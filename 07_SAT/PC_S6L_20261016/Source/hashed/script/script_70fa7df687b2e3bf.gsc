// script_70fa7df687b2e3bf  (hash_70fa7df687b2e3bf.gscc) (size: 5160 Bytes / 0x1428 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1230121 (3777167649)
// size ...... 5160 (0x1428)
// includes .. 9   (offset: 0x1370)
// strings ... 9   (offset: 0x13b8)
// dev strs .. 0   (offset: 0x1428)
// exports ... 16  (offset: 0xc34)
// cseg ...... 0xee + 0xb46 (0xc34)
// imports ... 40  (offset: 0xeb4)
// animtree1 . 0   (offset: 0x1428)
// animtree2 . 0   (offset: 0x1428)
#using script_16ea1b94f0f381b3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\common\utility\damage;
#using scripts\mp\gamescore;

#namespace namespace_3047dff6a502386b;

// Namespace namespace_3047dff6a502386b
// Params 4
// Checksum 0xdfb74684, Offset: 0x10c
// Size: 0x62
function function_84fa91f471681f87( zombietype, origin, angles = ( 0, randomint( 360 ), 0 ), team = "axis" )
{
    aitype = function_b3988325430ce242( zombietype );
    return namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, origin, angles, team );
}

// Namespace namespace_3047dff6a502386b
// Params 1
// Checksum 0x9d85e27c, Offset: 0x177
// Size: 0x15d
function function_b6f41600d513811d( settings )
{
    if ( !settings )
    {
        return;
    }
    
    if ( settings.var_583144a97cdaecf6 )
    {
        thread utility::animscriptedagent( "spawn", "spawn_end", undefined, ( 0, 0, 0 ), "spawn_animating" );
    }
    
    if ( settings.maxhealth )
    {
        ai::set_ai_max_health( settings.maxhealth );
    }
    
    if ( isdefined( settings.goalradius ) )
    {
        self.goalradius = settings.goalradius;
    }
    
    if ( isdefined( settings.stealthenabled ) )
    {
        self.stealth_enabled = settings.stealthenabled;
    }
    
    if ( isdefined( settings.pathenemyfightdist ) )
    {
        self.pathenemyfightdist = settings.pathenemyfightdist;
    }
    
    if ( isdefined( settings.movespeed ) )
    {
        zombie_utils::function_a8ce00e0448cb6f0( settings.movespeed, settings.movespeedid ?? "horde_spawn", settings.movespeedpriority ?? 1 );
    }
    
    if ( isdefined( settings.awarenessradius ) )
    {
        self function_fa32376aaa88a7a2( self.origin, settings.awarenessradius );
    }
    
    if ( settings.specialproperties )
    {
        self.specialproperties = settings.specialproperties;
    }
}

// Namespace namespace_3047dff6a502386b
// Params 2
// Checksum 0x774610ad, Offset: 0x2dc
// Size: 0x25
function function_d459dbb12782be2d( team, optional_owner )
{
    self [[ level.setagentteam ]]( team, optional_owner );
}

// Namespace namespace_3047dff6a502386b
// Params 3
// Checksum 0x5e029288, Offset: 0x309
// Size: 0x164
function function_1a39d018d539d9a4( player, mindist = 300, var_61101f38c7a85085 = 0 )
{
    if ( !player )
    {
        return;
    }
    
    var_68e48d95a0187354 = mindist * mindist;
    x = 2 * mindist * pow( -1, randomint( 2 ) );
    y = 2 * mindist * pow( -1, randomint( 2 ) );
    
    if ( var_61101f38c7a85085 )
    {
        safeorigin = getclosestpointonnavmesh( player.origin + ( x, y, 0 ) );
    }
    else
    {
        safeorigin = getrandomnavpoint( player.origin + ( x, y, 0 ), mindist );
    }
    
    if ( safeorigin )
    {
        isInWater = utility::ispointinwater( safeorigin );
        
        if ( isInWater )
        {
            return;
        }
        
        foreach ( p in level.players )
        {
            if ( distance2dsquared( safeorigin, p.origin ) < var_68e48d95a0187354 )
            {
                return;
            }
        }
    }
    
    return safeorigin;
}

// Namespace namespace_3047dff6a502386b
// Params 4
// Checksum 0xf2d957a, Offset: 0x476
// Size: 0xbe
function function_352e5eb80d317f9e( count, zombietype, team, spawnsettings )
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < count ; i++ )
    {
        origin = undefined;
        
        while ( !origin )
        {
            player = utility::array_random( level.players );
            origin = function_1a39d018d539d9a4( player );
            
            if ( !origin )
            {
                waitframe();
            }
        }
        
        ai = function_84fa91f471681f87( zombietype, origin, ( 0, randomint( 360 ), 0 ), team );
        
        if ( isagent( ai ) )
        {
            ai function_b6f41600d513811d( spawnsettings );
        }
        
        waitframe();
    }
}

