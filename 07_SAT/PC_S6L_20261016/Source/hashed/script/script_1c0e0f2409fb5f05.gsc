// script_1c0e0f2409fb5f05  (hash_1c0e0f2409fb5f05.gscc) (size: 12125 Bytes / 0x2f5d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4bc7b8d (2763815821)
// size ...... 12125 (0x2f5d)
// includes .. 17  (offset: 0x2a65)
// strings ... 25  (offset: 0x2aed)
// dev strs .. 59  (offset: 0x2c71)
// exports ... 34  (offset: 0x1829)
// cseg ...... 0x259 + 0x15d0 (0x1829)
// imports ... 106 (offset: 0x1d79)
// animtree1 . 0   (offset: 0x2f5d)
// animtree2 . 0   (offset: 0x2f5d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;

#namespace quest_wanted;

// Namespace quest_wanted
// Params 0, eflags: 0x5
// Checksum 0x3f324893, Offset: 0x277
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_wanted", #"br_map_quest", &pre_main, undefined );
}

// Namespace quest_wanted
// Params 0
// Checksum 0xc32774b2, Offset: 0x2a0
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_wanted" };
    br_map_quest::register( quest );
}

// Namespace quest_wanted
// Params 0
// Checksum 0xb5be87a3, Offset: 0x322
// Size: 0x32
function on_init()
{
    quest_set_dvars();
    quest_set_variables();
    quest_set_callbacks();
    activity_definition_utils::function_74af1ab4059e3c06( "wz_sat_activity_outlaws", "outlaws" );
    
    /#
        debug_init();
    #/
}

// Namespace quest_wanted
// Params 0
// Checksum 0x5ea849d5, Offset: 0x35c
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_wanted
// Params 0
// Checksum 0xbfb52b97, Offset: 0x366
// Size: 0xb3
function on_start()
{
    foreach ( item in self.items )
    {
        item_spawn( item );
    }
    
    self.camera = spawnscriptable( "quest_wz_wanted_camera", self.camera.origin, self.camera.angles );
}

// Namespace quest_wanted
// Params 0
// Checksum 0x6395ec65, Offset: 0x421
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_wanted
// Params 0
// Checksum 0xf470bd7, Offset: 0x42b
// Size: 0x9f
function on_infil()
{
    self.cutout.trigger = spawn( "noent_volume_trigger_box", self.cutout.origin, 0, ( self.cutout.radius, self.cutout.radius, 100 ), ( self.cutout.radius, self.cutout.radius, 100 ) );
    self.cutout.trigger thread function_cabb81e79406b845();
}

// Namespace quest_wanted
// Params 0
// Checksum 0xb78faade, Offset: 0x4d2
// Size: 0x2
function on_disabled()
{
    
}

// Namespace quest_wanted
// Params 0
// Checksum 0x91722eb0, Offset: 0x4dc
// Size: 0x56
function quest_set_dvars()
{
    br_map_quest::add_setting( "need_all_items", 1 );
    br_map_quest::add_setting( "cutout_timer", 2 );
    br_map_quest::add_setting( "flash_timer", 5 );
    br_map_quest::add_setting( "delay_after_flash", 2 );
    br_map_quest::add_setting( "include_sheriff", 1 );
    br_map_quest::add_setting( "cancel_existing_contract", 1 );
}

// Namespace quest_wanted
// Params 0
// Checksum 0x605512ac, Offset: 0x53a
// Size: 0xa2
function quest_set_variables()
{
    self.items = utility::getstructarray( "wanted_item" );
    self.cutout = utility::getstruct( "wanted_cutout" );
    self.camera = utility::getstruct( "wanted_camera" );
    self.var_1e52e37520456c59 = [];
    self.cutout_timer = br_map_quest::get_setting( "cutout_timer" );
    self.items_found = 0;
    self.flash_duration = br_map_quest::get_setting( "flash_timer" );
    self.delay_after_flash = br_map_quest::get_setting( "delay_after_flash" );
    self.cancel_existing_contract = br_map_quest::get_setting( "cancel_existing_contract" );
}

