// script_6e05fdc2c6f5fa06  (hash_6e05fdc2c6f5fa06.gscc) (size: 29178 Bytes / 0x71fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec1f101d (3961458717)
// size ...... 29178 (0x71fa)
// includes .. 28  (offset: 0x6e1e)
// strings ... 42  (offset: 0x6efe)
// dev strs .. 14  (offset: 0x7146)
// exports ... 76  (offset: 0x43d2)
// cseg ...... 0x368 + 0x406a (0x43d2)
// imports ... 253 (offset: 0x4fb2)
// animtree1 . 0   (offset: 0x71fa)
// animtree2 . 0   (offset: 0x71fa)
#using script_3ec57c71b0b61f00;
#using script_60cd1c57e94be8d7;
#using script_e9bca00ec07d3c6;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_tracking;
#using scripts\common\visibility_mode;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\vehicles\damage;
#using scripts\mp\weapons;
#using scripts\vehicle\vehicle_common;

#namespace namespace_cf9a4f547edbca10;

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x1
// Checksum 0xfcb8a54, Offset: 0x386
// Size: 0x18a
function autoexec main()
{
    utility::registersharedfunc( #"veh_sat_mil_vtol_ob_infil", #"spawn", &do_spawn_vtol );
    utility::registersharedfunc( #"veh_sat_mil_vtol_ob_infil", #"movetoposition", &move_to_position );
    utility::registersharedfunc( #"veh_sat_mil_vtol_ob_infil", #"infil", &do_infil );
    utility::registersharedfunc( #"veh_sat_mil_vtol_ob_infil", #"loadAI", &load_ai );
    utility::registersharedfunc( #"veh_sat_mil_vtol_ob_infil", #"setuprope", &setup_rope );
    utility::registersharedfunc( #"veh_sat_mil_vtol_ob_infil", #"movetounload", &function_f4fb1090a77230c8 );
    utility::registersharedfunc( %"hash_1fd2d0a3dbca690", #"spawn", &vtol_create );
    utility::registersharedfunc( %"hash_3a781e40677af73e", #"spawn", &vtol_create );
    utility::registersharedfunc( %"hash_3de08ee4ce53144f", #"spawn", &vtol_create );
    utility::registersharedfunc( %"hash_7b283a59c4bf1a92", #"spawn", &vtol_create );
    level.ob_air_traffic = {};
    level.ob_air_traffic.var_2c075fa23c46910f = [];
    function_e8d02650e81ea5b8( "vtol", 750 );
    function_e8d02650e81ea5b8( "vtol_default_spawn", ( 0, 0, 3000 )[ 2 ] );
    
    /#
        function_e6b1b8630b567f84();
    #/
    
    level thread post_init();
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0x5167b938, Offset: 0x518
// Size: 0x24
function private post_init()
{
    wait 1;
    level.vehicle.aianimthread[ "unload" ] = &guy_unload_ob;
}

// Namespace namespace_cf9a4f547edbca10
// Params 2
// Checksum 0x11585d6f, Offset: 0x544
// Size: 0x32
function guy_unload_ob( guy, pos )
{
    if ( vehicle::ishelicopter() )
    {
        guy thread function_b9592a3ecabfa233( self );
    }
    
    vehicle_aianim::guy_unload( guy, pos );
}

// Namespace namespace_cf9a4f547edbca10
// Params 2
// Checksum 0xa7e79616, Offset: 0x57e
// Size: 0x89
function vtol_create( spawndata, faildata )
{
    vehiclebundle = spawndata.script_vehiclebundle ?? %"hash_1fd2d0a3dbca690";
    vehicle = vehicle::default_spawn( vehiclebundle, spawndata, faildata );
    
    if ( !vehicle )
    {
        return;
    }
    
    var_ae6be251b85688c8 = vehicle_damage::get_instance_data( vehicle, 1 );
    var_ae6be251b85688c8.destroyscoreevent = #"kill_ss_vtol_warship";
    vehicle.var_e038900b11ddf286 = undefined;
    return vehicle;
}

/#

    // Namespace namespace_cf9a4f547edbca10
    // Params 0, eflags: 0x4
    // Checksum 0x2afc0591, Offset: 0x610
    // Size: 0x5a, Type: dev
    function private function_e6b1b8630b567f84()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x4f>", &function_d0d26991821693ec );
        devgui::function_cd4e263c1f3018ae( "<dev string:x64>", "<dev string:x83>", &function_abc2dbbca0b0d93e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9e>", "<dev string:xbe>", &function_abc2dbbca0b0d93e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_cf9a4f547edbca10
    // Params 0, eflags: 0x4
    // Checksum 0xfcce1da4, Offset: 0x672
    // Size: 0x13e, Type: dev
    function private function_d0d26991821693ec()
    {
        objweapon = undefined;
        
        foreach ( player in level.players )
        {
            objweapon = player getcurrentprimaryweapon();
            
            if ( objweapon )
            {
                break;
            }
        }
        
        data = { #objweapon:objweapon };
        vtols = level.vehicle.instances[ %"hash_1fd2d0a3dbca690" ];
        
        foreach ( vtol in vtols )
        {
            vtol handle_death_damage( data );
        }
    }

    // Namespace namespace_cf9a4f547edbca10
    // Params 1, eflags: 0x4
    // Checksum 0x2707f818, Offset: 0x7b8
    // Size: 0xca, Type: dev
    function private function_abc2dbbca0b0d93e( params )
    {
        applycamo = int( params[ 0 ] );
        vtols = level.vehicle.instances[ %"hash_1fd2d0a3dbca690" ];
        
        foreach ( vtol in vtols )
        {
            if ( applycamo )
            {
                vtol apply_camo();
                continue;
            }
            
            vtol remove_camo();
        }
    }

#/

// Namespace namespace_cf9a4f547edbca10
// Params 0
// Checksum 0x2858baa5, Offset: 0x88a
// Size: 0x7a
function function_879241d6eca278b()
{
    data = spawnstruct();
    data.spawn = &spawn_vtol;
    data.flyaway = &vtol_flyaway;
    data.startattacking = &start_attacking;
    data.stopattacking = &stop_attacking;
    data.var_2f436ee6869ef2b2 = &init_objective_icon_intro;
    data.switchtarget = &switch_target;
    return data;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x5affbe3d, Offset: 0x90d
// Size: 0xb4
function private spawn_vtol( spawnoptions )
{
    vtol = do_spawn_vtol( spawnoptions );
    vtol.activityinstance = self;
    vtol switch_target( spawnoptions.target );
    vtol thread function_a25c39c6bcbf71a3();
    
    if ( vtol.isattacking )
    {
        vtol start_attacking();
    }
    
    self.flaresreservecount = 1;
    self.flareslive = [];
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        self thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &function_c0285cde66c160af );
    }
    
    return vtol;
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xe48c41bf, Offset: 0x9ca
// Size: 0x23
function private start_attacking()
{
    self.isattacking = 1;
    thread function_e01f518754e7716b();
    thread missiles_think();
    weapons::function_ef0cb557b1a93af9( self );
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xe9bc445, Offset: 0x9f5
// Size: 0x20
function private stop_attacking()
{
    self.isattacking = 0;
    self notify( #"stop_attacking" );
    weapons::function_d5eafafe8f6a97bf( self );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x6b040370, Offset: 0xa1d
// Size: 0x4c7
function private do_spawn_vtol( spawnoptions )
{
    if ( !level.var_209035fc1e63a988 )
    {
        level.var_209035fc1e63a988 = utility::getstructarray( "heli_reinforceNode", "script_noteworthy" );
    }
    
    spawnnode = spawnoptions.spawnnode;
    
    if ( !spawnnode )
    {
        spawnpoint = spawnoptions.spawnpoint ?? ( 0, 0, 3000 );
        node = function_47c86977a18df38b( level.var_209035fc1e63a988, spawnpoint );
        spawnnode = {};
        spawnnode.origin = node.origin;
        spawnnode.angles = node.angles;
        spawnnode.targetname = "boatdrive_apache";
    }
    
    var_6434572d2f2dc708 = spawnoptions.var_6434572d2f2dc708 ?? %"hash_3a781e40677af73e";
    spawnnode.vehicletype = var_6434572d2f2dc708;
    faildata = {};
    
    if ( activity_instance_common::isactivityinstance( self ) )
    {
        vtol = ob_resource_manager::activity_spawn_vehicle( var_6434572d2f2dc708, spawnnode, faildata );
    }
    else
    {
        vtol = namespace_37f5741ccbccb7a::ai_spawn_director_heli_spawn( spawnnode, spawnoptions.is_landed, spawnoptions.vehicle_ref, spawnoptions.var_b3d18d4778197ab5, spawnoptions.heli_team, spawnoptions.model_name, spawnoptions.skinoverride, spawnoptions.requestid );
    }
    
    vehicleref = spawnoptions.vehicle_ref;
    vtol.vehiclename = var_6434572d2f2dc708;
    vehiclebundledata = level.var_a7bf93687486b5ba[ vehicleref ];
    vtolhealth = spawnoptions.maxhealth ?? vehiclebundledata.damage.health ?? 7500;
    
    /#
        vtolhealth = getdvarint( @"hash_f74db18ed5e33e45", vtolhealth );
    #/
    
    vtol.maxhealth = vtolhealth;
    vtol.health = vtolhealth;
    vtol.currenthealth = vtolhealth;
    vtol.var_24954f14e27b448d = spawnoptions.var_24954f14e27b448d;
    healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_6ed4fde0ed0bcf9b" );
    vtol.healthbarsettingsid = healthbarsettingsid;
    vtol.isattacking = spawnoptions.isattacking;
    vtol.var_76d248a3f9ee1e4f = spawnoptions.var_76d248a3f9ee1e4f ?? 0;
    vtol.var_cec48ccf7bfb7369 = spawnoptions.var_cec48ccf7bfb7369;
    vtol.var_606f01dce2492f65 = spawnoptions.var_606f01dce2492f65;
    vtol.team = "team_hundred_ninety";
    vtol setvehicleteam( "team_hundred_ninety" );
    vehicle_tracking::register_instance( vtol, undefined, vtol.team );
    vtol vehicle_damage::set_can_damage( 1 );
    vtol.var_300686ebe3a78e39 = 1;
    vtol damage::set_pre_mod_damage_callback( var_6434572d2f2dc708, &function_f71676731e45c6a6 );
    vtol damage::set_post_mod_damage_callback( var_6434572d2f2dc708, &function_49f3b0d251ebaeef );
    vtol damage::set_death_callback( var_6434572d2f2dc708, &function_b68424a3a74c409d );
    vtol function_d2b8ee2e1275daaf( 1 );
    
    if ( node )
    {
        vtol.exitnode = node;
    }
    
    vtol.missileweapon = makeweapon( "sat_vtol_warship_proj_ob" );
    vtol.damagestate = 0;
    vtol forcenetfieldhighlod( 1 );
    
    if ( spawnoptions.var_7b27ef0169596da0 )
    {
        vtol apply_camo();
    }
    else
    {
        vtol thread init_scriptable( 1 );
    }
    
    if ( !spawnoptions.var_d4114f8808b68804 )
    {
        vtol.explosiondamageradius = spawnoptions.explosiondamageradius ?? 1000;
        vtol.var_4a4d2097381a687e = spawnoptions.var_4a4d2097381a687e ?? 100;
        vtol.var_4a7112973842c46c = spawnoptions.var_4a7112973842c46c ?? 10;
        vtol.var_448a00c5d2e5ba91 = spawnoptions.var_448a00c5d2e5ba91 ?? 0.4;
        vtol.var_d64e578d70d2ecd0 = spawnoptions.var_d64e578d70d2ecd0 ?? 2.5;
    }
    
    vehicleref = vtol vehicle::get_ref();
    vtol thread function_d041234dab436269();
    
    if ( spawnoptions.hashighvis )
    {
        vtol.var_521099eccef67894 = 1;
        visibility_mode::function_3afc3bc470c80e61( vtol, vtol.team );
        level notify( #"highvis_reload_outline", vtol.team, [ vtol ] );
    }
    
    vtol.var_8839162ef17bfbc1 = 1;
    return vtol;
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xce68c4e0, Offset: 0xeed
// Size: 0x2e
function private function_d041234dab436269()
{
    level endon( #"game_ended" );
    self endon( #"vehicle_deleted" );
    self waittill( #"death" );
    delete_vtol();
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x1aaebc9c, Offset: 0xf23
// Size: 0x4e
function private function_e70db9994ed1a9b6( vehicleref, stateref )
{
    leveldatafordamagestate = vehicle_damage::function_9a9c7f377e631a4d( vehicleref, stateref, 1 );
    leveldatafordamagestate.onentercallback = &function_ee5b785cbdc4da5e;
    leveldatafordamagestate.onexitcallback = &function_ee5b785cbdc4da5e;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x14baf04, Offset: 0xf79
// Size: 0x45
function private switch_target( newtarget )
{
    if ( !newtarget || !newtarget.origin || self.health <= 0 )
    {
        return;
    }
    
    self.targetedentity = newtarget;
    self setlookatent( newtarget );
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x74331716, Offset: 0xfc6
// Size: 0x15
function private function_ee5b785cbdc4da5e( oldstateref, data )
{
    
}

// Namespace namespace_cf9a4f547edbca10
// Params 1
// Checksum 0xa99d22dc, Offset: 0xfe3
// Size: 0x29
function function_495220db898177a0( value )
{
    namespace_7161222aac9ca916::function_bfaacd2d206fbda3( value );
    self.var_c3c4d711e69d5ab9 = value;
    function_d1d702405f01f1f0( value );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0xfd21d294, Offset: 0x1014
// Size: 0x5b
function private function_d1d702405f01f1f0( value )
{
    if ( self.is_shield_activated == value )
    {
        return;
    }
    
    self.is_shield_activated = value;
    scriptable_state = self.is_shield_activated ? "shield_fx_activate" : "shield_fx_deactivate";
    self setscriptablepartstate( "shield", scriptable_state, 1 );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1
// Checksum 0xcfc0a8ed, Offset: 0x1077
// Size: 0x83, Type: bool
function function_43ac45f2bf4fe748( origin )
{
    forwarddot = vectordot( vectornormalize( origin - self.origin ), anglestoforward( self.angles ) );
    downdot = vectordot( vectornormalize( origin - self.origin ), -1 * anglestoup( self.angles ) );
    return forwarddot > 0.258819 && downdot > 0 || downdot > 0.95;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x2d709c74, Offset: 0x1103
// Size: 0x6f, Type: bool
function private function_ae5efa8add232784( origin )
{
    forwarddot = vectordot( vectornormalize( origin - self.origin ), anglestoforward( self.angles ) );
    downdot = vectordot( vectornormalize( origin - self.origin ), -1 * anglestoup( self.angles ) );
    return forwarddot > 0.4;
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x1ebc418d, Offset: 0x117b
// Size: 0x34, Type: bool
function private is_within_range( origin, range )
{
    dist = distance2d( self.origin, origin );
    return dist < range;
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0x3f800795, Offset: 0x11b8
// Size: 0xc5
function private function_e01f518754e7716b()
{
    self endon( #"death" );
    self endon( #"flyaway" );
    self endon( #"crashing" );
    self endon( #"stop_attacking" );
    self endon( #"explode" );
    
    while ( true )
    {
        target = self.targetedentity;
        
        if ( target )
        {
            self setturrettargetvec( target.origin );
            self setturretscriptcontrolled( 1, 0 );
            self setturretaispread( 2.5 );
            
            if ( is_within_range( target.origin, 3000 ) && function_43ac45f2bf4fe748( target.origin ) )
            {
                function_12afeddc73d1dda4( target, randomfloatrange( 6, 7 ) );
            }
        }
        
        wait 3;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0x13c00889, Offset: 0x1285
// Size: 0x8e
function private missiles_think()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    self endon( #"stop_attacking" );
    
    while ( true )
    {
        target = self.targetedentity;
        
        if ( target )
        {
            if ( is_within_range( target.origin, 5000 ) && function_ae5efa8add232784( target.origin ) )
            {
                shoot_missiles( target, 4 );
            }
        }
        
        wait 6;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 2
// Checksum 0xceb9bf49, Offset: 0x131b
// Size: 0x4c
function function_12afeddc73d1dda4( target, time )
{
    self endon( #"death" );
    self endon( #"crashing" );
    
    if ( !target )
    {
        return;
    }
    
    thread turret_shoot_at_target( target );
    wait time;
    self notify( #"stop_shooting" );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1
// Checksum 0xbff42b30, Offset: 0x136f
// Size: 0x18f
function turret_shoot_at_target( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    self endon( #"stop_shooting" );
    self endon( #"stop_attacking" );
    attackradius = 50;
    var_2c5451aab99e9240 = 0;
    shotcount = 0;
    
    if ( self.var_b3dff6739efc2294 )
    {
        attackradius = self.var_b3dff6739efc2294;
    }
    
    while ( true )
    {
        if ( !target || target.health <= 0 )
        {
            return;
        }
        
        if ( isdefined( self.var_a648afea39238b85 ) )
        {
            centerpoint = target.origin;
        }
        else
        {
            centerpoint = target.origin + ( 0, 0, 50 );
        }
        
        randdist = randomint( attackradius ) + var_2c5451aab99e9240;
        randangle = randomint( 360 );
        x = centerpoint[ 0 ] + randdist * cos( randangle );
        y = centerpoint[ 1 ] + randdist * sin( randangle );
        z = centerpoint[ 2 ];
        point = ( x, y, z );
        offset = point - target.origin;
        self setturrettargetent( target, offset );
        
        while ( self function_7cc4e445cca9566f( 0 ) != 1 )
        {
            waitframe();
        }
        
        self requestfireweapon( 0 );
        shotcount++;
        waitframe();
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 2
// Checksum 0xb91b9805, Offset: 0x1506
// Size: 0x257
function shoot_missiles( target, missilecount )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    missiletags = [ "tag_fx_missiles_right", "tag_fx_rockets_right", "tag_fx_missiles_left", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_4", "fire_missile_1", "fire_missile_1" ];
    wait 1;
    shots = 0;
    
    while ( shots < missilecount )
    {
        if ( !target )
        {
            break;
        }
        
        var_ad9e617e3c1fb0aa = self gettagorigin( missiletags[ 1 ] );
        targetpos = target.origin;
        var_606d7606836b794 = vectornormalize( var_ad9e617e3c1fb0aa - targetpos );
        targetpitch = vectortopitch( var_606d7606836b794 * -1 );
        var_f0bdade03f04e976 = ( targetpitch + 5, self.angles[ 1 ], self.angles[ 2 ] );
        var_fb87996113bb6bd9 = anglestoforward( var_f0bdade03f04e976 );
        var_614260aaf8f69a08 = var_ad9e617e3c1fb0aa + var_fb87996113bb6bd9 * 50;
        var_5d88509d1ece9b99 = var_ad9e617e3c1fb0aa + var_fb87996113bb6bd9 * 500;
        missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
        self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
        wait 0.5;
        var_e102635e44e9e649 = self gettagorigin( missiletags[ 3 ] );
        targetpos = target.origin;
        var_5bab3eff246dd10b = vectornormalize( var_e102635e44e9e649 - targetpos );
        targetpitch = vectortopitch( var_5bab3eff246dd10b * -1 );
        var_f0bdade03f04e976 = ( targetpitch + 5, self.angles[ 1 ], self.angles[ 2 ] );
        var_fb87996113bb6bd9 = anglestoforward( var_f0bdade03f04e976 );
        var_baece2beb8c3f959 = var_e102635e44e9e649 + var_fb87996113bb6bd9 * 50;
        var_8cac471c45ae8448 = var_e102635e44e9e649 + var_fb87996113bb6bd9 * 500;
        missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
        self setscriptablepartstate( missilestates[ 3 ], "on", 0 );
        wait 0.5;
        shots += 2;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 7, eflags: 0x4
// Checksum 0xb98656f3, Offset: 0x1765
// Size: 0x248
function private function_a25c39c6bcbf71a3( updaterate, followdistance, neardistance, fardistance, followspeed, followaccel, followdecel )
{
    self endon( #"death", #"crashing", #"flyaway", #"entitydeleted" );
    
    if ( !isdefined( updaterate ) )
    {
        updaterate = 0.5;
    }
    
    if ( !isdefined( followdistance ) )
    {
        followdistance = 1500;
    }
    
    if ( !isdefined( neardistance ) )
    {
        neardistance = 2500;
    }
    
    if ( !isdefined( fardistance ) )
    {
        fardistance = 5000;
    }
    
    if ( !isdefined( followspeed ) )
    {
        followspeed = 100;
    }
    
    if ( !isdefined( followaccel ) )
    {
        followaccel = 50;
    }
    
    if ( !isdefined( followdecel ) )
    {
        followdecel = 50;
    }
    
    self setmaxpitchroll( 10, 10 );
    self setneargoalnotifydist( 150 );
    self sethoverparams( 50, 50, 50 );
    set_speed( followspeed, followaccel, followdecel );
    
    while ( true )
    {
        wait updaterate;
        target = self.targetedentity;
        
        if ( !target )
        {
            thread vtol_flyaway();
            return;
        }
        
        utility::function_7c10ea82c1e305b8( #"thrusters", #"dynamic" );
        distance = distance2d( target.origin, self.origin );
        var_1b7fa4c908a6e55 = distance > fardistance;
        self.isneartarget = distance <= neardistance && self.origin[ 2 ] > target.origin[ 2 ];
        
        if ( !self.isneartarget || self.var_5b86416d469f0dc4 )
        {
            followpos = target.origin - anglestoforward( ( 0, target.angles[ 1 ], 0 ) ) * followdistance;
            
            if ( var_1b7fa4c908a6e55 )
            {
                forwardvector = vectornormalize2( target.origin - self.origin );
                followpos = self.origin + forwardvector * followdistance;
            }
            
            var_ef5cd1cc12144e26 = clamp( followpos[ 2 ] + 750, 750, 5000 );
            followpos = ( followpos[ 0 ], followpos[ 1 ], var_ef5cd1cc12144e26 );
            
            if ( self.var_cec48ccf7bfb7369 )
            {
                followpos = function_fdbdb59ab54e8448( followpos );
            }
            
            thread move_to_position( followpos, !var_1b7fa4c908a6e55, 50, 1 );
        }
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x6024c416, Offset: 0x19b5
// Size: 0x13d
function private function_fdbdb59ab54e8448( goalpos )
{
    var_6baa30c654bd4a0d = 0;
    candidategoalpos = goalpos;
    self.var_5b86416d469f0dc4 = 0;
    
    while ( true )
    {
        obstructiontrace = trace::sphere_trace( self.origin, candidategoalpos, 300, [ self ], undefined, 1 );
        tracepassed = obstructiontrace[ "hittype" ] == "hittype_none";
        
        /#
            if ( getdvarint( @"hash_3c165272d6d3919", 0 ) )
            {
                debugcolor = tracepassed ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                var_ad499299bfcf0216 = 100;
                sphere( self.origin, 300, debugcolor, undefined, var_ad499299bfcf0216 );
                line( self.origin, candidategoalpos, debugcolor, 1, undefined, var_ad499299bfcf0216 );
                sphere( candidategoalpos, 300, debugcolor, undefined, var_ad499299bfcf0216 );
            }
        #/
        
        if ( tracepassed )
        {
            return candidategoalpos;
        }
        
        wait 0.5;
        
        if ( var_6baa30c654bd4a0d >= 10 )
        {
            goalpos = function_edc90ef27700de12();
            var_6baa30c654bd4a0d = 0;
        }
        
        candidategoalpos = function_f5303f6299f7898c( goalpos, 300, var_6baa30c654bd4a0d );
        var_6baa30c654bd4a0d++;
        self.var_5b86416d469f0dc4 = 1;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xa36baede, Offset: 0x1afa
// Size: 0x55
function private function_edc90ef27700de12()
{
    randomangle = randomfloat( 6.28318 );
    randomradius = sqrt( randomfloatrange( squared( 400 ), squared( 1000 ) ) );
    return self.origin + ( cos( randomangle ) * randomradius, sin( randomangle ) * randomradius, 0 );
}

// Namespace namespace_cf9a4f547edbca10
// Params 3, eflags: 0x4
// Checksum 0xa694de05, Offset: 0x1b58
// Size: 0x10c
function private function_f5303f6299f7898c( goalpos, circleradius, incrementfactor )
{
    forwardvector = vectornormalize2( anglestoforward( self.angles ) );
    leftvector = vectornormalize2( anglestoleft( self.angles ) );
    goalposdirection = vectornormalize2( goalpos - self.origin );
    var_92da6c5040d38ae0 = vectordot( leftvector, goalposdirection );
    rotationsign = var_92da6c5040d38ae0 > 0 ? -1 : 1;
    rotationangle = 15 * incrementfactor + 180 * rotationsign;
    rotationangles = vectortoangles( self.origin ) + ( 0, rotationangle, 0 );
    var_807b4078fba6fa20 = rotatevector( forwardvector, rotationangles );
    var_aa39f9e050db9a37 = vectortoangles( var_807b4078fba6fa20 );
    newgoalpos = self.origin + anglestoforward( var_aa39f9e050db9a37 ) * 1500;
    return newgoalpos;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x9f91bc52, Offset: 0x1c6d
// Size: 0x66, Type: bool
function private function_f71676731e45c6a6( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) && isdefined( self.turret ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            if ( attacker.owner == self )
            {
                return false;
            }
        }
        
        return ( attacker != self.turret );
    }
    
    return true;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x4222b046, Offset: 0x1cdc
// Size: 0x10f, Type: bool
function private function_49f3b0d251ebaeef( data )
{
    if ( namespace_7161222aac9ca916::function_bcc82514dd1dd6ff() )
    {
        data.damage = 0;
        
        if ( data.attacker && isplayer( data.attacker ) )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, "tag_origin", undefined, undefined, 0, data.point, 1, undefined, undefined, undefined, undefined );
        }
    }
    else
    {
        if ( self.var_76d248a3f9ee1e4f && data.attacker && isplayer( data.attacker ) )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( data.attacker, self, data.hitloc, data.meansofdeath, data.objweapon, int( data.damage ), data.point, 0, undefined, 0, 0 );
        }
        
        function_923fcd3a277b1e00( data );
        damage_utility::function_723dcec170ec23be( data.attacker );
    }
    
    return true;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x91475193, Offset: 0x1df4
// Size: 0x179
function private function_923fcd3a277b1e00( data )
{
    thrusterradius = 125;
    var_33b5b37d59099f58 = thrusterradius * 0.5;
    var_c7beb966f4f78b7f = thrusterradius * thrusterradius;
    tagoffset = anglestoright( self.angles ) * var_33b5b37d59099f58;
    var_f7620ec70e55c31e = self gettagorigin( "tag_engine_ri_rotate_animate" ) + tagoffset;
    var_f76218c70e55d91c = self gettagorigin( "tag_engine_le_rotate_animate" ) - tagoffset;
    
    /#
        var_4a177ab31c96cdef = getdvarint( @"hash_c9c5ab8ba6684356", 0 ) == 1;
    #/
    
    var_9a7859ec3774529a = getdvarfloat( @"hash_249bdfb019027017", 2 );
    
    if ( distancesquared( data.point, var_f7620ec70e55c31e ) < var_c7beb966f4f78b7f )
    {
        /#
            if ( var_4a177ab31c96cdef )
            {
                sphere( var_f7620ec70e55c31e, thrusterradius, ( 1, 1, 1 ), 1, 300 );
                iprintlnbold( "<dev string:xd9>" );
            }
        #/
        
        data.damage *= var_9a7859ec3774529a;
        return;
    }
    
    if ( distancesquared( data.point, var_f76218c70e55d91c ) < var_c7beb966f4f78b7f )
    {
        /#
            if ( var_4a177ab31c96cdef )
            {
                sphere( var_f76218c70e55d91c, thrusterradius, ( 1, 1, 1 ), 1, 300 );
                iprintlnbold( "<dev string:xe0>" );
            }
        #/
        
        data.damage *= var_9a7859ec3774529a;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x36bf1fc2, Offset: 0x1f75
// Size: 0x32, Type: bool
function private function_b68424a3a74c409d( data )
{
    if ( isdefined( self.var_3a79afe576bae9 ) )
    {
        [[ self.var_3a79afe576bae9 ]]( data );
    }
    
    thread handle_death_damage( data );
    return true;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0xeca0738e, Offset: 0x1fb0
// Size: 0x85
function private handle_death_damage( data )
{
    if ( !isdefined( self ) || self.var_13a0597ddc1a09b2 )
    {
        return;
    }
    
    self endon( #"death", #"entitydeleted" );
    self notify( #"crashing" );
    self.var_13a0597ddc1a09b2 = 1;
    thread remove_camo();
    
    if ( vtol_crash( 150, data.objweapon ) )
    {
        utility::waittill_any_timeout( 2, "ready_to_explode", "collision" );
    }
    
    thread vtol_explode( data );
}

// Namespace namespace_cf9a4f547edbca10
// Params 4, eflags: 0x4
// Checksum 0x94dbfc58, Offset: 0x203d
// Size: 0xc2
function private function_66dcfcc8f21a8603( crashstart, crashdist, jetforward, jetright )
{
    var_20ab34c906cea752 = [ crashstart + jetforward * crashdist, crashstart - jetforward * crashdist, crashstart + jetright * crashdist, crashstart - jetright * crashdist, crashstart + 0.707 * crashdist * ( jetforward + jetright ), crashstart + 0.707 * crashdist * ( jetforward - jetright ), crashstart + 0.707 * crashdist * ( jetright - jetforward ), crashstart + 0.707 * crashdist * ( -1 * jetforward - jetright ) ];
    var_92fac1512f91a7c3 = arrayrandomize( var_20ab34c906cea752 );
    return var_92fac1512f91a7c3;
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x922eb945, Offset: 0x2108
// Size: 0x1ff
function private function_fd0d698b5bed3d27( var_28bb32c02dd73cad, var_e37664792fc10e9f )
{
    crashstart = self.origin;
    jetforward = anglestoforward( self.angles );
    jetright = anglestoright( self.angles );
    crashdist = var_28bb32c02dd73cad;
    
    while ( crashdist <= var_e37664792fc10e9f )
    {
        if ( self.var_c93e8f2f2f75907f.angle )
        {
            var_92fac1512f91a7c3 = [ crashstart + crashdist * self.var_c93e8f2f2f75907f.angle ];
        }
        else
        {
            var_92fac1512f91a7c3 = function_66dcfcc8f21a8603( crashstart, crashdist, jetforward, jetright );
        }
        
        foreach ( crashend in var_92fac1512f91a7c3 )
        {
            var_dad77806dcda6f40 = utility::drop_to_ground( crashend );
            watercontents = trace::function_bbd81e56529ef225();
            waterhit = trace::ray_trace( crashstart, var_dad77806dcda6f40, self, watercontents );
            var_9448f97caa72f79f = trace::ray_trace_passed( crashstart, var_dad77806dcda6f40, self );
            
            if ( waterhit && waterhit[ "hittype" ] != "hittype_none" || !var_9448f97caa72f79f )
            {
                /#
                    if ( getdvarint( @"scr_vtol_crash_debug", 0 ) == 1 )
                    {
                        line( crashstart, var_dad77806dcda6f40, ( 1, 0, 0 ), 1, 1, 400 );
                    }
                #/
                
                continue;
            }
            
            /#
                if ( getdvarint( @"scr_vtol_crash_debug", 0 ) == 1 )
                {
                    line( crashstart, var_dad77806dcda6f40, ( 0, 1, 0 ), 1, 1, 400 );
                }
            #/
            
            return var_dad77806dcda6f40;
        }
        
        crashdist += 100;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x2349829a, Offset: 0x2310
// Size: 0x155, Type: bool
function private vtol_crash( speed, weaponkilledby )
{
    self clearlookatent();
    utility::function_7c10ea82c1e305b8( #"engine", #"off" );
    utility::function_7c10ea82c1e305b8( #"blinking_lights", #"on" );
    utility::function_7c10ea82c1e305b8( #"engine_explosion", #"on" );
    
    if ( self.var_c93e8f2f2f75907f )
    {
        set_speed( self.var_c93e8f2f2f75907f.speed, self.var_c93e8f2f2f75907f.acceleration, self.var_c93e8f2f2f75907f.deceleration );
    }
    else
    {
        set_speed( speed, 30, 60 );
        self setmaxpitchroll( 10, 25 );
    }
    
    glassdamagestate = #"missile_damage";
    
    if ( weaponkilledby && weapon_utility::isbulletweapon( weaponkilledby ) )
    {
        glassdamagestate = #"bullet_damage";
    }
    
    self setscriptablepartstate( #"glass", glassdamagestate, 0 );
    var_61f902b2dd6fc262 = function_fd0d698b5bed3d27( 1280, 4000 );
    
    if ( !var_61f902b2dd6fc262 )
    {
        return false;
    }
    
    self function_d2b8ee2e1275daaf( 0 );
    thread move_to_position( var_61f902b2dd6fc262, 0, 5, 0 );
    thread function_cccd4d46d31f96aa( var_61f902b2dd6fc262 );
    thread vtol_spinout( speed );
    return true;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x3792b3ff, Offset: 0x246e
// Size: 0x52
function private vtol_spinout( speed )
{
    self endon( #"death" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.4 );
        wait 0.5;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x3ac7295c, Offset: 0x24c8
// Size: 0xa4
function private function_cccd4d46d31f96aa( var_61f902b2dd6fc262 )
{
    self endon( #"death" );
    activityinstance = self.activityinstance;
    
    if ( activityinstance )
    {
        activityinstance endon( #"activity_ended" );
        activityinstance endon( #"instance_destroyed" );
    }
    
    waitframe();
    
    for ( var_6100f7d0b1061bbd = distance( self.origin, var_61f902b2dd6fc262 ); true ; var_6100f7d0b1061bbd = var_b4b6a32e269bef7e )
    {
        waitframe();
        var_b4b6a32e269bef7e = distance( self.origin, var_61f902b2dd6fc262 );
        
        if ( var_6100f7d0b1061bbd - var_b4b6a32e269bef7e <= 0 )
        {
            self notify( #"ready_to_explode" );
            break;
        }
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x38364eec, Offset: 0x2574
// Size: 0xe3
function private vtol_explode( data )
{
    self endon( #"death", #"entitydeleted" );
    self notify( #"explode" );
    
    if ( self.explosiondamageradius )
    {
        self radiusdamage( self.origin, self.explosiondamageradius, self.var_4a4d2097381a687e, self.var_4a7112973842c46c, self, "MOD_EXPLOSIVE" );
        earthquake( self.var_448a00c5d2e5ba91, self.var_d64e578d70d2ecd0, self.origin, self.explosiondamageradius );
    }
    
    self setscriptablepartstate( #"explode", #"on", 0 );
    self setscriptablepartstate( #"explode_smoke", #"on", 0 );
    wait 0.35;
    callback::callback( #"hash_5f04bed91965f0ec", data );
    delete_vtol();
}

// Namespace namespace_cf9a4f547edbca10
// Params 4, eflags: 0x4
// Checksum 0x938ce91f, Offset: 0x265f
// Size: 0x116
function private function_c0285cde66c160af( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            missiletarget.flaresreservecount--;
            missiletarget thread function_497b8e3a540cbade( fxtagoverride );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self.var_458d8d6ca334fa52 = 1;
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            level notify( #"flares", player );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0xb92d7bcc, Offset: 0x277d
// Size: 0x4b
function private function_497b8e3a540cbade( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xd426c8b6, Offset: 0x27d0
// Size: 0x95
function private vtol_flyaway()
{
    if ( !isent( self ) )
    {
        return;
    }
    
    self endon( #"death", #"crashing", #"entitydeleted" );
    
    if ( self.flyingaway )
    {
        return;
    }
    
    self notify( #"flyaway" );
    self clearlookatent();
    self.flyingaway = 1;
    set_speed( 80, 25, 25 );
    move_to_position( self.exitnode.origin, 1, 50, 1 );
    self waittill( #"near_goal" );
    delete_vtol();
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0x126cb43b, Offset: 0x286d
// Size: 0xb7
function private function_b2b43817a8b0212b()
{
    if ( self.turret )
    {
        self.turret setentityowner( undefined );
        
        if ( self.turret.firetarget )
        {
            self.turret.firetarget delete();
        }
    }
    
    if ( self.var_795c9a23417e649c )
    {
        self.var_795c9a23417e649c setentityowner( undefined );
        self.var_795c9a23417e649c delete();
    }
    
    if ( self.var_bf973a4d1cadadc9 )
    {
        self.var_bf973a4d1cadadc9 setentityowner( undefined );
        self.var_bf973a4d1cadadc9 delete();
    }
    
    if ( self.var_dc64ea91291dad76 )
    {
        self.var_dc64ea91291dad76 delete();
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xa8f1d3b1, Offset: 0x292c
// Size: 0x2f
function private delete_vtol()
{
    if ( !isdefined( self ) || self.is_deleting )
    {
        return;
    }
    
    self.is_deleting = 1;
    function_b2b43817a8b0212b();
    namespace_37f5741ccbccb7a::ai_spawn_director_heli_cleanup();
}

// Namespace namespace_cf9a4f547edbca10
// Params 6, eflags: 0x4
// Checksum 0x3c27d567, Offset: 0x2963
// Size: 0x103
function private function_f4fb1090a77230c8( goalpos, goalyaw, speed = undefined, accel = undefined, decel = undefined, airresistance = undefined )
{
    self endon( #"death" );
    self endon( #"crashing" );
    speed = speed ?? 100;
    speed = max( speed, 100 );
    accel = accel ?? 50;
    decel = decel ?? 50;
    set_speed( speed, accel, decel );
    
    if ( isdefined( airresistance ) )
    {
        self setairresistance( airresistance );
    }
    
    self setgoalyaw( goalyaw );
    self setvehgoalpos( goalpos, 1 );
    self sethoverparams( 0, 0, 0 );
    self setneargoalnotifydist( 50 );
    utility::waittill_any( "goal", "near_goal", "begin_evasive_maneuvers" );
    self sethoverparams( 50, 5, 2.5 );
    self cleargoalyaw();
    self cleartargetyaw();
}

// Namespace namespace_cf9a4f547edbca10
// Params 5, eflags: 0x4
// Checksum 0x94d943df, Offset: 0x2a6e
// Size: 0x1cc
function private move_to_position( goalpos = self.origin, stopatgoal = 1, var_5197ba25f206c925 = 50, var_8c4b378b85ff60f6 = 1, goalyaw = undefined )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self setneargoalnotifydist( var_5197ba25f206c925 );
    desiredheight = goalpos[ 2 ];
    
    if ( var_8c4b378b85ff60f6 )
    {
        desiredheight = get_desired_height( goalpos[ 0 ], goalpos[ 1 ], 50 );
        
        if ( self.var_606f01dce2492f65 )
        {
            desiredheight = max( desiredheight, goalpos[ 2 ] );
        }
    }
    
    finalgoalpos = ( goalpos[ 0 ], goalpos[ 1 ], desiredheight );
    
    if ( !goalyaw )
    {
        goalyaw = vectortoyaw( finalgoalpos - self.origin );
    }
    
    /#
        if ( getdvarint( @"hash_3c165272d6d3919", 0 ) )
        {
            start_pos = self.previousgoalpos ?? self.origin;
            end_pos = finalgoalpos;
            debug::line( start_pos, end_pos, undefined, 20, "<dev string:xe6>" );
            last_radius = 10;
            debug::sphere( start_pos, last_radius, ( 0, 1, 0 ), 20, "<dev string:xe6>" );
            goal_color = stopatgoal ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            debug::sphere( start_pos, 10, goal_color, 20, "<dev string:xe6>" );
            self.previousgoalpos = finalgoalpos;
        }
    #/
    
    self vehicle_helisetai( finalgoalpos, undefined, undefined, undefined, 1, 1, goalyaw, 0, 0, stopatgoal, 0, 0, stopatgoal );
}

// Namespace namespace_cf9a4f547edbca10
// Params 3, eflags: 0x4
// Checksum 0x1111229f, Offset: 0x2c42
// Size: 0x28
function private set_speed( speed, acceleration, deceleration )
{
    self vehicle_setspeed( speed, acceleration, deceleration );
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0xd29256f8, Offset: 0x2c72
// Size: 0xce
function private trace_ground_point( x, y )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = 0;
    ignorelist = [ self ];
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 800, ignorelist, undefined, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace namespace_cf9a4f547edbca10
// Params 3
// Checksum 0xdeba15cc, Offset: 0x2d49
// Size: 0x5b
function get_desired_height( x, y, rand )
{
    offgroundheight = 750;
    groundheight = trace_ground_point( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x90c9a6cc, Offset: 0x2dad
// Size: 0x8e
function private init_scriptable( delay )
{
    self endon( #"death" );
    self endon( #"crashing" );
    wait delay;
    utility::function_7c10ea82c1e305b8( #"engine", #"on_all" );
    utility::function_7c10ea82c1e305b8( #"blinking_lights", #"on" );
    utility::function_7c10ea82c1e305b8( #"thrusters", #"horizontal" );
    wait 1;
    utility::function_7c10ea82c1e305b8( #"thrusters", #"dynamic" );
}

// Namespace namespace_cf9a4f547edbca10
// Params 4, eflags: 0x4
// Checksum 0xa10397f, Offset: 0x2e43
// Size: 0xac
function private init_objective_icon_intro( var_8c953eb201608663, shouldping, bundle, var_a6ba4bf0f70eab6a = 1 )
{
    activityinstance = self.activityinstance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    thread init_objective_icon( bundle, var_a6ba4bf0f70eab6a );
    
    if ( var_8c953eb201608663 && shouldping )
    {
        wait 5;
        var_624f6f859b8f2906 = self.origin + ( 0, 0, 60 );
        var_8c953eb201608663 calloutmarkerping::function_5d7b7302e94b97c2( self.vtolid, var_624f6f859b8f2906 );
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x2f463323, Offset: 0x2ef7
// Size: 0x9d
function private init_objective_icon( bundle, var_a6ba4bf0f70eab6a )
{
    activityinstance = self.activityinstance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    vtolid = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( bundle ?? "sat_ob_vtol_marker", 0, var_a6ba4bf0f70eab6a );
    self.vtolid = vtolid;
    objidpoolmanager::update_objective_onentity( vtolid, self );
    utility::waittill_any( "death", "crashing", "entitydeleted", "flyaway" );
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( vtolid );
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xe2daefcb, Offset: 0x2f9c
// Size: 0x167
function private initialize_infil()
{
    vehicleref = vehicle::get_ref();
    vehiclebundle = level.var_a7bf93687486b5ba[ vehicleref ];
    self.unload_hover_offset = vehiclebundle.ai.unload_hover_offset ?? 650;
    self.speed = 65;
    self.usedpositions = [];
    self.originalspeed = self.speed;
    self.accel = 20;
    self.decel = 20;
    self.heightoffset = ( 0, 0, 1280 );
    self setmaxpitchroll( 15, 25 );
    self vehicle_setspeed( self.speed, self.accel, self.decel );
    
    if ( self.is_landed )
    {
        self sethoverparams( 0, 0, 0 );
    }
    else
    {
        self sethoverparams( 50, 5, 2.5 );
    }
    
    self setturningability( 0.5 );
    self setyawspeed( 90, 45, 45 );
    self setcandamage( 1 );
    self setneargoalnotifydist( 512 );
    self vehicle_allowplayerstandon( 0 );
    self.ignorelist = [ self ];
    self.crashoffset = 1030;
    self.damagestate = 0;
    self.attackers = [];
    self.var_dc64ea91291dad76 = setup_ramp();
    thread function_110475e5cf545351();
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xd315f4e4, Offset: 0x310b
// Size: 0xb5
function private function_110475e5cf545351()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"camo_on" );
    utility::ent_flag_wait( "loaded" );
    
    if ( self.var_b69574d70876a99 )
    {
        foreach ( rider in self.riders )
        {
            rider hide();
        }
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x844bf8f7, Offset: 0x31c8
// Size: 0x27a
function private function_2ce95df53937a04f( start_node )
{
    self endon( #"death" );
    self endon( #"crashing" );
    
    for ( unloadnode = start_node; isdefined( unloadnode.target ) ; unloadnode = getvehiclenode( unloadnode.target, #targetname ) )
    {
    }
    
    self.currentnode = unloadnode;
    ground_pos = utility::drop_to_ground( unloadnode.origin, 100, -1000 );
    scenenode = {};
    scenenode.origin = ground_pos;
    scenenode.angles = unloadnode.angles;
    self.scenenode = scenenode;
    currentnode = start_node;
    animation = vehicle_ai::get_intro_anim();
    neworg = getstartorigin( scenenode.origin, scenenode.angles, animation );
    newangles = getstartangles( scenenode.origin, scenenode.angles, animation );
    utility::function_7c10ea82c1e305b8( #"thrusters", #"dynamic" );
    
    while ( isdefined( currentnode.target ) )
    {
        nextnode = getvehiclenode( currentnode.target, #targetname );
        
        if ( !isdefined( nextnode ) )
        {
            break;
        }
        
        unloadorg = ( neworg[ 0 ], neworg[ 1 ], 0 );
        currentnodeorg = ( currentnode.origin[ 0 ], currentnode.origin[ 1 ], 0 );
        nextnodeorg = ( nextnode.origin[ 0 ], nextnode.origin[ 1 ], 0 );
        var_77b2e25bf873456d = unloadorg - currentnodeorg;
        var_b2dbfd09c0c8c8a5 = unloadorg - nextnodeorg;
        
        if ( vectordot( var_77b2e25bf873456d, var_b2dbfd09c0c8c8a5 ) < 0 )
        {
            break;
        }
        
        move_to_position( nextnode.origin, 0, 300 );
        utility::waittill_any( "goal", "near_goal", "begin_evasive_maneuvers" );
        currentnode = nextnode;
    }
    
    thread function_f4fb1090a77230c8( neworg, newangles[ 1 ], 20, 5, 5 );
    utility::waittill_any( "goal", "near_goal", "begin_evasive_maneuvers" );
    return unloadnode;
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0xd9feb327, Offset: 0x344b
// Size: 0x6f
function private monitor_unloading( requestid, unload_node )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self waittill( #"unloading" );
    self vehicle_allowplayerstandon( 1 );
    utility::function_7c10ea82c1e305b8( #"doors", #"open" );
    thread namespace_37f5741ccbccb7a::function_7ac76e1b9d949c1e( unload_node.ground_pos, requestid );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x627edce1, Offset: 0x34c2
// Size: 0x64
function private monitor_unloaded( requestid )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self waittill( #"unloaded" );
    self.var_e038900b11ddf286 = 1;
    utility::function_7c10ea82c1e305b8( #"doors", #"closed" );
    self vehicle_allowplayerstandon( 0 );
    self function_dc61b81ec6b63cc4( 1 );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x70f60bb7, Offset: 0x352e
// Size: 0x15
function private function_36cbe4d2e7f91b9a( vtol )
{
    vtol thread leave_area();
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0x7bdafa42, Offset: 0x354b
// Size: 0x24
function private enter_path()
{
    self endon( #"death" );
    self endon( #"crashing" );
    wait 4;
    remove_camo();
}

// Namespace namespace_cf9a4f547edbca10
// Params 4, eflags: 0x4
// Checksum 0x70bb24aa, Offset: 0x3577
// Size: 0x149
function private do_infil( requestid, start_node, unload_node = undefined, riders )
{
    self notify( #"new_orders" );
    self endon( #"death" );
    self endon( #"crashing" );
    initialize_infil();
    thread enter_path();
    
    if ( unload_node )
    {
        thread namespace_37f5741ccbccb7a::function_2ca63bc8e2eee252( requestid );
        thread monitor_unloading( requestid, unload_node );
        thread monitor_unloaded( requestid );
        self.deathfunc = &function_36cbe4d2e7f91b9a;
        
        if ( !isdefined( unload_node.var_19ef9c5f3c3fe4aa ) )
        {
            self vehphys_setdefaultmotion();
            self.choices = unload_node.choices;
            vehicle_paths::vehicle_paths_helicopter( start_node );
        }
        
        return;
    }
    
    unloadnode = function_2ce95df53937a04f( start_node );
    unload_ai( requestid, unloadnode );
    set_speed( 65, 20, 20 );
    return_to_pos = start_node.origin;
    childthread namespace_37f5741ccbccb7a::ai_spawn_director_heli_land( return_to_pos );
    utility::function_7c10ea82c1e305b8( #"thrusters", #"horizontal" );
    self vehicle_allowplayerstandon( 0 );
    self function_dc61b81ec6b63cc4( 1 );
    self waittill( #"ai_spawn_director_heli_landed" );
    thread leave_area();
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0xd141dbd1, Offset: 0x36c8
// Size: 0x52
function private get_camo_endpoint( vtolorigin, vtolangles )
{
    forward = anglestoforward( vtolangles );
    var_87206c2adee9ca78 = 5000 * forward;
    var_87206c2adee9ca78 = ( var_87206c2adee9ca78[ 0 ], var_87206c2adee9ca78[ 1 ], 0 );
    camopoint = vtolorigin + var_87206c2adee9ca78;
    return camopoint;
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0x6fff3982, Offset: 0x3723
// Size: 0x76
function private leave_area()
{
    self endon( #"death", #"crashing", #"entitydeleted" );
    apply_camo();
    endpoint = get_camo_endpoint( self.origin, self.angles );
    move_to_position( endpoint, 1, 50, 0 );
    utility::waittill_any( "goal", "near_goal", "begin_evasive_maneuvers" );
    delete_vtol();
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x6efdb2dc, Offset: 0x37a1
// Size: 0x82
function private setup_rope( rider )
{
    animpos = vehicle_aianim::anim_pos( self, rider.vehicle_position );
    
    if ( isdefined( animpos.fastroperig ) && !isdefined( self.fastroperig[ animpos.fastroperig ] ) )
    {
        animatemodel = vehicle_aianim::getanimatemodel();
        getoutrig_model = vehicle_aianim::getout_rigspawn( animatemodel, animpos, 1 );
    }
    
    rider vehicle_common::setuprope();
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x24630dfc, Offset: 0x382b
// Size: 0x144
function private unload_ai( requestid, unloadnode )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self sethoverparams( 0, 0, 0 );
    vehicle_code::waittill_stable( unloadnode );
    self vehicle_cleardrivingstate();
    self function_d2b8ee2e1275daaf( 1 );
    self vehphys_forcekeyframedmotion();
    thread namespace_37f5741ccbccb7a::function_7ac76e1b9d949c1e( unloadnode, requestid );
    utility::function_7c10ea82c1e305b8( #"doors", #"open" );
    var_9a90df07a9fe1a03 = vehicle_code::_vehicle_unload();
    
    foreach ( rider in var_9a90df07a9fe1a03 )
    {
        rider thread function_b9592a3ecabfa233( self );
    }
    
    self waittill( #"unloaded" );
    self.var_e038900b11ddf286 = 1;
    self function_d2b8ee2e1275daaf( 0 );
    self vehphys_setdefaultmotion();
    self cleargoalyaw();
    function_2479114e5ee014dc( requestid );
    utility::function_7c10ea82c1e305b8( #"doors", #"closed" );
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0xc
// Checksum 0x77e15523, Offset: 0x3977
// Size: 0x80
function private function_b9592a3ecabfa233( vehicle )
{
    self notify( #"hash_2e5a6ff5641ae840" );
    self endon( #"hash_2e5a6ff5641ae840" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self.lastvehicle = vehicle;
    self.var_1416dd8624fff097 = 1;
    self endon( #"death" );
    self waittill( #"jumpedout" );
    self.var_1416dd8624fff097 = undefined;
    
    if ( self.lastvehicle == vehicle )
    {
        self.lastvehicle = undefined;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 1, eflags: 0x4
// Checksum 0x13b34789, Offset: 0x39ff
// Size: 0x2aa
function private load_ai( ai_group )
{
    botseat = 0;
    doorpeople = 0;
    usedpositions = [];
    var_11e06795610dcf30 = [];
    loadedai = [];
    
    foreach ( rider in ai_group )
    {
        if ( issubstr( rider.agent_type, "guild_bot" ) )
        {
            if ( botseat >= 2 )
            {
                rider agent_utils::despawnagent();
                assertmsg( "<dev string:x103>" );
                continue;
            }
            
            usedpositions[ botseat ] = 1;
            botseat = initialize_rider( rider, botseat );
            loadedai[ loadedai.size ] = rider;
            continue;
        }
        
        if ( rider.var_e7dd375985ff5ff2 && rider.var_e7dd375985ff5ff2 >= 2 )
        {
            usedpositions[ rider.var_e7dd375985ff5ff2 ] = 1;
            loadedai[ loadedai.size ] = rider;
            initialize_rider( rider, rider.var_e7dd375985ff5ff2 );
            
            if ( rider.var_e7dd375985ff5ff2 == 5 || rider.var_e7dd375985ff5ff2 == 6 )
            {
                doorpeople++;
            }
            
            continue;
        }
        
        var_11e06795610dcf30[ var_11e06795610dcf30.size ] = rider;
    }
    
    currentseat = 2;
    vehicleclassname = vehicle_code::get_vehicle_classname();
    var_f688d258b516e02b = level.vehicle.templates.aianims[ vehicleclassname ].size;
    
    foreach ( rider in var_11e06795610dcf30 )
    {
        while ( usedpositions[ currentseat ] )
        {
            currentseat++;
        }
        
        if ( currentseat >= var_f688d258b516e02b )
        {
            break;
        }
        
        if ( doorpeople < 2 )
        {
            if ( !usedpositions[ 5 ] )
            {
                doorindex = 5;
            }
            else if ( !usedpositions[ 6 ] )
            {
                doorindex = 6;
            }
            
            usedpositions[ doorindex ] = 1;
            loadedai[ loadedai.size ] = rider;
            initialize_rider( rider, doorindex );
            doorpeople++;
            continue;
        }
        
        usedpositions[ currentseat ] = 1;
        loadedai[ loadedai.size ] = rider;
        currentseat = initialize_rider( rider, currentseat );
    }
    
    vehicle_ai::load( loadedai, 1, 1 );
}

// Namespace namespace_cf9a4f547edbca10
// Params 2, eflags: 0x4
// Checksum 0x33756a28, Offset: 0x3cb1
// Size: 0x4e
function private initialize_rider( rider, seatindex )
{
    rider.script_startingposition = seatindex;
    rider.vehicle_position = rider.script_startingposition;
    rider thread namespace_37f5741ccbccb7a::function_aca6e5ab85c2cffa( int( seatindex ) );
    seatindex++;
    return seatindex;
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xcced9f64, Offset: 0x3d08
// Size: 0xb1
function private setup_ramp()
{
    ramplocation = self gettagorigin( "tag_ramp_lower_animate" );
    rampangles = self gettagangles( "tag_ramp_lower_animate" );
    var_dc64ea91291dad76 = spawn( "script_model", ramplocation );
    var_dc64ea91291dad76.angles = rampangles;
    var_dc64ea91291dad76 setmodel( %"veh_sat_mil_air_vtol_buzzard_ramp_lower" );
    var_dc64ea91291dad76 linkto( self, "tag_ramp_lower_animate" );
    var_dc64ea91291dad76.parent = self;
    
    if ( self.var_b69574d70876a99 )
    {
        var_dc64ea91291dad76 hide();
    }
    
    var_dc64ea91291dad76 thread damage::monitordamage( self.maxhealth, "none", &ramp_modifydamage, &ramp_modifydamage, 1 );
    return var_dc64ea91291dad76;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1
// Checksum 0xe24b4bc1, Offset: 0x3dc2
// Size: 0xf3
function ramp_modifydamage( damagedata )
{
    vtol = self.parent;
    
    if ( !vtol )
    {
        return 0;
    }
    
    damage = damagedata.damage;
    
    if ( damage <= 0 )
    {
        return damage;
    }
    
    hitloc = damagedata.hitloc ?? "none";
    vtol [[ level.vehicles.damagecallback ]]( damagedata.inflictor, damagedata.attacker, damage, damagedata.idflags, damagedata.meansofdeath, damagedata.objweapon, damagedata.point, damagedata.direction_vec, hitloc, 0, 0, damagedata.tagname, damagedata.partname, damagedata.eventid );
    return damage;
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xed3cb2df, Offset: 0x3ebe
// Size: 0x188
function private apply_camo()
{
    if ( self.var_b69574d70876a99 )
    {
        return;
    }
    
    self.var_b69574d70876a99 = 1;
    
    if ( !self getscriptablehaspart( #"vehicle_active_camo_fx" ) )
    {
        assertmsg( "<dev string:x159>" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( #"vehicle_active_camo_fx", #"camo_fx_activate" );
    utility::function_7c10ea82c1e305b8( #"engine", #"off" );
    utility::function_7c10ea82c1e305b8( #"blinking_lights", #"off" );
    
    if ( getdvarint( @"hash_a21672b493458708", 0 ) )
    {
        utility::function_7c10ea82c1e305b8( #"body_damage_light", #"off" );
        utility::function_7c10ea82c1e305b8( #"body_damage_medium", #"off" );
        utility::function_7c10ea82c1e305b8( #"body_damage_heavy", #"off" );
    }
    
    foreach ( rider in self.riders )
    {
        rider hide();
    }
    
    if ( self.var_dc64ea91291dad76 )
    {
        self.var_dc64ea91291dad76 hide();
    }
    
    self.var_24954f14e27b448d = 0;
    self notify( #"camo_on" );
}

// Namespace namespace_cf9a4f547edbca10
// Params 0, eflags: 0x4
// Checksum 0xab158f9a, Offset: 0x404e
// Size: 0x250
function private remove_camo()
{
    if ( !self.var_b69574d70876a99 )
    {
        return;
    }
    
    self.var_b69574d70876a99 = 0;
    
    if ( !self getscriptablehaspart( #"vehicle_active_camo_fx" ) )
    {
        assertmsg( "<dev string:x159>" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( #"vehicle_active_camo_fx", #"camo_fx_deactivate" );
    utility::function_7c10ea82c1e305b8( #"engine", #"on_all" );
    utility::function_7c10ea82c1e305b8( #"blinking_lights", #"on" );
    utility::function_7c10ea82c1e305b8( #"thrusters", #"dynamic" );
    
    if ( getdvarint( @"hash_a21672b493458708", 0 ) )
    {
        currentdamagestate = vehicle_damage::get_state();
        
        switch ( currentdamagestate )
        {
            case #"hash_d582c3286e5c390f":
                utility::function_7c10ea82c1e305b8( #"body_damage_light", #"on" );
                break;
            case #"hash_c71b112fe04823d6":
                utility::function_7c10ea82c1e305b8( #"body_damage_medium", #"on" );
                break;
            case #"hash_2453c9ffec9f5c20":
                utility::function_7c10ea82c1e305b8( #"body_damage_heavy", #"on" );
                break;
            case #"hash_36b632947e7a6609":
            default:
                utility::function_7c10ea82c1e305b8( #"body_damage_light", #"off" );
                utility::function_7c10ea82c1e305b8( #"body_damage_medium", #"off" );
                utility::function_7c10ea82c1e305b8( #"body_damage_heavy", #"off" );
                break;
        }
    }
    
    foreach ( rider in self.riders )
    {
        rider show();
    }
    
    if ( self.var_dc64ea91291dad76 )
    {
        self.var_dc64ea91291dad76 show();
    }
    
    if ( !level.var_ac384fdf4664f6cc )
    {
        self.var_24954f14e27b448d = 1;
    }
}

// Namespace namespace_cf9a4f547edbca10
// Params 2
// Checksum 0x75b3b14, Offset: 0x42a6
// Size: 0xea
function function_e8d02650e81ea5b8( key, value )
{
    assert( !level.ob_air_traffic.var_2c075fa23c46910f[ key ], "<dev string:x19b>" + key );
    
    foreach ( var_2c075fa23c46910f in level.ob_air_traffic.var_2c075fa23c46910f )
    {
        assert( abs( var_2c075fa23c46910f - value ) > 500, "<dev string:x1e1>" + key );
    }
    
    level.ob_air_traffic.var_2c075fa23c46910f[ key ] = value;
}

// Namespace namespace_cf9a4f547edbca10
// Params 1
// Checksum 0xc70d9329, Offset: 0x4398
// Size: 0x39
function function_8412c1d7c8896af1( key )
{
    return level.ob_air_traffic.var_2c075fa23c46910f[ key ] + randomintrange( int( -250 ), int( 250 ) );
}

