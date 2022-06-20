#!/bin/sh

git submodule update --init --recursive
vim -c VundleUpdate -c quitall
