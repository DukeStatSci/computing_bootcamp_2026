# Makefile for Duke Statistical Science Computing Bootcamp 2026

# Define variables
SLIDE_DIR = slides
EXAMPLES_DIR = examples
SLIDE_SOURCES = $(wildcard $(SLIDE_DIR)/*.qmd)
EXAMPLE_SOURCES = $(wildcard $(EXAMPLES_DIR)/*.qmd)
SLIDE_OUTPUTS = $(SLIDE_SOURCES:.qmd=.html)
EXAMPLE_OUTPUTS = $(EXAMPLE_SOURCES:.qmd=.html)

# Default target
.PHONY: all
all: index slides examples

# Render landing page (index.html) and README.md from the same source
.PHONY: index
index: index.html

index.html: index.qmd
	@echo "Rendering $<..."
	quarto render "$<" --to all

# Render all slides
.PHONY: slides
slides: $(SLIDE_OUTPUTS)

# Render all examples
.PHONY: examples  
examples: $(EXAMPLE_OUTPUTS)

# Individual slide targets
$(SLIDE_DIR)/%.html: $(SLIDE_DIR)/%.qmd
	@echo "Rendering $<..."
	quarto render "$<"

# Individual example targets
$(EXAMPLES_DIR)/%.html: $(EXAMPLES_DIR)/%.qmd
	@echo "Rendering $<..."
	quarto render "$<"

# Specific slide targets for convenience
.PHONY: intro repro dcc
intro: $(SLIDE_DIR)/01_introduction_and_resources.html
repro: $(SLIDE_DIR)/02_reproducible_workflows.html
dcc: $(SLIDE_DIR)/03_dcc.html

# Specific example targets
.PHONY: unvotes
unvotes: $(EXAMPLES_DIR)/unvotes.html

# Clean generated files
.PHONY: clean
clean:
	@echo "Cleaning generated files..."
	rm -f index.html
	rm -f $(SLIDE_DIR)/*.html
	rm -f $(EXAMPLES_DIR)/*.html
	rm -f $(SLIDE_DIR)/*_files
	rm -f $(EXAMPLES_DIR)/*_files

# Preview slides (requires quarto preview)
.PHONY: preview
preview:
	@echo "Starting preview server..."
	quarto preview $(SLIDE_DIR)/

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all       - Render landing page, slides, and examples"
	@echo "  index     - Render landing page"
	@echo "  slides    - Render all slide presentations"  
	@echo "  examples  - Render all example documents"
	@echo "  intro     - Render introduction slides"
	@echo "  repro     - Render reproducibility, version control & literate programming slides"
	@echo "  dcc       - Render DCC slides"
	@echo "  unvotes   - Render UN votes example"
	@echo "  clean     - Remove generated HTML files"
	@echo "  preview   - Start Quarto preview server"
	@echo "  help      - Show this help message"