// scripts\common\ai_formation.gsc  (hash_48ca7f64463ff6dc.gscc) (size: 6729 Bytes / 0x1a49 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6b821e8 (3065520616)
// size ...... 6729 (0x1a49)
// includes .. 1   (offset: 0x19cd)
// strings ... 4   (offset: 0x19d5)
// dev strs .. 5   (offset: 0x1a0d)
// exports ... 24  (offset: 0x1105)
// cseg ...... 0x102 + 0x1003 (0x1105)
// imports ... 41  (offset: 0x14c5)
// animtree1 . 0   (offset: 0x1a49)
// animtree2 . 0   (offset: 0x1a49)
#using scripts\common\utility;

#namespace ai_formation;

// Namespace ai_formation
// Params 0
// Checksum 0x9ae7b7c3, Offset: 0x120
// Size: 0x18
function init_formations()
{
    if ( !isdefined( level.formationlist ) )
    {
        level.formationlist = [];
    }
}

// Namespace ai_formation
// Params 1
// Checksum 0x2e4cb957, Offset: 0x140
// Size: 0x22, Type: bool
function formation_valid( formationid )
{
    return isdefined( formationid ) && formationid != -1 && function_fa1443329395568f( formationid );
}

// Namespace ai_formation
// Params 4
// Checksum 0xcdc713fe, Offset: 0x16b
// Size: 0x125
function function_c37011dc917139e7( formationname, formationtype, columncount = 2, horizontalspacing = 40 )
{
    if ( !isdefined( level.formationlist ) )
    {
        init_formations();
    }
    
    if ( formation_valid( level.formationlist[ formationname ] ) )
    {
        return level.formationlist[ formationname ];
    }
    
    assert( formationtype >= 0 && formationtype < 7, "<dev string:x24>" + formationtype );
    level.formationlist[ formationname ] = newaiformation( formationtype );
    formationid = level.formationlist[ formationname ];
    
    if ( isdefined( level.var_845e167e54b7d89b ) && formation_valid( formationid ) )
    {
        switch ( formationtype )
        {
            case 4:
                function_3a95bb1a6ebed8f6( formationid, columncount, horizontalspacing );
                break;
            case 6:
                function_69cbc799b37bc8f4( formationid, horizontalspacing );
                break;
            default:
                break;
        }
    }
    
    return level.formationlist[ formationname ];
}

// Namespace ai_formation
// Params 1
// Checksum 0x5a2971fa, Offset: 0x299
// Size: 0x40
function delete_formation( formationname )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    deleteaiformation( level.formationlist[ formationname ] );
    level.formationlist[ formationname ] = undefined;
}

// Namespace ai_formation
// Params 5
// Checksum 0x133a05de, Offset: 0x2e1
// Size: 0x11e
function function_452107292f74bf20( formationname, aitoadd, formationtype = 3, columncount = 2, horizontalspacing = 40 )
{
    if ( !isdefined( level.formationlist ) )
    {
        init_formations();
    }
    
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        function_c37011dc917139e7( formationname, formationtype, columncount, horizontalspacing );
    }
    
    if ( !isarray( aitoadd ) )
    {
        aitoadd = [ aitoadd ];
    }
    
    foreach ( ai in aitoadd )
    {
        ai enter_formation( level.formationlist[ formationname ] );
        ai thread need_to_run( formationname );
    }
}

