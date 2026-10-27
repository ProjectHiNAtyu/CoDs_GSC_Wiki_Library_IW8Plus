// scripts\mp\damage.gsc  (hash_4c9f3a24feabde1f.gscc) (size: 196783 Bytes / 0x300af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf29cbf30 (4070358832)
// size ...... 196783 (0x300af)
// includes .. 122 (offset: 0x2cfbf)
// strings ... 555 (offset: 0x2d38f)
// dev strs .. 73  (offset: 0x2fc3f)
// exports ... 236 (offset: 0x228c7)
// cseg ...... 0x3719 + 0x1f1ae (0x228c7)
// imports ... 964 (offset: 0x24da7)
// animtree1 . 0   (offset: 0x300af)
// animtree2 . 0   (offset: 0x300af)
#using script_16ea1b94f0f381b3;
#using script_4c9bd9a3bf3f8cf7;
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\damage;
#using scripts\common\damage_effects;
#using scripts\common\debug;
#using scripts\common\game_utility;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\string;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\analyticslog;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\bounty;
#using scripts\mp\br\gametypes\br_ai_gulag;
#using scripts\mp\br\gametypes\br_alt_mode_shock;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_dom_gulag;
#using scripts\mp\br\gametypes\br_jugg_common;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\equipment\throwing_knife;
#using scripts\mp\common\equipment\throwstar;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\headgear;
#using scripts\mp\common\perks\perk_mark_targets;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\gun_shield;
#using scripts\mp\crossbow;
#using scripts\mp\damage_numbers;
#using scripts\mp\damagefeedback;
#using scripts\mp\deathicons;
#using scripts\mp\deathrecap;
#using scripts\mp\disguise_controller;
#using scripts\mp\dragonsbreath;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\execution;
#using scripts\mp\final_killcam;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\shock_buff;
#using scripts\mp\gestures;
#using scripts\mp\heavyarmor;
#using scripts\mp\hud_editor;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\killcam;
#using scripts\mp\laststand;
#using scripts\mp\lightarmor;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\meatshield;
#using scripts\mp\mtx_weapon;
#using scripts\mp\operator;
#using scripts\mp\outline;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\playerstats_interface;
#using scripts\mp\potg_events;
#using scripts\mp\rank;
#using scripts\mp\riotshield;
#using scripts\mp\shellshock;
#using scripts\mp\spawncamera;
#using scripts\mp\stat_limits;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\teamrevive;
#using scripts\mp\teams;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;

#namespace damage;

// Namespace damage
// Params 19
// Checksum 0xde6db9e0, Offset: 0x3737
// Size: 0x1e59
function callback_playerdamage_internal( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    if ( !isdefined( level.playerdamagechecks ) )
    {
        level.playerdamagechecks = [];
    }
    
    if ( eattacker.classname == "worldspawn" )
    {
        eattacker = undefined;
    }
    
    if ( isdefined( eattacker.gunner ) )
    {
        eattacker = eattacker.gunner;
    }
    
    if ( getdvarint( @"hash_c36efcba0f21f379", 0 ) == 1 && isdefined( objweapon ) )
    {
        baseweaponref = weapon::getweaponrootname( objweapon.basename );
        weaponlootid = loot::getlootidfromref( baseweaponref );
        var_a6b3ec2abf218ee6 = loot::function_7ece35b2b5205ad( weaponlootid );
        goldengunexception = weaponlootid == 39598 && level.gametype == "gold_gun" && eattacker.raygun;
        
        if ( var_a6b3ec2abf218ee6 && !goldengunexception )
        {
            victim = eattacker;
        }
    }
    
    /#
        if ( getdvarint( @"scr_force_damage", 0 ) != 0 )
        {
            victim finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, 0 );
            function_2499f72abb86f810( victim, "<dev string:x24>" );
            return;
        }
    #/
    
    shouldreturn = filterdamage( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, shitloc );
    
    if ( isdefined( shouldreturn ) )
    {
        if ( victim.takedamage == 0 )
        {
            if ( isdefined( victim.var_a84311e2c57646de ) )
            {
                victim [[ victim.var_a84311e2c57646de ]]( { #vdir:vdir, #vpoint:vpoint, #shitloc:shitloc, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #victim:victim, #eattacker:eattacker, #einflictor:einflictor } );
            }
            
            victim callback::callback( #"hash_72c6652e871e91a5" );
        }
        
        function_2499f72abb86f810( victim, "filterDamage true, " + shouldreturn );
        return;
    }
    
    if ( idflags & 8589934592 )
    {
        victim finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, 1 );
        function_2499f72abb86f810( victim, "Last Stand Tick Damage" );
        return;
    }
    
    var_ca02bfdd611a56f4 = victim.health;
    iskillstreakweapon = isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon );
    
    if ( !level.allowprematchdamage )
    {
        if ( game[ "inLiveLobby" ] || !flags::gameflag( "prematch_done" ) || level.infilcinematicactive )
        {
            handledamagefeedback( einflictor, eattacker, victim, 0, smeansofdeath, objweapon, shitloc, idflags, 1, 1, iskillstreakweapon, willknockdown, undefined, vpoint );
            function_2499f72abb86f810( victim, "!istrue( level.allowPrematchDamage ) in prematch still" );
            return;
        }
    }
    
    if ( isdefined( level.var_a44ba6c01eac941 ) && [[ level.var_a44ba6c01eac941 ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2 ) )
    {
        return;
    }
    
    var_f956d45d187000c0 = isplayer( victim ) && victim ismeatshieldvictim() && smeansofdeath != "MOD_MEATSHIELD";
    
    if ( var_f956d45d187000c0 )
    {
        if ( !( victim function_6cc6c35f3656f467() && victim function_1f93baff34558ff0() ) )
        {
            return;
        }
        
        meatshieldattacker = victim getmeatshieldpartner();
        
        if ( attackerishittingteam( meatshieldattacker, eattacker, additionalparams.turretindex ) )
        {
            return;
        }
        
        var_30db8e2b53b42ff = einflictor.stuckto == victim && einflictor.var_5e3a1c87edc1edd5 == #"bunkerbuster";
        var_d3ceaa0c4a6de28e = idamage;
        
        if ( var_30db8e2b53b42ff || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" )
        {
            var_d3ceaa0c4a6de28e = int( idamage * getdvarfloat( @"hash_1dee446fa0921f47", 1 ) );
        }
        
        var_bfa258faf98a7c99 = victim meatshield::function_222c414f9985817e( einflictor );
        isblockeddamage = !var_bfa258faf98a7c99;
        victim meatshield::function_1fd576a60f12c8da( eattacker, var_d3ceaa0c4a6de28e, var_bfa258faf98a7c99, isblockeddamage );
        dir = vectornormalize( eattacker.origin - self.origin );
        victim finishplayerdamagewrapper( einflictor, eattacker, 0, idflags, smeansofdeath, fdistance, objweapon, vpoint, dir, shitloc, psoffsettime, modelindex, partname, 1, 0, 0, var_d3ceaa0c4a6de28e, poisedamage, willknockdown );
        eattacker handledamagefeedback( einflictor, eattacker, victim, var_d3ceaa0c4a6de28e, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, willknockdown, partname, vpoint );
        meatshieldholder = victim getmeatshieldpartner();
        
        if ( !isdefined( meatshieldholder ) )
        {
            return;
        }
        
        if ( var_30db8e2b53b42ff )
        {
            meatshieldholder dodamage( idamage, vpoint, eattacker, einflictor, smeansofdeath, objweapon, shitloc, fdistance, idflags );
        }
        
        if ( smeansofdeath == "MOD_PROJECTILE" )
        {
            idamage = 1;
            meatshieldholder dodamage( idamage, vpoint, eattacker, einflictor, smeansofdeath, objweapon, shitloc, fdistance, idflags );
        }
        
        return;
    }
    
    var_622d76b2a53e43c0 = isplayer( victim ) && victim ismeatshieldattacker() && ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_BUMP" );
    
    if ( var_622d76b2a53e43c0 )
    {
        meatshieldvictim = victim getmeatshieldpartner();
        
        if ( isplayer( meatshieldvictim ) )
        {
            if ( idamage >= victim.health )
            {
                meatshieldvictim cancelmeatshield();
                meatshieldvictim dodamage( meatshieldvictim.health, victim.origin, victim, einflictor, smeansofdeath, objweapon, shitloc, fdistance, idflags );
            }
            else
            {
                meatshielddamage = idamage / meatshieldvictim.maxhealth * meatshieldvictim.meatshieldmaxhealth;
                meatshieldvictim meatshield::function_1fd576a60f12c8da( victim, meatshielddamage, 0, 0 );
            }
        }
    }
    
    if ( !level.gamemodebundle.var_6a38404afa0c8d92 )
    {
        if ( isplayer( victim ) && victim function_219428ef27cf009c() && smeansofdeath != "MOD_EXECUTION" )
        {
            executionattacker = victim getexecutionpartner();
            
            if ( attackerishittingteam( executionattacker, eattacker ) )
            {
                var_267899400d0d8b68 = 1;
            }
        }
    }
    
    if ( utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"isdefibrillator", objweapon ) )
    {
        params = { #objweapon:objweapon, #victim:victim, #eattacker:eattacker, #einflictor:einflictor };
        utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"hash_dd3226361f17fd81", params );
        function_2499f72abb86f810( victim, "utility::callSharedFunc( #x\"defibrillator\", #x\"isDefibrillatorDamage\", objWeapon )" );
        return;
    }
    
    attackerishittingteammate = attackerishittingteam( victim, eattacker, additionalparams.turretindex );
    
    if ( attackerishittingteammate || var_267899400d0d8b68 )
    {
        var_cc4d41e8f890d710 = einflictor && einflictor vehicle::is_vehicle() && !iskillstreakweapon && smeansofdeath == "MOD_EXPLOSIVE";
        friendlyfireexception = istrue( einflictor.friendlyfireexception );
        
        if ( !var_cc4d41e8f890d710 && !friendlyfireexception || einflictor.var_331f7e56b7a9891b )
        {
            idamage = handlefriendlyfiredamage( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon, willknockdown );
            
            if ( idamage == 0 )
            {
                params = { #iskillstreakweapon:iskillstreakweapon, #partname:partname, #modelindex:modelindex, #psoffsettime:psoffsettime, #shitloc:shitloc, #vdir:vdir, #vpoint:vpoint, #objweapon:objweapon, #fdistance:fdistance, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #victim:victim, #eattacker:eattacker, #einflictor:einflictor };
                callback::callback( #"player_friendly_fire", params );
                function_2499f72abb86f810( victim, "handleFriendlyFireDamage damage == 0" );
                return;
            }
        }
    }
    
    var_4d662094f81ae869 = 0;
    isstimpistol = weapon::isstimpistolweapon( objweapon );
    
    if ( utility::issharedfuncdefined( #"hash_a4d82011a2a333b3", #"hash_dbfc9b45172a4949" ) )
    {
        var_4d662094f81ae869 = [[ utility::getsharedfunc( #"hash_a4d82011a2a333b3", #"hash_dbfc9b45172a4949" ) ]]();
    }
    
    if ( var_4d662094f81ae869 && isstimpistol && utility::isbulletdamage( smeansofdeath ) )
    {
        idamage = 0;
        function_2499f72abb86f810( victim, "super_stimPistol_getHostileRevivesEnabled() && super_stimPistol_isStimPistol() && isBulletDamage()" );
        return;
    }
    
    ignorelightarmor = 0;
    
    if ( victim.spawnprotection || victim islaststandinvulnerable() )
    {
        washurttrigger = smeansofdeath == "MOD_TRIGGER_HURT" || eattacker.classname == "trigger_hurt";
        wasfalldamage = smeansofdeath == "MOD_FALLING";
        wassuicidedamage = smeansofdeath == "MOD_SUICIDE";
        var_71fa1018f4ec53ca = smeansofdeath == "MOD_BUMP";
        
        if ( !washurttrigger && !wasfalldamage && !wassuicidedamage && !var_71fa1018f4ec53ca )
        {
            var_25d47fc38a90a059 = 0;
            
            if ( isdefined( level.gametypebundle ) && victim.spawnprotection )
            {
                switch ( smeansofdeath )
                {
                    case #"hash_590bdb04e515167b":
                    case #"hash_5f1054c48d66fd1c":
                    case #"hash_966768b3f0c94767":
                        if ( level.gametypebundle.var_a79f3da1cdc60ac3 )
                        {
                            var_25d47fc38a90a059 = 1;
                        }
                        
                        break;
                    case #"hash_a86d8c43482948a4":
                        if ( level.gametypebundle.var_807f9de3590015a2 && weapon::isprimaryweapon( objweapon ) )
                        {
                            var_25d47fc38a90a059 = 1;
                        }
                        
                        break;
                    case #"hash_d8646db4e6ee3658":
                        if ( level.gametypebundle.var_5636d51684bededf || dragonsbreath::function_7feebca326ca7376( objweapon ) && istrue( level.gametypebundle.var_a79f3da1cdc60ac3 ) )
                        {
                            var_25d47fc38a90a059 = 1;
                        }
                        
                        break;
                    case #"hash_b1078ff213fddba6":
                        if ( level.gametypebundle.var_38255b32d18a59d1 )
                        {
                            var_25d47fc38a90a059 = 1;
                        }
                        
                        break;
                    case #"hash_19fbc34dda39832e":
                    case #"hash_1b5395c651f95456":
                    case #"hash_61e42661ac27b9f2":
                    case #"hash_a5123f4d02745600":
                        if ( level.gametypebundle.var_8de2da21e59a42b5 )
                        {
                            var_25d47fc38a90a059 = 1;
                        }
                        
                        break;
                    default:
                        if ( level.gametypebundle.var_a7b88c336da29356 && isexplosivedamagemod( smeansofdeath ) )
                        {
                            var_25d47fc38a90a059 = 1;
                        }
                        
                        break;
                }
                
                if ( var_25d47fc38a90a059 && level.gametypebundle.var_baaf8a3b7db62522 )
                {
                    ignorelightarmor = 1;
                }
            }
            
            if ( !var_25d47fc38a90a059 )
            {
                var_c984e13baf919436 = [ "MOD_CRUSH":1 ];
                
                if ( !var_c984e13baf919436[ smeansofdeath ] )
                {
                    handledamagefeedback( einflictor, eattacker, victim, 0, smeansofdeath, objweapon, shitloc, idflags, 1, 1, iskillstreakweapon, willknockdown, partname, vpoint );
                }
                
                function_2499f72abb86f810( victim, "( istrue( victim.spawnProtection ) || victim IsLastStandInvulnerable() ) && !wasHurtTrigger && !wasFallDamage" );
                return;
            }
        }
    }
    
    if ( isdefined( self.callbacks[ #"hash_d4bbb4278ed1fcab" ] ) || isdefined( level.callbacks[ #"hash_d4bbb4278ed1fcab" ] ) )
    {
        callback::callback( #"hash_d4bbb4278ed1fcab", { #victim:victim, #attacker:eattacker } );
    }
    
    if ( game_utility::getgametype() == "high" )
    {
        idamage = 0;
        
        if ( isdefined( objweapon ) && objweapon.basenamehash == %"rock_mp" )
        {
            victim utility::knockback_flat( vdir, 250 );
            eattacker thread events::shothit();
        }
    }
    
    if ( eattacker.classname == "script_origin" && eattacker.type == "soft_landing" )
    {
        function_2499f72abb86f810( victim, "eAttacker.classname == script_origin && eAttacker.type == soft_landing" );
        return;
    }
    
    if ( isagent( eattacker ) && utility::isbulletdamage( smeansofdeath ) && ( victim.attackeraccuracy <= 0 || eattacker.accuracy <= 0 ) )
    {
        function_2499f72abb86f810( victim, "IsAgent( eAttacker ) && utility::isBulletDamage( sMeansOfDeath ) && self.attackeraccuracy <= 0" );
        return;
    }
    
    if ( isdefined( victim.var_d681f0e0f5023f4f ) )
    {
        foreach ( toxic_growth in victim.var_d681f0e0f5023f4f )
        {
            if ( math::segmentvssphere( victim.origin, eattacker.origin, toxic_growth.origin, toxic_growth.protection_radius ) )
            {
                toxic_growth [[ toxic_growth.on_damage_func ]]( idamage );
                function_2499f72abb86f810( victim, "math::segmentVsSphere( victim.origin, eAttacker.origin, toxic_growth.origin, toxic_growth.protection_radius )" );
                return;
            }
        }
    }
    
    headshotmultiplier = 1;
    
    if ( var_cdd29ad5d1362c2 > 0 )
    {
        headshotmultiplier = idamage / var_cdd29ad5d1362c2;
    }
    
    idflags |= 4;
    weapongroup = weapon::getweapongroup( objweapon );
    
    if ( isspreadweapon( objweapon ) && damage_utility::validshotcheck( smeansofdeath, eattacker ) )
    {
        if ( dragonsbreath::isdragonsbreathweapon( objweapon ) && !dragonsbreath::function_527608d84b46e115( victim ) && ( weapongroup == "weapon_shotgun" || objweapon.isalternate || getweaponhasperk( objweapon, "specialty_incendiary_alt" ) ) )
        {
            victim thread dragonsbreathhitloccollection( shitloc, eattacker, objweapon );
        }
        
        idamage = spreadshotdamagemod( victim, eattacker, objweapon, idamage, idflags );
        
        if ( idamage == 0 )
        {
            function_2499f72abb86f810( victim, "isSpreadWeapon() && spreadShotDamageMod() iDamage == 0" );
            return;
        }
    }
    
    if ( einflictor.isweaponent )
    {
        victim thread meleestagger( eattacker );
    }
    
    weaponbasename = objweapon.basename;
    
    if ( !isdefined( weaponbasename ) )
    {
        assertmsg( "<dev string:x3a>" );
    }
    
    equiptype = weapon::getequipmenttype( objweapon );
    
    if ( isdefined( equiptype ) )
    {
        if ( equiptype == "lethal" )
        {
            idamage = lethalequipmentdamagemod( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon );
        }
        
        damagedata = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, partname, undefined, idflags, undefined, shitloc );
        result = equipment_mp::equiponplayerdamaged( damagedata );
        
        if ( result == 0 )
        {
            if ( eattacker.var_c36269996253c559.var_4e0caacb60f9e217 && eattacker.var_c36269996253c559.var_11a45d4b82e41038 && victim [[ eattacker.var_c36269996253c559.var_4e0caacb60f9e217 ]]( objweapon, eattacker, smeansofdeath, idamage ) )
            {
                victim thread [[ eattacker.var_c36269996253c559.var_11a45d4b82e41038 ]]( eattacker, einflictor );
            }
            
            function_2499f72abb86f810( victim, "IsDefined( getEquipmentType ) && equipOnPlayerDamaged() == false" );
            return;
        }
        
        if ( utility::callsharedfunc( #"gametype", #"hash_eac27f8466f4fff2", victim, eattacker ) )
        {
            return;
        }
    }
    
    if ( victim game_utility_mp::ismatchstartprotected() )
    {
        var_9585d4bbf5043072 = objweapon.basenamehash == %"minefield_mp";
        wassuicide = smeansofdeath == "MOD_SUICIDE";
        
        if ( !var_9585d4bbf5043072 && !wassuicide )
        {
            isunderbarrel = istrue( objweapon.isalternate );
            
            if ( isdefined( equiptype ) && !weapon::isthrowingknife( objweapon ) || isunderbarrel || smeansofdeath == "MOD_EXPLOSIVE" )
            {
                damagelimit = int( max( victim.health / 5, 1 ) );
                
                if ( idamage >= damagelimit )
                {
                    idamage = damagelimit;
                }
            }
        }
    }
    
    if ( weapon::iskillstreakweapon( weaponbasename ) )
    {
        idamage = killstreakdamagefilter( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor.streakinfo );
        
        if ( idamage == 0 )
        {
            function_2499f72abb86f810( victim, "getWeaponType() == killstreak && iDamage == 0" );
            return;
        }
        
        if ( isdefined( level.gunshipplayer ) && level.gunshipplayer === eattacker )
        {
            level notify( #"ai_pain", victim );
        }
    }
    
    if ( isdefined( level.scripted_damage_override ) )
    {
        foreach ( func in level.scripted_damage_override )
        {
            n_damage = self [[ func ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime );
            
            if ( isdefined( n_damage ) )
            {
                idamage = n_damage;
            }
        }
    }
    
    idamage = handleriotshieldhits( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, iskillstreakweapon, ignorelightarmor, partname );
    [ idamage, lightarmordamage ] = modifydamagegeneral( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, var_cdd29ad5d1362c2, partname );
    
    if ( idamage == 0 && lightarmordamage == 0 )
    {
        function_2499f72abb86f810( victim, "iDamage == 0 && lightArmorDamage == 0" );
        return;
    }
    
    if ( dragonsbreath::isdragonsbreathweapon( objweapon ) && !dragonsbreath::function_527608d84b46e115( victim ) && !isspreadweapon( objweapon ) && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_FIRE" )
    {
        victim thread dragonsbreath::function_86551e1f9bf5f185( idamage + lightarmordamage, eattacker, objweapon, shitloc );
    }
    else if ( crossbow::isthermitecrossbow( objweapon ) )
    {
        victim thread dragonsbreath::function_339797d4003778a7( shitloc, crossbow::function_aa9fd31c54910c8() );
    }
    
    var_b498ef73c22e754d = 0;
    
    if ( victim == eattacker )
    {
        var_b498ef73c22e754d = 1;
    }
    
    if ( var_b498ef73c22e754d && ( objweapon.basenamehash == %"danger_circle_br" || objweapon.basenamehash == %"rex_radiation_dmz" ) )
    {
        var_b498ef73c22e754d = 0;
    }
    
    if ( isbrgamemode() && victim common_kiosk::function_ab8446ed6aa283a5( attackerishittingteammate || var_b498ef73c22e754d, eattacker, idamage + lightarmordamage, objweapon ) )
    {
        victim common_kiosk::_closepurchasemenuwithresponse( 2 );
    }
    
    if ( !victim.donotmodifydamage )
    {
        modifieddamageresults = cac_modified_damage( victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, einflictor, 0, idflags, iskillstreakweapon, headshotmultiplier, ignorelightarmor, weapongroup );
        idamage = modifieddamageresults[ 0 ];
        heavyarmordamage = modifieddamageresults[ 1 ];
        shitloc = modifieddamageresults[ 2 ];
    }
    else
    {
        heavyarmordamage = 0;
    }
    
    if ( !level.var_cfbae0f0dc7ccd6b && iskilltradedamage( eattacker, victim, idamage, smeansofdeath, objweapon, var_2300d396e46c0fe7 ) )
    {
        function_2499f72abb86f810( victim, "isKillTradeDamage()" );
        return;
    }
    
    if ( isdefined( victim.forcehitlocation ) )
    {
        shitloc = victim.forcehitlocation;
        victim.forcehitlocation = undefined;
    }
    
    if ( isplayer( eattacker ) && ( weaponbasename == "smoke_grenade_mp" || weapon::isthrowingknife( objweapon ) ) )
    {
        eattacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "hits" );
    }
    
    if ( isplayer( eattacker ) && isdefined( smeansofdeath ) && smeansofdeath == "MOD_IMPACT" && isalive( eattacker ) && soundexists( "hit_marker_eqp_imp_3d" ) )
    {
        self playsoundtoplayer( "hit_marker_eqp_imp_3d", eattacker );
    }
    
    if ( isplayer( eattacker ) && isdefined( smeansofdeath ) && smeansofdeath == "MOD_RIFLE_BULLET" && isalive( eattacker ) && einflictor != eattacker && soundexists( "hit_marker_eqp_imp_3d" ) )
    {
        self playsoundtoplayer( "hit_marker_eqp_imp_3d", eattacker );
    }
    
    vdamagedir = vdir;
    
    if ( isdefined( idflags ) && idflags & 256 && idamage < self.health )
    {
        vdamagedir = victim.origin - eattacker.origin;
    }
    
    if ( isenvironmentalscriptableinflictor( einflictor ) )
    {
        idamage = 0;
    }
    
    if ( isplayer( eattacker ) )
    {
        if ( armor::armorvest_washit( eattacker ) || helmet_washit( eattacker ) )
        {
            if ( idamage < victim.health )
            {
                idflags |= 512;
            }
        }
        
        if ( armor::armorvest_wasbroke( eattacker ) || helmet_wasbroke( eattacker ) )
        {
            if ( idamage < victim.health )
            {
                idflags |= 1024;
            }
        }
        
        if ( victim killstreak::function_27766a07ce1d112a() )
        {
            idflags |= 512;
        }
        
        foreach ( modifier in level.damage_feedback.dflags_modifiers )
        {
            idflags = [[ modifier ]]( { #partname:partname, #willknockdown:willknockdown, #iskillstreakweapon:iskillstreakweapon, #heavyarmordamage:heavyarmordamage, #lightarmordamage:lightarmordamage, #idflags:idflags, #shitloc:shitloc, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idamage:idamage, #victim:victim, #eattacker:eattacker, #einflictor:einflictor } );
        }
    }
    
    if ( isdefined( level.onplayerdamaged_func ) )
    {
        if ( ![[ level.onplayerdamaged_func ]]( smeansofdeath ) )
        {
            function_2499f72abb86f810( victim, "[[level.onPlayerDamaged_func]] == false" );
            return;
        }
    }
    
    if ( isdefined( einflictor ) && isdefined( objweapon ) && isdefined( einflictor.equipmentref ) )
    {
        if ( einflictor.equipmentref == "equip_throwstar" )
        {
            idamage = throwstar::function_958668cc77ccb4af( einflictor, victim, idamage, partname );
        }
        
        if ( einflictor.equipmentref == "equip_findia_throwing_knife" )
        {
            data = spawnstruct();
            data.einflictor = einflictor;
            data.victim = victim;
            data.idamage = idamage;
            data.partname = partname;
            idamage = self [[ utility::getsharedfunc( #"findia_throwing_knife", #"hash_b3aa95d59ba36635" ) ]]( data );
        }
        
        if ( einflictor.equipmentref == "equip_throwing_knife" || einflictor.equipmentref == "equip_shuriken" || einflictor.equipmentref == "equip_throwstar" || einflictor.equipmentref == "equip_mutation_throwstar" )
        {
            if ( einflictor.bwasunderwater )
            {
                idamage = throwing_knife::function_588ffc7587b7cb54( victim );
            }
            
            if ( utility::issharedfuncdefined( #"perk_cqc", #"perk_apply_effect" ) && isdefined( victim.perks[ "specialty_close_quarter" ] ) )
            {
                idamage = [[ utility::getsharedfunc( #"perk_cqc", #"perk_apply_effect" ) ]]( idamage, victim, eattacker, 1 );
            }
        }
    }
    
    if ( isdefined( eattacker ) && smeansofdeath == "MOD_MELEE" && isdefined( eattacker.perks[ "specialty_super_strength" ] ) )
    {
        idamage = victim.maxhealth;
    }
    
    if ( game_utility_mp::isjuggermoshgamemode() && objweapon.basenamehash == %"jup_jp23_me_swhiskey_mp" )
    {
        idamage = victim.maxhealth;
    }
    
    if ( isplayer( eattacker ) && eattacker.var_9aa66d67d4bbc976 && eattacker utility::callsharedfunc( #"roulette_weapon", #"hash_313858dca0b4e4b8", objweapon ) )
    {
        idamage = 0;
    }
    
    if ( !isdefined( level.playerdamagechecks[ #"isdogzombie" ] ) )
    {
        level.playerdamagechecks[ #"isdogzombie" ] = isdefined( level.sharedfuncs[ #"escort" ][ #"isdogzombie" ] );
    }
    
    if ( level.playerdamagechecks[ #"isdogzombie" ] )
    {
        isdogzombie = isdefined( eattacker ) && [[ level.sharedfuncs[ #"escort" ][ #"isdogzombie" ] ]]();
        
        if ( isdogzombie && objweapon == level.defaultfist )
        {
            idamage = victim.maxhealth;
        }
    }
    
    if ( game_utility_mp::ismutationgamemode() && ( victim.inlaststand || victim.playergoingintols ) )
    {
        idamage = 0;
        eattacker damagefeedback::updatedamagefeedback( "hitnobulletdamage_wm" );
    }
    
    if ( isplayer( eattacker ) && isdefined( eattacker.lifetimedamage ) )
    {
        eattacker.lifetimedamage += idamage;
    }
    
    if ( isplayer( victim ) && !issimulationplayer( victim ) )
    {
        victim.var_52134643987847ec += idamage;
    }
    
    if ( isdefined( level.var_20949167f659852f[ weaponbasename ] ) )
    {
        idamage = [[ level.var_20949167f659852f[ weaponbasename ] ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon );
    }
    
    if ( level.gametypebundle.var_1f1d15085bcb3eac && isdefined( objweapon ) && isdefined( eattacker ) && eattacker.type == "human" && ( shitloc == "head" || shitloc == "helmet" || shitloc == "neck" ) )
    {
        if ( idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        crit_damage_mod = weapongetdamagelocationmodifier( objweapon, shitloc, weapondamagetype );
        normal_damage_mod = weapongetdamagelocationmodifier( objweapon, "torso_upper", weapondamagetype );
        
        if ( isdefined( crit_damage_mod ) && isdefined( normal_damage_mod ) && crit_damage_mod != 0 )
        {
            damage = idamage;
            var_c51a0b56b7eb5a3b = damage / crit_damage_mod;
            idamage = int( var_c51a0b56b7eb5a3b * normal_damage_mod );
        }
    }
    
    if ( isdefined( eattacker.perks[ "specialty_back_stab" ] ) && level.gamemodebundle.var_e5d8ba1c0a112dc6 )
    {
        backstabdistance = getdvarint( @"hash_b80f1b17813f2bf", 120 );
        var_8d3bd7dbfd669cea = getdvarfloat( @"hash_86eeddee07494ab3", 2 );
        var_42c2faa7cb43c425 = getdvarfloat( @"hash_874388f1f435d9a6", 1.5 );
        var_a64759de317cc7f = getdvarfloat( @"scr_melee_backstab_damage_scalar", 3 );
        
        if ( isdefined( smeansofdeath ) && !withinfov2d( victim.origin, victim.angles, eattacker.origin, -0.6 ) )
        {
            if ( distance( victim.origin, eattacker.origin ) <= backstabdistance )
            {
                if ( smeansofdeath == "MOD_RIFLE_BULLET" )
                {
                    if ( shitloc == "head" || shitloc == "helmet" )
                    {
                        idamage = int( idamage * var_8d3bd7dbfd669cea );
                    }
                    
                    if ( shitloc == "neck" || shitloc == "torso_upper" )
                    {
                        idamage = int( idamage * var_42c2faa7cb43c425 );
                    }
                }
                
                if ( smeansofdeath == "MOD_MELEE" )
                {
                    poisedamage = int( poisedamage * var_a64759de317cc7f );
                    willknockdown = 1;
                }
            }
        }
    }
    
    if ( idamage >= 150 && isdefined( smeansofdeath ) && smeansofdeath == "MOD_MELEE" )
    {
        var_66fc061070bf9657 = getdvarint( @"hash_6138625068b37f1", 0 );
        rewardbackstab = getdvarint( @"hash_65b74a71a96e27ea", 0 );
        
        if ( var_66fc061070bf9657 == 1 )
        {
            idamage = 135;
            newdamage = getdvarint( @"hash_fd334bd8d3ee773", 0 );
            
            if ( newdamage > 0 )
            {
                idamage = newdamage;
            }
            
            if ( rewardbackstab && isbehindmeleevictim( eattacker, victim ) )
            {
                idamage = 150;
            }
            
            if ( utility::issharedfuncdefined( #"perk_cqc", #"perk_apply_effect" ) && isdefined( victim.perks[ "specialty_close_quarter" ] ) )
            {
                idamage = [[ utility::getsharedfunc( #"perk_cqc", #"perk_apply_effect" ) ]]( idamage, victim, eattacker, 0 );
            }
        }
    }
    
    if ( idflags & 4294967296 || victim.var_44ed6e22cb50e4b )
    {
        if ( idamage >= victim.health && victim.health > 0 )
        {
            idamage = victim.health - 1;
        }
    }
    
    if ( idamage > 0 && isplayer( victim ) )
    {
        victim mtx_weapon::function_8e324d558c3fbc01();
    }
    
    if ( isplayer( victim ) && isnumber( victim.deathshieldthreshold ) )
    {
        diff = victim.health - idamage - victim.deathshieldthreshold;
        
        if ( diff < 0 )
        {
            idamage += diff;
        }
    }
    
    if ( isplayer( victim ) && victim.var_41e03581d6136136 )
    {
        if ( utility::issharedfuncdefined( #"super_survival_life_drain", #"hash_e2b8202b1b5db7b0" ) )
        {
            [[ utility::getsharedfunc( #"super_survival_life_drain", #"hash_e2b8202b1b5db7b0" ) ]]( { #victim:victim, #idamage:idamage } );
        }
        
        return;
    }
    
    preplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdamagedir, shitloc, psoffsettime, modelindex, partname, lightarmordamage, weapongroup );
    victim finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdamagedir, shitloc, psoffsettime, modelindex, partname, 1, lightarmordamage, heavyarmordamage, undefined, poisedamage, willknockdown );
    postplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdamagedir, shitloc, psoffsettime, modelindex, partname, lightarmordamage, heavyarmordamage, var_ca02bfdd611a56f4, iskillstreakweapon, willknockdown, weapongroup );
}

// Namespace damage
// Params 3
// Checksum 0xd3627fc1, Offset: 0x5599
// Size: 0x93
function function_c8187a18dfbd8beb( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 )
{
    if ( isdefined( eattacker ) )
    {
        typehit = "standard";
        waskilled = 1;
        headshot = 0;
        hitmarkertype = "standardspread";
        suppressaudio = 0;
        var_4514dcf3d65e7af0 = 0;
        armorPlateCount = 0;
        eattacker damagefeedback::updatedamagefeedback( typehit, waskilled, headshot, hitmarkertype, suppressaudio, undefined, undefined, armorPlateCount, {}, undefined, var_4514dcf3d65e7af0 );
    }
}

// Namespace damage
// Params 3
// Checksum 0xa7944174, Offset: 0x5635
// Size: 0xfc
function dragonsbreathhitloccollection( hitloc, eattacker, objweapon )
{
    self notify( #"hash_f78dc608d52d98dc" );
    self endon( #"hash_f78dc608d52d98dc" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.dragonsbreathdamage ) )
    {
        self.dragonsbreathdamage = dragonsbreath::function_9829423140f8ffeb();
    }
    
    self.dragonsbreathdamage.newhitlocs[ self.dragonsbreathdamage.newhitlocs.size ] = hitloc;
    waittillframeend();
    newhitlocs = [];
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.dragonsbreathdamage ) )
    {
        newhitlocs = self.dragonsbreathdamage.newhitlocs;
        self.dragonsbreathdamage.newhitlocs = [];
    }
    
    if ( player::isreallyalive( self ) )
    {
        dragonsbreath::function_6e45d22ffdfaeade( newhitlocs, eattacker, objweapon );
        return;
    }
    
    dragonsbreath::function_9db00fb5b6541561( objweapon );
}

// Namespace damage
// Params 15
// Checksum 0xcb180111, Offset: 0x5739
// Size: 0x403
function preplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage, weapongroup )
{
    if ( issimulationplayer( victim ) )
    {
        return;
    }
    
    originaldamage = idamage;
    victim.lastweaponused = victim getcurrentweapon();
    victim.wasaimingdownsightsondamage = victim player::isplayerads();
    
    if ( isai( self ) )
    {
        bots::bot_damage_callback( eattacker, idamage, smeansofdeath, objweapon, einflictor, shitloc, vpoint, lightarmordamage, idflags );
    }
    
    if ( isdefined( einflictor.streakinfo.hits ) )
    {
        einflictor.streakinfo.hits++;
    }
    
    if ( isdefined( objweapon ) && objweapon.basenamehash == %"bunkerbuster_round_mp" )
    {
        if ( isdefined( einflictor ) && isdefined( victim ) )
        {
            var_cd5ce389a1eb292d = distance( einflictor.origin, victim.origin );
            eattacker dlog_recordplayerevent( "dlog_event_mp_bunkerbuster_expl_dist_to_enemy", [ "victim", victim, "distance", var_cd5ce389a1eb292d ], 0 );
        }
    }
    
    perkfunctions::bulletoutlinecheck( eattacker, victim, objweapon, smeansofdeath );
    
    if ( smeansofdeath == "MOD_FALLING" )
    {
        victim thread emitfalldamage( idamage );
    }
    
    victim.lastattacker = eattacker;
    logattacker( victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup );
    
    if ( isdefined( einflictor.owner.team ) && einflictor.owner.team != victim.team )
    {
        victim.lastdamagewasfromenemy = 1;
    }
    else
    {
        victim.lastdamagewasfromenemy = isdefined( eattacker ) && eattacker != victim;
    }
    
    if ( isdefined( eattacker ) && victim.lastdamagewasfromenemy )
    {
        timestamp = gettime();
        
        if ( isdefined( eattacker ) )
        {
            eattacker.damagedplayers[ victim.guid ] = timestamp;
            eattacker.var_ee1eedef79be45b2 = timestamp;
            eattacker.var_b5e80d29bd4f9dcc = victim;
            
            if ( !isai( victim ) )
            {
                eattacker.var_de1ea76836aa6925 = timestamp;
            }
            
            if ( !isai( eattacker ) )
            {
                victim.var_18d5e672482ea280 = timestamp;
            }
        }
        
        victim.lastdamagedtime = timestamp;
        
        if ( isdefined( level.scoreeventglobals.var_9be8154810a6d28b ) && function_384f9e35c17e5080( level.scoreeventglobals.var_9be8154810a6d28b, eattacker, victim ) )
        {
            victim.offscreenattackers[ eattacker.guid ?? eattacker getentitynumber() ] = timestamp;
        }
    }
    
    var_b51dbb6028f6a1e3 = 0;
    
    if ( isdefined( victim ) && isdefined( victim.currentprimaryweapon ) )
    {
        var_b51dbb6028f6a1e3 = victim function_25af1328b3e8da54( victim.currentprimaryweapon, 0 );
    }
    
    victim.var_fd8aef3cf545952d = var_b51dbb6028f6a1e3;
    victim thread potg_events::onplayerdamaged( eattacker, victim, smeansofdeath );
    
    if ( isdefined( eattacker ) )
    {
        if ( idamage != 0 )
        {
            eattacker notify( #"victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime );
        }
        else
        {
            eattacker notify( #"hash_38a2ca5c5a840264", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime );
        }
    }
    
    if ( isdefined( level.preplayerdamaged ) )
    {
        victim thread [[ level.preplayerdamaged ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
    }
    
    assert( originaldamage == idamage, "<dev string:x87>" );
}

// Namespace damage
// Params 19
// Checksum 0x50aa5127, Offset: 0x5b44
// Size: 0x115c
function postplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage, heavyarmordamage, var_ca02bfdd611a56f4, iskillstreakweapon, willknockdown, weapongroup )
{
    /#
        originaldamage = idamage;
    #/
    
    bisbulletdamage = utility::isbulletdamage( smeansofdeath );
    healthdamage = var_ca02bfdd611a56f4 - victim.health;
    var_7f613f71e183715c = isplayer( eattacker );
    var_74c9a6788a02a9ef = isplayer( victim );
    
    if ( getdvarint( @"scr_track_attacker_origin", 0 ) == 1 && isdefined( eattacker.origin ) )
    {
        victim setattackerdistance( eattacker.origin );
    }
    
    if ( victim.battlerageactive )
    {
        victim callback::callback( #"battlerage_on_player_damaged" );
    }
    
    if ( victim.disguised && !victim.var_cbd4681f351fbad2 )
    {
        victim disguise_controller::function_e55cff6322653311( idamage );
    }
    
    weapon_utility::function_f3a4302a5efe0ef2( eattacker, victim, objweapon, partname );
    
    if ( smeansofdeath == "MOD_MELEE" && idamage > 10 && var_74c9a6788a02a9ef && isplayer( einflictor ) && !victim utility::isusingremote() )
    {
        if ( !isbrgamemode() && isalive( victim ) && !victim killstreak::isjuggernaut() )
        {
            victim thread meleestagger( eattacker );
            victim.hitwithmeleetime = gettime();
        }
        
        if ( idflags & 33554432 )
        {
            position = vpoint;
        }
        
        mtx_weapon::function_49a6fc7df1c44a33( einflictor, victim, objweapon );
        einflictor thread shellshock::bloodmeleeeffect( objweapon, position );
        victim playrumbleonentity( "defaultweapon_melee" );
        einflictor playrumbleonentity( "defaultweapon_melee" );
    }
    
    if ( smeansofdeath == "MOD_MELEE" && isagent( eattacker ) && eattacker != self )
    {
        utility::callsharedfunc( #"agent", #"hash_5c07427bf67d5871", eattacker, victim );
    }
    
    if ( objweapon.var_5e3a1c87edc1edd5 == #"railgun" )
    {
        victim thread railgunstagger( eattacker );
        victim playrumbleonentity( "defaultweapon_melee" );
    }
    
    if ( isagent( self ) )
    {
        if ( killstreak::iscontrollingproxyagent() )
        {
            if ( idamage >= self.health )
            {
                idamage = self.health - 1;
            }
            else
            {
                var_bda53394c108f2e = getcompleteweaponname( objweapon );
                self [[ agent_utility::agentfunc( "on_damaged_finished" ) ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, var_bda53394c108f2e, vpoint, vdir, shitloc, psoffsettime );
            }
        }
        else
        {
            var_bda53394c108f2e = getcompleteweaponname( objweapon );
            self [[ agent_utility::agentfunc( "on_damaged_finished" ) ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, var_bda53394c108f2e, vpoint, vdir, shitloc, psoffsettime );
        }
    }
    else
    {
        thread challenges::function_16334bed0602c028( self, idamage, lightarmordamage, eattacker, objweapon );
    }
    
    handledamagefeedback( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon, willknockdown, partname, vpoint );
    
    if ( getdvarint( @"hash_c171156c4fe8b9fc", 0 ) == 0 )
    {
        handledamageeffects( idamage, einflictor, eattacker, victim, smeansofdeath, vpoint, lightarmordamage, objweapon );
    }
    
    if ( bisbulletdamage )
    {
        victim thread battlechatter_mp::adddamagetaken( eattacker, objweapon, idamage, weapongroup );
    }
    
    if ( isagent( eattacker ) && eattacker player::isreallyalive() && eattacker != victim )
    {
        victim thread battlechatter_mp::addrecentattacker( eattacker );
    }
    
    if ( isdefined( victim ) && victim player::isreallyalive() )
    {
        if ( isbrgamemode() && victim != eattacker && ( lightarmordamage > 0 || heavyarmordamage > 0 ) && victim.armorhealth == 0 )
        {
            level thread battlechatter_mp::trysaylocalsound( eattacker, #"bc_combat_action_armor_break" );
        }
        
        if ( victim.health < 30 )
        {
            victim thread battlechatter_mp::hurtbadlywait();
        }
        
        if ( !level.var_ca1a245e2065ebbd && isdefined( eattacker ) && eattacker != victim && isexplosivedamagemod( smeansofdeath ) )
        {
            issafecracker = objweapon.basenamehash == %"safe_c4_mp";
            isgas = objweapon.basenamehash == %"gas_mp";
            
            if ( !isdefined( objweapon ) || !isgas && !issafecracker )
            {
                level thread battlechatter_mp::trysaylocalsound( victim, #"bc_flavor_player_surprise", 0.5 );
            }
        }
    }
    
    gamelogic_mp::sethasdonecombat( victim, 1 );
    
    if ( isdefined( eattacker ) && eattacker != victim )
    {
        level.usestartspawns = 0;
    }
    
    if ( var_7f613f71e183715c )
    {
        gamelogic_mp::sethasdonecombat( eattacker, 1 );
        
        if ( isdefined( eattacker.pers[ "participation" ] ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
            {
                if ( isdefined( eattacker.leaderboarddata[ "participation" ] ) )
                {
                    eattacker.leaderboarddata[ "participation" ] = eattacker.leaderboarddata[ "participation" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "participation" ] ) )
                {
                    [[ level.leaderboardfunc[ "participation" ] ]]( eattacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( eattacker.pers[ "participation" ] ) )
                {
                    eattacker.pers[ "participation" ] = eattacker.pers[ "participation" ] + 1;
                }
            }
        }
        else
        {
            eattacker.pers[ "participation" ] = 1;
        }
    }
    
    /#
        weapon_utility::function_926700ffa3fbe9e( idamage, eattacker, victim, smeansofdeath, shitloc, einflictor, vpoint, lightarmordamage, heavyarmordamage );
    #/
    
    if ( isdefined( level.cinematic_replay_recording ) && isplayer( einflictor ) )
    {
        recordstruct = spawnstruct();
        recordstruct.victim = victim;
        recordstruct.vpoint = vpoint;
        recordstruct.vdir = vdir;
        recordstruct.objweapon = objweapon;
        recordstruct.kill = !isalive( victim );
        einflictor.hitrecord[ einflictor.hitrecord.size ] = recordstruct;
    }
    
    if ( isdefined( level.matchrecording_logeventmsg ) && var_74c9a6788a02a9ef && isplayer( einflictor ) && bisbulletdamage )
    {
        if ( var_ca02bfdd611a56f4 == victim.maxhealth && victim.health != self.maxhealth )
        {
            victim.engagementstarttime = gettime();
        }
    }
    
    if ( isdefined( eattacker ) && idamage > 0 )
    {
        if ( isdefined( eattacker.perks[ "specialty_delayhealing" ] ) )
        {
            eattacker thread perk_mark_targets::marktarget_run( victim, objweapon, smeansofdeath );
        }
        
        if ( isshrapnelsource( objweapon, smeansofdeath ) && player::isreallyalive( victim ) && eattacker != victim )
        {
            if ( isdefined( eattacker.var_b06fceab0526c3b1 ) && !isdefined( victim.perks[ "specialty_explosive_regen_delay_immunity" ] ) )
            {
                regendelayms = eattacker.var_b06fceab0526c3b1 * 1000;
                targetdelayms = level.healthregendelayms + regendelayms;
                delaymod = 1 - targetdelayms / level.healthregendelayms;
                var_402616d92bbd746c = eattacker.var_937517417ea57909;
                
                if ( victim playerhealth::function_fd91e6d94cab77e7( #"explosive_delay_perk", delaymod, targetdelayms ) && isdefined( var_402616d92bbd746c ) )
                {
                    victim thread [[ var_402616d92bbd746c ]]();
                }
            }
            
            if ( eattacker.explosiveregenhalt && !isdefined( victim.perks[ "specialty_explosive_regen_halt_immunity" ] ) )
            {
                eattacker thread perkfunctions::explosiveregenhalt_activate( victim );
            }
            
            if ( eattacker.var_befce6213f4de60e && !isdefined( victim.perks[ "specialty_explosive_slow_immunity" ] ) )
            {
                if ( utility::getsharedfunc( #"hash_59072086fe6f0fdd", #"hash_d9e9a01b83d5611e" ) )
                {
                    eattacker thread [[ utility::getsharedfunc( #"hash_59072086fe6f0fdd", #"hash_d9e9a01b83d5611e" ) ]]( victim );
                }
            }
        }
        
        if ( bisbulletdamage || objweapon.basenamehash == %"throwstar_mp" )
        {
            if ( function_6ddd57254184be0f( objweapon, eattacker ) && damage_utility::islowerbodyshot( shitloc, smeansofdeath, eattacker ) && !isdefined( victim.perks[ "specialty_dauntless" ] ) )
            {
                eattacker thread perkfunctions::ammodisabling_run( victim, objweapon.basenamehash == %"throwstar_mp" );
            }
            
            if ( vdir && eattacker shouldmeleeslow( vdir, victim ) )
            {
                eattacker thread function_45da7ca374194f4b( victim );
            }
        }
        
        if ( var_74c9a6788a02a9ef )
        {
            if ( weapon::isstimpistolweapon( objweapon ) && utility::isbulletdamage( smeansofdeath ) || isdefined( eattacker.perks[ "specialty_shrapnel" ] ) && isshrapnelsource( objweapon, smeansofdeath ) )
            {
                victim.lastshrapneltime = gettime();
            }
        }
    }
    
    if ( isdefined( level.onplayerdamaged ) )
    {
        victim thread [[ level.onplayerdamaged ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage );
    }
    
    level notify( #"post_player_damaged", einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
    
    if ( eattacker.var_c36269996253c559.var_4e0caacb60f9e217 && eattacker.var_c36269996253c559.var_11a45d4b82e41038 && victim [[ eattacker.var_c36269996253c559.var_4e0caacb60f9e217 ]]( objweapon, eattacker, smeansofdeath ) )
    {
        victim thread [[ eattacker.var_c36269996253c559.var_11a45d4b82e41038 ]]( eattacker );
    }
    
    wallbang = var_7f613f71e183715c && isdefined( idflags ) && idflags & 8 && !( idflags & 16384 );
    
    if ( wallbang )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
        {
            if ( isdefined( eattacker.leaderboarddata[ "wallbangsdamage" ] ) )
            {
                eattacker.leaderboarddata[ "wallbangsdamage" ] = eattacker.leaderboarddata[ "wallbangsdamage" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "wallbangsdamage" ] ) )
            {
                [[ level.leaderboardfunc[ "wallbangsdamage" ] ]]( eattacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
            
            if ( isdefined( eattacker.pers[ "wallbangsdamage" ] ) )
            {
                eattacker.pers[ "wallbangsdamage" ] = eattacker.pers[ "wallbangsdamage" ] + 1;
            }
        }
    }
    
    if ( player::isreallyalive( victim ) )
    {
        switch ( smeansofdeath )
        {
            case #"hash_3c20f39c73a1422b":
            case #"hash_571e46e17a3cf2e3":
            case #"hash_66cb246f3e55fbe2":
            case #"hash_a911a1880d996edb":
            case #"hash_c22b13f81bed11f0":
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                {
                    if ( isdefined( victim.leaderboarddata[ "explosionsSurvived" ] ) )
                    {
                        victim.leaderboarddata[ "explosionsSurvived" ] = victim.leaderboarddata[ "explosionsSurvived" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "explosionsSurvived" ] ) )
                    {
                        [[ level.leaderboardfunc[ "explosionsSurvived" ] ]]( victim, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                    
                    if ( isdefined( victim.pers[ "explosionsSurvived" ] ) )
                    {
                        victim.pers[ "explosionsSurvived" ] = victim.pers[ "explosionsSurvived" ] + 1;
                    }
                }
                
                if ( getdvarint( @"scr_live_ragdoll_on_explosives", 0 ) == 1 )
                {
                    if ( isdefined( einflictor ) )
                    {
                        testarray = function_c2bbdc31acb90186( einflictor, objweapon );
                        
                        if ( testarray[ 0 ] )
                        {
                            victim thread function_a48c25ff5c1fa9ba( testarray.size );
                        }
                    }
                }
                
                break;
        }
    }
    else
    {
        if ( isdefined( victim ) && isdefined( einflictor.vehicleent ) && einflictor.var_5e3a1c87edc1edd5 == #"bunkerbuster" )
        {
            victim function_54eff3fa1cad1199( einflictor.vehicleent );
        }
        
        if ( wallbang )
        {
            if ( eattacker game_utility_mp::onlinestatsenabled() )
            {
                wallbangs = eattacker playerstats_interface::getplayerstat( "combatStats", "wallbangs" ) + 1;
                eattacker playerstats_interface::setplayerstatbuffered( wallbangs, "combatStats", "wallbangs" );
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
            {
                if ( isdefined( eattacker.leaderboarddata[ "penetrationKills" ] ) )
                {
                    eattacker.leaderboarddata[ "penetrationKills" ] = eattacker.leaderboarddata[ "penetrationKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "penetrationKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "penetrationKills" ] ]]( eattacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( eattacker.pers[ "penetrationKills" ] ) )
                {
                    eattacker.pers[ "penetrationKills" ] = eattacker.pers[ "penetrationKills" ] + 1;
                }
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
            {
                if ( isdefined( eattacker.leaderboarddata[ "wallbangs" ] ) )
                {
                    eattacker.leaderboarddata[ "wallbangs" ] = eattacker.leaderboarddata[ "wallbangs" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "wallbangs" ] ) )
                {
                    [[ level.leaderboardfunc[ "wallbangs" ] ]]( eattacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( eattacker.pers[ "wallbangs" ] ) )
                {
                    eattacker.pers[ "wallbangs" ] = eattacker.pers[ "wallbangs" ] + 1;
                }
            }
        }
        
        if ( hasomnvar( "ui_ricochet_logo_obituary" ) )
        {
            var_e484e1ec0f2fb9b8 = eattacker == victim;
            isinvehicle = victim vehicle::is_in_vehicle( 1 ) || isdefined( victim.lastvehicle.vehiclename );
            var_66855ce9d51e0a5 = smeansofdeath == "MOD_FALLING" && victim function_1876fb7a26caba85( 8519680 );
            var_88c05502bfa5be12 = isinvehicle && smeansofdeath == "MOD_EXPLOSIVE" && victim function_1876fb7a26caba85( 50331648 );
            
            if ( var_e484e1ec0f2fb9b8 && ( var_66855ce9d51e0a5 || var_88c05502bfa5be12 ) )
            {
                victimclientnum = victim getentitynumber();
                setomnvar( "ui_ricochet_logo_obituary", victimclientnum );
            }
            else if ( getomnvar( "ui_firing_range_target_kill_count" ) != -1 )
            {
                setomnvar( "ui_ricochet_logo_obituary", -1 );
            }
        }
    }
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagTrackPlayerBulletHitPlayer" ) )
    {
        namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagTrackPlayerBulletHitPlayer", eattacker );
    }
    
    /#
        if ( originaldamage != idamage )
        {
            assertmsg( "<dev string:x107>" );
        }
    #/
    
    sparams = { #bisbulletdamage:bisbulletdamage, #healthdamage:healthdamage, #heavyarmordamage:heavyarmordamage, #lightarmordamage:lightarmordamage, #partname:partname, #shitloc:shitloc, #vdir:vdir, #vpoint:vpoint, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #einflictor:einflictor, #eattacker:eattacker, #victim:victim };
    
    if ( isdefined( eattacker ) )
    {
        eattacker callback::callback( "player_dealt_damage", sparams );
    }
    
    if ( self )
    {
        callback::callback( #"player_damaged", sparams );
    }
    
    if ( isplayer( eattacker ) && isdefined( einflictor ) && ( isdefined( einflictor.equipmentref ) || einflictor.isequipment ) )
    {
        loggrenadedata( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon );
        callbackparams = { #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idamage:idamage, #victim:victim, #eattacker:eattacker, #einflictor:einflictor };
        callback::callback( #"hash_6fbac24ba0a39999", callbackparams );
    }
}

// Namespace damage
// Params 2
// Checksum 0x6eea211, Offset: 0x6ca8
// Size: 0x3d, Type: bool
function function_6ddd57254184be0f( objweapon, eattacker )
{
    if ( objweapon hasattachment( "ammomod_slow" ) || isdefined( eattacker.perks[ "specialty_wounding" ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 2, eflags: 0x4
// Checksum 0x49a43252, Offset: 0x6cee
// Size: 0x11c
function private function_c2bbdc31acb90186( einflictor, objweapon )
{
    if ( isdefined( einflictor.equipmentref ) )
    {
        equipmentinfo = equipment_mp::getequipmenttableinfo( einflictor.equipmentref );
        
        if ( isdefined( equipmentinfo ) && equipmentinfo.defaultslot == "primary" )
        {
            return [ 1 ];
        }
    }
    
    if ( isdefined( objweapon ) )
    {
        if ( weapon::iskillstreakweapon( objweapon ) )
        {
            return [ 1, 1 ];
        }
        
        switch ( objweapon.basenamehash )
        {
            case %"iw8_la_kgolf_mp":
            case %"iw8_la_gromeo_mp":
            case %"iw8_la_juliet_mp":
            case %"iw9_la_gromeo_mp":
            case %"iw8_la_gromeoks_mp":
            case %"t10_la_p18_stisaac_mp":
            case %"iw8_la_rpapa7_mp":
            case %"t10_la_p17_pable3_mp":
            case %"iw9_la_juliet_mp":
            case %"t10_ks_m202":
                return [ 1 ];
        }
    }
    
    return [ 0 ];
}

// Namespace damage
// Params 3, eflags: 0x4
// Checksum 0x45466f07, Offset: 0x6e13
// Size: 0x7a
function private function_a48c25ff5c1fa9ba( knockdownintensity, isvehiclehit, velocity )
{
    self endon( #"death_or_disconnect" );
    
    if ( !self.perkthirdperson )
    {
        self setcamerathirdperson( 1 );
    }
    
    if ( isvehiclehit )
    {
        self function_1d5453a0507b54e1( "torso_upper", velocity );
        wait 3;
    }
    else
    {
        self startliveragdoll();
        wait knockdownintensity == 2 ? 5 : 3;
    }
    
    class::setthirdpersonview();
    self stopliveragdoll();
}

// Namespace damage
// Params 2
// Checksum 0xe8caab55, Offset: 0x6e95
// Size: 0x90
function meleestagger_anglesviewattack( victim, attacker )
{
    vdir = anglestoforward( ( 0, victim getplayerangles()[ 1 ], 0 ) );
    vattack = vectornormalize( ( attacker.origin[ 0 ], attacker.origin[ 1 ], 0 ) - ( victim.origin[ 0 ], victim.origin[ 1 ], 0 ) );
    return math::anglebetweenvectorssigned( vdir, vattack, ( 0, 0, 1 ) );
}

// Namespace damage
// Params 2
// Checksum 0x4de9659b, Offset: 0x6f2e
// Size: 0x84, Type: bool
function isshrapnelsource( objweapon, meansofdeath )
{
    if ( !isdefined( objweapon ) || isnullweapon( objweapon ) )
    {
        return false;
    }
    
    if ( !isexplosivedamagemod( meansofdeath ) )
    {
        return false;
    }
    
    if ( weapon::iskillstreakweapon( objweapon ) )
    {
        return false;
    }
    
    if ( vehicle::isvehicleweapon( objweapon ) )
    {
        return false;
    }
    
    if ( weapon::isgamemodeweapon( objweapon ) )
    {
        return false;
    }
    
    equipmenttype = weapon::getequipmenttype( objweapon );
    
    if ( isdefined( equipmenttype ) )
    {
        if ( equipmenttype != "lethal" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace damage
// Params 1
// Checksum 0x78274020, Offset: 0x6fbb
// Size: 0x21
function railgunstagger( attacker )
{
    self endon( #"death_or_disconnect" );
    thread function_e06c3968defb7867( attacker );
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0xbb032457, Offset: 0x6fe4
// Size: 0x98
function private function_e06c3968defb7867( attacker )
{
    self endon( #"damage" );
    pitchdegrees = -4;
    pitchscale = getdvarfloat( @"hash_679a444357928abb", 0.5 );
    
    if ( killstreak::function_2512509a946854ce() )
    {
        pitchscale *= 0.4;
    }
    
    self setplayerangles( self getplayerangles() + ( pitchdegrees * pitchscale, 0, 0 ) );
    self earthquakeforplayer( 0.35, 0.2, self.origin, 400 );
    self playrumbleonpositionforclient( "plr_rumble_4_mp", self.origin );
}

// Namespace damage
// Params 1
// Checksum 0x2fcac624, Offset: 0x7084
// Size: 0x26e
function meleestagger( attacker )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level.meleestaggershockduration ) )
    {
        level.meleestaggershockduration = getdvarfloat( @"melee_stagger_shock_duration", 0.2 );
    }
    
    if ( !isdefined( level.var_9b21fcbd86699795 ) )
    {
        level.var_9b21fcbd86699795 = getdvarfloat( @"melee_stagger_aftershock_duration", 0.2 );
    }
    
    var_406b6dd86201cc2c = self getviewkickscale();
    
    if ( isdefined( level.gamemodeoverridemeleeviewkickscale ) )
    {
        self setviewkickscale( isdefined( attacker.perks[ "specialty_hardmelee" ] ) ? level.gamemodeoverridemeleeviewkickscale * 2 : level.gamemodeoverridemeleeviewkickscale );
    }
    else
    {
        self setviewkickscale( isdefined( attacker.perks[ "specialty_hardmelee" ] ) ? 3 : 1.5 );
    }
    
    if ( level.meleestaggershockduration > 0 )
    {
        duration = isdefined( attacker.perks[ "specialty_hardmelee" ] ) ? level.meleestaggershockduration * 1.5 : level.meleestaggershockduration;
        shellshock_utility_cpmp::_shellshock( %"melee_mp", #"damage", duration, 0, 0 );
    }
    
    yaw = 0;
    
    if ( isdefined( attacker ) && attacker player::isreallyalive() )
    {
        angle = meleestagger_anglesviewattack( self, attacker );
        
        if ( angle < 15 )
        {
            yaw = 10;
        }
        else if ( angle > -15 )
        {
            yaw = -10;
        }
    }
    
    pitchscale = isdefined( attacker.perks[ "specialty_hardmelee" ] ) ? 1.5 : 1;
    self setplayerangles( self getplayerangles() + ( -8 * pitchscale, yaw, 0 ) );
    thread meleedofroutine( attacker );
    self earthquakeforplayer( 0.35, 0.2, self.origin, 400 );
    self playrumbleonpositionforclient( "plr_rumble_4_mp", self.origin );
    self setviewkickscale( var_406b6dd86201cc2c );
    
    if ( level.var_9b21fcbd86699795 > 0 )
    {
        duration = isdefined( attacker.perks[ "specialty_hardmelee" ] ) ? level.var_9b21fcbd86699795 * 1.5 : level.var_9b21fcbd86699795;
        shellshock_utility_cpmp::_shellshock( %"melee_mp_after", #"damage", duration, 0, 0 );
    }
}

// Namespace damage
// Params 1
// Checksum 0x1076e754, Offset: 0x72fa
// Size: 0x73
function meleedofroutine( attacker )
{
    self notify( #"hash_69a67e5c93cb98b9" );
    self endon( #"hash_69a67e5c93cb98b9" );
    self endon( #"death_or_disconnect" );
    var_d3d92f7ab4915019 = isdefined( attacker.perks[ "specialty_hardmelee" ] ) ? level.meleestaggershockduration * 3 : level.meleestaggershockduration;
    wait var_d3d92f7ab4915019;
    player::setdof_default();
}

// Namespace damage
// Params 1
// Checksum 0x6b2305cf, Offset: 0x7375
// Size: 0x24
function monitormeleeoverlay( overlay )
{
    utility::waittill_any_timeout( 2, "death_or_disconnect" );
    overlay destroy();
}

// Namespace damage
// Params 7
// Checksum 0xc040e68e, Offset: 0x73a1
// Size: 0xbd, Type: bool
function weaponignoresbrarmor( attacker, victim, damage, objweapon, smeansofdeath, inflictor, shitloc )
{
    if ( isdefined( objweapon.basenamehash ) && ( objweapon.basenamehash == %"danger_circle_br" || objweapon.basenamehash == %"shock_thunder_mp_br" ) )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        return true;
    }
    
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_BUMP" )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 1
// Checksum 0xb3c4b7f9, Offset: 0x7467
// Size: 0x35, Type: bool
function function_b8d8959a0b118c87( weapon )
{
    weapobj = utility::function_64003742d8f5c781( weapon );
    return weapobj.basenamehash == %"danger_circle_br";
}

// Namespace damage
// Params 15
// Checksum 0x571758d5, Offset: 0x74a5
// Size: 0xa63
function cac_modified_damage( victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query, idflags, iskillstreakweapon, headshotmultiplier, ignorelightarmor, weapongroup )
{
    assert( isplayer( victim ) || isagent( victim ) );
    assert( issimulationplayer( victim ) || isdefined( victim.team ) );
    victim notify( #"damage_begin", attacker );
    
    if ( !isdefined( weapongroup ) )
    {
        weapongroup = weapon::getweapongroup( objweapon );
    }
    
    if ( !isdefined( headshotmultiplier ) )
    {
        headshotmultiplier = 1;
    }
    
    damageadd = 0;
    heavyarmordamage = 0;
    var_7c3f909210c03e9e = victim armor::hasarmor();
    var_d5326b8a16c5a7b2 = victim armor::hashelmet();
    
    if ( isplayer( attacker ) )
    {
        helmet_clearhit( attacker );
        helmet_clearbroke( attacker );
    }
    
    if ( utility::isbulletdamage( smeansofdeath ) )
    {
        weaponbasename = objweapon.basename;
        validshot = damage_utility::validshotcheck( smeansofdeath, attacker );
        headshot = damage_utility::isheadshot( shitloc, smeansofdeath, attacker, validshot );
        torsoshot = damage_utility::istorsoshot( shitloc, smeansofdeath, attacker, validshot );
        
        if ( isdefined( objweapon ) && weapon::iscacprimaryorsecondary( weaponbasename, weapongroup ) )
        {
            if ( isbehindmeleevictim( attacker, victim ) && isplayer( victim ) )
            {
                level thread battlechatter_mp::saytoself( victim, "plr_hit_back", undefined, 0.1 );
            }
        }
        
        if ( isdefined( idflags ) && idflags & 256 )
        {
            if ( weaponbasename != "none" && !weapon::issuperweapon( weaponbasename ) )
            {
                damage *= 0.4;
            }
        }
        
        if ( isplayer( attacker ) && isdefined( attacker.perks[ "specialty_paint_pro" ] ) && !iskillstreakweapon )
        {
            victim thread perkfunctions::setpainted( attacker );
        }
        
        if ( isbrgamemode() && weapon::isminigunweapon( objweapon ) )
        {
            damage *= br_jugg_common::getminigundamagescale();
        }
        
        hitarmorvest = torsoshot && isdefined( victim.perks[ "specialty_armorvest" ] );
        var_ab76a035496d6d7a = headshot && var_d5326b8a16c5a7b2;
        hithelmet = headshot && victim.hasheadgear;
        var_adf16a2992a75413 = attacker.lastcrossbowhadstoppingpower && weapon::getweaponrootname( objweapon ) == "iw9_dm_crossbow";
        var_6e0c9eae5969ad41 = isdefined( attacker.perks[ "specialty_underkill" ] ) && weaponclass( objweapon ) == "pistol";
        awardstoppingpower = isdefined( attacker.perks[ "specialty_bulletdamage" ] ) || var_adf16a2992a75413 || var_6e0c9eae5969ad41;
        armorpiercing = isfmjdamage( objweapon, smeansofdeath );
        
        if ( var_ab76a035496d6d7a && !victim.inlaststand )
        {
            attackerweaponclass = weaponclass( objweapon );
            snipershot = 0;
            
            if ( attackerweaponclass == "sniper" || attackerweaponclass == "dmr" )
            {
                snipershot = 1;
            }
            
            var_9cb03e33b979be7f = victim armor::damagehelmet( damage, snipershot, impactdir );
            damage *= var_9cb03e33b979be7f;
        }
        
        if ( awardstoppingpower && hitarmorvest )
        {
            armor::armorvest_sethit( attacker );
        }
        else if ( awardstoppingpower && damage > 0 )
        {
            if ( damage <= 0 )
            {
                assertmsg( "<dev string:x162>" );
            }
            else
            {
                damagenew = applystoppingpower( objweapon, shitloc, smeansofdeath, attacker, damage, 100 );
                damageadd += damagenew - damage;
            }
        }
        else if ( hitarmorvest && !victim.tookvesthit && !armorpiercing )
        {
            victim.tookvesthit = 1;
            damagenew = adjustbulletstokill( damage, 100, level.armorvestbulletdelta );
            damageadd += damagenew - damage;
            helmet_sethit( attacker );
        }
        else if ( hithelmet && !armorpiercing )
        {
            damagemod = headgear::getdamagemod();
            maxdamage = headgear::getmaxdamage();
            damagehelmet = int( clamp( damage * damagemod, 1, maxdamage ) );
            
            if ( victim.health > 1 )
            {
                damagehelmet = int( min( victim.health - 1, damagehelmet ) );
            }
            
            var_557912290102a12c = damage - damagehelmet;
            damageadd -= var_557912290102a12c;
            victim notify( #"headgear_save" );
            helmet_sethit( attacker );
        }
        
        if ( attacker.vehicleparent == "loot_chopper" )
        {
            damage = int( damage / 3 );
        }
        
        if ( victim.undying )
        {
            if ( damage >= victim.health )
            {
                victim.health = int( clamp( damage + 1, 1, victim.maxhealth ) );
            }
        }
        
        if ( headshot && isdefined( attacker.perks[ "specialty_headhunter" ] ) )
        {
            if ( headshotmultiplier <= 1 )
            {
                damage += 10;
            }
            else
            {
                disttovictim = distance( attacker.origin, victim.origin );
                
                if ( disttovictim < level.headhuntermaxrange )
                {
                    damage += 20 * headshotmultiplier;
                }
                else if ( disttovictim < level.headhuntermaxrange )
                {
                    damage += 15 * headshotmultiplier;
                }
                else
                {
                    damage += 10 * headshotmultiplier;
                }
            }
        }
    }
    else if ( smeansofdeath == "MOD_FALLING" )
    {
        if ( isdefined( self.perks[ "specialty_falldamage" ] ) )
        {
            damage = 0;
        }
        
        if ( isdefined( self.var_3bf56b2cb4cf6514 ) )
        {
            damage -= damage * self.var_3bf56b2cb4cf6514.bundle.var_c97737c628f19dc4;
        }
    }
    
    if ( objweapon.var_5e3a1c87edc1edd5 == #"trophy" )
    {
        if ( utility::issharedfuncdefined( #"trophy", #"modifydamage" ) )
        {
            modifydamageresults = [[ utility::getsharedfunc( #"trophy", #"modifydamage" ) ]]( attacker, victim, damage, damageadd );
            damage = modifydamageresults[ 0 ];
            damageadd = modifydamageresults[ 1 ];
        }
    }
    
    if ( victim heavyarmor::hasheavyarmor() )
    {
        modifydamageresults = heavyarmor::heavyarmormodifydamage( victim, attacker, damage, damageadd, smeansofdeath, objweapon.basename, impactpoint, impactdir, shitloc, inflictor, query );
        heavyarmordamage = modifydamageresults[ 0 ] > 0;
        damage = modifydamageresults[ 1 ];
        damageadd = modifydamageresults[ 2 ];
    }
    
    if ( lightarmor::haslightarmor( victim ) && !ignorelightarmor )
    {
        modifydamageresults = lightarmor::lightarmor_modifydamage( victim, attacker, damage, damageadd, smeansofdeath, objweapon.basename, impactpoint, impactdir, shitloc, inflictor, query );
        damage = modifydamageresults[ 1 ];
        damageadd = modifydamageresults[ 2 ];
    }
    
    if ( isplayer( attacker ) )
    {
        var_a09c3a2b7e984af9 = victim armor::hasarmor();
        var_db1ba6678c42504f = victim armor::hashelmet();
        
        if ( var_7c3f909210c03e9e && !var_a09c3a2b7e984af9 )
        {
            armor::armorvest_setbroke( attacker );
        }
        
        if ( var_d5326b8a16c5a7b2 && !var_db1ba6678c42504f )
        {
            helmet_setbroke( attacker );
        }
    }
    
    if ( hashealthshield( victim ) )
    {
        damage = victim gethealthshielddamage( damage );
    }
    
    fatalfalldamage = smeansofdeath == "MOD_FALLING" && damage >= victim.maxhealth;
    var_e146ddf81d1ba666 = inflictor.stuckto == victim || inflictor.stuckenemyentity == victim;
    
    if ( victim.inlaststand && !fatalfalldamage )
    {
        if ( var_e146ddf81d1ba666 && ( objweapon.basenamehash == %"semtex_mp" || objweapon.basenamehash == %"bunkerbuster_not_burrowed_mp" || objweapon.basenamehash == %"sticky_grenade_mp" ) )
        {
        }
        else
        {
            damage = int( ceil( damage * level.lastStandDamageTakenScalar ) );
        }
    }
    
    if ( damage <= 1 )
    {
        damage = int( ceil( clamp( damage, 0, 1 ) ) );
    }
    else
    {
        damage = int( damage + damageadd );
    }
    
    if ( victim killstreak::ismutantinjection() )
    {
        if ( isdefined( self.damagemanglercannon ) )
        {
            victim [[ self.damagemanglercannon ]]( damage, shitloc, smeansofdeath, attacker );
        }
        
        if ( damage >= self.health && isdefined( self.var_53fc5e1e26ae990f ) )
        {
            self thread [[ self.var_53fc5e1e26ae990f ]]( 0, 0 );
            damage = 0;
        }
    }
    
    if ( victim killstreak::isjuggernaut() )
    {
        if ( !isdefined( victim.juggernautmodifydamage ) || victim.juggernautmodifydamage )
        {
            damage = modify_juggernaut_damage( victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query, idflags, iskillstreakweapon );
        }
        else if ( victim.juggcontext.juggconfig.modifydamagefunc )
        {
            damage = victim [[ victim.juggcontext.juggconfig.modifydamagefunc ]]( attacker, victim, objweapon, inflictor, smeansofdeath, damage );
        }
        
        if ( damage >= self.health && self.var_e4dae87a649544c3 )
        {
            self.var_e4dae87a649544c3 = 0;
            damagedata = { #var_e4dae87a649544c3:1, #hitloc:shitloc, #isfauxdeath:0, #objweapon:objweapon, #meansofdeath:smeansofdeath, #inflictor:inflictor, #victim:victim, #attacker:attacker };
            thread juggernaut::jugg_removejuggernaut( damagedata );
            damage = 0;
        }
    }
    else if ( victim killstreak::function_27766a07ce1d112a() && utility::issharedfuncdefined( #"minijugg", #"modifydamage" ) )
    {
        damage = utility::callsharedfunc( #"minijugg", #"modifydamage", attacker, victim, damage, objweapon, smeansofdeath, inflictor );
    }
    
    return [ damage, heavyarmordamage, shitloc ];
}

// Namespace damage
// Params 2
// Checksum 0xc3a0b968, Offset: 0x7f11
// Size: 0xa8
function function_affb697eaeaf6938( damage, victim )
{
    var_31f8f12b7f730845 = int( min( victim.flakjackethealth, damage ) );
    victim.flakjackethealth -= var_31f8f12b7f730845;
    victim notify( #"blast_shield_damaged", victim.flakjackethealth );
    
    if ( victim.flakjackethealth <= 0 && isdefined( victim.var_fd5a6b40b5a293da ) )
    {
        victim [[ victim.var_fd5a6b40b5a293da ]]();
    }
    
    modifieddamage = damage - var_31f8f12b7f730845;
    return modifieddamage;
}

// Namespace damage
// Params 12
// Checksum 0x7cdcb348, Offset: 0x7fc2
// Size: 0x516
function modify_juggernaut_damage( victim, attacker, damage, smeansofdeath, objweapon, impactpoint, impactdir, shitloc, inflictor, query, idflags, iskillstreakweapon )
{
    attackerweaponclass = weaponclass( objweapon );
    damagescale = 1;
    
    if ( isdefined( attacker ) && attacker killstreak::isjuggernaut() && isbrgamemode() )
    {
        damagescale = br_jugg_common::getjuggdamagescale();
    }
    else if ( game_utility::function_ae97372c83da7acc() )
    {
        damagescale = 1.25;
    }
    
    if ( utility::isbulletdamage( smeansofdeath ) )
    {
        var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
        
        switch ( attackerweaponclass )
        {
            case #"hash_719417cb1de832b6":
            case #"hash_900cb96c552c5e8e":
                damage = min( 15, damage );
                break;
            case #"hash_8cdaf2e4ecfe5b51":
            case #"hash_fa24dff6bd60a12d":
                if ( weapon::isminigunweapon( objweapon ) )
                {
                    damage = min( 50, damage );
                }
                else
                {
                    damage = min( 20, damage );
                }
                
                break;
            case #"hash_690c0d6a821b42e":
                damage = min( 25, damage );
                break;
            case #"hash_6191aaef9f922f96":
                break;
            case #"hash_e224d0b635d0dadd":
                if ( var_ec636abdcf08f7b3 )
                {
                    damage = int( self.maxhealth * 0.05 );
                }
                
                break;
            default:
                damage = min( 15, damage );
                break;
        }
        
        damage = handleapdamage( objweapon, smeansofdeath, damage, attacker );
    }
    else if ( isexplosivedamagemod( smeansofdeath ) )
    {
        damage = function_8280f3321b0c7d40( damage, objweapon, attacker );
        var_7f8df2a190821e8f = level.streakglobals.streakbundles[ "juggernaut" ].var_13802df9020b7c46 ?? 1;
        damage = int( damage * var_7f8df2a190821e8f );
        var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
        
        switch ( objweapon.basenamehash )
        {
            case %"artillery_mp":
                damage *= 0.25;
                break;
            case %"auto_drone_proj_mp":
                damage *= 1.5;
                break;
            case %"sticky_grenade_mp":
            case %"semtex_mp":
                if ( istrue( var_ec636abdcf08f7b3 ) )
                {
                    damage = int( self.maxhealth * 0.1 );
                }
                
                break;
            case %"sat_semtex_wz":
                if ( istrue( var_ec636abdcf08f7b3 ) )
                {
                    damage = int( self.maxhealth * 0.2 );
                }
                
                break;
            case %"molotov_mp":
            case %"sat_molotov_mp":
                if ( var_ec636abdcf08f7b3 )
                {
                    damage = int( self.maxhealth * 0.011 );
                }
                
                break;
            case %"sat_thermite_wz":
                if ( var_ec636abdcf08f7b3 )
                {
                    damage = int( self.maxhealth * 0.011 );
                }
                
                break;
        }
    }
    else if ( utility::isfiredamage( smeansofdeath ) )
    {
        var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
        
        switch ( objweapon.basenamehash )
        {
            case %"thermite_ap_mp":
            case %"thermite_av_mp":
                if ( var_ec636abdcf08f7b3 )
                {
                    damage = int( self.maxhealth * 0.023 );
                }
                
                break;
        }
        
        damage = function_a8689e5a2448ca1( damage, objweapon, attacker, smeansofdeath );
    }
    else if ( utility::isimpactdamage( smeansofdeath ) )
    {
        switch ( attackerweaponclass )
        {
            case #"hash_e224d0b635d0dadd":
                damage = min( 10, damage );
                break;
            case #"hash_2ab98cab4066a74e":
                damage = min( 100, damage );
                break;
        }
    }
    else if ( utility::isvehiclecrushdamage( inflictor, smeansofdeath ) )
    {
        if ( !isdefined( victim.var_9a17b6833b49f11 ) )
        {
            victim.var_9a17b6833b49f11 = 0;
        }
        
        damage = min( 50, damage );
        victim.var_9a17b6833b49f11++;
        
        if ( victim.var_9a17b6833b49f11 >= 30 )
        {
            exit = vehicle_occupancy::function_7ce9972f31ab138b( victim, inflictor, victim.origin, 1 );
            
            if ( isdefined( exit.origin ) )
            {
                victim setorigin( exit.origin );
                victim.var_9a17b6833b49f11 = undefined;
            }
        }
    }
    
    damage = int( damage * damagescale );
    
    if ( isdefined( self.var_c6ec5306170d4f28 ) )
    {
        victim [[ self.var_c6ec5306170d4f28 ]]( damage, shitloc, smeansofdeath, attacker );
    }
    
    /#
        victim thread function_13044ae0f56c133b( attacker, damage, smeansofdeath, objweapon );
    #/
    
    return damage;
}

// Namespace damage
// Params 3
// Checksum 0x76998c39, Offset: 0x84e1
// Size: 0x1c2
function modifydestructibledamage( damage, inflictor, objweapon )
{
    if ( !isdefined( inflictor ) )
    {
        return damage;
    }
    
    if ( !isnullweapon( objweapon ) )
    {
        return damage;
    }
    
    if ( inflictor.code_classname != "scriptable" )
    {
        return damage;
    }
    
    classname = inflictor.classname;
    
    if ( isdefined( classname ) && isstartstr( classname, "scriptable_" ) )
    {
        classname = getsubstr( classname, 11, classname.size );
        classnames = [ "uk_gas_tank_thin_cylinder", "uk_misc_fuel_jug", "uk_fire_extinguisher", "uk_misc_fuel_jug", "decor_barrels_gameplay_flammable", "un_propane_gas_tank", "machinery_oxygen_generator_tank", "sol_barrel", "box_wooden_grenade", "container_gas_tank", "decor_propane_tank", "equipment_propane_burner_stove", "equipment_propane_tank", "misc_propane_rocket", "oil_drum", "rp_propane_tank", "misc_exterior_oxygen_barrel" ];
        
        foreach ( _classname in classnames )
        {
            if ( isstartstr( classname, _classname ) )
            {
                if ( classname != "decor_barrels_gameplay_flammable_zul" )
                {
                    if ( game_utility_mp::isanymlgmatch() )
                    {
                        return 0;
                    }
                    
                    return int( min( damage, 60 ) );
                }
            }
        }
    }
    
    return damage;
}

// Namespace damage
// Params 6
// Checksum 0x903c9b4b, Offset: 0x86ac
// Size: 0x9b, Type: bool
function iskilltradedamage( eattacker, victim, idamage, smeansofdeath, objweapon, var_2300d396e46c0fe7 )
{
    if ( isplayer( eattacker ) && ( !isalive( eattacker ) || player::function_1e7ee0fc7e70248( eattacker ) ) )
    {
        if ( var_2300d396e46c0fe7 && isspreadweapon( objweapon ) )
        {
            return true;
        }
        else if ( idamage >= victim.health )
        {
            if ( smeansofdeath == "MOD_MELEE" )
            {
                return true;
            }
            else if ( var_2300d396e46c0fe7 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace damage
// Params 1
// Checksum 0x579c1c8e, Offset: 0x8750
// Size: 0x1f, Type: bool
function isspreadweapon( objweapon )
{
    return isdefined( objweapon ) && weaponclass( objweapon ) == "spread";
}

// Namespace damage
// Params 3
// Checksum 0x852a9468, Offset: 0x8778
// Size: 0x65, Type: bool
function function_a634b4e081115ab9( eattacker, victim, objweapon )
{
    if ( objweapon.basenamehash == %"semtex_bolt_splash_mp" && isdefined( victim.var_672320809c1c1c21 ) && isdefined( eattacker ) && arraycontains( victim.var_672320809c1c1c21, eattacker ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 1
// Checksum 0xef3cee72, Offset: 0x87e6
// Size: 0x77
function issmallsplashdamage( objweapon )
{
    if ( objweapon.basenamehash == %"semtex_xmike109_splash_mp" || objweapon.basenamehash == %"thermite_xmike109_radius_mp" || objweapon.basenamehash == %"semtex_bolt_splash_mp" || objweapon.basenamehash == %"thermite_bolt_radius_mp" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace damage
// Params 5
// Checksum 0x329feb7b, Offset: 0x8865
// Size: 0x35e
function spreadshotdamagemod( victim, eattacker, objweapon, idamage, idflags )
{
    if ( isdefined( eattacker ) && isdefined( victim ) )
    {
        hand = weapon_utility::function_deff5471cdf04d56( idflags );
        victimentnum = weapon_utility::function_4ec08fffae2d922d( victim );
        time = gettime();
        
        if ( !isdefined( eattacker.pelletweaponvictimids ) )
        {
            eattacker.pelletweaponvictimids = [];
        }
        
        foreach ( ihand, var_3efaf483dba5b6a8 in eattacker.pelletweaponvictimids )
        {
            foreach ( victimid, victimstruct in var_3efaf483dba5b6a8 )
            {
                if ( ( time - victimstruct.time ) / 1000 > level.shotgunsettings.var_ef779d3586800fe )
                {
                    eattacker.pelletweaponvictimids[ ihand ][ victimid ] = undefined;
                    
                    if ( eattacker.pelletweaponvictimids[ ihand ].size == 0 )
                    {
                        eattacker.pelletweaponvictimids[ ihand ] = undefined;
                    }
                }
            }
        }
        
        if ( !isdefined( eattacker.pelletweaponvictimids[ hand ] ) )
        {
            eattacker.pelletweaponvictimids[ hand ] = [];
        }
        
        if ( !isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
        {
            eattacker.pelletweaponvictimids[ hand ][ victimentnum ] = function_e15be0607bfbb4e7( eattacker, objweapon, time );
        }
        
        eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_77e7ce207984d5d8 = 0;
        eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed = arraysort( eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed );
        
        if ( eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed.size >= eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_b2fcf56b19fb3493 )
        {
            if ( idamage > eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ] )
            {
                damagedelta = idamage - eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ];
                eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ] = idamage;
                eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_77e7ce207984d5d8 = 1;
                idamage = damagedelta;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            arrayinsert( eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed, idamage, 0 );
        }
        
        idamage = weapon_utility::function_ceb194a906bf4a4c( eattacker, victim, idflags, idamage );
    }
    
    return idamage;
}

// Namespace damage
// Params 3
// Checksum 0xb74b9668, Offset: 0x8bcc
// Size: 0xda
function function_e15be0607bfbb4e7( eattacker, objweapon, time )
{
    struct = { #var_b2fcf56b19fb3493:getspreadpelletspershot( eattacker, objweapon ), #var_8c8eb6b39a4c19ad:0, #pelletdmgpassed:[], #time:time };
    
    if ( objweapon hasattachment( "trigger_heavy_p14" ) )
    {
        struct.var_57dfd4c4337d402e = level.shotgunsettings.var_e2d6f278a43050bd;
    }
    else if ( function_e03b776948c43ba8( objweapon ) )
    {
        struct.var_57dfd4c4337d402e = level.shotgunsettings.maxdamagefast;
    }
    else
    {
        struct.var_57dfd4c4337d402e = level.shotgunsettings.maxdamage;
    }
    
    return struct;
}

// Namespace damage
// Params 2
// Checksum 0x94aae1f0, Offset: 0x8caf
// Size: 0x29d
function getspreadpelletspershot( eattacker, objweapon )
{
    rootname = weapon::getweaponrootname( objweapon.basename );
    
    if ( rootname == "iw9_sh_charlie725" || rootname == "iw9_pi_swhiskey" || rootname == "jup_jp16_sh_recho870" )
    {
        if ( eattacker isdualwielding() )
        {
            return level.shotgunsettings.var_116f55d8852120c2;
        }
        
        if ( objweapon hasattachment( "bar_sh_short_p14" ) )
        {
            return level.shotgunsettings.var_ffd662859bc49103;
        }
        
        ads = eattacker playerads() > 0.5;
        tacstance = 0;
        
        if ( rootname == "jup_jp16_sh_recho870" )
        {
            tacstance = eattacker function_25af1328b3e8da54( objweapon, 0 );
        }
        
        if ( ads || tacstance )
        {
            return level.shotgunsettings.var_7fffe485f8d41378;
        }
        else
        {
            return level.shotgunsettings.var_ffd662859bc49103;
        }
        
        return;
    }
    
    if ( level.shotgunsettings.var_4a2f2b202a6e379 )
    {
        if ( isdefined( level.shotgunsettings.var_377891bb83de6bbb[ objweapon.basename ] ) )
        {
            switch ( level.shotgunsettings.var_377891bb83de6bbb[ objweapon.basename ] )
            {
                case #"hash_d63846c305b1c75e":
                    return level.shotgunsettings.var_ffd662859bc49103;
                case #"hash_599ed914eede51c1":
                    return level.shotgunsettings.var_7fffe485f8d41378;
                default:
                    return level.shotgunsettings.var_ffd662859bc49103;
            }
        }
        
        return ( eattacker playerads() > 0.5 ? level.shotgunsettings.var_7fffe485f8d41378 : level.shotgunsettings.var_ffd662859bc49103 );
    }
    
    if ( objweapon hasattachment( "jup_ammo_410g_ball" ) )
    {
        return level.shotgunsettings.var_2f74da3d7b6984ef;
    }
    
    if ( rootname == "jup_jp35_sn_moscar" && objweapon hasattachment( "jup_jp35_sn_moscar_bar_blund" ) )
    {
        return level.shotgunsettings.var_bd28e04a5ae50091;
    }
    
    if ( objweapon hasattachment( "t10_bar_short_sl_olove" ) || objweapon hasattachment( "t10_mags_wand_bulbs" ) )
    {
        return level.shotgunsettings.var_bd28e04a5ae50091;
    }
    
    return level.shotgunsettings.var_b0a6ec759ea967db;
}

// Namespace damage
// Params 1
// Checksum 0xc1d58434, Offset: 0x8f54
// Size: 0x1c, Type: bool
function helmet_washit( attacker )
{
    return gettime() == attacker.hithelmet;
}

// Namespace damage
// Params 1
// Checksum 0x32135833, Offset: 0x8f79
// Size: 0x1c
function helmet_sethit( attacker )
{
    attacker.hithelmet = gettime();
}

// Namespace damage
// Params 1
// Checksum 0x80be4e77, Offset: 0x8f9d
// Size: 0x17
function helmet_clearhit( attacker )
{
    attacker.hithelmet = undefined;
}

// Namespace damage
// Params 1
// Checksum 0x679bf27c, Offset: 0x8fbc
// Size: 0x1c, Type: bool
function helmet_wasbroke( attacker )
{
    return gettime() == attacker.brokehelmet;
}

// Namespace damage
// Params 1
// Checksum 0xa9be845, Offset: 0x8fe1
// Size: 0x1c
function helmet_setbroke( attacker )
{
    attacker.brokehelmet = gettime();
}

// Namespace damage
// Params 1
// Checksum 0x358c1897, Offset: 0x9005
// Size: 0x17
function helmet_clearbroke( attacker )
{
    attacker.brokehelmet = undefined;
}

// Namespace damage
// Params 6
// Checksum 0x27378440, Offset: 0x9024
// Size: 0xb5
function applystoppingpower( objweapon, shitloc, smeansofdeath, attacker, damage, maxhealth )
{
    maxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
    bulletstokill = getbulletstokill( maxhealth, damage );
    
    if ( bulletstokill == 2 )
    {
        if ( stoppingpowercanonehitkill( objweapon, shitloc, smeansofdeath, attacker ) )
        {
            return maxhealth;
        }
        else
        {
            return ( 0.9 * maxhealth );
        }
    }
    
    var_bc23ddab05613948 = -1;
    
    if ( bulletstokill >= 7 )
    {
        var_bc23ddab05613948 = -3;
    }
    else if ( bulletstokill >= 5 )
    {
        var_bc23ddab05613948 = -2;
    }
    
    return adjustbulletstokill( damage, maxhealth, var_bc23ddab05613948 );
}

// Namespace damage
// Params 4
// Checksum 0x9406d9a2, Offset: 0x90e2
// Size: 0x222, Type: bool
function stoppingpowercanonehitkill( objweapon, shitloc, smeansofdeath, attacker )
{
    weaponrootname = weapon::getweaponrootname( objweapon );
    sweaponclass = weaponclass( objweapon );
    
    if ( weaponrootname == "iw9_dm_crossbow" )
    {
        return true;
    }
    else if ( sweaponclass == "sniper" )
    {
        switch ( objweapon.var_1616e6fbba9a722d )
        {
            case %"iw8_sn_sksierra":
            case %"iw8_sn_mike14":
                if ( damage_utility::istorsouppershot( shitloc, smeansofdeath, attacker ) || damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
                {
                    return true;
                }
                
                break;
            case %"iw8_sn_kilo98":
            case %"iw8_sn_delta":
            case %"iw8_sn_sbeta":
                if ( damage_utility::istorsoshot( shitloc, smeansofdeath, attacker ) || damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
                {
                    return true;
                }
                
                break;
            default:
                if ( damage_utility::isupperbodyshot( shitloc, smeansofdeath, attacker ) || damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
                {
                    return true;
                }
                
                break;
        }
    }
    else if ( sweaponclass == "pistol" )
    {
        switch ( objweapon.var_1616e6fbba9a722d )
        {
            case %"hash_17cb45193ba1d4d7":
            case %"iw9_pi_swhiskey":
            case %"iw9_pi_decho":
                if ( damage_utility::istorsouppershot( shitloc, smeansofdeath, attacker ) || damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
                {
                    return true;
                }
                
                break;
        }
    }
    else if ( sweaponclass == "rifle" )
    {
        switch ( objweapon.var_1616e6fbba9a722d )
        {
            case %"iw8_ar_falima":
            case %"iw8_ar_asierra12":
                if ( damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
                {
                    return true;
                }
                
                break;
        }
        
        ammotype = getweaponammopoolname( objweapon );
        
        if ( ammotype == %"hash_a9efef52b466ad3" || ammotype == %"hash_6aa606a18241ad16" )
        {
            if ( damage_utility::istorsouppershot( shitloc, smeansofdeath, attacker ) || damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace damage
// Params 3
// Checksum 0xde969e8d, Offset: 0x930d
// Size: 0x159
function adjustbulletstokill( damage, maxhealth, delta )
{
    damage = int( damage );
    delta = int( delta );
    
    if ( delta == 0 )
    {
        return damage;
    }
    
    if ( damage <= 0 )
    {
        assertmsg( "<dev string:x1a6>" );
        return damage;
    }
    
    var_421ebd00ae948b2a = getbulletstokill( maxhealth, damage );
    var_37afcd826b27e2f8 = var_421ebd00ae948b2a + delta;
    
    if ( var_37afcd826b27e2f8 <= 0 )
    {
        damage *= 1.4;
    }
    else if ( var_37afcd826b27e2f8 == 1 )
    {
        damage = int( max( maxhealth, damage * 1.4 ) );
    }
    else
    {
        var_3e2f2426ba73630f = damage > maxhealth ? maxhealth : damage;
        percent = 0;
        
        if ( var_421ebd00ae948b2a == 1 )
        {
            percent = 0.9;
        }
        else
        {
            var_86fa0fe40518d274 = int( ceil( maxhealth / ( var_421ebd00ae948b2a - 1 ) ) );
            var_3d5c4d4f32b837fa = int( ceil( maxhealth / var_421ebd00ae948b2a ) );
            percent = ( var_3e2f2426ba73630f - var_3d5c4d4f32b837fa ) / ( var_86fa0fe40518d274 - var_3d5c4d4f32b837fa );
        }
        
        var_8bc943d01fd25dfa = int( ceil( maxhealth / ( var_37afcd826b27e2f8 - 1 ) ) );
        var_a51478c3956024e8 = int( ceil( maxhealth / var_37afcd826b27e2f8 ) );
        damage = int( ( var_8bc943d01fd25dfa - var_a51478c3956024e8 ) * percent + var_a51478c3956024e8 );
    }
    
    return damage;
}

// Namespace damage
// Params 2
// Checksum 0x3dcb62a8, Offset: 0x946f
// Size: 0x21
function getbulletstokill( maxhealth, damage )
{
    return int( ceil( maxhealth / damage ) );
}

// Namespace damage
// Params 2
// Checksum 0xe125be03, Offset: 0x9499
// Size: 0x40, Type: bool
function isbehindmeleevictim( attacker, victim )
{
    return !withinfov2d( victim.origin, victim.angles, attacker.origin, -0.4 );
}

// Namespace damage
// Params 3
// Checksum 0xbf5b7ebc, Offset: 0x94e2
// Size: 0x46, Type: bool
function function_384f9e35c17e5080( var_496aa4116abec767, attacker, victim )
{
    return !withinfov2d( victim.origin, victim.angles, attacker.origin, var_496aa4116abec767 );
}

// Namespace damage
// Params 6
// Checksum 0xc225ead1, Offset: 0x9531
// Size: 0xe5
function killstreakdamagefilter( eattacker, victim, idamage, objweapon, smeansofdeath, killstreakinfo )
{
    var_f4e7b1064f0dd48a = 0;
    streakname = killstreakinfo ? killstreakinfo.streakname : "";
    
    if ( isdefined( level.gamemodespawnprotectedcallback ) )
    {
        var_f4e7b1064f0dd48a = [[ level.gamemodespawnprotectedcallback ]]( eattacker, victim, idamage, objweapon, smeansofdeath, streakname );
    }
    
    if ( victim.var_c19506b543ae5021 || var_f4e7b1064f0dd48a )
    {
        damagelimit = function_550035572a0c4fd8( victim, objweapon, killstreakinfo );
        
        if ( idamage >= damagelimit && weapon::iskillstreakweapon( objweapon ) && !weapon::weaponbypassspawnprotection( objweapon, streakname ) && smeansofdeath != "MOD_MELEE" )
        {
            idamage = damagelimit;
        }
    }
    
    return idamage;
}

// Namespace damage
// Params 3, eflags: 0x4
// Checksum 0x2d38490d, Offset: 0x961f
// Size: 0x175
function private function_550035572a0c4fd8( victim, weapon, killstreak_info )
{
    damage_limit = int( max( victim.health / 4, 1 ) );
    
    if ( !killstreak_info )
    {
        return damage_limit;
    }
    
    var_f5656d048b80fb90 = killstreak_info.var_d884ad6df4aec245[ weapon.basename ];
    
    if ( !isdefined( var_f5656d048b80fb90 ) )
    {
        var_f5656d048b80fb90 = 2147483647;
        weapon_entries = killstreak_utility::function_b5d94c2d60f51b9d( killstreak_info.streakname );
        
        foreach ( entry in weapon_entries )
        {
            if ( entry.weaponname == weapon.basename && entry.var_48635ca083603e0c )
            {
                var_f5656d048b80fb90 = entry.var_48635ca083603e0c;
                break;
            }
        }
        
        if ( !isdefined( killstreak_info.var_d884ad6df4aec245 ) )
        {
            killstreak_info.var_d884ad6df4aec245 = [];
        }
        
        killstreak_info.var_d884ad6df4aec245[ weapon.basename ] = var_f5656d048b80fb90;
    }
    
    return int( min( damage_limit, var_f5656d048b80fb90 ) );
}

// Namespace damage
// Params 13
// Checksum 0x97854eda, Offset: 0x979d
// Size: 0xfc
function function_9537c6ad6219f24b( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    var_611487f2f41845b7 = 0;
    
    if ( isdefined( objweapon ) )
    {
        switch ( objweapon.basenamehash )
        {
            case %"none":
                if ( isdefined( einflictor ) && entity::isdronepackage( einflictor ) )
                {
                    var_611487f2f41845b7 = 1;
                }
                
                break;
            case %"chopper_gunner_turret_mp":
            case %"trophy_mp":
            case %"chopper_gunner_turret_ballistics_mp":
            case %"bomb_site_mp":
                var_611487f2f41845b7 = 1;
                break;
        }
    }
    
    return var_611487f2f41845b7;
}

// Namespace damage
// Params 16
// Checksum 0x87657c06, Offset: 0x98a2
// Size: 0xa27
function handlefriendlyfiredamage( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon, willknockdown )
{
    if ( isdefined( einflictor ) && !isplayer( einflictor ) )
    {
        if ( !isdefined( eattacker ) )
        {
            if ( isdefined( einflictor.owner ) )
            {
                eattacker = einflictor.owner;
            }
        }
        else if ( !isplayer( eattacker ) )
        {
            if ( isdefined( einflictor.owner ) )
            {
                eattacker = einflictor.owner;
            }
            else if ( isdefined( eattacker.owner ) )
            {
                eattacker = eattacker.owner;
            }
        }
    }
    
    if ( isdefined( level.var_a396a2687c46a7e8 ) )
    {
        return [[ level.var_a396a2687c46a7e8 ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon, willknockdown );
    }
    
    if ( isdefined( objweapon ) )
    {
        if ( utility::isbulletdamage( smeansofdeath ) && ( weapon::iscacprimaryweapon( objweapon.basename ) || weapon::iscacsecondaryweapon( objweapon.basename ) ) && !weapon::isstimpistolweapon( objweapon ) && !level.gametypebundle.var_79e06c3afebaaa60 )
        {
            level thread battlechatter_mp::trysaylocalsound( victim, #"bc_combat_inform_check_fire_ally", 0.25 );
        }
        
        if ( weapon::isstimpistolweapon( objweapon ) )
        {
            return 0;
        }
    }
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        if ( isdefined( idflags ) && idflags & 256 && utility::isbulletdamage( smeansofdeath ) )
        {
            idamage = int( idamage * 0.2 );
        }
    }
    
    if ( level.friendlyfire != 0 )
    {
        if ( level.maxallowedteamkills == -1 )
        {
            var_a28d6b990d7c0d0e = 0;
        }
        else
        {
            var_a28d6b990d7c0d0e = victim.isffprotectedaction || victim.isdefusing || victim.isplanting;
        }
        
        var_9c3b8b767a4df7f5 = isfriendlyfireprotectedperiod( eattacker );
        
        if ( var_a28d6b990d7c0d0e || var_9c3b8b767a4df7f5 )
        {
            idamage = int( idamage * 0.5 );
            
            if ( idamage < 1 )
            {
                idamage = 1;
            }
            
            if ( idamage > victim.health )
            {
                idamage = victim.health;
            }
            
            eattacker.lastdamagewasfromenemy = 0;
            
            if ( isdefined( eattacker.pers[ "teamdamage" ] ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
                {
                    if ( isdefined( eattacker.leaderboarddata[ "teamdamage" ] ) )
                    {
                        eattacker.leaderboarddata[ "teamdamage" ] = eattacker.leaderboarddata[ "teamdamage" ] + idamage;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "teamdamage" ] ) )
                    {
                        [[ level.leaderboardfunc[ "teamdamage" ] ]]( eattacker, idamage );
                    }
                    
                    assert( isint( idamage ) || isfloat( idamage ), "<dev string:xe1>" );
                    
                    if ( isdefined( eattacker.pers[ "teamdamage" ] ) )
                    {
                        eattacker.pers[ "teamdamage" ] = eattacker.pers[ "teamdamage" ] + idamage;
                    }
                }
            }
            
            damageattacker( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
            return 0;
        }
    }
    
    if ( level.friendlyfire == 0 || !isplayer( eattacker ) && level.friendlyfire != 1 )
    {
        if ( function_baa09a9e75d8726c( eattacker, victim ) )
        {
            eattacker handledamagefeedback( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, willknockdown, partname, vpoint );
        }
        
        return 0;
    }
    else if ( level.friendlyfire == 1 )
    {
        if ( idamage < 1 )
        {
            idamage = 1;
        }
        
        victim.lastdamagewasfromenemy = 0;
        
        if ( isspreadweapon( objweapon ) && damage_utility::validshotcheck( smeansofdeath, eattacker ) )
        {
            if ( dragonsbreath::isdragonsbreathweapon( objweapon ) && !dragonsbreath::function_527608d84b46e115( victim ) && ( weapon::getweapongroup( objweapon ) == "weapon_shotgun" || objweapon.isalternate ) )
            {
                victim thread dragonsbreathhitloccollection( shitloc, eattacker, objweapon );
            }
        }
        
        logfriendlyfire( victim, eattacker, idamage, smeansofdeath );
        victim finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
        eattacker handledamagefeedback( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, willknockdown, partname, vpoint );
        return 0;
    }
    else if ( level.friendlyfire == 2 )
    {
        idamage = int( idamage * 0.5 );
        
        if ( idamage < 1 )
        {
            idamage = 1;
        }
        
        eattacker.lastdamagewasfromenemy = 0;
        
        if ( !function_9537c6ad6219f24b( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname ) )
        {
            damageattacker( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
        }
        
        return 0;
    }
    else if ( level.friendlyfire == 3 )
    {
        idamage = int( idamage * 0.5 );
        
        if ( idamage < 1 )
        {
            idamage = 1;
        }
        
        victim.lastdamagewasfromenemy = 0;
        eattacker.lastdamagewasfromenemy = 0;
        
        if ( isspreadweapon( objweapon ) && damage_utility::validshotcheck( smeansofdeath, eattacker ) )
        {
            if ( dragonsbreath::isdragonsbreathweapon( objweapon ) && !dragonsbreath::function_527608d84b46e115( victim ) && ( weapon::getweapongroup( objweapon ) == "weapon_shotgun" || objweapon.isalternate ) )
            {
                victim thread dragonsbreathhitloccollection( shitloc, eattacker, objweapon );
            }
        }
        
        logfriendlyfire( victim, eattacker, idamage, smeansofdeath );
        victim finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
        
        if ( !function_9537c6ad6219f24b( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname ) )
        {
            damageattacker( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
        }
        
        eattacker handledamagefeedback( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, iskillstreakweapon, willknockdown, partname, vpoint );
        return 0;
    }
    else if ( level.friendlyfire == 4 )
    {
        var_bcfe91353ca38d42 = !function_9537c6ad6219f24b( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
        
        if ( var_bcfe91353ca38d42 && isdefined( eattacker.pers[ "teamdamage" ] ) && self.team == eattacker.team )
        {
            teamdamage = int( idamage );
            
            if ( idamage > victim.health )
            {
                teamdamage = victim.health;
            }
            
            var_e14018e370c240c1 = !eattacker.pers[ "didHitFFPunishLimit" ] && iskillstreakweapon;
            
            if ( !var_e14018e370c240c1 )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
                {
                    if ( isdefined( eattacker.leaderboarddata[ "teamdamage" ] ) )
                    {
                        eattacker.leaderboarddata[ "teamdamage" ] = eattacker.leaderboarddata[ "teamdamage" ] + teamdamage;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "teamdamage" ] ) )
                    {
                        [[ level.leaderboardfunc[ "teamdamage" ] ]]( eattacker, teamdamage );
                    }
                    
                    assert( isint( teamdamage ) || isfloat( teamdamage ), "<dev string:xe1>" );
                    
                    if ( isdefined( eattacker.pers[ "teamdamage" ] ) )
                    {
                        eattacker.pers[ "teamdamage" ] = eattacker.pers[ "teamdamage" ] + teamdamage;
                    }
                }
            }
            
            var_d58d3291077748db = level.var_547db1b350d23351 > 0;
            
            if ( var_d58d3291077748db && eattacker.pers[ "didHitFFPunishLimit" ] )
            {
                eattacker hud_message::showerrormessage( "MP/FRIENDLY_FIRE_KICK_WARNING" );
                
                if ( eattacker.pers[ "teamdamage" ] - eattacker.pers[ "totalFFDamageDoneBeforePunish" ] >= level.var_547db1b350d23351 )
                {
                    if ( !eattacker.pers[ "didHitFFKickLimit" ] )
                    {
                        eattacker.pers[ "didHitFFKickLimit" ] = 1;
                    }
                    else if ( eattacker.connected )
                    {
                        kick( eattacker getentitynumber(), &"EXE/PLAYERKICKED_TEAMKILLS" );
                        return 0;
                    }
                }
            }
            else if ( level.var_d0ec159c9006f135 > 0 )
            {
                if ( !eattacker.var_94623e30205f504d && eattacker.pers[ "teamdamage" ] >= level.var_d0ec159c9006f135 )
                {
                    eattacker.var_94623e30205f504d = 1;
                    eattacker hud_message::showerrormessage( %"mp/friendly_fire_will_not" );
                }
            }
        }
        
        var_25d4871c7475325c = level.var_2b4cdfe0899a031e > 0;
        shouldpunish = eattacker.pers[ "teamkills" ] >= level.maxallowedteamkills;
        
        if ( !shouldpunish && var_25d4871c7475325c )
        {
            shouldpunish = eattacker.pers[ "teamdamage" ] >= level.var_2b4cdfe0899a031e;
        }
        
        if ( shouldpunish && var_bcfe91353ca38d42 )
        {
            idamage = int( idamage * 0.5 );
            
            if ( idamage < 1 )
            {
                idamage = 1;
            }
            
            eattacker.lastdamagewasfromenemy = 0;
            damageattacker( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
            
            if ( !eattacker.pers[ "didHitFFPunishLimit" ] )
            {
                eattacker.pers[ "didHitFFPunishLimit" ] = 1;
                eattacker.pers[ "totalFFDamageDoneBeforePunish" ] = eattacker.pers[ "teamdamage" ];
            }
            
            return 0;
        }
    }
    
    return idamage;
}

// Namespace damage
// Params 1
// Checksum 0xb8ae0231, Offset: 0xa2d2
// Size: 0x9c, Type: bool
function isfriendlyfireprotectedperiod( attacker )
{
    if ( level.gametype == "havoc" )
    {
        return false;
    }
    
    if ( game_utility_mp::isanymlgmatch() && !level.leagueplaymatch )
    {
        return false;
    }
    
    if ( level.ingraceperiod )
    {
        return true;
    }
    
    if ( isdefined( attacker ) && attacker.pers[ "teamkills" ] > 1 && game_utility::gettimepassed() < level.graceperiod * 1000 + 8000 + attacker.pers[ "teamkills" ] * 1000 )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 14
// Checksum 0xc9dd18b1, Offset: 0xa377
// Size: 0xbf
function damageattacker( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    if ( eattacker player::isreallyalive() )
    {
        eattacker.friendlydamage = 1;
        eattacker finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
        eattacker.friendlydamage = undefined;
    }
}

// Namespace damage
// Params 1
// Checksum 0x6b67b874, Offset: 0xa43e
// Size: 0x2c, Type: bool
function mlghitlocrequiresclamp( shitloc )
{
    return shitloc == "head" || shitloc == "helmet" || shitloc == "neck";
}

// Namespace damage
// Params 6
// Checksum 0xc68a7748, Offset: 0xa473
// Size: 0xfc
function mlgmodifyheadshotdamage( eattacker, idamage, smeansofdeath, objweapon, shitloc, idflags )
{
    if ( game_utility_mp::isanymlgmatch() && isplayer( eattacker ) && !isnullweapon( objweapon ) && weapon::isprimaryweapon( objweapon ) && utility::isbulletdamage( smeansofdeath ) && mlghitlocrequiresclamp( shitloc ) )
    {
        if ( idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        switch ( objweapon.classname )
        {
            case #"hash_719417cb1de832b6":
            case #"hash_8cdaf2e4ecfe5b51":
            case #"hash_900cb96c552c5e8e":
            case #"hash_fa24dff6bd60a12d":
                idamage = int( clamp( idamage, 0, objweapon getmaxdamage( weapondamagetype ) * 1.3 ) );
                break;
        }
    }
    
    return idamage;
}

// Namespace damage
// Params 0
// Checksum 0xefa18cbb, Offset: 0xa578
// Size: 0x1d, Type: bool
function function_c1fe3b459e6e677d()
{
    if ( self isskydiving() )
    {
        self skydive_interrupt();
    }
    
    self notify( #"hash_76158f9795c6f611" );
    return false;
}

// Namespace damage
// Params 4
// Checksum 0xe514fd6f, Offset: 0xa59e
// Size: 0x2da
function modifyfalldamage( victim, idamage, idflags, smeansofdeath )
{
    modifieddamage = idamage;
    
    if ( smeansofdeath == "MOD_FALLING" )
    {
        /#
            if ( getdvarint( @"hash_8c547ec61bba79fd", 0 ) && !isbot( victim ) )
            {
                return 0;
            }
        #/
        
        if ( victim.falldamageprotection )
        {
            modifieddamage = 0;
        }
        else if ( victim callback::response( 0, #"hash_657f964d63330123", {} ) )
        {
            modifieddamage = function_c1fe3b459e6e677d();
        }
        else if ( getdvarint( @"hash_f1b2bd0a1fa58a73", 0 ) )
        {
            modifieddamage = function_c1fe3b459e6e677d();
        }
        else if ( idflags & 32768 && modifieddamage >= victim.health )
        {
            modifieddamage = victim.health - 1;
        }
        else if ( br_alt_mode_shock::function_480f16a04286f001() && victim shock_buff::function_c1adf60b0d7bb249( "shock_super_jump" ) )
        {
            modifieddamage = 0;
        }
        else if ( victim.var_72369e11c9a3b837 || victim.var_a171f194c1a383da )
        {
            modifieddamage = 0;
        }
        else if ( isdefined( victim.perks[ "specialty_falldamage" ] ) )
        {
            modifieddamage = 0;
        }
        else
        {
            foreach ( falldamagemodifier in victim.falldamagemodifiers )
            {
                modifieddamage = [[ falldamagemodifier ]]( victim, modifieddamage, idflags, smeansofdeath );
            }
            
            if ( modifieddamage < victim.maxhealth )
            {
                modifieddamage = int( ceil( modifieddamage / victim.maxhealth * modifieddamage / victim.maxhealth * victim.maxhealth ) );
                thread damage_effects::falldamageeffects( modifieddamage );
                
                if ( self.battlerageactive )
                {
                    if ( isdefined( level.var_cde0743afea3bc92 ) )
                    {
                        modifieddamage *= level.var_cde0743afea3bc92;
                    }
                    else
                    {
                        modifieddamage = 0;
                    }
                }
                else if ( modifieddamage >= victim.health )
                {
                    modifieddamage = victim.health - 1;
                }
                
                if ( victim.var_6c90b007e13f1832 )
                {
                    victim notify( #"dexterity_activated" );
                }
                
                if ( isdefined( self.perks[ "specialty_mountaineer" ] ) )
                {
                    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_mountaineer" );
                }
                
                if ( self function_4bbc5b259f2dd62c() && level.projectbundle.var_dab1c2079efa9082 )
                {
                    modifieddamage = 0;
                }
            }
            else if ( level.projectbundle.var_bec849b8d4def8da )
            {
                victim playlocalsound( "step_default_plr_landdeath" );
            }
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 5, eflags: 0x4
// Checksum 0x626881df, Offset: 0xa881
// Size: 0xbb
function private modifyvehicletoplayerdamage( einflictor, eattacker, victim, idamage, smeansofdeath )
{
    modifieddamage = idamage;
    
    if ( isdefined( einflictor ) && einflictor vehicle::is_vehicle() )
    {
        if ( victim killstreak::isjuggernaut() )
        {
            modifieddamage = victim juggernaut::jugg_modifyvehicletoplayerdamage( idamage, smeansofdeath );
        }
        
        if ( getdvarint( @"scr_live_ragdoll_on_vehicles", 0 ) == 1 )
        {
            velocity = einflictor vehicle_getvelocity();
            modifieddamage = victim.health - 1;
            
            if ( victim.health > 0 )
            {
                victim thread function_a48c25ff5c1fa9ba( undefined, 1, velocity );
            }
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 4
// Checksum 0x7b361542, Offset: 0xa945
// Size: 0x9a
function function_34ab23a052385c85( eattacker, objweapon, smeansofdeath, idamage )
{
    modifieddamage = idamage;
    
    if ( isdefined( eattacker ) && isdefined( eattacker.var_3e5cb61ea21f86d4 ) )
    {
        modifieddamage *= eattacker.var_3e5cb61ea21f86d4;
    }
    
    if ( istrue( self.inlaststand ) && isdefined( level.gametypebundle ) && istrue( level.gametypebundle.var_1bbadd348b2ce5ef ) )
    {
        modifieddamage = self.health;
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 5
// Checksum 0x8fcb8fa8, Offset: 0xa9e8
// Size: 0x75
function modifycrushdamage( einflictor, eattacker, victim, idamage, smeansofdeath )
{
    modifieddamage = idamage;
    
    if ( smeansofdeath == "MOD_CRUSH" )
    {
        if ( einflictor == eattacker && eattacker killstreak::isjuggernaut() && victim killstreak::isjuggernaut() )
        {
            modifieddamage = victim juggernaut::jugg_modifyherodroptoplayerdamage( idamage );
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 6
// Checksum 0x9679dc55, Offset: 0xaa66
// Size: 0xa4
function function_9a4c8c9cd9e75801( eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2 )
{
    modifieddamage = idamage;
    
    if ( isdefined( eattacker ) && isdefined( smeansofdeath ) && isdefined( objweapon ) )
    {
        if ( dragonsbreath::function_7feebca326ca7376( objweapon ) )
        {
            objweapon = eattacker weapon_utility::function_5ba4049e1c74f6a8( objweapon );
            
            if ( !isspreadweapon( objweapon ) )
            {
                victimhealth = victim.health;
                modifieddamage = var_cdd29ad5d1362c2;
                
                if ( modifieddamage >= victimhealth )
                {
                    modifieddamage = victimhealth - 1;
                }
            }
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 7, eflags: 0x4
// Checksum 0x2fec8ec5, Offset: 0xab13
// Size: 0xfe
function private function_1b763dede306d97b( eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, einflictor )
{
    data = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor );
    
    if ( victim damage_utility::isstuckdamagekill( data ) )
    {
        return idamage;
    }
    
    if ( victim killstreak::isjuggernaut() )
    {
        return idamage;
    }
    
    equiptype = weapon::getequipmenttype( objweapon );
    
    if ( isdefined( equiptype ) )
    {
        if ( equiptype == "lethal" )
        {
            idamage = function_70f15936fa8106a2( objweapon, idamage );
        }
    }
    
    if ( utility::isbulletdamage( smeansofdeath ) )
    {
        idamage = function_fb0dfe13e3e17c14( objweapon, idamage );
    }
    
    if ( ( objweapon.basename == "jup_jp26_la_mike32_mp" || objweapon.basename == "bunkerbuster_round_gl_mp" ) && smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        idamage *= 0.2;
    }
    
    return idamage;
}

// Namespace damage
// Params 2, eflags: 0x4
// Checksum 0x6740945b, Offset: 0xac1a
// Size: 0x78
function private function_70f15936fa8106a2( objweapon, damage )
{
    dvarstringbase = @"hash_303dbc969fd35e79";
    
    if ( isdefined( objweapon.basename ) )
    {
        dvarstring = hashcat( dvarstringbase, objweapon.basename );
        defaultratio = self.maxhealth / 100;
        damage *= getdvarfloat( dvarstring, defaultratio );
    }
    
    return damage;
}

// Namespace damage
// Params 2, eflags: 0x4
// Checksum 0x4e2b34d5, Offset: 0xac9b
// Size: 0xcc
function private function_fb0dfe13e3e17c14( objweapon, damage )
{
    dvarstringbase = @"hash_303dbc969fd35e79";
    
    if ( isdefined( objweapon.classname ) )
    {
        dvarstring = hashcat( dvarstringbase, objweapon.classname );
        damageratio = getdvarfloat( dvarstring, 0 );
        damage *= damageratio == 0 ? 1 : damageratio;
    }
    
    if ( isdefined( objweapon.basename ) )
    {
        dvarstring = hashcat( dvarstringbase, objweapon.basename );
        damageratio = getdvarfloat( dvarstring, 0 );
        damage *= damageratio == 0 ? 1 : damageratio;
    }
    
    return damage;
}

// Namespace damage
// Params 8
// Checksum 0x534fac36, Offset: 0xad70
// Size: 0x4bd
function modifyexplosivedamage( inflictor, attacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, shitloc )
{
    modifieddamage = idamage;
    isfraggrenade = issubstr( objweapon.basename, "frag_grenade" );
    
    if ( isfraggrenade )
    {
        assert( smeansofdeath == "<dev string:x202>" || smeansofdeath == "<dev string:x20e>" || smeansofdeath == "<dev string:x221>" || smeansofdeath == "<dev string:x22c>" || smeansofdeath == "<dev string:x238>", "<dev string:x246>" + smeansofdeath );
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        iskillstreakweapon = istrue( weapon::iskillstreakweapon( objweapon ) );
        
        if ( isplayer( attacker ) )
        {
            if ( attacker != victim && isdefined( attacker.perks[ "specialty_paint" ] ) && !iskillstreakweapon )
            {
                victim thread perkfunctions::setpainted( attacker );
            }
        }
        
        modifieddamage = modifydestructibledamage( modifieddamage, inflictor, objweapon );
        var_67ea85cc257f9923 = level.var_d3ff65cbeaa3ff69[ objweapon.var_25b0062cbe4d9c99 ];
        
        if ( var_67ea85cc257f9923 )
        {
            modifieddamage = [[ var_67ea85cc257f9923 ]]( victim, inflictor, objweapon, smeansofdeath, modifieddamage );
        }
        
        if ( isdefined( objweapon.basenamehash ) )
        {
            switch ( objweapon.basenamehash )
            {
                case %"concussion_grenade_mp":
                case %"hash_56e9bc574acd9d63":
                case %"flash_grenade_mp":
                    if ( isdefined( victim ) && modifieddamage >= victim.health )
                    {
                        if ( isdefined( attacker ) )
                        {
                            attacker damagefeedback::updatedamagefeedback( "" );
                        }
                        
                        modifieddamage = 0;
                    }
                    
                    break;
                case %"hash_799b419560fbf61":
                    modifieddamage = 0;
                    break;
            }
        }
        
        var_90f79f2631cd0a80 = arraycontains( victim.loadoutperks, "specialty_eod_vest" );
        
        if ( isdefined( level.sharedfuncs[ #"thermobaric_grenade" ][ #"thermobaric_additional_explosive_damage" ] ) )
        {
            modifieddamage += [[ level.sharedfuncs[ #"thermobaric_grenade" ][ #"thermobaric_additional_explosive_damage" ] ]]( victim, attacker, modifieddamage );
        }
        
        if ( !isdefined( modifieddamage ) )
        {
            assertmsg( "<dev string:x27a>" );
            modifieddamage = idamage ?? 0;
        }
        
        if ( isdefined( victim.perks[ "specialty_reduce_explosion_damage" ] ) && !attacker.ignore_perk_reduce_explosion_damage )
        {
            if ( isdefined( victim.var_7d000e422856102b ) && attacker == victim )
            {
                scalarreduction = victim.var_7d000e422856102b;
            }
            else
            {
                scalarreduction = victim.var_e2e9f6fc2bcc1652;
            }
            
            modifieddamage *= scalarreduction ?? 1;
        }
        
        if ( victim.var_35f8278d51a40c7f )
        {
            modifieddamage *= victim.var_35f8278d51a40c7f;
        }
        
        if ( isplayer( attacker ) && weaponinheritsperks( objweapon ) && isdefined( attacker.perks[ "specialty_explosivedamage" ] ) && isdefined( victim.perks[ "specialty_blastshield" ] ) )
        {
        }
        else if ( isplayer( attacker ) && weaponinheritsperks( objweapon ) && !iskillstreakweapon && isdefined( attacker.perks[ "specialty_explosivedamage" ] ) )
        {
            modifieddamage += modifieddamage * level.explosivedamagemod;
        }
        else if ( ( var_90f79f2631cd0a80 || isdefined( victim.perks[ "specialty_blastshield" ] ) ) && ![[ level.sharedfuncs[ #"specialty_blastshield" ][ #"hash_4caa4d716053e6b8" ] ]]( attacker, victim, objweapon, smeansofdeath, inflictor, shitloc ) )
        {
            if ( var_90f79f2631cd0a80 )
            {
                assert( isdefined( victim.perks[ "<dev string:x2ac>" ] ), "<dev string:x2c2>" );
            }
            
            var_ed30eb0c259df2de = modifieddamage;
            
            if ( isdefined( victim.flakjackethealth ) )
            {
                var_ed30eb0c259df2de = function_affb697eaeaf6938( var_ed30eb0c259df2de, victim );
            }
            else if ( isdefined( level.sharedfuncs[ #"specialty_blastshield" ][ #"hash_792f3fd5f432ec37" ] ) )
            {
                var_ed30eb0c259df2de = [[ level.sharedfuncs[ #"specialty_blastshield" ][ #"hash_792f3fd5f432ec37" ] ]]( modifieddamage, attacker, victim );
            }
            
            if ( isdefined( level.sharedfuncs[ #"specialty_blastshield" ][ #"perkactivation" ] ) )
            {
                [[ level.sharedfuncs[ #"specialty_blastshield" ][ #"perkactivation" ] ]]();
            }
            
            modifieddamage -= modifieddamage - var_ed30eb0c259df2de;
        }
        
        if ( isdefined( level.lethaldelay ) && !equipment_mp::lethaldelaypassed() )
        {
            modifieddamage *= level.graceperiodgrenademod;
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 8
// Checksum 0xf66bbf59, Offset: 0xb236
// Size: 0x183
function function_3d729a089258c13d( inflictor, attacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, shitloc )
{
    modifieddamage = idamage;
    
    if ( smeansofdeath == "MOD_FIRE" )
    {
        if ( isdefined( victim.perks[ "specialty_blastshield" ] ) && ![[ utility::getsharedfunc( #"specialty_blastshield", #"hash_4caa4d716053e6b8" ) ]]( attacker, victim, objweapon, smeansofdeath, inflictor, shitloc ) )
        {
            var_ed30eb0c259df2de = modifieddamage;
            
            if ( isdefined( victim.var_a81cc8dd26229958 ) )
            {
                var_ed30eb0c259df2de *= victim.var_a81cc8dd26229958;
                
                if ( isdefined( victim.flakjackethealth ) )
                {
                    var_ed30eb0c259df2de = function_affb697eaeaf6938( var_ed30eb0c259df2de, victim );
                }
            }
            else if ( utility::issharedfuncdefined( #"specialty_blastshield", #"hash_792f3fd5f432ec37" ) )
            {
                var_ed30eb0c259df2de = [[ utility::getsharedfunc( #"specialty_blastshield", #"hash_792f3fd5f432ec37" ) ]]( modifieddamage, attacker, victim );
            }
            
            if ( utility::issharedfuncdefined( #"specialty_blastshield", #"perkactivation" ) )
            {
                [[ utility::getsharedfunc( #"specialty_blastshield", #"perkactivation" ) ]]();
            }
            
            modifieddamage -= modifieddamage - var_ed30eb0c259df2de;
        }
        
        if ( isagent( attacker ) && player::isinlaststand( victim ) )
        {
            modifieddamage = int( modifieddamage / 3 );
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 8
// Checksum 0x439bba02, Offset: 0xb3c2
// Size: 0x32a
function function_39ea5ed8dc906fd( inflictor, attacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, shitloc )
{
    modifieddamage = idamage;
    
    if ( isdefined( objweapon ) && isdefined( smeansofdeath ) && isdefined( victim.perks[ "specialty_super_protection" ] ) )
    {
        weaponref = objweapon.basenamehash;
        attackerweaponclass = weaponclass( objweapon );
        var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
        
        if ( isdefined( weaponref ) && isdefined( attackerweaponclass ) )
        {
            if ( utility::isbulletdamage( smeansofdeath ) )
            {
                switch ( attackerweaponclass )
                {
                    case #"hash_e224d0b635d0dadd":
                        if ( var_ec636abdcf08f7b3 )
                        {
                            modifieddamage = min( 1, idamage );
                        }
                        
                        break;
                }
            }
            else if ( utility::isimpactdamage( smeansofdeath ) )
            {
                if ( isdefined( attackerweaponclass ) )
                {
                    switch ( attackerweaponclass )
                    {
                        case #"hash_2ab98cab4066a74e":
                            modifieddamage = min( self.maxhealth, idamage );
                            break;
                    }
                }
            }
            else if ( isexplosivedamagemod( smeansofdeath ) )
            {
                switch ( weaponref )
                {
                    case %"molotov_mp":
                        if ( var_ec636abdcf08f7b3 )
                        {
                            modifieddamage = min( 5, idamage );
                        }
                        
                        break;
                }
            }
            else if ( utility::isfiredamage( smeansofdeath ) )
            {
                var_ec636abdcf08f7b3 = isdefined( inflictor ) && ( inflictor.stuckto == victim || inflictor.stuckenemyentity == victim );
                
                switch ( weaponref )
                {
                    case %"thermite_mp":
                    case %"thermite_ap_mp":
                    case %"thermite_av_mp":
                        if ( var_ec636abdcf08f7b3 )
                        {
                            modifieddamage = min( 5, idamage );
                        }
                        
                        break;
                }
            }
        }
        
        if ( modifieddamage > 0 )
        {
            modifier = isagent( attacker ) ? getdvarfloat( @"hash_aca7f88b7bc0b97d", 0 ) : getdvarfloat( @"hash_82cc9b0ec1f12017", 0 );
            modifieddamage = int( modifieddamage * modifier );
            
            if ( modifieddamage == 0 )
            {
                attacker damagefeedback::updatedamagefeedback( "hitnobulletdamage_wm", 0, 0, undefined, 1 );
            }
        }
    }
    
    if ( isdefined( objweapon ) && isdefined( smeansofdeath ) && smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_BUMP" && modifieddamage < victim.maxhealth && isdefined( victim.perks[ "specialty_battlerage_reduce_damage" ] ) )
    {
        modifieddamage = int( modifieddamage * getdvarfloat( @"hash_1bd8b2e40fb683f9", 0.9 ) );
    }
    
    if ( smeansofdeath == "MOD_SUICIDE" )
    {
        isfraggrenade = issubstr( objweapon.basename, "frag_grenade" );
        
        if ( isfraggrenade && isdefined( victim.perks[ "specialty_reduce_explosion_damage" ] ) )
        {
            if ( isdefined( victim.var_7d000e422856102b ) )
            {
                modifieddamage *= victim.var_7d000e422856102b;
            }
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 1
// Checksum 0x37212a3d, Offset: 0xb6f5
// Size: 0x39
function function_3232791951a34daf( modifier )
{
    if ( !isdefined( level.damagemodifiers ) )
    {
        level.damagemodifiers = [];
    }
    
    level.damagemodifiers[ level.damagemodifiers.size ] = modifier;
}

// Namespace damage
// Params 13
// Checksum 0x7e525ae7, Offset: 0xb736
// Size: 0x96d
function modifydamagegeneral( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, var_cdd29ad5d1362c2, partname )
{
    unmodifieddamage = idamage;
    
    if ( self.var_455ee79bf87eeb35 )
    {
        idamage *= self.var_455ee79bf87eeb35;
    }
    
    if ( game_utility_mp::isanymlgmatch() )
    {
        idamage = mlgmodifyheadshotdamage( eattacker, idamage, smeansofdeath, objweapon, shitloc, idflags );
    }
    
    switch ( smeansofdeath ?? "" )
    {
        case #"hash_b15027ffbdc0ecb":
            idamage = modifyfalldamage( victim, idamage, idflags, smeansofdeath );
            break;
        case #"hash_abb1587cdc6def23":
            idamage = modifycrushdamage( einflictor, eattacker, victim, idamage, smeansofdeath );
            break;
        case #"hash_d8646db4e6ee3658":
            idamage = function_3d729a089258c13d( einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, shitloc );
            break;
        case #"hash_a86d8c43482948a4":
            if ( idamage != 1 )
            {
                idamage *= getdvarfloat( @"scr_explbulletmod" );
                idamage = int( idamage );
            }
            
            break;
        case #"hash_b1078ff213fddba6":
            if ( idamage != 1 )
            {
                if ( objweapon.isalternate && weapons::isattachmentgrenadelauncher( objweapon.underbarrel ) )
                {
                    velocity = einflictor getmissilevelocity();
                    speed = length( velocity );
                    
                    if ( speed < 400 )
                    {
                        idamage = 10;
                    }
                }
            }
            
            break;
        case #"hash_a5123f4d02745600":
            idamage = function_34ab23a052385c85( eattacker, objweapon, smeansofdeath, idamage );
            break;
    }
    
    if ( einflictor && einflictor vehicle::is_vehicle() )
    {
        idamage = modifyvehicletoplayerdamage( einflictor, eattacker, victim, idamage, smeansofdeath );
    }
    
    vehicle = victim vehicle::get_vehicle();
    
    if ( vehicle )
    {
        idamage = vehicle_damage::function_c95ff728d8d53bce( vehicle, victim, idamage, idflags, shitloc, smeansofdeath, eattacker, objweapon );
    }
    
    if ( dragonsbreath::function_7feebca326ca7376( objweapon ) )
    {
        idamage = function_9a4c8c9cd9e75801( eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2 );
    }
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        idamage = function_1b763dede306d97b( eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, einflictor );
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        idamage = modifyexplosivedamage( einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, shitloc );
    }
    
    idamage = function_39ea5ed8dc906fd( einflictor, eattacker, victim, objweapon, smeansofdeath, idamage, var_cdd29ad5d1362c2, shitloc );
    
    if ( isdefined( level.modifyplayerdamage ) )
    {
        idamage = int( [[ level.modifyplayerdamage ]]( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 ) );
    }
    
    if ( isscriptedagent( eattacker ) )
    {
        idamage = function_7559275e5e539ebe( eattacker, idamage, smeansofdeath, objweapon, victim );
    }
    
    foreach ( damagemodifier in level.damagemodifiers )
    {
        idamage = [[ damagemodifier ]]( eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, partname, unmodifieddamage );
    }
    
    if ( !isdefined( victim.donotmodifydamage ) )
    {
        if ( victim.additivedamagemodifiers.size > 0 || victim.multiplicativedamagemodifiers.size > 0 )
        {
            idamage = int( idamage * victim damage_utility::getdamagemodifiertotal( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc ) );
        }
    }
    
    var_35306fe1439862ca = eattacker && isplayer( eattacker ) && ( isdefined( eattacker.callbacks[ #"hash_2346898712859996" ] ) || isdefined( level.callbacks[ #"hash_2346898712859996" ] ) );
    var_6ae612c357a0b863 = victim && ( isdefined( victim.callbacks[ #"hash_652eb614ba902b3d" ] ) || isdefined( level.callbacks[ #"hash_652eb614ba902b3d" ] ) );
    
    if ( var_35306fe1439862ca || var_6ae612c357a0b863 )
    {
        params = { #partname:partname, #var_cdd29ad5d1362c2:var_cdd29ad5d1362c2, #psoffsettime:psoffsettime, #shitloc:shitloc, #vdamagedir:vdir, #vpoint:vpoint, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #victim:victim, #eattacker:eattacker, #einflictor:einflictor };
        
        if ( var_35306fe1439862ca )
        {
            eattacker callback::callback( #"hash_2346898712859996", params );
        }
        
        if ( var_6ae612c357a0b863 )
        {
            victim callback::callback( #"hash_652eb614ba902b3d", params );
        }
        
        idamage = params.idamage;
    }
    
    if ( victim armor::hasarmor() )
    {
        [ idamage, lightarmordamage ] = armor::function_4875d04d69b22ae( eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, unmodifieddamage, partname );
    }
    else
    {
        if ( isplayer( eattacker ) )
        {
            armor::armorvest_clearhit( eattacker );
            armor::armorvest_clearbroke( eattacker );
        }
        
        lightarmordamage = 0;
    }
    
    if ( lightarmordamage > 0 && isplayer( eattacker ) )
    {
        if ( shouldrecorddamagestats( eattacker ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
            {
                if ( isdefined( eattacker.leaderboarddata[ "damage" ] ) )
                {
                    eattacker.leaderboarddata[ "damage" ] = eattacker.leaderboarddata[ "damage" ] + lightarmordamage;
                }
                
                if ( isdefined( level.leaderboardfunc[ "damage" ] ) )
                {
                    [[ level.leaderboardfunc[ "damage" ] ]]( eattacker, lightarmordamage );
                }
                
                assert( isint( lightarmordamage ) || isfloat( lightarmordamage ), "<dev string:xe1>" );
                
                if ( isdefined( eattacker.pers[ "damage" ] ) )
                {
                    eattacker.pers[ "damage" ] = eattacker.pers[ "damage" ] + lightarmordamage;
                }
            }
            
            eattacker codcasterclientmatchdata::function_d1f0591eda60c559( 1, lightarmordamage );
            
            if ( isdefined( eattacker.pers[ "friendlyDamageDone" ] ) && victim.team == eattacker.team )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
                {
                    if ( isdefined( eattacker.leaderboarddata[ "friendlyDamageDone" ] ) )
                    {
                        eattacker.leaderboarddata[ "friendlyDamageDone" ] = eattacker.leaderboarddata[ "friendlyDamageDone" ] + lightarmordamage;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "friendlyDamageDone" ] ) )
                    {
                        [[ level.leaderboardfunc[ "friendlyDamageDone" ] ]]( eattacker, lightarmordamage );
                    }
                    
                    assert( isint( lightarmordamage ) || isfloat( lightarmordamage ), "<dev string:xe1>" );
                    
                    if ( isdefined( eattacker.pers[ "friendlyDamageDone" ] ) )
                    {
                        eattacker.pers[ "friendlyDamageDone" ] = eattacker.pers[ "friendlyDamageDone" ] + lightarmordamage;
                    }
                }
            }
        }
        else if ( isdefined( level.onattackerdamagenottracked ) )
        {
            eattacker [[ level.onattackerdamagenottracked ]]( lightarmordamage );
        }
    }
    
    if ( victim.inlaststand && objweapon.basenamehash == %"iw9_dm_crossbow_mp" )
    {
        idamage = victim.health;
        
        if ( level.lastStandDamageTakenScalar > 0 )
        {
            idamage = int( ceil( idamage / level.lastStandDamageTakenScalar ) );
        }
    }
    
    if ( eattacker.var_1d1e022a5aa5050b )
    {
        idamage *= 0.5;
    }
    
    if ( level.headshotsonly )
    {
        if ( smeansofdeath == "MOD_HEAD_SHOT" || damage_utility::isheadshot( shitloc, smeansofdeath, eattacker ) )
        {
            idamage = 150;
        }
    }
    
    if ( isdefined( level.sharedfuncs[ #"helmet" ][ #"modifyhelmetdamage" ] ) )
    {
        [ idamage, lightarmordamage ] = [[ level.sharedfuncs[ #"helmet" ][ #"modifyhelmetdamage" ] ]]( eattacker, victim, idamage, lightarmordamage, objweapon, shitloc, partname, smeansofdeath );
    }
    
    if ( objweapon.basenamehash == %"jup_jp26_la_mike32_mp" && objweapon hasattachmenthash( %"jup_ammo_44mm_slug" ) )
    {
        switch ( shitloc )
        {
            case #"hash_92bbfe494d03d772":
            case #"hash_b107b5547c755d23":
                idamage *= 1.4;
                break;
            case #"hash_da51cc36a471058":
            case #"hash_51d5d0b9add9cc5a":
            case #"hash_5d5aac570f6fd382":
            case #"hash_a7980c387477e7bb":
            case #"hash_b275b50677dcf6cb":
            case #"hash_d42e71cd9f1e822f":
            case #"hash_da2f35145aa58933":
                idamage *= 1.1;
            default:
                break;
        }
    }
    
    return [ idamage, lightarmordamage ];
}

// Namespace damage
// Params 13
// Checksum 0xf6a31370, Offset: 0xc0ac
// Size: 0x744
function handleriotshieldhits( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, iskillstreakweapon, ignorelightarmor, bonename )
{
    if ( shitloc != "shield" )
    {
        return idamage;
    }
    
    if ( isdefined( objweapon ) && objweapon.basenamehash == %"super_laser_charge_mp" )
    {
        victim.forcehitlocation = "none";
        return idamage;
    }
    
    data = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, vpoint, vdir, undefined, undefined, undefined, undefined, idflags );
    ignorexp = istrue( victim.ignoreriotshieldxp );
    isenemy = istrue( player_utility::playersareenemies( victim, eattacker ) );
    
    if ( getdvarint( @"hash_79392ae6dcfba9e9", 0 ) )
    {
        isfriendly = isfriendlyfire( victim, eattacker );
        var_9b748ce2d8b188a5 = isdefined( victim ) && ( eattacker == victim || eattacker.owner == victim );
        
        if ( isenemy || isfriendly && ( game_utility::function_ae97372c83da7acc() || var_9b748ce2d8b188a5 ) )
        {
            if ( function_e3c4fc450ca6942a( objweapon, smeansofdeath ) )
            {
                victim.var_5eced67e46f64479 = gettime();
            }
        }
    }
    
    if ( isdefined( victim.owner ) )
    {
        victim = victim.owner;
        
        if ( eattacker == victim )
        {
            return 0;
        }
    }
    
    var_e5bad414cfe9af08 = 1;
    
    if ( isdefined( vpoint ) && idflags & 128 )
    {
        var_e5bad414cfe9af08 = victim function_ea572ab73d87a720( vpoint );
    }
    
    var_52a78e92cd8e855e = victim.super.riotshielddata;
    
    if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE_SPLASH" || var_52a78e92cd8e855e )
    {
        if ( isplayer( eattacker ) )
        {
            eattacker.lastattackedshieldplayer = victim;
            eattacker.lastattackedshieldtime = gettime();
        }
        
        victim notify( #"shield_blocked" );
        
        if ( weapon::isenvironmentweapon( objweapon ) )
        {
            shielddamage = 25;
        }
        else
        {
            var_ec36de079e500e58 = idamage * var_e5bad414cfe9af08;
            modifieddamageresults = cac_modified_damage( victim, eattacker, var_ec36de079e500e58, smeansofdeath, objweapon, vpoint, vdir, shitloc, einflictor, 0, idflags, ignorelightarmor );
            shielddamage = modifieddamageresults[ 0 ];
            shitloc = modifieddamageresults[ 2 ];
        }
        
        if ( isdefined( bonename ) )
        {
            if ( bonename == "tag_shield_le" || bonename == "tag_shield_le_new" || bonename == "tag_shield_le_dmg" || bonename == "tag_shield_ri" || bonename == "tag_shield_ri_new" || bonename == "tag_shield_ri_dmg" )
            {
                victim gun_shield::gunshield_ondamage( victim, shielddamage, bonename, eattacker );
                eattacker damagefeedback::updatedamagefeedback( "hitequip" );
            }
            else if ( utility::issharedfuncdefined( #"super_riotshield", #"hash_dd3226361f17fd81" ) )
            {
                victim [[ utility::getsharedfunc( #"super_riotshield", #"hash_dd3226361f17fd81" ) ]]( data, bonename );
            }
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
        {
            if ( isdefined( victim.leaderboarddata[ "riotShieldDamageAbsorbed" ] ) )
            {
                victim.leaderboarddata[ "riotShieldDamageAbsorbed" ] = victim.leaderboarddata[ "riotShieldDamageAbsorbed" ] + shielddamage;
            }
            
            if ( isdefined( level.leaderboardfunc[ "riotShieldDamageAbsorbed" ] ) )
            {
                [[ level.leaderboardfunc[ "riotShieldDamageAbsorbed" ] ]]( victim, shielddamage );
            }
            
            assert( isint( shielddamage ) || isfloat( shielddamage ), "<dev string:xe1>" );
            
            if ( isdefined( victim.pers[ "riotShieldDamageAbsorbed" ] ) )
            {
                victim.pers[ "riotShieldDamageAbsorbed" ] = victim.pers[ "riotShieldDamageAbsorbed" ] + shielddamage;
            }
        }
        
        if ( isplayer( eattacker ) && isdefined( victim.rearguardattackers ) )
        {
            idx = eattacker getentitynumber();
            
            if ( !isdefined( victim.rearguardattackers[ idx ] ) )
            {
                victim.rearguardattackers[ idx ] = shielddamage;
            }
            else
            {
                victim.rearguardattackers[ idx ] += shielddamage;
            }
        }
        
        if ( ignorexp )
        {
            return 0;
        }
        
        if ( !weapon::isenvironmentweapon( objweapon ) || utility::cointoss() )
        {
            victim.shieldbullethits++;
        }
        
        if ( victim.shieldbullethits >= level.riotshieldxpbullets && isenemy )
        {
            xpmultiplier = 1;
            
            if ( self.recentshieldxp > 4 )
            {
                xpmultiplier = 1 / self.recentshieldxp;
            }
            
            basepoints = rank::getscoreinfovalue( #"shield_damage" );
            victim thread points::doscoreevent( #"shield_damage", victim.currentweapon, basepoints * xpmultiplier );
            victim thread giverecentshieldxp();
            victim.shieldbullethits = 0;
        }
    }
    
    shieldweapon = victim riotshield::function_1d321a5b69a36090();
    
    if ( idflags & 32 )
    {
        victim.forcehitlocation = "none";
        
        if ( !( idflags & 64 ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
            {
                if ( isdefined( victim.leaderboarddata[ "riotShieldDamageAbsorbed" ] ) )
                {
                    victim.leaderboarddata[ "riotShieldDamageAbsorbed" ] = victim.leaderboarddata[ "riotShieldDamageAbsorbed" ] + idamage;
                }
                
                if ( isdefined( level.leaderboardfunc[ "riotShieldDamageAbsorbed" ] ) )
                {
                    [[ level.leaderboardfunc[ "riotShieldDamageAbsorbed" ] ]]( victim, idamage );
                }
                
                assert( isint( idamage ) || isfloat( idamage ), "<dev string:xe1>" );
                
                if ( isdefined( victim.pers[ "riotShieldDamageAbsorbed" ] ) )
                {
                    victim.pers[ "riotShieldDamageAbsorbed" ] = victim.pers[ "riotShieldDamageAbsorbed" ] + idamage;
                }
            }
            
            idamage = 0;
        }
    }
    else if ( idflags & 128 )
    {
        idamage *= 1 - var_e5bad414cfe9af08;
        victim.forcehitlocation = "none";
        
        if ( victim damage_utility::isstuckdamagekill( data ) )
        {
            idamage = victim.maxhealth;
        }
    }
    else if ( isdefined( eattacker ) && eattacker.dontdamageriotshield )
    {
        return 0;
    }
    else if ( isdefined( shieldweapon ) && shieldweapon.var_3f885093772f94bf > 0 )
    {
        victim.forcehitlocation = "none";
        idamage = int( idamage * shieldweapon.var_3f885093772f94bf );
    }
    else
    {
        return 0;
    }
    
    if ( smeansofdeath == "MOD_MELEE" && weapon_utility::isriotshield( objweapon ) )
    {
        victim stunplayer( 0 );
    }
    
    return idamage;
}

// Namespace damage
// Params 8
// Checksum 0x7301914b, Offset: 0xc7f9
// Size: 0x450
function filterdamage( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, shitloc )
{
    if ( !idamage )
    {
        return "!iDamage";
    }
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return "level.hostMigrationTimer";
    }
    
    eattacker = _validateattacker( eattacker );
    
    if ( !isdefined( eattacker ) && smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_BUMP" && !( isdefined( einflictor ) && einflictor.team == "team_hundred_ninety" ) )
    {
        return "invalid attacker";
    }
    
    victim = _validatevictim( victim );
    
    if ( !isdefined( victim ) )
    {
        return "invalidVictim";
    }
    
    if ( game_utility_mp::getgamestate( eattacker ) == "postgame" && smeansofdeath != "MOD_TRIGGER_HURT" )
    {
        return "game[ state ] == postgame";
    }
    
    if ( victim.sessionteam == "spectator" )
    {
        return "victim.sessionteam == spectator";
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_2752ba35d4ac4156" ) )
    {
        filterresult = utility::callsharedfunc( #"gametype", #"hash_2752ba35d4ac4156", einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc );
        
        if ( filterresult )
        {
            return filterresult;
        }
    }
    
    if ( eattacker === victim && smeansofdeath == "MOD_SUICIDE" && isdefined( victim.var_dd48e9d589417616 ) )
    {
        message = [[ victim.var_dd48e9d589417616 ]]( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, shitloc );
        return message;
    }
    
    if ( isdefined( eattacker ) )
    {
        if ( victim.damageblockedteam == eattacker.team || eattacker.damageblockedteam == victim.team )
        {
            return "damageBlockedTeam";
        }
    }
    
    if ( level.headshotsonly )
    {
        if ( shitloc != "head" && shitloc != "helmet" )
        {
            if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
            {
                return "getTweakableValue( game, onlyheadshots )";
            }
        }
    }
    
    if ( isdefined( level.var_98c776d96ea6e53 ) )
    {
        if ( level.var_98c776d96ea6e53 )
        {
            if ( smeansofdeath == "MOD_MELEE" )
            {
                return "No melee damage in Headhunter";
            }
        }
    }
    
    if ( function_a634b4e081115ab9( eattacker, victim, objweapon ) )
    {
        return "crossbow semtex splash damage on stuckto victim";
    }
    
    if ( smeansofdeath == "MOD_CRUSH" && isdefined( einflictor ) && einflictor vehicle::is_vehicle() && victim vehicle::is_in_vehicle() && !victim utility::isusingremote() )
    {
        return "hitByVehicleWhileInVehicle";
    }
    
    if ( vehicle_collision::function_898c68dd6412f983( einflictor, victim, smeansofdeath, objweapon ) )
    {
        return "vehicle_playerShouldIgnoreCollisionDamage";
    }
    
    if ( vehicle_collision::function_dc1f303123867705( einflictor, victim, smeansofdeath ) )
    {
        return "vehicle_isRubbingAgainstVehicle";
    }
    
    if ( victim.plotarmor )
    {
        return "isTrue( victim.plotArmor )";
    }
    
    if ( victim.takedamage == 0 )
    {
        return "isdefined( victim.takedamage ) && victim.takedamage == false";
    }
    
    if ( player::isinlaststand( victim ) && ( level.laststand_always_disable_damage || victim.var_5eaebe6e973bbb7b ) )
    {
        return "isInLastStand( victim ) && ( IsTrue( level.laststand_always_disable_damage ) || IsTrue( victim.laststandDisableDamage ) )";
    }
    
    if ( br_dom_gulag::function_d6dd699e0c93e705( eattacker, victim ) || br_ai_gulag::function_565227f9fc314fbb( eattacker, victim ) )
    {
        return "isInLastStand( victim ) && IsTrue( level.laststand_always_disable_damage )";
    }
    
    /#
        if ( getdvarint( @"hash_62a47106347dc9c3", 0 ) == 1 )
        {
            return "<dev string:x2fa>";
        }
        
        if ( isdefined( victim.team ) )
        {
            var_361fc5679916438a = getdvarint( hashcat( @"hash_cc6c5774be41ec78", string( victim.team ) ), 0 ) != 0;
            
            if ( var_361fc5679916438a )
            {
                return "<dev string:x30b>";
            }
        }
    #/
    
    pvp_disabled = eattacker.pvpdisabled || victim.pvpdisabled || getdvarint( @"scr_dmz_pve_enabled", 0 );
    
    if ( pvp_disabled && isplayer( eattacker ) && isplayer( victim ) && eattacker != victim )
    {
        return "pvp_disabled";
    }
    
    if ( victim.inlaststand && level.laststandrequiresmelee && smeansofdeath != "MOD_MELEE" )
    {
        return "istrue( victim.inLastStand ) && istrue( level.lastStandRequiresMelee ) && sMeansOfDeath != MOD_MELEE";
    }
    
    if ( idflags & 16 && shitloc != "shield" )
    {
        return "iDFlags & DFLAGS_STUN";
    }
}

// Namespace damage
// Params 12
// Checksum 0xce5cbd7, Offset: 0xcc51
// Size: 0x27e
function logattacker( victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup )
{
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_BUMP" )
    {
        eattacker = victim;
    }
    
    if ( !isdefined( weapongroup ) )
    {
        weapongroup = weapon::getweapongroup( objweapon );
    }
    
    if ( isdefined( eattacker ) )
    {
        if ( isplayer( eattacker ) || isagent( eattacker ) )
        {
            addattacker( victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup );
        }
        
        if ( !isplayer( eattacker ) )
        {
            if ( isdefined( eattacker.owner ) && !eattacker.scrambled )
            {
                addattacker( victim, eattacker.owner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup );
            }
            else if ( isdefined( eattacker.secondowner ) && eattacker.scrambled )
            {
                addattacker( victim, eattacker.secondowner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup );
            }
        }
    }
    
    if ( isdefined( einflictor.owner ) )
    {
        lethalteam = isdefined( einflictor.owner.team ) && einflictor.owner.team != victim.team || level.friendlyfire == 1;
        
        if ( lethalteam && isdefined( einflictor.owner.guid ) && !isdefined( self.attackerdata[ einflictor.owner.guid ] ) )
        {
            addattacker( victim, einflictor.owner, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup );
        }
    }
    
    if ( isplayer( eattacker ) && isdefined( objweapon ) && eattacker != victim )
    {
        eattacker thread weapons::checkhit( objweapon, einflictor, victim, shitloc, idamage, weapongroup, smeansofdeath );
        eattacker thread events::damagedplayer( self, idamage );
        victim.attackerposition = eattacker.origin;
        return;
    }
    
    victim.attackerposition = undefined;
}

// Namespace damage
// Params 11
// Checksum 0xcaefd5f4, Offset: 0xced7
// Size: 0x172
function logattackerkillstreak( victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, objweapon )
{
    if ( isplayer( eattacker ) )
    {
        addattackerkillstreak( victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
    }
    
    if ( isdefined( eattacker ) && !isplayer( eattacker ) && isplayer( eattacker.owner ) && !eattacker.scrambled )
    {
        eattacker = eattacker.owner;
        addattackerkillstreak( victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
    }
    else if ( isdefined( eattacker ) && !isplayer( eattacker ) && isplayer( eattacker.secondowner ) && eattacker.scrambled )
    {
        eattacker = eattacker.secondowner;
        addattackerkillstreak( victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
    }
    
    if ( isplayer( eattacker ) && isdefined( objweapon ) && eattacker != victim )
    {
        victim.attackerposition = eattacker.origin;
        return;
    }
    
    victim.attackerposition = undefined;
}

// Namespace damage
// Params 6
// Checksum 0xb29043ef, Offset: 0xd051
// Size: 0x322
function loggrenadedata( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon )
{
    if ( ( issubstr( smeansofdeath, "MOD_EXPLOSIVE" ) || issubstr( smeansofdeath, "MOD_PROJECTILE" ) ) && isdefined( einflictor ) && isdefined( eattacker ) )
    {
        var_bda53394c108f2e = getcompleteweaponname( objweapon );
        victim.explosiveinfo = [];
        victim.explosiveinfo[ "damageTime" ] = gettime();
        victim.explosiveinfo[ "damageId" ] = einflictor getentitynumber();
        victim.explosiveinfo[ "returnToSender" ] = 0;
        victim.explosiveinfo[ "counterKill" ] = 0;
        victim.explosiveinfo[ "chainKill" ] = 0;
        victim.explosiveinfo[ "cookedKill" ] = 0;
        victim.explosiveinfo[ "throwbackKill" ] = 0;
        victim.explosiveinfo[ "suicideGrenadeKill" ] = 0;
        victim.explosiveinfo[ "weapon" ] = var_bda53394c108f2e;
        isfrag = issubstr( objweapon.basename, "frag_" );
        
        if ( eattacker != victim )
        {
            if ( ( issubstr( objweapon.basename, "c4_" ) || issubstr( objweapon.basename, "proximity_explosive_" ) || issubstr( objweapon.basename, "claymore_" ) ) && isdefined( einflictor.owner ) )
            {
                victim.explosiveinfo[ "returnToSender" ] = einflictor.owner == victim;
                victim.explosiveinfo[ "counterKill" ] = isdefined( einflictor.wasdamaged );
                victim.explosiveinfo[ "chainKill" ] = isdefined( einflictor.waschained );
                victim.explosiveinfo[ "bulletPenetrationKill" ] = isdefined( einflictor.wasdamagedfrombulletpenetration );
                victim.explosiveinfo[ "cookedKill" ] = 0;
            }
            
            if ( eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag )
            {
                victim.explosiveinfo[ "suicideGrenadeKill" ] = 1;
            }
        }
        
        if ( isfrag )
        {
            victim.explosiveinfo[ "cookedKill" ] = isdefined( einflictor.iscooked );
            victim.explosiveinfo[ "throwbackKill" ] = isdefined( einflictor.threwback );
        }
        
        victim.explosiveinfo[ "stickKill" ] = einflictor.isstuck == "enemy";
        victim.explosiveinfo[ "stickFriendlyKill" ] = einflictor.isstuck == "friendly";
        
        if ( isplayer( eattacker ) && eattacker != self && game_utility::getgametype() != "aliens" )
        {
            updateinflictorstat( einflictor, eattacker, objweapon );
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x7e521810, Offset: 0xd37b
// Size: 0x78
function function_e91c31c1d200656d( modifier )
{
    if ( !isdefined( level.damage_feedback ) )
    {
        level.damage_feedback = {};
    }
    
    if ( !isdefined( level.damage_feedback.var_72d82b3e6587ea49 ) )
    {
        level.damage_feedback.var_72d82b3e6587ea49 = [];
    }
    
    level.damage_feedback.var_72d82b3e6587ea49[ level.damage_feedback.var_72d82b3e6587ea49.size ] = modifier;
}

// Namespace damage
// Params 1
// Checksum 0x604ee1f2, Offset: 0xd3fb
// Size: 0x78
function function_6d459163ecf4555d( modifier )
{
    if ( !isdefined( level.damage_feedback ) )
    {
        level.damage_feedback = {};
    }
    
    if ( !isdefined( level.damage_feedback.dflags_modifiers ) )
    {
        level.damage_feedback.dflags_modifiers = [];
    }
    
    level.damage_feedback.dflags_modifiers[ level.damage_feedback.dflags_modifiers.size ] = modifier;
}

// Namespace damage
// Params 14
// Checksum 0xea781be7, Offset: 0xd47b
// Size: 0x1318
function handledamagefeedback( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon, willknockdown, partname, vpoint )
{
    if ( issimulationplayer( eattacker ) || issimulationplayer( victim ) )
    {
        return;
    }
    
    if ( isdefined( victim.handledamagefeedback ) )
    {
        [[ victim.handledamagefeedback ]]( einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon, willknockdown );
        return;
    }
    
    damager = eattacker.owner ?? eattacker;
    typehit = "standard";
    
    if ( isdefined( damager ) && damager != victim && idamage + lightarmordamage + heavyarmordamage > 0 && shitloc != "shield" )
    {
        waskilled = !victim player::isreallyalive() || isagent( victim ) && idamage >= victim.health;
        var_526ac9c190ed7b26 = victim.platecarrierlevel > 2;
        var_7eb39e35adca14f2 = isdefined( victim.perks[ "specialty_tempered" ] ) || victim.platecarriertype == "brloot_plate_carrier_tempered";
        damagecaused = idamage + lightarmordamage + heavyarmordamage;
        var_b344d52b3a59b64c = 0;
        params = spawnstruct();
        params.attacker = eattacker;
        params.victim = victim;
        params.objweapon = objweapon;
        params.hitloc = shitloc;
        params.meansofdeath = smeansofdeath;
        callback::callback( #"player_deal_damage", params );
        
        if ( utility::issharedfuncdefined( #"helmet", #"hash_44c34f9d06050ba7" ) )
        {
            var_b344d52b3a59b64c = utility::callsharedfunc( #"helmet", #"hash_44c34f9d06050ba7", damager );
        }
        
        if ( var_526ac9c190ed7b26 && isdefined( victim.armorhealth ) )
        {
            var_95bb801829c060a0 = victim.armorhealth + damagecaused >= 150;
        }
        
        if ( isdefined( level.var_d4edfe6f6b2f654b ) )
        {
            str_type_hit = self [[ level.var_d4edfe6f6b2f654b ]]( params );
            
            if ( isdefined( str_type_hit ) )
            {
                typehit = str_type_hit;
            }
        }
        else if ( damager.var_82381c5b677c4f5f )
        {
            typehit = damager.var_82381c5b677c4f5f;
            damager.var_82381c5b677c4f5f = undefined;
        }
        else if ( victim.var_9d46480598e68297 )
        {
            typehit = "hitboba";
        }
        else if ( isplayer( eattacker ) && function_a76bfa0c2b49b5c5( eattacker, victim, smeansofdeath, idflags ) )
        {
            typehit = "hitsuppression";
        }
        else if ( victim.inlaststand && isdefined( victim.perks[ "specialty_pistoldeath" ] ) && !victim.hasshownlaststandicon )
        {
            if ( !getdvarint( @"hash_bc8723ca94c64971", 1 ) )
            {
                victim.hasshownlaststandicon = 1;
            }
            
            typehit = "hitlaststand";
        }
        else if ( !isagent( victim ) && victim islaststandinvulnerable() )
        {
            typehit = "hitlaststand";
        }
        else if ( isagent( victim ) && issubstr( victim.agent_type, "jugg" ) )
        {
            switch ( smeansofdeath )
            {
                case #"hash_3c20f39c73a1422b":
                case #"hash_a911a1880d996edb":
                case #"hash_c22b13f81bed11f0":
                    typehit = "hitblastshield";
                    break;
                default:
                    typehit = "hitjuggernaut";
                    break;
            }
        }
        else if ( victim killstreak::function_2512509a946854ce() && !game_utility_mp::isjuggermoshgamemode() )
        {
            if ( victim.isjuggernautrecon )
            {
                typehit = "hitjuggernautrecon";
            }
            else if ( isdefined( victim.var_3743638e74262366.hitmarker ) )
            {
                typehit = victim.var_3743638e74262366.hitmarker;
            }
            else
            {
                typehit = "hitjuggernaut";
            }
        }
        else if ( isdefined( victim.perks[ "rex_consumable_pain_killers" ] ) )
        {
            typehit = "hitpainkiller";
        }
        else if ( isplayer( victim ) && victim ismeatshieldvictim() )
        {
            typehit = "hitbodyshield";
        }
        else if ( victim heavyarmor::hasheavyarmor() || victim heavyarmor::hasheavyarmorinvulnerability() )
        {
            typehit = "hitarmorheavy";
        }
        else if ( idflags & 16 )
        {
            typehit = "stun";
        }
        else if ( hashealthshield( victim ) )
        {
            typehit = "hitarmorlight";
        }
        else if ( var_b344d52b3a59b64c )
        {
            typehit = "hithelmetlightbreak";
        }
        else if ( armor::armorvest_wasbroke( damager ) )
        {
            typehit = "hitarmorlightbreak";
            
            if ( var_526ac9c190ed7b26 )
            {
                typehit = "hitarmormaxplatebreak";
            }
            
            if ( var_7eb39e35adca14f2 )
            {
                typehit = "hitarmortemperedbreak";
            }
            
            if ( self.bossinstance.bundle.islieutenant )
            {
                typehit = "hitarmorlieutenantbreak";
            }
            
            if ( isdefined( victim.perks[ "specialty_reactive_armor" ] ) )
            {
                damager namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_reactive_armor", 1 );
                victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_reactive_armor" );
            }
        }
        else if ( isdefined( victim.perks[ "specialty_durability" ] ) )
        {
            typehit = "hitdurability";
        }
        else if ( function_baa09a9e75d8726c( eattacker, victim ) || victim.var_c19506b543ae5021 && iskillstreakweapon && !weapon::weaponbypassspawnprotection( objweapon, einflictor.streakname ) )
        {
            typehit = "hitspawnprotect";
        }
        else if ( helmet_wasbroke( damager ) )
        {
            typehit = "hithelmetlightbreak";
        }
        else if ( istacticaldamage( objweapon, smeansofdeath ) && ( isdefined( victim.perks[ "specialty_stun_resistance" ] ) || isdefined( victim.perks[ "specialty_veteran" ] ) ) )
        {
            if ( isdefined( victim.perks[ "specialty_veteran" ] ) )
            {
                damager namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran", 1 );
                victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
            }
        }
        else if ( armor::armorvest_washit( damager ) )
        {
            typehit = "hitarmorlight";
            
            if ( ( getdvarint( @"hash_2f7767a2a092ce1a", 0 ) || !getdvarint( @"hash_f786619a1f55409f", 0 ) ) && var_526ac9c190ed7b26 )
            {
                typehit = "hitarmorlightmaxlevel";
            }
            
            if ( var_7eb39e35adca14f2 )
            {
                typehit = "hitarmorlighttempered";
            }
            
            if ( self.bossinstance.bundle.islieutenant )
            {
                typehit = "hitarmorlieutenant";
            }
        }
        else if ( helmet_washit( damager ) )
        {
            typehit = "hithelmetlight";
        }
        else if ( lightarmordamage > 0 )
        {
            typehit = "hitarmorlight";
        }
        else if ( isdefined( victim.perks[ "specialty_close_quarter" ] ) && ( smeansofdeath == "MOD_MELEE" || weapon::function_e1a6c47f66c6de20( objweapon ) || weapon::isthrowingstar( objweapon ) ) )
        {
            typehit = "hitcqc";
        }
        else if ( isdefined( victim.perks[ "specialty_regen_delay_reduced" ] ) )
        {
            typehit = "hitquickfix";
        }
        else if ( victim.battlerageactive )
        {
            typehit = "hitbattlerage";
        }
        else if ( perkfunctions::function_9a4f085a6e6f1eef( victim, damager ) )
        {
            perkfunctions::function_f248ab44cf241b4( victim, damager );
            typehit = "hitresolute";
        }
        else if ( utility::callsharedfunc( #"perk_resolute", #"shouldshowhitmarker", victim, eattacker ) )
        {
            typehit = "hitresolute";
        }
        else if ( isdefined( victim.perks[ "specialty_bomb_squad" ] ) && !utility::callsharedfunc( #"specialty_blastshield", #"hash_4caa4d716053e6b8", eattacker, victim, objweapon, smeansofdeath, einflictor, shitloc ) )
        {
            damager namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_bomb_squad", 1 );
            victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_bomb_squad" );
        }
        else if ( isdefined( victim.perks[ "specialty_blastshield" ] ) && ![[ utility::getsharedfunc( #"specialty_blastshield", #"hash_4caa4d716053e6b8" ) ]]( eattacker, victim, objweapon, smeansofdeath, einflictor, shitloc ) )
        {
            if ( isdefined( victim.perks[ "specialty_flak_jacket" ] ) )
            {
                typehit = "hitflakjacket";
            }
            else
            {
                typehit = "hitblastshield";
            }
        }
        else if ( victim.adrenalinepoweractive )
        {
            typehit = "hitadrenaline";
        }
        else if ( isdefined( objweapon ) && objweapon.basenamehash == %"sound_veil_mp" )
        {
            typehit = "hitsoundveil";
        }
        else if ( getdvarint( @"hash_1db87c3b655b5645", 0 ) == 1 )
        {
            typehit = "hithealth";
        }
        
        foreach ( modifier in level.damage_feedback.var_72d82b3e6587ea49 )
        {
            newhittype = [[ modifier ]]( typehit, { #damager:damager, #partname:partname, #willknockdown:willknockdown, #iskillstreakweapon:iskillstreakweapon, #heavyarmordamage:heavyarmordamage, #lightarmordamage:lightarmordamage, #idflags:idflags, #shitloc:shitloc, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idamage:idamage, #victim:victim, #eattacker:eattacker, #einflictor:einflictor } );
            
            if ( newhittype )
            {
                typehit = newhittype;
                break;
            }
        }
        
        eattacker common::function_6b65663570bf5d41();
        
        if ( smeansofdeath == "MOD_MELEE" && willknockdown && victim.health >= 0 )
        {
            if ( eattacker.var_c7749ae3ff81978f )
            {
                eattacker thread [[ eattacker.var_c7749ae3ff81978f ]]( victim );
            }
            else
            {
                eattacker points::doscoreevent( #"hash_7a71b7e91e7062c4" );
            }
        }
        
        bulletdamage = utility::isbulletdamage( smeansofdeath );
        hitmarkertype = bulletdamage && weapon::isprimaryweapon( objweapon ) ? "standardspread" : "standard";
        
        if ( level.skydive_spawnprotectionactive )
        {
            if ( bulletdamage && victim.skydive_spawnprotection || isexplosivedamagemod( smeansofdeath ) && victim.var_a422b89d7d7aa4f1 )
            {
                typehit = "hitskydiveprotection";
            }
        }
        
        armorbreak = 0;
        
        if ( typehit == "hitarmorlightbreak" || typehit == "hitarmormaxplatebreak" || typehit == "hitarmortemperedbreak" )
        {
            armorbreak = 1;
            
            if ( var_7eb39e35adca14f2 )
            {
                hitmarkertype = "temperedarmorbreak";
            }
            else if ( var_526ac9c190ed7b26 )
            {
                hitmarkertype = "threeplatearmorbreak";
            }
            else if ( hitmarkertype == "standardspread" )
            {
                hitmarkertype = "standardspreadarmorbreak";
            }
            else
            {
                hitmarkertype = "standardarmorbreak";
            }
        }
        else if ( typehit == "hitarmorlight" || typehit == "hitarmorlightmaxlevel" || typehit == "hitarmorlighttempered" )
        {
            if ( var_7eb39e35adca14f2 )
            {
                hitmarkertype = "temperedarmor";
            }
            else if ( var_526ac9c190ed7b26 )
            {
                hitmarkertype = "threeplatearmor";
            }
            else if ( hitmarkertype == "standardspread" )
            {
                hitmarkertype = "standardspreadarmor";
            }
            else
            {
                hitmarkertype = "standardarmor";
            }
        }
        else if ( typehit == "hitflakjacket" )
        {
            hitmarkertype = "hitflakjacket";
        }
        
        if ( typehit == "hitohkprotect" )
        {
            hitmarkertype = "hitohkprotect";
        }
        
        if ( willknockdown && !waskilled )
        {
            hitmarkertype = "hitknockdown";
        }
        
        isspreadweapon = isspreadweapon( objweapon );
        
        if ( isdefined( objweapon ) )
        {
            if ( objweapon hasattachment( "t10_bar_db_ar_love85" ) || objweapon hasattachment( "sat_stock_lever_sh_corso" ) || objweapon hasattachment( "sat_ammo_spread_sm_orca" ) )
            {
                isspreadweapon = 0;
            }
        }
        
        headshot = !isspreadweapon && damage_utility::isheadshot( shitloc, smeansofdeath, eattacker );
        
        if ( weapon::isthrowingstar( objweapon ) && damage_utility::function_5d1c04cbc4da6bc4( partname ) )
        {
            headshot = 1;
        }
        
        if ( headshot && isdefined( eattacker.perks[ "specialty_headhunter" ] ) )
        {
            typehit = "hitheadhunter";
        }
        
        allowdamagefeedback = 1;
        var_8de3951ebaac8431 = damagefeedback::isusingstackablehitmarker();
        suppressaudio = var_8de3951ebaac8431 ? 0 : smeansofdeath == "MOD_MELEE";
        victimentnum = victim getentitynumber();
        
        if ( waskilled && isdefined( victim.body ) )
        {
            targetentnum = victim.body getentitynumber();
        }
        else
        {
            targetentnum = victimentnum;
        }
        
        var_b19df35a7ba9c1cf = 0;
        
        if ( !armorbreak && isspreadweapon && isdefined( damager.pelletweaponvictimids ) )
        {
            foreach ( var_b8039407bae95f2a in damager.pelletweaponvictimids )
            {
                if ( isdefined( var_b8039407bae95f2a[ victimentnum ] ) && var_b8039407bae95f2a[ victimentnum ].pelletdmgpassed.size > 1 )
                {
                    var_b19df35a7ba9c1cf = 1;
                    break;
                }
            }
        }
        
        isweaponkillstreak = weapon::iskillstreakweaponname( objweapon.basename );
        
        if ( !isweaponkillstreak && isplayer( damager ) )
        {
            explosiveweapon = weapon_utility::function_c1972d0d01397a22( objweapon ) || weapon_utility::isgrenadeweapon( objweapon );
            
            if ( isspreadweapon ? !var_b19df35a7ba9c1cf && bulletdamage : bulletdamage || explosiveweapon )
            {
                var_ca2a15979675aa9b = 0;
                
                if ( true )
                {
                }
                else if ( isspreadweapon || explosiveweapon )
                {
                    weaponbasename = objweapon.basename;
                    
                    if ( !isdefined( weaponbasename ) )
                    {
                        var_ca2a15979675aa9b = 1;
                    }
                    else
                    {
                        if ( !isdefined( damager.lasthittime[ objweapon.basename ] ) )
                        {
                            damager.lasthittime[ objweapon.basename ] = 0;
                        }
                        
                        if ( damager.lasthittime[ objweapon.basename ] == gettime() )
                        {
                            var_ca2a15979675aa9b = 1;
                        }
                        else
                        {
                            damager.lasthittime[ objweapon.basename ] = gettime();
                        }
                    }
                }
                
                if ( !var_ca2a15979675aa9b )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( damager ) ) )
                    {
                        if ( isdefined( damager.leaderboarddata[ "shotsBulletHit" ] ) )
                        {
                            damager.leaderboarddata[ "shotsBulletHit" ] = damager.leaderboarddata[ "shotsBulletHit" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "shotsBulletHit" ] ) )
                        {
                            [[ level.leaderboardfunc[ "shotsBulletHit" ] ]]( damager, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( damager.pers[ "shotsBulletHit" ] ) )
                        {
                            damager.pers[ "shotsBulletHit" ] = damager.pers[ "shotsBulletHit" ] + 1;
                        }
                    }
                    
                    totalshots = damager.pers[ "shotsFired" ] ?? 0;
                    bullethits = damager.pers[ "shotsBulletHit" ] ?? 0;
                    shotAccuracy = bullethits / max( totalshots, 1 ) * 100;
                    damager thread gameplay_telemetry::function_f98fbe3bbb2ed9f1( "shotAccuracy", 1, shotAccuracy, 0 );
                    
                    if ( damager gameplay_telemetry_utils::function_944c6d9098e40dfb( victim ) )
                    {
                        if ( !isagent( victim ) )
                        {
                            weaponname = objweapon.basename;
                            var_f485a2c9a458e19a = damager.pers[ "weap_shotFired" ][ weaponname ] ?? 0;
                            
                            if ( !isdefined( damager.pers[ "weap_shotHit" ][ weaponname ] ) )
                            {
                                damager.pers[ "weap_shotHit" ][ weaponname ] = 0;
                            }
                            
                            damager.pers[ "weap_shotHit" ][ weaponname ]++;
                            shothit = damager.pers[ "weap_shotHit" ][ weaponname ];
                            var_cef9affae1f4ddd3 = shothit / max( var_f485a2c9a458e19a, 1 ) * 100;
                            damager thread gameplay_telemetry::function_83a6a8db9fcbb065( "weap_accuracy", objweapon.basename, 3, var_cef9affae1f4ddd3 );
                        }
                    }
                }
            }
        }
        
        if ( !suppressaudio && var_b19df35a7ba9c1cf )
        {
            var_318889068963b7d1 = victim.inlaststand && !victim.hasshownlaststandicon && getdvarint( @"hash_bc8723ca94c64971", 1 );
            
            if ( waskilled || armorbreak || var_318889068963b7d1 || willknockdown )
            {
                suppressaudio = 1;
            }
            else
            {
                allowdamagefeedback = 0;
            }
        }
        
        if ( typehit == "hitlaststand" && getdvarint( @"hash_bc8723ca94c64971", 1 ) )
        {
            victim.hasshownlaststandicon = 1;
        }
        
        if ( allowdamagefeedback && isplayer( damager ) )
        {
            if ( var_8de3951ebaac8431 )
            {
                if ( isplayer( victim ) || isagent( victim ) )
                {
                    var_c3b5e08c98a28e3a = isweaponkillstreak && ( damager utility::isusingremote() || weapon::function_1344ad15d2d7bd21( objweapon ) );
                    var_795e8a31194a39ac = damagefeedback::function_63bdec1d3fd95d25( isfriendlyfire( victim, damager ), victim, bulletdamage, objweapon, smeansofdeath == "MOD_EXECUTION", smeansofdeath == "MOD_EXPLOSIVE_BULLET", isweaponkillstreak, var_c3b5e08c98a28e3a, einflictor );
                    var_795e8a31194a39ac.isenemydown = victim.inlaststand && !victim.var_f8fd1ec1961e390c;
                    
                    if ( var_795e8a31194a39ac.isenemydown )
                    {
                        victim.var_f8fd1ec1961e390c = 1;
                    }
                    
                    hitmarkercategory = damagefeedback::function_a2c239c0552433dd( eattacker, objweapon, smeansofdeath, bulletdamage, isweaponkillstreak, weapon::isprimaryweapon( objweapon ), 0, var_c3b5e08c98a28e3a );
                }
            }
            
            armorPlateCount = armor::function_88bd3cd8729867e4( victim armor::getarmorhealth() + lightarmordamage );
            damager damagefeedback::updatedamagefeedback( typehit, waskilled, headshot, hitmarkertype, suppressaudio, undefined, targetentnum, armorPlateCount, var_795e8a31194a39ac ?? {}, undefined, victim armor::function_4514dcf3d65e7af0(), hitmarkercategory );
            
            if ( damage_numbers::is_enabled() && isplayer( eattacker ) && ( damage_numbers::function_c50b200b96c4c3a1() && isplayer( victim ) || damage_numbers::function_32fd7475ab012d6f() && isagent( victim ) ) && isdefined( vpoint ) )
            {
                damage_numbers::display( eattacker, victim, undefined, smeansofdeath, objweapon, damagecaused, vpoint, 0, 0, waskilled, 0 );
            }
        }
    }
}

// Namespace damage
// Params 8
// Checksum 0x29bdcfe1, Offset: 0xe79b
// Size: 0x5e
function handledamageeffects( idamage, einflictor, eattacker, victim, smeansofdeath, vpoint, lightarmordamage, objweapon )
{
    damage_effects::playerdamageeffects( idamage, einflictor, eattacker, victim, smeansofdeath, vpoint, lightarmordamage, objweapon, undefined );
}

// Namespace damage
// Params 7
// Checksum 0xc47dcd3, Offset: 0xe801
// Size: 0x212
function lethalequipmentdamagemod( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon )
{
    data = damage_utility::packdamagedata( eattacker, victim, idamage, objweapon, smeansofdeath, einflictor, undefined, undefined, undefined, undefined, undefined, undefined, idflags );
    
    if ( isdefined( einflictor ) && isdefined( einflictor.damagedby ) )
    {
        eattacker = einflictor.damagedby;
    }
    
    if ( victim damage_utility::isstuckdamagekill( data ) && !einflictor.bundle.var_1d0cfac68a99662f )
    {
        if ( victim killstreak::isjuggernaut() )
        {
            idamage = min( 300, idamage );
        }
        else if ( einflictor.bundle.var_223e0db0df10c803 || einflictor.bundle.var_6b2d2d42e2a81cd5 )
        {
            if ( !isdefined( victim.perks[ "specialty_blastshield" ] ) )
            {
                if ( isdefined( victim.maxarmorhealth ) )
                {
                    idamage = victim.maxhealth + victim.maxarmorhealth;
                }
                else
                {
                    idamage = victim.maxhealth;
                }
            }
        }
        else if ( isdefined( victim.maxarmorhealth ) )
        {
            idamage = victim.maxhealth + victim.maxarmorhealth;
        }
        else
        {
            idamage = victim.maxhealth;
        }
    }
    
    if ( isdefined( smeansofdeath ) && smeansofdeath != "MOD_IMPACT" )
    {
        if ( isdefined( eattacker ) && isdefined( einflictor ) && isdefined( victim.lastspawnpoint ) && victim != eattacker && einflictor.classname == "grenade" && victim.lastspawntime + 3500 > gettime() && distance( einflictor.origin, victim.lastspawnpoint.origin ) < 500 )
        {
            idamage = 0;
        }
    }
    
    return idamage;
}

// Namespace damage
// Params 1
// Checksum 0xcefff43d, Offset: 0xea1c
// Size: 0x4a
function function_b75cdec2204b8d80( meansofdeath )
{
    if ( meansofdeath == "MOD_MEATSHIELD" )
    {
        return getdvarfloat( @"hash_e92481ac2616c9c1", 2.5 );
    }
    
    return getdvarfloat( @"scr_death_scene_time", level.gamemodebundle.deathcamtime );
}

// Namespace damage
// Params 12
// Checksum 0x257929d2, Offset: 0xea6f
// Size: 0x302
function playerkilled_initdeathdata( inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath )
{
    if ( level.gametypebundle.var_bbd2c6a749097357 )
    {
        script::function_f82d6641490331a9();
    }
    
    deathdata = damage_utility::packdamagedata( attacker, victim, damage, objweapon, meansofdeath, inflictor, undefined, direction_vec, undefined, undefined, undefined, undefined, damageflags, undefined, hitloc );
    deathdata.psoffsettime = psoffsettime;
    deathdata.deathanimduration = deathanimduration;
    deathdata.isfauxdeath = isfauxdeath;
    deathdata.weapongroup = weapon::getweapongroup( objweapon );
    
    if ( meansofdeath == "MOD_EXECUTION" )
    {
        deathdata.executionref = execution::execution_getrefbyplayer( attacker );
    }
    
    if ( !isdefined( deathdata.victim.streaktype ) )
    {
        deathdata.victim.streaktype = "assault";
    }
    
    deathdata.dokillcam = 0;
    deathdata.dofinalkillcam = 1;
    deathdata.killcamentity = undefined;
    deathdata.killcamentityindex = -1;
    deathdata.killcamentitystarttime = 0;
    deathdata.inflictoragentinfo = undefined;
    deathdata.killcamentstickstovictim = undefined;
    deathdata.isfriendlyfire = undefined;
    deathdata.primaryweapon = undefined;
    deathdata.lifeid = undefined;
    deathdata.attackerentnum = undefined;
    deathdata.iskillstreakweapon = undefined;
    deathdata.var_2064b425f9abe07c = undefined;
    deathdata.weaponfullstring = undefined;
    deathdata.isnukekill = 0;
    deathdata.deathscenetimesec = function_b75cdec2204b8d80( meansofdeath );
    deathdata.deathscenetimems = int( deathdata.deathscenetimesec * 1000 );
    deathdata.deathtime = gettime();
    deathdata.brvictiminlaststand = undefined;
    deathdata.attackerlastspawntime = undefined;
    
    if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
    {
        logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_initDeathData - init - deathData.doKillcam=" + deathdata.dokillcam );
    }
    
    if ( isplayer( victim ) )
    {
        deathdata.heldoffhand = victim getheldoffhand();
        deathdata.var_2ce16cf2dc2c23b5 = !isnullweapon( deathdata.heldoffhand );
        deathdata.var_49082f50a1e5e854 = istrue( victim.var_49082f50a1e5e854 );
    }
    
    if ( victim ui_bot::function_9f76c7655b16ed66() )
    {
        deathdata.var_9f76c7655b16ed66 = 1;
    }
    
    return deathdata;
}

// Namespace damage
// Params 1
// Checksum 0x8e8eb9bb, Offset: 0xed7a
// Size: 0x2ff
function playerkilled_parameterfixup( deathdata )
{
    assert( deathdata.victim.sessionteam != "<dev string:x31e>" );
    
    if ( isdefined( deathdata.inflictor ) && deathdata.inflictor.isracecar )
    {
        deathdata.meansofdeath = "MOD_CRUSH";
        deathdata.attacker = deathdata.inflictor;
        deathdata.attacker.team = team_utility::getotherteam( deathdata.victim.team );
    }
    
    if ( isdefined( deathdata.attacker ) )
    {
        deathdata.attackerlastspawntime = deathdata.attacker.lastspawntime;
    }
    
    if ( deathdata.victim == deathdata.attacker && deathdata.meansofdeath == "MOD_CRUSH" )
    {
        deathdata.meansofdeath = "MOD_SUICIDE";
    }
    
    if ( deathdata.objweapon.basename == "none" )
    {
        if ( isdefined( deathdata.inflictor ) && isdefined( deathdata.inflictor.baseweapon ) )
        {
            deathdata.objweapon.basename = deathdata.inflictor.baseweapon;
        }
    }
    
    deathdata.victim playerkilled_fixupattacker( deathdata );
    
    if ( damage_utility::isheadshot( deathdata.hitloc, deathdata.meansofdeath, deathdata.attacker ) )
    {
        deathdata.meansofdeath = "MOD_HEAD_SHOT";
    }
    
    if ( deathdata.isfauxdeath )
    {
        deathdata.dokillcam = 0;
        deathdata.deathanimduration = deathdata.victim playerforcedeathanim( deathdata.inflictor, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.direction_vec );
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "playerKilled_parameterFixup - deathData.isFauxDeat - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
    
    if ( deathdata.victim.var_9cf07436884eef22 )
    {
        deathdata.idflags |= 8;
        deathdata.victim.var_9cf07436884eef22 = undefined;
    }
    
    /#
        function_ce51453a1aabf1be( deathdata );
    #/
}

// Namespace damage
// Params 1
// Checksum 0x4b346fae, Offset: 0xf081
// Size: 0xb62
function playerkilled_fixupattacker( deathdata )
{
    deathdata.attacker = _validateattacker( deathdata.attacker );
    victim = deathdata.victim;
    
    if ( deathdata.inflictor.isracecar )
    {
        if ( isdefined( level.var_7934054faf656061 ) )
        {
            deathdata.attacker = [[ level.var_7934054faf656061 ]]( deathdata.inflictor, victim );
        }
    }
    
    assistedsuicide = 0;
    
    if ( !isdefined( deathdata.attacker ) )
    {
        assistedsuicide = 1;
    }
    else if ( isdefined( deathdata.attacker.classname ) && ( deathdata.attacker.classname == "trigger_hurt" || deathdata.attacker.classname == "worldspawn" ) )
    {
        assistedsuicide = 1;
    }
    else if ( deathdata.attacker == victim )
    {
        assistedsuicide = 1;
        
        if ( deathdata.meansofdeath == "MOD_SUICIDE" )
        {
            logattacker( victim, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.damage, undefined, undefined, deathdata.hitloc, deathdata.psoffsettime, deathdata.meansofdeath, 0 );
        }
    }
    else if ( train_utility::is_train_ent( deathdata.attacker ) )
    {
        assistedsuicide = 1;
    }
    
    if ( assistedsuicide )
    {
        bestplayer = undefined;
        
        foreach ( player in victim.attackers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isdefined( _validateattacker( player ) ) )
            {
                continue;
            }
            
            if ( !isdefined( victim.attackerdata[ player.guid ].damage ) )
            {
                continue;
            }
            
            if ( player == victim || level.teambased && player.team == victim.team )
            {
                continue;
            }
            
            if ( isdefined( bestplayer ) )
            {
                bestplayer = victim.attackerdata[ player.guid ].damage > victim.attackerdata[ bestplayer.guid ].damage ? player : bestplayer;
                continue;
            }
            
            if ( victim.attackerdata[ player.guid ].damage > 1 )
            {
                bestplayer = player;
            }
        }
        
        if ( !isdefined( bestplayer ) )
        {
            if ( isdefined( victim.debuffedbyplayers ) && victim.debuffedbyplayers.size > 0 )
            {
                debuffweapons = [ "chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp" ];
                
                foreach ( debuffweapon in debuffweapons )
                {
                    debuffattackers = gamescore::getdebuffattackersbyweapon( victim, debuffweapon );
                    
                    if ( debuffattackers.size > 0 )
                    {
                        for ( i = debuffattackers.size - 1; i >= 0 ; i-- )
                        {
                            debuffattacker = debuffattackers[ i ];
                            
                            if ( utility::callsharedfunc( #"gametype", #"hash_eac27f8466f4fff2", victim, debuffattacker ) )
                            {
                                continue;
                            }
                            
                            if ( !isdefined( _validateattacker( debuffattacker ) ) )
                            {
                                continue;
                            }
                            
                            if ( !player_utility::playersareenemies( debuffattacker, victim ) )
                            {
                                continue;
                            }
                            
                            bestplayer = debuffattacker;
                            
                            if ( !( isdefined( victim.attackerdata ) && isdefined( victim.attackerdata[ bestplayer.guid ] ) ) )
                            {
                                addattacker( victim, bestplayer, undefined, makeweapon( debuffweapon ), 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE" );
                            }
                            
                            break;
                        }
                    }
                    
                    if ( isdefined( bestplayer ) )
                    {
                        break;
                    }
                }
            }
        }
        
        if ( isdefined( bestplayer ) )
        {
            deathdata.attacker = bestplayer;
            deathdata.attacker.assistedsuicide = 1;
            deathdata.objweapon = victim.attackerdata[ bestplayer.guid ].objweapon;
            deathdata.direction_vec = victim.attackerdata[ bestplayer.guid ].vdir;
            deathdata.hitloc = victim.attackerdata[ bestplayer.guid ].shitloc;
            deathdata.psoffsettime = victim.attackerdata[ bestplayer.guid ].psoffsettime;
            deathdata.meansofdeath = victim.attackerdata[ bestplayer.guid ].smeansofdeath;
            deathdata.damage = victim.attackerdata[ bestplayer.guid ].damage;
            
            if ( victim.squadwiped && isdefined( victim.attackerdata[ bestplayer.guid ].inflictor ) )
            {
                deathdata.inflictor = victim.attackerdata[ bestplayer.guid ].inflictor;
            }
            
            deathdata.assistedsuicide = 1;
        }
        else if ( !isdefined( deathdata.attacker.team ) || deathdata.attacker.team == "neutral" )
        {
            deathdata.attacker = victim;
        }
    }
    else
    {
        einflictor = deathdata.inflictor.owner ?? deathdata.inflictor;
        
        if ( deathdata.meansofdeath == "MOD_SUICIDE" && isplayer( einflictor ) && victim != einflictor )
        {
            lethalteam = einflictor.team != victim.team || level.friendlyfire == 1;
            
            if ( lethalteam && isdefined( einflictor.guid ) && !isdefined( self.attackerdata[ einflictor.guid ] ) )
            {
                weapongroup = weapon::getweapongroup( deathdata.objweapon );
                lightarmordamage = 0;
                addattacker( victim, einflictor, deathdata.inflictor, deathdata.objweapon, deathdata.damage, undefined, undefined, deathdata.hitloc, deathdata.psoffsettime, deathdata.meansofdeath, lightarmordamage, weapongroup );
            }
        }
    }
    
    if ( isdefined( deathdata.attacker ) && isdefined( deathdata.attacker.code_classname ) )
    {
        if ( deathdata.attacker.code_classname == "script_vehicle" && isdefined( deathdata.attacker.owner ) )
        {
            deathdata.attacker = deathdata.attacker.owner;
        }
        
        if ( deathdata.attacker.code_classname == "misc_turret" && isdefined( deathdata.attacker.owner ) )
        {
            if ( isdefined( deathdata.attacker.vehicle ) )
            {
                deathdata.attacker.vehicle notify( #"hash_7a7b0522d300a665", victim );
            }
            
            deathdata.attacker = deathdata.attacker.owner;
        }
        
        if ( isagent( deathdata.attacker ) )
        {
            if ( isdefined( deathdata.attacker.owner ) )
            {
                deathdata.attacker = deathdata.attacker.owner;
            }
        }
        
        if ( deathdata.attacker.code_classname == "script_model" && isdefined( deathdata.attacker.owner ) )
        {
            deathdata.attacker = deathdata.attacker.owner;
            
            if ( !isfriendlyfire( victim, deathdata.attacker ) && deathdata.attacker != victim )
            {
                deathdata.attacker notify( #"crushed_enemy" );
            }
        }
    }
    
    if ( isdefined( deathdata.inflictor ) && !isplayer( deathdata.inflictor ) )
    {
        if ( !isdefined( deathdata.attacker ) )
        {
            if ( isdefined( deathdata.inflictor.owner ) )
            {
                deathdata.attacker = deathdata.inflictor.owner;
            }
        }
        else if ( !isplayer( deathdata.attacker ) )
        {
            if ( isdefined( deathdata.inflictor.owner ) )
            {
                deathdata.attacker = deathdata.inflictor.owner;
            }
        }
    }
    
    if ( isdefined( deathdata.attacker ) && deathdata.attacker != victim )
    {
        if ( deathdata.inflictor == victim )
        {
            deathdata.inflictor = deathdata.attacker;
        }
    }
    
    if ( isdefined( deathdata.inflictor ) && isdefined( deathdata.inflictor.burndownattacker ) && !player_utility::playersareenemies( victim, deathdata.inflictor.burndownattacker ) )
    {
        deathdata.attacker = self;
    }
    
    deathdata.attacker.assistedsuicide = 0;
}

// Namespace damage
// Params 1
// Checksum 0x7247c99c, Offset: 0xfbeb
// Size: 0x2bd
function playerkilled_precalc( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    inflictor = deathdata.inflictor;
    objweapon = deathdata.objweapon;
    victim.perkoutlined = 0;
    victim.deathspectatepos = undefined;
    victim.deathtime = deathdata.deathtime;
    victim.attacker = attacker;
    victim.lastdeathpos = victim.origin;
    victim.lastdeathangles = victim getplayerangles();
    
    if ( isdefined( inflictor ) && isdefined( inflictor.primaryweapon ) && !isplayer( inflictor ) )
    {
        deathdata.primaryweapon = inflictor.primaryweapon;
    }
    else if ( isplayer( attacker ) && !isnullweapon( attacker getcurrentprimaryweapon() ) )
    {
        deathdata.primaryweapon = getcompleteweaponname( attacker getcurrentprimaryweapon() );
    }
    else if ( objweapon.isalternate )
    {
        deathdata.primaryweapon = weapon::getweaponname( objweapon );
    }
    else
    {
        deathdata.primaryweapon = undefined;
    }
    
    deathdata.lifeid = victim.matchdatalifeindex;
    
    if ( !isdefined( deathdata.lifeid ) )
    {
        deathdata.lifeid = level.maxlives - 1;
    }
    
    if ( game_utility_common::isgameparticipant( attacker ) )
    {
        deathdata.attackerentnum = attacker getentitynumber();
    }
    else if ( attacker.playerkilled_forcekillcam && game_utility_common::isgameparticipant( victim ) )
    {
        deathdata.attackerentnum = victim getentitynumber();
    }
    else
    {
        deathdata.attackerentnum = -1;
    }
    
    deathdata.iskillstreakweapon = weapon::iskillstreakweapon( objweapon );
    deathdata.var_1344ad15d2d7bd21 = deathdata.iskillstreakweapon && weapon::function_1344ad15d2d7bd21( objweapon );
    deathdata.weaponfullstring = getcompleteweaponname( objweapon );
    deathdata.var_2064b425f9abe07c = objweapon.basenamehash == %"bomb_site_mp";
    deathdata.isfriendlyfire = isfriendlyfire( victim, attacker );
    deathdata.isnukekill = objweapon.basenamehash == %"nuke_mp";
    deathdata.brvictiminlaststand = player::isinlaststand( victim );
    
    /#
        function_b042fa22e449387d( deathdata );
    #/
}

// Namespace damage
// Params 1
// Checksum 0x2ece1a9d, Offset: 0xfeb0
// Size: 0x88, Type: bool
function function_2786fa8e2c98141a( deathdata )
{
    if ( level.skip_death_vo )
    {
        return false;
    }
    
    response = callback::response( 1, #"hash_bca0fca284613568", { #deathdata:deathdata } );
    
    if ( response )
    {
        return false;
    }
    
    if ( deathdata.isnukekill )
    {
        return false;
    }
    
    if ( deathdata.meansofdeath == "MOD_EXECUTION" )
    {
        return false;
    }
    
    if ( deathdata.meansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 1
// Checksum 0xaca1c216, Offset: 0xff41
// Size: 0x1663
function playerkilled_sharedlogic_early( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    inflictor = deathdata.inflictor;
    objweapon = deathdata.objweapon;
    damage = deathdata.damage;
    meansofdeath = deathdata.meansofdeath;
    isfauxdeath = deathdata.isfauxdeath;
    hitloc = deathdata.hitloc;
    direction_vec = deathdata.direction_vec;
    
    if ( attacker.fireteam && arraycontains( attacker.fireteam, inflictor ) )
    {
        var_c3c9e6f032846bdb = 1;
    }
    
    points::function_a4d7e6250c59331e( victim );
    victim notify( #"killed_player" );
    
    if ( victim gameplay_telemetry_utils::function_ab5801f54c55eee8( 3 ) )
    {
        victim gameplay_telemetry::function_383cde919fd850c4( "operatorDeaths", 3 );
        operatorkill = victim gameplay_telemetry::function_42040e5fa41218b3( "operatorKills" );
        operatordeath = victim gameplay_telemetry::function_42040e5fa41218b3( "operatorDeaths" );
        operatorkd = operatorkill / max( operatordeath, 1 );
        victim thread gameplay_telemetry::function_f98fbe3bbb2ed9f1( "operatorKD", 3, operatorkd, 0 );
        currweapname = victim getcurrentweapon().basename;
        victim gameplay_telemetry::function_3b8d40426c725ea0( "weap_deaths", currweapname, 3 );
        weapondeath = victim gameplay_telemetry::function_42040e5fa41218b3( "weap_deaths", currweapname );
        weaponkill = victim gameplay_telemetry::function_42040e5fa41218b3( "weap_kills", currweapname );
        weaponkd = weaponkill / max( weapondeath, 1 );
        victim thread gameplay_telemetry::function_83a6a8db9fcbb065( "weap_kdratio", currweapname, 3, weaponkd, 0 );
    }
    
    outline::outlinedisableinternalall( victim );
    
    if ( !victim.juggcontext.var_af0e1deab5671dfa )
    {
        victim damage_effects::ondeatheffects();
        victim setblurforplayer( 0, 0 );
        
        if ( utility::issharedfuncdefined( #"molotov", #"onplayerkilled" ) )
        {
            [[ utility::getsharedfunc( #"molotov", #"onplayerkilled" ) ]]();
        }
        
        victim damage_effects::clearburning();
    }
    
    /#
        if ( !game_utility_mp::runleanthreadmode() )
        {
            print::printgameaction( "<dev string:x328>", victim );
        }
    #/
    
    victim launchshield( damage, meansofdeath );
    victim riotshield::riotshield_clear();
    
    if ( meansofdeath == "MOD_EXECUTION" )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "executionKills" ] ) )
            {
                attacker.leaderboarddata[ "executionKills" ] = attacker.leaderboarddata[ "executionKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "executionKills" ] ) )
            {
                [[ level.leaderboardfunc[ "executionKills" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
            
            if ( isdefined( attacker.pers[ "executionKills" ] ) )
            {
                attacker.pers[ "executionKills" ] = attacker.pers[ "executionKills" ] + 1;
            }
        }
        
        level thread battlechatter_mp::trysaylocalsound( attacker, #"bc_combat_action_execution", 1 );
    }
    
    if ( victim playerkilled_washitbyvehicle( meansofdeath, inflictor ) )
    {
        inflictor notify( #"vehicle_killed_player" );
    }
    
    victimheldweapon = victim getcurrentweapon();
    
    if ( !victim weapon::iskillstreakweaponname( victimheldweapon.basename ) )
    {
        weapons::savetogglescopestates();
        weapons::savealtstates();
        weapons::function_7cc000a4d4bc9a60();
    }
    
    victim nvg::savenvgstate();
    inventory::handleweaponchangecallbacksondeath();
    
    if ( !isfauxdeath )
    {
        if ( vehicle_occupancy::function_3080323254ba6900( victim ) )
        {
            if ( isdefined( victim.vehicle ) )
            {
                victim.vehicle notify( #"player_killed_no_faux_death" );
            }
        }
    }
    else
    {
        victim playerlogic::function_b2741fbfac0c8b8c( 1 );
        victim sethidenameplate( 1 );
        self notify( #"death" );
        self notify( #"death_or_disconnect" );
    }
    
    if ( deathdata.meansofdeath == "MOD_SUICIDE" && deathdata.var_2ce16cf2dc2c23b5 )
    {
        equipref = equipment_mp::getequipmentreffromweapon( deathdata.objweapon );
        bundle = level.equipment.table[ equipref ].bundle;
        
        if ( bundle.var_ff969a74ed1aaeba && !level.var_83d8ad2846573fbf )
        {
            foreach ( slot, equip in victim.pers[ "rechargeEquipment" ] )
            {
                if ( equip.ref == equipref )
                {
                    victim.pers[ "rechargeEquipment" ][ slot ].ammo = victim.pers[ "rechargeEquipment" ][ slot ].ammo - 1;
                    break;
                }
            }
        }
    }
    
    equiptype = weapon::getequipmenttype( objweapon );
    
    if ( isdefined( equiptype ) )
    {
        result = equipment_mp::equiponplayerkilled( deathdata );
    }
    
    perks::updateactiveperks( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc, direction_vec );
    supers_mp::updateactivesupers( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc, direction_vec );
    
    if ( isdefined( level.custom_death_effect ) )
    {
        [[ level.custom_death_effect ]]( victim, meansofdeath, inflictor );
    }
    
    if ( meansofdeath != "MOD_SUICIDE" && ( game_utility_common::isaigameparticipant( victim ) || game_utility_common::isaigameparticipant( attacker ) ) )
    {
        bots::function_be8d6ad4371f7b67( attacker, inflictor, victim, deathdata );
    }
    
    laststand::function_da2b8eafac133316( deathdata );
    callback::callback( #"hash_3a9399925470154c", deathdata );
    
    if ( game_utility_mp::isteamreviveenabled() && flags::gameflag( "prematch_done" ) && !victim.switching_teams || level.var_eb2add0a0ffb773e )
    {
        var_ce60dbbce5224109 = self.isjuggernaut && isdefined( self.juggcontext );
        
        if ( isdefined( level.var_e00bbb7e3b09cb1e ) )
        {
            [[ level.var_e00bbb7e3b09cb1e ]]( victim );
        }
        
        if ( !var_ce60dbbce5224109 )
        {
            respawnitems = victim class::respawnitems_saveplayeritemstostruct();
        }
        else
        {
            respawnitems = self.juggcontext;
        }
        
        victim class::respawnitems_assignrespawnitems( respawnitems );
    }
    
    if ( isbrgamemode() )
    {
        if ( level.br_prematchstarted && !br_public::isplayeringulag() && !deathdata.var_9f76c7655b16ed66 )
        {
            br_analytics::branalytics_inventory_snapshot( self, "player_death" );
        }
    }
    
    victim.var_fbdf9e00e56b1f10 = victim.perks;
    deathdata.var_d9ca660ba1f38dd0 = 0;
    victimweaponlist = deathdata.victim getweaponslistprimaries();
    
    foreach ( weapon in victimweaponlist )
    {
        if ( weaponclass( weapon ) == "sniper" )
        {
            deathdata.var_d9ca660ba1f38dd0 = 1;
            break;
        }
    }
    
    var_79861ef29c7c2ca4 = victim killstreak::iscontrollingproxyagent() ? victim.playerproxyagent : victim;
    
    if ( isdefined( attacker.perks[ "specialty_scavenger" ] ) )
    {
        var_79861ef29c7c2ca4 thread utility::callsharedfunc( #"specialty_scavenger", #"dropscavengerfordeath", attacker, deathdata.meansofdeath );
    }
    
    if ( getdvarint( @"hash_5afa341109e3a9f4", 0 ) || level.var_21cde95d1d91bf03 )
    {
        var_79861ef29c7c2ca4 thread weapons::function_edc8b4335dbc2596( attacker, deathdata.meansofdeath );
    }
    
    var_79861ef29c7c2ca4 thread [[ level.weapondropfunction ]]( attacker, meansofdeath, undefined, damage );
    
    if ( !isfauxdeath && !victim.juggcontext.var_af0e1deab5671dfa )
    {
        if ( !level.disable_killcam )
        {
            if ( isplayer( attacker ) )
            {
                victim setclientomnvar( "ui_killcam_killedby_id", attacker getentitynumber() );
                victim setclientomnvar( "ui_killcam_killedby_health_ratio", int( clamp( deathdata.attacker.health / deathdata.attacker.maxhealth * 127, 0, 127 ) ) );
                victim hud_editor::function_8618046cf533c449( attacker );
            }
            else if ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" )
            {
                victim setclientomnvar( "ui_killcam_killedby_id", victim getentitynumber() );
            }
            else
            {
                victim setclientomnvar( "ui_killcam_killedby_id", -1 );
            }
        }
        
        newstate = "dead";
        
        if ( self.liveragdoll )
        {
            newstate = "playing_but_spectating";
        }
        else if ( level.var_b05cefe0c59dde7f )
        {
            newstate = "spectator";
        }
        
        victim player::updatesessionstate( newstate );
    }
    
    var_6e4092c67fbc5947 = victim getplayerunoid();
    
    if ( isdefined( var_6e4092c67fbc5947 ) && victim != attacker && isplayer( victim ) && isplayer( attacker ) && flags::gameflag( "prematch_done" ) && getdvarint( @"hash_5ce3657bc4920adc", 1 ) == 1 )
    {
        playerkillevents = attacker.pers[ "telemetry" ].playerkillevents;
        
        if ( isdefined( playerkillevents ) )
        {
            playerkillevents[ playerkillevents.size ] = int( gettime() / 1000 );
            playerkillevents[ playerkillevents.size ] = var_6e4092c67fbc5947;
            attacker.pers[ "telemetry" ].playerkillevents = playerkillevents;
        }
    }
    
    if ( isdefined( var_6e4092c67fbc5947 ) && victim != attacker && isplayer( victim ) && isplayer( attacker ) && flags::gameflag( "prematch_done" ) && getdvarint( @"hash_7355aa3741355360", 1 ) == 1 )
    {
        foreach ( assistplayer in victim.attackers )
        {
            if ( assistplayer == attacker || assistplayer == victim )
            {
                continue;
            }
            
            if ( !isdefined( assistplayer.var_1c8f83acf99b4207 ) )
            {
                assistplayer.var_1c8f83acf99b4207 = [];
            }
            
            assistplayer.var_1c8f83acf99b4207[ assistplayer.var_1c8f83acf99b4207.size ] = var_6e4092c67fbc5947 ?? 0;
            
            if ( !isdefined( assistplayer.var_7d6bcb4efeec5380 ) )
            {
                assistplayer.var_7d6bcb4efeec5380 = [];
            }
            
            assistplayer.var_7d6bcb4efeec5380[ assistplayer.var_7d6bcb4efeec5380.size ] = attacker getplayerunoid() ?? 0;
        }
    }
    
    var_28e01e0b7a42a771 = victim.fauxdead && victim.switching_teams;
    
    if ( !var_28e01e0b7a42a771 )
    {
        if ( !isdefined( level.modemayconsiderplayerdead ) || [[ level.modemayconsiderplayerdead ]]( victim ) )
        {
            victim playerlogic::removefromalivecount( undefined, "playerKilled" );
        }
    }
    
    if ( !isdefined( victim.switching_teams ) )
    {
        if ( !level.ignorescoring && ( !deathdata.isfriendlyfire || game_utility::function_a81fd80bdb4f6ab1() ) )
        {
            if ( !game_utility::function_245a95d184375f25() )
            {
                victim playerstats_interface::addtoplayerstat( 1, "combatStats", "deaths" );
            }
            
            if ( victim.pers[ "deaths" ] < 999 )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                {
                    if ( isdefined( victim.leaderboarddata[ "deaths" ] ) )
                    {
                        victim.leaderboarddata[ "deaths" ] = victim.leaderboarddata[ "deaths" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "deaths" ] ) )
                    {
                        [[ level.leaderboardfunc[ "deaths" ] ]]( victim, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                    
                    if ( isdefined( victim.pers[ "deaths" ] ) )
                    {
                        victim.pers[ "deaths" ] = victim.pers[ "deaths" ] + 1;
                    }
                }
                
                if ( isplayer( attacker ) && isbot( attacker ) )
                {
                    deathtype = deathdata.deathtype ?? playerkilled_finddeathtype( deathdata );
                    
                    if ( deathtype != "deathType_suicide" )
                    {
                        if ( !isdefined( victim.pers[ "telemetry" ].var_98a5205ed62c93d ) )
                        {
                            victim.pers[ "telemetry" ].var_98a5205ed62c93d = 0;
                        }
                        
                        victim.pers[ "telemetry" ].var_98a5205ed62c93d++;
                    }
                }
                else if ( isagent( attacker ) )
                {
                    if ( !isdefined( victim.pers[ "telemetry" ].var_e3103b223b34ee91 ) )
                    {
                        victim.pers[ "telemetry" ].var_e3103b223b34ee91 = 0;
                    }
                    
                    victim.pers[ "telemetry" ].var_e3103b223b34ee91++;
                }
                
                victim.deaths = victim.pers[ "deaths" ];
                victim persistence::statsetchild( "round", "deaths", victim.deaths, level.ignorekdrstats );
            }
        }
    }
    
    obitmeansofdeath = meansofdeath;
    
    if ( !( deathdata.idflags & 524288 ) && deathdata.idflags & 8 && !( deathdata.idflags & 16384 ) )
    {
        if ( !isdefined( attacker.bulletkillsinaframecount ) || attacker.bulletkillsinaframecount == 0 )
        {
            obitmeansofdeath = "MOD_PENETRATION";
            
            if ( isplayer( attacker ) && player_utility::playersareenemies( attacker, victim ) && !var_c3c9e6f032846bdb )
            {
                attacker thread points::doscoreevent( #"penetration_kill" );
                attacker.var_2d5b79b93c51aa8f = 1;
            }
        }
    }
    else if ( objweapon.basenamehash == %"semtex_xmike109_mp" && ( deathdata.hitloc === "head" || deathdata.hitloc === "helmet" ) )
    {
        obitmeansofdeath = "MOD_HEAD_SHOT";
    }
    
    if ( isdefined( deathdata.inflictor ) && deathdata.inflictor.iswztrain )
    {
        obitmeansofdeath = "MOD_CRUSH";
    }
    
    if ( deathdata.damageflags & 2097152 )
    {
        obitmeansofdeath = "MOD_TRIGGER_HURT";
    }
    
    if ( isdefined( deathdata.inflictor.var_30656af96b2ac2a4 ) && deathdata.inflictor.var_30656af96b2ac2a4.size > 0 && getprojectname() != "WZ2" )
    {
        obitmeansofdeath = "MOD_BUFFED_KILL";
    }
    
    var_5a83bf7171038fab = objweapon;
    
    if ( obitmeansofdeath == "MOD_MEATSHIELD" )
    {
        var_5a83bf7171038fab = makeweapon( level.projectbundle.var_de265c71ee2dc8a6 ?? "t10_meatshield" );
    }
    
    if ( isbrgamemode() || isdmzgamemode() )
    {
        obitplayers = [];
        var_2c67fd32918bcac9 = function_17f611cf51138f9d( deathdata );
        
        if ( isdefined( var_2c67fd32918bcac9 ) )
        {
            obitplayers = var_2c67fd32918bcac9;
        }
        else
        {
            if ( isdefined( victim ) )
            {
                victimteam = teams::getfriendlyplayers( victim.team, 0 );
                
                if ( isdefined( victimteam ) )
                {
                    obitplayers = arraycombine( obitplayers, victimteam );
                }
            }
            
            if ( isplayer( attacker ) )
            {
                attackerteam = teams::getfriendlyplayers( attacker.team, 0 );
                
                if ( isdefined( attackerteam ) && victim.team != attacker.team )
                {
                    obitplayers = arraycombine( obitplayers, attackerteam );
                }
                
                var_924abc145a22046e = br_spectate::getspectatorsofplayer( attacker );
                
                if ( isdefined( var_924abc145a22046e ) )
                {
                    obitplayers = arraycombine( obitplayers, var_924abc145a22046e );
                }
            }
        }
        
        obitplayers = arraycombine( obitplayers, level.codcasters );
        
        if ( obitplayers.size > 0 && !level.gametypebundle.var_6bdb958d32b58800 )
        {
            var_48adc5c7948bb284 = vehicle_collision::function_ff24898d8aa594cd( deathdata ) ? "MOD_EXPLOSIVE" : obitmeansofdeath;
            
            if ( attacker.gulag && victim.gulag )
            {
                var_48adc5c7948bb284 = "MOD_GULAG_KILL";
            }
            
            obituary( victim, attacker, var_5a83bf7171038fab, var_48adc5c7948bb284, obitplayers );
        }
    }
    else
    {
        obitplayers = game_utility_mp::function_4b15b7eb1dc364e7( victim.team );
        obitplayers = arraycombine( obitplayers, level.codcasters );
        
        if ( obitmeansofdeath == "MOD_EXPLOSIVE" && ( !isdefined( var_5a83bf7171038fab ) || isnullweapon( var_5a83bf7171038fab ) ) )
        {
            var_5a83bf7171038fab = makeweapon( level.projectbundle.var_d9872195a7b3fbdb ?? "obit_explosive" );
        }
        
        var_48adc5c7948bb284 = vehicle_collision::function_ff24898d8aa594cd( deathdata ) ? "MOD_EXPLOSIVE" : obitmeansofdeath;
        var_9f596a3cd043877b = isdefined( level.var_9f596a3cd043877b ) && [[ level.var_9f596a3cd043877b ]]( victim );
        
        if ( !level.gametypebundle.var_6bdb958d32b58800 || var_9f596a3cd043877b )
        {
            if ( isdefined( inflictor ) && inflictor.var_5ceba5e960eea3fb )
            {
                obituary( victim, inflictor, var_5a83bf7171038fab, var_48adc5c7948bb284, obitplayers );
            }
            else
            {
                obituary( victim, attacker, var_5a83bf7171038fab, var_48adc5c7948bb284, obitplayers );
            }
        }
    }
    
    victim updatedeathdetails( victim.attackers, victim.attackerdata, attacker );
    victim.lastbounty = bounty::playergetbountypoints();
    victim bounty::playerresetbountypoints();
    victim bounty::playerresetbountystreak();
    
    if ( victim.var_822abd84a3f6c167 )
    {
        victim function_fd721b9e2718f0c1( 0 );
    }
    
    if ( victim.rallypointrevived )
    {
        victim.rallypointrevived = 0;
    }
    
    victim thread supers_mp::handledeath( attacker );
    victim thread supers_mp::handledeath( attacker, #"tactical" );
    victim thread [[ level.onplayerkilledcommon ]]( inflictor, attacker, damage, meansofdeath, objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid, weapon::iskillstreakweapon( victimheldweapon ) );
    
    if ( isai( victim ) )
    {
        victim thread bots::on_bot_killed( inflictor, attacker, damage, deathdata.damageflags, meansofdeath, deathdata.objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid );
    }
    
    victimlifetime = ( deathdata.deathtime - victim.spawntime ) / 1000;
    
    if ( isdefined( victim.pers[ "shortestLife" ] ) )
    {
        if ( victim.pers[ "shortestLife" ] == 0 || victimlifetime < victim.pers[ "shortestLife" ] )
        {
            victim.pers[ "shortestLife" ] = victimlifetime;
        }
    }
    
    if ( isdefined( victim.pers[ "longestLife" ] ) )
    {
        if ( victim.pers[ "longestLife" ] == 0 || victimlifetime > victim.pers[ "longestLife" ] )
        {
            victim.pers[ "longestLife" ] = victimlifetime;
        }
    }
    
    /#
        function_b042fa22e449387d( deathdata );
    #/
    
    if ( utility::issharedfuncdefined( #"player", #"hash_ee582e497ca1db5" ) )
    {
        attacker [[ utility::getsharedfunc( #"player", #"hash_ee582e497ca1db5" ) ]]( attacker, victim, objweapon, meansofdeath );
    }
    
    if ( weapon_utility::function_f94272fc69a3d88c( objweapon.basename ) )
    {
        attacker points::doscoreevent( #"hash_70e0aaee7cf1d86" );
    }
    
    if ( victim.isknockeddown && !var_c3c9e6f032846bdb )
    {
        switch ( objweapon.basename )
        {
            case #"hash_7aa7e372f00591b7":
                attacker points::doscoreevent( #"hash_a814131da52373c0" );
                break;
            case #"hash_34f28162f0f54c6e":
                attacker points::doscoreevent( #"hash_1d2d6191f2acc596" );
                break;
        }
        
        if ( victim.var_8cdd9b270c1b3f2a.attackerent != attacker )
        {
            attacker points::doscoreevent( #"hash_9e899ef1c826a45c", undefined, undefined, undefined, victim );
        }
    }
    
    if ( meansofdeath == "MOD_HEAD_SHOT" && !var_c3c9e6f032846bdb )
    {
        attacker points::doscoreevent( #"hash_9e05dc51acedc8c5", undefined, undefined, undefined, victim );
        return;
    }
    
    if ( victim.var_d0aba15d98adc210 )
    {
        if ( meansofdeath == "MOD_HEAD_SHOT" && !var_c3c9e6f032846bdb )
        {
            attacker points::doscoreevent( #"hash_c980a9b9d2451826", undefined, undefined, undefined, victim );
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x3df73cd5, Offset: 0x115ac
// Size: 0x29b
function playerkilled_logkill( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    inflictor = deathdata.inflictor;
    attackerweaponobj = deathdata.objweapon;
    weaponfullstring = deathdata.weaponfullstring;
    meansofdeath = deathdata.meansofdeath;
    victim utility::trycall( level.clientmatchdata_logplayerdeath, attacker );
    telemetry_utils::function_af2d366f9522f76f( "callback_player_death", deathdata );
    victim analyticslog::logevent_path();
    victim analyticslog::logevent_playerdeath( attacker, meansofdeath, weaponfullstring );
    attacker analyticslog::logevent_playerkill( victim, meansofdeath, weaponfullstring );
    var_682c1d84bef49f0f = player_utility::playersareenemies( victim, attacker );
    
    if ( var_682c1d84bef49f0f )
    {
        var_b4dd7dd265ca863f = victim.var_983a3526ad5f8a6a;
        
        if ( isplayer( attacker ) && meansofdeath.size > 0 )
        {
            if ( isdefined( var_b4dd7dd265ca863f ) && isdefined( inflictor ) )
            {
                var_b4dd7dd265ca863f = weapon::mapweapon( var_b4dd7dd265ca863f, inflictor );
                thread gamelogic_mp::trackleaderboarddeathstats( attacker, victim, var_b4dd7dd265ca863f, meansofdeath );
            }
            
            thread gamelogic_mp::trackattackerleaderboarddeathstats( attacker, victim, attackerweaponobj, meansofdeath );
        }
        else if ( isagent( attacker ) )
        {
            var_b4dd7dd265ca863f = weapon::mapweapon( var_b4dd7dd265ca863f, inflictor );
            victim thread gamelogic_mp::threadedsetweaponstatbyname( var_b4dd7dd265ca863f, 1, "deaths", attacker, attacker );
        }
    }
    
    telemetry_mp::function_75399aefea54c661( attacker, victim, deathdata );
    telemetry_mp::function_6b08bb7eb0006e2e( attacker, victim, deathdata );
    telemetry_mp::function_3a70f4799d2d7acc( victim );
    
    if ( isdefined( level.matchrecording_logeventmsg ) && isplayer( inflictor ) && utility::isbulletdamage( meansofdeath ) )
    {
        if ( !isdefined( victim.sidekillcount ) )
        {
            victim.sidekillcount = 0;
        }
        
        if ( !withinfov2d( victim.origin, victim.angles, inflictor.origin, 0.258819 ) )
        {
            victim.sidekillcount++;
        }
        
        engagementtime = 0;
        
        if ( isdefined( victim.engagementstarttime ) )
        {
            engagementtime = gettime() - victim.engagementstarttime;
        }
        
        if ( !isdefined( victim.engagementtime ) )
        {
            victim.engagementtime = 0;
            victim.engagementcount = 0;
        }
        
        victim.engagementtime += engagementtime;
        victim.engagementcount++;
        victim.engagementstarttime = undefined;
    }
    
    updatecombatrecordkillstats( attacker, victim, meansofdeath, attackerweaponobj );
}

// Namespace damage
// Params 1
// Checksum 0xa87d36a5, Offset: 0x1184f
// Size: 0x144
function playerkilled_finddeathtype( deathdata )
{
    victim = deathdata.victim;
    [ attacker, inflictor, objweapon, meansofdeath, iskillstreakweapon ] = victim function_c9cd6450ceee53ef( deathdata );
    
    if ( victim isswitchingteams() )
    {
        return "deathType_switchingTeams";
    }
    
    if ( !isplayer( attacker ) || meansofdeath == "MOD_FALLING" || meansofdeath == "MOD_BUMP" || inflictor.iscrusher && meansofdeath == "MOD_CRUSH" )
    {
        return "deathType_worldDeath";
    }
    
    if ( attacker == victim || entity::isdronepackage( inflictor ) && !player_utility::playersareenemies( attacker, victim ) )
    {
        return "deathType_suicide";
    }
    
    if ( deathdata.isfriendlyfire && !deathdata.isnukekill )
    {
        return "deathType_friendlyFire";
    }
    
    if ( victim.inlaststand )
    {
        return "deathType_inLastStand";
    }
    
    return "deathType_normal";
}

// Namespace damage
// Params 1
// Checksum 0xe4bab685, Offset: 0x1199b
// Size: 0x236
function playerkilled_handledeathtype( deathdata )
{
    victim = deathdata.victim;
    deathdata.deathtype = playerkilled_finddeathtype( deathdata );
    var_211532436691dcc4 = 0;
    isfauxdeath = istrue( deathdata.isfauxdeath );
    
    if ( !isfauxdeath || getdvarint( @"scr_force_player_fatal_death", 0 ) )
    {
        victim notify( #"player_fatal_death" );
    }
    
    if ( getdvarint( @"hash_8df77c9b4d81fd0f", 0 ) == 0 && level.projectbundle.var_7b672c8455ce7ff1 == 1 )
    {
        deathrecap::function_243d45bcade5e4ac( victim, deathdata.attacker );
    }
    
    switch ( deathdata.deathtype )
    {
        case #"hash_fea1e712b5740278":
            handleteamchangedeath();
            break;
        case #"hash_1184b43822fe56f0":
            handleworlddeath( deathdata, deathdata.attacker, deathdata.lifeid, deathdata.meansofdeath, deathdata.hitloc );
            break;
        case #"hash_c03eabf71149f406":
            var_211532436691dcc4 = 1;
            handlesuicidedeath( deathdata, deathdata.meansofdeath, deathdata.hitloc );
            break;
        case #"hash_e97320d8279bef45":
            handlefriendlyfiredeath( deathdata );
            break;
        case #"hash_ce250de499ae9603":
            handleinlaststanddeath( deathdata );
            break;
        case #"hash_a9f265ec10b615d":
            handlenormaldeath( deathdata.lifeid, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.meansofdeath, victim, deathdata.iskillstreakweapon, deathdata );
            break;
        default:
            assertmsg( "<dev string:x32e>" + deathdata.deathtype + "<dev string:x344>" );
            break;
    }
    
    function_5eecf23a1765bbb2( deathdata.attacker, 0 );
    
    /#
        function_b042fa22e449387d( deathdata );
    #/
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0xf41c0ff9, Offset: 0x11bd9
// Size: 0x5d
function private function_932d988168d7ec5( deathdata )
{
    victim = deathdata.victim;
    victim player::updatesessionstate( "dead" );
    
    if ( !victim.juggcontext.var_af0e1deab5671dfa )
    {
        playerkilled_handlecorpse( deathdata );
    }
    
    outofbounds::clearoob( self, 1 );
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0x2f57cb80, Offset: 0x11c3e
// Size: 0x393
function private playerkilled_sharedlogic_late( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( !victim.juggcontext.var_af0e1deab5671dfa )
    {
        playerkilled_handlecorpse( deathdata );
    }
    
    outofbounds::clearoob( self, 1 );
    setdeathtimerlength( deathdata );
    
    if ( isdefined( level.custom_death_sound ) )
    {
        [[ level.custom_death_sound ]]( victim, deathdata.meansofdeath, deathdata.inflictor );
    }
    else if ( function_2786fa8e2c98141a( deathdata ) )
    {
        victim sound::playdeathsound( deathdata.objweapon, deathdata.meansofdeath, deathdata.hitloc );
    }
    
    if ( isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( isplayer( attacker ) )
    {
        hassilentkill = isdefined( attacker.perks[ "specialty_silentkill" ] );
        victim setplayersilentkill( hassilentkill );
        
        if ( attacker != victim && attacker gameplay_telemetry_utils::function_944c6d9098e40dfb( victim ) )
        {
            attacker gameplay_telemetry::function_383cde919fd850c4( "operatorKills", 2 );
            operatorkill = attacker gameplay_telemetry::function_42040e5fa41218b3( "operatorKills" );
            operatordeath = attacker gameplay_telemetry::function_42040e5fa41218b3( "operatorDeaths" );
            kdRatio = operatorkill / max( operatordeath, 1 );
            attacker thread gameplay_telemetry::function_f98fbe3bbb2ed9f1( "operatorKD", 2, kdRatio, 0 );
        }
    }
    
    if ( level.killcam || level.finalkillcamenabled )
    {
        playerkilled_killcamsetup( deathdata );
    }
    
    if ( !deathdata.var_9f76c7655b16ed66 )
    {
        if ( isbrgamemode() )
        {
            br_analytics::branalytics_down( deathdata.attacker, deathdata.victim, deathdata.objweapon, deathdata.deathtype, deathdata.meansofdeath );
        }
        
        thread challenges::function_267b9750fac691c1( deathdata.inflictor, deathdata.attacker, deathdata.damage, deathdata.damageflags, deathdata.meansofdeath, deathdata.objweapon, deathdata.hitloc, deathdata.attacker.modifiers );
        
        if ( !game_utility_mp::runleanthreadmode() || getdvarint( @"hash_ee4a7c4b0cf8c75b", 1 ) )
        {
            playerkilled_logkill( deathdata );
        }
    }
    
    if ( level.var_d3b87493843ea3b1 )
    {
        codcasterclientmatchdata::function_d6aea11d2e9ba521();
        level.var_d3b87493843ea3b1 = 0;
    }
    
    mtx_weapon::function_df0eeeccd6a86cb5( deathdata );
    
    if ( !deathdata.var_753c947650e223ce )
    {
        callback::callback( #"hash_244314ef9125e636", deathdata );
        deathdata.var_753c947650e223ce = 1;
    }
    
    if ( !deathdata.var_dbf1664ca06180ed )
    {
        callback::callback( #"hash_5e4c0033a7bbd7f", deathdata );
        deathdata.var_dbf1664ca06180ed = 1;
    }
    
    callback::callback( #"player_death", deathdata );
    
    if ( function_53609df45841c88c() )
    {
        if ( isplayer( attacker ) )
        {
            attacker function_26369d153305237e( 1 );
        }
        
        if ( isplayer( deathdata.victim ) )
        {
            deathdata.victim function_26369d153305237e( 2 );
        }
    }
    
    victim ui_bot::function_7f7e3bf95fb723cd();
    
    /#
        function_b042fa22e449387d( deathdata );
    #/
    
    level.var_28b0b95d6825011 = function_8fc063681724727f();
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0xe6554c6b, Offset: 0x11fd9
// Size: 0xcd
function private function_89837db6544c3f21( deathdata )
{
    if ( !level.var_9873833220fc9713 )
    {
        level.var_9873833220fc9713 = [];
    }
    
    bundle = level.perkbundles[ "specialty_medic_revival" ];
    reviveuseobj = gameobjects::createhintobject( deathdata.victim.origin, "HINT_NOICON", undefined, bundle.var_f763791752809720, undefined, "duration_medium", "show", 600, 180, 90, 45 );
    reviveuseobj.team = deathdata.victim.team;
    reviveuseobj disableplayeruseforallplayers();
    reviveuseobj function_c6d345eeab0c9bc2();
    reviveuseobj thread function_6309f472380dda29();
    reviveuseobj thread function_3d06ed44a5f7e7d( deathdata, bundle );
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0x5e7d5f5c, Offset: 0x120ae
// Size: 0x13c
function private function_c6d345eeab0c9bc2()
{
    if ( !isdefined( level.var_9873833220fc9713 ) )
    {
        level.var_9873833220fc9713 = [];
    }
    
    level.var_9873833220fc9713[ level.var_9873833220fc9713.size ] = self;
    
    if ( !level.var_fe765ea4a3d0f9f5 )
    {
        return;
    }
    
    foreach ( player in level.var_fe765ea4a3d0f9f5 )
    {
        foreach ( obj in level.var_9873833220fc9713 )
        {
            if ( player.team == obj.team )
            {
                obj enableplayeruse( player );
            }
        }
    }
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0xf3575ac5, Offset: 0x121f2
// Size: 0x30
function private function_6309f472380dda29()
{
    self endon( #"trigger" );
    level endon( #"match_ended" );
    wait 10;
    self notify( #"revive_expired" );
    function_d7ebd4af18957eb8();
}

// Namespace damage
// Params 2, eflags: 0x4
// Checksum 0x4be89615, Offset: 0x1222a
// Size: 0x89
function private function_3d06ed44a5f7e7d( deathdata, bundle )
{
    self endon( #"revive_expired" );
    level endon( #"match_ended" );
    self waittill( #"trigger" );
    agent = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( bundle.var_b891fd5ab71565ac, self.origin, ( 0, 0, 0 ), deathdata.victim.team );
    function_d7ebd4af18957eb8();
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0xfb212cb5, Offset: 0x122bb
// Size: 0x26
function private function_d7ebd4af18957eb8()
{
    self setusableenabled( 0 );
    level.var_9873833220fc9713 = arrayremove( level.var_9873833220fc9713, self );
    self delete();
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0x1c18d927, Offset: 0x122e9
// Size: 0x11d
function private function_57aa27f98ebd1ffd( deathdata )
{
    if ( !deathdata.attacker.var_822abd84a3f6c167 )
    {
        return;
    }
    
    if ( !level.var_a2de4a5773d5a2c5 )
    {
        level.var_a2de4a5773d5a2c5 = [];
    }
    
    bundle = level.perkbundles[ "specialty_identity_theft" ];
    var_b5dcc90e614db99 = gameobjects::createhintobject( deathdata.victim.origin, "HINT_NOICON", undefined, bundle.var_463c68c61e5c64de, undefined, "duration_medium", "show", 600, 180, 90, 45 );
    var_b5dcc90e614db99.team = deathdata.attacker.team;
    var_b5dcc90e614db99 disableplayeruseforallplayers();
    var_b5dcc90e614db99 enableplayeruse( deathdata.attacker );
    
    if ( !isdefined( level.var_a2de4a5773d5a2c5 ) )
    {
        level.var_a2de4a5773d5a2c5 = [];
    }
    
    level.var_a2de4a5773d5a2c5[ level.var_a2de4a5773d5a2c5.size ] = var_b5dcc90e614db99;
    var_b5dcc90e614db99 thread function_1732f6a1a9bc4147();
    var_b5dcc90e614db99 thread function_46febe23c4c4e677( deathdata, bundle );
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0x42807c9f, Offset: 0x1240e
// Size: 0x30
function private function_1732f6a1a9bc4147()
{
    self endon( #"trigger" );
    level endon( #"match_ended" );
    wait 10;
    self notify( #"theft_expired" );
    function_a9977394ccefe73e();
}

// Namespace damage
// Params 2, eflags: 0x4
// Checksum 0x5989a605, Offset: 0x12446
// Size: 0x53
function private function_46febe23c4c4e677( deathdata, bundle )
{
    self endon( #"theft_expired" );
    level endon( #"match_ended" );
    self waittill( #"trigger" );
    deathdata.attacker function_fd721b9e2718f0c1( 1 );
    function_a9977394ccefe73e();
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0x6e5d9f45, Offset: 0x124a1
// Size: 0x26
function private function_a9977394ccefe73e()
{
    self setusableenabled( 0 );
    level.var_a2de4a5773d5a2c5 = arrayremove( level.var_a2de4a5773d5a2c5, self );
    self delete();
}

// Namespace damage
// Params 1
// Checksum 0xf030cc8d, Offset: 0x124cf
// Size: 0x620
function playerkilled_handlecorpse( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    inflictor = deathdata.inflictor;
    meansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    isfauxdeath = deathdata.isfauxdeath;
    hitloc = deathdata.hitloc;
    var_267560ed6dab34fe = 0;
    
    if ( isdefined( victim.carryobject ) && !isfauxdeath )
    {
        victim notify( #"drop_called" );
        victim.carryobject thread gameobjects::setdropped();
    }
    
    if ( game_utility_mp::isteamreviveenabled() && !outofbounds::isoob( self ) && flags::gameflag( "prematch_done" ) && level.teambased )
    {
        if ( level.var_295e3e1536070747 )
        {
            level callback::callback( "on_revive_trigger_requested", deathdata );
        }
        else
        {
            level thread teamrevive::spawnrevivetrigger( victim, attacker, meansofdeath );
        }
    }
    
    vehicle_collision::function_9a63065217865db4( deathdata );
    var_2ba06f559b123d31 = victim.skipcorpse || inflictor.var_bc286fce9fff9062 || deathdata.var_9f76c7655b16ed66;
    
    if ( !isdefined( self.nocorpse ) && !var_2ba06f559b123d31 )
    {
        if ( self.liveragdoll )
        {
            if ( function_56b8fd2ccc68ddf9() )
            {
                victim.var_f122a6539d6d6e03 = deathdata;
            }
            
            victim.body = victim;
        }
        else
        {
            victim.body = victim cloneplayer( deathdata.deathanimduration, attacker, objweapon );
            victim.body.targetname = "player_corpse";
        }
        
        /#
            debug::function_b94568e3a7672460( victim.body );
        #/
        
        if ( !deathdata.isfauxdeath )
        {
            function_89837db6544c3f21( deathdata );
            function_57aa27f98ebd1ffd( deathdata );
        }
    }
    
    if ( !isdefined( self.nocorpse ) && !var_2ba06f559b123d31 && isdefined( victim.body ) )
    {
        if ( !isdefined( victim.switching_teams ) )
        {
            if ( level.var_124458d4c5310c29 || isplayer( attacker ) || attacker.var_a89afb46f02bb18c )
            {
                thread deathicons::adddeathicon( attacker, victim.body, victim, victim.team, 5 );
            }
            
            var_b9b44bfa6677741d = [];
            
            if ( isdefined( victim ) )
            {
                foreach ( player in level.players )
                {
                    if ( player iscodcaster() )
                    {
                        var_b9b44bfa6677741d[ var_b9b44bfa6677741d.size ] = player;
                    }
                }
            }
            
            if ( var_b9b44bfa6677741d.size > 0 )
            {
                thread deathicons::addenemydeathicon( victim.body, victim, [], var_b9b44bfa6677741d, getdvarfloat( @"perk_kill_report_icon_time" ), 1 );
            }
        }
        
        if ( !self.liveragdoll )
        {
            if ( deathdata.isnukekill )
            {
            }
            
            if ( deathdata.isfauxdeath )
            {
                victim player_utility::function_dbe5a52a6654a982();
                victim player_utility::function_9d378d725bb4831e( "damage::PlayerKilled_handleCorpse()" );
                victim setsolid( 0 );
            }
            
            victim thread _startragdoll( deathdata.victim.body, deathdata.meansofdeath, deathdata.inflictor );
        }
        
        victim thread callcorpsetablefuncs();
        
        if ( !function_4a18c3f584835c37( deathdata ) )
        {
            if ( isbrgamemode() )
            {
                if ( game_utility::getgametype() == "dmz" && self.liveragdoll )
                {
                    var_267560ed6dab34fe = 1;
                }
                else if ( isdefined( level.pleaforhelp ) )
                {
                    var_267560ed6dab34fe = !utility::callsharedfunc( #"pleaforhelp", #"hash_348c1ada8ab9898f", victim );
                }
                else
                {
                    var_267560ed6dab34fe = 1;
                }
            }
            else
            {
                var_267560ed6dab34fe = 1;
            }
        }
        
        if ( weapon_utility::function_584becf6a5ddf5f0( inflictor, victim ) )
        {
            var_267560ed6dab34fe = 0;
        }
        
        if ( var_267560ed6dab34fe )
        {
            victim mtx_weapon::function_82186dea3b314616( attacker, objweapon, meansofdeath, hitloc, inflictor, deathdata.executionref, deathdata.damageflags );
            
            if ( weapon_utility::function_724ac858ee9ecfb8( objweapon ) )
            {
                self.body setscriptablepartstate( "burning", "flareUp", 0 );
            }
        }
    }
    else if ( !self.liveragdoll )
    {
        if ( isdefined( victim.nocorpse ) && !var_2ba06f559b123d31 )
        {
            victim.body = victim cloneplayer( deathdata.deathanimduration );
            victim.body hide( 1 );
        }
    }
    
    if ( !game[ "isLaunchChunk" ] )
    {
        victim.streaktype = class::loadout_getplayerstreaktype( victim.streaktype );
        requisitionsenabled = level.gametypebundle.requisitionsenabled;
        
        if ( victim killstreaks::streaktyperesetsondeath( victim.streaktype ) )
        {
            if ( !level.casualscorestreaks && !isdefined( victim.perks[ "specialty_support_killstreaks" ] ) && !requisitionsenabled )
            {
                victim killstreaks::resetstreakpoints();
                victim killstreaks::resetstreakavailability();
                return;
            }
            
            if ( level.casualscorestreaks && !requisitionsenabled )
            {
                shouldreset = killstreaks::checkcasualstreaksreset();
                
                if ( shouldreset )
                {
                    victim killstreaks::resetstreakpoints();
                    victim killstreaks::resetstreakavailability();
                }
                
                return;
            }
            
            if ( requisitionsenabled )
            {
                if ( getdvarint( @"hash_9e63e7a9c6f6ee4c", 1 ) == 1 )
                {
                    victim killstreaks::function_422a79191a5074b2();
                }
                
                victim killstreaks::function_ecd054aa133cc973( attacker );
                victim killstreaks::resetstreakavailability();
            }
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x9a93f0c8, Offset: 0x12af7
// Size: 0x7a, Type: bool
function function_4a18c3f584835c37( deathdata )
{
    if ( !isdefined( deathdata ) || !deathdata.assistedsuicide )
    {
        return false;
    }
    
    timesincelastdamage = gettime() - deathdata.victim.lastdamagedtime;
    damagedrecently = timesincelastdamage < getdvarfloat( @"hash_2e69ee4932e4a6e5", 1000 );
    return deathdata.assistedsuicide && !damagedrecently;
}

// Namespace damage
// Params 1
// Checksum 0xca05efc4, Offset: 0x12b7a
// Size: 0x38
function function_204223caa7a0582f( var_d02735f1eea1ac5a )
{
    assert( !isdefined( level.var_6457134e2e34b724 ) );
    
    if ( isdefined( level.var_6457134e2e34b724 ) )
    {
        return;
    }
    
    level.var_6457134e2e34b724 = var_d02735f1eea1ac5a;
}

// Namespace damage
// Params 1
// Checksum 0xc2f55031, Offset: 0x12bba
// Size: 0x2a
function function_9283f67cf34d62ce( var_d02735f1eea1ac5a )
{
    assert( level.var_6457134e2e34b724 === var_d02735f1eea1ac5a );
    level.var_6457134e2e34b724 = undefined;
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0x3eee94c8, Offset: 0x12bec
// Size: 0x28
function private function_17f611cf51138f9d( deathdata )
{
    if ( !isdefined( level.var_6457134e2e34b724 ) )
    {
        return;
    }
    
    return [[ level.var_6457134e2e34b724 ]]( deathdata );
}

// Namespace damage
// Params 3
// Checksum 0xc98c9376, Offset: 0x12c1d
// Size: 0x31a
function _startragdoll( corpse, meansofdeath, inflictor )
{
    if ( !isdefined( corpse ) )
    {
        return;
    }
    
    corpse endon( #"death" );
    deathanim = corpse getcorpseanim();
    animduration = 0;
    
    if ( animisleaf( deathanim ) )
    {
        animduration = getanimlength( deathanim );
    }
    
    startdelay = undefined;
    vehicle = vehicle::get_vehicle();
    hitbyvehicle = playerkilled_washitbyvehicle( meansofdeath, inflictor );
    var_a0fc3fce2a67081a = undefined;
    deletecorpse = animhasnotetrack( deathanim, "delete_corpse" );
    deletecorpsedelayed = animhasnotetrack( deathanim, "delete_corpse_delayed" );
    noragdoll = animhasnotetrack( deathanim, "no_ragdoll" );
    hasstartdelay = animhasnotetrack( deathanim, "start_ragdoll" );
    
    if ( isdefined( vehicle ) || isdefined( self.externalvehicletag ) && isdefined( self.externalvehicle ) )
    {
        if ( isdefined( vehicle ) )
        {
            if ( vehicle_occupancy::instance_is_registered( vehicle ) )
            {
                var_a0fc3fce2a67081a = vehicle_occupancy::get_occupant_seat( vehicle, self );
            }
        }
        else
        {
            vehicle = self.externalvehicle;
            var_a0fc3fce2a67081a = self.externalvehicletag;
        }
        
        if ( isdefined( var_a0fc3fce2a67081a ) )
        {
            if ( noragdoll || hasstartdelay )
            {
                vehicle_occupancy::function_e1a19a7a2a793b7f( corpse, vehicle, var_a0fc3fce2a67081a );
                corpse setcorpsefalling( 0 );
                corpse.linktooriginandangles = vehicle_occupancy::function_3fdb556dfc812f8( vehicle, var_a0fc3fce2a67081a );
            }
            
            if ( deletecorpse || deletecorpsedelayed || noragdoll || hasstartdelay )
            {
                deleteonseatenter = !noragdoll && !hasstartdelay || isdefined( self.externalvehicle );
                duration = deletecorpsedelayed ? animduration : animduration + 3;
                thread playerkilled_deletecorpseoutofvehicle( corpse, vehicle, var_a0fc3fce2a67081a, duration, deleteonseatenter );
            }
        }
    }
    
    if ( !( meansofdeath == "mod_execution" || meansofdeath == "MOD_MEATSHIELD" ) && meansofdeath != "MOD_MELEE_TAKEDOWN" && !noragdoll )
    {
        startdelay = 0;
        
        if ( hasstartdelay && animduration > 0 )
        {
            startfraction = getnotetracktimes( deathanim, "start_ragdoll" )[ 0 ];
            startdelay = startfraction * animduration;
        }
        
        if ( hitbyvehicle )
        {
            startdelay = 0;
        }
    }
    
    if ( isdefined( startdelay ) )
    {
        wait startdelay;
        
        if ( !isdefined( corpse ) )
        {
            return;
        }
        
        if ( isdefined( vehicle ) )
        {
            thread _unlinkcorpsefromvehicle( vehicle, var_a0fc3fce2a67081a, deletecorpse, deletecorpsedelayed, startdelay, animduration, corpse );
            corpse notify( #"cancel_delete_corpse" );
            vehicle_occupancy::function_e0dab587ee188096( corpse, vehicle, var_a0fc3fce2a67081a );
            return;
        }
        
        if ( !corpse isragdoll() )
        {
            if ( hitbyvehicle )
            {
                corpse startragdollfromvehiclehit( inflictor );
            }
            
            corpse startragdoll();
        }
        
        if ( isdefined( level.var_db5fcc527a2c7a07 ) )
        {
            self thread [[ level.var_db5fcc527a2c7a07 ]]( corpse, animduration );
            return;
        }
        
        [ var_4eb5d78a2bd82efa, var_fb630ab3925b9306 ] = function_620e317661e5bd90();
        
        if ( isdefined( var_4eb5d78a2bd82efa ) && isdefined( var_fb630ab3925b9306 ) )
        {
            corpse thread function_365bc9449fe13e8a( var_4eb5d78a2bd82efa, var_fb630ab3925b9306 );
            return;
        }
        
        thread _donewithcorpse( deletecorpse, deletecorpsedelayed, startdelay, animduration, corpse );
    }
}

// Namespace damage
// Params 5
// Checksum 0x9784b207, Offset: 0x12f3f
// Size: 0x91
function _donewithcorpse( deletecorpse, deletecorpsedelayed, startdelay, animduration, corpse )
{
    if ( deletecorpse || deletecorpsedelayed )
    {
        deletedelay = animduration;
        
        if ( deletecorpsedelayed )
        {
            animduration += 3;
        }
        
        if ( isdefined( startdelay ) )
        {
            deletedelay -= startdelay;
        }
        
        wait deletedelay;
        
        if ( !isdefined( corpse ) )
        {
            return;
        }
        
        corpse delete();
        return;
    }
    
    if ( !game_utility_mp::isteamreviveenabled() && !isagent( self ) )
    {
        corpse setplayercorpsedone();
    }
}

// Namespace damage
// Params 2
// Checksum 0xc3f748fb, Offset: 0x12fd8
// Size: 0x54
function function_365bc9449fe13e8a( var_4eb5d78a2bd82efa, var_fb630ab3925b9306 )
{
    corpse = self;
    level endon( #"game_ended" );
    
    if ( isdefined( var_4eb5d78a2bd82efa ) && var_fb630ab3925b9306 > 0 )
    {
        corpse utility::waittill_notify_or_timeout( var_4eb5d78a2bd82efa, var_fb630ab3925b9306 );
    }
    
    if ( isdefined( corpse ) )
    {
        corpse delete();
    }
}

// Namespace damage
// Params 0
// Checksum 0x13e05928, Offset: 0x13034
// Size: 0x97
function function_620e317661e5bd90()
{
    player = self;
    
    if ( isdefined( level.var_7283b1a906baec17 ) )
    {
        return player [[ level.var_7283b1a906baec17 ]]();
    }
    else if ( player.gulag )
    {
        arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
        
        if ( !( isdefined( arena ) && isdefined( arena.time ) ) )
        {
            return [ undefined, undefined ];
        }
        else
        {
            return [ "corpse_manually_deleted", arena.time ];
        }
    }
    
    return [ undefined, undefined ];
}

// Namespace damage
// Params 7
// Checksum 0x8d5e250d, Offset: 0x130d4
// Size: 0x165
function _unlinkcorpsefromvehicle( vehicle, var_a0fc3fce2a67081a, deletecorpse, deletecorpsedelayed, startdelay, animduration, corpse )
{
    var_49e0adaae24fa459 = getdvarint( @"hash_7c902421e1883986", 1 );
    var_2b07c7236f671fce = !var_49e0adaae24fa459;
    
    if ( var_49e0adaae24fa459 )
    {
        if ( !corpse isragdoll() )
        {
            corpse startragdoll();
        }
    }
    
    waittime = getdvarfloat( @"hash_7d1401b6075479ac", 0.1 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( isdefined( corpse ) )
    {
        if ( isdefined( corpse.linktooriginandangles ) && isdefined( vehicle ) )
        {
            originoffset = ( 0, 0, 0 );
            linktooriginandangles = vehicle_occupancy::function_3fdb556dfc812f8( vehicle, var_a0fc3fce2a67081a );
            originoffset = linktooriginandangles.origin - corpse.linktooriginandangles.origin;
            corpseorigin = corpse.origin + originoffset;
            corpseangles = linktooriginandangles.angles;
            corpse trajectoryupdateoriginandangles( corpseorigin, corpseangles );
        }
        
        corpse unlink();
        
        if ( var_2b07c7236f671fce )
        {
            corpse startragdoll();
        }
        
        thread _donewithcorpse( deletecorpse, deletecorpsedelayed, startdelay, animduration, corpse );
    }
}

// Namespace damage
// Params 5
// Checksum 0xdc89fd4e, Offset: 0x13241
// Size: 0x73
function playerkilled_deletecorpseoutofvehicle( corpse, vehicle, seatid, duration, deleteonseatenter )
{
    corpse endon( #"death" );
    corpse endon( #"cancel_delete_corpse" );
    vehicle_occupancy::function_7730eb57fd31aeea( corpse, vehicle, seatid, deleteonseatenter );
    vehicle utility::waittill_any_timeout( duration, "death" );
    
    if ( isdefined( corpse ) )
    {
        corpse delete();
    }
}

// Namespace damage
// Params 2
// Checksum 0x61cbf2c9, Offset: 0x132bc
// Size: 0x3b, Type: bool
function playerkilled_washitbyvehicle( meansofdeath, inflictor )
{
    if ( meansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    if ( !isdefined( inflictor ) )
    {
        return false;
    }
    
    if ( !inflictor vehicle::is_vehicle() )
    {
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 1
// Checksum 0x8152cccb, Offset: 0x13300
// Size: 0x17
function function_ed3198984075cea5( shouldforce )
{
    self.playerkilled_forcekillcam = shouldforce;
}

// Namespace damage
// Params 1
// Checksum 0x867840d1, Offset: 0x1331f
// Size: 0x82a
function playerkilled_killcamsetup( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    inflictor = deathdata.inflictor;
    meansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    executionref = deathdata.executionref;
    attackerentnum = deathdata.attackerentnum;
    
    if ( level.gametypebundle.var_c82b3dd90fb96afc && victim.lastattacker )
    {
        lastattacker = victim.lastattacker.owner ?? victim.lastattacker;
        
        if ( inflictor == attacker )
        {
            inflictor = lastattacker;
        }
        
        attacker = lastattacker;
        attackerentnum = lastattacker getentitynumber();
        
        if ( isdefined( lastattacker.guid ) )
        {
            objweapon = victim.attackerdata[ lastattacker.guid ].objweapon;
            meansofdeath = victim.attackerdata[ lastattacker.guid ].smeansofdeath;
        }
        
        executionref = meansofdeath == "MOD_EXECUTION" ? execution::execution_getrefbyplayer( attacker ) : undefined;
    }
    
    classname = attacker.classname ?? "undefined";
    var_1b5ffd708de0aac9 = attacker == victim;
    
    if ( getdvarint( @"scr_debug_final_killcam", 1 ) )
    {
        logstring( "[FINAL KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - data - deathData.doFinalKillcam=" + deathdata.dofinalkillcam + ", meansOfDeath=" + meansofdeath + ", attacker.classname=" + classname + ", attackerIsVictim=" + var_1b5ffd708de0aac9 );
    }
    
    var_d8bc8a418c98a0cc = istrue( attacker.playerkilled_forcekillcam );
    
    if ( var_d8bc8a418c98a0cc )
    {
        deathdata.dokillcam = 1;
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - isKillcamForced - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
    else if ( !isplayer( attacker.owner ?? attacker ) || attacker.assistedsuicide || level.teambased && attacker.team == victim.team || level.var_f73b2c304649d2d6 )
    {
        deathdata.dokillcam = 0;
        deathdata.dofinalkillcam = 0;
        
        if ( getdvarint( @"scr_debug_final_killcam", 1 ) )
        {
            logstring( "[FINAL KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - non-player kill - deathData.doFinalKillcam=" + deathdata.dofinalkillcam );
        }
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - non-player kill - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
    
    if ( !isdefined( deathdata.killcamentity ) )
    {
        deathdata.killcamentity = victim killcam::getkillcamentity( attacker, inflictor, objweapon, meansofdeath );
    }
    
    if ( isdefined( deathdata.killcamentity ) )
    {
        deathdata.killcamentityindex = deathdata.killcamentity getentitynumber();
        deathdata.killcamentitystarttime = deathdata.killcamentity.birthtime;
        
        if ( !isdefined( deathdata.killcamentitystarttime ) )
        {
            deathdata.killcamentitystarttime = 0;
        }
    }
    
    /#
        if ( getdvarint( @"scr_forcekillcam" ) != 0 )
        {
            deathdata.dokillcam = 1;
            
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "<dev string:x346>" + ( victim ? victim.name : "<dev string:x358>" ) + "<dev string:x362>" + "<dev string:x365>" + deathdata.dokillcam );
            }
        }
    #/
    
    if ( inflictor.isracecar )
    {
        deathdata.dokillcam = 1;
    }
    
    if ( getdvarint( @"hash_30599f71c31a04d8", 0 ) )
    {
        if ( deathdata.inflictor vehicle::is_vehicle() )
        {
            var_74a37d3faeb42bb5 = 1;
            deathdata.dokillcam = 0;
        }
    }
    
    if ( deathdata.dokillcam )
    {
        assert( !var_74a37d3faeb42bb5 );
        victim killcam::prekillcamnotify( attacker );
        
        if ( isagent( inflictor ) )
        {
            deathdata.inflictoragentinfo = spawnstruct();
            deathdata.inflictoragentinfo.agent_type = inflictor.agent_type;
            deathdata.inflictoragentinfo.lastspawntime = inflictor.lastspawntime;
        }
    }
    
    deathdata.killcamentstickstovictim = meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_HEAD_SHOT" && isdefined( inflictor ) || meansofdeath == "MOD_GRENADE" || isdefined( victim ) && isdefined( victim.stuckbygrenade ) && isdefined( inflictor ) && victim.stuckbygrenade == inflictor || objweapon.basenamehash == %"hash_1d0617a79d86a480";
    
    if ( !deathdata.iskillstreakweapon || weapon::function_ea0f95c57e71d5b4( objweapon ) )
    {
        killcam::setkillcamnormalweaponomnvars( objweapon, meansofdeath, inflictor, executionref, attacker );
    }
    
    deathdata.var_c9f36c9b6da231a2 = isdefined( inflictor ) && inflictor vehicle::is_vehicle() && ( meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" );
    attackerisvalid = isdefined( attacker ) && isdefined( attacker.classname ) && attacker.classname != "trigger_hurt" && attacker.classname != "worldspawn" && attacker != victim;
    
    if ( level.recordfinalkillcam && deathdata.dofinalkillcam )
    {
        if ( !level.disable_killcam && meansofdeath != "MOD_SUICIDE" && attackerisvalid )
        {
            final_killcam::recordfinalkillcam( 5, victim, attacker, attackerentnum, inflictor, deathdata.killcamentityindex, deathdata.killcamentitystarttime, deathdata.killcamentstickstovictim, objweapon, deathdata.psoffsettime, meansofdeath, deathdata.var_c9f36c9b6da231a2 );
            
            if ( getdvarint( @"scr_debug_final_killcam", 1 ) )
            {
                logstring( "[FINAL KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - record final killcam" );
            }
        }
        else if ( getdvarint( @"scr_debug_final_killcam", 1 ) )
        {
            logstring( "[FINAL KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - skip recording final killcam 2 - level.disable_killcam=" + level.disable_killcam + ", meansOfDeath=" + meansofdeath + ", attackerIsValid=" + attackerisvalid );
        }
    }
    else if ( getdvarint( @"scr_debug_final_killcam", 1 ) )
    {
        logstring( "[FINAL KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_killcamSetup - skip recording final killcam 1 - level.recordFinalKillcam=" + level.recordfinalkillcam + ", deathData.doFinalKillcam=" + deathdata.dofinalkillcam );
    }
    
    /#
        function_b042fa22e449387d( deathdata );
    #/
}

// Namespace damage
// Params 1
// Checksum 0x73647143, Offset: 0x13b51
// Size: 0x271
function playerkilled_deathscene( deathdata )
{
    victim = deathdata.victim;
    victim.var_6db12e4862ea2427 = 1;
    victim endon( #"spawned" );
    
    if ( victim spawncamera::function_7e5668ce5be4b48e() )
    {
        victim spawncamera::function_769148f8af5f7546();
    }
    
    if ( !deathdata.isfauxdeath )
    {
        if ( !isdefined( victim.respawntimerstarttime ) )
        {
            victim.respawntimerstarttime = gettime() + deathdata.deathscenetimems;
        }
        
        if ( player::function_a21ab4e7c3c4cbbc( deathdata ) )
        {
            thread player::deathcam_effects( deathdata.deathscenetimesec, deathdata.meansofdeath );
        }
        
        if ( deathdata.dokillcam )
        {
            deathcamwindow = deathdata.deathscenetimesec + 0.5;
            inputwindow = level.gamemodebundle.var_35284a04e585ef1a;
            
            if ( !isdefined( inputwindow ) )
            {
                inputwindow = deathcamwindow - getdvarfloat( @"hash_4bd6c89e311b7a", 0.5 );
            }
            
            inputwindow = clamp( inputwindow, 0, deathcamwindow );
            thread final_killcam::function_42a11fbfb54cbf4c( inputwindow, deathcamwindow, victim isautoskipkillcam() );
            msg = victim utility::waittill_any_timeout_no_endon_death( deathcamwindow, "killcam_death_button_cancel_no_spawn_point" );
        }
        else
        {
            wait deathdata.deathscenetimesec;
        }
        
        if ( msg == "killcam_death_button_cancel_no_spawn_point" )
        {
            victim.skippedspawnpoint = 1;
            victim.skippedkillcam = 1;
            victim.var_e95cd0c15f8374cb = 1;
        }
        
        if ( deathdata.dokillcam )
        {
            deathdata.dokillcam = isdefined( self.skippedkillcam ) && !self.skippedkillcam;
            
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "playerKilled_deathScene - skippedKillcam - deathData.doKillcam =" + deathdata.dokillcam );
            }
        }
        
        if ( isdefined( victim ) )
        {
            victim notify( #"death_delay_finished" );
            
            if ( getdvarint( @"hash_8d86e6b3c30bfbf1", 1 ) == 1 && !isbrgamemode() )
            {
                victim thread playerlogic::function_85ec963075a77a92();
            }
        }
    }
    else if ( !isdefined( victim.respawntimerstarttime ) )
    {
        victim.respawntimerstarttime = gettime();
    }
    
    /#
        function_b042fa22e449387d( deathdata );
    #/
}

// Namespace damage
// Params 1
// Checksum 0x1ad90ac0, Offset: 0x13dca
// Size: 0x90
function function_db6770b3fd4dba62( deathdata )
{
    if ( !isdefined( deathdata.victim ) )
    {
        return;
    }
    
    if ( !isdefined( level.gametypebundle.var_90dc7492c941db1a ) || level.gametypebundle.var_90dc7492c941db1a <= 0 )
    {
        return;
    }
    
    deathdata.victim setclientomnvar( "ui_show_dead_result_screen", 1 );
    wait level.gametypebundle.var_90dc7492c941db1a;
    deathdata.victim setclientomnvar( "ui_show_dead_result_screen", 0 );
}

// Namespace damage
// Params 1
// Checksum 0x8d9690d1, Offset: 0x13e62
// Size: 0x755
function playerkilled_killcam( var_5bbff34739bd683f )
{
    deathdata = var_5bbff34739bd683f;
    
    if ( !isdefined( deathdata.victim ) )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "playerKilled_killcam - !isdefined( deathData.victim )" );
        }
        
        return;
    }
    
    deathtime = deathdata.victim.deathtime;
    
    if ( getdvarint( @"hash_98f5c716d594181b", 1 ) && isdefined( deathdata.victim.laststanddowneddata ) )
    {
        deathdata = deathdata.victim.laststanddowneddata;
        deathdata.victim.laststanddowneddata = undefined;
        deathdata.dokillcam = deathdata.dokillcam && isplayer( deathdata.attacker );
        deathtime = deathdata.deathtime;
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "playerKilled_killcam - deathData.victim.lastStandDownedData - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
    
    if ( isdefined( level.modevalidatekillcam ) )
    {
        [[ level.modevalidatekillcam ]]( deathdata );
    }
    
    if ( !isdefined( deathtime ) )
    {
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "playerKilled_killcam - !IsDefined( deathTime )" );
        }
        
        return;
    }
    
    if ( isdefined( level.finalkillcamskipteamremaining ) )
    {
        result = deathdata.victim [[ level.finalkillcamskipteamremaining ]]();
        
        if ( result )
        {
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "playerKilled_killcam - level.finalKillcamSkipTeamRemaining" );
            }
            
            return;
        }
    }
    
    deathdata.victim endon( #"spawned" );
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    postdeathdelay = ( gettime() - deathtime ) / 1000;
    
    if ( !victim.cancelkillcam && deathdata.dokillcam && level.killcam && game_utility_mp::getgamestate( victim ) == "playing" && ( !victim utility::isusingremote() || victim.var_1df90882c6490925 ) && !level.showingfinalkillcam && !level.var_a5ecc4fd7d64db7b )
    {
        pbgpostfxbundlekillall( victim );
        timeuntilspawn = playerlogic::timeuntilspawn( 1 );
        attackerperks = [];
        defaultperks = class::function_c8d9816a5c9f1f97( attacker );
        perklist = attacker.loadoutperks;
        
        if ( isdefined( attacker.pers[ "loadoutPerks" ] ) && !isdefined( perklist ) )
        {
            perklist = attacker.pers[ "loadoutPerks" ];
        }
        
        if ( isdefined( perklist ) )
        {
            var_71738c7fede5bb2b = !isdefined( defaultperks ) || defaultperks.size == 0;
            
            foreach ( perk in perklist )
            {
                if ( !isdefined( perk ) )
                {
                    continue;
                }
                
                if ( perk != "" && perk != "none" && perk != "specialty_null" && !arraycontains( attackerperks, perk ) && !level.perkbundles[ perk ].hideinkillcam && ( var_71738c7fede5bb2b || !arraycontains( defaultperks, perk ) ) )
                {
                    attackerperks[ attackerperks.size ] = perk;
                }
            }
        }
        else if ( isdefined( attacker.pers ) )
        {
            foreach ( perkarr in [ "loadoutStandardPerks", "loadoutExtraPerks" ] )
            {
                if ( isdefined( attacker.pers[ perkarr ] ) )
                {
                    foreach ( perk in attacker.pers[ perkarr ] )
                    {
                        if ( !isdefined( perk ) )
                        {
                            continue;
                        }
                        
                        if ( perk != "" && perk != "none" && perk != "specialty_null" && !arraycontains( attackerperks, perk ) && !level.perkbundles[ perk ].hideinkillcam )
                        {
                            attackerperks[ attackerperks.size ] = perk;
                        }
                    }
                }
            }
        }
        
        if ( !level.disablecopycatloadout )
        {
            victim thread startcopycatoption( attacker );
        }
        
        skippable = 1;
        victim killcam::killcam( deathdata.inflictor, deathdata.inflictoragentinfo, deathdata.attackerentnum, deathdata.killcamentityindex, deathdata.killcamentitystarttime, undefined, deathdata.killcamentstickstovictim, deathdata.objweapon, postdeathdelay, deathdata.psoffsettime, deathdata.attackerlastspawntime, timeuntilspawn, gamelogic_mp::timeuntilroundend(), attacker, victim, deathdata.meansofdeath, attackerperks, skippable, undefined, undefined, undefined, deathdata.var_c9f36c9b6da231a2 );
        
        if ( isdefined( victim ) && !level.disablecopycatloadout )
        {
            victim thread stopcopycatoption();
        }
        
        if ( isdefined( level.onpostkillcamcallback ) )
        {
            [[ level.onpostkillcamcallback ]]();
        }
    }
    
    if ( isdefined( victim ) )
    {
        victim.willshowkillcam = 0;
    }
    
    if ( victim.var_6db12e4862ea2427 )
    {
        victim.var_6db12e4862ea2427 = 0;
        victim notify( #"death_scene_ended" );
    }
    
    /#
        function_b042fa22e449387d( var_5bbff34739bd683f );
    #/
}

// Namespace damage
// Params 1
// Checksum 0xc2fe0eb2, Offset: 0x145bf
// Size: 0x13d
function playerkilled_spawn( deathdata )
{
    victim = deathdata.victim;
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    if ( isdefined( level.modeplayerkilledspawn ) && [[ level.modeplayerkilledspawn ]]( deathdata, 1 ) )
    {
        return;
    }
    
    if ( victim.liveragdoll )
    {
        return;
    }
    
    victim endon( #"spawned" );
    victim endon( #"disconnect" );
    attacker = deathdata.attacker;
    victim resetplayervariables();
    victim resetplayeromnvarsonspawn();
    
    if ( isdefined( attacker ) )
    {
        victim.lastattacker = attacker;
    }
    else
    {
        victim.lastattacker = undefined;
    }
    
    victim.wantsafespawn = 0;
    
    if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
    {
        victim adjustvoxelhead( 1 );
    }
    
    if ( game_utility_mp::getgamestate( victim ) != "playing" )
    {
        if ( !level.showingfinalkillcam )
        {
            victim player::updatesessionstate( "dead" );
            victim player::clearkillcamstate();
        }
        
        return;
    }
    
    if ( class::isvalidclass( victim.class ) )
    {
        victim thread playerlogic::spawnclient();
    }
}

// Namespace damage
// Params 12
// Checksum 0xfa945d3c, Offset: 0x14704
// Size: 0x177
function playerkilled_internal( inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath )
{
    profilestart();
    victim endon( #"spawned" );
    
    if ( game_utility_mp::getgamestate( victim ) == "postgame" )
    {
        if ( isdefined( victim.pers[ "telemetry" ] ) )
        {
            victim.pers[ "telemetry" ].is_early_disconnect = 0;
        }
        
        if ( meansofdeath == "MOD_TRIGGER_HURT" || damageflags & 2097152 )
        {
            deathdata = victim playerkilled_initdeathdata( inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath );
            deathdata.var_ae4cca4af25048d0 = 1;
            playerkilled_parameterfixup( deathdata );
            playerkilled_precalc( deathdata );
            function_932d988168d7ec5( deathdata );
        }
        
        profilestop();
        return;
    }
    
    deathdata = victim playerkilled_initdeathdata( inflictor, attacker, victim, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, isfauxdeath );
    playerkilled_parameterfixup( deathdata );
    playerkilled_precalc( deathdata );
    playerkilled_sharedlogic_early( deathdata );
    playerkilled_handledeathtype( deathdata );
    playerkilled_sharedlogic_late( deathdata );
    childthread function_9f82c62eb4e06219( deathdata );
    profilestop();
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0x2ebd5f37, Offset: 0x14883
// Size: 0x30
function private function_9f82c62eb4e06219( deathdata )
{
    playerkilled_deathscene( deathdata );
    function_db6770b3fd4dba62( deathdata );
    playerkilled_killcam( deathdata );
    playerkilled_spawn( deathdata );
}

// Namespace damage
// Params 0
// Checksum 0x255dbfb5, Offset: 0x148bb
// Size: 0x13, Type: bool
function isswitchingteams()
{
    if ( isdefined( self.switching_teams ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 0
// Checksum 0x162adf2f, Offset: 0x148d7
// Size: 0x46, Type: bool
function isteamswitchbalanced()
{
    playercounts = teams::countplayers();
    playercounts[ self.leaving_team ]--;
    playercounts[ self.joining_team ]++;
    return playercounts[ self.joining_team ] - playercounts[ self.leaving_team ] < 2;
}

// Namespace damage
// Params 2
// Checksum 0xfc260426, Offset: 0x14926
// Size: 0x7f, Type: bool
function isfriendlyfire( victim, attacker )
{
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( !isplayer( attacker ) && !isdefined( attacker.team ) )
    {
        return false;
    }
    
    if ( victim.team != attacker.team )
    {
        return false;
    }
    
    if ( victim == attacker )
    {
        return false;
    }
    
    if ( level.ignorefriendlyfire )
    {
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 1
// Checksum 0xc2fb6021, Offset: 0x149ae
// Size: 0x23, Type: bool
function killedself( attacker )
{
    if ( !isplayer( attacker ) )
    {
        return false;
    }
    
    if ( attacker != self )
    {
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 0
// Checksum 0xc83ef1e5, Offset: 0x149da
// Size: 0x153
function handleteamchangedeath()
{
    if ( !level.teambased )
    {
        return;
    }
    
    assert( self.leaving_team != self.joining_team );
    
    if ( self.joining_team == "spectator" || !isteamswitchbalanced() )
    {
        playerstats_interface::addtoplayerstat( 1, "combatStats", "suicides" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "suicides" ] ) )
            {
                self.leaderboarddata[ "suicides" ] = self.leaderboarddata[ "suicides" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "suicides" ] ) )
            {
                [[ level.leaderboardfunc[ "suicides" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
            
            if ( isdefined( self.pers[ "suicides" ] ) )
            {
                self.pers[ "suicides" ] = self.pers[ "suicides" ] + 1;
            }
        }
    }
    
    if ( isdefined( level.onteamchangedeath ) )
    {
        [[ level.onteamchangedeath ]]( self );
    }
    
    level notify( #"hash_d2e4f945874471d" );
}

// Namespace damage
// Params 3
// Checksum 0x9f1938b9, Offset: 0x14b35
// Size: 0x96
function function_c34797baf24976a1( victim, attacker, deathdata )
{
    if ( isagent( attacker ) || teams::function_f2b980a5ef176703( attacker.team ) )
    {
        deathdata.dokillcam = 1;
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "handleWorldDeath - IsAgent( attacker ) - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
}

// Namespace damage
// Params 5
// Checksum 0xa9703e33, Offset: 0x14bd3
// Size: 0x1c0
function handleworlddeath( deathdata, attacker, lifeid, smeansofdeath, shitloc )
{
    victim = deathdata.victim;
    victim.deathspectatepos = victim.origin;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    events::playerworlddeath( attacker, smeansofdeath );
    
    if ( !isdefined( attacker.team ) || attacker.team == "neutral" || attacker.team == "free" || attacker == victim )
    {
        handlesuicidedeath( deathdata, smeansofdeath, shitloc );
        return;
    }
    
    assert( isagent( attacker ) || team_utility::isgameplayteam( attacker.team ) || teams::function_f2b980a5ef176703( attacker.team ) );
    
    if ( level.teambased && attacker.team != self.team || !level.teambased )
    {
        if ( isdefined( level.onnormaldeath ) && ( isplayer( attacker ) || isagent( attacker ) ) && attacker.team != "spectator" || isdefined( attacker.damagetrigger ) )
        {
            if ( !level.gameended )
            {
                [[ level.onnormaldeath ]]( self, attacker, lifeid, smeansofdeath );
            }
        }
    }
    
    function_c34797baf24976a1( attacker, deathdata );
    
    if ( isagent( attacker ) || teams::function_f2b980a5ef176703( attacker.team ) )
    {
        thread handlenormaldeath_sounds( attacker, victim, smeansofdeath );
    }
}

// Namespace damage
// Params 3
// Checksum 0xb9e92b58, Offset: 0x14d9b
// Size: 0x1f3
function handlesuicidedeath( deathdata, smeansofdeath, shitloc )
{
    playerstats_interface::addtoplayerstat( 1, "combatStats", "suicides" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "suicides" ] ) )
        {
            self.leaderboarddata[ "suicides" ] = self.leaderboarddata[ "suicides" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "suicides" ] ) )
        {
            [[ level.leaderboardfunc[ "suicides" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
        
        if ( isdefined( self.pers[ "suicides" ] ) )
        {
            self.pers[ "suicides" ] = self.pers[ "suicides" ] + 1;
        }
    }
    
    codcasterclientmatchdata::function_e7a75c10db88c294( 6, 0 );
    scoresub = getdvarint( @"scr_game_suicidepointloss", 0 );
    gamescore::setplayerscore( self, gamescore::getplayerscore( self ) - scoresub );
    
    if ( deathdata.var_2ce16cf2dc2c23b5 && smeansofdeath == "MOD_SUICIDE" && shitloc == "none" )
    {
        self.lastgrenadesuicidetime = deathdata.deathtime ?? gettime();
        armor::setarmorhealth( 0, 1 );
    }
    
    if ( isdefined( level.onsuicidedeath ) )
    {
        [[ level.onsuicidedeath ]]( self );
    }
    
    if ( isdefined( level.onplayerkilledcallback ) )
    {
        self [[ level.onplayerkilledcallback ]]( undefined, 0 );
    }
    
    self notify( #"player_suicide_death" );
    self.suicidespawndelay = 1;
    
    if ( isdefined( self.friendlydamage ) )
    {
        self.friendlyfiredeath = 1;
    }
    
    thread function_5ba31dddfc2eb877( deathdata, smeansofdeath );
}

// Namespace damage
// Params 1
// Checksum 0xab2943d0, Offset: 0x14f96
// Size: 0x2e9
function handlefriendlyfiredeath( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    meansofdeath = deathdata.meansofdeath;
    attacker thread battlechatter_mp::trysaylocalsound( attacker, #"bc_combat_killfirm_friendly", 0.75 );
    nearbyfriendly = attacker battlechatter_mp::function_6616b20c4b7f2923( victim geteye(), level.var_295625aa04d53bea );
    
    if ( isdefined( nearbyfriendly ) )
    {
        nearbyfriendly thread battlechatter_mp::trysaylocalsound( nearbyfriendly, #"bc_combat_killfirm_friendly_react", 2.75 );
    }
    
    var_781c9305cc23da2e = 0;
    
    if ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" )
    {
        var_a91372bf2ae4d5a7 = getxhash( game_utility_mp::getbasegametype() );
        
        if ( var_a91372bf2ae4d5a7 == #"control" || var_a91372bf2ae4d5a7 == #"koth" )
        {
            if ( victim.isonobjective )
            {
                var_781c9305cc23da2e = 1;
            }
        }
    }
    else if ( deathdata.iskillstreakweapon )
    {
        var_781c9305cc23da2e = 1;
    }
    
    if ( deathdata.var_2064b425f9abe07c )
    {
        return;
    }
    
    if ( var_781c9305cc23da2e && attacker.pers[ "teamkills" ] < level.maxallowedteamkills )
    {
        return;
    }
    
    attacker thread rank::scoreeventpopup( #"teamkill" );
    attacker.pers[ "teamkills" ] = attacker.pers[ "teamkills" ] + 1;
    
    if ( isdefined( level.var_b1c69282cd1f88ba ) )
    {
        [[ level.var_b1c69282cd1f88ba ]]();
    }
    
    victim codcasterclientmatchdata::function_e7a75c10db88c294( 6, 0 );
    
    if ( getdvarint( @"scr_team_teamkillpointloss", 0 ) )
    {
        scoresub = rank::getscoreinfovalue( #"kill" ) ?? 0;
        gamescore::setplayerscore( attacker, gamescore::getplayerscore( attacker ) - scoresub );
    }
    
    if ( level.maxallowedteamkills < 0 )
    {
        return;
    }
    
    teamkilldelay = attacker playerlogic::teamkilldelay();
    
    if ( teamkilldelay > 0 )
    {
        attacker.pers[ "teamKillPunish" ] = 1;
        attacker notify( #"team_kill_punish" );
        
        if ( attacker utility::isusingremote() )
        {
            attacker thread suicide_on_end_remote();
        }
        else
        {
            attacker thread suicide_on_alive();
        }
    }
    
    if ( level.friendlyfire == 4 )
    {
        if ( !attacker.pers[ "hitFFLimit" ] && attacker.pers[ "teamkills" ] >= level.maxallowedteamkills )
        {
            attacker.pers[ "hitFFLimit" ] = 1;
            attacker hud_message::showerrormessage( %"mp/friendly_fire_punish_switch" );
            return;
        }
        
        if ( level.var_92336756f4268acc )
        {
            attacker hud_message::showerrormessage( %"mp/friendly_fire_will_not" );
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x4ff4474b, Offset: 0x15287
// Size: 0x673
function handleinlaststanddeath( deathdata )
{
    /#
        if ( isbot( deathdata.victim ) && getdvarint( @"hash_e125675f281d4f47", 0 ) == 1 )
        {
            deathdata.dokillcam = 0;
            
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "<dev string:x346>" + ( deathdata.victim ? deathdata.victim.name : "<dev string:x358>" ) + "<dev string:x362>" + "<dev string:x3a9>" + deathdata.dokillcam );
            }
            
            [ attacker, inflictor, objweapon, meansofdeath, iskillstreakweapon ] = function_c9cd6450ceee53ef( deathdata );
            
            if ( isdefined( attacker ) )
            {
                thread handlenormaldeath_sounds( attacker, self, meansofdeath );
            }
            
            return;
        }
    #/
    
    if ( isdefined( level.checkforlaststandwipe ) )
    {
        [[ level.checkforlaststandwipe ]]( self, 1 );
    }
    
    if ( isdefined( deathdata.victim.var_e988ab84618d4592.attacker ) )
    {
        info = deathdata.victim.var_e988ab84618d4592;
        info.attacker [[ info.collateralhandler ]]( info.shotcount );
        deathdata.victim.var_e988ab84618d4592 = undefined;
    }
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        [ attacker, inflictor, objweapon, meansofdeath, iskillstreakweapon ] = function_c9cd6450ceee53ef( deathdata );
        
        if ( !isdefined( attacker ) )
        {
            infostring = ( inflictor.name ?? deathdata.attacker.name ) + " | ";
            infostring += ( self.name ?? deathdata.victim.name ) + " | ";
            infostring += ( self.origin[ 0 ] ?? deathdata.victim.origin[ 0 ] ) + " | ";
            infostring += ( self.origin[ 1 ] ?? deathdata.victim.origin[ 1 ] ) + " | ";
            infostring += ( self.origin[ 2 ] ?? deathdata.victim.origin[ 2 ] ) + " | ";
            infostring += ( deathdata.hitloc ?? "unknown_hitloc" ) + " | ";
            infostring += ( meansofdeath ?? deathdata.meansofdeath ) + " | ";
            infostring += ( objweapon.basename ?? deathdata.objweapon.basename ) + " | ";
            script::demoforcesre( "[handleNormalDeath] : undefined attacker. " + infostring );
        }
        
        if ( isdefined( self.attackers ) )
        {
            foreach ( var_69a07fe9e172e8b0 in self.attackers )
            {
                if ( !isdefined( var_69a07fe9e172e8b0 ) )
                {
                    continue;
                }
                
                if ( !isdefined( attacker ) || var_69a07fe9e172e8b0 == attacker )
                {
                    continue;
                }
                
                if ( !isdefined( var_69a07fe9e172e8b0.modifiers ) )
                {
                    var_69a07fe9e172e8b0.modifiers = [];
                }
            }
        }
        
        handlenormaldeath( deathdata.lifeid, attacker, inflictor, objweapon, meansofdeath, self, iskillstreakweapon, deathdata, 0 );
    }
    else
    {
        if ( !deathdata.victim.disable_killcam )
        {
            deathdata.dokillcam = 1;
            
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "handleInLastStandDeath - deathData.victim.disable_killcam - deathData.doKillcam=" + deathdata.dokillcam );
            }
        }
        
        if ( !deathdata.iskillstreakweapon )
        {
            deathdata.attacker thread points::function_aa3f27bc29d005fc( #"last_stand_kill", deathdata.objweapon, deathdata.victim );
        }
        
        if ( isdefined( self.laststandattacker ) )
        {
            self.laststandattacker playerincrementscoreboardkills( self );
        }
        
        var_6e7e37660efa182d = undefined;
        
        if ( isdefined( self.laststandattacker ) && deathdata.attacker != self.laststandattacker )
        {
            var_6e7e37660efa182d = 1;
            thread challenges::onplayerkilled( self, self.laststandattacker, self.laststandattacker, 0, deathdata.damageflags, self.laststandmeansofdeath, self.var_a54cf862f580156, self.laststandattackermodifiers );
            
            if ( isdefined( level.onplayerkilledcallback ) )
            {
                self [[ level.onplayerkilledcallback ]]( self.laststandattacker, 0 );
            }
            
            self.laststandattacker thread rank::scoreeventpopup( #"kill_confirmed" );
        }
        
        var_53387a1f0a9c7454 = 0;
        
        if ( var_6e7e37660efa182d )
        {
            var_53387a1f0a9c7454 = 1;
        }
        
        handlenormaldeath( deathdata.lifeid, deathdata.attacker, deathdata.inflictor, deathdata.objweapon, deathdata.meansofdeath, self, deathdata.iskillstreakweapon, deathdata, 1, var_53387a1f0a9c7454 );
    }
    
    self.laststandattacker = undefined;
    self.laststandinflictor = undefined;
    self.laststandmeansofdeath = undefined;
    self.var_a54cf862f580156 = undefined;
    self.var_3242e03bf1b09197 = undefined;
    self.var_8f849ee66df5a544 = undefined;
    self.laststandattackermodifiers = undefined;
}

// Namespace damage
// Params 1
// Checksum 0x788ec468, Offset: 0x15902
// Size: 0x38
function function_da48b845398f72a0( var_80efff15f84c37ab )
{
    if ( !isdefined( var_80efff15f84c37ab ) )
    {
        return "";
    }
    
    var_d44cba3081792cb4 = function_7692109e08424123( var_80efff15f84c37ab );
    
    if ( var_d44cba3081792cb4 )
    {
        return var_d44cba3081792cb4;
    }
    
    return "";
}

// Namespace damage
// Params 2, eflags: 0x4
// Checksum 0x2b72c008, Offset: 0x15943
// Size: 0x8b
function private function_50ef512eaaef426( attacker, objweapon )
{
    sound = undefined;
    
    if ( attacker.var_cbd4681f351fbad2 )
    {
        bundle = level.superglobals.staticsuperdata[ "super_spykit" ].bundle;
        sound = bundle.var_a763723cb7131651;
    }
    
    if ( !isdefined( sound ) || sound == #"" )
    {
        sound = function_5bff66f44c55afa( objweapon );
    }
    
    return sound;
}

// Namespace damage
// Params 6
// Checksum 0x44222c08, Offset: 0x159d7
// Size: 0x588
function handlenormaldeath_sounds( attacker, victim, smeansofdeath, einflictor, var_80efff15f84c37ab, hitloc )
{
    var_a68a6be2544b34fe = 0;
    ent = victim;
    
    if ( !isdefined( attacker.lastkillalertsoundtime ) )
    {
        attacker.lastkillalertsoundtime = gettime();
        var_a68a6be2544b34fe = 1;
    }
    else if ( gettime() > attacker.lastkillalertsoundtime + 700 )
    {
        attacker.lastkillalertsoundtime = gettime();
        var_a68a6be2544b34fe = 1;
    }
    
    var_2c7d040023182003 = !game_utility::function_d3f8957534dc62af() || getdvarint( @"hash_c2989c398361dbb3", 0 ) != 0;
    var_d7a5198696ce52c1 = game_utility::function_d3f8957534dc62af() && getdvarint( @"hash_58f2c5b698828174", 0 ) != 0;
    
    if ( function_193057578506a224() )
    {
    }
    else if ( isagent( attacker ) )
    {
        if ( !utility::isbulletdamage( smeansofdeath ) || isdefined( einflictor ) && attacker != einflictor )
        {
        }
        else if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            ent playsoundtoplayer( #"bullet_impact_headshot_plr", victim );
            ent playsoundtoteam( #"bullet_impact_headshot", victim.team, victim );
        }
        else
        {
            ent playsoundtoteam( #"hash_7c2620190d95c6a4", victim.team );
        }
    }
    else if ( !utility::isbulletdamage( smeansofdeath ) || isdefined( einflictor ) && attacker != einflictor )
    {
        if ( var_a68a6be2544b34fe )
        {
            if ( smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
            {
                soundtoplay = hashcat( #"mp_kill_alert", function_da48b845398f72a0( var_80efff15f84c37ab ) );
                
                if ( isplayer( attacker ) )
                {
                    ent playsoundtoplayer( soundtoplay, attacker );
                }
            }
            else if ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" )
            {
                soundtoplay = hashcat( #"mp_kill_alert_exp", function_da48b845398f72a0( var_80efff15f84c37ab ) );
                
                if ( isplayer( attacker ) && soundexists( soundtoplay ) )
                {
                    ent playsoundtoplayer( soundtoplay, attacker );
                }
                else if ( isplayer( attacker ) )
                {
                    ent playsoundtoplayer( #"mp_kill_alert_quiet", attacker );
                }
            }
            else if ( isplayer( attacker ) )
            {
                if ( smeansofdeath == "MOD_HEAD_SHOT" )
                {
                    if ( isplayer( attacker ) )
                    {
                        ent playsoundtoplayer( #"bullet_impact_headshot_npc", attacker );
                        
                        if ( var_a68a6be2544b34fe )
                        {
                            ent playsoundtoplayer( #"mp_headshot_alert", attacker );
                        }
                    }
                }
                else if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
                {
                    if ( isplayer( attacker ) )
                    {
                        ent playsoundtoplayer( #"mp_kill_alert", attacker );
                    }
                }
                else
                {
                    ent playsoundtoplayer( #"mp_kill_alert_quiet", attacker );
                }
            }
        }
    }
    else if ( smeansofdeath == "MOD_HEAD_SHOT" && var_2c7d040023182003 )
    {
        if ( isplayer( victim ) )
        {
            ent playsoundtoplayer( #"bullet_impact_headshot_plr", victim );
        }
        
        if ( isplayer( attacker ) )
        {
            ent playsoundtoplayer( #"bullet_impact_headshot_npc", attacker );
            
            if ( var_a68a6be2544b34fe )
            {
                soundtoplay = hashcat( #"mp_headshot_alert", function_da48b845398f72a0( var_80efff15f84c37ab ) );
                ent playsoundtoplayer( soundtoplay, attacker );
            }
        }
        
        if ( isplayer( victim ) )
        {
            ent playsoundtoteam( #"bullet_impact_headshot", victim.team, victim );
        }
        
        if ( isplayer( attacker ) )
        {
            ent playsoundtoteam( #"bullet_impact_headshot", attacker.team, attacker );
        }
    }
    else
    {
        if ( isplayer( victim ) )
        {
            ent playsoundtoteam( #"hash_7c2620190d95c6a4", victim.team );
        }
        
        if ( isplayer( attacker ) )
        {
            ent playsoundtoteam( #"hash_7c2620190d95c6a4", attacker.team, attacker );
        }
        
        if ( var_a68a6be2544b34fe )
        {
            killalert = var_d7a5198696ce52c1 ? #"mp_kill_alert_quiet" : #"mp_kill_alert";
            
            if ( !var_d7a5198696ce52c1 )
            {
                killalert = hashcat( killalert, function_da48b845398f72a0( var_80efff15f84c37ab ) );
            }
            
            ent playsoundtoplayer( killalert, attacker );
        }
    }
    
    if ( isdefined( var_80efff15f84c37ab ) )
    {
        if ( isplayer( victim ) )
        {
            if ( !isdefined( victimdeathsound ) )
            {
                victimdeathsound = function_50ef512eaaef426( attacker, var_80efff15f84c37ab );
            }
            
            victim function_402ee208d206742e( smeansofdeath );
            victim setentitysoundcontext( "deaths_door", "", 0.1 );
            victim damage_effects::function_e8cba6f10a4635e9();
            victim notify( #"deaths_door_exit" );
            victim.deathsdoor = 0;
            
            if ( getdvarint( @"hash_4392ab54b296ef96", 0 ) != 0 )
            {
                if ( victimdeathsound )
                {
                    victim playlocalsound( victimdeathsound );
                }
            }
        }
        
        if ( isplayer( victim ) || isagent( victim ) )
        {
            if ( getdvarint( @"hash_4392ab54b296ef96", 0 ) != 0 )
            {
                var_2e8d3582569ede4 = function_4100cc9c7e94bee8( var_80efff15f84c37ab );
                var_b448f143862aa9d9 = function_70c471b56770053d( var_80efff15f84c37ab );
                
                if ( ( isplayer( attacker ) || isagent( attacker ) ) && isdefined( var_2e8d3582569ede4 ) && var_2e8d3582569ede4 != "" )
                {
                    if ( isplayer( victim ) )
                    {
                        attacker playsoundtoteam( var_2e8d3582569ede4, victim.team );
                    }
                    
                    attacker playsoundtoteam( var_2e8d3582569ede4, attacker.team, attacker );
                }
                
                if ( isplayer( attacker ) && isdefined( var_b448f143862aa9d9 ) && var_b448f143862aa9d9 != "" )
                {
                    attacker playlocalsound( var_b448f143862aa9d9 );
                }
            }
        }
    }
}

// Namespace damage
// Params 2
// Checksum 0xe7245500, Offset: 0x15f67
// Size: 0x62
function function_5ba31dddfc2eb877( deathdata, smeansofdeath )
{
    if ( isplayer( self ) )
    {
        function_402ee208d206742e( smeansofdeath );
        self setentitysoundcontext( "deaths_door", "", 0.1 );
        thread damage_effects::function_e8cba6f10a4635e9();
        thread function_8ec92004bd02bfa6( deathdata, smeansofdeath );
        self notify( #"deaths_door_exit" );
        self.deathsdoor = 0;
    }
}

// Namespace damage
// Params 2
// Checksum 0x8cac0cf3, Offset: 0x15fd1
// Size: 0x96
function function_8ec92004bd02bfa6( deathdata, smeansofdeath )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( deathdata.objweapon.classname == "grenade" && smeansofdeath == "MOD_SUICIDE" )
    {
        if ( self getscriptableparthasstate( "bloody_mist", "suicide_frag" ) )
        {
            self setscriptablepartstate( "bloody_mist", "suicide_frag" );
            self waittill( #"spawned" );
            self setscriptablepartstate( "bloody_mist", "off" );
        }
    }
}

// Namespace damage
// Params 0
// Checksum 0xb871d8f7, Offset: 0x1606f
// Size: 0xc, Type: bool
function function_193057578506a224()
{
    return istrue( level.var_d5c2787fbd88bebd );
}

// Namespace damage
// Params 2
// Checksum 0xa26968ec, Offset: 0x16084
// Size: 0x14c
function handlenormaldeathkillcam( victim, deathdata )
{
    deathdata.dokillcam = 1;
    
    if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
    {
        logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "handleNormalDeath - set true - deathData.doKillcam=" + deathdata.dokillcam );
    }
    
    if ( isai( victim ) )
    {
        deathdata.dokillcam = victim bots::bot_should_do_killcam();
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "handleNormalDeath - bot should_do_killcam - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
    
    if ( level.disable_killcam || victim.disable_killcam )
    {
        deathdata.dokillcam = 0;
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "handleNormalDeath - level.disable_killcam - deathData.doKillcam=" + deathdata.dokillcam );
        }
    }
}

// Namespace damage
// Params 10
// Checksum 0xe1eeab3, Offset: 0x161d8
// Size: 0x271c
function handlenormaldeath( lifeid, attacker, einflictor, objweapon, smeansofdeath, victim, iskillstreakweapon, deathdata, var_454ae2b026d4a8a6, var_53387a1f0a9c7454 )
{
    attacker.var_e111789bdf9bcbda = {};
    
    if ( smeansofdeath == "MOD_GRENADE" && einflictor == attacker )
    {
        addattacker( victim, attacker, einflictor, objweapon, deathdata.damage, ( 0, 0, 0 ), deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, smeansofdeath );
    }
    
    handlenormaldeathkillcam( victim, deathdata );
    attacker callback::callback( #"hash_244314ef9125e636", deathdata );
    deathdata.var_753c947650e223ce = 1;
    attacker thread events::killedplayer( lifeid, self, objweapon, smeansofdeath, einflictor, deathdata );
    
    if ( attacker gameplay_telemetry_utils::function_944c6d9098e40dfb( victim ) )
    {
        statsweapon = attacker weapon_utility::function_8097c50c526bd683( objweapon );
        ismeleedamage = smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_TAKEDOWN";
        
        if ( weapon_utility::isbulletweapon( statsweapon ) || weapon_utility::function_c1972d0d01397a22( statsweapon ) || weapon_utility::isgrenadeweapon( statsweapon ) || ismeleedamage || statsweapon.isalternate )
        {
            attacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_kills", statsweapon.basename, 3 );
            weapkills = attacker.pers[ "weap_kills" ][ statsweapon.basename ] ?? 0;
            weapdeaths = attacker.pers[ "weap_deaths" ][ statsweapon.basename ] ?? 0;
            weaponkd = weapkills / max( weapdeaths, 1 );
            attacker gameplay_telemetry::function_83a6a8db9fcbb065( "weap_kdratio", statsweapon.basename, 3, weaponkd, 0 );
            
            if ( isplayer( attacker ) && attacker ismeatshieldattacker() )
            {
                if ( !isdefined( attacker.meat_shield_eliminations ) )
                {
                    attacker.meat_shield_eliminations = 0;
                }
                
                attacker.meat_shield_eliminations++;
            }
            
            attacker gameplay_telemetry::function_10952c3c9a272c6d( statsweapon, 2 );
        }
    }
    
    if ( !level.disablestattracking )
    {
        self.var_4b4aee614c039b = isdefined( self.lastattackedshieldplayer ) && isdefined( self.lastattackedshieldtime ) && self.lastattackedshieldplayer != attacker;
        
        if ( getdvarint( @"hash_dda9d67c21b0f4b4", 0 ) )
        {
            victim thread challenges::onplayerkilled( self, einflictor, attacker, deathdata.damage, deathdata.damageflags, smeansofdeath, objweapon, attacker.modifiers );
            
            if ( isdefined( level.onplayerkilledcallback ) )
            {
                self [[ level.onplayerkilledcallback ]]( attacker, istrue( var_53387a1f0a9c7454 ) );
            }
        }
        else if ( !var_53387a1f0a9c7454 )
        {
            victim thread challenges::onplayerkilled( self, einflictor, attacker, deathdata.damage, deathdata.damageflags, smeansofdeath, objweapon, attacker.modifiers );
            
            if ( isdefined( level.onplayerkilledcallback ) )
            {
                self [[ level.onplayerkilledcallback ]]( attacker, 0 );
            }
        }
        
        victim.pers[ "cur_death_streak" ]++;
        
        if ( smeansofdeath == "MOD_HEAD_SHOT" )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
            {
                if ( isdefined( attacker.leaderboarddata[ #"limitheadshots" ] ) )
                {
                    attacker.leaderboarddata[ #"limitheadshots" ] += 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ #"limitheadshots" ] ) )
                {
                    [[ level.leaderboardfunc[ #"limitheadshots" ] ]]( attacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( attacker.pers[ #"limitheadshots" ] ) )
                {
                    attacker.pers[ #"limitheadshots" ] += 1;
                }
            }
            
            if ( !attacker stat_limits::function_608486f90656f2f7( #"limitheadshots" ) )
            {
                attacker playerstats_interface::addtoplayerstat( 1, "combatStats", "headshots" );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "headshots" ] ) )
                    {
                        attacker.leaderboarddata[ "headshots" ] = attacker.leaderboarddata[ "headshots" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "headshots" ] ) )
                    {
                        [[ level.leaderboardfunc[ "headshots" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                    
                    if ( isdefined( attacker.pers[ "headshots" ] ) )
                    {
                        attacker.pers[ "headshots" ] = attacker.pers[ "headshots" ] + 1;
                    }
                }
                
                if ( isbot( victim ) )
                {
                    if ( !isdefined( attacker.pers[ "telemetry" ].bot_headshots ) )
                    {
                        attacker.pers[ "telemetry" ].bot_headshots = 0;
                    }
                    
                    attacker.pers[ "telemetry" ].bot_headshots++;
                }
                
                weaponname = objweapon.basename;
                attacker.headshots = attacker.pers[ "headshots" ];
                attacker gameplay_telemetry::function_383cde919fd850c4( "headShotCount", 3 );
                attacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_headshot_count", weaponname, 1 );
                
                switch ( weaponclass( objweapon ) )
                {
                    case #"hash_8cdaf2e4ecfe5b51":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "arHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "arHeadshots" ] = attacker.leaderboarddata[ "arHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "arHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "arHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "arHeadshots" ] ) )
                            {
                                attacker.pers[ "arHeadshots" ] = attacker.pers[ "arHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_900cb96c552c5e8e":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "smgHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "smgHeadshots" ] = attacker.leaderboarddata[ "smgHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "smgHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "smgHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "smgHeadshots" ] ) )
                            {
                                attacker.pers[ "smgHeadshots" ] = attacker.pers[ "smgHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_690c0d6a821b42e":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "shotgunHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "shotgunHeadshots" ] = attacker.leaderboarddata[ "shotgunHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "shotgunHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "shotgunHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "shotgunHeadshots" ] ) )
                            {
                                attacker.pers[ "shotgunHeadshots" ] = attacker.pers[ "shotgunHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_fa24dff6bd60a12d":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "lmgHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "lmgHeadshots" ] = attacker.leaderboarddata[ "lmgHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "lmgHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "lmgHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "lmgHeadshots" ] ) )
                            {
                                attacker.pers[ "lmgHeadshots" ] = attacker.pers[ "lmgHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_6191aaef9f922f96":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "sniperHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "sniperHeadshots" ] = attacker.leaderboarddata[ "sniperHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "sniperHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "sniperHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "sniperHeadshots" ] ) )
                            {
                                attacker.pers[ "sniperHeadshots" ] = attacker.pers[ "sniperHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_61e969dacaaf9881":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "launcherHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "launcherHeadshots" ] = attacker.leaderboarddata[ "launcherHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "launcherHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "launcherHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "launcherHeadshots" ] ) )
                            {
                                attacker.pers[ "launcherHeadshots" ] = attacker.pers[ "launcherHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_719417cb1de832b6":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "pistolHeadshots" ] ) )
                            {
                                attacker.leaderboarddata[ "pistolHeadshots" ] = attacker.leaderboarddata[ "pistolHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "pistolHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "pistolHeadshots" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                            
                            if ( isdefined( attacker.pers[ "pistolHeadshots" ] ) )
                            {
                                attacker.pers[ "pistolHeadshots" ] = attacker.pers[ "pistolHeadshots" ] + 1;
                            }
                        }
                        
                        break;
                }
            }
        }
        
        if ( einflictor.isequipment && einflictor.equipmentref && attacker )
        {
            switch ( einflictor.equipmentref )
            {
                case #"hash_8c7819f0a3fbd1e0":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "fragKills" ] ) )
                        {
                            attacker.leaderboarddata[ "fragKills" ] = attacker.leaderboarddata[ "fragKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "fragKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "fragKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "fragKills" ] ) )
                        {
                            attacker.pers[ "fragKills" ] = attacker.pers[ "fragKills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_d3a6dc7f9c517e66":
                case #"hash_f0907f858c134cb4":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "semtexKills" ] ) )
                        {
                            attacker.leaderboarddata[ "semtexKills" ] = attacker.leaderboarddata[ "semtexKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "semtexKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "semtexKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "semtexKills" ] ) )
                        {
                            attacker.pers[ "semtexKills" ] = attacker.pers[ "semtexKills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_142a787e36d7d7ce":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "molotovKills" ] ) )
                        {
                            attacker.leaderboarddata[ "molotovKills" ] = attacker.leaderboarddata[ "molotovKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "molotovKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "molotovKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "molotovKills" ] ) )
                        {
                            attacker.pers[ "molotovKills" ] = attacker.pers[ "molotovKills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_2354208d9af64220":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "claymoreKills" ] ) )
                        {
                            attacker.leaderboarddata[ "claymoreKills" ] = attacker.leaderboarddata[ "claymoreKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "claymoreKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "claymoreKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "claymoreKills" ] ) )
                        {
                            attacker.pers[ "claymoreKills" ] = attacker.pers[ "claymoreKills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_184d8c620fb78060":
                case #"hash_9ba0a6ff6081954e":
                case #"hash_acc752b9cde2ff4f":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "throwingKnifeKills" ] ) )
                        {
                            attacker.leaderboarddata[ "throwingKnifeKills" ] = attacker.leaderboarddata[ "throwingKnifeKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "throwingKnifeKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "throwingKnifeKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "throwingKnifeKills" ] ) )
                        {
                            attacker.pers[ "throwingKnifeKills" ] = attacker.pers[ "throwingKnifeKills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_4320d77f90725183":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "c4Kills" ] ) )
                        {
                            attacker.leaderboarddata[ "c4Kills" ] = attacker.leaderboarddata[ "c4Kills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "c4Kills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "c4Kills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "c4Kills" ] ) )
                        {
                            attacker.pers[ "c4Kills" ] = attacker.pers[ "c4Kills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_de4641ddbc44a7ba":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "thermiteKills" ] ) )
                        {
                            attacker.leaderboarddata[ "thermiteKills" ] = attacker.leaderboarddata[ "thermiteKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "thermiteKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "thermiteKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "thermiteKills" ] ) )
                        {
                            attacker.pers[ "thermiteKills" ] = attacker.pers[ "thermiteKills" ] + 1;
                        }
                    }
                    
                    break;
                case #"hash_3995658e01f4fac1":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                    {
                        if ( isdefined( attacker.leaderboarddata[ "proximityMineKills" ] ) )
                        {
                            attacker.leaderboarddata[ "proximityMineKills" ] = attacker.leaderboarddata[ "proximityMineKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "proximityMineKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "proximityMineKills" ] ]]( attacker, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                        
                        if ( isdefined( attacker.pers[ "proximityMineKills" ] ) )
                        {
                            attacker.pers[ "proximityMineKills" ] = attacker.pers[ "proximityMineKills" ] + 1;
                        }
                    }
                    
                    break;
            }
        }
    }
    
    if ( attacker gameplay_telemetry_utils::function_ab5801f54c55eee8( 1 ) )
    {
        headshotnum = attacker gameplay_telemetry::function_42040e5fa41218b3( "weap_headshot_count", objweapon.basename );
        weapkills = attacker gameplay_telemetry::function_42040e5fa41218b3( "weap_kills", objweapon.basename );
        headshotaccuracy = headshotnum / max( weapkills, 1 ) * 100;
        attacker gameplay_telemetry::function_83a6a8db9fcbb065( "weap_headshot_accuracy", objweapon.basename, 1, headshotaccuracy );
    }
    
    if ( einflictor.isracecar )
    {
        return;
    }
    
    thread handlenormaldeath_sounds( attacker, victim, smeansofdeath, einflictor, objweapon, deathdata.hitloc );
    var_42a557281949174a = attacker;
    
    if ( isdefined( attacker.commanding_bot ) )
    {
        var_42a557281949174a = attacker.commanding_bot;
    }
    
    if ( !var_454ae2b026d4a8a6 && !isfriendlyfire( victim, attacker ) )
    {
        attacker function_e75f1e487cc993ea( victim );
        attacker function_89b99953ac074804( attacker, victim, objweapon );
    }
    
    if ( !level.disablestattracking )
    {
        codcasterclientmatchdata::function_e7a75c10db88c294( 6, 0 );
        
        if ( isplayer( attacker ) && !weapon::iskillstreakweapon( objweapon ) && !level.ignorescoring )
        {
            attacker codcasterclientmatchdata::function_35da766061f19c58( 6, 1 );
            consecutivekills = attacker.var_e891936d159d62ad[ 6 ];
            
            if ( !( consecutivekills % 5 ) )
            {
                if ( !isbrgamemode() )
                {
                    codcaster_utils::function_3038b6eafc46c037( 13, attacker.team, attacker getentitynumber(), consecutivekills );
                }
            }
        }
    }
    
    if ( !var_42a557281949174a.pers[ "ignoreWeaponMatchBonus" ] && ( weapon::iscacprimaryweapon( objweapon, deathdata.weapongroup ) || weapon::iscacsecondaryweapon( objweapon, deathdata.weapongroup ) ) )
    {
        if ( !isdefined( var_42a557281949174a.pers[ "weaponMatchBonusKills" ] ) )
        {
            var_42a557281949174a.pers[ "weaponMatchBonusKills" ] = 1;
        }
        else
        {
            var_42a557281949174a.pers[ "weaponMatchBonusKills" ]++;
        }
        
        if ( var_42a557281949174a.pers[ "weaponMatchBonusKills" ] > weaponrank::getgametypekillspermatchmaximum() )
        {
            var_42a557281949174a.pers[ "ignoreWeaponMatchBonus" ] = 1;
            var_42a557281949174a.pers[ "weaponMatchBonusKills" ] = undefined;
            var_42a557281949174a.pers[ "killsPerWeapon" ] = undefined;
        }
        else
        {
            if ( !isdefined( var_42a557281949174a.pers[ "killsPerWeapon" ] ) )
            {
                var_42a557281949174a.pers[ "killsPerWeapon" ] = [];
            }
            
            rootname = weapon::getweaponrootname( objweapon );
            weaponfound = 0;
            
            foreach ( weaponkey, data in var_42a557281949174a.pers[ "killsPerWeapon" ] )
            {
                if ( weaponkey == rootname )
                {
                    data.killcount++;
                    weaponfound = 1;
                    break;
                }
            }
            
            if ( !weaponfound )
            {
                data = spawnstruct();
                data.killcount = 1;
                data.basename = objweapon.basename;
                data.orderindex = var_42a557281949174a.pers[ "killsPerWeapon" ].size;
                var_42a557281949174a.pers[ "killsPerWeapon" ][ rootname ] = data;
            }
        }
    }
    
    attacker.pers[ "cur_death_streak" ] = 0;
    kill_streak_extended = 0;
    
    if ( !level.ignorescoring && ( isalive( attacker ) || !level.gamemodebundle.streaktypeenabled && attacker.streaktype == "support" ) )
    {
        if ( smeansofdeath == "MOD_MELEE" && !attacker killstreak::function_2512509a946854ce() || attacker killstreak::killshouldaddtokillstreak( objweapon ) )
        {
            attacker registerkill( objweapon, smeansofdeath, 1, iskillstreakweapon );
            kill_streak_extended = 1;
        }
    }
    
    if ( kill_streak_extended )
    {
        attacker_cur_kill_streak = attacker.pers[ "cur_kill_streak" ];
        
        if ( attacker_cur_kill_streak > attacker.pers[ "longestStreak" ] )
        {
            attacker.pers[ "longestStreak" ] = attacker_cur_kill_streak;
        }
        
        if ( !game_utility_mp::runleanthreadmode() )
        {
            if ( !level.ignorescoring && attacker_cur_kill_streak > attacker persistence::statgetchild( "round", "killStreak" ) )
            {
                attacker persistence::statsetchild( "round", "killStreak", attacker_cur_kill_streak );
            }
            
            if ( !level.ignorescoring && attacker game_utility_mp::onlinestatsenabled() )
            {
                if ( attacker_cur_kill_streak > attacker.bestlifetimekillstreak )
                {
                    attacker playerstats_interface::setplayerstat( attacker_cur_kill_streak, "bestStats", "killStreak" );
                    attacker.bestlifetimekillstreak = attacker_cur_kill_streak;
                }
            }
        }
        
        attacker events::function_f567912869fad5d4( attacker_cur_kill_streak, victim );
    }
    
    callback::callback( #"hash_5e4c0033a7bbd7f", deathdata );
    deathdata.var_dbf1664ca06180ed = 1;
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        function_1e05f2b200e3e3cc( deathdata );
    }
    else if ( level.gamemodebundle.var_e8db2c40ab74d2e4 )
    {
        attacker function_f81a84e2092d538a( victim, objweapon, einflictor, iskillstreakweapon, smeansofdeath, deathdata );
    }
    else if ( !iskillstreakweapon && !weapon::iskillstreakvehicleinflictor( einflictor ) || points::isforcekillstreakprogressweapon( objweapon ) )
    {
        killscoreevent = #"kill";
        
        if ( isdefined( einflictor.var_be3ca76047281300 ) )
        {
            killscoreevent = einflictor.var_be3ca76047281300;
        }
        
        currentkillcount = attacker.killcountthislife ?? 0;
        attacker thread events::killeventtextpopup( killscoreevent, 0, undefined, { #killcount:currentkillcount, #victim:victim } );
        pointoverride = undefined;
        
        if ( isbrgamemode() && !flags::gameflag( "prematch_done" ) )
        {
            pointoverride = 100;
        }
        
        xpoverride = undefined;
        
        if ( level.var_bf319b0aeb8a0378 )
        {
            xpoverride = getdvarint( @"hash_defd7006efde9127", 100 );
        }
        
        if ( level.var_dd30bf39c0753f31 )
        {
            attacker.var_3f98a27bd6d0f2b3 = 1;
            attacker thread points::doscoreevent( killscoreevent, objweapon, pointoverride, xpoverride, victim );
        }
        else
        {
            attacker thread points::doscoreevent( killscoreevent, objweapon, pointoverride, xpoverride, victim );
        }
        
        attacker bounty::bountyincreasestreak();
        attacker bounty::bountycollect( victim.lastbounty, victim.origin );
    }
    
    attacker.var_e111789bdf9bcbda = undefined;
    scoresub = getdvarint( @"scr_game_deathpointloss", 0 );
    
    if ( level.gunshipplayer == attacker )
    {
        level notify( #"ai_killed", self );
    }
    
    gamescore::setplayerscore( self, gamescore::getplayerscore( self ) - scoresub );
    attacker notify( #"killed_enemy", smeansofdeath, self );
    
    if ( isdefined( level.onnormaldeath ) && isdefined( attacker.pers ) && attacker.pers[ "team" ] != "spectator" && !level.ignorescoring )
    {
        [[ level.onnormaldeath ]]( self, attacker, lifeid, smeansofdeath, objweapon, iskillstreakweapon );
    }
    
    vocallout = undefined;
    
    switch ( victim.loadoutarchetype )
    {
        case #"hash_98ff6f21872f18e0":
            vocallout = "plr_killfirm_warfighter";
            break;
    }
    
    if ( isdefined( vocallout ) )
    {
        level thread battlechatter_mp::saytoself( attacker, vocallout, "plr_killfirm_generic", 0.75 );
    }
    
    if ( self.var_4b4aee614c039b && !level.disablestattracking )
    {
        var_625368c4a614f60d = getdvarint( @"hash_89c66b6f125f4f6", 2500 );
        
        if ( deathdata.deathtime - self.lastattackedshieldtime < var_625368c4a614f60d )
        {
            self.lastattackedshieldplayer thread gamescore::processshieldassist( self );
        }
        else if ( isalive( self.lastattackedshieldplayer ) && deathdata.deathtime - self.lastattackedshieldtime < 5000 )
        {
            forwardvec = vectornormalize( anglestoforward( self.angles ) );
            shieldvec = vectornormalize( self.lastattackedshieldplayer.origin - self.origin );
            
            if ( vectordot( shieldvec, forwardvec ) > 0.925 )
            {
                self.lastattackedshieldplayer thread gamescore::processshieldassist( self );
            }
            else
            {
                self.lastattackedshieldplayer gamescore::function_95bd35d2bd07d736( attacker, self, attacker.team );
            }
        }
        else
        {
            self.lastattackedshieldplayer gamescore::function_95bd35d2bd07d736( attacker, self, attacker.team );
        }
    }
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        gamescore::awardbuffdebuffassists( attacker, self );
    }
    
    var_4230ca77395dae4d = 1;
    
    if ( !level.disablestattracking && isdefined( self.attackers ) )
    {
        foreach ( player in self.attackers )
        {
            if ( isdefined( level.assists_disabled ) )
            {
                continue;
            }
            
            if ( !isdefined( _validateattacker( player ) ) )
            {
                continue;
            }
            
            if ( getdvarint( @"hash_dda9d67c21b0f4b4", 0 ) )
            {
                if ( player == attacker )
                {
                    continue;
                }
            }
            else if ( !var_53387a1f0a9c7454 && player == attacker || var_53387a1f0a9c7454 && player == self.laststandattacker )
            {
                continue;
            }
            
            if ( self == player )
            {
                continue;
            }
            
            if ( isagent( player ) )
            {
                continue;
            }
            
            attackerdata = self.attackerdata[ player.guid ];
            assert( isdefined( attackerdata ) );
            assistweapon = attackerdata.objweapon;
            
            if ( isdefined( level.var_6be9e2dc9b025c26 ) && [[ level.var_6be9e2dc9b025c26 ]]( self, attacker, player, assistweapon ) )
            {
                continue;
            }
            
            if ( level.gamemodebundle.var_7bd25e2787349232 )
            {
                if ( weapon::iskillstreakweapon( assistweapon ) )
                {
                    continue;
                }
                
                var_7bd25e2787349232 = level.gamemodebundle.var_7bd25e2787349232 * 1000;
                
                if ( self.inlaststand )
                {
                    if ( isbrgamemode() )
                    {
                        if ( attackerdata.var_2a11f150d0e7dca4 > 0 )
                        {
                            timesincelastdamaged = self.laststandstarttime - attackerdata.var_2a11f150d0e7dca4;
                            
                            if ( timesincelastdamaged > var_7bd25e2787349232 )
                            {
                                continue;
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }
                    else if ( attackerdata.lasttimedamaged < self.laststandstarttime )
                    {
                        timesincelastdamaged = self.laststandstarttime - attackerdata.lasttimedamaged;
                        
                        if ( timesincelastdamaged > var_7bd25e2787349232 )
                        {
                            continue;
                        }
                    }
                }
                else
                {
                    lasttimedamaged = attackerdata.lasttimedamaged ?? 0;
                    timesincelastdamaged = deathdata.deathtime - lasttimedamaged;
                    var_c97d57b1eadee09e = self ismeatshieldvictim();
                    
                    if ( timesincelastdamaged > var_7bd25e2787349232 && !var_c97d57b1eadee09e )
                    {
                        continue;
                    }
                }
                
                if ( !attackerdata.var_2899bd461c78b880 )
                {
                    continue;
                }
            }
            
            if ( getdvarint( @"hash_dda9d67c21b0f4b4", 0 ) )
            {
                if ( !( var_53387a1f0a9c7454 && isdefined( self.laststandattacker ) && player == self.laststandattacker ) )
                {
                    bonusmagnitude = 0;
                    
                    if ( isdefined( attackerdata.damage ) )
                    {
                        if ( attackerdata.damage >= 70 )
                        {
                            bonusmagnitude = 2;
                        }
                        else if ( attackerdata.damage >= 35 )
                        {
                            bonusmagnitude = 1;
                        }
                    }
                    
                    player thread gamescore::processassist( self, assistweapon, bonusmagnitude, attackerdata.damage );
                }
            }
            else
            {
                bonusmagnitude = 0;
                
                if ( isdefined( attackerdata.damage ) )
                {
                    if ( attackerdata.damage >= 70 )
                    {
                        bonusmagnitude = 2;
                    }
                    else if ( attackerdata.damage >= 35 )
                    {
                        bonusmagnitude = 1;
                    }
                }
                
                player thread gamescore::processassist( self, assistweapon, bonusmagnitude, attackerdata.damage );
            }
            
            var_4230ca77395dae4d = 0;
            
            if ( isdefined( player.super ) )
            {
                if ( player.super.staticdata.ref == "super_battlerage" )
                {
                    if ( utility::issharedfuncdefined( #"battlerage", #"hash_87e0ce2b2de1b457" ) )
                    {
                        player [[ utility::getsharedfunc( #"battlerage", #"hash_87e0ce2b2de1b457" ) ]]();
                    }
                }
            }
            
            if ( !isdefined( player.equipment ) )
            {
                player.equipment = [];
            }
            
            if ( player.equipment[ "secondary" ] == "equip_battlerage" )
            {
                if ( player.battlerageactive )
                {
                    if ( utility::issharedfuncdefined( #"battlerage", #"hash_87e0ce2b2de1b457" ) )
                    {
                        player [[ utility::getsharedfunc( #"battlerage", #"hash_87e0ce2b2de1b457" ) ]]( 1 );
                    }
                }
            }
            
            if ( isdefined( player.perks[ "specialty_boom" ] ) )
            {
                victim thread perkfunctions::setboominternal( player );
            }
        }
    }
    
    var_db0467bbbb3deffc = level.var_38f84e6d5f274bb.statustracker[ victim.guid ];
    
    if ( var_db0467bbbb3deffc )
    {
        guidtoplayer = [];
        
        foreach ( player in level.players )
        {
            guidtoplayer[ player.guid ] = player;
        }
        
        foreach ( var_427ca3ae63b1a91c, var_16687f98fb1e390e in var_db0467bbbb3deffc )
        {
            if ( var_427ca3ae63b1a91c == attacker.guid )
            {
                continue;
            }
            
            var_2e1dd770e7e11010 = guidtoplayer[ var_427ca3ae63b1a91c ];
            
            if ( !var_2e1dd770e7e11010 || !player_utility::playersareenemies( var_2e1dd770e7e11010, victim ) )
            {
                continue;
            }
            
            var_2899bd461c78b880 = self.attackerdata[ var_427ca3ae63b1a91c ].var_2899bd461c78b880;
            level callback::callback( #"hash_476254565e0a712c", { #var_2899bd461c78b880:var_2899bd461c78b880, #deathtime:deathdata.deathtime, #var_a7b1f82b5a561d1f:var_427ca3ae63b1a91c, #assister:var_2e1dd770e7e11010, #victimguid:victim.guid } );
        }
    }
    
    if ( var_4230ca77395dae4d && isdefined( attacker.pers[ "soloKills" ] ) && attacker.team != victim.team )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "soloKills" ] ) )
            {
                attacker.leaderboarddata[ "soloKills" ] = attacker.leaderboarddata[ "soloKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "soloKills" ] ) )
            {
                [[ level.leaderboardfunc[ "soloKills" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
            
            if ( isdefined( attacker.pers[ "soloKills" ] ) )
            {
                attacker.pers[ "soloKills" ] = attacker.pers[ "soloKills" ] + 1;
            }
        }
    }
    
    if ( isdefined( self.markedbyboomperk ) && !level.disablestattracking )
    {
        foreach ( player in level.players )
        {
            if ( player.team == self.team )
            {
                continue;
            }
            
            if ( arraycontains( self.attackers, player ) )
            {
                continue;
            }
            
            if ( isdefined( self.markedbyboomperk[ player player::getuniqueid() ] ) )
            {
                player thread gamescore::processassist( self, objweapon );
            }
        }
    }
    
    if ( smeansofdeath == "MOD_EXPLOSIVE" )
    {
        attacker points::doscoreevent( #"hash_d924161c011da9f3" );
    }
    else if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        if ( victim getstance() == "prone" )
        {
            attacker points::doscoreevent( #"hash_ab5d5e2ad7281433" );
        }
    }
    
    if ( attacker issprinting() )
    {
        attacker points::doscoreevent( #"hash_af3b226c81e79d5c" );
    }
    
    if ( victim.inlaststand )
    {
        function_994ae661e8aa177( victim );
    }
    else
    {
        function_e27976b1ab5b0348( attacker, victim, 0 );
    }
    
    if ( isplayer( attacker ) )
    {
        function_cb58faabc0fd9c21();
        
        if ( !function_f9925926a3a1717a() )
        {
            attacker setclientomnvar( "ui_killed_player", self getentitynumber() );
            attacker setclientomnvar( "ui_killed_player_notify", deathdata.deathtime );
        }
    }
    
    if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
    {
        attacker adjustvoxelhead();
    }
    
    /#
        if ( isdefined( attacker_cur_kill_streak ) && attacker_cur_kill_streak != attacker.pers[ "<dev string:x3ea>" ] )
        {
            assertmsg( "<dev string:x3fa>" );
        }
    #/
}

// Namespace damage
// Params 1
// Checksum 0x61b121ee, Offset: 0x188fc
// Size: 0x265
function function_1e05f2b200e3e3cc( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    objweapon = deathdata.objweapon;
    einflictor = deathdata.einflictor ?? deathdata.inflictor;
    smeansofdeath = deathdata.smeansofdeath ?? deathdata.meansofdeath;
    iskillstreakweapon = weapon::iskillstreakweapon( objweapon );
    var_f27896797b2c2739 = !deathdata.var_eacecf0a1e48bf74;
    
    if ( isdefined( level.var_ccf4ff45bf452003 ) )
    {
        var_f27896797b2c2739 = [[ level.var_ccf4ff45bf452003 ]]( attacker );
    }
    
    if ( var_f27896797b2c2739 )
    {
        if ( !isdefined( attacker.var_9b5953146269e8f8 ) )
        {
            attacker.var_9b5953146269e8f8 = 0;
        }
        
        attacker.var_9b5953146269e8f8++;
        
        if ( !isdefined( attacker.var_e111789bdf9bcbda ) )
        {
            attacker.var_e111789bdf9bcbda = {};
        }
        
        attacker.var_e111789bdf9bcbda.var_1478d6a5815e4bf5 = 1;
        attacker function_f81a84e2092d538a( victim, objweapon, einflictor, iskillstreakweapon, smeansofdeath, deathdata );
        function_483c8cb5f7e4a41a( deathdata );
        attacker.var_e111789bdf9bcbda.var_1478d6a5815e4bf5 = 0;
    }
    
    if ( iskillstreakweapon )
    {
        events::function_3799ac52cb0c45dd( attacker, einflictor, objweapon );
        
        if ( isdefined( attacker.var_de2230a467dc7058 ) && isdefined( einflictor.streakinfo.id ) )
        {
            if ( !isdefined( attacker.var_de2230a467dc7058[ einflictor.streakinfo.id ] ) )
            {
                attacker.var_de2230a467dc7058[ einflictor.streakinfo.id ] = 0;
            }
            
            attacker.var_de2230a467dc7058[ einflictor.streakinfo.id ] += 1;
            
            if ( attacker.var_de2230a467dc7058[ einflictor.streakinfo.id ] == 6 )
            {
                attacker thread points::doscoreevent( #"scorestreak_topped_off" );
            }
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0xbb95f215, Offset: 0x18b69
// Size: 0x101
function function_483c8cb5f7e4a41a( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    objweapon = deathdata.objweapon;
    einflictor = deathdata.einflictor ?? deathdata.inflictor;
    inflictorid = einflictor.var_a7803e45d8e63517 ?? ( isent( einflictor ) ? einflictor getentitynumber() : undefined );
    telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, attacker, inflictorid, objweapon );
    
    if ( attacker && isdefined( attacker.pers ) && isdefined( attacker.pers[ "telemetry" ] ) )
    {
        attacker.pers[ "telemetry" ].eliminations++;
        attacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "eliminations", victim );
    }
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0x9fd23fbe, Offset: 0x18c72
// Size: 0x7dd
function private function_994ae661e8aa177( victim )
{
    if ( !level.teambased )
    {
        return;
    }
    
    laststanddowneddata = victim.laststanddowneddata;
    var_f88441acaa84d56 = laststanddowneddata.callbackeventdata[ "uav" ];
    
    if ( !isdefined( var_f88441acaa84d56 ) )
    {
        return;
    }
    
    foreach ( towerowner in var_f88441acaa84d56.var_7833283fd2f06215 )
    {
        towerowner thread points::doscoreevent( #"uav_assist" );
    }
    
    foreach ( eventstruct in var_f88441acaa84d56.uavassists )
    {
        eventname = eventstruct.scoreeventname;
        var_7e2e012bec81f493 = eventstruct.var_7e2e012bec81f493;
        uavtype = eventstruct.uavtype;
        owner = eventstruct.owner;
        uav = eventstruct.uav;
        victim killstreak::function_7acb73c1355e75ce( laststanddowneddata.attacker, uav.owner, uav.streakinfo );
        
        if ( isdefined( owner ) )
        {
            if ( isdefined( eventname ) && isdefined( uav ) )
            {
                if ( !isdefined( uav.assistsgiven ) )
                {
                    uav.assistsgiven = 0;
                }
                
                maxscoreassists = uavtype == "directional_uav" ? 15 : 10;
                
                if ( uav.assistsgiven < maxscoreassists )
                {
                    owner thread points::doscoreevent( eventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, uav.streakinfo );
                }
                else
                {
                    owner thread points::givexpwithtext( eventname );
                }
                
                uav.assistsgiven++;
            }
            
            if ( isdefined( var_7e2e012bec81f493 ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( owner ) ) )
                {
                    if ( isdefined( owner.leaderboarddata[ var_7e2e012bec81f493 ] ) )
                    {
                        owner.leaderboarddata[ var_7e2e012bec81f493 ] += 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ var_7e2e012bec81f493 ] ) )
                    {
                        [[ level.leaderboardfunc[ var_7e2e012bec81f493 ] ]]( owner, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                    
                    if ( isdefined( owner.pers[ var_7e2e012bec81f493 ] ) )
                    {
                        owner.pers[ var_7e2e012bec81f493 ] += 1;
                    }
                }
            }
            
            owner script::bufferednotify( "update_uav_assist_buffered" );
            owner combatrecordkillstreakstat( uavtype );
        }
    }
    
    foreach ( eventstruct in var_f88441acaa84d56.droneassists )
    {
        var_7298838bd5d43265 = eventstruct.var_7298838bd5d43265;
        scoreeventname = eventstruct.scoreeventname;
        var_7e2e012bec81f493 = eventstruct.var_7e2e012bec81f493;
        owner = eventstruct.owner;
        drone = eventstruct.drone;
        
        if ( isdefined( owner ) )
        {
            if ( isdefined( var_7298838bd5d43265 ) )
            {
                owner thread points::doscoreevent( var_7298838bd5d43265 );
            }
            
            if ( isdefined( scoreeventname ) && isdefined( drone ) )
            {
                if ( !isdefined( drone.assistsgiven ) )
                {
                    drone.assistsgiven = 0;
                }
                
                if ( drone.assistsgiven < 10 )
                {
                    owner thread points::doscoreevent( scoreeventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, drone.streakinfo );
                }
                else
                {
                    owner thread points::givexpwithtext( scoreeventname );
                }
                
                drone.assistsgiven++;
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( owner ) ) )
            {
                if ( isdefined( owner.leaderboarddata[ "killstreakCUAVAssists" ] ) )
                {
                    owner.leaderboarddata[ "killstreakCUAVAssists" ] = owner.leaderboarddata[ "killstreakCUAVAssists" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakCUAVAssists" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakCUAVAssists" ] ]]( owner, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( owner.pers[ "killstreakCUAVAssists" ] ) )
                {
                    owner.pers[ "killstreakCUAVAssists" ] = owner.pers[ "killstreakCUAVAssists" ] + 1;
                }
            }
        }
    }
    
    foreach ( var_bf101a105bc57e16 in var_f88441acaa84d56.var_19f3dd154804adb8 )
    {
        if ( isdefined( var_bf101a105bc57e16 ) )
        {
            var_bf101a105bc57e16 thread points::doscoreevent( #"binoculars_assist" );
        }
    }
    
    foreach ( eventstruct in var_f88441acaa84d56.var_4bff7fbae539ce99 )
    {
        eventname = eventstruct.scoreeventname;
        var_7e2e012bec81f493 = eventstruct.var_7e2e012bec81f493;
        owner = eventstruct.owner;
        wpzone = eventstruct.wpzone;
        
        if ( isdefined( owner ) )
        {
            if ( isdefined( eventname ) && isdefined( wpzone ) )
            {
                if ( !isdefined( wpzone.assistsgiven ) )
                {
                    wpzone.assistsgiven = 0;
                }
                
                if ( wpzone.assistsgiven < 15 )
                {
                    owner thread points::doscoreevent( eventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, uav.streakinfo );
                }
                else
                {
                    owner thread points::givexpwithtext( eventname );
                }
                
                wpzone.assistsgiven++;
            }
            
            if ( isdefined( var_7e2e012bec81f493 ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( owner ) ) )
                {
                    if ( isdefined( owner.leaderboarddata[ var_7e2e012bec81f493 ] ) )
                    {
                        owner.leaderboarddata[ var_7e2e012bec81f493 ] += 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ var_7e2e012bec81f493 ] ) )
                    {
                        [[ level.leaderboardfunc[ var_7e2e012bec81f493 ] ]]( owner, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                    
                    if ( isdefined( owner.pers[ var_7e2e012bec81f493 ] ) )
                    {
                        owner.pers[ var_7e2e012bec81f493 ] += 1;
                    }
                }
            }
        }
    }
}

// Namespace damage
// Params 5, eflags: 0x4
// Checksum 0x73348fba, Offset: 0x19457
// Size: 0x59
function private function_64dae57b2b50ee80( scoreeventname, player, streakinfo, executenow, cachestruct )
{
    if ( executenow )
    {
        player thread points::doscoreevent( scoreeventname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, streakinfo );
        return;
    }
    
    cachestruct.scoreeventname = scoreeventname;
}

// Namespace damage
// Params 4, eflags: 0x4
// Checksum 0xcd99da86, Offset: 0x194b8
// Size: 0x47
function private function_f12f39f131632ac6( scoreeventname, player, executenow, cachestruct )
{
    if ( executenow )
    {
        player thread points::givexpwithtext( scoreeventname );
        return;
    }
    
    cachestruct.scoreeventname = scoreeventname;
}

// Namespace damage
// Params 4, eflags: 0x4
// Checksum 0x730a7006, Offset: 0x19507
// Size: 0x104
function private function_5a59278130dcc12e( var_7e2e012bec81f493, player, incrementnow, cachestruct )
{
    if ( incrementnow )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ var_7e2e012bec81f493 ] ) )
            {
                player.leaderboarddata[ var_7e2e012bec81f493 ] += 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ var_7e2e012bec81f493 ] ) )
            {
                [[ level.leaderboardfunc[ var_7e2e012bec81f493 ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
            
            if ( isdefined( player.pers[ var_7e2e012bec81f493 ] ) )
            {
                player.pers[ var_7e2e012bec81f493 ] += 1;
            }
        }
        
        return;
    }
    
    cachestruct.var_7e2e012bec81f493 = var_7e2e012bec81f493;
}

// Namespace damage
// Params 3, eflags: 0x4
// Checksum 0x43d15682, Offset: 0x19613
// Size: 0xd3e
function private function_e27976b1ab5b0348( attacker, victim, islaststand )
{
    if ( level.gamemodebundle.var_9257addc44d0799c )
    {
        return;
    }
    
    if ( islaststand )
    {
        var_9265cf419229ae5f = {};
        
        if ( !isdefined( victim.laststanddowneddata ) )
        {
            victim.laststanddowneddata = {};
        }
        
        if ( !isdefined( victim.laststanddowneddata.callbackeventdata ) )
        {
            victim.laststanddowneddata.callbackeventdata = [];
        }
        
        victim.laststanddowneddata.callbackeventdata[ "uav" ] = var_9265cf419229ae5f;
    }
    
    if ( level.teambased )
    {
        index = undefined;
        
        if ( level.var_f3d1cde89907a07a && isdefined( attacker.sessionsquadid ) )
        {
            index = attacker.sessionsquadid;
        }
        else if ( isdefined( attacker.team ) )
        {
            index = attacker.team;
        }
        
        var_40fd701a365a0bd7 = level.uavmodels[ index ] ?? [];
        var_40fd701a365a0bd7 = arraycombine( var_40fd701a365a0bd7, level.var_9f462aa58e87d9c9[ index ] );
        var_40fd701a365a0bd7 = arraycombine( var_40fd701a365a0bd7, level.var_97592a5d2d301d66[ index ] );
        
        foreach ( tower in level.activetowers )
        {
            assert( isdefined( tower.var_8c953eb201608663 ), "<dev string:x449>" );
            
            if ( tower.var_8c953eb201608663 == attacker || tower.var_8c953eb201608663.team != attacker.team )
            {
                continue;
            }
            
            if ( distance2dsquared( tower.origin, attacker.origin ) <= tower.scanradius * tower.scanradius )
            {
                if ( islaststand )
                {
                    if ( !isdefined( var_9265cf419229ae5f.var_7833283fd2f06215 ) )
                    {
                        var_9265cf419229ae5f.var_7833283fd2f06215 = [];
                    }
                    
                    var_9265cf419229ae5f.var_7833283fd2f06215[ var_9265cf419229ae5f.var_7833283fd2f06215.size ] = tower.var_8c953eb201608663;
                    continue;
                }
                
                tower.var_8c953eb201608663 thread points::doscoreevent( #"uav_assist" );
            }
        }
        
        var_40fd701a365a0bd7 = arraycombine( var_40fd701a365a0bd7, level.var_d0e77ff44ad01536 );
        uavtypes = [];
        
        if ( islaststand )
        {
            var_9265cf419229ae5f.uavassists = [];
        }
        
        foreach ( uav in var_40fd701a365a0bd7 )
        {
            if ( !isdefined( uav ) )
            {
                continue;
            }
            
            if ( !isplayer( uav.owner ) )
            {
                continue;
            }
            
            victim killstreak::function_7acb73c1355e75ce( attacker, uav.owner, uav.streakinfo );
            
            if ( arraycontains( uavtypes, uav.uavtype ) )
            {
                continue;
            }
            
            if ( isdefined( uav.owner.team ) && uav.owner == attacker )
            {
                continue;
            }
            
            if ( !isdefined( uav.uavtype ) )
            {
                debugstring = ( attacker.name ?? "[n/a]" ) + " | ";
                debugstring += ( victim.name ?? "[n/a]" ) + " | ";
                debugstring += ( attacker.origin[ 0 ] ?? 0 ) + " | ";
                debugstring += ( attacker.origin[ 1 ] ?? 0 ) + " | ";
                debugstring += ( attacker.origin[ 2 ] ?? 0 ) + " | ";
                debugstring += ( uav.owner.name ?? "[n/a]" ) + " | ";
                debugstring += ( islaststand ?? "[n/a]" ) + " | ";
                debugstring += ( int( gettime() / 1000 ) ?? 0 ) + " | ";
                script::demoforcesre( "[uav.uavType undefined] " + debugstring );
                uav.uavtype = "";
            }
            
            eventname = getxhash( uav.uavtype + "_assist" );
            
            if ( ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" || uav.uavtype == "false_flag" ) && ( isdefined( attacker.perks[ "specialty_perceptive" ] ) || killstreak_utility::teamhasuav( uav.owner.team ) ) )
            {
                var_d6dc6370bc1aacc6 = 1;
            }
            
            if ( !isdefined( uav.assistsgiven ) )
            {
                uav.assistsgiven = 0;
            }
            
            maxscoreassists = uav.uavtype == "directional_uav" ? 15 : 10;
            
            if ( islaststand )
            {
                var_b0ae2d9aefaf4d54 = { #uavtype:uav.uavtype, #owner:uav.owner, #uav:uav };
                var_9265cf419229ae5f.uavassists[ var_9265cf419229ae5f.uavassists.size ] = var_b0ae2d9aefaf4d54;
            }
            
            if ( uav.assistsgiven < maxscoreassists )
            {
                if ( uav.uavtype == "counter_uav" || var_d6dc6370bc1aacc6 )
                {
                    function_64dae57b2b50ee80( eventname, uav.owner, uav.streakinfo, !islaststand, var_b0ae2d9aefaf4d54 );
                }
                else if ( isbrgamemode() && ( uav.uavtype == "uav" || uav.uavtype == "directional_uav" ) )
                {
                    function_64dae57b2b50ee80( eventname, uav.owner, uav.streakinfo, !islaststand, var_b0ae2d9aefaf4d54 );
                }
            }
            else
            {
                function_f12f39f131632ac6( eventname, uav.owner, !islaststand, var_b0ae2d9aefaf4d54 );
            }
            
            if ( !islaststand )
            {
                uav.assistsgiven++;
            }
            
            switch ( uav.uavtype )
            {
                case #"hash_634b246c3da5c56f":
                    if ( var_d6dc6370bc1aacc6 )
                    {
                        function_5a59278130dcc12e( "killstreakUAVAssists", uav.owner, !islaststand, var_b0ae2d9aefaf4d54 );
                    }
                    
                    break;
                case #"hash_10e585c25e7e9f60":
                    function_5a59278130dcc12e( "killstreakCUAVAssists", uav.owner, !islaststand, var_b0ae2d9aefaf4d54 );
                    break;
                case #"hash_e171e5b86ef0a4cc":
                    if ( var_d6dc6370bc1aacc6 )
                    {
                        function_5a59278130dcc12e( "killstreakAUAVAssists", uav.owner, !islaststand, var_b0ae2d9aefaf4d54 );
                    }
                    
                    break;
                case #"hash_13b46e54efc6f337":
                    if ( var_d6dc6370bc1aacc6 )
                    {
                        function_5a59278130dcc12e( "killstreakFalseFlagAssists", uav.owner, !islaststand, var_b0ae2d9aefaf4d54 );
                    }
                    
                    break;
            }
            
            uavtypes[ uavtypes.size ] = uav.uavtype;
            
            if ( !islaststand )
            {
                uav.owner script::bufferednotify( "update_uav_assist_buffered" );
                uav.owner combatrecordkillstreakstat( uav.uavtype );
            }
        }
        
        if ( islaststand )
        {
            var_9265cf419229ae5f.droneassists = [];
        }
        
        if ( isdefined( level.supportdrones ) && level.supportdrones.size > 0 )
        {
            foreach ( drone in level.supportdrones )
            {
                if ( islaststand )
                {
                    var_135e1332f97646ee = { #owner:drone.owner, #drone:drone };
                    var_9265cf419229ae5f.droneassists[ var_9265cf419229ae5f.droneassists.size ] = var_135e1332f97646ee;
                }
                
                if ( level.teambased && drone.team == attacker.team && drone.owner != attacker )
                {
                    if ( isdefined( drone.enemiesmarked[ self getentitynumber() ] ) )
                    {
                        if ( islaststand )
                        {
                            var_135e1332f97646ee.var_7298838bd5d43265 = hashcat( getxhash( drone.streakinfo.streakname ), "_assist" );
                        }
                        else
                        {
                            drone.owner thread points::doscoreevent( hashcat( getxhash( drone.streakinfo.streakname ), "_assist" ) );
                        }
                    }
                }
                
                if ( drone.helperdronetype == "scrambler_drone_guard" )
                {
                    if ( level.teambased && drone.team == attacker.team && drone.owner != attacker )
                    {
                        eventname = hashcat( getxhash( drone.streakinfo.streakname ), "_assist" );
                        
                        if ( !isdefined( drone.assistsgiven ) )
                        {
                            drone.assistsgiven = 0;
                        }
                        
                        if ( drone.assistsgiven < 10 )
                        {
                            function_64dae57b2b50ee80( eventname, drone.owner, drone.streakinfo, !islaststand, var_135e1332f97646ee );
                        }
                        else
                        {
                            function_f12f39f131632ac6( eventname, drone.owner, !islaststand, var_135e1332f97646ee );
                        }
                        
                        function_5a59278130dcc12e( "killstreakCUAVAssists", drone.owner, !islaststand, var_135e1332f97646ee );
                        
                        if ( !islaststand )
                        {
                            drone.assistsgiven++;
                        }
                    }
                }
            }
        }
        
        if ( islaststand )
        {
            if ( utility::issharedfuncdefined( #"binoculars", #"hash_6d5fabf2416b62ba" ) )
            {
                var_9265cf419229ae5f.var_19f3dd154804adb8 = [[ utility::getsharedfunc( #"binoculars", #"hash_6d5fabf2416b62ba" ) ]]( attacker, self );
            }
        }
        else if ( utility::issharedfuncdefined( #"binoculars", #"hash_87e0ce2b2de1b457" ) )
        {
            attacker [[ utility::getsharedfunc( #"binoculars", #"hash_87e0ce2b2de1b457" ) ]]( attacker, victim );
        }
        
        if ( islaststand )
        {
            var_9265cf419229ae5f.var_4bff7fbae539ce99 = [];
        }
        
        if ( isdefined( level.activewpzones ) && isdefined( attacker.team ) && level.activewpzones.size > 0 )
        {
            wpzone = level.activewpzones[ 0 ];
            wpowner = wpzone.owner;
            wpteam = wpzone.team;
            
            if ( attacker.team == wpteam && attacker != wpowner )
            {
                if ( victim.wpdisorient || victim.wpburning )
                {
                    eventname = #"white_phosphorus_assist";
                    
                    if ( islaststand )
                    {
                        var_fc32ca495811f669 = { #owner:wpowner, #wpzone:wpzone };
                        var_9265cf419229ae5f.var_4bff7fbae539ce99[ var_9265cf419229ae5f.var_4bff7fbae539ce99.size ] = var_fc32ca495811f669;
                    }
                    
                    if ( !isdefined( wpzone.assistsgiven ) )
                    {
                        wpzone.assistsgiven = 0;
                    }
                    
                    if ( wpzone.assistsgiven < 15 )
                    {
                        function_64dae57b2b50ee80( eventname, wpowner, wpzone.streakinfo, !islaststand, var_fc32ca495811f669 );
                    }
                    else
                    {
                        function_f12f39f131632ac6( eventname, wpowner, !islaststand, var_fc32ca495811f669 );
                    }
                    
                    function_5a59278130dcc12e( "killstreakWhitePhosphorousKillsAssists", wpowner, !islaststand, var_fc32ca495811f669 );
                    
                    if ( !islaststand )
                    {
                        wpzone.assistsgiven++;
                    }
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( level.uavmodels ) )
    {
        foreach ( uav in level.uavmodels )
        {
            victim killstreak::function_7acb73c1355e75ce( attacker, uav.owner, uav.streakinfo );
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x5f8ddc0, Offset: 0x1a359
// Size: 0x173
function adjustvoxelhead( doreset )
{
    headsize = 0;
    head = self.operatorcustomization.head;
    
    if ( doreset == 1 )
    {
        head = getsubstr( head, 0, head.size - 1 ) + "a";
        headsize = 1;
    }
    else
    {
        lastcharacter = head[ head.size - 1 ];
        
        if ( lastcharacter == "a" )
        {
            head = getsubstr( head, 0, head.size - 1 ) + "b";
            headsize = 2;
        }
        
        if ( lastcharacter == "b" )
        {
            head = getsubstr( head, 0, head.size - 1 ) + "c";
            headsize = 3;
        }
    }
    
    operator::function_44f7d464da13e4f6( self.operatorcustomization.operatorref, self.operatorcustomization.skinref );
    teams::setcharactermodels( self.operatorcustomization.body, head, self.operatorcustomization.vm );
    
    if ( headsize != 0 )
    {
        self setclientomnvar( "ui_voxel_head_size", headsize );
    }
    
    param = undefined;
    
    if ( headsize == 3 )
    {
        param = ae_utility::function_2d1565a236387b2( #"gamemode_event_action_param_bitfield", #"largest_head" );
    }
    
    challenges::function_a5855417fbf48c62( self, ae_utility::function_2d1565a236387b2( #"gamemode_event_action_index", #"hash_4a43652a1705a30b" ), param );
}

// Namespace damage
// Params 1
// Checksum 0xeaa203c0, Offset: 0x1a4d4
// Size: 0x29c
function function_e75f1e487cc993ea( victim )
{
    var_42a557281949174a = self;
    
    if ( !level.ignorescoring )
    {
        if ( utility::issharedfuncdefined( #"game", #"hash_e9102cee294e5077" ) )
        {
            [ suspiciouskill, suspiciousdown ] = utility::callsharedfunc( #"game", #"hash_e9102cee294e5077", victim, victim.laststandattacker, 1 );
            
            if ( suspiciouskill > 0 || suspiciousdown > 0 )
            {
                return;
            }
        }
        
        var_42a557281949174a playerincrementscoreboardkills( victim );
        codcasterclientmatchdata::function_661764696c0eb0fc( var_42a557281949174a, victim );
        
        if ( isbehindmeleevictim( var_42a557281949174a, victim ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_42a557281949174a ) ) )
            {
                if ( isdefined( var_42a557281949174a.leaderboarddata[ "killsFromBehind" ] ) )
                {
                    var_42a557281949174a.leaderboarddata[ "killsFromBehind" ] = var_42a557281949174a.leaderboarddata[ "killsFromBehind" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killsFromBehind" ] ) )
                {
                    [[ level.leaderboardfunc[ "killsFromBehind" ] ]]( var_42a557281949174a, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( var_42a557281949174a.pers[ "killsFromBehind" ] ) )
                {
                    var_42a557281949174a.pers[ "killsFromBehind" ] = var_42a557281949174a.pers[ "killsFromBehind" ] + 1;
                }
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
            {
                if ( isdefined( victim.leaderboarddata[ "deathsFromBehind" ] ) )
                {
                    victim.leaderboarddata[ "deathsFromBehind" ] = victim.leaderboarddata[ "deathsFromBehind" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "deathsFromBehind" ] ) )
                {
                    [[ level.leaderboardfunc[ "deathsFromBehind" ] ]]( victim, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( victim.pers[ "deathsFromBehind" ] ) )
                {
                    victim.pers[ "deathsFromBehind" ] = victim.pers[ "deathsFromBehind" ] + 1;
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( level.prematchaddkillfunc ) )
    {
        var_42a557281949174a [[ level.prematchaddkillfunc ]]();
    }
}

// Namespace damage
// Params 1
// Checksum 0xbc46b2, Offset: 0x1a778
// Size: 0x15a
function playerincrementscoreboardkills( victim )
{
    var_42a557281949174a = self;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_42a557281949174a ) ) )
    {
        if ( isdefined( var_42a557281949174a.leaderboarddata[ #"limitkills" ] ) )
        {
            var_42a557281949174a.leaderboarddata[ #"limitkills" ] += 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ #"limitkills" ] ) )
        {
            [[ level.leaderboardfunc[ #"limitkills" ] ]]( var_42a557281949174a, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
        
        if ( isdefined( var_42a557281949174a.pers[ #"limitkills" ] ) )
        {
            var_42a557281949174a.pers[ #"limitkills" ] += 1;
        }
    }
    
    if ( !var_42a557281949174a stat_limits::function_608486f90656f2f7( #"limitkills" ) )
    {
        if ( !game_utility::function_245a95d184375f25() )
        {
            var_42a557281949174a playerstats_interface::addtoplayerstat( 1, "combatStats", "kills" );
        }
        
        var_42a557281949174a stats::function_ee7ea2a7c2c198f3( 1, victim );
    }
}

// Namespace damage
// Params 3
// Checksum 0x73d9e537, Offset: 0x1a8da
// Size: 0x2c7
function function_89b99953ac074804( attacker, victim, objweapon )
{
    if ( isplayer( victim ) )
    {
        if ( isbot( victim ) )
        {
            var_eee55cab64045312 = 1;
        }
        else
        {
            var_eee55cab64045312 = 0;
        }
    }
    else if ( isagent( victim ) )
    {
        var_eee55cab64045312 = 2;
    }
    
    weapongroup = weapon::getweapongroup( objweapon );
    
    switch ( weapongroup )
    {
        case #"hash_8af0086b038622b5":
            weapontype = "ar";
            break;
        case #"hash_dd616da0b395a0b0":
            weapontype = "br";
            break;
        case #"hash_47368bc0d2ef1565":
            weapontype = "dmr";
            break;
        case #"hash_c095d67337b1f5a1":
            weapontype = "sniper";
            break;
        case #"hash_9d18adab1b65a661":
            weapontype = "launcher";
            break;
        case #"hash_bef5ec0b3e197ae":
            weapontype = "lmg";
            break;
        case #"hash_86b11ac21f992552":
        case #"hash_a1f27f97be15d620":
            weapontype = "melee";
            break;
        case #"hash_34340d457a63e7f1":
            weapontype = "pistol";
            break;
        case #"hash_16cf6289ab06bd30":
            weapontype = "shotgun";
            break;
        case #"hash_ab10f9c080fe4faf":
            weapontype = "smg";
            break;
        default:
            weapontype = "other";
            break;
    }
    
    switch ( var_eee55cab64045312 )
    {
        case 0:
            if ( !isdefined( attacker.pers[ "telemetry" ].var_61c7f7fc343e033b[ weapontype ] ) )
            {
                attacker.pers[ "telemetry" ].var_61c7f7fc343e033b[ weapontype ] = 0;
            }
            
            attacker.pers[ "telemetry" ].var_61c7f7fc343e033b[ weapontype ]++;
            return;
        case 1:
            if ( !isdefined( attacker.pers[ "telemetry" ].var_aedba93c9726c98f[ weapontype ] ) )
            {
                attacker.pers[ "telemetry" ].var_aedba93c9726c98f[ weapontype ] = 0;
            }
            
            attacker.pers[ "telemetry" ].var_aedba93c9726c98f[ weapontype ]++;
            return;
        case 2:
            if ( !isdefined( attacker.pers[ "telemetry" ].var_defc700e2a933403[ weapontype ] ) )
            {
                attacker.pers[ "telemetry" ].var_defc700e2a933403[ weapontype ] = 0;
            }
            
            attacker.pers[ "telemetry" ].var_defc700e2a933403[ weapontype ]++;
            return;
    }
}

// Namespace damage
// Params 6, eflags: 0x4
// Checksum 0x242fed63, Offset: 0x1aba9
// Size: 0x546
function private function_f81a84e2092d538a( victim, objweapon, einflictor, iskillstreakweapon, smeansofdeath, deathdata )
{
    eventinfo = function_c7f203dba75721b1( victim, einflictor );
    callback::callback( #"hash_eb54ccc016130a88", { #deathdata:deathdata, #smeansofdeath:smeansofdeath, #iskillstreakweapon:iskillstreakweapon, #einflictor:einflictor, #objweapon:objweapon, #victim:victim } );
    var_b2bc7419ea41cc87 = level.gamemodebundle.var_67302f78b191f13a;
    
    if ( einflictor.isequipment && einflictor.owner === self && !iskillstreakweapon && var_b2bc7419ea41cc87 )
    {
        assert( isdefined( einflictor.equipmentref ), "<dev string:x49e>" );
        equipmentbundle = level.equipment.table[ einflictor.equipmentref ].bundle;
        scoreevent = equipmentbundle.eliminationscoreevent;
        
        if ( isdefined( scoreevent ) )
        {
            if ( self.modifiers[ "grenade_reverse" ] )
            {
                thread points::doscoreevent( #"grenade_reverse" );
            }
            
            thread points::doscoreevent( scoreevent, objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
            return;
        }
    }
    else if ( einflictor.issuper && var_b2bc7419ea41cc87 )
    {
        assert( isdefined( einflictor.weapon_name ), "<dev string:x4ca>" );
        superbundle = supers_mp::function_5ffd3dfa9cc1e8de( supers_mp::getsuperrefforsuperweapon( einflictor.weapon_name ) );
        scoreevent = superbundle.eliminationscoreevent;
        
        if ( isdefined( scoreevent ) )
        {
            thread points::doscoreevent( scoreevent, objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
            return;
        }
    }
    else if ( iskillstreakweapon && var_b2bc7419ea41cc87 )
    {
        streakinfo = einflictor.streakinfo;
        
        if ( !isdefined( streakinfo ) )
        {
            streakinfo = einflictor.var_ec0bb630fbaa253a[ objweapon.basename ] ?? einflictor.owner.var_ec0bb630fbaa253a[ objweapon.basename ];
        }
        
        assert( isdefined( streakinfo ), "<dev string:x4f1>" );
        
        if ( isdefined( streakinfo.var_5c576910469d4fde ) )
        {
            var_c241be460be921d1 = self [[ streakinfo.var_5c576910469d4fde ]]( { #objweapon:objweapon, #streakinfo:streakinfo, #victim:victim, #attacker:self } );
        }
        
        streakbundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
        scoreevent = var_c241be460be921d1 ?? streakbundle.eliminationscoreevent;
        
        if ( streakinfo.mpstreaksysteminfo.var_36d265ac42039b40 == victim )
        {
            thread points::doscoreevent( #"cp_stolen_elim", objweapon, undefined, undefined, victim, undefined, undefined, undefined, streakinfo, undefined, eventinfo );
        }
        
        if ( isdefined( scoreevent ) )
        {
            thread points::doscoreevent( scoreevent, objweapon, undefined, undefined, victim, undefined, undefined, undefined, streakinfo, undefined, eventinfo );
            return;
        }
    }
    else if ( smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        if ( objweapon.damagemodcategory == #"melee" && self.modifiers[ "backstab" ] && isplayer( victim ) )
        {
            thread points::doscoreevent( #"melee_backstab", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
        }
        else if ( objweapon.damagemodcategory != #"melee" )
        {
            thread points::doscoreevent( #"melee_gunbutt", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
        }
        
        if ( utility::callsharedfunc( #"damage", #"hash_7f94b6a02e13629f", victim ) )
        {
            return;
        }
        
        if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
        {
            thread points::doscoreevent( #"elimination_melee", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
            return;
        }
        
        if ( level.gamemodebundle.var_e8db2c40ab74d2e4 )
        {
            thread points::doscoreevent( #"melee", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
        }
        
        return;
    }
    else if ( smeansofdeath == "MOD_HEAD_SHOT" )
    {
        if ( level.var_23730bd6be76cb84 )
        {
            events::headshot( deathdata.lifeid, eventinfo, objweapon, einflictor, victim );
        }
        
        return;
    }
    else if ( isdefined( level.var_c4a835bb7120c6a0 ) )
    {
        if ( self [[ level.var_c4a835bb7120c6a0 ]]( deathdata ) )
        {
            return;
        }
    }
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        thread points::doscoreevent( #"elimination_kill", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
        return;
    }
    
    if ( level.gamemodebundle.var_e8db2c40ab74d2e4 )
    {
        thread points::doscoreevent( #"kill", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
    }
}

// Namespace damage
// Params 2
// Checksum 0x7c7192ef, Offset: 0x1b0f7
// Size: 0x125
function function_c7f203dba75721b1( victim, einflictor )
{
    eventinfo = { #objectivekillpoints:self.var_e111789bdf9bcbda.objectivekillpoints, #isobjectivekill:self.var_e111789bdf9bcbda.isobjectivekill, #var_9f71c6384859861d:1 };
    
    if ( isdefined( einflictor ) && isdefined( einflictor.birthtime ) && self != einflictor )
    {
        if ( isdefined( einflictor.equipmentref ) && isdefined( game[ "potg" ].var_61a8ea389aa982cb ) )
        {
            if ( arraycontains( game[ "potg" ].var_61a8ea389aa982cb, getxhash( einflictor.equipmentref ) ) )
            {
                return eventinfo;
            }
        }
        
        eventinfo.killcamentindex = einflictor getentitynumber();
        eventinfo.killcamentstarttime = einflictor.birthtime;
        eventinfo.killcamlookatentityindex = victim getentitynumber();
        eventinfo.killcamentstickstolookatent = isdefined( einflictor.stuckenemyentity );
    }
    
    return eventinfo;
}

// Namespace damage
// Params 10
// Checksum 0xc9d65f14, Offset: 0x1b225
// Size: 0x74
function callback_playerkilled( inflictor, attacker, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration )
{
    playerkilled_internal( inflictor, attacker, self, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, 0 );
}

// Namespace damage
// Params 2
// Checksum 0x98ff3c6d, Offset: 0x1b2a1
// Size: 0x49
function launchshield( damage, meansofdeath )
{
    if ( riotshield::riotshield_hasweapon() )
    {
        if ( isdefined( self.riotshieldmodel ) )
        {
            riotshield::riotshield_detach( 1 );
        }
        
        if ( isdefined( self.riotshieldmodelstowed ) )
        {
            riotshield::riotshield_detach( 0 );
        }
    }
}

// Namespace damage
// Params 0
// Checksum 0xd209ef45, Offset: 0x1b2f2
// Size: 0xb3
function resetplayervariables()
{
    self.switching_teams = undefined;
    self.joining_team = undefined;
    self.leaving_team = undefined;
    self.pers[ "cur_kill_streak" ] = 0;
    thread gameplay_telemetry::function_f98fbe3bbb2ed9f1( "killstreakCount", 1, 0 );
    
    if ( !isbrgamemode() )
    {
        self.killcountthislife = 0;
    }
    
    self.var_9b5953146269e8f8 = 0;
    self.laststandattacker = undefined;
    self.laststandinflictor = undefined;
    self.var_24c4c756a0d798dd = undefined;
    self.laststandmeansofdeath = undefined;
    self.var_a54cf862f580156 = undefined;
    self.var_3242e03bf1b09197 = undefined;
    self.var_8f849ee66df5a544 = undefined;
    self.laststandattackermodifiers = undefined;
    gameobjects::detachusemodels();
}

// Namespace damage
// Params 0
// Checksum 0x15617f1e, Offset: 0x1b3ad
// Size: 0x2d
function resetplayeromnvarsonspawn()
{
    playerlogic::resetuiomnvarscommon();
    self setclientomnvar( "ui_life_kill_count", 0 );
    self setclientomnvar( "ui_shrapnel_overlay", 0 );
    self setclientomnvar( "ui_br_has_plate_pouch", 0 );
}

// Namespace damage
// Params 5
// Checksum 0xd2ec88a8, Offset: 0x1b3e2
// Size: 0x44e
function hitlocdebug( attacker, victim, damage, hitloc, dflags )
{
    colors = [];
    colors[ 0 ] = 2;
    colors[ 1 ] = 3;
    colors[ 2 ] = 5;
    colors[ 3 ] = 7;
    
    if ( !getdvarint( @"scr_hitloc_debug" ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.hitlocinited ) )
    {
        for ( i = 0; i < 6 ; i++ )
        {
            attacker setclientdvar( hashcat( @"hash_3dd1dde9508849d5", string( i ) ), "" );
        }
        
        attacker.hitlocinited = 1;
    }
    
    if ( level.splitscreen || !isplayer( attacker ) )
    {
        return;
    }
    
    elemcount = 6;
    
    if ( !isdefined( attacker.damageinfo ) )
    {
        attacker.damageinfo = [];
        
        for ( i = 0; i < elemcount ; i++ )
        {
            attacker.damageinfo[ i ] = spawnstruct();
            attacker.damageinfo[ i ].damage = 0;
            attacker.damageinfo[ i ].hitloc = "";
            attacker.damageinfo[ i ].bp = 0;
            attacker.damageinfo[ i ].colorindex = 0;
        }
        
        attacker.damageinfocolorindex = 0;
        attacker.damageinfovictim = undefined;
    }
    
    for ( i = elemcount - 1; i > 0 ; i-- )
    {
        attacker.damageinfo[ i ].damage = attacker.damageinfo[ i - 1 ].damage;
        attacker.damageinfo[ i ].hitloc = attacker.damageinfo[ i - 1 ].hitloc;
        attacker.damageinfo[ i ].bp = attacker.damageinfo[ i - 1 ].bp;
        attacker.damageinfo[ i ].colorindex = attacker.damageinfo[ i - 1 ].colorindex;
    }
    
    attacker.damageinfo[ 0 ].damage = damage;
    attacker.damageinfo[ 0 ].hitloc = hitloc;
    attacker.damageinfo[ 0 ].bp = dflags & 8;
    
    if ( isdefined( attacker.damageinfovictim ) && attacker.damageinfovictim != victim )
    {
        attacker.damageinfocolorindex++;
        
        if ( attacker.damageinfocolorindex == colors.size )
        {
            attacker.damageinfocolorindex = 0;
        }
    }
    
    attacker.damageinfovictim = victim;
    attacker.damageinfo[ 0 ].colorindex = attacker.damageinfocolorindex;
    
    for ( i = 0; i < elemcount ; i++ )
    {
        color = "^" + colors[ attacker.damageinfo[ i ].colorindex ];
        
        if ( attacker.damageinfo[ i ].hitloc != "" )
        {
            val = color + attacker.damageinfo[ i ].hitloc;
            
            if ( attacker.damageinfo[ i ].bp )
            {
                val += " (BP)";
            }
            
            attacker setclientdvar( hashcat( @"hash_3dd1dde9508849d5", string( i ) ), val );
        }
        
        attacker setclientdvar( hashcat( @"hash_9df3a18be699b19d", string( i ) ), color + attacker.damageinfo[ i ].damage );
    }
}

// Namespace damage
// Params 0
// Checksum 0xebc183b5, Offset: 0x1b838
// Size: 0x40
function giverecentshieldxp()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_a0e9b3f9cfb6925e" );
    self endon( #"hash_a0e9b3f9cfb6925e" );
    self.recentshieldxp++;
    wait 20;
    self.recentshieldxp = 0;
}

// Namespace damage
// Params 4
// Checksum 0xc3337985, Offset: 0x1b880
// Size: 0x79
function updateinflictorstat( einflictor, eattacker, sweapon, otherent )
{
    if ( !( isdefined( einflictor ) && isdefined( einflictor.alreadyhit ) ) || !einflictor.alreadyhit || !weapon::issinglehitweapon( sweapon ) )
    {
        gamelogic_mp::setinflictorstat( einflictor, eattacker, sweapon );
    }
    
    if ( isdefined( einflictor ) )
    {
        einflictor.alreadyhit = 1;
    }
}

// Namespace damage
// Params 12
// Checksum 0xf3b401f5, Offset: 0x1b901
// Size: 0x91c
function addattacker( victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath, lightarmordamage, weapongroup )
{
    if ( !isdefined( eattacker.guid ) && ( isplayer( eattacker ) || isagent( eattacker ) ) )
    {
        eattacker.guid = eattacker player::getuniqueid();
    }
    
    if ( !isdefined( eattacker.guid ) )
    {
        return;
    }
    
    if ( level.var_20582ffa76d6281e && eattacker == victim )
    {
        if ( victim.islaststandbleedoutdmg || victim.bleedout || victim.var_3fd757d47a3afc0d )
        {
            return;
        }
    }
    
    if ( !isdefined( victim.attackerdata ) )
    {
        victim.attackerdata = [];
    }
    
    currenttime = gettime();
    
    if ( !isdefined( victim.attackerdata[ eattacker.guid ] ) )
    {
        victim.attackers[ eattacker.guid ] = eattacker;
        victim.attackerdata[ eattacker.guid ] = { #var_f3734f16a3fc2423:0, #var_974b5409ab1fb70d:0, #hitlocslower:0, #var_d1e937b2d94a7d6c:0, #var_1deaa0b1c11f2092:0, #hitcount:0, #firsttimedamaged:currenttime, #attackerent:eattacker, #effectivedamage:0, #damage:0 };
    }
    
    attackerdata = victim.attackerdata[ eattacker.guid ];
    
    if ( utility::isbulletdamage( smeansofdeath ) && !eattacker.attackerdata[ victim.guid ].var_1064e75bd343dd83[ victim.guid ] && !victim.attackerdata[ eattacker.guid ].var_1064e75bd343dd83[ eattacker.guid ] )
    {
        if ( !isdefined( attackerdata.var_1064e75bd343dd83[ eattacker.guid ] ) )
        {
            attackerdata.var_1064e75bd343dd83[ eattacker.guid ] = [];
        }
        
        attackerdata.var_1064e75bd343dd83[ eattacker.guid ] = 1;
    }
    
    if ( isdefined( level.var_e14b75034d106d4b[ objweapon.basenamehash ][ eattacker.guid ] ) )
    {
        objweapon = level.var_e14b75034d106d4b[ objweapon.basenamehash ][ eattacker.guid ];
    }
    
    if ( !isdefined( weapongroup ) )
    {
        weapongroup = weapon::function_820c0dca2415bd8( objweapon );
    }
    
    if ( weapon::iscacprimaryweapongroup( weapongroup ) && !weapon::iscacsecondaryweapongroup( weapongroup, objweapon ) )
    {
        attackerdata.diddamagewithprimary = 1;
    }
    
    if ( isdefined( smeansofdeath ) && smeansofdeath != "MOD_MELEE" )
    {
        attackerdata.didnonmeleedamage = 1;
    }
    
    var_2899bd461c78b880 = 1;
    equipmenttype = weapon::getequipmenttype( objweapon );
    
    if ( isdefined( equipmenttype ) )
    {
        if ( equipmenttype == "lethal" )
        {
            attackerdata.diddamagewithlethalequipment = 1;
        }
        
        if ( equipmenttype == "tactical" )
        {
            attackerdata.diddamagewithtacticalequipment = 1;
            
            if ( !( smeansofdeath === "MOD_IMPACT" ) )
            {
                var_2899bd461c78b880 = 0;
            }
        }
    }
    
    if ( !isdefined( idamage ) )
    {
        idamage = 0;
    }
    
    if ( !isdefined( lightarmordamage ) )
    {
        lightarmordamage = 0;
    }
    
    victimhealth = smeansofdeath == "MOD_SUICIDE" ? victim.maxhealth : victim.health;
    victimarmorhealth = int( max( victim.armorhealth ?? 0, 0 ) );
    totalhealth = victimhealth + victimarmorhealth + lightarmordamage;
    totaldamage = idamage + lightarmordamage;
    effectivedamage = totaldamage > totalhealth ? totalhealth : totaldamage;
    attackerdata damage_effects::updatefirsttimedamaged();
    attackerdata.hitcount++;
    attackerdata.damage += totaldamage;
    attackerdata.effectivedamage += effectivedamage;
    attackerdata.objweapon = objweapon;
    attackerdata.vpoint = vpoint;
    attackerdata.vdir = vdir;
    attackerdata.shitloc = shitloc;
    attackerdata.psoffsettime = psoffsettime;
    attackerdata.smeansofdeath = smeansofdeath;
    attackerdata.attackerent = eattacker;
    attackerdata.lasttimedamaged = currenttime;
    attackerdata.inflictor = einflictor;
    attackerdata.var_3fd757d47a3afc0d = istrue( victim.var_3fd757d47a3afc0d );
    
    switch ( shitloc )
    {
        case #"hash_8a1772f5f912c880":
        case #"hash_92bbfe494d03d772":
        case #"hash_b107b5547c755d23":
            attackerdata.var_1deaa0b1c11f2092++;
            break;
        case #"hash_da51cc36a471058":
        case #"hash_51d5d0b9add9cc5a":
        case #"hash_5d5aac570f6fd382":
        case #"hash_a7980c387477e7bb":
        case #"hash_b275b50677dcf6cb":
        case #"hash_d42e71cd9f1e822f":
        case #"hash_da2f35145aa58933":
        case #"hash_fb5b5e6c07253005":
            attackerdata.var_d1e937b2d94a7d6c++;
            break;
        case #"hash_1cbc508a2fe01b79":
        case #"hash_810a7426c8bac3ac":
        case #"hash_fbb61fc356f3c75e":
            attackerdata.hitlocslower++;
            break;
        case #"hash_168c74e879f0ba11":
        case #"hash_7b36142458a6c2d5":
        case #"hash_9536712388e65bce":
        case #"hash_a638fec9040cfcf4":
            attackerdata.var_974b5409ab1fb70d++;
            break;
        case #"hash_7038dec66d8275be":
        case #"hash_db653a4972b3c13b":
            attackerdata.var_f3734f16a3fc2423++;
            break;
    }
    
    if ( !isdefined( attackerdata.var_2a11f150d0e7dca4 ) )
    {
        attackerdata.var_2a11f150d0e7dca4 = 0;
    }
    
    if ( !player::isinlaststand( victim ) && !victim ismeatshieldvictim() )
    {
        attackerdata.var_2a11f150d0e7dca4 = currenttime;
    }
    
    if ( !isdefined( attackerdata.damagesources ) )
    {
        attackerdata.damagesources = [];
    }
    
    var_db64f49fb75590dd = "none";
    equipref = equipment_mp::getequipmentreffromweapon( objweapon );
    
    if ( isdefined( equipref ) )
    {
        var_db64f49fb75590dd = equipref;
    }
    else if ( weapon::iskillstreakweaponname( objweapon.basename ) )
    {
        var_db64f49fb75590dd = killstreak::getkillstreaknamefromweapon( objweapon );
    }
    else if ( weapon::issuperweapon( objweapon ) )
    {
        var_db64f49fb75590dd = supers_mp::getsuperrefforsuperweapon( objweapon );
    }
    else if ( isdefined( smeansofdeath ) && ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN" || smeansofdeath == "MOD_BUMP" ) )
    {
        var_db64f49fb75590dd = smeansofdeath;
    }
    else if ( victim.islaststandbleedoutdmg || victim.bleedout || victim.var_3fd757d47a3afc0d )
    {
        var_db64f49fb75590dd = "BLEED_TICK";
    }
    else if ( smeansofdeath == "MOD_EXPLOSIVE" && einflictor.code_classname == "scriptable" )
    {
        var_db64f49fb75590dd = "ENV_EXPLOSIVE";
    }
    else if ( weapon::function_d565a7ddfefc76e2( objweapon ) )
    {
        var_db64f49fb75590dd = "BOMB_SITE";
    }
    else if ( victim.oobdeath )
    {
        var_db64f49fb75590dd = "OOB";
    }
    else if ( isdefined( objweapon.basename ) )
    {
        var_db64f49fb75590dd = objweapon.basename;
    }
    
    if ( isdefined( attackerdata.damagesources[ var_db64f49fb75590dd ].damagedone ) )
    {
        attackerdata.damagesources[ var_db64f49fb75590dd ].damagedone += effectivedamage;
    }
    
    if ( !isdefined( attackerdata.damagesources[ var_db64f49fb75590dd ] ) )
    {
        attackerdata.damagesources[ var_db64f49fb75590dd ] = { #objweapon:objweapon, #damagedone:effectivedamage, #meansofdeath:smeansofdeath, #active:1 };
    }
    
    if ( var_2899bd461c78b880 )
    {
        attackerdata.var_2899bd461c78b880 = 1;
    }
    
    attackerdata.var_22b37ea8a43d69a2 = var_db64f49fb75590dd;
    
    if ( isplayer( victim ) && bots_util::function_deef484b5b3a3977() )
    {
        victim function_a413e91ba3513105( string::to_string( eattacker.guid ), attackerdata );
    }
}

// Namespace damage
// Params 11
// Checksum 0xb0e85f70, Offset: 0x1c225
// Size: 0x39f
function addattackerkillstreak( victim, idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, tagname, partname, idflags, objweapon )
{
    if ( !isdefined( victim.attackerdata ) )
    {
        victim.attackerdata = [];
    }
    
    if ( !isdefined( victim.attackerdata[ eattacker.guid ] ) )
    {
        victim.attackers[ eattacker.guid ] = eattacker;
        victim.attackerdata[ eattacker.guid ] = spawnstruct();
        victim.attackerdata[ eattacker.guid ].damage = 0;
        victim.attackerdata[ eattacker.guid ].attackerent = eattacker;
        victim.attackerdata[ eattacker.guid ].firsttimedamaged = gettime();
        victim.attackerdata[ eattacker.guid ].hitcount = 1;
        victim.attackerdata[ eattacker.guid ].var_f3734f16a3fc2423 = 1;
    }
    
    victim.attackerdata[ eattacker.guid ] damage_effects::updatefirsttimedamaged();
    victim.attackerdata[ eattacker.guid ].damage += idamage;
    victim.attackerdata[ eattacker.guid ].vpoint = vpoint;
    victim.attackerdata[ eattacker.guid ].vdir = vdir;
    victim.attackerdata[ eattacker.guid ].partname = partname;
    victim.attackerdata[ eattacker.guid ].smeansofdeath = smeansofdeath;
    victim.attackerdata[ eattacker.guid ].attackerent = eattacker;
    victim.attackerdata[ eattacker.guid ].lasttimedamaged = gettime();
    victim.attackerdata[ eattacker.guid ].objweapon = objweapon;
    
    if ( !isdefined( victim.attackerdata[ eattacker.guid ].var_2a11f150d0e7dca4 ) )
    {
        victim.attackerdata[ eattacker.guid ].var_2a11f150d0e7dca4 = 0;
    }
    
    if ( !player::isinlaststand( victim ) )
    {
        victim.attackerdata[ eattacker.guid ].var_2a11f150d0e7dca4 = gettime();
    }
    
    if ( isplayer( victim ) && bots_util::function_deef484b5b3a3977() )
    {
        victim function_a413e91ba3513105( eattacker.guid, victim.attackerdata[ eattacker.guid ] );
    }
}

// Namespace damage
// Params 0
// Checksum 0x5fa89dcf, Offset: 0x1c5cc
// Size: 0x2e
function resetattackerlist()
{
    self.attackers = [];
    self.attackerdata = [];
    
    if ( isplayer( self ) && bots_util::function_deef484b5b3a3977() )
    {
        self function_e9f7073565ae6e49();
    }
}

// Namespace damage
// Params 18
// Checksum 0x2b5ae94, Offset: 0x1c602
// Size: 0xc6
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    callback_playerdamage_internal( einflictor, eattacker, self, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams );
}

// Namespace damage
// Params 3
// Checksum 0x370ae263, Offset: 0x1c6d0
// Size: 0x29
function function_4aaeed9fade1dcd( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 )
{
    function_c8187a18dfbd8beb( eattacker, var_5bf42dcb704ef501, var_5c1822850207de16 );
}

// Namespace damage
// Params 6
// Checksum 0xb52cd9b5, Offset: 0x1c701
// Size: 0x692
function function_230e2a69150a8eb4( eattacker, var_23646deaadab01d3, idamage, fdistance, objweapon, shitloc )
{
    if ( shouldrecorddamagestats( eattacker ) )
    {
        var_e9d5705bf2d8dd3d = min( self.health, idamage );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
        {
            if ( isdefined( eattacker.leaderboarddata[ "damage" ] ) )
            {
                eattacker.leaderboarddata[ "damage" ] = eattacker.leaderboarddata[ "damage" ] + var_23646deaadab01d3;
            }
            
            if ( isdefined( level.leaderboardfunc[ "damage" ] ) )
            {
                [[ level.leaderboardfunc[ "damage" ] ]]( eattacker, var_23646deaadab01d3 );
            }
            
            assert( isint( var_23646deaadab01d3 ) || isfloat( var_23646deaadab01d3 ), "<dev string:xe1>" );
            
            if ( isdefined( eattacker.pers[ "damage" ] ) )
            {
                eattacker.pers[ "damage" ] = eattacker.pers[ "damage" ] + var_23646deaadab01d3;
            }
        }
        
        if ( isdefined( eattacker.pers[ "friendlyDamageDone" ] ) && self.team == eattacker.team )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
            {
                if ( isdefined( eattacker.leaderboarddata[ "friendlyDamageDone" ] ) )
                {
                    eattacker.leaderboarddata[ "friendlyDamageDone" ] = eattacker.leaderboarddata[ "friendlyDamageDone" ] + var_23646deaadab01d3;
                }
                
                if ( isdefined( level.leaderboardfunc[ "friendlyDamageDone" ] ) )
                {
                    [[ level.leaderboardfunc[ "friendlyDamageDone" ] ]]( eattacker, var_23646deaadab01d3 );
                }
                
                assert( isint( var_23646deaadab01d3 ) || isfloat( var_23646deaadab01d3 ), "<dev string:xe1>" );
                
                if ( isdefined( eattacker.pers[ "friendlyDamageDone" ] ) )
                {
                    eattacker.pers[ "friendlyDamageDone" ] = eattacker.pers[ "friendlyDamageDone" ] + var_23646deaadab01d3;
                }
            }
        }
        
        if ( !isdefined( eattacker.damagethisround ) )
        {
            eattacker.damagethisround = var_23646deaadab01d3;
        }
        else
        {
            eattacker.damagethisround += var_23646deaadab01d3;
        }
        
        if ( eattacker != self && self.team != eattacker.team )
        {
            eattacker codcasterclientmatchdata::function_d1f0591eda60c559( 1, var_23646deaadab01d3 );
            eattacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, var_e9d5705bf2d8dd3d, "damage", self );
        }
        
        if ( shitloc == "head" && isdefined( eattacker.pers[ "shotsHitHead" ] ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( eattacker ) ) )
            {
                if ( isdefined( eattacker.leaderboarddata[ "shotsHitHead" ] ) )
                {
                    eattacker.leaderboarddata[ "shotsHitHead" ] = eattacker.leaderboarddata[ "shotsHitHead" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "shotsHitHead" ] ) )
                {
                    [[ level.leaderboardfunc[ "shotsHitHead" ] ]]( eattacker, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
                
                if ( isdefined( eattacker.pers[ "shotsHitHead" ] ) )
                {
                    eattacker.pers[ "shotsHitHead" ] = eattacker.pers[ "shotsHitHead" ] + 1;
                }
            }
        }
        
        eattacker utility::trycall( level.matchdata_logweaponstat, weapon::getweaponrootname( objweapon ), "damage", min( self.health, idamage ), -1 );
        weaponobj = weapon::mapweapon( objweapon );
        eattacker thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, var_23646deaadab01d3, "damage_dealt" );
        
        if ( player_utility::function_51a0c300008ab56b( eattacker, self ) )
        {
            if ( !isdefined( eattacker.pers[ "telemetry" ].var_aaefe63e2908cf61 ) )
            {
                eattacker.pers[ "telemetry" ].var_aaefe63e2908cf61 = 0;
            }
            
            eattacker.pers[ "telemetry" ].var_aaefe63e2908cf61 = eattacker.pers[ "telemetry" ].var_aaefe63e2908cf61 + var_e9d5705bf2d8dd3d;
        }
        
        if ( isbot( self ) )
        {
            if ( !isdefined( eattacker.pers[ "telemetry" ].var_10c1b854abd32824 ) )
            {
                eattacker.pers[ "telemetry" ].var_10c1b854abd32824 = 0;
            }
            
            eattacker.pers[ "telemetry" ].var_10c1b854abd32824 = eattacker.pers[ "telemetry" ].var_10c1b854abd32824 + var_e9d5705bf2d8dd3d;
        }
        else
        {
            if ( !isdefined( eattacker.pers[ "telemetry" ].var_af5fee48115acc2c ) )
            {
                eattacker.pers[ "telemetry" ].var_af5fee48115acc2c = 0;
            }
            
            eattacker.pers[ "telemetry" ].var_af5fee48115acc2c = eattacker.pers[ "telemetry" ].var_af5fee48115acc2c + var_e9d5705bf2d8dd3d;
        }
        
        if ( isbot( eattacker ) )
        {
            if ( !isdefined( self.pers[ "telemetry" ].var_ed8397fa350b0793 ) )
            {
                self.pers[ "telemetry" ].var_ed8397fa350b0793 = 0;
            }
            
            self.pers[ "telemetry" ].var_ed8397fa350b0793 = self.pers[ "telemetry" ].var_ed8397fa350b0793 + var_e9d5705bf2d8dd3d;
        }
        else
        {
            if ( !isdefined( self.pers[ "telemetry" ].var_596bc72160ba30dd ) )
            {
                self.pers[ "telemetry" ].var_596bc72160ba30dd = 0;
            }
            
            self.pers[ "telemetry" ].var_596bc72160ba30dd = self.pers[ "telemetry" ].var_596bc72160ba30dd + var_e9d5705bf2d8dd3d;
        }
        
        return;
    }
    
    if ( isdefined( level.onattackerdamagenottracked ) )
    {
        eattacker [[ level.onattackerdamagenottracked ]]( var_23646deaadab01d3 );
    }
}

// Namespace damage
// Params 19
// Checksum 0x7f6be7cf, Offset: 0x1cd9b
// Size: 0x86e
function finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, flinch, lightarmordamage, heavyarmordamage, victimdamage, poisedamage, shouldknockdown )
{
    idamage = int( idamage );
    var_23646deaadab01d3 = int( min( idamage, self.health ) );
    
    if ( isplayer( eattacker ) && !issimulationplayer( eattacker ) )
    {
        if ( eattacker != self )
        {
            if ( eattacker gameplay_telemetry_utils::function_944c6d9098e40dfb( self ) )
            {
                eattacker thread gameplay_telemetry::function_383cde919fd850c4( "damageDealt", 2, var_23646deaadab01d3 );
                eattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_damagedealt", objweapon.basename, 3, var_23646deaadab01d3 );
                eattacker gameplay_telemetry::function_318b3726867c0e81( objweapon, 2 );
            }
        }
        
        function_230e2a69150a8eb4( eattacker, var_23646deaadab01d3, idamage, fdistance, objweapon, shitloc );
    }
    else if ( isdefined( einflictor ) && einflictor vehicle::is_vehicle() )
    {
        vehicle = einflictor;
        
        if ( isplayer( vehicle.owner ) )
        {
            function_230e2a69150a8eb4( vehicle.owner, var_23646deaadab01d3, idamage, fdistance, objweapon, shitloc );
        }
    }
    else if ( isdefined( eattacker ) && eattacker vehicle::is_vehicle() )
    {
        vehicle = eattacker;
        
        if ( isplayer( vehicle.owner ) )
        {
            function_230e2a69150a8eb4( vehicle.owner, var_23646deaadab01d3, idamage, fdistance, objweapon, shitloc );
        }
    }
    
    if ( isplayer( self ) )
    {
        thread gameplay_telemetry::function_383cde919fd850c4( "damageReceived", 2, var_23646deaadab01d3 );
    }
    
    if ( isplayer( eattacker ) && eattacker ismeatshieldattacker() )
    {
        if ( !isdefined( eattacker.meat_shield_damage_dealt ) )
        {
            eattacker.meat_shield_damage_dealt = 0;
        }
        
        eattacker.meat_shield_damage_dealt += var_23646deaadab01d3;
    }
    
    if ( isplayer( self ) && shouldrecorddamagestats( self ) && !issimulationplayer( self ) )
    {
        weaponobj = self.lastdroppableweaponobj;
        weaponobj = weapon::mapweapon( weaponobj );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "damageTaken" ] ) )
            {
                self.leaderboarddata[ "damageTaken" ] = self.leaderboarddata[ "damageTaken" ] + var_23646deaadab01d3;
            }
            
            if ( isdefined( level.leaderboardfunc[ "damageTaken" ] ) )
            {
                [[ level.leaderboardfunc[ "damageTaken" ] ]]( self, var_23646deaadab01d3 );
            }
            
            assert( isint( var_23646deaadab01d3 ) || isfloat( var_23646deaadab01d3 ), "<dev string:xe1>" );
            
            if ( isdefined( self.pers[ "damageTaken" ] ) )
            {
                self.pers[ "damageTaken" ] = self.pers[ "damageTaken" ] + var_23646deaadab01d3;
            }
        }
        
        thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, 1, "hit_markers_taken", undefined, eattacker );
        thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, var_23646deaadab01d3, "damage_taken", undefined, eattacker );
    }
    
    if ( isdefined( einflictor ) && isdefined( einflictor.streakinfo ) && isdefined( einflictor.streakinfo.damage ) )
    {
        einflictor.streakinfo.damage += idamage;
    }
    
    if ( playershoulddofauxdeath() && idamage >= self.health && !( idflags & 16 ) && allowfauxdeath() )
    {
        if ( !isdefined( vdir ) )
        {
            vdir = ( 0, 0, 0 );
        }
        
        if ( !isdefined( eattacker ) )
        {
            eattacker = self;
        }
        
        if ( !isdefined( einflictor ) )
        {
            einflictor = eattacker;
        }
        
        playerkilled_internal( einflictor, eattacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 0, 1 );
    }
    else
    {
        if ( isdefined( self.var_5eced67e46f64479 ) )
        {
            isfataldamage = idamage >= self.health;
            isvalidshielddamage = gettime() - self.var_5eced67e46f64479 <= 1000 && riotshield::riotshield_hasweapon() && function_e3c4fc450ca6942a( objweapon, smeansofdeath );
            var_198c766883d11ac8 = !utility::isusingremote();
            
            if ( isfataldamage && isvalidshielddamage && var_198c766883d11ac8 )
            {
                /#
                    iprintln( "<dev string:x51d>" + self.name );
                #/
                
                self suicide();
                function_2499f72abb86f810( self, "forcing suicide on riot shield player" );
                return;
            }
        }
        
        if ( !callback_killingblow( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime ) )
        {
            function_2499f72abb86f810( self, "Callback_KillingBlow == false" );
            return;
        }
        
        if ( !isalive( self ) )
        {
            function_2499f72abb86f810( self, "!IsAlive" );
            return;
        }
        
        if ( isplayer( self ) )
        {
            if ( !isdefined( partname ) )
            {
                partname = "";
            }
            
            if ( !isdefined( lightarmordamage ) )
            {
                lightarmordamage = 0;
            }
            
            if ( !isdefined( heavyarmordamage ) )
            {
                heavyarmordamage = 0;
            }
            
            if ( !isdefined( victimdamage ) )
            {
                victimdamage = 0;
            }
            
            damagescore = scoredamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage );
            idflags = function_db0256cf366b6094( idflags, smeansofdeath, objweapon );
            
            if ( !isdefined( flinch ) )
            {
                var_c1db6e112670f76e = smeansofdeath == "MOD_TRIGGER_HURT" && isdefined( self.islaststandbleedoutdmg );
                iscircledamage = smeansofdeath == "MOD_TRIGGER_HURT" && ( objweapon.basenamehash == %"danger_circle_br" || objweapon.basenamehash == %"rex_radiation_dmz" );
                flinch = !var_c1db6e112670f76e && !iscircledamage;
            }
            
            if ( isplayer( eattacker ) && eattacker != self )
            {
                if ( !isdefined( eattacker.var_c8e77c8b66f05eaa ) )
                {
                    eattacker.var_c8e77c8b66f05eaa = gettime();
                }
                
                function_4a4ad03615233c7c( eattacker );
                function_4a4ad03615233c7c( self );
            }
            
            if ( !isdefined( self.var_d15047abc75b9fb7 ) )
            {
                self.var_d15047abc75b9fb7 = gettime();
            }
            
            if ( game_utility_mp::isteamreviveenabled() && !game_utility_mp::ismutationgamemodezombie() && idamage >= self.health && !laststand::function_902b5a239dd4a73a( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 500 ) && ( !level.var_7b18d7f69313853a || teams::getteamdata( self.team, "noRespawns" ) ) )
            {
                if ( self.inlaststand )
                {
                    self laststandrevive();
                }
                
                self notify( #"enter_live_ragdoll" );
                idamage = self.health - 1;
                println( "<dev string:x561>" + gettime() + "<dev string:x564>" + self.name + "<dev string:x567>" + self.health + "<dev string:x59d>" + idamage + "<dev string:x5af>" );
                self finishplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, 0, modelindex, partname, flinch, fdistance, damagescore, lightarmordamage, heavyarmordamage, victimdamage, poisedamage, shouldknockdown );
                println( "<dev string:x561>" + gettime() + "<dev string:x564>" + self.name + "<dev string:x5b7>" + self.health + "<dev string:x5ee>" );
                
                if ( isdefined( einflictor ) && isdefined( eattacker ) )
                {
                    self lookatkiller( einflictor, eattacker );
                }
                
                player::_freezecontrols( 1, undefined, "liveRagdoll" );
                self sethidenameplate( 1 );
                self.healthregendisabled = 1;
                self.liveragdoll = 1;
                self function_53d446e6e6a7f1ac( 1 );
                self function_715e8b27564eeece( 1 );
                self startliveragdoll();
                
                if ( self getcamerathirdperson() )
                {
                    self.var_b4f3321870f4a286 = 1;
                }
                else
                {
                    self.var_b4f3321870f4a286 = undefined;
                }
                
                class::setthirdpersonview();
                
                if ( !isdefined( einflictor ) && !isdefined( eattacker ) )
                {
                    einflictor = self;
                    eattacker = self;
                }
                
                thread playerkilled_internal( einflictor, eattacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, 500, 0 );
                self notify( #"death" );
                self notify( #"death_or_disconnect" );
            }
            else
            {
                sound::function_739ef269e7eed028( objweapon );
                self finishplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, 0, modelindex, partname, flinch, fdistance, damagescore, lightarmordamage, heavyarmordamage, victimdamage, poisedamage, shouldknockdown );
            }
        }
    }
    
    damageshellshockandrumble( einflictor, objweapon, smeansofdeath, idamage, idflags, eattacker );
}

// Namespace damage
// Params 1
// Checksum 0xd855b825, Offset: 0x1d611
// Size: 0x6d
function function_4a4ad03615233c7c( player )
{
    if ( !isdefined( player.var_13e00284b1601b70 ) )
    {
        timesincespawned = player.spawntime;
        
        if ( isdefined( player.var_b73925ccb5007bd8 ) )
        {
            timesincespawned = player.var_b73925ccb5007bd8;
            player.var_b73925ccb5007bd8 = undefined;
        }
        
        player.var_13e00284b1601b70 = gettime() - timesincespawned;
    }
}

// Namespace damage
// Params 1
// Checksum 0xcd06d973, Offset: 0x1d686
// Size: 0x38, Type: bool
function shoulduseexplosiveindicator( smeansofdeath )
{
    return smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_FIRE";
}

// Namespace damage
// Params 11
// Checksum 0x273aa41b, Offset: 0x1d6c7
// Size: 0x7e
function callback_playerimpaled( eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100, isagent )
{
    thread weapons::impale( eattacker, self, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100, isagent );
}

// Namespace damage
// Params 6
// Checksum 0x1be94174, Offset: 0x1d74d
// Size: 0x91
function function_42649d6d0a964fbd( eattacker, objweapon, vdir, magnitude, shitloc, isagent )
{
    if ( isdefined( objweapon.weaponblueprint ) && objweapon.weaponblueprint.lootid == 64155 )
    {
        magnitude *= 3;
        vdir = ( vdir[ 0 ], vdir[ 1 ], vdir[ 2 ] + 0.5 );
    }
    
    weapons::launch( eattacker, self, objweapon, vdir, magnitude, shitloc, isagent );
}

// Namespace damage
// Params 0
// Checksum 0x8aff1341, Offset: 0x1d7e6
// Size: 0x22
function allowfauxdeath()
{
    if ( !isdefined( level.allowfauxdeath ) )
    {
        level.allowfauxdeath = 1;
    }
    
    return level.allowfauxdeath;
}

// Namespace damage
// Params 1
// Checksum 0x178eaf07, Offset: 0x1d811
// Size: 0x14e
function function_ee00f85ddd486a3b( deathdata )
{
    victim = self;
    deathdata.deathtype = playerkilled_finddeathtype( deathdata );
    
    switch ( deathdata.deathtype )
    {
        case #"hash_1184b43822fe56f0":
            function_c34797baf24976a1( victim, deathdata.attacker, deathdata );
            break;
        case #"hash_ce250de499ae9603":
            if ( !level.gamemodebundle.var_2fc669d4ccb1f63e && !deathdata.victim.disable_killcam )
            {
                deathdata.dokillcam = 1;
                
                if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
                {
                    logstring( "[KILLCAM DEBUG] [" + ( deathdata.victim ? deathdata.victim.name : "undefined" ) + "] " + "handleInLastStandDeath - deathData.victim.disable_killcam - deathData.doKillcam=" + deathdata.dokillcam );
                }
            }
            
            handlenormaldeathkillcam( victim, deathdata );
            break;
        case #"hash_a9f265ec10b615d":
            handlenormaldeathkillcam( victim, deathdata );
            break;
        default:
            break;
    }
    
    victim playerkilled_killcamsetup( deathdata );
}

// Namespace damage
// Params 10
// Checksum 0x354bc46a, Offset: 0x1d967
// Size: 0x86b, Type: bool
function callback_playerlaststand( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    forcelaststand = isforcedlaststand( self, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc );
    var_1a1364a5ff1e2f38 = laststand::function_902b5a239dd4a73a( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration );
    
    if ( !forcelaststand && !var_1a1364a5ff1e2f38 )
    {
        return false;
    }
    
    gametype = game_utility::getgametype();
    var_7f613f71e183715c = isplayer( attacker );
    var_85677bf7b1a7b0ea = isagent( attacker );
    
    if ( var_7f613f71e183715c && attacker != self )
    {
        if ( !attacker.gulag && !level.var_5195f9fa56bdff5 )
        {
            attacker thread hud_message::showsplash( "br_enemy_downed", undefined, self );
        }
        
        attacker notify( #"hash_1a40374ba454c2e6", self, objweapon, smeansofdeath );
    }
    
    if ( isdefined( level.parachuteprelaststandfunc ) )
    {
        self [[ level.parachuteprelaststandfunc ]]();
    }
    
    if ( self isskydiving() )
    {
        self skydive_interrupt();
    }
    
    lifeid = self.matchdatalifeindex;
    
    if ( !isdefined( lifeid ) )
    {
        lifeid = level.maxlives - 1;
    }
    
    isbr = isbrgamemode();
    
    if ( isbr )
    {
        if ( !isdefined( self.timesdowned ) )
        {
            self.timesdowned = 0;
        }
        
        self.timesdowned++;
    }
    
    var_ed818825b86cf381 = 0;
    deathdata = { #meansofdeath:smeansofdeath, #victim:self };
    
    if ( isdefined( attacker ) && attacker.classname != "worldspawn" || level.var_b24f65709b8c089b )
    {
        if ( isdefined( attacker.var_651f886e839b954e ) )
        {
            attacker [[ attacker.var_651f886e839b954e ]]( self );
        }
        
        if ( !var_7f613f71e183715c )
        {
            if ( isplayer( attacker.owner ) )
            {
                attacker = attacker.owner;
                var_7f613f71e183715c = 1;
            }
            else if ( isdefined( einflictor ) && isplayer( einflictor.owner ) )
            {
                attacker = einflictor.owner;
                var_7f613f71e183715c = 1;
            }
        }
        
        deathdata = playerkilled_initdeathdata( einflictor, attacker, self, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, 0 );
        playerkilled_parameterfixup( deathdata );
        playerkilled_precalc( deathdata );
        deathdata.laststandkill = 1;
        self.playergoingintols = 1;
        
        if ( ( var_7f613f71e183715c || var_85677bf7b1a7b0ea ) && attacker != self )
        {
            self.laststandattacker = attacker;
            self.laststandinflictor = einflictor;
            self.laststandmeansofdeath = deathdata.meansofdeath;
            self.var_a54cf862f580156 = objweapon;
            self.var_3242e03bf1b09197 = self.origin;
            self.var_8f849ee66df5a544 = deathdata.iskillstreakweapon;
        }
        
        self.lastbounty = bounty::playergetbountypoints();
        bounty::playerresetbountypoints();
        bounty::playerresetbountystreak();
        deathdata.isfriendlyfire = isfriendlyfire( self, attacker );
        
        if ( getdvarint( @"hash_98f5c716d594181b", 1 ) )
        {
            self.laststanddowneddata = structcopy( deathdata );
            function_ee00f85ddd486a3b( self.laststanddowneddata );
        }
        
        if ( function_56b8fd2ccc68ddf9() )
        {
            self.laststanddowneddata = deathdata;
        }
        
        if ( !level.gamemodebundle.var_9a2648e733e507e7 )
        {
            self.laststanddowneddata = structcopy( deathdata );
            function_ee00f85ddd486a3b( self.laststanddowneddata );
            inflictorisequipment = istrue( einflictor.isequipment );
            var_ba78af0f54c15adf = istrue( einflictor.issuper );
            
            if ( inflictorisequipment || var_ba78af0f54c15adf || isdefined( einflictor.streakinfo ) )
            {
                inflictorcopy = { #owner:einflictor.owner, #streakinfo:einflictor.streakinfo, #equipmentref:einflictor.equipmentref, #issuper:var_ba78af0f54c15adf, #isequipment:inflictorisequipment };
                self.var_24c4c756a0d798dd = inflictorcopy;
            }
        }
        
        if ( !deathdata.isfriendlyfire && attacker != self )
        {
            var_ed818825b86cf381 = 1;
            
            if ( attacker gameplay_telemetry_utils::function_944c6d9098e40dfb( self ) )
            {
                attacker thread gameplay_telemetry::function_383cde919fd850c4( "operatorDowns", 2 );
                attacker thread gameplay_telemetry::function_3b8d40426c725ea0( "weap_downs", objweapon.basename, 2 );
            }
            
            if ( isbr )
            {
                if ( var_7f613f71e183715c && attacker != self )
                {
                    attacker br_public::incrementplayersdownedstat();
                    attacker thread rank::scoreeventpopup( #"downed" );
                    killstreakweaponname = killstreak::getkillstreaknamefromweapon( objweapon );
                    
                    if ( isdefined( killstreakweaponname ) )
                    {
                        if ( isdefined( attacker.var_bf76d1814a73cd34 ) )
                        {
                            attacker.var_bf76d1814a73cd34++;
                        }
                    }
                }
                
                if ( attacker != self )
                {
                    if ( gametype != "plunder" && gametype != "risk" && gametype != "kingslayer" && gametype != "codmas_clash" && level.teamdata[ self.team ][ "alivePlayers" ].size > 0 && var_7f613f71e183715c )
                    {
                        obitplayers = [];
                        
                        if ( isdefined( level.codcasters ) )
                        {
                            obitplayers = level.codcasters;
                        }
                        
                        obitplayers = arraycombine( obitplayers, level.teamdata[ attacker.team ][ "players" ] );
                        var_924abc145a22046e = br_spectate::getspectatorsofplayer( attacker );
                        
                        if ( isdefined( var_924abc145a22046e ) )
                        {
                            obitplayers = arraycombine( obitplayers, var_924abc145a22046e );
                        }
                        
                        obituary( self, attacker, objweapon, "MOD_DOWN", obitplayers );
                    }
                    
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"squad_down_enemy", level.teamdata[ self.team ][ "alivePlayers" ] );
                }
                else
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"squad_down_self", level.teamdata[ self.team ][ "alivePlayers" ] );
                }
                
                if ( isdefined( level.br_circle.circleindex ) )
                {
                    circle = min( max( 0, level.br_circle.circleindex ), 5 );
                    event = hashcat( #"br_downenemy_circle_", string( circle ) );
                    
                    if ( rank::function_dd61d4640c245ebc( event ) )
                    {
                        attacker thread points::doscoreevent( event, objweapon, undefined, undefined, self );
                    }
                }
            }
        }
        
        function_e27976b1ab5b0348( attacker, self, 1 );
    }
    
    if ( gametype == "plunder" || gametype == "risk" )
    {
        br_plunder::plunder_allowallrepositoryuseforplayer( self, 0, 1 );
    }
    
    if ( isbr || isdmzgamemode() )
    {
        if ( smeansofdeath != "MOD_FALLING" )
        {
            armor::setarmorhealth( 0, 1 );
        }
        
        br_analytics::branalytics_down( attacker, self, objweapon, "deathType_downed", smeansofdeath );
        
        if ( smeansofdeath == "MOD_CRUSH" && isdefined( einflictor.classname ) && einflictor.classname == "script_vehicle" )
        {
            playsoundatpos( self.origin + ( 0, 0, 18 ), "vehicle_body_hit" );
        }
    }
    
    if ( br_public::isbrpracticemode() )
    {
        if ( isplayer( attacker ) && !isbot( attacker ) )
        {
            attacker notify( #"hash_3cf2917b5c702564" );
        }
    }
    
    thread laststand::enter( deathdata );
    
    if ( isdefined( level.checkforlaststandwipe ) )
    {
        if ( [[ level.checkforlaststandwipe ]]( self ) )
        {
            self.playergoingintols = 0;
            return false;
        }
    }
    
    if ( isplayer( self ) )
    {
        talking_gun::talkinggun_event( self, #"player_knocked_down" );
        
        if ( var_7f613f71e183715c )
        {
            talking_gun::talkinggun_event( attacker, #"knocked_down_enemy" );
        }
    }
    
    if ( playerkilled_washitbyvehicle( smeansofdeath, einflictor ) )
    {
        einflictor notify( #"vehicle_downed_player" );
    }
    
    if ( var_ed818825b86cf381 && isdefined( attacker.guid ) )
    {
        function_cb58faabc0fd9c21( 1 );
        function_5eecf23a1765bbb2( attacker, 1 );
    }
    
    return true;
}

// Namespace damage
// Params 3
// Checksum 0x9897205b, Offset: 0x1e1db
// Size: 0x5e
function function_db0256cf366b6094( idflags, smeansofdeath, objweapon )
{
    if ( shoulduseexplosiveindicator( smeansofdeath ) )
    {
        idflags |= 256;
    }
    
    if ( weapon_utility::function_50055d29b455bc79( objweapon ) )
    {
        idflags |= 1048576;
    }
    
    if ( self.var_aab5beb67c1704ec )
    {
        idflags |= 67108864;
    }
    
    return idflags;
}

// Namespace damage
// Params 0
// Checksum 0x80f1196e, Offset: 0x1e242
// Size: 0x18
function function_4d6bc0e8404c6e6c()
{
    return getdvarfloat( @"hash_568c61c9cb10a05a", 20 ) * 1000;
}

// Namespace damage
// Params 1
// Checksum 0x2f4ef44d, Offset: 0x1e263
// Size: 0x16f
function function_cb58faabc0fd9c21( isdowned )
{
    if ( getdvarint( @"hash_3352584db9b5ae7b", 1 ) == 0 )
    {
        return;
    }
    
    if ( self.var_1030b877096cfad2 )
    {
        return;
    }
    
    currenttime = gettime();
    ignoremaxtime = function_4d6bc0e8404c6e6c();
    attackercount = 0;
    
    foreach ( data in self.attackerdata )
    {
        if ( data.attackerent == self )
        {
            continue;
        }
        
        elapsedtime = data.lasttimedamaged - currenttime;
        
        if ( abs( elapsedtime ) > ignoremaxtime )
        {
            continue;
        }
        
        attackercount++;
    }
    
    attackercount = int( clamp( attackercount, 0, 15 ) );
    self setclientomnvar( "ui_num_attackers", attackercount );
    self.var_1030b877096cfad2 = 1;
    
    if ( attackercount > 1 )
    {
        thread rank::scoreeventpopup( #"downed_victim_multi" );
        return;
    }
    
    if ( isdowned )
    {
        if ( getdvarint( @"hash_a188996b14552063", 0 ) == 1 )
        {
            thread rank::scoreeventpopup( #"downed_victim" );
        }
    }
}

// Namespace damage
// Params 8
// Checksum 0x760384fa, Offset: 0x1e3da
// Size: 0x17f
function isforcedlaststand( victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc )
{
    forcelaststand = 0;
    
    /#
        var_627fc6e71a7f6002 = getdvarint( @"hash_9564fda23c9d6dbd", 0 );
        
        if ( var_627fc6e71a7f6002 )
        {
            return 1;
        }
    #/
    
    if ( level.var_dce68d4837fb7c51 && isbot( victim ) )
    {
        return 1;
    }
    
    var_63cc35d3a425b56 = istrue( level.gametypebundle.var_63cc35d3a425b56 );
    var_5ee13a28080c5e33 = istrue( level.gametypebundle.var_5ee13a28080c5e33 );
    
    if ( var_63cc35d3a425b56 || var_5ee13a28080c5e33 )
    {
        if ( br_public::istutorial() )
        {
            return 1;
        }
        
        if ( !flags::gameflagexists( "prematch_done" ) || flags::gameflag( "prematch_done" ) )
        {
            if ( !self.gulagarena && !self.inlaststand )
            {
                if ( smeansofdeath == "MOD_FALLING" && var_63cc35d3a425b56 || smeansofdeath == "MOD_FIRE" && var_5ee13a28080c5e33 )
                {
                    forcelaststand = 1;
                }
            }
        }
    }
    
    if ( level.var_c816553278678d8a )
    {
        forcelaststand = 1;
    }
    
    if ( isdefined( level.var_43618bb5c38bef6e ) )
    {
        forcelaststand = self [[ level.var_43618bb5c38bef6e ]]( victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc );
    }
    
    return forcelaststand;
}

// Namespace damage
// Params 1
// Checksum 0xadff1568, Offset: 0x1e562
// Size: 0x102
function gethitlocheight( shitloc )
{
    switch ( shitloc )
    {
        case #"hash_8a1772f5f912c880":
        case #"hash_92bbfe494d03d772":
        case #"hash_b107b5547c755d23":
            return 60;
        case #"hash_da51cc36a471058":
        case #"hash_51d5d0b9add9cc5a":
        case #"hash_5d5aac570f6fd382":
        case #"hash_a7980c387477e7bb":
        case #"hash_b275b50677dcf6cb":
        case #"hash_d42e71cd9f1e822f":
        case #"hash_da2f35145aa58933":
        case #"hash_fb5b5e6c07253005":
            return 48;
        case #"hash_fbb61fc356f3c75e":
            return 40;
        case #"hash_1cbc508a2fe01b79":
        case #"hash_810a7426c8bac3ac":
            return 32;
        case #"hash_7b36142458a6c2d5":
        case #"hash_a638fec9040cfcf4":
            return 10;
        case #"hash_168c74e879f0ba11":
        case #"hash_9536712388e65bce":
            return 5;
    }
    
    return 48;
}

// Namespace damage
// Params 6
// Checksum 0x182e1e6c, Offset: 0x1e66d
// Size: 0xbe
function damageshellshockandrumble( einflictor, objweapon, smeansofdeath, idamage, idflags, eattacker )
{
    thread weapons::onweapondamage( einflictor, objweapon, smeansofdeath, idamage, eattacker );
    
    if ( !isai( self ) && utility::getdamagetype( smeansofdeath ) != #"bullet" )
    {
        self playrumbleonentity( "damage_heavy" );
        
        if ( isdefined( einflictor ) && isdefined( einflictor.var_7c439348ae863f40 ) )
        {
            self [[ einflictor.var_7c439348ae863f40 ]]( einflictor );
            return;
        }
        
        if ( !isbrgamemode() && smeansofdeath == "MOD_TRIGGER_HURT" )
        {
            self playsoundtoplayer( #"trigger_hurt_impact_plr", self );
        }
    }
}

// Namespace damage
// Params 10
// Checksum 0xe0f44829, Offset: 0x1e733
// Size: 0x5f, Type: bool
function callback_killingblow( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    return true;
}

// Namespace damage
// Params 3
// Checksum 0x60e03097, Offset: 0x1e79b
// Size: 0x7f
function function_f4559c300b8ac145( eattacker, victim, idflags )
{
    if ( !( isdefined( eattacker ) && isdefined( victim ) ) )
    {
        return;
    }
    
    eattacker endon( #"disconnect" );
    victim endon( #"disconnect" );
    outlinetype = "outline_nodepth_trans_white";
    victim outline::hudoutline_enable_internal( eattacker, "damage", outlinetype );
    wait 0.2;
    victim outline::function_a232cd494502454d( eattacker, "damage", 1 );
}

// Namespace damage
// Params 1
// Checksum 0x1f1eae0c, Offset: 0x1e822
// Size: 0x20
function emitfalldamage( idamage )
{
    physicsexplosionsphere( self.origin, 64, 64, 1 );
}

// Namespace damage
// Params 11
// Checksum 0xd17749f9, Offset: 0x1e84a
// Size: 0x252
function gamemodemodifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( isplayer( eattacker ) && isalive( eattacker ) )
    {
        if ( level.matchrules_damagemultiplier )
        {
            idamage *= level.matchrules_damagemultiplier;
        }
        
        if ( level.matchrules_vampirism )
        {
            eattacker.health = int( min( float( eattacker.maxhealth ), min( eattacker.health + idamage, float( eattacker.health + 20 ) ) ) );
            eattacker notify( #"vampirism" );
        }
        
        if ( game_utility::function_ae97372c83da7acc() && utility::isbulletdamage( smeansofdeath ) && !isspreadweapon( objweapon ) )
        {
            switch ( shitloc )
            {
                case #"hash_8a1772f5f912c880":
                case #"hash_92bbfe494d03d772":
                case #"hash_b107b5547c755d23":
                    if ( !victim killstreak::isjuggernaut() )
                    {
                        idamage = victim.maxhealth;
                        
                        if ( isdefined( victim.maxarmorhealth ) )
                        {
                            idamage += victim.maxarmorhealth;
                        }
                    }
                    
                    break;
                default:
                    break;
            }
        }
        
        if ( game[ "isLaunchChunk" ] )
        {
            if ( game[ "launchChunkRuleSet" ] == 0 || game[ "launchChunkRuleSet" ] == 3 )
            {
                if ( !isbot( victim ) )
                {
                    if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT" )
                    {
                        var_45df31d9dde18c5c = 80;
                        
                        if ( !isplayer( eattacker ) || !isplayer( victim ) )
                        {
                            return 0;
                        }
                        
                        victimangles = victim getplayerangles();
                        attackerangles = eattacker getplayerangles();
                        anglediff = angleclamp180( victimangles[ 1 ] - attackerangles[ 1 ] );
                        
                        if ( abs( anglediff ) < var_45df31d9dde18c5c )
                        {
                            idamage *= 0.3;
                        }
                    }
                }
            }
        }
    }
    
    return idamage;
}

// Namespace damage
// Params 4
// Checksum 0x916f70df, Offset: 0x1eaa5
// Size: 0x158
function registerkill( objweapon, smeansofdeath, var_3547235c1deef51, iskillstreakweapon )
{
    self.killcountthislife++;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "cur_kill_streak" ] ) )
        {
            self.leaderboarddata[ "cur_kill_streak" ] = self.leaderboarddata[ "cur_kill_streak" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "cur_kill_streak" ] ) )
        {
            [[ level.leaderboardfunc[ "cur_kill_streak" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xe1>" );
        
        if ( isdefined( self.pers[ "cur_kill_streak" ] ) )
        {
            self.pers[ "cur_kill_streak" ] = self.pers[ "cur_kill_streak" ] + 1;
        }
    }
    
    thread gameplay_telemetry::function_f98fbe3bbb2ed9f1( "killstreakCount", 1, self.pers[ "cur_kill_streak" ] );
    
    if ( function_f9925926a3a1717a() )
    {
        return;
    }
    
    killcountthislife = self.killcountthislife;
    
    if ( killcountthislife >= 255 )
    {
        killcountthislife = 255;
    }
    
    self setclientomnvar( "ui_life_kill_count", killcountthislife );
}

// Namespace damage
// Params 0
// Checksum 0x40fe42a7, Offset: 0x1ec05
// Size: 0xc, Type: bool
function function_f9925926a3a1717a()
{
    return istrue( level.var_f9925926a3a1717a );
}

// Namespace damage
// Params 8
// Checksum 0x78224669, Offset: 0x1ec1a
// Size: 0x1da
function monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken, var_edfc3e5438cd5590 = 1 )
{
    self notify( #"hash_3e49f34bdf8cd0ad" );
    self endon( #"hash_3e49f34bdf8cd0ad" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"hash_132222844eaf7009" );
    
    if ( !isdefined( rumble ) )
    {
        rumble = 0;
    }
    
    self setcandamage( 1 );
    self.health = 2147483647;
    self.maxhealth = int( maxhealth );
    
    if ( !isdefined( self.damagetaken ) || resetdamagetaken )
    {
        self.damagetaken = 0;
    }
    
    if ( !isdefined( biskillstreak ) )
    {
        biskillstreak = 0;
    }
    
    for ( running = 1; running ; running = monitordamageoneshot( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, time, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, var_edfc3e5438cd5590 ) )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, time );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( rumble )
        {
            self playrumbleonentity( "damage_light" );
        }
    }
}

// Namespace damage
// Params 0
// Checksum 0xcd28ce8e, Offset: 0x1edfc
// Size: 0x47
function monitordamageend()
{
    self notify( #"hash_132222844eaf7009" );
    self.damagetaken = undefined;
    self.attackers = undefined;
    self.wasdamaged = undefined;
    self.wasdamagedfrombulletpenetration = undefined;
    self.wasdamagedfrombulletricochet = undefined;
    self setcandamage( 0 );
}

// Namespace damage
// Params 20
// Checksum 0x490900e8, Offset: 0x1ee4b
// Size: 0x5b2, Type: bool
function monitordamageoneshot( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor, time, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, var_edfc3e5438cd5590 = 1 )
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( var_edfc3e5438cd5590 && isdefined( attacker ) && !( game_utility_common::isgameparticipant( attacker ) || game_utility_common::isgameparticipant( inflictor ) ) )
    {
        return true;
    }
    
    var_8e53c5c5f39e5b6c = utility::isvehiclecrushdamage( inflictor, meansofdeath );
    var_fb59b044887d7953 = var_8e53c5c5f39e5b6c && self.var_86aa957ae630982b;
    
    if ( isdefined( attacker ) && !var_fb59b044887d7953 && !weapons::friendlyfirecheck( self.owner, attacker ) )
    {
        if ( isdefined( self.equipmentref ) && ( self.equipmentref == "equip_tac_cover" || self.equipmentref == "equip_door_barricade" ) )
        {
        }
        else
        {
            return true;
        }
    }
    
    modifieddamage = damage;
    utility::callsharedfunc( #"equipment_interaction", #"on_hit", self, attacker, inflictor, objweapon );
    
    if ( !self.skipignoredamage && non_player_should_ignore_damage( attacker, objweapon, inflictor, meansofdeath ) )
    {
        return true;
    }
    
    if ( isdefined( objweapon ) )
    {
        damagedata = damage_utility::packdamagedata( attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, undefined, partname, tagname, idflags );
        damagedata.biskillstreak = biskillstreak;
        
        if ( !isdefined( modifydamagefunc ) )
        {
            modifydamagefunc = &modifydamage;
        }
        
        modifieddamage = self [[ modifydamagefunc ]]( damagedata );
    }
    
    if ( modifieddamage <= 0 )
    {
        return true;
    }
    
    self.wasdamaged = 1;
    self.damagetaken += int( modifieddamage );
    self.health = 2147483647;
    self notify( #"entity_damage_received" );
    function_5c52d54234e3d0( damagedata );
    
    if ( isplayer( attacker ) )
    {
        if ( isdefined( self.streakinfo ) )
        {
            var_7417ce53f759703f = level.sharedfuncs[ #"killstreak" ][ #"killstreakhit" ];
            
            if ( var_7417ce53f759703f )
            {
                self [[ var_7417ce53f759703f ]]( attacker, objweapon, self, meansofdeath, damage, damagedata );
            }
        }
        
        if ( isdefined( self.weapon_object ) )
        {
            var_256fdc12660ff342 = weapon::getequipmenttype( self.weapon_object );
        }
        
        if ( isdefined( var_256fdc12660ff342 ) && ( var_256fdc12660ff342 == "lethal" || var_256fdc12660ff342 == "tactical" || var_256fdc12660ff342 == "super" ) )
        {
            var_795e8a31194a39ac = { #var_4dba57e6e29ded8e:1, #var_f561a4dd442b0d91:1, #victimentity:self };
            attacker damagefeedback::updatedamagefeedback( damagefeedback, self.damagetaken >= self.maxhealth, undefined, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac, undefined );
        }
        else
        {
            var_7731d58f6f82f082 = { #mod:meansofdeath, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:self };
            attacker damagefeedback::updatedamagefeedback( damagefeedback, self.damagetaken >= self.maxhealth, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_7731d58f6f82f082 );
        }
    }
    
    if ( self.damagetaken >= self.maxhealth )
    {
        damagedata = damage_utility::packdamagedata( attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, undefined, partname, tagname, idflags );
        
        if ( attacker && supers_mp::issuper( self.superref ) && !supers_mp::function_12ae76428d4cf386( self ) )
        {
            equipment_utility::function_9b8126f6415066aa( attacker );
            attacker battlechatter_mp::onfieldupgradedestroy( damagedata );
        }
        
        if ( inflictor && isfunction( inflictor.var_57fc77af24a8791e ) )
        {
            inflictor [[ inflictor.var_57fc77af24a8791e ]]();
        }
        
        if ( isplayer( attacker ) && isdefined( attacker.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
        {
            attacker [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( self );
        }
        
        thread challenges::equipmentdestroyed( self, inflictor, attacker, damage, idflags, undefined, objweapon, undefined, attacker.modifiers );
        
        if ( self.isequipment || self.issuper )
        {
            var_7754a4583dbe5809 = inflictor.streakinfo;
            
            if ( !isdefined( var_7754a4583dbe5809 ) )
            {
                var_7754a4583dbe5809 = inflictor.var_ec0bb630fbaa253a[ objweapon.basename ];
            }
            
            events::killedequipment( self.owner, attacker, objweapon, var_7754a4583dbe5809 );
        }
        
        params = { #equipmentref:self.superref ?? self.equipmentref, #inflictor:inflictor, #player:attacker, #event:#"on_destroyed_equipment" };
        level callback::callback( #"hash_6c71d319dc089c27", params );
        self thread [[ ondeathfunc ]]( damagedata );
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 1
// Checksum 0x241ce78a, Offset: 0x1f406
// Size: 0xc5
function function_5c52d54234e3d0( data )
{
    idflags = data.idflags;
    
    if ( isdefined( idflags ) && idflags & 8 )
    {
        self.wasdamagedfrombulletpenetration = 1;
    }
    
    if ( isdefined( idflags ) && idflags & 256 )
    {
        self.wasdamagedfrombulletricochet = 1;
    }
    
    attacker = data.attacker;
    
    if ( data.var_d21bb34ebd9120e0 )
    {
        killstreaks::killstreakhit( attacker, data.objweapon, self, data.meansofdeath, data.damage, data );
    }
    
    if ( isplayer( attacker ) )
    {
        if ( player::isreallyalive( attacker ) )
        {
            attacker common::function_6b65663570bf5d41();
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x256ebd2c, Offset: 0x1f4d3
// Size: 0xd4
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    
    if ( isdefined( idflags ) && idflags & 256 )
    {
        modifieddamage = 0.6 * damage;
    }
    else
    {
        modifieddamage = damage;
    }
    
    modifieddamage = handleempdamage( objweapon, type, modifieddamage );
    modifieddamage = handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = handlegrenadedamage( objweapon, type, modifieddamage );
    modifieddamage = handleapdamage( objweapon, type, modifieddamage, attacker );
    return modifieddamage;
}

// Namespace damage
// Params 3
// Checksum 0xe916bf0, Offset: 0x1f5b0
// Size: 0x125
function handlemissiledamage( objweapon, meansofdeath, damage )
{
    actualdamage = damage;
    
    switch ( objweapon.basenamehash )
    {
        case %"gunship_105mm_mp":
        case %"gunship_40mm_mp":
        case %"iw8_la_kgolf_mp":
        case %"iw8_la_gromeo_mp":
        case %"iw8_la_juliet_mp":
        case %"gunship_hellfire_mp":
        case %"iw9_la_gromeo_mp":
        case %"iw8_la_gromeoks_mp":
        case %"t10_la_p18_stisaac_mp":
        case %"iw8_la_rpapa7_mp":
        case %"t10_la_p17_pable3_mp":
        case %"iw9_la_juliet_mp":
        case %"bomb_site_mp":
        case %"t10_ks_m202":
            self.largeprojectiledamage = 1;
            actualdamage = self.maxhealth + 1;
            break;
        case %"heli_pilot_turret_mp":
            self.largeprojectiledamage = 0;
            actualdamage *= 2;
            break;
    }
    
    return actualdamage;
}

// Namespace damage
// Params 3
// Checksum 0xc3e8e8c3, Offset: 0x1f6de
// Size: 0xb9
function handlegrenadedamage( objweapon, damagetype, modifieddamage )
{
    if ( isexplosivedamagemod( damagetype ) )
    {
        weaponrootname = getweaponrootstring( objweapon );
        
        switch ( weaponrootname )
        {
            case #"hash_fa1e80f6bd5b8e72":
                modifieddamage *= 3;
                break;
            case #"hash_5d11ac1131cddab1":
            case #"hash_720535feb098085f":
            case #"hash_7c03088193266bc4":
            case #"hash_eeb591a8f50a5869":
                modifieddamage *= 4;
                break;
            default:
                if ( objweapon.isalternate )
                {
                    modifieddamage *= 3;
                }
                
                break;
        }
    }
    
    return modifieddamage;
}

// Namespace damage
// Params 3
// Checksum 0xae9c5be1, Offset: 0x1f7a0
// Size: 0x20
function handleempdamage( objweapon, meansofdeath, damage )
{
    return damage;
}

// Namespace damage
// Params 5
// Checksum 0x30ca1de3, Offset: 0x1f7c9
// Size: 0xcb
function handleapdamage( objweapon, meansofdeath, damage, attacker, victim )
{
    modifier = 1;
    armorpiercingmod = ( level.perkbundles[ "specialty_armorpiercing" ].var_2258a6140e746492 ?? level.armorpiercingmod ) - 1;
    
    if ( isfmjdamage( objweapon, meansofdeath ) )
    {
        if ( !isplayer( victim ) )
        {
            modifier += armorpiercingmod;
        }
    }
    
    var_738e59af660fe997 = armorpiercingmod + 0.5;
    
    if ( function_7e7e4fed88045f3e( meansofdeath, attacker ) )
    {
        modifier += var_738e59af660fe997;
        attacker namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "suppressionRoundHit" );
    }
    
    return int( damage * modifier );
}

// Namespace damage
// Params 4
// Checksum 0xae5d9e7d, Offset: 0x1f89d
// Size: 0x5a
function handleapammodamage( objweapon, smeansofdeath, damage, var_cdd29ad5d1362c2 )
{
    if ( !isfmjdamage( objweapon, smeansofdeath ) )
    {
        return damage;
    }
    
    var_ed940b73132c5294 = 0;
    
    if ( damage / var_cdd29ad5d1362c2 < var_ed940b73132c5294 )
    {
        damage = int( var_cdd29ad5d1362c2 * var_ed940b73132c5294 );
    }
    
    return damage;
}

// Namespace damage
// Params 2
// Checksum 0xa712d86f, Offset: 0x1f900
// Size: 0x2e
function function_ea2af1be925ed0ea( objweapon, damage )
{
    if ( getweaponhasperk( objweapon, "specialty_ammo_uranium" ) )
    {
        return ( damage * 1.25 );
    }
    
    return damage;
}

// Namespace damage
// Params 4
// Checksum 0x4f6ff3c3, Offset: 0x1f937
// Size: 0x58
function function_a8689e5a2448ca1( damage, objweapon, attacker, meansofdeath )
{
    modifier = 1;
    
    if ( function_17032bfefd0f2bff( objweapon, meansofdeath, attacker ) )
    {
        modifier = level.incendiaryammomod;
    }
    
    return int( damage * modifier );
}

// Namespace damage
// Params 3
// Checksum 0x446300fd, Offset: 0x1f998
// Size: 0x4e
function function_8280f3321b0c7d40( damage, objweapon, attacker )
{
    modifier = 1;
    
    if ( function_c9250d055b095b66( objweapon, attacker ) )
    {
        modifier = level.incendiaryammomod;
    }
    
    return int( damage * modifier );
}

// Namespace damage
// Params 3
// Checksum 0x62f819a5, Offset: 0x1f9ef
// Size: 0x61
function handleshotgundamage( objweapon, meansofdeath, damage )
{
    if ( !isdefined( objweapon ) )
    {
        return damage;
    }
    
    if ( objweapon.basenamehash == %"none" )
    {
        return damage;
    }
    
    if ( weaponclass( objweapon ) != "spread" )
    {
        return damage;
    }
    
    return int( min( 150, damage ) );
}

// Namespace damage
// Params 4
// Checksum 0x8b284449, Offset: 0x1fa59
// Size: 0x59
function onkillstreakdamaged( killstreakname, attacker, weapon, damage )
{
    if ( isdefined( attacker ) && isdefined( self.owner ) )
    {
        if ( isplayer( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
}

// Namespace damage
// Params 10
// Checksum 0x2bd2ed6b, Offset: 0x1faba
// Size: 0x5df
function onkillstreakkilled( killstreakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify, additionalparams )
{
    if ( !isplayer( attacker ) )
    {
        return 0;
    }
    
    notifyflag = 0;
    validattacker = undefined;
    var_b845d79c9266c76a = 0;
    
    if ( isdefined( attacker ) && isdefined( self.owner ) )
    {
        if ( isplayer( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
        
        if ( issentient( self.owner ) && issentient( attacker ) )
        {
            if ( !isalliedsentient( self.owner, attacker ) )
            {
                validattacker = attacker;
            }
        }
        else if ( self.owner player_utility::isenemy( attacker ) )
        {
            validattacker = attacker;
        }
    }
    
    if ( isdefined( validattacker ) )
    {
        if ( isdefined( level.var_efaf30b680072745 ) )
        {
            [[ level.var_efaf30b680072745 ]]( killstreakname, self.team, validattacker );
        }
        
        if ( function_7e3cc32b22322954( damagetype, objweapon ) )
        {
            validattacker battlechatter_mp::killstreakdestroyed( killstreakname );
        }
        
        if ( weaponclass( objweapon ) == "rocketlauncher" )
        {
            validattacker gameplay_telemetry::function_3b8d40426c725ea0( "weap_destruction", objweapon.basename, 3 );
        }
        
        if ( isdefined( attacker.perks[ "specialty_streak_sniper" ] ) )
        {
            if ( !isdefined( attacker.perks[ "specialty_killstreak_to_scorestreak" ] ) && !var_b845d79c9266c76a )
            {
                attacker killstreaks::givestreakpoints( #"interceptor_intercepted", 1 );
                attacker thread points::doscoreevent( #"interceptor_intercepted", objweapon );
                var_b845d79c9266c76a = 1;
            }
        }
        
        foreach ( _attacker in self.attackerdata )
        {
            if ( isdefined( _attacker.attackerent.perks[ "specialty_streak_destroy_bonus" ] ) )
            {
                var_e36b9ae0887d6a54 = spawnstruct();
                var_e36b9ae0887d6a54.var_47a7414a3ba1af73 = _attacker.damage;
                var_e36b9ae0887d6a54.streakmaxhealth = int( self.maxhealth );
                _attacker.attackerent callback::callback( "streak_destroy_bonus_points", var_e36b9ae0887d6a54 );
            }
        }
        
        if ( isdefined( attacker.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
        {
            attacker [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( self );
        }
        
        thread events::killedkillstreak( killstreakname, validattacker, objweapon );
        
        if ( additionalparams.inflictor )
        {
            thread challenges::killstreakkilled( self, killstreakname, self.owner, validattacker, damage, damagetype, objweapon, undefined, additionalparams.inflictor );
        }
        else
        {
            thread challenges::killstreakkilled( self, killstreakname, self.owner, validattacker, damage, damagetype, objweapon );
        }
        
        level callback::callback( #"killstreak_destroyed", { #inflictor:additionalparams.inflictor, #objweapon:objweapon, #attacker:validattacker, #killstreakname:killstreakname, #killedkillstreak:self } );
        params = { #weapon:objweapon, #streakname:killstreakname, #player:attacker, #event:#"on_destroyed_killstreak" };
        level callback::callback( #"hash_6c71d319dc089c27", params );
        gestures::processcalloutdeath( self, validattacker );
        notifyflag = 1;
    }
    
    thread events::processscrapassist( validattacker );
    
    if ( isplayer( self.owner ) && !self.streakinfo.superref && !self.streakinfo.issuper )
    {
        self.owner dlog_recordplayerevent( "dlog_event_kill_streak_destroyed", [ "destroyed_kill_streak_name", killstreakname, "attacking_kill_streak_name", killstreak::getkillstreaknamefromweapon( objweapon ) ?? "", "attacking_weapon_name", objweapon.basename ] ?? "" );
        var_d5001050e9e693cb = additionalparams.inflictor.streakinfo;
        
        if ( !var_d5001050e9e693cb && attacker.var_dda5ef0b107c7d42 )
        {
            var_d5001050e9e693cb = attacker.var_dda5ef0b107c7d42[ objweapon.basename ];
        }
        
        if ( var_d5001050e9e693cb )
        {
            killstreak::function_b700fb2ad0fa69e9( self.owner, attacker, var_d5001050e9e693cb );
        }
        
        if ( self.owner )
        {
            self.owner killstreak_utility::function_8b88dd572355be1f( self.streakinfo, self.streakinfo.var_9384480e6997afd7, 1 );
        }
        
        if ( isdefined( leaderdialog ) )
        {
            if ( isdefined( validattacker ) )
            {
                self.owner killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, leaderdialog, #"destroyed" );
            }
        }
    }
    
    if ( !skipdeathnotify )
    {
        self notify( #"death" );
    }
    
    if ( !self.streakinfo.var_bbd40c52f0758e34 )
    {
        if ( isdefined( validattacker ) )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed", 1 );
        }
    }
    
    return notifyflag;
}

// Namespace damage
// Params 2
// Checksum 0xccf4a5bc, Offset: 0x200a2
// Size: 0x60, Type: bool
function function_7e3cc32b22322954( damagetype, objweapon )
{
    return objweapon.damagemodcategory === #"rpg_lockon" || damagetype && ( damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET" || damagetype == "MOD_EXPLOSIVE_BULLET" || damagetype == "MOD_HEAD_SHOT" );
}

// Namespace damage
// Params 3
// Checksum 0x5efabcb2, Offset: 0x2010b
// Size: 0x1a7
function updatedeathdetails( attackerlist, attackerdata, killer )
{
    attackercount = 0;
    
    if ( isplayer( killer ) && isdefined( killer.health ) )
    {
        if ( !killer player::isreallyalive() )
        {
            self setclientomnvar( "ui_death_details_enemy_health", 0 );
        }
        else
        {
            self setclientomnvar( "ui_death_details_enemy_health", int( clamp( killer.health, 0, killer.maxhealth ) ) / killer.maxhealth );
        }
    }
    else
    {
        self setclientomnvar( "ui_death_details_enemy_health", -1 );
    }
    
    if ( isdefined( attackerlist ) && isdefined( attackerdata ) )
    {
        foreach ( guid, attacker in attackerlist )
        {
            if ( !isplayer( attacker ) )
            {
                continue;
            }
            
            attackernumber = attacker getentitynumber();
            self setclientomnvar( "ui_death_details_attacker_" + attackercount, attackernumber );
            self setclientomnvar( "ui_death_details_hits_" + attackercount, int( min( attackerdata[ guid ].hitcount ?? 0, 10 ) ) );
            attackercount++;
            
            if ( attackercount >= 4 )
            {
                break;
            }
        }
    }
    
    for ( clearindex = attackercount; clearindex < 4 ; clearindex++ )
    {
        self setclientomnvar( "ui_death_details_attacker_" + clearindex, -1 );
    }
}

// Namespace damage
// Params 1
// Checksum 0xb54384c4, Offset: 0x202ba
// Size: 0xa4
function setdeathtimerlength( deathdata )
{
    victim = deathdata.victim;
    actualtimeuntilspawn = 0;
    
    if ( victim playerlogic::mayspawn() && !level.disablespawncamera )
    {
        timeuntilspawn = playerlogic::timeuntilspawn( 1 );
        minimumtime = 2.25;
        var_e23f556bab26c016 = 1;
        timeuntilspawn = max( timeuntilspawn + var_e23f556bab26c016, minimumtime );
        actualtimeuntilspawn = timeuntilspawn + deathdata.deathscenetimesec;
    }
    
    victim.death_timer_length = int( actualtimeuntilspawn * 10 );
}

// Namespace damage
// Params 1
// Checksum 0xdaf2cfcd, Offset: 0x20366
// Size: 0x133
function getindexfromhitloc( shitloc )
{
    switch ( shitloc )
    {
        case #"hash_b275b50677dcf6cb":
            return 0;
        case #"hash_fbb61fc356f3c75e":
            return 1;
        case #"hash_8a1772f5f912c880":
            return 2;
        case #"hash_b107b5547c755d23":
            return 3;
        case #"hash_92bbfe494d03d772":
            return 4;
        case #"hash_51d5d0b9add9cc5a":
            return 5;
        case #"hash_a7980c387477e7bb":
            return 6;
        case #"hash_da51cc36a471058":
            return 7;
        case #"hash_d42e71cd9f1e822f":
            return 8;
        case #"hash_5d5aac570f6fd382":
            return 9;
        case #"hash_da2f35145aa58933":
            return 10;
        case #"hash_810a7426c8bac3ac":
            return 11;
        case #"hash_7b36142458a6c2d5":
            return 12;
        case #"hash_168c74e879f0ba11":
            return 13;
        case #"hash_1cbc508a2fe01b79":
            return 14;
        case #"hash_a638fec9040cfcf4":
            return 15;
        case #"hash_9536712388e65bce":
            return 16;
        case #"hash_fb5b5e6c07253005":
            return 17;
        case #"hash_db653a4972b3c13b":
            return 18;
    }
    
    return 0;
}

// Namespace damage
// Params 4
// Checksum 0xa327d54d, Offset: 0x204a2
// Size: 0x171
function updatecombatrecordkillstats( attacker, victim, meansofdeath, objweapon )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    if ( isplayer( attacker ) && attacker != victim && attacker player_utility::isenemy( victim ) )
    {
        if ( isdefined( objweapon ) )
        {
            equipmenttype = weapon::getequipmenttype( objweapon );
            
            if ( equipmenttype == "lethal" )
            {
                equipment = equipment_mp::getequipmentreffromweapon( objweapon );
                
                if ( !isdefined( equipment ) )
                {
                    assertmsg( "<dev string:x5f6>" + weapon::getweaponname( objweapon ) );
                    equipment = "";
                }
                
                if ( equipment == "equip_throwing_knife_fire" || equipment == "equip_throwing_knife_electric" || equipment == "equip_shuriken" || equipment == "equip_mutation_throwstar" )
                {
                    equipment = "equip_throwing_knife";
                }
                
                if ( equipment == "equip_pball" )
                {
                    equipment = "equip_snowball";
                }
                
                attacker combatrecordlethalkill( equipment );
                return;
            }
            
            killstreak = killstreak::getkillstreaknamefromweapon( objweapon );
            
            if ( isdefined( killstreak ) )
            {
                if ( isenumvaluevalid( level.var_6f9b00680ed002d8, "LethalScorestreakStatItems", killstreak ) )
                {
                    attacker combatrecordkillstreakstat( killstreak );
                }
            }
            
            if ( attacker.personalradaractive )
            {
                attacker combatrecordtacticalstat( "power_periphVis" );
            }
            
            if ( attacker.adrenalinepoweractive )
            {
                attacker combatrecordtacticalstat( "equip_adrenaline" );
            }
        }
    }
}

// Namespace damage
// Params 1
// Checksum 0x8e1e94ac, Offset: 0x2061b
// Size: 0x13f
function combatrecordequipmentused( weapon )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    islethal = equipment_mp::isequipmentlethal( weapon );
    
    if ( weapon == "equip_throwing_knife_fire" || weapon == "equip_throwing_knife_electric" || weapon == "equip_shuriken" || weapon == "equip_mutation_throwstar" )
    {
        weapon = "equip_throwing_knife";
    }
    
    if ( weapon == "equip_pball" )
    {
        weapon = "equip_snowball";
    }
    
    if ( islethal )
    {
        oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"lethalstats", weapon, #"uses" );
        self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"lethalstats", weapon, #"uses", oldvalue + 1 );
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"tacticalstats", weapon, #"uses" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"tacticalstats", weapon, #"uses", oldvalue + 1 );
}

// Namespace damage
// Params 1
// Checksum 0xa8475a48, Offset: 0x20762
// Size: 0x7f
function combatrecordlethalkill( weapon )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"lethalstats", weapon, #"kills" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"lethalstats", weapon, #"kills", oldvalue + 1 );
}

// Namespace damage
// Params 2
// Checksum 0x522bfbed, Offset: 0x207e9
// Size: 0x99
function combatrecordtacticalstat( weapon, incrementvalue )
{
    if ( !stats::canrecordcombatrecordstats() || isagent( self ) )
    {
        return;
    }
    
    if ( !isdefined( incrementvalue ) )
    {
        incrementvalue = 1;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"tacticalstats", weapon, #"extrastat1" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", #"tacticalstats", weapon, #"extrastat1", oldvalue + incrementvalue );
}

// Namespace damage
// Params 1
// Checksum 0xbd32a7f2, Offset: 0x2088a
// Size: 0x91
function combatrecordkillstreakstat( streakname )
{
    if ( !stats::canrecordcombatrecordstats() || !isdefined( streakname ) )
    {
        return;
    }
    
    recordtype = stats::getstreakrecordtype( streakname );
    
    if ( !isdefined( recordtype ) )
    {
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"extrastat1" );
    self setplayerdata( level.var_6f9b00680ed002d8, #"playerstats", recordtype, streakname, #"extrastat1", oldvalue + 1 );
}

// Namespace damage
// Params 2
// Checksum 0x1e0bd802, Offset: 0x20923
// Size: 0x71
function enqueuecorpsetablefunc( funcid, func )
{
    if ( !isdefined( self.corpsetablefuncs ) )
    {
        self.corpsetablefuncs = [];
        self.corpsetablefunccounts = [];
    }
    
    if ( !isdefined( self.corpsetablefuncs[ funcid ] ) )
    {
        self.corpsetablefuncs[ funcid ] = func;
        self.corpsetablefunccounts[ funcid ] = 0;
    }
    
    self.corpsetablefunccounts[ funcid ]++;
}

// Namespace damage
// Params 1
// Checksum 0x67e5a443, Offset: 0x2099c
// Size: 0x63
function dequeuecorpsetablefunc( funcid )
{
    if ( !isdefined( self.corpsetablefuncs ) )
    {
        return;
    }
    
    if ( !isdefined( self.corpsetablefuncs[ funcid ] ) )
    {
        return;
    }
    
    self.corpsetablefunccounts[ funcid ]--;
    
    if ( self.corpsetablefunccounts[ funcid ] <= 0 )
    {
        self.corpsetablefuncs[ funcid ] = undefined;
        self.corpsetablefunccounts[ funcid ] = undefined;
    }
}

// Namespace damage
// Params 0
// Checksum 0xfb477d6a, Offset: 0x20a07
// Size: 0xa3
function callcorpsetablefuncs()
{
    if ( !isdefined( self.corpsetablefuncs ) )
    {
        return;
    }
    
    corpsetable = self.body;
    
    foreach ( func in self.corpsetablefuncs )
    {
        self thread [[ func ]]( corpsetable );
    }
    
    thread clearcorpsetablefuncs();
}

// Namespace damage
// Params 0
// Checksum 0x830d8924, Offset: 0x20ab2
// Size: 0x22
function clearcorpsetablefuncs()
{
    self notify( #"hash_7e1da2bc89210385" );
    self.corpsetablefuncs = undefined;
    self.corpsetablefunccounts = undefined;
}

// Namespace damage
// Params 1
// Checksum 0x3672ac66, Offset: 0x20adc
// Size: 0x66
function startcopycatoption( attacker )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_1499dba4b6654b54" );
    
    if ( !isplayer( attacker ) || isbot( self ) )
    {
        return;
    }
    
    while ( self copyloadoutbuttonpressed() )
    {
        waitframe();
    }
    
    while ( !self copyloadoutbuttonpressed() )
    {
        waitframe();
    }
    
    class::copyclassfornextlife( attacker );
}

// Namespace damage
// Params 0
// Checksum 0x3236c563, Offset: 0x20b4a
// Size: 0xe
function stopcopycatoption()
{
    self notify( #"hash_1499dba4b6654b54" );
}

// Namespace damage
// Params 1
// Checksum 0xd10b0c1e, Offset: 0x20b60
// Size: 0x46, Type: bool
function isenvironmentalscriptableinflictor( einflictor )
{
    if ( einflictor.code_classname == "scriptable" )
    {
        switch ( einflictor.classname )
        {
            case #"hash_807fe3702cfc611f":
                return true;
        }
    }
    
    return false;
}

// Namespace damage
// Params 1
// Checksum 0x2728d207, Offset: 0x20baf
// Size: 0x5b, Type: bool
function shouldrecorddamagestats( player )
{
    assert( isplayer( player ), "<dev string:x652>" );
    
    if ( issimulationplayer( player ) )
    {
        return false;
    }
    
    if ( level.disabledamagestattracking )
    {
        return false;
    }
    
    if ( isdefined( level.disabledamagestattrackingfunc ) && ![[ level.disabledamagestattrackingfunc ]]( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 4
// Checksum 0x1e3f8fcc, Offset: 0x20c13
// Size: 0xe4
function logfriendlyfire( player, attacker, damage, method )
{
    if ( !( isdefined( player ) && isdefined( attacker ) && isdefined( method ) ) )
    {
        return;
    }
    
    telemetry_data = { #weaponobj:attacker.currentweapon, #variantid:-1, #statupdates:[ { #value:int( min( damage, player.health ) ), #name:"friendly_fire_damage" } ], #fullweaponname:getcompleteweaponname( attacker.currentweapon ), #weaponname:weapon::getweaponrootname( attacker.currentweapon ) };
    attacker telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
}

// Namespace damage
// Params 5, eflags: 0x4
// Checksum 0xdc9fbdca, Offset: 0x20cff
// Size: 0x42a
function private function_7559275e5e539ebe( eattacker, idamage, smeansofdeath, objweapon, victim )
{
    if ( eattacker.unittype == "zombie" )
    {
        return idamage;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN" || smeansofdeath == "MOD_DOWN" )
    {
        return idamage;
    }
    
    maxdamage = undefined;
    class = weaponclass( objweapon );
    
    switch ( class )
    {
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_fa24dff6bd60a12d":
            maxdamage = eattacker.damagecategory[ "assault" ];
            break;
        case #"hash_900cb96c552c5e8e":
            maxdamage = eattacker.damagecategory[ "smg" ];
            break;
        case #"hash_6191aaef9f922f96":
            maxdamage = eattacker.damagecategory[ "sniper" ];
            break;
        case #"hash_690c0d6a821b42e":
            maxdamage = eattacker.damagecategory[ "shotgun" ];
            break;
        default:
            if ( isexplosivedamagemod( smeansofdeath ) )
            {
                maxdamage = eattacker.damagecategory[ "explosive" ];
            }
            else if ( smeansofdeath == "MOD_MELEE" )
            {
                maxdamage = eattacker.damagecategory[ "melee" ];
            }
            else
            {
                maxdamage = eattacker.damagecategory[ "default" ];
            }
            
            break;
    }
    
    if ( maxdamage == -2 )
    {
        return idamage;
    }
    else if ( maxdamage == -1 )
    {
        switch ( class )
        {
            case #"hash_8cdaf2e4ecfe5b51":
            case #"hash_fa24dff6bd60a12d":
                maxdamage = level.agentmaxdamage_assault;
                break;
            case #"hash_900cb96c552c5e8e":
                maxdamage = level.var_cbad58ee40f08d58;
                break;
            case #"hash_6191aaef9f922f96":
                maxdamage = level.agentmaxdamage_sniper;
                break;
            case #"hash_690c0d6a821b42e":
                maxdamage = level.agentmaxdamage_shotgun;
                break;
            default:
                if ( isexplosivedamagemod( smeansofdeath ) )
                {
                    maxdamage = level.agentmaxdamage_explosive;
                }
                else if ( smeansofdeath == "MOD_MELEE" )
                {
                    maxdamage = level.agentmaxdamage_melee;
                }
                else
                {
                    maxdamage = level.agentmaxdamage;
                }
                
                break;
        }
    }
    
    if ( maxdamage > 0 )
    {
        invehicle = vehicle::is_in_vehicle();
        
        if ( invehicle && isdefined( level.var_973576b7b9b719fa ) && level.var_973576b7b9b719fa != -1 )
        {
            maxdamage = int( maxdamage * level.var_973576b7b9b719fa );
        }
    }
    
    if ( maxdamage < idamage )
    {
        idamage = maxdamage;
    }
    
    if ( eattacker aiissniper( 1 ) && !eattacker.var_c6eeb14b93b8a344 )
    {
        if ( victim armor::hasarmor() )
        {
            if ( idamage > victim.armorhealth )
            {
                bleedthrough = idamage - victim.armorhealth;
                var_df6d6d0b2c095634 = bleedthrough / victim.health;
                var_656cd7a3b15ae241 = bleedthrough * var_df6d6d0b2c095634;
                idamage = victim.armorhealth + var_656cd7a3b15ae241;
                var_f8775da620933572 = victim.armorhealth + victim.health - randomintrange( 5, 20 );
                idamage = min( idamage, var_f8775da620933572 );
                
                if ( victim.armorhealth + victim.health - idamage < 100 )
                {
                    victim.var_fee17f18f8d4ba66 = gettime();
                }
                
                return idamage;
            }
        }
        else
        {
            if ( !isdefined( victim.var_fee17f18f8d4ba66 ) )
            {
                victim.var_fee17f18f8d4ba66 = 0;
            }
            
            if ( gettime() - victim.var_fee17f18f8d4ba66 < 20000 )
            {
                victim.var_fee17f18f8d4ba66 = gettime();
                return idamage;
            }
            
            var_1bdc8a10c00a42a0 = victim.health - 20;
            idamage = min( idamage, var_1bdc8a10c00a42a0 );
            
            if ( idamage <= 0 )
            {
                idamage = 1;
            }
            
            victim.var_fee17f18f8d4ba66 = gettime();
        }
    }
    
    return idamage;
}

// Namespace damage
// Params 4
// Checksum 0x1b24b6d6, Offset: 0x21132
// Size: 0x61, Type: bool
function issuicide( einflictor, attacker, smeansofdeath, objweapon )
{
    if ( attacker == self )
    {
        return true;
    }
    
    if ( isdefined( smeansofdeath ) && ( smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE" ) )
    {
        return true;
    }
    
    if ( entity::isdronepackage( einflictor ) )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0xca05096e, Offset: 0x2119c
// Size: 0x60, Type: bool
function isteamkill( einflictor, attacker )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( !isplayer( attacker ) && !isdefined( attacker.team ) )
    {
        return false;
    }
    
    if ( self.team != attacker.team )
    {
        return false;
    }
    
    if ( self == attacker )
    {
        return false;
    }
    
    return true;
}

// Namespace damage
// Params 2
// Checksum 0x9be7600b, Offset: 0x21205
// Size: 0xba
function function_e3c4fc450ca6942a( objweapon, smeansofdeath )
{
    if ( !isdefined( objweapon ) )
    {
        return 0;
    }
    
    if ( !isdefined( objweapon.basenamehash ) )
    {
        return 0;
    }
    
    exploitweapon = 0;
    
    switch ( objweapon.basenamehash )
    {
        case %"airdrop_escort_turret_ballistics_mp":
        case %"airdrop_escort_turret_ballistics_champion":
        case %"chopper_gunner_turret_ballistics_dmz":
        case %"chopper_gunner_turret_ballistics_mp":
        case %"hover_jet_turret_ballistics_mp":
            exploitweapon = 1;
            break;
        default:
            if ( isdefined( smeansofdeath ) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
            {
                exploitweapon = 1;
            }
            
            break;
    }
    
    return exploitweapon;
}

// Namespace damage
// Params 1
// Checksum 0x447d395f, Offset: 0x212c8
// Size: 0x5b, Type: bool
function function_e03b776948c43ba8( weaponname )
{
    weaponobj = utility::function_64003742d8f5c781( weaponname );
    
    switch ( weaponobj.basenamehash )
    {
        case %"iw9_sh_vecho_mp":
        case %"iw9_sh_tsierra12_mp":
        case %"iw9_pi_swhiskey_mp":
            return true;
    }
    
    return false;
}

// Namespace damage
// Params 2
// Checksum 0xff563838, Offset: 0x2132c
// Size: 0x56
function function_2499f72abb86f810( victim, reason )
{
    if ( getdvarint( @"hash_a658b504ac40c111", 1 ) == 1 )
    {
        logprint( "[DamageEarlyOut] Victim Client " + victim getentitynumber() + " '" + victim.name + "' - Reason: " + reason );
    }
}

// Namespace damage
// Params 2
// Checksum 0xe1bde98e, Offset: 0x2138a
// Size: 0x69
function function_5eecf23a1765bbb2( attacker, type )
{
    if ( !isdefined( self.attackerdata ) )
    {
        return;
    }
    
    victimsattackerdata = arraycopy( self.attackerdata );
    
    if ( self function_5c766d1d0140b86( "ui_combat_report_num_attackers" ) )
    {
        thread function_75c3aa3ddc27b870( victimsattackerdata, attacker.guid, self.team, type );
    }
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0x44740150, Offset: 0x213fb
// Size: 0x81
function private function_51ebfccfaa7d8210()
{
    if ( !isdefined( level.gametypebundle.var_b5d99a6493ceb9ce ) )
    {
        level.gametypebundle.var_b5d99a6493ceb9ce = #"nowait";
    }
    
    switch ( level.gametypebundle.var_b5d99a6493ceb9ce )
    {
        case #"nowait":
            return;
        case #"slowprocessing":
        default:
            script::waittillslowprocessallowed( 1, 1 );
            return;
    }
}

// Namespace damage
// Params 4, eflags: 0x4
// Checksum 0xf5baaa08, Offset: 0x21484
// Size: 0x3e
function private function_ba76132ce52e8db3( omnvar, value, bitoffset, bitwidth )
{
    if ( self function_5c766d1d0140b86( omnvar ) )
    {
        omnvar_utility::function_8b206c75cb7ad548( omnvar, bitoffset, bitwidth, value );
    }
}

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0x61b446e, Offset: 0x214ca
// Size: 0x48, Type: bool
function private function_fefba0611d1ea168( attackerdata )
{
    if ( attackerdata.attackerent && isagent( attackerdata.attackerent ) && level.gametypebundle.var_4c074f106f89eeff )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 4, eflags: 0x4
// Checksum 0xf84fdb22, Offset: 0x2151b
// Size: 0x88c
function private function_75c3aa3ddc27b870( victimsattackerdata, attackerguid, victimteam, type )
{
    self endon( #"disconnect" );
    function_51ebfccfaa7d8210();
    displaydata = [];
    
    if ( victimsattackerdata[ attackerguid ] && !function_fefba0611d1ea168( victimsattackerdata[ attackerguid ] ) )
    {
        if ( !isdefined( self.attackerdata[ attackerguid ] ) )
        {
            return;
        }
        
        if ( type == 0 )
        {
            victimsattackerdata[ attackerguid ].killedby = 1;
        }
        else if ( type == 1 )
        {
            victimsattackerdata[ attackerguid ].downedby = 1;
        }
        
        displaydata[ 0 ] = victimsattackerdata[ attackerguid ];
    }
    
    currenttime = gettime();
    elapsedtime = 0;
    ignoremaxtime = function_4d6bc0e8404c6e6c();
    var_b690943302effd50 = getdvarint( @"hash_10925a6ddd9190c1", 0 ) == 0;
    
    while ( true )
    {
        var_896df4e15b31b291 = undefined;
        var_16108e5c9f1a7958 = undefined;
        
        foreach ( guid, attackerdata in victimsattackerdata )
        {
            if ( arraycontains( displaydata, attackerdata ) )
            {
                continue;
            }
            
            if ( var_b690943302effd50 && attackerdata.var_3fd757d47a3afc0d )
            {
                continue;
            }
            
            if ( attackerdata.lasttimedamaged )
            {
                elapsedtime = attackerdata.lasttimedamaged - currenttime;
                
                if ( abs( elapsedtime ) > ignoremaxtime )
                {
                    continue;
                }
            }
            
            if ( isstring( self.guid ) && isstring( guid ) && self.guid == guid )
            {
                continue;
            }
            
            if ( function_fefba0611d1ea168( attackerdata ) )
            {
                continue;
            }
            
            if ( !isdefined( var_16108e5c9f1a7958 ) || var_16108e5c9f1a7958 > elapsedtime )
            {
                var_896df4e15b31b291 = attackerdata;
                var_16108e5c9f1a7958 = elapsedtime;
            }
        }
        
        if ( isdefined( var_896df4e15b31b291 ) )
        {
            displaydata[ displaydata.size ] = var_896df4e15b31b291;
            continue;
        }
        
        break;
    }
    
    for ( index = 0; index < 6 ; index++ )
    {
        if ( index < displaydata.size )
        {
            data = displaydata[ index ];
            lootid = weapon::getweaponlootid( data.objweapon );
            
            if ( lootid == 0 )
            {
                equipref = equipment_mp::getequipmentreffromweapon( data.objweapon );
                
                if ( isdefined( equipref ) )
                {
                    lootid = loot::getlootidfromref( equipref );
                }
                else if ( weapon::iskillstreakweapon( data.objweapon ) )
                {
                    killstreakname = killstreak::getkillstreaknamefromweapon( data.objweapon );
                    lootid = loot::getlootidfromref( killstreakname );
                }
                else if ( weapon::issuperweapon( data.objweapon ) )
                {
                    supername = supers_mp::getsuperrefforsuperweapon( data.objweapon );
                    lootid = loot::getlootidfromref( supername );
                }
                else if ( isdefined( data.objweapon.basename ) )
                {
                    lootid = loot::getlootidfromref( data.objweapon.basename );
                }
            }
            
            attackerent = data.attackerent ?? undefined;
            lootid = int( clamp( lootid ?? 0, 0, 2147483647 ) );
            multiweapon = isdefined( data.damagesources ) && data.damagesources.size > 1;
            damage = int( data.effectivedamage ?? 0 );
            hitcount = int( data.hitcount ?? 0 );
            downedby = istrue( data.downedby );
            killedby = istrue( data.killedby );
            friendly = attackerent ? player_utility::isfriendly( victimteam, attackerent ) ?? 0 : 0;
            var_f3734f16a3fc2423 = clamp( int( data.var_f3734f16a3fc2423 ?? 0 ), 0, 255 );
            var_1deaa0b1c11f2092 = clamp( int( data.var_1deaa0b1c11f2092 ?? 0 ) + var_f3734f16a3fc2423, 0, 255 );
            var_d1e937b2d94a7d6c = clamp( int( data.var_d1e937b2d94a7d6c ?? 0 ) + var_f3734f16a3fc2423, 0, 255 );
            hitlocslower = clamp( int( data.hitlocslower ?? 0 ) + var_f3734f16a3fc2423, 0, 255 );
            var_974b5409ab1fb70d = clamp( int( data.var_974b5409ab1fb70d ?? 0 ) + var_f3734f16a3fc2423, 0, 255 );
            damagetypeoverride = 0;
            
            if ( isdefined( data.var_22b37ea8a43d69a2 ) )
            {
                switch ( data.var_22b37ea8a43d69a2 )
                {
                    case #"hash_b15027ffbdc0ecb":
                        damagetypeoverride = 1;
                        break;
                    case #"hash_c6ee58aac2278b70":
                    case #"hash_f91d639d29feb858":
                        damagetypeoverride = 2;
                        break;
                    case #"hash_e4fbf0b31ced1661":
                        damagetypeoverride = 3;
                        break;
                    case #"hash_91d0b5d30ea06560":
                        damagetypeoverride = 4;
                        break;
                    case #"hash_daa7ba4e87e42b9":
                        damagetypeoverride = 5;
                        break;
                    case #"hash_abb1587cdc6def23":
                        damagetypeoverride = 6;
                        break;
                    case #"hash_1b5395c651f95456":
                    case #"hash_a5123f4d02745600":
                        damagetypeoverride = 7;
                        break;
                    case #"hash_61e42661ac27b9f2":
                        damagetypeoverride = 8;
                        break;
                    case #"hash_24cf9a6ca3404493":
                        damagetypeoverride = 9;
                        break;
                    default:
                        damagetypeoverride = 10;
                        
                        if ( isdefined( data.smeansofdeath ) && data.smeansofdeath == "MOD_SUICIDE" )
                        {
                            damagetypeoverride = 9;
                            
                            if ( multiweapon && data.damagesources[ "MOD_CRUSH" ] )
                            {
                                damagetypeoverride = 6;
                            }
                            
                            if ( level.projectbundle.var_68c894f5d919aa16 && data.var_22b37ea8a43d69a2 == level.projectbundle.var_68c894f5d919aa16 )
                            {
                                damagetypeoverride = 11;
                            }
                        }
                        
                        break;
                }
            }
            
            self setclientomnvar( "ui_combat_report_attacker_" + index, attackerent );
            self setclientomnvar( "ui_combat_report_weapon_lootid_" + index, lootid );
            self setclientomnvar( "ui_combat_report_multi_weapon_" + index, multiweapon );
            self setclientomnvar( "ui_combat_report_friendly_" + index, friendly );
            self setclientomnvar( "ui_combat_report_damage_type_override_" + index, damagetypeoverride );
            self setclientomnvar( "ui_combat_report_damage_" + index, damage, 1023 );
            self setclientomnvar( "ui_combat_report_hits_" + index, hitcount, 255 );
            self setclientomnvar( "ui_combat_report_downedby_" + index, downedby );
            self setclientomnvar( "ui_combat_report_killedby_" + index, killedby );
            function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, var_1deaa0b1c11f2092, 0, 8 );
            function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, var_d1e937b2d94a7d6c, 8, 8 );
            function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, hitlocslower, 16, 8 );
            function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, var_974b5409ab1fb70d, 24, 8 );
            continue;
        }
        
        self setclientomnvar( "ui_combat_report_attacker_" + index, undefined );
        self setclientomnvar( "ui_combat_report_weapon_lootid_" + index, 0 );
        self setclientomnvar( "ui_combat_report_multi_weapon_" + index, 0 );
        self setclientomnvar( "ui_combat_report_friendly_" + index, 0 );
        self setclientomnvar( "ui_combat_report_damage_type_override_" + index, 0 );
        self setclientomnvar( "ui_combat_report_damage_" + index, 0 );
        self setclientomnvar( "ui_combat_report_hits_" + index, 0 );
        self setclientomnvar( "ui_combat_report_downedby_" + index, 0 );
        self setclientomnvar( "ui_combat_report_killedby_" + index, 0 );
        function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, 0, 0, 8 );
        function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, 0, 8, 8 );
        function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, 0, 16, 8 );
        function_ba76132ce52e8db3( "ui_combat_report_hit_locs_" + index, 0, 24, 8 );
    }
    
    numattackers = displaydata.size ?? 0;
    numattackers = int( clamp( numattackers, 0, 6 ) );
    self setclientomnvar( "ui_combat_report_num_attackers", numattackers );
    
    if ( level.var_20582ffa76d6281e && type == 1 )
    {
        wait 5;
        self setclientomnvar( "ui_combat_report_num_attackers", 0 );
    }
}

// Namespace damage
// Params 1
// Checksum 0x37d69996, Offset: 0x21daf
// Size: 0xc9
function function_45da7ca374194f4b( victim )
{
    victim endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( victim.bulletDamageMeleeSlowMod ) )
    {
        return;
    }
    else
    {
        victim.bulletDamageMeleeSlowMod = -0.1;
        
        if ( !victim common::function_8ff835bf23198a0( "bulletDamageMeleeSlowMod" ) )
        {
            victim common::function_ac4bf3256b2545e3( "bulletDamageMeleeSlowMod", -0.1 );
            victim common::function_11a0a06c67c80f4d( "bulletDamageMeleeSlowMod", 2 );
        }
    }
    
    victim weapons::updatemovespeedscale();
    utility::waittill_any_timeout( 0.7, "death" );
    victim.bulletDamageMeleeSlowMod = undefined;
    
    if ( victim common::function_8ff835bf23198a0( "bulletDamageMeleeSlowMod" ) )
    {
        victim common::function_d85a92c557ea5a52( "bulletDamageMeleeSlowMod" );
    }
    
    victim weapons::updatemovespeedscale();
}

// Namespace damage
// Params 2
// Checksum 0x2dc13ad8, Offset: 0x21e80
// Size: 0xbd, Type: bool
function shouldmeleeslow( vdir, victim )
{
    if ( !getdvarint( @"scr_bullet_damage_melee_slow", 1 ) )
    {
        return false;
    }
    
    if ( isdefined( victim.perks[ "specialty_dauntless" ] ) )
    {
        return false;
    }
    
    if ( victim isswimming() )
    {
        return false;
    }
    
    currentweapon = victim.currentweapon;
    
    if ( !weapon::ismeleeonly( currentweapon ) || weapon::isclimbweaponobject( currentweapon ) )
    {
        return false;
    }
    
    if ( vectordot( vdir, anglestoforward( victim.angles ) ) < 0 && distance2dsquared( self.origin, victim.origin ) < 562500 )
    {
        return true;
    }
    
    return false;
}

// Namespace damage
// Params 1
// Checksum 0xa23392d9, Offset: 0x21f46
// Size: 0x4f
function register_scripted_damage_override_func( func_damage_override )
{
    assert( isdefined( func_damage_override ), "<dev string:x691>" );
    
    if ( !isdefined( level.scripted_damage_override ) )
    {
        level.scripted_damage_override = [];
    }
    
    level.scripted_damage_override = arraycombineunique( level.scripted_damage_override, [ func_damage_override ] );
}

// Namespace damage
// Params 1
// Checksum 0x39869c9a, Offset: 0x21f9d
// Size: 0x36
function function_d8877aa55ec6518b( func )
{
    if ( !isarray( level.scripted_damage_override ) )
    {
        return;
    }
    
    level.scripted_damage_override = arrayremove( level.scripted_damage_override, func );
}

// Namespace damage
// Params 1
// Checksum 0xeff9642d, Offset: 0x21fdb
// Size: 0x3f
function function_231589aee53ae064( var_f5b397df8fd97c2b )
{
    assert( isdefined( var_f5b397df8fd97c2b ), "<dev string:x6e9>" );
    assert( !isdefined( level.var_d4edfe6f6b2f654b ), "<dev string:x743>" );
    level.var_d4edfe6f6b2f654b = var_f5b397df8fd97c2b;
}

// Namespace damage
// Params 1
// Checksum 0xb21ba4ed, Offset: 0x22022
// Size: 0x25
function function_d1c0bcd44206c27f( func )
{
    if ( !isdefined( level.var_d4edfe6f6b2f654b ) )
    {
        return;
    }
    
    level.var_d4edfe6f6b2f654b = undefined;
}

/#

    // Namespace damage
    // Params 1
    // Checksum 0x2737345f, Offset: 0x2204f
    // Size: 0x178, Type: dev
    function function_ce51453a1aabf1be( deathdata )
    {
        deathdata.var_90c30295130f075a = [];
        deathdata.var_90c30295130f075a[ "<dev string:x7b2>" ] = deathdata.attacker;
        deathdata.var_90c30295130f075a[ "<dev string:x7bb>" ] = deathdata.victim;
        deathdata.var_90c30295130f075a[ "<dev string:x7c2>" ] = deathdata.damage;
        deathdata.var_90c30295130f075a[ "<dev string:x7c9>" ] = deathdata.objweapon;
        deathdata.var_90c30295130f075a[ "<dev string:x7d3>" ] = deathdata.meansofdeath;
        deathdata.var_90c30295130f075a[ "<dev string:x7e0>" ] = deathdata.inflictor;
        deathdata.var_90c30295130f075a[ "<dev string:x7ea>" ] = deathdata.direction_vec;
        deathdata.var_90c30295130f075a[ "<dev string:x7f8>" ] = deathdata.damageflags;
        deathdata.var_90c30295130f075a[ "<dev string:x804>" ] = deathdata.hitloc;
        deathdata.var_90c30295130f075a[ "<dev string:x80b>" ] = deathdata.psoffsettime;
        deathdata.var_90c30295130f075a[ "<dev string:x818>" ] = deathdata.deathanimduration;
        deathdata.var_90c30295130f075a[ "<dev string:x82a>" ] = deathdata.isfauxdeath;
    }

    // Namespace damage
    // Params 1
    // Checksum 0xcdb2f943, Offset: 0x221cf
    // Size: 0x253, Type: dev
    function function_b042fa22e449387d( deathdata )
    {
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7b2>" ] === deathdata.attacker, "<dev string:x836>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7bb>" ] === deathdata.victim, "<dev string:x885>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7c2>" ] === deathdata.damage, "<dev string:x8d2>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7c9>" ] === deathdata.objweapon, "<dev string:x91f>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7d3>" ] === deathdata.meansofdeath, "<dev string:x96f>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7e0>" ] === deathdata.inflictor || !( isdefined( deathdata.var_90c30295130f075a[ "<dev string:x7e0>" ] ) && isdefined( deathdata.inflictor ) ), "<dev string:x9c2>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7ea>" ] === deathdata.direction_vec || !( isdefined( deathdata.var_90c30295130f075a[ "<dev string:x7ea>" ] ) && isdefined( deathdata.direction_vec ) ), "<dev string:xa12>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x7f8>" ] === deathdata.damageflags, "<dev string:xa66>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x804>" ] === deathdata.hitloc, "<dev string:xab8>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x80b>" ] === deathdata.psoffsettime, "<dev string:xb05>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x818>" ] === deathdata.deathanimduration, "<dev string:xb58>" );
        assert( deathdata.var_90c30295130f075a[ "<dev string:x82a>" ] === deathdata.isfauxdeath, "<dev string:xbb0>" );
    }

    // Namespace damage
    // Params 4
    // Checksum 0xef5cbac9, Offset: 0x2242a
    // Size: 0xfb, Type: dev
    function function_13044ae0f56c133b( attacker, recentdamage, smeansofdeath, objweapon )
    {
        self endon( #"disconnect" );
        
        if ( !isdefined( self.var_dd3844dacf3215dd ) )
        {
            self.var_dd3844dacf3215dd = recentdamage;
        }
        else
        {
            self.var_dd3844dacf3215dd += recentdamage;
        }
        
        self notify( #"recent_damage_debug" );
        self endon( #"recent_damage_debug" );
        
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
        
        utility::waittill_any_timeout( 2, "<dev string:x328>" );
        var_fbdfe496d22f2b2b = self.var_dd3844dacf3215dd;
        self.var_dd3844dacf3215dd = undefined;
        
        if ( !( isdefined( objweapon ) && isdefined( attacker ) ) )
        {
            return;
        }
        
        iprintlnbold( "<dev string:xc02>" + var_fbdfe496d22f2b2b + "<dev string:xc11>" + smeansofdeath + "<dev string:xc20>" + weapon::getweaponname( objweapon ) );
    }

#/

// Namespace damage
// Params 1, eflags: 0x4
// Checksum 0xf56af37a, Offset: 0x2252d
// Size: 0x188
function private function_402ee208d206742e( smeansofdeath )
{
    if ( isdefined( level.gamemodebundle.var_feb4b2aad25fbaf3 ) && soundexists( level.gamemodebundle.var_feb4b2aad25fbaf3 ) )
    {
        var_7ddcfdce656a50d1 = level.gamemodebundle.var_feb4b2aad25fbaf3;
    }
    
    if ( isdefined( var_7ddcfdce656a50d1 ) )
    {
        if ( isdefined( level.gamemodebundle.var_9d44880cfd22ca3c ) && soundexists( level.gamemodebundle.var_9d44880cfd22ca3c ) )
        {
            function_4009348bd72e9021( level.gamemodebundle.var_9d44880cfd22ca3c, self );
        }
        
        if ( smeansofdeath != "MOD_EXECUTION" && ( smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_SUICIDE" ) )
        {
            if ( soundexists( var_7ddcfdce656a50d1 + "_quiet" ) )
            {
                quietalias = var_7ddcfdce656a50d1 + "_quiet";
                playworldsound( self.origin, quietalias, self );
            }
            else
            {
                playworldsound( self.origin, var_7ddcfdce656a50d1, self );
            }
        }
        else if ( smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN" )
        {
            playworldsound( self.origin, var_7ddcfdce656a50d1, self );
        }
        
        if ( isdefined( self.heartbeatalias ) )
        {
            self stoplocalsound( self.heartbeatalias );
        }
        
        if ( isdmzgamemode() )
        {
            self playlocalsound( "deaths_door_heartrate_flatline" );
        }
    }
}

// Namespace damage
// Params 0, eflags: 0x4
// Checksum 0x3bc04dda, Offset: 0x226bd
// Size: 0x94, Type: bool
function private function_88d9cecc7b6f844a()
{
    if ( !level.var_8ece63698f074a2b )
    {
        level.var_8ece63698f074a2b = [];
    }
    
    if ( !level.gametypebundle.var_51a1a1690b8c47a )
    {
        return false;
    }
    
    elementlist = getscriptbundle( level.gametypebundle.var_51a1a1690b8c47a ).list;
    
    for ( i = 0; i < elementlist.size ; i++ )
    {
        level.var_8ece63698f074a2b[ elementlist[ i ].type ] = i;
    }
    
    return true;
}

// Namespace damage
// Params 1
// Checksum 0x236d1c14, Offset: 0x2275a
// Size: 0x63
function function_6bebdb697b69b555( type )
{
    if ( !isdefined( type ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_8ece63698f074a2b ) )
    {
        if ( !function_88d9cecc7b6f844a() )
        {
            return 0;
        }
    }
    
    if ( isstring( type ) )
    {
        type = getxhash( type );
    }
    
    id = level.var_8ece63698f074a2b[ type ];
    
    if ( !isdefined( id ) )
    {
        return 0;
    }
    
    return id;
}

// Namespace damage
// Params 1
// Checksum 0x94004137, Offset: 0x227c6
// Size: 0x100
function function_c9cd6450ceee53ef( deathdata )
{
    if ( self.laststandattacker && !level.gamemodebundle.var_9a2648e733e507e7 )
    {
        attacker = self.laststandattacker;
        inflictor = self.laststandinflictor ?? self.var_24c4c756a0d798dd;
        objweapon = self.var_a54cf862f580156;
        meansofdeath = self.laststandmeansofdeath;
        iskillstreakweapon = self.var_8f849ee66df5a544;
    }
    else
    {
        attacker = deathdata.attacker;
        inflictor = deathdata.inflictor;
        objweapon = deathdata.objweapon;
        meansofdeath = deathdata.meansofdeath;
        iskillstreakweapon = deathdata.iskillstreakweapon;
    }
    
    return [ attacker, inflictor, objweapon, meansofdeath, iskillstreakweapon ];
}

