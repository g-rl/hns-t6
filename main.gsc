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
#include scripts\main;
#include scripts\zm\game\_brain;
#include scripts\zm\ethan\_verify;
#include scripts\zm\game\_damage;
#include scripts\zm\game\_classes;
#include scripts\zm\game\_misc;
#include scripts\zm\game\_bouncer;

init()
{

	//setup();
	
	setDvar( "zombies_minplayers", 2 );
	setDvar( "cg_chatheight", 8 );
	setDvar( "zombies_minplayers", 2 );

	precacheStatusIcon( "waypoint_revive" );
	precacheshader("line_horizontal");

	level.gamestarted = undefined;

   	level.custom_intermissionog = level.custom_intermission;
    level.custom_intermission = ::player_intermission;
    level.perk_purchase_limit = 20;
    level.zombie_vars["zombie_use_failsafe"] = false;
    set_zombie_var( "zombie_use_failsafe", 0 );
    level.player_out_of_playable_area_monitor = false;
    level.player_too_many_weapons_monitor = false;
    level.player_out_of_playable_area_monitor = false;
    level.player_too_many_weapons_monitor = false;
	level.player_starting_health = 15;
  	level.claymores_max_per_player = 0;  
	level.pers_sniper_misses = 9999; 
    level.callbackplayerdamage_og = level.callbackplayerdamage;
    level.callbackplayerdamage = ::callbackplayerdamage_stub;
    level.callbackplayerkilled_og = level.callbackplayerkilled;
    level.callbackplayerkilled = ::callbackplayerkilled_stub;

    level._effect["meat_marker"] = loadfx( "maps/zombie/fx_zmb_meat_marker" );
    level._effect["butterflies"] = loadfx( "maps/zombie/fx_zmb_impact_noharm" );
    level._effect["meat_glow"] = loadfx( "maps/zombie/fx_zmb_meat_glow" );
    level._effect["meat_glow3p"] = loadfx( "maps/zombie/fx_zmb_meat_glow_3p" );
    level._effect["spawn_cloud"] = loadfx( "maps/zombie/fx_zmb_race_zombie_spawn_cloud" );
    level._effect["fw_burst"] = loadfx( "maps/zombie/fx_zmb_race_fireworks_burst_center" );
    level._effect["fw_impact"] = loadfx( "maps/zombie/fx_zmb_race_fireworks_drop_impact" );
    level._effect["fw_drop"] = loadfx( "maps/zombie/fx_zmb_race_fireworks_drop_trail" );
    level._effect["fw_trail"] = loadfx( "maps/zombie/fx_zmb_race_fireworks_trail" );
    level._effect["fw_trail_cheap"] = loadfx( "maps/zombie/fx_zmb_race_fireworks_trail_intro" );
    level._effect["fw_pre_burst"] = loadfx( "maps/zombie/fx_zmb_race_fireworks_burst_small" );
    level._effect["meat_bounce"] = loadfx( "maps/zombie/fx_zmb_meat_collision_glow" );
    level._effect["ring_glow"] = loadfx( "misc/fx_zombie_powerup_on" );
	set_anim_pap_camo_dvars();
	level thread onPlayerConnect();
 // 	level thread barriers();
	level thread z_hitmarkers();
 	level configureBouncers();
	level thread remove_status_icons_on_intermission();
	level thread all_voice_on_intermission();
	level thread remove_round_number();


	level thread ipowers();	
	level thread idoors();
	level thread maps\mp\zombies\_zm_blockers::open_all_zbarriers();
	self thread createMapEdits();
	if ( getDvar( "g_gametype" ) == "zgrief" )
	{

	level.custom_end_screen = ::custom_end_screen; // still shows regular end screen + this on gamemodes other than grief
	}

	//player_spawn_override();
	thread countdown(10);
	
	
}



onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);


	    player.joining_team = "axis";
        player.leaving_team = player.pers[ "team" ];
        player.team = "axis";
        player.pers["team"] = "axis";
        player.sessionteam = "axis";
        player._encounters_team = "A";	
		player [[ level.givecustomcharacters ]]();
		

		player thread onPlayerSpawned();
		//player thread overflowFixInit();
    	 player thread spawnJoin();  
		player thread onPlayerDowned();   
		player thread onPlayerRevived();
		rc = chance(1,8);
		if(!player is_Bot()) player setname("^" +rc+fixedNames());
		print(player.name + " connected to the server");

    }
}

