#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include <cairo/cairo.h>

#include <glib.h>
#include <gdk/gdk.h>
#include <gdk-pixbuf/gdk-pixbuf.h>

#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h>

#define PROJECT_NAME "native"

#define for_range(loopvar, stop) for (gulong loopvar = 0; loopvar < (stop); ++loopvar)

#define def(name) static int name(lua_State* L)

#define assert(value, message) if (!(value)) { lua_pushstring((L), (message)); lua_error(L); }

gdouble clamp(gdouble number, gdouble floor, gdouble ceiling) {
	if (number < floor) {
		return floor;
	} else if (number > ceiling) {
		return ceiling;
	} else {
		return number;
	}
}

gint64 int_clamp(gint64 number, gint64 floor, gint64 ceiling) {
	if (number < floor) {
		return floor;
	} else if (number > ceiling) {
		return ceiling;
	} else {
		return number;
	}
}

static const gdouble pi = 3.1415926535897932384626433832795;
// Based on https://stackoverflow.com/a/8204867
static gdouble *generate_blur_kernel(guint radius, gint sigma) {
	gdouble *kernel = malloc(sizeof(gdouble) * (radius * radius));
	gdouble mean = radius / 2;
	gdouble sum = 0.0;

	for_range (x, radius) {
		for_range (y, radius) {
			gint index = x + (y * radius);

			kernel[index] = exp(
				-0.5 * (pow((x - mean) / sigma, 2.0) + pow((y - mean) / sigma, 2.0))
			) / (
				2 * pi * sigma * sigma
			);

			sum += kernel[index];
		}
	}

	for_range (x, radius) {
		for_range (y, radius) {
			kernel[x + (y * radius)] /= sum;
		}
	}

	return kernel;
}

static gdouble *generate_blur_kernel_linear(guint radius, gint sigma) {
	gdouble *kernel = g_malloc(sizeof(gdouble) * (radius));
	gdouble mean = radius / 2;
	gdouble sum = 0.0;

	for_range (x, radius) {
		kernel[x] = exp(
			-0.5 * (pow((x - mean) / sigma, 2.0) + pow(((radius/2) - mean) / sigma, 2.0))
		) / (
			2 * pi * sigma * sigma
		);

		sum += kernel[x];
	}

	for_range (x, radius) {
		kernel[x] /= sum;
	}

	return kernel;
}

typedef struct _RGBAPixel {
	guint8 red, green, blue, alpha;
} __attribute__((packed)) RGBAPixel;

RGBAPixel rgba_pixel_new(void) {
	RGBAPixel obj = {
		.red   = 0,
		.green = 0,
		.blue  = 0,
		.alpha = 0,
	};

	return obj;
}

typedef struct _ARGBPixel {
	guint8 alpha, red, green, blue;
} __attribute__((packed)) ARGBPixel;

ARGBPixel argb_pixel_new(void) {
	ARGBPixel obj = {
		.alpha = 0,
		.red   = 0,
		.green = 0,
		.blue  = 0,
	};

	return obj;
}

///////////////////////////////////////////////////////////////////////////////
// Stack blur. Generally faster than gausian.
// Yoinked from https://gitlab.gnome.org/Archive/lasem/-/blob/master/src/lsmsvgfiltersurface.c#L159

///////////////////////////////////////////////////////////////////////////////

/**
 * @param input_surface {"owner":"caller"}
 * @param output_surface {"owner":"caller"}
 * @param radius {"range":[0, 65535]}
*/
void cairo_image_surface_apply_blur(cairo_surface_t *input_surface, cairo_surface_t *output_surface, const gint radius) {
	// TODO: Use a gaussian kernel
	//gdouble *kernel = generate_blur_kernel_linear(radius*2, radius);

	gint width     = cairo_image_surface_get_width(input_surface);
	gint height    = cairo_image_surface_get_height(input_surface);
	gint rowstride = cairo_image_surface_get_stride(input_surface);

	cairo_surface_flush(output_surface);

	ARGBPixel *input_pixels  = cairo_image_surface_get_data(input_surface);
	ARGBPixel *output_pixels = cairo_image_surface_get_data(output_surface);

	/*
	g_print("cairo_image_surface_get_format(output_surface) = ");
	switch (cairo_image_surface_get_format(output_surface)) {
		case CAIRO_FORMAT_INVALID:   g_print("INVALID\n"); break;
		case CAIRO_FORMAT_ARGB32:    g_print("ARGB32\n"); break;
		case CAIRO_FORMAT_RGB24:     g_print("RGB24\n"); break;
		case CAIRO_FORMAT_A8:        g_print("A8\n"); break;
		case CAIRO_FORMAT_A1:        g_print("A1\n"); break;
		case CAIRO_FORMAT_RGB16_565: g_print("RGB16_565\n"); break;
		case CAIRO_FORMAT_RGB30:     g_print("RGB30\n"); break;
		case CAIRO_FORMAT_RGB96F:    g_print("RGB96F\n"); break;
		case CAIRO_FORMAT_RGBA128F:  g_print("RGBA128F\n"); break;
	}
	//*/

	// With gaussian blur, there's a trick you can use to make it faster: Instead of
	// applying a blurring square to each pixel (which scales O(N^2) (very bad)), do
	// two passes, one for the orizontal and one for the vertical (which scales O(N)).
	// The result will look the same.

	glong end = width * height;

	// Horizontal pass
	for (gulong i = 0; i < end; i++) {
		gulong sum_alpha = 0;
		gulong sum_red   = 0;
		gulong sum_green = 0;
		gulong sum_blue  = 0;

		for (gint offset = -radius; offset < radius; offset++) {
			guint true_index = int_clamp(i + offset, 0, end);
			sum_alpha += input_pixels[true_index].alpha; //* kernel[radius + offset];
			sum_red   += input_pixels[true_index].red;   //* kernel[radius + offset];
			sum_green += input_pixels[true_index].green; //* kernel[radius + offset];
			sum_blue  += input_pixels[true_index].blue;  //* kernel[radius + offset];
		}

		output_pixels[i].alpha = sum_alpha / (radius * 2);
		output_pixels[i].red   = sum_red   / (radius * 2);
		output_pixels[i].green = sum_green / (radius * 2);
		output_pixels[i].blue  = sum_blue  / (radius * 2);
	}

	// Vertical pass
	for (gulong i = 0; i < end; i++) {
		gulong sum_alpha = 0;
		gulong sum_red   = 0;
		gulong sum_green = 0;
		gulong sum_blue  = 0;
		guint current_column = i % width;

		for (gint offset = -radius; offset < radius; offset++) {
			// `end - (width + (i % width))` means the last pixel below the current one;
			// just using `end` would result in the edge pixels always blurring with the
			// very last pixel (i.e. the bottom right one).
			guint true_index = int_clamp(i + (offset * width), current_column, end - current_column);
			sum_alpha += output_pixels[true_index].alpha;
			sum_red   += output_pixels[true_index].red;
			sum_green += output_pixels[true_index].green;
			sum_blue  += output_pixels[true_index].blue;
		}

		output_pixels[i].alpha = sum_alpha / (radius * 2);
		output_pixels[i].red   = sum_red   / (radius * 2);
		output_pixels[i].green = sum_green / (radius * 2);
		output_pixels[i].blue  = sum_blue  / (radius * 2);
	}

	cairo_surface_mark_dirty(output_surface);

	//g_free(kernel);
}

