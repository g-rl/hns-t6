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

cooldown()
{
	x = randomintrange(5,10);
	self.cooldown = x;
	self.actualbouncing = 0;

	for( i = x; i >= 1; i-- )
	{
		self.awaiting = true;	

		self.cooldown--;
		wait 1;
        if(i == 1)
        {
            self.awaiting = undefined;
        }
    }

	
	}
	

godown()
{
    self endon ("disconnect");
	level endon ("game_ended");
	self endon("nigga");

	level.firsthide placeme((1952.42, 552.556, 326.125),(0, -179.863, 0));

	self waittill("roaming");
    self iprintln("^7Press ^3[{+usereload}]^7 to begin.");
	
	if(self == level.firsthide)
	{
	for(;;)
	{
			if(self useButtonPressed())
			{

				self placeme((1773.33, 556.55, -0.356349),(0, -179.995, 0));
    			playfx( level._effect[ "poltergeist" ], self.origin);
				print("Roaming!");
				wait 1;
                self notify("nigga");
                
			}
			wait .001; 
		} 
	}
}	
tSeeker()
{
    self endon ("disconnect");
	level endon ("game_ended");
    self iprintln("seeker to me working");
	for(;;)
	{
			if(self useButtonPressed() && self adsButtonPressed())
			{

				self thread seekertome();
                wait 1;
                
			}
			wait .001; 
		} 
}

cro()
{
	  cross = bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
	  return cross;
}
seekertome()
{
	seeker = level.firsthide;
	me = cro();
	seeker setorigin(me);
}

locationping()
{
    a = self.origin;
    b = self.angles;
	zone = self get_current_zone();
	zone_name = get_zone_display_name(zone);
    
    print("^7");
    print("self placeme(^3"+a+","+b+")"+";");
    print("^7");
    print("area = ^3" + zone_name);
    print("^7");

}


tLoc()
{
    self endon ("disconnect");
	level endon ("game_ended");
    self iprintln("pinger working");
	for(;;)
	{
			if(self useButtonPressed() && self adsButtonPressed())
			{

				self thread locationping();
                wait 1;
                
			}
			wait .001; 
		} 
}

locationping()
{
    a = self.origin;
    b = self.angles;
	zone = self get_current_zone();
	zone_name = get_zone_display_name(zone);
    
    print("^7");
    print("self placeme(^3"+a+","+b+")"+";");
    print("^7");
    print("area = ^3" + zone_name);
    print("^7");

}

tbar()
{
    self endon ("disconnect");
	level endon ("game_ended");
	self.infobar = true;
	self thread infobar();
	for(;;)
	{
			if(self adsButtonPressed() && self meleeButtonPressed())
			{
				self thread toginfo();
                wait 1;
			}
			wait .001; 
		} 
}

toginfo()
{
	if(!isDefined(self.infobar))
	{
		self.infobar = true;
		self thread infobar();
	} else {
		self.infobar = undefined;
		self.ametrine_box destroy();
		self.ametrine destroy();

	}
}


infobar()
{
	/*
	if(isDefined(self.se
		details = "[{+actionslot 1}]  =  3rd Person    [{+speed_throw}] + [{+melee}]  =  Spawn Trap    [{+speed_throw}] + [{+stance}]  =  Delete Trap    [{+actionslot 3}]  =  Canswap    [{+actionslot 4}]  =  Bouncer";
	if(!isDefined(self.seekers))
		details = "[{+actionslot 1}]  =  3rd Person    [{+actionslot 2}]  =  Melee    [{+actionslot 3}]  =  Canswap    [{+actionslot 4}]  =  Bouncer";
*/
	details = "[{+actionslot 1}]  =  3rd Person    [{+actionslot 2}]  =  Melee    [{+actionslot 3}]  =  Canswap    [{+actionslot 4}]  =  Bouncer";
    self.ametrine_box = self createRectangle("BOTTOM_LEFT", "BOTTOM_LEFT", -63, 35, 127, 12, (0, 0, 0), "line_horizontal", 1, .2);
    self.ametrine = self createText("Objective", 0, "BOTTOM_LEFT", "BOTTOM_LEFT", -61, -430, 1, 0.75, (0.514, 0.784, 0.698), details);
}

