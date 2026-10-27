// script_130d36f66baea3af  (hash_130d36f66baea3af.gscc) (size: 5921 Bytes / 0x1721 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x23c8272e (600319790)
// size ...... 5921 (0x1721)
// includes .. 3   (offset: 0x1639)
// strings ... 17  (offset: 0x1651)
// dev strs .. 0   (offset: 0x1721)
// exports ... 16  (offset: 0xf95)
// cseg ...... 0x186 + 0xe0f (0xf95)
// imports ... 33  (offset: 0x1215)
// animtree1 . 0   (offset: 0x1721)
// animtree2 . 0   (offset: 0x1721)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gulag;

#namespace namespace_c2403cc64e8875c4;

// Namespace namespace_c2403cc64e8875c4
// Params 0
// Checksum 0x993581f6, Offset: 0x1a4
// Size: 0x257
function init()
{
    level.gulag.var_893a06a0611303bf = getdvarint( @"hash_9f370893a02d7f7e", 1 );
    
    if ( !level.gulag.var_893a06a0611303bf )
    {
        return;
    }
    
    br_gulag::function_c8f7b364fdc4f2d2( "overrideArenas", &function_49e0675f8e5577af );
    br_gulag::function_c8f7b364fdc4f2d2( "getNamedArenaSettings", &getnamedarenasettings );
    br_gulag::function_9d1513fbb2a21c4f( "addArenas", &function_a883ff46201f72b8 );
    br_gulag::function_9d1513fbb2a21c4f( "isArenaEnabled", &function_bc235f0c7a554fef );
    br_gulag::function_9d1513fbb2a21c4f( "beginNewFight", &function_1081e7ea1e203a30 );
    br_gulag::function_9d1513fbb2a21c4f( "handleEndArena", &function_ef3c36526f268067 );
    br_gulag::function_9d1513fbb2a21c4f( "jailEnter", &function_a87af352848fd5cc );
    br_gulag::function_9d1513fbb2a21c4f( "respawnCleanup", &function_5c136a82add717bd );
    var_6cbe2f93d42e1375 = getmatchrulesdata( "brData", "gulagNamedArenaList" );
    
    if ( var_6cbe2f93d42e1375 == "" )
    {
        return;
    }
    
    var_2a9f7f8fb5de4d56 = getscriptbundle( "gulagnamedarenalist:" + var_6cbe2f93d42e1375 );
    
    if ( !isdefined( var_2a9f7f8fb5de4d56 ) )
    {
        script::demoforcesre( "Could not find scriptbundle gulagnamedarenalist:" + var_6cbe2f93d42e1375 );
        return;
    }
    
    level.gulag.var_5282f308a89f13c6 = spawnstruct();
    level.gulag.var_5282f308a89f13c6.chance = getdvarfloat( @"hash_cbb5097fc1a36d1c", var_2a9f7f8fb5de4d56.chance );
    level.gulag.var_5282f308a89f13c6.var_57fe56d04634639a = getdvarint( @"hash_f86bbf62d7600d2e", var_2a9f7f8fb5de4d56.var_57fe56d04634639a );
    level.gulag.var_5282f308a89f13c6.arenas = [];
    level.gulag.var_514ba1e99d367f4 = getdvarint( @"hash_4103c635701b02ab", 0 );
    
    foreach ( index, arenabundle in var_2a9f7f8fb5de4d56.var_fd788c3447c98ce7 )
    {
        function_ea9d0a83fe308428( index, arenabundle );
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 2
// Checksum 0xd1ab7663, Offset: 0x403
// Size: 0x191
function function_ea9d0a83fe308428( index, bundle )
{
    arenasettings = getscriptbundle( "gulagnamedarena:" + bundle.gulagnamedarena );
    prefix = hashcat( @"hash_9f372493a02dbd12", arenasettings.ref, "_" );
    info = spawnstruct();
    info.index = index;
    info.weight = getdvarfloat( hashcat( prefix, "weight" ), bundle.weight );
    info.settings = arenasettings;
    arenastructs = utility::getstructarray( arenasettings.targetname, "targetname" );
    
    foreach ( arenastruct in arenastructs )
    {
        arenastruct.var_ae1e63b3a30cc502 = 1;
        arenastruct.var_1173a399221171ca = index;
        arenastruct.sortvalue = -1;
    }
    
    info.arenastructs = arenastructs;
    level.gulag.var_5282f308a89f13c6.arenas[ index ] = info;
}

// Namespace namespace_c2403cc64e8875c4
// Params 0
// Checksum 0x10bf355b, Offset: 0x59c
// Size: 0xc6
function function_a883ff46201f72b8()
{
    arenas = [];
    
    foreach ( info in level.gulag.var_5282f308a89f13c6.arenas )
    {
        var_893a06a0611303bf = utility::getstructarray( info.settings.targetname, "targetname" );
        arenas = arraycombine( arenas, var_893a06a0611303bf );
    }
    
    return arenas;
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0x82cfd15d, Offset: 0x66b
// Size: 0x42
function getnamedarenasettings( arena )
{
    if ( !function_ae1e63b3a30cc502( arena ) )
    {
        return;
    }
    
    return level.gulag.var_5282f308a89f13c6.arenas[ arena.var_1173a399221171ca ];
}

// Namespace namespace_c2403cc64e8875c4
// Params 0
// Checksum 0x4ea11446, Offset: 0x6b6
// Size: 0x203
function function_49e0675f8e5577af()
{
    waitingarena = function_221845643380fa4( self );
    
    if ( isdefined( waitingarena ) )
    {
        self.var_ca182e67a6607888 = 1;
        return [ [ waitingarena ], 1 ];
    }
    
    if ( randomfloat( 1 ) >= level.gulag.var_5282f308a89f13c6.chance )
    {
        return;
    }
    
    var_3e391771d3a99028 = [];
    var_c1694035b053bb64 = 0;
    
    foreach ( arena in level.gulag.var_5282f308a89f13c6.arenas )
    {
        if ( arena.weight <= 0 )
        {
            continue;
        }
        
        if ( !function_4b1a3b2c9579127b( arena ) )
        {
            continue;
        }
        
        var_c1694035b053bb64 += arena.weight;
        var_3e391771d3a99028[ var_3e391771d3a99028.size ] = arena;
    }
    
    if ( !var_3e391771d3a99028.size )
    {
        return;
    }
    
    randchoice = randomfloat( var_c1694035b053bb64 );
    sum = 0;
    
    foreach ( arenainfo in var_3e391771d3a99028 )
    {
        sum += arenainfo.weight;
        
        if ( randchoice < sum )
        {
            self.var_ca182e67a6607888 = 1;
            return [ arenainfo.arenastructs, 0 ];
        }
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0xc009b926, Offset: 0x8c1
// Size: 0xe3, Type: bool
function function_4b1a3b2c9579127b( arenainfo )
{
    foreach ( arena in level.gulag.arenas )
    {
        if ( !function_ae1e63b3a30cc502( arena ) )
        {
            continue;
        }
        
        if ( arena.var_1173a399221171ca != arenainfo.index )
        {
            continue;
        }
        
        if ( arena.matches.size < level.gulag.var_5282f308a89f13c6.var_57fe56d04634639a )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_c2403cc64e8875c4
// Params 2
// Checksum 0xcb63f138, Offset: 0x9ad
// Size: 0x83, Type: bool
function function_bc235f0c7a554fef( arena, player )
{
    if ( !function_ae1e63b3a30cc502( arena ) )
    {
        return true;
    }
    
    if ( function_ae1e63b3a30cc502( arena ) && !player.var_ca182e67a6607888 )
    {
        return false;
    }
    
    info = level.gulag.var_5282f308a89f13c6.arenas[ arena.var_1173a399221171ca ];
    return info.weight > 0;
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0xc014592a, Offset: 0xa39
// Size: 0x18, Type: bool
function function_ae1e63b3a30cc502( arena )
{
    return istrue( arena.var_ae1e63b3a30cc502 );
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0xbe9d04a5, Offset: 0xa5a
// Size: 0x8a
function function_a87af352848fd5cc( arena )
{
    if ( !function_ae1e63b3a30cc502( arena ) )
    {
        return;
    }
    
    info = level.gulag.var_5282f308a89f13c6.arenas[ arena.var_1173a399221171ca ];
    
    if ( info.settings.var_cf3b00fa54830955 && level.gulag.var_514ba1e99d367f4 )
    {
        self nightvisionviewon();
        thread function_174d6eefb719e350();
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0x5c5441d5, Offset: 0xaec
// Size: 0xfc
function function_1081e7ea1e203a30( arena )
{
    if ( !function_ae1e63b3a30cc502( arena ) )
    {
        return;
    }
    
    info = level.gulag.var_5282f308a89f13c6.arenas[ arena.var_1173a399221171ca ];
    
    foreach ( player in arena.arenaplayers )
    {
        if ( info.settings.var_cf3b00fa54830955 && !level.gulag.var_514ba1e99d367f4 )
        {
            player thread function_c315961f55f8ef81( 1.5 );
        }
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0x20b0ecb3, Offset: 0xbf0
// Size: 0x166
function function_ef3c36526f268067( arena )
{
    foreach ( player in arena.arenaplayers )
    {
        player.var_ca182e67a6607888 = undefined;
    }
    
    if ( !function_ae1e63b3a30cc502( arena ) )
    {
        return;
    }
    
    wait br_gulag::function_933c89106a2241d4() + 1;
    info = level.gulag.var_5282f308a89f13c6.arenas[ arena.var_1173a399221171ca ];
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( info.settings.var_cf3b00fa54830955 )
        {
            player nightvisionviewoff( 1 );
        }
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0xbf646a05, Offset: 0xd5e
// Size: 0x97
function function_5c136a82add717bd( player )
{
    arena = player.arena;
    player.var_ca182e67a6607888 = undefined;
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !function_ae1e63b3a30cc502( arena ) )
    {
        return;
    }
    
    info = level.gulag.var_5282f308a89f13c6.arenas[ arena.var_1173a399221171ca ];
    
    if ( info.settings.var_cf3b00fa54830955 )
    {
        player nightvisionviewoff( 1 );
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0x3fa11ae7, Offset: 0xdfd
// Size: 0x130
function function_221845643380fa4( player )
{
    foreach ( arena in level.gulag.arenas )
    {
        if ( !function_ae1e63b3a30cc502( arena ) )
        {
            continue;
        }
        
        foreach ( match in arena.matches )
        {
            if ( match.size == 1 )
            {
                if ( player.team == match[ 0 ].team )
                {
                    continue;
                }
                
                return arena;
            }
        }
    }
}

// Namespace namespace_c2403cc64e8875c4
// Params 1
// Checksum 0x1442324, Offset: 0xf36
// Size: 0x28
function function_c315961f55f8ef81( delay )
{
    self endon( #"death_or_disconnect" );
    wait delay;
    self nightvisionviewon();
    thread function_174d6eefb719e350();
}

// Namespace namespace_c2403cc64e8875c4
// Params 0
// Checksum 0x1af94266, Offset: 0xf66
// Size: 0x2f
function function_174d6eefb719e350()
{
    self endon( #"death_or_disconnect" );
    wait 2;
    
    if ( self.gulag && !self isnightvisionon() )
    {
        self nightvisionviewon( 1 );
    }
}

