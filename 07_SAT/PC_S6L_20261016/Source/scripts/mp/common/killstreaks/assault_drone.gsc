// scripts\mp\common\killstreaks\assault_drone.gsc  (hash_5d9e9c912716b012.gscc) (size: 16709 Bytes / 0x4145 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2830b97 (3531803543)
// size ...... 16709 (0x4145)
// includes .. 18  (offset: 0x3bc9)
// strings ... 69  (offset: 0x3c59)
// dev strs .. 1   (offset: 0x4139)
// exports ... 32  (offset: 0x26f9)
// cseg ...... 0x4e6 + 0x2213 (0x26f9)
// imports ... 132 (offset: 0x2bf9)
// animtree1 . 0   (offset: 0x4145)
// animtree2 . 0   (offset: 0x4145)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\armor;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\recon_drone;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\render_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;

#namespace assault_drone;

// Namespace assault_drone
// Params 0
// Checksum 0x7e75c4cc, Offset: 0x504
// Size: 0x37
function init()
{
    function_5971bd8444f983bf();
    function_ee1ace5a4e39b84d();
    init_assault_drone_vo();
    init_assault_drone_anim();
    function_a9b2dbcf1206c037();
    
    /#
        setdevdvarifuninitialized( @"hash_268779ee67d4a45a", 0 );
    #/
}

// Namespace assault_drone
// Params 0
// Checksum 0x8b07c6da, Offset: 0x543
// Size: 0x4b2
function function_5971bd8444f983bf()
{
    level.helperdronesettings[ "assault_drone" ] = spawnstruct();
    level.helperdronesettings[ "assault_drone" ].timeout = 30;
    level.helperdronesettings[ "assault_drone" ].maxhealth = 150;
    level.helperdronesettings[ "assault_drone" ].hitstokill = 1;
    level.helperdronesettings[ "assault_drone" ].speed = 100;
    level.helperdronesettings[ "assault_drone" ].accel = 20;
    level.helperdronesettings[ "assault_drone" ].halfsize = 27;
    level.helperdronesettings[ "assault_drone" ].spawndist = 30;
    level.helperdronesettings[ "assault_drone" ].streakname = "assault_drone";
    level.helperdronesettings[ "assault_drone" ].vehicleinfo = "veh_assault_drone_mp";
    level.helperdronesettings[ "assault_drone" ].modelbase = "veh9_mil_air_bomb_drone_c4_attached_mp";
    level.helperdronesettings[ "assault_drone" ].teamsplash = "used_" + "assault_drone";
    level.helperdronesettings[ "assault_drone" ].destroyedsplash = "callout_destroyed_" + "assault_drone";
    level.helperdronesettings[ "assault_drone" ].scorepopup = "destroyed_" + "assault_drone";
    level.helperdronesettings[ "assault_drone" ].primarymode = "MANUAL";
    level.helperdronesettings[ "assault_drone" ].primarymodestring = "test string";
    level.helperdronesettings[ "assault_drone" ].primarymodefunc = &function_b5d4ae343956e1a1;
    level.helperdronesettings[ "assault_drone" ].premoddamagefunc = undefined;
    level.helperdronesettings[ "assault_drone" ].postmoddamagefunc = &helper_drone::helperdrone_postmodifydamage;
    level.helperdronesettings[ "assault_drone" ].deathfunc = &helper_drone::helperdrone_handledeathdamage;
    level.helperdronesettings[ "assault_drone" ].tryusefunc = &function_a40936578095e2f8;
    level.helperdronesettings[ "assault_drone" ].exitfunc = &assaultdrone_exit;
    level.helperdronesettings[ "assault_drone" ].leavefunc = &assaultdrone_leave;
    level.helperdronesettings[ "assault_drone" ].explodefunc = &assaultdrone_explode;
    level.helperdronesettings[ "assault_drone" ].returnplayerfunc = &assaultdrone_returnplayer;
    level.helperdronesettings[ "assault_drone" ].playfxcallback = &helper_drone::helperdrone_playfx;
    level.helperdronesettings[ "assault_drone" ].var_a2bdd1c0e927f10e = &function_963423a91ac9cac6;
    level.helperdronesettings[ "assault_drone" ].var_d188942a41771ea1 = &function_bf11d20cec694752;
    level.helperdronesettings[ "assault_drone" ].var_beb5cf9815327759 = 0;
    level.helperdronesettings[ "assault_drone" ].var_8882e489606fbd21 = 0;
    level.helperdronesettings[ "assault_drone" ].var_56f14c50d828adbe = 73441;
    level.helperdronesettings[ "assault_drone" ].var_c069a84757495b12 = 10000;
    level.helperdronesettings[ "assault_drone" ].colorvision = "assault_drone_color_mp";
    level.helperdronesettings[ "assault_drone" ].var_9fa8a04fa6a7af05 = "assault_drone_color_dark_mp";
    level.helperdronesettings[ "assault_drone" ].var_eaf7aed3b097c78d = 1;
    level.helperdronesettings[ "assault_drone" ].var_87f65f379613d0e7 = 0;
    level.helperdronesettings[ "assault_drone" ].var_6dbecaf540678d47 = 1;
    level.helperdronesettings[ "assault_drone" ].detonateontimeout = 1;
    level.helperdronesettings[ "assault_drone" ].voontimeout = 0;
    
    if ( isbrgamemode() )
    {
        level.helperdronesettings[ "assault_drone" ].diewithowner = 1;
    }
}

