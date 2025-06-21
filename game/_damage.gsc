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


/*

callbackplayerdamage_stub(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{


    eattacker do_hitmarker_internal(smeansofdeath);

		if ( isDamageWeapon( sWeapon ) )
            {
			iDamage = 9999;
          //  eAttacker playsound( death[deathr] );
            }

    [[level.callbackplayerdamage_og]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
}
*/
callbackplayerdamage_stub(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{


		
		b = randomize("^1Direct^7 Impact!;^2Direct^7 Impact!;^3Direct^7 Impact!;^4Direct^7 Impact!;^5Direct^7 Impact!;^6Direct^7 Impact!;^8Direct^7 Impact!;^9Direct^7 Impact!");
		
		
		
		a = randomize("^1Stabbed^7!;^2Stabbed^7!;^3Stabbed^7!;^4Stabbed^7!;^5Stabbed^7!;^6Stabbed^7!;^8Stabbed^7!;^9Stabbed^7!");


		if(smeansofdeath != "MOD_TRIGGER_HURT") 
		{


		if(isDefined(self.graceperiod))
		{
			self iprintln("You ^1cannot^7 hurt players during the grace period.");
			
		} else {

		if ( smeansofdeath == "MOD_MELEE") 
		{
			goodluck = randomintrange(500,1200);
			iDamage = goodluck;
			//eattacker iprintln(a);
			eattacker thread play_sound_at_pos( "purchase", eattacker.origin );
		
		}
		if ( smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
		{
			iDamage = 7;
		}
		if ( smeansofdeath == "MOD_IMPACT")
		{
			iDamage = 9999;
			eattacker iprintln(b);
			eattacker thread play_sound_at_pos( "purchase", eattacker.origin );
		}


    	eattacker do_hitmarker_internal(smeansofdeath);
    	[[level.callbackplayerdamage_og]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex);  
		}
		
		} 

}

isDamageWeapon( weapon )
{
    if ( !isDefined ( weapon ) )
        return false;
    

    if (weapon == "usrpg_zm")
        return true;
        
    switch( weapon )
    {
       case "rnma_zm": //Allows Tomahawk Damage
             return true;
        default:
             return false;        
    }

}   

callbackplayerkilled_stub(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration)
{
    eattacker do_hitmarker_internal(smeansofdeath);
    obituary(self, eattacker, sweapon, smeansofdeath);

    [[level.callbackplayerkilled_og]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
}


do_hitmarker_internal(mod, death)
{
    if (!isdefined(death))
	
        death = false;

    if (isdefined(mod) && mod != "MOD_CRUSH" && mod != "MOD_GRENADE_SPLASH" && mod != "MOD_HIT_BY_OBJECT")
    {
        self.hud_damagefeedback.color = ( 0.847, 0.553, 0.741 );
		self playlocalsound( "mpl_hit_alert" );
        if (death && level.red_hitmarkers_on_death)
            self.hud_damagefeedback.color = (0.282, 0.153, 0.184);

        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
	}
}

z_hitmarkers()
{
	precacheshader( "damage_feedback" );
	
	maps\mp\zombies\_zm_spawner::register_zombie_damage_callback(::do_hitmarker);
    maps\mp\zombies\_zm_spawner::register_zombie_death_event_callback(::do_hitmarker_death);

    for( ;; )
    {
        level waittill( "connected", player );
        player.hud_damagefeedback = newdamageindicatorhudelem( player );
    	player.hud_damagefeedback.horzalign = "center";
    	player.hud_damagefeedback.vertalign = "middle";
    	player.hud_damagefeedback.x = -12;
    	player.hud_damagefeedback.y = -12;
    	player.hud_damagefeedback.alpha = 0;
    	player.hud_damagefeedback.archived = 1;
    	player.hud_damagefeedback.color = ( 1, 1, 1 );
    	player.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
		player.hud_damagefeedback_red = newdamageindicatorhudelem( player );
    	player.hud_damagefeedback_red.horzalign = "center";
    	player.hud_damagefeedback_red.vertalign = "middle";
    	player.hud_damagefeedback_red.x = -12;
    	player.hud_damagefeedback_red.y = -12;
    	player.hud_damagefeedback_red.alpha = 0;
    	player.hud_damagefeedback_red.archived = 1;
    	player.hud_damagefeedback_red.color = ( 0.557, 0.502, 0.557 );
    	player.hud_damagefeedback_red setshader( "damage_feedback", 24, 48 );
    }
}


updatedamagefeedback( mod, inflictor, death ) //checked matches cerberus output
{
	if ( !isplayer( self ) || isDefined( self.disable_hitmarkers ))
	{
		return;
	}
	if ( isDefined( mod ) && mod != "MOD_CRUSH" && mod != "MOD_TRIGGER_HURT")
	{
		if ( isDefined( inflictor ))
		{
			self playlocalsound( "mpl_hit_alert" );
		}
		if( death && getdvarintdefault( "redhitmarkers", 1 ))
		{
    		self.hud_damagefeedback_red setshader( "damage_feedback", 24, 48 );
			self.hud_damagefeedback_red.alpha = 1;
			self.hud_damagefeedback_red fadeovertime( 1 );
			self.hud_damagefeedback_red.alpha = 0;
		}
		else
		{
        	self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
			self.hud_damagefeedback.alpha = 1;
			self.hud_damagefeedback fadeovertime( 1 );
			self.hud_damagefeedback.alpha = 0;
		}
	}
    return 0;
}

do_hitmarker_death()
{
	if( isDefined( self.attacker ) && isplayer( self.attacker ) && self.attacker != self )
    {
		self.attacker thread updatedamagefeedback( self.damagemod, self.attacker, 1 );
    }
    return 0;
}

do_hitmarker(mod, hitloc, hitorig, player, damage)
{
    if( isDefined( player ) && isplayer( player ) && player != self )
    {
		player thread updatedamagefeedback( mod, player, 0 );
    }
    return 0;
}






/*

    failed freezebomb concept:

	if(sweapon == "frag_grenade_zm" || !einflictor)

	{

		eattacker freezecontrolsallowlook(true);
		eattacker enableInvulnerability();
		eattacker thread show_grief_hud_msg("You are now frozen!");
		wait 4;
		eattacker freezecontrolsallowlook(false);
		eattacker disableInvulnerability();

	}
*/
