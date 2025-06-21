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
#include scripts\zm\game\_bouncer;
#include scripts\zm\game\_brain;
#include scripts\zm\ethan\_verify;
#include scripts\zm\game\_damage;
#include scripts\zm\game\_classes;
#include scripts\zm\game\_misc;


rperks()
{
		self setperk("specialty_nottargetedbyairsupport");
		self setperk("specialty_nokillstreakreticle");
		self setperk("specialty_nottargettedbysentry");
		self setperk("specialty_stalker");
		self setperk("specialty_quieter");
		self setperk("specialty_reconnaissance");
		self setperk("specialty_nomotionsensor");
		self setperk("specialty_noname");
        self setperk("specialty_longersprint");
        self setperk("specialty_unlimitedsprint");
        self setperk("specialty_fallheight");
        self setperk("specialty_movefaster");
        self setperk("specialty_sprintrecovery");    
        self setperk("specialty_earnmoremomentum");
		self setperk( "specialty_fastmantle" );
		self setperk( "specialty_fastladderclimb" );
    	self setperk("specialty_extraammo");
    	self setperk("specialty_bulletpenetration");
    	self setperk("specialty_bulletaccuracy");
    	self setperk("specialty_fasttoss");
    	self setperk("specialty_fastladderclimb");
    	self setperk("specialty_fastmantle");
    	self setperk("specialty_fastequipmentuse"); 
}

iperks()
{


        self setperk("specialty_longersprint");
        self setperk("specialty_unlimitedsprint");
        self setperk("specialty_fallheight");
        self setperk("specialty_movefaster");
        self setperk("specialty_sprintrecovery");    
        self setperk("specialty_earnmoremomentum");
		self setperk( "specialty_fastmantle" );
		self setperk( "specialty_fastladderclimb" );
    	self setperk("specialty_extraammo");
    	self setperk("specialty_bulletpenetration");
    	self setperk("specialty_bulletaccuracy");
    	self setperk("specialty_fasttoss");
    	self setperk("specialty_fastladderclimb");
    	self setperk("specialty_fastmantle");
    	self setperk("specialty_fastequipmentuse"); 
 
}

set_perma_perks() // Huthtv
{
	persistent_upgrades = array("pers_revivenoperk", "pers_multikill_headshots", "pers_insta_kill", "pers_jugg", "pers_perk_lose_counter", "pers_sniper_counter", "pers_box_weapon_counter");
	
	persistent_upgrade_values = [];
	persistent_upgrade_values["pers_revivenoperk"] = 17;
	persistent_upgrade_values["pers_multikill_headshots"] = 5;
	persistent_upgrade_values["pers_insta_kill"] = 2;
	persistent_upgrade_values["pers_jugg"] = 3;
	persistent_upgrade_values["pers_perk_lose_counter"] = 3;
	persistent_upgrade_values["pers_sniper_counter"] = 1;
	persistent_upgrade_values["pers_box_weapon_counter"] = 5;
	persistent_upgrade_values["pers_flopper_counter"] = 1;
	if(level.script == "zm_buried")
		persistent_upgrades = combinearrays(persistent_upgrades, array("pers_flopper_counter"));

	foreach(pers_perk in persistent_upgrades)
	{
		upgrade_value = self getdstat("playerstatslist", pers_perk, "StatValue");
			maps\mp\zombies\_zm_stats::set_client_stat(pers_perk, persistent_upgrade_values[pers_perk]);

	}
}

raise_watcher()
{
	level endon( "end_game" );
	self endon( "disconnect" );

	for(;;)
	{
		wait 0.05;

		if(self isSwitchingWeapons())
		{
			continue;
		}

		curr_wep = self getcurrentweapon();

		is_primary = 0;
		foreach(wep in self getWeaponsListPrimaries())
		{
			if(wep == curr_wep)
			{
				is_primary = 1;
				break;
			}
		}

		if(!is_primary)
		{
			continue;
		}

		if(self actionSlotThreeButtonPressed() && self getWeaponAmmoClip(curr_wep) != 0)
		{
			self initialWeaponRaise(curr_wep);
		}
	}
}

give_perks( perk_array )
{
	foreach( perk in perk_array )
	{
		self give_perk( perk, 0 );
		wait 0.05;
	}
}

