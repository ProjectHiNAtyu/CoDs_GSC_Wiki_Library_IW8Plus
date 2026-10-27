// script_59557cacb75c2176  (hash_59557cacb75c2176.gscc) (size: 10467 Bytes / 0x28e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8fb4c4fe (2410988798)
// size ...... 10467 (0x28e3)
// includes .. 13  (offset: 0x2533)
// strings ... 39  (offset: 0x259b)
// dev strs .. 20  (offset: 0x27b7)
// exports ... 35  (offset: 0x1487)
// cseg ...... 0x3af + 0x10d8 (0x1487)
// imports ... 96  (offset: 0x19ff)
// animtree1 . 0   (offset: 0x28e3)
// animtree2 . 0   (offset: 0x28e3)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\interactive_notes;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_1136765c63eb0dbe;

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x5
// Checksum 0x34e92e90, Offset: 0x3cd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_waterfall", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0xc4a0e55e, Offset: 0x3f6
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_waterfall" };
    br_map_quest::register( quest );
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0x6d9a4483, Offset: 0x478
// Size: 0x53
function on_init()
{
    apply_settings();
    function_1a00a5a2ba836d4d();
    register_callbacks();
    set_quest_variables();
    waterfall_cave_clip = getent( "waterfall_cave_clip", #targetname );
    
    if ( isdefined( waterfall_cave_clip ) )
    {
        waterfall_cave_clip delete();
    }
    
    /#
        debug_init();
    #/
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0xa17e3649, Offset: 0x4d3
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0xf6d9e32b, Offset: 0x4dd
// Size: 0x10
function on_start()
{
    function_80e5aa744355852f();
    spawn_caches();
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0x9c4393f9, Offset: 0x4f5
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0x9d951645, Offset: 0x4ff
// Size: 0x9
function on_infil()
{
    spawn_digsites();
}

// Namespace namespace_1136765c63eb0dbe
// Params 0
// Checksum 0x4859d542, Offset: 0x510
// Size: 0x2
function on_disabled()
{
    
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0x6048a1c4, Offset: 0x51a
// Size: 0x5d
function private apply_settings()
{
    br_map_quest::add_setting( "num_lege_caches", 1 );
    br_map_quest::add_setting( "num_staged_weapons", 1 );
    br_map_quest::add_setting( "guaranteed_staged_weapon_list", "" );
    br_map_quest::add_setting( "cache_loot_zone", "wz_sat_resurgence_zone_global" );
    br_map_quest::add_setting( "reward_amount", 1000 );
    br_map_quest::add_setting( "map_triggers_digsite_spawn", 1 );
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0x248847b, Offset: 0x57f
// Size: 0x73
function private set_quest_variables()
{
    self.num_lege_caches = br_map_quest::get_setting( "num_lege_caches" );
    self.num_staged_weapons = br_map_quest::get_setting( "num_staged_weapons" );
    self.reward_amount = br_map_quest::get_setting( "reward_amount" );
    
    if ( game_utility::function_f24780eadd3fb772() > 2 )
    {
        self.num_lege_caches++;
        self.num_staged_weapons++;
        self.reward_amount *= 2;
    }
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0xf42e869a, Offset: 0x5fa
// Size: 0x6b
function private function_1a00a5a2ba836d4d()
{
    self.digsite_locs = utility::getstructarray( "quest_saw_digsite", "script_noteworthy" );
    self.staged_locs = utility::getstructarray( "waterfall_weapon" );
    self.cache_locs = utility::getstructarray( "waterfall_cache" );
    self.var_9c54ed363be18982 = utility::getstruct( "waterfall_map_location" );
    self.lower_note_location = utility::getstruct( "waterfall_lower_note_location" );
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0x2263ab8f, Offset: 0x66d
// Size: 0x2
function private register_callbacks()
{
    
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0xe2033b6d, Offset: 0x677
// Size: 0xaf
function private spawn_digsites()
{
    self.digsites = [];
    
    /#
        if ( getdvarint( @"hash_95dab018f303ff30" ) )
        {
            function_11a43a132e927706();
            return;
        }
    #/
    
    self.selected_digsite = utility::array_random( self.digsite_locs );
    
    if ( !br_map_quest::get_setting( "map_triggers_digsite_spawn" ) )
    {
        digsite = spawn_digsite( self.selected_digsite );
    }
    
    /#
        if ( getdvarint( @"scr_debug_waterfall" ) )
        {
            debug::sphere( digsite, 1, "<dev string:x24>", undefined, "<dev string:x2a>" );
            debug::sphere( digsite, 150, "<dev string:x24>", undefined, "<dev string:x2a>" );
        }
    #/
    
    thread function_9ad16710ca258c00();
}

// Namespace namespace_1136765c63eb0dbe
// Params 1, eflags: 0x4
// Checksum 0x1de67293, Offset: 0x72e
// Size: 0xec
function private spawn_digsite( digsite_struct )
{
    digsite = spawnscriptable( "quest_saw_digsite", digsite_struct.origin, digsite_struct.angles, undefined, function_67b78af3c33ac9a8( 0.25 ) );
    digsite setscriptablepartstate( "quest_saw_digsite", "visible" );
    interact = interaction::register_interact( digsite.origin + ( 0, 0, 30 ), 100, &digsite_used, &"mp_saw_manticore/dig" );
    interact.digsite = digsite;
    digsite.quest = self;
    digsite.var_e81b202b17e54a69 = isdefined( digsite_struct.script_label ) && int( digsite_struct.script_label ) > 0;
    self.digsites[ self.digsites.size ] = digsite;
    return digsite;
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0xbc5dc3e0, Offset: 0x823
// Size: 0x54
function private function_9ad16710ca258c00()
{
    function_ae2e5315da76b962();
    data = interactive_notes::create_note_data( "manticore_waterfall_lower", "interactive_note_paper" );
    interactive_notes::spawn_note( data, self.lower_note_location.origin, self.lower_note_location.angles );
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0x986c680b, Offset: 0x87f
// Size: 0x9b
function private function_ae2e5315da76b962()
{
    data = interactive_notes::create_note_data( "manticore_waterfall_map", "interactive_note_scroll_secret", self.selected_digsite.targetname );
    note = interactive_notes::spawn_note( data, self.var_9c54ed363be18982.origin, self.var_9c54ed363be18982.angles );
    note.quest = self;
    
    if ( br_map_quest::get_setting( "map_triggers_digsite_spawn" ) )
    {
        note callback::add( #"interactive_note_scriptable_used", &function_ef2b7c8e881ec3bb );
    }
}

// Namespace namespace_1136765c63eb0dbe
// Params 1, eflags: 0x4
// Checksum 0x6054382a, Offset: 0x922
// Size: 0x72
function private function_ef2b7c8e881ec3bb( params )
{
    params.instance callback::remove( #"interactive_note_scriptable_used", &function_ef2b7c8e881ec3bb );
    digsite = params.instance.quest spawn_digsite( params.instance.quest.selected_digsite );
}

// Namespace namespace_1136765c63eb0dbe
// Params 1, eflags: 0x4
// Checksum 0xb68628ec, Offset: 0x99c
// Size: 0x65
function private digsite_used( player )
{
    if ( self.var_60a18211288345a4 )
    {
        return;
    }
    
    self.var_60a18211288345a4 = player;
    self.digsite setscriptablepartstate( "quest_saw_digsite", self.digsite.var_e81b202b17e54a69 ? "digging_water" : "digging" );
    level thread function_54b9c35a614fb303( self, player );
}

// Namespace namespace_1136765c63eb0dbe
// Params 2, eflags: 0x4
// Checksum 0x354f9818, Offset: 0xa09
// Size: 0xf3
function private function_54b9c35a614fb303( instance, player )
{
    level endon( #"game_ended" );
    level childthread function_34e789bb81b0cc2( player );
    level childthread function_849ba9ef5ac4b429( player );
    msg = player utility::waittill_any_timeout( 3, "digsite_player_invalid", "digsite_interact_canceled" );
    player notify( #"hash_afd4f5926302837f" );
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0 );
    instance.var_60a18211288345a4 = undefined;
    
    if ( msg == "timeout" )
    {
        instance.digsite setscriptablepartstate( "quest_saw_digsite", instance.digsite.var_e81b202b17e54a69 ? "complete_water" : "complete" );
        digsite_complete( instance, player );
        return;
    }
    
    instance.digsite setscriptablepartstate( "quest_saw_digsite", "visible" );
}

// Namespace namespace_1136765c63eb0dbe
// Params 1, eflags: 0x4
// Checksum 0x622afe8e, Offset: 0xb04
// Size: 0x49
function private function_34e789bb81b0cc2( player )
{
    player endon( #"hash_afd4f5926302837f" );
    msg = player utility::waittill_any( "death_or_disconnect", "last_stand_ended", "meatshield_victim_grabbed" );
    player notify( #"digsite_player_invalid" );
}

// Namespace namespace_1136765c63eb0dbe
// Params 1, eflags: 0x4
// Checksum 0x8ae4781e, Offset: 0xb55
// Size: 0x9c
function private function_849ba9ef5ac4b429( player )
{
    player endon( #"hash_afd4f5926302837f" );
    t = 0;
    time = 3;
    player setclientomnvar( "ui_securing", 1 );
    var_421373cd9e815b0f = gettime();
    
    while ( gettime() - var_421373cd9e815b0f < 250 )
    {
        if ( player usebuttonpressed() )
        {
            var_421373cd9e815b0f = gettime();
        }
        
        player setclientomnvar( "ui_securing_progress", t / time );
        t += level.framedurationseconds;
        waitframe();
    }
    
    player notify( #"digsite_interact_canceled" );
}

// Namespace namespace_1136765c63eb0dbe
// Params 2, eflags: 0x4
// Checksum 0xf49a3477, Offset: 0xbf9
// Size: 0x106
function private digsite_complete( instance, player )
{
    origin = getgroundposition( instance.origin, 0 );
    angles = vectortoangles( player.origin - ( instance.origin[ 0 ], instance.origin[ 1 ], player.origin[ 2 ] ) );
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( origin, angles );
    quest = br_map_quest::get_quest( "mtc_waterfall" );
    common_item::items_spawnitemfromscriptable( "brloot_plunder_cash_epic_1", quest.reward_amount, spawn_options );
    player thread points::doscoreevent( #"br_cacheOpen" );
    challenges::function_37e945722d6497f3( player, "manticore_sq_waterfall_cave", 1, 1 );
    quest br_map_quest::on_completed( { #completed_by:[ player ], #is_successful:1 } );
    instance delete();
}

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0xe3100bcb, Offset: 0xd07
// Size: 0x4d
function private function_80e5aa744355852f()
{
    self.staged_locs = arrayrandomize( self.staged_locs );
    
    for ( i = 0; i < self.num_staged_weapons ; i++ )
    {
        spawn_weapon_individual( self.staged_locs[ i ] );
    }
}

// Namespace namespace_1136765c63eb0dbe
// Params 1, eflags: 0x4
// Checksum 0x1ea8524b, Offset: 0xd5c
// Size: 0xc6
function private spawn_weapon_individual( staged_loc )
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

// Namespace namespace_1136765c63eb0dbe
// Params 0, eflags: 0x4
// Checksum 0x98f962c9, Offset: 0xe2a
// Size: 0x15a
function private spawn_caches()
{
    quest = br_map_quest::get_quest( "mtc_waterfall" );
    loot_zone = br_map_quest::get_setting( "cache_loot_zone" );
    quest.cache_locs = arrayrandomize( quest.cache_locs );
    lege_spawned = 0;
    
    foreach ( loc in quest.cache_locs )
    {
        var_1135b81b40c4ece1 = loc.script_noteworthy == "lege" ? "br_loot_cache_lege" : "br_reusable_loot_cache";
        
        if ( loc.script_noteworthy == "lege" && lege_spawned == quest.num_lege_caches )
        {
            continue;
        }
        
        script_cache = common_cache::function_9bc018c1b8aad720( var_1135b81b40c4ece1, loc.origin, loc.angles, undefined, loot_zone );
        
        if ( loc.script_noteworthy == "lege" )
        {
            lege_spawned++;
        }
    }
}

/#

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0x25a2e758, Offset: 0xf8c
    // Size: 0x21, Type: dev
    function private debug_init()
    {
        utility::function_95db22f620602461( @"scr_debug_waterfall", &function_2b8027e4434b50c5 );
        devgui_init();
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0xdda6d06c, Offset: 0xfb5
    // Size: 0x140, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x45>" + level.mapname + "<dev string:x54>" + "<dev string:x56>" + "<dev string:x54>" );
        devgui::add_devgui_func( "<dev string:x64>", "<dev string:x7b>", &function_75e8aa164520bd4b );
        devgui::add_devgui_func( "<dev string:x92>", "<dev string:xad>", &function_123eb660e8b3502a );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xe2>", &function_e74eeceb2e2f71ef );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x10f>", &function_11a43a132e927706 );
        devgui::add_devgui_func( "<dev string:x128>", "<dev string:x13f>", &function_9feabbcc72041d03 );
        
        foreach ( loc in self.digsite_locs )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x164>" + loc.targetname, "<dev string:x173>" + loc.targetname, &function_9feabbcc72041d03 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0x9b29af4d, Offset: 0x10fd
    // Size: 0x5a, Type: dev
    function private function_75e8aa164520bd4b()
    {
        if ( !getdvarint( @"scr_debug_waterfall" ) )
        {
            setdvar( @"scr_debug_waterfall", 1 );
            iprintlnbold( "<dev string:x199>" );
            function_2b8027e4434b50c5();
            return;
        }
        
        setdvar( @"scr_debug_waterfall", 0 );
        iprintlnbold( "<dev string:x2a>" );
        function_f64b8dfffec907c1();
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0xd2134402, Offset: 0x115f
    // Size: 0xb8, Type: dev
    function private function_2b8027e4434b50c5()
    {
        quest = br_map_quest::get_quest( "<dev string:x56>" );
        
        foreach ( scriptable in quest.digsites )
        {
            debug::sphere( scriptable, 1, "<dev string:x24>", undefined, "<dev string:x2a>" );
            debug::sphere( scriptable, 150, "<dev string:x24>", undefined, "<dev string:x2a>" );
        }
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0x696f13c6, Offset: 0x121f
    // Size: 0x11, Type: dev
    function private function_f64b8dfffec907c1()
    {
        level notify( #"hash_920b57c47c13cffe" );
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0x24f24ac3, Offset: 0x1238
    // Size: 0x3f, Type: dev
    function private function_123eb660e8b3502a()
    {
        level.player setorigin( ( 5264, 11548, 2069 ), 1 );
        level.player setplayerangles( ( 0, 37, 0 ), 1 );
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0xc546be9b, Offset: 0x127f
    // Size: 0x41, Type: dev
    function private function_e74eeceb2e2f71ef()
    {
        quest = br_map_quest::get_quest( "<dev string:x56>" );
        level.player setorigin( quest.selected_digsite.origin, 1 );
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 0, eflags: 0x4
    // Checksum 0x60135ef5, Offset: 0x12c8
    // Size: 0x15f, Type: dev
    function private function_11a43a132e927706()
    {
        quest = br_map_quest::get_quest( "<dev string:x56>" );
        
        foreach ( scriptable in quest.digsites )
        {
            scriptable freescriptable();
        }
        
        quest.digsites = [];
        
        foreach ( s in quest.digsite_locs )
        {
            digsite = quest spawn_digsite( s );
            
            if ( getdvarint( @"scr_debug_waterfall" ) )
            {
                debug::sphere( digsite, 1, "<dev string:x24>", undefined, "<dev string:x2a>" );
                debug::sphere( digsite, 150, "<dev string:x24>", undefined, "<dev string:x2a>" );
            }
        }
    }

    // Namespace namespace_1136765c63eb0dbe
    // Params 1, eflags: 0x4
    // Checksum 0x36a47ef, Offset: 0x142f
    // Size: 0x58, Type: dev
    function private function_9feabbcc72041d03( args )
    {
        data = interactive_notes::create_note_data( "<dev string:x1b3>", "<dev string:x1cb>", args[ 0 ] ?? self.selected_digsite.targetname );
        level.players[ 0 ] interactive_notes::open_note( data );
    }

#/
