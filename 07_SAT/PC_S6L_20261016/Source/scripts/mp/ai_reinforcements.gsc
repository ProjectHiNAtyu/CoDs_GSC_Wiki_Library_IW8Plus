// scripts\mp\ai_reinforcements.gsc  (hash_7b7e14c60a103ef9.gscc) (size: 47575 Bytes / 0xb9d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcccdbc91 (3436035217)
// size ...... 47575 (0xb9d7)
// includes .. 20  (offset: 0xafdf)
// strings ... 107 (offset: 0xb07f)
// dev strs .. 43  (offset: 0xb70f)
// exports ... 59  (offset: 0x8cd3)
// cseg ...... 0x73a + 0x8599 (0x8cd3)
// imports ... 186 (offset: 0x960b)
// animtree1 . 0   (offset: 0xb9d7)
// animtree2 . 0   (offset: 0xb9d7)
#using scripts\common\ai\stealth\enemy;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\dmz\star_system;
#using scripts\mp\flags;
#using scripts\mp\poi;

#namespace ai_reinforcements;

// Namespace ai_reinforcements
// Params 0
// Checksum 0xbfca05b0, Offset: 0x758
// Size: 0xc97
function reinforce_init()
{
    /#
        setdvar( @"hash_3c77de36070e314c", 0 );
        level.var_b3dd93a2c97992f0 = getdvarint( @"hash_b0cde04af6f25f1a", 0 );
    #/
    
    utility::registersharedfunc( #"reinforcement", #"hash_3872d7819878df58", &function_b939bd9525dd795b );
    level.var_22711d88c3be755c = getdvarint( @"hash_63c7f4543f03c1f2", 7 );
    level.var_4b3ac2cf122de201 = getdvarint( @"hash_65c413f748899d7f", 20 );
    level.var_e0e6df865005db87 = getdvarint( @"hash_9a629aeb212fa5eb", 10 );
    level.var_bd4c56ffc4412dbb = getdvarint( @"hash_6e2f481aa94d1169", 5 );
    level.var_40d0ef7679d01102 = getdvarint( @"hash_f45dce4613bc7eb8", 9 );
    level.var_92114727f367a690 = getdvarint( @"hash_b1921baf4f2acc49", 7 );
    level.reinforcementoptions = spawnstruct();
    level.reinforcementoptions.disablelist = [];
    level.var_a6df1f075a23375f = [];
    
    if ( getdvarint( @"hash_be15dbb5db51168a", 0 ) )
    {
        level.reinforcementoptions.disablelist[ level.reinforcementoptions.disablelist.size ] = "heli";
    }
    
    if ( getdvarint( @"hash_ef18872f775cbf51", 0 ) )
    {
        level.reinforcementoptions.disablelist[ level.reinforcementoptions.disablelist.size ] = "ground";
    }
    
    if ( getdvarint( @"hash_af2a5bcfeab0313a", 0 ) )
    {
        level.reinforcementoptions.disablelist[ level.reinforcementoptions.disablelist.size ] = "closet";
    }
    
    if ( getdvarint( @"hash_5ba4da9311ec46d", 0 ) )
    {
        level.reinforcementoptions.disablelist[ level.reinforcementoptions.disablelist.size ] = "para";
    }
    
    if ( getdvarint( @"hash_e61c7be770ae9de8", 1 ) )
    {
        level.reinforcementoptions.disablelist[ level.reinforcementoptions.disablelist.size ] = "elevator";
    }
    
    level.reinforcementoptions.var_af4ae51d05e56e0 = [];
    
    if ( getdvarint( @"hash_a00601dc39bf335d", 0 ) )
    {
        level.reinforcementoptions.var_af4ae51d05e56e0[ level.reinforcementoptions.var_af4ae51d05e56e0.size ] = "sedan";
    }
    
    if ( getdvarint( @"hash_606c2b2d9e94162d", 0 ) )
    {
        level.reinforcementoptions.var_af4ae51d05e56e0[ level.reinforcementoptions.var_af4ae51d05e56e0.size ] = "overland";
    }
    
    if ( getdvarint( @"hash_a116a13b4ae556c2", 0 ) )
    {
        level.reinforcementoptions.var_af4ae51d05e56e0[ level.reinforcementoptions.var_af4ae51d05e56e0.size ] = "cargo";
    }
    
    if ( getdvarint( @"hash_caad3249a4af6b4b", 0 ) )
    {
        level.reinforcementoptions.var_af4ae51d05e56e0[ level.reinforcementoptions.var_af4ae51d05e56e0.size ] = "techo";
    }
    
    if ( getdvarint( @"hash_c6458de3ac612272", 0 ) )
    {
        level.reinforcementoptions.var_af4ae51d05e56e0[ level.reinforcementoptions.var_af4ae51d05e56e0.size ] = "jltv";
    }
    
    level.reinforcementoptions.var_77c2302a0092fd70 = getdvarint( @"hash_6cf658b24a4f657", 5 );
    level.var_ee9d312af31ee3e6 = getdvar( @"hash_a8e4f619345dd4f", "none" );
    level.reinforcementoptions.var_d6bd12c59326681f = [];
    level.reinforcementoptions.var_d6bd12c59326681f[ 0 ] = [ "tier1_ground", "tier1_closet", "tier1_heli" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "0_chance" ] = [ 1, 2, 2 ];
    level.reinforcementoptions.var_d6bd12c59326681f[ 1 ] = [ "tier1_ground", "tier1_closet", "tier1_heli" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "1_chance" ] = [ 1, 1, 2 ];
    level.reinforcementoptions.var_d6bd12c59326681f[ 2 ] = [ "tier1_ground", "tier1_closet", "tier1_heli" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "2_chance" ] = [ 1, 1, 2 ];
    level.reinforcementoptions.var_d6bd12c59326681f[ 3 ] = [ "tier2_ground", "tier2_heli", "tier2_closet" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "3_chance" ] = [ 1, 3, 1 ];
    level.reinforcementoptions.var_d6bd12c59326681f[ 4 ] = [ "tier2_ground", "tier2_heli", "tier2_closet" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "4_chance" ] = [ 1, 3, 1 ];
    level.reinforcementoptions.var_d6bd12c59326681f[ 5 ] = [ "tier3_ground", "tier3_heli", "tier3_closet" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "5_chance" ] = [ 1, 2, 1 ];
    level.reinforcementoptions.var_d6bd12c59326681f[ 6 ] = [ "tier3_ground", "tier3_heli", "tier3_closet" ];
    level.reinforcementoptions.var_d6bd12c59326681f[ "6_chance" ] = [ 1, 2, 1 ];
    level.reinforcementoptions.var_2120c0a77dba8911 = [];
    level.reinforcementoptions.var_2120c0a77dba8911[ 0 ] = "tier1_ground";
    level.reinforcementoptions.var_2120c0a77dba8911[ 1 ] = "tier1_ground";
    level.reinforcementoptions.var_2120c0a77dba8911[ 2 ] = "tier2_heli";
    level.reinforcementoptions.var_2120c0a77dba8911[ 3 ] = "tier2_heli";
    level.reinforcementoptions.var_2120c0a77dba8911[ 4 ] = "tier2_heli";
    level.reinforcementoptions.var_2120c0a77dba8911[ 5 ] = "tier3_heli";
    level.reinforcementoptions.var_2120c0a77dba8911[ 6 ] = "tier3_heli";
    level.reinforcementoptions.secondarytier[ 0 ] = "none";
    level.reinforcementoptions.secondarytier[ 1 ] = "none";
    level.reinforcementoptions.secondarytier[ 2 ] = "tier2_2";
    level.reinforcementoptions.secondarytier[ 3 ] = "none";
    level.reinforcementoptions.secondarytier[ 4 ] = "tier3_1";
    level.reinforcementoptions.secondarytier[ 5 ] = "none";
    level.reinforcementoptions.secondarytier[ 6 ] = "none";
    level.reinforcementoptions.var_15f05597dbbc3801 = [];
    level.reinforcementoptions.var_15f05597dbbc3801[ "tier1" ] = [ %"hash_66be4f4ee63df510", %"hash_589e54b7d4954c7" ];
    level.reinforcementoptions.var_15f05597dbbc3801[ "tier2" ] = [ %"hash_66be4f4ee63df510", %"hash_589e54b7d4954c7" ];
    level.reinforcementoptions.var_15f05597dbbc3801[ "tier3" ] = [ %"hash_66be4f4ee63df510", %"hash_589e54b7d4954c7" ];
    level.reinforcementoptions.var_1946a53223a1147e[ 0 ] = 0;
    level.reinforcementoptions.var_1946a53223a1147e[ 1 ] = 25;
    level.reinforcementoptions.var_1946a53223a1147e[ 2 ] = 45;
    level.reinforcementoptions.var_1946a53223a1147e[ 3 ] = 65;
    level.reinforcementoptions.var_1946a53223a1147e[ 4 ] = 80;
    level.reinforcementoptions.var_1946a53223a1147e[ 5 ] = 95;
    level.reinforcementoptions.var_1946a53223a1147e[ 6 ] = 95;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 0 ] = 1500;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 1 ] = 1500;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 2 ] = 1024;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 3 ] = 512;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 4 ] = 512;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 5 ] = 128;
    level.reinforcementoptions.var_3c17fb08cc27f877[ 6 ] = 128;
    level.reinforcementoptions.var_332c180f176a5288[ 0 ] = 1;
    level.reinforcementoptions.var_332c180f176a5288[ 1 ] = 1;
    level.reinforcementoptions.var_332c180f176a5288[ 2 ] = 1;
    level.reinforcementoptions.var_332c180f176a5288[ 3 ] = 0.5;
    level.reinforcementoptions.var_332c180f176a5288[ 4 ] = 0.2;
    level.reinforcementoptions.var_332c180f176a5288[ 5 ] = 0.1;
    level.reinforcementoptions.var_332c180f176a5288[ 6 ] = 0.1;
    level.var_adebcd3cc511b080 = getdvarfloat( @"hash_af12ddaae716e0bb", 8 ) * 1000;
    level.reinforcementoptions.var_63bcdb3abec1ac73 = [];
    level.reinforcementoptions.var_63bcdb3abec1ac73[ %"hash_3dff816eedc0901c" ] = [ "black" ];
    level.reinforcementoptions.var_63bcdb3abec1ac73[ %"hash_38fe1c7502792874" ] = [ "black" ];
    level.var_c606dcf2882e883d = 1048576;
    level.var_d2ab896b653d8dd0 = 20000;
    function_1812fb4b110d706e();
    utility::callsharedfunc( #"reinforcement", #"override" );
    level.var_eba22ed94ea6dae9 = 0;
    level.var_1cbf5a9865b66dea = getdvarint( @"hash_9ad5dbdd1dfb3fac", 3 );
    level.var_2cd6aaf6ae3a56bb = 0;
    level.var_5d17c11d996f811c = 0;
    level.var_514e64489647724b = getdvarint( @"hash_bbb1bddaa8b9b5e3", 45 );
    level.var_329705c814e762cf = getdvarint( @"hash_a28fc6fefeca8d04", 30 ) * 1000;
    level.var_477715688f562bf0 = getdvarint( @"hash_95b63abf931aaca6", 1 );
    level.var_80ce5b5bc9eb2e4b = getdvarint( @"hash_a94cd203ec30eb73", 1 );
    level.var_da02bb24370fd73 = [];
    level.var_3dd9db24e4281c99 = [];
    level.var_ddfe07e6e98d74df = utility::getstructarray( "defend_smoke_spawn_loc", "script_noteworthy" );
    
    /#
        level.var_95a3e1453148b015 = 0;
        
        if ( level.var_477715688f562bf0 )
        {
            level thread function_9077c36b2171f937();
        }
        
        level thread function_855aeffb82f117b0();
    #/
}

