PRODUCT_BRAND ?= radium

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/radium/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_BOOTANIMATION := vendor/radium/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip
else
PRODUCT_BOOTANIMATION := vendor/radium/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip
endif
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=dd-MM-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
ifneq ($(WITH_GMS),true)
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/radium/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/radium/prebuilt/common/bin/50-radium.sh:system/addon.d/50-radium.sh \
    vendor/radium/prebuilt/common/bin/blacklist:system/addon.d/blacklist
endif

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/radium/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# radium-specific init file
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/etc/init.local.rc:root/init.radium.rc

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/radium/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/radium/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is radium!
PRODUCT_COPY_FILES += \
    vendor/radium/config/permissions/com.radium.android.xml:system/etc/permissions/com.radium.android.xml

# T-Mobile theme engine
include vendor/radium/config/themes_common.mk

# Required CM packages
PRODUCT_PACKAGES += \
    Development \
    BluetoothExt \
    Profiles

# Optional CM packages
PRODUCT_PACKAGES += \
    VoicePlus \
    Basic \
    libemoji \
    Terminal

# Custom packages
PRODUCT_PACKAGES += \
    Launcher3 \
    Trebuchet \
    AudioFX \
    CMFileManager \
    Apollo \
    LockClock \
    CMHome \
    RadiumOTA \
    CMSettingsProvider

# CM Platform Library
PRODUCT_PACKAGES += \
    org.cyanogenmod.platform-res \
    org.cyanogenmod.platform \
    org.cyanogenmod.platform.xml

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra tools in CM
PRODUCT_PACKAGES += \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    ntfsfix \
    ntfs-3g \
    gdbserver \
    micro_bench \
    oprofiled \
    sqlite3 \
    strace

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

PRODUCT_PACKAGE_OVERLAYS += vendor/radium/overlay/common

RADIUM_VERSION_MAJOR = 1
RADIUM_VERSION_MINOR = 5
PRODUCT_VERSION_MAINTENANCE = 0-RC0

# release
ifeq ($(RADIUM_RELEASE),true)
    RADIUM_VERSION_STATE := OFFICIAL
else
    RADIUM_VERSION_STATE := UNOFFICIAL
endif
    RADIUM_VERSION := Ionzied-Radium-$(RADIUM_VERSION_MAJOR).$(RADIUM_VERSION_MINOR)-$(RADIUM_VERSION_STATE)-$(RADIUM_BUILD)-$(shell date +%Y%m%d)

RADIUM_DISPLAY_VERSION := $(RADIUM_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.radium.version=$(RADIUM_VERSION) \
	ro.radium.releasetype=$(RADIUM_BUILDTYPE) \
	ro.modversion=$(RADIUM_VERSION) \
	radium.ota.version=$(shell date +%Y%m%d)

# SuperSU 
PRODUCT_COPY_FILES += \
    vendor/radium/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    vendor/radium/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),)
ifneq ($(PRODUCT_DEFAULT_DEV_CERTIFICATE),build/target/product/security/testkey)
  ifneq ($(RADIUM_BUILDTYPE), UNOFFICIAL)
    ifndef TARGET_VENDOR_RELEASE_BUILD_ID
      ifneq ($(RADIUM_EXTRAVERSION),)
        # Remove leading dash from RADIUM_EXTRAVERSION
        RADIUM_EXTRAVERSION := $(shell echo $(RADIUM_EXTRAVERSION) | sed 's/-//')
        TARGET_VENDOR_RELEASE_BUILD_ID := $(RADIUM_EXTRAVERSION)
      else
        TARGET_VENDOR_RELEASE_BUILD_ID := $(shell date -u +%Y%m%d)
      endif
    else
      TARGET_VENDOR_RELEASE_BUILD_ID := $(TARGET_VENDOR_RELEASE_BUILD_ID)
    endif
    RADIUM_DISPLAY_VERSION=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(TARGET_VENDOR_RELEASE_BUILD_ID)
  endif
endif
endif

# by default, do not update the recovery with system updates
PRODUCT_PROPERTY_OVERRIDES += persist.sys.recovery_update=false

ifndef CM_PLATFORM_SDK_VERSION
  # This is the canonical definition of the SDK version, which defines
  # the set of APIs and functionality available in the platform.  It
  # is a single integer that increases monotonically as updates to
  # the SDK are released.  It should only be incremented when the APIs for
  # the new release are frozen (so that developers don't write apps against
  # intermediate builds).
  CM_PLATFORM_SDK_VERSION := 3
endif

ifndef CM_PLATFORM_REV
  # For internal SDK revisions that are hotfixed/patched
  # Reset after each CM_PLATFORM_SDK_VERSION release
  # If you are doing a release and this is NOT 0, you are almost certainly doing it wrong
  CM_PLATFORM_REV := 0
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.radium.display.version=$(RADIUM_DISPLAY_VERSION)

# CyanogenMod Platform SDK Version
PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.build.version.plat.sdk=$(CM_PLATFORM_SDK_VERSION)

# CyanogenMod Platform Internal
PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.build.version.plat.rev=$(CM_PLATFORM_REV)

-include $(WORKSPACE)/build_env/image-auto-bits.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
