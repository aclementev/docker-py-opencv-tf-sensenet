FROM unmonoqueteclea/python-opencv:py3.9-cv4.5.5
LABEL maintainer="clemente@bigml.com"

# If you are running this from a mac M1, you need to set an environment variable
# to point to some tensorflow wheel compiled without AVX-512 instructions
# (i.e: these ones https://tf.novaal.de/barcelona/)
ARG TENSORFLOW="tensorflow==2.8.0"

RUN apt-get update  && \
    apt-get -qq install -y --no-install-recommends ffmpeg alsa-utils alsa-tools  && \
    python -m pip install wheel

# Make sure we don't force sensenet to use the manually installed Tensorflow
RUN python -m pip install ${TENSORFLOW} && \
    python -m pip install 'bigml-sensenet==0.5.2' --no-build-isolation && \
    python -m pip install opencv-contrib-python
