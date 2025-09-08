git clone https://github.com/ggml-org/llama.cpp.git work-area/llama.cpp
cd work-area/llama.cpp

. ../../envVars

HIPCXX="$(hipconfig -l)/clang" \
    HIP_PATH="$(hipconfig -R)" \
    cmake -S . -B build \
    -DGGML_HIP=ON \
    -DAMDGPU_TARGETS=gfx1151 \
    -DGGML_HIP_ROCWMMA_FATTN=ON \
    -Dhip_HIPCONFIG_EXECUTABLE=/opt/rocm/bin/hipconfig \
    -DCMAKE_BUILD_TYPE=Release \
    --fresh \
    && cmake --build build --config Release -t install -- -j 16


echo "export GGML_CUDA_ENABLE_UNIFIED_MEMORY=1" >> ../envVars

cd -

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/python3.12/dist-packages/_rocm_sdk_libraries_gfx1151/lib/:/usr/local/lib/python3.12/dist-packages/_rocm_sdk_core/lib/