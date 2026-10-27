// script_a34e6e05805c9de  (hash_0a34e6e05805c9de.gscc) (size: 16410 Bytes / 0x401a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40b1d050 (1085395024)
// size ...... 16410 (0x401a)
// includes .. 8   (offset: 0x3a36)
// strings ... 81  (offset: 0x3a76)
// dev strs .. 4   (offset: 0x3fea)
// exports ... 24  (offset: 0x28da)
// cseg ...... 0x678 + 0x2262 (0x28da)
// imports ... 109 (offset: 0x2c9a)
// animtree1 . 0   (offset: 0x401a)
// animtree2 . 0   (offset: 0x401a)
#using script_16ea1b94f0f381b3;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;

#namespace namespace_2bdecc05800910ee;

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xf47599b9, Offset: 0x696
// Size: 0x57
function init()
{
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    load_laser_fx();
    initsentrysettings();
    scriptable::scriptable_addusedcallbackbypart( "trap_defuse_object", &function_baa85dc4dfb4d4a );
    
    /#
        level thread function_5a04fbd2319d659();
    #/
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xc1187da7, Offset: 0x6f5
// Size: 0x160
function load_laser_fx()
{
    level._effect[ "vfx_laser_smoke" ] = loadfxasset( "vfx_iw8_cp_raid_steampipe_explo" );
    level._effect[ "vfx_laser_pointer" ] = loadfxasset( "vfx_iw8_cp_red_laser" );
    level._effect[ "vfx_laser_pointer_thermal" ] = loadfxasset( "vfx_iw8_cp_red_laser_thermalonly" );
    level._effect[ "vfx_laser_pointer_nvg" ] = loadfxasset( "vfx_iw9_cp_red_laser_nvgonly" );
    level._effect[ "vfx_laser_destroy" ] = loadfxasset( "vfx_iw8_cp_red_laser_destroy" );
    level._effect[ "vfx_laser_burn" ] = loadfxasset( "vfx_iw8_cp_raid_lava_laser_burn" );
    level._effect[ "vfx_turret_light" ] = loadfxasset( "vfx_iw9_cp_turret_light" );
    level._effect[ "vfx_c4_explode" ] = loadfxasset( "vfx_iw9_core_equip_c4_gen_ch" );
    level._effect[ "vfx_turret_light_5" ] = loadfxasset( "vfx_iw9_cp_turret_light_0_5s" );
    level._effect[ "vfx_turret_light_175" ] = loadfxasset( "vfx_iw9_cp_turret_light_1_75s" );
    level._effect[ "vfx_turret_light_2" ] = loadfxasset( "vfx_iw9_cp_turret_light_2_0s" );
    level._effect[ "vfx_turret_light_3" ] = loadfxasset( "vfx_iw9_cp_turret_light_3_0s" );
    level._effect[ "vfx_laser_destroy_nvg" ] = loadfxasset( "vfx_iw9_cp_red_laser_nvgonly_die" );
    level._effect[ "vfx_laser_destroy_end" ] = loadfxasset( "vfx_iw9_core_lasers_laser_nvg_end_die" );
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xf5a9cf1a, Offset: 0x85d
// Size: 0x5b6
function initsentrysettings()
{
    level.sentrysettings[ "bs_laser" ] = spawnstruct();
    level.sentrysettings[ "bs_laser" ].health = 999999;
    level.sentrysettings[ "bs_laser" ].maxhealth = 350;
    level.sentrysettings[ "bs_laser" ].burstmin = 20;
    level.sentrysettings[ "bs_laser" ].burstmax = 120;
    level.sentrysettings[ "bs_laser" ].pausemin = 0.15;
    level.sentrysettings[ "bs_laser" ].pausemax = 0.35;
    level.sentrysettings[ "bs_laser" ].maxrange = 4000000;
    level.sentrysettings[ "bs_laser" ].laserrange = 7562500;
    level.sentrysettings[ "bs_laser" ].lockstrength = 2;
    level.sentrysettings[ "bs_laser" ].sentrymodeon = "manual";
    level.sentrysettings[ "bs_laser" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "bs_laser" ].ammo = 200;
    level.sentrysettings[ "bs_laser" ].timeout = 999999;
    level.sentrysettings[ "bs_laser" ].spinuptime = 0.65;
    level.sentrysettings[ "bs_laser" ].overheattime = 8;
    level.sentrysettings[ "bs_laser" ].cooldowntime = 0.1;
    level.sentrysettings[ "bs_laser" ].fxtime = 0.3;
    level.sentrysettings[ "bs_laser" ].streakname = "sentry_gun";
    level.sentrysettings[ "bs_laser" ].weaponinfo = "laser_trap_nvg";
    level.sentrysettings[ "bs_laser" ].playerweaponinfo = "laser_trap_nvg";
    level.sentrysettings[ "bs_laser" ].scriptable = "ks_sentry_turret_mp";
    level.sentrysettings[ "bs_laser" ].modelbasecover = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[ "bs_laser" ].modelbaseground = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[ "bs_laser" ].modeldestroyedcover = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[ "bs_laser" ].modeldestroyedground = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[ "bs_laser" ].placementhintstring = &"killstreaks_hints/sentry_gun_place";
    level.sentrysettings[ "bs_laser" ].ownerusehintstring = &"killstreaks_hints/sentry_use";
    level.sentrysettings[ "bs_laser" ].otherusehintstring = &"killstreaks_hints/sentry_other_use";
    level.sentrysettings[ "bs_laser" ].dismantlehintstring = &"killstreaks_hints/sentry_dismantle";
    level.sentrysettings[ "bs_laser" ].headicon = 1;
    level.sentrysettings[ "bs_laser" ].teamsplash = "used_sentry_gun";
    level.sentrysettings[ "bs_laser" ].destroyedsplash = "callout_destroyed_sentry_gun";
    level.sentrysettings[ "bs_laser" ].shouldsplash = 1;
    level.sentrysettings[ "bs_laser" ].votimeout = "sentry_shock_timeout";
    level.sentrysettings[ "bs_laser" ].vodestroyed = "sentry_shock_destroy";
    level.sentrysettings[ "bs_laser" ].scorepopup = "destroyed_sentry";
    level.sentrysettings[ "bs_laser" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "bs_laser" ].iskillstreak = 1;
    level.sentrysettings[ "bs_laser" ].headiconoffset = ( 0, 0, 75 );
    level.sentrysettings[ "bs_laser" ].ignoreownerteam = 0;
    level.sentrysettings[ "bs_laser" ].var_c0e7bd1402ecc2ca = 2;
    level.sentrysettings[ "bs_laser" ].laserexplosion = 1;
    level.sentrysettings[ "bs_laser" ].trapmindamage = 100;
    level.sentrysettings[ "bs_laser" ].trapmaxdamage = 200;
    level.sentrysettings[ "bs_laser" ].trapdamageradius = 384;
    level.sentrysettings[ "bs_laser" ].trapdamageweapon = "frag_grenade_mp";
    level.sentrysettings[ "bs_laser" ].trapmeansofdeath = "MOD_EXPLOSIVE";
}

// Namespace namespace_2bdecc05800910ee
// Params 5
// Checksum 0xf35f2d18, Offset: 0xe1b
// Size: 0x208
function spawn_sentry_turret( config, struct, team, model, weapon )
{
    turret = spawnturret( "misc_turret", struct.origin, weapon );
    turret.team = team;
    turret setturretteam( team );
    turret.angles = struct.angles;
    turret.health = config.maxhealth;
    turret.maxhealth = config.maxhealth;
    turret.momentum = 0;
    turret.heatlevel = 0;
    turret.overheated = 0;
    turret.cooldownwaittime = 2;
    turret.maxrange = config.maxrange;
    turret.laserrange = config.laserrange;
    
    if ( isdefined( struct.radius ) )
    {
        maxdistsq = struct.radius * struct.radius;
        turret.maxrange = int( maxdistsq - maxdistsq * 0.1 );
        turret.laserrange = int( maxdistsq );
    }
    
    turret setmodel( model );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    turret setautorotationdelay( 0.2 );
    turret maketurretinoperable();
    turret setleftarc( 180 );
    turret setrightarc( 180 );
    turret setbottomarc( 50 );
    turret settoparc( 60 );
    turret setconvergencetime( 0.6, "pitch" );
    turret setconvergencetime( 0.6, "yaw" );
    turret setconvergenceheightpercent( 0.65 );
    turret setdefaultdroppitch( -89 );
    turret setturretmodechangewait( 1 );
    return turret;
}

// Namespace namespace_2bdecc05800910ee
// Params 6
// Checksum 0x9103eac9, Offset: 0x102c
// Size: 0x209
function setup_sentry( enemy_sentry_struct, team, damage_type, turret_model, parent_struct, weapon_info )
{
    sentrytype = "bs_laser";
    config = level.sentrysettings[ sentrytype ];
    
    if ( !isdefined( weapon_info ) )
    {
        weapon_info = level.sentrysettings[ sentrytype ].weaponinfo;
    }
    
    if ( !isdefined( team ) )
    {
        team = "axis";
    }
    
    if ( !isdefined( enemy_sentry_struct.angles ) )
    {
        enemy_sentry_struct.angles = ( 0, 0, 0 );
    }
    
    if ( !isdefined( turret_model ) )
    {
        turret_model = "electronics_ir_laser_device_assembly_nogeo";
    }
    
    turret = spawn_sentry_turret( config, enemy_sentry_struct, team, turret_model, weapon_info );
    turret.sentrytype = sentrytype;
    turret.turrettype = sentrytype;
    turret.damage_type = damage_type;
    turret emp_debuff::set_start_emp_callback( &sentryturret_empstarted );
    turret emp_debuff::set_clear_emp_callback( &sentryturret_empcleared );
    turret emp_debuff::allow_emp( 0 );
    enemy_sentry_struct.turret = turret;
    turret.sentry_struct = enemy_sentry_struct;
    turret.parent_struct = parent_struct;
    
    if ( !isdefined( level.killstreak_additional_targets ) )
    {
        level.killstreak_additional_targets = [];
    }
    
    level.killstreak_additional_targets[ level.killstreak_additional_targets.size ] = turret;
    
    if ( !isdefined( level.var_9102adf30a9660e ) )
    {
        level.var_9102adf30a9660e = [];
    }
    
    level.var_9102adf30a9660e[ level.var_9102adf30a9660e.size ] = turret;
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeon );
    turret emp_debuff::allow_emp( 1 );
    turret sentryturret_empupdate();
    turret laseron();
    turret thread function_8403b85629cedf8e();
    turret thread function_7c5485c86804c658();
    turret notify( #"lasers_started" );
    return turret;
}

// Namespace namespace_2bdecc05800910ee
// Params 1
// Checksum 0xdae7dd4a, Offset: 0x123e
// Size: 0x7f
function sentryturret_empstarted( data )
{
    if ( isplayer( data.attacker ) && game_utility::getgametype() != "wm" )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"dmz_lasertrap_disabled" );
        }
    }
    
    sentryturret_empupdate();
}

