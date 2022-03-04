# Dockerfiles for Python+OpenCV+Tensorflow+BigML-sensenet

These are images that contain the Dockerfiles for pre-built docker images that contain recent versions of Python + OpenCV + Tensorflow + BigML's Sensenet.

## Quickstart

The easiest way to consume these images is to use the uploaded to the [official registry](https://hub.docker.com/repository/docker/clementebigml/python-opencv-tf-sensenet/).

```console
docker run -it --rm aclementev/python-opencv-tf-sensenet:py3.9-cv4.5.5-tf2.8.0-amd64
```

Which will leave you in a python session.
Note the `amd64` at the end of the tag, you must change that to `arm64` if you are running a computer with arm CPUs.

## Building the Images

The following are the instructions for building the images in a similar way as they are built in the [official registry](https://hub.docker.com/repository/docker/clementebigml/python-opencv-tf-sensenet/) (in Docker Hub).
We use the `--platform` flag for Docker's `BuildKit` build backend (default on Docker Desktop version's, must be manually enabled on Linux) for building platform specific version of the images.

Due to the issues described in the [M1 and Tensorflow](#m1-and-tensorflow) section, at the moment you cannot build the images cross platform.
The version of the image for the `linux/amd64` must be built from a `x86_64` native host (Rosetta2 does not work yet).  

For x86_64:

```console
docker build -t aclementev/python-opencv-tf-sensenet:py3.9-cv4.5.5-tf2.8.0-amd64 --platform linux/amd64 .
```

For arm:

```console
docker build -t aclementev/python-opencv-tf-sensenet:py3.9-cv4.5.5-tf2.8.0-arm64 --platform linux/arm64 .
```


**NOTE**: The images are **manually tagged** with the arch version using BuildKit's default build arg `TARGETARCH`, which will be `amd64` on x86_64 and `arm64` on arm architectures.
That way you can conditionally select them any Docker image that inherits from these ones, like this:

```dockerfile
FROM clementebigml/python-opencv-tf-sensenet:py3.9-cv4.5.5-tf2.8.0-${TARGETARCH}
```


## M1 and Tensorflow

Currently there's a known issue with `qemu` on macOS not supporting `AVX-512` instructions.
These instructions are used by `Tensorflow` by default as part of the hardware acceleration techniques.
The python wheels uploaded to PyPI have these compiled in by default, and therefore we cannot simply run `pip install tensorflow`.

One solution would be to use the community-maintained `tensorflow-macos` project, however that does not play well well with other dependencies 
suffering from a similar issue (looking at you, `mediapipe`).
Therefore we are looking to use an x86 version of the library that runs on macOS's Rosetta (`qemu` based).

During the installation some native code is running, which makes it so that for now you cannot do a real cross-compilation (neither from mac to linux nor the other way around).