// Namespace quest_wanted
// Params 0
// Checksum 0x82a5d3d2, Offset: 0x5e4
// Size: 0x7d
function quest_set_callbacks()
{
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_wanted_item_01", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_wanted_item_02", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_wanted_item_03", { #dropped:&function_c18d0f4047e3fa65, #used:&on_quest_item_pickup } );
}

// Namespace quest_wanted
// Params 1
// Checksum 0x77e53ca0, Offset: 0x669
// Size: 0x6b
function item_spawn( item )
{
    spawn_options = common_item::function_bc5ff2958b71a708( item.origin, item.angles );
    loot_item = common_item::items_spawnitemfromscriptable( "brloot_wz_quest_wanted_item_0" + int( item.script_noteworthy ), 1, spawn_options );
    item.scriptable = loot_item;
}

// Namespace quest_wanted
// Params 1, eflags: 0x4
// Checksum 0xcd879cb0, Offset: 0x6dc
// Size: 0x7a
function private on_quest_item_pickup( params )
{
    quest = br_map_quest::get_quest( "mtc_wanted" );
    
    switch ( params.bundle.ref )
    {
        case #"hash_e33b845761af1a2f":
            break;
        case #"hash_e33b855761af1bc2":
            break;
        case #"hash_e33b865761af1d55":
            break;
        default:
            return;
    }
}

// Namespace quest_wanted
// Params 1, eflags: 0x4
// Checksum 0xed8ea45b, Offset: 0x75e
// Size: 0x7a
function private function_c18d0f4047e3fa65( params )
{
    quest = br_map_quest::get_quest( "mtc_wanted" );
    
    switch ( params.bundle.ref )
    {
        case #"hash_e33b845761af1a2f":
            break;
        case #"hash_e33b855761af1bc2":
            break;
        case #"hash_e33b865761af1d55":
            break;
        default:
            return;
    }
}

