// scripts\mp\zm\systems\zm_save.gsc  (hash_1667bc66bcc6e6e2.gscc) (size: 74047 Bytes / 0x1213f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a00046f (704644207)
// size ...... 74047 (0x1213f)
// includes .. 43  (offset: 0xfbf7)
// strings ... 335 (offset: 0xfd4f)
// dev strs .. 38  (offset: 0x11f67)
// exports ... 79  (offset: 0xc1df)
// cseg ...... 0x1c5d + 0xa582 (0xc1df)
// imports ... 313 (offset: 0xce37)
// animtree1 . 0   (offset: 0x1213f)
// animtree2 . 0   (offset: 0x1213f)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\doorbuy;
#using scripts\mp\electric_power_switch;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_killstreak;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\pack_a_punch;
#using scripts\mp\supers;
#using scripts\mp\wallbuy;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_catchup;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_ui;
#using scripts\mp\zm\zm_utility;

#namespace zm_save;

// Namespace zm_save
// Params 0, eflags: 0x5
// Checksum 0x69cbafb8, Offset: 0x1c7b
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_5eddddec038a8350", undefined, &pre_main, &post_main );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x22a77d51, Offset: 0x1ca0
// Size: 0x41b
function private pre_main()
{
    if ( !is_save_load_enabled() )
    {
        return;
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    level ui::lui_registercallback( "save_and_end_game", &menu_save_and_end_game );
    level ui::lui_registercallback( "zm_save_load_leave_join_player", &function_a7e1154075b4b73f );
    level callback::add( "doorbuy_opened", &add_enabled_doors );
    level callback::add( "power_switch_state_changed", &power_state_changed );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( #"hash_5b8b82c2527d7aa2", &function_b307ddfb2258fbc3 );
    level callback::add( #"hash_347b41546632b85a", &function_272ebe68c945c463 );
    level callback::add( #"hash_d558db2dac47d5f7", &function_e498c41fd90a8d6 );
    utility::registersharedfunc( #"zombie", #"hash_ba1f273364ecd5ca", &function_1d3eee82fb090fbc );
    utility::registersharedfunc( #"zombie", #"hash_e29bc9f93cc9ba4", &function_b2cda415fe32c09d );
    utility::registersharedfunc( #"zombie", #"get_saved_timeline", &get_saved_timeline );
    utility::registersharedfunc( #"zombie", #"get_timewarps_initialized", &get_timewarps_initialized );
    utility::registersharedfunc( #"zombie", #"get_persistent_random_seed", &get_persistent_random_seed );
    utility::registersharedfunc( #"zombie", #"hash_8b52dcc4e869e5e5", &function_1dda3554974a999e );
    utility::registersharedfunc( #"zombie", #"is_chompy_activated", &is_chompy_activated );
    utility::registersharedfunc( #"zombie", #"hash_818fba7b4cde9cfc", &function_7c32d54fe0ba8adb );
    utility::registersharedfunc( #"zombie", #"hash_b6da8d713483a2e", &function_786b3b5398819fe5 );
    utility::registersharedfunc( #"zombie", #"get_melted_mannequins", &get_melted_mannequins );
    utility::registersharedfunc( #"zombie", #"hash_e1eecff22a023276", &function_fcccc3d2a616b1c7 );
    utility::registersharedfunc( #"zombie", #"hash_1374768dfa684874", &function_1f44a48caae2acbf );
    utility::registersharedfunc( #"zombie", #"hash_d4fd1ac4daa061c6", &function_9698b815ada87667 );
    utility::registersharedfunc( #"zombie", #"hash_edafec158d8c1bdc", &function_3191c44ef2465141 );
    
    if ( is_autosave_enabled() )
    {
        level thread function_41bc4ff446281d86();
        level thread function_767619d07194353f();
        level callback::add( #"player_disconnect", &on_player_disconnect );
        level callback::add( "zm_exfil_failure", &on_exfil_failure );
        level callback::add( "zm_exfil_success", &on_exfil_success );
    }
    
    level.zm_save_info = spawnstruct();
    level.zm_save_info.opened_doors = [];
    level.zm_save_info.on_switches = [];
    
    /#
        devgui_init();
    #/
    
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    level.zm_save_info.var_cccdb0a426251ee0 = 1;
    level.zm_save_info.var_cfebebc6bef5c225 = 1;
    level callback::add( "on_round_start", &on_round_start );
    level.zm_save_info.num_players = zmsaveread( "num_players" );
    assert( level.zm_save_info.num_players > 0 );
    level.zm_save_info.var_f8acb750331e3c9 = [];
    
    for ( index = 0; index < level.zm_save_info.num_players ; index++ )
    {
        level.zm_save_info.var_f8acb750331e3c9[ index ] = zmsaveread( "player_xuids", index );
    }
    
    level.zm_save_info.disconnect_save = zmsaveread( "disconnect_save" );
    level.zm_save_info.restored_players = 0;
    utility::flag_init( "zm_save_level_restore_complete" );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0xd5faafd0, Offset: 0x20c3
// Size: 0x47
function private post_main()
{
    level endon( #"game_ended" );
    
    if ( !function_fcccc3d2a616b1c7() )
    {
        setomnvar( "ui_was_savegame_loaded_this_round", 1 );
        return;
    }
    
    utility::flag_wait_all( "zm_round_spawning_init_data_done", "electric_power_switch_init_complete", "doorbuy_init_complete", "zone_setup_finished" );
    restore_level_state();
}

// Namespace zm_save
// Params 3, eflags: 0x4
// Checksum 0x61123a44, Offset: 0x2112
// Size: 0x264
function private function_32005e96099d4056( player, var_6787895101874fb4, var_66cc4d3d21a0ce0d )
{
    time_left = 0;
    assert( isdefined( level.bgb ) );
    
    switch ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 )
    {
        case #"hash_4f89286e3448ad44":
            bgb_state = undefined;
            
            if ( isdefined( player.bgb_enabled ) )
            {
                bgb_state = player.bgb_enabled[ var_66cc4d3d21a0ce0d ];
            }
            
            if ( isdefined( bgb_state ) && isdefined( bgb_state.start_time ) && isdefined( bgb_state.time_left_at_start ) )
            {
                time_elapsed = gettime() - bgb_state.start_time;
                time_left = maxint( 0, int( bgb_state.time_left_at_start * 1000 ) - time_elapsed );
            }
            else
            {
                time_left = int( level.bgb[ var_66cc4d3d21a0ce0d ].limit * 1000 );
                logstring( "ZM Save: " + "Player Index: " + var_6787895101874fb4 + " BGB: " + var_66cc4d3d21a0ce0d + " missing timed BGB state during save; defaulting to full duration." );
            }
            
            break;
        case #"hash_d80a36cf43c842b8":
            bgb_state = undefined;
            
            if ( isdefined( player.bgb_enabled ) )
            {
                bgb_state = player.bgb_enabled[ var_66cc4d3d21a0ce0d ];
            }
            
            if ( isdefined( bgb_state ) && isdefined( bgb_state.rounds_left ) )
            {
                time_left = maxint( 0, bgb_state.rounds_left - 1 );
            }
            else
            {
                time_left = maxint( 0, level.bgb[ var_66cc4d3d21a0ce0d ].limit - 1 );
                logstring( "ZM Save: " + "Player Index: " + var_6787895101874fb4 + " BGB: " + var_66cc4d3d21a0ce0d + " missing round-limited BGB state during save; defaulting to its configured rounds." );
            }
            
            break;
        case #"hash_d9a7b65f9477385c":
            if ( var_66cc4d3d21a0ce0d == "support_group" )
            {
                xuid = function_fffbd405b1911268( player getxuid() );
                time_left = level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] ?? 0;
            }
            
            break;
        case #"hash_a77aa76e7d308f7f":
            if ( var_66cc4d3d21a0ce0d == "round_off" )
            {
                xuid = function_fffbd405b1911268( player getxuid() );
                time_left = level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] ?? 0;
            }
            
            break;
        default:
            break;
    }
    
    return time_left;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x6ef09a3e, Offset: 0x237f
// Size: 0x3b, Type: bool
function private function_7bb71291321c28de()
{
    if ( !getdvarint( @"hash_9997e24666b05958", 1 ) )
    {
        var_ee7e4762f16f61fd = getdvarint( @"party_maxplayers", 0 );
        
        if ( var_ee7e4762f16f61fd > 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x5788d710, Offset: 0x23c3
// Size: 0x16, Type: bool
function private function_aaa9fbeb31d98559()
{
    return !level.gametypebundle.var_ec584fa263e989f1;
}

// Namespace zm_save
// Params 0
// Checksum 0xe1838f7a, Offset: 0x23e2
// Size: 0xa7, Type: bool
function is_save_load_enabled()
{
    if ( !getdvarint( @"hash_a66117357389df9c", 0 ) && isdefined( level.gametypebundle ) && level.gametypebundle.var_3bcb298d5c2940 && function_aaa9fbeb31d98559() && !level.zm_save_info.disable_save_load )
    {
        if ( isdedicatedserver() )
        {
            if ( function_7a3d4348b3110c54() )
            {
                if ( function_7bb71291321c28de() )
                {
                    return true;
                }
                else
                {
                    var_ee7e4762f16f61fd = getdvarint( @"party_maxplayers", 0 );
                    
                    if ( var_ee7e4762f16f61fd == 1 )
                    {
                        return true;
                    }
                }
            }
        }
        else
        {
            /#
                return true;
            #/
        }
    }
    
    return false;
}

// Namespace zm_save
// Params 0
// Checksum 0xbf2fdf7c, Offset: 0x2492
// Size: 0x36, Type: bool
function is_autosave_enabled()
{
    if ( !is_save_load_enabled() )
    {
        return false;
    }
    
    if ( function_7bb71291321c28de() )
    {
        return false;
    }
    
    if ( isusingmatchrulesdata() && getmatchrulesdata( "zmData", "autosaveEnabled" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_save
// Params 0
// Checksum 0x7a8c9765, Offset: 0x24d1
// Size: 0x19, Type: bool
function function_fcccc3d2a616b1c7()
{
    if ( !is_save_load_enabled() )
    {
        return false;
    }
    
    if ( function_8eee0591fd5c5449() )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_save
// Params 0
// Checksum 0xb54f1768, Offset: 0x24f3
// Size: 0x2e, Type: bool
function function_1dda3554974a999e()
{
    if ( !is_save_load_enabled() )
    {
        return false;
    }
    
    if ( function_fcccc3d2a616b1c7() )
    {
        return true;
    }
    
    return istrue( level.zm_save_info.var_cfebebc6bef5c225 );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x880e66b5, Offset: 0x252a
// Size: 0x103, Type: bool
function private function_dd4205207008db19()
{
    round_number = zm_round_logic::get_rb_round_number();
    
    if ( function_1dda3554974a999e() || round_number <= 1 )
    {
        return false;
    }
    
    assert( isdefined( level.players ) );
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate != "playing" )
        {
            return false;
        }
        
        if ( !isalive( player ) || player::isinlaststand( player ) )
        {
            return false;
        }
        
        if ( player.health < player.maxhealth )
        {
            return false;
        }
    }
    
    if ( isdefined( level.s_exfil_active ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x18b1e7f3, Offset: 0x2636
// Size: 0x25
function private function_9698b815ada87667()
{
    if ( isdefined( level.zm_save_info ) )
    {
        level.zm_save_info.disable_save_load = 1;
    }
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0xf0e111ce, Offset: 0x2663
// Size: 0x22
function private function_3191c44ef2465141()
{
    if ( isdefined( level.zm_save_info ) )
    {
        level.zm_save_info.disable_save_load = undefined;
    }
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xc2e1c4c7, Offset: 0x268d
// Size: 0xf1
function private add_enabled_doors( params )
{
    assert( isdefined( level.zm_save_info ) && isdefined( level.zm_save_info.opened_doors ) );
    
    foreach ( flag in params.enabled_flags )
    {
        if ( arraycontains( level.zm_save_info.opened_doors, flag ) )
        {
            continue;
        }
        
        level.zm_save_info.opened_doors[ level.zm_save_info.opened_doors.size ] = flag;
    }
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xa3d58be0, Offset: 0x2786
// Size: 0xb0
function private power_state_changed( params )
{
    assert( isdefined( level.zm_save_info ) && isdefined( level.zm_save_info.on_switches ) );
    
    if ( params.on )
    {
        level.zm_save_info.on_switches[ level.zm_save_info.on_switches.size ] = params.flag;
        return;
    }
    
    level.zm_save_info.on_switches = arrayremove( level.zm_save_info.on_switches, params.flag );
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0x9ce6080d, Offset: 0x283e
// Size: 0x94
function private set_autosave_stat( val, pause_timer_expired = 0 )
{
    self endon( #"disconnect" );
    assert( isdefined( val ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "auto_save_available", val );
    self setplayerdata( level.var_6f9b00680ed002d8, "auto_save_due_to_pause_timer", pause_timer_expired );
    
    if ( level.gamemodebundle.var_823ca58a582dbbc0 )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "auto_save_type", 0 );
    }
    
    waitframe();
    self function_432458e83a394206( 2 );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0xb11db211, Offset: 0x28da
// Size: 0x2c
function private function_2b2c77dfbdfcda1()
{
    if ( !is_save_load_enabled() )
    {
        return 0;
    }
    
    is_autosave_enabled = is_autosave_enabled();
    assert( is_autosave_enabled );
    return is_autosave_enabled;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x2c6b46d9, Offset: 0x290f
// Size: 0x159
function private function_41bc4ff446281d86()
{
    level endon( #"game_ended" );
    function_2b2c77dfbdfcda1();
    level waittill( #"hash_ed5d7ed8f6aecadb" );
    
    if ( level.var_838b34ec9c6565aa )
    {
        return;
    }
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    if ( isdefined( game[ "telemetry" ] ) )
    {
        game[ "telemetry" ].var_dfe2eb9a94da993c = 1;
    }
    
    if ( !function_dd4205207008db19() )
    {
        return;
    }
    
    commit_session( 1, 1, 1 );
    level.zm_save_info.var_9b56dda5ea34b207 = 1;
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"hash_be8c1e50ae7da3ff", 1 );
    }
    
    if ( isdefined( game[ "telemetry" ] ) )
    {
        game[ "telemetry" ].save_and_end_game_for_pause_expired = 1;
    }
    
    assert( game[ "<dev string:x24>" ][ "<dev string:x2f>" ] == 77 );
    level thread gamelogic_zm::forceend( 77 );
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xae0feef1, Offset: 0x2a70
// Size: 0x6f
function private on_round_end( params )
{
    level.zm_save_info.var_cfebebc6bef5c225 = 0;
    
    if ( function_fcccc3d2a616b1c7() )
    {
        logstring( "ZM Save: " + "Resetting save. Reason: Loaded round has ended." );
        zmsavereset();
    }
    
    save_session( params.var_e7c2c09903c13bf7 );
    
    if ( is_autosave_enabled() )
    {
        commit_session( 1, 0 );
    }
    
    setomnvar( "ui_was_savegame_loaded_this_round", 0 );
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xbf619bb7, Offset: 0x2ae7
// Size: 0xc2
function private on_round_start( params )
{
    if ( function_fcccc3d2a616b1c7() && level.zm_save_info.var_cccdb0a426251ee0 )
    {
        logstring( "ZM Save: " + "Attempting invalidate. Reason: Loaded round has started. Expected players: " + level.zm_save_info.num_players + " Restored players: " + level.zm_save_info.restored_players );
        
        if ( !zmsaveinvalidate() )
        {
            logstring( "ZM Save: " + "Invalidated failed" );
        }
        else
        {
            logstring( "ZM Save: " + "Invalidate succeeded" );
            
            if ( is_autosave_enabled() )
            {
                save_session( 0 );
                commit_session( 1, 0 );
            }
        }
    }
    
    level callback::remove( "on_round_start", &on_round_start );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0xb9911ae5, Offset: 0x2bb1
// Size: 0x1d
function private function_767619d07194353f()
{
    function_2b2c77dfbdfcda1();
    level waittill( #"game_ended" );
    function_6a9908477b8acef1();
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x9f913a31, Offset: 0x2bd6
// Size: 0x1a
function private on_exfil_success( exfil_players )
{
    function_2b2c77dfbdfcda1();
    function_6a9908477b8acef1();
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xd10ae642, Offset: 0x2bf8
// Size: 0x1a
function private on_exfil_failure( exfil_players )
{
    function_2b2c77dfbdfcda1();
    function_6a9908477b8acef1();
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x5bfd3cf8, Offset: 0x2c1a
// Size: 0x115
function private function_6a9908477b8acef1()
{
    if ( !level.zm_save_info.var_f5f3283763443139 )
    {
        return;
    }
    
    if ( level.zm_save_info.var_a664e047f1bd1ffc )
    {
        return;
    }
    
    if ( level.zm_save_info.var_9b56dda5ea34b207 )
    {
        return;
    }
    
    logstring( "ZM Save: " + "Attempting autosave invalidate. Reason: Game ending gracefully" );
    
    if ( !zmsaveinvalidate( 1 ) )
    {
        logstring( "ZM Save: " + "Invalidated failed" );
        return;
    }
    
    logstring( "ZM Save: " + "Invalidate succeeded" );
    level.zm_save_info.var_a664e047f1bd1ffc = 1;
    
    foreach ( player in level.players )
    {
        player thread set_autosave_stat( 0 );
    }
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0xf18121b5, Offset: 0x2d37
// Size: 0x326
function private get_loadout_weapon_info( weapon_index, use_fallback )
{
    var_b87c8459d148bf6a = spawnstruct();
    
    if ( weapon_index == 0 )
    {
        if ( use_fallback )
        {
            saved_weapon_info = self.a_saved_weapons[ "primary" ];
            weapon = saved_weapon_info[ "weapon" ];
        }
        else
        {
            weapon = item_weapon::function_e7484276ad85f220( #"primary_0" );
        }
    }
    else if ( weapon_index == 1 )
    {
        if ( use_fallback )
        {
            saved_weapon_info = self.a_saved_weapons[ "secondary" ];
            weapon = saved_weapon_info[ "weapon" ];
        }
        else
        {
            weapon = item_weapon::function_e7484276ad85f220( #"primary_1" );
        }
    }
    else if ( weapon_index == 2 )
    {
        assert( -1 );
        
        if ( use_fallback )
        {
            saved_weapon_info = self.a_saved_weapons[ "tertiary" ];
            weapon = saved_weapon_info[ "weapon" ];
        }
        else if ( isdefined( self.var_cc1262e66dbb1c79 ) && self hasweapon( self.var_cc1262e66dbb1c79 ) )
        {
            weapon = self.var_cc1262e66dbb1c79;
        }
    }
    else if ( weapon_index == 3 )
    {
        assert( -1 );
        
        if ( use_fallback )
        {
            saved_weapon_info = self.a_saved_weapons[ "third_weapon" ];
            weapon = saved_weapon_info[ "weapon" ];
        }
        else if ( isdefined( self.var_3bf72dcd2775aa78 ) && zombie_perks::has_perk( "specialty_z_mod" ) && self hasweapon( self.var_3bf72dcd2775aa78 ) )
        {
            weapon = self.var_3bf72dcd2775aa78;
        }
    }
    else
    {
        assertmsg( "<dev string:x41>" );
        return var_b87c8459d148bf6a;
    }
    
    var_b87c8459d148bf6a.weapon = weapon;
    
    if ( isdefined( weapon ) && weapon != level.weaponnone )
    {
        if ( use_fallback )
        {
            var_b87c8459d148bf6a.clip_ammo = saved_weapon_info[ "clip_right" ];
            var_b87c8459d148bf6a.stock_ammo = saved_weapon_info[ "stock" ];
            var_b87c8459d148bf6a.alt_clip_ammo = saved_weapon_info[ "alt_clip" ];
            var_b87c8459d148bf6a.alt_stock_ammo = saved_weapon_info[ "alt_stock" ];
            var_b87c8459d148bf6a.pap_level = saved_weapon_info[ "pap_level" ];
            var_b87c8459d148bf6a.rarity = saved_weapon_info[ "rarity" ];
            var_b87c8459d148bf6a.ammo_mod = saved_weapon_info[ "ammo_mod" ];
            
            if ( var_b87c8459d148bf6a.ammo_mod == "" )
            {
                var_b87c8459d148bf6a.ammo_mod = "none";
            }
        }
        else
        {
            var_b87c8459d148bf6a.clip_ammo = self getweaponammoclip( weapon );
            var_b87c8459d148bf6a.stock_ammo = self getweaponammostock( weapon );
            altweapon = weapon getaltweapon();
            var_b87c8459d148bf6a.alt_clip_ammo = self getweaponammoclip( altweapon );
            var_b87c8459d148bf6a.alt_stock_ammo = self getweaponammostock( altweapon );
            var_b87c8459d148bf6a.pap_level = pack_a_punch::get_pap_level( weapon );
            var_b87c8459d148bf6a.rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
            var_b87c8459d148bf6a.ammo_mod = ammo_mod::get_ammo_mod_name( weapon );
            
            if ( var_b87c8459d148bf6a.ammo_mod == "" )
            {
                var_b87c8459d148bf6a.ammo_mod = "none";
            }
        }
    }
    
    return var_b87c8459d148bf6a;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x9b8847da, Offset: 0x3066
// Size: 0x494
function private get_loadout_struct( var_85b15254d9d08b51 = 1 )
{
    loadout_struct = spawnstruct();
    loadout_struct.weapons = [];
    use_fallback = var_85b15254d9d08b51 && isdefined( self.a_saved_weapons );
    
    for ( weapon_index = 0; weapon_index < 4 ; weapon_index++ )
    {
        loadout_struct.weapons[ weapon_index ] = get_loadout_weapon_info( weapon_index, use_fallback );
    }
    
    if ( use_fallback )
    {
        logstring( "ZM Save: " + "Retrieving loadout from cached data (i.e. player.a_saved_weapons). CACHE SOURCE: " + ( isdefined( self.a_saved_weapons[ "save_source" ] ) ? self.a_saved_weapons[ "save_source" ] : "UNDEFINED" ) );
        loadout_struct.lethal = spawnstruct();
        lethal_equip = self.a_saved_weapons[ "equip_primary" ][ "weapon" ];
        
        if ( isdefined( lethal_equip ) )
        {
            item = getscriptbundle( lethal_equip.name );
            loadout_struct.lethal.ref = item.ref;
            loadout_struct.lethal.ammo = lethal_equip.count;
        }
        
        loadout_struct.tactical = spawnstruct();
        
        if ( isdefined( self.var_87522aee8be7890b.ref ) )
        {
            loadout_struct.tactical.ref = self.var_87522aee8be7890b.ref;
            loadout_struct.tactical.ammo = self.var_87522aee8be7890b.ammo;
        }
        else
        {
            tactical_equip = self.a_saved_weapons[ "equip_secondary" ][ "weapon" ];
            
            if ( isdefined( tactical_equip ) )
            {
                item = getscriptbundle( tactical_equip.name );
                loadout_struct.tactical.ref = item.ref;
                loadout_struct.tactical.ammo = tactical_equip.count;
            }
        }
        
        loadout_struct.super = spawnstruct();
        loadout_struct.super.ref = self.a_saved_weapons[ "super" ][ "ref" ];
        
        if ( isdefined( loadout_struct.super.ref ) )
        {
            loadout_struct.super.points = int( self.a_saved_weapons[ "super" ][ "points" ] );
            loadout_struct.super.extra_points = int( self.a_saved_weapons[ "super" ][ "extra_points" ] );
        }
    }
    else
    {
        loadout_struct.lethal = spawnstruct();
        loadout_struct.lethal.ref = equipment_mp::getcurrentequipment( "primary" );
        loadout_struct.lethal.ammo = equipment_mp::getequipmentslotammo( "primary" );
        loadout_struct.tactical = spawnstruct();
        
        if ( isdefined( self.var_87522aee8be7890b.ref ) )
        {
            loadout_struct.tactical.ref = self.var_87522aee8be7890b.ref;
            loadout_struct.tactical.ammo = self.var_87522aee8be7890b.ammo;
        }
        else
        {
            loadout_struct.tactical.ref = equipment_mp::getcurrentequipment( "secondary" );
            loadout_struct.tactical.ammo = equipment_mp::getequipmentslotammo( "secondary" );
        }
        
        loadout_struct.super = spawnstruct();
        loadout_struct.super.ref = supers_mp::getcurrentsuperref();
        
        if ( isdefined( loadout_struct.super.ref ) )
        {
            loadout_struct.super.points = int( supers_mp::getcurrentsuperpoints() );
            loadout_struct.super.extra_points = int( self.overclockcharge ?? 0 );
        }
    }
    
    return loadout_struct;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xe4378e66, Offset: 0x3503
// Size: 0x31
function private function_b307ddfb2258fbc3( params )
{
    if ( !isdefined( self.a_saved_weapons ) )
    {
        self.var_efcb1d40c8085364 = 1;
        zm_utility::function_d47920bb0d5fa327( "zmsave_mutantinjection_startcallback" );
    }
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x5982d4a0, Offset: 0x353c
// Size: 0x2c
function private function_272ebe68c945c463( params )
{
    if ( self.var_efcb1d40c8085364 )
    {
        self.a_saved_weapons = undefined;
        self.var_efcb1d40c8085364 = undefined;
    }
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x6fee9969, Offset: 0x3570
// Size: 0x2c
function private function_e498c41fd90a8d6( params )
{
    if ( self.var_efcb1d40c8085364 )
    {
        self.a_saved_weapons = undefined;
        self.var_efcb1d40c8085364 = undefined;
    }
}

// Namespace zm_save
// Params 3, eflags: 0x4
// Checksum 0x6921eda1, Offset: 0x35a4
// Size: 0x14d
function private function_d10876b2c42aaf3d( var_d502348c16c8d691, path, var_9b69f851734acea6 )
{
    path[ path.size ] = var_d502348c16c8d691.ref;
    
    if ( var_d502348c16c8d691.steps.size > 0 && var_d502348c16c8d691.linear_substeps )
    {
        foreach ( substep_index, step in var_d502348c16c8d691.steps )
        {
            if ( step.completed )
            {
                continue;
            }
            
            if ( substep_index > 0 )
            {
                var_72e55ab04fe9d84 = var_d502348c16c8d691.steps[ substep_index - 1 ];
            }
            else
            {
                var_72e55ab04fe9d84 = undefined;
            }
            
            return function_d10876b2c42aaf3d( step, path, var_72e55ab04fe9d84 );
        }
    }
    
    if ( var_d502348c16c8d691.var_c51acbb2ef22425b && isdefined( var_9b69f851734acea6 ) )
    {
        path[ path.size - 1 ] = var_9b69f851734acea6.ref;
        return [ var_9b69f851734acea6, path ];
    }
    
    return [ var_d502348c16c8d691, path ];
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0xcbac3712, Offset: 0x36f9
// Size: 0x51d, Type: bool
function private save_quest( quest, var_9c3b47fc1d714f47 )
{
    zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "name", quest.ref );
    zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "completed", quest.var_66751ff7ae3ea95f ?? quest.completed );
    
    if ( quest.save_kvps.size > 16 )
    {
        assertmsg( "<dev string:x73>" + quest.ref );
        return false;
    }
    
    var_2a88723414227592 = 0;
    
    foreach ( key, value in quest.save_kvps )
    {
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "state_keys", var_2a88723414227592, key );
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "state_values", var_2a88723414227592, value );
        var_2a88723414227592++;
    }
    
    while ( var_2a88723414227592 < 16 )
    {
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "state_keys", var_2a88723414227592, "" );
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "state_values", var_2a88723414227592, 0 );
        var_2a88723414227592++;
    }
    
    respawn_round = quest.n_respawn_round ?? 0;
    zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "respawn_round", respawn_round );
    
    if ( quest.completed )
    {
        return true;
    }
    
    var_7be076c9078045aa = quest.steps[ quest.var_7be076c9078045aa ];
    
    if ( quest.var_7be076c9078045aa > 0 )
    {
        var_9b69f851734acea6 = quest.steps[ quest.var_7be076c9078045aa - 1 ];
    }
    else
    {
        var_9b69f851734acea6 = undefined;
    }
    
    [ active_step, path ] = function_d10876b2c42aaf3d( var_7be076c9078045aa, [], var_9b69f851734acea6 );
    
    if ( path.size > 4 )
    {
        assertmsg( "<dev string:xb4>" + quest.ref );
        return false;
    }
    
    if ( active_step.steps.size > 10 )
    {
        assertmsg( "<dev string:xf0>" + quest.ref );
        return false;
    }
    
    var_1f42fb5079240912 = 0;
    
    foreach ( step in path )
    {
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "path", var_1f42fb5079240912, step );
        var_1f42fb5079240912++;
    }
    
    while ( var_1f42fb5079240912 < 4 )
    {
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "path", var_1f42fb5079240912, "" );
        var_1f42fb5079240912++;
    }
    
    active_step_progress = active_step.current_progress ?? 0;
    zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "active_step_progress", active_step_progress );
    substep_index = 0;
    
    foreach ( var_ca114aa12dee1e8e in active_step.steps )
    {
        name = var_ca114aa12dee1e8e.ref;
        completed = var_ca114aa12dee1e8e.completed;
        progress = var_ca114aa12dee1e8e.current_progress ?? 0;
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "substeps", substep_index, "name", name );
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "substeps", substep_index, "completed", completed );
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "substeps", substep_index, "progress", progress );
        substep_index++;
    }
    
    while ( substep_index < 10 )
    {
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "substeps", substep_index, "name", "" );
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "substeps", substep_index, "completed", 0 );
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "substeps", substep_index, "progress", 0 );
        substep_index++;
    }
    
    return true;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xf0805261, Offset: 0x3c1f
// Size: 0x107c
function private save_level_state( is_round_progressing )
{
    logstring( "ZM Save: " + "Level save begin" );
    zmsavewrite( "save_version", 1 );
    logstring( "ZM Save: " + "Wrote: Version: " + 1 );
    round_number = zm_round_logic::get_rb_round_number();
    assert( round_number >= 1 );
    
    if ( is_round_progressing )
    {
        round_number++;
        
        if ( level.var_dc917abcf5b8f749 > 0 )
        {
            round_number = level.var_dc917abcf5b8f749;
        }
    }
    
    zmsavewrite( "save", "round_num", round_number );
    logstring( "ZM Save: " + "Wrote: Round number: " + round_number );
    round_cap = zm_round_logic::get_rb_round_cap();
    assert( isdefined( round_cap ) && round_number >= 1 );
    zmsavewrite( "save", "round_cap", round_cap );
    logstring( "ZM Save: " + "Wrote: Round cap: " + round_cap );
    timestamp = getsystemtime();
    assert( timestamp > 0 );
    zmsavewrite( "save", "timestamp", timestamp );
    logstring( "ZM Save: " + "Wrote: Timestamp: " + timestamp );
    rampage_inducer_state = level utility::flag( "rampage_inducer_activated" );
    zmsavewrite( "save", "rampage_inducer_activated", rampage_inducer_state );
    logstring( "ZM Save: " + "Wrote: Rampage Inducer: " + rampage_inducer_state );
    num_global_perks_purchased = level.var_af8e5ce115d7696f ?? 0;
    zmsavewrite( "save", "num_global_perks_purchased", num_global_perks_purchased );
    logstring( "ZM Save: " + "Wrote: Num Global Perks Purchased: " + num_global_perks_purchased );
    zmsavewrite( "save", "perk_threshold_reached", istrue( level.var_865fa84b8f7cc220 ) );
    logstring( "ZM Save: " + "Wrote: Perk purchase threshold: " + istrue( level.var_865fa84b8f7cc220 ) );
    min_elite_round_appearance = zm_round_spawning::function_30c3e881d71480cb();
    zmsavewrite( "save", "min_elite_round_appearance", min_elite_round_appearance );
    logstring( "ZM Save: " + "Wrote: Min next elite round appearance: " + min_elite_round_appearance );
    var_aba266c8200a8328 = [];
    var_a1ffaa8cd30f2c9b = 0;
    num_dev_spawned = 0;
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( ( zombie.aicategory == "elite" || zombie.aicategory == "hvt" ) && !zombie.var_e7095781f14d8c2d )
        {
            var_d0c6b7fe2f128d03 = zombie zm_cleanup_manager::get_zombie_respawn_info();
            
            if ( isdefined( var_d0c6b7fe2f128d03 ) )
            {
                var_a1ffaa8cd30f2c9b++;
                
                if ( zombie.spawn_source == "dev_spawned" )
                {
                    num_dev_spawned++;
                }
                
                var_d0c6b7fe2f128d03.aitype = zombie.subclass;
                var_d0c6b7fe2f128d03.metabones = zombie get_metabone_states();
                
                if ( var_aba266c8200a8328.size < 8 )
                {
                    var_aba266c8200a8328[ var_aba266c8200a8328.size ] = var_d0c6b7fe2f128d03;
                }
            }
        }
    }
    
    assert( var_a1ffaa8cd30f2c9b - num_dev_spawned <= 8, "<dev string:x12f>" + 8 + "<dev string:x15a>" + var_a1ffaa8cd30f2c9b + "<dev string:x16b>" + num_dev_spawned );
    save_index = 0;
    
    foreach ( var_d0c6b7fe2f128d03 in var_aba266c8200a8328 )
    {
        zmsavewrite( "save", "elite_zombies", save_index, "subclass", var_d0c6b7fe2f128d03.aitype );
        zmsavewrite( "save", "elite_zombies", save_index, "health", var_d0c6b7fe2f128d03.savedhealth ?? 0 );
        zmsavewrite( "save", "elite_zombies", save_index, "max_health", var_d0c6b7fe2f128d03.savedmaxhealth ?? 0 );
        metabone_index = 0;
        
        foreach ( metabone in var_d0c6b7fe2f128d03.metabones )
        {
            zmsavewrite( "save", "elite_zombies", save_index, "metabones", metabone_index, "name", metabone.name );
            zmsavewrite( "save", "elite_zombies", save_index, "metabones", metabone_index, "is_active", metabone.is_active );
            zmsavewrite( "save", "elite_zombies", save_index, "metabones", metabone_index, "state_index", metabone.state_index );
            metabone_index++;
        }
        
        while ( metabone_index < 14 )
        {
            zmsavewrite( "save", "elite_zombies", save_index, "metabones", metabone_index, "name", "" );
            zmsavewrite( "save", "elite_zombies", save_index, "metabones", metabone_index, "is_active", 0 );
            zmsavewrite( "save", "elite_zombies", save_index, "metabones", metabone_index, "state_index", 0 );
            metabone_index++;
        }
        
        save_index++;
    }
    
    logstring( "ZM Save: " + "Wrote: Elite zombies" );
    
    while ( save_index < 8 )
    {
        zmsavewrite( "save", "elite_zombies", save_index, "subclass", "" );
        save_index++;
    }
    
    if ( isdefined( level.scarab_ee_masks ) )
    {
        if ( level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_hose_ee_mask" ] )
        {
            zmsavewrite( "save", "safehouse_ee_mask", 1 );
        }
        
        if ( level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_twins_ee_mask" ] )
        {
            zmsavewrite( "save", "twins_ee_mask", 1 );
        }
        
        if ( level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_grp_ee_mask" ] )
        {
            zmsavewrite( "save", "grapple_challenge_ee_mask", 1 );
        }
        
        if ( level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_loom_ride_ee_mask" ] )
        {
            zmsavewrite( "save", "spider_ride_ee_mask", 1 );
        }
    }
    
    var_2df7f5ec44901941 = doorbuy::function_ebd700ab45c45880();
    save_index = 0;
    
    if ( var_2df7f5ec44901941 > 48 || level.zm_save_info.opened_doors.size > var_2df7f5ec44901941 )
    {
        assertmsg( "<dev string:x17f>" );
    }
    else
    {
        foreach ( flag in level.zm_save_info.opened_doors )
        {
            zmsavewrite( "save", "enabled_doors", save_index, flag );
            save_index++;
        }
        
        logstring( "ZM Save: " + "Wrote: Doors" );
    }
    
    while ( save_index < 48 )
    {
        zmsavewrite( "save", "enabled_doors", save_index, "" );
        save_index++;
    }
    
    var_21d71dae194b819 = electric_power_switch::function_dec0a4e06ef0b6b2();
    save_index = 0;
    
    if ( var_21d71dae194b819 > 4 || level.zm_save_info.on_switches.size > var_21d71dae194b819 )
    {
        assertmsg( "<dev string:x1aa>" );
    }
    else
    {
        foreach ( flag in level.zm_save_info.on_switches )
        {
            zmsavewrite( "save", "enabled_power_switches", save_index, flag );
            save_index++;
        }
        
        logstring( "ZM Save: " + "Wrote: Power switches" );
    }
    
    while ( save_index < 4 )
    {
        zmsavewrite( "save", "enabled_power_switches", save_index, "" );
        save_index++;
    }
    
    num_used = level.var_410b736ba41817c2 ?? 0;
    num_moved = level.var_1c98168ff9213851 ?? 0;
    zmsavewrite( "save", "magic_box_state", "num_used", num_used );
    zmsavewrite( "save", "magic_box_state", "num_moved", num_moved );
    found_box = 0;
    
    if ( isdefined( level.var_1bbb5557537e2c0c ) )
    {
        foreach ( var_1fb242bbb1a67fdf in level.var_1bbb5557537e2c0c )
        {
            if ( var_1fb242bbb1a67fdf.var_f14b2b4820b635e7 )
            {
                found_box = 1;
                zone_name = "";
                nav_origin = getclosestpointonnavmesh( var_1fb242bbb1a67fdf.origin );
                
                if ( isdefined( nav_origin ) )
                {
                    zone = zone_manager::function_90e5c3e2272b0130( nav_origin );
                    
                    if ( isdefined( zone.zone_name ) )
                    {
                        zone_name = zone.zone_name;
                    }
                }
                
                zmsavewrite( "save", "magic_box_state", "current_zone", zone_name );
                logstring( "ZM Save: " + "Wrote: Magic box at " + zone_name );
                break;
            }
        }
    }
    
    if ( !found_box )
    {
        zmsavewrite( "save", "magic_box_state", "current_zone", "" );
    }
    
    if ( isdefined( level.var_69fdad347dd6817 ) )
    {
        foreach ( index, chompy in level.var_69fdad347dd6817 )
        {
            if ( chompy.activated )
            {
                zmsavewrite( "save", "chompy_state", index, "current_zone", chompy.zone );
                logstring( "ZM Save: " + "Wrote: Chompy at " + chompy.zone );
            }
        }
    }
    
    if ( isdefined( level.var_27f7b165ac055579 ) )
    {
        zmsavewrite( "save", "og_barnacle_spawned_num", level.var_bb5b506ca2aa7e9c );
        
        foreach ( index, Barnacle in level.zm_barnacles )
        {
            zmsavewrite( "save", "barnacle", index, "index", Barnacle.save_index );
            
            if ( Barnacle getscriptablepartstate( "body" ) == "healthy" )
            {
                zmsavewrite( "save", "barnacle", index, "alive", 1 );
            }
            else
            {
                zmsavewrite( "save", "barnacle", index, "alive", 0 );
            }
            
            if ( isdefined( Barnacle.respawn_round ) )
            {
                zmsavewrite( "save", "barnacle", index, "barnacle_respawn_round", Barnacle.respawn_round );
                continue;
            }
            
            zmsavewrite( "save", "barnacle", index, "barnacle_respawn_round", 0 );
        }
    }
    
    if ( isdefined( level.melted_mannequins ) )
    {
        if ( level.melted_mannequins.size > 16 )
        {
            assertmsg( "<dev string:x1dd>" );
            utility::array_slice( level.melted_mannequins, 0, 16 );
        }
        
        for ( i = 0; i < level.melted_mannequins.size ; i++ )
        {
            zmsavewrite( "save", "melted_mannequins", i, level.melted_mannequins[ i ] );
        }
        
        logstring( "ZM Save: " + "Wrote: Melted Mannequins" );
    }
    
    var_536bdcba70828281 = [];
    var_d99effd565aaa2bd = 0;
    
    foreach ( quest in level.zm_quests )
    {
        if ( !isstruct( quest ) )
        {
            continue;
        }
        
        if ( quest.dont_save )
        {
            continue;
        }
        
        var_d99effd565aaa2bd++;
        
        if ( !quest.started )
        {
            continue;
        }
        
        var_536bdcba70828281[ var_536bdcba70828281.size ] = quest;
    }
    
    var_9c3b47fc1d714f47 = 0;
    
    if ( var_d99effd565aaa2bd > 30 )
    {
        assertmsg( "<dev string:x22a>" );
    }
    else
    {
        foreach ( quest in var_536bdcba70828281 )
        {
            if ( save_quest( quest, var_9c3b47fc1d714f47 ) )
            {
                var_9c3b47fc1d714f47++;
            }
        }
        
        logstring( "ZM Save: " + "Wrote: Quests" );
    }
    
    while ( var_9c3b47fc1d714f47 < 30 )
    {
        zmsavewrite( "save", "quests", var_9c3b47fc1d714f47, "name", "" );
        var_9c3b47fc1d714f47++;
    }
    
    relics_count = level.active_relics.size;
    
    if ( relics_count > 0 )
    {
        save_index = 0;
        
        if ( relics_count > 30 )
        {
            assertmsg( "<dev string:x256>" );
        }
        else
        {
            foreach ( relichash in level.active_relics )
            {
                if ( level.zm_relics[ relichash ] )
                {
                    zmsavewrite( "save", "relics_active", save_index, level.zm_relics[ relichash ].lootid );
                }
                
                save_index++;
            }
            
            logstring( "ZM Save: " + "Wrote: Relics Active" );
        }
        
        while ( save_index < 30 )
        {
            zmsavewrite( "save", "relics_active", save_index, 0 );
            save_index++;
        }
    }
    
    if ( isdefined( level.timetravel ) )
    {
        timeline = utility::flag( "timetravel_ongoing" ) ? time_travel::get_next_timeline() : level.timetravel.timeline;
        zmsavewrite( "save", "timetravel_timeline", timeline.name );
        logstring( "ZM Save: " + "Wrote: Timetravel Current Timeline: " + timeline.name );
    }
    
    if ( isdefined( level.timewarps ) )
    {
        zmsavewrite( "save", "timewarps_init", istrue( level.timewarps.initialized ) );
        logstring( "ZM Save: " + "Wrote: Timewarps Initialized: " + level.timewarps.initialized );
    }
    
    if ( isdefined( level.saved_seed ) )
    {
        zmsavewrite( "save", "seed", level.saved_seed );
        logstring( "ZM Save: " + "Wrote: Seed: " + level.saved_seed );
    }
    
    logstring( "ZM Save: " + "Level save complete" );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x3b0134c2, Offset: 0x4ca3
// Size: 0x137
function private get_metabone_states()
{
    metabones = [];
    
    if ( self.metabones )
    {
        metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
        
        foreach ( metabone in metabones_def.metabones )
        {
            metabone_info = self.metabones.info[ metabone.name ];
            metabone_save = spawnstruct();
            metabone_save.name = metabone.name;
            metabone_save.is_active = metabone_info.is_active;
            metabone_save.state_index = metabone_info.current_state_index ?? 0;
            metabones[ metabones.size ] = metabone_save;
        }
    }
    
    return metabones;
}

// Namespace zm_save
// Params 2
// Checksum 0x7c881ef5, Offset: 0x4de3
// Size: 0x2300
function save_player_state( type, var_6787895101874fb4 )
{
    self endon( #"disconnect" );
    logstring( "ZM Save: " + "Player " + self getentitynumber() + " save begin" );
    params = spawnstruct();
    callback::callback( #"hash_f2c79b44bf002ece", params );
    self.var_f09d95abf79cd6b6 = var_6787895101874fb4;
    
    if ( self.sessionstate == "playing" && isalive( self ) )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "player_spawn_state", "alive" );
    }
    else if ( self.var_5c81ab2cabcc273f )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "player_spawn_state", "respawn" );
    }
    else
    {
        save_write( type, "save", "players", var_6787895101874fb4, "player_spawn_state", "hotjoin" );
    }
    
    loadout_struct = get_loadout_struct();
    weapon_index = 0;
    
    for ( weapon_index = 0; weapon_index < 4 ; weapon_index++ )
    {
        var_b87c8459d148bf6a = loadout_struct.weapons[ weapon_index ];
        weapon = var_b87c8459d148bf6a.weapon;
        
        if ( !isdefined( weapon ) || weapon == level.weaponnone )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "weaponLootID", 0 );
            continue;
        }
        
        var_7068c97ad157148 = weapon::getweaponrootname( weapon );
        loot_id = loot::getlootidfromref( var_7068c97ad157148 ) ?? 0;
        var_eb9f90c52851b4d9 = weapon.variantid ?? 0;
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "weaponLootID", loot_id );
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "weaponVariantID", var_eb9f90c52851b4d9 );
        attachments = getweaponattachments( weapon );
        var_b8195033cf8c432 = 0;
        var_b68dc114fe2a190e = weapon.attachmentvarindices;
        var_5c215cf93fd669e2 = weapon::getbaseweaponattachdefaulttoidmap( var_7068c97ad157148 );
        
        for ( var_4345f239ffa3344 = 0; var_4345f239ffa3344 < attachments.size && var_b8195033cf8c432 < 16 ; var_4345f239ffa3344++ )
        {
            if ( !isdefined( var_5c215cf93fd669e2[ attachments[ var_4345f239ffa3344 ] ] ) )
            {
                attachment_data_name = function_333a08591af6b59( weapon, attachments[ var_4345f239ffa3344 ] );
                
                if ( isdefined( attachment_data_name ) )
                {
                    attachment_loot_id = getscriptbundlefieldvalue( attachment_data_name, #"lootid" ) ?? 0;
                }
                else
                {
                    attachment_loot_id = 0;
                }
                
                save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "attachmentSetup", var_b8195033cf8c432, "attachmentLootID", attachment_loot_id );
                save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "attachmentSetup", var_b8195033cf8c432, "attachmentVariantID", var_b68dc114fe2a190e[ attachments[ var_4345f239ffa3344 ] ] ?? 0 );
                var_b8195033cf8c432++;
            }
        }
        
        while ( var_b8195033cf8c432 < 16 )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "attachmentSetup", var_b8195033cf8c432, "attachmentLootID", 0 );
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "attachmentSetup", var_b8195033cf8c432, "attachmentVariantID", 0 );
            var_b8195033cf8c432++;
        }
        
        if ( isdefined( weapon.camo ) )
        {
            camo_loot_id = loot::getlootidfromref( weapon.camo ) ?? "camo_none";
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "camoLootID", camo_loot_id );
        }
        
        if ( isdefined( weapon.reticle ) )
        {
            var_eafc15f24be8abe7 = function_64144d3177c6bcce( weapon );
            
            if ( isdefined( var_eafc15f24be8abe7 ) )
            {
                reticle_loot_id = getscriptbundlefieldvalue( var_eafc15f24be8abe7, #"lootid" ) ?? 0;
            }
            else
            {
                reticle_loot_id = 0;
            }
            
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "reticleLootID", reticle_loot_id );
        }
        
        if ( isdefined( weapon.charmscriptbundle ) )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "cosmeticAttachmentLootID", loot::getlootidfromref( weapon.charmscriptbundle.charmref ) );
        }
        
        stickers = [ weapon.stickerslot0, weapon.stickerslot1, weapon.stickerslot2, weapon.stickerslot3, weapon.var_73762c7cb8b2063 ?? "sticker_none" ];
        slot = 0;
        
        foreach ( slot, sticker in stickers )
        {
            if ( sticker == "sticker_none" || sticker == "none" )
            {
                save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "stickerLootIDs", slot, 0 );
                continue;
            }
            
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "stickerLootIDs", slot, loot::getlootidfromref( getsubstr( sticker, 2 ) ) );
        }
        
        clip_ammo = var_b87c8459d148bf6a.clip_ammo;
        stock_ammo = var_b87c8459d148bf6a.stock_ammo;
        alt_clip_ammo = var_b87c8459d148bf6a.alt_clip_ammo;
        alt_stock_ammo = var_b87c8459d148bf6a.alt_stock_ammo;
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "clip_ammo", clip_ammo );
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "stock_ammo", stock_ammo );
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "alt_clip_ammo", alt_clip_ammo );
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "alt_stock_ammo", alt_stock_ammo );
        pap_level = var_b87c8459d148bf6a.pap_level;
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "pack_level", pap_level );
        var_a486557eb8209c53 = loot::getlootidfromref( self.var_60c2ab39157e81d2[ weapon.var_1616e6fbba9a722d ] ?? "camo_none" );
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "camo_lootID_before_pap", var_a486557eb8209c53 );
        rarity = var_b87c8459d148bf6a.rarity;
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "rarity", rarity );
        ammo_mod = var_b87c8459d148bf6a.ammo_mod;
        save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "ammo_mod", ammo_mod );
        
        if ( level.var_78b06bc85775ee0.size > 0 )
        {
            is_wallbuy_weapon = arraycontains( level.var_78b06bc85775ee0, weapon );
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_wallbuy_weapon", is_wallbuy_weapon );
        }
        else
        {
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_wallbuy_weapon", 0 );
        }
        
        if ( level.var_73d6fa41113ea1a8.size > 0 )
        {
            is_magicbox_weapon = arraycontains( level.var_73d6fa41113ea1a8, weapon );
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_magicbox_weapon", is_magicbox_weapon );
        }
        else
        {
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_magicbox_weapon", 0 );
        }
        
        var_1353699ce76de43a = self.var_ba3dc11e269136ed;
        
        if ( var_1353699ce76de43a.size > 0 )
        {
            is_quest_weapon = 0;
            
            if ( isarray( var_1353699ce76de43a ) )
            {
                is_quest_weapon = arraycontains( var_1353699ce76de43a, weapon.basename );
            }
            
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_quest_weapon_for_relic", is_quest_weapon );
        }
        else
        {
            save_write( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_quest_weapon_for_relic", 0 );
        }
        
        logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Weapon index: " + weapon_index + " Name: " + var_7068c97ad157148 + " Pap: " + pap_level );
    }
    
    lethal = loadout_struct.lethal.ref;
    lethal_ammo = loadout_struct.lethal.ammo;
    
    if ( isdefined( lethal ) && isdefined( lethal_ammo ) )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 0, "name", lethal );
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 0, "count", lethal_ammo );
        logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Lethal: " + lethal );
    }
    else
    {
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 0, "name", "none" );
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 0, "count", 0 );
    }
    
    tactical = loadout_struct.tactical.ref;
    tactical_ammo = loadout_struct.tactical.ammo;
    
    if ( isdefined( tactical ) && isdefined( tactical_ammo ) )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 1, "name", tactical );
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 1, "count", tactical_ammo );
        logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Tactical: " + tactical );
    }
    else
    {
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 1, "name", "none" );
        save_write( type, "save", "players", var_6787895101874fb4, "equipments", 1, "count", 0 );
    }
    
    super = loadout_struct.super.ref;
    
    if ( isdefined( super ) )
    {
        super = supers_mp::function_8738421e46f2cfbc( super );
        points = loadout_struct.super.points;
        extra_points = loadout_struct.super.extra_points;
        save_write( type, "save", "players", var_6787895101874fb4, "super", "name", super );
        save_write( type, "save", "players", var_6787895101874fb4, "super", "charge", points );
        save_write( type, "save", "players", var_6787895101874fb4, "super", "extra_charge", extra_points );
        logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Super: " + super );
    }
    else
    {
        save_write( type, "save", "players", var_6787895101874fb4, "super", "name", "none" );
        save_write( type, "save", "players", var_6787895101874fb4, "super", "charge", 0 );
    }
    
    essence = int( currency::get_currency_amount( #"essence" ) );
    salvage = int( currency::get_currency_amount( #"salvage" ) );
    rare_salvage = int( currency::get_currency_amount( #"rare_salvage" ) );
    save_write( type, "save", "players", var_6787895101874fb4, "essence", essence );
    save_write( type, "save", "players", var_6787895101874fb4, "salvage", salvage );
    save_write( type, "save", "players", var_6787895101874fb4, "rare_salvage", rare_salvage );
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Essence: " + essence + " Salvage: " + salvage + " Rare salvage: " + rare_salvage );
    self_revive_count = laststand::function_7072b516e6cffb7c();
    self_revive_used = self.var_aecc486f34e4dd66 ?? 0;
    self_revive_crafted = self.var_3b2b912816c110b4 ?? 0;
    last_stand_count = self.last_stand_count ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "self_revive_count", self_revive_count );
    save_write( type, "save", "players", var_6787895101874fb4, "self_revive_used", self_revive_used );
    save_write( type, "save", "players", var_6787895101874fb4, "self_revive_crafted", self_revive_crafted );
    save_write( type, "save", "players", var_6787895101874fb4, "downs", last_stand_count );
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Self Revive Count: " + self_revive_count + " Used: " + self_revive_used + " Crafted: " + self_revive_crafted + " Downs Count: " + last_stand_count );
    armor_plates = armor::function_22290101992e4874();
    save_write( type, "save", "players", var_6787895101874fb4, "armor_plates", armor_plates );
    armor_level = self.platecarrierlevel ?? 1;
    save_write( type, "save", "players", var_6787895101874fb4, "armor_level", armor_level );
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Armor plates: " + armor_plates + " Armor level: " + armor_level );
    loot_key_level = self.n_loot_key_level ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "loot_key_level", loot_key_level );
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Loot key level: " + loot_key_level );
    total_purchased_perks = self.total_purchased_perks ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "total_purchased_perks", total_purchased_perks );
    active_perks = zombie_perks::get_active_perks_str_array();
    perma_perks = self.perma_perks;
    purchased_perks = [];
    
    if ( self.perkspurchased.size > 0 )
    {
        count = 0;
        
        foreach ( perk, var_e90472a83f1bd909 in self.perkspurchased )
        {
            purchased_perks[ count ] = perk;
            count++;
        }
    }
    
    if ( self.ismutantinjection )
    {
        if ( isdefined( self.micontext.var_d2526179d91798d6 ) )
        {
            foreach ( perk in self.micontext.var_d2526179d91798d6 )
            {
                if ( !arraycontains( active_perks, perk ) )
                {
                    active_perks[ active_perks.size ] = perk;
                }
            }
        }
    }
    
    save_index = 0;
    
    if ( active_perks.size > 16 )
    {
        assertmsg( "<dev string:x289>" );
    }
    else
    {
        foreach ( index, perk in active_perks )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "active_perks", index, perk );
            logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Perk: " + perk );
            save_index++;
        }
    }
    
    for ( index = save_index; index < 16 ; index++ )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "active_perks", index, "none" );
    }
    
    save_index = 0;
    
    if ( purchased_perks.size > 16 )
    {
        assertmsg( "<dev string:x289>" );
    }
    else
    {
        foreach ( index, perk in purchased_perks )
        {
            if ( perk != "specialty_choice" )
            {
                save_write( type, "save", "players", var_6787895101874fb4, "purchased_perks", index, perk );
                logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Purchased Perk: " + perk );
                save_index++;
            }
        }
    }
    
    for ( index = save_index; index < 16 ; index++ )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "purchased_perks", index, "none" );
    }
    
    save_index = 0;
    
    if ( perma_perks.size > 16 )
    {
        assertmsg( "<dev string:x2b4>" + perma_perks.size );
    }
    else
    {
        foreach ( index, perk in perma_perks )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "perma_perks", index, perk );
            logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Perma Perk: " + perk );
            save_index++;
        }
    }
    
    for ( index = save_index; index < 16 ; index++ )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "perma_perks", index, "none" );
    }
    
    increased_cost = int( self.var_6b07486215a175b0 ?? 0 );
    save_write( type, "save", "players", var_6787895101874fb4, "super_increased_cost", increased_cost );
    save_index = 0;
    var_7b31b3b5b53c8c23 = getnoentvolumearray( "lc_trigger", "targetname" );
    
    foreach ( index, trigger in var_7b31b3b5b53c8c23 )
    {
        if ( index < 16 )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "active_loose_change", index, trigger.script_noteworthy );
            logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Loose Change: " + trigger.script_noteworthy );
            save_index++;
            continue;
        }
        
        break;
    }
    
    for ( index = save_index; index < 16 ; index++ )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "active_loose_change", index, "none" );
    }
    
    score_earned = self.total_score_earned ?? 0;
    kills = self.pers[ "kills" ] ?? 0;
    critical_kills = self.pers[ "extrascore2" ] ?? 0;
    doorbuys_opened = self.doorbuycount ?? 0;
    revives_completed = self.revivecount ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "scoreboard", "total_score", score_earned );
    save_write( type, "save", "players", var_6787895101874fb4, "scoreboard", "kills", kills );
    save_write( type, "save", "players", var_6787895101874fb4, "scoreboard", "critical_kills", critical_kills );
    save_write( type, "save", "players", var_6787895101874fb4, "scoreboard", "doorbuys_opened", doorbuys_opened );
    save_write( type, "save", "players", var_6787895101874fb4, "scoreboard", "revives", revives_completed );
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Total score: " + score_earned + " Kills: " + kills + " Critical kills: " + critical_kills + " Doorbuys opened: " + doorbuys_opened + " Revives: " + revives_completed );
    
    if ( isdefined( self.var_b02f6e7abbbc8a84 ) )
    {
        assert( -1 );
        
        for ( index = 0; index < 3 ; index++ )
        {
            slot = index + 1;
            
            if ( isdefined( self.var_b02f6e7abbbc8a84[ slot ] ) && self.var_b02f6e7abbbc8a84[ slot ] != "none" )
            {
                var_66cc4d3d21a0ce0d = self.var_b02f6e7abbbc8a84[ slot ];
                is_enabled = bgb::is_enabled( var_66cc4d3d21a0ce0d );
                is_active = bgb::is_active( var_66cc4d3d21a0ce0d );
                time_left = 0;
                is_free = 0;
                
                if ( isdefined( self.var_4317de3baf10e68d ) && self.var_4317de3baf10e68d[ 0 ] === var_66cc4d3d21a0ce0d )
                {
                    is_free = 1;
                }
                
                if ( is_enabled || is_active )
                {
                    time_left = function_32005e96099d4056( self, var_6787895101874fb4, var_66cc4d3d21a0ce0d );
                    
                    if ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 == "activated" && var_66cc4d3d21a0ce0d == "support_group" )
                    {
                        is_enabled = 1;
                    }
                }
                
                save_write( type, "save", "players", var_6787895101874fb4, "gums", index, "ref", var_66cc4d3d21a0ce0d );
                save_write( type, "save", "players", var_6787895101874fb4, "gums", index, "is_enabled", is_enabled );
                save_write( type, "save", "players", var_6787895101874fb4, "gums", index, "time_left", time_left );
                save_write( type, "save", "players", var_6787895101874fb4, "gums", index, "is_free", is_free );
                logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " BGB: " + var_66cc4d3d21a0ce0d );
                continue;
            }
            
            save_write( type, "save", "players", var_6787895101874fb4, "gums", index, "ref", "" );
        }
    }
    
    killstreak = item_killstreak::get_current_killstreak();
    
    if ( isdefined( killstreak ) && isdefined( killstreak.ref ) && killstreak.ref != "" && !bgb::is_active( "support_group" ) )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "support_killstreak", killstreak.ref );
        save_write( type, "save", "players", var_6787895101874fb4, "support_killstreak_count", killstreak.count );
        logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Killstreak: " + killstreak.ref );
    }
    else
    {
        save_write( type, "save", "players", var_6787895101874fb4, "support_killstreak", "none" );
    }
    
    if ( bgb::is_active( "support_group" ) && isdefined( self.bgb_support_group_killstreak_save ) )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "bgb_support_group_killstreak", self.bgb_support_group_killstreak_save );
        logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " BGB Support Group Killstreak: " + self.bgb_support_group_killstreak_save );
    }
    else
    {
        save_write( type, "save", "players", var_6787895101874fb4, "bgb_support_group_killstreak", "none" );
    }
    
    zone_name = "";
    zone = zone_manager::get_current_zone();
    
    if ( isdefined( zone ) && isdefined( zone.zone_name ) )
    {
        zone_name = zone.zone_name;
    }
    
    save_write( type, "save", "players", var_6787895101874fb4, "spawn_zone", zone_name );
    var_20687d4d598bd660 = self.var_6f9595e5de90c2aa ?? 0;
    var_dfa2da77bb2d3266 = self.var_84cde01ffd2cb360 ?? 0;
    var_1def767665278361 = self.w_mod_savior_uses ?? 0;
    var_6e6e57f1080691df = self.scarab_ee_mask_id ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "num_dying_wish", var_20687d4d598bd660 );
    save_write( type, "save", "players", var_6787895101874fb4, "num_last_chance", var_dfa2da77bb2d3266 );
    save_write( type, "save", "players", var_6787895101874fb4, "w_mod_savior_uses", var_1def767665278361 );
    
    if ( var_6e6e57f1080691df )
    {
        save_write( type, "save", "players", var_6787895101874fb4, "scarab_ee_mask_id", var_6e6e57f1080691df );
    }
    
    has_gold_armor = self.var_a1faa64d8c07872e ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "has_gold_armor", has_gold_armor );
    first_time_getting_mule_kick = self.var_b35729a9ecacd84f ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "first_time_getting_mule_kick", first_time_getting_mule_kick );
    allow_instant_bgb_pack_switching = self.allow_instant_bgb_pack_switching ?? 0;
    save_write( type, "save", "players", var_6787895101874fb4, "allow_instant_bgb_pack_switching", allow_instant_bgb_pack_switching );
    var_efd960f3c3cf6f19 = self.pers[ "telemetry" ].var_efd960f3c3cf6f19;
    eliminations = ( self.pers[ "telemetry" ].eliminations ?? 0 ) + ( var_efd960f3c3cf6f19.eliminations ?? 0 );
    mq_completed = self.pers[ "telemetry" ].mq_completed ?? 0;
    mq_progress_time_ms = 0;
    
    if ( !mq_completed )
    {
        mq_progress_time_ms = var_efd960f3c3cf6f19.mq_progress_time_ms ?? 0;
        start_time_ms = game[ "telemetry" ].start_time_ms ?? 0;
        mq_progress_time_ms += gettime() - start_time_ms;
    }
    else
    {
        mq_progress_time_ms = self.pers[ "telemetry" ].mq_complete_time_ms ?? 0;
    }
    
    utc_connect_time = self.pers[ "telemetry" ].utc_connect_time_s ?? 0;
    time_played = getsystemtime() - utc_connect_time + ( var_efd960f3c3cf6f19.prev_time_played ?? 0 );
    special_elims = ( self.pers[ "telemetry" ].special_eliminations ?? 0 ) + ( var_efd960f3c3cf6f19.special_eliminations ?? 0 );
    elite_elims = ( self.pers[ "telemetry" ].elite_eliminations ?? 0 ) + ( var_efd960f3c3cf6f19.elite_eliminations ?? 0 );
    boss_elims = ( self.pers[ "telemetry" ].boss_eliminations ?? 0 ) + ( var_efd960f3c3cf6f19.boss_eliminations ?? 0 );
    pap_elims = ( self.pers[ "telemetry" ].pap_weapon_elims ?? 0 ) + ( var_efd960f3c3cf6f19.pap_weapon_elims ?? 0 );
    legendary_elims = ( self.pers[ "telemetry" ].legendary_weapon_elims ?? 0 ) + ( var_efd960f3c3cf6f19.legendary_weapon_elims ?? 0 );
    one_shot_kills = ( self.pers[ "telemetry" ].one_shot_kills ?? 0 ) + ( var_efd960f3c3cf6f19.one_shot_kills ?? 0 );
    match_id = var_efd960f3c3cf6f19.match_id ?? getonlinematchid();
    solo_paused_time_ms = function_e3cd85eead6e1fc7() + ( var_efd960f3c3cf6f19.solo_paused_time_ms ?? 0 );
    save_write( type, "save", "players", var_6787895101874fb4, "eliminations", eliminations );
    save_write( type, "save", "players", var_6787895101874fb4, "mq_progress_time_ms", mq_progress_time_ms );
    save_write( type, "save", "players", var_6787895101874fb4, "mq_completed", mq_completed );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "time_played", time_played );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "special_elims", special_elims );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "elite_elims", elite_elims );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "boss_elims", boss_elims );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "pap_elims", pap_elims );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "legendary_elims", legendary_elims );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "one_shot_kills", one_shot_kills );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "match_id", match_id );
    save_write( type, "save", "players", var_6787895101874fb4, "telemetry", "solo_paused_time_ms", solo_paused_time_ms );
    challenges_states = [ istrue( self.var_b8e6a8c9bfecb39 ), istrue( self.var_1a750b53551a95c3 ), istrue( self.var_8ba28984e9b77eb8 ), istrue( self.var_bf28468f33958718 ), istrue( level.any_doorbuy_opened ), istrue( self.var_998090d04c25480b ), level.var_cea2fe0ea477724a ?? 0, istrue( self.was_frozen ), istrue( self.b_used_ammo_cache ), istrue( self.b_used_perk_machine ), istrue( self.var_b728f74baa7e0b47 ) ];
    assert( challenges_states.size == 11, "<dev string:x2e7>" );
    
    foreach ( index, value in challenges_states )
    {
        if ( index < 11 )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "challenges_states", index, value );
        }
    }
    
    relics_states = [ istrue( self.var_3df52cdafd7c3a3f ), istrue( level.var_1241723eaf9538b ), istrue( level.var_2d551b2a23bf56fb ), istrue( level.var_dd5a72f42d9c38e ), istrue( level.var_ae96560687cb440 ), istrue( self.relic_damage ), istrue( level.var_23f0535ecbba9ff3 ), istrue( level.var_1f33183f27882b21 ) ];
    assert( relics_states.size == 8, "<dev string:x35a>" );
    
    foreach ( index, value in relics_states )
    {
        if ( index < 8 )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "relics_states", index, value );
        }
    }
    
    super_ee_states = [ istrue( self.var_e8b776e9698cb857 ) ];
    assert( super_ee_states.size == 1, "<dev string:x3c9>" );
    
    foreach ( index, value in super_ee_states )
    {
        if ( index < 1 )
        {
            save_write( type, "save", "players", var_6787895101874fb4, "super_ee_states", index, value );
        }
    }
    
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Time played: " + time_played + " Elims: " + eliminations + " Special elims: " + special_elims + " Elite elims: " + elite_elims + " Boss elims: " + boss_elims + " PAP elims: " + pap_elims + " Legendary elims: " + legendary_elims + " One shot kills: " + one_shot_kills + " MQ progress/complete time: " + mq_progress_time_ms );
    params = spawnstruct();
    callback::callback( #"hash_4ee55d1a7046ff82", params );
    logstring( "ZM Save: " + "Player " + self getentitynumber() + " save complete" );
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x585e49c9, Offset: 0x70eb
// Size: 0x412
function private overwrite_player_state( var_6787895101874fb4 )
{
    assert( var_6787895101874fb4 >= 0 && var_6787895101874fb4 < 4 );
    logstring( "ZM Save: " + "Player " + self getentitynumber() + " overwrite save begin" );
    self_revive_count = laststand::function_7072b516e6cffb7c();
    self_revive_used = self.var_aecc486f34e4dd66 ?? 0;
    self_revive_crafted = self.var_3b2b912816c110b4 ?? 0;
    last_stand_count = self.last_stand_count ?? 0;
    zmsavewrite( "save", "players", var_6787895101874fb4, "self_revive_count", self_revive_count );
    zmsavewrite( "save", "players", var_6787895101874fb4, "self_revive_used", self_revive_used );
    zmsavewrite( "save", "players", var_6787895101874fb4, "self_revive_crafted", self_revive_crafted );
    zmsavewrite( "save", "players", var_6787895101874fb4, "downs", last_stand_count );
    var_20687d4d598bd660 = self.var_6f9595e5de90c2aa ?? 0;
    var_dfa2da77bb2d3266 = self.var_84cde01ffd2cb360 ?? 0;
    var_1def767665278361 = self.w_mod_savior_uses ?? 0;
    var_6e6e57f1080691df = self.scarab_ee_mask_id ?? 0;
    zmsavewrite( "save", "players", var_6787895101874fb4, "num_dying_wish", var_20687d4d598bd660 );
    zmsavewrite( "save", "players", var_6787895101874fb4, "num_last_chance", var_dfa2da77bb2d3266 );
    zmsavewrite( "save", "players", var_6787895101874fb4, "w_mod_savior_uses", var_1def767665278361 );
    
    if ( var_6e6e57f1080691df )
    {
        zmsavewrite( "save", "players", var_6787895101874fb4, "scarab_ee_mask_id", var_6e6e57f1080691df );
    }
    
    logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " Self Revive Count: " + self_revive_count + " Used: " + self_revive_used + " Crafted: " + self_revive_crafted + " Downs Count: " + last_stand_count );
    allow_instant_bgb_pack_switching = self.allow_instant_bgb_pack_switching ?? 0;
    zmsavewrite( "save", "players", var_6787895101874fb4, "allow_instant_bgb_pack_switching", allow_instant_bgb_pack_switching );
    
    if ( isdefined( self.var_b02f6e7abbbc8a84 ) )
    {
        assert( -1 );
        
        for ( index = 0; index < 3 ; index++ )
        {
            slot = index + 1;
            
            if ( isdefined( self.var_b02f6e7abbbc8a84[ slot ] ) && self.var_b02f6e7abbbc8a84[ slot ] != "none" )
            {
                var_66cc4d3d21a0ce0d = self.var_b02f6e7abbbc8a84[ slot ];
                is_enabled = bgb::is_enabled( var_66cc4d3d21a0ce0d );
                is_active = bgb::is_active( var_66cc4d3d21a0ce0d );
                time_left = 0;
                is_free = 0;
                
                if ( isdefined( self.var_4317de3baf10e68d ) && self.var_4317de3baf10e68d[ 0 ] === var_66cc4d3d21a0ce0d )
                {
                    is_free = 1;
                }
                
                if ( is_enabled || is_active )
                {
                    time_left = function_32005e96099d4056( self, var_6787895101874fb4, var_66cc4d3d21a0ce0d );
                    
                    if ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 == "activated" && var_66cc4d3d21a0ce0d == "support_group" )
                    {
                        is_enabled = 1;
                    }
                }
                
                zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "ref", var_66cc4d3d21a0ce0d );
                zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "is_enabled", is_enabled );
                zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "time_left", time_left );
                zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "is_free", is_free );
                logstring( "ZM Save: " + "Wrote: Player Index: " + var_6787895101874fb4 + " BGB: " + var_66cc4d3d21a0ce0d );
                continue;
            }
            
            zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "ref", "" );
        }
    }
    
    logstring( "ZM Save: " + "Player " + self getentitynumber() + " overwrite save complete" );
}

