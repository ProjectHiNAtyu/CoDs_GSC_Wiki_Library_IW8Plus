// scripts\mp\common\killstreaks\helper_drone.gsc  (hash_785265c2027066bf.gscc) (size: 57640 Bytes / 0xe128 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x561ebac1 (1444854465)
// size ...... 57640 (0xe128)
// includes .. 26  (offset: 0xd6c8)
// strings ... 133 (offset: 0xd798)
// dev strs .. 7   (offset: 0xe0cc)
// exports ... 122 (offset: 0x9894)
// cseg ...... 0xb5d + 0x8d37 (0x9894)
// imports ... 336 (offset: 0xaba4)
// animtree1 . 0   (offset: 0xe128)
// animtree2 . 0   (offset: 0xe128)
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\assault_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;

#namespace helper_drone;

// Namespace helper_drone
// Params 0
// Checksum 0xbcdfb470, Offset: 0xb7b
// Size: 0x7fb
function init()
{
    if ( !isdefined( level.helperdronesettings ) )
    {
        level.helperdronesettings = [];
    }
    
    assault_drone::init();
    level.helperdronesettings[ "radar_drone_overwatch" ] = spawnstruct();
    level.helperdronesettings[ "radar_drone_overwatch" ].timeout = 45;
    level.helperdronesettings[ "radar_drone_overwatch" ].maxhealth = 700;
    level.helperdronesettings[ "radar_drone_overwatch" ].hitstokill = 3;
    level.helperdronesettings[ "radar_drone_overwatch" ].speed = 100;
    level.helperdronesettings[ "radar_drone_overwatch" ].accel = 10;
    level.helperdronesettings[ "radar_drone_overwatch" ].halfsize = 50;
    level.helperdronesettings[ "radar_drone_overwatch" ].spawndist = 100;
    level.helperdronesettings[ "radar_drone_overwatch" ].streakname = "radar_drone_overwatch";
    level.helperdronesettings[ "radar_drone_overwatch" ].vehicleinfo = "veh_radar_drone_overwatch_mp";
    level.helperdronesettings[ "radar_drone_overwatch" ].modelbase = "veh8_mil_air_mquebec8_small";
    level.helperdronesettings[ "radar_drone_overwatch" ].modelbasealt = "veh8_mil_air_mquebec8_small_east";
    level.helperdronesettings[ "radar_drone_overwatch" ].teamsplash = "used_radar_drone_overwatch";
    level.helperdronesettings[ "radar_drone_overwatch" ].destroyedsplash = "callout_destroyed_radar_drone_overwatch";
    level.helperdronesettings[ "radar_drone_overwatch" ].sound_explode = "radar_drone_explode";
    level.helperdronesettings[ "radar_drone_overwatch" ].vodestroyed = "destroyed_radar_drone_overwatch";
    level.helperdronesettings[ "radar_drone_overwatch" ].votimedout = "timeout_radar_drone_overwatch";
    level.helperdronesettings[ "radar_drone_overwatch" ].scorepopup = "destroyed_radar_drone_overwatch";
    level.helperdronesettings[ "radar_drone_overwatch" ].playfxcallback = &helperdrone_playfx;
    level.helperdronesettings[ "radar_drone_overwatch" ].standupoffset = 120;
    level.helperdronesettings[ "radar_drone_overwatch" ].crouchupoffset = 80;
    level.helperdronesettings[ "radar_drone_overwatch" ].proneupoffset = 46;
    level.helperdronesettings[ "radar_drone_overwatch" ].backoffset = 124;
    level.helperdronesettings[ "radar_drone_overwatch" ].sideoffset = 55;
    level.helperdronesettings[ "radar_drone_overwatch" ].primarymode = "RADAR";
    level.helperdronesettings[ "radar_drone_overwatch" ].primarymodestring = &"killstreaks_hints/rcd_radar";
    level.helperdronesettings[ "radar_drone_overwatch" ].primarymodefunc = &setoverwatchmodesettings;
    level.helperdronesettings[ "radar_drone_overwatch" ].premoddamagefunc = undefined;
    level.helperdronesettings[ "radar_drone_overwatch" ].postmoddamagefunc = &helperdrone_postmodifydamage;
    level.helperdronesettings[ "radar_drone_overwatch" ].deathfunc = &helperdrone_handledeathdamage;
    level.helperdronesettings[ "radar_drone_overwatch" ].deployweaponname = "ks_gesture_generic_mp";
    
    if ( isbrgamemode() )
    {
        level.helperdronesettings[ "radar_drone_overwatch" ].diewithowner = 1;
    }
    
    level.helperdronesettings[ "ammo_drop" ] = spawnstruct();
    level.helperdronesettings[ "ammo_drop" ].timeout = undefined;
    level.helperdronesettings[ "ammo_drop" ].maxhealth = 100;
    level.helperdronesettings[ "ammo_drop" ].hitstokill = 3;
    level.helperdronesettings[ "ammo_drop" ].speed = 60;
    level.helperdronesettings[ "ammo_drop" ].accel = 20;
    level.helperdronesettings[ "ammo_drop" ].halfsize = 30;
    level.helperdronesettings[ "ammo_drop" ].spawndist = 100;
    level.helperdronesettings[ "ammo_drop" ].streakname = "ammo_drop";
    level.helperdronesettings[ "ammo_drop" ].vehicleinfo = "veh_delivery_drone_recon_mp";
    level.helperdronesettings[ "ammo_drop" ].modelbase = "veh8_mil_air_malfa_big";
    level.helperdronesettings[ "ammo_drop" ].teamsplash = "used_radar_drone_recon";
    level.helperdronesettings[ "ammo_drop" ].destroyedsplash = "callout_destroyed_radar_drone_overwatch";
    level.helperdronesettings[ "ammo_drop" ].sound_explode = "radar_drone_explode";
    level.helperdronesettings[ "ammo_drop" ].vodestroyed = "ball_drone_backup_destroy";
    level.helperdronesettings[ "ammo_drop" ].votimedout = "ball_drone_backup_timeout";
    level.helperdronesettings[ "ammo_drop" ].scorepopup = "destroyed_radar_drone_recon";
    level.helperdronesettings[ "ammo_drop" ].playfxcallback = &helperdrone_playfx;
    level.helperdronesettings[ "ammo_drop" ].standupoffset = 120;
    level.helperdronesettings[ "ammo_drop" ].crouchupoffset = 80;
    level.helperdronesettings[ "ammo_drop" ].proneupoffset = 46;
    level.helperdronesettings[ "ammo_drop" ].backoffset = 124;
    level.helperdronesettings[ "ammo_drop" ].sideoffset = 55;
    level.helperdronesettings[ "ammo_drop" ].primarymodefunc = &setdeliverymodesettings;
    level.helperdronesettings[ "ammo_drop" ].premoddamagefunc = undefined;
    level.helperdronesettings[ "ammo_drop" ].postmoddamagefunc = &helperdrone_postmodifydamage;
    level.helperdronesettings[ "ammo_drop" ].deathfunc = &helperdrone_handledeathdamage;
    level.helperdronesettings[ "ammo_drop" ].deployweaponname = "ks_gesture_generic_mp";
    level.helperdronesettings[ "shouldIgnoreImmediateDamage" ] = [];
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"init" ) )
    {
        [[ utility::getsharedfunc( #"helper_drone", #"init" ) ]]();
    }
    
    level.incominghelperdrones = [];
    init_helper_drone_vo();
    init_helper_drone_anim();
    function_981869e683eddff4();
    
    /#
        setdevdvarifuninitialized( @"scr_helperdrone_timeout", 60 );
        setdevdvarifuninitialized( @"hash_2bdd5a15714e6e8f", 0 );
        setdevdvarifuninitialized( @"hash_5dba01914d06f31d", 50 );
        setdevdvarifuninitialized( @"hash_728ad0e3aaae3e2b", 35 );
        setdevdvarifuninitialized( @"scr_helperdrone_debug_path", 0 );
        setdevdvarifuninitialized( @"scr_helperdrone_visibility", 0 );
        setdevdvarifuninitialized( @"hash_166b0ad3d56b43f", 0 );
        setdevdvarifuninitialized( @"hash_7786353439eb384c", 0 );
    #/
    
    utility::flag_set( "helper_drone_settings_loaded" );
}

// Namespace helper_drone
// Params 0
// Checksum 0x3599eb7e, Offset: 0x137e
// Size: 0x2
function init_helper_drone_vo()
{
    
}

// Namespace helper_drone
// Params 0
// Checksum 0x834c2b56, Offset: 0x1388
// Size: 0x2
function init_helper_drone_anim()
{
    
}

// Namespace helper_drone
// Params 0
// Checksum 0xc0988e0, Offset: 0x1392
// Size: 0x1a
function function_981869e683eddff4()
{
    killstreak_shared::function_28d986de72ce85f8( "recon_drone_color_mp" );
    killstreak_shared::function_28d986de72ce85f8( "recon_drone_color_dark_mp" );
}

// Namespace helper_drone
// Params 1
// Checksum 0xee3cb384, Offset: 0x13b4
// Size: 0xe, Type: bool
function weapongivenhelperdrone( streakinfo )
{
    return true;
}

// Namespace helper_drone
// Params 1
// Checksum 0x71332b33, Offset: 0x13cb
// Size: 0xa0
function function_a4e09d4e460bcb64( streakinfo )
{
    level.incominghelperdrones[ level.incominghelperdrones.size ] = spawnstruct();
    level.incominghelperdrones[ level.incominghelperdrones.size - 1 ].type = streakinfo.streakname;
    level.incominghelperdrones[ level.incominghelperdrones.size - 1 ].owner = self;
    level.incominghelperdrones[ level.incominghelperdrones.size - 1 ].team = self.team;
}

// Namespace helper_drone
// Params 1
// Checksum 0x20d9ff9e, Offset: 0x1473
// Size: 0xd7
function function_bc4c01fe510bb495( streakinfo )
{
    if ( level.incominghelperdrones.size == 0 )
    {
        return;
    }
    
    cleanuparray = [];
    
    foreach ( drone in level.incominghelperdrones )
    {
        if ( drone.type == streakinfo.streakname && drone.owner == self )
        {
            continue;
        }
        
        cleanuparray[ cleanuparray.size ] = drone;
    }
    
    level.incominghelperdrones = cleanuparray;
}

// Namespace helper_drone
// Params 2
// Checksum 0x317549fe, Offset: 0x1552
// Size: 0x37, Type: bool
function function_522905ceb07e70e0( streakinfo, showerror )
{
    function_a4e09d4e460bcb64( streakinfo );
    
    if ( function_37be65b472591d49( streakinfo, self ) )
    {
        function_bc4c01fe510bb495( streakinfo );
        return false;
    }
    
    return true;
}

// Namespace helper_drone
// Params 2
// Checksum 0xa4d452f8, Offset: 0x1592
// Size: 0x130, Type: bool
function function_82d83598f8412a9d( streakinfo, showerror )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"currentactivevehiclecount" ) && utility::issharedfuncdefined( #"killstreak", #"maxvehiclesallowed" ) )
    {
        if ( [[ utility::getsharedfunc( #"killstreak", #"currentactivevehiclecount" ) ]]() >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() || level.fauxvehiclecount + 1 >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() )
        {
            if ( showerror )
            {
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
                }
            }
            
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"vehicle", #"incrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"incrementfauxvehiclecount" ) ]]( 1 );
    }
    
    return true;
}

// Namespace helper_drone
// Params 2
// Checksum 0xd0c735b2, Offset: 0x16cb
// Size: 0x4a
function tryusehelperdrone( streakname, abilityrange = 1000 )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    streakinfo.abilityrange = abilityrange;
    return tryusehelperdronefromstruct( streakinfo );
}

// Namespace helper_drone
// Params 1
// Checksum 0xa977ad47, Offset: 0x171e
// Size: 0x941, Type: bool
function tryusehelperdronefromstruct( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_ce704e5491be04ff" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_ce704e5491be04ff" ) ]]( self );
    }
    
    helperdronetype = streakinfo.streakname;
    startpos = function_a5f95568df49cf66( helperdronetype );
    
    if ( !isdefined( startpos ) && helperdronetype != "scrambler_drone_guard" )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/NOT_ENOUGH_SPACE" );
        }
        
        return false;
    }
    
    config = level.helperdronesettings[ helperdronetype ];
    deployresult = undefined;
    var_65934120c2efeb81 = undefined;
    var_d3bad8b7042c10da = 0;
    
    if ( isdefined( config.tryusefunc ) )
    {
        var_d3bad8b7042c10da = 1;
        deployresult = self [[ config.tryusefunc ]]( streakinfo );
    }
    else
    {
        nonvehicle = !isdefined( config.vehicleinfo );
        
        if ( !nonvehicle )
        {
            if ( !vehicle_tracking::reserve_vehicle() )
            {
                return false;
            }
        }
        
        deployweaponname = level.helperdronesettings[ streakinfo.streakname ].deployweaponname;
        
        if ( isplayer( self ) )
        {
            deployweaponobj = makeweapon( deployweaponname );
            
            if ( killstreak_utility::function_1b357b025e90e8cc( deployweaponobj ) )
            {
                deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &weapongivenhelperdrone );
            }
            else if ( killstreak_utility::function_75333d343673ab1c( deployweaponobj ) )
            {
                deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &weapongivenhelperdrone );
            }
            else if ( killstreak_utility::iskillstreakgestureweapon( deployweaponobj ) )
            {
                deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, deployweaponobj );
            }
            else if ( killstreak_utility::function_d84b70a08674a174( deployweaponobj ) )
            {
                deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo );
            }
            else
            {
                deployresult = 0;
                assertmsg( "<dev string:x24>" );
            }
        }
        else
        {
            deployresult = 1;
        }
        
        if ( !deployresult )
        {
            if ( !nonvehicle )
            {
                vehicle_tracking::function_4f76f5b4541acef1();
            }
            
            return false;
        }
        
        if ( isdefined( level.killstreakbeginusefunc ) )
        {
            if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
            {
                if ( !nonvehicle )
                {
                    vehicle_tracking::function_4f76f5b4541acef1();
                }
                
                if ( deployweaponname != "ks_gesture_generic_mp" )
                {
                    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                }
                
                return false;
            }
        }
        
        if ( helperdronetype != "scrambler_drone_guard" || deployweaponname == "ks_gesture_generic_mp" )
        {
            var_f60ccc5164e18a4 = tryusehelperdroneearlyout( streakinfo, 1 );
            
            if ( var_f60ccc5164e18a4 )
            {
                if ( !nonvehicle )
                {
                    vehicle_tracking::function_4f76f5b4541acef1();
                }
                
                if ( deployweaponname != "ks_gesture_generic_mp" )
                {
                    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                }
                
                return false;
            }
        }
        
        startpos = function_a5f95568df49cf66( helperdronetype );
        
        if ( deployweaponname == "ks_remote_device_mp" )
        {
            if ( !isdefined( startpos ) )
            {
                if ( !nonvehicle )
                {
                    vehicle_tracking::function_4f76f5b4541acef1();
                }
                
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
                }
                
                streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                return false;
            }
        }
        
        if ( deployweaponname == "ks_remote_drone_mp" )
        {
            var_fd467b160103911b = 0.6;
            fullanimtime = 2;
            result = utility::waittill_any_timeout( var_fd467b160103911b, "death", "weapon_switch_started" );
            
            if ( result != "timeout" )
            {
                if ( !nonvehicle )
                {
                    vehicle_tracking::function_4f76f5b4541acef1();
                }
                
                streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                return false;
            }
            
            if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
            {
                var_d3bad8b7042c10da = 1;
                self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
                var_65934120c2efeb81 = 0.5;
            }
            
            val::set( "helperDrone", "weapon_switch", 0 );
            result = utility::waittill_any_timeout( fullanimtime - var_fd467b160103911b, "death" );
            
            if ( result != "timeout" )
            {
                if ( !nonvehicle )
                {
                    vehicle_tracking::function_4f76f5b4541acef1();
                }
                
                val::reset_all( "helperDrone" );
                streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                return false;
            }
            
            val::reset_all( "helperDrone" );
        }
        
        mappointinfo = undefined;
        
        if ( deployweaponname == "ks_remote_map_mp" )
        {
            mappointinfo = undefined;
            
            if ( utility::issharedfuncdefined( #"killstreak", #"getselectmappoint" ) )
            {
                mappointinfo = self [[ utility::getsharedfunc( #"killstreak", #"getselectmappoint" ) ]]( streakinfo, 1 );
            }
            
            if ( !isdefined( mappointinfo ) )
            {
                if ( !nonvehicle )
                {
                    vehicle_tracking::function_4f76f5b4541acef1();
                }
                
                if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
                {
                    [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
                }
                
                return false;
            }
        }
        else if ( helperdronetype == "scrambler_drone_guard" )
        {
            location = self.origin;
            
            if ( isdefined( level.traceselectedmaplocation ) )
            {
                tracedata = [[ level.traceselectedmaplocation ]]( self.origin );
                location = tracedata[ "position" ];
            }
            
            mappoint = spawnstruct();
            mappoint.location = location;
            mappointinfo = [];
            mappointinfo[ 0 ] = mappoint;
        }
        
        startang = self.angles;
        
        if ( isdefined( mappointinfo ) )
        {
            if ( helperdronetype == "scrambler_drone_guard" )
            {
                killstreak_utility::killstreak_dangernotifyplayersinrange( self, self.team, 15000, helperdronetype, mappointinfo[ 0 ].location );
                scramblerspawnpos = mappointinfo[ 0 ].location + ( 0, 0, 3000 );
                helperdrone = createhelperdrone( scramblerspawnpos, startang, helperdronetype, streakinfo, nonvehicle, !nonvehicle );
                
                if ( !isdefined( helperdrone ) )
                {
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/unavailable" );
                    }
                    
                    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
                    {
                        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
                    }
                    
                    function_bc4c01fe510bb495( streakinfo );
                    return false;
                }
                
                helperdrone.mappointinfo = mappointinfo;
                bundle = killstreak_utility::function_f943c0602acdc2af( helperdronetype );
                helperdrone thread killstreak_utility::killstreak_registerminimapinfo( bundle );
                function_bc4c01fe510bb495( streakinfo );
                thread starthelperdrone( helperdrone );
            }
        }
        else
        {
            if ( helperdronetype == "radar_drone_escort" || killstreak::function_17736ca3e3ad4382( helperdronetype ) )
            {
                startpos = function_a5f95568df49cf66( helperdronetype );
            }
            
            if ( helperdronetype == "radar_drone_overwatch" )
            {
                startpos = self.origin + ( 0, 0, 1500 ) - anglestoforward( self.angles ) * 5000;
            }
            
            helperdrone = createhelperdrone( startpos, startang, helperdronetype, streakinfo, nonvehicle, !nonvehicle );
            
            if ( !isdefined( helperdrone ) )
            {
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/NOT_ENOUGH_SPACE" );
                }
                
                helperdronecreationfailedfx( helperdronetype, startpos );
                streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                
                if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
                {
                    [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
                }
                
                function_bc4c01fe510bb495( streakinfo );
                return false;
            }
            
            if ( helperdronetype == "assault_drone" )
            {
                thread helperdrone_giveplayerfauxremote( streakinfo );
            }
            
            function_bc4c01fe510bb495( streakinfo );
            thread starthelperdrone( helperdrone );
        }
    }
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isplayer( self ) && !var_d3bad8b7042c10da )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
            var_65934120c2efeb81 = 2.5;
        }
        
        thread killstreak_utility::playkillstreaktacomdialog( streakinfo, streakinfo.streakname + "_use", #"use", 1, var_65934120c2efeb81 );
    }
    
    teamsplash = config.teamsplash;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( teamsplash, self );
    }
    
    if ( streakinfo.streakname == "assault_drone" )
    {
        if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, "bombDroneUsed" );
        }
    }
    
    level notify( #"helper_drone_started", self, helperdronetype );
    return true;
}

