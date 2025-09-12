#/bin/bash

ROCM_PATH="$(find /usr -type d -name _rocm_sdk_core)"
ROCM_BIN_PATH="$ROCM_PATH/bin/"
ROCM_DEVICE_LIBS="$(find /usr -type d -name _rocm_sdk_libraries_gfx1151)/lib"

ROCM_SDK_PATH=$(rocm-sdk path --root 2>/dev/null)

if [ "$ROCM_SDK_PATH" != "" ];
then
    ROCM_PATH=$(rocm-sdk path --root 2>/dev/null)
    ROCM_BIN_PATH=$(rocm-sdk path --bin 2>/dev/null)
fi


export ROCM_PATH="$ROCM_PATH"
export HIP_PLATFORM="amd"
export HIP_PATH="$ROCM_PATH"
export HIP_INCLUDE_PATH="$ROCM_PATH/include"
export HIP_LIB_PATH="$ROCM_PATH/lib"

# Set HIP compiler paths using rocm-sdk detected paths
# Note: clang++ is actually in lib/llvm/bin, not the main bin directory
export HIP_CLANG_PATH="$ROCM_PATH/lib/llvm/bin"
export HIP_CLANG_LIB_PATH="$ROCM_PATH/lib/llvm/lib"
export HIP_DEVICE_LIB_PATH="$ROCM_PATH/lib/llvm/amdgcn/bitcode"

export CXX="$HIP_CLANG_PATH/amdclang++"
export CC="$HIP_CLANG_PATH/amdclang"

# Set PATH and library paths using rocm-sdk detected paths
export PATH="$ROCM_BIN_PATH:$PATH"
export LD_LIBRARY_PATH="$ROCM_PATH/lib:$ROCM_PATH/lib64:/usr/local/lib:$HIP_CLANG_LIB_PATH:$ROCM_DEVICE_LIBS:\$LD_LIBRARY_PATH"
export LIBRARY_PATH="$ROCM_PATH/lib:$ROCM_PATH/lib64:\$LIBRARY_PATH"

export CPATH="$ROCM_PATH/include:\$CPATH"
export PKG_CONFIG_PATH="$ROCM_PATH/lib/pkgconfig:\$PKG_CONFIG_PATH"

# Set debugging and device variables
# export AMD_SERIALIZE_KERNEL="3"
# export HIP_VISIBLE_DEVICES="0"
export HIP_ARCH="gfx1151"  # Strix Halo architecture