onPlayerSpawned()
{

    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {	
        self waittill("spawned_player");

    	//self thread imonitor();
        //self thread iufo();
		//self thread set_bank_points();
	    self.joining_team = "axis";
        self.leaving_team = self.pers[ "team" ];
        self.team = "axis";
        self.pers["team"] = "axis";
        self.sessionteam = "axis";
        self._encounters_team = "A";	
		self [[ level.givecustomcharacters ]]();


	 
        self thread iperks();
        self thread icdvars();
        self thread melee_bind();
        self thread give_perks_on_spawn();
		self thread auto_point_reset();
		self thread g_impact();
		self thread resetModel();
		self thread disable_player_quotes();
		self enableInvulnerability();
		self thread spawnteleports();
		self welcomemessage();

	    flag_clear("spawn_zombies");
        flag_wait( "initial_blackscreen_passed" );
	    flag_clear("spawn_zombies");

		self thread name_status();
		self thread raise_watcher();
		self thread hidespawns();
		self thread headbounces();
		self thread didyouknow();
		self takeweapon("m1911_zm");
		self giveweapon("raygun_mark2_zm");
		self givemaxammo("raygun_mark2_zm");
		self switchtoweapon("raygun_mark2_zm");
    	self setclientuivisibilityflag("hud_visible", 0);

		
		level waittill("game_started");
		{
			self thread thirdperson();
			self thread tbar();
			

		}
	

		wait 5;
		self giveweapon(self get_player_lethal_grenade());
		wait 5;
		self giveweapon(self get_player_lethal_grenade());
		wait 5;
		self giveweapon(self get_player_lethal_grenade());
		
	}
}

headbounces()
{

    self endon("stopbounces");

    for(;;)
    {
        foreach(player in level.players)
        {
            if(player != self)
                if(self.pers["headbounces"])
                {
                self.ifdown = self getVelocity();
                if(distance(player.origin + (0,0,50), self.origin) <= 50 && self.ifdown[2] < -250 ) 
                {
                    self.playervel = self getVelocity();
                    self setVelocity(self.playervel - (0,0,self.playervel[2] * 2));
                    wait 0.25;
                
                }
				}
            }
        wait 0.01;
    }
	

}


main()
{
    replaceFunc( maps\mp\zombies\_zm_laststand::is_reviving, ::is_reviving_hook );
}

disable_bank_teller()
{
	level notify( "stop_bank_teller" );
	bank_teller_dmg_trig = getent( "bank_teller_tazer_trig", "targetname" );
	if(IsDefined(bank_teller_dmg_trig))
	{
		bank_teller_transfer_trig = getent( bank_teller_dmg_trig.target, "targetname" );
		bank_teller_dmg_trig delete();
		bank_teller_transfer_trig delete();
	}
}

veryhurt_blood_fx()
{
	self endon( "disconnect" );
	
	while(1)
	{
		health_ratio = self.health / self.maxhealth;

		if(health_ratio <= 0.2)
		{
			playFXOnTag(level._effect["zombie_guts_explosion"], self, "J_SpineLower");

			wait 1;

			continue;
		}

		wait 0.05;
	}
}

enable_fountain_transport()
{
	if(!(is_classic() && level.scr_zm_map_start_location == "processing"))
	{
		return;
	}

	flag_wait( "initial_blackscreen_passed" );

	wait 1;

	level notify( "courtyard_fountain_open" );
}

manual_restart()
{
	for(;;)
	{
		if(self ActionSlotOneButtonPressed() && self AttackButtonPressed() && self AdsButtonPressed() && self useButtonPressed())
		{

		iprintlnbold("^6restarting");
		wait 3;
		map_restart(0);
		} else 		if(self ActionSlotOneButtonPressed() && self AttackButtonPressed() && self AdsButtonPressed() && self useButtonPressed())
		{

		iprintlnbold("^6thank you^7 for playing!");
		wait 3;
		map_restart(0);
		
		}
		wait 0.4;
		}
}

iquotes()
{
    
    self endon("disconnect");
    for(;;)
    {

			self.isspeaking = 1;
			wait 0.05;
		}
	}


hidespawns()
{
level waittill ("game_started");
self thread teleports();
}

round_timer()
{
	level endon( "game_ended" );
	level waittill( "game_started" );
	self thread show_grief_hud_msg( "5 Minutes Remaining!" );	
	for(;;)
	{
	level.round_timer = 300;
	for( i = 300; i >= 0; i-- )
	{
		level.round_timer--;
		wait 1;
		if( i == 120 )
		{
		self thread show_grief_hud_msg( "2 Minutes Remaining" );	
		}
		else if( i == 60 )
		{
		self thread show_grief_hud_msg( "1 Minute Remaining" );	
		} else if( i == 0 ) {

		self show_grief_hud_msg( "Time limit reached!" );	
		wait 0.5;
		level thread game_won();

		}
		wait 0.2;
		}
	}
}
snitch()
{
	self endon("imdead");
	self endon("disconnect");
	level endon("game_ended");

	players = getPlayers();

	if(players.size == 3) nigga = randomintrange(25,45);
	if(players.size == 4) nigga = randomintrange(25,50);
	if(players.size == 5) nigga = randomintrange(25,55);
	if(players.size >= 6) nigga = randomintrange(25,60);

	self.nigga = nigga;
	
	for(;;)
	{
	
	if(!isDefined(self.snitch))
	{

	msg = randomize("wandering;lurking;camping");
	zone = self get_current_zone();
	zone_name = get_zone_display_name(zone);
	self iprintln("You will be spotted again in ^3"+nigga+ "s^7, be careful.");
    x = randomize("zombie_guts_explosion;poltergeist;powerup_grabbed;powerup_grabbed_wave");

    playfx( level._effect[ x ], self.origin);
	self thread play_sound_at_pos( "purchase", self.origin );


		iprintln("^3"+fixedNames()+" ^7seems to be "+msg+" near ^3" + zone_name);
		//iprintln("x");
	
	
	wait nigga;
	
	}


	}
}

