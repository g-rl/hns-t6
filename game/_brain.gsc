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
#include scripts\zm\game\_bouncer;
/*
setup()
{
	//set_anim_pap_camo_dvars();

	load_fx();

    level.custom_intermissionog = level.custom_intermission;
    level.custom_intermission = ::player_intermission;
    level.perk_purchase_limit = 20;
    level.zombie_vars["zombie_use_failsafe"] = false;
    set_zombie_var( "zombie_use_failsafe", 0 );
    level.player_out_of_playable_area_monitor = false;
    level.player_too_many_weapons_monitor = false;
    level thread onPlayerConnect();
    level thread remove_buried_witches();
    level thread barriers();
	level thread z_hitmarkers();
	level thread setMysteryBoxPrice();
	disable_bank_teller();
    level configureBouncers();
    level.player_out_of_playable_area_monitor = false;
    level.player_too_many_weapons_monitor = false;
	level.player_starting_health = 15;
  	level.claymores_max_per_player = 0;  
	level.pers_sniper_misses = 9999; 
    level.callbackplayerdamage_og = level.callbackplayerdamage;
    level.callbackplayerdamage = ::callbackplayerdamage_stub;
    level.callbackplayerkilled_og = level.callbackplayerkilled;
    level.callbackplayerkilled = ::callbackplayerkilled_stub;

    setDvar("ui_errorMessage", "\n^7thank you for playing!\n\nmade w/ ^1<3");
    setDvar("ui_errorTitle", "^7#^1#^8#");
	makedvarserverinfo("perk_bulletPenetrationMultiplier", "999");
	makedvarserverinfo("perk_armorPiercing", "999");
    setDvar("perk_bulletPenetrationMultiplier", "999");
    setDvar("perk_armorPiercing", "999");
	/*
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
	

	xe = randomintrange(8,10);
    load_fx();
	thread countdown(xe);
*/

vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}


icdvars()
{

    if (level.script == "zm_transit")
    {
    setDvar("scr_screecher_ignore_player", 1); // Denizens do not spawn
    }

	self.isspeaking = 1;
    setdvar( "bg_prone_yawcap", 360 );
    setDvar("bg_ladder_yawcap", 360);
    setdvar("bot_AllowMovement", 1);
    setdvar("bot_PressAttackBtn", 1);
    setdvar("bot_PressMeleeBtn", 1);
    setdvar("jump_slowdownEnable", 0);
    //setdvar("sv_enableBounces", 1);
   // setdvar("sv_cheats", 1);
    setdvar("player_lastStandBleedoutTime", 125);
    setDvar("perk_extendedmeleerange", 3200);
    setDvar("aim_automelee_enabled", 1);
    setDvar("aim_automelee_range", 75); 
    setDvar("aim_autoaim_lerp", 60);        
    setDvar("bg_gravity", 740);   
	setDvar("g_useholdtime", 0);
	setDvar("g_useholdspawndelay", 0);
	setDvar( "dtp_exhaustion_window", 0 );
	setDvar( "player_meleeRange", 64 );
	setDvar( "player_breath_gasp_lerp", 0 );
	setDvar( "perk_weapRateEnhanced", 0 );
	setDvar( "sv_patch_zm_weapons", 0 );
	setDvar( "sv_fix_zm_weapons", 1 );//feet traails
	setDvar( "sv_voice", 2 );
	setDvar( "sv_voiceQuality", 9 );    
	setdvar("aim_automelee_move_limit", 0);
	setDvar( "player_backSpeedScale", 1.7 );

	self setClientDvar( "com_maxfps", 255 );
    //self setClientDvar("cg_fov", 95);


    self setClientDvar("cg_fov_default", 85);
    self setClientDvar("cg_fov", 85);
    self setClientDvar("cg_fov_default_thirdperson", 120);
	self SetClientDvar( "ai_disableSpawn", 0);
    self setclientdvar("player_strafeSpeedScale", 1);
    self setclientdvar("player_sprintStrafeSpeedScale", 1);

	self setClientDvar( "cg_drawBreathHint", 0 );

	self setClientDvar( "cg_friendlyNameFadeIn", 0 );
	self setClientDvar( "cg_friendlyNameFadeOut", 0 );
	self setClientDvar( "cg_enemyNameFadeIn", 0 );
	self setClientDvar( "cg_enemyNameFadeOut", 0 );
    self setClientDvar( "safeArea_horizontal", 0.85);
    self setClientDvar( "safeArea_vertical", 0.85);

	self setClientDvar( "waypointOffscreenPointerDistance", 0);
	self setClientDvar( "waypointOffscreenPadTop", 0);
	self setClientDvar( "waypointOffscreenPadBottom", 0);
	self setClientDvar( "waypointPlayerOffsetStand", 0);
	self setClientDvar( "waypointPlayerOffsetCrouch", 0);

	self setClientDvar( "r_fog", 0 );

	//self setClientDvar( "r_lodBiasRigid", -1000 );
	//self setClientDvar( "r_lodBiasSkinned", -1000 );

	//self setClientDvar( "cg_ufo_scaler", 1 );
}


