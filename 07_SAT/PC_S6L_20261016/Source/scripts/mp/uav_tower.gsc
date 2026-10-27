// scripts\mp\uav_tower.gsc  (hash_4cd18ca9a7233a86.gscc) (size: 43272 Bytes / 0xa908 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa9fe02a (4204781610)
// size ...... 43272 (0xa908)
// includes .. 35  (offset: 0x9c88)
// strings ... 147 (offset: 0x9da0)
// dev strs .. 15  (offset: 0xa810)
// exports ... 75  (offset: 0x6e94)
// cseg ...... 0xa88 + 0x640c (0x6e94)
// imports ... 268 (offset: 0x7a4c)
// animtree1 . 1   (offset: 0xa8c8)
// animtree2 . 3   (offset: 0xa8d8)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\currency;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\emp_debuff;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\structspawnconfig;
#using scripts\mp\talking_gun;

#namespace uav_tower;

// Namespace uav_tower
// Params 0, eflags: 0x5
// Checksum 0xb79b60e4, Offset: 0xaa6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"uav_tower", undefined, &init, undefined );
}

// Namespace uav_tower
// Params 0
// Checksum 0x8ea39a71, Offset: 0xac7
// Size: 0x22
function init()
{
    if ( !function_d54bbc8100ac0b16() || isdefined( level.uavtowers ) )
    {
        return;
    }
    
    thread function_d5c9bb9644692c4e();
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0xac0f39c0, Offset: 0xaf1
// Size: 0x26e
function private function_d5c9bb9644692c4e()
{
    scriptmodelanims();
    function_78940006ccf09082();
    seticonnames();
    setwaypoints();
    level.var_dfe8fdf9c0076a23 = [];
    level.activetowers = [];
    level.uavtowers = [];
    
    if ( level.uavtowerssc && getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        initssc();
    }
    
    if ( getdvarint( @"hash_d378a3f6f115229a", 1 ) )
    {
        level endon( #"game_ended" );
        level waittill( #"prematch_fade_done" );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "uav_tower", &tower_used );
    
    if ( utility::ismp() )
    {
        utility::registersharedfunc( #"uav_tower", #"tower_disable", &tower_disable );
        utility::registersharedfunc( #"uav_tower", #"hash_f6cd96249db374f6", &function_59ad13ac6dc2a221 );
    }
    
    level callback::add( "ob_content_process_create_script", &function_de20f9d952ccf97a );
    
    if ( getdvarint( @"hash_132aa99ae926c59c", 1 ) && utility::issharedfuncdefined( #"br", #"registercirclecallbacks" ) )
    {
        br_circle::registercirclecallbacks( 14, &dangercircletick, &dangermulticircletick );
    }
    
    callback::add( #"player_assimilated", &function_2550892140fff0c1 );
    
    if ( level.var_bed6c01c0c143027 )
    {
        assert( isdefined( game[ "<dev string:x24>" ] ) );
        game[ "dialog" ][ "uav_tower_use_first_person" ] = "uav1_wzan_klls";
        game[ "dialog" ][ "uav_tower_use_friendly" ] = "uav1_wzan_kllc";
        game[ "dialog" ][ "uav_tower_use_enemy" ] = "uav1_wzan_klnc";
        game[ "dialog" ][ "uav_tower_time_expired" ] = "uavt_wzan_xprd";
        game[ "dialog" ][ "uav_tower_stolen" ] = "uavt_wzan_cptr";
    }
    
    utility::flag_init( "uav_towers_created" );
    var_d39902740476091 = 0;
    
    if ( utility::issharedfuncdefined( #"mission_manager", #"isenabled" ) )
    {
        var_d39902740476091 = utility::callsharedfunc( #"mission_manager", #"isenabled" );
    }
    
    if ( !var_d39902740476091 && ( !level.uavtowerssc || !getdvarint( @"scr_ssc_enabled", 1 ) ) )
    {
        level thread function_f9ac5b32ab7f7f10();
    }
    
    level thread function_3802ba933a143e2b();
    level.var_f1e585bc3f7a2e35 = getdvarint( @"hash_3cee7c513ae578f7", 0 );
    
    /#
        level thread uavtowers_debug();
    #/
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0xfeb9dd3, Offset: 0xd67
// Size: 0x4d
function private initssc()
{
    level endon( #"game_ended" );
    utility::flag_wait( "ssc_initialized" );
    structspawnconfig::function_7418a260adaec05( "uav_tower", &function_139d58d75da4222 );
    structspawnconfig::function_8c0a09968efe9138( "uav_tower", &function_355286b36027791c );
    structspawnconfig::function_36050499b5f48983( "uav_tower", &function_f85eb124e4de116a );
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0xffbf6a92, Offset: 0xdbc
// Size: 0x547
function private function_78940006ccf09082()
{
    level.var_be56c651557bc33c = getdvarfloat( @"hash_e6cff9732582a0d5", level.gametypebundle.var_1a54aa4018bce76d ?? 0 );
    level.uavtowerssc = getdvarint( @"scr_ssc_use_uav_tower", level.gametypebundle.uavtowerssc ?? 0 );
    level.towerusetime = getdvarfloat( @"scr_uav_tower_use_time", level.gametypebundle.towerusetime ?? 3.4 );
    level.var_73b0db0ae4b5b606 = getdvarint( @"hash_bd581b3a13b81db8", level.gametypebundle.var_73b0db0ae4b5b606 ?? 5000 );
    level.var_ed1d437905997e43 = level.var_73b0db0ae4b5b606 * level.var_73b0db0ae4b5b606;
    level.var_91770bcd2cf3d204 = getdvarint( @"scr_uav_tower_sweep_time", level.gametypebundle.var_91770bcd2cf3d204 ?? 3 ) * 1000;
    level.var_49394ae30544646e = getdvarint( @"hash_d6193a209d3948a4", level.gametypebundle.var_49394ae30544646e ?? 3 );
    level.toweruptime = getdvarint( @"scr_uav_tower_uptime", level.gametypebundle.toweruptime ?? 45 );
    level.var_9bb2993c2475a372 = getdvarint( @"hash_42ba93b094050d0", level.gametypebundle.var_9bb2993c2475a372 ?? 0 );
    level.var_89117951191889f3 = getdvarint( @"hash_c7c9d45312dd7ec", level.gametypebundle.var_89117951191889f3 ?? 1 );
    level.var_2f0e39a9b33aa7ad = getdvarint( @"hash_2b04c9b89da1c476", level.gametypebundle.var_2f0e39a9b33aa7ad ?? 0 );
    level.towercooldown = getdvarint( @"hash_2fd1561a14bc4d7d", level.gametypebundle.towercooldown ?? 1 );
    level.var_a5bbb57efb42b3dd = getdvarint( @"scr_uav_tower_cost", level.gametypebundle.var_a5bbb57efb42b3dd ?? 0 );
    level.uavtowersounds = getdvarint( @"scr_uav_tower_sound", level.gametypebundle.uavtowersounds ?? 0 );
    level.var_bed6c01c0c143027 = getdvarint( @"hash_5569456c0eff0d5b", level.gametypebundle.var_bed6c01c0c143027 ?? 0 );
    level.var_ebb8313d767c6dbd = getdvarint( @"hash_b447447f129aacf9", level.gametypebundle.var_ebb8313d767c6dbd ?? 1 );
    level.var_bfd9f8ac7836d9dc = getdvarint( @"hash_2d4b53ed39fc8215", level.gametypebundle.var_bfd9f8ac7836d9dc ?? 1 );
    level.var_5ee9a89b9f9b984b = getdvarint( @"hash_9d7a6b692b6e84ae", level.gametypebundle.var_5ee9a89b9f9b984b ?? 0 );
    level.var_7eb46e155e4238bb = getdvarfloat( @"hash_806065bf3c06e24", level.gametypebundle.var_7eb46e155e4238bb ?? 30 );
    level.var_9fadae9240ce9194 = getdvarint( @"hash_21c230525b7cf2be", level.gametypebundle.var_9fadae9240ce9194 ?? 1 );
    level.var_946dd4556e9713a = getdvarint( @"hash_25af310c5bc4bc7c", level.gametypebundle.var_946dd4556e9713a ?? 3 );
    level.var_8863d28f3af3d010 = getdvarint( @"hash_4704cc015db60ad2", level.gametypebundle.var_8863d28f3af3d010 ?? 3 );
    level.var_c21cfab853ea20c4 = getdvarint( @"hash_f741c76d2b72d5c5", level.gametypebundle.var_c21cfab853ea20c4 ?? 1 );
    level.var_e517df15a0000c5a = getdvarint( @"hash_d78433447211bc33", level.gametypebundle.var_e517df15a0000c5a ?? 1 );
    level.var_f03e848c8d418c36 = randomintrange( level.var_946dd4556e9713a, level.var_8863d28f3af3d010 + 1 );
    level.var_1946d3120ad89768 = getdvarint( @"hash_939ab4119a3db356", level.gametypebundle.var_1946d3120ad89768 ?? 0 );
    level.var_8b7e4bdd0f125f51 = getdvarint( @"hash_7131733d65e51232", level.gametypebundle.var_8b7e4bdd0f125f51 ?? 0 );
    level.var_1135b5091e4b8cc6 = getdvarint( @"scr_uav_tower_use_dom_capture", level.gametypebundle.var_b9132424f73d2fac ?? 0 );
    level.toweruseradius = getdvarfloat( @"scr_uav_tower_use_radius", level.gametypebundle.toweruseradius ?? 128 );
    level.var_ed85cae984aadba9 = getdvarint( @"hash_87c657d03f6da2c5", level.gametypebundle.var_2b90de19a8d047b4 ?? 0 );
}

#using_animtree( "script_model" );

// Namespace uav_tower
// Params 0
// Checksum 0x9c9c27e0, Offset: 0x130b
// Size: 0x11f
function scriptmodelanims()
{
    level.scr_animtree[ "uav_tower" ] = #animtree;
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_enter" ] = %uav_tower_enter;
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_enter" ] = %"use_uav_tower_enter";
    level.scr_viewmodelanim[ "uav_tower" ][ "use_uav_tower_enter" ] = "uav_tower_enter";
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_idle" ] = %uav_tower_idle;
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_idle" ] = %"use_uav_tower_idle";
    level.scr_viewmodelanim[ "uav_tower" ][ "use_uav_tower_idle" ] = "uav_tower_idle";
    level.scr_anim[ "uav_tower" ][ "use_uav_tower_exit" ] = %uav_tower_exit;
    level.scr_eventanim[ "uav_tower" ][ "use_uav_tower_exit" ] = %"use_uav_tower_exit";
    level.scr_viewmodelanim[ "uav_tower" ][ "use_uav_tower_exit" ] = "uav_tower_exit";
}

// Namespace uav_tower
// Params 4
// Checksum 0x37a6a06e, Offset: 0x1432
// Size: 0x378
function create_player_rig( animname, spawnpos, spawnang, uav_tower )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    self function_e19ccf4da1a61ba7( spawnpos );
    player_rig = spawn( "script_arms", self.origin, 0, 0, self );
    self.player_rig = player_rig;
    player_rig.origin = spawnpos;
    player_rig.angles = spawnang;
    player_rig.player = self;
    player_rig hide( 1 );
    player_rig.animname = animname;
    player_rig useanimtree( #animtree );
    player_rig.updatedversion = 1;
    self playerlinktoabsolute( player_rig, "tag_player" );
    
    if ( isdefined( uav_tower ) && isdefined( uav_tower.linkedparent ) )
    {
        player_rig linkto( uav_tower.linkedparent );
    }
    else
    {
        self playerlinktoblend( self.player_rig, "tag_player", 1, 0, 0, 1, 1 );
    }
    
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot", "disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        self stopviewmodelanim();
        hackwaitframes = level.var_f1e585bc3f7a2e35;
        
        while ( hackwaitframes > 0 )
        {
            waitframe();
            hackwaitframes -= 1;
        }
        
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig ) && player_rig islinked() )
    {
        player_rig unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
    
    if ( isdefined( self ) && isdefined( uav_tower ) && isdefined( uav_tower.linkedparent ) )
    {
        parent = uav_tower.linkedparent;
        
        if ( isdefined( parent.velocity ) )
        {
            local_vel = coordtransformtranspose( parent.velocity, ( 0, 0, 0 ), parent.angles );
            local_vel = ( local_vel[ 0 ], local_vel[ 1 ], 0 );
            world_vel = coordtransform( local_vel, ( 0, 0, 0 ), parent.angles );
            horizontaloffset = getdvarfloat( @"hash_70433558c51dfcfd", 5 );
            var_a380614e02b3fc96 = anglestoforward( self.angles ) * ( horizontaloffset * -1, horizontaloffset * -1, 0 );
            test_origin = self.origin + world_vel * getframeduration() / 1000 * 0.25 + var_a380614e02b3fc96;
            point_start = test_origin + ( 0, 0, 50 );
            point_end = test_origin - ( 0, 0, 50 );
            traceresult = trace::capsule_trace( point_start, point_end, 10, 72, undefined, self );
            point_on_ground = traceresult[ "position" ];
            self setvelocity( world_vel * 0.5 );
            verticaloffset = getdvarfloat( @"hash_6b0f27e366b9165f", 2 );
            offset = ( 0, 0, verticaloffset );
            self setorigin( point_on_ground + offset );
        }
    }
}

// Namespace uav_tower
// Params 2
// Checksum 0x60599fab, Offset: 0x17b2
// Size: 0x44
function function_355286b36027791c( structname, towerstruct )
{
    if ( !isdefined( level.uavtowerlocs ) )
    {
        level.uavtowerlocs = [];
    }
    
    level.uavtowerlocs[ level.uavtowerlocs.size ] = towerstruct;
    return towerstruct;
}

// Namespace uav_tower
// Params 1
// Checksum 0x24ad4223, Offset: 0x17ff
// Size: 0xc8
function function_f85eb124e4de116a( structname )
{
    level endon( #"game_ended" );
    level waittill( #"prematch_fade_done" );
    waitframe();
    
    if ( !isdefined( level.uavtowerlocs ) || level.uavtowerlocs.size == 0 )
    {
        return;
    }
    
    foreach ( loc in level.uavtowerlocs )
    {
        function_e9d70c7951442090( loc );
    }
    
    level.uavtowerlocs = undefined;
}

// Namespace uav_tower
// Params 4
// Checksum 0xdd00483, Offset: 0x18cf
// Size: 0x68
function function_e9d70c7951442090( towerstruct, var_72018eec9bcac4be, var_6752d816058c2289, var_6a989ccbb4376550 )
{
    assert( isdefined( level.uavtowers ) );
    towersspawned = level.uavtowers.size;
    towerscriptable = spawnuavtower( towerstruct, towersspawned, var_72018eec9bcac4be, var_6752d816058c2289, var_6a989ccbb4376550 );
    return towerscriptable;
}

// Namespace uav_tower
// Params 5
// Checksum 0x233a2342, Offset: 0x1940
// Size: 0x32c
function spawnuavtower( towerstruct, identifier, scriptablename, partnametower = "uav_tower", partnamelaptop = "uav_tower_laptop" )
{
    if ( !isdefined( towerstruct.angles ) )
    {
        towerstruct.angles = ( 0, 0, 0 );
    }
    
    scriptable = towerstruct;
    
    if ( !isdefined( scriptablename ) )
    {
        scriptablename = level.gamemodebundle.uavtowerscriptable ?? "scriptable_uav_tower";
    }
    
    if ( isstruct( towerstruct ) )
    {
        scriptable = spawnscriptable( scriptablename, towerstruct.origin, towerstruct.angles );
    }
    
    if ( level.gamemodebundle.var_6c5872f3b39fec6f && scriptable getscriptableparthasstate( partnametower, level.gamemodebundle.var_6c5872f3b39fec6f ) )
    {
        scriptable setscriptablepartstate( partnametower, level.gamemodebundle.var_6c5872f3b39fec6f );
    }
    
    scriptable setscriptablepartstate( partnamelaptop, "laptop_closed" );
    
    if ( level.var_1135b5091e4b8cc6 || level.var_ed85cae984aadba9 )
    {
        scriptable setscriptablepartstate( "objective", "none" );
        scriptable setscriptablepartstate( partnametower, "unusable" );
    }
    
    towerstruct.uav_station = scriptable;
    scriptable.towerstruct = towerstruct;
    scriptable.identifier = identifier;
    scriptable.gasdisabled = 0;
    scriptable.var_30629e995e498243 = -1;
    
    if ( level.var_5ee9a89b9f9b984b )
    {
        towerstruct.uav_station emp_debuff::set_apply_emp_callback( &uavtoweremp );
        towerstruct.uav_station.var_5b3dbacfeda0fd01 = &uavtoweremp;
    }
    
    if ( !isdefined( towerstruct.script_poi ) && isdefined( towerstruct.fortress ) && isdefined( towerstruct.fortress.poiname ) )
    {
        towerstruct.script_poi = towerstruct.fortress.poiname;
    }
    
    if ( !isdefined( towerstruct.script_poi ) )
    {
        towerstruct.script_poi = poi::poi_findpoioriginisin( towerstruct.origin );
    }
    
    level.uavtowers[ level.uavtowers.size ] = towerstruct;
    
    if ( level.var_9bb2993c2475a372 )
    {
        scriptable.teamscooldown = [];
    }
    
    function_59ad13ac6dc2a221( scriptable, "inactive" );
    scriptable interaction::set_interact_hint_callback( &function_9d46067e231b6377 );
    
    /#
        if ( utility::issharedfuncdefined( #"logging", #"addevent" ) )
        {
            [[ utility::getsharedfunc( #"logging", #"addevent" ) ]]( "<dev string:x2b>", "<dev string:x2b>", undefined, "<dev string:x35>", undefined, undefined, towerstruct.script_poi, towerstruct.origin );
        }
    #/
    
    callback::callback( #"uav_tower_spawned", { #instance:scriptable } );
    return scriptable;
}

// Namespace uav_tower
// Params 1
// Checksum 0x47b3c377, Offset: 0x1c75
// Size: 0x68
function despawnuavtower( scriptable )
{
    assert( scriptable );
    tower_disable( scriptable, "despawning" );
    function_59ad13ac6dc2a221( scriptable, "none" );
    
    if ( scriptable.towerstruct )
    {
        level.uavtowers = arrayremove( level.uavtowers, scriptable.towerstruct );
    }
    
    scriptable freescriptable();
}

// Namespace uav_tower
// Params 0
// Checksum 0x50983981, Offset: 0x1ce5
// Size: 0x98
function seticonnames()
{
    level.uavtowericons = { #iconlocked:"tower_locked", #iconreinforcing:"tower_reinforcing", #iconclearing:"tower_clearing", #iconlosing:"tower_losing", #icontaking:"tower_taking", #iconcontested:"tower_contested", #icondefending:"tower_defending", #icondefend:"defend_tower", #iconcapture:"capture_tower", #iconneutral:"capture_tower" };
}

// Namespace uav_tower
// Params 0
// Checksum 0x864aac4b, Offset: 0x1d85
// Size: 0x324
function setwaypoints()
{
    level.var_3b442e6e976785cc = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i" ];
    gamelogic_mp::setwaypointiconinfo( "capture_tower", 1, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "defend_tower", 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_contested", 1, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_contested", 1, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_taking", 1, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_losing", 1, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_clearing", 1, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_reinforcing", 1, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_defending", 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "ui_map_icon_uav_tower", 0 );
    gamelogic_mp::setwaypointiconinfo( "tower_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
    
    foreach ( objkey in level.var_3b442e6e976785cc )
    {
        gamelogic_mp::setwaypointiconinfo( "capture_tower" + objkey, 1, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "defend_tower" + objkey, 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_contested" + objkey, 1, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_taking" + objkey, 1, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_losing" + objkey, 1, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_clearing" + objkey, 1, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_reinforcing" + objkey, 1, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_defending" + objkey, 1, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "ui_map_icon_uav_tower", 0 );
        gamelogic_mp::setwaypointiconinfo( "tower_locked" + objkey, 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
    }
}

// Namespace uav_tower
// Params 2, eflags: 0x4
// Checksum 0x125a755e, Offset: 0x20b1
// Size: 0x220
function private function_9d46067e231b6377( usable, player )
{
    emptyhint = { #string:&"", #type:"HINT_NOICON" };
    
    if ( !isdefined( player ) )
    {
        return emptyhint;
    }
    
    if ( utility::issharedfuncdefined( #"uav_tower", #"canuseuavtower" ) )
    {
        if ( !player [[ utility::getsharedfunc( #"uav_tower", #"canuseuavtower" ) ]]() )
        {
            return emptyhint;
        }
    }
    
    cooldown = usable function_aabf6ff0dd88e819( player.team );
    
    if ( cooldown )
    {
        return { #params:[ int( max( level.toweruptime + level.towercooldown - ( gettime() - cooldown ) * 0.001, 0 ) ) ], #string:&"dmz/inactive_uav_tower_time", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.overridehint[ player.team ] )
    {
        return { #string:usable.overridehint[ player.team ], #type:"HINT_BUTTON" };
    }
    
    playercost = player function_ff10f32a6723540a( usable );
    
    if ( playercost )
    {
        displaycost = playercost * getdvarint( @"playlist_ui_cash_scalar", 10 );
        
        if ( !player currency::can_afford( "cash", playercost ) )
        {
            return { #params:[ displaycost ], #string:&"dmz/insufficient_money_uav_tower_hint", #type:"HINT_NOBUTTON" };
        }
        
        return { #params:[ displaycost ], #string:&"dmz/activate_uav_tower_cost", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"dmz/activate_uav_tower", #type:"HINT_BUTTON" };
}

// Namespace uav_tower
// Params 1
// Checksum 0xe1e4142a, Offset: 0x22d9
// Size: 0x1e2
function function_93ae24b85961c554( scriptable )
{
    trigger = spawn( "trigger_radius", scriptable.origin, 0, level.toweruseradius, 90 );
    trigger.objectivekey = level.var_3b442e6e976785cc[ level.uavtowers.size - 1 ];
    trigger.iconname = level.var_3b442e6e976785cc[ level.uavtowers.size - 1 ];
    capturezone = obj_dom::setupobjective( trigger, "neutral", undefined, undefined, undefined, level.uavtowericons );
    capturezone.offset3d = ( 0, 0, 300 );
    capturezone gameobjects::allowuse( "any" );
    capturezone gameobjects::setcapturebehavior( "persistent" );
    capturezone.scriptable delete();
    capturezone.flagmodel delete();
    capturezone.var_c95f5d841e441c5b = 1;
    capturezone gameobjects::setusetime( level.towerusetime );
    capturezone obj_dom::domflag_setneutral();
    capturezone.var_13edf71915945035 = &function_a96ff97caf239ab0;
    capturezone gameobjects::setobjectivestatusicons( capturezone.icons.iconcapture );
    capturezone objidpoolmanager::update_objective_setzoffset( capturezone.objidnum, capturezone.offset3d[ 2 ] );
    capturestring = gameobjects::getwaypointstring( capturezone.icons.iconcapture + trigger.objectivekey );
    objidpoolmanager::update_objective_ownerteam( capturezone.objidnum, undefined );
    objective_setlabel( capturezone.objidnum, capturestring );
    scriptable.capturezone = capturezone;
    capturezone.towerscriptable = scriptable;
}

// Namespace uav_tower
// Params 1
// Checksum 0xcadaa97a, Offset: 0x24c3
// Size: 0x59
function function_a96ff97caf239ab0( player )
{
    if ( !isdefined( self.towerscriptable ) )
    {
        return;
    }
    
    gameobjects::setownerteam( player.team );
    gameobjects::allowuse( "enemy" );
    function_ad35065b87cb760c( self.towerscriptable, undefined, undefined, player, undefined, undefined, undefined, level.players );
}

// Namespace uav_tower
// Params 1
// Checksum 0xc82808a7, Offset: 0x2524
// Size: 0xc4
function function_b959726e6647858e( towerscriptable )
{
    towerscriptable.gameobject = gameobjects::function_19468713681caa1d( "neutral", towerscriptable.origin, [ towerscriptable ], ( 0, 0, 300 ) );
    towerscriptable.gameobject.icons = level.uavtowericons;
    towerscriptable.gameobject gameobjects::requestid( 1, 1, 1 );
    towerscriptable.gameobject gameobjects::setvisibleteam( "any", undefined, 1 );
    towerscriptable.gameobject gameobjects::setobjectivestatusicons( towerscriptable.gameobject.icons.iconcapture );
}

// Namespace uav_tower
// Params 1
// Checksum 0x2e5a8a75, Offset: 0x25f0
// Size: 0x70
function function_139d58d75da4222( structname = "uav_tower" )
{
    uavtowerlocations = utility::getstructarray( structname, "targetname" );
    
    if ( !isdefined( uavtowerlocations ) || uavtowerlocations.size < 1 )
    {
        uavtowerlocations = utility::getstructarray( "uav_tower", "targetname" );
    }
    
    if ( isdefined( level.var_f5f810e5ea804904 ) )
    {
        uavtowerlocations = [[ level.var_f5f810e5ea804904 ]]();
    }
    
    return uavtowerlocations;
}

// Namespace uav_tower
// Params 1, eflags: 0x4
// Checksum 0x46bb2bc7, Offset: 0x2669
// Size: 0x13
function private function_de20f9d952ccf97a( sparams )
{
    function_f9ac5b32ab7f7f10();
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0x336231e1, Offset: 0x2684
// Size: 0x44a
function private function_f9ac5b32ab7f7f10()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    uavtowerlocations = function_139d58d75da4222( "uav_tower" );
    
    if ( uavtowerlocations.size == 0 )
    {
        utility::flag_set( "uav_towers_created" );
        return;
    }
    
    uavtowerlocations = arrayrandomize( uavtowerlocations );
    var_60108f3a12434d1d = isdefined( level.areas );
    
    if ( level.var_bfd9f8ac7836d9dc )
    {
        foreach ( tower in uavtowerlocations )
        {
            if ( var_60108f3a12434d1d )
            {
                tower.script_poi = utility::callsharedfunc( #"poi", #"area_findoriginisin", tower.origin, 0 );
                continue;
            }
            
            tower.script_poi = poi::poi_findpoioriginisin( tower.origin );
        }
    }
    
    towersspawned = 0;
    var_5bfa24b285fac405 = utility::callsharedfunc( #"poi", #"poi_issystemactive" );
    
    if ( !level.var_1946d3120ad89768 && !level.var_8b7e4bdd0f125f51 && var_5bfa24b285fac405 )
    {
        var_6358a67673e8d868 = [];
        uavtowerpois = [];
        ispoiactivedefined = utility::issharedfuncdefined( #"poi", #"poi_ispoiactive", 0 );
        
        for ( towerindex = 0; towerindex < uavtowerlocations.size ; towerindex++ )
        {
            uavtower = uavtowerlocations[ towerindex ];
            
            if ( !isdefined( uavtower.script_poi ) )
            {
                continue;
            }
            
            if ( !isdefined( var_6358a67673e8d868[ uavtower.script_poi ] ) )
            {
                var_6358a67673e8d868[ uavtower.script_poi ] = [];
                uavtowerpois[ uavtowerpois.size ] = uavtower.script_poi;
            }
            
            var_6358a67673e8d868[ uavtower.script_poi ][ var_6358a67673e8d868[ uavtower.script_poi ].size ] = uavtower;
        }
        
        uavtowerpois = arrayrandomize( uavtowerpois );
        poisused = 0;
        
        foreach ( uavtowerpoi in uavtowerpois )
        {
            if ( poisused == level.var_f03e848c8d418c36 )
            {
                break;
            }
            
            if ( !var_60108f3a12434d1d && ispoiactivedefined && ![[ utility::getsharedfunc( #"poi", #"poi_ispoiactive" ) ]]( uavtowerpoi ) )
            {
                continue;
            }
            
            poisused++;
            var_e0c4ee351ef51dd1 = var_6358a67673e8d868[ uavtowerpoi ];
            var_c21cfab853ea20c4 = getdvarint( hashcat( @"hash_72de7f7dbae2d115", uavtowerpoi ), level.var_c21cfab853ea20c4 );
            var_e517df15a0000c5a = getdvarint( hashcat( @"hash_ea59c77e13b98a07", uavtowerpoi ), level.var_e517df15a0000c5a );
            var_88a3b0449d6474fb = randomintrange( var_c21cfab853ea20c4, var_e517df15a0000c5a + 1 );
            
            if ( var_88a3b0449d6474fb > var_e0c4ee351ef51dd1.size )
            {
                var_88a3b0449d6474fb = var_e0c4ee351ef51dd1.size;
            }
            
            var_e0c4ee351ef51dd1 = utility::array_slice( arrayrandomize( var_e0c4ee351ef51dd1 ), 0, var_88a3b0449d6474fb );
            
            for ( towerindex = 0; towerindex < var_e0c4ee351ef51dd1.size ; towerindex++ )
            {
                towerstruct = var_e0c4ee351ef51dd1[ towerindex ];
                spawnuavtower( towerstruct, towersspawned );
                towersspawned++;
            }
        }
        
        utility::flag_set( "uav_towers_created" );
        return;
    }
    else if ( !level.var_8b7e4bdd0f125f51 || !var_5bfa24b285fac405 )
    {
        var_cf57420ea0ae2530 = randomintrange( level.var_c21cfab853ea20c4, level.var_e517df15a0000c5a + 1 );
        
        if ( var_cf57420ea0ae2530 < uavtowerlocations.size )
        {
            uavtowerlocations = utility::array_slice( arrayrandomize( uavtowerlocations ), 0, var_cf57420ea0ae2530 );
        }
    }
    
    for ( towerindex = 0; towerindex < uavtowerlocations.size ; towerindex++ )
    {
        towerstruct = uavtowerlocations[ towerindex ];
        spawnuavtower( towerstruct, towersspawned );
        towersspawned++;
    }
    
    utility::flag_set( "uav_towers_created" );
}

// Namespace uav_tower
// Params 3
// Checksum 0x83e3ea9a, Offset: 0x2ad6
// Size: 0x289
function _ping( scriptable, playerteam, var_32745f1dee3c9ef3 )
{
    scriptable endon( #"death" );
    scriptable endon( #"tower_disable" );
    level endon( #"game_ended" );
    players = teams::getteamdata( playerteam, "players" );
    
    foreach ( player in players )
    {
        player player::showminimap();
    }
    
    if ( var_32745f1dee3c9ef3 )
    {
        radius = int( level.var_73b0db0ae4b5b606 * ( level.var_2ab3ff8456131beb ?? 1 ) );
    }
    else
    {
        radius = int( level.var_73b0db0ae4b5b606 );
    }
    
    if ( level.var_9bb2993c2475a372 )
    {
        if ( utility::issharedfuncdefined( #"uav_tower", #"ontowerpingstart" ) )
        {
            [[ utility::getsharedfunc( #"uav_tower", #"ontowerpingstart" ) ]]( scriptable, radius, level.var_49394ae30544646e );
        }
    }
    
    while ( true )
    {
        scriptable.scanradius = radius;
        
        foreach ( player in players )
        {
            player.var_f3e321c35a85e44b = gettime();
            player.var_43fc4e9032b52638 = gettime() + level.var_91770bcd2cf3d204;
            player.var_b448d58f0f40f9a8 = radius;
            player.var_f5cbb7e69e156fec = scriptable.origin;
        }
        
        triggerportableradarpingteam( scriptable.origin, playerteam, radius, level.var_91770bcd2cf3d204, scriptable.var_30629e995e498243 );
        uav_bigmap::function_c0b3b2a1f1e2ac5e( playerteam, scriptable.origin, radius, ( level.var_91770bcd2cf3d204 + 50 ) / 1000 );
        wait level.var_49394ae30544646e;
        scriptable.pulseindex++;
        function_49b564bacaa49917( scriptable, var_32745f1dee3c9ef3 );
    }
}

// Namespace uav_tower
// Params 2
// Checksum 0x6d4190f9, Offset: 0x2d67
// Size: 0x1d1
function tower_disable( scriptable, disablereason )
{
    player = scriptable.var_8c953eb201608663;
    
    if ( isdefined( player ) )
    {
        players = teams::getteamdata( player.team, "players" );
        
        foreach ( teamplayer in players )
        {
            teamplayer player::hideminimap();
        }
    }
    
    if ( level.var_bed6c01c0c143027 && isdefined( player ) && disablereason != "different_team_activated" )
    {
        level thread br_public::brleaderdialogteam( "uav_tower_time_expired", player.team, 1, 2 );
    }
    
    scriptable uavtoweranalytics( disablereason );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"uav_tower_duration_ended", scriptable.activeteam );
    scriptable setscriptablepartstate( "uav_tower_antenna", "active_end" );
    scriptable setscriptablepartstate( "activated_alarm_tell", "off" );
    state = "inactive";
    
    if ( disablereason == "EMP_DDOS" )
    {
        state = "disabled";
    }
    
    function_59ad13ac6dc2a221( scriptable, state );
    scriptable.var_8c953eb201608663 = undefined;
    scriptable.activeteam = undefined;
    level.activetowers = arrayremove( level.activetowers, scriptable );
    
    if ( level.var_89117951191889f3 )
    {
        scriptable function_d12441c6647bce40();
    }
    
    scriptable notify( #"tower_disable" );
}

// Namespace uav_tower
// Params 2
// Checksum 0xc4f088d0, Offset: 0x2f40
// Size: 0x78
function function_66689aa7a978b5bc( scriptable, var_32745f1dee3c9ef3 )
{
    scriptable endon( #"death" );
    scriptable endon( #"tower_disable" );
    level endon( #"game_ended" );
    
    if ( var_32745f1dee3c9ef3 )
    {
        wait scriptable.uptime * ( level.var_1099f076e66a8a09 ?? 1 );
    }
    else
    {
        wait scriptable.uptime;
    }
    
    tower_disable( scriptable, "timeout" );
}

// Namespace uav_tower
// Params 1
// Checksum 0x49da1c55, Offset: 0x2fc0
// Size: 0x130
function function_ac5b68ec8d4ade0e( scriptable )
{
    scriptable endon( #"death" );
    scriptable endon( #"hash_e49b4d1e9609033d" );
    level endon( #"game_ended" );
    capduration = modified_values::function_14d05d73e63e1f9e( 8, level.toweruptime );
    
    if ( !level.var_9bb2993c2475a372 )
    {
        level.var_dfe8fdf9c0076a23[ scriptable.index ] = gettime();
        wait capduration + level.towercooldown;
        level.var_dfe8fdf9c0076a23[ scriptable.index ] = 0;
    }
    else
    {
        scriptable.teamscooldown[ self.team ] = gettime();
        scriptable utility::waittill_any_timeout( capduration, "tower_disable" );
        wait level.towercooldown;
        scriptable.teamscooldown[ self.team ] = 0;
    }
    
    if ( utility::issharedfuncdefined( #"ops", #"hash_8c02104a8323540" ) )
    {
        utility::callsharedfunc( #"ops", #"hash_8c02104a8323540", level.gamemodebundle.uavtowermission, scriptable );
    }
}

// Namespace uav_tower
// Params 6
// Checksum 0xd95cba71, Offset: 0x30f8
// Size: 0x576
function tower_used( instance, part, state, player, bautouse, usestring )
{
    if ( !tower_canuse( player ) )
    {
        return;
    }
    
    canuse = !level.var_dfe8fdf9c0076a23[ instance.index ];
    takeover = 0;
    oldteam = undefined;
    cooldowntime = !canuse ? level.var_dfe8fdf9c0076a23[ instance.index ] : 0;
    
    if ( level.var_9bb2993c2475a372 )
    {
        canuse = !instance.teamscooldown[ player.team ];
        
        if ( canuse )
        {
            takeover = 1;
        }
        
        foreach ( playerteam, value in instance.teamscooldown )
        {
            if ( value == 1 )
            {
                oldteam = playerteam;
                break;
            }
        }
        
        cooldowntime = !canuse ? instance.teamscooldown[ player.team ] : 0;
    }
    
    var_e3c6c1bbc4b40b36 = 1;
    cost = player function_ff10f32a6723540a( instance );
    
    if ( cost > 0 )
    {
        var_e3c6c1bbc4b40b36 = player currency::get_currency_amount( "cash" ) >= cost;
        
        if ( canuse && !var_e3c6c1bbc4b40b36 )
        {
            canuse = 0;
        }
    }
    
    if ( canuse )
    {
        player callback::callback( #"uav_tower_used_start", { #cost:cost, #instance:instance, #player:player } );
        instance setscriptablepartstate( "uav_tower", "unusable" );
        instance.capturingteam = player.team;
        
        if ( level.var_9bb2993c2475a372 )
        {
            utility::callsharedfunc( #"uav_tower", #"oncapturedchange", instance, 1 );
        }
        
        instance.successfuluse = level.var_be56c651557bc33c;
        
        if ( !level.var_be56c651557bc33c )
        {
            instance function_f62c2471b7b672e( player );
        }
        
        state = instance getscriptablepartstate( "uav_tower_laptop" );
        
        if ( state == "laptop_closed" && !instance.gasdisabled )
        {
            instance setscriptablepartstate( "uav_tower_laptop", "laptop_opened" );
        }
        
        instance setscriptablepartstate( "uav_tower", "usable" );
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player setclientomnvar( "ui_uav_tower_screen", 0 );
        
        if ( !isbot( player ) )
        {
            player notifyonplayercommandremove( "interact_cancelled", "+weapnext" );
        }
        
        instance setscriptablepartstate( "uav_tower", "usable" );
        
        if ( cost > 0 )
        {
            var_e3c6c1bbc4b40b36 = player currency::get_currency_amount( "cash" ) >= cost;
            
            if ( var_e3c6c1bbc4b40b36 && instance.successfuluse )
            {
                players = level.players;
                instance thread function_ad35065b87cb760c( instance, part, state, player, bautouse, usestring, players, oldteam, takeover );
            }
            else if ( var_e3c6c1bbc4b40b36 && !instance.successfuluse )
            {
            }
            else
            {
                if ( soundexists( "ui_select_purchase_deny" ) && level.uavtowersounds )
                {
                    player playlocalsound( "ui_select_purchase_deny" );
                }
                
                if ( isdefined( level.showerrormessagefunc ) )
                {
                    player [[ level.showerrormessagefunc ]]( %"dmz/insufficient_money_uav_tower" );
                }
            }
        }
        else if ( isdefined( instance.successfuluse ) && instance.successfuluse )
        {
            players = level.players;
            instance thread function_ad35065b87cb760c( instance, part, state, player, bautouse, usestring, players, oldteam, takeover );
        }
        
        return;
    }
    
    if ( !var_e3c6c1bbc4b40b36 )
    {
        if ( soundexists( "ui_select_purchase_deny" ) && level.uavtowersounds )
        {
            player playlocalsound( "ui_select_purchase_deny" );
        }
        
        if ( isdefined( level.showerrormessagefunc ) )
        {
            player [[ level.showerrormessagefunc ]]( %"dmz/insufficient_money_uav_tower" );
        }
        
        return;
    }
    
    if ( soundexists( "fly_pickup_deny" ) && level.uavtowersounds )
    {
        player playlocalsound( "fly_pickup_deny" );
    }
    
    if ( isdefined( level.showerrormessagefunc ) )
    {
        if ( cooldowntime > 0 && ( !isdefined( instance.capturingteam ) || isdefined( instance.capturingteam ) && instance.capturingteam != player.team ) )
        {
            totalcooldown = ( !level.var_9bb2993c2475a372 ? level.toweruptime + level.towercooldown : level.towercooldown ) * 1000;
            timeremaining = ( cooldowntime + totalcooldown - gettime() ) / 1000;
            
            if ( timeremaining < 0 )
            {
                player [[ level.showerrormessagefunc ]]( %"dmz/inactive_uav_tower" );
            }
            else
            {
                timeremaining = int( max( 0, timeremaining ) );
                player [[ level.showerrormessagefunc ]]( %"dmz/inactive_uav_tower_time", timeremaining );
            }
            
            return;
        }
        
        player [[ level.showerrormessagefunc ]]( %"dmz/inactive_uav_tower" );
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x4f8dbb5d, Offset: 0x3676
// Size: 0xeb
function function_f62c2471b7b672e( player )
{
    if ( self.var_9b44b630662e4ee8 )
    {
        self.successfuluse = 1;
        return;
    }
    
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    time = gettime();
    player playsound( "uav_tower_foley_npc", player, player );
    thread watchplayerdeathordisconnect( player );
    typinganimstart( player );
    player setclientomnvar( "ui_uav_tower_screen", 1 );
    thread watchcancelinteraction( player );
    function_9cf05c516bcb29fa( player );
    function_c1019aaab7226574( player );
    player notify( #"interact_finished" );
    endtime = gettime();
    player function_3cb1db2ab7f88b85( 1 );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"remove_rig" );
    }
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0xde2994fc, Offset: 0x3769
// Size: 0x40
function private user_player_goal_pos()
{
    player_use_offset = self.player_use_offset ?? ( -1.279, -55.632, 0 );
    return self.origin + rotatevector( player_use_offset, self.angles );
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0xe752e127, Offset: 0x37b2
// Size: 0x36
function private user_player_goal_angles()
{
    var_55076c73b671c9c = self.var_55076c73b671c9c ?? ( 0, 90, 0 );
    return combineangles( self.angles, var_55076c73b671c9c );
}

// Namespace uav_tower
// Params 0
// Checksum 0x15d936c5, Offset: 0x37f1
// Size: 0x30
function watchgunlessweapon()
{
    self endon( #"hash_2d66abd493d720d1" );
    utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "interact_interrupt" );
    
    if ( isdefined( self ) )
    {
        thread inventory_utility::takegunlessweapon();
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0xd3ec6df6, Offset: 0x3829
// Size: 0x341
function typinganimstart( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player function_3cb1db2ab7f88b85( 0 );
    player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 0 );
    player_use_offset = self.player_use_offset ?? ( -1.279, -55.632, 0 );
    var_55076c73b671c9c = self.var_55076c73b671c9c ?? ( 0, 90, 0 );
    goalpos = user_player_goal_pos();
    var_9a2195688e618184 = ( 10, 0, 0 );
    targetlocalangles = combineangles( var_55076c73b671c9c, var_9a2195688e618184 );
    goalangles = combineangles( self.angles, targetlocalangles );
    movetotime = 0.5;
    
    if ( isdefined( self.linkedparent ) )
    {
        player.linktoent childthread function_ff6a9e0fd2df659f( self, player_use_offset, targetlocalangles, movetotime );
    }
    else
    {
        player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
        player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    }
    
    player setstance( "crouch" );
    player thread watchgunlessweapon();
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = max( 0, movetotime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000 );
    wait var_ed2a546b70aa8095;
    player unlink();
    
    if ( player.linktoent islinked() )
    {
        player.linktoent unlink();
    }
    
    player.linktoent delete();
    player.linktoent = undefined;
    player setorigin( user_player_goal_pos() );
    player setplayerangles( user_player_goal_angles() );
    animname = "use_uav_tower_enter";
    player notify( #"hash_2d66abd493d720d1" );
    player thread create_player_rig( "uav_tower", user_player_goal_pos(), user_player_goal_angles(), self );
    player.player_rig showonlytoplayer( player );
    
    if ( !isdefined( self.animstruct ) )
    {
        if ( isdefined( self.linkedparent ) )
        {
            animstruct = utility::spawn_tag_origin();
        }
        else
        {
            animstruct = spawnstruct();
        }
        
        animstruct.origin = self.origin;
        animstruct.angles = combineangles( self.angles, combineangles( ( 0, 180, 0 ), var_55076c73b671c9c ) );
        self.animstruct = animstruct;
    }
    
    if ( isdefined( self.linkedparent ) )
    {
        self.animstruct linkto( self.linkedparent );
    }
    
    self.animstruct anim_mp::anim_player_solo( player, player.player_rig, animname );
}

// Namespace uav_tower
// Params 4, eflags: 0x4
// Checksum 0xab70de38, Offset: 0x3b72
// Size: 0x17d
function private function_ff6a9e0fd2df659f( uav_tower, goaloffset, goalangles, movetotime )
{
    start_time_ms = gettime();
    end_time_ms = gettime() + movetotime * 1000;
    startoffset = rotatevectorinverted( self.origin - uav_tower.origin, uav_tower.angles );
    startangles = combineanglesinverted( uav_tower.angles, self.angles );
    var_f662ace189f06564 = uav_tower.origin;
    
    while ( isdefined( self ) && gettime() < end_time_ms )
    {
        eff_time = gettime() + getframeduration();
        t = ( eff_time - start_time_ms ) / movetotime * 1000;
        deltapos = uav_tower.origin - var_f662ace189f06564;
        targetoffset = vectorlerp( startoffset, goaloffset, t );
        self.origin = uav_tower.origin + rotatevector( targetoffset, uav_tower.angles ) + deltapos;
        worldangles = combineangles( uav_tower.angles, anglelerpquatfrac( startangles, goalangles, t ) );
        self.angles = worldangles;
        var_f662ace189f06564 = uav_tower.origin;
        waitframe();
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x200ff6, Offset: 0x3cf7
// Size: 0xbe
function watchcancelinteraction( player )
{
    player endon( #"interact_interrupt" );
    player endon( #"disconnect" );
    waitframe();
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommand( "interact_cancelled", "+weapnext" );
    }
    
    self.cancel = 0;
    msg = player utility::waittill_any_timeout_no_endon_death( level.towerusetime, "interact_cancelled" );
    self.cancel = 1;
    
    if ( msg == "interact_cancelled" )
    {
        wait 0.25;
        player setclientomnvar( "ui_uav_tower_screen", 0 );
    }
    else
    {
        self.successfuluse = 1;
        player notify( #"hash_84e77c8027679f26" );
    }
    
    player stoploopsound( "uav_tower_foley_lp" );
}

// Namespace uav_tower
// Params 1
// Checksum 0x68efddc3, Offset: 0x3dbd
// Size: 0xa3
function watchplayerdeathordisconnect( player )
{
    player endon( #"interact_cancelled" );
    player endon( #"interact_finished" );
    player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "last_stand_enter" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( #"interact_interrupt" );
    player stopanimscriptsceneevent();
    
    if ( isdefined( player.linktoent ) )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    player notify( #"remove_rig" );
    player function_3cb1db2ab7f88b85( 1 );
}

// Namespace uav_tower
// Params 2
// Checksum 0x99320300, Offset: 0x3e68
// Size: 0x79
function function_9cf05c516bcb29fa( player, instance )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"hash_84e77c8027679f26" );
    player endon( #"interact_cancelled" );
    
    while ( player::isreallyalive( player ) )
    {
        self.animstruct anim_mp::anim_player_solo( player, player.player_rig, "use_uav_tower_idle" );
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x347dbb67, Offset: 0x3ee9
// Size: 0x88
function function_c1019aaab7226574( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    
    if ( player::isreallyalive( player ) )
    {
        self.animstruct anim_mp::anim_player_solo( player, player.player_rig, "use_uav_tower_exit" );
    }
    
    if ( isent( self.animstruct ) )
    {
        self.animstruct delete();
        self.animstruct = undefined;
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0xf96b166b, Offset: 0x3f79
// Size: 0x166
function function_3cb1db2ab7f88b85( isallowed )
{
    if ( !isallowed )
    {
        val::set( "typing", "allow_jump", 0 );
        val::set( "typing", "gesture", 0 );
        val::set( "typing", "melee", 0 );
        val::set( "typing", "mantle", 0 );
        val::set( "typing", "offhand_weapons", 0 );
        val::set( "typing", "allow_movement", 0 );
        val::set( "typing", "sprint", 0 );
        val::set( "typing", "fire", 0 );
        val::set( "typing", "reload", 0 );
        val::set( "typing", "weapon_pickup", 0 );
        val::set( "typing", "weapon_switch", 0 );
        val::set( "typing", "offhand_weapons", 0 );
        val::set( "typing", "execution_victim", 0 );
        val::set( "typing", "supers", 0 );
        val::set( "typing", "usability", 0 );
        val::set( "typing", "allow_toggle_third_person", 0 );
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
        self function_60e112d2e106b00a();
        return;
    }
    
    val::reset_all( "typing" );
    self setclientomnvar( "ui_br_inventory_disabled", 0 );
    self function_7d73d6786e51ae1f();
}

// Namespace uav_tower
// Params 1, eflags: 0x4
// Checksum 0xa231bc65, Offset: 0x40e7
// Size: 0xa6
function private function_75f7c1bb7427d366( player )
{
    count = 0;
    
    foreach ( tower in level.activetowers )
    {
        if ( tower.activeteam == player.team )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace uav_tower
// Params 1, eflags: 0x4
// Checksum 0xd4b98052, Offset: 0x4196
// Size: 0x9d
function private function_f5083f9dac6d4f16( player )
{
    count = 0;
    
    foreach ( tower in level.activetowers )
    {
        if ( tower.var_8c953eb201608663 == player )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace uav_tower
// Params 2, eflags: 0x4
// Checksum 0x1a267941, Offset: 0x423c
// Size: 0x12b
function private function_f73586e5634b356e( instance, var_cfe0d114504b5e14 )
{
    activeteam = instance.activeteam;
    radius = level.var_73b0db0ae4b5b606 * int( var_cfe0d114504b5e14 ? getdvarfloat( @"hash_be8418001822e32e", 1.5 ) : 1 );
    maxdist = radius * radius;
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( player.team == activeteam )
        {
            continue;
        }
        
        dist = distance2dsquared( instance.origin, player.origin );
        
        if ( dist < maxdist )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace uav_tower
// Params 2, eflags: 0x4
// Checksum 0x8cf570f4, Offset: 0x4370
// Size: 0x65
function private function_49b564bacaa49917( instance, var_cfe0d114504b5e14 )
{
    player = instance.var_8c953eb201608663;
    numpulse = instance.pulseindex;
    numplayersdetected = function_f73586e5634b356e( instance, var_cfe0d114504b5e14 );
    
    if ( isdefined( player ) )
    {
        player challenges::function_49b564bacaa49917( numpulse, numplayersdetected );
    }
}

// Namespace uav_tower
// Params 1, eflags: 0x4
// Checksum 0x8c37a3f3, Offset: 0x43dd
// Size: 0x29
function private function_1789ccf1b2a11905( capturingplayer )
{
    function_59ad13ac6dc2a221( self, "inactive" );
    waitframe();
    function_59ad13ac6dc2a221( self, "active", capturingplayer );
}

// Namespace uav_tower
// Params 9
// Checksum 0xeaea4167, Offset: 0x440e
// Size: 0x8c2
function function_ad35065b87cb760c( instance, part, state, player, bautouse, usestring, players, oldteam, takeover )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    level notify( #"uav_tower_activated", instance );
    
    if ( isdefined( instance.var_8c953eb201608663 ) )
    {
        tower_disable( instance, "different_team_activated" );
    }
    
    cost = player function_ff10f32a6723540a( instance );
    
    if ( cost > 0 )
    {
        player function_d2960f8b768f4d37( cost, instance );
    }
    
    instance.activeteam = player.team;
    instance.uavused = 1;
    instance setscriptablepartstate( "uav_tower_antenna", "active_start" );
    function_59ad13ac6dc2a221( instance, "active", player );
    player thread function_ac5b68ec8d4ade0e( instance );
    instance.var_8c953eb201608663 = player;
    instance.pulseindex = 0;
    level.activetowers[ level.activetowers.size ] = instance;
    
    if ( !level.var_1135b5091e4b8cc6 && !level.var_ed85cae984aadba9 )
    {
        instance function_474bcbb86b733bef( "objective", instance.activeteam );
        instance thread function_1789ccf1b2a11905( player );
    }
    
    if ( level.var_ebb8313d767c6dbd )
    {
        instance thread function_bf33bc181ffadce9( instance );
    }
    
    thread talking_gun::function_a151347084cb61ff( player );
    var_32745f1dee3c9ef3 = 0;
    
    if ( isdefined( player.perks[ "specialty_uav_buff" ] ) )
    {
        var_32745f1dee3c9ef3 = 1;
    }
    
    if ( level.var_89117951191889f3 )
    {
        instance function_863e65711ea8d553( player.team, var_32745f1dee3c9ef3 );
        
        if ( isdefined( instance.towerstruct ) && instance.towerstruct.var_237005472a482004 )
        {
            instance thread function_943f24f57cef78b6();
        }
    }
    
    instance.uptime = player modified_values::function_14d05d73e63e1f9e( 8, level.toweruptime ) * ( level.var_2ab3ff8456131beb ?? 1 );
    instance thread _ping( instance, player.team, var_32745f1dee3c9ef3 );
    
    if ( level.toweruptime > 0 )
    {
        instance thread function_66689aa7a978b5bc( instance, var_32745f1dee3c9ef3 );
    }
    
    instance uavtoweranalytics( undefined );
    instance.lasttimeactivated = gettime();
    
    if ( utility::issharedfuncdefined( #"game", #"getsquadmates" ) )
    {
        squadmates = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( player.team, player.sessionsquadid, 1 );
        
        foreach ( ent in squadmates )
        {
            if ( !isdefined( ent.var_eb6903e216bd4dd ) )
            {
                ent.var_eb6903e216bd4dd = 0;
            }
            
            ent.var_eb6903e216bd4dd++;
            ent namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"uav_tower_used" );
        }
        
        players = undefined;
        
        if ( !isdefined( instance.towerstruct.script_poi ) && isdefined( instance.towerstruct.var_b94953c653a8555f ) )
        {
            instance.towerstruct.script_poi = poi::function_c14b808f44505866( instance.origin, 0, 0, 1 );
        }
        
        if ( isdefined( instance.towerstruct.script_poi ) )
        {
            players = level.poi[ instance.towerstruct.script_poi ][ "players" ];
            
            if ( !isdefined( players ) )
            {
                players = level.areas[ instance.towerstruct.script_poi ][ "players" ];
            }
            
            if ( isdefined( players ) )
            {
                players = arrayremove( players, squadmates );
                
                if ( level.var_9fadae9240ce9194 )
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"uav_tower_used_others", players );
                }
            }
        }
        
        function_fd7407adf9c161f0( squadmates, player.team );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"uav_tower_used", squadmates );
        
        if ( level.uavtowersounds && level.var_a5bbb57efb42b3dd && !instance.var_cba25aeb0b0992a9 )
        {
            wait 1;
        }
        
        if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
        {
            if ( isdefined( instance.towerstruct.script_poi ) )
            {
                var_d39902740476091 = 0;
                
                if ( utility::issharedfuncdefined( #"mission_manager", #"isenabled" ) )
                {
                    var_d39902740476091 = utility::callsharedfunc( #"mission_manager", #"isenabled" );
                }
                
                if ( utility::issharedfuncdefined( #"splash", #"hash_1cdff8916d495428" ) )
                {
                    if ( isdefined( players ) )
                    {
                        [[ utility::getsharedfunc( #"splash", #"hash_1cdff8916d495428" ) ]]( "dmz_uav_tower_activated_others", players, instance.towerstruct.script_poi );
                    }
                    
                    if ( !var_d39902740476091 )
                    {
                        [[ utility::getsharedfunc( #"splash", #"hash_1cdff8916d495428" ) ]]( "dmz_uav_tower_activated_team", squadmates, instance.towerstruct.script_poi );
                    }
                    else if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) && var_d39902740476091 )
                    {
                        instancesteps = utility::callsharedfunc( #"mission_manager", #"hash_ca30f847ff80ecd4", instance, 1 );
                        
                        foreach ( step in instancesteps )
                        {
                            utility::callsharedfunc( #"mission_manager", #"hash_a91636b8ac0b4912", step, 1, player.team );
                            waitframe();
                        }
                    }
                }
                else if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
                {
                    if ( level.var_9fadae9240ce9194 && isdefined( players ) )
                    {
                        [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_uav_tower_activated_others", players, instance.towerstruct.script_poi );
                    }
                    
                    [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "dmz_uav_tower_activated_team", squadmates, instance.towerstruct.script_poi );
                }
            }
        }
        
        if ( level.var_bed6c01c0c143027 )
        {
            level thread br_public::brleaderdialogteamexcludeplayer( "uav_tower_use_friendly", player.team, player, 1, undefined, 2 );
            level thread br_public::brleaderdialogplayer( "uav_tower_use_first_person", player, 1, undefined, 2 );
            team_players = teams::getteamdata( player.team, "players" );
            var_4b6662842d97bb99 = player_utility::script_getplayersinradius( instance.origin, level.var_73b0db0ae4b5b606 * 1.1, undefined, team_players );
            
            foreach ( player in var_4b6662842d97bb99 )
            {
                level thread br_public::brleaderdialogplayer( "uav_tower_use_enemy", player, 1, undefined, 2 );
            }
            
            if ( isdefined( oldteam ) )
            {
                level thread br_public::brleaderdialogteam( "uav_tower_stolen", oldteam, 1, 2 );
            }
        }
    }
    
    player callback::callback( #"uav_tower_used", { #cost:cost, #instance:instance, #player:player } );
}

// Namespace uav_tower
// Params 0
// Checksum 0xa40f1dfe, Offset: 0x4cd8
// Size: 0x178
function function_3802ba933a143e2b()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        for ( i = 0; i < level.uavtowers.size ; i++ )
        {
            if ( isdefined( level.uavtowers[ i ] ) && isdefined( level.uavtowers[ i ].uav_station ) )
            {
                instance = level.uavtowers[ i ].uav_station;
                state = "";
                
                if ( instance getscriptablehaspart( "uav_tower_laptop" ) )
                {
                    state = instance getscriptablepartstate( "uav_tower_laptop" );
                }
                
                if ( !instance.uavused || state == "laptop_closed" )
                {
                    if ( level.uavtowers[ i ].generatordisabled )
                    {
                        continue;
                    }
                    
                    players = utility::playersnear( instance.origin, 600 );
                    
                    if ( isdefined( players ) && players.size > 0 )
                    {
                        if ( state == "laptop_closed" && !instance.gasdisabled )
                        {
                            instance setscriptablepartstate( "uav_tower_laptop", "laptop_opened" );
                        }
                    }
                    else if ( state == "laptop_opened" && !instance.uavused )
                    {
                        instance setscriptablepartstate( "uav_tower_laptop", "laptop_closed" );
                    }
                }
            }
            
            wait 0.25;
        }
        
        wait 0.25;
    }
}

// Namespace uav_tower
// Params 0
// Checksum 0x1fb538f2, Offset: 0x4e58
// Size: 0x5e
function function_d54bbc8100ac0b16()
{
    if ( !isdefined( level.gametypebundle ) )
    {
        assertmsg( "<dev string:x46>" );
        return 0;
    }
    
    if ( !isdefined( level.var_85772f457b0c1629 ) )
    {
        level.var_85772f457b0c1629 = getdvarint( @"scr_enable_uav_towers", istrue( level.gametypebundle.var_4725961d52ef12f1 ) );
    }
    
    return level.var_85772f457b0c1629;
}

// Namespace uav_tower
// Params 1
// Checksum 0x77daec2a, Offset: 0x4ebf
// Size: 0x17f, Type: bool
function tower_canuse( player )
{
    if ( utility::issharedfuncdefined( #"uav_tower", #"canuseuavtower" ) )
    {
        if ( !player [[ utility::getsharedfunc( #"uav_tower", #"canuseuavtower" ) ]]() )
        {
            return false;
        }
    }
    
    if ( isdefined( player ) && player.carryinghostage )
    {
        if ( isdefined( level.showerrormessagefunc ) && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
        {
            player [[ level.showerrormessagefunc ]]( level.br_pickups.var_9d247aba85e39454 );
        }
        
        return false;
    }
    
    if ( !common_item::function_9af4a186249f7df1( player ) )
    {
        if ( isdefined( level.showerrormessagefunc ) && isdefined( level.br_pickups.var_e42dab6eb0ce5dec ) )
        {
            player [[ level.showerrormessagefunc ]]( level.br_pickups.var_e42dab6eb0ce5dec );
        }
        
        return false;
    }
    
    if ( isdefined( player.vehicle ) )
    {
        return false;
    }
    
    if ( player isthrowinggrenade() || player isswitchingweapon() || isdefined( player getheldoffhand() ) && !isnullweapon( player getheldoffhand() ) )
    {
        if ( isdefined( level.showerrormessagefunc ) && isdefined( level.br_pickups.var_e42dab6eb0ce5dec ) )
        {
            player [[ level.showerrormessagefunc ]]( level.br_pickups.var_e42dab6eb0ce5dec );
        }
        
        return false;
    }
    
    return true;
}

// Namespace uav_tower
// Params 1
// Checksum 0xc1000624, Offset: 0x5047
// Size: 0x39
function function_aabf6ff0dd88e819( team )
{
    if ( !level.var_9bb2993c2475a372 )
    {
        return level.var_dfe8fdf9c0076a23[ self.index ];
    }
    
    return self.teamscooldown[ team ];
}

// Namespace uav_tower
// Params 1
// Checksum 0x33194f4b, Offset: 0x5089
// Size: 0x3d
function function_bf33bc181ffadce9( instance )
{
    level endon( #"game_ended" );
    wait 1;
    instance setscriptablepartstate( "activated_oneshot_audio", "on" );
    instance setscriptablepartstate( "activated_alarm_tell", "on" );
}

// Namespace uav_tower
// Params 2
// Checksum 0x9b2bfd69, Offset: 0x50ce
// Size: 0x10f
function function_d2960f8b768f4d37( amount, data )
{
    currencytype = level.gametypebundle.currencytype ?? #"essence";
    assert( currency::can_afford( currencytype, amount ), "<dev string:x9d>" );
    currency::function_b5fe1e05c892a7f3( currencytype, amount, #"uav_tower" );
    self.endmatchstats[ "cashSpent" ] = ( self.endmatchstats[ "cashSpent" ] ?? 0 ) + amount;
    
    if ( soundexists( "ui_select_purchase_confirm" ) && level.uavtowersounds && !data.var_cba25aeb0b0992a9 )
    {
        self playlocalsound( "ui_select_purchase_confirm" );
    }
    
    perskey = "highestPurchaseCost";
    
    if ( !isdefined( self.pers[ perskey ] ) || self.pers[ perskey ] < amount )
    {
        self.pers[ perskey ] = amount;
    }
    
    br_plunder::function_d7efc5a9b599e020( 4, amount );
}

// Namespace uav_tower
// Params 3
// Checksum 0x33e3b908, Offset: 0x51e5
// Size: 0x248
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !utility::issharedfuncdefined( #"br", #"ispointindangercircle" ) )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + thresholdradius;
    
    if ( isdefined( level.uavtowers ) )
    {
        foreach ( tower in level.uavtowers )
        {
            if ( tower.uav_station.ignore_gas )
            {
                continue;
            }
            
            incircle = 1;
            
            if ( distance2dsquared( dangercircleorigin, tower.uav_station.origin ) > var_1bdc861911b3625e * var_1bdc861911b3625e )
            {
                incircle = 0;
            }
            
            if ( !incircle && !tower.uav_station.gasdisabled )
            {
                tower_disable( tower.uav_station, "in_gas" );
                tower.uav_station setscriptablepartstate( "uav_tower", "unusable" );
                tower.uav_station setscriptablepartstate( "objective", "none" );
                tower.uav_station setscriptablepartstate( "uav_tower_laptop", "laptop_closed" );
                tower.uav_station.gasdisabled = 1;
                level.var_7700f978cfc75454[ level.var_7700f978cfc75454.size ] = tower;
                continue;
            }
            
            if ( incircle && tower.uav_station.gasdisabled )
            {
                tower.uav_station setscriptablepartstate( "uav_tower", "usable" );
                function_59ad13ac6dc2a221( tower.uav_station, "inactive" );
                tower.uav_station.gasdisabled = 0;
                level.var_7700f978cfc75454 = arrayremove( level.var_7700f978cfc75454, tower );
            }
        }
    }
}

// Namespace uav_tower
// Params 0
// Checksum 0xca9e7be5, Offset: 0x5435
// Size: 0x201
function dangermulticircletick()
{
    if ( isdefined( level.uavtowers ) )
    {
        foreach ( tower in level.uavtowers )
        {
            if ( tower.uav_station.ignore_gas )
            {
                continue;
            }
            
            if ( !br_circle_util::ispointinmulticircledanger( tower.uav_station.origin ) && !tower.uav_station.gasdisabled )
            {
                tower_disable( tower.uav_station, "in_gas" );
                tower.uav_station setscriptablepartstate( "uav_tower", "unusable" );
                tower.uav_station setscriptablepartstate( "objective", "none" );
                tower.uav_station setscriptablepartstate( "uav_tower_laptop", "laptop_closed" );
                tower.uav_station.gasdisabled = 1;
                level.var_7700f978cfc75454[ level.var_7700f978cfc75454.size ] = tower;
                continue;
            }
            
            if ( br_circle_util::ispointinmulticircledanger( tower.uav_station.origin ) && tower.uav_station.gasdisabled )
            {
                tower.uav_station setscriptablepartstate( "uav_tower", "usable" );
                function_59ad13ac6dc2a221( tower.uav_station, "inactive" );
                tower.uav_station.gasdisabled = 0;
                level.var_7700f978cfc75454 = arrayremove( level.var_7700f978cfc75454, tower );
            }
        }
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x6f81a589, Offset: 0x563e
// Size: 0x106
function function_28eec0c7733904e8( allowgas )
{
    if ( isdefined( level.uavtowers ) )
    {
        foreach ( tower in level.uavtowers )
        {
            if ( tower.uav_station.gasdisabled )
            {
                tower.uav_station setscriptablepartstate( "uav_tower", "usable" );
                function_59ad13ac6dc2a221( tower.uav_station, "inactive" );
                
                if ( allowgas )
                {
                    tower.uav_station.gasdisabled = 0;
                }
                
                level.var_7700f978cfc75454 = arrayremove( level.var_7700f978cfc75454, tower );
            }
        }
    }
}

// Namespace uav_tower
// Params 2
// Checksum 0xf1570dab, Offset: 0x574c
// Size: 0xf3
function function_863e65711ea8d553( team, var_32745f1dee3c9ef3 )
{
    if ( var_32745f1dee3c9ef3 )
    {
        radius = int( level.var_73b0db0ae4b5b606 * ( level.var_2ab3ff8456131beb ?? 1 ) );
    }
    else
    {
        radius = int( level.var_73b0db0ae4b5b606 );
    }
    
    game_utility::questcircle_create( "active_uav_tower_radius", self.origin, radius );
    game_utility::questcircle_showtoall();
    
    if ( isdefined( team ) )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            game_utility::questcircle_hidefromplayer( player );
        }
    }
}

// Namespace uav_tower
// Params 0
// Checksum 0xd4e2244d, Offset: 0x5847
// Size: 0x4c
function function_943f24f57cef78b6()
{
    self endon( #"death" );
    self endon( #"tower_disable" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        game_utility::questcircle_move( self.origin );
        waitframe();
        
        if ( !game_utility::questcircle_exists() )
        {
            break;
        }
    }
}

// Namespace uav_tower
// Params 0
// Checksum 0xc8ed182a, Offset: 0x589b
// Size: 0x12
function function_d12441c6647bce40()
{
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x28ffa8c6, Offset: 0x58b5
// Size: 0x102
function function_2550892140fff0c1( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    if ( level.var_89117951191889f3 )
    {
        foreach ( tower in level.activetowers )
        {
            if ( isdefined( tower.activeteam ) )
            {
                if ( tower.activeteam == oldteam )
                {
                    tower game_utility::questcircle_showtoplayer( player );
                }
                
                if ( tower.activeteam == newteam )
                {
                    tower game_utility::questcircle_hidefromplayer( player );
                }
            }
        }
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0xe4a76065, Offset: 0x59bf
// Size: 0x17
function function_710d24ec8ce5c43b( suffix )
{
    level.var_617a87002d314c33 = suffix;
}

// Namespace uav_tower
// Params 0, eflags: 0x4
// Checksum 0xcdd2de6c, Offset: 0x59de
// Size: 0x24
function private function_654f1085405bf1ea()
{
    if ( isdefined( level.var_617a87002d314c33 ) )
    {
        return ( "_" + level.var_617a87002d314c33 );
    }
    
    return "";
}

// Namespace uav_tower
// Params 3
// Checksum 0x64dd14c8, Offset: 0x5a0b
// Size: 0x21f
function function_59ad13ac6dc2a221( towerscriptable, state = "inactive", capturingplayer )
{
    if ( !isdefined( towerscriptable ) )
    {
        return;
    }
    
    currentstate = towerscriptable.currentobjectivestate ?? "";
    
    if ( level.var_1135b5091e4b8cc6 )
    {
        if ( !isdefined( towerscriptable.capturezone ) )
        {
            function_93ae24b85961c554( towerscriptable );
        }
        
        if ( state == "none" )
        {
            towerscriptable notify( #"tower_state_set" );
            towerscriptable.capturezone gameobjects::setvisibleteam( "none" );
            towerscriptable.capturezone gameobjects::allowuse( "none" );
        }
        else if ( currentstate == "none" )
        {
            towerscriptable thread function_f59ba559bfa074b6();
        }
    }
    else if ( level.var_ed85cae984aadba9 )
    {
        if ( !isdefined( towerscriptable.gameobject ) )
        {
            function_b959726e6647858e( towerscriptable );
        }
        
        if ( state == "active" && isdefined( capturingplayer ) )
        {
            towerscriptable.gameobject.ownerteam = capturingplayer.team;
            towerscriptable.gameobject.prevownerteam = capturingplayer.team;
            towerscriptable.gameobject gameobjects::setobjectivestatusicons( towerscriptable.gameobject.icons.icondefend, towerscriptable.gameobject.icons.iconcapture );
        }
        else if ( state == "inactive" )
        {
            towerscriptable.gameobject gameobjects::releaseid();
            function_b959726e6647858e( towerscriptable );
        }
        else if ( state == "none" )
        {
            towerscriptable.gameobject gameobjects::setvisibleteam( "none" );
        }
    }
    else
    {
        newstate = state + function_654f1085405bf1ea();
        towerscriptable setscriptablepartstate( "objective", newstate );
    }
    
    towerscriptable.currentobjectivestate = state;
}

// Namespace uav_tower
// Params 0, eflags: 0xc
// Checksum 0xabd88c5c, Offset: 0x5c32
// Size: 0x69
function private function_f59ba559bfa074b6()
{
    self notify( #"hash_51a7ad7e554d2183" );
    self endon( #"hash_51a7ad7e554d2183" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"tower_state_set" );
    self.capturezone gameobjects::setvisibleteam( "any" );
    waitframe();
    self.capturezone gameobjects::allowuse( "any" );
}

// Namespace uav_tower
// Params 1
// Checksum 0x713e2c65, Offset: 0x5ca3
// Size: 0x40
function function_ff10f32a6723540a( instance )
{
    if ( level.var_a5bbb57efb42b3dd > 0 && !instance.var_cba25aeb0b0992a9 )
    {
        return int( level.var_a5bbb57efb42b3dd * function_2bac9c0eb0b820b7() );
    }
    
    return 0;
}

// Namespace uav_tower
// Params 0
// Checksum 0x7155906b, Offset: 0x5cec
// Size: 0xd4
function function_2bac9c0eb0b820b7()
{
    var_b5dffc805f1b22df = 1;
    var_ba0867ab01379c01 = 1;
    
    if ( isdefined( level.var_927092972401d98e[ self.guid ] ) )
    {
        foreach ( source in level.var_927092972401d98e[ self.guid ] )
        {
            if ( source[ "additive" ] )
            {
                var_b5dffc805f1b22df += source[ "modifier" ];
                continue;
            }
            
            var_ba0867ab01379c01 *= source[ "modifier" ];
        }
    }
    
    return var_b5dffc805f1b22df * var_ba0867ab01379c01;
}

// Namespace uav_tower
// Params 4
// Checksum 0xab8f816b, Offset: 0x5dc9
// Size: 0xe5
function function_9033276b6b21c1e8( source, modifier, additive, overwriteexisting )
{
    if ( !isdefined( level.var_927092972401d98e ) )
    {
        level.var_927092972401d98e = [];
    }
    
    if ( !isdefined( level.var_927092972401d98e[ self.guid ] ) )
    {
        level.var_927092972401d98e[ self.guid ] = [];
    }
    
    assert( overwriteexisting || !isdefined( level.var_927092972401d98e[ self.guid ][ source ] ) );
    level.var_927092972401d98e[ self.guid ][ source ] = [];
    level.var_927092972401d98e[ self.guid ][ source ][ "additive" ] = istrue( additive );
    level.var_927092972401d98e[ self.guid ][ source ][ "modifier" ] = modifier;
}

// Namespace uav_tower
// Params 1
// Checksum 0xbdfb869f, Offset: 0x5eb6
// Size: 0x3c
function function_fb0cabac970236c3( source )
{
    if ( isdefined( level.var_927092972401d98e[ self.guid ][ source ] ) )
    {
        level.var_927092972401d98e[ self.guid ][ source ] = undefined;
    }
}

// Namespace uav_tower
// Params 0
// Checksum 0x7db20a01, Offset: 0x5efa
// Size: 0x2c
function function_a4c65c539595c5d7()
{
    if ( isdefined( level.var_927092972401d98e[ self.guid ] ) )
    {
        level.var_927092972401d98e[ self.guid ] = undefined;
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x6fba2d87, Offset: 0x5f2e
// Size: 0x19f
function uavtoweranalytics( var_eb20dcb7faf43d81 )
{
    uavtowerscriptable = self;
    playeractivated = uavtowerscriptable.var_8c953eb201608663;
    
    if ( !isdefined( playeractivated ) )
    {
        playerxuid = "";
    }
    else
    {
        playerxuid = playeractivated getxuid();
    }
    
    if ( isdefined( playeractivated ) && isdefined( playeractivated.team ) )
    {
        teamname = playeractivated.team;
    }
    else
    {
        teamname = "neutral";
    }
    
    if ( teamname == "neutral" )
    {
        cost = 0;
    }
    else
    {
        cost = playeractivated function_ff10f32a6723540a( uavtowerscriptable );
    }
    
    lasttimeactivated = -1;
    
    if ( isdefined( uavtowerscriptable.lasttimeactivated ) )
    {
        lasttimeactivated = int( ( gettime() - uavtowerscriptable.lasttimeactivated ) / 1000 );
    }
    
    if ( !isdefined( playeractivated ) )
    {
        playeractivated = gamelogic_mp::gethostplayer();
    }
    
    if ( isdefined( playeractivated ) )
    {
        playeractivated dlog_recordplayerevent( "dlog_event_br_uav_tower", [ "player_activated_xuid", playerxuid, "team_activated", teamname, "cost_activated", cost, "tower_x", uavtowerscriptable.origin[ 0 ], "tower_y", uavtowerscriptable.origin[ 1 ], "tower_z", uavtowerscriptable.origin[ 2 ], "last_time_activated", lasttimeactivated, "disable_reason", var_eb20dcb7faf43d81 ?? "none" ] );
    }
}

// Namespace uav_tower
// Params 1
// Checksum 0x8f926eae, Offset: 0x60d5
// Size: 0x2e
function uavtoweremp( data )
{
    tower_disable( self, "EMP_" + data.reason );
    thread uavtowerdisablefortime( data );
}

// Namespace uav_tower
// Params 1
// Checksum 0x57fd494, Offset: 0x610b
// Size: 0x227
function uavtowerdisablefortime( data )
{
    self notify( #"uavtowerdisablefortime" );
    self endon( #"uavtowerdisablefortime" );
    self setscriptablepartstate( "uav_tower", "unusable" );
    empduration = level.var_7eb46e155e4238bb ?? data.time;
    
    if ( !isdefined( self.temptrigger ) )
    {
        self.temptrigger = spawn( "trigger_radius", self.origin, 0, 1000, 62 );
        trigger::makeenterexittrigger( self.temptrigger, &function_271d7897fefcc12, &playerexituavtowerdisabled );
        self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( empduration ) );
        
        if ( isdefined( self.towerstruct ) && isdefined( self.towerstruct.traincar ) )
        {
            self.temptrigger enablelinkto();
            self.temptrigger linkto( self.towerstruct.traincar );
        }
    }
    else if ( isdefined( self.temptrigger.triggerenterents ) )
    {
        self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( empduration ) );
        
        foreach ( player in self.temptrigger.triggerenterents )
        {
            if ( isplayer( player ) )
            {
                player lower_message::setlowermessageomnvar( "uav_offline", self.temptrigger.endtime );
            }
        }
    }
    
    wait empduration;
    function_59ad13ac6dc2a221( self, "inactive" );
    self setscriptablepartstate( "uav_tower", "usable" );
    self.temptrigger delete();
}

// Namespace uav_tower
// Params 2
// Checksum 0x1f22639, Offset: 0x633a
// Size: 0x99
function function_271d7897fefcc12( player, trigger )
{
    self endon( #"playerexituavtowerdisabled" );
    
    if ( isplayer( self ) )
    {
        lower_message::setlowermessageomnvar( "uav_offline", trigger.endtime );
    }
    
    timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() );
    
    while ( isdefined( trigger ) && timeleft > 0 )
    {
        timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() );
        wait timeleft;
    }
    
    waitframe();
    thread playerexituavtowerdisabled( player, trigger );
}

// Namespace uav_tower
// Params 2
// Checksum 0x6dd29910, Offset: 0x63db
// Size: 0x35
function playerexituavtowerdisabled( player, trigger )
{
    if ( isplayer( self ) )
    {
        lower_message::setlowermessageomnvar( "clear_lower_msg" );
    }
    
    self notify( #"playerexituavtowerdisabled" );
}

// Namespace uav_tower
// Params 2, eflags: 0x4
// Checksum 0x18451224, Offset: 0x6418
// Size: 0x123
function private function_fd7407adf9c161f0( squadmates, team )
{
    var_31184e7302b5359e = 0;
    
    foreach ( tower in level.activetowers )
    {
        if ( tower.activeteam == team )
        {
            var_31184e7302b5359e++;
        }
    }
    
    foreach ( player in squadmates )
    {
        if ( var_31184e7302b5359e >= 3 )
        {
            challenges::function_37e945722d6497f3( player, "three_uav_towers_active", 1 );
        }
    }
}

/#

    // Namespace uav_tower
    // Params 0
    // Checksum 0xd3a3662d, Offset: 0x6543
    // Size: 0xb3, Type: dev
    function uavtowers_debug()
    {
        thread function_31e0fb784781dcf8();
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x11d>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x12e>", @"hash_1583aa42d0c9d90a" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x148>", @"hash_1583aa42d0c9d90a" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x164>", @"scr_uav_tower_debug_spawn" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x170>", @"hash_158fdc0be6244136" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x18b>", @"hash_ce4d8222d33e9051" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x198>", @"hash_710ff2c3b923a971" );
        devgui::function_77df7fe7dd273e10();
        dev::devcommandwatcher( @"uav_tower", &debuguavtower );
    }

    // Namespace uav_tower
    // Params 2, eflags: 0x4
    // Checksum 0x35e75bc2, Offset: 0x65fe
    // Size: 0x319, Type: dev
    function private debuguavtower( command, argslist )
    {
        player = level.players[ 0 ];
        
        switch ( command )
        {
            case #"hash_8ba969b748118b3f":
                foreach ( index, _ in level.var_dfe8fdf9c0076a23 )
                {
                    level.var_dfe8fdf9c0076a23[ index ] = 0;
                }
                
                foreach ( team in level.allteamnamelist )
                {
                    foreach ( tower in level.uavtowers )
                    {
                        tower.uav_station.teamscooldown[ team ] = 0;
                    }
                }
                
                foreach ( tower in level.uavtowers )
                {
                    tower_disable( tower );
                }
                
                break;
            case #"hash_74438e9702ab94b3":
                friendly = !isdefined( argslist[ 0 ] );
                
                if ( !friendly )
                {
                    [ player ] = teams::getenemyplayers( player.team, 1 );
                }
                
                foreach ( tower in level.uavtowers )
                {
                    tower_used( tower.uav_station, undefined, undefined, player );
                }
                
                break;
            case #"hash_2d358ed4ebf819cc":
                level.toweruptime = int( argslist[ 0 ] );
                break;
            default:
                break;
        }
    }

    // Namespace uav_tower
    // Params 0, eflags: 0x4
    // Checksum 0x4c533600, Offset: 0x691f
    // Size: 0x575, Type: dev
    function private function_31e0fb784781dcf8()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_1583aa42d0c9d90a", 0 ) )
            {
                setdvar( @"hash_1583aa42d0c9d90a", 0 );
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"uav_tower_used", level.players );
                
                if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
                {
                    [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "<dev string:x1d2>", level.players, 0 );
                }
            }
            
            if ( getdvarint( @"hash_4d4dcdd9dd9dd058", 0 ) )
            {
                setdvar( @"hash_4d4dcdd9dd9dd058", 0 );
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"uav_tower_used_others", level.players );
                
                if ( utility::issharedfuncdefined( #"hud", #"showbrdmzsplash" ) )
                {
                    [[ utility::getsharedfunc( #"hud", #"showbrdmzsplash" ) ]]( "<dev string:x1ef>", level.players, 0 );
                }
            }
            
            if ( getdvarint( @"scr_uav_tower_debug_spawn", 0 ) )
            {
                setdvar( @"scr_uav_tower_debug_spawn", 0 );
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    forward = anglestoforward( player getplayerangles() );
                    pos = player.origin + forward * 300;
                    pos = utility::drop_to_ground( pos, 100 );
                    tower_struct = spawnstruct();
                    tower_struct.origin = pos;
                    tower_struct.angles = ( 0, 0, 0 );
                    spawnuavtower( tower_struct, level.uavtowers.size );
                }
            }
            
            if ( getdvarint( @"hash_158fdc0be6244136", 0 ) )
            {
                setdvar( @"hash_158fdc0be6244136", 0 );
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    closest_tower = sortbydistance( level.uavtowers, player.origin )[ 0 ];
                    
                    if ( isdefined( closest_tower ) )
                    {
                        closest_tower function_f62c2471b7b672e( player );
                    }
                }
            }
            
            var_3b485f116f066dbf = getdvarint( @"hash_ce4d8222d33e9051", 0 );
            
            if ( var_3b485f116f066dbf )
            {
                setdvar( @"hash_ce4d8222d33e9051", 0 );
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    if ( var_3b485f116f066dbf == 2 && player.team == level.players[ 0 ].team )
                    {
                        continue;
                    }
                    
                    var_32745f1dee3c9ef3 = 0;
                    
                    if ( isdefined( player.perks[ "<dev string:x20e>" ] ) )
                    {
                        var_32745f1dee3c9ef3 = 1;
                    }
                    
                    if ( var_32745f1dee3c9ef3 )
                    {
                        radius = int( level.var_73b0db0ae4b5b606 * ( level.var_2ab3ff8456131beb ?? 1 ) );
                    }
                    else
                    {
                        radius = int( level.var_73b0db0ae4b5b606 );
                    }
                    
                    triggerportableradarpingteam( player.origin, player.team, radius, level.var_91770bcd2cf3d204 );
                }
            }
            
            if ( getdvarint( @"hash_710ff2c3b923a971", 0 ) )
            {
                setdvar( @"hash_710ff2c3b923a971", 0 );
                
                foreach ( player in level.players )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"uav_tower_used" );
                }
            }
            
            if ( getdvarint( @"hash_9705adb45ef93ac", 0 ) )
            {
                setdvar( @"hash_9705adb45ef93ac", 0 );
                function_28eec0c7733904e8( 0 );
            }
            
            waitframe();
        }
    }

#/
