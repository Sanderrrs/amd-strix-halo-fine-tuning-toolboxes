export ROCM_VERSION=7.0_rc1
export AMDGPU_VERSION=30.10_rc1

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-cacher-ng
apt-cacher-ng

echo 'Acquire::http::Proxy "http://localhost:3142";' > /etc/apt/apt.conf.d/cacher
echo 'Acquire::https::Proxy "http://localhost:3142";' >>  /etc/apt/apt.conf.d/cacher

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl libnuma-dev gnupg \
  && curl -sL https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add - \
  && printf "deb [arch=amd64] http://repo.radeon.com/rocm/apt/$ROCM_VERSION/ noble main" | tee /etc/apt/sources.list.d/rocm.list \
  && printf "deb [arch=amd64] http://repo.radeon.com/amdgpu/$AMDGPU_VERSION/ubuntu noble main" | tee /etc/apt/sources.list.d/amdgpu.list \
  && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    sudo \
    libelf1 \
    kmod \
    file \
    python3-dev \
    python3-pip \
    python-is-python3 \
    build-essential \
    git git-lfs \
    ninja-build \
    cmake \
    pkg-config \
    xxd \
    patchelf \
    automake \
    curl \
    wget \
    vim \
    libcurl4t64 \
    libcurl4-openssl-dev \
    libtool \
    # libegl1-mesa-dev \
    # g++ \
    # gfortran \
    # rocm7.0.0 \
    # rocm-hip-sdk7.0.0 \
    # hipcc7.0.0 \
    # rocm-cmake7.0.0 \
    # rocm-dev7.0.0 \
    # rocm7.0.0 \
    # rocm-device-libs7.0.0 \


groupadd -g 109 render

export PIP_BREAK_SYSTEM_PACKAGES=1

echo "export PIP_BREAK_SYSTEM_PACKAGES=1" > envVars

mkdir -p work-area

