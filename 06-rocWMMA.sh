git clone https://github.com/ROCm/rocWMMA work-area/rocWMMA
cd work-area/rocWMMA

CC=/opt/rocm/lib/llvm/bin/amdclang \
    CXX=/opt/rocm/lib/llvm/bin/amdclang++ \
    cmake -B build -S . \
    -DROCWMMA_BUILD_TESTS=OFF \
    -DGPU_TARGETS=gfx1151 \
    -Dhip_HIPCONFIG_EXECUTABLE=/opt/rocm/bin/hipconfig \
    -DROCWMMA_BUILD_SAMPLES=OFF

cmake --build build -t install -- -j16

cd -