// script_96f7305c40cc74d  (hash_096f7305c40cc74d.gscc) (size: 956 Bytes / 0x3bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31026201 (822239745)
// size ...... 956 (0x3bc)
// includes .. 4   (offset: 0x35c)
// strings ... 5   (offset: 0x37c)
// dev strs .. 0   (offset: 0x3bc)
// exports ... 5   (offset: 0x1b0)
// cseg ...... 0xa9 + 0x107 (0x1b0)
// imports ... 8   (offset: 0x278)
// animtree1 . 0   (offset: 0x3bc)
// animtree2 . 0   (offset: 0x3bc)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;

#namespace namespace_1ce9f4c8d67c396e;

// Namespace namespace_1ce9f4c8d67c396e
// Params 0
// Checksum 0x33ed4565, Offset: 0xc7
// Size: 0x22
function function_d0eff41dd77b3b53()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
}

// Namespace namespace_1ce9f4c8d67c396e
// Params 0
// Checksum 0x4b08078a, Offset: 0xf1
// Size: 0x10
function init_zombie_galileo_move()
{
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    thread patrol_listener();
}

// Namespace namespace_1ce9f4c8d67c396e
// Params 0, eflags: 0x4
// Checksum 0xf066b587, Offset: 0x109
// Size: 0x52
function private patrol_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"galileo_patrol_start" );
        zombie_utils::function_a8ce00e0448cb6f0( "patrol", "galileo_patrol", 22 );
        self waittill( #"galileo_patrol_end" );
        zombie_utils::function_a8ce00e0448cb6f0( undefined, "galileo_patrol", 22 );
    }
}

// Namespace namespace_1ce9f4c8d67c396e
// Params 1, eflags: 0x4
// Checksum 0x7d7dc2f1, Offset: 0x163
// Size: 0x4d
function private on_move_speed_changed( params )
{
    animset = self.animsetname;
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

