// scripts\mp\br\gametypes\br_searchseizure_quest.gsc  (hash_55ed7d43694734d8.gscc) (size: 35563 Bytes / 0x8aeb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a9d5d00 (983391488)
// size ...... 35563 (0x8aeb)
// includes .. 30  (offset: 0x8013)
// strings ... 106 (offset: 0x8103)
// dev strs .. 77  (offset: 0x8727)
// exports ... 74  (offset: 0x54f3)
// cseg ...... 0x8e9 + 0x4c0a (0x54f3)
// imports ... 256 (offset: 0x6083)
// animtree1 . 0   (offset: 0x8aeb)
// animtree2 . 0   (offset: 0x8aeb)
#using script_16ea1b94f0f381b3;
#using script_3b0670880a9f4b4f;
#using script_5218f92aaa1d8675;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\agents\br_agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dev;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\poi;

#namespace br_searchseizure_quest;

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xbc632991, Offset: 0x907
// Size: 0xf9
function getcontractdata( data )
{
    quest_init();
    data.funcs[ "onInit" ] = &task_oninit;
    data.funcs[ "onTeamAssigned" ] = &task_onteamassigned;
    data.funcs[ "onCancel" ] = &task_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &task_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &task_onplayerassimilated;
    data.funcs[ "onPlayerKilled" ] = &task_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_2426f1dfb0b8ab38;
    data.funcs[ "onPlayerDisconnect" ] = &task_onplayerdisconnect;
    data.funcs[ "onEnterGulag" ] = &task_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &task_onrespawn;
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xf3ba08a9, Offset: 0xa08
// Size: 0x21
function quest_init()
{
    quest_initvariables();
    quest_initfunctions();
    quest_initdialog();
    
    /#
        quest_initdevgui();
    #/
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x9c6581b1, Offset: 0xa31
// Size: 0x447
function quest_initvariables()
{
    level.br_searchseizure_task = spawnstruct();
    level.br_searchseizure_task.enabled = getdvarint( @"hash_bf18f9e007484fa5", 1 );
    level.br_searchseizure_task.time = getdvarint( @"hash_64a7b52adce89ea5", 240 );
    level.br_searchseizure_task.var_cfe44d60815ac19a = getdvarint( @"hash_8f30c2023a4a5765", 2500 );
    level.br_searchseizure_task.var_c29c08e07387b70c = getdvarint( @"hash_41ef549b795f9fc3", 15000 );
    level.br_searchseizure_task.var_c0f96ac85addf5b5 = getdvarint( @"hash_ddbf53085a7a7d1c", 5000 );
    level.br_searchseizure_task.var_9cf125382cf35ec7 = getdvarint( @"hash_b00ae4edb676deb6", 15000 );
    level.br_searchseizure_task.var_1da206fed773d5c9 = getdvarint( @"hash_1a693b17e369558c", 6000 );
    level.br_searchseizure_task.var_a2c7a6a1a8febc43 = getdvarint( @"hash_d33e01d1a7ed8dc6", 12500 );
    level.br_searchseizure_task.minaicount = getdvarint( @"hash_3b590a4a694673af", 2 );
    level.br_searchseizure_task.maxaicount = getdvarint( @"hash_ac6ab3e7f4c59a81", 5 );
    level.br_searchseizure_task.spawnaiindex = getdvarint( @"hash_fc51239397667145", 0 );
    level.br_searchseizure_task.var_44c555ec1fb9dc8 = getdvarint( @"hash_ab5a3352cfce280e", 0 );
    level.br_searchseizure_task.var_74f567fdabda923e = getdvarint( @"hash_cf9c5344c4606910", 0 );
    level.br_searchseizure_task.var_76b6c517942d8d1e = getdvarint( @"hash_6127b0a8716b968a", 0 );
    level.br_searchseizure_task.var_4f737f2d8bf010fe = getdvarint( @"hash_e8ffe4ab1d755918", 6 );
    level.br_searchseizure_task.var_bcc112f244b7ab9b = getdvarint( @"hash_6822a5ab6d0ee5b5", 1 );
    level.br_searchseizure_task.var_67ff82d200dbe6ae = getdvarint( @"hash_cdf23d9f5e7a81ec", 1 );
    level.br_searchseizure_task.var_8aa79b019d45222e = pow( level.br_searchseizure_task.var_cfe44d60815ac19a, 2 );
    level.br_searchseizure_task.var_af0363a4d21c67f4 = pow( level.br_searchseizure_task.var_c29c08e07387b70c, 2 );
    level.br_searchseizure_task.var_595b7683f016ec99 = pow( level.br_searchseizure_task.var_c0f96ac85addf5b5, 2 );
    level.br_searchseizure_task.var_bf2828601ef43b77 = pow( level.br_searchseizure_task.var_9cf125382cf35ec7, 2 );
    level.br_searchseizure_task.searchnodes = utility::getstructarray( "searchseizure_poi", "script_noteworthy" );
    
    /#
        level.br_searchseizure_task.var_c489b0e036133510 = getdvar( @"hash_1bce9dfd1fff45ea", "<dev string:x24>" );
        level.br_searchseizure_task.var_802aeb48b774ef4d = getdvarint( @"hash_b9f7bbf6802613de", 0 );
        level.br_searchseizure_task.var_8893265a3db5437d = getdvarint( @"hash_b9e4ba0c2eddf72d", 0 );
        level.br_searchseizure_task.var_8f62e44b49796fdc = getdvarint( @"hash_30164dafcddf7b6", 0 );
        level.br_searchseizure_task.var_cd5f5830843e4d = getdvarint( @"hash_90b26cc85cd96563", 0 );
        level.br_searchseizure_task.var_fc95f849df9871e4 = getdvarint( @"hash_e6bfe27f77965dd6", 0 );
        level.br_searchseizure_task.var_8cf5d4bf13f31d77 = getdvarint( @"hash_f48225c4e42e1051", 0 );
    #/
    
    if ( !isdefined( level.averagealliesz ) )
    {
        level.averagealliesz = 0;
    }
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x1691fb1f, Offset: 0xe80
// Size: 0x3c
function quest_initfunctions()
{
    if ( level.br_searchseizure_task.var_44c555ec1fb9dc8 )
    {
        namespace_1999aeb00a58bdf6::init();
    }
    
    level.missionitemcallbacks[ "brloot_vehiclekeys_contract" ] = &function_9676034e082b090b;
    level thread function_395d9776379d898a();
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xc8b541f2, Offset: 0xec4
// Size: 0x158
function quest_initdialog()
{
    game[ "dialog" ][ "mission_searchseizure_accept" ] = "srcs_wzan_sscs";
    game[ "dialog" ][ "mission_searchseizure_success" ] = "srcs_wzan_sscc";
    game[ "dialog" ][ "mission_searchseizure_fail_destroyed" ] = "srcs_wzan_scfv";
    game[ "dialog" ][ "mission_searchseizure_fail_lost" ] = "srcs_wzan_ssfl";
    game[ "dialog" ][ "mission_searchseizure_fail_time" ] = "srcs_wzan_sscf";
    game[ "dialog" ][ "mission_searchseizure_fail_gas" ] = "srcs_wzan_ssnx";
    game[ "dialog" ][ "mission_searchseizure_timer" ] = "srcs_wzan_sstm";
    game[ "dialog" ][ "mission_searchseizure_dist_far1" ] = "srcs_wzan_s150";
    game[ "dialog" ][ "mission_searchseizure_dist_far2" ] = "srcs_wzan_s151";
    game[ "dialog" ][ "mission_searchseizure_dist_close1" ] = "srcs_wzan_ss60";
    game[ "dialog" ][ "mission_searchseizure_dist_close2" ] = "srcs_wzan_ss61";
    game[ "dialog" ][ "mission_searchseizure_dz_cleared" ] = "srcs_wzan_sslg";
    game[ "dialog" ][ "mission_searchseizure_key" ] = "srcs_wzan_slsg";
    game[ "dialog" ][ "mission_searchseizure_airstrike" ] = "srcs_wzan_ssrs";
    game[ "dialog" ][ "mission_searchseizure_heli_arrive" ] = "srcs_wzan_sshl";
    game[ "dialog" ][ "mission_searchseizure_heli_destroyed" ] = "srcs_wzan_sshd";
    game[ "dialog" ][ "mission_searchseizure_heli_depart" ] = "srcs_wzan_sshp";
    game[ "dialog" ][ "mission_searchseizure_dropoff_coord" ] = "srcs_wzan_sspl";
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x240430b9, Offset: 0x1024
// Size: 0x29
function function_395d9776379d898a()
{
    level waittill( #"prematch_done" );
    ai_mp_controller::aibudget_registercategory( "searchseizure", 50 );
    br_agent_utils::function_b9a0e8dab46ee1bb( "searchseizure" );
}

/#

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x62a6d30c, Offset: 0x1055
    // Size: 0x10a, Type: dev
    function quest_initdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x29>" );
        devgui::add_devgui_func( "<dev string:x48>", "<dev string:x59>", &function_66e760604615c5e4 );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x81>", &function_550f615f25194ea7 );
        devgui::add_devgui_func( "<dev string:x95>", "<dev string:xa6>", &function_2bfa3e93c7d0f3de );
        devgui::add_devgui_func( "<dev string:xbc>", "<dev string:xcb>", &function_713eab3b8a1e6157 );
        devgui::add_devgui_func( "<dev string:xdc>", "<dev string:xeb>", &function_9f71ac7bf93fa7c4 );
        devgui::add_devgui_func( "<dev string:xff>", "<dev string:x116>", &function_49c54354541f12cd );
        devgui::add_devgui_func( "<dev string:x127>", "<dev string:x13b>", &function_35b512f3e7a384de );
        devgui::add_devgui_func( "<dev string:x149>", "<dev string:x15d>", &function_7136db42d1f65a2c );
        devgui::add_devgui_func( "<dev string:x16b>", "<dev string:x17c>", &function_db50b79e207712e2 );
        devgui::add_devgui_func( "<dev string:x18d>", "<dev string:x19f>", &function_e14a0c52985d5359 );
        devgui::add_devgui_func( "<dev string:x1b1>", "<dev string:x1c2>", &function_f40f558e3b254e39 );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace br_searchseizure_quest
// Params 1, eflags: 0x4
// Checksum 0xc18c76fc, Offset: 0x1167
// Size: 0x2f0
function private agent_spawngroup( var_7c075bd9283a510d )
{
    var_3673e9439496a8 = getclosestpointonnavmesh( self.origin );
    
    if ( !isdefined( var_3673e9439496a8 ) )
    {
        assertmsg( "<dev string:x1d7>" + self.origin + "<dev string:x1f7>" );
        return;
    }
    
    spawnpoints = getrandomnavpoints( var_3673e9439496a8, 1536, 64 );
    validspawnpoints = [];
    
    if ( !isdefined( spawnpoints ) )
    {
        assertmsg( "<dev string:x212>" + self.origin + "<dev string:x1f7>" );
        return;
    }
    
    var_3204c5c95d5c8d50 = randomintrange( level.br_searchseizure_task.minaicount, level.br_searchseizure_task.maxaicount );
    spawnpoints = arrayrandomize( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( distance2dsquared( self.origin, spawnpoint ) <= pow( 192, 2 ) || !ai_behavior::function_628be322cfae6d24( spawnpoint, 64, 512, 128 ) )
        {
            continue;
        }
        
        validspawnpoints[ validspawnpoints.size ] = spawnpoint;
        
        if ( validspawnpoints.size % 2 == 0 && validspawnpoints.size != var_3204c5c95d5c8d50 )
        {
            validspawnpoints[ validspawnpoints.size ] = spawnpoint;
        }
        
        if ( validspawnpoints.size == var_3204c5c95d5c8d50 )
        {
            break;
        }
    }
    
    assert( validspawnpoints.size == var_3204c5c95d5c8d50, "<dev string:x236>" + validspawnpoints.size + "<dev string:x270>" + var_3204c5c95d5c8d50 );
    spawnsetname = "guard";
    groupname = ai_mp_controller::function_391d43ea550a7a49();
    poiname = poi::poi_findpoioriginisin( validspawnpoints[ 0 ] );
    self.agents = [];
    self.groupname = groupname;
    
    for ( i = 0; i < validspawnpoints.size ; i++ )
    {
        tier = 1 + ( var_7c075bd9283a510d && i + 1 == validspawnpoints.size );
        agenttype = ai_mp_controller::function_b86341658788836c( undefined, undefined, poiname, spawnsetname, undefined, tier, undefined );
        agent = ai_mp_controller::ai_mp_requestspawnagent( agenttype, validspawnpoints[ i ], ( 0, randomint( 360 ), 0 ), "high", "searchseizure", "searchTask", groupname, undefined, undefined, poiname, 0, 0, 0, undefined, 0 );
        
        if ( isdefined( agent ) )
        {
            if ( isagent( agent ) )
            {
                agent.groupname = groupname;
                agent thread ai_behavior::behavior_GuardWander( agent, 256, 256, validspawnpoints[ i ] );
                self.agents[ self.agents.size ] = agent;
            }
            else
            {
                println( "<dev string:x27e>" );
            }
            
            continue;
        }
        
        println( "<dev string:x2c8>" );
    }
}

// Namespace br_searchseizure_quest
// Params 2, eflags: 0x4
// Checksum 0x43627166, Offset: 0x145f
// Size: 0x5a
function private function_edca3998c212e72d( baseaccuracy, time )
{
    self endon( #"death" );
    prevaccuracy = self.baseaccuracy;
    self.baseaccuracy = baseaccuracy;
    utility::waittill_notify_or_timeout( "damage", time );
    self.baseaccuracy = prevaccuracy;
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xcc2c6c3b, Offset: 0x14c1
// Size: 0x236
function helicopter_leave()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"crashing" );
    self clearlookatent();
    self setmaxpitchroll( 0, 0 );
    self notify( #"leaving" );
    var_afb8f3b781e97c77 = 3;
    flightheightoffset = ( 0, 0, 1000 );
    var_7de37a63fdf1b0f = self.origin + flightheightoffset;
    leavestart = undefined;
    leavegoal = undefined;
    leaveangles = undefined;
    
    while ( var_afb8f3b781e97c77 > 0 )
    {
        flightpath = killstreak_utility::function_9c51f918f2c46115( var_7de37a63fdf1b0f, self.angles, 350, 25000 );
        
        if ( isdefined( flightpath.end ) )
        {
            leavestart = flightpath.start;
            leavegoal = flightpath.end;
            leaveangles = flightpath.angles;
            break;
        }
        
        var_7de37a63fdf1b0f += ( 0, 0, 1000 );
        var_afb8f3b781e97c77--;
        wait 0.05;
    }
    
    if ( !isdefined( leavegoal ) )
    {
        chopper_support::choppersupport_crash( 100 );
        chopper_support::choppersupport_explode();
        return;
    }
    
    turnspeed = 150;
    ascendspeed = 50;
    self setyawspeed( turnspeed, 50, 50, 0.5 );
    self settargetyaw( leaveangles[ 1 ] );
    self vehicle_setspeed( ascendspeed, 25 );
    pathgoal = leavestart;
    self setvehgoalpos( pathgoal, 1 );
    self waittill( #"goal" );
    failsafetime = 0;
    
    while ( failsafetime < 2 )
    {
        currentyaw = ( 0, self.angles[ 1 ], 0 );
        yawdiff = leaveangles - currentyaw;
        
        if ( abs( yawdiff[ 1 ] ) < 5 )
        {
            break;
        }
        
        failsafetime += level.framedurationseconds;
        waitframe();
    }
    
    self setmaxpitchroll( 15, 15 );
    self vehicle_setspeed( 150, self.accel );
    self setvehgoalpos( leavegoal, 1 );
    self setneargoalnotifydist( 1000 );
    utility::waittill_any_timeout( 10, "near_goal" );
    chopper_support::choppersupport_cleanup( 0 );
}

// Namespace br_searchseizure_quest
// Params 3
// Checksum 0xac53b6e8, Offset: 0x16ff
// Size: 0xe8
function helicopter_start( position, var_530a642361ea8773, initaltarget )
{
    var_be8ad6f67090e389 = spawnstruct();
    var_be8ad6f67090e389.health = 5000;
    var_be8ad6f67090e389.speed = 100;
    var_be8ad6f67090e389.accel = 40;
    var_be8ad6f67090e389.turret_ammo = 16;
    var_be8ad6f67090e389.turret_cooldown = 3;
    var_be8ad6f67090e389.var_e3b4cbb02d09d139 = 0.1;
    var_be8ad6f67090e389.accuracy = 35;
    var_be8ad6f67090e389.range_squared = 4000000;
    var_be8ad6f67090e389.team = "team_hundred_ninety_four";
    position += ( 0, 0, 1000 );
    escortheli = namespace_1999aeb00a58bdf6::custom_chopper_spawn( var_530a642361ea8773, initaltarget, position, var_be8ad6f67090e389 );
    
    if ( !isdefined( escortheli ) )
    {
        return;
    }
    
    return escortheli;
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0x9485b3dc, Offset: 0x17f0
// Size: 0x64
function function_418c503e85a71447( teamname )
{
    br_contract_manager::createquestobjicon( "ui_map_icon_obj_searchseizure", "current" );
    objective_removeallfrommask( self.objectiveiconid );
    thread br_contract_manager::function_b6def068f44f04c9( self.objectiveiconid, teamname );
    objective_setshowdistance( self.objectiveiconid, 1 );
    objective_setdescription( self.objectiveiconid, &"mp_dmz_missions/contract_icon_label" );
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0xdf3e5008, Offset: 0x185c
// Size: 0xf7
function function_6307581ef43efcda( target, pulsate )
{
    self endon( #"task_ended" );
    self endon( #"task_cleanup" );
    
    if ( !isdefined( self.objectiveiconid ) )
    {
        assertmsg( "<dev string:x2f9>" + istrue( self.taskcompleted ) );
        return;
    }
    
    if ( isdefined( target ) )
    {
        if ( isvector( target ) )
        {
            objidpoolmanager::update_objective_position( self.objectiveiconid, target + ( 0, 0, 64 ) );
            objidpoolmanager::update_objective_setzoffset( self.objectiveiconid, 0 );
        }
        else if ( isent( target ) || target isscriptable() )
        {
            objidpoolmanager::update_objective_onentity( self.objectiveiconid, target );
            objidpoolmanager::update_objective_setzoffset( self.objectiveiconid, 64 );
        }
        
        objidpoolmanager::objective_set_pulsate( self.objectiveiconid, istrue( pulsate ) );
        return;
    }
    
    assertmsg( "<dev string:x33c>" );
}

// Namespace br_searchseizure_quest
// Params 2, eflags: 0x4
// Checksum 0xe062ce05, Offset: 0x195b
// Size: 0xc9, Type: bool
function private function_9676034e082b090b( pickup, player )
{
    if ( isdefined( pickup.instance ) && isdefined( pickup.instance.task ) )
    {
        instance = pickup.instance;
        task = instance.task;
        task function_6307581ef43efcda( task.vehicle );
        
        if ( isdefined( task.vehicle.useobject ) )
        {
            task.vehicle.useobject delete();
        }
        
        task.vehicle thread function_1c7ba859b3060a03( task, 0 );
        return true;
    }
    
    return false;
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xd369b2a0, Offset: 0x1a2d
// Size: 0x82
function vehicle_deathwatcher()
{
    self waittill( #"death" );
    params = spawnstruct();
    params.intvar = 0;
    task = self.task;
    task br_contract_manager::function_5c7e547ccc13711b( "br_searchseizure_quest_failure", params, "splash_list_br_contract_searchseizure" );
    level thread br_public::brleaderdialogteam( "mission_searchseizure_fail_destroyed", task.teams[ 0 ], 1, 2 );
    task thread function_416f76860d8e1df2( 0, undefined, "VehKilled" );
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x9f9ba4e, Offset: 0x1ab7
// Size: 0x25e
function function_efdff22c46be56d4()
{
    self endon( #"death" );
    self endon( #"kill_distance_watcher" );
    var_94cddf8599e3b27d = 0;
    var_273b04a31c00be6a = 0;
    var_eb04ca5ec73fdd6e = level.br_searchseizure_task.var_595b7683f016ec99 * pow( 1.5, 2 );
    var_c1056f750601071 = level.br_searchseizure_task.var_595b7683f016ec99 * pow( 1.5, 2 );
    
    if ( vehicle::get_ref() == %"hash_7ad965933c54dd53" )
    {
        utility::wait_time_in_ms( 5000 );
    }
    
    while ( true )
    {
        occupants = vehicle_occupancy::get_all_occupants( self );
        
        if ( occupants.size == 0 )
        {
            waitframe();
            continue;
        }
        
        if ( vehicle_damage::is_burning_down() )
        {
            self notify( #"kill_distance_watcher" );
            return;
        }
        
        if ( !var_94cddf8599e3b27d && distance2dsquared( self.origin, self.task.endnode.origin ) <= var_eb04ca5ec73fdd6e )
        {
            var_94cddf8599e3b27d = 1;
            self.task notify( #"hash_7760a0c3ba1dd3e4" );
            
            if ( utility::cointoss() )
            {
                level thread br_public::brleaderdialogteam( "mission_searchseizure_dist_far1", self.task.teams[ 0 ], 1, 2 );
            }
            else
            {
                level thread br_public::brleaderdialogteam( "mission_searchseizure_dist_far2", self.task.teams[ 0 ], 1, 2 );
            }
            
            waitframe();
            continue;
        }
        
        if ( !var_273b04a31c00be6a && level.br_searchseizure_task.spawnaiindex > 1 && distance2dsquared( self.origin, self.task.endnode.origin ) <= var_c1056f750601071 )
        {
            var_273b04a31c00be6a = 1;
            self.task notify( #"hash_d97d9ac9ec449687" );
            
            if ( utility::cointoss() )
            {
                level thread br_public::brleaderdialogteam( "mission_searchseizure_dist_close1", self.task.teams[ 0 ], 1, 2 );
            }
            else
            {
                level thread br_public::brleaderdialogteam( "mission_searchseizure_dist_close2", self.task.teams[ 0 ], 1, 2 );
            }
            
            /#
                iprintlnbold( "<dev string:x375>" );
            #/
            
            return;
        }
        
        wait 1;
    }
}

// Namespace br_searchseizure_quest
// Params 3
// Checksum 0x45c7de2d, Offset: 0x1d1d
// Size: 0xfa
function vehicle_spawntype( type, origin, angles )
{
    spawnposition = origin;
    spawnangles = angles * ( 0, 1, 0 );
    spawndata = spawnstruct();
    spawndata.origin = spawnposition;
    spawndata.angles = spawnangles;
    spawndata.spawntype = "LEVEL";
    vehicle = vehicle::spawn( type == "land" ? %"hash_7ad965933c54dd53" : %"hash_4c7e54cca5ad7fd8", spawndata );
    vehicle.fuel = vehicle_interact::get_data( vehicle vehicle::get_ref() ).maxfuel / 2;
    vehicle.var_1f4f9d64c04f05db = 1;
    vehicle.damagecallback = &vehicle_damagecallback;
    return vehicle;
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0x3e71c840, Offset: 0x1e20
// Size: 0xb2
function function_ba6d8cbd857b1557( task, vehicle )
{
    self endon( #"entitydeleted" );
    task endon( #"task_ended" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player::isinlaststand( player ) )
        {
            continue;
        }
        
        if ( vehicle vehicle_damage::is_burning_down() )
        {
            return;
        }
        
        if ( isdefined( task.keysforvehicle ) )
        {
            task function_6307581ef43efcda( vehicle );
            pickups::loothide( task.keysforvehicle );
        }
        
        vehicle thread function_1c7ba859b3060a03( task, 0 );
        self delete();
    }
}

// Namespace br_searchseizure_quest
// Params 14
// Checksum 0x783ff54b, Offset: 0x1eda
// Size: 0x11f
function vehicle_damagecallback( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( attacker.var_5d350bc7166e50ce && objweapon.basename == "toma_proj_mp" )
    {
        var_d12afbf0a81814b5 = vehicle::get_ref() == %"hash_7ad965933c54dd53" ? 3 : 5;
        damage = int( ceil( self.maxhealth / var_d12afbf0a81814b5 ) );
        self.debugdamage = 1;
    }
    
    self [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
    self.debugdamage = undefined;
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xea77adb2, Offset: 0x2001
// Size: 0x30
function function_979ccf2ba8ab5645()
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    childthread vehicle_deathwatcher();
    childthread vehicle_ownerwatcher();
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xba63b251, Offset: 0x2039
// Size: 0x1a4
function vehicle_ownerwatcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"vehicle_owner_update" );
        
        if ( !isdefined( self.owner ) || vehicle_damage::is_burning_down() )
        {
            continue;
        }
        
        driver = self.owner;
        
        if ( driver.team != self.task.team )
        {
            params = spawnstruct();
            params.intvar = 0;
            self.task br_contract_manager::function_5c7e547ccc13711b( "br_searchseizure_quest_target_lost", params, "splash_list_br_contract_searchseizure" );
            level thread br_public::brleaderdialogteam( "mission_searchseizure_fail_lost", self.task.teams[ 0 ], 1, 2 );
            self.task thread function_416f76860d8e1df2( 0, undefined, "VehStolen" );
            return;
        }
        
        driver childthread function_c98f2ebae3eab8f7( self );
        self.task br_contract_manager::function_5c7e547ccc13711b( "br_searchseizure_quest_deliver_asset", undefined, "splash_list_br_contract_searchseizure", driver.team, driver.sessionsquadid );
        level thread br_public::brleaderdialogteam( "mission_searchseizure_dropoff_coord", self.task.teams[ 0 ], 1, 2 );
        
        if ( self.task.objectiveactive )
        {
            self.task function_6307581ef43efcda( self.task.endnode.groundpos );
            continue;
        }
        
        self.task thread function_1b7e7f5f4ee14f8b( driver, self );
    }
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0x6147ea56, Offset: 0x21e5
// Size: 0x85
function function_c98f2ebae3eab8f7( vehicle )
{
    utility::waittill_any( "vehicle_seat_exit", "death_or_disconnect", "killed_player" );
    
    if ( isdefined( self.vehicle ) )
    {
        return;
    }
    
    if ( vehicle.occupants.size > 0 )
    {
        return;
    }
    
    vehicle.task br_contract_manager::function_5c7e547ccc13711b( "br_searchseizure_quest_deliver_asset", undefined, "splash_list_br_contract_searchseizure", self.team, self.sessionsquadid );
    vehicle.task function_6307581ef43efcda( vehicle );
}

// Namespace br_searchseizure_quest
// Params 4
// Checksum 0xd3965797, Offset: 0x2272
// Size: 0x9b
function vehicle_triggerspawn( origin, angles, radius, height )
{
    trigger = spawn( "trigger_radius", origin, 0, radius, height );
    trigger.effect = spawnfx( level._effect[ "vfx_smktrail_mortar" ], origin + ( 0, 0, 16 ) );
    trigger.angles = angles;
    trigger thread vehicle_triggerthink( self );
    triggerfx( trigger.effect );
    return trigger;
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0x6e9c1394, Offset: 0x2316
// Size: 0x20b
function vehicle_triggerthink( task )
{
    level endon( #"game_ended" );
    task endon( #"task_ended" );
    driver = undefined;
    
    while ( true )
    {
        self waittill( #"trigger", entity );
        
        if ( isdefined( entity ) && entity vehicle::is_vehicle() && !entity vehicle_damage::is_burning_down() )
        {
            if ( task != entity.task )
            {
                continue;
            }
            
            if ( level.br_searchseizure_task.var_76b6c517942d8d1e && isdefined( entity.task.endnode.agents ) && entity.task.endnode.agents.size > 0 )
            {
                continue;
            }
            
            occupant = vehicle_occupancy::get_driver( entity );
            
            if ( !isdefined( occupant ) )
            {
                occupants = vehicle_occupancy::get_all_occupants( entity );
                
                if ( occupants.size > 0 )
                {
                    keys = getarraykeys( occupants );
                    occupant = occupants[ keys[ 0 ] ];
                }
            }
            
            break;
        }
    }
    
    assert( isplayer( occupant ) );
    teamname = task.team;
    players = teams::getteamdata( teamname, "players" );
    task br_contract_manager::function_ba80ad6a1d946b85( 8, br_contract_manager::getquestindex( "searchseizure" ), occupant );
    rewards = task br_contract_manager::function_7d7e225a8f9c9222( "searchseizure", task.vehicle );
    
    if ( !br_public::istutorial() )
    {
        if ( isdefined( rewards[ "plunder" ] ) )
        {
            task br_contract_manager::function_1f816e3c3465df7e( "br_searchseizure_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "searchseizure" ), rewards[ "plunder" ], undefined, "splash_list_br_contract_searchseizure" );
        }
        
        level thread br_public::brleaderdialogteam( "mission_searchseizure_success", teamname, 1, 2 );
    }
    
    task thread function_416f76860d8e1df2( 1, rewards, "Win" );
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0x2054e8ba, Offset: 0x2529
// Size: 0x14d
function function_1c7ba859b3060a03( task, skipsuccess )
{
    self.islocked = 0;
    task.keysforvehicle = undefined;
    utility::function_7c10ea82c1e305b8( "single", "vehicle_use" );
    
    if ( skipsuccess )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( task.team, "players" ) )
    {
        player thread points::doscoreevent( #"hash_6b31daeaad06caa5" );
    }
    
    utility::function_7c10ea82c1e305b8( "single", "vehicle_use" );
    
    if ( self getscriptablehaspart( "lights" ) )
    {
        utility::function_7c10ea82c1e305b8( "car_alarm", "off" );
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( i % 2 == 0 )
            {
                utility::function_7c10ea82c1e305b8( "lights", "on" );
            }
            else
            {
                utility::function_7c10ea82c1e305b8( "lights", "off" );
            }
            
            wait 0.5;
        }
    }
}

// Namespace br_searchseizure_quest
// Params 3
// Checksum 0x1c7d6ee1, Offset: 0x267e
// Size: 0xe0
function task_createlootkey( origin, angles, ignoreent )
{
    self endon( #"task_ended" );
    self endon( #"task_cleanup" );
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( origin, angles );
    spawnoptions.critical = 1;
    item = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_vehiclekeys_contract", 1, spawnoptions );
    item.criticalitem = 1;
    item.task = self;
    self.keysforvehicle = item;
    
    while ( item getscriptablepartstate( "brloot_vehiclekeys_contract" ) != "visible" )
    {
        waitframe();
    }
    
    function_6307581ef43efcda( item.origin, 1 );
    level thread br_public::brleaderdialogteam( "mission_searchseizure_key", self.teams[ 0 ], 1, 2 );
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x19fafed3, Offset: 0x2766
// Size: 0x1ab
function function_e9b7855924dc5ad5()
{
    endnode = self.endnode;
    castresult = undefined;
    groundpos = undefined;
    starttrace = endnode.origin + ( 0, 0, 128 );
    endtrace = endnode.origin - ( 0, 0, 64 );
    contents = self.tasktype == "land" ? trace::create_contents( 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0 ) : trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
    castresult = trace::ray_trace( starttrace, endtrace, undefined, contents, 0, 0, 0 );
    
    if ( isdefined( castresult[ "hittype" ] != "hittype_none" ) && isdefined( castresult[ "position" ] ) )
    {
        groundpos = castresult[ "position" ];
    }
    else
    {
        groundpos = self.origin;
        assertmsg( "<dev string:x3ba>" + self.origin );
    }
    
    endnode.groundpos = groundpos;
    
    /#
        level.br_searchseizure_task.spawnaiindex = getdvarint( @"hash_fc51239397667145", 0 );
    #/
    
    if ( level.br_searchseizure_task.spawnaiindex > 1 && self.tasktype != "water" )
    {
        endnode agent_spawngroup();
    }
    
    endnode.trigger = vehicle_triggerspawn( groundpos, endnode.angles, 96, 128 );
    function_6307581ef43efcda( groundpos );
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0x6f0338e5, Offset: 0x2919
// Size: 0x249
function function_8cca5cf8ab873c98( type, tabletpos )
{
    startnodesinrange = function_6ccc77ab11eaab53( type, tabletpos, level.br_searchseizure_task.var_8aa79b019d45222e, level.br_searchseizure_task.var_af0363a4d21c67f4 );
    
    if ( startnodesinrange.size == 0 )
    {
        return;
    }
    
    var_b5eefdf655fda772 = undefined;
    var_c8f52e077a73a45d = undefined;
    var_e34b2a712c85d8c6 = undefined;
    
    if ( !level.br_circle_disabled )
    {
        var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( tabletpos );
        var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
    }
    
    bestnode = undefined;
    bestdist = level.br_searchseizure_task.var_c29c08e07387b70c;
    
    foreach ( node in startnodesinrange )
    {
        if ( node.script_type == "end" )
        {
            continue;
        }
        
        dist = distance2d( node.origin, tabletpos );
        
        if ( dist > bestdist )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_c8f52e077a73a45d = br_circle_util::function_472c93858e491e0a( node.origin );
            var_e34b2a712c85d8c6 = br_circle_util::function_b880c0f9998fdd69( var_c8f52e077a73a45d );
            
            if ( var_e34b2a712c85d8c6 < var_b5eefdf655fda772 )
            {
                continue;
            }
        }
        
        var_ac99ac222f6bbc72 = 0;
        
        if ( dist < level.br_searchseizure_task.var_a2c7a6a1a8febc43 )
        {
            if ( dist < level.br_searchseizure_task.var_1da206fed773d5c9 )
            {
                var_ac99ac222f6bbc72 = level.br_searchseizure_task.var_1da206fed773d5c9 - dist;
            }
        }
        else
        {
            var_ac99ac222f6bbc72 = dist - level.br_searchseizure_task.var_a2c7a6a1a8febc43;
        }
        
        if ( var_ac99ac222f6bbc72 < bestdist )
        {
            bestdist = var_ac99ac222f6bbc72;
            bestnode = node;
            bestnode.circletimeline = var_c8f52e077a73a45d;
            bestnode.var_b77210c587c94ed6 = var_e34b2a712c85d8c6;
            
            if ( var_ac99ac222f6bbc72 <= 0 )
            {
                break;
            }
        }
    }
    
    return bestnode;
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0x4b225f01, Offset: 0x2b6b
// Size: 0x232
function task_getendnode( type, startnode )
{
    var_f325ee4909e20270 = function_6ccc77ab11eaab53( type, startnode.origin, level.br_searchseizure_task.var_595b7683f016ec99, level.br_searchseizure_task.var_bf2828601ef43b77 );
    
    if ( var_f325ee4909e20270.size == 0 )
    {
        println( "<dev string:x3ec>" + startnode.origin + "<dev string:x433>" + type );
        return;
    }
    
    bestnode = undefined;
    bestdist = level.br_searchseizure_task.var_9cf125382cf35ec7;
    
    foreach ( node in var_f325ee4909e20270 )
    {
        if ( node.script_type == "start" )
        {
            continue;
        }
        
        dist = distance2d( node.origin, startnode.origin );
        
        if ( dist > bestdist )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_c8f52e077a73a45d = br_circle_util::function_472c93858e491e0a( node.origin );
            var_e34b2a712c85d8c6 = br_circle_util::function_b880c0f9998fdd69( var_c8f52e077a73a45d );
            
            if ( var_e34b2a712c85d8c6 < startnode.var_b77210c587c94ed6 )
            {
                continue;
            }
        }
        
        var_ac99ac222f6bbc72 = 0;
        
        if ( dist < level.br_searchseizure_task.var_a2c7a6a1a8febc43 )
        {
            if ( dist < level.br_searchseizure_task.var_1da206fed773d5c9 )
            {
                var_ac99ac222f6bbc72 = level.br_searchseizure_task.var_1da206fed773d5c9 - dist;
            }
        }
        else
        {
            var_ac99ac222f6bbc72 = dist - level.br_searchseizure_task.var_a2c7a6a1a8febc43;
        }
        
        if ( var_ac99ac222f6bbc72 < bestdist )
        {
            bestdist = var_ac99ac222f6bbc72;
            bestnode = node;
            
            if ( var_ac99ac222f6bbc72 <= 0 )
            {
                break;
            }
        }
    }
    
    return bestnode;
}

// Namespace br_searchseizure_quest
// Params 5
// Checksum 0xb5bb2697, Offset: 0x2da6
// Size: 0x18e
function function_6ccc77ab11eaab53( type, searchpos, mindistsq, maxdistsq, ignoreinuse )
{
    searchnodes = arrayrandomize( level.br_searchseizure_task.searchnodes );
    
    /#
        level.br_searchseizure_task.var_8893265a3db5437d = getdvarint( @"hash_b9e4ba0c2eddf72d", 0 );
        
        if ( level.br_searchseizure_task.var_8893265a3db5437d )
        {
            searchnodes = function_ae2a75500fd5615b();
        }
    #/
    
    if ( type == "water" )
    {
        mindistsq = undefined;
        maxdistsq = undefined;
    }
    
    nodesinrange = [];
    
    foreach ( node in searchnodes )
    {
        if ( isdefined( mindistsq ) && isdefined( maxdistsq ) )
        {
            distsq = distance2dsquared( node.origin, searchpos );
            
            if ( distsq < mindistsq || distsq > maxdistsq )
            {
                continue;
            }
        }
        
        if ( isdefined( type ) && node.script_string != type )
        {
            continue;
        }
        
        if ( !ignoreinuse && node.inuse )
        {
            continue;
        }
        
        nodesinrange[ nodesinrange.size ] = node;
    }
    
    return nodesinrange;
}

// Namespace br_searchseizure_quest
// Params 2, eflags: 0x4
// Checksum 0xe48db928, Offset: 0x2f3d
// Size: 0x229
function private function_d75fc9678df501fc( params, task )
{
    agent = self;
    attacker = params.eattacker;
    subcategory = agent.subcategory;
    
    if ( "searchTask" != subcategory )
    {
        return;
    }
    
    groupname = agent.groupname;
    
    if ( task.startnode.groupname == groupname )
    {
        if ( level.br_searchseizure_task.var_bcc112f244b7ab9b )
        {
            vehicle = agent.keysforvehicle;
            
            if ( isdefined( vehicle ) && vehicle vehicle::is_vehicle() && !vehicle vehicle_damage::is_burning_down() && vehicle.islocked )
            {
                if ( attacker.team == task.team )
                {
                    /#
                        attacker iprintlnbold( "<dev string:x43d>" );
                    #/
                }
                else
                {
                    /#
                        iprintlnbold( "<dev string:x469>" );
                    #/
                }
                
                task thread task_createlootkey( agent.origin, agent.angles, agent );
            }
        }
        
        task.startnode.agents = arrayremove( task.startnode.agents, agent );
        
        if ( task.startnode.agents.size == 0 )
        {
            /#
                iprintln( "<dev string:x48c>" );
            #/
        }
        
        return;
    }
    
    if ( task.endnode.groupname == groupname )
    {
        task.endnode.agents = arrayremove( task.endnode.agents, agent );
        
        if ( task.endnode.agents.size == 0 )
        {
            level thread br_public::brleaderdialogteam( "mission_searchseizure_dz_cleared", task.teams[ 0 ], 1, 2 );
            
            /#
                iprintln( "<dev string:x4ac>" );
            #/
        }
    }
}

// Namespace br_searchseizure_quest
// Params 3
// Checksum 0x58909c14, Offset: 0x316e
// Size: 0x73
function function_416f76860d8e1df2( success, rewards, endstate )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    thread function_c88b9ad5e77167a6();
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xf625f7da, Offset: 0x31e9
// Size: 0x21
function task_oninit()
{
    if ( !level.br_searchseizure_task.enabled )
    {
        return 0;
    }
    
    return function_fb781e11a0a616fc();
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xdd046651, Offset: 0x3213
// Size: 0xb1
function task_onteamassigned()
{
    self.category = "searchseizure";
    teamname = self.team;
    
    /#
        if ( !self.tablet.init )
        {
            if ( isdefined( self.startnode ) )
            {
                self.startnode.inuse = 0;
            }
            
            if ( isdefined( self.endnode ) )
            {
                self.endnode.inuse = 0;
            }
            
            br_contract_manager::endcontract( undefined, undefined, undefined, undefined, "<dev string:x4ca>" );
            return;
        }
    #/
    
    ai_mp_controller::function_2b1cc53b284373( &function_d75fc9678df501fc, self );
    function_9b7b13ffd01382fb( teamname );
    function_89737c9f5002144b();
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0x86a36029, Offset: 0x32cc
// Size: 0x1e
function task_onplayerkilled( attacker, victim )
{
    task_playerremoved( victim );
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0x47eda43c, Offset: 0x32f2
// Size: 0x15
function function_2426f1dfb0b8ab38( victim )
{
    task_playerremoved( victim );
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0x87cf511d, Offset: 0x330f
// Size: 0x15
function task_onplayerdisconnect( player )
{
    task_playerremoved( player );
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xf0a5d02e, Offset: 0x332c
// Size: 0x6e
function task_playerremoved( player )
{
    if ( player.team == self.team )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        
        if ( !br_quest_util::isteamvalid( self.team, filter ) )
        {
            function_416f76860d8e1df2( 0, undefined, "Killed" );
        }
    }
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xf5ab1215, Offset: 0x33a2
// Size: 0x20
function task_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xa1f6a265, Offset: 0x33ca
// Size: 0x20
function task_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
}

// Namespace br_searchseizure_quest
// Params 3
// Checksum 0x3950f651, Offset: 0x33f2
// Size: 0x71
function task_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        if ( !br_quest_util::isteamvalid( oldteam, level.contractmanager.defaultfilter ) )
        {
            thread task_oncancel( oldteam );
            return;
        }
        
        player br_contract_manager::uiobjectivehide();
        objective_removeclientfrommask( self.objectiveiconid, player );
    }
}

// Namespace br_searchseizure_quest
// Params 3
// Checksum 0x78f65af, Offset: 0x346b
// Size: 0x6f
function task_onplayerassimilated( player, oldteam, newteam )
{
    if ( !isdefined( self.vehicle ) )
    {
        return;
    }
    
    if ( newteam == self.team )
    {
        objective_addclienttomask( self.objectiveiconid, player );
        player br_contract_manager::uiobjectiveshow( "searchseizure" );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
    }
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xae8bf8a6, Offset: 0x34e2
// Size: 0x29
function task_oncancel( team )
{
    if ( self.team == team )
    {
        thread function_416f76860d8e1df2( 0, undefined, "Cancel" );
    }
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xebf61e54, Offset: 0x3513
// Size: 0x90
function function_9b7b13ffd01382fb( team )
{
    br_contract_manager::function_87e10a6e85d45d58( "searchseizure" );
    time = br_contract_manager::function_2f14979bf83bc3db( level.br_searchseizure_task.time );
    br_contract_manager::function_3fbbc67df36be7bb( time, 0 );
    thread function_57d17d293554e9f2();
    br_contract_manager::function_5c7e547ccc13711b( "br_searchseizure_quest_start_team", undefined, "splash_list_br_contract_searchseizure" );
    br_contract_manager::function_ba80ad6a1d946b85( 6, br_contract_manager::getquestindex( "searchseizure" ) );
    level thread br_public::brleaderdialogteam( "mission_searchseizure_accept", self.teams[ 0 ], 1, 2 );
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xf75d12c, Offset: 0x35ab
// Size: 0x435
function function_89737c9f5002144b()
{
    vehicle = undefined;
    vehicles = vehicle_getarrayinradius( self.startnode.origin, 512 );
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        validvehicles = [];
        vehiclename = self.tasktype == "land" ? %"hash_7ad965933c54dd53" : %"hash_4c7e54cca5ad7fd8";
        var_7d6c612ff93bbbca = vehicle_interact::get_data( vehiclename ).maxfuel / 4;
        
        foreach ( vehicle in vehicles )
        {
            if ( isdefined( vehicle.task ) )
            {
                continue;
            }
            
            if ( !( isdefined( vehicle.fuel ) && isdefined( var_7d6c612ff93bbbca ) ) )
            {
                continue;
            }
            
            if ( vehicle vehicle::get_ref() != vehiclename )
            {
                continue;
            }
            
            if ( vehicle.fuel < var_7d6c612ff93bbbca )
            {
                continue;
            }
            
            occupants = vehicle_occupancy::get_all_occupants( vehicle );
            
            if ( occupants.size > 0 )
            {
                continue;
            }
            
            if ( vehicle.health / vehicle.maxhealth < 0.33 )
            {
                continue;
            }
            
            if ( vehicle vehicle_damage::is_burning_down() )
            {
                continue;
            }
            
            validvehicles[ validvehicles.size ] = vehicle;
        }
        
        vehicle = utility::array_random( validvehicles );
    }
    
    if ( !isdefined( vehicle ) )
    {
        vehicle = vehicle_spawntype( self.tasktype, self.startnode.origin, self.startnode.angles );
    }
    
    vehicle.task = self;
    vehicle thread function_979ccf2ba8ab5645();
    vehicle utility::function_7c10ea82c1e305b8( "car_alarm", "on" );
    function_418c503e85a71447( self.team );
    function_6307581ef43efcda( vehicle );
    
    /#
        level.br_searchseizure_task.spawnaiindex = getdvarint( @"hash_fc51239397667145", 0 );
    #/
    
    if ( level.br_searchseizure_task.spawnaiindex % 2 == 1 )
    {
        self.startnode agent_spawngroup( level.br_searchseizure_task.var_bcc112f244b7ab9b );
    }
    
    if ( level.br_searchseizure_task.var_bcc112f244b7ab9b )
    {
        vehicle.islocked = 1;
        vehicle utility::function_7c10ea82c1e305b8( "single", "vehicle_unusable" );
        
        if ( level.br_searchseizure_task.var_67ff82d200dbe6ae )
        {
            tag = self.tasktype == "land" ? "tag_door_front_left" : "tag_steering_axis";
            tagorigin = vehicle gettagorigin( tag );
            radius = 96;
            fov = 120;
            hintstring = &"mp_br_ingame/unlock_vehicle";
            useobject = gameobjects::createhintobject( tagorigin, "HINT_BUTTON", undefined, hintstring, undefined, "duration_long", "show", radius, fov, radius, fov );
            useobject linkto( vehicle, tag );
            useobject thread function_ba6d8cbd857b1557( self, vehicle );
            vehicle.useobject = useobject;
        }
        
        if ( isdefined( self.startnode.agents ) && self.startnode.agents.size > 0 )
        {
            agent = self.startnode.agents[ self.startnode.agents.size - 1 ];
            agent.keysforvehicle = vehicle;
            utility::array_thread( self.startnode.agents, &function_edca3998c212e72d, 0.01, 5 );
        }
    }
    
    self.vehicle = vehicle;
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x25786142, Offset: 0x39e8
// Size: 0x27a
function function_c88b9ad5e77167a6()
{
    self notify( #"task_cleanup" );
    
    /#
        self.taskcompleted = 1;
    #/
    
    ai_mp_controller::function_52ec288d11c14408( &function_d75fc9678df501fc, self );
    
    if ( isdefined( self.vehicle.useobject ) )
    {
        self.vehicle.useobject delete();
    }
    
    if ( level.br_searchseizure_task.var_bcc112f244b7ab9b )
    {
        if ( isdefined( self.keysforvehicle ) )
        {
            pickups::loothide( self.keysforvehicle );
        }
        
        if ( self.vehicle.islocked )
        {
            self.vehicle thread function_1c7ba859b3060a03( self, 1 );
        }
    }
    
    self.vehicle.task = undefined;
    self.vehicle.damagecallback = undefined;
    self.vehicle = undefined;
    self.startnode.inuse = 0;
    
    if ( isdefined( self.endnode ) )
    {
        self.endnode.inuse = 0;
        
        if ( isdefined( self.endnode.trigger ) )
        {
            self.endnode.trigger.effect delete();
            self.endnode.trigger delete();
        }
    }
    
    if ( isdefined( self.tomafx ) )
    {
        foreach ( fxent in self.tomafx )
        {
            fxent delete();
        }
        
        self.tomafx = undefined;
    }
    
    if ( br_contract_manager::checkforactiveobjicon() )
    {
        br_contract_manager::deletequestobjicon();
        self.objectiveiconid = undefined;
    }
    
    if ( isdefined( self.helicopter ) )
    {
        self.helicopter notify( #"change_movement_type", &helicopter_leave );
        level thread br_public::brleaderdialogteam( "mission_searchseizure_heli_depart", self.teams[ 0 ], 1, 2 );
        return;
    }
    
    if ( isdefined( self.var_b5e82167fea8e32 ) )
    {
        wait 9;
        self.var_b5e82167fea8e32 delete();
    }
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0x81c08891, Offset: 0x3c6a
// Size: 0x146, Type: bool
function function_fb781e11a0a616fc( secondarymode )
{
    tasktype = undefined;
    
    /#
        if ( level.br_searchseizure_task.var_802aeb48b774ef4d )
        {
            level.br_searchseizure_task.var_c489b0e036133510 = getdvar( @"hash_1bce9dfd1fff45ea", "<dev string:x24>" );
            tasktype = level.br_searchseizure_task.var_c489b0e036133510;
        }
    #/
    
    startnode = function_8cca5cf8ab873c98( tasktype, self.tablet.origin );
    
    if ( !isdefined( startnode ) )
    {
        return false;
    }
    
    if ( !isdefined( startnode.script_string ) )
    {
        assertmsg( "<dev string:x4d5>" + startnode.origin + "<dev string:x4f8>" );
        startnode.script_string = "land";
    }
    
    tasktype = startnode.script_string;
    endnode = task_getendnode( tasktype, startnode );
    
    if ( !isdefined( endnode ) )
    {
        return false;
    }
    
    startnode.inuse = 1;
    endnode.inuse = 1;
    self.startnode = startnode;
    self.endnode = endnode;
    self.tasktype = tasktype;
    return true;
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0xab5dd103, Offset: 0x3db9
// Size: 0xf9
function function_57d17d293554e9f2()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    time = br_contract_manager::function_2f14979bf83bc3db( level.br_searchseizure_task.time );
    notifytime = time * 0.7;
    var_c7533d0469fd9f6a = time - notifytime;
    utility::wait_time_in_ms( notifytime * 1000 );
    
    if ( self.objectiveactive )
    {
        level thread br_public::brleaderdialogteam( "mission_searchseizure_timer", self.teams[ 0 ], 1, 2 );
    }
    
    utility::wait_time_in_ms( var_c7533d0469fd9f6a * 1000 );
    params = spawnstruct();
    params.intvar = 0;
    br_contract_manager::function_5c7e547ccc13711b( "br_searchseizure_quest_timer_expired", params, "splash_list_br_contract_searchseizure" );
    level thread br_public::brleaderdialogteam( "mission_searchseizure_fail_time", self.teams[ 0 ], 1, 2 );
    thread function_416f76860d8e1df2( 0, undefined, "Time" );
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0xd08440c, Offset: 0x3eba
// Size: 0x129
function function_1b7e7f5f4ee14f8b( player, vehicle )
{
    self endon( #"task_ended" );
    vehicle childthread function_efdff22c46be56d4();
    function_e9b7855924dc5ad5();
    self.objectiveactive = 1;
    
    if ( self.tasktype == "water" && level.br_searchseizure_task.var_44c555ec1fb9dc8 )
    {
        helicopter = helicopter_start( vehicle.origin, vehicle, player );
        self.helicopter = helicopter;
        level thread br_public::brleaderdialogteam( "mission_searchseizure_heli_arrive", self.teams[ 0 ], 1, 5 );
        
        /#
            iprintlnbold( "<dev string:x513>" );
        #/
        
        return;
    }
    
    if ( self.tasktype == "land" )
    {
        self waittill( #"hash_7760a0c3ba1dd3e4" );
    }
    
    streakowner = function_289b86f6cf671725();
    self.var_b5e82167fea8e32 = streakowner;
    thread tomastrike_start( vehicle, streakowner );
    level thread br_public::brleaderdialogteam( "mission_searchseizure_airstrike", self.teams[ 0 ], 1, 5 );
    
    /#
        iprintlnbold( "<dev string:x52e>" );
    #/
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xe79303d6, Offset: 0x3feb
// Size: 0x6b, Type: bool
function function_cd1076974fe4466( target )
{
    startpos = target.origin + ( 0, 0, 32 );
    endpos = target.origin + ( 0, 0, 2048 );
    tracepassed = trace::ray_trace_passed( startpos, endpos, target );
    return !tracepassed;
}

// Namespace br_searchseizure_quest
// Params 2
// Checksum 0x5789a70a, Offset: 0x405f
// Size: 0x4a4
function tomastrike_start( target, owner )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.tomafx = [];
    streakinfo = killstreak_utility::createstreakinfo( "toma_strike", owner );
    var_b65149b3708c8c59 = level.br_searchseizure_task.var_4f737f2d8bf010fe;
    
    if ( self.tasktype == "water" )
    {
        var_b65149b3708c8c59 *= 2;
    }
    
    while ( true )
    {
        if ( var_b65149b3708c8c59 == 0 )
        {
            foreach ( tomafx in self.tomafx )
            {
                tomafx delete();
            }
            
            self.tomafx = undefined;
            break;
        }
        
        /#
            level.br_searchseizure_task.var_fc95f849df9871e4 = getdvarint( @"hash_e6bfe27f77965dd6", 0 );
            
            if ( level.br_searchseizure_task.var_fc95f849df9871e4 )
            {
                waitframe();
                continue;
            }
        #/
        
        if ( function_cd1076974fe4466( target ) )
        {
            wait randomfloatrange( 3.5, 5 ) / 2;
            continue;
        }
        
        targetforward = anglestoforward( target.angles );
        targetright = anglestoright( target.angles );
        randomscalar = randomfloatrange( 4, 4.5 );
        targetvelocity = function_c80080f08382b88b( target );
        dotproduct = vectordot( targetforward, util_getvelocity( target ) );
        sign = dotproduct >= 0 ? 1 : -1;
        firepos = target.origin + targetforward * sign * targetvelocity * randomscalar;
        
        /#
            level.br_searchseizure_task.var_8cf5d4bf13f31d77 = getdvarint( @"hash_f48225c4e42e1051", 0 );
            
            if ( level.br_searchseizure_task.var_8cf5d4bf13f31d77 )
            {
                radius = 128;
                drawtimeseconds = 4;
                thread debug::drawsphere( target.origin + targetforward, radius, drawtimeseconds, ( 0, 1, 0 ) );
                thread debug::drawsphere( firepos, radius, drawtimeseconds, ( 1, 0, 0 ) );
            }
        #/
        
        var_d0b84b2215b34610 = 256;
        var_4d99e8552caf305a = owner toma_strike::findunobstructedfiringinfo( firepos, var_d0b84b2215b34610, targetforward, targetforward, targetright );
        excludeents = teams::getteamdata( self.team, "players" );
        enemiesnearby = entity::function_cd55d7a649cb9c44( var_4d99e8552caf305a.goalpos, var_d0b84b2215b34610 * 3, undefined, excludeents );
        
        if ( isdefined( enemiesnearby ) && enemiesnearby.size > 0 )
        {
            /#
                iprintln( "<dev string:x548>" );
            #/
            
            wait randomfloatrange( 3.5, 5 );
            continue;
        }
        
        fxent = undefined;
        
        if ( level.br_searchseizure_task.var_74f567fdabda923e )
        {
            fxent = spawnfx( level._effect[ "vfx_dom_flare" ], var_4d99e8552caf305a.goalpos );
        }
        else
        {
            foreach ( player in teams::getteamdata( self.team, "players" ) )
            {
                if ( isalive( player ) )
                {
                    fxent = spawnfxforclient( level._effect[ "vfx_dom_flare" ], var_4d99e8552caf305a.goalpos, player );
                }
            }
        }
        
        triggerfx( fxent );
        self.tomafx[ self.tomafx.size ] = fxent;
        owner toma_strike::tomastrike_firestrike( 1, var_4d99e8552caf305a, streakinfo );
        var_b65149b3708c8c59--;
        
        if ( self.tomafx.size == 2 )
        {
            self.tomafx[ 0 ] delete();
            self.tomafx[ 0 ] = undefined;
            function_cdc669dbc8ea2101( self.tomafx );
        }
        
        wait randomfloatrange( 3.5, 5 );
    }
}

// Namespace br_searchseizure_quest
// Params 0
// Checksum 0x44cc0b1e, Offset: 0x450b
// Size: 0x68
function function_289b86f6cf671725()
{
    fakeent = utility::spawn_tag_origin();
    fakeent.pers = [];
    fakeent.pers[ "deaths" ] = 0;
    fakeent.pers[ "nextKillstreakID" ] = 0;
    fakeent.team = "team_hundred_ninety_four";
    fakeent.var_5d350bc7166e50ce = 1;
    return fakeent;
}

/#

    // Namespace br_searchseizure_quest
    // Params 4, eflags: 0x4
    // Checksum 0x9127a828, Offset: 0x457c
    // Size: 0x52, Type: dev
    function private util_drawline( origin, offset, color, timeseconds )
    {
        drawframes = function_b2e02b0096f32bea( timeseconds );
        line( origin, origin + offset, color, 1, 0, drawframes );
    }

    // Namespace br_searchseizure_quest
    // Params 1, eflags: 0x4
    // Checksum 0xb20cdf77, Offset: 0x45d6
    // Size: 0x20, Type: dev
    function private function_b2e02b0096f32bea( seconds )
    {
        return int( seconds / level.framedurationseconds );
    }

    // Namespace br_searchseizure_quest
    // Params 3, eflags: 0x4
    // Checksum 0x2a0e8671, Offset: 0x45fe
    // Size: 0x72, Type: dev
    function private function_1bc0761d73fe113( type, origin, angles )
    {
        s = spawnstruct();
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        s.origin = origin;
        s.angles = angles;
        s.script_string = type;
        return s;
    }

#/

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xe8902ebc, Offset: 0x4678
// Size: 0x26
function function_c80080f08382b88b( target )
{
    velocity = util_getvelocity( target );
    return length( velocity );
}

// Namespace br_searchseizure_quest
// Params 1
// Checksum 0xbe2124d5, Offset: 0x46a7
// Size: 0x73
function util_getvelocity( target )
{
    velocity = 0;
    
    if ( target vehicle::is_vehicle() )
    {
        velocity = target vehicle_getvelocity();
    }
    else if ( isplayer( target ) )
    {
        if ( target vehicle::is_in_vehicle() )
        {
            target = vehicle::get_vehicle();
            velocity = target vehicle_getvelocity();
        }
        else
        {
            velocity = target getvelocity();
        }
    }
    else
    {
        assertmsg( "<dev string:x57d>" );
    }
    
    return velocity;
}

/#

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x607ea86b, Offset: 0x4723
    // Size: 0x32c, Type: dev
    function function_ae2a75500fd5615b()
    {
        debugnodes = [];
        land = "<dev string:x24>";
        water = "<dev string:x59d>";
        
        switch ( level.mapname )
        {
            case #"hash_57eba45b7ddbdcd6":
            case #"hash_63326ac3e12f8da0":
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -51349, 6236.79, 1238.39 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -51123.5, 8909.07, 1174.97 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -52709.4, 11245.9, 1248.17 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -53294.3, 14443.9, 1343.24 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -52033.7, 18110.6, 1145.72 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -48612.7, 19078.9, 1261.22 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -46117.7, 19062.5, 960.875 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -45767.2, 21738.1, 1443 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -43392.6, 17767.1, 210.041 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -46040.5, 13964.2, 1011.29 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -46357.2, 12518.7, 1159.66 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -46396.2, 10931.9, 946.973 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -43364.2, 8331.73, 383.033 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -42013.4, 7071.1, 593.468 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -40765.5, 5938.72, 748.72 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -40587.6, 2448.83, 349.103 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -41677.6, 853.808, 341.881 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -42782, -1174.98, 411.748 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -46258.9, -1449.15, 741.922 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -50514.3, -1018.65, 765.698 ) );
                break;
            case #"hash_4aa5d6e97851bdbd":
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -3018, -2847, 58 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -3728, -7366, 58 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -6051, 2047, 58 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -3653, 8514, 58 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( -588, 12965, 58 ) );
                debugnodes[ debugnodes.size ] = function_1bc0761d73fe113( land, ( 4338, 3048, 58 ) );
                break;
        }
        
        return debugnodes;
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x7b29d3b7, Offset: 0x4a57
    // Size: 0x4e, Type: dev
    function function_912675d268c5c463()
    {
        self endon( #"death_or_disconnect" );
        debugposoutputs = [];
        
        while ( true )
        {
            wait 1;
            
            if ( function_cd1076974fe4466( self ) )
            {
                iprintln( "<dev string:x5c4>" );
            }
            else
            {
                iprintln( "<dev string:x5cf>" );
            }
            
            waitframe();
        }
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x131ec394, Offset: 0x4aad
    // Size: 0x161, Type: dev
    function function_135c0badb62fbe72()
    {
        nodes = function_6ccc77ab11eaab53( undefined, self.origin, 0, pow( 8192, 2 ), 1 );
        vehicles = [];
        
        foreach ( node in nodes )
        {
            vehicle = vehicle_spawntype( node.script_string, node.origin, node.angles );
            vehicle.dontspawnhusk = 1;
            vehicle_occupancy::set_team( vehicle, "<dev string:x5de>" );
            vehicles[ vehicles.size ] = vehicle;
        }
        
        wait 15;
        
        foreach ( vehicle in vehicles )
        {
            vehicle::death( vehicle );
        }
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x50e59e5a, Offset: 0x4c16
    // Size: 0x1fd, Type: dev
    function function_65b7cb238af75296()
    {
        self endon( #"death_or_disconnect" );
        level.br_searchseizure_task.var_cd5f5830843e4d = getdvarint( @"hash_90b26cc85cd96563", 0 );
        var_cd5f5830843e4d = level.br_searchseizure_task.var_cd5f5830843e4d;
        debugtype = [];
        debugtype[ 0 ] = undefined;
        debugtype[ 1 ] = "<dev string:x24>";
        debugtype[ 2 ] = "<dev string:x59d>";
        debugtype[ 3 ] = "<dev string:x5e3>";
        showtype = debugtype[ var_cd5f5830843e4d ];
        
        if ( isdefined( showtype ) )
        {
            searchnodes = level.br_searchseizure_task.searchnodes;
            level.br_searchseizure_task.var_8893265a3db5437d = getdvarint( @"hash_b9e4ba0c2eddf72d", 0 );
            
            if ( level.br_searchseizure_task.var_8893265a3db5437d )
            {
                searchnodes = function_ae2a75500fd5615b();
            }
            
            foreach ( node in searchnodes )
            {
                color = node.script_string == "<dev string:x24>" ? ( 1, 0, 0 ) : ( 0, 0, 1 );
                
                if ( var_cd5f5830843e4d == 3 )
                {
                    util_drawline( node.origin, ( 0, 0, 9999 ), color, 30 );
                    continue;
                }
                
                if ( var_cd5f5830843e4d < 3 && node.script_string == showtype )
                {
                    util_drawline( node.origin, ( 0, 0, 9999 ), color, 30 );
                }
            }
        }
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0xea9bac8c, Offset: 0x4e1b
    // Size: 0xe5, Type: dev
    function function_9e1b01e941c30737()
    {
        foreach ( contract in level.contractmanager.activetablets )
        {
            if ( contract.type != "<dev string:x5e8>" )
            {
                continue;
            }
            
            if ( contract.task.tasktype != "<dev string:x59d>" )
            {
                continue;
            }
            
            util_drawline( contract.origin, ( 0, 0, 9999 ), ( 1, 0, 0 ), 30 );
        }
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x764c28e1, Offset: 0x4f08
    // Size: 0x20, Type: dev
    function function_66e760604615c5e4()
    {
        host = dev_mp::devfindhost();
        host thread function_912675d268c5c463();
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0xecac71a7, Offset: 0x4f30
    // Size: 0x215, Type: dev
    function function_550f615f25194ea7()
    {
        host = dev_mp::devfindhost();
        println( "<dev string:x603>" );
        println( "<dev string:x624>" );
        println( "<dev string:x63e>" + level.br_searchseizure_task.enabled );
        println( "<dev string:x65e>" + level.br_searchseizure_task.time );
        println( "<dev string:x67e>" + level.br_searchseizure_task.var_cfe44d60815ac19a );
        println( "<dev string:x69e>" + level.br_searchseizure_task.var_c29c08e07387b70c );
        println( "<dev string:x6be>" + level.br_searchseizure_task.var_c0f96ac85addf5b5 );
        println( "<dev string:x6de>" + level.br_searchseizure_task.var_9cf125382cf35ec7 );
        println( "<dev string:x6fe>" + level.br_searchseizure_task.var_1da206fed773d5c9 );
        println( "<dev string:x71e>" + level.br_searchseizure_task.var_a2c7a6a1a8febc43 );
        println( "<dev string:x73e>" + level.br_searchseizure_task.minaicount );
        println( "<dev string:x75e>" + level.br_searchseizure_task.maxaicount );
        println( "<dev string:x77e>" + level.br_searchseizure_task.spawnaiindex );
        println( "<dev string:x79e>" + level.br_searchseizure_task.var_44c555ec1fb9dc8 );
        println( "<dev string:x7be>" + level.br_searchseizure_task.var_74f567fdabda923e );
        println( "<dev string:x7de>" + level.br_searchseizure_task.var_76b6c517942d8d1e );
        println( "<dev string:x7fe>" + level.br_searchseizure_task.var_4f737f2d8bf010fe );
        println( "<dev string:x81e>" + level.br_searchseizure_task.var_bcc112f244b7ab9b );
        println( "<dev string:x603>" );
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x74666752, Offset: 0x514d
    // Size: 0x20, Type: dev
    function function_2bfa3e93c7d0f3de()
    {
        host = dev_mp::devfindhost();
        host thread function_65b7cb238af75296();
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0xbfd83c40, Offset: 0x5175
    // Size: 0x20, Type: dev
    function function_713eab3b8a1e6157()
    {
        host = dev_mp::devfindhost();
        host agent_spawngroup();
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0xd760c46a, Offset: 0x519d
    // Size: 0x15, Type: dev
    function function_9f71ac7bf93fa7c4()
    {
        setdvar( @"hash_b0c2611966c23b36", 1 );
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x2c7deb01, Offset: 0x51ba
    // Size: 0x126, Type: dev
    function function_49c54354541f12cd()
    {
        host = dev_mp::devfindhost();
        level endon( #"game_ended" );
        host endon( #"death_or_disconnect" );
        targetforward = anglestoforward( host.angles );
        targetright = anglestoright( host.angles );
        aitype = ai_mp_controller::function_b86341658788836c();
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x83e>", "<dev string:x845>", "<dev string:x84f>" );
        assert( isagent( agent ) );
        streakinfo = killstreak_utility::createstreakinfo( "<dev string:x859>", agent );
        targetforward = anglestoforward( agent.angles );
        targetright = anglestoright( agent.angles );
        var_4d99e8552caf305a = agent toma_strike::findunobstructedfiringinfo( host.origin, 256, targetforward, targetforward, targetright );
        agent toma_strike::tomastrike_firestrike( 1, var_4d99e8552caf305a, streakinfo );
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x61f6aee7, Offset: 0x52e8
    // Size: 0x104, Type: dev
    function function_35b512f3e7a384de()
    {
        host = dev_mp::devfindhost();
        vehicle = vehicle_spawntype( "<dev string:x24>", host.origin, host.angles );
        end = spawnstruct();
        end.origin = host.origin;
        end.angles = host.angles;
        task = spawnstruct();
        task.end = end;
        task.vehicle = vehicle;
        task.helidata = namespace_abdf64fc596be565::function_7d86b1d8eb835027();
        task thread [[ task.helidata.var_b1b3897987cfbae3 ]]();
        task.c4heli = task [[ task.helidata.spawnheli ]]( task.vehicle );
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x3f72b75, Offset: 0x53f4
    // Size: 0x75, Type: dev
    function function_7136db42d1f65a2c()
    {
        host = dev_mp::devfindhost();
        vehicle = vehicle_spawntype( "<dev string:x59d>", host.origin, host.angles );
        helicopter = level helicopter_start( host.origin, vehicle, host );
        
        if ( !isdefined( helicopter ) )
        {
            assertmsg( "<dev string:x865>" );
        }
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x9acf383e, Offset: 0x5471
    // Size: 0x32, Type: dev
    function function_db50b79e207712e2()
    {
        host = dev_mp::devfindhost();
        fakeent = function_289b86f6cf671725();
        level thread tomastrike_start( host, fakeent );
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x50b3c027, Offset: 0x54ab
    // Size: 0x20, Type: dev
    function function_e14a0c52985d5359()
    {
        host = dev_mp::devfindhost();
        host thread function_135c0badb62fbe72();
    }

    // Namespace br_searchseizure_quest
    // Params 0
    // Checksum 0x56b69739, Offset: 0x54d3
    // Size: 0x20, Type: dev
    function function_f40f558e3b254e39()
    {
        host = dev_mp::devfindhost();
        host thread function_9e1b01e941c30737();
    }

#/
