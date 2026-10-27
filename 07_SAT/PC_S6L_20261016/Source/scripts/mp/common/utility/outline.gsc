// scripts\mp\common\utility\outline.gsc  (hash_7af4b8f37e520205.gscc) (size: 6055 Bytes / 0x17a7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0c226b1 (3770820273)
// size ...... 6055 (0x17a7)
// includes .. 6   (offset: 0x169b)
// strings ... 6   (offset: 0x16cb)
// dev strs .. 11  (offset: 0x1723)
// exports ... 25  (offset: 0xda7)
// cseg ...... 0x98 + 0xd0f (0xda7)
// imports ... 40  (offset: 0x118f)
// animtree1 . 0   (offset: 0x17a7)
// animtree2 . 0   (offset: 0x17a7)
#using scripts\common\math;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\outline;

#namespace outline;

// Namespace outline
// Params 4
// Checksum 0x4d3f93f2, Offset: 0xb6
// Size: 0x55
function outlineenableforall( var_72bacf1a84917ff4, hudoutlineassetname, prioritygroup, var_dee59419df84c9c4 = 0 )
{
    prioritygroup = getxhash( prioritygroup );
    return outlineenableinternal( var_72bacf1a84917ff4, level.players, hudoutlineassetname, prioritygroup, "ALL", undefined, undefined, undefined, var_dee59419df84c9c4 );
}

// Namespace outline
// Params 3
// Checksum 0x6c92bf99, Offset: 0x114
// Size: 0x30
function outlineviewmodelenable( var_72bacf1a84917ff4, hudoutlineassetname, prioritygroup )
{
    prioritygroup = getxhash( prioritygroup );
    return function_b8b81b3d2c58f000( var_72bacf1a84917ff4, hudoutlineassetname, prioritygroup );
}

// Namespace outline
// Params 4
// Checksum 0xb1b4010b, Offset: 0x14d
// Size: 0x40
function function_cc0ba57bbdf62b90( var_72bacf1a84917ff4, playersvisibleto, hudoutlineassetname, prioritygroup )
{
    prioritygroup = getxhash( prioritygroup );
    return outlineenableinternal( var_72bacf1a84917ff4, playersvisibleto, hudoutlineassetname, prioritygroup, "ALL" );
}

