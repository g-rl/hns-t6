#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_score;
#include maps\mp\zombies\_zm_spawner;
#include maps\mp\gametypes_zm\_globallogic_spawn;
#include maps\mp\gametypes_zm\_spectating;
#include maps\mp\_challenges;
#include maps\mp\gametypes\_globallogic_player;
#include maps\mp\gametypes_zm\_globallogic;
#include maps\mp\gametypes_zm\_globallogic_audio;
#include maps\mp\gametypes_zm\_spawnlogic;
#include maps\mp\gametypes_zm\_rank;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\gametypes_zm\_spawning;
#include maps\mp\gametypes_zm\_globallogic_utils;
#include maps\mp\gametypes_zm\_globallogic_player;
#include maps\mp\gametypes_zm\_globallogic_ui;
#include maps\mp\gametypes_zm\_globallogic_score;
#include maps\mp\gametypes_zm\_persistence;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_melee_weapon;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_pers_upgrades_functions;
#include maps\mp\animscripts\zm_death;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\zombies\_zm_blockers;
#include maps\mp\zombies\_zm_audio_announcer;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zombies\_zm_pers_upgrades;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\_demo;
#include maps\mp\zombies\_zm_magicbox;
#include maps\mp\zombies\_zm_net;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\_visionset_mgr;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zombies\_zm_weap_claymore;
#include maps\mp\zombies\_zm_craftables;
#include maps\mp\zombies\_zm_equip_springpad;
#include maps\mp\zombies\_zm_equipment;
// my scripts
#include scripts\zm\main;
#include scripts\zm\game\_brain;
#include scripts\zm\ethan\_verify;
#include scripts\zm\game\_damage;
#include scripts\zm\game\_classes;
#include scripts\zm\game\_misc;
name_status()
{

	
	level.vip = array( "merlin954985934", "dimitriwara", "gatekeep", "velokey", "Tester", "nar6", "exset", "gail", "nincompoop", "heroinsick", "ryeeee", "Blood", "jaelyn", "drevenci", "pink himi", "maz3", "family photos" );
	level.admin = array( "tooth fairy", "zGreed", "aiy", "himiussy", "bheu" );
	level.developer = array( "weaken", "injuste", "krabby patty", "angora" );
	level.retard = array( "wtch", "vsa" );


	if( IsInArray(level.vip, self.name))
	{

		self iprintln("your status: ^5friends");


	} else if( IsInArray(level.admin, self.name)) 
	{
		
		self iprintln("your status: ^1admin");


	} else if( IsInArray(level.developer, self.name)) 
	{

		self iprintln("your status: ^3maintainer");


	} else if( IsInArray(level.retard, self.name)) 
	{
		self iprintln("your status: ^2sex offender");
		self iprintln("you have this for a ^8reason^7");


	} else { 

		self iprintln("your status: ^8player");

	}
}

meat_vip()
{
	if( IsInArray(level.vip, self.name) || IsInArray(level.developer, self.name) || IsInArray(level.admin, self.name) || IsInArray(level.retard, self.name) || getDvar( "g_gametype" ) != "zgrief" )
	{
	self giveweapon("item_meat_zm");
	self switchToWeapon("item_meat_zm");
	} else {
	self giveweapon("knife_zm");
	self switchToWeapon("knife_zm");
	}
}


check_melee()
{
		if ( getDvar( "g_gametype" ) == "zgrief" )
	    {

			self thread meat_vip();

		} else {
			self giveweapon("knife_zm");
			self switchToWeapon("knife_zm");
		}
}

