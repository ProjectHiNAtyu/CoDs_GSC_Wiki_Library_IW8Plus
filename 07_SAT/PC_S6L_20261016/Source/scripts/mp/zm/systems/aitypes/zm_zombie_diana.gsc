// scripts\mp\zm\systems\aitypes\zm_zombie_diana.gsc  (hash_3d2e34e452e5ee8d.gscc) (size: 5393 Bytes / 0x1511 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x94432c90 (2487430288)
// size ...... 5393 (0x1511)
// includes .. 15  (offset: 0x1369)
// strings ... 24  (offset: 0x13e1)
// dev strs .. 0   (offset: 0x1511)
// exports ... 11  (offset: 0xd7d)
// cseg ...... 0x223 + 0xb5a (0xd7d)
// imports ... 32  (offset: 0xf35)
// animtree1 . 0   (offset: 0x1511)
// animtree2 . 0   (offset: 0x1511)
#using script_16ea1b94f0f381b3;
#using script_21453148428dc2c0;
#using script_28f8e299bbcf2c00;
#using script_2de83d6261680959;
#using script_4fb7a9021a570c8a;
#using script_6d4c5bf7d72d6d4a;
#using script_7f0fdfedd9ca7570;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_zombie_diana;

// Namespace zm_zombie_diana
// Params 2
// Checksum 0x12d271e5, Offset: 0x241
// Size: 0x52
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_8e1f1ce7457af908 ) )
    {
        return;
    }
    
    level.var_8e1f1ce7457af908 = 1;
    level callback::add( "on_zombie_diana_spawned", &function_4b4ce81354cf8c2e );
    level callback::add( "on_zombie_diana_assault_rounds_spawned", &function_4b4ce81354cf8c2e );
}

// Namespace zm_zombie_diana
// Params 1
// Checksum 0x6dcfcf38, Offset: 0x29b
// Size: 0x118
function function_4b4ce81354cf8c2e( params )
{
    callback::add( "new_diana_phase", &function_d9f177d8cb8e47e );
    zombie_utils::function_dfae6a5bd222c586( &function_d77a74cbd1346432 );
    val::set( "diana", "ignore_ai_collision", 1 );
    val::set( "diana", "trigger_hurt_damage", 0 );
    val::set( "diana", "ignore_cleanup", 1 );
    val::set( "diana", "allow_dismember", 0 );
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.ignore_enemy_count = 1;
    self.b_ignore_cleanup = 1;
    self.b_ignore_water_check = 1;
    self.var_1bc1a37495c8ca04 = 1;
    self.var_bfa7ca2a8740bf7b = 1;
    self.b_ignore_monkey_bomb = 1;
    self.b_ignore_frenzied_guard = 1;
    self.b_disable_annihilate = 1;
    self.no_powerups = 1;
    self.var_a8fa61d92872fc74 = 1;
    self.disallow_aether_shroud_shadow_blade = 1;
    self.var_a13bed1ac47e1b2c = 1;
}

// Namespace zm_zombie_diana
// Params 1, eflags: 0x4
// Checksum 0xa749e423, Offset: 0x3bb
// Size: 0x47
function private function_d9f177d8cb8e47e( params )
{
    var_28755b2381cf7597 = int( self.var_f8115155adde44d[ self.bossfightphase - 1 ] * self.maxhealth );
    self.var_d200801f77f0de0 = var_28755b2381cf7597;
}

