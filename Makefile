.PHONY:all
all: test

.PHONY:clean
clean:
	@rm -r out/ || true

##################
# Code
##################

.PHONY:fmt
fmt:
	@npm run solium

.PHONY:test-contracts
test-contracts:
	@npm test

# TODO: get tests to pass in coverage env
.PHONY:test-contracts-coverage
test-contracts-coverage:
	@npm run coverage
