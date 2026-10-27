// script_53600bb9c82cbdf2  (hash_53600bb9c82cbdf2.gscc) (size: 29123 Bytes / 0x71c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce2016cb (3458209483)
// size ...... 29123 (0x71c3)
// includes .. 20  (offset: 0x6a4b)
// strings ... 76  (offset: 0x6aeb)
// dev strs .. 46  (offset: 0x6f8f)
// exports ... 85  (offset: 0x4813)
// cseg ...... 0x811 + 0x4002 (0x4813)
// imports ... 162 (offset: 0x555b)
// animtree1 . 0   (offset: 0x71c3)
// animtree2 . 0   (offset: 0x71c3)
#using script_16ea1b94f0f381b3;
#using script_2d59c90cd0791757;
#using script_3aa124d2660239e3;
#using script_44c033c00a89e56d;
#using script_4714f11e284c32a4;
#using script_63715c31ee91a2d9;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\systems\zm_vo;

#namespace zombie_boss_virgil;

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0x79bfed86, Offset: 0x82f
// Size: 0xbb
function private function_7198bda0f5479fd6( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_f585ea798525ec7 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_e76af6e14d194699 );
    callback::get_template( self.animsetname ) callback::add( #"hash_7059ddcfb435dc40", &virgil_hide );
    callback::get_template( self.animsetname ) callback::add( #"hash_f2c8f928efab90f9", &virgil_show );
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x87e0596b, Offset: 0x8f2
// Size: 0x7c
function function_a4ec5bc6cd9af548( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    utility::function_32b24db3127bff40( "base", "base_on" );
    callback::add( "on_first_ai_init", &function_7198bda0f5479fd6 );
    zombie_utils::function_dfae6a5bd222c586( &function_769484be7fa6ac48 );
    self function_43a971093c992365( 1 );
    self forcenetfieldhighlod( 1 );
    set_boss_values();
    return anim.success;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x7eb7e5e8, Offset: 0x977
// Size: 0xb05
function function_c0e77c8f500f805c()
{
    zombie_boss_virgil_metabones::init_virgil_metabones();
    level.virgil_boss = { #var_16c64e122a6102eb:getdvarint( @"hash_8f76ddf8a3028c34", 1 ), #var_3690edf18d4e412a:getdvarfloat( @"hash_afdb3f86b18e268b", 5 ), #var_898d4faf41e71641:undefined, #var_3145efa13b9ea0ad:getdvarfloat( @"hash_f2d5c6c46336a9a6", 5 ), #var_56593fb6bce36aab:getdvarfloat( @"hash_16d0b8e1d71f17c4", 0.2 ), #var_d262acb091cc9e9a:getdvarfloat( @"hash_aaeb54aa36e63151", 0.55 ), #var_7a25467d794fb6e5:getdvarfloat( @"hash_9f038efde7bdb6be", 0.9 ), #var_67112de8432da461:getdvarint( @"hash_a9f3d1aa4dc1ffca", 3 ), #baltic_damage_multiplier:getdvarfloat( @"hash_ee14dd6fde6fd0fa", 0.65 ), #corso_damage_multiplier:getdvarfloat( @"hash_a4d93d4f4a717fef", 0.4 ), #shepherd_damage_multiplier:getdvarfloat( @"hash_98f90b672f9a1bb8", 0.35 ), #mammoth_damage_multiplier:getdvarfloat( @"hash_4b90e9f2631962b8", 1.15 ), #ray_gun_damage_multiplier:getdvarfloat( @"hash_8b012a94d5e118e8", 1.25 ), #var_ca5179cf4553503c:getdvarfloat( @"hash_3cb99bfbf83d4f9b", 0.4 ), #var_433acd5df547113b:getdvarfloat( @"hash_5cf79f56b86508ba", 0.6 ), #var_dac0773073c0d144:getdvarfloat( @"hash_6871b80ff35232d", 0.2 ), #alcor_damage_multiplier:getdvarfloat( @"hash_760816259d8f9ea6", 0.14 ), #melee_damage_multiplier:getdvarfloat( @"hash_9403b1e4d090eb39", 0.35 ), #warmachine_damage_multiplier:getdvarfloat( @"hash_a8ba4467ef0cb8bc", 0.5 ), #var_78e09839951fd1c4:getdvarfloat( @"hash_7936534961877c1f", 0.35 ), #var_512dd71778c047fa:getdvarfloat( @"hash_2278e14d82efe9d2", 0.4 ), #turret_damage_multiplier:getdvarfloat( @"hash_76f2ff47d69d0e35", 0.25 ), #spread_damage_multiplier:getdvarfloat( @"hash_71068c2dcd83043c", 1 ), #var_e77533599d878c5:getdvarfloat( @"hash_5bf5efb3cd287b40", 0.25 ), #general_damage_multiplier:getdvarfloat( @"hash_2f587026e5f79729", 1 ), #var_b41c6a9f1f5e9286:getdvarfloat( @"hash_a3dabf085460bf9", 0.5 ), #wunderbarrage_damage_multiplier:getdvarfloat( @"hash_2d857b677627909a", 0.15 ), #head_damage_multiplier:getdvarfloat( @"hash_68c64f58f9654461", 1.2 ), #skin_damage_multiplier:getdvarfloat( @"hash_c38fa5c94db07d8e", 0.1 ), #var_da29476bbf4d6a0e:getdvarint( @"hash_ded76ef1cc191fe7", 2 ), #weak_point_damage_multiplier:getdvarfloat( @"hash_ca8e01ed021ce34a", 1.6 ), #weak_point_timeout_sec:getdvarint( @"hash_bcd86971e1679446", 30 ), #var_4d7eb5c5650a48f8:getdvarint( @"hash_376a3f7a689b6897", 14 ), #weak_point_max:getdvarint( @"hash_4bf0189fab12ece5", 1 ), #weak_point_health_frac:getdvarfloat( @"hash_d83f0137abfef28c", 0.15 ), #var_358e66f1dc806ba2:getdvarfloat( @"hash_a7e474b92686cedf", 5 ), #var_5d0adf841779b7f2:undefined, #var_ced4275e5d862301:getdvarfloat( @"hash_79b8b7a5a9a6aace", 0.7 ), #var_a2237e4000b17fec:getdvarfloat( @"hash_914484021b04a151", 45 ), #var_a114d85a2c12418e:getdvarfloat( @"hash_baa33faff543db89", 2 ), #var_d4196fed65acc3be:getdvarfloat( @"hash_764b8f6d1a3421b5", 0.6 ), #var_724b96d61cf792d:getdvarfloat( @"hash_7aebc39b4513985c", 1 ), #var_5e2272cce8431cfa:utility::getstruct( "bossSceneScriptStruct03", "targetname" ), #var_5e2273cce8431f2d:utility::getstruct( "bossSceneScriptStruct02", "targetname" ), #var_5e2270cce8431894:utility::getstruct( "bossSceneScriptStruct01", "targetname" ), #var_523071ed022bda99:0, #is_immune:0 };
    level.virgil_boss.var_912b91f2467f9b42 = [ "torso_lower":[ "virgil_pain_plyr_facing_lower_01", "virgil_pain_plyr_facing_lower_02" ], "torso_upper":[ "virgil_pain_plyr_facing_upper_01", "virgil_pain_plyr_facing_upper_02" ], "arm_right":[ "virgil_pain_plyr_facing_r_arm" ], "arm_left":[ "virgil_pain_plyr_facing_l_arm" ], "head":[ "virgil_pain_plyr_facing_head", "virgil_pain_plyr_facing_head_02" ] ];
    level.virgil_boss.var_e75378df8574a44f = [ "torso_lower":[ "virgil_pain_bttl_lower_01", "virgil_pain_bttl_lower_02" ], "torso_upper":[ "virgil_pain_bttl_upper_01", "virgil_pain_bttl_upper_02" ], "arm_right":[ "virgil_pain_bttl_r_arm" ], "arm_left":[ "virgil_pain_bttl_l_arm" ], "head":[ "virgil_pain_bttl_head", "virgil_pain_bttl_head_02" ] ];
    level.virgil_boss.var_e78a9ab7bb7782ab = [ "torso_lower":[ "weakspot_stomach_left" ], "torso_upper":[ "weakspot_chest_right" ], "arm_right":[ "weakspot_forearm_right", "weakspot_elbow_right" ], "arm_left":[ "weakspot_armpit_left", "weakspot_elbow_left", "weakspot_forearm_left" ] ];
    level.virgil_boss.var_d9dce600db48ced7 = [ "weakspot_stomach_left":"torso_lower", "weakspot_chest_right":"torso_upper", "weakspot_elbow_right":"arm_right", "weakspot_forearm_right":"arm_right", "weakspot_forearm_left":"arm_left", "weakspot_elbow_left":"arm_left", "weakspot_armpit_left":"arm_left" ];
    zombie_boss_healthbar::init_zombie_boss_healthbar();
    var_2de9031f0bd6faa9 = getdvarfloat( @"virgil_health_scalar", 1 );
    
    if ( var_2de9031f0bd6faa9 < 1 )
    {
        ai::set_ai_max_health( int( self.maxhealth * var_2de9031f0bd6faa9 ) );
        self.var_9dd11279d5e371c7 *= var_2de9031f0bd6faa9;
        self.health = self.maxhealth;
    }
    
    level.virgil_boss.var_a2e3bab552f04c2b = { #var_da29476bbf4d6a0e:level.virgil_boss.var_da29476bbf4d6a0e, #weak_point_timeout_sec:level.virgil_boss.weak_point_timeout_sec, #var_5275d938754b334c:1, #var_4d7eb5c5650a48f8:level.virgil_boss.var_4d7eb5c5650a48f8, #weak_point_damage_multiplier:level.virgil_boss.weak_point_damage_multiplier, #weak_point_health_frac:level.virgil_boss.weak_point_health_frac, #var_35e16c5719638f4c:level.virgil_boss.weak_point_max };
    self.armored_locations = [ "head", "arm_left", "arm_right", "torso_lower", "torso_upper" ];
    self.special_locations = [];
    self.weak_points_hidden = 0;
    self.active_weak_points = [];
    self.weak_point_settings = level.virgil_boss.var_a2e3bab552f04c2b;
    self.state_change_timestamp_ms = gettime();
    self.state_change_count = 0;
    self.armor_health_damage_multiplier = 7;
    self.var_317816f65dd8fd6c = 2;
    self.var_2fc3a5fb762afb6e = 1;
    namespace_fd7b16d2452999a9::init();
    namespace_589ae4efe3ba85ad::init();
    zombie_boss_virgil_totem_attack::init();
    namespace_dba99780c141b678::init();
    metabone::set_metabone_active( "head", 0 );
    utility::add_fx( "virgil_wp_impact", "vfx_sat_zm_locust_virgil_fight_weak_point_bullet_impacts" );
    utility::add_fx( "virgil_wp_impact_pap", "vfx_sat_zm_locust_virgil_fight_weak_point_bullet_impacts_pap" );
    register_boss_banter( #"weakpoint_first", #"hash_23c8705a2ff1d926", #"bc_flavor_player_positive", 1, 60 );
    register_boss_banter( #"pops_knockdown_first", #"hash_64344740877ece2c", #"bc_flavor_player_negative", 0, undefined, 1 );
    register_boss_banter( #"virgil_knockdown_first", #"hash_279ae0e183e3bc4b", #"bc_flavor_player_positive", 0, undefined, 1 );
    register_boss_banter( #"hash_f97707d9b2c60f0", #"hash_a6ec0551a01d120d", undefined, 1, undefined, 1 );
    register_boss_banter( #"hash_6cb37c3368099316", #"hash_bfa4495ba8e65154", undefined, 1, undefined, 1 );
    register_boss_banter( #"runic_volley_first", #"hash_8f0bdeeef98d32f6", undefined, 1, 60, 1 );
    register_boss_banter( #"hash_d86403afb0b514e5", #"hash_1f1abfae8afecd9d", undefined, 0, 60, 1 );
    register_boss_banter( #"totem_mouth_first", #"hash_3b1bf0a90b24ba00", undefined, 1, 60 );
    register_boss_banter( #"charge_bomb_first", #"hash_eb108780c3e85113", undefined, 1, 60, 1 );
    register_boss_banter( #"pops_defeated", #"hash_50aeb4599ec50263", undefined, 1, undefined, 1 );
    register_boss_banter( #"hash_c92603fbad70b904", #"hash_2014ccc3da9a019f", #"bc_flavor_player_positive", 0, undefined, 1 );
    register_boss_banter( #"pops_recovers", #"hash_e6f2fb63c6f4eba0", undefined, 1, undefined, 1 );
    register_boss_banter( #"virgil_killed", #"hash_c15530621ddd676c", #"bc_flavor_player_positive", 0, undefined, 1 );
    register_boss_dialogue( #"virgil_appear", "dx_zm_lobf_bfp1_sslo_lbf1bfst", 7.5, 1 );
    register_boss_dialogue( #"wp_destroy", "dx_locust_virgil_exert_pain", undefined, 0, 5 );
    register_boss_dialogue( #"virgil_return", "dx_zm_lobf_bfp1_sslo_lbf1ssrt1t", undefined, 1 );
    register_boss_dialogue( #"runic_volley_first", "dx_zm_lobf_bfp1_sslo_lbf1rncvl1t", undefined, 1 );
    register_boss_dialogue( #"totem_first", "dx_zm_lobf_bflo_sslo_lbfph2st", undefined, 1 );
    register_boss_dialogue( #"virgil_defeats_pops", "dx_zm_lobf_bflo_sslo_lbfrbfldet", undefined, 1 );
    register_boss_dialogue( #"hash_e7564cd0438f9e82", "dx_zm_lobf_bflo_sslo_lbfph3st", undefined, 1 );
    
    /#
        virgil_debug();
    #/
    
    thread function_972ccc97adb5b626();
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x9a62a6d5, Offset: 0x1484
// Size: 0x97
function boss_fight_begin()
{
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_boss_virgil_healthbar", self );
    }
    
    level.virgil_boss.var_523071ed022bda99 = 1;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x53e0e4fc, Offset: 0x1523
// Size: 0xcd
function function_9cc2b48802345520()
{
    foreach ( player in level.players )
    {
        if ( isalive( level.virgil_entity ) )
        {
            if ( !self.is_immune && level.virgil_boss.var_523071ed022bda99 )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_boss_virgil_healthbar", self );
            }
            else
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_immune();
            }
            
            continue;
        }
        
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x466c1a21, Offset: 0x15f8
// Size: 0x19
function update_state_change()
{
    self.state_change_timestamp_ms = gettime();
    self.state_change_count++;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x8688b436, Offset: 0x1619
// Size: 0x33
function current_health_percent()
{
    return clamp( level.virgil_entity.health / level.virgil_entity.maxhealth * 100, 0, 100 );
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0xc42c6d16, Offset: 0x1655
// Size: 0x665
function function_ca4558c8ac3fa9f7( params )
{
    damage = params.idamage * level.virgil_boss.general_damage_multiplier;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= level.virgil_boss.var_67112de8432da461 )
        {
            if ( paplevel >= 4 )
            {
                damage *= level.virgil_boss.var_d262acb091cc9e9a;
            }
            else
            {
                damage *= level.virgil_boss.var_7a25467d794fb6e5;
            }
        }
    }
    
    if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= level.virgil_boss.var_e77533599d878c5;
    }
    
    if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= level.virgil_boss.spread_damage_multiplier;
    }
    
    if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= level.virgil_boss.turret_damage_multiplier;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= level.virgil_boss.var_512dd71778c047fa;
        }
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= level.virgil_boss.var_78e09839951fd1c4;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= level.virgil_boss.warmachine_damage_multiplier;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= level.virgil_boss.melee_damage_multiplier;
    }
    
    if ( params.objweapon.basename == "sat_zm_wunderbarrage_missile_proj" )
    {
        damage *= level.virgil_boss.wunderbarrage_damage_multiplier;
    }
    
    if ( isdefined( function_f02c63b99c9614c9( [ %"sat_pi_timir_mp", %"sat_dm_kara_mp" ], params.objweapon.basenamehash ) ) )
    {
        damage *= level.virgil_boss.var_b41c6a9f1f5e9286;
    }
    else if ( params.objweapon.basenamehash == %"sat_pi_alcor_mp" )
    {
        damage *= level.virgil_boss.alcor_damage_multiplier;
    }
    else if ( params.objweapon.basenamehash == %"sat_ks_deathmachine" )
    {
        damage *= level.virgil_boss.var_dac0773073c0d144;
    }
    else if ( params.objweapon.basenamehash == %"sat_ks_warmachine" )
    {
        damage *= level.virgil_boss.var_433acd5df547113b;
    }
    else if ( params.objweapon.basenamehash == %"sat_ks_handcannon" )
    {
        damage *= level.virgil_boss.var_ca5179cf4553503c;
    }
    else if ( params.objweapon.basenamehash == %"sat_ww_raygun_mp" )
    {
        damage *= level.virgil_boss.ray_gun_damage_multiplier;
    }
    else if ( params.objweapon.basenamehash == %"sat_sm_mammoth_mp" )
    {
        damage *= level.virgil_boss.mammoth_damage_multiplier;
    }
    else if ( params.objweapon.basenamehash == %"sat_sh_shepherd_mp" )
    {
        damage *= level.virgil_boss.shepherd_damage_multiplier;
    }
    else if ( params.objweapon.basenamehash == %"sat_sh_corso_mp" )
    {
        damage *= level.virgil_boss.corso_damage_multiplier;
    }
    else if ( params.objweapon.basenamehash == %"sat_sn_baltic_mp" )
    {
        damage *= level.virgil_boss.baltic_damage_multiplier;
    }
    
    if ( params.metabonename && level.virgil_entity metabone::get_metabone_state_name( params.metabonename ) == "exposed_enabled" )
    {
        if ( params.metabonename == "head" )
        {
            damage *= level.virgil_boss.head_damage_multiplier;
        }
        else
        {
            damage *= level.virgil_entity.weak_point_settings.weak_point_damage_multiplier;
        }
    }
    else
    {
        damage *= level.virgil_boss.skin_damage_multiplier;
    }
    
    if ( damage > 0 )
    {
        damage = roundint( damage );
    }
    
    /#
        if ( getdvarint( @"hash_99a3633430407ed0", 0 ) && isplayer( params.eattacker ) && params.eattacker == level.players[ 0 ] )
        {
            damage *= 3.5;
        }
    #/
    
    return damage;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x48bfaa, Offset: 0x1cc3
// Size: 0x60
function function_be62689fc9735cc8( var_b0fb0169d6923562 )
{
    damage = var_b0fb0169d6923562 * level.virgil_entity.maxhealth;
    level.virgil_entity dodamage( damage, level.virgil_entity.origin, undefined, undefined, undefined, undefined, "none", undefined, 65536 );
}

// Namespace zombie_boss_virgil
// Params 4
// Checksum 0x386f4de6, Offset: 0x1d2b
// Size: 0xcf
function function_682e7757f916b296( shot_name, bundle_override = undefined, var_4e0e1dd8f8a93e4d = 1, var_4e7b169f0a9cb0cc = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death", #"hash_7ffd9295d37efbf1" );
    
    if ( var_4e7b169f0a9cb0cc )
    {
        utility::ent_flag_set( "flag_virgil_busy_scene" );
    }
    
    bundle_override = bundle_override ?? level.virgil_boss.var_5e2272cce8431cfa;
    bundle_override scene::play( self, shot_name );
    
    if ( var_4e0e1dd8f8a93e4d )
    {
        level.virgil_boss.var_5e2270cce8431894 thread scene::play( self, "virgil_player_facing_idle" );
    }
    
    if ( var_4e7b169f0a9cb0cc )
    {
        utility::ent_flag_clear( "flag_virgil_busy_scene" );
    }
}

// Namespace zombie_boss_virgil
// Params 3
// Checksum 0x91636bf0, Offset: 0x1e02
// Size: 0x112
function set_virgil_in_pain( pain_location = undefined, var_1690b984ea8c634a = 1, var_4e0e1dd8f8a93e4d = 1 )
{
    if ( !utility::ent_flag( "flag_virgil_in_pain" ) && !utility::ent_flag( "flag_virgil_busy_scene" ) )
    {
        utility::ent_flag_set( "flag_virgil_in_pain" );
        self notify( #"hash_7ffd9295d37efbf1" );
        utility::ent_flag_clear( "flag_virgil_attack_charge_bomb" );
        utility::ent_flag_clear( "flag_virgil_attack_runic_volley" );
        var_d0f3f1aa4f5c2941 = var_1690b984ea8c634a ? level.virgil_boss.var_912b91f2467f9b42 : level.virgil_boss.var_e75378df8574a44f;
        
        if ( !isdefined( pain_location ) )
        {
            shot_name = utility::array_random( var_d0f3f1aa4f5c2941[ "torso_upper" ] );
            function_682e7757f916b296( shot_name, undefined, var_4e0e1dd8f8a93e4d );
        }
        else
        {
            shot_name = utility::array_random( var_d0f3f1aa4f5c2941[ pain_location ] );
            function_682e7757f916b296( shot_name, undefined, var_4e0e1dd8f8a93e4d );
        }
        
        utility::ent_flag_clear( "flag_virgil_in_pain" );
    }
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x1708691d, Offset: 0x1f1c
// Size: 0x1c, Type: bool
function function_31854a9e29e8d2d()
{
    return utility::ent_flag( "flag_virgil_attack_runic_volley" ) || utility::ent_flag( "flag_virgil_attack_charge_bomb" );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x2e8d1e21, Offset: 0x1f41
// Size: 0x3c, Type: bool
function function_8fc422943bc5c65a()
{
    if ( function_31854a9e29e8d2d() || utility::ent_flag( "flag_virgil_in_pain" ) || utility::ent_flag( "flag_virgil_busy_scene" ) || utility::ent_flag( "flag_virgil_hidden" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_boss_virgil
// Params 0, eflags: 0x4
// Checksum 0x59909982, Offset: 0x1f86
// Size: 0x65
function private function_972ccc97adb5b626()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !function_8fc422943bc5c65a() )
        {
            if ( utility::ent_flag( "flag_virgil_is_ready" ) )
            {
                utility::ent_flag_clear( "flag_virgil_is_ready" );
            }
        }
        else if ( !utility::ent_flag( "flag_virgil_is_ready" ) )
        {
            utility::ent_flag_set( "flag_virgil_is_ready" );
        }
        
        waitframe();
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0x979a97, Offset: 0x1ff3
// Size: 0x2b
function private play_death_fx( params )
{
    if ( isdefined( params.body ) )
    {
        params.body delete();
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0x1b35424, Offset: 0x2026
// Size: 0x7d
function private function_769484be7fa6ac48( params )
{
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.virgil_boss ) )
    {
        return 0;
    }
    
    if ( self.is_immune )
    {
        return 0;
    }
    
    if ( params.metabonename && level.virgil_entity metabone::get_metabone_state_name( params.metabonename ) == "exposed_enabled" )
    {
        params.biscritical = 1;
    }
    
    return function_ca4558c8ac3fa9f7( params );
}

// Namespace zombie_boss_virgil
// Params 6
// Checksum 0x68040179, Offset: 0x20ac
// Size: 0x116
function register_boss_banter( key, var_d9a98ad3b14f016a, fallback, per_player = 0, cooldown, var_95b86e61b2c6a7 = 0 )
{
    data = { #var_95b86e61b2c6a7:var_95b86e61b2c6a7, #players:[], #var_2cda4fec82ac854c:0, #cooldown:cooldown, #per_player:per_player, #fallback:fallback, #var_d9a98ad3b14f016a:var_d9a98ad3b14f016a, #key:key };
    
    if ( !isdefined( level.virgil_boss.banters ) )
    {
        level.virgil_boss.banters = [];
    }
    
    assert( !level.virgil_boss.banters[ key ], "<dev string:x24>" + key );
    level.virgil_boss.banters[ key ] = data;
}

// Namespace zombie_boss_virgil
// Params 5
// Checksum 0x651c066d, Offset: 0x21ca
// Size: 0xe8
function register_boss_dialogue( key, dialogue, delay, one_off, cooldown )
{
    data = { #var_2cda4fec82ac854c:0, #cooldown:cooldown, #one_off:one_off, #delay:delay, #dialogue:dialogue, #key:key };
    
    if ( !isdefined( level.virgil_boss.dialogues ) )
    {
        level.virgil_boss.dialogues = [];
    }
    
    assert( !level.virgil_boss.dialogues[ key ], "<dev string:x3f>" + key );
    level.virgil_boss.dialogues[ key ] = data;
}

// Namespace zombie_boss_virgil
// Params 3
// Checksum 0x5ad90e37, Offset: 0x22ba
// Size: 0x14a
function function_9c386609d0280bef( key, player, forced )
{
    if ( !isxhash( key ) )
    {
        key = getxhash( key );
    }
    
    data = level.virgil_boss.banters[ key ];
    assert( data, "<dev string:x5c>" + key );
    
    if ( !player && data.var_95b86e61b2c6a7 )
    {
        player = get_any_hero( 1 );
    }
    
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    if ( !forced )
    {
        if ( data.per_player )
        {
            if ( arraycontains( data.players, player ) )
            {
                return;
            }
            
            if ( data.cooldown && !utility::time_has_passed( data.var_2cda4fec82ac854c, data.cooldown ) )
            {
                return;
            }
            
            data.players[ data.players.size ] = player;
        }
        else if ( data.var_2cda4fec82ac854c )
        {
            return;
        }
    }
    
    data.var_2cda4fec82ac854c = gettime();
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( data.var_d9a98ad3b14f016a, data.fallback );
}

// Namespace zombie_boss_virgil
// Params 3
// Checksum 0x48a53a94, Offset: 0x240c
// Size: 0x5b
function function_d6cf55dbb78f41c8( key, banter_key, forced = 0 )
{
    level.virgil_entity endon( #"death" );
    boss_play_dialogue( key, forced );
    level.virgil_entity waittill( key );
    function_9c386609d0280bef( banter_key );
}

// Namespace zombie_boss_virgil
// Params 2
// Checksum 0xdb80a466, Offset: 0x246f
// Size: 0x133
function boss_play_dialogue( key, forced = 0 )
{
    if ( !isxhash( key ) )
    {
        key = getxhash( key );
    }
    
    data = level.virgil_boss.dialogues[ key ];
    assert( data, "<dev string:x7a>" + key );
    
    if ( !forced )
    {
        if ( data.dialogue && !utility::time_has_passed( data.var_2cda4fec82ac854c, data.cooldown ) )
        {
            return;
        }
        
        if ( data.one_off && data.var_2cda4fec82ac854c )
        {
            return;
        }
        
        delay = data.delay;
    }
    else
    {
        delay = undefined;
    }
    
    data.var_2cda4fec82ac854c = gettime();
    
    if ( isarray( data.dialogue ) )
    {
        dialogue = utility::array_random( data.dialogue );
    }
    else
    {
        dialogue = data.dialogue;
    }
    
    level.virgil_entity thread boss_say_self( key, dialogue, delay );
}

// Namespace zombie_boss_virgil
// Params 3, eflags: 0x4
// Checksum 0xc50713a0, Offset: 0x25aa
// Size: 0x56
function private boss_say_self( key, dialogue, delay )
{
    level.virgil_entity endon( #"death" );
    level.virgil_entity dialogue::say_self( dialogue, undefined, undefined, undefined, delay );
    level.virgil_entity notify( key );
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0x55c8bc2e, Offset: 0x2608
// Size: 0x260
function private function_f585ea798525ec7( params )
{
    if ( self.is_immune || params.idamage == 0 )
    {
        return;
    }
    
    if ( params.metabonename && level.virgil_entity metabone::get_metabone_state_name( params.metabonename ) == "exposed_enabled" )
    {
        function_9c386609d0280bef( #"weakpoint_first", params.eattacker );
        
        if ( params.metabonename != "head" )
        {
            weak_point_struct = level.virgil_entity.active_weak_points[ params.metabonename ];
            assert( isdefined( weak_point_struct ), "<dev string:x9a>" + params.metabonename + "<dev string:xae>" );
            weak_point_struct.damage_taken += params.idamage;
            
            if ( weak_point_struct.damage_taken >= weak_point_struct.health )
            {
                thread kill_weak_point( weak_point_struct );
            }
        }
        
        if ( level.virgil_boss.var_16c64e122a6102eb )
        {
            current_time_ms = gettime();
            enough_time_has_passed = !isdefined( self.var_278b5a44b66e9c43 ) || self.var_278b5a44b66e9c43 <= current_time_ms;
            
            if ( enough_time_has_passed )
            {
                if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
                {
                    paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
                    
                    if ( paplevel > 0 )
                    {
                        playfx( utility::getfx( "virgil_wp_impact_pap" ), params.vpoint );
                    }
                    else
                    {
                        playfx( utility::getfx( "virgil_wp_impact" ), params.vpoint );
                    }
                }
                else if ( isdefined( params.sweapon ) )
                {
                    playfx( utility::getfx( "virgil_wp_impact" ), params.vpoint );
                }
                
                self.var_278b5a44b66e9c43 = current_time_ms + level.virgil_boss.var_56593fb6bce36aab * 1000;
            }
        }
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0x1d190ec9, Offset: 0x2870
// Size: 0x16
function private function_e76af6e14d194699( params )
{
    logstring( "[LOCUST BOSS] Virgil has been killed" );
}

// Namespace zombie_boss_virgil
// Params 0, eflags: 0x4
// Checksum 0x8b7cd486, Offset: 0x288e
// Size: 0xe8
function private set_boss_values()
{
    val::set( "virgil", "trigger_hurt_damage", 0 );
    val::set( "virgil", "ignore_cleanup", 1 );
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.b_ignore_monkey_bomb = 1;
    self.b_ignore_frenzied_guard = 1;
    self.b_disable_annihilate = 1;
    self.b_ignore_water_check = 1;
    self.var_1bc1a37495c8ca04 = 1;
    self.var_bfa7ca2a8740bf7b = 1;
    self.ignore_enemy_count = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.var_5a9c952260ab1cf = 1;
    self.no_powerups = 1;
    self.disable_brain_rot = 1;
    self.action_cooldowns = [ 1, 1, 1 ];
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0xb0ebb3e3, Offset: 0x297e
// Size: 0xba
function virgil_hide( params )
{
    foreach ( linked_child in level.virgil_entity getlinkedchildren() )
    {
        linked_child hide();
    }
    
    level.virgil_entity hide();
    level.virgil_entity setcandamage( 0 );
    level.virgil_boss.var_31ba46fce3c9ee93 = 1;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0xbfe639ec, Offset: 0x2a40
// Size: 0x3f
function virgil_show( params )
{
    level.virgil_entity show();
    level.virgil_entity setcandamage( 1 );
    level.virgil_boss.var_31ba46fce3c9ee93 = 0;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xd04ddfbe, Offset: 0x2a87
// Size: 0x7b
function function_f045e7a90b276444()
{
    foreach ( player in level.players )
    {
        function_8c7b9b9da0fc6edf( player );
    }
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x205292d2, Offset: 0x2b0a
// Size: 0x8a
function function_8c7b9b9da0fc6edf( player )
{
    self notify( #"hash_f420738cdbdf2141" );
    self endon( #"hash_f420738cdbdf2141" );
    
    if ( player.var_e5557a1483620915 )
    {
        return;
    }
    
    if ( function_23321ff001c537b( player ) )
    {
        return;
    }
    
    player thread utility::callsharedfunc( #"zm_blizzard", #"freeze_player" );
    player thread function_c0d35977ab8f9789();
    player thread function_65bad44c9d8592fb();
    player.var_975bf7fd8d79d1c7 = gettime();
    player.var_e5557a1483620915 = 1;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0xe2e986ce, Offset: 0x2b9c
// Size: 0x48, Type: bool
function function_23321ff001c537b( player )
{
    return player utility::callsharedfunc( #"locust_ww", #"hash_5f2e6769ea79096e" ) || player utility::ent_flag( "blizzard_immune" ) || player utility::ent_flag( "wiley_fox_active" );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xba814fd2, Offset: 0x2bed
// Size: 0x7b
function function_1c0102bd87cded9()
{
    foreach ( player in level.players )
    {
        function_a09504af23da06b0( player );
    }
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x1135b5ce, Offset: 0x2c70
// Size: 0xb3
function function_a09504af23da06b0( player )
{
    self notify( #"hash_a98e8a329fab70d3" );
    self endon( #"hash_a98e8a329fab70d3" );
    
    if ( !player.var_e5557a1483620915 )
    {
        return;
    }
    
    player thread utility::callsharedfunc( #"zm_blizzard", #"hash_6bb3b928d432c637" );
    player thread utility::callsharedfunc( #"zm_blizzard", #"hash_f95768c13efc10ab", 1, 1 );
    player setscriptablepartstate( #"snow_fx", #"all_vfx_off", 0 );
    player.var_975bf7fd8d79d1c7 = undefined;
    player.var_e5557a1483620915 = 0;
    player notify( #"hash_91fc19c2e16b1604" );
}

// Namespace zombie_boss_virgil
// Params 0, eflags: 0xc
// Checksum 0x9ce0bc5a, Offset: 0x2d2b
// Size: 0xb7
function private function_c0d35977ab8f9789()
{
    self notify( #"hash_91bd8321660d9f74" );
    self endon( #"hash_91bd8321660d9f74" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_91fc19c2e16b1604" );
    wait level.virgil_boss.var_724b96d61cf792d;
    
    while ( true )
    {
        var_6de0dad2d7531eb9 = level.virgil_boss.var_5d0adf841779b7f2 ?? level.virgil_boss.var_ced4275e5d862301;
        thread utility::callsharedfunc( #"zm_blizzard", #"set_freeze_movespeed", 0.05, var_6de0dad2d7531eb9 );
        wait level.virgil_boss.var_d4196fed65acc3be;
    }
}

// Namespace zombie_boss_virgil
// Params 0, eflags: 0xc
// Checksum 0xdf1c8ce5, Offset: 0x2dea
// Size: 0x145
function private function_65bad44c9d8592fb()
{
    self notify( #"hash_cc6256970d5305a6" );
    self endon( #"hash_cc6256970d5305a6" );
    self endon( #"death_or_disconnect" );
    level.virgil_entity endon( #"death" );
    self endon( #"hash_91fc19c2e16b1604" );
    wait level.virgil_boss.var_724b96d61cf792d;
    
    while ( true )
    {
        var_1c7d0d75248d7fb1 = namespace_589ae4efe3ba85ad::function_7ed660c91ba7ca82( self ) || level.virgil_entity utility::ent_flag( "flag_virgil_freeze_periodic_damage_active" );
        
        if ( var_1c7d0d75248d7fb1 && isalive( self ) && !player::isinlaststand( self ) )
        {
            enough_time_has_passed = ( gettime() - self.var_975bf7fd8d79d1c7 ) * 0.001 >= level.virgil_boss.var_358e66f1dc806ba2;
            
            if ( enough_time_has_passed )
            {
                self dodamage( level.virgil_boss.var_a2237e4000b17fec, self.origin, level.virgil_entity, undefined, "MOD_UNKNOWN", undefined, "torso_upper", undefined, 0 );
                self playsoundevent( "zm_locust_boss_virgil_cold_damage" );
                pbgpostfxbundlestart( self, %"sat_zm_virgil_freeze" );
            }
        }
        
        wait level.virgil_boss.var_a114d85a2c12418e;
    }
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xcc9f337e, Offset: 0x2f37
// Size: 0x1e
function function_3b6570c25cc5176e()
{
    level.virgil_entity utility::ent_flag_set( "flag_virgil_freeze_effects_active" );
    function_f045e7a90b276444();
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xba5e6a2f, Offset: 0x2f5d
// Size: 0x1e
function function_b3044af60fb9ebb7()
{
    level.virgil_entity utility::ent_flag_clear( "flag_virgil_freeze_effects_active" );
    function_1c0102bd87cded9();
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x2251dd26, Offset: 0x2f83
// Size: 0x22
function function_20fbfb695885d7be( slow_override )
{
    level.virgil_boss.var_5d0adf841779b7f2 = slow_override;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x70eb1d6, Offset: 0x2fad
// Size: 0x15
function function_76653291ef09c793()
{
    level.virgil_boss.var_5d0adf841779b7f2 = undefined;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x5d0b80d4, Offset: 0x2fca
// Size: 0xbe, Type: bool
function has_body_armor()
{
    body_armor_locations = [ "arm_left", "arm_right", "torso_lower", "torso_upper" ];
    
    foreach ( var_6337887a136ec510 in body_armor_locations )
    {
        if ( level.virgil_entity getscriptablepartstate( getxhash( var_6337887a136ec510 ) ) == #"armored" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x7b3ff6ea, Offset: 0x3091
// Size: 0x45
function function_1c3066df3a64ff1b( var_6337887a136ec510 )
{
    level.virgil_entity setscriptablepartstate( getxhash( var_6337887a136ec510 ), #"exposed" );
    callback::callback( #"hash_5edc11f1ffe674ff", { #var_6337887a136ec510:var_6337887a136ec510 } );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x4eb6bccd, Offset: 0x30de
// Size: 0xc3
function function_dab167edcd6162fa()
{
    foreach ( var_6337887a136ec510 in [ "head", "arm_left", "arm_right", "torso_lower", "torso_upper" ] )
    {
        if ( !level.virgil_entity.special_locations[ var_6337887a136ec510 ] )
        {
            level.virgil_entity thread function_1c3066df3a64ff1b( var_6337887a136ec510 );
        }
    }
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x61e1d4fc, Offset: 0x31a9
// Size: 0x24
function function_333e5267a078290c( var_6337887a136ec510 )
{
    level.virgil_entity.special_locations[ var_6337887a136ec510 ] = var_6337887a136ec510;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xfd10d8b6, Offset: 0x31d5
// Size: 0x2f
function enable_immunity()
{
    level.virgil_entity.is_immune = 1;
    function_760120540374bc8d();
    level.virgil_entity thread function_9cc2b48802345520();
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xd2fb5ab7, Offset: 0x320c
// Size: 0x27
function disable_immunity()
{
    level.virgil_entity.is_immune = 0;
    level.virgil_entity thread function_9cc2b48802345520();
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0xf9d95967, Offset: 0x323b
// Size: 0x66
function show_weak_point( weak_point_struct )
{
    level.virgil_entity metabone::set_metabone_state( weak_point_struct.name, "exposed_enabled" );
    level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_struct.name ), #"spawned" );
    function_135c65b25c342aab( weak_point_struct.name );
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x7e1b9fd6, Offset: 0x32a9
// Size: 0xb3
function hide_weak_point( weak_point_struct )
{
    level.virgil_entity metabone::set_metabone_state( weak_point_struct.name, "exposed_disabled" );
    
    if ( level.virgil_entity.active_weak_points[ weak_point_struct.name ] )
    {
        level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_struct.name ), #"hash_8f87ab97a15702e0" );
    }
    else
    {
        level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_struct.name ), #"inactive" );
    }
    
    function_6742c1294d78f32e( weak_point_struct.name );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x2b771f49, Offset: 0x3364
// Size: 0x9a
function function_7b87ea5cec2388a6()
{
    foreach ( weak_point_struct in level.virgil_entity.active_weak_points )
    {
        show_weak_point( weak_point_struct );
    }
    
    level.virgil_entity.weak_points_hidden = 0;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x10e8c19e, Offset: 0x3406
// Size: 0x9b
function function_64ecba8d40b7f9d7()
{
    foreach ( weak_point_struct in level.virgil_entity.active_weak_points )
    {
        hide_weak_point( weak_point_struct );
    }
    
    level.virgil_entity.weak_points_hidden = 1;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x16a4784d, Offset: 0x34a9
// Size: 0x2d, Type: bool
function is_weak_point_hidden( weak_point_struct )
{
    return !( level.virgil_entity metabone::get_metabone_state_name( weak_point_struct.name ) == "exposed_enabled" );
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x70cf761c, Offset: 0x34df
// Size: 0xf5
function kill_weak_point( weak_point_struct )
{
    level.virgil_entity metabone::set_metabone_state( weak_point_struct.name, "exposed_disabled" );
    
    if ( level.virgil_entity.active_weak_points[ weak_point_struct.name ] )
    {
        level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_struct.name ), #"destroyed" );
        boss_play_dialogue( #"wp_destroy" );
    }
    
    function_6742c1294d78f32e( weak_point_struct.name );
    level.virgil_entity thread callback::callback( #"hash_89720860d7fd7978", { #was_killed:1, #weak_point_struct:weak_point_struct } );
    level.virgil_entity.active_weak_points = function_a5c1175d3ea3c25a( level.virgil_entity.active_weak_points, weak_point_struct );
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x543fc8b4, Offset: 0x35dc
// Size: 0xe4
function despawn_weak_point( weak_point_struct )
{
    level.virgil_entity metabone::set_metabone_state( weak_point_struct.name, "exposed_disabled" );
    
    if ( level.virgil_entity.active_weak_points[ weak_point_struct.name ] )
    {
        level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_struct.name ), #"hash_8f87ab97a15702e0" );
    }
    
    function_6742c1294d78f32e( weak_point_struct.name );
    level.virgil_entity thread callback::callback( #"hash_89720860d7fd7978", { #was_killed:0, #weak_point_struct:weak_point_struct } );
    level.virgil_entity.active_weak_points = function_a5c1175d3ea3c25a( level.virgil_entity.active_weak_points, weak_point_struct );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x25b0d8b3, Offset: 0x36c8
// Size: 0x85
function function_760120540374bc8d()
{
    foreach ( weak_point_struct in level.virgil_entity.active_weak_points )
    {
        despawn_weak_point( weak_point_struct );
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0xacfa322, Offset: 0x3755
// Size: 0xa0
function private function_135c65b25c342aab( weak_point_struct_name )
{
    if ( level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] && !level.virgil_boss.var_31ba46fce3c9ee93 )
    {
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] setscriptablepartstate( #"icon", #"exposed" );
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] enableaimassist();
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] show();
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0xc3abd0c8, Offset: 0x37fd
// Size: 0xa5
function private function_6742c1294d78f32e( weak_point_struct_name )
{
    if ( level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] )
    {
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] setscriptablepartstate( #"icon", #"off" );
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] disableaimassist();
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] calloutmarkerping::function_608710c894185549();
        level.virgil_entity.weak_point_objectives[ weak_point_struct_name ] hide();
    }
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x19018065, Offset: 0x38aa
// Size: 0x29
function function_7962cd4502850b79()
{
    level.virgil_entity.weak_point_settings = level.virgil_boss.var_a2e3bab552f04c2b;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xdb6de227, Offset: 0x38db
// Size: 0x15
function function_f8a229a16991533c()
{
    return level.virgil_boss.var_a2e3bab552f04c2b;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x792b449f, Offset: 0x38f9
// Size: 0x23, Type: bool
function is_weak_point_active( weak_point_name )
{
    return isdefined( level.virgil_entity.active_weak_points[ weak_point_name ] );
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x55b06950, Offset: 0x3925
// Size: 0x22
function get_weak_point_struct( weak_point_name )
{
    return level.virgil_entity.active_weak_points[ weak_point_name ];
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x3f1df8, Offset: 0x3950
// Size: 0x22
function function_3d52547cf27e2d36( weak_point_settings )
{
    level.virgil_entity.weak_point_settings = weak_point_settings;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x25c350bf, Offset: 0x397a
// Size: 0x22
function function_b7a39a9bf03c92b7( head_damage_multiplier )
{
    level.virgil_boss.head_damage_multiplier = head_damage_multiplier;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x5f32fef1, Offset: 0x39a4
// Size: 0x252
function function_3719639b6a7c555c( weak_point_names )
{
    self notify( #"hash_400ff6c4f268794e" );
    self endon( #"hash_400ff6c4f268794e" );
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death", #"hash_5f9ee8213c68708a" );
    var_fe00330d4794f6f3 = [];
    
    foreach ( weak_point_name in weak_point_names )
    {
        info = { #var_ab4304f9b22654a6:gettime(), #name:weak_point_name };
        var_fe00330d4794f6f3[ weak_point_name ] = info;
    }
    
    while ( true )
    {
        if ( level.virgil_entity.active_weak_points.size < level.virgil_entity.weak_point_settings.var_35e16c5719638f4c )
        {
            var_c38a96b0f64fde30 = [];
            
            foreach ( weak_point_selection in var_fe00330d4794f6f3 )
            {
                if ( gettime() >= weak_point_selection.var_ab4304f9b22654a6 )
                {
                    var_c38a96b0f64fde30[ var_c38a96b0f64fde30.size ] = weak_point_selection;
                }
            }
            
            var_bc7554894b03494a = utility::array_random( var_c38a96b0f64fde30 );
            
            if ( isdefined( var_bc7554894b03494a ) )
            {
                activate_weak_point( var_bc7554894b03494a.name );
                
                while ( is_weak_point_active( var_bc7554894b03494a.name ) )
                {
                    waitframe();
                }
                
                wait level.virgil_entity.weak_point_settings.var_da29476bbf4d6a0e;
                var_fe00330d4794f6f3[ var_bc7554894b03494a.name ].var_ab4304f9b22654a6 = gettime() + level.virgil_entity.weak_point_settings.weak_point_timeout_sec * 1000;
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0xa36dcc02, Offset: 0x3bfe
// Size: 0x16
function function_ed45e41507b1667d()
{
    level.virgil_entity notify( #"hash_5f9ee8213c68708a" );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x5f6c2b91, Offset: 0x3c1c
// Size: 0xec
function function_89bf535f25340cde()
{
    foreach ( location_map in level.virgil_boss.var_e78a9ab7bb7782ab )
    {
        foreach ( weak_point_name in location_map )
        {
            activate_weak_point( weak_point_name );
        }
    }
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x259e69ff, Offset: 0x3d10
// Size: 0x13f
function function_a50623b6d9857886( var_a1e68778bc9c18b9 )
{
    available_weak_points = [];
    
    foreach ( location in var_a1e68778bc9c18b9 )
    {
        foreach ( weak_point_name in level.virgil_boss.var_e78a9ab7bb7782ab[ location ] )
        {
            if ( !level.virgil_entity.active_weak_points[ weak_point_name ] )
            {
                available_weak_points[ available_weak_points.size ] = weak_point_name;
            }
        }
    }
    
    if ( available_weak_points.size > 0 )
    {
        var_6e8b4fa8206aedf9 = utility::array_random( available_weak_points );
        return activate_weak_point( var_6e8b4fa8206aedf9 );
    }
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x2f74af52, Offset: 0x3e58
// Size: 0x114
function activate_weak_point( weak_point_name )
{
    if ( !level.virgil_entity.active_weak_points[ weak_point_name ] )
    {
        level.virgil_entity.active_weak_points[ weak_point_name ] = function_90a8de08b5348a96( weak_point_name );
        
        if ( level.virgil_entity.weak_points_hidden )
        {
            level.virgil_entity metabone::set_metabone_state( weak_point_name, "exposed_disabled" );
            level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_name ), #"inactive" );
        }
        else
        {
            level.virgil_entity metabone::set_metabone_state( weak_point_name, "exposed_enabled" );
            level.virgil_entity setscriptablepartstate( get_weak_point_scriptable_state( weak_point_name ), #"spawned" );
            function_135c65b25c342aab( weak_point_name );
        }
        
        if ( level.virgil_entity.weak_point_settings.var_5275d938754b334c )
        {
            level thread function_2b6eb339a14f9db1( weak_point_name );
        }
        
        return level.virgil_entity.active_weak_points[ weak_point_name ];
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0xc9bb49a4, Offset: 0x3f75
// Size: 0x7b
function private function_2b6eb339a14f9db1( weak_point_name )
{
    level endon( #"game_ended" );
    level.virgil_entity endon( #"death", #"hash_5f9ee8213c68708a" );
    wait level.virgil_entity.weak_point_settings.var_4d7eb5c5650a48f8;
    
    if ( is_weak_point_active( weak_point_name ) )
    {
        despawn_weak_point( level.virgil_entity.active_weak_points[ weak_point_name ] );
    }
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0x62ec5bbe, Offset: 0x3ff8
// Size: 0x7b
function private function_90a8de08b5348a96( weak_point_name )
{
    return { #health:level.virgil_entity.weak_point_settings.weak_point_health_frac * level.virgil_entity.maxhealth, #damage_taken:0, #location:level.virgil_boss.var_d9dce600db48ced7[ weak_point_name ], #name:weak_point_name };
}

// Namespace zombie_boss_virgil
// Params 1, eflags: 0x4
// Checksum 0xee0477fa, Offset: 0x407c
// Size: 0x12
function private get_weak_point_scriptable_state( weak_point_name )
{
    return getxhash( weak_point_name );
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x3ee6a3b1, Offset: 0x4097
// Size: 0x15
function function_86ea0d4221766f6()
{
    return level.virgil_entity.active_weak_points;
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x42ca50be, Offset: 0x40b5
// Size: 0x18, Type: bool
function function_3ab1eacb268ed911()
{
    return self.aether_shroud_active || self.var_568623dc77af5450;
}

// Namespace zombie_boss_virgil
// Params 1
// Checksum 0x80b332, Offset: 0x40d6
// Size: 0x4a
function get_any_hero( fallback = 0 )
{
    var_ebc5d3bc56525846 = get_all_heroes();
    
    if ( var_ebc5d3bc56525846.size > 0 )
    {
        return utility::array_random( var_ebc5d3bc56525846 );
    }
    
    if ( fallback )
    {
        return utility::array_random( utility::get_alive_players( 0 ) );
    }
}

// Namespace zombie_boss_virgil
// Params 2
// Checksum 0x43ceb1fa, Offset: 0x4129
// Size: 0x38
function get_closest_hero( origin, max_radius )
{
    var_ebc5d3bc56525846 = get_all_heroes();
    
    if ( var_ebc5d3bc56525846.size > 0 )
    {
        return function_47c86977a18df38b( var_ebc5d3bc56525846, origin, max_radius );
    }
}

// Namespace zombie_boss_virgil
// Params 0
// Checksum 0x5a71f0d4, Offset: 0x416a
// Size: 0x9b
function get_all_heroes()
{
    valid_heroes = [];
    players = utility::get_alive_players( 0 );
    
    foreach ( player in players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            valid_heroes[ valid_heroes.size ] = player;
        }
    }
    
    return valid_heroes;
}

/#

    // Namespace zombie_boss_virgil
    // Params 0, eflags: 0x4
    // Checksum 0xe970e65c, Offset: 0x420e
    // Size: 0x3c6, Type: dev
    function private virgil_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:xd8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x108>", "<dev string:x118>" + "<dev string:x125>", &deal_damage );
        devgui::function_cd4e263c1f3018ae( "<dev string:x129>", "<dev string:x118>" + "<dev string:x139>", &deal_damage );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13e>", "<dev string:x118>" + "<dev string:x14e>", &deal_damage );
        devgui::function_cd4e263c1f3018ae( "<dev string:x153>", "<dev string:x118>" + "<dev string:x163>", &deal_damage );
        devgui::add_devgui_func( "<dev string:x168>", "<dev string:x174>", &function_aea29586ea4784f0 );
        devgui::add_devgui_func( "<dev string:x18a>", "<dev string:x198>", &function_3a4ad91f1dfd6c55 );
        
        foreach ( weak_point_location in [ "<dev string:x1af>", "<dev string:x1c6>", "<dev string:x1db>", "<dev string:x1f0>", "<dev string:x206>", "<dev string:x21b>", "<dev string:x22f>" ] )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x245>" + weak_point_location, "<dev string:x25b>" + weak_point_location, &function_252c12946ceec965 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x276>" + weak_point_location, "<dev string:x28e>" + weak_point_location, &function_d9614ea187d3f114 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x2a8>" + weak_point_location, "<dev string:x2ba>" + weak_point_location, &function_82e5f2363bbb115e );
        }
        
        devgui::add_devgui_func( "<dev string:x2d1>", "<dev string:x2e3>", &function_dab167edcd6162fa );
        
        foreach ( var_6337887a136ec510 in [ "<dev string:x2f5>", "<dev string:x2fa>", "<dev string:x303>", "<dev string:x30d>", "<dev string:x319>" ] )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x325>" + var_6337887a136ec510, "<dev string:x334>" + var_6337887a136ec510, &function_ff040b83ad8325fb );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x353>" );
        
        foreach ( key, value in level.virgil_boss.banters )
        {
            name = getxhashsourcename( key );
            devgui::function_cd4e263c1f3018ae( name, "<dev string:x36e>" + name, &function_21a3d45d8846e62f );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x383>" );
        
        foreach ( key, value in level.virgil_boss.dialogues )
        {
            name = getxhashsourcename( key );
            devgui::function_cd4e263c1f3018ae( name, "<dev string:x3a7>" + name, &function_b2b2cdcb0447bf65 );
        }
        
        devgui::function_77df7fe7dd273e10();
        level thread update_dvars_loop();
    }

    // Namespace zombie_boss_virgil
    // Params 1, eflags: 0x4
    // Checksum 0xb789b6c1, Offset: 0x45dc
    // Size: 0x19, Type: dev
    function private function_252c12946ceec965( params )
    {
        activate_weak_point( params[ 0 ] );
    }

    // Namespace zombie_boss_virgil
    // Params 1, eflags: 0x4
    // Checksum 0x1b8cc3c0, Offset: 0x45fd
    // Size: 0x2d, Type: dev
    function private function_82e5f2363bbb115e( params )
    {
        kill_weak_point( level.virgil_entity.active_weak_points[ params[ 0 ] ] );
    }

    // Namespace zombie_boss_virgil
    // Params 1, eflags: 0x4
    // Checksum 0x2c47f751, Offset: 0x4632
    // Size: 0x2d, Type: dev
    function private function_d9614ea187d3f114( params )
    {
        despawn_weak_point( level.virgil_entity.active_weak_points[ params[ 0 ] ] );
    }

    // Namespace zombie_boss_virgil
    // Params 0, eflags: 0x4
    // Checksum 0x415f90f0, Offset: 0x4667
    // Size: 0x15, Type: dev
    function private function_aea29586ea4784f0()
    {
        level.virgil_entity enable_immunity();
    }

    // Namespace zombie_boss_virgil
    // Params 0, eflags: 0x4
    // Checksum 0x18ae67bd, Offset: 0x4684
    // Size: 0x15, Type: dev
    function private function_3a4ad91f1dfd6c55()
    {
        level.virgil_entity disable_immunity();
    }

    // Namespace zombie_boss_virgil
    // Params 1, eflags: 0x4
    // Checksum 0xd1f881fd, Offset: 0x46a1
    // Size: 0x2b, Type: dev
    function private deal_damage( params )
    {
        var_8d2325a3c1b80415 = float( params[ 0 ] );
        function_be62689fc9735cc8( var_8d2325a3c1b80415 );
    }

    // Namespace zombie_boss_virgil
    // Params 1, eflags: 0x4
    // Checksum 0x308127cd, Offset: 0x46d4
    // Size: 0x24, Type: dev
    function private function_21a3d45d8846e62f( params )
    {
        function_9c386609d0280bef( params[ 0 ], level.player, 1 );
    }

    // Namespace zombie_boss_virgil
    // Params 1, eflags: 0x4
    // Checksum 0xbdc2bfef, Offset: 0x4700
    // Size: 0x1b, Type: dev
    function private function_b2b2cdcb0447bf65( params )
    {
        boss_play_dialogue( params[ 0 ], 1 );
    }

    // Namespace zombie_boss_virgil
    // Params 0, eflags: 0xc
    // Checksum 0xf3c6be7d, Offset: 0x4723
    // Size: 0xc6, Type: dev
    function private update_dvars_loop()
    {
        self notify( #"hash_fb3843ffb1b870aa" );
        self endon( #"hash_fb3843ffb1b870aa" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            level.virgil_boss.var_724b96d61cf792d = getdvarfloat( @"hash_7aebc39b4513985c", 1 );
            level.virgil_boss.var_d4196fed65acc3be = getdvarfloat( @"hash_764b8f6d1a3421b5", 0.6 );
            level.virgil_boss.var_a114d85a2c12418e = getdvarfloat( @"hash_baa33faff543db89", 2 );
            level.virgil_boss.var_a2237e4000b17fec = getdvarfloat( @"hash_914484021b04a151", 45 );
            wait 0.5;
        }
    }

    // Namespace zombie_boss_virgil
    // Params 1
    // Checksum 0xc7a66b80, Offset: 0x47f1
    // Size: 0x22, Type: dev
    function function_ff040b83ad8325fb( params )
    {
        level.virgil_entity thread function_1c3066df3a64ff1b( params[ 0 ] );
    }

#/