// Namespace ai_formation
// Params 2
// Checksum 0x32e57ab5, Offset: 0x407
// Size: 0xf0
function function_4cb9d766794b2ad2( formationname, agents )
{
    level endon( #"game_ended" );
    level notify( "single_delete_formation_when_ai_cleared_" + formationname );
    level endon( "single_delete_formation_when_ai_cleared_" + formationname );
    var_1f39b9f062f5344f = 1;
    
    while ( var_1f39b9f062f5344f )
    {
        var_1f39b9f062f5344f = 0;
        
        foreach ( agent in level.patrolformations[ formationname ].members )
        {
            if ( isalive( agent ) )
            {
                var_1f39b9f062f5344f = 1;
            }
        }
        
        wait 2;
    }
    
    delete_formation( formationname );
    level.patrolformations[ formationname ] = undefined;
}

// Namespace ai_formation
// Params 6
// Checksum 0xd33b53ef, Offset: 0x4ff
// Size: 0x123
function function_173c203a2373914b( formationname, horizontalcount, verticalcount, horizontalseparation, verticalseparation, leaderinfront = 0 )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    mid = floor( horizontalcount / 2 );
    offsetcount = 1;
    
    for ( verticalindex = 0; verticalindex < verticalcount ; verticalindex++ )
    {
        for ( horizontalindex = 0; horizontalindex < horizontalcount ; horizontalindex++ )
        {
            if ( !leaderinfront && verticalindex == 0 && horizontalindex == mid )
            {
                continue;
            }
            
            yoffset = horizontalseparation * -1 * ( horizontalindex - mid );
            xoffset = verticalseparation * -1 * verticalindex;
            
            if ( leaderinfront )
            {
                yoffset -= 0.5 * ( horizontalcount - 1 ) % 2 * horizontalseparation;
                xoffset -= verticalseparation;
            }
            
            setaiformationcustomoffset( level.formationlist[ formationname ], offsetcount, ( xoffset, yoffset, 0 ) );
            offsetcount++;
        }
    }
}

// Namespace ai_formation
// Params 6
// Checksum 0x9d72e11, Offset: 0x62a
// Size: 0x27e
function function_1fd64dcd55c92197( formationname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront = 0 )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return 1;
    }
    
    if ( numai <= 1 )
    {
        return 1;
    }
    
    if ( leaderinfront && formationshape != 1 )
    {
        numai--;
    }
    
    switch ( formationshape )
    {
        case 1:
            dimension = ceil( ( sqrt( 8 * numai + 1 ) - 1 ) / 2 );
            offsetcount = 1;
            
            for ( verticalindex = 0; verticalindex < dimension ; verticalindex++ )
            {
                for ( horizontalindex = 0; horizontalindex < verticalindex + 1 ; horizontalindex++ )
                {
                    if ( verticalindex == 0 && horizontalindex == 0 )
                    {
                        continue;
                    }
                    
                    yoffset = horizontalseparation * ( horizontalindex - verticalindex / 2 );
                    xoffset = verticalseparation * -1 * verticalindex;
                    setaiformationcustomoffset( level.formationlist[ formationname ], offsetcount, ( xoffset, yoffset, 0 ) );
                    offsetcount++;
                }
            }
            
            return ( ( dimension - 1 ) * horizontalseparation );
        case 2:
            mid = 0;
            horizontalcount = 1;
            verticalcount = numai;
            break;
        case 3:
            mid = 1;
            horizontalcount = 2;
            verticalcount = ceil( numai / horizontalcount );
            break;
        case 4:
            mid = 1;
            horizontalcount = 3;
            verticalcount = ceil( numai / horizontalcount );
            break;
        default:
            horizontalcount = ceil( sqrt( numai ) );
            verticalcount = ceil( numai / horizontalcount );
            mid = floor( horizontalcount / 2 );
            break;
    }
    
    offsetcount = 1;
    
    for ( verticalindex = 0; verticalindex < verticalcount ; verticalindex++ )
    {
        for ( horizontalindex = 0; horizontalindex < horizontalcount ; horizontalindex++ )
        {
            if ( !leaderinfront && verticalindex == 0 && horizontalindex == mid )
            {
                continue;
            }
            
            yoffset = horizontalseparation * -1 * ( horizontalindex - mid );
            xoffset = verticalseparation * -1 * verticalindex;
            
            if ( leaderinfront )
            {
                yoffset -= 0.5 * ( horizontalcount - 1 ) % 2 * horizontalseparation;
                xoffset -= verticalseparation;
            }
            
            setaiformationcustomoffset( level.formationlist[ formationname ], offsetcount, ( xoffset, yoffset, 0 ) );
            offsetcount++;
        }
    }
    
    return ( horizontalcount - 1 ) * horizontalseparation;
}

// Namespace ai_formation
// Params 2
// Checksum 0x864dd379, Offset: 0x8b1
// Size: 0xe4
function function_4c4de030ada6ee42( formationname, customoffsetlist )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    assert( customoffsetlist.size < 31, "<dev string:x3f>" + string( 31 ) + "<dev string:x6d>" + level.formationlist[ formationname ] );
    count = 1;
    
    foreach ( offset in customoffsetlist )
    {
        setaiformationcustomoffset( level.formationlist[ formationname ], count, offset );
        count++;
    }
}

