// script_75be757f00035a1c  (hash_75be757f00035a1c.gscc) (size: 1186 Bytes / 0x4a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85122ae5 (2232560357)
// size ...... 1186 (0x4a2)
// includes .. 1   (offset: 0x482)
// strings ... 2   (offset: 0x48a)
// dev strs .. 0   (offset: 0x4a2)
// exports ... 5   (offset: 0x2aa)
// cseg ...... 0x7b + 0x22f (0x2aa)
// imports ... 8   (offset: 0x372)
// animtree1 . 0   (offset: 0x4a2)
// animtree2 . 0   (offset: 0x4a2)
#using scripts\common\utility;

#namespace namespace_82d6b192a5808a3e;

// Namespace namespace_82d6b192a5808a3e
// Params 0, eflags: 0x1
// Checksum 0x626f63f5, Offset: 0x99
// Size: 0x3d
function autoexec preinit()
{
    if ( !utility::issharedfuncdefined( #"nuke", #"onusesequence", 0 ) )
    {
        utility::registersharedfunc( #"nuke", #"onusesequence", &onusesequence );
    }
}

// Namespace namespace_82d6b192a5808a3e
// Params 0
// Checksum 0x2f134c7e, Offset: 0xde
// Size: 0x36
function onusesequence()
{
    if ( !self getscriptablehaspart( #"nuke_walkie_screen" ) || !self getscriptablehaspart( #"nuke_walkie_screen_base" ) )
    {
        return;
    }
    
    thread function_f0f99fac2c417552();
    thread monitorownerdeath();
}

// Namespace namespace_82d6b192a5808a3e
// Params 0
// Checksum 0x43cd5739, Offset: 0x11c
// Size: 0x4f
function monitorownerdeath()
{
    self endon( #"disconnect" );
    utility::waittill_any( "death", "nuke_sequence_finished" );
    self setscriptablepartstate( #"nuke_walkie_screen", #"neutral" );
    self setscriptablepartstate( #"nuke_walkie_screen_base", #"neutral" );
}

// Namespace namespace_82d6b192a5808a3e
// Params 0
// Checksum 0xea7c37ad, Offset: 0x173
// Size: 0x137
function function_f0f99fac2c417552()
{
    self endon( #"death_or_disconnect" );
    wait 0.15;
    self setscriptablepartstate( #"nuke_walkie_screen", #"neutral" );
    self setscriptablepartstate( #"nuke_walkie_screen_base", #"neutral" );
    wait 0.15;
    self setscriptablepartstate( #"nuke_walkie_screen", #"setup" );
    self setscriptablepartstate( #"nuke_walkie_screen_base", #"setup" );
    wait 0.45;
    self setscriptablepartstate( #"nuke_walkie_screen", #"press_1" );
    wait 0.33;
    self setscriptablepartstate( #"nuke_walkie_screen", #"press_2" );
    wait 0.33;
    self setscriptablepartstate( #"nuke_walkie_screen", #"press_3" );
    wait 0.33;
    self setscriptablepartstate( #"nuke_walkie_screen", #"press_4" );
    wait 0.8;
    self setscriptablepartstate( #"nuke_walkie_screen", #"nuke_incoming" );
    self setscriptablepartstate( #"nuke_walkie_screen_base", #"nuke_incoming" );
    wait 1;
    self notify( #"nuke_sequence_finished" );
}

