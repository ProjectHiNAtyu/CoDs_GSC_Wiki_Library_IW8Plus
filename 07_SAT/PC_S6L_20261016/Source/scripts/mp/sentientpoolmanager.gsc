// scripts\mp\sentientpoolmanager.gsc  (hash_7911684723811df3.gscc) (size: 3403 Bytes / 0xd4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0f469ff (3237243391)
// size ...... 3403 (0xd4b)
// includes .. 1   (offset: 0xc43)
// strings ... 14  (offset: 0xc4b)
// dev strs .. 1   (offset: 0xd3f)
// exports ... 8   (offset: 0x80f)
// cseg ...... 0x14c + 0x6c3 (0x80f)
// imports ... 25  (offset: 0x94f)
// animtree1 . 0   (offset: 0xd4b)
// animtree2 . 0   (offset: 0xd4b)
#using scripts\common\utility;

#namespace sentientpoolmanager;

// Namespace sentientpoolmanager
// Params 0
// Checksum 0x1e2fed91, Offset: 0x16a
// Size: 0x1e9
function init()
{
    utility::flag_init( "sentientpoolmanager_initialized" );
    createthreatbiasgroup( "Tactical_Static" );
    createthreatbiasgroup( "Tactical_Moving" );
    createthreatbiasgroup( "Lethal_Static" );
    createthreatbiasgroup( "Lethal_Moving" );
    createthreatbiasgroup( "Level_Vehicle" );
    createthreatbiasgroup( "Killstreak_Static" );
    createthreatbiasgroup( "Killstreak_Air" );
    createthreatbiasgroup( "Killstreak_Ground" );
    createthreatbiasgroup( "Drone" );
    setignoremegroup( "Killstreak_Ground", "Killstreak_Ground" );
    setignoremegroup( "Killstreak_Air", "Killstreak_Ground" );
    setignoremegroup( "Killstreak_Air", "Killstreak_Air" );
    setignoremegroup( "Killstreak_Ground", "Killstreak_Air" );
    level.sentientpools = [];
    level.sentientpools[ level.sentientpools.size ] = "Tactical_Static";
    level.sentientpools[ level.sentientpools.size ] = "Tactical_Moving";
    level.sentientpools[ level.sentientpools.size ] = "Lethal_Static";
    level.sentientpools[ level.sentientpools.size ] = "Lethal_Moving";
    level.sentientpools[ level.sentientpools.size ] = "Level_Vehicle";
    level.sentientpools[ level.sentientpools.size ] = "Killstreak_Static";
    level.sentientpools[ level.sentientpools.size ] = "Killstreak_Air";
    level.sentientpools[ level.sentientpools.size ] = "Killstreak_Ground";
    level.sentientpools[ level.sentientpools.size ] = "Drone";
    level.activesentients = [];
    
    for ( i = 0; i < level.sentientpools.size ; i++ )
    {
        level.activesentients[ level.sentientpools[ i ] ] = [];
    }
    
    utility::flag_set( "sentientpoolmanager_initialized" );
}

