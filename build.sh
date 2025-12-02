#!/usr/bin/env bash

WORKING_DIR="$PWD"
git pull origin custom

mkdir builddir
flatpak run --command=flathub-build org.flatpak.Builder --force-clean \
                --user \
                --install-deps-from=flathub \
                --repo=repo \
                --install \
                $WORKING_DIR/org.signal.Signal.yaml
