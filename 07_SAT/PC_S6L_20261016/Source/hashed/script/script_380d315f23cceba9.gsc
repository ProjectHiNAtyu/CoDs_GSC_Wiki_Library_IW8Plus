// script_380d315f23cceba9  (hash_380d315f23cceba9.gscc) (size: 4919 Bytes / 0x1337 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8df361c3 (2381537731)
// size ...... 4919 (0x1337)
// includes .. 3   (offset: 0x1233)
// strings ... 6   (offset: 0x124b)
// dev strs .. 13  (offset: 0x129b)
// exports ... 12  (offset: 0xabb)
// cseg ...... 0x12d + 0x98e (0xabb)
// imports ... 48  (offset: 0xc9b)
// animtree1 . 0   (offset: 0x1337)
// animtree2 . 0   (offset: 0x1337)
#using scripts\asm\asm;
#using scripts\common\cap;
#using scripts\common\utility;

#namespace ai_combat_basic_move;

// Namespace ai_combat_basic_move
// Params 1
// Checksum 0x7d8da6ec, Offset: 0x14b
// Size: 0xb6
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_e0740123af2138d0":
            return &doresumepath;
        case #"hash_ef0e635a1138ba71":
            return &startcommcap;
        case #"hash_41da787f02441998":
            return &respondtocommand;
        case #"hash_afbed9970f0239a":
            return &startcoverfire;
        case #"hash_b4fe90457feff88d":
            return &endcoverfire;
        case #"hash_e8b87266a141a68c":
            return &IsBSeqUserCountLow;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace ai_combat_basic_move
// Params 1
// Checksum 0x9b4178f8, Offset: 0x209
// Size: 0xc8
function onuserinit( interactionid )
{
    if ( !isdefined( self.var_4de221b5ce19cf3c ) )
    {
        self.var_4de221b5ce19cf3c = 0;
    }
    
    if ( !isdefined( level.bseq ) )
    {
        level.bseq = spawnstruct();
    }
    
    if ( !isdefined( level.bseq.instancedata ) )
    {
        level.bseq.instancedata = [];
    }
    
    if ( !isdefined( level.bseq.instancedata[ interactionid ] ) )
    {
        level.bseq.instancedata[ interactionid ] = spawnstruct();
    }
    
    level.bseq.instancedata[ interactionid ].var_d87e49671bafa172 = 0;
    self clearpath();
    self pausepath();
}

