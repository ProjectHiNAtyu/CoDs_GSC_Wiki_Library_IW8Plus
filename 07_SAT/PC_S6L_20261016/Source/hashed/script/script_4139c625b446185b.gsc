// script_4139c625b446185b  (hash_4139c625b446185b.gscc) (size: 1089 Bytes / 0x441 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5dd37a6b (1574140523)
// size ...... 1089 (0x441)
// includes .. 6   (offset: 0x3c1)
// strings ... 6   (offset: 0x3f1)
// dev strs .. 0   (offset: 0x441)
// exports ... 5   (offset: 0x1f9)
// cseg ...... 0xb6 + 0x143 (0x1f9)
// imports ... 9   (offset: 0x2c1)
// animtree1 . 0   (offset: 0x441)
// animtree2 . 0   (offset: 0x441)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_weyward_stinger_asm;

// Namespace zombie_weyward_stinger_asm
// Params 0, eflags: 0x4
// Checksum 0x8a0155f0, Offset: 0xd4
// Size: 0x21
function private function_498159e8be1ea685()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
}

// Namespace zombie_weyward_stinger_asm
// Params 3
// Checksum 0x57f5c550, Offset: 0xfd
// Size: 0x71
function function_3cf2f7937a6dab9b( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_498159e8be1ea685 );
    thread zombie_wander::wander_listener();
    self.noragdoll = 1;
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_weyward_stinger_asm
// Params 1, eflags: 0x4
// Checksum 0x9445efc1, Offset: 0x176
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_weyward_stinger_asm
// Params 3
// Checksum 0xbcc0561a, Offset: 0x1ad
// Size: 0x4b
function function_b3112ac8cd71014b( asmname, statename, params )
{
    if ( self.var_30b5e6fc9ca7628e )
    {
        alias = "charge_retract";
    }
    else
    {
        alias = 0;
    }
    
    return asm::asm_chooseanim( asmname, statename, alias );
}

