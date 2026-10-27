// scripts\autotests\gscunittest\test_gscunittest_switch.gsc  (hash_29239f1da1d73c26.gscc) (size: 7756 Bytes / 0x1e4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbf0874 (197068916)
// size ...... 7756 (0x1e4c)
// includes .. 1   (offset: 0x1a70)
// strings ... 56  (offset: 0x1a78)
// dev strs .. 0   (offset: 0x1e4c)
// exports ... 17  (offset: 0x1484)
// cseg ...... 0x2ab + 0x11d9 (0x1484)
// imports ... 23  (offset: 0x172c)
// animtree1 . 0   (offset: 0x1e4c)
// animtree2 . 0   (offset: 0x1e4c)
#using scripts\autotests\autotests;

#namespace gscunittest_switch;

// Namespace gscunittest_switch
// Params 1
// Checksum 0xf5b2e156, Offset: 0x2c9
// Size: 0x72
function switch_numcases( c )
{
    result = -1;
    
    switch ( c )
    {
        case 0:
            result = 10;
            break;
        case 1:
            result = 11;
            break;
        case 2:
            result = 12;
            break;
        case 3:
            result = 13;
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0xcdc46881, Offset: 0x344
// Size: 0x97
function switch_strcases( c )
{
    result = "no";
    
    switch ( c )
    {
        case #"hash_31103fbc01bd840c":
            result = "ra";
            break;
        case #"hash_311042bc01bd88c5":
            result = "rb";
            break;
        case #"hash_311041bc01bd8732":
            result = "rc";
            break;
        case #"hash_31103cbc01bd7f53":
            result = "rd";
            break;
        case #"hash_7038dec66d8275be":
            result = "default";
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0x253c64f8, Offset: 0x3e4
// Size: 0x97
function switch_mixedcases( c )
{
    result = "no";
    
    switch ( c )
    {
        case #"hash_31103fbc01bd840c":
            result = "ma";
            break;
        case 0:
            result = "m0";
            break;
        case #"hash_311042bc01bd88c5":
            result = "mb";
            break;
        case #"hash_31100fbc01bd387c":
            result = "m1";
            break;
        default:
            result = "nope";
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0x69b55343, Offset: 0x484
// Size: 0xc4
function switch_skipcases( c )
{
    result = "";
    
    switch ( c )
    {
        case 0:
        case 1:
            result = "a";
            break;
        case 2:
        case 3:
            result = "b" + ( c % 2 ? "c" : "d" );
        case 4:
            result += "e";
            break;
        case 5:
        case 6:
        default:
            result = "f";
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0x6f1f0c66, Offset: 0x551
// Size: 0x91
function switch_combinecases( c )
{
    result = "";
    
    switch ( c )
    {
        case 0:
        case 1:
        case 2:
        case 3:
            result = "a";
            break;
        case 4:
        case 5:
        default:
            result = "b";
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0x14cb5432, Offset: 0x5eb
// Size: 0x51
function switch_combinecasesstr( c )
{
    result = -1;
    
    switch ( c )
    {
        case #"hash_bec7864bdc9acd1b":
        case #"hash_bec7874bdc9aceae":
        case #"hash_bec7884bdc9ad041":
            result = 1;
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0xeba4f43d, Offset: 0x645
// Size: 0x3f
function switch_singlecases( c )
{
    result = "";
    
    switch ( c )
    {
        default:
            result = "a";
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0x2edbde14, Offset: 0x68d
// Size: 0x39
function switch_singlecasesstr( c )
{
    result = -1;
    
    switch ( c )
    {
        case #"hash_bec7874bdc9aceae":
            result = 1;
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 0
// Checksum 0x8dcd4615, Offset: 0x6cf
// Size: 0x843
function switch_case()
{
    numcases = [ 2, 1, 4, 3, 0 ];
    numcasesresult = [ 12, 11, -1, 13, 10 ];
    
    foreach ( index, c in numcases )
    {
        x = switch_numcases( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_numCases: " + c, x, numcasesresult[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 176 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    strcases = [ "b", "a", "foo", "d", "c" ];
    strcasesresults = [ "rb", "ra", "no", "rd", "rc" ];
    
    foreach ( index, c in strcases )
    {
        x = switch_strcases( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_strCases: " + c, x, strcasesresults[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 185 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    mixedcases = [ "a", 2, 0, "foo", "b", 1 ];
    mixedcasesresult = [ "ma", "nope", "m0", "nope", "mb", "nope" ];
    
    foreach ( index, c in mixedcases )
    {
        x = switch_mixedcases( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_mixedCases: " + c, x, mixedcasesresult[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 194 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    skipcases = [ 0, 1, 2, 3, 4, 5, 6, 7, 8 ];
    skipcasesresults = [ "a", "a", "bde", "bce", "e", "f", "f", "f", "f" ];
    
    foreach ( index, c in skipcases )
    {
        x = switch_skipcases( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_skipCases: " + c, x, skipcasesresults[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 202 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    combinecases = [ 0, 1, 2, 3, 4, 5, 6, 7 ];
    combinecasesresults = [ "a", "a", "a", "a", "b", "b", "b", "b" ];
    
    foreach ( index, c in combinecases )
    {
        x = switch_combinecases( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_combineCases: " + c, x, combinecasesresults[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 210 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    combinecases = [ "foo_a", "foo_b", "foo_c", "foo_d" ];
    combinecasesresults = [ 1, 1, 1, -1 ];
    
    foreach ( index, c in combinecases )
    {
        x = switch_combinecasesstr( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_combineCasesStr: " + c, x, combinecasesresults[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 218 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    singlecases = [ 0, 1, 2, 3 ];
    singlecasesresults = [ "a", "", "", "" ];
    
    foreach ( index, c in singlecases )
    {
        x = switch_singlecases( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_singleCases: " + c, x, singlecasesresults[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 226 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    singlecases = [ "foo_a", "foo_b", "foo_c", "foo_d" ];
    singlecasesresults = [ -1, 1, -1, -1 ];
    
    foreach ( index, c in singlecases )
    {
        x = switch_singlecasesstr( c );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_singleCasesStr: " + c, x, singlecasesresults[ index ], "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 234 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace gscunittest_switch
// Params 0
// Checksum 0xcf278671, Offset: 0xf1a
// Size: 0x13c
function switch_nest()
{
    numcases = [ 0, 0, 0, 1, 0, 2, 1, 0, 1, 1, 1, 2 ];
    numcasesresults = [ "0 0", "0 1", "0 2", "1 0", "1 1", "1 2" ];
    i = 0;
    
    while ( i < numcases.size )
    {
        c0 = numcases[ i ];
        c1 = numcases[ i + 1 ];
        x = switch_nestswitch( c0, c1 );
        index = int( floor( i / 2 ) );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_nest: " + i, numcasesresults[ index ], x, "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 251 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        i += 2;
    }
}

// Namespace gscunittest_switch
// Params 2
// Checksum 0xa7222e7e, Offset: 0x105e
// Size: 0xfa
function switch_nestswitch( c0, c1 )
{
    result = undefined;
    
    switch ( c0 )
    {
        case 0:
            switch ( c1 )
            {
                case 0:
                    result = "0 0";
                    break;
                case 1:
                    result = "0 1";
                    break;
                case 2:
                    result = "0 2";
                    break;
            }
            
            break;
        case 1:
            switch ( c1 )
            {
                case 0:
                    result = "1 0";
                    break;
                case 1:
                    result = "1 1";
                    break;
                case 2:
                    result = "1 2";
                    break;
            }
            
            break;
        default:
            result = "nest bad";
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 0
// Checksum 0x32b40a40, Offset: 0x1161
// Size: 0xd8
function switch_loop()
{
    loopresults = [ "03", "1", "2", "3", "4", "5", "6", "7", "8", "9" ];
    
    for ( i = 0; i < 10 ; i++ )
    {
        x = switch_loopswitch( i );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_loop: " + i, loopresults[ i ], x, "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 307 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0x9d28278f, Offset: 0x1241
// Size: 0x6f
function switch_loopswitch( i )
{
    result = string( i );
    
    switch ( i )
    {
        case 0:
            for ( j = 0; j < 5 ; j++ )
            {
                if ( j > 2 )
                {
                    break;
                }
            }
            
            result += j;
            break;
        default:
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 0
// Checksum 0xb86bfc7, Offset: 0x12b9
// Size: 0xd8
function switch_return()
{
    loopresults = [ "0ab3", "1b3", "d", "e", "4", "5", "6", "7", "8", "9" ];
    
    for ( i = 0; i < 10 ; i++ )
    {
        x = switch_returnswitch( i );
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "switch_returnSwitch: " + i, loopresults[ i ], x, "scripts/autotests/gscunittest/test_gscunittest_switch.gsc", 340 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace gscunittest_switch
// Params 1
// Checksum 0xdebab21f, Offset: 0x1399
// Size: 0xc4
function switch_returnswitch( i )
{
    result = string( i );
    
    switch ( i )
    {
        case 0:
            result += "a";
        case 1:
            result += "b";
            
            for ( j = 0; j < 5 ; j++ )
            {
                if ( j > 2 )
                {
                    return ( result + j );
                }
            }
            
            result += "c";
            break;
        case 2:
            return "d";
        case 3:
            if ( result != "" )
            {
                return "e";
            }
        default:
            break;
    }
    
    return result;
}

// Namespace gscunittest_switch
// Params 0
// Checksum 0x34a9b377, Offset: 0x1466
// Size: 0x1e
function main()
{
    switch_case();
    switch_nest();
    switch_loop();
    switch_return();
}

