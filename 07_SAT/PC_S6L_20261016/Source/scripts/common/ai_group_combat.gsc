// scripts\common\ai_group_combat.gsc  (hash_5a95e510c3121db7.gscc) (size: 4228 Bytes / 0x1084 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45c9586c (1170823276)
// size ...... 4228 (0x1084)
// includes .. 2   (offset: 0x1020)
// strings ... 4   (offset: 0x1030)
// dev strs .. 3   (offset: 0x1060)
// exports ... 17  (offset: 0x9f4)
// cseg ...... 0xda + 0x91a (0x9f4)
// imports ... 31  (offset: 0xc9c)
// animtree1 . 0   (offset: 0x1084)
// animtree2 . 0   (offset: 0x1084)
#using scripts\common\ai_formation;
#using scripts\common\utility;

#namespace ai_group_combat;

// Namespace ai_group_combat
// Params 0
// Checksum 0xbee41c12, Offset: 0xf8
// Size: 0x18
function init()
{
    if ( !isdefined( level.var_ad98796cc6f286e1 ) )
    {
        level.var_ad98796cc6f286e1 = [];
    }
}

// Namespace ai_group_combat
// Params 2
// Checksum 0xe0a77cd2, Offset: 0x118
// Size: 0xa3
function function_fa26af5d2d373688( var_d90a8c9e8c6c55a6, formationtype )
{
    if ( !isdefined( level.var_ad98796cc6f286e1 ) )
    {
        init();
    }
    
    if ( isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ];
    }
    
    assert( formationtype >= 0 && formationtype < 7, "<dev string:x24>" + formationtype );
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] = spawnstruct();
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array = [];
    ai_formation::function_c37011dc917139e7( var_d90a8c9e8c6c55a6, formationtype );
    return level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ];
}

// Namespace ai_group_combat
// Params 1
// Checksum 0xdc3005a7, Offset: 0x1c4
// Size: 0xf1
function function_35710891cfb53aa6( var_d90a8c9e8c6c55a6 )
{
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return;
    }
    
    foreach ( ai in level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array )
    {
        ai notify( #"leave_group_combat" );
    }
    
    notifyname = function_c5974ef8c12299dd( var_d90a8c9e8c6c55a6 );
    level notify( notifyname );
    ai_formation::leave_formation( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array );
    ai_formation::delete_formation( var_d90a8c9e8c6c55a6 );
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] = undefined;
}

// Namespace ai_group_combat
// Params 3
// Checksum 0x669865df, Offset: 0x2bd
// Size: 0xf2
function function_fb879aec933fd9b9( var_d90a8c9e8c6c55a6, aitoadd, formationtype = 3 )
{
    if ( !isdefined( level.var_ad98796cc6f286e1 ) )
    {
        init();
    }
    
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        function_fa26af5d2d373688( var_d90a8c9e8c6c55a6, formationtype );
    }
    
    if ( !isarray( aitoadd ) )
    {
        aitoadd = [ aitoadd ];
    }
    
    foreach ( ai in aitoadd )
    {
        if ( ai.var_d90a8c9e8c6c55a6 == var_d90a8c9e8c6c55a6 )
        {
            continue;
        }
        
        function_a7eea1b58560fdd8( var_d90a8c9e8c6c55a6, ai, formationtype );
    }
}

