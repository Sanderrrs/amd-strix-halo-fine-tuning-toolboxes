python -m pip install --break-system-packages \
  --index-url https://rocm.nightlies.amd.com/v2/gfx1151/ \
  rocm[libraries,devel]


# git clone https://github.com/ROCm/TheRock.git work-area/TheRock
# cd work-area/TheRock
# pip install boto3 --break-system-packages

# python build_tools/install_rocm_from_artifacts.py \
#   --release 7.0.0rc20250908 --amdgpu-family gfx1151 --output-dir /opt/rocm

# RELEASE="7.0.0rc`date '+%Y%m%d'`"
# FILE=therock-dist-linux-gfx1151-$RELEASE.tar.gz
# CACHE=/root/.cache/$FILE

# [ ! -e $CACHE ] && echo "Downloading ROCm..." && wget \
#   -O $CACHE \
#   "https://therock-nightly-tarball.s3.us-east-2.amazonaws.com/$FILE"

# mkdir /opt/rocm

# echo Extracting to /opt/rocm
# tar -xvf $CACHE -C /opt/rocm

# cp -a /opt/rocm/lib/cmake /usr/local/lib/python3.12/dist-packages/_rocm_sdk_core/lib/
# sed -i -e 's/libamdhip64.so.7.*"/libamdhip64.so.7"/g' /usr/local/lib/python3.12/dist-packages/_rocm_sdk_core/lib/cmake/hip-lang/hip-lang-targets-release.cmake

#This generates cmake files
rocm-sdk path --cmake

# mkdir /opt
ln -s `rocm-sdk path --root` /opt/rocm

cp -v files/rocm-envs.sh /etc/profile.d/