// Namespace helper_drone
// Params 2
// Checksum 0x3044a67c, Offset: 0x2068
// Size: 0x76
function helperdronecreationfailedfx( helperdronetype, failposition = self geteye() + ( 0, 0, 80 ) )
{
    fxent = spawn( "script_model", failposition );
    fxent setmodel( "ks_" + helperdronetype + "_mp" );
    fxent setscriptablepartstate( "exit", "on", 0 );
    fxent thread delay_deletescriptable();
}

// Namespace helper_drone
// Params 2
// Checksum 0x4273dd2b, Offset: 0x20e6
// Size: 0x15f, Type: bool
function tryusehelperdroneearlyout( streakinfo, showerror )
{
    if ( utility::isusingremote() )
    {
        return true;
    }
    
    if ( self.drones_disabled )
    {
        if ( showerror )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/unavailable" );
            }
        }
        
        return true;
    }
    
    if ( killstreak::function_17736ca3e3ad4382( streakinfo.streakname ) )
    {
        candeploydrone = !isdefined( killstreakdeploy::candeploykillstreakweapon( streakinfo ) );
        
        if ( !candeploydrone && showerror )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"MP/CANNOT_USE_GENERIC" );
            }
            
            return true;
        }
    }
    
    var_5348e955fb6f2aa5 = function_82d83598f8412a9d( streakinfo, showerror );
    
    if ( !var_5348e955fb6f2aa5 )
    {
        return true;
    }
    
    var_ae9e5bcd4df7ca7 = function_522905ceb07e70e0( streakinfo, showerror );
    
    if ( !var_ae9e5bcd4df7ca7 )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]( 1 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace helper_drone
// Params 0
// Checksum 0x990893fa, Offset: 0x224e
// Size: 0x1d
function delay_deletescriptable()
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 2 );
    self delete();
}

// Namespace helper_drone
// Params 7
// Checksum 0xed9ea2e8, Offset: 0x2273
// Size: 0x85b
function createhelperdrone( startpos, startang, helperdronetype, streakinfo, nonvehicle, vehiclereserved, startingvelocity )
{
    clearvehiclereservation = !nonvehicle && vehiclereserved;
    
    if ( !isdefined( startpos ) )
    {
        if ( !clearvehiclereservation )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
        }
        
        return;
    }
    
    config = level.helperdronesettings[ helperdronetype ];
    dronemodel = config.modelbase;
    drone = undefined;
    
    if ( nonvehicle )
    {
        drone = spawn( "script_model", startpos );
        drone setmodel( dronemodel );
        drone.nonvehicle = 1;
    }
    else
    {
        if ( clearvehiclereservation )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
        }
        
        if ( config.var_17e473e12ced7138 )
        {
            if ( !isdefined( startingvelocity ) )
            {
                startingvelocity = ( 0, 0, 0 );
            }
            
            spawndata = spawnstruct();
            spawndata.origin = startpos;
            spawndata.angles = startang;
            spawndata.modelname = dronemodel;
            spawndata.targetname = config.targetname;
            spawndata.vehicletype = config.vehicleinfo ?? streakinfo.var_27b09523e68cae9e;
            spawndata.owner = self;
            
            if ( isdefined( self.isagent ) && helperdronetype == "sweeper_drone" )
            {
                spawndata.owner = undefined;
            }
            
            spawndata.initialvelocity = startingvelocity;
            drone = vehicle_tracking::spawn_vehicle( spawndata );
        }
        else
        {
            drone = vehicle_tracking::spawn_helicopter( self, startpos, startang, config.vehicleinfo, dronemodel );
        }
        
        /#
            var_be458bc45c02fda5 = getdvarint( @"hash_b23e7bb60bbe76a6", 0 );
            
            if ( var_be458bc45c02fda5 )
            {
                drone setscriptablepartstate( "<dev string:x5b>", "<dev string:x65>", 0 );
            }
        #/
    }
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    drone setnodeploy( 1 );
    drone.health = config.maxhealth;
    drone.maxhealth = config.maxhealth;
    drone.currenthealth = config.maxhealth;
    drone.damagetaken = 0;
    drone.speed = config.speed;
    drone.accel = config.accel;
    drone.angles = startang;
    drone.manualspeed = 50;
    drone.owner = self;
    
    if ( !config.autonomous )
    {
        drone.owner.vehicle = drone;
        
        if ( isdefined( self.isagent ) && helperdronetype == "sweeper_drone" )
        {
            drone.owner.vehicle = undefined;
        }
    }
    
    drone.team = self.team;
    drone.teamfriendlyto = self.team;
    drone.helperdronetype = helperdronetype;
    drone.combatmode = config.primarymode;
    drone.currentstring = config.secondarymodestring;
    drone.streakinfo = streakinfo;
    drone.camerastate = "default";
    drone.var_eaf7aed3b097c78d = config.var_eaf7aed3b097c78d;
    drone.timeout = config.timeout;
    drone.isdrone = 1;
    drone function_a4ebfb83ec0621b9( &helperdrone_handledeathdamage );
    
    if ( drone function_1b1775de1150c960() )
    {
        drone thread function_c4d6a9b7b4fefdcf( 0.1 );
    }
    
    if ( level.killstreak_emp_initialized )
    {
        drone.ksempapplycallback = &helperdrone_empapplied;
    }
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"attachxrays" ) )
    {
        drone = [[ utility::getsharedfunc( #"helper_drone", #"attachxrays" ) ]]( drone );
    }
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            drone.timeout = 9999;
        }
    #/
    
    delaysentient = 0;
    
    if ( drone.nonvehicle )
    {
        drone sentientpoolmanager::registersentient( "Tactical_Moving", self, undefined, undefined, 0, 1 );
    }
    else
    {
        delaysentient = 1;
        drone thread function_6f2358c8c3908626();
        drone setvehicleteam( drone.team );
    }
    
    drone enableaimassist();
    
    if ( drone.var_eaf7aed3b097c78d )
    {
        weapon_utility::setlockedoncallback( drone, &helperdrone_lockedoncallback );
        weapon_utility::setlockedonremovedcallback( drone, &helperdrone_lockedonremovedcallback );
    }
    
    drone helperdrone_setupdamagefunctionality( helperdronetype );
    
    if ( isdefined( config.flarescount ) )
    {
        drone.flaresreservecount = config.flarescount;
    }
    
    drone setotherent( self );
    drone setcandamage( 1 );
    
    if ( nonvehicle )
    {
        drone scriptmoveroutline();
        drone scriptmoverthermal();
    }
    
    iconoffset = 12;
    
    switch ( helperdronetype )
    {
        case #"hash_f64c697bfb4c6b54":
            iconoffset = 60;
            break;
        case #"hash_e10937962ef20946":
            scrambler = drone helperdrone_spawnnewscrambler( "medium" );
            drone.scrambler = scrambler;
            drone.uavtype = "counter_uav";
            break;
        case #"hash_27002778019fb447":
            if ( level.makedroneguardscrambler )
            {
                scrambler = drone helperdrone_spawnnewscrambler( "large" );
                drone.scrambler = scrambler;
            }
            
            drone.uavtype = "counter_uav";
            iconoffset = 100;
            break;
        default:
            break;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) && isdefined( streakinfo ) )
    {
        drone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", drone.owner, 0, 1, iconoffset );
    }
    
    drone.attract_strength = 10000;
    drone.attract_range = 150;
    drone.attractor = missile_createattractorent( drone, drone.attract_strength, drone.attract_range );
    drone.stunned = 0;
    drone.inactive = 0;
    drone thread helperdrone_play_lightfx();
    data = spawnstruct();
    data.validateaccuratetouching = 1;
    data.deathoverridecallback = &helperdrone_moving_platform_death;
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        drone [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
    
    if ( isdefined( level.helperdronesettings[ drone.helperdronetype ].streakname ) )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
        {
            drone.owner [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( config.streakname, drone.targetpos );
        }
    }
    
    thread function_83688e382cb7897c( delaysentient, drone );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( drone );
        }
    }
    
    return drone;
}

// Namespace helper_drone
// Params 1
// Checksum 0x433890ef, Offset: 0x2ad7
// Size: 0x2f
function function_7d135d70a58856f6( func )
{
    level.helperdronesettings[ "shouldIgnoreImmediateDamage" ][ level.helperdronesettings[ "shouldIgnoreImmediateDamage" ].size ] = func;
}

