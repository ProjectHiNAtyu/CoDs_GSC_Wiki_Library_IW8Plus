// scripts\common\scene_sequence.gsc  (hash_4303fcad8bc43532.gscc) (size: 5384 Bytes / 0x1508 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7989a73 (127441523)
// size ...... 5384 (0x1508)
// includes .. 2   (offset: 0x14a4)
// strings ... 6   (offset: 0x14b4)
// dev strs .. 0   (offset: 0x1508)
// exports ... 13  (offset: 0x1044)
// cseg ...... 0xc6 + 0xf7e (0x1044)
// imports ... 18  (offset: 0x124c)
// animtree1 . 0   (offset: 0x1508)
// animtree2 . 0   (offset: 0x1508)
#using scripts\common\scene;
#using scripts\common\utility;

#namespace scene_sequence;

/#

    // Namespace scene_sequence
    // Params 0
    // Checksum 0xb9453ade, Offset: 0xe4
    // Size: 0x5, Type: dev
    function init_sequences()
    {
        
    }

#/

// Namespace scene_sequence
// Params 3
// Checksum 0x497073b2, Offset: 0xf1
// Size: 0x3e3
function scene_sequence_play( existingentities, sequencename, defaultscenename )
{
    seqroot = self;
    
    /#
    #/
    
    var_60b1997e773d6932 = [];
    sequencebundle = getscriptbundle( "sequencescriptbundle:" + sequencename );
    seqroot.scenesequence = spawnstruct();
    seqroot.scenesequence.sequencename = sequencename;
    seqroot.scenesequence.sequencebundle = sequencebundle;
    seqroot.existingentities = existingentities;
    seqroot.scenesequence.nodes = [];
    seqroot.scenesequence.scenestructs = [];
    seqroot.scenesequence.running = [];
    startnode = undefined;
    defaultshotnames = undefined;
    
    foreach ( scenenode in sequencebundle.sequencenodes )
    {
        seqroot.scenesequence.nodes[ scenenode.name ] = scenenode;
        
        if ( scenenode.var_901b3984e940f748 && !isdefined( startnode ) )
        {
            startnode = scenenode;
        }
        
        if ( !isdefined( scenenode.scene ) )
        {
            if ( isdefined( defaultscenename ) )
            {
                scenenode.scene = defaultscenename;
                
                if ( !isdefined( defaultshotnames ) )
                {
                    defaultscenebundle = getscriptbundle( "scenescriptbundle:" + scenenode.scene );
                    defaultshotnames = defaultscenebundle scene::get_shot_names();
                }
                
                if ( !isdefined( var_60b1997e773d6932[ scenenode.scene ] ) && arraycontains( defaultshotnames, scenenode.shot ) )
                {
                    var_60b1997e773d6932[ scenenode.scene ] = scenenode.scene;
                }
            }
            
            continue;
        }
        
        if ( isdefined( scenenode.scene ) && !isdefined( var_60b1997e773d6932[ scenenode.scene ] ) )
        {
            var_60b1997e773d6932[ scenenode.scene ] = scenenode.scene;
        }
    }
    
    foreach ( scenename in var_60b1997e773d6932 )
    {
        existingstructindex = -1;
        
        if ( isdefined( level.var_18c87c2c4c3b0a2d ) )
        {
            for ( i = 0; i < level.var_18c87c2c4c3b0a2d.size ; i++ )
            {
                if ( level.var_18c87c2c4c3b0a2d[ i ] == scenename )
                {
                    existingstructindex = i;
                    break;
                }
            }
        }
        
        if ( existingstructindex >= 0 )
        {
            seqroot.scenesequence.scenestructs[ scenename ] = level.a_scene_structs[ existingstructindex ];
            continue;
        }
        
        seqroot.scenesequence.scenestructs[ scenename ] = spawnstruct();
        seqroot.scenesequence.scenestructs[ scenename ].origin = seqroot.origin;
        seqroot.scenesequence.scenestructs[ scenename ].angles = seqroot.angles;
    }
    
    thread start_sequence( startnode );
}

