typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;
typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;
typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;
typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;
typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;
typedef int __daddr_t;
typedef int __key_t;
typedef int __clockid_t;
typedef void * __timer_t;
typedef long int __blksize_t;
typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;
typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;
typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;
typedef long int __fsword_t;
typedef long int __ssize_t;
typedef long int __syscall_slong_t;
typedef unsigned long int __syscall_ulong_t;
typedef __off64_t __loff_t;
typedef char *__caddr_t;
typedef long int __intptr_t;
typedef unsigned int __socklen_t;
typedef int __sig_atomic_t;
typedef __ino_t ino_t;
typedef __dev_t dev_t;
typedef __gid_t gid_t;
typedef __mode_t mode_t;
typedef __nlink_t nlink_t;
typedef __uid_t uid_t;
typedef __off_t off_t;
typedef __pid_t pid_t;
typedef __ssize_t ssize_t;
typedef __clockid_t clockid_t;
typedef __time_t time_t;
typedef __timer_t timer_t;
typedef long unsigned int size_t;
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
typedef __uint8_t u_int8_t;
typedef __uint16_t u_int16_t;
typedef __uint32_t u_int32_t;
typedef __uint64_t u_int64_t;
typedef int register_t __attribute__ ((__mode__ (__word__)));
typedef __blkcnt_t blkcnt_t;
typedef __fsblkcnt_t fsblkcnt_t;
typedef __fsfilcnt_t fsfilcnt_t;
typedef unsigned long XID;
typedef unsigned long Mask;
typedef unsigned long Atom;
typedef unsigned long VisualID;
typedef unsigned long Time;
typedef XID Window;
typedef XID Drawable;
typedef XID Font;
typedef XID Pixmap;
typedef XID Cursor;
typedef XID Colormap;
typedef XID GContext;
typedef XID KeySym;
typedef unsigned char KeyCode;
typedef long int ptrdiff_t;
typedef int wchar_t;
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
} max_align_t;
extern int
_Xmblen(
    char *str,
    int len
    );
typedef char *XPointer;
typedef struct _XExtData {
 int number;
 struct _XExtData *next;
 int (*free_private)(
 struct _XExtData *extension
 );
 XPointer private_data;
} XExtData;
typedef struct {
 int extension;
 int major_opcode;
 int first_event;
 int first_error;
} XExtCodes;
typedef struct {
    int depth;
    int bits_per_pixel;
    int scanline_pad;
} XPixmapFormatValues;
typedef struct {
 int function;
 unsigned long plane_mask;
 unsigned long foreground;
 unsigned long background;
 int line_width;
 int line_style;
 int cap_style;
 int join_style;
 int fill_style;
 int fill_rule;
 int arc_mode;
 Pixmap tile;
 Pixmap stipple;
 int ts_x_origin;
 int ts_y_origin;
        Font font;
 int subwindow_mode;
 int graphics_exposures;
 int clip_x_origin;
 int clip_y_origin;
 Pixmap clip_mask;
 int dash_offset;
 char dashes;
} XGCValues;
typedef struct _XGC
*GC;
typedef struct {
 XExtData *ext_data;
 VisualID visualid;
 int class;
 unsigned long red_mask, green_mask, blue_mask;
 int bits_per_rgb;
 int map_entries;
} Visual;
typedef struct {
 int depth;
 int nvisuals;
 Visual *visuals;
} Depth;
struct _XDisplay;
typedef struct {
 XExtData *ext_data;
 struct _XDisplay *display;
 Window root;
 int width, height;
 int mwidth, mheight;
 int ndepths;
 Depth *depths;
 int root_depth;
 Visual *root_visual;
 GC default_gc;
 Colormap cmap;
 unsigned long white_pixel;
 unsigned long black_pixel;
 int max_maps, min_maps;
 int backing_store;
 int save_unders;
 long root_input_mask;
} Screen;
typedef struct {
 XExtData *ext_data;
 int depth;
 int bits_per_pixel;
 int scanline_pad;
} ScreenFormat;
typedef struct {
    Pixmap background_pixmap;
    unsigned long background_pixel;
    Pixmap border_pixmap;
    unsigned long border_pixel;
    int bit_gravity;
    int win_gravity;
    int backing_store;
    unsigned long backing_planes;
    unsigned long backing_pixel;
    int save_under;
    long event_mask;
    long do_not_propagate_mask;
    int override_redirect;
    Colormap colormap;
    Cursor cursor;
} XSetWindowAttributes;
typedef struct {
    int x, y;
    int width, height;
    int border_width;
    int depth;
    Visual *visual;
    Window root;
    int class;
    int bit_gravity;
    int win_gravity;
    int backing_store;
    unsigned long backing_planes;
    unsigned long backing_pixel;
    int save_under;
    Colormap colormap;
    int map_installed;
    int map_state;
    long all_event_masks;
    long your_event_mask;
    long do_not_propagate_mask;
    int override_redirect;
    Screen *screen;
} XWindowAttributes;
typedef struct {
 int family;
 int length;
 char *address;
} XHostAddress;
typedef struct {
 int typelength;
 int valuelength;
 char *type;
 char *value;
} XServerInterpretedAddress;
typedef struct _XImage {
    int width, height;
    int xoffset;
    int format;
    char *data;
    int byte_order;
    int bitmap_unit;
    int bitmap_bit_order;
    int bitmap_pad;
    int depth;
    int bytes_per_line;
    int bits_per_pixel;
    unsigned long red_mask;
    unsigned long green_mask;
    unsigned long blue_mask;
    XPointer obdata;
    struct funcs {
 struct _XImage *(*create_image)(
  struct _XDisplay* ,
  Visual* ,
  unsigned int ,
  int ,
  int ,
  char* ,
  unsigned int ,
  unsigned int ,
  int ,
  int );
 int (*destroy_image) (struct _XImage *);
 unsigned long (*get_pixel) (struct _XImage *, int, int);
 int (*put_pixel) (struct _XImage *, int, int, unsigned long);
 struct _XImage *(*sub_image)(struct _XImage *, int, int, unsigned int, unsigned int);
 int (*add_pixel) (struct _XImage *, long);
 } f;
} XImage;
typedef struct {
    int x, y;
    int width, height;
    int border_width;
    Window sibling;
    int stack_mode;
} XWindowChanges;
typedef struct {
 unsigned long pixel;
 unsigned short red, green, blue;
 char flags;
 char pad;
} XColor;
typedef struct {
    short x1, y1, x2, y2;
} XSegment;
typedef struct {
    short x, y;
} XPoint;
typedef struct {
    short x, y;
    unsigned short width, height;
} XRectangle;
typedef struct {
    short x, y;
    unsigned short width, height;
    short angle1, angle2;
} XArc;
typedef struct {
        int key_click_percent;
        int bell_percent;
        int bell_pitch;
        int bell_duration;
        int led;
        int led_mode;
        int key;
        int auto_repeat_mode;
} XKeyboardControl;
typedef struct {
        int key_click_percent;
 int bell_percent;
 unsigned int bell_pitch, bell_duration;
 unsigned long led_mask;
 int global_auto_repeat;
 char auto_repeats[32];
} XKeyboardState;
typedef struct {
        Time time;
 short x, y;
} XTimeCoord;
typedef struct {
  int max_keypermod;
  KeyCode *modifiermap;
} XModifierKeymap;
typedef struct _XDisplay Display;
struct _XPrivate;
struct _XrmHashBucketRec;
typedef struct
{
 XExtData *ext_data;
 struct _XPrivate *private1;
 int fd;
 int private2;
 int proto_major_version;
 int proto_minor_version;
 char *vendor;
        XID private3;
 XID private4;
 XID private5;
 int private6;
 XID (*resource_alloc)(
  struct _XDisplay*
 );
 int byte_order;
 int bitmap_unit;
 int bitmap_pad;
 int bitmap_bit_order;
 int nformats;
 ScreenFormat *pixmap_format;
 int private8;
 int release;
 struct _XPrivate *private9, *private10;
 int qlen;
 unsigned long last_request_read;
 unsigned long request;
 XPointer private11;
 XPointer private12;
 XPointer private13;
 XPointer private14;
 unsigned max_request_size;
 struct _XrmHashBucketRec *db;
 int (*private15)(
  struct _XDisplay*
  );
 char *display_name;
 int default_screen;
 int nscreens;
 Screen *screens;
 unsigned long motion_buffer;
 unsigned long private16;
 int min_keycode;
 int max_keycode;
 XPointer private17;
 XPointer private18;
 int private19;
 char *xdefaults;
}
*_XPrivDisplay;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Window root;
 Window subwindow;
 Time time;
 int x, y;
 int x_root, y_root;
 unsigned int state;
 unsigned int keycode;
 int same_screen;
} XKeyEvent;
typedef XKeyEvent XKeyPressedEvent;
typedef XKeyEvent XKeyReleasedEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Window root;
 Window subwindow;
 Time time;
 int x, y;
 int x_root, y_root;
 unsigned int state;
 unsigned int button;
 int same_screen;
} XButtonEvent;
typedef XButtonEvent XButtonPressedEvent;
typedef XButtonEvent XButtonReleasedEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Window root;
 Window subwindow;
 Time time;
 int x, y;
 int x_root, y_root;
 unsigned int state;
 char is_hint;
 int same_screen;
} XMotionEvent;
typedef XMotionEvent XPointerMovedEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Window root;
 Window subwindow;
 Time time;
 int x, y;
 int x_root, y_root;
 int mode;
 int detail;
 int same_screen;
 int focus;
 unsigned int state;
} XCrossingEvent;
typedef XCrossingEvent XEnterWindowEvent;
typedef XCrossingEvent XLeaveWindowEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 int mode;
 int detail;
} XFocusChangeEvent;
typedef XFocusChangeEvent XFocusInEvent;
typedef XFocusChangeEvent XFocusOutEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 char key_vector[32];
} XKeymapEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 int x, y;
 int width, height;
 int count;
} XExposeEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Drawable drawable;
 int x, y;
 int width, height;
 int count;
 int major_code;
 int minor_code;
} XGraphicsExposeEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Drawable drawable;
 int major_code;
 int minor_code;
} XNoExposeEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 int state;
} XVisibilityEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window parent;
 Window window;
 int x, y;
 int width, height;
 int border_width;
 int override_redirect;
} XCreateWindowEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
} XDestroyWindowEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
 int from_configure;
} XUnmapEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
 int override_redirect;
} XMapEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window parent;
 Window window;
} XMapRequestEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
 Window parent;
 int x, y;
 int override_redirect;
} XReparentEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
 int x, y;
 int width, height;
 int border_width;
 Window above;
 int override_redirect;
} XConfigureEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
 int x, y;
} XGravityEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 int width, height;
} XResizeRequestEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window parent;
 Window window;
 int x, y;
 int width, height;
 int border_width;
 Window above;
 int detail;
 unsigned long value_mask;
} XConfigureRequestEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window event;
 Window window;
 int place;
} XCirculateEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window parent;
 Window window;
 int place;
} XCirculateRequestEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Atom atom;
 Time time;
 int state;
} XPropertyEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Atom selection;
 Time time;
} XSelectionClearEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window owner;
 Window requestor;
 Atom selection;
 Atom target;
 Atom property;
 Time time;
} XSelectionRequestEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window requestor;
 Atom selection;
 Atom target;
 Atom property;
 Time time;
} XSelectionEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Colormap colormap;
 int new;
 int state;
} XColormapEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 Atom message_type;
 int format;
 union {
  char b[20];
  short s[10];
  long l[5];
  } data;
} XClientMessageEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
 int request;
 int first_keycode;
 int count;
} XMappingEvent;
typedef struct {
 int type;
 Display *display;
 XID resourceid;
 unsigned long serial;
 unsigned char error_code;
 unsigned char request_code;
 unsigned char minor_code;
} XErrorEvent;
typedef struct {
 int type;
 unsigned long serial;
 int send_event;
 Display *display;
 Window window;
} XAnyEvent;
typedef struct
    {
    int type;
    unsigned long serial;
    int send_event;
    Display *display;
    int extension;
    int evtype;
    } XGenericEvent;
