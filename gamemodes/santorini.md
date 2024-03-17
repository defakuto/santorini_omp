# Santorini Gamemode Documentation

## Overview
This is the documentation for the Santorini gamemode. It provides details about the features, implementation, and usage of various scripts included in the gamemode.

## Main Function
The main function of the gamemode is responsible for initializing and starting the game. It displays information about the founder, version, and status of the gamemode.

## Included Scripts
The Santorini gamemode includes several scripts organized into different categories:

### Additional Setup
- **connector.inc**: Includes a connector file for external dependencies.

### Initial Setup
- **colors.pwn**: Sets up color configurations for the game.
- **settings.pwn**: Initializes game settings and configurations.
- **accounts.pwn**: Manages player accounts and data.
- **staffteam.pwn**: Handles staff team functionalities.
- **vehicle.pwn**: Implements vehicle-related features.
- **hourbenefit.pwn**: Provides benefits based on playtime.
- **speedometer.pwn**: Displays the speedometer for vehicles.
- **driftmeter.pwn**: Tracks and displays drifting statistics.
- **time.pwn**: Manages in-game time and day-night cycles.

### Gameplay Scripts
- **teams.pwn**: Implements team functionalities for players.
- **wanted.pwn**: Manages player wanted levels and law enforcement interactions.
- **racewar.pwn**: Sets up and manages race wars between players.
- **parrot.pwn**: Implements a pet system where players can have a parrot companion.
- **emergency.pwn**: Handles emergency situations and responses.

### Maps
- **bayside.pwn**: Contains map-specific functionalities and setups for the Bayside area.

## Commands
The gamemode provides several commands for players to interact with the game:
- **/weapon**: Gives the player an M4 weapon with 100 ammunition.
- **/money**: Grants the player $20,000 in-game currency.
- **/kill**: Sets the player's health to zero, effectively killing them.

## Usage
Players can use the provided commands to access various features and functionalities within the game. Additionally, they can engage in team activities, participate in race wars, manage their wanted level, and interact with NPCs and pets.

## Notes
- Ensure that all scripts are properly configured and integrated into the gamemode.
- Test each functionality thoroughly to verify its accuracy and functionality.
- Monitor player feedback and adjust gameplay elements as necessary to ensure a balanced and enjoyable experience.