def(export_cairo_image_surface_apply_blur) {
	cairo_surface_t *input_surface = (cairo_surface_t *)lua_touserdata(L, 1);
	gint radius = lua_tonumber(L, 2);

	assert(radius > 0, "You must provide a radius greater than 0!");

	cairo_surface_t *output_surface = cairo_image_surface_create(
		CAIRO_FORMAT_ARGB32,
		cairo_image_surface_get_width(input_surface),
		cairo_image_surface_get_height(input_surface)
	);

	cairo_image_surface_apply_blur(input_surface, output_surface, radius);

	lua_pushlightuserdata(L, output_surface);

	return 1;
}

///////////////////////////////////////////////////////////////////////////////

/**
 * @param input_surface {"owner":"caller"}
 * @param output_surface {"owner":"caller"}
 * @param radius {"range":[0, 65535]}
*/
void cairo_image_surface_apply_shadow(cairo_surface_t *input_surface, cairo_surface_t *output_surface, const gint radius) {
	gint width     = cairo_image_surface_get_width(input_surface);
	gint height    = cairo_image_surface_get_height(input_surface);
	gint rowstride = cairo_image_surface_get_stride(input_surface);

	cairo_surface_flush(output_surface);

	guchar *input_pixels  = cairo_image_surface_get_data(input_surface);
	guchar *output_pixels = cairo_image_surface_get_data(output_surface);

	glong end = rowstride * height;

	for (gulong i = 3; i < end; i += 4) {
		gulong sum_horizontal = 0;

		for (gint offset = -radius; offset < radius; offset++) {
			guint true_index = int_clamp(i + (offset * 4), 0, end);
			sum_horizontal += input_pixels[true_index];
		}

		output_pixels[i] = sum_horizontal / (radius * 2);
	}

	for (gulong i = 3; i < end; i += 4) {
		guint current_column = i % rowstride;
		gulong sum_vertical = 0;

		for (gint offset = -radius; offset < radius; offset++) {
			guint true_index = int_clamp(i + (offset * rowstride), current_column, (end - current_column));
			sum_vertical += output_pixels[true_index];
		}

		output_pixels[i] = sum_vertical / (radius * 2);
	}

	for (gulong i = 3; i < end; i += 4) {
		output_pixels[i - 3] = 0;
		output_pixels[i - 2] = 0;
		output_pixels[i - 1] = 0;
	}

	cairo_surface_mark_dirty(output_surface);
}

def(export_cairo_image_surface_apply_shadow) {
	cairo_surface_t *input_surface = (cairo_surface_t *)lua_touserdata(L, 1);
	gint radius = lua_tonumber(L, 2);

	assert(radius > 0, "You must provide a radius greater than 0!");

	cairo_surface_t *output_surface = cairo_image_surface_create(
		CAIRO_FORMAT_ARGB32,
		cairo_image_surface_get_width(input_surface),
		cairo_image_surface_get_height(input_surface)
	);

	cairo_image_surface_apply_shadow(input_surface, output_surface, radius);

	lua_pushlightuserdata(L, output_surface);

	return 1;
}

///////////////////////////////////////////////////////////////////////////////

static const struct luaL_Reg native[] = {
	{ "cairo_image_surface_apply_blur",   export_cairo_image_surface_apply_blur   },
	{ "cairo_image_surface_apply_shadow", export_cairo_image_surface_apply_shadow },
	{ NULL, NULL }
};

int luaopen_native_native(lua_State* L) {
	luaL_newlib(L, native);

	return 1;
}

