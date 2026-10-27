// script_1df1ae965888eae  (hash_01df1ae965888eae.gscc) (size: 4458 Bytes / 0x116a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15b24803 (364005379)
// size ...... 4458 (0x116a)
// includes .. 6   (offset: 0x104e)
// strings ... 17  (offset: 0x107e)
// dev strs .. 1   (offset: 0x115e)
// exports ... 11  (offset: 0xa7a)
// cseg ...... 0x1f9 + 0x881 (0xa7a)
// imports ... 36  (offset: 0xc32)
// animtree1 . 0   (offset: 0x116a)
// animtree2 . 0   (offset: 0x116a)
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\utility\teams;

#namespace namespace_384fce4a31518799;

// Namespace namespace_384fce4a31518799
// Params 1
// Checksum 0x3b2355d4, Offset: 0x217
// Size: 0xe8
function getcontractdata( data )
{
    level.var_66cc2b30d8b7a0 = spawnstruct();
    level.var_66cc2b30d8b7a0.time = getdvarint( @"hash_f3296f3f7c79bfb8", 240 );
    level.var_66cc2b30d8b7a0.maxrange = getdvarint( @"hash_79550894c085d1db", 45000 );
    level.var_66cc2b30d8b7a0.var_a78f4e37e17d8c6 = getdvarint( @"hash_1b3cc7a99c2f33e5", 25000 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_infiltration_accept" ] = "mission_mission_time_accept";
    game[ "dialog" ][ "mission_infiltration_fail" ] = "mission_mission_time_failed";
    data.funcs[ "onInit" ] = &strongholdinfil_oninit;
    data.funcs[ "onTeamAssigned" ] = &strongholdinfil_onteamassigned;
}

// Namespace namespace_384fce4a31518799
// Params 0
// Checksum 0xec5e3b16, Offset: 0x307
// Size: 0x39, Type: bool
function strongholdinfil_oninit()
{
    if ( br_strongholds::function_15f893a51b7d6d7c() )
    {
        self.tablet.startdisabled = 1;
    }
    
    self.tablet.strongholdcontract = 1;
    return true;
}

// Namespace namespace_384fce4a31518799
// Params 0
// Checksum 0x61e4468b, Offset: 0x349
// Size: 0x192
function strongholdinfil_onteamassigned()
{
    if ( !isdefined( self.fortress ) )
    {
        fortress = self.tablet function_3f8f8b44f0111f74();
        
        if ( !isdefined( fortress ) )
        {
            thread function_145f99ab12cfc127( 1 );
            return;
        }
        
        self.fortress = fortress;
    }
    
    br_contract_manager::function_87e10a6e85d45d58( "strongholdInfil" );
    time = level.var_66cc2b30d8b7a0.time;
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    thread function_6c5c82c5504ac247( time );
    thread function_9ce5bc21287a0224();
    br_contract_manager::function_5c7e547ccc13711b( "stronghold_infil_contract_accepted" );
    level thread br_public::brleaderdialogteam( "mission_infiltration_accept", self.team, 1, 1 );
    self.curorigin = self.fortress.origin;
    br_contract_manager::createquestobjicon( "ui_map_icon_obj_fortress", "current", self.curorigin + ( 0, 0, 65 ) );
    players = teams::getteamdata( self.team, "players" );
    
    foreach ( player in players )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
    
    thread strongholdinfil_detectwinners();
}

// Namespace namespace_384fce4a31518799
// Params 1
// Checksum 0xbc9528cf, Offset: 0x4e3
// Size: 0x10e
function function_145f99ab12cfc127( success )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        br_contract_manager::deletequestobjicon();
    }
    
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    br_contract_manager::endcontract( success );
    
    if ( isdefined( self.fortress ) && success )
    {
        self.fortress.infiltrated = 1;
        self.fortress.var_4fd1a4d3c3c59033 = self.team;
        self.fortress notify( #"stronghold_infiltrated" );
        ai_fortress::function_6afabfde369e039c( self.fortress, 1 );
        logstring( "BR STRONGHOLD " + function_f02c63b99c9614c9( level.fortressstruct.chosenfortresses, self.fortress ) + ": Fortress Infiltrated!" );
        return;
    }
    
    if ( success )
    {
    }
}

