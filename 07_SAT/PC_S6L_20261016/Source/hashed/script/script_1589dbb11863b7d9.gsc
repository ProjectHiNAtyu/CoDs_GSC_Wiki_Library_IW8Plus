// script_1589dbb11863b7d9  (hash_1589dbb11863b7d9.gscc) (size: 8139 Bytes / 0x1fcb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1f2cd14 (3790785812)
// size ...... 8139 (0x1fcb)
// includes .. 8   (offset: 0x1c9f)
// strings ... 28  (offset: 0x1cdf)
// dev strs .. 28  (offset: 0x1e6f)
// exports ... 26  (offset: 0x1067)
// cseg ...... 0x27d + 0xdea (0x1067)
// imports ... 69  (offset: 0x1477)
// animtree1 . 0   (offset: 0x1fcb)
// animtree2 . 0   (offset: 0x1fcb)
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace quest_wine_rack;

// Namespace quest_wine_rack
// Params 0, eflags: 0x5
// Checksum 0x779a8d5f, Offset: 0x29b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"wine_rack", #"br_map_quest", &init, undefined );
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x70f55c38, Offset: 0x2c4
// Size: 0x6c
function init()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"wine_rack" };
    br_map_quest::register( quest );
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x2a56b1e, Offset: 0x338
// Size: 0x28
function on_init()
{
    set_dvars();
    function_1a00a5a2ba836d4d();
    cache_ents();
    set_quest_variables();
    
    /#
        debug_init();
    #/
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0xe17659b5, Offset: 0x368
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x30002034, Offset: 0x372
// Size: 0x2
function on_start()
{
    
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0xdc4bfc05, Offset: 0x37c
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x76eb76bb, Offset: 0x386
// Size: 0x1e
function on_infil()
{
    spawn_wine();
    spawn_items();
    spawn_caches();
    setup_wine_rack();
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x4e08aa32, Offset: 0x3ac
// Size: 0x59
function set_dvars()
{
    br_map_quest::add_setting( "cache_loot_zone", "wz_sat_resurgence_zone_global" );
    br_map_quest::add_setting( "spawn_wine_loot", 1 );
    br_map_quest::add_setting( "wine_loot_count", 3 );
    br_map_quest::add_setting( "wine_required_count", 3 );
    br_map_quest::add_setting( "num_staged_items", 3 );
    br_map_quest::add_setting( "num_caches", 2 );
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0x890810cd, Offset: 0x40d
// Size: 0x2a
function private set_quest_variables()
{
    self.num_caches = br_map_quest::get_setting( "num_caches" );
    self.num_staged_items = br_map_quest::get_setting( "num_staged_items" );
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x8d1413e1, Offset: 0x43f
// Size: 0x11b
function function_1a00a5a2ba836d4d()
{
    self.wine_locs = utility::getstructarray( "quest_wine_bottle_spawn", "targetname" );
    assert( isdefined( self.wine_locs ) && self.wine_locs.size > 0, "<dev string:x24>" + "<dev string:x43>" );
    self.item_locs = utility::getstructarray( "quest_wine_item", "targetname" );
    assert( isdefined( self.item_locs ) && self.item_locs.size > 0, "<dev string:x24>" + "<dev string:x53>" );
    self.cache_locs = utility::getstructarray( "quest_wine_cache", "targetname" );
    assert( isdefined( self.cache_locs ) && self.cache_locs.size > 0, "<dev string:x24>" + "<dev string:x64>" );
    self.wine_prop_locs = [ ( 18, 20, 47 ), ( 18, 25, 47 ), ( 18, 30, 47 ) ];
    self.wine_prop_index = 0;
}

// Namespace quest_wine_rack
// Params 0
// Checksum 0x14841348, Offset: 0x562
// Size: 0x6a
function cache_ents()
{
    self.wine_rack = getent( "quest_wine_rack", "targetname" );
    assert( isdefined( self.wine_rack ), "<dev string:x76>" + "<dev string:x92>" );
    self.wine_rack_clip = getent( "wine_rack_clip", "targetname" );
    assert( isdefined( self.wine_rack_clip ), "<dev string:x76>" + "<dev string:xa7>" );
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0xa49ddd77, Offset: 0x5d4
// Size: 0xfe
function private spawn_wine()
{
    quest = br_map_quest::get_quest( "wine_rack" );
    
    if ( !quest br_map_quest::get_setting( "spawn_wine_loot" ) || quest.wine_locs.size == 0 )
    {
        return;
    }
    
    wine_loot_spawns = [];
    wine_locs = arrayrandomize( quest.wine_locs );
    wine_spawn_count = quest br_map_quest::get_setting( "wine_loot_count" );
    
    if ( quest.wine_locs.size < wine_spawn_count )
    {
        wine_spawn_count = quest.wine_locs.size;
    }
    
    for ( i = 0; i < wine_spawn_count ; i++ )
    {
        wine_spawn = common_item::function_bc5ff2958b71a708( wine_locs[ i ].origin, wine_locs[ i ].angles );
        wine_loot_spawns[ i ] = common_item::items_spawnitemfromscriptable( "brloot_saw_quest_wine_rack_wine", 1, wine_spawn );
    }
    
    quest.wine_loot_spawns = wine_loot_spawns;
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0x7452e035, Offset: 0x6da
// Size: 0x37
function private spawn_items()
{
    for ( i = 0; i < self.num_staged_items ; i++ )
    {
        spawn_item_individual( self.item_locs[ i ] );
    }
}

// Namespace quest_wine_rack
// Params 1, eflags: 0x4
// Checksum 0xdb251777, Offset: 0x719
// Size: 0xc0
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
    
    if ( scriptable.model == "carepackage_base" )
    {
        scriptable.angles += ( 0, -90, 0 );
    }
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0xfd76a255, Offset: 0x7e1
// Size: 0x109
function private spawn_caches()
{
    quest = br_map_quest::get_quest( "wine_rack" );
    loot_zone = br_map_quest::get_setting( "cache_loot_zone" );
    quest.cache_locs = arrayrandomize( quest.cache_locs );
    caches_spawned = 0;
    
    foreach ( loc in quest.cache_locs )
    {
        if ( caches_spawned == quest.num_caches )
        {
            continue;
        }
        
        script_cache = common_cache::function_9bc018c1b8aad720( "br_loot_cache_lege", loc.origin, loc.angles, undefined, loot_zone );
        caches_spawned++;
    }
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0xc0dc305b, Offset: 0x8f2
// Size: 0x12e
function private setup_wine_rack()
{
    wine_prop_spawns = [];
    
    foreach ( wine_prop_loc in self.wine_prop_locs )
    {
        wine_prop = spawnscriptable( "quest_saw_wine_rack_wine_prop", wine_prop_loc );
        wine_prop scriptablesetparententity( self.wine_rack, wine_prop_loc, ( -65, 0, 0 ) );
        wine_prop setscriptablepartstate( "model", "hidden" );
        wine_prop_spawns[ wine_prop_spawns.size ] = wine_prop;
    }
    
    self.wine_props = wine_prop_spawns;
    self.wine_rack_clip linkto( self.wine_rack );
    self.wine_rack_fx = spawnscriptable( "quest_saw_wine_rack_fx", self.wine_rack.origin );
    self.wine_rack_fx scriptablesetparententity( self.wine_rack );
    function_92500fc5d98841be();
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0x98b0e413, Offset: 0xa28
// Size: 0xb8
function private function_92500fc5d98841be()
{
    v = self.wine_rack.origin;
    v += anglestoforward( self.wine_rack.angles ) * 10;
    v += anglestoright( self.wine_rack.angles ) * -25;
    v += ( 0, 0, 55 );
    interact = interaction::register_interact( v, 64, &function_9a22ebbcaa783b2c );
    interact interaction::set_interact_hint_callback( &function_27f0ec74bba4c1c );
    interact setusableenabled( 1 );
    interact sethintonobstruction( "show" );
    self.wine_rack_interact = interact;
}

// Namespace quest_wine_rack
// Params 1, eflags: 0x4
// Checksum 0x5c32e8b2, Offset: 0xae8
// Size: 0xa8
function private function_9a22ebbcaa783b2c( player )
{
    quest = br_map_quest::get_quest( "wine_rack" );
    
    if ( quest.wine_prop_index < 3 && player br_quest_inventory::has_quest_item( "wz_consumable_saw_quest_wine_rack_wine" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_saw_quest_wine_rack_wine" );
        quest.wine_props[ quest.wine_prop_index ] setscriptablepartstate( "model", "visible" );
        quest.wine_prop_index++;
        
        if ( quest.wine_prop_index == 3 )
        {
            quest move_shelf();
            quest_complete( player );
        }
    }
}

// Namespace quest_wine_rack
// Params 0, eflags: 0x4
// Checksum 0x54c643d7, Offset: 0xb98
// Size: 0x74
function private move_shelf()
{
    self.wine_rack_origin = self.wine_rack.origin;
    self.wine_rack_fx setscriptablepartstate( "vfx", "visible" );
    self.wine_rack moveto( self.wine_rack.origin + anglestoright( self.wine_rack.angles ) * -110, 5 );
}

// Namespace quest_wine_rack
// Params 2, eflags: 0x4
// Checksum 0x266bad, Offset: 0xc14
// Size: 0x68
function private function_27f0ec74bba4c1c( interact, player )
{
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_saw_quest_wine_rack_wine" ) )
    {
        return { #string:&"hash_5064228e41f8f19c", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace quest_wine_rack
// Params 1, eflags: 0x4
// Checksum 0x47c47982, Offset: 0xc85
// Size: 0x58
function private quest_complete( player )
{
    if ( isdefined( self.wine_rack_interact ) )
    {
        self.wine_rack_interact delete();
    }
    
    params = { #completed_by:[ player ], #is_successful:1 };
    br_map_quest::on_completed( params );
}

/#

    // Namespace quest_wine_rack
    // Params 0, eflags: 0x4
    // Checksum 0x33719b25, Offset: 0xce5
    // Size: 0x16, Type: dev
    function private debug_init()
    {
        devgui_init();
        self.var_6e918fbbece6ba20 = 0;
    }

    // Namespace quest_wine_rack
    // Params 0, eflags: 0x4
    // Checksum 0x9154bc74, Offset: 0xd03
    // Size: 0xb8, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xc1>" + "<dev string:xd0>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdb>", "<dev string:xe6>", &devgui_wine_rack );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf8>", "<dev string:x107>", &devgui_wine_rack );
        devgui::function_cd4e263c1f3018ae( "<dev string:x119>", "<dev string:x123>", &devgui_wine_rack );
        devgui::function_cd4e263c1f3018ae( "<dev string:x135>", "<dev string:x14d>", &devgui_wine_rack );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15f>", "<dev string:x175>", &devgui_wine_rack );
        devgui::function_cd4e263c1f3018ae( "<dev string:x187>", "<dev string:x194>", &devgui_wine_rack );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a6>", "<dev string:x1b6>", &devgui_wine_rack );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_wine_rack
    // Params 1, eflags: 0x4
    // Checksum 0x27d805df, Offset: 0xdc3
    // Size: 0x19, Type: dev
    function private devgui_wine_rack( params )
    {
        level thread debug_wine_rack( params );
    }

    // Namespace quest_wine_rack
    // Params 1
    // Checksum 0x6274e806, Offset: 0xde4
    // Size: 0x283, Type: dev
    function debug_wine_rack( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x1c8>" );
        
        switch ( int( params[ 0 ] ) )
        {
            case 0:
                level thread spawn_wine();
                break;
            case 1:
                sphere( quest.wine_rack.origin, 25, ( 0, 1, 0 ), 0, 600 );
                break;
            case 2:
                foreach ( wine in quest.wine_loot_spawns )
                {
                    sphere( wine.origin, 25, ( 1, 0, 0 ), 0, 600 );
                }
                
                break;
            case 3:
                level.player setorigin( quest.wine_locs[ quest.var_6e918fbbece6ba20 ].origin );
                quest.var_6e918fbbece6ba20++;
                
                if ( quest.var_6e918fbbece6ba20 == quest.wine_locs.size )
                {
                    quest.var_6e918fbbece6ba20 = 0;
                }
                
                break;
            case 4:
                level.player setorigin( quest.wine_rack.origin );
                break;
            case 5:
                if ( quest.wine_prop_index != 3 )
                {
                    quest.wine_props[ quest.wine_prop_index ] setscriptablepartstate( "<dev string:x1d2>", "<dev string:x1d8>" );
                    quest.wine_prop_index++;
                }
                
                if ( quest.wine_prop_index == 3 )
                {
                    quest move_shelf();
                }
                
                break;
            case 6:
                quest.wine_rack moveto( quest.wine_rack_origin, 0.3 );
                quest.wine_rack_fx setscriptablepartstate( "<dev string:x1e0>", "<dev string:x1e4>" );
                break;
        }
    }

#/