// Namespace helper_drone
// Params 0
// Checksum 0xf5a1d241, Offset: 0x2b0e
// Size: 0x84, Type: bool
function function_1b1775de1150c960()
{
    foreach ( func in level.helperdronesettings[ "shouldIgnoreImmediateDamage" ] )
    {
        if ( self [[ func ]]() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace helper_drone
// Params 1
// Checksum 0x50bddd09, Offset: 0x2b9b
// Size: 0x27
function function_c4d6a9b7b4fefdcf( time )
{
    self.nullownerdamagefunc = &function_bacdcbcaec50c821;
    wait time;
    self.nullownerdamagefunc = undefined;
}

// Namespace helper_drone
// Params 1
// Checksum 0x2f208572, Offset: 0x2bca
// Size: 0xe, Type: bool
function function_bacdcbcaec50c821( attacker )
{
    return true;
}

// Namespace helper_drone
// Params 0
// Checksum 0x9f02cf5e, Offset: 0x2be1
// Size: 0x50
function function_6f2358c8c3908626()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    
    if ( function_c61ef62c5ef9987b() )
    {
        return;
    }
    
    wait 5;
    sentientpoolmanager::registersentient( "Drone", self.owner );
    self notify( #"registered_sentient" );
}

// Namespace helper_drone
// Params 0
// Checksum 0x249e8576, Offset: 0x2c39
// Size: 0x54
function function_c61ef62c5ef9987b()
{
    switch ( self.helperdronetype )
    {
        case #"hash_819b6aff4e34ea29":
        case #"hash_8ef5b52c9e784884":
        case #"hash_b73c57d747ce4083":
        case #"hash_e40585107590f016":
            return 1;
        default:
            return 0;
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x5451f23b, Offset: 0x2c95
// Size: 0x49
function function_83688e382cb7897c( delaysentient, drone )
{
    drone endon( #"death" );
    self endon( #"disconnect" );
    
    if ( delaysentient )
    {
        drone waittill( #"registered_sentient" );
    }
    
    self setplayerusingdrone( drone );
}

// Namespace helper_drone
// Params 6
// Checksum 0x8cf0722d, Offset: 0x2ce6
// Size: 0x39e
function drophelperdrone( startpos, startang, helperdronetype, streakinfo, dronevel, dronehealth )
{
    config = level.helperdronesettings[ helperdronetype ];
    
    if ( getdvarint( @"scr_helperdrone_reusable", 0 ) && isdefined( config.var_369a390f2a90bd71 ) )
    {
        dronemodel = config.var_369a390f2a90bd71;
    }
    else
    {
        dronemodel = config.modelbase;
    }
    
    drone = undefined;
    drone = spawn( "script_model", startpos );
    drone setmodel( dronemodel );
    drone.nonvehicle = 0;
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    drone setnodeploy( 1 );
    drone.health = config.maxhealth;
    drone.maxhealth = config.maxhealth;
    drone.currenthealth = dronehealth;
    drone.ispiloted = 0;
    drone.damagetaken = config.maxhealth - dronehealth;
    drone.angles = startang;
    drone.owner = self;
    drone.team = self.team;
    drone.helperdronetype = helperdronetype;
    drone.combatmode = config.primarymode;
    drone.currentstring = config.secondarymodestring;
    drone.streakinfo = streakinfo;
    drone.camerastate = "default";
    drone.var_eaf7aed3b097c78d = 0;
    drone.timeout = config.timeout;
    drone.dropped = 1;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            drone.timeout = 9999;
        }
    #/
    
    drone sentientpoolmanager::registersentient( "Tactical_Moving", self, undefined, undefined, 0, 1 );
    drone function_5cf532639f300426();
    
    if ( isdefined( config.damagemonitorfunc ) )
    {
        drone thread [[ config.damagemonitorfunc ]]( 1 );
    }
    
    if ( isdefined( config.flarescount ) )
    {
        drone.flaresreservecount = config.flarescount;
    }
    
    drone setotherent( self );
    drone setcandamage( 1 );
    drone scriptmoveroutline();
    drone scriptmoverthermal();
    drone.stunned = 0;
    drone.inactive = 1;
    data = spawnstruct();
    data.validateaccuratetouching = 1;
    data.deathoverridecallback = &helperdrone_moving_platform_death;
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        drone [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
    
    if ( isdefined( dronevel ) )
    {
        drone physics_takecontrol( 1, drone.origin, dronevel * 25 );
    }
    else
    {
        drone physics_takecontrol( 1 );
    }
    
    drone makeusable();
    drone sethintstring( &"mp/br_recondrone" );
    drone sethintdisplayfov( 90 );
    drone setuseholdduration( "duration_none" );
    drone setusefov( 90 );
    drone thread function_86385ba0dbb6f35c( streakinfo.superref );
    return drone;
}

// Namespace helper_drone
// Params 1
// Checksum 0xe7df40a5, Offset: 0x308d
// Size: 0xd7
function function_86385ba0dbb6f35c( superref )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"pickup" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isalive( player ) )
        {
            if ( utility::issharedfuncdefined( #"player", #"forcegivesuper" ) )
            {
                player [[ utility::getsharedfunc( #"player", #"forcegivesuper" ) ]]( superref, 1, 0 );
            }
            
            if ( utility::issharedfuncdefined( #"player", #"playpickupfeedback" ) )
            {
                player [[ utility::getsharedfunc( #"player", #"playpickupfeedback" ) ]]( self, 0 );
            }
            
            self delete();
            return;
        }
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x8df50922, Offset: 0x316c
// Size: 0xe0
function helperdrone_notifyenemyplayersinrange( helperdronetype )
{
    enemyplayersinrange = utility::playersincylinder( self.origin, 3000, undefined, undefined, self.team );
    
    foreach ( enemyplayer in enemyplayersinrange )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"dangernotifyplayer" ) )
        {
            self.owner [[ utility::getsharedfunc( #"killstreak", #"dangernotifyplayer" ) ]]( enemyplayer, helperdronetype, 1 );
        }
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xb51cfe53, Offset: 0x3254
// Size: 0xce
function helperdrone_handleteamvisibility()
{
    foreach ( player in level.players )
    {
        if ( level.teambased && player.team == self.team || !level.teambased && player == self.owner )
        {
            self hidefromplayer( player );
        }
    }
    
    thread helperdrone_managevisibilityonteamjoin();
    
    /#
        thread function_3630f494c1a974c5();
    #/
}

// Namespace helper_drone
// Params 0
// Checksum 0xbbf5b3e6, Offset: 0x332a
// Size: 0x8b
function helperdrone_managevisibilityonteamjoin()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    
    while ( true )
    {
        level waittill( #"joined_team", player );
        
        if ( level.teambased && player.team == self.team )
        {
            self hidefromplayer( player );
            continue;
        }
        
        self showtoplayer( player );
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0xc36b6e70, Offset: 0x33bd
// Size: 0x189
function helperdrone_setupdamagefunctionality( streakname )
{
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( !self.nonvehicle )
    {
        killstreakvehicle = self;
        scorepopup = config.scorepopup;
        vodestroyed = config.vodestroyed;
        destroyedsplash = config.destroyedsplash;
        var_c96bcef6709d6df1 = config.var_a2bdd1c0e927f10e;
        var_d188942a41771ea1 = config.var_b36fa7b97a3225fe;
        premoddamagecallback = config.premoddamagefunc;
        postmoddamagecallback = config.postmoddamagefunc;
        deathcallback = config.deathfunc;
        killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
        vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    }
    
    killstreak_utility::function_b555369eba6b0252( 1, self.maxhealth * 0.75, &function_1a1af8effb6318e7 );
    killstreak_utility::function_b555369eba6b0252( 2, self.maxhealth * 0.5, &function_34219a3628f1d9b0 );
    killstreak_utility::function_b555369eba6b0252( 3, self.maxhealth * 0.25, &function_db443e2033acaf2e );
    self.var_514172427acb20c1 = &function_eae195e2ce74cd37;
}

// Namespace helper_drone
// Params 2
// Checksum 0x688a2946, Offset: 0x354e
// Size: 0x3e
function function_eae195e2ce74cd37( dronevictim, impulse )
{
    if ( !isdefined( dronevictim ) )
    {
        return;
    }
    
    if ( impulse > 0 )
    {
        if ( dronevictim.isdestroyed )
        {
            return;
        }
        
        dronevictim thread helperdrone_explode( 1 );
    }
}

/#

    // Namespace helper_drone
    // Params 0
    // Checksum 0x5a6e27ba, Offset: 0x3594
    // Size: 0x233, Type: dev
    function function_3630f494c1a974c5()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"explode" );
        self endon( #"drop" );
        self.togglevisibility = 0;
        
        while ( true )
        {
            togglevisibility = getdvarint( @"scr_helperdrone_visibility", 0 );
            
            if ( self.helperdronetype == "<dev string:x68>" )
            {
                togglevisibility = getdvarint( @"hash_ac7f6a636682c52f", 0 );
            }
            
            if ( togglevisibility )
            {
                if ( !self.togglevisibility )
                {
                    self.togglevisibility = 1;
                    
                    foreach ( player in level.players )
                    {
                        if ( player.team == self.team )
                        {
                            self showtoplayer( player );
                            
                            if ( self.helperdronetype == "<dev string:x68>" )
                            {
                                self.owner.var_640ea62fa70ae194 = 1;
                                level notify( #"uav_update" );
                            }
                        }
                    }
                }
            }
            else if ( self.togglevisibility )
            {
                self.togglevisibility = 0;
                
                foreach ( player in level.players )
                {
                    if ( player.team == self.team )
                    {
                        self hidefromplayer( player );
                        
                        if ( self.helperdronetype == "<dev string:x68>" )
                        {
                            self.owner.var_640ea62fa70ae194 = undefined;
                            level notify( #"uav_update" );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace helper_drone
// Params 1
// Checksum 0xcd95a9b5, Offset: 0x37cf
// Size: 0xc6
function helperdrone_enableradar( radartype )
{
    radar = spawn( "script_model", self.origin );
    radar.owner = self.owner;
    radar.team = self.owner.team;
    self.radar = radar;
    
    if ( radartype == "auto_radar" )
    {
        radar makeportableradar( self.owner );
    }
    else if ( radartype == "escort_radar" )
    {
        radar setentityowner( self.owner );
        radar setotherent( self.owner );
        radar setmodel( "ks_radar_drone_escort_mp" );
    }
    
    radar linkto( self );
}

// Namespace helper_drone
// Params 0
// Checksum 0x7a86333b, Offset: 0x389d
// Size: 0x1d
function helperdrone_disableradar()
{
    if ( isdefined( self.radar ) )
    {
        self.radar delete();
    }
}

// Namespace helper_drone
// Params 3
// Checksum 0xf060445d, Offset: 0x38c2
// Size: 0xce
function helperdrone_spawnnewscrambler( scramblersize, spawnoverridepos, link )
{
    scrambler = spawn( "script_model", self.origin );
    scrambler.team = self.owner.team;
    
    if ( isdefined( self.streakinfo ) && isdefined( self.streakinfo.abilityrange ) )
    {
        scrambleradius = int( self.streakinfo.abilityrange );
    }
    else
    {
        scrambleradius = 0;
    }
    
    scrambler makescrambler( self.owner, scramblersize, scrambleradius );
    function_b7a26b47bd7435ed( scrambler, scramblersize, scrambleradius );
    scrambler linkto( self );
    return scrambler;
}

// Namespace helper_drone
// Params 3
// Checksum 0xe3f1a428, Offset: 0x3999
// Size: 0xb0
function function_b7a26b47bd7435ed( scrambler, scramblersize, scrambleradius )
{
    if ( scrambleradius == 0 )
    {
        switch ( scramblersize )
        {
            case #"hash_4bf33d595d8f4894":
                scrambleradius = getdvarfloat( @"scramblerjamdistlarge", 1000 );
                break;
            case #"hash_c71b112fe04823d6":
                scrambleradius = getdvarfloat( @"scramblerjamdistmedium", 500 );
                break;
            case #"hash_a8bcbd0fa8b39221":
                scrambleradius = getdvarfloat( @"scramblerjamdistlittle", 250 );
                break;
            default:
                break;
        }
    }
    
    scrambler.var_d1db0034a30c9a5b = scrambleradius * scrambleradius;
}

// Namespace helper_drone
// Params 0
// Checksum 0x55042cbc, Offset: 0x3a51
// Size: 0xf5, Type: bool
function function_11513d6fb722aba8()
{
    if ( !isdefined( level.supportdrones ) )
    {
        return false;
    }
    
    foreach ( drone in level.supportdrones )
    {
        if ( isdefined( drone.scrambler.var_d1db0034a30c9a5b ) && drone.team == self.team )
        {
            distsq = distance2dsquared( self.origin, drone.origin );
            
            if ( distsq <= drone.scrambler.var_d1db0034a30c9a5b )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace helper_drone
// Params 1
// Checksum 0x45675a92, Offset: 0x3b4f
// Size: 0x4b
function helperdrone_moving_platform_death( data )
{
    if ( !isdefined( data.lasttouchedplatform.destroydroneoncollision ) || data.lasttouchedplatform.destroydroneoncollision )
    {
        self notify( #"death" );
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0x4fc932a3, Offset: 0x3ba2
// Size: 0x47
function helperdrone_play_lightfx()
{
    settings = level.helperdronesettings[ self.helperdronetype ];
    
    if ( isent( self ) )
    {
        if ( isdefined( settings.playfxcallback ) )
        {
            self [[ settings.playfxcallback ]]();
        }
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0x92152277, Offset: 0x3bf1
// Size: 0x8d
function helperdrone_playfx()
{
    self setscriptablepartstate( "lights", "on", 0 );
    
    if ( self.helperdronetype == "radar_drone_overwatch" )
    {
        self setscriptablepartstate( "glint", "on", 0 );
        self setscriptablepartstate( "engine", "on", 0 );
    }
    
    if ( killstreak::function_17736ca3e3ad4382( self.helperdronetype ) )
    {
        self setscriptablepartstate( "glint", "on", 0 );
    }
    
    if ( self.helperdronetype == "ammo_drop" )
    {
        self setscriptablepartstate( "glint", "on", 0 );
    }
}

// Namespace helper_drone
// Params 3
// Checksum 0x43c0b55, Offset: 0x3c86
// Size: 0x27a
function starthelperdrone( helperdrone, var_f3fe9e563beed5fd, var_553979a9fc7f365f )
{
    level endon( #"game_ended" );
    helperdrone endon( #"death" );
    
    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_8d28ad2c7f7f7cac" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_8d28ad2c7f7f7cac" ) ]]( helperdrone );
    }
    
    config = level.helperdronesettings[ helperdrone.helperdronetype ];
    
    if ( isplayer( self ) )
    {
        helperdrone thread function_eca8c9b5b3045fd0();
        helperdrone.owner setclientomnvar( "ui_killstreak_health", helperdrone.currenthealth / helperdrone.maxhealth );
        helperdrone.owner setclientomnvar( "ui_killstreak_damage_state", 0 );
    }
    
    helperdrone thread helperdrone_watchtimeout();
    helperdrone thread helperdrone_watchownerloss();
    helperdrone thread helperdrone_watchownerdeath();
    helperdrone thread helperdrone_watchroundend();
    helperdrone thread helperdrone_destroyongameend();
    helperdrone setcandamage( 1 );
    
    if ( isdefined( config.damagemonitorfunc ) )
    {
        helperdrone thread [[ config.damagemonitorfunc ]]();
    }
    
    if ( function_cdb02c8d3e1593c0( helperdrone.helperdronetype ) )
    {
        helperdrone thread helperdrone_monitorcollision( config );
        helperdrone thread function_7cb035830b2e9992( config );
        helperdrone thread helperdrone_watchearlyexit( config, var_f3fe9e563beed5fd );
        helperdrone thread function_ed68d7d7e9cb1bcb();
        isthermalenabled = getdvarint( @"hash_fbbf89bc8f18c20", 1 );
        
        if ( isthermalenabled == 1 )
        {
            helperdrone thread function_40cebb67a434bc6b();
        }
        
        if ( isbrgamemode() )
        {
            helperdrone thread helperdrone_watchaltitude( self );
        }
        
        if ( utility::issharedfuncdefined( #"game", #"registerentforoob" ) )
        {
            [[ utility::getsharedfunc( #"game", #"registerentforoob" ) ]]( helperdrone, "killstreak" );
        }
        
        if ( utility::issharedfuncdefined( #"game", #"hash_dff576ba1496baa4" ) )
        {
            var_553979a9fc7f365f = [[ utility::getsharedfunc( #"game", #"hash_dff576ba1496baa4" ) ]]();
        }
        
        if ( !var_553979a9fc7f365f )
        {
            helperdrone thread function_ac97a26ccd31c134();
        }
    }
    
    helperdrone thread [[ config.primarymodefunc ]]( config );
}

// Namespace helper_drone
// Params 1
// Checksum 0x687e4e15, Offset: 0x3f08
// Size: 0x103
function helperdrone_followplayer( offsetoverride )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"target_assist" );
    self endon( #"player_defend" );
    
    if ( !isdefined( self.owner ) )
    {
        thread helperdrone_leave();
        return;
    }
    
    self.owner endon( #"disconnect" );
    self endon( #"owner_gone" );
    
    while ( true )
    {
        currentstance = self.owner getstance();
        
        if ( !isdefined( self.last_owner_stance ) || currentstance != self.last_owner_stance || self.stoppedatlocation )
        {
            if ( self.stoppedatlocation )
            {
                self.stoppedatlocation = undefined;
            }
            
            self.last_owner_stance = currentstance;
            helperdrone_movetoplayer( self.owner, offsetoverride );
        }
        
        wait 0.5;
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xc5cc1101, Offset: 0x4013
// Size: 0x1ec
function helperdrone_overwatchplayer()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    self.owner player::showminimap();
    self.owner.showuavminimaponspawn = 1;
    self.owner thread helperdrone_showminimaponspawn( self );
    introspeed = 1;
    self vehicle_setspeed( 200, 50, 10 );
    
    while ( true )
    {
        obstructiontrace = undefined;
        
        if ( introspeed )
        {
            currentpos = self.origin;
            initialgoalpos = self.owner.origin * ( 1, 1, 0 ) + ( 0, 0, self.origin[ 2 ] );
            obstructiontrace = trace::ray_trace( currentpos, initialgoalpos, self );
        }
        
        xpos = self.owner.origin[ 0 ];
        ypos = self.owner.origin[ 1 ];
        
        if ( isdefined( obstructiontrace ) )
        {
            if ( obstructiontrace[ "hittype" ] != "hittype_none" )
            {
                xpos = obstructiontrace[ "position" ][ 0 ];
                ypos = obstructiontrace[ "position" ][ 1 ];
            }
        }
        
        properz = getcorrectheight( xpos, ypos, 20 );
        newgoal = ( xpos, ypos, properz );
        self setlookatent( self.owner );
        self setvehgoalpos( newgoal, 1 );
        utility::waittill_any( "goal", "begin_evasive_maneuvers" );
        
        if ( introspeed )
        {
            introspeed = undefined;
            self vehicle_setspeed( level.helperdronesettings[ self.helperdronetype ].speed, 10, 10 );
        }
        
        self clearlookatent();
        hostmigration::waitlongdurationwithpause( 0.1 );
    }
}

// Namespace helper_drone
// Params 3
// Checksum 0xe4adaca0, Offset: 0x4207
// Size: 0x7c
function getcorrectheight( x, y, rand )
{
    offgroundheight = 1500;
    
    /#
        var_a2424d1ee2ad6059 = getdvarint( @"hash_166b0ad3d56b43f", 0 );
        offgroundheight += var_a2424d1ee2ad6059;
    #/
    
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace helper_drone
// Params 2
// Checksum 0xd9877098, Offset: 0x428c
// Size: 0xca
function tracegroundpoint( x, y )
{
    self endon( #"death" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = level.averagealliesz;
    ignorelist = [ self ];
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 256, ignorelist, undefined, 1 );
    
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

// Namespace helper_drone
// Params 0
// Checksum 0xba2d9d46, Offset: 0x435f
// Size: 0x1a6
function helperdrone_pingnearbyenemies()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    pingsize = 300;
    radarrange = 1200;
    
    if ( game_utility::islargemap() )
    {
        pingsize = 1000;
        radarrange = 2500;
    }
    
    self.pingedenemies = [];
    
    while ( true )
    {
        nearplayers = utility::playersinsphere( self.owner.origin, radarrange );
        
        foreach ( player in nearplayers )
        {
            if ( player == self.owner )
            {
                continue;
            }
            
            if ( level.teambased && player.team == self.owner.team )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player helperdrone_isbeingpingedbydrone( self ) )
            {
                continue;
            }
            
            if ( isdefined( player.perks[ "specialty_ghost" ] ) )
            {
                continue;
            }
            
            triggerportableradarping( player.origin, self.owner, pingsize, 3000 );
            thread helperdrone_watchpingedstatus( player, self.owner );
        }
        
        waitframe();
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x3268dd5b, Offset: 0x450d
// Size: 0x8d
function helperdrone_watchpingedstatus( pingedtarget, helperdroneowner )
{
    self endon( #"death" );
    pingedtarget endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( helperdroneowner ) )
    {
        pingedtarget playsoundtoplayer( "recondrone_marker", helperdroneowner );
    }
    
    self.pingedenemies[ self.pingedenemies.size ] = pingedtarget;
    pingedtarget utility::waittill_any_timeout( 3, "death" );
    self.pingedenemies = arrayremove( self.pingedenemies, pingedtarget );
}

// Namespace helper_drone
// Params 1
// Checksum 0x80430d93, Offset: 0x45a2
// Size: 0x99
function helperdrone_isbeingpingedbydrone( drone )
{
    ispinged = 0;
    
    foreach ( enemy in drone.pingedenemies )
    {
        if ( self == enemy )
        {
            ispinged = 1;
            break;
        }
    }
    
    return ispinged;
}

// Namespace helper_drone
// Params 1
// Checksum 0x7266c4f0, Offset: 0x4644
// Size: 0x9a
function helperdrone_getheightoffset( config )
{
    heightoffset = config.standupoffset;
    owner_stance = self.owner getstance();
    
    switch ( owner_stance )
    {
        case #"hash_c6775c88e38f7803":
            heightoffset = config.standupoffset;
            break;
        case #"hash_3fed0cbd303639eb":
            heightoffset = config.crouchupoffset;
            break;
        case #"hash_d91940431ed7c605":
            heightoffset = config.proneupoffset;
            break;
    }
    
    return heightoffset;
}

// Namespace helper_drone
// Params 0
// Checksum 0x4d6507b1, Offset: 0x46e7
// Size: 0x63
function helperdrone_watchradarpulse()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    
    while ( true )
    {
        triggerportableradarping( self.origin, self.owner );
        self.owner playsound( "oracle_radar_pulse_npc" );
        wait 3;
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x37cf953, Offset: 0x4752
// Size: 0x5b
function helperdrone_movetoplayer( player, offsetoverride )
{
    self setlookatent( player );
    targetoffset = helperdrone_gettargetoffset( self, player );
    
    if ( isdefined( offsetoverride ) )
    {
        targetoffset = offsetoverride;
    }
    
    self setdronegoalent( player, targetoffset, 16, 10 );
    self.intransit = 1;
    thread helperdrone_watchforgoal();
}

// Namespace helper_drone
// Params 0
// Checksum 0x47aea387, Offset: 0x47b5
// Size: 0x30f
function helperdrone_watchmodeswitch()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    self endon( #"owner_gone" );
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( utility::issharedfuncdefined( #"killstreak", #"setkillstreakcontrolpriority" ) )
    {
        self.useobj [[ utility::getsharedfunc( #"killstreak", #"setkillstreakcontrolpriority" ) ]]( self.owner, self.currentstring, 360, 360, 30000, 30000, 3 );
    }
    
    while ( true )
    {
        self.useobj waittill( #"trigger", player );
        
        if ( player != self.owner )
        {
            continue;
        }
        
        if ( self.owner utility::isusingremote() )
        {
            continue;
        }
        
        if ( !self.owner val::get( "usability" ) )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"entity", #"istouchingboundstrigger" ) )
        {
            if ( [[ utility::getsharedfunc( #"entity", #"istouchingboundstrigger" ) ]]( self.owner ) )
            {
                continue;
            }
        }
        
        timeused = 0;
        result = undefined;
        updaterate = level.framedurationseconds;
        
        while ( self.owner usebuttonpressed() )
        {
            timeused += updaterate;
            
            if ( timeused > 0.1 )
            {
                self notify( #"switch_modes" );
                newmode = getothermode( self.combatmode, self.streakinfo );
                newstring = "Empty String";
                assert( isdefined( config.primarymode ) && isdefined( config.secondarymode ), "<dev string:x7e>" );
                
                if ( newmode == config.primarymode )
                {
                    result = [[ config.primarymodefunc ]]( config );
                    newstring = config.secondarymodestring;
                }
                else
                {
                    result = [[ config.secondarymodefunc ]]( config );
                    newstring = config.primarymodestring;
                }
                
                if ( !result )
                {
                    return;
                }
                
                self.combatmode = newmode;
                self.currentstring = newstring;
                self.useobj makeunusable();
                hostmigration::waitlongdurationwithpause( 1 );
                
                if ( utility::issharedfuncdefined( #"killstreak", #"setkillstreakcontrolpriority" ) )
                {
                    self.useobj [[ utility::getsharedfunc( #"killstreak", #"setkillstreakcontrolpriority" ) ]]( self.owner, self.currentstring, 360, 360, 30000, 30000, 3 );
                }
                
                break;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0xa8abb189, Offset: 0x4acc
// Size: 0x64
function getothermode( mode, streakinfo )
{
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( mode == config.primarymode )
    {
        mode = config.secondarymode;
    }
    else
    {
        mode = config.primarymode;
    }
    
    return mode;
}

// Namespace helper_drone
// Params 1
// Checksum 0x5d1aa9e, Offset: 0x4b39
// Size: 0x91, Type: bool
function setescortmodesettings( config )
{
    self vehicle_setspeed( self.speed, self.accel );
    self setyawspeed( 120, 90 );
    self setneargoalnotifydist( 16 );
    self sethoverparams( 30, 10, 5 );
    self setturningability( 1 );
    self setdroneturnparams( 50, 1.3, 30, 20 );
    self.owner player::showminimap();
    self.owner thread helperdrone_showminimaponspawn( self );
    helperdrone_enableradar( "escort_radar" );
    thread helperdrone_followplayer();
    return true;
}

// Namespace helper_drone
// Params 0
// Checksum 0x91bd1d04, Offset: 0x4bd3
// Size: 0x130
function function_eca8c9b5b3045fd0()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    config = level.helperdronesettings[ self.helperdronetype ];
    timeoutduration = self.timeout;
    timeelapsed = 0;
    
    if ( !isdefined( self.timeout ) )
    {
        return;
    }
    
    if ( config.var_c9532252f020d459 )
    {
        var_69fb75ce43100ed0 = [];
        var_69fb75ce43100ed0[ "leaving" ] = self;
        level thread killstreak_utility::killstreak_watchlifetime( self, timeoutduration, 1, var_69fb75ce43100ed0 );
        return;
    }
    
    self.owner setclientomnvar( "ui_killstreak_countdown", 100 );
    
    while ( timeelapsed < timeoutduration )
    {
        timepercent = ( timeoutduration - timeelapsed ) / timeoutduration;
        timepercent = int( ceil( clamp( timepercent, 0, 1 ) * 100 ) );
        
        if ( self.ispiloted )
        {
            self.owner setclientomnvar( "ui_killstreak_countdown", timepercent );
        }
        
        timeelapsed += level.framedurationseconds;
        waitframe();
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xf2b16a0b, Offset: 0x4d0b
// Size: 0x1c
function helperdrone_lockedoncallback()
{
    vehicle_omnvar::show_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace helper_drone
// Params 0
// Checksum 0x57c3d78e, Offset: 0x4d2f
// Size: 0x1c
function helperdrone_lockedonremovedcallback()
{
    vehicle_omnvar::hide_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace helper_drone
// Params 1
// Checksum 0x582861b0, Offset: 0x4d53
// Size: 0x23, Type: bool
function setoverwatchmodesettings( config )
{
    thread helperdrone_overwatchplayer();
    thread helperdrone_pingnearbyenemies();
    helperdrone_handleteamvisibility();
    return true;
}

// Namespace helper_drone
// Params 1
// Checksum 0x15ab4c97, Offset: 0x4d7f
// Size: 0x17, Type: bool
function setdeliverymodesettings( config )
{
    thread helperdrone_deliver( config );
    return true;
}

// Namespace helper_drone
// Params 1
// Checksum 0xadba51e3, Offset: 0x4d9f
// Size: 0x1fc
function helperdrone_deliver( config )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    self setneargoalnotifydist( 10 );
    speed = level.helperdronesettings[ self.helperdronetype ].speed;
    accel = level.helperdronesettings[ self.helperdronetype ].accel;
    self vehicle_setspeed( speed, accel, accel );
    abovepos = self.deliverytarget + ( 0, 0, 4000 );
    startpos = self.deliverytarget + ( 0, 0, 2500 );
    endpos = self.deliverytarget + ( 0, 0, 100 );
    halfsize = level.helperdronesettings[ self.helperdronetype ].halfsize;
    ignoreents = [];
    ignoreents[ 0 ] = self;
    contentoverride = trace::create_contents( 1, 1, 1, 1 );
    traceresult = trace::sphere_trace( startpos, endpos, halfsize, ignoreents, contentoverride, 0 );
    droppos = traceresult[ "shape_position" ] + ( 0, 0, 100 );
    self setvehgoalpos( droppos, 1 );
    self waittill( #"goal" );
    wait 0.5;
    [[ self.ondelivercallback ]]();
    self vehicle_setspeedimmediate( 2 );
    self vehicle_setspeed( 0.1, 1, 1 );
    wait 0.5;
    self vehicle_setspeed( speed, accel, accel );
    self setvehgoalpos( abovepos, 0 );
    self waittill( #"goal" );
    helperdrone_remove( self.helperdronetype, config, 0 );
}

// Namespace helper_drone
// Params 2
// Checksum 0x3a8bd99a, Offset: 0x4fa3
// Size: 0xd8
function helperdrone_watchearlyexit( config, var_f3fe9e563beed5fd )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"explode" );
    
    while ( true )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"allowridekillstreakplayerexit" ) )
        {
            self thread [[ utility::getsharedfunc( #"killstreak", #"allowridekillstreakplayerexit" ) ]]( "leaving", var_f3fe9e563beed5fd );
        }
        
        self waittill( #"killstreakexit" );
        
        if ( !self.ispiloted )
        {
            continue;
        }
        
        if ( isdefined( config.exitfunc ) )
        {
            self notify( #"drone_exit" );
            self [[ config.exitfunc ]]();
            continue;
        }
        
        helperdrone_leave();
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x9744aad3, Offset: 0x5083
// Size: 0x7e
function function_ed68d7d7e9cb1bcb( config )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "drone_exit", "explode", "death" );
        
        if ( isdefined( self.owner ) )
        {
            if ( !config.autonomous )
            {
                self.owner.vehicle = undefined;
            }
        }
        
        if ( msg != "drone_exit" )
        {
            break;
        }
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xd556eeec, Offset: 0x5109
// Size: 0x75
function function_40cebb67a434bc6b()
{
    level endon( #"game_ended" );
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    var_fa0ab78da8e0f789 = 1;
    
    /#
        cammode = getdvarint( @"hash_b23e7bb60bbe76a6", 0 );
        
        if ( cammode )
        {
            var_fa0ab78da8e0f789 = 0;
        }
    #/
    
    if ( var_fa0ab78da8e0f789 )
    {
        droneowner function_98cd33662c8f413d( self );
    }
    
    thread helperdrone_handlethermalswitchinternal();
}

// Namespace helper_drone
// Params 0
// Checksum 0xfebaaed7, Offset: 0x5186
// Size: 0x179
function helperdrone_handlethermalswitchinternal()
{
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    self.isthermalenabled = 0;
    droneconfig = level.helperdronesettings[ self.helperdronetype ];
    thermalvisionset = killstreak_utility::function_2c6a2b2cb28d923a();
    
    if ( utility::isnightmap() )
    {
        self.isthermalenabled = 1;
        droneowner killstreak_utility::killstreak_setmainvision( thermalvisionset );
        droneowner player_utility::setthermalvision( 1, 12, 1000 );
    }
    
    while ( true )
    {
        droneowner waittill( #"switch_thermal_mode" );
        
        if ( !self.ispiloted )
        {
            continue;
        }
        
        if ( self.isthermalenabled )
        {
            self.isthermalenabled = 0;
            droneowner player_utility::setthermalvision( 0 );
            droneowner function_98cd33662c8f413d( self );
            droneowner playlocalsound( "weap_thermal_toggle_click" );
            continue;
        }
        
        self.isthermalenabled = 1;
        
        if ( droneconfig.var_30e7bbc9ee1bd839 && droneconfig.thermalpbg )
        {
            function_a82677f8f4785700( droneconfig.thermalpbg );
        }
        else
        {
            droneowner killstreak_utility::killstreak_setmainvision( thermalvisionset );
        }
        
        droneowner player_utility::setthermalvision( 1, 12, 1000 );
        droneowner playlocalsound( "weap_thermal_toggle_click" );
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x7d7ac6f4, Offset: 0x5307
// Size: 0xb5
function function_98cd33662c8f413d( drone )
{
    droneconfig = level.helperdronesettings[ drone.helperdronetype ];
    
    if ( droneconfig.var_30e7bbc9ee1bd839 && isdefined( droneconfig.colorpbg ) )
    {
        pbgpostfxbundlestart( self, droneconfig.colorpbg );
        return;
    }
    
    if ( level.mapname == "mp_hideout" )
    {
        killstreak_utility::killstreak_setmainvision( droneconfig.var_9fa8a04fa6a7af05 );
    }
    
    if ( isdefined( level.assaultdronevisionset ) )
    {
        killstreak_utility::killstreak_setmainvision( level.assaultdronevisionset );
        return;
    }
    
    killstreak_utility::killstreak_setmainvision( droneconfig.colorvision );
}

// Namespace helper_drone
// Params 1
// Checksum 0xcda11367, Offset: 0x53c4
// Size: 0x14f
function helperdrone_monitorcollision( config )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    
    while ( true )
    {
        self waittill( #"touch", ent );
        
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        vehicle = undefined;
        
        if ( ent vehicle::is_vehicle() )
        {
            vehicle = ent;
        }
        else if ( ent vehicle::is_in_vehicle() )
        {
            vehicle = ent.vehicle;
        }
        
        if ( vehicle == self )
        {
            continue;
        }
        
        if ( !isdefined( vehicle ) )
        {
            continue;
        }
        
        attacker = undefined;
        inflictor = undefined;
        
        if ( player_utility::playersareenemies( self.owner, vehicle.owner ) )
        {
            currentvehicle = vehicle.owner vehicle::get_vehicle();
            
            if ( currentvehicle == vehicle )
            {
                attacker = vehicle.owner;
                inflictor = vehicle;
            }
        }
        
        self dodamage( self.maxhealth, vehicle.origin, attacker, inflictor, "MOD_CRUSH" );
        break;
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x11d8fb5e, Offset: 0x551b
// Size: 0x15b
function function_7cb035830b2e9992( config )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    watercontents = [ "physicscontents_water" ];
    contentoverride = physics_createcontents( watercontents );
    self.inwater = 0;
    
    while ( true )
    {
        hitwater = physics_querypoint( self.origin, 0, contentoverride, self, "physicsquery_any" );
        
        if ( hitwater && !self.inwater )
        {
            self.inwater = 1;
            attacker = self.owner;
            inflictor = self;
            self dodamage( 10000, self.origin, attacker, inflictor, "MOD_CRUSH" );
            break;
        }
        else if ( !hitwater && self.inwater )
        {
            self.inwater = 0;
            self vehicle_setspeed( 100, 10 );
            self setyawspeed( 120, 90 );
            self sethoverparams( 30, 10, 5 );
            self setturningability( 1 );
            self setdroneturnparams( 50, 1.3, 30, 20 );
        }
        
        waitframe();
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xfa7764ae, Offset: 0x567e
// Size: 0xb7
function helperdrone_watchforgoal()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    self.owner endon( #"death_or_disconnect" );
    self endon( #"owner_gone" );
    self notify( #"helperdrone_watchforgoal" );
    self endon( #"helperdrone_watchforgoal" );
    result = utility::waittill_any_return( "goal", "near_goal", "hit_goal" );
    self.intransit = 0;
    self.inactive = 0;
    self notify( #"hit_goal" );
}

// Namespace helper_drone
// Params 1
// Checksum 0x971a6775, Offset: 0x573d
// Size: 0x41d
function helperdrone_watchdamage( var_7076b7d3aa171123 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self.owner endon( #"disconnect" );
    self endon( #"owner_gone" );
    self.health = 2147483647;
    config = level.helperdronesettings[ self.helperdronetype ];
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        debugdamage = undefined;
        
        /#
            debugdamage = istrue( self.debugdamage );
        #/
        
        if ( isdefined( attacker ) )
        {
            if ( isdefined( attacker.owner ) )
            {
                attacker = attacker.owner;
            }
            
            if ( attacker.team == self.team && attacker != self.owner && !var_7076b7d3aa171123 )
            {
                continue;
            }
        }
        
        if ( isdefined( objweapon ) )
        {
            if ( debugdamage )
            {
            }
            else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
            {
                amount = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, meansofdeath, amount, config.maxhealth, 1, 1, 1 );
            }
        }
        
        self.currenthealth -= amount;
        killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
        data = { #objweapon:objweapon, #idflags:idflags, #partname:partname, #tagname:tagname, #modelname:modelname, #meansofdeath:meansofdeath, #point:point, #direction_vec:direction_vec, #attacker:attacker, #damage:amount, #victim:self };
        
        if ( isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "" );
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
            {
                [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( attacker, objweapon, self, meansofdeath, amount, data );
            }
            
            if ( utility::issharedfuncdefined( #"damage", #"logattackerkillstreak" ) )
            {
                self [[ utility::getsharedfunc( #"damage", #"logattackerkillstreak" ) ]]( self, amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
            }
            
            if ( self.currenthealth <= 0 )
            {
                attacker notify( #"destroyed_killstreak", objweapon );
                damage = amount;
                damagetype = meansofdeath;
                skipdeathnotify = 1;
                
                if ( isdefined( objweapon ) )
                {
                    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
                    {
                        notifyattacker = self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( self.helperdronetype, attacker, objweapon, damagetype, damage, config.scorepop, config.vodestroyed, config.destroyedsplash, skipdeathnotify );
                    }
                }
                
                thread helperdrone_explode( 1 );
            }
        }
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0x3cc536b9, Offset: 0x5b62
// Size: 0x12a
function helperdrone_watchtimeout()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"drop" );
    self.owner endon( #"disconnect" );
    self endon( #"owner_gone" );
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( !isdefined( self.timeout ) )
    {
        return;
    }
    
    if ( self.timeout > 0 )
    {
        wait self.timeout;
    }
    
    if ( config.voontimeout )
    {
        if ( killstreak::function_17736ca3e3ad4382( self.helperdronetype ) )
        {
            killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, self.streakinfo.streakname + "_timeout", #"leave" );
        }
        else
        {
            killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_timeout", #"leave", 1 );
        }
    }
    
    thread helperdrone_leave( 1 );
}

// Namespace helper_drone
// Params 0
// Checksum 0x679be19a, Offset: 0x5c94
// Size: 0x6e
function helperdrone_watchownerloss()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    childthread helperdrone_watchownerstatus( "disconnect" );
    childthread helperdrone_watchownerstatus( "joined_team" );
    childthread helperdrone_watchownerstatus( "joined_spectators" );
    childthread helperdrone_watchownerstatus( "last_stand_enter" );
}

// Namespace helper_drone
// Params 1
// Checksum 0xc2966811, Offset: 0x5d0a
// Size: 0x2d
function helperdrone_watchownerstatus( notifymsg )
{
    self.owner waittill( notifymsg );
    self notify( #"owner_gone" );
    thread helperdrone_leave();
}

// Namespace helper_drone
// Params 0
// Checksum 0x54c6f0d6, Offset: 0x5d3f
// Size: 0x64
function helperdrone_watchownerdeath()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"owner_gone" );
    
    while ( true )
    {
        self.owner utility::waittill_any( "death", "last_stand_enter" );
        
        if ( function_e88a0471efc222e8() )
        {
            thread helperdrone_leave();
        }
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0x18feab3, Offset: 0x5dab
// Size: 0xe0, Type: bool
function function_e88a0471efc222e8()
{
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( config.diewithowner )
    {
        return true;
    }
    
    if ( level.gamemodebundle.var_ebfe1419685a15cd )
    {
        return true;
    }
    
    if ( game_utility::function_d3590d4c71dbeae8( self.owner ) || getdvarint( @"scr_force_player_fatal_death", 0 ) )
    {
        if ( self.ispiloted )
        {
            switch ( self.helperdronetype )
            {
                case #"hash_8ef5b52c9e784884":
                case #"hash_b73c57d747ce4083":
                case #"hash_e40585107590f016":
                    if ( !config.repeatuse )
                    {
                        return true;
                    }
                    
                    self notify( #"killstreakexit" );
                    return false;
                default:
                    return true;
            }
        }
    }
    
    return false;
}

// Namespace helper_drone
// Params 0
// Checksum 0xe6965a6, Offset: 0x5e94
// Size: 0xd9
function helperdrone_watchroundend()
{
    self endon( #"death", #"leaving", #"explode", #"drop", #"owner_gone" );
    self.owner endon( #"disconnect" );
    level utility::waittill_any( "start_game_ended", "game_ended", "prematch_cleanup" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    if ( self.var_c76bfe8b1e839403 )
    {
        wait self.var_c76bfe8b1e839403;
    }
    
    thread helperdrone_leave();
}

// Namespace helper_drone
// Params 1
// Checksum 0x5c963098, Offset: 0x5f75
// Size: 0x1a1
function helperdrone_leave( timeout )
{
    self endon( #"death", #"explode", #"drop" );
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_f9b3918b698c1d60" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_f9b3918b698c1d60" ) ]]( self );
    }
    
    if ( isdefined( config.leavefunc ) )
    {
        self thread [[ config.leavefunc ]]( timeout );
        return;
    }
    
    if ( self.helperdronetype == "radar_drone_overwatch" )
    {
        self clearlookatent();
        self setmaxpitchroll( 0, 0 );
        self notify( #"leaving" );
        self vehicle_setspeed( 50, 25 );
        pathgoal = self.origin + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 500;
        pathgoal += ( 0, 0, 1000 );
        self setvehgoalpos( pathgoal, 1 );
        self setneargoalnotifydist( 100 );
        self waittill( #"near_goal" );
        pathend = helperdrone_getpathend();
        self vehicle_setspeed( 150, 50 );
        self setvehgoalpos( pathend, 1 );
        self waittill( #"goal" );
        self notify( #"gone" );
        helperdrone_remove( self.helperdronetype, level.helperdronesettings[ self.helperdronetype ], 0 );
        return;
    }
    
    thread helperdrone_explode( 0, 1, timeout );
}

// Namespace helper_drone
// Params 0
// Checksum 0x499ad588, Offset: 0x611e
// Size: 0x55
function helperdrone_getpathend()
{
    halfdistance = 15000;
    yaw = self.angles[ 1 ];
    direction = ( 0, yaw, 0 );
    endpoint = self.origin + anglestoforward( direction ) * halfdistance;
    return endpoint;
}

// Namespace helper_drone
// Params 0
// Checksum 0x886d2f4d, Offset: 0x617c
// Size: 0x145
function perkengineer_manageminimap()
{
    enemyicon = "hud_icon_minimap_killstreak_cuav";
    createfunc = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"createobjectiveengineer" ) )
    {
        createfunc = utility::getsharedfunc( #"game", #"createobjectiveengineer" );
    }
    
    if ( isdefined( createfunc ) )
    {
        self.enemyobjid = self [[ createfunc ]]( enemyicon, 1, 1 );
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_engineer" ] ) && player.team != self.team )
        {
            if ( isdefined( self.enemyobjid ) && self.enemyobjid != -1 )
            {
                objidpoolmanager::objective_playermask_addshowplayer( self.enemyobjid, player );
            }
        }
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x59e082e1, Offset: 0x62c9
// Size: 0xed, Type: bool
function helperdrone_premodifydamage( data )
{
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = data.victim.streakinfo.bundle;
        
        if ( bundle )
        {
            data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, { #iskillstreak:1, #inflictor:data.inflictor } );
        }
    }
    
    return true;
}

// Namespace helper_drone
// Params 1
// Checksum 0x6feea692, Offset: 0x63bf
// Size: 0xfe, Type: bool
function helperdrone_postmodifydamage( data )
{
    type = data.meansofdeath;
    damage = data.damage;
    
    if ( isdefined( self.owner ) && self.owner utility::isusingremote() )
    {
        if ( isexplosivedamagemod( type ) )
        {
            if ( ceil( damage / self.maxhealth ) >= 0.4 )
            {
                earthquake( 0.25, 0.2, self.origin, 150 );
                self.owner playrumbleonentity( "damage_heavy" );
            }
            else
            {
                earthquake( 0.15, 0.15, self.origin, 150 );
                self.owner playrumbleonentity( "damage_light" );
            }
        }
    }
    
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace helper_drone
// Params 1
// Checksum 0x82820609, Offset: 0x64c6
// Size: 0x11f
function helperdrone_stunned( duration )
{
    self notify( #"helperdrone_stunned" );
    self endon( #"helperdrone_stunned" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( self.attackingtarget )
    {
        self notify( #"hash_81dec846ca525a44" );
    }
    
    self.stunned = 1;
    
    if ( isdefined( level.helperdronesettings[ self.helperdronetype ].fxid_sparks ) )
    {
        playfxontag( level.helperdronesettings[ self.helperdronetype ].fxid_sparks, self, "tag_origin" );
    }
    
    playfxontag( utility::getfx( "emp_stun" ), self, "tag_origin" );
    hostmigration::waitlongdurationwithpause( duration );
    stopfxontag( utility::getfx( "emp_stun" ), self, "tag_origin" );
    self.stunned = 0;
}

// Namespace helper_drone
// Params 1
// Checksum 0x9abaf462, Offset: 0x65ed
// Size: 0x2bd
function function_2b6d3e12b69ce468( data )
{
    self.isdestroyed = 1;
    self.haywiredeath = 1;
    
    if ( self.repeatuse )
    {
        self.repeatuse = 0;
    }
    
    if ( self.ispiloted )
    {
        self.var_ad74168cb59251e1 = spawn( "script_model", self.origin );
        self.var_ad74168cb59251e1.angles = self.owner getplayerangles();
        self.var_ad74168cb59251e1 setmodel( "tag_origin" );
        self.var_ad74168cb59251e1 linkto( self, "tag_origin" );
        
        if ( killstreak::function_17736ca3e3ad4382( self.helperdronetype ) )
        {
            self.owner remotecontrolvehicleoff();
        }
        else if ( self.helperdronetype == "assault_drone" )
        {
            self.owner remotecontrolvehicleoff();
        }
        
        self.owner cameraunlink();
        self.owner cameralinkto( self.var_ad74168cb59251e1, "tag_origin", 1, 1 );
        self clearlookatent();
    }
    
    vertdistance = 3000;
    castend = self.origin + anglestoup( self.angles ) * vertdistance * -1 + ( randomintrange( -500, 500 ), 0, randomintrange( -500, 500 ) );
    trace = trace::ray_trace( self.origin, castend, [ self ] );
    target_origin = trace[ "position" ] + trace[ "normal" ] * 5;
    maxvelocity = getdvarfloat( @"hash_44e62153228221f", 30.2 );
    acceleration = getdvarfloat( @"hash_cdb03278c6d17e78", 13.8 );
    deceleration = getdvarfloat( @"hash_ed85baf3072c3fff", 17.2 );
    var_6705e2570d9c3664 = getdvarfloat( @"hash_3f6d20d42a18063b", 2500 );
    distance = distance( target_origin, self.origin );
    falltime = sqrt( 2 * distance / acceleration );
    falltime = min( falltime, 2 ) - 0.2;
    self vehicle_setspeed( maxvelocity, acceleration, deceleration );
    self setvehgoalpos( target_origin, 0 );
    thread function_cc5d71d19cd66107();
    time = 0;
    
    while ( true )
    {
        if ( distancesquared( self.origin, target_origin ) <= var_6705e2570d9c3664 || time >= falltime )
        {
            function_6a8189230baa9b69( data );
            break;
        }
        
        time += level.framedurationseconds;
        waitframe();
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x782e8d5, Offset: 0x68b2
// Size: 0x86
function function_6a8189230baa9b69( data )
{
    if ( isdefined( data.inflictor ) && isdefined( data.inflictor.stuckto ) )
    {
        data.inflictor notify( #"forcedeath" );
    }
    
    if ( isdefined( self.var_ad74168cb59251e1 ) )
    {
        self.owner cameraunlink();
        self.var_ad74168cb59251e1 delete();
        self.var_ad74168cb59251e1 = undefined;
    }
    
    thread helperdrone_explode( 1 );
}

// Namespace helper_drone
// Params 0
// Checksum 0xea26f032, Offset: 0x6940
// Size: 0x76
function function_cc5d71d19cd66107()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"drop" );
    self setmaxpitchroll( 60, 90 );
    self setyawspeed( 1000, 500, 500 );
    
    while ( true )
    {
        randyaw = randomintrange( 140, 170 );
        self settargetyaw( self.angles[ 1 ] + randyaw );
        wait 0.25;
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x5714455c, Offset: 0x69be
// Size: 0xa7
function helperdrone_handledeathdamage( data )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( isdefined( data ) && isdefined( data.inflictor ) && isdefined( data.inflictor.weapon_name ) && ( data.inflictor.weapon_name == "shock_stick_mp" || data.inflictor.weapon_name == "jup_shock_stick_cp" ) )
    {
        thread function_2b6d3e12b69ce468( data );
    }
    else
    {
        thread helperdrone_explode( 1, undefined, undefined, undefined, data );
    }
    
    return 0;
}

// Namespace helper_drone
// Params 0
// Checksum 0xb6051729, Offset: 0x6a6e
// Size: 0x12
function function_1a1af8effb6318e7()
{
    self setscriptablepartstate( "body_damage_light", "on" );
}

// Namespace helper_drone
// Params 0
// Checksum 0x6665b21f, Offset: 0x6a88
// Size: 0x12
function function_34219a3628f1d9b0()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace helper_drone
// Params 0
// Checksum 0x1e6634d0, Offset: 0x6aa2
// Size: 0x12
function function_db443e2033acaf2e()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace helper_drone
// Params 1
// Checksum 0x44c549e5, Offset: 0x6abc
// Size: 0xde
function function_198f07572db31b4b( cameraorigin )
{
    tag_origin = spawn( "script_model", cameraorigin );
    tag_origin setmodel( "tag_origin" );
    direction = vectornormalize( self.origin - tag_origin.origin );
    right = vectorcross( direction, ( 0, 0, 1 ) );
    up = vectorcross( right, direction );
    lookrotation = axistoangles( direction, right, up );
    tag_origin rotateto( lookrotation, 0.01 );
    self.owner cameraunlink();
    self.owner setplayerangles( tag_origin.angles );
    self.owner cameralinkto( tag_origin, "tag_origin", 0, 1 );
}

// Namespace helper_drone
// Params 1
// Checksum 0x1d1a88c9, Offset: 0x6ba2
// Size: 0x25, Type: bool
function function_8e31d8004223bb1c( traceresult )
{
    return isdefined( traceresult[ "hittype" ] ) && traceresult[ "hittype" ] != "hittype_none";
}

// Namespace helper_drone
// Params 3
// Checksum 0x5959072f, Offset: 0x6bd0
// Size: 0xea
function function_1dfb777446b6d755( testangles, isback, upangles )
{
    traceorigin = self gettagorigin( "tag_undercam" ) - ( 0, 0, 15 );
    
    if ( isback )
    {
        testangles *= -1;
    }
    
    originforward = anglestoforward( testangles + ( 15, 0, 0 ) );
    
    if ( !isdefined( upangles ) )
    {
        traceresult = trace::ray_trace( traceorigin + originforward, traceorigin + testangles, self );
        thread debug_utility::drawline( traceorigin + originforward, traceorigin + testangles, 2.5, ( 1, 0, 0 ) );
    }
    else
    {
        traceresult = trace::ray_trace( traceorigin + testangles, traceorigin + testangles + upangles, self );
        thread debug_utility::drawline( traceorigin + testangles, traceorigin + testangles + upangles, 2.5, ( 1, 0, 0 ) );
    }
    
    return traceresult;
}

// Namespace helper_drone
// Params 2
// Checksum 0x1196bb02, Offset: 0x6cc3
// Size: 0xb0, Type: bool
function function_23e92e96ffc718d7( traceangles, isback )
{
    traceorigin = self gettagorigin( "tag_undercam" ) - ( 0, 0, 15 );
    traceupangles = anglestoup( self.angles ) * 125;
    testtrace = function_1dfb777446b6d755( traceangles, isback );
    
    if ( !function_8e31d8004223bb1c( testtrace ) )
    {
        var_d6844e45e915fb80 = function_1dfb777446b6d755( traceangles, isback, traceupangles );
        
        if ( !function_8e31d8004223bb1c( var_d6844e45e915fb80 ) )
        {
            if ( isback )
            {
                traceangles *= -1;
            }
            
            function_198f07572db31b4b( traceorigin + traceangles + traceupangles );
            return true;
        }
    }
    
    return false;
}

// Namespace helper_drone
// Params 0
// Checksum 0xb0e370eb, Offset: 0x6d7c
// Size: 0x94, Type: bool
function function_b6a81fa34a6cbdd8()
{
    traceorigin = self gettagorigin( "tag_undercam" ) - ( 0, 0, 15 );
    traceupangles = anglestoup( self.angles ) * 125 * 3;
    traceresult = trace::ray_trace( traceorigin, traceorigin + traceupangles, self );
    thread debug_utility::drawline( traceorigin, traceorigin + traceupangles, 2.5, ( 1, 0, 0 ) );
    
    if ( !function_8e31d8004223bb1c( traceresult ) )
    {
        function_198f07572db31b4b( traceorigin + traceupangles );
        return true;
    }
    
    return false;
}

// Namespace helper_drone
// Params 0
// Checksum 0xb9ae8d2f, Offset: 0x6e19
// Size: 0xa9, Type: bool
function helperdrone_setcamerathirdperson()
{
    var_b02bcf521a5d2918 = anglestoforward( self.angles ) * 350;
    tracerightangles = anglestoright( self.angles ) * 350;
    traceleftangles = anglestoleft( self.angles ) * 350;
    
    if ( function_23e92e96ffc718d7( var_b02bcf521a5d2918, 1 ) )
    {
        return true;
    }
    
    if ( function_23e92e96ffc718d7( var_b02bcf521a5d2918 ) )
    {
        return true;
    }
    
    if ( function_23e92e96ffc718d7( tracerightangles ) )
    {
        return true;
    }
    
    if ( function_23e92e96ffc718d7( traceleftangles ) )
    {
        return true;
    }
    
    if ( function_b6a81fa34a6cbdd8() )
    {
        return true;
    }
    
    /#
        announcement( "<dev string:xd9>" );
    #/
    
    return false;
}

// Namespace helper_drone
// Params 5
// Checksum 0xd115cd1e, Offset: 0x6ecb
// Size: 0x460
function helperdrone_explode( wasdestroyed, wasexited, wastimedout, wasdetonated, damagedata )
{
    self.owner player_utility::stopwatchingthermalinputchange();
    self.isdestroyed = 1;
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( !wasexited && !wasdetonated )
    {
        if ( killstreak::function_17736ca3e3ad4382( self.helperdronetype ) )
        {
            killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, self.helperdronetype + "_destroyed", #"destroyed" );
        }
        else if ( player_utility::playersareenemies( damagedata.attacker, self.owner ) )
        {
            killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.helperdronetype + "_destroyed", #"destroyed", 1 );
        }
    }
    
    if ( isdefined( self.targetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( self.targetmarkergroup );
        self.targetmarkergroup = undefined;
    }
    
    if ( isdefined( self.minimapid ) )
    {
        objidpoolmanager::returnobjectiveid( self.minimapid );
        self.minimapid = undefined;
    }
    
    thirdperson = 0;
    
    if ( isdefined( config.explodefunc ) && !self.dropdrone )
    {
        self [[ config.explodefunc ]]( config, wasdestroyed, wasexited, wastimedout, wasdetonated, thirdperson, damagedata );
    }
    else
    {
        function_e44894e06827a3a9();
    }
    
    emp_debuff::allow_emp( 0 );
    self notify( #"explode" );
    
    if ( isdefined( self.streakinfo.superref ) )
    {
        if ( utility::issharedfuncdefined( #"challenges", #"onfieldupgradeend" ) )
        {
            challengeparams = { #value:self.usedcount, #fieldupgraderef:self.streakinfo.superref, #fieldupgradeent:self, #field_upgrade_owner:self.owner };
            self.owner [[ utility::getsharedfunc( #"challenges", #"onfieldupgradeend" ) ]]( challengeparams );
        }
    }
    
    if ( isdefined( self.streakinfo.superid ) )
    {
        if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
        {
            [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.streakinfo.superid, self.usedcount, istrue( wasdestroyed ) );
        }
    }
    
    owner = self.owner;
    
    if ( isdefined( owner ) )
    {
        if ( isdefined( owner.super ) && owner.super.isinuse )
        {
            if ( self.streakinfo.superref == owner.super.staticdata.ref )
            {
                if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
                {
                    self.owner thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0 );
                }
            }
        }
    }
    
    if ( self.inwater )
    {
        self.owner clearsoundsubmix( "player_swimming_underwater", 0 );
        self.owner clearsoundsubmix( "iw9_player_drowning", 0 );
        self.owner setentitysoundcontext( "atmosphere", "water_surface", 0 );
        self.owner clearclienttriggeraudiozone( 0 );
    }
    
    if ( self.nonvehicle )
    {
        waitframe();
    }
    else
    {
        wait 0.2;
    }
    
    helperdrone_remove( self.helperdronetype, level.helperdronesettings[ self.helperdronetype ], wasdestroyed );
    
    if ( !isbrgamemode() && isdefined( owner ) && utility::issharedfuncdefined( #"br", #"superslotcleanup" ) )
    {
        [[ utility::getsharedfunc( #"br", #"superslotcleanup" ) ]]( owner );
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x45055b19, Offset: 0x7333
// Size: 0xb4
function function_f3897bba9c46b35f( ison )
{
    if ( ison )
    {
        vehicle_omnvar::show_warning( "DDoSed", self.owner, vehicle::get_ref() );
        self.owner emp_debuff::play_emp_scramble( 4 );
        self.owner player::_freezecontrols( 1 );
        self.owner player::_freezelookcontrols( 1 );
        return;
    }
    
    vehicle_omnvar::hide_warning( "DDoSed", self.owner, vehicle::get_ref() );
    self.owner emp_debuff::stop_emp_scramble( 4 );
    self.owner player::_freezecontrols( 0 );
    self.owner player::_freezelookcontrols( 0 );
}

// Namespace helper_drone
// Params 3
// Checksum 0xf87aa74e, Offset: 0x73ef
// Size: 0x3bf
function helperdrone_drop( wasdestroyed, wasexited, timedout )
{
    dronehealth = self.currenthealth;
    dronevel = undefined;
    
    if ( self.ispiloted )
    {
        dronevel = self getentityvelocity();
    }
    
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( isdefined( self.targetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( self.targetmarkergroup );
        self.targetmarkergroup = undefined;
    }
    
    if ( isdefined( self.minimapid ) )
    {
        objidpoolmanager::returnobjectiveid( self.minimapid );
        self.minimapid = undefined;
    }
    
    if ( isdefined( config.dropfunc ) && self.dropdrone )
    {
        self [[ config.dropfunc ]]( config, wasdestroyed, wasexited, timedout );
    }
    else
    {
        function_e44894e06827a3a9();
    }
    
    emp_debuff::allow_emp( 0 );
    self notify( #"drop" );
    
    if ( isdefined( self.streakinfo.superref ) )
    {
        if ( utility::issharedfuncdefined( #"challenges", #"onfieldupgradeend" ) )
        {
            challengeparams = { #value:self.usedcount, #fieldupgraderef:self.streakinfo.superref, #fieldupgradeent:self, #field_upgrade_owner:self.owner };
            self.owner [[ utility::getsharedfunc( #"challenges", #"onfieldupgradeend" ) ]]( challengeparams );
        }
    }
    
    if ( isdefined( self.streakinfo.superid ) )
    {
        if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
        {
            [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.streakinfo.superid, self.usedcount, istrue( wasdestroyed ) );
        }
    }
    
    if ( self.inwater )
    {
        self.owner clearsoundsubmix( "player_swimming_underwater", 0 );
        self.owner clearsoundsubmix( "iw9_player_drowning", 0 );
        self.owner setentitysoundcontext( "atmosphere", "water_surface", 0 );
        self.owner clearclienttriggeraudiozone( 0 );
    }
    
    if ( self.nonvehicle )
    {
        waitframe();
    }
    else
    {
        wait 0.2;
    }
    
    owner = self.owner;
    
    if ( isdefined( owner.super ) && owner.super.isinuse )
    {
        if ( self.streakinfo.superref == owner.super.staticdata.ref )
        {
            if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
            {
                self.owner thread [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 0 );
            }
        }
    }
    
    helperdrone_remove( self.helperdronetype, level.helperdronesettings[ self.helperdronetype ], wasdestroyed, dronevel, dronehealth );
    
    if ( !isbrgamemode() && isdefined( owner ) && utility::issharedfuncdefined( #"br", #"superslotcleanup" ) )
    {
        [[ utility::getsharedfunc( #"br", #"superslotcleanup" ) ]]( owner );
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xc8f7d485, Offset: 0x77b6
// Size: 0x4e
function function_eccf8adbfdb03edc()
{
    if ( isent( self ) )
    {
        explodestate = "on";
        
        if ( self.inwater )
        {
            if ( self getscriptableparthasstate( "explode", "water" ) )
            {
                explodestate = "water";
            }
        }
        
        self setscriptablepartstate( "explode", explodestate, 0 );
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0x9ace751f, Offset: 0x780c
// Size: 0x4e
function function_e44894e06827a3a9()
{
    if ( isent( self ) )
    {
        exitstate = "on";
        
        if ( self.inwater )
        {
            if ( self getscriptableparthasstate( "exit", "water" ) )
            {
                exitstate = "water";
            }
        }
        
        self setscriptablepartstate( "exit", exitstate, 0 );
    }
}

// Namespace helper_drone
// Params 0
// Checksum 0xc156c0b5, Offset: 0x7862
// Size: 0x1b
function function_5cf532639f300426()
{
    if ( isent( self ) )
    {
        self setscriptablepartstate( "drop", "on", 0 );
    }
}

// Namespace helper_drone
// Params 5
// Checksum 0x7b6090d4, Offset: 0x7885
// Size: 0x380
function helperdrone_remove( dronetype, config, wasdestroyed, dronevel, dronehealth )
{
    helperdrone_disableradar();
    self.ispiloted = undefined;
    self.repeatuse = undefined;
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    if ( isdefined( self.playersfx ) )
    {
        self.playersfx delete();
    }
    
    if ( isdefined( self.scrambler ) )
    {
        self.scrambler delete();
    }
    
    if ( isdefined( self.enemyobjid ) )
    {
        objidpoolmanager::returnobjectiveid( self.enemyobjid );
    }
    
    if ( isdefined( self.pulsedarts ) && self.pulsedarts.size > 0 )
    {
        foreach ( pulsedart in self.pulsedarts )
        {
            pulsedart notify( #"death" );
        }
    }
    
    if ( !self.streakinfo.issuper )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( !config.autonomous )
        {
            self.owner.vehicle = undefined;
        }
        
        if ( isdefined( self.owner.helperdrone ) )
        {
            self.owner.helperdrone = undefined;
        }
        
        if ( isplayer( self.owner ) )
        {
            self.owner clearsoundsubmix( "mp_recon_drone", 1 );
            self.owner notify( #"hash_d40e764495907cfe", -1 );
        }
        else
        {
            self.owner notify( #"drone_destroyed", wasdestroyed );
        }
        
        self.owner player_utility::stopwatchingthermalinputchange();
        
        if ( dronetype == "radar_drone_escort" || dronetype == "radar_drone_overwatch" )
        {
            self.owner player::hideminimap();
        }
        
        self.streakinfo.expiredbydeath = istrue( wasdestroyed );
        self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    }
    
    if ( self.nonvehicle )
    {
        thread helperdrone_delete( dronetype );
    }
    else if ( !wasdestroyed && self.dropdrone && !self.dropped )
    {
        if ( isdefined( self.owner ) )
        {
            droppeddrone = self.owner drophelperdrone( self.origin, self.angles, dronetype, self.streakinfo, dronevel, dronehealth );
        }
        
        vehicle_tracking::delete_vehicle( self );
    }
    else
    {
        if ( isdefined( config.onvehicledeath ) )
        {
            self [[ config.onvehicledeath ]]( config );
        }
        
        vehicle_tracking::delete_vehicle( self );
    }
    
    if ( isplayer( self.owner ) && isbrgamemode() )
    {
        self.owner setclientomnvar( "ui_killstreak_countdown", 0 );
    }
}

// Namespace helper_drone
// Params 1, eflags: 0x4
// Checksum 0xa68df382, Offset: 0x7c0d
// Size: 0x59
function private helperdrone_delete( dronetype )
{
    self endon( #"death" );
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( config.deletedelay > 0 )
    {
        wait config.deletedelay;
    }
    
    self delete();
}

// Namespace helper_drone
// Params 0
// Checksum 0x59ec65f0, Offset: 0x7c6e
// Size: 0x5c
function function_ab65cb511ffc8807()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"dronestart" );
    starttime = gettime();
    var_fd551226c4a881e2 = 1000;
    
    while ( gettime() - starttime < var_fd551226c4a881e2 )
    {
        function_686284be4293a73a( 0 );
        waitframe();
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x70908e42, Offset: 0x7cd2
// Size: 0x76
function function_686284be4293a73a( state, drone )
{
    assert( 0 <= state && state <= 4, "<dev string:xff>" );
    isassault = 0;
    
    if ( isdefined( drone ) )
    {
        isassault = drone.helperdronetype == "assault_drone";
    }
    
    if ( state > 0 && isassault )
    {
        state += 2;
    }
    
    self setclientomnvar( "ui_rcd_controls", state );
}

// Namespace helper_drone
// Params 3
// Checksum 0xd5dfb26f, Offset: 0x7d50
// Size: 0x5b
function helperdrone_settargetmarkerstate( markergroup, target, state )
{
    firstbit = ( state >> 0 ) % 2 == 1;
    secondbit = ( state >> 1 ) % 2 == 1;
    targetmarkergroupsetentitystate( markergroup, target, firstbit );
    targetmarkergroupsetextrastate( markergroup, target, secondbit );
}

// Namespace helper_drone
// Params 2
// Checksum 0xa92c8f96, Offset: 0x7db3
// Size: 0x7dd
function function_37be65b472591d49( streakinfo, owner )
{
    if ( utility::issharedfuncdefined( #"infiltration", #"hash_50f6da65a7a15290" ) )
    {
        return utility::callsharedfunc( #"infiltration", #"hash_50f6da65a7a15290" );
    }
    
    if ( !isdefined( level.supportdrones ) )
    {
        return 0;
    }
    
    if ( level.incominghelperdrones.size > 0 )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"maxvehiclesallowed" ) )
        {
            if ( level.incominghelperdrones.size >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() )
            {
                return 1;
            }
        }
        
        foreach ( drone in level.incominghelperdrones )
        {
            if ( drone.owner == owner )
            {
                continue;
            }
            
            if ( killstreak::function_17736ca3e3ad4382( streakinfo.streakname ) && drone.type == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( isdefined( drone.owner ) && drone.owner.team == owner.team )
                    {
                        return 1;
                    }
                }
                
                continue;
            }
            
            if ( streakinfo.streakname == "assault_drone" && drone.type == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( isdefined( drone.owner ) && drone.owner.team == owner.team )
                    {
                        return 1;
                    }
                }
                
                continue;
            }
            
            if ( streakinfo.streakname == "radar_drone_overwatch" && drone.type == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( helperdrone_getnumdrones( "radar_drone_overwatch", level.incominghelperdrones, owner.team ) >= 10 )
                    {
                        return 1;
                    }
                }
                
                if ( helperdrone_getnumdrones( "radar_drone_overwatch", level.incominghelperdrones ) >= 20 )
                {
                    return 1;
                }
                
                continue;
            }
            
            if ( streakinfo.streakname == "scrambler_drone_guard" && drone.type == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( helperdrone_getnumdrones( "scrambler_drone_guard", level.incominghelperdrones, owner.team ) >= 10 )
                    {
                        return 1;
                    }
                }
            }
        }
    }
    
    if ( level.supportdrones.size > 0 )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"maxvehiclesallowed" ) )
        {
            if ( level.supportdrones.size >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() )
            {
                return 1;
            }
        }
        
        foreach ( drone in level.supportdrones )
        {
            if ( streakinfo.streakname == "radar_drone_escort" && drone.helperdronetype == streakinfo.streakname )
            {
                if ( drone.owner == owner )
                {
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/COMPANION_ALREADY_EXISTS" );
                    }
                    
                    return 1;
                }
                
                continue;
            }
            
            if ( killstreak::function_17736ca3e3ad4382( streakinfo.streakname ) && drone.helperdronetype == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( drone.team == owner.team )
                    {
                        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                        {
                            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
                        }
                        
                        return 1;
                    }
                }
                
                continue;
            }
            
            if ( streakinfo.streakname == "assault_drone" && drone.helperdronetype == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( drone.team == owner.team )
                    {
                        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                        {
                            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
                        }
                        
                        return 1;
                    }
                }
                
                continue;
            }
            
            if ( streakinfo.streakname == "radar_drone_overwatch" && drone.helperdronetype == streakinfo.streakname )
            {
                if ( helperdrone_getnumdrones( "radar_drone_overwatch", level.supportdrones ) >= 20 )
                {
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
                    }
                    
                    return 1;
                }
                
                if ( level.teambased )
                {
                    if ( helperdrone_getnumdrones( "radar_drone_overwatch", level.supportdrones, owner.team ) >= 10 )
                    {
                        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                        {
                            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/MAX_FRIENDLY_PERSONAL_RADAR" );
                        }
                        
                        return 1;
                    }
                }
                
                if ( helperdrone_getnumdrones( "radar_drone_overwatch", level.supportdrones, owner ) >= 1 )
                {
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/PERSONAL_RADAR_ALREADY_ACTIVE" );
                    }
                    
                    return 1;
                }
                
                continue;
            }
            
            if ( streakinfo.streakname == "scrambler_drone_guard" && drone.helperdronetype == streakinfo.streakname )
            {
                if ( level.teambased )
                {
                    if ( helperdrone_getnumdrones( "scrambler_drone_guard", level.supportdrones, owner.team ) >= 10 )
                    {
                        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                        {
                            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/max_friendly_counter_uav" );
                        }
                        
                        return 1;
                    }
                    
                    continue;
                }
                
                if ( helperdrone_getnumdrones( "scrambler_drone_guard", level.supportdrones, owner ) >= 2 )
                {
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/max_friendly_counter_uav" );
                    }
                    
                    return 1;
                }
            }
        }
    }
    
    return 0;
}

// Namespace helper_drone
// Params 3
// Checksum 0xcc751fb9, Offset: 0x8599
// Size: 0xff
function helperdrone_getnumdrones( dronetype, dronearray, affiliation )
{
    numdrones = 0;
    
    foreach ( drone in dronearray )
    {
        if ( drone.type == dronetype || drone.helperdronetype == dronetype )
        {
            if ( isdefined( affiliation ) )
            {
                if ( isplayer( affiliation ) )
                {
                    if ( drone.owner != affiliation )
                    {
                        continue;
                    }
                }
                else if ( team_utility::isgameplayteam( affiliation ) )
                {
                    if ( drone.team != affiliation )
                    {
                        continue;
                    }
                }
            }
            
            numdrones++;
        }
    }
    
    return numdrones;
}

// Namespace helper_drone
// Params 0
// Checksum 0x51170e3b, Offset: 0x86a1
// Size: 0x98
function helperdrone_destroyongameend()
{
    self endon( #"death", #"leaving", #"explode" );
    level utility::waittill_any( "bro_shot_start", "game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
    
    helperdrone_handledeathdamage();
}

// Namespace helper_drone
// Params 1
// Checksum 0xfb98e260, Offset: 0x8741
// Size: 0x126
function helperdrone_watchaltitude( player )
{
    self endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    var_3a3aa590a814867a = getdvarfloat( @"hash_f983d652b2640512", 1500 );
    var_49e2323f0f59dcea = getdvarfloat( @"hash_35bab6c292a12242", 6000 );
    maxaltitude = var_3a3aa590a814867a + var_49e2323f0f59dcea;
    var_45e3d90efeebe918 = 0;
    var_64135b1269654c74 = 0;
    
    while ( true )
    {
        if ( self.origin[ 2 ] > var_49e2323f0f59dcea )
        {
            if ( self.origin[ 2 ] > maxaltitude )
            {
                player setclientomnvar( "ui_out_of_range", 0 );
                helperdrone_handledeathdamage();
            }
            
            var_45e3d90efeebe918 = ( self.origin[ 2 ] - var_49e2323f0f59dcea ) / var_3a3aa590a814867a;
        }
        else
        {
            var_45e3d90efeebe918 = 0;
        }
        
        if ( var_45e3d90efeebe918 != var_64135b1269654c74 )
        {
            var_64135b1269654c74 = var_45e3d90efeebe918;
            player setclientomnvar( "ui_out_of_range", var_45e3d90efeebe918 );
        }
        
        waitframe();
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x4a79f5ac, Offset: 0x886f
// Size: 0xa3
function helperdrone_gettargetoffset( helperdrone, player )
{
    config = level.helperdronesettings[ helperdrone.helperdronetype ];
    backoffset = config.backoffset;
    sideoffset = config.sideoffset;
    heightoffset = helperdrone helperdrone_getheightoffset( config );
    
    if ( isdefined( helperdrone.low_entry ) )
    {
        heightoffset *= helperdrone.low_entry;
    }
    
    targetoffset = ( sideoffset, backoffset, heightoffset );
    return targetoffset;
}

// Namespace helper_drone
// Params 2
// Checksum 0x81ec1d84, Offset: 0x891b
// Size: 0x5b8
function function_a5f95568df49cf66( helperdronetype, droneentity )
{
    zoffset = ( 0, 0, 80 );
    spawndist = level.helperdronesettings[ helperdronetype ].spawndist;
    heightoffset = ( 0, 0, zoffset[ 2 ] );
    halfsize = level.helperdronesettings[ helperdronetype ].halfsize;
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    playerpos = isdefined( droneentity ) ? droneentity.origin : utility::function_f02ebab438642e16();
    var_be05cac570d57ab0 = 50;
    horizontaloffset = 20;
    
    if ( train_utility::player_standing_on_train() )
    {
        heightoffset += ( 0, 0, 150 );
        var_be05cac570d57ab0 = 120;
        spawndist = 150;
        halfsize *= 3;
        horizontaloffset = 120;
    }
    else if ( player_utility::function_c0192d3e90f65e0e( self ) )
    {
        heightoffset += ( 0, 0, 100 );
        var_be05cac570d57ab0 = 100;
        spawndist = 120;
        halfsize *= 2;
        horizontaloffset = 100;
    }
    else if ( self isswimming() )
    {
        playerpos = isdefined( droneentity ) ? droneentity.origin : self.origin + ( 0, 0, getdvarfloat( @"hash_d78c8ed504373ea5", 30 ) );
    }
    
    var_3754aa86cac9d841 = isdefined( droneentity ) ? ( 0, 0, 0 ) : ( 0, 0, 1 );
    var_6263c45876844832 = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    ignoreents = self;
    raytrace = trace::ray_trace( self.origin + ( 0, 0, 20 ), playerpos + var_3754aa86cac9d841, ignoreents, var_6263c45876844832 );
    
    if ( raytrace[ "hittype" ] != "hittype_none" )
    {
        return;
    }
    
    var_e2afa7d3a137b96d = spawndist + horizontaloffset;
    
    if ( self getstance() == "prone" )
    {
        var_e2afa7d3a137b96d += 25;
    }
    
    if ( isplayer( self ) )
    {
        if ( train_utility::player_standing_on_train() )
        {
            heightoffset += ( 0, 0, 150 );
        }
    }
    
    spawnoffsets = [ heightoffset + spawndist * forward, heightoffset - spawndist * forward, heightoffset + spawndist * right, heightoffset - spawndist * right, heightoffset, heightoffset + 0.707 * spawndist * ( forward + right ), heightoffset + 0.707 * spawndist * ( forward - right ), heightoffset + 0.707 * spawndist * ( right - forward ), heightoffset + 0.707 * spawndist * ( -1 * forward - right ), var_e2afa7d3a137b96d * forward, -1 * var_e2afa7d3a137b96d * forward, var_e2afa7d3a137b96d * right, -1 * var_e2afa7d3a137b96d * right, 0.707 * var_e2afa7d3a137b96d * ( forward + right ), 0.707 * var_e2afa7d3a137b96d * ( forward - right ), 0.707 * var_e2afa7d3a137b96d * ( right - forward ), 0.707 * var_e2afa7d3a137b96d * ( -1 * forward - right ) ];
    currentchecks = 0;
    
    for ( i = 0; i < spawnoffsets.size ; i++ )
    {
        if ( 4 <= currentchecks )
        {
            currentchecks = 0;
            wait 0.05;
        }
        
        spawnoffset = spawnoffsets[ i ];
        spawnpos = playerpos + spawnoffset;
        
        if ( isbrgamemode() )
        {
            var_3a3aa590a814867a = getdvarfloat( @"hash_f983d652b2640512", 1500 );
            var_49e2323f0f59dcea = getdvarfloat( @"hash_35bab6c292a12242", 6000 );
            maxaltitude = var_3a3aa590a814867a + var_49e2323f0f59dcea;
            
            if ( spawnpos[ 2 ] >= maxaltitude )
            {
                break;
            }
        }
        
        rayoffset = vectornormalize( spawnoffset ) * var_be05cac570d57ab0;
        raypos = playerpos + rayoffset;
        collisioncontents = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot", "physicscontents_water" ] );
        raytrace = trace::ray_trace( playerpos, raypos, ignoreents, collisioncontents );
        
        /#
            if ( getdvarint( @"hash_7d1382405485d79f", 0 ) )
            {
                line( playerpos, raypos, ( 0, 0, 1 ), 1, 0, 1000 );
            }
        #/
        
        if ( raytrace[ "hittype" ] != "hittype_none" )
        {
            continue;
        }
        
        spheretrace = trace::sphere_trace( raypos, spawnpos, halfsize, ignoreents, collisioncontents );
        fraction = spheretrace[ "fraction" ];
        maxoffset = fraction * ( spawnpos - raypos );
        maxposition = raypos + maxoffset;
        
        /#
            if ( getdvarint( @"hash_7d1382405485d79f", 0 ) )
            {
                line( raypos, spawnpos, ( 1, 0, 0 ), 1, 0, 1000 );
                sphere( raypos, 5, ( 1, 1, 0 ), 0, 1000 );
                sphere( spawnpos, 5, ( 0, 1, 1 ), 0, 1000 );
            }
        #/
        
        if ( fraction > 0 )
        {
            /#
                if ( getdvarint( @"hash_7d1382405485d79f", 0 ) )
                {
                    sphere( maxposition, halfsize, ( 0, 1, 0 ), 0, 1000 );
                }
            #/
            
            self.recondronesafespawn = maxposition;
            return maxposition;
        }
        
        currentchecks++;
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x78701e3a, Offset: 0x8edc
// Size: 0xb7
function helperdrone_showminimaponspawn( drone )
{
    self endon( #"disconnect" );
    drone endon( #"death" );
    drone endon( #"explode" );
    drone endon( #"leaving" );
    drone endon( #"drop" );
    level endon( #"game_ended" );
    ownerid = self.guid;
    level notify( "helperDrone_show_minimap_" + ownerid );
    level endon( "helperDrone_show_minimap_" + ownerid );
    
    if ( level.istacops )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"spawned_player" );
        player::showminimap();
        self.showuavminimaponspawn = 1;
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x5eb9f0fa, Offset: 0x8f9b
// Size: 0x19d
function deliverydrone_delivertopoint( targetpos, ondelivercallback )
{
    self endon( #"death_or_disconnect" );
    self endon( #"recondroneended" );
    self endon( #"recondroneunset" );
    streakinfo = spawnstruct();
    streakinfo.streakname = "ammo_drop";
    streakinfo.issuper = 1;
    streakinfo.superid = level.superglobals.staticsuperdata[ "super_weapon_drop" ].id;
    streakinfo.superref = level.superglobals.staticsuperdata[ "super_weapon_drop" ].ref;
    
    if ( tryusehelperdroneearlyout( streakinfo, 1 ) )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        function_bc4c01fe510bb495( streakinfo );
        return;
    }
    
    startpos = targetpos + ( 0, 0, 4000 ) - anglestoforward( self.angles ) * 0;
    deliverydrone = createhelperdrone( startpos, self.angles, streakinfo.streakname, streakinfo );
    
    if ( !isdefined( deliverydrone ) )
    {
        return;
    }
    
    function_bc4c01fe510bb495( streakinfo );
    deliverydrone.deliverytarget = targetpos;
    deliverydrone.ondelivercallback = ondelivercallback;
    thread starthelperdrone( deliverydrone );
    return deliverydrone;
}

// Namespace helper_drone
// Params 0
// Checksum 0x8e659638, Offset: 0x9141
// Size: 0x209
function function_ac97a26ccd31c134()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    interferencefrac = 0;
    self.oobdistortion = 0;
    var_e5e5275a9a4c68ba = 0;
    touchingtrigger = undefined;
    
    while ( true )
    {
        if ( isdefined( level.outofboundstriggers ) )
        {
            self.oobdistortion = 0;
            
            foreach ( trigger in level.outofboundstriggers )
            {
                if ( self istouching( trigger ) )
                {
                    if ( isdefined( trigger.script_team ) && self.team != trigger.script_team )
                    {
                        continue;
                    }
                    
                    self.oobdistortion = 1;
                    touchingtrigger = trigger;
                    
                    if ( var_e5e5275a9a4c68ba && ( !isdefined( self.oobtriggers ) || self.oobtriggers.size == 0 ) )
                    {
                        var_e5e5275a9a4c68ba = 0;
                    }
                    
                    break;
                }
            }
            
            if ( self.oobdistortion )
            {
                interferencefrac += 1 * level.framedurationseconds;
                
                if ( !var_e5e5275a9a4c68ba && isdefined( touchingtrigger ) )
                {
                    if ( utility::issharedfuncdefined( #"game", #"onenteroobtrigger" ) )
                    {
                        [[ utility::getsharedfunc( #"game", #"onenteroobtrigger" ) ]]( touchingtrigger, self );
                    }
                    
                    var_e5e5275a9a4c68ba = 1;
                }
            }
            else
            {
                interferencefrac -= 2 * level.framedurationseconds;
                
                if ( var_e5e5275a9a4c68ba && isdefined( touchingtrigger ) )
                {
                    var_e5e5275a9a4c68ba = 0;
                    touchingtrigger = undefined;
                }
            }
            
            interferencefrac = clamp( interferencefrac, 0, 0.5 );
            self.owner setclientomnvar( "ui_out_of_range", interferencefrac );
        }
        
        waitframe();
    }
}

// Namespace helper_drone
// Params 1
// Checksum 0x248d1d1f, Offset: 0x9352
// Size: 0x74
function function_cdb02c8d3e1593c0( helperdronetype )
{
    isremotecontrolhelper = 0;
    
    switch ( helperdronetype )
    {
        case #"hash_76e78a4e69f5d4f7":
        case #"hash_8ef5b52c9e784884":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_b73c57d747ce4083":
        case #"hash_bc14c03f08cfdfbd":
        case #"hash_e40585107590f016":
            isremotecontrolhelper = 1;
            break;
    }
    
    return isremotecontrolhelper;
}

// Namespace helper_drone
// Params 1
// Checksum 0x1cb6d298, Offset: 0x93cf
// Size: 0x2c
function helperdrone_giveplayerfauxremote( streakinfo )
{
    self endon( #"disconnect" );
    player::setusingremote( streakinfo.streakname, 1 );
}

// Namespace helper_drone
// Params 1
// Checksum 0xc0f42d4d, Offset: 0x9403
// Size: 0x4a
function helperdrone_takeplayerfauxremote( streakinfo )
{
    player::clearusingremote( 1 );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    objweapon = makeweapon( "ks_remote_drone_mp" );
    
    if ( self hasweapon( objweapon ) )
    {
        thread inventory_utility::getridofweapon( objweapon );
    }
}

// Namespace helper_drone
// Params 2
// Checksum 0x529bc37f, Offset: 0x9455
// Size: 0x24e
function helperdrone_canseetarget( target, inautopilot )
{
    icansee = 0;
    useorigin = self.owner getvieworigin();
    
    if ( inautopilot )
    {
        useorigin = self.origin;
    }
    
    if ( isdefined( target.recondronetracecontents ) )
    {
        contents = target.recondronetracecontents;
    }
    else
    {
        contents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    }
    
    defaultorigin = target.origin;
    
    if ( isdefined( target.recondronetraceoffset ) )
    {
        defaultorigin += target.recondronetraceoffset;
    }
    
    tracepoints = [ defaultorigin ];
    
    if ( isplayer( target ) )
    {
        headpos = target utility::function_f02ebab438642e16();
        centerpos = target utility::function_68061c3d21a6d57a();
        tracepoints = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( target ) )
    {
        tracepoints = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    ignorelist = [ self ];
    
    if ( !isstruct( target ) )
    {
        ignorelist[ ignorelist.size ] = target;
    }
    
    vehicle = target vehicle::get_vehicle();
    
    if ( isdefined( vehicle ) )
    {
        ignorelist[ ignorelist.size ] = vehicle;
        vehiclechildren = vehicle getlinkedchildren( 1 );
        
        foreach ( child in vehiclechildren )
        {
            ignorelist[ ignorelist.size ] = vehicle;
        }
    }
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( useorigin, tracepoints[ i ], ignorelist, contents ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace helper_drone
// Params 0
// Checksum 0xf0bfd645, Offset: 0x96ac
// Size: 0x3c, Type: bool
function ishelperdrone()
{
    if ( isdefined( level.helperdronesettings ) )
    {
        if ( isdefined( self.streakinfo ) )
        {
            return isdefined( level.helperdronesettings[ self.streakinfo.streakname ] );
        }
    }
    
    return false;
}

// Namespace helper_drone
// Params 1
// Checksum 0xd0495e76, Offset: 0x96f1
// Size: 0x47, Type: bool
function function_91d1cd88e72287( weapon )
{
    return weapon.basename == "ks_remote_drone_mp" || weapon.basename == "ks_assault_drone_mp" || weapon.basename == "ks_assault_drone_cp";
}

// Namespace helper_drone
// Params 1
// Checksum 0xb680a2a9, Offset: 0x9741
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace helper_drone
// Params 1
// Checksum 0x1cceb6fd, Offset: 0x9760
// Size: 0x4b
function helperdrone_empapplied( data )
{
    config = level.helperdronesettings[ self.helperdronetype ];
    
    if ( isdefined( config.empfunc ) )
    {
        self [[ config.empfunc ]]( data );
    }
}

/#

    // Namespace helper_drone
    // Params 0
    // Checksum 0xac9e1de, Offset: 0x97b3
    // Size: 0xe1, Type: dev
    function function_4272ee1d39da148c()
    {
        self endon( #"death" );
        self endon( #"hit_goal" );
        self notify( #"hash_4313ff7eb60fc78b" );
        self endon( #"hash_4313ff7eb60fc78b" );
        
        while ( true )
        {
            nodepath = getnodesonpath( self.owner.origin, self.origin );
            
            if ( isdefined( nodepath ) )
            {
                for ( i = 0; i < nodepath.size ; i++ )
                {
                    if ( isdefined( nodepath[ i + 1 ] ) )
                    {
                        line( nodepath[ i ].origin + ( 0, 0, 80 ), nodepath[ i + 1 ].origin + ( 0, 0, 80 ), ( 1, 0, 0 ) );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
