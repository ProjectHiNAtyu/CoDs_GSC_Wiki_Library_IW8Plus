// script_15dcfcf56850a061  (hash_15dcfcf56850a061.gscc) (size: 2096 Bytes / 0x830 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1aeca02f (451715119)
// size ...... 2096 (0x830)
// includes .. 10  (offset: 0x730)
// strings ... 12  (offset: 0x780)
// dev strs .. 0   (offset: 0x830)
// exports ... 7   (offset: 0x3b0)
// cseg ...... 0x111 + 0x29f (0x3b0)
// imports ... 21  (offset: 0x4c8)
// animtree1 . 0   (offset: 0x830)
// animtree2 . 0   (offset: 0x830)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_projectile_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_orion_asm;

// Namespace zombie_orion_asm
// Params 0, eflags: 0x4
// Checksum 0xa3a213fc, Offset: 0x12f
// Size: 0x21
function private function_caae7d151750f60e()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
}

// Namespace zombie_orion_asm
// Params 3
// Checksum 0x4b97e837, Offset: 0x158
// Size: 0xe4
function function_4692ae2e620caedb( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_caae7d151750f60e );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    thread zombie_wander::function_c77a8eaa38883b1c();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_orion_asm
// Params 1, eflags: 0x4
// Checksum 0x294d5a28, Offset: 0x244
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_orion_asm
// Params 0
// Checksum 0x2b6d5b63, Offset: 0x27b
// Size: 0x41
function cause_special_pain()
{
    if ( !zombie_stun::is_stunned() && !self isintraverse() && isalive( self ) && val::get( "special_pain" ) )
    {
        asm::function_7256f5ba459c840b( "special_pain_in" );
        thread enraged();
    }
}

// Namespace zombie_orion_asm
// Params 0, eflags: 0x4
// Checksum 0x97a53141, Offset: 0x2c4
// Size: 0xd8
function private enraged()
{
    self endon( #"death" );
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "enraged", 32 );
    zombie_projectile_attack::enable_projectile_attack( 0 );
    val::set( "enraged", "pain", 0 );
    val::set( "enraged", "special_pain", 0 );
    val::set( "enraged", "collide_with_ai_allies_smaller", 0 );
    self.is_enraged = 1;
    
    if ( self.var_d6894f01a36b4ff3.knockdowndata_list.size > 0 && !self.var_d6894f01a36b4ff3.var_cf239a32f7448dd1 )
    {
        thread zombie_knockdown::function_a0c03faf3694150c( &function_41bc93ab79676430 );
    }
    
    wait 30;
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "enraged", 30 );
    zombie_projectile_attack::enable_projectile_attack( 1 );
    val::reset_all( "enraged" );
    self.is_enraged = 0;
}

// Namespace zombie_orion_asm
// Params 0, eflags: 0x4
// Checksum 0x2cb8fdd9, Offset: 0x3a4
// Size: 0xb
function private function_41bc93ab79676430()
{
    return self.is_enraged;
}