// Namespace ai_group_combat
// Params 1, eflags: 0x4
// Checksum 0x3faaf4c7, Offset: 0x3b7
// Size: 0x67
function private group_combat_cleanup( formationtype )
{
    level endon( #"game_ended" );
    var_d90a8c9e8c6c55a6 = self.var_d90a8c9e8c6c55a6;
    utility::waittill_any( "leave_group_combat", "death" );
    
    if ( isdefined( self ) )
    {
        leave_group_combat_formation( var_d90a8c9e8c6c55a6, self );
        
        if ( isalive( self ) )
        {
            self enableavoidance( 1 );
            self.patroltarget = undefined;
        }
    }
}

// Namespace ai_group_combat
// Params 1, eflags: 0x4
// Checksum 0xd258c68d, Offset: 0x426
// Size: 0x14
function private function_c5974ef8c12299dd( var_d90a8c9e8c6c55a6 )
{
    return var_d90a8c9e8c6c55a6 + "_kill_update";
}

// Namespace ai_group_combat
// Params 1
// Checksum 0x286e2e34, Offset: 0x443
// Size: 0xd7
function get_target_goals( target )
{
    goals = getnodearray( target, #targetname );
    new_goals = utility::getstructarray( target, "targetname" );
    goals = arraycombine( goals, new_goals );
    new_goals = getentarray( target, #targetname );
    
    foreach ( new in new_goals )
    {
        if ( !is_target_goal_valid( new ) )
        {
            continue;
        }
        
        goals[ goals.size ] = new;
    }
    
    return goals;
}

// Namespace ai_group_combat
// Params 1
// Checksum 0x1361869b, Offset: 0x523
// Size: 0x5e, Type: bool
function is_target_goal_valid( object )
{
    if ( isspawner( object ) )
    {
        return false;
    }
    
    switch ( object.code_classname )
    {
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_5e0756fcd4e0adcd":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_81903cb95a447b8c":
            return false;
    }
    
    return true;
}

// Namespace ai_group_combat
// Params 1
// Checksum 0x27f33f94, Offset: 0x58a
// Size: 0x7a
function function_95d69c1398a9734d( var_d90a8c9e8c6c55a6 )
{
    assert( isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ), "<dev string:x3f>" );
    leader = ai_formation::get_leader( var_d90a8c9e8c6c55a6 );
    
    if ( !isdefined( leader ) && level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array.size > 0 )
    {
        leader = level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array[ 0 ];
    }
    
    return leader;
}

// Namespace ai_group_combat
// Params 3, eflags: 0x4
// Checksum 0x2c497a30, Offset: 0x60d
// Size: 0x7e
function private function_a7eea1b58560fdd8( var_d90a8c9e8c6c55a6, aitoadd, formationtype )
{
    index = level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array.size;
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array[ index ] = aitoadd;
    aitoadd.var_d90a8c9e8c6c55a6 = var_d90a8c9e8c6c55a6;
    ai_formation::function_452107292f74bf20( var_d90a8c9e8c6c55a6, aitoadd, formationtype );
    aitoadd thread group_combat_cleanup( formationtype );
}

// Namespace ai_group_combat
// Params 2
// Checksum 0xaae74574, Offset: 0x693
// Size: 0x31
function function_4c4de030ada6ee42( var_d90a8c9e8c6c55a6, customoffsetlist )
{
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return;
    }
    
    ai_formation::function_4c4de030ada6ee42( var_d90a8c9e8c6c55a6, customoffsetlist );
}

// Namespace ai_group_combat
// Params 3
// Checksum 0xaae74529, Offset: 0x6cc
// Size: 0x3b
function function_48a197da910dcd4d( var_d90a8c9e8c6c55a6, formationslot, customoffset )
{
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return;
    }
    
    ai_formation::function_48a197da910dcd4d( var_d90a8c9e8c6c55a6, formationslot, customoffset );
}

// Namespace ai_group_combat
// Params 2
// Checksum 0xaae74574, Offset: 0x70f
// Size: 0x31
function set_goal( var_d90a8c9e8c6c55a6, goalposition )
{
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return;
    }
    
    ai_formation::set_goal( var_d90a8c9e8c6c55a6, goalposition );
}

// Namespace ai_group_combat
// Params 2
// Checksum 0xfb48900e, Offset: 0x748
// Size: 0xf4
function leave_group_combat_formation( var_d90a8c9e8c6c55a6, aitoremove )
{
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return;
    }
    
    if ( !isarray( aitoremove ) )
    {
        aitoremove = [ aitoremove ];
    }
    
    foreach ( ai in aitoremove )
    {
        ai_formation::leave_formation( ai );
        ai clearbtgoal( 1 );
        ai notify( #"leave_group_combat" );
    }
    
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array = arrayremove( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array, aitoremove );
}

// Namespace ai_group_combat
// Params 0
// Checksum 0xea9eaca8, Offset: 0x844
// Size: 0x28
function function_18c99ba0f7def2d1()
{
    assert( self.var_d90a8c9e8c6c55a6, "<dev string:x64>" );
    ai_formation::set_as_leader( self.var_d90a8c9e8c6c55a6 );
}

// Namespace ai_group_combat
// Params 5
// Checksum 0x5f1c688f, Offset: 0x874
// Size: 0x180
function function_dc1721259a44cdb4( var_d90a8c9e8c6c55a6, formationshape, horizontalseparation, verticalseparation, leaderinfront = 0 )
{
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ] ) )
    {
        return;
    }
    
    numai = level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].array.size;
    
    if ( numai == 0 )
    {
        return;
    }
    
    leaderinfront = leaderinfront || formationshape == 1;
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].formationwidth = ai_formation::function_1fd64dcd55c92197( var_d90a8c9e8c6c55a6, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront );
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].horizontalseparation = horizontalseparation;
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].verticalseparation = verticalseparation;
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].var_bf52d366dfa30bb3 = formationshape;
    level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].leaderinfront = leaderinfront;
    
    if ( !isdefined( level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].var_7df184e702bb256c ) )
    {
        level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].var_7df184e702bb256c = formationshape;
    }
    
    if ( formationshape == level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].var_7df184e702bb256c )
    {
        level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].var_24fb42ff083faeb5 = level.var_ad98796cc6f286e1[ var_d90a8c9e8c6c55a6 ].formationwidth;
    }
}

