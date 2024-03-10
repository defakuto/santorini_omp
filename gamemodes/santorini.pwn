#include "../connector.inc"
/**
TODO : Score System (get and lose score, economy...)
TODO : Economy System (based on Score, get what u can have or dont can have, buy or do...)
TODO : Superpower System (pick two or three superpower u can use, driving skill, jump, speedrun, etc...)
TODO : Weather (random weather, rain, sunny, dust, etc...)
TODO : Superarea (random zones on map get change of gravity or something else, idk now, i will see...)
TODO : Gunpack (create your gunpack, just type command and select, get your guns (must pay every time))
TODO : Tunepack (create your tunepack, just type command and select tune u created for vehicle)
TODO : vcall (get vehicle from garage you want, in location near you)
TODO : Garage (buy garage to get all vehicles in use)
TODO : Airstike (buy airstrike and activate with "Satchel Explosives" or "Camera" where u activate/shoot)
TODO : Missions (create unicate missions for players to be fun...)

Critical
// ! Last Position (when you been kicked on login, coordinate going to reset, also the skin...)
// ! Shoot Move (when you shoot, you get teleported ((can be stuck underground or in object)(works but not the whole idea), need to find a_math or write math for that and create to move it smooth)
// ! 
// !
// !
// !
// !

Progress
// ? Advanced Register and Login (maybe textdraw if i find somebody to make it for free...)
// ? Advanced Staff (integration with discord or something, i dont have idea...)
// ? Advanced Wanted (more bribe points and more wanted points, completing arrest and economy)
// ? Advanced Racewars (more checkpoints, add rockets to cars, some additional stuff like flying combo or slowing cars in radius)
// ? Advanced Shoot Move (make it smooth and give amount of time how often can use it)
// ?

Done
// * Simple Register and Login
// * Simple Staff
// * Simple Wanted
// * Simple Racewars
// * Simple Shoot Move
// * Simple Parrot Pet

Additional
// ? Moved from Standard to Modular
*/

main()
{
    print("-                                     -");
	print(" Founder : defakuto");
	print(" Version : 0.0.2");
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

#include "external/scripts/wanted.pwn"
#include "external/scripts/racewar.pwn"
#include "external/scripts/shootmove.pwn"
#include "external/scripts/parrot.pwn"
