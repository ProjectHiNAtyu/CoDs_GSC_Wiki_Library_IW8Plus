// scripts\autotests\gscunittest\test_gscunittest_entity_field.gsc  (hash_5a94d2adfb79ac86.gscc) (size: 9704 Bytes / 0x25e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb543644e (3041092686)
// size ...... 9704 (0x25e8)
// includes .. 1   (offset: 0x1f98)
// strings ... 75  (offset: 0x1fa0)
// dev strs .. 0   (offset: 0x25e8)
// exports ... 3   (offset: 0x1ac0)
// cseg ...... 0x899 + 0x1227 (0x1ac0)
// imports ... 9   (offset: 0x1b38)
// animtree1 . 0   (offset: 0x25e8)
// animtree2 . 0   (offset: 0x25e8)
#using scripts\autotests\autotests;

#namespace gscunittest_entity_field;

// Namespace gscunittest_entity_field
// Params 0
// Checksum 0x20259774, Offset: 0x8b7
// Size: 0x11f8
function player_pers()
{
    while ( !( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].pers ) ) )
    {
        waitframe();
    }
    
    player = level.players[ 0 ];
    perscopy = undefined;
    varcopy = undefined;
    structcopy = undefined;
    arraycopy = undefined;
    var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "1) pers loaded", player.pers.size, 0, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    varcopy = player.pers[ "ut_var" ];
    structcopy = player.pers[ "ut_struct" ];
    arraycopy = player.pers[ "ut_array" ];
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "2) Non-existent variables: varCopy", varcopy, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 29 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "2) Non-existent variables: structCopy", structcopy, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 30 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "2) Non-existent variables: arrayCopy", arraycopy, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 31 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    perscopy = player.pers;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "3) Make copy of player.pers", player.pers.size, perscopy.size, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 37 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player.pers[ "ut_var" ] = "a";
    s1 = spawnstruct();
    s1.b = "b";
    s1.c = "c";
    player.pers[ "ut_struct" ] = s1;
    a1 = [];
    a1[ "d" ] = "d";
    a1[ "e" ] = "e";
    player.pers[ "ut_array" ] = a1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) New field to player.pers: ut_var", player.pers[ "ut_var" ], "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 51 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) New field to player.pers: ut_struct: b", player.pers[ "ut_struct" ].b, "b", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 52 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) New field to player.pers: ut_var: c", player.pers[ "ut_struct" ].c, "c", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 53 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) New field to player.pers: ut_array: d", player.pers[ "ut_array" ][ "d" ], "d", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 54 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) New field to player.pers: ut_array: d", player.pers[ "ut_array" ][ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 55 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "4) Copy remains undefined: varCopy", varcopy, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 56 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "4) Copy remains undefined: structCopy", structcopy, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 57 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "4) Copy remains undefined: arrayCopy", arraycopy, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) persCopy completely updated", player.pers.size, perscopy.size, "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 59 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "4) persCopy completely updated", perscopy[ "ut_var" ], "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 60 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    perscopy = arraycopy( player.pers );
    varcopy = player.pers[ "ut_var" ];
    structcopy = player.pers[ "ut_struct" ];
    arraycopy = arraycopy( player.pers[ "ut_array" ] );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "5) Re-copy variables: varCopy", varcopy, "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 69 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "5) Re-copy variables: structCopy", structcopy.b, "b", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 70 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "5) Re-copy variables: arrayCopy", arraycopy[ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 71 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    perscopy[ "ut_var" ] = "aa";
    perscopy[ "ut_struct" ].b = "bb";
    perscopy[ "ut_struct" ].c = "cc";
    perscopy[ "ut_array" ][ "d" ] = "dd";
    perscopy[ "ut_array" ][ "e" ] = "ee";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Unchanged player.pers: ut_var", player.pers[ "ut_var" ], "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 81 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Changed player.pers: ut_struct: b", player.pers[ "ut_struct" ].b, "bb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 82 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Changed player.pers: ut_struct: c", player.pers[ "ut_struct" ].c, "cc", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 83 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Unchanged player.pers: ut_array: d", player.pers[ "ut_array" ][ "d" ], "d", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 84 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Unchanged player.pers: ut_array: d", player.pers[ "ut_array" ][ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 85 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Updated copy: ut_var", perscopy[ "ut_var" ], "aa", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 86 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Updated copy: ut_struct: b", perscopy[ "ut_struct" ].b, "bb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 87 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Updated copy: ut_var: c", perscopy[ "ut_struct" ].c, "cc", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 88 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Updated copy: ut_array: d", perscopy[ "ut_array" ][ "d" ], "dd", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 89 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "6) Updated copy: ut_array: d", perscopy[ "ut_array" ][ "e" ], "ee", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 90 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    varcopy = "aaa";
    structcopy.b = "bbb";
    structcopy.c = "ccc";
    arraycopy[ "d" ] = "ddd";
    arraycopy[ "e" ] = "eee";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Update copy variables: varCopy", varcopy, "aaa", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 100 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Update copy variables: structCopy", structcopy.b, "bbb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 101 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Update copy variables: arrayCopy", arraycopy[ "e" ], "eee", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 102 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Unchanged player.pers: ut_var", player.pers[ "ut_var" ], "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 103 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Changed player.pers: ut_struct: b", player.pers[ "ut_struct" ].b, "bbb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 104 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Unchanged player.pers: ut_array: d", player.pers[ "ut_array" ][ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 105 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Unchanged copy: ut_var", perscopy[ "ut_var" ], "aa", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 106 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Changed copy: ut_var: c", perscopy[ "ut_struct" ].c, "ccc", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 107 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "7) Unchanged copy: ut_array: d", perscopy[ "ut_array" ][ "d" ], "dd", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 108 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    perscopy = arraycopy( player.pers );
    varcopy = player.pers[ "ut_var" ];
    structcopy = player.pers[ "ut_struct" ];
    arraycopy = arraycopy( player.pers[ "ut_array" ] );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "8 )Re-get variables: varCopy", varcopy, "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 118 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "8 )Re-get variables: structCopy", structcopy.b, "bbb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 119 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "8) Re-get variables: arrayCopy", arraycopy[ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 120 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player.pers[ "ut_var" ] = "aaaa";
    player.pers[ "ut_struct" ].b = "bbbb";
    player.pers[ "ut_struct" ].c = "cccc";
    player.pers[ "ut_array" ][ "d" ] = "dddd";
    player.pers[ "ut_array" ][ "e" ] = "eeee";
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Unchanged copy variables: varCopy", varcopy, "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 130 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Changed copy variables: structCopy", structcopy.b, "bbbb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 131 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Unchanged copy variables: arrayCopy", arraycopy[ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 132 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Update player.pers: ut_var", player.pers[ "ut_var" ], "aaaa", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 133 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Update player.pers: ut_struct: b", player.pers[ "ut_struct" ].b, "bbbb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 134 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Update player.pers: ut_array: d", player.pers[ "ut_array" ][ "e" ], "eeee", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 135 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Unchanged copy: ut_var", perscopy[ "ut_var" ], "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 136 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Changed copy (shallow copy): ut_var: c", perscopy[ "ut_struct" ].c, "cccc", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 137 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "9) Unchanged copy: ut_array: d", perscopy[ "ut_array" ][ "d" ], "d", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 138 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player.pers[ "ut_var" ] = undefined;
    player.pers[ "ut_struct" ] = undefined;
    player.pers[ "ut_array" ] = undefined;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "10) Unchanged copy variables: varCopy", varcopy, "a", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 145 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "10) Changed copy variables: structCopy", structcopy.b, "bbbb", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 146 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "10) Unchanged copy variables: arrayCopy", arraycopy[ "e" ], "e", "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 147 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "10) Delete player.pers: ut_var", player.pers[ "ut_var" ], "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 148 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "10) Delete player.pers: ut_struct: b", player.pers[ "ut_struct" ], "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 149 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_dbbd10e009ede41e( "10) Delete player.pers: ut_array: d", player.pers[ "ut_array" ], "scripts/autotests/gscunittest/test_gscunittest_entity_field.gsc", 150 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace gscunittest_entity_field
// Params 0
// Checksum 0x44248e27, Offset: 0x1ab7
// Size: 0x9
function main()
{
    player_pers();
}

