// script_7fa8040f6c869050  (hash_7fa8040f6c869050.gscc) (size: 3767 Bytes / 0xeb7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x99f844ae (2583184558)
// size ...... 3767 (0xeb7)
// includes .. 7   (offset: 0xd1f)
// strings ... 24  (offset: 0xd57)
// dev strs .. 0   (offset: 0xeb7)
// exports ... 10  (offset: 0x83f)
// cseg ...... 0x237 + 0x608 (0x83f)
// imports ... 28  (offset: 0x9cf)
// animtree1 . 0   (offset: 0xeb7)
// animtree2 . 0   (offset: 0xeb7)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace dmz_supply_drops;

// Namespace dmz_supply_drops
// Params 0
// Checksum 0x3eac5b5b, Offset: 0x255
// Size: 0x1f0
function init()
{
    br_supply_drops_common::init();
    level.var_4280cdebdfea8385 = getdvarint( @"hash_36a630e359ea8611", 16000 );
    dropstruct = br_supply_drops_common::function_2c34853680769fd9( "dmz_mission_reward", "military_crate_carepackage_rig_dmz" );
    br_supply_drops_common::function_9d48fde0cd4ee1d5( "dmz_mission_reward", "onDropSpawned", &function_226ba157f425380a );
    br_supply_drops_common::function_9d48fde0cd4ee1d5( "dmz_mission_reward", "spawnDropCrate", &function_62a30c1d4771b1f6 );
    dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
    dropstruct.var_2fd5afa46e56e8f6 = 0;
    dropstruct = br_supply_drops_common::function_2c34853680769fd9( "dmz_killstreak_reward", "military_crate_carepackage_rig_dmz" );
    br_supply_drops_common::function_9d48fde0cd4ee1d5( "dmz_killstreak_reward", "onDropSpawned", &function_226ba157f425380a );
    br_supply_drops_common::function_9d48fde0cd4ee1d5( "dmz_killstreak_reward", "spawnDropCrate", &function_62a30c1d4771b1f6 );
    br_supply_drops_common::function_9d48fde0cd4ee1d5( "dmz_killstreak_reward", "planeDropRun", &function_e59805d9cf4d1cae );
    dropstruct.planemodel = "veh9_mil_air_cargo_plane_wm_dmz";
    dropstruct.var_2fd5afa46e56e8f6 = 0;
    level.var_95bd2f4b7e19613a = [];
    level.var_95bd2f4b7e19613a[ "common" ] = "dmz_mission_reward_common";
    level.var_95bd2f4b7e19613a[ "uncommon" ] = "dmz_mission_reward_uncommon";
    level.var_95bd2f4b7e19613a[ "rare" ] = "dmz_mission_reward_rare";
    level.var_95bd2f4b7e19613a[ "epic" ] = "dmz_mission_reward_epic";
    level.var_95bd2f4b7e19613a[ "legendary" ] = "dmz_mission_reward_legendary";
    level.var_6256db70994942ed = [];
    level.var_6256db70994942ed[ 1 ] = "uncommon";
    level.var_6256db70994942ed[ 2 ] = "rare";
    level.var_6256db70994942ed[ 3 ] = "epic";
    level.var_6256db70994942ed[ 4 ] = "legendary";
    level.var_6256db70994942ed[ "fallback" ] = "legendary";
    
    if ( getdvarint( @"hash_531f1530cb50bb4a", 0 ) == 0 )
    {
        return;
    }
    
    level thread function_5072f5a2a4f51280();
}

// Namespace dmz_supply_drops
// Params 2
// Checksum 0x2a2522c2, Offset: 0x44d
// Size: 0x78
function function_e59805d9cf4d1cae( dropstruct, pos )
{
    prevdistance = distance2d( self.origin, pos );
    
    while ( true )
    {
        newdistance = distance2d( self.origin, pos );
        
        if ( newdistance > prevdistance )
        {
            break;
        }
        
        prevdistance = newdistance;
        waitframe();
    }
    
    br_supply_drops_common::brsupplydrop_spawn( pos, level.supplydroptypes[ "dmz_killstreak_reward" ] );
}

// Namespace dmz_supply_drops
// Params 3
// Checksum 0x115a70ea, Offset: 0x4cd
// Size: 0x63
function function_62a30c1d4771b1f6( dropend, dropstruct, dropstart )
{
    crate = br_supply_drops_common::function_85cc64e2a6e80987( dropend, dropstruct, dropstart );
    crate.nochute = 1;
    crate.var_dbd8dfc4d8cbaf6c = 1;
    crate.var_dcd245efa3ae2e6d = &function_6e5d311ff6fa22f6;
    return crate;
}

// Namespace dmz_supply_drops
// Params 2
// Checksum 0x1b79b4e0, Offset: 0x539
// Size: 0x1f
function function_6e5d311ff6fa22f6( player, crate )
{
    br::function_abafdefb2f831e7b( crate, player );
}

// Namespace dmz_supply_drops
// Params 1
// Checksum 0x71647091, Offset: 0x560
// Size: 0x2b
function function_226ba157f425380a( dropend )
{
    var_fc7bb437732e8a83 = "cashdrop_common";
    self setscriptablepartstate( "objective_map", var_fc7bb437732e8a83, 0 );
}

// Namespace dmz_supply_drops
// Params 0
// Checksum 0x7e2c85fa, Offset: 0x593
// Size: 0x13f
function function_5072f5a2a4f51280()
{
    flags::gameflagwait( "prematch_done" );
    waittime = getdvarint( @"hash_7affedbe66b614ea", 300 );
    wait waittime;
    level thread function_ca43863fdad4a54f();
    teamcount = level.teamswithplayers.size;
    
    if ( teamcount > 1 )
    {
        posone = function_4664d0d6270ac2c0( level.teamswithplayers[ 0 ] );
        postwo = function_4664d0d6270ac2c0( level.teamswithplayers[ 1 ] );
        
        if ( isdefined( posone ) && isdefined( postwo ) )
        {
            pos = ( posone + postwo ) / 2;
            br_supply_drops_common::brsupplydrop_run( utility::drop_to_ground( pos ), "dmz_c17_drop" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) )
        {
            function_f60f9e687d39bad4( player );
            return;
        }
    }
}

// Namespace dmz_supply_drops
// Params 0
// Checksum 0xea977cf7, Offset: 0x6da
// Size: 0x1a
function function_ca43863fdad4a54f()
{
    wait 3;
    br_gametype_dmz::showdmzsplash( "dmz_supply_drop", level.players );
}

// Namespace dmz_supply_drops
// Params 1
// Checksum 0x4d36ce58, Offset: 0x6fc
// Size: 0x87
function function_f60f9e687d39bad4( player )
{
    droppos = player.origin;
    mindropdist = getdvarint( @"hash_ab10323144550acf", 2000 );
    var_c606616b1bed6e3c = getdvarint( @"hash_a002dde97cd0623e", 3000 );
    droppos = utility::drop_to_ground( droppos + vectornormalize( utility::function_9e0df7b136ab833c() ) * ( randomint( var_c606616b1bed6e3c ) + mindropdist ), 10500 );
    br_supply_drops_common::brsupplydrop_run( droppos, "dmz_c17_drop" );
}

// Namespace dmz_supply_drops
// Params 1
// Checksum 0x8773ef02, Offset: 0x78b
// Size: 0xb3
function function_4664d0d6270ac2c0( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) && isdefined( player.origin ) )
        {
            return player.origin;
        }
    }
}

