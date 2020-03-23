################################################################################
#
# ffmpeg
#
################################################################################

FFMPEG_GPT_VERSION = n3.4.2_gpt_0.2_dev_demo
FFMPEG_GPT_SITE_METHOD = git
FFMPEG_GPT_SITE = git@moore:software/ffmpeg.git
FFMPEG_GPT_SOURCE = ffmpeg-gpt-$(FFMPEG_GPT_VERSION).tar.gz
FFMPEG_GPT_ALWAYS_BUILD = YES
FFMPEG_GPT_INSTALL_STAGING = YES

FFMPEG_GPT_LICENSE = LGPL-2.1+, libjpeg license
FFMPEG_GPT_LICENSE_FILES = LICENSE.md COPYING.LGPLv2.1
ifeq ($(BR2_PACKAGE_FFMPEG_GPT_GPL),y)
FFMPEG_GPT_LICENSE += and GPL-2.0+
FFMPEG_GPT_LICENSE_FILES += COPYING.GPLv2
endif

FFMPEG_GPT_CONF_OPTS = \
	--prefix=/usr \
	--enable-avfilter \
	--disable-version3 \
	--enable-logging \
	--disable-optimizations \
	--disable-extra-warnings \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--enable-network \
	--disable-gray \
	--enable-swscale-alpha \
	--disable-small \
	--enable-dct \
	--enable-fft \
	--enable-mdct \
	--enable-rdft \
	--disable-crystalhd \
	--disable-dxva2 \
	--disable-hardcoded-tables \
	--disable-mipsdsp \
	--disable-mipsdspr2 \
	--disable-msa \
	--disable-cuda \
	--disable-cuvid \
	--disable-nvenc \
	--disable-avisynth \
	--disable-frei0r \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libdc1394 \
	--disable-libgsm \
	--disable-libilbc \
	--disable-libvo-amrwbenc \
	--disable-symver \
	--disable-doc \
	--disable-debug

FFMPEG_GPT_DEPENDENCIES += host-pkgconf

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_GPL),y)
FFMPEG_GPT_CONF_OPTS += --enable-gpl
else
FFMPEG_GPT_CONF_OPTS += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_NONFREE),y)
FFMPEG_GPT_CONF_OPTS += --enable-nonfree
else
FFMPEG_GPT_CONF_OPTS += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_FFMPEG_GPT),y)
FFMPEG_GPT_CONF_OPTS += --enable-ffmpeg
else
FFMPEG_GPT_CONF_OPTS += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_FFPLAY),y)
FFMPEG_GPT_DEPENDENCIES += sdl2
FFMPEG_GPT_CONF_OPTS += --enable-ffplay
FFMPEG_GPT_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl2-config
else
FFMPEG_GPT_CONF_OPTS += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_FFSERVER),y)
FFMPEG_GPT_CONF_OPTS += --enable-ffserver
else
FFMPEG_GPT_CONF_OPTS += --disable-ffserver
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_AVRESAMPLE),y)
FFMPEG_GPT_CONF_OPTS += --enable-avresample
else
FFMPEG_GPT_CONF_OPTS += --disable-avresample
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_FFPROBE),y)
FFMPEG_GPT_CONF_OPTS += --enable-ffprobe
else
FFMPEG_GPT_CONF_OPTS += --disable-ffprobe
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_POSTPROC),y)
FFMPEG_GPT_CONF_OPTS += --enable-postproc
else
FFMPEG_GPT_CONF_OPTS += --disable-postproc
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_SWSCALE),y)
FFMPEG_GPT_CONF_OPTS += --enable-swscale
else
FFMPEG_GPT_CONF_OPTS += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_ENCODERS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-encoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_DECODERS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-decoders \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_MUXERS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-muxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_DEMUXERS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-demuxers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_PARSERS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-parsers \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_BSFS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-bsfs \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_BSFS)),--enable-bsfs=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_PROTOCOLS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-protocols \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_FILTERS)),all)
FFMPEG_GPT_CONF_OPTS += --disable-filters \
	$(foreach x,$(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_INDEVS),y)
