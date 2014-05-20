#!/bin/bash
set -e
source /build/buildconfig
set -x

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
if [[ "$final" = 1 ]]; then
	rm -rf /build
else
	rm -f /build/runit/*
	rm -f /build/config/*.conf
	rm -f /build/{install,enable_repos,prepare,finalize,packages,configure}.sh
	rm -f /build/{Dockerfile,README.md,buildconfig,insecure_key*}
fi