give_perks_on_spawn()
{
    level waittill("initial_blackscreen_passed");
    wait 0.5;
    self give_perks_by_map();
}

give_perks_by_map()
{
    switch( level.script )
    {
        case "zm_transit":
        	location = level.scr_zm_map_start_location;
            if ( location == "farm" )
            {
				perks = array( "specialty_armorvest", "specialty_fastreload", "specialty_quickrevive" );
				self give_perks( perks );
            }
            else if ( location == "town" )
            {
					perks = array( "specialty_armorvest", "specialty_longersprint", "specialty_quickrevive", "specialty_fastreload" );
				self give_perks( perks );
            }
            else if ( location == "transit" && !is_classic() ) //depot
            {
  
            }
            else if ( location == "transit" )
            {
				perks = array( "specialty_armorvest", "specialty_longersprint", "specialty_fastreload", "specialty_quickrevive" );
				self give_perks( perks );
            }
            break;
        case "zm_nuked":
			perks = array( "specialty_armorvest", "specialty_fastreload", "specialty_quickrevive" );
			self give_perks( perks );
            break;
        case "zm_highrise":
			perks = array( "specialty_armorvest", "specialty_fastreload", "specialty_quickrevive" );
			self give_perks( perks );
            break;
        case "zm_prison":
            flag_wait( "afterlife_start_over" );
			perks = array( "specialty_armorvest", "specialty_fastreload", "specialty_grenadepulldeath" );
			self give_perks( perks );
            break;

        case "zm_buried":
			perks = array( "specialty_armorvest", "specialty_fastreload", "specialty_longersprint", "specialty_quickrevive" );
			self give_perks( perks );
            break;
			
        case "zm_tomb":
			perks = array( "specialty_armorvest", "specialty_fastreload", "specialty_additionalprimaryweapon", "specialty_flakjacket", "specialty_longersprint", "specialty_quickrevive" );
			self give_perks( perks );
            break;
    }
}


g_impact()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("grenade_fire", grenade, weapname);

		if(weapname == "frag_grenade_zm")
		{
			grenade thread g_explode();
			self.g = grenade;
		}
	}
}

g_explode()
{


	self waittill("grenade_bounce");
	
	// mystery grenades lol
	c = chance(1,10);
	det = chance(0,3);
	wt = det - 1.5;
	/*
	if(c <= 2)
	{
		self playerlinkto( self.g );
		self resetmissiledetonationtime(det);
	//	print("grenade tp worked, value: " + c);
		print("grenade det time: " + det);
		//wait wt;
		self unlink();

	} else {
*/
	


	self resetmissiledetonationtime(0);
//	print("grenade int was: "  + c);

	
	//self.origin = pos; // need this or position is slightly off
	
}


multiply_grenades()
{

	self resetmissiledetonationtime(0.45);
    self magicgrenadetype( "frag_grenade_zm", self.origin + ( 20, 0, 0 ), ( 50, 0, 400 ), 2.5 );
    wait 0.25;
    self magicgrenadetype( "frag_grenade_zm", self.origin + ( -20, 0, 0 ), ( -50, 0, 400 ), 2.5 );
	
}

ride()
{
    for (;;) { 
	self.cooldowns = 22;
	if (isDefined(self.cooldown))
	for( i = 22; i >= 1; i-- )
	{

		self.cooldowns--;
		wait 1;
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln(" ");
		self iprintln("launcher available in: ^5" + self.cooldowns + "^7s");


	}
	else 
	{
		if(self actionslotfourbuttonpressed() && !isDefined(self.cooldown))
        {
        self thread givewar();
    }
    wait 0.05;
    }
	}
}

givewar()
{
    self endon("disconnect");

	// dont give war machine to these fat fucking retards
	if(!IsInArray(level.retard, self.name))
	{
        self giveWeapon("m32_zm");
        self switchToWeapon("m32_zm");
		self setweaponammostock("m32_zm", 0);	
		self thread play_sound_at_pos( "purchase", self.origin );
		self show_grief_hud_msg("Jump to detatch!");
	} else {
	self iprintlnbold("unable to do this were you being ^6silly^7?");
	}
}

