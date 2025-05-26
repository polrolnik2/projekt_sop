# Makefile for running main.sh and comparing output with reference
SHELL := /bin/bash
MAIN_SCRIPT=./main
MAIN_INPUT=./test/overlap_detector_base
MAIN_THRESHOLD=2
OUTPUT_DIR=output
OUTPUT=output.json
REFERENCE=expected/test1.txt

.PHONY: all run test clean

all: test

run:
	mkdir -p $(OUTPUT_DIR)
	bash $(MAIN_SCRIPT) $(MAIN_THRESHOLD) $(MAIN_INPUT) | tee $(OUTPUT_DIR)/$(OUTPUT)

test: run
	@echo "Comparing output with reference..."
	@if diff -B $(REFERENCE) $(OUTPUT_DIR)/$(OUTPUT) > /dev/null; then \
		echo "PASS: Output matches reference."; \
	else \
		echo "FAIL: Output does not match reference." >&2; \
		exit 1; \
	fi

clean:
	rm -f $(OUTPUT)