typedef struct {
    int type;
    unsigned long serial;
    int send_event;
    Display *display;
    int extension;
    int evtype;
    unsigned int cookie;
    void *data;
} XGenericEventCookie;
typedef union _XEvent {
        int type;
 XAnyEvent xany;
 XKeyEvent xkey;
 XButtonEvent xbutton;
 XMotionEvent xmotion;
 XCrossingEvent xcrossing;
 XFocusChangeEvent xfocus;
 XExposeEvent xexpose;
 XGraphicsExposeEvent xgraphicsexpose;
 XNoExposeEvent xnoexpose;
 XVisibilityEvent xvisibility;
 XCreateWindowEvent xcreatewindow;
 XDestroyWindowEvent xdestroywindow;
 XUnmapEvent xunmap;
 XMapEvent xmap;
 XMapRequestEvent xmaprequest;
 XReparentEvent xreparent;
 XConfigureEvent xconfigure;
 XGravityEvent xgravity;
 XResizeRequestEvent xresizerequest;
 XConfigureRequestEvent xconfigurerequest;
 XCirculateEvent xcirculate;
 XCirculateRequestEvent xcirculaterequest;
 XPropertyEvent xproperty;
 XSelectionClearEvent xselectionclear;
 XSelectionRequestEvent xselectionrequest;
 XSelectionEvent xselection;
 XColormapEvent xcolormap;
 XClientMessageEvent xclient;
 XMappingEvent xmapping;
 XErrorEvent xerror;
 XKeymapEvent xkeymap;
 XGenericEvent xgeneric;
 XGenericEventCookie xcookie;
 long pad[24];
} XEvent;
typedef struct {
    short lbearing;
    short rbearing;
    short width;
    short ascent;
    short descent;
    unsigned short attributes;
} XCharStruct;
typedef struct {
    Atom name;
    unsigned long card32;
} XFontProp;
typedef struct {
    XExtData *ext_data;
    Font fid;
    unsigned direction;
    unsigned min_char_or_byte2;
    unsigned max_char_or_byte2;
    unsigned min_byte1;
    unsigned max_byte1;
    int all_chars_exist;
    unsigned default_char;
    int n_properties;
    XFontProp *properties;
    XCharStruct min_bounds;
    XCharStruct max_bounds;
    XCharStruct *per_char;
    int ascent;
    int descent;
} XFontStruct;
typedef struct {
    char *chars;
    int nchars;
    int delta;
    Font font;
} XTextItem;
typedef struct {
    unsigned char byte1;
    unsigned char byte2;
} XChar2b;
typedef struct {
    XChar2b *chars;
    int nchars;
    int delta;
    Font font;
} XTextItem16;
typedef union { Display *display;
  GC gc;
  Visual *visual;
  Screen *screen;
  ScreenFormat *pixmap_format;
  XFontStruct *font; } XEDataObject;
