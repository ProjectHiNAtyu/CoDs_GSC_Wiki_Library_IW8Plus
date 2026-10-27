// scripts\mp\common\killstreaks\circle_peek.gsc  (hash_0d79f4feed7d0186.gscc) (size: 2824 Bytes / 0xb08 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d9891a8 (764973480)
// size ...... 2824 (0xb08)
// includes .. 7   (offset: 0xa24)
// strings ... 10  (offset: 0xa5c)
// dev strs .. 2   (offset: 0xae8)
// exports ... 9   (offset: 0x668)
// cseg ...... 0xfb + 0x56d (0x668)
// imports ... 20  (offset: 0x7d0)
// animtree1 . 0   (offset: 0xb08)
// animtree2 . 0   (offset: 0xb08)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;

#namespace circle_peek;

// Namespace circle_peek
// Params 0
// Checksum 0xd1131369, Offset: 0x119
// Size: 0x27
function init()
{
    killstreaks::registerkillstreak( "circle_peek", &function_4afece668af0e2ac, undefined );
    game[ "dialog" ][ "use_circle_peek" ] = "4sit_wzan_klls";
}

// Namespace circle_peek
// Params 1
// Checksum 0xf8544eab, Offset: 0x148
// Size: 0xe, Type: bool
function weapongivenchoppergunner( streakinfo )
{
    return true;
}

// Namespace circle_peek
// Params 0
// Checksum 0x1d70d89b, Offset: 0x15f
// Size: 0x22
function function_2175a48ea3af0f31()
{
    streakinfo = killstreak_utility::createstreakinfo( "circle_peek", self );
    return function_4afece668af0e2ac( streakinfo );
}

// Namespace circle_peek
// Params 0
// Checksum 0x15732567, Offset: 0x18a
// Size: 0x32
function function_ac4807df7989715a()
{
    streakinfo = killstreak_utility::createstreakinfo( "circle_peek", self );
    streakinfo.skipequippedstreakcheck = 1;
    return function_4afece668af0e2ac( streakinfo, 1 );
}

// Namespace circle_peek
// Params 2
// Checksum 0x5c646dcd, Offset: 0x1c5
// Size: 0x265
function function_4afece668af0e2ac( streakinfo, directuse )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( !directuse )
    {
        bundle = level.streakglobals.streakbundles[ "circle_peek" ];
        
        if ( isdefined( bundle ) && isdefined( bundle.deployweaponname ) )
        {
            deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( bundle.deployweaponname ) );
        }
        else
        {
            deployweaponobj = makeweapon( "ks_gesture_phone_mp" );
            deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, deployweaponobj );
        }
        
        if ( !deployresult )
        {
            return 0;
        }
    }
    
    var_a227ad75bf74130d = bundle.circlepeek_amount ?? getdvarint( @"hash_f07b00937abc199e", 1 );
    
    if ( isdefined( level.teamswithcirclepeek[ self.team ] ) && level.teamswithcirclepeek[ self.team ] >= var_a227ad75bf74130d )
    {
        lower_message::setlowermessageomnvar( "circle_peek_soft_limit", undefined, 5 );
        return 0;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( var_a227ad75bf74130d == 0 )
    {
        result = function_49e18e194b93d52b( streakinfo );
    }
    else
    {
        result = function_3be01c54b726f6bd( streakinfo, var_a227ad75bf74130d );
    }
    
    if ( !result )
    {
        return result;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakinfo.streakname, self.origin );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + streakinfo.streakname, self );
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "use_" + "circle_peek", #"use", 1 );
    level thread br_public::brleaderdialogteam( "use_circle_peek", self.team, 0, undefined, undefined, "dx_br_brdm_" );
    return 1;
}

// Namespace circle_peek
// Params 1
// Checksum 0x7446a1a9, Offset: 0x433
// Size: 0xee, Type: bool
function function_49e18e194b93d52b( streakinfo )
{
    if ( !isdefined( level.teamswithcirclepeek ) )
    {
        /#
            self iprintlnbold( "<dev string:x24>" );
        #/
        
        return false;
    }
    
    if ( !isdefined( level.br_circle.circleindex ) )
    {
        /#
            self iprintlnbold( "<dev string:x68>" );
        #/
        
        return false;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ self.team ] ) )
    {
        level.teamswithcirclepeek[ self.team ] = 0;
    }
    
    var_eba196f43a2bef60 = level.teamswithcirclepeek[ self.team ] + level.br_circle.circleindex + 1;
    thread function_3ab5bf2e6717fb6a();
    
    for ( i = var_eba196f43a2bef60; i < level.circlepeeks.size ; i++ )
    {
        br_contract_manager::questrewardcirclepeek( self.team );
    }
    
    return true;
}

// Namespace circle_peek
// Params 2
// Checksum 0xf1f53399, Offset: 0x52a
// Size: 0x109, Type: bool
function function_3be01c54b726f6bd( streakinfo, var_a227ad75bf74130d )
{
    if ( !isdefined( level.teamswithcirclepeek ) )
    {
        /#
            self iprintlnbold( "<dev string:x24>" );
        #/
        
        return false;
    }
    
    if ( !isdefined( level.br_circle.circleindex ) )
    {
        /#
            self iprintlnbold( "<dev string:x68>" );
        #/
        
        return false;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ self.team ] ) )
    {
        level.teamswithcirclepeek[ self.team ] = 0;
    }
    
    var_eba196f43a2bef60 = level.teamswithcirclepeek[ self.team ] + level.br_circle.circleindex + 1;
    thread function_3ab5bf2e6717fb6a();
    
    for ( i = var_eba196f43a2bef60; i < var_eba196f43a2bef60 + var_a227ad75bf74130d ; i++ )
    {
        if ( level.teamswithcirclepeek[ self.team ] < var_a227ad75bf74130d )
        {
            br_contract_manager::questrewardcirclepeek( self.team );
        }
    }
    
    return true;
}

// Namespace circle_peek
// Params 0
// Checksum 0x7162ceea, Offset: 0x63c
// Size: 0x2c
function function_3ab5bf2e6717fb6a()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.45;
    setomnvar( "ui_minimap_pulse", 2 );
}