// Namespace namespace_3047dff6a502386b
// Params 5
// Checksum 0xef37b231, Offset: 0x53c
// Size: 0x87
function function_6d5b2d2dd94015f6( zombietype, targetcount, team, spawnsettings, tickdelay )
{
    level endon( #"game_ended" );
    level endon( "stop_zombie_spawns_" + zombietype );
    
    if ( !isdefined( tickdelay ) )
    {
        tickdelay = 10;
    }
    
    while ( true )
    {
        deficit = targetcount - agent_utility::getnumactiveagents( zombietype );
        
        if ( deficit > 0 )
        {
            level thread function_352e5eb80d317f9e( deficit, zombietype, team, spawnsettings );
        }
        
        wait tickdelay;
    }
}

// Namespace namespace_3047dff6a502386b
// Params 1
// Checksum 0xc57e8396, Offset: 0x5cb
// Size: 0xf6
function function_95f8261172e0fceb( zombietypes )
{
    if ( !zombietypes )
    {
        return;
    }
    
    foreach ( zombietype in zombietypes )
    {
        foreach ( zombie in agent_utility::getactiveagentsoftype( zombietype ) )
        {
            if ( zombie )
            {
                zombie kill();
                waitframe();
            }
        }
    }
}

// Namespace namespace_3047dff6a502386b
// Params 1
// Checksum 0xfc29d5cd, Offset: 0x6c9
// Size: 0x2c
function function_96e8ad309c3d5340( handler )
{
    if ( !handler )
    {
        return;
    }
    
    callback::get_template( "zombie" ) callback::add( "on_zombie_ai_damaged", handler );
}

// Namespace namespace_3047dff6a502386b
// Params 0
// Checksum 0x3fc44892, Offset: 0x6fd
// Size: 0x2a
function function_6c0fdc0c23f23397()
{
    if ( getdvarint( @"hash_30ebbc7a38567d8c", 1 ) )
    {
        level callback::add( #"player_death", &function_82701a6018294dbb );
    }
}

// Namespace namespace_3047dff6a502386b
// Params 1
// Checksum 0xbda67a79, Offset: 0x72f
// Size: 0x19b
function function_82701a6018294dbb( deathdata )
{
    victim = self;
    attacker = deathdata.attacker;
    
    if ( !isplayer( victim ) || !isagent( attacker ) || isplayer( attacker ) )
    {
        return;
    }
    
    if ( level.assists_disabled || !victim.attackers )
    {
        return;
    }
    
    foreach ( player in victim.attackers )
    {
        if ( !damage::_validateattacker( player ) )
        {
            continue;
        }
        
        if ( isagent( player ) || player == victim )
        {
            continue;
        }
        
        attackerdata = victim.attackerdata[ player.guid ];
        
        if ( !attackerdata )
        {
            continue;
        }
        
        assistweapon = attackerdata.objweapon;
        bonusmagnitude = 0;
        
        if ( attackerdata.damage )
        {
            if ( attackerdata.damage >= 70 )
            {
                bonusmagnitude = 2;
            }
            else if ( attackerdata.damage >= 35 )
            {
                bonusmagnitude = 1;
            }
        }
        
        player thread gamescore::processassist( victim, assistweapon, bonusmagnitude, attackerdata.damage );
    }
}

// Namespace namespace_3047dff6a502386b
// Params 2
// Checksum 0x9255571f, Offset: 0x8d2
// Size: 0x112
function function_c48ec991a151d7ca( friendlyteam, zombieteam )
{
    foreach ( player in level.players )
    {
        function_281fbcb10cdce0df( player, friendlyteam );
    }
    
    zombies = getzombies( zombieteam );
    
    foreach ( zombie in zombies )
    {
        function_44808593c36bbd6a( zombie, friendlyteam );
    }
}

// Namespace namespace_3047dff6a502386b
// Params 1
// Checksum 0x8943a9d, Offset: 0x9ec
// Size: 0xa2
function getzombies( zombieteam )
{
    zombies = getaiarray( zombieteam );
    var_4c6516944983d5d8 = [];
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) )
        {
            var_4c6516944983d5d8[ var_4c6516944983d5d8.size ] = zombie;
        }
    }
    
    return var_4c6516944983d5d8;
}

// Namespace namespace_3047dff6a502386b
// Params 2
// Checksum 0x64948e86, Offset: 0xa97
// Size: 0x4f
function function_281fbcb10cdce0df( player, friendlyteam )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.team == friendlyteam )
    {
        player setclientomnvar( "gp_zombies_are_my_friends", 1 );
        return;
    }
    
    player setclientomnvar( "gp_zombies_are_my_friends", 0 );
}

// Namespace namespace_3047dff6a502386b
// Params 2
// Checksum 0xf7bcc038, Offset: 0xaee
// Size: 0x28
function function_896d0f86ab8af668( zombieagent, friendlyteam )
{
    function_44808593c36bbd6a( zombieagent, friendlyteam, #"active_subtle" );
}

// Namespace namespace_3047dff6a502386b
// Params 3
// Checksum 0xf590eae, Offset: 0xb1e
// Size: 0x116
function function_44808593c36bbd6a( zombieagent, friendlyteam, var_1c3a3c252a85f00c )
{
    if ( !zombieagent || !isagent( zombieagent ) || !zombieagent isscriptable() || !zombieagent getscriptablehaspart( #"zombie_friend_team" ) )
    {
        return;
    }
    
    zombieagent utility::function_7c10ea82c1e305b8( #"hash_7e6ad33e450cbe30", #"off" );
    zombieagent utility::function_7c10ea82c1e305b8( #"zombie_friend_team", #"off" );
    waitframe();
    
    if ( !zombieagent || !isagent( zombieagent ) || !zombieagent isscriptable() || !zombieagent getscriptablehaspart( #"zombie_friend_team" ) )
    {
        return;
    }
    
    if ( !isdefined( friendlyteam ) )
    {
        friendlyteam = zombieagent.team;
    }
    
    zombieagent utility::function_7c10ea82c1e305b8( #"hash_7e6ad33e450cbe30", var_1c3a3c252a85f00c ?? #"active" );
    zombieagent function_474bcbb86b733bef( #"hash_7e6ad33e450cbe30", friendlyteam );
    zombieagent utility::function_7c10ea82c1e305b8( #"zombie_friend_team", #"friend_selector" );
}

