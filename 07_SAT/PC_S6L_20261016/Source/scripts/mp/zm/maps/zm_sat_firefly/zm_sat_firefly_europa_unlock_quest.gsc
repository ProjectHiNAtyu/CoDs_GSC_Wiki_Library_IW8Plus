// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_europa_unlock_quest.gsc  (hash_2c751cf74eafeb9a.gscc) (size: 37387 Bytes / 0x920b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb02520fb (2955223291)
// size ...... 37387 (0x920b)
// includes .. 21  (offset: 0x8577)
// strings ... 154 (offset: 0x861f)
// dev strs .. 6   (offset: 0x91bf)
// exports ... 59  (offset: 0x6153)
// cseg ...... 0xced + 0x5466 (0x6153)
// imports ... 194 (offset: 0x6a8b)
// animtree1 . 0   (offset: 0x920b)
// animtree2 . 0   (offset: 0x920b)
#using script_ac28d65e8605696;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_europa_unlock_quest;

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0, eflags: 0x5
// Checksum 0x894687a8, Offset: 0xd0b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_20abb664dc40cc64", undefined, undefined, &init );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0xe03bf52b, Offset: 0xd2c
// Size: 0x319
function init()
{
    if ( game_utility::function_21211f3255f8ea58() )
    {
        function_8f61645575558381();
        return;
    }
    
    if ( !getdvarint( @"enable_firefly_ee", 0 ) )
    {
        unlock_device = getent( "europa_unlock_device", "script_noteworthy" );
        unlock_chip = getent( "europa_unlock_chip", "script_noteworthy" );
        box_struct = utility::getstruct( "viper_box_deactivated", "script_noteworthy" );
        viper_box = utility::spawn_model( "sat_zm_uber_k_box_full_fxanim", box_struct.origin, box_struct.angles );
        unlock_chip hide();
        level utility::flag_wait( "scriptables_ready" );
        unlock_device utility::function_32b24db3127bff40( "screen", "power_off" );
        viper_box utility::function_32b24db3127bff40( "box_indicator", "deactivated" );
        var_7e92747a6c4d5344 = utility::getstruct( "europa_spawner", "script_noteworthy" );
        var_930af36215fc7c5f = utility::spawn_model( "sat_zm_torture_chair_fxanim", var_7e92747a6c4d5344.origin, var_7e92747a6c4d5344.angles );
        return;
    }
    
    level._effect[ "europa_unlock_spark" ] = loadfxasset( "vfx_sat_levels_zm_firefly_klaus_wires_elec" );
    level._effect[ "europa_unlock_terminla_spark" ] = loadfxasset( "vfx_sat_levels_zm_firefly_klaus_terminal_elec" );
    level._effect[ "europa_unlock_torso" ] = loadfxasset( "vfx_sat_levels_zm_firefly_klaus_elec_shock_torso" );
    level._effect[ "europa_unlock_arms" ] = loadfxasset( "vfx_sat_levels_zm_firefly_klaus_elec_shock_arms" );
    level._effect[ "europa_unlock_legs" ] = loadfxasset( "vfx_sat_levels_zm_firefly_klaus_elec_shock_legs" );
    level._effect[ "europa_stun" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_flashbang_stun_head" );
    level utility::flag_wait( "zm_sat_firefly_europa_unlock_quest_create_script_completed" );
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_quest_initialized" );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"find_klaus", &setup_find_klaus, &cleanup_find_klaus );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"approach_viper", &setup_approach_viper, &cleanup_approach_viper );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"hash_e6d2991f8688bd9b", &setup_wait_viper, &cleanup_wait_viper );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"hash_62467328fcb57cc6", &function_b9d25db9d0aa4957, &function_37e1c01192595378 );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"hash_d7ed766c3c6c69cf", &function_4277654187df36e2, &function_f61064fafcd30089 );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"stabilize_europa", &setup_stabilize_europa, &cleanup_stabilize_europa );
    zm_quest::register_quest_step( #"europa_unlock_quest", #"reboot_europa", &setup_reboot_europa, &cleanup_reboot_europa );
    level callback::add( "quest_item_used", &on_quest_item_pickup );
    level utility::flag_wait( "begin_round_logic" );
    level thread setup_europa_unlock_ee();
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"europa_unlock_quest" );
    
    /#
        level thread function_cf059f0f6284a13a();
    #/
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0xee4cf617, Offset: 0x104d
// Size: 0x3ca
function function_8f61645575558381()
{
    level.europa_unlock_ee = spawnstruct();
    level utility::flag_init( "europa_assets_ready" );
    level utility::flag_wait( "begin_round_logic" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 = utility::getstruct( "europa_spawner", "script_noteworthy" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 thread scene::play( undefined, "looping_idle_1", "sat_cin_zm_europa_chained" );
    scene::add_scene_func( level.europa_unlock_ee.var_15bcb3e0fb9f42a7, &setup_europa_data, "looping_idle_1" );
    level utility::flag_wait( "europa_scene_played" );
    level.europa_unlock_ee.europa = level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::get_entity( "Actor 1" );
    level.europa_unlock_ee.europa.team = game[ "attackers" ];
    level.europa_unlock_ee.europa.var_eb92c31552620100 = 1;
    level.europa_unlock_ee.unlock_device = getent( "europa_unlock_device", "script_noteworthy" );
    level.europa_unlock_ee.unlock_chip = getent( "europa_unlock_chip", "script_noteworthy" );
    level.europa_unlock_ee.unlock_wire = getent( "europa_unlock_wire", "script_noteworthy" );
    level.europa_unlock_ee.summon_devices = getentarray( "europa_summon", "script_noteworthy" );
    level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_52318df3b22daaa2", level.europa_unlock_ee.europa.origin, level.europa_unlock_ee.europa.angles );
    level.europa_unlock_ee.europa setscriptablepartstate( "madness", "activated" );
    level thread function_9603d40ae36badd4( "power_on3" );
    level utility::flag_set( "europa_assets_ready" );
    level utility::flag_wait( "power_on3" );
    level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "install_complete" );
    level.europa_unlock_ee.europa europa::set_on_chair( 1 );
    level waittill( #"europa_first_activation_finished", params );
    level utility::flag_set( "disable_europa_interaction" );
    level thread function_91ffcd5de381188f();
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::play( level.europa_unlock_ee.var_bdd6f8bc19ccd8d7, "first_activated", "sat_cin_zm_europa_chained" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::stop_object( "Actor 1" );
    level utility::flag_clear( "disable_europa_interaction" );
    waitframe();
    
    if ( !params.owner )
    {
        iprintlnbold( "setup_reboot_europa - Europa Owner Deleted!" );
        level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_5a10c74557470ade" );
    }
    else
    {
        level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_cc6a196accc3d6bf", params );
    }
    
    if ( isdefined( params.owner ) )
    {
        params.owner namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_dc71102e59bb8035", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x59e17e78, Offset: 0x141f
// Size: 0xf
function setup_europa_data()
{
    level utility::flag_set( "europa_scene_played" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x173a5f8e, Offset: 0x1436
// Size: 0x8e2
function setup_europa_unlock_ee()
{
    level.europa_unlock_ee = spawnstruct();
    level utility::flag_init( "europa_assets_ready" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 = utility::getstruct( "europa_spawner", "script_noteworthy" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::init( undefined, "looping_idle_1", "sat_cin_zm_europa_chained" );
    level.europa_unlock_ee.europa = level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::get_entity( "Actor 1" );
    level.europa_unlock_ee.europa.team = game[ "attackers" ];
    level.europa_unlock_ee.europa.var_eb92c31552620100 = 1;
    level.europa_unlock_ee.europa.sceneobjectdata = level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::get_object( "Actor 1" );
    level.europa_unlock_ee.europa.sceneobjectdata.existingentity = 1;
    level.europa_unlock_ee.europa_chair = level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::get_entity( "Prop 1" );
    level.europa_unlock_ee.var_bdd6f8bc19ccd8d7 = [ level.europa_unlock_ee.europa, level.europa_unlock_ee.europa_chair ];
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 thread scene::play( level.europa_unlock_ee.var_bdd6f8bc19ccd8d7, "chip_installed", "sat_cin_zm_europa_chained" );
    level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_52318df3b22daaa2", level.europa_unlock_ee.europa.origin, level.europa_unlock_ee.europa.angles );
    level.europa_unlock_ee.europa setscriptablepartstate( "madness", "activated" );
    level.europa_unlock_ee.var_163444e1336b6859 = utility::getstruct( "viper_box", "script_noteworthy" );
    level.europa_unlock_ee.var_163444e1336b6859 scene::init( undefined, "looping_idle", "sat_cin_zm_viper_break_out" );
    level.europa_unlock_ee.viper = level.europa_unlock_ee.var_163444e1336b6859 scene::get_entity( "Actor 1" );
    level.europa_unlock_ee.viper_box = level.europa_unlock_ee.var_163444e1336b6859 scene::get_entity( "Prop 1" );
    level.europa_unlock_ee.var_163444e1336b6859 thread scene::play( undefined, "looping_idle", "sat_cin_zm_viper_break_out" );
    level.europa_unlock_ee.viper.ignoreme = 1;
    level.europa_unlock_ee.viper.b_ignore_water_check = 1;
    level.europa_unlock_ee.viper.var_2902ca09e32bd7d8 = 1;
    level.europa_unlock_ee.viper.ignore_enemy_count = 1;
    level.europa_unlock_ee.viper.b_ignore_cleanup = 1;
    level.europa_unlock_ee.viper.var_825b17c932865df = 1;
    level.europa_unlock_ee.viper.b_ignore_death_perception = 1;
    level.europa_unlock_ee.viper.var_7ee152b43c7188e1 = 1;
    level.europa_unlock_ee.viper.var_a13bed1ac47e1b2c = 1;
    level.europa_unlock_ee.viper.var_dea940150826c88d = 1;
    level.europa_unlock_ee.viper.var_e7095781f14d8c2d = 1;
    level.europa_unlock_ee.viper.var_2fc3a5fb762afb6e = 1;
    level.europa_unlock_ee.viper function_66dc8b6ae969f66d( 1 );
    level.europa_unlock_ee.viper.var_be5ccf6d16f6b59e = 1;
    level.europa_unlock_ee.viper.var_8b8cea407e5fee86 = 1;
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "damage", 0 );
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "death", 0 );
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_dismember", 0 );
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_brot", 0 );
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "show_healthbar", 0 );
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_vo", 0 );
    level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_aim_assist", 0 );
    
    if ( level.europa_unlock_ee.viper isscriptable() )
    {
        level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "base", "base_off" );
        level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "icon", "idle" );
        level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "tesla_coil_left", "off" );
        level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "tesla_coil_right", "off" );
    }
    
    level callback::add( "on_zombie_viper_eject", &function_b6855e090d96eab0 );
    level.europa_unlock_ee.viper callback::add( "on_zombie_ai_killed", &function_9992242babee92d0 );
    level.europa_unlock_ee.unlock_device = getent( "europa_unlock_device", "script_noteworthy" );
    level.europa_unlock_ee.unlock_chip = getent( "europa_unlock_chip", "script_noteworthy" );
    level.europa_unlock_ee.unlock_wire = getent( "europa_unlock_wire", "script_noteworthy" );
    level.europa_unlock_ee.unlock_chip hide();
    level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "power_off" );
    level.europa_unlock_ee.unlock_device.interact = zm_quest::function_91f9590e98d57ff6( level.europa_unlock_ee.unlock_device, &use_europa_unlock_device, &function_d6496090aab8d3c, "small" );
    level.europa_unlock_ee.summon_devices = getentarray( "europa_summon", "script_noteworthy" );
    level thread function_9603d40ae36badd4();
    a_s_stuns = utility::getstructarray( "europa_quest_stun", "script_noteworthy" );
    
    foreach ( struct in a_s_stuns )
    {
        stun = zm_quest::spawn_quest_item( struct.origin + ( 0, 0, -3 ), struct.angles, %"hash_268cec26a054a1a3" );
    }
    
    level utility::flag_set( "europa_assets_ready" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1, eflags: 0x4
// Checksum 0x1826ff70, Offset: 0x1d20
// Size: 0x7f
function private function_9992242babee92d0( params )
{
    if ( !level utility::flag( "viper_mini_killed" ) )
    {
        zm_quest::function_4eefe6de31f5ddab( #"europa_unlock_quest", #"viper_mini_alive", 1 );
    }
    
    if ( isdefined( level.europa_unlock_ee ) && isdefined( level.europa_unlock_ee.viper ) )
    {
        level.europa_unlock_ee.viper callback::remove( "on_zombie_ai_killed", &function_9992242babee92d0 );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0xe08a1a12, Offset: 0x1da7
// Size: 0x1d7
function function_b6855e090d96eab0( params )
{
    if ( isdefined( params.eject_ai ) )
    {
        hud_data = function_288fb21b76dbbe94( params.eject_ai, 100, undefined, params.eject_ai );
        level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"hash_62467328fcb57cc6" );
        params.eject_ai.var_a13bed1ac47e1b2c = 1;
        params.eject_ai val::set( "europa_unlock_ee", "allow_brot", 0 );
        params.eject_ai.b_ignore_water_check = 1;
        params.eject_ai.var_2902ca09e32bd7d8 = 1;
        params.eject_ai.ignore_enemy_count = 1;
        params.eject_ai.b_ignore_cleanup = 1;
        params.eject_ai.var_825b17c932865df = 1;
        params.eject_ai.b_ignore_death_perception = 1;
        params.eject_ai.var_7ee152b43c7188e1 = 1;
        params.eject_ai.var_e7095781f14d8c2d = 1;
        params.eject_ai.var_8b8cea407e5fee86 = 1;
        params.eject_ai callback::add( "on_zombie_ai_killed", &function_fe56a90e8acb3a11 );
        zm_quest::function_4eefe6de31f5ddab( #"europa_unlock_quest", #"viper_mini_alive", 1 );
        level callback::remove( "on_zombie_viper_eject", &function_b6855e090d96eab0 );
        level.europa_unlock_ee.viper_mini = params.eject_ai;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 6, eflags: 0x4
// Checksum 0x93dbd379, Offset: 0x1f86
// Size: 0x8b
function private function_288fb21b76dbbe94( var_8d3073d69d0ee3d1, offset = undefined, radius = undefined, var_895bdd0db4c4515 = undefined, str_label = undefined, var_7658622ac37ea4e5 = undefined )
{
    return [ [ var_8d3073d69d0ee3d1, offset, radius, str_label, var_7658622ac37ea4e5, var_895bdd0db4c4515 ] ];
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 5, eflags: 0xc
// Checksum 0xe87bbd8d, Offset: 0x201a
// Size: 0x1a9
function private function_d8d8737d2a3fc57( hud_data, var_42d0d026ca87eb78, quest_step, var_cdb665c03b873a33, var_ca908a6a83b8fb50 )
{
    self notify( #"hash_6e5b3c7119c17278" );
    self endon( #"hash_6e5b3c7119c17278" );
    level endon( #"game_ended" );
    europa_unlock_quest = zm_quest::get_quest( #"europa_unlock_quest" );
    var_dd7c19dbdfeef2f2 = europa_unlock_quest.steps[ europa_unlock_quest.steps.size - 1 ];
    
    if ( var_dd7c19dbdfeef2f2.completed )
    {
        return;
    }
    
    if ( isdefined( level.europa_unlock_ee ) )
    {
        level.europa_unlock_ee endon( #"zm_quest_completed" );
    }
    
    level.pap_quest utility::ent_flag_wait( "zm_quest_completed" );
    level.var_759d027eca7a10d1 utility::ent_flag_wait( "zm_quest_completed" );
    
    if ( isdefined( var_ca908a6a83b8fb50 ) )
    {
        level utility::flag_wait( var_ca908a6a83b8fb50 );
    }
    
    if ( level zm_sat_firefly::function_24006873400b7a8() )
    {
        if ( !isdefined( level.zm_quests[ var_42d0d026ca87eb78 ] ) )
        {
            return;
        }
        
        if ( quest_step == #"hash_d7ed766c3c6c69cf" && !level.europa_unlock_ee.stabilizer_chip )
        {
            return;
        }
        
        if ( !zm_quest::function_73720cdf21c3cfd7( #"europa_unlock_quest", #"klaus_found" ) && quest_step == #"approach_viper" )
        {
            hud_data = function_8a4d3856c3cf09c8();
            level thread zm_quest::update_guidance( hud_data, var_42d0d026ca87eb78, #"find_klaus" );
        }
        else
        {
            level thread zm_quest::update_guidance( hud_data, var_42d0d026ca87eb78, quest_step );
        }
    }
    
    if ( isdefined( var_cdb665c03b873a33 ) )
    {
        level utility::flag_set( var_cdb665c03b873a33 );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0x3e1ace5, Offset: 0x21cb
// Size: 0x146
function function_9603d40ae36badd4( override_str_flag )
{
    level endon( #"game_ended" );
    
    if ( isdefined( override_str_flag ) )
    {
        level utility::flag_wait( override_str_flag );
    }
    else
    {
        level utility::flag_wait( "europa_first_activation_finished" );
    }
    
    foreach ( var_c5142e0d1342bef0 in level.europa_unlock_ee.summon_devices )
    {
        var_c5142e0d1342bef0.interact = interaction::register_interact( var_c5142e0d1342bef0, 64, &summon_used, &set_interact_hint, undefined, undefined, undefined, "HINT_BUTTON" );
        var_c5142e0d1342bef0 sethintonobstruction( "hide" );
        var_c5142e0d1342bef0 sethintdisplayrange( 64 );
        level.europa_unlock_ee.script_cost = 2000;
        var_c5142e0d1342bef0.script_currency = #"essence";
        var_c5142e0d1342bef0 setscriptablepartstate( "screen", "red" );
        var_c5142e0d1342bef0 setscriptablepartstate( "objective", "activated" );
        var_c5142e0d1342bef0 thread function_209d79ecfa55b44d();
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xafac160f, Offset: 0x2319
// Size: 0x351
function summon_used( player, half_buy )
{
    if ( level utility::flag( "disable_europa_interaction" ) )
    {
        return;
    }
    
    if ( !level.europa_unlock_ee.europa europa::is_activated() && !level utility::flag( "europa_is_recharging" ) )
    {
        if ( half_buy )
        {
            if ( player currency::can_afford( self.script_currency, int( level.europa_unlock_ee.script_cost / 2 ) ) && !level.europa_unlock_ee.var_6b6c1bfda2809bae )
            {
                half_cost = int( level.europa_unlock_ee.script_cost / 2 );
                level.europa_unlock_ee.script_cost -= half_cost;
                level.europa_unlock_ee.var_6b6c1bfda2809bae = 1;
                level.europa_unlock_ee.var_82715ba80990f81e = player;
                player currency::function_b5fe1e05c892a7f3( self.script_currency, half_cost );
                player playsoundtoplayer( "ui_zm_core_door_purchase_partial", player );
                player thread function_cfd7e9d343b2ce00();
                return;
            }
        }
        
        if ( player currency::can_afford( #"essence", level.europa_unlock_ee.script_cost ) )
        {
            player currency::function_b5fe1e05c892a7f3( self.script_currency, level.europa_unlock_ee.script_cost );
            player playsoundtoplayer( "ui_zm_core_door_purchase_success", player );
            params = spawnstruct();
            params.owner = player;
            
            if ( !params.owner )
            {
                iprintlnbold( "summon_used - Europa Owner Deleted!" );
                return;
            }
            
            if ( game_utility::function_21211f3255f8ea58() && !utility::flag( "europa_first_activation_finished" ) )
            {
                level utility::flag_set( "europa_first_activation_finished", params );
            }
            else
            {
                level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_cc6a196accc3d6bf", params );
                level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_5c619c99b9d2e4bb", params );
            }
            
            foreach ( var_c5142e0d1342bef0 in level.europa_unlock_ee.summon_devices )
            {
                var_c5142e0d1342bef0 thread function_e404ac536fed1113();
                var_c5142e0d1342bef0 thread function_209d79ecfa55b44d();
            }
            
            player thread function_cfd7e9d343b2ce00();
            level.europa_unlock_ee.script_cost = 2000;
            level.europa_unlock_ee.var_6b6c1bfda2809bae = 0;
            level.europa_unlock_ee.var_82715ba80990f81e = undefined;
        }
        else
        {
            player playsoundtoplayer( "ui_zm_core_door_purchase_deny", player );
        }
        
        return;
    }
    
    player playsoundtoplayer( "ui_zm_core_door_purchase_deny", player );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x1bd21e48, Offset: 0x2672
// Size: 0x3b
function function_e404ac536fed1113()
{
    level endon( #"game_ended" );
    level utility::flag_set( "sum_kls_delay" );
    wait 3;
    self setscriptablepartstate( "screen", "red" );
    level utility::flag_clear( "sum_kls_delay" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x68911075, Offset: 0x26b5
// Size: 0x123
function function_209d79ecfa55b44d()
{
    self notify( #"hash_9fedb705a04e2b82" );
    self endon( #"hash_9fedb705a04e2b82" );
    level endon( #"game_ended" );
    state = level.europa_unlock_ee.europa europa::is_on_chair() ? "green" : "red";
    self setscriptablepartstate( "screen", state );
    
    while ( true )
    {
        msg = level.europa_unlock_ee.europa utility::waittill_any_return( "europa_sit_on_chair", "europa_activated", "europa_recharge_finished" );
        
        switch ( msg )
        {
            case #"hash_20841f628a74516b":
                self setscriptablepartstate( "screen", "red" );
                break;
            case #"hash_a9c53fa48acd7922":
                level utility::flag_set( "europa_is_recharging" );
                self setscriptablepartstate( "screen", "red" );
                break;
            case #"hash_bc38a9527b35e674":
                level utility::flag_clear( "europa_is_recharging" );
                self setscriptablepartstate( "screen", "green" );
                break;
        }
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xb6416232, Offset: 0x27e0
// Size: 0x1e2
function set_interact_hint( interact, player )
{
    if ( player.interactions_disabled || level utility::flag( "disable_europa_interaction" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level.var_a93ba697bc9fda85 && !player.is_in_summon_radius && !level.europa_unlock_ee.var_6b6c1bfda2809bae )
    {
        player function_f39a2bb4a5f19185( interact );
    }
    
    hint_data = function_f8ad4dc8f114dc5a( interact, player );
    
    if ( utility::flag( "sum_kls_delay" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_492f94db590aab17:hint_data.var_492f94db590aab17, #altbuttoncallout:hint_data.altbuttoncallout, #interactable:hint_data.interactable, #icon_text_value:hint_data.icon_text_value, #var_776a268784e089af:hint_data.var_776a268784e089af, #buttoncallout:hint_data.buttoncallout, #icon:"ui_icon_zm_minimap_klaus", #aux_text:hint_data.aux_text, #description:hint_data.description, #title:hint_data.title, #params:[ level.europa_unlock_ee.script_cost ], #string:hint_data.var_ca8523ea008acd97, #type:"HINT_BUTTON" };
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x1447c444, Offset: 0x29ca
// Size: 0x3d9
function function_f8ad4dc8f114dc5a( interact, player )
{
    hint_data = {};
    hint_data.buttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY";
    hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
    hint_data.icon_text_value = level.europa_unlock_ee.script_cost;
    hint_data.interactable = 1;
    
    if ( isplayer( player ) )
    {
        if ( level.europa_unlock_ee.europa europa::is_activated() || !level.europa_unlock_ee.europa europa::is_on_chair() )
        {
            hint_data.var_ca8523ea008acd97 = &"";
            hint_data.var_776a268784e089af = "";
            hint_data.title = &"shared_hintstrings/europa_activated_title";
            hint_data.description = &"shared_hintstrings/europa_already_summoned";
            hint_data.interactable = 0;
            return hint_data;
        }
        
        if ( level utility::flag( "europa_is_recharging" ) )
        {
            hint_data.var_ca8523ea008acd97 = &"";
            hint_data.var_776a268784e089af = &"shared_hintstrings/europa_cooldown_time";
            cool_down_period = level.europa_unlock_ee.europa europa::function_b85fde7cbf122619( "recharge" );
            cool_down_start_time = level.europa_unlock_ee.europa.europa.cooldowns[ "recharge" ] / 1000;
            cool_down_end_time = cool_down_start_time + cool_down_period;
            hint_data.icon_text_value = int( floor( cool_down_end_time - gettime() / 1000 ) );
            hint_data.title = &"shared_hintstrings/europa_recharging_title";
            hint_data.description = &"shared_hintstrings/europa_not_available_aux";
            hint_data.interactable = 0;
            return hint_data;
        }
        
        if ( player currency::can_afford( #"essence", level.europa_unlock_ee.script_cost ) )
        {
            hint_data.var_ca8523ea008acd97 = &"";
            
            if ( level.var_a93ba697bc9fda85 && !level.europa_unlock_ee.var_6b6c1bfda2809bae )
            {
                hint_data.altbuttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY_HALF";
                hint_data.var_492f94db590aab17 = 1;
                player setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 1 );
                player setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 0 );
            }
        }
        else if ( level.var_a93ba697bc9fda85 && player currency::can_afford( interact.script_currency, 1000 ) && !level.europa_unlock_ee.var_6b6c1bfda2809bae )
        {
            hint_data.altbuttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY_HALF";
            hint_data.var_492f94db590aab17 = 1;
            player setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 1 );
            player setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 1 );
        }
        else
        {
            hint_data.var_ca8523ea008acd97 = &"";
            hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
            hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
            hint_data.icon_text_value = level.europa_unlock_ee.script_cost;
            hint_data.interactable = 0;
        }
        
        hint_data.title = &"shared_hintstrings/europa_ready";
        hint_data.description = &"shared_hintstrings/europa_ready_to_summon";
    }
    
    return hint_data;
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1, eflags: 0x4
// Checksum 0x23b153db, Offset: 0x2dac
// Size: 0x5f
function private function_f39a2bb4a5f19185( summon_device )
{
    if ( !is_in_summon_radius( summon_device ) )
    {
        return;
    }
    
    self.is_in_summon_radius = 1;
    thread function_1af47c82061e99a8( summon_device );
    thread function_ea570d6a951a7cff( summon_device );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "try_partial_summon_kbm", "+reload" );
        self notifyonplayercommand( "try_partial_summon_gpad", "-usereload" );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1, eflags: 0x4
// Checksum 0xe3a40a1b, Offset: 0x2e13
// Size: 0x44
function private function_1af47c82061e99a8( summon_device )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ef6f3ba1a4094b15" );
    
    while ( is_in_summon_radius( summon_device ) )
    {
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1, eflags: 0x4
// Checksum 0x3ef339cc, Offset: 0x2e5f
// Size: 0xc3
function private function_ea570d6a951a7cff( summon_device )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_398558f16bf47058" );
    
    while ( true )
    {
        notifies = [ "try_partial_summon_kbm", "try_partial_summon_gpad" ];
        event = utility::waittill_any_in_array_return( notifies );
        isvalidinput = 0;
        
        if ( event == "try_partial_summon_kbm" && !self usinggamepad() )
        {
            isvalidinput = 1;
        }
        
        if ( event == "try_partial_summon_gpad" && self usinggamepad() )
        {
            isvalidinput = 1;
        }
        
        if ( isvalidinput && isdefined( summon_device ) )
        {
            summon_device summon_used( self, 1 );
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0, eflags: 0xc
// Checksum 0x8c1dd153, Offset: 0x2f2a
// Size: 0x7d
function private function_cfd7e9d343b2ce00()
{
    self notify( #"hash_7230a520010fb9cb" );
    self endon( #"hash_7230a520010fb9cb" );
    self.is_in_summon_radius = 0;
    self setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 0 );
    self setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 0 );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "try_partial_summon_kbm", "+reload" );
        self notifyonplayercommandremove( "try_partial_summon_gpad", "-usereload" );
    }
    
    self notify( #"hash_ef6f3ba1a4094b15" );
    self notify( #"hash_398558f16bf47058" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1, eflags: 0x4
// Checksum 0xd1bf2a8a, Offset: 0x2faf
// Size: 0x44
function private is_in_summon_radius( summon_device )
{
    if ( isdefined( summon_device ) && distancesquared( self.origin, summon_device.origin ) <= squared( 90 ) )
    {
        return 1;
    }
    
    thread function_cfd7e9d343b2ce00();
    return 0;
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0xacb3c907, Offset: 0x2ffb
// Size: 0x193
function function_fe56a90e8acb3a11( params )
{
    v_drop = utility::function_7afe366c29a77c34( self.origin, 32 );
    v_drop = utility::function_5918594658d3ffba( v_drop, 100 );
    var_5f8b52b422edf55f = utility::getstruct( "stabilizer_fallback_loc", "script_noteworthy" );
    fallback_loc_start = utility::function_7afe366c29a77c34( var_5f8b52b422edf55f.origin, 64 );
    fallback_loc_end = utility::drop_to_ground( fallback_loc_start + ( 0, 0, 100 ) );
    droppeditem = undefined;
    
    if ( zone_manager::function_65305a611c6226d9( v_drop ) )
    {
        droppeditem = common_item::function_47324f290423b2d1( %"hash_1e10a02191886472", self.origin, v_drop, undefined, 1 );
        level thread function_cd746d8bd7e7b2c0( v_drop, v_drop );
    }
    else
    {
        droppeditem = common_item::function_47324f290423b2d1( %"hash_1e10a02191886472", fallback_loc_start, fallback_loc_end, undefined, 1 );
        level thread function_cd746d8bd7e7b2c0( fallback_loc_start, fallback_loc_end );
    }
    
    hud_data = function_288fb21b76dbbe94( droppeditem, 30, undefined, droppeditem );
    level utility::delaythread( 0.5, &function_d8d8737d2a3fc57, hud_data, #"hash_7f40fbc392cb9208", #"hash_d7ed766c3c6c69cf", "chip_objective_updated" );
    callback::remove( "on_zombie_ai_killed", &function_fe56a90e8acb3a11 );
    utility::flag_set( "viper_mini_killed" );
    zm_quest::function_4eefe6de31f5ddab( #"europa_unlock_quest", #"viper_mini_alive", 0 );
    level.europa_unlock_ee.stabilizer_chip = droppeditem;
    level.europa_unlock_ee.viper = undefined;
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x2dd5bb2a, Offset: 0x3196
// Size: 0x9c
function setup_find_klaus( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "europa_assets_ready" );
    
    if ( !level callback::exists( "on_round_start", &viper_box_state_watcher ) )
    {
        level callback::add( "on_round_start", &viper_box_state_watcher );
    }
    
    level thread function_58f91c86af6a0e3c();
    hud_data = function_8a4d3856c3cf09c8();
    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"find_klaus" );
    utility::flag_wait_any( "klaus_found", "viper_box_ready" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xe9f9e423, Offset: 0x323a
// Size: 0x5c
function cleanup_find_klaus( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_wait( "europa_assets_ready" );
        
        if ( !level callback::exists( "on_round_start", &viper_box_state_watcher ) )
        {
            level callback::add( "on_round_start", &viper_box_state_watcher );
        }
        
        level thread function_58f91c86af6a0e3c();
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0, eflags: 0x4
// Checksum 0xb749735a, Offset: 0x329e
// Size: 0xa4
function private function_8a4d3856c3cf09c8()
{
    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.europa_chair.origin + ( -20, 175, 0 ), 70, undefined, level.europa_unlock_ee.unlock_device );
    radius_marker = [ level.europa_unlock_ee.europa_chair.origin + ( -20, 175, 0 ), undefined, 325 ];
    hud_data[ hud_data.size ] = radius_marker;
    return hud_data;
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0xee57c7d6, Offset: 0x334b
// Size: 0x3d5
function viper_box_state_watcher( params )
{
    round_num = zm_utility::get_round_number();
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        switch ( round_num )
        {
            case 1:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "two_lights" );
                break;
            case 2:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "three_lights" );
                break;
            case 3:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "four_lights" );
                break;
            case 4:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "five_lights" );
                break;
            case 5:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "six_lights" );
                break;
            case 6:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "seven_lights" );
                break;
            case 7:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "eight_lights" );
                level utility::flag_set( "viper_box_ready" );
                break;
            default:
                level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "eight_lights" );
                level utility::flag_set( "viper_box_ready" );
                break;
        }
        
        return;
    }
    
    switch ( round_num )
    {
        case 1:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "one_light" );
            break;
        case 2:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "two_lights" );
            break;
        case 3:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "three_lights" );
            break;
        case 4:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "four_lights" );
            break;
        case 5:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "five_lights" );
            break;
        case 6:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "six_lights" );
            break;
        case 7:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "seven_lights" );
            break;
        case 8:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "eight_lights" );
            level utility::flag_set( "viper_box_ready" );
            break;
        default:
            level.europa_unlock_ee.viper_box utility::function_32b24db3127bff40( "box_indicator", "eight_lights" );
            level utility::flag_set( "viper_box_ready" );
            break;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x9c886156, Offset: 0x3728
// Size: 0x215
function function_58f91c86af6a0e3c()
{
    level endon( #"game_ended" );
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"europa_unlock_quest", #"klaus_found" ) == 1 )
    {
        level utility::flag_set( "klaus_found" );
        return;
    }
    
    var_4603f846f034faa0 = getent( "europa_unlock_device", "script_noteworthy" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distance( player.origin, var_4603f846f034faa0.origin ) < 200 )
            {
                level utility::flag_set( "klaus_found" );
                level zm_quest::function_4eefe6de31f5ddab( #"europa_unlock_quest", #"klaus_found", 1 );
                level thread find_klaus_vo();
                europa_unlock_quest = zm_quest::get_quest( #"europa_unlock_quest" );
                quest_step = europa_unlock_quest.steps[ europa_unlock_quest.var_7be076c9078045aa ];
                
                if ( quest_step.ref == #"approach_viper" )
                {
                    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.viper_box.origin + ( -200, -450, 0 ), 20, 1200 );
                    marker_array = [ level.europa_unlock_ee.viper_box.origin + ( -200, -450, 0 ), 350 ];
                    hud_data[ hud_data.size ] = marker_array;
                    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"approach_viper" );
                }
                
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x5830aa37, Offset: 0x3945
// Size: 0x12b
function find_klaus_vo()
{
    level endon( #"game_ended" );
    level endon( #"viper_box_ready" );
    
    if ( utility::flag( "viper_box_ready" ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( level.europa_unlock_ee.europa )
        {
            foreach ( player in level.players )
            {
                if ( distance( player.origin, level.europa_unlock_ee.europa.origin ) < 500 && !utility::flag( "find_klaus_vo_in_cd" ) )
                {
                    level.europa_unlock_ee.europa dialogue::say( #"hash_9ba883c456e444d9" );
                    level thread function_41e167fcfbc730ee();
                    break;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x9d45907e, Offset: 0x3a78
// Size: 0x35
function function_41e167fcfbc730ee()
{
    level endon( #"game_ended" );
    level endon( #"viper_box_ready" );
    utility::flag_set( "find_klaus_vo_in_cd" );
    wait 45;
    utility::flag_clear( "find_klaus_vo_in_cd" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x3ae17139, Offset: 0x3ab5
// Size: 0xe9
function setup_approach_viper( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "europa_assets_ready" );
    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.viper_box.origin + ( -200, -450, 0 ), 20, 1200 );
    marker_array = [ level.europa_unlock_ee.viper_box.origin + ( -200, -450, 0 ), 350 ];
    hud_data[ hud_data.size ] = marker_array;
    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"approach_viper" );
    level thread function_d5a1170b9b08e60f();
    level utility::flag_wait( "viper_box_found" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xd6824c7, Offset: 0x3ba6
// Size: 0x2d
function cleanup_approach_viper( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "viper_box_found" );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x4338c5e4, Offset: 0x3bdb
// Size: 0xca
function function_d5a1170b9b08e60f()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distance( player.origin, level.europa_unlock_ee.viper_box.origin ) < 500 )
            {
                level utility::flag_set( "viper_box_found" );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x84390e0, Offset: 0x3cad
// Size: 0x1f2
function setup_wait_viper( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "europa_assets_ready" );
    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.viper, 120, undefined, level.europa_unlock_ee.viper );
    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"hash_e6d2991f8688bd9b" );
    
    if ( isdefined( level.europa_unlock_ee ) && isdefined( level.europa_unlock_ee.viper_box ) )
    {
        if ( !level.europa_unlock_ee.viper_box utility::function_9f2c41c1dcc8c94( "box_indicator", "ready" ) )
        {
            level utility::flag_wait( "viper_box_ready" );
        }
    }
    
    if ( isdefined( level.europa_unlock_ee ) && isdefined( level.europa_unlock_ee.viper_box ) )
    {
        level.europa_unlock_ee.viper_box thread function_a45149e64567d3b( 800 );
    }
    
    level utility::flag_wait( "viper_activated" );
    a_players = getplayersinradius( level.europa_unlock_ee.viper_box.origin, 1500 );
    a_players = arrayrandomize( a_players );
    
    foreach ( player in a_players )
    {
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d3a60fe73f1eb1f1", #"bc_flavor_player_negative" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xd511249b, Offset: 0x3ea7
// Size: 0x483
function cleanup_wait_viper( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_wait( "europa_assets_ready" );
        
        while ( !isdefined( level.europa_unlock_ee.viper ) )
        {
            waitframe();
        }
        
        round_num = zm_utility::get_round_number();
        level.europa_unlock_ee.viper zombie_utils::set_zombie_round_difficulty( round_num );
        
        if ( level.europa_unlock_ee.viper isscriptable() )
        {
            level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "base", "base_on" );
            level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "icon", "active" );
            level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "tesla_coil_left", "on" );
            level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "tesla_coil_right", "on" );
        }
        
        level.europa_unlock_ee.viper.var_2fc3a5fb762afb6e = 0;
        level.europa_unlock_ee.viper function_66dc8b6ae969f66d( 0 );
        
        if ( !b_save_restored )
        {
            level.europa_unlock_ee.var_163444e1336b6859 scene::play( [ level.europa_unlock_ee.viper, level.europa_unlock_ee.viper_box ], "jump_out", "sat_cin_zm_viper_break_out" );
        }
        else
        {
            level.europa_unlock_ee.var_163444e1336b6859 scene::stop_object( "Actor 1" );
            level.europa_unlock_ee.viper val::reset_all( "scene_shot" );
            level.europa_unlock_ee.var_163444e1336b6859 thread scene::play( level.europa_unlock_ee.viper_box, "jump_out", "sat_cin_zm_viper_break_out" );
            wait level.framedurationseconds;
            s_viper_respawn_loc = utility::getstruct( "viper_respawn_loc", "script_noteworthy" );
            level.europa_unlock_ee.viper forceteleport( s_viper_respawn_loc.origin, s_viper_respawn_loc.angles );
        }
        
        level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "show_healthbar", 1 );
        level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "damage", 1 );
        level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "death", 1 );
        level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_dismember", 1 );
        level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_vo", 1 );
        level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_aim_assist", 1 );
        level.europa_unlock_ee.viper.ignoreme = 0;
        level.europa_unlock_ee.viper.b_ignore_water_check = 0;
        level.europa_unlock_ee.viper.var_2902ca09e32bd7d8 = 0;
        level.europa_unlock_ee.viper.var_7ee152b43c7188e1 = 0;
        level.europa_unlock_ee.viper.b_ignore_cleanup = 0;
        level.europa_unlock_ee.viper.b_ignore_death_perception = 0;
        level.europa_unlock_ee.viper.var_be5ccf6d16f6b59e = 0;
        utility::flag_set( "viper_activated" );
        
        if ( zm_quest::function_73720cdf21c3cfd7( #"europa_unlock_quest", #"viper_mini_alive" ) )
        {
            wait level.framedurationseconds;
            level.europa_unlock_ee.viper kill();
        }
        
        return;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x7f3dcd18, Offset: 0x4332
// Size: 0xc3
function function_b9d25db9d0aa4957( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"europa_unlock_quest", #"viper_mini_alive" ) )
    {
        hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.viper, 120, undefined, level.europa_unlock_ee.viper );
        level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"hash_62467328fcb57cc6" );
        zm_quest::function_4eefe6de31f5ddab( #"europa_unlock_quest", #"viper_mini_alive", 0 );
    }
    
    level utility::flag_wait( "viper_mini_killed" );
    level thread function_e7691528e83e9e4e();
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0, eflags: 0x4
// Checksum 0x5f6cbcf4, Offset: 0x43fd
// Size: 0xdf
function private function_e7691528e83e9e4e()
{
    viper_kill_origin = level.europa_unlock_ee.viper_mini.origin;
    wait 2;
    
    if ( viper_kill_origin )
    {
        a_players = getplayersinradius( viper_kill_origin, 1500 );
        a_players = arrayrandomize( a_players );
        
        foreach ( player in a_players )
        {
            var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_7ffc0d7cb027ffc3", #"bc_flavor_player_positive" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x956603bc, Offset: 0x44e4
// Size: 0xbd
function function_37e1c01192595378( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_wait( "europa_assets_ready" );
        var_ca47e1218488d906 = level.europa_unlock_ee.viper;
        
        if ( isdefined( level.europa_unlock_ee.viper_mini ) )
        {
            var_ca47e1218488d906 = level.europa_unlock_ee.viper_mini;
        }
        else
        {
            var_ca47e1218488d906.var_c3746c711044489d = 1;
            var_ca47e1218488d906 callback::add( "on_zombie_ai_killed", &function_fe56a90e8acb3a11 );
        }
        
        utility::flag_set( "viper_mini_killed" );
        var_ca47e1218488d906.nocorpse = 1;
        var_ca47e1218488d906 kill();
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xd045b39, Offset: 0x45a9
// Size: 0x2e
function function_4277654187df36e2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "got_stabilizer_chip" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xe0a91330, Offset: 0x45df
// Size: 0x88
function function_f61064fafcd30089( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"europa_unlock", 0, #"stage_1", 1, 1 );
        
        if ( isdefined( level.europa_unlock_ee.stabilizer_chip ) )
        {
            level.europa_unlock_ee.stabilizer_chip freescriptable();
        }
        
        level utility::flag_set( "chip_objective_updated" );
        level utility::flag_set( "got_stabilizer_chip" );
        return;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0xca87b5d2, Offset: 0x466f
// Size: 0x4c3
function function_a45149e64567d3b( radius )
{
    level endon( #"game_ended" );
    level endon( #"viper_activated" );
    radiussq = radius * radius;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( self.origin, player.origin ) <= radiussq && distance2dsquared( level.wonder_veh.origin, self.origin ) >= squared( 300 ) )
            {
                if ( !isdefined( level.europa_unlock_ee ) || !isdefined( level.europa_unlock_ee.viper ) )
                {
                    continue;
                }
                
                hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.viper, 120, undefined, level.europa_unlock_ee.viper );
                level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"hash_62467328fcb57cc6" );
                level.europa_unlock_ee.viper.var_2fc3a5fb762afb6e = 0;
                level.europa_unlock_ee.viper function_66dc8b6ae969f66d( 0 );
                
                if ( level.europa_unlock_ee.viper isscriptable() )
                {
                    level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "base", "base_on" );
                    level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "icon", "active" );
                    level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "tesla_coil_left", "on" );
                    level.europa_unlock_ee.viper utility::function_32b24db3127bff40( "tesla_coil_right", "on" );
                }
                
                level.europa_unlock_ee.var_163444e1336b6859 scene::play( [ level.europa_unlock_ee.viper, level.europa_unlock_ee.viper_box ], "jump_out", "sat_cin_zm_viper_break_out" );
                level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "show_healthbar", 1 );
                level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "damage", 1 );
                level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "death", 1 );
                level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_dismember", 1 );
                level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_vo", 1 );
                level.europa_unlock_ee.viper val::set( "europa_unlock_ee", "allow_aim_assist", 1 );
                level.europa_unlock_ee.viper.ignoreme = 0;
                level.europa_unlock_ee.viper.b_ignore_water_check = 0;
                level.europa_unlock_ee.viper.var_2902ca09e32bd7d8 = 0;
                level.europa_unlock_ee.viper.var_7ee152b43c7188e1 = 0;
                level.europa_unlock_ee.viper.b_ignore_cleanup = 0;
                level.europa_unlock_ee.viper.b_ignore_death_perception = 0;
                level.europa_unlock_ee.viper.var_be5ccf6d16f6b59e = 0;
                level.europa_unlock_ee.viper.var_dea940150826c88d = 0;
                round_num = zm_utility::get_round_number();
                level.europa_unlock_ee.viper zombie_utils::set_zombie_round_difficulty( round_num );
                utility::flag_set( "viper_activated" );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xc85b2aff, Offset: 0x4b3a
// Size: 0xb9
function function_cd746d8bd7e7b2c0( loc_start, loc_end )
{
    wait 60;
    
    if ( !utility::flag( "got_stabilizer_chip" ) )
    {
        if ( isdefined( level.europa_unlock_ee.stabilizer_chip ) )
        {
            level.europa_unlock_ee.stabilizer_chip freescriptable();
        }
        
        droppeditem = common_item::function_47324f290423b2d1( %"hash_1e10a02191886472", loc_start, loc_end, undefined, 1 );
        hud_data = function_288fb21b76dbbe94( droppeditem, 30, undefined, droppeditem );
        level utility::delaythread( 0.5, &function_d8d8737d2a3fc57, hud_data, #"hash_7f40fbc392cb9208", #"hash_d7ed766c3c6c69cf", "chip_objective_updated" );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0xf1c0b618, Offset: 0x4bfb
// Size: 0xf9
function on_quest_item_pickup( params )
{
    itembundle = params.bundle;
    item = params.scriptable;
    player = params.player;
    
    switch ( itembundle.ref )
    {
        case #"hash_f676d96a49eead19":
            zm_quest::function_b57dfe9625966b0b( #"europa_unlock", 0, #"stage_1", 1, 1 );
            
            if ( isdefined( player ) )
            {
                zm_quest::show_splash_item_picked_up( #"europa_unlock", #"stage_1", 1, player );
            }
            
            playsoundatpos( item.origin, #"hash_accb3360749c2f6" );
            level utility::flag_set( "got_stabilizer_chip" );
            wait 1;
            
            if ( player )
            {
                player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_ea6ac83d2ea722a1", #"hash_5212ed7ec42f115a" );
            }
            
            break;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xc289f9eb, Offset: 0x4cfc
// Size: 0x191
function setup_stabilize_europa( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "europa_assets_ready" );
    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.unlock_device.origin + ( -3, 4, 0 ), 30, undefined, level.europa_unlock_ee.unlock_device );
    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"stabilize_europa", undefined, "chip_objective_updated" );
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_assets( "firefly_europa_quest", "model", "sat_zm_torture_chair_conect_console_fxanim", 2000 );
    }
    
    utility::flag_wait( "stabilizer_chip_install_complete" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 thread scene::play( level.europa_unlock_ee.var_bdd6f8bc19ccd8d7, "looping_idle_1", "sat_cin_zm_europa_chained" );
    level.europa_unlock_ee.europa setscriptablepartstate( "madness", "deactivated" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xd50b186a, Offset: 0x4e95
// Size: 0xdf
function cleanup_stabilize_europa( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.europa_unlock_ee.stabilizer_chip_user = level.players[ 0 ];
        level.europa_unlock_ee.unlock_chip show();
        level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "require_restart" );
        utility::flag_set( "stabilizer_chip_install_complete" );
        level.europa_unlock_ee.var_15bcb3e0fb9f42a7 thread scene::play( level.europa_unlock_ee.var_bdd6f8bc19ccd8d7, "looping_idle_1", "sat_cin_zm_europa_chained" );
        level.europa_unlock_ee.europa setscriptablepartstate( "madness", "deactivated" );
        return;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0x2f053e68, Offset: 0x4f7c
// Size: 0x33
function use_europa_unlock_device( player )
{
    if ( utility::flag( "got_stabilizer_chip" ) && !utility::flag( "stabilizer_chip_install_complete" ) )
    {
        on_stabilizer_chip_used( player );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0xc15ad2ce, Offset: 0x4fb7
// Size: 0x130
function function_d6496090aab8d3c( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( !utility::flag( "got_stabilizer_chip" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( utility::flag( "stabilizer_chip_install_complete" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( utility::flag( "stabilizer_chip_used" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"zm_sat_firefly/europa_unlock_setp_stabilize_europa_hint", #type:"HINT_NOICON" };
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0x56fe7b3, Offset: 0x50f0
// Size: 0xfe
function on_stabilizer_chip_used( player )
{
    utility::flag_set( "stabilizer_chip_used" );
    level.europa_unlock_ee.unlock_chip show();
    level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "installing" );
    level.europa_unlock_ee.stabilizer_chip_user = player;
    
    if ( player )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_26c945e9027fdf91", #"hash_5212ed7ec42f115a" );
    }
    
    wait 5;
    utility::flag_set( "stabilizer_chip_install_complete" );
    level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "require_restart" );
    
    if ( isdefined( level.europa_unlock_ee.unlock_device.interact ) )
    {
        level.europa_unlock_ee.unlock_device.interact zm_quest::function_9170db4686f796e2();
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x85ac1b97, Offset: 0x51f6
// Size: 0x31d
function setup_reboot_europa( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "europa_assets_ready" );
    level.europa_unlock_ee.europa_chair thread function_aeab4ef4278cb26d();
    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.europa.origin + ( 5, 8, 0 ), 85, undefined, level.europa_unlock_ee.europa );
    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"reboot_europa", undefined, "chip_objective_updated" );
    level utility::flag_wait( "reboot_europa_success" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"awaken" );
    playfxontag( utility::getfx( "europa_stun" ), level.europa_unlock_ee.europa, "j_head" );
    wait 3;
    stopfxontag( utility::getfx( "europa_stun" ), level.europa_unlock_ee.europa, "j_head" );
    hud_data = function_288fb21b76dbbe94( level.europa_unlock_ee.europa.origin + ( 5, 8, 0 ), 85, undefined, level.europa_unlock_ee.europa );
    level thread function_d8d8737d2a3fc57( hud_data, #"hash_7f40fbc392cb9208", #"hash_d05d946dd29e0d7d" );
    utility::delaythread( 14, &zm_quest::function_b5d75b34f712db9a );
    level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "install_complete" );
    level thread function_91ffcd5de381188f();
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::play( level.europa_unlock_ee.var_bdd6f8bc19ccd8d7, "first_activated", "sat_cin_zm_europa_chained" );
    level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::stop_object( "Actor 1" );
    waitframe();
    params = spawnstruct();
    params.owner = level.europa_unlock_ee.stabilizer_chip_user;
    
    if ( !params.owner )
    {
        iprintlnbold( "setup_reboot_europa - Europa Owner Deleted!" );
        level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_5a10c74557470ade" );
    }
    else
    {
        level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_cc6a196accc3d6bf", params );
    }
    
    level utility::flag_set( "europa_first_activation_finished" );
    
    if ( level.europa_unlock_ee.stabilizer_chip_user )
    {
        level.europa_unlock_ee.stabilizer_chip_user namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_dc71102e59bb8035", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 2
// Checksum 0x382ecf12, Offset: 0x551b
// Size: 0x301
function cleanup_reboot_europa( b_skipped, b_save_restored )
{
    level callback::remove( "on_zombie_ai_killed", &function_63a425e091580c3f );
    
    if ( b_skipped || b_save_restored )
    {
        level thread function_d8d8737d2a3fc57( undefined, #"hash_7f40fbc392cb9208", #"reboot_europa", undefined, "chip_objective_updated" );
        level.europa_unlock_ee.unlock_device setscriptablepartstate( "screen", "install_complete" );
        level.europa_unlock_ee.europa setscriptablepartstate( "madness", "deactivated" );
        
        if ( b_save_restored || getdvarint( @"hash_a6558a9705dc2754", 0 ) )
        {
            level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::stop_object( "Actor 1" );
            level.europa_unlock_ee.europa val::reset_all( "scene_shot" );
            level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_5a10c74557470ade", "none" );
            level.europa_unlock_ee.var_15bcb3e0fb9f42a7 thread scene::play( level.europa_unlock_ee.europa_chair, "first_activated", "sat_cin_zm_europa_chained" );
            level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::skip( "first_activated" );
            
            if ( !getdvarint( @"hash_a6558a9705dc2754", 0 ) )
            {
                level utility::flag_set( "reboot_europa_success" );
                level utility::flag_set( "europa_first_activation_finished" );
                level.europa_unlock_ee.europa utility::delay_notify( level.framedurationseconds, "europa_deactivated" );
                return;
            }
        }
        else
        {
            level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::play( level.europa_unlock_ee.var_bdd6f8bc19ccd8d7, "first_activated", "sat_cin_zm_europa_chained" );
            level.europa_unlock_ee.var_15bcb3e0fb9f42a7 scene::stop_object( "Actor 1" );
            waitframe();
        }
        
        params = spawnstruct();
        params.owner = level.europa_unlock_ee.stabilizer_chip_user;
        
        if ( !params.owner )
        {
            iprintlnbold( "cleanup_reboot_europa - Europa Owner Deleted!" );
            level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_5a10c74557470ade", "none" );
        }
        else
        {
            level.europa_unlock_ee.europa utility::callsharedfunc( #"europa", #"hash_cc6a196accc3d6bf", params );
        }
        
        level utility::flag_set( "reboot_europa_success" );
        level utility::flag_set( "europa_first_activation_finished" );
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        function_a7ba43e1369c1825();
    }
    
    iprintlnbold( "Reboot Europa Success!" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0, eflags: 0x4
// Checksum 0x8ec1c720, Offset: 0x5824
// Size: 0x1d2
function private function_a7ba43e1369c1825()
{
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"find_klaus" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"approach_viper" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"hash_e6d2991f8688bd9b" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"hash_62467328fcb57cc6" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"hash_d7ed766c3c6c69cf" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"stabilize_europa" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"reboot_europa" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, #"hash_7f40fbc392cb9208", #"hash_d05d946dd29e0d7d" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"find_klaus" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"approach_viper" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"hash_e6d2991f8688bd9b" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"hash_62467328fcb57cc6" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"hash_d7ed766c3c6c69cf" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"stabilize_europa" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"reboot_europa" );
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"hash_7f40fbc392cb9208", #"hash_d05d946dd29e0d7d" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x5fa9bcab, Offset: 0x59fe
// Size: 0xca
function function_12951809290cbbc()
{
    playfxontag( utility::getfx( "europa_unlock_torso" ), self, "j_spine4" );
    waitframe();
    playfxontag( utility::getfx( "europa_unlock_arms" ), self, "j_shouldertwist_le" );
    playfxontag( utility::getfx( "europa_unlock_arms" ), self, "j_shouldertwist_ri" );
    playfxontag( utility::getfx( "europa_unlock_arms" ), self, "j_elbow_le" );
    playfxontag( utility::getfx( "europa_unlock_arms" ), self, "j_elbow_ri" );
    waitframe();
    playfxontag( utility::getfx( "europa_unlock_legs" ), self, "j_hip_le" );
    playfxontag( utility::getfx( "europa_unlock_legs" ), self, "j_hip_ri" );
    playfxontag( utility::getfx( "europa_unlock_legs" ), self, "j_knee_le" );
    playfxontag( utility::getfx( "europa_unlock_legs" ), self, "j_knee_ri" );
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0xf2ebbce1, Offset: 0x5ad0
// Size: 0x18e
function function_aeab4ef4278cb26d()
{
    level endon( #"game_ended" );
    level endon( #"reboot_europa_success" );
    self.impact_num = 0;
    self.dmg_trigger = getent( "europa_t_d", #targetname );
    self.var_7ccf3c26aa3522cb = 0;
    
    while ( true )
    {
        self.dmg_trigger waittill( #"damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( objweapon ) && objweapon.basename == "sat_concussion_grenade_zm" && type == "MOD_GRENADE_SPLASH" )
        {
            curr_time = gettime();
            
            if ( curr_time - self.var_7ccf3c26aa3522cb >= utility::function_4b74c15943231980( 2.5 ) )
            {
                self.var_7ccf3c26aa3522cb = curr_time;
                self.impact_num = 0;
            }
            
            self.impact_num++;
        }
        
        if ( self.impact_num >= 2 )
        {
            self.dmg_trigger delete();
            level utility::flag_set( "reboot_europa_success" );
            return;
        }
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0x3bb9949c, Offset: 0x5c66
// Size: 0x137
function function_e077374194abd515( radius )
{
    level endon( #"game_ended" );
    level endon( #"reboot_europa_success" );
    radiussq = radius * radius;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            distancesq = distance2dsquared( self.origin, player.origin );
            
            if ( distancesq <= radiussq && player utility::ent_flag( "tesla_storm_active" ) )
            {
                player.var_58d346226bf188f6 = playfxontagsbetweenclients( utility::getfx( "tesla_storm_beam_effect" ), player, "j_spineupper", self, "tag_origin" );
                player.var_58d346226bf188f6 utility::delaycall( 3, &delete );
                level utility::flag_set( "reboot_europa_success" );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0xda8cbbf5, Offset: 0x5da5
// Size: 0x1a6
function function_a1cad9d303f1f2b()
{
    level endon( #"game_ended" );
    level endon( #"reboot_europa_success" );
    self setcandamage( 1 );
    self.impact_num = 0;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isdefined( objweapon ) && objweapon.basename == "sat_shock_stick_zm" && ( !isdefined( self.last_inflictor ) || inflictor != self.last_inflictor ) )
        {
            while ( isdefined( inflictor ) )
            {
                if ( !inflictor utility::function_9f2c41c1dcc8c94( "beacon", "active" ) )
                {
                    waitframe();
                    continue;
                }
                
                break;
            }
            
            if ( !isdefined( inflictor ) )
            {
                continue;
            }
            
            inflictor setscriptablepartstate( "electric", "active", 0 );
            inflictor setscriptablepartstate( "detonate", "detonate", 0 );
            inflictor thread shock_stick::function_1d426c8b1b9484bb();
            self.last_inflictor = inflictor;
            self.impact_num++;
            utility::delaythread( 5, &do_minus );
        }
        
        if ( self.impact_num >= 2 )
        {
            level utility::flag_set( "reboot_europa_success" );
            return;
        }
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x89060396, Offset: 0x5f53
// Size: 0xc
function do_minus()
{
    self.impact_num--;
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 1
// Checksum 0x9b21a55c, Offset: 0x5f67
// Size: 0xf5
function function_63a425e091580c3f( params )
{
    if ( isagent( self ) && ( utility::ent_flag( "deadwire_stun_kill" ) || utility::ent_flag( "deadwire_stunned" ) ) && isplayer( params.eattacker ) )
    {
        var_c5142e0d1342bef0 = level.europa_unlock_ee.unlock_device;
        distancesq = distance2dsquared( var_c5142e0d1342bef0.origin, self.origin );
        
        if ( distancesq < 22500 )
        {
            var_c5142e0d1342bef0.e_beam_europa = playfxontagsbetweenclients( utility::getfx( "tesla_storm_beam_effect" ), self.deadwireorb, "tag_origin", var_c5142e0d1342bef0, "tag_origin" );
            var_c5142e0d1342bef0.e_beam_europa utility::delaycall( 3, &delete );
            level utility::flag_set( "reboot_europa_success" );
            level callback::remove( "on_zombie_ai_killed", &function_63a425e091580c3f );
        }
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest
// Params 0
// Checksum 0x201783c6, Offset: 0x6064
// Size: 0x34
function function_91ffcd5de381188f()
{
    level endon( #"game_ended" );
    wait 3;
    level.europa_unlock_ee.europa dialogue::say( #"hash_86f751121b4558ab" );
}

/#

    // Namespace zm_sat_firefly_europa_unlock_quest
    // Params 0
    // Checksum 0xff431a70, Offset: 0x60a0
    // Size: 0x2f, Type: dev
    function function_cf059f0f6284a13a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x40>", "<dev string:x4c>", &function_fe2665363a3b6327, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_europa_unlock_quest
    // Params 1
    // Checksum 0x5c1107fc, Offset: 0x60d7
    // Size: 0x7c, Type: dev
    function function_fe2665363a3b6327( params )
    {
        playfxontag( utility::getfx( "<dev string:x6b>" ), level.europa_unlock_ee.unlock_device, "<dev string:x88>" );
        playfxontag( utility::getfx( "<dev string:x93>" ), level.europa_unlock_ee.unlock_wire, "<dev string:x88>" );
        wait 1;
        level.europa_unlock_ee.europa function_12951809290cbbc();
    }

#/
