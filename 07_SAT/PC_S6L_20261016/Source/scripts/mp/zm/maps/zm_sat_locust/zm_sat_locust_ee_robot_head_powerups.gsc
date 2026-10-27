// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_robot_head_powerups.gsc  (hash_2080ac10818deebc.gscc) (size: 15386 Bytes / 0x3c1a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75713f22 (1970356002)
// size ...... 15386 (0x3c1a)
// includes .. 11  (offset: 0x3632)
// strings ... 41  (offset: 0x368a)
// dev strs .. 71  (offset: 0x38b2)
// exports ... 35  (offset: 0x2372)
// cseg ...... 0x2ca + 0x20a8 (0x2372)
// imports ... 99  (offset: 0x28ea)
// animtree1 . 0   (offset: 0x3c1a)
// animtree2 . 0   (offset: 0x3c1a)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_ee_robot_head_powerups;

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x5
// Checksum 0x425f4301, Offset: 0x2e8
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"locust_ee_robot_head_powerups", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0xef1bcc61, Offset: 0x315
// Size: 0xe2
function private pre_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_deea6cf86e812719", 1 ) )
    {
        return;
    }
    
    level.robot_head_powerups = { #var_c0ec3c66c17f12d8:getdvarint( @"hash_22d5d1faf881ba70", 30 ), #var_71c8c53d841a172e:getdvarint( @"hash_de812270babba8be", 10 ), #kills_required:0, #powerups_collected:0 };
    zm_quest::register_quest_step( #"locust_ee_robot_head_powerups", #"get_required_kills", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"locust_ee_robot_head_powerups", #"collect_powerup", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0x4ac2623f, Offset: 0x3ff
// Size: 0x9b
function private post_main()
{
    level thread function_6c24464d39b69dd7();
    
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_deea6cf86e812719", 1 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_52656a106e9b00aa();
    level callback::add( #"hash_f2c79b44bf002ece", &function_8fee08bed0cdbd0a );
    zm_save::function_1f44a48caae2acbf();
    utility::flag_wait( "onStartGameTypeFinished" );
    level thread zm_quest::start_quest( #"locust_ee_robot_head_powerups" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0x3fa5d69d, Offset: 0x4a2
// Size: 0x50
function private function_8fee08bed0cdbd0a( params )
{
    if ( !level.robot_head_powerups.powerups_collected )
    {
        return;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"locust_ee_robot_head_powerups", #"powerups_collected", level.robot_head_powerups.powerups_collected );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 2, eflags: 0x4
// Checksum 0xd7dae282, Offset: 0x4fa
// Size: 0x106
function private function_7d6d613ab952c071( skipped, save_restored )
{
    utility::flag_wait( "pap_step_04" );
    level.robot_head_powerups.powerups_collected = ( zm_save::function_1dda3554974a999e() ? zm_quest::function_73720cdf21c3cfd7( #"locust_ee_robot_head_powerups", #"powerups_collected" ) : 0 ) ?? 0;
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( !level callback::exists( #"on_ai_killed", &function_7613e9a62797dbc8 ) )
    {
        level callback::add( #"on_ai_killed", &function_7613e9a62797dbc8 );
    }
    
    if ( !level callback::exists( #"hash_ced83715576a5279", &function_3368577f2a8a1ffc ) )
    {
        level callback::add( #"hash_ced83715576a5279", &function_3368577f2a8a1ffc );
    }
    
    if ( !level callback::exists( "on_round_start", &on_round_start ) )
    {
        level callback::add( "on_round_start", &on_round_start );
    }
    
    thread function_2d44a19abf1f7824();
    utility::flag_wait( #"hash_e81a80f74f6a14e9" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 2, eflags: 0x4
// Checksum 0x809e82b4, Offset: 0x608
// Size: 0xbc
function private function_60062348e78b78d6( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        if ( !level callback::exists( #"on_ai_killed", &function_7613e9a62797dbc8 ) )
        {
            level callback::add( #"on_ai_killed", &function_7613e9a62797dbc8 );
        }
        
        if ( !level callback::exists( #"hash_ced83715576a5279", &function_3368577f2a8a1ffc ) )
        {
            level callback::add( #"hash_ced83715576a5279", &function_3368577f2a8a1ffc );
        }
        
        if ( !level callback::exists( "on_round_start", &on_round_start ) )
        {
            level callback::add( "on_round_start", &on_round_start );
        }
        
        thread function_2d44a19abf1f7824();
        utility::flag_set( #"hash_e81a80f74f6a14e9" );
    }
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0x74f11b95, Offset: 0x6cc
// Size: 0x39c
function private function_6c24464d39b69dd7()
{
    if ( !isdefined( level.robot_head_powerups ) )
    {
        level.robot_head_powerups = {};
    }
    
    level.robot_head_powerups.kill_zones = [];
    var_47ecdfefe42d85a5 = { #tag_right:2, #tag_left:4, #zone_name:"bridge" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:4, #tag_left:2, #zone_name:"foundry" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:6, #tag_left:3, #zone_name:"dock" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:4, #tag_left:4, #zone_name:"fishery" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:4, #tag_left:6, #zone_name:"market" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:5, #tag_left:5, #zone_name:"downtown" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:8, #tag_left:5, #zone_name:"spawn" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_47ecdfefe42d85a5 = { #tag_right:7, #tag_left:7, #zone_name:"lighthouse" };
    level.robot_head_powerups.kill_zones[ level.robot_head_powerups.kill_zones.size ] = var_47ecdfefe42d85a5;
    var_a0de18512017e226 = utility::getstruct( "howard_fx" );
    display_fx = spawnscriptable( %"sat_zm_prop_howard", var_a0de18512017e226.origin, var_a0de18512017e226.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_f5113db8de4e585d", display_fx );
    display = getent( "rh_tube_display", #targetname );
    
    if ( display )
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"rh_display", display );
        utility::flag_wait( "scriptables_ready" );
        function_109ffc6cebe9005e();
        display_fx setscriptablepartstate( #"sat_zm_prop_howard", #"off" );
    }
    
    /#
        level.robot_head_powerups.debug_structs = utility::getstructarray( "<dev string:x24>" );
    #/
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0xaac76c2e, Offset: 0xa70
// Size: 0x121
function private function_2d44a19abf1f7824( kill_zone_override )
{
    utility::flag_wait( "begin_round_logic" );
    
    if ( kill_zone_override )
    {
        foreach ( struct in level.robot_head_powerups.kill_zones )
        {
            if ( struct.zone_name == kill_zone_override )
            {
                level.robot_head_powerups.current_kill_zone = struct;
                break;
            }
        }
    }
    else
    {
        level.robot_head_powerups.current_kill_zone = utility::array_random( level.robot_head_powerups.kill_zones );
    }
    
    function_a6d9b9981f6ffdf6();
    level thread function_91bb904503aaafd8();
    
    /#
        if ( level.robot_head_powerups.var_4f4d1954fb08ab )
        {
            level thread function_49e04f77f9ea6d8a();
        }
    #/
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0x8a29a91, Offset: 0xb99
// Size: 0x10a
function private function_a6d9b9981f6ffdf6()
{
    squad_size = level.players.size;
    squad_frac = math::lerp_fraction( 1, 4, squad_size );
    var_244432712f6f896e = int( clamp( math::lerp( 75, 99, squad_frac ), 75, 99 ) );
    
    switch ( squad_size )
    {
        case 1:
            kill_override = getdvarint( @"hash_efcf6e8e07b66165", var_244432712f6f896e );
            break;
        case 2:
            kill_override = getdvarint( @"hash_6089f63680e8111a", var_244432712f6f896e );
            break;
        case 3:
            kill_override = getdvarint( @"hash_e9e343dc1ea04366", var_244432712f6f896e );
            break;
        case 4:
            kill_override = getdvarint( @"hash_1b1f952ab8adb3d5", var_244432712f6f896e );
            break;
    }
    
    level.robot_head_powerups.kills_required = getdvarint( @"hash_a5f7f7f96095c063", kill_override ?? var_244432712f6f896e );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0xdb8166ea, Offset: 0xcab
// Size: 0x7a
function private function_109ffc6cebe9005e()
{
    /#
        level notify( #"hash_bc795fac59aa2da1" );
    #/
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"rh_display" ) )
    {
        return;
    }
    
    display = zm_sat_locust_util::get_quest_reference( #"rh_display" );
    display hideallparts();
    display showpart( "tag_origin", "sat_zm_locust_tube_clock" );
    display showpart( "tag_animated", "sat_zm_locust_tube_clock" );
    display showpart( "tag_dial", "sat_zm_locust_tube_clock" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0xc
// Checksum 0x36caf707, Offset: 0xd2d
// Size: 0x15a
function private function_91bb904503aaafd8()
{
    self notify( #"hash_b15c814476f29e1d" );
    self endon( #"hash_b15c814476f29e1d" );
    level endon( #"game_ended" );
    level.robot_head_powerups endon( #"display_on_cooldown" );
    
    /#
        level endon( #"hash_51c573bc73962be4" );
    #/
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"rh_display" ) )
    {
        return;
    }
    
    display = zm_sat_locust_util::get_quest_reference( #"rh_display" );
    var_47ecdfefe42d85a5 = level.robot_head_powerups.current_kill_zone;
    
    while ( true )
    {
        function_109ffc6cebe9005e();
        function_77b5d50dc3c1c57d( var_47ecdfefe42d85a5.tag_left, undefined, var_47ecdfefe42d85a5.tag_right );
        wait 3;
        function_109ffc6cebe9005e();
        display function_a3c32d01af35f90e();
        kill_count_string = string( level.robot_head_powerups.kills_required );
        middle_light = kill_count_string[ 1 ] ? int( kill_count_string[ 0 ] ) : undefined;
        right_light = kill_count_string[ 1 ] ? int( kill_count_string[ 1 ] ) : int( kill_count_string[ 0 ] );
        function_109ffc6cebe9005e();
        function_77b5d50dc3c1c57d( undefined, middle_light, right_light );
        wait 3;
        function_109ffc6cebe9005e();
        display function_a3c32d01af35f90e();
    }
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 4, eflags: 0x4
// Checksum 0xe4a1112c, Offset: 0xe8f
// Size: 0x1ad
function private function_77b5d50dc3c1c57d( left_light, middle_light, right_light, zone_name )
{
    /#
        if ( level.robot_head_powerups.var_4f4d1954fb08ab )
        {
            function_205909f13d613a82( left_light, middle_light, right_light, zone_name );
        }
    #/
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"rh_display" ) )
    {
        return;
    }
    
    display = zm_sat_locust_util::get_quest_reference( #"rh_display" );
    
    if ( isdefined( display.var_8ccb84252d20cad6 ) )
    {
        display hidepart( "tag_light_two_on_" + display.var_8ccb84252d20cad6 );
    }
    
    if ( isdefined( display.var_36618f1ca20b9aa ) )
    {
        display hidepart( "tag_light_three_on_" + display.var_36618f1ca20b9aa );
    }
    
    if ( isdefined( display.var_13c4414693eaab59 ) )
    {
        display hidepart( "tag_light_one_on_" + display.var_13c4414693eaab59 );
    }
    
    display.var_8ccb84252d20cad6 = left_light;
    
    if ( left_light > -1 )
    {
        display showpart( "tag_light_two_on_" + display.var_8ccb84252d20cad6 );
    }
    
    display.var_36618f1ca20b9aa = middle_light;
    
    if ( middle_light > -1 )
    {
        display showpart( "tag_light_three_on_" + display.var_36618f1ca20b9aa );
    }
    
    display.var_13c4414693eaab59 = right_light;
    
    if ( right_light > -1 )
    {
        display showpart( "tag_light_one_on_" + display.var_13c4414693eaab59 );
    }
    
    display_fx = zm_sat_locust_util::get_quest_reference( #"hash_f5113db8de4e585d" );
    display_fx setscriptablepartstate( #"sat_zm_prop_howard", #"on" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0xc
// Checksum 0x250cb4b7, Offset: 0x1044
// Size: 0x211
function private function_a3c32d01af35f90e()
{
    self notify( #"hash_57175043061bcff9" );
    self endon( #"hash_57175043061bcff9" );
    level endon( #"game_ended" );
    level.robot_head_powerups endon( #"display_on_cooldown" );
    end_time = gettime() + 3000;
    display_fx = zm_sat_locust_util::get_quest_reference( #"hash_f5113db8de4e585d" );
    display_fx setscriptablepartstate( #"sat_zm_prop_howard", #"hash_9c6ec7eb473cfc69" );
    
    while ( gettime() < end_time )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            switch ( i )
            {
                case 0:
                    light_num = "one";
                    
                    if ( isdefined( self.var_13c4414693eaab59 ) )
                    {
                        self hidepart( "tag_light_one_on_" + self.var_13c4414693eaab59 );
                    }
                    
                    break;
                case 1:
                    light_num = "two";
                    
                    if ( isdefined( self.var_8ccb84252d20cad6 ) )
                    {
                        self hidepart( "tag_light_two_on_" + self.var_8ccb84252d20cad6 );
                    }
                    
                    break;
                case 2:
                    light_num = "three";
                    
                    if ( isdefined( self.var_36618f1ca20b9aa ) )
                    {
                        self hidepart( "tag_light_one_on_" + self.var_36618f1ca20b9aa );
                    }
                    
                    break;
            }
            
            result = randomint( 10 );
            
            for ( idx = 0; idx < 10 ; idx++ )
            {
                if ( idx == result )
                {
                    self showpart( "tag_light_" + light_num + "_on_" + result, "sat_zm_locust_tube_clock" );
                    
                    switch ( i )
                    {
                        case 0:
                            self.var_13c4414693eaab59 = result;
                            break;
                        case 1:
                            self.var_8ccb84252d20cad6 = result;
                            break;
                        case 2:
                            self.var_36618f1ca20b9aa = result;
                            break;
                    }
                }
            }
        }
        
        wait 0.1;
        function_109ffc6cebe9005e();
    }
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0xe89569a1, Offset: 0x125d
// Size: 0x98
function private function_7613e9a62797dbc8( params )
{
    if ( function_d987d18c2dfa9582( level.robot_head_powerups.current_kill_zone.zone_name, params.eattacker ) && function_d987d18c2dfa9582( level.robot_head_powerups.current_kill_zone.zone_name, self ) )
    {
        level.robot_head_powerups.kills_required--;
        
        if ( level.robot_head_powerups.kills_required == 0 )
        {
            thread function_9b6ed19256363a41();
        }
    }
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 2, eflags: 0x4
// Checksum 0x5bcfa462, Offset: 0x12fd
// Size: 0xc4, Type: bool
function private function_d987d18c2dfa9582( zone, target )
{
    name = "rh_" + zone;
    triggers = getnoentvolumearray( name, #targetname );
    
    foreach ( trigger in triggers )
    {
        if ( isdefined( trigger ) && isdefined( target ) && target istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0x6ee4745a, Offset: 0x13ca
// Size: 0x130
function private function_9b6ed19256363a41()
{
    utility::flag_set( #"hash_e81a80f74f6a14e9" );
    function_109ffc6cebe9005e();
    function_fe4bde8d840009b( 1 );
    level.robot_head_powerups.powerup_ready = 1;
    alive_players = utility::get_alive_players( 0 );
    
    foreach ( player in alive_players )
    {
        zone = player zone_manager::get_current_zone();
        
        if ( player.var_420915a121e1cc41 || zone.zone_name == "zone_robot_head" )
        {
            function_d6dfdb44d41b0dc5();
            level.robot_head_powerups.powerup_ready = 0;
            break;
        }
    }
    
    level.robot_head_powerups.var_af19dc8273371a9 = 1;
    level.robot_head_powerups notify( #"display_on_cooldown" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0x7d9d6726, Offset: 0x1502
// Size: 0x40
function private on_round_start( params )
{
    if ( !level.robot_head_powerups.var_af19dc8273371a9 )
    {
        return;
    }
    
    level.robot_head_powerups.var_af19dc8273371a9 = 0;
    thread function_2d44a19abf1f7824();
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 2, eflags: 0x4
// Checksum 0x689a1a69, Offset: 0x154a
// Size: 0x60
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( !level callback::exists( #"player_powerup", &function_33cd6c7139e961b4 ) )
    {
        level callback::add( #"player_powerup", &function_33cd6c7139e961b4 );
    }
    
    utility::flag_wait( #"hash_e81a7df74f6a0fd0" );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 2, eflags: 0x4
// Checksum 0x8ada732, Offset: 0x15b2
// Size: 0x5f
function private function_60062248e78b76a3( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        if ( !level callback::exists( #"player_powerup", &function_33cd6c7139e961b4 ) )
        {
            level callback::add( #"player_powerup", &function_33cd6c7139e961b4 );
        }
        
        utility::flag_set( #"hash_e81a7df74f6a0fd0" );
    }
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0x7a9de9, Offset: 0x1619
// Size: 0x112
function private function_52656a106e9b00aa()
{
    var_780999056e00e677 = [];
    exterior_lights = utility::getstructarray( "rh_exterior_light" );
    
    foreach ( loc in exterior_lights )
    {
        scriptable = spawnscriptable( %"sat_zm_prop_herman_01", loc.origin, loc.angles );
        var_780999056e00e677[ var_780999056e00e677.size ] = scriptable;
    }
    
    interior_ring = utility::getstruct( "rh_interior_ring" );
    scriptable = spawnscriptable( %"sat_zm_prop_herman_02", interior_ring.origin, interior_ring.angles );
    var_780999056e00e677[ var_780999056e00e677.size ] = scriptable;
    zm_sat_locust_util::function_295a36ef38f5acae( #"rh_lights", var_780999056e00e677 );
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0x714ceb4d, Offset: 0x1733
// Size: 0x5c
function private function_3368577f2a8a1ffc( params )
{
    if ( !level.robot_head_powerups.powerup_ready )
    {
        return;
    }
    
    level.robot_head_powerups.powerup_ready = 0;
    params.player utility::waittill_any_timeout( 10, "fasttravel_finished" );
    wait 1;
    function_d6dfdb44d41b0dc5();
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 0, eflags: 0x4
// Checksum 0xca91e80f, Offset: 0x1797
// Size: 0x1ab
function private function_d6dfdb44d41b0dc5()
{
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"rh_powerup" ) )
    {
        powerup = zm_sat_locust_util::get_quest_reference( #"rh_powerup" );
        powerup powerups::powerup_delete();
        zm_sat_locust_util::function_7bf944a5a2b76f39( #"rh_powerup" );
    }
    
    spawn_pos = utility::getstruct( "rh_interior_ring" );
    item_spawned = level callback::response( 0, #"hash_4fcf8b30a92d6571", { #spawn_pos:spawn_pos } );
    
    if ( !item_spawned )
    {
        var_dcef9be67174ef20 = randomint( 100 );
        
        if ( var_dcef9be67174ef20 < level.robot_head_powerups.var_71c8c53d841a172e )
        {
            powerup_type = utility::array_random( [ "fire_sale", "free_perk" ] );
        }
        else if ( var_dcef9be67174ef20 < level.robot_head_powerups.var_c0ec3c66c17f12d8 + level.robot_head_powerups.var_71c8c53d841a172e )
        {
            powerup_type = utility::array_random( [ "double_points", "full_ammo" ] );
        }
        else
        {
            powerup_type = utility::array_random( [ "full_power", "bonus_points_team", "full_armor" ] );
        }
        
        new_powerup = powerups::powerup_drop( powerup_type, spawn_pos.origin + ( 0, 0, 40 ), -1, undefined, undefined, 1 );
        zm_sat_locust_util::function_295a36ef38f5acae( #"rh_powerup", new_powerup );
    }
    
    /#
        if ( level.robot_head_powerups.var_4f4d1954fb08ab )
        {
            function_953fb579fa2de5cc();
        }
    #/
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0x6c6363e8, Offset: 0x194a
// Size: 0xe1
function private function_33cd6c7139e961b4( params )
{
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"rh_powerup" ) )
    {
        return;
    }
    
    powerup = zm_sat_locust_util::get_quest_reference( #"rh_powerup" );
    
    if ( params.powerup != powerup )
    {
        return;
    }
    
    utility::flag_set( #"hash_e81a7df74f6a0fd0" );
    
    if ( !isdefined( level.robot_head_powerups.powerups_collected ) )
    {
        level.robot_head_powerups.powerups_collected = 0;
    }
    
    level.robot_head_powerups.powerups_collected++;
    level callback::callback( #"hash_97272c456c65bf4a", { #num_collected:level.robot_head_powerups.powerups_collected } );
    function_fe4bde8d840009b( 0 );
    
    /#
        level notify( #"hash_eab5031f8dc1edc7" );
    #/
}

// Namespace zm_sat_locust_ee_robot_head_powerups
// Params 1, eflags: 0x4
// Checksum 0xc9f3ad7b, Offset: 0x1a33
// Size: 0xca
function private function_fe4bde8d840009b( var_c290e019071bf2a7 = 1 )
{
    state = var_c290e019071bf2a7 ? #"on" : #"off";
    var_780999056e00e677 = zm_sat_locust_util::get_quest_reference( #"rh_lights" );
    
    foreach ( light in var_780999056e00e677 )
    {
        light setscriptablepartstate( light function_84ad2f70189ee7c3(), state );
    }
}

/#

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0x4
    // Checksum 0xe946907c, Offset: 0x1b05
    // Size: 0x27b, Type: dev
    function private debug_init()
    {
        setdvarifuninitialized( @"hash_f81424f3586934d6", 0, -1, 9 );
        setdvarifuninitialized( @"hash_ede8df46e955b3aa", 0, -1, 9 );
        setdvarifuninitialized( @"hash_4ce7e6afc42bc959", 0, -1, 9 );
        setdvarifuninitialized( @"hash_a5f7f7f96095c063", 75, 1, 99 );
        zm_quest::function_bc99f123a684344f( #"locust_ee_robot_head_powerups" );
        devgui::add_devgui_func( "<dev string:x2d>", "<dev string:x3a>", &debug_toggle );
        devgui::add_devgui_dvar( "<dev string:x5e>", "<dev string:x71>" );
        devgui::add_devgui_func( "<dev string:x9f>", "<dev string:xc0>", &function_e5f00195e791f46c );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe5>", "<dev string:x109>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12d>", "<dev string:x147>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x16a>", "<dev string:x183>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a5>", "<dev string:x1c2>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e8>", "<dev string:x207>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x22f>", "<dev string:x24a>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x26e>", "<dev string:x28a>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2af>", "<dev string:x2cb>", &function_238d655937af9d02 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2f0>", "<dev string:x30b>", &function_238d655937af9d02 );
        devgui::add_devgui_dvar( "<dev string:x32f>", "<dev string:x34c>" );
        devgui::add_devgui_dvar( "<dev string:x376>", "<dev string:x395>" );
        devgui::add_devgui_dvar( "<dev string:x3c1>", "<dev string:x3df>" );
        devgui::add_devgui_func( "<dev string:x40a>", "<dev string:x427>", &function_cec4e1a1ee961fdc );
        devgui::add_devgui_func( "<dev string:x455>", "<dev string:x477>", &function_5881d43b2bde718f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x49a>", "<dev string:x4c2>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4eb>", "<dev string:x516>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x542>", "<dev string:x56f>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x59d>", "<dev string:x5c6>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5f0>", "<dev string:x619>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x643>", "<dev string:x66d>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x698>", "<dev string:x6c2>", &function_81cebcfae05e8e8c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6ed>", "<dev string:x714>", &function_81cebcfae05e8e8c );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 4, eflags: 0x4
    // Checksum 0x1fdf203f, Offset: 0x1d88
    // Size: 0x176, Type: dev
    function private function_205909f13d613a82( left_light, middle_light, right_light, zone_name )
    {
        letters = [ 9:"<dev string:x74e>", 8:"<dev string:x74c>", 7:"<dev string:x74a>", 6:"<dev string:x748>", 5:"<dev string:x746>", 4:"<dev string:x744>", 3:"<dev string:x742>", 2:"<dev string:x740>", 1:"<dev string:x73e>", 0:"<dev string:x73c>" ];
        
        if ( left_light > -1 )
        {
            chosen_letter = letters[ left_light ];
        }
        
        text_left = chosen_letter ?? "<dev string:x750>";
        var_d640060fab7631ff = middle_light ?? ( isdefined( left_light ) ? "<dev string:x751>" : "<dev string:x750>" );
        text = text_left + var_d640060fab7631ff + right_light;
        
        if ( !isdefined( zone_name ) )
        {
            zone_name = level.robot_head_powerups.current_kill_zone.zone_name;
        }
        
        level notify( #"hash_bc795fac59aa2da1" );
        debug::print3d( ( 3036, 9539, 1681 ), text, ( 0, 1, 0 ), undefined, "<dev string:x753>", undefined, 1, 1, -10 );
        debug::print3d( ( 3036, 9539, 1681 ), zone_name, ( 0, 1, 0 ), undefined, "<dev string:x753>", undefined, 1, 0.5, -15 );
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0x4
    // Checksum 0x4ad7748b, Offset: 0x1f06
    // Size: 0x71, Type: dev
    function private function_953fb579fa2de5cc()
    {
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"rh_powerup" ) )
        {
            return;
        }
        
        level notify( #"hash_eab5031f8dc1edc7" );
        powerup = zm_sat_locust_util::get_quest_reference( #"rh_powerup" );
        debug::print3d( powerup.origin, "<dev string:x76c>", ( 0, 1, 0 ), undefined, "<dev string:x77a>", undefined, 1, 3, 50 );
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0x4
    // Checksum 0xaa668886, Offset: 0x1f7f
    // Size: 0xc, Type: dev
    function private function_e5f00195e791f46c()
    {
        thread function_9b6ed19256363a41();
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 1, eflags: 0x4
    // Checksum 0xdef4f946, Offset: 0x1f93
    // Size: 0x37, Type: dev
    function private function_238d655937af9d02( params )
    {
        zone = params[ 0 ] == "<dev string:x793>" ? undefined : params[ 0 ];
        thread function_2d44a19abf1f7824( zone );
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0x4
    // Checksum 0x6d2555ab, Offset: 0x1fd2
    // Size: 0x90, Type: dev
    function private debug_toggle()
    {
        if ( level.robot_head_powerups.var_4f4d1954fb08ab )
        {
            level.robot_head_powerups.var_4f4d1954fb08ab = 0;
            level notify( #"hash_88dff8580fdd4a8d" );
            level notify( #"hash_bc795fac59aa2da1" );
            level notify( #"hash_eab5031f8dc1edc7" );
            iprintlnbold( "<dev string:x79a>" );
            return;
        }
        
        level.robot_head_powerups.var_4f4d1954fb08ab = 1;
        function_953fb579fa2de5cc();
        level thread function_49e04f77f9ea6d8a();
        iprintlnbold( "<dev string:x7bb>" );
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0xc
    // Checksum 0x59dfffd6, Offset: 0x206a
    // Size: 0x171, Type: dev
    function private function_49e04f77f9ea6d8a()
    {
        self notify( #"hash_429c63ecddfea7d3" );
        self endon( #"hash_429c63ecddfea7d3" );
        level endon( #"game_ended", #"hash_88dff8580fdd4a8d" );
        
        foreach ( struct in level.robot_head_powerups.debug_structs )
        {
            if ( struct.script_noteworthy == level.robot_head_powerups.current_kill_zone.zone_name )
            {
                var_7a573f2050303037 = struct;
                break;
            }
        }
        
        while ( true )
        {
            debug::line( var_7a573f2050303037, var_7a573f2050303037.origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), level.framedurationseconds, "<dev string:x7db>" );
            debug::print3d( var_7a573f2050303037, "<dev string:x7f3>" + level.robot_head_powerups.kills_required, ( 0, 1, 0 ), level.framedurationseconds, "<dev string:x7db>", undefined, 1, 3, 100 );
            waitframe();
        }
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0x4
    // Checksum 0x30fb50d5, Offset: 0x21e3
    // Size: 0x71, Type: dev
    function private function_cec4e1a1ee961fdc()
    {
        if ( level.robot_head_powerups.var_a1571362c9a44915 )
        {
            level.robot_head_powerups.var_a1571362c9a44915 = 0;
            level thread function_91bb904503aaafd8();
            iprintlnbold( "<dev string:x79a>" );
            return;
        }
        
        level.robot_head_powerups.var_a1571362c9a44915 = 1;
        level notify( #"hash_51c573bc73962be4" );
        iprintlnbold( "<dev string:x7bb>" );
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 0, eflags: 0x4
    // Checksum 0xeb96ba9f, Offset: 0x225c
    // Size: 0x3a, Type: dev
    function private function_5881d43b2bde718f()
    {
        function_109ffc6cebe9005e();
        function_77b5d50dc3c1c57d( getdvarint( @"hash_a9af20a4e19b6db9" ), getdvarint( @"hash_90fcab94c6a35e1d" ), getdvarint( @"hash_d4fe2875cde2493c" ) );
    }

    // Namespace zm_sat_locust_ee_robot_head_powerups
    // Params 1, eflags: 0x4
    // Checksum 0xbaacdb3a, Offset: 0x229e
    // Size: 0xd4, Type: dev
    function private function_81cebcfae05e8e8c( params )
    {
        this_zone = undefined;
        
        foreach ( zone in level.robot_head_powerups.kill_zones )
        {
            if ( zone.zone_name == params[ 0 ] )
            {
                this_zone = zone;
            }
        }
        
        if ( this_zone )
        {
            function_109ffc6cebe9005e();
            function_77b5d50dc3c1c57d( this_zone.tag_left, undefined, this_zone.tag_right );
        }
    }

#/
