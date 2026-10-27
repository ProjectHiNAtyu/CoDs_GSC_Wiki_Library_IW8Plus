// scripts\mp\ob\systems\ob_music.gsc  (hash_39ed36ec8127fdd0.gscc) (size: 6781 Bytes / 0x1a7d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbdd2f33 (4225576755)
// size ...... 6781 (0x1a7d)
// includes .. 7   (offset: 0x190d)
// strings ... 21  (offset: 0x1945)
// dev strs .. 0   (offset: 0x1a7d)
// exports ... 32  (offset: 0xdfd)
// cseg ...... 0x290 + 0xb6d (0xdfd)
// imports ... 49  (offset: 0x12fd)
// animtree1 . 0   (offset: 0x1a7d)
// animtree2 . 0   (offset: 0x1a7d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;

#namespace ob_music;

// Namespace ob_music
// Params 0, eflags: 0x1
// Checksum 0x4e032007, Offset: 0x2ae
// Size: 0x9
function autoexec main()
{
    thread init_ob_music();
}

// Namespace ob_music
// Params 0
// Checksum 0xd9016a47, Offset: 0x2bf
// Size: 0xa9
function init_ob_music()
{
    if ( level.gametypebundle.var_c27b5e2901d81fa7 )
    {
        return;
    }
    
    level musicbank_utility::init_musicbanks();
    level thread music_awareness_zone_setup();
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_spawned", &on_player_spawn );
    level callback::add( #"player_death", &on_player_death );
    level callback::add( "player_region_difficulty_change", &function_b99e1ffe0d7d679c );
    level callback::add( "on_ob_infil_start_music", &on_ob_infil_start );
    level callback::add( "on_ob_infil_complete", &on_ob_infil_complete );
    level thread function_e3c69adbb5f073e3();
}

// Namespace ob_music
// Params 0
// Checksum 0x57c6e808, Offset: 0x370
// Size: 0x85
function function_e3c69adbb5f073e3()
{
    utility::flag_wait( "activity_nexus_init_complete" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_51c99577e034e7b8 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_bbfe69caf3c664e7 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_926c5f61ded55005 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_469df3af3aed22c3 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_acb8e346c0ed5429 );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &on_activity_success );
    activity_common::function_2dd4f07fa5c3e911( "ActivityFailure", &on_activity_failure );
}

// Namespace ob_music
// Params 1
// Checksum 0x2bbc0d42, Offset: 0x3fd
// Size: 0x42
function on_player_connect( sparams )
{
    musicbank_utility::function_c5abc550e9f75f30();
    
    if ( isdefined( self.musicbankparams ) )
    {
        self.musicbankparams[ "isWithinMusicAwarenessZone_Contract" ] = 0;
        self.musicbankparams[ "isWithinMusicAwarenessZone_Activity" ] = 0;
    }
}

// Namespace ob_music
// Params 1
// Checksum 0xda3f452, Offset: 0x447
// Size: 0x13
function on_player_spawn( sparams )
{
    thread function_f38728afc2151f12();
}

// Namespace ob_music
// Params 1
// Checksum 0x5f71771d, Offset: 0x462
// Size: 0xc
function on_player_death( sparams )
{
    
}

// Namespace ob_music
// Params 1
// Checksum 0x9266593d, Offset: 0x476
// Size: 0xa7
function on_ob_infil_start( sparams )
{
    var_217abee662607976 = 0;
    var_4d8ee06315fd4755 = getdvarint( @"hash_ee88beebf586b9f6", 0 );
    
    if ( var_4d8ee06315fd4755 >= 1 )
    {
        var_217abee662607976 = 1;
    }
    
    if ( getdvarint( @"ob_codmas", 0 ) )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"infil_codmas" );
        return;
    }
    
    if ( var_217abee662607976 )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"infil_daisy" );
        return;
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"infil" );
}

// Namespace ob_music
// Params 1
// Checksum 0xb880f102, Offset: 0x525
// Size: 0xc
function on_ob_infil_complete( sparams )
{
    
}

