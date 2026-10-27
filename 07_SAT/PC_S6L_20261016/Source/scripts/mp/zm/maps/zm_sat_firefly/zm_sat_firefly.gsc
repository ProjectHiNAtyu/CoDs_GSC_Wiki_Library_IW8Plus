// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly.gsc  (hash_1858eec3c7a0a3ef.gscc) (size: 22568 Bytes / 0x5828 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6b875c8 (4139283912)
// size ...... 22568 (0x5828)
// includes .. 28  (offset: 0x4d20)
// strings ... 186 (offset: 0x4e00)
// dev strs .. 0   (offset: 0x5828)
// exports ... 38  (offset: 0x37c8)
// cseg ...... 0x10e4 + 0x26e4 (0x37c8)
// imports ... 116 (offset: 0x3db8)
// animtree1 . 0   (offset: 0x5828)
// animtree2 . 0   (offset: 0x5828)
#using script_16ea1b94f0f381b3;
#using script_1fdf637d053ba2b6;
#using script_5e7dba7c18c08f5a;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\doorbuy;
#using scripts\mp\load;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_audio;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_fx;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_lighting;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_rb;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_saw_blade_trap_cs;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_game_over_scenes_cs;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_powerups_ee_create_script;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_quest_create_script;
#using scripts\mp\zm\systems\zm_fog_spawning;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\traps\saw_blade_trap;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly;

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x76b2bb13, Offset: 0x1102
// Size: 0x3d7
function main()
{
    zm_sat_firefly_art::main();
    zm_sat_firefly_fx::main();
    zm_sat_firefly_lighting::main();
    zm_sat_firefly_audio::main();
    load::main();
    zm_sat_firefly_script_quest_create_script::main();
    zm_sat_firefly_script_powerups_ee_create_script::main();
    zm_sat_firefly_saw_blade_trap_cs::main();
    zm_sat_firefly_script_game_over_scenes_cs::main();
    level callback::callback( "create_script_initialized" );
    level callback::add( "special_round_start", &on_special_round_start );
    level callback::add( "special_round_end", &on_special_round_end );
    level callback::add( "on_round_start", &on_round_start );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_8f0df026fe58ba32", &function_44d40f41feea2acf );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"directed", &function_44d40f41feea2acf );
    level check_quest_guidance_default_on();
    level utility::flag_set( "quest_guidance_default_on_checked" );
    function_1f6e194dc0f23ae0();
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        level thread function_9047b1a8249cec19();
    }
    
    compass::setupminimap( "compass_map_zm_sat_firefly" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level callback::add( "zone_changed", &on_zone_changed );
    level callback::add( "player_entered_fog", &function_dc9fecd81cbe521d );
    level.var_7a5a3a48204781da = &function_3fe60bf56876108d;
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    level.var_4798e0076da78416 = [ "hellstorm_missile", "chopper_door_gunner", "toma_strike" ];
    level.var_82608d37301e46de = [ "zone_lakefront_cabin", "zone_lakefront_cabin_floor2", "zone_exit115_gas", "zone_exit115_diner", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_cellar", "zone_launchpad_underground", "zone_launchpad_underground_02", "zone_launchpad_maintenance", "zone_launchpad_control_room", "zone_sunken_brothel", "zone_janus_warehouse", "zone_sunken_garage", "zone_sunken_shops_mercantile", "zone_sunken_brothel_shops", "zone_sunken_shops_interior", "zone_sunken_sheriff_interior" ];
    level.var_14f114e0c14850f8 = [ "vtol_warship", "hellstorm_missile", "chopper_door_gunner", "toma_strike", "ground_drone_unit" ];
    level.var_227f7ba40322bd7a = [ "zone_boss_arena" ];
    level.var_796be4543cb83fec = [ "zone_sunken_garage" ];
    level.ttlos_suppressasserts = 1;
    level.vending_machines_powered_on_at_start = 1;
    level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_54cc4f423a562da7" );
    level thread zm_round_accelerant::init_round_accelerant();
    level.var_e19bd13057298f1e = &get_fasttravel_jumppad_power_flag;
    level.var_5eadbec443282eb6 = &get_fasttravel_jumppad_index;
    level.var_f1588a2f34367fab = &function_e70c9567a16f753d;
    level.var_41b52e54c6e6ac2c = &function_2f385f4a5343288e;
    level thread zm_sat_firefly_rb::init();
    level thread saw_blade_trap::init();
    level thread function_980e8bb694dd527();
    level thread function_7b19654a20b6e706();
    level thread function_2b0173b3f19cc5a3();
    level thread hide_quest_item();
    level thread namespace_fc27622d9019ee2f::init();
    level thread handle_dynamic_traversal();
    level thread function_7e775b8840beb218();
    level thread function_89959621274f23c7();
    level thread magicbox_materials();
    level thread function_f6e387873eda0ce9();
    level thread spawn_axes();
    level thread function_4f3f711eb132a9a5();
    level thread function_18d7a0868d0f3dc0();
    level thread function_49a05da18b24108e();
    level.var_b9b5070bae70d850 = 1;
    
    if ( getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        level thread function_31368ac71ce2dc62();
    }
    
    level.var_59abd25eeb5b2fed = &function_b00fc8e1982a35b3;
    level utility::registersharedfunc( #"hash_704eb0156b6e091", #"override_tedd_task", &function_7eedd495f34b4085 );
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0xe59de65b, Offset: 0x14e1
// Size: 0x181, Type: bool
function private function_b00fc8e1982a35b3( var_ec5aa195d3ea1ca3 )
{
    if ( !isdefined( var_ec5aa195d3ea1ca3 ) )
    {
        return !isplayer( self );
    }
    
    vault_sbl = utility::function_b3fc2f9ce7786d99( "fww_v", #targetname );
    
    if ( vault_sbl && distancesquared( var_ec5aa195d3ea1ca3, vault_sbl.origin ) < squared( 50 ) )
    {
        return false;
    }
    
    foreach ( jumppad in level.a_jumppads )
    {
        if ( jumppad && distancesquared( var_ec5aa195d3ea1ca3, jumppad.origin ) < squared( 50 ) )
        {
            return false;
        }
    }
    
    foreach ( landingpad in level.var_fb4ce2ccb8add9ab )
    {
        if ( landingpad && distancesquared( var_ec5aa195d3ea1ca3, landingpad.origin ) < squared( 50 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x6af751c4, Offset: 0x166b
// Size: 0x3e
function function_49a05da18b24108e()
{
    level endon( #"game_ended" );
    
    while ( !level.zone_spawn_locations )
    {
        wait 1;
    }
    
    level.zone_spawn_locations = utility::function_6ed29b1b786df49a( level.zone_spawn_locations, &should_remove_spawner );
}

// Namespace zm_sat_firefly
// Params 2, eflags: 0x4
// Checksum 0xbf166777, Offset: 0x16b1
// Size: 0x57, Type: bool
function private should_remove_spawner( key, val )
{
    if ( val.target == "zone_lakefront_cliffs_south" && ( val.script_noteworthy == "hvt_large" || val.script_noteworthy == "zombie_callisto" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x7e9cb258, Offset: 0x1711
// Size: 0xd7
function magicbox_materials()
{
    utility::flag_wait( "magicbox_ready" );
    
    foreach ( s_magic_box in level.var_1bbb5557537e2c0c )
    {
        if ( s_magic_box.script_noteworthy == "survival_magicbox_zone_lakefront" || s_magic_box.script_noteworthy == "survival_magicbox_zone_exit115" )
        {
            while ( !isdefined( s_magic_box.mdl_magicbox ) )
            {
                waitframe();
            }
            
            s_magic_box.mdl_magicbox utility::function_7c10ea82c1e305b8( "material", "snow" );
        }
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0xf1b46ec1, Offset: 0x17f0
// Size: 0x184
function function_31368ac71ce2dc62()
{
    utility::flag_wait( "magicbox_ready" );
    var_8484cf1933e8cf14 = [];
    var_ac7f7b4f1dffaa57 = [];
    var_6a2460eb956438be = [ "survival_magicbox_zone_jplaza", "survival_magicbox_zone_farm", "survival_magicbox_zone_lakefront", "survival_magicbox_zone_sunken" ];
    
    foreach ( var_93e4a0a8514ca47e, a_s_magic_boxes in level.var_e0e84452fe117b5f )
    {
        if ( !isdefined( var_ac7f7b4f1dffaa57[ var_93e4a0a8514ca47e ] ) )
        {
            var_ac7f7b4f1dffaa57[ var_93e4a0a8514ca47e ] = [];
        }
        
        foreach ( s_magic_box in a_s_magic_boxes )
        {
            if ( isdefined( s_magic_box.script_noteworthy ) && arraycontains( var_6a2460eb956438be, s_magic_box.script_noteworthy ) )
            {
                var_ac7f7b4f1dffaa57[ var_93e4a0a8514ca47e ][ var_ac7f7b4f1dffaa57[ var_93e4a0a8514ca47e ].size ] = s_magic_box;
                var_8484cf1933e8cf14[ var_8484cf1933e8cf14.size ] = s_magic_box;
            }
        }
    }
    
    level.var_1bbb5557537e2c0c = var_8484cf1933e8cf14;
    level.var_e0e84452fe117b5f = var_ac7f7b4f1dffaa57;
}

// Namespace zm_sat_firefly
// Params 2, eflags: 0x4
// Checksum 0xa30fac00, Offset: 0x197c
// Size: 0x74
function private function_3fe60bf56876108d( streakitem, slotnumber )
{
    if ( isdefined( self.var_b43d27527f482c08 ) && arraycontains( level.var_4798e0076da78416, streakitem.streakname ) )
    {
        return 0;
    }
    
    if ( isdefined( self.var_163ee79762bc0a64 ) && arraycontains( level.var_14f114e0c14850f8, streakitem.streakname ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0x1bd14ce, Offset: 0x19f8
// Size: 0x95
function private on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) )
    {
        if ( arraycontains( level.var_82608d37301e46de, params.zone_struct.script_zone_name ) )
        {
            self.var_b43d27527f482c08 = 1;
        }
        else
        {
            self.var_b43d27527f482c08 = undefined;
        }
        
        if ( arraycontains( level.var_227f7ba40322bd7a, params.zone_struct.script_zone_name ) )
        {
            self.var_163ee79762bc0a64 = 1;
            return;
        }
        
        self.var_163ee79762bc0a64 = undefined;
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0xa82b2045, Offset: 0x1a95
// Size: 0x15b
function hide_quest_item()
{
    if ( getdvarint( @"hash_af9f3b894ff6a556", 0 ) || !getdvarint( @"enable_firefly_ee", 0 ) )
    {
        vault_sbl = utility::function_b3fc2f9ce7786d99( "fww_v", #targetname );
        
        if ( isent( vault_sbl ) && vault_sbl.model == "sat_zm_vault_flesh_01_active_fxanim" )
        {
            level utility::flag_wait( "scriptables_ready" );
            vault_sbl utility::function_32b24db3127bff40( "anim", "close_idle" );
        }
    }
    
    clip = getent( "axr_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip notsolid();
        clip hide();
    }
    
    clip = getent( "axr_plt_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip notsolid();
        clip hide();
    }
    
    var_d69e4eb311b10cc7 = getentarray( "wwq_clip", #targetname );
    
    foreach ( clip in var_d69e4eb311b10cc7 )
    {
        clip connectpaths();
        clip notsolid();
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x4cc6c208, Offset: 0x1bf8
// Size: 0x1b5
function function_7e775b8840beb218()
{
    waitframe();
    zm_fog_spawning::init_zm_fog_spawning( "zmfogspawning:zm_sat_fog_spawning_firefly" );
    zm_fog_spawning::register_fog_zone( "zone_ts_monoliths", undefined, "zone_ts_monoliths_close_to_lakefront", "zone_ts_monoliths_close_to_jplaza" );
    zm_fog_spawning::register_fog_zone( "zone_ts_monoliths_close_to_lakefront", "zone_ts_monoliths_close_to_jplaza" );
    zm_fog_spawning::register_fog_zone( "zone_ts_monoliths_close_to_jplaza", "zone_ts_monoliths_close_to_lakefront" );
    zm_fog_spawning::register_fog_zone( "zone_ts_boat", undefined, "zone_ts_boat_close_to_farm", "zone_ts_boat_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_boat_close_to_farm", "zone_ts_boat_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_boat_close_to_sunken", "zone_ts_boat_close_to_farm" );
    zm_fog_spawning::register_fog_zone( "zone_ts_boat_deck", undefined, "zone_ts_boat_close_to_farm", "zone_ts_boat_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_orda", undefined, "zone_ts_orda_close_to_exit115", "zone_ts_orda_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_orda_close_to_exit115", "zone_ts_orda_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_orda_close_to_sunken", "zone_ts_orda_close_to_exit115" );
    zm_fog_spawning::register_fog_zone( "zone_ts_plane", undefined, "zone_ts_plane_close_to_exit115", "zone_ts_plane_close_to_launchpad" );
    zm_fog_spawning::register_fog_zone( "zone_ts_plane_close_to_exit115", "zone_ts_plane_close_to_launchpad" );
    zm_fog_spawning::register_fog_zone( "zone_ts_plane_close_to_launchpad", "zone_ts_plane_close_to_exit115" );
    zm_fog_spawning::register_fog_zone( "zone_ts_rocket", undefined, "zone_ts_rocket_close_to_sunken", "zone_ts_rocket_close_to_launchpad" );
    zm_fog_spawning::register_fog_zone( "zone_ts_rocket_close_to_sunken", "zone_ts_rocket_close_to_launchpad" );
    zm_fog_spawning::register_fog_zone( "zone_ts_rocket_close_to_launchpad", "zone_ts_rocket_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_tower", undefined, "zone_ts_tower_close_to_farm", "zone_ts_tower_close_to_janus" );
    zm_fog_spawning::register_fog_zone( "zone_ts_tower_close_to_farm", "zone_ts_tower_close_to_janus" );
    zm_fog_spawning::register_fog_zone( "zone_ts_tower_close_to_janus", "zone_ts_tower_close_to_farm" );
    zm_fog_spawning::register_fog_zone( "zone_ts_w_lakefront", undefined, "zone_ts_w_lakefront_close_to_lakefront", "zone_ts_w_lakefront_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_w_lakefront_close_to_lakefront", "zone_ts_w_lakefront_close_to_sunken" );
    zm_fog_spawning::register_fog_zone( "zone_ts_w_lakefront_close_to_sunken", "zone_ts_w_lakefront_close_to_lakefront" );
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0xa07e2491, Offset: 0x1db5
// Size: 0xc5
function private function_89959621274f23c7()
{
    if ( level.gametypebundle.var_690bd39082a5d6b0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_wait_any( "door_from_farm_to_jplaza_enabled", "door_from_sunken_to_farm_enabled" );
    a_doors = getentarray( "farm_garage_db", #targetname );
    
    foreach ( door in a_doors )
    {
        door doorbuy::function_f3160e450543b4f1();
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x495c3605, Offset: 0x1e82
// Size: 0x35d
function function_9047b1a8249cec19()
{
    a_clips = getentarray( "perk_clip_to_removed_survival", #script_noteworthy );
    
    foreach ( clip in a_clips )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    level utility::flag_wait( "firefly_pap_doors_init" );
    level utility::flag_wait( "firefly_zone_unlocks_init" );
    var_e5ccbf542c55e9dd = getnoentvolumearray( "zone_unlock_trig", #targetname );
    
    foreach ( trig in var_e5ccbf542c55e9dd )
    {
        doorbuy_hint_ent = getent( trig.target, #target );
        
        if ( isdefined( doorbuy_hint_ent ) )
        {
            doorbuy_hint_ent.var_a0d364b16ee53ab6 = &"";
            doorbuy_hint_ent.var_df00f5fbf4a6d195 = 1;
        }
        
        foreach ( sbl in trig.a_door_sbls )
        {
            sbl utility::function_7c10ea82c1e305b8( "icon", "off" );
        }
    }
    
    a_door_triggers = getnoentvolumearray( "pap_wood_barrier_trig", #targetname );
    
    foreach ( trig in a_door_triggers )
    {
        doorbuy_hint_ent = getent( trig.target, #target );
        
        if ( isdefined( doorbuy_hint_ent ) )
        {
            doorbuy_hint_ent.var_a0d364b16ee53ab6 = &"";
            doorbuy_hint_ent.var_df00f5fbf4a6d195 = 1;
        }
        
        foreach ( sbl in trig.a_door_sbls )
        {
            sbl utility::function_7c10ea82c1e305b8( "icon", "off" );
        }
    }
    
    level utility::flag_set( "survival_map_setup_finished" );
    level utility::flag_wait( "begin_round_logic" );
    activateworldevent( "we_sat_survival_hidden_arrows" );
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0x549ec16e, Offset: 0x21e7
// Size: 0x7f
function private get_fasttravel_jumppad_power_flag( pad_name )
{
    switch ( pad_name )
    {
        case #"hash_7e2d277ad8631e8b":
            return "power_on2";
        case #"hash_6c34dd2c0d08e2b3":
            return "power_on1";
        case #"hash_374ab4e6aeafc48b":
        case #"hash_afa01f4fce57e78c":
        case #"hash_b47fff9af76fccd5":
        case #"hash_ba5f8024feb2af3b":
            return "power_on3";
        default:
            break;
    }
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0x33dd1c1, Offset: 0x226e
// Size: 0x8e
function private get_fasttravel_jumppad_index( pad_name )
{
    switch ( pad_name )
    {
        case #"hash_60082bff96677cf2":
            return 1;
        case #"hash_7e2d277ad8631e8b":
            return 2;
        case #"hash_6c34dd2c0d08e2b3":
            return 4;
        case #"hash_374ab4e6aeafc48b":
            return 3;
        case #"hash_ba5f8024feb2af3b":
            return 7;
        case #"hash_afa01f4fce57e78c":
            return 5;
        case #"hash_b47fff9af76fccd5":
            return 6;
        default:
            break;
    }
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0x4a6f8fac, Offset: 0x2304
// Size: 0xb5
function private function_e70c9567a16f753d( path_name )
{
    switch ( path_name )
    {
        case #"hash_16775007c8c1ad06":
            return &"zm_sat_firefly/callout_janus_tower";
        case #"hash_6cda8e5a62155ba7":
            return &"zm_sat_firefly/callout_farm";
        case #"hash_42b6ea8687452627":
            return &"zm_sat_firefly/callout_lakefront";
        case #"hash_6c551b99f4a89c1f":
        case #"hash_e17e23c9c072c2f7":
            return &"zm_sat_firefly/callout_sunken";
        case #"hash_29fbff58769531f8":
            return &"zm_sat_firefly/callout_exit115";
        case #"hash_909eaec96022f9f9":
            return &"zm_sat_firefly/callout_launchpad";
        default:
            break;
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x98f40497, Offset: 0x23c1
// Size: 0xc2
function function_980e8bb694dd527()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    s_tv_loc = utility::getstruct( "ts_ee_tv_loc", "script_noteworthy" );
    
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        mdl_tv = spawnscriptable( "equipment_tv_01_scriptable", s_tv_loc.origin, s_tv_loc.angles );
    }
    else
    {
        level.var_eafc3735139d91e1 = spawnscriptable( "zm_sat_firefly_two_sister_ee_tv", s_tv_loc.origin, s_tv_loc.angles );
        level.var_eafc3735139d91e1 setscriptablepartstate( "model", "noise" );
    }
    
    level utility::flag_set( "ts_ee_tv_spawned" );
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0xdb7eaca2, Offset: 0x248b
// Size: 0xd0
function function_7b19654a20b6e706()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        unlock_device = getent( "europa_unlock_device", "script_noteworthy" );
        unlock_chip = getent( "europa_unlock_chip", "script_noteworthy" );
        box_struct = utility::getstruct( "viper_box_deactivated", "script_noteworthy" );
        viper_box = utility::spawn_model( "sat_zm_uber_k_box_full_fxanim", box_struct.origin, box_struct.angles );
        unlock_chip hide();
        level utility::flag_wait( "scriptables_ready" );
        unlock_device utility::function_32b24db3127bff40( "screen", "power_off" );
        viper_box utility::function_32b24db3127bff40( "box_indicator", "deactivated" );
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x2c97f576, Offset: 0x2563
// Size: 0x19
function hide_clip()
{
    level utility::flag_wait( "begin_round_logic" );
    
    if ( self )
    {
        self notsolid();
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0xadf000c7, Offset: 0x2584
// Size: 0x18b
function function_1f6e194dc0f23ae0()
{
    if ( !isdefined( level.var_a07e60759c20be4c ) )
    {
        level.var_a07e60759c20be4c = [];
    }
    
    var_5a19f001737e07f7 = utility::getstructarray( "vdm_ee_machine", "script_noteworthy" );
    
    foreach ( loc in var_5a19f001737e07f7 )
    {
        mdl = spawnscriptable( "zm_sat_firefly_vdm_ee_vd_machine", loc.origin, loc.angles );
        
        if ( !isdefined( level.var_a07e60759c20be4c ) )
        {
            level.var_a07e60759c20be4c = [];
        }
        
        level.var_a07e60759c20be4c[ level.var_a07e60759c20be4c.size ] = mdl;
    }
    
    a_clips = getentarray( "vdm_ee_clip", "script_noteworthy" );
    
    foreach ( clip in a_clips )
    {
        clip solid();
        clip disconnectpaths();
    }
    
    level utility::flag_set( "ee_vdm_models_spawned" );
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x6e23bd22, Offset: 0x2717
// Size: 0x781
function function_2b0173b3f19cc5a3()
{
    if ( !getdvarint( @"enable_firefly_mq", 0 ) )
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_d1bc81df4ca8ffd7", 1 );
        level utility::flag_wait( "scriptables_ready" );
        a_s_mon = utility::getstructarray( "rob_mon", "targetname" );
        
        foreach ( struct in a_s_mon )
        {
            spawnscriptable( %"sat_zm_firefly_mon", struct.origin, struct.angles );
            temp = utility::spawn_model( %"sat_zm_possible_code_monitor_fxanim", struct.origin, struct.angles );
            waitframe();
            spawnscriptable( %"zm_sat_firefly_mon_cir", temp gettagorigin( "tag_button" ), temp gettagangles( "tag_button" ) );
            temp delete();
        }
        
        var_467cc65e7d16745e = utility::getstructarray( "rob_mon_y", "targetname" );
        
        foreach ( struct in var_467cc65e7d16745e )
        {
            spawnscriptable( %"sat_zm_firefly_mon", struct.origin, struct.angles );
        }
        
        s_rocket = utility::getstruct( "grom_r", "targetname" );
        spawnscriptable( %"sat_zm_firefly_roc", s_rocket.origin, s_rocket.angles );
        s_rocket_clamp_left = utility::getstruct( "ro_cl_le", "targetname" );
        spawnscriptable( %"sat_zm_firefly_r_cl", s_rocket_clamp_left.origin, s_rocket_clamp_left.angles );
        s_rocket_clamp_right = utility::getstruct( "ro_cl_ri", "targetname" );
        spawnscriptable( %"sat_zm_firefly_r_cr", s_rocket_clamp_right.origin, s_rocket_clamp_right.angles );
        level.sc = getent( "lt_c", #targetname );
        
        if ( isdefined( level.sc ) )
        {
            level.sc connectpaths();
            level.sc notsolid();
        }
        
        level.box_clip = getent( "eb_c", #targetname );
        
        if ( isdefined( level.box_clip ) )
        {
            level.box_clip connectpaths();
            level.box_clip notsolid();
        }
        
        s_rm_r = utility::getstruct( "rm_r", "targetname" );
        var_629662e7cf4e76a1 = utility::getstruct( "exit_ch_1", "targetname" );
        var_62965fe7cf4e7008 = utility::getstruct( "exit_ch_2", "targetname" );
        s_m_j = utility::getstruct( "m_j", "targetname" );
        s_f_h = utility::getstruct( "f_he", "targetname" );
        s_bb = utility::getstruct( "bb_hang", "targetname" );
        s_p_loc = utility::getstruct( "lf_p", "targetname" );
        var_2fa04e885f6a283f = utility::getstruct( "exit_c_1", "targetname" );
        var_2fa04f885f6a2a72 = utility::getstruct( "exit_c_2", "targetname" );
        var_d84fef993c3e32f2 = utility::getstruct( "s_mm", "targetname" );
        s_fc = utility::getstruct( "f_c", "targetname" );
        utility::spawn_model( "c_sat_zmb_corpse_vandorn_skull", s_f_h.origin, s_f_h.angles );
        spawnscriptable( %"sat_zm_firefly_mm", var_d84fef993c3e32f2.origin, var_d84fef993c3e32f2.angles );
        spawnscriptable( %"sat_zm_firefly_mj", s_m_j.origin, s_m_j.angles );
        spawnscriptable( %"sat_zm_firefly_pro", s_p_loc.origin, s_p_loc.angles );
        spawnscriptable( %"sat_zm_firefly_reg", s_rm_r.origin, s_rm_r.angles );
        mdl_bb = utility::spawn_model( %"sat_zm_firefly_farm_barn_body_hanging_01_c_fxsim", s_bb.origin, s_bb.angles );
        mdl_bf = utility::spawn_model( %"c_sat_zmb_corpse_charred_male_foot", s_bb.origin, s_bb.origin );
        mdl_bf setscriptablepartstate( "vfx", "off" );
        mdl_bf linkto( mdl_bb, "tag_foot_ri", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        mdl_bb scriptmodelplayanim( "sat_zm_firefly_farm_barn_body_hanging_01_c_fxsim", undefined, 0 );
        utility::spawn_model( %"sat_zm_decor_clock_pointer_minute", var_629662e7cf4e76a1.origin, var_629662e7cf4e76a1.angles );
        utility::spawn_model( %"sat_zm_decor_clock_pointer_minute", var_62965fe7cf4e7008.origin, var_62965fe7cf4e7008.angles );
        spawnscriptable( %"sat_zm_firefly_g_c", var_2fa04e885f6a283f.origin, var_2fa04e885f6a283f.angles );
        spawnscriptable( %"sat_zm_firefly_g_c", var_2fa04f885f6a2a72.origin, var_2fa04f885f6a2a72.angles );
        spawnscriptable( %"sat_zm_firefly_fc", s_fc.origin, s_fc.angles );
        a_s_ant = utility::getstructarray( "m_a_q", "targetname" );
        
        foreach ( struct in a_s_ant )
        {
            spawnscriptable( %"zm_sat_firefly_mq_at", struct.origin, struct.angles );
        }
        
        s_projection = utility::getstruct( "fmq_p", "targetname" );
        s_projection.sbl = spawnscriptable( %"sat_zm_firefly_mq_projections_reactive", s_projection.origin, s_projection.angles );
        var_766a71b8f84c0a8c = utility::getstruct( "tag_align_europa_retrievable", "targetname" );
        var_766a71b8f84c0a8c thread scene::play( undefined, "closed", "sat_cin_zm_death_whistle_box" );
        whistle = var_766a71b8f84c0a8c scene::get_entity( "Prop 2" );
        
        if ( whistle )
        {
            whistle hide();
        }
    }
}

// Namespace zm_sat_firefly
// Params 1
// Checksum 0x54314486, Offset: 0x2ea0
// Size: 0x55
function function_2f385f4a5343288e( s_exfil )
{
    return [ "zone_farm", "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_cellar", "zone_exit115", "zone_exit115_gas", "zone_exit115_diner" ];
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x5de26b19, Offset: 0x2efe
// Size: 0xa1
function handle_dynamic_traversal()
{
    var_95b6d59473871cdb = getnodearray( "dynamic_traversal", #script_noteworthy );
    
    if ( var_95b6d59473871cdb.size < 0 )
    {
        return;
    }
    
    foreach ( var_85b597ea50b4bcc7 in var_95b6d59473871cdb )
    {
        function_30dc1efdafe7681e( var_85b597ea50b4bcc7, 0 );
        var_85b597ea50b4bcc7 thread function_f1115d0c53240e07();
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0xf2af003f, Offset: 0x2fa7
// Size: 0x32
function function_f1115d0c53240e07()
{
    level endon( #"game_ended" );
    
    if ( self.script_flag_wait )
    {
        utility::flag_wait( self.script_flag_wait );
    }
    
    function_30dc1efdafe7681e( self, 1 );
}

// Namespace zm_sat_firefly
// Params 1
// Checksum 0xefbda95b, Offset: 0x2fe1
// Size: 0xa0
function on_special_round_start( sparams )
{
    tendrils = getentarray( "firefly_farm_streamer", "targetname" );
    
    foreach ( tendril in tendrils )
    {
        tendril utility::function_7c10ea82c1e305b8( "base", "normal_to_special" );
    }
}

// Namespace zm_sat_firefly
// Params 1
// Checksum 0xc9b04ea9, Offset: 0x3089
// Size: 0xa0
function on_special_round_end( sparams )
{
    tendrils = getentarray( "firefly_farm_streamer", "targetname" );
    
    foreach ( tendril in tendrils )
    {
        tendril utility::function_7c10ea82c1e305b8( "base", "special_to_normal" );
    }
}

// Namespace zm_sat_firefly
// Params 1
// Checksum 0x11fe3f70, Offset: 0x3131
// Size: 0x35
function on_round_start( params )
{
    if ( params.roundnumber >= 31 )
    {
        level.var_e89fe60e34cb36f1 = 1;
        return;
    }
    
    level.var_e89fe60e34cb36f1 = undefined;
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0xcf622899, Offset: 0x316e
// Size: 0x79
function private function_44d40f41feea2acf( params )
{
    if ( params[ 0 ] == "0" )
    {
        level utility::flag_clear( "dev_quest_guidance_enabled" );
        iprintlnbold( "Quest guidance disabled." );
        return;
    }
    
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = spawnstruct();
        level.directed_mode.var_f1879f50f4eeaca3 = [];
    }
    
    level utility::flag_set( "dev_quest_guidance_enabled" );
    iprintlnbold( "Quest guidance enabled!" );
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0xde56dc36, Offset: 0x31ef
// Size: 0x1a
function private check_quest_guidance_default_on()
{
    if ( getdvarint( @"hash_8926097318777973", 0 ) )
    {
        function_44d40f41feea2acf();
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x7b537ca, Offset: 0x3211
// Size: 0x22, Type: bool
function function_24006873400b7a8()
{
    if ( level utility::flag( "dev_quest_guidance_enabled" ) )
    {
        return true;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_firefly
// Params 1, eflags: 0x4
// Checksum 0xfb157e47, Offset: 0x323c
// Size: 0x32
function private function_dc9fecd81cbe521d( params )
{
    if ( !vehicle::is_in_vehicle() )
    {
        level thread function_520b65c26e34f73a();
        return;
    }
    
    if ( vehicle::is_in_vehicle() )
    {
        level thread function_40b9581c5022c9f0();
    }
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0x8a3607ae, Offset: 0x3276
// Size: 0x10b
function private function_520b65c26e34f73a()
{
    level endon( #"game_ended" );
    
    if ( !level utility::flag( "firefly_players_entered_fog_on_foot_first_time" ) )
    {
        wait 10;
        a_players = arrayrandomize( level.players );
        
        foreach ( player in a_players )
        {
            if ( player namespace_c0b4f2882c9d100f::is_hero_operator() && player.var_cc1677771f64fd22 && !level utility::flag( "firefly_players_entered_fog_on_foot_first_time" ) && !isdefined( player.is_dempsey_speaking ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_dc37d689cee3c5cf" );
                
                if ( var_db75d3de862ce072 )
                {
                    level utility::flag_set( "firefly_players_entered_fog_on_foot_first_time" );
                    return;
                }
            }
        }
    }
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0x7d58f985, Offset: 0x3389
// Size: 0x67
function private function_40b9581c5022c9f0()
{
    level endon( #"game_ended" );
    
    if ( !level utility::flag( "firefly_players_entered_fog_with_tessie_first_time" ) )
    {
        var_db75d3de862ce072 = level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_b39742bfc04a3120" );
        
        if ( var_db75d3de862ce072 )
        {
            level utility::flag_set( "firefly_players_entered_fog_with_tessie_first_time" );
            return;
        }
    }
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0xfc25ec43, Offset: 0x33f8
// Size: 0x1a1
function private function_f6e387873eda0ce9()
{
    spacious_zones = [ "zone_farm_close_to_sunken", "zone_farm_road", "zone_farm_close_to_tower", "zone_sunken", "zone_sunken_north", "zone_sunken_south", "zone_lakefront_path_south", "zone_lakefront_path_north", "zone_jplaza_close_to_ts_tower", "zone_jplaza_ramp", "zone_jplaza_close_to_monolith" ];
    var_e5e4cffa68fca07d = 51;
    
    while ( true )
    {
        if ( zm_utility::get_round_number() < var_e5e4cffa68fca07d )
        {
            waitframe();
            continue;
        }
        
        all_ai = getaiarray();
        
        foreach ( ai in all_ai )
        {
            if ( !isalive( ai ) )
            {
                continue;
            }
            
            if ( !issubstr( ai.subclass, "zombie_base" ) )
            {
                continue;
            }
            
            if ( ai.round_spawning_move_speed != "sprint" )
            {
                continue;
            }
            
            var_31a025cdd36577c7 = ai zone_manager::get_current_zone();
            
            if ( var_31a025cdd36577c7 && arraycontains( spacious_zones, var_31a025cdd36577c7.zone_name ) )
            {
                ai zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "firefly_spacious_zone", 8 );
            }
            else
            {
                ai zombie_utils::function_a8ce00e0448cb6f0( undefined, "firefly_spacious_zone", 8 );
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly
// Params 0
// Checksum 0x76ed5e89, Offset: 0x35a1
// Size: 0xfd
function spawn_axes()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    item_bundle = getscriptbundle( "itemspawnentry:" + "zm_sat_item_combataxe" );
    var_f144346027c675dd = utility::getstructarray( "g_combataxe", "targetname" );
    
    if ( var_f144346027c675dd )
    {
        foreach ( s_loc in var_f144346027c675dd )
        {
            angles = s_loc.angles - ( 90, 0, 0 );
            var_3eebad4f7884c91a = zm_quest::spawn_quest_item( s_loc.origin, angles, item_bundle );
        }
    }
}

// Namespace zm_sat_firefly
// Params 1
// Checksum 0xfa2e69bc, Offset: 0x36a6
// Size: 0x35
function function_7eedd495f34b4085( var_d5e505e9e95f2d3b )
{
    if ( var_d5e505e9e95f2d3b == "zone_exit115" )
    {
        var_d5e505e9e95f2d3b = "zone_diner_roof";
    }
    else if ( var_d5e505e9e95f2d3b == "zone_launchpad" )
    {
        var_d5e505e9e95f2d3b = "zone_rocket_facility";
    }
    
    return var_d5e505e9e95f2d3b;
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0xea09f940, Offset: 0x36e4
// Size: 0x6e
function private function_18d7a0868d0f3dc0()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_4c33e1cd56ccc717 = getent( "rh_col_coffin", #targetname );
    
    if ( !isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        return;
    }
    
    level.var_4c33e1cd56ccc717 connectpaths();
    level.var_4c33e1cd56ccc717 notsolid();
}

// Namespace zm_sat_firefly
// Params 0, eflags: 0x4
// Checksum 0x4acf45f4, Offset: 0x375a
// Size: 0x6e
function private function_4f3f711eb132a9a5()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.rh_meteor_col = getent( "rh_col_rock", #targetname );
    
    if ( !isdefined( level.rh_meteor_col ) )
    {
        return;
    }
    
    level.rh_meteor_col connectpaths();
    level.rh_meteor_col notsolid();
}

