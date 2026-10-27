// scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_metabones.gsc  (hash_36a7aeaa109a0807.gscc) (size: 2084 Bytes / 0x824 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5556d763 (1431754595)
// size ...... 2084 (0x824)
// includes .. 9   (offset: 0x720)
// strings ... 13  (offset: 0x768)
// dev strs .. 0   (offset: 0x824)
// exports ... 5   (offset: 0x3fc)
// cseg ...... 0x12e + 0x2ce (0x3fc)
// imports ... 21  (offset: 0x4c4)
// animtree1 . 0   (offset: 0x824)
// animtree2 . 0   (offset: 0x824)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_claw_hammer;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_enraged;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_karkinos_metabones;

// Namespace zombie_karkinos_metabones
// Params 0, eflags: 0x1
// Checksum 0x5965e191, Offset: 0x14c
// Size: 0x2f
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_karkinos";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
    metabone::function_7b57cab1f2311c7b( var_fb56e56d94279338, &function_7af73e5c3e2c4b17 );
}

// Namespace zombie_karkinos_metabones
// Params 1, eflags: 0x4
// Checksum 0xea4623cf, Offset: 0x183
// Size: 0xf2
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    
    if ( metabone_name == "armored_head" )
    {
        metabone::set_metabone_state( metabone_name, "destroyed" );
        metabone::set_metabone_active( metabone_name, 1 );
    }
    
    scriptable_state_name = "destroyed";
    
    if ( metabone_name == "claw_shield" )
    {
        destroy_claw_shield( params );
    }
    
    if ( !zombie_stun::is_stunned() && !self isintraverse() )
    {
        if ( isalive( self ) && val::get( "special_pain" ) )
        {
            self notify( #"vox_pain" );
            asm::function_7256f5ba459c840b( "special_pain_in" );
            
            if ( self getaiblackboarddynamic( "in_claw_hammer" ) == 1 )
            {
                zombie_karkinos_claw_hammer::cleanup_claw_hammer();
            }
        }
    }
    
    if ( isalive( self ) )
    {
        thread zombie_karkinos_enraged::karkinos_enrage( self.enrage_duration, 0 );
        
        if ( metabone_name != "claw_shield" )
        {
            utility::function_32b24db3127bff40( metabone_name, scriptable_state_name );
        }
    }
}

// Namespace zombie_karkinos_metabones
// Params 1, eflags: 0x4
// Checksum 0x19b0a219, Offset: 0x27d
// Size: 0x99
function private function_7af73e5c3e2c4b17( params )
{
    if ( params.metabone_name == "claw_shield_weakpoint" )
    {
        utility::function_32b24db3127bff40( "claw_shield_wp_imp", "on" );
        self.var_d5ae8d9ff7d863e2 -= params.damage;
        
        if ( self.var_d5ae8d9ff7d863e2 <= 0 && metabone::get_metabone_state_name( "claw_shield_weakpoint" ) != "broken" )
        {
            metabone::destroy_metabone( "claw_shield", params.eattacker, params.einflictor, "MOD_EXPLOSIVE" );
        }
    }
}

// Namespace zombie_karkinos_metabones
// Params 1, eflags: 0x4
// Checksum 0xc9381015, Offset: 0x31e
// Size: 0xde
function private destroy_claw_shield( params )
{
    zombie_karkinos::disable_claw_shield( 0 );
    metabone::set_metabone_state( "claw_shield_weakpoint", "broken" );
    metabone::set_metabone_active( "claw_shield_weakpoint", 0 );
    self.claw_arm_destroyed = 1;
    var_81a4fbc692f40f48 = self.maxhealth * self.claw_shield_destroy_damage * 0.01;
    self dodamage( var_81a4fbc692f40f48, self.origin, params.eattacker, params.einflictor, "MOD_EXPLOSIVE", undefined, "left_arm_upper", undefined, 1073807360 );
    callback::callback( #"hash_805e7303a0ba39b1", { #einflictor:params.einflictor, #eattacker:params.eattacker, #var_81a4fbc692f40f48:var_81a4fbc692f40f48 } );
}