// Namespace quest_wanted
// Params 0
// Checksum 0x4952cef8, Offset: 0x7e0
// Size: 0xc4
function function_cabb81e79406b845()
{
    self notify( #"hash_a4644583f5baff59" );
    self endon( #"hash_a4644583f5baff59" );
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "mtc_wanted" );
    quest endon( #"wanted_trigger_stop" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        ent_id = ent getentitynumber();
        
        if ( isdefined( quest.var_1e52e37520456c59[ ent_id ] ) )
        {
            continue;
        }
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( !ent function_c8c4f11637060bee() )
        {
            continue;
        }
        
        quest.var_1e52e37520456c59[ ent_id ] = ent;
        ent thread function_bfadaf9e773d3e7b( self );
    }
}

// Namespace quest_wanted
// Params 0, eflags: 0x4
// Checksum 0x916be1bc, Offset: 0x8ac
// Size: 0x132, Type: bool
function private function_c8c4f11637060bee()
{
    team = teams::getteamdata( self.team, "players" );
    
    foreach ( var_e78811eec0c27aa in [ "wz_consumable_quest_wanted_item_01", "wz_consumable_quest_wanted_item_02", "wz_consumable_quest_wanted_item_03" ] )
    {
        has_quest_item = 0;
        
        foreach ( player in team )
        {
            if ( player br_quest_inventory::has_quest_item( var_e78811eec0c27aa ) )
            {
                has_quest_item = 1;
                break;
            }
        }
        
        if ( !has_quest_item )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace quest_wanted
// Params 1
// Checksum 0x2416d3bc, Offset: 0x9e7
// Size: 0xc2
function function_bfadaf9e773d3e7b( trigger )
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "mtc_wanted" );
    quest endon( #"wanted_trigger_stop" );
    
    /#
        iprintln( "<dev string:x24>" );
    #/
    
    while ( player::isreallyalive( self ) && self istouching( trigger ) )
    {
        if ( function_c1651439af07183f() )
        {
            if ( !quest.cutout_timer_started )
            {
                /#
                    iprintln( "<dev string:x36>" );
                #/
                
                quest.cutout_timer_started = 1;
                quest thread cutout_timer( self );
            }
        }
        else
        {
            quest.cutout_timer_started = 0;
            self notify( #"wanted_cutout_trigger" );
        }
        
        waitframe();
    }
    
    function_9338d6af567aae14();
}

// Namespace quest_wanted
// Params 0
// Checksum 0xfa673c40, Offset: 0xab1
// Size: 0x42
function function_9338d6af567aae14()
{
    self notify( #"wanted_cutout_trigger" );
    quest = br_map_quest::get_quest( "mtc_wanted" );
    ent_id = self getentitynumber();
    quest.var_1e52e37520456c59[ ent_id ] = undefined;
}

// Namespace quest_wanted
// Params 0
// Checksum 0x1c6121a0, Offset: 0xafb
// Size: 0x58, Type: bool
function function_c1651439af07183f()
{
    quest = br_map_quest::get_quest( "mtc_wanted" );
    
    if ( self getstance() == "crouch" && withinfov( self geteye(), self getplayerangles(), quest.camera.origin, cos( 8 ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace quest_wanted
// Params 1
// Checksum 0xe7944340, Offset: 0xb5c
// Size: 0x5d
function cutout_timer( player )
{
    self notify( #"hash_bdfb81425b732c07" );
    self endon( #"hash_bdfb81425b732c07" );
    level endon( #"game_ended" );
    player endon( #"wanted_cutout_trigger" );
    player endon( #"death_or_disconnect" );
    wait self.cutout_timer;
    thread cutout_start_contract( player );
}

// Namespace quest_wanted
// Params 0, eflags: 0x4
// Checksum 0x538009f1, Offset: 0xbc1
// Size: 0x123
function private function_8687677c36daf7e2()
{
    team = teams::getteamdata( self.team, "players" );
    
    foreach ( var_e78811eec0c27aa in [ "wz_consumable_quest_wanted_item_01", "wz_consumable_quest_wanted_item_02", "wz_consumable_quest_wanted_item_03" ] )
    {
        foreach ( player in team )
        {
            if ( player br_quest_inventory::has_quest_item( var_e78811eec0c27aa ) )
            {
                player br_quest_inventory::consume_quest_item( var_e78811eec0c27aa );
                break;
            }
        }
    }
}

// Namespace quest_wanted
// Params 2
// Checksum 0xf5ae26b2, Offset: 0xcec
// Size: 0x28f
function cutout_start_contract( player, sheriff_override )
{
    level endon( #"game_ended" );
    var_657a3abce2509b48 = activity_participation::function_a2ffa98b763c335d( player );
    
    if ( var_657a3abce2509b48 activity_participation::function_a63ffe2063075fb4( "Contract" ) )
    {
        if ( self.cancel_existing_contract )
        {
            foreach ( activityinstance in var_657a3abce2509b48.var_3a1b6f52043e32b1[ "Contract" ] )
            {
                activity_participation::function_1f1a3bd685df59e8( activityinstance );
            }
        }
        else
        {
            return;
        }
    }
    
    self notify( #"wanted_trigger_stop" );
    self.camera setscriptablepartstate( "quest_wz_wanted_camera", "flash" );
    self.camera utility::delaycall( 10, &freescriptable );
    wanted_team = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in wanted_team )
    {
        var_947bb4706c5ccfaa = teammate hud_util::function_cd054751d2d5b5c5( "white" );
        var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( teammate, 0.05, 1, 2, 1 );
        pbgpostfxbundlestart( teammate, %"mp_wz2_manticore_postfx_wildwest" );
    }
    
    player function_8687677c36daf7e2();
    properties = activity_definition_utils::function_9129cd8075c85c09( activity_definition_utils::getactivitydefinition( "outlaws" ) );
    new_event = activity_instance_common::createactivityinstance( properties.activitytype, "outlaws" );
    activity_participation::function_fb0ec90aaf6d4c61( new_event, wanted_team );
    new_event.var_ca369031b554da2f = player;
    new_event.team = player.team;
    
    if ( isdefined( sheriff_override ) )
    {
        new_event.targetteam = sheriff_override.team;
        new_event.targetplayer = sheriff_override;
    }
    
    activity_instance_common::function_852865f5a195559f( new_event );
    level callback::add( "outlaws_complete", &function_7e4137ffe93fa00c );
}

// Namespace quest_wanted
// Params 1
// Checksum 0x9105a58c, Offset: 0xf83
// Size: 0x9f
function function_7e4137ffe93fa00c( params )
{
    foreach ( player in params.players )
    {
        pbgpostfxbundleend( player, %"mp_wz2_manticore_postfx_wildwest" );
        challenges::function_37e945722d6497f3( player, "manticore_sq_wanted", 1, 0 );
    }
}

/#

    // Namespace quest_wanted
    // Params 0
    // Checksum 0x8b52598, Offset: 0x102a
    // Size: 0x243, Type: dev
    function debug_init()
    {
        utility::function_95db22f620602461( @"hash_ff833cac5279d46f", &function_602515a572169f69 );
        devgui::function_9082edeb5db93280( "<dev string:x54>" + level.mapname + "<dev string:x63>" + "<dev string:x65>" + "<dev string:x63>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x70>", "<dev string:x8a>", &debug_start_contract );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa8>", "<dev string:xc8>", &debug_start_contract );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe8>", "<dev string:x10f>", &debug_start_contract );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12e>", "<dev string:x154>", &debug_start_contract );
        devgui::function_cd4e263c1f3018ae( "<dev string:x172>", "<dev string:x194>", &function_4d0f78b2519327b2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ab>", "<dev string:x1c8>", &function_4d0f78b2519327b2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1df>", "<dev string:x1fe>", &function_4d0f78b2519327b2 );
        devgui::add_devgui_func( "<dev string:x215>", "<dev string:x22f>", &function_e7f12ccbf64e08af );
        devgui::add_devgui_func( "<dev string:x246>", "<dev string:x259>", &function_fad4ca0b0cb753df );
        devgui::add_devgui_func( "<dev string:x273>", "<dev string:x289>", &function_5b27ff2d59b38d6d );
        devgui::add_devgui_func( "<dev string:x2ac>", "<dev string:x2c6>", &function_afc5470234e07880 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e3>", "<dev string:x304>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33a>", "<dev string:x35a>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x38f>", "<dev string:x3b1>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3e8>", "<dev string:x409>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43f>", "<dev string:x468>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a6>", "<dev string:x4cb>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x506>", "<dev string:x52e>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x56b>", "<dev string:x58f>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5c9>", "<dev string:x5e8>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x61f>", "<dev string:x63a>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66e>", "<dev string:x697>", &debug_splash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6d7>", "<dev string:x700>", &debug_splash );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_wanted
    // Params 1
    // Checksum 0x35855e94, Offset: 0x1275
    // Size: 0x1e6, Type: dev
    function debug_start_contract( params )
    {
        player = undefined;
        sheriff = undefined;
        
        if ( params[ 0 ] != "<dev string:x73f>" )
        {
            if ( level.players.size == 1 )
            {
                return;
            }
            
            teammates = arrayremove( teams::getteamdata( level.player.team, "<dev string:x746>" ), level.player );
            enemies = [];
            
            foreach ( player in level.players )
            {
                if ( player::isreallyalive( player ) && player.team != level.player.team )
                {
                    enemies[ enemies.size ] = player;
                }
            }
        }
        
        switch ( params[ 0 ] )
        {
            case #"hash_87d1443ef2805760":
                player = level.player;
                break;
            case #"hash_ecada18a31eceade":
                player = utility::array_random( teammates );
                
                if ( !isdefined( player ) )
                {
                    return;
                }
                
                break;
            case #"hash_fd6246d0b2e1a9fc":
                player = utility::array_random( enemies );
                
                if ( !isdefined( player ) )
                {
                    return;
                }
                
                sheriff = level.player;
                break;
            case #"hash_8b880d9ac6c4a14a":
                player = utility::array_random( enemies );
                
                if ( !isdefined( player ) )
                {
                    return;
                }
                
                sheriff = utility::array_random( teammates );
                break;
        }
        
        quest = br_map_quest::get_quest( "<dev string:x65>" );
        quest thread cutout_start_contract( player, sheriff );
        iprintlnbold( "<dev string:x766>" );
    }

    // Namespace quest_wanted
    // Params 1
    // Checksum 0xafceb4b2, Offset: 0x1463
    // Size: 0x60, Type: dev
    function function_4d0f78b2519327b2( params )
    {
        activity = activity_common::getactivityinstance( level.var_f07a5af7e61f0535 );
        
        if ( !isdefined( activity ) )
        {
            iprintlnbold( "<dev string:x77e>" );
            return;
        }
        
        activity.end_result = int( params[ 0 ] );
        activity activity_instance_common::endactivity( activity, int( params[ 0 ] ) );
    }

    // Namespace quest_wanted
    // Params 0
    // Checksum 0xe3f831ef, Offset: 0x14cb
    // Size: 0x2e, Type: dev
    function function_e7f12ccbf64e08af()
    {
        quest = br_map_quest::get_quest( "<dev string:x65>" );
        quest thread cutout_start_contract( level.player );
    }

    // Namespace quest_wanted
    // Params 0
    // Checksum 0x35156a5d, Offset: 0x1501
    // Size: 0x5a, Type: dev
    function function_fad4ca0b0cb753df()
    {
        if ( !getdvarint( @"hash_ff833cac5279d46f" ) )
        {
            setdvar( @"hash_ff833cac5279d46f", 1 );
            iprintlnbold( "<dev string:x798>" );
            function_602515a572169f69();
            return;
        }
        
        setdvar( @"hash_ff833cac5279d46f", 0 );
        iprintlnbold( "<dev string:x7b5>" );
        function_885199d9e7e82585();
    }

    // Namespace quest_wanted
    // Params 0
    // Checksum 0x82099550, Offset: 0x1563
    // Size: 0xb8, Type: dev
    function function_602515a572169f69()
    {
        quest = br_map_quest::get_quest( "<dev string:x65>" );
        
        foreach ( item in quest.items )
        {
            debug::sphere( item, 1, "<dev string:x7d3>", undefined, "<dev string:x7b5>" );
            debug::sphere( item, 100, "<dev string:x7d3>", undefined, "<dev string:x7b5>" );
        }
    }

    // Namespace quest_wanted
    // Params 0
    // Checksum 0xb2823c06, Offset: 0x1623
    // Size: 0x11, Type: dev
    function function_885199d9e7e82585()
    {
        level notify( #"hash_458341ec9504c244" );
    }

    // Namespace quest_wanted
    // Params 0
    // Checksum 0xc620e93c, Offset: 0x163c
    // Size: 0xf4, Type: dev
    function function_5b27ff2d59b38d6d()
    {
        quest = br_map_quest::get_quest( "<dev string:x65>" );
        
        if ( !isdefined( quest.var_bf74d1bc18c59e15 ) )
        {
            quest.var_bf74d1bc18c59e15 = -1;
        }
        
        quest.var_bf74d1bc18c59e15++;
        
        if ( quest.var_bf74d1bc18c59e15 == quest.items.size )
        {
            quest.var_bf74d1bc18c59e15 = 0;
        }
        
        item = quest.items[ quest.var_bf74d1bc18c59e15 ];
        origin = getclosestpointonnavmesh( item.origin );
        level.player setorigin( origin, 1 );
        angles = vectortoangles( item.origin - origin + ( 0, 0, 60 ) );
        level.player setplayerangles( angles, 1 );
    }

    // Namespace quest_wanted
    // Params 0
    // Checksum 0xc46bf0f2, Offset: 0x1738
    // Size: 0x4b, Type: dev
    function function_afc5470234e07880()
    {
        quest = br_map_quest::get_quest( "<dev string:x65>" );
        level.player setorigin( quest.cutout.trigger.origin, 1 );
    }

    // Namespace quest_wanted
    // Params 1
    // Checksum 0x79e23a5b, Offset: 0x178b
    // Size: 0x9e, Type: dev
    function debug_splash( params )
    {
        if ( level.var_f07a5af7e61f0535 )
        {
            activity = activity_common::getactivityinstance( level.var_f07a5af7e61f0535 );
        }
        
        if ( !activity )
        {
            properties = activity_definition_utils::function_9129cd8075c85c09( activity_definition_utils::getactivitydefinition( "<dev string:x7d9>" ) );
            activity = activity_instance_common::createactivityinstance( properties.activitytype, "<dev string:x7d9>" );
        }
        
        if ( isdefined( activity ) )
        {
            activity activity_player_broadcasting::function_c2b1e8bad2e95e69( params[ 0 ], level.players );
            level.var_f07a5af7e61f0535 = activity.id;
        }
    }

#/
