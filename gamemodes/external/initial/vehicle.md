# Vehicle Control System Documentation

## Overview
This script provides functionality to control vehicle engine and lights for players in the game.

## Features
- Engine and lights control: Players can toggle vehicle engine and lights on or off.
- Visual feedback: Players receive visual feedback about the state of the engine and lights.
- Bicycle support: Bicycles are identified and exempt from engine and light control.

## Commands and Usage
- **Engine Control**: Players can toggle the vehicle engine on or off by pressing the 'N' key while driving.
- **Lights Control**: Players can toggle the vehicle lights on or off by pressing the 'Y' key while driving.

## Implementation Details
- **OnVehicleSpawn Hook**: When a vehicle spawns, the script ensures that its parameters are properly set based on whether it's a bicycle or not.
- **OnPlayerKeyStateChange Hook**: Handles player input for toggling engine and lights.
- **OnPlayerStateChange Hook**: Provides visual feedback to players about starting the engine when they enter a vehicle.
- **IsVehicleBicycle Function**: Identifies whether a vehicle is a bicycle based on its model.

## Notes
- Ensure proper configuration of key bindings in the game to avoid conflicts with other scripts or default game actions.
- The script assumes that the 'N' key starts or stops the engine, and the 'Y' key toggles the lights. Modify key bindings if necessary.

