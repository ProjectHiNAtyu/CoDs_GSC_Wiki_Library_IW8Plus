// script_4e2becc40a3e7251  (hash_4e2becc40a3e7251.gscc) (size: 19881 Bytes / 0x4da9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5fe1e9b (3053330075)
// size ...... 19881 (0x4da9)
// includes .. 18  (offset: 0x4909)
// strings ... 72  (offset: 0x4999)
// dev strs .. 8   (offset: 0x4d49)
// exports ... 52  (offset: 0x2f7d)
// cseg ...... 0x65e + 0x291f (0x2f7d)
// imports ... 139 (offset: 0x379d)
// animtree1 . 0   (offset: 0x4da9)
// animtree2 . 0   (offset: 0x4da9)
#using script_2304453c69e996e2;
#using script_24ca45b70d66c3c3;
#using script_e9bca00ec07d3c6;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\scriptable;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;
#using scripts\mp\loot\common_cache;
#using scripts\mp\mp_agent_damage;

#namespace scorpio_exterior;

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0xe4505e84, Offset: 0x67c
    // Size: 0x5, Type: dev
    function function_59b395d041b89cd3()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0
// Checksum 0x5831e0df, Offset: 0x689
// Size: 0x33
function function_e42b96423718d54d()
{
    function_bf0e6638bb00cbae();
    function_7acfd63b41d757a9();
    function_1e9dd5eaa72463ce();
    level thread function_322eff68ce1f23e();
    level thread function_3b8c62b55fd36d55();
    utility::flag_set( "scorpio_exterior_setup_complete" );
}

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0x4dfa399a, Offset: 0x6c4
// Size: 0x2f
function private function_bf0e6638bb00cbae()
{
    level.var_bf8d1e3625de37c0 = utility::getstructarray( "s_scorpio_exterior_spawn", "targetname" );
    level.var_9209738322af425c = [];
    level.var_3a70453ca82b19d3 = [];
}