// Namespace ai_formation
// Params 3
// Checksum 0xf47b512c, Offset: 0x99d
// Size: 0x85
function function_48a197da910dcd4d( formationname, formationslot, customoffset )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    maxcount = 31;
    assert( formationslot < maxcount && formationslot > 0, "<dev string:x83>" + maxcount + "<dev string:xc0>" + level.formationlist[ formationname ] );
    setaiformationcustomoffset( level.formationlist[ formationname ], formationslot, customoffset );
}

// Namespace ai_formation
// Params 2
// Checksum 0x8b2c4952, Offset: 0xa2a
// Size: 0x3e
function set_goal( formationname, goalposition )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    aiformationmoveto( level.formationlist[ formationname ], goalposition );
}

// Namespace ai_formation
// Params 1
// Checksum 0x7033cd5d, Offset: 0xa70
// Size: 0x91
function leave_formation( aitoremove )
{
    if ( !isarray( aitoremove ) )
    {
        aitoremove = [ aitoremove ];
    }
    
    foreach ( ai in aitoremove )
    {
        ai exit_formation();
    }
}

// Namespace ai_formation
// Params 4
// Checksum 0xff7ac4b4, Offset: 0xb09
// Size: 0x89, Type: bool
function follow_entity( formationname, ent, followdistance = 100, timestep )
{
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return false;
    }
    
    leader = get_leader( formationname );
    
    if ( isdefined( leader ) )
    {
        leader setgoalentity( ent );
        setaiformationleaderfollowdistance( level.formationlist[ formationname ], followdistance );
        return true;
    }
    
    return false;
}

// Namespace ai_formation
// Params 1
// Checksum 0x55312162, Offset: 0xb9b
// Size: 0x49, Type: bool
function unfollow_entity( formationname )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return false;
    }
    
    leader = get_leader( formationname );
    
    if ( isdefined( leader ) )
    {
        leader cleargoalentity();
        return true;
    }
    
    return false;
}

