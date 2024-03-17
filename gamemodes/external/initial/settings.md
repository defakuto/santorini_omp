# Settings Configuration Documentation

## Overview
This documentation provides information about the settings configuration implemented in Pawn for a gamemode. The configuration includes key macros and event hooks for player connection and spawning.

## Features
- Defines macros for checking key presses using bitwise operations.
- Sets up event hooks for player connection and spawning.

## Code Structure

### Macros
- `PRESSED(%0)`: Macro to check if a specific key is pressed using bitwise operations.

### Hooks
- `OnPlayerConnect`: Ensures that players are not spectating upon connection and sets their color to default.
- `OnPlayerSpawn`: Sets players' team to no team upon spawning.

## Usage
1. Use the `PRESSED(%0)` macro to check for specific key presses in the game logic.
2. Implement additional functionality within the provided event hooks to customize player connection and spawning behavior.

## Notes
- Ensure compatibility with the YSI Coding library version specified.
- Customize event hook functionality as needed to fit your gamemode requirements.
- Document any additional settings or configurations relevant to your gamemode.

