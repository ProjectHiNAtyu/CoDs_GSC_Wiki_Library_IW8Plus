// script_13caa2936537a827  (hash_13caa2936537a827.gscc) (size: 7085 Bytes / 0x1bad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf31af59 (3476139865)
// size ...... 7085 (0x1bad)
// includes .. 10  (offset: 0x192d)
// strings ... 22  (offset: 0x197d)
// dev strs .. 15  (offset: 0x1aed)
// exports ... 22  (offset: 0xf1d)
// cseg ...... 0x237 + 0xce6 (0xf1d)
// imports ... 55  (offset: 0x128d)
// animtree1 . 0   (offset: 0x1bad)
// animtree2 . 0   (offset: 0x1bad)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace quest_rat;

// Namespace quest_rat
// Params 0, eflags: 0x5
// Checksum 0x5d948acd, Offset: 0x255
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"rat_cheese", #"br_map_quest", &init, undefined );
}

// Namespace quest_rat
// Params 0
// Checksum 0x8e3cb7d1, Offset: 0x27e
// Size: 0x6c
function init()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"rat_cheese" };
    br_map_quest::register( quest );
}

// Namespace quest_rat
// Params 0
// Checksum 0x6fc64965, Offset: 0x2f2
// Size: 0x1a
function on_init()
{
    set_dvars();
    function_1a00a5a2ba836d4d();
    
    /#
        debug_init();
    #/
}

// Namespace quest_rat
// Params 0
// Checksum 0x10d9ab03, Offset: 0x314
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_rat
// Params 0
// Checksum 0x8dd01d52, Offset: 0x31e
// Size: 0x10
function on_start()
{
    spawn_cheese_loot();
    spawn_rat_holes();
}

