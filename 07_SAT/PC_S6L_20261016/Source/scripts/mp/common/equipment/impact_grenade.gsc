// scripts\mp\common\equipment\impact_grenade.gsc  (hash_55e9f3fc38062110.gscc) (size: 909 Bytes / 0x38d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75a17e88 (1973517960)
// size ...... 909 (0x38d)
// includes .. 3   (offset: 0x351)
// strings ... 3   (offset: 0x369)
// dev strs .. 0   (offset: 0x38d)
// exports ... 6   (offset: 0x181)
// cseg ...... 0x8a + 0xf7 (0x181)
// imports ... 8   (offset: 0x271)
// animtree1 . 0   (offset: 0x38d)
// animtree2 . 0   (offset: 0x38d)
#using scripts\common\callbacks;
#using scripts\mp\gamelogic;
#using scripts\mp\weapons;

#namespace impact_grenade;

// Namespace impact_grenade
// Params 0, eflags: 0x5
// Checksum 0xcdb3ef51, Offset: 0xa8
// Size: 0x14
function private autoexec function_2e156f7b4a6033d3()
{
    level callback::add( "init_grenade", &init );
}

// Namespace impact_grenade
// Params 1, eflags: 0x4
// Checksum 0x525ba9d4, Offset: 0xc4
// Size: 0x1d
function private init( params )
{
    weapons::registerusedcallback( "impact_grenade", &used );
}

// Namespace impact_grenade
// Params 1, eflags: 0x4
// Checksum 0x1033b649, Offset: 0xe9
// Size: 0x15
function private used( grenade )
{
    grenade thread watch_stuck();
}

// Namespace impact_grenade
// Params 0, eflags: 0x4
// Checksum 0x549cef4e, Offset: 0x106
// Size: 0x57
function private watch_stuck()
{
    self endon( #"impact_death_delay" );
    thread cleanup_watcher();
    self waittill( #"projectile_impact_player", stuckto );
    
    if ( isplayer( stuckto ) )
    {
        self.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weapon_object, 1, "special_hits" );
    }
}

// Namespace impact_grenade
// Params 0, eflags: 0x4
// Checksum 0xe1b78489, Offset: 0x165
// Size: 0x1c
function private cleanup_watcher()
{
    self waittill( #"death" );
    waitframe();
    self notify( #"impact_death_delay" );
}

