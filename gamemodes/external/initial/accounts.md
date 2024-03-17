# Player Account Management System Documentation

## Overview

This documentation outlines the functionality and usage of a player account management system implemented in Pawn. The system manages player registration, login, and account data storage using bcrypt for password hashing.

## Features

- Account registration with password hashing
- Account login with password verification
- Account data storage and retrieval using INI files
- Player spawn management based on registration or login status

## Code Structure

### Constants

- `USER_PATH`: Defines the path template for storing user account data.
- `MAX_LOGIN_ATTEMPTS`: Maximum number of login attempts allowed.

### Enumerations

- `e_SPAWN_TYPE_REGISTER`: Spawn type for newly registered players.
- `e_SPAWN_TYPE_LOGIN`: Spawn type for logged-in players.

### Static Variables

- `player_Password`: Array to store hashed passwords for each player.
- `player_Score`, `player_Skin`, `player_Money`: Arrays to store player scores, skins, and money.
- `player_LoginAttempts`: Array to store login attempts for each player.
- `player_PosX`, `player_PosY`, `player_PosZ`: Arrays to store player positions.

### Hooks

- `Account_Load`: Loads account data from an INI file when a player connects.
- `OnPlayerConnect`: Handles player connection events, prompting for login or registration.
- `OnPlayerDisconnect`: Saves player data to an INI file when a player disconnects.
- `OnPlayerDeath`: Handles player death events, resetting player spawn info.
- `Spawn_Player`: Spawns players based on registration or login status.
- `dialog_regpassword`: Handles registration dialog, setting initial account data.
- `dialog_login`: Handles login dialog, verifying passwords.
- `Account_Path`: Constructs the path to the INI file for a player account.

### Functions

- `OnPlayerPasswordHash`: Handles password hashing for new accounts.
- `OnPlayerVerifyHash`: Handles password verification for login attempts.

## Usage

1. When a player connects:
   - If an account exists, the player is prompted to login.
   - If no account exists, the player is prompted to register.
2. Players can register by entering a password in the registration dialog.
3. Players can login by entering their password in the login dialog.
4. Account data is stored in INI files in the specified directory.
5. Player spawn locations are managed based on registration or login status.

## Dependencies

- YSI Library: Required for handling INI file operations.
- Bcrypt: Required for password hashing and verification.

## Notes

- Ensure proper error handling and security measures are implemented for production use.
- Customize paths and default values as per server requirements.
