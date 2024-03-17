# Parrot Attachment Script Documentation

## Overview
This script allows players to buy and attach a parrot object to their characters in the game. The parrot object is attached to the player's character model as an attached object.

## Features
- **Parrot Attachment**: Players can buy and attach a parrot object to their characters using a command.
- **Automatic Attachment**: When a player with a parrot attached connects to the server, the parrot is automatically attached to their character.
- **Parrot Removal on Damage**: If a player with a parrot attached takes damage, the parrot is automatically removed.

## Implementation Details
- **Account Data Handling**: Stores the player's preference for owning a parrot in account data.
- **Automatic Attachment**: Attaches the parrot object to the player's character model upon connection if the player owns a parrot.
- **Parrot Removal**: Removes the parrot object if the player takes damage while having the parrot attached.
- **Command Usage**: Provides a command `/buyparrot` for players to buy and attach a parrot to their characters.

## Usage
- Players can use the `/buyparrot` command to buy and attach a parrot to their character.
- When a player with a parrot attached connects to the server, the parrot is automatically attached to their character.
- If a player with a parrot attached takes damage, the parrot is automatically removed.

## Notes
- Verify that the parrot object ID and attachment position are suitable for attaching to player characters.
- Ensure that the script handles account data properly to store and retrieve the player's preference for owning a parrot.
- Test the script thoroughly to ensure that parrot attachment and removal work as expected in various scenarios.