spawnJoin()
{
    level endon("game_ended");
    self endon("disconnect");
    wait 2;
    if (self.sessionstate == "spectator")
    {
        self [[level.spawnplayer]]();
        thread maps\mp\zombies\_zm::refresh_player_navcard_hud();


        self.joining_team = "axis";
        self.leaving_team = self.pers[ "team" ];
        self.team = "axis";
        self.pers["team"] = "axis";
        self.sessionteam = "axis";
		
        self._encounters_team = "A";
		
		if(isDefined(level.gamestarted))
		{
		iprintln("^5" + self.name+" ^7joined late and was instakilled!");
		wait 0.05;
		self notify("imdead");
		self doDamage(8000, self.origin, self);
		self thread maps\mp\zombies\_zm_laststand::laststand_bleedout(.2);

		}
    }
}

playerJoined()
{
    level endon("game_ended");
    self endon("disconnect");
    wait 2;
    if (self.sessionstate == "spectator" && isDefined(level.gamestarted))
    {
        self [[level.spawnplayer]]();
        thread maps\mp\zombies\_zm::refresh_player_navcard_hud();
		iprintln("^5" + self.name+" ^7joined late and was instakilled!");
		wait 0.05;
		self doDamage(8000, self.origin, self);
		self notify("imdead");
		
    }
}

