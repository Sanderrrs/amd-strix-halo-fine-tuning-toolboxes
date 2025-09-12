git clone https://github.com/Dao-AILab/flash-attention.git work-area/flash-attention
cd work-area/flash-attention

. /etc/profile.d/rocm-envs.sh 

FLASH_ATTENTION_TRITON_AMD_ENABLE="TRUE" python setup.py install

cd -

echo "export FLASH_ATTENTION_TRITON_AMD_ENABLE=TRUE" >> /etc/profile.d/rocm-envs.sh 
echo "export TRITON_HIP_LLD_PATH=/opt/rocm/lib/llvm/bin/ld.lld" >> /etc/profile.d/rocm-envs.sh 