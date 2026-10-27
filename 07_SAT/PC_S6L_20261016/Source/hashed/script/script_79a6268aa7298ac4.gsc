// script_79a6268aa7298ac4  (hash_79a6268aa7298ac4.gscc) (size: 4013 Bytes / 0xfad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x102ceeb9 (271380153)
// size ...... 4013 (0xfad)
// includes .. 3   (offset: 0xe85)
// strings ... 21  (offset: 0xe9d)
// dev strs .. 0   (offset: 0xfad)
// exports ... 5   (offset: 0xaad)
// cseg ...... 0x1a1 + 0x90c (0xaad)
// imports ... 26  (offset: 0xb75)
// animtree1 . 0   (offset: 0xfad)
// animtree2 . 0   (offset: 0xfad)
#using script_3d2770dc09c1243;
#using scripts\common\trace;
#using scripts\mp\matchdata;

#namespace namespace_8fae7b668e6e3cb;

// Namespace namespace_8fae7b668e6e3cb
// Params 0
// Checksum 0x6ceb252c, Offset: 0x1bf
// Size: 0x5cd
function function_fff4014a6853e75a()
{
    var_a4fc878a1d7a27c5 = 1;
    var_5fcbfd57bec4a8a9 = 2;
    var_8739c6b2ec32ed4e = 3;
    var_b2d82a0696284508 = getdvarfloat( @"hash_7bf0de1b1d9ca208", 150 );
    var_c197b11d1d1ea6ca = getdvarfloat( @"hash_7748ba4302072dca", 150 );
    var_1b4c88e4250f8481 = getdvarfloat( @"hash_25616f5e79c1fb81", 230 );
    var_dc6210ff0f12e2a8 = 30;
    var_300bc58eef5827c5 = 0.9;
    var_61d2af02a63891ba = 30;
    var_c2e45a58bb8b6c1a = [];
    var_2546e259f63731c0 = function_3c48453182f1903d();
    
    for ( lastindex = var_2546e259f63731c0.size - 1; lastindex >= 1 ; lastindex-- )
    {
        var_af639b71f7002ba0 = var_2546e259f63731c0[ lastindex ];
        var_bb8c32378105ae5f = var_af639b71f7002ba0.centerposition;
        var_3c0a9ef3280695b6 = var_af639b71f7002ba0.orientation;
        
        for ( index = 0; index < lastindex ; index++ )
        {
            var_2746a57f80ac0a8 = var_2546e259f63731c0[ index ];
            var_3c224fa5511c46a7 = var_2746a57f80ac0a8.centerposition;
            var_86defc1dd43249be = var_2746a57f80ac0a8.orientation;
            
            if ( abs( var_bb8c32378105ae5f[ 2 ] - var_3c224fa5511c46a7[ 2 ] ) > var_dc6210ff0f12e2a8 )
            {
                continue;
            }
            
            var_7390dd61029b4d0d = undefined;
            dist = distance( var_bb8c32378105ae5f, var_3c224fa5511c46a7 );
            
            if ( abs( vectordot( var_3c0a9ef3280695b6, var_86defc1dd43249be ) ) >= var_300bc58eef5827c5 )
            {
                var_184c5aa42bf79793 = abs( vectordot( var_3c0a9ef3280695b6, var_3c224fa5511c46a7 - var_bb8c32378105ae5f ) );
                
                if ( var_184c5aa42bf79793 >= var_61d2af02a63891ba )
                {
                    if ( dist <= var_b2d82a0696284508 )
                    {
                        raycastresult = physics_raycast( var_bb8c32378105ae5f + ( 0, 0, 30 ), var_3c224fa5511c46a7 + ( 0, 0, 30 ), trace::create_default_contents(), undefined, 0, "physicsquery_all", 0, 1 );
                        raycastpassed = 1;
                        
                        foreach ( item in raycastresult )
                        {
                            if ( !isdefined( item[ "scriptable" ] ) || !( arraycontains( var_af639b71f7002ba0.doors, item[ "scriptable" ] ) || arraycontains( var_2746a57f80ac0a8.doors, item[ "scriptable" ] ) ) )
                            {
                                raycastpassed = 0;
                                break;
                            }
                        }
                        
                        if ( raycastpassed )
                        {
                            var_7390dd61029b4d0d = { #scores:[ var_184c5aa42bf79793 * -1 ], #type:var_a4fc878a1d7a27c5 };
                        }
                    }
                }
                else if ( dist <= var_c197b11d1d1ea6ca )
                {
                    var_7390dd61029b4d0d = { #scores:[ var_184c5aa42bf79793 * -1 ], #type:var_5fcbfd57bec4a8a9 };
                }
            }
            else if ( dist <= var_1b4c88e4250f8481 )
            {
                var_7390dd61029b4d0d = { #type:var_8739c6b2ec32ed4e };
            }
            
            if ( isdefined( var_7390dd61029b4d0d ) )
            {
                var_7390dd61029b4d0d.pairs = [ var_af639b71f7002ba0, var_2746a57f80ac0a8 ];
                
                if ( !isdefined( var_7390dd61029b4d0d.scores ) )
                {
                    var_7390dd61029b4d0d.scores = [];
                }
                
                arrayinsert( var_7390dd61029b4d0d.scores, dist * -1, 0 );
                var_7390dd61029b4d0d.distance = dist;
                var_c2e45a58bb8b6c1a[ var_c2e45a58bb8b6c1a.size ] = var_7390dd61029b4d0d;
            }
        }
    }
    
    var_c2e45a58bb8b6c1a = arraysort( var_c2e45a58bb8b6c1a, undefined, &function_8d9868b4bd692bac );
    typestrings = [];
    typestrings[ var_a4fc878a1d7a27c5 ] = "parallel";
    typestrings[ var_5fcbfd57bec4a8a9 ] = "collinear";
    typestrings[ var_8739c6b2ec32ed4e ] = "perpendicular";
    mit::outputlog( "AdjacentDoubleDoorsInfo", "#time; #type; #positions; #distance" );
    
    for ( index = 0; index < var_c2e45a58bb8b6c1a.size ; index++ )
    {
        var_7390dd61029b4d0d = var_c2e45a58bb8b6c1a[ index ];
        typestring = typestrings[ var_7390dd61029b4d0d.type ];
        dist = var_7390dd61029b4d0d.distance;
        pos1 = var_7390dd61029b4d0d.pairs[ 0 ].centerposition;
        pos2 = var_7390dd61029b4d0d.pairs[ 1 ].centerposition;
        reportstring = gettime() + "; " + typestring + "; " + pos1 + ", " + pos2 + "; " + dist;
        mit::outputlog( "AdjacentDoubleDoorsInfo", reportstring );
        var_64faf23c2e76181d = mit::function_655ffb35317b1edb( pos1, 3, [ -1, -1, -1 ] );
        var_bdaf1db1aba7f308 = mit::function_655ffb35317b1edb( pos2, 3, [ -1, -1, -1 ] );
        dlog_recordevent( "dlog_event_mit_adjacent_double_door", [ "time", matchdata::gettimefrommatchstart( gettime() ) ?? -1, "type", typestring ?? "", "position_1_x", var_64faf23c2e76181d[ 0 ] * 1, "position_1_y", var_64faf23c2e76181d[ 1 ] * 1, "position_1_z", var_64faf23c2e76181d[ 2 ] * 1, "position_2_x", var_bdaf1db1aba7f308[ 0 ] * 1, "position_2_y", var_bdaf1db1aba7f308[ 1 ] * 1, "position_2_z", var_bdaf1db1aba7f308[ 2 ] * 1, "distance", isnumber( dist ) ? dist : -1 ] );
    }
}

// Namespace namespace_8fae7b668e6e3cb
// Params 0, eflags: 0x4
// Checksum 0x9eaef052, Offset: 0x794
// Size: 0x177
function private function_3c48453182f1903d()
{
    var_2546e259f63731c0 = [];
    doubledoors = function_56f3835f67873d45();
    assert( doubledoors.size % 2 == 0 );
    lastindex = doubledoors.size - 1;
    
    while ( lastindex >= 1 )
    {
        onedoor = doubledoors[ lastindex ];
        var_81b45011d796a9f0 = onedoor function_50ddcb729a6c2820();
        targetindex = undefined;
        mindistsq = undefined;
        
        for ( index = 0; index < lastindex ; index++ )
        {
            doorpos = doubledoors[ index ] function_50ddcb729a6c2820();
            distsq = distancesquared( doorpos, var_81b45011d796a9f0 );
            
            if ( !isdefined( mindistsq ) || distsq < mindistsq )
            {
                mindistsq = distsq;
                targetindex = index;
            }
        }
        
        var_efcc801be4ef9609 = doubledoors[ targetindex ];
        
        if ( targetindex != lastindex - 1 )
        {
            doubledoors[ targetindex ] = doubledoors[ lastindex - 1 ];
        }
        
        pairsinfo = spawnstruct();
        pairsinfo.doors = [ onedoor, var_efcc801be4ef9609 ];
        var_e4532189409e8d1d = var_efcc801be4ef9609 function_50ddcb729a6c2820();
        pairsinfo.centerposition = ( var_81b45011d796a9f0 + var_e4532189409e8d1d ) / 2;
        pairsinfo.orientation = anglestoforward( onedoor.angles + ( 0, -90, 0 ) );
        var_2546e259f63731c0[ var_2546e259f63731c0.size ] = pairsinfo;
        lastindex -= 2;
    }
    
    return var_2546e259f63731c0;
}

// Namespace namespace_8fae7b668e6e3cb
// Params 0, eflags: 0x4
// Checksum 0xabf2fdf1, Offset: 0x914
// Size: 0x9f
function private function_56f3835f67873d45()
{
    doubledoors = [];
    doors = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "door" );
    
    foreach ( door in doors )
    {
        if ( door scriptabledoorisdouble() )
        {
            doubledoors[ doubledoors.size ] = door;
        }
    }
    
    return doubledoors;
}

// Namespace namespace_8fae7b668e6e3cb
// Params 2, eflags: 0x4
// Checksum 0x7f05ceaa, Offset: 0x9bc
// Size: 0xf0, Type: bool
function private function_8d9868b4bd692bac( lhs, rhs )
{
    assert( isdefined( lhs.type ) && isdefined( lhs.scores ) );
    
    if ( lhs.type != rhs.type )
    {
        return ( lhs.type < rhs.type );
    }
    
    assert( lhs.scores.size == rhs.scores.size );
    
    for ( i = 0; i < lhs.scores.size ; i++ )
    {
        if ( lhs.scores[ i ] != rhs.scores[ i ] )
        {
            return ( lhs.scores[ i ] > rhs.scores[ i ] );
        }
    }
    
    return true;
}

