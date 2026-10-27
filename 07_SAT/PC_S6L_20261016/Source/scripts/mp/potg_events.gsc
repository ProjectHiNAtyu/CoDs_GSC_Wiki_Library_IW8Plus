// scripts\mp\potg_events.gsc  (hash_22085d5a2d267f34.gscc) (size: 13667 Bytes / 0x3563 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5bc098f (96209295)
// size ...... 13667 (0x3563)
// includes .. 8   (offset: 0x312f)
// strings ... 75  (offset: 0x316f)
// dev strs .. 7   (offset: 0x350f)
// exports ... 49  (offset: 0x2227)
// cseg ...... 0x646 + 0x1be1 (0x2227)
// imports ... 55  (offset: 0x29cf)
// animtree1 . 0   (offset: 0x3563)
// animtree2 . 0   (offset: 0x3563)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\potg;

#namespace potg_events;

// Namespace potg_events
// Params 0
// Checksum 0xe34d36b0, Offset: 0x664
// Size: 0x9c
function init()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    level.potgglobals.eventdata = spawnstruct();
    globals = level.potgglobals.eventdata;
    globals.lastkillearner = undefined;
    globals.lastkilltime = undefined;
    
    if ( level.teambased )
    {
        globals.lastteamkillearners = [];
        globals.lastteamkilltimes = [];
    }
    
    function_769162adb8b44831();
    
    /#
        setdevdvarifuninitialized( @"hash_c6cd6bf543f12f2e", 0 );
    #/
}

