#!/bin/bash
assemble:
	flutter assemble -v -dBuildMode="release" \
		-dTargetPlatform="linux-x64" \
		--output="./build/release" release_bundle_linux-x64_assets 
	cp -r ./build/release/* $(HOME)/.config/yara

