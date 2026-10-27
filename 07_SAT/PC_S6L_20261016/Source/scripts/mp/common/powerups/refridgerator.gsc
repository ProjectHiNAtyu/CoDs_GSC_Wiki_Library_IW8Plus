// scripts\mp\common\powerups\refridgerator.gsc  (hash_222cd8c9f3f95056.gscc) (size: 1158 Bytes / 0x486 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf24620ce (4064682190)
// size ...... 1158 (0x486)
// includes .. 3   (offset: 0x442)
// strings ... 3   (offset: 0x45a)
// dev strs .. 0   (offset: 0x486)
// exports ... 5   (offset: 0x262)
// cseg ...... 0x87 + 0x1db (0x262)
// imports ... 10  (offset: 0x32a)
// animtree1 . 0   (offset: 0x486)
// animtree2 . 0   (offset: 0x486)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;

#namespace refridgerator;

// Namespace refridgerator
// Params 0, eflags: 0x1
// Checksum 0xf8a67880, Offset: 0xa5
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"hash_36becc54c0baa20b", 0 ) )
    {
        return;
    }
    
    init_refridgerator();
}

// Namespace refridgerator
// Params 1, eflags: 0x4
// Checksum 0xbdfb651a, Offset: 0xc8
// Size: 0x1d
function private init_refridgerator( var_a53a6962d153065f )
{
    powerups::register_powerup( "refridgerator", &grab_refridgerator );
}

// Namespace refridgerator
// Params 2, eflags: 0x4
// Checksum 0xd99cf86, Offset: 0xed
// Size: 0xf9
function private grab_refridgerator( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    root = powerups::get_powerups_root();
    n_lifetime = root.powerups[ "refridgerator" ].var_3f03b937c69044df;
    
    if ( isdefined( level.powerup_timeout_override ) )
    {
        n_lifetime = self [[ level.powerup_timeout_override ]]( n_lifetime );
    }
    
    foreach ( player in a_players )
    {
        player thread set_refridgerator( n_lifetime, root );
    }
    
    level notify( #"hash_e3c910c0983dc51e" );
}

// Namespace refridgerator
// Params 2, eflags: 0x4
// Checksum 0x3a4d34d8, Offset: 0x1ee
// Size: 0x74
function private set_refridgerator( n_lifetime, root )
{
    self notify( #"hash_9d6e393ee9085708" );
    self endon( #"hash_9d6e393ee9085708" );
    self.powerup_refridgerator = 1;
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "refridgerator", n_lifetime );
    utility::waittill_any_timeout( n_lifetime, "end_refridgerator", "death" );
    
    if ( isdefined( self ) )
    {
        self.powerup_refridgerator = undefined;
        self notify( #"hash_572edd00ce1ff53" );
    }
}

