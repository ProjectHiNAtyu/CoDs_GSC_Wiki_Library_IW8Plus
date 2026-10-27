// scripts\mp\zm\livingworld\zm_sat_livingworld.gsc  (hash_56820dc081635f18.gscc) (size: 17737 Bytes / 0x4549 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd24119d3 (3527481811)
// size ...... 17737 (0x4549)
// includes .. 8   (offset: 0x3f45)
// strings ... 89  (offset: 0x3f85)
// dev strs .. 0   (offset: 0x4549)
// exports ... 33  (offset: 0x2ced)
// cseg ...... 0x93a + 0x23b3 (0x2ced)
// imports ... 99  (offset: 0x3215)
// animtree1 . 0   (offset: 0x4549)
// animtree2 . 0   (offset: 0x4549)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_livingworld;

#namespace zm_sat_livingworld;

// Namespace zm_sat_livingworld
// Params 0, eflags: 0x5
// Checksum 0xb2ed8959, Offset: 0x958
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"zm_sat_livingworld", #"zm_livingworld", undefined, &init_sat_livingworld );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x58cb6431, Offset: 0x981
// Size: 0x27c
function init_sat_livingworld()
{
    if ( zm_livingworld::livingworld_is_disabled( "SAT" ) )
    {
        return;
    }
    
    while ( !isdefined( level._livingworld_info.script_funcs ) )
    {
        waitframe();
    }
    
    anim_func_pairs = [];
    anim_func_pairs[ "test_ai_combat" ] = &ai_combat;
    anim_func_pairs[ "sat_cin_zm_living_world_horde_fall_zmb" ] = &sat_cin_zm_living_world_horde_fall_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_backseat_car_zmb_r" ] = &sat_cin_zm_living_world_backseat_car_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_backseat_car_zmb_r" + "_pre_play" ] = &function_9fee99e60a7c33d;
    anim_func_pairs[ "sat_cin_zm_living_world_backseat_car_zmb_l" ] = &sat_cin_zm_living_world_backseat_car_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_backseat_car_zmb_l" + "_pre_play" ] = &function_9fee99e60a7c33d;
    anim_func_pairs[ "sat_cin_zm_living_world_bodybag_zmb" ] = &sat_cin_zm_living_world_bodybag_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_caught_zmb" ] = &sat_cin_zm_living_world_caught_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_crushed_zmb" ] = &sat_cin_zm_living_world_crushed_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_falling_zmb" ] = &sat_cin_zm_living_world_falling_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_multi_eating_corpse_zmb" ] = &sat_cin_zm_living_world_multi_eating_corpse_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_operation_table_zmb" ] = &sat_cin_zm_living_world_operation_table_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_operation_table_chase_zmb" ] = &sat_cin_zm_living_world_operation_table_chase_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_slumped_over_zmb" ] = &sat_cin_zm_living_world_slumped_over_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_half_eaten_zmb" ] = &sat_cin_zm_living_world_half_eaten_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_tube_break_out" ] = &sat_cin_zm_living_world_tube_break_out;
    anim_func_pairs[ "sat_cin_zm_living_world_tube_dud" ] = &sat_cin_zm_living_world_tube_dud;
    anim_func_pairs[ "sat_cin_zm_living_world_vermin_scare_jump_01" ] = &sat_cin_zm_living_world_vermin_scare_jump;
    anim_func_pairs[ "sat_cin_zm_living_world_undr_low_obj_zmb" ] = &sat_cin_zm_living_world_undr_low_obj_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_slumped_chair_zmb" ] = &sat_cin_zm_living_world_slumped_chair_zmb;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_long_zmb" ] = &function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_short_zmb" ] = &function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_long_zmb" ] = &function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_short_zmb" ] = &function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_sign_zmb" ] = &function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_sign_zmb" ] = &function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_long_zmb_ai" ] = &function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_short_zmb_ai" ] = &function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_long_zmb_ai" ] = &function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_short_zmb_ai" ] = &function_d4e1a10c23c9b8fe;
    
    foreach ( stringid, func in anim_func_pairs )
    {
        level._livingworld_info.script_funcs[ stringid ] = func;
    }
    
    level._effect[ "zmb_eye_glow" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zai_base_eye" );
    level utility::flag_set( "init_" + getprojectname() + "_anim_func_pairs" );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x672ab544, Offset: 0xc05
// Size: 0x2
function ai_combat()
{
    
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xe6af05e3, Offset: 0xc0f
// Size: 0x39
function sat_cin_zm_living_world_horde_fall_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars();
    self.action_func_vars = zm_livingworld::init_action_func_vars();
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xc5c51f76, Offset: 0xc50
// Size: 0x1d
function function_9fee99e60a7c33d()
{
    self.scene_root callback::add( "on_agent_align_entity", &function_434d11e9dbbd1882, self );
}

// Namespace zm_sat_livingworld
// Params 2
// Checksum 0xdb34e186, Offset: 0xc75
// Size: 0xd2
function function_434d11e9dbbd1882( sparams, livingworldstruct )
{
    tag = "tag_body_animate";
    car = livingworldstruct.var_58e6c0d1fd24de83[ 0 ];
    
    if ( isdefined( car ) && car tagexists( tag ) )
    {
        var_13d60e5f54c6db7 = spawnstruct();
        var_13d60e5f54c6db7.alignent = car;
        var_13d60e5f54c6db7.aligntag = tag;
        origin = car gettagorigin( tag, 1 );
        angles = car gettagangles( tag, 1 );
        var_13d60e5f54c6db7.origin = origin;
        var_13d60e5f54c6db7.angles = angles;
        sparams.entity.var_13d60e5f54c6db7 = var_13d60e5f54c6db7;
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xe5db4d4b, Offset: 0xd4f
// Size: 0x114
function sat_cin_zm_living_world_backseat_car_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( undefined, 1, undefined, 0, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( undefined, 1, undefined, undefined, undefined, undefined, 1 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( self.isplaying )
    {
        return;
    }
    
    foreach ( ent in self.scene_ents[ "actors" ] )
    {
        if ( !isalive( ent ) || !isai( ent ) )
        {
            continue;
        }
        
        ent function_7f8988ce63c1623d( 0 );
        ent val::set( "living_world", "collide_with_ai_allies" );
        ent val::set( "living_world", "force_show_healthbar_distance" );
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x3b0bcae1, Offset: 0xe6b
// Size: 0x5c
function sat_cin_zm_living_world_bodybag_zmb()
{
    b_cleanup_props = level.mapname == "zm_sat_core_features";
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( undefined, undefined, undefined, b_cleanup_props );
    self.action_func_vars = zm_livingworld::init_action_func_vars( undefined, 1 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x8b5b4c39, Offset: 0xecf
// Size: 0xf7
function sat_cin_zm_living_world_caught_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( undefined, 1, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars();
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    ents = self.scene_root scene::get_entities();
    
    if ( self.isplaying )
    {
        return;
    }
    
    foreach ( zombie in ents )
    {
        if ( !isalive( zombie ) || !isagent( zombie ) )
        {
            continue;
        }
        
        zombie zombie_utils::function_dfae6a5bd222c586( &function_da786cbe9fe463b );
    }
}

// Namespace zm_sat_livingworld
// Params 1, eflags: 0x4
// Checksum 0x82a0877f, Offset: 0xfce
// Size: 0x82
function private function_da786cbe9fe463b( sparams )
{
    if ( isdefined( sparams.einflictor ) && isdefined( level.rockablecars.cars ) && sparams.einflictor utility::function_de1f80d93273abf5() && arraycontains( level.rockablecars.cars, sparams.einflictor ) )
    {
        return self.health;
    }
    
    return sparams.idamage;
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xb50a7790, Offset: 0x1059
// Size: 0x1c9
function sat_cin_zm_living_world_crushed_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( undefined, 1, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars();
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    ents = self.scene_root scene::get_entities();
    
    foreach ( ent in ents )
    {
        if ( !isalive( ent ) || !isagent( ent ) )
        {
            continue;
        }
        
        if ( !self.isplaying )
        {
            excluded_dismemberment = [ "right_leg", "left_leg", "right_arm", "left_arm", "both_arms", "head" ];
            ent zm_livingworld::function_fbbc42d14f371113( 50, 30, excluded_dismemberment );
            ent zombie_utils::function_dfae6a5bd222c586( &function_9bd539d0aad87e91 );
            ent val::set( "living_world", "collide_with_ai_allies", 0 );
            continue;
        }
        
        if ( !self.var_c0993ffe04a4ad27 )
        {
            continue;
        }
        
        excluded_dismemberment = [ "right_leg", "left_leg", "right_arm", "left_arm", "both_arms", "head" ];
        ent zm_livingworld::function_fbbc42d14f371113( 100, 30, excluded_dismemberment );
        ent val::reset( "living_world", "collide_with_ai_allies" );
    }
}

// Namespace zm_sat_livingworld
// Params 1, eflags: 0x4
// Checksum 0x199272b6, Offset: 0x122a
// Size: 0x82
function private function_9bd539d0aad87e91( sparams )
{
    if ( isdefined( sparams.einflictor ) && isdefined( level.rockablecars.cars ) && sparams.einflictor utility::function_de1f80d93273abf5() && arraycontains( level.rockablecars.cars, sparams.einflictor ) )
    {
        return self.health;
    }
    
    return sparams.idamage;
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x97f93907, Offset: 0x12b5
// Size: 0x59
function sat_cin_zm_living_world_falling_zmb()
{
    ents = self.scene_root scene::get_entities();
    self.idle_func_vars = zm_livingworld::init_idle_func_vars();
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xa9ba7cae, Offset: 0x1316
// Size: 0x1ef
function sat_cin_zm_living_world_multi_eating_corpse_zmb()
{
    ents = self.scene_root scene::get_entities();
    
    if ( !self.isplaying )
    {
        scenarios = [];
        
        foreach ( ent in ents )
        {
            if ( ent.sceneobjectdata.sceneobject.variant_object.name == "Actor 3" )
            {
                scenarios[ "eaten_zombie_died" ] = [ ent ];
                ent.health = int( ent.maxhealth * 0.05 );
                self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint", undefined, undefined, ent );
                ent val::set( "living_world", "allow_give_point", 0 );
            }
            else if ( ent.sceneobjectdata.sceneobject.variant_object.name == "Actor 1" )
            {
                scenarios[ "zombie1_eating_died" ] = [ ent ];
            }
            else if ( ent.sceneobjectdata.sceneobject.variant_object.name == "Actor 2" )
            {
                scenarios[ "zombie2_eating_died" ] = [ ent ];
            }
            
            self.var_2d6cf50c52a5088b = [ scenarios ];
        }
        
        self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, 650 );
    }
    
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x8c9210b8, Offset: 0x150d
// Size: 0x11f
function sat_cin_zm_living_world_operation_table_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( undefined, 1 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    ents = self.scene_root scene::get_entities();
    
    if ( !self.isplaying )
    {
        scenarios = [];
        
        foreach ( ent in ents )
        {
            if ( isalive( ent ) && isagent( ent ) )
            {
                scenarios[ "zombie_died" ] = [ ent ];
                self.var_2d6cf50c52a5088b = [ scenarios ];
                ent.b_disable_annihilate = 1;
            }
        }
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xfed8f453, Offset: 0x1634
// Size: 0xf5
function sat_cin_zm_living_world_operation_table_chase_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    ents = self.scene_root scene::get_entities();
    
    if ( !self.isplaying )
    {
        foreach ( ent in ents )
        {
            if ( isalive( ent ) && isagent( ent ) )
            {
                ent.b_disable_annihilate = 1;
            }
        }
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x7dba567a, Offset: 0x1731
// Size: 0xf5
function sat_cin_zm_living_world_slumped_over_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( !self.isplaying )
    {
        foreach ( ent in self.scene_ents[ "actors" ] )
        {
            if ( !isalive( ent ) || !isai( ent ) )
            {
                continue;
            }
            
            ent val::set( "living_world", "collide_with_ai_allies" );
        }
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x12d74040, Offset: 0x182e
// Size: 0x139
function sat_cin_zm_living_world_half_eaten_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint", undefined, undefined, undefined, undefined, undefined, 0 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( !self.isplaying )
    {
        foreach ( ent in self.scene_ents[ "actors" ] )
        {
            if ( !isalive( ent ) || !isai( ent ) )
            {
                continue;
            }
            
            excluded_dismemberment = [ "right_arm", "left_arm", "both_arms", "head" ];
            ent zm_livingworld::function_fbbc42d14f371113( 100, 30, excluded_dismemberment );
            ent val::set( "living_world", "collide_with_ai_allies" );
        }
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x8a3e085, Offset: 0x196f
// Size: 0x138
function sat_cin_zm_living_world_tube_break_out()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( undefined, undefined, undefined, 0, 0, 0, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint", undefined, &function_6d39262410171ff7, undefined, 1 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    function_a0e8719e37d1d85b();
    ents = self.scene_root scene::get_entities();
    
    foreach ( ent in ents )
    {
        if ( !isalive( ent ) || !isai( ent ) )
        {
            continue;
        }
        
        if ( self.isplaying )
        {
            ent.b_ignore_water_check = 0;
            continue;
        }
        
        ent.b_ignore_water_check = 1;
        thread function_bc93b233cebdb2d8( ent );
        thread set_rumble();
        self.custom_living_world_transition_check = &function_15556c470e4b397b;
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x31cf9ae4, Offset: 0x1aaf
// Size: 0x83
function function_15556c470e4b397b()
{
    self endon( #"hash_43c323f558763d65" );
    self endon( #"cancel_encounter" );
    
    if ( self.script_parameters == "or" )
    {
        utility::ent_flag_wait_any_array( self.wait_array );
    }
    else
    {
        utility::ent_flag_wait_all_array( self.wait_array );
    }
    
    ent = self.scene_ents[ "actors" ][ 0 ];
    
    if ( isalive( ent ) )
    {
        ent waittill( #"end_of_anim" );
    }
}

// Namespace zm_sat_livingworld
// Params 0, eflags: 0x4
// Checksum 0x48c606cb, Offset: 0x1b3a
// Size: 0x10e
function private set_rumble()
{
    self waittill( #"hash_43c323f558763d65" );
    time_start_rumble = utility::function_6f5d2e1f1ff70482( gettime() );
    time_start_eq = utility::function_6f5d2e1f1ff70482( gettime() );
    
    while ( true )
    {
        if ( !isdefined( self.ap_machine.mdl_glass ) )
        {
            break;
        }
        
        var_b663fc67159f514d = self.ap_machine.mdl_glass getscriptablepartstate( "base", 1 );
        
        if ( var_b663fc67159f514d == "crack" )
        {
            break;
        }
        
        time = utility::function_6f5d2e1f1ff70482( gettime() );
        
        if ( time_start_rumble - time < 3 )
        {
            time_start_rumble = utility::function_6f5d2e1f1ff70482( gettime() );
            playrumbleonposition( "zm_ap_machine_rumble", self.ap_machine.origin );
        }
        
        if ( time_start_eq - time < 3 )
        {
            earthquake( 0.12, 1.5, self.ap_machine.origin, 300 );
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_livingworld
// Params 1, eflags: 0x4
// Checksum 0xa20a036f, Offset: 0x1c50
// Size: 0x71
function private function_6d39262410171ff7( ent )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    ent endon( #"death" );
    self endon( #"cancel_encounter" );
    ent waittill( #"break_tube" );
    ent val::reset( "living_world", "play_ambient_vo" );
    ent val::reset( "living_world", "allow_vo" );
}

// Namespace zm_sat_livingworld
// Params 0, eflags: 0x4
// Checksum 0x5ba7c6ac, Offset: 0x1cc9
// Size: 0x431
function private function_a0e8719e37d1d85b()
{
    if ( self.isplaying )
    {
        return;
    }
    
    if ( !isdefined( level._livingworld_info.a_ap_machine ) )
    {
        struct_ap_machine = utility::getstructarray( "lw_tube", "script_noteworthy" );
        scriptable_ap_machine = getentitylessscriptablearray( "lw_tube", #script_noteworthy );
        level._livingworld_info.a_ap_machine = arraycombine( struct_ap_machine, scriptable_ap_machine );
        
        for ( i = 0; i < level._livingworld_info.a_ap_machine.size ; i++ )
        {
            ap_machine = level._livingworld_info.a_ap_machine[ i ];
            
            if ( ap_machine utility::function_de1f80d93273abf5() )
            {
                ap_machine.mdl = ap_machine;
            }
            else
            {
                ap_machine.mdl = spawnscriptable( "t10_zm_ap_machine", ap_machine.origin, ap_machine.angles );
            }
            
            ap_machine.mdl_glass = spawnscriptable( "t10_zm_ap_machine_glass", ap_machine.origin, ap_machine.angles );
            ap_machine.mdl setscriptablepartstate( "base", "base" );
            ap_machine.mdl_glass setscriptablepartstate( "base", "base" );
            ap_machine.mayhem_num = i;
        }
    }
    
    if ( !isdefined( self.ap_machine ) )
    {
        self.ap_machine = utility::getstruct( self.target2, "targetname" );
        
        if ( !isdefined( self.ap_machine ) )
        {
            [ self.ap_machine ] = getentitylessscriptablearray( self.target2, #targetname );
        }
        
        var_562ec0674b1c118e = self.info_structs[ "living_world_swap_no_spawned" ];
        
        if ( isdefined( var_562ec0674b1c118e ) )
        {
            foreach ( info_struct in var_562ec0674b1c118e )
            {
                if ( !isdefined( info_struct.mdl ) || info_struct.var_2f54aeaff63fbdee )
                {
                    continue;
                }
                
                info_struct.mdl.origin += ( 8, 8, 0 );
            }
        }
    }
    
    if ( isdefined( self.ap_machine.mdl ) )
    {
        self.ap_machine.mdl utility::function_7c10ea82c1e305b8( "fx", "on" );
    }
    
    foreach ( a_ents in self.scene_ents )
    {
        foreach ( ent in a_ents )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            ent.b_ignore_water_check = 1;
            ent.var_2902ca09e32bd7d8 = 1;
            ent val::set( "living_world", "damage", 0 );
            ent val::set( "living_world", "death", 0 );
            ent val::set( "living_world", "allow_dismember", 0 );
        }
    }
}

// Namespace zm_sat_livingworld
// Params 1
// Checksum 0xa9e9ff27, Offset: 0x2102
// Size: 0x3d2
function function_bc93b233cebdb2d8( ent )
{
    self notify( #"hash_edfd63e7a0ecf19a" );
    self endon( #"hash_edfd63e7a0ecf19a" );
    level endon( #"game_ended" );
    self endon( #"death" );
    ent endon( #"death" );
    self endon( #"cancel_encounter" );
    
    if ( isdefined( self.ap_machine.mdl ) )
    {
        self.ap_machine.mdl utility::function_7c10ea82c1e305b8( "base", "base" );
    }
    
    if ( isdefined( self.ap_machine.mdl_glass ) )
    {
        self.ap_machine.mdl_glass utility::function_7c10ea82c1e305b8( "base", "base" );
    }
    
    self waittill( #"hash_43c323f558763d65" );
    
    if ( isdefined( self.ap_machine.mdl ) )
    {
        self.ap_machine.mdl utility::function_7c10ea82c1e305b8( "fx", "off" );
    }
    
    ent waittill( #"crack_tube" );
    
    foreach ( water in self.scene_ents[ "props" ] )
    {
        water delete();
    }
    
    foreach ( scene_ent in self.scene_ents[ "actors" ] )
    {
        if ( !isalive( scene_ent ) || !isai( scene_ent ) )
        {
            continue;
        }
        
        scene_ent val::set( "living_world", "damage", 1 );
        scene_ent val::set( "living_world", "death", 1 );
        scene_ent val::set( "living_world", "allow_dismember", 1 );
        scene_ent.var_2902ca09e32bd7d8 = 0;
    }
    
    if ( isdefined( self.ap_machine.mdl_glass ) )
    {
        self.ap_machine.mdl_glass utility::function_7c10ea82c1e305b8( "base", "crack" );
    }
    
    ent waittill( #"break_tube" );
    
    if ( !isdefined( self.ap_machine ) )
    {
        return;
    }
    
    spawnmayhem( "living_world_mayhem_" + self.ap_machine.mayhem_num, "vfx_mayh_sat_zm_ap_machine_main_glass", self.ap_machine.origin, self.ap_machine.angles );
    self.ap_machine.mayhem = "living_world_mayhem_" + self.ap_machine.mayhem_num;
    playmayhem( self.ap_machine.mayhem );
    self.ap_machine.mdl_glass utility::function_7c10ea82c1e305b8( "base", "dam" );
    self.ap_machine.mdl utility::function_7c10ea82c1e305b8( "base", "dam" );
    wait 1;
    killmayhem( self.ap_machine.mayhem );
    self.ap_machine.mayhem = undefined;
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x4ebb5cb0, Offset: 0x24dc
// Size: 0xff
function sat_cin_zm_living_world_tube_dud()
{
    function_a0e8719e37d1d85b();
    
    foreach ( prop in self.scene_ents[ "props" ] )
    {
        if ( !isdefined( prop ) || !prop tagexists( "tag_eye_glow_ri" ) || !prop tagexists( "tag_eye_glow_le" ) )
        {
            continue;
        }
        
        var_dfd8429deb9ee0f0 = prop gettagorigin( "tag_eye_glow_ri" );
        var_3afcda951fb8406a = prop gettagorigin( "tag_eye_glow_le" );
        playfx( level._effect[ "zmb_eye_glow" ], var_dfd8429deb9ee0f0 );
        playfx( level._effect[ "zmb_eye_glow" ], var_3afcda951fb8406a );
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x1eb1f74b, Offset: 0x25e3
// Size: 0x39
function sat_cin_zm_living_world_vermin_scare_jump()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars();
    self.action_func_vars = zm_livingworld::init_action_func_vars();
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xd528f1e0, Offset: 0x2624
// Size: 0x139
function sat_cin_zm_living_world_undr_low_obj_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint", undefined, undefined, undefined, undefined, undefined, 0 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( !self.isplaying )
    {
        foreach ( ent in self.scene_ents[ "actors" ] )
        {
            if ( !isalive( ent ) || !isai( ent ) )
            {
                continue;
            }
            
            excluded_dismemberment = [ "right_arm", "left_arm", "both_arms", "head" ];
            ent zm_livingworld::function_fbbc42d14f371113( 100, 30, excluded_dismemberment );
            ent val::set( "living_world", "collide_with_ai_allies" );
        }
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x4c3c8dfd, Offset: 0x2765
// Size: 0xf5
function sat_cin_zm_living_world_slumped_chair_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( !self.isplaying )
    {
        foreach ( ent in self.scene_ents[ "actors" ] )
        {
            if ( !isalive( ent ) || !isai( ent ) )
            {
                continue;
            }
            
            ent val::set( "living_world", "collide_with_ai_allies" );
        }
    }
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0x73b10fee, Offset: 0x2862
// Size: 0x8d
function function_fdfab27bdcab98f()
{
    b_cleanup_props = level.mapname == "zm_sat_core_features";
    prop = self.scene_ents[ "props" ][ 0 ];
    prop.var_7ee152b43c7188e1 = !self.isplaying;
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( undefined, undefined, undefined, b_cleanup_props );
    self.action_func_vars = zm_livingworld::init_action_func_vars( undefined, 1 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

// Namespace zm_sat_livingworld
// Params 0
// Checksum 0xf0bc701, Offset: 0x28f7
// Size: 0x133
function function_d4e1a10c23c9b8fe()
{
    ent = self.scene_ents[ "actors" ][ 0 ];
    e_chains = self.scene_ents[ "props" ][ 0 ];
    
    if ( !self.isplaying && isalive( ent ) && isai( ent ) )
    {
        ent val::set( "living_world", "collide_with_ai_allies" );
    }
    
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( self.isplaying && isalive( ent ) && isai( ent ) && !ent utility::ent_flag( "ent_scene_death_anim_playing" ) )
    {
        shot_length = self.scene_root scene::function_b3c7b792a7a154fa( "action" );
        wait shot_length;
        
        if ( isalive( ent ) && isai( ent ) && !ent utility::ent_flag( "ent_scene_death_anim_playing" ) )
        {
            function_32ee02d1fe9a37e8( ent, e_chains );
        }
    }
}

// Namespace zm_sat_livingworld
// Params 2, eflags: 0x4
// Checksum 0xca9664d3, Offset: 0x2a32
// Size: 0x1dd
function private function_32ee02d1fe9a37e8( ent, e_chains )
{
    level endon( #"game_ended" );
    self endon( #"death", #"cancel_encounter" );
    ent endon( #"death" );
    is_arm_anim = self.encounterstruct.scenebundle == "sat_cin_zm_living_world_hung_arms_long_zmb_ai" || self.encounterstruct.scenebundle == "sat_cin_zm_living_world_hung_arms_short_zmb_ai";
    
    if ( is_arm_anim )
    {
        excluded_dismemberment = [ "right_leg", "left_leg", "both_legs", "both_arms", "head" ];
    }
    else
    {
        excluded_dismemberment = [ "right_leg", "left_leg", "both_legs", "left_arm", "right_arm", "both_arms" ];
    }
    
    ent callback::add( "pre_killed_body_cloned", &function_5aefb434d40e1891, self );
    ent callback::add( "killed_body_cloned", &function_5aefb434d40e1891, self );
    ent utility::ent_flag_set( "stop_dismember_headless_dot" );
    ent val::reset( "living_world", "allow_dismember" );
    ent zm_livingworld::function_fbbc42d14f371113( 100, 0, excluded_dismemberment );
    ent animmode( "gravity_off_nav" );
    self.scene_root utility::delaythread( 0.2, &scene::stop );
    
    while ( isdefined( self.scene_root.scenedata ) )
    {
        waitframe();
    }
    
    if ( e_chains )
    {
        e_chains delete();
    }
    
    ent animmode( "gravity_off_nav" );
    ent thread zombie_knockdown::function_6fc167d4a3590991( ent.origin );
    
    if ( !is_arm_anim )
    {
        ent utility::delaythread( 5, &utility::ent_flag_clear, "stop_dismember_headless_dot" );
    }
}

// Namespace zm_sat_livingworld
// Params 2, eflags: 0x4
// Checksum 0xbd2ec7fc, Offset: 0x2c17
// Size: 0xd6
function private function_5aefb434d40e1891( sparams, var_650afee77554228c )
{
    if ( !self.is_living_world_ai )
    {
        return;
    }
    
    livingworldstruct = var_650afee77554228c;
    
    if ( !zm_livingworld::function_1d0b3d1864dce638( livingworldstruct ) )
    {
        return;
    }
    
    self animmode( "zonly_physics" );
    self.ragdollhitloc = "torso_lower";
    self.do_immediate_ragdoll = 1;
    self.forceragdollimmediate = 1;
    self.noragdoll = 0;
    self.script_noragdoll = 0;
    self.var_fd5c989cd241b6c4 = 0;
    self.disabledeathorient = 0;
    self.var_fd5c989cd241b6c4 = 0;
    
    if ( sparams.body )
    {
        callback::remove( "killed_body_cloned", &function_5aefb434d40e1891, livingworldstruct );
        return;
    }
    
    callback::remove( "pre_killed_body_cloned", &function_5aefb434d40e1891, livingworldstruct );
}

