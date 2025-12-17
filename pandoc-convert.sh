#!/bin/sh

if [ $# -eq 1 ]; then
    INPUT_FILE=$1

    if [ -z "$INPUT_FILE" ]; then
        echo "Error: Input file not specified."
        echo "Usage: docker run <image_name> <input_file.md> [output_dir]"
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
        --number-sections \
        --template=toc-sidebar.html \
        --filter pandoc-plantuml-filter \
        --syntax-highlighting=pygments \
        -t html5 \
        -o "$OUTPUT_FILE"

    if [ $? -eq 0 ]; then
        echo "---"
        echo "Conversion completed: $OUTPUT_FILE"
    else
        echo "---"
        echo "Error occurred during conversion."
        exit 1
    fi

elif [ $# -eq 2 ]; then
    INPUT_DIR=$1
    OUTPUT_DIR=$2

    if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
        echo "Error: Input directory and output directory must be specified."
        echo "Usage: docker run <image_name> <input_dir> <output_dir>"
        exit 1
    fi

    # Create output directory if it doesn't exist
    mkdir -p "$OUTPUT_DIR"

    echo "Input Directory: $INPUT_DIR"
    echo "Output Directory: $OUTPUT_DIR"
    echo "---"

    # Find all .md files in the input directory and subdirectories
    find "$INPUT_DIR" -name "*.md" -type f | while read -r file; do
        # Get the relative path from input directory
        REL_PATH=${file#$INPUT_DIR/}
        # Change extension from .md to .html
        OUTPUT_FILE="$OUTPUT_DIR/${REL_PATH%.md}.html"
        # Create subdirectory in output if needed
        OUTPUT_SUBDIR=$(dirname "$OUTPUT_FILE")
        mkdir -p "$OUTPUT_SUBDIR"

        echo "Converting: $file -> $OUTPUT_FILE"

        # Execute Pandoc conversion
        pandoc "$file" \
            --standalone \
            --toc \
            --toc-depth=6 \
            --template=toc-sidebar.html \
            --filter pandoc-plantuml-filter \
            --syntax-highlighting=pygments \
            -t html5 \
            -o "$OUTPUT_FILE"

        if [ $? -eq 0 ]; then
            echo "Conversion completed: $OUTPUT_FILE"
        else
            echo "Error occurred during conversion of $file"
        fi
    done

    echo "---"
    echo "All conversions completed."

else
    echo "Error: Invalid number of arguments."
    echo "Usage: docker run <image_name> <input_file.md> [output_dir]"
    echo "   or: docker run <image_name> <input_dir> <output_dir>"
    exit 1
fi