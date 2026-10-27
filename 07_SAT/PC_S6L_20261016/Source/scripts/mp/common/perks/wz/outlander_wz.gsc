// scripts\mp\common\perks\wz\outlander_wz.gsc  (hash_70b97d991306b8be.gscc) (size: 1553 Bytes / 0x611 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24bdc1f7 (616415735)
// size ...... 1553 (0x611)
// includes .. 4   (offset: 0x5b5)
// strings ... 3   (offset: 0x5d5)
// dev strs .. 0   (offset: 0x611)
// exports ... 7   (offset: 0x2e1)
// cseg ...... 0x91 + 0x250 (0x2e1)
// imports ... 15  (offset: 0x3f9)
// animtree1 . 0   (offset: 0x611)
// animtree2 . 0   (offset: 0x611)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace outlander_wz;

// Namespace outlander_wz
// Params 0, eflags: 0x1
// Checksum 0x10e75d1f, Offset: 0xaf
// Size: 0x1f
function autoexec preinit()
{
    if ( isbrgamemode() )
    {
        level callback::add( #"register_perk", &function_3e03f05582ff0dc6 );
    }
}

// Namespace outlander_wz
// Params 1
// Checksum 0x9af70dd4, Offset: 0xd6
// Size: 0x5e
function function_3e03f05582ff0dc6( params )
{
    bundle = level.perkbundles[ "specialty_outlander" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_outlander", &function_f0ec5251e113d4bd, &function_a7ef377dab519c26, undefined, undefined );
    }
}

// Namespace outlander_wz
// Params 0
// Checksum 0x14d96b65, Offset: 0x13c
// Size: 0x4f
function function_f0ec5251e113d4bd()
{
    if ( !isdefined( self.var_8ee8efc2c797c4a ) )
    {
        self.var_8ee8efc2c797c4a = 0;
    }
    
    self.var_d97303c92e1e679 = 1;
    self.var_8ee8efc2c797c4a += getdvarfloat( @"hash_50dc5065112199d7", -0.1 );
    thread outlander_updatemovespeed();
}

// Namespace outlander_wz
// Params 0
// Checksum 0x6ebdc419, Offset: 0x193
// Size: 0x38
function function_a7ef377dab519c26()
{
    self.var_d97303c92e1e679 = 0;
    self.var_8ee8efc2c797c4a -= getdvarfloat( @"hash_50dc5065112199d7", -0.1 );
    thread outlander_updatemovespeed();
}

// Namespace outlander_wz
// Params 0
// Checksum 0x31fee883, Offset: 0x1d3
// Size: 0xed
function outlander_updatemovespeed()
{
    if ( self.var_d97303c92e1e679 && function_a5c8689c923a2749() )
    {
        if ( self.outlanderspeedmod != getdvarfloat( @"hash_f12f9c3e925d6a69", 0.1 ) )
        {
            self.outlanderspeedmod = getdvarfloat( @"hash_f12f9c3e925d6a69", 0.1 );
            
            if ( !common::function_8ff835bf23198a0( "outlanderSpeedMod" ) )
            {
                common::function_ac4bf3256b2545e3( "outlanderSpeedMod", self.outlanderspeedmod );
                common::function_11a0a06c67c80f4d( "outlanderSpeedMod", 2 );
            }
            
            weapons::updatemovespeedscale();
            perkfunctions::function_fd784ee883797b4b( "outlander" );
        }
        
        return;
    }
    
    if ( isdefined( self.outlanderspeedmod ) && self.outlanderspeedmod != 0 )
    {
        self.outlanderspeedmod = 0;
        
        if ( common::function_8ff835bf23198a0( "outlanderSpeedMod" ) )
        {
            common::function_d85a92c557ea5a52( "outlanderSpeedMod" );
        }
        
        weapons::updatemovespeedscale();
        perkfunctions::function_11ff2063f097a68f( "outlander" );
    }
}

// Namespace outlander_wz
// Params 0, eflags: 0x4
// Checksum 0x73c1861f, Offset: 0x2c8
// Size: 0x18, Type: bool
function private function_a5c8689c923a2749()
{
    return self.isincircle || self.var_a7d90dea0d5e6ba2;
}

