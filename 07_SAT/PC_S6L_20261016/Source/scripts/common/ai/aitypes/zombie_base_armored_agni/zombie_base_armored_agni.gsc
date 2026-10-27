// scripts\common\ai\aitypes\zombie_base_armored_agni\zombie_base_armored_agni.gsc  (hash_7934ab87a454aad4.gscc) (size: 4507 Bytes / 0x119b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0abc478 (3769353336)
// size ...... 4507 (0x119b)
// includes .. 6   (offset: 0x1073)
// strings ... 16  (offset: 0x10a3)
// dev strs .. 0   (offset: 0x119b)
// exports ... 10  (offset: 0x9ff)
// cseg ...... 0x188 + 0x877 (0x9ff)
// imports ... 43  (offset: 0xb8f)
// animtree1 . 0   (offset: 0x119b)
// animtree2 . 0   (offset: 0x119b)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_base_armored_agni;

// Namespace zombie_base_armored_agni
// Params 2
// Checksum 0x216156e2, Offset: 0x1a6
// Size: 0x67
function precache( classname, aitypescriptbundle )
{
    if ( utility::flag( "init_zombie_base_armored_agni" ) )
    {
        return;
    }
    
    utility::flag_set( "init_zombie_base_armored_agni" );
    specific_settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    callback::add( "on_" + aitypescriptbundle.subclass + "_spawned", &function_2ab8141ee29a2efc );
}

// Namespace zombie_base_armored_agni
// Params 1, eflags: 0x4
// Checksum 0xe31cad80, Offset: 0x215
// Size: 0x14
function private function_2ab8141ee29a2efc( params )
{
    thread scorch_nearby_targets( self );
}

// Namespace zombie_base_armored_agni
// Params 1, eflags: 0x4
// Checksum 0x3f250452, Offset: 0x231
// Size: 0x21a
function private scorch_nearby_targets( agni )
{
    agni endon( #"death" );
    specific_struct = agni.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    while ( true )
    {
        if ( agni val::get( "disable_elemental_effect" ) )
        {
            waitframe();
            continue;
        }
        
        radius = specific_struct.scorchradius;
        targets = getplayersandaiarrayinradius( agni.origin, radius );
        
        foreach ( target in targets ?? [] )
        {
            if ( target.team == agni.team )
            {
                continue;
            }
            
            if ( target.subclass == agni.subclass )
            {
                continue;
            }
            
            if ( !target utility::ent_flag( "zombie_scorch_ignited" ) )
            {
                target utility::ent_flag_set( "zombie_scorch_ignited" );
                target.var_14e41693a999e976 = gettime();
                
                if ( !isai( target ) && target.scorch_state != "on" )
                {
                    set_scorch_state( target, "tell", specific_struct.var_2d221e74e45c941 );
                }
            }
            else
            {
                target notify( #"reapply_zombie_scorch_ignite" );
            }
            
            ignite_time = isai( target ) ? specific_struct.var_d235d25b3692c0e0 : specific_struct.var_f1666c38a0450f2;
            
            if ( utility::time_has_passed( target.var_14e41693a999e976, ignite_time ) )
            {
                target function_d6833a46e45303f();
                scorch_target( agni, target );
                continue;
            }
            
            target utility::delaythreadendon( level.framedurationseconds * 5, "reapply_zombie_scorch_ignite", &function_d6833a46e45303f );
        }
        
        waitframe();
    }
}

// Namespace zombie_base_armored_agni
// Params 0, eflags: 0x4
// Checksum 0x1d12ffee, Offset: 0x453
// Size: 0x2d
function private function_d6833a46e45303f()
{
    utility::ent_flag_clear( "zombie_scorch_ignited" );
    
    if ( self.scorch_state == "tell" )
    {
        set_scorch_state( self, "off" );
    }
}

// Namespace zombie_base_armored_agni
// Params 3, eflags: 0x4
// Checksum 0xc85d0a63, Offset: 0x488
// Size: 0xff
function private set_scorch_state( player, state, postfxbundle )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.scorch_state == state )
    {
        return;
    }
    
    if ( player.var_2d221e74e45c941 )
    {
        pbgpostfxbundleend( player, player.var_2d221e74e45c941 );
        player.var_2d221e74e45c941 = undefined;
    }
    
    if ( player.var_d14f85d37eb66a63 )
    {
        pbgpostfxbundleend( player, player.var_d14f85d37eb66a63 );
        player.var_d14f85d37eb66a63 = undefined;
    }
    
    if ( state == "tell" )
    {
        pbgpostfxbundlestart( player, postfxbundle );
        player.var_2d221e74e45c941 = postfxbundle;
    }
    
    if ( state == "on" )
    {
        pbgpostfxbundlestart( player, postfxbundle );
        player.var_d14f85d37eb66a63 = postfxbundle;
    }
    
    player.scorch_state = state;
    
    if ( player getscriptablehaspart( "scorch_fx" ) )
    {
        player utility::function_7c10ea82c1e305b8( "scorch_fx", state );
    }
}

