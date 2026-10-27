// script_1456f182ad10c689  (hash_1456f182ad10c689.gscc) (size: 19760 Bytes / 0x4d30 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbac8f48 (3685519176)
// size ...... 19760 (0x4d30)
// includes .. 24  (offset: 0x460c)
// strings ... 89  (offset: 0x46cc)
// dev strs .. 26  (offset: 0x4bd4)
// exports ... 49  (offset: 0x2c50)
// cseg ...... 0x7a7 + 0x24a9 (0x2c50)
// imports ... 154 (offset: 0x33f8)
// animtree1 . 0   (offset: 0x4d30)
// animtree2 . 0   (offset: 0x4d30)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;

#namespace activate_lockdown;

// Namespace activate_lockdown
// Params 0, eflags: 0x5
// Checksum 0x2c90acd7, Offset: 0x7c5
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace activate_lockdown
// Params 0
// Checksum 0xa96fa8f5, Offset: 0x7d6
// Size: 0x7a
function init()
{
    quest = { #on_disable:&on_disable, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"activate_lockdown" };
    br_map_quest::register( quest );
}

// Namespace activate_lockdown
// Params 0
// Checksum 0xde168152, Offset: 0x858
// Size: 0xe2
function on_init()
{
    init_bundle_data();
    set_dvars();
    function_1a00a5a2ba836d4d();
    cache_scriptables();
    set_callbacks();
    function_d9f4558b23e86d5f();
    function_46317fa7a9e08cda();
    self.var_dd411351679478e3 = [ "no_repaired", "one_repaired", "two_repaired", "three_repaired", "four_repaired", "five_repaired", "six_repaired", "seven_repaired", "eight_repaired" ];
    val::group_register( "ActivateLockdownRelayUse", [ "offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers" ] );
    function_a03986e6e07ebb73();
    
    /#
        debug_init();
    #/
}

// Namespace activate_lockdown
// Params 0
// Checksum 0xce6c3be8, Offset: 0x942
// Size: 0x2
function on_precache()
{
    
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x1f1a4269, Offset: 0x94c
// Size: 0x2
function on_start()
{
    
}

// Namespace activate_lockdown
// Params 0
// Checksum 0xf3519e58, Offset: 0x956
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x1002b8e2, Offset: 0x960
// Size: 0x1e
function on_infil()
{
    setup_power_relay_states();
    setup_power_indicator_state();
    function_3ca7909e6affef43();
    function_6de9b83d74f52893();
}

// Namespace activate_lockdown
// Params 0
// Checksum 0xdda74afc, Offset: 0x986
// Size: 0x9
function on_disable()
{
    function_46317fa7a9e08cda();
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x488befbe, Offset: 0x997
// Size: 0x123
function init_bundle_data()
{
    matchteamsize = game_utility::function_f24780eadd3fb772();
    bundle_name = "activate_lockdown_data_quads";
    
    switch ( matchteamsize )
    {
        case 1:
            bundle_name = "activate_lockdown_data_solos";
            break;
        case 2:
            bundle_name = "activate_lockdown_data_duos";
            break;
        case 3:
            bundle_name = "activate_lockdown_data_trios";
            break;
        case 4:
        default:
            break;
    }
    
    self.bundledata = getscriptbundle( hashcat( %"hash_2f7499bd85576ad6", bundle_name ) );
    
    if ( !isdefined( self.bundledata ) )
    {
        self.bundledata = { #var_656f6ca37e71dca1:"MP_BR_INGAME/BR_ACTIVATE_LOCKDOWN_POWER_INDICATOR_USE_ERROR", #var_bc16dfd72d715aba:"MP_BR_INGAME/BR_ACTIVATE_LOCKDOWN_RELAY_USE_ERROR", #var_d10a4ab0159c2ebf:1, #var_352ee8dd62900b2d:0.8, #var_8c702fc5651d39ef:16, #var_53de98ac198f90d7:8, #var_8a8636322e58fbf5:5, #var_31ecb045bb76bb6a:3 };
    }
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x7a0b75d2, Offset: 0xac2
// Size: 0x7e
function set_dvars()
{
    br_map_quest::add_setting( "toolboxes_total_amount", self.bundledata.var_31ecb045bb76bb6a );
    br_map_quest::add_setting( "relays_total_amount", self.bundledata.var_8a8636322e58fbf5 );
    br_map_quest::add_setting( "relay_hold_duration", self.bundledata.var_53de98ac198f90d7 );
    br_map_quest::add_setting( "relay_shock_duration", self.bundledata.var_d10a4ab0159c2ebf );
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x82e1886b, Offset: 0xb48
// Size: 0x180
function function_1a00a5a2ba836d4d()
{
    self.blast_doors = getentarray( "bunker_blast_door", #script_noteworthy );
    
    foreach ( door in self.blast_doors )
    {
        door.collision = getent( door.target, #targetname );
        
        if ( door.collision )
        {
            door.collision linkto( door );
            door.collision setmoverantilagged( 1 );
        }
        
        door.goal = utility::getstruct( door.target, "targetname" );
        door.collision.var_ee2b9c9187a8adde = 1;
    }
    
    self.speakerlocs = utility::getstructarray( "activate_lockdown_speaker", "script_noteworthy" );
    self.toolbox_spawn_list = utility::getstructarray( "activate_lockdown_toolbox", "targetname" );
    self.blueprint_spawn_list = utility::getstructarray( "activate_lockdown_weapon_spawn", "script_noteworthy" );
    self.blueprint_spawn_list = utility::array_sort_by_script_index( self.blueprint_spawn_list );
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x2cba920a, Offset: 0xcd0
// Size: 0x2b7
function cache_scriptables()
{
    self.inner_doors = getentitylessscriptablearray( "scriptable_t10_gate_rollup_bundle_11", #classname );
    self.speakers = [];
    
    foreach ( loc in self.speakerlocs )
    {
        self.speakers[ self.speakers.size ] = spawnscriptable( "quest_wz_activate_lockdown_speaker", loc.origin, loc.angles ?? ( 0, 0, 0 ) );
    }
    
    lockdown_lights = getentitylessscriptablearray( "activate_lockdown_light", #script_noteworthy );
    
    if ( lockdown_lights.size <= 0 )
    {
        self.lockdown_lights = [];
        self.lockdown_lights[ 0 ] = spawnscriptable( "quest_wz_activate_lockdown_light", ( 29773, 1576, -267 ), ( 88.9005, 135.21, -179.991 ) );
        self.lockdown_lights[ 1 ] = spawnscriptable( "quest_wz_activate_lockdown_light", ( 29465, 1970, -669 ), ( 0, 0, 0 ) );
        self.lockdown_lights[ 2 ] = spawnscriptable( "quest_wz_activate_lockdown_light", ( 29009, 1512, -669 ), ( 0, 0, 0 ) );
    }
    else
    {
        self.lockdown_lights = lockdown_lights;
    }
    
    lockdown_power_indicator = getentitylessscriptablearray( "activate_lockdown_power_indicator", "script_noteworthy" );
    self.lockdown_power_indicator = lockdown_power_indicator[ 0 ] ?? spawnscriptable( "quest_wz_activate_lockdown_power_indicator", ( 29853, 1608, -370 ), ( 0, 313, 0 ) );
    var_7630fd5e66fff5e2 = getentitylessscriptablearray( "activate_lockdown_power_relay", "script_noteworthy" );
    
    if ( var_7630fd5e66fff5e2.size <= 0 )
    {
        self.power_relays = [];
        self.power_relays[ 0 ] = spawnscriptable( "quest_wz_activate_lockdown_power_relay", ( 30523, 1923, -321 ), ( 0, 223, 0 ) );
        self.power_relays[ 1 ] = spawnscriptable( "quest_wz_activate_lockdown_power_relay", ( 30472, 1650, -321 ), ( 0, 131, 0 ) );
        self.power_relays[ 2 ] = spawnscriptable( "quest_wz_activate_lockdown_power_relay", ( 29633, 1381, -321 ), ( 0, 44, 0 ) );
        return;
    }
    
    self.power_relays = var_7630fd5e66fff5e2;
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x83b0293c, Offset: 0xf8f
// Size: 0x24
function set_callbacks()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_activate_lockdown_power_indicator", &function_d0bbffd989279c49 );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_activate_lockdown_power_relay", &activate_lockdown_power_relay_activation );
}

// Namespace activate_lockdown
// Params 6
// Checksum 0x75a711d8, Offset: 0xfbb
// Size: 0xae
function function_d0bbffd989279c49( instance, part, state, player, bautouse, usestring )
{
    quest = level.br_map_quest.quests[ "activate_lockdown" ];
    
    if ( quest.power_relay_repaired < 8 )
    {
        player function_aedb5293943d3968( quest.bundledata.var_656f6ca37e71dca1 );
        instance setscriptablepartstate( "quest_wz_activate_lockdown_power_indicator", "cooldown" );
        return;
    }
    
    function_500682987af034ef( instance, part, state, player, bautouse, usestring );
}

// Namespace activate_lockdown
// Params 6
// Checksum 0x6403e973, Offset: 0x1071
// Size: 0x497
function function_500682987af034ef( instance, part, state, player, bautouse, usestring )
{
    quest = level.br_map_quest.quests[ "activate_lockdown" ];
    quest function_39d92db1d02f15cd();
    points::function_40522c040a4e7b1( player.team, #"hash_79c0f17a1c9f555b" );
    quest br_map_quest::function_bcff1e4dd70594f4( player, "progress", [ "pos_x", instance.origin[ 0 ], "pos_y", instance.origin[ 1 ], "pos_z", instance.origin[ 2 ], "team_id", player.team, "relay_repair", 0, "quest_completed", 1 ] );
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:1 };
    quest br_map_quest::on_completed( params );
    quest.lockdown_power_indicator setscriptablepartstate( "quest_wz_activate_lockdown_power_indicator", "used" );
    quest.lockdown_power_indicator setscriptablepartstate( "screen", "activated" );
    
    foreach ( speaker in quest.speakers )
    {
        speaker setscriptablepartstate( "base", "warning" );
    }
    
    foreach ( light in quest.lockdown_lights )
    {
        light setscriptablepartstate( "quest_wz_activate_lockdown_light", "on" );
    }
    
    foreach ( door in quest.inner_doors )
    {
        door setscriptablepartstate( "base", "close" );
    }
    
    quest thread activate_lockdown_siren();
    utility::exploder( "lockdown_alert_monitor" );
    wait 10;
    
    foreach ( door in quest.blast_doors )
    {
        door thread function_99c671b966c49f02();
    }
    
    wait 31;
    utility::stop_exploder( "lockdown_alert_monitor" );
    
    foreach ( speaker in quest.speakers )
    {
        speaker setscriptablepartstate( "base", "lockdown" );
    }
    
    foreach ( light in quest.lockdown_lights )
    {
        light setscriptablepartstate( "quest_wz_activate_lockdown_light", "off" );
    }
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x9296f913, Offset: 0x1510
// Size: 0x106
function function_99c671b966c49f02()
{
    self setscriptablepartstate( "base", "moving" );
    midpoint = math::get_mid_point( self.goal.origin, self.origin );
    direction = self.goal.origin - self.origin;
    var_edba835ea52770ce = createnavobstaclebybounds( midpoint, ( 250, 250, 32 ), ( 0, 46, 0 ) );
    self.collision connectpaths();
    self moveto( self.origin + vectornormalize( direction ) * 3, 2, 1, 0 );
    wait 6;
    self moveto( self.goal.origin, 25, 20, 0 );
    wait 25;
    destroynavobstacle( var_edba835ea52770ce );
    self.collision disconnectpaths();
    self setscriptablepartstate( "base", "static" );
}

// Namespace activate_lockdown
// Params 0
// Checksum 0xd2233300, Offset: 0x161e
// Size: 0x55
function activate_lockdown_siren()
{
    siren = spawn( "script_model", ( 28717, 2261, 555 ) );
    siren setmodel( "quest_wz_activate_lockdown_siren" );
    siren forcenetfieldhighlod( 1 );
    waitframe();
    siren setscriptablepartstate( "sound_fx", "siren" );
    wait 25;
    siren delete();
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x90085881, Offset: 0x167b
// Size: 0x13
function function_a03986e6e07ebb73()
{
    calloutmarkerping::function_572853cf60de7300( "quest_wz_activate_lockdown_power_relay", "ping_objective_go_generic" );
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x40734a25, Offset: 0x1696
// Size: 0xfe
function setup_power_relay_states()
{
    if ( self.power_relays.size <= 0 )
    {
        return;
    }
    
    self.var_288163006a0fc67b = [];
    var_34799f2785355f07 = br_map_quest::get_setting( "relays_total_amount" );
    var_34799f2785355f07 = int( min( var_34799f2785355f07, self.power_relays.size ) );
    relay_candidates = [];
    
    for ( idx = 0; idx < self.power_relays.size ; idx++ )
    {
        relay_candidates[ idx ] = idx;
    }
    
    relay_candidates = arrayrandomize( relay_candidates );
    
    for ( idx = 0; idx < var_34799f2785355f07 ; idx++ )
    {
        relay_index = relay_candidates[ idx ];
        var_da741aa9a9b8a144 = self.power_relays[ relay_index ];
        var_da741aa9a9b8a144 setscriptablepartstate( "quest_wz_activate_lockdown_power_relay", "usable" );
        var_da741aa9a9b8a144 setscriptablepartstate( "visual_state", "broken" );
        self.var_288163006a0fc67b[ self.var_288163006a0fc67b.size ] = relay_index;
    }
    
    self.power_relay_repaired = 8 - var_34799f2785355f07;
}

// Namespace activate_lockdown
// Params 6
// Checksum 0x13ff7133, Offset: 0x179c
// Size: 0xcf
function activate_lockdown_power_relay_activation( instance, part, state, player, bautouse, usestring )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    quest = level.br_map_quest.quests[ "activate_lockdown" ];
    
    if ( !player br_quest_inventory::has_quest_item( "wz_consumable_quest_activate_lockdown_toolbox" ) )
    {
        player thread function_7baace494ec6d69f();
        player function_aedb5293943d3968( quest.bundledata.var_bc16dfd72d715aba );
        return;
    }
    
    var_afceab17afd85a34 = isdefined( player.activate_lockdown_relay_use );
    
    if ( !var_afceab17afd85a34 )
    {
        thread function_bceab700c26ede6c( instance, part, state, player, bautouse, usestring, quest );
    }
}

// Namespace activate_lockdown
// Params 7, eflags: 0x4
// Checksum 0xd6a7c98, Offset: 0x1873
// Size: 0x116
function private function_bceab700c26ede6c( instance, part, state, player, bautouse, usestring, quest )
{
    if ( !function_d971e00d5ee3e4e2( instance, player ) )
    {
        return;
    }
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    player.activate_lockdown_relay_use = { #curprogress:0 };
    player.activate_lockdown_relay_use.usetime = quest br_map_quest::get_setting( "relay_hold_duration" );
    instance.id = "activate_lockdown_relay";
    function_cd37b2ec7520f7( player, instance );
    result = function_ca79a4b31bab0d7d( player, instance );
    
    if ( player )
    {
        thread function_dd430043e688c95f( player, instance, result );
    }
    
    if ( result )
    {
        player relay_repair( instance, quest );
    }
    else
    {
        instance setscriptablepartstate( "sfx", "base" );
        instance setscriptablepartstate( "quest_wz_activate_lockdown_power_relay", "usable" );
    }
    
    player.activate_lockdown_relay_use = undefined;
}

// Namespace activate_lockdown
// Params 2, eflags: 0x4
// Checksum 0xdcea20e1, Offset: 0x1991
// Size: 0x8b, Type: bool
function private function_d971e00d5ee3e4e2( instance, player )
{
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !player::isaliveandnotinlaststand( player ) )
    {
        return false;
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( player.iscarrying && !isdefined( player.carriable ) )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return false;
    }
    
    if ( player isthrowinggrenade() )
    {
        return false;
    }
    
    return true;
}

// Namespace activate_lockdown
// Params 2, eflags: 0x4
// Checksum 0xe7267391, Offset: 0x1a25
// Size: 0x81
function private function_cd37b2ec7520f7( player, instance )
{
    player thread function_d6f678789986f9e2();
    player val::group_set( "ActivateLockdownRelayUse", 0 );
    player setclientomnvar( "ui_br_inventory_disabled", 1 );
    player gameobjects::updateuiprogress( instance, 0, player.activate_lockdown_relay_use );
    instance setscriptablepartstate( "sfx", "repairing" );
    instance setscriptablepartstate( "quest_wz_activate_lockdown_power_relay", "used" );
    player.is_using_activate_lockdown_relay = 1;
}

// Namespace activate_lockdown
// Params 0, eflags: 0x4
// Checksum 0x38d005c8, Offset: 0x1aae
// Size: 0x50
function private function_d6f678789986f9e2()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    weapon_utility::saveweaponstates();
    crate_weapon_obj = makeweapon( "ks_use_crate_mp" );
    inventory_utility::_giveweapon( crate_weapon_obj );
    thread function_7a3582e1434a5ee9( crate_weapon_obj );
    self switchtoweapon( crate_weapon_obj );
}

// Namespace activate_lockdown
// Params 1, eflags: 0x4
// Checksum 0xa15013b5, Offset: 0x1b06
// Size: 0xa4
function private function_7a3582e1434a5ee9( crate_weapon_obj )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"hash_8b4e799a5c484a9a" );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( crate_weapon_obj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( crate_weapon_obj );
        return;
    }
    
    inventory_utility::_takeweapon( crate_weapon_obj );
    
    if ( self.lastdroppableweaponobj )
    {
        if ( self.inlaststand )
        {
            self waittill( #"last_stand_exit" );
        }
        
        last_weapon_obj = weapon_utility::restoreweaponstates( self.lastdroppableweaponobj, 1 );
        self switchtoweapon( last_weapon_obj );
    }
    
    thread inventory_utility::forcevalidweapon( last_weapon_obj );
}

// Namespace activate_lockdown
// Params 2, eflags: 0x4
// Checksum 0xfdd92781, Offset: 0x1bb2
// Size: 0x142, Type: bool
function private function_ca79a4b31bab0d7d( player, instance )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    instance.use_rate = player.objectivescaler ?? 1;
    
    while ( player && function_23ff70dbb26a6025( player, instance ) && player usebuttonpressed() )
    {
        player.activate_lockdown_relay_use.curprogress += level.framedurationseconds * instance.use_rate;
        
        if ( player.activate_lockdown_relay_use.curprogress >= player.activate_lockdown_relay_use.usetime )
        {
            player.activate_lockdown_relay_use.curprogress = 0;
            return true;
        }
        
        player gameobjects::updateuiprogress( instance, 1, player.activate_lockdown_relay_use );
        waitframe();
    }
    
    if ( player.activate_lockdown_relay_use.curprogress )
    {
        player.activate_lockdown_relay_use.curprogress = 0;
    }
    
    return false;
}

// Namespace activate_lockdown
// Params 2, eflags: 0x4
// Checksum 0xa60f8fbd, Offset: 0x1cfd
// Size: 0x122, Type: bool
function private function_23ff70dbb26a6025( player, instance )
{
    if ( !isdefined( instance ) )
    {
        return false;
    }
    
    var_488d64c382c7ed45 = player val::get( "crate_use" );
    
    if ( !var_488d64c382c7ed45 )
    {
        return false;
    }
    
    if ( !player player::isreallyalive() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player superbuttonpressed() )
    {
        player hud_message::showerrormessage( "SUPER_MP/SUPER_CANNOT_USE" );
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    if ( !isdefined( player.activate_lockdown_relay_use ) )
    {
        return false;
    }
    
    quest = level.br_map_quest.quests[ "activate_lockdown" ];
    var_6a97dfea6e23047c = getdvarfloat( @"hash_ecd52993b5dab130", 128 ) + quest.bundledata.var_8c702fc5651d39ef;
    max_dist_squared = var_6a97dfea6e23047c * var_6a97dfea6e23047c;
    
    if ( distancesquared( player.origin, instance.origin ) > max_dist_squared )
    {
        return false;
    }
    
    return true;
}

// Namespace activate_lockdown
// Params 3, eflags: 0x4
// Checksum 0xa084dac0, Offset: 0x1e28
// Size: 0x97
function private function_dd430043e688c95f( player, instance, result )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player val::group_reset( "ActivateLockdownRelayUse" );
    player setclientomnvar( "ui_br_inventory_disabled", 0 );
    assert( player.activate_lockdown_relay_use );
    
    if ( instance )
    {
        player gameobjects::updateuiprogress( instance, 0, player.activate_lockdown_relay_use );
    }
    
    player notify( #"hash_8b4e799a5c484a9a" );
    player.is_using_activate_lockdown_relay = undefined;
}

// Namespace activate_lockdown
// Params 2, eflags: 0x4
// Checksum 0x43aa9e82, Offset: 0x1ec7
// Size: 0x152
function private relay_repair( instance, quest )
{
    if ( !isdefined( instance ) || !isdefined( quest ) )
    {
        return;
    }
    
    instance setscriptablepartstate( "sfx", "repaired" );
    quest.power_relay_repaired = int( min( quest.power_relay_repaired + 1, 8 ) );
    quest function_a61b3d2d4a212141();
    instance setscriptablepartstate( "quest_wz_activate_lockdown_power_relay", "used" );
    instance setscriptablepartstate( "visual_state", "intact" );
    points::doscoreevent( #"hash_211e0c0cc9bd29d4" );
    
    if ( quest.power_relay_repaired == 8 )
    {
        points::function_40522c040a4e7b1( self.team, #"hash_8152a2bc4f80de0e" );
    }
    
    quest br_map_quest::function_bcff1e4dd70594f4( self, "progress", [ "pos_x", instance.origin[ 0 ], "pos_y", instance.origin[ 1 ], "pos_z", instance.origin[ 2 ], "team_id", self.team, "relay_repair", 1, "quest_completed", 0 ] );
}

// Namespace activate_lockdown
// Params 1
// Checksum 0x9f0fa9c, Offset: 0x2021
// Size: 0x5f
function function_aedb5293943d3968( message )
{
    player = self;
    
    if ( !isplayer( player ) || !isdefined( message ) )
    {
        return;
    }
    
    if ( soundexists( "fly_pickup_deny" ) )
    {
        player playlocalsound( "fly_pickup_deny" );
    }
    
    if ( level.showerrormessagefunc )
    {
        player [[ level.showerrormessagefunc ]]( message );
    }
}

// Namespace activate_lockdown
// Params 0, eflags: 0x4
// Checksum 0x3a5e3c06, Offset: 0x2088
// Size: 0xa2
function private function_d9f4558b23e86d5f()
{
    quest = self;
    quest.bundle = spawnstruct();
    quest.bundle.var_9342451ed3d7db03 = self.bundledata.var_352ee8dd62900b2d;
    quest.bundle.var_f3447a3874df563f = undefined;
    quest.bundle.var_bd94b71ffdfd39c = 1;
    quest.bundle.var_b110dbf60f7e2c47 = undefined;
    quest.bundle.var_4c6cc0f99efbb64f = 1;
}

// Namespace activate_lockdown
// Params 0, eflags: 0x4
// Checksum 0xf360c29b, Offset: 0x2132
// Size: 0xbb
function private function_7baace494ec6d69f()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    quest = level.br_map_quest.quests[ "activate_lockdown" ];
    
    if ( !isdefined( quest ) )
    {
        return;
    }
    
    if ( !self.ishaywire )
    {
        shockdata = { #victim:self };
        quest shock_stick::function_5f89a63c19349cd5( shockdata, quest.bundle );
        shock_duration = quest br_map_quest::get_setting( "relay_shock_duration" );
        utility::waittill_any_timeout( shock_duration, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_enter" );
        function_c9f63c381f9c369e( quest );
    }
}

// Namespace activate_lockdown
// Params 1
// Checksum 0xef56ec24, Offset: 0x21f5
// Size: 0x67
function function_c9f63c381f9c369e( quest )
{
    if ( !isdefined( quest.bundle ) )
    {
        return;
    }
    
    if ( self.ishaywire )
    {
        self.ishaywire = undefined;
        fromdeath = !player::isreallyalive( self );
        shock_stick::function_a509214050ca03a5( fromdeath, quest.bundle );
        self notify( #"haywire_cleared" );
    }
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x854f4038, Offset: 0x2264
// Size: 0x30
function setup_power_indicator_state()
{
    if ( !isdefined( self.lockdown_power_indicator ) )
    {
        return;
    }
    
    self.lockdown_power_indicator setscriptablepartstate( "quest_wz_activate_lockdown_power_indicator", "usable" );
    function_a61b3d2d4a212141();
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x51cb7398, Offset: 0x229c
// Size: 0x4e
function function_a61b3d2d4a212141()
{
    if ( !( isdefined( self.lockdown_power_indicator ) && isdefined( self.var_dd411351679478e3[ self.power_relay_repaired ] ) ) )
    {
        return;
    }
    
    self.lockdown_power_indicator setscriptablepartstate( "screen", self.var_dd411351679478e3[ self.power_relay_repaired ] );
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x53da3a27, Offset: 0x22f2
// Size: 0x102
function function_3ca7909e6affef43()
{
    if ( self.toolbox_spawn_list.size <= 0 )
    {
        return;
    }
    
    self.toolbox_bundle = common_item::function_cf68ad18114498b2( "wz_consumable_quest_activate_lockdown_toolbox" );
    
    if ( !isdefined( self.toolbox_bundle ) )
    {
        return;
    }
    
    var_7a7c5e4f65fd94de = br_map_quest::get_setting( "toolboxes_total_amount" );
    var_7a7c5e4f65fd94de = int( min( self.toolbox_spawn_list.size, var_7a7c5e4f65fd94de ) );
    var_ebde55aad045e2b8 = [];
    
    for ( idx = 0; idx < self.toolbox_spawn_list.size ; idx++ )
    {
        var_ebde55aad045e2b8[ idx ] = idx;
    }
    
    var_ebde55aad045e2b8 = arrayrandomize( var_ebde55aad045e2b8 );
    
    for ( idx = 0; idx < var_7a7c5e4f65fd94de ; idx++ )
    {
        toolbox_spawn_index = var_ebde55aad045e2b8[ idx ];
        toolbox_spawn = self.toolbox_spawn_list[ toolbox_spawn_index ];
        toolbox = common_item::function_a87dc047f584d2c7( self.toolbox_bundle, toolbox_spawn.origin, toolbox_spawn.angles, undefined, 1 );
    }
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x4666b9da, Offset: 0x23fc
// Size: 0xc8
function function_46317fa7a9e08cda()
{
    triggerarray = getnoentvolumearray( "activate_lockdown_kt", #script_noteworthy );
    
    foreach ( trigger in triggerarray )
    {
        if ( isdefined( trigger ) )
        {
            if ( !isdefined( self.killtriggers ) )
            {
                self.killtriggers = [];
            }
            
            self.killtriggers[ self.killtriggers.size ] = trigger;
            trigger::makeenterexittrigger( trigger, &bunker_trigger_enter );
        }
    }
}

// Namespace activate_lockdown
// Params 2
// Checksum 0x213c8de2, Offset: 0x24cc
// Size: 0x3b
function bunker_trigger_enter( player, killtrigger )
{
    if ( isplayer( player ) )
    {
        player dodamage( 10000, player.origin, player, player, "MOD_TRIGGER_HURT" );
    }
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x828a19b0, Offset: 0x250f
// Size: 0x8e
function function_39d92db1d02f15cd()
{
    if ( !isdefined( self.killtriggers ) )
    {
        return;
    }
    
    foreach ( trigger in self.killtriggers )
    {
        trigger notify( #"hash_73537c07898a047a" );
    }
}

// Namespace activate_lockdown
// Params 0
// Checksum 0x6087b4e2, Offset: 0x25a5
// Size: 0xf1
function function_6de9b83d74f52893()
{
    team_size = game_utility::function_f24780eadd3fb772();
    var_7b9c397db9ee656f = self.blueprint_spawn_list;
    
    for ( i = 0; i < team_size ; i++ )
    {
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( var_7b9c397db9ee656f[ i ].origin, var_7b9c397db9ee656f[ i ].angles );
        spawnoptions.critical = 1;
        scriptable = common_item::function_61c2c0251e742ffd( %"hash_5450e8d5782f53c7", undefined, spawnoptions );
        scriptable.is_activate_lockdown_blueprint = 1;
        
        if ( scriptable getscriptableparthasstate( scriptable.type, #"visible_staged_weapon" ) )
        {
            scriptable setscriptablepartstate( scriptable.type, #"visible_staged_weapon" );
        }
    }
    
    level callback::add( #"item_weapon_picked_up", &function_d2286bb40ecec08 );
}

// Namespace activate_lockdown
// Params 1
// Checksum 0xbc9b57bb, Offset: 0x269e
// Size: 0x56
function function_d2286bb40ecec08( params )
{
    if ( !params.item.is_activate_lockdown_blueprint || params.item.type != "brloot_weapon_dm_p03_sgeorge550_stadium" )
    {
        return;
    }
    
    challenges::function_37e945722d6497f3( self, "sierra_activate_lockdown_blueprint", 1, 1 );
}

/#

    // Namespace activate_lockdown
    // Params 0
    // Checksum 0x32825f21, Offset: 0x26fc
    // Size: 0xf1, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x33>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x54>", &function_e7548e8c67916f70 );
        relays_repair_amount = br_map_quest::get_setting( "<dev string:x7e>" );
        
        for ( i = 0; i < relays_repair_amount ; i++ )
        {
            desc_string = "<dev string:x92>" + i + 1;
            token_string = "<dev string:xa9>" + i;
            devgui::function_cd4e263c1f3018ae( desc_string, token_string, &function_4f54d1db52170736 );
        }
        
        devgui::add_devgui_func( "<dev string:xb7>", "<dev string:xcf>", &function_a85dd9487d204144 );
        devgui::add_devgui_func( "<dev string:x103>", "<dev string:x11a>", &function_527799994f0954a1 );
        devgui::add_devgui_func( "<dev string:x141>", "<dev string:x153>", &function_7009aa097a1c871a );
        devgui::add_devgui_func( "<dev string:x181>", "<dev string:x195>", &function_540f49f23a2bca96 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activate_lockdown
    // Params 0
    // Checksum 0x2d501262, Offset: 0x27f5
    // Size: 0x83, Type: dev
    function function_e7548e8c67916f70()
    {
        toolbox_bundle = common_item::function_cf68ad18114498b2( "<dev string:x1c5>" );
        
        if ( !isdefined( toolbox_bundle ) )
        {
            return;
        }
        
        spawn_origin = level.player.origin + ( 50, 50, 10 );
        spawn_angles = level.player.angles;
        toolbox = common_item::function_a87dc047f584d2c7( toolbox_bundle, spawn_origin, spawn_angles, undefined, 1 );
    }

    // Namespace activate_lockdown
    // Params 1
    // Checksum 0x402f13e4, Offset: 0x2880
    // Size: 0xfd, Type: dev
    function function_4f54d1db52170736( params )
    {
        if ( !flags::gameflag( "<dev string:x1f3>" ) )
        {
            assertmsg( "<dev string:x201>" );
            return;
        }
        
        broken_index = int( params[ 0 ] );
        quest = level.br_map_quest.quests[ "<dev string:x244>" ];
        
        if ( !isdefined( quest.var_288163006a0fc67b[ broken_index ] ) )
        {
            return;
        }
        
        target_relay = quest.power_relays[ quest.var_288163006a0fc67b[ broken_index ] ];
        level.players[ 0 ] setorigin( target_relay.origin + anglestoforward( target_relay.angles ) * 30 );
        player_angles = target_relay.angles + ( 0, 180, 0 );
        level.players[ 0 ] setplayerangles( player_angles );
    }

    // Namespace activate_lockdown
    // Params 0
    // Checksum 0x7f74faed, Offset: 0x2985
    // Size: 0x53, Type: dev
    function function_527799994f0954a1()
    {
        quest = level.br_map_quest.quests[ "<dev string:x244>" ];
        function_500682987af034ef( quest.lockdown_power_indicator, "<dev string:x256>", "<dev string:x281>", level.players[ 0 ], undefined, undefined );
    }

    // Namespace activate_lockdown
    // Params 0
    // Checksum 0x36fabf2a, Offset: 0x29e0
    // Size: 0xa2, Type: dev
    function function_a85dd9487d204144()
    {
        quest = level.br_map_quest.quests[ "<dev string:x244>" ];
        power_indicator = quest.lockdown_power_indicator;
        level.players[ 0 ] setorigin( power_indicator.origin + anglestoforward( power_indicator.angles ) * 60 );
        player_angles = power_indicator.angles + ( 0, 180, 0 );
        level.players[ 0 ] setplayerangles( player_angles );
    }

    // Namespace activate_lockdown
    // Params 0
    // Checksum 0xf13bf779, Offset: 0x2a8a
    // Size: 0xac, Type: dev
    function function_7009aa097a1c871a()
    {
        quest = level.br_map_quest.quests[ "<dev string:x244>" ];
        quest.blast_doors[ 0 ] moveto( ( 28238.8, 2740.42, -812.29 ), 0.1 );
        quest.blast_doors[ 0 ] setscriptablepartstate( "<dev string:x288>", "<dev string:x28d>" );
        quest.blast_doors[ 1 ] moveto( ( 29194.4, 1784.83, -812.29 ), 0.1 );
        quest.blast_doors[ 1 ] setscriptablepartstate( "<dev string:x288>", "<dev string:x28d>" );
    }

    // Namespace activate_lockdown
    // Params 0
    // Checksum 0x2d5906a, Offset: 0x2b3e
    // Size: 0x112, Type: dev
    function function_540f49f23a2bca96()
    {
        quest = level.br_map_quest.quests[ "<dev string:x244>" ];
        
        foreach ( relay_index in quest.var_288163006a0fc67b )
        {
            relay = quest.power_relays[ relay_index ];
            relay setscriptablepartstate( "<dev string:x294>", "<dev string:x281>" );
            relay setscriptablepartstate( "<dev string:x2bb>", "<dev string:x2c8>" );
        }
        
        quest.power_relay_repaired = 8 - quest.var_288163006a0fc67b.size;
        quest.lockdown_power_indicator setscriptablepartstate( "<dev string:x256>", "<dev string:x281>" );
        quest function_a61b3d2d4a212141();
    }

#/
