// scripts\mp\br\gametypes\br_lootchopper.gsc  (hash_46881a911642c15b.gscc) (size: 17167 Bytes / 0x430f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xebd161c4 (3956367812)
// size ...... 17167 (0x430f)
// includes .. 25  (offset: 0x3dc3)
// strings ... 83  (offset: 0x3e8b)
// dev strs .. 6   (offset: 0x42bf)
// exports ... 27  (offset: 0x2a13)
// cseg ...... 0x66e + 0x23a5 (0x2a13)
// imports ... 125 (offset: 0x2e4b)
// animtree1 . 0   (offset: 0x430f)
// animtree2 . 0   (offset: 0x430f)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;

#namespace br_lootchopper;

// Namespace br_lootchopper
// Params 0
// Checksum 0xee5502b7, Offset: 0x68c
// Size: 0x1c8
function init()
{
    level.averagealliesz = 0;
    level.loot_choppers = [];
    
    if ( game_utility::getgametype() != "plunder" )
    {
        utility::registersharedfunc( #"br_lootchopper", #"lootchopper_oncrateuse", &lootchopper_oncrateuse );
    }
    
    level.quadgridcenterpoints = [];
    level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( -21299.2, 41779.2, 0 );
    level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 37683.2, 41779.2, 0 );
    level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 37683.2, -17203.2, 0 );
    level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( -21299.2, -17203.2, 0 );
    level thread registerleveldataforvehicle();
    
    /#
        setdevdvarifuninitialized( @"hash_6e1432e14f4ba139", 0 );
        setdevdvarifuninitialized( @"hash_1853d73ee1c86fd4", 0 );
        setdevdvarifuninitialized( @"hash_d043ee66392f7b83", 6 );
        setdevdvarifuninitialized( @"hash_117db97fcbbffbb8", 4500 );
        setdevdvarifuninitialized( @"hash_6ab65ba1a8931841", 9999 );
        setdevdvarifuninitialized( @"hash_5db4b9205b63bbd3", 0 );
        setdevdvarifuninitialized( @"hash_880c7f3811901ea1", 1500 );
        setdevdvarifuninitialized( @"hash_ad78da1d72e62dd3", 4000 );
        setdevdvarifuninitialized( @"hash_38568daa586b1fe3", 6000 );
        setdevdvarifuninitialized( @"hash_31c380c6ba1eab38", 360 );
        setdevdvarifuninitialized( @"hash_31e696c6ba452352", 480 );
        setdevdvarifuninitialized( @"hash_c027db5b75ded4aa", 100000 );
        setdevdvarifuninitialized( @"hash_7daf22bb16ed19fe", 50000 );
        setdevdvarifuninitialized( @"hash_6b87854981a58552", 3 );
    #/
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x4c3993db, Offset: 0x85c
// Size: 0x39
function registerleveldataforvehicle()
{
    while ( !isdefined( level.vehicle ) )
    {
        waitframe();
    }
    
    leveldataforvehicle = vehicle::function_1572cbe3d2550638( "loot_chopper" );
    leveldataforvehicle.canfly = 1;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0x8cfabab3, Offset: 0x89d
// Size: 0x2be
function lootchopper_initspawninfo( circleinfo )
{
    var_fb0569ce276a3617 = lootchopper_getspawnlocations( circleinfo );
    level.loot_chopper_spawns = [];
    level.loot_chopper_spawns[ "quad_1" ] = [];
    level.loot_chopper_spawns[ "quad_2" ] = [];
    level.loot_chopper_spawns[ "quad_3" ] = [];
    level.loot_chopper_spawns[ "quad_4" ] = [];
    
    if ( !isdefined( var_fb0569ce276a3617 ) )
    {
        return;
    }
    
    foreach ( spawnzone in var_fb0569ce276a3617 )
    {
        closestdist = undefined;
        closestquad = undefined;
        var_b97f8633ff369aab = undefined;
        
        if ( circleinfo.isvalid )
        {
            foreach ( quadindex, quad in circleinfo.quadpoints )
            {
                var_c823da9323f5b40e = distance2dsquared( spawnzone.origin, quad );
                
                if ( !isdefined( closestdist ) || var_c823da9323f5b40e < closestdist )
                {
                    closestdist = var_c823da9323f5b40e;
                    closestquad = quad;
                    var_b97f8633ff369aab = "quad_" + quadindex + 1;
                }
            }
        }
        else
        {
            foreach ( quadindex, quad in level.quadgridcenterpoints )
            {
                var_c823da9323f5b40e = distance2dsquared( spawnzone.origin, quad );
                
                if ( !isdefined( closestdist ) || var_c823da9323f5b40e < closestdist )
                {
                    closestdist = var_c823da9323f5b40e;
                    closestquad = quad;
                    var_b97f8633ff369aab = "quad_" + quadindex + 1;
                }
            }
        }
        
        spawnzone.origin *= ( 1, 1, 0 );
        spawnzone.origin = br::getoffsetspawnoriginmultitrace( spawnzone.origin, ( 0, 0, 10000 ) );
        level.loot_chopper_spawns[ var_b97f8633ff369aab ][ level.loot_chopper_spawns[ var_b97f8633ff369aab ].size ] = spawnzone;
    }
}

// Namespace br_lootchopper
// Params 1
// Checksum 0xbc7c7e68, Offset: 0xb63
// Size: 0xfb
function lootchopper_getspawnlocations( circleinfo )
{
    spawnlocationarray = [];
    
    foreach ( location in level.br_prematchspawnlocations )
    {
        if ( circleinfo.isvalid )
        {
            if ( distance2dsquared( location.origin, circleinfo.center ) > circleinfo.radius * circleinfo.radius )
            {
                continue;
            }
        }
        
        newlocation = spawnstruct();
        newlocation.origin = location.origin;
        spawnlocationarray[ spawnlocationarray.size ] = newlocation;
    }
    
    return spawnlocationarray;
}

// Namespace br_lootchopper
// Params 2
// Checksum 0x4f7ba7da, Offset: 0xc67
// Size: 0x12f
function lootchopper_initcircleinfo( circlecenter, circleradius )
{
    circleinfo = spawnstruct();
    circleinfo.isvalid = isdefined( circlecenter ) && isdefined( circleradius );
    
    if ( circleinfo.isvalid )
    {
        circleinfo.center = circlecenter;
        circleinfo.radius = circleradius;
        circleangle = 45;
        cosangle = cos( circleangle );
        sinangle = sin( circleangle );
        circleinfo.quadpoints[ 0 ] = circlecenter + ( -1 * cosangle, sinangle, 0 ) * circleradius * 0.5;
        circleinfo.quadpoints[ 1 ] = circlecenter + ( cosangle, sinangle, 0 ) * circleradius * 0.5;
        circleinfo.quadpoints[ 2 ] = circlecenter + ( cosangle, -1 * sinangle, 0 ) * circleradius * 0.5;
        circleinfo.quadpoints[ 3 ] = circlecenter + ( -1 * cosangle, -1 * sinangle, 0 ) * circleradius * 0.5;
    }
    
    return circleinfo;
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x10f9f2f7, Offset: 0xd9f
// Size: 0x261
function lootchopper_managespawns()
{
    level endon( #"game_ended" );
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    circlecenter = undefined;
    circleradius = undefined;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        circlecenter = br_circle::getsafecircleorigin();
        circleradius = br_circle::getsafecircleradius();
    }
    
    circleinfo = lootchopper_initcircleinfo( circlecenter, circleradius );
    lootchopper_initspawninfo( circleinfo );
    
    /#
        level thread function_44e8d6ffaedea50e();
    #/
    
    utility::flag_wait( "br_prematchEnded" );
    var_f1d00cd815ca4c10 = getdvarint( @"hash_d043ee66392f7b83", 6 );
    var_59edf18dbb75c022 = getdvarint( @"hash_38568daa586b1fe3", 6000 );
    mincooldowntime = getdvarint( @"hash_31c380c6ba1eab38", 360 );
    maxcooldowntime = getdvarint( @"hash_31e696c6ba452352", 480 );
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        var_59edf18dbb75c022 = 1000;
    }
    
    while ( true )
    {
        lootchopperactive = getdvarint( @"hash_1853d73ee1c86fd4", 0 );
        
        if ( !lootchopperactive )
        {
            waitframe();
            continue;
        }
        
        spawninterval = randomintrange( mincooldowntime, maxcooldowntime );
        
        if ( level.usemilestonephases )
        {
            flags::gameflagwait( "activate_cash_helis" );
        }
        else
        {
            wait spawninterval;
        }
        
        if ( level.loot_choppers.size < var_f1d00cd815ca4c10 )
        {
            var_ab61a64147b2131d = var_f1d00cd815ca4c10 - level.loot_choppers.size;
            
            for ( i = 0; i < var_ab61a64147b2131d ; i++ )
            {
                quadid = i + 1;
                
                if ( quadid > 4 )
                {
                    quadid = 1;
                }
                
                patrolzone = lootchopper_findunoccupiedpatrolzone( level.loot_chopper_spawns[ "quad_" + quadid ], var_59edf18dbb75c022 );
                
                if ( !isdefined( patrolzone ) )
                {
                    /#
                        iprintlnbold( "<dev string:x24>" + quadid + "<dev string:x69>" );
                    #/
                    
                    wait 1;
                }
                
                if ( i == 0 )
                {
                    hud_util::showsplashtoall( "br_lootchopper_incoming" );
                }
                
                lootchopper_spawn( patrolzone );
                
                if ( level.usemilestonephases )
                {
                    wait randomintrange( 1, 2 );
                }
            }
            
            if ( level.usemilestonephases )
            {
                return;
            }
            
            continue;
        }
        
        while ( level.loot_choppers.size >= var_f1d00cd815ca4c10 )
        {
            waitframe();
        }
    }
}

/#

    // Namespace br_lootchopper
    // Params 0
    // Checksum 0x4a2cff04, Offset: 0x1008
    // Size: 0xee, Type: dev
    function function_44e8d6ffaedea50e()
    {
        level endon( #"game_ended" );
        quadid = 0;
        
        while ( true )
        {
            testspawn = getdvarint( @"hash_6e1432e14f4ba139", 0 );
            
            if ( !testspawn )
            {
                waitframe();
                continue;
            }
            
            var_59edf18dbb75c022 = getdvarint( @"hash_38568daa586b1fe3", 6000 );
            
            if ( level.mapname == "<dev string:xb1>" )
            {
                var_59edf18dbb75c022 = 1000;
            }
            
            quadid++;
            
            if ( quadid > 4 )
            {
                quadid = 1;
            }
            
            patrolzone = lootchopper_findunoccupiedpatrolzone( level.loot_chopper_spawns[ "<dev string:xc1>" + quadid ], var_59edf18dbb75c022 );
            
            if ( !isdefined( patrolzone ) )
            {
                iprintlnbold( "<dev string:x24>" + quadid + "<dev string:x69>" );
                wait 1;
            }
            
            hud_util::showsplashtoall( "<dev string:xc7>" );
            lootchopper_spawn( patrolzone );
            setdvar( @"hash_6e1432e14f4ba139", 0 );
            waitframe();
        }
    }

#/

// Namespace br_lootchopper
// Params 2
// Checksum 0x57f8f7ee, Offset: 0x10fe
// Size: 0xec
function lootchopper_findunoccupiedpatrolzone( availablespawns, var_ddbd0f933904e1de )
{
    patrolzone = undefined;
    
    if ( availablespawns.size > 0 )
    {
        validspawns = [];
        
        foreach ( potentialspawn in availablespawns )
        {
            if ( potentialspawn.chopperoccupied )
            {
                continue;
            }
            
            if ( lootchopper_isnearbyoccupiedspawns( potentialspawn, var_ddbd0f933904e1de ) )
            {
                continue;
            }
            
            validspawns[ validspawns.size ] = potentialspawn;
        }
        
        if ( validspawns.size > 0 )
        {
            patrolzone = validspawns[ randomint( validspawns.size ) ];
        }
        
        if ( isdefined( patrolzone ) )
        {
            patrolzone.chopperoccupied = 1;
        }
    }
    
    return patrolzone;
}

// Namespace br_lootchopper
// Params 2
// Checksum 0x72dbb5f3, Offset: 0x11f3
// Size: 0x156
function lootchopper_isnearbyoccupiedspawns( potentialspawn, var_ddbd0f933904e1de )
{
    var_7be936099716bb30 = 0;
    allspawns = level.loot_chopper_spawns;
    mindistsq = var_ddbd0f933904e1de * var_ddbd0f933904e1de;
    
    if ( isdefined( allspawns ) )
    {
        foreach ( quadrantspawns in allspawns )
        {
            foreach ( var_fa9a170be3d9ccab in quadrantspawns )
            {
                if ( var_fa9a170be3d9ccab.chopperoccupied )
                {
                    if ( distance2dsquared( potentialspawn.origin, var_fa9a170be3d9ccab.origin ) < mindistsq )
                    {
                        var_7be936099716bb30 = 1;
                        break;
                    }
                }
            }
            
            if ( var_7be936099716bb30 )
            {
                break;
            }
        }
    }
    
    return var_7be936099716bb30;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0xb1e905a3, Offset: 0x1352
// Size: 0xa5
function lootchopper_getzonebyindex( index )
{
    zonebyindex = undefined;
    zonecount = 0;
    
    foreach ( zone in level.loot_chopper_spawns )
    {
        if ( zonecount == index )
        {
            zonebyindex = zone;
            break;
        }
        
        zonecount++;
    }
    
    return zonebyindex;
}

// Namespace br_lootchopper
// Params 2
// Checksum 0x7ba89230, Offset: 0x1400
// Size: 0x959
function lootchopper_spawn( patrolzone, overwriteparameters )
{
    patrollocation = undefined;
    patrolradius = getdvarint( @"hash_ad78da1d72e62dd3", 4000 );
    
    if ( isdefined( patrolzone ) )
    {
        patrollocation = patrolzone.origin;
    }
    else
    {
        playersalive = [];
        
        foreach ( player in level.players )
        {
            if ( player::isreallyalive( player ) )
            {
                playersalive[ playersalive.size ] = player;
            }
        }
        
        if ( playersalive.size > 0 )
        {
            randomindex = randomint( playersalive.size );
            patrollocation = playersalive[ randomindex ].origin;
        }
        
        if ( isdefined( patrollocation ) )
        {
            patrollocation = br::getoffsetspawnoriginmultitrace( patrollocation, ( 0, 0, 10000 ) );
        }
    }
    
    if ( !isdefined( patrollocation ) )
    {
        /#
            iprintlnbold( "<dev string:xdf>" );
        #/
        
        return;
    }
    
    startingposition = overwriteparameters.startingposition.origin ?? chopper_support::getpathstart( patrollocation );
    startingangles = vectortoangles( patrollocation - startingposition );
    
    if ( getdvarint( @"hash_f3aec952abe1e494", 1 ) )
    {
        var_e19d3f45bafc368f = br_public::function_5d8b60a1b01b8249();
        var_f44fffd98bdd7c02 = var_e19d3f45bafc368f + 10000;
        
        if ( startingposition[ 2 ] < var_f44fffd98bdd7c02 )
        {
            startingposition = ( startingposition[ 0 ], startingposition[ 1 ], var_f44fffd98bdd7c02 );
        }
    }
    
    spawnvehicletype = overwriteparameters.vehicletype ?? "veh_chopper_support_dmz_mp";
    choppermodel = "veh8_mil_air_palfa_east";
    
    if ( level.var_b4c8dcabb0437344 )
    {
        choppermodel = "veh9_mil_air_heli_hind";
    }
    
    if ( isdefined( overwriteparameters.model ) )
    {
        choppermodel = overwriteparameters.model;
    }
    
    chopper = vehicle_tracking::spawn_helicopter( level.players[ randomint( level.players.size ) ], startingposition, startingangles, spawnvehicletype, choppermodel );
    
    if ( !isdefined( chopper ) )
    {
        logstring( "br_lootchopper::lootChopper_spawn - chopper failed to spawn!" );
        return;
    }
    
    chopper.speed = overwriteparameters.speed ?? 100;
    chopper.accel = overwriteparameters.accel ?? 50;
    chopper.lifetime = overwriteparameters.lifetime ?? getdvarint( @"hash_6ab65ba1a8931841", 9999 );
    chopper.team = "neutral";
    chopper.angles = startingangles;
    chopper.flaresreservecount = getdvarint( @"hash_5db4b9205b63bbd3", 0 );
    chopper.pathstart = startingposition;
    chopper.var_a76a87f8b57cf448 = overwriteparameters.endposition ?? undefined;
    chopper.pathgoal = patrollocation;
    chopper.currentaction = "patrol";
    chopper.currenttarget = undefined;
    chopper.heightoffset = ( 0, 0, getdvarint( @"hash_880c7f3811901ea1", 1500 ) );
    chopper.patrolzone = patrolzone;
    chopper.patrollocation = patrollocation;
    chopper.patrolradius = patrolradius;
    chopper.stage3accradius = 35;
    chopper.crashoffset = chopper.heightoffset[ 2 ] - 250;
    chopper.var_63ccbd180a0cb0e5 = overwriteparameters.var_63ccbd180a0cb0e5;
    chopper.clustercooldown = overwriteparameters.clustercooldown;
    chopper setmaxpitchroll( 15, 15 );
    chopper vehicle_setspeed( chopper.speed, chopper.accel );
    chopper sethoverparams( 50, 5, 2.5 );
    chopper setturningability( 0.5 );
    chopper setyawspeed( 100, 25, 25, 0.1 );
    chopper setcandamage( 1 );
    chopper setneargoalnotifydist( 768 );
    chopper setvehicleteam( chopper.team );
    chopper.health = getdvarint( @"hash_117db97fcbbffbb8", 4500 );
    chopper.maxhealth = getdvarint( @"hash_117db97fcbbffbb8", 4500 );
    chopper.currenthealth = getdvarint( @"hash_117db97fcbbffbb8", 4500 );
    chopper sentientpoolmanager::registersentient( "Level_Vehicle", chopper.team );
    chopper lootchopper_setupdamagefunctionality();
    chopper setscriptablepartstate( "blinking_lights", "on", 0 );
    chopper setscriptablepartstate( "engine", "on", 0 );
    turretmodel = "veh9_mil_air_heli_ahotel64_turret";
    linktag = "tag_turret_front";
    
    if ( level.var_b4c8dcabb0437344 )
    {
        turretmodel = "veh9_mil_air_heli_hind_turret";
        linktag = "tag_turret";
    }
    
    weaponname = overwriteparameters.weapon ?? "chopper_support_turret_br";
    chopper.frontturret = spawnturret( "misc_turret", chopper gettagorigin( linktag ), weaponname );
    chopper.frontturret setmodel( turretmodel );
    chopper.frontturret.team = chopper.team;
    chopper.frontturret.angles = chopper.angles;
    chopper.frontturret.turreton = 1;
    chopper.frontturret.name = "front_turret";
    chopper.frontturret.attackingtarget = undefined;
    chopper.frontturret.vehicleparent = "loot_chopper";
    chopper.frontturret linkto( chopper );
    chopper.frontturret setturretteam( chopper.team );
    chopper.frontturret setturretmodechangewait( 0 );
    chopper.frontturret setmode( "sentry" );
    chopper.frontturret setdefaultdroppitch( 45 );
    chopper.frontturret.groundtargetent = spawn( "script_model", chopper.origin );
    chopper.frontturret.groundtargetent setmodel( "tag_origin" );
    chopper.frontturret.groundtargetent dontinterpolate();
    
    if ( !level.var_b4c8dcabb0437344 )
    {
        chopper.rearturret = spawnturret( "misc_turret", chopper gettagorigin( "tag_turret_rear" ), weaponname );
        chopper.rearturret setmodel( "veh9_mil_air_heli_ahotel64_turret" );
        chopper.rearturret.team = chopper.team;
        chopper.rearturret.angles = chopper.angles;
        chopper.rearturret.turreton = 1;
        chopper.rearturret.name = "rear_turret";
        chopper.rearturret.attackingtarget = undefined;
        chopper.rearturret.vehicleparent = "loot_chopper";
        chopper.rearturret linkto( chopper );
        chopper.rearturret setturretteam( chopper.team );
        chopper.rearturret setturretmodechangewait( 0 );
        chopper.rearturret setmode( "sentry" );
        chopper.rearturret setdefaultdroppitch( 45 );
        chopper.rearturret.groundtargetent = spawn( "script_model", chopper.origin );
        chopper.rearturret.groundtargetent setmodel( "tag_origin" );
        chopper.rearturret.groundtargetent dontinterpolate();
    }
    
    level.loot_choppers[ level.loot_choppers.size ] = chopper;
    chopper.patrolfunc = &lootchopper_patrolzone;
    chopper.lootfunc = &lootchopper_droploot;
    chopper.cleanupfunc = &lootchopper_cleanup;
    chopper lootchopper_createobjective();
    chopper thread chopper_support::choppersupport_neargoalsettings();
    chopper thread chopper_support::choppersupport_watchdestroyed();
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        chopper thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &chopper_support::choppersupport_handlemissiledetection );
    }
    
    chopper thread chopper_support::choppersupport_movetolocation( chopper.pathgoal, 1 );
    return chopper;
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x9349fe2c, Offset: 0x1d62
// Size: 0x393
function lootchopper_setupdamagefunctionality()
{
    self.vehiclename = "loot_chopper";
    vehicle_damage::set_vehicle_hit_damage_data( vehicle::get_ref(), 20 );
    lootchopper_modifyweapondamage( "iw9_la_gromeo_mp", 4, 20 );
    lootchopper_modifyweapondamage( "iw9_la_kgolf_mp", 4, 20 );
    lootchopper_modifyweapondamage( "iw9_la_rpapa7_mp", 4, 20 );
    lootchopper_modifyweapondamage( "iw9_la_juliet_mp", 5, 20 );
    lootchopper_modifyweapondamage( "iw9_la_gromeo_mp", 4, 20 );
    lootchopper_modifyweapondamage( "iw9_la_mike32_mp", 2.85714, 20 );
    lootchopper_modifyweapondamage( "t10_la_p17_pable3", 4, 20 );
    lootchopper_modifyweapondamage( "t10_la_p18_stisaac", 4, 20 );
    lootchopper_modifyweapondamage( "jup_jp22_la_dromeo", 1.66667, 20 );
    lootchopper_modifyweapondamage( "jup_jp26_la_cluster", 4, 20 );
    lootchopper_modifyweapondamage( "jup_jp26_la_cluster32", 4, 20 );
    lootchopper_modifyweapondamage( "jup_jp26_la_mike32", 4, 20 );
    lootchopper_modifyweapondamage( "sat_la_fang", 4, 20 );
    lootchopper_modifyweapondamage( "sat_la_polis", 4, 20 );
    lootchopper_modifyweapondamage( "equip_c4", 4, 20 );
    lootchopper_modifyweapondamage( "equip_semtex", 2.85714, 20 );
    lootchopper_modifyweapondamage( "sticky_grenade_mp", 2.85714, 20 );
    lootchopper_modifyweapondamage( "equip_frag", 2.85714, 20 );
    lootchopper_modifyweapondamage( "pop_rocket_mp", 2.85714, 20 );
    lootchopper_modifyweapondamage( "equip_molotov", 1.81818, 20 );
    lootchopper_modifyweapondamage( "at_mine_ap_mp", 1.81818, 20 );
    lootchopper_modifyweapondamage( "equip_at_mine", 2.85714, 20 );
    lootchopper_modifyweapondamage( "equip_thermite", 1, 52 );
    lootchopper_modifyweapondamage( "thermite_av_mp", 1, 52 );
    lootchopper_modifyweapondamage( "thermite_bolt_mp", 1, 52 );
    lootchopper_modifyweapondamage( "thermite_xmike109_mp", 1, 52 );
    lootchopper_modifyweapondamage( "equip_emp", 2.85714, 20 );
    lootchopper_modifyweapondamage( "equip_claymore", 2.85714, 20 );
    lootchopper_modifyweapondamage( "semtex_bolt_mp", 2, 20 );
    lootchopper_modifyweapondamage( "semtex_xmike109_mp", 1.42857, 20 );
    lootchopper_modifyweapondamage( "chopper_gunner_proj_mp", 5, 20 );
    lootchopper_modifyweapondamage( "toma_proj_mp", 2.85714, 20 );
    lootchopper_modifyweapondamage( "cruise_proj_mp", 6.66667, 20 );
    lootchopper_modifyweapondamage( "artillery_mp", 6.66667, 20 );
    lootchopper_modifyweapondamage( "nuke_mp", 10, 20 );
    lootchopper_modifyweapondamage( "gunship_hellfire_mp", 10, 20 );
    lootchopper_modifyweapondamage( "gunship_105mm_mp", 10, 20 );
    lootchopper_modifyweapondamage( "gunship_40mm_mp", 5, 20 );
    lootchopper_modifyweapondamage( "gunship_25mm_mp", 2.85714, 20 );
    lootchopper_modifyweapondamage( "hover_jet_proj_mp", 5, 20 );
    vehicle_damage::function_f22ce6c0cf2d903b( self );
    vehicle_damage::get_vehicle_mod_damage_data( vehicle::get_ref(), 1 );
    vehicle_damage::set_pre_mod_damage_callback( vehicle::get_ref(), &lootchopper_premodifydamage );
    vehicle_damage::set_post_mod_damage_callback( vehicle::get_ref(), &lootchopper_postmodifydamage );
    vehicle_damage::set_death_callback( vehicle::get_ref(), &lootchopper_handledeathdamage );
    killstreak_utility::function_b555369eba6b0252( 1, 2000, &function_736530d9de4f4a52 );
    killstreak_utility::function_b555369eba6b0252( 2, 1000, &function_50f55dcd1440adb7 );
    killstreak_utility::function_b555369eba6b0252( 3, 500, &function_734920a78b9a1827 );
    vehicle_tracking::register_instance( self );
}

// Namespace br_lootchopper
// Params 3
// Checksum 0x7eca2bd0, Offset: 0x20fd
// Size: 0x9e
function lootchopper_modifyweapondamage( weaponname, var_e8fb536462dbc663, var_965b7ee9f4e661e1 )
{
    weaponnameref = weaponname;
    
    if ( level.equipment.table && level.equipment.table[ weaponname ] )
    {
        weaponnameref = level.equipment.table[ weaponname ].weaponname;
    }
    
    vehicle_damage::set_weapon_hit_damage_data_for_vehicle( weaponnameref, var_e8fb536462dbc663, vehicle::get_ref() );
    vehicle_damage::set_vehicle_hit_damage_data_for_weapon( vehicle::get_ref(), var_965b7ee9f4e661e1, weaponnameref );
}

// Namespace br_lootchopper
// Params 1
// Checksum 0x629f32dd, Offset: 0x21a3
// Size: 0x3a, Type: bool
function lootchopper_premodifydamage( data )
{
    damage = data.damage;
    attacker = data.attacker;
    return true;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0x99ce5afb, Offset: 0x21e6
// Size: 0x128, Type: bool
function lootchopper_postmodifydamage( data )
{
    chopper_support::choppersupport_postmodifydamage( data );
    
    if ( !isdefined( self.attackers ) )
    {
        self.attackers = [];
    }
    
    oldattackerdata = lootchopper_getattackerdata( data.attacker );
    
    if ( !isdefined( oldattackerdata ) )
    {
        newattacker = spawnstruct();
        newattacker.player = data.attacker;
        newattacker.objweapon = data.objweapon;
        newattacker.totaldamage = data.damage;
        newattacker.lastdamagetime = gettime();
        self.attackers[ self.attackers.size ] = newattacker;
    }
    else
    {
        oldattackerdata.totaldamage += data.damage;
        oldattackerdata.objweapon = data.objweapon;
        oldattackerdata.lastdamagetime = gettime();
    }
    
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0x16db725c, Offset: 0x2317
// Size: 0x155, Type: bool
function lootchopper_handledeathdamage( data )
{
    chopper_support::choppersupport_handledeathdamage( data );
    scoreevent = undefined;
    points = undefined;
    killer = data.attacker;
    
    foreach ( attackerinfo in self.attackers )
    {
        if ( isdefined( attackerinfo.player ) )
        {
            if ( killer == attackerinfo.player )
            {
                scoreevent = #"hash_916af74a28436e1c";
            }
            else
            {
                scoreevent = #"hash_59b8198b31baf7ea";
            }
            
            points = rank::getscoreinfovalue( scoreevent );
            attackerinfo.player thread rank::giverankxp( scoreevent, points, attackerinfo.objweapon );
            attackerinfo.player thread events::killeventtextpopup( scoreevent, 0 );
            thread challenges::vehiclekilled( self, attackerinfo.player, 0, attackerinfo.objweapon );
        }
    }
    
    self notify( #"death" );
    return true;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0xa52f4e8d, Offset: 0x2475
// Size: 0xfc
function lootchopper_patrolzone( initialpatrol )
{
    if ( self.currentaction != "patrol" )
    {
        self.currentaction = "patrol";
    }
    else if ( self.currentaction == "patrol" && !initialpatrol )
    {
        return;
    }
    
    self clearlookatent();
    self setneargoalnotifydist( 300 );
    wasattacking = 0;
    startingangle = 0;
    
    while ( true )
    {
        if ( self.currentaction == "attacking" )
        {
            if ( !wasattacking )
            {
                wasattacking = 1;
            }
            
            waitframe();
            continue;
        }
        
        if ( !initialpatrol && wasattacking )
        {
            wasattacking = 0;
        }
        
        newgoal = self.patrollocation + anglestoforward( ( 0, startingangle, 0 ) ) * int( self.patrolradius / 1.2 );
        startingangle += 90;
        chopper_support::choppersupport_movetolocation( newgoal, 1 );
        
        if ( startingangle >= 360 )
        {
            startingangle = 0;
        }
        
        wait 0.5;
    }
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x9057d77a, Offset: 0x2579
// Size: 0x6c
function lootchopper_droploot()
{
    droplocation = lootchopper_finddroplocation( self.origin + ( 0, 0, 500 ) );
    
    if ( isdefined( droplocation ) )
    {
        plundercrate = airdrop::dropbrlootchoppercrate( self.origin, droplocation );
        triggerobject = airdrop::gettriggerobject( plundercrate );
        triggerobject.usetimeoverride = 10;
    }
}

// Namespace br_lootchopper
// Params 1
// Checksum 0x8d3c5854, Offset: 0x25ed
// Size: 0xa6
function lootchopper_finddroplocation( starttrace )
{
    droplocation = undefined;
    endtrace = starttrace - ( 0, 0, 20000 );
    ignorelist = [];
    
    if ( isent( self ) )
    {
        ignorelist = [ self, self.frontturret, self.rearturret ];
        ignorelist = function_5713d46873b29625( ignorelist );
    }
    
    trace = trace::ray_trace( starttrace, endtrace, ignorelist );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        droplocation = trace[ "position" ];
    }
    
    return droplocation;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0xc2dd6d38, Offset: 0x269c
// Size: 0x172
function lootchopper_oncrateuse( player )
{
    plunderreward = getdvarint( @"hash_c027db5b75ded4aa", 100000 );
    
    if ( level.bmoovertime )
    {
        var_89309919075fbffb = getdvarint( @"hash_7daf22bb16ed19fe", 50000 );
        plunderreward += var_89309919075fbffb;
    }
    
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropstruct.dropidx = 10;
    common_item::function_45c338c4003d5f13( self, 0 );
    pickupents = br_plunder::dropplunderbyrarity( plunderreward / 100, dropstruct );
    
    foreach ( ent in pickupents )
    {
        ent.lootsource = "loot_chopper";
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( game_utility::getgametype() == "plunder" )
    {
        player br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
    
    player thread points::doscoreevent( #"hash_70e5de61cfaa916b" );
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x59b64fa5, Offset: 0x2816
// Size: 0x79
function lootchopper_cleanup()
{
    if ( isdefined( self.dropzone ) )
    {
        self.dropzone delete();
    }
    
    if ( isdefined( self.patrolzone ) )
    {
        self.patrolzone.chopperoccupied = undefined;
    }
    
    if ( isdefined( self.objectiveiconid ) )
    {
        objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    }
    
    vehicle_tracking::deregister_instance( self );
    level.loot_choppers = arrayremove( level.loot_choppers, self );
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x83de7100, Offset: 0x2897
// Size: 0x7a
function lootchopper_createobjective()
{
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "active", self.origin, "ui_mp_br_mapmenu_icon_boss_chopper", "icon_medium" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
        objidpoolmanager::update_objective_onentity( objectiveiconid, self );
        objective_sethideelevation( objectiveiconid, 1 );
        function_461834c350793158( objectiveiconid, 1 );
    }
    
    self.objectiveiconid = objectiveiconid;
}

// Namespace br_lootchopper
// Params 1
// Checksum 0x5556cee6, Offset: 0x2919
// Size: 0xab
function lootchopper_getattackerdata( currentattacker )
{
    attackerdata = undefined;
    
    if ( !isdefined( currentattacker ) )
    {
        return attackerdata;
    }
    
    foreach ( activeattackerdata in self.attackers )
    {
        if ( currentattacker == activeattackerdata.player )
        {
            attackerdata = activeattackerdata;
            break;
        }
    }
    
    return attackerdata;
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x9a345189, Offset: 0x29cd
// Size: 0x12
function function_736530d9de4f4a52()
{
    self setscriptablepartstate( "body_damage_light", "on" );
}

// Namespace br_lootchopper
// Params 0
// Checksum 0xb4129cd3, Offset: 0x29e7
// Size: 0x12
function function_50f55dcd1440adb7()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace br_lootchopper
// Params 0
// Checksum 0x32577270, Offset: 0x2a01
// Size: 0x12
function function_734920a78b9a1827()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
}