FFMPEG_GPT_CONF_OPTS += --enable-indevs
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
FFMPEG_GPT_CONF_OPTS += --enable-alsa
FFMPEG_GPT_DEPENDENCIES += alsa-lib
else
FFMPEG_GPT_CONF_OPTS += --disable-alsa
endif
else
FFMPEG_GPT_CONF_OPTS += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_OUTDEVS),y)
FFMPEG_GPT_CONF_OPTS += --enable-outdevs
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
FFMPEG_GPT_DEPENDENCIES += alsa-lib
endif
else
FFMPEG_GPT_CONF_OPTS += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
FFMPEG_GPT_CONF_OPTS += --enable-pthreads
else
FFMPEG_GPT_CONF_OPTS += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
FFMPEG_GPT_CONF_OPTS += --enable-zlib
FFMPEG_GPT_DEPENDENCIES += zlib
else
FFMPEG_GPT_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_BZIP2),y)
FFMPEG_GPT_CONF_OPTS += --enable-bzlib
FFMPEG_GPT_DEPENDENCIES += bzip2
else
FFMPEG_GPT_CONF_OPTS += --disable-bzlib
endif

ifeq ($(BR2_PACKAGE_FDK_AAC)$(BR2_PACKAGE_FFMPEG_GPT_NONFREE),yy)
FFMPEG_GPT_CONF_OPTS += --enable-libfdk-aac
FFMPEG_GPT_DEPENDENCIES += fdk-aac
else
FFMPEG_GPT_CONF_OPTS += --disable-libfdk-aac
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_GPL)$(BR2_PACKAGE_LIBCDIO_PARANOIA),yy)
FFMPEG_GPT_CONF_OPTS += --enable-libcdio
FFMPEG_GPT_DEPENDENCIES += libcdio-paranoia
else
FFMPEG_GPT_CONF_OPTS += --disable-libcdio
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
FFMPEG_GPT_CONF_OPTS += --enable-gnutls --disable-openssl
FFMPEG_GPT_DEPENDENCIES += gnutls
else
FFMPEG_GPT_CONF_OPTS += --disable-gnutls
ifeq ($(BR2_PACKAGE_OPENSSL),y)
# openssl isn't license compatible with GPL
ifeq ($(BR2_PACKAGE_FFMPEG_GPT_GPL)x$(BR2_PACKAGE_FFMPEG_GPT_NONFREE),yx)
FFMPEG_GPT_CONF_OPTS += --disable-openssl
else
FFMPEG_GPT_CONF_OPTS += --enable-openssl
FFMPEG_GPT_DEPENDENCIES += openssl
endif
else
FFMPEG_GPT_CONF_OPTS += --disable-openssl
endif
endif

ifeq ($(BR2_PACKAGE_FFMPEG_GPT_GPL)$(BR2_PACKAGE_LIBEBUR128),yy)
FFMPEG_GPT_DEPENDENCIES += libebur128
endif

ifeq ($(BR2_PACKAGE_LIBOPENH264),y)
FFMPEG_GPT_CONF_OPTS += --enable-libopenh264
FFMPEG_GPT_DEPENDENCIES += libopenh264
else
FFMPEG_GPT_CONF_OPTS += --disable-libopenh264
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
FFMPEG_GPT_DEPENDENCIES += libvorbis
FFMPEG_GPT_CONF_OPTS += \
	--enable-libvorbis \
	--enable-muxer=ogg \
	--enable-encoder=libvorbis
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
FFMPEG_GPT_CONF_OPTS += --enable-vaapi
FFMPEG_GPT_DEPENDENCIES += libva
else
FFMPEG_GPT_CONF_OPTS += --disable-vaapi
endif

ifeq ($(BR2_PACKAGE_LIBVDPAU),y)
FFMPEG_GPT_CONF_OPTS += --enable-vdpau
FFMPEG_GPT_DEPENDENCIES += libvdpau
else
FFMPEG_GPT_CONF_OPTS += --disable-vdpau
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
FFMPEG_GPT_CONF_OPTS += --enable-mmal --enable-omx --enable-omx-rpi \
	--extra-cflags=-I$(STAGING_DIR)/usr/include/IL
