// scripts\mp\common\killstreaks\toma_strike.gsc  (hash_50689c1d9e3ef00a.gscc) (size: 39028 Bytes / 0x9874 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9081140 (4178055488)
// size ...... 39028 (0x9874)
// includes .. 12  (offset: 0x9248)
// strings ... 78  (offset: 0x92a8)
// dev strs .. 11  (offset: 0x97f0)
// exports ... 85  (offset: 0x664c)
// cseg ...... 0x601 + 0x604b (0x664c)
// imports ... 230 (offset: 0x7394)
// animtree1 . 0   (offset: 0x9874)
// animtree2 . 0   (offset: 0x9874)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\objidpoolmanager;

#namespace toma_strike;

// Namespace toma_strike
// Params 4
// Checksum 0x2c3781d8, Offset: 0x61f
// Size: 0x3d
function function_fa2d3c85e0485e01( var_65246a83e689f027, dvar_str, bundle_val, default_val )
{
    function_a016aad7fcd3132f( var_65246a83e689f027, dvar_str, bundle_val, default_val, #"int" );
}

// Namespace toma_strike
// Params 4
// Checksum 0x482d159a, Offset: 0x664
// Size: 0x3d
function function_c8fb055aea67850a( var_65246a83e689f027, dvar_str, bundle_val, default_val )
{
    function_a016aad7fcd3132f( var_65246a83e689f027, dvar_str, bundle_val, default_val, #"float" );
}

// Namespace toma_strike
// Params 5
// Checksum 0x4d48bea, Offset: 0x6a9
// Size: 0x65
function function_a016aad7fcd3132f( var_65246a83e689f027, dvar_str, bundle_val, default_val, value_type )
{
    level.var_c78c69f53f3a8f4e[ var_65246a83e689f027 ] = function_43c2d5456991f187( dvar_str, bundle_val, default_val );
    
    if ( isdefined( value_type ) )
    {
        level.var_c78c69f53f3a8f4e[ var_65246a83e689f027 ].type = value_type;
    }
}

// Namespace toma_strike
// Params 3
// Checksum 0x52e52fb4, Offset: 0x716
// Size: 0x7c
function function_43c2d5456991f187( dvar_str, bundle_val, default_val )
{
    var_38dca6af9a1f0358 = spawnstruct();
    
    if ( isdefined( dvar_str ) )
    {
        var_38dca6af9a1f0358.dvarstr = dvar_str;
    }
    
    if ( isdefined( bundle_val ) )
    {
        var_38dca6af9a1f0358.bundle_val = bundle_val;
    }
    
    if ( isdefined( default_val ) )
    {
        var_38dca6af9a1f0358.default_val = default_val;
    }
    else
    {
        var_38dca6af9a1f0358.default_val = 0;
    }
    
    return var_38dca6af9a1f0358;
}

// Namespace toma_strike
// Params 1
// Checksum 0x53edc146, Offset: 0x79b
// Size: 0xe7
function function_857af6ad64793086( var_65246a83e689f027 )
{
    var_38dca6af9a1f0358 = level.var_c78c69f53f3a8f4e[ var_65246a83e689f027 ];
    
    if ( !isdefined( var_38dca6af9a1f0358 ) )
    {
        return 0;
    }
    
    if ( isdefined( var_38dca6af9a1f0358.bundle_val ) )
    {
        return var_38dca6af9a1f0358.bundle_val;
    }
    
    if ( !( isdefined( var_38dca6af9a1f0358.dvarstr ) && isdefined( var_38dca6af9a1f0358.type ) ) )
    {
        return var_38dca6af9a1f0358.default_val;
    }
    
    if ( var_38dca6af9a1f0358.type == #"float" )
    {
        return getdvarfloat( var_38dca6af9a1f0358.dvarstr, var_38dca6af9a1f0358.default_val );
    }
    else if ( var_38dca6af9a1f0358.type == #"int" )
    {
        return getdvarint( var_38dca6af9a1f0358.dvarstr, var_38dca6af9a1f0358.default_val );
    }
    
    return var_38dca6af9a1f0358.default_val;
}

// Namespace toma_strike
// Params 0
// Checksum 0xa1d8efa3, Offset: 0x88b
// Size: 0xcb
function init()
{
    if ( utility::issharedfuncdefined( #"toma_strike", #"init" ) )
    {
        [[ utility::getsharedfunc( #"toma_strike", #"init" ) ]]();
    }
    
    level.toma_strikes = [];
    level.toma_strikes_count = 0;
    level.var_c34a57306e2957dd = getdvarint( @"scr_toma_strike_notify_time", 0 );
    init_toma_strike_vo();
    function_c94dd818d01b8e41();
    init_toma_strike_dvars();
    bundle = level.streakglobals.streakbundles[ "toma_strike" ];
    
    /#
        setdevdvarifuninitialized( @"scr_toma_strike_type", 0 );
        setdevdvarifuninitialized( @"hash_604652367665c1e0", 1 );
    #/
    
    utility::flag_set( "toma_strike_initialized" );
}

// Namespace toma_strike
// Params 0
// Checksum 0x2a7403ce, Offset: 0x95e
// Size: 0x5f
function init_toma_strike_vo()
{
    game[ "dialog" ][ "toma_strike" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "toma_strike" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "toma_strike" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace toma_strike
// Params 0
// Checksum 0x5bab9e81, Offset: 0x9c5
// Size: 0x45
function function_c94dd818d01b8e41()
{
    level.var_199beb4f90307ec8 = "toma_strike_placement";
    val::group_register( level.var_199beb4f90307ec8, [ "offhand_weapons", "melee", "execution_attack", "weapon_pickup" ] );
}

// Namespace toma_strike
// Params 1
// Checksum 0x9414be2f, Offset: 0xa12
// Size: 0x48d
function init_toma_strike_params( var_28ed962522598df3 )
{
    bundle = killstreak::function_85b2d8e857ab4898( "toma_strike" ) ?? { #toma_weapon_name:undefined };
    level.toma_weapon_name = bundle.toma_weapon_name ?? "toma_proj_mp";
    
    if ( var_28ed962522598df3 == 1 )
    {
        function_fa2d3c85e0485e01( #"selection_radius", @"scr_toma_strike_radius", bundle.toma_selection_radius, 900 );
        function_fa2d3c85e0485e01( #"launch_delay", @"scr_toma_strike_delay", bundle.toma_launch_delay, 5 );
        function_fa2d3c85e0485e01( #"num_waves", @"scr_num_toma_waves", bundle.toma_waves, 4 );
        function_fa2d3c85e0485e01( #"hash_3082f1a04b68416a", @"hash_9d9d004060864d1f", bundle.toma_payload_per_wave, 4 );
        function_c8fb055aea67850a( #"min_time_per_wave", @"scr_min_time_per_wave", bundle.toma_min_time_per_wave, 3.25 );
        function_c8fb055aea67850a( #"max_time_per_wave", @"scr_max_time_per_wave", bundle.toma_max_time_per_wave, 4 );
        function_c8fb055aea67850a( #"min_time_per_payload", @"scr_min_time_per_payload", bundle.toma_min_time_per_payload, 0.5 );
        function_c8fb055aea67850a( #"max_time_per_payload", @"scr_max_time_per_payload", bundle.toma_max_time_per_payload, 0.75 );
        function_c8fb055aea67850a( #"missile_travel_time", @"scr_toma_strike_travel_time", bundle.toma_missile_travel_time, 4 );
        return;
    }
    
    if ( var_28ed962522598df3 == 2 )
    {
        function_fa2d3c85e0485e01( #"selection_radius", @"scr_toma_strike_radius", bundle.toma_selection_radius, 50 );
        function_fa2d3c85e0485e01( #"launch_delay", @"scr_toma_strike_delay", bundle.toma_launch_delay, 0 );
        function_fa2d3c85e0485e01( #"num_waves", @"scr_num_toma_waves", bundle.toma_waves, 1 );
        function_fa2d3c85e0485e01( #"hash_3082f1a04b68416a", @"hash_9d9d004060864d1f", bundle.toma_payload_per_wave, 14 );
        function_c8fb055aea67850a( #"min_time_per_wave", @"scr_min_time_per_wave", bundle.toma_min_time_per_wave, 3.25 );
        function_c8fb055aea67850a( #"max_time_per_wave", @"scr_max_time_per_wave", bundle.toma_max_time_per_wave, 4 );
        function_c8fb055aea67850a( #"min_time_per_payload", @"scr_min_time_per_payload", bundle.toma_min_time_per_payload, 0.2 );
        function_c8fb055aea67850a( #"max_time_per_payload", @"scr_max_time_per_payload", bundle.toma_max_time_per_payload, 0.8 );
        function_c8fb055aea67850a( #"missile_travel_time", @"scr_toma_strike_travel_time", bundle.toma_missile_travel_time, 1.5 );
        return;
    }
    
    function_fa2d3c85e0485e01( #"selection_radius", @"scr_toma_strike_radius", bundle.toma_selection_radius, 450 );
    function_fa2d3c85e0485e01( #"launch_delay", @"scr_toma_strike_delay", bundle.toma_launch_delay, 2 );
    function_fa2d3c85e0485e01( #"num_waves", @"scr_num_toma_waves", bundle.toma_waves, 4 );
    function_fa2d3c85e0485e01( #"hash_3082f1a04b68416a", @"hash_9d9d004060864d1f", bundle.toma_payload_per_wave, 4 );
    function_c8fb055aea67850a( #"min_time_per_wave", @"scr_min_time_per_wave", bundle.toma_min_time_per_wave, 3.25 );
    function_c8fb055aea67850a( #"max_time_per_wave", @"scr_max_time_per_wave", bundle.toma_max_time_per_wave, 4 );
    function_c8fb055aea67850a( #"min_time_per_payload", @"scr_min_time_per_payload", bundle.toma_min_time_per_payload, 0.5 );
    function_c8fb055aea67850a( #"max_time_per_payload", @"scr_max_time_per_payload", bundle.toma_max_time_per_payload, 0.75 );
    function_c8fb055aea67850a( #"missile_travel_time", @"scr_toma_strike_travel_time", bundle.toma_missile_travel_time, 4 );
}

// Namespace toma_strike
// Params 0
// Checksum 0xa9ac9be, Offset: 0xea7
// Size: 0xbe
function init_toma_strike_dvars()
{
    setdvarifuninitialized( @"scr_toma_strike_type", 0 );
    setdvarifuninitialized( @"scr_toma_strike_radius", 450 );
    setdvarifuninitialized( @"scr_toma_strike_delay", 2 );
    setdvarifuninitialized( @"hash_3417b331cd0f5b4f", 6 );
    setdvarifuninitialized( @"scr_num_toma_waves", 4 );
    setdvarifuninitialized( @"hash_9d9d004060864d1f", 4 );
    setdvarifuninitialized( @"scr_min_time_per_wave", 3.25 );
    setdvarifuninitialized( @"scr_max_time_per_wave", 4 );
    setdvarifuninitialized( @"scr_min_time_per_payload", 0.5 );
    setdvarifuninitialized( @"scr_max_time_per_payload", 0.75 );
    setdvarifuninitialized( @"scr_toma_strike_travel_time", 4 );
}

// Namespace toma_strike
// Params 1
// Checksum 0xfc14a39e, Offset: 0xf6d
// Size: 0x2a0
function set_toma_strike_dvars( var_1b589287e785c19 )
{
    var_28ed962522598df3 = getdvarint( @"scr_toma_strike_type", 0 );
    
    if ( var_28ed962522598df3 == var_1b589287e785c19 )
    {
        return;
    }
    
    if ( var_1b589287e785c19 == 0 )
    {
        setdvar( @"scr_toma_strike_type", 0 );
        setdvar( @"scr_toma_strike_radius", 450 );
        setdvar( @"scr_toma_strike_delay", 2 );
        setdvar( @"hash_3417b331cd0f5b4f", 6 );
        setdvar( @"scr_num_toma_waves", 4 );
        setdvar( @"hash_9d9d004060864d1f", 4 );
        setdvar( @"scr_min_time_per_wave", 3.25 );
        setdvar( @"scr_max_time_per_wave", 4 );
        setdvar( @"scr_min_time_per_payload", 0.5 );
        setdvar( @"scr_max_time_per_payload", 0.75 );
        setdvar( @"scr_toma_strike_travel_time", 4 );
    }
    else if ( var_1b589287e785c19 == 1 )
    {
        setdvar( @"scr_toma_strike_type", 1 );
        setdvar( @"scr_toma_strike_radius", 900 );
        setdvar( @"scr_toma_strike_delay", 5 );
        setdvar( @"hash_3417b331cd0f5b4f", 6 );
        setdvar( @"scr_num_toma_waves", 4 );
        setdvar( @"hash_9d9d004060864d1f", 4 );
        setdvar( @"scr_min_time_per_wave", 3.25 );
        setdvar( @"scr_max_time_per_wave", 4 );
        setdvar( @"scr_min_time_per_payload", 0.5 );
        setdvar( @"scr_max_time_per_payload", 0.75 );
        setdvar( @"scr_toma_strike_travel_time", 4 );
    }
    else if ( var_1b589287e785c19 == 2 )
    {
        setdvar( @"scr_toma_strike_type", 2 );
        setdvar( @"scr_toma_strike_radius", 50 );
        setdvar( @"scr_toma_strike_delay", 0 );
        setdvar( @"hash_3417b331cd0f5b4f", 14 );
        setdvar( @"scr_num_toma_waves", 1 );
        setdvar( @"hash_9d9d004060864d1f", 14 );
        setdvar( @"scr_min_time_per_wave", 3.25 );
        setdvar( @"scr_max_time_per_wave", 4 );
        setdvar( @"scr_min_time_per_payload", 0.2 );
        setdvar( @"scr_max_time_per_payload", 0.8 );
        setdvar( @"scr_toma_strike_travel_time", 1.5 );
    }
    
    self.var_ca5dd26ab39d925b = function_857af6ad64793086( #"missile_travel_time" ) - 0.075;
}

// Namespace toma_strike
// Params 1
// Checksum 0x5fe513f1, Offset: 0x1215
// Size: 0x3d, Type: bool
function trytomastriketriggered( streakinfo )
{
    streakname = streakinfo.streakname;
    var_28ed962522598df3 = getdvarint( @"scr_toma_strike_type", 0 );
    return true;
}

// Namespace toma_strike
// Params 0
// Checksum 0xfb2c0494, Offset: 0x125b
// Size: 0xd3
function gettimeremaining()
{
    shortestleft = undefined;
    
    foreach ( strike in level.toma_strikes )
    {
        timeleft = int( max( 1, strike.starttimems + strike.totaltimesec * 1000 - gettime() ) );
        
        if ( !isdefined( shortestleft ) || timeleft < shortestleft )
        {
            shortestleft = timeleft;
        }
    }
    
    return int( utility::function_6f5d2e1f1ff70482( shortestleft ) ) + 1;
}

// Namespace toma_strike
// Params 1
// Checksum 0x11d85307, Offset: 0x1337
// Size: 0x22, Type: bool
function weapongiventomastrike( streakinfo )
{
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_using_clusterstrike", 1 );
    }
    
    return true;
}

// Namespace toma_strike
// Params 3
// Checksum 0xbe9de942, Offset: 0x1362
// Size: 0x242
function weaponfiredtomastrike( streakinfo, firedweaponobj, firedprojectile )
{
    if ( !isdefined( streakinfo.targetoverride ) )
    {
        mappoint = tomastrike_getownerlookat( self, streakinfo );
        
        if ( !isdefined( mappoint ) )
        {
            utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/INVALID_POINT" );
            utility::callsharedfunc( #"toma_strike", #"invalidtargetposition" );
            return "continue";
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_3687f10503075830" ) )
        {
            if ( !self [[ utility::getsharedfunc( #"killstreak", #"hash_3687f10503075830" ) ]]( mappoint ) )
            {
                utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/INVALID_POINT" );
                utility::callsharedfunc( #"toma_strike", #"invalidtargetposition" );
                return "continue";
            }
        }
        
        if ( streakinfo.markers.size == 0 )
        {
            bundle = streakinfo.bundle;
            
            if ( bundle.var_8771a3dbfc3b5dbe && !namespace_9d8e359c3b1041e5::function_99585ce0ed7d5df7( streakinfo, mappoint ) )
            {
                return "continue";
            }
        }
    }
    
    if ( namespace_9d8e359c3b1041e5::is_empdsharedfunc() )
    {
        utility::callsharedfunc( #"hud", #"showerrormessage", %"killstreaks/cannot_be_used" );
        return "continue";
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_using_clusterstrike", 0 );
    }
    
    marker = toma_strike_createmarker( streakinfo, mappoint );
    streakinfo.markers[ streakinfo.markers.size ] = marker;
    thread function_2bb2540764ac76b6( streakinfo );
    
    if ( streakinfo.markers.size < streakinfo.var_6d32ae6f8cb439d4 )
    {
        return "continue";
    }
    
    utility::callsharedfunc( #"sound", #"playkillstreakdeploydialog", streakinfo.streakname );
    thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_use", #"use", 1, 2 );
    self notify( #"hash_b29435a3a44b69f0" );
    return "success";
}

// Namespace toma_strike
// Params 1
// Checksum 0xe558ff2d, Offset: 0x15ad
// Size: 0xd3
function function_2bb2540764ac76b6( streakinfo )
{
    self notify( #"hash_198545284e4a3932" );
    self endon( #"hash_198545284e4a3932" );
    self endon( #"hash_b29435a3a44b69f0" );
    utility::waittill_any_ents( self, "death", self, "disconnect", self, "weapon_change", level, "game_ended" );
    
    foreach ( marker in streakinfo.markers )
    {
        marker notify( #"hash_4c1a49a027c1b272", "killstreak_cancelled" );
    }
}

// Namespace toma_strike
// Params 0
// Checksum 0xf66d8bd7, Offset: 0x1688
// Size: 0x22
function tryusetomastrike()
{
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "toma_strike", self );
    return tryusetomastrikefromstruct( streakinfo );
}

// Namespace toma_strike
// Params 1
// Checksum 0x2d96cd02, Offset: 0x16b3
// Size: 0x30b, Type: bool
function tryusetomastrikefromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    var_28ed962522598df3 = function_2828cb52fc7c81ef();
    init_toma_strike_params( var_28ed962522598df3 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_8c6567a01fb8c81a" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_8c6567a01fb8c81a" ) ]]( streakinfo );
    }
    
    streakinfo.var_6d32ae6f8cb439d4 = streakinfo.bundle.var_36b9f21e3007a8b4;
    streakinfo.markers = [];
    
    if ( var_28ed962522598df3 == 1 && isdefined( self.kstargetlocation ) )
    {
        streakinfo.targetoverride = self.kstargetlocation;
        streakinfo.striketype = var_28ed962522598df3;
        self.kstargetlocation = undefined;
        firedresult = weaponfiredtomastrike( streakinfo, undefined, undefined );
        
        if ( firedresult != "success" )
        {
            return false;
        }
    }
    else
    {
        if ( isdefined( level.var_199beb4f90307ec8 ) )
        {
            streakinfo.var_21f1b0b4d8d3ea8f = level.var_199beb4f90307ec8;
        }
        
        deployweaponname = streakinfo.bundle.deployweaponname ?? "iw9_laser_large_ir_mp";
        deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweaponfireddeploysharedfunc( streakinfo, makeweapon( deployweaponname ), "weapon_fired", &weapongiventomastrike, &function_5b3c77949b8996d7, &weaponfiredtomastrike );
        
        if ( !deployresult )
        {
            if ( isbrgamemode() )
            {
                self setclientomnvar( "ui_using_clusterstrike", 0 );
            }
            
            streakinfo notify( #"toma_strike_canceled" );
            
            if ( utility::issharedfuncdefined( #"killstreak", #"hash_7af048d104650b20" ) )
            {
                self thread [[ utility::getsharedfunc( #"killstreak", #"hash_7af048d104650b20" ) ]]( streakinfo );
            }
            
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_764fee55301f33f3" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"hash_764fee55301f33f3" ) ]]();
    }
    
    streakinfo.streakduration = 20;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    self.var_e73f627a785541a2[ streakinfo.streakname ] = 0;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_toma_strike", self );
    }
    
    utility::callsharedfunc( #"killstreak", #"logkillstreakevent", streakinfo.streakname, self.origin );
    starttomastrike( var_28ed962522598df3, streakinfo );
    
    if ( isbrgamemode() )
    {
        self.var_6a87b5d2e21d59be = gettime();
    }
    
    return true;
}

// Namespace toma_strike
// Params 0
// Checksum 0xf96ff3ee, Offset: 0x19c7
// Size: 0x62
function function_2828cb52fc7c81ef()
{
    var_28ed962522598df3 = getdvarint( @"scr_toma_strike_type", 0 );
    
    if ( isbrgamemode() && isplayer( self ) )
    {
        var_28ed962522598df3 = 1;
        set_toma_strike_dvars( var_28ed962522598df3 );
    }
    else if ( isagent( self ) )
    {
        var_28ed962522598df3 = 2;
        set_toma_strike_dvars( var_28ed962522598df3 );
    }
    else
    {
        var_28ed962522598df3 = 0;
    }
    
    set_toma_strike_dvars( var_28ed962522598df3 );
    return var_28ed962522598df3;
}

// Namespace toma_strike
// Params 6
// Checksum 0xbd48e02b, Offset: 0x1a32
// Size: 0x196
function function_bc1265319f0001e1( target, var_b9f13b776244947c, var_756626aaf0ce5668, var_6f50b012a8dd6332, var_89ba4f440f386ce, launchdelayoverride )
{
    self endon( #"death_or_disconnect" );
    var_28ed962522598df3 = function_2828cb52fc7c81ef();
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "toma_strike", self );
    init_toma_strike_params( var_28ed962522598df3 );
    
    if ( var_28ed962522598df3 == 2 )
    {
        if ( isdefined( var_756626aaf0ce5668 ) )
        {
            if ( isplayer( target ) && isdefined( target.vehicle ) && isdefined( target.vehicle vehicle::get_ref() ) )
            {
                setdvar( @"scr_toma_strike_travel_time", var_756626aaf0ce5668.vehiclesetting );
                self.var_ca5dd26ab39d925b = var_756626aaf0ce5668.vehiclesetting - 0.075;
            }
            else
            {
                setdvar( @"scr_toma_strike_travel_time", var_756626aaf0ce5668.walksetting );
                self.var_ca5dd26ab39d925b = var_756626aaf0ce5668.walksetting - 0.075;
            }
        }
    }
    
    tomaid = function_6b4303b8a0349775();
    streakinfo.var_6f50b012a8dd6332 = var_6f50b012a8dd6332;
    streakinfo.var_89ba4f440f386ce = var_89ba4f440f386ce;
    streakinfo.launchdelayoverride = launchdelayoverride;
    streakinfo.var_b9f13b776244947c = var_b9f13b776244947c;
    level.toma_strikes[ tomaid ] = self;
    function_559b67e08ba0b55c( tomaid, var_28ed962522598df3, target );
    tomastrike_attacktarget( var_28ed962522598df3, undefined, target, streakinfo, tomaid );
    level.toma_strikes[ tomaid ] = undefined;
}

// Namespace toma_strike
// Params 2
// Checksum 0x3f963bee, Offset: 0x1bd0
// Size: 0x14f
function starttomastrike( striketype, streakinfo )
{
    tomaid = function_6b4303b8a0349775();
    function_559b67e08ba0b55c( tomaid, striketype );
    thread tomastrike_watchgameend( tomaid, streakinfo );
    thread function_97186af8813e4508( tomaid, streakinfo );
    thread function_44a65df9c1a20b24( tomaid, streakinfo );
    
    foreach ( marker in streakinfo.markers )
    {
        thread tomastrike_attacktarget( striketype, undefined, marker, streakinfo, tomaid );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    
    if ( utility::issharedfuncdefined( #"toma_strike", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"toma_strike", #"munitionused" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, "tomaStrikeUsed" );
    }
}

// Namespace toma_strike
// Params 2
// Checksum 0x44ac1564, Offset: 0x1d27
// Size: 0x165
function tomastrike_getownerlookat( owner, streakinfo )
{
    if ( utility::issharedfuncdefined( #"game", #"gettracecontents" ) )
    {
        content = [[ utility::getsharedfunc( #"game", #"gettracecontents" ) ]]( #"toma_strike" );
    }
    else
    {
        content = [ "physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy" ];
    }
    
    contentoverride = physics_createcontents( content );
    starttrace = owner getvieworigin();
    
    if ( owner getcamerathirdperson() )
    {
        starttrace = owner getcamerathirdpersonorigin();
    }
    
    endtrace = starttrace + anglestoforward( owner getplayerangles() ) * ( streakinfo.tracemaxdist ?? 50000 );
    ignoreents = owner namespace_9d8e359c3b1041e5::playerkillstreakgetownerlookatignoreentssharedfunc();
    
    if ( streakinfo.var_8c2e877a905d558d )
    {
        trace = trace::ray_trace_detail( starttrace, endtrace, ignoreents, contentoverride );
    }
    else
    {
        trace = trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
    }
    
    endpos = undefined;
    
    if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
    {
        endpos = trace[ "position" ];
    }
    
    return endpos;
}

// Namespace toma_strike
// Params 0
// Checksum 0x98a068c2, Offset: 0x1e95
// Size: 0x6d
function function_6b4303b8a0349775()
{
    level.toma_strikes_count++;
    
    if ( getdvarint( @"scr_toma_strike_type", 0 ) == 2 )
    {
        return ( self getentitynumber() + "_" + level.toma_strikes_count );
    }
    
    if ( isplayer( self ) )
    {
        return ( self getxuid() + "_" + level.toma_strikes_count );
    }
    
    return self getentitynumber() + "_" + level.toma_strikes_count;
}

// Namespace toma_strike
// Params 2
// Checksum 0xd83bf1d8, Offset: 0x1f0a
// Size: 0x6e
function tomastrike_watchgameend( tomaid, streakinfo )
{
    level endon( "toma_strike_clean_up_" + tomaid );
    level waittill( #"game_ended" );
    
    if ( self && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
}

// Namespace toma_strike
// Params 2
// Checksum 0xbc7177ec, Offset: 0x1f80
// Size: 0xcd
function function_97186af8813e4508( tomaid, streakinfo )
{
    level endon( #"game_ended" );
    level thread function_5b6dccd0187356d2( "disconnect", tomaid, self );
    level thread function_5b6dccd0187356d2( "joined_team", tomaid, self );
    level thread function_5b6dccd0187356d2( "toma_strike_finished_" + tomaid, tomaid );
    level waittill( "toma_strike_clean_up_" + tomaid );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"tomastrikeendfunc" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"tomastrikeendfunc" ) ]]();
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( isdefined( self ) )
    {
        namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
    }
    
    level.toma_strikes[ tomaid ] = undefined;
}

// Namespace toma_strike
// Params 3
// Checksum 0x96c03b68, Offset: 0x2055
// Size: 0x51
function function_5b6dccd0187356d2( actionnotify, tomaid, player )
{
    level endon( "toma_strike_clean_up_" + tomaid );
    notifyobject = level;
    
    if ( isdefined( player ) )
    {
        notifyobject = player;
    }
    
    notifyobject waittill( actionnotify );
    level notify( "toma_strike_clean_up_" + tomaid );
}

// Namespace toma_strike
// Params 2
// Checksum 0xeef9e4bf, Offset: 0x20ae
// Size: 0x1e0
function function_44a65df9c1a20b24( tomaid, streakinfo )
{
    level endon( #"game_ended" );
    self notify( #"toma_strike_watch_kills" );
    self endon( #"toma_strike_watch_kills" );
    self.var_3800574a3cb43b1a = 0;
    childthread function_9dab37234ee110bb( tomaid );
    childthread function_55dc0a87618f089d( tomaid );
    level waittill( "toma_strike_finished_" + tomaid );
    
    if ( isdefined( self ) )
    {
        played = 0;
        
        if ( self.var_3800574a3cb43b1a == 3 )
        {
            played = namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_hit_target", #"kill_3", 1 );
        }
        
        if ( !played && self.var_3800574a3cb43b1a == 2 )
        {
            played = namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_hit_target", #"kill_2", 1 );
        }
        
        if ( !played && self.var_3800574a3cb43b1a == 1 )
        {
            played = namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_hit_target", #"kill_1", 1 );
        }
        
        if ( !played && self.var_3800574a3cb43b1a > 1 )
        {
            played = namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_hit_target", #"kill_multi", 1 );
        }
        
        if ( !played && self.var_3800574a3cb43b1a >= 1 )
        {
            played = namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_hit_target", #"hit", 1 );
        }
        
        var_e0b2621941054a4f = 0;
        
        if ( !played && var_e0b2621941054a4f )
        {
            namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_hit_damage", #"hit", 1 );
            return;
        }
        
        if ( self.var_3800574a3cb43b1a == 0 )
        {
            namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, "toma_strike" + "_miss_target", #"miss", 1 );
        }
    }
}

// Namespace toma_strike
// Params 1
// Checksum 0x82a3bc0d, Offset: 0x2296
// Size: 0x65
function function_9dab37234ee110bb( tomaid )
{
    level endon( "toma_strike_finished_" + tomaid );
    
    while ( isdefined( self ) )
    {
        self waittill( #"update_rapid_kill_buffered", recentkillcount, var_95795539e2a8343 );
        
        if ( isstring( var_95795539e2a8343 ) && var_95795539e2a8343 == level.toma_weapon_name )
        {
            self.var_3800574a3cb43b1a++;
        }
    }
}

// Namespace toma_strike
// Params 1
// Checksum 0x528956b1, Offset: 0x2303
// Size: 0x5b
function function_55dc0a87618f089d( tomaid )
{
    level endon( "toma_strike_finished_" + tomaid );
    
    while ( isdefined( self ) )
    {
        self waittill( #"update_rapid_agent_kill_buffered", recentkillcount, var_bda53394c108f2e );
        
        if ( var_bda53394c108f2e == level.toma_weapon_name )
        {
            self.var_3800574a3cb43b1a++;
        }
    }
}

// Namespace toma_strike
// Params 3
// Checksum 0x205e6c68, Offset: 0x2366
// Size: 0x376
function function_559b67e08ba0b55c( tomaid, striketype, target )
{
    level.toma_strikes[ tomaid ] = spawnstruct();
    level.toma_strikes[ tomaid ].starttimems = gettime();
    level.toma_strikes[ tomaid ].totaltimesec = function_857af6ad64793086( #"launch_delay" );
    level.toma_strikes[ tomaid ].strikedelay = [];
    explosiontype = getdvarint( @"hash_604652367665c1e0", 1 );
    var_c89ed29a58a1c345 = function_857af6ad64793086( #"num_waves" );
    var_c11b16cce6cf81ee = function_857af6ad64793086( #"hash_3082f1a04b68416a" );
    var_c3dc6dc0fbcf4017 = function_857af6ad64793086( #"min_time_per_wave" );
    var_afeaad0d882fca6d = function_857af6ad64793086( #"max_time_per_wave" );
    var_a4db596a495f0704 = function_857af6ad64793086( #"min_time_per_payload" );
    var_c9bade25e3dc4c62 = function_857af6ad64793086( #"max_time_per_payload" );
    
    if ( explosiontype == 1 )
    {
        if ( striketype == 2 )
        {
            if ( isdefined( level.ob.warlordparameters[ "Rainmaker" ] ) )
            {
                var_c11b16cce6cf81ee = level.ob.warlordparameters[ "Rainmaker" ].var_56ee9e92c7925429;
                var_c89ed29a58a1c345 = level.ob.warlordparameters[ "Rainmaker" ].var_3e332114dc548da2;
            }
        }
        
        level.toma_strikes[ tomaid ].wavedelay = [];
        
        for ( i = 0; i < var_c89ed29a58a1c345 ; i++ )
        {
            level.toma_strikes[ tomaid ].strikedelay[ i ] = [];
            
            for ( j = 0; j < var_c11b16cce6cf81ee ; j++ )
            {
                timetowait = var_a4db596a495f0704 == var_c9bade25e3dc4c62 ? var_a4db596a495f0704 : randomfloatrange( var_a4db596a495f0704, var_c9bade25e3dc4c62 );
                level.toma_strikes[ tomaid ].totaltimesec += timetowait;
                level.toma_strikes[ tomaid ].strikedelay[ i ][ j ] = timetowait;
            }
            
            timetowait = var_c3dc6dc0fbcf4017 == var_afeaad0d882fca6d ? var_c3dc6dc0fbcf4017 : randomfloatrange( var_c3dc6dc0fbcf4017, var_afeaad0d882fca6d );
            level.toma_strikes[ tomaid ].totaltimesec += timetowait;
            level.toma_strikes[ tomaid ].wavedelay[ i ] = timetowait;
        }
        
        return;
    }
    
    [ numstrikes, radius ] = function_530c3cfffa0f987a( striketype );
    
    for ( i = 0; i < numstrikes ; i++ )
    {
        timetowait = randomfloatrange( 1.35, 2.5 );
        level.toma_strikes[ tomaid ].totaltimesec += timetowait;
        level.toma_strikes[ tomaid ].strikedelay[ i ] = timetowait;
    }
}

// Namespace toma_strike
// Params 3
// Checksum 0x7af442e6, Offset: 0x26e4
// Size: 0x43
function function_f5823cf9bbfbcb95( tomaid, explosiontype, strikeindex )
{
    assert( explosiontype != 1 );
    return level.toma_strikes[ tomaid ].strikedelay[ strikeindex ];
}

// Namespace toma_strike
// Params 4
// Checksum 0xfda4380c, Offset: 0x2730
// Size: 0x4e
function function_c41014e54d9149b9( tomaid, explosiontype, waveindex, strikeindex )
{
    assert( explosiontype == 1 );
    return level.toma_strikes[ tomaid ].strikedelay[ waveindex ][ strikeindex ];
}

// Namespace toma_strike
// Params 3
// Checksum 0xacf4647d, Offset: 0x2787
// Size: 0x43
function function_26fadce9fa5c822c( tomaid, explosiontype, waveindex )
{
    assert( explosiontype == 1 );
    return level.toma_strikes[ tomaid ].wavedelay[ waveindex ];
}

// Namespace toma_strike
// Params 1
// Checksum 0x964add9a, Offset: 0x27d3
// Size: 0x4b
function function_530c3cfffa0f987a( striketype )
{
    numstrikes = getdvarint( @"hash_3417b331cd0f5b4f" );
    radius = function_857af6ad64793086( #"selection_radius" );
    return [ numstrikes, radius ];
}

// Namespace toma_strike
// Params 1
// Checksum 0xc928710b, Offset: 0x2827
// Size: 0x23
function function_23ee00b330358b3e( tomaid )
{
    return level.toma_strikes[ tomaid ].strikedelay.size;
}

// Namespace toma_strike
// Params 2
// Checksum 0x84ce783d, Offset: 0x2853
// Size: 0x2e
function function_a0d2ac91c1c95a07( tomaid, waveid )
{
    return level.toma_strikes[ tomaid ].strikedelay[ waveid ].size;
}

// Namespace toma_strike
// Params 4
// Checksum 0x762fe236, Offset: 0x288a
// Size: 0x125
function function_55e16bcb3d1a287b( markerorigin, var_147ece74855f6277, ownerforward, ownerright )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "toma_strike" ) ?? spawnstruct();
    
    if ( !bundle.var_fd11cac1749d39b6 || !isdefined( bundle.var_4c3705a00e2cd38a ) )
    {
        return;
    }
    
    if ( isdefined( bundle.var_677dab3dfea67027 ) )
    {
        wait bundle.var_677dab3dfea67027;
    }
    
    launchpos = tomastrike_findoptimallaunchpos( markerorigin, var_147ece74855f6277, ownerforward, ownerright );
    soundpos = length2d( launchpos - self.origin ) * vectornormalize2( launchpos - self.origin ) * 2 + self.origin;
    
    if ( isbrgamemode() )
    {
        playsoundatpos( ( markerorigin[ 0 ], markerorigin[ 1 ], 7000 ), bundle.var_4c3705a00e2cd38a );
        return;
    }
    
    playsoundatpos( ( soundpos[ 0 ], soundpos[ 1 ], 0 ), bundle.var_4c3705a00e2cd38a );
}

// Namespace toma_strike
// Params 5
// Checksum 0xb323afc8, Offset: 0x29b7
// Size: 0x846
function tomastrike_attacktarget( striketype, vehicle, marker, streakinfo, tomaid )
{
    self endon( #"disconnect", #"joined_team" );
    level endon( #"game_ended" );
    marker notify( #"hash_4c1a49a027c1b272", "attackStarted" );
    self notify( #"hash_60733902ed6a2449" );
    
    if ( isdefined( self ) )
    {
        var_c2ecf940026626e0 = level.sharedfuncs[ #"killstreak" ][ #"hash_1fa18935c88e6b0c" ];
        
        if ( isdefined( var_c2ecf940026626e0 ) )
        {
            self [[ var_c2ecf940026626e0 ]]( level.toma_weapon_name );
        }
    }
    
    streakinfo.shots_fired++;
    markerorigin = undefined;
    
    if ( isdefined( marker ) )
    {
        if ( isvector( marker ) )
        {
            markerorigin = marker;
        }
        else
        {
            markerorigin = marker.origin;
        }
    }
    
    numstrikes = getdvarint( @"hash_3417b331cd0f5b4f", 6 );
    radius = function_857af6ad64793086( #"selection_radius" );
    
    if ( isdefined( streakinfo.var_b9f13b776244947c ) )
    {
        radius = streakinfo.var_b9f13b776244947c;
    }
    
    if ( striketype == 1 )
    {
        if ( utility::issharedfuncdefined( #"br", #"challengeevaluator" ) )
        {
            paramstruct = spawnstruct();
            paramstruct.streakinfo = streakinfo;
            paramstruct.targetsite = markerorigin;
            self [[ utility::getsharedfunc( #"br", #"challengeevaluator" ) ]]( "br_mastery_pointBlank_tomahawk", paramstruct );
        }
    }
    
    bundle = streakinfo.bundle;
    launchheight = bundle.var_8c0093bd62972936;
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( self, self.team, radius + 300, streakinfo.streakname, markerorigin, isbrgamemode() ? 6000 : launchheight );
    delaytime = function_857af6ad64793086( #"launch_delay" );
    
    if ( isdefined( streakinfo.launchdelayoverride ) )
    {
        delaytime = streakinfo.launchdelayoverride;
    }
    
    ownerforward = anglestoforward( self.angles );
    ownerright = anglestoright( self.angles );
    var_147ece74855f6277 = ownerforward;
    
    if ( isplayer( self ) )
    {
        var_147ece74855f6277 = anglestoforward( self getplayerangles() );
    }
    
    thread function_55e16bcb3d1a287b( markerorigin, var_147ece74855f6277, ownerforward, ownerright );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( delaytime );
    
    /#
        clusterdebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( clusterdebugon )
        {
            thread debug::sphere( markerorigin, 20, ( 1, 1, 1 ), 20 );
        }
    #/
    
    explosiontype = getdvarint( @"hash_604652367665c1e0", 1 );
    
    if ( !isdefined( self.attackrange ) )
    {
        self.attackrange = 4000;
    }
    
    var_4b93b1a95d43d553 = self.attackrange * self.attackrange;
    
    if ( !isdefined( self.var_57a843751bdea6d8 ) )
    {
        self.var_57a843751bdea6d8 = 0;
    }
    
    var_113f938830a85120 = self.var_57a843751bdea6d8 * self.var_57a843751bdea6d8;
    
    if ( !bundle.var_35d4abd106522062 )
    {
        if ( isdefined( level.var_3d90777bfb7fc504 ) )
        {
            badplace = function_30c25bea1909556f( markerorigin, ( radius, radius, 100 ), ( 0, 0, 0 ), level.var_3d90777bfb7fc504 );
        }
        else
        {
            badplace = createnavbadplacebybounds( markerorigin, ( radius, radius, 100 ), ( 0, 0, 0 ) );
        }
        
        level thread function_1333829808d5f64e( badplace, tomaid );
    }
    
    if ( explosiontype == 1 )
    {
        var_c89ed29a58a1c345 = function_23ee00b330358b3e( tomaid );
        
        for ( i = 0; i < var_c89ed29a58a1c345 ; i++ )
        {
            var_c11b16cce6cf81ee = function_a0d2ac91c1c95a07( tomaid, i );
            
            if ( isdefined( streakinfo.var_6f50b012a8dd6332 ) )
            {
                var_c11b16cce6cf81ee = streakinfo.var_6f50b012a8dd6332;
            }
            
            var_c9bade25e3dc4c62 = function_857af6ad64793086( #"max_time_per_payload" );
            var_a4db596a495f0704 = function_857af6ad64793086( #"min_time_per_payload" );
            var_afeaad0d882fca6d = function_857af6ad64793086( #"max_time_per_wave" );
            var_c3dc6dc0fbcf4017 = function_857af6ad64793086( #"min_time_per_wave" );
            
            if ( isdefined( level.ob ) && isdefined( level.ob.warlordparameters[ "Rainmaker" ] ) )
            {
                if ( isplayer( marker ) && isdefined( marker.vehicle ) && isdefined( marker.vehicle vehicle::get_ref() ) )
                {
                    var_c9bade25e3dc4c62 = level.ob.warlordparameters[ "Rainmaker" ].var_e80db4daca6fd9d2.vehiclesetting;
                    var_a4db596a495f0704 = level.ob.warlordparameters[ "Rainmaker" ].var_a4db596a495f0704.vehiclesetting;
                    var_afeaad0d882fca6d = level.ob.warlordparameters[ "Rainmaker" ].var_afeaad0d882fca6d.vehiclesetting;
                    var_c3dc6dc0fbcf4017 = level.ob.warlordparameters[ "Rainmaker" ].var_c3dc6dc0fbcf4017.vehiclesetting;
                }
                else
                {
                    var_c9bade25e3dc4c62 = level.ob.warlordparameters[ "Rainmaker" ].var_e80db4daca6fd9d2.walksetting;
                    var_a4db596a495f0704 = level.ob.warlordparameters[ "Rainmaker" ].var_a4db596a495f0704.walksetting;
                    var_afeaad0d882fca6d = level.ob.warlordparameters[ "Rainmaker" ].var_afeaad0d882fca6d.walksetting;
                    var_c3dc6dc0fbcf4017 = level.ob.warlordparameters[ "Rainmaker" ].var_c3dc6dc0fbcf4017.walksetting;
                }
            }
            
            for ( j = 0; j < var_c11b16cce6cf81ee ; j++ )
            {
                if ( striketype == 2 )
                {
                    enemyplayer = marker;
                    targetposition = enemyplayer.origin;
                    
                    if ( isdefined( self.var_3d83320616ebb0ab ) )
                    {
                        targetposition = [[ self.var_3d83320616ebb0ab ]]( j, function_6b4303b8a0349775(), enemyplayer );
                    }
                    
                    if ( isdefined( targetposition ) )
                    {
                        var_4d99e8552caf305a = findunobstructedfiringinfo( targetposition, radius, var_147ece74855f6277, ownerforward, ownerright, i, j );
                        thread tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
                    }
                }
                else
                {
                    var_4d99e8552caf305a = findunobstructedfiringinfo( markerorigin, radius, var_147ece74855f6277, ownerforward, ownerright, i, j );
                    thread tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
                }
                
                if ( isdefined( streakinfo.var_89ba4f440f386ce ) )
                {
                    wait streakinfo.var_89ba4f440f386ce;
                    continue;
                }
                
                if ( isdefined( var_c9bade25e3dc4c62 ) && isdefined( var_a4db596a495f0704 ) )
                {
                    timetowait = var_a4db596a495f0704 == var_c9bade25e3dc4c62 ? var_a4db596a495f0704 : randomfloatrange( var_a4db596a495f0704, var_c9bade25e3dc4c62 );
                    wait timetowait;
                    continue;
                }
                
                timetowait = function_c41014e54d9149b9( tomaid, explosiontype, i, j );
                wait timetowait;
            }
            
            if ( isdefined( var_afeaad0d882fca6d ) && isdefined( var_c3dc6dc0fbcf4017 ) )
            {
                timetowait = var_c3dc6dc0fbcf4017 == var_afeaad0d882fca6d ? var_c3dc6dc0fbcf4017 : randomfloatrange( var_c3dc6dc0fbcf4017, var_afeaad0d882fca6d );
                wait timetowait;
                continue;
            }
            
            timetowait = function_26fadce9fa5c822c( tomaid, explosiontype, i );
            wait timetowait;
        }
    }
    else
    {
        for ( i = 0; i < numstrikes ; i++ )
        {
            if ( striketype == 2 )
            {
                var_4d99e8552caf305a = findunobstructedfiringinfo( marker.origin, radius, var_147ece74855f6277, ownerforward, ownerright, 0, i );
            }
            else
            {
                var_4d99e8552caf305a = findunobstructedfiringinfo( markerorigin, radius, var_147ece74855f6277, ownerforward, ownerright, 0, i );
            }
            
            thread tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
            namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( randomfloatrange( 1.35, 2.5 ) );
        }
    }
    
    utility::callsharedfunc( #"killstreak", #"killstreak_explosionnearai", markerorigin, 1000, "allies", "toma_strike" );
    level notify( "toma_strike_finished_" + tomaid );
}

// Namespace toma_strike
// Params 7
// Checksum 0xc7d83640, Offset: 0x3205
// Size: 0x269
function findunobstructedfiringinfo( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_147ece74855f6277, ownerforward, ownerright, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    gravity = getdvarfloat( @"bg_gravity", 800 );
    
    if ( getdvarint( @"bg_bristotallynormal", 0 ) )
    {
        gravity = getdvarfloat( @"hash_2f4cf62df1af9a6", 125 );
    }
    
    var_4d99e8552caf305a = spawnstruct();
    var_ae8856ebc968addf = tomastrike_findoptimallaunchpos( var_ff2c40cf5f0d3cc8, var_147ece74855f6277, ownerforward, ownerright );
    var_2bfd178bc84d73d7 = vectornormalize( var_ff2c40cf5f0d3cc8 - ( var_ae8856ebc968addf[ 0 ], var_ae8856ebc968addf[ 1 ], 0 ) );
    var_50e6a9e25a9fba6d = tomastrike_getrandombombingpoint( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 );
    var_7dae7f8ea43ba5c8 = ( 0, 0, -1 * gravity );
    traveltime = function_857af6ad64793086( #"missile_travel_time" );
    var_9dce17a116cdf149 = ( var_50e6a9e25a9fba6d.point - 0.5 * var_7dae7f8ea43ba5c8 * squared( traveltime ) - var_ae8856ebc968addf ) / traveltime;
    
    /#
        clusterdebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( clusterdebugon )
        {
            thread debug::sphere( var_50e6a9e25a9fba6d.point, 20, ( 1, 1, 0 ), 20 );
            thread debug::line( var_ae8856ebc968addf, var_50e6a9e25a9fba6d.point, ( 1, 1, 0 ), 20 );
        }
    #/
    
    if ( !isdefined( self.var_ca5dd26ab39d925b ) )
    {
        self.var_ca5dd26ab39d925b = function_857af6ad64793086( #"missile_travel_time" ) - 0.075;
    }
    
    var_2dd8674712c19866 = var_ae8856ebc968addf + var_9dce17a116cdf149 * self.var_ca5dd26ab39d925b + 0.5 * var_7dae7f8ea43ba5c8 * squared( self.var_ca5dd26ab39d925b );
    var_4d99e8552caf305a.sourcepos = var_ae8856ebc968addf;
    var_4d99e8552caf305a.entityhit = var_50e6a9e25a9fba6d.entityhit;
    var_4d99e8552caf305a.entityhittype = var_50e6a9e25a9fba6d.entityhittype;
    var_4d99e8552caf305a.goalpos = var_50e6a9e25a9fba6d.point;
    var_4d99e8552caf305a.preexplpos = var_2dd8674712c19866;
    var_4d99e8552caf305a.initvelocity = var_9dce17a116cdf149;
    var_4d99e8552caf305a.var_471d07fbd87e726b = traveltime;
    return var_4d99e8552caf305a;
}

// Namespace toma_strike
// Params 1
// Checksum 0x4025f9be, Offset: 0x3477
// Size: 0x5a
function delayscriptablechangethread( delaytime )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self.owner utility::waittill_any_timeout( delaytime, "stop_marker_guide" );
    self setscriptablepartstate( "target", "off", 0 );
    self delete();
}

// Namespace toma_strike
// Params 5
// Checksum 0xee460949, Offset: 0x34d9
// Size: 0x1ab
function tomastrike_getrandombombingpoint( var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    randdist = randomint( var_d0b84b2215b34610 );
    randangle = randomint( 360 );
    x = var_ff2c40cf5f0d3cc8[ 0 ] + randdist * cos( randangle );
    y = var_ff2c40cf5f0d3cc8[ 1 ] + randdist * sin( randangle );
    z = var_ff2c40cf5f0d3cc8[ 2 ];
    point = ( x, y, z );
    
    if ( isdefined( var_2bfd178bc84d73d7 ) )
    {
        point -= var_2bfd178bc84d73d7 * 100;
    }
    
    traceheightoffset = 10000;
    
    if ( isdefined( level.toma_strike_trace_offset ) )
    {
        traceheightoffset = level.toma_strike_trace_offset;
    }
    
    pointinfo = spawnstruct();
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( point + ( 0, 0, traceheightoffset ), point - ( 0, 0, traceheightoffset ), undefined, contents );
    
    if ( isdefined( trace[ "entity" ] ) )
    {
        entity = trace[ "entity" ];
        pointinfo.entityhit = entity;
        
        if ( tomastrike_isflyingvehicle( entity ) || tomastrike_isflyingkillstreak( entity ) )
        {
            pointinfo.entityhittype = "flying";
        }
    }
    
    if ( isdefined( trace[ "position" ] ) )
    {
        point = trace[ "position" ];
    }
    
    pointinfo.point = point;
    utility::callsharedfunc( #"toma_strike", #"hash_992596e61dee82dd", pointinfo, var_e563c7b55d6eb727, var_56aff40dfda39956, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7 );
    return pointinfo;
}

// Namespace toma_strike
// Params 1
// Checksum 0xfbc90300, Offset: 0x368d
// Size: 0x1f, Type: bool
function tomastrike_isflyingvehicle( entity )
{
    return isdefined( vehicle::get_ref() ) && entity vehicle::can_fly();
}

// Namespace toma_strike
// Params 1
// Checksum 0x814f1181, Offset: 0x36b5
// Size: 0x2d, Type: bool
function tomastrike_isflyingkillstreak( entity )
{
    return isdefined( entity.streakinfo ) && entity.sentientpool == "Killstreak_Air";
}

// Namespace toma_strike
// Params 2
// Checksum 0xae9f62f5, Offset: 0x36eb
// Size: 0x34
function function_1333829808d5f64e( badplace, tomaid )
{
    level endon( #"game_ended" );
    level waittill( "toma_strike_clean_up_" + tomaid );
    destroynavobstacle( badplace );
}

// Namespace toma_strike
// Params 4
// Checksum 0x9f85ce4d, Offset: 0x3727
// Size: 0x451
function tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo, vehicle )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( vehicle ) )
    {
        self earthquakeforplayer( 0.35, 1, vehicle.origin, 1000 );
        self playlocalsound( "weap_cluster_fire" );
    }
    
    missile = magicgrenademanual( level.toma_weapon_name, var_4d99e8552caf305a.sourcepos, var_4d99e8552caf305a.initvelocity, function_857af6ad64793086( #"missile_travel_time" ) + 2, self );
    bundle = streakinfo.bundle ?? { #var_aa3f05d6cb252306:undefined };
    
    if ( level.streakglobals.var_3feb5f5305e6fe83 )
    {
        missile function_681f2a0d5c7420db( streakinfo.bundle.var_77216bac95c39355 );
        missile function_d0fcbff5a25cc481( streakinfo.bundle.var_4d7d4b6afc661107 );
        missile function_d93054349b7f4e82( var_4d99e8552caf305a.goalpos );
    }
    
    missile setentityowner( self );
    missile setotherent( self );
    missile.owner = self;
    missile.team = self.team;
    missile.streakinfo = streakinfo;
    missile update_minimap_icon( 1, var_4d99e8552caf305a.goalpos );
    killcament = spawn( "script_model", var_4d99e8552caf305a.sourcepos );
    killcament linkto( missile, "tag_origin", ( 10, 0, 10 ), ( 0, 0, 0 ) );
    missile.killcament = killcament;
    missile.explodeent = spawn( "script_model", missile.origin );
    missile.explodeent setmodel( bundle.var_aa3f05d6cb252306 ?? "ks_toma_strike_missile_mp" );
    missile.explodeent linkto( missile );
    missile.explodeent dontinterpolate();
    missile.explodeent setentityowner( self );
    missile.explodeent.killcament = killcament;
    
    if ( !self.var_5d350bc7166e50ce && utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_39046aa32b2153cf", var_4d99e8552caf305a.goalpos, self.team );
    }
    
    missile setscriptablepartstate( "launch", "active", 0 );
    missile setscriptablepartstate( "trail", "active", 0 );
    missile thread toma_strike_watch_owner();
    missile thread function_f8b73ca080dc9bfb();
    
    if ( bundle.var_bba29000ee818e74 )
    {
        missile.angles = generateaxisanglesfromforwardvector( var_4d99e8552caf305a.initvelocity, missile.angles );
        missile thread function_a72b7bee7ef1d4d4();
    }
    
    explosiontype = getdvarint( @"hash_604652367665c1e0", 1 );
    var_c70fe14f2661a47e = function_857af6ad64793086( #"missile_travel_time" ) - ( bundle.var_da553973a8961a09 ?? 0.5 );
    killcamendpos = var_4d99e8552caf305a.preexplpos;
    
    if ( explosiontype != 1 )
    {
        missile thread toma_strike_watch_airexplosion( var_4d99e8552caf305a.preexplpos, var_4d99e8552caf305a.entityhit, var_4d99e8552caf305a.entityhittype, self.var_ca5dd26ab39d925b );
    }
    else
    {
        missile thread toma_strike_watch_airexplosion( undefined, undefined, undefined, function_857af6ad64793086( #"missile_travel_time" ) + 1 );
    }
    
    if ( var_4d99e8552caf305a.var_471d07fbd87e726b )
    {
        missile thread toma_strike_delay_hide( var_4d99e8552caf305a.var_471d07fbd87e726b );
    }
    
    missile thread toma_strike_watch_stuck( explosiontype, vectortoangles( var_4d99e8552caf305a.initvelocity ), gettime(), var_4d99e8552caf305a.initvelocity );
    missile.killcament thread toma_strike_move_killcam( var_c70fe14f2661a47e, killcamendpos );
}

// Namespace toma_strike
// Params 6
// Checksum 0xc41e2414, Offset: 0x3b80
// Size: 0x13e
function function_5a8f351cdf789664( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo )
{
    level endon( #"game_ended" );
    self.exploding = 1;
    var_1ab7db68120283ff = toma_strike_create_explosion( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo );
    var_1ab7db68120283ff.killcament = self.killcament;
    explodepart = "explode_large";
    
    if ( self.waterimpact )
    {
        explodepart += "_water";
    }
    else if ( streakinfo.var_df3d94091dbd9fc3 )
    {
        playrumbleonposition( "artillery_rumble", self.origin );
    }
    
    haspart = var_1ab7db68120283ff getscriptablehaspart( explodepart );
    var_1ab7db68120283ff setscriptablepartstate( explodepart, "active", 1 );
    
    if ( isdefined( self.explodeent ) )
    {
        self.explodeent delete();
    }
    
    self delete();
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    
    if ( isdefined( var_1ab7db68120283ff ) )
    {
        if ( isdefined( var_1ab7db68120283ff.killcament ) )
        {
            var_1ab7db68120283ff.killcament delete();
        }
        
        var_1ab7db68120283ff delete();
    }
}

// Namespace toma_strike
// Params 1
// Checksum 0xd680f4ea, Offset: 0x3cc6
// Size: 0xad
function function_d97b038fa7aa08c6( var_310c207acff4725 )
{
    self endon( #"death" );
    self.exploding = 1;
    self.explodeent unlink();
    self.explodeent.origin = var_310c207acff4725;
    self.explodeent setscriptablepartstate( "explode", "active", 0 );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    
    if ( isdefined( self.explodeent ) )
    {
        self.explodeent delete();
    }
    
    update_minimap_icon( 0 );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    self delete();
}

// Namespace toma_strike
// Params 1
// Checksum 0x3136dd8e, Offset: 0x3d7b
// Size: 0x3e
function toma_strike_delay_hide( delaytime )
{
    self endon( #"death" );
    
    if ( delaytime > 0.02 )
    {
        wait delaytime - 0.02;
        self setscriptablepartstate( "visibility", "hide", 1 );
    }
}

// Namespace toma_strike
// Params 0
// Checksum 0x655dde19, Offset: 0x3dc1
// Size: 0x8d
function toma_strike_watch_owner()
{
    self endon( #"missile_empd" );
    self endon( #"death" );
    self endon( #"hash_7419a6ae62fb730b" );
    owner = self.owner;
    owner utility::waittill_any( "disconnect", "joined_team" );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
    thread function_d97b038fa7aa08c6( self.origin );
    self notify( #"hash_f0d4a2ca833ee95c" );
}

// Namespace toma_strike
// Params 0
// Checksum 0x5b6d4573, Offset: 0x3e56
// Size: 0x95
function function_f8b73ca080dc9bfb()
{
    self endon( #"death" );
    owner = self.owner;
    owner endon( #"disconnect" );
    
    while ( true )
    {
        if ( owner.ksempd )
        {
            self notify( #"missile_empd" );
            
            if ( isdefined( self.killcament ) )
            {
                self.killcament delete();
            }
            
            namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
            thread function_d97b038fa7aa08c6( self.origin );
            self notify( #"hash_f0d4a2ca833ee95c" );
            break;
        }
        
        waitframe();
    }
}

// Namespace toma_strike
// Params 0
// Checksum 0x476b97ec, Offset: 0x3ef3
// Size: 0xca
function function_a72b7bee7ef1d4d4()
{
    self endon( #"death" );
    self endon( #"missile_empd" );
    self endon( #"missile_stuck" );
    self endon( #"missile_water_impact" );
    self endon( #"hash_7419a6ae62fb730b" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    prevloc = self getorigin();
    
    while ( true )
    {
        if ( !isdefined( prevloc ) )
        {
            prevloc = self getorigin();
            waitframe();
            continue;
        }
        
        currloc = self getorigin();
        
        if ( !isdefined( currloc ) )
        {
            waitframe();
            continue;
        }
        
        self.angles = anglelerpquat( self.angles, vectortoangles( currloc - prevloc ), self.streakinfo.var_a3fe3d63cfa0baa3 ?? 1 );
        prevloc = currloc;
        waitframe();
    }
}

// Namespace toma_strike
// Params 4
// Checksum 0x6302376c, Offset: 0x3fc5
// Size: 0x10e
function toma_strike_watch_airexplosion( var_310c207acff4725, entityhit, entityhittype, explosiondelay )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    self endon( #"hash_7419a6ae62fb730b" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( explosiondelay );
    namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
    
    if ( !isdefined( var_310c207acff4725 ) )
    {
        var_310c207acff4725 = self.origin;
    }
    
    thread function_d97b038fa7aa08c6( var_310c207acff4725 );
    
    if ( utility::issharedfuncdefined( #"toma_strike", #"damageoverride" ) )
    {
        [[ utility::getsharedfunc( #"toma_strike", #"damageoverride" ) ]]( var_310c207acff4725, 500, 500, 500, self.owner, "MOD_EXPLOSIVE", makeweapon( level.toma_weapon_name ) );
        return;
    }
    
    if ( isdefined( entityhit ) && entityhittype == "flying" )
    {
        entityhit dodamage( 500, var_310c207acff4725, self.owner, self, "MOD_EXPLOSIVE", makeweapon( level.toma_weapon_name ) );
    }
}

// Namespace toma_strike
// Params 2
// Checksum 0xab0586bf, Offset: 0x40db
// Size: 0x4e
function toma_strike_move_killcam( var_6edb5cd6057d3905, endpos )
{
    if ( isdefined( self ) )
    {
        self endon( #"death" );
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( var_6edb5cd6057d3905 );
        self unlink();
        self moveto( endpos, 5 );
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 7 );
        self delete();
    }
}

// Namespace toma_strike
// Params 4
// Checksum 0x3be58d95, Offset: 0x4131
// Size: 0x116
function toma_strike_watch_stuck( explosiontype, launchangles, launchtimems, launchvelocity )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    stuckto = function_4c2011ea1469ed8a();
    update_minimap_icon( 2 );
    
    if ( explosiontype != 1 && gettime() - launchtimems < self.var_ca5dd26ab39d925b * 1000 )
    {
        thread function_d97b038fa7aa08c6( self.origin );
        self notify( #"hash_f0d4a2ca833ee95c" );
        return;
    }
    
    wait 0.05;
    gravityaccel = -1 * getdvarfloat( @"bg_gravity", 800 );
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, gravityaccel * traveltime );
    
    if ( isplayer( stuckto ) )
    {
        toma_strike_stuck_player( explosiontype, self, stuckto, launchangles, impactvelocity );
    }
    else
    {
        toma_strike_stuck( explosiontype, stuckto, launchangles, impactvelocity );
    }
    
    self notify( #"hash_7419a6ae62fb730b" );
}

// Namespace toma_strike
// Params 0
// Checksum 0x996611c5, Offset: 0x424f
// Size: 0x8c
function function_4c2011ea1469ed8a()
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    impactinfo = killstreak_shared::killstreak_waittillexplode( "missile_stuck", "missile_water_impact" );
    stuckto = undefined;
    
    if ( isdefined( impactinfo ) )
    {
        if ( impactinfo.msg == "missile_stuck" )
        {
            stuckto = impactinfo.param1;
        }
        else if ( impactinfo.msg == "missile_water_impact" )
        {
            self.waterimpact = 1;
        }
    }
    
    return stuckto;
}

// Namespace toma_strike
// Params 4
// Checksum 0x9d33e3c4, Offset: 0x42e4
// Size: 0x10a
function toma_strike_stuck( explosiontype, stuckto, launchangles, impactvelocity )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( self.angles );
    right = anglestoright( launchangles );
    
    if ( self.waterimpact )
    {
        up = ( 0, 0, 1 );
    }
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = toma_strike_rebuild_angles_up_right( up, right );
    }
    else
    {
        angles = toma_strike_rebuild_angles_up_forward( up, forward );
    }
    
    self.angles = angles;
    
    if ( explosiontype == 1 )
    {
        thread function_5a8f351cdf789664( self.origin, angles, stuckto, self.owner, gettime(), self.streakinfo );
        return;
    }
    
    thread toma_strike_launch_cluster( self, self.origin, angles, stuckto, gettime() );
}

// Namespace toma_strike
// Params 5
// Checksum 0xa893967e, Offset: 0x43f6
// Size: 0x1df
function toma_strike_stuck_player( explosiontype, grenade, stuckto, launchangles, impactvelocity )
{
    impactvelocity *= ( 0, 0, 1 );
    caststart = grenade.origin;
    castdir = ( 0, 0, -1 );
    castend = caststart + castdir * 128;
    contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    castresults = physics_raycast( caststart, castend, contents, grenade, 0, "physicsquery_closest", 1 );
    
    if ( castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        casthitnorm = castresults[ 0 ][ "normal" ];
        casthitent = castresults[ 0 ][ "entity" ];
        castend -= casthitnorm * 1;
        gravityaccel = -1 * getdvarfloat( @"bg_gravity", 800 );
        d = vectordot( castend - caststart, castdir );
        t = sqrt( 2 * d / -1 * gravityaccel );
        up = casthitnorm;
        right = anglestoright( launchangles );
        impactangles = toma_strike_rebuild_angles_up_right( up, right );
        
        if ( explosiontype == 1 )
        {
            thread function_5a8f351cdf789664( self.origin, impactangles, stuckto, self.owner, gettime(), self.streakinfo );
            return;
        }
        
        thread toma_strike_launch_cluster( grenade, castend, impactangles, casthitent, gettime() + t * 1000 );
    }
}

// Namespace toma_strike
// Params 5
// Checksum 0xc158953, Offset: 0x45dd
// Size: 0x327
function toma_strike_launch_cluster( grenade, impactorigin, impactangles, impactent, impacttime )
{
    owner = grenade.owner;
    killcament = grenade.killcament;
    impactnormal = anglestoup( impactangles );
    caststart = impactorigin + impactnormal * 1;
    castend = caststart + impactnormal * 25;
    contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    castresults = physics_raycast( caststart, castend, contents, grenade, 0, "physicsquery_closest", 1 );
    
    if ( castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ] - impactnormal * 1;
    }
    
    borigin = castend;
    shareddata = toma_strike_get_shared_data( owner, grenade.streakinfo, impacttime, killcament );
    castdata = toma_strike_get_cast_data();
    branch = toma_strike_create_branch( shareddata, castdata, undefined, borigin, impactangles, impactent, 0, undefined, undefined );
    shareddata.branches[ shareddata.branches.size ] = branch;
    branch.killcament = killcament;
    forward = anglestoforward( impactangles );
    right = anglestoright( impactangles );
    up = anglestoup( impactangles );
    bforward = rotatepointaroundvector( up, forward, 30 );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    castdata = toma_strike_get_cast_data();
    branch = toma_strike_create_branch( shareddata, castdata, undefined, borigin, bangles, impactent, 0, undefined, undefined );
    branch.killcament = killcament;
    shareddata.branches[ shareddata.branches.size ] = branch;
    bforward = rotatepointaroundvector( up, forward, -30 );
    bright = vectornormalize( vectorcross( bforward, up ) );
    bup = vectorcross( bright, forward );
    bangles = axistoangles( bforward, bright, bup );
    castdata = toma_strike_get_cast_data();
    branch = toma_strike_create_branch( shareddata, castdata, undefined, borigin, bangles, impactent, 0, undefined, undefined );
    branch.killcament = killcament;
    shareddata.branches[ shareddata.branches.size ] = branch;
    shareddata toma_strike_shared_data_register_cast();
    
    foreach ( branch in shareddata.branches )
    {
        branch thread toma_strike_start_branch();
    }
}

// Namespace toma_strike
// Params 0
// Checksum 0x873da3bb, Offset: 0x490c
// Size: 0x714
function toma_strike_start_branch()
{
    killcament = self.killcament;
    
    /#
        if ( utility::issharedfuncdefined( #"toma_strike", #"molotov_branch_draw_hits" ) )
        {
            self thread [[ utility::getsharedfunc( #"toma_strike", #"molotov_branch_draw_hits" ) ]]();
        }
    #/
    
    if ( !isdefined( self.preventstarttime ) )
    {
        self.preventstarttime = gettime();
    }
    
    if ( !isdefined( self.startingcasttype ) )
    {
        if ( !self.shareddata toma_strike_shared_data_is_complete() )
        {
            explent = toma_strike_branch_create_explosion( self.startingorigin, self.startingangles, self.startingstuckto, self.shareddata.streakinfo );
            explent.killcament = killcament;
            explent thread toma_strike_start_explosion();
            self.iscomplete = 1;
            self.shareddata toma_strike_shared_data_is_complete( 1 );
            
            /#
                self.hitpositions[ self.hitpositions.size ] = self.startingorigin;
                self.hittypes[ self.hittypes.size ] = 1;
            #/
        }
        
        return;
    }
    
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;
    
    while ( true )
    {
        if ( self.shareddata toma_strike_shared_data_is_complete() )
        {
            break;
        }
        
        if ( toma_strike_branch_is_complete() )
        {
            break;
        }
        
        if ( !self.shareddata toma_strike_shared_data_can_cast_this_frame() )
        {
            waitframe();
            continue;
        }
        
        if ( self.casttype == 0 )
        {
            firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;
            
            if ( isdefined( firstforwardmodanglesfunc ) )
            {
                self.castangles = [[ firstforwardmodanglesfunc ]]( self.castangles );
                self.castdata.firstforwardmodanglesfunc = undefined;
            }
        }
        
        self.castdir = toma_strike_get_cast_dir( self.castangles, self.casttype );
        self.castend = self.caststart + self.castdir * toma_strike_get_cast_dist( self.casttype, self.castdata );
        casthit = undefined;
        casthitpos = undefined;
        casthitnorm = undefined;
        casthitent = undefined;
        casthitangles = undefined;
        castresults = physics_raycast( self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1 );
        
        if ( castresults.size > 0 )
        {
            casthit = 1;
            casthitpos = castresults[ 0 ][ "position" ];
            casthitnorm = castresults[ 0 ][ "normal" ];
            casthitent = castresults[ 0 ][ "entity" ];
        }
        
        switch ( self.casttype )
        {
            case 0:
                if ( casthit )
                {
                    toma_strike_branch_register_cast( self.casttype, 0, casthitpos );
                    var_578abdcb9fea30ac = 1;
                    
                    if ( isdefined( self.castdata.firstforwarddist ) )
                    {
                        castvec = casthitpos - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.castdata.firstforwarddist -= castdist;
                        
                        if ( self.castdata.firstforwarddist > self.castdata.firstforwardmindist )
                        {
                            var_578abdcb9fea30ac = 0;
                        }
                        else
                        {
                            self.castdata.firstforwarddist = undefined;
                        }
                    }
                    
                    casthitangles = toma_strike_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    
                    if ( var_578abdcb9fea30ac )
                    {
                        explent = toma_strike_branch_create_explosion( casthitpos, casthitangles, casthitent, self.shareddata.streakinfo );
                        explent.killcament = killcament;
                        explent thread toma_strike_start_explosion();
                    }
                    
                    self.casttype = 2;
                    self.caststart = casthitpos + casthitnorm * 1;
                    self.castangles = casthitangles;
                }
                else
                {
                    toma_strike_branch_register_cast( self.casttype, undefined, undefined );
                    
                    if ( isdefined( self.castdata.firstforwarddist ) )
                    {
                        castvec = self.castend - self.caststart;
                        castdist = vectordot( castvec, self.castdir );
                        self.castdata.firstforwarddist -= castdist;
                        
                        if ( self.castdata.firstforwarddist <= self.castdata.firstforwardmindist )
                        {
                            self.castdata.firstforwarddist = undefined;
                        }
                    }
                    
                    self.casttype = 1;
                    self.caststart = self.castend;
                }
                
                break;
            case 1:
                if ( casthit )
                {
                    casthitangles = toma_strike_rebuild_angles_up_right( casthitnorm, anglestoright( self.castangles ) );
                    explent = toma_strike_branch_create_explosion( casthitpos, casthitangles, casthitent, self.shareddata.streakinfo );
                    explent.killcament = killcament;
                    explent thread toma_strike_start_explosion();
                    normdot = vectordot( anglestoup( self.castangles ), casthitnorm );
                    
                    if ( normdot < 0.9848 )
                    {
                        toma_strike_branch_register_cast( self.casttype, 2, casthitpos );
                        self.casttype = 2;
                        self.caststart = casthitpos + casthitnorm * 1;
                        self.castangles = casthitangles;
                    }
                    else
                    {
                        toma_strike_branch_register_cast( self.casttype, 1, casthitpos );
                        self.casttype = 0;
                    }
                }
                else
                {
                    toma_strike_branch_register_cast( self.casttype, undefined, undefined );
                    self.caststart = self.castend;
                }
                
                break;
            case 2:
                if ( casthit )
                {
                    toma_strike_branch_register_cast( self.casttype, 3, casthitpos );
                    self.casttype = 0;
                    self.caststart = casthitpos + casthitnorm * 1;
                }
                else
                {
                    toma_strike_branch_register_cast( self.casttype, undefined, undefined );
                    self.casttype = 0;
                }
                
                break;
        }
        
        waittillframeend();
    }
    
    self.iscomplete = 1;
    self.shareddata toma_strike_shared_data_is_complete( 1 );
    self.shareddata.branches = [];
}

// Namespace toma_strike
// Params 4
// Checksum 0x847903b9, Offset: 0x5028
// Size: 0xc0
function toma_strike_branch_create_explosion( origin, angles, stuckto, streakinfo )
{
    delayms = 50;
    
    if ( true )
    {
        delayms = randomintrange( 50, 350 );
    }
    
    starttime = self.preventstarttime + delayms;
    ent = toma_strike_create_explosion( origin + anglestoup( angles ), angles, stuckto, self.shareddata.owner, starttime, streakinfo );
    self.preventstarttime = starttime;
    self.ents[ self.ents.size ] = ent;
    self.shareddata toma_strike_shared_data_register_ent();
    return ent;
}

// Namespace toma_strike
// Params 0, eflags: 0x4
// Checksum 0x230b94db, Offset: 0x50f1
// Size: 0x5a
function private function_7adbbe8a4b551689()
{
    if ( !isdefined( level.var_d2057eb693bfdb83 ) )
    {
        bundle = killstreak::function_85b2d8e857ab4898( "toma_strike" ) ?? { #var_d2057eb693bfdb83:undefined };
        level.var_d2057eb693bfdb83 = bundle.var_d2057eb693bfdb83 ?? "ks_toma_strike_cluster_mp";
    }
    
    return level.var_d2057eb693bfdb83;
}

// Namespace toma_strike
// Params 6
// Checksum 0x1d39e4c6, Offset: 0x5154
// Size: 0xe9
function toma_strike_create_explosion( origin, angles, stuckto, owner, starttime, streakinfo )
{
    ent = spawn( "script_model", origin );
    ent.angles = angles;
    ent.stuckto = stuckto;
    ent.owner = owner;
    ent.starttime = starttime;
    ent.streakinfo = streakinfo;
    var_d2057eb693bfdb83 = function_7adbbe8a4b551689();
    ent setmodel( var_d2057eb693bfdb83 );
    
    if ( isdefined( owner ) )
    {
        ent setotherent( owner );
        ent setentityowner( owner );
    }
    
    if ( isdefined( stuckto ) && ( !isagent( stuckto ) || isalive( stuckto ) ) )
    {
        ent linkto( stuckto );
    }
    
    return ent;
}

// Namespace toma_strike
// Params 0
// Checksum 0xe2a2da6c, Offset: 0x5246
// Size: 0x73
function toma_strike_start_explosion()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    
    if ( isdefined( self.stuckto ) )
    {
        self.stuckto endon( #"death" );
    }
    
    while ( gettime() < self.starttime )
    {
        waitframe();
    }
    
    thread toma_strike_explosion_end();
}

// Namespace toma_strike
// Params 0
// Checksum 0x6706d12d, Offset: 0x52c1
// Size: 0x1c
function toma_strike_explosion_end()
{
    self setscriptablepartstate( "explode", "active", 0 );
    wait 1;
    self delete();
}

// Namespace toma_strike
// Params 0
// Checksum 0x4f723f93, Offset: 0x52e5
// Size: 0x23
function toma_strike_shared_data_register_cast()
{
    self.caststotal++;
    self.caststhisframe++;
    self.frametimestamp = gettime();
}

// Namespace toma_strike
// Params 0
// Checksum 0x52be0206, Offset: 0x5310
// Size: 0xc
function toma_strike_shared_data_register_ent()
{
    self.entstotal++;
}

// Namespace toma_strike
// Params 0
// Checksum 0x1e150078, Offset: 0x5324
// Size: 0x36, Type: bool
function toma_strike_shared_data_can_cast_this_frame()
{
    if ( self.frametimestamp < gettime() )
    {
        self.frametimestamp = gettime();
        self.caststhisframe = 0;
    }
    
    return self.caststhisframe < 3;
}

// Namespace toma_strike
// Params 1
// Checksum 0x5b612aba, Offset: 0x5363
// Size: 0xf1
function toma_strike_shared_data_is_complete( var_4a9d8dc725fefd )
{
    iscomplete = 0;
    
    if ( self.caststotal >= 60 )
    {
        iscomplete = 1;
    }
    else if ( self.entstotal >= 20 )
    {
        iscomplete = 1;
    }
    else if ( var_4a9d8dc725fefd )
    {
        var_fda75b85789eb4d3 = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !branch toma_strike_branch_is_complete() )
            {
                var_fda75b85789eb4d3 = 0;
                break;
            }
        }
        
        if ( var_fda75b85789eb4d3 )
        {
            iscomplete = 1;
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
    }
    
    return iscomplete;
}

// Namespace toma_strike
// Params 3
// Checksum 0x8cb781c0, Offset: 0x545d
// Size: 0x187
function toma_strike_branch_register_cast( casttype, casthittype, hitposition )
{
    self.shareddata toma_strike_shared_data_register_cast();
    self.casts++;
    
    if ( isdefined( casthittype ) )
    {
        if ( casthittype == 0 || casthittype == 1 || casthittype == 2 )
        {
            self.castfails = 0;
        }
    }
    else if ( casttype == 1 )
    {
        self.castfails++;
    }
    
    /#
        debugmsg = undefined;
        
        if ( isdefined( casthittype ) )
        {
            debugmsg = undefined;
            
            switch ( casthittype )
            {
                case 0:
                    debugmsg = "<dev string:x24>";
                    break;
                case 1:
                    debugmsg = "<dev string:x30>";
                    break;
                case 2:
                    debugmsg = "<dev string:x39>";
                    break;
                case 3:
                    debugmsg = "<dev string:x49>";
                    break;
            }
            
            self.hitpositions[ self.hitpositions.size ] = hitposition;
            self.hittypes[ self.hittypes.size ] = casthittype;
        }
        else
        {
            switch ( casttype )
            {
                case 0:
                    debugmsg = "<dev string:x50>";
                    break;
                case 1:
                    debugmsg = "<dev string:x58>";
                    break;
                case 2:
                    debugmsg = "<dev string:x62>";
                    break;
            }
        }
        
        if ( level.var_569988d90e2df561 )
        {
            if ( isdefined( debugmsg ) )
            {
                println( debugmsg );
            }
        }
    #/
}

// Namespace toma_strike
// Params 1
// Checksum 0x37f0bfe1, Offset: 0x55ec
// Size: 0x249
function toma_strike_branch_is_complete( var_4a9d8dc725fefd )
{
    iscomplete = 0;
    var_fda75b85789eb4d3 = undefined;
    
    if ( self.shareddata toma_strike_shared_data_is_complete() )
    {
        iscomplete = 1;
    }
    else if ( isdefined( self.castdata ) && self.castfails >= self.castdata.maxfails )
    {
        iscomplete = 1;
    }
    else if ( isdefined( self.castdata ) && self.casts >= self.castdata.maxcasts )
    {
        iscomplete = 1;
    }
    else if ( isdefined( self.castdata ) && self.ents.size >= self.castdata.maxents )
    {
        iscomplete = 1;
    }
    else if ( var_4a9d8dc725fefd )
    {
        var_fda75b85789eb4d3 = 1;
        
        foreach ( branch in self.branches )
        {
            if ( !branch toma_strike_branch_is_complete() )
            {
                var_fda75b85789eb4d3 = 0;
                break;
            }
        }
        
        if ( var_fda75b85789eb4d3 )
        {
            iscomplete = 1;
        }
    }
    
    if ( iscomplete && !self.iscomplete )
    {
        oncompletedfunc = self.oncompletedfunc;
        
        if ( isdefined( oncompletedfunc ) )
        {
            self [[ oncompletedfunc ]]();
        }
        
        println( "<dev string:x65>" );
        
        if ( var_fda75b85789eb4d3 )
        {
            iscomplete = 0;
            
            foreach ( branch in self.branches )
            {
                if ( !branch toma_strike_branch_is_complete() )
                {
                    var_fda75b85789eb4d3 = 0;
                    break;
                }
            }
            
            if ( var_fda75b85789eb4d3 )
            {
                iscomplete = 1;
            }
        }
    }
    
    if ( iscomplete )
    {
        self.iscomplete = 1;
    }
    
    return iscomplete;
}

// Namespace toma_strike
// Params 9
// Checksum 0x55a2df07, Offset: 0x583e
// Size: 0x124
function toma_strike_create_branch( shareddata, castdata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc )
{
    branch = spawnstruct();
    branch.shareddata = shareddata;
    branch.castdata = castdata;
    branch.startingorigin = startingorigin;
    branch.startingangles = startingangles;
    branch.startingstuckto = startingstuckto;
    branch.startingcasttype = startingcasttype;
    branch.oncompletedfunc = oncompletedfunc;
    branch.ents = [];
    branch.branches = [];
    branch.hitpositions = [];
    branch.hittypes = [];
    branch.casts = 0;
    branch.castfails = 0;
    branch.preventstarttime = preventstarttime;
    return branch;
}

// Namespace toma_strike
// Params 4
// Checksum 0x1ceb5c3b, Offset: 0x596b
// Size: 0xfc
function toma_strike_get_shared_data( owner, streakinfo, impacttime, killcament )
{
    shareddata = spawnstruct();
    shareddata.owner = owner;
    shareddata.team = owner.team;
    shareddata.streakinfo = streakinfo;
    shareddata.impacttime = impacttime;
    shareddata.branches = [];
    shareddata.entstotal = 0;
    shareddata.caststotal = 0;
    shareddata.caststhisframe = 0;
    shareddata.frametimestamp = gettime();
    shareddata.castcontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    return shareddata;
}

// Namespace toma_strike
// Params 0
// Checksum 0x376b2dbc, Offset: 0x5a70
// Size: 0x68
function toma_strike_get_cast_data()
{
    castdata = spawnstruct();
    castdata.distforward = 125;
    castdata.distdown = 50;
    castdata.distup = 25;
    castdata.maxcasts = 12;
    castdata.maxfails = 3;
    castdata.maxents = 4;
    return castdata;
}

// Namespace toma_strike
// Params 2
// Checksum 0xcc73ed4b, Offset: 0x5ae1
// Size: 0x5b
function toma_strike_get_cast_dir( angles, casttype )
{
    switch ( casttype )
    {
        case 0:
            return anglestoforward( angles );
        case 1:
            return ( -1 * anglestoup( angles ) );
        case 2:
            return anglestoup( angles );
    }
}

// Namespace toma_strike
// Params 2
// Checksum 0xc54569dc, Offset: 0x5b45
// Size: 0x87
function toma_strike_get_cast_dist( casttype, castdata )
{
    switch ( casttype )
    {
        case 0:
            var_7237854e3be197ca = castdata.firstforwarddist;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
            
            return castdata.distforward;
        case 1:
            return castdata.distdown;
        case 2:
            return castdata.distup;
    }
}

// Namespace toma_strike
// Params 2, eflags: 0x4
// Checksum 0xbda72c78, Offset: 0x5bd5
// Size: 0x343
function private update_minimap_icon( var_5207c09168cffe2d, missilegoalpos )
{
    bundle = level.streakglobals.streakbundles[ "toma_strike" ] ?? { #var_aa3f05d6cb252306:undefined };
    var_d0fd0dc6e83e37fa = getdvarint( @"hash_2cfbf02c634789ea", 1 );
    
    switch ( var_5207c09168cffe2d )
    {
        case 0:
            if ( isdefined( self.minimapid ) )
            {
                if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
                {
                    [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
                }
                
                self.minimapid = undefined;
            }
            
            break;
        case 1:
            var_f920b37e2fe18c87 = istrue( bundle.var_310b1dcd4f1fac27 );
            
            if ( var_d0fd0dc6e83e37fa == 0 )
            {
                namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
                
                if ( level.streakglobals.var_3feb5f5305e6fe83 )
                {
                    namespace_9d8e359c3b1041e5::function_bc3d11edade5004( bundle.var_77216bac95c39355 );
                    namespace_9d8e359c3b1041e5::function_2774ff2792a00056( bundle.var_4d7d4b6afc661107 );
                    namespace_9d8e359c3b1041e5::function_fe287412c2a2bb55( missilegoalpos );
                }
            }
            else if ( !var_f920b37e2fe18c87 )
            {
                minimapid = undefined;
                
                if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
                {
                    minimapid = self [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( "hud_icon_minimap_killstreak_mortar_strike", self.team, undefined, 1, 1 );
                }
                
                if ( isdefined( minimapid ) )
                {
                    self.minimapid = minimapid;
                    function_38c992e07c477802( self.minimapid, 1 );
                    function_461834c350793158( self.minimapid, 1 );
                    
                    if ( level.streakglobals.var_3feb5f5305e6fe83 )
                    {
                        function_46a5a0ae8a411d8d( self.minimapid, bundle.var_77216bac95c39355 );
                        function_a9992b78cd05e28b( self.minimapid, bundle.var_4d7d4b6afc661107 );
                        function_82408b23a25468f3( self.minimapid, missilegoalpos );
                    }
                    
                    objective_sethideelevation( self.minimapid, 1 );
                    objective_setminimapiconsize( self.minimapid, "icon_medium" );
                }
            }
            
            if ( isdefined( bundle.minimapicon ) )
            {
                namespace_9d8e359c3b1041e5::setmissileimpactminimapiconsharedfunc( bundle.minimapicon );
            }
            
            break;
        case 2:
            if ( isdefined( bundle.impacticon ) )
            {
                namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
                namespace_9d8e359c3b1041e5::setmissileimpactminimapiconsharedfunc( bundle.impacticon );
            }
            else if ( var_d0fd0dc6e83e37fa == 0 )
            {
                namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
            }
            else
            {
                namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 1 );
            }
            
            if ( isdefined( self.minimapid ) )
            {
                if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
                {
                    [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
                }
                
                self.minimapid = undefined;
            }
            
            break;
        default:
            assertmsg( "<dev string:x7d>" + var_5207c09168cffe2d + "<dev string:x91>" );
            break;
    }
}

// Namespace toma_strike
// Params 2, eflags: 0x4
// Checksum 0x382a0470, Offset: 0x5f20
// Size: 0x16b
function private toma_strike_createmarker( streakinfo, markerorigin )
{
    owner = self;
    
    if ( streakinfo.striketype == 1 && isdefined( streakinfo.targetoverride ) )
    {
        markerorigin = streakinfo.targetoverride;
    }
    
    bundle = streakinfo.bundle;
    marker = spawn( "script_model", markerorigin );
    
    if ( !isdefined( marker ) )
    {
        script::demoforcesre( "Unable to spawn toma strike [toma_strike_createMarker] " + ( markerorigin ?? "unknown origin " ) );
        return;
    }
    
    marker setmodel( bundle.var_a94094e4a53aaa38 ?? "ks_toma_strike_marker_mp" );
    marker.objidnum = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        marker.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
    }
    
    objidpoolmanager::function_e4d6a71507372662( marker.objidnum, 0 );
    marker.icon = bundle.var_7ff6896acc57338 ?? "hud_icon_killstreak_tomastrike";
    marker setotherent( owner );
    marker toma_strike_setmarkerobjective( marker.objidnum, marker.icon, owner, 50 );
    marker thread toma_strike_handlemarkerscriptable();
    return marker;
}

// Namespace toma_strike
// Params 4
// Checksum 0x2281cbe5, Offset: 0x6094
// Size: 0xa6
function toma_strike_setmarkerobjective( objid, icon, owner, offset )
{
    if ( utility::issp() )
    {
        return;
    }
    
    objective_icon( objid, icon );
    objective_showtoplayersinmask( objid );
    objective_addclienttomask( objid, owner );
    objective_onentity( objid, self );
    objective_setzoffset( objid, offset );
    objective_setplayintro( objid, 0 );
    objective_setplayoutro( objid, 0 );
    objective_setbackground( objid, 1 );
    
    if ( level.teambased )
    {
        objective_setownerteam( objid, owner.team );
    }
    else
    {
        objective_setownerclient( objid, owner );
    }
    
    objective_state( objid, "current" );
}

// Namespace toma_strike
// Params 0
// Checksum 0x5556efdf, Offset: 0x6142
// Size: 0xc7
function toma_strike_handlemarkerscriptable()
{
    self endon( #"death" );
    self setscriptablepartstate( "target", "on", 0 );
    self waittill( #"hash_4c1a49a027c1b272", update );
    
    if ( update == "attackStarted" )
    {
        wait 10;
    }
    else
    {
        assert( update == "<dev string:xb4>" );
    }
    
    if ( isdefined( self ) )
    {
        if ( self.objidnum != -1 && !objidpoolmanager::function_fb05d646a96ed99e( self.objidnum ) && utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.objidnum );
        }
        
        self delete();
    }
}

// Namespace toma_strike
// Params 2
// Checksum 0x20f51ee6, Offset: 0x6211
// Size: 0x3d
function toma_strike_rebuild_angles_up_right( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace toma_strike
// Params 2
// Checksum 0x6d907775, Offset: 0x6257
// Size: 0x3d
function toma_strike_rebuild_angles_up_forward( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace toma_strike
// Params 4
// Checksum 0xa3ec2a77, Offset: 0x629d
// Size: 0x2db
function tomastrike_findoptimallaunchpos( markerorigin, var_147ece74855f6277, ownerforward, ownerright )
{
    contents = trace::create_default_contents( 1 );
    trace = trace::ray_trace( markerorigin - var_147ece74855f6277 * 30, markerorigin + var_147ece74855f6277 * 1000, undefined, contents );
    coord = trace[ "position" ] + trace[ "normal" ] * 20;
    targetpos = coord;
    bundle = killstreak::function_85b2d8e857ab4898( "toma_strike" ) ?? { #var_5b4b935104ac5ab6:undefined };
    launchheight = bundle.var_8c0093bd62972936 ?? 5000;
    var_f3401a2195395d24 = bundle.var_576f052fb6674214 ?? 0;
    var_c09eeec12b11a47 = bundle.var_8eb617bdd424ff53 ?? 0;
    var_5b3eac5d3b856cef = 0;
    
    if ( var_c09eeec12b11a47 > 0 )
    {
        var_5b3eac5d3b856cef = randomfloat( var_c09eeec12b11a47 * 2 ) - var_c09eeec12b11a47;
    }
    
    trajectoryangle = ( bundle.var_5b4b935104ac5ab6 ?? 45 ) + var_5b3eac5d3b856cef;
    targetforward = launchheight * tan( trajectoryangle );
    var_4159891f0b5bc03 = [ targetpos + ownerforward * 100, targetpos - ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + ( ownerforward + ownerright ) * 100, targetpos + ( ownerforward - ownerright ) * 100, targetpos + ( ownerright - ownerforward ) * 100, targetpos + ( -1 * ownerforward - ownerright ) * 100 ];
    var_54454e7b516826d3 = vectornormalize( var_4159891f0b5bc03[ 0 ] - targetpos );
    bestlaunchpos = targetpos + ( 0, 0, launchheight ) - var_54454e7b516826d3 * targetforward;
    
    foreach ( dirpos in var_4159891f0b5bc03 )
    {
        direction = vectornormalize( dirpos - targetpos );
        starttracepos = bestlaunchpos;
        
        if ( var_f3401a2195395d24 > 0 )
        {
            starttracepos = targetpos + ( randomfloatrange( var_f3401a2195395d24 * -1, var_f3401a2195395d24 ), randomfloatrange( var_f3401a2195395d24 * -1, var_f3401a2195395d24 ), launchheight + randomfloatrange( var_f3401a2195395d24 * -1, var_f3401a2195395d24 ) ) - direction * targetforward;
        }
        else
        {
            starttracepos = targetpos + ( 0, 0, launchheight ) - direction * targetforward;
        }
        
        endtracepos = targetpos;
        traceresult = trace::ray_trace_passed( starttracepos, endtracepos, undefined, contents );
        
        if ( !traceresult )
        {
            continue;
        }
        
        bestlaunchpos = starttracepos;
        break;
    }
    
    return bestlaunchpos;
}

// Namespace toma_strike
// Params 2
// Checksum 0x53652048, Offset: 0x6581
// Size: 0x23
function function_5b3c77949b8996d7( streakinfo, switchresult )
{
    if ( switchresult )
    {
        thread tomastrike_watchads( streakinfo );
    }
}

// Namespace toma_strike
// Params 1
// Checksum 0x5342669d, Offset: 0x65ac
// Size: 0xa0
function tomastrike_watchads( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"deploy_cancelled" );
    self endon( #"deploy_fired" );
    waitframe();
    self endon( #"weapon_change" );
    airstrike::function_1f199e14c878a314( streakinfo );
    var_b63a200bca5472e1 = 0;
    
    while ( true )
    {
        playerads = self playerads();
        
        if ( playerads == 1 && !var_b63a200bca5472e1 )
        {
            airstrike::function_1f199e14c878a314( streakinfo );
            var_b63a200bca5472e1 = 1;
        }
        else if ( playerads < 1 && var_b63a200bca5472e1 )
        {
            var_b63a200bca5472e1 = 0;
        }
        
        wait 0.5;
    }
}