// Namespace ai_reinforcements
// Params 18
// Checksum 0xa3ff9393, Offset: 0x13f7
// Size: 0x81c
function reinforce_requestreinforcements( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, reinforcementtype, goalradius, var_349676481fc57c94, var_6fc710600b539c60, nationality, var_2f251312d1f96bb3 = 0, tags, var_45009a6d8bfd6637, covernodetag )
{
    if ( !level.supportsai )
    {
        return;
    }
    
    if ( isdefined( level.radiation ) && level.radiation.spreading )
    {
        return;
    }
    
    assert( flags::gameflagexists( "<dev string:x24>" ) && flags::gameflag( "<dev string:x24>" ), "<dev string:x32>" );
    
    if ( !isvector( reinforceorigin ) )
    {
        assertmsg( "<dev string:xb5>" );
        return;
    }
    else if ( !isstring( category ) )
    {
        assertmsg( "<dev string:xd2>" );
        return;
    }
    
    agents = [];
    
    if ( !isdefined( team ) )
    {
        nationality = utility::callsharedfunc( #"poi", #"hash_e8d82f43da156688", undefined, subarea );
        team = agent_utils::function_25b40f5accbca0dd( nationality );
    }
    
    if ( !isdefined( reinforcementtype ) )
    {
        reinforcementtype = "Unknown";
    }
    
    reinforcementoptions = undefined;
    var_3144745bfece99e0 = undefined;
    fallback = undefined;
    
    if ( poi::poi_issystemactive() )
    {
        if ( !isdefined( subarea ) )
        {
            subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", reinforceorigin );
        }
    }
    
    if ( !var_6fc710600b539c60.starlevel )
    {
        starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
    }
    else
    {
        starlevel = var_6fc710600b539c60.starlevel;
    }
    
    if ( isdefined( var_6fc710600b539c60 ) )
    {
        numagents = var_6fc710600b539c60.numagents;
        
        if ( var_6fc710600b539c60.reinforcementtype )
        {
            reinforcementtype = var_6fc710600b539c60.reinforcementtype;
            reinforcementoptions = [ var_6fc710600b539c60.reinforcementtype ];
            var_3144745bfece99e0 = [ 100 ];
        }
    }
    
    if ( reinforcementtype == "Unknown" || !reinforcementtype )
    {
        if ( level.var_940aa51ab4b20f5d )
        {
            level.reinforcementoptions.var_d6bd12c59326681f[ "tier1" ] = [ "tier1_ground", "tier1_heli" ];
            level.reinforcementoptions.var_d6bd12c59326681f[ "tier1_chance" ] = [ 1, 1 ];
            level.reinforcementoptions.var_d6bd12c59326681f[ "tier2" ] = [ "tier2_ground", "tier2_heli" ];
            level.reinforcementoptions.var_d6bd12c59326681f[ "tier2_chance" ] = [ 1, 1 ];
            level.reinforcementoptions.var_d6bd12c59326681f[ "tier3" ] = [ "tier3_ground", "tier3_heli" ];
            level.reinforcementoptions.var_d6bd12c59326681f[ "tier3_chance" ] = [ 1, 1 ];
            level.reinforcementoptions.var_2120c0a77dba8911[ "tier1" ] = "tier1_heli";
            level.reinforcementoptions.var_2120c0a77dba8911[ "tier2" ] = "tier2_heli";
            level.reinforcementoptions.var_2120c0a77dba8911[ "tier3" ] = "tier3_heli";
            level.reinforcementoptions.secondarytier[ 0 ] = "none";
            level.reinforcementoptions.secondarytier[ 1 ] = "none";
            level.reinforcementoptions.secondarytier[ 2 ] = "none";
            level.reinforcementoptions.secondarytier[ 3 ] = "none";
            level.reinforcementoptions.secondarytier[ 4 ] = "none";
            level.reinforcementoptions.secondarytier[ 5 ] = "none";
            reinforcementoptions = level.reinforcementoptions.var_d6bd12c59326681f[ level.var_6c32e5d8baac049b ];
            var_3144745bfece99e0 = level.reinforcementoptions.var_d6bd12c59326681f[ level.var_6c32e5d8baac049b + "_chance" ];
            fallback = level.reinforcementoptions.var_2120c0a77dba8911[ level.var_6c32e5d8baac049b ];
        }
        else if ( !var_6fc710600b539c60.reinforcementtype )
        {
            if ( level.var_3bd90ba443220384[ subarea.subareaname ][ starlevel ] )
            {
                var_a7a580230edaad5 = level.var_3bd90ba443220384[ subarea.subareaname ];
            }
            else
            {
                var_a7a580230edaad5 = level.reinforcementoptions.var_d6bd12c59326681f;
            }
            
            reinforcementoptions = arraycopy( var_a7a580230edaad5[ starlevel ] );
            var_3144745bfece99e0 = arraycopy( var_a7a580230edaad5[ starlevel + "_chance" ] );
            
            if ( level.var_3e12ef82c4fc024c[ subarea.subareaname ] )
            {
                var_a7a580230edaad5 = level.var_3e12ef82c4fc024c[ subarea.subareaname ];
            }
            else
            {
                var_a7a580230edaad5 = level.reinforcementoptions.var_2120c0a77dba8911;
            }
            
            fallback = var_a7a580230edaad5[ starlevel ];
        }
    }
    
    if ( reinforcementtype != "Unknown" )
    {
        agents = function_1faa63a0b398c676( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, reinforcementtype, goalradius, var_349676481fc57c94, var_6fc710600b539c60, nationality, var_2f251312d1f96bb3, tags, var_45009a6d8bfd6637, covernodetag );
    }
    else
    {
        while ( reinforcementoptions.size > 0 && ( !isdefined( agents ) || agents.size == 0 ) )
        {
            index = function_e8e38d007de82a8f( reinforcementoptions, var_3144745bfece99e0 );
            reinforcementtype = reinforcementoptions[ index ];
            
            if ( !isdefined( var_6fc710600b539c60 ) )
            {
                maintier = int( getsubstr( reinforcementtype, 4, 5 ) );
                secondarytier = undefined;
                var_55f1015bf9eecc25 = undefined;
                
                if ( level.reinforcementoptions.secondarytier[ starlevel ] != "none" )
                {
                    secondarytier = int( getsubstr( level.reinforcementoptions.secondarytier[ starlevel ], 4, 5 ) );
                    var_98eaee355e701cbf = int( getsubstr( level.reinforcementoptions.secondarytier[ starlevel ], 6, 7 ) );
                }
                
                var_6fc710600b539c60 = function_c6a741f41aaede19( numagents, undefined, maintier, level.defaultspawnset, secondarytier, var_98eaee355e701cbf );
            }
            
            agents = function_1faa63a0b398c676( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, reinforcementtype, goalradius, var_349676481fc57c94, var_6fc710600b539c60, nationality, var_2f251312d1f96bb3, tags, var_45009a6d8bfd6637, covernodetag );
            
            if ( !isdefined( agents ) || agents.size == 0 )
            {
                reinforcementoptions[ index ] = undefined;
                
                if ( isint( index ) )
                {
                    function_cdc669dbc8ea2101( reinforcementoptions );
                }
                
                var_3144745bfece99e0[ index ] = undefined;
                
                if ( isint( index ) )
                {
                    function_cdc669dbc8ea2101( var_3144745bfece99e0 );
                }
                
                if ( reinforcementoptions.size == 0 && isdefined( fallback ) )
                {
                    if ( level.var_b3dd93a2c97992f0 )
                    {
                        println( "<dev string:xe8>" + subarea.subareaname + "<dev string:xfc>" );
                    }
                    
                    reinforcementoptions = [ fallback ];
                    var_3144745bfece99e0 = [ 100 ];
                    fallback = undefined;
                }
                
                continue;
            }
            
            break;
        }
    }
    
    var_2c6e42e91a51e816 = isarray( agents ) && agents.size > 0 && isai( agents[ getarraykey( agents, 0 ) ] );
    
    if ( var_2c6e42e91a51e816 )
    {
        poiname = poi::poi_findpoioriginisin( reinforceorigin );
        
        if ( poiname )
        {
            if ( category == "mission" )
            {
                level thread star_system::function_c7a5d1fd397934a0( poiname, agents );
            }
            
            if ( !isdefined( level.startracker[ poiname ].reinforcementsactive ) )
            {
                level.startracker[ poiname ].reinforcementsactive = 1;
            }
        }
        
        agents[ 0 ].reinforcementtype = reinforcementtype;
    }
    
    return agents;
}

// Namespace ai_reinforcements
// Params 19
// Checksum 0xb8420526, Offset: 0x1c1c
// Size: 0x78c
function function_1faa63a0b398c676( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, reinforcementtype, goalradius, var_349676481fc57c94, var_6fc710600b539c60, nationality, var_2f251312d1f96bb3 = 0, tags, var_45009a6d8bfd6637, covernodetag, specificvehicletype )
{
    if ( !isdefined( level.reinforcementoptions ) )
    {
        return;
    }
    
    agents = undefined;
    vehicle = undefined;
    
    if ( isdefined( nationality ) )
    {
        team = agent_utils::function_25b40f5accbca0dd( nationality );
    }
    
    if ( issubstr( reinforcementtype, "closet" ) || reinforcementtype == "Monster Closet" )
    {
        agents = closet_requestreinforcements( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, undefined, undefined, undefined, nationality );
    }
    else if ( ( issubstr( reinforcementtype, "ground" ) || reinforcementtype == "Ground Vehicle" ) && level.var_d7316fc4c7d2e90c )
    {
        if ( !level.reinforcementoptions.var_f74d7b5e24620f33 )
        {
            level.reinforcementoptions.var_f74d7b5e24620f33 = 1;
            
            foreach ( index, tier in level.reinforcementoptions.var_15f05597dbbc3801 )
            {
                level.reinforcementoptions.var_15f05597dbbc3801[ index ] = arrayremove( tier, level.reinforcementoptions.var_af4ae51d05e56e0 );
            }
        }
        
        if ( specificvehicletype )
        {
            vehicleoverrides = [ specificvehicletype ];
        }
        else if ( isdefined( level.var_ee9d312af31ee3e6 ) && level.var_ee9d312af31ee3e6 != "none" )
        {
            vehicleoverrides = [ level.var_ee9d312af31ee3e6 ];
        }
        else
        {
            vehicletier = getsubstr( reinforcementtype, 0, 5 );
            
            if ( !isdefined( level.reinforcementoptions.var_15f05597dbbc3801[ vehicletier ] ) )
            {
                if ( isdefined( var_6fc710600b539c60 ) && isdefined( var_6fc710600b539c60.requests[ 0 ] ) && isdefined( var_6fc710600b539c60.requests[ 0 ].tier ) )
                {
                    vehicletier = "tier" + var_6fc710600b539c60.requests[ 0 ].tier;
                }
                else
                {
                    vehicletier = "tier" + ai_mp_controller::function_b5b96d25a6551932( undefined, subarea, reinforceorigin );
                }
            }
            
            vehicleoverrides = level.reinforcementoptions.var_15f05597dbbc3801[ vehicletier ];
        }
        
        agents = [[ utility::getsharedfunc( #"ground", #"requestReinforcements" ) ]]( numagents, var_6fc710600b539c60, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, nationality, vehicleoverrides );
    }
    else if ( ( issubstr( reinforcementtype, "heli" ) || reinforcementtype == "Helicopter" ) && level.var_5261767313e4e145 )
    {
        if ( specificvehicletype )
        {
            vehicleoverrides = [ specificvehicletype ];
        }
        
        agents = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, goalradius, var_349676481fc57c94, var_6fc710600b539c60, undefined, var_45009a6d8bfd6637, nationality, vehicleoverrides, var_2f251312d1f96bb3, tags );
    }
    else if ( ( issubstr( reinforcementtype, "para" ) || reinforcementtype == "Paratroopers" ) && isdefined( level.parareinforcestruct ) )
    {
        agents = [[ utility::getsharedfunc( #"para", #"requestReinforcements" ) ]]( numagents, reinforceorigin, 10000, var_6fc710600b539c60, priority, category, subcategory, team, var_6d02049e49f1e1a0, subarea, undefined, undefined, undefined, undefined, undefined, undefined, nationality );
    }
    else if ( ( issubstr( reinforcementtype, "elevator" ) || reinforcementtype == "Elevator" ) && ( level.var_99b3ff6b099dcb03 || level.reinforceelevators.size > 0 ) )
    {
        overridetier = undefined;
        
        if ( issubstr( reinforcementtype, "tier" ) )
        {
            tokens = strtok( reinforcementtype, "_" );
            
            foreach ( token in tokens )
            {
                if ( issubstr( token, "tier" ) && token.size > 4 )
                {
                    tiernum = int( getsubstr( token, 4, token.size ) );
                    
                    if ( tiernum >= 1 && tiernum <= 3 )
                    {
                        overridetier = tiernum;
                    }
                    
                    break;
                }
            }
        }
        
        agents = [[ utility::getsharedfunc( #"elevator", #"requestReinforcements" ) ]]( numagents, var_6fc710600b539c60, reinforceorigin, priority, category, subcategory, groupname, team, subarea, nationality, overridetier, covernodetag );
    }
    
    var_2c6e42e91a51e816 = isarray( agents ) && agents.size > 0 && isai( agents[ getarraykey( agents, 0 ) ] );
    
    if ( var_2c6e42e91a51e816 )
    {
        foreach ( index, agent in agents )
        {
            if ( !agent || !isai( agent ) || !isalive( agent ) )
            {
                agents[ index ] = undefined;
                continue;
            }
            
            agent enemy::bt_set_stealth_state( "combat", undefined );
            controlleanout = issubstr( reinforcementtype, "ground" );
            agent thread ai_behavior::function_d5e7cf61659cb6e( agent, undefined, undefined, controlleanout );
        }
    }
    
    data = spawnstruct();
    data.agents = agents;
    data.poiname = subarea.subareaname;
    data.origin = reinforceorigin;
    telemetry_utils::function_af2d366f9522f76f( "callback_dmz_on_reinforce", data );
    numagents = isarray( numagents ) ? numagents.size : numagents;
    
    if ( numagents > agents.size && level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_437887e88d7deb43 )
    {
        level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_437887e88d7deb43 += numagents - agents.size;
    }
    
    if ( level.var_4b49553b9fd31e8d && level.var_4b49553b9fd31e8d[ subarea.subareaname ] )
    {
        level thread [[ level.var_4b49553b9fd31e8d[ subarea.subareaname ] ]]( reinforcementtype );
    }
    
    return agents;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xc7c5aa13, Offset: 0x23b1
// Size: 0x123
function function_e8e38d007de82a8f( reinforcementoptions, var_3144745bfece99e0 )
{
    totaltickets = 0;
    
    foreach ( itemtickets in var_3144745bfece99e0 )
    {
        totaltickets += itemtickets;
    }
    
    roll = randomint( totaltickets );
    ticketschecked = 0;
    
    foreach ( index, reinforcementtype in reinforcementoptions )
    {
        ticketschecked += var_3144745bfece99e0[ index ];
        
        if ( roll < ticketschecked )
        {
            return index;
        }
    }
}

// Namespace ai_reinforcements
// Params 0
// Checksum 0x1a87207f, Offset: 0x24dc
// Size: 0x255
function function_3e5c6e84814e5108()
{
    if ( getdvarint( @"hash_c121e4a8e6b78c34", 0 ) == 1 )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    level.var_5b8d2ce323476cc7 = getdvarint( @"hash_3d859bf85679053c", 200 ) * 1000;
    level.var_de6ddfa46d3f97a9 = [];
    level.var_acfec34990aa3c0a = [];
    
    foreach ( areaname, area in level.areas )
    {
        level.var_de6ddfa46d3f97a9[ areaname ] = [];
        level.var_acfec34990aa3c0a[ areaname ] = [];
        
        foreach ( subareaname, subarea in area[ "subAreas" ] )
        {
            level.var_de6ddfa46d3f97a9[ areaname ][ subareaname ] = 0;
            level.var_de6ddfa46d3f97a9[ areaname ][ subareaname ] = 0;
        }
    }
    
    level.var_f15ee21b463afe2b = getdvarint( @"hash_599c5453cd5cd717", 240 ) * 1000;
    
    if ( poi::poi_issystemactive() )
    {
        foreach ( subarea in level.subareas )
        {
            if ( subarea.var_d4b3247c36826678 )
            {
                continue;
            }
            
            if ( isdefined( subarea.tuning.var_22c3e564e5b0795d ) && !subarea.tuning.var_22c3e564e5b0795d )
            {
                subarea.var_d4b3247c36826678 = 1;
                continue;
            }
            
            level thread function_1152936158631aec( subarea );
        }
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x788512ce, Offset: 0x2739
// Size: 0x331
function function_1152936158631aec( subarea )
{
    subareaname = subarea.subareaname;
    areaname = subarea.areaname;
    level.aibudgets.areas[ areaname ][ subareaname ].var_df674af4a77a2361 = getdvarint( @"hash_69535aa7c07dd140", 5 );
    level.aibudgets.areas[ areaname ][ subareaname ].reinforcementqueue = [];
    level.aibudgets.areas[ areaname ][ subareaname ].var_f69986e46c50ba53 = 0;
    level.aibudgets.areas[ areaname ][ subareaname ].var_71a0da72a95d69a = [];
    level.aibudgets.areas[ areaname ][ subareaname ].reinforcementlocs = [];
    level.aibudgets.areas[ areaname ][ subareaname ].var_aa73bfa8d1ecba54 = [];
    level.aibudgets.areas[ areaname ][ subareaname ].var_7f9a2bfd48246871 = 0;
    level.aibudgets.areas[ areaname ][ subareaname ].var_3068dadbd9f67325 = 0;
    level.aibudgets.areas[ areaname ][ subareaname ].var_5d8751db294ae491 = 0;
    level.aibudgets.areas[ areaname ][ subareaname ].var_65bb55dc2eb1d1db = [];
    level.aibudgets.areas[ areaname ][ subareaname ].var_e85d6ff0725889ea = -1;
    level.aibudgets.areas[ areaname ][ subareaname ].shutdowninterval = int( subarea.tuning.var_2fdda594ff89a52d * 0.66 );
    level.aibudgets.areas[ areaname ][ subareaname ].var_437887e88d7deb43 = 0;
    level.aibudgets.areas[ areaname ][ subareaname ].reinforcementpoints = 0;
    
    if ( getdvarint( @"hash_8ec821e080a0b50d", 1 ) == 1 )
    {
        level.var_de6ddfa46d3f97a9[ areaname ][ subareaname ] = gettime();
        level.var_acfec34990aa3c0a[ areaname ][ subareaname ] = 0;
    }
    
    level.aibudgets.areas[ areaname ][ subareaname ].var_f20b3aa2ef5b6d6c = "Initalizing";
    level thread function_e21bbcb055d11620( subarea );
    var_b0d2cbabc814f61a = getdvarint( @"hash_3bb3561ddb301247", 240 ) + randomintrange( 0, 15 );
    level thread function_76b1f3a7ba935088( subarea, var_b0d2cbabc814f61a, "Initial Delay" );
    wait var_b0d2cbabc814f61a;
    
    while ( level.aibudgets.areas[ areaname ][ subareaname ].reinforcepoints < 4 )
    {
        waitframe();
    }
    
    level thread function_1d1b796dd0e8f226( subarea );
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xe65be7, Offset: 0x2a72
// Size: 0x52a
function function_1d1b796dd0e8f226( subarea )
{
    level endon( #"game_ended" );
    level endon( #"dmz_radiation_started" );
    var_3e156a1bccd65dd1 = getdvarint( @"hash_5f174bbb593ef9f4", 45 );
    var_59ac7c480cfe8e30 = getdvarint( @"hash_623de28f7e6a71a2", 10 );
    subareaname = subarea.subareaname;
    areaname = subarea.areaname;
    reinforcestruct = level.aibudgets.areas[ areaname ][ subareaname ];
    
    while ( true )
    {
        if ( !subarea.isshutdown )
        {
            while ( reinforcestruct.reinforcementpoints <= 4 )
            {
                waitframe();
            }
            
            reinforceorigin = function_f7a78ac2acd50894( subarea );
            
            if ( isplayer( reinforceorigin ) )
            {
                var_c9bd53c23737bfa4 = reinforceorigin;
                reinforceorigin = var_c9bd53c23737bfa4.origin;
            }
            
            if ( isdefined( reinforceorigin ) )
            {
                nextincrement = reinforcestruct.reinforcementqueue[ 0 ];
                reinforcestruct.var_f20b3aa2ef5b6d6c = "Queue Activated. Reinforcements requested.";
                nationality = utility::callsharedfunc( #"poi", #"hash_e8d82f43da156688", undefined, subarea );
                
                if ( !isdefined( nationality ) )
                {
                    nationality = level.var_6c24585cf7e38ab9;
                }
                
                if ( level.var_b3dd93a2c97992f0 )
                {
                    println( "<dev string:x116>" + subareaname + "<dev string:x130>" + gettime() );
                }
                
                agents = reinforce_requestreinforcements( nextincrement, reinforceorigin, "medium", "reinforcements", undefined, undefined, undefined, undefined, subarea, undefined, undefined, undefined, undefined, nationality );
                
                if ( agents.size > 0 )
                {
                    poiname = poi::poi_findpoioriginisin( reinforceorigin );
                    
                    if ( poiname )
                    {
                        level thread function_cc09697b3048416b( poiname, reinforceorigin, subarea, var_c9bd53c23737bfa4 );
                    }
                    
                    if ( subarea.livingagents.size < subarea.tuning.var_9f21e8ffde4930f )
                    {
                        if ( isdefined( function_f7a78ac2acd50894( subarea ) ) )
                        {
                            reinforceorigin = function_f7a78ac2acd50894( subarea );
                        }
                        
                        extraagents = reinforce_requestreinforcements( nextincrement, reinforceorigin, "medium", "reinforcements", undefined, undefined, undefined, undefined, subarea, undefined, undefined, undefined, undefined, nationality );
                    }
                    
                    agents = arraycombine( agents, extraagents );
                    
                    if ( var_c9bd53c23737bfa4 )
                    {
                        foreach ( agent in agents )
                        {
                            if ( !agent.stealth_enabled )
                            {
                                continue;
                            }
                            
                            agent thread ai_behavior::behavior_pushplayer( var_c9bd53c23737bfa4, agent, undefined, undefined, subarea );
                        }
                    }
                    
                    reinforcestruct.reinforcementqueue[ 0 ] = undefined;
                    function_cdc669dbc8ea2101( reinforcestruct.reinforcementqueue );
                    
                    if ( subarea.var_ee24fa1e4b6ae66 )
                    {
                        if ( !subarea.var_438cbd0cee5eec0f )
                        {
                            subarea.var_438cbd0cee5eec0f = 0;
                        }
                        
                        subarea.var_438cbd0cee5eec0f++;
                        
                        if ( subarea.var_438cbd0cee5eec0f >= 3 )
                        {
                            subarea.var_ee24fa1e4b6ae66 = 0;
                            subarea.var_438cbd0cee5eec0f = 0;
                            delaytime = var_3e156a1bccd65dd1 + randomfloatrange( var_59ac7c480cfe8e30 * -1, var_59ac7c480cfe8e30 );
                            starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
                            delaytime *= level.reinforcementoptions.var_332c180f176a5288[ starlevel ];
                        }
                        else
                        {
                            delaytime = 0.1;
                        }
                    }
                    else if ( subarea.isshutdown )
                    {
                        continue;
                    }
                    else
                    {
                        delaytime = var_3e156a1bccd65dd1 + randomfloatrange( var_59ac7c480cfe8e30 * -1, var_59ac7c480cfe8e30 );
                        starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
                        delaytime *= level.reinforcementoptions.var_332c180f176a5288[ starlevel ];
                        
                        if ( subarea.tuning.var_22c3e564e5b0795d )
                        {
                            delaytime *= subarea.tuning.var_22c3e564e5b0795d;
                        }
                    }
                    
                    if ( level.var_b3dd93a2c97992f0 )
                    {
                        println( "<dev string:x133>" + subareaname + "<dev string:x155>" + delaytime );
                    }
                    
                    function_fa992719a805b962( delaytime, subarea, "Success" );
                }
                else
                {
                    if ( level.var_b3dd93a2c97992f0 )
                    {
                        println( "<dev string:x162>" + subareaname + "<dev string:x155>" + 1 );
                    }
                    
                    reinforcestruct.var_f20b3aa2ef5b6d6c = "Request Failed: Will Try Again";
                    function_fa992719a805b962( 1, subarea );
                }
            }
            else
            {
                println( "<dev string:x181>" + subareaname );
                level thread function_76b1f3a7ba935088( subarea, 5, "No good reinforce loc found." );
                function_fa992719a805b962( 5, subarea );
            }
        }
        else
        {
            reinforcestruct.var_f20b3aa2ef5b6d6c = "Queue Empty";
            function_fa992719a805b962( 1, subarea );
        }
        
        function_5177d3885b422760( subarea );
    }
}

// Namespace ai_reinforcements
// Params 3
// Checksum 0x3f40b0da, Offset: 0x2fa4
// Size: 0x134
function function_76b1f3a7ba935088( subarea, time, reason )
{
    timeremaining = time;
    interval = 0.1;
    
    if ( !isdefined( reason ) )
    {
        reason = "";
    }
    else
    {
        reason += " - ";
    }
    
    while ( timeremaining > 0 )
    {
        displaytime = script::limitdecimalplaces( timeremaining, 1 );
        level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f20b3aa2ef5b6d6c = reason + "Queue Delay : " + displaytime;
        wait interval;
        timeremaining -= interval;
    }
    
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f20b3aa2ef5b6d6c = "Delay Complete. New Request Available";
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f20b3aa2ef5b6d6c = "Queue Delay : 0";
}

// Namespace ai_reinforcements
// Params 0
// Checksum 0xee2c254f, Offset: 0x30e0
// Size: 0x324
function function_1812fb4b110d706e()
{
    if ( level.reinforcementoptions.disablelist.size == 0 )
    {
        return;
    }
    
    foreach ( starlevel, var_a4254f58352e4602 in level.reinforcementoptions.var_d6bd12c59326681f )
    {
        var_d848f6ee2197975b = [];
        var_6aae863ea2be5ed2 = [];
        
        if ( !isint( starlevel ) )
        {
            continue;
        }
        
        foreach ( index, optiontype in var_a4254f58352e4602 )
        {
            tokens = strtok( optiontype, "_" );
            
            if ( !arraycontains( level.reinforcementoptions.disablelist, tokens[ 1 ] ) )
            {
                var_d848f6ee2197975b[ var_d848f6ee2197975b.size ] = optiontype;
                var_6aae863ea2be5ed2[ var_6aae863ea2be5ed2.size ] = level.reinforcementoptions.var_d6bd12c59326681f[ starlevel + "_chance" ][ index ];
            }
        }
        
        level.reinforcementoptions.var_d6bd12c59326681f[ starlevel ] = var_d848f6ee2197975b;
        level.reinforcementoptions.var_d6bd12c59326681f[ starlevel + "_chance" ] = var_6aae863ea2be5ed2;
    }
    
    foreach ( difficultylevel, var_b9c906fadea1a3e7 in level.reinforcementoptions.bydifficulty )
    {
        var_d848f6ee2197975b = [];
        var_6aae863ea2be5ed2 = [];
        
        if ( !isint( difficultylevel ) )
        {
            continue;
        }
        
        foreach ( index, optiontype in var_b9c906fadea1a3e7 )
        {
            tokens = strtok( optiontype, "_" );
            
            if ( !arraycontains( level.reinforcementoptions.disablelist, tokens[ 1 ] ) )
            {
                var_d848f6ee2197975b[ var_d848f6ee2197975b.size ] = optiontype;
                var_6aae863ea2be5ed2[ var_6aae863ea2be5ed2.size ] = level.reinforcementoptions.bydifficulty[ difficultylevel + "_chance" ][ index ];
            }
        }
        
        level.reinforcementoptions.bydifficulty[ difficultylevel ] = var_d848f6ee2197975b;
        level.reinforcementoptions.bydifficulty[ difficultylevel + "_chance" ] = var_6aae863ea2be5ed2;
    }
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xdc6f5a45, Offset: 0x340c
// Size: 0x79
function function_f7a78ac2acd50894( subarea, var_8713b879735f3c0b = 1 )
{
    if ( poi::poi_issystemactive() )
    {
        if ( !isdefined( subarea ) )
        {
            return;
        }
        
        starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
        var_7237854e3be197ca = function_4bcfbc863aa7b20e( subarea );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x27530bb4, Offset: 0x348d
// Size: 0x2a0
function function_f88af37c0128d1b5( subarea )
{
    if ( !isdefined( subarea.poiname ) )
    {
        return;
    }
    
    var_485945f190ffd751 = star_system::function_401d5b95f7e26b6f( subarea.poiname, 5 );
    
    if ( !var_485945f190ffd751 || var_485945f190ffd751.size == 0 )
    {
        return;
    }
    
    foreach ( player in var_485945f190ffd751 )
    {
        if ( level.startracker[ subarea.poiname ].threatlist[ player.guid ].threat < 600 )
        {
            var_485945f190ffd751 = arrayremove( var_485945f190ffd751, player );
        }
    }
    
    if ( var_485945f190ffd751.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_a6df1f075a23375f[ subarea.poiname ] ) )
    {
        level.var_a6df1f075a23375f[ subarea.poiname ] = [];
    }
    
    arraykeys = getarraykeys( level.var_a6df1f075a23375f[ subarea.poiname ] );
    var_cb8f2f4ae3edcea2 = undefined;
    
    foreach ( player in var_485945f190ffd751 )
    {
        var_af8ae404de135379 = player getentitynumber();
        
        if ( !arraycontains( arraykeys, var_af8ae404de135379 ) )
        {
            level.var_a6df1f075a23375f[ subarea.poiname ][ var_af8ae404de135379 ] = gettime();
            return player;
        }
        
        if ( level.var_a6df1f075a23375f[ subarea.poiname ][ var_af8ae404de135379 ] + 60000 > gettime() )
        {
            continue;
        }
        
        if ( !var_cb8f2f4ae3edcea2 )
        {
            var_862b59579b042a12 = player;
            continue;
        }
        
        if ( level.var_a6df1f075a23375f[ subarea.poiname ][ var_af8ae404de135379 ] < level.var_a6df1f075a23375f[ subarea.poiname ][ var_862b59579b042a12 getentitynumber() ] )
        {
            var_862b59579b042a12 = player;
        }
    }
    
    if ( !var_862b59579b042a12 )
    {
        return;
    }
    
    level.var_a6df1f075a23375f[ subarea.poiname ][ var_862b59579b042a12 getentitynumber() ] = gettime();
    return var_862b59579b042a12;
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x771be7a4, Offset: 0x3736
// Size: 0x1c2
function function_2b9d2be4380a0d89( subarea )
{
    alllocs = level.poi[ subarea.poiname ][ "paraReinforceStruct" ].landingspots;
    
    if ( subarea.subareaname != "orphan" )
    {
        subarealocs = [];
        
        foreach ( loc in alllocs )
        {
            foundsubarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", loc.origin, subarea.poiname );
            
            if ( subarea.subareaname == foundsubarea.subareaname )
            {
                subarealocs[ subarealocs.size ] = loc;
            }
        }
        
        if ( subarealocs.size == 0 )
        {
            println( "<dev string:x1a4>" + subarea.poiname + "<dev string:x1ec>" + subarea.subareaname );
            return subarea.trigger.origin;
        }
        
        return utility::array_random( subarealocs ).origin;
    }
    
    if ( alllocs.size == 0 )
    {
        println( "<dev string:x1f0>" + subarea.poiname + "<dev string:x1ec>" + subarea.subareaname );
        return;
    }
    
    return utility::array_random( alllocs ).origin;
}

// Namespace ai_reinforcements
// Params 3
// Checksum 0x8d49697e, Offset: 0x3900
// Size: 0x1a0
function function_6f6dd03e6762a8ca( subarea, origin, time )
{
    if ( game_utility::getgametype() != "dmz" )
    {
        return;
    }
    
    if ( !( isdefined( subarea ) && isdefined( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ] ) ) )
    {
        return;
    }
    
    budgetstruct = level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ];
    
    if ( !isdefined( budgetstruct.reinforcementlocs ) )
    {
        return;
    }
    
    if ( distance2dsquared( subarea.origin, origin ) > 225000000 )
    {
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = gettime();
    }
    
    if ( isdefined( budgetstruct.var_80a15632de6ab1b0 ) )
    {
        dist = distance2dsquared( origin, budgetstruct.var_80a15632de6ab1b0.origin );
        
        if ( time - budgetstruct.var_80a15632de6ab1b0.time < level.var_d2ab896b653d8dd0 && dist <= level.var_c606dcf2882e883d )
        {
            return;
        }
    }
    
    struct = spawnstruct();
    struct.origin = origin;
    struct.time = gettime();
    struct.subarea = subarea;
    budgetstruct.reinforcementlocs[ budgetstruct.reinforcementlocs.size ] = struct;
    budgetstruct.var_80a15632de6ab1b0 = struct;
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x8a1a7bbc, Offset: 0x3aa8
// Size: 0x18d
function function_4bcfbc863aa7b20e( subarea )
{
    if ( !( isdefined( subarea ) && isdefined( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ] ) ) )
    {
        return;
    }
    
    budgetstruct = level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ];
    currenttime = gettime();
    
    if ( budgetstruct.reinforcementlocs.size > 0 )
    {
        foreach ( index, loc in budgetstruct.reinforcementlocs )
        {
            if ( currenttime > loc.time + 300000 )
            {
                function_be02076c575c95ef( subarea, loc );
                budgetstruct.reinforcementlocs[ index ] = undefined;
                continue;
            }
            
            function_be02076c575c95ef( subarea, loc );
            origin = loc.origin;
            budgetstruct.reinforcementlocs[ index ] = undefined;
            return origin;
        }
        
        return;
    }
    
    loc = utility::array_random( budgetstruct.var_aa73bfa8d1ecba54 );
    return loc.origin;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0x2d59ad83, Offset: 0x3c3e
// Size: 0xd8
function function_be02076c575c95ef( subarea, loc )
{
    if ( !( isdefined( subarea ) && isdefined( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ] ) ) )
    {
        return;
    }
    
    budgetstruct = level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ];
    
    if ( budgetstruct.var_aa73bfa8d1ecba54.size > 8 )
    {
        arraykeys = getarraykeys( budgetstruct.var_aa73bfa8d1ecba54 );
        budgetstruct.var_aa73bfa8d1ecba54[ arraykeys[ 0 ] ] = undefined;
    }
    
    budgetstruct.var_aa73bfa8d1ecba54[ budgetstruct.var_aa73bfa8d1ecba54.size ] = loc;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xf823624a, Offset: 0x3d1e
// Size: 0x52
function function_7292254f1248df0( agentrequests, reinforcementtype )
{
    requestpackage = spawnstruct();
    requestpackage.numagents = agentrequests.size;
    requestpackage.requests = agentrequests;
    requestpackage.reinforcementtype = reinforcementtype;
    return requestpackage;
}

// Namespace ai_reinforcements
// Params 3
// Checksum 0x83670c62, Offset: 0x3d79
// Size: 0x73
function function_f5e5b01238f335a0( type, tier, nationality )
{
    request = spawnstruct();
    
    if ( !isdefined( type ) )
    {
        type = ai_mp_controller::function_e0390bd2e60129e2( undefined, tier );
    }
    
    request.type = type;
    
    if ( !isdefined( tier ) )
    {
        tier = 1;
    }
    
    request.tier = tier;
    request.nationality = nationality;
    return request;
}

// Namespace ai_reinforcements
// Params 6
// Checksum 0x3b67ba75, Offset: 0x3df5
// Size: 0xc9
function function_c6a741f41aaede19( var_f81e889813df1769, possibletypes, maintier, spawnsetname, secondarytier, var_98eaee355e701cbf )
{
    requests = [];
    
    if ( secondarytier )
    {
        var_587e1b2bd384814 = 0;
    }
    
    for ( i = 0; i < var_f81e889813df1769 ; i++ )
    {
        if ( var_587e1b2bd384814 < var_98eaee355e701cbf )
        {
            var_82ee92c07f32eede = secondarytier;
            var_587e1b2bd384814++;
        }
        else
        {
            var_82ee92c07f32eede = maintier;
        }
        
        if ( isdefined( spawnsetname ) )
        {
            type = ai_mp_controller::function_e0390bd2e60129e2( spawnsetname, var_82ee92c07f32eede );
        }
        else
        {
            type = utility::array_random( possibletypes );
        }
        
        requests[ requests.size ] = function_f5e5b01238f335a0( type, var_82ee92c07f32eede );
    }
    
    return function_7292254f1248df0( requests, undefined );
}

// Namespace ai_reinforcements
// Params 3
// Checksum 0xd419f79e, Offset: 0x3ec7
// Size: 0x157
function function_fa992719a805b962( delaytime, subarea, delayreason )
{
    if ( !( isdefined( subarea ) && isdefined( level.aibudgets.areas[ subarea.areaname ] ) ) )
    {
        return;
    }
    
    if ( !isdefined( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_71a0da72a95d69a ) )
    {
        return;
    }
    
    delaypackage = spawnstruct();
    delaypackage.delaytime = delaytime;
    delaypackage.delayreason = delayreason;
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_71a0da72a95d69a[ level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_71a0da72a95d69a.size ] = delaypackage;
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_3068dadbd9f67325 = 1;
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xf63a93b8, Offset: 0x4026
// Size: 0x192
function function_5177d3885b422760( subarea )
{
    level endon( #"game_ended" );
    
    if ( !( isdefined( subarea ) && isdefined( level.aibudgets.areas[ subarea.areaname ] ) ) )
    {
        return;
    }
    
    while ( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_3068dadbd9f67325 )
    {
        delayarray = level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_71a0da72a95d69a;
        function_45d15116d2acf1f8( subarea );
        
        foreach ( delaypackage in delayarray )
        {
            if ( level.var_b3dd93a2c97992f0 )
            {
                println( "<dev string:x232>" + subarea.subareaname + "<dev string:x130>" + delaypackage.delaytime );
            }
            
            level thread function_76b1f3a7ba935088( subarea, delaypackage.delaytime, delaypackage.delayreason );
            wait delaypackage.delaytime;
        }
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xba26249c, Offset: 0x41c0
// Size: 0x7a
function function_45d15116d2acf1f8( subarea )
{
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_71a0da72a95d69a = [];
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_3068dadbd9f67325 = 0;
}

// Namespace ai_reinforcements
// Params 4
// Checksum 0x59a9ee25, Offset: 0x4242
// Size: 0x1b2
function function_cc09697b3048416b( poiname, origin, subarea, player )
{
    if ( player )
    {
        maxdistance = 6250000;
        teamplayers = teams::getteamdata( player.team, "players" );
        var_e87a494185c221c6 = [ player ];
        
        foreach ( teamplayer in teamplayers )
        {
            if ( distance2dsquared( teamplayer.origin, player.origin ) < maxdistance )
            {
                var_e87a494185c221c6[ var_e87a494185c221c6.size ] = teamplayer;
            }
        }
        
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"hash_284f841ab9026375", var_e87a494185c221c6 );
    }
    
    if ( subarea )
    {
        foreach ( agent in subarea.livingagents )
        {
            if ( !isagent( agent ) )
            {
                continue;
            }
            
            agent setbattlechatterflag( "reinforcements_incoming", 1, 5 );
        }
    }
}

// Namespace ai_reinforcements
// Params 11
// Checksum 0xbe587925, Offset: 0x43fc
// Size: 0x3a8
function function_d0a9530035c6dc35( origin, radius = 1024, team = "team_hundred_ninety_four", var_2c7ce042e9712590, var_eb89deb402a7a05, goalradiusoverride = 256, var_f0ad9f1ee00dec3 = 512, var_c8b7084b2d109553, var_9110dea815bfb02b, targetent, var_2fdb8624c6b8f1dd )
{
    if ( !isvector( origin ) )
    {
        return;
    }
    
    localdebug = 0;
    agents = entity::function_cd55d7a649cb9c44( origin, radius, team );
    temparray = [];
    
    foreach ( agent in agents )
    {
        if ( !isplayer( agent ) )
        {
            temparray[ temparray.size ] = agent;
        }
    }
    
    agents = temparray;
    
    if ( !isdefined( var_2c7ce042e9712590 ) )
    {
        var_2c7ce042e9712590 = 5;
    }
    
    if ( !isdefined( var_eb89deb402a7a05 ) )
    {
        var_eb89deb402a7a05 = [ "reinforcements", "spawnPackage" ];
    }
    
    /#
        if ( localdebug )
        {
            foreach ( guy in level.agentarray )
            {
                guy notify( #"hash_e50272a44df0733f" );
            }
        }
    #/
    
    agents = sortbydistance( agents, origin );
    chosenagents = [];
    
    foreach ( agent in agents )
    {
        if ( isplayer( agent ) )
        {
            continue;
        }
        
        if ( issubstr( agent.agent_type, "jugg" ) )
        {
            continue;
        }
        
        if ( chosenagents.size >= var_2c7ce042e9712590 )
        {
            break;
        }
        
        if ( !var_c8b7084b2d109553 && agent.var_1e0ecc16c74773d8 || isint( agent.vehicle_position ) )
        {
            continue;
        }
        
        if ( !( isstring( var_eb89deb402a7a05 ) && var_eb89deb402a7a05 == "all" ) && !arraycontains( var_eb89deb402a7a05, agent.category ) )
        {
            /#
                if ( localdebug )
                {
                    agent thread debug::drawsphere( agent.origin, 64, 30, ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        
        if ( var_2fdb8624c6b8f1dd )
        {
            if ( abs( origin[ 2 ] - agent.origin[ 2 ] ) > var_2fdb8624c6b8f1dd )
            {
                /#
                    if ( localdebug )
                    {
                        agent thread debug::drawsphere( agent.origin, 64, 30, ( 0, 0, 1 ) );
                    }
                #/
                
                continue;
            }
        }
        
        chosenagents[ chosenagents.size ] = agent;
        agent.var_1e0ecc16c74773d8 = 1;
        agent thread ai_behavior::behavior_combatRushOrigin( agent, origin, var_f0ad9f1ee00dec3, goalradiusoverride, undefined, 1, agents, 0, var_9110dea815bfb02b, targetent );
        
        /#
            if ( localdebug )
            {
                agent thread ai_mp_controller::function_fa975b780e4b54cd( agent, origin );
            }
        #/
    }
    
    return chosenagents;
}

// Namespace ai_reinforcements
// Params 13
// Checksum 0xa7ab91c3, Offset: 0x47ad
// Size: 0x204
function function_ee97bd279a52ed16( numagents, reinforceorigin, priority, category, subcategory, groupname, team, subarea, var_a7167dc7e5ec6448 = 512, maxdistfromorigin = 1024, tier = 1, var_1bd8f67df7ca8a84 = 1, var_e5193624dc91eff4 )
{
    reinforceorigin = ai_behavior::function_b49820d3792f8b12( reinforceorigin );
    degoffset = 360 / numagents;
    agents = [];
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        var_599d450bd1f7dd3b = var_e5193624dc91eff4 ?? function_7c4eb2a03864d853( 0, 1, "reinforcements", 0 );
    }
    
    for ( i = 1; i <= numagents ; i++ )
    {
        spawnorigin = ( 0, randomintrange( var_a7167dc7e5ec6448, maxdistfromorigin ), 0 );
        spawnorigin = reinforceorigin + rotatepointaroundvector( ( 0, 0, 1 ), spawnorigin, degoffset * i );
        spawnorigin = ai_behavior::function_b49820d3792f8b12( spawnorigin );
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, undefined, undefined, tier, undefined, spawnorigin );
        agents[ agents.size ] = ai_mp_controller::spawn( { #groupid:var_599d450bd1f7dd3b, #var_4f8a92ebabf37ee:var_1bd8f67df7ca8a84, #subarea:subarea, #team:team, #groupname:groupname, #subcategory:subcategory, #category:category, #priority:priority, #spawnangles:( 0, 0, 0 ), #groundspawnorigin:spawnorigin, #agenttype:aitype } );
    }
    
    if ( isdefined( var_599d450bd1f7dd3b ) && !isdefined( var_e5193624dc91eff4 ) )
    {
        function_7ac170c0429491c1( var_599d450bd1f7dd3b, 1 );
    }
    
    return agents;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xe8a58bd2, Offset: 0x49ba
// Size: 0x5d
function function_771f47d2b0f5aee2( tier, arrayoptions )
{
    while ( !( isdefined( level.reinforcementoptions ) && isdefined( level.reinforcementoptions.var_15f05597dbbc3801 ) ) )
    {
        waitframe();
    }
    
    level.reinforcementoptions.var_15f05597dbbc3801[ "tier" + tier ] = arrayoptions;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0x10a497ac, Offset: 0x4a1f
// Size: 0x56
function function_e73fd4898f86616a( type, arrayoptions )
{
    while ( !( isdefined( level.reinforcementoptions ) && isdefined( level.reinforcementoptions.var_63bcdb3abec1ac73 ) ) )
    {
        waitframe();
    }
    
    level.reinforcementoptions.var_63bcdb3abec1ac73[ type ] = arrayoptions;
}

// Namespace ai_reinforcements
// Params 5
// Checksum 0x4bba08c5, Offset: 0x4a7d
// Size: 0x4d2
function function_b939bd9525dd795b( agent, subarea, var_dd9449b988f98f43, attacker, attackerteam )
{
    if ( !isdefined( subarea ) )
    {
        return;
    }
    
    var_6d3f7efbfc04fc77 = 1;
    
    if ( subarea.var_d4b3247c36826678 || level.var_2a654158ce494733 )
    {
        var_6d3f7efbfc04fc77 = 0;
    }
    
    if ( utility::callsharedfunc( #"quickkill", #"hash_78ce44dfaea233cc", agent ) )
    {
        return;
    }
    
    if ( subarea.livingagents.size >= subarea.tuning.var_f1abf29235565ad0 )
    {
        return;
    }
    
    var_9e757b9d522d2c53 = 0;
    
    if ( agent.enemy )
    {
        var_9e757b9d522d2c53 = 1;
    }
    
    var_98a9094c33458685 = attacker.compromised;
    
    if ( level.players[ 0 ].compromised && !var_9e757b9d522d2c53 )
    {
        test = 1;
    }
    
    var_68b7af9656ecff14 = agent.var_68b7af9656ecff14;
    lastnonsilenceddamagetime = agent.lastnonsilenceddamagetime;
    var_65ef08c8609871c1 = agent.origin;
    waittillframeend();
    
    if ( level.var_477715688f562bf0 && ( agent.quickkill || !var_9e757b9d522d2c53 ) && !var_68b7af9656ecff14 && !var_98a9094c33458685 )
    {
        stealthkill = 1;
    }
    
    if ( attacker vehicle::is_vehicle() )
    {
        attackerteam = attacker.owner.team;
    }
    
    if ( isdefined( attackerteam ) )
    {
        teammembers = teams::getteamdata( attackerteam, "players" );
    }
    
    delay = level.var_22711d88c3be755c;
    var_e66031757b8e19a = 0;
    
    if ( isdefined( subarea.poiname ) && isdefined( level.poi[ subarea.poiname ][ "players" ] ) )
    {
        if ( level.poi[ subarea.poiname ][ "players" ].size >= level.var_40d0ef7679d01102 )
        {
            var_e66031757b8e19a = 1;
        }
    }
    
    if ( !var_e66031757b8e19a && isdefined( teammembers ) && teammembers.size == 1 )
    {
        if ( !isdefined( teammembers[ 0 ].var_9949f70a08026548 ) )
        {
            teammembers[ 0 ].var_9949f70a08026548 = 0;
        }
        
        teammembers[ 0 ].var_9949f70a08026548++;
        
        if ( teammembers[ 0 ].var_9949f70a08026548 % level.var_92114727f367a690 != 0 )
        {
            if ( stealthkill )
            {
                var_d7200d0ed7caeaf8 = 1;
            }
            
            delay += level.var_bd4c56ffc4412dbb;
        }
    }
    
    if ( var_dd9449b988f98f43 && ( !isdefined( lastnonsilenceddamagetime ) || gettime() - lastnonsilenceddamagetime > level.var_e0e6df865005db87 * 1000 ) )
    {
        if ( stealthkill )
        {
            var_5e0b2f799788a787 = 1;
        }
        
        delay += level.var_4b3ac2cf122de201;
    }
    
    if ( stealthkill )
    {
        function_ae26372a68ba526e( attacker, attackerteam, var_9e757b9d522d2c53, var_65ef08c8609871c1 );
        
        if ( var_6d3f7efbfc04fc77 )
        {
            if ( !isdefined( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_5d8751db294ae491 ) )
            {
                return;
            }
            
            level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_5d8751db294ae491++;
            level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_65bb55dc2eb1d1db[ level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_65bb55dc2eb1d1db.size ] = delay;
        }
        
        /#
            if ( level.var_2d9e20cc8a208e77 )
            {
                print3d( var_65ef08c8609871c1 + ( 0, 0, 80 ), "<dev string:x24a>", ( 0, 1, 0 ), 1, 0.7, 100 );
            }
        #/
        
        if ( !isdefined( level.var_67485e0d2432d311 ) )
        {
            level.var_67485e0d2432d311 = 0;
        }
        
        level.var_67485e0d2432d311++;
        return;
    }
    
    if ( var_6d3f7efbfc04fc77 )
    {
        level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f69986e46c50ba53++;
        wait delay;
        level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f69986e46c50ba53--;
    }
    
    ai_mp_controller::function_db2ffb8d9982a194( subarea, var_6d3f7efbfc04fc77 );
}

// Namespace ai_reinforcements
// Params 4
// Checksum 0x9a069c0a, Offset: 0x4f57
// Size: 0x264
function function_ae26372a68ba526e( attacker, attackerteam, var_9e757b9d522d2c53, killorigin )
{
    if ( attacker.compromised )
    {
        return;
    }
    
    currenttime = gettime();
    attackerguid = attacker.guid;
    
    if ( !isdefined( attackerguid ) )
    {
        return;
    }
    
    event = "none";
    
    if ( !level.var_da02bb24370fd73[ attackerguid ] )
    {
        level.var_da02bb24370fd73[ attackerguid ] = spawnstruct();
    }
    
    if ( !level.var_da02bb24370fd73[ attackerguid ].var_2ee6199ef51c15ac )
    {
        level.var_da02bb24370fd73[ attackerguid ].var_2ee6199ef51c15ac = 1;
        event = "kill_first";
    }
    else
    {
        level.var_da02bb24370fd73[ attackerguid ].var_2ee6199ef51c15ac++;
    }
    
    if ( level.var_da02bb24370fd73[ attackerguid ].var_2ee6199ef51c15ac > 4 )
    {
        if ( level.var_da02bb24370fd73[ attackerguid ].lastkilltime && currenttime - level.var_da02bb24370fd73[ attackerguid ].lastkilltime > 5000 )
        {
            event = "kill_multi";
        }
    }
    
    if ( var_9e757b9d522d2c53 )
    {
        event = "kill_first_aware";
    }
    
    level.var_da02bb24370fd73[ attackerguid ].lastkilltime = gettime();
    
    if ( !function_a97a541ec800e47c( attacker, 1, 1, 1, 1024, killorigin ) )
    {
        return;
    }
    
    nearbyteammates = function_ef672be3c0a7abd7( attacker );
    
    switch ( event )
    {
        case #"hash_7192c2868f819658":
            thread function_90d71d4c606852e2( #"kill_first", [ attacker ], 0.5 );
            thread function_90d71d4c606852e2( #"hash_cc3dd8e4ff8912e", nearbyteammates, 0.5 );
            break;
        case #"hash_94dbaed92d6bbcf3":
            thread function_90d71d4c606852e2( #"kill_multi", [ attacker ], 0.5 );
            thread function_90d71d4c606852e2( #"hash_cc3dd8e4ff8912e", nearbyteammates, 0.5 );
            break;
        case #"hash_443ffbb3014b5e89":
            thread function_90d71d4c606852e2( #"kill_first_aware", [ attacker ], 0.5 );
            thread function_90d71d4c606852e2( #"hash_cc3dd8e4ff8912e", nearbyteammates, 0.5 );
            break;
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x14eb5dce, Offset: 0x51c3
// Size: 0x26
function function_10a0b2a04b0ec533( player )
{
    level.var_da02bb24370fd73[ player.guid ] = spawnstruct();
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xe6111525, Offset: 0x51f1
// Size: 0x4b
function function_4fea199de14a7b2e( player )
{
    player.var_a6befdf2e0ba95d8 = 0;
    player.var_7901ab8f5a6f5389 = 0;
    player.var_fdb4b15046e2baca = 0;
    player.var_fadea250a7e1ae52 = undefined;
    player.compromised = 0;
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x7819ae8f, Offset: 0x5244
// Size: 0x5a1
function function_a573d3a695c1a8( agent )
{
    self notify( #"hash_e75d021fc661f499" );
    self endon( #"hash_e75d021fc661f499" );
    
    if ( !level.var_477715688f562bf0 )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"quickkill", #"hash_78ce44dfaea233cc", self ) )
    {
        return;
    }
    
    agent thread function_b5151d485bfe6018( agent );
    var_4d413f11dc3b79c9 = level.var_b33604761536dd78 ?? 4;
    waittillframeend();
    
    while ( isalive( agent ) && agent isincombat() && !agent.longdeathanims_alias )
    {
        if ( !isalive( agent ) )
        {
            break;
        }
        
        if ( agent.enemy )
        {
            if ( !isplayer( agent.enemy ) )
            {
                waitframe();
                continue;
            }
            
            if ( agent.enemy.compromised )
            {
                agent.var_676ce18289ee4475 = undefined;
                waitframe();
                continue;
            }
            
            if ( agent iscurrentenemyvalid() && agent canshootenemy() )
            {
                if ( !agent.enemy.compromised && ( !agent.var_8e69dff3b1c39f54 || agent.enemy != agent.var_8e69dff3b1c39f54 ) )
                {
                    agent.var_8e69dff3b1c39f54 = agent.enemy;
                    
                    if ( agent.enemy.var_e6f902e3aae33a76 && gettime() - agent.enemy.var_e6f902e3aae33a76 < 5000 )
                    {
                        var_4d413f11dc3b79c9 = 1;
                    }
                    else
                    {
                        var_4d413f11dc3b79c9 = level.var_b33604761536dd78 ?? 5;
                    }
                    
                    agent.var_676ce18289ee4475 = gettime() + var_4d413f11dc3b79c9 * 1000;
                    var_4f97f381b690b09b = 0;
                }
                
                if ( !agent.enemy.compromised && !agent.enemy.var_a6befdf2e0ba95d8 && !agent.enemy.var_7901ab8f5a6f5389 )
                {
                    if ( !agent dmz_ai::function_fb0f68f6b97f7f6c() )
                    {
                        if ( function_a97a541ec800e47c( agent.enemy, 0 ) )
                        {
                            if ( !isdefined( agent.enemy.var_fadea250a7e1ae52 ) )
                            {
                                agent.enemy.var_fadea250a7e1ae52 = ai_fortress::function_a38917c33bb50ae3( agent.enemy.origin );
                            }
                            
                            if ( !agent.enemy.var_fadea250a7e1ae52 )
                            {
                                agent.enemy.var_a6befdf2e0ba95d8 = 1;
                                thread function_90d71d4c606852e2( #"hash_d51a14c4c104a02d", [ agent.enemy ], 0.1 );
                                
                                /#
                                    if ( level.var_95a3e1453148b015 )
                                    {
                                        printtoscreen2d( 550, 450, "<dev string:x257>", ( 1, 0, 0 ), 2, 50 );
                                    }
                                #/
                            }
                        }
                        else if ( !agent.enemy.var_7901ab8f5a6f5389 )
                        {
                            if ( !isdefined( agent.enemy.var_fadea250a7e1ae52 ) )
                            {
                                agent.enemy.var_fadea250a7e1ae52 = ai_fortress::function_a38917c33bb50ae3( agent.enemy.origin );
                            }
                            
                            if ( !agent.enemy.var_fadea250a7e1ae52 )
                            {
                                agent.enemy.var_7901ab8f5a6f5389 = 1;
                                nearbyplayers = function_770007e7eafcc318( agent.origin, 1 );
                                temparray = [];
                                
                                foreach ( nearbyplayer in nearbyplayers )
                                {
                                    if ( function_a97a541ec800e47c( nearbyplayer, 1, 1, 100, 32 ) )
                                    {
                                        temparray[ temparray.size ] = nearbyplayer;
                                    }
                                }
                                
                                nearbyplayers = temparray;
                                thread function_90d71d4c606852e2( #"enemy_heard_something", nearbyplayers );
                                
                                /#
                                    if ( level.var_95a3e1453148b015 )
                                    {
                                        printtoscreen2d( 550, 400, "<dev string:x282>", ( 1, 0, 0 ), 2, 50 );
                                    }
                                #/
                            }
                        }
                    }
                }
            }
        }
        else
        {
            agent.var_676ce18289ee4475 = undefined;
        }
        
        if ( !agent.enemy.compromised && agent.var_676ce18289ee4475 && gettime() > agent.var_676ce18289ee4475 )
        {
            utility::callsharedfunc( #"quickkill", #"hash_916f5a249e90416e", agent );
            return;
        }
        
        /#
            if ( level.var_2d9e20cc8a208e77 && isalive( agent ) && agent.var_676ce18289ee4475 )
            {
                print3d( agent.origin + ( 0, 0, 80 ), ( agent.var_676ce18289ee4475 - gettime() ) / 1000, ( 1, 1, 1 ), 1, 3, 5 );
            }
        #/
        
        waitframe();
    }
    
    if ( !isalive( agent ) || agent.longdeathanims_alias )
    {
        agent.quickkill = 1;
    }
}

// Namespace ai_reinforcements
// Params 4
// Checksum 0xbc4e31c0, Offset: 0x57ed
// Size: 0x141
function function_ef672be3c0a7abd7( player, agent, origin, var_dcd22d76e533729d = 1 )
{
    maxdistancesq = 2250000;
    teammates = teams::getteamdata( player.team, "players" );
    teammates = arrayremove( teammates, player );
    nearbyteammates = [];
    
    if ( agent && isagent( agent ) )
    {
        origin = agent.origin;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = player.origin;
    }
    
    foreach ( teammate in teammates )
    {
        if ( var_dcd22d76e533729d && player.var_27b7df354768cb58 )
        {
            continue;
        }
        
        if ( distance2dsquared( origin, teammate.origin ) < maxdistancesq )
        {
            nearbyteammates[ nearbyteammates.size ] = teammate;
        }
    }
    
    return nearbyteammates;
}

// Namespace ai_reinforcements
// Params 4
// Checksum 0x21fa2949, Offset: 0x5937
// Size: 0x129
function function_770007e7eafcc318( origin, var_68739ee02c6bd3bd, maxdistance = 1500, var_dcd22d76e533729d = 1 )
{
    maxdistancesq = maxdistance * maxdistance;
    nearbyplayers = [];
    playerssorted = sortbydistance( level.players, origin );
    
    foreach ( player in playerssorted )
    {
        if ( distance2dsquared( player.origin, origin ) < maxdistancesq )
        {
            if ( var_68739ee02c6bd3bd && player.compromised )
            {
                continue;
            }
            
            if ( var_dcd22d76e533729d && player.var_27b7df354768cb58 )
            {
                continue;
            }
            
            nearbyplayers[ nearbyplayers.size ] = player;
            continue;
        }
        
        return nearbyplayers;
    }
    
    return nearbyplayers;
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xd945db35, Offset: 0x5a69
// Size: 0x148
function function_b5151d485bfe6018( agent )
{
    self notify( #"hash_54c690bf067af417" );
    self endon( #"hash_54c690bf067af417" );
    agent endon( #"death" );
    agent endon( #"hash_e3af37106ce7514b" );
    events = [ "bulletwhizby", "damage", "grenade_danger", "explosion", "gunshot", "gunshot_impact" ];
    
    while ( true )
    {
        msg = agent utility::waittill_any_in_array_return( events );
        
        if ( !agent.enemy || agent.enemy.compromised )
        {
            continue;
        }
        
        if ( agent.var_676ce18289ee4475 && msg )
        {
            agent.var_676ce18289ee4475 += 300;
        }
        
        /#
            if ( level.var_2d9e20cc8a208e77 && isalive( agent ) )
            {
                print3d( agent.origin + ( 0, 0, 100 ), "<dev string:x2bb>" + msg, ( 1, 1, 1 ), 1, 3, 100 );
            }
        #/
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x582f116d, Offset: 0x5bb9
// Size: 0x2be
function function_e21bbcb055d11620( subarea )
{
    level endon( #"game_ended" );
    level endon( #"dmz_radiation_started" );
    subareaname = subarea.subareaname;
    areaname = subarea.areaname;
    reinforcestruct = level.aibudgets.areas[ areaname ][ subareaname ];
    var_ee262674631ec86c = level.var_ee262674631ec86c ?? 270;
    halftimecalled = 0;
    
    while ( true )
    {
        currenttime = gettime();
        
        if ( reinforcestruct.var_5d8751db294ae491 > 0 )
        {
            if ( reinforcestruct.var_e85d6ff0725889ea == -1 )
            {
                reinforcestruct.var_e85d6ff0725889ea = currenttime + var_ee262674631ec86c * 1000;
                halftimecalled = 0;
            }
            else if ( !halftimecalled && currenttime > reinforcestruct.var_e85d6ff0725889ea - var_ee262674631ec86c * 1000 * 0.5 )
            {
                halftimecalled = 1;
                
                if ( subarea.poiname )
                {
                    var_cbb5c6dfd9b05341 = level.poi[ subarea.poiname ][ "players" ];
                    
                    foreach ( player in var_cbb5c6dfd9b05341 )
                    {
                        if ( function_a97a541ec800e47c( player, 0, 1, 2, 768 ) )
                        {
                            thread function_90d71d4c606852e2( #"timer_half", [ player ] );
                        }
                    }
                }
            }
            else if ( reinforcestruct.var_e85d6ff0725889ea != -1 && currenttime > reinforcestruct.var_e85d6ff0725889ea )
            {
                level thread function_32ba280b26f826f6( subarea );
                halftimecalled = 0;
                
                if ( subarea.poiname )
                {
                    var_cbb5c6dfd9b05341 = level.poi[ subarea.poiname ][ "players" ];
                    
                    foreach ( player in var_cbb5c6dfd9b05341 )
                    {
                        if ( function_a97a541ec800e47c( player, 0, 1, 2, 768 ) )
                        {
                            thread function_90d71d4c606852e2( #"hash_254cb71e341e1022", [ player ] );
                        }
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xe3fc74c8, Offset: 0x5e7f
// Size: 0x19c
function function_6d4f769419d7baaf( agent )
{
    /#
        if ( level.var_2d9e20cc8a208e77 )
        {
            print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x2c8>", ( 1, 0, 0 ), 1, 0.7, 100 );
        }
    #/
    
    level thread function_32ba280b26f826f6( agent.subarea );
    agent notify( #"hash_e3af37106ce7514b" );
    
    if ( agent.enemy && !agent.enemy.compromised && isplayer( agent.enemy ) )
    {
        compromiseplayer( agent.enemy );
        
        if ( !agent dmz_ai::function_fb0f68f6b97f7f6c() && function_a97a541ec800e47c( agent.enemy, undefined, undefined, 100, 32 ) )
        {
            if ( level.var_da02bb24370fd73[ agent.enemy.guid ].var_2ee6199ef51c15ac > 4 )
            {
                thread function_90d71d4c606852e2( #"hash_b110a6cccd7b7ead", [ agent.enemy ] );
            }
            else
            {
                thread function_90d71d4c606852e2( #"hash_e0f92c870e9c0ebe", [ agent.enemy ] );
            }
            
            /#
                if ( level.var_95a3e1453148b015 )
                {
                    printtoscreen2d( 550, 350, "<dev string:x2dc>", ( 1, 0, 0 ), 2, 50 );
                }
            #/
        }
        
        function_10a0b2a04b0ec533( agent.enemy );
    }
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xbf035149, Offset: 0x6023
// Size: 0xdd
function compromiseplayer( player, delay )
{
    if ( delay )
    {
        player endon( #"death_or_disconnect" );
        wait delay;
    }
    
    player.var_3f3a25f0ddf41b75 = gettime();
    
    if ( !player.compromised )
    {
        player.compromised = 1;
        player thread utility::callsharedfunc( #"music_intensity", #"boost_intensity", { #self_notify:"endCompromisedMusicBoost", #timeout:60, #max:2, #amount:1, #name:"compromised" } );
        
        if ( isplayer( player ) )
        {
            player playlocalsound( "uin_dmz_hud_compromised" );
        }
        
        player setclientomnvar( "ui_stealth_compromise_state", 1 );
    }
    
    player thread function_314a5c5a3254d902( player );
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0xc1e8c361, Offset: 0x6108
// Size: 0x1f4
function function_314a5c5a3254d902( player )
{
    self notify( #"hash_5855b8a7c5daa1bc" );
    self endon( #"hash_5855b8a7c5daa1bc" );
    player endon( #"death" );
    
    while ( player.compromised )
    {
        lkptime = player function_229cf866aa943cd1();
        timecompromised = ( gettime() - player.var_3f3a25f0ddf41b75 ) / 1000;
        
        /#
            if ( level.var_2d9e20cc8a208e77 && lkptime )
            {
                var_cf3c52bffd5aa952 = ( gettime() - lkptime ) / 1000;
                
                if ( gettime() - lkptime > level.var_adebcd3cc511b080 )
                {
                    color = ( 0, 1, 0 );
                }
                else
                {
                    color = ( 1, 0, 0 );
                }
                
                printtoscreen2d( 550, 250, "<dev string:x2f3>" + var_cf3c52bffd5aa952, color, 2, 18 );
                
                if ( timecompromised * 1000 > level.var_adebcd3cc511b080 )
                {
                    color = ( 0, 1, 0 );
                }
                else
                {
                    color = ( 1, 0, 0 );
                }
                
                printtoscreen2d( 550, 300, "<dev string:x310>" + timecompromised, color, 2, 18 );
            }
        #/
        
        if ( gettime() - lkptime > level.var_adebcd3cc511b080 && timecompromised * 1000 > level.var_adebcd3cc511b080 )
        {
            /#
                if ( level.var_95a3e1453148b015 )
                {
                    printtoscreen2d( 550, 550, "<dev string:x323>", ( 1, 0, 0 ), 2, 100 );
                }
            #/
            
            player.compromised = 0;
            player notify( #"endCompromisedMusicBoost" );
            
            if ( isplayer( player ) )
            {
                player playlocalsound( "uin_dmz_hud_uncompromised" );
            }
            
            player.var_e6f902e3aae33a76 = gettime();
            player setclientomnvar( "ui_stealth_compromise_state", 0 );
            function_4fea199de14a7b2e( player );
            continue;
        }
        
        wait 1;
        continue;
    }
}

// Namespace ai_reinforcements
// Params 3
// Checksum 0x91463aa3, Offset: 0x6304
// Size: 0xe7
function function_90d71d4c606852e2( alias, playerarray, delay )
{
    foreach ( player in playerarray )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        var_fba5199c50e799f = utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", alias, [ player ], delay );
        
        if ( var_fba5199c50e799f )
        {
            entid = player getentitynumber();
            level.var_3dd9db24e4281c99[ entid ] = gettime();
        }
    }
}

// Namespace ai_reinforcements
// Params 6
// Checksum 0xe45a6f89, Offset: 0x63f3
// Size: 0x1d1, Type: bool
function function_a97a541ec800e47c( player, var_dd1bf74a328220d8 = 1, var_8dc70ee501651c51 = 0, var_79b9a8638ad8d254 = 3, var_b80324c73191747d = 1500, var_1f0aaf2855cdf429 )
{
    if ( !level.var_80ce5b5bc9eb2e4b )
    {
        return false;
    }
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( player.vehicle )
    {
        return false;
    }
    
    if ( isdefined( player.inexfil ) )
    {
        return false;
    }
    
    if ( player.var_27b7df354768cb58 )
    {
        return false;
    }
    
    entid = player getentitynumber();
    
    if ( isdefined( level.var_3dd9db24e4281c99[ entid ] ) && level.var_3dd9db24e4281c99[ entid ] + 5000 > gettime() )
    {
        return false;
    }
    
    var_b123ac868f41f0c9 = var_1f0aaf2855cdf429 ?? player.origin;
    var_5d5cda2fe522c69 = getaiarrayinradius( var_b123ac868f41f0c9, var_b80324c73191747d );
    
    if ( isarray( var_5d5cda2fe522c69 ) )
    {
        if ( var_5d5cda2fe522c69.size >= var_79b9a8638ad8d254 )
        {
            return false;
        }
        
        if ( var_8dc70ee501651c51 )
        {
            foreach ( agent in var_5d5cda2fe522c69 )
            {
                if ( agent.enemy && agent.enemy == player && agent iscurrentenemyvalid() )
                {
                    return false;
                }
            }
        }
    }
    
    if ( var_dd1bf74a328220d8 )
    {
        if ( ai_fortress::function_a38917c33bb50ae3( var_b123ac868f41f0c9 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x77ad497, Offset: 0x65cd
// Size: 0x15b
function function_74b2cd4f14144719( subarea )
{
    subareaname = subarea.subareaname;
    areaname = subarea.areaname;
    reinforcestruct = level.aibudgets.areas[ areaname ][ subareaname ];
    
    if ( reinforcestruct.var_49bd0769e65e43d8 )
    {
        return;
    }
    
    if ( level.var_2d9e20cc8a208e77 )
    {
        level thread debug::function_16b0d1fbf9c99e98( 400, 60, "DUMPING SINGLE STEALTH POINT - " + subareaname, 5 );
    }
    
    foreach ( index, pointdelay in reinforcestruct.var_65bb55dc2eb1d1db )
    {
        level thread function_4edc4b590a311348( pointdelay, subarea );
        reinforcestruct.var_65bb55dc2eb1d1db[ index ] = undefined;
        
        if ( isint( index ) )
        {
            function_cdc669dbc8ea2101( reinforcestruct.var_65bb55dc2eb1d1db );
        }
        
        reinforcestruct.var_5d8751db294ae491--;
        
        if ( !isdefined( level.var_5dd589bf94650072 ) )
        {
            level.var_5dd589bf94650072 = 0;
        }
        
        level.var_5dd589bf94650072++;
        return;
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x138b07af, Offset: 0x6730
// Size: 0x16b
function function_32ba280b26f826f6( subarea )
{
    subareaname = subarea.subareaname;
    areaname = subarea.areaname;
    reinforcestruct = level.aibudgets.areas[ areaname ][ subareaname ];
    
    if ( reinforcestruct.var_49bd0769e65e43d8 )
    {
        return;
    }
    
    reinforcestruct.var_49bd0769e65e43d8 = 1;
    
    if ( level.var_2d9e20cc8a208e77 )
    {
        level thread debug::function_16b0d1fbf9c99e98( 400, 60, "DUMPING STEALTH POINTS - " + subareaname, 5 );
    }
    
    foreach ( pointdelay in reinforcestruct.var_65bb55dc2eb1d1db )
    {
        level thread function_4edc4b590a311348( pointdelay, subarea );
        
        if ( !isdefined( level.var_5dd589bf94650072 ) )
        {
            level.var_5dd589bf94650072 = 0;
        }
        
        level.var_5dd589bf94650072++;
        waitframe();
    }
    
    reinforcestruct.var_65bb55dc2eb1d1db = [];
    reinforcestruct.var_5d8751db294ae491 = 0;
    reinforcestruct.var_49bd0769e65e43d8 = 0;
    reinforcestruct.var_e85d6ff0725889ea = -1;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0x5698f95e, Offset: 0x68a3
// Size: 0x98
function function_4edc4b590a311348( delay, subarea )
{
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f69986e46c50ba53++;
    wait delay;
    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].var_f69986e46c50ba53--;
    ai_mp_controller::function_db2ffb8d9982a194( subarea, subarea.var_d4b3247c36826678 );
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xdc06ecb4, Offset: 0x6943
// Size: 0x3b
function function_fb5d36d607bcb7d2( player, duration )
{
    player.var_27b7df354768cb58 = 1;
    
    if ( duration && duration > 0 )
    {
        player thread function_b59f540a9687b1b7( player, duration );
    }
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xa7bd3f1d, Offset: 0x6986
// Size: 0x3a
function function_55cd83368e70c7a8( player, duration )
{
    player.var_27b7df354768cb58 = 0;
    
    if ( duration && duration > 0 )
    {
        player thread function_b59f540a9687b1b7( player, duration );
    }
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xa0b28946, Offset: 0x69c8
// Size: 0x44
function function_b59f540a9687b1b7( player, duration )
{
    wait duration;
    
    if ( player.var_27b7df354768cb58 )
    {
        player.var_27b7df354768cb58 = 0;
        return;
    }
    
    player.var_27b7df354768cb58 = 1;
}

// Namespace ai_reinforcements
// Params 2
// Checksum 0xb8d2f9d9, Offset: 0x6a14
// Size: 0x19c
function function_db311c352799e0f( player, subarea )
{
    if ( !isdefined( subarea.poiname ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
    
    if ( randomintrange( 0, 100 ) < level.reinforcementoptions.var_1946a53223a1147e[ starlevel ] )
    {
        var_b4b4071aa0139469 = [];
        
        foreach ( agent in subarea.livingagents )
        {
            if ( isagent( agent ) && agent.category == "reinforcements" )
            {
                var_b4b4071aa0139469[ var_b4b4071aa0139469.size ] = agent;
            }
        }
        
        foreach ( agent in var_b4b4071aa0139469 )
        {
            if ( !agent.pushingplayer )
            {
                agent thread ai_behavior::behavior_pushplayer( player, agent );
            }
        }
    }
}

// Namespace ai_reinforcements
// Params 0
// Checksum 0x451a8442, Offset: 0x6bb8
// Size: 0x21c
function function_9077c36b2171f937()
{
    level endon( #"game_ended" );
    interval = 1;
    setdvar( @"hash_26949904bad947e0", 0 );
    
    while ( true )
    {
        level.var_2d9e20cc8a208e77 = getdvarint( @"hash_26949904bad947e0", 0 ) == 1;
        
        if ( level.var_2d9e20cc8a208e77 )
        {
            subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", level.players[ 0 ].origin );
            
            if ( subarea )
            {
                budgetstruct = level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ];
            }
            else
            {
                budgetstruct = undefined;
            }
            
            if ( isdefined( budgetstruct.var_5d8751db294ae491 ) )
            {
                level thread debug::function_16b0d1fbf9c99e98( 600, 80, "-== STEALTH DEBUG KILL TRACKING == -", interval );
                level thread debug::function_16b0d1fbf9c99e98( 600, 100, "SUBAREA: " + subarea.subareaname, interval );
                level thread debug::function_16b0d1fbf9c99e98( 600, 120, "STEALTH KILLS:            " + budgetstruct.var_5d8751db294ae491, interval );
                
                if ( budgetstruct.var_e85d6ff0725889ea == -1 )
                {
                    text = "Stealth Not Tracking";
                }
                else
                {
                    text = ( budgetstruct.var_e85d6ff0725889ea - gettime() ) / 1000;
                }
                
                level thread debug::function_16b0d1fbf9c99e98( 600, 140, "STEALTH PTS DUMP TIME: " + text, interval );
            }
            else if ( isdefined( subarea ) )
            {
                level thread debug::function_16b0d1fbf9c99e98( 600, 80, "-== STEALTH DEBUG KILL TRACKING == -", interval );
                level thread debug::function_16b0d1fbf9c99e98( 600, 100, "SUBAREA: " + subarea.subareaname, interval );
                level thread debug::function_16b0d1fbf9c99e98( 600, 120, "Reinforcements disabled for this SubArea", interval );
            }
            else
            {
                level thread debug::function_16b0d1fbf9c99e98( 600, 80, "-== STEALTH DEBUG KILL TRACKING == -", interval );
                level thread debug::function_16b0d1fbf9c99e98( 600, 100, "SUBAREA: UNKNOWN", interval );
                level thread debug::function_16b0d1fbf9c99e98( 600, 120, "You are not in a subArea", interval );
            }
        }
        
        wait interval - 0.05;
    }
}

// Namespace ai_reinforcements
// Params 13
// Checksum 0x335d9a35, Offset: 0x6ddc
// Size: 0x4dc
function closet_requestreinforcements( numagents, reinforceorigin, priority, category, subcategory, groupname, team, var_6d02049e49f1e1a0, subarea, var_5130622e68f6876a, var_842419b3f43fc50, combatrushoriginvariance, nationality )
{
    if ( isdefined( level.radiation ) && level.radiation.spreading )
    {
        return;
    }
    
    reinforceorigin = ai_behavior::function_c916e757809745f2( reinforceorigin, subarea );
    reinforceorigin = ai_behavior::function_b49820d3792f8b12( reinforceorigin );
    
    if ( !isdefined( subarea ) )
    {
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", reinforceorigin, undefined, undefined, 1 );
    }
    
    fortress = function_90692244f4131ed5( reinforceorigin, subarea, var_5130622e68f6876a, var_842419b3f43fc50 );
    
    if ( !( isdefined( fortress ) && isdefined( fortress.spawnclosetnodes ) ) )
    {
        return;
    }
    
    spawnlocs = fortress.spawnclosetnodes;
    agents = [];
    starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
    spawnsetname = "guard";
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        var_599d450bd1f7dd3b = function_7c4eb2a03864d853( 0, 1, "reinforcements", 0 );
    }
    
    if ( !numagents || numagents == -1 )
    {
        reinforcementpoints = level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints;
        
        if ( reinforcementpoints <= 2 )
        {
            numagents = undefined;
        }
        
        if ( reinforcementpoints > 2 && reinforcementpoints <= 5 )
        {
            numagents = reinforcementpoints;
        }
        else
        {
            numagents = randomintrange( 3, 5 );
        }
    }
    
    foreach ( loc in spawnlocs )
    {
        loc.script_noteworthy = undefined;
        tier = ai_mp_controller::function_7063710b1014b9d0( starlevel );
        
        if ( tier != 1 && tier != 2 && tier != 3 )
        {
            tier = 1;
        }
        
        aitype = ai_mp_controller::function_b86341658788836c( loc, undefined, subarea, spawnsetname, undefined, tier, nationality );
        agents[ agents.size ] = ai_mp_controller::spawn( { #groupid:var_599d450bd1f7dd3b, #subarea:subarea, #team:team, #groupname:"closetSpawn", #subcategory:"closetSpawn", #category:"reinforcements", #priority:"medium", #spawnangles:loc.angles, #groundspawnorigin:loc.origin, #agenttype:aitype } );
        
        if ( agents.size >= numagents )
        {
            break;
        }
    }
    
    if ( isdefined( var_599d450bd1f7dd3b ) )
    {
        function_7ac170c0429491c1( var_599d450bd1f7dd3b, 1 );
    }
    
    var_85fcf5f4ad4ba99d = getdvarint( @"hash_3c77de36070e314c", 0 );
    
    foreach ( agent in agents )
    {
        br_dmz_radiation::function_5a5a89bee8ebb158( agent, reinforceorigin );
        agent thread ai_behavior::behavior_combatRushOrigin( agent, reinforceorigin, combatrushoriginvariance, undefined, undefined, 0 );
        
        if ( var_85fcf5f4ad4ba99d )
        {
            level thread debug::drawsphere( agent.origin, 128, 10, ( 0, 1, 0 ) );
        }
    }
    
    if ( isdefined( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints ) )
    {
        level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints -= agents.size;
    }
    
    return agents;
}

// Namespace ai_reinforcements
// Params 5
// Checksum 0x9f1a4a40, Offset: 0x72c1
// Size: 0x4a9
function function_90692244f4131ed5( origin, subarea, var_e667c6c7d0a7773c, maxdistfromorigin, var_a7167dc7e5ec6448 )
{
    if ( !isdefined( level.fortressstruct ) )
    {
        return;
    }
    
    if ( !isdefined( level.fortressstruct.var_53bdfafeb20e094e ) )
    {
        level.fortressstruct.var_53bdfafeb20e094e = ( getdvarint( @"hash_5f174bbb593ef9f4", 45 ) + getdvarint( @"hash_623de28f7e6a71a2", 10 ) ) * 1000;
    }
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( subarea ) )
    {
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", origin );
    }
    
    if ( !isdefined( var_e667c6c7d0a7773c ) )
    {
        var_e667c6c7d0a7773c = 2359296;
    }
    else
    {
        var_e667c6c7d0a7773c *= var_e667c6c7d0a7773c;
    }
    
    if ( !isdefined( maxdistfromorigin ) )
    {
        maxdistfromorigin = 30250000;
    }
    else
    {
        maxdistfromorigin *= maxdistfromorigin;
    }
    
    if ( !isdefined( var_a7167dc7e5ec6448 ) )
    {
        var_a7167dc7e5ec6448 = 1048576;
    }
    else
    {
        var_a7167dc7e5ec6448 *= var_a7167dc7e5ec6448;
    }
    
    var_28b9e8b22d6b8d58 = [];
    
    foreach ( fortress in level.fortressstruct.unusedfortresses )
    {
        if ( !fortress.spawnclosetnodes )
        {
            continue;
        }
        
        if ( fortress.poiname == subarea.poiname )
        {
            var_28b9e8b22d6b8d58[ var_28b9e8b22d6b8d58.size ] = fortress;
            continue;
        }
        
        if ( fortress.subarea == subarea )
        {
            var_28b9e8b22d6b8d58[ var_28b9e8b22d6b8d58.size ] = fortress;
        }
    }
    
    if ( var_28b9e8b22d6b8d58.size == 0 )
    {
        foreach ( fortress in level.fortressstruct.unusedfortresses )
        {
            if ( !fortress.spawnclosetnodes )
            {
                continue;
            }
            
            if ( fortress.areaname == subarea.areaname )
            {
                var_28b9e8b22d6b8d58[ var_28b9e8b22d6b8d58.size ] = fortress;
            }
        }
    }
    
    if ( var_28b9e8b22d6b8d58.size == 0 )
    {
        return;
    }
    
    var_28b9e8b22d6b8d58 = sortbydistance( var_28b9e8b22d6b8d58, origin );
    
    foreach ( fortress in var_28b9e8b22d6b8d58 )
    {
        playertooclose = 0;
        
        if ( !isdefined( level.poi[ subarea.poiname ][ "players" ] ) || level.poi[ subarea.poiname ][ "players" ] && level.poi[ subarea.poiname ][ "players" ].size == 0 )
        {
            var_28b9e8b22d6b8d58[ 0 ].var_bfdba4455c7f2ec3 = gettime() + level.fortressstruct.var_53bdfafeb20e094e;
            return var_28b9e8b22d6b8d58[ 0 ];
        }
        
        if ( function_743f8c353f6fb498( fortress ) )
        {
            continue;
        }
        
        var_78e73604d0bd66e7 = distance2dsquared( origin, fortress.origin );
        
        if ( var_78e73604d0bd66e7 < var_a7167dc7e5ec6448 )
        {
            continue;
        }
        else if ( var_78e73604d0bd66e7 > maxdistfromorigin )
        {
            break;
        }
        else
        {
            foreach ( player in level.poi[ subarea.poiname ][ "players" ] )
            {
                var_d18634d86314c894 = distance2dsquared( player.origin, fortress.origin );
                
                if ( var_d18634d86314c894 < var_e667c6c7d0a7773c )
                {
                    playertooclose = 1;
                    continue;
                }
                
                if ( playertooclose )
                {
                    break;
                }
            }
        }
        
        if ( !playertooclose )
        {
            fortress.var_bfdba4455c7f2ec3 = gettime() + level.fortressstruct.var_53bdfafeb20e094e;
            return fortress;
        }
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x1583086d, Offset: 0x7773
// Size: 0x35, Type: bool
function function_743f8c353f6fb498( fortress )
{
    if ( !isdefined( fortress.var_bfdba4455c7f2ec3 ) )
    {
        return false;
    }
    
    if ( fortress.var_bfdba4455c7f2ec3 < gettime() )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_reinforcements
// Params 5
// Checksum 0x51050b2a, Offset: 0x77b1
// Size: 0x16a
function function_fea9b22ccb187d4e( numagents, reinforceorigin, var_c130f2e6f49c2635, var_994027f8c7768fac, var_a7df765a83f1c2a7 )
{
    smokelocs = sortbydistancecullbyradius( level.var_ddfe07e6e98d74df, reinforceorigin, 1500 );
    mindistsq = 262144;
    var_fe45777260d244a = smokelocs;
    
    foreach ( loc in var_fe45777260d244a )
    {
        if ( distance2dsquared( loc.origin, reinforceorigin ) <= mindistsq )
        {
            arrayremove( smokelocs, loc );
            continue;
        }
        
        break;
    }
    
    var_b082fc06e46d2940 = 4;
    numgroups = ceil( numagents / var_b082fc06e46d2940 );
    agentsremaining = numagents;
    
    for ( i = 0; i < numgroups ; i++ )
    {
        var_3ec45facfbdbae73 = min( agentsremaining, var_b082fc06e46d2940 );
        level thread function_2d139d080e67181f( var_3ec45facfbdbae73, reinforceorigin, smokelocs[ i ], var_c130f2e6f49c2635, var_994027f8c7768fac, var_a7df765a83f1c2a7 );
        agentsremaining -= var_3ec45facfbdbae73;
        wait randomfloatrange( 1, 2 );
    }
}

// Namespace ai_reinforcements
// Params 6
// Checksum 0xb82c5809, Offset: 0x7923
// Size: 0x1dc
function function_2d139d080e67181f( numagents, reinforceorigin, smokeloc, var_c130f2e6f49c2635, var_994027f8c7768fac, var_a7df765a83f1c2a7 )
{
    var_593f5e05dab2d7b0 = 1500;
    
    if ( !isdefined( var_c130f2e6f49c2635 ) )
    {
        var_c130f2e6f49c2635 = 0;
    }
    
    if ( !isdefined( var_994027f8c7768fac ) )
    {
        var_994027f8c7768fac = 0;
    }
    
    if ( !isdefined( var_a7df765a83f1c2a7 ) )
    {
        var_a7df765a83f1c2a7 = 0;
    }
    
    vect = ( 0, var_593f5e05dab2d7b0, 0 );
    
    if ( smokeloc )
    {
        smokeorigin = smokeloc.origin;
    }
    else
    {
        smokeorigin = reinforceorigin + rotatepointaroundvector( ( 0, 0, 1 ), vect, randomintrange( 0, 359 ) );
    }
    
    groundpos = getgroundposition( smokeorigin, 1, 1000, 0 );
    scriptable = spawnscriptable( "rex_dmz_smoke_mortar", groundpos );
    scriptable setscriptablepartstate( "smoke", "smoke_launch" );
    thread function_ed87eb860cdc5e72( groundpos );
    partstate = scriptable getscriptablepartstate( "smoke" );
    
    while ( partstate != "smoke_loop" )
    {
        partstate = scriptable getscriptablepartstate( "smoke" );
        waitframe();
    }
    
    for ( i = 0; i < numagents ; i++ )
    {
        tier = function_e75020ee081445fa( var_c130f2e6f49c2635, var_994027f8c7768fac, var_a7df765a83f1c2a7 );
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, undefined, undefined, tier );
        var_bb92d96bc2e1a524 = ( randomfloatrange( -128, 128 ), randomfloatrange( -128, 128 ), 0 );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, groundpos + var_bb92d96bc2e1a524, ( 0, 0, 0 ), "absolute", "reinforcements", "defendSpawn", "defendSpawn" );
        
        if ( !isagent( agent ) )
        {
            return;
        }
        
        br_dmz_radiation::function_5a5a89bee8ebb158( agent, reinforceorigin );
        agent thread ai_behavior::behavior_combatRushOrigin( agent, reinforceorigin, undefined, undefined, undefined, 0 );
    }
}

// Namespace ai_reinforcements
// Params 1
// Checksum 0x9de82eeb, Offset: 0x7b07
// Size: 0x9b
function function_ed87eb860cdc5e72( groundpos )
{
    vect = ( 0, 300, 0 );
    
    for ( i = 0; i < 3 ; i++ )
    {
        smokeorigin = groundpos + rotatepointaroundvector( ( 0, 0, 1 ), vect, randomintrange( 0, 359 ) );
        scriptable = spawnscriptable( "rex_dmz_smoke_mortar", smokeorigin );
        scriptable setscriptablepartstate( "smoke", "smoke_launch" );
        wait randomfloatrange( 0.1, 0.3 );
    }
}

// Namespace ai_reinforcements
// Params 3
// Checksum 0xf0fc0764, Offset: 0x7baa
// Size: 0x87
function function_e75020ee081445fa( var_ca8a9e4770498cf9 = 0, tier2weight = 0, tier3weight = 0 )
{
    totalweight = var_ca8a9e4770498cf9 + tier2weight + tier3weight;
    
    if ( totalweight <= 0 )
    {
        return 1;
    }
    
    pick = randomintrange( 1, totalweight + 1 );
    
    if ( pick <= var_ca8a9e4770498cf9 )
    {
        return 1;
    }
    
    if ( pick <= var_ca8a9e4770498cf9 + tier2weight )
    {
        return 2;
    }
    
    return 3;
}

/#

    // Namespace ai_reinforcements
    // Params 0
    // Checksum 0xe2809362, Offset: 0x7c39
    // Size: 0xa67, Type: dev
    function function_855aeffb82f117b0()
    {
        level endon( #"game_ended" );
        
        foreach ( tier, tierarray in level.reinforcementoptions.var_15f05597dbbc3801 )
        {
            foreach ( index, vehiclename in level.reinforcementoptions.var_15f05597dbbc3801[ tier ] )
            {
                var_1ce27da6ee8e3c51 = getxhashsourcename( vehiclename );
                path = "<dev string:x34c>" + tier + "<dev string:x38a>" + var_1ce27da6ee8e3c51;
                command = "<dev string:x38c>" + tier + "<dev string:x3b7>" + var_1ce27da6ee8e3c51;
                devgui::add_devgui_command( path, command, index );
                path = "<dev string:x3b9>" + tier + "<dev string:x38a>" + var_1ce27da6ee8e3c51;
                command = "<dev string:x3fa>" + tier + "<dev string:x3b7>" + var_1ce27da6ee8e3c51;
                devgui::add_devgui_command( path, command, index );
            }
            
            waitframe();
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_2450e77b0430661c", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        helitype = getdvarint( @"hash_2450e77b0430661c", 1 );
                        
                        if ( helitype == 1 || helitype == 2 )
                        {
                            level thread debug_requestreinforcements( "<dev string:x443>", player.origin, team, player, %"veh_rex_air_heli_little_mp", undefined, helitype == 2 );
                        }
                        else if ( helitype == 3 || helitype == 4 )
                        {
                            level thread debug_requestreinforcements( "<dev string:x443>", player.origin, team, player, %"hash_506dea88804800e4", undefined, helitype == 4 );
                        }
                    }
                }
                
                setdevdvar( @"hash_2450e77b0430661c", 0 );
            }
            
            if ( getdvarint( @"hash_3812148f43182b8", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        level thread debug_requestreinforcements( "<dev string:x443>", player.origin, player.team );
                    }
                }
                
                setdevdvar( @"hash_3812148f43182b8", 0 );
            }
            
            vehicletype = getdvar( @"hash_56e9c6adae23f12b", "<dev string:x448>" );
            
            if ( vehicletype != "<dev string:x448>" )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        tier = int( getsubstr( vehicletype, 4, 5 ) );
                        vehiclename = getxhashasset( getsubstr( vehicletype, 6 ) );
                        level thread debug_requestreinforcements( "<dev string:x449>", player.origin, team, player, vehiclename, tier );
                    }
                }
                
                setdevdvar( @"hash_56e9c6adae23f12b", "<dev string:x448>" );
            }
            
            if ( getdvarint( @"hash_e98cb58666dc372d", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        level thread debug_requestreinforcements( "<dev string:x449>", player.origin, player.team );
                    }
                }
                
                setdevdvar( @"hash_e98cb58666dc372d", 0 );
            }
            
            if ( getdvarint( @"hash_ab9e351e7bdd4002", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        origin = ai_behavior::function_b49820d3792f8b12( player.origin );
                        level thread debug_requestreinforcements( "<dev string:x450>", origin, team );
                    }
                }
                
                setdevdvar( @"hash_ab9e351e7bdd4002", 0 );
            }
            
            if ( getdvarint( @"hash_534dfd9d53977a3a", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        origin = ai_behavior::function_b49820d3792f8b12( player.origin );
                        level thread debug_requestreinforcements( "<dev string:x450>", origin, player.team );
                    }
                }
                
                setdevdvar( @"hash_534dfd9d53977a3a", 0 );
            }
            
            if ( getdvarint( @"hash_249d0bd1bced7236", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        origin = ai_behavior::function_b49820d3792f8b12( player.origin );
                        level thread debug_requestreinforcements( "<dev string:x45b>", origin, team, player );
                    }
                }
                
                setdevdvar( @"hash_249d0bd1bced7236", 0 );
            }
            
            if ( getdvarint( @"hash_867ce306c3674a56", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        origin = ai_behavior::function_b49820d3792f8b12( player.origin );
                        team = player.team;
                        level thread debug_requestreinforcements( "<dev string:x45b>", origin, team, player );
                    }
                }
                
                setdevdvar( @"hash_867ce306c3674a56", 0 );
            }
            
            if ( getdvarint( @"hash_88ae422170005010", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        origin = ai_behavior::function_b49820d3792f8b12( player.origin );
                        level thread reinforce_requestreinforcements( 2, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, player.team );
                    }
                }
                
                setdevdvar( @"hash_88ae422170005010", 0 );
            }
            
            if ( getdvarint( @"hash_7882eb2f0ed5ba94", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        origin = ai_behavior::function_b49820d3792f8b12( player.origin );
                        level thread reinforce_requestreinforcements( 5, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, team );
                    }
                }
                
                setdevdvar( @"hash_7882eb2f0ed5ba94", 0 );
            }
            
            if ( getdvarint( @"hash_dd00a99e0fc8f650", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        level thread debug_requestreinforcements( "<dev string:x47a>", player.origin, team, player );
                    }
                }
                
                setdevdvar( @"hash_dd00a99e0fc8f650", 0 );
            }
            
            if ( getdvarint( @"hash_a880595a62e6c674", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        level thread debug_requestreinforcements( "<dev string:x47a>", player.origin, player.team, player );
                    }
                }
                
                setdevdvar( @"hash_a880595a62e6c674", 0 );
            }
            
            if ( getdvarint( @"hash_61fc4efede6cbbe2", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    team = undefined;
                    
                    if ( game_utility::getgametype() == "<dev string:x426>" )
                    {
                        if ( isdefined( level.var_7ba393bd5b21cc2d ) )
                        {
                            team = level.var_7ba393bd5b21cc2d;
                        }
                        else
                        {
                            team = "<dev string:x42a>";
                        }
                    }
                    else
                    {
                        team = team_utility::getotherteam( player.team );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        level thread debug_requestreinforcements( "<dev string:x481>", player.origin, team, player );
                    }
                }
                
                setdevdvar( @"hash_61fc4efede6cbbe2", 0 );
            }
            
            if ( getdvarint( @"hash_f823061619fb9d9a", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        level thread debug_requestreinforcements( "<dev string:x481>", player.origin, player.team, player );
                    }
                }
                
                setdevdvar( @"hash_f823061619fb9d9a", 0 );
            }
            
            if ( getdvarint( @"hash_e66a4e3d3c5ab690", 0 ) > 0 )
            {
                if ( level.supportsai )
                {
                    player = level.players[ 0 ];
                    
                    if ( isdefined( player ) )
                    {
                        level thread utility::callsharedfunc( #"starSystemReinforcements", #"hash_50be6ea55fc7d341", player, getdvarint( @"hash_e66a4e3d3c5ab690", 0 ) );
                    }
                }
                
                setdevdvar( @"hash_e66a4e3d3c5ab690", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace ai_reinforcements
    // Params 7
    // Checksum 0x4dab944, Offset: 0x86a8
    // Size: 0x4d6, Type: dev
    function debug_requestreinforcements( type, origin, team, player, specificvehicletype, tier, fastunload )
    {
        agents = undefined;
        subarea = undefined;
        
        if ( isdefined( player ) )
        {
            subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", player.origin );
        }
        
        nationalityid = utility::callsharedfunc( #"poi", #"hash_e8d82f43da156688", origin, subarea );
        
        switch ( type )
        {
            case #"hash_b111a4547c7d9125":
                if ( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints )
                {
                    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints += 4;
                }
                
                agents = function_1faa63a0b398c676( 4, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, team, 1, subarea, type, undefined, undefined, undefined, nationalityid, fastunload, undefined, undefined, undefined, specificvehicletype );
                break;
            case #"hash_8d96201d150187de":
                if ( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints )
                {
                    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints += 4;
                }
                
                var_6fc710600b539c60 = function_c6a741f41aaede19( 6, undefined, tier );
                agents = function_1faa63a0b398c676( 6, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, team, undefined, subarea, type, undefined, undefined, var_6fc710600b539c60, nationalityid, undefined, undefined, undefined, undefined, specificvehicletype );
                break;
            case #"hash_f2a2ef6a2b0d207c":
                function_d0a9530035c6dc35( origin, 2048, "<dev string:x42a>", undefined, undefined, 32, 32, undefined, undefined, undefined, 200 );
                break;
            case #"hash_c72bb484b209c08b":
                agents = function_1faa63a0b398c676( 5, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, team, undefined, subarea, type );
                break;
            case #"hash_f0e5b0c514493855":
                if ( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints )
                {
                    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints += 4;
                }
                
                agents = function_1faa63a0b398c676( 4, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, team, undefined, subarea, type );
                break;
            case #"hash_8b66cdb7a2b06217":
                if ( level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints )
                {
                    level.aibudgets.areas[ subarea.areaname ][ subarea.subareaname ].reinforcementpoints += 4;
                }
                
                agents = function_1faa63a0b398c676( 4, origin, "<dev string:x460>", "<dev string:x465>", "<dev string:x474>", undefined, team, undefined, subarea, type );
                break;
        }
        
        if ( !isdefined( origin ) )
        {
            origin = player.origin;
        }
        
        if ( isarray( agents ) )
        {
            poiname = poi::poi_findpoioriginisin( origin );
            level thread function_cc09697b3048416b( poiname, origin, subarea, player );
        }
    }

    // Namespace ai_reinforcements
    // Params 1
    // Checksum 0x593eefc4, Offset: 0x8b86
    // Size: 0x14d, Type: dev
    function function_1e040f980370bfcb( substring )
    {
        while ( !flags::gameflagexists( "<dev string:x24>" ) || flags::gameflagexists( "<dev string:x24>" ) && !flags::gameflag( "<dev string:x24>" ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            foreach ( subarea in level.subareas )
            {
                if ( issubstr( subarea.subareaname, substring ) )
                {
                    agent = utility::array_random( subarea.livingagents );
                    
                    if ( !isdefined( agent ) )
                    {
                        continue;
                    }
                    
                    if ( isint( agent ) )
                    {
                        continue;
                    }
                    
                    if ( agent.vehicle )
                    {
                        continue;
                    }
                    
                    agent.var_68b7af9656ecff14 = 1;
                    agent kill( level.players[ 0 ].origin, level.players[ 0 ] );
                    wait 0.5;
                }
            }
            
            wait 4;
        }
    }

#/