// Namespace zm_save
// Params 3
// Checksum 0xb8abfe6c, Offset: 0x7505
// Size: 0x254, Type: bool
function commit_session( save_type, overwrite_player_state = 1, pause_timer_expired = 0 )
{
    assert( isdefined( save_type ) );
    
    if ( !zmsaveisinitialized() )
    {
        logstring( "ZM Save: " + "Failed to commit/push save, save was not initialized." );
        return false;
    }
    
    if ( save_type == 1 )
    {
        if ( !is_autosave_enabled() || !isdedicatedserver() )
        {
            logstring( "ZM Save: " + "Failed to commit/push autosave, autosave is not enabled." );
            return false;
        }
    }
    
    if ( overwrite_player_state && isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_f09d95abf79cd6b6 ) && player.sessionstate == "playing" && isalive( player ) )
            {
                player overwrite_player_state( player.var_f09d95abf79cd6b6 );
            }
            
            player.var_f09d95abf79cd6b6 = undefined;
        }
    }
    
    zmsavewrite( "disconnect_save", istrue( level.zm_save_info.disconnect_save ) );
    
    if ( isdedicatedserver() )
    {
        if ( zmsavepush( save_type ) )
        {
            logstring( "ZM Save: " + "Commit/Push completed successfully" );
            
            if ( save_type == 1 )
            {
                level.zm_save_info.var_f5f3283763443139 = 1;
                
                foreach ( player in level.players )
                {
                    player thread set_autosave_stat( 1, pause_timer_expired );
                }
            }
            
            return true;
        }
    }
    else
    {
        /#
            if ( zmsavecommit() )
            {
                logstring( "<dev string:x43b>" + "<dev string:x445>" );
                return true;
            }
        #/
    }
    
    logstring( "ZM Save: " + "Failed to commit/push save." );
    return false;
}

