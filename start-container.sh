mkdir -p cache/apt
mkdir -p cache/root

docker run -it \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  --ipc=host \
  --shm-size 8G \
  -v ${PWD}:/strix-rocm-all \
  -v ${PWD}/cache/apt:/var/cache/apt-cacher-ng \
  -v ${PWD}/cache/root:/root/.cache \
  -w /strix-rocm-all \
  -v /var/cache/apt/archives/:/var/cache/apt/archives/ \
  ubuntu:24.04
  # rocm/llama.cpp:llama.cpp-b5997_rocm6.4.0_ubuntu24.04_server