// Namespace zm_zombie_diana
// Params 1, eflags: 0x4
// Checksum 0xfd470b18, Offset: 0x40a
// Size: 0x6d9
function private function_d77a74cbd1346432( params )
{
    if ( self.InAssaultRounds || self.var_382b3e1f72536e3c )
    {
        return 0;
    }
    
    var_f79d2cbb78ec6c7 = getdvarfloat( @"hash_acaf2d7c2aabce4d", self.var_e53c55e039dfed88 ?? 3.3 );
    var_59d8376765d7e280 = getdvarfloat( @"hash_51de7bcc854365ea", self.var_d392e34c98ed055 ?? 3.5 );
    var_c5e472f3e01c3e15 = getdvarfloat( @"hash_285cb254a76cbf65", 1156.25 );
    var_baf1a8fb2ec9f5cd = getdvarfloat( @"hash_12b533f0adfefbd", 625 );
    var_a000db45f4b84e16 = getdvarfloat( @"hash_ef01af3c5c3dfba6", 2500 );
    var_8207753ca64b3f2c = getdvarfloat( @"hash_19be9a4f222787bc", 2312.5 );
    var_6a4a5d66f3be5024 = getdvarfloat( @"hash_dbac2cf5342050d4", 1250 );
    var_f17754b3d53fb767 = getdvarfloat( @"hash_8f1af24be0711f7", 5000 );
    var_53d678e7a71008ff = getdvarfloat( @"hash_7c41a87a3eb9868f", 4625 );
    var_6ec0b93351d61717 = getdvarfloat( @"hash_f206cfba8f98cd47", 2500 );
    var_b9097be192675d74 = getdvarfloat( @"hash_8200534dbcf32004", 10000 );
    var_7803f1f628db23ae = getdvarfloat( @"hash_b8484086507443e", 9250 );
    var_6dc7a9229168f746 = getdvarfloat( @"hash_d342b613b2d3df6", 5000 );
    var_c3f2212fdbdc7c5d = getdvarfloat( @"hash_dcc5ecbedbd9192d", 20000 );
    var_8a39033315f3b2b1 = getdvarfloat( @"hash_f3fcf33afacc8641", 11562.5 );
    var_cab333a0dbee77e9 = getdvarfloat( @"hash_f8f5b554f4d9ab99", 6250 );
    var_f60ca9b2187baa82 = getdvarfloat( @"hash_203233f85fe2dd92", 25000 );
    var_820d311e6dc77d7f = getdvarfloat( @"hash_969e3196c9124046", 1.9 );
    var_b04192d031bd0abd = getdvarfloat( @"hash_51de7bcc854365ea", 0.65 );
    var_5a19bdebb5dcd986 = getdvarfloat( @"hash_545c25a64b24e75f", 0.1 );
    var_121f92de46516c81 = getdvarfloat( @"hash_7c65d003b0d5cf06", 0.43 );
    var_6ef71cf09949e3a0 = getdvarfloat( @"hash_beea76f90de4a30d", 0.5 );
    var_677b7ef5f6698b30 = getdvarfloat( @"hash_ba6bcd30445f95fd", 0.5 );
    var_7b0369ee7436d0eb = getdvarfloat( @"hash_ce31a61723ec9202", 0.5 );
    var_94b67e97b730d03f = 0.1;
    var_4c2a0f4937888418 = 0.05;
    
    if ( !isplayer( params.eattacker ) || !params.eattacker.var_f468cf5c9e75db1 )
    {
        return params.idamage;
    }
    
    damage = params.idamage;
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    is_base_raygun = issubstr( params.objweapon.basename, "raygun" ) && !issubstr( params.objweapon.basename, "raygunmark2" );
    
    if ( is_wonder )
    {
        is_hornet_ww = issubstr( params.objweapon.basename, "ww_hornet_zm" );
        
        if ( is_hornet_ww )
        {
            paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
            
            switch ( paplevel ?? 0 )
            {
                case 4:
                    damage = var_8a39033315f3b2b1;
                    
                    if ( armordata )
                    {
                        damage = var_cab333a0dbee77e9;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_f60ca9b2187baa82;
                    }
                    
                    break;
                case 3:
                    damage = var_7803f1f628db23ae;
                    
                    if ( armordata )
                    {
                        damage = var_6dc7a9229168f746;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_c3f2212fdbdc7c5d;
                    }
                    
                    break;
                case 2:
                    damage = var_53d678e7a71008ff;
                    
                    if ( armordata )
                    {
                        damage = var_6ec0b93351d61717;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_b9097be192675d74;
                    }
                    
                    break;
                case 1:
                    damage = var_8207753ca64b3f2c;
                    
                    if ( armordata )
                    {
                        damage = var_6a4a5d66f3be5024;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_f17754b3d53fb767;
                    }
                    
                    break;
                case 0:
                default:
                    damage = var_c5e472f3e01c3e15;
                    
                    if ( armordata )
                    {
                        damage = var_baf1a8fb2ec9f5cd;
                    }
                    
                    if ( weakspotdata )
                    {
                        damage = var_a000db45f4b84e16;
                    }
                    
                    break;
            }
            
            var_1c5a5fe66c8c0724 = self.var_50718c08923dcdbb && self.health <= int( self.maxhealth * self.var_f8115155adde44d[ self.bossfightphase - 1 ] );
            var_e61527db42062cc1 = self getaiblackboarddynamic( "in_intro_sequence" );
            
            if ( var_1c5a5fe66c8c0724 )
            {
                damage *= var_94b67e97b730d03f;
            }
            
            if ( var_e61527db42062cc1 )
            {
                damage *= var_4c2a0f4937888418;
            }
        }
        
        if ( is_base_raygun )
        {
            damage *= var_820d311e6dc77d7f;
        }
    }
    
    if ( armordata )
    {
        damage *= var_f79d2cbb78ec6c7;
    }
    else if ( weakspotdata && !is_base_raygun && !is_hornet_ww )
    {
        damage *= var_59d8376765d7e280;
        
        if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
        {
            damage *= var_b04192d031bd0abd;
        }
        
        if ( issubstr( params.objweapon.basename, "pi_atlas" ) )
        {
            damage *= var_5a19bdebb5dcd986;
        }
        
        if ( issubstr( params.sweapon.basename, "handcannon" ) )
        {
            damage *= var_121f92de46516c81;
        }
        
        if ( issubstr( params.sweapon.basename, "deathmachine" ) )
        {
            damage *= var_6ef71cf09949e3a0;
        }
    }
    
    if ( arraycontains( [ "rifle" ], params.sweapon.classname ) )
    {
        isrhino = issubstr( params.objweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_677b7ef5f6698b30;
            
            if ( weakspotdata )
            {
                damage *= var_7b0369ee7436d0eb;
            }
        }
    }
    
    if ( damage >= self.health )
    {
        self.health = int( self.maxhealth * 0.01 );
    }
    
    return damage;
}

