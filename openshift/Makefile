DETECT_RELEASE_YAML_PIPELINE=$(shell bash latest-release.sh pipeline)
STABLE_RELEASE_YAML_PIPELINE=$(shell bash latest-release.sh pipeline --only-stable-release)
RELEASE_YAML_PIPELINE=

DETECT_RELEASE_YAML_TRIGGERS=$(shell bash latest-release.sh triggers)
STABLE_RELEASE_YAML_TRIGGERS=$(shell bash latest-release.sh triggers --only-stable-release)
RELEASE_YAML_TRIGGERS=
# Turn the modules on as we're using `-mod=vendor` flag while building the binaries
# and the source code is cloned under $GOPATH
export GO111MODULE=on

# Temporary hack to use the stable release if nightly doesn't exist, in case release fails
test-e2e-downstream-nightly:
	make test-e2e-downstream RELEASE_YAML_PIPELINE=$(DETECT_RELEASE_YAML_PIPELINE) RELEASE_YAML_TRIGGERS=$(DETECT_RELEASE_YAML_TRIGGERS)
.PHONY: test-e2e-downstream-nightly

test-e2e-downstream-stable:
	@make test-e2e-downstream RELEASE_YAML_PIPELINE=$(STABLE_RELEASE_YAML_PIPELINE) RELEASE_YAML_TRIGGERS=$(STABLE_RELEASE_YAML_TRIGGERS)
.PHONY: test-e2e-downstream-stable

test-e2e-downstream:
	@make -C ../ bin/tkn
	@env \
		RELEASE_YAML_PIPELINE=$(RELEASE_YAML_PIPELINE) \
		RELEASE_YAML_TRIGGERS=$(RELEASE_YAML_TRIGGERS) \
		LOCAL_CI_RUN=true \
		../test/e2e-tests.sh
.PHONY: test-e2e-downstream
