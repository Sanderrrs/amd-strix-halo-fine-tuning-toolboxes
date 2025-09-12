# Makefile

MAKEFILE_NAME := $(lastword $(MAKEFILE_LIST))

.PHONY: help theRock pytorch bitsandbytes flash-attn rocWMMA llama-cpp unsloth

help: ## Prints all available targets
	@echo "Available targets:"
	@grep -E '^[a-zA-Z0-9_.-]+:.*?##' Makefile \
		| sed -E 's/^([a-zA-Z0-9_.-]+):.*?## ?(.*)/  \1: \2/' \
		| sort

# install-packages: ## Installs required packages
# 	@echo "Installing Packages"
# 	@bash ./01-install-packages.sh

theRock: ## Installs ROCm in /opt/rocm from theRock Nightly
	@echo "Installing ROCm nightly from TheRock"
	@bash ./02-setup-theRock.sh

pytorch: theRock ## Installs torch torchvision torchaudio pytorch-triton-rcom from ROCm nightly
	@echo "Installing pytorch"
	@bash ./03-pytorch-rocm.sh

bitsandbytes: pytorch ##Install bitsandbytes from source
	@echo "Installing bitsandbytes"
	@bash ./04-bitsandbytes.sh

flash-attn: pytorch ##Install flash-attn from source
	@echo "Installing flash-attn"
	@bash ./05-flash-attn.sh

rocWMMA: theRock ##Installs rocWMMA library from source
	@echo "Installing rocWMMA"
	@bash ./06-rocWMMA.sh

llama-cpp: rocWMMA ##Installs llama.cpp from source
	@echo "Installing llama.cpp"
	@bash ./07-llama-cpp.sh

unsloth: flash-attn bitsandbytes ##Installs unsloth from source
	@echo "Installing unsloth"
	@bash ./08-unsloth.sh

clean: ##Clean unwanted packages after build
	@echo "Cleaning up"
	@bash ./99-cleanup.sh

all: llama-cpp unsloth ##Installs everything