teleports()
{
	self endon("disconnect");
    level endon("game_ended");
	self endon("placed");

	wait 0.05;

	if(self != level.firsthide)
	{
	yodie = randomintrange(1,25);
	if(yodie == 1) self placeme((-726.686, 2.32041, 95.5812), (0, 53.1737, 0));
	if(yodie == 2) self placeme((-60.0143, 645.943, 184.125), (0, -141.037, 0));
	if(yodie == 3) self placeme((1333.6, 1390.82, 200.125), (0, -109.05, 0));
	if(yodie == 4) self placeme((-514.525, -580.898, 136.452), (0, 102.041, 0));
	if(yodie == 5) self placeme((-907.184, 529.44, 418.735), (0, -58.4476, 0));
	if(yodie == 6) self placeme((-557.776, -896.53, 150.623), (0, 92.8398, 0));
	if(yodie == 7) self placeme((524.163, -998.121, 208.125), (0, 167.547, 0));
	if(yodie == 8) self placeme((-18.2461, -1293.12, 168.125), (0, -58.4476, 0));
	if(yodie == 9) self placeme((216.631, 1322.01, 144.125), (0, -90.3848, 0));
	if(yodie == 10) self placeme((270.229, -1791.61, 158.344), (0, -104.128, 0));
	if(yodie == 11) self placeme((1046.23, -1779.2, 120.125), (0, 135.511, 0));
	if(yodie == 12) self placeme((-596.701, -1253.71, 144.125),(0, 84.523, 0));
	if(yodie == 13) self placeme((-93.3387, -1920.75, 271.21),(0, 30.8713, 0));
	if(yodie == 14) self placeme((138.129, -1943.72, -1.31706),(0, 92.0541, 0));
	if(yodie == 15) self placeme((-240.356, -164.782, 8.125),(0, -90.1816, 0));
	if(yodie == 16) self placeme((952.284, -1056.71, 56.125),(0, -177.946, 0));
	if(yodie == 17) self placeme((314.336, 1355.42, 8.125),(0, 178.846, 0));
	if(yodie == 18) self placeme((-25.8415, 86.4007, 328.267),(0, 80.1889, 0));
	if(yodie == 19) self placeme((-1039.97, 344.401, 377.267),(0, 40.0723, 0));
	if(yodie == 20) self placeme((-809.11, -132.617, 288.125),(0, -88.7863, 0));
	if(yodie == 21) self placeme((-271.163, 809.047, 143.211),(0, -87.6437, 0));
	if(yodie == 22) self placeme((-660.254, 989.631, 8.125),(0, -90.0827, 0));
	if(yodie == 23) self placeme((2357.2, 549.805, 104.125),(0, 179.159, 0));
	if(yodie == 24) self placeme((1651.85, 2264.84, 40.125),(0, -110.363, 0));
	if(yodie == 25) self placeme((2241.36, 1076.87, 0.532076),(0, -155.704, 0));
	if(yodie == 26) self placeme((2325.19, 49.2639, 88.125),(0, 130.105, 0));
	if(yodie == 27) self placeme((1710.71, 59.6023, 11.2848),(0, 61.3308, 0));
	if(yodie == 28) self placeme((1191.88, 1480.51, -19.875),(0, -105.843, 0));
	if(yodie == 29) self placeme((762.572, -327.441, 132.8),(0, 138.878, 0));
	if(yodie == 30) self placeme((762.572, -327.441, 132.8),(0, 138.878, 0));
	if(yodie == 31) self placeme((-1176.04, 576.353, 144.125),(0, -38.3043, 0));
	if(yodie == 32) self placeme((1315.98, -1722.07, 142.65),(0, -142.46, 0));
	if(yodie == 33) self placeme((792.775, -1922.56, 192.125),(0, 92.867, 0));
	if(yodie == 34) self placeme((419.891, -1651.89, 61.9308),(0, 52.4758, 0));
	if(yodie == 35) self placeme((787.799, -927.675, 287.407),(0, 179.401, 0));
	if(yodie == 36) self placeme((563.746, -781.516, 149.631),(0, -178.358, 0));
	if(yodie == 37) self placeme((496.359, -399.641, 165.893),(0, -140.488, 0));
	if(yodie == 38) self placeme((623.641, 1015.64, 4.19873),(0, 12.8316, 0));
	if(yodie == 39) self placeme((1635.85, 1585.66, 15.0732),(0, 119.575, 0));
	if(yodie == 40) self placeme((1126.87, 2172.52, 45.2193),(0, -2.93378, 0));
	} else {

	yodie = randomintrange(1,5);
	wait 1;
	if(yodie == 1) level.firsthide placeme((-2948.1, -218.667, 1414.37), (0, -90.3189, 0));
	if(yodie == 2) level.firsthide placeme((-268.958, 839.839, 144.125),(0, -91.9833, 0));
	if(yodie == 3) level.firsthide placeme((-711.235, 1051.96, 8.125),(0, -76.0751, 0));
	if(yodie == 4) level.firsthide placeme((493.996, -274.331, 8.125),(0, 39.5285, 0));
	if(yodie == 5) 
	{
		level.firsthide thread godown();
	}
	}

}



placeme(origin, angles)
{
	self setorigin(origin);
	self setplayerangles(angles);
	
	self notify("placed");
	self freezecontrolsallowlook(true);
	wait 1;
	self FreezeControlsAllowLook(false);
}


spawnteleports()
{
	self endon("disconnect");
    level endon("game_ended");


	yodie = randomintrange(1,21);
	if(yodie == 1) self placeme((-726.686, 2.32041, 95.5812), (0, 53.1737, 0));
	if(yodie == 2) self placeme((-60.0143, 645.943, 184.125), (0, -141.037, 0));
	if(yodie == 3) self placeme((1333.6, 1390.82, 200.125), (0, -109.05, 0));
	if(yodie == 4) self placeme((-514.525, -580.898, 136.452), (0, 102.041, 0));
	if(yodie == 5) self placeme((-907.184, 529.44, 418.735), (0, -58.4476, 0));
	if(yodie == 6) self placeme((-557.776, -896.53, 150.623), (0, 92.8398, 0));
	if(yodie == 7) self placeme((524.163, -998.121, 208.125), (0, 167.547, 0));
	if(yodie == 8) self placeme((-18.2461, -1293.12, 168.125), (0, -58.4476, 0));
	if(yodie == 9) self placeme((216.631, 1322.01, 144.125), (0, -90.3848, 0));
	if(yodie == 10) self placeme((270.229, -1791.61, 158.344), (0, -104.128, 0));
	if(yodie == 11) self placeme((1046.23, -1779.2, 120.125), (0, 135.511, 0));
	if(yodie == 12) self placeme((-596.701, -1253.71, 144.125),(0, 84.523, 0));
	if(yodie == 13) self placeme((-93.3387, -1920.75, 271.21),(0, 30.8713, 0));
	if(yodie == 14) self placeme((138.129, -1943.72, -1.31706),(0, 92.0541, 0));
	if(yodie == 15) self placeme((-240.356, -164.782, 8.125),(0, -90.1816, 0));
	if(yodie == 16) self placeme((952.284, -1056.71, 56.125),(0, -177.946, 0));
	if(yodie == 17) self placeme((314.336, 1355.42, 8.125),(0, 178.846, 0));
	if(yodie == 18) self placeme((-25.8415, 86.4007, 328.267),(0, 80.1889, 0));
	if(yodie == 19) self placeme((-1039.97, 344.401, 377.267),(0, 40.0723, 0));
	if(yodie == 20) self placeme((-809.11, -132.617, 288.125),(0, -88.7863, 0));
	if(yodie == 21) self placeme((-271.163, 809.047, 143.211),(0, -87.6437, 0));
	

}