// Namespace ai_combat_basic_move
// Params 1
// Checksum 0x3b92a893, Offset: 0x2d9
// Size: 0x6e
function onuserterminate( interactionid )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    utility::delaythread( 5, &function_7468b381715d58fe );
    self._blackboard.bseqphase = undefined;
    self resumepath();
    users = getbsequsers( interactionid );
    
    if ( users.size == 1 )
    {
        level.bseq.instancedata[ interactionid ] = undefined;
    }
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0x39c40fbc, Offset: 0x34f
// Size: 0x2b
function function_7468b381715d58fe( statename, params )
{
    self endon( #"death" );
    self.var_841c6270cd42c72f = 0;
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0xe018c5f3, Offset: 0x382
// Size: 0x270
function startcommcap( statename, params )
{
    if ( gettime() < self.var_7d48f0dd993e6221 )
    {
        return;
    }
    
    if ( isanimscripted( self ) || self isintraverse() )
    {
        return;
    }
    
    if ( self.doinglongdeath || self.a.painplaying )
    {
        return;
    }
    
    interactionid = self getinteractionid();
    users = getbsequsers( interactionid );
    squadid = function_8398629a6c526ce3( self );
    
    if ( !squadid )
    {
        return;
    }
    
    squadmembers = aigetsquadmembers( squadid );
    
    if ( users.size < 2 )
    {
        return;
    }
    
    if ( !squadmembers )
    {
        return;
    }
    
    var_8bdba99ed23d3ab9 = self getgoalpos();
    var_406493d02e9b5ea2 = distancesquared( self.origin, var_8bdba99ed23d3ab9 );
    
    if ( var_406493d02e9b5ea2 >= 57600 && users.size * 2 >= squadmembers.size )
    {
        self.var_7d48f0dd993e6221 = gettime() + 5000;
        capinfo = getcapinfoforrole( self, "leader" );
        level.bseq.instancedata[ interactionid ].var_1bc6a584e02d6e98 = var_8bdba99ed23d3ab9;
        level.bseq.instancedata[ interactionid ].movedir = function_521b5a0a07a246a8( interactionid, "movedir" );
        cap::cap_start( capinfo.capname, capinfo.animation );
        level.bseq.instancedata[ interactionid ].var_d87e49671bafa172 = 1;
        
        if ( getdvarint( @"hash_418cd3e3dce1f292", 0 ) == 1 )
        {
            /#
                lines = [ "<dev string:x42>", "<dev string:x4f>", "<dev string:x5b>", "<dev string:x67>", "<dev string:x75>" ];
                
                if ( !isdefined( self.var_b6e1979f5406f630 ) )
                {
                    self.var_b6e1979f5406f630 = utility::create_deck( lines );
                }
                
                speechline = self.var_b6e1979f5406f630 utility::deck_draw();
                linecolor = ( 0.5, 0.1, 0.5 );
                print3d( self.origin + ( 0, 0, 48 ), speechline, linecolor, 1, 1, 60 );
            #/
        }
    }
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0x59fec6bd, Offset: 0x5fa
// Size: 0x138
function respondtocommand( statename, params )
{
    interactionid = self getinteractionid();
    var_8bdba99ed23d3ab9 = self getgoalpos();
    
    if ( distancesquared( self.origin, var_8bdba99ed23d3ab9 ) >= 57600 && level.bseq.instancedata[ interactionid ].var_d87e49671bafa172 )
    {
        if ( getdvarint( @"hash_418cd3e3dce1f292", 0 ) == 1 )
        {
            /#
                lines = [ "<dev string:x81>", "<dev string:x87>", "<dev string:x8e>", "<dev string:x9c>", "<dev string:xa4>" ];
                
                if ( !isdefined( level.var_65bba5113b850f9b ) )
                {
                    level.var_65bba5113b850f9b = utility::create_deck( lines );
                }
                
                speechline = level.var_65bba5113b850f9b utility::deck_draw();
                linecolor = ( 0.5, 0.5, 0.1 );
                print3d( self.origin + ( 0, 0, 48 ), speechline, linecolor, 1, 0.66, 60 );
            #/
        }
    }
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0x9ada6128, Offset: 0x73a
// Size: 0x140
function startcoverfire( statename, params )
{
    self endon( #"death" );
    
    if ( utility::issharedfuncdefined( #"hash_296cc93ec4ed507f", #"tokens_issystemactive" ) )
    {
        if ( isdefined( self.team ) )
        {
            var_802d7e487180a4bb = -1;
            var_802d7e487180a4bb = function_a29d1a64cdf10332( self.team, getxhashasset( "ai_token_type:shoot" ) );
            
            if ( var_802d7e487180a4bb != -1 )
            {
                function_e0e6c83506a5c833( var_802d7e487180a4bb, [ self ] );
            }
        }
    }
    
    self.bulletsinclip = weaponclipsize( self.weapon );
    self function_ea6f0992b9ae05c8( 10, 10 );
    self.var_fccfc00935827567 = 0;
    self.balwayscoverexposed = 1;
    self.providecoveringfire = 1;
    self.shootstyleoverride = "full";
    self function_a83f7fcb7b07947b( "ads" );
    
    /#
        if ( getdvarint( @"hash_a688c590b60b2552", 0 ) >= 1 )
        {
            linecolor = ( 0.5, 0.1, 0.5 );
            print3d( self.origin + ( 0, 0, 48 ), "<dev string:xbe>", linecolor, 1, 1, 15 );
        }
    #/
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0xe83cdeee, Offset: 0x882
// Size: 0x10c
function endcoverfire( statename, params )
{
    self endon( #"death" );
    
    if ( utility::issharedfuncdefined( #"hash_296cc93ec4ed507f", #"tokens_issystemactive" ) )
    {
        if ( isdefined( self.team ) )
        {
            var_802d7e487180a4bb = -1;
            var_802d7e487180a4bb = function_a29d1a64cdf10332( self.team, getxhashasset( "ai_token_type:shoot" ) );
            
            if ( var_802d7e487180a4bb != -1 )
            {
                function_7f54cda22572b610( var_802d7e487180a4bb, [ self ] );
            }
        }
    }
    
    self function_1ff5561221ab5783();
    self.balwayscoverexposed = 0;
    self.providecoveringfire = 0;
    self.shootstyleoverride = undefined;
    self function_a83f7fcb7b07947b( undefined );
    
    /#
        if ( getdvarint( @"hash_a688c590b60b2552", 0 ) >= 1 )
        {
            linecolor = ( 0.5, 0.1, 0.5 );
            print3d( self.origin + ( 0, 0, 48 ), "<dev string:xd1>", linecolor, 1, 1, 15 );
        }
    #/
}

// Namespace ai_combat_basic_move
// Params 1
// Checksum 0x34dc86f4, Offset: 0x996
// Size: 0x3a, Type: bool
function IsBSeqUserCountLow( statename )
{
    interactionid = self getinteractionid();
    users = getbsequsers( interactionid );
    
    if ( users.size < 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0xb5babab6, Offset: 0x9d9
// Size: 0x4c
function doresumepath( statename, params )
{
    self resumepath();
    
    if ( self function_2e50bdd9495d2b8c() != "coverfire" && self function_2e50bdd9495d2b8c() != "leader" || self issuppressed() )
    {
        self.var_841c6270cd42c72f = 1;
    }
}

// Namespace ai_combat_basic_move
// Params 2
// Checksum 0x4835c9d4, Offset: 0xa2d
// Size: 0x8d
function function_23209c5b6405bd72( statename, params )
{
    goalpos = self getgoalpos();
    targetangles = vectortoangles( goalpos - self.origin );
    targetyaw = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
    aliasname = asm::yawdiffto2468( targetyaw );
    animresult = archetypegetrandomalias( self.animsetname, statename, aliasname );
    return animresult;
}

