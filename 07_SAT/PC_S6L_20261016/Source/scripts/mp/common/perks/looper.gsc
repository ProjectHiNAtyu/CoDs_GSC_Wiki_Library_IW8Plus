// scripts\mp\common\perks\looper.gsc  (hash_08fe716a3deff381.gscc) (size: 1057 Bytes / 0x421 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb58d59d0 (3045939664)
// size ...... 1057 (0x421)
// includes .. 1   (offset: 0x405)
// strings ... 1   (offset: 0x40d)
// dev strs .. 0   (offset: 0x421)
// exports ... 6   (offset: 0x231)
// cseg ...... 0x6c + 0x1c5 (0x231)
// imports ... 8   (offset: 0x321)
// animtree1 . 0   (offset: 0x421)
// animtree2 . 0   (offset: 0x421)
#using scripts\common\callbacks;

#namespace looper;

// Namespace looper
// Params 0, eflags: 0x1
// Checksum 0x36ab3d4f, Offset: 0x8a
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_cac16087e3f93b6 );
}

// Namespace looper
// Params 1
// Checksum 0x53a93e1, Offset: 0xaa
// Size: 0x5c
function function_cac16087e3f93b6( params )
{
    bundle = level.perkbundles[ "specialty_looper" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_looper", &setlooper, &unsetlooper );
    }
}

// Namespace looper
// Params 0
// Checksum 0x91e2a39d, Offset: 0x10e
// Size: 0x76
function setlooper()
{
    bundle = level.perkbundles[ "specialty_looper" ];
    self.var_3954d804557beb55 = bundle.var_1e9d79c3b9584677 ?? 999;
    self.var_bbcb5b8525f16f4b[ 1 ] = 0;
    self.var_bbcb5b8525f16f4b[ 2 ] = 0;
    self.var_bbcb5b8525f16f4b[ 3 ] = 0;
    callback::add( #"killstreak_activated", &function_837c8de566c5a461 );
}

// Namespace looper
// Params 0
// Checksum 0xa9e5dbca, Offset: 0x18c
// Size: 0x17
function unsetlooper()
{
    callback::remove( #"killstreak_activated", &function_837c8de566c5a461 );
}

// Namespace looper
// Params 1, eflags: 0x4
// Checksum 0x6887f176, Offset: 0x1ab
// Size: 0x86
function private function_837c8de566c5a461( params )
{
    if ( !isdefined( self.var_bbcb5b8525f16f4b[ params.streakslot ] ) )
    {
        return;
    }
    
    self.var_bbcb5b8525f16f4b[ params.streakslot ]++;
    
    if ( self.var_bbcb5b8525f16f4b[ params.streakslot ] >= self.var_3954d804557beb55 )
    {
        self setclientomnvar( level.streakglobals.var_4c3d20e7c093163[ params.streakslot ], 1 );
    }
}