countdown( waittime )
{
	level endon( "game_started" );
	level.custom_timelimit = getDvarIntDefault( "hideTimelimit", 10 );
	//level.firsthide = "";
	level.hidetable = [];
	level.count_down = waittime;
	level.waiting = 0;
	level.mins_to_add = 0;
	level waittill( "prematch_over" );
	level.disableweapondrop = 1;
	players = get_players();
	level enableInvulnerability();
	level.playerwait = strTok("waiting for ^3players^7, waiting for ^6players^7, waiting for ^2players^7, waiting for ^2players^7, waiting for ^1players^7, waiting for ^4players^7", ",");
	level.playerrand = RandomInt(self.playerwait.size);
	level.check = self.playerwait[self.playerrand];

	while ( players.size <= 2 )
	{
		players = get_players();
		wait 1;
		iprintlnbold( level.check );
		level.waiting++;
		if( level.waiting == 60 )
		{
			level.waiting = 1;
			level.mins_to_add++;
		}
	}
	if( level.mins_to_add > 0 )
	{
		setgametypesetting( "timelimit", ( level.custom_timelimit + level.mins_to_add ));
	}
	else
	{
		setgametypesetting( "timelimit", level.custom_timelimit );
	}
	wait 1;
	for( i = waittime; i >= 0; i-- )
	{

		level.seekerwait = strTok("game starting in ^2, game starting in ^6, game starting in ^3, game starting in ^1, game starting in ^5, game starting in ^9, game starting in ^4", ",");
		level.seekerrand = RandomInt(self.seekerwait.size);
		level.seeka = self.seekerwait[self.seekerrand];
		
		iprintlnbold( level.seeka + level.count_down );
		level.count_down--;
		wait 1;
		if( level.count_down == 0 )
		{

			level disableInvulnerability();
			level.firsthide = pickRandomPlayer();
			level.firsthide.seeker = true;
    		level.firsthide setclientuivisibilityflag("hud_visible", 0);
			//level.firsthide suicide();
			level.firsthide saveXUID( level.firsthide getXUID() );
			level.firsthide enableInvulnerability();


			foreach( player in level.players )
			{
				if( player.pers[ "team" ] == "axis" )
				{

					player.joining_team = "axis";
    				player.leaving_team = player.pers[ "allies" ];
    				player.team = "axis";
    				player.pers["team"] = "axis";
    				player.sessionteam = "axis";
    				player._encounters_team = "A";	

					player thread hider();
					player thread set_perma_perks();
					player thread equipmentcooldown();
					
					player allowSpectateTeam("allies", true);
					player allowSpectateTeam("axis", true);
					player allowSpectateTeam("freelook", true);
					player allowSpectateTeam("none", true);	
					
					player setperk("specialty_nottargetedbyairsupport");
					player setperk("specialty_nokillstreakreticle");
					player setperk("specialty_nottargettedbysentry");
					player setperk("specialty_stalker");
					player setperk("specialty_quieter");
					player setperk("specialty_reconnaissance");
					player setperk("specialty_nomotionsensor");
					player setperk("specialty_noname");


					//player_spawn_override();

					// round start for hiders
                } else if( player.pers[ "team" ] == "allies" ) {

					level thread enable_fountain_transport();
					level.hider = player.name;
					player thread set_perma_perks();
					player thread equipmentcooldown();
                    player thread fadeToBlack( 0.25, 9.5, 0.25, 0.75 );
					player iprintln("Status: ^8Seeker");
					player iprintln("Relocating to ^8Seeker^7 spawn.");
					player thread seeker();
				//	player thread trapper();
	   				player.joining_team = "allies";
        			player.leaving_team = player.pers[ "team" ];
        			player.team = "allies";
        			player.pers["team"] = "allies";
        			player.sessionteam = "allies";
        			player._encounters_team = "B";	
				//	player thread trapper();
					player setperk("specialty_nottargetedbyairsupport");
					player setperk("specialty_nokillstreakreticle");
					player setperk("specialty_nottargettedbysentry");
					player setperk("specialty_quieter");
					player setperk("specialty_stalker");
					player setperk("specialty_reconnaissance");
					player setperk("specialty_nomotionsensor");
					player setperk("specialty_noname");
					player setperk("specialty_healthregen");

					player allowSpectateTeam("allies", true);
					player allowSpectateTeam("axis", true);
					player allowSpectateTeam("freelook", true);
					player allowSpectateTeam("none", true);	


                }
			player thread tBouncer();
		//	player thread tSeeker();
			}


			level notify( "game_started" );
			level notify( "courtyard_fountain_open" );
			level.gamestarted = true;
    		level setclientuivisibilityflag("hud_visible", 0);

			
		}
    }
	}
	