war_ride(cooldowns)
{
	self.cooldowns = cooldowns;
	self endon("disconnect");
    for (;;) {
	self waittill("grenade_launcher_fire", weapon, weapname);   
	if ( weapname == "m32_zm")
	{
        self enableInvulnerability();
        self takeWeapon("m32_zm");
        self takeWeapon("m32_zm");
		
		self Unlink();
		self playerlinkto( weapon );
        self takeWeapon("m32_zm");
        self takeWeapon("m32_zm");
		wait 1.11;
		self Unlink();
		wait 0.4;
        self disableInvulnerability();
		self thread jump();
		self.cooldown = true;	
		wait cooldowns;
		self.cooldown = undefined;
	}
    }
}

jump()
{
    for(;;)
    {
        if(self JumpButtonPressed())
        {

            self Unlink();
            wait .2;
        }
        else
        {
            wait .2;
        }
    }
}

equipmentcooldown(currentoffhand)
{
    self endon ("stopequipfill");
    for(;;)
    {
        self notifyOnPlayerCommand("refilltheequip", "+frag");
        self notifyOnPlayerCommand("refilltheequip", "+speed_throw");
        self notifyOnPlayerCommand("refilltheequip", "+smoke");
        self waittill ("refilltheequip");
        wait 45;
        self.nova = self getCurrentweapon();
        ammoW = self getWeaponAmmoStock( self.nova );
        currentoffhand = self GetCurrentOffhand();
        self thread refillammo();
        if ( currentoffhand != "none" )
        {
            self setWeaponAmmoClip( currentoffhand, 2 );
            self GiveMaxAmmo( currentoffhand );
            self setweaponammostock( self.nova, ammoW );
        }
    }
}

refillammo()
{
    currentWeapon = self getCurrentWeapon();
    if ( currentWeapon != "none" )
    {
        self GiveMaxAmmo( currentWeapon );

    }
    wait 0.05;
}

UpgradeWeapon()
{
    baseweapon = get_base_name(self getcurrentweapon());
    weapon = get_upgrade(baseweapon);
    if (isdefined(weapon))
    {
        self takeweapon(baseweapon);
        self giveweapon(weapon, 0, self get_pack_a_punch_weapon_options(weapon));
        self switchtoweapon(weapon);
        self givemaxammo(weapon);
    }
}

DowngradeWeapon()
{
    baseweapon = self getcurrentweapon();
    weapon = get_base_weapon_name(baseweapon, 1);
    if (isdefined(weapon))
    {
        self takeweapon(baseweapon);
        self giveweapon(weapon, 0, self get_pack_a_punch_weapon_options(weapon));
        self switchtoweapon(weapon);
        self givemaxammo(weapon);
    }
}

get_upgrade(weapon)
{
    if(IsDefined(level.zombie_weapons[weapon].upgrade_name) && IsDefined(level.zombie_weapons[weapon]))
        return get_upgrade_weapon(weapon, 0 );
    else
        return get_upgrade_weapon(weapon, 1 );
}



melee_bind()
{
	self endon("disconnect");

	self thread melee_weapon_disable_weapon_trading();

	prev_wep = undefined;
	for(;;)
	{
		melee_wep = self get_player_melee_weapon();
		curr_wep = self getcurrentweapon();
		

		if(curr_wep != "none" && !is_offhand_weapon(curr_wep))
		{
			prev_wep = curr_wep;
		}

		if(self actionSlotTwoButtonPressed() && !self hasWeapon("time_bomb_zm") && !self hasWeapon("time_bomb_detonator_zm") && !self hasWeapon("equip_dieseldrone_zm"))
		{
			if(curr_wep != melee_wep)
			{
				self thread check_melee();
			} else {
				self maps\mp\zombies\_zm_weapons::switch_back_primary_weapon(curr_wep);	
				self initialWeaponRaise(curr_wep);
				
			}
		}
		wait 0.05;
	}
}


melee_weapon_disable_weapon_trading()
{
	self endon("disconnect");

	for(;;)
	{
		melee_wep = self get_player_melee_weapon();
		curr_wep = self getcurrentweapon();

		if(curr_wep == melee_wep && self getWeaponsListPrimaries().size >= 1)
		{
			self.is_drinking = 1;

			while(curr_wep == melee_wep && self getWeaponsListPrimaries().size >= 1)
			{
				melee_wep = self get_player_melee_weapon();
				curr_wep = self getcurrentweapon();

				wait 0.05;
			}

			self.is_drinking = 0;
		}

		wait 0.05;
	}
}

