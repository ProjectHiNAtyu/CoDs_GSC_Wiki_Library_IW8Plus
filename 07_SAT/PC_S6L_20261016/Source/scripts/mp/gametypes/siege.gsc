// scripts\mp\gametypes\siege.gsc  (hash_6b62860a8acd5c43.gscc) (size: 52451 Bytes / 0xcce3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x19480756 (424150870)
// size ...... 52451 (0xcce3)
// includes .. 39  (offset: 0xbe33)
// strings ... 151 (offset: 0xbf6b)
// dev strs .. 23  (offset: 0xcb73)
// exports ... 78  (offset: 0x8ccf)
// cseg ...... 0x9fb + 0x82d4 (0x8ccf)
// imports ... 298 (offset: 0x98ff)
// animtree1 . 0   (offset: 0xcce3)
// animtree2 . 0   (offset: 0xcce3)
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\arm;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;

#namespace siege;

// Namespace siege
// Params 0
// Checksum 0x9a2903a4, Offset: 0xa19
// Size: 0x60a
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    level.isgroundwarsiege = 0;
    matchmakingmatch = getdvarint( @"onlinegame" ) && !getdvarint( @"xblive_privatematch" );
    
    if ( matchmakingmatch )
    {
        level.isgroundwarsiege = getdvarint( @"scr_siege_groundwarsiege", 0 );
    }
    
    /#
        level.isgroundwarsiege = getdvarint( @"scr_siege_groundwarsiege", 0 );
    #/
    
    level.allowmodestructs = [];
    
    if ( level.isgroundwarsiege )
    {
        level.allowmodestructs[ level.allowmodestructs.size ] = "arm";
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "dom";
    
    if ( level.isgroundwarsiege )
    {
        allowed[ allowed.size ] = "arm";
    }
    
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.gamehasstarted = 0;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.onplayerjointeam = &onplayerjointeam;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.ondeadevent = &ondeadevent;
    level.ononeleftevent = &ononeleftevent;
    level.ontimelimit = &ontimelimit;
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    level.lastcaptime = gettime();
    level.alliesprevflagcount = 0;
    level.axisprevflagcount = 0;
    level.allowlatecomers = 0;
    level.gametimerbeeps = 0;
    level.rushtimerteam = "none";
    level.siegeflagcapturing = [];
    
    if ( level.isgroundwarsiege )
    {
        level.requiredplayercountoveride = 1;
        level.requiredplayercount[ "allies" ] = 12;
        level.requiredplayercount[ "axis" ] = 12;
        level.modecontrolledvehiclespawningonly = 1;
        level.maxhqtanks = 0;
        level.numnonrallyvehicles = getdvarint( @"scr_siege_numnonrallyvehicles", 25 );
        level.skipplaybodycountsound = 1;
        level.disablespawncamera = 1;
        mapname = game_utility::getmapname();
        
        switch ( mapname )
        {
            case #"hash_12f3765ef24b4037":
            case #"hash_1bc93b88575e82eb":
            case #"hash_32eaa112f8caa7e4":
            case #"hash_3a8b050ff58578ad":
            case #"hash_50de71be6e7469ff":
            case #"hash_7a28db3c5928c489":
            case #"hash_863773b8960b3944":
            case #"hash_924a3fbe9fbe15c6":
            case #"hash_e4ca6b73b5022b26":
                parachute::initparachutedvars();
                break;
            default:
                break;
        }
        
        if ( !isdefined( game_utility::getlocaleid() ) )
        {
            switch ( mapname )
            {
                case #"hash_32eaa112f8caa7e4":
                    game_utility::setlocaleid( 6 );
                    break;
                case #"hash_7a28db3c5928c489":
                    game_utility::setlocaleid( 5 );
                    break;
                case #"hash_50de71be6e7469ff":
                case #"hash_863773b8960b3944":
                    game_utility::setlocaleid( 9 );
                    break;
                case #"hash_12f3765ef24b4037":
                    game_utility::setlocaleid( 3 );
                    break;
                case #"hash_924a3fbe9fbe15c6":
                    game_utility::setlocaleid( 4 );
                    break;
                case #"hash_a8b272dba33a4aed":
                    game_utility::setlocaleid( 17 );
                    break;
                case #"hash_1bc93b88575e82eb":
                    game_utility::setlocaleid( 18 );
                    break;
                case #"hash_e4ca6b73b5022b26":
                    game_utility::setlocaleid( 10 );
                    break;
                case #"hash_3a8b050ff58578ad":
                    game_utility::setlocaleid( 19 );
                    break;
                default:
                    game_utility::setlocaleid( 0 );
                    break;
            }
        }
    }
    
    game[ "canScoreOnTie" ] = 1;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_mpsg_mode_uktl_snt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "gametype_siege";
    }
    
    game[ "dialog" ][ "boost" ] = "boost_siege";
    game[ "dialog" ][ "offense_obj" ] = "boost_siege";
    game[ "dialog" ][ "defense_obj" ] = "boost_siege";
    game[ "dialog" ][ "securing_a" ] = "securing_a";
    game[ "dialog" ][ "securing_b" ] = "securing_b";
    game[ "dialog" ][ "securing_c" ] = "securing_c";
    game[ "dialog" ][ "secured_a" ] = "secure_a";
    game[ "dialog" ][ "secured_b" ] = "secure_b";
    game[ "dialog" ][ "secured_c" ] = "secure_c";
    game[ "dialog" ][ "losing_a" ] = "losing_a";
    game[ "dialog" ][ "losing_b" ] = "losing_b";
    game[ "dialog" ][ "losing_c" ] = "losing_c";
    game[ "dialog" ][ "lost_a" ] = "lost_a";
    game[ "dialog" ][ "lost_b" ] = "lost_b";
    game[ "dialog" ][ "lost_c" ] = "lost_c";
    game[ "dialog" ][ "enemy_captured_2" ] = "siege_enemy_captured_2";
    game[ "dialog" ][ "friendly_captured_2" ] = "siege_friendly_captured_2";
    game[ "dialog" ][ "lastalive_zones" ] = "lastalive_zones";
}

// Namespace siege
// Params 0
// Checksum 0x2503c4aa, Offset: 0x102b
// Size: 0xcd
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_41bd47d6d0def56", getmatchrulesdata( "siegeData", "rushTimer" ) );
    setdynamicdvar( @"hash_24a372f8e55b2fea", getmatchrulesdata( "siegeData", "rushTimerAmount" ) );
    setdynamicdvar( @"hash_9e119c9c57105ac5", getmatchrulesdata( "siegeData", "sharedRushTimer" ) );
    setdynamicdvar( @"hash_132b182e76e85c9b", getmatchrulesdata( "siegeData", "preCapPoints" ) );
    setdynamicdvar( @"hash_18590465135e9503", getmatchrulesdata( "siegeData", "capRate" ) );
    setdynamicdvar( @"hash_462e8dc6c1e380cc", getmatchrulesdata( "siegeData", "objScalar" ) );
    setdynamicdvar( @"hash_e2d968dab42f65ee", getmatchrulesdata( "siegeData", "holdAllTimer" ) );
}

// Namespace siege
// Params 0
// Checksum 0x25aca372, Offset: 0x1100
// Size: 0x64
function seticonnames()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
}

// Namespace siege
// Params 0
// Checksum 0x9d0c0584, Offset: 0x116c
// Size: 0x20c
function onstartgametype()
{
    seticonnames();
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/dom" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dom" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/dom_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/dom_hint" );
    }
    
    thread waittooverridegraceperiod();
    
    if ( level.isgroundwarsiege )
    {
        thread adjustroundendtimer();
        arm::initspawns( isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] != 0 );
        level thread arm::setupwaypointicons();
        arm::debug_setupmatchdata();
        arm::setuphqs();
        arm::calculatehqmidpoint();
        level.numsiegeflags = getdvarint( @"scr_siege_flagcount", 3 );
        setomnvar( "ui_num_dom_flags", level.numsiegeflags );
        arm::setupobjectives();
        level thread runobjectives();
        thread arm_vehicles::init_groundwarvehicles();
        thread initvehicles();
        arm::emergency_cleanupents();
    }
    else
    {
        initspawns();
        thread domflags();
    }
    
    thread watchflagtimerpause();
    thread watchgamestart();
    
    if ( game_utility_mp::matchmakinggame() )
    {
        thread watchgameinactive();
    }
    
    /#
        thread function_8d8d77f766c8bd7a();
        thread removedompoint();
        thread placedompoint();
    #/
}

// Namespace siege
// Params 1
// Checksum 0xf7b74b1c, Offset: 0x1380
// Size: 0x6b
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    return spawndata;
}

// Namespace siege
// Params 2
// Checksum 0x28be201b, Offset: 0x13f4
// Size: 0x82
function registervehicletype( refname, spawnvehiclecallback )
{
    assert( isdefined( refname ) );
    vehicleinfo = spawnstruct();
    vehicleinfo.refname = refname;
    vehicleinfo.spawncallback = spawnvehiclecallback;
    vehicleinfo.vehiclespawns = vehicle_spawn::get_spawn_structs( refname );
    assert( isdefined( vehicleinfo.vehiclespawns ) );
    level.vehicleinfo[ refname ] = vehicleinfo;
}

// Namespace siege
// Params 0
// Checksum 0xecd99c80, Offset: 0x147e
// Size: 0x3df
function initvehicles()
{
    level.numhqtanks_axis = 0;
    level.numhqtanks_allies = 0;
    
    if ( !isdefined( level.vehicleinfo ) )
    {
        level.vehicleinfo = [];
    }
    
    registervehicletype( %"hash_49602cb7beee6fba", &vehiclespawn_littlebird );
    registervehicletype( %"hash_21df6558fa3c728b", &vehiclespawn_atv );
    registervehicletype( %"hash_4725c8dee627919d", &vehiclespawn_tacrover );
    level.vehiclespawnlocs = [];
    
    foreach ( vehicleinfo in level.vehicleinfo )
    {
        switch ( vehicleinfo.refname )
        {
            case %"hash_49602cb7beee6fba":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_49602cb7beee6fba", "veh9_mil_air_heli_medium_physics_mp" );
                break;
            case %"hash_21df6558fa3c728b":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_21df6558fa3c728b", "veh9_mil_lnd_atv_physics_mp" );
                break;
            case %"hash_4725c8dee627919d":
                vehicleinfo.vehiclespawns = getvehiclespawns( %"hash_4725c8dee627919d", "tromeo_physics_mp" );
                break;
        }
        
        foreach ( spawnpoint in vehicleinfo.vehiclespawns )
        {
            index = level.vehiclespawnlocs.size;
            level.vehiclespawnlocs[ index ] = spawnpoint;
            level.vehiclespawnlocs[ index ].refname = vehicleinfo.refname;
        }
    }
    
    if ( false )
    {
        foreach ( loc in level.vehiclespawnlocs )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
        }
    }
    
    level.vehiclespawnlocs = arrayrandomize( level.vehiclespawnlocs );
    numtospawn = level.numnonrallyvehicles;
    
    if ( !isdefined( level.numnonrallyvehicles ) )
    {
        numtospawn = 25;
    }
    
    if ( false )
    {
        for ( i = 0; i < numtospawn ; i++ )
        {
            loc = level.vehiclespawnlocs[ i ];
            thread debug::drawline( loc.origin + ( 0, 0, 1500 ), loc.origin + ( 0, 0, 2500 ), 1000, ( 0, 1, 0 ) );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        loc = level.vehiclespawnlocs[ i ];
        
        if ( isdefined( loc ) )
        {
            vehicleinfo = level.vehicleinfo[ loc.refname ];
            [[ vehicleinfo.spawncallback ]]( loc );
        }
    }
}

