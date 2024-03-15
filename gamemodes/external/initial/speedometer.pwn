#include <ysilib\YSI_Coding\y_hooks>

new Text:p_SpeedoMeterTextdraw;

hook OnGameModeInit()
{
    p_SpeedoMeterTextdraw = TextDrawCreate(183.968872, 421.417358, "0km/h");
	TextDrawLetterSize(p_SpeedoMeterTextdraw, 0.291303, 1.594166);
	TextDrawAlignment(p_SpeedoMeterTextdraw, TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(p_SpeedoMeterTextdraw, -1);
	TextDrawSetShadow(p_SpeedoMeterTextdraw, 0);
	TextDrawBackgroundColour(p_SpeedoMeterTextdraw, 255);
	TextDrawFont(p_SpeedoMeterTextdraw, TEXT_DRAW_FONT_1);
	TextDrawSetProportional(p_SpeedoMeterTextdraw, true);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	if (newstate == PLAYER_STATE_DRIVER) 
    {
		TextDrawShowForPlayer(playerid, p_SpeedoMeterTextdraw);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerUpdate(playerid)
{
    new Float:fPos[3], Float:fSpeed;
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		GetVehicleVelocity(GetPlayerVehicleID(playerid), fPos[0], fPos[1], fPos[2]);
		fSpeed = floatsqroot(floatpower(fPos[0], 2) + floatpower(fPos[1], 2) + floatpower(fPos[2], 2)) * 200;
		new Float:alpha = 320 - fSpeed;
		if (alpha < 60) alpha = 60;
		for(new i; i < 4; i++)
		{
		    new speed[128];
			new vid = GetPlayerVehicleID(playerid);
		    format(speed,sizeof(speed), "%d km/h", GetVehicleSpeed(vid));
		    TextDrawSetString(p_SpeedoMeterTextdraw, speed);
		}
	}
	if (!IsPlayerInAnyVehicle(playerid))
	{
 		TextDrawHideForPlayer(playerid, p_SpeedoMeterTextdraw);
	}

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock GetVehicleSpeed(vehicleid)
{
	new Float:xPos[3];

	GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);

	return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}