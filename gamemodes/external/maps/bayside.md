# Game Initialization and Construction Documentation

## Overview
This script handles the initialization of the gamemode and the construction of various dynamic objects and structures in the game world.

## Features
- **OnGameModeInit Hook**: Initializes the gamemode and constructs dynamic objects such as buildings, structures, and decorations.
- **OnPlayerConnect Hook**: Removes specific buildings and structures for players upon connection to the server.

## Construction Details
- **OnGameModeInit Hook**: Constructs various dynamic objects and structures in the game world, including buildings, decorations, and other elements.
- **OnPlayerConnect Hook**: Removes specific buildings and structures for players upon connection to the server to customize the game environment.

## Usage
- Ensure that the construction coordinates and object IDs are configured correctly to place dynamic objects and remove buildings accurately.
- Test the script thoroughly to ensure that the constructed objects are placed correctly and the buildings are removed as intended.

## Notes
- Coordinate values and object IDs may need to be adjusted based on the game world layout and desired customization.
- Verify that the building removal coordinates accurately target the buildings intended for removal to avoid unintended changes to the game environment.

