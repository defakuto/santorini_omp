# Wanted System Documentation

## Overview
This script implements a wanted system in the game. Players can accumulate a wanted level by committing crimes within certain areas monitored by cameras. They can also bribe law enforcement to clear their wanted level.

## Features
- **Wanted Level**: Players accumulate a wanted level by committing crimes within monitored areas.
- **Bribery Option**: Players can bribe law enforcement to clear their wanted level for a fee.
- **Crime Monitoring**: Crimes are detected within specific areas monitored by cameras.
- **Interaction with NPCs**: Law enforcement NPCs respond to player actions and offer the option to bribe.

## Implementation Details
- **Wanted Level Management**: Tracks the wanted level of each player and updates it based on their actions.
- **Camera Monitoring**: Checks if players are within range of monitored areas and increases their wanted level accordingly.
- **Bribery System**: Allows players to interact with an NPC to clear their wanted level for a fee.
- **Persistence**: Stores player wanted levels in an INI file to maintain their status across sessions.
- **Animation Effects**: Applies animation effects to NPCs and players during interactions.

## Usage
- Players can accumulate a wanted level by committing crimes within monitored areas.
- Law enforcement NPCs offer the option to bribe to clear a player's wanted level.
- Using the `/bribe` command, players can interact with the law enforcement NPC to clear their wanted level for a fee.
- Checkpoints are set up to monitor specific areas where crimes can be committed.
- Player wanted levels persist across sessions and are stored in an INI file.

## Notes
- Ensure that the areas monitored by cameras cover key locations where crimes may occur.
- Adjust the bribe amount and other parameters as needed to balance gameplay.
- Test the script thoroughly to verify that wanted level accumulation, bribery, and persistence work as intended.
- Consider adding additional features such as escalating wanted levels, law enforcement response teams, or rewards for capturing criminals to enhance gameplay.
