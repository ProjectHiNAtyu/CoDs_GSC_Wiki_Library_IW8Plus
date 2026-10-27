// scripts\common\dog_utility.gsc  (hash_5938b1c7e9cf6ddd.gscc) (size: 2434 Bytes / 0x982 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9ace9fd (2846681597)
// size ...... 2434 (0x982)
// includes .. 2   (offset: 0x93e)
// strings ... 4   (offset: 0x94e)
// dev strs .. 0   (offset: 0x982)
// exports ... 11  (offset: 0x562)
// cseg ...... 0xa1 + 0x4c1 (0x562)
// imports ... 19  (offset: 0x71a)
// animtree1 . 0   (offset: 0x982)
// animtree2 . 0   (offset: 0x982)
#using scripts\common\ai_formation;
#using scripts\common\utility;

#namespace dog_utility;

// Namespace dog_utility
// Params 1
// Checksum 0x5454ed9d, Offset: 0xbf
// Size: 0x5d
function is_entity_alive( entity )
{
    if ( isplayer( entity ) && utility::ismp() )
    {
        return ( isalive( entity ) && !isdefined( entity.fauxdead ) && !entity.delayedspawnedplayernotify && !entity.liveragdoll );
    }
    
    return isalive( entity );
}

// Namespace dog_utility
// Params 0
// Checksum 0xaa6ddf7c, Offset: 0x125
// Size: 0x24
function get_cover_volume_forward()
{
    if ( isdefined( self.goalvolumecoveryaw ) )
    {
        return anglestoforward( ( 0, self.goalvolumecoveryaw, 0 ) );
    }
    
    return;
}

// Namespace dog_utility
// Params 2
// Checksum 0x39ea7bfe, Offset: 0x151
// Size: 0x5e
function function_9f1774c3cdd58bb9( var_2fe4d61295ccaebf, formationtype )
{
    if ( !isdefined( level.var_6a976b09a4c59423 ) )
    {
        level.var_6a976b09a4c59423 = [];
    }
    
    level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ] = spawnstruct();
    level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ].array = [];
    ai_formation::function_c37011dc917139e7( var_2fe4d61295ccaebf, formationtype );
}

// Namespace dog_utility
// Params 0
// Checksum 0xcf6bddf3, Offset: 0x1b7
// Size: 0x90
function function_7b17a9fa8dd10c73()
{
    self endon( #"death" );
    self endon( #"enemy" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self choreographer_iscontrolled() )
        {
            break;
        }
        
        if ( isdefined( self.stealth ) && isdefined( self.fnisinstealthinvestigate ) && isdefined( self.fnisinstealthhunt ) && ( ![[ self.fnisinstealthinvestigate ]]() || ![[ self.fnisinstealthhunt ]]() ) )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"leave_dog_stealth_formation" );
}

// Namespace dog_utility
// Params 0
// Checksum 0xed3b5d11, Offset: 0x24f
// Size: 0x73
function function_7af3fa2487d02303()
{
    level endon( #"game_ended" );
    thread function_7b17a9fa8dd10c73();
    utility::waittill_any( "leave_dog_stealth_formation", "enemy", "death" );
    ai_formation::leave_formation( self );
    level.var_6a976b09a4c59423[ self.var_2fe4d61295ccaebf ].array = arrayremove( level.var_6a976b09a4c59423[ self.var_2fe4d61295ccaebf ].array, self );
}

// Namespace dog_utility
// Params 0
// Checksum 0xed0e0e3d, Offset: 0x2ca
// Size: 0x81
function function_d220f3cb85eaabc9()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    group = level.wolfgroup[ self.groupname ];
    
    while ( true )
    {
        if ( self choreographer_iscontrolled() )
        {
            break;
        }
        
        if ( self._blackboard.var_560df2fc1c45fb15 || group.var_22c9287dacfda193 )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"leave_wolf_formation" );
}

// Namespace dog_utility
// Params 0
// Checksum 0x28b0e137, Offset: 0x353
// Size: 0x75
function function_2b4d30606dd5c6e5()
{
    level endon( #"game_ended" );
    var_2fe4d61295ccaebf = self.var_2fe4d61295ccaebf;
    thread function_d220f3cb85eaabc9();
    utility::waittill_any( "leave_wolf_formation", "death" );
    ai_formation::leave_formation( self );
    level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ].array = arrayremove( level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ].array, self );
}

// Namespace dog_utility
// Params 4
// Checksum 0x3831d94c, Offset: 0x3d0
// Size: 0x6c
function function_53bd47c4c5cfd33( var_2fe4d61295ccaebf, formationshape, horizontalseparation, verticalseparation )
{
    if ( !isdefined( level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ] ) )
    {
        return;
    }
    
    numai = level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ].array.size;
    ai_formation::function_1fd64dcd55c92197( var_2fe4d61295ccaebf, formationshape, numai, horizontalseparation, verticalseparation, 1 );
}

// Namespace dog_utility
// Params 0
// Checksum 0x4e750ef, Offset: 0x444
// Size: 0x50
function function_4b9e4000b8faa7c9()
{
    level endon( #"game_ended" );
    var_3b781b5b8bff840d = undefined;
    
    while ( true )
    {
        if ( var_3b781b5b8bff840d != self.goalpos )
        {
            var_3b781b5b8bff840d = self.goalpos;
            ai_formation::set_goal( self.var_2fe4d61295ccaebf, var_3b781b5b8bff840d );
        }
        
        waitframe();
    }
}

// Namespace dog_utility
// Params 5
// Checksum 0xe17ec2fe, Offset: 0x49c
// Size: 0xc6
function function_885086bb6bb53cdb( var_2fe4d61295ccaebf, newmember, formationtype, isleader, var_a3de2f7d26dc6d9f )
{
    if ( !isdefined( level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ] ) )
    {
        function_9f1774c3cdd58bb9( var_2fe4d61295ccaebf, formationtype );
    }
    
    stealthformation = level.var_6a976b09a4c59423[ var_2fe4d61295ccaebf ];
    index = stealthformation.array.size;
    stealthformation.array[ index ] = newmember;
    newmember.var_2fe4d61295ccaebf = var_2fe4d61295ccaebf;
    ai_formation::function_452107292f74bf20( var_2fe4d61295ccaebf, newmember, formationtype );
    
    if ( isleader )
    {
        newmember ai_formation::set_as_leader( var_2fe4d61295ccaebf );
    }
    
    newmember function_403190bdf322e3a8( 1 );
    
    if ( isdefined( var_a3de2f7d26dc6d9f ) )
    {
        newmember thread [[ var_a3de2f7d26dc6d9f ]]();
    }
}

