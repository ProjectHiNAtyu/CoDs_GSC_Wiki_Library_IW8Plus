// scripts\common\ai\stealth\neutral.gsc  (hash_29adfedafc8723b8.gscc) (size: 691 Bytes / 0x2b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x526d5ad2 (1382898386)
// size ...... 691 (0x2b3)
// includes .. 4   (offset: 0x27b)
// strings ... 2   (offset: 0x29b)
// dev strs .. 0   (offset: 0x2b3)
// exports ... 2   (offset: 0x113)
// cseg ...... 0x6d + 0xa6 (0x113)
// imports ... 10  (offset: 0x163)
// animtree1 . 0   (offset: 0x2b3)
// animtree2 . 0   (offset: 0x2b3)
#using scripts\common\ai\stealth\debug;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\event;
#using scripts\common\ai\stealth\group;

#namespace neutral;

// Namespace neutral
// Params 0
// Checksum 0x8679f3e3, Offset: 0x8b
// Size: 0x88
function main()
{
    if ( isdefined( self.stealth ) )
    {
        return;
    }
    
    enemy::init_settings();
    self.neutralsenses = 1;
    self.stealth_groupname = self.script_stealthgroup;
    enemy::init_flags();
    group::addtogroup( self.script_stealthgroup, self );
    self setpatrolstylebase();
    event::event_init_entity();
    thread enemy::monitor_damage_thread();
    
    /#
        thread debug::debug_enemy();
    #/
    
    self function_2534a85eba6b0e0b( "noncombat" );
    enemy::bt_set_stealth_state( "idle" );
    enemy::stealth_init_goal_radius();
}

