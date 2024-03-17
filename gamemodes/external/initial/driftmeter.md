# Drift Point System Documentation

## Overview
This documentation describes a drift point system implemented in Pawn for a gamemode. The system tracks and rewards players for successful drifts performed in vehicles.

## Features
- Tracks player drifts and awards drift points based on angle, speed, and vehicle control.
- Saves player drift points and updates their in-game currency balance accordingly.
- Provides a textdraw interface to display current drift points to players.

## Code Structure

### Constants
- `DRIFT_MIN_ANGLE`: Minimum angle threshold for a drift to be considered.
- `DRIFT_MAX_ANGLE`: Maximum angle threshold for a drift to be considered.
- `DRIFT_SPEED`: Minimum speed threshold for a drift to be considered.

### Textdraw
- `DriftTD`: Textdraw object for displaying current drift points to players.

### Hooks
- `Account_Load`: Loads player account data, including their in-game currency balance.
- `OnGameModeInit`: Initializes the drift point system and sets up timers for updating drift points.
- `OnPlayerConnect`: Hides the drift points textdraw when a player connects.
- `OnPlayerUpdate`: Hides the drift points textdraw when a player is not in a vehicle.
- `OnPlayerStateChange`: Shows the drift points textdraw when a player enters a vehicle.

### Functions
- `AngleUpdate`: Updates player positions for angle calculations.
- `GetPlayerTheoreticAngle`: Calculates the theoretical angle of a player's movement.
- `DriftSummary`: Handles the summary of drift points earned by a player and updates their account data.
- `ReturnPlayerAngle`: Returns the angle of a player's facing direction.
- `DriftCount`: Counts and calculates drift points for each player.

## Usage
1. Players earn drift points when they perform drifts in vehicles.
2. Drift points are displayed to players using the textdraw `DriftTD`.
3. Players' in-game currency balance is updated based on their drift points.
4. Adjust drift point thresholds and reward calculations as needed for game balance.

## Notes
- Ensure proper handling of timers and account data to prevent exploits or inconsistencies.
- Customize textdraw appearance and positioning according to your gamemode's UI design.

