git clone https://github.com/bitsandbytes-foundation/bitsandbytes.git work-area/bitsandbytes \
    && git apply bitsandbytes.patch --directory work-area/bitsandbytes \

# Working commit seen 39dd8471c1c0677001d0d20ba2218b14bf18fd00
export PIP_BREAK_SYSTEM_PACKAGES=1

pip install packaging

cd work-area/bitsandbytes/

. /etc/profile.d/rocm-envs.sh 

cmake \
    -DCOMPUTE_BACKEND=hip \
    -DBNB_ROCM_ARCH="gfx1151" \
    -S . \
    --fresh
make

pip install . --no-deps

cd -
