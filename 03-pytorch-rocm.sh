# cd TheRock/external-builds/pytorch/

# python pytorch_torch_repo.py checkout
# python pytorch_audio_repo.py checkout
# python pytorch_vision_repo.py checkout


# python build_prod_wheels.py build \
#   --pytorch-rocm-arch gfx1151 \
#   --output-dir build/dist


python -m pip install --break-system-packages \
  --index-url https://rocm.nightlies.amd.com/v2/gfx1151/  \
  torch \
  torchvision \
  pytorch-triton-rocm 

