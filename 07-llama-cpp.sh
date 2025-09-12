git clone https://github.com/ggml-org/llama.cpp.git work-area/llama.cpp
cd work-area/llama.cpp

. /etc/profile.d/rocm-envs.sh 

HIPCXX="$(hipconfig -l)/clang" \
    HIP_PATH="$(hipconfig -R)" \
    cmake -S . -B build \
    -DGGML_HIPBLAS=on \
    -DGGML_HIP=ON \
    -DAMDGPU_TARGETS=gfx1151 \
    -DGGML_HIP_ROCWMMA_FATTN=ON \
    -DCMAKE_BUILD_TYPE=Release \
    --fresh \
    && cmake --build build --config Release -t install -- -j 16


echo "export GGML_CUDA_ENABLE_UNIFIED_MEMORY=1" >> /etc/profile.d/rocm-envs.sh 

cd -

