// scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_medal.gsc  (hash_2dfa5ec484fda770.gscc) (size: 667 Bytes / 0x29b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3db54f1b (1035292443)
// size ...... 667 (0x29b)
// includes .. 2   (offset: 0x28b)
// strings ... 0   (offset: 0x29b)
// dev strs .. 0   (offset: 0x29b)
// exports ... 4   (offset: 0x15f)
// cseg ...... 0x58 + 0x107 (0x15f)
// imports ... 5   (offset: 0x1ff)
// animtree1 . 0   (offset: 0x29b)
// animtree2 . 0   (offset: 0x29b)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;

#namespace zombie_loom_minion_medal;

// Namespace zombie_loom_minion_medal
// Params 0
// Checksum 0x8c414891, Offset: 0x76
// Size: 0x45
function function_4c300e7d7d59919e()
{
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", self.animsetname, &on_killed_medal );
    }
}

// Namespace zombie_loom_minion_medal
// Params 4, eflags: 0x4
// Checksum 0x6700ff76, Offset: 0xc3
// Size: 0x7d
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( !isdefined( self.loom_minion_kill_count ) )
    {
        self.loom_minion_kill_count = 0;
    }
    
    if ( self.loom_minion_kill_count == 0 )
    {
        thread function_39c519ee3ad4e95c();
    }
    
    self.loom_minion_kill_count++;
    
    if ( self.loom_minion_kill_count % 3 == 0 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_eafde3ec31b0b65c" );
    }
}

// Namespace zombie_loom_minion_medal
// Params 0, eflags: 0x4
// Checksum 0xe817bbd2, Offset: 0x148
// Size: 0x17
function private function_39c519ee3ad4e95c()
{
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self.loom_minion_kill_count = 0;
    }
}

