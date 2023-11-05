#ifndef HEADER_surface_filter
#define HEADER_surface_filter

#include <glib.h>

/**
 * @param input_surface {"owner":"caller"}
 * @param output_surface {"owner":"caller","notes":"Must be an image surface with the same width, height and rowstride as `input_surface`. Must not be the same objecet as `input_surface`"}
 * @param radius {"range":[0, 65535]}
*/
void cairo_image_surface_create_blurred(cairo_surface_t *restrict input_surface, cairo_surface_t *restrict output_surface, const guint radius);

/**
 * @param input_surface {"owner":"caller"}
 * @param output_surface {"owner":"caller","notes":"Must be an image surface with the same width, height and rowstride as `input_surface`. Must not be the same objecet as `input_surface`"}
 * @param radius {"range":[0, 65535]}
*/
void cairo_image_surface_create_shadow(cairo_surface_t *restrict input_surface, cairo_surface_t *restrict output_surface, const guint radius);

int luaopen_surface_filter_surface_filter(lua_State* L);

#endif
