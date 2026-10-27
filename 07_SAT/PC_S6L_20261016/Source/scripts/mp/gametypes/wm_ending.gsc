// scripts\mp\gametypes\wm_ending.gsc  (hash_163ad3ccb646c1fa.gscc) (size: 7744 Bytes / 0x1e40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2765e2bd (660988605)
// size ...... 7744 (0x1e40)
// includes .. 7   (offset: 0x1b90)
// strings ... 47  (offset: 0x1bc8)
// dev strs .. 0   (offset: 0x1e34)
// exports ... 11  (offset: 0x1310)
// cseg ...... 0x43a + 0xed6 (0x1310)
// imports ... 56  (offset: 0x14c8)
// animtree1 . 1   (offset: 0x1e34)
// animtree2 . 0   (offset: 0x1e40)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\samsite;

#namespace wm_ending;

// Namespace wm_ending
// Params 0
// Checksum 0x2f67ceb, Offset: 0x458
// Size: 0xd
function init()
{
    level.var_86bbc7d0be1ace54 = 1;
}

// Namespace wm_ending
// Params 2
// Checksum 0xfed0c49, Offset: 0x46d
// Size: 0x2b
function function_4e85d388752f31a3( func_attackers, func_defenders )
{
    level.var_63e9b5349b59e57d = func_attackers;
    level.var_cb15537dde51f001 = func_defenders;
}

