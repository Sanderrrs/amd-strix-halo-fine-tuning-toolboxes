git clone https://github.com/Dao-AILab/flash-attention.git work-area/flash-attention
cd work-area/flash-attention

FLASH_ATTENTION_TRITON_AMD_ENABLE="TRUE" python setup.py install

cd -

echo "export FLASH_ATTENTION_TRITON_AMD_ENABLE=TRUE" >> envVars
echo "export TRITON_HIP_LLD_PATH=/opt/rocm/lib/llvm/bin/ld.lld" >> envVars