onPlayerDowned()
{
	self endon("disconnect");
	level endon("end_game");
	
	for(;;)
	{

		self waittill_any( "player_downed", "fake_death", "entering_last_stand");	

		self.downed = true;
		
		last_player = undefined;
		last_player.last = undefined;

		if(isDefined(last_player.last))
		{
			self.sessionstate = "spectator"; 
		}



		self thread play_sound_at_pos( "music_chest", self.origin );
		self thread veryhurt_blood_fx();
		self thread maps\mp\animscripts\zm_death::flame_death_fx();
		level thread update_players_on_downed( self );


		playfx( level._effect["poltergeist"], self.origin );


		self.statusicon = "hud_status_dead";
		self.imdead = true;
		self.imfrdead = undefined;
		bleedout = randomintrange(0,15);
		
		iprintln("^5" + fixedNames() + "^7 is down! They will die in ^5"+bleedout+" ^7seconds^7.");
		
    	//self magicgrenadetype( "frag_grenade_zm", self.origin + ( 20, 0, 0 ), ( 50, 0, 400 ), 1 );
    	self magicgrenadetype( "frag_grenade_zm", self.origin + ( 20, 0, 0 ), ( 50, 0, 400 ), 1.5 );

		wait bleedout;

		if(isDefined(self.downed) && !isDefined(last_player.last))
		{
			
		playfx( level._effect["ring_glow"], self.origin );
		playfx( level.effect["zombie_guts_explosion"], self.origin);
		self.is_playing = undefined;
		self.imfrdead = true;
		self.imdead = undefined;
    	self.sessionstate = "spectator"; 
		iprintln("^5" + fixedNames() + "^7 bled out!");
		self notify("imdead");
		// clearLowerMessage();
		// self thread maps\mp\zombies\_zm_spawner::zombie_head_gib()
		} else {
		iprintln("^5" + fixedNames() + "^7 was ^3revived^7 and survived the seeker!");
		self.downed = undefined;

		}
	
	}
}

onPlayerRevived()
{
	self endon("disconnect");
	level endon("end_game");
	
	for(;;)
	{
		self waittill_any( "whos_who_self_revive","player_revived","fake_revive","do_revive_ended_normally", "al_t" );
		if(!self.sessionstate == "spectator")
		{
		//self notify( "powerup_timedout" );
		wait 0.05;
		self.downed = undefined;
		self.imfrdead = undefined;
		self.statusicon = "";
		testfx = randomize("powerup_grabbed_wave_solo;powerup_grabbed_solo;powerup_grabbed_wave_caution;powerup_grabbed;powerup_grabbed_caution;powerup_off");
		self.testfx = testfx;	
		self thread rperks();
		self thread grace();
		self.deathcause = undefined;


	} else {
		iprintln("^5" + fixedNames() + "^7 was revived but already ^1bled^7 out!");
	}
	}
}


