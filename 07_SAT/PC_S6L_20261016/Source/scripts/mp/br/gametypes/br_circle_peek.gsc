// scripts\mp\br\gametypes\br_circle_peek.gsc  (hash_515da5efd18c91fc.gscc) (size: 4290 Bytes / 0x10c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x836be3b8 (2204885944)
// size ...... 4290 (0x10c2)
// includes .. 8   (offset: 0x1032)
// strings ... 5   (offset: 0x1072)
// dev strs .. 1   (offset: 0x10b6)
// exports ... 9   (offset: 0xc32)
// cseg ...... 0xb5 + 0xb7d (0xc32)
// imports ... 21  (offset: 0xd9a)
// animtree1 . 0   (offset: 0x10c2)
// animtree2 . 0   (offset: 0x10c2)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\teams;

#namespace br_circle_peek;

// Namespace br_circle_peek
// Params 0
// Checksum 0x2aee86c5, Offset: 0xd3
// Size: 0xc1
function setupcirclepeek()
{
    if ( level.br_circle_disabled || level.br_level.staticcircle || br_gametypes::isfeatureenabled( #"hash_7bf340059947e149" ) )
    {
        return;
    }
    
    assert( !isdefined( level.circlepeeks ), "<dev string:x24>" );
    utility::flag_wait( "calc_circle_centers" );
    level.circlepeeks = [];
    level.teamswithcirclepeek = [];
    
    for ( index = 1; index < level.br_level.br_circleradii.size ; index++ )
    {
        function_3da53a564d3c8970( index );
    }
    
    level thread function_81b29b996d8abffc();
    callback::add( "circle_relocation", &function_e47977cbd4f706d8 );
}

// Namespace br_circle_peek
// Params 1
// Checksum 0xbf280999, Offset: 0x19c
// Size: 0xf2
function function_e47977cbd4f706d8( params )
{
    if ( isdefined( level.circlepeeks ) )
    {
        multicirclecount = br_circle_util::function_7c3401c47d505872();
        circleinfo = level.br_multi_circle;
        nextcircleindex = level.br_circle.circleindex + 2;
        
        for ( i = nextcircleindex; i < level.br_level.br_circleradii.size ; i++ )
        {
            for ( j = 0; j < multicirclecount ; j++ )
            {
                circleorigin = circleinfo.circles[ j ].circlecenters[ i ];
                questcircle = level.circlepeeks[ i ].questcircles[ j ];
                questcircle game_utility::questcircle_move( circleorigin );
            }
        }
    }
}

// Namespace br_circle_peek
// Params 0
// Checksum 0x58a454ed, Offset: 0x296
// Size: 0xf5
function function_d777610f99715c3()
{
    foreach ( circlepeek in level.circlepeeks )
    {
        foreach ( questcircle in circlepeek.questcircles )
        {
            questcircle game_utility::questcircle_delete();
        }
    }
    
    level.circlepeeks = undefined;
}

// Namespace br_circle_peek
// Params 1
// Checksum 0x9f2e9c00, Offset: 0x393
// Size: 0x135
function function_3da53a564d3c8970( circleindex )
{
    if ( !isdefined( level.circlepeeks ) )
    {
        return;
    }
    
    level.circlepeeks[ circleindex ] = spawnstruct();
    level.circlepeeks[ circleindex ].questcircles = [];
    circleradius = level.br_level.br_circleradii[ circleindex ];
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    if ( multicirclecount > 1 )
    {
        circleinfo = level.br_multi_circle;
        
        if ( circleindex < level.br_multi_circle.splitindex || circleindex >= level.br_multi_circle.mergeindex )
        {
            multicirclecount = 1;
        }
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            circleorigin = circleinfo.circles[ i ].circlecenters[ circleindex ];
            function_a8463ea3c0956a62( circleindex, circleorigin, circleradius );
        }
        
        return;
    }
    
    circleorigin = level.br_level.br_circlecenters[ circleindex ];
    function_a8463ea3c0956a62( circleindex, circleorigin, circleradius );
}

// Namespace br_circle_peek
// Params 3
// Checksum 0x98a1f0f8, Offset: 0x4d0
// Size: 0x95
function function_a8463ea3c0956a62( circleindex, circleorigin, circleradius )
{
    if ( !isdefined( level.circlepeeks[ circleindex ] ) )
    {
        return;
    }
    
    questcircle = spawnstruct();
    questcircle game_utility::questcircle_create( "PeekCircle_Br", circleorigin, circleradius );
    questcircle game_utility::questcircle_hidefromall();
    size = level.circlepeeks[ circleindex ].questcircles.size;
    level.circlepeeks[ circleindex ].questcircles[ size ] = questcircle;
}

// Namespace br_circle_peek
// Params 0
// Checksum 0x784cfff5, Offset: 0x56d
// Size: 0x167
function function_81b29b996d8abffc()
{
    self endon( #"game_ended" );
    level endon( #"hash_161c3d8f1cc2d1ea" );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        
        foreach ( questcircle in level.circlepeeks[ level.br_circle.circleindex + 1 ].questcircles )
        {
            questcircle game_utility::questcircle_delete();
        }
        
        foreach ( team in getarraykeys( level.teamswithcirclepeek ) )
        {
            level.teamswithcirclepeek[ team ]--;
            
            if ( level.teamswithcirclepeek[ team ] < 0 )
            {
                level.teamswithcirclepeek[ team ] = 0;
            }
        }
    }
}

// Namespace br_circle_peek
// Params 1
// Checksum 0x6f22223c, Offset: 0x6dc
// Size: 0x385
function function_6de0d379275546d1( team )
{
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ team ] ) )
    {
        level.teamswithcirclepeek[ team ] = 0;
    }
    
    var_4f6edf53136eb3db = -1;
    
    if ( level.teamswithcirclepeek[ team ] == 0 )
    {
        buffertime = getdvarint( @"hash_a8b73338df20273", 15 );
        
        if ( buffertime >= br_circle::function_f30ad5eda1a16d44() )
        {
            level.teamswithcirclepeek[ team ]++;
            var_4f6edf53136eb3db = level.teamswithcirclepeek[ team ] + level.br_circle.circleindex + 1;
        }
    }
    
    level.teamswithcirclepeek[ team ]++;
    index = level.teamswithcirclepeek[ team ] + level.br_circle.circleindex + 1;
    
    if ( !isdefined( level.circlepeeks[ index ] ) )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( var_4f6edf53136eb3db != -1 && isdefined( level.circlepeeks[ var_4f6edf53136eb3db ] ) )
            {
                foreach ( questcircle in level.circlepeeks[ var_4f6edf53136eb3db ].questcircles )
                {
                    questcircle game_utility::questcircle_showtoplayer( player );
                }
            }
            
            player lower_message::setlowermessageomnvar( "circle_peek_limit", undefined, 5 );
        }
        
        return;
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        foreach ( questcircle in level.circlepeeks[ index ].questcircles )
        {
            questcircle game_utility::questcircle_showtoplayer( player );
        }
        
        if ( var_4f6edf53136eb3db != -1 )
        {
            foreach ( questcircle in level.circlepeeks[ var_4f6edf53136eb3db ].questcircles )
            {
                questcircle game_utility::questcircle_showtoplayer( player );
            }
        }
    }
}

// Namespace br_circle_peek
// Params 2
// Checksum 0xebf43a1d, Offset: 0xa69
// Size: 0x1c9
function function_a70e58c72b536c47( oldteam, newteam )
{
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ oldteam ] ) )
    {
        level.teamswithcirclepeek[ oldteam ] = 0;
    }
    
    if ( !isdefined( level.teamswithcirclepeek[ newteam ] ) )
    {
        level.teamswithcirclepeek[ newteam ] = 0;
    }
    
    if ( level.teamswithcirclepeek[ oldteam ] > level.teamswithcirclepeek[ newteam ] )
    {
        level.teamswithcirclepeek[ newteam ] = level.teamswithcirclepeek[ oldteam ];
    }
    
    index = level.teamswithcirclepeek[ newteam ] + level.br_circle.circleindex + 1;
    
    if ( !isdefined( level.circlepeeks[ index ] ) )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( newteam, "players" ) )
    {
        foreach ( questcircle in level.circlepeeks[ index ].questcircles )
        {
            questcircle game_utility::questcircle_showtoplayer( player );
        }
    }
}

