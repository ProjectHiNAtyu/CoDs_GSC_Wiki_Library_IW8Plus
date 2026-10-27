// scripts\mp\zm\gametypes\zm_rb_survival.gsc  (hash_6fed2c217e2e21e7.gscc) (size: 17463 Bytes / 0x4437 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff5a28a6 (4284098726)
// size ...... 17463 (0x4437)
// includes .. 27  (offset: 0x40cf)
// strings ... 35  (offset: 0x41a7)
// dev strs .. 10  (offset: 0x43bb)
// exports ... 34  (offset: 0x2caf)
// cseg ...... 0x32b + 0x2984 (0x2caf)
// imports ... 121 (offset: 0x31ff)
// animtree1 . 0   (offset: 0x4437)
// animtree2 . 0   (offset: 0x4437)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\magicbox;
#using scripts\mp\outofbounds;
#using scripts\mp\pack_a_punch;
#using scripts\mp\perk_machines;
#using scripts\mp\spawnlogic;
#using scripts\mp\wallbuy;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\globallogic;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_player_damage;

#namespace zm_rb_survival;

// Namespace zm_rb_survival
// Params 0
// Checksum 0xc2e67923, Offset: 0x349
// Size: 0x21f
function main()
{
    level.callbackstartgametype = &void;
    level.callbackplayeractive = &void;
    level.callbackplayerconnect = &void;
    level.callbackplayerdisconnect = &void;
    level.callbackplayerkilled = &void;
    level.callbackplayerlaststand = &void;
    level.callbackplayermigrated = &void;
    level.var_16eab40d8f2ae445 = &void;
    globallogic::init();
    globallogic::setupcallbacks();
    level.var_309f8f867be84cac = level.callbackplayerdamage;
    level.callbackplayerdamage = &callback_playerdamage;
    level.var_a77da733a6ccbb76 = "zm_base_magicbox_scaling";
    level.var_1de073b03eb3e525 = "zm_base_equipment_scaling";
    level.getspawnpoint = &get_player_spawn_point;
    level.forceteamassignmentoverride = &zm::function_824ea4febe3f5318;
    zm::init();
    level thread zone_spawner::init_zone_spawner();
    level.var_b7013d9ccd1b171a = 1;
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    function_27459deefbb3631d();
    var_3e6257afaa75758 = "zone";
    
    /#
        var_3e6257afaa75758 = getdvar( @"hash_a5647468cd17c478", var_3e6257afaa75758 );
    #/
    
    agent_spawner::function_da6c989ec2c8c5fa( var_3e6257afaa75758 );
    level zm_round_logic::init_zm_round_logic();
    level zm_music::init_zm_music();
    level callback::add( "on_zombie_ai_spawned", &rb_on_zombie_ai_spawned );
    level callback::add( #"player_connect", &callback_playerconnect );
    level callback::add( #"player_connect", &function_89f0f12105109e23 );
    level.poiname = function_64c3a9143299dacb();
    utility::registersharedfunc( #"zm_survival", #"get_survival_poi_name", &function_64c3a9143299dacb );
    utility::registersharedfunc( #"rampage_inducer", #"override_round_accelerant", &override_round_accelerant );
    
    if ( !isdefined( level.var_6efaf96150acaafa ) )
    {
        level.var_6efaf96150acaafa = 1;
    }
    
    if ( !isdefined( level.var_5ab0498cf1ac995e ) )
    {
        level.var_5ab0498cf1ac995e = 1;
    }
    
    level thread function_bd1a465e18e6ca15();
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x5571d1ed, Offset: 0x570
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x4e8219d7, Offset: 0x581
// Size: 0xe
function function_27459deefbb3631d()
{
    setnojipscore( 0 );
    setnojiptime( 0 );
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xc58d1195, Offset: 0x597
// Size: 0x2
function void()
{
    
}

// Namespace zm_rb_survival
// Params 1
// Checksum 0x94ae10ba, Offset: 0x5a1
// Size: 0x152
function function_89f0f12105109e23( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    outofbounds::enableoobimmunity( self );
    val::set( "survival_spawn", "ignore_playable_area_check", 1 );
    self waittill( #"spawned" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    level utility::flag_wait( "scriptables_ready" );
    zone_name = level.poiname;
    var_f121848267539693 = function_b9655117246af792( self );
    assert( isdefined( var_f121848267539693 ), "<dev string:x24>" + zone_name );
    
    if ( !isdefined( var_f121848267539693 ) )
    {
        var_f121848267539693 = zone_manager::function_aeaa8dd788ed9b16( undefined, undefined, undefined, [ zone_name ] );
    }
    
    if ( isdefined( var_f121848267539693 ) )
    {
        self setadditionalstreamposuntilcleared( var_f121848267539693.origin, 3 );
        level utility::flag_wait( "survival_map_zone_setup_finished" );
        self dontinterpolate();
        
        while ( self.sessionstate == "spectator" )
        {
            waitframe();
        }
        
        self setorigin( var_f121848267539693.origin );
        self setplayerangles( var_f121848267539693.angles );
    }
    
    level utility::flag_wait( "begin_round_logic" );
    
    if ( isdefined( var_f121848267539693.origin ) )
    {
        self clearadditionalstreampos();
    }
    
    outofbounds::disableoobimmunity( self );
    val::reset( "survival_spawn", "ignore_playable_area_check" );
}

// Namespace zm_rb_survival
// Params 1
// Checksum 0x4d4686ff, Offset: 0x6fb
// Size: 0x81
function callback_playerconnect( params )
{
    self waittill( #"begin" );
    
    if ( !isdefined( level.player ) )
    {
        spawnpoints = getentarray( "mp_global_intermission", #classname );
        self spawn( spawnpoints[ 0 ].origin, spawnpoints[ 0 ].angles );
        self.maxhealth = 10000000;
        self.health = 10000000;
    }
}

// Namespace zm_rb_survival
// Params 18
// Checksum 0xb59b9b43, Offset: 0x784
// Size: 0x25e
function callback_playerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    if ( function_155aa95b980a1663( einflictor, eattacker, smeansofdeath ) )
    {
        return;
    }
    
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.fdistance = fdistance;
    dmg_struct.objweapon = objweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.var_2300d396e46c0fe7 = var_2300d396e46c0fe7;
    dmg_struct.var_cdd29ad5d1362c2 = var_cdd29ad5d1362c2;
    dmg_struct.idamage = idamage;
    dmg_struct.additionalparams = additionalparams;
    dmg_struct = zm_player_damage::function_8509d988e53f1c55( dmg_struct );
    [[ level.var_309f8f867be84cac ]]( dmg_struct.einflictor, dmg_struct.eattacker, dmg_struct.idamage, dmg_struct.idflags, dmg_struct.smeansofdeath, dmg_struct.fdistance, dmg_struct.objweapon, dmg_struct.vpoint, dmg_struct.vdir, dmg_struct.shitloc, dmg_struct.timeoffset, dmg_struct.modelindex, dmg_struct.partname, dmg_struct.var_2300d396e46c0fe7, dmg_struct.var_cdd29ad5d1362c2 );
}

// Namespace zm_rb_survival
// Params 1, eflags: 0x4
// Checksum 0xd8b79e9, Offset: 0x9ea
// Size: 0x13
function private rb_on_zombie_ai_spawned( params )
{
    agent_utils::function_e6724888010b2003();
}

// Namespace zm_rb_survival
// Params 3, eflags: 0x4
// Checksum 0x492849ec, Offset: 0xa05
// Size: 0xaa, Type: bool
function private function_155aa95b980a1663( einflictor, eattacker, smeansofdeath )
{
    attackent = eattacker ?? einflictor;
    
    if ( isdefined( attackent ) && attackent vehicle::is_vehicle() )
    {
        if ( attackent.occupants.size == 0 && !isdefined( attackent.driver ) && !attackent.var_19a36b17776e8e85 )
        {
            return true;
        }
        else if ( attackent vehicle_isphysveh() && !attackent vehphys_isgroundvehicle() )
        {
            if ( smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_IMPACT" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_rb_survival
// Params 0, eflags: 0x4
// Checksum 0xd18bb74d, Offset: 0xab8
// Size: 0x1f4
function private get_player_spawn_point()
{
    if ( !self.hasspawned )
    {
        if ( zm_save::function_fcccc3d2a616b1c7() )
        {
            level utility::flag_wait( "survival_map_zone_setup_finished" );
            zone_name = zm_save::get_saved_spawn_zone();
            
            if ( isdefined( zone_name ) )
            {
                spawn_point = zm_player::function_c107082b3aabba7d( zone_name );
                
                if ( isdefined( spawn_point ) )
                {
                    return spawn_point;
                }
            }
        }
        
        if ( !utility::flag( "begin_round_logic" ) )
        {
            spawnpoints = function_1742a508480a0134();
            
            if ( !isdefined( spawnpoints ) || spawnpoints.size < 4 )
            {
                spawnpoints = utility::getstructarray( "initial_spawn_points", "targetname" );
            }
            
            if ( spawnpoints.size < 4 )
            {
                if ( level.var_8fb8bca729cc4b96 )
                {
                    spawn_point = zm_player::function_c107082b3aabba7d( level.var_8fb8bca729cc4b96 );
                    
                    if ( spawn_point )
                    {
                        return spawn_point;
                    }
                }
                
                return spawnlogic::function_3f9d5fcfb93d4190( self );
            }
            
            foreach ( spawn_point in spawnpoints )
            {
                if ( isdefined( spawn_point.script_int ) )
                {
                    var_6787895101874fb4 = self getentitynumber();
                    
                    if ( var_6787895101874fb4 == spawn_point.script_int )
                    {
                        spawn_point.index = var_6787895101874fb4;
                        return spawn_point;
                    }
                }
            }
            
            return spawnpoints[ self getentitynumber() ];
        }
        
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    spawn_point = zm_player::function_4edc86bda6052f6e();
    
    if ( !isdefined( spawn_point ) )
    {
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( self.origin );
        spawn_point = zm_player::function_c107082b3aabba7d( var_8c4fe62d01999d1e.zone_name );
    }
    
    if ( !isdefined( spawn_point ) )
    {
        spawn_point = zm_player::function_c107082b3aabba7d( self.cached_zone_info.zone_struct.zone_name );
    }
    
    if ( !isdefined( spawn_point ) )
    {
        spawn_point = spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    return spawn_point;
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x8ef242e7, Offset: 0xcb5
// Size: 0x3c1
function function_bd1a465e18e6ca15()
{
    if ( !isdefined( level.s_zm_survival ) )
    {
        level.s_zm_survival = spawnstruct();
    }
    
    var_8356fac0d335ea17 = getscriptbundlenames( "zmsurvivalsettings" );
    
    if ( var_8356fac0d335ea17.size == 0 )
    {
        assertmsg( "<dev string:x4c>" + level.mapname );
        return;
    }
    
    var_5f49b6035f1a566b = getscriptbundle( var_8356fac0d335ea17[ 0 ] );
    level.s_zm_survival function_6c941889993a9c8( var_5f49b6035f1a566b );
    level utility::registersharedfunc( #"survival_mode", #"override_tedd_task", &function_bdab09e1f3f1448d );
    level.override_player_spawn_point = &function_bd2b56a286aa4b63;
    out_of_bounds_time = 5;
    
    /#
        setdvar( @"scr_outofboundstime", out_of_bounds_time );
    #/
    
    level.outofboundstime = out_of_bounds_time;
    
    if ( level.poiname == "null" )
    {
        /#
            if ( isofflinetoolrun() )
            {
                return;
            }
        #/
        
        assertmsg( "<dev string:x90>" + level.mapname + "<dev string:xdd>" );
        return;
    }
    
    level.s_zm_survival.var_e4e84f6eeb50ec46 = level.poiname;
    level.var_fb0a5dab5ac2975f = 8;
    level thread function_f4643c06ba611029();
    register_anywhere_but_here_teleport_destinations();
    function_1d180341eadd660();
    level utility::flag_wait( "scriptables_ready" );
    
    foreach ( flag in level.s_zm_survival.var_17b8a8c092b3c9fa )
    {
        if ( !utility::flag( flag ) )
        {
            level utility::flag_set( flag );
        }
    }
    
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ] ) && isdefined( level.s_zm_survival.poidata[ level.poiname ].var_756e8dcc2cfa67b4 ) )
    {
        foreach ( info in level.s_zm_survival.poidata[ level.poiname ].var_756e8dcc2cfa67b4 )
        {
            if ( !utility::flag( info.var_1395ff2ff4783844 ) )
            {
                level utility::flag_set( info.var_1395ff2ff4783844 );
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"zm_rb_survival", #"power_flag_override" ) )
    {
        level utility::callsharedfunc( #"zm_rb_survival", #"power_flag_override" );
    }
    
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ] ) && isdefined( level.s_zm_survival.poidata[ level.poiname ].var_1cec74c00ff1430d ) )
    {
        activateworldevent( level.s_zm_survival.poidata[ level.poiname ].var_1cec74c00ff1430d );
    }
    
    function_5a62bcbbab318ca4();
    level thread setup_magicbox();
    level thread function_e3072fc2ae641bda();
    level thread function_3a6c72a559f7f270();
    level thread function_1a25031c5c7de053();
    level thread disable_doorbuys();
    function_382d73e05b2194a4();
}

// Namespace zm_rb_survival
// Params 0, eflags: 0x4
// Checksum 0xb4138391, Offset: 0x107e
// Size: 0x8a
function private function_382d73e05b2194a4()
{
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ].var_51edbb5a3e8bb89 ) )
    {
        var_3fad51515248400f = level.s_zm_survival.poidata[ level.poiname ].var_51edbb5a3e8bb89;
    }
    else
    {
        var_3fad51515248400f = "intermission_camera_" + level.poiname;
    }
    
    level.var_e35ab30242703f86 = utility::getstructarray( var_3fad51515248400f, "targetname" );
}

// Namespace zm_rb_survival
// Params 1
// Checksum 0x864685b0, Offset: 0x1110
// Size: 0x201
function function_6c941889993a9c8( var_5f49b6035f1a566b )
{
    self.var_17b8a8c092b3c9fa = [];
    
    foreach ( info in var_5f49b6035f1a566b.var_17b8a8c092b3c9fa )
    {
        self.var_17b8a8c092b3c9fa[ self.var_17b8a8c092b3c9fa.size ] = info.var_1395ff2ff4783844;
    }
    
    self.var_13f0e2a6fe9e1680 = var_5f49b6035f1a566b.var_f89ab59f4dbc2c42;
    
    if ( isdefined( var_5f49b6035f1a566b.var_64fe6f9606f42fd4 ) )
    {
        self.var_64fe6f9606f42fd4 = var_5f49b6035f1a566b.var_64fe6f9606f42fd4;
    }
    
    if ( isdefined( var_5f49b6035f1a566b.var_6dd76a5d852d130 ) )
    {
        self.doorbuyinfo = [];
        
        foreach ( info in var_5f49b6035f1a566b.var_6dd76a5d852d130 )
        {
            self.doorbuyinfo[ info.doorbuyflagname ] = info.var_8735789486b96c91;
        }
    }
    
    foreach ( info in var_5f49b6035f1a566b.var_47377ab0cfa0e815 )
    {
        self.poidata[ info.poiname ] = info;
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xc5944405, Offset: 0x1319
// Size: 0x198
function function_3a6c72a559f7f270()
{
    level utility::flag_wait( "begin_round_logic" );
    mapinfo = getactivemapinfobundle();
    var_89bbabeea696160 = undefined;
    
    if ( isdefined( mapinfo.var_ca80f058eecbf8f0 ) && mapinfo.var_ca80f058eecbf8f0 != %"" )
    {
        var_89bbabeea696160 = getscriptbundle( mapinfo.var_ca80f058eecbf8f0 );
    }
    
    if ( isdefined( var_89bbabeea696160.questitems ) )
    {
        foreach ( questitem in var_89bbabeea696160.questitems )
        {
            if ( !isdefined( questitem.questitem ) )
            {
                continue;
            }
            
            quest = getscriptbundle( questitem.questitem );
            
            foreach ( player in level.players )
            {
                zm_quest::function_98432f89334662d5( quest.ref, 0, player );
            }
            
            zm_quest::function_44fe3dcaa8005357();
        }
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x7b96fc8f, Offset: 0x14b9
// Size: 0x34
function function_64c3a9143299dacb()
{
    dvar_hash = hashcat( @"scr_", level.mapname, "_survival_poi" );
    return getdvar( dvar_hash, "null" );
}

// Namespace zm_rb_survival
// Params 1
// Checksum 0x4ec9fad0, Offset: 0x14f6
// Size: 0x5e, Type: bool
function is_survival_poi( name )
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return false;
    }
    
    map_name = level.mapname ?? level.mapinfobundle.mapname;
    return getdvar( hashcat( @"scr_", map_name, "_survival_poi" ) ) == name;
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xb3c43624, Offset: 0x155d
// Size: 0x626
function function_f4643c06ba611029()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zone_setup_finished" );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level utility::flag_wait( "zm_save_level_restore_complete" );
    }
    
    all_zones = zone_manager::get_all_zones();
    
    foreach ( zone in all_zones )
    {
        zone_struct = zone_manager::get_zone_struct( zone.script_zone_name );
        
        if ( zone_struct.is_enabled )
        {
            continue;
        }
        
        zone_manager::set_zone_enabled( zone.script_zone_name, 0 );
    }
    
    if ( level.s_zm_survival.var_13f0e2a6fe9e1680 != "" )
    {
        if ( isdefined( level.zone_manager.zone_distances[ level.s_zm_survival.var_13f0e2a6fe9e1680 ] ) )
        {
            foreach ( zone_name, dis in level.zone_manager.zone_distances[ level.s_zm_survival.var_13f0e2a6fe9e1680 ] )
            {
                if ( dis != 99999 )
                {
                    zone_manager::set_zone_enabled( zone_name, 0 );
                }
            }
        }
    }
    
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ] ) && isdefined( level.s_zm_survival.poidata[ level.poiname ].var_ddac443620d59614 ) )
    {
        if ( level.s_zm_survival.poidata[ level.poiname ].var_ddac443620d59614.size == 0 )
        {
            assertmsg( "<dev string:x108>" );
            return;
        }
        
        foreach ( zone_info in level.s_zm_survival.poidata[ level.poiname ].var_ddac443620d59614 )
        {
            if ( isdefined( all_zones[ zone_info.var_a7f03c100acaf3ac ] ) )
            {
                zone_manager::set_zone_enabled( zone_info.var_a7f03c100acaf3ac, 1 );
            }
        }
    }
    
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ] ) && isdefined( level.s_zm_survival.poidata[ level.poiname ].var_54f08a00e162bbf8 ) )
    {
        foreach ( zone_info in level.s_zm_survival.poidata[ level.poiname ].var_54f08a00e162bbf8 )
        {
            if ( isdefined( all_zones[ zone_info.var_a7f03c100acaf3ac ] ) )
            {
                zone_manager::set_zone_enabled( zone_info.var_a7f03c100acaf3ac, 0 );
            }
        }
    }
    
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ] ) && isdefined( level.s_zm_survival.poidata[ level.poiname ].var_a5d67952733ff54d ) )
    {
        if ( !isdefined( level.var_239f27811d6175db ) )
        {
            level.var_239f27811d6175db = [];
        }
        
        foreach ( zone_info in level.s_zm_survival.poidata[ level.poiname ].var_a5d67952733ff54d )
        {
            level.var_239f27811d6175db[ level.var_239f27811d6175db.size ] = zone_info.var_a7f03c100acaf3ac;
        }
    }
    
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ].var_33e5d1229cccfc7d ) )
    {
        var_6e08e0ccf60d6cd6 = getentarray( "OutOfBounds", #targetname );
        var_19a180ffde6ecc57 = [];
        
        foreach ( trig in var_6e08e0ccf60d6cd6 )
        {
            if ( trig.script_noteworthy == level.s_zm_survival.poidata[ level.poiname ].var_33e5d1229cccfc7d )
            {
                var_19a180ffde6ecc57[ var_19a180ffde6ecc57.size ] = trig;
            }
        }
        
        if ( var_19a180ffde6ecc57.size != 0 )
        {
            level.outofboundstriggers = var_19a180ffde6ecc57;
        }
    }
    
    level utility::flag_set( "survival_map_zone_setup_finished" );
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xc08f1086, Offset: 0x1b8b
// Size: 0x120
function function_bdab09e1f3f1448d()
{
    if ( utility::issharedfuncdefined( #"survival_mode", #"hash_f09f680a0b4acd00" ) )
    {
        level utility::callsharedfunc( #"survival_mode", #"hash_f09f680a0b4acd00" );
        return;
    }
    
    foreach ( loc in level.var_31998b7ccf36d152 )
    {
        if ( !issubstr( loc.script_location, level.poiname ) )
        {
            if ( isdefined( level.var_d78277198d5eb19c ) )
            {
                if ( !arraycontains( level.var_d78277198d5eb19c, loc.script_location ) )
                {
                    level.var_31998b7ccf36d152 = arrayremove( level.var_31998b7ccf36d152, loc );
                }
                
                continue;
            }
            
            level.var_31998b7ccf36d152 = arrayremove( level.var_31998b7ccf36d152, loc );
        }
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x966677cf, Offset: 0x1cb3
// Size: 0x52
function override_round_accelerant()
{
    var_55914eb3735a0730 = level.s_zm_survival.poidata[ level.poiname ].var_8eea21bd6e32ebf9;
    assert( isdefined( var_55914eb3735a0730 ), "<dev string:x13c>" );
    return utility::getstruct( var_55914eb3735a0730, "targetname" );
}

// Namespace zm_rb_survival
// Params 0, eflags: 0x4
// Checksum 0xfc3a7975, Offset: 0x1d0e
// Size: 0x11f
function private function_69be4248a50763fd()
{
    level utility::registersharedfunc( #"perk_machine", #"hash_dce0d2ce4dd5c816", &despawn_perk_machine );
    var_b675b6e84d394436 = level.s_zm_survival.poidata[ level.poiname ].var_d789793d84b318a;
    var_ba381686a4deee63 = utility::getstructarray( var_b675b6e84d394436, "target" );
    assert( var_ba381686a4deee63.size != 0, "<dev string:x171>" );
    instance = spawnstruct();
    instance.survival_spawn = 1;
    instance.script_currency = #"essence";
    
    foreach ( struct in var_ba381686a4deee63 )
    {
        struct perk_machines::function_e3d3bfcc06c89350( instance );
    }
}

// Namespace zm_rb_survival
// Params 1, eflags: 0x4
// Checksum 0x67428836, Offset: 0x1e35
// Size: 0xe, Type: bool
function private despawn_perk_machine( instance )
{
    return true;
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x4288df3a, Offset: 0x1e4c
// Size: 0x97
function function_5a62bcbbab318ca4()
{
    var_c4192bd6da027b59 = level.s_zm_survival.poidata[ level.poiname ].var_db4885da79b211a8;
    
    if ( !isdefined( var_c4192bd6da027b59 ) )
    {
        return;
    }
    
    var_ef5c80f53fe457fc = utility::getstruct( var_c4192bd6da027b59, "targetname" );
    
    if ( !isdefined( var_ef5c80f53fe457fc ) )
    {
        return;
    }
    
    if ( var_ef5c80f53fe457fc )
    {
        if ( !isdefined( level.var_db52bcfd04d45a7a ) )
        {
            level.var_db52bcfd04d45a7a = [];
        }
        
        level.var_db52bcfd04d45a7a[ level.var_db52bcfd04d45a7a.size ] = var_ef5c80f53fe457fc;
        var_ef5c80f53fe457fc thread pack_a_punch::init_pap_machine();
    }
}

// Namespace zm_rb_survival
// Params 1, eflags: 0x4
// Checksum 0xb41da7c1, Offset: 0x1eeb
// Size: 0xe0
function private function_3007fc53b527bfff( zone_name )
{
    var_d599255953c29193 = level.s_zm_survival.poidata[ zone_name ].var_242ab5ac67fff01e;
    var_9da9b77c0c78ffbf = utility::getstruct( var_d599255953c29193, "targetname" );
    var_759a4a0f92d9f29f = utility::getstructarray( var_9da9b77c0c78ffbf.target, "targetname" );
    
    foreach ( struct in var_759a4a0f92d9f29f )
    {
        level thread wallbuy::function_c2a9b9b2e4b90c0a( struct );
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xbc8350d3, Offset: 0x1fd3
// Size: 0x71
function function_1d180341eadd660()
{
    if ( !isdefined( level.s_zm_survival.poidata[ level.poiname ].var_223714241f2c4c73 ) )
    {
        return;
    }
    
    level.var_edd2cdda7ab7ec0 = "zmroundspawning:" + level.s_zm_survival.poidata[ level.poiname ].var_223714241f2c4c73;
    utility::flag_set( "round_spawning_bundle_set" );
}

// Namespace zm_rb_survival
// Params 0, eflags: 0x4
// Checksum 0x99670aa6, Offset: 0x204c
// Size: 0x320
function private setup_magicbox()
{
    level endon( #"game_ended" );
    poiinfo = level.s_zm_survival.poidata[ level.poiname ];
    
    if ( !isdefined( poiinfo ) )
    {
        return;
    }
    
    level utility::flag_wait( "magicbox_ready" );
    var_af04ee2075dd5fac = [];
    
    foreach ( var_93e4a0a8514ca47e, var_1bbb5557537e2c0c in level.var_e0e84452fe117b5f )
    {
        foreach ( s_magicbox_struct in var_1bbb5557537e2c0c )
        {
            if ( s_magicbox_struct.mdl_magicbox && !s_magicbox_struct.mdl_magicbox utility::ent_flag( "minimap_floor_setup_complete" ) )
            {
                s_magicbox_struct.mdl_magicbox utility::ent_flag_wait( "minimap_floor_setup_complete" );
                waitframe();
            }
            
            if ( s_magicbox_struct && s_magicbox_struct.script_noteworthy == poiinfo.var_326c1d770b75aa66 )
            {
                var_af04ee2075dd5fac[ var_af04ee2075dd5fac.size ] = s_magicbox_struct;
            }
            else
            {
                level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ] = arrayremove( level.var_e0e84452fe117b5f[ var_93e4a0a8514ca47e ], s_magicbox_struct );
                level.var_1bbb5557537e2c0c = arrayremove( level.var_1bbb5557537e2c0c, s_magicbox_struct );
            }
            
            if ( s_magicbox_struct )
            {
                s_magicbox_struct magicbox::hide_magicbox( 1, 0 );
                s_magicbox_struct.var_f14b2b4820b635e7 = undefined;
            }
        }
    }
    
    var_96f48887fd16d201 = 0;
    
    if ( isdefined( poiinfo.var_cf051c40806a3d88 ) )
    {
        foreach ( magicbox in var_af04ee2075dd5fac )
        {
            zone = zone_manager::function_90e5c3e2272b0130( magicbox.mdl_magicbox.origin );
            
            if ( zone.zone_name == poiinfo.var_cf051c40806a3d88 )
            {
                magicbox magicbox::show_magicbox( 1, 0 );
                magicbox.var_f14b2b4820b635e7 = 1;
                var_96f48887fd16d201 = 1;
                break;
            }
        }
    }
    else
    {
        random_start_magicbox = utility::array_random( var_af04ee2075dd5fac );
        random_start_magicbox magicbox::show_magicbox( 1, 0 );
        random_start_magicbox.var_f14b2b4820b635e7 = 1;
        var_96f48887fd16d201 = 1;
    }
    
    assert( var_96f48887fd16d201, "<dev string:x1a3>" );
    
    if ( var_af04ee2075dd5fac.size == 1 )
    {
        level.var_5542fc8f8eafa0c0 = 1;
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xdc3f48e4, Offset: 0x2374
// Size: 0x7f
function function_7152b12548dab9fe()
{
    var_88f0826b5783d9f = utility::getstruct( "anywhere_but_here_spawn_set_" + level.poiname, "script_noteworthy" );
    var_64ac6290776ff0ee = function_628bac9faa9d1e86( utility::getstructarray( var_88f0826b5783d9f.target, "targetname" ), self.origin, 1 );
    var_374f96df2dbe481f = utility::array_slice( var_64ac6290776ff0ee, 0, 4 );
    a_rand = arrayrandomize( var_374f96df2dbe481f );
    return a_rand[ 0 ];
}

// Namespace zm_rb_survival
// Params 1
// Checksum 0xbf06142c, Offset: 0x23fc
// Size: 0x98
function function_bd2b56a286aa4b63( player )
{
    var_205c3814cb6c7f62 = level.s_zm_survival.poidata[ level.poiname ].var_2de8c99103d83ad0;
    assert( isdefined( var_205c3814cb6c7f62 ), "<dev string:x225>" + level.poiname );
    s_survival_spawn_set = utility::getstruct( var_205c3814cb6c7f62, "targetname" );
    var_a04d4ac93cd4cea0 = utility::getstructarray( s_survival_spawn_set.target, "targetname" );
    return var_a04d4ac93cd4cea0[ player getentitynumber() ];
}

// Namespace zm_rb_survival
// Params 1
// Checksum 0xd9b45ca6, Offset: 0x249d
// Size: 0x98
function function_b9655117246af792( player )
{
    var_205c3814cb6c7f62 = level.s_zm_survival.poidata[ level.poiname ].var_dd74fdd3de3644d3;
    assert( isdefined( var_205c3814cb6c7f62 ), "<dev string:x278>" + level.poiname );
    s_survival_spawn_set = utility::getstruct( var_205c3814cb6c7f62, "targetname" );
    var_a04d4ac93cd4cea0 = utility::getstructarray( s_survival_spawn_set.target, "targetname" );
    return var_a04d4ac93cd4cea0[ player getentitynumber() ];
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x5fdd6ca1, Offset: 0x253e
// Size: 0x149
function function_1742a508480a0134()
{
    if ( isdefined( level.s_zm_survival.poidata[ level.poiname ].var_dd74fdd3de3644d3 ) )
    {
        var_205c3814cb6c7f62 = level.s_zm_survival.poidata[ level.poiname ].var_dd74fdd3de3644d3;
    }
    else
    {
        var_205c3814cb6c7f62 = "survival_spawn_set_" + level.poiname;
    }
    
    assert( isdefined( var_205c3814cb6c7f62 ), "<dev string:x278>" + level.poiname );
    s_survival_spawn_set = utility::getstruct( var_205c3814cb6c7f62, "targetname" );
    var_a04d4ac93cd4cea0 = utility::getstructarray( s_survival_spawn_set.target, "targetname" );
    
    foreach ( i, spawn_point in var_a04d4ac93cd4cea0 )
    {
        spawn_point.index = i;
        spawn_point.bucket = 0;
    }
    
    return var_a04d4ac93cd4cea0;
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xb7ce035c, Offset: 0x2690
// Size: 0x17f
function function_e3072fc2ae641bda()
{
    level utility::flag_wait( "begin_round_logic" );
    
    if ( !isdefined( level.a_s_doorbuys ) )
    {
        return;
    }
    
    if ( isdefined( level.s_zm_survival.var_64fe6f9606f42fd4 ) )
    {
        foreach ( doorbuy in level.a_s_doorbuys )
        {
            doorbuy.script_cost = 2000;
        }
    }
    
    if ( isdefined( level.s_zm_survival.doorbuyinfo ) )
    {
        foreach ( doorbuy in level.a_s_doorbuys )
        {
            if ( isdefined( level.s_zm_survival.doorbuyinfo[ doorbuy.script_flag_set ] ) )
            {
                doorbuy.script_cost = level.s_zm_survival.doorbuyinfo[ doorbuy.script_flag_set ];
            }
        }
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0x5ed89f79, Offset: 0x2817
// Size: 0x268
function disable_doorbuys()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    
    if ( !isdefined( level.s_zm_survival.poidata[ level.poiname ].var_b764b2c394f88a64 ) )
    {
        return;
    }
    
    foreach ( data in level.s_zm_survival.poidata[ level.poiname ].var_b764b2c394f88a64 )
    {
        foreach ( doorbuy in level.a_s_doorbuys )
        {
            if ( doorbuy.script_flag_set == data.var_1395ff2ff4783844 )
            {
                if ( isdefined( doorbuy.interact ) )
                {
                    doorbuy.interact.var_a0d364b16ee53ab6 = &"";
                    doorbuy.interact.var_df00f5fbf4a6d195 = 1;
                    
                    if ( isdefined( doorbuy.interact.doors ) )
                    {
                        foreach ( sub_door in doorbuy.interact.doors )
                        {
                            if ( isdefined( sub_door.minimap_scriptable ) )
                            {
                                sub_door.minimap_scriptable calloutmarkerping::function_608710c894185549();
                                sub_door.minimap_scriptable freescriptable();
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_rb_survival
// Params 0
// Checksum 0xdbda6ecb, Offset: 0x2a87
// Size: 0xd2
function register_anywhere_but_here_teleport_destinations()
{
    info = level.s_zm_survival.poidata[ level.poiname ].var_a44c2313670196a;
    
    if ( !isdefined( info ) || info.size == 0 )
    {
        return;
    }
    
    force_destinations = [];
    
    foreach ( dest in info )
    {
        force_destinations[ force_destinations.size ] = dest.var_a7f03c100acaf3ac;
    }
    
    zm_quest::function_fe2a9a31ab8fbcab( force_destinations );
}

// Namespace zm_rb_survival
// Params 0, eflags: 0x4
// Checksum 0x24b48b35, Offset: 0x2b61
// Size: 0x14e
function private function_1a25031c5c7de053()
{
    level utility::flag_wait( "begin_round_logic" );
    oob_dist = getdvarfloat( @"hash_139e934315e6cf5e", 0 );
    
    if ( oob_dist <= 0 )
    {
        return;
    }
    
    s_survival_spawn_set = utility::getstruct( "survival_spawn_set_" + level.poiname, "script_noteworthy" );
    survival_spawn_point = utility::getstructarray( s_survival_spawn_set.target, "targetname" )[ 0 ].origin;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player_dist = distance( player.origin, survival_spawn_point );
                
                if ( player_dist > oob_dist )
                {
                    player playlocalsound( #"evt_plr_oob_impact_main" );
                    thread gamelogic_zm::endgame( "none", game[ "end_reason" ][ "mp_faction_eliminated" ] );
                    return;
                }
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