pickRandomPlayer(d)
{
	randomnum = randomintrange( 0, level.players.size );
	seeker = level.players[ randomnum ];
	//seeker = level.players[ 0 ];
    seeker.joining_team = "allies";
    seeker.leaving_team = seeker.pers[ "team" ];
    seeker.team = "allies";
    seeker.pers["team"] = "allies";
    seeker.sessionteam = "allies";
    seeker._encounters_team = "B";
	return seeker;
}

hider()
{

/*
	self thread war_ride(22);
	self thread g_impact();
	self thread ride();
*/
	self iprintln("Status: ^3Hider");
	self thread show_grief_hud_msg("Grace period has started! 20 seconds remaining.");
	self takeallweapons();
	self giveweapon("knife_zm");
	self giveweapon("m1911_zm");
	self switchtoweapon("m1911_zm");

	x = randomintrange(0,3);
	self setweaponammostock("m1911_zm", x);
	self setweaponammoclip("m1911_zm", x);

	self takeweapon("raygun_mark2_zm");
	self takeweapon("raygun_mark2_zm");
	self takeweapon("raygun_mark2_zm_upgraded");
	self takeweapon("raygun_mark2_zm_upgraded");
	
	self.seekers = undefined;
	self.dupecheck = true;	
	self.deathcause = undefined;
	self.snitch = undefined;
	self.hider = self.name;
    self setclientuivisibilityflag("hud_visible", 0);
	self thread deflects();
	self thread zone_hud();
	//self thread status_hud();
	self thread monitor_reviving();
	self enableInvulnerability();
	self.graceperiod = true;
	wait 20;
	self disableInvulnerability();
	self.graceperiod = undefined;
	self thread show_grief_hud_msg("Grace period is now over!");
    playfx( level._effect[ "poltergeist" ], self.origin);
	self thread snitch();
	self notify("nograce");
}


create_dvar( dvar, set )
{
    if( getDvar( dvar ) == "" )
		setDvar( dvar, set );
}

isDvarAllowed( dvar )
{
	if( getDvar( dvar ) == "" )
		return false;
	else
		return true;
}


disable_player_quotes()
{
	create_dvar( "disable_player_quotes", 1 );
    
    self endon("disconnect");
    for(;;)
    {
		if( getDvarInt( "disable_player_quotes" ) )
		{
			self.isspeaking = 1;
		}
		wait 0.5;
	}
}

set_visionset()
{
	self useservervisionset(1);
	self setvisionsetforplayer(GetDvar( "mapname" ), 1.0 );
	// visionSetNaked( GetDvar( "mapname" ), 1.0 );
	// self setvisionsetforplayer("", 0 );
}

graphic_tweaks()
{
	if( level.script != "zm_tomb")
		self setclientdvar("r_fog", 0.3);
	self setclientdvar("r_dof_enable", 0);
	self setclientdvar("r_lodBiasRigid", -1000); // casues error when nocliping
	self setclientdvar("r_lodBiasSkinned", -1000);
	self setClientDvar("r_lodScaleRigid", 1);
	self setClientDvar("r_lodScaleSkinned", 1);
	self setclientdvar("sm_sunquality", 2);
	self setclientdvar("r_enablePlayerShadow", 1);
	self setclientdvar( "vc_fbm", "0 0 0 0" );
	self setclientdvar( "vc_fsm", "1 1 1 1" );
	self setclientdvar( "vc_fgm", "1 1 1 1" );
	// self setclientdvar( "r_skyColorTemp", 25000 );
}


deflects()
{
	players = get_players();
	hello = randomintrange(1,6);

	if(hello <= 2)
	{
	xd = randomize("zombie_skull;zombie_ammocan;zombie_bomb;zombie_pickup_perk_bottle;zombie_x2_icon;zombie_z_money_icon;");
	self attach(xd, "J_Eyeball_LE", true);
	self attach(xd, "J_Wrist_LE", true);
	self attach(xd, "J_Wrist_RI", true);
	self attach(xd, "J_Knee_RI", true);
	self attach(xd, "J_Knee_LE", true);
	wait 3;
	self iprintln("You have been ^3deflected^7!");
	print("deflected: " + self.name);
	} else {

	}
}