FFMPEG_GPT_DEPENDENCIES += rpi-userland
else
FFMPEG_GPT_CONF_OPTS += --disable-mmal --disable-omx --disable-omx-rpi
endif

# To avoid a circular dependency only use opencv if opencv itself does
# not depend on ffmpeg.
ifeq ($(BR2_PACKAGE_OPENCV_LIB_IMGPROC)x$(BR2_PACKAGE_OPENCV_WITH_FFMPEG_GPT),yx)
FFMPEG_GPT_CONF_OPTS += --enable-libopencv
FFMPEG_GPT_DEPENDENCIES += opencv
else ifeq ($(BR2_PACKAGE_OPENCV3_LIB_IMGPROC)x$(BR2_PACKAGE_OPENCV3_WITH_FFMPEG_GPT),yx)
FFMPEG_GPT_CONF_OPTS += --enable-libopencv
FFMPEG_GPT_DEPENDENCIES += opencv3
else
FFMPEG_GPT_CONF_OPTS += --disable-libopencv
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
FFMPEG_GPT_CONF_OPTS += --enable-libopus
FFMPEG_GPT_DEPENDENCIES += opus
else
FFMPEG_GPT_CONF_OPTS += --disable-libopus
endif

ifeq ($(BR2_PACKAGE_LIBVPX),y)
FFMPEG_GPT_CONF_OPTS += --enable-libvpx
FFMPEG_GPT_DEPENDENCIES += libvpx
else
FFMPEG_GPT_CONF_OPTS += --disable-libvpx
endif

ifeq ($(BR2_PACKAGE_LIBASS),y)
FFMPEG_GPT_CONF_OPTS += --enable-libass
FFMPEG_GPT_DEPENDENCIES += libass
else
FFMPEG_GPT_CONF_OPTS += --disable-libass
endif

ifeq ($(BR2_PACKAGE_LIBBLURAY),y)
FFMPEG_GPT_CONF_OPTS += --enable-libbluray
FFMPEG_GPT_DEPENDENCIES += libbluray
else
FFMPEG_GPT_CONF_OPTS += --disable-libbluray
endif

ifeq ($(BR2_PACKAGE_RTMPDUMP),y)
FFMPEG_GPT_CONF_OPTS += --enable-librtmp
FFMPEG_GPT_DEPENDENCIES += rtmpdump
else
FFMPEG_GPT_CONF_OPTS += --disable-librtmp
endif

ifeq ($(BR2_PACKAGE_LAME),y)
FFMPEG_GPT_CONF_OPTS += --enable-libmp3lame
FFMPEG_GPT_DEPENDENCIES += lame
else
FFMPEG_GPT_CONF_OPTS += --disable-libmp3lame
endif

ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
FFMPEG_GPT_CONF_OPTS += --enable-libmodplug
FFMPEG_GPT_DEPENDENCIES += libmodplug
else
FFMPEG_GPT_CONF_OPTS += --disable-libmodplug
endif

ifeq ($(BR2_PACKAGE_SPEEX),y)
FFMPEG_GPT_CONF_OPTS += --enable-libspeex
FFMPEG_GPT_DEPENDENCIES += speex
else
FFMPEG_GPT_CONF_OPTS += --disable-libspeex
endif

ifeq ($(BR2_PACKAGE_LIBTHEORA),y)
FFMPEG_GPT_CONF_OPTS += --enable-libtheora
FFMPEG_GPT_DEPENDENCIES += libtheora
else
FFMPEG_GPT_CONF_OPTS += --disable-libtheora
endif

ifeq ($(BR2_PACKAGE_WAVPACK),y)
FFMPEG_GPT_CONF_OPTS += --enable-libwavpack
FFMPEG_GPT_DEPENDENCIES += wavpack
else
FFMPEG_GPT_CONF_OPTS += --disable-libwavpack
endif

ifeq ($(BR2_PACKAGE_LIBICONV),y)
FFMPEG_GPT_CONF_OPTS += --enable-iconv
FFMPEG_GPT_DEPENDENCIES += libiconv
else
FFMPEG_GPT_CONF_OPTS += --disable-iconv
endif