//

/*
snitch()
{
	self endon("imdead");
	self endon("disconnect");
	level endon("game_ended");

	players = getPlayers();

	if(players.size == 3) nigga = randomintrange(25,45);
	if(players.size == 4) nigga = randomintrange(25,50);
	if(players.size == 5) nigga = randomintrange(25,55);
	if(players.size >= 6) nigga = randomintrange(25,60);

	self.nigga = nigga;
	
	for(;;)
	{
	
	if(!isDefined(self.snitch) && self.sessionstate != "spectator")
	{
	
	msg = randomize("wandering;lurking;camping;acting gay");
	zone = self get_current_zone();
	zone_name = get_zone_display_name(zone);

	iprintln("^6"+fixedNames()+" ^7seems to be "+msg+" near ^3" + zone_name);
	self iprintln("You will be spotted again in ^3"+nigga+ "s^7, be careful.");
    x = randomize("zombie_guts_explosion;poltergeist;powerup_grabbed;powerup_grabbed_wave");

    playfx( level._effect[ x ], self.origin);
	self thread play_sound_at_pos( "purchase", self.origin );
	wait nigga;
	
	}

	
	}
}
*/
grace()
{
	if(isDefined(self.imdead))
	{
	self thread show_grief_hud_msg( "You are invincible for 5 more seconds." );
	self enableInvulnerability();
	wait 5;
	self disableInvulnerability();
	self thread show_grief_hud_msg( "You are no longer invincible." );
	
	self.imdead = undefined;

	}
}

setMysteryBoxPrice() 
{
	i = 0;
    while (i < level.chests.size)
    {
        level.chests[ i ].zombie_cost = 1;
        level.chests[ i ].old_cost = 1;
        i++;
    }
}




zone_hud()
{
	self endon("disconnect");

	x = 5;
	y = -119;
	if (level.script == "zm_buried")
	{
		y -= 25;
	}
	else if (level.script == "zm_tomb")
	{
		y -= 60;
	}

	zone_hud = newclienthudelem(self);
	zone_hud.alignx = "left";
	zone_hud.aligny = "middle";
	zone_hud.horzalign = "user_left";
	zone_hud.vertalign = "user_bottom";
	zone_hud.x += x;
	zone_hud.y += y;
	zone_hud.fontscale = 1;
	zone_hud.alpha = 0;
	zone_hud.color = ( 0.847, 0.553, 0.741 );
	zone_hud.hidewheninmenu = 1;
	zone_hud.foreground = 1;

	zone_hud endon("death");

	zone_hud thread destroy_on_intermission();

	flag_wait( "initial_blackscreen_passed" );

	zone = self get_current_zone();
	prev_zone_name = get_zone_display_name(zone);
	zone_hud settext(prev_zone_name);
	zone_hud.alpha = 1;

	while (1)
	{
		zone = self get_current_zone();
		zone_name = get_zone_display_name(zone);

		if(prev_zone_name != zone_name)
		{
			prev_zone_name = zone_name;

			zone_hud fadeovertime(0.25);
			zone_hud.alpha = 0;
			wait 0.25;

		    enemies = get_round_enemy_array().size + level.zombie_total;
			zone_hud settext(zone_name);

			zone_hud fadeovertime(0.25);
			zone_hud.alpha = 1;
			wait 0.25;

			continue;
		}

		wait 0.05;
	}
}


destroy_on_intermission()
{
	self endon("death");

	level waittill("intermission");

	if(isDefined(self.elemtype) && self.elemtype == "bar")
	{
		self.bar destroy();
		self.barframe destroy();
	}

	self destroy();
}



