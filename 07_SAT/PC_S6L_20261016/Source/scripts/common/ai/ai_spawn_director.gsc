// scripts\common\ai\ai_spawn_director.gsc  (hash_5a38602f6a9ab5d4.gscc) (size: 65293 Bytes / 0xff0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x879fa9 (8888233)
// size ...... 65293 (0xff0d)
// includes .. 14  (offset: 0xf13d)
// strings ... 101 (offset: 0xf1ad)
// dev strs .. 115 (offset: 0xf8ad)
// exports ... 150 (offset: 0xae55)
// cseg ...... 0x917 + 0xa53e (0xae55)
// imports ... 332 (offset: 0xc5c5)
// animtree1 . 0   (offset: 0xff0d)
// animtree2 . 0   (offset: 0xff0d)
#using script_2e61bcf54eaedd23;
#using script_e9bca00ec07d3c6;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_roads;

#namespace ai_spawn_director;

// Namespace ai_spawn_director
// Params 0, eflags: 0x5
// Checksum 0xacc9b241, Offset: 0x935
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ai_spawn_director", undefined, undefined, &_director_init );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x883d3dbb, Offset: 0x956
// Size: 0x83a
function private function_a19eb749238534b3( requestid, data )
{
    agent = data.agent;
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    if ( data.script_noteworthy )
    {
        agent.script_noteworthy = data.script_noteworthy;
    }
    
    if ( data.script_parameters )
    {
        agent.script_parameters = data.script_parameters;
    }
    
    if ( data.targetname )
    {
        agent.targetname = data.targetname;
    }
    
    assert( agent.directorrequestid == requestid );
    agent.directorambient = istrue( data.ambient );
    agent.directorspawndata = data;
    
    if ( isdefined( level.var_d42c6a76441fa1aa ) )
    {
        agent [[ level.var_d42c6a76441fa1aa ]]();
    }
    
    callbackstruct = _lookup_callback( "OnSpawned", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        foreach ( entry in callbackstruct )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata, agent, data );
        }
    }
    
    callbackstruct = function_2519019863f6b43f( "OnSpawned", requestid, data.spawnsetname );
    
    if ( isdefined( callbackstruct ) )
    {
        foreach ( entry in callbackstruct )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata, agent, data );
        }
    }
    
    foreach ( entry in level.var_4c766d9edc0c3e79 )
    {
        thread [[ entry ]]( agent, requestid, data );
    }
    
    if ( agent.unittype == "civilian" )
    {
        agent function_7bbd01e514ea0578( 640 );
        return;
    }
    
    if ( isdefined( data.script_stealthgroup ) )
    {
        agent thread function_1fe3edf4b61e6a27( data );
    }
    
    agent function_6230ce6691589765();
    agent.var_e7dd375985ff5ff2 = data.var_e7dd375985ff5ff2;
    isvehiclespawn = 0;
    
    if ( isdefined( data.vehiclespawntarget ) )
    {
        isvehiclespawn = 1;
        data.vehiclespawntarget thread vehicle_aianim::guy_enter( agent );
        agent thread function_d01c01d2ae601d33( requestid );
    }
    else if ( isdefined( data.vehiclepathtargetname ) )
    {
        assert( agent.behaviortreeasset != %"riotshield_cp", "<dev string:x24>" );
        agent.var_a6ecefe6814132d4 = 1;
        agent thread function_cdfb1a6001bc9ea1();
        isvehiclespawn = 1;
        
        if ( !isdefined( level.var_ac4d968ccb10fa96[ requestid ] ) )
        {
            level.var_ac4d968ccb10fa96[ requestid ] = [];
        }
        
        assert( isdefined( data.spawnpointindex ) );
        
        if ( !isdefined( level.var_ac4d968ccb10fa96[ requestid ][ data.spawnpointindex ] ) )
        {
            vehicleinfostruct = spawnstruct();
            vehicleinfostruct.vehicle = data.vehicle;
            vehicleinfostruct.vehiclepathtargetname = data.vehiclepathtargetname;
            vehicleinfostruct.vehicle_index = data.vehicle_index;
            vehicleinfostruct.riders = [];
            vehicleinfostruct.riders[ 0 ] = agent;
            vehicleinfostruct.unload_pos = data.vehicle_unload_pos;
            vehicleinfostruct.infil_type = data.infil_type;
            vehicleinfostruct.var_dd45d245730c6c45 = istrue( data.custominfil );
            
            if ( data.custominfil )
            {
                var_28e67715cd82b1e8 = spawnstruct();
                var_28e67715cd82b1e8.var_94654d69cf1fe557 = data.var_94654d69cf1fe557;
                var_28e67715cd82b1e8.var_586750f761586b3 = data.var_586750f761586b3;
                var_28e67715cd82b1e8.var_24ada7b3f042e1a8 = data.var_24ada7b3f042e1a8;
                var_28e67715cd82b1e8.var_bcb5c9e91d2117a7 = data.var_bcb5c9e91d2117a7;
                var_28e67715cd82b1e8.var_c56260e2f2f1e4e9 = data.var_c56260e2f2f1e4e9;
                vehicleinfostruct.var_28e67715cd82b1e8 = var_28e67715cd82b1e8;
            }
            
            if ( isdefined( data.vehicleskin ) )
            {
                vehicleinfostruct.var_305ce2bb6ec0993d = data.vehicleskin;
            }
            
            level.var_ac4d968ccb10fa96[ requestid ][ data.spawnpointindex ] = vehicleinfostruct;
        }
        else
        {
            agent.var_a6ecefe6814132d4 = 1;
            level.var_ac4d968ccb10fa96[ requestid ][ data.spawnpointindex ].riders = arraycombineunique( level.var_ac4d968ccb10fa96[ requestid ][ data.spawnpointindex ].riders, [ agent ] );
        }
    }
    
    if ( isdefined( data.parachute_start_pos ) )
    {
        isvehiclespawn = 1;
        
        if ( isdefined( level.var_a402a9ac5ac1adee ) )
        {
            agent thread [[ level.var_a402a9ac5ac1adee ]]( requestid, data );
        }
    }
    
    if ( !isvehiclespawn )
    {
        if ( data.smokebombinfil )
        {
            if ( isdefined( level.var_3db6b836941d6d4d ) )
            {
                specialinfil = 1;
                agent hide();
                agent utility::delaycall( 0.5, &show );
                agent thread [[ level.var_3db6b836941d6d4d ]]( agent.origin, requestid );
            }
        }
        
        if ( data.custominfil )
        {
            if ( isdefined( level.var_88cc975aac78e7df ) )
            {
                specialinfil = 1;
                agent hide();
                agent utility::delaycall( 0.5, &show );
                agent thread [[ level.var_88cc975aac78e7df ]]( data );
            }
        }
        
        agent _precombat( data );
    }
    
    if ( agent.subclass == "ob_rusher" && ( specialinfil || isvehiclespawn ) )
    {
        agent.var_9ba790bbbb4cf695 = 1;
    }
    
    function_3b7a9416144737bb( requestid, agent, data, !data.spawninggroup );
    
    if ( getdvarint( @"hash_bf14cfde8e249160", 0 ) == 1 && agent.unittype == "zombie" && data.ambient )
    {
        agent thread function_24d3a519a7c2bbe4( data.encounterradius );
    }
    
    if ( data.spawnspeed != 2 && data.animscripted_alias != "no_anim" )
    {
        if ( isdefined( data.animscripted_alias ) )
        {
            spawn_anim_alias = [ data.animscripted_alias ];
        }
        else if ( data.alert || data.spawnspeed == 1 )
        {
            spawn_anim_alias = [ "spawn_fast", "spawn_hop" ];
        }
        else
        {
            spawn_anim_alias = [ "spawn", "spawn_fast", "spawn_hop" ];
        }
        
        if ( isdefined( level.var_16f375d1b0d1c224 ) )
        {
            thread [[ level.var_16f375d1b0d1c224 ]]( agent, data, spawn_anim_alias );
        }
    }
    
    /#
        if ( getdvarint( @"hash_fe20797ad12b2dbe", 0 ) == 1 )
        {
            if ( isdefined( level.var_5bcac48b7e338dce ) )
            {
                agent thread [[ level.var_5bcac48b7e338dce ]]();
            }
        }
    #/
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x532983e7, Offset: 0x1198
// Size: 0xd8
function private function_cdfb1a6001bc9ea1()
{
    self endon( #"death" );
    self invisiblenotsolid();
    self.var_b4b292a00215f014 = 1;
    self.invulnerable = 1;
    val::set( "loading_vehicle", "ignoreall", 1 );
    val::set( "loading_vehicle", "ignore_ai_collision", 1 );
    val::set( "loading_vehicle", "ignoreme", 1 );
    self waittill( #"entervehicle" );
    
    while ( !self._blackboard.linkedtovehicle )
    {
        waitframe();
    }
    
    self visiblesolid();
    self.var_b4b292a00215f014 = 0;
    self.invulnerable = 0;
    val::reset( "loading_vehicle", "ignoreall" );
    val::reset( "loading_vehicle", "ignore_ai_collision" );
    val::reset( "loading_vehicle", "ignoreme" );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0xa3169abc, Offset: 0x1278
// Size: 0xc0
function private function_3b7a9416144737bb( requestid, agent, data, groupfinished )
{
    if ( !isdefined( level.var_eefebdafec711f3b[ requestid ] ) )
    {
        level.var_eefebdafec711f3b[ requestid ] = [];
    }
    
    currententry = level.var_eefebdafec711f3b[ requestid ].size;
    level.var_eefebdafec711f3b[ requestid ][ currententry ] = spawnstruct();
    level.var_eefebdafec711f3b[ requestid ][ currententry ].agent = agent;
    level.var_eefebdafec711f3b[ requestid ][ currententry ].data = data;
    
    if ( groupfinished )
    {
        function_c996245c00270b4f( requestid );
        level.var_eefebdafec711f3b[ requestid ][ currententry ] = undefined;
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x5713a05c, Offset: 0x1340
// Size: 0xa9
function private function_9ff6d6804491561d( reinforcementarea )
{
    bundle = level.var_ee0bf8e63064304e[ reinforcementarea.reinforcementbundlename ];
    var_85fb59db0227fe31 = bundle.reinforcementareatuning.var_85fb59db0227fe31;
    var_ba38015f1cd112ab = bundle.reinforcementareatuning.var_ba38015f1cd112ab;
    
    if ( !isdefined( var_ba38015f1cd112ab ) )
    {
        return var_85fb59db0227fe31;
    }
    
    if ( var_85fb59db0227fe31 > var_ba38015f1cd112ab )
    {
        assertmsg( "<dev string:x52>" + getxhashsourcename( reinforcementarea.reinforcementbundlename ) + "<dev string:x9e>" );
        return var_85fb59db0227fe31;
    }
    
    return randomfloatrange( var_85fb59db0227fe31, var_ba38015f1cd112ab );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xec82aacc, Offset: 0x13f2
// Size: 0x4e
function private function_2644dad52dfae787( reinforcementarea )
{
    bundle = level.var_ee0bf8e63064304e[ reinforcementarea.reinforcementbundlename ];
    var_7a4e93ea6756d6df = bundle.reinforcementareatuning.var_7a4e93ea6756d6df;
    return var_7a4e93ea6756d6df;
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x4d399e4f, Offset: 0x1449
// Size: 0x1b9
function private function_f650088e85858351( goaltargetname )
{
    goalarea = spawnstruct();
    potentialgoalnode = getnode( goaltargetname, #targetname );
    
    if ( isdefined( potentialgoalnode ) )
    {
        goalarea.goalnode = potentialgoalnode;
        return goalarea;
    }
    
    var_11f26edabc39583d = getnoentvolumearray( goaltargetname, #targetname );
    
    if ( var_11f26edabc39583d.size > 0 )
    {
        goalarea.var_94f4a4f8715172ca = var_11f26edabc39583d[ 0 ];
        
        if ( var_11f26edabc39583d.size > 1 )
        {
            assertmsg( "<dev string:xc4>" + var_11f26edabc39583d[ 0 ].origin + "<dev string:x114>" + goaltargetname );
        }
        
        return goalarea;
    }
    
    var_11f26edabc39583d = getentarray( goaltargetname, #targetname );
    
    if ( var_11f26edabc39583d.size > 0 )
    {
        goalarea.var_94f4a4f8715172ca = var_11f26edabc39583d[ 0 ];
        
        if ( var_11f26edabc39583d.size > 1 )
        {
            assertmsg( "<dev string:x123>" + var_11f26edabc39583d[ 0 ].origin + "<dev string:x114>" + goaltargetname );
        }
        
        return goalarea;
    }
    
    var_9bfa60d6a4a2d633 = utility::getstructarray( goaltargetname, "targetname" );
    
    foreach ( struct in var_9bfa60d6a4a2d633 )
    {
        if ( isdefined( struct.radius ) )
        {
            goalstruct = struct;
            break;
        }
    }
    
    if ( isdefined( goalstruct ) )
    {
        goalarea.var_8f483f0d17a5aa21 = goalstruct;
        return goalarea;
    }
    
    return goalarea;
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xe622488e, Offset: 0x160b
// Size: 0x15d
function function_2cf421a429b77278( data )
{
    if ( isdefined( data.var_d229a71fb9fbe4d1 ) || isdefined( data.target ) || isdefined( data.covernodetarget ) )
    {
        if ( isdefined( data.covernodetarget ) )
        {
            goalarea = function_f650088e85858351( data.covernodetarget );
        }
        else if ( isdefined( data.var_d229a71fb9fbe4d1 ) )
        {
            goalarea = function_f650088e85858351( data.var_d229a71fb9fbe4d1 );
        }
        else
        {
            goalarea = function_f650088e85858351( data.target );
        }
        
        thread function_ccf5f24c62d8d119( goalarea, data );
        return;
    }
    
    if ( isdefined( data.var_7ed4900ca15f95c1 ) )
    {
        goalarea = spawnstruct();
        goalarea.var_8f483f0d17a5aa21 = data.var_7ed4900ca15f95c1;
        thread function_ccf5f24c62d8d119( goalarea, data );
        return;
    }
    
    if ( data.spawnpointradius > 0 )
    {
        var_8f483f0d17a5aa21 = spawnstruct();
        var_8f483f0d17a5aa21.radius = data.spawnpointradius;
        var_8f483f0d17a5aa21.origin = data.origin;
        goalarea = spawnstruct();
        goalarea.var_8f483f0d17a5aa21 = var_8f483f0d17a5aa21;
        thread function_ccf5f24c62d8d119( goalarea );
        return;
    }
    
    function_5faf4f558867daa9( data );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x1b71cd0b, Offset: 0x1770
// Size: 0x169
function function_19c43b5b3335d9e4( data )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( self.directorrequestid ) )
    {
        return;
    }
    
    goalassignment = data.var_d87e625ec065d455;
    
    if ( isdefined( data.path_array ) )
    {
        goalassignment = data.var_5f6eaefe5a5e8812;
    }
    
    if ( !isdefined( goalassignment ) || goalassignment == #"none" )
    {
        return;
    }
    
    utility::waittill_any( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    
    if ( !isdefined( self.directorrequestid ) )
    {
        return;
    }
    
    switch ( goalassignment )
    {
        case #"encounterarea":
            requestdata = function_9b649316adcccbaa( self.directorrequestid );
            
            if ( isdefined( requestdata ) )
            {
                self setgoalpos( requestdata.origin, requestdata.radius );
            }
            
            break;
        case #"currentlocation":
            self setgoalpos( self.origin );
            break;
        case #"patrolpoint":
            if ( isdefined( data.path_array ) )
            {
                closestpoint = function_47c86977a18df38b( data.path_array, self.origin );
                self setgoalpos( closestpoint.origin );
            }
            
            break;
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x6bbf4f0c, Offset: 0x18e1
// Size: 0x355
function _precombat( data )
{
    self endon( #"death" );
    
    if ( self.unittype == "soldier" || self.unittype == "juggernaut" || self.unittype == "suicidebomber" )
    {
        if ( !isdefined( self.qsetgoalpos ) )
        {
            thread function_2cf421a429b77278( data );
        }
        
        if ( isalive( self.enemy ) )
        {
            return;
        }
        
        if ( !self.var_98976fabf7d4b227 && ( isdefined( data.interaction_id ) || isdefined( data.interactionname ) ) )
        {
            interactdatanode = spawnstruct();
            interactdatanode.script_delay = data.script_delay;
            interactdatanode.script_delay_min = data.script_delay_min;
            interactdatanode.script_delay_max = data.script_delay_max;
            
            if ( data.script_delay_min == data.script_delay_max )
            {
                if ( data.script_delay_min != 0 )
                {
                    interactdatanode.script_delay = data.script_delay_min;
                }
                
                interactdatanode.script_delay_min = undefined;
                interactdatanode.script_delay_max = undefined;
            }
            
            if ( isdefined( data.repeat_interaction ) && int( data.repeat_interaction ) )
            {
                interactdatanode.repeat_interaction = 1;
            }
            
            if ( data.script_faceangles )
            {
                interactdatanode.script_faceangles = 1;
            }
            
            if ( data.script_cleanexit )
            {
                interactdatanode.script_cleanexit = 1;
            }
            
            self._blackboard.idlenode = interactdatanode;
            self.repeatinteraction = istrue( interactdatanode.repeat_interaction );
            
            if ( isdefined( data.interaction_id ) )
            {
                self function_a47253874da73280( getinteractionorigin( data.interaction_id ) );
                self function_ad85ecc3923456f4( 64 );
                self function_895b16b8fcd857ba( data.interaction_id );
                thread function_26dbb208db84916f();
            }
            else
            {
                var_a1a7ca42ea0a74 = spawninteraction( data.interactionname, data.interactionorigin, data.interactionangles );
                
                if ( isdefined( var_a1a7ca42ea0a74 ) )
                {
                    self function_a47253874da73280( getinteractionorigin( var_a1a7ca42ea0a74 ) );
                    self function_ad85ecc3923456f4( 64 );
                    self function_895b16b8fcd857ba( var_a1a7ca42ea0a74 );
                    thread function_ac245662cd95abf4( var_a1a7ca42ea0a74, 0 );
                    thread function_26dbb208db84916f();
                }
                else
                {
                    assertmsg( "<dev string:x171>" + data.interactionorigin + "<dev string:x1a0>" );
                }
            }
            
            if ( isdefined( data.path_array ) )
            {
                thread function_ee88bbf980323b35( data.path_array );
            }
            
            return;
        }
        
        if ( isdefined( data.path_array ) )
        {
            var_b73d8ef65bab62da = 0;
            
            if ( data.restored )
            {
                var_b73d8ef65bab62da = 1;
            }
            
            function_c14096b85ff5fcd3( data.path_array, var_b73d8ef65bab62da );
            return;
        }
        
        if ( data.ambient && !data.var_433589829cadc877 )
        {
            thread _wander( self, self.goalradius, 0, self.goalpos );
        }
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xd934f149, Offset: 0x1c3e
// Size: 0xfc
function private function_1fe3edf4b61e6a27( data )
{
    self endon( #"death" );
    
    if ( isdefined( data.script_stealthgroup ) )
    {
        self.script_stealthgroup = data.script_stealthgroup;
        thread enemy::main();
        
        if ( isdefined( level.var_cbd34096ae9d0004 ) )
        {
            thread [[ level.var_cbd34096ae9d0004 ]]();
        }
        
        waitframe();
        
        if ( isdefined( self.fnsetstealthstate ) && isdefined( data.var_dd18ba56aed9c0bf ) && data.alert && data.var_b1ddd4c5daa30b07 != "investigate" )
        {
            self [[ self.fnsetstealthstate ]]( data.var_dd18ba56aed9c0bf );
            return;
        }
        
        if ( isdefined( self.fnsetstealthstate ) && isdefined( data.var_5d22516693d1182f ) && !isdefined( data.var_dd18ba56aed9c0bf ) )
        {
            self [[ self.fnsetstealthstate ]]( data.var_5d22516693d1182f );
        }
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x16619a65, Offset: 0x1d42
// Size: 0x33
function private function_c996245c00270b4f( requestid )
{
    if ( isdefined( level.var_e650c10800c4e481 ) )
    {
        [[ level.var_e650c10800c4e481 ]]( requestid, level.var_eefebdafec711f3b[ requestid ] );
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xe0d12080, Offset: 0x1d7d
// Size: 0xb7
function private function_c7cb4dace31a862a( requestid )
{
    callbacks = _lookup_callback( "ReadyToSpawn", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
        
        return;
    }
    
    function_fbe9bb47edbe2d7c( requestid );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x88875120, Offset: 0x1e3c
// Size: 0xc0
function private function_c3e61f64ac6d6926( requestid, data )
{
    callbacks = _lookup_callback( "FinishedSpawningBucket", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
    }
    
    function_6bae540331f2ea1b( requestid, data );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xb5629d93, Offset: 0x1f04
// Size: 0xf5, Type: bool
function private _shouldreinforce( requestid, data )
{
    assert( isdefined( level.var_a20b02d86621e9ed[ requestid ] ), "<dev string:x1d7>" );
    callbacks = _lookup_callback( "ShouldReinforce", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            if ( ![[ entry.fncallback ]]( requestid, entry.userdata, data.wavenumber ) )
            {
                return false;
            }
        }
        
        return true;
    }
    
    assertmsg( "<dev string:x236>" + requestid );
    return true;
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x57f08e91, Offset: 0x2002
// Size: 0x117
function private function_b748082dd387c19a( requestid )
{
    level notify( "ai_encounter_floodfill_shutdown_thread_" + requestid );
    level endon( "ai_encounter_floodfill_shutdown_thread_" + requestid );
    level endon( "ai_encounter_shutdown_" + requestid );
    
    while ( true )
    {
        callbacks = _lookup_callback( "ShouldShutdownFloodFill", requestid );
        
        if ( isdefined( callbacks ) )
        {
            should_shutdown = 1;
            
            foreach ( entry in callbacks )
            {
                if ( ![[ entry.fncallback ]]( requestid, entry.userdata ) )
                {
                    should_shutdown = 0;
                    break;
                }
            }
            
            if ( should_shutdown )
            {
                break;
            }
        }
        else
        {
            assertmsg( "<dev string:x27d>" + requestid + "<dev string:x2c0>" );
            break;
        }
        
        waitframe();
    }
    
    function_42319057a16481e( requestid );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x3da89a0c, Offset: 0x2121
// Size: 0x16
function private function_aefd5cca4d2fdd4d( requestid )
{
    level thread function_b748082dd387c19a( requestid );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x18acc29b, Offset: 0x213f
// Size: 0x152
function private function_b1f926bd5aeb0bb3( requestid )
{
    level notify( "ai_encounter_floodfill_spawn_thread_" + requestid );
    level endon( "ai_encounter_floodfill_spawn_thread_" + requestid );
    level endon( "ai_encounter_shutdown_" + requestid );
    
    while ( true )
    {
        callbacks = _lookup_callback( "ShouldSpawnFloodFill", requestid );
        
        if ( isdefined( callbacks ) )
        {
            /#
                requestinfo = function_9b649316adcccbaa( requestid );
                assert( requestinfo.status == 1 || requestinfo.status == 9 );
            #/
            
            should_spawn = 1;
            
            foreach ( entry in callbacks )
            {
                if ( ![[ entry.fncallback ]]( requestid, entry.userdata ) )
                {
                    should_spawn = 0;
                    break;
                }
            }
            
            if ( should_spawn )
            {
                break;
            }
        }
        else
        {
            assertmsg( "<dev string:x317>" + requestid + "<dev string:x357>" );
            break;
        }
        
        waitframe();
    }
    
    function_5c25c75941c4dc8b( requestid );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xe1c04f40, Offset: 0x2299
// Size: 0x32
function private function_1684e90755873b02( requestid, ready )
{
    if ( ready )
    {
        level thread function_b1f926bd5aeb0bb3( requestid );
        return;
    }
    
    level notify( "ai_encounter_floodfill_spawn_thread_" + requestid );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xe65a0f4e, Offset: 0x22d3
// Size: 0x2e
function function_a49c35b72d6b6fea( requestid, fncallback, userdata )
{
    add_callback( "Shutdown", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x8856214d, Offset: 0x2309
// Size: 0x2e
function function_c99d360d62c49a9c( requestid, fncallback, userdata )
{
    add_callback( "ShouldSpawnFloodFill", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xc2553a59, Offset: 0x233f
// Size: 0x2e
function function_53289c032f506bb1( requestid, fncallback, userdata )
{
    add_callback( "ShouldShutdownFloodFill", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x55b624bb, Offset: 0x2375
// Size: 0x30e
function private function_36ad70b1ed46ec4d( requestid, data )
{
    shutdown_callbacks = _lookup_callback( "Shutdown", requestid );
    
    if ( data.iscomplete )
    {
        if ( isdefined( level.var_a20b02d86621e9ed[ requestid ] ) )
        {
            foreach ( callbackname, callbackarray in level.var_a20b02d86621e9ed[ requestid ] )
            {
                if ( function_d804b1256e23f725( requestid, callbackname ) )
                {
                    foreach ( var_5ac76bf038b8fc9f, var_5225ce5949a493f9 in callbackarray )
                    {
                        if ( var_5ac76bf038b8fc9f != "Shutdown" )
                        {
                            foreach ( entry in var_5225ce5949a493f9 )
                            {
                                entry notify( #"callback_cleanup" );
                            }
                        }
                    }
                    
                    continue;
                }
                
                if ( callbackname != "Shutdown" )
                {
                    foreach ( entry in callbackarray )
                    {
                        entry notify( #"callback_cleanup" );
                    }
                }
            }
            
            level.var_a20b02d86621e9ed[ requestid ] = undefined;
        }
        
        if ( data.canreactivate )
        {
            level.var_a20b02d86621e9ed[ requestid ] = [];
        }
        
        if ( isdefined( level.var_b7f0da7ac80e9755[ requestid ] ) )
        {
            level.var_b7f0da7ac80e9755[ requestid ] = undefined;
        }
    }
    
    if ( isdefined( shutdown_callbacks ) )
    {
        foreach ( callbackstruct in shutdown_callbacks )
        {
            thread [[ callbackstruct.fncallback ]]( requestid, callbackstruct.userdata, data );
        }
    }
    
    if ( data.iscomplete )
    {
        level notify( "ai_encounter_shutdown_" + requestid );
    }
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x7a72930, Offset: 0x268b
// Size: 0x102
function private function_f1d6054dcbe3f55e( requestid, data )
{
    if ( getdvarint( @"ai_spawn_director_enable_despawn_behaviors", 0 ) == 1 )
    {
        foreach ( guy in data.ai )
        {
            assert( !guy.var_6aa30d193409f0d9 );
            guy.var_6aa30d193409f0d9 = 1;
            level.var_4e3e63b167b19473[ level.var_4e3e63b167b19473.size ] = guy;
        }
        
        var_c60a13eba6baced = data.var_c60a13eba6baced;
    }
    
    level notify( "ai_encounter_despawning_" + requestid );
    level notify( #"hash_e1948edb198abc10", var_c60a13eba6baced );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xd74918a0, Offset: 0x2795
// Size: 0x82
function private function_cebfb0c5c8553b2d()
{
    while ( true )
    {
        level waittill( #"hash_e1948edb198abc10", var_c60a13eba6baced );
        
        while ( level.var_4e3e63b167b19473.size > 0 )
        {
            guy = level.var_4e3e63b167b19473[ 0 ];
            level.var_4e3e63b167b19473[ 0 ] = undefined;
            function_cdc669dbc8ea2101( level.var_4e3e63b167b19473 );
            
            if ( isalive( guy ) )
            {
                guy thread function_4638391dde5218f1( guy.directorrequestid, var_c60a13eba6baced );
            }
        }
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0xb7f90b0a, Offset: 0x281f
// Size: 0x16b
function private _director_callback( callbackname, requestid, data )
{
    switch ( callbackname )
    {
        case #"hash_9e98220b6f353a3f":
            return function_a19eb749238534b3( requestid, data );
        case #"hash_58235f15856f6160":
            data function_a0ce0fd087a726d0();
            return;
        case #"hash_d88f6ad5755dfe30":
        case #"hash_eb099bd287e41597":
            function_c7cb4dace31a862a( requestid );
            break;
        case #"hash_b9a32efd84fd32d0":
            function_c3e61f64ac6d6926( requestid, data );
            break;
        case #"hash_505c12a82a7b90c9":
            function_ec740f4e03e8d89b( requestid, data );
            break;
        case #"hash_9667ea6cd44b8ec8":
            return _shouldreinforce( requestid, data );
        case #"hash_95c6a6d49e8ed085":
            function_1684e90755873b02( requestid, data );
            break;
        case #"hash_79765d0de58f935c":
            function_aefd5cca4d2fdd4d( requestid );
            break;
        case #"hash_45fc965fd1793461":
            function_f1d6054dcbe3f55e( requestid, data );
            break;
        case #"hash_d432f1ec297228ab":
            function_36ad70b1ed46ec4d( requestid, data );
            break;
        case #"hash_588e5af9459f74ef":
            function_fac1e28aebfc2f67( requestid );
            break;
        case #"hash_4e0fcd24c9caa04":
            function_7ab6ef1062e48ccd( requestid );
            break;
        case #"hash_7c1d8e0a9e3c904f":
            function_995c3f09cc33972d( requestid );
            break;
    }
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xfe704078, Offset: 0x2992
// Size: 0x2e
function function_c0e5cd2a219c993a( requestid, fncallback, userdata )
{
    add_callback( "Restored", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x9d025c50, Offset: 0x29c8
// Size: 0xad
function private function_995c3f09cc33972d( requestid )
{
    callbacks = _lookup_callback( "Restored", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x61328ce2, Offset: 0x2a7d
// Size: 0x93
function private function_7ab6ef1062e48ccd( zoneindex )
{
    subzones = function_6978793539ff1cb4( zoneindex );
    
    foreach ( entry in level.var_6aa07e1d496d2507 )
    {
        thread [[ entry ]]( zoneindex, subzones );
    }
}

// Namespace ai_spawn_director
// Params 5
// Checksum 0x24185b67, Offset: 0x2b18
// Size: 0xf8
function add_callback( callbackname, var_7157a9997af97948, fncallback, userdata, spawnset )
{
    requestid = var_7157a9997af97948;
    
    if ( isstring( var_7157a9997af97948 ) )
    {
        requestid = lookup_spawn_request( var_7157a9997af97948 );
    }
    
    if ( !( isdefined( requestid ) && isdefined( level.var_a20b02d86621e9ed[ requestid ] ) ) )
    {
        assertmsg( "<dev string:x3ac>" + callbackname );
        return;
    }
    
    if ( isdefined( fncallback ) )
    {
        if ( isdefined( spawnset ) )
        {
            function_1202642ad1d7b6d3( callbackname, requestid, fncallback, userdata, spawnset );
            return;
        }
        
        if ( !isdefined( level.var_a20b02d86621e9ed[ requestid ][ callbackname ] ) )
        {
            level.var_a20b02d86621e9ed[ requestid ][ callbackname ] = [];
        }
        
        callbackentry = { #userdata:userdata, #fncallback:fncallback };
        level.var_a20b02d86621e9ed[ requestid ][ callbackname ][ level.var_a20b02d86621e9ed[ requestid ][ callbackname ].size ] = callbackentry;
    }
}

// Namespace ai_spawn_director
// Params 5, eflags: 0x4
// Checksum 0x3500ef98, Offset: 0x2c18
// Size: 0x10a
function private function_1202642ad1d7b6d3( callbackname, requestid, fncallback, userdata, spawnset )
{
    valid_callbacks = [ "OnSpawned", "OnParachuteLanded", "DirectorKilledAI" ];
    
    if ( !arraycontains( valid_callbacks, callbackname ) )
    {
        assertmsg( "<dev string:x3f4>" + callbackname + "<dev string:x41f>" );
        return;
    }
    
    if ( !function_d804b1256e23f725( requestid, spawnset ) )
    {
        assertmsg( "<dev string:x446>" + callbackname + "<dev string:x484>" + requestid );
        return;
    }
    
    if ( !isdefined( level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ] ) )
    {
        level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ] = [];
    }
    
    callbackentry = { #userdata:userdata, #fncallback:fncallback };
    level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ][ level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ].size ] = callbackentry;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x52ebfed9, Offset: 0x2d2a
// Size: 0x167
function remove_callback( callbackname, requestid, fncallback )
{
    if ( isdefined( level.var_a20b02d86621e9ed[ requestid ][ callbackname ] ) )
    {
        if ( isdefined( fncallback ) )
        {
            new_array = [];
            
            foreach ( entry in level.var_a20b02d86621e9ed[ requestid ][ callbackname ] )
            {
                if ( entry.fncallback != fncallback )
                {
                    new_array[ new_array.size ] = entry;
                }
            }
            
            level.var_a20b02d86621e9ed[ requestid ][ callbackname ] = new_array;
            return;
        }
        
        foreach ( entry in level.var_a20b02d86621e9ed[ requestid ][ callbackname ] )
        {
            entry notify( #"callback_cleanup" );
        }
        
        level.var_a20b02d86621e9ed[ requestid ][ callbackname ] = undefined;
    }
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x3ef06c66, Offset: 0x2e99
// Size: 0x49
function _lookup_callback( callbackname, requestid )
{
    if ( isdefined( level.var_a20b02d86621e9ed[ requestid ][ callbackname ] ) && level.var_a20b02d86621e9ed[ requestid ][ callbackname ].size )
    {
        return level.var_a20b02d86621e9ed[ requestid ][ callbackname ];
    }
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x2138532, Offset: 0x2eeb
// Size: 0x58
function function_2519019863f6b43f( callbackname, requestid, spawnset )
{
    if ( isdefined( level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ] ) && level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ].size )
    {
        return level.var_a20b02d86621e9ed[ requestid ][ spawnset ][ callbackname ];
    }
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x44 variadic
// Checksum 0x81890cb8, Offset: 0x2f4c
// Size: 0xae
function private _notify_callback( requestid, callbackname, ... )
{
    callbacks = _lookup_callback( callbackname, requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( callbackstruct in callbacks )
        {
            callbackstruct notify( callbackname );
        }
    }
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x61fffb7, Offset: 0x3002
// Size: 0x7a, Type: bool
function function_3ce5298df1143d67( callbackname, requestid )
{
    add_callback( callbackname, requestid, &_notify_callback, callbackname );
    callbacks = _lookup_callback( callbackname, requestid );
    callbackstruct = callbacks[ callbacks.size - 1 ];
    result = callbackstruct utility::waittill_any_return( callbackname, "callback_cleanup" );
    
    if ( result == callbackname )
    {
        thread remove_callback( callbackname, requestid );
        return true;
    }
    
    return false;
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0x3cb893fc, Offset: 0x3085
// Size: 0xe
function function_f83b50a2af1fe115()
{
    self notify( #"endDirectorInitiatedPatrol" );
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0x329c0a8b, Offset: 0x309b
// Size: 0xe
function function_6b359c0d23cded0a()
{
    self notify( #"endDirectorInitiatedWander" );
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0x5ef9a81d, Offset: 0x30b1
// Size: 0x60
function function_a06e8ec2fc7e833e()
{
    if ( isdefined( self.directorspawndata ) && isdefined( self.directorspawndata.path_array ) )
    {
        function_c14096b85ff5fcd3( self.directorspawndata.path_array );
        return;
    }
    
    assertmsg( "<dev string:x4a3>" + self.directorrequestid + "<dev string:x4e4>" );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x6e9d4e47, Offset: 0x3119
// Size: 0x8c
function lookup_spawn_request( targetname )
{
    assert( level.var_aee978b8c8705c84, "<dev string:x506>" );
    requestid = function_9af53217f6ebd241( targetname );
    
    if ( !getdvarint( @"hash_d9375e00b5f54c59", 0 ) && !isdefined( requestid ) )
    {
        assertmsg( "<dev string:x52a>" + targetname + "<dev string:x555>" );
    }
    
    if ( isdefined( requestid ) && !isdefined( level.var_a20b02d86621e9ed[ requestid ] ) )
    {
        level.var_a20b02d86621e9ed[ requestid ] = [];
    }
    
    return requestid;
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x3605048d, Offset: 0x31ae
// Size: 0xcd
function function_4cc9aafe98c53c7f( targetname, type )
{
    assert( level.var_aee978b8c8705c84, "<dev string:x506>" );
    requestids = function_91bae863ce90a60d( targetname, type );
    
    foreach ( requestid in requestids )
    {
        if ( isdefined( requestid ) && !isdefined( level.var_a20b02d86621e9ed[ requestid ] ) )
        {
            level.var_a20b02d86621e9ed[ requestid ] = [];
        }
    }
    
    return requestids;
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x9f2d7eca, Offset: 0x3284
// Size: 0x4b
function function_c83497dcedebe189( fncallback )
{
    assert( isdefined( fncallback ) );
    assert( isdefined( level.var_4c766d9edc0c3e79 ), "<dev string:x5c7>" );
    level.var_4c766d9edc0c3e79 = arraycombineunique( level.var_4c766d9edc0c3e79, [ fncallback ] );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xd02a9aa6, Offset: 0x32d7
// Size: 0x2f
function function_1b7d6a5e85cd61b6( fncallback )
{
    assert( isdefined( fncallback ) );
    level.var_4c766d9edc0c3e79 = arrayremove( level.var_4c766d9edc0c3e79, fncallback );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x4c2da0d5, Offset: 0x330e
// Size: 0x4b
function function_bb42c0a4dc530693( fncallback )
{
    assert( isdefined( fncallback ) );
    assert( isdefined( level.var_6aa07e1d496d2507 ), "<dev string:x5c7>" );
    level.var_6aa07e1d496d2507 = arraycombineunique( level.var_6aa07e1d496d2507, [ fncallback ] );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x6968b335, Offset: 0x3361
// Size: 0x2f
function function_28b48afba0eb29e4( fncallback )
{
    assert( isdefined( fncallback ) );
    level.var_6aa07e1d496d2507 = arrayremove( level.var_6aa07e1d496d2507, fncallback );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x39de2719, Offset: 0x3398
// Size: 0x2e
function function_5ee28426adb3b64b( requestid, fncallback, userdata )
{
    add_callback( "ReadyToSpawn", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 4
// Checksum 0x41ef079e, Offset: 0x33ce
// Size: 0x39
function add_spawned_callback( requestid, fncallback, userdata, spawnset )
{
    add_callback( "OnSpawned", requestid, fncallback, userdata, spawnset );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x1e43fcc7, Offset: 0x340f
// Size: 0x2e
function add_vehicle_spawned_callback( requestid, fncallback, userdata )
{
    add_callback( "OnVehicleSpawned", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xcc245aba, Offset: 0x3445
// Size: 0x2e
function function_baa5d26d8804d5da( requestid, fncallback, userdata )
{
    add_callback( "OnUnloaded", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 4
// Checksum 0x42cb41b, Offset: 0x347b
// Size: 0x39
function function_ee0b7976619e1cb8( requestid, fncallback, userdata, spawnset )
{
    add_callback( "OnParachuteLanded", requestid, fncallback, userdata, spawnset );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x2f5dc542, Offset: 0x34bc
// Size: 0x2e
function function_5c8b22954b3bfa37( requestid, fncallback, userdata )
{
    add_callback( "ShouldReinforce", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x906d14c7, Offset: 0x34f2
// Size: 0x2e
function function_5a08798970350207( requestid, fncallback, userdata )
{
    add_callback( "FinishedSpawningBucket", requestid, fncallback, userdata );
}

// Namespace ai_spawn_director
// Params 4
// Checksum 0x767628bc, Offset: 0x3528
// Size: 0x39
function function_c4cace40604d2bf9( requestid, fncallback, userdata, spawnset )
{
    add_callback( "DirectorKilledAI", requestid, fncallback, userdata, spawnset );
}

// Namespace ai_spawn_director
// Params 7
// Checksum 0x8b371980, Offset: 0x3569
// Size: 0xaf
function spawn_request( encounterbundlename, origin, radius, enabled, readytospawn, isambient, var_7187af36c198931c )
{
    assert( level.var_aee978b8c8705c84 );
    assert( isdefined( getscriptbundle( encounterbundlename ) ), "<dev string:x600>" + getxhashsourcename( encounterbundlename ) );
    
    if ( !isdefined( isambient ) )
    {
        isambient = 0;
    }
    
    if ( !isdefined( var_7187af36c198931c ) )
    {
        var_7187af36c198931c = 1;
    }
    
    requestid = aispawndirectorspawnrequest( encounterbundlename, origin, radius, enabled, readytospawn, isambient, var_7187af36c198931c );
    
    if ( isdefined( requestid ) )
    {
        level.var_a20b02d86621e9ed[ requestid ] = [];
    }
    
    return requestid;
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x2dc77f9c, Offset: 0x3621
// Size: 0x5d
function spawn_request_associate( requestid, object )
{
    assert( isint( requestid ) );
    assert( isstruct( object ) );
    
    if ( !isdefined( object.var_ec2a4274015323c4 ) )
    {
        object.var_ec2a4274015323c4 = [];
    }
    
    object.var_ec2a4274015323c4[ requestid ] = 1;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0x7fd83d8, Offset: 0x3686
// Size: 0x38
function cancel_spawn_request( requestid, shouldrespawn, var_c60a13eba6baced )
{
    assert( level.var_aee978b8c8705c84 );
    function_17ee483eb76a9759( requestid, shouldrespawn, var_c60a13eba6baced );
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x508495e9, Offset: 0x36c6
// Size: 0x2e
function function_eb2a1f09e136d7dc( requestid, prioritylevel )
{
    assert( level.var_aee978b8c8705c84 );
    function_cb371d19a8d1de8( requestid, prioritylevel );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xcd779d10, Offset: 0x36fc
// Size: 0x4d
function function_804a8c3353daab95( createscriptflag )
{
    if ( !isdefined( level.var_f208794d2f398118 ) )
    {
        level.var_f208794d2f398118 = [];
    }
    
    numflags = level.var_f208794d2f398118.size;
    level.var_f208794d2f398118[ numflags ] = createscriptflag + "_completed";
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x1f084fc6, Offset: 0x3751
// Size: 0x20
function private process_create_script_bool( value )
{
    if ( isstring( value ) )
    {
        return ( value == "1" );
    }
    
    return value;
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0xf3312611, Offset: 0x377a
// Size: 0xbae
function process_create_script()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    
    if ( isdefined( level.var_f208794d2f398118 ) )
    {
        foreach ( createscriptflag in level.var_f208794d2f398118 )
        {
            utility::flag_wait( createscriptflag );
        }
        
        level.var_f208794d2f398118 = [];
    }
    
    interactions = utility::getstructarray( "info_act", "script_noteworthy" );
    var_c6a73a31adbe90d2 = [];
    
    foreach ( interaction in interactions )
    {
        if ( !isdefined( interaction.ai_interaction ) )
        {
            continue;
        }
        
        if ( isdefined( interaction.targetname ) )
        {
            var_c6a73a31adbe90d2[ interaction.targetname ] = interaction;
            continue;
        }
        
        interactionid = spawninteraction( interaction.ai_interaction, interaction.origin, interaction.angles );
        
        if ( isdefined( interactionid ) )
        {
            function_dccedc2a7bda3299( interactionid, interaction.origin );
            continue;
        }
        
        assertmsg( "<dev string:x625>" );
    }
    
    interactions = undefined;
    patrolpoints = utility::getstructarray( "ai_encounter_patrol_point", "variantname" );
    
    foreach ( point in patrolpoints )
    {
        if ( isdefined( point.move_speed ) )
        {
            point.move_speed = float( point.move_speed );
        }
        
        if ( isdefined( point.min_wait_time ) )
        {
            point.min_wait_time = float( point.min_wait_time );
        }
        
        if ( isdefined( point.max_wait_time ) )
        {
            point.max_wait_time = float( point.max_wait_time );
        }
        
        point.start_point = process_create_script_bool( point.start_point );
        point.reverse_route = process_create_script_bool( point.reverse_route );
        point.loop_route = process_create_script_bool( point.loop_route );
        point.var_df8f7b8318d59fe5 = process_create_script_bool( point.var_df8f7b8318d59fe5 );
        
        if ( isdefined( point.info_act_ref ) && isdefined( var_c6a73a31adbe90d2[ point.info_act_ref ] ) )
        {
            point.interactionname = var_c6a73a31adbe90d2[ point.info_act_ref ].ai_interaction;
            point.interactionorigin = var_c6a73a31adbe90d2[ point.info_act_ref ].origin;
            point.interactionangles = var_c6a73a31adbe90d2[ point.info_act_ref ].angles;
            point.repeat_interaction = var_c6a73a31adbe90d2[ point.info_act_ref ].repeat_interaction;
        }
        else if ( isdefined( point.target ) && isdefined( var_c6a73a31adbe90d2[ point.target ] ) )
        {
            point.interactionname = var_c6a73a31adbe90d2[ point.target ].ai_interaction;
            point.interactionorigin = var_c6a73a31adbe90d2[ point.target ].origin;
            point.interactionangles = var_c6a73a31adbe90d2[ point.target ].angles;
            point.repeat_interaction = var_c6a73a31adbe90d2[ point.target ].repeat_interaction;
        }
        
        point.info_act_ref = undefined;
        
        if ( isdefined( point.var_e8fdcbf62408dcde ) )
        {
            point.var_e8fdcbf62408dcde = int( point.var_e8fdcbf62408dcde );
        }
        
        function_37ee4af04167f7e6( point );
    }
    
    patrolpoints = undefined;
    parachutestartpoints = utility::getstructarray( "ai_encounter_parachute_start", "script_noteworthy" );
    spawnpoints = utility::getstructarray( "ai_encounter_spawnpoint", "variantname" );
    wanderpoints = utility::getstructarray( "ai_encounter_wander_spawnpoint", "variantname" );
    patrolstartpoints = utility::getstructarray( "ai_encounter_patrolstart_spawnpoint", "variantname" );
    locationpoints = utility::getstructarray( "ai_encounter_location_spawnpoint", "variantname" );
    spawnpoints = arraycombine( wanderpoints, spawnpoints );
    wanderpoints = undefined;
    spawnpoints = arraycombine( patrolstartpoints, spawnpoints );
    patrolstartpoints = undefined;
    spawnpoints = arraycombine( locationpoints, spawnpoints );
    locationpoints = undefined;
    spawnpointscount = spawnpoints.size;
    
    for ( pointindex = 0; pointindex < spawnpointscount ; pointindex++ )
    {
        point = spawnpoints[ pointindex ];
        
        if ( isdefined( point.var_6324368dbfa7058a ) )
        {
            point.var_6324368dbfa7058a = float( point.var_6324368dbfa7058a );
        }
        else
        {
            point.var_6324368dbfa7058a = 5000;
        }
        
        point.preferred_spawnpoint = process_create_script_bool( point.preferred_spawnpoint );
        point.reinforcement_spawn = process_create_script_bool( point.reinforcement_spawn );
        point.is_elite = process_create_script_bool( point.is_elite );
        
        if ( point.script_stealthgroup == "-1" )
        {
            point.script_stealthgroup = undefined;
        }
        
        point.parachute_landing_point = process_create_script_bool( point.parachute_landing_point );
        
        if ( point.parachute_landing_point )
        {
            if ( isdefined( point.targetname ) )
            {
                foreach ( parachutepoint in parachutestartpoints )
                {
                    if ( parachutepoint.target == point.targetname )
                    {
                        point.parachute_start_pos = parachutepoint.origin;
                    }
                }
                
                if ( !isdefined( point.parachute_start_pos ) )
                {
                    point.parachute_start_pos = ( point.origin[ 0 ], point.origin[ 1 ], point.origin[ 2 ] + point.var_6324368dbfa7058a );
                }
            }
            else
            {
                point.parachute_start_pos = ( point.origin[ 0 ], point.origin[ 1 ], point.origin[ 2 ] + point.var_6324368dbfa7058a );
            }
        }
        
        if ( isdefined( point.info_act_ref ) && isdefined( var_c6a73a31adbe90d2[ point.info_act_ref ] ) )
        {
            point.interactionname = var_c6a73a31adbe90d2[ point.info_act_ref ].ai_interaction;
            point.interactionorigin = var_c6a73a31adbe90d2[ point.info_act_ref ].origin;
            point.interactionangles = var_c6a73a31adbe90d2[ point.info_act_ref ].angles;
        }
        else if ( isdefined( point.target ) && isdefined( var_c6a73a31adbe90d2[ point.target ] ) )
        {
            point.interactionname = var_c6a73a31adbe90d2[ point.target ].ai_interaction;
            point.interactionorigin = var_c6a73a31adbe90d2[ point.target ].origin;
            point.interactionangles = var_c6a73a31adbe90d2[ point.target ].angles;
        }
        
        point.info_act_ref = undefined;
        
        if ( isdefined( point.minspawns ) )
        {
            point.minspawns = int( point.minspawns );
        }
        
        if ( isdefined( point.maxspawns ) )
        {
            point.maxspawns = int( point.maxspawns );
        }
        
        if ( isdefined( point.location_spawnpoint ) )
        {
            point.location_spawnpoint = process_create_script_bool( point.location_spawnpoint );
        }
        else
        {
            point.location_spawnpoint = point.variantname == "ai_encounter_location_spawnpoint";
        }
        
        if ( isdefined( point.reusecooldown ) )
        {
            point.reusecooldown = float( point.reusecooldown );
        }
        
        if ( isdefined( point.radius ) )
        {
            point.radius = float( point.radius );
        }
        
        if ( isdefined( point.wait_time ) )
        {
            point.wait_time = int( point.wait_time );
        }
        
        point.var_433589829cadc877 = process_create_script_bool( point.var_433589829cadc877 );
        function_dfecc0b725642ed( point );
        point = undefined;
        spawnpoints[ pointindex ] = undefined;
    }
    
    spawnpoints = undefined;
    function_cbc7a1c20227af29();
    volumes = utility::getstructarray( "noent_volume_ai_encounter_cs", "script_noteworthy" );
    
    foreach ( volume in volumes )
    {
        volume.var_5afd49978f924648 = process_create_script_bool( volume.var_5afd49978f924648 );
        volume.var_a8568d8e0b0b6076 = process_create_script_bool( volume.var_a8568d8e0b0b6076 );
        volume.var_3f3960eb7318312d = process_create_script_bool( volume.var_3f3960eb7318312d );
        volume.var_95e2cee7aca5aaae = process_create_script_bool( volume.var_95e2cee7aca5aaae );
        volume.is_ambient = process_create_script_bool( volume.is_ambient );
        
        if ( isdefined( volume.default_goal_radius ) )
        {
            volume.default_goal_radius = float( volume.default_goal_radius );
        }
        
        if ( volume.script_stealthgroup == "-1" )
        {
            volume.script_stealthgroup = undefined;
        }
        
        function_f09cb58bddf9a7ea( volume );
    }
    
    if ( getdvarint( @"hash_6c2c138ca17a4631", 1 ) == 1 )
    {
        thread function_5e8e513b487c4dc7();
    }
    
    utility::flag_set( "ai_spawn_director_create_script_processed" );
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0xa5abc140, Offset: 0x4330
// Size: 0x2d7
function function_ce4d6b81417e3b34()
{
    encounterselectors = utility::getstructarray( "script_struct_ai_encounter_selector", "script_noteworthy" );
    
    foreach ( selector in encounterselectors )
    {
        if ( selector.target != "" && isdefined( selector.target ) )
        {
            encounters = function_4cc9aafe98c53c7f( selector.target );
            
            if ( encounters.size > 0 )
            {
                foreach ( encounter in encounters )
                {
                    function_ef57f478f96b050c( encounter, 0 );
                }
                
                filteredencounters = [];
                
                foreach ( encounter in encounters )
                {
                    if ( selector.script_required_tag && !function_7ee822e93093763e( encounter, selector.script_required_tag ) )
                    {
                        continue;
                    }
                    
                    if ( selector.script_ignore_tag && function_7ee822e93093763e( encounter, selector.script_ignore_tag ) )
                    {
                        continue;
                    }
                    
                    filteredencounters[ filteredencounters.size ] = encounter;
                }
                
                if ( filteredencounters.size == 0 )
                {
                    continue;
                }
                
                mincount = 1;
                maxcount = 1;
                selectcount = 1;
                
                if ( isdefined( selector.script_count_min ) )
                {
                    mincount = int( selector.script_count_min );
                }
                
                if ( isdefined( selector.script_count_max ) )
                {
                    maxcount = int( selector.script_count_max );
                }
                
                assert( mincount <= maxcount, "<dev string:x6a1>" + selector.target );
                
                if ( mincount <= maxcount )
                {
                    selectcount = randomintrange( mincount, maxcount + 1 );
                }
                
                if ( selectcount <= 0 )
                {
                    continue;
                }
                
                filteredencounters = arrayrandomize( filteredencounters );
                
                for ( encounterindex = 0; encounterindex < filteredencounters.size && encounterindex < selectcount ; encounterindex++ )
                {
                    function_ef57f478f96b050c( filteredencounters[ encounterindex ], 1 );
                }
            }
        }
    }
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x88e41bf3, Offset: 0x460f
// Size: 0xd1
function private function_5e8e513b487c4dc7()
{
    var_c00c5fb6c6a69c4f = getdvarint( @"hash_59839a5de33b3ef6", 5 );
    level thread function_f7bda4bac3a2a942( "variantname", "ai_encounter_patrol_point", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "script_noteworthy", "ai_encounter_patrol_point", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "variantname", "ai_encounter_parachute_start", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "variantname", "ai_encounter_spawnpoint", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "script_noteworthy", "ai_encounter_spawnpoint", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "variantname", "ai_encounter_wander_spawnpoint", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "variantname", "ai_encounter_patrolstart_spawnpoint", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "variantname", "ai_encounter_location_spawnpoint", var_c00c5fb6c6a69c4f );
    level thread function_f7bda4bac3a2a942( "script_noteworthy", "noent_volume_ai_encounter_cs", var_c00c5fb6c6a69c4f );
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0xddb780a7, Offset: 0x46e8
// Size: 0xd2
function private function_56d14e125bf8e84a( arrayclassname, arraytargetname, typevalue )
{
    if ( isdefined( arraytargetname ) )
    {
        targetnamearray = [];
        arraysize = level.struct_class_names[ arrayclassname ][ arraytargetname ].size;
        
        for ( structindex = 0; structindex < arraysize ; structindex++ )
        {
            if ( level.struct_class_names[ arrayclassname ][ arraytargetname ][ structindex ].variantname != typevalue && level.struct_class_names[ arrayclassname ][ arraytargetname ][ structindex ].script_noteworthy != typevalue )
            {
                targetnamearray[ targetnamearray.size ] = level.struct_class_names[ arrayclassname ][ arraytargetname ][ structindex ];
            }
        }
        
        if ( targetnamearray.size != arraysize )
        {
            level.struct_class_names[ arrayclassname ][ arraytargetname ] = targetnamearray;
        }
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0xa8aef69a, Offset: 0x47c2
// Size: 0x144
function private function_f7bda4bac3a2a942( type, typevalue, var_20c6f4005cc6b4c0 )
{
    structs = level.struct_class_names[ type ][ typevalue ];
    
    if ( !isarray( structs ) )
    {
        return;
    }
    
    level.struct_class_names[ type ][ typevalue ] = [];
    
    while ( level.var_8d45f4cb539a6e10 )
    {
        waitframe();
    }
    
    level.var_8d45f4cb539a6e10 = 1;
    var_7df4c8a63a669ebf = 0;
    
    foreach ( struct in structs )
    {
        function_56d14e125bf8e84a( "targetname", struct.targetname, typevalue );
        function_56d14e125bf8e84a( "target", struct.target, typevalue );
        function_56d14e125bf8e84a( "script_linkname", struct.script_linkname, typevalue );
        var_7df4c8a63a669ebf++;
        
        if ( var_7df4c8a63a669ebf >= var_20c6f4005cc6b4c0 )
        {
            waitframe();
            var_7df4c8a63a669ebf = 0;
        }
    }
    
    waitframe();
    level.var_8d45f4cb539a6e10 = 0;
}

/#

    // Namespace ai_spawn_director
    // Params 0, eflags: 0x4
    // Checksum 0xc2c9d1dd, Offset: 0x490e
    // Size: 0xa72, Type: dev
    function private _devgui_thread()
    {
        devguipath = "<dev string:x6fc>";
        wait 3;
        function_505e6f0ead1ba0d( "<dev string:x72b>", "<dev string:x738>", devguipath + "<dev string:x757>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x763>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x7ab>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x7dc>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x837>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x893>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x8d9>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x920>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x95d>" );
        waitframe();
        adddebugcommand( devguipath + "<dev string:x997>" );
        
        if ( !utility::issp() )
        {
            test_names = [ [ "<dev string:x9cd>", "<dev string:x9d4>", "<dev string:x9e4>" ], [ "<dev string:x9cd>", "<dev string:x9eb>", "<dev string:x9f8>" ], [ "<dev string:x9cd>", "<dev string:xa07>", "<dev string:xa14>" ], [ "<dev string:x9cd>", "<dev string:xa22>", "<dev string:xa2c>" ], [ "<dev string:x9cd>", "<dev string:xa42>", "<dev string:xa46>" ], [ "<dev string:xa51>", "<dev string:x9d4>", "<dev string:xa5d>" ], [ "<dev string:xa51>", "<dev string:x9eb>", "<dev string:xa69>" ], [ "<dev string:xa51>", "<dev string:xa07>", "<dev string:xa7d>" ], [ "<dev string:xa51>", "<dev string:xa22>", "<dev string:xa90>" ], [ "<dev string:xa51>", "<dev string:xa42>", "<dev string:xaab>" ], [ "<dev string:xabb>", "<dev string:x9d4>", "<dev string:xac1>" ], [ "<dev string:xabb>", "<dev string:x9eb>", "<dev string:xac7>" ], [ "<dev string:xabb>", "<dev string:xa07>", "<dev string:xad5>" ], [ "<dev string:xabb>", "<dev string:xa22>", "<dev string:xae2>" ], [ "<dev string:xabb>", "<dev string:xa42>", "<dev string:xaf7>" ], [ "<dev string:xa42>", "<dev string:x9d4>", "<dev string:xb01>" ], [ "<dev string:xa42>", "<dev string:x9eb>", "<dev string:xb1a>" ], [ "<dev string:xa42>", "<dev string:xa07>", "<dev string:xb3b>" ], [ "<dev string:xa42>", "<dev string:xa22>", "<dev string:xb5b>" ], [ "<dev string:xa42>", "<dev string:xa42>", "<dev string:xb83>" ] ];
            
            foreach ( test_name in test_names )
            {
                commandstring = devguipath + "<dev string:xba0>" + test_name[ 0 ] + "<dev string:xbba>" + test_name[ 1 ] + "<dev string:xbbe>" + test_name[ 2 ] + "<dev string:xbef>";
                adddebugcommand( commandstring );
            }
        }
        
        activerequests = [];
        
        while ( true )
        {
            if ( getdvarint( @"hash_c2967f1425f47dcf", 0 ) == 1 )
            {
                foreach ( requestid in activerequests )
                {
                    cancel_spawn_request( requestid );
                }
                
                activerequests = [];
                setdvar( @"hash_c2967f1425f47dcf", 0 );
            }
            
            bundlename = getdvar( @"hash_338fd6962a58ef94", "<dev string:xbf1>" );
            
            if ( bundlename && isalive( level.players[ 0 ] ) )
            {
                fullbundlename = hashcat( %"ai_encounter:", bundlename );
                requestid = spawn_request( fullbundlename, level.players[ 0 ].origin, 1000, 1, 1 );
                activerequests[ activerequests.size ] = requestid;
            }
            
            setdvar( @"hash_338fd6962a58ef94", "<dev string:xbf1>" );
            tagname = getdvar( @"hash_cb77d3c82e353f1d", "<dev string:xbf1>" );
            
            if ( tagname )
            {
                function_a25acb62ddab20e2( tagname, 1 );
                setdvar( @"hash_cb77d3c82e353f1d", "<dev string:xbf1>" );
            }
            
            tagname = getdvar( @"hash_648b265962adac34", "<dev string:xbf1>" );
            
            if ( tagname )
            {
                function_a25acb62ddab20e2( tagname, 0 );
                setdvar( @"hash_648b265962adac34", "<dev string:xbf1>" );
            }
            
            if ( getdvarint( @"hash_7560a9c3d8fb8030", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    function_1c4c7ef874191be2( "<dev string:xbf2>", level.players[ 0 ].origin, 2000 );
                }
                
                setdvar( @"hash_7560a9c3d8fb8030", 0 );
            }
            
            if ( getdvarint( @"hash_a9bfe570a4470e77", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    function_71799ce2c69ce5a9( "<dev string:xbf2>" );
                }
                
                setdvar( @"hash_a9bfe570a4470e77", 0 );
            }
            
            if ( getdvarint( @"hash_b887180c55479401", 0 ) == 1 )
            {
                converted = 0;
                encounters = function_3d653c10296f0b1b( 0, 1 );
                
                foreach ( encounter in encounters )
                {
                    data = function_9b649316adcccbaa( encounter );
                    
                    if ( data.status != 1 )
                    {
                        function_b43716082f77e5e5( encounter );
                        iprintlnbold( "<dev string:xc01>" + encounter + "<dev string:xc17>" );
                    }
                }
                
                if ( !converted )
                {
                    iprintlnbold( "<dev string:xc24>" );
                }
                
                setdvar( @"hash_b887180c55479401", 0 );
            }
            
            if ( getdvarint( @"hash_5052dcf9e0cb4ce1", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    zoneindex = function_93c626f0d446b575( level.players[ 0 ].origin );
                    function_b57e44ce9d93be80( zoneindex );
                }
                
                setdvar( @"hash_5052dcf9e0cb4ce1", 0 );
            }
            
            if ( getdvarint( @"hash_e1ca0daaa71ada82", 0 ) == 1 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    subzone = function_28e6db29ed75c40f( level.players[ 0 ].origin );
                    
                    if ( isdefined( subzone ) )
                    {
                        function_89ae4c5cfa2feb00( subzone.zoneindex, subzone.subzoneindex, !subzone.enabled );
                    }
                }
                
                setdvar( @"hash_e1ca0daaa71ada82", 0 );
            }
            
            settag = getdvar( @"hash_6c37cbeecb7d7215", "<dev string:xbf1>" );
            
            if ( settag )
            {
                subzone = function_28e6db29ed75c40f( level.players[ 0 ].origin );
                
                if ( isdefined( subzone ) )
                {
                    function_5866063fb64cf1a9( subzone.zoneindex, subzone.subzoneindex, settag, 1 );
                }
                
                setdvar( @"hash_6c37cbeecb7d7215", "<dev string:xbf1>" );
            }
            
            cleartag = getdvar( @"hash_226b7063f48ab77a", "<dev string:xbf1>" );
            
            if ( cleartag )
            {
                subzone = function_28e6db29ed75c40f( level.players[ 0 ].origin );
                
                if ( isdefined( subzone ) )
                {
                    function_5866063fb64cf1a9( subzone.zoneindex, subzone.subzoneindex, cleartag, 0 );
                }
                
                setdvar( @"hash_226b7063f48ab77a", "<dev string:xbf1>" );
            }
            
            test_name = getdvar( @"hash_25688c988df289c3", "<dev string:xbf1>" );
            
            if ( test_name != "<dev string:xbf1>" )
            {
                if ( isdefined( level.var_e807ae7cef74a307 ) )
                {
                    thread [[ level.var_e807ae7cef74a307 ]]( test_name );
                }
                
                setdvar( @"hash_25688c988df289c3", "<dev string:xbf1>" );
            }
            
            var_6fec2f6e41c00db = getdvar( @"hash_76a02dcfeaf85e8a", "<dev string:xbf1>" );
            
            if ( var_6fec2f6e41c00db != "<dev string:xbf1>" )
            {
                thread [[ level.var_96589ceaddbba0e6 ]]( var_6fec2f6e41c00db );
                setdvar( @"hash_76a02dcfeaf85e8a", "<dev string:xbf1>" );
            }
            
            if ( getdvarint( @"hash_b8cb86dbb04715e2", 0 ) == 1 )
            {
                function_a25acb62ddab20e2( "<dev string:xc49>", 1 );
                function_a25acb62ddab20e2( "<dev string:xc5b>", 0 );
                setdvar( @"hash_19f0eb1fd6a2f87d", 1 );
                setdvar( @"hash_b8cb86dbb04715e2", 0 );
            }
            
            if ( getdvarint( @"hash_48e36b0fa33ce48f", 0 ) == 1 )
            {
                function_a25acb62ddab20e2( "<dev string:xc49>", 0 );
                function_a25acb62ddab20e2( "<dev string:xc5b>", 1 );
                setdvar( @"hash_19f0eb1fd6a2f87d", 1 );
                setdvar( @"hash_48e36b0fa33ce48f", 0 );
            }
            
            lwagentid = getdvarint( @"hash_14b4dd6c9138d7a6", -1 );
            
            if ( lwagentid != -1 )
            {
                function_e8d926888b39e4d1( lwagentid, 10000 );
                setdvar( @"hash_14b4dd6c9138d7a6", -1 );
            }
            
            encounterid = getdvarint( @"hash_ff2bcf56da809d00", -1 );
            
            if ( encounterid != -1 )
            {
                function_b5b92a58f2fd25f6( encounterid, 10000 );
                setdvar( @"hash_ff2bcf56da809d00", -1 );
            }
            
            waitframe();
        }
    }

    // Namespace ai_spawn_director
    // Params 3, eflags: 0x4
    // Checksum 0xc64c7497, Offset: 0x5388
    // Size: 0x10a, Type: dev
    function private function_505e6f0ead1ba0d( var_7f15ce5a972b7fc2, dvarname, devguipath )
    {
        bundlenames = getscriptbundlenames( var_7f15ce5a972b7fc2 );
        
        foreach ( bundlename in bundlenames )
        {
            bundlenamestring = getxhashsourcename( bundlename );
            array = strtok( bundlenamestring, "<dev string:xc6c>" );
            
            if ( !( isdefined( array ) && isdefined( array[ 1 ] ) ) )
            {
                continue;
            }
            
            cmdstring = devguipath + "<dev string:xc6e>" + array[ 1 ] + "<dev string:xc77>" + dvarname + "<dev string:xc7f>" + array[ 1 ] + "<dev string:xbef>";
            adddebugcommand( cmdstring );
            waitframe();
        }
    }

#/

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xfa8cc02e, Offset: 0x549a
// Size: 0x32
function private _out_of_bounds_init()
{
    if ( getdvarint( @"ai_spawn_director_check_out_of_bounds", 0 ) == 1 && isdefined( level.outofboundstriggers ) )
    {
        function_e231563f612f89f7( level.outofboundstriggers );
    }
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x7b3ee905, Offset: 0x54d4
// Size: 0x91
function private function_b954a604dc5811b()
{
    wait 1;
    
    while ( true )
    {
        settag = getdvar( @"hash_c1b168fb1d959c2f", "" );
        
        if ( settag )
        {
            function_a25acb62ddab20e2( settag, 1 );
            setdvar( @"hash_c1b168fb1d959c2f", "" );
        }
        
        cleartag = getdvar( @"hash_91f3192aa5d2ec6c", "" );
        
        if ( cleartag )
        {
            function_a25acb62ddab20e2( cleartag, 0 );
            setdvar( @"hash_91f3192aa5d2ec6c", "" );
        }
        
        wait 1;
    }
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x77ad23ac, Offset: 0x556d
// Size: 0x1b5
function private _director_init()
{
    if ( !aispawndirectorisenabled() )
    {
        return;
    }
    
    if ( isdefined( level.var_aee978b8c8705c84 ) )
    {
        return;
    }
    
    level.var_8d45f4cb539a6e10 = 0;
    level.var_aee978b8c8705c84 = 1;
    level.var_b9c398f695ae40e2 = &_director_callback;
    level.var_a20b02d86621e9ed = [];
    level.aipatrolpaths = [];
    
    if ( !isdefined( level.var_4c766d9edc0c3e79 ) )
    {
        level.var_4c766d9edc0c3e79 = [];
    }
    
    if ( !isdefined( level.var_6aa07e1d496d2507 ) )
    {
        level.var_6aa07e1d496d2507 = [];
    }
    
    level.var_ac4d968ccb10fa96 = [];
    level.var_4e3e63b167b19473 = [];
    level.var_b7f0da7ac80e9755 = [];
    level.var_eefebdafec711f3b = [];
    level.var_af47d34ad4800660 = &_lookup_callback;
    level.var_c9ee967436c4aef1 = &function_9419b995f7b80fe3;
    level.var_9113767d83484110 = &function_431a955cdf4541d6;
    level.var_2cefcfce07d0ec89 = &function_d01c01d2ae601d33;
    level.var_a2840f6fd3266931 = &function_87d2160f1f99c092;
    level.var_53ab230739a1dc59 = &function_8e5fd6ee7c16e173;
    level.var_ebf7251ad1dfbf01 = &function_9b4d7efab3d65703;
    level.var_6c16ea3007e1f6ff = &function_abadd6786f1c47f1;
    level.var_8ef3e1bd276011eb = &ai_parachute_util::function_eaef79ee8709ab89;
    level.var_46fda7b32c44e034 = &function_cd73d5a41d9796c6;
    level.var_95924257d090fe9d = &_precombat;
    function_fb69eb0fc214329c();
    namespace_37f5741ccbccb7a::function_c2d182d5a2dfe516();
    thread function_cebfb0c5c8553b2d();
    thread function_b954a604dc5811b();
    _out_of_bounds_init();
    function_347eaa94397a9de2();
    
    /#
        level thread _devgui_thread();
    #/
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        function_89353523460a3b1e( level.outofboundstriggers );
    }
    
    assert( level.var_b652537ae1e39415, "<dev string:xc81>" );
    function_fe1bd817f76d7787();
    utility::flag_set( "ai_spawn_director_initialized" );
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0x5f4390b8, Offset: 0x572a
// Size: 0x136
function function_dee86930a11f3d9e()
{
    level.var_4d5a2411b96fed3b = function_3d653c10296f0b1b( 1, 0 );
    level.var_e705fd124846ca01 = [];
    level.var_ee0bf8e63064304e = [];
    reinforcementareas = utility::getstructarray( "ai_director_reinforcement_area", "variantname" );
    
    /#
        level thread function_c2bfc6f3cf359abd();
    #/
    
    foreach ( area in reinforcementareas )
    {
        bundlename = hashcat( %"hash_4f99210e7aa63124", area.var_97211249c4ced036 );
        
        if ( !isdefined( level.var_ee0bf8e63064304e[ bundlename ] ) )
        {
            bundle = getscriptbundle( bundlename );
            
            if ( !isdefined( bundle ) )
            {
                assertmsg( "<dev string:xcd5>" + bundlename );
                continue;
            }
            else
            {
                level.var_ee0bf8e63064304e[ bundlename ] = bundle;
            }
        }
        
        areaindex = function_995a48fee89d70d1( area, bundlename );
        waitframe();
    }
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x4c19646, Offset: 0x5868
// Size: 0x21f
function function_995a48fee89d70d1( structpoi, reinforcementbundlename )
{
    areaindex = level.var_e705fd124846ca01.size;
    reinforcementarea = spawnstruct();
    reinforcementarea.var_185a806e4e65310d = [];
    reinforcementarea.numaideaths = 0;
    reinforcementarea.var_a6188e36c5ce6bcc = 0;
    reinforcementarea.var_21edb89b5af99c0f = 0;
    reinforcementarea.var_db9fb6ac4ccde0e8 = 0;
    reinforcementarea.var_6279d854d23c2112 = 0;
    reinforcementarea.reinforcementcount = 0;
    reinforcementarea.reinforcementareaindex = areaindex;
    reinforcementarea.reinforcementbundlename = reinforcementbundlename;
    reinforcementarea.targetname = structpoi.targetname;
    reinforcementarea.origin = structpoi.origin;
    reinforcementarea.radius = structpoi.radius;
    reinforcementarea.script_stealthgroup = structpoi.script_stealthgroup;
    reinforcementarea.enabled = 1;
    level.var_e705fd124846ca01[ areaindex ] = reinforcementarea;
    
    foreach ( encounterid in level.var_4d5a2411b96fed3b )
    {
        encountercenter = aispawndirectorgetencountercenter( encounterid );
        encounterradius = function_6433fa8ea1ce8da0( encounterid );
        
        if ( function_81db9c4c6fe14c60( structpoi.origin, structpoi.radius, encountercenter, encounterradius ) )
        {
            var_e68c3e8e7a97cc89 = level.var_e705fd124846ca01[ areaindex ].var_185a806e4e65310d.size;
            level.var_e705fd124846ca01[ areaindex ].var_185a806e4e65310d[ var_e68c3e8e7a97cc89 ] = encounterid;
        }
    }
    
    level thread function_b7fbd1b3a26254a3( areaindex );
    return areaindex;
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xee4442a9, Offset: 0x5a90
// Size: 0x10c
function function_b9e4174a5b2295d3( requestid )
{
    if ( isdefined( level.var_e705fd124846ca01 ) )
    {
        foreach ( area in level.var_e705fd124846ca01 )
        {
            foreach ( trackedrequest in area.var_185a806e4e65310d )
            {
                if ( requestid == trackedrequest )
                {
                    return area.reinforcementareaindex;
                }
            }
        }
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x84b9e172, Offset: 0x5ba5
// Size: 0xa6
function function_43f179843e99c826( areaname )
{
    if ( isdefined( level.var_e705fd124846ca01 ) )
    {
        foreach ( area in level.var_e705fd124846ca01 )
        {
            if ( areaname == area.targetname )
            {
                return area.reinforcementareaindex;
            }
        }
    }
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x1ca74376, Offset: 0x5c54
// Size: 0x56
function disable_dynamic_reinforcement_area( areaindex, shoulddisable )
{
    if ( isdefined( level.var_e705fd124846ca01[ areaindex ] ) )
    {
        level.var_e705fd124846ca01[ areaindex ].enabled = !shoulddisable;
        level.var_e705fd124846ca01[ areaindex ] notify( #"dynamic_reinforcement_area_disabled" );
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x376af32, Offset: 0x5cb2
// Size: 0xa5
function function_30967cc65fd6cba3( shoulddisable )
{
    if ( isdefined( level.var_e705fd124846ca01 ) )
    {
        foreach ( area in level.var_e705fd124846ca01 )
        {
            area.enabled = !shoulddisable;
            area notify( #"dynamic_reinforcement_area_disabled" );
        }
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x645a7438, Offset: 0x5d5f
// Size: 0x27
function function_a7c0f408b30cf066( reinforcementareaindex )
{
    thread function_ec389dfdb4e18f91( reinforcementareaindex );
    thread function_43424315dc4fad7f( reinforcementareaindex );
    thread function_1e365ec59f075b29( reinforcementareaindex );
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x94c0248c, Offset: 0x5d8e
// Size: 0x1d
function function_ae3cb26bc2f24781( var_a205a248129b4545, var_84543df2efd3eb40 )
{
    function_487e038e594e0c31( var_a205a248129b4545, var_84543df2efd3eb40 );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x24f08b47, Offset: 0x5db3
// Size: 0x5a, Type: bool
function private function_81db9c4c6fe14c60( firstcenter, firstradius, secondcenter, secondradius )
{
    distsq = distancesquared( firstcenter, secondcenter );
    radiisum = firstradius + secondradius;
    radiisumsq = radiisum * radiisum;
    return distsq <= radiisumsq;
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xf0e5078, Offset: 0x5e16
// Size: 0x110
function private function_6230ce6691589765()
{
    if ( isdefined( level.var_e705fd124846ca01 ) )
    {
        foreach ( area in level.var_e705fd124846ca01 )
        {
            foreach ( trackedrequest in area.var_185a806e4e65310d )
            {
                if ( self.directorrequestid == trackedrequest )
                {
                    function_a7c0f408b30cf066( area.reinforcementareaindex );
                }
            }
        }
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xf53638ec, Offset: 0x5f2f
// Size: 0x193
function private function_ec389dfdb4e18f91( areaindex )
{
    level endon( #"game_ended" );
    self waittill( #"death", attacker );
    
    if ( self.stealth_bsmstate == 3 )
    {
        assert( level.var_e705fd124846ca01[ areaindex ].var_21edb89b5af99c0f > 0, "<dev string:xd05>" );
        level.var_e705fd124846ca01[ areaindex ].var_21edb89b5af99c0f--;
    }
    
    if ( isplayer( attacker ) )
    {
        reinforcementarea = level.var_e705fd124846ca01[ areaindex ];
        
        if ( !reinforcementarea.enabled || gettime() < reinforcementarea.var_5ca2efce0dc707a )
        {
            return;
        }
        
        bundle = level.var_ee0bf8e63064304e[ reinforcementarea.reinforcementbundlename ];
        suminfluence = getplayerinfluenceatposition( self.origin, 1 );
        maxinfluence = getplayerinfluenceatposition( self.origin, 0 );
        
        if ( suminfluence >= bundle.reinforcementareatuning.var_14f970ee07b9f708 && maxinfluence >= bundle.reinforcementareatuning.var_486523ed7139abd9 )
        {
            reinforcementarea.numaideaths++;
            reinforcementarea.var_aca68be0b7de5e42 = self.origin;
            reinforcementarea.var_8e766aee6adeb07b = attacker.origin;
            reinforcementarea.var_b834721420095112 = self.directorrequestid;
        }
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xbd2fdae6, Offset: 0x60ca
// Size: 0xc8
function private function_43424315dc4fad7f( areaindex )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"stealth_combat", attacker );
        level.var_e705fd124846ca01[ areaindex ].var_21edb89b5af99c0f++;
        level.var_e705fd124846ca01[ areaindex ].var_aca68be0b7de5e42 = self.origin;
        
        if ( isdefined( attacker ) )
        {
            level.var_e705fd124846ca01[ areaindex ].var_8e766aee6adeb07b = attacker.origin;
        }
        else
        {
            level.var_e705fd124846ca01[ areaindex ].var_8e766aee6adeb07b = self.origin;
        }
        
        waitframe();
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xb1305534, Offset: 0x619a
// Size: 0x76
function private function_1e365ec59f075b29( areaindex )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"stealth_combat_exited" );
        assert( level.var_e705fd124846ca01[ areaindex ].var_21edb89b5af99c0f > 0, "<dev string:xd05>" );
        level.var_e705fd124846ca01[ areaindex ].var_21edb89b5af99c0f--;
        waitframe();
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x7f2ef068, Offset: 0x6218
// Size: 0x3e8
function private function_b7fbd1b3a26254a3( areaindex )
{
    level endon( #"game_ended" );
    level.var_e705fd124846ca01[ areaindex ] endon( #"dynamic_reinforcement_area_disabled" );
    reinforcementarea = level.var_e705fd124846ca01[ areaindex ];
    areaname = reinforcementarea.targetname;
    bundle = level.var_ee0bf8e63064304e[ reinforcementarea.reinforcementbundlename ];
    reinforcementtriggers = bundle.reinforcementareatuning.reinforcementtriggers;
    var_fa9acac35f4d787f = bundle.reinforcementareatuning.var_fa9acac35f4d787f;
    
    if ( !isdefined( reinforcementarea.var_5ca2efce0dc707a ) )
    {
        level.var_e705fd124846ca01[ areaindex ].var_5ca2efce0dc707a = gettime();
    }
    
    var_ecfd8fb164a26976 = function_b20cdd0c0737d9fc();
    var_2146cf3dc095deaa = 0;
    var_f2a85eea896364b7 = 0;
    
    while ( !var_f2a85eea896364b7 && !var_2146cf3dc095deaa )
    {
        var_51b980e0f2ef03fa = 0;
        var_527b63594ce54c0f = 0;
        
        foreach ( spawntrigger in reinforcementtriggers )
        {
            switch ( spawntrigger.triggertype )
            {
                case #"hash_9ccb46b94a7eb6e2":
                    if ( reinforcementarea.var_a6188e36c5ce6bcc < spawntrigger.triggercap )
                    {
                        if ( reinforcementarea.numaideaths >= spawntrigger.deathcountthreshold )
                        {
                            var_527b63594ce54c0f = 1;
                            reinforcementarea.var_a6188e36c5ce6bcc++;
                        }
                    }
                    
                    break;
                case #"hash_9b02ab80d56b8f3":
                    if ( reinforcementarea.var_db9fb6ac4ccde0e8 < spawntrigger.triggercap )
                    {
                        if ( reinforcementarea.var_21edb89b5af99c0f >= spawntrigger.var_fec6f956144f53e1 )
                        {
                            suminfluence = getplayerinfluenceatposition( reinforcementarea.var_aca68be0b7de5e42, 1 );
                            maxinfluence = getplayerinfluenceatposition( reinforcementarea.var_aca68be0b7de5e42, 0 );
                            
                            if ( suminfluence >= bundle.reinforcementareatuning.var_14f970ee07b9f708 && maxinfluence >= bundle.reinforcementareatuning.var_486523ed7139abd9 )
                            {
                                var_527b63594ce54c0f = 1;
                                reinforcementarea.var_db9fb6ac4ccde0e8++;
                            }
                        }
                    }
                    
                    break;
                default:
                    assertmsg( "<dev string:xd35>" + getxhashsourcename( reinforcementarea.reinforcementbundlename ) );
                    break;
            }
            
            if ( var_527b63594ce54c0f )
            {
                var_51b980e0f2ef03fa++;
            }
            
            if ( var_527b63594ce54c0f && !var_fa9acac35f4d787f )
            {
                var_f2a85eea896364b7 = 1;
                break;
            }
            
            if ( !var_527b63594ce54c0f && var_fa9acac35f4d787f )
            {
                var_f2a85eea896364b7 = 0;
                break;
            }
        }
        
        if ( !var_f2a85eea896364b7 && var_fa9acac35f4d787f && var_51b980e0f2ef03fa == reinforcementtriggers.size )
        {
            var_f2a85eea896364b7 = 1;
        }
        
        if ( var_f2a85eea896364b7 )
        {
            var_bcb9169883a159de = getplayerinfluenceatposition( reinforcementarea.var_aca68be0b7de5e42 );
            
            if ( var_bcb9169883a159de >= var_ecfd8fb164a26976 && reinforcementarea.enabled )
            {
                break;
            }
        }
        
        wait 1;
    }
    
    encounterstruct = function_dd4c46cdd18025f9( areaindex, bundle );
    
    if ( !isdefined( encounterstruct.encounterbundlename ) )
    {
        assertmsg( "<dev string:xd80>" + areaname + "<dev string:xdba>" + reinforcementarea.var_aca68be0b7de5e42 );
        return;
    }
    
    delaytime = function_9ff6d6804491561d( reinforcementarea );
    wait delaytime;
    function_f97b59568749a6c4( areaindex, encounterstruct, bundle );
    reinforcementarea.reinforcementcount++;
    level thread function_640584eeb7ee6776( areaindex );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xa4006eb7, Offset: 0x6608
// Size: 0x148
function private function_dd4c46cdd18025f9( areaindex, bundle )
{
    area = level.var_e705fd124846ca01[ areaindex ];
    
    if ( !area.reinforcement_list )
    {
        function_fd1c5482a733d7a7( areaindex, bundle );
    }
    
    if ( !isdefined( area.var_6592e70371a939c2 ) )
    {
        area.var_6592e70371a939c2 = 0;
    }
    
    area.var_6592e70371a939c2 = area.var_6592e70371a939c2 == area.reinforcement_list.size ? 0 : area.var_6592e70371a939c2;
    
    for ( idx = 0; idx < area.reinforcement_list.size ; idx++ )
    {
        current_idx = ( idx + area.var_6592e70371a939c2 ) % area.reinforcement_list.size;
        potentialencounter = area.reinforcement_list[ current_idx ];
        var_400d35d9115f694e = getxhashasset( potentialencounter.encounterbundlename );
        encounterstruct = area.reinforcement_list[ current_idx ];
        
        if ( function_a364e022aa9a0cdf( areaindex, var_400d35d9115f694e ) )
        {
            area.var_6592e70371a939c2 = current_idx + 1;
            return encounterstruct;
        }
    }
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x49bfd3eb, Offset: 0x6759
// Size: 0x20a
function private function_fd1c5482a733d7a7( areaindex, bundle )
{
    encounterstruct = spawnstruct();
    level.var_e705fd124846ca01[ areaindex ].reinforcement_list = [];
    
    foreach ( encounter in bundle.potentialencounters )
    {
        var_400d35d9115f694e = getxhashasset( encounter.encounter );
        
        if ( encounter.radiusmin < encounter.radiusmax )
        {
            encounterstruct.reinforceradius = randomfloatrange( encounter.radiusmin, encounter.radiusmax );
        }
        else
        {
            encounterstruct.reinforceradius = encounter.radiusmin;
        }
        
        potentialencounterbundle = getscriptbundle( var_400d35d9115f694e );
        encounterstruct.var_330e4613c1d885c9 = potentialencounterbundle.potentialbuckets[ 0 ].var_330e4613c1d885c9;
        encounterstruct.vehiclespawntype = potentialencounterbundle.potentialbuckets[ 0 ].vehiclespawntype;
        encounterstruct.encounterbundlename = encounter.encounter;
        encounterstruct.encounterplacement = encounter.encounterplacement;
        level.var_e705fd124846ca01[ areaindex ].reinforcement_list[ level.var_e705fd124846ca01[ areaindex ].reinforcement_list.size ] = structcopy( encounterstruct );
    }
    
    level.var_e705fd124846ca01[ areaindex ].reinforcement_list = arrayrandomize( level.var_e705fd124846ca01[ areaindex ].reinforcement_list );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xd412751c, Offset: 0x696b
// Size: 0x113, Type: bool
function private function_a364e022aa9a0cdf( areaindex, name )
{
    potentialencounterbundle = getscriptbundle( name );
    requiresalltags = potentialencounterbundle.requiredalltags;
    
    foreach ( requiredtag in potentialencounterbundle.requiredtags )
    {
        hastags = 1;
        tagsvalid = function_7ee822e93093763e( level.var_e705fd124846ca01[ areaindex ].var_aca68be0b7de5e42, requiredtag.tag );
        
        if ( !tagsvalid && requiresalltags || tagsvalid && !requiresalltags )
        {
            break;
        }
    }
    
    if ( !tagsvalid && hastags )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x33a06ec6, Offset: 0x6a87
// Size: 0x45a
function private function_f97b59568749a6c4( areaindex, encounterstruct, bundle )
{
    reinforcementarea = level.var_e705fd124846ca01[ areaindex ];
    reinforcementorigin = undefined;
    var_330e4613c1d885c9 = encounterstruct.var_330e4613c1d885c9;
    vehiclespawntype = encounterstruct.vehiclespawntype;
    
    if ( isdefined( reinforcementarea.var_8e766aee6adeb07b ) )
    {
        reinforcementorigin = reinforcementarea.var_8e766aee6adeb07b;
    }
    else if ( isdefined( reinforcementarea.var_aca68be0b7de5e42 ) )
    {
        reinforcementorigin = reinforcementarea.var_aca68be0b7de5e42;
    }
    else
    {
        reinforcementorigin = reinforcementarea.origin;
    }
    
    encounterplacement = encounterstruct.encounterplacement ?? #"attacker";
    
    if ( encounterplacement == #"ai" )
    {
        if ( isdefined( reinforcementarea.var_aca68be0b7de5e42 ) )
        {
            spawnorigin = reinforcementarea.var_aca68be0b7de5e42;
        }
    }
    else if ( encounterplacement == #"attacker" )
    {
        if ( isdefined( reinforcementarea.var_8e766aee6adeb07b ) )
        {
            spawnorigin = reinforcementarea.var_8e766aee6adeb07b;
        }
    }
    else
    {
        assert( encounterplacement == #"location" );
        validlocationspawnpoints = [];
        locationspawns = function_59b972ac4477f673( reinforcementarea.var_aca68be0b7de5e42, 5000 );
        
        if ( isdefined( var_330e4613c1d885c9 ) && isdefined( vehiclespawntype ) && isdefined( locationspawns ) )
        {
            foreach ( point in locationspawns )
            {
                validlocation = 0;
                
                if ( var_330e4613c1d885c9 )
                {
                    if ( #"parachute" == vehiclespawntype && point.isparachutespawn )
                    {
                        validlocation = 1;
                    }
                    else if ( #"groundvehicle" == vehiclespawntype || #"airvehicle" == vehiclespawntype )
                    {
                        if ( isdefined( point.vehiclepathtargetname ) )
                        {
                            validlocation = 1;
                        }
                    }
                }
                else if ( !point.isparachutespawn && !isdefined( point.vehiclepathtargetname ) )
                {
                    validlocation = 1;
                }
                
                if ( validlocation )
                {
                    validlocationspawnpoint = spawnstruct();
                    validlocationspawnpoint.point = point;
                    validlocationspawnpoint.influence = getplayerinfluenceatposition( point.location );
                    validlocationspawnpoints[ validlocationspawnpoints.size ] = validlocationspawnpoint;
                }
            }
            
            if ( validlocationspawnpoints.size >= 1 )
            {
                if ( validlocationspawnpoints.size == 1 )
                {
                    spawnorigin = validlocationspawnpoints[ 0 ].location;
                }
                else
                {
                    maxinfluence = -1;
                    
                    foreach ( locspawn in validlocationspawnpoints )
                    {
                        if ( locspawn.influence > maxinfluence )
                        {
                            maxinfluence = locspawn.influence;
                            spawnorigin = locspawn.point.location;
                        }
                    }
                }
            }
        }
        
        if ( !isdefined( spawnorigin ) )
        {
            spawnorigin = reinforcementorigin;
        }
    }
    
    requestid = spawn_request( encounterstruct.encounterbundlename, reinforcementorigin, encounterstruct.reinforceradius, 0, 1, 0, 1 );
    
    if ( isdefined( requestid ) )
    {
        function_1ac3703e7bc56a8( requestid, spawnorigin, encounterstruct.reinforceradius, 0 );
        function_ef57f478f96b050c( requestid, 1 );
        function_5a08798970350207( requestid, &function_8dab3db7c1ab5299, { #areaindex:areaindex, #radius:encounterstruct.reinforceradius, #origin:reinforcementorigin } );
        add_spawned_callback( requestid, &function_c91eb6da04358a30, reinforcementarea );
        function_a49c35b72d6b6fea( requestid, &function_dae1887ae39dabb6, reinforcementarea );
    }
    
    level.var_e705fd124846ca01[ areaindex ].var_ee7d2f668d3aba17 = gettime();
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x6c7b92fe, Offset: 0x6ee9
// Size: 0x33
function private function_8dab3db7c1ab5299( requestid, reinforcestruct )
{
    function_afa23f7d94908b20( requestid, reinforcestruct );
    function_6178df6eba4b0711( requestid, reinforcestruct.areaindex );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x404dea95, Offset: 0x6f24
// Size: 0x4b
function private function_c91eb6da04358a30( requestid, reinforcementarea, agent, data )
{
    function_45fe0b71c3d9a143( requestid, reinforcementarea, agent, data );
    function_b8ffaa74a2c4e2b7( requestid, reinforcementarea.reinforcementareaindex, agent, data );
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0xc5415e16, Offset: 0x6f77
// Size: 0x71
function private function_45fe0b71c3d9a143( requestid, reinforcementarea, agent, data )
{
    if ( !isdefined( reinforcementarea.script_stealthgroup ) )
    {
        backupstealthgroup = "dynamic_reinforcement_area_" + requestid;
        data.script_stealthgroup = backupstealthgroup;
        return;
    }
    
    data.script_stealthgroup = reinforcementarea.script_stealthgroup;
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x22256c40, Offset: 0x6ff0
// Size: 0x3b
function private function_7ae32bc792017376( requestid, agent, reinforcestruct )
{
    agent setgoalpos( reinforcestruct.origin, reinforcestruct.radius );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xafba101c, Offset: 0x7033
// Size: 0xa4
function private function_afa23f7d94908b20( requestid, reinforcestruct )
{
    data = function_9b649316adcccbaa( requestid );
    
    foreach ( agent in data.ai )
    {
        agent thread function_7ae32bc792017376( requestid, agent, reinforcestruct );
    }
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0x9c158b0c, Offset: 0x70df
// Size: 0x31
function private function_b8ffaa74a2c4e2b7( requestid, areaindex, agent, data )
{
    agent thread function_7a8bf31e57445e82( areaindex );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x5984e434, Offset: 0x7118
// Size: 0x4a
function private function_6178df6eba4b0711( requestid, areaindex )
{
    data = function_9b649316adcccbaa( requestid );
    level.var_e705fd124846ca01[ areaindex ].var_556dd8332c13b0a0 = data.ai.size;
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xdf0e4ddf, Offset: 0x716a
// Size: 0x5c
function private function_7a8bf31e57445e82( areaindex )
{
    level endon( #"game_ended" );
    self waittill( #"death", attacker );
    
    if ( isplayer( attacker ) )
    {
        reinforcementarea = level.var_e705fd124846ca01[ areaindex ];
        reinforcementarea.var_6279d854d23c2112++;
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0xb147375d, Offset: 0x71ce
// Size: 0x41
function private function_dae1887ae39dabb6( requestid, reinforcementarea, data )
{
    if ( !data.canreactivate )
    {
        level notify( reinforcementarea.reinforcementareaindex + "_dynamic_reinforcement_encounter_finished" );
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x47c54680, Offset: 0x7217
// Size: 0x179
function private function_640584eeb7ee6776( areaindex )
{
    level endon( #"game_ended" );
    level.var_e705fd124846ca01[ areaindex ] endon( #"dynamic_reinforcement_area_disabled" );
    level waittill( areaindex + "_dynamic_reinforcement_encounter_finished" );
    reinforcementarea = level.var_e705fd124846ca01[ areaindex ];
    bundle = level.var_ee0bf8e63064304e[ reinforcementarea.reinforcementbundlename ];
    reinforcementcount = reinforcementarea.reinforcementcount;
    var_1bae049a1e7a6bfc = bundle.reinforcementareatuning.var_1bae049a1e7a6bfc;
    reinforcementarea.numaideaths = 0;
    reinforcementarea.var_6279d854d23c2112 = 0;
    
    if ( reinforcementcount < var_1bae049a1e7a6bfc )
    {
        cooldowntime = randomfloatrange( bundle.reinforcementareatuning.cooldownmin, bundle.reinforcementareatuning.cooldownmax );
        reinforcementarea.var_5ca2efce0dc707a = gettime() + cooldowntime * 1000;
        wait cooldowntime;
        level thread function_b7fbd1b3a26254a3( areaindex );
        return;
    }
    
    var_7a4e93ea6756d6df = function_2644dad52dfae787( reinforcementarea );
    wait var_7a4e93ea6756d6df;
    reinforcementarea.var_5ca2efce0dc707a = 0;
    reinforcementarea.reinforcementcount = 0;
    reinforcementarea.var_a6188e36c5ce6bcc = 0;
    reinforcementarea.var_db9fb6ac4ccde0e8 = 0;
    level thread function_b7fbd1b3a26254a3( areaindex );
}

/#

    // Namespace ai_spawn_director
    // Params 0, eflags: 0xc
    // Checksum 0x43e51b12, Offset: 0x7398
    // Size: 0x2bc, Type: dev
    function private function_c2bfc6f3cf359abd()
    {
        self notify( #"hash_2eb9216bab31bafe" );
        self endon( #"hash_2eb9216bab31bafe" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_352053f7df36a823", 0 ) == 1 )
            {
                if ( isdefined( level.var_e705fd124846ca01 ) )
                {
                    foreach ( area in level.var_e705fd124846ca01 )
                    {
                        if ( isdefined( area ) )
                        {
                            sphere( area.origin, area.radius, ( 1, 1, 1 ), 1, 20 );
                            printorigin = area.origin;
                            print3d( printorigin, area.reinforcementbundlename, ( 1, 1, 1 ), 1, 1, 20, 1 );
                            printorigin -= ( 0, 0, 20 );
                            
                            if ( area.var_185a806e4e65310d.size > 0 )
                            {
                                trackedencounters = "<dev string:xdc7>";
                                
                                foreach ( encounterid in area.var_185a806e4e65310d )
                                {
                                    trackedencounters += encounterid + "<dev string:xc7f>";
                                }
                                
                                print3d( printorigin, trackedencounters, ( 1, 1, 1 ), 1, 1, 20, 1 );
                                printorigin -= ( 0, 0, 20 );
                            }
                            
                            print3d( printorigin, "<dev string:xdcd>" + area.numaideaths + "<dev string:xdd6>" + area.var_21edb89b5af99c0f, ( 1, 1, 1 ), 1, 1, 20, 1 );
                            printorigin -= ( 0, 0, 20 );
                            
                            if ( area.var_5ca2efce0dc707a > gettime() )
                            {
                                print3d( printorigin, "<dev string:xde0>" + ( area.var_5ca2efce0dc707a - gettime() ) / 1000, ( 1, 1, 1 ), 1, 1, 20, 1 );
                                printorigin -= ( 0, 0, 20 );
                            }
                        }
                    }
                }
            }
            
            wait 1;
        }
    }

#/

// Namespace ai_spawn_director
// Params 4
// Checksum 0x2110a06, Offset: 0x765c
// Size: 0x330
function _wander( agent, radius, radiusvariance, wanderorigin )
{
    if ( agent.briotshieldinitialized )
    {
        return;
    }
    
    if ( !isdefined( wanderorigin ) )
    {
        wanderorigin = agent.origin;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 100;
    }
    
    if ( !isdefined( radiusvariance ) || radiusvariance <= 0 )
    {
        radiusvariance = 50;
    }
    
    agent endon( #"death" );
    agent endon( #"stealth_investigate" );
    agent endon( #"stealth_hunt" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    agent endon( #"enemy" );
    agent endon( #"endDirectorInitiatedWander" );
    agent thread function_896169b92e7bb14e();
    wait randomfloatrange( 1, 2 );
    var_84b7b1bb88be3927 = findclosesttacpoint( wanderorigin );
    
    if ( !( isdefined( var_84b7b1bb88be3927 ) && isdefined( var_84b7b1bb88be3927.navzoneindex ) ) || var_84b7b1bb88be3927.navzoneindex < 0 )
    {
        agent notify( #"endDirectorInitiatedWander" );
        return;
    }
    
    while ( true )
    {
        if ( isalive( agent.enemy ) )
        {
            agent notify( #"endDirectorInitiatedWander" );
            break;
        }
        
        if ( utility::cointoss() )
        {
            potentialpoints = function_ed94bdbde6961d29( wanderorigin, radius + radiusvariance, var_84b7b1bb88be3927.navzoneindex, 0 );
            randompoint = utility::array_random( potentialpoints );
            
            /#
                if ( getdvarint( @"hash_8b09a19a78df72b4", 0 ) == agent getentitynumber() )
                {
                    foreach ( point in potentialpoints )
                    {
                        if ( randompoint == point )
                        {
                            sphere( point.groundpos, 10, ( 0, 1, 0 ), 1, 200 );
                            line( agent.origin, point.groundpos, ( 0, 1, 0 ), 1, 200 );
                            print3d( point.groundpos, "<dev string:xdeb>" + agent getentitynumber(), ( 1, 1, 1 ), 1, 1, 200, 1 );
                            continue;
                        }
                        
                        sphere( point.groundpos, 10, ( 1, 0, 0 ), 1, 200 );
                    }
                }
            #/
            
            potentialpoints = undefined;
            
            if ( isdefined( randompoint ) )
            {
                var_cbf0098919b9f972 = randompoint.groundpos;
            }
            
            if ( isdefined( var_cbf0098919b9f972 ) && distance2d( agent.origin, var_cbf0098919b9f972 ) > 20 )
            {
                agent setbtgoalpos( 3, var_cbf0098919b9f972 );
                agent setbtgoalradius( 3, 8 );
                agent thread function_4d88120eb3676b81( agent );
                agent utility::waittill_any( "bt_goal", "refreshGoalPos" );
            }
        }
        
        wait randomfloatrange( 6.5, 10.5 );
    }
}

// Namespace ai_spawn_director
// Params 4, eflags: 0x4
// Checksum 0xd3fbad22, Offset: 0x7994
// Size: 0xd6
function private _setgoalpos( origin, goalradius, var_f0d2e4ade0883512, bunbounded = 0 )
{
    if ( self.fixednode || !isalive( self ) )
    {
        return;
    }
    
    if ( !var_f0d2e4ade0883512 )
    {
        function_7bbd01e514ea0578( goalradius );
    }
    
    if ( distancesquared( self.goalpos, origin ) <= 400 )
    {
        return;
    }
    
    safeorigin = self getclosestreachablepointonnavmesh( origin, bunbounded );
    
    if ( !isdefined( safeorigin ) )
    {
        println( "<dev string:xdfa>" + origin );
        return;
    }
    
    if ( !isdefined( self.origin ) )
    {
        assertmsg( "<dev string:xe39>" );
        return;
    }
    
    if ( distancesquared( self.goalpos, safeorigin ) > 400 )
    {
        self setgoalpos( safeorigin );
    }
}

// Namespace ai_spawn_director
// Params 2, eflags: 0xc
// Checksum 0x1583bfbe, Offset: 0x7a72
// Size: 0x6f
function private function_4d88120eb3676b81( agent, time )
{
    self notify( #"hash_72ed053ea8e63bac" );
    self endon( #"hash_72ed053ea8e63bac" );
    agent endon( #"bt_goal" );
    agent endon( #"death" );
    waittime = 10;
    
    if ( isdefined( time ) )
    {
        waittime = time;
    }
    
    wait waittime;
    agent notify( #"refreshGoalPos" );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x391135d7, Offset: 0x7ae9
// Size: 0x133
function private function_ccf5f24c62d8d119( goalarea, data )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( goalarea.goalnode ) )
    {
        if ( self usecovernodeifpossible( goalarea.goalnode ) )
        {
            self setgoalnode( goalarea.goalnode );
        }
        
        return;
    }
    
    if ( isdefined( goalarea.var_94f4a4f8715172ca ) )
    {
        if ( isdefined( self getgoalentity( 0 ) ) )
        {
            /#
                function_9e65ae7d8c3a96a4( "<dev string:xe71>" + self getentitynumber() + "<dev string:xe96>" );
            #/
            
            return;
        }
        
        self setgoalvolumeauto( goalarea.var_94f4a4f8715172ca );
        return;
    }
    
    if ( isdefined( goalarea.var_8f483f0d17a5aa21 ) )
    {
        _setgoalpos( goalarea.var_8f483f0d17a5aa21.origin, goalarea.var_8f483f0d17a5aa21.radius );
        
        if ( isdefined( goalarea.var_8f483f0d17a5aa21.height ) )
        {
            self.goalheight = float( goalarea.var_8f483f0d17a5aa21.height );
        }
        
        return;
    }
    
    function_5faf4f558867daa9( data );
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xbb891652, Offset: 0x7c24
// Size: 0x5e
function function_5faf4f558867daa9( data )
{
    if ( data.defaultgoalradius > 0 )
    {
        goalradius = data.defaultgoalradius;
    }
    else
    {
        goalradius = self.goalradius;
    }
    
    _setgoalpos( data.origin, goalradius );
    thread function_19c43b5b3335d9e4( data );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x1972b307, Offset: 0x7c8a
// Size: 0x32
function private function_7bbd01e514ea0578( goalradius = 128 )
{
    self.goalradius = int( goalradius );
    self.script_goalradius = goalradius;
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x9e2788bc, Offset: 0x7cc4
// Size: 0x213
function function_c14096b85ff5fcd3( path_array, var_da9370ce40573050 )
{
    if ( self.unittype != "soldier" )
    {
        return;
    }
    
    if ( !isdefined( level.aipatrolpaths[ path_array[ 0 ].id ] ) )
    {
        pathstruct = spawnstruct();
        pathstruct.current_ai = [];
        pathstruct.current_ai[ pathstruct.current_ai.size ] = self;
        pathstruct.patrolpath = path_array;
        pathstruct.var_df89931e0fd1469f = path_array[ 0 ].var_df89931e0fd1469f;
        pathstruct.var_ec2d1a0d4a6dba5b = path_array[ 0 ].var_ec2d1a0d4a6dba5b;
        level.aipatrolpaths[ path_array[ 0 ].id ] = pathstruct;
        level thread function_9986293a207514eb( path_array[ 0 ].id, pathstruct, var_da9370ce40573050 );
    }
    else if ( isdefined( level.aipatrolpaths[ path_array[ 0 ].id ] ) && level.aipatrolpaths[ path_array[ 0 ].id ].current_ai.size == 0 )
    {
        patrolpath = level.aipatrolpaths[ path_array[ 0 ].id ];
        patrolpath.current_ai[ patrolpath.current_ai.size ] = self;
        level thread function_9986293a207514eb( path_array[ 0 ].id, patrolpath, var_da9370ce40573050 );
    }
    else
    {
        patrolpath = level.aipatrolpaths[ path_array[ 0 ].id ];
        patrolpath.current_ai[ patrolpath.current_ai.size ] = self;
    }
    
    if ( !isdefined( self.patroldata ) )
    {
        patroldata = spawnstruct();
        patroldata.patrolpath = level.aipatrolpaths[ path_array[ 0 ].id ];
        patroldata.nodeindex = 0;
        self.patroldata = patroldata;
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xe5f0fb76, Offset: 0x7edf
// Size: 0x6a
function private function_ee88bbf980323b35( path_array )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"stealth_investigate" );
    self endon( #"stealth_hunt" );
    self endon( #"stealth_combat" );
    self endon( #"startCombatRush" );
    self waittill( #"bseq_user_deleted" );
    function_c14096b85ff5fcd3( path_array );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xe04502e3, Offset: 0x7f51
// Size: 0x85
function private function_ac245662cd95abf4( interactionid, var_308539918071b60d )
{
    level endon( #"game_ended" );
    self endon( interactionid + "despawned" );
    
    if ( var_308539918071b60d )
    {
        utility::waittill_any( "death", "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    }
    else
    {
        utility::waittill_any( "bseq_user_deleted", "cap_exit_completed", "death", "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    }
    
    despawninteraction( interactionid );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x447e18b0, Offset: 0x7fde
// Size: 0x3f
function private function_cf13763f454c07a6()
{
    self leaveinteraction();
    
    if ( isdefined( self.var_a1a7ca42ea0a74 ) )
    {
        despawninteraction( self.var_a1a7ca42ea0a74 );
        self notify( self.var_a1a7ca42ea0a74 + "despawned" );
        self.var_a1a7ca42ea0a74 = undefined;
    }
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x95da56cd, Offset: 0x8025
// Size: 0x959
function private function_9986293a207514eb( pathindex, pathstruct, var_b73d8ef65bab62da )
{
    level endon( #"game_ended" );
    endon_agents = [];
    patrolpath = pathstruct.patrolpath;
    pathstruct.claimed = 1;
    index = 0;
    forwarddirection = 1;
    
    while ( true )
    {
        var_2079bcd3b73e0438 = level.aipatrolpaths[ pathindex ].current_ai;
        point = patrolpath[ index ].origin;
        
        foreach ( agentindex, agent in var_2079bcd3b73e0438 )
        {
            if ( agent.var_160ae0571a728a2f )
            {
                continue;
            }
            
            if ( !isdefined( endon_agents[ agentindex ] ) )
            {
                agent endon( #"death" );
                agent endon( #"stealth_investigate" );
                agent endon( #"stealth_hunt" );
                agent endon( #"stealth_combat" );
                agent endon( #"startCombatRush" );
                agent endon( #"enemy" );
                agent endon( #"endDirectorInitiatedPatrol" );
                endon_agents[ agentindex ] = agent;
                
                if ( isdefined( agent.patroldata.nodeindex ) )
                {
                    index = agent.patroldata.nodeindex;
                    point = patrolpath[ index ].origin;
                }
                
                if ( var_b73d8ef65bab62da )
                {
                    nodeindex = 0;
                    
                    foreach ( patrolnode in patrolpath )
                    {
                        patrolnode.nodeindex = nodeindex;
                        nodeindex++;
                    }
                    
                    sortedpathnodes = utility::get_array_of_closest( agent.origin, patrolpath );
                    index = sortedpathnodes[ 0 ].nodeindex;
                    point = patrolpath[ index ].origin;
                }
                
                agent thread function_5ca7d7c375575974( pathindex );
                agent thread function_3ed8f367ebd0ce7( pathindex );
            }
            
            if ( agentindex != 0 )
            {
                random_x = randomfloatrange( 30, 31 ) * ( utility::cointoss() ? 1 : -1 );
                random_y = randomfloatrange( 30, 31 ) * ( utility::cointoss() ? 1 : -1 );
                point = ( point[ 0 ] + random_x, point[ 1 ] + random_y, point[ 2 ] );
            }
            
            if ( !agent.var_98976fabf7d4b227 && ( isdefined( patrolpath[ index ].interaction_id ) && patrolpath[ index ].interaction_id != -1 || isdefined( patrolpath[ index ].interactionname ) ) )
            {
                var_4fa34ef5b8d48def = patrolpath[ index ].var_eb5c198faf3468b7;
                var_6b3af6751e61e721 = patrolpath[ index ].patrol_max_wait_time;
                var_92a2f452172ad9a6 = patrolpath[ index ].script_delay > 0;
                var_5524cb8687dcae79 = patrolpath[ index ].script_delay_min == patrolpath[ index ].script_delay_max;
                
                if ( var_5524cb8687dcae79 && !var_92a2f452172ad9a6 )
                {
                    patrolpath[ index ].script_delay = patrolpath[ index ].script_delay_min;
                    patrolpath[ index ].script_delay_min = undefined;
                    patrolpath[ index ].script_delay_max = undefined;
                    var_92a2f452172ad9a6 = patrolpath[ index ].script_delay > 0;
                }
                
                if ( !var_92a2f452172ad9a6 )
                {
                    if ( isdefined( var_4fa34ef5b8d48def ) && isdefined( var_6b3af6751e61e721 ) && var_4fa34ef5b8d48def > 0 && var_6b3af6751e61e721 > 0 )
                    {
                        if ( var_6b3af6751e61e721 != var_4fa34ef5b8d48def )
                        {
                            patrolpath[ index ].script_delay_min = var_4fa34ef5b8d48def;
                            patrolpath[ index ].script_delay_max = var_6b3af6751e61e721;
                        }
                        else
                        {
                            patrolpath[ index ].script_delay = var_4fa34ef5b8d48def;
                            var_92a2f452172ad9a6 = 1;
                        }
                        
                        patrolpath[ index ].var_eb5c198faf3468b7 = 0;
                        patrolpath[ index ].patrol_max_wait_time = 0;
                    }
                }
                
                if ( var_92a2f452172ad9a6 )
                {
                    patrolpath[ index ].script_delay_min = undefined;
                    patrolpath[ index ].script_delay_max = undefined;
                }
                
                agent._blackboard.idlenode = patrolpath[ index ];
                agent function_cf13763f454c07a6();
                
                if ( isdefined( patrolpath[ index ].interaction_id ) && patrolpath[ index ].interaction_id != -1 )
                {
                    agent setbtgoalpos( 3, getinteractionorigin( patrolpath[ index ].interaction_id ) );
                    agent setbtgoalradius( 3, 64 );
                    agent function_a47253874da73280( getinteractionorigin( patrolpath[ index ].interaction_id ) );
                    agent function_ad85ecc3923456f4( 64 );
                    agent function_895b16b8fcd857ba( patrolpath[ index ].interaction_id );
                    agent waittill( #"cap_reach_and_arrive" );
                    agent.var_255993e0c37895bb = 1;
                }
                else
                {
                    var_a1a7ca42ea0a74 = spawninteraction( patrolpath[ index ].interactionname, patrolpath[ index ].interactionorigin, patrolpath[ index ].interactionangles );
                    
                    if ( isdefined( var_a1a7ca42ea0a74 ) )
                    {
                        agent setbtgoalpos( 3, getinteractionorigin( var_a1a7ca42ea0a74 ) );
                        agent setbtgoalradius( 3, 64 );
                        agent function_a47253874da73280( getinteractionorigin( var_a1a7ca42ea0a74 ) );
                        agent function_ad85ecc3923456f4( 64 );
                        agent.var_a1a7ca42ea0a74 = var_a1a7ca42ea0a74;
                        agent function_895b16b8fcd857ba( var_a1a7ca42ea0a74 );
                        agent thread function_ac245662cd95abf4( var_a1a7ca42ea0a74, 1 );
                        agent waittill( #"cap_reach_and_arrive" );
                        agent.var_255993e0c37895bb = 1;
                    }
                    else
                    {
                        assertmsg( "<dev string:x171>" + patrolpath[ index ].interactionorigin + "<dev string:x1a0>" );
                    }
                }
                
                if ( isdefined( patrolpath[ index ].repeat_interaction ) && int( patrolpath[ index ].repeat_interaction ) )
                {
                    agent.var_160ae0571a728a2f = 1;
                }
            }
            else
            {
                agent function_cf13763f454c07a6();
                point = getclosestpointonnavmesh( point, agent ) ?? point;
                agent setbtgoalpos( 3, point );
                agent setbtgoalradius( 3, 64 );
            }
            
            if ( patrolpath[ index ].var_df8f7b8318d59fe5 )
            {
                agent.customarrivalangles = patrolpath[ index ].angles;
            }
            
            if ( var_2079bcd3b73e0438.size > 1 && agentindex == 0 )
            {
                wait 3;
            }
            
            if ( var_2079bcd3b73e0438.size > 1 && agentindex != 0 )
            {
                wait randomfloatrange( 1.5, 2.5 );
            }
        }
        
        shouldcontinue = 0;
        
        foreach ( agentindex, agent in var_2079bcd3b73e0438 )
        {
            if ( !agent.var_160ae0571a728a2f )
            {
                shouldcontinue = 1;
                break;
            }
        }
        
        if ( !shouldcontinue )
        {
            break;
        }
        
        waitframe();
        
        if ( !var_2079bcd3b73e0438[ 0 ].var_255993e0c37895bb )
        {
            var_2079bcd3b73e0438[ 0 ] utility::waittill_any( "goal", "bt_goal" );
        }
        else
        {
            var_2079bcd3b73e0438[ 0 ].var_255993e0c37895bb = 0;
        }
        
        if ( isdefined( var_2079bcd3b73e0438[ 0 ] getinteractionid() ) )
        {
            var_2079bcd3b73e0438[ 0 ] waittill( #"bseq_user_deleted" );
        }
        
        if ( patrolpath[ index ].var_eb5c198faf3468b7 < patrolpath[ index ].patrol_max_wait_time )
        {
            wait randomfloatrange( patrolpath[ index ].var_eb5c198faf3468b7, patrolpath[ index ].patrol_max_wait_time );
        }
        else
        {
            wait patrolpath[ index ].var_eb5c198faf3468b7;
        }
        
        if ( forwarddirection )
        {
            index++;
        }
        else
        {
            index--;
        }
        
        foreach ( agent in var_2079bcd3b73e0438 )
        {
            agent.customarrivalangles = undefined;
        }
        
        if ( !isdefined( patrolpath[ index ] ) )
        {
            if ( !pathstruct.var_df89931e0fd1469f && !pathstruct.var_ec2d1a0d4a6dba5b )
            {
                break;
            }
            else if ( pathstruct.var_ec2d1a0d4a6dba5b )
            {
                index = 0;
            }
            else if ( forwarddirection )
            {
                index = int( max( patrolpath.size - 2, 0 ) );
                forwarddirection = 0;
            }
            else
            {
                index = int( min( 1, patrolpath.size - 1 ) );
                forwarddirection = 1;
            }
        }
        
        var_2079bcd3b73e0438[ 0 ].patroldata.nodeindex = index;
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x4fcd7b3b, Offset: 0x8986
// Size: 0x70
function private function_3ed8f367ebd0ce7( pathindex )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::waittill_any( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush", "enemy", "endDirectorInitiatedPatrol" );
    self.customarrivalangles = undefined;
    self clearbtgoal( 3 );
    self function_ea023e456339d630();
    self function_dfd37f9b04e9d5a4();
    function_470a654d831db64d( pathindex );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x74f391e8, Offset: 0x89fe
// Size: 0x53
function private function_26dbb208db84916f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::waittill_any( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush", "enemy", "endDirectorInitiatedPatrol" );
    self function_ea023e456339d630();
    self function_dfd37f9b04e9d5a4();
    self clearbtgoal( 3 );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x9bcef4b2, Offset: 0x8a59
// Size: 0x47
function private function_896169b92e7bb14e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::waittill_any( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush", "enemy", "endDirectorInitiatedWander" );
    self clearbtgoal( 3 );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xb8253530, Offset: 0x8aa8
// Size: 0x22
function private function_5ca7d7c375575974( pathindex )
{
    self waittill( #"death" );
    function_470a654d831db64d( pathindex );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x71cd9008, Offset: 0x8ad2
// Size: 0xf9
function private function_470a654d831db64d( pathindex )
{
    foreach ( agentindex, agent in level.aipatrolpaths[ pathindex ].current_ai )
    {
        if ( agent == self )
        {
            level.aipatrolpaths[ pathindex ].current_ai[ agentindex ] = undefined;
            break;
        }
    }
    
    if ( level.aipatrolpaths[ pathindex ].claimed && level.aipatrolpaths[ pathindex ].current_ai.size == 0 )
    {
        level.aipatrolpaths[ pathindex ].claimed = 0;
    }
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xa903e4f4, Offset: 0x8bd3
// Size: 0x102
function private function_4638391dde5218f1( requestid, var_c60a13eba6baced )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( var_c60a13eba6baced )
    {
        if ( self.unittype == "zombie" )
        {
            _zombiekill( 1 );
            return;
        }
        
        function_93e0e37fcbd3aec3( 1 );
        return;
    }
    
    if ( isdefined( level.var_400b44c398b1e1d7[ requestid ] ) )
    {
        self [[ level.var_400b44c398b1e1d7[ requestid ].fncallback ]]( level.var_400b44c398b1e1d7[ requestid ].fallback_goal, level.var_400b44c398b1e1d7[ requestid ].check_sight, level.var_400b44c398b1e1d7[ requestid ].var_adc97ec15b3ff2e8, level.var_400b44c398b1e1d7[ requestid ].early_despawn );
        return;
    }
    
    if ( self.unittype == "zombie" )
    {
        function_79b337fe2944db3d();
        return;
    }
    
    function_8f1edb40e27acf17();
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x805f9f6b, Offset: 0x8cdd
// Size: 0x2f1
function private function_8f1edb40e27acf17()
{
    self endon( #"death" );
    assert( self.unittype != "<dev string:xed1>" );
    requestid = self.directorrequestid;
    callbackstruct = _lookup_callback( "DirectorKilledAI", requestid );
    
    if ( isdefined( callbackstruct ) )
    {
        foreach ( entry in callbackstruct )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
    }
    
    callbackstruct = function_2519019863f6b43f( "DirectorKilledAI", requestid, self.directorspawndata.spawnsetname );
    
    if ( isdefined( callbackstruct ) )
    {
        foreach ( entry in callbackstruct )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
    }
    
    while ( !function_889d56bd1e8182a5( self ) )
    {
        var_fb82ea42f3461323 = 0;
        
        while ( isalive( self.enemy ) && isplayer( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) <= 262144 )
        {
            var_fb82ea42f3461323 = 1;
            self.pathenemyfightdist = 0;
            self.pathenemylookahead = 0;
            self.var_b35099cc0a791f1b = 0;
            self setbtgoalradius( 4, 256 );
            self setbtgoalpos( 4, self.enemy.origin );
            wait 5;
        }
        
        if ( var_fb82ea42f3461323 )
        {
            continue;
        }
        
        wait randomfloatrange( 1, 3 );
        despawnpos = function_27714d830591cc56( self );
        starttime = gettime();
        
        if ( isdefined( despawnpos ) )
        {
            despawnpos = getrandomnavpoint( despawnpos, 256, self, 1, 0 );
            
            if ( isdefined( despawnpos ) )
            {
                self setbtgoalpos( 4, despawnpos );
                self setbtgoalradius( 4, 256 );
                utility::waittill_any( "bt_goal", "bad_path" );
            }
        }
        
        waittime = getdvarfloat( @"hash_273a7f3e61e64e35", 10 );
        timediffseconds = ( gettime() - starttime ) / 1000;
        
        if ( timediffseconds < waittime )
        {
            wait waittime - timediffseconds;
        }
    }
    
    function_93e0e37fcbd3aec3( 1 );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xe757c882, Offset: 0x8fd6
// Size: 0x46
function private function_dbc65edf550b9482()
{
    self endon( #"death" );
    despawntime = randomfloatrange( getdvarint( @"hash_96955f67517b7611", 5 ), getdvarint( @"hash_96b8716751a1e55f", 10 ) );
    wait despawntime;
    function_a0ce0fd087a726d0();
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x7c31faf, Offset: 0x9024
// Size: 0x41
function private function_a0ce0fd087a726d0( should_kill_immediately )
{
    self endon( #"death" );
    
    if ( self.unittype == "zombie" )
    {
        _zombiekill( 0, should_kill_immediately );
        return;
    }
    
    function_93e0e37fcbd3aec3( 0, should_kill_immediately );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x21399afd, Offset: 0x906d
// Size: 0x24, Type: bool
function private function_a55dd61eeb0cb029()
{
    despawncount = function_5155c13b6c6d6950();
    return despawncount < getdvarint( @"hash_54dc66a37e679beb", 5 );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x30a07b1f, Offset: 0x909a
// Size: 0xb4
function private function_93e0e37fcbd3aec3( var_30b4822d70c44a1, should_kill_immediately )
{
    self endon( #"death" );
    assert( self.unittype != "<dev string:xed1>" );
    
    if ( !should_kill_immediately )
    {
        while ( !function_a55dd61eeb0cb029() )
        {
            waitframe();
        }
    }
    
    self.death_source = "despawn";
    self.nocorpse = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.dropweapon = 0;
    self.nodrop = 1;
    
    if ( self.magic_bullet_shield )
    {
        ai::stop_magic_bullet_shield();
    }
    
    if ( isdefined( level.var_322ef03826a64697 ) )
    {
        self [[ level.var_322ef03826a64697 ]]( var_30b4822d70c44a1 );
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xb593ed9b, Offset: 0x9156
// Size: 0xac
function private function_24d3a519a7c2bbe4( encounterradius )
{
    self endon( #"death" );
    spawnpoint = self.origin;
    maxdistance = encounterradius * getdvarfloat( @"hash_a99b215bdc4d8f7d", 5 );
    maxdistancesqr = maxdistance * maxdistance;
    
    while ( true )
    {
        wait randomfloatrange( 5, 7 );
        
        if ( distancesquared( self.origin, spawnpoint ) > maxdistancesqr )
        {
            /#
                function_9e65ae7d8c3a96a4( "<dev string:xed8>" + self getentitynumber() + "<dev string:xeeb>" + self.directorrequestid );
            #/
            
            function_79b337fe2944db3d();
        }
    }
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x17ca22c7, Offset: 0x920a
// Size: 0x1d3
function private function_79b337fe2944db3d()
{
    self endon( #"death" );
    requestid = self.directorrequestid;
    callbacks = _lookup_callback( "DirectorKilledAI", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
    }
    
    callbacks = function_2519019863f6b43f( "DirectorKilledAI", requestid, self.directorspawndata.spawnsetname );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata );
        }
    }
    
    if ( getplayerinfluenceatposition( self.origin ) > function_8fdd82733eebd05f() )
    {
        if ( self._blackboard.var_903cd88c07cfc16b )
        {
            return;
        }
        
        self notify( #"despawn" );
        
        if ( self asmhasstate( self.asmname, "despawn_in" ) )
        {
            self.nocorpse = 1;
            asm::asm_setstate( "despawn_in" );
            return;
        }
    }
    
    _zombiekill( 1 );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xb89d1215, Offset: 0x93e5
// Size: 0x1ce
function private _zombiekill( var_30b4822d70c44a1, should_kill_immediately )
{
    self endon( #"death" );
    
    if ( !should_kill_immediately )
    {
        while ( !function_a55dd61eeb0cb029() )
        {
            waitframe();
        }
    }
    
    if ( !var_30b4822d70c44a1 )
    {
        requestid = self.directorrequestid;
        callbacks = _lookup_callback( "DirectorKilledAI", requestid );
        
        if ( isdefined( callbacks ) )
        {
            foreach ( entry in callbacks )
            {
                thread [[ entry.fncallback ]]( requestid, entry.userdata );
            }
        }
        
        callbacks = function_2519019863f6b43f( "DirectorKilledAI", requestid, self.directorspawndata.spawnsetname );
        
        if ( isdefined( callbacks ) )
        {
            foreach ( entry in callbacks )
            {
                thread [[ entry.fncallback ]]( requestid, entry.userdata );
            }
        }
    }
    
    if ( self.magic_bullet_shield )
    {
        ai::stop_magic_bullet_shield();
    }
    
    self.nocorpse = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.death_source = "despawn";
    self kill();
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xaad70364, Offset: 0x95bb
// Size: 0x1cb
function private function_431a955cdf4541d6( requestid, unload_pos )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    thread function_a5d93847b714f21d();
    
    foreach ( rider in self.riders )
    {
        rider thread function_d01c01d2ae601d33( requestid, unload_pos );
    }
    
    result = utility::waittill_any_return( "reached_end_node", "vehicleStuckNavSpline", "ai_encounter_driver_death" );
    self notify( #"hash_bd0a7f8a332ba449" );
    
    /#
        if ( result == "<dev string:xf0c>" )
        {
            function_9e65ae7d8c3a96a4( "<dev string:xf22>" + self.origin );
        }
    #/
    
    self vehphys_parkingbrake( 1 );
    self setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( 0 ) );
    self setconfigvalue( "p2p", "pause", 1 );
    self vehicle_cleardrivingstate();
    vehicle_code::_vehicle_unload( "default" );
    
    if ( vehicle_aianim::riders_unloadable( "default" ) )
    {
        self waittill( #"unloaded" );
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self removecomponent( "p2p" );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self removecomponent( "path" );
    }
    
    self vehphys_parkingbrake( 0 );
    
    if ( isdefined( level.var_cdd64fc68a01b0 ) )
    {
        self [[ level.var_cdd64fc68a01b0 ]]();
    }
    
    vehicle_occupancy::set_team( self, "neutral" );
    vehicle_interact::allow_use( self, 1 );
    function_2479114e5ee014dc( requestid );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xdd5a2a4f, Offset: 0x978e
// Size: 0x52
function private function_8e5fd6ee7c16e173( requestid )
{
    level endon( #"game_ended" );
    entnum = self getentitynumber();
    self waittill( #"death", attacker, meansofdeath );
    function_472153ca8ab6ac91( requestid, entnum );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0xa9670ed8, Offset: 0x97e8
// Size: 0x3d
function private function_9b4d7efab3d65703( requestid )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"vehicle_owner_update" );
    function_472153ca8ab6ac91( requestid, self getentitynumber() );
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0xbc9c193a, Offset: 0x982d
// Size: 0x6d
function private function_a5d93847b714f21d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"hash_bd0a7f8a332ba449" );
    
    if ( !vehicle::is_ground_vehicle() || !isdefined( self.aidriver ) )
    {
        return;
    }
    
    self.aidriver waittill( #"death" );
    self notify( #"ai_encounter_driver_death" );
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0xdf847e78, Offset: 0x98a2
// Size: 0xcc
function private function_d01c01d2ae601d33( requestid, unload_pos )
{
    self endon( #"death" );
    self waittill( #"unload" );
    
    while ( self islinked() )
    {
        waitframe();
    }
    
    wait 1;
    
    if ( !isdefined( self.directorspawndata ) )
    {
        return;
    }
    
    var_7ed4900ca15f95c1 = spawnstruct();
    var_7ed4900ca15f95c1.radius = 512;
    
    if ( !isdefined( unload_pos ) )
    {
        var_7ed4900ca15f95c1.origin = self.origin;
    }
    else
    {
        var_7ed4900ca15f95c1.origin = unload_pos;
    }
    
    self.directorspawndata.var_7ed4900ca15f95c1 = var_7ed4900ca15f95c1;
    function_87d2160f1f99c092( requestid );
    thread _precombat( self.directorspawndata );
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x82e76573, Offset: 0x9976
// Size: 0xb8
function private function_ca86f435d0cfe26d( vehiclenodeindex )
{
    result = undefined;
    vehiclenodestart = getvehiclenode( vehiclenodeindex );
    
    if ( isdefined( vehiclenodestart ) )
    {
        pathnodes = [];
        pathnodes[ pathnodes.size ] = vehiclenodestart;
        
        while ( true )
        {
            currentnode = pathnodes[ pathnodes.size - 1 ];
            
            if ( !isdefined( currentnode.target ) )
            {
                break;
            }
            
            nextnode = getvehiclenode( currentnode.target, #targetname );
            
            if ( !isdefined( nextnode ) || arraycontains( pathnodes, nextnode ) )
            {
                break;
            }
            
            pathnodes[ pathnodes.size ] = nextnode;
        }
        
        result = pathnodes[ pathnodes.size - 1 ];
    }
    
    return result;
}

// Namespace ai_spawn_director
// Params 4
// Checksum 0xac6214d1, Offset: 0x9a37
// Size: 0x338
function function_9419b995f7b80fe3( spawnedvehicle, goalpoint, pathindex, vehspeed )
{
    if ( !spawnedvehicle hascomponent( "p2p" ) )
    {
        spawnedvehicle addcomponent( "p2p" );
    }
    
    if ( !spawnedvehicle hascomponent( "path" ) )
    {
        spawnedvehicle addcomponent( "path" );
    }
    
    if ( !spawnedvehicle hascomponent( "animator" ) )
    {
        spawnedvehicle addcomponent( "animator" );
    }
    
    spawnedvehicle setconfigvalue( "p2p", "checkStuck", 0 );
    spawnedvehicle setconfigvalue( "p2p", "brakeAtGoal", 1 );
    spawnedvehicle setconfigvalue( "p2p", "automaticNormal", 1 );
    spawnedvehicle setconfigvalue( "p2p", "brakeOnGoalGasbrake", 1 );
    spawnedvehicle setconfigvalue( "p2p", "goalPoint", goalpoint );
    spawnedvehicle setconfigvalue( "p2p", "goalThreshold", 300 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedClose", 1 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedThreshold", 1 );
    spawnedvehicle setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedFarBelow", 1 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedFarAbove", 4 );
    spawnedvehicle setconfigvalue( "p2p", "throttleSpeedClose", 2 );
    spawnedvehicle setconfigvalue( "p2p", "gasToStopMovement", 0.9 );
    spawnedvehicle setconfigvalue( "p2p", "steeringMultiplier", 2 );
    spawnedvehicle setconfigvalue( "path", "radiusToStep", 300 );
    spawnedvehicle setconfigvalue( "p2p", "manualSpeed", vehspeed );
    var_de3fc68d66d7c880 = 0;
    
    if ( getdvarint( @"hash_46c9c4287e87fcfd", 0 ) )
    {
        goalvehiclenode = function_ca86f435d0cfe26d( pathindex );
        
        if ( isdefined( goalvehiclenode ) )
        {
            /#
                adddebugcommand( "<dev string:xf5a>" );
                adddebugcommand( "<dev string:xf7b>" );
            #/
            
            spawnedvehicle vehicle_code::vehicle_disable_navobstacles();
            startlocation = spawnedvehicle.origin;
            goallocation = goalvehiclenode.origin;
            vehicleforward = anglestoforward( spawnedvehicle.angles );
            var_9ed6c85de846a97c = isnavmeshloaded( "vehicle_large" );
            var_7f0e92a7d2b854b2 = isnavmeshloaded( "zombie_large" );
            navmeshlayer = var_9ed6c85de846a97c ? "vehicle_large" : var_7f0e92a7d2b854b2 ? "zombie_large" : undefined;
            splinepoints = spawnedvehicle findsplinepath( startlocation, goallocation, 50, 200, 100, vehicleforward, ( 0, 0, 0 ), 300, 0.4, 0, 1, navmeshlayer, 0, 1 );
            
            if ( splinepoints.size > 0 )
            {
                var_de3fc68d66d7c880 = 1;
                spawnedvehicle thread vehicle_roads::watch_interrupt();
            }
            
            /#
                spawnedvehicle thread vehicle_roads::function_2b723e6a5a86a006( splinepoints, isdefined( navmeshlayer ) ? ( 1, 1, 1 ) : ( 1, 0, 0 ) );
                spawnedvehicle thread vehicle_roads::function_8437fc8203abb755( navmeshlayer );
            #/
        }
    }
    
    if ( !var_de3fc68d66d7c880 )
    {
        spawnedvehicle setconfigvalue( "path", "radiantId", pathindex );
    }
    
    spawnedvehicle thread vehicle_roads::watch_stuck();
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x62264bad, Offset: 0x9d77
// Size: 0x142
function private function_6bae540331f2ea1b( requestid, data )
{
    if ( isdefined( level.var_ac4d968ccb10fa96[ requestid ] ) )
    {
        foreach ( vehicleinfostruct in level.var_ac4d968ccb10fa96[ requestid ] )
        {
            assert( isdefined( vehicleinfostruct.infil_type ) );
            
            if ( vehicleinfostruct.infil_type == 1 )
            {
                if ( isdefined( level.var_d965725bfca1652e ) )
                {
                    level thread [[ level.var_d965725bfca1652e ]]( requestid, data.aifaction, vehicleinfostruct );
                }
                
                continue;
            }
            
            if ( vehicleinfostruct.infil_type == 3 )
            {
                if ( isdefined( level.var_c95e61c4fc8e049 ) )
                {
                    level thread [[ level.var_c95e61c4fc8e049 ]]( requestid, data.aifaction, vehicleinfostruct );
                }
                
                continue;
            }
            
            assertmsg( "<dev string:xfa3>" + requestid );
        }
        
        level.var_ac4d968ccb10fa96[ requestid ] = undefined;
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x25d55012, Offset: 0x9ec1
// Size: 0x1e1
function function_abadd6786f1c47f1( riders )
{
    assert( isdefined( riders ) && riders.size > 0, "<dev string:xfc5>" + self.vehiclename );
    var_167ae93f6826125 = [];
    usedpositions = [];
    
    foreach ( rider in riders )
    {
        if ( isdefined( rider.var_e7dd375985ff5ff2 ) && rider.var_e7dd375985ff5ff2 != -1 )
        {
            if ( !usedpositions[ rider.var_e7dd375985ff5ff2 ] )
            {
                rider.script_startingposition = rider.var_e7dd375985ff5ff2;
                usedpositions[ rider.var_e7dd375985ff5ff2 ] = 1;
            }
            else
            {
                assertmsg( "<dev string:xfe3>" + rider.var_e7dd375985ff5ff2 );
            }
            
            continue;
        }
        
        var_167ae93f6826125[ var_167ae93f6826125.size ] = rider;
    }
    
    availableseats = vehicle_aianim::get_availablepositions();
    seatsindex = 0;
    
    foreach ( rider in var_167ae93f6826125 )
    {
        seatnumber = availableseats.availablepositions[ seatsindex ].vehicle_position;
        rider.script_startingposition = seatnumber;
        usedpositions[ seatnumber ] = 1;
        seatsindex++;
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0x48107575, Offset: 0xa0aa
// Size: 0xae
function function_87d2160f1f99c092( requestid )
{
    callbacks = _lookup_callback( "OnUnloaded", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata, self );
        }
    }
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xb4562719, Offset: 0xa160
// Size: 0x158
function function_cd73d5a41d9796c6( requestid )
{
    self function_6bb4fe624d472bf3( 0 );
    callbacks = _lookup_callback( "OnParachuteLanded", requestid );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata, self );
        }
    }
    
    callbacks = function_2519019863f6b43f( "OnParachuteLanded", requestid, self.directorspawndata.spawnsetname );
    
    if ( isdefined( callbacks ) )
    {
        foreach ( entry in callbacks )
        {
            thread [[ entry.fncallback ]]( requestid, entry.userdata, self );
        }
    }
}

// Namespace ai_spawn_director
// Params 0
// Checksum 0x3c904740, Offset: 0xa2c0
// Size: 0x8e
function function_83b64ff1bf82fa89()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( self.directorrequestid ) )
    {
        return;
    }
    
    utility::waittill_any( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    
    if ( !isdefined( self.directorrequestid ) )
    {
        return;
    }
    
    requestdata = function_9b649316adcccbaa( self.directorrequestid );
    
    if ( isdefined( requestdata ) )
    {
        self setgoalpos( requestdata.origin, requestdata.radius );
    }
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x769ae8f8, Offset: 0xa356
// Size: 0x2
function private function_347eaa94397a9de2()
{
    
}

// Namespace ai_spawn_director
// Params 0, eflags: 0x4
// Checksum 0x7429f632, Offset: 0xa360
// Size: 0x54
function private function_fb69eb0fc214329c()
{
    if ( getdvarint( @"hash_c69456bc853363e0" ) == 1 && !isdefined( level.var_5aededa530361e29 ) )
    {
        level.var_5aededa530361e29 = &function_ef9772724ac44a;
        level.var_da105458e50be04c = &function_7cb49117e7296b09;
        level.var_491e5b648aae5fd3 = [];
        level.var_2c5b3e4463355df7 = [];
    }
}

// Namespace ai_spawn_director
// Params 7
// Checksum 0x8d6f987c, Offset: 0xa3bc
// Size: 0xaf
function function_e19f6a00c4bb7490( name, lightweightenabled, autoenable, autodelete, forcespawn, prioritylevel, var_751d8c6cb70eb6d7 = 0 )
{
    assert( isdefined( level.var_2c5b3e4463355df7 ), "<dev string:x102c>" );
    
    if ( !isdefined( prioritylevel ) )
    {
        prioritylevel = 2;
    }
    
    groupid = function_7c4eb2a03864d853( lightweightenabled, autoenable, name, autodelete, forcespawn, prioritylevel, var_751d8c6cb70eb6d7 );
    level.var_491e5b648aae5fd3[ groupid ] = spawnstruct();
    level.var_491e5b648aae5fd3[ groupid ].callbacks = [];
    return groupid;
}

// Namespace ai_spawn_director
// Params 1
// Checksum 0xfda3ec8a, Offset: 0xa474
// Size: 0x3a
function function_d15a5427eec4ebe3( groupid )
{
    assert( isdefined( level.var_2c5b3e4463355df7 ), "<dev string:x102c>" );
    
    if ( isdefined( level.var_491e5b648aae5fd3[ groupid ] ) )
    {
        function_6838782d653fa210( groupid );
    }
}

// Namespace ai_spawn_director
// Params 1, eflags: 0x4
// Checksum 0x1feed778, Offset: 0xa4b6
// Size: 0x52
function private function_fac1e28aebfc2f67( groupid )
{
    callbackstruct = function_49853dfb2028f1d3( "Shutdown", groupid );
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( groupid, callbackstruct.userdata );
    }
    
    level.var_491e5b648aae5fd3[ groupid ] = undefined;
}

// Namespace ai_spawn_director
// Params 13
// Checksum 0xf7bfc736, Offset: 0xa510
// Size: 0x18b
function function_9893a28f1d682a28( groupid, aitype, origin, angles, forcespawn, perfectenemyinfo, var_ecd8f11a6767ddcc, team, characterlistname, gender, var_25afe155bb5b33b6, var_cae8263562118c46, priority )
{
    assert( isdefined( level.var_491e5b648aae5fd3[ groupid ] ), "<dev string:x104c>" );
    
    if ( !isdefined( priority ) )
    {
        priority = 2;
    }
    
    var_6d63bc1fea0a37c2 = function_ad4355adb3e707c5( groupid, origin, angles, aitype, priority );
    assert( !isdefined( level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] ) );
    level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] = spawnstruct();
    datastruct = level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ];
    datastruct.groupid = groupid;
    datastruct.aitype = aitype;
    datastruct.forcespawn = forcespawn;
    datastruct.perfectenemyinfo = perfectenemyinfo;
    datastruct.var_ecd8f11a6767ddcc = var_ecd8f11a6767ddcc;
    datastruct.team = team;
    datastruct.characterlistname = characterlistname;
    datastruct.gender = gender;
    datastruct.var_4f627fa582a17e0f = var_25afe155bb5b33b6;
    datastruct.var_cae8263562118c46 = var_cae8263562118c46;
    datastruct.priority = priority;
    return var_6d63bc1fea0a37c2;
}

// Namespace ai_spawn_director
// Params 3
// Checksum 0xdb649368, Offset: 0xa6a4
// Size: 0x104
function function_11f24fcbdedc053e( var_eaf7e4b2ef297e4a, groupid, priority )
{
    assert( isdefined( level.var_491e5b648aae5fd3[ groupid ] ), "<dev string:x104c>" );
    
    if ( !isarray( var_eaf7e4b2ef297e4a ) )
    {
        var_eaf7e4b2ef297e4a = [ var_eaf7e4b2ef297e4a ];
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 2;
    }
    
    foreach ( ai in var_eaf7e4b2ef297e4a )
    {
        assert( isai( ai ) );
        assert( !isdefined( ai.directorrequestid ), "<dev string:x1096>" );
        function_b44bc58cb5fea251( ai, groupid, priority );
        assert( ai.directorrequestid == groupid );
    }
}

// Namespace ai_spawn_director
// Params 6, eflags: 0x4
// Checksum 0xe0d35952, Offset: 0xa7b0
// Size: 0x30c
function private function_ef9772724ac44a( charactertype, origin, angles, var_6d63bc1fea0a37c2, var_8735f083fb8a8924, isdemotion )
{
    if ( isdemotion )
    {
        var_48024e39c61f60d3 = function_1af167929351b62a( var_6d63bc1fea0a37c2 );
        
        if ( isdefined( var_48024e39c61f60d3 ) )
        {
            function_7cb49117e7296b09( var_48024e39c61f60d3, var_6d63bc1fea0a37c2, 0 );
        }
    }
    
    assert( isdefined( level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] ), "<dev string:x10c5>" );
    datastruct = level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ];
    
    if ( var_8735f083fb8a8924 )
    {
        aitypename = removesubstr( datastruct.aitype, "actor_" );
        lwagentid = function_8234856093b76105( aitypename, datastruct.team );
        
        if ( isdefined( lwagentid ) )
        {
            function_87f5ba010fc2e55b( lwagentid, origin );
        }
        else
        {
            level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] = undefined;
        }
        
        return lwagentid;
    }
    
    level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] = undefined;
    datastruct.forcespawn = datastruct.forcespawn ?? 1;
    datastruct.perfectenemyinfo = datastruct.perfectenemyinfo ?? 0;
    datastruct.var_ecd8f11a6767ddcc = datastruct.var_ecd8f11a6767ddcc ?? 1;
    datastruct.priority = datastruct.priority ?? 3;
    
    if ( !issubstr( datastruct.aitype, "actor_" ) )
    {
        aitypename = "actor_" + datastruct.aitype;
    }
    else
    {
        aitypename = datastruct.aitype;
    }
    
    agent = dospawnaitype( aitypename, origin, angles, datastruct.forcespawn, datastruct.perfectenemyinfo, datastruct.var_ecd8f11a6767ddcc, 0, datastruct.team, datastruct.characterlistname, datastruct.gender, datastruct.var_4f627fa582a17e0f, datastruct.var_cae8263562118c46 );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.priority = datastruct.priority;
    agent.gender = datastruct.gender;
    agent.var_4f627fa582a17e0f = datastruct.var_4f627fa582a17e0f;
    agent.forcespawn = datastruct.forcespawn;
    agent.perfectenemyinfo = datastruct.perfectenemyinfo;
    agent.var_ecd8f11a6767ddcc = datastruct.var_ecd8f11a6767ddcc;
    
    if ( isdefined( level.var_d42c6a76441fa1aa ) )
    {
        agent [[ level.var_d42c6a76441fa1aa ]]();
    }
    
    callbackstruct = function_49853dfb2028f1d3( "OnSpawned", datastruct.groupid );
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( datastruct.groupid, callbackstruct.userdata, agent, var_6d63bc1fea0a37c2 );
    }
    
    return agent;
}

// Namespace ai_spawn_director
// Params 3, eflags: 0x4
// Checksum 0x2c48d5f6, Offset: 0xaac5
// Size: 0x168
function private function_7cb49117e7296b09( ent, var_6d63bc1fea0a37c2, var_c2d1b1f57897b6ae )
{
    if ( var_c2d1b1f57897b6ae )
    {
        assert( isdefined( level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] ), "<dev string:x10c5>" );
        return;
    }
    
    assert( !isdefined( level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] ) );
    level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ] = spawnstruct();
    datastruct = level.var_2c5b3e4463355df7[ var_6d63bc1fea0a37c2 ];
    datastruct.aitype = ent.classname;
    datastruct.priority = ent.priority;
    datastruct.team = ent.team;
    datastruct.characterlistname = ent.characterlistname;
    datastruct.gender = ent.gender;
    datastruct.var_4f627fa582a17e0f = ent.var_4f627fa582a17e0f;
    datastruct.forcespawn = ent.forcespawn;
    datastruct.perfectenemyinfo = ent.perfectenemyinfo;
    datastruct.var_ecd8f11a6767ddcc = ent.var_ecd8f11a6767ddcc;
    
    if ( isdefined( level.var_a611f05444297343 ) )
    {
        self [[ level.var_a611f05444297343 ]]( ent );
    }
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x4817ba00, Offset: 0xac35
// Size: 0x51
function private function_ec740f4e03e8d89b( groupid, var_b06d38cf76935416 )
{
    callbackstruct = function_49853dfb2028f1d3( "FinishedSpawningGroup", groupid );
    
    if ( isdefined( callbackstruct ) )
    {
        thread [[ callbackstruct.fncallback ]]( groupid, callbackstruct.userdata, var_b06d38cf76935416 );
    }
}

// Namespace ai_spawn_director
// Params 4
// Checksum 0x59d6a8b1, Offset: 0xac8e
// Size: 0xac
function function_35aa3b1d92cd8207( callbackname, groupid, fncallback, userdata )
{
    assert( isdefined( level.var_491e5b648aae5fd3[ groupid ] ), "<dev string:x104c>" );
    
    if ( isdefined( fncallback ) )
    {
        level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ] = spawnstruct();
        level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ].fncallback = fncallback;
        level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ].userdata = userdata;
    }
}

// Namespace ai_spawn_director
// Params 2
// Checksum 0x38dcc737, Offset: 0xad42
// Size: 0x49
function function_c9330a7e3d1eaef2( callbackname, groupid )
{
    if ( isdefined( level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ] ) )
    {
        level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ] = undefined;
    }
}

// Namespace ai_spawn_director
// Params 2, eflags: 0x4
// Checksum 0x64cab3ff, Offset: 0xad93
// Size: 0x5a
function private function_49853dfb2028f1d3( callbackname, groupid )
{
    if ( isdefined( level.var_491e5b648aae5fd3[ groupid ] ) && isdefined( level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ] ) )
    {
        return level.var_491e5b648aae5fd3[ groupid ].callbacks[ callbackname ];
    }
}

/#

    // Namespace ai_spawn_director
    // Params 1, eflags: 0x4
    // Checksum 0x7f965b02, Offset: 0xadf6
    // Size: 0x5f, Type: dev
    function private function_9e65ae7d8c3a96a4( text )
    {
        shouldlog = getdvarint( @"ai_spawn_director_log", 0 );
        
        if ( isstring( shouldlog ) && shouldlog == "<dev string:x113c>" || !isstring( shouldlog ) && shouldlog == 1 )
        {
            println( "<dev string:x113e>" + text );
        }
    }

#/
