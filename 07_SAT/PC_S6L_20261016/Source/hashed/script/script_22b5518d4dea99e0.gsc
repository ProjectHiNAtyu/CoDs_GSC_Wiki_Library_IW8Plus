// script_22b5518d4dea99e0  (hash_22b5518d4dea99e0.gscc) (size: 3973 Bytes / 0xf85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ad37450 (450065488)
// size ...... 3973 (0xf85)
// includes .. 6   (offset: 0xe21)
// strings ... 22  (offset: 0xe51)
// dev strs .. 0   (offset: 0xf85)
// exports ... 11  (offset: 0x895)
// cseg ...... 0x1c0 + 0x6d5 (0x895)
// imports ... 33  (offset: 0xa4d)
// animtree1 . 0   (offset: 0xf85)
// animtree2 . 0   (offset: 0xf85)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\escort_horde_abilities;
#using scripts\mp\hud_util;

#namespace namespace_e1bdb0f108987648;

// Namespace namespace_e1bdb0f108987648
// Params 0
// Checksum 0xb0d66a52, Offset: 0x1de
// Size: 0x64
function function_cd777845c2baaf18()
{
    var_d2ed5ad2291a9ace = level.mutationgametype.var_1eaef6af3ddd0b92;
    escort_horde_abilities::addpowerbutton( level.mutationgametype.zombie, "shout", "+frag", &function_3aa50e36094f7a2a, 0, undefined, undefined, undefined, &"hash_462acc9f5ed15a5f", undefined, var_d2ed5ad2291a9ace, "shoutStatus", "shoutProgress" );
}

// Namespace namespace_e1bdb0f108987648
// Params 2
// Checksum 0xe25f89dd, Offset: 0x24a
// Size: 0x9b
function function_3aa50e36094f7a2a( powerstruct, powerref )
{
    zombie = self;
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    zombie.var_eee053c8f4042fe6 = undefined;
    
    if ( !zombie function_37299b65091c804() )
    {
        zombie escort_horde_abilities::function_22b061104142a21e();
        zombie escort_horde_abilities::function_37287d7567e2a847( zombie.var_eee053c8f4042fe6 );
        zombie thread escort_horde_abilities::function_689938e798c377b5( powerstruct, powerref );
        return;
    }
    
    if ( zombie weapon::grenadeinpullback() )
    {
        zombie canceloffhands();
    }
    
    zombie thread function_307e8b021dbec2b9( powerstruct, powerref );
    zombie thread function_e28b91aa73e58621( powerstruct, powerref );
    zombie thread function_d0690a30b0732d7();
}

// Namespace namespace_e1bdb0f108987648
// Params 0
// Checksum 0xbbc65f65, Offset: 0x2ed
// Size: 0x5f, Type: bool
function function_37299b65091c804()
{
    zombie = self;
    
    if ( !isdefined( zombie ) || !zombie game_utility_mp::ismutationgamemodezombie() )
    {
        return false;
    }
    
    if ( zombie isswimunderwater() )
    {
        zombie.var_eee053c8f4042fe6 = "MP_BR_INGAME/ZMB_SHOUT_ERROR_UNDERWATER";
        return false;
    }
    
    if ( zombie isonladder() )
    {
        zombie.var_eee053c8f4042fe6 = "MP_BR_INGAME/ZMB_SHOUT_ERROR_LADDER";
        return false;
    }
    
    return true;
}