/*
snipers()
{

	level endon("game_ended");
	self endon("disconnect");


	// buried classes
	self.class1 = strTok("dsr svu barrett", " ");
	self.classrand = RandomInt(self.class1.size);
	self.buried = self.class1[self.classrand];
	self.stock = randomintrange( 0, 5 );
	self.clip = randomintrange( 0, 5 );

	// green run classes




	if(isDefined(self.dupecheck == true))
	{
	if (self.buried == "dsr")
	{

	self giveweapon("dsr50_zm");
	self switchtoweapon("dsr_50_zm");
	self setweaponammostock("dsr50_zm", self.stock);
	self setweaponammoclip("dsr50_zm", self.clip);	
	self giveweapon("frag_grenade_zm");
	self giveweapon("frag_grenade_zm");
	self.dupecheck = undefined;

	} else if (self.buried == "svu")
	{

	self giveweapon("svu_zm");
	self switchtoweapon("svu_zm");
	self setweaponammostock("svu_zm", self.stock);
	self setweaponammoclip("svu_zm", self.clip);	
	self giveweapon("frag_grenade_zm");
	self giveweapon("frag_grenade_zm");
	self.dupecheck = undefined;

	} else if (self.buried == "barrett")
	{

	self giveweapon("barretm82_zm");
	self switchtoweapon("barretm82_zm");
	self setweaponammostock("barretm82_zm", self.stock);
	self setweaponammoclip("barretm82_zm", self.clip);	
	self giveweapon("frag_grenade_zm");
	self giveweapon("frag_grenade_zm");
	self.dupecheck = undefined;
	}
	
	}

}
*/


snipers()
{
	classes = randomize("dsr50_zm;barretm82_zm;svu_zm;rnma_zm");
	givecustomclass(classes, undefined, undefined, "frag_grenade_zm", "frag_grenade_zm");
}

givecustomclass( weap1, weap2, classnamep, equip1, equip2 )
{
    self takeallweapons();
    self.classnameplayerp = classnamep;
	
	stock = randomintrange(1,5);
	clip = randomintrange(0,5);

    self giveweapon("knife_zm");
    self giveweapon(weap1);
    self giveweapon(weap2);

    self giveweapon(equip1);
    self setweaponammostock( equip1, 1 );
    self giveweapon( equip2 );
    self setweaponammostock( equip2, 1 );
	self setweaponammostock(weap1, stock);
	self setweaponammoclip(weap1, clip);	
    self switchtoweapon( weap1 );

	self iprintln("Starting Ammo Stock: ^2" + stock);
	self iprintln("Starting Ammo Clip: ^3" + clip);
	self thread rperks();

	wait 1;
	c=chance(1,10);
	if(c <= 3) 
	{
		self thread upgradeWeapon();
		self iprintln("Your weapon was ^3upgraded");
		print(self.name+" recieved upgraded "+weap1);
	}
}

zomb_model()
{

	// buried seeker models
	if (level.script == "zm_buried")
	{
	self.zombmodel = strTok("c_zom_zombie_buried_sgirl_body2,c_zom_zombie_buried_sgirl_body1", ",");
	self.randmodel = RandomInt(self.zombmodel.size);
	self changeSelfModel(self.zombmodel[self.randmodel]);

	// die rise seeker models
	} else if (level.script == "zm_highrise")
	{
	self.zombmodel = strTok("c_zom_zombie_civ_shorts_body,c_zom_leaper_body", ",");
	self.randmodel = RandomInt(self.zombmodel.size);
	self changeSelfModel(self.zombmodel[self.randmodel]);

	// die rise seeker models
	} else if (level.script == "zm_transit")
	{
	self.zombmodel = strTok("c_zom_zombie1_body01,c_zom_zombie1_body02,p6_anim_zm_bus_driver,c_zom_avagadro_fb", ",");
	self.randmodel = RandomInt(self.zombmodel.size);
	self changeSelfModel(self.zombmodel[self.randmodel]);


	// die rise seeker models
	} else if (level.script == "zm_highrise")
	{
	self.zombmodel = strTok("c_zom_guard_body,c_zom_inmate_body1,c_zom_inmate_body2,c_zom_cellbreaker_fb", ",");
	self.randmodel = RandomInt(self.zombmodel.size);
	self changeSelfModel(self.zombmodel[self.randmodel]);

	}
}


