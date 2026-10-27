// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_black_room.gsc  (hash_5607e84827a261c7.gscc) (size: 23022 Bytes / 0x59ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x10628d7f (274894207)
// size ...... 23022 (0x59ee)
// includes .. 20  (offset: 0x5116)
// strings ... 99  (offset: 0x51b6)
// dev strs .. 23  (offset: 0x58ca)
// exports ... 47  (offset: 0x3332)
// cseg ...... 0x835 + 0x2afd (0x3332)
// imports ... 175 (offset: 0x3a8a)
// animtree1 . 0   (offset: 0x59ee)
// animtree2 . 0   (offset: 0x59ee)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_black_room;

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x5
// Checksum 0x2bb2c879, Offset: 0x853
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"scarab_black_room", undefined, &pre_main, &post_main );
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xbb06d7af, Offset: 0x878
// Size: 0x90
function private pre_main()
{
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        return;
    }
    
    utility::flag_init( "black_room_in_use" );
    level.scarab_black_room = spawnstruct();
    level.scarab_black_room.var_e4d5f0bc6a97190c = [];
    level.scarab_black_room.a_visited = [];
    level.scarab_black_room.a_used_structs = [];
    zm_quest::register_quest_step( #"black_room", #"black_room", &black_room_init, &black_room_cleanup );
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0x7ccdc097, Offset: 0x910
// Size: 0x255
function private post_main()
{
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) )
    {
        return;
    }
    
    level._effect[ "black_room_cage_beam" ] = loadfxasset( "vfx_sat_levels_zm_scarab_black_room_light_beam" );
    level._effect[ "black_room_teleport_fx" ] = loadfxasset( "vfx_sat_zm_scarab_world_tear_portal_screen_fx_teleport_out_warning" );
    level._effect[ "black_room_teleport_in_fx" ] = loadfxasset( "vfx_sat_zm_scarab_world_tear_portal_screen_fx_teleport_in" );
    level._effect[ "black_room_teleport_3p_fx" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    zm_save::function_1f44a48caae2acbf();
    level.scarab_black_room.a_all_portals = utility::getstructarray( "black_room_portal", "targetname" );
    
    foreach ( index, item in level.scarab_black_room.a_all_portals )
    {
        if ( zm_quest::function_73720cdf21c3cfd7( #"black_room", hashcat( #"black_room_portal_used", string( index ) ) ) )
        {
            level.scarab_black_room.a_used_structs[ level.scarab_black_room.a_used_structs.size ] = item;
            level.scarab_black_room.a_all_portals = function_a5c1175d3ea3c25a( level.scarab_black_room.a_all_portals, item );
        }
    }
    
    level thread function_d934451631276e39();
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"black_room", #"black_room_completed" ) || zm_quest::is_quest_complete( #"scarab_mq" ) )
    {
        return;
    }
    
    zm_quest::start_quest( #"black_room" );
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( "special_round_start", &on_special_round_start );
    level callback::add( "special_round_end", &on_special_round_end );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level thread function_b95d06ef6f50e995();
    level thread function_d646b56c63903f96();
    
    /#
        level thread function_ec6d4c9d857773f();
    #/
}

// Namespace zm_sat_scarab_black_room
// Params 0
// Checksum 0x9c8867e0, Offset: 0xb6d
// Size: 0xbd
function function_d934451631276e39()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    
    foreach ( player in level.players )
    {
        if ( zm_quest::function_73720cdf21c3cfd7( #"black_room", hashcat( #"player_has_entered", string( player getentitynumber() ) ) ) )
        {
            mark_visited( player );
        }
    }
}

// Namespace zm_sat_scarab_black_room
// Params 1
// Checksum 0xe3a5587e, Offset: 0xc32
// Size: 0x27
function on_player_disconnect( params )
{
    if ( utility::ent_flag( "black_room_visited" ) )
    {
        level utility::flag_clear( "black_room_in_use" );
    }
}

// Namespace zm_sat_scarab_black_room
// Params 1
// Checksum 0x10c2b350, Offset: 0xc61
// Size: 0xfb
function on_round_start( params )
{
    if ( !zm_round_spawning::is_special_round( zm_utility::get_round_number() + 1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.scarab_black_room ) )
    {
        level.scarab_black_room = spawnstruct();
    }
    
    next_portal_struct = utility::array_random( level.scarab_black_room.a_all_portals );
    
    foreach ( index, var_16af6624858ffa21 in level.scarab_black_room.a_all_portals )
    {
        if ( next_portal_struct == var_16af6624858ffa21 )
        {
            zm_quest::function_4eefe6de31f5ddab( #"black_room", #"black_room_portal_index", index );
            break;
        }
    }
}

// Namespace zm_sat_scarab_black_room
// Params 0
// Checksum 0x5ba2f49f, Offset: 0xd64
// Size: 0x53
function function_b95d06ef6f50e995()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "enter_boss_fight_go" );
    level callback::remove( "special_round_start", &on_special_round_start );
    level callback::remove( "special_round_end", &on_special_round_end );
    level notify( #"black_room_round_ended" );
    level thread clear_all_portals();
}

// Namespace zm_sat_scarab_black_room
// Params 2
// Checksum 0x74069563, Offset: 0xdbf
// Size: 0x15
function black_room_init( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_black_room
// Params 2
// Checksum 0xc4c6f4d, Offset: 0xddc
// Size: 0x15
function black_room_cleanup( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xe289f061, Offset: 0xdf9
// Size: 0x56
function private function_d646b56c63903f96()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        n_debug_powerup = getdvarint( @"hash_aef129cb7673f8bd", 0 );
        
        if ( n_debug_powerup != 0 )
        {
            setdvar( @"hash_aef129cb7673f8bd", 0 );
            level thread function_f63c60e3ae54013d( n_debug_powerup );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0xdbf7ac7d, Offset: 0xe57
// Size: 0x94
function private function_3dd6b2a8c750ecbb( n_debug_powerup )
{
    switch ( n_debug_powerup )
    {
        case 1:
            return "full_ammo";
        case 2:
            return "double_points";
        case 3:
            return "insta_kill";
        case 4:
            return "nuke";
        case 5:
            return "fire_sale";
        case 6:
            return "full_armor";
        case 7:
            return "full_power";
    }
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0xcc2cfbe5, Offset: 0xef4
// Size: 0x139
function private function_f63c60e3ae54013d( n_debug_powerup )
{
    level endon( #"game_ended" );
    str_powerup = function_3dd6b2a8c750ecbb( n_debug_powerup );
    
    if ( !isdefined( str_powerup ) )
    {
        iprintlnbold( "Black Room debug powerup id is invalid" );
        return;
    }
    
    player = undefined;
    
    foreach ( candidate in level.players )
    {
        if ( zm_player::function_f37cfdf04b932a03( candidate, 0, 0 ) )
        {
            player = candidate;
            break;
        }
    }
    
    if ( !isdefined( player ) )
    {
        iprintlnbold( "Black Room debug powerup spawn failed: no valid player" );
        return;
    }
    
    v_dir = anglestoforward( player getplayerangles() );
    v_pos = player.origin + v_dir * 80 + ( 0, 0, 30 );
    level powerups::powerup_drop( str_powerup, v_pos, undefined, undefined, "quest" );
    iprintlnbold( "Black Room debug spawned powerup: " + str_powerup );
}

/#

    // Namespace zm_sat_scarab_black_room
    // Params 0, eflags: 0x4
    // Checksum 0x70925d4b, Offset: 0x1035
    // Size: 0x10b, Type: dev
    function private function_ec6d4c9d857773f()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3a>", "<dev string:x52>", &function_fb7fc7dd9497b2a3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6d>", "<dev string:x89>", &function_fb7fc7dd9497b2a3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa4>", "<dev string:xbd>", &function_fb7fc7dd9497b2a3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd8>", "<dev string:xeb>", &function_fb7fc7dd9497b2a3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x106>", "<dev string:x11e>", &function_fb7fc7dd9497b2a3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x139>", "<dev string:x152>", &function_fb7fc7dd9497b2a3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x16d>", "<dev string:x186>", &function_fb7fc7dd9497b2a3 );
        devgui::add_devgui_func( "<dev string:x1a1>", "<dev string:x1a1>", &function_d88cf445ea4aebfc );
        devgui::add_devgui_func( "<dev string:x1b3>", "<dev string:x1b3>", &function_d478d6ebee646acf );
        devgui::add_devgui_func( "<dev string:x1ca>", "<dev string:x1ca>", &spawn_rewards );
        devgui::add_devgui_func( "<dev string:x1d8>", "<dev string:x1d8>", &test_friendly_outline );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_black_room
    // Params 0
    // Checksum 0x1e94549d, Offset: 0x1148
    // Size: 0x2f, Type: dev
    function test_friendly_outline()
    {
        function_3264af4e7a8e907a( level.players[ 0 ], 1 );
        wait 10;
        function_3264af4e7a8e907a( level.players[ 0 ], undefined );
    }

    // Namespace zm_sat_scarab_black_room
    // Params 0
    // Checksum 0x5bf8e4ff, Offset: 0x117f
    // Size: 0x2c, Type: dev
    function spawn_rewards()
    {
        level.players[ 0 ] function_8bcb7582e3d498d7( level.players[ 0 ].origin );
    }

    // Namespace zm_sat_scarab_black_room
    // Params 0
    // Checksum 0x97ad1004, Offset: 0x11b3
    // Size: 0x103, Type: dev
    function function_d88cf445ea4aebfc()
    {
        a_structs = utility::getstructarray( "<dev string:x1ee>", "<dev string:x200>" );
        
        foreach ( s_portal in a_structs )
        {
            var_7c170ceae0649b57 = [ #"teamselect", level.players[ 0 ] getentitynumber() ];
            portal = spawnscriptable( %"hash_5d65fbfa99c802c7", s_portal.origin, s_portal.angles, undefined, var_7c170ceae0649b57 );
            portal.angles = s_portal.angles;
            portal thread draw_sphere();
        }
    }

    // Namespace zm_sat_scarab_black_room
    // Params 0
    // Checksum 0xd2fe94f3, Offset: 0x12be
    // Size: 0x37, Type: dev
    function function_d478d6ebee646acf()
    {
        zone_manager::set_zone_enabled( "<dev string:x20b>", 1 );
        function_f57a6b92aa9b46e2( level.players[ 0 ] );
        level.players[ 0 ] thread function_f69a813c808d65c1();
    }

    // Namespace zm_sat_scarab_black_room
    // Params 1, eflags: 0x4
    // Checksum 0x220f8184, Offset: 0x12fd
    // Size: 0x1e, Type: dev
    function private function_fb7fc7dd9497b2a3( params )
    {
        level thread function_f63c60e3ae54013d( int( params[ 0 ] ) );
    }

#/

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x475cbf4a, Offset: 0x1323
// Size: 0x23
function private on_special_round_start( params )
{
    if ( utility::flag( "enter_boss_fight_go" ) )
    {
        return;
    }
    
    level thread spawn_portals();
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x27ec41b4, Offset: 0x134e
// Size: 0x20
function private on_special_round_end( params )
{
    level notify( #"black_room_round_ended" );
    level thread clear_all_portals();
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xccfda3fa, Offset: 0x1376
// Size: 0x3a7
function private spawn_portals()
{
    level endon( #"game_ended" );
    level endon( #"black_room_round_ended" );
    a_structs = utility::getstructarray( "black_room_portal", "targetname" );
    
    if ( a_structs.size < 3 )
    {
        return;
    }
    
    foreach ( s in a_structs )
    {
        if ( arraycontains( level.scarab_black_room.a_used_structs, s ) )
        {
            level.scarab_black_room.a_all_portals = function_a5c1175d3ea3c25a( level.scarab_black_room.a_all_portals, s );
        }
    }
    
    if ( level.scarab_black_room.a_all_portals.size == 0 )
    {
        zm_quest::function_4eefe6de31f5ddab( #"black_room", #"black_room_completed", 1 );
        level callback::remove( "special_round_start", &on_special_round_start );
        level callback::remove( "special_round_end", &on_special_round_end );
        return;
    }
    
    saved_index = zm_quest::function_73720cdf21c3cfd7( #"black_room", #"black_room_portal_index" );
    s_portal = level.scarab_black_room.a_all_portals[ saved_index ];
    
    if ( !isdefined( s_portal ) )
    {
        s_portal = utility::array_random( level.scarab_black_room.a_all_portals );
    }
    
    foreach ( player in level.players )
    {
        if ( is_eligible( player ) )
        {
            var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
            portal = spawnscriptable( %"hash_5d65fbfa99c802c7", s_portal.origin, s_portal.angles, undefined, var_7c170ceae0649b57 );
            level.scarab_black_room.var_e4d5f0bc6a97190c[ level.scarab_black_room.var_e4d5f0bc6a97190c.size ] = portal;
        }
    }
    
    wait 1;
    level.scarab_black_room.var_5489a0edbdfeebfc = s_portal;
    level.scarab_black_room.portal_interaction = zm_quest::function_91f9590e98d57ff6( level.scarab_black_room.var_5489a0edbdfeebfc.origin, &on_portal_interact, &function_140dd3355f68a2a5 );
    level.scarab_black_room.back_pos = utility::getstruct( s_portal.target, "targetname" );
    level.scarab_black_room.reward_pos = utility::getstruct( level.scarab_black_room.back_pos.target, "targetname" );
    
    /#
        level.scarab_black_room.var_5489a0edbdfeebfc thread draw_sphere();
        debug::function_9d6fee9cf5908ddc( "<dev string:x21a>" + portal.origin, ( 1, 0, 0 ), 5 );
    #/
}

// Namespace zm_sat_scarab_black_room
// Params 0
// Checksum 0x6ba2cf0a, Offset: 0x1725
// Size: 0x5e
function draw_sphere()
{
    self notify( #"hash_fe98da1d99eb2f9c" );
    self endon( #"hash_fe98da1d99eb2f9c" );
    level endon( #"game_ended" );
    level endon( #"hash_20bd483ea451a96c" );
    
    while ( true )
    {
        /#
            sphere( self.origin, 30, ( 1, 1, 0 ), 0, 1 );
        #/
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_black_room
// Params 2
// Checksum 0x27a66742, Offset: 0x178b
// Size: 0x3c
function function_140dd3355f68a2a5( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xff5ccf2c, Offset: 0x17d0
// Size: 0x128
function private clear_all_portals()
{
    level endon( #"game_ended" );
    wait 2;
    level notify( #"hash_20bd483ea451a96c" );
    
    if ( isdefined( level.scarab_black_room.var_e4d5f0bc6a97190c ) )
    {
        foreach ( s_portal in level.scarab_black_room.var_e4d5f0bc6a97190c )
        {
            s_portal utility::function_7c10ea82c1e305b8( "icon", "hide" );
            s_portal utility::function_7c10ea82c1e305b8( "effects", "close" );
            s_portal utility::delaycall( 5, &freescriptable );
        }
    }
    
    level.scarab_black_room.var_e4d5f0bc6a97190c = [];
    
    if ( isdefined( level.scarab_black_room.portal_interaction ) )
    {
        level.scarab_black_room.portal_interaction zm_quest::function_9170db4686f796e2();
    }
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0xe257103e, Offset: 0x1900
// Size: 0x160
function private on_portal_interact( player )
{
    if ( !is_eligible( player ) )
    {
        return;
    }
    
    level utility::flag_set( "black_room_in_use" );
    mark_visited( player );
    zm_quest::function_4eefe6de31f5ddab( #"black_room", hashcat( #"player_has_entered", string( player getentitynumber() ) ), 1 );
    level.scarab_black_room.a_used_structs[ level.scarab_black_room.a_used_structs.size ] = level.scarab_black_room.var_5489a0edbdfeebfc;
    
    foreach ( index, var_16af6624858ffa21 in level.scarab_black_room.a_all_portals )
    {
        if ( level.scarab_black_room.var_5489a0edbdfeebfc == var_16af6624858ffa21 )
        {
            zm_quest::function_4eefe6de31f5ddab( #"black_room", hashcat( #"black_room_portal_used", string( index ) ), 1 );
            break;
        }
    }
    
    level thread clear_all_portals();
    player thread function_9cac3e4899a0ff20();
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0xa1b3eaaa, Offset: 0x1a68
// Size: 0x81, Type: bool
function private is_eligible( player )
{
    if ( !zm_player::function_f37cfdf04b932a03( player, 0, 0 ) )
    {
        return false;
    }
    
    if ( level utility::flag( "black_room_in_use" ) )
    {
        return false;
    }
    
    if ( level utility::flag( "start_br_vote" ) )
    {
        return false;
    }
    
    if ( has_visited( player ) )
    {
        return false;
    }
    
    if ( utility::flag( "enter_boss_fight_go" ) )
    {
        return false;
    }
    
    if ( !is_zm_operator( player ) )
    {
        return false;
    }
    
    if ( player && player.interactions_disabled )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x3fe7e4d2, Offset: 0x1af2
// Size: 0x7a
function private is_zm_operator( player )
{
    zm_operator_list = [ "sat_rus_pl_weaver", "sat_gbr_pl_grey", "sat_usa_pl_carver", "sat_phl_pl_maya", "sat_ger_pl_purple", "sat_usa_pl_amber", "sat_jpn_pl_scarlet", "sat_rus_pl_magenta" ];
    playerref = player operator::getoperatorref();
    return arraycontains( zm_operator_list, playerref );
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0xee757ab, Offset: 0x1b75
// Size: 0x2c, Type: bool
function private has_visited( player )
{
    if ( arraycontains( level.scarab_black_room.a_visited, player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x15e79221, Offset: 0x1baa
// Size: 0x45
function private mark_visited( player )
{
    player utility::ent_flag_set( "black_room_visited" );
    level.scarab_black_room.a_visited[ level.scarab_black_room.a_visited.size ] = player;
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0x6219070f, Offset: 0x1bf7
// Size: 0xd3
function private function_9cac3e4899a0ff20()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    var_782fa2a2e40002da = level.players.size == 1;
    thread function_230bb3ab0db75d8e();
    function_3264af4e7a8e907a( self, 1 );
    zone_manager::set_zone_enabled( "zone_blackroom", 1 );
    function_f57a6b92aa9b46e2( self );
    level utility::flag_clear( "black_room_vo_finished" );
    thread function_f69a813c808d65c1();
    
    if ( var_782fa2a2e40002da )
    {
        zm_round_spawning::pause_round_spawning( 1, "black_room_solo_pause" );
    }
    
    thread watch_edge();
    level utility::flag_wait( "black_room_vo_finished" );
    wait 1;
    function_116348f02aa238a9( self, var_782fa2a2e40002da );
    function_3264af4e7a8e907a( self, undefined );
    wait 1;
    self notify( #"black_room_exit" );
    utility::ent_flag_clear( "black_room_visited" );
    zone_manager::set_zone_enabled( "zone_blackroom", 0 );
}

// Namespace zm_sat_scarab_black_room
// Params 2
// Checksum 0x59896638, Offset: 0x1cd2
// Size: 0x23
function function_3264af4e7a8e907a( enter_player, var_94d1ab5da995e573 )
{
    enter_player.var_b9a43612c09a3d01 = var_94d1ab5da995e573;
}

// Namespace zm_sat_scarab_black_room
// Params 0
// Checksum 0xcad0480b, Offset: 0x1cfd
// Size: 0x2a6
function function_f69a813c808d65c1()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    s_cage = utility::getstruct( "cage_fx_origin", "targetname" );
    sound_proxy = utility::spawn_model( "tag_origin", s_cage.origin );
    wait 2.5;
    
    if ( level.players.size > 1 )
    {
        if ( namespace_c0b4f2882c9d100f::is_grey() || namespace_c0b4f2882c9d100f::is_weaver() || namespace_c0b4f2882c9d100f::is_carver() || namespace_c0b4f2882c9d100f::is_maya() )
        {
            conversation_id = utility::array_random( [ "1", "2" ] );
            var_ada7a86ef7b67094 = #"hash_95f8673ca2336957";
            entity_aliases = conversation_id == "1" ? [ #"hash_d49e282d2932408c", #"hash_d49e2b2d293245a5", #"hash_d49e2a2d293243f2" ] : [ #"hash_43af5f48661a0915", #"hash_43af5c48661a03fc", #"hash_43af5d48661a05af", #"hash_43af5a48661a0096", #"hash_43af5b48661a0249" ];
            function_d334d02370add563( sound_proxy, entity_aliases );
            namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( hashcat( var_ada7a86ef7b67094, conversation_id ) );
        }
        else if ( namespace_c0b4f2882c9d100f::is_richtofen() || namespace_c0b4f2882c9d100f::is_dempsey() || namespace_c0b4f2882c9d100f::is_takeo() || namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            conversation_id = utility::array_random( [ "1", "2" ] );
            var_ada7a86ef7b67094 = #"hash_fcc54043b0b4f7f7";
            entity_aliases = conversation_id == "1" ? [ #"hash_9144a08dbff2fb83", #"hash_9144a18dbff2fd36", #"hash_9144a28dbff2fee9" ] : [ #"hash_e29edee3f8830351", #"hash_e29edbe3f882fe38", #"hash_e29edce3f882ffeb" ];
            function_d334d02370add563( sound_proxy, entity_aliases );
            namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( hashcat( var_ada7a86ef7b67094, conversation_id ) );
        }
        
        level utility::flag_set( "black_room_vo_finished" );
    }
    else
    {
        solo_id = utility::array_random( [ "1", "2" ] );
        base_name = function_6a1778cac7f264d0( solo_id );
        new_base_name = hashcat( base_name, "_line_" );
        
        if ( isdefined( new_base_name ) )
        {
            level function_7d8f3e7c1f648343( new_base_name, self, sound_proxy );
        }
    }
    
    sound_proxy utility::delaycall( 1, &delete );
}

// Namespace zm_sat_scarab_black_room
// Params 2, eflags: 0x4
// Checksum 0x963a27e1, Offset: 0x1fab
// Size: 0xc6
function private function_d334d02370add563( sound_proxy, aliases )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( aliases ) || aliases.size == 0 )
    {
        return;
    }
    
    foreach ( alias in aliases )
    {
        self playsoundtoplayer( alias, self, sound_proxy );
        wait_time = utility::function_6f5d2e1f1ff70482( lookupsoundlength( alias ) );
        
        if ( wait_time > 0 )
        {
            wait wait_time;
        }
    }
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0xc2fd25ca, Offset: 0x2079
// Size: 0xd4
function private function_6a1778cac7f264d0( solo_id )
{
    if ( namespace_c0b4f2882c9d100f::is_carver() )
    {
        return hashcat( #"hash_8ba6322eaaf150eb", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_grey() )
    {
        return hashcat( #"hash_788d3d6b0605698b", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_maya() )
    {
        return hashcat( #"hash_a8b83cdafdffebbe", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_weaver() )
    {
        return hashcat( #"hash_231b2b0c3848a1d6", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_dempsey() )
    {
        return hashcat( #"hash_393cdb8a6856d927", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_nikolai() )
    {
        return hashcat( #"hash_f47b269c1c6850d9", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_richtofen() )
    {
        return hashcat( #"hash_8382445486871d54", solo_id );
    }
    
    if ( namespace_c0b4f2882c9d100f::is_takeo() )
    {
        return hashcat( #"hash_99ddb3d1740a67f0", solo_id );
    }
}

// Namespace zm_sat_scarab_black_room
// Params 3, eflags: 0x4
// Checksum 0x342e275f, Offset: 0x2156
// Size: 0x11d
function private function_7d8f3e7c1f648343( base_name, player, sound_proxy )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    for ( i = 1; i < 15 ; i++ )
    {
        local_base_name = hashcat( base_name, string( i ) );
        b_played_vo_event = 0;
        b_played_banter = 0;
        event = level.overlord.events[ local_base_name ];
        
        if ( isdefined( event ) )
        {
            alias = event.alias;
            timeout = event.timeout;
            player playsoundtoplayer( alias, player, sound_proxy );
            
            if ( isdefined( timeout ) && timeout > 0 )
            {
                wait timeout;
            }
            
            b_played_vo_event = 1;
        }
        
        if ( player_banter::function_59ab3c2fe1424d34( local_base_name ) )
        {
            b_played_banter = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( local_base_name );
        }
        
        if ( !b_played_vo_event && !b_played_banter )
        {
            break;
        }
    }
    
    level utility::flag_set( "black_room_vo_finished" );
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x8bc72aac, Offset: 0x227b
// Size: 0x20b
function private function_f57a6b92aa9b46e2( player )
{
    s_spawn = utility::getstruct( "black_room_player_transport", "targetname" );
    
    if ( isdefined( s_spawn ) )
    {
        v_origin = s_spawn.origin;
        v_angles = s_spawn.angles;
    }
    else
    {
        v_origin = ( 0, 0, 0 );
        v_angles = ( 0, 0, 0 );
    }
    
    player setadditionalstreamposuntilcleared( v_origin );
    
    if ( isdefined( level.var_a009ab14ee0d3223 ) && isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ zm_utility::get_round_number() ] ) )
    {
        player setsoundsubmix( "mute_music", 0 );
        musicbank_utility::function_4f253fd35ec68cbc( [ player ], #"specialround_loop" );
    }
    
    playsoundatpos( player.origin, #"hash_165d13d526eca172" );
    playfxontagforclients( level._effect[ "black_room_teleport_in_fx" ], player, "j_head", player );
    wait 0.6;
    utility::fadetoblackforplayer( player, 1, 0.3 );
    playfx( level._effect[ "black_room_teleport_3p_fx" ], player.origin );
    playworldsound( player.origin + ( 0, 0, 75 ), #"hash_1084c5d54855b552" );
    
    if ( level.scarab_black_room )
    {
        level.scarab_black_room.var_79a994f71634121e = player.origin;
        level.scarab_black_room.var_6eea71706e2126b4 = player.angles;
    }
    
    player utility::ent_flag_wait( "black_room_ready_to_teleport" );
    wait 0.1;
    zm_player::teleport_player( player, v_origin, v_angles, 0, 0 );
    wait 0.6;
    stopfxontagforclients( level._effect[ "black_room_teleport_in_fx" ], player, "j_head", player );
    level thread utility::fadetoblackforplayer( player, 0, 0.3 );
    player clearadditionalstreampos();
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0x50f1bd5b, Offset: 0x248e
// Size: 0x745
function private function_230bb3ab0db75d8e()
{
    self endon( #"disconnect" );
    player = self;
    self.var_ecdde94b952193a8 = 1;
    
    if ( self getcamerathirdperson() )
    {
        self setcamerathirdperson( 0 );
    }
    
    val::set( "black_room", "sprint", 0 );
    val::set( "black_room", "supersprint", 0 );
    val::set( "black_room", "jog", 0 );
    val::set( "black_room", "allow_jump", 0 );
    val::set( "black_room", "allow_double_jump", 0 );
    val::set( "black_room", "doublejump", 0 );
    val::set( "black_room", "slide", 0 );
    val::set( "black_room", "mantle", 0 );
    val::set( "black_room", "crouch", 0 );
    val::set( "black_room", "prone", 0 );
    val::set( "black_room", "allow_toggle_third_person", 0 );
    val::set( "black_room", "weapon", 0 );
    val::set( "black_room", "fire", 0 );
    val::set( "black_room", "equipment_primary", 0 );
    val::set( "black_room", "equipment_secondary", 0 );
    val::set( "black_room", "supers", 0 );
    val::set( "black_room", "super_switching", 0 );
    val::set( "black_room", "action_slot_weapon", 0 );
    
    if ( hasomnvar( "ui_block_fu_not_ready_error" ) )
    {
        self setclientomnvar( "ui_block_fu_not_ready_error", 1 );
    }
    
    val::set( "black_room", "allow_teleport", 0 );
    val::set( "black_room", "damage", 0 );
    val::set( "black_room", "allow_ping", 0 );
    val::set( "black_room", "show_hud", 0 );
    val::set( "black_room", "show_compass", 0 );
    val::set( "black_room", "allow_battlechatter_vo", 0 );
    var_a9097ba58fc22ff4 = self.var_e1e23a6d9f1887af;
    self.var_e1e23a6d9f1887af = 1;
    player::hideminimap( 1 );
    self setclientomnvar( "ui_scoreboard_enabled", 0 );
    self sethidenameplate( 1 );
    self function_66dc8b6ae969f66d( 1 );
    self filteroutplayermarks( self.team );
    self notify( #"end_tesla_storm_buff" );
    self notify( #"end_tesla_storm" );
    utility::function_32b24db3127bff40( "tesla_storm_static_discharge_fx", "super_fx_off" );
    utility::function_32b24db3127bff40( "tesla_storm_shockwave_fx", "super_fx_off" );
    utility::function_32b24db3127bff40( "tesla_storm_teammate_fx", "super_fx_off" );
    utility::function_32b24db3127bff40( "tesla_storm_source_fx", "super_fx_off" );
    utility::function_32b24db3127bff40( "tesla_storm_transformer_fx", "super_fx_off" );
    
    if ( isdefined( self.var_fba2acdd44267d9f ) )
    {
        self.var_fba2acdd44267d9f delete();
        self.var_fba2acdd44267d9f = undefined;
    }
    
    thread function_8c87470debd8e333();
    
    if ( isdefined( self.wiley_fox_settings ) )
    {
        self.wiley_fox_settings.active = undefined;
    }
    
    utility::function_7c10ea82c1e305b8( "wiley_fox_fx", "super_fx_off" );
    thread function_1872a6887659bbe8();
    self.var_14237761a6491554 = "super_fx_off";
    self setscriptablepartstate( "healing_aura_fx", "super_fx_off", 0 );
    
    if ( self getscriptablehaspart( "ncfd_pedestal_charge" ) && self.var_819dfee5ff9a56d6 )
    {
        self setscriptablepartstate( "ncfd_pedestal_charge", "off" );
    }
    
    if ( level utility::flag( "its_raining" ) )
    {
        if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_efe074ec11372361" ) )
        {
            utility::callsharedfunc( #"scarab_rain", #"hash_efe074ec11372361" );
        }
    }
    
    zm_round_spawning::function_4ac257955c0b5c16( 0 );
    
    if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        thread zm_round_spawning::function_4ac257955c0b5c16( 0 );
        function_ad915db840c90fb3( 384, 1, 0, undefined, self );
    }
    
    if ( !level callback::exists( "special_round_start", &function_3a4e0577256672fb ) )
    {
        level callback::add( "special_round_start", &function_3a4e0577256672fb );
    }
    
    utility::ent_flag_set( "black_room_ready_to_teleport" );
    self waittill( #"black_room_exit" );
    val::reset( "black_room", "sprint" );
    val::reset( "black_room", "supersprint" );
    val::reset( "black_room", "jog" );
    val::reset( "black_room", "allow_jump" );
    val::reset( "black_room", "allow_double_jump" );
    val::reset( "black_room", "doublejump" );
    val::reset( "black_room", "slide" );
    val::reset( "black_room", "mantle" );
    val::reset( "black_room", "crouch" );
    val::reset( "black_room", "prone" );
    val::reset( "black_room", "equipment_primary" );
    val::reset( "black_room", "equipment_secondary" );
    val::reset( "black_room", "supers" );
    val::reset( "black_room", "super_switching" );
    val::reset( "black_room", "action_slot_weapon" );
    val::reset( "black_room", "allow_teleport" );
    val::reset( "black_room", "allow_ping" );
    val::reset( "black_room", "damage" );
    val::reset( "black_room", "show_hud" );
    val::reset( "black_room", "show_compass" );
    val::reset( "black_room", "allow_battlechatter_vo" );
    val::reset( "black_room", "tacmap_scoreboard" );
    val::reset( "black_room", "allow_toggle_third_person" );
    
    if ( hasomnvar( "ui_block_fu_not_ready_error" ) )
    {
        self setclientomnvar( "ui_block_fu_not_ready_error", 0 );
    }
    
    self.var_e1e23a6d9f1887af = var_a9097ba58fc22ff4;
    self.var_ecdde94b952193a8 = 0;
    self setclientomnvar( "ui_scoreboard_enabled", 1 );
    player::showminimap();
    self.var_14237761a6491554 = undefined;
    val::reset( "black_room", "weapon" );
    val::reset( "black_room", "fire" );
    self sethidenameplate( 0 );
    self function_66dc8b6ae969f66d( 0 );
    self filteroutplayermarks( undefined );
    self clearsoundsubmix( "mute_music", 0 );
    
    if ( level callback::exists( "special_round_start", &function_3a4e0577256672fb ) )
    {
        level callback::remove( "special_round_start", &function_3a4e0577256672fb );
    }
    
    if ( isalive( self ) )
    {
        if ( level.players.size == 1 )
        {
            level thread function_d7b9e2c3bad5273b();
            
            if ( level utility::flag( "its_raining" ) )
            {
                if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
                {
                    utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
                }
            }
        }
        else
        {
            if ( zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
            {
                thread zm_round_spawning::function_4ac257955c0b5c16( 1 );
                var_3d56c20afd849383 = function_46d860b15a4a1ecd();
                function_ad915db840c90fb3( 384, var_3d56c20afd849383, 0, undefined, self );
            }
            
            if ( level utility::flag( "its_raining" ) )
            {
                if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
                {
                    utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
                }
            }
        }
    }
    
    utility::ent_flag_clear( "black_room_ready_to_teleport" );
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x8e623c30, Offset: 0x2bdb
// Size: 0xdb
function private function_3a4e0577256672fb( params )
{
    waitframe();
    
    foreach ( player in level.players )
    {
        if ( player.var_ecdde94b952193a8 )
        {
            if ( level utility::flag( "its_raining" ) )
            {
                if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_efe074ec11372361" ) )
                {
                    player utility::callsharedfunc( #"scarab_rain", #"hash_efe074ec11372361" );
                }
            }
            
            player zm_round_spawning::function_4ac257955c0b5c16( 0 );
        }
    }
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xd30bec05, Offset: 0x2cbe
// Size: 0xb5
function private function_8c87470debd8e333()
{
    self endon( #"disconnect" );
    self endon( #"black_room_exit" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self notify( #"end_tesla_storm_buff" );
        utility::function_32b24db3127bff40( "tesla_storm_static_discharge_fx", "super_fx_off" );
        utility::function_32b24db3127bff40( "tesla_storm_shockwave_fx", "super_fx_off" );
        utility::function_32b24db3127bff40( "tesla_storm_teammate_fx", "super_fx_off" );
        utility::function_32b24db3127bff40( "tesla_storm_source_fx", "super_fx_off" );
        utility::function_32b24db3127bff40( "tesla_storm_transformer_fx", "super_fx_off" );
        
        if ( isdefined( self.var_fba2acdd44267d9f ) )
        {
            self.var_fba2acdd44267d9f delete();
            self.var_fba2acdd44267d9f = undefined;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xecc6fc80, Offset: 0x2d7b
// Size: 0x40
function private function_1872a6887659bbe8()
{
    self endon( #"disconnect" );
    self endon( #"black_room_exit" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::function_7c10ea82c1e305b8( "wiley_fox_fx", "super_fx_off" );
        waitframe();
    }
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xf3119605, Offset: 0x2dc3
// Size: 0x5b
function private function_d7b9e2c3bad5273b()
{
    var_c06a497974aaca99 = level.zm_mode_modifiers.var_a56fc07f056a7549;
    level.zm_mode_modifiers.var_a56fc07f056a7549 = 1;
    zm_utility::util_kill_all_zombies();
    zm_round_logic::function_895fdc21ab019efe();
    level.zm_mode_modifiers.var_a56fc07f056a7549 = var_c06a497974aaca99;
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xe260abd5, Offset: 0x2e26
// Size: 0xcc
function private function_46d860b15a4a1ecd()
{
    if ( isdefined( level.zm_lighting_setting ) && isdefined( level.zm_lighting_setting.var_2f782dd2cca16291 ) )
    {
        foreach ( info in level.zm_lighting_setting.var_2f782dd2cca16291 )
        {
            if ( info.var_7e4e710386ab5934 && isdefined( info.var_756ca0d63c9bc9df ) )
            {
                return info.var_756ca0d63c9bc9df;
            }
        }
    }
    
    return 1;
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0xaa868157, Offset: 0x2efb
// Size: 0xe2
function private watch_edge()
{
    self endon( #"disconnect" );
    s_center = utility::getstruct( "black_room_center", "targetname" );
    var_dac75f4116c98678 = s_center.origin;
    
    for ( var_abcd3eff7c097ffc = 0; true ; var_abcd3eff7c097ffc = 0 )
    {
        if ( utility::waittill_any_timeout( 0.1, "black_room_exit" ) == "black_room_exit" )
        {
            break;
        }
        
        var_b6081b1b6ba5e8b5 = distance2d( self.origin, var_dac75f4116c98678 );
        
        if ( var_b6081b1b6ba5e8b5 >= 300 )
        {
            if ( !var_abcd3eff7c097ffc )
            {
                val::set( "black_room_edge", "move_speed_scale", 0.3 );
                var_abcd3eff7c097ffc = 1;
            }
            
            continue;
        }
        
        if ( var_abcd3eff7c097ffc )
        {
            val::reset( "black_room_edge", "move_speed_scale" );
        }
    }
    
    if ( var_abcd3eff7c097ffc )
    {
        val::reset( "black_room_edge", "move_speed_scale" );
    }
}

// Namespace zm_sat_scarab_black_room
// Params 2, eflags: 0x4
// Checksum 0x61cf045, Offset: 0x2fe5
// Size: 0x214
function private function_116348f02aa238a9( player, var_782fa2a2e40002da )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player ) )
    {
        level utility::flag_clear( "black_room_in_use" );
        return;
    }
    
    teleport_back_pos = level.scarab_black_room.back_pos;
    v_origin = teleport_back_pos.origin;
    v_angles = teleport_back_pos.angles ?? ( 0, 0, 0 );
    player setadditionalstreamposuntilcleared( teleport_back_pos.origin );
    s_cage = utility::getstruct( "cage_fx_origin", "targetname" );
    playfx( level._effect[ "black_room_cage_beam" ], s_cage.origin );
    playfxontagforclients( level._effect[ "black_room_teleport_fx" ], player, "j_head", player );
    player playlocalsound( #"hash_f9bad78273f71678" );
    wait 5;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    utility::fadetoblackforplayer( player, 1, 0.3 );
    stopfxontagforclients( level._effect[ "black_room_teleport_fx" ], player, "j_head", player );
    player playsoundtoplayer( #"hash_1fcabd3140b32dab", player );
    wait 0.6;
    zm_player::teleport_player( player, v_origin, v_angles, 0, 20 );
    playfx( level._effect[ "black_room_teleport_3p_fx" ], player.origin );
    playworldsound( player.origin + ( 0, 0, 75 ), #"hash_1084c5d54855b552" );
    wait 0.6;
    level thread utility::fadetoblackforplayer( player, 0, 0.3 );
    player clearadditionalstreampos();
    player playsoundtoplayer( "evt_success_stinger", player );
    
    if ( var_782fa2a2e40002da )
    {
        zm_round_spawning::pause_round_spawning( 0, "black_room_solo_pause" );
        player thread function_3fdb70252177e625();
    }
    
    player thread function_8bcb7582e3d498d7();
    level utility::flag_clear( "black_room_in_use" );
}

// Namespace zm_sat_scarab_black_room
// Params 0, eflags: 0x4
// Checksum 0x76661aba, Offset: 0x3201
// Size: 0x44
function private function_3fdb70252177e625()
{
    self endon( #"disconnect" );
    wait 1;
    
    if ( !isdefined( v_pos ) )
    {
        v_pos = self.origin;
    }
    
    level powerups::powerup_drop( "full_ammo", v_pos, undefined, undefined, "quest" );
}

// Namespace zm_sat_scarab_black_room
// Params 1, eflags: 0x4
// Checksum 0x7ce242fe, Offset: 0x324d
// Size: 0xe5
function private function_8bcb7582e3d498d7( v_pos_override = undefined )
{
    self endon( #"disconnect" );
    
    if ( isdefined( v_pos_override ) )
    {
        v_pos = v_pos_override;
    }
    
    if ( !isdefined( v_pos ) )
    {
        v_pos = level.scarab_black_room.reward_pos.origin;
    }
    
    n_round = zm_round_logic::get_rb_round_number();
    
    if ( n_round <= 10 )
    {
        var_d9906d678f78a3fa = %"hash_177df22075e8c456";
    }
    else if ( n_round <= 20 )
    {
        var_d9906d678f78a3fa = %"hash_177df12075e8c2a3";
    }
    else if ( n_round <= 30 )
    {
        var_d9906d678f78a3fa = %"hash_177df02075e8c0f0";
    }
    else
    {
        var_d9906d678f78a3fa = %"hash_177df72075e8ccd5";
    }
    
    if ( !isdefined( var_d9906d678f78a3fa ) )
    {
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( v_pos );
    level common_item::function_38cde6a6acb68ea6( var_d9906d678f78a3fa, 9, spawnoptions );
}