// Namespace scorpio_exterior
// Params 1, eflags: 0x4
// Checksum 0x82cbe023, Offset: 0x6fb
// Size: 0x79
function private link_to_scorpio( spawn_point )
{
    if ( spawn_point.script_parameters )
    {
        scorpio_clip_brush = getent( spawn_point.script_parameters, #targetname );
        
        if ( scorpio_clip_brush )
        {
            self linkto( scorpio_clip_brush );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" + spawn_point.script_noteworthy + "<dev string:x67>" + spawn_point.origin );
}

// Namespace scorpio_exterior
// Params 0
// Checksum 0x90fc057, Offset: 0x77c
// Size: 0x15a
function clean_up_exterior()
{
    foreach ( item in level.var_9209738322af425c )
    {
        item notify( #"hash_73537c07898a047a" );
        
        if ( isent( item ) )
        {
            item delete();
            continue;
        }
        
        item freescriptable();
    }
    
    foreach ( turret in level.var_3a70453ca82b19d3 )
    {
        turret notify( #"kill_turret" );
        
        if ( turret.turret_base )
        {
            turret.turret_base delete();
        }
        
        vehicle_tracking::deregister_instance( turret );
        vehicle_occupancy::deregister_instance( turret );
        turret vehicle_tracking::delete_vehicle( turret );
    }
    
    utility::flag_set( "scorpio_exterior_clean_up_complete" );
}

// Namespace scorpio_exterior
// Params 0
// Checksum 0xf73c4c1d, Offset: 0x8de
// Size: 0xdd
function function_3f2c28196579d5d0()
{
    scriptable::function_dc174fecebb79952( &function_7c415ed72d687241 );
    
    foreach ( item in level.var_9209738322af425c )
    {
        item notify( #"hash_73537c07898a047a" );
        
        if ( isent( item ) && item.is_portal )
        {
            item delete();
        }
        
        if ( item.is_foot_door )
        {
            if ( item getscriptablepartstate( "model" ) == "destroyed" )
            {
                item setscriptablepartstate( "model", "disabled" );
            }
        }
    }
}

// Namespace scorpio_exterior
// Params 0
// Checksum 0x4586e167, Offset: 0x9c3
// Size: 0x91
function function_50d2d399689da874()
{
    foreach ( turret in level.var_3a70453ca82b19d3 )
    {
        turret notify( #"kill_turret" );
        vehicle_tracking::deregister_instance( turret );
        vehicle_occupancy::deregister_instance( turret );
    }
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0x130eb031, Offset: 0xa5c
    // Size: 0x5, Type: dev
    function function_be4986120ef269b5()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 1
// Checksum 0x44056256, Offset: 0xa69
// Size: 0x58
function function_b0ed025fd9f64b5e( b_static = 1 )
{
    if ( b_static )
    {
        scorpio_minions = ai_spawn_director::lookup_spawn_request( "ai_enc_vol_minions_right" );
        
        if ( isdefined( scorpio_minions ) )
        {
            function_ef57f478f96b050c( scorpio_minions, 1 );
            function_fbe9bb47edbe2d7c( scorpio_minions );
            ai_spawn_director::add_spawned_callback( scorpio_minions, &function_23c54261ef7afc6a );
        }
    }
}

// Namespace scorpio_exterior
// Params 1
// Checksum 0x383c634a, Offset: 0xac9
// Size: 0x49
function function_64e281352de54639( b_static = 1 )
{
    if ( b_static )
    {
        scorpio_minions = ai_spawn_director::lookup_spawn_request( "ai_enc_vol_minions_right" );
        
        if ( isdefined( scorpio_minions ) )
        {
            function_ef57f478f96b050c( scorpio_minions, 0 );
            function_b57e44ce9d93be80( scorpio_minions );
        }
    }
}

// Namespace scorpio_exterior
// Params 4
// Checksum 0x4bd8057, Offset: 0xb1a
// Size: 0x47
function function_23c54261ef7afc6a( requestid, instance, agent, ai_data )
{
    agent val::set( "scorpio_minion", "dont_evolve", 1 );
    agent.var_2d00ed01947563cf = undefined;
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0x8c44c244, Offset: 0xb69
    // Size: 0x5, Type: dev
    function function_6d225301d3a11b0e()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 1
// Checksum 0x8b81c31d, Offset: 0xb76
// Size: 0xab
function function_880d772e5f5913a( b_full_ai_spawn_director )
{
    s_teleport_des = utility::getstruct( "s_start_heli_test", "targetname" );
    level.players[ 0 ] setorigin( s_teleport_des.origin, 1 );
    level.players[ 0 ] setplayerangles( s_teleport_des.angles, 1 );
    
    if ( b_full_ai_spawn_director )
    {
        var_61fda374fe76a4e7 = ai_spawn_director::lookup_spawn_request( "ai_enc_vol_heli_reinforcements" );
        
        if ( isdefined( var_61fda374fe76a4e7 ) )
        {
            function_ef57f478f96b050c( var_61fda374fe76a4e7, 1 );
            function_fbe9bb47edbe2d7c( var_61fda374fe76a4e7 );
            ai_spawn_director::add_vehicle_spawned_callback( var_61fda374fe76a4e7, &function_a6f6cfc5ad2c548e );
        }
        
        return;
    }
    
    level thread function_55769a5f5847c5d1();
}

// Namespace scorpio_exterior
// Params 0
// Checksum 0xac49da63, Offset: 0xc29
// Size: 0x76
function function_55769a5f5847c5d1()
{
    helicopter_struct = getvehiclenode( "nd_veh_heli_reinforcements", #targetname );
    var_300037d32586873c = getscriptbundle( "helicoptersettings:blima_helicopter_settings_wc_sat" );
    heli = namespace_28acf6540b1bc740::function_49253856b6828e7e( helicopter_struct, 0, 1, var_300037d32586873c );
    v_pos = ( -8420, -4515, 0 );
    heli thread function_13512290f48e46d2( v_pos, heli.origin );
}

// Namespace scorpio_exterior
// Params 2
// Checksum 0x8b8ce67e, Offset: 0xca7
// Size: 0x1d2
function function_13512290f48e46d2( target_pos, origin_pos )
{
    self.usedpositions = [ 0, 0, 0, 0, 0, 0, 0 ];
    passengers = ai_spawn_director::lookup_spawn_request( "ai_enc_vol_heli_passengers_reinforcements" );
    function_c505198907e0d306( passengers, self, 1 );
    
    if ( isdefined( passengers ) )
    {
        function_ef57f478f96b050c( passengers, 1 );
        function_fbe9bb47edbe2d7c( passengers );
        function_64ac8c4e752f4dca( passengers, 0 );
        self.directorrequestid = passengers;
        b_success = ai_spawn_director::function_3ce5298df1143d67( "FinishedSpawningBucket", self.directorrequestid );
        
        if ( b_success )
        {
            foreach ( rider in self.riders )
            {
                self.ignorelist[ self.ignorelist.size ] = rider;
            }
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x69>" );
            #/
        }
    }
    
    if ( isvector( target_pos ) )
    {
        target = utility::spawn_tag_origin( target_pos );
    }
    else
    {
        target = target_pos;
    }
    
    b_ignoreblocks = 0;
    namespace_28acf6540b1bc740::function_7fb408948b1225e0( target, undefined, 512, b_ignoreblocks );
    thread namespace_37f5741ccbccb7a::function_d3c71c9947aada0b( target );
    self waittill( #"unloaded" );
    wait 3;
    target delete();
    var_33c6ec0c8950dc0 = utility::spawn_tag_origin( origin_pos );
    namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_33c6ec0c8950dc0, undefined, 512, b_ignoreblocks );
    wait 3;
    var_33c6ec0c8950dc0 delete();
    namespace_37f5741ccbccb7a::ai_spawn_director_heli_cleanup();
}

// Namespace scorpio_exterior
// Params 3
// Checksum 0xb329f2c3, Offset: 0xe81
// Size: 0x57
function function_a6f6cfc5ad2c548e( requestid, userdata, heli )
{
    v_pos = ( 4480, -2752, 0 );
    target = utility::spawn_tag_origin( v_pos );
    heli thread namespace_28acf6540b1bc740::function_7fb408948b1225e0( target, undefined, 256 );
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0xee84c40, Offset: 0xee0
    // Size: 0x5, Type: dev
    function function_7acc6c449e67163()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0
// Checksum 0x94f1c61f, Offset: 0xeed
// Size: 0xb8
function function_d007508f5fd420e0()
{
    charge_time = 10;
    cooldown = 5;
    damage_countdown = 80;
    
    foreach ( point in level.var_bf8d1e3625de37c0 )
    {
        if ( point.script_noteworthy == "scorpio_pylon" )
        {
            level thread function_12f9aaa3168d4b63( damage_countdown, point, charge_time, cooldown );
        }
    }
}

// Namespace scorpio_exterior
// Params 5
// Checksum 0xba88f894, Offset: 0xfad
// Size: 0x103
function function_12f9aaa3168d4b63( damage_countdown, str_bone, charge_time, cooldown, pylon_origin )
{
    if ( !isdefined( pylon_origin ) )
    {
        skeleton_rig = level.scorpio_skel;
        pylon_origin = ( 0, 0, 0 );
    }
    
    pylon = spawnscriptable( %"hash_36f5268156dbde7f", pylon_origin );
    scriptable::scriptable_addnotifycallback( "pylon_charging", &function_4c7fa6fc7a737c31 );
    scriptable::scriptable_addnotifycallback( "pylon_damaged", &function_43638978ae07b115 );
    scriptable::scriptable_addnotifycallback( "pylon_discharged", &function_a2551e9ebfff939a );
    
    if ( isdefined( str_bone ) && isdefined( skeleton_rig ) )
    {
        pylon thread function_531b436ab8887dea( skeleton_rig, str_bone, "pylon_destroyed" );
    }
    
    pylon.damage_countdown = damage_countdown;
    pylon setscriptablepartstate( #"body", #"discharged" );
    pylon setscriptablepartstate( #"health", #"shootable" );
}

// Namespace scorpio_exterior
// Params 4
// Checksum 0xb81b92e0, Offset: 0x10b8
// Size: 0x2d
function function_4c7fa6fc7a737c31( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance ) )
    {
    }
}

// Namespace scorpio_exterior
// Params 4
// Checksum 0x4b79cc8d, Offset: 0x10ed
// Size: 0x95
function function_43638978ae07b115( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance ) )
    {
        instance.damage_countdown--;
        
        if ( !instance.dead && instance.damage_countdown <= 0 )
        {
            instance.dead = 1;
            instance notify( #"pylon_destroyed" );
            instance setscriptablepartstate( #"body", #"destroyed" );
            waitframe();
            instance freescriptable();
        }
    }
}

// Namespace scorpio_exterior
// Params 4
// Checksum 0xe0873c54, Offset: 0x118a
// Size: 0x14b
function function_a2551e9ebfff939a( instance, note, param, var_64ffacba090c91be )
{
    circle_radius = 256;
    var_c8cf90daee0f67a3 = 800;
    knockback_damage = 50;
    z_offset = ( 0, 0, 110 );
    
    if ( isdefined( instance ) )
    {
        thread function_d9a145e4a9356418( instance );
        players = getplayersinradius( instance.origin, circle_radius );
        
        foreach ( player in players )
        {
            player knockback( player.origin - instance.origin, circle_radius * var_c8cf90daee0f67a3 / length( player.origin - instance.origin ) );
            player dodamage( knockback_damage, instance.origin, undefined, instance );
        }
    }
}

// Namespace scorpio_exterior
// Params 1
// Checksum 0x9f3c22ff, Offset: 0x12dd
// Size: 0x47
function function_d9a145e4a9356418( instance )
{
    var_c16e8946d253c0ce = spawnfx( level._effect[ "dust_kickup" ], instance.origin );
    triggerfx( var_c16e8946d253c0ce );
    wait 5;
    var_c16e8946d253c0ce delete();
}

// Namespace scorpio_exterior
// Params 3
// Checksum 0x3bf6b78a, Offset: 0x132c
// Size: 0x8a
function function_531b436ab8887dea( skeleton_rig, str_bone, msg_endon )
{
    if ( !isdefined( skeleton_rig ) )
    {
        /#
            iprintln( "<dev string:xa8>" );
        #/
        
        return;
    }
    
    if ( !isdefined( str_bone ) )
    {
        /#
            iprintln( "<dev string:xda>" );
        #/
        
        return;
    }
    
    if ( !isdefined( msg_endon ) )
    {
        msg_endon = "game_ended";
    }
    
    self endon( msg_endon );
    
    while ( true )
    {
        self.origin = str_bone.origin;
        self.angles = str_bone.angles;
        waitframe();
    }
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0x4f50c536, Offset: 0x13be
    // Size: 0x5, Type: dev
    function function_16c90bce8e09c8ef()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0x3566f469, Offset: 0x13cb
// Size: 0xa5
function private function_1e9dd5eaa72463ce()
{
    foreach ( spawnpoint in level.var_bf8d1e3625de37c0 )
    {
        if ( spawnpoint.script_noteworthy == "scorpio_loot" )
        {
            function_4a3181381306f6e2( spawnpoint.origin, spawnpoint.angles, spawnpoint );
        }
    }
}

// Namespace scorpio_exterior
// Params 3
// Checksum 0x184970b3, Offset: 0x1478
// Size: 0xd5
function function_4a3181381306f6e2( loot_origin, var_1d71d60919352611, spawnpoint )
{
    rewardchest = spawnscriptable( "sat_ob_loot_cache", loot_origin, var_1d71d60919352611 );
    rewardchest setscriptablepartstate( "body", "closed_usable" );
    clip_brush = getent( spawnpoint.script_parameters, #targetname );
    
    if ( clip_brush )
    {
        rewardchest scriptablesetparententity( clip_brush, rewardchest.origin - clip_brush.origin, var_1d71d60919352611 ?? ( 0, 0, 0 ) );
    }
    
    common_cache::function_a136b84fc5c0dfab( rewardchest, hashcat( %"itemspawnlist:", "ob_sat_items_scorpio_exterior_cache" ), 5, 1 );
    level.var_9209738322af425c[ level.var_9209738322af425c.size ] = rewardchest;
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0xc66fc9e5, Offset: 0x1555
    // Size: 0x5, Type: dev
    function function_8d8ac4cd6dd788b1()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0xd71dd57c, Offset: 0x1562
// Size: 0x114
function private function_2988555ee3a06466()
{
    level thread function_c51d4aa9789ac471();
    
    foreach ( jump_pad_spawn in level.var_bf8d1e3625de37c0 )
    {
        if ( jump_pad_spawn.script_noteworthy == "scorpio_jump_pad" )
        {
            jump_pad_spawn.pad_is_active = 0;
            jump_pad_spawn thread scorpio_jump_pad_watcher();
            jump_pad_model = spawn( "script_model", jump_pad_spawn.origin );
            jump_pad_model setmodel( "sat_zm_ztron_props_spring_platform" );
            jump_pad_model.angles = jump_pad_spawn.angles;
            jump_pad_spawn.var_9bd5a841113ddac8 = jump_pad_model;
            jump_pad_model link_to_scorpio( jump_pad_spawn );
            level.var_9209738322af425c[ level.var_9209738322af425c.size ] = jump_pad_model;
        }
    }
}

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0x59c59ce6, Offset: 0x167e
// Size: 0x2b1
function private scorpio_jump_pad_watcher()
{
    level endon( #"game_ended" );
    level.scorpio_skel endon( #"scorpio_reached_end" );
    utility::flag_wait( "scorpio_setup_complete" );
    thread scorpio_jump_pad_toggle();
    jump_magnitude = getdvarfloat( @"hash_c3a620836ac4d015", 1700 );
    forward_magnitude = getdvarfloat( @"hash_f7fdc050ac4e2c55", 500 );
    jump_pad_dir = self.angles;
    
    while ( true )
    {
        if ( self.radius )
        {
            players_in_radius = getplayersinradius( self.origin, self.radius );
        }
        else
        {
            players_in_radius = getplayersinradius( self.origin, 64 );
        }
        
        if ( self.target == "jump_pad_1_ri" )
        {
            jump_magnitude = getdvarfloat( @"hash_da5c2b121d892435", 0 );
            forward_magnitude = getdvarfloat( @"hash_dbf8ebc0e2bb51f5", 0 );
            forward_shift = getdvarvector( @"hash_3919853dc75fb59e", ( 0, 0, 0 ) );
            jump_pad_dir = self.angles + forward_shift;
        }
        
        if ( self.target == "jump_pad_2_ri" )
        {
            jump_magnitude = getdvarfloat( @"hash_c0dca61b513b267e", 0 );
            forward_magnitude = getdvarfloat( @"hash_4d2c4b2e8acc02d0", 0 );
            forward_shift = getdvarvector( @"hash_cde9e6a744096a0f", ( 0, 0, 0 ) );
            jump_pad_dir = self.angles + forward_shift;
        }
        
        if ( self.target == "jump_pad_1_le" )
        {
            jump_magnitude = getdvarfloat( @"hash_5582d04dbb6eb92a", 0 );
            forward_magnitude = getdvarfloat( @"hash_e494f5253709544c", 0 );
            forward_shift = getdvarvector( @"hash_97bf1fc03af989c3", ( 0, 0, 0 ) );
            jump_pad_dir = self.angles + forward_shift;
        }
        
        if ( self.target == "jump_pad_2_le" )
        {
            jump_magnitude = getdvarfloat( @"hash_2c216d149f792fbb", 0 );
            forward_magnitude = getdvarfloat( @"hash_df28f9729fb5c1cb", 0 );
            forward_shift = getdvarvector( @"hash_dea98a6ededf9c18", ( 0, 0, 0 ) );
            jump_pad_dir = self.angles + forward_shift;
        }
        
        if ( getdvarint( @"scorpio_jump_pad_debug", 0 ) )
        {
            /#
                thread function_930bb54a1718bfee( self, jump_pad_dir, jump_magnitude, forward_magnitude, forward_shift );
            #/
        }
        
        if ( isdefined( players_in_radius ) && self.pad_is_active )
        {
            players_in_radius scorpio_jump_pad_knockback( self.origin, jump_pad_dir, jump_magnitude, forward_magnitude );
        }
        
        waitframe();
    }
}

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0xa182290a, Offset: 0x1937
// Size: 0x46a
function private function_c51d4aa9789ac471()
{
    level endon( #"game_ended" );
    level.scorpio_skel endon( #"scorpio_reached_end" );
    utility::flag_wait( "scorpio_setup_complete" );
    
    while ( true )
    {
        msg = level.scorpio_skel utility::waittill_any_return( "scorpio_stomp_a", "scorpio_stomp_b", "scorpio_laser_a", "scorpio_laser_b" );
        
        if ( msg == "scorpio_stomp_a" )
        {
            setdvar( @"hash_da5c2b121d892435", 1650 );
            setdvar( @"hash_dbf8ebc0e2bb51f5", 430 );
            setdvar( @"hash_3919853dc75fb59e", ( 0, 26, 0 ) );
            setdvar( @"hash_c0dca61b513b267e", 1550 );
            setdvar( @"hash_4d2c4b2e8acc02d0", 400 );
            setdvar( @"hash_cde9e6a744096a0f", ( 0, -29, 0 ) );
            setdvar( @"hash_5582d04dbb6eb92a", 840 );
            setdvar( @"hash_e494f5253709544c", 780 );
            setdvar( @"hash_97bf1fc03af989c3", ( 0, -50, 0 ) );
            setdvar( @"hash_2c216d149f792fbb", 1040 );
            setdvar( @"hash_df28f9729fb5c1cb", 600 );
            setdvar( @"hash_dea98a6ededf9c18", ( 0, -50, 0 ) );
            continue;
        }
        
        if ( msg == "scorpio_stomp_b" )
        {
            setdvar( @"hash_da5c2b121d892435", 1650 );
            setdvar( @"hash_dbf8ebc0e2bb51f5", 430 );
            setdvar( @"hash_3919853dc75fb59e", ( 0, 30, 0 ) );
            setdvar( @"hash_c0dca61b513b267e", 1600 );
            setdvar( @"hash_4d2c4b2e8acc02d0", 390 );
            setdvar( @"hash_cde9e6a744096a0f", ( 0, -29, 0 ) );
            setdvar( @"hash_5582d04dbb6eb92a", 620 );
            setdvar( @"hash_e494f5253709544c", 840 );
            setdvar( @"hash_97bf1fc03af989c3", ( 0, -52, 0 ) );
            setdvar( @"hash_2c216d149f792fbb", 910 );
            setdvar( @"hash_df28f9729fb5c1cb", 560 );
            setdvar( @"hash_dea98a6ededf9c18", ( 0, -50, 0 ) );
            continue;
        }
        
        if ( msg == "scorpio_laser_a" )
        {
            setdvar( @"hash_da5c2b121d892435", 1480 );
            setdvar( @"hash_dbf8ebc0e2bb51f5", 670 );
            setdvar( @"hash_3919853dc75fb59e", ( 0, 38, 0 ) );
            setdvar( @"hash_c0dca61b513b267e", 1650 );
            setdvar( @"hash_4d2c4b2e8acc02d0", 530 );
            setdvar( @"hash_cde9e6a744096a0f", ( 0, 18, 0 ) );
            setdvar( @"hash_5582d04dbb6eb92a", 1100 );
            setdvar( @"hash_e494f5253709544c", 900 );
            setdvar( @"hash_97bf1fc03af989c3", ( 0, 12, 0 ) );
            setdvar( @"hash_2c216d149f792fbb", 1240 );
            setdvar( @"hash_df28f9729fb5c1cb", 550 );
            setdvar( @"hash_dea98a6ededf9c18", ( 0, 45, 0 ) );
            continue;
        }
        
        if ( msg == "scorpio_laser_b" )
        {
            setdvar( @"hash_da5c2b121d892435", 1440 );
            setdvar( @"hash_dbf8ebc0e2bb51f5", 670 );
            setdvar( @"hash_3919853dc75fb59e", ( 0, 40, 0 ) );
            setdvar( @"hash_c0dca61b513b267e", 1650 );
            setdvar( @"hash_4d2c4b2e8acc02d0", 530 );
            setdvar( @"hash_cde9e6a744096a0f", ( 0, 18, 0 ) );
            setdvar( @"hash_5582d04dbb6eb92a", 1000 );
            setdvar( @"hash_e494f5253709544c", 900 );
            setdvar( @"hash_97bf1fc03af989c3", ( 0, 12, 0 ) );
            setdvar( @"hash_2c216d149f792fbb", 1240 );
            setdvar( @"hash_df28f9729fb5c1cb", 550 );
            setdvar( @"hash_dea98a6ededf9c18", ( 0, 45, 0 ) );
        }
    }
}

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0x5a1d866d, Offset: 0x1da9
// Size: 0x10d
function private scorpio_jump_pad_toggle()
{
    level endon( #"game_ended" );
    level.scorpio_skel endon( #"scorpio_reached_end" );
    
    while ( true )
    {
        waitframe();
        playfxontag( level._effect[ "scorpio_pad_disabled" ], self, "tag_origin" );
        msg = level.scorpio_skel utility::waittill_any( "scorpio_stomp_loop", "scorpio_attack_beam" );
        
        if ( msg == "scorpio_stomp_loop" )
        {
            wait 3.7;
        }
        else if ( msg == "scorpio_attack_beam" )
        {
            wait 1.8;
        }
        
        stopfxontag( level._effect[ "scorpio_pad_disabled" ], self, "tag_origin" );
        waitframe();
        playfxontag( level._effect[ "scorpio_pad_enabled" ], self, "tag_origin" );
        self.pad_is_active = 1;
        level.scorpio_skel utility::waittill_any( "scorpio_beam_start", "scorpio_stomp" );
        stopfxontag( level._effect[ "scorpio_pad_enabled" ], self, "tag_origin" );
        self.pad_is_active = 0;
    }
}

// Namespace scorpio_exterior
// Params 4, eflags: 0x4
// Checksum 0x8480576, Offset: 0x1ebe
// Size: 0x112
function private scorpio_jump_pad_knockback( impulse_pos, jump_pad_dir, jump_magnitude, forward_magnitude )
{
    foreach ( entity in self )
    {
        if ( isplayer( entity ) && !events::function_853f2fa3d548d7ec( entity ) )
        {
            up = anglestoup( entity.angles );
            forward = anglestoforward( jump_pad_dir );
            entity setorigin( impulse_pos + ( 0, 0, 20 ) );
            entity setvelocity( forward * forward_magnitude + up * jump_magnitude );
            
            if ( getdvarint( @"scorpio_jump_pad_debug", 0 ) )
            {
                /#
                    entity thread function_b079cea001492f2d();
                #/
            }
        }
    }
}

/#

    // Namespace scorpio_exterior
    // Params 0, eflags: 0x4
    // Checksum 0x638f216b, Offset: 0x1fd8
    // Size: 0x1c0, Type: dev
    function private function_b079cea001492f2d()
    {
        self endon( #"death" );
        self endon( #"game_ended" );
        level.scorpio_skel endon( #"scorpio_reached_end" );
        timer = 120;
        
        while ( timer > 0 )
        {
            vel = self getvelocity();
            
            if ( isdefined( vel ) )
            {
                speed = length( vel );
                
                if ( speed != 0 )
                {
                    velnorm = vel / speed;
                    speed = clamp( speed, 0, 350 );
                    lineratio = speed / 350;
                    thread debug::drawline( self.origin, self.origin + velnorm * lineratio * 25, 60, ( 0.91, 0.118, 0.961 ) );
                }
            }
            
            waitframe();
            
            if ( self isonground() )
            {
                thread debug::drawsphere( self.origin, 60, 60, ( 1, 1, 0 ) );
                break;
            }
            
            foreach ( ent in level.scorpio_ents )
            {
                if ( self istouching( ent ) )
                {
                    thread debug::drawsphere( self.origin, 60, 60, ( 1, 0, 0 ) );
                }
            }
            
            timer--;
            
            if ( timer == 0 )
            {
                thread debug::drawsphere( self.origin, 60, 60, ( 0, 1, 1 ) );
            }
        }
    }

    // Namespace scorpio_exterior
    // Params 5
    // Checksum 0x7b4dae33, Offset: 0x21a0
    // Size: 0x19c, Type: dev
    function function_930bb54a1718bfee( var_9bd5a841113ddac8, jump_pad_dir, jump_magnitude, forward_magnitude, forward_shift )
    {
        self notify( #"hash_adc36333755afd9d" );
        self endon( #"hash_adc36333755afd9d" );
        
        if ( var_9bd5a841113ddac8.pad_is_active )
        {
            thread utility::draw_circle( var_9bd5a841113ddac8.origin, var_9bd5a841113ddac8.radius, ( 0, 1, 0 ), 1, 0, 1 );
        }
        else
        {
            thread utility::draw_circle( var_9bd5a841113ddac8.origin, var_9bd5a841113ddac8.radius, ( 1, 0, 0 ), 1, 0, 1 );
            return;
        }
        
        up = ( 0, 0, 1 );
        forward = anglestoforward( jump_pad_dir );
        var_d8a1028bfb515319 = var_9bd5a841113ddac8.origin + ( 0, 0, 20 );
        estimated_velocity = forward * forward_magnitude + up * jump_magnitude;
        estimated_displacement = var_d8a1028bfb515319 + estimated_velocity;
        thread debug::drawline( var_d8a1028bfb515319, estimated_displacement, 0.05, ( 1, 1, 0 ) );
        thread debug::drawline( var_d8a1028bfb515319, var_d8a1028bfb515319 + up * 20, 0.05, ( 0, 0, 1 ) );
        thread debug::drawline( var_d8a1028bfb515319, var_d8a1028bfb515319 + forward * 20, 0.05, ( 1, 0, 0 ) );
        thread function_f5347b60eecd0e8f( var_9bd5a841113ddac8, forward, jump_magnitude, forward_magnitude, forward_shift );
    }

    // Namespace scorpio_exterior
    // Params 5, eflags: 0x4
    // Checksum 0xcd02d0ed, Offset: 0x2344
    // Size: 0xfc, Type: dev
    function private function_f5347b60eecd0e8f( var_9bd5a841113ddac8, jump_pad_dir, jump_magnitude, forward_magnitude, forward_shift )
    {
        print3d( var_9bd5a841113ddac8.origin, var_9bd5a841113ddac8.target, undefined, 1, 1, 1, 1 );
        print3d( var_9bd5a841113ddac8.origin + ( 10, 0, 40 ), "<dev string:x10d>" + jump_magnitude, undefined, 0.5, 0.4, 1, 1 );
        print3d( var_9bd5a841113ddac8.origin + ( 10, 0, 30 ), "<dev string:x118>" + forward_magnitude, undefined, 0.5, 0.4, 1, 1 );
        print3d( var_9bd5a841113ddac8.origin + ( 10, 0, 20 ), "<dev string:x122>" + forward_shift, undefined, 0.5, 0.4, 1, 1 );
    }

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0x9f3646a3, Offset: 0x2448
    // Size: 0x5, Type: dev
    function function_929763ff9d3392eb()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0xf8c2478f, Offset: 0x2455
// Size: 0x1bf
function private function_322eff68ce1f23e()
{
    var_dfd261369588c018 = getentarray( "scorpio_foot_portal_entrance", #targetname );
    scriptable::scriptable_addnotifycallback( "scorpio_foot_door_destroyed", &scorpio_foot_door_destroyed );
    scriptable::scriptable_adddamagedcallback( &function_7c415ed72d687241 );
    
    foreach ( ent in var_dfd261369588c018 )
    {
        clip_brush = getent( ent.target, #targetname );
        ent enablelinkto();
        ent linkto( clip_brush );
        foot_door = spawnscriptable( %"sat_ob_scorpio_exterior_foot_door", ent.origin );
        foot_door.door = ent;
        foot_door.clip = clip_brush;
        foot_door.var_ab8007f32d8a3abe = getdvarint( @"hash_40a2a11b4e66151a", 10000 );
        clip_brush.entrance_trigger = ent;
        ent.is_portal = 1;
        foot_door.is_foot_door = 1;
        level thread set_foot_door_pos( foot_door );
        level.var_9209738322af425c[ level.var_9209738322af425c.size ] = ent;
        level.var_9209738322af425c[ level.var_9209738322af425c.size ] = foot_door;
        level.var_2269853965fd4bfd[ level.var_2269853965fd4bfd.size ] = ent;
        level.var_2269853965fd4bfd[ level.var_2269853965fd4bfd.size ] = clip_brush;
    }
}

// Namespace scorpio_exterior
// Params 1, eflags: 0x4
// Checksum 0x83a8f978, Offset: 0x261c
// Size: 0xb1
function private set_foot_door_pos( foot_door )
{
    utility::flag_wait( "scorpio_setup_complete" );
    
    if ( foot_door.door.target == "j_ankle_ri" )
    {
        foot_door scriptablesetparententity( level.scorpio_ents[ 17 ], ( -5, -90, -160 ), ( 0, 0, 0 ) );
        return;
    }
    
    if ( foot_door.door.target == "j_ankle_le" )
    {
        foot_door scriptablesetparententity( level.scorpio_ents[ 18 ], ( -5, -90, -160 ), ( 0, 0, 0 ) );
    }
}

// Namespace scorpio_exterior
// Params 11, eflags: 0x4
// Checksum 0xf5669141, Offset: 0x26d5
// Size: 0x134
function private function_7c415ed72d687241( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) || instance.type != "sat_ob_scorpio_exterior_foot_door" )
    {
        return;
    }
    
    if ( instance.var_ab8007f32d8a3abe == 0 )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        instance.var_ab8007f32d8a3abe = max( instance.var_ab8007f32d8a3abe - idamage, 0 );
        level mp_agent_damage::function_eb8ba16055d6da7c( eattacker, instance, eattacker.point, undefined, undefined, idamage, vpoint );
        eattacker damagefeedback::updatehitmarker( "standard", instance.var_ab8007f32d8a3abe == 0, 1, 1 );
        eattacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", 0, self );
    }
    
    if ( instance.var_ab8007f32d8a3abe == 0 )
    {
        instance setscriptablepartstate( "health", "inactive" );
    }
}

// Namespace scorpio_exterior
// Params 4, eflags: 0x4
// Checksum 0xd3b3fb89, Offset: 0x2811
// Size: 0x89
function private scorpio_foot_door_destroyed( scriptable, notif, params, var_64ffacba090c91be )
{
    trigger::makeenterexittrigger( scriptable.door, &function_2c9da2856380dfe8 );
    scriptable.door.is_portal_exposed = 1;
    scriptable scriptableclearparententity();
    scriptable scriptablesetparententity( scriptable.clip, ( -6, 85, -208 ), ( 0, 0, 180 ) );
}

// Namespace scorpio_exterior
// Params 2, eflags: 0x4
// Checksum 0x1c361c3b, Offset: 0x28a2
// Size: 0x5c
function private function_2c9da2856380dfe8( ent, trigger )
{
    level.scorpio_skel endon( #"scorpio_reached_end" );
    
    if ( isplayer( ent ) )
    {
        scorpio_interior::function_f9500965257e57b( ent );
        scorpio_interior::teleport_player( ent, "entrance", level.scorpio_skel.entrance_interact );
    }
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0x2e1e96be, Offset: 0x2906
    // Size: 0x5, Type: dev
    function function_f67515301fc949b()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0xbf47a4cb, Offset: 0x2913
// Size: 0xb0
function private function_3b8c62b55fd36d55()
{
    utility::flag_wait( "scorpio_setup_complete" );
    entrance_origin = level.scorpio_skel gettagorigin( "tag_portal" );
    scorpio_portal = spawn( "script_model", entrance_origin );
    scorpio_portal setmodel( "c_sat_scorpio_portal" );
    scorpio_portal linkto( level.scorpio_ents[ 4 ], "tag_origin", ( 0, 554, -498 ), ( 0, 0, -90 ) );
    scorpio_portal.is_portal = 1;
    scorpio_portal playloopsound( "evt_scorpio_back_door_portal_lp" );
    level.var_9209738322af425c[ level.var_9209738322af425c.size ] = scorpio_portal;
}

/#

    // Namespace scorpio_exterior
    // Params 0
    // Checksum 0xb2708cbf, Offset: 0x29cb
    // Size: 0x5, Type: dev
    function function_ae8c3bba5d9df2d3()
    {
        
    }

#/

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0x49d6a2de, Offset: 0x29d8
// Size: 0xdd
function private function_7acfd63b41d757a9()
{
    foreach ( var_44bb5e2d2f5251d7 in level.var_bf8d1e3625de37c0 )
    {
        if ( var_44bb5e2d2f5251d7.script_noteworthy == "scorpio_turret" )
        {
            turret = function_ceb255828490e916( var_44bb5e2d2f5251d7 );
            
            if ( isdefined( turret ) )
            {
                turret link_to_scorpio( var_44bb5e2d2f5251d7 );
                turret link_to_scorpio( var_44bb5e2d2f5251d7 );
                turret.turret_base link_to_scorpio( var_44bb5e2d2f5251d7 );
                level.var_3a70453ca82b19d3[ level.var_3a70453ca82b19d3.size ] = turret;
            }
        }
    }
}

// Namespace scorpio_exterior
// Params 1
// Checksum 0x21964ec, Offset: 0x2abd
// Size: 0x167
function function_ceb255828490e916( struct )
{
    spawndata = { #angles:struct.angles ?? ( 0, 0, 0 ), #targetname:"veh_sat_scorpio_turret_ob", #vehicletype:"veh_scorpio_turret_ob", #origin:struct.origin + ( 0, 0, 35 ) };
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    vehicle_tracking::register_instance( turret );
    vehicle_occupancy::register_instance( turret );
    turret_base = spawn( "script_model", struct.origin );
    turret_base setmodel( "j_turret_geo_base_high" );
    turret_base.angles = struct.angles ?? ( 0, 0, 0 );
    turret.turret_base = turret_base;
    turret setturretscriptcontrolled( 1, 0 );
    turret turret::function_9b1f535339c80a4();
    turret.maxhealth = turret.health;
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &scorpio_turret_handledeathdamage, &scorpio_turret_modifydamage, 1 );
    turret thread function_c16bfec9247f2e80();
    return turret;
}

// Namespace scorpio_exterior
// Params 1, eflags: 0x4
// Checksum 0xc99792e5, Offset: 0x2c2d
// Size: 0x148
function private scorpio_turret_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" )
    {
        explosivedamage = 1;
    }
    
    if ( isdefined( attacker ) )
    {
        guy = attacker.owner ?? attacker;
        
        if ( isplayer( guy ) )
        {
            eventinfo = { #var_ef32324b503188b8:1, #isdestroyedkillstreak:1 };
            guy thread points::doscoreevent( #"kill_ss_sentry_gun", objweapon, undefined, undefined, self, undefined, undefined, undefined, undefined, 0, eventinfo );
        }
    }
    
    self.var_24954f14e27b448d = 0;
    self.stopfiring = 1;
    self laseroff();
    self notify( #"kill_turret", explosivedamage, 1 );
}

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0x843eb57b, Offset: 0x2d7d
// Size: 0x6b
function private function_d4793041860abd74()
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    level.scorpio_skel endon( #"scorpio_reached_end" );
    
    while ( true )
    {
        currenthealth = self.maxhealth - self.damagetaken;
        
        if ( currenthealth < 0 )
        {
            currenthealth = 0;
        }
        
        self.var_cce7c67ea2da8902 = currenthealth;
        waitframe();
    }
}

// Namespace scorpio_exterior
// Params 1, eflags: 0x4
// Checksum 0xaf1b1da2, Offset: 0x2df0
// Size: 0xb0
function private scorpio_turret_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    
    if ( self.var_b712c270b3e6cfd4 && isdefined( attacker.team ) && self.team == attacker.team )
    {
        return 0;
    }
    
    return damage;
}

// Namespace scorpio_exterior
// Params 0, eflags: 0x4
// Checksum 0xed375b82, Offset: 0x2ea9
// Size: 0xd4
function private function_c16bfec9247f2e80()
{
    self waittill( #"kill_turret", skipshutdown, wasdestroyed );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    turret::function_9a0fa09f3acbc0cd();
    self setturretscriptcontrolled( 0, 0 );
    self setmodel( "j_turret_dest_geo_high_a" );
    self setcandamage( 0 );
    self setscriptablepartstate( "explode", "violent" );
    self playsound( "mp_equip_destroyed" );
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    wait 0.2;
    vehicle_tracking::deregister_instance( self );
    vehicle_occupancy::deregister_instance( self );
}