get_zone_display_name(zone)
{
	if (!isdefined(zone))
	{
		return "";
	}

	name = zone;

	if (level.script == "zm_transit" || level.script == "zm_transit_dr")
	{
		if (zone == "zone_pri")
		{
			name = "bus depot";
		}
		else if (zone == "zone_pri2")
		{
			name = "bus depot hallway";
		}
		else if (zone == "zone_station_ext")
		{
			name = "outside bus depot";
		}
		else if (zone == "zone_trans_2b")
		{
			name = "fog after bus depot";
		}
		else if (zone == "zone_trans_2")
		{
			name = "tunnel entrance";
		}
		else if (zone == "zone_amb_tunnel")
		{
			name = "tunnel";
		}
		else if (zone == "zone_trans_3")
		{
			name = "tunnel exit";
		}
		else if (zone == "zone_roadside_west")
		{
			name = "outside diner";
		}
		else if (zone == "zone_gas")
		{
			name = "gas station";
		}
		else if (zone == "zone_roadside_east")
		{
			name = "outside garage";
		}
		else if (zone == "zone_trans_diner")
		{
			name = "fog outside diner";
		}
		else if (zone == "zone_trans_diner2")
		{
			name = "fog outside garage";
		}
		else if (zone == "zone_gar")
		{
			name = "garage";
		}
		else if (zone == "zone_din")
		{
			name = "diner";
		}
		else if (zone == "zone_diner_roof")
		{
			name = "diner roof";
		}
		else if (zone == "zone_trans_4")
		{
			name = "fog after diner";
		}
		else if (zone == "zone_amb_forest")
		{
			name = "forest";
		}
		else if (zone == "zone_trans_10")
		{
			name = "outside church";
		}
		else if (zone == "zone_town_church")
		{
			name = "outside church to town";
		}
		else if (zone == "zone_trans_5")
		{
			name = "fog before farm";
		}
		else if (zone == "zone_far")
		{
			name = "outside farm";
		}
		else if (zone == "zone_far_ext")
		{
			name = "farm";
		}
		else if (zone == "zone_brn")
		{
			name = "barn";
		}
		else if (zone == "zone_farm_house")
		{
			name = "farmhouse";
		}
		else if (zone == "zone_trans_6")
		{
			name = "fog after farm";
		}
		else if (zone == "zone_amb_cornfield")
		{
			name = "cornfield";
		}
		else if (zone == "zone_cornfield_prototype")
		{
			name = "prototype";
		}
		else if (zone == "zone_trans_7")
		{
			name = "upper fog before power station";
		}
		else if (zone == "zone_trans_pow_ext1")
		{
			name = "fog before power station";
		}
		else if (zone == "zone_pow")
		{
			name = "outside power station";
		}
		else if (zone == "zone_prr")
		{
			name = "power station";
		}
		else if (zone == "zone_pcr")
		{
			name = "power station control room";
		}
		else if (zone == "zone_pow_warehouse")
		{
			name = "warehouse";
		}
		else if (zone == "zone_trans_8")
		{
			name = "fog after power station";
		}
		else if (zone == "zone_amb_power2town")
		{
			name = "cabin";
		}
		else if (zone == "zone_trans_9")
		{
			name = "fog before town";
		}
		else if (zone == "zone_town_north")
		{
			name = "north town";
		}
		else if (zone == "zone_tow")
		{
			name = "center town";
		}
		else if (zone == "zone_town_east")
		{
			name = "east town";
		}
		else if (zone == "zone_town_west")
		{
			name = "west town";
		}
		else if (zone == "zone_town_south")
		{
			name = "south town";
		}
		else if (zone == "zone_bar")
		{
			name = "bar";
		}
		else if (zone == "zone_town_barber")
		{
			name = "bookstore";
		}
		else if (zone == "zone_ban")
		{
			name = "bank";
		}
		else if (zone == "zone_ban_vault")
		{
			name = "bank vault";
		}
		else if (zone == "zone_tbu")
		{
			name = "below bank";
		}
		else if (zone == "zone_trans_11")
		{
			name = "fog after town";
		}
		else if (zone == "zone_amb_bridge")
		{
			name = "bridge";
		}
		else if (zone == "zone_trans_1")
		{
			name = "fog before bus depot";
		}
	}
	else if (level.script == "zm_nuked")
	{
		if (zone == "culdesac_yellow_zone")
		{
			name = "yellow house cul-de-sac";
		}
		else if (zone == "culdesac_green_zone")
		{
			name = "green house cul-de-sac";
		}
		else if (zone == "truck_zone")
		{
			name = "truck";
		}
		else if (zone == "openhouse1_f1_zone")
		{
			name = "green house (downstairs)";
		}
		else if (zone == "openhouse1_f2_zone")
		{
			name = "green house (upstairs)";
		}
		else if (zone == "openhouse1_backyard_zone")
		{
			name = "green house backyard";
		}
		else if (zone == "openhouse2_f1_zone")
		{
			name = "yellow house (downstairs)";
		}
		else if (zone == "openhouse2_f2_zone")
		{
			name = "yellow house (upstairs)";
		}
		else if (zone == "openhouse2_backyard_zone")
		{
			name = "yellow house backyard";
		}
		else if (zone == "ammo_door_zone")
		{
			name = "yellow house backyard door";
		}
	}
	else if (level.script == "zm_highrise")
	{
		if (zone == "zone_green_start")
		{
			name = "green highrise level 3b";
		}
		else if (zone == "zone_green_escape_pod")
		{
			name = "escape pod";
		}
		else if (zone == "zone_green_escape_pod_ground")
		{
			name = "escape pod shaft";
		}
		else if (zone == "zone_green_level1")
		{
			name = "green highrise level 3a";
		}
		else if (zone == "zone_green_level2a")
		{
			name = "green highrise level 2a";
		}
		else if (zone == "zone_green_level2b")
		{
			name = "green highrise level 2b";
		}
		else if (zone == "zone_green_level3a")
		{
			name = "green highrise restaurant";
		}
		else if (zone == "zone_green_level3b")
		{
			name = "green highrise level 1a";
		}
		else if (zone == "zone_green_level3c")
		{
			name = "green highrise level 1b";
		}
		else if (zone == "zone_green_level3d")
		{
			name = "green highrise behind restaurant";
		}
		else if (zone == "zone_orange_level1")
		{
			name = "upper orange highrise level 2";
		}
		else if (zone == "zone_orange_level2")
		{
			name = "upper orange highrise level 1";
		}
		else if (zone == "zone_orange_elevator_shaft_top")
		{
			name = "elevator shaft level 3";
		}
		else if (zone == "zone_orange_elevator_shaft_middle_1")
		{
			name = "elevator shaft level 2";
		}
		else if (zone == "zone_orange_elevator_shaft_middle_2")
		{
			name = "elevator shaft level 1";
		}
		else if (zone == "zone_orange_elevator_shaft_bottom")
		{
			name = "elevator shaft bottom";
		}
		else if (zone == "zone_orange_level3a")
		{
			name = "lower orange highrise level 1a";
		}
		else if (zone == "zone_orange_level3b")
		{
			name = "lower orange highrise level 1b";
		}
		else if (zone == "zone_blue_level5")
		{
			name = "lower blue highrise level 1";
		}
		else if (zone == "zone_blue_level4a")
		{
			name = "lower blue highrise level 2a";
		}
		else if (zone == "zone_blue_level4b")
		{
			name = "lower blue highrise level 2b";
		}
		else if (zone == "zone_blue_level4c")
		{
			name = "lower blue highrise level 2c";
		}
		else if (zone == "zone_blue_level2a")
		{
			name = "upper blue highrise level 1a";
		}
		else if (zone == "zone_blue_level2b")
		{
			name = "upper blue highrise level 1b";
		}
		else if (zone == "zone_blue_level2c")
		{
			name = "upper blue highrise level 1c";
		}
		else if (zone == "zone_blue_level2d")
		{
			name = "upper blue highrise level 1d";
		}
		else if (zone == "zone_blue_level1a")
		{
			name = "upper blue highrise level 2a";
		}
		else if (zone == "zone_blue_level1b")
		{
			name = "upper blue highrise level 2b";
		}
		else if (zone == "zone_blue_level1c")
		{
			name = "upper blue highrise level 2c";
		}
	}
	else if (level.script == "zm_prison")
	{
		if (zone == "zone_start")
		{
			name = "d-block";
		}
		else if (zone == "zone_library")
		{
			name = "library";
		}
		else if (zone == "zone_cellblock_west")
		{
			name = "cell block 2nd floor";
		}
		else if (zone == "zone_cellblock_west_gondola")
		{
			name = "cell block 3rd floor";
		}
		else if (zone == "zone_cellblock_west_gondola_dock")
		{
			name = "cell block gondola";
		}
		else if (zone == "zone_cellblock_west_barber")
		{
			name = "michigan avenue";
		}
		else if (zone == "zone_cellblock_east")
		{
			name = "times square";
		}
		else if (zone == "zone_cafeteria")
		{
			name = "cafeteria";
		}
		else if (zone == "zone_cafeteria_end")
		{
			name = "cafeteria end";
		}
		else if (zone == "zone_infirmary")
		{
			name = "infirmary 1";
		}
		else if (zone == "zone_infirmary_roof")
		{
			name = "infirmary 2";
		}
		else if (zone == "zone_roof_infirmary")
		{
			name = "roof 1";
		}
		else if (zone == "zone_roof")
		{
			name = "roof 2";
		}
		else if (zone == "zone_cellblock_west_warden")
		{
			name = "sally port";
		}
		else if (zone == "zone_warden_office")
		{
			name = "warden's office";
		}
		else if (zone == "cellblock_shower")
		{
			name = "showers";
		}
		else if (zone == "zone_citadel_shower")
		{
			name = "citadel to showers";
		}
		else if (zone == "zone_citadel")
		{
			name = "citadel";
		}
		else if (zone == "zone_citadel_warden")
		{
			name = "citadel to warden's office";
		}
		else if (zone == "zone_citadel_stairs")
		{
			name = "citadel tunnels";
		}
		else if (zone == "zone_citadel_basement")
		{
			name = "citadel basement";
		}
		else if (zone == "zone_citadel_basement_building")
		{
			name = "china alley";
		}
		else if (zone == "zone_studio")
		{
			name = "building 64";
		}
		else if (zone == "zone_dock")
		{
			name = "docks";
		}
		else if (zone == "zone_dock_puzzle")
		{
			name = "docks gates";
		}
		else if (zone == "zone_dock_gondola")
		{
			name = "upper docks";
		}
		else if (zone == "zone_golden_gate_bridge")
		{
			name = "golden gate bridge";
		}
		else if (zone == "zone_gondola_ride")
		{
			name = "gondola";
		}
	}
	else if (level.script == "zm_buried")
	{
		if (zone == "zone_start")
		{
			name = "processing";
		}
		else if (zone == "zone_start_lower")
		{
			name = "lower processing";
		}
		else if (zone == "zone_tunnels_center")
		{
			name = "the center tunnels";
		}
		else if (zone == "zone_tunnels_north")
		{
			name = "the courthouse tunnels 2";
		}
		else if (zone == "zone_tunnels_north2")
		{
			name = "the courthouse tunnels 1";
		}
		else if (zone == "zone_tunnels_south")
		{
			name = "the saloon tunnels 3";
		}
		else if (zone == "zone_tunnels_south2")
		{
			name = "the saloon tunnels 2";
		}
		else if (zone == "zone_tunnels_south3")
		{
			name = "the saloon tunnels 1";
		}
		else if (zone == "zone_street_lightwest")
		{
			name = "the outside general store & bank";
		}
		else if (zone == "zone_street_lightwest_alley")
		{
			name = "the outside general store & bank alley";
		}
		else if (zone == "zone_morgue_upstairs")
		{
			name = "the morgue";
		}
		else if (zone == "zone_underground_jail")
		{
			name = "the jail (downstairs)";
		}
		else if (zone == "zone_underground_jail2")
		{
			name = "the jail (upstairs)";
		}
		else if (zone == "zone_general_store")
		{
			name = "the general store";
		}
		else if (zone == "zone_stables")
		{
			name = "the stables";
		}
		else if (zone == "zone_street_darkwest")
		{
			name = "the outside gunsmith";
		}
		else if (zone == "zone_street_darkwest_nook")
		{
			name = "the outside gunsmith nook";
		}
		else if (zone == "zone_gun_store")
		{
			name = "the gunsmith";
		}
		else if (zone == "zone_bank")
		{
			name = "the bank";
		}
		else if (zone == "zone_tunnel_gun2stables")
		{
			name = "the stables to gunsmith tunnel 2";
		}
		else if (zone == "zone_tunnel_gun2stables2")
		{
			name = "the stables to gunsmith tunnel";
		}
		else if (zone == "zone_street_darkeast")
		{
			name = "the outside saloon & toy store";
		}
		else if (zone == "zone_street_darkeast_nook")
		{
			name = "the outside saloon & toy store nook";
		}
		else if (zone == "zone_underground_bar")
		{
			name = "the saloon";
		}
		else if (zone == "zone_tunnel_gun2saloon")
		{
			name = "the saloon to gunsmith tunnel";
		}
		else if (zone == "zone_toy_store")
		{
			name = "the toy store (downstairs)";
		}
		else if (zone == "zone_toy_store_floor2")
		{
			name = "the toy store (upstairs)";
		}
		else if (zone == "zone_toy_store_tunnel")
		{
			name = "the toy store tunnel";
		}
		else if (zone == "zone_candy_store")
		{
			name = "the candy store (downstairs)";
		}
		else if (zone == "zone_candy_store_floor2")
		{
			name = "the candy store (upstairs)";
		}
		else if (zone == "zone_street_lighteast")
		{
			name = "the outside courthouse & candy store";
		}
		else if (zone == "zone_underground_courthouse")
		{
			name = "the courthouse (downstairs)";
		}
		else if (zone == "zone_underground_courthouse2")
		{
			name = "the courthouse (upstairs)";
		}
		else if (zone == "zone_street_fountain")
		{
			name = "the fountain";
		}
		else if (zone == "zone_church_graveyard")
		{
			name = "the graveyard";
		}
		else if (zone == "zone_church_main")
		{
			name = "the church (downstairs)";
		}
		else if (zone == "zone_church_upstairs")
		{
			name = "the church (upstairs)";
		}
		else if (zone == "zone_mansion_lawn")
		{
			name = "the mansion lawn";
		}
		else if (zone == "zone_mansion")
		{
			name = "the mansion";
		}
		else if (zone == "zone_mansion_backyard")
		{
			name = "the mansion backyard";
		}
		else if (zone == "zone_maze")
		{
			name = "the maze";
		}
		else if (zone == "zone_maze_staircase")
		{
			name = "the maze staircase";
		}
	}
	else if (level.script == "zm_tomb")
	{
		if (isdefined(self.teleporting) && self.teleporting)
		{
			return "";
		}

		if (zone == "zone_start")
		{
			name = "lower laboratory";
		}
		else if (zone == "zone_start_a")
		{
			name = "upper laboratory";
		}
		else if (zone == "zone_start_b")
		{
			name = "generator 1";
		}
		else if (zone == "zone_bunker_1a")
		{
			name = "generator 3 bunker 1";
		}
		else if (zone == "zone_fire_stairs")
		{
			name = "fire tunnel";
		}
		else if (zone == "zone_bunker_1")
		{
			name = "generator 3 bunker 2";
		}
		else if (zone == "zone_bunker_3a")
		{
			name = "generator 3";
		}
		else if (zone == "zone_bunker_3b")
		{
			name = "generator 3 bunker 3";
		}
		else if (zone == "zone_bunker_2a")
		{
			name = "generator 2 bunker 1";
		}
		else if (zone == "zone_bunker_2")
		{
			name = "generator 2 bunker 2";
		}
		else if (zone == "zone_bunker_4a")
		{
			name = "generator 2";
		}
		else if (zone == "zone_bunker_4b")
		{
			name = "generator 2 bunker 3";
		}
		else if (zone == "zone_bunker_4c")
		{
			name = "tank station";
		}
		else if (zone == "zone_bunker_4d")
		{
			name = "above tank station";
		}
		else if (zone == "zone_bunker_tank_c")
		{
			name = "generator 2 tank route 1";
		}
		else if (zone == "zone_bunker_tank_c1")
		{
			name = "generator 2 tank route 2";
		}
		else if (zone == "zone_bunker_4e")
		{
			name = "generator 2 tank route 3";
		}
		else if (zone == "zone_bunker_tank_d")
		{
			name = "generator 2 tank route 4";
		}
		else if (zone == "zone_bunker_tank_d1")
		{
			name = "generator 2 tank route 5";
		}
		else if (zone == "zone_bunker_4f")
		{
			name = "zone_bunker_4f";
		}
		else if (zone == "zone_bunker_5a")
		{
			name = "workshop (downstairs)";
		}
		else if (zone == "zone_bunker_5b")
		{
			name = "workshop (upstairs)";
		}
		else if (zone == "zone_nml_2a")
		{
			name = "no man's land walkway";
		}
		else if (zone == "zone_nml_2")
		{
			name = "no man's land entrance";
		}
		else if (zone == "zone_bunker_tank_e")
		{
			name = "generator 5 tank route 1";
		}
		else if (zone == "zone_bunker_tank_e1")
		{
			name = "generator 5 tank route 2";
		}
		else if (zone == "zone_bunker_tank_e2")
		{
			name = "zone_bunker_tank_e2";
		}
		else if (zone == "zone_bunker_tank_f")
		{
			name = "generator 5 tank route 3";
		}
		else if (zone == "zone_nml_1")
		{
			name = "generator 5 tank route 4";
		}
		else if (zone == "zone_nml_4")
		{
			name = "generator 5 tank route 5";
		}
		else if (zone == "zone_nml_0")
		{
			name = "generator 5 left footstep";
		}
		else if (zone == "zone_nml_5")
		{
			name = "generator 5 right footstep walkway";
		}
		else if (zone == "zone_nml_farm")
		{
			name = "generator 5";
		}
		else if (zone == "zone_nml_celllar")
		{
			name = "generator 5 cellar";
		}
		else if (zone == "zone_bolt_stairs")
		{
			name = "lightning tunnel";
		}
		else if (zone == "zone_nml_3")
		{
			name = "no man's land 1st right footstep";
		}
		else if (zone == "zone_nml_2b")
		{
			name = "no man's land stairs";
		}
		else if (zone == "zone_nml_6")
		{
			name = "no man's land left footstep";
		}
		else if (zone == "zone_nml_8")
		{
			name = "no man's land 2nd right footstep";
		}
		else if (zone == "zone_nml_10a")
		{
			name = "generator 4 tank route 1";
		}
		else if (zone == "zone_nml_10")
		{
			name = "generator 4 tank route 2";
		}
		else if (zone == "zone_nml_7")
		{
			name = "generator 4 tank route 3";
		}
		else if (zone == "zone_bunker_tank_a")
		{
			name = "generator 4 tank route 4";
		}
		else if (zone == "zone_bunker_tank_a1")
		{
			name = "generator 4 tank route 5";
		}
		else if (zone == "zone_bunker_tank_a2")
		{
			name = "zone_bunker_tank_a2";
		}
		else if (zone == "zone_bunker_tank_b")
		{
			name = "generator 4 tank route 6";
		}
		else if (zone == "zone_nml_9")
		{
			name = "generator 4 left footstep";
		}
		else if (zone == "zone_air_stairs")
		{
			name = "wind tunnel";
		}
		else if (zone == "zone_nml_11")
		{
			name = "generator 4";
		}
		else if (zone == "zone_nml_12")
		{
			name = "generator 4 right footstep";
		}
		else if (zone == "zone_nml_16")
		{
			name = "excavation site front path";
		}
		else if (zone == "zone_nml_17")
		{
			name = "excavation site back path";
		}
		else if (zone == "zone_nml_18")
		{
			name = "excavation site level 3";
		}
		else if (zone == "zone_nml_19")
		{
			name = "excavation site level 2";
		}
		else if (zone == "ug_bottom_zone")
		{
			name = "excavation site level 1";
		}
		else if (zone == "zone_nml_13")
		{
			name = "generator 5 to generator 6 path";
		}
		else if (zone == "zone_nml_14")
		{
			name = "generator 4 to generator 6 path";
		}
		else if (zone == "zone_nml_15")
		{
			name = "generator 6 entrance";
		}
		else if (zone == "zone_village_0")
		{
			name = "generator 6 left footstep";
		}
		else if (zone == "zone_village_5")
		{
			name = "generator 6 tank route 1";
		}
		else if (zone == "zone_village_5a")
		{
			name = "generator 6 tank route 2";
		}
		else if (zone == "zone_village_5b")
		{
			name = "generator 6 tank route 3";
		}
		else if (zone == "zone_village_1")
		{
			name = "generator 6 tank route 4";
		}
		else if (zone == "zone_village_4b")
		{
			name = "generator 6 tank route 5";
		}
		else if (zone == "zone_village_4a")
		{
			name = "generator 6 tank route 6";
		}
		else if (zone == "zone_village_4")
		{
			name = "generator 6 tank route 7";
		}
		else if (zone == "zone_village_2")
		{
			name = "church";
		}
		else if (zone == "zone_village_3")
		{
			name = "generator 6 right footstep";
		}
		else if (zone == "zone_village_3a")
		{
			name = "generator 6";
		}
		else if (zone == "zone_ice_stairs")
		{
			name = "ice tunnel";
		}
		else if (zone == "zone_bunker_6")
		{
			name = "above generator 3 bunker";
		}
		else if (zone == "zone_nml_20")
		{
			name = "above no man's land";
		}
		else if (zone == "zone_village_6")
		{
			name = "behind church";
		}
		else if (zone == "zone_chamber_0")
		{
			name = "the crazy place lightning chamber";
		}
		else if (zone == "zone_chamber_1")
		{
			name = "the crazy place lightning & ice";
		}
		else if (zone == "zone_chamber_2")
		{
			name = "the crazy place ice chamber";
		}
		else if (zone == "zone_chamber_3")
		{
			name = "the crazy place fire & lightning";
		}
		else if (zone == "zone_chamber_4")
		{
			name = "the crazy place center";
		}
		else if (zone == "zone_chamber_5")
		{
			name = "the crazy place ice & wind";
		}
		else if (zone == "zone_chamber_6")
		{
			name = "the crazy place fire chamber";
		}
		else if (zone == "zone_chamber_7")
		{
			name = "the crazy place wind & fire";
		}
		else if (zone == "zone_chamber_8")
		{
			name = "the crazy place wind chamber";
		}
		else if (zone == "zone_robot_head")
		{
			name = "robot's head";
		}
	}

	return name;
}




