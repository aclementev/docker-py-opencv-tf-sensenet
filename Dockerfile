FROM unmonoqueteclea/python-opencv:py3.9-cv4.5.5
LABEL maintainer="clemente@bigml.com"

RUN apt-get update  && \
    apt-get -qq install -y --no-install-recommends ffmpeg alsa-utils alsa-tools  && \
    python -m pip install wheel

# This is a default build-arg passed by docker `buildx` backend
ARG TARGETPLATFORM

# Install the right version of tensorflow based on the target platform
# Which by default is 'linux/amd64'. To modify it use the --platform flag for
# docker build (using docker buildx/BuildKit backend)
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; \
    then \
        python -m pip install 'https://tf.novaal.de/barcelona/tensorflow-2.8.0-cp39-cp39-linux_x86_64.whl' && \
        python -m pip install 'bigml-sensenet==0.5.2' --no-build-isolation && \
        python -m pip install opencv-contrib-python; \
    else \
        python -m pip install "tensorflow==2.8.0" "bigml-sensenet==0.5.2" opencv-contrib-python; \
    fi
