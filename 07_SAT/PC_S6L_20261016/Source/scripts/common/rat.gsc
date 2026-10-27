// scripts\common\rat.gsc  (hash_1a4fc95657361d97.gscc) (size: 5218 Bytes / 0x1462 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfc24c732 (4230268722)
// size ...... 5218 (0x1462)
// includes .. 0   (offset: 0x131e)
// strings ... 24  (offset: 0x131e)
// dev strs .. 0   (offset: 0x1462)
// exports ... 24  (offset: 0xa3a)
// cseg ...... 0x203 + 0x837 (0xa3a)
// imports ... 42  (offset: 0xdfa)
// animtree1 . 0   (offset: 0x1462)
// animtree2 . 0   (offset: 0x1462)
#namespace rat;

// Namespace rat
// Params 0
// Checksum 0x51484b6a, Offset: 0x221
// Size: 0x169
function init()
{
    if ( isdefined( level.var_855c138311a366fb ) )
    {
        return;
    }
    
    level.var_855c138311a366fb = [];
    level.var_ade95642d19836cd = [];
    ratregisterfunction( "RatGetPlayerPosition", &ratgetplayerposition, "vector3" );
    ratregisterfunction( "RatGetPlayerAngles", &ratgetplayerangles, "vector3" );
    ratregisterfunction( "RatGetPlayerIsSwitchingWeapon", &ratgetplayerisswitchingweapon, "bool" );
    ratregisterfunction( "RatGetPlayerIsReloading", &ratgetplayerisreloading, "bool" );
    ratregisterfunction( "RatGetPlayerIsMeleeing", &ratgetplayerismeleeing, "bool" );
    ratregisterfunction( "RatGetPlayerADS", &ratgetplayerads, "float" );
    ratregisterfunction( "RatGetPlayerStance", &ratgetplayerstance, "string" );
    ratregisterfunction( "RatGetPlayerHealth", &ratgetplayerhealth, "int64_t" );
    ratregisterfunction( "RatSetPlayerHealth", &ratsetplayerhealth );
    ratregisterfunction( "RatDoDamage", &ratdodamage, "bool" );
    ratregisterfunction( "RatGetClipAmmoCount", &ratgetclipammocount, "int64_t" );
    ratregisterfunction( "RatGetTotalAmmoCount", &ratgettotalammocount, "int64_t" );
    ratregisterfunction( "RatGetCompleteWeaponName", &ratgetcompleteweaponname, "string" );
    ratregisterfunction( "RatGetPlayerKills", &ratgetplayerkills, "int64_t" );
    ratregisterfunction( "RatGetPlayerDeaths", &ratgetplayerdeaths, "int64_t" );
}

// Namespace rat
// Params 3
// Checksum 0xdd2c0b31, Offset: 0x392
// Size: 0x4c
function ratregisterfunction( function_name, function_ref, return_type )
{
    key = tolower( function_name );
    level.var_855c138311a366fb[ key ] = function_ref;
    level.var_ade95642d19836cd[ key ] = return_type;
}

// Namespace rat
// Params 1
// Checksum 0xbcf19d17, Offset: 0x3e6
// Size: 0x47
function function_5dcc3c9b5e08f7d5( function_name )
{
    init();
    key = tolower( function_name );
    
    if ( isdefined( level.var_ade95642d19836cd[ key ] ) )
    {
        return level.var_ade95642d19836cd[ key ];
    }
    
    return "";
}

// Namespace rat
// Params 1
// Checksum 0x979a8cad, Offset: 0x436
// Size: 0x6b
function function_23d093e60b946bcc( params )
{
    assert( isdefined( params._cmd ) );
    key = tolower( params._cmd );
    assert( isdefined( level.var_855c138311a366fb[ key ] ) );
    func = level.var_855c138311a366fb[ key ];
    return [[ func ]]( params );
}

