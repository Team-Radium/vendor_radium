# from device/cyanogen/msm8916-common/system.prop
#
# Art
dalvik.vm.dex2oat-flags=--no-watch-dog

# Audio
tunnel.audio.encode=false
av.offload.enable=true
av.streaming.offload.enable=true
audio.offload.buffer.size.kb=64
audio.offload.gapless.enabled=true
audio.offload.min.duration.secs=30
audio.offload.pcm.16bit.enable=false
audio.offload.pcm.24bit.enable=true
use.voice.path.for.pcm.voip=true
vidc.enc.narrow.searchrange=1

# Media
mm.enable.qcom_parser=3183153
mm.enable.smoothstreaming=true
mm.disable.sec_smoothstreaming=true
media.aac_51_output_enabled=true

# set max starting background services
ro.config.max_starting_bg=8

# Bluetooth
ro.qualcomm.bt.hci_transport=smd

# Display
debug.composition.type=c2d
debug.sf.gpu_comp_tiling=1
debug.mdpcomp.idletime=600
persist.hwc.mdpcomp.enable=true
persist.hwc.ptor.enable=true
ro.opengles.version=196608
debug.enable.sglscale=1

# GPS
persist.gps.qc_nlp_in_use=0
ro.gps.agps_provider=1
ro.qc.sdk.izat.premium.enabled=0
ro.qc.sdk.izat.service_mask=0x0

# NITZ
persist.rild.nitz_plmn=
persist.rild.nitz_long_ons_0=
persist.rild.nitz_long_ons_1=
persist.rild.nitz_long_ons_2=
persist.rild.nitz_long_ons_3=
persist.rild.nitz_short_ons_0=
persist.rild.nitz_short_ons_1=
persist.rild.nitz_short_ons_2=
persist.rild.nitz_short_ons_3=

# Radio
persist.data.qmi.adb_logmask=0
persist.radio.apm_sim_not_pwdn=1
rild.libargs=-d /dev/smd0

ro.use_data_netmgrd=true

# Time
persist.timed.enable=true

# perf
ro.core_ctl_min_cpu=2
ro.core_ctl_max_cpu=4
ro.min_freq_0=800000
ro.vendor.extension_library=libqti-perfd-client.so

#Trim properties
ro.sys.fw.use_trim_settings=true
ro.sys.fw.empty_app_percent=50
ro.sys.fw.trim_empty_percent=100
ro.sys.fw.trim_cache_percent=100
ro.sys.fw.trim_enable_memory=1073741824


# Enable B service adj transition by default
ro.sys.fw.bservice_enable=true
ro.sys.fw.bservice_limit=5
ro.sys.fw.bservice_age=5000

# WiFi
ro.disableWifiApFirmwareReload=true
#
# from device/yu/lettuce/system.prop
#
# Audio
ro.qc.sdk.audio.fluencetype=fluence
persist.audio.fluence.voicecall=true
persist.audio.fluence.voicerec=false
persist.audio.fluence.speaker=true

# set roaming indicator to always show
ro.config.always_show_roaming=true

# Display
ro.sf.lcd_density=320

# Radio
persist.data.target=dpm1
persist.radio.multisim.config=dsds
persist.radio.no_cons_man_roam=1
ril.ecclist=000,08,100,101,102,110,112,118,119,120,122,911,999

ro.com.android.mobiledata=false
ro.telephony.default_network=9,1

# relax sensor fusion mag field filter
ro.fusion.magfield.max=250
ro.adb.secure=0
ro.secure=0

#
# ADDITIONAL_BUILD_PROPERTIES
#
keyguard.no_require_sim=true
ro.com.android.dataroaming=true
ro.config.ringtone=Ring_Synth_04.ogg
ro.config.notification_sound=pixiedust.ogg
ro.carrier=unknown
ro.config.alarm_alert=Alarm_Classic.ogg
dalvik.vm.dex2oat-filter=speed
dalvik.vm.dex2oat-swap=false
dalvik.vm.heapstartsize=12m
dalvik.vm.heapgrowthlimit=128m
dalvik.vm.heapsize=256m
dalvik.vm.heaptargetutilization=0.75
dalvik.vm.heapminfree=4m
ro.hwui.texture_cache_size=72
ro.hwui.layer_cache_size=48
ro.hwui.r_buffer_cache_size=8
ro.hwui.path_cache_size=32
ro.hwui.gradient_cache_size=1
ro.hwui.drop_shadow_cache_size=6
ro.hwui.texture_cache_flushrate=0.4
ro.hwui.text_small_cache_width=1024
ro.hwui.text_small_cache_height=1024
ro.hwui.text_large_cache_width=2048
ro.hwui.text_large_cache_height=1024
sys.io.scheduler=row
ro.com.google.clientidbase=android-google
ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html
ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html
ro.com.android.wifi-watchlist=GoogleGuest
ro.setupwizard.enterprise_mode=1
ro.com.android.dateformat=MM-dd-yyyy
ro.build.selinux=1
persist.sys.dun.override=0
media.sf.omx-plugin=libffmpeg_omx.so
media.sf.extractor-plugin=libffmpeg_extractor.so
persist.sys.recovery_update=false
persist.sys.dalvik.vm.lib.2=libart
dalvik.vm.isa.arm64.variant=generic
dalvik.vm.isa.arm64.features=default
dalvik.vm.isa.arm.variant=cortex-a53
dalvik.vm.isa.arm.features=default
ro.kernel.android.checkjni=1
dalvik.vm.lockprof.threshold=500
dalvik.vm.image-dex2oat-filter=verify-at-runtime
dalvik.vm.usejit=true
net.bt.name=Android
dalvik.vm.stack-trace-file=/data/anr/traces.txt
ro.expect.recovery_id=0xe28d089d3a30c320b4ddeb02c0aa7d8f682e99a8000000000000000000000000
