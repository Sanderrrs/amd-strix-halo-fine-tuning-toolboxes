# LLM Fine Tuning Toolboxes for Ryzen AI 395+ Max

Based on original idea from - https://github.com/kyuz0/amd-strix-halo-toolboxes

**ROCm based Unsloth Fine Tuning for Strix Halo - Ryzen AI 395+ Max**

These are Ubuntu 24.04 based toolboxes for running Unsloth on Strix Halo machines.

Comes in 2 variants

1. Unsloth only - Tag `unsloth-latest`
2. Unsloth + llama.cpp - Tag `all-latest`

## Pre-requistes.

- A Ryzen AI 395+ Max machine
- Linux ( Tested on Ubuntu )
- Podman-Toolbox installed ( sudo apt install podman-toolbox )
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

### UDev

If you want to run toolbox as non-sudo user, add the following to `/etc/udev/rules.d/99-amd-kfd.rules` file.

```
SUBSYSTEM=="kfd", GROUP="render", MODE="0666", OPTIONS+="last_rule"
SUBSYSTEM=="drm", KERNEL=="card[0-9]*", GROUP="render", MODE="0666", OPTIONS+="last_rule"
```

Then run

```
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=kfd --action=change
sudo udevadm trigger --subsystem-match=drm --action=change
```

Copy paste script below in shell to do this automated

```
sudo tee /etc/udev/rules.d/99-amd-kfd.rules > /dev/null <<EOF
SUBSYSTEM=="kfd", GROUP="render", MODE="0666", OPTIONS+="last_rule"
SUBSYSTEM=="drm", KERNEL=="card[0-9]*", GROUP="render", MODE="0666", OPTIONS+="last_rule"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=kfd --action=change
sudo udevadm trigger --subsystem-match=drm --action=change
```



### Caching - Advanced On host use case

Apart from few initial binaries, almost all downloaded packages are cached in `cache` folder in the host. 

Anything installed with `pip` or `apt install` will automatically be cached and available next run.

The `/cache/root` folder is mounted to `/root/.cache`. This helps to cache models downloaded in the container. Also makes container re-install very quick


## Running ( Ubuntu / Debian commands)

### Install Toolbox

```
sudo apt install podman-toolbox
```

### Creating Toolbox - Unsloth

Run command below. This should start your toolbox named - 'toolbox-unsloth'
```
toolbox create toolbox-unsloth --image docker.io/shantur/amd-strix-halo-fine-tuning-toolboxes
```
### Creating Toolbox - All Tools

Run command below. This should start your toolbox named - 'toolbox-unsloth'
```
toolbox create toolbox-all --image docker.io/shantur/amd-strix-halo-fine-tuning-toolboxes
```

### Entering Toolbox
Following command will land you in toolbox
```
toolbox enter toolbox-unsloth
```
or
```
toolbox enter toolbox-all
```

### Running - Unsloth
```
python -c 'import unsloth'
```
Looks like
```
shantur@toolbox:~/strix-rocm-all$ python -c 'import unsloth'
🦥 Unsloth: Will patch your computer to enable 2x faster free finetuning.
Unsloth: Your Flash Attention 2 installation seems to be broken?
A possible explanation is you have a new CUDA version which isn't
yet compatible with FA2? Please file a ticket to Unsloth or FA2.
We shall now use Xformers instead, which does not have any performance hits!
We found this negligible impact by benchmarking on 1x A100.
🦥 Unsloth Zoo will now patch everything to make training faster!

```

### Running - llama.cpp
```
llama-cli --list-devices
```