// Namespace ob_music
// Params 1
// Checksum 0x7e5e064, Offset: 0x539
// Size: 0x25
function function_51c99577e034e7b8( relevant_info_struct )
{
    activity = self;
    
    if ( namespace_4a69edc3725e741::function_34024c4b393d3065( activity ) )
    {
        return;
    }
}

// Namespace ob_music
// Params 1
// Checksum 0x72e18d4f, Offset: 0x566
// Size: 0x4c
function function_bbfe69caf3c664e7( relevant_info_struct )
{
    activity = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( namespace_4a69edc3725e741::function_34024c4b393d3065( activity ) )
    {
        return;
    }
    
    if ( activity_instance_common::getactivitystate( activity ) == "Ended" )
    {
        return;
    }
}

// Namespace ob_music
// Params 1
// Checksum 0x4e91c551, Offset: 0x5ba
// Size: 0x4c
function function_926c5f61ded55005( relevant_info_struct )
{
    activity = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( namespace_4a69edc3725e741::function_34024c4b393d3065( activity ) )
    {
        return;
    }
    
    if ( activity_instance_common::getactivitystate( activity ) == "Ended" )
    {
        return;
    }
}

// Namespace ob_music
// Params 1
// Checksum 0x61e2c41, Offset: 0x60e
// Size: 0xc
function function_469df3af3aed22c3( relevant_info_struct )
{
    
}

// Namespace ob_music
// Params 1
// Checksum 0xe2d85542, Offset: 0x622
// Size: 0xc
function function_acb8e346c0ed5429( relevant_info_struct )
{
    
}

// Namespace ob_music
// Params 1
// Checksum 0x9291f52a, Offset: 0x636
// Size: 0xc
function on_activity_success( relevant_info_struct )
{
    
}

// Namespace ob_music
// Params 1
// Checksum 0xdc0a2959, Offset: 0x64a
// Size: 0xc
function on_activity_failure( relevant_info_struct )
{
    
}

// Namespace ob_music
// Params 1
// Checksum 0x21ad72ea, Offset: 0x65e
// Size: 0x4a
function function_b99e1ffe0d7d679c( params )
{
    if ( isdefined( params ) && isdefined( params.player ) )
    {
        if ( isdefined( params.new_difficulty ) )
        {
            if ( params.new_difficulty != params.var_705eae6dbfaf5fad )
            {
            }
        }
    }
}

