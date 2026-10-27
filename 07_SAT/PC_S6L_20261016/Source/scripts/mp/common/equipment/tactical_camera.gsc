// scripts\mp\common\equipment\tactical_camera.gsc  (hash_1d1eb2e41a985cd2.gscc) (size: 24316 Bytes / 0x5efc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe3951e2 (4265169378)
// size ...... 24316 (0x5efc)
// includes .. 26  (offset: 0x5978)
// strings ... 67  (offset: 0x5a48)
// dev strs .. 5   (offset: 0x5ec0)
// exports ... 64  (offset: 0x3104)
// cseg ...... 0x5e6 + 0x2b1e (0x3104)
// imports ... 261 (offset: 0x3b04)
// animtree1 . 0   (offset: 0x5efc)
// animtree2 . 0   (offset: 0x5efc)
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\chaff_debuff;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\deployable_camera_common;
#using scripts\mp\emp_debuff;
#using scripts\mp\superdeploy;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace tactical_camera;

// Namespace tactical_camera
// Params 0, eflags: 0x1
// Checksum 0xa16dfd15, Offset: 0x604
// Size: 0x10
function autoexec main()
{
    deployable_camera_common::function_fef754ab20558ef2();
    tacticalcamera_init();
}

// Namespace tactical_camera
// Params 0
// Checksum 0x3e2b080b, Offset: 0x61c
// Size: 0xcc
function tacticalcamera_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_tac_camera", &tacticalcamera_set, &tacticalcamera_unset, undefined, undefined, undefined, &tacticalcamera_ongive, &function_824fba7ea597e396, undefined, undefined );
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_tac_camera" ] ) )
    {
        return;
    }
    
    level._effect[ "vfx_iw9_fieldupgrades_ammobox_timeout" ] = loadfxasset( "vfx_iw9_fieldupgrades_ammobox_timeout" );
    deployable_camera_common::function_44cb63d579bee7c8( "tacticalCameraList" );
    level.var_cb28f5431edb1e50[ "tacCam" ] = spawnstruct();
    function_a9bb151995194127();
    level.superglobals.staticsuperdata[ "super_tac_camera" ].var_1836be75d110dd2f = &function_4a324135cfcd7671;
    weapons::registerusedcallback( "tac_camera", &tacticalcamera_used );
}

