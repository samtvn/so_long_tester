#!/bin/bash

MAP_DIR="resources/maps"
VALID_MAP="resources/maps/map.ber"
VALGRIND="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --quiet"
EXECUTABLE_PATH="../so_long"

for map in "$MAP_DIR"/broken*.ber; do
    if [ -f "$map" ]; then
        echo "Launching ./so_long with map: $map"
        $VALGRIND $EXECUTABLE_PATH "$map" 2>&1 | sed $'s/^/\033[31m/' | sed $'s/$/\033[0m/'
    fi
done

echo "Launching ./so_long without arguments"
$VALGRIND $EXECUTABLE_PATH 2>&1 | sed $'s/^/\033[31m/' | sed $'s/$/\033[0m/'

echo "Launching ./so_long with > 1 argument"
$VALGRIND $EXECUTABLE_PATH $VALID_MAP other 2>&1 | sed $'s/^/\033[31m/' | sed $'s/$/\033[0m/'

echo "Launching ./so_long with unexisting file"
$VALGRIND $EXECUTABLE_PATH awesome_map.ber 2>&1 | sed $'s/^/\033[31m/' | sed $'s/$/\033[0m/'

echo "Launching ./so_long with valid map: $MAP, simulating ESC exit"
$VALGRIND $EXECUTABLE_PATH "$VALID_MAP" &
PID=$!
echo "Press ESC to exit the game"
wait $PID

echo "Launching ./so_long with valid map: $MAP, simulating close button exit"
$VALGRIND $EXECUTABLE_PATH "$VALID_MAP" &
PID=$!
echo "Press window X button to exit the game"
wait $PID

echo "Launching ./so_long with valid map: $MAP"
$VALGRIND $EXECUTABLE_PATH "$VALID_MAP" 2>&1 | sed $'s/^/\033[31m/' | sed $'s/$/\033[0m/'
