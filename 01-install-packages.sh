if [ "$1" != "NO_CACHING" ]
then
  echo "Enabling Cache"
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-cacher-ng
  apt-cacher-ng

  echo 'Acquire::http::Proxy "http://localhost:3142";' > /etc/apt/apt.conf.d/cacher
  echo 'Acquire::https::Proxy "http://localhost:3142";' >>  /etc/apt/apt.conf.d/cacher
fi

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl libnuma-dev gnupg \
  && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libelf1 \
    kmod \
    file \
    python3-dev \
    python3-pip \
    python-is-python3 \
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
    build-essential \

groupadd -g 109 render

mkdir -p work-area

