// script_40faca4b75c4139d  (hash_40faca4b75c4139d.gscc) (size: 1955 Bytes / 0x7a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0cfcce2 (3771714786)
// size ...... 1955 (0x7a3)
// includes .. 7   (offset: 0x703)
// strings ... 6   (offset: 0x73b)
// dev strs .. 0   (offset: 0x7a3)
// exports ... 6   (offset: 0x423)
// cseg ...... 0xc8 + 0x35b (0x423)
// imports ... 17  (offset: 0x513)
// animtree1 . 0   (offset: 0x7a3)
// animtree2 . 0   (offset: 0x7a3)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace specialty_resolute;

// Namespace specialty_resolute
// Params 0, eflags: 0x1
// Checksum 0x770e31a7, Offset: 0xe6
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_8923879b1afb77e0 );
}

// Namespace specialty_resolute
// Params 1
// Checksum 0xc78542c4, Offset: 0x106
// Size: 0x67
function function_8923879b1afb77e0( params )
{
    bundle = level.perkbundles[ "specialty_resolute" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_resolute", &setresolute, &unsetresolute, [ "specialty_delaymine" ], undefined );
    }
}

// Namespace specialty_resolute
// Params 0
// Checksum 0x1ced392a, Offset: 0x175
// Size: 0x93
function setresolute()
{
    self.resolutespeedmod = 0;
    self.hasresolute = 1;
    self.var_b38065f0a75f3418 = self.var_9842326056fd7207.var_6d931968481d74e4 ?? getdvarint( @"hash_87db853764e7f565", 3000 );
    self.var_4f537e9f98aea3dc = self.var_9842326056fd7207.var_4ee89a57b15ba9d ?? getdvarfloat( @"scr_perk_resolute_speed_mod", 0.15 );
    self.lastshottime = self.var_b38065f0a75f3418 * -1;
    thread watchdamagethread();
}

// Namespace specialty_resolute
// Params 0
// Checksum 0x13eadd0c, Offset: 0x210
// Size: 0x2c
function unsetresolute()
{
    self.var_b38065f0a75f3418 = undefined;
    self.var_4f537e9f98aea3dc = undefined;
    self.hasresolute = 0;
    self notify( #"resolute_unset" );
}

// Namespace specialty_resolute
// Params 0
// Checksum 0x3fbc0d0f, Offset: 0x244
// Size: 0x1df
function watchdamagethread()
{
    self notify( #"hash_3b838889f11d8d8" );
    self endon( #"hash_3b838889f11d8d8" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self.resolutespeedmod <= 0 )
        {
            utility::waittill_any( "resolute_shot", "resolute_unset" );
        }
        
        if ( !self.hasresolute )
        {
            break;
        }
        
        speedmod = 0;
        timestamp = gettime();
        var_8327890ff4f1a28 = player::isreallyalive( self );
        
        if ( var_8327890ff4f1a28 && self.lastshottime + self.var_b38065f0a75f3418 >= timestamp )
        {
            speedmod = self.var_4f537e9f98aea3dc;
        }
        
        if ( speedmod != self.resolutespeedmod )
        {
            self.resolutespeedmod = speedmod;
            
            if ( !common::function_8ff835bf23198a0( "resoluteSpeedMod" ) )
            {
                common::function_ac4bf3256b2545e3( "resoluteSpeedMod", speedmod );
            }
            else if ( speedmod <= 0 )
            {
                common::function_d85a92c557ea5a52( "resoluteSpeedMod" );
            }
            
            if ( var_8327890ff4f1a28 )
            {
                weapons::updatemovespeedscale();
            }
            
            if ( speedmod > 0 )
            {
                namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_resolute" );
                perkfunctions::function_fd784ee883797b4b( "resolute" );
                wait ( self.lastshottime + self.var_b38065f0a75f3418 - timestamp ) / 1000;
            }
            else
            {
                perkfunctions::function_11ff2063f097a68f( "resolute" );
            }
            
            continue;
        }
        
        if ( self.resolutespeedmod > 0 )
        {
            wait ( self.lastshottime + self.var_b38065f0a75f3418 - timestamp ) / 1000;
        }
    }
    
    if ( isdefined( self.resolutespeedmod ) )
    {
        self.resolutespeedmod = undefined;
        
        if ( common::function_8ff835bf23198a0( "resoluteSpeedMod" ) )
        {
            common::function_d85a92c557ea5a52( "resoluteSpeedMod" );
        }
        
        perkfunctions::function_11ff2063f097a68f( "resolute" );
        
        if ( player::isreallyalive( self ) )
        {
            weapons::updatemovespeedscale();
        }
    }
}

