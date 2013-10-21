#!/bin/sh
# Compile and optimize JS code
# Copyright 2013 Lu Wang <coolwanglu@gmail.com>

# To enable closure-compiler, you need to install and configure JAVA environment
# Read 3rdparty/closure-compiler/README for details


BASEDIR=$(dirname $0)
CLOSURE_COMPILER_DIR="$BASEDIR/../../3rdparty/closure-compiler"
OUTPUT="$BASEDIR/../pdf2htmlEX.js"

(echo 'Building pdf2htmlEX.js with closure-compiler...' && \
    java -jar "$CLOSURE_COMPILER_DIR/compiler.jar" \
         --compilation_level ADVANCED_OPTIMIZATIONS \
         --process_jquery_primitives \
         --externs "$CLOSURE_COMPILER_DIR/jquery-1.9.js" \
         --js "$BASEDIR/header.js" \
         --js "$BASEDIR/css_class_names.js" \
         --js "$BASEDIR/viewer.js" \
         --js_output_file "$OUTPUT" 2>/dev/null && \
    echo 'Done.') || \
(echo 'Failed. Read `3rdparty/closure-compiler/README` for more detail.' && \
echo 'Fall back to naive concatenation' && \
cat "$BASEDIR/header.js" "$BASEDIR/css_class_names.js" "$BASEDIR/viewer.js" > "$OUTPUT")