// Namespace scene_sequence
// Params 1, eflags: 0x4
// Checksum 0x7e8bb4b9, Offset: 0x4dc
// Size: 0x31
function private start_sequence( startnode )
{
    seqroot = self;
    seqroot thread play_next_node( startnode );
    seqroot waittill( #"sequence_finished" );
}

// Namespace scene_sequence
// Params 5, eflags: 0x4
// Checksum 0xfc0a2a7f, Offset: 0x515
// Size: 0xb5
function private play_node( scenestruct, shot, scene, existingentities, earlyexitconditions )
{
    foreach ( conditionname in earlyexitconditions )
    {
        self endon( conditionname );
    }
    
    scene::play( existingentities, shot, scene );
    scenestruct notify( "Complete" + shot );
}

// Namespace scene_sequence
// Params 1, eflags: 0x4
// Checksum 0x54b795d1, Offset: 0x5d2
// Size: 0x439
function private play_next_node( currentnode )
{
    seqroot = self;
    scenestruct = seqroot.scenesequence.scenestructs[ currentnode.scene ];
    seqroot.scenesequence.running[ currentnode.scene + "-" + currentnode.shot ] = scenestruct;
    var_4e7576f5b4b3ec2e = [];
    var_a4022ff6bad8a94c = [];
    var_6480f2ab48de6c07 = [];
    var_2aa5a6461aa0b8f9 = undefined;
    
    foreach ( condition in currentnode.sequenceconnectors )
    {
        if ( condition.nextsequencenodes.size > 0 )
        {
            if ( condition.outputcondition == "ConditionAndActive" )
            {
                var_6480f2ab48de6c07[ var_6480f2ab48de6c07.size ] = condition;
                var_4e7576f5b4b3ec2e[ var_4e7576f5b4b3ec2e.size ] = condition;
                var_a4022ff6bad8a94c[ var_a4022ff6bad8a94c.size ] = condition.name;
                continue;
            }
            
            if ( condition.outputcondition == "ConditionAndComplete" )
            {
                var_6480f2ab48de6c07[ var_6480f2ab48de6c07.size ] = condition;
                continue;
            }
            
            var_2aa5a6461aa0b8f9 = condition;
        }
    }
    
    seqroot thread play_node( scenestruct, currentnode.shot, currentnode.scene, seqroot.existingentities, var_a4022ff6bad8a94c );
    
    foreach ( condition in var_4e7576f5b4b3ec2e )
    {
        if ( seqroot utility::ent_flag_exist( condition.name ) )
        {
            seqroot thread finish_node( currentnode, condition );
            return;
        }
    }
    
    var_a4022ff6bad8a94c[ var_a4022ff6bad8a94c.size ] = "Complete" + currentnode.shot;
    completedconditionname = scenestruct utility::waittill_any_in_array_return( var_a4022ff6bad8a94c );
    
    if ( completedconditionname == "Complete" + currentnode.shot )
    {
        if ( !isdefined( var_2aa5a6461aa0b8f9 ) && var_6480f2ab48de6c07.size > 0 )
        {
            var_3657fd963a1bfddf = [];
            
            foreach ( condition in var_6480f2ab48de6c07 )
            {
                var_3657fd963a1bfddf[ var_3657fd963a1bfddf.size ] = condition.name;
            }
            
            completedconditionname = scenestruct utility::waittill_any_in_array_return( var_3657fd963a1bfddf );
        }
        
        foreach ( condition in var_6480f2ab48de6c07 )
        {
            if ( completedconditionname == condition.name || seqroot utility::ent_flag_exist( condition.name ) )
            {
                seqroot thread finish_node( currentnode, condition );
                return;
            }
        }
        
        seqroot thread finish_node( currentnode, var_2aa5a6461aa0b8f9 );
        return;
    }
    
    foreach ( condition in var_4e7576f5b4b3ec2e )
    {
        if ( completedconditionname == condition.name || seqroot utility::ent_flag_exist( condition.name ) )
        {
            seqroot thread finish_node( currentnode, condition );
            return;
        }
    }
}

// Namespace scene_sequence
// Params 2, eflags: 0x4
// Checksum 0xec688538, Offset: 0xa13
// Size: 0x168
function private finish_node( currentnode, exitcondition )
{
    seqroot = self;
    seqroot.scenesequence.running[ currentnode.scene + "-" + currentnode.shot ] = undefined;
    scenestruct = seqroot.scenesequence.scenestructs[ currentnode.scene ];
    scenestruct function_b47fdd827a56b468( currentnode.shot );
    
    if ( isdefined( exitcondition ) )
    {
        foreach ( nextnodename in exitcondition.nextsequencenodes )
        {
            nextnode = seqroot.scenesequence.nodes[ nextnodename.var_80096c6ee9b61a39 ];
            seqroot thread play_next_node( nextnode );
        }
    }
    
    waitframe();
    
    if ( seqroot.scenesequence.running.size == 0 )
    {
        seqroot notify( #"sequence_finished" );
    }
}

// Namespace scene_sequence
// Params 1
// Checksum 0x83effcb7, Offset: 0xb83
// Size: 0xc5
function function_db451eed38abdc9a( note )
{
    seqroot = self;
    seqroot notify( note );
    
    if ( isdefined( seqroot.scenesequence ) && isdefined( seqroot.scenesequence.scenestructs ) )
    {
        foreach ( scenestruct in seqroot.scenesequence.scenestructs )
        {
            scenestruct notify( note );
        }
    }
}

// Namespace scene_sequence
// Params 4
// Checksum 0xe9213dcd, Offset: 0xc50
// Size: 0xe4
function function_ce5a40bc9a076cf8( notifytarget, note, objectname, repeat )
{
    seqroot = self;
    
    if ( isdefined( seqroot.scenesequence ) && isdefined( seqroot.scenesequence.scenestructs ) )
    {
        foreach ( scenestruct in seqroot.scenesequence.scenestructs )
        {
            scenestruct scene::set_notify_note( notifytarget, note, objectname, repeat );
        }
    }
}

// Namespace scene_sequence
// Params 1
// Checksum 0x371cf90, Offset: 0xd3c
// Size: 0x1e
function function_c4633d0aaef8227b( conditionname )
{
    if ( isstring( conditionname ) )
    {
        utility::ent_flag_set( conditionname );
    }
}

// Namespace scene_sequence
// Params 1
// Checksum 0xad0435d8, Offset: 0xd62
// Size: 0x20
function function_1ed0f968979dc586( conditionname )
{
    if ( isstring( conditionname ) )
    {
        utility::ent_flag_clear( conditionname, 1 );
    }
}

// Namespace scene_sequence
// Params 5, eflags: 0x40 variadic
// Checksum 0xa8f09110, Offset: 0xd8a
// Size: 0x1df
function function_610ca1fbd65d21c8( scene, shotname, func, ... )
{
    seqroot = self;
    scenestruct = undefined;
    
    if ( isstruct( scene ) )
    {
        foreach ( st in seqroot.scenesequence.scenestructs )
        {
            if ( st == scene )
            {
                scenestruct = scene;
                break;
            }
        }
    }
    else if ( isstring( scene ) )
    {
        if ( isdefined( seqroot.scenesequence.scenestructs[ scene ] ) )
        {
            scenestruct = seqroot.scenesequence.scenestructs[ scene ];
        }
    }
    
    if ( isdefined( scenestruct ) )
    {
        if ( !isdefined( scenestruct.callbacks ) )
        {
            scenestruct.callbacks = [];
        }
        
        if ( !isdefined( scenestruct.callbacks[ shotname ] ) )
        {
            scenestruct.callbacks[ shotname ] = [];
        }
        
        index = scenestruct.callbacks[ shotname ].size;
        scenestruct.callbacks[ shotname ][ index ] = spawnstruct();
        scenestruct.callbacks[ shotname ][ index ].func = func;
        scenestruct.callbacks[ shotname ][ index ].vararg = vararg;
        scenestruct.callbacks[ shotname ][ index ].varargcount = varargcount;
    }
}

// Namespace scene_sequence
// Params 1, eflags: 0x4
// Checksum 0x8cfa5b98, Offset: 0xf71
// Size: 0xd3
function private function_b47fdd827a56b468( shotname )
{
    scenestruct = self;
    
    if ( isdefined( scenestruct.callbacks[ shotname ] ) )
    {
        foreach ( callbackstruct in scenestruct.callbacks[ shotname ] )
        {
            if ( isdefined( callbackstruct.func ) )
            {
                self [[ callbackstruct.func ]]( flat_args( callbackstruct.vararg, callbackstruct.varargcount ) );
            }
        }
    }
}

