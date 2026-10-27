// scripts\mp\serversettings.gsc  (hash_12971cebdd7fff70.gscc) (size: 1509 Bytes / 0x5e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd72fc7f3 (3610232819)
// size ...... 1509 (0x5e5)
// includes .. 1   (offset: 0x53d)
// strings ... 11  (offset: 0x545)
// dev strs .. 0   (offset: 0x5e5)
// exports ... 5   (offset: 0x359)
// cseg ...... 0xc0 + 0x299 (0x359)
// imports ... 9   (offset: 0x421)
// animtree1 . 0   (offset: 0x5e5)
// animtree2 . 0   (offset: 0x5e5)
#using scripts\mp\common\utility\game_utility;

#namespace serversettings;

// Namespace serversettings
// Params 0
// Checksum 0x8c6fcfe9, Offset: 0xde
// Size: 0x4a
function init()
{
    level.hostname = getserverhostname();
    setfriendlyfire( getmatchrulesdata( "commonOption", "friendlyFire" ) );
    constraingametype( game_utility::getgametype() );
    level endon( #"hash_6edeef7a54182f2" );
    
    for ( ;; )
    {
        updateserversettings();
        wait 5;
    }
}

// Namespace serversettings
// Params 0
// Checksum 0x3ed9215d, Offset: 0x130
// Size: 0x34
function updateserversettings()
{
    scr_friendlyfire = getmatchrulesdata( "commonOption", "friendlyFire" );
    
    if ( level.friendlyfire != scr_friendlyfire )
    {
        setfriendlyfire( scr_friendlyfire );
    }
}

// Namespace serversettings
// Params 1
// Checksum 0xd2a7757a, Offset: 0x16c
// Size: 0x1ae
function constraingametype( gametype )
{
    entities = getentarray();
    
    for ( i = 0; i < entities.size ; i++ )
    {
        entity = entities[ i ];
        
        if ( gametype == "dm" )
        {
            if ( isdefined( entity.script_gametype_dm ) && entity.script_gametype_dm != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "tdm" )
        {
            if ( isdefined( entity.script_gametype_tdm ) && entity.script_gametype_tdm != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "ctf" )
        {
            if ( isdefined( entity.script_gametype_ctf ) && entity.script_gametype_ctf != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "hq" )
        {
            if ( isdefined( entity.script_gametype_hq ) && entity.script_gametype_hq != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "sd" )
        {
            if ( isdefined( entity.script_gametype_sd ) && entity.script_gametype_sd != "1" )
            {
                entity delete();
            }
            
            continue;
        }
        
        if ( gametype == "koth" || gametype == "koth_horde" || gametype == "koth_jugg" )
        {
            if ( isdefined( entity.script_gametype_koth ) && entity.script_gametype_koth != "1" )
            {
                entity delete();
            }
        }
    }
}

// Namespace serversettings
// Params 1
// Checksum 0x8ac7c481, Offset: 0x322
// Size: 0x37
function setfriendlyfire( enabled )
{
    level.friendlyfire = enabled;
    setdvar( @"ui_friendlyfire", enabled );
    setdvar( @"cg_drawfriendlyhudgrenades", enabled );
}

