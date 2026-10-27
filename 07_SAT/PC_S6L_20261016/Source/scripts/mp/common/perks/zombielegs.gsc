// scripts\mp\common\perks\zombielegs.gsc  (hash_31fcff29baeff04f.gscc) (size: 1536 Bytes / 0x600 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x613c3d71 (1631337841)
// size ...... 1536 (0x600)
// includes .. 3   (offset: 0x5ac)
// strings ... 4   (offset: 0x5c4)
// dev strs .. 0   (offset: 0x600)
// exports ... 8   (offset: 0x2d8)
// cseg ...... 0xb8 + 0x220 (0x2d8)
// imports ... 14  (offset: 0x418)
// animtree1 . 0   (offset: 0x600)
// animtree2 . 0   (offset: 0x600)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;

#namespace zombielegs;

// Namespace zombielegs
// Params 0, eflags: 0x1
// Checksum 0x38e6ee2c, Offset: 0xd6
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace zombielegs
// Params 1
// Checksum 0x3a9cb6e5, Offset: 0xf6
// Size: 0x66
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_zombie_legs" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_zombie_legs", &perk_set, &perk_unset, [ "specialty_sprintmelee" ] );
    }
}

// Namespace zombielegs
// Params 0
// Checksum 0x8a5ac417, Offset: 0x164
// Size: 0x9
function perk_set()
{
    thread perk_apply_effect();
}

// Namespace zombielegs
// Params 0
// Checksum 0x42c709e4, Offset: 0x175
// Size: 0x2a
function perk_unset()
{
    self lerpfovbypreset( "default_2seconds" );
    self notify( #"zombie_legs_unset" );
    self.falldamageprotection = 0;
    function_95338b0d45bd7965();
}

// Namespace zombielegs
// Params 0
// Checksum 0x51fcac56, Offset: 0x1a7
// Size: 0x4e
function perk_apply_effect()
{
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_legs_unset" );
    self refreshsprinttime();
    self.falldamageprotection = 1;
    function_3a6756e887f529ee();
    
    while ( true )
    {
        if ( self issupersprinting() )
        {
            self refreshsprinttime();
        }
        
        wait 0.1;
    }
}

// Namespace zombielegs
// Params 0
// Checksum 0x1027ae0, Offset: 0x1fd
// Size: 0x87
function function_3a6756e887f529ee()
{
    bundle = level.perkbundles[ "specialty_zombie_legs" ];
    speedmod = bundle.var_c400370a20b6d924 ?? 0.1;
    self.perkzombielegsspeedmod = speedmod;
    common::function_ac4bf3256b2545e3( "perkZombieLegsSpeedMod", speedmod );
    
    if ( utility::issharedfuncdefined( #"player", #"updatemovespeed" ) )
    {
        utility::callsharedfunc( #"player", #"updatemovespeed" );
    }
}

// Namespace zombielegs
// Params 0
// Checksum 0xf31ccad7, Offset: 0x28c
// Size: 0x4c
function function_95338b0d45bd7965()
{
    self.perkzombielegsspeedmod = undefined;
    common::function_d85a92c557ea5a52( "perkZombieLegsSpeedMod" );
    
    if ( utility::issharedfuncdefined( #"player", #"updatemovespeed" ) )
    {
        utility::callsharedfunc( #"player", #"updatemovespeed" );
    }
}

