// script_4d4682ef93c2b16f  (hash_4d4682ef93c2b16f.gscc) (size: 1701 Bytes / 0x6a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7890d06 (126422278)
// size ...... 1701 (0x6a5)
// includes .. 2   (offset: 0x661)
// strings ... 3   (offset: 0x671)
// dev strs .. 0   (offset: 0x6a5)
// exports ... 8   (offset: 0x3bd)
// cseg ...... 0x15e + 0x25f (0x3bd)
// imports ... 12  (offset: 0x4fd)
// animtree1 . 0   (offset: 0x6a5)
// animtree2 . 0   (offset: 0x6a5)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;

#namespace namespace_7cac3ffdb2ceac22;

// Namespace namespace_7cac3ffdb2ceac22
// Params 0, eflags: 0x5
// Checksum 0x21f5569f, Offset: 0x17c
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "stock_option", #"bgb", &__init__, undefined );
}

// Namespace namespace_7cac3ffdb2ceac22
// Params 0
// Checksum 0xebfde20a, Offset: 0x1a1
// Size: 0x24
function __init__()
{
    bgb::register( "stock_option", "time", 60, &enable, &disable, &validation );
}

// Namespace namespace_7cac3ffdb2ceac22
// Params 0
// Checksum 0x3ebecbf4, Offset: 0x1cd
// Size: 0x9
function enable()
{
    thread special_weapon_watcher();
}

// Namespace namespace_7cac3ffdb2ceac22
// Params 0
// Checksum 0x577b0863, Offset: 0x1de
// Size: 0x1c
function disable()
{
    self notify( #"disable_stock_option" );
    waitframe();
    self unsetperk( "specialty_ammodrainsfromstockfirst", 1 );
}

// Namespace namespace_7cac3ffdb2ceac22
// Params 0
// Checksum 0x77a840f7, Offset: 0x202
// Size: 0x22, Type: bool
function validation()
{
    w_current = self getcurrentweapon();
    
    if ( is_banned_weapon( w_current ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_7cac3ffdb2ceac22
// Params 0
// Checksum 0x423ea3c5, Offset: 0x22d
// Size: 0x8b
function special_weapon_watcher()
{
    self endon( #"disconnect" );
    self endon( #"disable_stock_option" );
    w_current = self getcurrentweapon();
    
    if ( !is_banned_weapon( w_current ) )
    {
        self setperk( "specialty_ammodrainsfromstockfirst", 1 );
    }
    
    while ( true )
    {
        self waittill( #"weapon_change", new_weapon );
        
        if ( is_banned_weapon( new_weapon ) )
        {
            self unsetperk( "specialty_ammodrainsfromstockfirst", 1 );
            continue;
        }
        
        self setperk( "specialty_ammodrainsfromstockfirst", 1 );
    }
}

// Namespace namespace_7cac3ffdb2ceac22
// Params 1
// Checksum 0x2cd510f3, Offset: 0x2c0
// Size: 0xfc, Type: bool
function is_banned_weapon( weapon )
{
    foreach ( str_attachment in weapon.attachments )
    {
        switch ( str_attachment )
        {
            case #"hash_1c1b4fd6c398312d":
            case #"hash_44e1c9769dc16f6a":
            case #"hash_6472a8ac163ce178":
            case #"hash_9ab5357088940c25":
            case #"hash_b24414861abc07a7":
            case #"hash_b2f5d9c5a1c2932a":
                return true;
        }
    }
    
    switch ( weapon.basename )
    {
        case #"hash_ac5b079adcf1af6d":
            return true;
    }
    
    return false;
}