// Namespace ai_formation
// Params 1
// Checksum 0x7f5757c3, Offset: 0xbed
// Size: 0x33
function get_leader( formationname )
{
    if ( !formation_valid( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    return getaiformationleader( level.formationlist[ formationname ] );
}

// Namespace ai_formation
// Params 1
// Checksum 0xaa9c83c5, Offset: 0xc29
// Size: 0x34
function set_as_leader( formationname )
{
    formationid = level.formationlist[ formationname ];
    
    if ( !isdefined( formationid ) )
    {
        return;
    }
    
    self function_be3ca81961b87558( formationid );
}

// Namespace ai_formation
// Params 0
// Checksum 0xdd4fa7e9, Offset: 0xc65
// Size: 0x2e
function exit_formation()
{
    if ( isalive( self ) && self.information )
    {
        self function_15d833edc621f776();
        self.information = 0;
        function_c08b93cc912e68a4();
    }
}

// Namespace ai_formation
// Params 1, eflags: 0x4
// Checksum 0x8889be78, Offset: 0xc9b
// Size: 0x33
function private enter_formation( formationid )
{
    if ( !formation_valid( formationid ) )
    {
        return;
    }
    
    exit_formation();
    self.information = 1;
    self function_f8d29c08efce8ec3( formationid );
}

// Namespace ai_formation
// Params 1, eflags: 0x4
// Checksum 0xd226008e, Offset: 0xcd6
// Size: 0x1fa
function private need_to_run( formationname )
{
    self endon( #"death" );
    self endon( #"enemy" );
    self endon( #"following_entity" );
    level endon( #"game_ended" );
    self notify( #"hash_631e4bb00dba5706" );
    self endon( #"hash_631e4bb00dba5706" );
    var_a9fbfa112d6277c5 = 1000;
    var_8085a679c5743a9f = 250;
    
    while ( true )
    {
        leader = get_leader( formationname );
        
        if ( !isalive( leader ) )
        {
            wait 1;
            continue;
        }
        
        disttogoal = self pathdisttogoal() - leader pathdisttogoal();
        
        /#
            if ( getdvarint( @"hash_96eb05fe9867a3a4", 0 ) == 1 )
            {
                print3d( self.origin, self getdemeanor(), ( 1, 0, 0 ), 1, 1, 20 );
                goal = self getgoalpos( 3 );
                utility::draw_circle( goal, var_a9fbfa112d6277c5, ( 1, 0, 0 ), 50 );
                utility::draw_circle( goal, var_8085a679c5743a9f, ( 0, 1, 0 ), 50 );
            }
        #/
        
        idledemeanoroverride = "sprint";
        
        if ( self.stealth_idledemeanor != idledemeanoroverride && disttogoal > var_a9fbfa112d6277c5 )
        {
            self enableavoidance( 1 );
            
            if ( !( isdefined( self.previous_idledemeanor ) && isdefined( self.var_b8378c0184179f4e ) ) )
            {
                self.previous_idledemeanor = self.stealth_idledemeanor;
                self.var_b8378c0184179f4e = self.var_b52fca22f7f1e144;
            }
            
            self.stealth_idledemeanor = idledemeanoroverride;
            self.var_b52fca22f7f1e144 = idledemeanoroverride;
        }
        else if ( self.stealth_idledemeanor == idledemeanoroverride && disttogoal < var_8085a679c5743a9f )
        {
            self enableavoidance( 0 );
            self.stealth_idledemeanor = self.previous_idledemeanor;
            self.var_b52fca22f7f1e144 = self.var_b8378c0184179f4e;
        }
        
        wait 1;
    }
}

// Namespace ai_formation
// Params 0, eflags: 0x4
// Checksum 0xf790b44d, Offset: 0xed8
// Size: 0x40
function private function_c08b93cc912e68a4()
{
    if ( isdefined( self.previous_idledemeanor ) )
    {
        self.stealth_idledemeanor = self.previous_idledemeanor;
    }
    
    if ( isdefined( self.var_b8378c0184179f4e ) )
    {
        self.var_b52fca22f7f1e144 = self.var_b8378c0184179f4e;
    }
}

// Namespace ai_formation
// Params 0
// Checksum 0x331f8c1a, Offset: 0xf20
// Size: 0x5b
function function_e9aabb85b0d12949()
{
    if ( !isdefined( level.var_667882d5b5f3b9d3 ) )
    {
        level.var_667882d5b5f3b9d3 = 0;
    }
    
    returnname = "ai_formation_" + level.var_667882d5b5f3b9d3;
    level.var_667882d5b5f3b9d3++;
    
    if ( level.var_667882d5b5f3b9d3 > 9999999 )
    {
        level.var_667882d5b5f3b9d3 = 0;
    }
    
    return returnname;
}

// Namespace ai_formation
// Params 1
// Checksum 0x8155698e, Offset: 0xf84
// Size: 0xd6
function function_b9c3c25d5af126df( pathstruct )
{
    if ( isdefined( pathstruct ) && isdefined( pathstruct.path[ 0 ] ) && isdefined( pathstruct.path[ 0 ].script_formation_type ) )
    {
        var_8fa73e234f8a7cc4 = pathstruct.path[ 0 ].script_formation_type;
        
        switch ( var_8fa73e234f8a7cc4 )
        {
            case #"hash_413c43425f1f3aca":
                return 1;
            case #"hash_a5f048ff68079067":
                return 2;
            case #"hash_4705851be63bb241":
                return 3;
            case #"hash_2a487f1c5f68914c":
                return 4;
            case #"hash_8613326cd6738ebb":
                return 5;
            case #"hash_83d576ad889124f0":
                return 6;
            default:
                return 3;
        }
    }
    
    return 3;
}

// Namespace ai_formation
// Params 1
// Checksum 0x371c4f09, Offset: 0x1063
// Size: 0xa1
function function_93024c73fc4ba7e6( pathstruct )
{
    if ( isdefined( pathstruct ) && isdefined( pathstruct.path[ 0 ] ) && isdefined( pathstruct.path[ 0 ].var_a1d97aef7430ab74 ) )
    {
        idledemeanor_override = tolower( pathstruct.path[ 0 ].var_a1d97aef7430ab74 );
        
        switch ( idledemeanor_override )
        {
            case #"hash_186d745a92c317d9":
            case #"hash_9e02cd4a0f3ca981":
                return idledemeanor_override;
            default:
                return "patrol";
        }
    }
    
    return "patrol";
}

