// script_1f995c07c7e9620d  (hash_1f995c07c7e9620d.gscc) (size: 6318 Bytes / 0x18ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe6217f98 (3860955032)
// size ...... 6318 (0x18ae)
// includes .. 8   (offset: 0x1776)
// strings ... 13  (offset: 0x17b6)
// dev strs .. 5   (offset: 0x1872)
// exports ... 16  (offset: 0x1002)
// cseg ...... 0x167 + 0xe9b (0x1002)
// imports ... 41  (offset: 0x1282)
// animtree1 . 0   (offset: 0x18ae)
// animtree2 . 0   (offset: 0x18ae)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace activity_hop_heat_mostwanted;

// Namespace activity_hop_heat_mostwanted
// Params 0
// Checksum 0xead94f1a, Offset: 0x185
// Size: 0x20a
function init()
{
    level endon( #"game_ended" );
    hopbundle = level.brgametype.hop_bundle;
    
    if ( !getdvarint( @"hash_df33f1ae344d3ef", hopbundle.var_3b90b45d773438fe ?? 0 ) )
    {
        return;
    }
    
    level.hopheat = { #enabled:0, #activitydefname:hopbundle.var_87f679b699a326c7 ?? "wz_sat_activity_mostwanted_bongo_hp", #var_8a16d102c01f16a1:getdvarint( @"hash_1c0ae7b1f5e09c90", hopbundle.var_b1cd5393ad12cd53 ?? 30000 ), #decayrate:getdvarint( @"hash_a500d2b2b320678f", hopbundle.var_b681e146ac4ee9c4 ?? 1 ), #var_d594121334fe24de:getdvarint( @"hash_900b5a010584ca07", hopbundle.var_1af5417eb0a91220 ?? 2 ), #var_c0ce27506784888f:getdvarint( @"hash_c269e665d005f90e", hopbundle.var_b8c990913578edb5 ?? 1 ), #heatthreshold:getdvarint( @"hash_af4dfb133d89056d", hopbundle.var_9628fbeb7289c398 ?? 5 ), #var_315868abc72ccc5:getdvarint( @"hash_c095f28b90082c5", hopbundle.var_2377ee14cab67072 ?? 5 ), #var_cc0e4315eede2fec:[] };
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"player_spawned", &onplayerspawned );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level thread function_92c6508c55390714();
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &function_9bbe799f77e34961 );
    level.hopheat.variantregistered = function_3d5b35daca15228b();
    level.hopheat.enabled = level.hopheat.variantregistered;
    
    /#
        level thread testmostwanted();
    #/
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0xa00d7ce6, Offset: 0x397
// Size: 0x38
function private onplayerspawned( params )
{
    if ( !isdefined( self.hopheat ) )
    {
        self.hopheat = 0;
    }
    
    if ( !isdefined( self.var_d0471a7afc72c327 ) )
    {
        self.var_d0471a7afc72c327 = 0;
    }
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0xfab5bb4a, Offset: 0x3d7
// Size: 0x7f
function private onplayerdeath( deathdata )
{
    attacker = deathdata.attacker;
    victim = self;
    
    if ( !attacker || !isplayer( attacker ) )
    {
        return;
    }
    
    if ( attacker == victim || attacker.team == victim.team )
    {
        return;
    }
    
    addheat( attacker, level.hopheat.var_c0ce27506784888f );
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0x73956134, Offset: 0x45e
// Size: 0xcf
function private function_9bbe799f77e34961( params )
{
    activityinstance = self;
    
    if ( activityinstance.var_d0471a7afc72c327 )
    {
        return;
    }
    
    players = activityinstance.playerparticipants;
    
    foreach ( player in players )
    {
        if ( player && isplayer( player ) )
        {
            addheat( player, level.hopheat.var_d594121334fe24de );
        }
    }
}

// Namespace activity_hop_heat_mostwanted
// Params 2, eflags: 0x4
// Checksum 0x445be226, Offset: 0x535
// Size: 0xb1
function private addheat( player, amount )
{
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    if ( player.var_d0471a7afc72c327 )
    {
        return;
    }
    
    if ( !isdefined( player.hopheat ) )
    {
        player.hopheat = 0;
    }
    
    player.hopheat += amount;
    threshold = getdvarint( @"hash_af4dfb133d89056d", level.hopheat.heatthreshold );
    
    if ( player.hopheat >= threshold )
    {
        function_f7a871614eeb8df9( player );
    }
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0xb1673bfb, Offset: 0x5ee
// Size: 0xb8
function private function_f7a871614eeb8df9( player )
{
    if ( !level.hopheat.enabled )
    {
        return;
    }
    
    if ( player.var_d0471a7afc72c327 )
    {
        return;
    }
    
    if ( function_59a0146bdec2f555( player.team ) )
    {
        return;
    }
    
    level.hopheat.var_315868abc72ccc5 = getdvarint( @"hash_c095f28b90082c5", level.hopheat.var_315868abc72ccc5 );
    function_10b67de62486ae56();
    
    if ( level.hopheat.var_cc0e4315eede2fec.size >= level.hopheat.var_315868abc72ccc5 )
    {
        return;
    }
    
    function_52ce51d81977840f( player );
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0x9d94cef8, Offset: 0x6ae
// Size: 0x2d3
function private function_52ce51d81977840f( player )
{
    if ( !level.hopheat.variantregistered )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    mostwantedinstance = activity_instance_common::function_9b387cb1af0d5b4b( "hop_heat_mostwanted" );
    
    if ( !mostwantedinstance )
    {
        println( "<dev string:x5f>" );
        return;
    }
    
    mostwantedinstance.var_ca369031b554da2f = player;
    mostwantedinstance.var_d0471a7afc72c327 = 1;
    mostwantedinstance.team = player.team;
    teamplayers = teams::getteamdata( player.team, "players" );
    activity_participation::function_fb0ec90aaf6d4c61( mostwantedinstance, teamplayers );
    entnum = player getentitynumber();
    
    foreach ( teamplayer in teamplayers )
    {
        teamplayer setclientomnvar( "ui_activity_description_param", entnum );
    }
    
    level.hopheat.var_cc0e4315eede2fec[ level.hopheat.var_cc0e4315eede2fec.size ] = mostwantedinstance;
    player.hopheat = 0;
    player.var_d0471a7afc72c327 = 1;
    mostwantedinstance thread function_90a48136a1c5dcc( player );
    mostwantedinstance thread function_6f7d741e2c504a79( player );
    var_13934742c9378caa = player getclientomnvar( o"ui_veh_occupant_faction" ) == 1;
    var_563452d5b74e342a = var_13934742c9378caa ? #"hash_f7dbf99fca4a57e2" : #"hash_f815cf9fca7b88cb";
    var_d1a9d0a532f284d3 = var_13934742c9378caa ? #"hash_f7dbeb9fca4a4018" : #"hash_f815dd9fca7ba095";
    
    if ( var_13934742c9378caa && !player.var_8088c8dcb343d196 || !var_13934742c9378caa && !player.var_a183c6d545738866 )
    {
        player playsoundtoplayer( var_563452d5b74e342a, player );
        
        foreach ( otherplayer in level.players )
        {
            if ( player != otherplayer )
            {
                otherplayer playsoundtoplayer( var_d1a9d0a532f284d3, otherplayer );
            }
        }
        
        if ( var_13934742c9378caa )
        {
            player.var_8088c8dcb343d196 = 1;
            return;
        }
        
        player.var_a183c6d545738866 = 1;
    }
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0xc18e50eb, Offset: 0x989
// Size: 0x130
function private function_90a48136a1c5dcc( player )
{
    utility::waittill_any( "activity_failed", "activity_succeeded", "activity_ended", "instance_destroyed" );
    
    if ( player )
    {
        player.var_d0471a7afc72c327 = 0;
        targetentnum = player getentitynumber();
        teamplayers = teams::getteamdata( player.team, "players" );
        
        foreach ( teamplayer in teamplayers )
        {
            if ( teamplayer getclientomnvar( "ui_activity_description_param" ) == targetentnum )
            {
                teamplayer setclientomnvar( "ui_activity_description_param", -1 );
            }
        }
    }
    
    if ( level.hopheat )
    {
        level.hopheat.var_cc0e4315eede2fec = arrayremove( level.hopheat.var_cc0e4315eede2fec, self );
    }
    
    function_59fd972216991bd0();
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0x9d2cd704, Offset: 0xac1
// Size: 0x5a
function private function_6f7d741e2c504a79( player )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    player waittill( #"mostwanted_activity_started" );
    waittillframeend();
    
    if ( self.var_332f929de1894b2b )
    {
        activity_definition_utils::updatetimer( self.var_332f929de1894b2b.contracttime, self );
    }
}

// Namespace activity_hop_heat_mostwanted
// Params 0, eflags: 0x4
// Checksum 0xe0889d07, Offset: 0xb23
// Size: 0xcd, Type: bool
function private function_3d5b35daca15228b()
{
    if ( isdefined( level.activities.definitions[ "hop_heat_mostwanted" ] ) )
    {
        return true;
    }
    
    bundlename = level.hopheat.activitydefname;
    
    if ( !isxhashasset( bundlename ) )
    {
        bundlename = "activityDefinition:" + bundlename;
    }
    
    testbundle = getscriptbundle( bundlename );
    
    if ( !testbundle )
    {
        println( "<dev string:x8f>" + level.hopheat.activitydefname + "<dev string:xb6>" );
        return false;
    }
    
    activity_definition_utils::function_74af1ab4059e3c06( level.hopheat.activitydefname, "hop_heat_mostwanted" );
    return isdefined( level.activities.definitions[ "hop_heat_mostwanted" ] );
}

// Namespace activity_hop_heat_mostwanted
// Params 0, eflags: 0x4
// Checksum 0x6ba5290, Offset: 0xbf9
// Size: 0xd5
function private function_10b67de62486ae56()
{
    state = level.hopheat;
    pruned = [];
    
    foreach ( instance in state.var_cc0e4315eede2fec )
    {
        if ( instance )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                pruned[ pruned.size ] = instance;
            }
        }
    }
    
    state.var_cc0e4315eede2fec = pruned;
}

// Namespace activity_hop_heat_mostwanted
// Params 1, eflags: 0x4
// Checksum 0xbb46616c, Offset: 0xcd6
// Size: 0xca, Type: bool
function private function_59a0146bdec2f555( team )
{
    foreach ( instance in level.hopheat.var_cc0e4315eede2fec )
    {
        if ( instance && instance.team == team )
        {
            instancestate = activity_instance_common::getactivitystate( instance );
            
            if ( instancestate != "Ended" && instancestate != "Cleanup" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace activity_hop_heat_mostwanted
// Params 0, eflags: 0x4
// Checksum 0x87eaa694, Offset: 0xda9
// Size: 0x151
function private function_92c6508c55390714()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        decayinterval = getdvarint( @"hash_1c0ae7b1f5e09c90", level.hopheat.var_8a16d102c01f16a1 ) / 1000;
        wait max( 0.1, decayinterval );
        decayrate = getdvarint( @"hash_a500d2b2b320678f", level.hopheat.decayrate );
        
        if ( decayrate <= 0 )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            if ( player && isalive( player ) && player.hopheat && player.hopheat > 0 )
            {
                if ( !player.var_d0471a7afc72c327 )
                {
                    player.hopheat = max( 0, player.hopheat - decayrate );
                }
            }
        }
    }
}

// Namespace activity_hop_heat_mostwanted
// Params 0, eflags: 0x4
// Checksum 0xfcba83b0, Offset: 0xf02
// Size: 0x77
function private function_59fd972216991bd0()
{
    if ( level.activitymanager )
    {
        level.activitymanager.var_cc0e4315eede2fec = arrayremove( level.activitymanager.var_cc0e4315eede2fec, self );
        
        if ( level.activitymanager.var_ec04bf3a584cbd90[ self.team ] )
        {
            level.activitymanager.var_ec04bf3a584cbd90[ self.team ] = undefined;
        }
    }
}

/#

    // Namespace activity_hop_heat_mostwanted
    // Params 0, eflags: 0x4
    // Checksum 0xa20eb3e8, Offset: 0xf81
    // Size: 0x81, Type: dev
    function private testmostwanted()
    {
        self endon( #"game_ended" );
        flags::function_2f3408423ccc9b2e( "<dev string:xfa>" );
        
        while ( true )
        {
            mostwantedindex = getdvarint( @"hash_bd852a7469d4fc4b", -1 );
            
            if ( mostwantedindex >= 0 && mostwantedindex < level.players.size )
            {
                addheat( level.players[ mostwantedindex ], 999 );
                setdvar( @"hash_bd852a7469d4fc4b", -1 );
            }
            
            wait 1;
        }
    }

#/
