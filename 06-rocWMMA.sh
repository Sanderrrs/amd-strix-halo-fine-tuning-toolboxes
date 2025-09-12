git clone https://github.com/ROCm/rocWMMA work-area/rocWMMA
cd work-area/rocWMMA

. /etc/profile.d/rocm-envs.sh 

cmake -B build -S . \
    -DROCWMMA_BUILD_TESTS=OFF \
    -DGPU_TARGETS=gfx1151 \
    -DROCWMMA_BUILD_SAMPLES=OFF \
    --fresh

cmake --build build -t install -- -j16

cd -
