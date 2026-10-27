// scripts\common\activity_nexus\activity_ai_encounters.gsc  (hash_2a9058c1321cd25d.gscc) (size: 13522 Bytes / 0x34d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe188b48 (236489544)
// size ...... 13522 (0x34d2)
// includes .. 9   (offset: 0x32e6)
// strings ... 11  (offset: 0x332e)
// dev strs .. 14  (offset: 0x33ca)
// exports ... 52  (offset: 0x1eae)
// cseg ...... 0x14c + 0x1d62 (0x1eae)
// imports ... 101 (offset: 0x26ce)
// animtree1 . 0   (offset: 0x34d2)
// animtree2 . 0   (offset: 0x34d2)
#using script_77873e194e406c6d;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;

#namespace activity_ai_encounters;

// Namespace activity_ai_encounters
// Params 0, eflags: 0x5
// Checksum 0x4ab06000, Offset: 0x16a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"activity_ai_encounters", undefined, &function_e381dff08069b4fe, undefined );
}

// Namespace activity_ai_encounters
// Params 0, eflags: 0x4
// Checksum 0x504b0c3b, Offset: 0x18b
// Size: 0x20
function private function_e381dff08069b4fe()
{
    utility::registersharedfunc( #"ai_spawn_director", #"activityaiencounterinit", &activityaiencounterinit );
}

// Namespace activity_ai_encounters
// Params 0
// Checksum 0xb64ffbbe, Offset: 0x1b3
// Size: 0x46
function activityaiencounterinit()
{
    activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &function_555eacddc857d64c );
    activity_common::function_2dd4f07fa5c3e911( "InstanceBegin", &function_555eacddc857d64c );
    activity_common::function_2dd4f07fa5c3e911( "ActivityEnd", &function_555eacddc857d64c );
    activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &function_555eacddc857d64c );
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0xbf1f9318, Offset: 0x201
// Size: 0x97
function function_202051e510314502( requestid, fncallback, userdata )
{
    activityinstance = self;
    assert( isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ), "<dev string:x24>" + requestid + "<dev string:x3b>" );
    assert( isfunction( fncallback ), "<dev string:x65>" );
    activityinstance.var_9c4a0b2cae577c1b[ requestid ].readytospawncallback = fncallback;
    activityinstance.var_9c4a0b2cae577c1b[ requestid ].var_85be7bf6a264b223 = userdata;
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0xe06a4de8, Offset: 0x2a0
// Size: 0x97
function function_52d1342183200a8f( requestid, fncallback, userdata )
{
    activityinstance = self;
    assert( isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ), "<dev string:x24>" + requestid + "<dev string:x3b>" );
    assert( isfunction( fncallback ), "<dev string:x65>" );
    activityinstance.var_9c4a0b2cae577c1b[ requestid ].spawnedcallback = fncallback;
    activityinstance.var_9c4a0b2cae577c1b[ requestid ].spawnedcallbackuserdata = userdata;
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0x7aab5d61, Offset: 0x33f
// Size: 0x3c
function function_982c63ff00493a21( requestid, fncallback, userdata )
{
    assert( isfunction( fncallback ), "<dev string:x65>" );
    ai_spawn_director::function_baa5d26d8804d5da( requestid, fncallback, userdata );
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0x946f45a2, Offset: 0x383
// Size: 0x3c
function function_16b0131751c4fb39( requestid, fncallback, userdata )
{
    assert( isfunction( fncallback ), "<dev string:x65>" );
    ai_spawn_director::function_5c8b22954b3bfa37( requestid, fncallback, userdata );
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0x9087578d, Offset: 0x3c7
// Size: 0x3c
function function_dcf6bdb6ee9d1ca0( requestid, fncallback, userdata )
{
    assert( isfunction( fncallback ), "<dev string:x65>" );
    ai_spawn_director::function_c99d360d62c49a9c( requestid, fncallback, userdata );
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0xb535a62d, Offset: 0x40b
// Size: 0x3c
function function_d33de057e760c97b( requestid, fncallback, userdata )
{
    assert( isfunction( fncallback ), "<dev string:x65>" );
    ai_spawn_director::function_53289c032f506bb1( requestid, fncallback, userdata );
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0x4888ac0, Offset: 0x44f
// Size: 0x3c
function function_6bf4ff2fbde584ee( requestid, fncallback, userdata )
{
    assert( isfunction( fncallback ), "<dev string:x65>" );
    ai_spawn_director::function_5a08798970350207( requestid, fncallback, userdata );
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0x71e498f, Offset: 0x493
// Size: 0x97
function function_189110951b3533d1( requestid, fncallback, userdata )
{
    activityinstance = self;
    assert( isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ), "<dev string:x24>" + requestid + "<dev string:x3b>" );
    assert( isfunction( fncallback ), "<dev string:x65>" );
    activityinstance.var_9c4a0b2cae577c1b[ requestid ].shutdowncallback = fncallback;
    activityinstance.var_9c4a0b2cae577c1b[ requestid ].shutdowncallbackuserdata = userdata;
}

// Namespace activity_ai_encounters
// Params 3
// Checksum 0xe6149db0, Offset: 0x532
// Size: 0x3c
function function_edecd8fd32cc3ec5( requestid, fncallback, userdata )
{
    assert( isfunction( fncallback ), "<dev string:x65>" );
    ai_spawn_director::add_vehicle_spawned_callback( requestid, fncallback, userdata );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0x1ba4cc44, Offset: 0x576
// Size: 0xe1
function function_a6fb1c80ed15c11b( requestid )
{
    var_ca3f65fdba0a9ed2 = level.activities;
    
    foreach ( activityinstance in var_ca3f65fdba0a9ed2.instances )
    {
        if ( isarray( activityinstance.var_9c4a0b2cae577c1b ) && isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ) )
        {
            return activityinstance;
        }
        
        if ( isarray( activityinstance.var_ec2a4274015323c4 ) && isdefined( activityinstance.var_ec2a4274015323c4[ requestid ] ) )
        {
            return activityinstance;
        }
    }
}

// Namespace activity_ai_encounters
// Params 7
// Checksum 0xea435c12, Offset: 0x660
// Size: 0xc0
function function_eb8506829193f5eb( encounterbundlename, origin, radius, enabled, var_f5ffc1c5957eb0ed, spawntype, cleanuptype )
{
    activityinstance = self;
    spawnimmediately = spawntype == 1;
    requestid = ai_spawn_director::spawn_request( encounterbundlename, origin, radius, enabled, spawnimmediately );
    
    if ( !isdefined( requestid ) )
    {
        assertmsg( "<dev string:xb4>" + encounterbundlename + "<dev string:xd7>" + activityinstance.type + "<dev string:xff>" + activityinstance.varianttag );
        return;
    }
    
    function_d30bd6aa221b3d12( requestid, var_f5ffc1c5957eb0ed, spawntype, cleanuptype );
    return requestid;
}

// Namespace activity_ai_encounters
// Params 5
// Checksum 0x36e03af4, Offset: 0x729
// Size: 0x8b
function function_1b2bc46463c552b3( requestid, enabled, var_f5ffc1c5957eb0ed, spawntype, cleanuptype )
{
    activityinstance = self;
    
    if ( !isdefined( requestid ) )
    {
        assertmsg( "<dev string:x10a>" + activityinstance.type + "<dev string:xff>" + activityinstance.varianttag );
        return;
    }
    
    function_d30bd6aa221b3d12( requestid, var_f5ffc1c5957eb0ed, spawntype, cleanuptype );
    
    if ( enabled )
    {
        function_48582991402cac50( requestid );
    }
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0xf24d37f4, Offset: 0x7bc
// Size: 0x14
function function_306a1676777f93e2( targetname )
{
    return ai_spawn_director::lookup_spawn_request( targetname );
}

// Namespace activity_ai_encounters
// Params 5
// Checksum 0x38a62557, Offset: 0x7d9
// Size: 0x9d
function function_92b671064b0b1ce2( targetname, enabled, var_f5ffc1c5957eb0ed, spawntype, cleanuptype )
{
    activityinstance = self;
    requestid = activityinstance function_306a1676777f93e2( targetname );
    
    if ( !isdefined( requestid ) )
    {
        assertmsg( "<dev string:x14f>" + targetname + "<dev string:xd7>" + activityinstance.type + "<dev string:xff>" + activityinstance.varianttag );
        return;
    }
    
    activityinstance function_1b2bc46463c552b3( requestid, enabled, var_f5ffc1c5957eb0ed, spawntype, cleanuptype );
    return requestid;
}

// Namespace activity_ai_encounters
// Params 5
// Checksum 0x639c6d73, Offset: 0x87f
// Size: 0x10d
function function_dd54dae45031dade( targetname, enabled, var_f5ffc1c5957eb0ed, spawntype, cleanuptype )
{
    activityinstance = self;
    requestids = ai_spawn_director::function_4cc9aafe98c53c7f( targetname );
    
    if ( !isdefined( requestids ) || requestids.size == 0 )
    {
        assertmsg( "<dev string:x14f>" + targetname + "<dev string:xd7>" + activityinstance.type + "<dev string:xff>" + activityinstance.varianttag );
        return [];
    }
    
    foreach ( requestid in requestids )
    {
        activityinstance function_1b2bc46463c552b3( requestid, enabled, var_f5ffc1c5957eb0ed, spawntype, cleanuptype );
    }
    
    return requestids;
}

// Namespace activity_ai_encounters
// Params 2
// Checksum 0xe9d4ec3a, Offset: 0x995
// Size: 0x7a
function function_48582991402cac50( requestid, forcespawn = 0 )
{
    activityinstance = self;
    
    if ( !( isdefined( requestid ) && isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ) ) )
    {
        assertmsg( "<dev string:x10a>" + activityinstance.type + "<dev string:xff>" + activityinstance.varianttag );
        return;
    }
    
    function_ef57f478f96b050c( requestid, 1, forcespawn );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0x6878d9a8, Offset: 0xa17
// Size: 0x6c
function function_43917fc6522a277( requestid )
{
    activityinstance = self;
    encounterrequest = activityinstance.var_9c4a0b2cae577c1b[ requestid ];
    assert( isdefined( encounterrequest ), "<dev string:x24>" + requestid + "<dev string:x3b>" );
    assert( encounterrequest.readytospawn == 1, "<dev string:x183>" );
    function_fbe9bb47edbe2d7c( requestid );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0x792636ee, Offset: 0xa8b
// Size: 0xa6
function function_2574b40bde3bd456( var_84543df2efd3eb40 )
{
    activityinstance = self;
    var_9c4a0b2cae577c1b = activityinstance.var_9c4a0b2cae577c1b ?? [];
    
    foreach ( requestid, encounterrequest in var_9c4a0b2cae577c1b )
    {
        function_21571e3b66711754( activityinstance, requestid, 0, var_84543df2efd3eb40 );
    }
}

// Namespace activity_ai_encounters
// Params 2
// Checksum 0xf09249d2, Offset: 0xb39
// Size: 0x54
function function_46dadc3aca2ffac0( requestid, var_c60a13eba6baced )
{
    activityinstance = self;
    assert( isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ), "<dev string:x24>" + requestid + "<dev string:x3b>" );
    function_21571e3b66711754( activityinstance, requestid, 0, var_c60a13eba6baced );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0xa6510d54, Offset: 0xb95
// Size: 0xd5
function function_ef590f5a067bcaf5( cleanuptype )
{
    activityinstance = self;
    var_9c4a0b2cae577c1b = activityinstance.var_9c4a0b2cae577c1b ?? [];
    
    foreach ( requestid, encounterrequest in var_9c4a0b2cae577c1b )
    {
        if ( !isdefined( cleanuptype ) || cleanuptype == encounterrequest.cleanuptype )
        {
            var_8c0b9efa3145cbb4 = encounterrequest.cleanuptype == 2;
            function_21571e3b66711754( activityinstance, requestid, var_8c0b9efa3145cbb4 );
        }
    }
}

// Namespace activity_ai_encounters
// Params 0
// Checksum 0xd86281fa, Offset: 0xc72
// Size: 0xb2
function function_cb88eba0bb17a5e4()
{
    activityinstance = self;
    var_9c4a0b2cae577c1b = activityinstance.var_9c4a0b2cae577c1b ?? [];
    
    foreach ( requestid, encounterrequest in var_9c4a0b2cae577c1b )
    {
        var_8c0b9efa3145cbb4 = encounterrequest.cleanuptype == 2;
        function_21571e3b66711754( activityinstance, requestid, var_8c0b9efa3145cbb4 );
    }
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0xf8c7c2ec, Offset: 0xd2c
// Size: 0x49
function function_1010ba035d94f9f1( requestid )
{
    activityinstance = self;
    var_8c0b9efa3145cbb4 = activityinstance.var_9c4a0b2cae577c1b[ requestid ].cleanuptype == 2;
    function_21571e3b66711754( activityinstance, requestid, var_8c0b9efa3145cbb4 );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0xcbb05faa, Offset: 0xd7d
// Size: 0x19, Type: bool
function function_e9bac21ccee7cf24( requestid )
{
    return isdefined( self.var_9c4a0b2cae577c1b[ requestid ] );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0xfa237169, Offset: 0xd9f
// Size: 0x15
function function_1f7aca3631296bd1( activityinstance )
{
    thread function_d6330d3f62fdb631( activityinstance );
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0x5dc9a70d, Offset: 0xdbc
// Size: 0x51
function function_39a20a8349bc2670( activityinstance )
{
    activityinstance notify( #"hash_51491ff04ff7016e" );
    
    if ( !function_4963294f0c81db42( activityinstance ) )
    {
        var_a6cf6e2e0cc37ee5 = activity_definition_utils::function_a20ffdf4fe1e295( activityinstance );
        activityinstance function_b048911d4c36d40f( 1, var_a6cf6e2e0cc37ee5 );
        function_6b277b1f57cd16b9( activityinstance, 1 );
    }
}

// Namespace activity_ai_encounters
// Params 1
// Checksum 0x3031e556, Offset: 0xe15
// Size: 0x28, Type: bool
function function_4963294f0c81db42( activityinstance )
{
    return activityinstance.var_e67357faa85c7ff6 || !isdefined( activityinstance.var_e67357faa85c7ff6 );
}

// Namespace activity_ai_encounters
// Params 6
// Checksum 0x6a414884, Offset: 0xe46
// Size: 0x134
function function_79c1b913ce172ac5( activity_instance, triggers_targetname, triggered_callback = undefined, var_c4dca161a9a26082 = undefined, var_53a9527b68265005 = undefined, monitor_encounter_end = 0 )
{
    encounter_triggers = getnoentvolumearray( triggers_targetname, #targetname );
    
    if ( encounter_triggers.size == 0 )
    {
        encounter_triggers = getentarray( triggers_targetname, #targetname );
    }
    
    foreach ( trigger in encounter_triggers )
    {
        assert( isdefined( trigger.script_noteworthy ), "<dev string:x1f5>" );
        thread function_a17e48a0fc2a28fc( activity_instance, trigger, trigger.script_noteworthy, triggered_callback, var_c4dca161a9a26082, var_53a9527b68265005, monitor_encounter_end );
        
        /#
            thread function_be06be8b47089278( trigger );
        #/
    }
}

// Namespace activity_ai_encounters
// Params 5
// Checksum 0x12881cf5, Offset: 0xf82
// Size: 0x215
function function_e9091e3a4b3537eb( activity_instance, encounter_volume_targetname, var_7b7d960e0f92a721, var_90c65bcf0094571c, var_f08b3bc303ab362c = undefined )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    encounter_id = function_92b671064b0b1ce2( encounter_volume_targetname, 1, 1, 1, 2 );
    var_bc38f415a9ff335d = { #encounter_id:encounter_id, #var_90c65bcf0094571c:var_90c65bcf0094571c, #var_7b7d960e0f92a721:var_7b7d960e0f92a721, #agent_array:[] };
    
    if ( isdefined( encounter_id ) )
    {
        activity_instance function_6bf4ff2fbde584ee( encounter_id, &function_ead560db726e1f2a, var_bc38f415a9ff335d );
        ai_spawn_director::add_spawned_callback( encounter_id, &function_156e9fb95f9aeb9b, var_bc38f415a9ff335d );
        var_bc38f415a9ff335d waittill( #"hash_7364c9803d78f212" );
        
        foreach ( extra_agent in var_f08b3bc303ab362c )
        {
            if ( extra_agent && isalive( extra_agent ) )
            {
                var_bc38f415a9ff335d.agent_array[ var_bc38f415a9ff335d.agent_array.size ] = extra_agent;
            }
        }
        
        foreach ( agent in var_bc38f415a9ff335d.agent_array )
        {
            if ( agent && isalive( agent ) )
            {
                childthread function_cf125c0068ad5cd( agent, var_bc38f415a9ff335d );
            }
        }
    }
    else
    {
        utility::flag_set( var_7b7d960e0f92a721 );
    }
    
    return [ encounter_id, var_bc38f415a9ff335d.agent_array ];
}

// Namespace activity_ai_encounters
// Params 2, eflags: 0x4
// Checksum 0xe5f7132a, Offset: 0x11a0
// Size: 0x1c0
function private function_cf125c0068ad5cd( agent, var_bc38f415a9ff335d )
{
    agent waittill( #"death" );
    
    if ( !isdefined( agent ) )
    {
        var_bc38f415a9ff335d.agent_array = function_5713d46873b29625( var_bc38f415a9ff335d.agent_array );
    }
    else
    {
        var_bc38f415a9ff335d.agent_array = arrayremove( var_bc38f415a9ff335d.agent_array, agent );
    }
    
    if ( var_bc38f415a9ff335d.agent_array.size <= 0 )
    {
        utility::flag_set( var_bc38f415a9ff335d.var_7b7d960e0f92a721 );
        
        if ( var_bc38f415a9ff335d.encounter_id )
        {
            ai_spawn_director::cancel_spawn_request( var_bc38f415a9ff335d.encounter_id );
        }
        
        return;
    }
    
    if ( var_bc38f415a9ff335d.agent_array.size <= var_bc38f415a9ff335d.var_90c65bcf0094571c )
    {
        foreach ( tracked_agent in var_bc38f415a9ff335d.agent_array )
        {
            if ( isai( tracked_agent ) )
            {
                closest_player = function_47c86977a18df38b( level.players, tracked_agent.origin );
                
                if ( !closest_player )
                {
                    if ( tracked_agent.favorite_enemy )
                    {
                        continue;
                    }
                    
                    do
                    {
                        waitframe();
                        closest_player = function_47c86977a18df38b( level.players, tracked_agent.origin );
                    }
                    while ( !closest_player );
                }
                
                tracked_agent.goalradius = 1024;
                tracked_agent.favorite_enemy = closest_player;
                tracked_agent setgoalentity( closest_player );
            }
        }
    }
}

// Namespace activity_ai_encounters
// Params 2, eflags: 0x4
// Checksum 0xff84b68b, Offset: 0x1368
// Size: 0x22
function private function_ead560db726e1f2a( requestid, var_bc38f415a9ff335d )
{
    var_bc38f415a9ff335d notify( #"hash_7364c9803d78f212" );
}

// Namespace activity_ai_encounters
// Params 4, eflags: 0x4
// Checksum 0x2df4a080, Offset: 0x1392
// Size: 0x42
function private function_156e9fb95f9aeb9b( requestid, var_bc38f415a9ff335d, agent, data )
{
    var_bc38f415a9ff335d.agent_array[ var_bc38f415a9ff335d.agent_array.size ] = agent;
}

// Namespace activity_ai_encounters
// Params 7, eflags: 0x4
// Checksum 0x10f9e2ec, Offset: 0x13dc
// Size: 0xfb
function private function_a17e48a0fc2a28fc( activity_instance, trigger, encounter_name, triggered_callback, var_c4dca161a9a26082, var_53a9527b68265005, monitor_encounter_end )
{
    trigger endon( #"delete" );
    
    do
    {
        trigger waittill( #"trigger", player );
    }
    while ( !isplayer( player ) );
    
    if ( monitor_encounter_end )
    {
        [ encounter_id, agents ] = function_e9091e3a4b3537eb( self, encounter_name, encounter_name + "_completed", 4 );
    }
    else
    {
        encounter_id = function_92b671064b0b1ce2( encounter_name, 1, 1, 1, 2 );
    }
    
    if ( var_c4dca161a9a26082 )
    {
        thread ai_spawn_director::add_spawned_callback( encounter_id, var_c4dca161a9a26082 );
    }
    
    if ( var_53a9527b68265005 )
    {
        thread ai_spawn_director::add_vehicle_spawned_callback( encounter_id, var_53a9527b68265005 );
    }
    
    if ( triggered_callback )
    {
        [[ triggered_callback ]]( activity_instance, encounter_name, player );
    }
    
    function_45b4998f4a9853ae( encounter_name );
}

// Namespace activity_ai_encounters
// Params 1, eflags: 0x4
// Checksum 0x3f716165, Offset: 0x14df
// Size: 0x95
function private function_45b4998f4a9853ae( encounter_name )
{
    var_afad82b174da5696 = getnoentvolumearray( encounter_name, #script_noteworthy );
    
    foreach ( trig in var_afad82b174da5696 )
    {
        trig delete();
    }
}

// Namespace activity_ai_encounters
// Params 4
// Checksum 0xc165af49, Offset: 0x157c
// Size: 0x74
function function_952687d67d74fdef( requestid, instance, agent, ai_data )
{
    closest_player = function_47c86977a18df38b( level.players, agent.origin );
    
    if ( closest_player )
    {
        agent getenemyinfo( closest_player );
        agent forcethreatupdate();
        agent function_fa32376aaa88a7a2( closest_player.origin, 1024 );
    }
}

/#

    // Namespace activity_ai_encounters
    // Params 1, eflags: 0x4
    // Checksum 0x5b92585e, Offset: 0x15f8
    // Size: 0x74, Type: dev
    function private function_be06be8b47089278( trigger )
    {
        trigger endon( #"delete" );
        
        while ( true )
        {
            if ( trigger )
            {
                drawtrigger( trigger, ( 1, 0, 0 ) );
                print3d( trigger.origin, "<dev string:x244>" + trigger.script_noteworthy, ( 0, 1, 0 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace activity_ai_encounters
// Params 2, eflags: 0x4
// Checksum 0xc094a807, Offset: 0x1674
// Size: 0x78
function private function_6b277b1f57cd16b9( activityinstance, var_e67357faa85c7ff6 )
{
    activityinstance.var_e67357faa85c7ff6 = istrue( var_e67357faa85c7ff6 );
    
    /#
        if ( namespace_634561435cfb3169::function_a940a26e08d4ac7e( @"hash_ca2c42defef1a832" ) )
        {
            if ( activityinstance.var_e67357faa85c7ff6 )
            {
                namespace_634561435cfb3169::activitynexuslog( "<dev string:x24c>", @"hash_ca2c42defef1a832", activityinstance );
                return;
            }
            
            namespace_634561435cfb3169::activitynexuslog( "<dev string:x29c>", @"hash_ca2c42defef1a832", activityinstance );
        }
    #/
}

// Namespace activity_ai_encounters
// Params 1, eflags: 0x4
// Checksum 0xf808a07a, Offset: 0x16f4
// Size: 0xc5
function private function_d6330d3f62fdb631( activityinstance )
{
    activityinstance endon( #"hash_51491ff04ff7016e" );
    activityinstance endon( #"instance_destroyed" );
    activitynexussettings = level.activities.activitynexussettings;
    
    if ( activity_definition_utils::function_b6096963d0181099( activityinstance ) && function_4963294f0c81db42( activityinstance ) )
    {
        var_2d4d75095474bc50 = activity_definition_utils::function_79a44503e178233f( activityinstance );
        activityinstance function_b048911d4c36d40f( 0, 0, var_2d4d75095474bc50 );
        function_6b277b1f57cd16b9( activityinstance, 0 );
        centercanmove = activity_instance_common::function_188180ca913da025( activityinstance );
        
        while ( centercanmove )
        {
            wait getdvarfloat( @"hash_b1b13b4fc75d3cd7", activitynexussettings.var_af7244e149179e50 );
            activityinstance function_b048911d4c36d40f( 0, 0, var_2d4d75095474bc50 );
        }
    }
}

// Namespace activity_ai_encounters
// Params 2, eflags: 0x4
// Checksum 0x37526ade, Offset: 0x17c1
// Size: 0xb2
function private function_e4f3a1cb33c801b0( requestid, activityinstance )
{
    encounterrequest = activityinstance.var_9c4a0b2cae577c1b[ requestid ];
    
    if ( isdefined( encounterrequest ) )
    {
        encounterrequest.readytospawn = 1;
        
        if ( encounterrequest.spawntype == 0 )
        {
            activityinstance function_43917fc6522a277( requestid );
            function_e16537372da150da( activityinstance, requestid );
        }
        else if ( encounterrequest.spawntype == 1 )
        {
            activityinstance function_43917fc6522a277( requestid );
        }
        
        if ( isfunction( encounterrequest.readytospawncallback ) )
        {
            [[ encounterrequest.readytospawncallback ]]( requestid, encounterrequest.var_85be7bf6a264b223 );
        }
    }
}

// Namespace activity_ai_encounters
// Params 4, eflags: 0x4
// Checksum 0x7990ae82, Offset: 0x187b
// Size: 0x96
function private function_d7f5f3c2e9ab3bf8( requestid, activityinstance, agent, var_be99c006f4b3839e )
{
    encounterrequest = activityinstance.var_9c4a0b2cae577c1b[ requestid ];
    
    if ( isdefined( encounterrequest ) )
    {
        if ( isfunction( encounterrequest.spawnedcallback ) )
        {
            [[ encounterrequest.spawnedcallback ]]( requestid, encounterrequest.spawnedcallbackuserdata, agent, var_be99c006f4b3839e );
        }
        
        if ( encounterrequest.var_7ff390b4031bfae2 && isdefined( agent ) )
        {
            activityinstance activity_participation::function_d041ee0ec570299d( agent );
        }
    }
}

// Namespace activity_ai_encounters
// Params 1, eflags: 0x4
// Checksum 0x96b81e48, Offset: 0x1919
// Size: 0x78
function private function_555eacddc857d64c( relevantinfostruct )
{
    activityinstance = self;
    activitymoment = relevantinfostruct.activitymoment;
    
    if ( activitymoment == "ActivityBegin" )
    {
        function_b129e23a50000025( activityinstance );
    }
    
    if ( activitymoment == "ActivityEnd" )
    {
        activityinstance function_ef590f5a067bcaf5( 0 );
    }
    else if ( activitymoment == "InstanceEnd" )
    {
        activityinstance function_ef590f5a067bcaf5();
    }
    
    function_ca7132fd482af62e( activityinstance, activitymoment );
}

// Namespace activity_ai_encounters
// Params 2, eflags: 0x4
// Checksum 0xf6e62393, Offset: 0x1999
// Size: 0x5d
function private function_ca7132fd482af62e( activityinstance, activitymoment )
{
    if ( activity_definition_utils::function_b6096963d0181099( activityinstance ) )
    {
        if ( activity_definition_utils::function_2ec319b548dd67b9( activityinstance ) == activitymoment )
        {
            function_1f7aca3631296bd1( activityinstance );
            return;
        }
        
        if ( activity_definition_utils::function_73d42e405d0be3bc( activityinstance ) == activitymoment || activitymoment == "InstanceEnd" )
        {
            function_39a20a8349bc2670( activityinstance );
        }
    }
}

// Namespace activity_ai_encounters
// Params 1, eflags: 0x4
// Checksum 0x70b2145b, Offset: 0x19fe
// Size: 0xa7
function private function_b129e23a50000025( activityinstance )
{
    var_9c4a0b2cae577c1b = activityinstance.var_9c4a0b2cae577c1b ?? [];
    
    foreach ( requestid, encounterrequest in var_9c4a0b2cae577c1b )
    {
        if ( encounterrequest.spawntype == 0 )
        {
            function_43917fc6522a277( requestid );
        }
    }
}

// Namespace activity_ai_encounters
// Params 3, eflags: 0x4
// Checksum 0xa39cd706, Offset: 0x1aad
// Size: 0x78
function private function_58f3fc2a74060068( requestid, activityinstance, data )
{
    encounterrequest = activityinstance.var_9c4a0b2cae577c1b[ requestid ];
    
    if ( isdefined( encounterrequest ) )
    {
        if ( isfunction( encounterrequest.shutdowncallback ) )
        {
            [[ encounterrequest.shutdowncallback ]]( requestid, encounterrequest.shutdowncallbackuserdata, data );
        }
        
        function_21571e3b66711754( activityinstance, requestid, 0 );
    }
}

// Namespace activity_ai_encounters
// Params 4, eflags: 0x4
// Checksum 0x9094b53e, Offset: 0x1b2d
// Size: 0x72
function private function_d30bd6aa221b3d12( requestid, var_f5ffc1c5957eb0ed, spawntype, cleanuptype )
{
    activityinstance = self;
    ai_spawn_director::function_5ee28426adb3b64b( requestid, &function_e4f3a1cb33c801b0, activityinstance );
    ai_spawn_director::function_a49c35b72d6b6fea( requestid, &function_58f3fc2a74060068, activityinstance );
    ai_spawn_director::add_spawned_callback( requestid, &function_d7f5f3c2e9ab3bf8, activityinstance );
    function_b1284e91745b3233( activityinstance, requestid, spawntype, cleanuptype, var_f5ffc1c5957eb0ed );
}

// Namespace activity_ai_encounters
// Params 5, eflags: 0x4
// Checksum 0x4727efc6, Offset: 0x1ba7
// Size: 0x124
function private function_b1284e91745b3233( activityinstance, requestid, spawntype, cleanuptype, var_f5ffc1c5957eb0ed )
{
    if ( !isdefined( activityinstance.var_9c4a0b2cae577c1b ) )
    {
        activityinstance.var_9c4a0b2cae577c1b = [];
    }
    
    if ( !isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ) )
    {
        activityinstance.var_9c4a0b2cae577c1b[ requestid ] = spawnstruct();
        activityinstance.var_9c4a0b2cae577c1b[ requestid ].spawntype = spawntype;
        activityinstance.var_9c4a0b2cae577c1b[ requestid ].cleanuptype = cleanuptype;
        activityinstance.var_9c4a0b2cae577c1b[ requestid ].var_7ff390b4031bfae2 = istrue( var_f5ffc1c5957eb0ed );
        activityinstance.var_9c4a0b2cae577c1b[ requestid ].readytospawn = 0;
        
        if ( spawntype == 0 )
        {
            activity_instance_common::function_c3911b0306ab7c81( activityinstance, undefined, "Active", "Waiting for AI Director spawn approval for encounter: " + requestid );
            activityinstance.var_9c4a0b2cae577c1b[ requestid ].var_9a413db82b180c81 = 1;
        }
        
        return;
    }
    
    assertmsg( "<dev string:x2df>" );
}

// Namespace activity_ai_encounters
// Params 4, eflags: 0x4
// Checksum 0x9d614899, Offset: 0x1cd3
// Size: 0x6c
function private function_21571e3b66711754( activityinstance, requestid, var_8c0b9efa3145cbb4, var_c60a13eba6baced )
{
    if ( isdefined( activityinstance.var_9c4a0b2cae577c1b[ requestid ] ) )
    {
        function_e16537372da150da( activityinstance, requestid );
        
        if ( var_8c0b9efa3145cbb4 )
        {
            function_b43716082f77e5e5( requestid );
        }
        else
        {
            ai_spawn_director::cancel_spawn_request( requestid, 0, var_c60a13eba6baced );
        }
        
        activityinstance.var_9c4a0b2cae577c1b[ requestid ] = undefined;
    }
}

// Namespace activity_ai_encounters
// Params 2, eflags: 0x4
// Checksum 0xcc1fdee6, Offset: 0x1d47
// Size: 0x7e
function private function_e16537372da150da( activityinstance, requestid )
{
    encounterrequest = activityinstance.var_9c4a0b2cae577c1b[ requestid ];
    
    if ( isdefined( encounterrequest ) )
    {
        if ( encounterrequest.spawntype == 0 && encounterrequest.var_9a413db82b180c81 )
        {
            activity_instance_common::function_32302285cf865c56( activityinstance, undefined, "Active", "AI Director spawn approval for encounter: " + requestid + " was granted" );
            encounterrequest.var_9a413db82b180c81 = 0;
        }
    }
}

// Namespace activity_ai_encounters
// Params 3, eflags: 0x4
// Checksum 0x309743ac, Offset: 0x1dcd
// Size: 0xe1
function private function_b048911d4c36d40f( removeonly, removedelay, var_2d4d75095474bc50 )
{
    if ( spatial_zone_container::function_3819f09eefb741e2( self, "Ambient_AI_Exclusion_Zone" ) )
    {
        var_42fe5c16400a39f4 = spatial_zone_container::function_f7fc3e6c249a8256( self, "Ambient_AI_Exclusion_Zone" );
        
        for ( var_9accb85ea4605178 = 0; var_9accb85ea4605178 < var_42fe5c16400a39f4.size ; var_9accb85ea4605178++ )
        {
            var_af97402b6c3c086d = var_42fe5c16400a39f4[ var_9accb85ea4605178 ];
            center = spatial_zone_container::function_2676e037929f0833( var_af97402b6c3c086d );
            radius = spatial_zone_container::function_231d9e91d8ef7b5f( var_af97402b6c3c086d );
            uniquename = string( self.id ) + " : " + string( var_9accb85ea4605178 );
            function_71799ce2c69ce5a9( uniquename + self.type, removedelay );
            
            if ( !removeonly )
            {
                function_1c4c7ef874191be2( uniquename + self.type, center, radius, var_2d4d75095474bc50 );
            }
        }
    }
}

