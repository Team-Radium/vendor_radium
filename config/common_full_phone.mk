# Inherit common stuff
$(call inherit-product, vendor/radium/config/common.mk)
$(call inherit-product, vendor/radium/config/common_apn.mk)

# SIM Toolkit
PRODUCT_PACKAGES += \
    Stk