// Namespace zm_save
// Params 1
// Checksum 0xaa9c7735, Offset: 0x7762
// Size: 0x1c1, Type: bool
function save_session( is_round_progressing )
{
    assert( isdefined( level.players ) );
    var_dc4fa75655c6106d = [];
    
    foreach ( player in level.players )
    {
        if ( function_7bb71291321c28de() )
        {
            var_dc4fa75655c6106d[ var_dc4fa75655c6106d.size ] = player;
            continue;
        }
        
        if ( player.sessionstate == "playing" && isalive( player ) )
        {
            var_dc4fa75655c6106d[ var_dc4fa75655c6106d.size ] = player;
        }
    }
    
    if ( var_dc4fa75655c6106d.size == 0 || var_dc4fa75655c6106d.size > 4 )
    {
        logstring( "ZM Save: " + "Incorrect number of players (" + var_dc4fa75655c6106d.size + ") for save system, aborting" );
        return false;
    }
    
    playlist_id = getplaylistid();
    
    if ( !zmsaveinit( playlist_id, var_dc4fa75655c6106d ) )
    {
        logstring( "ZM Save: " + "Failed to initialize save, aborting" );
        return false;
    }
    
    logstring( "ZM Save: " + "Save initialization complete" );
    save_level_state( is_round_progressing );
    
    foreach ( index, player in var_dc4fa75655c6106d )
    {
        player save_player_state( 1, index );
    }
    
    logstring( "ZM Save: " + "Save session completed successfully" );
    return true;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xd07e71ab, Offset: 0x792c
// Size: 0x14e
function private menu_save_and_end_game( val )
{
    if ( level.var_838b34ec9c6565aa )
    {
        return;
    }
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    if ( !commit_session( 0 ) )
    {
        foreach ( player in level.players )
        {
            player openmenu( "ZMSaveFailed" );
            player hud_message::showerrormessage( %"SAVE_LOAD/SAVE_FAILED" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"hash_be8c1e50ae7da3ff", 0 );
    }
    
    level thread gamelogic_zm::forceend( val );
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xa6879894, Offset: 0x7a82
// Size: 0x17
function private function_a7e1154075b4b73f( val )
{
    level.var_838b34ec9c6565aa = 1;
}

// Namespace zm_save
// Params 0
// Checksum 0x9c8f32c3, Offset: 0x7aa1
// Size: 0x17
function function_1f44a48caae2acbf()
{
    if ( function_fcccc3d2a616b1c7() )
    {
        utility::flag_wait( "zm_save_level_restore_complete" );
    }
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x666b252b, Offset: 0x7ac0
// Size: 0xf6
function private function_1d3eee82fb090fbc( magic_box_list )
{
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    saved_zone_name = zmsaveread( "save", "magic_box_state", "current_zone" );
    
    if ( !isdefined( saved_zone_name ) || saved_zone_name == "" )
    {
        return;
    }
    
    foreach ( var_1fb242bbb1a67fdf in magic_box_list )
    {
        nav_origin = getclosestpointonnavmesh( var_1fb242bbb1a67fdf.origin );
        
        if ( isdefined( nav_origin ) )
        {
            box_zone = zone_manager::function_90e5c3e2272b0130( nav_origin );
            
            if ( box_zone.zone_name == saved_zone_name )
            {
                return var_1fb242bbb1a67fdf;
            }
        }
    }
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x466de223, Offset: 0x7bbf
// Size: 0x66
function private is_chompy_activated( chompy )
{
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    for ( index = 0; index < 10 ; index++ )
    {
        var_b6d34398668103b1 = zmsaveread( "save", "chompy_state", index, "current_zone" );
        
        if ( chompy.zone == var_b6d34398668103b1 )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x64f0256c, Offset: 0x7c2e
// Size: 0xc9
function private function_7c32d54fe0ba8adb()
{
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    barnacles_restore = [];
    
    for ( index = 0; index < 60 ; index++ )
    {
        save_index = zmsaveread( "save", "barnacle", index, "index" );
        var_6406b411db6be5c4 = zmsaveread( "save", "barnacle", index, "alive" );
        respawn_round = zmsaveread( "save", "barnacle", index, "barnacle_respawn_round" );
        
        if ( save_index != 0 )
        {
            restore_struct = spawnstruct();
            restore_struct.var_6406b411db6be5c4 = var_6406b411db6be5c4;
            restore_struct.respawn_round = respawn_round;
            barnacles_restore[ save_index ] = restore_struct;
        }
    }
    
    return barnacles_restore;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0xeb72efe1, Offset: 0x7d00
// Size: 0x1b
function private function_786b3b5398819fe5()
{
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    return zmsaveread( "save", "og_barnacle_spawned_num" );
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x82a0cf57, Offset: 0x7d24
// Size: 0x5d
function private get_melted_mannequins()
{
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    melted_mannequins = [];
    
    for ( i = 0; i < 16 ; i++ )
    {
        var_718f5e1ef4ef7bc6 = zmsaveread( "save", "melted_mannequins", i );
        
        if ( var_718f5e1ef4ef7bc6 != 0 )
        {
            melted_mannequins[ melted_mannequins.size ] = var_718f5e1ef4ef7bc6;
        }
    }
    
    return melted_mannequins;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xfa2a1575, Offset: 0x7d8a
// Size: 0x10e
function private function_b2cda415fe32c09d( start_rarity )
{
    assert( isdefined( start_rarity ) );
    
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    saved_round_number = zmsaveread( "save", "round_num" );
    assert( saved_round_number >= 1 );
    var_5da8bec91e1b0eb3 = start_rarity;
    max_round_number = minint( 50, saved_round_number );
    round_number = 5;
    
    while ( round_number <= max_round_number )
    {
        if ( var_5da8bec91e1b0eb3 == "orange" )
        {
            break;
        }
        
        if ( namespace_a2d5c07a0ea12ae::function_9671f0078ceb9f5d( var_5da8bec91e1b0eb3, round_number ) )
        {
            switch ( var_5da8bec91e1b0eb3 )
            {
                case #"hash_1393412d7401c646":
                    var_5da8bec91e1b0eb3 = "green";
                    break;
                case #"hash_883ff07272b4f9c":
                    var_5da8bec91e1b0eb3 = "blue";
                    break;
                case #"hash_778bb52ecd08072d":
                    var_5da8bec91e1b0eb3 = "purple";
                    break;
                case #"hash_598a30e44f53045f":
                default:
                    var_5da8bec91e1b0eb3 = "orange";
                    break;
            }
        }
        
        round_number += 5;
    }
    
    return var_5da8bec91e1b0eb3;
}

// Namespace zm_save
// Params 0
// Checksum 0x6420afb1, Offset: 0x7ea1
// Size: 0xb9
function get_saved_player_index()
{
    assert( function_fcccc3d2a616b1c7() );
    assert( isdefined( level.zm_save_info ) );
    xuid = function_fffbd405b1911268( self getxuid() );
    
    foreach ( index, save_xuid in level.zm_save_info.var_f8acb750331e3c9 )
    {
        if ( save_xuid == xuid )
        {
            return index;
        }
    }
}

// Namespace zm_save
// Params 0
// Checksum 0x37b3cba, Offset: 0x7f62
// Size: 0x7e
function get_saved_spawn_zone()
{
    assert( function_fcccc3d2a616b1c7() );
    var_6787895101874fb4 = get_saved_player_index();
    
    if ( isdefined( var_6787895101874fb4 ) )
    {
        zone_name = zmsaveread( "save", "players", var_6787895101874fb4, "spawn_zone" );
        
        if ( zone_name != "" )
        {
            if ( isdefined( level.var_e41b7c5a0479a4f0 ) )
            {
                override_zone_name = [[ level.var_e41b7c5a0479a4f0 ]]( zone_name );
            }
            
            return ( override_zone_name ?? zone_name );
        }
    }
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x633a5abd, Offset: 0x7fe8
// Size: 0x5d
function private get_persistent_random_seed()
{
    if ( isdefined( level.saved_seed ) )
    {
        return level.saved_seed;
    }
    
    seed = randomint( 100 );
    
    if ( function_fcccc3d2a616b1c7() )
    {
        function_1f44a48caae2acbf();
        seed = zmsaveread( "save", "seed" ) ?? seed;
    }
    
    level.saved_seed = seed;
    return seed;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x2b4c57b2, Offset: 0x804e
// Size: 0x2c
function private get_saved_timeline()
{
    assert( function_fcccc3d2a616b1c7() );
    timeline = zmsaveread( "save", "timetravel_timeline" );
    return timeline;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0xe0854954, Offset: 0x8083
// Size: 0x2c
function private get_timewarps_initialized()
{
    assert( function_fcccc3d2a616b1c7() );
    timewarps_init = zmsaveread( "save", "timewarps_init" );
    return timewarps_init;
}

// Namespace zm_save
// Params 0
// Checksum 0xc6b6ac8e, Offset: 0x80b8
// Size: 0xbd
function function_3df2221f7b1fd5a4()
{
    assert( function_fcccc3d2a616b1c7() );
    var_6787895101874fb4 = get_saved_player_index();
    
    if ( isdefined( var_6787895101874fb4 ) )
    {
        self_revive_info = spawnstruct();
        self_revive_info.count = zmsaveread( "save", "players", var_6787895101874fb4, "self_revive_count" );
        self_revive_info.used = zmsaveread( "save", "players", var_6787895101874fb4, "self_revive_used" );
        self_revive_info.var_6f806f859e675821 = zmsaveread( "save", "players", var_6787895101874fb4, "self_revive_crafted" );
        self_revive_info.last_stand_count = zmsaveread( "save", "players", var_6787895101874fb4, "downs" );
        return self_revive_info;
    }
}

// Namespace zm_save
// Params 0
// Checksum 0x92686c71, Offset: 0x817d
// Size: 0x80
function function_c3331894f472199b()
{
    assert( function_fcccc3d2a616b1c7() );
    var_6787895101874fb4 = get_saved_player_index();
    
    if ( isdefined( var_6787895101874fb4 ) )
    {
        armor_plates = zmsaveread( "save", "players", var_6787895101874fb4, "armor_plates" );
        armor_level = zmsaveread( "save", "players", var_6787895101874fb4, "armor_level" );
        return [ armor_plates, armor_level ];
    }
    
    return [ 0, 1 ];
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x4de0a920, Offset: 0x8206
// Size: 0x10e
function private function_4953cb22cf375cc3( saved_quests )
{
    foreach ( name, quest in level.zm_quests )
    {
        if ( isdefined( saved_quests[ name ] ) )
        {
            foreach ( key, value in saved_quests[ name ].save_kvps )
            {
                zm_quest::function_4eefe6de31f5ddab( name, key, value );
            }
        }
    }
    
    utility::flag_set( "zm_save_level_restore_keys_complete" );
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0xfdebfbf8, Offset: 0x831c
// Size: 0x3d0
function private restore_quest( quest, var_9a75b374f6cd74f3 )
{
    quest.n_respawn_round = var_9a75b374f6cd74f3.respawn_round;
    
    if ( var_9a75b374f6cd74f3.completed )
    {
        foreach ( step in quest.steps )
        {
            zm_quest::function_e65609834444650c( step, 1 );
        }
        
        if ( !quest.started )
        {
            thread zm_quest::start_quest( quest.ref );
        }
        
        return;
    }
    
    step_list = quest.steps;
    
    foreach ( path_step in var_9a75b374f6cd74f3.path )
    {
        active_step = undefined;
        
        foreach ( step in step_list )
        {
            if ( step.ref == path_step )
            {
                step_list = step.steps;
                active_step = step;
                break;
            }
            
            zm_quest::function_e65609834444650c( step, 1 );
        }
        
        if ( !isdefined( active_step ) )
        {
            var_d6244defeb4b4644 = getxhashhexname( quest.ref );
            
            /#
                var_d6244defeb4b4644 = getxhashsourcename( quest.ref );
            #/
            
            logstring( "ZM Save: " + "Could not find active path when restoring quest: " + var_d6244defeb4b4644 );
            break;
        }
    }
    
    if ( isdefined( active_step ) )
    {
        active_step.current_progress = var_9a75b374f6cd74f3.active_step_progress;
        
        if ( active_step.steps.size > 0 && var_9a75b374f6cd74f3.var_f78e0493a133deec.size > 0 )
        {
            foreach ( var_ce4235f0cd5bf117 in var_9a75b374f6cd74f3.var_f78e0493a133deec )
            {
                foreach ( var_ca114aa12dee1e8e in active_step.steps )
                {
                    if ( var_ce4235f0cd5bf117.name == var_ca114aa12dee1e8e.ref )
                    {
                        var_ca114aa12dee1e8e.current_progress = var_ce4235f0cd5bf117.progress;
                        
                        if ( var_ce4235f0cd5bf117.completed )
                        {
                            zm_quest::function_e65609834444650c( var_ca114aa12dee1e8e, 1 );
                        }
                        
                        break;
                    }
                }
            }
        }
    }
    
    if ( !quest.started )
    {
        thread zm_quest::start_quest( quest.ref );
    }
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x5aa2f84b, Offset: 0x86f4
// Size: 0xdab
function private restore_level_state()
{
    logstring( "ZM Save: " + "Level restore begin" );
    setomnvar( "ui_was_savegame_loaded_this_round", 1 );
    round_number = zmsaveread( "save", "round_num" );
    assert( round_number >= 1 );
    zm_round_logic::set_rb_round_number( round_number );
    logstring( "ZM Save: " + "Read: Round number: " + round_number );
    round_cap = zmsaveread( "save", "round_cap" );
    assert( round_cap >= 1 );
    zm_quest::update_round_cap( round_cap, 1, 0 );
    logstring( "ZM Save: " + "Read: Round cap: " + round_cap );
    
    if ( round_number > 1 )
    {
        min_elite_round_appearance = zmsaveread( "save", "min_elite_round_appearance" );
        zm_round_spawning::function_8c0a8afe0779b82a( 1, round_number, min_elite_round_appearance );
        zm_round_spawning::function_72b3db5fc2b7d929( round_number );
    }
    
    rampage_inducer_state = istrue( zmsaveread( "save", "rampage_inducer_activated" ) );
    
    if ( rampage_inducer_state )
    {
        level thread zm_round_accelerant::set_round_accelerant( 1 );
    }
    
    logstring( "ZM Save: " + "Read: Rampage Inducer: " + rampage_inducer_state );
    num_global_perks_purchased = zmsaveread( "save", "num_global_perks_purchased" ) ?? 0;
    level.var_af8e5ce115d7696f = num_global_perks_purchased;
    level.total_purchased_perks = num_global_perks_purchased;
    level.var_865fa84b8f7cc220 = zmsaveread( "save", "perk_threshold_reached" );
    logstring( "ZM Save: " + "Read: Perk purchase threshold: " + istrue( level.var_865fa84b8f7cc220 ) );
    power_flags = [];
    
    for ( index = 0; index < 4 ; index++ )
    {
        flag = zmsaveread( "save", "enabled_power_switches", index );
        
        if ( flag == "" )
        {
            break;
        }
        
        power_flags[ power_flags.size ] = flag;
    }
    
    if ( power_flags.size > 0 )
    {
        foreach ( var_c0a89f990cafaa0c in level.electric_power_switches )
        {
            if ( isdefined( var_c0a89f990cafaa0c ) && isdefined( var_c0a89f990cafaa0c.interact ) )
            {
                var_41a7b79236ee0d86 = var_c0a89f990cafaa0c.script_noteworthy;
                flag = var_c0a89f990cafaa0c.script_flag_set;
                
                if ( isdefined( var_41a7b79236ee0d86 ) )
                {
                    flag += var_41a7b79236ee0d86;
                }
                
                if ( arraycontains( power_flags, flag ) )
                {
                    var_c0a89f990cafaa0c.interact electric_power_switch::function_e17b8c37ab7db9f2();
                    logstring( "ZM Save: " + "Restored: Power switch: " + flag );
                }
            }
        }
    }
    
    door_flags = [];
    
    for ( index = 0; index < 48 ; index++ )
    {
        flag = zmsaveread( "save", "enabled_doors", index );
        
        if ( flag == "" )
        {
            break;
        }
        
        door_flags[ door_flags.size ] = flag;
    }
    
    if ( door_flags.size > 0 )
    {
        foreach ( doorbuy in level.a_s_doorbuys )
        {
            if ( isdefined( doorbuy ) && isdefined( doorbuy.script_flag_set ) && isdefined( doorbuy.interact ) )
            {
                var_9f005c38ce614ca8 = strtok( doorbuy.script_flag_set, ", " );
                
                foreach ( flag in var_9f005c38ce614ca8 )
                {
                    if ( arraycontains( door_flags, flag ) )
                    {
                        doorbuy.interact thread doorbuy::doorbuy_used( undefined, undefined, level.gamemodebundle.var_fa2cddd0dacd4898 );
                        logstring( "ZM Save: " + "Restored: Door: " + flag );
                        break;
                    }
                }
            }
        }
    }
    
    var_9070b9bb8b0c3a6c = [];
    
    for ( index = 0; index < 8 ; index++ )
    {
        subclass_hash = zmsaveread( "save", "elite_zombies", index, "subclass" );
        
        if ( subclass_hash == #"" )
        {
            break;
        }
        
        var_d0c6b7fe2f128d03 = spawnstruct();
        var_d0c6b7fe2f128d03.aitype = function_b3d26e56d504237f( subclass_hash );
        
        if ( isdefined( var_d0c6b7fe2f128d03.aitype ) )
        {
            saved_health = zmsaveread( "save", "elite_zombies", index, "health" );
            
            if ( saved_health > 0 )
            {
                saved_max_health = zmsaveread( "save", "elite_zombies", index, "max_health" );
                assert( saved_max_health >= saved_health );
                var_d0c6b7fe2f128d03.savedhealth = saved_health;
                var_d0c6b7fe2f128d03.savedmaxhealth = saved_max_health;
            }
            
            var_d0c6b7fe2f128d03.metabones = [];
            
            for ( metabone_index = 0; metabone_index < 14 ; metabone_index++ )
            {
                name = zmsaveread( "save", "elite_zombies", index, "metabones", metabone_index, "name" );
                
                if ( name == #"" )
                {
                    break;
                }
                
                metabone = spawnstruct();
                metabone.name = name;
                metabone.is_active = zmsaveread( "save", "elite_zombies", index, "metabones", metabone_index, "is_active" );
                metabone.state_index = zmsaveread( "save", "elite_zombies", index, "metabones", metabone_index, "state_index" );
                var_d0c6b7fe2f128d03.metabones[ var_d0c6b7fe2f128d03.metabones.size ] = metabone;
            }
            
            zm_cleanup_manager::function_8918c1cebb25919e( var_d0c6b7fe2f128d03, 1 );
        }
    }
    
    level.var_410b736ba41817c2 = zmsaveread( "save", "magic_box_state", "num_used" );
    level.var_1c98168ff9213851 = zmsaveread( "save", "magic_box_state", "num_moved" );
    logstring( "ZM Save: " + "Restored: Magic box" );
    saved_quests = [];
    
    for ( index = 0; index < 30 ; index++ )
    {
        var_544dc6c47711ac4a = zmsaveread( "save", "quests", index, "name" );
        
        if ( var_544dc6c47711ac4a == #"" )
        {
            break;
        }
        
        completed = zmsaveread( "save", "quests", index, "completed" );
        path = [];
        
        for ( var_1f42fb5079240912 = 0; var_1f42fb5079240912 < 4 ; var_1f42fb5079240912++ )
        {
            path_step = zmsaveread( "save", "quests", index, "path", var_1f42fb5079240912 );
            
            if ( path_step == #"" )
            {
                break;
            }
            
            path[ path.size ] = path_step;
        }
        
        active_step_progress = zmsaveread( "save", "quests", index, "active_step_progress" );
        var_f78e0493a133deec = [];
        
        for ( substep_index = 0; substep_index < 10 ; substep_index++ )
        {
            name = zmsaveread( "save", "quests", index, "substeps", substep_index, "name" );
            
            if ( name == #"" )
            {
                break;
            }
            
            var_c8880ea9156c6384 = zmsaveread( "save", "quests", index, "substeps", substep_index, "completed" );
            progress = zmsaveread( "save", "quests", index, "substeps", substep_index, "progress" );
            var_ce4235f0cd5bf117 = { #progress:progress, #completed:var_c8880ea9156c6384, #name:name };
            var_f78e0493a133deec[ var_f78e0493a133deec.size ] = var_ce4235f0cd5bf117;
        }
        
        save_kvps = [];
        
        for ( var_2a88723414227592 = 0; var_2a88723414227592 < 16 ; var_2a88723414227592++ )
        {
            key = zmsaveread( "save", "quests", index, "state_keys", var_2a88723414227592 );
            value = zmsaveread( "save", "quests", index, "state_values", var_2a88723414227592 );
            
            if ( key == #"" )
            {
                break;
            }
            
            save_kvps[ key ] = value;
        }
        
        respawn_round = zmsaveread( "save", "quests", index, "respawn_round" );
        
        if ( respawn_round == 0 )
        {
            respawn_round = undefined;
        }
        
        quest_struct = { #respawn_round:respawn_round, #save_kvps:save_kvps, #var_f78e0493a133deec:var_f78e0493a133deec, #active_step_progress:active_step_progress, #path:path, #completed:completed };
        saved_quests[ var_544dc6c47711ac4a ] = quest_struct;
    }
    
    start_time = gettime();
    timeout = 0;
    
    foreach ( var_544dc6c47711ac4a, quest_struct in saved_quests )
    {
        while ( true )
        {
            array_keys = getarraykeys( level.zm_quests );
            
            if ( arraycontains( array_keys, var_544dc6c47711ac4a ) )
            {
                break;
            }
            
            waitframe();
            current_time = gettime();
            
            if ( current_time - start_time > 3000 )
            {
                timeout = 1;
                break;
            }
        }
        
        if ( timeout )
        {
            logstring( "ZM Save: " + "Hit timeout while waiting for quests to initialize. Quest state restore will be incomplete." );
            break;
        }
    }
    
    if ( isdefined( level.scarab_ee_masks ) )
    {
        if ( zmsaveread( "save", "safehouse_ee_mask" ) )
        {
            foreach ( pedestal in level.mask_pedestals )
            {
                if ( pedestal.script_noteworthy == "zmloot_scarab_hose_ee_mask" )
                {
                    level.var_cecd1497de62383d = pedestal function_8e19a65a0c8a135( %"hash_23072e51581351dc", "zmloot_scarab_hose_ee_mask" );
                }
            }
        }
        
        if ( zmsaveread( "save", "twins_ee_mask" ) )
        {
            foreach ( pedestal in level.mask_pedestals )
            {
                if ( pedestal.script_noteworthy == "zmloot_scarab_twins_ee_mask" )
                {
                    level.var_a22ccc3239223459 = pedestal function_8e19a65a0c8a135( %"hash_6ddbae43b1c907d8", "zmloot_scarab_twins_ee_mask" );
                    break;
                }
            }
        }
        
        if ( zmsaveread( "save", "grapple_challenge_ee_mask" ) )
        {
            foreach ( pedestal in level.mask_pedestals )
            {
                if ( pedestal.script_noteworthy == "zmloot_scarab_grp_ee_mask" )
                {
                    level.var_b30347bb441cd8b = pedestal function_8e19a65a0c8a135( %"hash_47c51773059c4144", "zmloot_scarab_grp_ee_mask" );
                    break;
                }
            }
        }
        
        if ( zmsaveread( "save", "spider_ride_ee_mask" ) )
        {
            foreach ( pedestal in level.mask_pedestals )
            {
                if ( pedestal.script_noteworthy == "zmloot_scarab_loom_ride_ee_mask" )
                {
                    level.var_f8f4e3b9b8d160b8 = pedestal function_8e19a65a0c8a135( %"hash_505813c990ca9a5b", "zmloot_scarab_loom_ride_ee_mask" );
                    break;
                }
            }
        }
    }
    
    waitframe();
    function_4953cb22cf375cc3( saved_quests );
    
    foreach ( name, quest in level.zm_quests )
    {
        if ( isdefined( saved_quests[ name ] ) )
        {
            restore_quest( quest, saved_quests[ name ] );
            namestring = getxhashhexname( name );
            
            /#
                namestring = getxhashsourcename( name );
            #/
            
            logstring( "ZM Save: " + "Restored: Quest: " + namestring );
        }
    }
    
    logstring( "ZM Save: " + "Level restore complete" );
    
    if ( zm_quest::is_main_quest_complete() )
    {
        utility::flag_set( "mq_complete_on_load" );
    }
    
    utility::flag_set( "zm_save_level_restore_complete" );
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0x85c66474, Offset: 0x94a7
// Size: 0x119
function private function_8e19a65a0c8a135( mask, ref = "none" )
{
    offset = 0;
    
    switch ( ref )
    {
        case #"hash_6d7a7c0d4b7602a7":
            offset = 36;
            break;
        case #"hash_51a2edfbee05bdb5":
            offset = 36;
            break;
        case #"hash_94213e23c1c2bc15":
            offset = 32;
            break;
        case #"hash_9865b9ac4258261a":
            offset = 38;
            break;
        case #"hash_db653a4972b3c13b":
            offset = 0;
            break;
        default:
            offset = 0;
            break;
    }
    
    spawn_origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + offset );
    spawnoptions = common_item::function_bc5ff2958b71a708( spawn_origin, self.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    item = common_item::function_61c2c0251e742ffd( mask, undefined, spawnoptions );
    return item;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x1883f9a4, Offset: 0x95c9
// Size: 0x133
function private function_dbdeb2391a86c75()
{
    logstring( "ZM Save: " + "Test Harness Begin" );
    res = function_8eee0591fd5c5449();
    logstring( "ZM Save: " + "Test: Initial IsResumed result " + string( res ) );
    res = zmsaveinit( 345, level.players );
    logstring( "ZM Save: " + "Test: Initialization result " + string( res ) );
    zmsavewrite( "save", "round_num", 10 );
    res = zmsavecommit();
    logstring( "ZM Save: " + "Test: Commit result " + string( res ) );
    res = function_8eee0591fd5c5449();
    logstring( "ZM Save: " + "Test: Subsequent IsResumed result " + string( res ) );
    res = zmsaveread( "save", "round_num" );
    logstring( "ZM Save: " + "Test: Save read result " + string( res ) );
    res = zmsaveinvalidate();
    logstring( "ZM Save: " + "Test: Invalidate result " + string( res ) );
    zmsavereset();
    logstring( "ZM Save: " + "Test: Reset" );
    res = function_8eee0591fd5c5449();
    logstring( "ZM Save: " + "Test: Final IsResumed result " + string( res ) );
    logstring( "ZM Save: " + "Test Harness End" );
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x7892e782, Offset: 0x9704
// Size: 0x34
function private on_player_connect( params )
{
    thread set_autosave_stat( 0 );
    
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    callback::add( #"player_spawned", &zm_save_on_player_spawned );
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x320313bf, Offset: 0x9740
// Size: 0x106
function private on_player_disconnect( params )
{
    function_2b2c77dfbdfcda1();
    
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "autosaveOnClientDisconnectEnabled" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "begin_round_logic" ) )
    {
        return;
    }
    
    if ( level.var_838b34ec9c6565aa )
    {
        return;
    }
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    if ( level.zm_save_info.disconnect_save )
    {
        return;
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    
    if ( function_1dda3554974a999e() || round_number <= 1 )
    {
        return;
    }
    
    if ( self.var_1a98782093ca2c08 )
    {
        return;
    }
    
    assert( isdefined( level.players ) );
    
    if ( level.players.size == 0 )
    {
        level.zm_save_info.var_9b56dda5ea34b207 = 1;
        level.zm_save_info.disconnect_save = 1;
        commit_session( 1, 0 );
    }
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0x4166e1dc, Offset: 0x984e
// Size: 0xd2
function private function_3f4b55674a1d728( category, lootid )
{
    var_3f1254dd3132c8e1 = [];
    var_3f1254dd3132c8e1[ 7 ] = "none";
    var_3f1254dd3132c8e1[ 13 ] = "camo_none";
    var_3f1254dd3132c8e1[ 5 ] = "none";
    var_3f1254dd3132c8e1[ 15 ] = "gunscreen_none";
    var_3f1254dd3132c8e1[ 6 ] = "specialty_null";
    var_3f1254dd3132c8e1[ 14 ] = "none";
    var_3f1254dd3132c8e1[ 17 ] = "sticker_none";
    var_3f1254dd3132c8e1[ 4 ] = "none";
    var_3f1254dd3132c8e1[ 3 ] = "none";
    var_3f1254dd3132c8e1[ 2 ] = "none";
    var_3f1254dd3132c8e1[ 16 ] = "charm_none";
    var_3f1254dd3132c8e1[ 45 ] = "wildcard_none";
    
    if ( lootid == 0 )
    {
        return var_3f1254dd3132c8e1[ category ];
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( !isdefined( ref ) || ref == "" )
    {
        return var_3f1254dd3132c8e1[ category ];
    }
    
    return ref;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0xbef6ec77, Offset: 0x9929
// Size: 0x1c9
function private zm_save_on_player_spawned( params )
{
    self endon( #"death_or_disconnect" );
    assert( function_fcccc3d2a616b1c7() );
    assert( isdefined( level.zm_save_info ) );
    var_6787895101874fb4 = get_saved_player_index();
    
    if ( !isdefined( var_6787895101874fb4 ) )
    {
        logstring( "ZM Save: " + "Could not find player " + self getentitynumber() + " in save, aborting restore for them" );
        callback::remove( #"player_spawned", &zm_save_on_player_spawned );
        return;
    }
    
    restore_player_state( 1, var_6787895101874fb4 );
    callback::remove( #"player_spawned", &zm_save_on_player_spawned );
    params = spawnstruct();
    callback::callback( #"hash_79b197636e7199f", params );
    zone_name = get_saved_spawn_zone();
    
    if ( isdefined( zone_name ) )
    {
        query_zone_struct = undefined;
        zones = zone_manager::get_inited_zones();
        
        foreach ( zone_struct in zones )
        {
            if ( zone_struct.zone_name == zone_name )
            {
                query_zone_struct = zone_struct;
                break;
            }
        }
        
        if ( isdefined( query_zone_struct ) )
        {
            params = spawnstruct();
            params.zone_struct = query_zone_struct;
            callback::callback( "zone_changed", params );
        }
    }
    
    if ( !level.zm_save_info.var_a039f009852790bd )
    {
        level.zm_save_info.var_a039f009852790bd = 1;
        level function_f43f8528da9f88dd( self );
    }
}

// Namespace zm_save
// Params 2
// Checksum 0x2224a652, Offset: 0x9afa
// Size: 0x1aea, Type: bool
function restore_player_state( type, var_6787895101874fb4 )
{
    logstring( "ZM Save: " + "Player " + self getentitynumber() + " restore begin" );
    player_spawn_state = save_read( type, "save", "players", var_6787895101874fb4, "player_spawn_state" );
    self.total_purchased_perks = save_read( type, "save", "players", var_6787895101874fb4, "total_purchased_perks" );
    
    for ( index = 0; index < 16 ; index++ )
    {
        perk = save_read( type, "save", "players", var_6787895101874fb4, "active_perks", index );
        
        if ( !isdefined( perk ) || perk == "none" )
        {
            break;
        }
        
        zombie_perks::give_perk( perk, 0 );
        logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Perk: " + perk );
    }
    
    if ( player_spawn_state == "alive" || !function_7bb71291321c28de() )
    {
        loadout_struct = get_loadout_struct( 0 );
        primary_weapon = undefined;
        equipment_mp::clearallequipment();
        supers_mp::clearsuper();
        
        for ( weapon_index = 0; weapon_index < 4 ; weapon_index++ )
        {
            var_d4bf4208be305cc7 = loadout_struct.weapons[ weapon_index ].weapon;
            
            if ( isdefined( var_d4bf4208be305cc7 ) && var_d4bf4208be305cc7 != level.weaponnone )
            {
                self takeweapon( var_d4bf4208be305cc7 );
            }
        }
        
        for ( weapon_index = 0; weapon_index < 4 ; weapon_index++ )
        {
            loot_id = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "weaponLootID" );
            
            if ( !isdefined( loot_id ) || loot_id == 0 )
            {
                continue;
            }
            
            var_7068c97ad157148 = function_3f4b55674a1d728( 2, loot_id );
            
            if ( !isdefined( var_7068c97ad157148 ) || var_7068c97ad157148 == "" || var_7068c97ad157148 == "none" )
            {
                continue;
            }
            
            if ( magicbox::function_104dda0cb2a785ee( var_7068c97ad157148 ) )
            {
                continue;
            }
            
            var_eb9f90c52851b4d9 = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "weaponVariantID" );
            attachments = [];
            attachment_ids = [];
            
            for ( var_4345f239ffa3344 = 0; var_4345f239ffa3344 < 16 ; var_4345f239ffa3344++ )
            {
                attachment_loot_id = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "attachmentSetup", var_4345f239ffa3344, "attachmentLootID" );
                attachment_data_name = function_3f4b55674a1d728( 7, attachment_loot_id );
                
                if ( attachment_data_name == "none" )
                {
                    attachments[ var_4345f239ffa3344 ] = "none";
                }
                else
                {
                    attachments[ var_4345f239ffa3344 ] = getscriptbundlefieldvalue( hashcat( %"hash_3c2c9813bb16552f", attachment_data_name ), #"baseref" ) ?? "none";
                }
                
                attachment_ids[ var_4345f239ffa3344 ] = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "attachmentSetup", var_4345f239ffa3344, "attachmentVariantID" );
            }
            
            camo = function_3f4b55674a1d728( 13, save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "camoLootID" ) );
            
            if ( !isdefined( camo ) )
            {
                camo = "camo_none";
            }
            
            var_706017b30dc302e2 = function_3f4b55674a1d728( 13, save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "camo_lootID_before_pap" ) );
            
            if ( !isdefined( var_706017b30dc302e2 ) )
            {
                var_706017b30dc302e2 = "camo_none";
            }
            
            var_eafc15f24be8abe7 = function_3f4b55674a1d728( 14, save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "reticleLootID" ) );
            cosmetic_attachment = function_3f4b55674a1d728( 16, save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "cosmeticAttachmentLootID" ) );
            stickers = [];
            
            for ( slot = 0; slot < 5 ; slot++ )
            {
                stickers[ slot ] = function_3f4b55674a1d728( 17, save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "weapon_setup", "stickerLootIDs", slot ) );
            }
            
            var_f581dedba4f25efb = weapon::function_2374da6f1b4fad4e( weapon::weaponassetnamemap( var_7068c97ad157148 ), var_eb9f90c52851b4d9 );
            weapon = weapon::buildweapon( var_7068c97ad157148, attachments, camo, var_eafc15f24be8abe7, var_eb9f90c52851b4d9, attachment_ids, cosmetic_attachment, stickers, undefined, undefined, undefined, var_f581dedba4f25efb );
            pap_level = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "pack_level" );
            
            if ( pap_level > 0 )
            {
                if ( !isdefined( self.var_60c2ab39157e81d2 ) )
                {
                    self.var_60c2ab39157e81d2 = [];
                }
                
                self.var_60c2ab39157e81d2[ weapon.var_1616e6fbba9a722d ] = var_706017b30dc302e2;
                weapon = pack_a_punch::function_e190a315803e2870( weapon, pap_level, undefined, camo );
            }
            
            self giveweapon( weapon );
            
            if ( !isdefined( primary_weapon ) )
            {
                primary_weapon = weapon;
            }
            
            primaryweaponindex = item_weapon::function_1464d1c9177c4934( weapon );
            assert( -1 );
            
            if ( weapon_index == 2 && weapon::function_6b74ecd475e99b4( weapon ) )
            {
                weapon::function_b4c9549dee5d0fc5( weapon );
            }
            
            assert( -1 );
            
            if ( weapon_index == 3 && zombie_perks::has_perk( "specialty_z_mod" ) )
            {
                self.var_3bf72dcd2775aa78 = weapon;
                self.var_1dbdf5cd10dc5432 = primaryweaponindex;
            }
            
            clip_ammo = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "clip_ammo" );
            stock_ammo = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "stock_ammo" );
            self setweaponammoclip( weapon, clip_ammo );
            self setweaponammostock( weapon, stock_ammo );
            altweapon = weapon getaltweapon();
            
            if ( !isnullweapon( altweapon ) )
            {
                alt_clip_ammo = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "alt_clip_ammo" );
                alt_stock_ammo = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "alt_stock_ammo" );
                self setweaponammoclip( altweapon, alt_clip_ammo );
                self setweaponammostock( altweapon, alt_stock_ammo );
            }
            
            if ( pap_level > 0 )
            {
                pack_a_punch::function_3f3b9cdbb4843e45( weapon, pap_level, primary_weapon == weapon );
            }
            
            rarity = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "rarity" );
            item_weapon::function_40e1cbd0e1f47d1a( weapon, rarity, primary_weapon == weapon );
            item_weapon::function_b2eab55086e607dc( weapon, pap_level, rarity );
            ammo_mod = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "ammo_mod" );
            
            if ( isdefined( ammo_mod ) && ammo_mod != "none" )
            {
                ammo_mod::add_ammo_mod_to_weapon( weapon, ammo_mod, primary_weapon == weapon );
            }
            
            is_wallbuy_weapon = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_wallbuy_weapon" );
            
            if ( is_wallbuy_weapon )
            {
                if ( !isdefined( level.var_78b06bc85775ee0 ) )
                {
                    level.var_78b06bc85775ee0 = [];
                }
                
                level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = weapon;
                
                if ( weapon.hasalternate )
                {
                    altweapon = weapon getaltweapon();
                    level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = altweapon;
                }
            }
            
            is_magicbox_weapon = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_magicbox_weapon" );
            
            if ( is_magicbox_weapon )
            {
                if ( !isdefined( level.var_73d6fa41113ea1a8 ) )
                {
                    level.var_73d6fa41113ea1a8 = [];
                }
                
                level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = weapon;
                
                if ( weapon.hasalternate )
                {
                    altweapon = weapon getaltweapon();
                    level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = altweapon;
                }
            }
            
            is_quest_weapon = save_read( type, "save", "players", var_6787895101874fb4, "weapons", weapon_index, "is_quest_weapon_for_relic" );
            
            if ( is_quest_weapon )
            {
                if ( !isdefined( self.var_ba3dc11e269136ed ) )
                {
                    self.var_ba3dc11e269136ed = [];
                }
                
                self.var_ba3dc11e269136ed[ self.var_ba3dc11e269136ed.size ] = weapon.basename;
            }
            
            if ( isdefined( primaryweaponindex ) )
            {
                item_weapon::function_55c302d95295530f( weapon, rarity, primaryweaponindex );
            }
            else
            {
                errormsg = "Error: ZMSave restore_player_state - Failed to get primary weapon index for player index: " + var_6787895101874fb4 + " for weapon " + var_7068c97ad157148 + " Pap: " + ( pap_level ? pap_level : "none" );
                assertmsg( errormsg );
                logstring( errormsg );
                logstring( "ZM Save: " + errormsg );
            }
            
            logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Weapon index: " + weapon_index + " Name: " + var_7068c97ad157148 + " Pap: " + pap_level );
        }
        
        if ( isdefined( primary_weapon ) )
        {
            self switchtoweaponimmediate( primary_weapon );
            self setspawnweapon( primary_weapon, 1 );
        }
        
        lethal = save_read( type, "save", "players", var_6787895101874fb4, "equipments", 0, "name" );
        lethal_ammo = save_read( type, "save", "players", var_6787895101874fb4, "equipments", 0, "count" );
        
        if ( isdefined( lethal ) && lethal != "none" )
        {
            equipment_mp::giveequipment( lethal, "primary" );
            equipment_mp::setequipmentslotammo( "primary", lethal_ammo );
            logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Lethal: " + lethal );
        }
        
        tactical = save_read( type, "save", "players", var_6787895101874fb4, "equipments", 1, "name" );
        tactical_ammo = save_read( type, "save", "players", var_6787895101874fb4, "equipments", 1, "count" );
        
        if ( isdefined( tactical ) && tactical != "none" )
        {
            equipment_mp::giveequipment( tactical, "secondary" );
            equipment_mp::setequipmentslotammo( "secondary", tactical_ammo );
            logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Tactical: " + tactical );
        }
        
        super = save_read( type, "save", "players", var_6787895101874fb4, "super", "name" );
        
        if ( isdefined( super ) && super != "none" )
        {
            super_points = save_read( type, "save", "players", var_6787895101874fb4, "super", "charge" );
            perkpackage::perkpackage_giveimmediate( super, undefined, undefined, undefined, 0 );
            supers_mp::givesuperpoints( super_points, undefined, 1 );
            superinfo = self.super;
            
            if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
            {
                superinfo.staticdata.var_5afeac4251aa48da = &field_upgrades::function_547d8d27c323ad0;
            }
            
            if ( isdefined( self.overclockcharge ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
            {
                extra_points = save_read( type, "save", "players", var_6787895101874fb4, "super", "extra_charge" );
                
                if ( extra_points > 0 )
                {
                    supers_mp::givesuperpoints( extra_points, undefined, 1 );
                }
            }
            
            logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Super: " + super );
        }
        
        killstreak = save_read( type, "save", "players", var_6787895101874fb4, "support_killstreak" );
        killstreak_count = save_read( type, "save", "players", var_6787895101874fb4, "support_killstreak_count" );
        
        if ( isdefined( killstreak ) && killstreak != "none" && isdefined( level.killstreaksetups[ killstreak ] ) )
        {
            thread give_killstreak_delayed( killstreak, killstreak_count );
            logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Support killstreak: " + killstreak );
        }
    }
    
    self.bgb_support_group_killstreak_save = save_read( type, "save", "players", var_6787895101874fb4, "bgb_support_group_killstreak" );
    self.n_loot_key_level = save_read( type, "save", "players", var_6787895101874fb4, "loot_key_level" );
    logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Loot key level: " + self.n_loot_key_level );
    
    if ( isdefined( level.bgb ) && isdefined( self.var_b02f6e7abbbc8a84 ) )
    {
        for ( index = 0; index < 3 ; index++ )
        {
            saved_bgb = save_read( type, "save", "players", var_6787895101874fb4, "gums", index, "ref" );
            
            if ( saved_bgb == "" )
            {
                continue;
            }
            
            is_enabled = save_read( type, "save", "players", var_6787895101874fb4, "gums", index, "is_enabled" );
            time_left = save_read( type, "save", "players", var_6787895101874fb4, "gums", index, "time_left" );
            is_free = save_read( type, "save", "players", var_6787895101874fb4, "gums", index, "is_free" );
            function_2d8d31eaeb4509af( saved_bgb, index + 1, is_enabled, time_left, is_free );
            var_af90348246727a35 = getxhashhexname( saved_bgb );
            
            /#
                var_af90348246727a35 = getxhashsourcename( saved_bgb );
            #/
            
            logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " BGB: " + var_af90348246727a35 );
        }
    }
    
    essence = save_read( type, "save", "players", var_6787895101874fb4, "essence" );
    salvage = save_read( type, "save", "players", var_6787895101874fb4, "salvage" );
    rare_salvage = save_read( type, "save", "players", var_6787895101874fb4, "rare_salvage" );
    currency::set_currency_amount( #"essence", essence );
    currency::set_currency_amount( #"salvage", salvage );
    currency::set_currency_amount( #"rare_salvage", rare_salvage );
    logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Essence: " + essence + " Salvage: " + salvage + " Rare salvage: " + rare_salvage );
    increased_cost = save_read( type, "save", "players", var_6787895101874fb4, "super_increased_cost" );
    self.var_6b07486215a175b0 = increased_cost ?? 0;
    total_score = save_read( type, "save", "players", var_6787895101874fb4, "scoreboard", "total_score" );
    kills = save_read( type, "save", "players", var_6787895101874fb4, "scoreboard", "kills" );
    critical_kills = save_read( type, "save", "players", var_6787895101874fb4, "scoreboard", "critical_kills" );
    self.doorbuycount = save_read( type, "save", "players", var_6787895101874fb4, "scoreboard", "doorbuys_opened" );
    self.revivecount = save_read( type, "save", "players", var_6787895101874fb4, "scoreboard", "revives" );
    logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Total score: " + total_score + " Kills: " + kills + " Critical kills: " + critical_kills + " Doorbuys opened: " + self.doorbuycount + " Revives: " + self.revivecount );
    self.total_score_earned = 0;
    points::update_total_score_earned( total_score );
    stats::function_ee7ea2a7c2c198f3( kills );
    stats::setextrascore2( critical_kills );
    zm_ui::function_b814b25c8d99fd02();
    var_b35729a9ecacd84f = save_read( type, "save", "players", var_6787895101874fb4, "first_time_getting_mule_kick" );
    self.var_b35729a9ecacd84f = var_b35729a9ecacd84f;
    
    for ( index = 0; index < 16 ; index++ )
    {
        perk = save_read( type, "save", "players", var_6787895101874fb4, "purchased_perks", index );
        
        if ( !isdefined( perk ) || perk == "none" )
        {
            break;
        }
        
        if ( !isdefined( self.perkspurchased ) )
        {
            self.perkspurchased = [];
        }
        
        self.perkspurchased[ perk ] = 1;
        logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Purchased Perk: " + perk );
    }
    
    for ( index = 0; index < 16 ; index++ )
    {
        perk = save_read( type, "save", "players", var_6787895101874fb4, "perma_perks", index );
        
        if ( !isdefined( perk ) || perk == "none" )
        {
            break;
        }
        
        zombie_perks::function_3c5c75cec72d90aa( perk );
        logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Perma Perk: " + perk );
    }
    
    zombie_perks::function_c11ba4bb3d0a676b( 1 );
    a_loose_change = getnoentvolumearray( "lc_trigger", "targetname" );
    var_28f83b842d970853 = [];
    
    for ( index = 0; index < 16 ; index++ )
    {
        perk = save_read( type, "save", "players", var_6787895101874fb4, "active_loose_change", index );
        var_28f83b842d970853[ var_28f83b842d970853.size ] = perk;
        
        if ( !isdefined( perk ) || perk == "none" )
        {
            break;
        }
        
        logstring( "ZM Save: " + "Read: Player Index: " + var_6787895101874fb4 + " Loose Change: " + perk );
    }
    
    foreach ( trigger in a_loose_change )
    {
        if ( !arraycontains( var_28f83b842d970853, trigger.script_noteworthy ) )
        {
            trigger delete();
        }
    }
    
    var_d98f48cd0b25b15d = getnoentvolumearray( "ec_trigger", "targetname" );
    
    foreach ( trigger in var_d98f48cd0b25b15d )
    {
        trigger delete();
    }
    
    self.var_6f9595e5de90c2aa = save_read( type, "save", "players", var_6787895101874fb4, "num_dying_wish" );
    self.var_84cde01ffd2cb360 = save_read( type, "save", "players", var_6787895101874fb4, "num_last_chance" );
    self.w_mod_savior_uses = save_read( type, "save", "players", var_6787895101874fb4, "w_mod_savior_uses" );
    self.scarab_ee_mask_id = save_read( type, "save", "players", var_6787895101874fb4, "scarab_ee_mask_id" );
    
    if ( isnumber( self.scarab_ee_mask_id ) )
    {
        thread function_a40517a74fcbff8f();
    }
    
    var_a1faa64d8c07872e = save_read( type, "save", "players", var_6787895101874fb4, "has_gold_armor" );
    self.allow_instant_bgb_pack_switching = save_read( type, "save", "players", var_6787895101874fb4, "allow_instant_bgb_pack_switching" );
    
    if ( var_a1faa64d8c07872e )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"set_golden_armor" ) )
        {
            utility::callsharedfunc( #"zombie", #"set_golden_armor" );
        }
    }
    
    if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_show_armor_global", 0 );
            
            if ( player.var_a1faa64d8c07872e || player.maxarmorhealth == 3 )
            {
                player.platecarrierlevel = 3;
                player namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( 3 );
                armorhealth = namespace_74c85f0ddf2d285f::get_max_armor_health();
                player.maxarmorhealth = armorhealth;
                params = spawnstruct();
                params.player = player;
                params.activate = 1;
                player callback::callback( "toggle_squad_armor", params );
            }
        }
    }
    
    eliminations = save_read( type, "save", "players", var_6787895101874fb4, "eliminations" );
    mq_progress_time_ms = save_read( type, "save", "players", var_6787895101874fb4, "mq_progress_time_ms" );
    mq_completed = save_read( type, "save", "players", var_6787895101874fb4, "mq_completed" );
    time_played = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "time_played" );
    special_elims = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "special_elims" );
    elite_elims = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "elite_elims" );
    boss_elims = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "boss_elims" );
    pap_elims = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "pap_elims" );
    legendary_elims = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "legendary_elims" );
    one_shot_kills = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "one_shot_kills" );
    match_id = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "match_id" );
    solo_paused_time_ms = save_read( type, "save", "players", var_6787895101874fb4, "telemetry", "solo_paused_time_ms" );
    
    if ( !isdefined( self.pers[ "telemetry" ].var_efd960f3c3cf6f19 ) )
    {
        self.pers[ "telemetry" ].var_efd960f3c3cf6f19 = {};
    }
    
    var_efd960f3c3cf6f19 = self.pers[ "telemetry" ].var_efd960f3c3cf6f19;
    var_efd960f3c3cf6f19.eliminations = eliminations;
    var_efd960f3c3cf6f19.mq_progress_time_ms = mq_progress_time_ms;
    var_efd960f3c3cf6f19.mq_completed = mq_completed;
    var_efd960f3c3cf6f19.prev_time_played = time_played;
    var_efd960f3c3cf6f19.special_eliminations = special_elims;
    var_efd960f3c3cf6f19.elite_eliminations = elite_elims;
    var_efd960f3c3cf6f19.boss_eliminations = boss_elims;
    var_efd960f3c3cf6f19.pap_weapon_elims = pap_elims;
    var_efd960f3c3cf6f19.legendary_weapon_elims = legendary_elims;
    var_efd960f3c3cf6f19.one_shot_kills = one_shot_kills;
    var_efd960f3c3cf6f19.critical_kills = critical_kills;
    var_efd960f3c3cf6f19.essence = self.total_score_earned;
    var_efd960f3c3cf6f19.salvage = salvage;
    var_efd960f3c3cf6f19.door_buys = self.doorbuycount;
    var_efd960f3c3cf6f19.revives = self.revivecount;
    var_efd960f3c3cf6f19.match_id = match_id;
    var_efd960f3c3cf6f19.solo_paused_time_ms = solo_paused_time_ms;
    challenges_states = [];
    
    for ( index = 0; index < 11 ; index++ )
    {
        challenges_states[ index ] = save_read( type, "save", "players", var_6787895101874fb4, "challenges_states", index );
    }
    
    if ( isarray( challenges_states ) )
    {
        self.var_b8e6a8c9bfecb39 = challenges_states[ 0 ];
        self.var_1a750b53551a95c3 = challenges_states[ 1 ];
        self.var_8ba28984e9b77eb8 = challenges_states[ 2 ];
        self.var_bf28468f33958718 = challenges_states[ 3 ];
        level.any_doorbuy_opened = challenges_states[ 4 ];
        self.var_998090d04c25480b = challenges_states[ 5 ];
        level.var_cea2fe0ea477724a = challenges_states[ 6 ];
        self.was_frozen = challenges_states[ 7 ];
        self.b_used_ammo_cache = challenges_states[ 8 ];
        self.b_used_perk_machine = challenges_states[ 9 ];
        self.var_b728f74baa7e0b47 = challenges_states[ 10 ];
    }
    
    relics_states = [];
    
    for ( index = 0; index < 8 ; index++ )
    {
        relics_states[ index ] = save_read( type, "save", "players", var_6787895101874fb4, "relics_states", index );
    }
    
    if ( isarray( relics_states ) )
    {
        self.var_3df52cdafd7c3a3f = relics_states[ 0 ];
        level.var_1241723eaf9538b = relics_states[ 1 ];
        level.var_2d551b2a23bf56fb = relics_states[ 2 ];
        level.var_dd5a72f42d9c38e = relics_states[ 3 ];
        level.var_ae96560687cb440 = relics_states[ 4 ];
        self.relic_damage = relics_states[ 5 ];
        level.var_23f0535ecbba9ff3 = relics_states[ 6 ];
        level.var_1f33183f27882b21 = relics_states[ 7 ];
    }
    
    level utility::flag_set( "relic_states_restored" );
    super_ee_states = [];
    
    for ( index = 0; index < 1 ; index++ )
    {
        super_ee_states[ index ] = save_read( type, "save", "players", var_6787895101874fb4, "super_ee_states", index );
    }
    
    if ( isarray( super_ee_states ) )
    {
        self.var_e8b776e9698cb857 = super_ee_states[ 0 ];
    }
    
    self setclientomnvar( "ui_time_played_save", var_efd960f3c3cf6f19.prev_time_played );
    
    if ( mq_completed )
    {
        self.pers[ "telemetry" ].mq_completed = 1;
        self.pers[ "telemetry" ].mq_complete_time_ms = mq_progress_time_ms;
    }
    
    if ( player_spawn_state != "alive" && function_7bb71291321c28de() )
    {
        zm_catchup::set_catchup_items( player_spawn_state == "hotjoin" );
    }
    
    logstring( "ZM Save: " + "Player " + self getentitynumber() + " restore complete" );
    
    if ( level.zm_save_info )
    {
        level.zm_save_info.restored_players = ( level.zm_save_info.restored_players ?? 0 ) + 1;
    }
    
    return true;
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x3afb8c66, Offset: 0xb5ed
// Size: 0xde
function private function_a40517a74fcbff8f()
{
    wait 1;
    
    if ( isplayer( self ) && isnumber( self.scarab_ee_mask_id ) )
    {
        switch ( self.scarab_ee_mask_id )
        {
            case 1:
                if ( level.var_cecd1497de62383d )
                {
                    common_item::function_96119bed8ab4c5d9( level.var_cecd1497de62383d );
                }
                
                break;
            case 2:
                if ( level.var_a22ccc3239223459 )
                {
                    common_item::function_96119bed8ab4c5d9( level.var_a22ccc3239223459 );
                }
                
                break;
            case 3:
                if ( level.var_b30347bb441cd8b )
                {
                    common_item::function_96119bed8ab4c5d9( level.var_b30347bb441cd8b );
                }
                
                break;
            case 4:
                if ( level.var_f8f4e3b9b8d160b8 )
                {
                    common_item::function_96119bed8ab4c5d9( level.var_f8f4e3b9b8d160b8 );
                }
                
                break;
        }
    }
}

// Namespace zm_save
// Params 2, eflags: 0x4
// Checksum 0x7dd8c79a, Offset: 0xb6d3
// Size: 0x77
function private give_killstreak_delayed( killstreak, killstreak_count )
{
    self endon( #"death_or_disconnect" );
    level waittill( #"begin_round_logic" );
    fakeitem = {};
    fakeitem.fromgroup = 2;
    fakeitem.count = killstreak_count;
    fakeitem.type = common_item::function_70d4affb770e8103( killstreak );
    common_item::function_2b5e2ff57d5f392( fakeitem, 0, 1 );
}

// Namespace zm_save
// Params 5, eflags: 0x4
// Checksum 0x87f45ac8, Offset: 0xb752
// Size: 0x2d8
function private function_2d8d31eaeb4509af( hash_bgb, slot, is_enabled, time_left, is_free = 0 )
{
    if ( is_free )
    {
        if ( isxhash( hash_bgb ) )
        {
            keys = getarraykeys( level.bgb );
            
            foreach ( key in keys )
            {
                if ( getxhash( key ) === hash_bgb )
                {
                    hash_bgb = key;
                }
            }
        }
        
        self.var_4317de3baf10e68d[ 0 ] = hash_bgb;
    }
    
    keys = getarraykeys( level.bgb );
    
    foreach ( var_66cc4d3d21a0ce0d in keys )
    {
        if ( var_66cc4d3d21a0ce0d == hash_bgb )
        {
            if ( !level.onlinegame || bgb::get_gum_count( var_66cc4d3d21a0ce0d ) > 0 )
            {
                if ( is_enabled && ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 == "activated" || level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 == "event" ) )
                {
                    if ( var_66cc4d3d21a0ce0d == "support_group" || var_66cc4d3d21a0ce0d == "round_off" )
                    {
                        xuid = function_fffbd405b1911268( self getxuid() );
                        level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] = time_left;
                    }
                    
                    if ( level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] >= 2 )
                    {
                        bgb::function_4818e19472b65502( var_66cc4d3d21a0ce0d );
                        level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] = undefined;
                        return;
                    }
                }
                
                bgb::set_action_slot( slot, var_66cc4d3d21a0ce0d, 0, 0 );
                self.var_48081f882523254d[ var_66cc4d3d21a0ce0d ].var_d2ccdc3b4353d23b++;
                
                if ( is_enabled )
                {
                    switch ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 )
                    {
                        case #"hash_4f89286e3448ad44":
                            override_limit = time_left * 0.001;
                            break;
                        case #"hash_d80a36cf43c842b8":
                            override_limit = minint( 999, time_left );
                            break;
                        case #"hash_d9a7b65f9477385c":
                            override_limit = time_left;
                            break;
                        default:
                            override_limit = undefined;
                            break;
                    }
                    
                    bgb::give_slot( slot, var_66cc4d3d21a0ce0d, override_limit );
                }
            }
            
            break;
        }
    }
}

// Namespace zm_save
// Params 0
// Checksum 0xaef5df24, Offset: 0xba32
// Size: 0x7f
function get_active_relics()
{
    var_b07f37580148debd = [];
    
    for ( index = 0; index < 30 ; index++ )
    {
        var_95626e9e2b6783c9 = zmsaveread( "save", "relics_active", index );
        
        if ( !var_95626e9e2b6783c9 )
        {
            break;
        }
        
        relic_ref = loot::function_f54ecb89dfab8e8c( var_95626e9e2b6783c9 );
        relic_hash = hashcat( %"hash_5d85ffbe6fa2a891", relic_ref );
        var_b07f37580148debd[ var_b07f37580148debd.size ] = relic_hash;
    }
    
    return var_b07f37580148debd;
}

// Namespace zm_save
// Params 1, eflags: 0x4
// Checksum 0x6b7b0dc3, Offset: 0xbaba
// Size: 0x17d
function private function_f43f8528da9f88dd( player )
{
    assert( function_1dda3554974a999e() );
    
    if ( !level.wonder_veh )
    {
        return;
    }
    
    var_6209aa2f9c5149e4 = utility::getstructarray( "vehicle_respawn_point", "targetname" );
    
    if ( !var_6209aa2f9c5149e4.size )
    {
        iprintlnbold( "ZM Save: Warning, no vehicle respawn points found for wonder vehicle." );
        logstring( "ZM Save: Warning, no vehicle respawn points found for wonder vehicle." );
        return;
    }
    
    sorted_points = function_628bac9faa9d1e86( var_6209aa2f9c5149e4, player.origin );
    
    foreach ( point in sorted_points )
    {
        nav_origin = getclosestpointonnavmesh( point.origin );
        
        if ( isdefined( nav_origin ) )
        {
            if ( zone_manager::function_65305a611c6226d9( nav_origin ) )
            {
                chosen_point = point;
                break;
            }
        }
    }
    
    if ( !isdefined( chosen_point ) )
    {
        iprintlnbold( "ZM Save: Warning, no valid vehicle respawn points found for wonder vehicle." );
        logstring( "ZM Save: Warning, no valid vehicle respawn points found for wonder vehicle." );
        return;
    }
    
    level.wonder_veh vehicle_teleport( chosen_point.origin + ( 0, 0, 8 ), chosen_point.angles ?? ( 0, 0, 0 ), 0 );
}

// Namespace zm_save
// Params 3, eflags: 0x44 variadic
// Checksum 0x64a922c5, Offset: 0xbc3f
// Size: 0x206
function private save_write( type = 1, ... )
{
    if ( type == 1 )
    {
        zmsavewrite( flat_args( vararg, varargcount ) );
        return;
    }
    
    if ( type == 2 )
    {
        save_struct = function_1a522a5158b49670();
        save_map = save_struct.map;
        var_d21a8a8bea13abaf = [];
        value = vararg[ varargcount - 1 ];
        var_i = 0;
        
        while ( var_i < varargcount )
        {
            var = vararg[ var_i ];
            
            if ( var_i === varargcount - 1 )
            {
                save_map[ var ] = value;
                var_d21a8a8bea13abaf[ var_d21a8a8bea13abaf.size ] = value;
            }
            else
            {
                if ( !isdefined( save_map[ var ] ) )
                {
                    save_map[ var ] = [];
                }
                
                var_d21a8a8bea13abaf[ var_d21a8a8bea13abaf.size ] = save_map;
                save_map = save_map[ var ];
                
                if ( !isarray( save_map ) )
                {
                    var_c3fd87566fc42030 = "";
                    var_i = 0;
                    
                    while ( var_i < varargcount )
                    {
                        var = vararg[ var_i ];
                        var_c3fd87566fc42030 += var + " -> ";
                        var_i += 1;
                    }
                    
                    assertmsg( "<dev string:x468>" + var_c3fd87566fc42030 );
                    return;
                }
            }
            
            var_i += 1;
        }
        
        var = vararg[ varargcount - 1 ];
        save_map = var_d21a8a8bea13abaf[ varargcount - 2 ];
        save_map[ vararg[ varargcount - 2 ] ] = var;
        var_i = varargcount - 3;
        
        while ( var_i >= 0 )
        {
            var_8e27f070b66c7c54 = save_map;
            save_map = var_d21a8a8bea13abaf[ var_i ];
            var = vararg[ var_i ];
            save_map[ var ] = var_8e27f070b66c7c54;
            var_i -= 1;
        }
        
        save_struct.map = save_map;
        
        if ( !isdefined( level.var_d1a225bf9dac26b3 ) )
        {
            level.var_d1a225bf9dac26b3 = gettime();
        }
        
        if ( !isdefined( level.var_3c4390042a9999f9 ) )
        {
            level.var_3c4390042a9999f9 = 0;
        }
        
        if ( level.var_d1a225bf9dac26b3 != gettime() )
        {
            level.var_d1a225bf9dac26b3 = gettime();
            level.var_3c4390042a9999f9 = 0;
        }
        
        if ( level.var_3c4390042a9999f9 >= 30 )
        {
            waitframe();
        }
        
        level.var_3c4390042a9999f9++;
    }
}

// Namespace zm_save
// Params 3, eflags: 0x44 variadic
// Checksum 0x414a8157, Offset: 0xbe4d
// Size: 0xe4
function private save_read( type = 1, ... )
{
    if ( type == 1 )
    {
        return zmsaveread( flat_args( vararg, varargcount ) );
    }
    
    if ( type == 2 )
    {
        save_struct = function_1a522a5158b49670();
        save_map = save_struct.map;
        
        foreach ( var in vararg )
        {
            if ( !isdefined( save_map[ var ] ) )
            {
                return;
            }
            
            save_map = save_map[ var ];
        }
        
        return save_map;
    }
}

// Namespace zm_save
// Params 1
// Checksum 0xa5265b0e, Offset: 0xbf3a
// Size: 0x56
function function_44611ba14d9004aa( var_6787895101874fb4 )
{
    save_struct = function_1a522a5158b49670();
    
    if ( isdefined( save_struct.map[ "save" ][ "players" ][ var_6787895101874fb4 ] ) )
    {
        save_struct.map[ "save" ][ "players" ][ var_6787895101874fb4 ] = undefined;
    }
}

// Namespace zm_save
// Params 0, eflags: 0x4
// Checksum 0x7c3ec4a5, Offset: 0xbf98
// Size: 0x2b
function private function_1a522a5158b49670()
{
    if ( !isdefined( level.zm_save_struct ) )
    {
        level.zm_save_struct = { #map:[] };
    }
    
    return level.zm_save_struct;
}

/#

    // Namespace zm_save
    // Params 0, eflags: 0x4
    // Checksum 0x18ac28ee, Offset: 0xbfcc
    // Size: 0x86, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4f3>" );
        devgui::add_devgui_func( "<dev string:x4fc>", "<dev string:x509>", &function_e177a40a6fc4f5ff );
        devgui::add_devgui_func( "<dev string:x516>", "<dev string:x525>", &function_517e4523ca49c573 );
        devgui::add_devgui_func( "<dev string:x539>", "<dev string:x556>", &function_ffe7731cbf06dca8 );
        devgui::add_devgui_func( "<dev string:x567>", "<dev string:x575>", &devgui_clear_session );
        devgui::add_devgui_func( "<dev string:x588>", "<dev string:x5a1>", &function_e6fb9b4397a1bb2c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_save
    // Params 0, eflags: 0x4
    // Checksum 0xce8ff83b, Offset: 0xc05a
    // Size: 0x23, Type: dev
    function private function_e177a40a6fc4f5ff()
    {
        if ( save_session( 0 ) )
        {
            iprintlnbold( "<dev string:x5ba>" );
            logstring( "<dev string:x5ba>" );
        }
    }

    // Namespace zm_save
    // Params 0, eflags: 0x4
    // Checksum 0x78322d15, Offset: 0xc085
    // Size: 0x23, Type: dev
    function private function_517e4523ca49c573()
    {
        if ( commit_session( 0 ) )
        {
            iprintlnbold( "<dev string:x5d1>" );
            logstring( "<dev string:x5d1>" );
        }
    }

    // Namespace zm_save
    // Params 0, eflags: 0x4
    // Checksum 0x293ba02a, Offset: 0xc0b0
    // Size: 0x93, Type: dev
    function private function_ffe7731cbf06dca8()
    {
        foreach ( player in level.players )
        {
            player openmenu( "<dev string:x5ec>" );
            player hud_message::showerrormessage( %"SAVE_LOAD/SAVE_FAILED" );
        }
    }

    // Namespace zm_save
    // Params 0, eflags: 0x4
    // Checksum 0x2183e9ae, Offset: 0xc14b
    // Size: 0x25, Type: dev
    function private devgui_clear_session()
    {
        if ( zmsaveinvalidate() )
        {
            zmsavereset();
            iprintlnbold( "<dev string:x5f9>" );
            logstring( "<dev string:x5f9>" );
        }
    }

    // Namespace zm_save
    // Params 0, eflags: 0x4
    // Checksum 0xb2892a15, Offset: 0xc178
    // Size: 0x67, Type: dev
    function private function_e6fb9b4397a1bb2c()
    {
        setdvar( @"sv_jqprof_enabled", 1 );
        setdvar( @"sv_jqprof_continuous", 1 );
        waitframe();
        runjqprofile( "<dev string:x612>" + gettime(), 1 );
        player = level.players[ 0 ];
        player save_player_state( 2, 0 );
        waitframe();
        player restore_player_state( 2, 0 );
    }

#/
