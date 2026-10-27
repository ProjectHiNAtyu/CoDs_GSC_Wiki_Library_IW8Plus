// scripts\mp\common\perks\perk_double_points.gsc  (hash_0405d154170c1942.gscc) (size: 1319 Bytes / 0x527 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf26c482f (4067182639)
// size ...... 1319 (0x527)
// includes .. 2   (offset: 0x4cf)
// strings ... 4   (offset: 0x4df)
// dev strs .. 0   (offset: 0x527)
// exports ... 8   (offset: 0x26b)
// cseg ...... 0x94 + 0x1d7 (0x26b)
// imports ... 10  (offset: 0x3ab)
// animtree1 . 0   (offset: 0x527)
// animtree2 . 0   (offset: 0x527)
#using scripts\common\callbacks;
#using scripts\common\powerups;

#namespace perk_double_points;

// Namespace perk_double_points
// Params 0, eflags: 0x1
// Checksum 0x312721f5, Offset: 0xb2
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_double_points
// Params 1
// Checksum 0x3108ac10, Offset: 0xd2
// Size: 0x5d
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_double_points" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_double_points", &perk_set, &perk_unset, [] );
    }
}

// Namespace perk_double_points
// Params 0
// Checksum 0x839b0bce, Offset: 0x137
// Size: 0x9
function perk_set()
{
    thread perk_apply_effect();
}

// Namespace perk_double_points
// Params 0
// Checksum 0x2527003a, Offset: 0x148
// Size: 0x37
function perk_unset()
{
    self notify( #"double_points_unset" );
    
    if ( self getscriptableparthasstate( "double_points_fx", "off" ) )
    {
        self setscriptablepartstate( "double_points_fx", "off" );
    }
    
    function_4c559959d14b2ff3();
}

// Namespace perk_double_points
// Params 0
// Checksum 0x13740eb0, Offset: 0x187
// Size: 0x43
function perk_apply_effect()
{
    self endon( #"death_or_disconnect" );
    self endon( #"double_points_unset" );
    
    if ( self getscriptableparthasstate( "double_points_fx", "on" ) )
    {
        self setscriptablepartstate( "double_points_fx", "on" );
    }
    
    function_6d67af66ef215a1c();
}

// Namespace perk_double_points
// Params 0
// Checksum 0x745f2c28, Offset: 0x1d2
// Size: 0x42
function function_6d67af66ef215a1c()
{
    root = powerups::get_powerups_root();
    
    if ( isdefined( root.var_a53a6962d153065f ) )
    {
        self [[ root.var_a53a6962d153065f ]]( 2 );
    }
    
    self.plunder_pickup_multiplier = 2;
}

// Namespace perk_double_points
// Params 0
// Checksum 0x73227a37, Offset: 0x21c
// Size: 0x4f
function function_4c559959d14b2ff3()
{
    root = powerups::get_powerups_root();
    
    if ( isdefined( self ) )
    {
        if ( isdefined( root.var_a53a6962d153065f ) )
        {
            self [[ root.var_a53a6962d153065f ]]( 1 );
        }
        
        self.plunder_pickup_multiplier = undefined;
        self notify( #"hash_ac5614462d6f7a81" );
    }
}

