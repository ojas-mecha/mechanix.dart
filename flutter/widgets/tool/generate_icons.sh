#!/usr/bin/env bash

set -e

echo "Generating MechanixIcons icon font from SVG assets..."

# Ensure we run from the package root directory
cd "$(dirname "$0")/.."

# Execute icon_font_generator CLI
dart run icon_font_generator:generator \
  assets/icons/svg \
  assets/fonts/MechanixIcons.ttf \
  --output-class-file=lib/src/icons/mechanix_icons.dart \
  --class-name=MechanixIcons \
  --font-name=MechanixIcons \
  --package=mechanix_widgets

if [ $? -eq 0 ]; then
    echo "✓ MechanixIcons successfully generated!"
else
    echo "✗ Failed to generate MechanixIcons" >&2
    exit 1
fi
