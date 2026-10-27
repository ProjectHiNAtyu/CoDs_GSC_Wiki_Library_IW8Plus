// scripts\mp\oxygenmask_mp.gsc  (hash_3c9f0944a991edb0.gscc) (size: 2728 Bytes / 0xaa8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x261c1d7b (639376763)
// size ...... 2728 (0xaa8)
// includes .. 4   (offset: 0xa34)
// strings ... 7   (offset: 0xa54)
// dev strs .. 0   (offset: 0xaa8)
// exports ... 12  (offset: 0x578)
// cseg ...... 0xf3 + 0x485 (0x578)
// imports ... 25  (offset: 0x758)
// animtree1 . 0   (offset: 0xaa8)
// animtree2 . 0   (offset: 0xaa8)
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\mp\oxygenmask;
#using scripts\mp\supers;

#namespace oxygenmask_mp;

// Namespace oxygenmask_mp
// Params 0
// Checksum 0xa67f083a, Offset: 0x111
// Size: 0x10e
function init()
{
    utility::registersharedfunc( #"oxygenmask", #"onunusable", &function_f0c831ecd23c2da5 );
    utility::registersharedfunc( #"oxygenmask", #"onequip", &function_67a1a104c29e5d0a );
    utility::registersharedfunc( #"oxygenmask", #"onuse", &oxygenmask_onuse );
    utility::registersharedfunc( #"oxygenmask", #"onusecomplete", &function_f11977779155e1ba );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_oxygen_mask" );
    level.oxygenmaskdata.holdweapon = bundle.useweapon;
    
    if ( isdefined( level.oxygenmaskdata.holdweapon ) )
    {
        level.oxygenmaskdata.holdweaponname = getweaponbasename( level.oxygenmaskdata.holdweapon );
        return;
    }
    
    level.oxygenmaskdata.holdweaponname = "iw9_oxygenmask_mp";
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0xabb3928, Offset: 0x227
// Size: 0x91
function function_f0c831ecd23c2da5()
{
    self endon( #"death_or_disconnect" );
    msg = undefined;
    
    if ( self isswimsprinting() )
    {
        msg = "MP/DISABLED_WHILE_SWIM_SPRINT";
    }
    else if ( !self isswimunderwater() )
    {
        msg = "MP/DISABLED_WHILE_NOT_SWIMMING";
    }
    
    if ( isdefined( msg ) && function_40f7824e29d09d18( msg ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( msg );
            function_43d05dd9710dac7c( msg );
        }
    }
}

// Namespace oxygenmask_mp
// Params 1
// Checksum 0x56af4711, Offset: 0x2c0
// Size: 0x47
function function_43d05dd9710dac7c( errorref )
{
    superinfo = self.super;
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    superinfo.omstarttime = gettime();
    superinfo.var_a93e534a6dcd080f = errorref;
}

// Namespace oxygenmask_mp
// Params 1
// Checksum 0x9126e825, Offset: 0x30f
// Size: 0x78
function function_40f7824e29d09d18( var_b300a443d1d15ab3 )
{
    superinfo = self.super;
    
    if ( !isdefined( superinfo ) )
    {
        return 0;
    }
    
    if ( superinfo.var_a93e534a6dcd080f == var_b300a443d1d15ab3 )
    {
        if ( !isdefined( superinfo.omstarttime ) )
        {
            return 1;
        }
        else if ( gettime() > superinfo.omstarttime + 1500 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0x2bd47cc5, Offset: 0x38f
// Size: 0x9
function function_67a1a104c29e5d0a()
{
    childthread function_9a23cdea9da58f88();
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0x7a2f53b0, Offset: 0x3a0
// Size: 0x8a
function function_9a23cdea9da58f88()
{
    while ( true )
    {
        self waittill( #"weapon_fired" );
        currentweapon = self getcurrentweapon();
        
        if ( isdefined( currentweapon.basename ) && currentweapon.basename != level.oxygenmaskdata.holdweaponname )
        {
            return;
        }
        
        stockammo = self getweaponammostock( currentweapon );
        
        if ( stockammo > 0 )
        {
            self setweaponammoclip( currentweapon, 1 );
            self setweaponammostock( currentweapon, stockammo - 1 );
        }
    }
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0x263e9929, Offset: 0x432
// Size: 0x3d
function oxygenmask_onuse()
{
    swim_common::function_858b92a50d1c824b( 1 );
    thread function_e79753ff42b51d76();
    thread function_f9b018a861ae8f67( "death" );
    thread function_f9b018a861ae8f67( "weapon_change" );
    thread function_f9b018a861ae8f67( "offhand_pullback" );
    thread function_6ec379bb0217e434();
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0xedfb0222, Offset: 0x477
// Size: 0x4f
function function_6ec379bb0217e434()
{
    self endon( #"disconnect" );
    self endon( #"oxygenmask_fired" );
    self endon( #"oxygenmask_fail" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self ismeleeing() )
        {
            self notify( #"oxygenmask_fail" );
        }
        
        waitframe();
    }
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0xc522d660, Offset: 0x4ce
// Size: 0x42
function function_e79753ff42b51d76()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"weapon_fired" );
    self waittill( #"oxygenmask_fail" );
    oxygenmask::cleanup_oxygenmask();
    swim_common::function_858b92a50d1c824b( 0 );
}

// Namespace oxygenmask_mp
// Params 1
// Checksum 0x48f982c3, Offset: 0x518
// Size: 0x4e
function function_f9b018a861ae8f67( failnotify )
{
    self endon( #"disconnect" );
    self endon( #"oxygenmask_fired" );
    self endon( #"oxygenmask_fail" );
    level endon( #"game_ended" );
    self waittill( failnotify );
    self notify( #"oxygenmask_fail" );
}

// Namespace oxygenmask_mp
// Params 0
// Checksum 0xa87f7b30, Offset: 0x56e
// Size: 0xa
function function_f11977779155e1ba()
{
    swim_common::function_858b92a50d1c824b( 0 );
}