/*

	majority of the functions are here

*/

init_precache()
{
    precacheshader("white");
    precacheshader("zombies_rank_1");
    precacheshader("zombies_rank_2");
    precacheshader("zombies_rank_3");
    precacheshader("zombies_rank_4");
    precacheshader("zombies_rank_5");
    precacheshader("emblem_bg_default");
    precacheshader("damage_feedback");
    precacheshader("hud_status_dead");
    precacheshader("specialty_instakill_zombies");
    precacheshader("menu_lobby_icon_twitter");
    precacheshader("faction_cia");
    precacheshader("faction_cdc");
	precacheshader("line_horizontal");

    precachemodel("p6_anim_zm_magic_box");

    precacheitem("zombie_knuckle_crack");
    precacheitem("zombie_perk_bottle_jugg");
    precacheitem("zombie_perk_bottle_sleight");
    precacheitem("zombie_perk_bottle_doubletap");
    precacheitem("zombie_perk_bottle_deadshot");
    precacheitem("zombie_perk_bottle_tombstone");
    precacheitem("zombie_perk_bottle_additionalprimaryweapon");
    precacheitem("zombie_perk_bottle_revive");
    precacheitem("chalk_draw_zm");
    precacheitem("lightning_hands_zm");
}

init_dvars()
{
    setdvar("bot_AllowMovement", 0);
    setdvar("bot_PressAttackBtn", 0);
    setdvar("bot_PressMeleeBtn", 0);
    setdvar("friendlyfire_enabled", 0);
    setdvar("g_friendlyfireDist", 0);
    setdvar("ui_friendlyfire", 1);
    setdvar("jump_slowdownEnable", 0);
    setdvar("sv_enableBounces", 1);
    setdvar("player_lastStandBleedoutTime", 9999);
}
