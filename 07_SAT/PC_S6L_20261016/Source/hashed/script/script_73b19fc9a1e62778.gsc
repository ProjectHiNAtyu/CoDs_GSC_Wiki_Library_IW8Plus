// script_73b19fc9a1e62778  (hash_73b19fc9a1e62778.gscc) (size: 8170 Bytes / 0x1fea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41e68f5b (1105629019)
// size ...... 8170 (0x1fea)
// includes .. 17  (offset: 0x1d26)
// strings ... 32  (offset: 0x1dae)
// dev strs .. 12  (offset: 0x1f56)
// exports ... 26  (offset: 0x1046)
// cseg ...... 0x372 + 0xcd4 (0x1046)
// imports ... 77  (offset: 0x1456)
// animtree1 . 0   (offset: 0x1fea)
// animtree2 . 0   (offset: 0x1fea)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\interactive_notes;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_publicevent_jailbreak;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\vehicles\vehicle_upgrade_mp;

#namespace namespace_f5481714c4a184a6;

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x5
// Checksum 0xad369480, Offset: 0x390
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"sm_island_police", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0x397fa92e, Offset: 0x3b9
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"sm_island_police" };
    br_map_quest::register( quest );
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0x247c841e, Offset: 0x43b
// Size: 0x28
function on_init()
{
    /#
        debug_init();
    #/
    
    set_dvars();
    function_1a00a5a2ba836d4d();
    set_quest_variables();
    vehicle_upgrade_mp::init();
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0x65037d59, Offset: 0x46b
// Size: 0x3e
function on_precache()
{
    self.vehicle_spawn = utility::getstruct( "quest_police_vehicle_spawn" );
    self.kiosk_interact_location = utility::getstruct( "quest_police_kiosk_interact" );
    self.note_spawn_locations = utility::getstructarray( "quest_police_note_spawn" );
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0xb44fd88d, Offset: 0x4b1
// Size: 0x42
function on_start()
{
    [ self.var_53f3c3f754962461 ] = getentitylessscriptablearray( undefined, undefined, ( -10864.5, 391.737, 495 ), 10, "door" );
    self.var_53f3c3f754962461 scriptabledoorlock();
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0x6f898219, Offset: 0x4fb
// Size: 0x19d
function on_prematch_end()
{
    level callback::add( #"hash_2c631dc23e0ee99b", &on_kiosk_purchase );
    self.kiosk_interact = interaction::register_interact( self.kiosk_interact_location.origin, 100, &on_kiosk_interact, &"hash_7affbf6697c52245" );
    shuffled_locations = arrayrandomize( self.note_spawn_locations );
    notes = [ "sm_island_police_code_1", "sm_island_police_code_2", "sm_island_police_code_3" ];
    
    foreach ( index, note in notes )
    {
        self.note_spawn_location = shuffled_locations[ index ];
        data = interactive_notes::create_note_data( note, "interactive_note_paper_secret" );
        interactive_notes::spawn_note( data, self.note_spawn_location.origin, self.note_spawn_location.angles );
    }
    
    self.kiosk_interact.overrideindex = common_kiosk::function_9d041619b6fccf18( "saw_sm_island_police" );
    common_kiosk::function_b1b75e4a51094d62( self.kiosk_interact.overrideindex );
    self.kiosk_interact.index = 999;
    self.valid_teams = [];
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0xf55c6c54, Offset: 0x6a0
// Size: 0xf5
function on_infil()
{
    keypad_init();
    self.vehicle_spawn.script_godmode = 1;
    self.vehicle = vehicle::spawn( br_map_quest::get_setting( "truck_vehicle_name" ), self.vehicle_spawn );
    self.vehicle vehicleshowonminimap( 0 );
    self.vehicle vehicle_upgrade_mp::function_9dc6bd75359eed96( "Perception" );
    self.vehicle.var_c1ccc445c80a83c0[ "Perception" ] = undefined;
    self.vehicle utility::callsharedfunc( #"vehicle_upgrade", #"hash_cfb734e8d4dbc90e" );
    self.vehicle vehicle_occupancy::lock();
    vehicle_interact::allow_use( self.vehicle, 0 );
    self.locked_interact = spawnscriptable( "quest_police_locked_interact", self.vehicle_spawn.origin );
    spawn_items();
    spawn_caches();
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0xef135c5a, Offset: 0x79d
// Size: 0x2
function on_disabled()
{
    
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0x276481a2, Offset: 0x7a7
// Size: 0x4e
function set_dvars()
{
    br_map_quest::add_setting( "cache_loot_zone", "wz_sat_resurgence_zone_global" );
    br_map_quest::add_setting( "num_staged_items", 4 );
    br_map_quest::add_setting( "num_lege_caches", 1 );
    br_map_quest::add_setting( "num_refillable_caches", 1 );
    br_map_quest::add_setting( "truck_vehicle_name", "veh_sat_wz_hp_pol_ltv" );
}

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x4
// Checksum 0x1cb8be94, Offset: 0x7fd
// Size: 0x3e
function private set_quest_variables()
{
    self.num_lege_caches = br_map_quest::get_setting( "num_lege_caches" );
    self.num_refillable_caches = br_map_quest::get_setting( "num_refillable_caches" );
    self.num_staged_items = br_map_quest::get_setting( "num_staged_items" );
}

// Namespace namespace_f5481714c4a184a6
// Params 0
// Checksum 0xfd62fd64, Offset: 0x843
// Size: 0x8e
function function_1a00a5a2ba836d4d()
{
    self.item_locs = utility::getstructarray( "quest_dirty_cop_item", "targetname" );
    assert( isdefined( self.item_locs ) && self.item_locs.size > 0, "<dev string:x24>" + "<dev string:x51>" );
    self.cache_locs = utility::getstructarray( "quest_dirty_cop_cache", "targetname" );
    assert( isdefined( self.cache_locs ) && self.cache_locs.size > 0, "<dev string:x24>" + "<dev string:x62>" );
}

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x4
// Checksum 0x4f273ac9, Offset: 0x8d9
// Size: 0xb1
function private spawn_items()
{
    num_items = min( self.num_staged_items, self.item_locs.size );
    self.item_dvars = [ "wz_item_quest_black_market":@"scr_br_black_market_enabled" ];
    
    for ( i = 0; i < num_items ; i++ )
    {
        item_name = self.item_locs[ i ].script_noteworthy;
        
        if ( self.item_dvars[ item_name ] && getdvarint( self.item_dvars[ item_name ] ) <= 0 )
        {
            continue;
        }
        
        spawn_item_individual( self.item_locs[ i ] );
    }
}

// Namespace namespace_f5481714c4a184a6
// Params 1, eflags: 0x4
// Checksum 0xc64d10a3, Offset: 0x992
// Size: 0xc6
function private spawn_item_individual( staged_loc )
{
    if ( !isdefined( staged_loc.script_noteworthy ) )
    {
        return;
    }
    
    item_bundle = getscriptbundle( "itemspawnentry:" + staged_loc.script_noteworthy );
    spawnoptions = common_item::function_bc5ff2958b71a708( staged_loc.origin, staged_loc.angles );
    spawnoptions.critical = 1;
    scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
    
    if ( isdefined( scriptable ) && scriptable getscriptableparthasstate( scriptable.type, #"visible_staged_weapon" ) )
    {
        scriptable setscriptablepartstate( scriptable.type, #"visible_staged_weapon" );
    }
}

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x4
// Checksum 0x65b8171a, Offset: 0xa60
// Size: 0x16c
function private spawn_caches()
{
    quest = br_map_quest::get_quest( "sm_island_police" );
    loot_zone = br_map_quest::get_setting( "cache_loot_zone" );
    quest.cache_locs = arrayrandomize( quest.cache_locs );
    var_c109ad55933287e4 = 0;
    var_bed793fa4473da89 = 0;
    
    foreach ( loc in quest.cache_locs )
    {
        if ( var_c109ad55933287e4 < quest.num_lege_caches )
        {
            common_cache::function_9bc018c1b8aad720( "br_loot_cache_lege", loc.origin, loc.angles, undefined, loot_zone );
            var_c109ad55933287e4++;
            continue;
        }
        
        if ( var_bed793fa4473da89 < quest.num_refillable_caches )
        {
            common_cache::function_9bc018c1b8aad720( "br_reusable_loot_cache", loc.origin, loc.angles, undefined, loot_zone );
            var_bed793fa4473da89++;
            continue;
        }
        
        common_cache::function_9bc018c1b8aad720( "br_loot_cache", loc.origin, loc.angles, undefined, loot_zone );
    }
}

// Namespace namespace_f5481714c4a184a6
// Params 1, eflags: 0x4
// Checksum 0x2e438450, Offset: 0xbd4
// Size: 0x5c
function private on_kiosk_interact( player )
{
    quest = br_map_quest::get_quest( "sm_island_police" );
    
    if ( quest.valid_teams[ player.team ] )
    {
        player thread common_kiosk::_runpurchasemenu( self );
        return;
    }
    
    player keypad_use( self.keypad );
}

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x4
// Checksum 0x2ca8daa7, Offset: 0xc38
// Size: 0x74
function private keypad_init()
{
    var_892fa6c4bb99e393 = "1234";
    self.kiosk_interact.keypad = { #quest:self, #var_f026366dba547f4c:1, #successfunction:&function_561e78789b4d65a6, #code:[ "string":var_892fa6c4bb99e393 ], #script_codelength:var_892fa6c4bb99e393.size, #backwallkeypad:1 };
}

// Namespace namespace_f5481714c4a184a6
// Params 1, eflags: 0x4
// Checksum 0x3321dca4, Offset: 0xcb4
// Size: 0x22
function private keypad_use( keypad )
{
    br_bunker_utility::keypad_playerinteractwithkeypadloop( keypad );
    
    if ( isdefined( self ) )
    {
        br_keypad_util::playersetkeypadstateindex( 0 );
    }
}

// Namespace namespace_f5481714c4a184a6
// Params 1, eflags: 0x4
// Checksum 0x99535736, Offset: 0xcde
// Size: 0x4a
function private function_561e78789b4d65a6( keypad )
{
    keypad.quest.valid_teams[ self.team ] = 1;
    thread common_kiosk::_runpurchasemenu( keypad.quest.kiosk_interact );
}

// Namespace namespace_f5481714c4a184a6
// Params 1, eflags: 0x4
// Checksum 0xa03dc395, Offset: 0xd30
// Size: 0xa4
function private on_kiosk_purchase( params )
{
    quest = br_map_quest::get_quest( "sm_island_police" );
    
    switch ( params.itemdata.ref )
    {
        case #"hash_e914dd85b50fa462":
            quest.var_53f3c3f754962461 scriptabledoorunlock();
            playsoundatpos( ( -10841, 338, 545 ), "evt_dirty_cop_door_unlock" );
            break;
        case #"hash_e914dc85b50fa2cf":
            quest function_f91eb6e3495319b4();
            break;
        case #"hash_e914db85b50fa13c":
            function_ee2bbd3ffc77c64f();
            break;
    }
}

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x4
// Checksum 0xa0f79752, Offset: 0xddc
// Size: 0x6f
function private function_f91eb6e3495319b4()
{
    self.vehicle vehicle_occupancy::unlock();
    self.vehicle vehicleshowonminimap( 1 );
    self.vehicle.godmode = 0;
    self.locked_interact freescriptable();
    vehicle_interact::allow_use( self.vehicle, 1 );
    self.vehicle setscriptablepartstate( "upgrade_usable", "upgrade_unusable" );
}

// Namespace namespace_f5481714c4a184a6
// Params 0, eflags: 0x4
// Checksum 0xa735ede0, Offset: 0xe53
// Size: 0x8f
function private function_ee2bbd3ffc77c64f()
{
    playerlist = br_publicevent_jailbreak::buildrespawnlist( 0 );
    
    foreach ( player in playerlist )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread br_publicevent_jailbreak::respawnplayer();
    }
}

/#

    // Namespace namespace_f5481714c4a184a6
    // Params 0, eflags: 0x4
    // Checksum 0x455f365f, Offset: 0xeea
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_f5481714c4a184a6
    // Params 0, eflags: 0x4
    // Checksum 0x6debbc7a, Offset: 0xefe
    // Size: 0x60, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x74>" + "<dev string:x83>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8e>", "<dev string:xa0>", &function_389b04cb84e6069a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb2>", "<dev string:xc3>", &function_389b04cb84e6069a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd5>", "<dev string:xdf>", &function_389b04cb84e6069a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_f5481714c4a184a6
    // Params 1, eflags: 0x4
    // Checksum 0x1f53a328, Offset: 0xf66
    // Size: 0x19, Type: dev
    function private function_389b04cb84e6069a( params )
    {
        level thread function_d4639d4c851229b3( params );
    }

    // Namespace namespace_f5481714c4a184a6
    // Params 1
    // Checksum 0xbfa12802, Offset: 0xf87
    // Size: 0xbf, Type: dev
    function function_d4639d4c851229b3( params )
    {
        quest = br_map_quest::get_quest( "<dev string:xf1>" );
        player = level.players[ 0 ];
        
        switch ( int( params[ 0 ] ) )
        {
            case 0:
                player setorigin( quest.kiosk_interact.origin );
                break;
            case 1:
                player setorigin( quest.var_53f3c3f754962461.origin );
                break;
            case 2:
                quest.var_53f3c3f754962461 scriptabledoorunlock();
                break;
        }
    }

#/
