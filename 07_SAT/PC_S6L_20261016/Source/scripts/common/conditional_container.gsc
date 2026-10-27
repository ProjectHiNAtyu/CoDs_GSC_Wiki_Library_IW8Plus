// scripts\common\conditional_container.gsc  (hash_54f6d121e91434f8.gscc) (size: 2766 Bytes / 0xace / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x741822dd (1947738845)
// size ...... 2766 (0xace)
// includes .. 0   (offset: 0xa66)
// strings ... 1   (offset: 0xa66)
// dev strs .. 6   (offset: 0xa76)
// exports ... 12  (offset: 0x68a)
// cseg ...... 0x71 + 0x619 (0x68a)
// imports ... 16  (offset: 0x86a)
// animtree1 . 0   (offset: 0xace)
// animtree2 . 0   (offset: 0xace)
#namespace conditional_container;

// Namespace conditional_container
// Params 0
// Checksum 0x8ba34fe, Offset: 0x8f
// Size: 0x17
function function_3c3be461141746c0()
{
    self.conditions = [];
    self.var_6282ae60ffa66695 = 1;
}

// Namespace conditional_container
// Params 0
// Checksum 0xe8682187, Offset: 0xae
// Size: 0x1a
function function_c60cc45fbd15f1c1()
{
    conditionalcontainer = {};
    conditionalcontainer function_3c3be461141746c0();
    return conditionalcontainer;
}

// Namespace conditional_container
// Params 0
// Checksum 0xdfbf99e0, Offset: 0xd1
// Size: 0xc, Type: bool
function function_6282ae60ffa66695()
{
    return istrue( self.var_6282ae60ffa66695 );
}

// Namespace conditional_container
// Params 5
// Checksum 0x35879f51, Offset: 0xe6
// Size: 0xc8
function addcondition( conditionalcontainer, conditionalfunction, var_d1443a36c450aa68 = undefined, uniquename = undefined, description = "No Description Given." )
{
    assert( conditionalcontainer function_6282ae60ffa66695(), "<dev string:x24>" );
    conditioninfo = spawnstruct();
    conditioninfo.function = conditionalfunction;
    conditioninfo.params = var_d1443a36c450aa68 ?? [];
    conditioninfo.uniquename = uniquename;
    conditioninfo.description = description;
    conditionalcontainer.conditions[ conditionalcontainer.conditions.size ] = conditioninfo;
}

// Namespace conditional_container
// Params 2
// Checksum 0xb5d8b92c, Offset: 0x1b6
// Size: 0xa2
function removecondition( conditionalcontainer, uniquename )
{
    assert( conditionalcontainer function_6282ae60ffa66695(), "<dev string:x24>" );
    
    for ( index = 0; index < conditionalcontainer.conditions.size ; index++ )
    {
        conditioninfo = conditionalcontainer.conditions[ index ];
        
        if ( conditioninfo.uniquename == uniquename )
        {
            conditionalcontainer.conditions[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( conditionalcontainer.conditions );
            }
            
            break;
        }
    }
}

// Namespace conditional_container
// Params 1
// Checksum 0x56137339, Offset: 0x260
// Size: 0x2e
function removeallconditions( conditionalcontainer )
{
    assert( conditionalcontainer function_6282ae60ffa66695(), "<dev string:x24>" );
    conditionalcontainer.conditions = [];
}

