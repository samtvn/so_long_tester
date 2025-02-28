#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
MAP_DIR="$SCRIPT_DIR/maps"
VALID_MAP="$MAP_DIR/map.ber"
VALGRIND="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --quiet"
EXECUTABLE_PATH="$SCRIPT_DIR/../so_long"

# Function to print errors in red
print_red() {
    tput setaf 1  # Set text color to red
    echo "$1"
    tput sgr0     # Reset text formatting
}

for map in "$MAP_DIR"/broken*.ber; do
    if [ -f "$map" ]; then
        echo "Launching ./so_long with map: $map"
        output=$($VALGRIND $EXECUTABLE_PATH "$map" 2>&1)
        print_red "$output"
    fi
done

echo "Launching ./so_long without arguments"
output=$($VALGRIND $EXECUTABLE_PATH 2>&1)
print_red "$output"

echo "Launching ./so_long with > 1 argument"
output=$($VALGRIND $EXECUTABLE_PATH $VALID_MAP other 2>&1)
print_red "$output"

echo "Launching ./so_long with unexisting file"
output=$($VALGRIND $EXECUTABLE_PATH awesome_map.ber 2>&1)
print_red "$output"

echo "Launching ./so_long with valid map: $VALID_MAP, simulating ESC exit"
output=$($VALGRIND $EXECUTABLE_PATH "$VALID_MAP" 2>&1)
print_red "$output"

echo "Launching ./so_long with valid map: $VALID_MAP, simulating close button exit"
output=$($VALGRIND $EXECUTABLE_PATH "$VALID_MAP" 2>&1)
print_red "$output"

echo "Launching ./so_long with valid map: $VALID_MAP"
output=$($VALGRIND $EXECUTABLE_PATH "$VALID_MAP" 2>&1)
print_red "$output"
