// script_6b77a4fdf28b9f8d  (hash_6b77a4fdf28b9f8d.gscc) (size: 19164 Bytes / 0x4adc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda218abe (3659631294)
// size ...... 19164 (0x4adc)
// includes .. 19  (offset: 0x4420)
// strings ... 67  (offset: 0x44b8)
// dev strs .. 42  (offset: 0x489c)
// exports ... 42  (offset: 0x2c18)
// cseg ...... 0x60f + 0x2609 (0x2c18)
// imports ... 139 (offset: 0x32a8)
// animtree1 . 0   (offset: 0x4adc)
// animtree2 . 0   (offset: 0x4adc)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\shellshock_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace namespace_21e3a82d7e11699c;

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x5
// Checksum 0xe1b9c0e9, Offset: 0x62d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"rcxd_race", #"br_map_quest", &init, undefined );
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0x348dfa6f, Offset: 0x656
// Size: 0x6c
function init()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"rcxd_race" };
    br_map_quest::register( quest );
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0xdf384b51, Offset: 0x6ca
// Size: 0x1a
function on_init()
{
    set_dvars();
    function_cb1918f58e2ef6fa();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0xbc84526b, Offset: 0x6ec
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0x6df22bea, Offset: 0x6f6
// Size: 0x2
function on_start()
{
    
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0x81b9f7db, Offset: 0x700
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0x2dae26fd, Offset: 0x70a
// Size: 0x9
function on_infil()
{
    thread setup_race_interacts();
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0x9a47c7ed, Offset: 0x71b
// Size: 0x81
function set_dvars()
{
    br_map_quest::add_setting( "rcxd_race_checkpoint_timer_duration", 5 );
    br_map_quest::add_setting( "rcxd_race_reset_duration", 15000 );
    br_map_quest::add_setting( "rcxd_race_grotto_enabled", 1 );
    br_map_quest::add_setting( "rcxd_race_town_enabled", 1 );
    br_map_quest::add_setting( "rcxd_race_town_2_enabled", 1 );
    br_map_quest::add_setting( "rcxd_race_keep_enabled", 1 );
    br_map_quest::add_setting( "rcxd_race_beach_enabled", 1 );
    br_map_quest::add_setting( "race_killstreak_reward_amount", 3 );
    br_map_quest::add_setting( "race_plunder_reward_amount", 2 );
}

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x4
// Checksum 0x8d737cc5, Offset: 0x7a4
// Size: 0xa7
function private function_cb1918f58e2ef6fa()
{
    self.var_ed8b343d828a592c = [];
    function_55c9a59448001882();
    
    foreach ( name in getarraykeys( self.var_ed8b343d828a592c ) )
    {
        var_5942dcc87059a5b4 = setup_race_properties( name );
        self.var_ed8b343d828a592c[ name ] = var_5942dcc87059a5b4;
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x4
// Checksum 0xfcb58189, Offset: 0x853
// Size: 0x349
function private function_55c9a59448001882()
{
    var_66bed5d6eb6b39d1 = utility::getstructarray( "quest_rcxd_race_checkpoint", "targetname" );
    assert( isdefined( var_66bed5d6eb6b39d1 ), "<dev string:x24>" + "<dev string:x49>" );
    
    foreach ( checkpoint in var_66bed5d6eb6b39d1 )
    {
        var_4f3c23c0101084bb = checkpoint.script_label;
        
        if ( !isdefined( br_map_quest::get_setting( "rcxd_race_" + tolower( var_4f3c23c0101084bb ) + "_enabled" ) ) )
        {
            continue;
        }
        
        if ( !isdefined( self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ] ) )
        {
            self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ] = { #checkpoints:[] };
        }
        
        self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].checkpoints[ self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].checkpoints.size ] = checkpoint;
    }
    
    prop_locs = utility::getstructarray( "quest_rcxd_race_prop", "targetname" );
    
    foreach ( var_11cdcfd134cee516 in prop_locs )
    {
        var_4f3c23c0101084bb = var_11cdcfd134cee516.script_label;
        
        if ( isdefined( self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ] ) )
        {
            self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].var_11cdcfd134cee516 = var_11cdcfd134cee516;
        }
    }
    
    start_locs = utility::getstructarray( "quest_rcxd_race_start", "targetname" );
    
    foreach ( var_93c3e7bb3f019adf in start_locs )
    {
        var_4f3c23c0101084bb = var_93c3e7bb3f019adf.script_label;
        
        if ( isdefined( self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ] ) )
        {
            self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].var_93c3e7bb3f019adf = var_93c3e7bb3f019adf;
        }
    }
    
    reward_cache_locs = utility::getstructarray( "quest_rcxd_race_reward_cache", "targetname" );
    
    foreach ( reward_cache_loc in reward_cache_locs )
    {
        var_4f3c23c0101084bb = reward_cache_loc.script_label;
        
        if ( isdefined( self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ] ) )
        {
            self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].reward_cache_loc = reward_cache_loc;
        }
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xdde1745b, Offset: 0xba4
// Size: 0x15a
function private setup_race_properties( var_4f3c23c0101084bb )
{
    var_dc6deb912927ce57 = spawnstruct();
    var_dc6deb912927ce57.quest = self;
    var_dc6deb912927ce57.name = var_4f3c23c0101084bb;
    var_dc6deb912927ce57.var_66bed5d6eb6b39d1 = sort_checkpoints( self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].checkpoints );
    var_dc6deb912927ce57.var_11cdcfd134cee516 = self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].var_11cdcfd134cee516;
    var_dc6deb912927ce57.var_93c3e7bb3f019adf = self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].var_93c3e7bb3f019adf;
    var_dc6deb912927ce57.reward_cache_loc = self.var_ed8b343d828a592c[ var_4f3c23c0101084bb ].reward_cache_loc;
    var_dc6deb912927ce57.current_checkpoint_index = 0;
    var_dc6deb912927ce57.start_index = 0;
    var_dc6deb912927ce57.var_15e857564681f39a = var_dc6deb912927ce57.var_66bed5d6eb6b39d1.size - 1;
    var_dc6deb912927ce57.var_ed2431ff5fd3b5d8 = var_dc6deb912927ce57.var_66bed5d6eb6b39d1[ var_dc6deb912927ce57.var_15e857564681f39a ].origin;
    var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 = br_map_quest::get_setting( "rcxd_race_checkpoint_timer_duration" );
    var_dc6deb912927ce57.var_3d91b0b7f187f8c4 = 0;
    var_dc6deb912927ce57.var_5cf05e5aa3cd097a = 0;
    return var_dc6deb912927ce57;
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0x21988a08, Offset: 0xd07
// Size: 0xa1
function private sort_checkpoints( var_8bd03e449c2dfbfa )
{
    sorted_checkpoint_structs = [];
    
    foreach ( checkpoint in var_8bd03e449c2dfbfa )
    {
        var_36ffee45bee14163 = int( checkpoint.script_noteworthy );
        sorted_checkpoint_structs[ var_36ffee45bee14163 ] = checkpoint;
    }
    
    return sorted_checkpoint_structs;
}

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x4
// Checksum 0x7b3d1368, Offset: 0xdb1
// Size: 0x87
function private setup_race_interacts()
{
    level endon( #"game_ended" );
    
    foreach ( var_dc6deb912927ce57 in self.var_ed8b343d828a592c )
    {
        spawn_reward_cache( var_dc6deb912927ce57 );
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xbd62d182, Offset: 0xe40
// Size: 0x24e
function private spawn_checkpoints( var_dc6deb912927ce57 )
{
    var_dc6deb912927ce57.checkpoint_scriptables = [];
    
    for ( i = 0; i < var_dc6deb912927ce57.var_66bed5d6eb6b39d1.size ; i++ )
    {
        var_885733cc8b8ef798 = var_dc6deb912927ce57.var_66bed5d6eb6b39d1[ i ];
        payload = [ #"teamselect", var_dc6deb912927ce57.player getentitynumber() ];
        var_7a0e5620fa3969c7 = "quest_saw_rcxd_race_checkpoint";
        trigger_size = 40;
        air = 0;
        angle_offset = ( 0, 0, 0 );
        origin_offset = ( 0, 0, 30 );
        trigger_type = "noent_volume_trigger_radius";
        
        if ( i == var_dc6deb912927ce57.var_15e857564681f39a )
        {
            var_7a0e5620fa3969c7 = "quest_saw_rcxd_race_finish";
        }
        else if ( isdefined( var_885733cc8b8ef798.air ) && int( var_885733cc8b8ef798.air ) == 1 )
        {
            var_7a0e5620fa3969c7 = "quest_jup_parkour_race_checkpoint_air";
            trigger_size = 90;
            air = 1;
            angle_offset = var_885733cc8b8ef798.angles + ( 90, 0, 0 );
            origin_offset = ( 0, 0, 10 );
            trigger_type = "noent_volume_trigger_rotatable_radius";
        }
        
        var_3b23fcd65c89e15b = spawnscriptable( var_7a0e5620fa3969c7, var_885733cc8b8ef798.origin, var_885733cc8b8ef798.angles, undefined, payload );
        var_3b23fcd65c89e15b.air = air;
        trigger = spawn( trigger_type, var_3b23fcd65c89e15b.origin + origin_offset, 0, trigger_size, trigger_size );
        trigger.angles += angle_offset;
        var_3b23fcd65c89e15b.trigger = trigger;
        var_3b23fcd65c89e15b.var_dc6deb912927ce57 = var_dc6deb912927ce57;
        var_3b23fcd65c89e15b setscriptablepartstate( "quest_saw_rcxd_partname", "hidden" );
        var_dc6deb912927ce57.checkpoint_scriptables[ var_dc6deb912927ce57.checkpoint_scriptables.size ] = var_3b23fcd65c89e15b;
        
        if ( i == 0 )
        {
            var_3b23fcd65c89e15b setscriptablepartstate( "quest_saw_rcxd_partname", "visible" );
            thread function_29df7ea207f544de( var_3b23fcd65c89e15b );
            var_dc6deb912927ce57.current_checkpoint = var_3b23fcd65c89e15b;
        }
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0x90623bbc, Offset: 0x1096
// Size: 0x18b
function private spawn_reward_cache( var_dc6deb912927ce57 )
{
    cache = common_cache::spawncache( %"hash_643f22d0e61243d6", var_dc6deb912927ce57.reward_cache_loc.origin + ( 0, 0, 3 ), var_dc6deb912927ce57.reward_cache_loc.angles );
    common_cache::function_a136b84fc5c0dfab( cache, %"hash_68053588187eb265", br_map_quest::get_setting( "race_killstreak_reward_amount" ), 1 );
    common_cache::function_a136b84fc5c0dfab( cache, %"hash_4d6eda1b48d1bb86", br_map_quest::get_setting( "race_plunder_reward_amount" ), 1 );
    common_cache::function_81144e13eed673e( cache );
    common_cache::function_9d6321275c249932( cache );
    cache setscriptablepartstate( "body", "lege_closed_unusable" );
    cache.panic_type = "survival";
    var_dc6deb912927ce57.cache = cache;
    var_dc6deb912927ce57.prop = spawnscriptable( "quest_saw_rcxd_prop", var_dc6deb912927ce57.var_11cdcfd134cee516.origin, var_dc6deb912927ce57.var_11cdcfd134cee516.angles );
    var_dc6deb912927ce57.prop = interaction::register_scriptable_interact( var_dc6deb912927ce57.prop, &function_f673a1e82d8bcbe0, undefined, undefined, &function_b9a6c49e073144dd );
    var_dc6deb912927ce57.prop setscriptablepartstate( "usable", "enabled" );
    var_dc6deb912927ce57.prop.var_dc6deb912927ce57 = var_dc6deb912927ce57;
    var_dc6deb912927ce57.prop thread function_3fd0e42b9f5c0d55();
}

// Namespace namespace_21e3a82d7e11699c
// Params 0
// Checksum 0x8fb0beb0, Offset: 0x1229
// Size: 0x5e
function function_3fd0e42b9f5c0d55()
{
    level endon( #"game_ended" );
    hit_time = br_circle_util::gettimetilldangerforpoint( self.origin );
    
    if ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", hit_time ) == "timeout" )
    {
        wait 1;
        self setscriptablepartstate( "usable", "off" );
        return;
    }
    
    thread function_3fd0e42b9f5c0d55();
    return;
}

// Namespace namespace_21e3a82d7e11699c
// Params 2, eflags: 0x4
// Checksum 0xfbebb18c, Offset: 0x128f
// Size: 0xbd
function private function_b9a6c49e073144dd( scriptable, player )
{
    if ( gettime() < scriptable.var_dc6deb912927ce57.cooldown_time )
    {
        return { #params:[ int( ( scriptable.var_dc6deb912927ce57.cooldown_time - gettime() + 1000 ) / 1000 ) ], #var_26bbd300351fde34:0, #string:&"hash_100de86a588be363", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_75d33a84770aa4d0", #type:"HINT_BUTTON" };
}

// Namespace namespace_21e3a82d7e11699c
// Params 2
// Checksum 0xe056ac9c, Offset: 0x1355
// Size: 0x14d
function activate_rcxd( player, var_dc6deb912927ce57 )
{
    streakitem = killstreaks::createstreakitemstruct( "rcxd" );
    streakitem.available = 1;
    streakitem.quantity = 1;
    streakinfo = killstreak_utility::createstreakinfo( "rcxd", player );
    streakinfo.mpstreaksysteminfo = streakitem;
    rcxd = rcxd_shared::creatercxd( "rcxd", player, streakinfo, var_dc6deb912927ce57.var_93c3e7bb3f019adf.origin );
    rcxd.maxhealth = 100;
    rcxd.health = 100;
    rcxd.currenthealth = 100;
    rcxd.lifetime = 999;
    
    if ( !isdefined( rcxd ) )
    {
        return;
    }
    
    rcxd vehicle_teleport( rcxd.origin, var_dc6deb912927ce57.var_93c3e7bb3f019adf.angles );
    player function_aff5382dadd1a572( rcxd );
    player.rcxd_racing_veh = rcxd;
    player setclientomnvar( "ui_killstreak_lifetime", 1 );
    player setclientomnvar( "ui_is_rcxd_race", 1 );
    rcxd thread rcxd_shared::function_899aef7aa02b06ec();
    var_dc6deb912927ce57.rcxd = rcxd;
}

// Namespace namespace_21e3a82d7e11699c
// Params 1
// Checksum 0xb0319dc, Offset: 0x14aa
// Size: 0x1d1
function function_aff5382dadd1a572( rcxd )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote();
    }
    
    player::setusingremote( rcxd.streakinfo.streakname );
    rcxd vehicle_damage::set_can_damage( 0 );
    data = spawnstruct();
    data.deathoverridecallback = &rcxd_shared::function_86ce53096e8db304;
    rcxd thread namespace_9d8e359c3b1041e5::handlemovingplatformssharedfunc( data );
    rcxd setotherent( self );
    rcxd.driver = self;
    rcxd.ispiloted = 1;
    
    if ( rcxd.empcount > 0 )
    {
        namespace_9d8e359c3b1041e5::freezelookcontrolssharedfunc( 1 );
    }
    else
    {
        self usevehicle( rcxd, 0 );
    }
    
    rcxd.controlslinked = 1;
    self painvisionoff();
    killstreak_shared::killstreak_savenvgstate();
    rcxd.starttime = gettime();
    rcxd.endtime = rcxd.starttime + int( rcxd.lifetime * 1000 );
    self setclientomnvar( "ui_killstreak_countdown", rcxd.endtime );
    self setclientomnvar( "ui_killstreak_health", 1 );
    self setclientomnvar( "ui_killstreak_damage_state", 0 );
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( rcxd.streakinfo.streakname, "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "rcxd" );
    shellshock_utility::_stopshellshock();
    val::set( "rcxd", "shellshock", 0 );
    namespace_9d8e359c3b1041e5::registerentforoobsharedfunc( rcxd, "killstreak" );
    val::set( "rcxd_spawn", "player_for_spawn_logic", 0 );
    namespace_9d8e359c3b1041e5::addspawnviewersharedfunc( rcxd );
    function_3d87a59a4ab8b451();
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1
// Checksum 0x3219df50, Offset: 0x1683
// Size: 0x15a
function function_97ec301a6784838a( rcxd )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( rcxd ) )
    {
        return;
    }
    
    rcxd function_8f57751bc1b28779( 0 );
    rcxd function_ccacc3fd2c146e8( 0 );
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    rcxd setscriptablepartstate( #"destroy", #"on", 0 );
    rcxd setscriptablepartstate( #"lights", #"off", 0 );
    rcxd thread rcxd_shared::function_5e658cd4c1d7e145();
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote();
    }
    
    self playlocalsound( "evt_rcxd_fade_out" );
    var_947bb4706c5ccfaa = hud_util::function_cd054751d2d5b5c5( "black" );
    
    if ( isalive( self ) )
    {
        var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( self, 0.5, 1, 1, 1 );
        wait 0.5;
    }
    else
    {
        var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( self, 0, 3, 1, 1 );
    }
    
    rcxd_shared::function_97ec301a6784838a( rcxd );
    self.rcxd_racing_veh = undefined;
    self setplayerangles( self.restoreangles );
    self setclientomnvar( "ui_is_rcxd_race", 0 );
    
    if ( isdefined( rcxd ) )
    {
        rcxd delete();
    }
    
    wait 2;
    namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    val::reset( "rcxd_race", "killstreaks" );
    val::reset( "rcxd_race", "vehicle_use" );
}

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x4
// Checksum 0xc87ccefb, Offset: 0x17e5
// Size: 0x85
function private function_3d87a59a4ab8b451()
{
    bundle = level.streakglobals.streakbundles[ "rcxd" ];
    fullscreenfxparams = { #visionset:bundle.var_28b586ad7dc362cb ?? "killstreak_rcxd_drive", #postfxbundlename:bundle.var_1f1feedfdba0656d };
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
}

// Namespace namespace_21e3a82d7e11699c
// Params 2, eflags: 0x4
// Checksum 0x767fba4e, Offset: 0x1872
// Size: 0x321
function private rcxd_race_start( var_dc6deb912927ce57, player )
{
    var_dc6deb912927ce57 notify( #"sidequest_race_start" );
    var_dc6deb912927ce57 endon( #"sidequest_race_start" );
    var_dc6deb912927ce57 endon( #"sidequest_race_end" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    var_dc6deb912927ce57.player = player;
    player namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 1 );
    player val::set( "rcxd_race", "killstreaks", 0 );
    player val::set( "rcxd_race", "vehicle_use", 0 );
    
    if ( !level callback::exists( #"player_damaged", &on_player_interrupted ) )
    {
        level callback::add( #"player_damaged", &on_player_interrupted );
    }
    
    if ( !level callback::exists( #"player_death", &on_player_interrupted ) )
    {
        level callback::add( #"player_death", &on_player_interrupted );
    }
    
    if ( !level callback::exists( #"player_disconnect", &on_player_interrupted ) )
    {
        level callback::add( #"player_disconnect", &on_player_interrupted );
    }
    
    var_dc6deb912927ce57.prop setscriptablepartstate( "usable", "off" );
    player playlocalsound( "evt_rcxd_fade_in" );
    var_947bb4706c5ccfaa = player hud_util::function_cd054751d2d5b5c5( "black" );
    var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( player, 1, 2, 2, 1 );
    wait 1;
    player.restoreangles = player getplayerangles();
    player setplayerangles( var_dc6deb912927ce57.var_93c3e7bb3f019adf.angles );
    player namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    activate_rcxd( player, var_dc6deb912927ce57 );
    spawn_checkpoints( var_dc6deb912927ce57 );
    wait 4;
    player thread play_countdown();
    wait 3;
    player namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
    player playlocalsound( "evt_parkour_race_start" );
    function_6ae004ca2f6fdaca( var_dc6deb912927ce57, var_dc6deb912927ce57.player );
    
    while ( var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 >= 0 && !var_dc6deb912927ce57.var_5cf05e5aa3cd097a )
    {
        starttime = gettime();
        var_dc6deb912927ce57.player setclientomnvar( "ui_race_timer", ( var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 + 1 ) * 1000 + starttime );
        
        if ( var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 < 3 && var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 > -1 )
        {
            player playlocalsound( "evt_parkour_race_time_ticking_0" + 1 + var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 );
        }
        
        wait 1;
        var_dc6deb912927ce57.var_da3cc9c14ad3c1d5--;
        
        if ( isdefined( var_dc6deb912927ce57.current_checkpoint ) )
        {
            /#
                print3d( var_dc6deb912927ce57.current_checkpoint.origin, var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 + 1, ( 1, 0, 0 ), 1, 2, 21 );
            #/
        }
    }
    
    if ( !var_dc6deb912927ce57.var_5cf05e5aa3cd097a )
    {
        thread function_9f7e0ab2aa7757e7( var_dc6deb912927ce57 );
    }
    
    var_dc6deb912927ce57 notify( #"sidequest_race_end" );
}

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x4
// Checksum 0xd7bb4c76, Offset: 0x1b9b
// Size: 0xf6
function private play_countdown()
{
    self endon( #"death_or_disconnect" );
    starttime = gettime();
    self setclientomnvar( "ui_race_timer", 3000 + starttime );
    
    /#
        printtoscreen2d( 1300, 500, "<dev string:x9e>", ( 1, 0, 0 ), 4, 20 );
    #/
    
    self playlocalsound( "evt_parkour_race_time_ticking_01" );
    wait 1;
    
    /#
        printtoscreen2d( 1300, 500, "<dev string:xa0>", ( 1, 0, 0 ), 4, 20 );
    #/
    
    self playlocalsound( "evt_parkour_race_time_ticking_01" );
    wait 1;
    
    /#
        printtoscreen2d( 1300, 500, "<dev string:xa2>", ( 1, 0, 0 ), 4, 20 );
    #/
    
    self playlocalsound( "evt_parkour_race_time_ticking_01" );
    wait 1;
    
    /#
        printtoscreen2d( 1300, 500, "<dev string:xa4>", ( 0, 1, 0 ), 4, 20 );
    #/
    
    self setclientomnvar( "ui_race_active", 1 );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xdb4a2d1e, Offset: 0x1c99
// Size: 0x12d
function private function_9f7e0ab2aa7757e7( var_dc6deb912927ce57 )
{
    if ( !var_dc6deb912927ce57.var_5cf05e5aa3cd097a )
    {
        function_c575a39101231bbf( var_dc6deb912927ce57 );
        var_dc6deb912927ce57.player playlocalsound( "evt_parkour_race_failure" );
        var_dc6deb912927ce57.player thread function_97ec301a6784838a( var_dc6deb912927ce57.rcxd );
        var_dc6deb912927ce57.prop setscriptablepartstate( "usable", "enabled" );
        var_dc6deb912927ce57.cooldown_time = gettime() + br_map_quest::get_setting( "rcxd_race_reset_duration" );
        var_dc6deb912927ce57.player setclientomnvar( "ui_race_active", 0 );
        var_dc6deb912927ce57.player = undefined;
    }
    
    var_dc6deb912927ce57.current_checkpoint_index = 0;
    var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 = br_map_quest::get_setting( "rcxd_race_checkpoint_timer_duration" );
    var_dc6deb912927ce57.var_5cf05e5aa3cd097a = 0;
    level callback::remove( #"player_damaged", &on_player_interrupted );
    level callback::remove( #"player_death", &on_player_interrupted );
    level callback::remove( #"player_disconnect", &on_player_interrupted );
    var_dc6deb912927ce57 notify( #"sidequest_race_end" );
}

// Namespace namespace_21e3a82d7e11699c
// Params 0, eflags: 0x4
// Checksum 0xe5e39e41, Offset: 0x1dce
// Size: 0x7b
function private race_reset_all()
{
    foreach ( var_dc6deb912927ce57 in self.var_ed8b343d828a592c )
    {
        thread function_9f7e0ab2aa7757e7( var_dc6deb912927ce57 );
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xcb613476, Offset: 0x1e51
// Size: 0xf5
function private function_a6db90a6446f4481( var_dc6deb912927ce57 )
{
    level endon( #"game_ended" );
    var_dc6deb912927ce57.player playlocalsound( "evt_parkour_race_success" );
    function_c575a39101231bbf( var_dc6deb912927ce57 );
    var_dc6deb912927ce57.var_3d91b0b7f187f8c4 = 1;
    var_dc6deb912927ce57.var_5cf05e5aa3cd097a = 1;
    thread quest_complete( var_dc6deb912927ce57.player );
    wait 1;
    var_dc6deb912927ce57.prop setscriptablepartstate( "usable", "off" );
    var_dc6deb912927ce57.prop setscriptablepartstate( "body", "hidden" );
    var_dc6deb912927ce57.cache setscriptablepartstate( "body", "lege_closed_usable" );
    var_dc6deb912927ce57.player function_97ec301a6784838a( var_dc6deb912927ce57.rcxd );
    var_dc6deb912927ce57.player setclientomnvar( "ui_race_active", 0 );
    var_dc6deb912927ce57 notify( #"sidequest_race_end" );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0x1e76bacf, Offset: 0x1f4e
// Size: 0x3d
function private quest_complete( player )
{
    params = { #completed_by:[ player ], #is_successful:1 };
    br_map_quest::on_completed( params );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0x1bdf5b17, Offset: 0x1f93
// Size: 0x2f
function private function_56163fe660b30326( var_dc6deb912927ce57 )
{
    level.player setorigin( var_dc6deb912927ce57.prop.origin );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xf256c9b7, Offset: 0x1fca
// Size: 0x55
function private function_d9b94d2d5a158a3a( var_dc6deb912927ce57 )
{
    if ( isdefined( var_dc6deb912927ce57.rcxd ) )
    {
        var_dc6deb912927ce57.rcxd vehicle_teleport( var_dc6deb912927ce57.var_93c3e7bb3f019adf.origin, var_dc6deb912927ce57.var_93c3e7bb3f019adf.angles );
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xdc60cad7, Offset: 0x2027
// Size: 0x15d
function private function_973698f252cdde6( var_dc6deb912927ce57 )
{
    var_dc6deb912927ce57 endon( #"sidequest_race_end" );
    level endon( #"game_ended" );
    current_checkpoint = var_dc6deb912927ce57.current_checkpoint;
    current_checkpoint setscriptablepartstate( "quest_saw_rcxd_partname", "hidden" );
    
    if ( var_dc6deb912927ce57.current_checkpoint_index == var_dc6deb912927ce57.var_15e857564681f39a )
    {
        function_e0983d3432d72e5c( var_dc6deb912927ce57 );
        return;
    }
    
    current_checkpoint notify( #"checkpoint_removed" );
    
    if ( var_dc6deb912927ce57.current_checkpoint_index == var_dc6deb912927ce57.var_15e857564681f39a - 1 )
    {
        objidpoolmanager::returnobjectiveid( var_dc6deb912927ce57.var_14840643e6710b6f );
        var_dc6deb912927ce57.var_14840643e6710b6f = undefined;
        function_6ae004ca2f6fdaca( var_dc6deb912927ce57, var_dc6deb912927ce57.player );
    }
    
    var_dc6deb912927ce57.current_checkpoint_index++;
    var_df2945f87bc0fb0e = var_dc6deb912927ce57.checkpoint_scriptables[ var_dc6deb912927ce57.current_checkpoint_index ];
    var_df2945f87bc0fb0e setscriptablepartstate( "quest_saw_rcxd_partname", "visible" );
    var_dc6deb912927ce57.current_checkpoint = var_df2945f87bc0fb0e;
    var_dc6deb912927ce57.objectivemarker moveto( var_df2945f87bc0fb0e.origin, 1, 0, 0.75 );
    thread function_29df7ea207f544de( var_df2945f87bc0fb0e );
    var_dc6deb912927ce57.var_da3cc9c14ad3c1d5 = br_map_quest::get_setting( "rcxd_race_checkpoint_timer_duration" );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xf8cd041f, Offset: 0x218c
// Size: 0xb0
function private function_29df7ea207f544de( checkpoint )
{
    var_dc6deb912927ce57 = checkpoint.var_dc6deb912927ce57;
    player = var_dc6deb912927ce57.player;
    rcxd = var_dc6deb912927ce57.rcxd;
    level endon( #"game_ended" );
    var_dc6deb912927ce57 endon( #"sidequest_race_end" );
    checkpoint endon( #"checkpoint_removed" );
    
    while ( true )
    {
        checkpoint.trigger waittill( #"trigger", ent );
        
        if ( ent == rcxd )
        {
            break;
        }
        
        waitframe();
    }
    
    thread on_checkpoint_reached( checkpoint );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0x18d6b5e8, Offset: 0x2244
// Size: 0x11b
function private function_c575a39101231bbf( var_dc6deb912927ce57 )
{
    if ( isdefined( var_dc6deb912927ce57.var_14840643e6710b6f ) )
    {
        objidpoolmanager::returnobjectiveid( var_dc6deb912927ce57.var_14840643e6710b6f );
        var_dc6deb912927ce57.var_14840643e6710b6f = undefined;
    }
    
    if ( isdefined( var_dc6deb912927ce57.var_de292bb09c740b8e ) )
    {
        objidpoolmanager::returnobjectiveid( var_dc6deb912927ce57.var_de292bb09c740b8e );
        var_dc6deb912927ce57.var_de292bb09c740b8e = undefined;
    }
    
    foreach ( checkpoint in var_dc6deb912927ce57.checkpoint_scriptables )
    {
        if ( isdefined( checkpoint.trigger ) )
        {
            checkpoint.trigger delete();
        }
        
        checkpoint freescriptable();
    }
    
    if ( isdefined( var_dc6deb912927ce57.objectivemarker ) )
    {
        var_dc6deb912927ce57.objectivemarker delete();
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 2, eflags: 0x4
// Checksum 0x596caf66, Offset: 0x2367
// Size: 0x140
function private function_6ae004ca2f6fdaca( var_dc6deb912927ce57, player )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( var_dc6deb912927ce57.current_checkpoint_index == var_dc6deb912927ce57.var_15e857564681f39a - 1 )
    {
        icon = "saw_hud_icon_checkered_flag";
        var_dc6deb912927ce57.var_de292bb09c740b8e = objid;
    }
    else
    {
        icon = "hud_icon_ctf_flag";
        var_dc6deb912927ce57.var_14840643e6710b6f = objid;
    }
    
    var_1c669d7332ae2d99 = "icon_small";
    icon_z_offset = 70;
    var_dc6deb912927ce57.objectivemarker = spawn( "script_model", var_dc6deb912927ce57.current_checkpoint.origin );
    objidpoolmanager::objective_add_objective( objid, "current", var_dc6deb912927ce57.current_checkpoint.origin, icon, var_1c669d7332ae2d99 );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::update_objective_setzoffset( objid, icon_z_offset );
    objidpoolmanager::update_objective_setbackground( objid, 1 );
    objidpoolmanager::objective_showdistance( objid, 1 );
    objective_onentity( objid, var_dc6deb912927ce57.objectivemarker );
    function_2b8e3d3ae2a6414a( objid, 1 );
    objective_disableping( objid, 1 );
    objidpoolmanager::objective_playermask_addshowplayer( objid, player );
    return objid;
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xa60b0068, Offset: 0x24b0
// Size: 0x53
function private function_f673a1e82d8bcbe0( player )
{
    if ( gettime() < self.var_dc6deb912927ce57.cooldown_time )
    {
        return;
    }
    
    quest = br_map_quest::get_quest( "rcxd_race" );
    quest thread rcxd_race_start( self.var_dc6deb912927ce57, player );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xcbf89e7c, Offset: 0x250b
// Size: 0x103
function private on_player_interrupted( params )
{
    quest = br_map_quest::get_quest( "rcxd_race" );
    
    foreach ( var_dc6deb912927ce57 in quest.var_ed8b343d828a592c )
    {
        if ( params.victim == var_dc6deb912927ce57.player )
        {
            var_dc6deb912927ce57.player namespace_9d8e359c3b1041e5::freezecontrolssharedfunc( 0 );
            var_dc6deb912927ce57.player val::reset( "rcxd_race", "killstreaks" );
            var_dc6deb912927ce57.player val::reset( "rcxd_race", "vehicle_use" );
            quest thread function_9f7e0ab2aa7757e7( var_dc6deb912927ce57 );
            return;
        }
    }
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0x159aba47, Offset: 0x2616
// Size: 0x4d
function private on_checkpoint_reached( checkpoint )
{
    var_dc6deb912927ce57 = checkpoint.var_dc6deb912927ce57;
    player = var_dc6deb912927ce57.player;
    player playlocalsound( "evt_parkour_race_checkpoint" );
    thread function_973698f252cdde6( var_dc6deb912927ce57 );
}

// Namespace namespace_21e3a82d7e11699c
// Params 1, eflags: 0x4
// Checksum 0xf10dca43, Offset: 0x266b
// Size: 0x15
function private function_e0983d3432d72e5c( var_dc6deb912927ce57 )
{
    thread function_a6db90a6446f4481( var_dc6deb912927ce57 );
}

/#

    // Namespace namespace_21e3a82d7e11699c
    // Params 0, eflags: 0x4
    // Checksum 0xca11382e, Offset: 0x2688
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_21e3a82d7e11699c
    // Params 0, eflags: 0x4
    // Checksum 0xd52c1a23, Offset: 0x269c
    // Size: 0x13c, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xa7>" + "<dev string:xb6>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc1>", "<dev string:xd6>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe8>", "<dev string:xf8>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10a>", "<dev string:x118>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12a>", "<dev string:x143>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x155>", "<dev string:x16c>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17e>", "<dev string:x197>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a9>", "<dev string:x1c1>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1d3>", "<dev string:x1ea>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1fc>", "<dev string:x20c>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x21e>", "<dev string:x22c>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x23e>", "<dev string:x24e>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x261>", "<dev string:x270>", &devgui_rcxd_race );
        devgui::function_cd4e263c1f3018ae( "<dev string:x283>", "<dev string:x291>", &devgui_rcxd_race );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_21e3a82d7e11699c
    // Params 1, eflags: 0x4
    // Checksum 0x901dad59, Offset: 0x27e0
    // Size: 0x19, Type: dev
    function private devgui_rcxd_race( params )
    {
        level thread debug_rcxd_race( params );
    }

    // Namespace namespace_21e3a82d7e11699c
    // Params 1
    // Checksum 0xed551d4a, Offset: 0x2801
    // Size: 0x417, Type: dev
    function debug_rcxd_race( params )
    {
        quest = br_map_quest::get_quest( "<dev string:x2a4>" );
        
        switch ( int( params[ 0 ] ) )
        {
            case 0:
                foreach ( var_dc6deb912927ce57 in quest.var_ed8b343d828a592c )
                {
                    foreach ( idx, var_687297cedbde711c in var_dc6deb912927ce57.var_66bed5d6eb6b39d1 )
                    {
                        str_color = ( 0, 0, 1 );
                        
                        if ( idx == 0 )
                        {
                            str_color = ( 0, 1, 0 );
                        }
                        else if ( idx == var_dc6deb912927ce57.var_66bed5d6eb6b39d1.size - 1 )
                        {
                            str_color = ( 1, 0, 0 );
                        }
                        
                        sphere( var_687297cedbde711c.origin, 25, str_color, 0, 300 );
                    }
                }
                
                break;
            case 1:
                race_reset_all();
                break;
            case 2:
                quest.var_ed8b343d828a592c[ "<dev string:x2ae>" ].cache setscriptablepartstate( "<dev string:x2b5>", "<dev string:x2ba>" );
                quest.var_ed8b343d828a592c[ "<dev string:x2cd>" ].cache setscriptablepartstate( "<dev string:x2b5>", "<dev string:x2ba>" );
                quest.var_ed8b343d828a592c[ "<dev string:x2d2>" ].cache setscriptablepartstate( "<dev string:x2b5>", "<dev string:x2ba>" );
                quest.var_ed8b343d828a592c[ "<dev string:x2d9>" ].cache setscriptablepartstate( "<dev string:x2b5>", "<dev string:x2ba>" );
                quest.var_ed8b343d828a592c[ "<dev string:x2df>" ].cache setscriptablepartstate( "<dev string:x2b5>", "<dev string:x2ba>" );
                break;
            case 3:
                function_56163fe660b30326( quest.var_ed8b343d828a592c[ "<dev string:x2ae>" ] );
                break;
            case 4:
                function_56163fe660b30326( quest.var_ed8b343d828a592c[ "<dev string:x2cd>" ] );
                break;
            case 5:
                function_56163fe660b30326( quest.var_ed8b343d828a592c[ "<dev string:x2d2>" ] );
                break;
            case 6:
                function_56163fe660b30326( quest.var_ed8b343d828a592c[ "<dev string:x2d9>" ] );
                break;
            case 7:
                function_56163fe660b30326( quest.var_ed8b343d828a592c[ "<dev string:x2df>" ] );
                break;
            case 8:
                quest thread function_9f7e0ab2aa7757e7( quest.var_ed8b343d828a592c[ "<dev string:x2ae>" ] );
                break;
            case 9:
                quest thread function_9f7e0ab2aa7757e7( quest.var_ed8b343d828a592c[ "<dev string:x2cd>" ] );
                break;
            case 10:
                quest thread function_9f7e0ab2aa7757e7( quest.var_ed8b343d828a592c[ "<dev string:x2d2>" ] );
                break;
            case 11:
                quest thread function_9f7e0ab2aa7757e7( quest.var_ed8b343d828a592c[ "<dev string:x2d9>" ] );
                break;
            case 12:
                quest thread function_9f7e0ab2aa7757e7( quest.var_ed8b343d828a592c[ "<dev string:x2df>" ] );
                break;
        }
    }

#/
