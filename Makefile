IBEX_CONFIG ?= small

FUSESOC_CONFIG_OPTS = $(shell ./util/ibex_config.py $(IBEX_CONFIG) fusesoc_opts)

all: help

.PHONY: help
help:
	@echo "This is a short hand for running popular tasks."
	@echo "Please check the documentation on how to get started"
	@echo "or how to set-up the different environments."

# Arty A7 FPGA example
# Use the following targets (depending on your hardware):
# - "build-arty-35"
# - "build-arty-100"
# - "program-arty"
zedboard-sw-program = sw/led/led.vmem
sw-led: $(zedboard-sw-program)

.PHONY: $(zedboard-sw-program)
$(zedboard-sw-program):
	cd sw/led && $(MAKE)

.PHONY: build-zedboard
build-zedboard: sw-led
	fusesoc --cores-root=. run --target=synth --setup --build lowrisc:ibex:top_zedboard

.PHONY: program-zedboard
program-zedboard:
	fusesoc --cores-root=. run --target=synth --run lowrisc:ibex:top_zedboard


