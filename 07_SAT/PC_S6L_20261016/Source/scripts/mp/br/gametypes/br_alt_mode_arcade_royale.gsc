// scripts\mp\br\gametypes\br_alt_mode_arcade_royale.gsc  (hash_173d25f292ceb81b.gscc) (size: 5172 Bytes / 0x1434 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c830d5b (478350683)
// size ...... 5172 (0x1434)
// includes .. 10  (offset: 0x1308)
// strings ... 15  (offset: 0x1358)
// dev strs .. 1   (offset: 0x1428)
// exports ... 21  (offset: 0xa18)
// cseg ...... 0x1af + 0x869 (0xa18)
// imports ... 48  (offset: 0xd60)
// animtree1 . 0   (offset: 0x1434)
// animtree2 . 0   (offset: 0x1434)
#using script_26ccbfe3954cacf4;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\playerlogic;

#namespace br_alt_mode_arcade_royale;

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0x9d1219a4, Offset: 0x1cd
// Size: 0x10
function function_1fd0c1b4145222f1()
{
    return getdvarint( @"scr_br_alt_mode_arcade_royale", 0 );
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0xb9565e6f, Offset: 0x1e6
// Size: 0xc9
function init()
{
    if ( !function_1fd0c1b4145222f1() )
    {
        return;
    }
    
    utility::registersharedfunc( #"gametype", #"getdefaultloadout", &getdefaultloadout );
    utility::registersharedfunc( #"gametype", #"hash_c16e26abbcb3752f", &function_22cb162d3517d39d );
    utility::registersharedfunc( #"gametype", #"mayconsiderplayerdead", &mayconsiderplayerdead );
    utility::registersharedfunc( #"gametype", #"isteameliminated", &isteameliminated );
    utility::registersharedfunc( #"gametype", #"killcamallowed", &killcamallowed );
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &onplayerkilled );
    level thread initpostmain();
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0x5ee43f16, Offset: 0x2b7
// Size: 0x19
function initpostmain()
{
    waitframe();
    level.brgametype.respawnenable = 1;
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0x77b65797, Offset: 0x2d8
// Size: 0x17
function getdefaultloadout()
{
    respawnloadout = br_spawnrespawn::function_a4305f2e039b471e();
    return respawnloadout[ 0 ];
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0x61e1e79c, Offset: 0x2f8
// Size: 0x6a
function function_6973e22363642362()
{
    noextraammo = 0;
    
    if ( isdefined( level.respawnloadout ) )
    {
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            if ( level.br_circle.circleindex == level.respawnloadout.size - 1 )
            {
                noextraammo = 1;
            }
        }
    }
    
    return noextraammo;
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0xfe402246, Offset: 0x36b
// Size: 0x9
function function_22cb162d3517d39d()
{
    return manager::SurvivalCurveMayConsiderBotDead( self );
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x727d3f2b, Offset: 0x37d
// Size: 0xbc
function isteameliminated( team )
{
    result = 1;
    
    if ( manager::isenabled() )
    {
        result = manager::isteameliminated( team );
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( isalive( player ) || player br_public::hasrespawntoken() )
        {
            result = 0;
            break;
        }
    }
    
    return result;
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0xbba79b18, Offset: 0x442
// Size: 0x64, Type: bool
function mayconsiderplayerdead( player )
{
    if ( flags::gameflag( "prematch_done" ) && flags::gameflag( "prematch_fade_done" ) )
    {
        if ( isbot( player ) && function_a18f970a934462b7() )
        {
            player item_redeploy_token::function_16ab0a48337237ef();
        }
        
        if ( player br_public::hasrespawntoken() )
        {
            player thread waitrespawn();
            br_utility::markplayeraseliminated( player );
        }
    }
    
    return true;
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0x22c8c5c3, Offset: 0x4af
// Size: 0x19a
function waitrespawn()
{
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player showrespawntimer();
    player.respawndelay = getrespawndelay();
    function_49c11ecb1e26d264( player.respawndelay );
    
    while ( player.respawndelay > 0 )
    {
        if ( isalive( player ) )
        {
            player.respawndelay = 0;
        }
        else
        {
            function_49c11ecb1e26d264( player.respawndelay );
        }
        
        player br_public::updatebrscoreboardstat( "respawnInSeconds", player.respawndelay );
        
        if ( player.respawndelay <= 5 )
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer_quarter_sec", player );
        }
        else if ( player.respawndelay <= 10 )
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer_half_sec", player );
        }
        else if ( player.respawndelay % 4 == 2 )
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer", player );
        }
        else
        {
            player playsoundtoplayer( "ui_mp_resurgence_timer_tick", player );
        }
        
        wait 1;
        player.respawndelay--;
    }
    
    player hiderespawntimer();
    player function_49c11ecb1e26d264( 0 );
    player br_public::updatebrscoreboardstat( "respawnInSeconds", 0 );
    
    if ( !isalive( player ) )
    {
        player thread doingrespawn( level.teamdata[ player.team ][ "alivePlayers" ] );
    }
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0xfa45748b, Offset: 0x651
// Size: 0x2f
function getrespawndelay()
{
    if ( !function_a18f970a934462b7() )
    {
        return getdvarint( @"scr_arcade_royale_respawn_delay", 8 );
    }
    
    return getdvarint( @"hash_38eaace6346da179", 2 );
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0xfe3eba73, Offset: 0x688
// Size: 0x36
function hiderespawntimer()
{
    currentvalue = self getclientomnvar( "ui_resurgenceRespawnTimer" );
    newvalue = currentvalue & ~16384;
    self setclientomnvar( "ui_resurgenceRespawnTimer", newvalue );
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0x605a5cc9, Offset: 0x6c6
// Size: 0x35
function showrespawntimer()
{
    currentvalue = self getclientomnvar( "ui_resurgenceRespawnTimer" );
    newvalue = currentvalue | 16384;
    self setclientomnvar( "ui_resurgenceRespawnTimer", newvalue );
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x1edecf7f, Offset: 0x703
// Size: 0x5c
function function_49c11ecb1e26d264( value )
{
    assert( value <= 16383 );
    currentvalue = self getclientomnvar( "ui_resurgenceRespawnTimer" );
    otherbits = currentvalue & ~16383;
    newvalue = otherbits | value;
    self setclientomnvar( "ui_resurgenceRespawnTimer", newvalue );
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x1a4027ab, Offset: 0x767
// Size: 0xbb
function doingrespawn( aliveteammates )
{
    assert( isdefined( self ), "<dev string:x24>" );
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"doingrespawn" );
    
    if ( player.respawningfromtoken )
    {
        return 0;
    }
    
    player.respawningfromtoken = 1;
    player item_redeploy_token::function_16ab0a48337237ef();
    player playerlogic::addtoalivecount( "arcade_royale" );
    br_utility::unmarkplayeraseliminated( player );
    respawnstruct = function_62dff2abe80e7f15( aliveteammates );
    player.var_1be091ba55db848e = "arcade_royale";
    player br_spawnrespawn::br_doingrespawn( undefined, respawnstruct );
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x8896abc0, Offset: 0x82a
// Size: 0x51
function function_62dff2abe80e7f15( aliveteammates )
{
    rs = br_spawnrespawn::function_1ecfc7c6647ddf97( &respawncleanup, "br_ac130_flyby", undefined );
    rs br_spawnrespawn::function_ecc6ed28c3fae86b( &prerespawn );
    rs.optparams.aliveteammates = aliveteammates;
    return rs;
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x110a29d5, Offset: 0x884
// Size: 0x14, Type: bool
function prerespawn( optparams )
{
    hiderespawntimer();
    return false;
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0xb8a00b58, Offset: 0x8a1
// Size: 0x49
function respawncleanup( optparams )
{
    self notify( #"resurgenceRespawn" );
    self.health = self.maxhealth;
    val::set( "resurgenceRespawn", "player_for_spawn_logic", 0 );
    br_public::updatebrscoreboardstat( "isRespawning", 0 );
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x2c8b086b, Offset: 0x8f2
// Size: 0x40
function killcamallowed( deathdata )
{
    if ( !getdvarint( @"hash_e07243410e9b2958", 1 ) && function_a18f970a934462b7() && deathdata.victim br_public::hasrespawntoken() )
    {
        return 0;
    }
}

// Namespace br_alt_mode_arcade_royale
// Params 0
// Checksum 0xdfc115bc, Offset: 0x93b
// Size: 0x41, Type: bool
function function_a18f970a934462b7()
{
    return level.br_circle.circleindex >= level.br_level.br_circlecenters.size - level.br_level.br_movingcirclecount - 1;
}

// Namespace br_alt_mode_arcade_royale
// Params 1
// Checksum 0x88c00ef5, Offset: 0x985
// Size: 0x93
function onplayerkilled( deathdata )
{
    if ( !level.br_prematchstarted )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( !isplayer( victim ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        attacker = victim;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    circleindex = level.br_circle.circleindex ?? 0;
}

