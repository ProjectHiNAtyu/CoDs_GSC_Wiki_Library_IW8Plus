// script_aa7268b0d2cc6fd  (hash_0aa7268b0d2cc6fd.gscc) (size: 22846 Bytes / 0x593e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f94545 (66667845)
// size ...... 22846 (0x593e)
// includes .. 22  (offset: 0x51ae)
// strings ... 85  (offset: 0x525e)
// dev strs .. 36  (offset: 0x570a)
// exports ... 61  (offset: 0x33de)
// cseg ...... 0x635 + 0x2da9 (0x33de)
// imports ... 164 (offset: 0x3d66)
// animtree1 . 0   (offset: 0x593e)
// animtree2 . 0   (offset: 0x593e)
#using script_63258e3c8c400b7a;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\interactive_notes;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\maps\mp_saw_manticore\mp_saw_manticore;

#namespace namespace_10a8697f7706c463;

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x5
// Checksum 0x3196161a, Offset: 0x653
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_pied_piper", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0xd46ce634, Offset: 0x67c
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_pied_piper" };
    br_map_quest::register( quest );
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0xcb7f0e84, Offset: 0x6fe
// Size: 0x2f
function on_init()
{
    apply_settings();
    function_970d564ac5226b2e();
    setup_variables();
    function_1a00a5a2ba836d4d();
    setup_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0xb593ff94, Offset: 0x735
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0x5f3b7233, Offset: 0x73f
// Size: 0x2c
function on_start()
{
    spawn_electrical_box();
    spawn_flute();
    function_846c5659236f1316();
    spawn_caches();
    spawn_staged_loot();
    thread function_ca44316d2bc39d30();
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0x88ae5a24, Offset: 0x773
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0xb8efa965, Offset: 0x77d
// Size: 0x1e
function on_infil()
{
    enable_electrical_box();
    enable_elevator_fusebox();
    function_2ca805baf0124cf3();
    function_9ad16710ca258c00();
}

// Namespace namespace_10a8697f7706c463
// Params 0
// Checksum 0x5cb41c9f, Offset: 0x7a3
// Size: 0x2
function on_disabled()
{
    
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x7d7e5ace, Offset: 0x7ad
// Size: 0x2f
function private apply_settings()
{
    br_map_quest::add_setting( "cache_loot_zone", "wz_sat_resurgence_zone_global" );
    br_map_quest::add_setting( "staged_caches_normal", 2 );
    br_map_quest::add_setting( "staged_caches_lege", 2 );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xab365d41, Offset: 0x7e4
// Size: 0x2
function private function_970d564ac5226b2e()
{
    
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x3305b488, Offset: 0x7ee
// Size: 0x9b
function private setup_variables()
{
    var_dce22208c91f9ecc = [];
    s = spawnstruct();
    s.model = "Three Blind Mice";
    s.melody = [ "E", "D", "C" ];
    var_dce22208c91f9ecc[ var_dce22208c91f9ecc.size ] = s;
    s_melody = utility::array_random( var_dce22208c91f9ecc );
    self.var_51761b0260803246 = s_melody.melody;
    self.var_6ac3ff12b9b2c9eb = 0;
    self.fuse_consumable = "wz_consumable_quest_fuse";
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x42ebf594, Offset: 0x891
// Size: 0x11f
function private function_1a00a5a2ba836d4d()
{
    self.cache_locs = utility::getstructarray( "piedpiper_cache" );
    self.sheet_music_loc = utility::getstruct( "piedpiper_sheet_music_location" );
    self.var_df5fc475e2503156 = utility::getstruct( "piedpiper_lab_lore_note_location" );
    self.var_f9a23d30a6cf1b91 = utility::getstructarray( "pied_piper_mousetrap" );
    self.var_ca7594b1e544cd09 = utility::getstructarray( "pied_piper_staged_loot" );
    
    foreach ( s in self.var_f9a23d30a6cf1b91 )
    {
        s.s_cheese = utility::getstruct( s.target );
    }
    
    fuses = getentitylessscriptablearray( "elevator_fusebox_fuse", "targetname" );
    
    if ( fuses.size > 0 )
    {
        self.elevator_fusebox_fuse = fuses[ 0 ];
    }
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x916d08a0, Offset: 0x9b8
// Size: 0x43
function private setup_callbacks()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_saw_gas_exclusion_button", &function_30f95c2803cb5ac9 );
    gas_exclusion_button = getentitylessscriptablearray( "scriptable_" + "quest_saw_gas_exclusion_button", "classname" )[ 0 ];
    gas_exclusion_button interaction::set_interact_hint_callback( &function_126dd0644c71e94b );
}

// Namespace namespace_10a8697f7706c463
// Params 6, eflags: 0x4
// Checksum 0xe9d86669, Offset: 0xa03
// Size: 0xcd
function private function_30f95c2803cb5ac9( instance, part, state, player, bautouse, usestring )
{
    player thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_loot_pickup", 1.17 );
    instance setscriptablepartstate( "quest_saw_gas_exclusion_button", "used" );
    instance.start_time = gettime();
    instance.timer = getdvarint( @"hash_45fccac3d69523f4", 60 );
    
    if ( !level.brgametype.respawnenable )
    {
        instance.timer = getdvarint( @"hash_b7bd54766e5291e7", 30 );
    }
    
    level thread function_c1d371449195bf43( instance.timer );
}

// Namespace namespace_10a8697f7706c463
// Params 2, eflags: 0x4
// Checksum 0xcb1bb333, Offset: 0xad8
// Size: 0xfa
function private function_126dd0644c71e94b( usable, player )
{
    if ( !isdefined( player ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( usable getscriptablepartstate( "quest_saw_gas_exclusion_button" ) == "standby" )
    {
        return { #string:&"mp_saw_manticore/activate_decontamination_system", #type:"HINT_BUTTON" };
    }
    
    power = int( 100 - ( gettime() - usable.start_time ) / usable.timer * 1000 * 100 );
    
    if ( power < 0 )
    {
        power = 0;
    }
    
    quest = br_map_quest::get_quest( "mtc_pied_piper" );
    return { #params:[ power ], #string:&"mp_saw_manticore/decontamination_system_power", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x3afabb59, Offset: 0xbdb
// Size: 0x1fd
function private function_c1d371449195bf43( timer )
{
    level endon( #"game_ended" );
    utility::registersharedfunc( #"gametype", #"hash_cb7f08e35dbda7cf", &function_d27c04e8de9b19d4 );
    quest = br_map_quest::get_quest( "mtc_pied_piper" );
    origin = ( quest.scr_fountain.origin[ 0 ], quest.scr_fountain.origin[ 1 ], 376 );
    var_c251179274e544f5 = level.exclusionzones[ exclusion_zones::function_13326ea977bfb539( origin, ( 1, 1, 1 ), ( 0, 55, 0 ), 2 ) ];
    var_c251179274e544f5 exclusion_zones::function_f597034a78b33c62( ( 1100, 1100, 1100 ), 0.05, 0 );
    
    for ( i = 0; i < timer ; i++ )
    {
        /#
            if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
            {
                var_1d036682dc89c202 = var_c251179274e544f5 function_465f674722f8d216()[ 0 ];
                debug::function_76204bee46fa39fd( origin, [ var_1d036682dc89c202 / 2, var_1d036682dc89c202 / 2, var_1d036682dc89c202 / 2 ], ( 0, 55, 0 ), 1, "<dev string:x24>" );
            }
        #/
        
        wait 1;
    }
    
    var_c251179274e544f5 exclusion_zones::function_f597034a78b33c62( ( 0, 0, 0 ), ( -3, -3, -3 ), 1 );
    
    while ( true )
    {
        var_1d036682dc89c202 = var_c251179274e544f5 function_465f674722f8d216()[ 0 ];
        
        /#
            if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
            {
                debug::function_76204bee46fa39fd( origin, [ var_1d036682dc89c202 / 2, var_1d036682dc89c202 / 2, var_1d036682dc89c202 / 2 ], ( 0, 55, 0 ), level.framedurationseconds, "<dev string:x24>" );
            }
        #/
        
        if ( var_1d036682dc89c202 < 1 )
        {
            exclusion_zones::function_5fc2ac1152c0aa19( var_c251179274e544f5 );
            return;
        }
        
        wait level.framedurationseconds;
    }
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x2e0dda38, Offset: 0xde0
// Size: 0xc
function private function_d27c04e8de9b19d4()
{
    return self gettagorigin( "j_head" );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x1b0c7dbd, Offset: 0xdf5
// Size: 0x5e4
function private function_2ca805baf0124cf3()
{
    var_cfdcb332178e0755 = [];
    
    /#
        self.var_b1b5e539a6c25a98 = [];
        self.spawned_cheese = [];
    #/
    
    foreach ( s_mousetrap in self.var_f9a23d30a6cf1b91 )
    {
        if ( !isdefined( var_cfdcb332178e0755[ s_mousetrap.script_noteworthy ] ) )
        {
            var_cfdcb332178e0755[ s_mousetrap.script_noteworthy ] = [];
        }
        
        var_cfdcb332178e0755[ s_mousetrap.script_noteworthy ][ var_cfdcb332178e0755[ s_mousetrap.script_noteworthy ].size ] = s_mousetrap;
    }
    
    /#
        if ( getdvarint( @"hash_df3353eaf98a14a2" ) )
        {
            foreach ( zone in var_cfdcb332178e0755 )
            {
                foreach ( s_mousetrap in zone )
                {
                    mousetrap = spawn( "<dev string:x2a>", s_mousetrap.origin );
                    mousetrap.angles = s_mousetrap.angles;
                    mousetrap setmodel( "<dev string:x37>" );
                    mousetrap setcandamage( 1 );
                    mousetrap.quest = self;
                    mousetrap thread function_e7c32924112b4357();
                    var_5baf88721a84cc3b = spawnscriptable( "<dev string:x46>", s_mousetrap.s_cheese.origin );
                    var_5baf88721a84cc3b.angles = s_mousetrap.s_cheese.angles;
                    var_5baf88721a84cc3b setscriptablepartstate( "<dev string:x46>", "<dev string:x5d>" );
                    
                    if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
                    {
                        debug::sphere( mousetrap, undefined, "<dev string:x65>", undefined, "<dev string:x69>" );
                        debug::sphere( var_5baf88721a84cc3b, undefined, "<dev string:x7e>", undefined, "<dev string:x69>" );
                    }
                    
                    self.var_b1b5e539a6c25a98[ self.var_b1b5e539a6c25a98.size ] = mousetrap;
                    self.spawned_cheese[ self.spawned_cheese.size ] = var_5baf88721a84cc3b;
                }
            }
            
            foreach ( zone in var_cfdcb332178e0755 )
            {
                foreach ( s_mousetrap in zone )
                {
                    s_mousetrap.s_cheese = undefined;
                    s_mousetrap = undefined;
                }
            }
            
            return;
        }
    #/
    
    foreach ( zone in var_cfdcb332178e0755 )
    {
        s_mousetrap = utility::array_random( zone );
        mousetrap = spawn( "script_model", s_mousetrap.origin );
        mousetrap.angles = s_mousetrap.angles;
        mousetrap setmodel( "vfx_mouse_trap" );
        mousetrap setcandamage( 1 );
        mousetrap.quest = self;
        mousetrap thread function_e7c32924112b4357();
        var_5baf88721a84cc3b = spawnscriptable( "quest_saw_cheese_wedge", s_mousetrap.s_cheese.origin );
        var_5baf88721a84cc3b.angles = s_mousetrap.s_cheese.angles;
        var_5baf88721a84cc3b setscriptablepartstate( "quest_saw_cheese_wedge", "visible" );
        
        /#
            if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
            {
                debug::sphere( mousetrap, undefined, "<dev string:x65>", undefined, "<dev string:x69>" );
                debug::sphere( var_5baf88721a84cc3b, undefined, "<dev string:x7e>", undefined, "<dev string:x69>" );
            }
            
            self.var_b1b5e539a6c25a98[ self.var_b1b5e539a6c25a98.size ] = mousetrap;
            self.spawned_cheese[ self.spawned_cheese.size ] = var_5baf88721a84cc3b;
        #/
    }
    
    foreach ( zone in var_cfdcb332178e0755 )
    {
        foreach ( s_mousetrap in zone )
        {
            s_mousetrap.s_cheese = undefined;
            s_mousetrap = undefined;
        }
    }
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x9f89cfa3, Offset: 0x13e1
// Size: 0x87
function private function_e7c32924112b4357()
{
    level endon( #"game_ended" );
    self waittill( #"damage" );
    fx = spawnscriptable( "quest_saw_pied_piper_mousetrap_destroyed", self.origin );
    self.quest.var_6ac3ff12b9b2c9eb++;
    
    if ( self.quest.var_6ac3ff12b9b2c9eb == 3 )
    {
        level thread function_b13078c3d74f833( self.origin );
    }
    
    self delete();
    wait 3;
    fx freescriptable();
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x68cb362d, Offset: 0x1470
// Size: 0x51
function private function_b13078c3d74f833( v_origin )
{
    level endon( #"game_ended" );
    sfx = spawnscriptable( "quest_saw_pied_piper_rat_squeaks", v_origin );
    
    /#
        debug::print3d( sfx, "<dev string:x85>", "<dev string:x24>", 5 );
    #/
    
    wait 5;
    sfx freescriptable();
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x383159, Offset: 0x14c9
// Size: 0xbf
function private spawn_electrical_box()
{
    var_f817c3d3f453b6f2 = spawnscriptable( "quest_saw_electrical_box", ( -3155, 6977, 979 ) );
    var_f817c3d3f453b6f2.angles = ( 0, 55, 0 );
    var_f817c3d3f453b6f2 setscriptablepartstate( "body", "default" );
    interaction::register_scriptable_interact( var_f817c3d3f453b6f2, undefined, undefined, &function_5e6c05644cf4d51, &electrical_box_hint_callback );
    var_f817c3d3f453b6f2.quest = self;
    self.var_f817c3d3f453b6f2 = var_f817c3d3f453b6f2;
    electrical_box_fuse = spawnscriptable( "quest_saw_electrical_box_fuse", ( -3154, 6978, 979 ) );
    electrical_box_fuse.angles = ( 0, 55, 0 );
    self.electrical_box_fuse = electrical_box_fuse;
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x293ae241, Offset: 0x1590
// Size: 0x32
function private enable_electrical_box()
{
    self.var_f817c3d3f453b6f2 setscriptablepartstate( "spark", "on" );
    self.var_f817c3d3f453b6f2 setscriptablepartstate( "usable", "enabled" );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x6eb58d02, Offset: 0x15ca
// Size: 0x6d
function private enable_elevator_fusebox()
{
    elevator_fusebox = getentitylessscriptablearray( "elevator_fusebox", "targetname" )[ 0 ];
    elevator_fusebox setscriptablepartstate( "usable", "enabled" );
    elevator_fusebox setscriptablepartstate( "body", "harvest_default" );
    interaction::register_scriptable_interact( elevator_fusebox, undefined, undefined, &function_5e6c05644cf4d51, &electrical_box_hint_callback );
    self.elevator_fusebox_fuse setscriptablepartstate( "fuse", "visible" );
}

// Namespace namespace_10a8697f7706c463
// Params 2
// Checksum 0x126b343b, Offset: 0x163f
// Size: 0xba
function electrical_box_hint_callback( scriptable, player )
{
    if ( isdefined( scriptable.quest ) )
    {
        if ( player br_quest_inventory::has_quest_item( scriptable.quest.fuse_consumable ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"mp_saw_manticore/repair", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #string:&"", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_10a8697f7706c463
// Params 1
// Checksum 0x8983dbe1, Offset: 0x1701
// Size: 0x1bb
function function_5e6c05644cf4d51( player )
{
    if ( isdefined( self.quest ) && !player br_quest_inventory::has_quest_item( self.quest.fuse_consumable ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self setscriptablepartstate( "usable", "off" );
    params = { #hud_description:&"hash_5b24c96557b8895", #var_b35caf93a1ae502d:self, #hold_time:2.7, #craft_reason:#"ww_qv" };
    result = player function_e4eb2d1c1bd8fc4e( params );
    
    if ( result )
    {
        if ( isdefined( self.quest ) )
        {
            player br_quest_inventory::consume_quest_item( self.quest.fuse_consumable );
            self setscriptablepartstate( "spark", "off" );
            self.quest.electrical_box_fuse setscriptablepartstate( "fuse", "visible_no_outline" );
            self.quest function_4ff316e5d9e0572d();
        }
        else
        {
            quest = br_map_quest::get_quest( "mtc_pied_piper" );
            self setscriptablepartstate( "body", "opened_harvested" );
            fakeitem = spawnstruct();
            fakeitem.type = "brloot_saw_quest_fuse";
            fakeitem.count = 1;
            player common_item::function_96119bed8ab4c5d9( fakeitem );
            quest.elevator_fusebox_fuse setscriptablepartstate( "fuse", "hidden" );
        }
        
        return;
    }
    
    self setscriptablepartstate( "usable", "enabled" );
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x66f03d59, Offset: 0x18c4
// Size: 0xd1, Type: bool
function private function_e4eb2d1c1bd8fc4e( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self setscriptablepartstate( "sndCrafting", "crafting", 0 );
    function_eb3a5a6c3f4f3ba6( params );
    result = function_df340931f1a0fe6e( params.hold_time, params.var_b35caf93a1ae502d, params.radius, params.save_progress, params.saved_use_object );
    
    if ( isdefined( self.var_a0de55e36be21b7a ) )
    {
        function_7c7ed762cd4d0333();
    }
    
    if ( result )
    {
        self setscriptablepartstate( "sndCrafting", "success", 0 );
    }
    else
    {
        self setscriptablepartstate( "sndCrafting", "fail", 0 );
    }
    
    function_b94186b3fb991490( params );
    return istrue( result );
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x448c0870, Offset: 0x199e
// Size: 0x72
function private function_eb3a5a6c3f4f3ba6( params )
{
    assert( isdefined( params.craft_reason ) );
    assert( !self.is_crafting );
    setup_player_crafting( params.craft_reason, params.allow_movement );
    inventory_utility::givegunlessweapon();
    thread utility::function_72b6372d2d8c997( params.gesture ?? "cer_zm_vm_ges_knucklecrack", 1 );
}

// Namespace namespace_10a8697f7706c463
// Params 2, eflags: 0x4
// Checksum 0x3204ddd9, Offset: 0x1a18
// Size: 0x6d
function private setup_player_crafting( reason, allow_movement )
{
    self.is_crafting = 1;
    val::set( reason, "allow_movement", istrue( allow_movement ) );
    val::set( reason, "killstreaks", 0 );
    val::set( reason, "melee", 0 );
    val::set( reason, "armor", 0 );
    val::set( reason, "usability", 0 );
}

// Namespace namespace_10a8697f7706c463
// Params 2, eflags: 0x4
// Checksum 0xf2145ff1, Offset: 0x1a8d
// Size: 0xd0
function private function_307c21197e0798d4( var_ed466fad37317edc, str_caption )
{
    if ( !isdefined( self.var_a0de55e36be21b7a ) )
    {
        self.var_a0de55e36be21b7a = lui_elems::register_lui_elem( "Interactionholding", #"interactionholding" );
    }
    
    if ( !self isluielemopenforplayer( self.var_a0de55e36be21b7a.menuname, self.var_a0de55e36be21b7a.regid ) )
    {
        self.var_a0de55e36be21b7a lui_elems::open_lui_elem( self );
    }
    
    function_45e51da251cd5e3a( 0 );
    
    if ( !isdefined( var_ed466fad37317edc ) )
    {
        var_ed466fad37317edc = &"";
    }
    
    self.var_a0de55e36be21b7a lui_elems::function_dccebe4829a93560( self, 1, var_ed466fad37317edc );
    
    if ( !isdefined( str_caption ) )
    {
        str_caption = &"";
    }
    
    self.var_a0de55e36be21b7a lui_elems::function_dccebe4829a93560( self, 3, str_caption );
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x9172beee, Offset: 0x1b65
// Size: 0x4a
function private function_45e51da251cd5e3a( frac )
{
    assert( isdefined( self.var_a0de55e36be21b7a ), "<dev string:x8d>" );
    self notify( #"hash_b2c8a65bb4eb6893", frac );
    self.var_a0de55e36be21b7a lui_elems::function_dccebe4829a93560( self, 2, frac * 300 );
}

// Namespace namespace_10a8697f7706c463
// Params 6, eflags: 0x4
// Checksum 0x48ab9cdb, Offset: 0x1bb7
// Size: 0x2d9
function private function_df340931f1a0fe6e( hold_time, var_4eb7bbc8eb7cea79, radius, var_72e52350a5016ee6, var_7db86d9b3e6952c5, var_f0d87f75743a9881 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_38101be0adc9a0bf" );
    self endon( #"blackhole_teleporting" );
    var_7161dc5d09bfd375 = 0;
    start_time = gettime();
    result = 0;
    waitframe();
    
    if ( !isdefined( hold_time ) )
    {
        hold_time = 3;
    }
    
    if ( !isdefined( self.var_83cebc8cbb76e120 ) )
    {
        self.var_83cebc8cbb76e120 = 0;
    }
    
    if ( !isdefined( var_f0d87f75743a9881 ) )
    {
        var_f0d87f75743a9881 = 0;
    }
    
    if ( var_72e52350a5016ee6 )
    {
        if ( var_f0d87f75743a9881 )
        {
            if ( !isdefined( self.var_6d238ed5f0bf5c99 ) )
            {
                self.var_6d238ed5f0bf5c99 = [];
            }
            
            if ( isdefined( var_7db86d9b3e6952c5.var_83cebc8cbb76e120 ) && arraycontains( self.var_6d238ed5f0bf5c99, var_7db86d9b3e6952c5 ) )
            {
                self.var_83cebc8cbb76e120 = var_7db86d9b3e6952c5.var_83cebc8cbb76e120;
            }
            else
            {
                self.var_6d238ed5f0bf5c99[ self.var_6d238ed5f0bf5c99.size ] = var_7db86d9b3e6952c5;
                self.var_83cebc8cbb76e120 = 0;
            }
        }
        else if ( self.var_79d4743aaada7261 != var_7db86d9b3e6952c5 )
        {
            self notify( #"hash_e4dfcf56c4fe219d", self.var_83cebc8cbb76e120 );
            self.var_83cebc8cbb76e120 = 0;
        }
    }
    else
    {
        self.var_83cebc8cbb76e120 = 0;
    }
    
    callback::add( #"player_laststand", &function_31bdb221a1e771cb );
    
    while ( true )
    {
        if ( isdefined( var_4eb7bbc8eb7cea79 ) && isdefined( radius ) )
        {
            if ( self usebuttonpressed() && distance2d( self.origin, var_4eb7bbc8eb7cea79.origin ) <= radius )
            {
                var_7161dc5d09bfd375 = utility::function_6f5d2e1f1ff70482( gettime() - start_time + self.var_83cebc8cbb76e120 ) / hold_time;
                
                if ( var_7161dc5d09bfd375 <= 1 )
                {
                }
                else
                {
                    result = 1;
                    break;
                }
            }
            else
            {
                result = 0;
                break;
            }
        }
        else
        {
            info = weapon::function_e418c15787e60727( self );
            var_b69d7072ddcca9ea = info.var_17a7b9ae2a4d76d5;
            
            if ( self usebuttonpressed() || var_b69d7072ddcca9ea )
            {
                var_7161dc5d09bfd375 = utility::function_6f5d2e1f1ff70482( gettime() - start_time + self.var_83cebc8cbb76e120 ) / hold_time;
                
                if ( var_7161dc5d09bfd375 <= 1 )
                {
                }
                else
                {
                    result = 1;
                    break;
                }
            }
            else
            {
                result = 0;
                break;
            }
        }
        
        waitframe();
    }
    
    callback::remove( #"player_laststand", &function_31bdb221a1e771cb );
    wait 0.05;
    
    if ( var_72e52350a5016ee6 )
    {
        self.var_83cebc8cbb76e120 = self.var_83cebc8cbb76e120 + gettime() - start_time;
        self.var_79d4743aaada7261 = var_7db86d9b3e6952c5;
        
        if ( isdefined( var_7db86d9b3e6952c5 ) && var_f0d87f75743a9881 )
        {
            var_7db86d9b3e6952c5.var_83cebc8cbb76e120 = self.var_83cebc8cbb76e120;
        }
    }
    
    return result;
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x4995495f, Offset: 0x1e99
// Size: 0x1f
function private function_31bdb221a1e771cb( params )
{
    self notify( #"hash_38101be0adc9a0bf" );
    function_7c7ed762cd4d0333();
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xcb31e4ab, Offset: 0x1ec0
// Size: 0x5b
function private function_7c7ed762cd4d0333()
{
    assert( isdefined( self.var_a0de55e36be21b7a ), "<dev string:x8d>" );
    callback::remove( #"player_laststand", &function_31bdb221a1e771cb );
    function_45e51da251cd5e3a( 0 );
    waitframe();
    
    if ( self.var_a0de55e36be21b7a lui_elems::is_open_lui_elem( self ) )
    {
        self.var_a0de55e36be21b7a lui_elems::close_lui_elem( self );
    }
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0xbafc7e53, Offset: 0x1f23
// Size: 0x63
function private function_b94186b3fb991490( params )
{
    assert( isdefined( params.craft_reason ) );
    assert( self.is_crafting );
    release_player_crafting( params.craft_reason );
    inventory_utility::takegunlessweapon();
    self takeweapon( params.gesture ?? "cer_zm_vm_ges_knucklecrack" );
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x44189eae, Offset: 0x1f8e
// Size: 0x1f
function private release_player_crafting( reason )
{
    self.is_crafting = 0;
    val::reset_all( reason );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xa87e942a, Offset: 0x1fb5
// Size: 0x21
function private spawn_flute()
{
    self.scr_flute = spawnscriptable( "quest_saw_pied_piper_flute", ( -3122, 7913, 1091 ) );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xce78b502, Offset: 0x1fde
// Size: 0x39
function private function_ca44316d2bc39d30()
{
    while ( !isdefined( level.var_f09080c68f256ce6 ) )
    {
        waitframe();
    }
    
    self.scr_fountain = spawnscriptable( "quest_saw_pied_piper_fountain", level.var_f09080c68f256ce6.origin );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x3544c6f5, Offset: 0x201f
// Size: 0x1bd
function private function_846c5659236f1316()
{
    notes = [ "C", "D", "E", "F", "G", "A", "B", "C#" ];
    orientation = 10;
    increment = 45;
    self.pressure_plates = getentarray( "pressure_plate", "script_noteworthy" );
    
    foreach ( plate in self.pressure_plates )
    {
        plate.origin += ( 0, 0, -2 );
        plate.down_pos = plate.origin;
        plate.up_pos = plate.down_pos + ( 0, 0, 2 );
        plate.b_down = 1;
        note = utility::array_random( notes );
        plate.note = note;
        notes = arrayremove( notes, note );
        
        /#
            if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
            {
                debug::print3d( plate, plate.note, undefined, undefined, "<dev string:x69>" );
            }
        #/
    }
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x4b5ae9b7, Offset: 0x21e4
// Size: 0xd6
function private function_4ff316e5d9e0572d()
{
    /#
        if ( getdvarint( @"hash_75941d1c6b1a95dc" ) )
        {
            wait getdvarint( @"hash_75941d1c6b1a95dc" );
        }
    #/
    
    self.correct_notes = 0;
    
    foreach ( plate in self.pressure_plates )
    {
        plate moveto( plate.up_pos, 1 );
        plate.b_down = 0;
        plate setscriptablepartstate( "base", "activate_up" );
    }
    
    thread function_8739997711cca5ac();
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xc90f6e90, Offset: 0x22c2
// Size: 0xd7
function private function_8739997711cca5ac()
{
    foreach ( plate in self.pressure_plates )
    {
        plate.trigger = spawn( "noent_volume_trigger_box", plate.origin, 0, ( 4, 4, 4 ), ( 4, 4, 4 ) );
        plate.trigger.angles = plate.angles;
        thread function_1e9ea97e2973f511( plate );
    }
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x877155e2, Offset: 0x23a1
// Size: 0xca
function private function_1e9ea97e2973f511( plate )
{
    level endon( #"game_ended" );
    level endon( #"hash_559536171670639e" );
    plate.touching = [];
    
    while ( true )
    {
        plate.trigger waittill( #"trigger", ent );
        plate.touching[ ent getentitynumber() ] = ent;
        plate thread function_86a5fb8c97d15231( ent );
        
        if ( !plate.b_down )
        {
            plate moveto( plate.down_pos, 1 );
            plate.b_down = 1;
            plate setscriptablepartstate( "base", "down" );
            thread play_note( plate, ent );
            wait 1;
        }
    }
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0x37815a22, Offset: 0x2473
// Size: 0x9d
function private function_86a5fb8c97d15231( ent )
{
    level endon( #"game_ended" );
    level endon( #"hash_559536171670639e" );
    
    while ( isdefined( ent ) && ent istouching( self.trigger ) )
    {
        waitframe();
    }
    
    if ( isdefined( ent ) )
    {
        self.touching[ ent getentitynumber() ] = undefined;
    }
    
    if ( !self.touching.size && self.b_down )
    {
        self moveto( self.up_pos, 1 );
        self.b_down = 0;
        self setscriptablepartstate( "base", "up" );
    }
}

// Namespace namespace_10a8697f7706c463
// Params 2, eflags: 0x4
// Checksum 0xf0a62569, Offset: 0x2518
// Size: 0x120
function private play_note( plate, player )
{
    level endon( #"game_ended" );
    self.scr_flute setscriptablepartstate( "base", plate.note );
    
    /#
        debug::print3d( self.scr_flute.origin, toupper( self.scr_flute getscriptablepartstate( "<dev string:xa9>" ) ), undefined, 1 );
    #/
    
    if ( self.var_6ac3ff12b9b2c9eb < 3 )
    {
        return;
    }
    
    if ( plate.note == self.var_51761b0260803246[ self.correct_notes ] )
    {
        self.correct_notes++;
    }
    else if ( plate.note == self.var_51761b0260803246[ 0 ] )
    {
        self.correct_notes = 1;
    }
    else
    {
        self.correct_notes = 0;
    }
    
    if ( self.correct_notes == self.var_51761b0260803246.size )
    {
        thread function_4e30e90d6597ce13( player );
        return;
    }
    
    waitframe();
    self.scr_flute setscriptablepartstate( "base", "Idle" );
}

// Namespace namespace_10a8697f7706c463
// Params 1, eflags: 0x4
// Checksum 0xa62c4bf, Offset: 0x2640
// Size: 0x23a
function private function_4e30e90d6597ce13( player )
{
    level endon( #"game_ended" );
    level notify( #"hash_559536171670639e" );
    wait 2;
    earthquake( 0.1, 10, level.var_f09080c68f256ce6.origin, 1000 );
    
    /#
        if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
        {
            debug::sphere( level.var_f09080c68f256ce6.origin, 1000, "<dev string:x65>", 10 );
        }
    #/
    
    self.scr_flute setscriptablepartstate( "base", "Three Blind Mice" );
    self.scr_flute scriptablesetparententity( level.var_f09080c68f256ce6, self.scr_flute.origin - level.var_f09080c68f256ce6.origin );
    
    /#
        debug::print3d( self.scr_flute, toupper( self.scr_flute getscriptablepartstate( "<dev string:xa9>" ) ), undefined, 10 );
    #/
    
    self.scr_fountain setscriptablepartstate( "base", "rise" );
    self.scr_fountain scriptablesetparententity( level.var_f09080c68f256ce6 );
    
    /#
        debug::print3d( self.scr_fountain, self.scr_fountain getscriptablepartstate( "<dev string:xa9>" ), undefined, 10 );
    #/
    
    foreach ( plate in self.pressure_plates )
    {
        plate.trigger delete();
        
        if ( !plate.b_down )
        {
            plate moveto( plate.down_pos, 1 );
            plate setscriptablepartstate( "base", "deactivate_down" );
        }
        
        plate.b_down = undefined;
    }
    
    level.var_f09080c68f256ce6 namespace_74f91c27e9a42e2a::fountain_move_up();
    challenges::function_37e945722d6497f3( player, "manticore_sq_pied_piper", 1, 1 );
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0x193423c7, Offset: 0x2882
// Size: 0x198
function private spawn_caches()
{
    quest = br_map_quest::get_quest( "mtc_pied_piper" );
    loot_zone = br_map_quest::get_setting( "cache_loot_zone" );
    staged_caches_normal = br_map_quest::get_setting( "staged_caches_normal" );
    staged_caches_lege = br_map_quest::get_setting( "staged_caches_lege" );
    
    if ( game_utility::function_f24780eadd3fb772() > 2 )
    {
        staged_caches_normal++;
        staged_caches_lege++;
    }
    
    staged_caches_normal_spawned = 0;
    staged_caches_lege_spawned = 0;
    quest.cache_locs = arrayrandomize( quest.cache_locs );
    
    foreach ( loc in quest.cache_locs )
    {
        if ( loc.script_noteworthy == "lege" )
        {
            if ( staged_caches_lege_spawned == staged_caches_lege )
            {
                continue;
            }
            else
            {
                staged_caches_lege_spawned++;
            }
        }
        else if ( staged_caches_normal_spawned == staged_caches_normal )
        {
            continue;
        }
        else
        {
            staged_caches_normal_spawned++;
        }
        
        var_1135b81b40c4ece1 = loc.script_noteworthy == "lege" ? "br_loot_cache_lege" : "br_reusable_loot_cache";
        script_cache = common_cache::function_9bc018c1b8aad720( var_1135b81b40c4ece1, loc.origin, loc.angles, undefined, loot_zone );
    }
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xb3bb2f64, Offset: 0x2a22
// Size: 0xf1
function private spawn_staged_loot()
{
    quest = br_map_quest::get_quest( "mtc_pied_piper" );
    
    foreach ( s in quest.var_ca7594b1e544cd09 )
    {
        item_bundle = getscriptbundle( "itemspawnentry:" + s.script_noteworthy );
        spawnoptions = common_item::function_bc5ff2958b71a708( s.origin, s.angles );
        spawnoptions.critical = 1;
        scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
    }
}

// Namespace namespace_10a8697f7706c463
// Params 0, eflags: 0x4
// Checksum 0xef7bdb43, Offset: 0x2b1b
// Size: 0x70
function private function_9ad16710ca258c00()
{
    function_da4b5455d7e6e640( "manticore_three_blind_mice", "interactive_note_paper", self.sheet_music_loc.origin, self.sheet_music_loc.angles );
    function_da4b5455d7e6e640( "manticore_piedpiper_lab_lore", "interactive_note_paper", self.var_df5fc475e2503156.origin, self.var_df5fc475e2503156.angles );
}

// Namespace namespace_10a8697f7706c463
// Params 4, eflags: 0x4
// Checksum 0x6820ffa3, Offset: 0x2b93
// Size: 0x74
function private function_da4b5455d7e6e640( ref, scriptable, origin, angles )
{
    data = namespace_69f464ded04255f4::create_note_data( ref, scriptable );
    note = namespace_69f464ded04255f4::spawn_note( data, origin, angles );
    
    /#
        if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
        {
            debug::sphere( note, undefined, undefined, undefined, "<dev string:x69>" );
        }
    #/
}

/#

    // Namespace namespace_10a8697f7706c463
    // Params 0
    // Checksum 0xbc6076ed, Offset: 0x2c0f
    // Size: 0x5, Type: dev
    function function_281fd8b149568957()
    {
        
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0xd030b771, Offset: 0x2c1c
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x3bed29e0, Offset: 0x2c30
    // Size: 0xce, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xae>" + level.mapname + "<dev string:xbd>" + "<dev string:xbf>" + "<dev string:xbd>" );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xdb>", &function_3e433349caec56ca );
        devgui::add_devgui_func( "<dev string:xeb>", "<dev string:x106>", &function_93624fe34c59d70c );
        devgui::add_devgui_func( "<dev string:x124>", "<dev string:x13d>", &function_e8dbd5f263a6dffc );
        devgui::add_devgui_func( "<dev string:x159>", "<dev string:x172>", &function_6b01fde581195e65 );
        devgui::add_devgui_func( "<dev string:x18e>", "<dev string:x1a5>", &function_e0da55f4a800d11c );
        devgui::add_devgui_func( "<dev string:x1bf>", "<dev string:x1da>", &function_b0d0bf2f2664376e );
        devgui::add_devgui_func( "<dev string:x1f8>", "<dev string:x208>", &function_ccf53e3d1918689f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x7b90828c, Offset: 0x2d06
    // Size: 0x5c, Type: dev
    function private function_3e433349caec56ca()
    {
        if ( !getdvarint( @"hash_d00cafde1fd1b40c" ) )
        {
            setdvar( @"hash_d00cafde1fd1b40c", 1 );
            iprintlnbold( "<dev string:x21b>" );
            level thread function_9df431165789482a();
            return;
        }
        
        setdvar( @"hash_d00cafde1fd1b40c", 0 );
        iprintlnbold( "<dev string:x23c>" );
        level thread function_e92d502282c3da9c();
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x98c18f2b, Offset: 0x2d6a
    // Size: 0x1b1, Type: dev
    function private function_9df431165789482a()
    {
        quest = br_map_quest::get_quest( "<dev string:xbf>" );
        
        foreach ( mousetrap in quest.var_b1b5e539a6c25a98 )
        {
            debug::sphere( mousetrap, undefined, "<dev string:x65>", undefined, "<dev string:x69>" );
        }
        
        foreach ( var_5baf88721a84cc3b in quest.spawned_cheese )
        {
            debug::sphere( var_5baf88721a84cc3b, undefined, "<dev string:x7e>", undefined, "<dev string:x69>" );
        }
        
        foreach ( plate in quest.pressure_plates )
        {
            debug::print3d( plate, plate.note, undefined, undefined, "<dev string:x69>" );
        }
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x5e12956a, Offset: 0x2f23
    // Size: 0x11, Type: dev
    function private function_e92d502282c3da9c()
    {
        level notify( #"hash_3a0910a556290ff0" );
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0xb3254f74, Offset: 0x2f3c
    // Size: 0x3f, Type: dev
    function private function_93624fe34c59d70c()
    {
        level.player setorigin( ( -3138, 7001, 986 ), 1 );
        level.player setplayerangles( ( 12, 231, 0 ), 1 );
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0xa01211d8, Offset: 0x2f83
    // Size: 0x3f, Type: dev
    function private function_e8dbd5f263a6dffc()
    {
        level.player setorigin( ( -975, 10861, 982 ), 1 );
        level.player setplayerangles( ( 0, 55, 0 ), 1 );
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x65c6ff8b, Offset: 0x2fca
    // Size: 0xcc, Type: dev
    function private function_6b01fde581195e65()
    {
        quest = br_map_quest::get_quest( "<dev string:xbf>" );
        
        foreach ( plate in quest.pressure_plates )
        {
            if ( plate.b_down )
            {
                plate moveto( plate.up_pos, 1 );
                plate.b_down = 0;
                plate setscriptablepartstate( "<dev string:xa9>", "<dev string:x25e>" );
            }
        }
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0xefea680d, Offset: 0x309e
    // Size: 0x102, Type: dev
    function private function_e0da55f4a800d11c()
    {
        quest = br_map_quest::get_quest( "<dev string:xbf>" );
        
        foreach ( plate in quest.pressure_plates )
        {
            if ( plate.b_down )
            {
                plate moveto( plate.up_pos, 1 );
                plate.b_down = 0;
                plate setscriptablepartstate( "<dev string:xa9>", "<dev string:x26a>" );
                continue;
            }
            
            plate moveto( plate.down_pos, 1 );
            plate.b_down = 1;
            plate setscriptablepartstate( "<dev string:xa9>", "<dev string:x26d>" );
        }
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x13448d36, Offset: 0x31a8
    // Size: 0xce, Type: dev
    function private function_b0d0bf2f2664376e()
    {
        quest = br_map_quest::get_quest( "<dev string:xbf>" );
        
        foreach ( plate in quest.pressure_plates )
        {
            if ( !plate.b_down )
            {
                plate moveto( plate.down_pos, 1 );
                plate.b_down = 1;
                plate setscriptablepartstate( "<dev string:xa9>", "<dev string:x272>" );
            }
        }
    }

    // Namespace namespace_10a8697f7706c463
    // Params 0, eflags: 0x4
    // Checksum 0x52f1e6f6, Offset: 0x327e
    // Size: 0x160, Type: dev
    function private function_ccf53e3d1918689f()
    {
        if ( level.var_f09080c68f256ce6.var_dfd266d94c7ed705 == "<dev string:x26d>" )
        {
            quest = br_map_quest::get_quest( "<dev string:xbf>" );
            earthquake( 0.1, 10, level.var_f09080c68f256ce6.origin, 1000 );
            
            if ( getdvarint( @"hash_d00cafde1fd1b40c" ) )
            {
                debug::sphere( level.var_f09080c68f256ce6.origin, 1000, "<dev string:x65>", 10 );
            }
            
            quest.scr_flute setscriptablepartstate( "<dev string:xa9>", "<dev string:x282>" );
            quest.scr_flute scriptableclearparententity();
            quest.scr_flute scriptablesetparententity( level.var_f09080c68f256ce6, quest.scr_flute.origin - level.var_f09080c68f256ce6.origin );
            quest.scr_fountain setscriptablepartstate( "<dev string:xa9>", "<dev string:x293>" );
            quest.scr_fountain scriptableclearparententity();
            quest.scr_fountain scriptablesetparententity( level.var_f09080c68f256ce6 );
            level.var_f09080c68f256ce6 thread namespace_74f91c27e9a42e2a::fountain_move_up();
            return;
        }
        
        level.var_f09080c68f256ce6 thread namespace_74f91c27e9a42e2a::fountain_move_down();
    }

#/