// Namespace ob_music
// Params 0
// Checksum 0xfc6205af, Offset: 0x6b0
// Size: 0xa9
function function_f38728afc2151f12()
{
    self notify( #"hash_3b81f97ce85ab24e" );
    self endon( #"hash_3b81f97ce85ab24e" );
    self endon( #"hash_e0d522a9528cbaf7" );
    self endon( #"death_or_disconnect" );
    
    if ( self.musicbankparams[ "isWithinMusicAwarenessZone_Contract" ] || self.musicbankparams[ "isWithinMusicAwarenessZone_Activity" ] )
    {
        return;
    }
    
    level utility::flag_wait( "ob_infil_completed" );
    var_f38874d9fbc4aa1a = 120;
    var_f3ab5ed9fbeac170 = 360;
    
    while ( true )
    {
        wait randomintrange( var_f38874d9fbc4aa1a, var_f3ab5ed9fbeac170 + 1 );
        level musicbank_utility::function_5aca66c390aa347d( self, #"ambient_oneshot" );
        wait 50;
    }
}

// Namespace ob_music
// Params 0
// Checksum 0x183865e7, Offset: 0x761
// Size: 0x26
function function_a21b9cecb6565243()
{
    self notify( #"hash_10d095a8268907a2" );
    self endon( #"hash_10d095a8268907a2" );
    self notify( #"hash_e0d522a9528cbaf7" );
}

// Namespace ob_music
// Params 0, eflags: 0x4
// Checksum 0xe2fffd44, Offset: 0x78f
// Size: 0x74
function private music_awareness_zone_setup()
{
    level.snd_contract_music_awareness_zones = [];
    level.snd_activity_music_awareness_zones = [];
    level utility::flag_wait( "ob_infil_completed" );
    spatial_zone_container::function_3e5d25f80be6b5d1( "contract_music_awareness_zones", &function_8d009b00791d7cd7, &function_f33a8bfc1ad2542f, "music_awareness_zone" );
    spatial_zone_container::function_3e5d25f80be6b5d1( "activity_music_awareness_zones_outer", &function_a791ad7d862fac84, &function_c0004460ecb25047, "music_awareness_zone_outer" );
    spatial_zone_container::function_3e5d25f80be6b5d1( "activity_music_awareness_zones_inner", &function_a791ad7d862fac84, &function_835f2074cc7682b6, "music_awareness_zone_inner" );
}

// Namespace ob_music
// Params 1
// Checksum 0xa9f87647, Offset: 0x80b
// Size: 0x31
function function_859fd7ab75f367c2( activityinstance )
{
    spatial_zone_container::addspatialzone( activityinstance, "music_awareness_zone" );
    level.snd_contract_music_awareness_zones[ level.snd_contract_music_awareness_zones.size ] = activityinstance;
}

// Namespace ob_music
// Params 3
// Checksum 0x32204fbd, Offset: 0x844
// Size: 0x93
function function_96d2da3192b28f8f( activityinstance, var_263d1e33a7809fac, originfuncparams )
{
    originfunc = &function_25d147aa431c5f9d;
    
    if ( isfunction( var_263d1e33a7809fac ) )
    {
        originfunc = var_263d1e33a7809fac;
    }
    else
    {
        activityinstance.var_99b47cf515042728 = var_263d1e33a7809fac;
    }
    
    sphereradius = 2750;
    spatial_zone_container::function_5252f95edcf9e32c( activityinstance, "music_awareness_zone", originfunc, originfuncparams );
    spatial_zone_container::function_847140d2863dfbf8( activityinstance, "music_awareness_zone", undefined, sphereradius );
    level.snd_contract_music_awareness_zones[ level.snd_contract_music_awareness_zones.size ] = activityinstance;
}

// Namespace ob_music
// Params 1
// Checksum 0x43523294, Offset: 0x8df
// Size: 0x21
function function_25d147aa431c5f9d( activityinstance )
{
    return activityinstance.var_99b47cf515042728.origin;
}

// Namespace ob_music
// Params 1
// Checksum 0xfef0215c, Offset: 0x909
// Size: 0xe0
function function_be4c0727a998b18b( activityinstance )
{
    if ( arraycontains( level.snd_contract_music_awareness_zones, activityinstance ) )
    {
        level.snd_contract_music_awareness_zones = arrayremove( level.snd_contract_music_awareness_zones, activityinstance );
        playersinzone = spatial_zone_container::function_84f653d797112085( activityinstance, "music_awareness_zone" );
        level musicbank_utility::function_4f253fd35ec68cbc( playersinzone, #"activity_loop" );
        spatial_zone_container::function_a16a7e6ae5875495( activityinstance, "music_awareness_zone" );
        
        foreach ( player in playersinzone )
        {
            player thread function_f38728afc2151f12();
        }
    }
}

// Namespace ob_music
// Params 0, eflags: 0x4
// Checksum 0xf112751f, Offset: 0x9f1
// Size: 0xb
function private function_8d009b00791d7cd7()
{
    return level.snd_contract_music_awareness_zones;
}

// Namespace ob_music
// Params 1, eflags: 0x4
// Checksum 0x23c3f410, Offset: 0xa05
// Size: 0x79
function private function_f33a8bfc1ad2542f( params )
{
    if ( params.enteredzone )
    {
        level musicbank_utility::function_5aca66c390aa347d( params.player, #"activity_loop" );
        params.player function_a21b9cecb6565243();
        return;
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( params.player, #"activity_loop" );
    params.player thread function_f38728afc2151f12();
}

// Namespace ob_music
// Params 3
// Checksum 0xefd3f570, Offset: 0xa86
// Size: 0x83
function function_ef5b9bf8dee0f26d( activityinstance, outerradius = 5500, innerradius = 2750 )
{
    centerpoint = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    spatial_zone_container::function_847140d2863dfbf8( activityinstance, "music_awareness_zone_outer", centerpoint, outerradius );
    spatial_zone_container::function_847140d2863dfbf8( activityinstance, "music_awareness_zone_inner", centerpoint, innerradius );
    level.snd_activity_music_awareness_zones[ level.snd_activity_music_awareness_zones.size ?? 0 ] = activityinstance;
}

// Namespace ob_music
// Params 1
// Checksum 0x73f462ed, Offset: 0xb11
// Size: 0x125
function function_3d5e3c9ec30e3784( activityinstance )
{
    if ( arraycontains( level.snd_activity_music_awareness_zones, activityinstance ) )
    {
        level.snd_activity_music_awareness_zones = arrayremove( level.snd_activity_music_awareness_zones, activityinstance );
        var_7ed10ead5eb0e88 = spatial_zone_container::function_84f653d797112085( activityinstance, "music_awareness_zone_outer" );
        level musicbank_utility::function_4f253fd35ec68cbc( var_7ed10ead5eb0e88, #"hash_be559511face0ed3" );
        spatial_zone_container::function_a16a7e6ae5875495( activityinstance, "music_awareness_zone_outer" );
        var_1dfb2f518ecf327f = spatial_zone_container::function_84f653d797112085( activityinstance, "music_awareness_zone_inner" );
        level musicbank_utility::function_4f253fd35ec68cbc( var_1dfb2f518ecf327f, #"hash_db843624c3113cac" );
        spatial_zone_container::function_a16a7e6ae5875495( activityinstance, "music_awareness_zone_inner" );
        
        foreach ( player in var_1dfb2f518ecf327f )
        {
            player notify( #"hash_ffb436e99e18122d" );
            player thread function_f38728afc2151f12();
        }
    }
}

// Namespace ob_music
// Params 0, eflags: 0x4
// Checksum 0xb1e151a9, Offset: 0xc3e
// Size: 0xb
function private function_a791ad7d862fac84()
{
    return level.snd_activity_music_awareness_zones;
}

// Namespace ob_music
// Params 1, eflags: 0x4
// Checksum 0xace9fedd, Offset: 0xc52
// Size: 0x79
function private function_c0004460ecb25047( params )
{
    if ( params.enteredzone )
    {
        level musicbank_utility::function_5aca66c390aa347d( params.player, #"hash_be559511face0ed3" );
        params.player function_a21b9cecb6565243();
        return;
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( params.player, #"hash_be559511face0ed3" );
    params.player thread function_f38728afc2151f12();
}

// Namespace ob_music
// Params 1, eflags: 0x4
// Checksum 0x5efd9da6, Offset: 0xcd3
// Size: 0x74
function private function_835f2074cc7682b6( params )
{
    if ( params.enteredzone )
    {
        level thread function_1cc83c2e3d3e5dd4( params.player );
        params.player function_a21b9cecb6565243();
        return;
    }
    
    params.player notify( #"hash_ffb436e99e18122d" );
    level musicbank_utility::function_5aca66c390aa347d( params.player, #"hash_be559511face0ed3" );
}

// Namespace ob_music
// Params 1, eflags: 0xc
// Checksum 0x8d9fe95d, Offset: 0xd4f
// Size: 0xae
function private function_1cc83c2e3d3e5dd4( player )
{
    self notify( #"hash_dddf65b127179bd8" );
    self endon( #"hash_dddf65b127179bd8" );
    player endon( #"hash_ffb436e99e18122d" );
    var_714119a55cc5037d = 0;
    
    while ( true )
    {
        var_b4c57459986d7577 = player.sentientattackercount;
        
        if ( var_b4c57459986d7577 >= 4 && !var_714119a55cc5037d )
        {
            var_714119a55cc5037d = 1;
            level musicbank_utility::function_5aca66c390aa347d( player, #"hash_db843624c3113cac" );
        }
        else if ( var_b4c57459986d7577 < 1 && var_714119a55cc5037d )
        {
            var_714119a55cc5037d = 0;
            level musicbank_utility::function_5aca66c390aa347d( player, #"hash_be559511face0ed3" );
        }
        
        wait 0.5;
    }
}