trapper()
{
    self endon ("disconnect");
	level endon("game_ended");
    self iprintln("Damage Trap - Hurt the enemies that walk your path");
    self iprintln("^7Aim ^3+^7 [{+melee}]^7 to spawn trap");
    self iprintln("^7Aim ^3+^7 [{+stance}]^7 to delete");

	zone = self get_current_zone();
	zone_name = get_zone_display_name(zone);
	self.mama = 10;
	for(;;)
	{

			
			if(self adsButtonPressed() && self meleeButtonPressed())
			{

				self notify("trapgone");
				self.temptrap delete();
				self thread tspawntrap();
				if(!isDefined(self.imtrapped)) wait self.mama;
			}

			if(self adsButtonPressed() && self stancebuttonpressed())
			{
				if(isDefined(self.imtrapped))
				{

				self.temptrap delete();
				self.imtrapped = undefined;
				self notify("stopthefx");
				self notify("trapgone");
				self iprintln("Your trap was ^3broken^7!");
    			self iprintln("^7Respawn using Aim ^3+^7 [{+melee}]");
				self.mama = 0;
				} else if(!isDefined(self.imtrapped))
				{
					self iprintln("^7You have no ^3active traps");
				}
				wait 1;
			
			
			}

			wait 0.05;
		} 
}
            
tspawntrap()
{

    cross = bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
	self.temptrap = spawnSM(cross, "test_sphere_lambert");
    trap = self.temptrap;
    nigga = self.name;
	testfx = randomize("zombie_guts_explosion;powerup_grabbed_caution");
	self.trapfx = testfx;
    playfx( level._effect[ "rise_billow_foliage" ], cross);
	self.imtrapped = true;

	self thread tmonitortrap(trap);
	self thread realmonitor();
	}
    

realmonitor()
{
		self endon("trapgone");
		x = randomintrange(5,10);
		self.trapmonitor = x;
		for( i = x; i >= 1; i-- )
		{
			self.trapmonitor--;
			wait 1;
        	if(i == 1)
       	 	{
			self iprintln("Looks like your trap broke.");
    		self iprintln("^3Respawn^7 using Aim ^3+^7 [{+melee}]");
			self.temptrap delete();
			self.imtrapped = undefined;
			self.deathcause = undefined;
			self notify("trapgone");
			}
		}

       	 
}

tmonitortrap(model)
{
	self endon("disconnect");
	self endon("trapgone");

	
	foreach(player in level.players)
		player thread temptrapglow(model);
	
	for(;;)
	{
		if(distance(self.origin, model.origin) < 60)
		{
		// 	radiusdamage( origin, ra=dius, max_damage, min_damage, attacker, "MOD_GRENADE_SPLASH" );
		self doDamage(8000, self.origin, level.firsthide);
		playfx( level._effect[ "rise_billow_foliage" ], self.origin);
		playfx( level._effect[ "poltergeist" ], self.origin);
		self.deathcause = "trap";
		print("cause of death: " + self.deathcause);
		print("shouldve killed: " + self.name);
		self.mama = 0;
		
		}
		wait 0.25;
	}
}


temptrapglow(bounce)
{

	level endon("trapgone");
	level endon("stopthefx");
	
	for(;;)
	{
		
		playfx( level._effect[ "zombie_guts_explosion" ], bounce.origin);
		playfx( level._effect[ "powerup_grabbed_caution" ], bounce.origin);
		wait 0.5;
	}
}


tBouncer()
{
    self endon ("disconnect");
	level endon ("game_ended");
   // self iprintln("Temp Bouncer - Deletes after used");
    //self iprintln("^3[{+actionslot 4}] ^7to spawn bounce");

	for(;;)
	{
			if(self actionslotfourbuttonpressed() )
			{
                if(!isDefined(self.awaiting))
                {
				self thread tspawnBounce();
				//self cooldown();
                } else if(isDefined(self.awaiting))
                {
                    self iprintln("Wait^3 " + self.cooldown + "s^7 to use again!");
                }
                
			}
			wait .001; 
		} 
}