// Namespace zombie_base_armored_agni
// Params 2, eflags: 0x4
// Checksum 0xa48a9781, Offset: 0x58f
// Size: 0x142
function private scorch_target( agni, target )
{
    specific_struct = agni.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( isai( target ) && !isbot( target ) )
    {
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( target.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        var_8d2325a3c1b80415 = function_6f12f0d15a3904d4( target, specific_struct );
        damage = zombie_base_health * var_8d2325a3c1b80415;
        target effect_burn::burn( specific_struct.var_495a21189549b3f9, damage, 1, agni, "agni_scorch", undefined, agni, "fire", 0, undefined, 1, 1, 1, undefined, 1 );
        return;
    }
    
    target.scorch_end_time = gettime() + specific_struct.var_3828226a2470cd30 * 1000;
    
    if ( !utility::ent_flag( "zombie_scorched" ) )
    {
        target.scorch_owner = agni;
        target utility::ent_flag_set( "zombie_scorched" );
        set_scorch_state( target, "on", specific_struct.var_d14f85d37eb66a63 );
        target thread function_ebf465e952d5f6c0( target, specific_struct );
    }
}

// Namespace zombie_base_armored_agni
// Params 2, eflags: 0x4
// Checksum 0x9b4e0fcb, Offset: 0x6d9
// Size: 0x220
function private function_ebf465e952d5f6c0( target, specific_struct )
{
    target endon( #"death" );
    
    while ( gettime() < target.scorch_end_time )
    {
        if ( !utility::ent_flag( "zombie_scorched_damaged" ) )
        {
            if ( !isalive( target.scorch_owner ) )
            {
                if ( !target.var_795be18122a8395e )
                {
                    target.var_795be18122a8395e = utility::spawn_script_origin();
                    target thread utility::delete_on_death( target.var_795be18122a8395e );
                    target.var_795be18122a8395e.armor_health_damage_multiplier = 1;
                }
            }
            
            scorch_owner = isalive( target.scorch_owner ) ? target.scorch_owner : target.var_795be18122a8395e;
            utility::ent_flag_set( "zombie_scorched_damaged" );
            target thread utility::ent_flag_clear_delayed( "zombie_scorched_damaged", 1 );
            assert( specific_struct.var_fc5c326594ab7923 > 0 );
            
            if ( !scorch_owner.armor_health_damage_multiplier )
            {
                var_aeea64ee76ba5493 = 1;
                scorch_owner.armor_health_damage_multiplier = 1;
            }
            
            scorch_owner.armor_health_damage_multiplier *= specific_struct.var_fc5c326594ab7923;
            damage = specific_struct.scorchdamage * ( target.scorch_owner.var_fe048a2106d8ef00[ #"scorched_damage" ] ?? 1 );
            
            if ( target.health > damage )
            {
                damage_origin = scorch_owner.origin ?? target.origin;
                target dodamage( damage, damage_origin, scorch_owner, scorch_owner, "MOD_ELEMENTAL_FIRE" );
            }
            
            if ( scorch_owner && var_aeea64ee76ba5493 )
            {
                scorch_owner.armor_health_damage_multiplier = undefined;
            }
            else
            {
                scorch_owner.armor_health_damage_multiplier /= specific_struct.var_fc5c326594ab7923;
            }
        }
        
        waitframe();
    }
    
    cleanup_scorched( target );
}

// Namespace zombie_base_armored_agni
// Params 1, eflags: 0x4
// Checksum 0x4abda3b9, Offset: 0x901
// Size: 0x54
function private cleanup_scorched( target )
{
    set_scorch_state( target, "off" );
    target utility::ent_flag_clear( "zombie_scorch_ignited" );
    target utility::ent_flag_clear( "zombie_scorched" );
    
    if ( target.var_795be18122a8395e )
    {
        target.var_795be18122a8395e delete();
    }
}

// Namespace zombie_base_armored_agni
// Params 2, eflags: 0x4
// Checksum 0x3abb16db, Offset: 0x95d
// Size: 0xa1
function private function_6f12f0d15a3904d4( target, specific_struct )
{
    if ( target.aicategory )
    {
        switch ( target.aicategory )
        {
            case #"hash_7b0e2f2ed84f34":
                return specific_struct.var_2d3533532561c9e3;
            case #"hash_8c089e813083e510":
                return specific_struct.var_48c3d6a553cb68c3;
            case #"hash_4e47eb6c32f5b165":
                return specific_struct.var_847a8d0b4d422234;
            default:
                return specific_struct.var_4b36baae8153402b;
        }
    }
    
    return specific_struct.var_4b36baae8153402b;
}