// Namespace sentientpoolmanager
// Params 6
// Checksum 0xb8c4cbe0, Offset: 0x35b
// Size: 0x1e0
function registersentient( threatbiasgroup, var_7abeff39c291fc41, isexplosive, var_29232a9774002e87, var_3b8ee7e3e8397398, var_d1d5db309b77a8bb )
{
    var_3b4e3a6091c7c218 = -1;
    
    for ( i = 0; i < level.sentientpools.size ; i++ )
    {
        if ( level.sentientpools[ i ] == threatbiasgroup )
        {
            var_3b4e3a6091c7c218 = i;
            break;
        }
    }
    
    if ( var_3b4e3a6091c7c218 == -1 )
    {
        assert( var_3b4e3a6091c7c218, "<dev string:x24>" + threatbiasgroup );
        return;
    }
    
    if ( isdefined( self.sentientpool ) )
    {
        return;
    }
    
    sentientcounts = getsentientcounts();
    sentientlimits = getsentientlimits();
    
    if ( sentientcounts[ "other" ] + sentientcounts[ "expendable" ] >= sentientlimits[ "other" ] )
    {
        maderoom = level removebestsentient( var_3b4e3a6091c7c218 );
        
        if ( !maderoom )
        {
            return;
        }
    }
    
    self.sentientpool = threatbiasgroup;
    self.sentientaddedtime = gettime();
    self.sentientpoolindex = self getentitynumber();
    team = undefined;
    
    if ( isstring( var_7abeff39c291fc41 ) )
    {
        team = var_7abeff39c291fc41;
    }
    else if ( isplayer( var_7abeff39c291fc41 ) )
    {
        team = var_7abeff39c291fc41.team;
    }
    
    succeeded = undefined;
    
    if ( isdefined( team ) && !isagent( self ) )
    {
        originalteam = self.team;
        self.team = undefined;
        succeeded = self makeentitysentient( team, undefined, var_3b8ee7e3e8397398, var_d1d5db309b77a8bb );
        
        if ( !succeeded )
        {
            self.team = originalteam;
        }
    }
    
    if ( succeeded )
    {
        self setthreatbiasgroup( threatbiasgroup );
        
        if ( isexplosive )
        {
            self makeentitynomeleetarget();
        }
        
        level.activesentients[ threatbiasgroup ][ self.sentientpoolindex ] = self;
        thread monitorsentient( var_29232a9774002e87 );
    }
}

// Namespace sentientpoolmanager
// Params 1
// Checksum 0x7dae94a2, Offset: 0x543
// Size: 0x5d
function monitorsentient( var_29232a9774002e87 )
{
    level endon( #"game_ended" );
    poolid = self.sentientpool;
    keyid = self.sentientpoolindex;
    utility::waittill_any( "death", "remove_sentient", var_29232a9774002e87 );
    unregistersentient( poolid, keyid );
}

// Namespace sentientpoolmanager
// Params 1
// Checksum 0xef9efd1c, Offset: 0x5a8
// Size: 0xaa, Type: bool
function removebestsentient( var_64f835837d091607 )
{
    assert( var_64f835837d091607 >= 0 && var_64f835837d091607 < level.sentientpools.size );
    bestsentient = undefined;
    
    for ( i = 0; i <= var_64f835837d091607 ; i++ )
    {
        assert( isdefined( level.sentientpools[ i ] ) );
        bestsentient = getbestsentientfrompool( level.sentientpools[ i ] );
        
        if ( isdefined( bestsentient ) )
        {
            break;
        }
    }
    
    if ( !isdefined( bestsentient ) )
    {
        return false;
    }
    
    bestsentient unregistersentient( bestsentient.sentientpool, bestsentient.sentientpoolindex );
    return true;
}

// Namespace sentientpoolmanager
// Params 1
// Checksum 0x8f0fdb61, Offset: 0x65b
// Size: 0xc1
function getbestsentientfrompool( pooltype )
{
    bestsentient = undefined;
    oldesttime = undefined;
    
    foreach ( sentient in level.activesentients[ pooltype ] )
    {
        if ( !isdefined( oldesttime ) || sentient.sentientaddedtime < oldesttime )
        {
            oldesttime = sentient.sentientaddedtime;
            bestsentient = sentient;
        }
    }
    
    return bestsentient;
}

// Namespace sentientpoolmanager
// Params 2
// Checksum 0xf8ac6d3d, Offset: 0x725
// Size: 0x59
function unregistersentient( poolid, keyid )
{
    if ( !( isdefined( poolid ) && isdefined( keyid ) ) )
    {
        return;
    }
    
    level.activesentients[ poolid ][ keyid ] = undefined;
    
    if ( isdefined( self ) )
    {
        self.sentientpool = undefined;
        self.sentientpoolindex = undefined;
        
        if ( !isagent( self ) )
        {
            self freeentitysentient();
        }
    }
}

// Namespace sentientpoolmanager
// Params 0
// Checksum 0xab0ac29a, Offset: 0x786
// Size: 0x88
function function_ad3d873516899a0e()
{
    var_f089e9fea8462fc5 = [];
    
    foreach ( pooltype in level.activesentients )
    {
        var_f089e9fea8462fc5 = arraycombineunique( var_f089e9fea8462fc5, pooltype );
    }
    
    return var_f089e9fea8462fc5;
}