tspawnBounce()
{
    cross = bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
	self.tempbounce = spawnSM(cross, "test_sphere_lambert");
    bounce = self.tempbounce;
    nigga = self.name;
    //print("temp bounce by: ^3" + nigga + " ^7created");
    //print("origin: ^3" + bounce.origin);

	print("^5"+nigga+"  ^7  Bounce ^3#" +  self.actualbouncing);
	testfx = randomize("powerup_grabbed_wave_solo;powerup_grabbed_solo;powerup_grabbed_wave_caution;powerup_grabbed;powerup_grabbed_caution;powerup_off");
	self.testfx = testfx;
    playfx( level._effect[ testfx ], cross);

	self thread tmonitorBounce(bounce);
    
}

tspawnBounce()
{
    cross = bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
	self.tempbounce = spawnSM(cross, "test_sphere_lambert");
    bounce = self.tempbounce;
    nigga = self.name;
    //print("temp bounce by: ^3" + nigga + " ^7created");
    //print("origin: ^3" + bounce.origin);

	print("^5"+nigga+"  ^7  Bounce ^3#" +  self.actualbouncing);
	testfx = randomize("powerup_grabbed_wave_solo;powerup_grabbed_solo;powerup_grabbed_wave_caution;powerup_grabbed;powerup_grabbed_caution;powerup_off");
	self.testfx = testfx;
    playfx( level._effect[ testfx ], cross);

	self thread tmonitorBounce(bounce);
    
}


// allow double bouncing then go cooldown

reallymonitor()
{
	// bruh
	if(!isDefined(self.actualbouncing))
		self.actualbouncing = 0;


	self waittill("bouncecompleted");
	self.actualbouncing++;

	if(self.actualbouncing == 2)
	{
		self notify("startcooldown");
		self cooldown();
	} else {
		//self iprintln("first bounce");
		
	}
}



tmonitorBounce(model)
{
	self endon("disconnect");
	self endon("tempgone");


	level thread tempbounceglow(model);
	self.startidle = true;
	
	for(;;)
	{
		if(distance(self.origin, model.origin) < 40 && !isDefined(self.isBouncing))
		{
			self.isBouncing = true;
			self thread reallymonitor();
			self notify("bouncecompleted");

			if(self isOnGround())
				self setOrigin(self.origin);
			for(i = 0; i < 10; i++)
            {
                self setVelocity(self getVelocity()+(0, 0, 999));
                wait 0.05;	
            }
			//self.actualbouncing++;
            fx = randomize("poltergeist;powerup_grabbed;powerup_grabbed_wave;rise_billow_foliage;divetonuke_groundhit");
            playfx( level._effect[ fx ], self.tempbounce.origin);
            self.tempbounce delete();
            print("temp bounce by: ^3" + self.name + " ^7deleted");
            self.isBouncing = undefined;
			print("bounce #" + self.actualbouncing);
			self notify("tempgone");
			self notify("expired");

		}
		wait .05;
	}
}

bouncer()
{
    self endon ("disconnect");
	self endon ("game_ended");
    self iprintln("bounce creator enabled");
    self iprintln("[{+actionslot 2}] to spawn bounce");
	for(;;)
	{
			if(self actionslottwobuttonpressed() )
			{
				self thread spawnBounce();
			}
			wait .001; 
		} 
}

