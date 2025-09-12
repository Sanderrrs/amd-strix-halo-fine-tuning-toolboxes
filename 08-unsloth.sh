git clone https://github.com/unslothai/unsloth.git work-area/unsloth
cd work-area/unsloth

. /etc/profile.d/rocm-envs.sh 

pip install . --break-system-packages

pip install unsloth-zoo --break-system-packages

cd -