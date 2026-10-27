// script_5e3244e3b1bdd40d  (hash_5e3244e3b1bdd40d.gscc) (size: 12968 Bytes / 0x32a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb569c3f (3411450943)
// size ...... 12968 (0x32a8)
// includes .. 14  (offset: 0x2df8)
// strings ... 44  (offset: 0x2e68)
// dev strs .. 28  (offset: 0x3124)
// exports ... 36  (offset: 0x1d50)
// cseg ...... 0x400 + 0x1950 (0x1d50)
// imports ... 89  (offset: 0x22f0)
// animtree1 . 0   (offset: 0x32a8)
// animtree2 . 0   (offset: 0x32a8)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace quest_panic;

// Namespace quest_panic
// Params 0, eflags: 0x5
// Checksum 0xa88b5402, Offset: 0x41e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"panic_room", #"br_map_quest", &pre_main, undefined );
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x62307019, Offset: 0x447
// Size: 0x5e
function private pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_start:&on_start, #on_init:&on_init, #name:"panic_room" };
    br_map_quest::register( quest );
}

// Namespace quest_panic
// Params 0
// Checksum 0xf4f6fa1f, Offset: 0x4ad
// Size: 0x21
function on_init()
{
    function_970d564ac5226b2e();
    function_1a00a5a2ba836d4d();
    register_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace quest_panic
// Params 0
// Checksum 0xa495d17f, Offset: 0x4d6
// Size: 0x9
function on_start()
{
    thread init_puzzle();
}

// Namespace quest_panic
// Params 0
// Checksum 0x7e198dc0, Offset: 0x4e7
// Size: 0x1a
function on_infil()
{
    self.keypad setscriptablepartstate( "quest_wz_panic_room_keypad", "on_model" );
}

// Namespace quest_panic
// Params 0
// Checksum 0x8bb5cd2e, Offset: 0x509
// Size: 0x2c
function on_disabled()
{
    door = getentitylessscriptablearray( "ee_panic_room_door", "targetname" );
    
    if ( door.size > 0 )
    {
        door[ 0 ] scriptabledoorfreeze();
    }
}

// Namespace quest_panic
// Params 0
// Checksum 0x2c869df, Offset: 0x53d
// Size: 0x1f
function function_970d564ac5226b2e()
{
    setdvarifuninitialized( @"ui_bunker_keypad_active", 1 );
    br_map_quest::add_setting( "panic_room_find_balls", 0 );
}

// Namespace quest_panic
// Params 0
// Checksum 0xd2913b5a, Offset: 0x564
// Size: 0x2eb
function function_1a00a5a2ba836d4d()
{
    self.door = getentitylessscriptablearray( "ee_panic_room_door", "targetname" )[ 0 ];
    assert( self.door, "<dev string:x24>" + "<dev string:x3f>" );
    self.panel_buttons = getentitylessscriptablearray( "vault_rollup_door", #target );
    assert( self.panel_buttons.size, "<dev string:x24>" + "<dev string:x4f>" );
    self.keypad_loc = utility::getstruct( "quest_wz_panic_room_keypad", "targetname" );
    assert( self.keypad_loc, "<dev string:x24>" + "<dev string:x68>" );
    
    /#
        self.var_d4c6a17be495c36d = utility::getstructarray( "<dev string:x81>", "<dev string:x9d>" );
        assert( self.var_d4c6a17be495c36d.size, "<dev string:x24>" + "<dev string:xa8>" );
    #/
    
    self.var_47cd8cb122a6038f = utility::getstruct( "quest_wz_panic_room_rack_interact", "targetname" );
    assert( self.var_47cd8cb122a6038f, "<dev string:x24>" + "<dev string:xc8>" );
    self.var_19cf7057e42bcd07 = utility::getstructarray( "quest_panic_room_rack_ball", "targetname" );
    assert( self.var_19cf7057e42bcd07.size, "<dev string:x24>" + "<dev string:xe8>" );
    self.ball_penthouse_locs = utility::getstructarray( "quest_panic_room_hidden_ball_penthouse", "targetname" );
    assert( self.ball_penthouse_locs.size, "<dev string:x24>" + "<dev string:x105>" );
    self.ball_atrium_locs = utility::getstructarray( "quest_panic_room_hidden_ball_atrium", "targetname" );
    assert( self.ball_atrium_locs.size, "<dev string:x24>" + "<dev string:x127>" );
    self.ball_lobby_locs = utility::getstructarray( "quest_panic_room_hidden_ball_lobby", "targetname" );
    assert( self.ball_lobby_locs.size, "<dev string:x24>" + "<dev string:x146>" );
    self.keycard_locs = utility::getstructarray( "panic_room_" + "brloot_saw_key_elevator", "targetname" );
    
    if ( self.keycard_locs.size == 0 )
    {
        self.keycard_locs = [ { #angles:( 0, 0, 0 ), #origin:( 19483, -14102, -16 ) }, { #angles:( 0, 0, 0 ), #origin:( 21071, -16740, -135.75 ) }, { #angles:( 0, 0, 0 ), #origin:( 19389, -15694.8, -33.75 ) } ];
    }
    
    self.cache_locs = utility::getstructarray( "br_loot_cache_locked", "targetname" );
    assert( self.cache_locs.size, "<dev string:x24>" + "<dev string:x164>" );
}

// Namespace quest_panic
// Params 0
// Checksum 0x1d0df316, Offset: 0x857
// Size: 0x24
function register_callbacks()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_panic_room_keypad", &function_97031bb6c42348b4 );
    scriptable::scriptable_addusedcallbackbypart( "locked_cache_prompt", &function_4ea36d554e49d58d );
}

// Namespace quest_panic
// Params 1, eflags: 0x4
// Checksum 0x14df8ab4, Offset: 0x883
// Size: 0x97
function private function_ff852ae29d92cbf8( params )
{
    scriptable = params.scriptable;
    quest = br_map_quest::get_quest( "panic_room" );
    ball_index = self.var_41aa34fe6c1c4158[ 0 ];
    scriptable setscriptablepartstate( "brloot_wz_quest_panic_room_ball", "visible_" + string( quest.puzzle_code[ ball_index ] ) );
    scriptable.code_index = ball_index;
    self.var_41aa34fe6c1c4158 = arrayremove( self.var_41aa34fe6c1c4158, ball_index );
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x6b0f045d, Offset: 0x922
// Size: 0xb0
function private init_puzzle()
{
    setup_puzzle_keypad();
    setup_puzzle_balls();
    setup_puzzle_keycards();
    setup_puzzle_caches();
    self.door scriptabledoorlock();
    wait 1;
    
    foreach ( button in self.panel_buttons )
    {
        button setscriptablepartstate( "arcwire_transmitter", "disabled" );
    }
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x3b647ada, Offset: 0x9da
// Size: 0xcc
function private setup_puzzle_keypad()
{
    self.keypad = spawnscriptable( "quest_wz_panic_room_keypad", self.keypad_loc.origin, self.keypad_loc.angles );
    self.keypad.backwallkeypad = 1;
    self.keypad.script_codelength = 6;
    self.keypad.code[ "string" ] = function_bf9d4ccfb0c4e3f4();
    self.keypad.successfunction = &function_561e78789b4d65a6;
    self.keypad.quest = self;
    self.keypad setscriptablepartstate( "quest_wz_panic_room_keypad", "off_model" );
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0xe45daeb8, Offset: 0xaae
// Size: 0xba
function private function_bf9d4ccfb0c4e3f4()
{
    puzzle_code = undefined;
    self.puzzle_code = [];
    var_4fc9b62ba71956f8 = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    
    for ( i = 0; i <= 5 ; i++ )
    {
        code_number = utility::array_random( var_4fc9b62ba71956f8 );
        var_4fc9b62ba71956f8 = arrayremove( var_4fc9b62ba71956f8, code_number );
        
        if ( isdefined( puzzle_code ) )
        {
            puzzle_code += string( code_number );
        }
        else
        {
            puzzle_code = string( code_number );
        }
        
        self.puzzle_code[ i ] = code_number;
    }
    
    return puzzle_code;
}

// Namespace quest_panic
// Params 6, eflags: 0x4
// Checksum 0x7705a0dc, Offset: 0xb71
// Size: 0x70
function private function_97031bb6c42348b4( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "panic_room" );
    
    if ( instance.quest == quest )
    {
        level thread keypad_use( instance, part, state, player, bautouse );
    }
}

// Namespace quest_panic
// Params 5, eflags: 0x4
// Checksum 0xdd8ca9c1, Offset: 0xbe9
// Size: 0x9b
function private keypad_use( instance, part, state, player, bautouse )
{
    quest = br_map_quest::get_quest( "panic_room" );
    instance setscriptablepartstate( part, "off_model" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    if ( !quest.is_completed )
    {
        instance setscriptablepartstate( part, "on_model" );
        return;
    }
    
    instance.completed = 1;
}

// Namespace quest_panic
// Params 1, eflags: 0x4
// Checksum 0xb4e201bb, Offset: 0xc8c
// Size: 0x120
function private function_561e78789b4d65a6( keypad )
{
    quest = br_map_quest::get_quest( "panic_room" );
    quest.door scriptabledoorunlock();
    quest.door scriptabledooropen( "away", self.origin );
    keypad setscriptablepartstate( "quest_wz_panic_room_keypad", "off_model" );
    
    foreach ( button in quest.panel_buttons )
    {
        button setscriptablepartstate( "arcwire_transmitter", "standby" );
    }
    
    params = { #completed_by:teams::getteamdata( self.team, "players" ), #is_successful:1 };
    quest br_map_quest::on_completed( params );
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x609d677c, Offset: 0xdb4
// Size: 0x17
function private setup_puzzle_balls()
{
    function_5942fbac9e51a7a4();
    function_81a203e958555886();
    function_ecbf636eab521c63();
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0xbec5e32f, Offset: 0xdd3
// Size: 0x7d
function private function_5942fbac9e51a7a4()
{
    self.var_19cf7057e42bcd07 = order_struct_array( self.var_19cf7057e42bcd07 );
    self.ball_penthouse_locs = order_struct_array( self.ball_penthouse_locs );
    self.ball_atrium_locs = order_struct_array( self.ball_atrium_locs );
    self.ball_lobby_locs = order_struct_array( self.ball_lobby_locs );
    
    /#
        self.var_d4c6a17be495c36d = order_struct_array( self.var_d4c6a17be495c36d );
    #/
}

// Namespace quest_panic
// Params 1, eflags: 0x4
// Checksum 0xb00788e4, Offset: 0xe58
// Size: 0xa1
function private order_struct_array( structarray )
{
    ordered_array = [];
    
    foreach ( var_ef4b37d1aaab7eba in structarray )
    {
        index = int( var_ef4b37d1aaab7eba.script_noteworthy );
        ordered_array[ index ] = var_ef4b37d1aaab7eba;
    }
    
    return ordered_array;
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x9e8d6a1f, Offset: 0xf02
// Size: 0x15b
function private function_81a203e958555886()
{
    self.ball_spawn_locs = [];
    self.var_4bb9276d692e1d39 = [];
    var_6c31f40bcd92962b = self.var_19cf7057e42bcd07[ 0 ];
    self.ball_spawn_locs[ self.ball_spawn_locs.size ] = var_6c31f40bcd92962b;
    self.penthouse_ball = randomint( self.ball_penthouse_locs.size );
    self.ball_spawn_locs[ self.ball_spawn_locs.size ] = self.ball_penthouse_locs[ self.penthouse_ball ];
    self.atrium_ball = randomint( self.ball_atrium_locs.size );
    self.ball_spawn_locs[ self.ball_spawn_locs.size ] = self.ball_atrium_locs[ self.atrium_ball ];
    var_6b04d5526fe4733a = self.var_19cf7057e42bcd07[ 3 ];
    self.ball_spawn_locs[ self.ball_spawn_locs.size ] = var_6b04d5526fe4733a;
    var_29e382268e0642b = self.var_19cf7057e42bcd07[ 4 ];
    self.ball_spawn_locs[ self.ball_spawn_locs.size ] = var_29e382268e0642b;
    self.lobby_ball = randomint( self.ball_lobby_locs.size );
    self.ball_spawn_locs[ self.ball_spawn_locs.size ] = self.ball_lobby_locs[ self.lobby_ball ];
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x6a7d687f, Offset: 0x1065
// Size: 0x196
function private function_ecbf636eab521c63()
{
    self.var_26ee2191c77f9805 = [];
    
    for ( i = 0; i < self.ball_spawn_locs.size ; i++ )
    {
        if ( false )
        {
            spawned_number = spawn_quest_item( "wz_consumable_quest_panic_room_ball", self.ball_spawn_locs[ i ].origin, self.ball_spawn_locs[ i ].angles );
            part = "brloot_wz_quest_panic_room_ball";
        }
        else
        {
            spawned_number = spawnscriptable( "quest_wz_panic_room_numbers", self.var_19cf7057e42bcd07[ i ].origin, self.var_19cf7057e42bcd07[ i ].angles );
            part = "quest_wz_panic_room_numbers";
        }
        
        spawned_number.code_number = string( self.puzzle_code[ i ] );
        spawned_number.code_index = i;
        spawned_number setscriptablepartstate( part, "visible_" + spawned_number.code_number );
        self.var_26ee2191c77f9805[ i ] = spawned_number;
    }
    
    /#
        for ( i = 0; i < self.var_d4c6a17be495c36d.size ; i++ )
        {
            spawned_number = spawnscriptable( "<dev string:x81>", self.var_d4c6a17be495c36d[ i ].origin, self.var_d4c6a17be495c36d[ i ].angles );
            model_number = string( self.puzzle_code[ i ] );
            spawned_number setscriptablepartstate( "<dev string:x81>", "<dev string:x17d>" + model_number );
        }
    #/
}

// Namespace quest_panic
// Params 3, eflags: 0x4
// Checksum 0xa0aa89d5, Offset: 0x1203
// Size: 0x78
function private spawn_quest_item( consumable, spawnorigin, spawnangles )
{
    bundle = common_item::function_cf68ad18114498b2( consumable );
    spawn_options = common_item::function_bc5ff2958b71a708( spawnorigin, spawnangles );
    spawn_options.critical = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    item = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
    return item;
}

// Namespace quest_panic
// Params 1, eflags: 0x4
// Checksum 0x8d3f3619, Offset: 0x1284
// Size: 0x95
function private function_84590b9b1c611fc2( params )
{
    player = params.player;
    scriptable = params.scriptable;
    
    if ( !isdefined( player.var_41aa34fe6c1c4158 ) )
    {
        player.var_41aa34fe6c1c4158 = [];
    }
    
    if ( !arraycontains( player.var_41aa34fe6c1c4158, scriptable.code_index ) )
    {
        player.var_41aa34fe6c1c4158[ player.var_41aa34fe6c1c4158.size ] = scriptable.code_index;
    }
}

// Namespace quest_panic
// Params 6, eflags: 0x4
// Checksum 0xafeeba48, Offset: 0x1321
// Size: 0x65
function private function_28c5dca1ee742901( scriptable, part, state, player, bautouse, usestring )
{
    if ( !isdefined( player.var_41aa34fe6c1c4158 ) || !player br_quest_inventory::has_quest_item( "wz_consumable_quest_panic_room_ball" ) )
    {
        return;
    }
    
    player thread function_442a75dc77e5c885();
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x318af95e, Offset: 0x138e
// Size: 0x1a0
function private function_442a75dc77e5c885()
{
    quest = br_map_quest::get_quest( "panic_room" );
    quest.ball_rack_interact setscriptablepartstate( "quest_wz_panic_room_rack_interact", "unusable" );
    
    foreach ( ball_index in self.var_41aa34fe6c1c4158 )
    {
        placed_ball = spawnscriptable( "quest_wz_panic_room_numbers", quest.var_19cf7057e42bcd07[ ball_index ].origin, quest.var_19cf7057e42bcd07[ ball_index ].angles );
        model_number = string( quest.puzzle_code[ ball_index ] );
        placed_ball setscriptablepartstate( "quest_wz_panic_room_numbers", "visible_" + model_number );
        quest.var_4bb9276d692e1d39[ ball_index ] = quest.var_19cf7057e42bcd07[ ball_index ];
        br_quest_inventory::consume_quest_item( "wz_consumable_quest_panic_room_ball", 1 );
        placed_ball setscriptablepartstate( "FX", "placed" );
    }
    
    thread pickups::playerplaypickupanim();
    self.var_41aa34fe6c1c4158 = [];
    
    if ( quest.var_4bb9276d692e1d39.size == 3 )
    {
        quest.ball_rack_interact freescriptable();
        return;
    }
    
    quest.ball_rack_interact setscriptablepartstate( "quest_wz_panic_room_rack_interact", "usable" );
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x9afe91c4, Offset: 0x1536
// Size: 0x3c
function private setup_puzzle_keycards()
{
    self.keycard_spawn_locs = [];
    spawn_keycard( self.ball_penthouse_locs );
    spawn_keycard( self.ball_atrium_locs );
    spawn_keycard( self.keycard_locs );
}

// Namespace quest_panic
// Params 1, eflags: 0x4
// Checksum 0x62196476, Offset: 0x157a
// Size: 0x80
function private spawn_keycard( var_8c221c06bd973e17 )
{
    for ( keycard_loc = utility::array_random( var_8c221c06bd973e17 ); arraycontains( self.ball_spawn_locs, keycard_loc ) ; keycard_loc = utility::array_random( var_8c221c06bd973e17 ) )
    {
    }
    
    keycard = spawn_quest_item( "saw_consumable_quest_elevator_key", keycard_loc.origin, ( 0, randomint( 360 ), 0 ) );
    self.keycard_spawn_locs[ self.keycard_spawn_locs.size ] = keycard;
}

// Namespace quest_panic
// Params 0, eflags: 0x4
// Checksum 0x5a79ed41, Offset: 0x1602
// Size: 0x35e
function private setup_puzzle_caches()
{
    self.cache_locs = order_struct_array( self.cache_locs );
    self.caches = [];
    squadsize = game_utility::function_f24780eadd3fb772();
    cache = common_cache::spawncache( %"hash_643f22d0e61243d6", self.cache_locs[ 0 ].origin + ( 0, 0, 3 ), self.cache_locs[ 0 ].angles );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_panic_room_survival" );
    var_f67995529827f79.spawncount += squadsize;
    common_cache::function_a136b84fc5c0dfab( cache, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
    cache locksandkeys::lockedcache_lock( self.cache_locs[ 0 ].origin + ( 0, 0, 20 ), "saw_consumable_quest_elevator_key", "lege_closed_unusable", "lege_closed_to_fully_open_unusable" );
    common_cache::function_81144e13eed673e( cache );
    common_cache::function_9d6321275c249932( cache );
    cache.panic_type = "survival";
    self.caches[ self.caches.size ] = cache;
    cache = common_cache::spawncache( %"hash_643f22d0e61243d6", self.cache_locs[ 1 ].origin + ( 0, 0, 3 ), self.cache_locs[ 1 ].angles );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_panic_room_specialist" );
    var_f67995529827f79.spawncount += squadsize;
    common_cache::function_a136b84fc5c0dfab( cache, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
    cache locksandkeys::lockedcache_lock( self.cache_locs[ 1 ].origin + ( 0, 0, 20 ), "saw_consumable_quest_elevator_key", "lege_closed_unusable", "lege_closed_to_fully_open_unusable" );
    common_cache::function_81144e13eed673e( cache );
    common_cache::function_9d6321275c249932( cache );
    cache.panic_type = "specialist";
    self.caches[ self.caches.size ] = cache;
    cache = common_cache::spawncache( %"hash_643f22d0e61243d6", self.cache_locs[ 2 ].origin + ( 0, 0, 3 ), self.cache_locs[ 2 ].angles );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_panic_room_utility" );
    var_f67995529827f79.spawncount += squadsize;
    common_cache::function_a136b84fc5c0dfab( cache, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
    cache locksandkeys::lockedcache_lock( self.cache_locs[ 2 ].origin + ( 0, 0, 20 ), "saw_consumable_quest_elevator_key", "lege_closed_unusable", "lege_closed_to_fully_open_unusable" );
    common_cache::function_81144e13eed673e( cache );
    common_cache::function_9d6321275c249932( cache );
    cache.panic_type = "utility";
    self.caches[ self.caches.size ] = cache;
}

// Namespace quest_panic
// Params 6, eflags: 0x4
// Checksum 0x1688ceb6, Offset: 0x1968
// Size: 0x114
function private function_4ea36d554e49d58d( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.cache.panic_type ) )
    {
        return;
    }
    
    if ( !player br_quest_inventory::has_quest_item( "saw_consumable_quest_elevator_key" ) )
    {
        if ( instance.canplaysound )
        {
            instance.canplaysound = 0;
            playsoundatpos( instance.origin, "mp_door_locked" );
            return 0;
        }
        
        instance.canplaysound = 1;
        return 0;
    }
    
    cache = instance.cache;
    player br_quest_inventory::consume_quest_item( "saw_consumable_quest_elevator_key", 1 );
    playsoundatpos( instance.origin, "mp_door_unlock_key" );
    cache setscriptablepartstate( "body", cache.unlockstate ?? "closed_usable" );
    common_cache::function_fbb69fe19da245da( cache, player, undefined );
    instance freescriptable();
}

/#

    // Namespace quest_panic
    // Params 0, eflags: 0x4
    // Checksum 0x4c52db17, Offset: 0x1a84
    // Size: 0x8c, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x186>" + "<dev string:x195>" );
        devgui::add_devgui_func( "<dev string:x1a1>", "<dev string:x1b4>", &function_b1ee7ab45bdb919c );
        devgui::add_devgui_func( "<dev string:x1d5>", "<dev string:x1eb>", &function_6e7ff8c9d98fcdef );
        devgui::add_devgui_func( "<dev string:x20a>", "<dev string:x21b>", &function_f78110f03f90b6d9 );
        devgui::add_devgui_func( "<dev string:x23a>", "<dev string:x24e>", &function_8b9b30ae510ee6ed );
        devgui::add_devgui_func( "<dev string:x26e>", "<dev string:x279>", &debug_print_code );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_panic
    // Params 0, eflags: 0x4
    // Checksum 0xb07732af, Offset: 0x1b18
    // Size: 0x3f, Type: dev
    function private function_b1ee7ab45bdb919c()
    {
        level.player setorigin( ( 20523, -14257, 4354 ), 1 );
        level.player setplayerangles( ( 0, 160, 0 ), 1 );
    }

    // Namespace quest_panic
    // Params 0, eflags: 0x4
    // Checksum 0x745f083, Offset: 0x1b5f
    // Size: 0x3f, Type: dev
    function private function_6e7ff8c9d98fcdef()
    {
        level.player setorigin( ( 20598, -14149, 4514 ), 1 );
        level.player setplayerangles( ( 0, 0, 0 ), 1 );
    }

    // Namespace quest_panic
    // Params 0, eflags: 0x4
    // Checksum 0xec439800, Offset: 0x1ba6
    // Size: 0xaf, Type: dev
    function private function_f78110f03f90b6d9()
    {
        quest = br_map_quest::get_quest( "<dev string:x292>" );
        
        foreach ( ball in quest.var_26ee2191c77f9805 )
        {
            sphere( ball.origin, 10, ( 1, 0, 0 ), 0, 1200 );
        }
    }

    // Namespace quest_panic
    // Params 0, eflags: 0x4
    // Checksum 0x438c64cd, Offset: 0x1c5d
    // Size: 0xaf, Type: dev
    function private function_8b9b30ae510ee6ed()
    {
        quest = br_map_quest::get_quest( "<dev string:x292>" );
        
        foreach ( ball in quest.keycard_spawn_locs )
        {
            sphere( ball.origin, 10, ( 0, 1, 0 ), 0, 1200 );
        }
    }

    // Namespace quest_panic
    // Params 0, eflags: 0x4
    // Checksum 0xdf5438ab, Offset: 0x1d14
    // Size: 0x3c, Type: dev
    function private debug_print_code()
    {
        quest = br_map_quest::get_quest( "<dev string:x292>" );
        iprintlnbold( quest.keypad.code[ "<dev string:x29d>" ] );
    }

#/
