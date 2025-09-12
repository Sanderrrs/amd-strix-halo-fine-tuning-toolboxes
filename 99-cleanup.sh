
rm -rf work-area

pip uninstall --break-system-packages -y rocm-sdk-devel

pip cache purge --no-input

apt remove --purge --autoremove -y \
    python3-dev \
    build-essential 