typedef struct {
    XRectangle max_ink_extent;
    XRectangle max_logical_extent;
} XFontSetExtents;
typedef struct _XOM *XOM;
typedef struct _XOC *XOC, *XFontSet;
typedef struct {
    char *chars;
    int nchars;
    int delta;
    XFontSet font_set;
} XmbTextItem;
typedef struct {
    wchar_t *chars;
    int nchars;
    int delta;
    XFontSet font_set;
} XwcTextItem;
typedef struct {
    int charset_count;
    char **charset_list;
} XOMCharSetList;
typedef enum {
    XOMOrientation_LTR_TTB,
    XOMOrientation_RTL_TTB,
    XOMOrientation_TTB_LTR,
    XOMOrientation_TTB_RTL,
    XOMOrientation_Context
} XOrientation;
typedef struct {
    int num_orientation;
    XOrientation *orientation;
} XOMOrientation;
typedef struct {
    int num_font;
    XFontStruct **font_struct_list;
    char **font_name_list;
} XOMFontInfo;
typedef struct _XIM *XIM;
typedef struct _XIC *XIC;
typedef void (*XIMProc)(
    XIM,
    XPointer,
    XPointer
);
typedef int (*XICProc)(
    XIC,
    XPointer,
    XPointer
);
typedef void (*XIDProc)(
    Display*,
    XPointer,
    XPointer
);
typedef unsigned long XIMStyle;
typedef struct {
    unsigned short count_styles;
    XIMStyle *supported_styles;
} XIMStyles;
typedef void *XVaNestedList;
typedef struct {
    XPointer client_data;
    XIMProc callback;
} XIMCallback;
typedef struct {
    XPointer client_data;
    XICProc callback;
} XICCallback;
typedef unsigned long XIMFeedback;
typedef struct _XIMText {
    unsigned short length;
    XIMFeedback *feedback;
    int encoding_is_wchar;
    union {
 char *multi_byte;
 wchar_t *wide_char;
    } string;
} XIMText;
typedef unsigned long XIMPreeditState;
typedef struct _XIMPreeditStateNotifyCallbackStruct {
    XIMPreeditState state;
} XIMPreeditStateNotifyCallbackStruct;
typedef unsigned long XIMResetState;
typedef unsigned long XIMStringConversionFeedback;
typedef struct _XIMStringConversionText {
    unsigned short length;
    XIMStringConversionFeedback *feedback;
    int encoding_is_wchar;
    union {
 char *mbs;
 wchar_t *wcs;
    } string;
} XIMStringConversionText;
typedef unsigned short XIMStringConversionPosition;
typedef unsigned short XIMStringConversionType;
typedef unsigned short XIMStringConversionOperation;
typedef enum {
    XIMForwardChar, XIMBackwardChar,
    XIMForwardWord, XIMBackwardWord,
    XIMCaretUp, XIMCaretDown,
    XIMNextLine, XIMPreviousLine,
    XIMLineStart, XIMLineEnd,
    XIMAbsolutePosition,
    XIMDontChange
} XIMCaretDirection;
typedef struct _XIMStringConversionCallbackStruct {
    XIMStringConversionPosition position;
    XIMCaretDirection direction;
    XIMStringConversionOperation operation;
    unsigned short factor;
    XIMStringConversionText *text;
} XIMStringConversionCallbackStruct;
typedef struct _XIMPreeditDrawCallbackStruct {
    int caret;
    int chg_first;
    int chg_length;
    XIMText *text;
} XIMPreeditDrawCallbackStruct;
typedef enum {
    XIMIsInvisible,
    XIMIsPrimary,
    XIMIsSecondary
} XIMCaretStyle;
typedef struct _XIMPreeditCaretCallbackStruct {
    int position;
    XIMCaretDirection direction;
    XIMCaretStyle style;
} XIMPreeditCaretCallbackStruct;
typedef enum {
    XIMTextType,
    XIMBitmapType
} XIMStatusDataType;
typedef struct _XIMStatusDrawCallbackStruct {
    XIMStatusDataType type;
    union {
 XIMText *text;
 Pixmap bitmap;
    } data;
} XIMStatusDrawCallbackStruct;
typedef struct _XIMHotKeyTrigger {
    KeySym keysym;
    int modifier;
    int modifier_mask;
} XIMHotKeyTrigger;
typedef struct _XIMHotKeyTriggers {
    int num_hot_key;
    XIMHotKeyTrigger *key;
} XIMHotKeyTriggers;
typedef unsigned long XIMHotKeyState;
typedef struct {
    unsigned short count_values;
    char **supported_values;
} XIMValuesList;
extern int _Xdebug;
extern XFontStruct *XLoadQueryFont(
    Display* ,
    const char*
);
extern XFontStruct *XQueryFont(
    Display* ,
    XID
);
extern XTimeCoord *XGetMotionEvents(
    Display* ,
    Window ,
    Time ,
    Time ,
    int*
);
extern XModifierKeymap *XDeleteModifiermapEntry(
    XModifierKeymap* ,
    KeyCode ,
    int
);
extern XModifierKeymap *XGetModifierMapping(
    Display*
);
extern XModifierKeymap *XInsertModifiermapEntry(
    XModifierKeymap* ,
    KeyCode ,
    int
);
extern XModifierKeymap *XNewModifiermap(
    int
);
extern XImage *XCreateImage(
    Display* ,
    Visual* ,
    unsigned int ,
    int ,
    int ,
    char* ,
    unsigned int ,
    unsigned int ,
    int ,
    int
);
extern int XInitImage(
    XImage*
);
extern XImage *XGetImage(
    Display* ,
    Drawable ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    unsigned long ,
    int
);
extern XImage *XGetSubImage(
    Display* ,
    Drawable ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    unsigned long ,
    int ,
    XImage* ,
    int ,
    int
);
extern Display *XOpenDisplay(
    const char*
);
extern void XrmInitialize(
    void
);
extern char *XFetchBytes(
    Display* ,
    int*
);
extern char *XFetchBuffer(
    Display* ,
    int* ,
    int
);
extern char *XGetAtomName(
    Display* ,
    Atom
);
extern int XGetAtomNames(
    Display* ,
    Atom* ,
    int ,
    char**
);
extern char *XGetDefault(
    Display* ,
    const char* ,
    const char*
);
extern char *XDisplayName(
    const char*
);
extern char *XKeysymToString(
    KeySym
);
extern int (*XSynchronize(
    Display* ,
    int
))(
    Display*
);
extern int (*XSetAfterFunction(
    Display* ,
    int (*) (
      Display*
            )
))(
    Display*
);
extern Atom XInternAtom(
    Display* ,
    const char* ,
    int
);
extern int XInternAtoms(
    Display* ,
    char** ,
    int ,
    int ,
    Atom*
);
extern Colormap XCopyColormapAndFree(
    Display* ,
    Colormap
);
extern Colormap XCreateColormap(
    Display* ,
    Window ,
    Visual* ,
    int
);
extern Cursor XCreatePixmapCursor(
    Display* ,
    Pixmap ,
    Pixmap ,
    XColor* ,
    XColor* ,
    unsigned int ,
    unsigned int
);
extern Cursor XCreateGlyphCursor(
    Display* ,
    Font ,
    Font ,
    unsigned int ,
    unsigned int ,
    XColor const * ,
    XColor const *
);
extern Cursor XCreateFontCursor(
    Display* ,
    unsigned int
);
extern Font XLoadFont(
    Display* ,
    const char*
);
extern GC XCreateGC(
    Display* ,
    Drawable ,
    unsigned long ,
    XGCValues*
);
extern GContext XGContextFromGC(
    GC
);
extern void XFlushGC(
    Display* ,
    GC
);
extern Pixmap XCreatePixmap(
    Display* ,
    Drawable ,
    unsigned int ,
    unsigned int ,
    unsigned int
);
extern Pixmap XCreateBitmapFromData(
    Display* ,
    Drawable ,
    const char* ,
    unsigned int ,
    unsigned int
);
extern Pixmap XCreatePixmapFromBitmapData(
    Display* ,
    Drawable ,
    char* ,
    unsigned int ,
    unsigned int ,
    unsigned long ,
    unsigned long ,
    unsigned int
);
extern Window XCreateSimpleWindow(
    Display* ,
    Window ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    unsigned int ,
    unsigned long ,
    unsigned long
);
extern Window XGetSelectionOwner(
    Display* ,
    Atom
);
extern Window XCreateWindow(
    Display* ,
    Window ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    unsigned int ,
    int ,
    unsigned int ,
    Visual* ,
    unsigned long ,
    XSetWindowAttributes*
);
extern Colormap *XListInstalledColormaps(
    Display* ,
    Window ,
    int*
);
extern char **XListFonts(
    Display* ,
    const char* ,
    int ,
    int*
);
extern char **XListFontsWithInfo(
    Display* ,
    const char* ,
    int ,
    int* ,
    XFontStruct**
);
extern char **XGetFontPath(
    Display* ,
    int*
);
extern char **XListExtensions(
    Display* ,
    int*
);
extern Atom *XListProperties(
    Display* ,
    Window ,
    int*
);
extern XHostAddress *XListHosts(
    Display* ,
    int* ,
    int*
);
__attribute__((deprecated))
extern KeySym XKeycodeToKeysym(
    Display* ,
    KeyCode ,
    int
);
extern KeySym XLookupKeysym(
    XKeyEvent* ,
    int
);
extern KeySym *XGetKeyboardMapping(
    Display* ,
    KeyCode ,
    int ,
    int*
);
extern KeySym XStringToKeysym(
    const char*
);
extern long XMaxRequestSize(
    Display*
);
extern long XExtendedMaxRequestSize(
    Display*
);
extern char *XResourceManagerString(
    Display*
);
extern char *XScreenResourceString(
 Screen*
);
extern unsigned long XDisplayMotionBufferSize(
    Display*
);
extern VisualID XVisualIDFromVisual(
    Visual*
);
extern int XInitThreads(
    void
);
extern int XFreeThreads(
    void
);
extern void XLockDisplay(
    Display*
);
extern void XUnlockDisplay(
    Display*
);
extern XExtCodes *XInitExtension(
    Display* ,
    const char*
);
extern XExtCodes *XAddExtension(
    Display*
);
extern XExtData *XFindOnExtensionList(
    XExtData** ,
    int
);
extern XExtData **XEHeadOfExtensionList(
    XEDataObject
);
extern Window XRootWindow(
    Display* ,
    int
);
extern Window XDefaultRootWindow(
    Display*
);
extern Window XRootWindowOfScreen(
    Screen*
);
extern Visual *XDefaultVisual(
    Display* ,
    int
);
extern Visual *XDefaultVisualOfScreen(
    Screen*
);
extern GC XDefaultGC(
    Display* ,
    int
);
extern GC XDefaultGCOfScreen(
    Screen*
);
extern unsigned long XBlackPixel(
    Display* ,
    int
);
extern unsigned long XWhitePixel(
    Display* ,
    int
);
extern unsigned long XAllPlanes(
    void
);
extern unsigned long XBlackPixelOfScreen(
    Screen*
);
extern unsigned long XWhitePixelOfScreen(
    Screen*
);
extern unsigned long XNextRequest(
    Display*
);
extern unsigned long XLastKnownRequestProcessed(
    Display*
);
extern char *XServerVendor(
    Display*
);
extern char *XDisplayString(
    Display*
);
extern Colormap XDefaultColormap(
    Display* ,
    int
);
extern Colormap XDefaultColormapOfScreen(
    Screen*
);
extern Display *XDisplayOfScreen(
    Screen*
);
extern Screen *XScreenOfDisplay(
    Display* ,
    int
);
extern Screen *XDefaultScreenOfDisplay(
    Display*
);
extern long XEventMaskOfScreen(
    Screen*
);
extern int XScreenNumberOfScreen(
    Screen*
);
typedef int (*XErrorHandler) (
    Display* ,
    XErrorEvent*
);
extern XErrorHandler XSetErrorHandler (
    XErrorHandler
);
typedef int (*XIOErrorHandler) (
    Display*
);
extern XIOErrorHandler XSetIOErrorHandler (
    XIOErrorHandler
);
typedef void (*XIOErrorExitHandler) (
    Display*,
    void*
);
extern void XSetIOErrorExitHandler (
    Display*,
    XIOErrorExitHandler,
    void*
);
extern XPixmapFormatValues *XListPixmapFormats(
    Display* ,
    int*
);
extern int *XListDepths(
    Display* ,
    int ,
    int*
);
extern int XReconfigureWMWindow(
    Display* ,
    Window ,
    int ,
    unsigned int ,
    XWindowChanges*
);
extern int XGetWMProtocols(
    Display* ,
    Window ,
    Atom** ,
    int*
);
extern int XSetWMProtocols(
    Display* ,
    Window ,
    Atom* ,
    int
);
extern int XIconifyWindow(
    Display* ,
    Window ,
    int
);
extern int XWithdrawWindow(
    Display* ,
    Window ,
    int
);
extern int XGetCommand(
    Display* ,
    Window ,
    char*** ,
    int*
);
extern int XGetWMColormapWindows(
    Display* ,
    Window ,
    Window** ,
    int*
);
extern int XSetWMColormapWindows(
    Display* ,
    Window ,
    Window* ,
    int
);
extern void XFreeStringList(
    char**
);
extern int XSetTransientForHint(
    Display* ,
    Window ,
    Window
);
extern int XActivateScreenSaver(
    Display*
);
extern int XAddHost(
    Display* ,
    XHostAddress*
);
extern int XAddHosts(
    Display* ,
    XHostAddress* ,
    int
);
extern int XAddToExtensionList(
    struct _XExtData** ,
    XExtData*
);
extern int XAddToSaveSet(
    Display* ,
    Window
);
extern int XAllocColor(
    Display* ,
    Colormap ,
    XColor*
);
extern int XAllocColorCells(
    Display* ,
    Colormap ,
    int ,
    unsigned long* ,
    unsigned int ,
    unsigned long* ,
    unsigned int
);
extern int XAllocColorPlanes(
    Display* ,
    Colormap ,
    int ,
    unsigned long* ,
    int ,
    int ,
    int ,
    int ,
    unsigned long* ,
    unsigned long* ,
    unsigned long*
);
extern int XAllocNamedColor(
    Display* ,
    Colormap ,
    const char* ,
    XColor* ,
    XColor*
);
extern int XAllowEvents(
    Display* ,
    int ,
    Time
);
extern int XAutoRepeatOff(
    Display*
);
extern int XAutoRepeatOn(
    Display*
);
extern int XBell(
    Display* ,
    int
);
extern int XBitmapBitOrder(
    Display*
);
extern int XBitmapPad(
    Display*
);
extern int XBitmapUnit(
    Display*
);
extern int XCellsOfScreen(
    Screen*
);
extern int XChangeActivePointerGrab(
    Display* ,
    unsigned int ,
    Cursor ,
    Time
);
extern int XChangeGC(
    Display* ,
    GC ,
    unsigned long ,
    XGCValues*
);
extern int XChangeKeyboardControl(
    Display* ,
    unsigned long ,
    XKeyboardControl*
);
extern int XChangeKeyboardMapping(
    Display* ,
    int ,
    int ,
    KeySym* ,
    int
);
extern int XChangePointerControl(
    Display* ,
    int ,
    int ,
    int ,
    int ,
    int
);
extern int XChangeProperty(
    Display* ,
    Window ,
    Atom ,
    Atom ,
    int ,
    int ,
    const unsigned char* ,
    int
);
extern int XChangeSaveSet(
    Display* ,
    Window ,
    int
);
extern int XChangeWindowAttributes(
    Display* ,
    Window ,
    unsigned long ,
    XSetWindowAttributes*
);
extern int XCheckIfEvent(
    Display* ,
    XEvent* ,
    int (*) (
        Display* ,
               XEvent* ,
               XPointer
             ) ,
    XPointer
);
extern int XCheckMaskEvent(
    Display* ,
    long ,
    XEvent*
);
extern int XCheckTypedEvent(
    Display* ,
    int ,
    XEvent*
);
extern int XCheckTypedWindowEvent(
    Display* ,
    Window ,
    int ,
    XEvent*
);
extern int XCheckWindowEvent(
    Display* ,
    Window ,
    long ,
    XEvent*
);
extern int XCirculateSubwindows(
    Display* ,
    Window ,
    int
);
extern int XCirculateSubwindowsDown(
    Display* ,
    Window
);
extern int XCirculateSubwindowsUp(
    Display* ,
    Window
);
extern int XClearArea(
    Display* ,
    Window ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    int
);
extern int XClearWindow(
    Display* ,
    Window
);
extern int XCloseDisplay(
    Display*
);
extern int XConfigureWindow(
    Display* ,
    Window ,
    unsigned int ,
    XWindowChanges*
);
extern int XConnectionNumber(
    Display*
);
extern int XConvertSelection(
    Display* ,
    Atom ,
    Atom ,
    Atom ,
    Window ,
    Time
);
extern int XCopyArea(
    Display* ,
    Drawable ,
    Drawable ,
    GC ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    int ,
    int
);
extern int XCopyGC(
    Display* ,
    GC ,
    unsigned long ,
    GC
);
extern int XCopyPlane(
    Display* ,
    Drawable ,
    Drawable ,
    GC ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    int ,
    int ,
    unsigned long
);
extern int XDefaultDepth(
    Display* ,
    int
);
extern int XDefaultDepthOfScreen(
    Screen*
);
extern int XDefaultScreen(
    Display*
);
extern int XDefineCursor(
    Display* ,
    Window ,
    Cursor
);
extern int XDeleteProperty(
    Display* ,
    Window ,
    Atom
);
extern int XDestroyWindow(
    Display* ,
    Window
);
extern int XDestroySubwindows(
    Display* ,
    Window
);
extern int XDoesBackingStore(
    Screen*
);
extern int XDoesSaveUnders(
    Screen*
);
extern int XDisableAccessControl(
    Display*
);
extern int XDisplayCells(
    Display* ,
    int
);
extern int XDisplayHeight(
    Display* ,
    int
);
extern int XDisplayHeightMM(
    Display* ,
    int
);
extern int XDisplayKeycodes(
    Display* ,
    int* ,
    int*
);
extern int XDisplayPlanes(
    Display* ,
    int
);
extern int XDisplayWidth(
    Display* ,
    int
);
extern int XDisplayWidthMM(
    Display* ,
    int
);
extern int XDrawArc(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    int ,
    int
);
extern int XDrawArcs(
    Display* ,
    Drawable ,
    GC ,
    XArc* ,
    int
);
extern int XDrawImageString(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    const char* ,
    int
);
extern int XDrawImageString16(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    const XChar2b* ,
    int
);
extern int XDrawLine(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    int ,
    int
);
extern int XDrawLines(
    Display* ,
    Drawable ,
    GC ,
    XPoint* ,
    int ,
    int
);
extern int XDrawPoint(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int
);
extern int XDrawPoints(
    Display* ,
    Drawable ,
    GC ,
    XPoint* ,
    int ,
    int
);
extern int XDrawRectangle(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    unsigned int ,
    unsigned int
);
extern int XDrawRectangles(
    Display* ,
    Drawable ,
    GC ,
    XRectangle* ,
    int
);
extern int XDrawSegments(
    Display* ,
    Drawable ,
    GC ,
    XSegment* ,
    int
);
extern int XDrawString(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    const char* ,
    int
);
extern int XDrawString16(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    const XChar2b* ,
    int
);
extern int XDrawText(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    XTextItem* ,
    int
);
extern int XDrawText16(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    XTextItem16* ,
    int
);
extern int XEnableAccessControl(
    Display*
);
extern int XEventsQueued(
    Display* ,
    int
);
extern int XFetchName(
    Display* ,
    Window ,
    char**
);
extern int XFillArc(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    int ,
    int
);
extern int XFillArcs(
    Display* ,
    Drawable ,
    GC ,
    XArc* ,
    int
);
extern int XFillPolygon(
    Display* ,
    Drawable ,
    GC ,
    XPoint* ,
    int ,
    int ,
    int
);
extern int XFillRectangle(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    unsigned int ,
    unsigned int
);
extern int XFillRectangles(
    Display* ,
    Drawable ,
    GC ,
    XRectangle* ,
    int
);
extern int XFlush(
    Display*
);
extern int XForceScreenSaver(
    Display* ,
    int
);
extern int XFree(
    void*
);
extern int XFreeColormap(
    Display* ,
    Colormap
);
extern int XFreeColors(
    Display* ,
    Colormap ,
    unsigned long* ,
    int ,
    unsigned long
);
extern int XFreeCursor(
    Display* ,
    Cursor
);
extern int XFreeExtensionList(
    char**
);
extern int XFreeFont(
    Display* ,
    XFontStruct*
);
extern int XFreeFontInfo(
    char** ,
    XFontStruct* ,
    int
);
extern int XFreeFontNames(
    char**
);
extern int XFreeFontPath(
    char**
);
extern int XFreeGC(
    Display* ,
    GC
);
extern int XFreeModifiermap(
    XModifierKeymap*
);
extern int XFreePixmap(
    Display* ,
    Pixmap
);
extern int XGeometry(
    Display* ,
    int ,
    const char* ,
    const char* ,
    unsigned int ,
    unsigned int ,
    unsigned int ,
    int ,
    int ,
    int* ,
    int* ,
    int* ,
    int*
);
extern int XGetErrorDatabaseText(
    Display* ,
    const char* ,
    const char* ,
    const char* ,
    char* ,
    int
);
extern int XGetErrorText(
    Display* ,
    int ,
    char* ,
    int
);
extern int XGetFontProperty(
    XFontStruct* ,
    Atom ,
    unsigned long*
);
extern int XGetGCValues(
    Display* ,
    GC ,
    unsigned long ,
    XGCValues*
);
extern int XGetGeometry(
    Display* ,
    Drawable ,
    Window* ,
    int* ,
    int* ,
    unsigned int* ,
    unsigned int* ,
    unsigned int* ,
    unsigned int*
);
extern int XGetIconName(
    Display* ,
    Window ,
    char**
);
extern int XGetInputFocus(
    Display* ,
    Window* ,
    int*
);
extern int XGetKeyboardControl(
    Display* ,
    XKeyboardState*
);
extern int XGetPointerControl(
    Display* ,
    int* ,
    int* ,
    int*
);
extern int XGetPointerMapping(
    Display* ,
    unsigned char* ,
    int
);
extern int XGetScreenSaver(
    Display* ,
    int* ,
    int* ,
    int* ,
    int*
);
extern int XGetTransientForHint(
    Display* ,
    Window ,
    Window*
);
extern int XGetWindowProperty(
    Display* ,
    Window ,
    Atom ,
    long ,
    long ,
    int ,
    Atom ,
    Atom* ,
    int* ,
    unsigned long* ,
    unsigned long* ,
    unsigned char**
);
extern int XGetWindowAttributes(
    Display* ,
    Window ,
    XWindowAttributes*
);
extern int XGrabButton(
    Display* ,
    unsigned int ,
    unsigned int ,
    Window ,
    int ,
    unsigned int ,
    int ,
    int ,
    Window ,
    Cursor
);
extern int XGrabKey(
    Display* ,
    int ,
    unsigned int ,
    Window ,
    int ,
    int ,
    int
);
extern int XGrabKeyboard(
    Display* ,
    Window ,
    int ,
    int ,
    int ,
    Time
);
extern int XGrabPointer(
    Display* ,
    Window ,
    int ,
    unsigned int ,
    int ,
    int ,
    Window ,
    Cursor ,
    Time
);
extern int XGrabServer(
    Display*
);
extern int XHeightMMOfScreen(
    Screen*
);
extern int XHeightOfScreen(
    Screen*
);
extern int XIfEvent(
    Display* ,
    XEvent* ,
    int (*) (
        Display* ,
               XEvent* ,
               XPointer
             ) ,
    XPointer
);
extern int XImageByteOrder(
    Display*
);
extern int XInstallColormap(
    Display* ,
    Colormap
);
extern KeyCode XKeysymToKeycode(
    Display* ,
    KeySym
);
extern int XKillClient(
    Display* ,
    XID
);
extern int XLookupColor(
    Display* ,
    Colormap ,
    const char* ,
    XColor* ,
    XColor*
);
extern int XLowerWindow(
    Display* ,
    Window
);
extern int XMapRaised(
    Display* ,
    Window
);
extern int XMapSubwindows(
    Display* ,
    Window
);
extern int XMapWindow(
    Display* ,
    Window
);
extern int XMaskEvent(
    Display* ,
    long ,
    XEvent*
);
extern int XMaxCmapsOfScreen(
    Screen*
);
extern int XMinCmapsOfScreen(
    Screen*
);
extern int XMoveResizeWindow(
    Display* ,
    Window ,
    int ,
    int ,
    unsigned int ,
    unsigned int
);
extern int XMoveWindow(
    Display* ,
    Window ,
    int ,
    int
);
extern int XNextEvent(
    Display* ,
    XEvent*
);
extern int XNoOp(
    Display*
);
extern int XParseColor(
    Display* ,
    Colormap ,
    const char* ,
    XColor*
);
extern int XParseGeometry(
    const char* ,
    int* ,
    int* ,
    unsigned int* ,
    unsigned int*
);
extern int XPeekEvent(
    Display* ,
    XEvent*
);
extern int XPeekIfEvent(
    Display* ,
    XEvent* ,
    int (*) (
        Display* ,
               XEvent* ,
               XPointer
             ) ,
    XPointer
);
extern int XPending(
    Display*
);
extern int XPlanesOfScreen(
    Screen*
);
extern int XProtocolRevision(
    Display*
);
extern int XProtocolVersion(
    Display*
);
extern int XPutBackEvent(
    Display* ,
    XEvent*
);
extern int XPutImage(
    Display* ,
    Drawable ,
    GC ,
    XImage* ,
    int ,
    int ,
    int ,
    int ,
    unsigned int ,
    unsigned int
);
extern int XQLength(
    Display*
);
extern int XQueryBestCursor(
    Display* ,
    Drawable ,
    unsigned int ,
    unsigned int ,
    unsigned int* ,
    unsigned int*
);
extern int XQueryBestSize(
    Display* ,
    int ,
    Drawable ,
    unsigned int ,
    unsigned int ,
    unsigned int* ,
    unsigned int*
);
extern int XQueryBestStipple(
    Display* ,
    Drawable ,
    unsigned int ,
    unsigned int ,
    unsigned int* ,
    unsigned int*
);
extern int XQueryBestTile(
    Display* ,
    Drawable ,
    unsigned int ,
    unsigned int ,
    unsigned int* ,
    unsigned int*
);
extern int XQueryColor(
    Display* ,
    Colormap ,
    XColor*
);
extern int XQueryColors(
    Display* ,
    Colormap ,
    XColor* ,
    int
);
extern int XQueryExtension(
    Display* ,
    const char* ,
    int* ,
    int* ,
    int*
);
extern int XQueryKeymap(
    Display* ,
    char [32]
);
extern int XQueryPointer(
    Display* ,
    Window ,
    Window* ,
    Window* ,
    int* ,
    int* ,
    int* ,
    int* ,
    unsigned int*
);
extern int XQueryTextExtents(
    Display* ,
    XID ,
    const char* ,
    int ,
    int* ,
    int* ,
    int* ,
    XCharStruct*
);
extern int XQueryTextExtents16(
    Display* ,
    XID ,
    const XChar2b* ,
    int ,
    int* ,
    int* ,
    int* ,
    XCharStruct*
);
extern int XQueryTree(
    Display* ,
    Window ,
    Window* ,
    Window* ,
    Window** ,
    unsigned int*
);
extern int XRaiseWindow(
    Display* ,
    Window
);
extern int XReadBitmapFile(
    Display* ,
    Drawable ,
    const char* ,
    unsigned int* ,
    unsigned int* ,
    Pixmap* ,
    int* ,
    int*
);
extern int XReadBitmapFileData(
    const char* ,
    unsigned int* ,
    unsigned int* ,
    unsigned char** ,
    int* ,
    int*
);
extern int XRebindKeysym(
    Display* ,
    KeySym ,
    KeySym* ,
    int ,
    const unsigned char* ,
    int
);
extern int XRecolorCursor(
    Display* ,
    Cursor ,
    XColor* ,
    XColor*
);
extern int XRefreshKeyboardMapping(
    XMappingEvent*
);
extern int XRemoveFromSaveSet(
    Display* ,
    Window
);
extern int XRemoveHost(
    Display* ,
    XHostAddress*
);
extern int XRemoveHosts(
    Display* ,
    XHostAddress* ,
    int
);
extern int XReparentWindow(
    Display* ,
    Window ,
    Window ,
    int ,
    int
);
extern int XResetScreenSaver(
    Display*
);
extern int XResizeWindow(
    Display* ,
    Window ,
    unsigned int ,
    unsigned int
);
extern int XRestackWindows(
    Display* ,
    Window* ,
    int
);
extern int XRotateBuffers(
    Display* ,
    int
);
extern int XRotateWindowProperties(
    Display* ,
    Window ,
    Atom* ,
    int ,
    int
);
extern int XScreenCount(
    Display*
);
extern int XSelectInput(
    Display* ,
    Window ,
    long
);
extern int XSendEvent(
    Display* ,
    Window ,
    int ,
    long ,
    XEvent*
);
extern int XSetAccessControl(
    Display* ,
    int
);
extern int XSetArcMode(
    Display* ,
    GC ,
    int
);
extern int XSetBackground(
    Display* ,
    GC ,
    unsigned long
);
extern int XSetClipMask(
    Display* ,
    GC ,
    Pixmap
);
extern int XSetClipOrigin(
    Display* ,
    GC ,
    int ,
    int
);
extern int XSetClipRectangles(
    Display* ,
    GC ,
    int ,
    int ,
    XRectangle* ,
    int ,
    int
);
extern int XSetCloseDownMode(
    Display* ,
    int
);
extern int XSetCommand(
    Display* ,
    Window ,
    char** ,
    int
);
extern int XSetDashes(
    Display* ,
    GC ,
    int ,
    const char* ,
    int
);
extern int XSetFillRule(
    Display* ,
    GC ,
    int
);
extern int XSetFillStyle(
    Display* ,
    GC ,
    int
);
extern int XSetFont(
    Display* ,
    GC ,
    Font
);
extern int XSetFontPath(
    Display* ,
    char** ,
    int
);
extern int XSetForeground(
    Display* ,
    GC ,
    unsigned long
);
extern int XSetFunction(
    Display* ,
    GC ,
    int
);
extern int XSetGraphicsExposures(
    Display* ,
    GC ,
    int
);
extern int XSetIconName(
    Display* ,
    Window ,
    const char*
);
extern int XSetInputFocus(
    Display* ,
    Window ,
    int ,
    Time
);
extern int XSetLineAttributes(
    Display* ,
    GC ,
    unsigned int ,
    int ,
    int ,
    int
);
extern int XSetModifierMapping(
    Display* ,
    XModifierKeymap*
);
extern int XSetPlaneMask(
    Display* ,
    GC ,
    unsigned long
);
extern int XSetPointerMapping(
    Display* ,
    const unsigned char* ,
    int
);
extern int XSetScreenSaver(
    Display* ,
    int ,
    int ,
    int ,
    int
);
extern int XSetSelectionOwner(
    Display* ,
    Atom ,
    Window ,
    Time
);
extern int XSetState(
    Display* ,
    GC ,
    unsigned long ,
    unsigned long ,
    int ,
    unsigned long
);
extern int XSetStipple(
    Display* ,
    GC ,
    Pixmap
);
extern int XSetSubwindowMode(
    Display* ,
    GC ,
    int
);
extern int XSetTSOrigin(
    Display* ,
    GC ,
    int ,
    int
);
extern int XSetTile(
    Display* ,
    GC ,
    Pixmap
);
extern int XSetWindowBackground(
    Display* ,
    Window ,
    unsigned long
);
extern int XSetWindowBackgroundPixmap(
    Display* ,
    Window ,
    Pixmap
);
extern int XSetWindowBorder(
    Display* ,
    Window ,
    unsigned long
);
extern int XSetWindowBorderPixmap(
    Display* ,
    Window ,
    Pixmap
);
extern int XSetWindowBorderWidth(
    Display* ,
    Window ,
    unsigned int
);
extern int XSetWindowColormap(
    Display* ,
    Window ,
    Colormap
);
extern int XStoreBuffer(
    Display* ,
    const char* ,
    int ,
    int
);
extern int XStoreBytes(
    Display* ,
    const char* ,
    int
);
extern int XStoreColor(
    Display* ,
    Colormap ,
    XColor*
);
extern int XStoreColors(
    Display* ,
    Colormap ,
    XColor* ,
    int
);
extern int XStoreName(
    Display* ,
    Window ,
    const char*
);
extern int XStoreNamedColor(
    Display* ,
    Colormap ,
    const char* ,
    unsigned long ,
    int
);
extern int XSync(
    Display* ,
    int
);
extern int XTextExtents(
    XFontStruct* ,
    const char* ,
    int ,
    int* ,
    int* ,
    int* ,
    XCharStruct*
);
extern int XTextExtents16(
    XFontStruct* ,
    const XChar2b* ,
    int ,
    int* ,
    int* ,
    int* ,
    XCharStruct*
);
extern int XTextWidth(
    XFontStruct* ,
    const char* ,
    int
);
extern int XTextWidth16(
    XFontStruct* ,
    const XChar2b* ,
    int
);
extern int XTranslateCoordinates(
    Display* ,
    Window ,
    Window ,
    int ,
    int ,
    int* ,
    int* ,
    Window*
);
extern int XUndefineCursor(
    Display* ,
    Window
);
extern int XUngrabButton(
    Display* ,
    unsigned int ,
    unsigned int ,
    Window
);
extern int XUngrabKey(
    Display* ,
    int ,
    unsigned int ,
    Window
);
extern int XUngrabKeyboard(
    Display* ,
    Time
);
extern int XUngrabPointer(
    Display* ,
    Time
);
extern int XUngrabServer(
    Display*
);
extern int XUninstallColormap(
    Display* ,
    Colormap
);
extern int XUnloadFont(
    Display* ,
    Font
);
extern int XUnmapSubwindows(
    Display* ,
    Window
);
extern int XUnmapWindow(
    Display* ,
    Window
);
extern int XVendorRelease(
    Display*
);
extern int XWarpPointer(
    Display* ,
    Window ,
    Window ,
    int ,
    int ,
    unsigned int ,
    unsigned int ,
    int ,
    int
);
extern int XWidthMMOfScreen(
    Screen*
);
extern int XWidthOfScreen(
    Screen*
);
extern int XWindowEvent(
    Display* ,
    Window ,
    long ,
    XEvent*
);
extern int XWriteBitmapFile(
    Display* ,
    const char* ,
    Pixmap ,
    unsigned int ,
    unsigned int ,
    int ,
    int
);
extern int XSupportsLocale (void);
extern char *XSetLocaleModifiers(
    const char*
);
extern XOM XOpenOM(
    Display* ,
    struct _XrmHashBucketRec* ,
    const char* ,
    const char*
);
extern int XCloseOM(
    XOM
);
extern char *XSetOMValues(
    XOM ,
    ...
) __attribute__ ((__sentinel__(0)));
extern char *XGetOMValues(
    XOM ,
    ...
) __attribute__ ((__sentinel__(0)));
extern Display *XDisplayOfOM(
    XOM
);
extern char *XLocaleOfOM(
    XOM
);
extern XOC XCreateOC(
    XOM ,
    ...
) __attribute__ ((__sentinel__(0)));
extern void XDestroyOC(
    XOC
);
extern XOM XOMOfOC(
    XOC
);
extern char *XSetOCValues(
    XOC ,
    ...
) __attribute__ ((__sentinel__(0)));
extern char *XGetOCValues(
    XOC ,
    ...
) __attribute__ ((__sentinel__(0)));
extern XFontSet XCreateFontSet(
    Display* ,
    const char* ,
    char*** ,
    int* ,
    char**
);
extern void XFreeFontSet(
    Display* ,
    XFontSet
);
extern int XFontsOfFontSet(
    XFontSet ,
    XFontStruct*** ,
    char***
);
extern char *XBaseFontNameListOfFontSet(
    XFontSet
);
extern char *XLocaleOfFontSet(
    XFontSet
);
extern int XContextDependentDrawing(
    XFontSet
);
extern int XDirectionalDependentDrawing(
    XFontSet
);
extern int XContextualDrawing(
    XFontSet
);
extern XFontSetExtents *XExtentsOfFontSet(
    XFontSet
);
extern int XmbTextEscapement(
    XFontSet ,
    const char* ,
    int
);
extern int XwcTextEscapement(
    XFontSet ,
    const wchar_t* ,
    int
);
extern int Xutf8TextEscapement(
    XFontSet ,
    const char* ,
    int
);
extern int XmbTextExtents(
    XFontSet ,
    const char* ,
    int ,
    XRectangle* ,
    XRectangle*
);
extern int XwcTextExtents(
    XFontSet ,
    const wchar_t* ,
    int ,
    XRectangle* ,
    XRectangle*
);
extern int Xutf8TextExtents(
    XFontSet ,
    const char* ,
    int ,
    XRectangle* ,
    XRectangle*
);
extern int XmbTextPerCharExtents(
    XFontSet ,
    const char* ,
    int ,
    XRectangle* ,
    XRectangle* ,
    int ,
    int* ,
    XRectangle* ,
    XRectangle*
);
extern int XwcTextPerCharExtents(
    XFontSet ,
    const wchar_t* ,
    int ,
    XRectangle* ,
    XRectangle* ,
    int ,
    int* ,
    XRectangle* ,
    XRectangle*
);
extern int Xutf8TextPerCharExtents(
    XFontSet ,
    const char* ,
    int ,
    XRectangle* ,
    XRectangle* ,
    int ,
    int* ,
    XRectangle* ,
    XRectangle*
);
extern void XmbDrawText(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    XmbTextItem* ,
    int
);
extern void XwcDrawText(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    XwcTextItem* ,
    int
);
extern void Xutf8DrawText(
    Display* ,
    Drawable ,
    GC ,
    int ,
    int ,
    XmbTextItem* ,
    int
);
extern void XmbDrawString(
    Display* ,
    Drawable ,
    XFontSet ,
    GC ,
    int ,
    int ,
    const char* ,
    int
);
extern void XwcDrawString(
    Display* ,
    Drawable ,
    XFontSet ,
    GC ,
    int ,
    int ,
    const wchar_t* ,
    int
);
extern void Xutf8DrawString(
    Display* ,
    Drawable ,
    XFontSet ,
    GC ,
    int ,
    int ,
    const char* ,
    int
);
extern void XmbDrawImageString(
    Display* ,
    Drawable ,
    XFontSet ,
    GC ,
    int ,
    int ,
    const char* ,
    int
);
extern void XwcDrawImageString(
    Display* ,
    Drawable ,
    XFontSet ,
    GC ,
    int ,
    int ,
    const wchar_t* ,
    int
);
extern void Xutf8DrawImageString(
    Display* ,
    Drawable ,
    XFontSet ,
    GC ,
    int ,
    int ,
    const char* ,
    int
);
extern XIM XOpenIM(
    Display* ,
    struct _XrmHashBucketRec* ,
    char* ,
    char*
);
extern int XCloseIM(
    XIM
);
extern char *XGetIMValues(
    XIM , ...
) __attribute__ ((__sentinel__(0)));
extern char *XSetIMValues(
    XIM , ...
) __attribute__ ((__sentinel__(0)));
extern Display *XDisplayOfIM(
    XIM
);
extern char *XLocaleOfIM(
    XIM
);
extern XIC XCreateIC(
    XIM , ...
) __attribute__ ((__sentinel__(0)));
extern void XDestroyIC(
    XIC
);
extern void XSetICFocus(
    XIC
);
extern void XUnsetICFocus(
    XIC
);
extern wchar_t *XwcResetIC(
    XIC
);
extern char *XmbResetIC(
    XIC
);
extern char *Xutf8ResetIC(
    XIC
);
extern char *XSetICValues(
    XIC , ...
) __attribute__ ((__sentinel__(0)));
extern char *XGetICValues(
    XIC , ...
) __attribute__ ((__sentinel__(0)));
extern XIM XIMOfIC(
    XIC
);
extern int XFilterEvent(
    XEvent* ,
    Window
);
extern int XmbLookupString(
    XIC ,
    XKeyPressedEvent* ,
    char* ,
    int ,
    KeySym* ,
    int*
);
extern int XwcLookupString(
    XIC ,
    XKeyPressedEvent* ,
    wchar_t* ,
    int ,
    KeySym* ,
    int*
);
extern int Xutf8LookupString(
    XIC ,
    XKeyPressedEvent* ,
    char* ,
    int ,
    KeySym* ,
    int*
);
extern XVaNestedList XVaCreateNestedList(
    int , ...
) __attribute__ ((__sentinel__(0)));
extern int XRegisterIMInstantiateCallback(
    Display* ,
    struct _XrmHashBucketRec* ,
    char* ,
    char* ,
    XIDProc ,
    XPointer
);
extern int XUnregisterIMInstantiateCallback(
    Display* ,
    struct _XrmHashBucketRec* ,
    char* ,
    char* ,
    XIDProc ,
    XPointer
);
typedef void (*XConnectionWatchProc)(
    Display* ,
    XPointer ,
    int ,
    int ,
    XPointer*
);
extern int XInternalConnectionNumbers(
    Display* ,
    int** ,
    int*
);
extern void XProcessInternalConnection(
    Display* ,
    int
);
extern int XAddConnectionWatch(
    Display* ,
    XConnectionWatchProc ,
    XPointer
);
extern void XRemoveConnectionWatch(
    Display* ,
    XConnectionWatchProc ,
    XPointer
);
extern void XSetAuthorization(
    char * ,
    int ,
    char * ,
    int
);
extern int _Xmbtowc(
    wchar_t * ,
    char * ,
    int
);
extern int _Xwctomb(
    char * ,
    wchar_t
);
extern int XGetEventData(
    Display* ,
    XGenericEventCookie*
);
extern void XFreeEventData(
    Display* ,
    XGenericEventCookie*
);
typedef struct {
    int type;
    unsigned long serial;
    int send_event;
    Display *display;
    Window window;
    int subtype;
    Window owner;
    Atom selection;
    Time timestamp;
    Time selection_timestamp;
} XFixesSelectionNotifyEvent;
typedef struct {
    int type;
    unsigned long serial;
    int send_event;
    Display *display;
    Window window;
    int subtype;
    unsigned long cursor_serial;
    Time timestamp;
    Atom cursor_name;
} XFixesCursorNotifyEvent;
typedef struct {
    short x, y;
    unsigned short width, height;
    unsigned short xhot, yhot;
    unsigned long cursor_serial;
    unsigned long *pixels;
    Atom atom;
    const char *name;
} XFixesCursorImage;
typedef XID XserverRegion;
typedef struct {
    short x, y;
    unsigned short width, height;
    unsigned short xhot, yhot;
    unsigned long cursor_serial;
    unsigned long *pixels;
    Atom atom;
    const char *name;
} XFixesCursorImageAndName;
int XFixesQueryExtension (Display *dpy,
       int *event_base_return,
       int *error_base_return);