# ffmpeg freetype support require fenv.h which is only
# available/working on glibc.
# The microblaze variant doesn't provide the needed exceptions
ifeq ($(BR2_PACKAGE_FREETYPE)$(BR2_TOOLCHAIN_USES_GLIBC)x$(BR2_microblaze),yyx)
FFMPEG_GPT_CONF_OPTS += --enable-libfreetype
FFMPEG_GPT_DEPENDENCIES += freetype
else
FFMPEG_GPT_CONF_OPTS += --disable-libfreetype
endif

ifeq ($(BR2_PACKAGE_FONTCONFIG),y)
FFMPEG_GPT_CONF_OPTS += --enable-fontconfig
FFMPEG_GPT_DEPENDENCIES += fontconfig
else
FFMPEG_GPT_CONF_OPTS += --disable-fontconfig
endif

ifeq ($(BR2_PACKAGE_OPENJPEG),y)
FFMPEG_GPT_CONF_OPTS += --enable-libopenjpeg
FFMPEG_GPT_DEPENDENCIES += openjpeg
else
FFMPEG_GPT_CONF_OPTS += --disable-libopenjpeg
endif

ifeq ($(BR2_PACKAGE_X264)$(BR2_PACKAGE_FFMPEG_GPT_GPL),yy)
FFMPEG_GPT_CONF_OPTS += --enable-libx264
FFMPEG_GPT_DEPENDENCIES += x264
else
FFMPEG_GPT_CONF_OPTS += --disable-libx264
endif

ifeq ($(BR2_PACKAGE_X265)$(BR2_PACKAGE_FFMPEG_GPT_GPL),yy)
FFMPEG_GPT_CONF_OPTS += --enable-libx265
FFMPEG_GPT_DEPENDENCIES += x265
else
FFMPEG_GPT_CONF_OPTS += --disable-libx265
endif

ifeq ($(BR2_X86_CPU_HAS_MMX),y)
FFMPEG_GPT_CONF_OPTS += --enable-x86asm
FFMPEG_GPT_DEPENDENCIES += host-nasm
else
FFMPEG_GPT_CONF_OPTS += --disable-x86asm
FFMPEG_GPT_CONF_OPTS += --disable-mmx
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
FFMPEG_GPT_CONF_OPTS += --enable-sse
else
FFMPEG_GPT_CONF_OPTS += --disable-sse
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
FFMPEG_GPT_CONF_OPTS += --enable-sse2
else
FFMPEG_GPT_CONF_OPTS += --disable-sse2
endif

ifeq ($(BR2_X86_CPU_HAS_SSE3),y)
FFMPEG_GPT_CONF_OPTS += --enable-sse3
else
FFMPEG_GPT_CONF_OPTS += --disable-sse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSSE3),y)
FFMPEG_GPT_CONF_OPTS += --enable-ssse3
else
FFMPEG_GPT_CONF_OPTS += --disable-ssse3
endif

ifeq ($(BR2_X86_CPU_HAS_SSE4),y)
FFMPEG_GPT_CONF_OPTS += --enable-sse4
else
FFMPEG_GPT_CONF_OPTS += --disable-sse4
endif

ifeq ($(BR2_X86_CPU_HAS_SSE42),y)
FFMPEG_GPT_CONF_OPTS += --enable-sse42
else
FFMPEG_GPT_CONF_OPTS += --disable-sse42
endif

ifeq ($(BR2_X86_CPU_HAS_AVX),y)
FFMPEG_GPT_CONF_OPTS += --enable-avx
else
FFMPEG_GPT_CONF_OPTS += --disable-avx
endif

ifeq ($(BR2_X86_CPU_HAS_AVX2),y)
FFMPEG_GPT_CONF_OPTS += --enable-avx2
else
FFMPEG_GPT_CONF_OPTS += --disable-avx2
endif

