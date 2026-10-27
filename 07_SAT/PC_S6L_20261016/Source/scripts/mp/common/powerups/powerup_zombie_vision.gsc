// scripts\mp\common\powerups\powerup_zombie_vision.gsc  (hash_2c52fb6d8d2b9900.gscc) (size: 1792 Bytes / 0x700 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd77a23d9 (3615106009)
// size ...... 1792 (0x700)
// includes .. 3   (offset: 0x698)
// strings ... 5   (offset: 0x6b0)
// dev strs .. 0   (offset: 0x700)
// exports ... 9   (offset: 0x334)
// cseg ...... 0xc2 + 0x272 (0x334)
// imports ... 18  (offset: 0x49c)
// animtree1 . 0   (offset: 0x700)
// animtree2 . 0   (offset: 0x700)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;

#namespace powerup_zombie_vision;

// Namespace powerup_zombie_vision
// Params 0, eflags: 0x1
// Checksum 0x6e893f3e, Offset: 0xe0
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"scr_disable_powerup_zombie_vision", 0 ) )
    {
        return;
    }
    
    init();
}

// Namespace powerup_zombie_vision
// Params 0
// Checksum 0x927234b3, Offset: 0x103
// Size: 0x18
function init()
{
    powerups::register_powerup( "zombie_vision", &function_6638234b060fb05d, &powerup_should_drop );
}

// Namespace powerup_zombie_vision
// Params 2
// Checksum 0x1f4334b9, Offset: 0x123
// Size: 0x99
function function_6638234b060fb05d( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread function_45a100bd472e0989();
    }
}

// Namespace powerup_zombie_vision
// Params 0
// Checksum 0x40577beb, Offset: 0x1c4
// Size: 0x4, Type: bool
function powerup_should_drop()
{
    return true;
}

// Namespace powerup_zombie_vision
// Params 1
// Checksum 0x92c0ac4f, Offset: 0x1d1
// Size: 0xa7
function function_45a100bd472e0989( n_lifetime )
{
    self notify( #"hash_e2f1c34395f20370" );
    self endon( #"hash_e2f1c34395f20370" );
    self endon( #"disconnect" );
    
    if ( !isdefined( n_lifetime ) )
    {
        n_lifetime = powerups::function_f379817a62e3850c( "zombie_vision" );
    }
    
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "zombie_vision", n_lifetime );
    
    if ( !self.var_bfbec6f94457a756 )
    {
        self.var_bfbec6f94457a756 = 1;
        namespace_9d8e359c3b1041e5::giveperksharedfunc( "specialty_zombie_vision" );
        thread function_2a4c443657270442();
        thread powerup_watch_game_end();
    }
    
    pbgpostfxbundlestart( self, "sat_mp_stealth_perks" );
    utility::waittill_any_timeout( n_lifetime, "end_powerup_zombie_vision", "death" );
    function_82c8acd260a04507();
}

// Namespace powerup_zombie_vision
// Params 0
// Checksum 0xc69a98f6, Offset: 0x280
// Size: 0x2f
function function_82c8acd260a04507()
{
    self notify( #"hash_316041f9f5c357cc" );
    namespace_9d8e359c3b1041e5::removeperksharedfunc( "specialty_zombie_vision" );
    self.var_bfbec6f94457a756 = undefined;
    pbgpostfxbundleend( self, "sat_mp_stealth_perks" );
}

// Namespace powerup_zombie_vision
// Params 0
// Checksum 0xd42cb657, Offset: 0x2b7
// Size: 0x42
function function_2a4c443657270442()
{
    self endon( #"hash_316041f9f5c357cc" );
    self endon( #"death_or_disconnect" );
    
    while ( self.var_bfbec6f94457a756 )
    {
        self waittill( #"giveloadout" );
        namespace_9d8e359c3b1041e5::giveperksharedfunc( "specialty_zombie_vision" );
    }
}

// Namespace powerup_zombie_vision
// Params 0
// Checksum 0xe803158e, Offset: 0x301
// Size: 0x33
function powerup_watch_game_end()
{
    self endon( #"hash_316041f9f5c357cc" );
    self endon( #"death_or_disconnect" );
    level waittill( #"game_ended" );
    self notify( #"end_powerup_zombie_vision" );
}