int XFixesQueryVersion (Display *dpy,
       int *major_version_return,
       int *minor_version_return);
int XFixesVersion (void);
void
XFixesChangeSaveSet (Display *dpy,
       Window win,
       int mode,
       int target,
       int map);
void
XFixesSelectSelectionInput (Display *dpy,
       Window win,
       Atom selection,
       unsigned long eventMask);
void
XFixesSelectCursorInput (Display *dpy,
    Window win,
    unsigned long eventMask);
XFixesCursorImage *
XFixesGetCursorImage (Display *dpy);
XserverRegion
XFixesCreateRegion (Display *dpy, XRectangle *rectangles, int nrectangles);
XserverRegion
XFixesCreateRegionFromBitmap (Display *dpy, Pixmap bitmap);
XserverRegion
XFixesCreateRegionFromWindow (Display *dpy, Window window, int kind);
XserverRegion
XFixesCreateRegionFromGC (Display *dpy, GC gc);
XserverRegion
XFixesCreateRegionFromPicture (Display *dpy, XID picture);
void
XFixesDestroyRegion (Display *dpy, XserverRegion region);
void
XFixesSetRegion (Display *dpy, XserverRegion region,
   XRectangle *rectangles, int nrectangles);
void
XFixesCopyRegion (Display *dpy, XserverRegion dst, XserverRegion src);
void
XFixesUnionRegion (Display *dpy, XserverRegion dst,
     XserverRegion src1, XserverRegion src2);
