// script_16d8789bae43669e  (hash_16d8789bae43669e.gscc) (size: 5406 Bytes / 0x151e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc464ae8c (3294932620)
// size ...... 5406 (0x151e)
// includes .. 9   (offset: 0x1432)
// strings ... 8   (offset: 0x147a)
// dev strs .. 2   (offset: 0x1506)
// exports ... 13  (offset: 0xd02)
// cseg ...... 0xde + 0xc24 (0xd02)
// imports ... 43  (offset: 0xf0a)
// animtree1 . 0   (offset: 0x151e)
// animtree2 . 0   (offset: 0x151e)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\squad_notification;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\coop;

#namespace namespace_1f3f9eb1e9681da5;

// Namespace namespace_1f3f9eb1e9681da5
// Params 5
// Checksum 0xcd37243b, Offset: 0xfc
// Size: 0x1b1
function init_player_catchup( activity_instance, center_struct_targetname, flag_on_complete, var_b0c8e210a11835de, countdown_time = 5 )
{
    var_678759dcf4f532b7 = function_ffc96a24d6f74919( center_struct_targetname, activity_instance, flag_on_complete, countdown_time );
    
    if ( !isdefined( var_678759dcf4f532b7 ) )
    {
        return;
    }
    
    if ( isarray( var_b0c8e210a11835de ) )
    {
        var_678759dcf4f532b7.var_b0c8e210a11835de = var_b0c8e210a11835de;
    }
    else
    {
        var_678759dcf4f532b7.var_b0c8e210a11835de = activity_instance.playerparticipants;
    }
    
    foreach ( player in var_678759dcf4f532b7.var_b0c8e210a11835de )
    {
        player val::set( "squad_notification", "damage", 0 );
        player val::set( "squad_notification", "vehicle_use", 0 );
        
        if ( player isvehicleactive() )
        {
            player leavevehicle( 0, 1 );
        }
    }
    
    var_678759dcf4f532b7 thread init_catchup_timer( countdown_time );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        function_dcbcb7287b57b18( player, countdown_time );
    }
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 7
// Checksum 0x92f002e4, Offset: 0x2b5
// Size: 0x18b
function function_9dbeaf9ca833864( activity_instance, center_struct_targetname, flag_on_complete, countdown_time = 5, var_7931c8b98d8aa1c8, var_678759dcf4f532b7, ignore_vfx = 0 )
{
    if ( !var_678759dcf4f532b7 )
    {
        var_678759dcf4f532b7 = function_ffc96a24d6f74919( center_struct_targetname, activity_instance, flag_on_complete, countdown_time, var_7931c8b98d8aa1c8 );
    }
    
    if ( !isdefined( var_678759dcf4f532b7 ) )
    {
        return;
    }
    
    var_678759dcf4f532b7.trigger = getent( var_678759dcf4f532b7.var_30be74fbdfe5bbae.target, #targetname );
    var_678759dcf4f532b7.ignore_vfx = ignore_vfx;
    var_678759dcf4f532b7.var_b0c8e210a11835de = activity_instance.playerparticipants;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        if ( player istouching( var_678759dcf4f532b7.trigger ) )
        {
            var_678759dcf4f532b7.var_b0c8e210a11835de = arrayremove( var_678759dcf4f532b7.var_b0c8e210a11835de, player );
        }
    }
    
    trigger::makeenterexittrigger( var_678759dcf4f532b7.trigger, &function_636639102eeb77c5, &function_16c9cf0a1d1d2f8f, undefined, undefined, &function_b3a4eb7a9647e2ba, var_678759dcf4f532b7 );
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 5
// Checksum 0x8a3ddaa2, Offset: 0x448
// Size: 0x196
function function_ffc96a24d6f74919( targetname, activity_instance, flag_on_complete, countdown_time, var_7931c8b98d8aa1c8 )
{
    var_2b0fa2a97f5259a7 = activity_common::function_d54f02a6971bb9ab( activity_instance.type );
    
    foreach ( struct in var_2b0fa2a97f5259a7.linkedstructs )
    {
        if ( struct.targetname == targetname )
        {
            var_30be74fbdfe5bbae = struct;
        }
    }
    
    if ( !isdefined( var_30be74fbdfe5bbae ) )
    {
        if ( isdefined( var_7931c8b98d8aa1c8 ) )
        {
            utility::flag_set( var_7931c8b98d8aa1c8 );
        }
        
        if ( isdefined( flag_on_complete ) )
        {
            utility::flag_set( flag_on_complete );
        }
        
        /#
            iprintlnbold( "<dev string:x24>" + targetname + "<dev string:x4c>" );
        #/
        
        return;
    }
    
    teleport_structs = var_30be74fbdfe5bbae utility::get_linked_structs();
    ob_story_mission_utils::set_revive_spawns( teleport_structs );
    var_678759dcf4f532b7 = { #var_7931c8b98d8aa1c8:var_7931c8b98d8aa1c8, #var_30be74fbdfe5bbae:var_30be74fbdfe5bbae, #teleport_structs:teleport_structs, #seconds_before_teleport:countdown_time, #countdown_time:countdown_time, #flag_on_complete:flag_on_complete, #activity_instance:activity_instance, #id:targetname };
    return var_678759dcf4f532b7;
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 3, eflags: 0x4
// Checksum 0x63182826, Offset: 0x5e7
// Size: 0x1d4
function private function_636639102eeb77c5( player, trigger, payload )
{
    var_678759dcf4f532b7 = payload;
    
    if ( arraycontains( var_678759dcf4f532b7.var_b0c8e210a11835de, player ) )
    {
        var_678759dcf4f532b7.var_b0c8e210a11835de = arrayremove( var_678759dcf4f532b7.var_b0c8e210a11835de, player );
    }
    
    if ( !utility::flag( payload.id + "_first_triggered" ) )
    {
        utility::flag_set( payload.id + "_first_triggered" );
        
        foreach ( player_participant in payload.activity_instance.playerparticipants )
        {
            player_participant val::set( "squad_notification", "damage", 0 );
        }
        
        var_678759dcf4f532b7 thread init_catchup_timer( var_678759dcf4f532b7.countdown_time );
        
        foreach ( player in var_678759dcf4f532b7.var_b0c8e210a11835de )
        {
            function_dcbcb7287b57b18( player, var_678759dcf4f532b7.seconds_before_teleport );
        }
    }
    else
    {
        function_35c3f43dbf143af5( player );
    }
    
    if ( var_678759dcf4f532b7.var_b0c8e210a11835de.size == 0 )
    {
        var_678759dcf4f532b7 player_catchup_complete();
    }
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 3, eflags: 0x4
// Checksum 0x5d9e6a9d, Offset: 0x7c3
// Size: 0x70
function private function_16c9cf0a1d1d2f8f( player, trigger, payload )
{
    var_678759dcf4f532b7 = payload;
    function_dcbcb7287b57b18( player, var_678759dcf4f532b7.seconds_before_teleport );
    
    if ( !arraycontains( var_678759dcf4f532b7.var_b0c8e210a11835de, player ) )
    {
        var_678759dcf4f532b7.var_b0c8e210a11835de[ var_678759dcf4f532b7.var_b0c8e210a11835de.size ] = player;
    }
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 3
// Checksum 0x830ad5f8, Offset: 0x83b
// Size: 0x2a
function function_b3a4eb7a9647e2ba( player, trigger, payload )
{
    if ( isai( player ) )
    {
        return 1;
    }
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 1
// Checksum 0xf7085580, Offset: 0x86d
// Size: 0x10d
function init_catchup_timer( var_a44d70a15368de39 )
{
    self.activity_instance endon( #"player_catchup_complete" );
    var_678759dcf4f532b7 = self;
    
    for ( i = 0; i < var_a44d70a15368de39 ; i++ )
    {
        var_678759dcf4f532b7.seconds_before_teleport = var_a44d70a15368de39 - i;
        
        if ( var_678759dcf4f532b7.seconds_before_teleport == 1 && isdefined( self.var_7931c8b98d8aa1c8 ) )
        {
            utility::flag_set( self.var_7931c8b98d8aa1c8 );
        }
        
        wait 1;
    }
    
    foreach ( player in self.var_b0c8e210a11835de )
    {
        player thread function_ffe63c844d53a59d( self );
    }
    
    function_a4d977b99bf31108();
    player_catchup_complete();
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 1
// Checksum 0x9167a3f8, Offset: 0x982
// Size: 0xff
function function_ffe63c844d53a59d( var_678759dcf4f532b7 )
{
    player::_freezecontrols( 1 );
    player::_freezelookcontrols( 1 );
    var_a1e68c33991c906f = var_678759dcf4f532b7.teleport_structs[ self.sessionuimemberindex ];
    
    if ( self getclientomnvar( "ui_world_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayerkeepui( self, 1, 1.5 );
    }
    
    if ( self getclientomnvar( "ui_total_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayer( self, 1, 1.5 );
    }
    
    coop::teleport_player( self, var_a1e68c33991c906f );
    
    if ( self getclientomnvar( "ui_world_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayerkeepui( self, 0, 1.5 );
    }
    
    if ( self getclientomnvar( "ui_total_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayer( self, 0, 1.5 );
    }
    
    utility::ent_flag_init( var_678759dcf4f532b7.id + "_player_teleported" );
    utility::ent_flag_set( var_678759dcf4f532b7.id + "_player_teleported" );
    player::_freezecontrols( 0 );
    player::_freezelookcontrols( 0 );
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 0, eflags: 0x4
// Checksum 0x14ab7820, Offset: 0xa89
// Size: 0xc5
function private function_a4d977b99bf31108()
{
    every_player_ready = 0;
    
    while ( !every_player_ready )
    {
        every_player_ready = 1;
        
        foreach ( player in self.var_b0c8e210a11835de )
        {
            if ( !player || !player isconnected() )
            {
                continue;
            }
            
            if ( !player utility::flag( self.id + "_player_teleported" ) )
            {
                every_player_ready = 0;
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 0
// Checksum 0xc81d4e18, Offset: 0xb56
// Size: 0x107
function player_catchup_complete()
{
    foreach ( player in self.activity_instance.playerparticipants )
    {
        player val::reset_all( "squad_notification" );
    }
    
    if ( isdefined( self.var_7931c8b98d8aa1c8 ) && !utility::flag( self.var_7931c8b98d8aa1c8 ) )
    {
        utility::flag_set( self.var_7931c8b98d8aa1c8 );
    }
    
    if ( isdefined( self.flag_on_complete ) )
    {
        utility::flag_set( self.flag_on_complete );
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self.activity_instance notify( #"player_catchup_complete" );
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 1
// Checksum 0x58415429, Offset: 0xc65
// Size: 0x1a
function function_35c3f43dbf143af5( player )
{
    player squad_notification::close( "squad_notification" );
}

// Namespace namespace_1f3f9eb1e9681da5
// Params 2
// Checksum 0x2153dff7, Offset: 0xc87
// Size: 0x7b
function function_dcbcb7287b57b18( player, countdown_start_seconds )
{
    if ( !isdefined( level.gametypebundle.var_2fb304cdde78a01d ) )
    {
        return;
    }
    
    if ( !( player isconnected() && player.sessionstate == "playing" ) )
    {
        return;
    }
    
    player thread squad_notification::create( "squad_notification", level.gametypebundle.var_2fb304cdde78a01d, countdown_start_seconds, undefined, &"coop_game_play/squad_notification_syncing" );
}