spawnBounce()
{
    cross = bullettrace(self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
	bounce = spawnSM(cross, "test_sphere_lambert");

    nigga = " ^7[^3" + self.name + "^7]";
	iPrintln("Bounce ^2Spawned" + nigga);
	iPrintln("Check console to see coordinates");
    print("origin: ^3" + bounce.origin);
    print("angles: ^3" + bounce.angles);
	foreach(player in level.players)
		player thread monitorBounce(bounce);
}


createMapEdits() {

    current_map = level.script;
    // Spawn bouncers 

	level waittill("game_started");
    if (isDefined(level.bounceLocs[current_map])) {
        for (bouncer_index = 0; bouncer_index < getBouncerCount(current_map); bouncer_index++) {
	        bounce = spawnSM(level.bounceLocs[current_map][bouncer_index], "test_sphere_lambert");
	        foreach(player in level.players)
        {
            player.bounce = bounce;
		    player thread monitorBounce(bounce);
        }

        }
    }
    }

bounceglow(bounce)
{

	seconds = randomfloatrange(0.5,1);
	for(;;)
	{

		testfx = randomize("butterflies;powerup_grabbed_wave_solo;powerup_grabbed_solo;powerup_grabbed_wave_caution;powerup_grabbed;powerup_grabbed_caution");
		playfx( level._effect[ testfx ], bounce.origin);
		wait seconds;
	}
}

tempbounceglow(bounce)
{

	self endon("tempgone");
	for(;;)
	{
		testfx = randomize("butterflies;powerup_grabbed_wave_solo;powerup_grabbed_solo;powerup_grabbed_wave_caution;powerup_grabbed;powerup_grabbed_caution");
		playfx( level._effect[ testfx ], bounce.origin);
		wait 0.5;
	}
}

getBouncerCount(map) {
    return level.bounceLocs[map].size;
}

randomize(a)
{

	r = strTok(a, ";"); // Rewrite later 
	random = RandomInt(r.size);
	final = r[random];
	return final;
}

monitorBounce(model)
{
	self endon("disconnect");
	
	self thread bounceglow(model);
	for(;;)
	{
		if(distance(self.origin, model.origin) < 40 && !isDefined(self.isBouncing))
		{
			self.isBouncing = true;
			if(self isOnGround())
				self setOrigin(self.origin);
			for(i = 0; i < 10; i++)
            {
                self setVelocity(self getVelocity()+(0, 0, 999));
                wait 0.05;
            }
            //playfx( level._effect[ "poltergeist" ], model.origin);

			x = randomize("poltergeist;rise_billow_foliage");
            playfx( level._effect[ x ], model.origin);
            self.isBouncing = undefined;
		}
		wait .05;
	}
}

configureBouncers() {

	level mapbounce("zm_buried", (-238.506, 439.612, 30.7648));
	level mapbounce("zm_buried", (584.125, 250.441, 46.2569));
	level mapbounce("zm_buried", (918.569, 158.503, 48.7354));
	level mapbounce("zm_buried", (707.501, 605.388, -16.5269));
	level mapbounce("zm_buried", (132.396, 1007.18, 44.125));
	level mapbounce("zm_buried", (-12.0126, -1000.61, 122.831));
	level mapbounce("zm_buried", (-487.17, 219.515, 19.2325));
	level mapbounce("zm_buried", (-513.153, 209.694, 36.4522));
	level mapbounce("zm_buried", (703.462, -990.875, 43.6281));
	level mapbounce("zm_buried", (701.875, -991.091, 25.5918));
	level mapbounce("zm_buried", (1658.78, 166.627, 32.3986));
	level mapbounce("zm_buried", (-1027.11, -329.64, 28.6597));
	level mapbounce("zm_buried", (119.84, -1988.07, 229.232));
	level mapbounce("zm_buried", (942.027, -1367.5, 96.0008));
	level mapbounce("zm_buried", (-650.747, 848.904, 8.125));
	level mapbounce("zm_buried", (-141.184, -877.68, 39.6849));
	level mapbounce("zm_buried", (-816.905, 927.6, 8.92021));
	level mapbounce("zm_buried", (1915.42, 545.206, 71.935));
	level mapbounce("zm_buried", (906.404, 1223.97, 39.328));
	level mapbounce("zm_buried", (249.207, 288.463, 14.0795));
	level mapbounce("zm_buried", (111.875, 489.43, 172.938));
	level mapbounce("zm_buried", (819.28, 250.125, 44.5919));
	level mapbounce("zm_buried", (1058.07, 346.565, -3.03908));
	level mapbounce("zm_buried", (409.497, -1017.91, 72.7814));
	level mapbounce("zm_buried", (349.239, -250.703, -7.875));
}


mapbounce(map, location) {

    if (!isDefined(level.bounceLocs)) {
        level.bounceLocs = [];
    }

    if (!isDefined(level.bounceLocs[map])) {
        level.bounceLocs[map] = [];
    }

    arr_size = level.bounceLocs[map].size;
    level.bounceLocs[map][arr_size] = location;
}

spawnSM(origin, model, angles)
{
    ent = spawn("script_model", origin);
    ent setModel(model);
    if(isDefined(angles))
        ent.angles = angles;
    return ent;
}


getMapName() // Map Name
{
	return level.script;
}