void
XFixesIntersectRegion (Display *dpy, XserverRegion dst,
         XserverRegion src1, XserverRegion src2);
void
XFixesSubtractRegion (Display *dpy, XserverRegion dst,
        XserverRegion src1, XserverRegion src2);
void
XFixesInvertRegion (Display *dpy, XserverRegion dst,
      XRectangle *rect, XserverRegion src);
void
XFixesTranslateRegion (Display *dpy, XserverRegion region, int dx, int dy);
void
XFixesRegionExtents (Display *dpy, XserverRegion dst, XserverRegion src);
XRectangle *
XFixesFetchRegion (Display *dpy, XserverRegion region, int *nrectanglesRet);
XRectangle *
XFixesFetchRegionAndBounds (Display *dpy, XserverRegion region,
       int *nrectanglesRet,
       XRectangle *bounds);
void
XFixesSetGCClipRegion (Display *dpy, GC gc,
         int clip_x_origin, int clip_y_origin,
         XserverRegion region);
void
XFixesSetWindowShapeRegion (Display *dpy, Window win, int shape_kind,
       int x_off, int y_off, XserverRegion region);
void
XFixesSetPictureClipRegion (Display *dpy, XID picture,
       int clip_x_origin, int clip_y_origin,
       XserverRegion region);
