# Strix-rocm-all - ROCm based apps for Ryzen AI 395+ Max

**Install ROCm based apps for Strix Halo - Ryzen AI 395+ Max**

This setup starts a barebones Ubuntu 24.04 container and installs all dependencies in it. 

As of now all the dependencies are cached in host but container isn't imaged. I will image the container and share at a later stage.

## Pre-requistes.

- A Ryzen AI 395+ Max machine
- Ubuntu 24.04 or newer
- Docker

## Host Configuration

### Unified Memory Configuration

1. Run command `sudo nano /etc/default/grub`
1. Add the following to the line starting with `GRUB_CMDLINE_LINUX_DEFAULT`
```
amd_iommu=off amdttm.pages_limit=33554432 ttm.pages_limit=33554432 amdgpu.gttsize=131072
```
3. Save by Ctrl + x, Y 
3. IMPORTANT: Shutdown **Do Not Restart**. I have seen issues with setting not applying once.

### Caching

Apart from few initial binaries, almost all downloaded packages are cached in `cache` folder in the host. 

Anything installed with `pip` or `apt install` will automatically be cached and available next run.

The `/cache/root` folder is mounted to `/root/.cache`. This helps to cache models downloaded in the container. Also makes container re-install very quick


## Running

### Downloading this repo

```
git clone https://github.com/shantur/strix-rocm-all
cd strix-rocm-all
```

### Starting container

Run command below. This should land you in the container.
```
./start-container.sh
```
### Base Packages

Run first before installing anything
```
./01-install-packages.sh
```

### Installing tools

Run following to list all possible commands
```
make help
```
Shows like below

```
root@4c73165ad421:/strix-rocm-all# make help
Available targets:
  all: Installs everything
  bitsandbytes: Install bitsandbytes from source
  flash-attn: Install flash-attn from source
  help: Prints all available targets
  install-packages: Installs required packages
  llama-cpp: Installs llama.cpp from source
  pytorch: Installs torch torchvision torchaudio pytorch-triton-rcom from ROCm nightly
  rocWMMA: Installs rocWMMA library from source
  theRock: Installs ROCm in /opt/rocm from theRock Nightly
  unsloth: Installs unsloth from source
```

### Installing unsloth
```
make unsloth
```

### Installing llama-cpp
```
make llama-cpp
```

Others can be installed similarly

## Running Tools

All python based tools are installed in the `/usr/local/lib/python/` and all binary utils are installed in the PATH.

If any tool complain of any missing libary, run this command first

```
source /etc/profile/rocm-envs.sh
```