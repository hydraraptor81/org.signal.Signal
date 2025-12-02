#!/usr/bin/env bash

git pull origin custom

mkdir builddir
flatpak-builder --force-clean \
                --user \
                --gpg-sign=32F09FD9A40A60E2CCAB6AEA0E3C43AB6D369AB7 \
                --install-deps-from=flathub \
                --repo=repo \
                --install \
                builddir \
                org.signal.Signal.yaml