// Namespace namespace_2bdecc05800910ee
// Params 1
// Checksum 0x4efef55f, Offset: 0x12c5
// Size: 0x19
function sentryturret_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    sentryturret_empupdate();
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xe9708150, Offset: 0x12e6
// Size: 0x87
function sentryturret_empupdate()
{
    if ( emp_debuff::is_empd() )
    {
        self turretfiredisable();
        self setmode( level.sentrysettings[ self.turrettype ].sentrymodeoff );
        self laseroff();
        return;
    }
    
    if ( !self.killed && !self.defused )
    {
        self turretfireenable();
        self setmode( level.sentrysettings[ self.turrettype ].sentrymodeon );
        self laseron();
    }
}

// Namespace namespace_2bdecc05800910ee
// Params 1
// Checksum 0x22822ae5, Offset: 0x1375
// Size: 0x3b
function sentryturret_setinactive( turret )
{
    turret setdefaultdroppitch( 30 );
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeoff );
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0x2fbc7eb3, Offset: 0x13b8
// Size: 0x3e5
function function_8403b85629cedf8e()
{
    self endon( #"death" );
    self endon( #"exit_idle" );
    self endon( #"stop_idle_movement" );
    
    if ( self.state == "idle" )
    {
        return;
    }
    
    self stopfiring();
    self.state = "idle";
    self notify( #"enter_idle" );
    self notify( #"stop_shooting" );
    tag = "tag_laser";
    
    if ( !utility::hastag( self.model, tag ) )
    {
        tag = "tag_turret";
    }
    
    if ( isdefined( self.idle_func ) )
    {
        self [[ self.idle_func ]]();
        return;
    }
    
    sentry_origin = self.sentry_struct.origin;
    sentry_angles = self.sentry_struct.angles;
    sentry_forward_vec = anglestoforward( sentry_angles );
    sentry_up_vec = anglestoup( sentry_angles );
    var_2a97b2108bfcdbda = anglestoleft( sentry_angles );
    sentry_right_vec = anglestoright( sentry_angles );
    maxangle = 15;
    var_fde680674fa81066 = rotatepointaroundvector( sentry_up_vec, sentry_forward_vec, maxangle );
    var_f19044cc6c3a3489 = vectornormalize( vectorcross( var_fde680674fa81066, sentry_up_vec ) );
    var_f26c1ac5fac945d4 = vectorcross( var_f19044cc6c3a3489, var_fde680674fa81066 );
    var_57b6f12fbe0ce29c = axistoangles( var_fde680674fa81066, var_f19044cc6c3a3489, var_f26c1ac5fac945d4 );
    var_8563f5721f6c07b1 = rotatepointaroundvector( sentry_up_vec, sentry_forward_vec, maxangle * -1 );
    var_c917f6711bd512f2 = vectornormalize( vectorcross( var_8563f5721f6c07b1, sentry_up_vec ) );
    var_cb3a1f5fb09d4d3d = vectorcross( var_c917f6711bd512f2, var_8563f5721f6c07b1 );
    var_426b929eec6de853 = axistoangles( var_8563f5721f6c07b1, var_c917f6711bd512f2, var_cb3a1f5fb09d4d3d );
    sentry_angles_up = vectortoangles( sentry_up_vec );
    sentry_angles_fwd = vectortoangles( sentry_forward_vec );
    sentry_angles_left = vectortoangles( var_2a97b2108bfcdbda );
    sentry_angles_right = vectortoangles( sentry_right_vec );
    self function_a0d3d838694fe8e1( sentry_forward_vec );
    self.aimlocation = self gettagorigin( tag ) + anglestoforward( self gettagangles( tag ) ) * 3000;
    
    /#
        if ( getdvarint( @"scr_lasertrap_debug", 0 ) != 0 )
        {
            debugstar( self gettagorigin( tag ), ( 1, 1, 0 ), 5000, tag, 0.1 );
        }
    #/
    
    raytrace_contents = trace::create_world_contents();
    
    if ( !self.sentry_struct function_ce453bcdefcb861() )
    {
        sentry_origin = self gettagorigin( tag );
        newdir = anglestoforward( sentry_angles_fwd );
        newpos = sentry_origin + newdir * 2000;
        trace = trace::ray_trace( sentry_origin, newpos, self, raytrace_contents );
        end = trace[ "position" ];
        self.aimlocation = ( newpos[ 0 ], newpos[ 1 ], sentry_origin[ 2 ] );
        self function_a0d3d838694fe8e1( self.aimlocation - sentry_origin );
        vmidpoint = ( sentry_origin + end ) / 2;
        function_c9f65560d0025f19( 1, vmidpoint );
        waitframe();
        
        while ( true )
        {
            function_ac50977193ad7ec8( var_57b6f12fbe0ce29c, 10, "left" );
            function_ac50977193ad7ec8( sentry_angles_fwd, 10, "fwd" );
            function_ac50977193ad7ec8( var_426b929eec6de853, 10, "right" );
            function_ac50977193ad7ec8( sentry_angles_fwd, 10, "fwd" );
        }
        
        return;
    }
    
    tag = "tag_laser";
    
    if ( !utility::hastag( self.model, tag ) )
    {
        tag = "tag_turret";
    }
    
    sentry_origin = self gettagorigin( tag );
    newpos = sentry_origin + sentry_forward_vec * 2000;
    trace = trace::ray_trace( sentry_origin, newpos, self, raytrace_contents );
    end = trace[ "position" ];
    self.aimlocation = ( end[ 0 ], end[ 1 ], sentry_origin[ 2 ] );
    vmidpoint = ( sentry_origin + end ) / 2;
    thread function_c9f65560d0025f19( undefined, vmidpoint );
}

// Namespace namespace_2bdecc05800910ee
// Params 2
// Checksum 0x697c70a1, Offset: 0x17a5
// Size: 0x45
function vectortoanglessafe( forward, up )
{
    right = vectorcross( forward, up );
    up = vectorcross( right, forward );
    angles = axistoangles( forward, right, up );
    return angles;
}

// Namespace namespace_2bdecc05800910ee
// Params 3
// Checksum 0x34801969, Offset: 0x17f3
// Size: 0x17d
function function_ac50977193ad7ec8( angles, timehere = 4, debug_text )
{
    timemove = timehere * 0.7;
    timestop = timehere - timemove;
    tag = "tag_laser";
    
    if ( !utility::hastag( self.model, tag ) )
    {
        tag = "tag_turret";
    }
    
    sentry_origin = self gettagorigin( tag );
    newdir = anglestoforward( angles );
    newpos = sentry_origin + newdir * 2000;
    newposfinal = ( newpos[ 0 ], newpos[ 1 ], sentry_origin[ 2 ] );
    var_757a5bfcf5cb53f0 = self.aimlocation;
    timestart = gettime();
    timetotal = timemove * 1000;
    
    while ( true )
    {
        timepass = gettime() - timestart;
        
        if ( timepass > timetotal )
        {
            break;
        }
        
        self.aimlocation = vectorlerp( var_757a5bfcf5cb53f0, newposfinal, timepass / timetotal );
        self function_a0d3d838694fe8e1( self.aimlocation - sentry_origin );
        waitframe();
    }
    
    /#
        if ( getdvarint( @"hash_69de6d4d9ba136d1", 0 ) )
        {
            if ( isdefined( debug_text ) )
            {
                announcement( debug_text );
            }
            
            level thread debug_utility::drawline( self.origin, newposfinal, timehere, ( 1, 0, 0 ) );
        }
    #/
    
    wait timestop;
}

// Namespace namespace_2bdecc05800910ee
// Params 4
// Checksum 0x4147de02, Offset: 0x1978
// Size: 0x171
function function_f08fb1dede4695bf( struct, turrets, customscriptable, owner )
{
    scriptablename = customscriptable ?? "dmz_lasertrap";
    struct.defuseobj = spawnscriptable( scriptablename, struct.origin, struct.angles );
    struct.defuseobj.turret_structs = utility::getstructarray( struct.target, "targetname" );
    struct.defuseobj.parent_struct = struct;
    
    if ( isdefined( owner ) )
    {
        struct.owner = owner;
    }
    
    if ( !isdefined( level.var_fe18ff6ea6360f80 ) )
    {
        level.var_fe18ff6ea6360f80 = [];
    }
    
    level.var_fe18ff6ea6360f80[ level.var_fe18ff6ea6360f80.size ] = struct;
    
    if ( function_31579636ccaca2a8() )
    {
        flags::function_2f3408423ccc9b2e( "prematch_done" );
        waitframe();
        
        foreach ( turret in turrets )
        {
            turret thread function_bebd673e8e3f2ded( struct );
        }
    }
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xeb24b3d5, Offset: 0x1af1
// Size: 0x1a, Type: bool
function function_31579636ccaca2a8()
{
    if ( getdvarint( @"hash_7693c920bebdb71b", 1 ) != 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2bdecc05800910ee
// Params 6
// Checksum 0x26854fd7, Offset: 0x1b14
// Size: 0x2a2
function function_baa85dc4dfb4d4a( instance, part, state, player, bautouse, usestring )
{
    if ( part == "trap_defuse_object" )
    {
        instance setscriptablepartstate( "trap_defuse_object", "off" );
        defusestruct = instance.parent_struct;
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( defusestruct.origin, defusestruct.angles );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_offhand_c4", 1, spawnoptions );
        playsoundatpos( defusestruct.origin, "cp_laser_disable" );
        
        foreach ( turret in defusestruct.turrets )
        {
            sentryturret_setinactive( turret );
            playfx( level._effect[ "vfx_laser_destroy_nvg" ], turret.origin );
            start = turret gettagorigin( "tag_laser" );
            trace = trace::ray_trace( start, turret.aimlocation );
            end = trace[ "position" ];
            playfx( level._effect[ "vfx_laser_destroy_end" ], start );
            playfx( level._effect[ "vfx_laser_destroy_end" ], end );
            turret setmode( "sentry_offline" );
            turret laseroff();
            turret.defused = 1;
            
            if ( function_31579636ccaca2a8() )
            {
                turret thread function_60c21e88d31051fa();
            }
            
            turret notify( #"stop_idle_movement" );
            
            if ( !turret.sentry_struct function_ce453bcdefcb861() )
            {
                turret function_2e9b676efd2c487( 1 );
                continue;
            }
            
            turret function_2e9b676efd2c487();
        }
        
        if ( isdefined( player ) )
        {
            var_d22200b8f07f81cd = utility::getsharedfunc( #"lasertrap", #"hash_d377d80e7543449c" );
            
            if ( isdefined( var_d22200b8f07f81cd ) )
            {
                [[ var_d22200b8f07f81cd ]]( player );
                return;
            }
            
            if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
            {
                player thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"dmz_lasertrap_defused" );
            }
        }
    }
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xe1b6910b, Offset: 0x1dbe
// Size: 0xf1
function function_60c21e88d31051fa()
{
    if ( isdefined( self.parent_struct.script_index ) )
    {
        if ( self.parent_struct.script_index == "0.5" )
        {
            stopfxontag( level._effect[ "vfx_turret_light_5" ], self, "tag_fx" );
        }
        
        if ( self.parent_struct.script_index == "1.75" )
        {
            stopfxontag( level._effect[ "vfx_turret_light_175" ], self, "tag_fx" );
        }
        
        if ( self.parent_struct.script_index == "2" )
        {
            stopfxontag( level._effect[ "vfx_turret_light_2" ], self, "tag_fx" );
        }
        
        if ( self.parent_struct.script_index == "3" )
        {
            stopfxontag( level._effect[ "vfx_turret_light_3" ], self, "tag_fx" );
        }
    }
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0xfe2fe6a4, Offset: 0x1eb7
// Size: 0x5b9
function function_7c5485c86804c658()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"stop_idle_movement" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    trapconfig = level.sentrysettings[ "bs_laser" ];
    delayseconds = trapconfig.var_c0e7bd1402ecc2ca;
    
    if ( delayseconds > 0 )
    {
        wait delayseconds;
    }
    
    raytrace_contents = trace::create_character_contents();
    
    while ( true )
    {
        if ( emp_debuff::is_empd() )
        {
            waitframe();
            continue;
        }
        
        start = self gettagorigin( "tag_laser" );
        nearby_player = function_47c86977a18df38b( level.players, start, 1024 );
        
        if ( isdefined( nearby_player ) )
        {
            waitframe();
            continue;
        }
        
        trace = trace::ray_trace( start, self.aimlocation );
        end = trace[ "position" ];
        
        /#
            if ( getdvarint( @"scr_lasertrap_debug", 0 ) != 0 )
            {
                line( start, end, ( 1, 0, 0 ), 1, 0, 1 );
            }
        #/
        
        trace = trace::ray_trace( start, end, [], raytrace_contents );
        
        if ( isdefined( trace[ "entity" ] ) && trace[ "hittype" ] == "hittype_entity" )
        {
            if ( isplayer( trace[ "entity" ] ) )
            {
                player = trace[ "entity" ];
                
                if ( trapconfig.ignoreownerteam && player.pers[ "team" ] == self.team )
                {
                    waitframe();
                    continue;
                }
                
                defuse_struct = self.parent_struct;
                
                if ( isplayer( player ) )
                {
                    player.var_92571c6ed4c9c936 = 1;
                    player.shouldskipdeathsshield = 1;
                }
                
                playsoundatpos( defuse_struct.origin, "cp_laser_trigger" );
                wait 0.65;
                
                if ( game_utility::getgametype() == "wm" )
                {
                    var_203ee8626a4c387a = anglestoforward( defuse_struct.angles );
                    
                    if ( var_203ee8626a4c387a[ 0 ] > 0 )
                    {
                        var_203ee8626a4c387a = ( 1, var_203ee8626a4c387a[ 1 ], 0 );
                    }
                    else
                    {
                        var_203ee8626a4c387a = ( -1, var_203ee8626a4c387a[ 1 ], 0 );
                    }
                    
                    if ( var_203ee8626a4c387a[ 1 ] > 0 )
                    {
                        var_203ee8626a4c387a = ( var_203ee8626a4c387a[ 0 ], 1, 0 );
                    }
                    else
                    {
                        var_203ee8626a4c387a = ( var_203ee8626a4c387a[ 0 ], -1, 0 );
                    }
                    
                    playsoundatpos( defuse_struct.origin + ( var_203ee8626a4c387a[ 0 ], var_203ee8626a4c387a[ 1 ], 0 ) * 10, "cp_laser_expl" );
                }
                else
                {
                    playsoundatpos( defuse_struct.origin, "cp_laser_expl" );
                }
                
                mindamage = getdvarint( @"scr_laser_trap_min_damage", trapconfig.trapmindamage );
                maxdamage = getdvarint( @"scr_laser_trap_max_damage", trapconfig.trapmaxdamage );
                traprange = getdvarint( @"scr_laser_trap_range", trapconfig.trapdamageradius );
                meansofdeath = trapconfig.trapmeansofdeath;
                damageweapon = trapconfig.trapdamageweapon;
                attacker = defuse_struct.owner ?? level.var_1b7719e8fe46996d;
                
                foreach ( turr in defuse_struct.turrets )
                {
                    if ( !turr emp_debuff::is_empd() && trapconfig.laserexplosion )
                    {
                        level.var_1b7719e8fe46996d radiusdamage( turr.soundorg.origin, traprange, maxdamage, mindamage, attacker, meansofdeath, damageweapon );
                    }
                }
                
                level.var_1b7719e8fe46996d radiusdamage( defuse_struct.origin, traprange, maxdamage, mindamage, attacker, meansofdeath, damageweapon );
                playrumbleonposition( "grenade_rumble", defuse_struct.origin );
                earthquake( 0.45, 0.7, defuse_struct.origin, 800 );
                level notify( #"hash_5fe8b0590cfefa4c" );
                playfx( level._effect[ "vfx_laser_destroy_nvg" ], start );
                playfx( level._effect[ "vfx_laser_destroy_end" ], start );
                playfx( level._effect[ "vfx_laser_destroy_nvg" ], end );
                playfx( level._effect[ "vfx_laser_destroy_end" ], end );
                
                foreach ( turret in defuse_struct.turrets )
                {
                    if ( !turret.sentry_struct function_ce453bcdefcb861() )
                    {
                        turret function_2e9b676efd2c487( 1 );
                    }
                    else
                    {
                        turret function_2e9b676efd2c487();
                    }
                    
                    if ( self != turret )
                    {
                        thread function_9651333190e090e8( turret );
                    }
                }
                
                if ( isdefined( defuse_struct.defuseobj ) )
                {
                    defuse_struct.defuseobj setscriptablepartstate( "trap_defuse_object", "off" );
                    playfx( level._effect[ "vfx_c4_explode" ], defuse_struct.defuseobj.origin );
                }
                
                thread function_9651333190e090e8( self );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_2bdecc05800910ee
// Params 1
// Checksum 0x93960c00, Offset: 0x2478
// Size: 0x55
function function_9651333190e090e8( turret )
{
    turret playsound( "recon_drone_explode" );
    
    if ( function_31579636ccaca2a8() )
    {
        turret thread function_60c21e88d31051fa();
    }
    
    sentryturret_setinactive( turret );
    turret.killed = 1;
    turret laseroff();
    turret notify( #"stop_idle_movement" );
}

// Namespace namespace_2bdecc05800910ee
// Params 0
// Checksum 0x5f9d81fc, Offset: 0x24d5
// Size: 0x18, Type: bool
function function_ce453bcdefcb861()
{
    if ( self.script_groupname == "nomove" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2bdecc05800910ee
// Params 1
// Checksum 0xc275d5ba, Offset: 0x24f6
// Size: 0xf4
function function_bebd673e8e3f2ded( struct )
{
    self endon( #"death" );
    self endon( #"stop_idle_movement" );
    
    if ( isdefined( struct.script_index ) )
    {
        if ( struct.script_index == "0.5" )
        {
            playfxontag( level._effect[ "vfx_turret_light_5" ], self, "tag_fx" );
            return;
        }
        
        if ( struct.script_index == "1.75" )
        {
            playfxontag( level._effect[ "vfx_turret_light_175" ], self, "tag_fx" );
            return;
        }
        
        if ( struct.script_index == "2" )
        {
            playfxontag( level._effect[ "vfx_turret_light_2" ], self, "tag_fx" );
            return;
        }
        
        if ( struct.script_index == "3" )
        {
            playfxontag( level._effect[ "vfx_turret_light_3" ], self, "tag_fx" );
        }
    }
}

// Namespace namespace_2bdecc05800910ee
// Params 2
// Checksum 0xa5000507, Offset: 0x25f2
// Size: 0xb3
function function_c9f65560d0025f19( var_dfbd063361cf6826, var_62775975f5489e9f )
{
    self endon( #"death" );
    
    if ( isvector( var_62775975f5489e9f ) )
    {
        self.soundorg = spawn( "script_model", var_62775975f5489e9f );
    }
    else
    {
        self.soundorg = spawn( "script_model", self.origin );
    }
    
    self.soundorg setmodel( "tag_origin" );
    waitframe();
    
    if ( !var_dfbd063361cf6826 )
    {
        self.soundorg playloopsound( "cp_laser_idle" );
        return;
    }
    
    self.soundorg linkto( self, "tag_aim_pivot" );
    self.soundorg playloopsound( "cp_laser_mvmt" );
}

// Namespace namespace_2bdecc05800910ee
// Params 1
// Checksum 0x11917eb4, Offset: 0x26ad
// Size: 0x49
function function_2e9b676efd2c487( var_dfbd063361cf6826 )
{
    if ( !var_dfbd063361cf6826 )
    {
        self.soundorg stoploopsound( "cp_laser_idle" );
    }
    else
    {
        self.soundorg stoploopsound( "cp_laser_mvmt" );
    }
    
    self.soundorg delete();
}

/#

    // Namespace namespace_2bdecc05800910ee
    // Params 0
    // Checksum 0x2a29f8d5, Offset: 0x26fe
    // Size: 0x1dc, Type: dev
    function function_5a04fbd2319d659()
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"scr_lasertrap_debug", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_lasertrap_debug", 0 ) != 0 && isdefined( level.var_fe18ff6ea6360f80 ) )
            {
                for ( i = 0; i < level.var_fe18ff6ea6360f80.size ; i++ )
                {
                    trap = level.var_fe18ff6ea6360f80[ i ];
                    sphere( trap.origin, 32, ( 1, 0, 0 ), 0, 1 );
                    text = "<dev string:x24>";
                    
                    if ( isdefined( trap.defuseobj ) )
                    {
                        text = "<dev string:x25>" + trap.defuseobj getscriptablepartstate( "<dev string:x30>" );
                        turrets = trap.turrets ?? trap.defuseobj.turret_structs;
                        
                        foreach ( turret in turrets )
                        {
                            if ( isdefined( turret ) )
                            {
                                line( trap.origin, turret.origin, ( 1, 1, 0 ), 0.8, 0, 1 );
                            }
                        }
                    }
                    else
                    {
                        text = "<dev string:x43>";
                    }
                    
                    print3d( trap.origin, text, ( 1, 0, 0 ), 1, 0.7, 1, 0 );
                }
            }
            
            waitframe();
        }
    }

#/