// Namespace namespace_e1bdb0f108987648
// Params 2
// Checksum 0x7049b40f, Offset: 0x355
// Size: 0x1f2
function function_e28b91aa73e58621( powerstruct, powerref )
{
    zombie = self;
    
    if ( !isplayer( zombie ) )
    {
        return;
    }
    
    zombie endon( #"death" );
    zombie endon( #"disconnect" );
    zombie endon( #"zombie_unset" );
    level endon( #"game_ended" );
    zombie.shouting = 1;
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        escort_horde_abilities::function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 4 );
    }
    
    self setscriptablepartstate( "zombieRageVfx", "fx_start", 0 );
    wait level.mutationgametype.var_1eaef6af3ddd0b92;
    zombie.shouting = 0;
    zombie notify( #"hash_42b50acb9b4a25fa" );
    zombie.buffed = 1;
    zombie thread function_7b626f8ddbca1005();
    self setscriptablepartstate( "zombieBuffVfx", "on", 0 );
    wait level.mutationgametype.var_16c64f75da8b736c;
    self setscriptablepartstate( "zombieBuffVfx", "off", 0 );
    self setscriptablepartstate( "zombieRageVfx", "fx_end", 0 );
    
    if ( isdefined( powerstruct.powers[ powerref ].statusupdate ) )
    {
        escort_horde_abilities::function_d4df5ef344368edd( powerstruct.powers[ powerref ].statusupdate, 1 );
    }
    
    zombie.movespeedscaler = 1;
    
    if ( zombie common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        zombie common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    zombie setmovespeedscale( zombie.movespeedscaler );
    zombie setswimspeedscale( zombie.movespeedscaler );
    zombie.buffed = 0;
    zombie notify( #"zombie_shout_finished" );
}

// Namespace namespace_e1bdb0f108987648
// Params 0
// Checksum 0xe5976e5f, Offset: 0x54f
// Size: 0xd9
function function_7b626f8ddbca1005()
{
    zombie = self;
    zombie endon( #"death" );
    zombie endon( #"disconnect" );
    zombie endon( #"zombie_unset" );
    zombie endon( #"zombie_shout_finished" );
    level endon( #"game_ended" );
    
    if ( !isdefined( zombie ) || !zombie game_utility_mp::ismutationgamemodezombie() )
    {
        return;
    }
    
    zombie setswimspeedscale( level.mutationgametype.var_36d899986585686f );
    
    while ( true )
    {
        zombie.movespeedscaler = zombie function_7ad3d25412dd3e11();
        
        if ( zombie.movespeedscaler > 0 )
        {
            zombie common::function_a0f5c85d465c5f0a( "moveSpeedScaler", zombie.movespeedscaler - 1 );
            zombie setmovespeedscale( zombie.movespeedscaler );
        }
        
        waitframe();
    }
}

// Namespace namespace_e1bdb0f108987648
// Params 0
// Checksum 0xc2bb9939, Offset: 0x630
// Size: 0x5e
function function_7ad3d25412dd3e11()
{
    zombie = self;
    
    if ( !isdefined( zombie ) || !zombie game_utility_mp::ismutationgamemodezombie() )
    {
        return;
    }
    
    if ( zombie isswimming() )
    {
        return;
    }
    
    if ( zombie issprintsliding() )
    {
        return level.mutationgametype.var_947af16d87b33e88;
    }
    
    return level.mutationgametype.var_f25225a855293950;
}

// Namespace namespace_e1bdb0f108987648
// Params 1
// Checksum 0xd0a52b1b, Offset: 0x697
// Size: 0x1d
function function_99eb2d5c0bcb928a( time )
{
    if ( isdefined( time ) )
    {
        wait time;
    }
    
    self enableplayerbreathsystem( 1 );
}

// Namespace namespace_e1bdb0f108987648
// Params 2
// Checksum 0xef8712d2, Offset: 0x6bc
// Size: 0x77
function function_307e8b021dbec2b9( powerstruct, powerref )
{
    if ( level.mutationgametype.hudserver )
    {
        self.powershud[ powerref ].barelem hud_util::updatebar( 1, 0 );
    }
    else
    {
        self.powershud[ powerref ].frac = 1;
    }
    
    thread escort_horde_abilities::playerpowerstartcooldown( powerstruct, powerref );
}

// Namespace namespace_e1bdb0f108987648
// Params 2
// Checksum 0x1e8da348, Offset: 0x73b
// Size: 0x21
function function_fc58af0f234f72ec( powerstruct, powerref )
{
    self notify( #"hash_7843353318e75213" );
}

// Namespace namespace_e1bdb0f108987648
// Params 0
// Checksum 0xc234d06f, Offset: 0x764
// Size: 0x131
function function_d0690a30b0732d7()
{
    zombie = self;
    zombie endon( #"zombie_shout_finished" );
    utility::waittill_any_ents( zombie, "death", zombie, "disconnect", level, "game_ended", zombie, "zombie_unset" );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( zombie.shouting )
    {
        stopfxontag( level._effect[ "zombie_shout" ], zombie, "j_head" );
        stopfxontag( level._effect[ "zombie_shout_shockwaves" ], zombie, "tag_origin" );
        
        if ( zombie isgestureplaying( "ges_zombie_shout" ) )
        {
            zombie stopgestureviewmodel( "ges_zombie_shout" );
        }
    }
    
    if ( zombie.buffed )
    {
        zombie setscriptablepartstate( "zombieBuffVfx", "off", 0 );
        zombie setscriptablepartstate( "zombieRageVfx", "off", 0 );
        zombie.movespeedscaler = 1;
        
        if ( zombie common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
        {
            zombie common::function_d85a92c557ea5a52( "moveSpeedScaler" );
        }
        
        zombie setmovespeedscale( zombie.movespeedscaler );
    }
    
    zombie.shouting = 0;
    zombie.buffed = 0;
}

