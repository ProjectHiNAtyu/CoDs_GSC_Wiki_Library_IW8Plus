// script_fc6482d8496385f  (hash_0fc6482d8496385f.gscc) (size: 12837 Bytes / 0x3225 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x82a896fc (2192086780)
// size ...... 12837 (0x3225)
// includes .. 8   (offset: 0x2ebd)
// strings ... 28  (offset: 0x2efd)
// dev strs .. 27  (offset: 0x30bd)
// exports ... 34  (offset: 0x1d39)
// cseg ...... 0x325 + 0x1a14 (0x1d39)
// imports ... 100 (offset: 0x2289)
// animtree1 . 0   (offset: 0x3225)
// animtree2 . 0   (offset: 0x3225)
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_3a0297bebde41829;

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x5
// Checksum 0x54a43c8e, Offset: 0x343
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_lockpick_axe", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0x3d07a700, Offset: 0x36c
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_lockpick_axe" };
    br_map_quest::register( quest );
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0x6f5404b8, Offset: 0x3ee
// Size: 0x21
function on_init()
{
    apply_settings();
    set_quest_variables();
    function_5a15097e00440f74();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0x7f7123de, Offset: 0x417
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0xe83d5eb, Offset: 0x421
// Size: 0xe6
function on_start()
{
    if ( self.door_planks.size > 0 )
    {
        utility::array_thread( self.door_planks, &function_78d206cd3cecdd59 );
    }
    
    if ( !self.block_windows )
    {
        function_c5088c588e1fd5ed();
    }
    else if ( !self.allow_damage_prematch )
    {
        function_5001fb17ba9fd12f();
    }
    
    foreach ( door in self.doors )
    {
        door scriptabledoorfreeze( 1 );
        door scriptabledoorlock();
    }
    
    spawn_axes();
    spawn_items();
    spawn_caches();
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0x424c866e, Offset: 0x50f
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0x2af59244, Offset: 0x519
// Size: 0x19e
function on_infil()
{
    foreach ( plank in self.door_planks )
    {
        plank show();
        plank setcandamage( 1 );
    }
    
    if ( self.block_windows )
    {
        foreach ( plank in self.window_planks )
        {
            plank setscriptablepartstate( #"base", #"healthy_no_vehicle" );
        }
    }
    
    foreach ( door in self.doors )
    {
        door scriptabledoorfreeze( 0 );
        door scriptabledoorlock();
    }
    
    self.var_5445d7f95503f47a = 0;
    self.var_aa0da57123d483e7 = 0;
}

// Namespace namespace_3a0297bebde41829
// Params 0
// Checksum 0xee40cdec, Offset: 0x6bf
// Size: 0x213
function on_disabled()
{
    self.door_planks = getentarray( "quest_wz_lockpick_axe_plank_door", #targetname );
    
    foreach ( plank in self.door_planks )
    {
        door_side = issubstr( plank.script_noteworthy, "left" ) ? "left" : "right";
        door = getentitylessscriptablearray( "scriptable_t10_door_industrial_metal_mp_01", #classname, plank.origin, 100, undefined )[ 0 ];
        
        if ( isdefined( door ) && !isdefined( self.doors[ door_side ] ) )
        {
            self.doors[ door_side ] = door;
        }
        
        plank delete();
    }
    
    foreach ( door in self.doors )
    {
        door scriptabledoorfreeze( 1 );
    }
    
    self.var_87f682d8888ae236 = getentitylessscriptablearray( "quest_wz_lockpick_axe_plank_door" );
    
    foreach ( plank in self.var_87f682d8888ae236 )
    {
        plank setscriptablepartstate( "model", "destroyed" );
    }
    
    function_5001fb17ba9fd12f();
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0xd02a8d7e, Offset: 0x8da
// Size: 0x47
function private apply_settings()
{
    br_map_quest::add_setting( "block_windows", 1 );
    br_map_quest::add_setting( "door_axe_required", 1 );
    br_map_quest::add_setting( "allow_damage_in_prematch", 0 );
    br_map_quest::add_setting( "num_staged_axes", 4 );
    br_map_quest::add_setting( "num_staged_caches", 3 );
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x5f66ce09, Offset: 0x929
// Size: 0x7a
function private set_quest_variables()
{
    self.block_windows = br_map_quest::get_setting( "block_windows" );
    self.door_axe_required = br_map_quest::get_setting( "door_axe_required" );
    self.allow_damage_prematch = br_map_quest::get_setting( "allow_damage_in_prematch" );
    self.num_staged_axes = br_map_quest::get_setting( "num_staged_axes" );
    self.num_staged_caches = br_map_quest::get_setting( "num_staged_caches" );
    self.var_5445d7f95503f47a = 0;
    self.var_aa0da57123d483e7 = 0;
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x18746504, Offset: 0x9ab
// Size: 0x205
function private function_5a15097e00440f74()
{
    self.door_planks = getentarray( "quest_wz_lockpick_axe_plank_door", #targetname );
    self.var_f8dbce896f8e3c6b = getentarray( "quest_wz_lockpick_axe_plank_door" + "_disabled", #targetname );
    self.var_87f682d8888ae236 = getentitylessscriptablearray( "quest_wz_lockpick_axe_plank_door" );
    self.doors = [];
    
    foreach ( plank in self.door_planks )
    {
        door_side = issubstr( plank.script_noteworthy, "left" ) ? "left" : "right";
        door = getentitylessscriptablearray( "scriptable_t10_door_industrial_metal_mp_01", #classname, plank.origin, 100, undefined )[ 0 ];
        
        if ( isdefined( door ) && !isdefined( self.doors[ door_side ] ) )
        {
            self.doors[ door_side ] = door;
        }
    }
    
    foreach ( plank in self.var_f8dbce896f8e3c6b )
    {
        plank delete();
    }
    
    self.window_planks = getentitylessscriptablearray( "fence_wood_planks_02_128_paint_red_lm" );
    self.staged_caches = utility::getstructarray( "lockpick_axe_cache" );
    self.staged_items = utility::getstructarray( "lockpick_axe_item" );
    self.staged_axes = utility::getstructarray( "lockpick_axe_axe" );
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x2099ab8a, Offset: 0xbb8
// Size: 0xc1
function private function_78d206cd3cecdd59()
{
    quest = br_map_quest::get_quest( "mtc_lockpick_axe" );
    self.quest = quest;
    
    foreach ( sbl in quest.var_87f682d8888ae236 )
    {
        if ( sbl.script_noteworthy == self.script_noteworthy )
        {
            self.scriptable = sbl;
            break;
        }
    }
    
    thread function_5dbb3f78096a25c9();
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0xcc66561c, Offset: 0xc81
// Size: 0x15d
function private function_5dbb3f78096a25c9()
{
    level endon( #"game_ended" );
    
    if ( self.quest br_map_quest::get_setting( "allow_damage_in_prematch" ) )
    {
        self setcandamage( 1 );
    }
    
    self.health = 9999;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, inflictor );
        self.health = 9999;
        equipmentref = equipment_mp::function_fdc4a655fbde0dec( weapon.basename );
        
        if ( equipment_mp::isequipmentlethal( equipmentref ) && equipmentref == "equip_combataxe" )
        {
            function_f067c8234bb06b91();
            continue;
        }
        
        if ( !self.quest.door_axe_required )
        {
            if ( isexplosivedamagemod( meansofdeath ) && damage > 1 || damage > 85 )
            {
                function_f067c8234bb06b91();
            }
        }
    }
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x15203ece, Offset: 0xde6
// Size: 0x78
function private function_f067c8234bb06b91()
{
    self.scriptable setscriptablepartstate( #"model", #"destroyed" );
    self hide();
    
    if ( issubstr( self.script_noteworthy, "left" ) )
    {
        self.quest.var_aa0da57123d483e7++;
    }
    else
    {
        self.quest.var_5445d7f95503f47a++;
    }
    
    self.quest function_cfce1d6584db8365();
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0xdd9b6d75, Offset: 0xe66
// Size: 0x118
function private function_cfce1d6584db8365()
{
    if ( self.var_aa0da57123d483e7 >= 2 )
    {
        dlog_recordevent( "dlog_event_br_manticore_lockpick_axe_right_open", [ "time_from_match_start_ms", gettime() ] );
        self.doors[ "left" ] scriptabledoorunlock();
        self.doors[ "left" ] scriptabledoorbashopen( "right" );
        self.rightdooropen = 1;
        
        if ( self.leftdooropen )
        {
            dlog_recordevent( "dlog_event_br_manticore_lockpick_axe_both_open", [ "time_from_match_start_ms", gettime() ] );
        }
    }
    
    if ( self.var_5445d7f95503f47a >= 2 )
    {
        dlog_recordevent( "dlog_event_br_manticore_lockpick_axe_left_open", [ "time_from_match_start_ms", gettime() ] );
        self.doors[ "right" ] scriptabledoorunlock();
        self.doors[ "right" ] scriptabledoorbashopen( "left" );
        self.leftdooropen = 1;
        
        if ( self.rightdooropen )
        {
            dlog_recordevent( "dlog_event_br_manticore_lockpick_axe_both_open", [ "time_from_match_start_ms", gettime() ] );
        }
    }
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0xa476154f, Offset: 0xf86
// Size: 0x7c
function private function_c5088c588e1fd5ed()
{
    foreach ( plank in self.window_planks )
    {
        plank scriptabledodamage( 1000 );
    }
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x491c61ff, Offset: 0x100a
// Size: 0xbb
function private function_5001fb17ba9fd12f()
{
    if ( !isdefined( self.window_planks ) || self.window_planks.size == 0 )
    {
        self.window_planks = getentitylessscriptablearray( "fence_wood_planks_02_128_paint_red_lm" );
    }
    
    foreach ( plank in self.window_planks )
    {
        plank setscriptablepartstate( #"base", #"visible_immune" );
    }
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x2315e8b3, Offset: 0x10cd
// Size: 0xf9
function private spawn_axes()
{
    self.staged_axes = arrayrandomize( self.staged_axes );
    item_bundle = getscriptbundle( "itemspawnentry:wz_sat_item_lethal_combataxe" );
    
    for ( i = 0; i < self.num_staged_axes ; i++ )
    {
        var_3eebad4f7884c91a = self.staged_axes[ i ];
        spawnoptions = common_item::function_bc5ff2958b71a708( var_3eebad4f7884c91a.origin, var_3eebad4f7884c91a.angles );
        spawnoptions.critical = 1;
        scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
        
        if ( isdefined( scriptable ) && scriptable getscriptableparthasstate( scriptable.type, #"visible_staged_weapon" ) )
        {
            scriptable setscriptablepartstate( scriptable.type, #"visible_staged_weapon" );
        }
        
        var_3eebad4f7884c91a.scriptable = scriptable;
    }
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0x7edc2ef, Offset: 0x11ce
// Size: 0x13a
function private spawn_items()
{
    foreach ( staged_items in self.staged_items )
    {
        if ( !isdefined( staged_items.script_noteworthy ) )
        {
            continue;
        }
        
        item_bundle = getscriptbundle( "itemspawnentry:" + staged_items.script_noteworthy );
        spawnoptions = common_item::function_bc5ff2958b71a708( staged_items.origin, staged_items.angles );
        spawnoptions.critical = 1;
        scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
        
        if ( isdefined( scriptable ) && scriptable getscriptableparthasstate( scriptable.type, #"visible_staged_weapon" ) )
        {
            scriptable setscriptablepartstate( scriptable.type, #"visible_staged_weapon" );
        }
        
        staged_items.scriptable = scriptable;
    }
}

// Namespace namespace_3a0297bebde41829
// Params 0, eflags: 0x4
// Checksum 0xaee3401a, Offset: 0x1310
// Size: 0xb7
function private spawn_caches()
{
    self.staged_caches = arrayrandomize( self.staged_caches );
    
    for ( i = 0; i < self.num_staged_caches ; i++ )
    {
        cache = self.staged_caches[ i ];
        var_1135b81b40c4ece1 = cache.script_noteworthy == "lege" ? "br_loot_cache_lege" : "br_reusable_loot_cache";
        script_cache = common_cache::function_9bc018c1b8aad720( var_1135b81b40c4ece1, cache.origin, cache.angles, undefined, "wz_sat_resurgence_zone_global" );
        cache.scriptable = script_cache;
    }
}

/#

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xcdfdfdcc, Offset: 0x13cf
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xc3b1d268, Offset: 0x13e3
    // Size: 0x10f, Type: dev
    function private devgui_init()
    {
        utility::function_95db22f620602461( @"hash_3984964dc29cb8bb", &function_ea731cfca2e4b22e );
        devgui::function_9082edeb5db93280( "<dev string:x24>" + level.mapname + "<dev string:x33>" + "<dev string:x35>" + "<dev string:x33>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x58>", &function_38f7d4ff58713cbe );
        devgui::add_devgui_func( "<dev string:x74>", "<dev string:x8c>", &function_30a9af087c704e3d );
        devgui::add_devgui_func( "<dev string:xae>", "<dev string:xc4>", &function_f2fd2541269e6341 );
        devgui::add_devgui_func( "<dev string:xe4>", "<dev string:xf9>", &function_9a30f0935f0b3d6a );
        devgui::add_devgui_func( "<dev string:x118>", "<dev string:x122>", &debug_reset_all );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13f>", "<dev string:x155>", &function_b1ee7ab45bdb919c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x178>", "<dev string:x18e>", &function_b1ee7ab45bdb919c );
        devgui::add_devgui_func( "<dev string:x1b1>", "<dev string:x1c6>", &function_11ff875d38494316 );
        devgui::add_devgui_func( "<dev string:x1e6>", "<dev string:x1f0>", &function_bc33aec619f9d011 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xb2388423, Offset: 0x14fa
    // Size: 0x5a, Type: dev
    function private function_38f7d4ff58713cbe()
    {
        if ( !getdvarint( @"hash_3984964dc29cb8bb" ) )
        {
            setdvar( @"hash_3984964dc29cb8bb", 1 );
            iprintlnbold( "<dev string:x20d>" );
            function_ea731cfca2e4b22e();
            return;
        }
        
        setdvar( @"hash_3984964dc29cb8bb", 0 );
        iprintlnbold( "<dev string:x22b>" );
        function_7fb8179a3ccdefd0();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xd5ce012f, Offset: 0x155c
    // Size: 0xb8, Type: dev
    function private function_ea731cfca2e4b22e()
    {
        quest = br_map_quest::get_quest( "<dev string:x35>" );
        
        foreach ( item in quest.staged_axes )
        {
            debug::sphere( item, 1, "<dev string:x24a>", undefined, "<dev string:x22b>" );
            debug::sphere( item, 100, "<dev string:x24a>", undefined, "<dev string:x22b>" );
        }
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0x4a3d6e2, Offset: 0x161c
    // Size: 0x11, Type: dev
    function private function_7fb8179a3ccdefd0()
    {
        level notify( #"hash_81f84d7bb2215f66" );
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0x79f98acd, Offset: 0x1635
    // Size: 0x13, Type: dev
    function private function_9a30f0935f0b3d6a()
    {
        function_f2fd2541269e6341();
        function_30a9af087c704e3d();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xf1be18ec, Offset: 0x1650
    // Size: 0x32, Type: dev
    function private function_30a9af087c704e3d()
    {
        quest = br_map_quest::get_quest( "<dev string:x35>" );
        quest.block_windows = 0;
        quest function_c5088c588e1fd5ed();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xd0952e1b, Offset: 0x168a
    // Size: 0xae, Type: dev
    function private function_f2fd2541269e6341()
    {
        quest = br_map_quest::get_quest( "<dev string:x35>" );
        quest.door_axe_required = 0;
        
        foreach ( plank in quest.door_planks )
        {
            plank dodamage( 1000, plank.origin );
        }
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xf07eaad3, Offset: 0x1740
    // Size: 0x3c3, Type: dev
    function private debug_reset_all()
    {
        quest = br_map_quest::get_quest( "<dev string:x35>" );
        quest.block_windows = quest br_map_quest::get_setting( "<dev string:x250>" );
        quest.door_axe_required = quest br_map_quest::get_setting( "<dev string:x25e>" );
        quest.var_5445d7f95503f47a = 0;
        quest.var_aa0da57123d483e7 = 0;
        
        foreach ( door in quest.doors )
        {
            door thread debug_close_door();
        }
        
        foreach ( plank in quest.door_planks )
        {
            plank show();
            plank.scriptable setscriptablepartstate( #"model", #"healthy" );
        }
        
        foreach ( plank in quest.window_planks )
        {
            plank setscriptablepartstate( #"base", #"healthy_no_vehicle" );
        }
        
        foreach ( var_3eebad4f7884c91a in quest.staged_axes )
        {
            if ( isdefined( var_3eebad4f7884c91a.scriptable ) )
            {
                var_3eebad4f7884c91a.scriptable freescriptable();
            }
        }
        
        foreach ( item in quest.staged_items )
        {
            if ( isdefined( item.scriptable ) )
            {
                item.scriptable freescriptable();
            }
        }
        
        foreach ( cache in quest.staged_caches )
        {
            if ( isdefined( cache.scriptable ) )
            {
                cache.scriptable freescriptable();
            }
        }
        
        quest spawn_axes();
        quest spawn_items();
        quest spawn_caches();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0x978cdbbe, Offset: 0x1b0b
    // Size: 0x14, Type: dev
    function private debug_close_door()
    {
        self scriptabledoorclose();
        wait 1;
        self scriptabledoorlock();
    }

    // Namespace namespace_3a0297bebde41829
    // Params 1, eflags: 0x4
    // Checksum 0x991340e5, Offset: 0x1b27
    // Size: 0xac, Type: dev
    function private function_b1ee7ab45bdb919c( params )
    {
        var_b718a4324486dcc = undefined;
        var_d99e534be5d9d3ce = undefined;
        
        switch ( params[ 0 ] )
        {
            case #"hash_311010bc01bd3a0f":
                var_b718a4324486dcc = ( 2819, -5172, 317 );
                var_d99e534be5d9d3ce = ( 11, 163, 0 );
                break;
            case #"hash_31100fbc01bd387c":
                var_b718a4324486dcc = ( 1919, -4936, 317 );
                var_d99e534be5d9d3ce = ( 9, 350, 0 );
                break;
        }
        
        level.player setorigin( var_b718a4324486dcc );
        level.player setplayerangles( var_d99e534be5d9d3ce );
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xfa82b206, Offset: 0x1bdb
    // Size: 0x128, Type: dev
    function private function_11ff875d38494316()
    {
        quest = br_map_quest::get_quest( "<dev string:x35>" );
        
        if ( !isdefined( quest.var_11ff875d38494316 ) )
        {
            quest.var_11ff875d38494316 = -1;
        }
        
        quest.var_11ff875d38494316++;
        
        if ( quest.var_11ff875d38494316 == quest.staged_axes.size )
        {
            quest.var_11ff875d38494316 = 0;
        }
        
        item = quest.staged_axes[ quest.var_11ff875d38494316 ];
        nav_origin = getclosestpointonnavmesh( item.origin );
        var_f9415643806be034 = ( nav_origin[ 0 ], nav_origin[ 1 ], item.origin[ 2 ] );
        angles = vectortoangles( item.origin - var_f9415643806be034 );
        origin = nav_origin + vectornormalize( var_f9415643806be034 - item.origin ) * 50;
        level.player setorigin( origin, 1 );
        level.player setplayerangles( angles, 1 );
    }

    // Namespace namespace_3a0297bebde41829
    // Params 0, eflags: 0x4
    // Checksum 0xf7552f4b, Offset: 0x1d0b
    // Size: 0x2e, Type: dev
    function private function_bc33aec619f9d011()
    {
        itembundle = getscriptbundle( "<dev string:x274>" );
        level.player common_item::function_360e96e0447f17f9( itembundle, 2 );
    }

#/