// Namespace zm_zombie_diana
// Params 1
// Checksum 0x10a2026f, Offset: 0xaec
// Size: 0x1e
function set_in_assault_rounds( enable )
{
    self.InAssaultRounds = enable;
    thread function_847f6ff6480b6e6();
}

// Namespace zm_zombie_diana
// Params 0, eflags: 0x4
// Checksum 0xaf012718, Offset: 0xb12
// Size: 0x1d8
function private function_847f6ff6480b6e6()
{
    utility::ent_flag_wait_or_timeout( "zombie_diana_init_finished", 1 );
    self.var_f8115155adde44d = undefined;
    self.var_9dd11279d5e371c7 = undefined;
    zombie_diana_move::function_4a1cbc8699d71a69();
    zombie_diana_metabones::turn_off_metabones();
    zombie_diana_targeting::function_1b8b00a924346b36();
    zombie_diana_necrotic_fan::function_ad53746de75bf86();
    zombie_diana_winged_tornado_attack::turn_off_winged_tornado_attack();
    var_a598eded71858c84 = self.var_fe048a2106d8ef00[ #"assault_rounds_necrotic_projectile" ] ?? 1;
    self.var_459c6df661602ddb = int( ceil( self.var_459c6df661602ddb * var_a598eded71858c84 ) );
    self.var_ea968bae159ea1c0 = int( ceil( self.var_ea968bae159ea1c0 * var_a598eded71858c84 ) );
    zombie_diana_necrotic_beam::function_11fa21e59bb35d9c( &is_pos_in_playable_space );
    var_2ef71251877a5954 = self.var_fe048a2106d8ef00[ #"assault_rounds_necrotic_beam" ] ?? 1;
    self.var_d27f4fe48e41462f = int( ceil( self.var_d27f4fe48e41462f * var_2ef71251877a5954 ) );
    self.var_113e179091297b80 = 1;
    var_1117b535859a8490 = self.var_fe048a2106d8ef00[ #"hash_9e891660aa25389e" ] ?? 1;
    self.var_3738d1332f70b824 = int( ceil( self.var_3738d1332f70b824 * var_1117b535859a8490 ) );
    
    if ( !utility::ent_flag_exist( "zombie_diana_post_init_finished" ) )
    {
        utility::ent_flag_set( "zombie_diana_post_init_finished" );
    }
    
    foreach ( player in level.players )
    {
        if ( player zombie_boss_healthbar::function_44d523f97fcaa324() )
        {
            zombie_boss_healthbar::function_57cec007b96540a4();
            break;
        }
    }
}

// Namespace zm_zombie_diana
// Params 1
// Checksum 0xdbf982ce, Offset: 0xcf2
// Size: 0x15, Type: bool
function is_pos_in_playable_space( pos )
{
    return isdefined( zone_manager::function_90e5c3e2272b0130( pos ) );
}

// Namespace zm_zombie_diana
// Params 1
// Checksum 0x2c17f484, Offset: 0xd10
// Size: 0x17
function function_66524aff88e1f47e( multiplier )
{
    self.var_e53c55e039dfed88 = multiplier;
}

// Namespace zm_zombie_diana
// Params 1
// Checksum 0xbce127f0, Offset: 0xd2f
// Size: 0x17
function function_5550daad88f85dfb( multiplier )
{
    self.var_d392e34c98ed055 = multiplier;
}

// Namespace zm_zombie_diana
// Params 2
// Checksum 0x810eb803, Offset: 0xd4e
// Size: 0x2e
function function_759e2a1c085bdfec( taskid, params )
{
    return self.InAssaultRounds ? "InAssaultRounds" : "InBossFight";
}