// Namespace namespace_384fce4a31518799
// Params 1
// Checksum 0x351746db, Offset: 0x5f9
// Size: 0x2e
function function_6c5c82c5504ac247( time )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    wait time;
    strongholdinfil_fail();
}

// Namespace namespace_384fce4a31518799
// Params 0
// Checksum 0xa9988881, Offset: 0x62f
// Size: 0x38
function function_9ce5bc21287a0224()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    self.fortress waittill( #"stronghold_infiltrated" );
    strongholdinfil_fail( 1 );
}

// Namespace namespace_384fce4a31518799
// Params 1
// Checksum 0x17a23a96, Offset: 0x66f
// Size: 0x78
function strongholdinfil_fail( enemycaptured = 0 )
{
    params = spawnstruct();
    params.intvar = 0;
    splash = "stronghold_infil_contract_failed";
    
    if ( enemycaptured )
    {
        splash = "stronghold_infil_contract_poached";
    }
    
    br_contract_manager::function_5c7e547ccc13711b( splash, params );
    level thread br_public::brleaderdialogteam( "mission_infiltration_fail", self.team, 1, 1 );
    thread function_145f99ab12cfc127( 0 );
}

// Namespace namespace_384fce4a31518799
// Params 1
// Checksum 0xaaf8fd85, Offset: 0x6ef
// Size: 0x195
function function_3f8f8b44f0111f74( includeblacksite )
{
    locations = arrayrandomize( level.fortressstruct.chosenfortresses );
    fortress = undefined;
    var_49bdf85b1540dcb2 = level.var_66cc2b30d8b7a0.maxrange;
    
    foreach ( location in locations )
    {
        if ( location.infiltrated )
        {
            continue;
        }
        
        if ( location.isblacksite && !includeblacksite )
        {
            continue;
        }
        
        incircle = br_circle_util::function_3199bf5530fd0bc2( location.origin );
        
        if ( !incircle )
        {
            continue;
        }
        
        if ( location.unspawned )
        {
            continue;
        }
        
        dist = distance2d( location.origin, self.origin );
        var_ac99ac222f6bbc72 = 0;
        
        if ( dist > level.var_66cc2b30d8b7a0.var_a78f4e37e17d8c6 )
        {
            var_ac99ac222f6bbc72 = dist - level.var_66cc2b30d8b7a0.var_a78f4e37e17d8c6;
        }
        
        if ( var_ac99ac222f6bbc72 < var_49bdf85b1540dcb2 )
        {
            var_49bdf85b1540dcb2 = var_ac99ac222f6bbc72;
            fortress = location;
            
            if ( var_ac99ac222f6bbc72 <= 0 )
            {
                break;
            }
        }
    }
    
    return fortress;
}

// Namespace namespace_384fce4a31518799
// Params 2
// Checksum 0xd7de24ad, Offset: 0x88d
// Size: 0xfa
function strongholdinfil_finishlinevfx( spawn_origin, team )
{
    finishlinevfx = spawnfx( level._effect[ "vfx_marker_base_orange_pulse" ], spawn_origin + ( 0, 0, 10 ) );
    finishlinevfx.angles = vectortoangles( ( 0, 0, 1 ) );
    finishlinevfx hide();
    wait 0.5;
    triggerfx( finishlinevfx );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        finishlinevfx showtoplayer( player );
    }
    
    self.finishlinevfx = finishlinevfx;
}

// Namespace namespace_384fce4a31518799
// Params 0
// Checksum 0xbc99f16f, Offset: 0x98f
// Size: 0xeb
function strongholdinfil_detectwinners()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( distance2d( player.origin, self.fortress.missiontrigger.origin ) < self.fortress.missiontrigger.radius )
            {
            }
        }
        
        waitframe();
    }
}

