// scripts\mp\common\powerups\powerup_zombie_legs.gsc  (hash_25ad2b6fd9ceb625.gscc) (size: 1534 Bytes / 0x5fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2daa833 (4074416179)
// size ...... 1534 (0x5fe)
// includes .. 3   (offset: 0x5a6)
// strings ... 4   (offset: 0x5be)
// dev strs .. 0   (offset: 0x5fe)
// exports ... 8   (offset: 0x2be)
// cseg ...... 0xa4 + 0x21a (0x2be)
// imports ... 15  (offset: 0x3fe)
// animtree1 . 0   (offset: 0x5fe)
// animtree2 . 0   (offset: 0x5fe)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;

#namespace powerup_zombie_legs;

// Namespace powerup_zombie_legs
// Params 0, eflags: 0x1
// Checksum 0x8e7a9c1e, Offset: 0xc2
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"scr_disable_powerup_zombie_legs", 0 ) )
    {
        return;
    }
    
    init();
}

// Namespace powerup_zombie_legs
// Params 0
// Checksum 0x2d046cc1, Offset: 0xe5
// Size: 0x18
function init()
{
    powerups::register_powerup( "zombie_legs", &function_6638234b060fb05d, &powerup_should_drop );
}

// Namespace powerup_zombie_legs
// Params 2
// Checksum 0x5fe5ef8e, Offset: 0x105
// Size: 0x99
function function_6638234b060fb05d( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread powerup_apply_zombie_legs();
    }
}

// Namespace powerup_zombie_legs
// Params 0
// Checksum 0xae8acac6, Offset: 0x1a6
// Size: 0x4, Type: bool
function powerup_should_drop()
{
    return true;
}

// Namespace powerup_zombie_legs
// Params 1
// Checksum 0xc52a2187, Offset: 0x1b3
// Size: 0x95
function powerup_apply_zombie_legs( n_lifetime )
{
    self notify( #"powerup_apply_zombie_legs" );
    self endon( #"powerup_apply_zombie_legs" );
    self endon( #"disconnect" );
    
    if ( !isdefined( n_lifetime ) )
    {
        n_lifetime = powerups::function_f379817a62e3850c( "zombie_legs" );
    }
    
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "zombie_legs", n_lifetime );
    
    if ( !self.var_c7db4a5f206339af )
    {
        self.var_c7db4a5f206339af = 1;
        namespace_9d8e359c3b1041e5::giveperksharedfunc( "specialty_zombie_legs" );
        thread function_2a4c443657270442();
    }
    
    utility::waittill_any_timeout( n_lifetime, "end_powerup_zombie_legs", "death" );
    powerup_remove_zombie_legs();
}

// Namespace powerup_zombie_legs
// Params 0
// Checksum 0x7f8cf6a3, Offset: 0x250
// Size: 0x24
function powerup_remove_zombie_legs()
{
    self notify( #"powerup_remove_zombie_legs" );
    namespace_9d8e359c3b1041e5::removeperksharedfunc( "specialty_zombie_legs" );
    self.var_c7db4a5f206339af = undefined;
}

// Namespace powerup_zombie_legs
// Params 0
// Checksum 0xfccda639, Offset: 0x27c
// Size: 0x42
function function_2a4c443657270442()
{
    self endon( #"powerup_remove_zombie_legs" );
    self endon( #"death_or_disconnect" );
    
    while ( self.var_c7db4a5f206339af )
    {
        self waittill( #"giveloadout" );
        namespace_9d8e359c3b1041e5::giveperksharedfunc( "specialty_zombie_legs" );
    }
}