// Namespace tactical_camera
// Params 0
// Checksum 0xb16b1ba5, Offset: 0x6f0
// Size: 0x245
function function_a9bb151995194127()
{
    leveldata = deployable_camera_common::function_ddb6749d6d40be33( "tacCam" );
    leveldata.supername = "super_tac_camera";
    leveldata.lifetime = getdvarint( @"hash_13717e6e87cb530f", 120 );
    leveldata.startfunc = &tacticalCamera_startCamera;
    leveldata.exitfunc = &function_2d732db8068b274a;
    leveldata.destroyfunc = &tacticalcamera_destroy;
    leveldata.var_57bb115d2ac5b412 = &function_983692460b27270e;
    leveldata.var_1d66ed73336b96f5 = &function_54371d0c91ab5bd8;
    leveldata.var_e0a8f87cf8290970 = &tacticalcamera_addmarkpoints;
    leveldata.var_2f24daeab8deae63 = &function_983692460b27270e;
    leveldata.var_2eb55a80f88c3746 = &function_9f68eb6e83cc936d;
    leveldata.var_26875662281a0bd1 = 2480625;
    leveldata.var_9b15b961a6e22c68 = 619369;
    leveldata.var_5cc58c3b33ca5e7d = 2480625;
    leveldata.var_40d0fc5983ba5d1c = 619369;
    leveldata.var_4114b4b691808ac7 = 9000000;
    leveldata.sensorduration = 3;
    leveldata.groupnameteams = "tacticalCameraList";
    leveldata.groupnameplayer = "tacticalCameras";
    leveldata.var_d7dbb2b6c97aa3cf = 2;
    leveldata.var_8985558107853acf = 10;
    leveldata.additionnotification = "tacticalCamera_camera_added";
    leveldata.removalnotification = "tacticalCamera_camera_removed";
    leveldata.var_c7d5c770eec5db7e = "tacticalCamera_location_changed";
    leveldata.var_a0c3c9d5e192ce52 = "tacticalCamera_pilot_removed";
    leveldata.headiconname = "hud_icon_fieldupgrade_tac_cam";
    leveldata.markingsfx = "equip_tactical_cam_marking";
    leveldata.maxhealth = 150;
    leveldata.var_472a74ff4f3384db = &tacticalcamera_handlefataldamage;
    leveldata.damagehandler = &functionals_utility::function_cdfa6ea614436cc;
    leveldata.orientationcontents = trace::create_contents( 1, 0, 0, 1, 0, 1, 0, 1, 1 );
    leveldata.var_c3053b6cc88402ae = getentarray( "tacCameraInvalid", #targetname );
}

// Namespace tactical_camera
// Params 0
// Checksum 0xd0bef9e, Offset: 0x93d
// Size: 0x94
function tacticalcamera_set()
{
    self notify( #"tacticalcamera_set" );
    thread deployable_camera_common::function_41b35e7097ad264c( "personal_camera_status_updated", "ui_tactical_camera_cam_", "tacticalCamera_unset" );
    deployable_camera_common::function_61d1333446b0881f( "tacCam" );
    deployable_camera_common::function_68e3f1c250bdd51f( self, undefined, &function_6196f40afc192847, "super_tac_camera" );
    thread deployable_camera_common::function_20c343566c160c96( "tacCamCluster", "tacticalCamera_unset", "tacticalCamera_camera_removed", 9000000, &function_6196f40afc192847 );
    self setclientomnvar( "ui_block_fu_not_ready_error", 1 );
    self.isusingcamera = 0;
    
    if ( !isbot( self ) && !isagent( self ) )
    {
        thread function_cc73760fa24d816a();
    }
}

// Namespace tactical_camera
// Params 0
// Checksum 0xec658f5f, Offset: 0x9d9
// Size: 0x5b
function tacticalcamera_unset()
{
    self notify( #"tacticalCamera_unset" );
    deployable_camera_common::function_e594b7877f267d89( "tacCam" );
    function_be604578638d20b2();
    self.isusingcamera = undefined;
    deployable_camera_common::function_4081af1e53d674d1( self );
    deployable_camera_common::function_68e3f1c250bdd51f( self, 1, &function_6196f40afc192847, "super_tac_camera" );
    self setclientomnvar( "ui_block_fu_not_ready_error", 0 );
    function_1470f03e18a3174a( undefined );
}

// Namespace tactical_camera
// Params 0
// Checksum 0x8ab99c01, Offset: 0xa3c
// Size: 0x2
function tacticalcamera_ongive()
{
    
}

// Namespace tactical_camera
// Params 0
// Checksum 0x588a035, Offset: 0xa46
// Size: 0x1d
function function_aa915ad881e928d5()
{
    inventory_utility::_takeweapon( function_e6583d8de1535a5b() );
    waitframe();
    inventory_utility::_giveweapon( function_e6583d8de1535a5b() );
}

// Namespace tactical_camera
// Params 0
// Checksum 0xeb876c09, Offset: 0xa6b
// Size: 0x1a
function function_be604578638d20b2()
{
    self setclientomnvar( "ui_tactical_camera_cam_0_status", 0 );
    self setclientomnvar( "ui_tactical_camera_cam_1_status", 0 );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x19a26571, Offset: 0xa8d
// Size: 0x9d
function tacticalcamera_used( grenade )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    thread function_32a69c007ce8292( grenade );
    camera = function_1f34460203a3d6ab( grenade, "super_tac_camera" );
    
    if ( isdefined( camera ) )
    {
        camera.usedcount = 0;
        camera endon( #"death" );
        camera thread tacticalcamera_makeusable();
        waitframe();
        camera thread deployable_camera_common::function_fd179e6b66b289cc();
        challenges::function_a0936b0e5b4550f3( "super_tac_camera", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    }
}

// Namespace tactical_camera
// Params 0
// Checksum 0x66a5d14d, Offset: 0xb32
// Size: 0x68
function tacticalcamera_makeusable()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    assert( self.owner deployable_camera_common::function_b04038c7f3abf1bc( "<dev string:x24>" ), "<dev string:x2b>" );
    
    /#
        self.owner thread function_b5d38912fad0bd5c();
    #/
    
    self.owner deployable_camera_common::function_76cdde25d88f4bc5( 1 );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x214bd3e8, Offset: 0xba2
// Size: 0x1b5
function function_3ba1e2e96f55fed8( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"death" );
    relaunchvelocity = getdvarint( @"hash_143ebf37dc99e63", 150 );
    stuckdata = undefined;
    
    while ( true )
    {
        stuckdata = deployable_camera_common::function_d5f198a6476235e1( grenade );
        var_4ca36b89aa230d40 = stuckdata.var_4ca36b89aa230d40;
        var_48c9acfd176d5868 = stuckdata.var_48c9acfd176d5868;
        var_7d0ca89c4a583506 = 0;
        
        if ( isdefined( var_48c9acfd176d5868 ) )
        {
            if ( var_48c9acfd176d5868 vehicle::is_vehicle() && var_48c9acfd176d5868 vehicle::is_killstreak() )
            {
                if ( var_48c9acfd176d5868.vehiclename == "pac_sentry" || var_48c9acfd176d5868.vehiclename == "radar_drone_recon" || var_48c9acfd176d5868.vehiclename == "assault_drone" )
                {
                    var_7d0ca89c4a583506 = 1;
                }
            }
            
            if ( var_48c9acfd176d5868.var_cc26002d1644fa5e )
            {
                var_7d0ca89c4a583506 = 1;
            }
        }
        
        if ( isdefined( var_4ca36b89aa230d40 ) )
        {
            var_7d0ca89c4a583506 = 1;
        }
        
        if ( var_7d0ca89c4a583506 )
        {
            var_3e243468f148939a = vectordot( anglestoup( grenade.angles ), ( 0, 0, 1 ) ) >= 0.99;
            velocityvector = anglestoup( grenade.angles ) * relaunchvelocity;
            
            if ( var_3e243468f148939a )
            {
                velocityvector += anglestoforward( grenade.angles ) * relaunchvelocity;
            }
            
            grenade unlink();
            grenade = weapon::_launchgrenade( function_e6583d8de1535a5b(), grenade.origin, velocityvector, undefined, 1, grenade );
            continue;
        }
        
        break;
    }
    
    return stuckdata;
}

// Namespace tactical_camera
// Params 1
// Checksum 0x734a45b4, Offset: 0xd60
// Size: 0x46
function function_32a69c007ce8292( grenade )
{
    self endon( #"death" );
    grenade endon( #"death" );
    grenade endon( #"hash_4d8755ce18e91d98" );
    self waittill( #"tacticalCamera_unset" );
    grenade delete();
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0x9d4554ad, Offset: 0xdae
// Size: 0x5e9
function private function_1f34460203a3d6ab( grenade, superid )
{
    self endon( #"tacticalCamera_unset" );
    stuckdata = function_3ba1e2e96f55fed8( grenade );
    
    if ( !isdefined( stuckdata ) )
    {
        /#
            iprintlnbold( "<dev string:x6c>" );
        #/
        
        return;
    }
    
    var_59f28bc546c68ddc = stuckdata.var_48c9acfd176d5868;
    position = grenade gettagorigin( "tag_player" );
    camera = deployable_camera_common::function_d9939fdafd600147( grenade, var_59f28bc546c68ddc, position, utility::get_scripted_weapon_name( #"tactical_camera_turret" ), "turret_tactical_camera_v0", "tacCam" );
    grenade delete();
    
    if ( !supers_mp::issuperready() )
    {
        self notify( #"hash_6f15d175f720560a" );
    }
    
    if ( level.teambased )
    {
        if ( deployable_camera_common::function_f83cf4f089c9ffdf( "tacCam" ) )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"super_mp/tactical_camera_max_team_num" );
            }
            
            camera thread tacticalcamera_explode();
            supers_mp::refundsuper();
            return;
        }
    }
    
    camera endon( #"death" );
    camera.hasexploded = 0;
    
    if ( isdefined( stuckdata.isunderwater ) )
    {
        camera.isunderwater = 1;
    }
    
    camera thread deployable_camera_common::function_d1e999863ff0886a();
    camera.isingraceperiod = 1;
    camera thread function_e8b6e2530607848f();
    camera.issuper = 1;
    camera.superid = level.superglobals.staticsuperdata[ superid ].id;
    camera.equipmentref = "equip_tac_camera";
    camera.creationtime = gettime();
    camera.ownerteam = grenade.owner.team;
    camera.bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_camera" );
    
    if ( utility::issharedfuncdefined( #"deployable_camera", #"attachxrays" ) )
    {
        camera = [[ utility::getsharedfunc( #"deployable_camera", #"attachxrays" ) ]]( camera );
    }
    
    camera.damagecallback = &tacticalcamera_damagecallback;
    camera deployable_camera_common::function_1eeb9de1633236bf();
    thread deployable_camera_common::function_eff29e4a52221c73( camera );
    deployable_camera_common::function_3a830c0230268df4( camera, undefined, 1 );
    deployable_camera_common::function_fbedeab58253b60a( camera );
    waitframe();
    thread deployable_camera_common::function_76f2b33b425d6bc2( camera );
    deployable_camera_common::function_78ea6b444014807e( camera );
    camera thread deployable_camera_common::function_928c5287b85618e2();
    
    if ( utility::issharedfuncdefined( #"game", #"clearoob" ) )
    {
        [[ utility::getsharedfunc( #"game", #"clearoob" ) ]]( camera, 1 );
    }
    
    thread deployable_camera_common::function_93eaead9553740e8( camera );
    
    if ( isdefined( camera.var_421f9e21fee55e8[ 0 ] ) )
    {
        camera setleftarc( camera.var_421f9e21fee55e8[ 0 ] );
    }
    
    if ( isdefined( camera.var_421f9e21fee55e8[ 1 ] ) )
    {
        camera setrightarc( camera.var_421f9e21fee55e8[ 1 ] );
    }
    
    if ( isdefined( camera.vertarc[ 1 ] ) )
    {
        camera setbottomarc( camera.vertarc[ 1 ] );
    }
    
    if ( isdefined( camera.vertarc[ 0 ] ) )
    {
        camera settoparc( camera.vertarc[ 0 ] );
    }
    
    if ( true )
    {
        thread weapons::outlineequipmentforowner( camera );
    }
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        camera deployable_camera_common::function_7cd737002cc225f4();
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &tacticalcamera_onplayerdisconnect );
    camera setscriptablepartstate( "plant", "on", 0 );
    camera setscriptablepartstate( "ddos", "neutral", 0 );
    camera emp_debuff::set_start_emp_callback( &tacticalcamera_empstarted );
    
    if ( level.killstreak_emp_initialized )
    {
        camera.ksempapplycallback = &tacticalcamera_empstarted;
    }
    
    if ( utility::issharedfuncdefined( #"emp", #"setemp_applied_callback" ) )
    {
        camera [[ utility::getsharedfunc( #"emp", #"setemp_applied_callback" ) ]]( &tacticalcamera_empstarted );
    }
    
    camera haywire::function_7f69a1eb3d590f76( &function_4a4207e7ff5257f5 );
    camera haywire::function_d7496c23fe4085d4( &function_e72df1782fa7b58c );
    camera chaff_debuff::function_4118b0299dc40ea( &function_4c6e00259bab6f4a );
    camera chaff_debuff::function_324dd42a2703bc25( &function_9c3a496b2cc12f5f );
    camera enableplayermarks( #"equipment" );
    
    if ( level.teambased )
    {
        camera filteroutplayermarks( self.team );
    }
    else
    {
        camera filteroutplayermarks( self );
    }
    
    isvaliddeployment = camera deployable_camera_common::function_70e93e9c74630a4();
    
    if ( isvaliddeployment )
    {
        thread deployable_camera_common::function_4e2173f801c91b9( camera, camera.ownerindex, 1 );
    }
    else if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"SUPER_MP/TACTICAL_CAMERA_INVALID_DEPLOYMENT" );
    }
    
    camera function_a4ebfb83ec0621b9( &tacticalcamera_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( camera );
        }
    }
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        camera [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( camera );
    }
    
    camera thread deployable_camera_common::function_d770be120fa6fe91();
    return camera;
}

// Namespace tactical_camera
// Params 2
// Checksum 0xaa077d35, Offset: 0x13a0
// Size: 0x44
function tacticalcamera_explode( attacker, wasdestroyed )
{
    self notify( #"explode" );
    self.hasexploded = 1;
    self setscriptablepartstate( "damaged", "off", 0 );
    tacticalcamera_destroy();
}

// Namespace tactical_camera
// Params 3
// Checksum 0x66a05c7f, Offset: 0x13ec
// Size: 0xda
function tacticalcamera_destroy( immediate = !self.planted, var_4bb221101ea9f3dd, destroyedoninit )
{
    deletiondelay = 0;
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        if ( !isdefined( destroyedoninit ) )
        {
            destroyedoninit = deployable_camera_common::function_b373db29b219ef53();
        }
        
        if ( !var_4bb221101ea9f3dd && !destroyedoninit )
        {
            self.owner thread deployable_camera_common::function_4e2173f801c91b9( self, self.ownerindex, 3, undefined, 3.25 );
            self.owner notify( #"camera_destroyed" );
        }
        
        self setscriptablepartstate( "destroyed", "on", 0 );
        deployable_camera_common::function_903c3eda53391682( "tacCam" );
        deployable_camera_common::function_fb429377bbbe4b1d( self.owner, &function_6dc97e9f86ea0707 );
        thread tacticalcamera_delete( destroyedoninit );
    }
}

// Namespace tactical_camera
// Params 0, eflags: 0x4
// Checksum 0xa9ef3579, Offset: 0x14ce
// Size: 0x22
function private function_9b0ccf35a846231f()
{
    deployable_camera_common::function_76cdde25d88f4bc5( 0 );
    deployable_camera_common::function_4d9ff7e202d60950( "tacCam" );
    self notify( #"tacticalCamera_allCamerasRemoved" );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x74dd32ae, Offset: 0x14f8
// Size: 0x147
function tacticalcamera_delete( destroyedoninit )
{
    self notify( #"death" );
    self.isdestroyed = 1;
    self setcandamage( 0 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    deployable_camera_common::function_feaeb4d1ac58eae8();
    deployable_camera_common::deployablecamera_makeunusable();
    
    if ( isdefined( self.owner ) && !destroyedoninit )
    {
        deployable_camera_common::function_c2c84235baaa07bc( self );
        
        if ( !self.owner deployable_camera_common::function_b04038c7f3abf1bc( "tacCam" ) )
        {
            self.owner function_9b0ccf35a846231f();
        }
        
        self.owner deployable_camera_common::function_ebd0636619e0a916( self );
    }
    
    if ( isdefined( self.watcher_tag ) )
    {
        self.watcher_tag delete();
    }
    
    self.var_421f9e21fee55e8 = undefined;
    self.tag = undefined;
    self.watcher_tag = undefined;
    self.isdamaged = undefined;
    self setturretowner( undefined );
    
    if ( !destroyedoninit )
    {
        self.owner challenges::function_a0936b0e5b4550f3( "super_tac_camera", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    }
    
    self.usedcount = undefined;
    wait 0.1;
    self delete();
}

// Namespace tactical_camera
// Params 0
// Checksum 0x48794250, Offset: 0x1647
// Size: 0x11
function function_983692460b27270e()
{
    return self.var_6a9b943529a63d39[ "tacCamCluster" ];
}

// Namespace tactical_camera
// Params 1, eflags: 0x4
// Checksum 0x7a6f3058, Offset: 0x1661
// Size: 0x1e
function private function_1470f03e18a3174a( val )
{
    self.var_6a9b943529a63d39[ "tacCamCluster" ] = val;
}

// Namespace tactical_camera
// Params 0, eflags: 0x4
// Checksum 0x8f686c14, Offset: 0x1687
// Size: 0xf
function private function_c2591ce48e19e7b()
{
    self setclientomnvar( "ui_block_fu_not_ready_error", 1 );
}

// Namespace tactical_camera
// Params 0
// Checksum 0x343921a1, Offset: 0x169e
// Size: 0x35
function function_e8b6e2530607848f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::waittill_notify_or_timeout( "tactical_camera_has_been_piloted", 3 );
    self.isingraceperiod = 0;
}

// Namespace tactical_camera
// Params 2
// Checksum 0x364bb150, Offset: 0x16db
// Size: 0x30
function function_6dc97e9f86ea0707( markdata, player )
{
    if ( markdata.markingent == self )
    {
        deployable_camera_common::function_5f1d60e42bc86b5( markdata, player, 0 );
    }
}

// Namespace tactical_camera
// Params 0
// Checksum 0xfc362a58, Offset: 0x1713
// Size: 0xd
function function_6196f40afc192847()
{
    return deployable_camera_common::function_2fee422e017f6d21( "tacCam" );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x8ec8a2a5, Offset: 0x1729
// Size: 0x64
function function_7de78f0482b183bb( owner )
{
    if ( !isdefined( level.gametypebundle ) || !level.gametypebundle.var_a817308d8d92ff8c )
    {
        return;
    }
    
    level endon( #"game_ended" );
    owner endon( #"camera_destroyed" );
    owner waittill( #"death_or_disconnect" );
    tacticalcamera_destroy( 1, 0 );
}

// Namespace tactical_camera
// Params 1, eflags: 0x4
// Checksum 0x665a08be, Offset: 0x1795
// Size: 0xc2
function private function_794b8b9bb7c43769( var_f0fa593dcaf8ac61 )
{
    cameragroup = [[ var_f0fa593dcaf8ac61 ]]();
    pilotomnvar = "ui_tactical_camera_" + "pilot";
    self setclientomnvar( pilotomnvar, undefined );
    self setclientomnvar( "ui_tactical_camera_" + "can_detonate_c4", 0 );
    self setclientomnvar( "ui_tactical_camera_" + "index", 0 );
    
    for ( i = 0; i < 10 ; i++ )
    {
        locomnvar = "ui_tactical_camera_" + string( i ) + "_location";
        var_3050be2951160327 = "ui_tactical_camera_" + string( i ) + "_status";
        self setclientomnvar( locomnvar, -1 );
        self setclientomnvar( var_3050be2951160327, 0 );
    }
}

// Namespace tactical_camera
// Params 1, eflags: 0x4
// Checksum 0x7f97d97d, Offset: 0x185f
// Size: 0x68
function private function_c6b5eacc73433040( camera )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_5bc8a48a76bae328" );
    camera endon( #"death" );
    
    while ( true )
    {
        if ( self.isusingcamera )
        {
            self setclientomnvar( "ui_killstreak_countdown", camera.batterytime );
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0xd926a3b4, Offset: 0x18cf
// Size: 0x37
function private function_970a323a82a779d9( camera, currenttime )
{
    waitframe();
    health = camera function_9e58a4a7164188da();
    self setclientomnvar( "ui_killstreak_health", health );
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0xfb54153b, Offset: 0x190e
// Size: 0x42
function private function_c201eb2fa3e9f093( camera, cameragroup )
{
    idx = camera.cameraindex;
    
    if ( isdefined( idx ) )
    {
        self setclientomnvar( "ui_tactical_camera_index", idx + 1 );
    }
}

// Namespace tactical_camera
// Params 0, eflags: 0x4
// Checksum 0xa296d049, Offset: 0x1958
// Size: 0xbb
function private function_591cfddeb33ad40c()
{
    level endon( #"game_ended" );
    self endon( #"hash_c22f384ac118b628" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        level waittill( #"tacticalCamera_location_changed", camera );
        cameragroup = function_6196f40afc192847();
        idx = function_f02c63b99c9614c9( cameragroup, camera );
        
        if ( isdefined( idx ) )
        {
            omnvarname = "ui_tactical_camera_" + string( idx ) + "_location";
            
            if ( camera.areaid >= 0 )
            {
                self setclientomnvar( omnvarname, camera.areaid );
            }
            else
            {
                self setclientomnvar( omnvarname, -1 );
            }
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0xefab41d6, Offset: 0x1a1b
// Size: 0xc8
function private function_ae4dedf25a77a7bd( player, index )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    self endon( #"death" );
    player endon( #"hash_c22f384ac118b628" );
    
    while ( true )
    {
        newstatus = deployable_camera_common::function_3baa03e64f7d4778( player );
        
        if ( !isdefined( self.status ) || isdefined( self.status ) && newstatus != self.status )
        {
            self.status = newstatus;
            omnvarname = "ui_tactical_camera_" + string( index ) + "_status";
            player setclientomnvar( omnvarname, self.status );
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0xe35fbe42, Offset: 0x1aeb
// Size: 0x172
function private function_b9e166f5f09701bb( _camera, cameragroup )
{
    var_e094f5688c770fb3 = "_is_piloted";
    locationpf = "_location";
    function_c201eb2fa3e9f093( _camera, cameragroup );
    
    foreach ( camera in cameragroup )
    {
        cameraindex = camera.cameraindex;
        assert( isdefined( camera.cameraindex ), "<dev string:xaa>" );
        
        if ( !isdefined( camera.cameraindex ) )
        {
            continue;
        }
        
        function_4169d51596812897( camera, cameraindex );
        
        if ( isdefined( camera.pilot ) )
        {
            self setclientomnvar( "ui_tactical_camera_" + cameraindex + var_e094f5688c770fb3, 1 );
        }
        else
        {
            self setclientomnvar( "ui_tactical_camera_" + cameraindex + var_e094f5688c770fb3, 0 );
        }
        
        if ( camera.areaid >= 0 )
        {
            self setclientomnvar( "ui_tactical_camera_" + string( cameraindex ) + locationpf, camera.areaid );
            continue;
        }
        
        self setclientomnvar( "ui_tactical_camera_" + string( cameraindex ) + locationpf, -1 );
    }
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0x1cef17be, Offset: 0x1c65
// Size: 0x69
function private function_4169d51596812897( camera, index )
{
    status = camera deployable_camera_common::function_3baa03e64f7d4778( self );
    camera.status = status;
    omnvarname = "ui_tactical_camera_" + string( index ) + "_status";
    self setclientomnvar( omnvarname, status );
    camera thread function_ae4dedf25a77a7bd( self, index );
}

// Namespace tactical_camera
// Params 1, eflags: 0x4
// Checksum 0xb2bedb0, Offset: 0x1cd6
// Size: 0x40
function private function_1489f69190413a7d( camera )
{
    if ( isdefined( camera.pilot ) )
    {
        self setclientomnvar( "ui_tactical_camera_pilot", camera.pilot );
        return;
    }
    
    self setclientomnvar( "ui_tactical_camera_pilot", undefined );
}

// Namespace tactical_camera
// Params 1, eflags: 0x4
// Checksum 0x690b4224, Offset: 0x1d1e
// Size: 0xac
function private function_4af4da9545cbd326( camera )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    camera endon( #"death" );
    
    while ( true )
    {
        level waittill( #"camera_piloted", pilotedcam );
        
        if ( pilotedcam == camera )
        {
            function_1489f69190413a7d( camera );
        }
        
        cameragroup = function_6196f40afc192847();
        idx = function_f02c63b99c9614c9( cameragroup, pilotedcam );
        
        if ( isdefined( idx ) )
        {
            self setclientomnvar( "ui_tactical_camera_" + idx + "_is_piloted", 1 );
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 1, eflags: 0x4
// Checksum 0x940839c8, Offset: 0x1dd2
// Size: 0xab
function private function_a595b03fe0700038( camera )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    camera endon( #"death" );
    
    while ( true )
    {
        level waittill( #"tacticalCamera_pilot_removed", var_b3607ac8a8fe7270 );
        
        if ( var_b3607ac8a8fe7270 == camera )
        {
            function_1489f69190413a7d( camera );
        }
        
        cameragroup = function_6196f40afc192847();
        idx = function_f02c63b99c9614c9( cameragroup, var_b3607ac8a8fe7270 );
        
        if ( isdefined( idx ) )
        {
            self setclientomnvar( "ui_tactical_camera_" + idx + "_is_piloted", 0 );
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 6
// Checksum 0xc9f57cef, Offset: 0x1e85
// Size: 0x261
function function_54371d0c91ab5bd8( markdata, camuser, target, targettype, useheadicon, useoutline )
{
    level endon( #"game_ended" );
    camuser endon( #"disconnect" );
    self.owner endon( #"disconnect" );
    self endon( #"explode" );
    markdata.reconmarked = 1;
    self.markingtarget = undefined;
    camuser stoplocalsound( "equip_tactical_cam_marking" );
    camuser playlocalsound( "equip_tactical_cam_marked" );
    self setscriptablepartstate( "marking_target", "off", 0 );
    success = deployable_camera_common::function_458a4d14b62d1b8b( markdata, camuser, 1, 0 );
    
    if ( !success )
    {
        return 0;
    }
    
    if ( isplayer( camuser ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( camuser ) ) )
        {
            if ( isdefined( camuser.leaderboarddata[ "tacCamMarks" ] ) )
            {
                camuser.leaderboarddata[ "tacCamMarks" ] = camuser.leaderboarddata[ "tacCamMarks" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "tacCamMarks" ] ) )
            {
                [[ level.leaderboardfunc[ "tacCamMarks" ] ]]( camuser, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x125>" );
            
            if ( isdefined( camuser.pers[ "tacCamMarks" ] ) )
            {
                camuser.pers[ "tacCamMarks" ] = camuser.pers[ "tacCamMarks" ] + 1;
            }
        }
    }
    
    self.usedcount++;
    deployable_camera_common::function_f7bcf5a27c1854dc( 0 );
    deployable_camera_common::function_f7bcf5a27c1854dc( 1 );
    markergroup = camuser deployable_camera_common::function_1066089a542b3224();
    deployable_camera_common::function_177bcf71b0bf91fe( markergroup, target, 2 );
    self.owner challenges::function_a0936b0e5b4550f3( "super_tac_camera", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
    timeout = 5;
    
    if ( isdefined( self.owner.perks[ "specialty_improved_target_mark" ] ) )
    {
        timeout += 2;
    }
    
    thread deployable_camera_common::function_c9ccf471e81ef3dd( markdata, camuser, timeout, 0 );
}

// Namespace tactical_camera
// Params 1
// Checksum 0xf07ce4eb, Offset: 0x20ee
// Size: 0x2c
function function_9f68eb6e83cc936d( target )
{
    markdelay = getdvarfloat( @"hash_4ed00d07f5187137", 0.3 );
    return markdelay;
}

// Namespace tactical_camera
// Params 2
// Checksum 0x3e0d763e, Offset: 0x2123
// Size: 0xdf
function tacticalcamera_addmarkpoints( target, targettype )
{
    if ( !isdefined( self.markedentitieslifeindicices ) )
    {
        self.markedentitieslifeindicices = [];
    }
    
    entitynum = target getentitynumber();
    lifeindex = self.matchdatalifeindex ?? 0;
    thread function_c3198a106dd0cc34( target );
    
    if ( !isdefined( self.markedentitieslifeindicices[ entitynum ] ) || self.markedentitieslifeindicices[ entitynum ] > lifeindex )
    {
        self.markedentitieslifeindicices[ entitynum ] = lifeindex;
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            deployable_camera_common::function_5b1f7b697350a2a6() thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( hashcat( #"hash_c692976b76d1b3c6", targettype, "_marked" ) );
        }
    }
}

// Namespace tactical_camera
// Params 1
// Checksum 0xfb839906, Offset: 0x220a
// Size: 0xe7
function function_c3198a106dd0cc34( target )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    target endon( #"disconnect" );
    result = target utility::waittill_notify_or_timeout_return( "death", 5 );
    targetdead = result == "death" || !isalive( target );
    
    if ( targetdead && isdefined( target.lastkilledby ) && target.lastkilledby != self.owner )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            camcontroller = deployable_camera_common::function_5b1f7b697350a2a6();
            camcontroller thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "tactical_camera_enemy_killed_assist" );
        }
    }
}

// Namespace tactical_camera
// Params 0, eflags: 0x4
// Checksum 0xb3f00cec, Offset: 0x22f9
// Size: 0x13d
function private function_cc73760fa24d816a()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_2f39de5e90ce4646" );
    self endon( #"hash_2f39de5e90ce4646" );
    self endon( #"tacticalCamera_unset" );
    
    while ( true )
    {
        success = deployable_camera_common::function_916284ca01bf7992();
        
        if ( !success )
        {
            continue;
        }
        
        if ( !deployable_camera_common::function_30d523bacbe035c8( function_e6583d8de1535a5b() ) )
        {
            continue;
        }
        
        if ( supers_mp::issuperready() && !self.var_b590d8a08fa6c901 )
        {
            continue;
        }
        
        grenade = undefined;
        cameracluster = function_983692460b27270e();
        
        if ( !isdefined( cameracluster ) )
        {
            continue;
        }
        else if ( cameracluster.size == 0 )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"super_mp/tactical_camera_out_of_range" );
            }
            
            continue;
        }
        else
        {
            [ cam ] = sortbydistance( function_983692460b27270e(), self.origin );
        }
        
        if ( isdefined( cam ) )
        {
            thread function_6364e7b71bb71f68( cam );
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 1
// Checksum 0x4d2dc48f, Offset: 0x243e
// Size: 0x20
function function_824fba7ea597e396( objweapon )
{
    deployable_camera_common::function_3b986a3ad8439874( objweapon, &function_983692460b27270e, function_e6583d8de1535a5b() );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x499029d8, Offset: 0x2466
// Size: 0x179
function function_6364e7b71bb71f68( camera )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    deployable_camera_common::function_3a830c0230268df4( camera );
    self.deployingcamera = 1;
    var_b60820e1a017ed9d = getdvarfloat( @"hash_83f60684c63746be", 0 );
    deployresult = superdeploy::superdeploy_doweapontabletdeploy( supers_mp::getcurrentsuper(), undefined, undefined, undefined, undefined, undefined, 0, var_b60820e1a017ed9d, undefined, 1 );
    self.var_b590d8a08fa6c901 = undefined;
    
    if ( !deployresult )
    {
        self.deployingcamera = 0;
        return 0;
    }
    
    if ( !isdefined( camera ) || camera.isdestroyed || camera.chaffstunned )
    {
        self.deployingcamera = 0;
        self notify( #"super_finished_with_deploy_weapon" );
        return 0;
    }
    
    killstreak_utility::movingplatform_playerlink( self );
    
    if ( isdefined( camera.var_421f9e21fee55e8[ 0 ] ) )
    {
        camera setleftarc( camera.var_421f9e21fee55e8[ 0 ] );
    }
    
    if ( isdefined( camera.var_421f9e21fee55e8[ 1 ] ) )
    {
        camera setrightarc( camera.var_421f9e21fee55e8[ 1 ] );
    }
    
    if ( isdefined( camera.vertarc[ 1 ] ) )
    {
        camera setbottomarc( camera.vertarc[ 1 ] );
    }
    
    if ( isdefined( camera.vertarc[ 0 ] ) )
    {
        camera settoparc( camera.vertarc[ 0 ] );
    }
    
    thread tacticalCamera_startCamera( camera );
}

// Namespace tactical_camera
// Params 2
// Checksum 0x64523bb6, Offset: 0x25e7
// Size: 0x23b
function tacticalCamera_startCamera( camera, forcewatcher )
{
    self.deployingcamera = 0;
    
    if ( !deployable_camera_common::function_f07a5abff6b8cc9c( camera ) )
    {
        self notify( #"cancel_all_super_deployments" );
        return 0;
    }
    
    deployable_camera_common::function_beefde1d1ac68ff8( camera );
    self painvisionoff();
    camera notify( #"entering" );
    self notify( #"hash_5bc8a48a76bae328" );
    
    if ( !camera.hasbeenused )
    {
        camera.hasbeenused = 1;
        camera notify( #"tactical_camera_has_been_piloted" );
    }
    
    self.isusingcamera = 1;
    self.currentcamera = camera;
    deployable_camera_common::function_6223506d2fc50a2f( self.isusingcamera );
    cameragroup = function_6196f40afc192847();
    thread function_b9e166f5f09701bb( camera, cameragroup );
    thread function_f36a0b71d9988d21();
    thread function_591cfddeb33ad40c();
    thread function_5dea665c2ebab0ad();
    deployable_camera_common::function_76cdde25d88f4bc5( 0, 1 );
    thread deployable_camera_common::function_76bae8f797234de8( camera, "tacticalCamera_unset", "tacCam" );
    self setclientomnvar( "ui_rcd_outer_ring", 0 );
    thread function_970a323a82a779d9( camera );
    thread function_c6b5eacc73433040( camera );
    thread deployable_camera_common::function_2fd8782ec11cfc2d( camera, "tacCam" );
    thread deployable_camera_common::function_14f7fdebaa3171b7( 5 );
    thread deployable_camera_common::function_822d202b00169d94( camera );
    thread deployable_camera_common::function_3ac8c3a713620589( camera );
    thread deployable_camera_common::function_fb22f7c7f74485a8( camera, undefined, "tacCam" );
    thread deployable_camera_common::function_b080eefed2eddd5b( camera, "tacCam" );
    thread deployable_camera_common::function_894a6efeebf366ae( camera, "tacCamCluster", "tacCam" );
    camera thread function_7de78f0482b183bb( self );
    
    if ( br_default_inventory::isbackpackinventoryenabled() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
    }
    
    thread function_caf8b97e8f95c31d( camera, forcewatcher );
    thread deployable_camera_common::function_8591223b9107cc48( "tacticalCamera_allCamerasRemoved", camera );
    killstreak_shared::killstreak_savenvgstate();
    
    if ( !isdefined( camera.sfx ) && self.isusingcamera )
    {
        self function_3af65ff34ed36712( 1 );
        camera.sfx = spawn( "script_origin", camera.origin );
        camera.sfx.targetname = "tacticalCamera_startCamera";
        camera.sfx showonlytoplayer( self );
        camera.sfx playloopsound( "equip_tactical_cam_amb_lp" );
    }
}

// Namespace tactical_camera
// Params 0, eflags: 0x4
// Checksum 0x2d9db193, Offset: 0x282a
// Size: 0x74
function private function_f36a0b71d9988d21()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    
    while ( true )
    {
        level waittill( #"tacticalCamera_camera_added", camera, addedindex );
        
        if ( camera.ownerteam == self.team )
        {
            function_4169d51596812897( camera, addedindex );
        }
        
        waitframe();
    }
}

// Namespace tactical_camera
// Params 0, eflags: 0x4
// Checksum 0xd8d556cd, Offset: 0x28a6
// Size: 0x71
function private function_5dea665c2ebab0ad()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c22f384ac118b628" );
    
    while ( true )
    {
        level waittill( #"tacticalCamera_camera_removed", camera, cameraindex );
        
        if ( deployable_camera_common::function_faf001f4f21b77e0( camera ) )
        {
            self setclientomnvar( "ui_tactical_camera_" + cameraindex + "_status", 0 );
        }
    }
}

// Namespace tactical_camera
// Params 3
// Checksum 0xcab71928, Offset: 0x291f
// Size: 0x260
function function_2d732db8068b274a( camera, isswitching, nosensor )
{
    if ( self.isusingcamera )
    {
        player_utility::stopwatchingthermalinputchange();
        
        if ( player::isreallyalive( self ) )
        {
            killstreak_shared::starttabletscreen( "super_tac_camera", 0, 1 );
            self setclientomnvar( "ui_total_fade", 0 );
        }
        
        if ( !isswitching )
        {
            deployable_camera_common::function_ca8402beb6dcf8cc( camera );
            self painvisionon();
            self notify( #"super_finished_with_deploy_weapon" );
            self.isusingcamera = 0;
            self.currentcamera = undefined;
            var_cb39b81537e43be4 = deployable_camera_common::function_ddb6749d6d40be33( camera.cameratype ).var_cb39b81537e43be4;
            
            if ( deployable_camera_common::function_b04038c7f3abf1bc( "tacCam" ) && !var_cb39b81537e43be4 )
            {
                deployable_camera_common::function_76cdde25d88f4bc5( 1 );
            }
            
            self notify( #"playerExitingCameraMode" );
            thread deployable_camera_common::function_8c3012bc6c42ee15();
        }
        
        if ( deployable_camera_common::function_15ee4c2022ab516b( camera ) )
        {
            thread deployable_camera_common::function_ea0e8ea15d3c3bf3( camera, isswitching, "tacCam" );
        }
        else
        {
            thread deployable_camera_common::function_2e0bea0dd3866639( camera, isswitching );
        }
        
        if ( isdefined( camera ) && !isdefined( camera.pilot ) && ( !isdefined( camera.watchers ) || camera.watchers.size == 0 ) )
        {
            if ( !nosensor )
            {
                camera setscriptablepartstate( "autopiloted", "on", 0 );
                camera thread deployable_camera_common::function_fd179e6b66b289cc();
                camera setmode( "sentry_offline" );
                camera restoredefaultdroppitch();
            }
        }
        
        self.var_9bbc2541cea0614c = 0;
        function_794b8b9bb7c43769( &function_6196f40afc192847 );
        
        if ( player::isreallyalive( self ) )
        {
            deployable_camera_common::function_6223506d2fc50a2f( 0 );
        }
        
        deployable_camera_common::function_a0caf4e9aeb4ac89();
        deployable_camera_common::function_1891792c3fc572f5();
        
        if ( isdefined( camera ) )
        {
            camera deployable_camera_common::function_feffc4d0cdb7dad3( self, undefined, "super_tac_camera" );
            camera showtoplayer( self );
        }
    }
    
    thread deployable_camera_common::function_1e2276123cdaad0f();
    killstreak_shared::killstreak_restorenvgstate();
    self notify( #"hash_c22f384ac118b628" );
    
    if ( br_default_inventory::isbackpackinventoryenabled() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 0 );
    }
    
    killstreak_utility::movingplatform_playerunlink( self );
    
    if ( isdefined( camera ) )
    {
        self notify( #"hash_f9bf56f61dc1cf9e" );
    }
    
    self notify( #"playerLeavingCurrentCamera" );
    self function_3af65ff34ed36712( 0 );
    
    if ( isdefined( camera.sfx ) )
    {
        camera.sfx stoploopsound( "equip_tactical_cam_amb_lp" );
        camera.sfx delete();
    }
}

// Namespace tactical_camera
// Params 2, eflags: 0x4
// Checksum 0x70b7af34, Offset: 0x2b87
// Size: 0x234
function private function_caf8b97e8f95c31d( camera, forcewatcher )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    camera endon( #"death" );
    
    if ( !self.isusingcamera )
    {
        return;
    }
    
    if ( isdefined( camera.pilot ) && camera.pilot != self && camera.owner == self )
    {
        oldpilot = camera.pilot;
        oldpilot function_2d732db8068b274a( camera, 1, 1 );
        oldpilot thread tacticalCamera_startCamera( camera, 1 );
    }
    
    if ( isdefined( camera.pilot ) || forcewatcher )
    {
        if ( !isdefined( camera.watchers ) )
        {
            camera.watchers = [];
        }
        
        camera.watchers[ self getentitynumber() ] = self;
        camera.var_903b12971e52e2d0[ self getentitynumber() ] = gettime();
        deployable_camera_common::function_5d9b2813d1d3da15();
        self lerpfov( 80, 0 );
        self cameralinkto( camera.watcher_tag, "tag_origin", 1, 1 );
    }
    else
    {
        level notify( #"camera_piloted", camera );
        camera.pilot = self;
        thread deployable_camera_common::function_d7fe0cec25430cf();
        thread deployable_camera_common::function_b5349d5f73682aa1( camera );
        camera setscriptablepartstate( "piloted", "on", 0 );
        camera setscriptablepartstate( "autopiloted", "off", 0 );
        camera setmode( "manual" );
        self remotecontrolturret( camera );
        self.var_9bbc2541cea0614c = 1;
        deployable_camera_common::function_5d9b2813d1d3da15();
        deployable_camera_common::function_fb429377bbbe4b1d( self, &deployable_camera_common::function_c16c4c3d7ac0cb4 );
        thread deployable_camera_common::function_1c744cbefa3cb8f( camera );
        camera thread deployable_camera_common::function_10c3a94e9c94aa68();
        thread deployable_camera_common::function_d71e7b3e8ab21636( camera );
        camera thread deployable_camera_common::function_a2a694740a9527a8( "tacCam" );
    }
    
    function_1489f69190413a7d( camera );
    thread function_4af4da9545cbd326( camera );
    thread function_a595b03fe0700038( camera );
    thread deployable_camera_common::function_7dedef407f7f7051();
    camera deployable_camera_common::function_feffc4d0cdb7dad3( self, undefined, "super_tac_camera" );
    
    if ( camera emp_debuff::is_empd() || camera.ksempd )
    {
        deployable_camera_common::function_63ebd594ea24d2f( camera );
    }
}

// Namespace tactical_camera
// Params 1
// Checksum 0x90766200, Offset: 0x2dc3
// Size: 0x21
function tacticalcamera_onplayerdisconnect( player )
{
    deployable_camera_common::function_4081af1e53d674d1( player );
    deployable_camera_common::function_e594b7877f267d89( "tacCam" );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x29058306, Offset: 0x2dec
// Size: 0x3f
function function_4c6e00259bab6f4a( data )
{
    var_9ce10f3a1575f377 = getdvarfloat( @"hash_1818fb198fa739fb", 1 );
    deployable_camera_common::deployablecamera_empstarted( data, var_9ce10f3a1575f377 );
    self.chaffstunned = 1;
}

// Namespace tactical_camera
// Params 1
// Checksum 0x55b2e9e9, Offset: 0x2e33
// Size: 0x16
function function_9c3a496b2cc12f5f( data )
{
    self.chaffstunned = 0;
}

// Namespace tactical_camera
// Params 1
// Checksum 0x9b39c63f, Offset: 0x2e51
// Size: 0x32
function tacticalcamera_empstarted( data )
{
    tacticalcamera_givepointsfordeath( data.attacker );
    thread tacticalcamera_explode( data.attacker, 1 );
}

// Namespace tactical_camera
// Params 1
// Checksum 0xe55f2ff3, Offset: 0x2e8b
// Size: 0x2d
function function_4a4207e7ff5257f5( data )
{
    if ( !self.ishaywire )
    {
        self.ishaywire = 1;
    }
    
    deployable_camera_common::function_25b4959d3a4136a7( data );
}

// Namespace tactical_camera
// Params 1
// Checksum 0xe55f2fbd, Offset: 0x2ec0
// Size: 0x15
function function_e72df1782fa7b58c( data )
{
    deployable_camera_common::function_8cb54d9cde7d4776( data );
}

// Namespace tactical_camera
// Params 1
// Checksum 0x7d89898a, Offset: 0x2edd
// Size: 0x32
function tacticalcamera_handlefataldamage( data )
{
    tacticalcamera_givepointsfordeath( data.attacker );
    thread tacticalcamera_explode( data.attacker, 1 );
}

// Namespace tactical_camera
// Params 1
// Checksum 0xac1c4876, Offset: 0x2f17
// Size: 0x7a
function tacticalcamera_damagecallback( damageamnt )
{
    self.owner setclientomnvar( "ui_killstreak_health", ( function_9e58a4a7164188da() - damageamnt ) / self.maxhealth );
    
    if ( self.damagetaken + damageamnt / self.maxhealth > 0.5 )
    {
        if ( !self.isdamaged )
        {
            self.isdamaged = 1;
            self setscriptablepartstate( "damaged", "on", 0 );
        }
    }
}

// Namespace tactical_camera
// Params 0
// Checksum 0xa19be617, Offset: 0x2f99
// Size: 0x1e
function function_9e58a4a7164188da()
{
    return int( max( 0, self.maxhealth - self.damagetaken ) );
}

// Namespace tactical_camera
// Params 1
// Checksum 0xd971c014, Offset: 0x2fc0
// Size: 0x41
function tacticalcamera_givepointsfordeath( attacker )
{
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
}

// Namespace tactical_camera
// Params 0
// Checksum 0xcc582a34, Offset: 0x3009
// Size: 0xd, Type: bool
function function_4a324135cfcd7671()
{
    return deployable_camera_common::function_b04038c7f3abf1bc( "tacCam" );
}

// Namespace tactical_camera
// Params 0
// Checksum 0x553c70d5, Offset: 0x301f
// Size: 0x45
function function_d6409172ea3769c6()
{
    pullbackweapon = weapon::getgrenadeinpullback();
    
    if ( isdefined( pullbackweapon ) && pullbackweapon.basename == "tac_camera_mp" )
    {
        inventory_utility::_takeweapon( pullbackweapon );
        wait 0.05;
        supers_mp::refundsuper();
    }
}

// Namespace tactical_camera
// Params 0
// Checksum 0xc605e752, Offset: 0x306c
// Size: 0x7
function function_e6583d8de1535a5b()
{
    return "tac_camera_mp";
}

// Namespace tactical_camera
// Params 1
// Checksum 0xa2720479, Offset: 0x307c
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace tactical_camera
// Params 1
// Checksum 0x8aa225cd, Offset: 0x309b
// Size: 0x2c
function tacticalcamera_hack( hacker )
{
    if ( self.exploding )
    {
        return;
    }
    
    hacker killstreaks::givescoreforhack();
    tacticalcamera_destroy( 1, 0 );
}

/#

    // Namespace tactical_camera
    // Params 0
    // Checksum 0x1799a792, Offset: 0x30cf
    // Size: 0x35, Type: dev
    function function_b5d38912fad0bd5c()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self notify( #"hash_4278b582b548396d" );
        self endon( #"hash_4278b582b548396d" );
    }

#/
