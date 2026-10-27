// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_fergus.gsc  (hash_6439d5e1b48a2ba2.gscc) (size: 23145 Bytes / 0x5a69 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x659c325d (1704735325)
// size ...... 23145 (0x5a69)
// includes .. 12  (offset: 0x5355)
// strings ... 78  (offset: 0x53b5)
// dev strs .. 22  (offset: 0x5895)
// exports ... 50  (offset: 0x3b81)
// cseg ...... 0x721 + 0x3460 (0x3b81)
// imports ... 126 (offset: 0x4351)
// animtree1 . 1   (offset: 0x59e9)
// animtree2 . 6   (offset: 0x5a09)
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_sat_locust_fergus;

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x5
// Checksum 0x33919742, Offset: 0x73f
// Size: 0x5b
function private autoexec init()
{
    utility::add_fx( "rod_magic", "vfx_sat_levels_zm_locust_mq_fish_float_amb" );
    level.fishing_struct = {};
    level thread init_fishing_poles();
    level thread function_c94ce6b17f026661();
    level thread init_fishing_rod_barrels();
    level thread init_fishing_loot_data();
    level thread init_fishing_anims();
    utility::flag_wait( "loading_screen_fade_out_begin" );
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x361050ea, Offset: 0x7a2
// Size: 0x10f
function private init_fishing_poles()
{
    utility::flag_wait( "loading_screen_fade_out_begin" );
    var_b79ab0dc95b26a5f = utility::getstructarray( "fishing_pole_loc", "script_noteworthy" );
    rod_pickups = [];
    
    foreach ( var_b11b64f5583f0be3 in var_b79ab0dc95b26a5f )
    {
        item = function_dd472c8d2675f644( var_b11b64f5583f0be3.origin, var_b11b64f5583f0be3.angles );
        rod_pickups[ rod_pickups.size ] = item;
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"pole_pickups", rod_pickups );
    level callback::add( #"quest_item_can_use", &function_7f4f6877d81fc769 );
    level callback::add( "quest_item_used", &function_e6025e370f214e3d );
    utility::flag_set( "poles_initalized" );
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x24b56603, Offset: 0x8b9
// Size: 0x34f
function private function_c94ce6b17f026661()
{
    utility::flag_wait( "scriptables_ready" );
    level.fishing_struct.rod_stands = utility::getstructarray( "fishing_pole_stand_loc", "script_noteworthy" );
    level.fishing_struct.fishing_holes = utility::getstructarray( "fishing_hole_loc", "script_noteworthy" );
    level.fishing_struct.loot_pickup_location = utility::getstructarray( "fishing_release_loc", "script_noteworthy" );
    var_f4f26fcc4fca2ff4 = &function_8bc3c540e7a2;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_f4f26fcc4fca2ff4 = utility::callsharedfunc( #"directed_mode", #"get_interact_func", #"fishing_stand" );
    }
    
    foreach ( stand in level.fishing_struct.rod_stands )
    {
        stand.scriptable = spawnscriptable( %"sat_zm_stand_fergus", stand.origin, stand.angles );
        stand.scriptable setscriptablepartstate( "usable", "disabled" );
        interaction::register_scriptable_interact( stand.scriptable, &function_9f3f6acade8440be, undefined, undefined, var_f4f26fcc4fca2ff4 );
        stand.scriptable.struct = stand;
        stand.scriptable.fishing_hole = utility::getstruct( stand.target, "targetname" );
        stand.scriptable.fishing_hole.var_f9cd5cbcdb7bf574 = stand;
    }
    
    foreach ( var_12d72740175e8cac in level.fishing_struct.fishing_holes )
    {
        var_12d72740175e8cac.scriptable = spawnscriptable( %"sat_zm_hole_fergus", var_12d72740175e8cac.origin, var_12d72740175e8cac.angles );
        var_12d72740175e8cac.scriptable setscriptablepartstate( #"vfx", #"enabled" );
        var_12d72740175e8cac.scriptable.var_b3fd65f70afca6aa = 0;
        var_12d72740175e8cac.scriptable.struct = var_12d72740175e8cac;
        var_12d72740175e8cac.idx = int( strtok( var_12d72740175e8cac.groupid, "fishing_spot_" )[ 0 ] );
        var_12d72740175e8cac.scriptable.loot_spawn_loc = utility::getstruct( var_12d72740175e8cac.target, "targetname" );
    }
    
    utility::flag_set( "fishing_spots_ready" );
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0xcf893255, Offset: 0xc10
// Size: 0x18d
function private init_fishing_rod_barrels()
{
    utility::flag_wait( "scriptables_ready" );
    barrel_structs = utility::getstructarray( "fishing_pole_barrel", "script_noteworthy" );
    level.fishing_struct.rod_barrels = [];
    
    foreach ( barrel_struct in barrel_structs )
    {
        if ( isdefined( barrel_struct.target ) )
        {
            var_c50461af94c08bab = utility::getstructarray( barrel_struct.target, "targetname" );
        }
        else
        {
            var_c50461af94c08bab = utility::getstructarray( "in_barrel_fishing_rod", "script_noteworthy" );
        }
        
        barrel = spawnscriptable( %"sat_zm_barrel_fergus", barrel_struct.origin, barrel_struct.angles );
        barrel setscriptablepartstate( "ping", "enabled" );
        barrel.max_rods = 1;
        barrel.rod_structs = var_c50461af94c08bab;
        barrel thread rod_barrel_on_round_end();
        interaction::register_scriptable_interact( barrel, &function_606e2bee7e73992a, undefined, undefined, &look_at_rod_barrel_hint );
        level.fishing_struct.rod_barrels[ level.fishing_struct.rod_barrels.size ] = barrel;
    }
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x618c490c, Offset: 0xda5
// Size: 0x17d
function private init_fishing_loot_data()
{
    level.fishing_struct.var_2870643174e16d7d = [ %"hash_3b91517f24547229", %"hash_3f8f43702c6cf00", %"hash_62e131cf5b4ac168" ];
    level.fishing_struct.var_83f376a30c506f71 = [ %"hash_150254a440bc8bbf", %"hash_7c820c39c69c1318", %"hash_36a78d1beabdd6f0" ];
    level.fishing_struct.loot_index = 0;
    level.fishing_struct.super_loot_count = 3;
    level.fishing_struct.ultra_loot_count = 1;
    level.fishing_struct.var_113cd2679b20848d = 4;
    level.fishing_struct.force_injection = 0;
    level.fishing_struct.force_rcxd = 0;
    level.fishing_struct.force_glocke = 0;
    level.fishing_struct.force_wb = 0;
    level.fishing_struct.var_2219fd082a1a34b3 = 2;
    level.fishing_struct.rcxd_remaining = 2;
    level.fishing_struct.glocke_remaining = 5;
    level.fishing_struct.wb_remaining = 5;
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0x922da59d, Offset: 0xf2a
// Size: 0x155
function private function_e6025e370f214e3d( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_fergus" || params.bundle.scriptable == %"hash_2748f9c3ea15c1e8" )
    {
        params.player function_c58d10b4f34e8525( 1 );
        zm_quest::show_splash_item_picked_up( #"hash_4c9cc3cf85d5472c", #"fishing_rod", 1, params.player );
        params.player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
        
        foreach ( barrel in level.fishing_struct.rod_barrels )
        {
            if ( barrel.max_rods < 4 )
            {
                barrel.max_rods++;
            }
        }
        
        if ( !utility::flag( #"collect_rod" ) )
        {
            function_49218c16f4815e4();
        }
    }
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0x6ccb6505, Offset: 0x1087
// Size: 0x62, Type: bool
function private function_7f4f6877d81fc769( params )
{
    if ( params.bundle.ref != %"sat_zm_quest_locust_fergus" )
    {
        return true;
    }
    
    if ( params.player function_c981f5f464e676e5() || params.scriptable.in_barrel )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0x679fe5fb, Offset: 0x10f2
// Size: 0x106
function private function_606e2bee7e73992a( player )
{
    if ( player function_c981f5f464e676e5() || self.interacts_this_round >= self.max_rods )
    {
        return;
    }
    
    if ( !utility::flag( #"collect_rod" ) )
    {
        function_49218c16f4815e4();
    }
    
    level callback::callback( "fishing_barrel_used" );
    playsoundatpos( self.origin, "evt_fishing_rod_pickup_item" );
    player function_c58d10b4f34e8525( 1 );
    zm_quest::show_splash_item_picked_up( #"hash_4c9cc3cf85d5472c", #"fishing_rod", 1, player );
    player thread common_item::function_29cda7adf128f6fb( getscriptbundle( %"hash_2ac03b2925ecadc1" ), 1 );
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    
    if ( isdefined( self.rod_structs[ self.interacts_this_round ].dummy_pickup ) )
    {
        self.rod_structs[ self.interacts_this_round ].dummy_pickup freescriptable();
    }
    
    self.interacts_this_round++;
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0xc
// Checksum 0x7d81551e, Offset: 0x1200
// Size: 0xb5
function private rod_barrel_on_round_end()
{
    self notify( #"hash_b0fc615a8bfcadbf" );
    self endon( #"hash_b0fc615a8bfcadbf" );
    level endon( #"game_over" );
    
    while ( true )
    {
        self.interacts_this_round = 0;
        
        for ( i = 0; i < self.max_rods ; i++ )
        {
            var_6720577a9c2306b4 = self.rod_structs[ i ];
            
            if ( !isdefined( var_6720577a9c2306b4.dummy_pickup ) )
            {
                var_6720577a9c2306b4.dummy_pickup = function_dd472c8d2675f644( var_6720577a9c2306b4.origin, var_6720577a9c2306b4.angles, 1 );
            }
        }
        
        level waittill( #"on_round_end" );
    }
}

// Namespace zm_sat_locust_fergus
// Params 2, eflags: 0x4
// Checksum 0xf8c44dd6, Offset: 0x12bd
// Size: 0x87
function private look_at_rod_barrel_hint( interact, player )
{
    if ( player function_c981f5f464e676e5() )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #description:&"zm_sat_locust/rod_barrel_hint", #title:&"zm_sat_locust/rod_barrel_title", #icon:"sat_ui_icon_zm_ping_fishing_rod_01", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x49aaf4ac, Offset: 0x134c
// Size: 0x153
function function_49218c16f4815e4()
{
    utility::flag_set( #"collect_rod" );
    
    foreach ( var_12d72740175e8cac in level.fishing_struct.fishing_holes )
    {
        var_12d72740175e8cac.scriptable thread function_28ef017417acf8d8();
    }
    
    foreach ( stand in level.fishing_struct.rod_stands )
    {
        stand.scriptable setscriptablepartstate( "usable", "enabled" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

#using_animtree( "zm_sat_locust_scriptables" );

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0xbfc3dad7, Offset: 0x14a7
// Size: 0x1fa
function private init_fishing_anims()
{
    level.scr_animtree[ "fishing_rod" ] = #animtree;
    level.scr_anim[ "fishing_rod" ][ "cast_out" ][ 0 ] = %sat_zm_fishing_rod_cast_out_anim;
    level.scr_eventanim[ "fishing_rod" ][ "cast_out" ][ 0 ] = %"sat_zm_fishing_rod_cast_out_anim";
    level.scr_animtree[ "fishing_rod" ] = #animtree;
    level.scr_anim[ "fishing_rod" ][ "idle" ][ 0 ] = %sat_zm_fishing_nibbling_on_bait_anim;
    level.scr_eventanim[ "fishing_rod" ][ "idle" ][ 0 ] = %"sat_zm_fishing_nibbling_on_bait_anim";
    level.scr_animtree[ "fishing_rod" ] = #animtree;
    level.scr_anim[ "fishing_rod" ][ "catch_on_line" ][ 0 ] = %sat_zm_fishing_set_on_hook_anim;
    level.scr_eventanim[ "fishing_rod" ][ "catch_on_line" ][ 0 ] = %"sat_zm_fishing_set_on_hook_anim";
    level.scr_animtree[ "fishing_rod" ] = #animtree;
    level.scr_anim[ "fishing_rod" ][ "bobbbing" ][ 0 ] = %sat_zm_fishing_bobbing_anim;
    level.scr_eventanim[ "fishing_rod" ][ "bobbbing" ][ 0 ] = %"sat_zm_fishing_bobbing_anim";
    level.scr_animtree[ "fishing_rod" ] = #animtree;
    level.scr_anim[ "fishing_rod" ][ "reel_in" ][ 0 ] = %sat_zm_fishing_reeled_in_anim;
    level.scr_eventanim[ "fishing_rod" ][ "reel_in" ][ 0 ] = %"sat_zm_fishing_reeled_in_anim";
    level.scr_animtree[ "fishing_rod" ] = #animtree;
    level.scr_anim[ "fishing_rod" ][ "pulled_away" ][ 0 ] = %sat_zm_fishing_pulled_away_anim;
    level.scr_eventanim[ "fishing_rod" ][ "pulled_away" ][ 0 ] = %"sat_zm_fishing_pulled_away_anim";
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x4072ecc2, Offset: 0x16a9
// Size: 0x2
function function_7de960b048b6cca6()
{
    
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0xc
// Checksum 0x28e7af80, Offset: 0x16b3
// Size: 0xd0
function private function_aa5c1a22309d79ca( player )
{
    self notify( #"hash_113944bdbbf805ea" );
    self endon( #"hash_113944bdbbf805ea" );
    level endon( #"game_ended" );
    level endon( #"zm_game_over" );
    self endon( #"hash_4b069fb0a7cf1081" );
    self endon( #"catch_fail" );
    player waittill( #"death_or_disconnect" );
    has_uranium = self.fishing_hole.scriptable getscriptablepartstate( "vfx" ) == "enabled_irradiated";
    
    if ( has_uranium )
    {
        if ( !self.object_on_the_hook )
        {
            self waittill( #"hash_82d641a2cc94e6cb" );
        }
        
        self.fishing_hole.scriptable thread function_269735aa7872cd67();
    }
    
    thread break_rod();
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0xc
// Checksum 0x4b12dd32, Offset: 0x178b
// Size: 0x34e
function private function_9f3f6acade8440be( player )
{
    self notify( #"hash_8d02ba43b85814fc" );
    self endon( #"hash_8d02ba43b85814fc" );
    
    if ( !self.fishing_hole.scriptable.active_fish )
    {
        return;
    }
    
    if ( !self.rod_model && !player function_c981f5f464e676e5() )
    {
        return;
    }
    
    if ( self.stored_player && player != self.stored_player )
    {
        return;
    }
    
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    
    if ( !isdefined( self.rod_model ) && !isdefined( self.stored_player ) && player function_c981f5f464e676e5() )
    {
        thread function_aa5c1a22309d79ca( player );
        player function_c58d10b4f34e8525( 0 );
        self.stored_player = player;
        function_438639be07ebc488();
        self.rod_model scriptmodelplayanim( "sat_zm_fishing_rod_cast_out_anim", undefined, undefined, 1 );
        self setscriptablepartstate( "audio", "cast_out" );
        self.fishing_hole.scriptable setscriptablepartstate( "water_spash", "enabled" );
        thread function_d2a597e52ca074dc();
        params = { #player:player, #rod_model:self.rod_model, #fishing_hole:self.struct };
        level callback::callback( "fergus_rod_placed", params );
        return;
    }
    
    if ( isdefined( self.rod_model ) && self.stored_player == player )
    {
        self notify( #"hash_4b069fb0a7cf1081" );
        
        if ( self.object_on_the_hook )
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            self setscriptablepartstate( "usable", "disabled" );
            self setscriptablepartstate( "audio", "reel_in" );
            self.fishing_hole.scriptable setscriptablepartstate( "water_spash", "enabled" );
            self.rod_model scriptmodelplayanim( "sat_zm_fishing_reeled_in_anim", undefined, undefined, 2 );
            self.var_678e30c3c3ad3edc = 1;
            wait 1.25;
            self.var_678e30c3c3ad3edc = 0;
            self.object_on_the_hook = 0;
            self setscriptablepartstate( "audio", "success" );
            stopfxontag( level._effect[ "rod_magic" ], self.rod_model, "j_butt_01" );
            self.fishing_hole.scriptable thread function_269735aa7872cd67( player );
        }
        else
        {
            has_uranium = self.fishing_hole.scriptable getscriptablepartstate( "vfx" ) == "enabled_irradiated";
            
            if ( zm_quest::function_b0a5181ebe7bb905() && has_uranium && utility::flag( #"hash_35fd63a75bced24f" ) && !utility::flag( #"hash_35fd64a75bced402" ) )
            {
                utility::flag_clear( #"hash_35fd63a75bced24f" );
                level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
            }
        }
        
        player function_c58d10b4f34e8525( 1 );
        self.var_d8c01564b28b72c7 = 0;
        self.stored_player = undefined;
        self setscriptablepartstate( "audio", "rod_from_holder" );
        waitframe();
        function_dd503f2010da4a74();
    }
}

// Namespace zm_sat_locust_fergus
// Params 2, eflags: 0x4
// Checksum 0x24ae76be, Offset: 0x1ae1
// Size: 0x89
function private function_8bc3c540e7a2( interact, player )
{
    if ( !interact.fishing_hole.scriptable.active_fish )
    {
        return { #string:&"zm_sat_locust/hint_no_fish", #var_26bbd300351fde34:0, #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0xa540657f, Offset: 0x1b72
// Size: 0x18b
function private function_d2a597e52ca074dc()
{
    level endon( #"game_ended" );
    self.stored_player endon( #"death_or_disconnect" );
    self endon( #"hash_82d641a2cc94e6cb" );
    self endon( #"hash_4b069fb0a7cf1081" );
    self endon( #"catch_fail" );
    wait 1.2;
    self.var_d8c01564b28b72c7 = 1;
    self setscriptablepartstate( "audio", "rod_into_holder" );
    self setscriptablepartstate( "usable", "enabled" );
    fishing_hole_scriptable = self.fishing_hole.scriptable;
    self.rod_model scriptmodelplayanim( "sat_zm_fishing_nibbling_on_bait_anim", undefined, undefined, 1 );
    time_waited = 0;
    has_uranium = fishing_hole_scriptable getscriptablepartstate( "vfx" ) == "enabled_irradiated";
    
    if ( zm_quest::function_b0a5181ebe7bb905() && has_uranium )
    {
        utility::flag_set( #"hash_35fd63a75bced24f" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    thread function_60b4905f1aaa4e5b();
    wait 5;
    
    while ( true )
    {
        wait 2;
        time_waited += 2;
        var_2517dd2b8b28893e = self.stored_player.fergus_data.var_9800444961e2dff6 ?? 40;
        
        if ( fishing_hole_scriptable.active_fish && utility::percent_chance( var_2517dd2b8b28893e ) || level.var_84efa2291c6f053b || time_waited >= 20 )
        {
            function_e0094abe235fcc78();
        }
    }
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0xc
// Checksum 0x30663740, Offset: 0x1d05
// Size: 0x99
function private function_60b4905f1aaa4e5b()
{
    self notify( #"hash_feb3e27026630924" );
    self endon( #"hash_feb3e27026630924" );
    self endon( #"game_ended" );
    self endon( #"hash_4b069fb0a7cf1081" );
    self endon( #"hash_82d641a2cc94e6cb" );
    self endon( #"catch_fail" );
    wait_duration = isdefined( self.stored_player.fergus_data ) ? self.stored_player.fergus_data.var_6d2623f6214ace88 : 20;
    wait wait_duration;
    function_e0094abe235fcc78();
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0xd28f9220, Offset: 0x1da6
// Size: 0xc6
function private function_e0094abe235fcc78()
{
    fishing_hole_scriptable = self.fishing_hole.scriptable;
    round_adjust = int( zm_round_logic::get_rb_round_number() / 15 ) + 1;
    round_adjust = round_adjust > 3 ? 3 : round_adjust;
    caught_count = min( 3, round_adjust );
    fishing_hole_scriptable.caught_fish = [];
    
    for ( i = 0; i < caught_count ; i++ )
    {
        fishing_hole_scriptable.caught_fish[ fishing_hole_scriptable.caught_fish.size ] = function_8ba6567444d2d7b();
    }
    
    /#
        iprintlnbold( "<dev string:x30>" );
    #/
    
    self setscriptablepartstate( "audio", "on_the_hook" );
    function_afd15abcb8d8b59a();
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x54fe730f, Offset: 0x1e74
// Size: 0x2c
function function_afd15abcb8d8b59a()
{
    self notify( #"hash_82d641a2cc94e6cb" );
    self.fishing_hole.scriptable notify( #"hash_82d641a2cc94e6cb" );
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x15c8aced, Offset: 0x1ea8
// Size: 0x12d
function private function_8ba6567444d2d7b()
{
    profilestart();
    caught_fish = function_f64393e02b6c8f12( self.stored_player );
    escape_time_limit = isdefined( self.stored_player.fergus_data ) ? self.stored_player.fergus_data.var_b715f87dfd5f250a : 5;
    
    if ( !isdefined( caught_fish ) )
    {
        profilestop();
        return undefined;
    }
    
    if ( self.stored_player && !self.stored_player.var_9c592b2357aff0e9 )
    {
        self.stored_player thread zm_vo::function_8c1a12974bd11f01( #"hash_d36b610919094be4" );
        self.stored_player.var_9c592b2357aff0e9 = 1;
    }
    
    self.object_on_the_hook = 1;
    var_ef682ab377047b82 = zm_quest::function_b0a5181ebe7bb905() && caught_fish == "uranium";
    
    if ( var_ef682ab377047b82 )
    {
        utility::flag_set( #"hash_35fd64a75bced402" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        thread function_c523ce8c548b87bd( escape_time_limit, 0 );
    }
    else
    {
        thread function_c523ce8c548b87bd( escape_time_limit );
    }
    
    profilestop();
    return caught_fish;
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0xe1cc85e7, Offset: 0x1fdf
// Size: 0x12d
function private function_f64393e02b6c8f12( player )
{
    fishing_hole = self.fishing_hole.scriptable;
    has_uranium = fishing_hole getscriptablepartstate( "vfx" ) == "enabled_irradiated";
    
    if ( has_uranium && level.fishing_struct.var_cbec9bf7ad43437e )
    {
        level.fishing_struct.var_cbec9bf7ad43437e = 0;
        return "uranium";
    }
    else if ( has_uranium && !level.fishing_struct.var_cbec9bf7ad43437e )
    {
        return;
    }
    
    var_4f7c497032717657 = getdvarint( @"hash_c5e7c59f3a6a92bf", 60 );
    loot_chance = isdefined( self.stored_player.fergus_data ) ? self.stored_player.fergus_data.var_9800444961e2dff6 : var_4f7c497032717657;
    
    if ( fishing_hole.struct.guaranteed_loot || utility::percent_chance( loot_chance ) )
    {
        return "loot";
    }
    
    return "zombie";
}

// Namespace zm_sat_locust_fergus
// Params 2, eflags: 0x4
// Checksum 0x76db0000, Offset: 0x2115
// Size: 0xaf
function private function_c523ce8c548b87bd( escape_timeout, var_2f8e3c8041bdf5b4 = 1 )
{
    level endon( #"game_ended" );
    self endon( #"hash_4b069fb0a7cf1081" );
    self.rod_model endon( #"death" );
    self.rod_model scriptmodelplayanim( "sat_zm_fishing_set_on_hook_anim", undefined, undefined, 1 );
    playfxontag( level._effect[ "rod_magic" ], self.rod_model, "j_butt_01" );
    wait 5;
    self.rod_model scriptmodelplayanim( "sat_zm_fishing_bobbing_anim", undefined, undefined, 1 );
    wait escape_timeout - 5;
    
    if ( var_2f8e3c8041bdf5b4 )
    {
        thread break_rod();
    }
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x7fb6303c, Offset: 0x21cc
// Size: 0x29f
function private break_rod()
{
    self notify( #"catch_fail" );
    level notify( #"hash_9b04c48191f2fee5" );
    stopfxontag( level._effect[ "rod_magic" ], self.rod_model, "j_butt_01" );
    
    foreach ( caught_fish in self.fishing_hole.scriptable.caught_fish )
    {
        if ( caught_fish === "uranium" )
        {
            level callback::callback( #"hash_521d7ba37c0a60b3", { #fishing_hole:self.fishing_hole } );
        }
    }
    
    self.fishing_hole.scriptable thread function_c89c7a96d390d153();
    self.fishing_hole.scriptable setscriptablepartstate( "vfx", "disabled" );
    self setscriptablepartstate( "audio", "lost_catch" );
    
    if ( isdefined( self.stored_player ) && !self.stored_player.broke_rod )
    {
        self.stored_player thread zm_vo::function_8c1a12974bd11f01( #"hash_99c78e874943696d" );
        self.stored_player.broke_rod = 1;
    }
    
    self.object_on_the_hook = 0;
    
    if ( isdefined( self.stored_player ) )
    {
        self.stored_player function_c58d10b4f34e8525( 2 );
        self.stored_player = undefined;
    }
    
    self.rod_model scriptmodelplayanim( "sat_zm_fishing_pulled_away_anim", undefined, undefined, 3 );
    control_pt = self.rod_model.origin + anglestoforward( self.rod_model.angles ) * 150 + ( 0, 0, 75 );
    end_pt = self.fishing_hole.scriptable.origin - ( 0, 0, 20 );
    self.rod_model utility::function_8001268940441423( self.rod_model.origin, end_pt, control_pt, 1, 0, 0 );
    function_dd503f2010da4a74();
    thread function_277117ae7b9425e5( self.fishing_hole.scriptable );
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x2082a05f, Offset: 0x2473
// Size: 0x78
function private function_438639be07ebc488()
{
    rod_origin = self.origin + anglestoup( self.angles ) * -2 + anglestoright( self.angles ) * 3.5;
    rod_angles = self.angles - ( -11, 90, 0 );
    self.rod_model = utility::spawn_model( %"sat_zm_locust_fishing_rod_01", rod_origin, rod_angles );
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0xce7ae134, Offset: 0x24f3
// Size: 0x29
function private function_dd503f2010da4a74()
{
    if ( !isdefined( self.rod_model ) )
    {
        return;
    }
    
    self.rod_model delete();
    self.rod_model = undefined;
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x15735cf5, Offset: 0x2524
// Size: 0x2
function function_a8ad37b2058b4639()
{
    
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x1e6fc4af, Offset: 0x252e
// Size: 0x48
function private function_28ef017417acf8d8()
{
    level endon( #"game_ended" );
    self.active_fish = 1;
    
    if ( self getscriptablepartstate( #"vfx" ) != "enabled_irradiated" )
    {
        self setscriptablepartstate( #"vfx", #"enabled" );
    }
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0xa3310225, Offset: 0x257e
// Size: 0x16
function private function_c89c7a96d390d153()
{
    level waittill( #"on_round_end" );
    thread function_28ef017417acf8d8();
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0x7512537, Offset: 0x259c
// Size: 0x87
function private function_269735aa7872cd67( player )
{
    level endon( #"game_ended" );
    spawn_catch( self.caught_fish, player );
    
    if ( !isdefined( self.var_2034e56efebccc6e ) )
    {
        self.var_2034e56efebccc6e = 0;
    }
    
    self.var_2034e56efebccc6e++;
    thread function_277117ae7b9425e5( self );
    level waittill( #"on_round_end" );
    self.var_2034e56efebccc6e = 0;
    self.var_a9904e96e7c5cdef = 0;
    
    /#
        iprintlnbold( "<dev string:x43>" );
    #/
    
    thread function_28ef017417acf8d8();
}

// Namespace zm_sat_locust_fergus
// Params 2, eflags: 0x4
// Checksum 0x8094429e, Offset: 0x262b
// Size: 0x106
function private spawn_catch( caught_array, player )
{
    for ( i = 0; i < caught_array.size ; i++ )
    {
        spawned_catch = undefined;
        
        switch ( caught_array[ i ] )
        {
            case #"hash_7da50b39ef481517":
                spawned_catch = fishing_hole_spawn_loot( i );
                break;
            case #"hash_f695947f7a9ce23f":
                thread fishing_hole_spawn_zm( i, player );
                break;
            case #"hash_9941fa6e7e21bf9e":
                thread function_b027f11ff8a76d01( i, player );
                break;
            default:
                break;
        }
        
        params = { #player:player, #fishing_hole:self.struct, #caught_obj:spawned_catch };
        level callback::callback( "fergus_general_catch_success", params );
        
        if ( self.var_b3fd65f70afca6aa )
        {
            self.var_b3fd65f70afca6aa = 0;
            break;
        }
    }
    
    self.caught_fish = undefined;
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0xa5267796, Offset: 0x2739
// Size: 0x61a
function private fishing_hole_spawn_loot( i )
{
    profilestart();
    stand_scriptable = self.struct.var_f9cd5cbcdb7bf574.scriptable;
    player = stand_scriptable.stored_player;
    var_6a892f8fbe7f8267 = [ 0, 20, -20 ];
    var_cbff355a2113d566 = isdefined( player.fergus_data );
    var_ad7e9e3909abbdca = var_cbff355a2113d566 ? 6 : 4;
    
    if ( var_cbff355a2113d566 && !self.var_a9904e96e7c5cdef && utility::percent_chance( 15 ) )
    {
        self.var_a9904e96e7c5cdef = 1;
        end_origin = getclosestpointonnavmesh( self.loot_spawn_loc.origin );
        
        if ( level.fishing_struct.var_113cd2679b20848d > 0 && utility::percent_chance( 10 ) )
        {
            powerups::force_powerup_drop( "free_perk", end_origin, "quest" );
            level.fishing_struct.var_113cd2679b20848d--;
        }
        else
        {
            powerups::force_powerup_drop( utility::array_random( [ "full_ammo", "full_power", "full_armor", "double_points", "bonus_points_team", "insta_kill", "nuke" ] ), end_origin, "quest" );
        }
        
        player playsoundtoplayer( "evt_ee_viking_helmet_success", player, player );
    }
    else
    {
        self setscriptablepartstate( #"vfx", #"catch_default" );
        spawn_origin = stand_scriptable.rod_model gettagorigin( "tag_fx_02" );
        offset = anglestoleft( self.loot_spawn_loc.angles ) * var_6a892f8fbe7f8267[ i ];
        end_origin = getclosestpointonnavmesh( self.loot_spawn_loc.origin + offset );
        spawn_options = common_item::function_f5dfaa3bbdf99a33( end_origin, spawn_origin, self.angles );
        var_77c2e455fcde5ca1 = level.fishing_struct.loot_index;
        item_spawned = level callback::response( 0, "fergus_override_catch_item", { #fishing_hole_scriptable:self, #fishing_hole:self.struct, #angles:self.angles, #from_origin:spawn_origin, #var_333e3dd12305988e:end_origin } );
        
        if ( item_spawned )
        {
            self.var_b3fd65f70afca6aa = 1;
        }
        
        if ( level.fishing_struct.force_injection && level.fishing_struct.var_2219fd082a1a34b3 > 0 && utility::percent_chance( 33 ) )
        {
            itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_killstreak_zm_dinj" );
            item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
            item.var_e78811eec0c27aa = 1;
            level.fishing_struct.var_2219fd082a1a34b3--;
        }
        else if ( level.fishing_struct.force_rcxd && level.fishing_struct.rcxd_remaining > 0 && utility::percent_chance( 33 ) )
        {
            itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_killstreak_rcxd" );
            item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
            item.var_e78811eec0c27aa = 1;
            level.fishing_struct.rcxd_remaining--;
        }
        else if ( level.fishing_struct.force_glocke && level.fishing_struct.glocke_remaining > 0 && utility::percent_chance( 33 ) )
        {
            itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_killstreak_zm_bernard_primary" );
            item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
            item.var_e78811eec0c27aa = 1;
            level.fishing_struct.glocke_remaining--;
        }
        else if ( level.fishing_struct.force_wb && level.fishing_struct.wb_remaining > 0 && utility::percent_chance( 33 ) )
        {
            itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_killstreak_zm_bernard_secondary" );
            item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
            item.var_e78811eec0c27aa = 1;
            level.fishing_struct.wb_remaining--;
        }
        else if ( level.fishing_struct.super_loot_count > 0 && utility::percent_chance( var_ad7e9e3909abbdca ) )
        {
            itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_revive_self_revive" );
            item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
            level.fishing_struct.super_loot_count--;
        }
        else if ( var_cbff355a2113d566 && level.fishing_struct.ultra_loot_count > 0 && utility::percent_chance( 2.5 ) )
        {
            itembundle = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_pi_raygun" );
            item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
            level.fishing_struct.ultra_loot_count--;
        }
        else if ( !item_spawned )
        {
            var_b8940482a4a47246 = var_cbff355a2113d566 ? level.fishing_struct.var_83f376a30c506f71 : level.fishing_struct.var_2870643174e16d7d;
            item_spawn_list = var_b8940482a4a47246[ var_77c2e455fcde5ca1 ];
            [ item ] = common_item::function_38cde6a6acb68ea6( item_spawn_list, 1, spawn_options );
            
            if ( item.type == "zmloot_sat_killstreak_rcxd" || item.type == "zmloot_killstreak_zm_dinj" )
            {
                item.var_e78811eec0c27aa = 1;
            }
        }
        
        if ( self.struct.guaranteed_loot )
        {
            self.struct.guaranteed_loot = undefined;
        }
        
        profilestop();
        return item;
    }
    
    profilestop();
}

// Namespace zm_sat_locust_fergus
// Params 2, eflags: 0x4
// Checksum 0xbecc76a5, Offset: 0x2d5b
// Size: 0x12c
function private fishing_hole_spawn_zm( i, player )
{
    self endon( #"game_ended" );
    var_6a892f8fbe7f8267 = [ 0, 20, -20 ];
    self setscriptablepartstate( #"vfx", #"catch_default" );
    var_28b7906f3ff3a2fe = function_2cedc06898c83328( var_6a892f8fbe7f8267[ i ] );
    var_30085f70fc117162 = { #angles:( 0, 0, 0 ), #origin:var_28b7906f3ff3a2fe.origin };
    params = { #allow_cleanup:1, #var_30085f70fc117162:var_30085f70fc117162, #spawner_zombie_type:"zombie_base" };
    zm = zm_sat_locust_util::spawn_quest_zombie( params );
    
    if ( !zm )
    {
        return;
    }
    
    zm.var_15598d8e493afe88 = 1;
    zm.var_a13bed1ac47e1b2c = 1;
    level callback::callback( #"hash_4063b53825f36952", { #player:player, #zombie:zm } );
}

// Namespace zm_sat_locust_fergus
// Params 1
// Checksum 0xdd0a8cc1, Offset: 0x2e8f
// Size: 0x17a
function function_2cedc06898c83328( var_6a892f8fbe7f8267 = 0 )
{
    stand_scriptable = self.struct.var_f9cd5cbcdb7bf574.scriptable;
    spawn_origin = stand_scriptable.rod_model gettagorigin( "tag_fx_02" );
    offset = anglestoleft( self.loot_spawn_loc.angles ) * var_6a892f8fbe7f8267;
    end_origin = getclosestpointonnavmesh( self.loot_spawn_loc.origin + offset );
    payload = calcscriptablepayloadgravityarc( spawn_origin, getgroundposition( end_origin, 16 ) );
    var_29eefe9a3dc4d3b8 = end_origin - spawn_origin;
    boot_angles = vectortoangles( ( var_29eefe9a3dc4d3b8[ 0 ], var_29eefe9a3dc4d3b8[ 1 ], 0 ) );
    boot_scriptable = spawnscriptable( %"sat_zm_boot_fergus", spawn_origin, boot_angles, undefined, payload );
    boot_scriptable setscriptablepartstate( "audio", "reeled_in" );
    wait 2;
    boot_scriptable setscriptablepartstate( "audio", "spawn_zm" );
    boot_scriptable setscriptablepartstate( "vfx", "spawn_zm" );
    boot_scriptable utility::delaycall( 3, &freescriptable );
    earthquake( 0.3, 2, boot_scriptable.origin, 256 );
    wait 2;
    earthquake( 1, 0.5, boot_scriptable.origin, 256 );
    return boot_scriptable;
}

// Namespace zm_sat_locust_fergus
// Params 2, eflags: 0x4
// Checksum 0xd83d0ab1, Offset: 0x3012
// Size: 0xbd
function private function_b027f11ff8a76d01( i, player )
{
    self setscriptablepartstate( #"vfx", #"catch_irradiated" );
    var_6a892f8fbe7f8267 = [ 0, 20, -20 ];
    offset = anglestoleft( self.loot_spawn_loc.origin ) * var_6a892f8fbe7f8267[ i ];
    spawn_origin = getclosestpointonnavmesh( self.loot_spawn_loc.origin + offset );
    level callback::callback( #"hash_2e6a3e8ab42d76c5", { #player:player, #spawn_origin:spawn_origin } );
}

// Namespace zm_sat_locust_fergus
// Params 1, eflags: 0x4
// Checksum 0x9e1235f0, Offset: 0x30d7
// Size: 0x8c
function private function_277117ae7b9425e5( fishing_hole_scriptable )
{
    level endon( #"game_ended" );
    level endon( #"on_round_end" );
    thread function_473cd46392037f1e();
    wait 1;
    level endon( #"hash_3d3e49f7fe1007fd" );
    fishing_hole_scriptable.active_fish = 0;
    
    if ( !isdefined( self.struct.var_f9cd5cbcdb7bf574 ) )
    {
        return;
    }
    
    self.struct.var_f9cd5cbcdb7bf574.scriptable setscriptablepartstate( "usable", "enabled" );
}

// Namespace zm_sat_locust_fergus
// Params 0, eflags: 0x4
// Checksum 0x63e18aff, Offset: 0x316b
// Size: 0x6c
function private function_473cd46392037f1e()
{
    level endon( #"game_ended" );
    level endon( #"hash_3d3e49f7fe1007fd" );
    level waittill( #"on_round_end" );
    
    if ( !isdefined( self.struct.var_f9cd5cbcdb7bf574 ) )
    {
        return;
    }
    
    self.struct.var_f9cd5cbcdb7bf574.scriptable setscriptablepartstate( "usable", "enabled" );
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x36c4585d, Offset: 0x31df
// Size: 0x2
function function_c38092426e9ef6f5()
{
    
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0xf5e822d3, Offset: 0x31e9
// Size: 0x2
function function_3121067142085a2d()
{
    
}

// Namespace zm_sat_locust_fergus
// Params 3, eflags: 0x4
// Checksum 0xc1a98720, Offset: 0x31f3
// Size: 0xb8
function private function_dd472c8d2675f644( spawn_origin, spawn_angles, in_barrel = 0 )
{
    spawnoptions = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    asset = zm_sat_locust_util::get_quest_item_ref( %"zmloot_sat_locust_quest_fergus" );
    params = { #asset:asset, #spawnoptions:spawnoptions };
    var_b11b64f5583f0be3 = zm_sat_locust_util::spawn_quest_item( params );
    
    if ( in_barrel )
    {
        var_b11b64f5583f0be3.in_barrel = 1;
    }
    
    return var_b11b64f5583f0be3;
}

// Namespace zm_sat_locust_fergus
// Params 1
// Checksum 0x73137ed1, Offset: 0x32b4
// Size: 0x4a
function function_c58d10b4f34e8525( rod_state_index )
{
    zm_quest::function_b57dfe9625966b0b( #"hash_4c9cc3cf85d5472c", 0, #"fishing_rod", rod_state_index, undefined, self );
    
    if ( rod_state_index == 1 )
    {
        self.broken_rod = 0;
        return;
    }
    
    self.broken_rod = 1;
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x237bfc99, Offset: 0x3306
// Size: 0x38
function function_c981f5f464e676e5()
{
    if ( self.broken_rod )
    {
        return 0;
    }
    
    var_c1bac0d1fd52d9d1 = zm_quest::function_6b5f09e88a4edfce( #"hash_4c9cc3cf85d5472c", 0, #"fishing_rod", self );
    return var_c1bac0d1fd52d9d1;
}

// Namespace zm_sat_locust_fergus
// Params 0
// Checksum 0x6026818a, Offset: 0x3347
// Size: 0x2
function __debug()
{
    
}

/#

    // Namespace zm_sat_locust_fergus
    // Params 0, eflags: 0x4
    // Checksum 0xf11f2f15, Offset: 0x3351
    // Size: 0x86, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5f>" );
        devgui::add_devgui_func( "<dev string:x6b>", "<dev string:x74>", &function_8f1d8bfc8b242861 );
        devgui::add_devgui_func( "<dev string:x84>", "<dev string:x97>", &function_62a43eab3b05faa );
        devgui::add_devgui_func( "<dev string:xb3>", "<dev string:xc8>", &function_411d76cb1d83ec56 );
        devgui::add_devgui_func( "<dev string:xdd>", "<dev string:xf6>", &function_8c72e25539f3fa32 );
        devgui::add_devgui_func( "<dev string:x10f>", "<dev string:x125>", &function_e1221c503c2e6c18 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_fergus
    // Params 0
    // Checksum 0x487e3599, Offset: 0x33df
    // Size: 0x1b1, Type: dev
    function function_8f1d8bfc8b242861()
    {
        poles = zm_sat_locust_util::get_quest_reference( #"pole_pickups" );
        
        foreach ( var_f9cd5cbcdb7bf574 in poles )
        {
            var_f9cd5cbcdb7bf574 freescriptable();
        }
        
        foreach ( player in level.players )
        {
            player function_c58d10b4f34e8525( 1 );
            zm_quest::show_splash_item_picked_up( #"hash_4c9cc3cf85d5472c", #"fishing_rod", 1, player );
        }
        
        foreach ( barrel in level.fishing_struct.rod_barrels )
        {
            barrel.max_rods = 4;
        }
        
        function_49218c16f4815e4();
    }

    // Namespace zm_sat_locust_fergus
    // Params 0
    // Checksum 0x99930dfe, Offset: 0x3598
    // Size: 0x57, Type: dev
    function function_62a43eab3b05faa()
    {
        if ( !isdefined( level.var_84efa2291c6f053b ) )
        {
            level.var_84efa2291c6f053b = 0;
        }
        
        level.var_84efa2291c6f053b = !level.var_84efa2291c6f053b;
        
        if ( level.var_84efa2291c6f053b )
        {
            /#
                iprintlnbold( "<dev string:x136>" );
            #/
            
            return;
        }
        
        /#
            iprintlnbold( "<dev string:x146>" );
        #/
    }

    // Namespace zm_sat_locust_fergus
    // Params 0, eflags: 0x4
    // Checksum 0x7cfd4e2b, Offset: 0x35f7
    // Size: 0x12a, Type: dev
    function private function_411d76cb1d83ec56()
    {
        var_be4a979112a66db0 = zm_sat_locust_util::get_quest_reference( #"pole_pickups" );
        
        if ( level.fishing_struct.debug_show_rods )
        {
            level.fishing_struct.debug_show_rods = 0;
            level notify( #"hash_75d86cc736e2a5d8" );
            return;
        }
        
        level.fishing_struct.debug_show_rods = 1;
        
        foreach ( var_b11b64f5583f0be3 in var_be4a979112a66db0 )
        {
            debug::line( var_b11b64f5583f0be3, var_b11b64f5583f0be3.origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), undefined, "<dev string:x159>" );
            debug::sphere( var_b11b64f5583f0be3, 30, ( 0, 1, 0 ), undefined, "<dev string:x159>" );
        }
    }

    // Namespace zm_sat_locust_fergus
    // Params 0
    // Checksum 0x5b28f979, Offset: 0x3729
    // Size: 0x256, Type: dev
    function function_8c72e25539f3fa32()
    {
        if ( level.fishing_struct.debug_show_uranium )
        {
            level.fishing_struct.debug_show_uranium = 0;
            level notify( #"hash_fa0eac88231904ff" );
            return;
        }
        
        level.fishing_struct.debug_show_uranium = 1;
        uranium_spot = undefined;
        
        foreach ( var_12d72740175e8cac in level.fishing_struct.fishing_holes )
        {
            if ( var_12d72740175e8cac.scriptable getscriptablepartstate( "<dev string:x170>" ) == "<dev string:x174>" )
            {
                uranium_spot = var_12d72740175e8cac.var_f9cd5cbcdb7bf574;
            }
        }
        
        if ( uranium_spot )
        {
            fishing_hole = uranium_spot.scriptable.fishing_hole.scriptable;
            uranium_spot notify( #"hash_82ccee92526564e3" );
            fishing_hole notify( #"hash_82ccee92526564e3" );
            debug::line( uranium_spot, uranium_spot.origin + ( 0, 0, 1000 ), ( 0, 0, 1 ), undefined, "<dev string:x187>", "<dev string:x187>" );
            debug::sphere( uranium_spot, 30, ( 0, 0, 1 ), undefined, "<dev string:x187>", "<dev string:x187>" );
            debug::line( fishing_hole, fishing_hole.origin + ( 0, 0, 250 ), ( 1, 1, 0 ), undefined, "<dev string:x187>", "<dev string:x187>" );
            debug::sphere( fishing_hole, 30, ( 1, 1, 0 ), undefined, "<dev string:x187>", "<dev string:x187>" );
            debug::line( uranium_spot, fishing_hole, ( 1, 1, 1 ), undefined, "<dev string:x187>", "<dev string:x187>" );
            return;
        }
        
        level.fishing_struct.debug_show_uranium = 0;
        level notify( #"hash_fa0eac88231904ff" );
        iprintlnbold( "<dev string:x1a1>" );
    }

    // Namespace zm_sat_locust_fergus
    // Params 0, eflags: 0x4
    // Checksum 0x14873df3, Offset: 0x3987
    // Size: 0x1fa, Type: dev
    function private function_e1221c503c2e6c18()
    {
        spots = level.fishing_struct.pole_stands;
        
        if ( level.fishing_struct.debug_show_spots )
        {
            level.fishing_struct.debug_show_spots = 0;
            level notify( #"hash_82ccee92526564e3" );
            return;
        }
        
        level.fishing_struct.debug_show_spots = 1;
        
        foreach ( spot in spots )
        {
            fishing_hole = spot.scriptable.fishing_hole.scriptable;
            spot notify( #"hash_fa0eac88231904ff" );
            fishing_hole notify( #"hash_fa0eac88231904ff" );
            debug::line( spot, spot.origin + ( 0, 0, 1000 ), ( 0, 1, 0 ), undefined, "<dev string:x1cb>", "<dev string:x1cb>" );
            debug::sphere( spot, 30, ( 0, 1, 0 ), undefined, "<dev string:x1cb>", "<dev string:x1cb>" );
            debug::line( fishing_hole, fishing_hole.origin + ( 0, 0, 250 ), ( 1, 0, 0 ), undefined, "<dev string:x1cb>", "<dev string:x1cb>" );
            debug::sphere( fishing_hole, 30, ( 1, 0, 0 ), undefined, "<dev string:x1cb>", "<dev string:x1cb>" );
            debug::line( spot, fishing_hole, ( 1, 1, 1 ), undefined, "<dev string:x1cb>", "<dev string:x1cb>" );
        }
    }

#/