// Namespace potg_events
// Params 0
// Checksum 0x27ee595, Offset: 0x708
// Size: 0x17
function function_769162adb8b44831()
{
    callback::add( #"stance_changed", &function_fce88589ea382a4e );
}

// Namespace potg_events
// Params 0
// Checksum 0x4056c5f6, Offset: 0x727
// Size: 0x2
function function_580c8afef4c35991()
{
    
}

// Namespace potg_events
// Params 0
// Checksum 0x4195048f, Offset: 0x731
// Size: 0x9
function onpotgrecordingstopped()
{
    clearshotgroup();
}

// Namespace potg_events
// Params 0
// Checksum 0x2fa4f510, Offset: 0x742
// Size: 0x48
function getentityeventdata()
{
    potgdata = potg::getentitypotgdata( self );
    
    if ( !isdefined( potgdata ) )
    {
        return;
    }
    
    if ( !isdefined( potgdata.trackingdata ) )
    {
        potgdata.trackingdata = createentityeventdata();
    }
    
    return potgdata.trackingdata;
}

// Namespace potg_events
// Params 0, eflags: 0x4
// Checksum 0xec771f6c, Offset: 0x793
// Size: 0x3f
function private createentityeventdata()
{
    return { #shotgrouplastaccuracy:0, #shotgrouplastcount:0, #shotgroupaccuracy:0, #shotgroupcount:0, #var_9540fbd0a1ff9537:0, #shotgroupactive:0 };
}

// Namespace potg_events
// Params 1
// Checksum 0xd0268d39, Offset: 0x7db
// Size: 0x15
function onroundended( winner )
{
    handlefinalkill( winner );
}

// Namespace potg_events
// Params 1
// Checksum 0xeb2c11f9, Offset: 0x7f8
// Size: 0x149
function multikill( killcount )
{
    assert( killcount > 1 );
    profilestart();
    award = undefined;
    
    switch ( killcount )
    {
        case 2:
            award = #"double";
            break;
        case 3:
            award = #"triple";
            break;
        case 4:
            award = #"four";
            break;
        case 5:
            award = #"five";
            break;
        case 6:
            award = #"six";
            break;
        case 7:
            award = #"seven";
            break;
        case 8:
            if ( !level.scoreeventglobals.var_824e7a3005f228e9 )
            {
                award = #"eight";
                break;
            }
        default:
            award = #"multi";
            break;
    }
    
    profilestop();
    eventinfo = spawnstruct();
    eventinfo.ismultikill = 1;
    waitframe();
    potg::processevent( award, gettime(), undefined, undefined, undefined, undefined, eventinfo );
}

// Namespace potg_events
// Params 1
// Checksum 0x501051a, Offset: 0x949
// Size: 0xdd
function handlefinalkill( winner )
{
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    globals = level.potgglobals.eventdata;
    lastkiller = undefined;
    lastkilltime = undefined;
    
    if ( level.teambased )
    {
        if ( isdefined( globals.lastteamkillearners[ winner ] ) )
        {
            lastkiller = globals.lastteamkillearners[ winner ];
            lastkilltime = globals.lastteamkilltimes[ winner ];
        }
        else
        {
            lastkiller = globals.lastkillearner;
            lastkilltime = globals.lastkilltime;
        }
    }
    else
    {
        lastkiller = globals.lastkillearner;
        lastkilltime = globals.lastkilltime;
    }
    
    if ( isdefined( lastkiller ) && isdefined( lastkilltime ) )
    {
        lastkiller potg::processevent( "final_kill", lastkilltime );
    }
}

// Namespace potg_events
// Params 3
// Checksum 0xaf95b80e, Offset: 0xa2e
// Size: 0x5f
function onplayerdamaged( attacker, victim, meansofdeath )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( utility::getdamagetype( meansofdeath ) == #"splash" && !victim.var_c19506b543ae5021 )
    {
        victim potg::processevent( "hit_by_explosive" );
    }
}

// Namespace potg_events
// Params 6
// Checksum 0xd88b1419, Offset: 0xa95
// Size: 0x560
function onplayerkilled( attacker, inflictor, victim, meansofdeath, objweapon, psoffsettime )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    globals = level.potgglobals.eventdata;
    curtime = gettime();
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    attackereventdata = attacker getentityeventdata();
    victimeventdata = victim getentityeventdata();
    scoremultiplier = attacker calckillmultiplier( attacker );
    equipmentkill = meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE";
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1 );
    castresult = physics_raycast( attacker geteye(), victim geteye(), contents, undefined, 0, "physicsquery_closest", 1 );
    var_36c964031367ba32 = castresult.size > 0;
    onscreen = utility::within_fov( attacker geteye(), attacker getplayerangles(), victim.origin, cos( 80 ) );
    javelinkill = objweapon.basename == "iw8_la_juliet_mp";
    var_b66e9ceaff73f409 = ( javelinkill || equipmentkill ) && ( !onscreen || var_36c964031367ba32 );
    
    if ( !var_b66e9ceaff73f409 )
    {
        attacker potg::processevent( "kill", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    if ( isdefined( self.prevlastkilltime ) && isdefined( attacker.lastspawntime ) )
    {
        if ( attacker.lastspawntime < self.prevlastkilltime )
        {
            timesincelastkill = curtime - self.prevlastkilltime;
            
            if ( timesincelastkill < 1800 )
            {
                var_131d18b5d9290081 = 1 - timesincelastkill / 1800;
                attacker potg::processevent( "kill_rate_bonus", self.prevlastkilltime, curtime, psoffsettime, undefined, var_131d18b5d9290081, undefined, objweapon, meansofdeath );
            }
        }
    }
    
    attacker handlekillmodifiers( attacker, meansofdeath, objweapon, victim, scoremultiplier, psoffsettime );
    
    if ( meansofdeath == "MOD_PROJECTILE_SPLASH" && !javelinkill )
    {
        attacker potg::processevent( "missile_splash_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    if ( utility::getdamagetype( meansofdeath ) == #"splash" )
    {
        if ( game_utility::gettimepassed() <= 12000 && randomintrange( 0, 2 ) == 0 )
        {
            attacker potg::processevent( "round_start_grenade", undefined, undefined, undefined, undefined, undefined, undefined, objweapon, meansofdeath );
        }
    }
    
    if ( attacker.modifiers[ "bullet_damage" ] && victim molotov::molotov_is_burning() )
    {
        attacker potg::processevent( "victim_on_fire", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    if ( attacker molotov::molotov_is_burning() )
    {
        attacker potg::processevent( "kill_while_on_fire", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    if ( attacker.modifiers[ "airborne" ] )
    {
        attackereventdata.lastinairkilltime = curtime;
        attackereventdata.inairsincelastkill = 1;
        attacker thread watchforpostkilllanding();
    }
    
    if ( isdefined( attacker.lastdooropentime ) && curtime - attacker.lastdooropentime < 3500 )
    {
        attacker potg::processevent( "open_door_before_kill", attacker.lastdooropentime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    if ( attacker.attackerdata.size > 3 )
    {
        attacker potg::processevent( "outnumbered", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    if ( isdefined( victimeventdata.lastteabagtime ) && curtime - victimeventdata.lastteabagtime < 1000 && randomintrange( 0, 2 ) == 0 )
    {
        attacker potg::processevent( "kill_teabagger", victimeventdata.lastteabagtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
    }
    
    attacker handleequipmentkills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier );
    attacker handlemeleekills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier, psoffsettime );
    
    if ( attackereventdata.shotgroupactive )
    {
        if ( attackereventdata.shotgroupaccuracy >= 0.9 )
        {
            attacker potg::processevent( "accuracy_good", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
        }
        else if ( attackereventdata.shotgroupaccuracy <= 0.075 )
        {
            attacker potg::processevent( "accuracy_very_bad", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
        }
        else if ( attackereventdata.shotgroupaccuracy <= 0.15 )
        {
            attacker potg::processevent( "accuracy_bad", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
        }
    }
    
    if ( level.teambased )
    {
        globals.lastteamkillearners[ attacker.team ] = attacker;
        globals.lastteamkilltimes[ attacker.team ] = curtime;
    }
    
    globals.lastkillearner = attacker;
    globals.lastkilltime = curtime;
}

// Namespace potg_events
// Params 1
// Checksum 0x22387870, Offset: 0xffd
// Size: 0x5a
function calckillmultiplier( attacker )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return 1;
    }
    
    scoremultiplier = 1;
    
    if ( !attacker.modifiers[ "victim_in_standard_view" ] )
    {
        scoremultiplier *= 0.15;
    }
    
    return scoremultiplier;
}

// Namespace potg_events
// Params 7
// Checksum 0x795f11b4, Offset: 0x1060
// Size: 0xb5
function handlemeleekills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier, psoffsettime )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_MELEE" )
    {
        if ( isdefined( attacker.lastspawntime ) )
        {
            var_6ee492702a0e37c3 = attacker.lastshotfiredtime >= attacker.lastspawntime;
            
            if ( !var_6ee492702a0e37c3 )
            {
                attacker potg::processevent( "no_shots_fired_kill", undefined, undefined, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
            }
        }
    }
}

// Namespace potg_events
// Params 6
// Checksum 0x72cf1ac8, Offset: 0x111d
// Size: 0x14e
function handleequipmentkills( attacker, inflictor, victim, meansofdeath, objweapon, scoremultiplier )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( isdefined( inflictor ) && inflictor.isequipment )
    {
        isthrowingknife = weapon::isthrowingknife( objweapon );
        
        if ( isdefined( inflictor.spawnpos ) )
        {
            throwdistsq = distancesquared( inflictor.spawnpos, inflictor.origin );
            
            if ( isthrowingknife )
            {
                if ( throwdistsq >= 640000 )
                {
                    attacker potg::processevent( "long_throwing_knife", undefined, undefined, undefined, undefined, undefined, undefined, objweapon, meansofdeath );
                }
                else
                {
                    attacker potg::processevent( "throwing_knife", undefined, undefined, undefined, undefined, undefined, undefined, objweapon, meansofdeath );
                }
            }
            else if ( throwdistsq >= 1440000 )
            {
                attacker potg::processevent( "long_grenade_throw", undefined, undefined, undefined, undefined, undefined, undefined, objweapon, meansofdeath );
            }
        }
        
        if ( game_utility::gettimepassed() <= 12000 )
        {
            if ( isthrowingknife && level.mapname != "mp_shipment" )
            {
                attacker potg::processevent( "round_start_throwing_knife", undefined, undefined, undefined, undefined, undefined, undefined, objweapon, meansofdeath );
            }
        }
    }
}

// Namespace potg_events
// Params 6
// Checksum 0x2ecc77f4, Offset: 0x1273
// Size: 0x300
function handlekillmodifiers( attacker, meansofdeath, objweapon, victim, scoremultiplier, psoffsettime )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    curtime = gettime();
    weapongroup = weapon::getweapongroup( objweapon );
    
    foreach ( modifier, _unused in attacker.modifiers )
    {
        switch ( modifier )
        {
            case #"hash_b2bbe57b24a8077a":
                if ( meansofdeath == "MOD_MELEE" )
                {
                    attacker potg::processevent( "backstab", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
            case #"hash_e1ae7daca67ccc55":
                if ( weapongroup == "weapon_sniper" )
                {
                    attacker potg::processevent( "pointblank_sniper", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                else
                {
                    attacker potg::processevent( "pointblank", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
            case #"hash_13f87da5f89d7b77":
                if ( isdefined( attacker.modifiers[ "ads" ] ) )
                {
                    if ( weapongroup == "weapon_sniper" )
                    {
                        attacker potg::processevent( "airborne_ads_sniper_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                    }
                    else
                    {
                        attacker potg::processevent( "airborne_ads_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                    }
                }
                
                break;
            case #"hash_487822d5f9b7daac":
                if ( weapongroup == "weapon_sniper" )
                {
                    attacker potg::processevent( "victim_airborne_sniper", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                else
                {
                    attacker potg::processevent( "victim_airborne", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
            case #"hash_bbddd8225d923d3":
                if ( !isdefined( attacker.modifiers[ "very_longshot" ] ) )
                {
                    attacker potg::processevent( "longshot", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
            case #"hash_74f930d98b6f9343":
                if ( weapongroup != "weapon_sniper" && weapongroup != "weapon_projectile" )
                {
                    attacker potg::processevent( "last_bullet_kill", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
            case #"hash_ef0e526485141da2":
                if ( weapongroup == "weapon_sniper" )
                {
                    attacker potg::processevent( "victim_sprinting_sniper", curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
            default:
                if ( potg::eventtable_isevent( modifier ) )
                {
                    attacker potg::processevent( modifier, curtime, curtime, psoffsettime, undefined, scoremultiplier, undefined, objweapon, meansofdeath );
                }
                
                break;
        }
    }
}

// Namespace potg_events
// Params 2
// Checksum 0xebb8178f, Offset: 0x157b
// Size: 0x7a
function collateral( attacker, numkills )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( numkills == 2 )
    {
        attacker potg::processevent( "collateral" );
        return;
    }
    
    if ( numkills == 3 )
    {
        attacker potg::processevent( "triple_collateral" );
        return;
    }
    
    attacker potg::processevent( "multi_collateral" );
}

// Namespace potg_events
// Params 2
// Checksum 0x126c5c86, Offset: 0x15fd
// Size: 0x61
function shotguncollateral( attacker, numkills )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( numkills == 2 )
    {
        attacker potg::processevent( "shotgun_collateral" );
        return;
    }
    
    attacker potg::processevent( "shotgun_multi_collateral" );
}

// Namespace potg_events
// Params 3
// Checksum 0xc098cae7, Offset: 0x1666
// Size: 0x54
function quadfeed( player, starttime, endtime )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    player potg::processevent( "quad_feed", starttime, endtime );
}

// Namespace potg_events
// Params 5
// Checksum 0xb0d3a905, Offset: 0x16c2
// Size: 0x117
function processeventforwitnesses( eventpoint, maxdistsq, eventref, starttime, endtime )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    witnessplayers = utility::playersnear( eventpoint, 1000 );
    
    foreach ( player in witnessplayers )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        var_e36b2a45308d2a5e = eventpoint - player geteye();
        playerforward = anglestoforward( player getplayerangles() );
        
        if ( vectordot( var_e36b2a45308d2a5e, playerforward ) < 0 )
        {
            continue;
        }
        
        player potg::processevent( eventref, starttime, endtime );
    }
}

// Namespace potg_events
// Params 0
// Checksum 0xdb381352, Offset: 0x17e1
// Size: 0x64
function watchforpostkilllanding()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    eventdata = getentityeventdata();
    
    while ( true )
    {
        if ( self isonground() )
        {
            eventdata.inairsincelastkill = 0;
            break;
        }
        
        waitframe();
    }
}

// Namespace potg_events
// Params 1
// Checksum 0x2f83a99b, Offset: 0x184d
// Size: 0x44
function predatormissileimpact( impactpos )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    processeventforwitnesses( impactpos, 1000000, "witness_predator_impact" );
}

// Namespace potg_events
// Params 1
// Checksum 0xd2a98e6f, Offset: 0x1899
// Size: 0x44
function largevehicleexplosion( explosionpos )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    processeventforwitnesses( explosionpos, 640000, "witness_vehicle_explode" );
}

// Namespace potg_events
// Params 1
// Checksum 0xa627500f, Offset: 0x18e5
// Size: 0x5c
function vehiclekilled( damagedata )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( !isplayer( damagedata.attacker ) )
    {
        return;
    }
    
    damagedata.attacker potg::processevent( "vehicle_destroyed" );
}

// Namespace potg_events
// Params 1
// Checksum 0x703907f4, Offset: 0x1949
// Size: 0x3f
function missilewhizby( player )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    player potg::processevent( "witness_missile_whizby" );
}

// Namespace potg_events
// Params 3
// Checksum 0x6f1c62e9, Offset: 0x1990
// Size: 0x7d
function bombdefused( defuser, waslastalive, enemiesnearby )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( enemiesnearby )
    {
        defuser potg::processevent( "ninja_defuse" );
        return;
    }
    
    if ( waslastalive )
    {
        defuser potg::processevent( "last_alive_defuse" );
        return;
    }
    
    defuser potg::processevent( "defuse" );
}

// Namespace potg_events
// Params 2
// Checksum 0x5b1be5c3, Offset: 0x1a15
// Size: 0x48
function revivedplayer( reviver, revivee )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    reviver potg::processevent( "revived_ally" );
}

// Namespace potg_events
// Params 2
// Checksum 0xb5ceeeaa, Offset: 0x1a65
// Size: 0x77
function playerworlddeath( attacker, meansofdeath )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    
    if ( eventdata.inairsincelastkill )
    {
        attacker potg::processevent( "fall_to_death_kill", eventdata.lastinairkilltime, gettime() );
    }
}

// Namespace potg_events
// Params 2
// Checksum 0xf09775a, Offset: 0x1ae4
// Size: 0x76
function doorused( player, opening )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( !opening && isdefined( player.lastkilltime ) && gettime() - player.lastkilltime < 2000 )
    {
        player potg::processevent( "closed_door_after_kill" );
    }
}

// Namespace potg_events
// Params 1, eflags: 0x4
// Checksum 0x44e632c8, Offset: 0x1b62
// Size: 0x148
function private function_fce88589ea382a4e( params )
{
    if ( !params.isalive )
    {
        return;
    }
    
    switch ( params.stance )
    {
        case #"stand":
            return;
        case #"crouch":
            potg::processevent( "recent_crouch" );
            
            if ( isdefined( self.lastkillvictimpos ) )
            {
                if ( distancesquared( self.lastkillvictimpos, self.origin ) < 40000 )
                {
                    timesincelastcrouch = params.time - self.var_84f7f2ffadd85173[ #"crouch" ];
                    
                    if ( timesincelastcrouch < 750 )
                    {
                        eventdata = getentityeventdata();
                        
                        if ( isdefined( eventdata ) )
                        {
                            var_8721aade97eccb48 = isdefined( self.lastspawntime ) && isdefined( eventdata.lastteabagtime ) && self.lastspawntime < eventdata.lastteabagtime;
                            
                            if ( !var_8721aade97eccb48 )
                            {
                                potg::processevent( "teabag" );
                            }
                            
                            eventdata.lastteabagtime = params.time;
                        }
                    }
                }
            }
            
            return;
        case #"prone":
            potg::processevent( "recent_prone" );
            return;
    }
}

// Namespace potg_events
// Params 0
// Checksum 0x783ffe62, Offset: 0x1cb2
// Size: 0x9
function shothit()
{
    function_e81d1e106dcd3cc6();
}

// Namespace potg_events
// Params 0, eflags: 0x4
// Checksum 0x74cc6d4a, Offset: 0x1cc3
// Size: 0x66
function private function_e81d1e106dcd3cc6()
{
    eventdata = getentityeventdata();
    
    if ( isdefined( eventdata ) )
    {
        eventdata.var_9540fbd0a1ff9537++;
        eventdata.shotgroupcount++;
        eventdata.shotgroupaccuracy = eventdata.var_9540fbd0a1ff9537 / eventdata.shotgroupcount;
        thread shotgroupendwatcher();
        
        /#
            thread function_3db3807fa99ab1f4();
        #/
    }
}

// Namespace potg_events
// Params 2
// Checksum 0x6f73c535, Offset: 0x1d31
// Size: 0x2d
function shotmissed( totalshots, hitshots )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    function_4f508765c03a5ebd( totalshots, hitshots );
}

// Namespace potg_events
// Params 2, eflags: 0x4
// Checksum 0x292081a2, Offset: 0x1d66
// Size: 0x7a
function private function_4f508765c03a5ebd( totalshots, hitshots )
{
    eventdata = getentityeventdata();
    eventdata.shotgroupcount += totalshots ?? 1;
    eventdata.shotgroupaccuracy = eventdata.var_9540fbd0a1ff9537 / eventdata.shotgroupcount;
    thread shotgroupendwatcher();
    
    /#
        thread function_3db3807fa99ab1f4();
    #/
}

// Namespace potg_events
// Params 0, eflags: 0xc
// Checksum 0xadc76d9e, Offset: 0x1de8
// Size: 0x5f
function private shotgroupendwatcher()
{
    self notify( #"hash_3a5ddcf0dd91e60c" );
    self endon( #"hash_3a5ddcf0dd91e60c" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    eventdata = getentityeventdata();
    eventdata.shotgroupactive = 1;
    wait 2;
    clearshotgroup();
}

// Namespace potg_events
// Params 0
// Checksum 0x742f8097, Offset: 0x1e4f
// Size: 0x84
function clearshotgroup()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    eventdata = getentityeventdata();
    eventdata.shotgroupactive = 0;
    eventdata.shotgrouplastcount = eventdata.shotgroupcount;
    eventdata.shotgrouplastaccuracy = eventdata.shotgroupaccuracy;
    eventdata.var_9540fbd0a1ff9537 = 0;
    eventdata.shotgroupcount = 0;
    eventdata.shotgroupaccuracy = 0;
}

// Namespace potg_events
// Params 1
// Checksum 0xc90be366, Offset: 0x1edb
// Size: 0x3a
function grenadethrownevent( islethal )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( islethal )
    {
        potg::processevent( "recent_lethal" );
        return;
    }
    
    potg::processevent( "recent_tactical" );
}

// Namespace potg_events
// Params 0
// Checksum 0xed5ead93, Offset: 0x1f1d
// Size: 0x1c
function crouch()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "recent_crouch" );
}

// Namespace potg_events
// Params 0
// Checksum 0x79b08257, Offset: 0x1f41
// Size: 0x1c
function jump()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "recent_jump" );
}

// Namespace potg_events
// Params 0
// Checksum 0xf6d06802, Offset: 0x1f65
// Size: 0x1c
function prone()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "recent_prone" );
}

// Namespace potg_events
// Params 0
// Checksum 0xf6d06802, Offset: 0x1f89
// Size: 0x1c
function slide()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "recent_slide" );
}

// Namespace potg_events
// Params 0
// Checksum 0xed5ead93, Offset: 0x1fad
// Size: 0x1c
function mantle()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "recent_mantle" );
}

// Namespace potg_events
// Params 0
// Checksum 0x96f3e2c7, Offset: 0x1fd1
// Size: 0x1c
function prop_plain_sight()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "mode_prop_plain_sight" );
}

// Namespace potg_events
// Params 0
// Checksum 0x9694f555, Offset: 0x1ff5
// Size: 0x1c
function prop_plain_sight_further()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "mode_prop_plain_sight_further" );
}

// Namespace potg_events
// Params 0
// Checksum 0x2463f199, Offset: 0x2019
// Size: 0x1c
function prop_damaged()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "mode_prop_damaged" );
}

