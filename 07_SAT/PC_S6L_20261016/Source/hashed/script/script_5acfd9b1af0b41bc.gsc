// script_5acfd9b1af0b41bc  (hash_5acfd9b1af0b41bc.gscc) (size: 15730 Bytes / 0x3d72 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6136eddf (1630989791)
// size ...... 15730 (0x3d72)
// includes .. 20  (offset: 0x38aa)
// strings ... 54  (offset: 0x394a)
// dev strs .. 3   (offset: 0x3d46)
// exports ... 27  (offset: 0x2686)
// cseg ...... 0x3ae + 0x22d8 (0x2686)
// imports ... 110 (offset: 0x2abe)
// animtree1 . 0   (offset: 0x3d72)
// animtree2 . 0   (offset: 0x3d72)
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\bots\bots_util;
#using scripts\mp\challenges;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\gameobjects\gameobjects_carryobject;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\stats;
#using scripts\mp\gamelogic;
#using scripts\mp\matchdata;
#using scripts\mp\persistence;
#using scripts\mp\supers;

#namespace bombzone;

// Namespace bombzone
// Params 1
// Checksum 0x859fe8de, Offset: 0x3cc
// Size: 0x71
function initialize_bomb( game_object )
{
    game_object.var_880969b651c101f5 = 1;
    game_object callback::add( #"hash_dff7cb7b68f75deb", &function_18154bde508ebf1 );
    game_object callback::function_dc654a4d4126a928( #"hash_249e26f937238db4", #"hash_6947ec89a1af6d69", &function_a18e13deea15aed5 );
    game_object callback::function_dc654a4d4126a928( #"hash_a21546ba725310a2", #"hash_6947ec89a1af6d69", &function_6b77081f85d6fc4f );
}

// Namespace bombzone
// Params 6
// Checksum 0x11cf2fa4, Offset: 0x445
// Size: 0x1d6
function initialize_bombzone( var_1b55994025b9dc25, var_85c26a6c91c38374, bomb_game_object, plant_weapon_name, defuse_weapon_name, var_8500c612eb90b969 )
{
    if ( isdefined( plant_weapon_name ) )
    {
        var_1b55994025b9dc25.use_weapon = makeweapon( plant_weapon_name );
    }
    
    if ( isdefined( defuse_weapon_name ) )
    {
        var_85c26a6c91c38374.use_weapon = makeweapon( defuse_weapon_name );
    }
    
    var_e22533de8de4b991 = { #var_8500c612eb90b969:var_8500c612eb90b969, #bomb_game_object:bomb_game_object, #var_85c26a6c91c38374:var_85c26a6c91c38374 };
    var_6312eb03276fb85c = { #bomb_game_object:bomb_game_object, #var_1b55994025b9dc25:var_1b55994025b9dc25 };
    var_1b55994025b9dc25 callback::add( #"hash_dff7cb7b68f75deb", &function_b5c4b1793b7cc323, { #bomb_game_object:bomb_game_object } );
    var_1b55994025b9dc25 callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_7c20aab2ec5f2811, var_e22533de8de4b991 );
    var_1b55994025b9dc25 callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_1e8a7690b1868637, var_e22533de8de4b991 );
    var_1b55994025b9dc25 callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_fa139c314133965a, var_e22533de8de4b991 );
    var_85c26a6c91c38374 callback::add( #"hash_dff7cb7b68f75deb", &function_b5c4b1793b7cc323 );
    var_85c26a6c91c38374 callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_c4df9a9fe4a9e334, var_6312eb03276fb85c );
    var_85c26a6c91c38374 callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_f4676fcda3269a4a, var_6312eb03276fb85c );
    var_85c26a6c91c38374 callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_6d8dc2eb44bb6b8d, var_6312eb03276fb85c );
    var_1b55994025b9dc25 thread setupkillcament( var_1b55994025b9dc25 );
    
    /#
        gameobjects_common::function_579ac2f7e66ed64f( var_85c26a6c91c38374, 1 );
    #/
}

// Namespace bombzone
// Params 1
// Checksum 0x88c2b813, Offset: 0x623
// Size: 0x23, Type: bool
function get_bomb_timer( game_object )
{
    return game_object.var_ccd5594a8890e558 ?? level.bombtimer;
}

// Namespace bombzone
// Params 4
// Checksum 0xdc488e1f, Offset: 0x64f
// Size: 0xa5
function force_plant_bomb( var_1b55994025b9dc25, player, var_2b03add3a518dea6, dropposition )
{
    if ( var_1b55994025b9dc25.bombplanted )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    params = {};
    params.var_dbd0d4c325a7ae15 = player;
    params.var_2b03add3a518dea6 = var_2b03add3a518dea6 ?? [];
    params.force_planted = 1;
    params.bomb_drop_position = dropposition;
    gameobjects_common::queue_callback( var_1b55994025b9dc25, #"hash_a1e02ee2cc2ad28e", params, 1 );
}

// Namespace bombzone
// Params 3
// Checksum 0x91155a1e, Offset: 0x6fc
// Size: 0x81
function force_defuse_bomb( var_85c26a6c91c38374, player, var_2b03add3a518dea6 )
{
    if ( !var_85c26a6c91c38374.bombplanted )
    {
        assertmsg( "<dev string:x40>" );
        return;
    }
    
    params = {};
    params.var_dbd0d4c325a7ae15 = player;
    params.var_2b03add3a518dea6 = var_2b03add3a518dea6 ?? [];
    gameobjects_common::queue_callback( var_85c26a6c91c38374, #"hash_a1e02ee2cc2ad28e", params, 1 );
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0xcdead4e1, Offset: 0x785
// Size: 0x1c2
function private function_f38d458fde45a232( player, enable )
{
    if ( enable )
    {
        player val::set( "bombzone", "gesture", 1 );
        player val::set( "bombzone", "allow_jump", 1 );
        player val::set( "bombzone", "allow_movement", 1 );
        current_weapon = player getcurrentweapon();
        
        if ( isdefined( current_weapon ) && current_weapon.basename == level.gametypebundle.bombplantweapon )
        {
            player thread utility::call_on_notify( "bomb_allow_offhands", &val::reset_all, "bombzone" );
            return;
        }
        
        player val::reset_all( "bombzone" );
        return;
    }
    
    player val::set( "bombzone", "ads", 0 );
    player val::set( "bombzone", "equipment_primary", 0 );
    player val::set( "bombzone", "equipment_secondary", 0 );
    player val::set( "bombzone", "gesture", 0 );
    player val::set( "bombzone", "allow_jump", 0 );
    player val::set( "bombzone", "mantle", 0 );
    player val::set( "bombzone", "melee", 0 );
    player val::set( "bombzone", "allow_movement", 0 );
    player val::set( "bombzone", "offhand_weapons", 0 );
    player val::set( "bombzone", "slide", 0 );
    player val::set( "bombzone", "sprint", 0 );
    player val::set( "bombzone", "supers", 0 );
    player val::set( "bombzone", "fire", 0 );
}

// Namespace bombzone
// Params 1, eflags: 0x4
// Checksum 0x566d28db, Offset: 0x94f
// Size: 0x11c
function private function_a18e13deea15aed5( params )
{
    game_object = params.game_object;
    player = params.player;
    level notify( #"bomb_picked_up", player );
    game_object notify( #"bomb_picked_up", player );
    player.isbombcarrier = 1;
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
    
    telemetry_data = {};
    telemetry_data.player = player;
    telemetry_data.eventname = "pickup";
    telemetry_data.position = player.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    player dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 1, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    setomnvar( "ui_bomb_carrier", player getentitynumber() );
}

// Namespace bombzone
// Params 1, eflags: 0x4
// Checksum 0x7249f969, Offset: 0xa73
// Size: 0x149
function private function_6b77081f85d6fc4f( params )
{
    game_object = params.game_object;
    player = params.player;
    level notify( #"bomb_dropped", player );
    game_object notify( #"bomb_dropped", player );
    player.isbombcarrier = undefined;
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 0 );
    }
    
    if ( level.bombplanted )
    {
        gameobjects_common::deactivate( game_object );
    }
    else
    {
        match_time_ms = matchdata::function_47550968a937b67e( gettime() );
        player dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 0, "match_time_ms", match_time_ms ] );
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "key", "bomb", "match_time_ms", match_time_ms ] );
    }
    
    setomnvar( "ui_bomb_carrier", -1 );
}

// Namespace bombzone
// Params 1, eflags: 0x4
// Checksum 0xdea37e63, Offset: 0xbc4
// Size: 0x16, Type: bool
function private function_18154bde508ebf1( params )
{
    return !level.bombplanted;
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0xe471c11f, Offset: 0xbe3
// Size: 0x126, Type: bool
function private function_b5c4b1793b7cc323( params, additional_params )
{
    bombzone_game_object = params.game_object;
    player = params.player;
    bomb_game_object = additional_params.bomb_game_object;
    
    if ( player isdiving() )
    {
        return false;
    }
    
    if ( player::isinlaststand( player ) )
    {
        return false;
    }
    
    if ( isdefined( bombzone_game_object.using_player_weapon ) )
    {
        if ( player inventory_utility::isswitchingtoweaponwithmonitoring( bombzone_game_object.using_player_weapon ) )
        {
            return false;
        }
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    if ( isdefined( bomb_game_object ) && !gameobjects_carryobject::is_carrier( bomb_game_object, player ) )
    {
        return false;
    }
    
    if ( gameobjects_common::get_type_hash( bombzone_game_object ) == #"gameobject_type_use_object" )
    {
        up_vector = anglestoup( gameobjects_common::function_63e25df7cfbb206f( bombzone_game_object ) );
        var_c51215b779b5fe59 = player.origin - gameobjects_common::get_origin( bombzone_game_object );
        dot_product = vectordot( vectornormalize( up_vector ), vectornormalize( var_c51215b779b5fe59 ) );
        return ( dot_product <= 0.5 );
    }
    
    return true;
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x4bf1fa4b, Offset: 0xd12
// Size: 0x112
function private function_8240bb5a55fc47eb( game_object, player )
{
    player notify( #"hash_b104d266cdc3b33b" );
    
    if ( isdefined( game_object.use_weapon ) )
    {
        function_f38d458fde45a232( player, 0 );
    }
    
    if ( player issprintsliding() )
    {
        player setstance( "crouch" );
    }
    
    if ( isdefined( game_object.use_weapon ) )
    {
        if ( utility::issharedfuncdefined( #"hash_e8cc48aecfa87408", #"hash_3ab480e745ec15f3" ) )
        {
            player utility::callsharedfunc( #"hash_e8cc48aecfa87408", #"hash_3ab480e745ec15f3" );
        }
        
        game_object.using_player_weapon = player getcurrentweapon();
        player giveweapon( game_object.use_weapon );
        player setweaponammostock( game_object.use_weapon, 1 );
        player setweaponammoclip( game_object.use_weapon, 1 );
        thread function_3534179e566f70d0( player, game_object.use_weapon, 0 );
        callback::callback( #"hash_89e109eb26a160ed", { #player:player } );
    }
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x3bfc04dd, Offset: 0xe2c
// Size: 0x64
function private function_7c20aab2ec5f2811( params, additional_params )
{
    var_1b55994025b9dc25 = params.game_object;
    player = params.player;
    function_8240bb5a55fc47eb( var_1b55994025b9dc25, player );
    thread function_b87bf4629312aedd( player, 1 );
    player bots_util_mp::notify_enemy_bots_bomb_used( "plant" );
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x1ce87da, Offset: 0xe98
// Size: 0x78
function private function_c4df9a9fe4a9e334( params, additional_params )
{
    var_85c26a6c91c38374 = params.game_object;
    player = params.player;
    function_8240bb5a55fc47eb( var_85c26a6c91c38374, player );
    thread function_b87bf4629312aedd( player, 0 );
    player bots_util_mp::notify_enemy_bots_bomb_used( "defuse" );
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x93085483, Offset: 0xf18
// Size: 0xbb
function private function_513bf848e8ce6ed1( game_object, player )
{
    player notify( #"bombzone_stop_use" );
    
    if ( isdefined( game_object.use_weapon ) )
    {
        function_f38d458fde45a232( player, 1 );
    }
    
    if ( isdefined( game_object.using_player_weapon ) )
    {
        player supers_mp::unstowsuperweapon();
        
        if ( player inventory_utility::isswitchingtoweaponwithmonitoring( game_object.use_weapon ) )
        {
            player inventory_utility::abortmonitoredweaponswitch( game_object.use_weapon );
            player inventory_utility::_switchtoweaponimmediate( game_object.using_player_weapon );
        }
        else
        {
            thread function_1db698f2d87aac( player, game_object );
        }
        
        callback::callback( #"hash_2a6553431436974f", { #player:player } );
    }
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x45c0d298, Offset: 0xfdb
// Size: 0x4b
function private function_1e8a7690b1868637( params, additional_params )
{
    var_1b55994025b9dc25 = params.game_object;
    player = params.player;
    function_513bf848e8ce6ed1( var_1b55994025b9dc25, player );
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0xd42421b4, Offset: 0x102e
// Size: 0x5f
function private function_f4676fcda3269a4a( params, additional_params )
{
    var_85c26a6c91c38374 = params.game_object;
    player = params.player;
    function_513bf848e8ce6ed1( var_85c26a6c91c38374, player );
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 0 );
    }
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x26171257, Offset: 0x1095
// Size: 0x57b
function private function_fa139c314133965a( params, additional_params )
{
    var_1b55994025b9dc25 = params.game_object;
    var_dbd0d4c325a7ae15 = params.var_dbd0d4c325a7ae15;
    instance_id = params.instance_id;
    var_85c26a6c91c38374 = additional_params.var_85c26a6c91c38374;
    bomb_game_object = additional_params.bomb_game_object;
    var_8500c612eb90b969 = additional_params.var_8500c612eb90b969;
    force_planted = params.force_planted;
    level notify( #"bomb_planted", var_1b55994025b9dc25, var_85c26a6c91c38374 );
    var_dbd0d4c325a7ae15 notify( #"bomb_planted", var_1b55994025b9dc25, var_85c26a6c91c38374 );
    var_1b55994025b9dc25 notify( #"bomb_planted" );
    var_85c26a6c91c38374 notify( #"bomb_planted" );
    level.bombplanted = 1;
    level.bombdefused = undefined;
    level.bombowner = var_dbd0d4c325a7ae15;
    
    if ( !isdefined( level.bombsplanted ) )
    {
        level.bombsplanted = 0;
    }
    
    level.bombsplanted++;
    var_5948d1b3a0d687f2 = var_dbd0d4c325a7ae15.team == "all" || var_dbd0d4c325a7ae15.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( var_dbd0d4c325a7ae15.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( var_dbd0d4c325a7ae15.team ) ? #"hash_ce911e3bbe99421f" : var_dbd0d4c325a7ae15.team == "none" || var_dbd0d4c325a7ae15.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( !isdefined( level.var_a4c1420a2120df87 ) )
    {
        level.var_a4c1420a2120df87 = [];
    }
    
    level.var_a4c1420a2120df87[ var_5948d1b3a0d687f2 ] = 1;
    var_1b55994025b9dc25.bombplanted = 1;
    var_85c26a6c91c38374.bombplanted = 1;
    var_dbd0d4c325a7ae15.bombplantedtime = gettime();
    thread function_10d98da5a9885fd5( var_1b55994025b9dc25, var_85c26a6c91c38374, bomb_game_object, var_dbd0d4c325a7ae15, instance_id );
    
    if ( isdefined( bomb_game_object ) )
    {
        if ( params.bomb_drop_position )
        {
            bomb_drop_position = params.bomb_drop_position;
        }
        else
        {
            bomb_drop_position = utility::drop_to_ground( var_dbd0d4c325a7ae15.origin, 64, -1024 );
        }
        
        gameobjects_carryobject::function_f20efc740638f6f1( bomb_game_object, bomb_drop_position );
        
        /#
            gameobjects_common::function_579ac2f7e66ed64f( bomb_game_object, 1 );
        #/
    }
    
    if ( !var_8500c612eb90b969 )
    {
        thread function_fcbc7809e62f7079( var_85c26a6c91c38374, bomb_game_object, var_dbd0d4c325a7ae15 );
    }
    
    var_1b55994025b9dc25.ticking_object = spawn( "script_origin", gameobjects_common::get_origin( var_85c26a6c91c38374 ) );
    var_85c26a6c91c38374.ticking_object = var_1b55994025b9dc25.ticking_object;
    var_1b55994025b9dc25.ticking_object thread gamelogic_mp::playtickingsound( var_1b55994025b9dc25.var_ccd5594a8890e558 ?? level.bombtimer );
    gameobjects_common::deactivate( var_1b55994025b9dc25 );
    gameobjects_common::activate( var_85c26a6c91c38374 );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_dbd0d4c325a7ae15 ) ) )
    {
        if ( isdefined( var_dbd0d4c325a7ae15.leaderboarddata[ "plants" ] ) )
        {
            var_dbd0d4c325a7ae15.leaderboarddata[ "plants" ] = var_dbd0d4c325a7ae15.leaderboarddata[ "plants" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "plants" ] ) )
        {
            [[ level.leaderboardfunc[ "plants" ] ]]( var_dbd0d4c325a7ae15, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x58>" );
        
        if ( isdefined( var_dbd0d4c325a7ae15.pers[ "plants" ] ) )
        {
            var_dbd0d4c325a7ae15.pers[ "plants" ] = var_dbd0d4c325a7ae15.pers[ "plants" ] + 1;
        }
    }
    
    var_dbd0d4c325a7ae15 persistence::statsetchild( "round", "plants", var_dbd0d4c325a7ae15.pers[ "plants" ] );
    var_dbd0d4c325a7ae15 stats::setextrascore0( var_dbd0d4c325a7ae15.pers[ "plants" ], "plants" );
    var_dbd0d4c325a7ae15 codcasterclientmatchdata::function_8ecc753b54a5740f( 3, 1 );
    var_dbd0d4c325a7ae15 challenges::function_981ae5464b9301da( istrue( var_dbd0d4c325a7ae15.disguised ) );
    challenges::function_a3678ff124a05f01( var_dbd0d4c325a7ae15 );
    telemetry_data = {};
    telemetry_data.player = var_dbd0d4c325a7ae15;
    telemetry_data.eventname = "plant";
    telemetry_data.position = var_dbd0d4c325a7ae15.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", "bomb", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 0 ] );
    var_b19ce51dfc12b7f8 = {};
    var_b19ce51dfc12b7f8.var_1b55994025b9dc25 = var_1b55994025b9dc25;
    var_b19ce51dfc12b7f8.var_85c26a6c91c38374 = var_85c26a6c91c38374;
    var_b19ce51dfc12b7f8.bomb_game_object = bomb_game_object;
    var_b19ce51dfc12b7f8.player = var_dbd0d4c325a7ae15;
    var_b19ce51dfc12b7f8.instance_id = instance_id;
    var_b19ce51dfc12b7f8.force_planted = force_planted;
    callback::callback( #"hash_4b88ae7136a85bfd", var_b19ce51dfc12b7f8 );
    
    /#
        gameobjects_common::function_579ac2f7e66ed64f( var_1b55994025b9dc25, 1 );
        gameobjects_common::function_579ac2f7e66ed64f( var_85c26a6c91c38374, 0 );
    #/
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x8106f96, Offset: 0x1618
// Size: 0x4f4
function private function_6d8dc2eb44bb6b8d( params, additional_params )
{
    var_85c26a6c91c38374 = params.game_object;
    var_dbd0d4c325a7ae15 = params.var_dbd0d4c325a7ae15;
    var_1b55994025b9dc25 = additional_params.var_1b55994025b9dc25;
    bomb_game_object = additional_params.bomb_game_object;
    level notify( #"bomb_defused", var_1b55994025b9dc25, var_85c26a6c91c38374 );
    var_dbd0d4c325a7ae15 notify( #"bomb_defused", var_1b55994025b9dc25, var_85c26a6c91c38374 );
    var_1b55994025b9dc25 notify( #"bomb_defused" );
    var_85c26a6c91c38374 notify( #"bomb_defused" );
    level.bombdefused = 1;
    level.bombplanted = undefined;
    level.bombsplanted--;
    var_1726e100ca5cbe89 = var_dbd0d4c325a7ae15.team == "all" || var_dbd0d4c325a7ae15.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( var_dbd0d4c325a7ae15.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( var_dbd0d4c325a7ae15.team ) ? #"hash_ce911e3bbe99421f" : var_dbd0d4c325a7ae15.team == "none" || var_dbd0d4c325a7ae15.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    var_5948d1b3a0d687f2 = var_1726e100ca5cbe89 == #"hash_7118f9343873352b" ? #"hash_ce911e3bbe99421f" : var_1726e100ca5cbe89 == #"hash_ce911e3bbe99421f" ? #"hash_7118f9343873352b" : undefined;
    level.var_a4c1420a2120df87[ var_5948d1b3a0d687f2 ] = undefined;
    
    if ( level.var_a4c1420a2120df87.size == 0 )
    {
        level.var_a4c1420a2120df87 = undefined;
    }
    
    var_85c26a6c91c38374.ticking_object gamelogic_mp::stoptickingsound();
    var_85c26a6c91c38374.ticking_object delete();
    var_85c26a6c91c38374.ticking_object = undefined;
    var_1b55994025b9dc25.ticking_object = undefined;
    var_85c26a6c91c38374.bombdefused = 1;
    var_1b55994025b9dc25.bombdefused = 1;
    var_85c26a6c91c38374.bombplanted = undefined;
    var_1b55994025b9dc25.bombplanted = undefined;
    gameobjects_common::update_origin( var_85c26a6c91c38374, gameobjects_common::get_origin( var_1b55994025b9dc25 ) );
    gameobjects_common::function_37f390027536269c( var_85c26a6c91c38374, gameobjects_common::function_63e25df7cfbb206f( var_1b55994025b9dc25 ) );
    gameobjects_common::activate( var_1b55994025b9dc25 );
    gameobjects_common::deactivate( var_85c26a6c91c38374 );
    
    /#
        if ( isdefined( bomb_game_object ) )
        {
            gameobjects_common::function_579ac2f7e66ed64f( bomb_game_object, 0 );
        }
    #/
    
    var_dbd0d4c325a7ae15 challenges::function_5f09e82f1ba9ce65( istrue( var_dbd0d4c325a7ae15.disguised ) );
    var_dbd0d4c325a7ae15 codcasterclientmatchdata::function_8ecc753b54a5740f( 2, 1 );
    
    if ( isplayer( var_dbd0d4c325a7ae15 ) )
    {
        telemetry_data = spawnstruct();
        telemetry_data.player = var_dbd0d4c325a7ae15;
        telemetry_data.eventname = "defuse";
        telemetry_data.position = var_dbd0d4c325a7ae15.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_dbd0d4c325a7ae15 ) ) )
    {
        if ( isdefined( var_dbd0d4c325a7ae15.leaderboarddata[ "defuses" ] ) )
        {
            var_dbd0d4c325a7ae15.leaderboarddata[ "defuses" ] = var_dbd0d4c325a7ae15.leaderboarddata[ "defuses" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "defuses" ] ) )
        {
            [[ level.leaderboardfunc[ "defuses" ] ]]( var_dbd0d4c325a7ae15, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x58>" );
        
        if ( isdefined( var_dbd0d4c325a7ae15.pers[ "defuses" ] ) )
        {
            var_dbd0d4c325a7ae15.pers[ "defuses" ] = var_dbd0d4c325a7ae15.pers[ "defuses" ] + 1;
        }
    }
    
    var_dbd0d4c325a7ae15 persistence::statsetchild( "round", "defuses", var_dbd0d4c325a7ae15.pers[ "defuses" ] );
    var_dbd0d4c325a7ae15 stats::setextrascore1( var_dbd0d4c325a7ae15.pers[ "defuses" ] );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", "bombSite.objectiveKey", "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    var_b19ce51dfc12b7f8 = {};
    var_b19ce51dfc12b7f8.var_1b55994025b9dc25 = var_1b55994025b9dc25;
    var_b19ce51dfc12b7f8.var_85c26a6c91c38374 = var_85c26a6c91c38374;
    var_b19ce51dfc12b7f8.bomb_game_object = bomb_game_object;
    var_b19ce51dfc12b7f8.player = var_dbd0d4c325a7ae15;
    var_b19ce51dfc12b7f8.instance_id = params.instance_id;
    callback::callback( #"hash_e19a9f3d97f3e18f", var_b19ce51dfc12b7f8 );
    
    /#
        gameobjects_common::function_579ac2f7e66ed64f( var_1b55994025b9dc25, 0 );
        gameobjects_common::function_579ac2f7e66ed64f( var_85c26a6c91c38374, 1 );
    #/
}

// Namespace bombzone
// Params 3, eflags: 0x4
// Checksum 0x9b0c713a, Offset: 0x1b14
// Size: 0xaf
function private function_3534179e566f70d0( player, weapon, immediate )
{
    player notify( #"hash_af3f8e2664edeaee" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_af3f8e2664edeaee" );
    player supers_mp::allowsuperweaponstow();
    result = player inventory_utility::domonitoredweaponswitch( weapon, immediate );
    
    if ( result )
    {
        return;
    }
    
    player notify( #"bomb_allow_offhands" );
    player supers_mp::unstowsuperweapon();
    
    if ( player inventory_utility::isswitchingtoweaponwithmonitoring( weapon ) )
    {
        player inventory_utility::abortmonitoredweaponswitch( weapon );
        return;
    }
    
    player inventory_utility::_takeweapon( weapon );
}

// Namespace bombzone
// Params 2, eflags: 0x4
// Checksum 0x65add10c, Offset: 0x1bcb
// Size: 0x68
function private function_1db698f2d87aac( player, game_object )
{
    player notify( #"hash_34ec22af294123ca" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_34ec22af294123ca" );
    player inventory_utility::getridofweapon( game_object.use_weapon, 0 );
    game_object.using_player_weapon = undefined;
}

// Namespace bombzone
// Params 2, eflags: 0xc
// Checksum 0xefee9c4a, Offset: 0x1c3b
// Size: 0xf6
function private function_b87bf4629312aedd( player, var_faa32a47da5c0140 )
{
    self notify( #"hash_75a9b43fb4db81c7" );
    self endon( #"hash_75a9b43fb4db81c7" );
    player endon( #"death_or_disconnect" );
    player endon( #"bombzone_stop_use" );
    
    if ( game_utility_mp::isanymlgmatch() || level.silentplant || isdefined( player.perks[ "specialty_engineer" ] ) && level.perkbundles[ "specialty_engineer" ].silent_plant_defuse )
    {
        player setentitysoundcontext( "silent_plant", "on" );
    }
    
    while ( true )
    {
        player waittill( #"weapon_change", weapon_obj );
        
        if ( weapon_obj.basename == level.gametypebundle.bombweapon )
        {
            break;
        }
    }
    
    player waittill( #"weapon_change" );
}

// Namespace bombzone
// Params 3, eflags: 0x4
// Checksum 0x69d4eba2, Offset: 0x1d39
// Size: 0xa2
function private function_fcbc7809e62f7079( var_85c26a6c91c38374, bomb_game_object, player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( bomb_game_object ) )
    {
        if ( gameobjects_carryobject::is_carrier( bomb_game_object, player ) )
        {
            bomb_game_object waittill( #"bomb_dropped" );
        }
        
        gameobjects_common::update_origin( var_85c26a6c91c38374, gameobjects_common::get_origin( bomb_game_object ) );
        gameobjects_common::function_37f390027536269c( var_85c26a6c91c38374, gameobjects_common::function_63e25df7cfbb206f( bomb_game_object ) );
        return;
    }
    
    gameobjects_common::update_origin( var_85c26a6c91c38374, utility::drop_to_ground( player.origin, 64, -1024 ) );
    gameobjects_common::function_37f390027536269c( var_85c26a6c91c38374, player.angles );
}

// Namespace bombzone
// Params 5, eflags: 0xc
// Checksum 0x987e3917, Offset: 0x1de3
// Size: 0x1ac
function private function_10d98da5a9885fd5( var_1b55994025b9dc25, var_85c26a6c91c38374, bomb_game_object, player, instance_id )
{
    self notify( #"hash_55f54f59053785b3" );
    self endon( #"hash_55f54f59053785b3" );
    bombzone_objective_key = gameobjects_common::get_objective_key( var_1b55994025b9dc25 );
    level endon( #"game_ended" );
    level endon( #"bomb_defused" );
    player endon( #"bomb_defused" );
    var_1b55994025b9dc25 endon( #"bomb_defused" );
    var_85c26a6c91c38374 endon( #"bomb_defused" );
    level.timelimitoverride = 1;
    level.defuseendtime = int( gettime() + ( var_1b55994025b9dc25.var_ccd5594a8890e558 ?? level.bombtimer ) * 1000 );
    match_start_time = matchdata::function_47550968a937b67e( gettime() );
    player dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 0, "match_time_ms", match_start_time ] );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", bombzone_objective_key, "team", player.team, "match_time_ms", match_start_time ] );
    plant_team_name = player.team;
    wait var_1b55994025b9dc25.var_ccd5594a8890e558 ?? level.bombtimer;
    level.timelimitoverride = undefined;
    on_bomb_detonated( var_1b55994025b9dc25, var_85c26a6c91c38374, bomb_game_object, player, instance_id, bombzone_objective_key, plant_team_name );
}

// Namespace bombzone
// Params 7, eflags: 0x4
// Checksum 0x1883a291, Offset: 0x1f97
// Size: 0x30a
function private on_bomb_detonated( var_1b55994025b9dc25, var_85c26a6c91c38374, bomb_game_object, player, instance_id, bombzone_objective_key, plant_team_name )
{
    level notify( "bomb_exploded" + bombzone_objective_key );
    level notify( #"bomb_exploded", var_1b55994025b9dc25, var_85c26a6c91c38374 );
    player notify( #"bomb_exploded", var_1b55994025b9dc25, var_85c26a6c91c38374 );
    var_1b55994025b9dc25 notify( #"bomb_exploded" );
    var_85c26a6c91c38374 notify( #"bomb_exploded" );
    gameobjects_common::deactivate( var_85c26a6c91c38374 );
    
    /#
        gameobjects_common::function_579ac2f7e66ed64f( var_1b55994025b9dc25, 1 );
        gameobjects_common::function_579ac2f7e66ed64f( var_85c26a6c91c38374, 1 );
    #/
    
    level.bombplanted = undefined;
    var_85c26a6c91c38374.bombplanted = undefined;
    var_1b55994025b9dc25.bombplanted = undefined;
    
    if ( !isdefined( level.bombexploded ) )
    {
        level.bombexploded = 0;
    }
    
    level.bombexploded++;
    level.bombsplanted--;
    var_1b55994025b9dc25.ticking_object gamelogic_mp::stoptickingsound();
    var_1b55994025b9dc25.ticking_object delete();
    var_1b55994025b9dc25.ticking_object = undefined;
    var_85c26a6c91c38374.ticking_object = undefined;
    
    if ( isdefined( player ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "destructions" ] ) )
            {
                player.leaderboarddata[ "destructions" ] = player.leaderboarddata[ "destructions" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "destructions" ] ) )
            {
                [[ level.leaderboardfunc[ "destructions" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x58>" );
            
            if ( isdefined( player.pers[ "destructions" ] ) )
            {
                player.pers[ "destructions" ] = player.pers[ "destructions" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "destructions", player.pers[ "destructions" ] );
    }
    
    var_d0a9d177707a4448 = gameobjects_common::get_origin( bomb_game_object );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", bombzone_objective_key, "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    var_b19ce51dfc12b7f8 = {};
    var_b19ce51dfc12b7f8.var_1b55994025b9dc25 = var_1b55994025b9dc25;
    var_b19ce51dfc12b7f8.var_85c26a6c91c38374 = var_85c26a6c91c38374;
    var_b19ce51dfc12b7f8.bomb_game_object = bomb_game_object;
    var_b19ce51dfc12b7f8.player = player;
    var_b19ce51dfc12b7f8.plant_team_name = plant_team_name;
    var_b19ce51dfc12b7f8.var_d0a9d177707a4448 = var_d0a9d177707a4448;
    var_b19ce51dfc12b7f8.instance_id = instance_id;
    callback::callback( #"hash_3a1fe5e4df493585", var_b19ce51dfc12b7f8 );
}

// Namespace bombzone
// Params 1, eflags: 0x4
// Checksum 0xbb43c333, Offset: 0x22a9
// Size: 0x202
function private setupkillcament( bombzone )
{
    temporg = spawn( "script_origin", bombzone.origin );
    temporg.angles = bombzone.angles;
    temporg rotateyaw( -45, 0.05 );
    waitframe();
    campos = undefined;
    bulletstart = bombzone.origin + anglestoforward( temporg.angles ) * 18 + ( 0, 0, 60 );
    bulletend = bombzone.origin + anglestoforward( temporg.angles ) * 100 + ( 0, 0, 128 );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle" ];
    contentoverride = physics_createcontents( content );
    result = trace::sphere_trace( bulletstart, bulletend, 16, undefined, contentoverride );
    campos = result[ "shape_position" ];
    bombzone.killcament = spawn( "script_model", campos );
    bombzone.killcament setscriptmoverkillcam( "explosive" );
    bombzone.killcamentnum = bombzone.killcament getentitynumber();
    temporg delete();
    
    /#
        if ( getdvarint( @"hash_3f3a15fb7e7c9b0" ) > 0 )
        {
            thread debug_utility::drawline( bulletstart, bulletend, 999, ( 1, 1, 0 ) );
            thread debug_utility::drawsphere( bulletstart, 2, 999, ( 0, 1, 0 ) );
            thread debug_utility::drawsphere( bulletend, 2, 999, ( 1, 0, 0 ) );
            thread debug_utility::drawsphere( campos, 2, 999, ( 1, 0, 1 ) );
        }
        
        bombzone.killcament thread debugkillcament( bombzone );
    #/
}

/#

    // Namespace bombzone
    // Params 1, eflags: 0x4
    // Checksum 0xc6e38b23, Offset: 0x24b3
    // Size: 0x1d3, Type: dev
    function private debugkillcament( visual )
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        visual endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_3f3a15fb7e7c9b0" ) > 0 )
            {
                line( self.origin, self.origin + anglestoforward( self.angles ) * 10, ( 1, 0, 0 ) );
                line( self.origin, self.origin + anglestoright( self.angles ) * 10, ( 0, 1, 0 ) );
                line( self.origin, self.origin + anglestoup( self.angles ) * 10, ( 0, 0, 1 ) );
                line( visual.origin + ( 0, 0, 5 ), self.origin, ( 0, 0, 1 ) );
                line( visual.origin, visual.origin + anglestoforward( visual.angles ) * 10, ( 1, 0, 0 ) );
                line( visual.origin, visual.origin + anglestoright( visual.angles ) * 10, ( 0, 1, 0 ) );
                line( visual.origin, visual.origin + anglestoup( visual.angles ) * 10, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

#/
