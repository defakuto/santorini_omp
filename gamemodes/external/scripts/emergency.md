# Blinkers Script Documentation

## Overview
This script implements a blinkers feature for vehicles in the game. Players can activate or deactivate blinkers for their vehicles using a command.

## Features
- **Blinker Activation**: Players can activate blinkers for their vehicles to indicate turning intentions.
- **Blinker Deactivation**: Players can deactivate blinkers for their vehicles when no longer needed.
- **Dynamic Object Creation**: Creates dynamic objects representing blinkers attached to vehicles.
- **Player Connection Handling**: Initializes blinker status for players upon connection to the server.

## Implementation Details
- **Blinker Array**: Tracks blinker state for each vehicle separately to manage blinker activation and deactivation.
- **Command Usage**: Players can use the `/blinkers` command to toggle blinkers for their vehicles.
- **Dynamic Object Attachment**: Attaches a dynamic object representing the blinker to the vehicle when activated.
- **Object Destruction**: Destroys the blinker object when the blinkers are deactivated.

## Usage
- Players can use the `/blinkers` command to activate or deactivate blinkers for their vehicles.
- Test the script thoroughly to ensure that blinkers are correctly activated and deactivated for vehicles.
- Adjust the blinker object creation and attachment coordinates as needed to ensure proper positioning relative to vehicles.

## Notes
- Verify that the object IDs and attachment positions are suitable for representing blinkers on vehicles.
- Ensure that the script handles edge cases and invalid scenarios gracefully to avoid unexpected behavior.