// Namespace wm_ending
// Params 1
// Checksum 0xb0019655, Offset: 0x4a0
// Size: 0x112
function function_dca7aa9f3fa57193( winner )
{
    level.var_745e643a4920d7d8 = 1;
    
    if ( winner == game[ "defenders" ] )
    {
        cinematic_func = level.var_cb15537dde51f001;
    }
    else
    {
        cinematic_func = level.var_63e9b5349b59e57d;
    }
    
    if ( !isdefined( cinematic_func ) )
    {
        cinematic_func = &function_282fe63fda676f90;
    }
    
    camera = [[ cinematic_func ]]();
    intermission_ents = getentarray( "mp_global_intermission", #classname );
    
    foreach ( ent in intermission_ents )
    {
        ent.origin = camera.origin;
        ent.angles = camera.angles;
    }
}

// Namespace wm_ending
// Params 3
// Checksum 0xa7ca8bbe, Offset: 0x5ba
// Size: 0x2ad
function ending_viewing_players_setup( animstruct, var_c9c41548d4af4a4e, var_2aa9b7bd4decf874 )
{
    level.brspawnplayersending = 1;
    level notify( #"hash_bcd7948d1417bc21" );
    
    foreach ( player in level.players )
    {
        /#
            if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
            {
                continue;
            }
        #/
        
        player function_e19ccf4da1a61ba7( animstruct.origin );
        player utility::hidehudenable();
        player setcinematicmotionoverride( "disabled" );
        player setclientomnvar( "ui_hide_hud", 1 );
        
        if ( isdefined( player.sessionstate ) )
        {
            if ( player.sessionstate == "intermission" )
            {
                player player::updatesessionstate( "spectator" );
            }
            
            if ( player.sessionstate == "spectator" )
            {
                player setspectatedefaults( animstruct.cam.origin, animstruct.cam.angles );
                player spawn( animstruct.cam.origin, animstruct.cam.angles );
                continue;
            }
            
            player setorigin( animstruct.origin + ( 0, 0, 100 ) );
        }
    }
    
    foreach ( player in level.players )
    {
        /#
            if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
            {
                continue;
            }
        #/
        
        camtag = "tag_player";
        linkent = animstruct.cam;
        
        if ( isdefined( var_2aa9b7bd4decf874 ) )
        {
            camtag = var_2aa9b7bd4decf874;
        }
        
        if ( isdefined( var_c9c41548d4af4a4e ) )
        {
            linkent = var_c9c41548d4af4a4e;
        }
        
        player cameralinkto( linkent, camtag, 1, 1 );
        player playerlinkto( animstruct.cam, "tag_player" );
        player playerhide();
    }
}

#using_animtree( "script_model" );

// Namespace wm_ending
// Params 0
// Checksum 0xb63f8943, Offset: 0x86f
// Size: 0x51
function create_cam()
{
    model = spawn( "script_model", self.origin );
    model setmodel( "tag_origin" );
    model forcenetfieldhighlod( 1 );
    model useanimtree( #animtree );
    model.animname = "endingCam";
    return model;
}

// Namespace wm_ending
// Params 0
// Checksum 0x2e62e430, Offset: 0x8c9
// Size: 0xa9
function function_282fe63fda676f90()
{
    animstruct = spawnstruct();
    animstruct.angles = ( 0, 0, 0 );
    animstruct.origin = ( 0, 0, 0 );
    animstruct.cam = animstruct create_cam();
    animstruct.cam.angles = animstruct.angles;
    ending_viewing_players_setup( animstruct );
    animstruct.cam movez( 128, 4, 0.3 );
    wait 3;
    return animstruct.cam;
}

// Namespace wm_ending
// Params 0
// Checksum 0x55e463f5, Offset: 0x97b
// Size: 0x1be
function function_381ff4943e4535f4()
{
    level.mercymatchending_time = 5;
    animstruct = utility::getstruct( "wm_st_c_ending_cam_attackers", "targetname" );
    animstruct.cam = animstruct create_cam();
    animstruct.cam.angles = animstruct.angles;
    ending_viewing_players_setup( animstruct );
    wm_missile_st_c = getent( "wm_missile_st_c", #targetname );
    wm_missile_st_c movez( 4096, 3, 0.3 );
    animstruct.cam movez( 2048, 4, 0.3 );
    wait 4;
    
    foreach ( player in level.players )
    {
        thread game_utility::fadetoblackforplayerkeepui( player, 1, 1 );
    }
    
    wait 1;
    setomnvarforallclients( "post_game_state", 12 );
    
    foreach ( player in level.players )
    {
        thread game_utility::fadetoblackforplayerkeepui( player, 0, 1 );
    }
    
    wait 5;
    wait 6;
    return animstruct.cam;
}

// Namespace wm_ending
// Params 0
// Checksum 0xce349f58, Offset: 0xb42
// Size: 0x2e5
function function_1d049dd706c91e2e()
{
    struct = utility::getstructarray( "mp_jup_dam_heli_spawn", "targetname" )[ 0 ];
    spawndata = spawnstruct();
    spawndata.origin = struct.origin;
    spawndata.angles = struct.angles;
    endstruct = spawnstruct();
    endstruct.origin = struct.origin + ( 0, 100, 0 );
    endstruct.angles = struct.angles;
    vehicle = vehicle::spawn( "veh9_blima", spawndata );
    vehicle setscriptablepartstate( "running_lights", "on" );
    vehicle.animname = "blima";
    vehicle.path_start_info = spawnstruct();
    vehicle.path_start_info.speed = 85;
    vehicle thread vehicle_paths::vehicle_paths_helicopter( endstruct );
    animstruct = utility::getstruct( "attackers_fail_outro_cam_1", "targetname" );
    animstruct.cam = animstruct create_cam();
    animstruct.cam.angles = animstruct.angles;
    sam_struct = utility::getstruct( "samsite_loc_cinematic", "targetname" );
    turret = samsite::function_5772afed0d0a7557( sam_struct, "military_samsite_01_rig_skeleton_war_mode_mp" );
    samsite::function_e223076ba8697313( turret );
    missile_fired = turret.missile1;
    turret.target_entity = vehicle;
    turret settargetentity( turret.target_entity );
    ending_viewing_players_setup( animstruct );
    animstruct.cam movez( 128, 10, 0.3 );
    wait 2;
    turret thread samsite::function_c6f769c78c2e9b12();
    wait 1;
    struct = utility::getstruct( "attackers_fail_outro_cam_2", "targetname" );
    animstruct.cam.origin = struct.origin;
    animstruct.cam.angles = struct.angles;
    wait 1.25;
    playfx( utility::getfx( "veh_jup_razorback_explosion" ), missile_fired.origin, anglestoforward( missile_fired.angles ), anglestoup( missile_fired.angles ) );
    missile_fired hide();
    vehicle vehphys_crash();
    vehicle setscriptablepartstate( "engine", "on" );
    vehicle setscriptablepartstate( "damageHeavy", "lowSpeed" );
    vehicle setscriptablepartstate( "damageEngine", "explode" );
    wait 3.5;
    return animstruct.cam;
}

// Namespace wm_ending
// Params 1
// Checksum 0xf8714d, Offset: 0xe30
// Size: 0x10d
function spawninfilvehicle( struct )
{
    spawnpos = struct.origin;
    spawnang = struct.angles;
    model = "veh9_mil_air_heli_blima_mp";
    vehicleassetname = "veh9_mil_air_heli_blima_physics_mp";
    vehicle = spawnvehicle( model, "wmHeliOutro", vehicleassetname, spawnpos, spawnang );
    vehicle.animname = "blima";
    vehicle setcandamage( 0 );
    
    if ( vehicle vehicle_isphysveh() )
    {
        vehicle function_d2b8ee2e1275daaf( 1 );
        vehicle vehphys_forcekeyframedmotion();
    }
    else
    {
        vehicle notsolid();
    }
    
    vehicle hidepart( "tag_main_rotor_blade_01" );
    vehicle hidepart( "tag_main_rotor_blade_02" );
    vehicle hidepart( "tag_main_rotor_blade_03" );
    vehicle hidepart( "tag_main_rotor_blade_04" );
    vehicle hidepart( "tag_tail_rotor_blade_01" );
    vehicle hidepart( "tag_tail_rotor_blade_02" );
    vehicle hidepart( "tag_tail_rotor_blade_03" );
    vehicle hidepart( "tag_tail_rotor_blade_04" );
    return vehicle;
}

// Namespace wm_ending
// Params 1
// Checksum 0x69ee7b5d, Offset: 0xf46
// Size: 0x3c9
function function_731f473342cf25bb( animstruct )
{
    animstruct = utility::getstructarray( "wm_attackers_win_camera", "targetname" )[ 0 ];
    animstruct.cam = animstruct create_cam();
    animstruct.cam.angles = animstruct.angles;
    ending_viewing_players_setup( animstruct );
    ai_mp_controller::init();
    setdvar( @"scr_starsystem", 0 );
    
    foreach ( player in level.players )
    {
        thread game_utility::fadetoblackforplayerkeepui( player, 1, 0 );
    }
    
    while ( !isdefined( level.agentarray ) || level.agentarray.size == 0 )
    {
        waitframe();
    }
    
    while ( !isdefined( level.aibudgets ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        waitframe();
    }
    
    level.var_df336712f37ebfc0 = 1;
    level.var_fe60ebaf5e21a892 = 1;
    setdvar( @"scr_heliverticaloffset", 2000 );
    ai_mp_controller::aibudget_registercategories( [ "reinforcements" ] );
    heli_struct = utility::getstructarray( "attacker_reinforcements_goal", "targetname" )[ 0 ];
    level.gamemodebundle.var_73b2e4fedf5cd267 = 1;
    level.var_6c24585cf7e38ab9 = "pmc";
    agents_heli = undefined;
    
    if ( level.var_5261767313e4e145 )
    {
        agents_heli = [[ utility::getsharedfunc( #"heli", #"requestReinforcements" ) ]]( 6, heli_struct.origin, "high", "reinforcements", "debug", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, %"hash_5b1746f66e66db96" );
    }
    
    if ( !isdefined( agents_heli ) )
    {
        return 0;
    }
    
    foreach ( player in level.players )
    {
        thread game_utility::fadetoblackforplayerkeepui( player, 0, 1 );
    }
    
    vehicle = agents_heli[ 0 ].vehicle;
    up = -250;
    left = -250;
    animstruct.cam linkto( vehicle, "tag_origin", ( up, left, 0 ), ( 0, 30, 0 ) );
    wait 4;
    up = 75;
    left = -175;
    animstruct.cam unlink();
    animstruct.cam linkto( vehicle, "tag_origin", ( up, left, -70 ), ( 0, 110, 0 ) );
    wait 10;
    animstruct.cam unlink();
    nextcam = utility::getstruct( "wm_attackers_win_camera_2", "targetname" );
    animstruct.cam.origin = nextcam.origin;
    animstruct.cam.angles = nextcam.angles;
    animstruct.cam movex( 128, 20 );
    wait 14;
    return animstruct.cam;
}

