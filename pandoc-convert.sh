#!/bin/sh

INPUT_FILE=$1

if [ -z "$INPUT_FILE" ]; then
    echo "Error: Input file not specified."
    echo "Usage: docker run <image_name> <input_file.md>"
    exit 1
fi

OUTPUT_FILE=$(basename "$INPUT_FILE" | sed 's/\(.*\)\..*/\1.html/')

echo "Input File: $INPUT_FILE"
echo "Output File: $OUTPUT_FILE"
echo "---"

# Execute Pandoc conversion using the custom template
# --template=toc-sidebar.html: Use the downloaded template
# --self-contained: Embed the template's CSS, PlantUML output, etc., for offline use
# --toc: Required by the template to generate the TOC data
pandoc "$INPUT_FILE" \
    --standalone \
    --toc \
    --toc-depth=6 \
    --template=toc-sidebar.html \
    --filter pandoc-plantuml-filter \
    --syntax-highlighting=pygments \
    -t html5 \
    -o "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "---"
    echo "🎉 Conversion completed: $OUTPUT_FILE"
else
    echo "---"
    echo "🚨 Error occurred during conversion."
    exit 1
fi