// Namespace conditional_container
// Params 4, eflags: 0x40 variadic
// Checksum 0xe628da2a, Offset: 0x296
// Size: 0xe0, Type: bool
function function_33051347e9187361( conditionalcontainer, object, ... )
{
    assert( conditionalcontainer function_6282ae60ffa66695(), "<dev string:x24>" );
    
    foreach ( condition in conditionalcontainer.conditions )
    {
        result = [[ condition.function ]]( object, condition.params, flat_args( vararg, varargcount ) );
        
        if ( !result )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace conditional_container
// Params 2
// Checksum 0x77214d3d, Offset: 0x37f
// Size: 0xe1
function function_fc04dbbd557e99c1( conditionalcontainer, object )
{
    assert( conditionalcontainer function_6282ae60ffa66695(), "<dev string:x24>" );
    
    foreach ( condition in conditionalcontainer.conditions )
    {
        result = [[ condition.function ]]( object, condition.params );
        
        if ( !result )
        {
            return function_4c46604471deb316( 0, condition.description );
        }
    }
    
    return function_4c46604471deb316( 1 );
}

// Namespace conditional_container
// Params 6
// Checksum 0xb755fa9d, Offset: 0x469
// Size: 0x101
function function_d3aa02b26606173a( conditionalcontainer, object, var_b426657b9730a092, var_9b95f84d12846873, var_2dc5fd48a3e54b50, var_c5874b01823cd986 )
{
    /#
        var_6282ae60ffa66695 = conditionalcontainer function_6282ae60ffa66695();
        objectisdefined = isdefined( object );
        var_1dde9a05823e9d3b = isfunction( var_b426657b9730a092 );
        var_27f543f503d37795 = !isdefined( var_9b95f84d12846873 ) || isstruct( var_9b95f84d12846873 );
        var_7f83189e6881e350 = 1;
        
        if ( !var_6282ae60ffa66695 )
        {
            iprintln( "<dev string:x97>" );
            var_7f83189e6881e350 = 0;
        }
        
        if ( !objectisdefined )
        {
            iprintln( "<dev string:xcc>" );
            var_7f83189e6881e350 = 0;
        }
        
        if ( !var_1dde9a05823e9d3b )
        {
            iprintln( "<dev string:xf5>" );
            var_7f83189e6881e350 = 0;
        }
        
        if ( !var_27f543f503d37795 )
        {
            iprintln( "<dev string:x153>" );
            var_7f83189e6881e350 = 0;
        }
        
        if ( !var_7f83189e6881e350 )
        {
            assertmsg( "<dev string:x1b7>" );
            return;
        }
    #/
    
    level thread function_863f05770b1d4a9b( conditionalcontainer, object, var_b426657b9730a092, var_9b95f84d12846873, var_2dc5fd48a3e54b50, var_c5874b01823cd986 );
}

// Namespace conditional_container
// Params 6, eflags: 0x4
// Checksum 0xadf6da9a, Offset: 0x572
// Size: 0xc0
function private function_863f05770b1d4a9b( conditionalcontainer, object, var_b426657b9730a092, var_9b95f84d12846873, var_2dc5fd48a3e54b50 = 5, var_c5874b01823cd986 = 0.5 )
{
    var_8682d885f65314ac = gettime();
    shouldcontinuecheckingconditions = 1;
    
    while ( shouldcontinuecheckingconditions )
    {
        var_38ab1a8ecfb1cfbd = gettime();
        timepassedinseconds = ( var_38ab1a8ecfb1cfbd - var_8682d885f65314ac ) / 1000;
        
        if ( isdefined( object ) && function_33051347e9187361( conditionalcontainer, object ) )
        {
            object thread [[ var_b426657b9730a092 ]]( var_9b95f84d12846873 );
            shouldcontinuecheckingconditions = 0;
            return;
        }
        
        if ( timepassedinseconds >= var_2dc5fd48a3e54b50 )
        {
            shouldcontinuecheckingconditions = 0;
            break;
        }
        
        wait var_c5874b01823cd986;
    }
}

// Namespace conditional_container
// Params 2, eflags: 0x4
// Checksum 0xdb339950, Offset: 0x63a
// Size: 0x4f
function private function_4c46604471deb316( var_bc7b5eb4839d0fe2, description = "No Description Given." )
{
    var_d71556941cd70208 = spawnstruct();
    var_d71556941cd70208.var_2060d7fd72693be3 = var_bc7b5eb4839d0fe2;
    var_d71556941cd70208.var_59e679186bcfdb0f = description;
    return var_d71556941cd70208;
}

