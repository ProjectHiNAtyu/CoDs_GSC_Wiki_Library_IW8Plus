// scripts\mp\common\utility\team_utility.gsc  (hash_596b87215f1ff115.gscc) (size: 1090 Bytes / 0x442 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff8a97ad (4287272877)
// size ...... 1090 (0x442)
// includes .. 1   (offset: 0x43a)
// strings ... 0   (offset: 0x442)
// dev strs .. 0   (offset: 0x442)
// exports ... 6   (offset: 0x266)
// cseg ...... 0x58 + 0x20e (0x266)
// imports ... 7   (offset: 0x356)
// animtree1 . 0   (offset: 0x442)
// animtree2 . 0   (offset: 0x442)
#using scripts\mp\gameinstance;

#namespace team_utility;

// Namespace team_utility
// Params 2
// Checksum 0x9aab5236, Offset: 0x76
// Size: 0x4d
function getfriendlyplayers( testteam, aliveonly )
{
    func = level.sharedfuncs[ #"team_utility" ][ #"getfriendlyplayers" ];
    
    if ( !isdefined( func ) )
    {
        return [];
    }
    
    return [[ func ]]( testteam, aliveonly );
}

// Namespace team_utility
// Params 2
// Checksum 0x86108fa8, Offset: 0xcc
// Size: 0x4d
function getenemyplayers( testteam, aliveonly )
{
    func = level.sharedfuncs[ #"team_utility" ][ #"getenemyplayers" ];
    
    if ( !isdefined( func ) )
    {
        return [];
    }
    
    return [[ func ]]( testteam, aliveonly );
}

// Namespace team_utility
// Params 1
// Checksum 0x30682ae6, Offset: 0x122
// Size: 0x22, Type: bool
function isgameplayteam( team )
{
    return isdefined( team ) && arraycontains( level.teamnamelist, team );
}

// Namespace team_utility
// Params 2
// Checksum 0x8fdf0d58, Offset: 0x14d
// Size: 0xbc
function getenemyteams( testteam, includeagents )
{
    if ( ( level.multimatch ?? gameinstance::is_enabled() ) && isgameplayteam( testteam ) )
    {
        instanceid = gameinstance::get_instance_id( testteam );
        
        if ( !isdefined( instanceid ) )
        {
            return;
        }
        
        return arrayremove( gameinstance::get_instance_teams( instanceid ), testteam );
    }
    
    if ( includeagents && isdefined( level.var_bb767a3f16846f6a ) && isgameplayteam( testteam ) )
    {
        return arrayremove( level.var_bb767a3f16846f6a, testteam );
    }
    
    if ( isdefined( level.teamnamelist ) && isgameplayteam( testteam ) )
    {
        return arrayremove( level.teamnamelist, testteam );
    }
}

// Namespace team_utility
// Params 1
// Checksum 0x7c5d93ff, Offset: 0x212
// Size: 0x54
function getotherteam( testteam )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        instanceid = gameinstance::get_instance_id( testteam );
        return arrayremove( gameinstance::get_instance_teams( instanceid ), testteam )[ 0 ];
    }
    
    return getenemyteams( testteam )[ 0 ];
}