// Namespace assault_drone
// Params 0
// Checksum 0x269bcf8a, Offset: 0x9fd
// Size: 0x103
function function_ee1ace5a4e39b84d()
{
    val::group_register( "assaultDrone_switch", [ "allow_movement", "allow_jump", "supers", "killstreaks", "vehicle_use" ] );
    val::group_register( "assaultDrone_deploy", [ "usability", "melee", "offhand_weapons", "weapon_switch" ] );
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_abbcd9152e41d77f" ) && ![[ utility::getsharedfunc( #"equipment", #"hash_abbcd9152e41d77f" ) ]]() )
    {
        val::group_register( "assaultDrone_use", [ "fire", "shellshock", "melee" ] );
        return;
    }
    
    val::group_register( "assaultDrone_use", [ "fire", "shellshock", "melee", "nvg" ] );
}

// Namespace assault_drone
// Params 0
// Checksum 0xb5bc1f37, Offset: 0xb08
// Size: 0x9d
function init_assault_drone_vo()
{
    game[ "dialog" ][ "assault_drone" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "assault_drone" + "_timeout" ] = "killstreak_remote_operator" + "_timeout";
    game[ "dialog" ][ "assault_drone" + "_destroyed" ] = "killstreak_remote_operator" + "_crash";
    game[ "dialog" ][ "assault_drone" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "assault_drone" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace assault_drone
// Params 0
// Checksum 0xadb14efe, Offset: 0xbad
// Size: 0x2
function init_assault_drone_anim()
{
    
}

// Namespace assault_drone
// Params 0
// Checksum 0x278553c5, Offset: 0xbb7
// Size: 0x54
function function_a9b2dbcf1206c037()
{
    if ( isdefined( level.assaultdronevisionset ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.assaultdronevisionset );
    }
    
    if ( isdefined( level.var_e887cce8358222f3 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.var_e887cce8358222f3 );
    }
    
    killstreak_shared::function_28d986de72ce85f8( "assault_drone_color_mp" );
    killstreak_shared::function_28d986de72ce85f8( "assault_drone_color_dark_mp" );
}

// Namespace assault_drone
// Params 0
// Checksum 0xbdf1a4cd, Offset: 0xc13
// Size: 0x22
function tryuseassaultdrone()
{
    streakinfo = killstreak_utility::createstreakinfo( "assault_drone", self );
    return function_a40936578095e2f8( streakinfo );
}

// Namespace assault_drone
// Params 1
// Checksum 0x2c6abb84, Offset: 0xc3e
// Size: 0x524, Type: bool
function function_a40936578095e2f8( streakinfo )
{
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        return false;
    }
    
    self notify( #"using_remote" );
    helperdronetype = streakinfo.streakname;
    startpos = helper_drone::function_a5f95568df49cf66( helperdronetype );
    var_627fb43f841ec021 = utility::callsharedfunc( #"map", #"hash_b4fafa9d5f310a7e", self, startpos );
    
    if ( !isdefined( startpos ) || var_627fb43f841ec021 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return false;
    }
    
    val::group_set( "assaultDrone_switch", 0 );
    deployweaponobj = makeweapon( "ks_assault_drone_mp" );
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &helper_drone::weapongivenhelperdrone );
    
    if ( !deployresult )
    {
        val::group_reset( "assaultDrone_switch" );
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            val::group_reset( "assaultDrone_switch" );
            vehicle_tracking::function_4f76f5b4541acef1();
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    self notify( #"assaultdronecalled" );
    fullanimtime = 2;
    var_65934120c2efeb81 = 0.5;
    val::group_set( "assaultDrone_deploy", 0 );
    player::_freezecontrols( 1, undefined, "heliEndRide" );
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
    
    result = utility::waittill_any_timeout( fullanimtime, "death" );
    
    if ( result != "timeout" )
    {
        player::_freezecontrols( 0, 1, "assaultDrone" );
        val::group_reset( "assaultDrone_switch" );
        val::group_reset( "assaultDrone_deploy" );
        vehicle_tracking::function_4f76f5b4541acef1();
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    startpos = helper_drone::function_a5f95568df49cf66( helperdronetype );
    startangles = self.angles;
    assaultdrone = assaultdrone_create( startpos, startangles, helperdronetype, streakinfo );
    
    if ( !isdefined( assaultdrone ) )
    {
        player::_freezecontrols( 0, 1, "assaultDrone" );
        val::group_reset( "assaultDrone_switch" );
        val::group_reset( "assaultDrone_deploy" );
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"weapons", #"_launchgrenade" ) )
    {
        if ( isbrgamemode() )
        {
            dangericonent = self [[ utility::getsharedfunc( #"weapons", #"_launchgrenade" ) ]]( "assault_drone_danger_br", assaultdrone.origin, ( 0, 0, 0 ), 100, 1 );
        }
        else
        {
            dangericonent = self [[ utility::getsharedfunc( #"weapons", #"_launchgrenade" ) ]]( "assault_drone_danger_mp", assaultdrone.origin, ( 0, 0, 0 ), 100, 1 );
        }
        
        dangericonent.streakinfo = streakinfo;
        dangericonent linkto( assaultdrone );
        assaultdrone.dangericonent = dangericonent;
    }
    
    thread helper_drone::helperdrone_giveplayerfauxremote( streakinfo );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"killstreakuse" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"killstreakuse" ) ]]( "assault_drone" );
    }
    
    if ( isbrgamemode() )
    {
        assaultdrone vehicleshowonminimap( 0 );
    }
    
    killstreak_utility::playkillstreakusedialog( streakinfo.streakname );
    assaultdrone helper_drone::helperdrone_notifyenemyplayersinrange( streakinfo.streakname );
    player::_freezecontrols( 0, 1, "assaultDrone" );
    helper_drone::function_bc4c01fe510bb495( streakinfo );
    var_5e25c8d3a2282d8 = getdvarint( @"hash_fdc42aba096a2344", 3 );
    thread helper_drone::starthelperdrone( assaultdrone, var_5e25c8d3a2282d8 );
    bundle = level.streakglobals.streakbundles[ "assault_drone" ];
    
    if ( isdefined( bundle ) && isdefined( bundle.dangerzoneheight ) && !bundle.var_cdb412d03773acb7 )
    {
        origin = assaultdrone.origin - ( 0, 0, bundle.dangerzoneheight / 2 );
        assaultdrone killstreak_utility::function_56141a75b0286674( #"hash_eafb9a6b88def4ca", self, self.team, origin );
    }
    
    self notify( #"assault_drone_deployed" );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, streakinfo.streakname + "_use", #"use", 1, var_65934120c2efeb81 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_276acc5232cc83b9" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_276acc5232cc83b9" ) ]]( assaultdrone );
    }
    
    return true;
}

// Namespace assault_drone
// Params 4
// Checksum 0x8d300ba8, Offset: 0x116b
// Size: 0x114
function assaultdrone_create( startpos, startang, helperdronetype, streakinfo )
{
    assaultdrone = helper_drone::createhelperdrone( startpos, startang, helperdronetype, streakinfo, 0, 1 );
    
    if ( !isdefined( assaultdrone ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        helper_drone::helperdronecreationfailedfx( helperdronetype, startpos );
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        helper_drone::function_bc4c01fe510bb495( streakinfo );
        return;
    }
    
    assaultdrone.owner.var_bf76d1814a73cd34 = 0;
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( streakinfo );
    }
    
    return assaultdrone;
}

// Namespace assault_drone
// Params 1
// Checksum 0x1ef75d9b, Offset: 0x1288
// Size: 0x38
function function_963423a91ac9cac6( streakname )
{
    hitstokill = level.helperdronesettings[ streakname ].hitstokill;
    vehicle_damage::set_vehicle_hit_damage_data( streakname, hitstokill );
}

// Namespace assault_drone
// Params 1
// Checksum 0x4bdc3fc6, Offset: 0x12c8
// Size: 0x91
function function_bf11d20cec694752( streakname )
{
    hitstokill = level.helperdronesettings[ streakname ].hitstokill;
    weaponname = "emp_grenade_mp";
    weaponhitsperattack = hitstokill;
    var_ffcfe5819a7a67f1 = hitstokill;
    
    if ( utility::issharedfuncdefined( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_damage", #"vehicle_setuphitdamageoverrideforweapon" ) ]]( weaponname, weaponhitsperattack, var_ffcfe5819a7a67f1, streakname );
    }
}

// Namespace assault_drone
// Params 1
// Checksum 0xc7d4a7a1, Offset: 0x1361
// Size: 0x2b
function function_b5d4ae343956e1a1( config )
{
    if ( !isdefined( self.usedcount ) )
    {
        self.usedcount = 0;
    }
    
    thread function_3026376ff4e32bb1( config );
}

// Namespace assault_drone
// Params 1
// Checksum 0xc52d32eb, Offset: 0x1394
// Size: 0x2d2, Type: bool
function function_3026376ff4e32bb1( config )
{
    self.owner thread player_utility::watchthermalinputchange( 1 );
    self.playersfx = spawn( "script_origin", self.origin );
    self.playersfx showonlytoplayer( self.owner );
    self.playersfx linkto( self );
    self.playersfx playloopsound( "recon_drone_overlay" );
    self.owner setsoundsubmix( "mp_recon_drone", 1 );
    self.targetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self.owner, undefined, self.owner, 0, 0, 0 );
    self.ispiloted = 1;
    self.owner val::group_set( "assaultDrone_use", 0 );
    self.owner.restoreangles = self.owner.angles;
    self.owner setplayerangles( self.angles );
    self.owner cameralinkto( self, "tag_origin", 0, 1 );
    
    if ( !isdefined( self.empcount ) || self.empcount == 0 )
    {
        self.owner remotecontrolvehicle( self );
        self.owner render_utility::function_2636a65c7f96feff( 1, 0, 0.015, 0.15 );
    }
    
    self.owner painvisionoff();
    self setscriptablepartstate( "ddos", "neutral", 0 );
    emp_debuff::set_start_emp_callback( &assaultdrone_empstarted );
    
    if ( level.killstreak_emp_initialized )
    {
        self.var_5b3dbacfeda0fd01 = &assaultdrone_empstarted;
    }
    
    emp_debuff::set_apply_emp_callback( &assaultdrone_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempapplycallback = &assaultdrone_empapplied;
    }
    
    emp_debuff::set_clear_emp_callback( &assaultdrone_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempclearcallback = &assaultdrone_empcleared;
    }
    
    haywire::function_7f69a1eb3d590f76( &assaultdrone_haywireapplied );
    killstreak_utility::movingplatform_playerlink( self.owner );
    self.owner helper_drone::function_686284be4293a73a( 1, self );
    self.owner setclientomnvar( "ui_rcd_outer_ring", 0 );
    
    if ( utility::issharedfuncdefined( #"game", #"registerentforoob" ) )
    {
        [[ utility::getsharedfunc( #"game", #"registerentforoob" ) ]]( self, "killstreak" );
    }
    
    thread recon_drone::function_a35d4d18f8290186( config );
    thread function_de370aa725001f4d( config );
    thread function_2ae2d5f81938e6c3( config );
    self setscriptablepartstate( "warning_beep", "on", 0 );
    self.owner killstreak_shared::killstreak_savenvgstate();
    thread function_e52b06d169e09e2c( config );
    return true;
}

// Namespace assault_drone
// Params 1
// Checksum 0x4b339908, Offset: 0x166f
// Size: 0xb7
function function_de370aa725001f4d( config )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"switch_modes" );
    self.owner endon( #"disconnect" );
    reticlestate = 0;
    
    while ( true )
    {
        if ( self.var_e3fb5db28789e005 && reticlestate == 0 )
        {
            self.owner setclientomnvar( "ui_rcd_outer_ring", 1 );
            reticlestate = 1;
        }
        else if ( !self.var_e3fb5db28789e005 && reticlestate == 1 )
        {
            self.owner setclientomnvar( "ui_rcd_outer_ring", 0 );
            reticlestate = 0;
        }
        
        waitframe();
    }
}

// Namespace assault_drone
// Params 1
// Checksum 0x219e3568, Offset: 0x172e
// Size: 0x1af
function function_2ae2d5f81938e6c3( config )
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"switch_modes" );
    var_54e4405a5938ecfc = 0;
    
    while ( true )
    {
        targets = self.targetsinouterradius;
        var_e3fb5db28789e005 = 0;
        
        foreach ( player in targets )
        {
            if ( var_54e4405a5938ecfc >= 3 )
            {
                var_54e4405a5938ecfc = 0;
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isplayer( player ) && !player::isreallyalive( player ) )
            {
                continue;
            }
            
            var_54e4405a5938ecfc++;
            helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 1 );
            isvisible = helper_drone::helperdrone_canseetarget( player );
            isinrange = recon_drone::function_5c048b824a93d619( player );
            
            if ( !isvisible )
            {
                helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 0 );
                continue;
            }
            else if ( !isinrange )
            {
                continue;
            }
            
            var_e3fb5db28789e005 = 1;
            helper_drone::helperdrone_settargetmarkerstate( self.targetmarkergroup, player, 2 );
        }
        
        self.var_e3fb5db28789e005 = var_e3fb5db28789e005;
        var_54e4405a5938ecfc = 0;
        waitframe();
    }
}

// Namespace assault_drone
// Params 0
// Checksum 0xbd8f426c, Offset: 0x18e5
// Size: 0x9
function assaultdrone_exit()
{
    thread assaultdrone_leave();
}

// Namespace assault_drone
// Params 1
// Checksum 0xf30e61, Offset: 0x18f6
// Size: 0x18
function assaultdrone_leave( timeout )
{
    thread helper_drone::helperdrone_explode( 0, 1, timeout );
}

// Namespace assault_drone
// Params 7
// Checksum 0x40a97cdb, Offset: 0x1916
// Size: 0x1bb
function assaultdrone_explode( config, wasdestroyed, wasexited, wastimedout, wasdetonated, thirdperson, damagedata )
{
    if ( self.empcount > 0 )
    {
        self.owner player::_freezelookcontrols( 0, 1 );
    }
    
    if ( utility::issharedfuncdefined( #"game", #"clearoob" ) )
    {
        [[ utility::getsharedfunc( #"game", #"clearoob" ) ]]( self, 1 );
    }
    
    if ( isdefined( self.dangericonent ) )
    {
        self.dangericonent delete();
    }
    
    self setscriptablepartstate( "warning_beep", "off", 0 );
    
    if ( !wasdestroyed )
    {
        self clearscriptabledamageowner();
    }
    
    if ( wasdetonated || wasexited && config.var_87f65f379613d0e7 || wastimedout && config.detonateontimeout || wasdestroyed && config.var_6dbecaf540678d47 )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_1d8dafd7607dbff0" ) )
        {
            self.owner thread [[ utility::getsharedfunc( #"killstreak", #"hash_1d8dafd7607dbff0" ) ]]( self );
        }
        
        helper_drone::function_eccf8adbfdb03edc();
        thread assaultdrone_watchkills();
    }
    else
    {
        helper_drone::function_e44894e06827a3a9();
    }
    
    if ( isdefined( level.var_845fe19bc9ff4b8e ) )
    {
        thread [[ level.var_845fe19bc9ff4b8e ]]( self.streakinfo, self.origin, 0 );
    }
    
    delayreturn = undefined;
    thread assaultdrone_returnplayer( self.owner, delayreturn );
}

// Namespace assault_drone
// Params 2
// Checksum 0x71138ad, Offset: 0x1ad9
// Size: 0x271
function assaultdrone_returnplayer( player, delayreturn )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    self setentityowner( player );
    self clearscriptabledamageowner();
    self.ispiloted = 0;
    
    if ( isdefined( player.super ) )
    {
        player.super.isactive = 0;
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx delete();
    }
    
    if ( isdefined( self.enemiesmarked ) )
    {
        foreach ( markdata in self.enemiesmarked )
        {
            recon_drone::function_27f725feb4b40f2d( markdata, player );
        }
    }
    
    tabletweapon = "ks_remote_drone_mp";
    
    if ( self.var_99e2d83f9d0b250a )
    {
        tabletweapon = "ks_remote_device_mp";
    }
    
    player thread recon_drone::recondrone_takedeployweapon( 1, tabletweapon );
    player helper_drone::helperdrone_takeplayerfauxremote( self.streakinfo );
    player painvisionon();
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
    
    player killstreak_utility::killstreak_setmainvision( "" );
    
    if ( self.isthermalenabled )
    {
        player player_utility::setthermalvision( 0 );
    }
    
    player player::_freezecontrols( 0, 1, "assaultDrone" );
    player player::_freezelookcontrols( 0, 1 );
    player val::group_reset( "assaultDrone_switch" );
    player val::group_reset( "assaultDrone_deploy" );
    player val::group_reset( "assaultDrone_use" );
    player thread helper_drone::function_ab65cb511ffc8807();
    
    if ( self.isempd )
    {
        self.isempd = undefined;
        self.owner thread emp_debuff::stop_emp_scramble( 5 );
    }
    
    if ( !self.haywiredeath )
    {
        player remotecontrolvehicleoff();
    }
    
    player render_utility::function_7d5ac95f0cd3294a();
    killstreak_utility::movingplatform_playerunlink( player );
    player killstreak_shared::killstreak_restorenvgstate();
    
    if ( isdefined( delayreturn ) )
    {
        wait delayreturn;
    }
    
    player cameraunlink();
    player setplayerangles( ( player.restoreangles[ 0 ], player.restoreangles[ 1 ], 0 ) );
    player.restoreangles = undefined;
}

// Namespace assault_drone
// Params 1
// Checksum 0xa034bc29, Offset: 0x1d52
// Size: 0x123
function function_12f67d8444bd78b2( config )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    self.owner notifyonplayercommand( "drone_camera_switch", "+melee_zoom" );
    
    while ( true )
    {
        self.owner waittill( #"drone_camera_switch" );
        var_85bd7e7eb7a23992 = 0;
        
        /#
            var_85bd7e7eb7a23992 = getdvarint( @"hash_268779ee67d4a45a", 0 );
        #/
        
        if ( !var_85bd7e7eb7a23992 )
        {
            continue;
        }
        
        if ( self.camerastate == "default" )
        {
            self.owner player::_freezelookcontrols( 1 );
            function_1b9accf83ed83938( 2, "under", "tag_undercam" );
            thread function_94e86715f1c41f22( config );
            
            /#
                thread function_38c78d47f5c7b510( "<dev string:x24>" );
            #/
            
            continue;
        }
        
        self.owner player::_freezelookcontrols( 0, 1 );
        function_1b9accf83ed83938( 1, "default", "tag_origin" );
        thread function_e52b06d169e09e2c( config );
    }
}

// Namespace assault_drone
// Params 1
// Checksum 0x3ae3bf1c, Offset: 0x1e7d
// Size: 0x90
function function_94e86715f1c41f22( config )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"detonate_bomb" );
    self.owner endon( #"disconnect" );
    self notify( #"release_bomb" );
    self.owner notifyonplayercommand( "drone_release_bomb", "+attack" );
    self.owner waittill( #"drone_release_bomb" );
    childthread function_9e02da939a522b8b();
}

// Namespace assault_drone
// Params 0
// Checksum 0x4845d0f6, Offset: 0x1f15
// Size: 0xda
function assaultdrone_watchkills()
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    hostmigration::waitlongdurationwithpause( 1 );
    
    if ( !isdefined( droneowner.var_eaf5be39c4590dd ) )
    {
        droneowner.var_eaf5be39c4590dd = 0;
    }
    
    if ( droneowner.recentkillcount >= 1 || droneowner.var_eaf5be39c4590dd >= 1 || droneowner.var_bf76d1814a73cd34 >= 1 )
    {
        droneowner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "assault_drone" + "_hit_target", #"hit", 1 );
    }
    else
    {
        droneowner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "assault_drone" + "_miss_target", #"miss", 1 );
    }
    
    self.var_bf76d1814a73cd34 = undefined;
}

// Namespace assault_drone
// Params 1
// Checksum 0x55067110, Offset: 0x1ff7
// Size: 0xc7
function function_e52b06d169e09e2c( config )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self endon( #"release_bomb" );
    self.owner endon( #"disconnect" );
    self notify( #"detonate_bomb" );
    self.owner notifyonplayercommand( "drone_detonate", "+attack" );
    
    while ( true )
    {
        self.owner waittill( #"drone_detonate" );
        
        if ( self.owner.ksempd || emp_debuff::is_empd() )
        {
            continue;
        }
        else
        {
            thread helper_drone::helperdrone_explode( 0, 0, 0, 1 );
            break;
        }
        
        waitframe();
    }
}

// Namespace assault_drone
// Params 3
// Checksum 0x55c10dfa, Offset: 0x20c6
// Size: 0xa8
function function_1b9accf83ed83938( controlstate, camerastate, cameratag )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    self.owner cameraunlink();
    self.owner helper_drone::function_686284be4293a73a( 0 );
    waitframe();
    self.owner cameralinkto( self, cameratag, 0, 1 );
    self.owner helper_drone::function_686284be4293a73a( controlstate, self );
    self.camerastate = camerastate;
}

// Namespace assault_drone
// Params 0
// Checksum 0x5db46934, Offset: 0x2176
// Size: 0xab
function function_9e02da939a522b8b()
{
    launchdir = vectornormalize( self.origin - ( 0, 0, 5 ) - self.origin );
    launchoffset = self.origin + launchdir * 10;
    launchgoal = launchoffset + launchdir * 100;
    launchvelocity = launchgoal - launchoffset;
    projectile = magicgrenademanual( "assault_drone_mp", launchoffset, launchvelocity, 99, self.owner );
    projectile.streakinfo = self.streakinfo;
    wait 2;
    thread assaultdrone_leave();
}

// Namespace assault_drone
// Params 1
// Checksum 0xc3ba4fe, Offset: 0x2229
// Size: 0x76
function assaultdrone_haywireapplied( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) && isdefined( data.inflictor ) && self.currenthealth > 0 )
    {
        self dodamage( self.maxhealth, self.origin, data.attacker, data.inflictor );
    }
}

// Namespace assault_drone
// Params 1
// Checksum 0x652006a8, Offset: 0x22a7
// Size: 0xf2
function assaultdrone_empstarted( data )
{
    self setscriptablepartstate( "ddos", "disabled", 0 );
    self setscriptablepartstate( "warning_beep", "off", 0 );
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_bomb_drone" );
        }
    }
    
    if ( self.ispiloted )
    {
        self.owner player::_freezecontrols( 1, undefined, "assaultDrone" );
        self.owner player::_freezelookcontrols( 1 );
        
        if ( !self.isempd )
        {
            self.isempd = 1;
            self.owner thread emp_debuff::play_emp_scramble( 5 );
        }
    }
}

// Namespace assault_drone
// Params 1
// Checksum 0x6df30347, Offset: 0x23a1
// Size: 0x70
function assaultdrone_empapplied( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_bomb_drone" );
        }
    }
}

// Namespace assault_drone
// Params 1
// Checksum 0x82c8968e, Offset: 0x2419
// Size: 0x9c
function assaultdrone_empcleared( isdeath )
{
    self setscriptablepartstate( "ddos", "neutral", 0 );
    self setscriptablepartstate( "warning_beep", "on", 0 );
    
    if ( self.isempd )
    {
        self.isempd = undefined;
        self.owner thread emp_debuff::stop_emp_scramble( 5 );
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( self.ispiloted )
    {
        self.owner player::_freezecontrols( 0, 1, "assaultDrone" );
        self.owner player::_freezelookcontrols( 0, 1 );
    }
}

// Namespace assault_drone
// Params 3
// Checksum 0x6f791dc8, Offset: 0x24bd
// Size: 0x1a7
function function_9b5a8615192cc2f6( inflictor, victim, scaleddamage )
{
    if ( !( isdefined( inflictor ) && isdefined( victim ) ) )
    {
        return scaleddamage;
    }
    
    var_763cc8a920ca25bf = victim armor::function_70d2a998e632c76();
    
    if ( var_763cc8a920ca25bf )
    {
        var_ce4f5f718a9d6fae = utility::playersnear( inflictor.origin, 100 );
        var_6adf9cb1998ec47c = 0;
        
        foreach ( potentialtarget in var_ce4f5f718a9d6fae )
        {
            if ( potentialtarget != victim )
            {
                continue;
            }
            
            var_6adf9cb1998ec47c = 1;
            break;
        }
        
        if ( !var_6adf9cb1998ec47c )
        {
            scaleddamage = victim armor::getarmorhealth() + victim.health - 1;
            
            if ( isdefined( inflictor.owner ) )
            {
                if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
                {
                    if ( victim.platecarriertype == "brloot_plate_carrier_tempered" )
                    {
                        inflictor.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"br_tempered_plate_broken" );
                    }
                    else
                    {
                        inflictor.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"br_three_plate_broken" );
                    }
                }
            }
        }
    }
    
    return scaleddamage;
}

/#

    // Namespace assault_drone
    // Params 1
    // Checksum 0x49d30be0, Offset: 0x266d
    // Size: 0x8c, Type: dev
    function function_38c78d47f5c7b510( cameratag )
    {
        self endon( #"death" );
        self endon( #"explode" );
        self endon( #"leaving" );
        self.owner endon( #"disconnect" );
        self.owner endon( #"drone_camera_switch" );
        
        while ( true )
        {
            level thread debug_utility::drawsphere( self gettagorigin( cameratag ), 10, 0.05, ( 1, 1, 1 ) );
            wait 0.05;
        }
    }

#/