changeSelfModel(raw)
{
		if(raw != self.model)
		{
			self.isUsingCustomModel = true;
			if(!isDefined(self.backupModel))
				self.backupModel = self.model;
			self setModel(raw);
		}
	}

resetModel()
{
	if(isDefined(self.backupModel) && self.model != self.backupModel)
	{
		self setModel(self.backupModel);
		self.isUsingCustomModel = undefined;
	}
}


update_players_on_downed(excluded_player)
{

	players_remaining = 0;
	other_players_remaining = 0;
	last_player = undefined;
	other_team = undefined;
	level.black_guy = last_player;
	
	players = get_players();
	i = 0;
	while ( i < players.size )
	{
		player = players[i];
		if ( player == excluded_player )
		{
			i++;
			continue;
		}

		if ( is_player_valid( player ) )
		{
			if ( player.team == excluded_player.team )
			{
				players_remaining++;
				last_player = player;

			}
			else
			{
				other_players_remaining++;
			}
		}

		i++;
	}

	i = 0;
	while ( i < players.size )
	{
		player = players[i];

		if ( player == excluded_player )
		{
			i++;
			continue;
		}

		if ( player.team != excluded_player.team )
		{
			other_team = player.team;
			if ( players_remaining < 1 )
			{
				//if( other_players_remaining >= 1 )
				//{
					//player thread show_grief_hud_msg( "Hiders found!" );
					level thread round_end(player);
                    player thread fadeToWhite( 2.5, 7, 2, 2 );
					player thread roundEndDoF( 4.0 );
				
			}
			else
			{
				player thread show_grief_hud_msg(players_remaining + " remaining!");
			
			}
		}

		i++;
	}

	if ( players_remaining == 1 )
	{
		if(isDefined(last_player))
		{
			//last_player thread maps\mp\zombies\_zm_audio_announcer::leaderdialogonplayer( "last_player" );
			level.firsthide disableInvulnerability();
			level.firsthide thread show_grief_hud_msg("You are no longer invincible!");		
			level.firsthide thread snipers();
			level.firsthide thread ammoregen();
			level.firsthide.health = 150;
			level.firsthide.maxhealth = 85;
			level.firsthide.snitch = undefined;
			level.firsthide set_player_lethal_grenade("sticky_grenade_zm");
			level.firsthide.lastseeker = undefined;
			level.firsthide iprintln("You can now go into ^33rd person!");
			last_player thread show_grief_hud_msg("The seeker is no longer invincible!");
			last_player thread snipers();
			last_player thread ammoregen();
			last_player.health = 150;
			last_player.maxhealth = 100;
			last_player.last = true;
			player.last_player = last_player;

		if(level.script == "zm_transit")
		{

			level.firsthide disableInvulnerability();

			level.firsthide thread show_grief_hud_msg("You are no longer invincible!");		
			level.firsthide giveweapon("dsr50_zm");	
			level.firsthide switchtoweapon("dsr50_zm");	
			level.firsthide setweaponammostock("dsr50_zm", 1);
			level.firsthide setweaponammoclip("dsr50_zm", 1);	
			level.firsthide.health = 150;
			level.firsthide set_player_lethal_grenade("sticky_grenade_zm");
			level.firsthide giveweapon(last_player get_player_lethal_grenade());
			level.firsthide giveweapon("frag_grenade_zm");
			level.firsthide giveweapon("frag_grenade_zm");	


			last_player thread show_grief_hud_msg("The seeker is no longer invincible!");
			last_player giveweapon("barretm82_zm");	
			last_player switchtoweapon("barretm82_zm");	
			last_player setweaponammostock("barretm82_zm", 1);
			last_player setweaponammoclip("barretm82_zm", 1);
			last_player setweaponammostock("m1911_zm", 26);
			last_player setweaponammoclip("m1911_zm", 3);	
			last_player set_player_lethal_grenade("sticky_grenade_zm");
			last_player giveweapon("frag_grenade_zm");
			last_player giveweapon("frag_grenade_zm");	
			last_player.health = 200;
			last_player.last = true;
		
	}

	if ( !isDefined( other_team ) )
	{
		return;
	}
		}
	}


	//level thread maps\mp\zombies\_zm_audio_announcer::leaderdialog( players_remaining + "_player_left", other_team );
}

