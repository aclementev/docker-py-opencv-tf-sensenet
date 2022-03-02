# Dockerfiles for Python+OpenCV+Tensorflow+BigML-sensenet

These are images that contain the Dockerfiles for pre-built docker images that contain recent versions of Python + OpenCV + Tensorflow + BigML's Sensenet.

## Quickstart
You can clone this repo and build them yourself with:


```console
docker build -t my-tag .
```

Or use the ones uploaded to the docker registry.
If you are on a macOS with an M1 processor, see the [notes on m1](#m1-usage) section.

### M1 Usage

Currently there's a known issue with `qemu` on macOS not supporting `AVX-512` instructions.
These instructions are used by `Tensorflow` by default as part of the hardware acceleration techniques.
The python wheels uploaded to PyPI have these compiled in by default, and therefore we cannot simply run `pip install tensorflow`.

Instead, we need to build a wheel without these instructions.
We can compile tensorflow ourselves, and use that version to build our own wheel, but that is surprisingly challenging.
However, there are publicly available pre-built wheels, maintained by the comunity.
One of the recommended options are the wheels at <https://tf.novaal.de/barcelona/>.  
Get the link to the relevant version and pass it in the `TENSORFLOW` build-arg:

```console
docker build -t aclementev/python-opencv-tf-sensenet:py3.9-cv4.5.5-tf2.8.0 --build-arg TENSORFLOW=https://tf.novaal.de/barcelona/tensorflow-2.8.0-cp39-cp39-linux_x86_64.whl .
```
