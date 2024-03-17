# Hour Benefit System Documentation

## Overview
This documentation outlines an hourly bonus system implemented in Pawn for a gamemode. The system rewards players with in-game currency and score points every hour they spend in the game.

## Features
- Grants players an hourly bonus of $500 and 1 score point.
- Automatically triggers every hour to reward active players.

## Code Structure

### Static Variables
- `player_Score`: Array to store player scores.
- `player_Money`: Array to store player money balances.

### Hooks
- `Account_Load`: Loads player account data, including scores and money balances.
- `OnGameModeInit`: Initializes the hourly bonus system and sets up a timer to trigger the bonus.
- `HourBenefit`: Grants the hourly bonus to players, updating their scores and money balances.

## Usage
1. Players receive the hourly bonus automatically after spending an hour in the game.
2. The bonus includes $500 and 1 score point for each player.
3. Player scores and money balances are updated accordingly after receiving the bonus.

## Notes
- Ensure the timer interval for the hourly bonus aligns with game balance and pacing.
- Customize the bonus amount and type of rewards as per game design requirements.
- Handle any edge cases or error scenarios to maintain fair gameplay.