void
XFixesSetCursorName (Display *dpy, Cursor cursor, const char *name);
const char *
XFixesGetCursorName (Display *dpy, Cursor cursor, Atom *atom);
void
XFixesChangeCursor (Display *dpy, Cursor source, Cursor destination);
void
XFixesChangeCursorByName (Display *dpy, Cursor source, const char *name);
void
XFixesExpandRegion (Display *dpy, XserverRegion dst, XserverRegion src,
      unsigned left, unsigned right,
      unsigned top, unsigned bottom);
void
XFixesHideCursor (Display *dpy, Window win);
void
XFixesShowCursor (Display *dpy, Window win);
typedef XID PointerBarrier;
PointerBarrier
XFixesCreatePointerBarrier(Display *dpy, Window w, int x1, int y1,
      int x2, int y2, int directions,
      int num_devices, int *devices);
void
XFixesDestroyPointerBarrier(Display *dpy, PointerBarrier b);
void
XFixesSetClientDisconnectMode(Display *dpy, int disconnect_mode);
int
XFixesGetClientDisconnectMode(Display *dpy);
int XCompositeQueryExtension (Display *dpy,
                               int *event_base_return,
                               int *error_base_return);
int XCompositeQueryVersion (Display *dpy,
                               int *major_version_return,
                               int *minor_version_return);
int XCompositeVersion (void);
void
XCompositeRedirectWindow (Display *dpy, Window window, int update);
void
XCompositeRedirectSubwindows (Display *dpy, Window window, int update);
void
XCompositeUnredirectWindow (Display *dpy, Window window, int update);
void
XCompositeUnredirectSubwindows (Display *dpy, Window window, int update);
XserverRegion
XCompositeCreateRegionFromBorderClip (Display *dpy, Window window);
Pixmap
XCompositeNameWindowPixmap (Display *dpy, Window window);
Window
XCompositeGetOverlayWindow (Display *dpy, Window window);
void
XCompositeReleaseOverlayWindow (Display *dpy, Window window);