// Namespace quest_rat
// Params 0
// Checksum 0x2de40eb3, Offset: 0x336
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_rat
// Params 0
// Checksum 0x437cbdc, Offset: 0x340
// Size: 0x9
function on_infil()
{
    thread function_ed45e9d337f94678();
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0xcb117941, Offset: 0x351
// Size: 0x2c
function private set_dvars()
{
    br_map_quest::add_setting( "spawn_cheese_loot", 1 );
    br_map_quest::add_setting( "cheese_loot_count", 7 );
    br_map_quest::add_setting( "spawn_rat_holes", 1 );
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0x27004743, Offset: 0x385
// Size: 0x10c
function private function_1a00a5a2ba836d4d()
{
    self.cheese_locs = [];
    self.cheese_locs = utility::getstructarray( "brloot_wz_quest_rat_cheese", "targetname" );
    assert( isdefined( self.cheese_locs ), "<dev string:x24>" + "<dev string:x3d>" );
    self.var_db1e9cf86cfd1fc6 = [];
    self.var_db1e9cf86cfd1fc6 = utility::getstructarray( "quest_wz_rat_hole_interact", "targetname" );
    assert( isdefined( self.var_db1e9cf86cfd1fc6 ), "<dev string:x24>" + "<dev string:x5f>" );
    self.cheese_prop_locs = [];
    self.cheese_prop_locs = utility::getstructarray( "quest_wz_rat_cheese_prop", "targetname" );
    assert( isdefined( self.cheese_prop_locs ), "<dev string:x24>" + "<dev string:x74>" );
    self.pirat_locs = [];
    self.pirat_locs = utility::getstructarray( "quest_wz_rat_pirat", "targetname" );
    assert( isdefined( self.pirat_locs ), "<dev string:x24>" + "<dev string:x8c>" );
    self.wine_spawned = 0;
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0x28024542, Offset: 0x499
// Size: 0x116
function private spawn_cheese_loot()
{
    quest = br_map_quest::get_quest( "rat_cheese" );
    
    if ( !quest br_map_quest::get_setting( "spawn_cheese_loot" ) || quest.cheese_locs.size == 0 )
    {
        return;
    }
    
    var_2a8ce395b2b52bf7 = [];
    cheese_locs = arrayrandomize( quest.cheese_locs );
    cheese_spawn_count = quest br_map_quest::get_setting( "cheese_loot_count" );
    
    if ( self.cheese_locs.size < cheese_spawn_count )
    {
        cheese_spawn_count = self.cheese_locs.size;
    }
    
    for ( i = 0; i < cheese_spawn_count ; i++ )
    {
        index = int( cheese_locs[ i ].script_noteworthy );
        cheese_spawn = common_item::function_bc5ff2958b71a708( cheese_locs[ i ].origin, cheese_locs[ i ].angles );
        var_2a8ce395b2b52bf7[ index ] = common_item::items_spawnitemfromscriptable( "brloot_saw_quest_rat_cheese", 1, cheese_spawn );
    }
    
    quest.var_2a8ce395b2b52bf7 = var_2a8ce395b2b52bf7;
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0xa46012d2, Offset: 0x5b7
// Size: 0x120
function private spawn_rat_holes()
{
    quest = br_map_quest::get_quest( "rat_cheese" );
    
    if ( !quest br_map_quest::get_setting( "spawn_rat_holes" ) || quest.var_db1e9cf86cfd1fc6.size == 0 )
    {
        return;
    }
    
    var_418bb3e636719add = [];
    
    foreach ( rat_hole in quest.var_db1e9cf86cfd1fc6 )
    {
        var_9685b4fb68397edc = spawnscriptable( "quest_saw_rat_cheese_hole_interact", rat_hole.origin, rat_hole.angles );
        index = int( rat_hole.script_noteworthy );
        var_418bb3e636719add[ index ] = var_9685b4fb68397edc;
    }
    
    quest.var_418bb3e636719add = var_418bb3e636719add;
    quest function_2b91971f8e54b03b();
    quest setup_cheese_props();
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0xeb9d03d, Offset: 0x6df
// Size: 0x128
function private function_2b91971f8e54b03b()
{
    quest = br_map_quest::get_quest( "rat_cheese" );
    
    if ( !quest br_map_quest::get_setting( "spawn_rat_holes" ) || quest.pirat_locs.size == 0 )
    {
        return;
    }
    
    pirat_spawns = [];
    
    foreach ( pirat in quest.pirat_locs )
    {
        pirat_model = spawnscriptable( "quest_saw_rat_cheese_pirat", pirat.origin, pirat.angles );
        index = int( pirat.script_noteworthy );
        pirat_spawns[ index ] = pirat_model;
        quest.var_418bb3e636719add[ index ].pirat = pirat_model;
    }
    
    quest.pirat_spawns = pirat_spawns;
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0xc7f1d728, Offset: 0x80f
// Size: 0x142
function private setup_cheese_props()
{
    quest = br_map_quest::get_quest( "rat_cheese" );
    
    if ( !quest br_map_quest::get_setting( "spawn_rat_holes" ) || quest.cheese_prop_locs.size == 0 )
    {
        return;
    }
    
    cheese_prop_spawns = [];
    
    foreach ( cheese_prop_struct in quest.cheese_prop_locs )
    {
        cheese_prop_item = spawnscriptable( "quest_saw_rat_cheese_prop", cheese_prop_struct.origin, cheese_prop_struct.angles );
        index = int( cheese_prop_struct.script_noteworthy );
        cheese_prop_spawns[ index ] = cheese_prop_item;
        quest.var_418bb3e636719add[ index ].cheese_prop = cheese_prop_item;
        quest.var_418bb3e636719add[ index ].reward_spawn_loc = cheese_prop_struct;
    }
    
    quest.cheese_prop_spawns = cheese_prop_spawns;
}

// Namespace quest_rat
// Params 0, eflags: 0x4
// Checksum 0x1b7a116a, Offset: 0x959
// Size: 0xa5
function private function_ed45e9d337f94678()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_saw_rat_cheese_hole_interact", &function_f9e926fbcd8dbdb9 );
    
    foreach ( rat_hole in self.var_418bb3e636719add )
    {
        rat_hole setscriptablepartstate( "quest_saw_rat_cheese_hole_interact", "usable" );
        rat_hole setscriptablepartstate( "sfx", "loop" );
    }
}

// Namespace quest_rat
// Params 6, eflags: 0x4
// Checksum 0x9caac8c5, Offset: 0xa06
// Size: 0xf7
function private function_f9e926fbcd8dbdb9( scriptable, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "rat_cheese" );
    
    if ( state == "usable" && player br_quest_inventory::has_quest_item( "saw_consumable_quest_rat_cheese" ) )
    {
        player br_quest_inventory::consume_quest_item( "saw_consumable_quest_rat_cheese" );
        scriptable setscriptablepartstate( "quest_saw_rat_cheese_hole_interact", "disabled" );
        scriptable setscriptablepartstate( "sfx", "interact" );
        scriptable.cheese_prop setscriptablepartstate( "quest_saw_rat_cheese_prop", "interact" );
        scriptable.pirat setscriptablepartstate( "quest_saw_rat_cheese_pirat", "interact" );
        quest utility::delaythread( 3.8, &spawn_rewards, scriptable );
        player thread points::doscoreevent( #"hash_654a697a397d30e6" );
    }
}

// Namespace quest_rat
// Params 1, eflags: 0x4
// Checksum 0x1183bb5f, Offset: 0xb05
// Size: 0x129
function private spawn_rewards( rat_hole )
{
    quest = br_map_quest::get_quest( "rat_cheese" );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_loot_cache_lege" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) )
    {
        var_70a083ae58057179 = randomintrange( 3, 6 );
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( rat_hole.reward_spawn_loc.origin, rat_hole.reward_spawn_loc.angles );
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_70a083ae58057179, spawn_options );
    }
    
    if ( !quest.wine_spawned )
    {
        wine_spawn = common_item::items_initspawnoptions_spawnfromposition( rat_hole.reward_spawn_loc.origin, rat_hole.reward_spawn_loc.angles );
        wine_loot = common_item::items_spawnitemfromscriptable( "brloot_saw_quest_wine_rack_wine", 1, wine_spawn );
        quest.wine_spawned = 1;
    }
    
    rat_hole setscriptablepartstate( "quest_saw_rat_cheese_hole_interact", "usable" );
}

// Namespace quest_rat
// Params 1, eflags: 0x4
// Checksum 0x918754bb, Offset: 0xc36
// Size: 0x4c
function private quest_complete( player )
{
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:1 };
    br_map_quest::on_completed( params );
}

/#

    // Namespace quest_rat
    // Params 0, eflags: 0x4
    // Checksum 0xe0b79cfc, Offset: 0xc8a
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace quest_rat
    // Params 0, eflags: 0x4
    // Checksum 0x1ae4b7a7, Offset: 0xc9e
    // Size: 0x60, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x9e>" + "<dev string:xad>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb9>", "<dev string:xc6>", &devgui_rat_cheese );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd9>", "<dev string:xe8>", &devgui_rat_cheese );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfb>", "<dev string:x107>", &devgui_rat_cheese );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_rat
    // Params 1, eflags: 0x4
    // Checksum 0x338ec98e, Offset: 0xd06
    // Size: 0x19, Type: dev
    function private devgui_rat_cheese( params )
    {
        level thread debug_rat_cheese( params );
    }

    // Namespace quest_rat
    // Params 1
    // Checksum 0x648d9e70, Offset: 0xd27
    // Size: 0x1f6, Type: dev
    function debug_rat_cheese( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x11a>" );
        player = level.player;
        
        switch ( int( params[ 0 ] ) )
        {
            case 0:
                v_spawn_pos = devgui::function_97024c0a6d1256a6();
                bundle = common_item::function_cf68ad18114498b2( "<dev string:x125>" );
                spawn_options = common_item::function_bc5ff2958b71a708( v_spawn_pos );
                spawn_options.critical = 1;
                cheese_item = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
                break;
            case 1:
                foreach ( var_12d72740175e8cac in quest.var_418bb3e636719add )
                {
                    sphere( var_12d72740175e8cac.origin, 25, ( 0, 0, 1 ), 0, 600 );
                }
                
                break;
            case 2:
                foreach ( var_5baf88721a84cc3b in quest.var_2a8ce395b2b52bf7 )
                {
                    sphere( var_5baf88721a84cc3b.origin, 25, ( 1, 0, 0 ), 0, 600 );
                }
                
                break;
        }
    }

#/
