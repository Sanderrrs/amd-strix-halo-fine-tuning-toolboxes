git clone https://github.com/ROCm/TheRock.git work-area/TheRock
cd work-area/TheRock
# pip install boto3 --break-system-packages

# python build_tools/install_rocm_from_artifacts.py \
#   --release 7.0.0rc20250908 --amdgpu-family gfx1151 --output-dir /opt/rocm

RELEASE=7.0.0rc20250908
FILE=therock-dist-linux-gfx1151-$RELEASE.tar.gz
CACHE=/root/.cache/$FILE

[ ! -e $CACHE ] && echo "Downloading ROCm..." && wget \
  -O $CACHE \
  "https://therock-nightly-tarball.s3.us-east-2.amazonaws.com/$FILE"


mkdir /opt/rocm

echo Extracting to /opt/rocm
tar -xvf $CACHE -C /opt/rocm

cd -

echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/opt/rocm/lib/" >> envVars
echo "export PATH=/opt/rocm/bin:\$PATH" >> envVars
