// scripts\mp\ob\activities\ob_activity_definition_utils.gsc  (hash_3ab6e780a7cbd499.gscc) (size: 4280 Bytes / 0x10b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52e0fe7e (1390476926)
// size ...... 4280 (0x10b8)
// includes .. 5   (offset: 0x1000)
// strings ... 3   (offset: 0x1028)
// dev strs .. 9   (offset: 0x104c)
// exports ... 21  (offset: 0x9bc)
// cseg ...... 0xa5 + 0x917 (0x9bc)
// imports ... 24  (offset: 0xd04)
// animtree1 . 0   (offset: 0x10b8)
// animtree2 . 0   (offset: 0x10b8)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\mp\ob\activities\ob_objective_rewards;
#using scripts\mp\rank;

#namespace ob_activity_definition_utils;

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xde1eae3d, Offset: 0xc3
// Size: 0x38
function function_e92f5b64dd1e72f7( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return var_144de98b63c7a63b.mission;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0x37d13f3e, Offset: 0x104
// Size: 0x3c, Type: bool
function function_5842f61e253fec32( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return var_144de98b63c7a63b.var_3209f1248a0917d2 ?? 0;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xfa2d829f, Offset: 0x149
// Size: 0x3d, Type: bool
function function_a15439dc6ab1f3a2( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return var_144de98b63c7a63b.var_f5e6321f57f1fd5a ?? 1;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xfa2d829e, Offset: 0x18f
// Size: 0x3c, Type: bool
function function_9d86869e58e36d0d( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return var_144de98b63c7a63b.var_9d8e78acc49a185 ?? 0;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xfa2d829e, Offset: 0x1d4
// Size: 0x3c, Type: bool
function function_7ad375d94d76c6dd( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return var_144de98b63c7a63b.var_7d1b376308cbed65 ?? 0;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0x6d284b04, Offset: 0x219
// Size: 0xe7
function function_b6096bc924663393( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    var_34a7c20640a74f0 = [];
    
    if ( isdefined( var_144de98b63c7a63b.var_da1336f4ecdf2862 ) )
    {
        foreach ( var_3e84485b605d2865 in var_144de98b63c7a63b.var_da1336f4ecdf2862 )
        {
            var_ca21418e617c2723 = activity_definition_utils::function_4e0655e047df12b8( var_3e84485b605d2865 );
            var_34a7c20640a74f0[ var_34a7c20640a74f0.size ] = var_ca21418e617c2723;
        }
    }
    
    /#
        if ( var_34a7c20640a74f0.size == 0 )
        {
            iprintln( "<dev string:x24>" );
        }
    #/
    
    return var_34a7c20640a74f0;
}

// Namespace ob_activity_definition_utils
// Params 2
// Checksum 0xb007ac1c, Offset: 0x309
// Size: 0x51
function function_b0e28b51d80eaa2c( var_e0bbf417e9178e6, difficultytier = 0 )
{
    var_208d4703b355998 = function_cc0a551aeddbf39f( var_e0bbf417e9178e6, difficultytier );
    
    if ( isdefined( var_208d4703b355998.score ) )
    {
        return int( var_208d4703b355998.score );
    }
}

// Namespace ob_activity_definition_utils
// Params 2
// Checksum 0x2907bdf7, Offset: 0x363
// Size: 0x51
function function_8cae82a5766f87d5( var_e0bbf417e9178e6, difficultytier = 0 )
{
    var_208d4703b355998 = function_cc0a551aeddbf39f( var_e0bbf417e9178e6, difficultytier );
    
    if ( isdefined( var_208d4703b355998.playerxp ) )
    {
        return int( var_208d4703b355998.playerxp );
    }
}

// Namespace ob_activity_definition_utils
// Params 2
// Checksum 0x4f7cfbe3, Offset: 0x3bd
// Size: 0xc9
function function_ee700758cb24d61f( activityvariantname, var_e0bbf417e9178e6 )
{
    difficultytier = undefined;
    
    for ( var_5f90846289fec35a = activity_common::function_d54f02a6971bb9ab( activityvariantname ); !isdefined( difficultytier ) && isdefined( var_5f90846289fec35a ) ; var_5f90846289fec35a = undefined )
    {
        difficultytier = var_5f90846289fec35a.variantstruct.difficulty_tier;
        
        if ( isstring( var_5f90846289fec35a.variantstruct.parent ) )
        {
            var_5f90846289fec35a = activity_common::function_d54f02a6971bb9ab( var_5f90846289fec35a.variantstruct.parent );
            continue;
        }
    }
    
    if ( !isdefined( difficultytier ) )
    {
        if ( !isdefined( var_e0bbf417e9178e6 ) )
        {
            var_e0bbf417e9178e6 = activity_definition_utils::getactivitydefinition( activityvariantname );
        }
        
        difficultytier = function_8c9d01de760456ce( var_e0bbf417e9178e6 );
    }
    
    difficultytier = difficultytier ?? 0;
    return int( difficultytier );
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0x762b2be1, Offset: 0x48f
// Size: 0x4c
function function_8c9d01de760456ce( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    difficultytier = var_144de98b63c7a63b.difficultytier ?? 0;
    return int( difficultytier );
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0x9b5eb5b7, Offset: 0x4e4
// Size: 0x81, Type: bool
function function_e55fda458ce2c4cc( activityinstance )
{
    difficulty = function_811f0cd70af471de( activityinstance );
    
    if ( !difficulty )
    {
        assertmsg( "<dev string:x89>" + activityinstance.varianttag );
        return false;
    }
    
    scoreevent = namespace_34bb2a33b8502c64::get_score_event( activityinstance, difficulty );
    
    if ( !scoreevent )
    {
        assertmsg( "<dev string:xac>" + activityinstance.varianttag );
        return false;
    }
    
    return rank::getscoreinfovalue( scoreevent ) ?? 0;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xd380ddcc, Offset: 0x56e
// Size: 0x3a
function function_811f0cd70af471de( activityinstance )
{
    difficulty = activityinstance.var_546e4eb5269dbafa ?? activityinstance.difficulty_region;
    
    if ( !difficulty )
    {
        return;
    }
    
    return difficulty;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xea46addc, Offset: 0x5b1
// Size: 0x77
function function_a74c120ee76094a2( activityinstance )
{
    difficultystr = function_811f0cd70af471de( activityinstance );
    
    if ( !isdefined( difficultystr ) )
    {
        return;
    }
    
    if ( !level.region_difficulty_manager.region_difficulty_to_int )
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    difficulty = level.region_difficulty_manager.region_difficulty_to_int[ difficultystr ];
    
    if ( !isdefined( difficulty ) )
    {
        return;
    }
    
    return difficulty;
}

// Namespace ob_activity_definition_utils
// Params 3
// Checksum 0x26b1a6dc, Offset: 0x631
// Size: 0x5f
function function_f23bdcfc447427ae( playerlist, startingprogress, maxprogress )
{
    activity_definition_utils::updateprogress( startingprogress, self, maxprogress, { #players:playerlist } );
    rewardamount = function_e55fda458ce2c4cc( self );
    activity_definition_utils::updatereward( rewardamount, self, { #players:playerlist } );
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0x85580717, Offset: 0x698
// Size: 0x4a
function function_34024c4b393d3065( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    
    if ( !isdefined( var_144de98b63c7a63b.var_7e8538682484a1e6 ) )
    {
        return 0;
    }
    
    return var_144de98b63c7a63b.var_7e8538682484a1e6;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0x39c91f4e, Offset: 0x6eb
// Size: 0x47, Type: bool
function function_3b4776b96de74fb9( activityinstance )
{
    if ( !activity_participation::function_5d733a45bcf51ef1( activityinstance ) )
    {
        return false;
    }
    
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( activityinstance );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return istrue( var_144de98b63c7a63b.var_e41dffe16875b1e1 );
}

// Namespace ob_activity_definition_utils
// Params 2, eflags: 0x4
// Checksum 0x3deca6c4, Offset: 0x73b
// Size: 0x106
function private function_cc0a551aeddbf39f( var_e0bbf417e9178e6, difficultytier = 0 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    var_208d4703b355998 = undefined;
    
    switch ( difficultytier )
    {
        case 0:
            var_208d4703b355998 = var_144de98b63c7a63b.var_8fd0e552c0151a9b;
            break;
        case 1:
            var_208d4703b355998 = var_144de98b63c7a63b.var_8fd0e452c0151868;
            break;
        case 2:
            var_208d4703b355998 = var_144de98b63c7a63b.var_8fd0e752c0151f01;
            break;
        case 3:
            var_208d4703b355998 = var_144de98b63c7a63b.var_8fd0e652c0151cce;
            break;
        case 4:
            var_208d4703b355998 = var_144de98b63c7a63b.var_8fd0e952c0152367;
            break;
        default:
            assertmsg( "<dev string:x119>" + difficultytier + "<dev string:x131>" );
            break;
    }
    
    return var_208d4703b355998;
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xaae314ae, Offset: 0x84a
// Size: 0x39, Type: bool
function function_e0417ab27e1c8990( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    return istrue( var_144de98b63c7a63b.var_f10d313a8e39dbda );
}

// Namespace ob_activity_definition_utils
// Params 1
// Checksum 0xcee01ddc, Offset: 0x88c
// Size: 0x56
function function_b56b6f51a8627848( var_e0bbf417e9178e6 )
{
    var_144de98b63c7a63b = activity_definition_utils::function_e9cffc15e34b2ea3( var_e0bbf417e9178e6 );
    var_144de98b63c7a63b = var_144de98b63c7a63b.var_733d5dc436b56f2e;
    var_b6d4b39a3d555217 = var_144de98b63c7a63b.var_a333c37d22e3412e;
    
    if ( var_b6d4b39a3d555217.size )
    {
        return var_b6d4b39a3d555217[ 0 ].variant_object;
    }
}

// Namespace ob_activity_definition_utils
// Params 2
// Checksum 0x411d335d, Offset: 0x8eb
// Size: 0xd0
function function_5620c3a2241ef9c5( activityinstance, var_b1fa80e8a41b41ed )
{
    if ( !activityinstance )
    {
        assertmsg( "<dev string:x1a2>" );
        return;
    }
    
    if ( !var_b1fa80e8a41b41ed )
    {
        assertmsg( "<dev string:x1c0>" );
        return;
    }
    
    difficulty = function_a74c120ee76094a2( activityinstance );
    
    if ( isdefined( difficulty ) )
    {
        var_8f6ba110cb8ff3b4 = hashcat( var_b1fa80e8a41b41ed, "_", difficulty );
        hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", var_8f6ba110cb8ff3b4 );
        
        if ( isdefined( hovercardid ) )
        {
            return hovercardid;
        }
        else
        {
            iprintln( "Get difficulty hovercard bundle varinat failed for difficulty [" + difficulty + "]" );
        }
    }
    
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", var_b1fa80e8a41b41ed );
    assert( isdefined( hovercardid ), "<dev string:x1e2>" + getxhashsourcename( var_b1fa80e8a41b41ed ) );
    return hovercardid;
}