# Explicitly disable everything that doesn't match for ARM
# FFMPEG_GPT "autodetects" by compiling an extended instruction via AS
# This works on compilers that aren't built for generic by default
ifeq ($(BR2_ARM_CPU_ARMV4),y)
FFMPEG_GPT_CONF_OPTS += --disable-armv5te
endif
ifeq ($(BR2_ARM_CPU_ARMV6)$(BR2_ARM_CPU_ARMV7A),y)
FFMPEG_GPT_CONF_OPTS += --enable-armv6
else
FFMPEG_GPT_CONF_OPTS += --disable-armv6 --disable-armv6t2
endif
ifeq ($(BR2_ARM_CPU_HAS_VFPV2),y)
FFMPEG_GPT_CONF_OPTS += --enable-vfp
else
FFMPEG_GPT_CONF_OPTS += --disable-vfp
endif
ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
FFMPEG_GPT_CONF_OPTS += --enable-neon
else ifeq ($(BR2_aarch64),y)
FFMPEG_GPT_CONF_OPTS += --enable-neon
else
FFMPEG_GPT_CONF_OPTS += --disable-neon
endif

ifeq ($(BR2_mips)$(BR2_mipsel)$(BR2_mips64)$(BR2_mips64el),y)
ifeq ($(BR2_MIPS_SOFT_FLOAT),y)
FFMPEG_GPT_CONF_OPTS += --disable-mipsfpu
else
FFMPEG_GPT_CONF_OPTS += --enable-mipsfpu
endif
endif # MIPS

ifeq ($(BR2_POWERPC_CPU_HAS_ALTIVEC),y)
FFMPEG_GPT_CONF_OPTS += --enable-altivec
else
FFMPEG_GPT_CONF_OPTS += --disable-altivec
endif

# Uses __atomic_fetch_add_4
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
FFMPEG_GPT_CONF_OPTS += --extra-libs=-latomic
endif

ifeq ($(BR2_STATIC_LIBS),)
FFMPEG_GPT_CONF_OPTS += --enable-pic
else
FFMPEG_GPT_CONF_OPTS += --disable-pic
endif

# Default to --cpu=generic for MIPS architecture, in order to avoid a
# warning from ffmpeg's configure script.
ifeq ($(BR2_mips)$(BR2_mipsel)$(BR2_mips64)$(BR2_mips64el),y)
FFMPEG_GPT_CONF_OPTS += --cpu=generic
else ifneq ($(call qstrip,$(BR2_GCC_TARGET_CPU)),)
FFMPEG_GPT_CONF_OPTS += --cpu=$(BR2_GCC_TARGET_CPU)
else ifneq ($(call qstrip,$(BR2_GCC_TARGET_ARCH)),)
FFMPEG_GPT_CONF_OPTS += --cpu=$(BR2_GCC_TARGET_ARCH)
endif

FFMPEG_GPT_CONF_OPTS += $(call qstrip,$(BR2_PACKAGE_FFMPEG_GPT_EXTRACONF))

# Override FFMPEG_GPT_CONFIGURE_CMDS: FFmpeg does not support --target and others
define FFMPEG_GPT_CONFIGURE_CMDS
	(cd $(FFMPEG_GPT_SRCDIR) && rm -rf config.cache && \
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_CONFIGURE_ARGS) \
	$(FFMPEG_GPT_CONF_ENV) \
	./configure \
		--enable-cross-compile \
		--cross-prefix=$(TARGET_CROSS) \
		--sysroot=$(STAGING_DIR) \
		--host-cc="$(HOSTCC)" \
		--arch=$(BR2_ARCH) \
		--target-os="linux" \
		--disable-stripping \
		--pkg-config="$(PKG_CONFIG_HOST_BINARY)" \
		$(SHARED_STATIC_LIBS_OPTS) \
		$(FFMPEG_GPT_CONF_OPTS) \
	)
endef

define FFMPEG_GPT_REMOVE_EXAMPLE_SRC_FILES
	rm -rf $(TARGET_DIR)/usr/share/ffmpeg/examples
endef
FFMPEG_GPT_POST_INSTALL_TARGET_HOOKS += FFMPEG_GPT_REMOVE_EXAMPLE_SRC_FILES

$(eval $(autotools-package))
