// script_a0535a22cc426b3  (hash_0a0535a22cc426b3.gscc) (size: 694 Bytes / 0x2b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3db57a6c (1035303532)
// size ...... 694 (0x2b6)
// includes .. 3   (offset: 0x27a)
// strings ... 3   (offset: 0x292)
// dev strs .. 0   (offset: 0x2b6)
// exports ... 4   (offset: 0x132)
// cseg ...... 0x8c + 0xa6 (0x132)
// imports ... 6   (offset: 0x1d2)
// animtree1 . 0   (offset: 0x2b6)
// animtree2 . 0   (offset: 0x2b6)
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_hermes_asm;

// Namespace zombie_hermes_asm
// Params 0, eflags: 0x4
// Checksum 0xbc77a275, Offset: 0xaa
// Size: 0x2
function private function_358c64f6ac74e0d3()
{
    
}

// Namespace zombie_hermes_asm
// Params 3
// Checksum 0x4f68e214, Offset: 0xb4
// Size: 0x6a
function function_b3311d566fd42efc( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    namespace_7e98bc5e3517bf83::zombie_init_ai_asm( &function_358c64f6ac74e0d3 );
    self animmode( "noclip" );
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_hermes_asm
// Params 1, eflags: 0x4
// Checksum 0xf7ea0be3, Offset: 0x126
// Size: 0xc
function private on_ai_init( params )
{
    
}

