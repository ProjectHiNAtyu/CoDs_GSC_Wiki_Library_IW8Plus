// scripts\mp\clientmatchdata.gsc  (hash_6256d4509c1489d0.gscc) (size: 1228 Bytes / 0x4cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28f2bcf7 (686996727)
// size ...... 1228 (0x4cc)
// includes .. 0   (offset: 0x480)
// strings ... 5   (offset: 0x480)
// dev strs .. 1   (offset: 0x4c0)
// exports ... 5   (offset: 0x254)
// cseg ...... 0xa8 + 0x1ac (0x254)
// imports ... 12  (offset: 0x31c)
// animtree1 . 0   (offset: 0x4cc)
// animtree2 . 0   (offset: 0x4cc)
#namespace clientmatchdata;

// Namespace clientmatchdata
// Params 0
// Checksum 0x67672462, Offset: 0xc6
// Size: 0x81
function init()
{
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 && !isdefined( game[ "clientMatchDataDefLoaded" ] ) )
    {
        function_fc0c14405ba19dd5();
        setclientmatchdata( "map", level.script );
        setclientmatchdata( "gametype", level.gametype );
        setclientmatchdata( "gametypeNameKey", level.gametypebundle.namekey );
        game[ "clientMatchDataDefLoaded" ] = 1;
    }
    
    level.clientmatchdata_logplayerdeath = &logplayerdeath;
}

// Namespace clientmatchdata
// Params 1
// Checksum 0xdd85149e, Offset: 0x14f
// Size: 0x4b, Type: bool
function canlogclient( client )
{
    if ( isagent( client ) )
    {
        return false;
    }
    
    assert( isplayer( client ), "<dev string:x24>" + client.code_classname );
    return client.clientid < level.maxlogclients;
}

// Namespace clientmatchdata
// Params 1
// Checksum 0x7de3d849, Offset: 0x1a3
// Size: 0x12, Type: bool
function canlogdeath( deathid )
{
    return deathid < 300;
}

// Namespace clientmatchdata
// Params 1
// Checksum 0x893e0a5c, Offset: 0x1be
// Size: 0x96
function logplayerdeath( attacker )
{
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) == 0 )
    {
        return;
    }
    
    deathid = getclientmatchdata( "deathCount" );
    
    if ( !canlogclient( self ) || !canlogdeath( deathid ) )
    {
        return;
    }
    
    if ( isplayer( attacker ) && canlogclient( attacker ) )
    {
        self logclientmatchdatadeath( deathid, self.clientid, attacker, attacker.clientid );
        return;
    }
    
    self logclientmatchdatadeath( deathid, self.clientid, undefined, undefined );
}

