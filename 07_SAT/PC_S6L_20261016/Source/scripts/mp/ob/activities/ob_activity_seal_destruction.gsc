// scripts\mp\ob\activities\ob_activity_seal_destruction.gsc  (hash_1e3cd7c58ae8f1e8.gscc) (size: 7063 Bytes / 0x1b97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7c77c5c (2814868572)
// size ...... 7063 (0x1b97)
// includes .. 14  (offset: 0x1a0b)
// strings ... 18  (offset: 0x1a7b)
// dev strs .. 3   (offset: 0x1b73)
// exports ... 20  (offset: 0xf37)
// cseg ...... 0x1ed + 0xd4a (0xf37)
// imports ... 67  (offset: 0x1257)
// animtree1 . 0   (offset: 0x1b97)
// animtree2 . 0   (offset: 0x1b97)
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_strike_boss_shared;

#namespace ob_activity_seal_destruction;

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x5
// Checksum 0xd40cd63a, Offset: 0x20b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_de34f7e791d8ddf3", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0xa5a498ff, Offset: 0x234
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_SEAL_DESTRUCTION", &activity_type_init );
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0xf2a347d2, Offset: 0x24f
// Size: 0x5e
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_DESTRUCTION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_DESTRUCTION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_DESTRUCTION", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_DESTRUCTION", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( "sat_activity_definition_seal_destruction", "haunting_seal_destruction" );
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0xd6003a09, Offset: 0x2b5
// Size: 0x295
function private activity_setup()
{
    state_map = [ 2:"ice", "electric", 0:"fire" ];
    spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    seal_params = spawn_data.seal_params;
    self.seal_type = seal_params.seal_type ?? 0;
    self.seal_base = seal_params.base;
    self.obelisk = seal_params.obelisk;
    self.ritual_object = seal_params.ritual_object;
    self.parent_activity = spawn_data.parent_activity;
    self.on_success_callback = spawn_data.on_success_callback;
    self.destruction_index = spawn_data.destruction_index;
    self.seal_zone = seal_params.seal_zone;
    self.seal_base.activity = self;
    self.seal_base setscriptablepartstate( #"interact", #"off" );
    self.seal_base setscriptablepartstate( #"body", hashcat( #"active_", state_map[ self.seal_type ] ) );
    self.obelisk setscriptablepartstate( #"icon", #"visible" );
    custom_props = activity_definition_utils::function_9129cd8075c85c09( self );
    
    switch ( self.seal_type )
    {
        case 0:
            activity_definition_utils::function_a0a94881bc380bbf( 1, self );
            self.required_kill_count = custom_props.var_ae64b4309b52790d;
            break;
        case 1:
            activity_definition_utils::function_a0a94881bc380bbf( 2, self );
            self.required_kill_count = custom_props.var_e11c8d1bc41f4e2f;
            break;
        case 2:
            activity_definition_utils::function_a0a94881bc380bbf( 0, self );
            self.required_kill_count = custom_props.var_86bc8573e9dbbc7a;
            break;
        default:
            assertmsg( "<dev string:x24>" + self.seal_type );
            break;
    }
    
    self.agent_kill_count = 0;
    self.var_546e4eb5269dbafa = "difficulty5";
    spatial_zone_container::function_5252f95edcf9e32c( self, "Awareness_Zone", &awareness_zone_get_center, [ self ] );
    self.spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( self, "Awareness_Zone", undefined, 1000, 1 );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0x224a4080, Offset: 0x552
// Size: 0xee
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread function_a81d76001d8ac72c();
    ob_activity_strike_boss_shared::function_33d7c1273681ab9f( self.seal_zone.origin, self.seal_zone.radius );
    waitframe();
    ob_activity_strike_boss_shared::function_e67794b46217642e( self.varianttag + self.destruction_index, self.seal_zone.origin, self.seal_zone.radius, self.seal_zone.height );
    ob_activity_strike_boss_shared::function_794686ee5a2eb3b6( self.seal_base.origin, 5000, self.seal_base.origin );
    wait 5;
    function_2303dc95861fc3cc();
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, self.required_kill_count );
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0xf7f7a350, Offset: 0x648
// Size: 0x156
function private activity_end()
{
    state_map = [ 2:#"ice", #"electric", 0:#"fire" ];
    var_77c07814e1824f48 = [ 2:"ice", "electric", 0:"fire" ];
    self.obelisk setscriptablepartstate( #"icon", #"invisible" );
    self.obelisk setscriptablepartstate( #"fx", hashcat( state_map[ self.seal_type ], "_done" ) );
    self.obelisk setscriptablepartstate( #"body", #"destroyed" );
    self.obelisk calloutmarkerping::function_608710c894185549();
    self.seal_base setscriptablepartstate( #"body", hashcat( #"hash_d8f7bd8dc356f472", var_77c07814e1824f48[ self.seal_type ] ) );
    self.ritual_object setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", self.seal_type ), #"done" );
    
    if ( activity_instance_common::function_6bb0be4a3940d6e3( self ) )
    {
        if ( self.parent_activity )
        {
            self.parent_activity thread [[ self.on_success_callback ]]();
        }
    }
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0xf573bcf3, Offset: 0x7a6
// Size: 0x24
function private function_d4acef179eb9f9b2()
{
    self.obelisk utility::function_32b24db3127bff40( #"icon", #"invisible" );
}

// Namespace ob_activity_seal_destruction
// Params 1, eflags: 0x4
// Checksum 0x216231b9, Offset: 0x7d2
// Size: 0xc2
function private function_b9ba7e08f677f663( ai_encounter_id )
{
    if ( !isdefined( ai_encounter_id ) )
    {
        return;
    }
    
    if ( !activity_ai_encounters::function_e9bac21ccee7cf24( ai_encounter_id ) )
    {
        return;
    }
    
    data = function_9b649316adcccbaa( ai_encounter_id );
    
    foreach ( agent in data.ai )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        agent thread function_a041a54f40b7dc8a();
    }
    
    activity_ai_encounters::function_1010ba035d94f9f1( ai_encounter_id );
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0x42e67446, Offset: 0x89c
// Size: 0x5c
function private function_a041a54f40b7dc8a()
{
    self endon( #"death" );
    self.var_a13bed1ac47e1b2c = 1;
    self.dropweapon = 0;
    self.nodrop = 1;
    val::set( "seal_destruction_end", "ignoreall", 1 );
    var_68d856e9730bd509 = randomfloat( 2 );
    wait var_68d856e9730bd509;
    self kill();
}

// Namespace ob_activity_seal_destruction
// Params 1, eflags: 0x4
// Checksum 0xadceef2, Offset: 0x900
// Size: 0x21
function private awareness_zone_get_center( activityinstance )
{
    return activityinstance.seal_base.origin;
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0x16907cd2, Offset: 0x92a
// Size: 0xc2
function private function_2303dc95861fc3cc()
{
    switch ( self.seal_type )
    {
        case 0:
            ai_encounter = "ai_encounter:sat_enc_ob_seal_guardians_precision";
            break;
        case 1:
            ai_encounter = "ai_encounter:sat_enc_ob_seal_guardians_ruin";
            break;
        case 2:
            ai_encounter = "ai_encounter:sat_enc_ob_seal_guardians_control";
            break;
    }
    
    self.encounter_id = activity_ai_encounters::function_eb8506829193f5eb( ai_encounter, self.seal_base.origin, 200, 1, 1, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( self.encounter_id, &on_agent_spawned, [ self ] );
    activity_ai_encounters::function_d33de057e760c97b( self.encounter_id, &should_shutdown_flood_fill, [ self ] );
}

// Namespace ob_activity_seal_destruction
// Params 2, eflags: 0x4
// Checksum 0x2a8dfd11, Offset: 0x9f4
// Size: 0x16, Type: bool
function private should_shutdown_flood_fill( encounter_id, var_3c793eed5f22ab1a )
{
    return false;
}

// Namespace ob_activity_seal_destruction
// Params 4, eflags: 0x4
// Checksum 0x2523e38e, Offset: 0xa13
// Size: 0x7f
function private on_agent_spawned( request_id, var_3c793eed5f22ab1a, agent, agent_spawn_data )
{
    activity_instance = var_3c793eed5f22ab1a[ 0 ];
    agent.var_647981cb4f0d9796 = activity_instance;
    agent callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7, activity_instance );
    
    if ( agent.subclass == "juggerbot" )
    {
        agent.var_a13bed1ac47e1b2c = 1;
    }
}

// Namespace ob_activity_seal_destruction
// Params 2, eflags: 0x4
// Checksum 0x15e58ca1, Offset: 0xa9a
// Size: 0x134
function private function_8c5e06ee1e60aeb7( params, activity_instance )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    if ( distance2d( activity_instance.obelisk.origin, self.origin ) >= 400 )
    {
        return;
    }
    
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:x5f>", 0 ) == 1 )
        {
            activity_instance function_e1b11f6893045136( self.origin );
            return;
        }
        
        if ( function_a5cd5a36ccebe58( "<dev string:x71>", 0 ) == 1 )
        {
            activity_instance.agent_kill_count = activity_instance.required_kill_count - 1;
        }
    #/
    
    weapon = params.sweapon;
    attacker = params.eattacker.owner ?? params.eattacker;
    
    if ( isplayer( attacker ) && isweapon( weapon ) && ( weapon::function_52f1736c4c1b06d4( params.sweapon ) || 5 <= attacker item_weapon::function_fb81bd2fe070faa6( weapon ) ) )
    {
        activity_instance function_e1b11f6893045136( self.origin );
    }
}

// Namespace ob_activity_seal_destruction
// Params 1, eflags: 0x4
// Checksum 0xe2e2eda0, Offset: 0xbd6
// Size: 0x69
function private function_e1b11f6893045136( origin )
{
    self.agent_kill_count += 1;
    self notify( #"hash_bf9c67cb39b26ca0" );
    
    if ( self.required_kill_count > self.agent_kill_count )
    {
        level thread collect_soul( origin, self.seal_type, self.ritual_object.origin );
    }
}

// Namespace ob_activity_seal_destruction
// Params 3, eflags: 0x4
// Checksum 0xaeb70d3b, Offset: 0xc47
// Size: 0xfa
function private collect_soul( origin, seal_type, target_origin )
{
    soul_move_speed = 250;
    mover = utility::spawn_model( "tag_origin", origin, ( 0, 0, 0 ) );
    scriptable = spawnscriptable( %"hash_62ad238b4c141a3d", origin );
    scriptable setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", seal_type ), #"visible" );
    scriptable utility::scriptable_setparententity( mover );
    move_time_seconds = distance( mover.origin, target_origin ) / soul_move_speed;
    mover moveto( target_origin, move_time_seconds );
    utility::waittill_any_ents( mover, "movedone" );
    scriptable setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", seal_type ), #"impact" );
    wait 0.2;
    scriptable freescriptable();
    mover delete();
}

// Namespace ob_activity_seal_destruction
// Params 0, eflags: 0x4
// Checksum 0x8be91012, Offset: 0xd49
// Size: 0x191
function private function_a81d76001d8ac72c()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    state_map = [ 2:#"ice", #"electric", 0:#"fire" ];
    self.obelisk.currentstate = 1;
    
    while ( true )
    {
        self waittill( #"hash_bf9c67cb39b26ca0" );
        activity_definition_utils::updateprogress( self.agent_kill_count, self, self.required_kill_count );
        progress = self.agent_kill_count / self.required_kill_count * 100;
        state = 1;
        
        if ( progress >= 66 )
        {
            state = 3;
        }
        else if ( progress >= 33 )
        {
            state = 2;
        }
        
        if ( self.obelisk.currentstate != state )
        {
            self.obelisk.currentstate = state;
            self.obelisk setscriptablepartstate( #"fx", hashcat( state_map[ self.seal_type ], self.obelisk.currentstate ) );
        }
        
        if ( self.required_kill_count <= self.agent_kill_count )
        {
            if ( self.seal_type == 2 )
            {
                function_b9ba7e08f677f663( self.var_4327a4d1e41d7bed );
                function_b9ba7e08f677f663( self.encounter_id );
            }
            
            waitframe();
            activity_instance_common::endactivity( self, 1 );
            break;
        }
    }
}

// Namespace ob_activity_seal_destruction
// Params 2, eflags: 0x4
// Checksum 0xbe4f5ec2, Offset: 0xee2
// Size: 0x2a
function private get_override_setting( name, defaultvalue )
{
    return getdvarint( hashcat( @"hash_836f00298387cd8a", name ), defaultvalue );
}

/#

    // Namespace ob_activity_seal_destruction
    // Params 2, eflags: 0x4
    // Checksum 0x4bc7e446, Offset: 0xf15
    // Size: 0x22, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return get_override_setting( name, defaultvalue );
    }

#/
