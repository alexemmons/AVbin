LIBNAME=$(OUTDIR)/libavbin.$(AVBIN_VERSION).dylib
DARWIN_VERSION=$(shell uname -r | cut -d . -f 1)

CFLAGS += -O3 -arch x86_64
LDFLAGS += -dylib \
           -single_module \
           -arch x86_64 \
           -install_name @rpath/libavbin.dylib \
           -macosx_version_min 10.6 \
           -framework CoreFoundation \
           -framework CoreVideo \
           -framework VideoDecodeAcceleration

STATIC_LIBS = $(LIBAV)/libavformat/libavformat.a \
              $(LIBAV)/libavcodec/libavcodec.a \
              $(LIBAV)/libavutil/libavutil.a \
              $(LIBAV)/libswscale/libswscale.a

LIBS = -lSystem \
       -lz \
       -lbz2 \
       /usr/lib/dylib1.o \
       -L/usr/lib/gcc/i686-apple-darwin$(DARWIN_VERSION)/4.2.1/x86_64/ \
       -lgcc

$(LIBNAME) : $(OBJNAME) $(OUTDIR)
	$(LD) $(LDFLAGS) -o $@ $< $(STATIC_LIBS) $(LIBS)