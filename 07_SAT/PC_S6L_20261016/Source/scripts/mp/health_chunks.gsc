// scripts\mp\health_chunks.gsc  (hash_0a5e53c9730a706d.gscc) (size: 18148 Bytes / 0x46e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b12d3a0 (1259525024)
// size ...... 18148 (0x46e4)
// includes .. 11  (offset: 0x454c)
// strings ... 17  (offset: 0x45a4)
// dev strs .. 4   (offset: 0x46b4)
// exports ... 39  (offset: 0x30a4)
// cseg ...... 0x179 + 0x2f2b (0x30a4)
// imports ... 109 (offset: 0x36bc)
// animtree1 . 0   (offset: 0x46e4)
// animtree2 . 0   (offset: 0x46e4)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\laststand;
#using scripts\mp\playerhealth;
#using scripts\mp\quick_use;
#using scripts\mp\quickprompt;
#using scripts\mp\wounded_movement;

#namespace health_chunks;

// Namespace health_chunks
// Params 0, eflags: 0x5
// Checksum 0x1c61e3f3, Offset: 0x197
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"health_chunks", undefined, undefined, &init );
}

// Namespace health_chunks
// Params 0
// Checksum 0x27c09ff0, Offset: 0x1b8
// Size: 0x133
function init()
{
    if ( !isenabled() || isdefined( level.var_ada44f3dab2c1d1 ) )
    {
        return;
    }
    
    function_adef98b3d83c4fd9();
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"hash_9741c7ee14b21924", &function_dd6a63500fbab2ef );
    callback::add( #"hash_564154fd82037502", &function_96242a62a02bf92 );
    callback::add( #"player_damaged", &function_eccfa657c586c520 );
    callback::add( #"player_friendly_fire", &function_eccfa657c586c520 );
    callback::add( #"player_laststand", &function_79faddedd4ba6280 );
    callback::add( #"player_laststand_exit", &function_834e623a250b9758 );
    utility::registersharedfunc( #"health_chunk", #"restorechunks", &restorechunks );
    utility::registersharedfunc( #"health_chunk", #"isenabled", &isenabled );
    utility::registersharedfunc( #"health_chunk", #"hash_bc96117656a280bf", &function_57d7450ef7a9c202 );
    laststand::register_revive_reason( "health_chunk_revive" );
    
    /#
        thread dev::devcommandwatcher( @"health_chunk", &function_adc7fbe77ad652cc );
    #/
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0xa85472b9, Offset: 0x2f3
// Size: 0x1a
function private function_79faddedd4ba6280( params )
{
    function_b1088edb45ba7b9( "laststand", 1 );
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0x93e504c9, Offset: 0x315
// Size: 0x19
function private function_834e623a250b9758( params )
{
    function_b1088edb45ba7b9( "laststand", 0 );
}

// Namespace health_chunks
// Params 1, eflags: 0xc
// Checksum 0x904d3801, Offset: 0x336
// Size: 0x7a
function private function_eccfa657c586c520( params )
{
    self notify( #"hash_9b7a666a4f45eac4" );
    self endon( #"hash_9b7a666a4f45eac4" );
    
    if ( self.health >= self.maxhealth || player::isinlaststand( self ) )
    {
        return;
    }
    
    function_b1088edb45ba7b9( "damage", 1 );
    self endon( #"disconnect" );
    self waittill( #"healed" );
    function_b1088edb45ba7b9( "damage", 0 );
}

// Namespace health_chunks
// Params 0, eflags: 0x4
// Checksum 0x5e8016b3, Offset: 0x3b8
// Size: 0xc, Type: bool
function private function_7ac90c4f2a92dfa0()
{
    return istrue( self.bloodyfootsteps );
}

// Namespace health_chunks
// Params 2, eflags: 0x4
// Checksum 0x988c392e, Offset: 0x3cd
// Size: 0xb4
function private function_b1088edb45ba7b9( source, val )
{
    if ( val )
    {
        if ( !isdefined( self.bloodyfootsteps ) )
        {
            self.bloodyfootsteps = [];
        }
        
        self.bloodyfootsteps[ source ] = 1;
        
        if ( self.bloodyfootsteps.size == 1 )
        {
            self function_ea4a0a1465ba167e( 1 );
            utility::function_7c10ea82c1e305b8( "bloody_footstep_fx", "on" );
        }
        
        return;
    }
    
    if ( self.bloodyfootsteps )
    {
        self.bloodyfootsteps[ source ] = undefined;
        
        if ( self.bloodyfootsteps.size == 0 )
        {
            self.bloodyfootsteps = undefined;
            self function_ea4a0a1465ba167e( 0 );
            utility::function_7c10ea82c1e305b8( "bloody_footstep_fx", "off" );
        }
    }
}

// Namespace health_chunks
// Params 4
// Checksum 0xf54a2c99, Offset: 0x489
// Size: 0x2bc
function modifychunk( player, newhealth, var_4807de00aa3e9293, index )
{
    if ( !function_9cb515de902172b5( player ) || !isdefined( newhealth ) || player.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe >= function_c3c38bc991ec9e76( player ).size )
    {
        assert( isdefined( newhealth ), "<dev string:x24>" );
        return;
    }
    
    if ( !( isdefined( index ) && isdefined( player.var_ada44f3dab2c1d1.chunks[ index ] ) ) )
    {
        currentdata = function_592f3ae4a5ba7280( player );
        
        if ( !isdefined( currentdata ) )
        {
            return;
        }
        
        index = currentdata.index;
    }
    
    if ( newhealth < level.var_ada44f3dab2c1d1.var_7021b0793d8622f0 )
    {
        removechunk( player, index, var_4807de00aa3e9293 );
        return;
    }
    
    deltahealth = newhealth - player.var_ada44f3dab2c1d1.chunks[ index ];
    
    if ( var_4807de00aa3e9293 )
    {
        leftoverhealth = deltahealth;
        
        for ( i = 0; i < player.var_ada44f3dab2c1d1.chunks.size ; i++ )
        {
            if ( i == index )
            {
                continue;
            }
            
            originalhealth = player.var_ada44f3dab2c1d1.chunks[ i ];
            modifiedhealth = max( originalhealth - deltahealth, level.var_ada44f3dab2c1d1.var_7021b0793d8622f0 );
            player.var_ada44f3dab2c1d1.chunks[ i ] = modifiedhealth;
            leftoverhealth -= originalhealth - modifiedhealth;
        }
        
        deltahealth = 0;
        newhealth -= leftoverhealth;
    }
    
    player.var_ada44f3dab2c1d1.chunks[ index ] = newhealth;
    var_839d665c7f7a4ec2 = 0;
    
    foreach ( chunk in player.var_ada44f3dab2c1d1.chunks )
    {
        var_839d665c7f7a4ec2 += chunk;
    }
    
    player.health = int( min( player.health, var_839d665c7f7a4ec2 ) );
    function_4c2e0e145365c407( player, var_4807de00aa3e9293 );
    function_bef3c19887444a9e( { #victim:player } );
    
    if ( wounded_movement::isenabled() )
    {
        player wounded_movement::function_9fe35b09302906a0();
    }
    
    function_4a767a18ab106419( player );
}

// Namespace health_chunks
// Params 4
// Checksum 0xb936830b, Offset: 0x74d
// Size: 0x30a
function removechunk( player, index, var_4807de00aa3e9293, isdisabling )
{
    if ( !function_9cb515de902172b5( player ) || player.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe >= function_c3c38bc991ec9e76( player ).size )
    {
        return;
    }
    
    index = index ?? player.var_ada44f3dab2c1d1.chunks.size - 1;
    
    if ( !isdefined( player.var_ada44f3dab2c1d1.chunks[ index ] ) )
    {
        assertmsg( "<dev string:x59>" );
        return;
    }
    
    var_c738b1ede69c9097 = player.var_ada44f3dab2c1d1.chunks[ index ];
    player.var_ada44f3dab2c1d1.chunks[ index ] = undefined;
    
    if ( isint( index ) )
    {
        function_cdc669dbc8ea2101( player.var_ada44f3dab2c1d1.chunks );
    }
    
    if ( player.var_ada44f3dab2c1d1.chunks.size == 0 )
    {
        function_4a767a18ab106419( player );
        player callback::callback( #"hash_564154fd82037502", { #removing:1 } );
        player function_b1088edb45ba7b9( "healthchunks", 1 );
        return;
    }
    
    if ( var_4807de00aa3e9293 )
    {
        var_d91b04928cf7e0fe = var_c738b1ede69c9097 / player.var_ada44f3dab2c1d1.chunks.size;
        
        for ( i = 0; i < player.var_ada44f3dab2c1d1.chunks.size ; i++ )
        {
            player.var_ada44f3dab2c1d1.chunks[ i ] += var_d91b04928cf7e0fe;
        }
        
        var_c738b1ede69c9097 = 0;
    }
    
    var_839d665c7f7a4ec2 = 0;
    
    foreach ( chunk in player.var_ada44f3dab2c1d1.chunks )
    {
        var_839d665c7f7a4ec2 += chunk;
    }
    
    player.health = int( min( player.health, var_839d665c7f7a4ec2 ) );
    function_bef3c19887444a9e( { #victim:player } );
    
    if ( wounded_movement::isenabled() )
    {
        player wounded_movement::function_9fe35b09302906a0();
    }
    
    if ( !var_4807de00aa3e9293 )
    {
        player.var_b487d47112fa93d = 1;
    }
    
    function_4a767a18ab106419( player );
    player callback::callback( #"hash_564154fd82037502", { #removing:1, #isdisabling:isdisabling } );
    player function_b1088edb45ba7b9( "healthchunks", 1 );
}

// Namespace health_chunks
// Params 3
// Checksum 0x31c54d, Offset: 0xa5f
// Size: 0x2f6
function addchunk( player, chunkhealth, var_4807de00aa3e9293 )
{
    if ( !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    numchunks = var_4807de00aa3e9293 ? player.var_ada44f3dab2c1d1.chunks.size + 1 : player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
    chunkmax = player.var_ada44f3dab2c1d1.basemaxhealth / numchunks;
    var_d91b04928cf7e0fe = chunkhealth ?? chunkmax;
    
    if ( var_4807de00aa3e9293 )
    {
        var_c738b1ede69c9097 = var_d91b04928cf7e0fe / player.var_ada44f3dab2c1d1.chunks.size;
        leftovervalue = var_d91b04928cf7e0fe;
        
        for ( i = 0; i < player.var_ada44f3dab2c1d1.chunks.size ; i++ )
        {
            originalvalue = player.var_ada44f3dab2c1d1.chunks[ i ];
            newvalue = max( originalvalue - var_c738b1ede69c9097, level.var_ada44f3dab2c1d1.var_7021b0793d8622f0 );
            player.var_ada44f3dab2c1d1.chunks[ i ] = newvalue;
            leftovervalue -= originalvalue - newvalue;
        }
        
        var_d91b04928cf7e0fe -= leftovervalue;
        var_d91b04928cf7e0fe = max( var_d91b04928cf7e0fe, level.var_ada44f3dab2c1d1.var_7021b0793d8622f0 );
    }
    else
    {
        chunks = player.var_ada44f3dab2c1d1.chunks;
        
        foreach ( i, chunk in player.var_ada44f3dab2c1d1.chunks )
        {
            if ( var_d91b04928cf7e0fe <= 0 )
            {
                break;
            }
            
            var_4a44862535fa90fe = min( chunk + var_d91b04928cf7e0fe, chunkmax );
            var_d91b04928cf7e0fe -= chunkmax - chunk;
            chunks[ i ] = var_4a44862535fa90fe;
        }
        
        player.var_ada44f3dab2c1d1.chunks = chunks;
    }
    
    chunks = arraycombine( player.var_ada44f3dab2c1d1.chunks, [ var_d91b04928cf7e0fe ] );
    player.var_ada44f3dab2c1d1.chunks = chunks;
    function_4c2e0e145365c407( player, var_4807de00aa3e9293 );
    function_bef3c19887444a9e( { #victim:player } );
    function_4a767a18ab106419( player );
    
    if ( wounded_movement::isenabled() )
    {
        player wounded_movement::function_9fe35b09302906a0();
    }
    
    player callback::callback( #"hash_9f85dd470a0b7a0c", {} );
    player function_b1088edb45ba7b9( "healthchunks", 0 );
}

// Namespace health_chunks
// Params 2
// Checksum 0x5a27adef, Offset: 0xd5d
// Size: 0x3e
function function_71612586498c2ca9( player, regenimmediately = 1 )
{
    restorechunks( player, player.var_ada44f3dab2c1d1.var_80b254869e7b4523, regenimmediately );
}

// Namespace health_chunks
// Params 5
// Checksum 0x5286df02, Offset: 0xda3
// Size: 0x1fe
function restorechunks( player, numchunks = 1, regenimmediately = 1, delayregentime, regenspeedmod )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( isdefined( player.var_bb2bb54de2aff00d ) )
    {
        player.var_bb2bb54de2aff00d = min( player.var_ada44f3dab2c1d1.var_80b254869e7b4523 ?? level.var_ada44f3dab2c1d1.var_7b14baf188eb576a, player.var_bb2bb54de2aff00d + numchunks );
    }
    
    if ( !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    var_9e3d6a460c64aec8 = int( min( player.var_ada44f3dab2c1d1.var_80b254869e7b4523 - player.var_ada44f3dab2c1d1.chunks.size, numchunks ) );
    
    for ( i = 0; i < var_9e3d6a460c64aec8 ; i++ )
    {
        addchunk( player );
    }
    
    currentchunk = function_592f3ae4a5ba7280( player );
    chunkmax = player.var_ada44f3dab2c1d1.basemaxhealth / player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
    
    if ( isdefined( currentchunk ) && currentchunk.value < chunkmax )
    {
        player.var_ada44f3dab2c1d1.chunks[ currentchunk.index ] = chunkmax;
    }
    
    function_bef3c19887444a9e( { #victim:player } );
    function_4a767a18ab106419( player );
    
    if ( regenimmediately )
    {
        playerhealth::forcehealthregen( player, 1, regenspeedmod );
    }
    else if ( delayregentime )
    {
        thread playerhealth::forcehealthregendelay( player, 1, delayregentime, regenspeedmod );
    }
    
    player callback::callback( #"hash_9f85dd470a0b7a0c", {} );
    player function_b1088edb45ba7b9( "healthchunks", 0 );
}

// Namespace health_chunks
// Params 7
// Checksum 0x89439fcf, Offset: 0xfa9
// Size: 0x27f
function incrementchunks( player, incrementamount, var_4807de00aa3e9293, regenimmediately, delayregentime, regenspeedmod, var_68b372c73f05aa5b )
{
    if ( !isenabled() || !( isdefined( player ) && isdefined( incrementamount ) ) || incrementamount <= 0 )
    {
        return;
    }
    
    if ( isdefined( player.var_bb2bb54de2aff00d ) && isdefined( player.var_ada44f3dab2c1d1 ) )
    {
        var_e0b4c337dc70987b = player.var_ada44f3dab2c1d1.basemaxhealth / player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
        player.var_bb2bb54de2aff00d = min( player.var_ada44f3dab2c1d1.var_80b254869e7b4523 ?? level.var_ada44f3dab2c1d1.var_7b14baf188eb576a, player.var_bb2bb54de2aff00d + incrementamount / var_e0b4c337dc70987b );
    }
    
    if ( !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    currentchunk = function_592f3ae4a5ba7280( player );
    var_e0b4c337dc70987b = player.var_ada44f3dab2c1d1.basemaxhealth / player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
    var_3994cd3134d27a0 = currentchunk.value + incrementamount;
    
    if ( currentchunk.value < var_e0b4c337dc70987b )
    {
        modifychunk( player, min( var_3994cd3134d27a0, var_e0b4c337dc70987b ), var_4807de00aa3e9293 );
    }
    
    if ( var_3994cd3134d27a0 >= var_e0b4c337dc70987b && ( var_68b372c73f05aa5b || level.var_ada44f3dab2c1d1.var_7b14baf188eb576a > player.var_ada44f3dab2c1d1.chunks.size ) )
    {
        var_3994cd3134d27a0 -= var_e0b4c337dc70987b;
        var_e673fc0cb5582efc = int( ceil( var_3994cd3134d27a0 / var_e0b4c337dc70987b ) );
        
        if ( !var_68b372c73f05aa5b )
        {
            var_e673fc0cb5582efc = int( min( level.var_ada44f3dab2c1d1.var_7b14baf188eb576a - player.var_ada44f3dab2c1d1.chunks.size, var_e673fc0cb5582efc ) );
        }
        
        for ( i = 0; i < var_e673fc0cb5582efc ; i++ )
        {
            chunkhealth = min( var_e0b4c337dc70987b, var_3994cd3134d27a0 );
            addchunk( player, chunkhealth, var_4807de00aa3e9293 );
            var_3994cd3134d27a0 -= chunkhealth;
        }
    }
    
    if ( regenimmediately )
    {
        playerhealth::forcehealthregen( player, 1, regenspeedmod );
        return;
    }
    
    if ( delayregentime )
    {
        thread playerhealth::forcehealthregendelay( player, 1, delayregentime, regenspeedmod );
    }
}

// Namespace health_chunks
// Params 0
// Checksum 0x7c0f62ee, Offset: 0x1230
// Size: 0x34
function function_a15bcfad6a17f80a()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( self.health <= 0 )
    {
        waitframe();
    }
    
    function_9834bbf38e7cf81( self );
}

// Namespace health_chunks
// Params 1
// Checksum 0xd84dac4b, Offset: 0x126c
// Size: 0x2c2
function function_9834bbf38e7cf81( player )
{
    if ( !isenabled() || player.var_144ad4a5bcb22c3 )
    {
        return;
    }
    
    var_ea61168db1da069a = player.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe;
    player.var_ada44f3dab2c1d1 = structcopy( level.var_ada44f3dab2c1d1, 1 );
    player.var_ada44f3dab2c1d1.basemaxhealth = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
    player.var_ada44f3dab2c1d1.var_80b254869e7b4523 = player.var_ada44f3dab2c1d1.chunks.size;
    
    if ( !isdefined( player.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe ) )
    {
        player.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe = var_ea61168db1da069a;
    }
    
    if ( isdefined( player.var_bb2bb54de2aff00d ) )
    {
        remainder = player.var_ada44f3dab2c1d1.var_80b254869e7b4523 - player.var_bb2bb54de2aff00d;
        var_ae449c96409c3915 = int( ceil( remainder ) );
        
        for ( i = 0; i < var_ae449c96409c3915 ; i++ )
        {
            removechunk( player );
        }
        
        incrementamount = var_ae449c96409c3915 - remainder;
        
        if ( incrementamount > 0 )
        {
            var_e0b4c337dc70987b = player.var_ada44f3dab2c1d1.basemaxhealth / player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
            incrementchunks( player, incrementamount * var_e0b4c337dc70987b, undefined, 1 );
        }
        
        player.var_bb2bb54de2aff00d = undefined;
    }
    
    function_bef3c19887444a9e( { #victim:player } );
    function_4a767a18ab106419( player );
    function_4c2e0e145365c407( player );
    teamarray = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in teamarray )
    {
        function_4a767a18ab106419( teammate );
    }
    
    player callback::add( #"player_damaged", &function_bef3c19887444a9e );
    player callback::add( #"player_death", &onplayerdeath );
    player callback::add( #"player_laststand_revived", &function_347827301cfd39fb );
    player.var_144ad4a5bcb22c3 = 1;
}

// Namespace health_chunks
// Params 1
// Checksum 0x1c227d85, Offset: 0x1536
// Size: 0x1f5
function function_137ee85a17945df0( player )
{
    if ( !isenabled() || !player.var_144ad4a5bcb22c3 )
    {
        return;
    }
    
    chunks = function_c3c38bc991ec9e76( player );
    var_e0b4c337dc70987b = player.var_ada44f3dab2c1d1.basemaxhealth / player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
    var_bb2bb54de2aff00d = 0;
    
    foreach ( chunk in chunks )
    {
        var_bb2bb54de2aff00d += chunk / var_e0b4c337dc70987b;
    }
    
    function_71612586498c2ca9( player, 0 );
    player.var_bb2bb54de2aff00d = var_bb2bb54de2aff00d;
    numchunks = player.var_ada44f3dab2c1d1.chunks.size;
    
    for ( i = 0; i < numchunks ; i++ )
    {
        removechunk( player, 0, 1, 1 );
    }
    
    player.var_fa68c3662d6e7eb6 = 1;
    player.laststandrevivehealth = int( player.var_ada44f3dab2c1d1.basemaxhealth );
    function_4a767a18ab106419( player );
    player.var_b487d47112fa93d = level.var_b487d47112fa93d;
    player callback::remove( #"player_damaged", &function_bef3c19887444a9e );
    player callback::remove( #"player_death", &onplayerdeath );
    player callback::remove( #"player_laststand_revived", &function_347827301cfd39fb );
    player.var_144ad4a5bcb22c3 = undefined;
    player thread function_eccfa657c586c520();
}

// Namespace health_chunks
// Params 0
// Checksum 0x3743e131, Offset: 0x1733
// Size: 0x100, Type: bool
function function_4ff6cb509967e92()
{
    if ( getdvarint( @"hash_25f4a9a6b7e73eb", 0 ) == 1 )
    {
        lastalive = 1;
        
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( !player || player == self )
            {
                continue;
            }
            
            if ( player::isreallyalive( player ) && !player::isinlaststand( player ) )
            {
                lastalive = 0;
                break;
            }
        }
        
        if ( lastalive )
        {
            return true;
        }
    }
    
    return function_9cb515de902172b5( self ) && function_255a24e5a52f09ee( self ) && laststand::function_7072b516e6cffb7c() <= 0 && !self.var_5f87feddcabb8ed;
}

// Namespace health_chunks
// Params 0
// Checksum 0xcde0b899, Offset: 0x183c
// Size: 0x5e
function isenabled()
{
    if ( !isdefined( level.gametypebundle ) )
    {
        assertmsg( "<dev string:xc3>" );
        return 0;
    }
    
    if ( !isdefined( level.var_1ce5d99a2c8dc93d ) )
    {
        level.var_1ce5d99a2c8dc93d = getdvarint( @"hash_7b20cc1ddb5f95be", istrue( level.gametypebundle.var_144ad4a5bcb22c3 ) );
    }
    
    return level.var_1ce5d99a2c8dc93d;
}

// Namespace health_chunks
// Params 2
// Checksum 0x91291282, Offset: 0x18a3
// Size: 0xff
function function_25ead0a9f0bc6eae( player, var_ea0905e104e60360 )
{
    if ( !isenabled() || !function_9cb515de902172b5( player ) || !isdefined( var_ea0905e104e60360 ) )
    {
        return;
    }
    
    lowerbounds = 0;
    chunkindex = 0;
    
    for ( i = 0; i < player.var_ada44f3dab2c1d1.chunks.size ; i++ )
    {
        chunk = player.var_ada44f3dab2c1d1.chunks[ i ];
        upperbounds = chunk + lowerbounds;
        chunkindex = i;
        
        if ( i == var_ea0905e104e60360 )
        {
            break;
        }
        
        lowerbounds = upperbounds;
    }
    
    return { #upperbounds:upperbounds, #lowerbounds:lowerbounds, #value:player.var_ada44f3dab2c1d1.chunks[ chunkindex ], #index:chunkindex };
}

// Namespace health_chunks
// Params 2
// Checksum 0x1c20af1, Offset: 0x19ab
// Size: 0x101
function function_4c2e0e145365c407( player, var_4807de00aa3e9293 )
{
    currentchunk = function_592f3ae4a5ba7280( player );
    numchunks = var_4807de00aa3e9293 ? player.var_ada44f3dab2c1d1.chunks.size + 1 : player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
    chunkmax = player.var_ada44f3dab2c1d1.basemaxhealth / numchunks;
    var_e8f97552f52600ea = player.var_ada44f3dab2c1d1.chunks.size == player.var_ada44f3dab2c1d1.var_80b254869e7b4523 && chunkmax == currentchunk.value;
    
    if ( var_e8f97552f52600ea )
    {
        player.var_b487d47112fa93d = level.var_b487d47112fa93d;
        return;
    }
    
    player.var_b487d47112fa93d = 1;
}

// Namespace health_chunks
// Params 1
// Checksum 0xbb3af77f, Offset: 0x1ab4
// Size: 0x106
function function_592f3ae4a5ba7280( player )
{
    if ( !isenabled() || !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    lowerbounds = 0;
    chunkindex = 0;
    
    for ( i = 0; i < player.var_ada44f3dab2c1d1.chunks.size ; i++ )
    {
        chunk = player.var_ada44f3dab2c1d1.chunks[ i ];
        upperbounds = chunk + lowerbounds;
        chunkindex = i;
        
        if ( i == player.var_ada44f3dab2c1d1.chunks.size - 1 )
        {
            break;
        }
        
        lowerbounds = upperbounds;
    }
    
    return { #upperbounds:upperbounds, #lowerbounds:lowerbounds, #value:player.var_ada44f3dab2c1d1.chunks[ chunkindex ], #index:chunkindex };
}

// Namespace health_chunks
// Params 1
// Checksum 0xf53c7d67, Offset: 0x1bc3
// Size: 0x4e, Type: bool
function function_9cb515de902172b5( player )
{
    return isenabled() && isdefined( player ) && isdefined( player.var_ada44f3dab2c1d1.chunks ) && player.var_ada44f3dab2c1d1.chunks.size > 0;
}

// Namespace health_chunks
// Params 1
// Checksum 0x38a1be5a, Offset: 0x1c1a
// Size: 0x39
function function_c3c38bc991ec9e76( player )
{
    if ( !isenabled() || !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    return player.var_ada44f3dab2c1d1.chunks;
}

// Namespace health_chunks
// Params 1
// Checksum 0x1faeb648, Offset: 0x1c5c
// Size: 0x4e, Type: bool
function function_255a24e5a52f09ee( player )
{
    if ( isdefined( player.perks[ "specialty_trait_chunk_revive" ] ) )
    {
        return ( player.downedchunks && player.downedchunks > function_4a0c302bed016180( player ) );
    }
    
    return !player function_57d7450ef7a9c202();
}

// Namespace health_chunks
// Params 1
// Checksum 0xd668c950, Offset: 0x1cb3
// Size: 0x6d
function function_4a0c302bed016180( player )
{
    if ( !isenabled() || !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    if ( isdefined( player.perks[ "specialty_trait_chunk_revive" ] ) )
    {
        return int( max( 1, level.var_ada44f3dab2c1d1.var_cc4d38df641935b8 - 1 ) );
    }
    
    return level.var_ada44f3dab2c1d1.var_cc4d38df641935b8;
}

// Namespace health_chunks
// Params 1
// Checksum 0xd572059d, Offset: 0x1d29
// Size: 0xf9, Type: bool
function function_57d7450ef7a9c202( var_f35e2da8afa7a404 )
{
    if ( !isdefined( self ) || !isenabled() || !function_9cb515de902172b5( self ) )
    {
        return false;
    }
    
    if ( !self.var_144ad4a5bcb22c3 && self.var_bb2bb54de2aff00d )
    {
        if ( var_f35e2da8afa7a404 )
        {
            return true;
        }
        
        return ( self.var_bb2bb54de2aff00d < self.var_ada44f3dab2c1d1.var_80b254869e7b4523 );
    }
    
    if ( self.var_ada44f3dab2c1d1.chunks.size < self.var_ada44f3dab2c1d1.var_80b254869e7b4523 )
    {
        return true;
    }
    
    currentchunk = function_592f3ae4a5ba7280( self );
    var_e0b4c337dc70987b = self.var_ada44f3dab2c1d1.basemaxhealth / self.var_ada44f3dab2c1d1.var_80b254869e7b4523;
    
    if ( isdefined( currentchunk ) && var_e0b4c337dc70987b > currentchunk.value )
    {
        return true;
    }
    
    return false;
}

// Namespace health_chunks
// Params 1
// Checksum 0x8b52223, Offset: 0x1e2b
// Size: 0x28b
function function_4a767a18ab106419( player )
{
    if ( !isenabled() || !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    squadindex = player.sessionuimemberindex;
    
    if ( squadindex == -1 )
    {
        return;
    }
    
    var_3405ba93a4f50aac = 0;
    
    for ( i = 0; i < player.var_ada44f3dab2c1d1.chunks.size ; i++ )
    {
        chunk = player.var_ada44f3dab2c1d1.chunks[ i ];
        chunk = int( max( level.var_ada44f3dab2c1d1.var_7021b0793d8622f0, chunk ) );
        var_cd5a5c65205109c4 = int( round( chunk * 100 / player.var_ada44f3dab2c1d1.basemaxhealth ) ) << i * 7 + 3;
        var_3405ba93a4f50aac += var_cd5a5c65205109c4;
    }
    
    var_931d59fcd3f0f763 = 0;
    
    if ( isdefined( player.var_bb2bb54de2aff00d ) )
    {
        var_e0b4c337dc70987b = player.var_ada44f3dab2c1d1.basemaxhealth / player.var_ada44f3dab2c1d1.var_80b254869e7b4523;
        lowvalue = int( ceil( player.var_bb2bb54de2aff00d * var_e0b4c337dc70987b ) );
        highvalue = int( min( player.var_ada44f3dab2c1d1.basemaxhealth, ceil( player.var_fa68c3662d6e7eb6 * player.var_ada44f3dab2c1d1.basemaxhealth ) ) );
        var_931d59fcd3f0f763 += lowvalue;
        var_931d59fcd3f0f763 += highvalue << 8;
    }
    
    var_3405ba93a4f50aac += player.var_ada44f3dab2c1d1.chunks.size;
    teamarray = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in teamarray )
    {
        teammate setclientomnvar( "ui_health_chunk_squad_temp_health_" + squadindex, int( var_931d59fcd3f0f763 ) );
        teammate setclientomnvar( "ui_health_chunk_squad_index_" + squadindex, var_3405ba93a4f50aac );
    }
}

// Namespace health_chunks
// Params 0, eflags: 0x4
// Checksum 0xdee24349, Offset: 0x20be
// Size: 0x401
function private function_adef98b3d83c4fd9()
{
    level.var_ada44f3dab2c1d1 = spawnstruct();
    var_43aa1bf136f632c3 = level.gametypebundle.var_7b14baf188eb576a ?? 3;
    level.var_ada44f3dab2c1d1.var_7b14baf188eb576a = getdvarint( @"hash_32af95361b7623ab", var_43aa1bf136f632c3 );
    var_7021b0793d8622f0 = level.gametypebundle.var_7021b0793d8622f0 ?? 0.1;
    level.var_ada44f3dab2c1d1.var_7021b0793d8622f0 = getdvarfloat( @"hash_3412b1b42f7f8440", var_7021b0793d8622f0 );
    var_e85d32d156d1f971 = level.gametypebundle.var_c67aa7293547f375 ?? 0;
    level.var_ada44f3dab2c1d1.var_e85d32d156d1f971 = getdvarint( @"hash_88d46b43f0e38d84", var_e85d32d156d1f971 );
    level.var_ada44f3dab2c1d1.var_cc4d38df641935b8 = getdvarint( @"hash_5965d417556d13ea", level.gametypebundle.var_cc4d38df641935b8 ?? 2 );
    level.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe = getdvarint( @"hash_79544b7e94058612", level.gametypebundle.var_8a0341f71fc5bcfe ?? 1 );
    var_b842b7bbd310d861 = [];
    var_a9f462baa41f8a49 = getdvar( @"hash_2035c64109179c97", "" );
    
    if ( var_a9f462baa41f8a49 != "" )
    {
        var_78ad6e60632e747 = strtok( var_a9f462baa41f8a49, "," );
        
        foreach ( percent in var_78ad6e60632e747 )
        {
            var_b842b7bbd310d861[ var_b842b7bbd310d861.size ] = float( percent );
        }
    }
    else if ( level.var_ada44f3dab2c1d1.var_e85d32d156d1f971 && isdefined( level.gametypebundle.var_b842b7bbd310d861 ) )
    {
        foreach ( percent in level.gametypebundle.var_b842b7bbd310d861 )
        {
            var_b842b7bbd310d861[ var_b842b7bbd310d861.size ] = percent.chunkpercent;
        }
    }
    else
    {
        total = 0;
        maxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
        
        for ( i = 0; i < level.var_ada44f3dab2c1d1.var_7b14baf188eb576a ; i++ )
        {
            var_b842b7bbd310d861[ i ] = 1 / level.var_ada44f3dab2c1d1.var_7b14baf188eb576a;
            total += var_b842b7bbd310d861[ i ];
            
            if ( i == level.var_ada44f3dab2c1d1.var_7b14baf188eb576a - 1 && total < 1 )
            {
                var_b842b7bbd310d861[ i ] += 1 - total;
            }
        }
    }
    
    chunks = [];
    
    foreach ( percent in var_b842b7bbd310d861 )
    {
        maxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
        chunks[ chunks.size ] = maxhealth * percent;
    }
    
    level.var_ada44f3dab2c1d1.chunks = chunks;
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0x8f77f767, Offset: 0x24c7
// Size: 0x13
function private onplayerconnect( params )
{
    thread function_a15bcfad6a17f80a();
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0xf271f256, Offset: 0x24e2
// Size: 0x44
function private function_dd6a63500fbab2ef( params )
{
    if ( function_9cb515de902172b5( self ) )
    {
        self.downedchunks = function_c3c38bc991ec9e76( self ).size;
    }
    
    if ( hasomnvar( "ui_health_chunk_can_revive" ) )
    {
        self setclientomnvar( "ui_health_chunk_can_revive", function_4ff6cb509967e92() );
    }
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0x1fa283c1, Offset: 0x252e
// Size: 0x13
function private function_96242a62a02bf92( params )
{
    thread function_2b9c14e3d0d68ec2();
}

// Namespace health_chunks
// Params 0, eflags: 0xc
// Checksum 0xd637e182, Offset: 0x2549
// Size: 0x12f
function private function_2b9c14e3d0d68ec2()
{
    self notify( #"hash_de66c29841a928c4" );
    self endon( #"hash_de66c29841a928c4" );
    
    if ( !level.gametypebundle.var_37f327b9bd27dfbc || !quickprompt::quickpromptisenabled() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 1;
    
    while ( function_57d7450ef7a9c202() )
    {
        if ( !quickprompt::function_106bde9d618791e9() && !quickprompt::function_bb66d5fa916ff9d1( level.gametypebundle.var_37f327b9bd27dfbc ) && !self.var_c1e5365cb212a166 )
        {
            if ( namespace_c96d31a1521582c1::isenabled() )
            {
                var_2e9c5a5d341dbdde = namespace_c96d31a1521582c1::function_f4cd8a1ae549f98c( "DEFAULT" );
                
                if ( !namespace_c96d31a1521582c1::function_28b589a4d7479415( var_2e9c5a5d341dbdde ) )
                {
                    thread quickprompt::quickpromptshow( level.gametypebundle.var_37f327b9bd27dfbc, 9999 );
                }
            }
            else
            {
                thread quickprompt::quickpromptshow( level.gametypebundle.var_37f327b9bd27dfbc, 9999 );
            }
        }
        
        wait 1;
    }
    
    if ( quickprompt::function_bb66d5fa916ff9d1( level.gametypebundle.var_37f327b9bd27dfbc ) )
    {
        quickprompt::quickpromptcancel();
    }
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0x89e9c8cb, Offset: 0x2680
// Size: 0x134
function private function_bef3c19887444a9e( params )
{
    damagedplayer = params.victim;
    
    if ( !isenabled() || !function_9cb515de902172b5( damagedplayer ) )
    {
        return;
    }
    
    var_fa68c3662d6e7eb6 = 1;
    currentchunk = function_592f3ae4a5ba7280( damagedplayer );
    chunkoverride = function_1cab09f68af0b65f( damagedplayer );
    var_f31dc476fb021d68 = currentchunk.index <= chunkoverride;
    upperbounds = var_f31dc476fb021d68 ? function_25ead0a9f0bc6eae( damagedplayer, chunkoverride ).upperbounds : currentchunk.upperbounds;
    var_fa68c3662d6e7eb6 = upperbounds / damagedplayer.maxhealth;
    damagedplayer.var_fa68c3662d6e7eb6 = min( 1, var_fa68c3662d6e7eb6 );
    damagedplayer.laststandrevivehealth = int( upperbounds );
    damagedplayer playerhealth::updatedeathsdoor();
    damagedplayer playerhealth::function_422b3e88b85c7745();
    
    if ( damagedplayer function_57d7450ef7a9c202() )
    {
        if ( !damagedplayer function_7ac90c4f2a92dfa0() )
        {
            damagedplayer function_b1088edb45ba7b9( "healthchunks", 1 );
        }
        
        return;
    }
    
    damagedplayer thread function_eccfa657c586c520();
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0x5da33875, Offset: 0x27bc
// Size: 0x2b
function private function_347827301cfd39fb( params )
{
    if ( params.reason != "health_chunk_revive" )
    {
        return;
    }
    
    function_e55b91d06dff5213( self, 2 );
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0xa24bf61c, Offset: 0x27ef
// Size: 0x31
function private onplayerdeath( params )
{
    function_e55b91d06dff5213( params.victim, level.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe );
}

// Namespace health_chunks
// Params 2, eflags: 0x4
// Checksum 0x5c127a34, Offset: 0x2828
// Size: 0xb6
function private function_e55b91d06dff5213( player, var_f16843371539b004 )
{
    if ( !isenabled() || !function_9cb515de902172b5( player ) )
    {
        return;
    }
    
    if ( player.freerevives > player.usedrevives )
    {
        player.usedrevives += 1;
        return;
    }
    
    for ( i = 0; i < function_4a0c302bed016180( player ) ; i++ )
    {
        if ( ( var_f16843371539b004 ?? player.var_ada44f3dab2c1d1.var_8a0341f71fc5bcfe ) >= function_c3c38bc991ec9e76( player ).size )
        {
            break;
        }
        
        removechunk( player );
    }
}

// Namespace health_chunks
// Params 1, eflags: 0x4
// Checksum 0x5d47c663, Offset: 0x28e6
// Size: 0x51
function private function_1cab09f68af0b65f( player )
{
    if ( !( isdefined( player ) && isdefined( player.var_3ad3616d2f05e453 ) && isdefined( player.var_3ad3616d2f05e453.highestindex ) ) )
    {
        return;
    }
    
    return player.var_3ad3616d2f05e453.highestindex;
}

/#

    // Namespace health_chunks
    // Params 2, eflags: 0x4
    // Checksum 0x9948b791, Offset: 0x2940
    // Size: 0x764, Type: dev
    function private function_adc7fbe77ad652cc( command, args )
    {
        player = level.players[ 0 ];
        players = !isdefined( args[ 0 ] ) ? [ level.players[ 0 ] ] : level.players;
        
        switch ( command )
        {
            case #"hash_166726e57186ebc6":
                foreach ( player in players )
                {
                    if ( !function_9cb515de902172b5( player ) )
                    {
                        continue;
                    }
                    
                    health = isdefined( args[ 0 ] ) ? int( args[ 0 ] ) : undefined;
                    samemaxhealth = isdefined( args[ 1 ] ) ? int( args[ 1 ] ) : undefined;
                    addchunk( player, health, samemaxhealth );
                }
                
                break;
            case #"hash_21257d21f25af377":
                foreach ( player in players )
                {
                    if ( !function_9cb515de902172b5( player ) )
                    {
                        continue;
                    }
                    
                    addchunk( player, undefined, 1 );
                }
                
                break;
            case #"hash_3cff177043073233":
                foreach ( player in players )
                {
                    if ( !function_9cb515de902172b5( player ) )
                    {
                        continue;
                    }
                    
                    index = isdefined( args[ 0 ] ) ? int( args[ 0 ] ) : undefined;
                    samemaxhealth = isdefined( args[ 1 ] ) ? int( args[ 1 ] ) : undefined;
                    removechunk( player, index, samemaxhealth );
                }
                
                break;
            case #"hash_b74d9f23769b7d46":
                foreach ( player in players )
                {
                    if ( !function_9cb515de902172b5( player ) )
                    {
                        continue;
                    }
                    
                    removechunk( player, undefined, 1 );
                }
                
                break;
            case #"hash_5be4424ef51596f9":
                foreach ( player in players )
                {
                    if ( !function_9cb515de902172b5( player ) )
                    {
                        continue;
                    }
                    
                    health = isdefined( args[ 0 ] ) ? int( args[ 0 ] ) : undefined;
                    samemaxhealth = isdefined( args[ 1 ] ) ? int( args[ 1 ] ) : undefined;
                    index = isdefined( args[ 2 ] ) ? int( args[ 2 ] ) : undefined;
                    modifychunk( player, health, samemaxhealth, index );
                }
                
                break;
            case #"hash_f4ed3ebe59831318":
                foreach ( player in players )
                {
                    if ( function_9cb515de902172b5( player ) )
                    {
                        function_137ee85a17945df0( player );
                        continue;
                    }
                    
                    function_9834bbf38e7cf81( player );
                }
                
                break;
            case #"hash_a7d942464a1f5bdc":
                if ( !isdefined( args ) )
                {
                    break;
                }
                
                damage = int( args[ 0 ] );
                
                foreach ( player in level.players )
                {
                    player dodamage( damage, player.origin, player, player );
                    iprintln( player.name + "<dev string:x18e>" + player.health );
                }
                
                break;
            case #"hash_7f59b41c85600641":
                if ( !isdefined( args ) )
                {
                    break;
                }
                
                level.healthregendelay = int( args[ 0 ] );
                break;
            case #"hash_9ff8b284fc5e6dce":
                foreach ( player in players )
                {
                    playerhealth::forcehealthregen( player );
                }
                
                break;
            case #"hash_81f125054f721d58":
                if ( !isdefined( args[ 1 ] ) )
                {
                    break;
                }
                
                foreach ( player in players )
                {
                    player.maxhealth = int( args[ 1 ] );
                }
                
                break;
            case #"hash_a54e249514daf30f":
                foreach ( player in players )
                {
                    var_70b7a1d6695bc8e5 = isdefined( args[ 1 ] ) ? int( args[ 1 ] ) : 1;
                    restorechunks( player, var_70b7a1d6695bc8e5, 1 );
                }
                
                break;
            case #"hash_bb36e77911d4827b":
                foreach ( player in players )
                {
                    function_71612586498c2ca9( player, 1 );
                }
                
                break;
            default:
                break;
        }
    }

#/
