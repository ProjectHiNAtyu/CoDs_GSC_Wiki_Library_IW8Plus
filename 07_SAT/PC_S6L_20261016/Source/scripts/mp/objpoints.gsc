// scripts\mp\objpoints.gsc  (hash_73b96343b87e992a.gscc) (size: 2132 Bytes / 0x854 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd7ad568 (3715814760)
// size ...... 2132 (0x854)
// includes .. 0   (offset: 0x82c)
// strings ... 2   (offset: 0x82c)
// dev strs .. 1   (offset: 0x848)
// exports ... 10  (offset: 0x554)
// cseg ...... 0x73 + 0x4e1 (0x554)
// imports ... 11  (offset: 0x6e4)
// animtree1 . 0   (offset: 0x854)
// animtree2 . 0   (offset: 0x854)
#namespace objpoints;

// Namespace objpoints
// Params 0
// Checksum 0x731706dc, Offset: 0x91
// Size: 0x61
function init()
{
    precacheshader( "objpoint_default" );
    level.objpointnames = [];
    level.objpoints = [];
    
    if ( level.splitscreen )
    {
        level.objpointsize = 15;
    }
    else
    {
        level.objpointsize = 8;
    }
    
    level.objpoint_alpha_default = 0.75;
    level.objpointscale = 1;
}

// Namespace objpoints
// Params 6
// Checksum 0x56e2580, Offset: 0xfa
// Size: 0x159
function createteamobjpoint( index, origin, team, shader, alpha, scale )
{
    assert( team == "<dev string:x24>" );
    
    if ( !isdefined( shader ) )
    {
        shader = "objpoint_default";
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    objpoint = undefined;
    
    if ( team != "all" )
    {
        objpoint = newteamhudelem( team );
    }
    else
    {
        objpoint = newhudelem();
    }
    
    objpoint.id = index;
    objpoint.x = origin[ 0 ];
    objpoint.y = origin[ 1 ];
    objpoint.z = origin[ 2 ];
    objpoint.team = team;
    objpoint.isflashing = 0;
    objpoint.isshown = 1;
    objpoint setshader( shader, level.objpointsize, level.objpointsize );
    objpoint setwaypoint( 1, 0 );
    
    if ( isdefined( alpha ) )
    {
        objpoint.alpha = alpha;
    }
    else
    {
        objpoint.alpha = level.objpoint_alpha_default;
    }
    
    objpoint.basealpha = objpoint.alpha;
    return objpoint;
}

// Namespace objpoints
// Params 1
// Checksum 0xa4b72b55, Offset: 0x25c
// Size: 0x120
function deleteobjpoint( oldobjpoint )
{
    assert( level.objpoints.size == level.objpointnames.size );
    
    if ( level.objpoints.size == 1 )
    {
        assert( level.objpointnames[ 0 ] == oldobjpoint.name );
        assert( isdefined( level.objpoints[ oldobjpoint.name ] ) );
        level.objpoints = [];
        level.objpointnames = [];
        oldobjpoint destroy();
        return;
    }
    
    newindex = oldobjpoint.index;
    oldindex = level.objpointnames.size - 1;
    objpoint = getobjpointbyindex( oldindex );
    level.objpointnames[ newindex ] = objpoint.name;
    objpoint.index = newindex;
    level.objpointnames[ oldindex ] = undefined;
    level.objpoints[ oldobjpoint.name ] = undefined;
    oldobjpoint destroy();
}

// Namespace objpoints
// Params 1
// Checksum 0x71c701f2, Offset: 0x384
// Size: 0x64
function updateorigin( origin )
{
    if ( self.x != origin[ 0 ] )
    {
        self.x = origin[ 0 ];
    }
    
    if ( self.y != origin[ 1 ] )
    {
        self.y = origin[ 1 ];
    }
    
    if ( self.z != origin[ 2 ] )
    {
        self.z = origin[ 2 ];
    }
}

// Namespace objpoints
// Params 2
// Checksum 0x88caa9a0, Offset: 0x3f0
// Size: 0x33
function setoriginbyname( name, origin )
{
    objpoint = getobjpointbyname( name );
    objpoint updateorigin( origin );
}

// Namespace objpoints
// Params 1
// Checksum 0x30803d7e, Offset: 0x42b
// Size: 0x2d
function getobjpointbyname( name )
{
    if ( isdefined( level.objpoints[ name ] ) )
    {
        return level.objpoints[ name ];
    }
    
    return;
}

// Namespace objpoints
// Params 1
// Checksum 0x6e5eff87, Offset: 0x460
// Size: 0x37
function getobjpointbyindex( index )
{
    if ( isdefined( level.objpointnames[ index ] ) )
    {
        return level.objpoints[ level.objpointnames[ index ] ];
    }
    
    return;
}

// Namespace objpoints
// Params 0
// Checksum 0xb77ae359, Offset: 0x49f
// Size: 0x93
function startflashing()
{
    self endon( #"hash_8cb63635c137dc2d" );
    
    if ( self.isflashing )
    {
        return;
    }
    
    self.isflashing = 1;
    
    while ( self.isflashing )
    {
        self fadeovertime( 0.75 );
        self.alpha = 0.35 * self.basealpha;
        wait 0.75;
        self fadeovertime( 0.75 );
        self.alpha = self.basealpha;
        wait 0.75;
    }
    
    self.alpha = self.basealpha;
}

// Namespace objpoints
// Params 0
// Checksum 0x65801418, Offset: 0x53a
// Size: 0x1a
function stopflashing()
{
    if ( !self.isflashing )
    {
        return;
    }
    
    self.isflashing = 0;
}

