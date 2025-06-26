# Makefile —— AnduinOS build orchestrator
SHELL         := /usr/bin/env bash
.DEFAULT_GOAL := current

SRC_DIR       := src
CONFIG_DIR    := config

DEPS := \
  binutils \
  debootstrap \
  squashfs-tools \
  xorriso \
  grub-pc-bin \
  grub-efi-amd64 \
  grub2-common \
  mtools \
  dosfstools

.PHONY: all fast current clean bootstrap help

help:
	@echo "Usage:"
	@echo "  make          (or make current)   Build current language"
	@echo "  make all                          Build all languages"
	@echo "  make ro_RO                        Build for Romanian language"
	@echo "  make fast                         Build fast config languages"
	@echo "  make clean                        Remove build artifacts"
	@echo "  make bootstrap                    Validate environment and deps"

bootstrap:
	@if [ "$$(id -u)" -eq 0 ]; then \
	  echo "Error: Do not run as root"; \
	  exit 1; \
	fi
	@if ! lsb_release -i | grep -qE "(Ubuntu|Debian|Tuxedo|AnduinOS)"; then \
	  echo "Error: Unsupported OS — only Ubuntu, Debian, Tuxedo or AnduinOS allowed"; \
	  exit 1; \
	fi

	@missing="" ; \
	for pkg in $(DEPS); do \
	  if ! dpkg -s $$pkg >/dev/null 2>&1; then \
	    missing="$$missing $$pkg"; \
	  fi; \
	done; \
	if [ -n "$$missing" ]; then \
	  echo "Missing packages:$$missing"; \
	  echo "Installing missing dependencies..."; \
	  sudo apt-get update && sudo apt-get install -y$$missing; \
	else \
	  echo "[MAKE] All required packages are already installed."; \
	fi

current: bootstrap
	@echo "[MAKE] Building current language..."
	@cd $(SRC_DIR) && ./build.sh

ar_SA: bootstrap
	@echo "[MAKE] Building for Arabic language (ar_SA.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/ar_SA.json

de_DE: bootstrap
	@echo "[MAKE] Building for German language (de_DE.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/de_DE.json

en_GB: bootstrap
	@echo "[MAKE] Building for English language (en_GB.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/en_GB.json

en_US: bootstrap
	@echo "[MAKE] Building for English language (en_US.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/en_US.json

es_ES: bootstrap
	@echo "[MAKE] Building for Spanish language (es_ES.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/es_ES.json

fr_FR: bootstrap
	@echo "[MAKE] Building for French language (fr_FR.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/fr_FR.json

it_IT: bootstrap
	@echo "[MAKE] Building for Italian language (it_IT.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/it_IT.json

ja_JP: bootstrap
	@echo "[MAKE] Building for Japanese language (ja_JP.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/ja_JP.json

ko_KR: bootstrap
	@echo "[MAKE] Building for Korean language (ko_KR.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/ko_KR.json

nl_NL: bootstrap
	@echo "[MAKE] Building for Nederlands language (nl_NL.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/nl_NL.json

pl_PL: bootstrap
	@echo "[MAKE] Building for Polish language (pl_PL.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/pl_PL.json

pt_BR: bootstrap
	@echo "[MAKE] Building for Portuguese language (pt_BR.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/pt_BR.json

pt_PT: bootstrap
	@echo "[MAKE] Building for Portuguese language (pt_PT.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/pt_PT.json

ro_RO: bootstrap
	@echo "[MAKE] Building for Romanian language (ro_RO.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/ro_RO.json

ru_RU: bootstrap
	@echo "[MAKE] Building for Russian language (ru_RU.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/ru_RU.json

sv_SE: bootstrap
	@echo "[MAKE] Building for Swedish language (sv_SE.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/sv_SE.json

th_TH: bootstrap
	@echo "[MAKE] Building for Thai language (th_TH.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/th_TH.json

tr_TR: bootstrap
	@echo "[MAKE] Building for Turkish language (tr_TR.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/tr_TR.json

vi_VN: bootstrap
	@echo "[MAKE] Building for Vietnamese language (vi_VN.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/vi_VN.json

zh_CN: bootstrap
	@echo "[MAKE] Building for Chinese language (zh_CN.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/zh_CN.json

zh_HK: bootstrap
	@echo "[MAKE] Building for Chinese language (zh_HK.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/zh_HK.json

zh_TW: bootstrap
	@echo "[MAKE] Building for Chinese language (zh_TW.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/zh_TW.json

all: bootstrap
	@echo "[MAKE] Building ALL languages (all.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/all.json

fast: bootstrap
	@echo "[MAKE] Building FAST languages (fast.json)..."
	@./build_all.sh -c $(CONFIG_DIR)/fast.json

clean:
	@echo "[MAKE] Cleaning build artifacts..."
	@./clean_all.sh
	@echo "[MAKE] Clean complete."