// Namespace siege
// Params 2
// Checksum 0xbb69e2b2, Offset: 0x1865
// Size: 0x1459
function getvehiclespawns( vehicleref, vehicletype )
{
    spawns = [];
    mapname = game_utility::getmapname();
    atvoriginsarray = [];
    atvanglesarray = [];
    var_b60e03df1c17ae46 = [];
    var_9e6d05dd2a832d1f = [];
    
    switch ( mapname )
    {
        case #"hash_32eaa112f8caa7e4":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 21843.8, -4640.11, -476.961 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 20375.9, -3612.78, -454 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 20728.8, -3309.36, -456 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 255, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 330, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 292, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 20937.2, -9029.28, -379.674 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 23097.1, -9966.89, -344 );
                atvanglesarray[ atvanglesarray.size ] = ( 356.825, 240, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 0, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 17471, -23211.4, -204 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 15960.1, -22768.1, -204 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 15821.3, -23568, -208.461 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 90, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 45, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 90, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 22994.3, -15304.5, -216 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 105, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 20120.2, -3287.71, -456 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 21339.9, -4787.55, -450.176 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 345, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 357.831, 255.032, -1.25312 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 17449, -22190.1, -208.116 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 16651.1, -22178.2, -207.908 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 60, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 60, 0 );
            }
            
            break;
        case #"hash_7a28db3c5928c489":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 26335.7, 30412.6, 655.471 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 27099.5, 30567.5, 639.236 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 27315.5, 30525.5, 639.236 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.0728273, 119, 0.843973 );
                atvanglesarray[ atvanglesarray.size ] = ( 2.67817, 77.0718, 1.59551 );
                atvanglesarray[ atvanglesarray.size ] = ( 2.67817, 77.0718, 1.59551 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 29610.4, 38228.5, 698.883 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 29465.5, 38973.6, 701 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 315, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 88.9989, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 39153, 46431.8, 932.749 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 38876.4, 46106.9, 925.771 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37923.7, 47136.4, 949.247 );
                atvanglesarray[ atvanglesarray.size ] = ( 1.88064, 180.047, 0.333796 );
                atvanglesarray[ atvanglesarray.size ] = ( 1.47639, 180.039, 1.17305 );
                atvanglesarray[ atvanglesarray.size ] = ( 359.077, 185.712, 7.76991 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 33628.2, 40971.6, 653.047 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 32104.4, 41719.8, 708.773 );
                atvanglesarray[ atvanglesarray.size ] = ( 349.991, 186.286, -2.23687 );
                atvanglesarray[ atvanglesarray.size ] = ( 3.95499, 211.371, 4.41818 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 26310.8, 30168.4, 659.426 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 26954, 29794.1, 651.013 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 358.195, 118.006, -2.71651 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 89.9998, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 38573.2, 47052.8, 950.28 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 39660.3, 45949.9, 952.362 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 359.669, 194.507, -0.439539 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 11.7511, 162.518, 0.102679 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 33138.2, 41498.6, 707.349 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 357.81, 284.768, 1.14713 );
            }
            
            break;
        case #"hash_50de71be6e7469ff":
        case #"hash_863773b8960b3944":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 49063.3, -22654.9, -385.662 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 47332.9, -23070.6, -374.497 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 48281.3, -22202.5, -371.375 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.0275984, 103.998, 0.280605 );
                atvanglesarray[ atvanglesarray.size ] = ( 357.226, 88.8435, 4.3294 );
                atvanglesarray[ atvanglesarray.size ] = ( 3.93534, 89.3527, 4.34541 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 49720, -18492, -387.562 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 48107.4, -18052.3, -312.859 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 73.9972, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 352.657, 118.56, -10.3306 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 46431.3, -92.3425, -52.4549 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 47471, -192.634, -43.7394 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 48085.6, -358.42, 9.73944 );
                atvanglesarray[ atvanglesarray.size ] = ( 359.802, 240.821, -3.32839 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.975088, 240.828, 0.322594 );
                atvanglesarray[ atvanglesarray.size ] = ( 6.15886, 241.028, 2.20885 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 44528.7, -5376.79, 283.824 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 43628, -5846.41, 346.636 );
                atvanglesarray[ atvanglesarray.size ] = ( 357.74, 256.16, -1.56165 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.506229, 241.181, 0.438595 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 47872.6, -22645.4, -385.49 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 48501.7, -22505, -382.243 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 1.68464, 109.9, -3.26246 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 359.897, 89.9842, 8.71393 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 46034.5, -59.925, -29.8834 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 47108.8, -498.535, -35.0573 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 2.33612, 243.444, -0.141863 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 355.135, 243.112, 2.65064 );
            }
            
            break;
        case #"hash_12f3765ef24b4037":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 31381.3, -35260.4, -566.754 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 31087.5, -35307.9, -566.206 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 106, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 91, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37273.8, -22647.6, -566 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 38224.6, -23864.4, -566 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 225, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 225, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37183.4, -15816, -558.929 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 36704.9, -15941.1, -558 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 37630.9, -15950.5, -564 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 34323.3, -25831.8, -566 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 45, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 31412.5, -34658.3, -564.862 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 31042.3, -16171.6, -565.383 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 105, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 75, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 36937.6, -15836.1, -559.8 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 37369.7, -16171.6, -562 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270, 0 );
            }
            
            break;
        case #"hash_924a3fbe9fbe15c6":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( -28937.7, -17197.8, -246.637 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29175.8, -17121.9, -247.909 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -28096.5, -16918.8, -246.085 );
                atvanglesarray[ atvanglesarray.size ] = ( 1.203, 90, 0.12 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.597, 90, 0.15 );
                atvanglesarray[ atvanglesarray.size ] = ( 358.68, 90.0277, -0.8 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -25926, -12688.6, -89.5073 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -24872.9, -12661.3, -65.0808 );
                atvanglesarray[ atvanglesarray.size ] = ( 5.13576, 104.619, 0.240957 );
                atvanglesarray[ atvanglesarray.size ] = ( 358.169, 15, -3.49767 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -28315.5, -3152.67, -311.293 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -28107.5, -3152.67, -311.293 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -27778.8, -3591.73, -310.621 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.061, 270, 7.355 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.061, 270, 7.355 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 270, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -25666, -8411.14, -47.9997 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -26998.2, -9004.54, -40 );
                atvanglesarray[ atvanglesarray.size ] = ( 358.715, 15.233, -10.279 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 285, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -28683.3, -16741.2, -249.16 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -29128.7, -16577.6, -229.266 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 359.734, 90.0021, -0.454 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 353.195, 90.3463, -3.01942 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -27985.4, -3613.97, -315.978 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -28449.8, -3645.92, -312.247 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270.003, 5.684 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 270.004, -3.208 );
            }
            
            break;
        case #"hash_a8b272dba33a4aed":
            break;
        case #"hash_1bc93b88575e82eb":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( -9606.95, -21527.2, -279.043 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -10288.2, -20891.9, -356.989 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -11011.4, -19877, -368.358 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 200, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 222, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 359.526, 210.007, -0.952 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -13835.9, -23127.9, -278.639 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -14327.9, -22160.8, -266.586 );
                atvanglesarray[ atvanglesarray.size ] = ( 2.373, 210, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0.806, 194.929, 2.603 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -21725.2, -26511, -152 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -21577.7, -26755.1, -151.997 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -21065.3, -27199.1, -148.746 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 30, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 60, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 5.079, 0.128, 1.453 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -18873.3, -25796.5, -199.784 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 30, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -10912.6, -20079.6, -367 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -10108.5, -21861.4, -287.271 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 196.996, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 7.93172, 180.719, 4.15911 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -22036.5, -25881.6, -147.198 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -21144.5, -27447.1, -151.145 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 345, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 30, 0 );
            }
            
            break;
        case #"hash_e4ca6b73b5022b26":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( -3749, 16980, -262 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -2971.9, 18898, -262 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -2735.8, 16203, -262 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 218, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 174, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 208, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -11894, 16161, -266 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -11841, 15884, -266 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 162, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 248, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29137, 12868, -244 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29539, 12883, -252 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -29040, 13706, -497 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 0, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 0, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 5, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -19181, 16384, -263 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -19650, 17253, 54 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -19937, 16123, -261 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 310, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 357, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 35, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -3520, 17805, -262 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -3892, 18566, -262 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 165, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 194, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -29131, 13010, -244 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -28676, 13724, -518 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 0, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 355, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -19622, 17422, 54 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 357, 0 );
            }
            
            break;
        case #"hash_3a8b050ff58578ad":
            if ( vehicleref == "atv" )
            {
                atvoriginsarray[ atvoriginsarray.size ] = ( 4103, 26076, 57 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 4247, 25021, -38 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 3517, 25981, 47 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 143, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 189, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 103, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 4989, 29842, 253 );
                atvoriginsarray[ atvoriginsarray.size ] = ( 1725, 28703, 51 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 162, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 141, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -6826, 33623, -46 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -7642, 32168, -188 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -6589, 32564, -82 );
                atvanglesarray[ atvanglesarray.size ] = ( 3, 337, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 357, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 320, 0 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -3326, 32657, 238 );
                atvoriginsarray[ atvoriginsarray.size ] = ( -2149, 33264, 253 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 325, 0 );
                atvanglesarray[ atvanglesarray.size ] = ( 0, 287, 0 );
            }
            else if ( vehicleref == "tac_rover" )
            {
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 4157, 26465, 65 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( 4628, 26545, 63 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 143, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 63, 0 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -7337, 32683, -77 );
                var_b60e03df1c17ae46[ var_b60e03df1c17ae46.size ] = ( -6671, 32948, -67 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 320, 0 );
                var_9e6d05dd2a832d1f[ var_9e6d05dd2a832d1f.size ] = ( 0, 36, 0 );
            }
            
            break;
        default:
            break;
    }
    
    level.atvoriginsarray = atvoriginsarray;
    level.atvanglesarray = atvanglesarray;
    
    if ( vehicleref == "atv" )
    {
        for ( i = 0; i < atvoriginsarray.size ; i++ )
        {
            if ( i <= atvoriginsarray.size - 1 )
            {
                atvorigin = atvoriginsarray[ i ];
                atvangles = atvanglesarray[ i ];
                vehicle = spawnstruct();
                vehicle.origin = atvorigin;
                vehicle.angles = atvangles;
                vehicle.vehicletype = vehicletype;
                spawns[ spawns.size ] = vehicle;
            }
        }
    }
    else if ( vehicleref == "tac_rover" )
    {
        for ( i = 0; i < var_b60e03df1c17ae46.size ; i++ )
        {
            if ( i <= var_b60e03df1c17ae46.size - 1 )
            {
                tacroverorigin = var_b60e03df1c17ae46[ i ];
                tacroverangles = var_9e6d05dd2a832d1f[ i ];
                vehicle = spawnstruct();
                vehicle.origin = tacroverorigin;
                vehicle.angles = tacroverangles;
                vehicle.vehicletype = vehicletype;
                spawns[ spawns.size ] = vehicle;
            }
        }
    }
    
    dvarstring = hashcat( @"hash_ad95d7262a11119e", vehicleref );
    
    for ( index = 0; true ; index++ )
    {
        origindvarstring = hashcat( dvarstring, "_origin_", index );
        angledvarstring = hashcat( dvarstring, "_angles_", index );
        defaultorigin = ( 0, 0, 0 );
        origin = getdvarvector( origindvarstring, defaultorigin );
        
        if ( origin == ( 0, 0, 0 ) )
        {
            break;
        }
        
        vehicle = spawnstruct();
        vehicle.origin = origin;
        defaultangles = ( 0, 0, 0 );
        vehicle.angles = getdvarvector( angledvarstring, defaultangles );
        vehicle.vehicletype = vehicletype;
        spawns[ spawns.size ] = vehicle;
    }
    
    return spawns;
}

