// scripts\mp\bots\bots_gametype_br.gsc  (hash_7e816fa0720d38a1.gscc) (size: 2022 Bytes / 0x7e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4495a180 (1150656896)
// size ...... 2022 (0x7e6)
// includes .. 7   (offset: 0x772)
// strings ... 5   (offset: 0x7aa)
// dev strs .. 0   (offset: 0x7e6)
// exports ... 7   (offset: 0x432)
// cseg ...... 0xb1 + 0x381 (0x432)
// imports ... 19  (offset: 0x54a)
// animtree1 . 0   (offset: 0x7e6)
// animtree2 . 0   (offset: 0x7e6)
#using script_3d2770dc09c1243;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;

#namespace bots_gametype_br;

// Namespace bots_gametype_br
// Params 0
// Checksum 0x12c42937, Offset: 0xcf
// Size: 0x3a
function main()
{
    if ( mit::function_d154accecda01f06() )
    {
        mit::initialize();
        return;
    }
    
    if ( game_utility::getgametype() == "plunder" && br_public::isdmzbotpracticematch() )
    {
        [[ level.dmz_bot_callback_func ]]();
    }
}

// Namespace bots_gametype_br
// Params 0
// Checksum 0xb9499760, Offset: 0x111
// Size: 0x25
function bot_br_spawn()
{
    self botsetflag( "ignore_script_weapon", 1 );
    self botsetflag( "disable_search_look", 1 );
    self function_fd0539a38d8fa649( 3000 );
}

// Namespace bots_gametype_br
// Params 0
// Checksum 0xaaa57523, Offset: 0x13e
// Size: 0x1da
function function_36d2209bdf00ce8f()
{
    var_b04f0481f7df4c2a = level.br_ac130.origin;
    var_8420562b06b24326 = vectornormalize( level.infilstruct.c130pathstruct.endpt - var_b04f0481f7df4c2a );
    var_b143c3687c779ed0 = ( level.br_level.br_mapbounds[ 0 ][ 0 ] - var_b04f0481f7df4c2a[ 0 ] ) / var_8420562b06b24326[ 0 ];
    var_b11fd9687c4f547a = ( level.br_level.br_mapbounds[ 1 ][ 0 ] - var_b04f0481f7df4c2a[ 0 ] ) / var_8420562b06b24326[ 0 ];
    var_3a1c2d7b783e89c5 = ( level.br_level.br_mapbounds[ 0 ][ 1 ] - var_b04f0481f7df4c2a[ 1 ] ) / var_8420562b06b24326[ 1 ];
    var_3a3f377b7864e77b = ( level.br_level.br_mapbounds[ 1 ][ 1 ] - var_b04f0481f7df4c2a[ 1 ] ) / var_8420562b06b24326[ 1 ];
    boundsdistances = [ var_b11fd9687c4f547a, var_b143c3687c779ed0, var_3a3f377b7864e77b, var_3a1c2d7b783e89c5 ];
    var_c102f45ebbe308cf = -1;
    
    foreach ( var_27bc7a8967cdaf98 in boundsdistances )
    {
        if ( var_27bc7a8967cdaf98 > 0 )
        {
            if ( var_c102f45ebbe308cf < 0 || var_27bc7a8967cdaf98 < var_c102f45ebbe308cf )
            {
                var_c102f45ebbe308cf = var_27bc7a8967cdaf98;
            }
        }
    }
    
    c130speed = br_c130::getc130speed();
    var_bc152547c76d56df = var_c102f45ebbe308cf / c130speed;
    return randomfloatrange( 0.1, 0.9 ) * var_bc152547c76d56df;
}

// Namespace bots_gametype_br
// Params 2
// Checksum 0xaad77b5c, Offset: 0x321
// Size: 0x39
function bot_get_angles_to_goal( bot, goal_origin )
{
    direction_to_goal = vectornormalize( goal_origin - bot.origin );
    return vectortoangles( direction_to_goal );
}

// Namespace bots_gametype_br
// Params 0
// Checksum 0xc798c540, Offset: 0x363
// Size: 0x8d, Type: bool
function bot_is_in_gas()
{
    if ( !flags::gameflag( "graceperiod_done" ) )
    {
        return false;
    }
    
    circleorigin = br_circle::getdangercircleorigin();
    circleradius = br_circle::getdangercircleradius();
    
    if ( level.circleclosing )
    {
        circleorigin = br_circle::getsafecircleorigin();
        circleradius = br_circle::getsafecircleradius();
    }
    
    if ( br_public::isplayerinorgoingtogulag() )
    {
        return false;
    }
    
    if ( !isalive( self ) || self.sessionstate != "playing" )
    {
        return false;
    }
    
    return !utility::ispointinsidecircle( self.origin, circleorigin, circleradius );
}

// Namespace bots_gametype_br
// Params 1
// Checksum 0x4f858d76, Offset: 0x3f9
// Size: 0x38, Type: bool
function ispointincurrentcircle( point )
{
    circleorigin = br_circle::getdangercircleorigin();
    circleradius = br_circle::getdangercircleradius();
    return utility::ispointinsidecircle( point, circleorigin, circleradius );
}

