# Append file to add extra configurations for the recipe.

# Adding the required dependencies for opencv
IMAGE_INSTALL:append = " opencv libopencv-core libopencv-imgproc"

# Adding the required dependencies for gstreamer
IMAGE_INSTALL:append = " v4l-utils python3 ntp fbida fbgrab ffmpeg imagemagick gstreamer1.0 gstreamer1.0-libav gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gst-player gstreamer1.0-meta-base gst-examples gstreamer1.0-rtsp-server"

# Configuring gstreamer packages to include support for required elements
PACKAGECONFIG:append:pn-gstreamer1.0-plugins-ugly = " x264"
PACKAGECONFIG:append:pn-gstreamer1.0-plugins-bad = " voaacenc"
PACKAGECONFIG:append:pn-gstreamer1.0-plugins-bad = " rtmp"