// Namespace siege
// Params 2
// Checksum 0x483eb06e, Offset: 0x2cc7
// Size: 0x5f
function vehiclespawn_littlebird( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_49602cb7beee6fba", spawndata, faildata );
}

// Namespace siege
// Params 2
// Checksum 0xad2fd04e, Offset: 0x2d2f
// Size: 0x5f
function vehiclespawn_atv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_21df6558fa3c728b", spawndata, faildata );
}

// Namespace siege
// Params 2
// Checksum 0xbb3f4f7, Offset: 0x2d97
// Size: 0x5f
function vehiclespawn_tacrover( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_4725c8dee627919d", spawndata, faildata );
}

// Namespace siege
// Params 1
// Checksum 0x6e3e4ad1, Offset: 0x2dff
// Size: 0x105
function filtervehiclespawnstructs( structs )
{
    filtered = [];
    
    if ( getdvarint( @"scr_brtdm_disable_radiant_vehicles", level.brtdm_config.locale_defaults[ "scr_brtdm_disable_radiant_vehicles" ] ) == 1 )
    {
        return filtered;
    }
    
    foreach ( struct in structs )
    {
        if ( distance2dsquared( struct.origin, level.brtdm_config.circlecenter ) < level.brtdm_config.circleradius * level.brtdm_config.circleradius )
        {
            filtered[ filtered.size ] = struct;
        }
    }
    
    return filtered;
}

// Namespace siege
// Params 0
// Checksum 0x9c37628f, Offset: 0x2f0d
// Size: 0xc5
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.rushtimer = dvars::dvarintvalue( "rushTimer", 1, 0, 1 );
    level.rushtimeramount = dvars::dvarfloatvalue( "rushTimerAmount", 45, 30, 120 );
    level.sharedrushtimer = dvars::dvarfloatvalue( "sharedRushTimer", 0, 0, 1 );
    level.precappoints = dvars::dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.caprate = dvars::dvarfloatvalue( "capRate", 7.5, 1, 60 );
    level.objectivescaler = dvars::dvarfloatvalue( "objScalar", 2, 1, 10 );
    level.holdallflagstimer = dvars::dvarfloatvalue( "holdAllTimer", 7.5, 0, 60 );
}

// Namespace siege
// Params 0
// Checksum 0xfb302b83, Offset: 0x2fda
// Size: 0x13
function adjustroundendtimer()
{
    wait 1;
    level.roundenddelay = 8;
}

// Namespace siege
// Params 0
// Checksum 0x654e08bb, Offset: 0x2ff5
// Size: 0x26
function waittooverridegraceperiod()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.isgroundwarsiege )
    {
        level.overrideingraceperiod = 1;
    }
}

// Namespace siege
// Params 0
// Checksum 0xa2102e1f, Offset: 0x3023
// Size: 0xc4
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::addstartspawnpoints( "mp_dom_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_dom_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_dom_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_dom_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_dom_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_dom_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_dom_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_dom_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
}