// Namespace outline
// Params 7
// Checksum 0x9d07c459, Offset: 0x196
// Size: 0x141
function outlineenableforteam( var_72bacf1a84917ff4, var_471181657d3e58e6, hudoutlineassetname, prioritygroup, var_39608ff9f170fda3, var_d478999d804948f6, var_51b3f2faa57d7ee8 )
{
    prioritygroup = getxhash( prioritygroup );
    
    if ( team_utility::isgameplayteam( var_471181657d3e58e6 ) )
    {
        playersvisibleto = teams::getteamdata( var_471181657d3e58e6, "players" );
    }
    else
    {
        playersvisibleto = [];
    }
    
    if ( isdefined( var_39608ff9f170fda3 ) )
    {
        var_7ca2ccbf7012c93 = [];
        
        if ( isarray( var_39608ff9f170fda3 ) )
        {
            var_7ca2ccbf7012c93 = var_39608ff9f170fda3;
        }
        else if ( isplayer( var_39608ff9f170fda3 ) )
        {
            var_7ca2ccbf7012c93 = [ var_39608ff9f170fda3 ];
        }
        
        foreach ( var_8e335378083f60b4 in var_7ca2ccbf7012c93 )
        {
            if ( var_8e335378083f60b4.team == var_471181657d3e58e6 )
            {
                playersvisibleto = arrayremove( playersvisibleto, var_8e335378083f60b4 );
            }
        }
    }
    
    return outlineenableinternal( var_72bacf1a84917ff4, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", var_471181657d3e58e6, undefined, var_d478999d804948f6, undefined, var_51b3f2faa57d7ee8 );
}

// Namespace outline
// Params 6
// Checksum 0xa0821987, Offset: 0x2e0
// Size: 0x101
function function_6901ecad424487e8( var_72bacf1a84917ff4, var_973dacb2daa897a3, hudoutlineassetname, prioritygroup, var_d478999d804948f6, var_51b3f2faa57d7ee8 )
{
    prioritygroup = getxhash( prioritygroup );
    assert( isarray( var_973dacb2daa897a3 ), "<dev string:x24>" );
    playersvisibleto = [];
    
    foreach ( team in var_973dacb2daa897a3 )
    {
        if ( team_utility::isgameplayteam( team ) )
        {
            playersvisibleto = arraycombine( playersvisibleto, teams::getteamdata( team, "players" ) );
        }
    }
    
    return outlineenableinternal( var_72bacf1a84917ff4, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", var_973dacb2daa897a3, undefined, var_d478999d804948f6, undefined, var_51b3f2faa57d7ee8 );
}

// Namespace outline
// Params 5
// Checksum 0xeffb3f89, Offset: 0x3ea
// Size: 0xc4
function outlineenableforsquad( var_72bacf1a84917ff4, var_471181657d3e58e6, squadindex, hudoutlineassetname, prioritygroup )
{
    prioritygroup = getxhash( prioritygroup );
    assert( squad_utility::issquadmode(), "<dev string:x41>" );
    assert( isdefined( level.squaddata[ var_471181657d3e58e6 ] ), "<dev string:x76>" + var_471181657d3e58e6 );
    assert( !isdefined( level.squaddata[ var_471181657d3e58e6 ] ) || isdefined( level.squaddata[ var_471181657d3e58e6 ][ squadindex ] ), "<dev string:xb8>" + squadindex );
    return outlineenableinternal( var_72bacf1a84917ff4, level.squaddata[ var_471181657d3e58e6 ][ squadindex ].players, hudoutlineassetname, prioritygroup, "SQUAD", var_471181657d3e58e6, squadindex );
}

// Namespace outline
// Params 6
// Checksum 0x31a1e19, Offset: 0x4b7
// Size: 0x88
function outlineenableforplayer( var_72bacf1a84917ff4, var_7dd27c2ee8d854d6, hudoutlineassetname, prioritygroup, var_d478999d804948f6 = 0, var_dee59419df84c9c4 = 0 )
{
    prioritygroup = getxhash( prioritygroup );
    
    if ( isagent( var_7dd27c2ee8d854d6 ) || !isent( var_72bacf1a84917ff4 ) )
    {
        return outlinegenerateuniqueid();
    }
    
    return outlineenableinternal( var_72bacf1a84917ff4, [ var_7dd27c2ee8d854d6 ], hudoutlineassetname, prioritygroup, "ENTITY", undefined, undefined, var_d478999d804948f6, var_dee59419df84c9c4 );
}

// Namespace outline
// Params 2
// Checksum 0x3f510d2a, Offset: 0x548
// Size: 0x24, Type: bool
function function_e5be62c454a35e6c( ent, outlineid )
{
    return isdefined( ent.outlinesviewmodel[ outlineid ] );
}

// Namespace outline
// Params 2
// Checksum 0xc411eb88, Offset: 0x575
// Size: 0x3b, Type: bool
function function_d922cfa94c5afc77( ent, outlineid )
{
    return function_e5be62c454a35e6c( ent, outlineid ) && !ent.outlinesviewmodel[ outlineid ].isdisabled;
}

// Namespace outline
// Params 2
// Checksum 0xcc3be7eb, Offset: 0x5b9
// Size: 0x30, Type: bool
function function_546d21e688121132( ent, outlineid )
{
    return isdefined( ent ) && isdefined( outlineid ) && isdefined( ent.outlines[ outlineid ] );
}

// Namespace outline
// Params 2
// Checksum 0x459a8487, Offset: 0x5f2
// Size: 0x3b, Type: bool
function isoutlineenabled( ent, outlineid )
{
    return function_546d21e688121132( ent, outlineid ) && !ent.outlines[ outlineid ].isdisabled;
}

// Namespace outline
// Params 2
// Checksum 0xb78cf39, Offset: 0x636
// Size: 0x35
function outlinedisable( id, var_a180bd51b09ab4ad )
{
    assert( int( id ) == id, "<dev string:x109>" );
    outlinedisableinternal( id, var_a180bd51b09ab4ad );
}

// Namespace outline
// Params 2
// Checksum 0xfb1a0655, Offset: 0x673
// Size: 0x35
function outlineviewmodeldisable( id, var_a180bd51b09ab4ad )
{
    assert( int( id ) == id, "<dev string:x12f>" );
    function_e8a0016e4a4b5903( id, var_a180bd51b09ab4ad );
}

// Namespace outline
// Params 1
// Checksum 0x1b4bc1a3, Offset: 0x6b0
// Size: 0x25
function outlinerefresh( var_a180bd51b09ab4ad )
{
    assert( isdefined( var_a180bd51b09ab4ad ), "<dev string:x15e>" );
    outlinerefreshinternal( var_a180bd51b09ab4ad );
}

// Namespace outline
// Params 0
// Checksum 0xc264eca2, Offset: 0x6dd
// Size: 0x16
function initoutlineoccluders()
{
    level.outlineoccluders = [];
    level.outlineoccludersid = 0;
}

// Namespace outline
// Params 2
// Checksum 0x2045c14b, Offset: 0x6fb
// Size: 0x6e
function addoutlineoccluder( position, radius )
{
    outlineoccluder = spawnstruct();
    outlineoccluder.position = position;
    outlineoccluder.radius = radius;
    id = level.outlineoccludersid;
    level.outlineoccluders[ id ] = outlineoccluder;
    level.outlineoccludersid++;
    return id;
}

// Namespace outline
// Params 1
// Checksum 0xa41ee307, Offset: 0x772
// Size: 0x18
function removeoutlineoccluder( id )
{
    level.outlineoccluders[ id ] = undefined;
}

// Namespace outline
// Params 2
// Checksum 0xf7cfe872, Offset: 0x792
// Size: 0xcd, Type: bool
function outlineoccluded( startpoint, endpoint )
{
    foreach ( occluder in level.outlineoccluders )
    {
        if ( !( isdefined( occluder.position ) && isdefined( occluder.radius ) ) )
        {
            continue;
        }
        
        if ( math::segmentvssphere( startpoint, endpoint, occluder.position, occluder.radius ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace outline
// Params 6
// Checksum 0x48ee229e, Offset: 0x868
// Size: 0x1ee
function function_67e3226e79560595( victimgroup, attacker, var_35133ea1d74d7e08, duration, outlineassetname = "snapshotgrenade", prioritygroup = #"equipment" )
{
    prioritygroup = getxhash( prioritygroup );
    assert( isdefined( victimgroup ), "<dev string:x18f>" );
    assert( isdefined( attacker ), "<dev string:x1e8>" );
    
    if ( !isdefined( var_35133ea1d74d7e08 ) )
    {
        var_35133ea1d74d7e08 = [ attacker ];
    }
    
    if ( !isarray( var_35133ea1d74d7e08 ) )
    {
        var_35133ea1d74d7e08 = [ var_35133ea1d74d7e08 ];
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 1000;
    }
    else
    {
        duration *= 1000;
    }
    
    outlinedata = spawnstruct();
    outlinedata.owner = attacker;
    outlinedata.isalive = 1;
    outlinedata.targets = [];
    outlinedata.endtimes = [];
    outlinedata.outlineids = [];
    
    if ( !isarray( victimgroup ) )
    {
        victimgroup = [ victimgroup ];
    }
    
    foreach ( victim in victimgroup )
    {
        if ( !isent( victim ) )
        {
            continue;
        }
        
        entnum = victim getentitynumber();
        outlinedata.targets[ entnum ] = victim;
        outlinedata.endtimes[ entnum ] = gettime() + duration;
        outlinedata.outlineids[ entnum ] = outlineenableinternal( victim, var_35133ea1d74d7e08, outlineassetname, prioritygroup, "ENTITY" );
    }
    
    outlinedata thread function_8d69f64cf9423512();
}

// Namespace outline
// Params 0, eflags: 0x4
// Checksum 0xe92bbcae, Offset: 0xa5e
// Size: 0x184
function private function_8d69f64cf9423512()
{
    self endon( #"death" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    if ( !self.isalive )
    {
        return;
    }
    
    while ( self.targets.size > 0 )
    {
        foreach ( id, target in self.targets )
        {
            target = self.targets[ id ];
            endtime = self.endtimes[ id ];
            outlineid = self.outlineids[ id ];
            
            if ( !isdefined( target ) || !player::isreallyalive( target ) || gettime() >= endtime )
            {
                outlinedisable( outlineid, target );
                
                if ( isdefined( target ) && ( isplayer( target ) || isbot( target ) ) )
                {
                    target _hudoutlineviewmodeldisable();
                }
                
                self.targets[ id ] = undefined;
                self.endtimes[ id ] = undefined;
                self.outlineids[ id ] = undefined;
            }
        }
        
        waitframe();
    }
    
    function_83d33d0ef124673b();
}

// Namespace outline
// Params 0, eflags: 0x4
// Checksum 0xe895dd0c, Offset: 0xbea
// Size: 0xd9
function private function_83d33d0ef124673b()
{
    self notify( #"death" );
    self.isalive = 0;
    
    foreach ( id, target in self.targets )
    {
        target = self.targets[ id ];
        outlineid = self.outlineids[ id ];
        outlinedisable( outlineid, target );
        
        if ( isdefined( target ) && ( isplayer( target ) || isbot( target ) ) )
        {
            target _hudoutlineviewmodeldisable();
        }
    }
}

// Namespace outline
// Params 0
// Checksum 0xe2378d23, Offset: 0xccb
// Size: 0x1d
function _hudoutlineviewmodeldisable()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !player::isreallyalive() )
    {
        return;
    }
    
    self hudoutlineviewmodeldisable();
}

// Namespace outline
// Params 2
// Checksum 0xd191dd0a, Offset: 0xcf0
// Size: 0x66
function _hudoutlineviewmodelenable( hudoutlineassetname, var_5be36dcf589800d = 0 )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x24e>" );
        return;
    }
    
    if ( !player::isreallyalive() )
    {
        if ( !var_5be36dcf589800d )
        {
            assertmsg( "<dev string:x266>" );
            return;
        }
        
        thread hudoutlineviewmodelenableonnextspawn( hudoutlineassetname );
        return;
    }
    
    self hudoutlineviewmodelenable( hudoutlineassetname );
}

// Namespace outline
// Params 1
// Checksum 0x876b7f03, Offset: 0xd5e
// Size: 0x49
function hudoutlineviewmodelenableonnextspawn( hudoutlineassetname )
{
    level endon( #"game_ended" );
    self waittill( #"spawned" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !player::isreallyalive() )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self hudoutlineviewmodelenable( hudoutlineassetname );
}