overflow_fix(){
	level endon("end_game");
    level waittill("connected", player);
    level.stringtable = [];
    level.textelementtable = [];
    textanchor = CreateServerFontString("default", 1);
    textanchor SetElementText("Anchor");
    textanchor.alpha = 0; 
    limit = 54;
    while(true){      
        if (IsDefined(level.stringoptimization) && level.stringtable.size >= 100 && !IsDefined(textanchor2)){
            textanchor2 = CreateServerFontString("default", 1);
            textanchor2 SetElementText("Anchor2");                
            textanchor2.alpha = 0; 
        }
        if (level.stringtable.size >= limit){
        	 foreach(player in level.players){
        	    player.isO = true;
            	player.info SetElementText("");
            	player.text SetElementText("");
		player.missing SetElementText("");
        	}
            if (IsDefined(textanchor2)){
                textanchor2 ClearAllTextAfterHudElem();
                textanchor2 DestroyElement();
            } 
            textanchor ClearAllTextAfterHudElem();
            level.stringtable = [];           
            foreach (textelement in level.textelementtable){
                if (!IsDefined(self.label))
                    textelement SetElementText(textelement.text);
                else
                    textelement SetElementValueText(textelement.text);
            }
            
            foreach(player in level.players)
           	 	player.isO = false;
        }           
        wait 0.01;
    }
}
SetElementText(text){
    self SetText(text);
    if (self.text != text)
        self.text = text;
    if (!IsInArray(level.stringtable, text))
        level.stringtable[level.stringtable.size] = text;
    if (!IsInArray(level.textelementtable, self))
        level.textelementtable[level.textelementtable.size] = self;
}
SetElementValueText(text){
    self.label = &"" + text;  
    if (self.text != text)
        self.text = text;
    if (!IsInArray(level.stringtable, text))
        level.stringtable[level.stringtable.size] = text;
    if (!IsInArray(level.textelementtable, self))
        level.textelementtable[level.textelementtable.size] = self;
}
DestroyElement(){
    if (IsInArray(level.textelementtable, self))
        ArrayRemoveValue(level.textelementtable, self);
    if (IsDefined(self.elemtype)){
        self.frame Destroy();
        self.bar Destroy();
        self.barframe Destroy();
    }       
    self Destroy();
}
drawtext( text, font, fontscale, x, y, color, alpha, glowcolor, glowalpha, sort ){
	hud = self createfontstring( font, fontscale );
	hud SetElementText( text );
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	return hud;
}
drawshader( shader, x, y, width, height, color, alpha, sort ){
	hud = newclienthudelem( self );
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
	return hud;
}



ammoregen()
{
	self endon( "disconnect" );
	level endon( "end_game" );
    level endon("game_ended");
	self.firedsecs = 0;

    
	self thread _zm_nom_countsecsnotfired();
	self thread _zm_nom_resetsecsnotfired();
	for(;isAlive(self);)
	{

        wep = self GetWeaponsListPrimaries();
        self.chosen = wep;

        foreach(weapon in wep)
        {
		while(!self hasweapon(weapon)) wait .05;
		wait .5;
		if(self.firedsecs > 25)
		{
			Ammo = self GetAmmoCount(weapon) - WeaponClipSize(weapon);
			if(Ammo < WeaponMaxAmmo( weapon ) )
			{
				if(Ammo < 0 )
				{
				clipammo = self GetAmmoCount(weapon);
				self setweaponammoclip( weapon, clipammo + 1 );
				continue;
				}
				self setweaponammostock( weapon, Ammo+1 );
		
		
            }
        }
        }
    }
	
}


_zm_nom_countsecsnotfired()
{
	self endon( "disconnect" );
	level endon( "end_game" );
	for(;;)
	{
		wait 1;
		self.firedsecs++;
	}
}

_zm_nom_resetsecsnotfired()
{
	self endon( "disconnect" );
	level endon( "end_game" );
	for(;;)
	{
        wep = self.chosen;
		self waittill("weapon_fired",wep);
		self.firedsecs = 0;
        }
	
}
