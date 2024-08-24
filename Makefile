TESTS_INIT=tests/minimal.lua
TESTS_DIR=tests/

.PHONY: all
all: lint format test

.PHONY: lint
lint: 
	@luacheck lua/ --globals vim
	@luacheck tests/ --globals vim

.PHONY: format 
format: 
	@stylua --check lua/ --config-path="stylua.toml"
	@stylua --check tests/ --config-path="stylua.toml"

.PHONY: test
test:
	@nvim \
		--headless \
		--noplugin \
		-u ${TESTS_INIT} \
		-c "PlenaryBustedDirectory ${TESTS_DIR} { minimal_init = '${TESTS_INIT}' }" \