// Namespace rat
// Params 1
// Checksum 0x3f35625b, Offset: 0x4aa
// Size: 0xd8
function getplayer( params )
{
    if ( isdefined( params.xuid ) )
    {
        xuid = int( params.xuid );
        players = getentarray( "player", #classname );
        
        for ( index = 0; index < players.size ; index++ )
        {
            player = players[ index ];
            
            if ( !isdefined( player.bot ) )
            {
                params.xuid = int( player getxuid() );
                
                if ( xuid == params.xuid )
                {
                    return player;
                }
            }
        }
    }
    
    if ( !isdefined( level.players[ 0 ] ) )
    {
        return level.player;
    }
    
    return level.players[ 0 ];
}

// Namespace rat
// Params 1
// Checksum 0x18a04642, Offset: 0x58b
// Size: 0x39
function ratgetplayerposition( params )
{
    player = getplayer( params );
    return player.origin + ( 0, 0, 60 );
}

// Namespace rat
// Params 1
// Checksum 0x66cb4207, Offset: 0x5cd
// Size: 0x4c
function ratgetplayerangles( params )
{
    player = getplayer( params );
    playerangles = player getplayerangles();
    return ( ( playerangles[ 0 ] + 360 ) % 360, ( playerangles[ 1 ] + 360 ) % 360, playerangles[ 2 ] );
}

// Namespace rat
// Params 1
// Checksum 0x774f8af6, Offset: 0x622
// Size: 0x26
function ratgetplayerisswitchingweapon( params )
{
    player = getplayer( params );
    return player isswitchingweapon();
}

// Namespace rat
// Params 1
// Checksum 0x47436191, Offset: 0x651
// Size: 0x26
function ratgetplayerisreloading( params )
{
    player = getplayer( params );
    return player isreloading();
}

// Namespace rat
// Params 1
// Checksum 0x42de213, Offset: 0x680
// Size: 0x26
function ratgetplayerismeleeing( params )
{
    player = getplayer( params );
    return player ismeleeing();
}

// Namespace rat
// Params 1
// Checksum 0xdd63f1a8, Offset: 0x6af
// Size: 0x26
function ratgetplayerads( params )
{
    player = getplayer( params );
    return player playerads();
}

// Namespace rat
// Params 1
// Checksum 0xbb6eae69, Offset: 0x6de
// Size: 0x26
function ratgetplayerstance( params )
{
    player = getplayer( params );
    return player getstance();
}

// Namespace rat
// Params 1
// Checksum 0xd7312774, Offset: 0x70d
// Size: 0x2b
function ratgetplayerhealth( params )
{
    player = getplayer( params );
    return player.health;
}

// Namespace rat
// Params 1
// Checksum 0x9e939af9, Offset: 0x741
// Size: 0x4e
function ratsetplayerhealth( params )
{
    amount = intvalue( params.amount, 1 );
    player = getplayer( params );
    player.health = amount;
}

// Namespace rat
// Params 1
// Checksum 0x156cb0d1, Offset: 0x797
// Size: 0xcf
function ratdodamage( params )
{
    amount = floatvalue( params.amount, 1 );
    force_damage = boolvalue( params.force_damage, 0 );
    player = getplayer( params );
    
    if ( force_damage )
    {
        var_8a6e95df9229044b = getdvarint( @"scr_force_damage" );
        setdvar( @"scr_force_damage", 1 );
        success = player dodamage( amount, player.origin );
        setdvar( @"scr_force_damage", var_8a6e95df9229044b );
    }
    else
    {
        success = player dodamage( amount, player.origin, player );
    }
    
    return success;
}

// Namespace rat
// Params 1
// Checksum 0x52994378, Offset: 0x86f
// Size: 0x26
function ratgetclipammocount( params )
{
    player = getplayer( params );
    return player getcurrentweaponclipammo();
}

// Namespace rat
// Params 1
// Checksum 0xda8edd01, Offset: 0x89e
// Size: 0x37
function ratgettotalammocount( params )
{
    player = getplayer( params );
    currentweapon = player getcurrentweapon();
    return player getammocount( currentweapon );
}

// Namespace rat
// Params 1
// Checksum 0x2264a367, Offset: 0x8de
// Size: 0x42
function ratgetcompleteweaponname( params )
{
    player = getplayer( params );
    currentweapon = player getcurrentweapon();
    weaponname = getcompleteweaponname( currentweapon );
    return weaponname;
}

// Namespace rat
// Params 1
// Checksum 0x23c34191, Offset: 0x929
// Size: 0x2b
function ratgetplayerkills( params )
{
    player = getplayer( params );
    return player.kills;
}

// Namespace rat
// Params 1
// Checksum 0xd7312774, Offset: 0x95d
// Size: 0x2b
function ratgetplayerdeaths( params )
{
    player = getplayer( params );
    return player.deaths;
}

// Namespace rat
// Params 2
// Checksum 0x6906e131, Offset: 0x991
// Size: 0x25
function intvalue( param, default_val )
{
    if ( !isdefined( param ) )
    {
        return default_val;
    }
    
    return int( param );
}

// Namespace rat
// Params 2
// Checksum 0xd2f8cc65, Offset: 0x9bf
// Size: 0x25
function floatvalue( param, default_val )
{
    if ( !isdefined( param ) )
    {
        return default_val;
    }
    
    return float( param );
}

// Namespace rat
// Params 2
// Checksum 0xa5214abe, Offset: 0x9ed
// Size: 0x4c
function boolvalue( param, default_val )
{
    if ( !isdefined( param ) )
    {
        return default_val;
    }
    
    param_lower = tolower( param );
    
    if ( param_lower == "false" || param_lower == "0" )
    {
        return 0;
    }
    
    return 1;
}

