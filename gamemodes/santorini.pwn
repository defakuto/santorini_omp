#include "../connector.inc"

main()
{
    print("-                                     -");
	print(" Founder : defakuto");
	print(" Version : 0.0.6");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Santorini Gamemode Started");
    print("-                                     -");
}

#include "external/initial/colors.pwn"
#include "external/initial/settings.pwn"
#include "external/initial/accounts.pwn"
#include "external/initial/staffteam.pwn"
#include "external/initial/vehicle.pwn"
#include "external/initial/hourbenefit.pwn"
#include "external/initial/speedometer.pwn"
#include "external/initial/driftmeter.pwn"
#include "external/initial/time.pwn"

#include "external/scripts/teams.pwn"
#include "external/scripts/wanted.pwn"
#include "external/scripts/racewar.pwn"
#include "external/scripts/parrot.pwn"
#include "external/scripts/emergency.pwn"


#include "external/maps/bayside.pwn"

YCMD:weapon(playerid, const string: params[], help)
{
	GivePlayerWeapon(playerid, WEAPON_M4, 100);

	return 1;
}

YCMD:money(playerid, const string: params[], help)
{
	GivePlayerMoney(playerid, 20000);

	return 1;
}

YCMD:kill(playerid, const string: params[], help)
{
	SetPlayerHealth(playerid, 0);

	return 1;
}