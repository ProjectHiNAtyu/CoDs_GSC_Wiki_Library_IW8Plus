// scripts\mp\br\gametypes\br_gametype_resurgence_poi.gsc  (hash_650adeb7576be33f.gscc) (size: 1871 Bytes / 0x74f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd64583c (4251211836)
// size ...... 1871 (0x74f)
// includes .. 6   (offset: 0x6eb)
// strings ... 4   (offset: 0x71b)
// dev strs .. 0   (offset: 0x74f)
// exports ... 9   (offset: 0x33f)
// cseg ...... 0x9e + 0x2a1 (0x33f)
// imports ... 20  (offset: 0x4a7)
// animtree1 . 0   (offset: 0x74f)
// animtree2 . 0   (offset: 0x74f)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\flags;

#namespace br_gametype_resurgence_poi;

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0xc62ceb77, Offset: 0xbc
// Size: 0x23
function main()
{
    level.var_dd10333ade220938 = &init;
    connect_event_aggregator::registeronconnectcallback( &onplayerconnect );
    br::main();
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0x9aa38c0d, Offset: 0xe7
// Size: 0x4d
function init()
{
    br_gametype_resurgence::init();
    utility::registersharedfunc( #"gametype", #"getplacementxpsharevalues", &function_bb36ba5f55e6f938 );
    utility::registersharedfunc( #"gametype", #"getbrbonusxppermillisecond", &function_de1474a6bf16b49b );
    level thread function_82c22ddd2ffcaee3();
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0x7d24071b, Offset: 0x13c
// Size: 0x17
function onplayerconnect()
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        function_eb3dffbc3c41dee8();
    }
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0x339a1e56, Offset: 0x15b
// Size: 0xa5
function function_82c22ddd2ffcaee3()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player thread function_72d74f80513e8f72();
        }
    }
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0xbaf796f1, Offset: 0x208
// Size: 0x77
function function_72d74f80513e8f72()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    br::function_db10c8f42ea08ad5( -1, -1, -1 );
    
    if ( !self istacmapactive() )
    {
        self notifyonplayercommand( "tac_map_toggle", "togglemap" );
        self waittill( #"tac_map_toggle" );
    }
    
    while ( isdefined( self ) && !self istacmapactive() )
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_eb3dffbc3c41dee8();
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0x308fbb5d, Offset: 0x287
// Size: 0x63
function function_eb3dffbc3c41dee8()
{
    endpos = br_circle::getfinalcirclecenter();
    zoomradius = level.br_level.br_circleradii[ 0 ] ?? 0;
    
    if ( zoomradius > 0 )
    {
        zoomradius += getdvarint( @"hash_d495131bff7bb215", 3000 );
    }
    
    br::function_db10c8f42ea08ad5( endpos[ 0 ], endpos[ 1 ], zoomradius );
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0x21c51c3b, Offset: 0x2f2
// Size: 0x3c
function function_bb36ba5f55e6f938()
{
    var_e27fb554125cbd0d = 50000;
    var_8a56d104e1212bd9 = 80;
    var_ddc311b5bcc23177 = 15;
    return [ var_e27fb554125cbd0d, var_8a56d104e1212bd9, var_ddc311b5bcc23177 ];
}

// Namespace br_gametype_resurgence_poi
// Params 0
// Checksum 0xdbb6cdb4, Offset: 0x337
// Size: 0x7
function function_de1474a6bf16b49b()
{
    return 0.001;
}