// Namespace potg_events
// Params 0
// Checksum 0x8a5154c6, Offset: 0x203d
// Size: 0x1c
function function_71e3534224b6a56a()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "mode_prop_survived" );
}

// Namespace potg_events
// Params 0
// Checksum 0x96f3e2c7, Offset: 0x2061
// Size: 0x1c
function prop_hunter_elim()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "mode_prop_hunter_elim" );
}

// Namespace potg_events
// Params 1
// Checksum 0xd1ada9a3, Offset: 0x2085
// Size: 0x28
function prop_last_survivor( eventstarttime )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg::processevent( "mode_prop_last_survivor", eventstarttime );
}

/#

    // Namespace potg_events
    // Params 0
    // Checksum 0xa4e9e146, Offset: 0x20b5
    // Size: 0x172, Type: dev
    function function_3db3807fa99ab1f4()
    {
        if ( getdvarint( @"hash_c6cd6bf543f12f2e", 0 ) == 0 )
        {
            return;
        }
        
        if ( isai( self ) )
        {
            return;
        }
        
        level endon( #"game_ended" );
        eventdata = getentityeventdata();
        
        if ( eventdata.var_5a5862a440a94f7d )
        {
            return;
        }
        
        eventdata.var_5a5862a440a94f7d = 1;
        
        while ( true )
        {
            printtoscreen2d( 100, 400, "<dev string:x24>", ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 420, eventdata.shotgroupactive ? "<dev string:x35>" : "<dev string:x3c>", ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 440, "<dev string:x40>" + eventdata.shotgroupaccuracy, ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 460, "<dev string:x4b>" + eventdata.shotgroupcount, ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 480, "<dev string:x53>" + eventdata.shotgrouplastaccuracy, ( 1, 0.5, 0.7 ), 1.5 );
            printtoscreen2d( 100, 500, "<dev string:x63>" + eventdata.shotgrouplastcount, ( 1, 0.5, 0.7 ), 1.5 );
            waitframe();
        }
    }

#/