decidetime()
{
		players = get_players();
		
		bb = randomintrange(25, 35);
		// self.counter = time to seek
		if(players.size == 3) self.counter = 10;
		if(players.size == 4) self.counter = 15;
		if(players.size == 5) self.counter = 20;
		if(players.size >= 6) self.counter = bb;

		x = self.counter;
		return x;
}

seeker()
{
	a = decideTime();
	for( i = a; i >= 1; i-- )
	{
		self.seekers = true;
		self.lastseeker = true;
		iprintlnbold( "The seeker will roam in ^3" + self.counter );	

		self.counter--;
		self freezecontrols(true);
		self hide();
		
		self takeallweapons();
		wait 1;
		if( i == 1 )
		{
		xd = randomize("zombie_skull;zombie_ammocan;zombie_bomb;zombie_pickup_perk_bottle;zombie_x2_icon;zombie_z_money_icon;");
		self attach(xd, "J_Eyeball_LE", true);	
		print("game started, seeker is: " + self.name);
		print("playing this round: " + level.players.size);
		self thread show_grief_hud_msg("Grace period has started! 10 seconds remaining.");
		level.firsthide setclientuivisibilityflag("hud_visible", 0);
		iprintlnbold( "The seeker is ^3now roaming^7 - Seeker: ^3" + fixSeeker());
		self notify("roaming");
		self disableInvulnerability();
        self thread give_perks_by_map();
		//self thread spork();
		self thread zomb_model();
		self thread ivisionres();
		self show();
		wait 1;
		self.snitch = true;
		self.health = 9999;
		self.maxHealth = 9999;
		self freezecontrols(false);
		self.dupecheck = true;
		self takeweapon("m1911_zm");
		self takeweapon("raygun_mark2_zm");
		self giveweapon("knife_ballistic_bowie_zm");
		self switchtoweapon("knife_ballistic_bowie_zm");
		self giveweapon("knife_zm");

		weapseek = self getcurrentweapon();
		self setweaponammostock(weapseek, 0);
		self setweaponammostock("knife_ballistic_bowie_zm", 0);	
		wait 16;
		self thread show_grief_hud_msg("Grace period is now over, Time to hunt!");
	}
		level notify( "game_started" );
	}
}


ally(player)
{
    
        player.joining_team = "allies";
        player.leaving_team = player.pers[ "team" ];
        player.team = "allies";
        player.pers["team"] = "allies";
        player.sessionteam = "allies";
        player._encounters_team = "B";
}

checkXUID( XUID )
{
	if( IsInArray( level.hidetable, XUID ))
	{
		self.hide = true;
	}
}

saveXUID( XUID )
{
	if( !IsInArray( level.hidetable, XUID ))
	{
		level.hidetable[ level.hidetable.size ] = XUID;
	}
}

didyouknow()
{
	self endon("disconnect");
	self endon("stopalooping");

	Messages=[];
	Messages[0]="Press ^3[{+actionslot 2}]^7 to bring out your melee weapon";
	Messages[1]="Your footsteps leave ^3no^7 sound";
	Messages[2]="Snipers are given to the ^3Last Player^7 and the ^8Seeker";
//	Messages[3]="You have ^58^7 seconds to revive your allies before they bleed out";
	Messages[3]="Go into third person by pressing ^3[{+actionslot 1}]^7";
	Messages[4]="Create a temporary bounce using ^3[{+actionslot 4}]^7 (^310^7s cooldown)";
	Messages[5]="Press ^3[{+actionslot 3}]^7 to canswap your current weapon";

	for(;;)
	{
		wait(60);
		self iprintln(Messages[randomint(Messages.size)]);
	}
}

thirdperson()
{
    self endon ("disconnect");
	self endon ("game_ended");

	self iprintln("Press ^3[{+actionslot 1}] ^7for ^3third person^7");
	for(;;)
	{
			if(self actionslotonebuttonpressed() )
			{
				if(!isDefined(self.lastseeker))
				{
				self thread toggleThirdPerson();
				} else if(isDefined(self.lastseeker))
				{
					self iprintln("^7You can only use this as a ^3hider^7!");
				}
			}
			wait 0.05; 
		} 
}




toggleThirdPerson()
{
	if(!isDefined(self.t3rd))
	{
		self.t3rd = true;
		self setclientthirdperson(true);
	}
	else
	{
		self.t3rd = undefined;
		self setclientthirdperson(false);
	}
}