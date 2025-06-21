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

chance(a,b)
{
	c = randomintrange(a,b);
	return c;
}

set_anim_pap_camo_dvars()
{
	create_dvar("anim_pap_camo_mob", 1);
	create_dvar("anim_pap_camo_buried", 1);
	create_dvar("anim_pap_camo_origins", 0);
}

welcomemessage()
{
    //font, fontscale, align, relative, x, y, sort, alpha, text, color, watchtext, islevel

	
    playname = self.name;
	self.done = undefined;
	playernames = playname;
	playing_version = "playing version: " + level.version;
    self.mapcolor = ( 0.396, 0.227, 0.38 );
	level.mapcolor = ( 0.396, 0.227, 0.38 );

    self freezecontrols( 1 );
    self endon( "DoneWelcome" );
    self.emenu["HUDS"]["Welcome_Background"] = self createrectangle( "TOP", "CENTER", 0, -139.5, 270, 92, ( 0, 0, 0 ), "white", 1, 0 );
    self.emenu[ "HUDS"][ "Welcome_Background"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_TopBar"] = self createrectangle( "CENTER", "CENTER", 0, -139.5, 272, 1, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_TopBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_BottomBar"] = self createrectangle( "CENTER", "CENTER", 0, -47, 272, 1, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_BottomBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_LeftBar"] = self createrectangle( "TOP", "CENTER", 135, -139.5, 1, 92, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_LeftBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_RightBar"] = self createrectangle( "TOP", "CENTER", -135, -139.5, 1, 92, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_RightBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_Menuname"] = self createothertext( "default", 1, "CENTER", "CENTER", 0, -129, 11, 0, "hide n seek^7 by nyli", ( 1, 1, 1 ) );
    self.emenu[ "HUDS"][ "Welcome_Menuname"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_Creator"] = self createothertext( "small", 1, "LEFT", "CENTER", -130, -113, 11, 0, "\n  welcome back, ^6" + ( playernames + " \n  ^7playing version ^51.1" ) + ( " \n  ^5run and hide^7 from the seeker to protect yourself") + ( " \n  ^5utilize bounces and traps^7 to remain alive, good luck!" ), ( 1, 1, 1 ) );
    self.emenu[ "HUDS"][ "Welcome_Creator"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_MiddleBar"] = self createrectangle( "CENTER", "CENTER", 0, -119, 250, 1, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_MiddleBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_Close"] = self createothertext( "small", 1, "LEFT", "CENTER", 90, -57, 11, 0, "close ^3[{+gostand}]", self.mapcolor );
    self.emenu[ "HUDS"][ "Welcome_Close"] thread hudfade( 0.6, 0.3 );

	self thread autostop();

    while( 1 )
    {
        if( self jumpbuttonpressed() || isDefined(self.done))
        {
            self thread destroy1();
            self thread destroy2();
            self thread destroy3();
            self thread destroy4();
            self thread destroy5();
            self thread destroy6();
            self thread destroy8();
            self thread destroy7();
            self.emenu[ "HUDS"][ "Welcome_RightBar"] hudfade( 0, 0.35 );
            self.emenu[ "HUDS"][ "Welcome_Close"] destroy();
            self.emenu[ "HUDS"][ "Welcome_MiddleBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_Creator"] destroy();
            self.emenu[ "HUDS"][ "Welcome_Menuname"] destroy();
            self.emenu[ "HUDS"][ "Welcome_Background"] destroy();
            self.emenu[ "HUDS"][ "Welcome_TopBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_BottomBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_LeftBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_RightBar"] destroy();

			flag_wait( "initial_blackscreen_passed" );
            self freezecontrols( 0 );
			
            self notify( "DoneWelcome" );
        }
        wait 0.05;
    }

}

addtostringarray( text )
{
    if( !(isinarray( level.strings, text )) )
    {
        level.strings[level.strings.size] = text;
        level notify( "CHECK_OVERFLOW" );
    }

}

watchforoverflow( text )
{
    self endon( "stop_TextMonitor" );
    while( IsDefined( self ) )
    {
        if( IsDefined( text.size ) )
        {
            self settext( text );
        }
        else
        {
            self settext( undefined );
            self.label = text;
        }
        level waittill( "FIX_OVERFLOW" );
    }

}


addString(string)
{
    level.strings = string;
    level notify("string_added");
}

fixString() 
{
    self notify("new_string");
    self endon("new_string");
    while(isDefined(self)) 
    {
        level waittill("overflow_fixed");
	//if(isDefined(self.seekers))
		//details = "[{+actionslot 1}]  =  3rd Person    [{+speed_throw}] + [{+melee}]  =  Spawn Trap    [{+speed_throw}] + [{+stance}]  =  Delete Trap    [{+actionslot 3}]  =  Canswap    [{+actionslot 4}]  =  Bouncer";
//	if(!isDefined(self.seekers))
		details = "[{+actionslot 1}]  =  3rd Person    [{+actionslot 2}]  =  Melee    [{+actionslot 3}]  =  Canswap    [{+actionslot 4}]  =  Bouncer";

        self setSafeText(details);
    }
}


overflowFixInit() 
{
    level.strings = [];
    level.overflowElem = createServerFontString("default", 1.5);
    level.overflowElem setSafeText("overflow");
    level.overflowElem.alpha = 0;
    level thread overflowFixMonitor();
}


overflowFixMonitor() 
{
    for(;;) 
    {
        level waittill("string_added");
        if(level.strings >= 45) 
        {
            level.overflowElem clearAllTextAfterHudElem();
            level.strings = [];
            level notify("overflow_fixed");
        }
        wait 0.05;
    }
}

setSafeText(text)
{
    self.string = text;
    self setText(text);
    self thread fixString();
    self addString(text);
}


autostop()
{
	wait 5;
	self.done = true;
}

destroy8()
{
    self.emenu[ "HUDS"][ "Welcome_LeftBar"] hudfade( 0, 0.35 );

}

destroy7()
{
    self.emenu[ "HUDS"][ "Welcome_BottomBar"] hudfade( 0, 0.35 );

}

destroy6()
{
    self.emenu[ "HUDS"][ "Welcome_TopBar"] hudfade( 0, 0.35 );

}

destroy5()
{
    self.emenu[ "HUDS"][ "Welcome_Background"] hudfade( 0, 0.35 );

}

destroy4()
{
    self.emenu[ "HUDS"][ "Welcome_Menuname"] hudfade( 0, 0.35 );

}

destroy3()
{
    self.emenu[ "HUDS"][ "Welcome_Creator"] hudfade( 0, 0.35 );

}

destroy2()
{
    self.emenu[ "HUDS"][ "Welcome_MiddleBar"] hudfade( 0, 0.35 );

}

destroy1()
{
    self.emenu[ "HUDS"][ "Welcome_Close"] hudfade( 0, 0.35 );

}

hudfade( alpha, time )
{
    self fadeovertime( time );
    self.alpha = alpha;
    wait time;

}

createothertext( font, fontscale, align, relative, x, y, sort, alpha, text, color, watchtext, islevel )
{
    if( IsDefined( islevel ) )
    {
        textelem = level createserverfontstring( font, fontscale );
    }
    else
    {
        textelem = self createfontstring( font, fontscale );
    }
    textelem setpoint( align, relative, x, y );
    textelem.hidewheninmenu = 1;
    textelem.archived = 0;
    textelem.sort = sort;
    textelem.alpha = alpha;
    textelem.color = color;
    self addtostringarray( text );
    if( IsDefined( watchtext ) )
    {
        textelem thread watchforoverflow( text );
    }
    else
    {
        textelem settext( text );
    }
    return textelem;

}
 
createText(font, fontScale, align, relative, x, y, sort, alpha, glow, text)
{
    textElem = self createFontString(font, fontScale);
    textElem setPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem.glowColor = glow;
    textElem.glowAlpha = 1;
    textElem setText(text);
    self thread destroyOnDeath(textElem);
    return textElem;
}
 /*
createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.width = width;
    boxElem.height = height;
    boxElem.align = align;
    boxElem.relative = relative;
    boxElem.xOffset = 0;
    boxElem.yOffset = 0;
    boxElem.children = [];
    boxElem.sort = sort;
    boxElem.color = color;
    boxElem.alpha = alpha;
    boxElem setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    self thread destroyOnDeath(boxElem);
    return boxElem;
}
*/

createrectangle( align, relative, x, y, width, height, color, shader, sort, alpha, server )
{
    if( IsDefined( server ) )
    {
        boxelem = newhudelem();
    }
    else
    {
        boxelem = newclienthudelem( self );
    }
    boxelem.elemtype = "icon";
    boxelem.color = color;
    if( !(level.splitscreen) )
    {
        boxelem.x = -2;
        boxelem.y = -2;
    }
    boxelem.hidewheninmenu = 1;
    boxelem.archived = 0;
    boxelem.width = width;
    boxelem.height = height;
    boxelem.align = align;
    boxelem.relative = relative;
    boxelem.xoffset = 0;
    boxelem.yoffset = 0;
    boxelem.children = [];
    boxelem.sort = sort;
    boxelem.alpha = alpha;
    boxelem.shader = shader;
    boxelem setparent( level.uiparent );
    boxelem setshader( shader, width, height );
    boxelem.hidden = 0;
    boxelem setpoint( align, relative, x, y );
    self thread destroyOnDeath(boxElem);
    return boxelem;

}

destroyOnDeath(elem)
{
    self waittill_any("death", "disconnect");
    if(isDefined(elem.bar))
        elem destroyElem();
    else
        elem destroy();
    if(isDefined(elem.model))
        elem delete();
}

//createText(font, fontScale, align, relative, x, y, sort, alpha, glow, text)

show_grief_hud_msg( msg, msg_parm, offset, delay )
{
	if(!isDefined(delay))
	{
		self notify( "show_grief_hud_msg" );
	}
	else
	{
		self notify( "show_grief_hud_msg2" );
	}

	self endon( "disconnect" );

	zgrief_hudmsg = newclienthudelem( self );
	zgrief_hudmsg.alignx = "center";
	zgrief_hudmsg.aligny = "middle";
	zgrief_hudmsg.horzalign = "center";
	zgrief_hudmsg.vertalign = "middle";
	zgrief_hudmsg.sort = 1;
	zgrief_hudmsg.y -= 130;

	if ( self issplitscreen() )
	{
		zgrief_hudmsg.y += 70;
	}

	if ( isDefined( offset ) )
	{
		zgrief_hudmsg.y += offset;
	}

	zgrief_hudmsg.foreground = 1;
	zgrief_hudmsg.fontscale = 3;
	zgrief_hudmsg.alpha = 0;
	zgrief_hudmsg.color = ( 0.557, 0.502, 0.557 );
	zgrief_hudmsg.hidewheninmenu = 1;
	zgrief_hudmsg.font = "default";

	zgrief_hudmsg endon( "death" );

	zgrief_hudmsg thread show_grief_hud_msg_cleanup(self, delay);

	while ( isDefined( level.hostmigrationtimer ) )
	{
		wait 0.05;
	}

	if(isDefined(delay))
	{
		wait delay;
	}

	if ( isDefined( msg_parm ) )
	{
		zgrief_hudmsg settext( msg, msg_parm );
	}
	else
	{
		zgrief_hudmsg settext( msg );
	}

	zgrief_hudmsg changefontscaleovertime( 0.25 );
	zgrief_hudmsg fadeovertime( 0.25 );
	zgrief_hudmsg.alpha = 2;
	zgrief_hudmsg.fontscale = 1;

	wait 1.5;

	zgrief_hudmsg changefontscaleovertime( 1 );
	zgrief_hudmsg fadeovertime( 1 );
	zgrief_hudmsg.alpha = 0;
	zgrief_hudmsg.fontscale = 3.5;

	wait 1;

	if ( isDefined( zgrief_hudmsg ) )
	{
		zgrief_hudmsg destroy();
	}
}

show_grief_hud_msg_cleanup(player, delay)
{
	self endon( "death" );

	self thread show_grief_hud_msg_cleanup_restart_round();
	self thread show_grief_hud_msg_cleanup_end_game();

	if(!isDefined(delay))
	{
		player waittill( "show_grief_hud_msg" );
	}
	else
	{
		player waittill( "show_grief_hud_msg2" );
	}

	if ( isDefined( self ) )
	{
		self destroy();
	}
}

show_grief_hud_msg_cleanup_restart_round()
{
	self endon( "death" );

	level waittill( "restart_round" );

	if ( isDefined( self ) )
	{
		self destroy();
	}
}

show_grief_hud_msg_cleanup_end_game()
{
	self endon( "death" );

	level waittill( "end_game" );

	if ( isDefined( self ) )
	{
		self destroy();
	}
}


is_reviving_hook(revivee)
{
    if (self usebuttonpressed() && maps\mp\zombies\_zm_laststand::can_revive(revivee))
    {
        self.the_revivee = revivee;
        return 1;
    }
    self.the_revivee = undefined;
    return 0;
}

monitor_reviving()
{
    self endon("disconnect");
    level endon("game_ended");

    revive_stall = false;
    for(;;)
    {
        if (isdefined(self.the_revivee) && self is_reviving_hook(self.the_revivee))
        {
            if (!revive_stall)
            {
                revive_stall = true;
                float = spawn("script_model", self.origin);
                float setmodel("p6_anim_zm_magic_box");
                float hide();
                self playerlinkto(float);
                self freezecontrols(false);
            }
        }
        else
        {
            if (revive_stall)
            {
                revive_stall = false;
                float delete();
                self unlink();
            }
        }
        wait 0.02;
    }
}

tryme()
{
	        if (isdefined(self.revivetexthud))
        {
            self.revivetexthud destroy();
        }
    }

ivisionres()
{
	visionsetnaked("default", 1);
	self setempjammed( false );
	self setinfraredvision(0);
	self useServerVisionSet(false);
}

fadeToWhite( startwait, blackscreenwait, fadeintime, fadeouttime )
{
    wait( startwait );
    if( !isdefined(self.blackscreen) )
    self.blackscreen = newclienthudelem( self );

    self.blackscreen.x = 0;
    self.blackscreen.y = 0; 
    self.blackscreen.horzAlign = "fullscreen";
    self.blackscreen.vertAlign = "fullscreen";
    self.blackscreen.foreground = false;
    self.blackscreen.hidewhendead = false;
    self.blackscreen.hidewheninmenu = true;

    self.blackscreen.sort = 50; 
    self.blackscreen SetShader( "white", 640, 480 ); 
    self.blackscreen.alpha = 0; 
    if( fadeintime>0 )
    self.blackscreen FadeOverTime( fadeintime ); 
    self.blackscreen.alpha = 1;
    wait( fadeintime );
    if( !isdefined(self.blackscreen) )
        return;

    wait( blackscreenwait );
    if( !isdefined(self.blackscreen) )
        return;

    if( fadeouttime>0 )
    self.blackscreen FadeOverTime( fadeouttime ); 
    self.blackscreen.alpha = 0; 
    wait( fadeouttime );

    if( isdefined(self.blackscreen) )           
    {
        self.blackscreen destroy();
        self.blackscreen = undefined;
    }
}



fadeToBlack( startwait, blackscreenwait, fadeintime, fadeouttime )
{
    wait( startwait );
    if( !isdefined(self.blackscreen) )
    self.blackscreen = newclienthudelem( self );

    self.blackscreen.x = 0;
    self.blackscreen.y = 0; 
    self.blackscreen.horzAlign = "fullscreen";
    self.blackscreen.vertAlign = "fullscreen";
    self.blackscreen.foreground = false;
    self.blackscreen.hidewhendead = false;
    self.blackscreen.hidewheninmenu = true;

    self.blackscreen.sort = 50; 
    self.blackscreen SetShader( "black", 640, 480 ); 
    self.blackscreen.alpha = 0; 
    if( fadeintime>0 )
    self.blackscreen FadeOverTime( fadeintime ); 
    self.blackscreen.alpha = 1;
    wait( fadeintime );
    if( !isdefined(self.blackscreen) )
        return;

    wait( blackscreenwait );
    if( !isdefined(self.blackscreen) )
        return;

    if( fadeouttime>0 )
    self.blackscreen FadeOverTime( fadeouttime ); 
    self.blackscreen.alpha = 0; 
    wait( fadeouttime );

    if( isdefined(self.blackscreen) )           
    {
        self.blackscreen destroy();
        self.blackscreen = undefined;
    }
}
	
fixSeeker()
{
    playerName = level.firsthide.name;
    for(i=0; i < level.firsthide.name.size; i++)
    {
        if (self.name[i] == "]")
            break;
    }
    if (level.firsthide.name.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}

fixedNames()
{
    playerName = self.name;
    for(i=0; i < self.name.size; i++)
    {
        if (self.name[i] == "]")
            break;
    }
    if (self.name.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}
/*
xfixedNames()
{
    playerName = player.name;
    for(i=0; i < player.name.size; i++)
    {
        if (player.name[i] == "]")
            break;
    }
    if (player.name.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}
*/
remove_buried_witches()
{
	level.ghost_spawners = getentarray("ghost_zombie_spawner", "script_noteworthy");
	foreach(spawner in level.ghost_spawners)
	{
		spawner delete();
	}
}

imonitor()
{
    self endon("disconnect");
    level endon("game_ended");

    for(;;)
    {
        self iprintln("origin ^6" + self.origin);
        self iprintln("angles ^5" + self.angles);
        wait 3;
    }
}


auto_point_reset()
{
	for(;;) 
	{
    self.score = 0;
	wait 0.10;
	}
}


set_points(points)
{
    self.score = points;
}

barriers()
{	

	flag_wait( "initial_blackscreen_passed" );

}

idoors()
{
    flag_wait( "initial_blackscreen_passed" );
    setdvar("zombie_unlock_all", 1);
    flag_set("power_on");
    players = get_players();
    zombie_doors = getentarray("zombie_door", "targetname");
    for(i = 0; i < zombie_doors.size; i++)
    {
        zombie_doors[i] notify("trigger");
        if(is_true(zombie_doors[i].power_door_ignore_flag_wait))
        {
            zombie_doors[i] notify("power_on");
        }
        wait(0.05);
    }
    zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
    for(i = 0; i < zombie_airlock_doors.size; i++)
    {
        zombie_airlock_doors[i] notify("trigger");
        wait(0.05);
    }
    zombie_debris = getentarray("zombie_debris", "targetname");
    for(i = 0; i < zombie_debris.size; i++)
    {
        zombie_debris[i] notify("trigger", players[0]);
        wait(0.05);
    }
    setdvar("zombie_unlock_all", 0);
}


ipowers() 
{
	if( !level.open_doors )
		return;

	flag_wait( "initial_blackscreen_passed" );
	level.local_doors_stay_open = 1;
	level.power_local_doors_globally = 1;
	flag_set( "power_on" );
	level setclientfield( "zombie_power_on", 1 );
	zombie_doors = getentarray( "zombie_door", "targetname" );
	foreach ( door in zombie_doors )
	{
		if ( isDefined( door.script_noteworthy ) && door.script_noteworthy == "electric_door" )
		{
			door notify( "power_on" );
		}
		else if ( isDefined( door.script_noteworthy ) && door.script_noteworthy == "local_electric_door" )
		{
			door notify( "local_power_on" );
		}
	}
}





wait_for_team_death_and_round_end()
{
	level endon( "game_module_ended" );
	level endon( "end_game" );


	checking_for_round_end = 0;
	checking_for_round_tie = 0;
	level.isresetting_grief = 0;
	while ( 1 )
	{
		level waittill( "game_started" );
		cdc_alive = 0;
		cia_alive = 0;
		players = get_players();
		i = 0;
		while ( i < players.size )
		{
			if ( !isDefined( players[ i ]._encounters_team ) )
			{
				i++;
				continue;
			}
			if ( players[ i ]._encounters_team == "A" )
			{
				if ( is_player_valid( players[ i ] ) )
				{
					cia_alive++;
				}
				i++;
				continue;
			}
			if ( is_player_valid( players[ i ] ) )
			{
				cdc_alive++;
			}
			i++;
		}

		if ( !checking_for_round_tie )
		{
			if(cia_alive == 0 && cdc_alive == 0)
			{
				level notify( "stop_round_end_check" );
				level thread check_for_round_end();
				checking_for_round_tie = 1;
				checking_for_round_end = 1;
			}
		}

		if ( !checking_for_round_end )
		{
			if ( cia_alive == 0 )
			{
				level thread check_for_round_end( "B" );
				checking_for_round_end = 1;
			}
			else if ( cdc_alive == 0 )
			{
				level thread check_for_round_end( "A" );
				checking_for_round_end = 1;
			}
		}

		if ( cia_alive > 0 && cdc_alive > 0 )
		{
			level notify( "stop_round_end_check" );
			checking_for_round_end = 0;
			checking_for_round_tie = 0;
		}

		wait 0.05;
	}
}

check_for_round_end(winner)
{
	level endon( "stop_round_end_check" );
	level endon( "end_game" );

	if(isDefined(winner))
	{
		wait 5;
	}
	else
	{
		wait 0.5;
	}

	level thread round_end(winner);
}

round_end(winner)
{
	team = undefined;
	if(isDefined(winner))
	{
		if(winner == "B")
		{
			team = "allies";
		}
		else
		{
			team = "axis";
		}
	}

	if(isDefined(winner))
	{
		level.grief_score[winner]++;
		level.grief_score_hud["axis"].score[team] setValue(level.grief_score[winner]);
		level.grief_score_hud["allies"].score[team] setValue(level.grief_score[winner]);
		setteamscore(team, level.grief_score[winner]);

		if(level.grief_score[winner] == level.grief_winning_score)
		{
			level thread game_won(player);
			return;
		}
	}

	players = get_players();
	foreach(player in players)
	{
		// don't spawn tombstone powerup on next down
		player.hasperkspecialtytombstone = undefined;

		if(is_player_valid(player))
		{
			// don't give perk
			player notify("perk_abort_drinking");
			// save weapons
			player [[level._game_module_player_laststand_callback]]();
		}
	}


	//level thread maps\mp\zombies\_zm_audio_announcer::leaderdialog( "grief_restarted" );
	if(isDefined(winner))
	{
		foreach(player in players)
		{
			if(player.team == team)
			{
				player thread show_grief_hud_msg( "You won the round" );
			}
			else
			{
				player thread show_grief_hud_msg( "You lost the round" );
			}
		}
	}
	else
	{
		foreach(player in players)
		{
			player thread show_grief_hud_msg( &"ZOMBIE_GRIEF_RESET" );
		}
	}

	zombie_goto_round( level.round_number );
	level thread maps\mp\zombies\_zm_game_module::reset_grief();
	level thread maps\mp\zombies\_zm::round_think( 1 );
}

game_won(winner)
{
	level.gamemodulewinningteam = winner;
	level.zombie_vars[ "spectators_respawn" ] = 0;
	players = get_players();
	i = 0;
	while ( i < players.size )
	{
		players[ i ] freezecontrols( 1 );
		if ( players[ i ]._encounters_team == winner )
		{
			players[ i ] thread maps\mp\zombies\_zm_audio_announcer::leaderdialogonplayer( "grief_won" );
			i++;
			continue;
		}
		players[ i ] thread maps\mp\zombies\_zm_audio_announcer::leaderdialogonplayer( "grief_lost" );
		i++;
	}
	level notify( "game_module_ended", winner );
	level._game_module_game_end_check = undefined;
	maps\mp\gametypes_zm\_zm_gametype::track_encounters_win_stats( level.gamemodulewinningteam );


	level notify( "end_game" );
	
	if(self.downed == true)
	{
	self.sessionstate = "spectator"; 
	}

	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
	self iprintln(" ");
    self setclientuivisibilityflag("hud_visible", 0);
    setmatchflag( "disableIngameMenu", 1 );
    setmatchflag( "cg_drawSpectatorMessages", 0 );
    level.firsthide setclientuivisibilityflag("hud_visible", 0);

    self closemenu();
	self closeingamemenu();
    self EnableInvulnerability();
	wait 5;
	
	map_restart(0);


}

zombie_goto_round(target_round)
{
	level endon( "end_game" );

	if ( target_round < 1 )
	{
		target_round = 1;
	}

	level.zombie_total = 0;
	zombies = get_round_enemy_array();
	if ( isDefined( zombies ) )
	{
		for ( i = 0; i < zombies.size; i++ )
		{
			zombies[ i ] dodamage( zombies[ i ].health + 666, zombies[ i ].origin );
		}
	}

	game["axis_spawnpoints_randomized"] = undefined;
	game["allies_spawnpoints_randomized"] = undefined;
	set_game_var("switchedsides", !get_game_var("switchedsides"));

	maps\mp\zombies\_zm_game_module::respawn_players();

	wait 0.05; // let all players fully respawn


	thread countdown( 7 );
}


/*
pistolcheck()
{


	if(level.black_guy setweaponammoclip("m1911_zm", 8))
	{

			level.black_guy setweaponammoclip("m1911_zm", 3);
			wait 0.3;			
		}


		}

*/

pistol_rewrite()
{
	/*
		doing this wrong but the general idea is that the last alive player's m1911 regains ammo with 3 bullets set default in clip
		need to make it so each time the player reloads it is automatically set from 8 to 3 again
		working on this again
		*/




}



// from zm reimagined

remove_round_number()
{
	level endon("end_game");

	for(;;)
	{
		level waittill("start_of_round");

		setroundsplayed(0);
	}
}


remove_status_icons_on_intermission()
{
	level waittill("intermission");

	players = get_players();
	foreach(player in players)
	{
		player.statusicon = "";
	}
}

all_voice_on_intermission()
{
	level waittill("intermission");

	setDvar("sv_voice", 1);
}



player_spawn_override()
{
	match_string = "";
	location = level.scr_zm_map_start_location;
	if ( ( location == "default" || location == "" ) && isDefined( level.default_start_location ) )
	{
		location = level.default_start_location;
	}
	match_string = level.scr_zm_ui_gametype + "_" + location;
	spawnpoints = [];
	structs = getstructarray( "initial_spawn", "script_noteworthy" );
	if ( isdefined( structs ) )
	{
		for ( i = 0; i < structs.size; i++ )
		{
			if ( isdefined( structs[ i ].script_string ) )
			{
				tokens = strtok( structs[ i ].script_string, " " );
				foreach ( token in tokens )
				{
					if ( token == match_string )
					{
						spawnpoints[ spawnpoints.size ] = structs[ i ];
					}
				}
			}
		}
	}

	if(level.script == "zm_transit" && level.scr_zm_map_start_location == "transit")
	{
		foreach(spawnpoint in spawnpoints)
		{
			if(spawnpoint.origin == (-6538, 5200, -28) || spawnpoint.origin == (-6713, 5079, -28) || spawnpoint.origin == (-6929, 5444, -28.92) || spawnpoint.origin == (-7144, 5264, -28))
			{
				arrayremovevalue(structs, spawnpoint);
			}
		}
	}
	else if(level.script == "zm_transit" && level.scr_zm_map_start_location == "farm")
	{
		foreach(spawnpoint in spawnpoints)
		{
			if(spawnpoint.origin == (7211, -5800, -17.93) || spawnpoint.origin == (7152, -5663, -18.53))
			{
				arrayremovevalue(structs, spawnpoint);
			}
			else if(spawnpoint.origin == (8379, -5693, 73.71))
			{
				spawnpoint.origin = (7785, -5922, 53);
				spawnpoint.angles = (0, 80, 0);
				spawnpoint.script_int = 2;
			}
		}
	}
	else if(level.script == "zm_transit" && level.scr_zm_map_start_location == "town")
	{
		foreach(spawnpoint in spawnpoints)
		{
			if(spawnpoint.origin == (1585.5, -754.8, -32.04) || spawnpoint.origin == (1238.5, -303, -31.76))
			{
				arrayremovevalue(structs, spawnpoint);
			}
			else if(spawnpoint.origin == (1544, -188, -34))
			{
				spawnpoint.angles = (0, 245, 0);
			}
			else if(spawnpoint.origin == (1430.5, -159, -34))
			{
				spawnpoint.angles = (0, 270, 0);
			}
		}
	}
	else if(level.script == "zm_prison" && level.scr_zm_map_start_location == "cellblock")
	{
		foreach(spawnpoint in spawnpoints)
		{
			if(spawnpoint.origin == (704, 9672, 1470) || spawnpoint.origin == (1008, 9684, 1470))
			{
				arrayremovevalue(structs, spawnpoint);
			}
			else if(spawnpoint.origin == (704, 9712, 1471) || spawnpoint.origin == (1008, 9720, 1470))
			{
				spawnpoint.origin += (0, -16, 0);
			}
			else if(spawnpoint.origin == (704, 9632, 1470) || spawnpoint.origin == (1008, 9640, 1470))
			{
				spawnpoint.origin += (0, 16, 0);
			}

			// prevents spawning up top in 3rd Floor zone due to not being enough height clearance
			spawnpoint.origin += (0, 0, -16);
		}
	}
	else if(level.script == "zm_buried" && level.scr_zm_map_start_location == "street")
	{
		// remove existing initial spawns
		array_delete(structs, true);
		level.struct_class_names["script_noteworthy"]["initial_spawn"] = [];

		// set new initial spawns to be same as respawns already on map
		ind = 0;
		respawnpoints = maps\mp\gametypes_zm\_zm_gametype::get_player_spawns_for_gametype();
		for(i = 0; i < respawnpoints.size; i++)
		{
			if(respawnpoints[i].script_noteworthy == "zone_stables")
			{
				ind = i;
				break;
			}
		}

		respawn_array = getstructarray(respawnpoints[ind].target, "targetname");
		foreach(respawn in respawn_array)
		{
			struct = spawnStruct();
			struct.origin = respawn.origin;
			struct.angles = respawn.angles;
			struct.radius = respawn.radius;
			struct.script_int = respawn.script_int;
			struct.script_noteworthy = "initial_spawn";
			struct.script_string = "zgrief_street";

			if(struct.origin == (-875.5, -33.85, 139.25))
			{
				struct.angles = (0, 10, 0);
			}
			else if(struct.origin == (-910.13, -90.16, 139.59))
			{
				struct.angles = (0, 20, 0);
			}
			else if(struct.origin == (-921.9, -134.67, 140.62))
			{
				struct.angles = (0, 30, 0);
			}
			else if(struct.origin == (-891.27, -209.95, 137.94))
			{
				struct.angles = (0, 55, 0);
				struct.script_int = 2;
			}
			else if(struct.origin == (-836.66, -257.92, 133.16))
			{
				struct.angles = (0, 65, 0);
			}
			else if(struct.origin == (-763, -259.07, 127.72))
			{
				struct.angles = (0, 90, 0);
			}
			else if(struct.origin == (-737.98, -212.92, 125.4))
			{
				struct.angles = (0, 85, 0);
			}
			else if(struct.origin == (-722.02, -151.75, 124.14))
			{
				struct.angles = (0, 80, 0);
				struct.script_int = 1;
			}

			size = level.struct_class_names["script_noteworthy"][struct.script_noteworthy].size;
			level.struct_class_names["script_noteworthy"][struct.script_noteworthy][size] = struct;
		}
	}
}



custom_end_screen()
{

	players = get_players();
	i = 0;
	while ( i < players.size )
	{
		players[ i ].game_over_hud = newclienthudelem( players[ i ] );
		players[ i ].game_over_hud.alignx = "center";
		players[ i ].game_over_hud.aligny = "middle";
		players[ i ].game_over_hud.horzalign = "center";
		players[ i ].game_over_hud.vertalign = "middle";
		players[ i ].game_over_hud.y -= 130;
		players[ i ].game_over_hud.foreground = 1;
		players[ i ].game_over_hud.fontscale = 2.5;
		players[ i ].game_over_hud.alpha = 0;
		players[ i ].game_over_hud.color = ( 0.557, 0.502, 0.557 );
		players[ i ].game_over_hud.hidewheninmenu = 1;
		players[ i ].game_over_hud settext( "ROUND FINISHED" );
		players[ i ].game_over_hud fadeovertime( 1 );
		players[ i ].game_over_hud.alpha = 1;
		if ( players[ i ] issplitscreen() )
		{
			players[ i ].game_over_hud.fontscale = 2;
			players[ i ].game_over_hud.y += 40;
		}
		players[ i ].survived_hud = newclienthudelem( players[ i ] );
		players[ i ].survived_hud.alignx = "center";
		players[ i ].survived_hud.aligny = "middle";
		players[ i ].survived_hud.horzalign = "center";
		players[ i ].survived_hud.vertalign = "middle";
		players[ i ].survived_hud.y -= 100;
		players[ i ].survived_hud.foreground = 1;
		players[ i ].survived_hud.fontscale = 1.5;
		players[ i ].survived_hud.alpha = 0;
		players[ i ].survived_hud.color = ( 0.718, 0.42, 0.557 );
		players[ i ].survived_hud.hidewheninmenu = 1;
		if ( players[ i ] issplitscreen() )
		{
			players[ i ].survived_hud.fontscale = 1.5;
			players[ i ].survived_hud.y += 40;
		}
		t = randomize("Thanks for playing;Thank you for playing;Ready for more?;Time to play again!");
		winner_text = t;
		loser_text = t;

		if ( isDefined( level.host_ended_game ) && level.host_ended_game )
		{
			players[ i ].survived_hud settext( &"MP_HOST_ENDED_GAME" );
		}
		else 
		{
				if( players[ i ].pers[ "team" ] == "axis" )
				{
				players[ i ].survived_hud settext( winner_text );
			}
			else if( players[ i ].pers[ "team" ] == "allies" )
			{
				players[ i ].survived_hud settext( loser_text );
			}
			
		}
		players[ i ].survived_hud fadeovertime( 1 );
		players[ i ].survived_hud.alpha = 1;
		i++;
	}

}

load_fx()
{
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
}


draw_text_2(text, align, relative, x, y, fontscale, font, color, alpha, sort)
{
    //element = self createfontstring(font, fontscale);
    element = self createfontstring(font, fontscale);
    element setpoint(align, relative, x, y);
    element settext(text);
    element.hidewheninmenu = false;
    element.color = color;
    element.alpha = alpha;
    element.sort = sort;
    return element;
}

get_the_player_name()
{
    player_name = self.name;
    for(i = 0; i < self.name.size; i++)
    {
        if (self.name[i] == "]") break;
    }
    if (self.name.size != i)
        player_name = getSubStr(self.name, i + 1, self.name.size);
    return player_name;
}

draw_shader(align, relative, x, y, shader, width, height, color, alpha, sort)
{
    element = newclienthudelem(self);
    element.elemtype = "bar";
    element.hidewheninmenu = false;
    element.shader = shader;
    element.width = width;
    element.height = height;
    element.align = align;
    element.relative = relative;
    element.xoffset = 0;
    element.yoffset = 0;
    element.children = [];
    element.sort = sort;
    element.color = color;
    element.alpha = alpha;
    element setparent(level.uiparent);
    element setshader(shader, width, height);
    element setpoint(align, relative, x, y);
    return element;
}

drawShader(shader, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}




callbackplayerkilled_stub(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration)
{
    eattacker do_hitmarker_internal(smeansofdeath);
    obituary(self, eattacker, sweapon, smeansofdeath);

    [[level.callbackplayerkilled_og]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
}


noclip()
{
    self endon("NoclipOff");
    self.fly = 0;
    ufo = spawn("script_model", self.origin);
    for(;;)
    {
        if (self secondaryoffhandbuttonpressed() || self FragButtonPressed() || self attackButtonPressed())
        {
            self playerLinkTo(UFO);
            self.fly = 1;
        }
        else
        {
            self.fly = 0;
        }
        if (self.fly)
        {
            fly = self.origin + vector_scal(anglesToForward(self getPlayerAngles()), self.ufospeed);
            UFO moveTo(fly, .02);
        }
        wait 0.001;
    }
}




status_hud()
{
	self endon("disconnect");

	x = 5;
	y = -112;
	if (level.script == "zm_buried")
	{
		y -= 20;
	}

	status = newclienthudelem(self);
	status.alignx = "left";
	status.aligny = "middle";
	status.horzalign = "user_left";
	status.vertalign = "user_bottom";
	status.x += x;
	status.y += y;
	status.fontscale = 1;
	status.alpha = 0;
	status.color = ( 0.847, 0.553, 0.741 );
	status.hidewheninmenu = 1;
	status.foreground = 1;

	status endon("death");

	status thread destroy_on_intermission();

	flag_wait( "initial_blackscreen_passed" );
	status settext("the seeker is lurking..");
	status.alpha = 1;

	while (1)
	{
		seeker = level.firsthide;
		dist = distance(self.origin, seeker.origin);
		text = "the seeker is near! (" + dist+")";
		stext = "the seeker is lurking..";

		if(self != seeker)
		{
		if(distance(self.origin, seeker.origin) < 400)
		{

			health = level.firsthide.health;

			status.color = ( 0.769, 0, 0 );
			status fadeovertime(1);
			status.alpha = 0;
			wait 1;
			status.color = ( 0.875, 0.678, 0.549 );
			status settext(text);
			status fadeovertime(1);
			status.alpha = 1;
			wait 1;
			continue;
		} else {
			wait 1;
			status.color = ( 0.529, 0.729, 0.549 );
			status settext(stext);
			
		}
		}

		wait 0.05;
	}
}



enable_night_mode()
{
	if( !isDefined( level.default_r_exposureValue ) )
		level.default_r_exposureValue = getDvar( "r_exposureValue" );
	if( !isDefined( level.default_r_lightTweakSunLight ) )
		level.default_r_lightTweakSunLight = getDvar( "r_lightTweakSunLight" );
	if( !isDefined( level.default_r_sky_intensity_factor0 ) )
		level.default_r_sky_intensity_factor0 = getDvar( "r_sky_intensity_factor0" );
	// if( !isDefined( level.default_r_sky_intensity_factor0 ) )
	// 	level.default_r_lightTweakSunColor = getDvar( "r_lightTweakSunColor" );

	//self setclientdvar( "r_fog", 0 );
	self setclientdvar( "r_filmUseTweaks", 1 );
	self setclientdvar( "r_bloomTweaks", 1 );
	self setclientdvar( "r_exposureTweak", 1 );
	self setclientdvar( "vc_rgbh", "0.07 0 0.25 0" );
	self setclientdvar( "vc_yl", "0 0 0.25 0" );
	self setclientdvar( "vc_yh", "0.015 0 0.07 0" );
	self setclientdvar( "vc_rgbl", "0.015 0 0.07 0" );
	self setclientdvar( "vc_rgbh", "0.015 0 0.07 0" );
	self setclientdvar( "r_exposureValue", 3.9 );
	self setclientdvar( "r_lightTweakSunLight", 16 );
	self setclientdvar( "r_sky_intensity_factor0", 3 );
	//self setclientdvar( "r_lightTweakSunColor", ( 0.015, 0, 0.07 ) );
	if( level.script == "zm_buried" )
	{
		self setclientdvar( "r_exposureValue", 4 );
	}
	else if( level.script == "zm_tomb" )
	{
		self setclientdvar( "r_exposureValue", 4 );
	}
	else if( level.script == "zm_nuked" )
	{
		self setclientdvar( "r_exposureValue", 5.6 );
	}
	else if( level.script == "zm_highrise" )
	{
		self setclientdvar( "r_exposureValue", 3 );
	}
}

disable_night_mode()
{
	self notify( "disable_nightmode" );
	//self setclientdvar( "r_fog", 1 );
	self setclientdvar( "r_filmUseTweaks", 0 );
	self setclientdvar( "r_bloomTweaks", 0 );
	self setclientdvar( "r_exposureTweak", 0 );
	self setclientdvar( "vc_rgbh", "0 0 0 0" );
	self setclientdvar( "vc_yl", "0 0 0 0" );
	self setclientdvar( "vc_yh", "0 0 0 0" );
	self setclientdvar( "vc_rgbl", "0 0 0 0" );
	self setclientdvar( "r_exposureValue", int( level.default_r_exposureValue ) );
	self setclientdvar( "r_lightTweakSunLight", int( level.default_r_lightTweakSunLight ) );
	self setclientdvar( "r_sky_intensity_factor0", int( level.default_r_sky_intensity_factor0 ) );
	//self setclientdvar( "r_lightTweakSunColor", level.default_r_lightTweakSunColor );
}

rotate_skydome()
{
	if ( level.script == "zm_tomb" )
	{
		return;
	}
	
	x = 360;
	
	self endon("disconnect");
	for(;;)
	{
		x -= 0.025;
		if ( x < 0 )
		{
			x += 360;
		}
		self setclientdvar( "r_skyRotation", x );
		wait 0.1;
	}
}

change_skydome()
{
	x = 6500;
	
	self endon("disconnect");
	for(;;)
	{
		x += 1.626;
		if ( x > 25000 )
		{
			x -= 23350;
		}
		self setclientdvar( "r_skyColorTemp", x );
		wait 0.1;
	}
}

eye_color_watcher()
{	
	if( getDvar( "eye_color") == "" )
		setDvar( "eye_color", 0 );

	wait 1;

	while(1)
	{
		while( !getDvarInt( "eye_color" ) )
		{
			wait 0.1;
		}
		level setclientfield( "zombie_eye_change", 1 );
    	sndswitchannouncervox( "richtofen" );

		while( getDvarInt( "eye_color" ) )
		{
			wait 0.1;
		}
		level setclientfield( "zombie_eye_change", 0 );
		sndswitchannouncervox( "sam" );
	}
}