// Namespace siege
// Params 0
// Checksum 0x5f41f7c2, Offset: 0x30ef
// Size: 0x281
function getspawnpoint()
{
    if ( level.isgroundwarsiege )
    {
        spawnteam = self.pers[ "team" ];
        
        if ( spawnlogic::shoulduseteamstartspawn() )
        {
            if ( spawnteam == game[ "attackers" ] )
            {
                spawnlogic::activatespawnset( #"start_attackers", 1 );
                spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
            }
            else
            {
                spawnlogic::activatespawnset( #"start_defenders", 1 );
                spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
            }
        }
        else
        {
            spawnlogic::activatespawnset( #"primary", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"fallback" );
        }
        
        if ( level.usesquadspawn && self.squadspawnconfirmed )
        {
            spectatingteammate = self getspectatingplayer();
            
            if ( isdefined( spectatingteammate ) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid )
            {
                spawnpoint = spawnscoring::findteammatebuddyspawn( spectatingteammate );
            }
        }
        
        return spawnpoint;
    }
    
    spawnteam = self.pers[ "team" ];
    otherteam = team_utility::getotherteam( spawnteam );
    
    if ( level.usestartspawns )
    {
        spawnlogic::setactivespawnlogic( #"start" );
        
        if ( game[ "switchedsides" ] )
        {
            spawnpoints = spawnlogic::getspawnpointarray( "mp_dom_spawn_" + otherteam + "_start" );
            spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
        }
        else
        {
            spawnpoints = spawnlogic::getspawnpointarray( "mp_dom_spawn_" + spawnteam + "_start" );
            spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
        }
    }
    else
    {
        spawnlogic::setactivespawnlogic( #"default" );
        teamdompoints = getteamdompoints( spawnteam );
        enemyteam = team_utility::getotherteam( spawnteam );
        var_1aeb62419a4ccf2d = getteamdompoints( enemyteam );
        flaggroups = dom::getpreferreddompoints( teamdompoints, var_1aeb62419a4ccf2d, spawnteam, otherteam );
        var_5604c97df7f05c1b = spawnfactor::function_6ee12c1c8b06235e( flaggroups[ "preferred" ], flaggroups[ "secondary" ] );
        spawnlogic::activatespawnset( #"primary" );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, #"primary", #"fallback", undefined, var_5604c97df7f05c1b );
    }
    
    assert( isdefined( spawnpoint ) );
    return spawnpoint;
}

// Namespace siege
// Params 1
// Checksum 0xfa0b6b3e, Offset: 0x3378
// Size: 0xa1
function getteamdompoints( team )
{
    teamdompoints = [];
    
    foreach ( dompoint in level.objectives )
    {
        if ( dompoint.ownerteam == team )
        {
            teamdompoints[ teamdompoints.size ] = dompoint;
        }
    }
    
    return teamdompoints;
}

// Namespace siege
// Params 1
// Checksum 0x5df5df26, Offset: 0x3422
// Size: 0x1c
function gettimesincedompointcapture( dompoint )
{
    return gettime() - dompoint.capturetime;
}

// Namespace siege
// Params 1
// Checksum 0x9dfa69e1, Offset: 0x3447
// Size: 0x77
function onplayerconnect( player )
{
    player._domflageffect = [];
    player._domflagpulseeffect = [];
    player thread onplayerspawned();
    player thread obj_dom::ondisconnect();
    player.siegelatecomer = 1;
    
    if ( isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] != 0 && !flags::gameflag( "prematch_done" ) )
    {
        player thread manageprematchfade();
    }
}

// Namespace siege
// Params 1
// Checksum 0xee1abadd, Offset: 0x34c6
// Size: 0x9c
function onplayerdisconnect( player )
{
    for ( ;; )
    {
        player waittill( #"disconnect" );
        
        foreach ( effect in player._domflageffect )
        {
            if ( isdefined( effect ) )
            {
                effect delete();
            }
        }
    }
}

// Namespace siege
// Params 0
// Checksum 0xb80b33cb, Offset: 0x356a
// Size: 0x61
function onplayerspawned()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned" );
        stats::setextrascore0( self.pers[ "captures" ] ?? 0, "captures" );
        stats::setextrascore1( self.pers[ "rescues" ] ?? 0, "rescues" );
    }
}

// Namespace siege
// Params 1
// Checksum 0xef0af3cc, Offset: 0x35d3
// Size: 0x23
function onplayerjointeam( player )
{
    if ( game_utility_mp::gamehasstarted() )
    {
        player.siegelatecomer = 1;
    }
}

// Namespace siege
// Params 1
// Checksum 0x56c19dc0, Offset: 0x35fe
// Size: 0x1f
function onspawnplayer( revivespawn )
{
    level notify( #"spawned_player" );
    thread dom::updatematchstatushintonspawn();
}

// Namespace siege
// Params 0
// Checksum 0x3dc3515e, Offset: 0x3625
// Size: 0x54
function checkallowspectating()
{
    if ( level.rushtimerteam == "none" )
    {
        return;
    }
    
    if ( !teams::getteamdata( level.rushtimerteam, "aliveCount" ) )
    {
        level.spectateoverride[ level.rushtimerteam ].allowenemyspectate = 1;
        spectating::updatespectatesettings();
    }
}

// Namespace siege
// Params 0
// Checksum 0x3ab23595, Offset: 0x3681
// Size: 0x77e
function domflags()
{
    level endon( #"game_ended" );
    primaryflags = getentarray( "flag_primary", #targetname );
    secondaryflags = getentarray( "flag_secondary", #targetname );
    
    if ( primaryflags.size + secondaryflags.size < 2 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    filename = "mp/siegeFlagPos.csv";
    currentmap = game_utility::getmapname();
    searchcol = 1;
    
    for ( returncol = 2; returncol < 11 ; returncol++ )
    {
        returnvalue = tablelookup( filename, searchcol, currentmap, returncol );
        
        if ( returnvalue != "" )
        {
            setflagpositions( returncol, float( returnvalue ) );
        }
    }
    
    triggers = [];
    
    for ( index = 0; index < primaryflags.size ; index++ )
    {
        triggers[ triggers.size ] = primaryflags[ index ];
    }
    
    for ( index = 0; index < secondaryflags.size ; index++ )
    {
        triggers[ triggers.size ] = secondaryflags[ index ];
    }
    
    level.numsiegeflags = 3;
    setomnvar( "ui_num_dom_flags", level.numsiegeflags );
    
    if ( level.numsiegeflags == 3 )
    {
        foreach ( trigger in primaryflags )
        {
            trigger dom::remapdomtriggerscriptlabel();
        }
    }
    
    level.objectives = [];
    
    for ( index = 0; index < triggers.size ; index++ )
    {
        trigger = triggers[ index ];
        
        if ( level.numsiegeflags == 3 )
        {
            if ( trigger.script_label == "_d" || trigger.script_label == "_e" )
            {
                continue;
            }
        }
        
        trigger.origin = getflagpos( trigger.script_label, trigger.origin );
        
        if ( isdefined( trigger.target ) )
        {
            visuals[ 0 ] = getent( trigger.target, #targetname );
        }
        else
        {
            visuals[ 0 ] = spawn( "script_model", trigger.origin );
            visuals[ 0 ].angles = trigger.angles;
        }
        
        domflag = gameobjects::createuseobject( "neutral", trigger, visuals, ( 0, 0, 100 ), 1, 1 );
        domflag gameobjects::allowuse( "enemy" );
        domflag gameobjects::setusetime( level.caprate );
        
        if ( isdefined( trigger.objectivekey ) )
        {
            domflag.objectivekey = trigger.objectivekey;
        }
        else
        {
            domflag.objectivekey = domflag gameobjects::getlabel();
        }
        
        if ( isdefined( trigger.iconname ) )
        {
            domflag.iconname = trigger.iconname;
        }
        else
        {
            domflag.iconname = domflag gameobjects::getlabel();
        }
        
        domflag gameobjects::cancontestclaim( 1 );
        domflag.nousebar = 1;
        domflag.id = "domFlag";
        domflag.firstcapture = 1;
        domflag.prevteam = "neutral";
        domflag.flagcapsuccess = 0;
        domflag.playersrevived = 0;
        domflag.claimgracetime = level.caprate * 1000;
        domflag gameobjects::pinobjiconontriggertouch();
        tracestart = visuals[ 0 ].origin + ( 0, 0, 32 );
        traceend = visuals[ 0 ].origin + ( 0, 0, -32 );
        trace = trace::ray_trace( tracestart, traceend, undefined, trace::create_default_contents( 1 ) );
        offset = obj_dom::checkmapoffsets( domflag );
        domflag.baseeffectpos = trace[ "position" ] + offset;
        upangles = vectortoangles( trace[ "normal" ] );
        modifiedupangles = obj_dom::checkmapfxangles( domflag, upangles );
        domflag.baseeffectforward = anglestoforward( modifiedupangles );
        domflag.noscriptable = 1;
        domflag.flagmodel = spawn( "script_model", domflag.baseeffectpos );
        domflag.flagmodel setmodel( "military_dom_flag_neutral" );
        level.objectives[ domflag.objectivekey ] = domflag;
    }
    
    spawn_axis_start = spawnlogic::getspawnpointarray( "mp_dom_spawn_axis_start" );
    spawn_allies_start = spawnlogic::getspawnpointarray( "mp_dom_spawn_allies_start" );
    level.startpos[ "allies" ] = spawn_allies_start[ 0 ].origin;
    level.startpos[ "axis" ] = spawn_axis_start[ 0 ].origin;
    level.bestspawnflag = [];
    level.bestspawnflag[ "allies" ] = obj_dom::getunownedflagneareststart( "allies", undefined );
    level.bestspawnflag[ "axis" ] = obj_dom::getunownedflagneareststart( "axis", level.bestspawnflag[ "allies" ] );
    dom::flagsetup();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    foreach ( flag in level.objectives )
    {
        reservedobjid = obj_dom::getreservedobjid( flag.objectivekey );
        flag gameobjects::requestid( 1, 1, reservedobjid );
        flag.onuse = &onuse;
        flag.onbeginuse = &onbeginuse;
        flag.onuseupdate = &onuseupdate;
        flag.onenduse = &onenduse;
        flag.oncontested = &oncontested;
        flag.onuncontested = &onuncontested;
        flag.onunoccupied = &onunoccupied;
        flag.onpinnedstate = &onpinnedstate;
        flag.onunpinnedstate = &onunpinnedstate;
        flag.stompeenemyprogressupdate = &onstompeenemyprogressupdate;
        flag.stompprogressreward = &stompprogressreward;
        flag gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        flag gameobjects::setvisibleteam( "any" );
        flag obj_dom::domflag_setneutral();
    }
    
    if ( level.precappoints )
    {
        obj_dom::precap();
    }
}

// Namespace siege
// Params 0
// Checksum 0xaffb2c38, Offset: 0x3e07
// Size: 0x1e
function setneutral()
{
    if ( gameobjects::getownerteam() == "neutral" )
    {
        thread obj_dom::updateflagstate( "idle", 0 );
    }
}

// Namespace siege
// Params 2
// Checksum 0xe45c3427, Offset: 0x3e2d
// Size: 0x109
function setflagpositions( col, posvalue )
{
    switch ( col )
    {
        case 2:
            level.siege_a_xpos = posvalue;
            break;
        case 3:
            level.siege_a_ypos = posvalue;
            break;
        case 4:
            level.siege_a_zpos = posvalue;
            break;
        case 5:
            level.siege_b_xpos = posvalue;
            break;
        case 6:
            level.siege_b_ypos = posvalue;
            break;
        case 7:
            level.siege_b_zpos = posvalue;
            break;
        case 8:
            level.siege_c_xpos = posvalue;
            break;
        case 9:
            level.siege_c_ypos = posvalue;
            break;
        case 10:
            level.siege_c_zpos = posvalue;
            break;
    }
}

// Namespace siege
// Params 2
// Checksum 0xf3893323, Offset: 0x3f3e
// Size: 0x110
function getflagpos( flaglabel, flagorigin )
{
    returnorigin = flagorigin;
    
    if ( flaglabel == "_a" )
    {
        if ( isdefined( level.siege_a_xpos ) && isdefined( level.siege_a_ypos ) && isdefined( level.siege_a_zpos ) )
        {
            returnorigin = ( level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos );
        }
    }
    else if ( flaglabel == "_b" )
    {
        if ( isdefined( level.siege_b_xpos ) && isdefined( level.siege_b_ypos ) && isdefined( level.siege_b_zpos ) )
        {
            returnorigin = ( level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos );
        }
    }
    else if ( isdefined( level.siege_c_xpos ) && isdefined( level.siege_c_ypos ) && isdefined( level.siege_c_zpos ) )
    {
        returnorigin = ( level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos );
    }
    
    return returnorigin;
}

// Namespace siege
// Params 0
// Checksum 0x6c694494, Offset: 0x4057
// Size: 0xeb
function watchflagtimerpause()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"flag_capturing", flag );
        
        if ( level.rushtimer )
        {
            if ( flag.prevteam != "neutral" )
            {
                capturingteam = team_utility::getotherteam( flag.prevteam );
                
                if ( isdefined( level.siegetimerstate ) && level.siegetimerstate != "pause" && !iswinningteam( capturingteam ) )
                {
                    level.gametimerbeeps = 0;
                    level.siegetimerstate = "pause";
                    pausecountdowntimer();
                    
                    if ( !flagownersalive( flag.prevteam ) )
                    {
                        setwinner( capturingteam, tolower( game[ flag.prevteam ] ) + "_eliminated" );
                    }
                }
            }
        }
    }
}

// Namespace siege
// Params 1
// Checksum 0xaf4f873d, Offset: 0x414a
// Size: 0x57
function iswinningteam( team )
{
    iswinning = 0;
    teamflags = getflagcount( team );
    
    if ( level.numsiegeflags == 3 )
    {
        if ( teamflags == 2 )
        {
            iswinning = 1;
        }
    }
    else if ( teamflags >= 3 )
    {
        iswinning = 1;
    }
    
    return iswinning;
}

// Namespace siege
// Params 1
// Checksum 0x1a3e8094, Offset: 0x41aa
// Size: 0xcb
function flagownersalive( team )
{
    ownersalive = 0;
    
    foreach ( player in level.participants )
    {
        if ( isdefined( player ) && player.team == team && ( player::isreallyalive( player ) || player.pers[ "lives" ] > 0 ) )
        {
            ownersalive = 1;
            break;
        }
    }
    
    return ownersalive;
}

// Namespace siege
// Params 0
// Checksum 0xe7429738, Offset: 0x427e
// Size: 0x6a
function pausecountdowntimer()
{
    if ( !level.timerstoppedforgamemode )
    {
        var_35172e0eb29f440c = level.rushtimeramount;
        
        if ( isdefined( level.siegetimeleft ) )
        {
            var_35172e0eb29f440c = level.siegetimeleft;
        }
        
        gameovertime = int( gettime() + var_35172e0eb29f440c * 1000 );
        gamelogic_mp::pausetimer( gameovertime );
    }
    
    level notify( #"hash_10739227c290845" );
}

// Namespace siege
// Params 1
// Checksum 0x5cba0d81, Offset: 0x42f0
// Size: 0xc7
function resumecountdowntimer( pause )
{
    var_35172e0eb29f440c = level.rushtimeramount;
    
    if ( level.timerstoppedforgamemode )
    {
        if ( isdefined( level.siegetimeleft ) )
        {
            var_35172e0eb29f440c = level.siegetimeleft;
        }
        
        gameovertime = int( gettime() + var_35172e0eb29f440c * 1000 );
        setgameendtime( gameovertime );
        gamelogic_mp::resumetimer( gameovertime );
        
        if ( !isdefined( level.siegetimerstate ) || level.siegetimerstate == "pause" )
        {
            level.siegetimerstate = "start";
        }
        
        thread watchgametimer( var_35172e0eb29f440c );
        
        if ( pause )
        {
            if ( level.siegeflagcapturing.size > 0 )
            {
                level notify( #"flag_capturing", self );
            }
        }
    }
}

// Namespace siege
// Params 1
// Checksum 0xbe692042, Offset: 0x43bf
// Size: 0x305
function watchflagenduse( team )
{
    level endon( #"game_ended" );
    alliesflags = 0;
    axisflags = 0;
    var_71b5bf2eb694eb30 = level.rushtimerteam;
    alliesflags = getflagcount( "allies" );
    axisflags = getflagcount( "axis" );
    
    if ( level.rushtimer && level.rushtimerteam != "none" )
    {
        if ( level.sharedrushtimer || alliesflags == 1 && axisflags == 1 )
        {
            level.siegetimerstate = "start";
            notifyplayers( "siege_timer_start" );
            resumecountdowntimer( 1 );
            return;
        }
    }
    
    if ( alliesflags == level.numsiegeflags )
    {
        setwinner( "allies", "siege_allflags_win", "siege_allflags_loss" );
    }
    else if ( axisflags == level.numsiegeflags )
    {
        setwinner( "axis", "siege_allflags_win", "siege_allflags_loss" );
    }
    else if ( level.rushtimer )
    {
        if ( alliesflags == 2 || axisflags == 2 )
        {
            level.rushtimerteam = alliesflags > axisflags ? "allies" : "axis";
            
            if ( var_71b5bf2eb694eb30 != level.rushtimerteam )
            {
                if ( isdefined( level.siegetimerstate ) && level.siegetimerstate != "reset" )
                {
                    level.gametimerbeeps = 0;
                    level.siegetimeleft = undefined;
                    level.siegetimerstate = "reset";
                    notifyplayers( "siege_timer_reset" );
                }
                
                if ( level.siegetimerstate != "start" )
                {
                    var_35172e0eb29f440c = level.rushtimeramount;
                    
                    if ( isdefined( level.siegetimeleft ) )
                    {
                        var_35172e0eb29f440c = level.siegetimeleft;
                    }
                    
                    gameovertime = int( gettime() + var_35172e0eb29f440c * 1000 );
                    level.timelimitoverride = 1;
                    gamelogic_mp::pausetimer( gameovertime );
                    setgameendtime( gameovertime );
                    gamelogic_mp::resumetimer( gameovertime );
                    
                    if ( !isdefined( level.siegetimerstate ) || level.siegetimerstate == "pause" )
                    {
                        level.siegetimerstate = "start";
                        notifyplayers( "siege_timer_start" );
                    }
                    
                    if ( !level.gametimerbeeps )
                    {
                        thread watchgametimer( var_35172e0eb29f440c );
                    }
                }
            }
            else if ( var_71b5bf2eb694eb30 == level.rushtimerteam && alliesflags == 1 || var_71b5bf2eb694eb30 == level.rushtimerteam && axisflags == 1 )
            {
                resumecountdowntimer( 1 );
            }
            else if ( level.rushtimer )
            {
                level.gametimerbeeps = 0;
                level.siegetimeleft = undefined;
                level.siegetimerstate = "reset";
                notifyplayers( "siege_timer_reset" );
                resumecountdowntimer( 1 );
            }
        }
    }
    
    self.prevteam = self.ownerteam;
}

// Namespace siege
// Params 0
// Checksum 0x4a368d7d, Offset: 0x46cc
// Size: 0x64
function watchgameinactive()
{
    level endon( #"game_ended" );
    level endon( #"flag_capturing" );
    timelimit = level.timelimit;
    
    if ( timelimit > 0 )
    {
        inactivetime = timelimit - 1;
        
        while ( inactivetime > 0 )
        {
            inactivetime -= 1;
            wait 1;
        }
        
        level.siegegameinactive = 1;
    }
}

// Namespace siege
// Params 0
// Checksum 0x3810ea9b, Offset: 0x4738
// Size: 0x33
function watchgamestart()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    while ( !havespawnedplayers() )
    {
        waitframe();
    }
    
    level.gamehasstarted = 1;
}

// Namespace siege
// Params 0
// Checksum 0xfdb991b9, Offset: 0x4773
// Size: 0xa0, Type: bool
function havespawnedplayers()
{
    if ( level.teambased )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( !teams::getteamdata( team, "hasSpawned" ) )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return level.maxplayercount > 1;
}

// Namespace siege
// Params 1
// Checksum 0x4bb727aa, Offset: 0x481c
// Size: 0xb1
function watchgametimer( gametime )
{
    level endon( #"game_ended" );
    level endon( #"hash_10739227c290845" );
    level endon( #"siege_timer_reset" );
    remainingtime = gametime;
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    clockobject hide();
    level.gametimerbeeps = 1;
    
    while ( remainingtime > 0 )
    {
        remainingtime -= 1;
        level.siegetimeleft = remainingtime;
        
        if ( remainingtime <= 30 )
        {
            if ( remainingtime != 0 )
            {
                clockobject playsound( "ui_mp_timer_countdown" );
            }
        }
        
        wait 1;
    }
    
    ontimelimit();
}

// Namespace siege
// Params 1
// Checksum 0xe6c6f344, Offset: 0x48d5
// Size: 0xae
function getflagcount( team )
{
    teamflags = 0;
    
    foreach ( flag in level.objectives )
    {
        if ( flag.ownerteam == team && !isbeingcaptured( flag ) )
        {
            teamflags += 1;
        }
    }
    
    return teamflags;
}

// Namespace siege
// Params 1
// Checksum 0xa67e374f, Offset: 0x498c
// Size: 0xb3
function isbeingcaptured( flag )
{
    var_b3916d2a96b09120 = 0;
    
    if ( isdefined( flag ) )
    {
        if ( level.siegeflagcapturing.size > 0 )
        {
            foreach ( flaglabel in level.siegeflagcapturing )
            {
                if ( flag.objectivekey == flaglabel )
                {
                    var_b3916d2a96b09120 = 1;
                }
            }
        }
    }
    
    return var_b3916d2a96b09120;
}

// Namespace siege
// Params 3
// Checksum 0x18a57709, Offset: 0x4a48
// Size: 0xde
function setwinner( team, reason, lossreason )
{
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        }
    }
    
    if ( isdefined( lossreason ) )
    {
        thread gamelogic_mp::endgame( team, game[ "end_reason" ][ reason ], game[ "end_reason" ][ lossreason ] );
        return;
    }
    
    thread gamelogic_mp::endgame( team, game[ "end_reason" ][ reason ] );
}

// Namespace siege
// Params 1
// Checksum 0x285f82da, Offset: 0x4b2e
// Size: 0x79
function onbeginuse( player )
{
    if ( !arraycontains( level.siegeflagcapturing, self.objectivekey ) )
    {
        level.siegeflagcapturing[ level.siegeflagcapturing.size ] = self.objectivekey;
        player setclientomnvar( "ui_objective_pinned_text_param", 1 );
        self.didstatusnotify = 0;
        gameobjects::setusetime( level.caprate );
    }
    
    level notify( #"flag_capturing", self );
}

// Namespace siege
// Params 1
// Checksum 0x6508373b, Offset: 0x4baf
// Size: 0x2d7
function onuse( credit_player )
{
    self.didstatusnotify = 0;
    team = credit_player.team;
    oldteam = gameobjects::getownerteam();
    otherteam = team_utility::getotherteam( team );
    self.capturetime = gettime();
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    thread obj_dom::updateflagstate( team, 0, team );
    obj_dom::setflagcaptured( team, oldteam, credit_player );
    level.usestartspawns = 0;
    
    if ( oldteam == "neutral" )
    {
        ownedflags = obj_dom::getteamflagcount( team );
        
        if ( ownedflags < level.objectives.size )
        {
            if ( ownedflags == 2 && level.numsiegeflags == 3 )
            {
                dialog::statusdialog( "friendly_captured_2", team );
                dialog::statusdialog( "enemy_captured_2", otherteam, 1 );
            }
            else
            {
                dialog::statusdialog( "secured" + self.objectivekey, team );
                dialog::statusdialog( "lost" + self.objectivekey, otherteam, 1 );
            }
        }
    }
    
    if ( obj_dom::getteamflagcount( team ) == level.objectives.size )
    {
        soundalias = "mp_dom_flag_captured_all";
    }
    else
    {
        soundalias = "mp_dom_flag_captured";
    }
    
    thread print::printandsoundoneveryone( team, otherteam, undefined, undefined, soundalias, "mp_dom_flag_lost", credit_player );
    thread giveflagcapturexp( self.touchlist[ team ], oldteam, credit_player );
    self.firstcapture = 0;
    
    if ( team_utility::isgameplayteam( team ) )
    {
        if ( level.teamdata[ team ][ "aliveCount" ] < level.teamdata[ team ][ "players" ].size )
        {
            foreach ( player in level.teamdata[ team ][ "players" ] )
            {
                player playlocalsound( "mp_bodycount_tick_positive" );
            }
            
            enemies = teams::getenemyplayers( team );
            
            foreach ( player in enemies )
            {
                player playlocalsound( "mp_bodycount_tick_negative" );
            }
        }
    }
    
    thread checkshouldplaymusic( team );
}

// Namespace siege
// Params 4
// Checksum 0xb282beb0, Offset: 0x4e8e
// Size: 0x136
function onuseupdate( team, progress, change, capplayer )
{
    ownerteam = gameobjects::getownerteam();
    
    if ( progress < 1 && !level.gameended && !self.captureblocked )
    {
        play_dom_capture_sfx( progress, team );
    }
    
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        if ( ownerteam == "neutral" )
        {
            dialog::statusdialog( "securing" + self.objectivekey, team );
            self.prevownerteam = team_utility::getotherteam( team );
        }
        else
        {
            dialog::statusdialog( "losing" + self.objectivekey, ownerteam, 1 );
            dialog::statusdialog( "securing" + self.objectivekey, team );
        }
        
        if ( !isagent( capplayer ) )
        {
            obj_dom::updateflagcapturestate( team );
        }
        
        gameobjects::setobjectivestatusicons( level.iconlosing, level.icontaking );
        self.didstatusnotify = 1;
    }
    
    level notify( #"flag_capturing", self );
}

// Namespace siege
// Params 1
// Checksum 0xf58331af, Offset: 0x4fcc
// Size: 0x89
function checkshouldplaymusic( team )
{
    playmusic = 0;
    teamflags = getflagcount( team );
    
    if ( level.numsiegeflags == 3 )
    {
        if ( teamflags == 2 )
        {
            playmusic = 1;
        }
    }
    else if ( teamflags == 4 )
    {
        playmusic = 1;
    }
    
    if ( playmusic )
    {
        level callback::callback( #"music_event", { #team:team, #event_type:#"dominating" } );
    }
}

// Namespace siege
// Params 2
// Checksum 0xbe1da932, Offset: 0x505d
// Size: 0x8d
function play_dom_capture_sfx( progress, team )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var_8eb35fb703d61a67 = "";
        progress = int( floor( progress * 10 ) );
        var_8eb35fb703d61a67 = "mp_dom_capturing_tick_0" + progress;
        self.visuals[ 0 ] playsoundtoteam( var_8eb35fb703d61a67, team );
    }
}

// Namespace siege
// Params 3
// Checksum 0xd9475405, Offset: 0x50f2
// Size: 0x103
function onenduse( team, player, success )
{
    self.didstatusnotify = 0;
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    }
    
    if ( success )
    {
        self.flagcapsuccess = 1;
    }
    else
    {
        self.flagcapsuccess = 0;
        resumecountdowntimer();
    }
    
    ownerteam = gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        gameobjects::setobjectivestatusicons( level.iconneutral );
        obj_dom::updateflagstate( "idle", 0 );
    }
    else
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        obj_dom::updateflagstate( ownerteam, 0 );
    }
    
    if ( !self.setblocking && !self.stalemate )
    {
        level.siegeflagcapturing = arrayremove( level.siegeflagcapturing, self.objectivekey );
    }
    
    thread waitthencheckendgame();
}

// Namespace siege
// Params 0
// Checksum 0xff46d355, Offset: 0x51fd
// Size: 0xa
function waitthencheckendgame()
{
    waitframe();
    checkendgame();
}

// Namespace siege
// Params 0
// Checksum 0x4bcb1e0d, Offset: 0x520f
// Size: 0x85
function oncontested()
{
    if ( !arraycontains( level.siegeflagcapturing, self.objectivekey ) )
    {
        level.siegeflagcapturing[ level.siegeflagcapturing.size ] = self.objectivekey;
    }
    
    gameobjects::setobjectivestatusicons( level.iconcontested );
    objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    obj_dom::updateflagstate( "contested", 0 );
    
    if ( level.rushtimerteam == self.ownerteam )
    {
        resumecountdowntimer();
    }
}

// Namespace siege
// Params 1
// Checksum 0xd30ba550, Offset: 0x529c
// Size: 0x141
function onuncontested( lastclaimteam )
{
    ownerteam = gameobjects::getownerteam();
    numtouching = gameobjects::getnumtouchingforteam( ownerteam );
    numother = gameobjects::getnumtouchingexceptteam( ownerteam );
    
    if ( numtouching && !numother )
    {
        level.siegeflagcapturing = arrayremove( level.siegeflagcapturing, self.objectivekey );
    }
    
    thread waitthencheckendgame();
    
    if ( ownerteam == "neutral" )
    {
        if ( lastclaimteam != "none" )
        {
            objidpoolmanager::objective_set_progress_team( self.objidnum, lastclaimteam );
        }
        else
        {
            objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
        }
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( self.objidnum, team_utility::getotherteam( ownerteam ) );
    }
    
    if ( lastclaimteam == "none" || ownerteam == "neutral" )
    {
        gameobjects::setobjectivestatusicons( level.iconneutral );
        self.didstatusnotify = 0;
    }
    else
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
    }
    
    flagstate = ownerteam == "neutral" ? "idle" : ownerteam;
    obj_dom::updateflagstate( flagstate, 0 );
}

// Namespace siege
// Params 0
// Checksum 0x9817d22, Offset: 0x53e5
// Size: 0x7b
function onunoccupied()
{
    ownerteam = gameobjects::getownerteam();
    level.siegeflagcapturing = arrayremove( level.siegeflagcapturing, self.objectivekey );
    thread waitthencheckendgame();
    
    if ( ownerteam == "neutral" )
    {
        gameobjects::setobjectivestatusicons( level.iconneutral );
        self.didstatusnotify = 0;
        return;
    }
    
    gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
}

// Namespace siege
// Params 1
// Checksum 0x38a42ba6, Offset: 0x5468
// Size: 0x5c
function onpinnedstate( player )
{
    if ( self.ownerteam != "neutral" && self.numtouching[ self.ownerteam ] && !self.stalemate )
    {
        gameobjects::setobjectivestatusicons( level.icondefending, level.iconcapture );
    }
}

// Namespace siege
// Params 1
// Checksum 0x8277a3f7, Offset: 0x54cc
// Size: 0xc5
function onunpinnedstate( player )
{
    if ( self.ownerteam != "neutral" && !self.numtouching[ self.ownerteam ] && !self.stalemate )
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
    }
    
    ownerteam = gameobjects::getownerteam();
    numtouching = gameobjects::getnumtouchingforteam( ownerteam );
    numother = gameobjects::getnumtouchingexceptteam( ownerteam );
    
    if ( numtouching && !numother )
    {
        level.siegeflagcapturing = arrayremove( level.siegeflagcapturing, self.objectivekey );
    }
    
    thread waitthencheckendgame();
}

// Namespace siege
// Params 1
// Checksum 0x1d1b5057, Offset: 0x5599
// Size: 0x96
function onstompeenemyprogressupdate( team )
{
    ownerteam = gameobjects::getownerteam();
    numtouching = gameobjects::getnumtouchingforteam( ownerteam );
    numother = gameobjects::getnumtouchingexceptteam( ownerteam );
    
    if ( numtouching && !numother )
    {
        level.siegeflagcapturing = arrayremove( level.siegeflagcapturing, self.objectivekey );
    }
    
    if ( level.rushtimerteam == self.ownerteam )
    {
        resumecountdowntimer();
        return;
    }
    
    resumecountdowntimer( 1 );
}

// Namespace siege
// Params 1
// Checksum 0x62965ca7, Offset: 0x5637
// Size: 0x40
function stompprogressreward( player )
{
    player thread rank::function_d2aa8986c506e985( #"defend" );
    player events::function_a7d373228760063b();
    gameobjects::setobjectivestatusicons( level.icondefending, level.iconcapture );
}

// Namespace siege
// Params 1
// Checksum 0x4702f6f3, Offset: 0x567f
// Size: 0x59
function ondeadevent( team )
{
    if ( game_utility_mp::gamehasstarted() )
    {
        if ( team == "all" )
        {
            ontimelimit();
            return;
        }
        
        if ( level.rushtimer && getflagcount( team ) == 2 )
        {
            return;
        }
        
        setwinner( game[ "attackers" ], "mp_faction_eliminated" );
    }
}

// Namespace siege
// Params 1
// Checksum 0xec3368ee, Offset: 0x56e0
// Size: 0x29
function ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    lastplayer thread givelastonteamwarning();
}

// Namespace siege
// Params 1
// Checksum 0xc8e5c6d4, Offset: 0x5711
// Size: 0x753
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    killid = deathdata.lifeid;
    
    if ( isdefined( victim.wasflagspawned ) )
    {
        victim.wasflagspawned = undefined;
    }
    
    if ( !isplayer( attacker ) || attacker.team == victim.team )
    {
        return;
    }
    
    if ( !flagownersalive( victim.team ) && obj_dom::getteamflagcount( victim.team ) == 2 )
    {
        dialog::statusdialog( "objs_capture", attacker.team, 1 );
    }
    
    var_a844077fc818e557 = 0;
    awardedassault = 0;
    awardeddefend = 0;
    victimteam = victim.team;
    victimpos = victim.origin;
    attackerteam = attacker.team;
    attackerpos = attacker.origin;
    
    if ( isdefined( einflictor ) )
    {
        attackerpos = einflictor.origin;
    }
    
    foreach ( trigger in attacker.touchtriggers )
    {
        objective = undefined;
        
        foreach ( obj in level.objectives )
        {
            if ( obj.trigger == trigger )
            {
                objective = obj;
                break;
            }
        }
        
        if ( !isdefined( objective ) )
        {
            continue;
        }
        
        ownerteam = objective.ownerteam;
        
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && attackerteam != ownerteam )
        {
            if ( !var_a844077fc818e557 )
            {
                var_a844077fc818e557 = 1;
            }
        }
    }
    
    foreach ( objective in level.objectives )
    {
        trigger = objective.trigger;
        ownerteam = objective.ownerteam;
        
        if ( ownerteam == "neutral" )
        {
            attackertouching = attacker istouching( trigger );
            victimtouching = victim istouching( trigger );
            
            if ( attackertouching || victimtouching )
            {
                if ( objective.claimteam == victimteam )
                {
                    if ( !awardedassault )
                    {
                        if ( var_a844077fc818e557 )
                        {
                            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
                        }
                        else
                        {
                            attacker thread rank::function_d2aa8986c506e985( #"assault" );
                            attacker events::function_58da673c1c3fc9f2();
                        }
                        
                        awardedassault = 1;
                        victim thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                        continue;
                    }
                }
                else if ( objective.claimteam == attackerteam )
                {
                    if ( !awardeddefend )
                    {
                        if ( var_a844077fc818e557 )
                        {
                            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
                        }
                        else
                        {
                            attacker thread rank::function_d2aa8986c506e985( #"defend" );
                            attacker events::function_20a5f572df6afd43();
                        }
                        
                        awardeddefend = 1;
                        
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                        {
                            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                            {
                                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                            {
                                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x52>" );
                            
                            if ( isdefined( attacker.pers[ "defends" ] ) )
                            {
                                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                            }
                        }
                        
                        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                        victim thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
                        continue;
                    }
                }
            }
            
            continue;
        }
        
        if ( ownerteam != attackerteam )
        {
            if ( !awardedassault )
            {
                giveassault = distsquaredcheck( trigger, attackerpos, victimpos );
                
                if ( giveassault )
                {
                    if ( var_a844077fc818e557 )
                    {
                        attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
                    }
                    else
                    {
                        attacker thread rank::function_d2aa8986c506e985( #"assault" );
                        attacker events::function_58da673c1c3fc9f2();
                    }
                    
                    awardedassault = 1;
                    victim thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                    continue;
                }
            }
            
            continue;
        }
        
        if ( !awardeddefend )
        {
            givedefend = distsquaredcheck( trigger, attackerpos, victimpos );
            
            if ( givedefend )
            {
                if ( var_a844077fc818e557 )
                {
                    attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
                }
                else
                {
                    attacker thread rank::function_d2aa8986c506e985( #"defend" );
                    attacker events::function_20a5f572df6afd43();
                }
                
                awardeddefend = 1;
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
                    {
                        attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
                    {
                        [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x52>" );
                    
                    if ( isdefined( attacker.pers[ "defends" ] ) )
                    {
                        attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                    }
                }
                
                attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                victim thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defending" );
            }
        }
    }
    
    thread checkallowspectating();
}

// Namespace siege
// Params 3
// Checksum 0xff45e74f, Offset: 0x5e6c
// Size: 0xc3
function distsquaredcheck( trigger, attackerpos, victimpos )
{
    var_239d2a4c215037cd = distancesquared( trigger.origin, attackerpos );
    var_675b1291697b281a = distancesquared( trigger.origin, victimpos );
    
    if ( var_239d2a4c215037cd < 105625 || var_675b1291697b281a < 105625 )
    {
        if ( !isdefined( trigger.modifieddefendcheck ) )
        {
            return 1;
        }
        else if ( attackerpos[ 2 ] - trigger.origin[ 2 ] < 100 || victimpos[ 2 ] - trigger.origin[ 2 ] < 100 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace siege
// Params 0
// Checksum 0x6df326da, Offset: 0x5f37
// Size: 0x98
function givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
}

// Namespace siege
// Params 0
// Checksum 0x6bda577, Offset: 0x5fd7
// Size: 0xb4
function ontimelimit()
{
    if ( isdefined( level.siegegameinactive ) )
    {
        level.forcedend = 1;
        thread gamelogic_mp::endgame( "none", game[ "end_reason" ][ "siege_force_end" ] );
        return;
    }
    
    alliesflags = getflagcount( "allies" );
    axisflags = getflagcount( "axis" );
    
    if ( alliesflags > axisflags )
    {
        setwinner( "allies", "siege_flag_win", "siege_flag_loss" );
        return;
    }
    
    if ( axisflags > alliesflags )
    {
        setwinner( "axis", "siege_flag_win", "siege_flag_loss" );
        return;
    }
    
    setwinner( "tie", "cyber_tie" );
}

// Namespace siege
// Params 2
// Checksum 0x29b1ed1a, Offset: 0x6093
// Size: 0x1b9
function teamrespawn( team, credit_player )
{
    if ( !isdefined( credit_player.rescuedplayers ) )
    {
        credit_player.rescuedplayers = [];
    }
    
    foreach ( player in level.participants )
    {
        if ( isdefined( player ) && player.team == team && !player::isreallyalive( player ) && !arraycontains( teams::getfriendlyplayers( player.team, 1 ), player ) && !player.waitingtoselectclass )
        {
            if ( isdefined( player.siegelatecomer ) && player.siegelatecomer )
            {
                player.siegelatecomer = 0;
            }
            
            if ( !player.pers[ "teamKillPunish" ] )
            {
                if ( player.wasflagspawned )
                {
                    continue;
                }
                
                player.wasflagspawned = 1;
                player thread playerlogic::waittillcanspawnclient( 0 );
                player thread rank::scoreeventpopup( #"revived" );
                level notify( #"sr_player_respawned", player );
                player dialog::leaderdialogonplayer( "revived" );
            }
            
            credit_player.rescuedplayers[ player.guid ] = 1;
        }
    }
    
    self.playersrevived = credit_player.rescuedplayers.size;
}

// Namespace siege
// Params 1
// Checksum 0x1ce8762e, Offset: 0x6254
// Size: 0x9c
function notifyplayers( notifystring )
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( notifystring );
    }
    
    level notify( #"match_ending_soon", "time" );
    level notify( notifystring );
}

// Namespace siege
// Params 3
// Checksum 0xced6df73, Offset: 0x62f8
// Size: 0x465
function giveflagcapturexp( touchlist, oldteam, credit_player )
{
    level endon( #"game_ended" );
    first_player = credit_player;
    
    if ( isdefined( first_player.owner ) )
    {
        first_player = first_player.owner;
    }
    
    level.lastcaptime = gettime();
    
    if ( isplayer( first_player ) )
    {
        level thread hud_util::teamplayercardsplash( "callout_securedposition" + self.objectivekey, first_player );
        telemetry_data = spawnstruct();
        telemetry_data.player = first_player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = first_player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    }
    
    players_touching = getarraykeys( touchlist );
    
    for ( index = 0; index < players_touching.size ; index++ )
    {
        player = touchlist[ players_touching[ index ] ].player;
        
        if ( isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player thread updatecpm();
        
        if ( player.cpm > 3 )
        {
            xpreward = 0;
            capreward = 0;
        }
        else if ( player.numcaps > 5 )
        {
            xpreward = 125;
            capreward = 50;
        }
        else if ( self.objectivekey == "_b" || oldteam != "neutral" || self.playersrevived > 0 )
        {
            xpreward = undefined;
            capreward = undefined;
        }
        else
        {
            xpreward = 125;
            capreward = 50;
        }
        
        player thread rank::scoreeventpopup( #"capture" );
        player thread points::doscoreevent( #"mode_siege_secure", undefined, capreward, xpreward );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "captures" ] ) )
            {
                player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
            {
                [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x52>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player stats::setextrascore0( player.pers[ "captures" ] );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "rescues" ] ) )
            {
                player.leaderboarddata[ "rescues" ] = player.leaderboarddata[ "rescues" ] + self.playersrevived;
            }
            
            if ( isdefined( level.leaderboardfunc[ "rescues" ] ) )
            {
                [[ level.leaderboardfunc[ "rescues" ] ]]( player, self.playersrevived );
            }
            
            assert( isint( self.playersrevived ) || isfloat( self.playersrevived ), "<dev string:x52>" );
            
            if ( isdefined( player.pers[ "rescues" ] ) )
            {
                player.pers[ "rescues" ] = player.pers[ "rescues" ] + self.playersrevived;
            }
        }
        
        player persistence::statsetchild( "round", "rescues", player.pers[ "rescues" ] );
        player stats::setextrascore1( player.pers[ "rescues" ] );
        wait 0.05;
    }
    
    self.playersrevived = 0;
}

// Namespace siege
// Params 0
// Checksum 0x1c90114a, Offset: 0x6765
// Size: 0x1d
function getcapxpscale()
{
    if ( self.cpm < 4 )
    {
        return 1;
    }
    
    return 0.25;
}

// Namespace siege
// Params 0
// Checksum 0xb3bb9934, Offset: 0x678a
// Size: 0x54
function updatecpm()
{
    if ( !isdefined( self.cpm ) )
    {
        self.numcaps = 0;
        self.cpm = 0;
    }
    
    self.numcaps++;
    
    if ( game_utility_mp::getminutespassed() < 1 )
    {
        return;
    }
    
    self.cpm = self.numcaps / game_utility_mp::getminutespassed();
}

// Namespace siege
// Params 0
// Checksum 0x975bf655, Offset: 0x67e6
// Size: 0x7b
function checkendgame()
{
    alliesflags = getflagcount( "allies" );
    axisflags = getflagcount( "axis" );
    
    if ( alliesflags == level.numsiegeflags )
    {
        setwinner( "allies", "siege_allflags_win", "siege_allflags_loss" );
        return;
    }
    
    if ( axisflags == level.numsiegeflags )
    {
        setwinner( "axis", "siege_allflags_win", "siege_allflags_loss" );
    }
}

// Namespace siege
// Params 1
// Checksum 0x33189048, Offset: 0x6869
// Size: 0x9bb
function runobjectives( numobjs )
{
    level.axisspawnareas = [ level.axishqname ];
    level.alliesspawnareas = [ level.allieshqname ];
    level.allfobs = [];
    
    foreach ( fob in level.gw_objstruct.startingfobs_axis )
    {
        activefob = runobjflag( fob.trigger, "axis" );
        level.allfobs[ level.allfobs.size ] = fob;
        level.axisspawnareas[ level.axisspawnareas.size ] = fob.name;
        
        if ( isdefined( level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity ) )
        {
            level.spawnselectionlocations[ fob.name ][ "axis" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
        }
    }
    
    foreach ( fob in level.gw_objstruct.startingfobs_allies )
    {
        activefob = runobjflag( fob.trigger, "allies" );
        level.allfobs[ level.allfobs.size ] = fob;
        level.alliesspawnareas[ level.alliesspawnareas.size ] = fob.name;
        
        if ( isdefined( level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity ) )
        {
            level.spawnselectionlocations[ fob.name ][ "allies" ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
        }
    }
    
    foreach ( fob in level.gw_objstruct.startingfobs_neutral )
    {
        if ( level.numsiegeflags == 3 )
        {
            if ( level.mapname == "mp_downtown_gw" )
            {
                if ( fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e" )
                {
                    continue;
                }
                else
                {
                    remapobjkeysandscriptlabels( fob.trigger );
                }
            }
            else if ( level.mapname == "mp_aniyah" )
            {
                if ( fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d" )
                {
                    continue;
                }
                else
                {
                    remapobjkeysandscriptlabels( fob.trigger );
                }
            }
            else if ( level.mapname == "mp_farms2_gw" )
            {
                if ( fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d" )
                {
                    continue;
                }
                else
                {
                    remapobjkeysandscriptlabels( fob.trigger );
                }
            }
            else if ( level.mapname == "mp_promenade_gw" )
            {
                if ( fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e" )
                {
                    continue;
                }
                else
                {
                    remapobjkeysandscriptlabels( fob.trigger );
                }
            }
            else if ( level.mapname == "mp_riverside_gw" )
            {
                if ( fob.trigger.objkey == "_b" || fob.trigger.objkey == "_d" )
                {
                    continue;
                }
                else
                {
                    remapobjkeysandscriptlabels( fob.trigger );
                }
            }
            else if ( fob.trigger.objkey == "_a" || fob.trigger.objkey == "_e" )
            {
                continue;
            }
            else
            {
                remapobjkeysandscriptlabels( fob.trigger );
            }
        }
        
        activefob = runobjflag( fob.trigger, "neutral" );
        level.allfobs[ level.allfobs.size ] = fob;
    }
    
    spawn_axis_start = spawnlogic::getspawnpointarray( "mp_gw_spawn_axis_start" );
    spawn_allies_start = spawnlogic::getspawnpointarray( "mp_gw_spawn_allies_start" );
    level.startpos[ "allies" ] = spawn_allies_start[ 0 ].origin;
    level.startpos[ "axis" ] = spawn_axis_start[ 0 ].origin;
    
    foreach ( fob in level.allfobs )
    {
        reservedobjid = obj_dom::getreservedobjid( fob.trigger.gameobject.objectivekey );
        fob.trigger.gameobject gameobjects::requestid( 1, 1, reservedobjid );
        fob.trigger.gameobject.onuse = &onuse;
        fob.trigger.gameobject.onbeginuse = &onbeginuse;
        fob.trigger.gameobject.onuseupdate = &onuseupdate;
        fob.trigger.gameobject.onenduse = &onenduse;
        fob.trigger.gameobject.oncontested = &oncontested;
        fob.trigger.gameobject.onuncontested = &onuncontested;
        fob.trigger.gameobject.onunoccupied = &onunoccupied;
        fob.trigger.gameobject.onpinnedstate = &onpinnedstate;
        fob.trigger.gameobject.onunpinnedstate = &onunpinnedstate;
        fob.trigger.gameobject.stompeenemyprogressupdate = &onstompeenemyprogressupdate;
        fob.trigger.gameobject.stompprogressreward = &stompprogressreward;
        fob.trigger.gameobject gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        fob.trigger.gameobject gameobjects::setvisibleteam( "any" );
        fob.trigger.gameobject obj_dom::domflag_setneutral();
        level.objectives[ fob.trigger.gameobject.objectivekey ] = fob.trigger.gameobject;
    }
    
    level.bestspawnflag = [];
    level.bestspawnflag[ "allies" ] = obj_dom::getunownedflagneareststart( "allies", undefined );
    level.bestspawnflag[ "axis" ] = obj_dom::getunownedflagneareststart( "axis", level.bestspawnflag[ "allies" ] );
    
    if ( level.precappoints )
    {
        obj_dom::precap( level.numsiegeflags == 5 );
    }
    
    dom::flagsetup();
    level thread objective_manageobjectivesintrovisibility();
    level thread arm::allowobjectiveuseaftermatchstart();
}

// Namespace siege
// Params 0
// Checksum 0x2c11494a, Offset: 0x722c
// Size: 0x13a
function objective_manageobjectivesintrovisibility()
{
    wait 1;
    
    foreach ( fob in level.allfobs )
    {
        objidpoolmanager::objective_playermask_hidefromall( fob.trigger.gameobject.objidnum );
    }
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    foreach ( fob in level.allfobs )
    {
        objidpoolmanager::objective_playermask_showtoall( fob.trigger.gameobject.objidnum );
    }
}

// Namespace siege
// Params 1
// Checksum 0x3781b977, Offset: 0x736e
// Size: 0x86a
function remapobjkeysandscriptlabels( objective )
{
    if ( level.mapname == "mp_downtown_gw" )
    {
        if ( objective.objkey == "_b" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_a";
            objective.objkey = "_a";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_c";
            objective.objkey = "_b";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_d" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_d";
            objective.objkey = "_c";
            objective.script_label = objective.objkey;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_boneyard_gw" )
    {
        if ( objective.objkey == "_b" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_b";
            objective.objkey = "_a";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_d" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_d";
            objective.objkey = "_b";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_c";
            objective.objkey = "_c";
            objective.script_label = objective.objkey;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_aniyah" )
    {
        if ( objective.objkey == "_a" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_a";
            objective.objkey = "_a";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_c";
            objective.objkey = "_b";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_e" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_e";
            objective.objkey = "_c";
            objective.script_label = objective.objkey;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_promenade_gw" )
    {
        if ( objective.objkey == "_b" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_b";
            objective.objkey = "_a";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_c";
            objective.objkey = "_b";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_d" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_e";
            objective.objkey = "_c";
            objective.script_label = objective.objkey;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_farms2_gw" )
    {
        if ( objective.objkey == "_a" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_a";
            objective.objkey = "_a";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_c";
            objective.objkey = "_b";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_e" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_e";
            objective.objkey = "_c";
            objective.script_label = objective.objkey;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_riverside_gw" )
    {
        if ( objective.objkey == "_a" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_a";
            objective.objkey = "_a";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_c";
            objective.objkey = "_b";
            objective.script_label = objective.objkey;
        }
        else if ( objective.objkey == "_e" && !isdefined( objective.oldkey ) )
        {
            objective.oldkey = "_e";
            objective.objkey = "_c";
            objective.script_label = objective.objkey;
        }
        
        return;
    }
    
    if ( objective.objkey == "_b" && !isdefined( objective.oldkey ) )
    {
        objective.oldkey = "_b";
        objective.objkey = "_a";
        objective.script_label = objective.objkey;
        return;
    }
    
    if ( objective.objkey == "_c" && !isdefined( objective.oldkey ) )
    {
        objective.oldkey = "_c";
        objective.objkey = "_b";
        objective.script_label = objective.objkey;
        return;
    }
    
    if ( objective.objkey == "_d" && !isdefined( objective.oldkey ) )
    {
        objective.oldkey = "_d";
        objective.objkey = "_c";
        objective.script_label = objective.objkey;
    }
}

// Namespace siege
// Params 2
// Checksum 0x9a1db2f3, Offset: 0x7be0
// Size: 0xd4
function runobjflag( objective, startingteam )
{
    level endon( #"game_ended" );
    objective.script_label = objective.objkey;
    domflag = obj_dom::setupobjective( objective, undefined, 1 );
    domflag.origin = objective.origin;
    domflag gameobjects::allowuse( "none" );
    domflag.didstatusnotify = 0;
    domflag gameobjects::setownerteam( startingteam );
    visibility = "any";
    
    if ( startingteam != "neutral" )
    {
        if ( level.hideenemyfobs )
        {
            visibility = "friendly";
        }
        
        domflag.capturetime = gettime();
    }
    
    domflag gameobjects::setvisibleteam( visibility );
    return domflag;
}

// Namespace siege
// Params 2
// Checksum 0xcd509821, Offset: 0x7cbd
// Size: 0x4b
function manageprematchfade( delay_time, var_4867050026bc2d98 )
{
    self endon( #"disconnect" );
    fadedownduration = 0;
    fadeupduration = 0.5;
    thread playerlogic::managerespawnfade( fadedownduration, fadeupduration );
}

/#

    // Namespace siege
    // Params 0
    // Checksum 0x895aee36, Offset: 0x7d10
    // Size: 0x10e, Type: dev
    function function_8d8d77f766c8bd7a()
    {
        self endon( #"game_ended" );
        setdevdvarifuninitialized( @"hash_1432c61b2a63cd8e", 0 );
        capplayer = undefined;
        
        while ( true )
        {
            if ( getdvarint( @"hash_1432c61b2a63cd8e", 0 ) != 0 )
            {
                foreach ( player in level.players )
                {
                    if ( player ishost() )
                    {
                        capplayer = player;
                        break;
                    }
                }
                
                level.objectives[ "<dev string:x78>" ] onuse( capplayer );
                wait 0.15;
                level.objectives[ "<dev string:x7b>" ] onuse( capplayer );
            }
            
            setdevdvar( @"hash_1432c61b2a63cd8e", 0 );
            wait 1;
        }
    }

    // Namespace siege
    // Params 0
    // Checksum 0x511033b1, Offset: 0x7e26
    // Size: 0x35f, Type: dev
    function removedompoint()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x7e>" ) != "<dev string:x7e>" )
            {
                flaglabel = getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x7e>" );
                
                foreach ( domflag in level.objectives )
                {
                    if ( isdefined( domflag.objectivekey ) && domflag.objectivekey == flaglabel )
                    {
                        domflag gameobjects::allowuse( "<dev string:x7f>" );
                        domflag.trigger = undefined;
                        domflag notify( #"deleted" );
                        
                        if ( isdefined( domflag.neutralflagfx ) )
                        {
                            domflag.neutralflagfx delete();
                        }
                        
                        foreach ( player in level.players )
                        {
                            foreach ( effect in player._domflageffect )
                            {
                                if ( isdefined( effect ) )
                                {
                                    effect delete();
                                }
                            }
                            
                            foreach ( pulseeffect in player._domflagpulseeffect )
                            {
                                if ( isdefined( pulseeffect ) )
                                {
                                    pulseeffect delete();
                                }
                            }
                        }
                        
                        domflag.visibleteam = "<dev string:x7f>";
                        domflag gameobjects::setobjectivestatusicons( undefined, undefined );
                        tempflags = [];
                        
                        foreach ( objective in level.objectives )
                        {
                            if ( objective.objectivekey != flaglabel )
                            {
                                tempflags[ tempflags.size ] = objective;
                            }
                        }
                        
                        level.objectives = tempflags;
                        break;
                    }
                }
                
                setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x7e>" );
            }
            
            wait 1;
        }
    }

    // Namespace siege
    // Params 0
    // Checksum 0xc6db0315, Offset: 0x818d
    // Size: 0x4f1, Type: dev
    function placedompoint()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x7e>" ) != "<dev string:x7e>" )
            {
                flaglabel = getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x7e>" );
                zone = spawnstruct();
                zone.origin = level.players[ 0 ].origin;
                zone.angles = level.players[ 0 ].angles;
                trigger = spawn( "<dev string:x84>", zone.origin, 0, 120, 128 );
                zone.trigger = trigger;
                zone.trigger.script_label = flaglabel;
                zone.ownerteam = "<dev string:x93>";
                tracestart = zone.origin + ( 0, 0, 32 );
                traceend = zone.origin + ( 0, 0, -32 );
                trace = trace::_bullet_trace( tracestart, traceend, 0, undefined );
                zone.origin = trace[ "<dev string:x9b>" ];
                zone.upangles = vectortoangles( trace[ "<dev string:xa4>" ] );
                zone.forward = anglestoforward( zone.upangles );
                zone.right = anglestoright( zone.upangles );
                zone.visuals[ 0 ] = spawn( "<dev string:xab>", zone.origin );
                zone.visuals[ 0 ].angles = zone.angles;
                domflag = gameobjects::createuseobject( "<dev string:x93>", zone.trigger, zone.visuals, ( 0, 0, 100 ) );
                domflag gameobjects::allowuse( "<dev string:xb8>" );
                domflag gameobjects::setusetime( level.caprate );
                
                if ( isdefined( trigger.objectivekey ) )
                {
                    domflag.objectivekey = trigger.objectivekey;
                }
                else
                {
                    domflag.objectivekey = domflag gameobjects::getlabel();
                }
                
                if ( isdefined( trigger.iconname ) )
                {
                    domflag.iconname = trigger.iconname;
                }
                else
                {
                    domflag.iconname = domflag gameobjects::getlabel();
                }
                
                domflag gameobjects::setobjectivestatusicons( "<dev string:xbe>", "<dev string:xce>" );
                domflag gameobjects::setvisibleteam( "<dev string:xe6>" );
                domflag gameobjects::cancontestclaim( 1 );
                domflag.onuse = &onuse;
                domflag.onbeginuse = &onbeginuse;
                domflag.onuseupdate = &onuseupdate;
                domflag.onenduse = &onenduse;
                domflag.oncontested = &oncontested;
                domflag.onuncontested = &onuncontested;
                domflag.onunoccupied = &obj_dom::dompoint_onunoccupied;
                domflag.onpinnedstate = &obj_dom::dompoint_onpinnedstate;
                domflag.onunpinnedstate = &obj_dom::dompoint_onunpinnedstate;
                domflag.stompprogressreward = &obj_dom::dompoint_stompprogressreward;
                domflag.nousebar = 1;
                domflag.id = "<dev string:xea>";
                domflag.firstcapture = 1;
                domflag.claimgracetime = 10000;
                domflag gameobjects::pinobjiconontriggertouch();
                tracestart = zone.visuals[ 0 ].origin + ( 0, 0, 32 );
                traceend = zone.visuals[ 0 ].origin + ( 0, 0, -32 );
                contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
                ignoreents = [];
                trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                domflag.baseeffectpos = trace[ "<dev string:x9b>" ];
                upangles = vectortoangles( trace[ "<dev string:xa4>" ] );
                domflag.baseeffectforward = anglestoforward( upangles );
                domflag obj_dom::initializematchrecording();
                domflag utility::delaythread( 1, &setneutral );
                level.objectives[ domflag.objectivekey ] = domflag;
                setdynamicdvar( @"hash_29d45d6822a1cf6d", "<dev string:x7e>" );
            }
            
            wait 1;
        }
    }

    // Namespace siege
    // Params 0
    // Checksum 0x6d87213f, Offset: 0x8686
    // Size: 0x649, Type: dev
    function domdebug()
    {
        spawnpoints = spawnlogic::getteamspawnpoints( "<dev string:xf2>" );
        ispathdataavailable = spawnlogic::ispathdataavailable();
        heightoffsetlines = ( 0, 0, 12 );
        heightoffsetnames = ( 0, 0, 64 );
        colors = [];
        colors[ 1 ] = ( 1, 0, 0 );
        colors[ 2 ] = ( 0, 1, 0 );
        colors[ 4 ] = ( 0, 0, 1 );
        colors[ 8 ] = ( 1, 1, 1 );
        colors[ 16 ] = ( 0, 0, 0 );
        colors[ 32 ] = ( 1, 1, 0 );
        colors[ 64 ] = ( 0, 1, 1 );
        colors[ 128 ] = ( 1, 0, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_domdebug" ) != 1 )
            {
                wait 1;
                continue;
            }
            
            while ( true )
            {
                if ( getdvarint( @"scr_domdebug" ) != 1 )
                {
                    break;
                }
                
                if ( !isdefined( level.players[ 0 ] ) )
                {
                    waitframe();
                    continue;
                }
                
                endpoints = [];
                endpoints[ 1 ] = [ level.objectives[ "<dev string:x78>" ] ];
                endpoints[ 2 ] = [ level.objectives[ "<dev string:x7b>" ] ];
                endpoints[ 4 ] = [ level.objectives[ "<dev string:xf7>" ] ];
                endpoints[ 8 ] = [ level.objectives[ "<dev string:xfa>" ] ];
                endpoints[ 16 ] = [ level.objectives[ "<dev string:xfd>" ] ];
                endpoints[ 32 ] = [ level.objectives[ "<dev string:x78>" ], level.objectives[ "<dev string:x7b>" ] ];
                endpoints[ 64 ] = [ level.objectives[ "<dev string:xf7>" ], level.objectives[ "<dev string:x7b>" ] ];
                endpoints[ 128 ] = [ level.objectives[ "<dev string:x78>" ], level.objectives[ "<dev string:xf7>" ] ];
                
                foreach ( spawnpoint in spawnpoints )
                {
                    spawnpointdata = spawnpoint.scriptdata;
                    
                    if ( !isdefined( spawnpointdata.nodearrays ) )
                    {
                        spawnpointdata.nodearrays = [];
                    }
                    
                    if ( ispathdataavailable )
                    {
                        foreach ( endpoint in endpoints[ spawnpoint.scriptdata.domflagassignments ] )
                        {
                            if ( !isdefined( spawnpointdata.nodearrays[ endpoint.spawnflagid ] ) )
                            {
                                spawnpointdata.nodearrays[ endpoint.spawnflagid ] = level.players[ 0 ] findpath( spawnpoint.origin, endpoint.curorigin );
                            }
                            
                            if ( !isdefined( spawnpointdata.nodearrays[ endpoint.spawnflagid ] ) || spawnpointdata.nodearrays[ endpoint.spawnflagid ].size == 0 )
                            {
                                continue;
                            }
                            
                            color = colors[ spawnpoint.scriptdata.domflagassignments ];
                            line( spawnpoint.origin + heightoffsetlines, spawnpointdata.nodearrays[ endpoint.spawnflagid ][ 0 ] + heightoffsetlines, color );
                            
                            for ( i = 0; i < spawnpointdata.nodearrays[ endpoint.spawnflagid ].size - 1 ; i++ )
                            {
                                line( spawnpointdata.nodearrays[ endpoint.spawnflagid ][ i ] + heightoffsetlines, spawnpointdata.nodearrays[ endpoint.spawnflagid ][ i + 1 ] + heightoffsetlines, color );
                            }
                        }
                        
                        continue;
                    }
                    
                    foreach ( endpoint in endpoints[ spawnpoint.scriptdata.domflagassignments ] )
                    {
                        line( endpoint.curorigin + heightoffsetlines, spawnpoint.origin + heightoffsetlines, ( 0.2, 0.2, 0.6 ) );
                    }
                }
                
                foreach ( flaglocation in level.objectives )
                {
                    if ( flaglocation == level.bestspawnflag[ "<dev string:x100>" ] )
                    {
                        print3d( flaglocation.trigger.origin + heightoffsetnames, "<dev string:x107>" );
                    }
                    
                    if ( flaglocation == level.bestspawnflag[ "<dev string:xf2>" ] )
                    {
                        print3d( flaglocation.trigger.origin + heightoffsetnames, "<dev string:x11e>" );
                    }
                }
                
                waitframe();
            }
        }
    }

#/
