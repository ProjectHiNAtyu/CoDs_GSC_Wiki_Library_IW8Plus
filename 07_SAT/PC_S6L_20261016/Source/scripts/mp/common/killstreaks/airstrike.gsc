// scripts\mp\common\killstreaks\airstrike.gsc  (hash_728c42c3a24edb82.gscc) (size: 45803 Bytes / 0xb2eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd4d2865 (3175950437)
// size ...... 45803 (0xb2eb)
// includes .. 20  (offset: 0xa7b7)
// strings ... 132 (offset: 0xa857)
// dev strs .. 16  (offset: 0xb1db)
// exports ... 80  (offset: 0x795b)
// cseg ...... 0xaaf + 0x6eac (0x795b)
// imports ... 255 (offset: 0x85db)
// animtree1 . 1   (offset: 0xb2b3)
// animtree2 . 1   (offset: 0xb2cb)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\napalm_strike_shared;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;

#namespace airstrike;

// Namespace airstrike
// Params 0
// Checksum 0x871e471c, Offset: 0xacd
// Size: 0x2a6
function init()
{
    if ( isdefined( level.sharedfuncs[ #"airstrike" ][ #"init" ] ) )
    {
        level [[ level.sharedfuncs[ #"airstrike" ][ #"init" ] ]]();
    }
    
    level._effect[ "airstrike_tracer" ] = loadfxasset( "vfx_iw8_mp_strk_a10_tracer_sep" );
    utility::registersharedfunc( #"airstrike", #"hash_7b6b2150e411ed64", &function_73e6c1fd9a435b1 );
    
    if ( isdefined( level.sharedfuncs[ #"airstrike" ][ #"airstrike_params" ] ) )
    {
        level [[ level.sharedfuncs[ #"airstrike" ][ #"airstrike_params" ] ]]();
    }
    
    bundle = level.streakglobals.streakbundles[ "precision_airstrike" ];
    
    if ( isdefined( bundle.deployweaponname ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "precision_airstrike", bundle.deployweaponname, #"large" );
    }
    
    bundle = level.streakglobals.streakbundles[ "napalm_strike" ];
    
    if ( isdefined( bundle.deployweaponname ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "naplam_strike", bundle.deployweaponname, #"large" );
    }
    
    init_airstrike_flyby_anims();
    init_airstrike_vo();
    function_fa2de638a8ae8e6d();
    level.activeairstrikes = [];
    level.airstrikecount = 0;
    level.var_42550a45fe36ac22 = getdvarint( @"hash_b17a1f9f7d5c5b0d", 0 );
    level.var_7f037608a27072f4 = getdvarint( @"hash_7017001214d170b1", 0 );
    level.airstrikedangerradius = getdvarint( @"hash_39459995df574c02", 1300 );
    level.var_a2eeb9e32ace684e = getdvarint( @"hash_77900c1535c539f5", 1 );
    level.var_5da8387c8cf123d9 = getdvarint( @"hash_20f5d09c276da17c", 0 );
    level.var_b8195296368ddbda = getdvarint( @"scr_airstrike_notify_time", 0 );
    
    /#
        setdevdvarifuninitialized( @"scr_airstrike_type", 2 );
        setdevdvarifuninitialized( @"hash_f6e58fc941b6935d", 0 );
        setdevdvarifuninitialized( @"scr_debugairstrike", 0 );
        setdevdvarifuninitialized( @"scr_debugairstriketraces", 0 );
    #/
    
    level.airstrikeprops = spawnstruct();
    level.airstrikeprops.mapdraw = getmatchrulesdata( "commonOption", "showAirstrikeOnMap" );
    level.airstrikeprops.var_4d7ca22e5490c24b = float( getmatchrulesdata( "commonOption", "airstrikeZoneVisibleRange" ) );
}

#using_animtree( "script_model" );

// Namespace airstrike
// Params 0
// Checksum 0xb8806498, Offset: 0xd7b
// Size: 0xc6
function init_airstrike_flyby_anims()
{
    level.scr_animtree[ "precision_airstrike" ] = #animtree;
    level.scr_anim[ "precision_airstrike" ][ "airstrike_flyby" ] = %mp_alfa10_flyin;
    level.scr_animtree[ "napalm_strike" ] = #animtree;
    level.scr_anim[ "napalm_strike" ][ "airstrike_flyby" ] = %mp_alfa10_flyin;
    level.scr_animtree[ "multi_airstrike" ] = #animtree;
    level.scr_anim[ "multi_airstrike" ][ "airstrike_flyby" ] = %mp_alfa10_flyin;
    level.scr_animtree[ "fuel_airstrike" ] = #animtree;
    level.scr_anim[ "fuel_airstrike" ][ "airstrike_flyby" ] = %mp_alfa10_flyin;
}

// Namespace airstrike
// Params 0
// Checksum 0x8abc1ca2, Offset: 0xe49
// Size: 0xe3
function init_airstrike_vo()
{
    game[ "dialog" ][ "precision_airstrike_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "precision_airstrike_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "precision_airstrike_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
    game[ "dialog" ][ "napalm_strike_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "napalm_strike_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "napalm_strike_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
    game[ "dialog" ][ "fuel_airstrike_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "fuel_airstrike_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "fuel_airstrike_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace airstrike
// Params 2
// Checksum 0xbb701a7, Offset: 0xf34
// Size: 0x5f
function function_73e6c1fd9a435b1( streakname, bundle )
{
    level.scr_animtree[ streakname ] = bundle.var_24bc0006f7554e55.id;
    level.scr_anim[ streakname ][ "airstrike_flyby" ] = bundle.var_87f14e278eb69465.id;
}

// Namespace airstrike
// Params 0
// Checksum 0x99e3ae20, Offset: 0xf9b
// Size: 0x4e
function function_fa2de638a8ae8e6d()
{
    level.var_dd721280128f94ac = "airstrike_placement";
    val::group_register( level.var_dd721280128f94ac, [ "offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers" ] );
}

// Namespace airstrike
// Params 2
// Checksum 0x89abd01d, Offset: 0xff1
// Size: 0x1d7
function gettimeremainingsec( useresult, strikelocation )
{
    if ( useresult == "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME" )
    {
        shortestleft = undefined;
        
        foreach ( airstrike in level.activeairstrikes )
        {
            timeleft = int( max( 1, airstrike.starttimems + airstrike.timems - gettime() ) );
            
            if ( !isdefined( shortestleft ) || timeleft < shortestleft )
            {
                shortestleft = timeleft;
            }
        }
        
        return ( int( utility::function_6f5d2e1f1ff70482( shortestleft ) ) + 1 );
    }
    
    if ( useresult == "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME" )
    {
        shortestleft = undefined;
        
        foreach ( airstrike in level.activeairstrikes )
        {
            mindistsq = function_6ac2148f634b641d();
            
            if ( distance2dsquared( airstrike.origin, strikelocation ) <= mindistsq )
            {
                timeleft = int( max( 1, airstrike.starttimems + airstrike.timems - gettime() ) );
                
                if ( !isdefined( shortestleft ) || timeleft < shortestleft )
                {
                    shortestleft = timeleft;
                }
            }
        }
        
        return ( int( utility::function_6f5d2e1f1ff70482( shortestleft ) ) + 1 );
    }
}

// Namespace airstrike
// Params 1
// Checksum 0x2cf5efe9, Offset: 0x11d0
// Size: 0x199, Type: bool
function weapongivenairstrike( streakinfo )
{
    if ( !level.in_play_limits_in_use )
    {
        useresult = airstrike_canbeused( streakinfo, self.origin );
        
        if ( useresult != "success" )
        {
            if ( level.var_b8195296368ddbda )
            {
                timesec = gettimeremainingsec( useresult, self.origin );
                
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult, timesec );
                }
            }
            else if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult );
            }
            
            return false;
        }
    }
    
    if ( streakinfo.streakname == "multi_airstrike" )
    {
        if ( utility::issharedfuncdefined( #"airstrike", #"hash_bc456c37cf700436" ) )
        {
            self [[ utility::getsharedfunc( #"airstrike", #"hash_bc456c37cf700436" ) ]]( 0, 1, "long_arrow", undefined, streakinfo );
        }
    }
    else if ( streakinfo.streakname == "fuel_airstrike" )
    {
        if ( utility::issharedfuncdefined( #"airstrike", #"hash_bc456c37cf700436" ) )
        {
            self [[ utility::getsharedfunc( #"airstrike", #"hash_bc456c37cf700436" ) ]]( undefined, undefined, undefined, undefined, streakinfo );
        }
    }
    
    self setclientomnvar( "ui_using_airstrike", 1 );
    return true;
}

// Namespace airstrike
// Params 2
// Checksum 0x81ba8b0a, Offset: 0x1372
// Size: 0x142
function weaponswitchendedairstrike( streakinfo, switchresult )
{
    if ( streakinfo.bundle.airstrike_settings )
    {
        if ( streakinfo.bundle.airstrike_target_type == #"scope" && streakinfo.bundle.var_6de5412893c1f44c )
        {
            thread airstrike_watchforads( streakinfo, streakinfo.bundle.markericon );
        }
        
        return;
    }
    
    airstrikeweapontype = getdvarint( @"scr_airstrike_type", 2 );
    
    if ( streakinfo.bundle.markericon )
    {
        overrideicon = streakinfo.bundle.markericon;
    }
    
    if ( switchresult )
    {
        switch ( streakinfo.streakname )
        {
            case #"hash_80c5f88142053bf4":
                overrideicon = "";
            case #"hash_42fd64e842a4c3d7":
            case #"hash_8c766d6477287bb6":
                if ( airstrikeweapontype == 1 )
                {
                    self laseron();
                }
                else if ( airstrikeweapontype == 2 )
                {
                    thread airstrike_watchforads( streakinfo, overrideicon );
                }
                
                break;
        }
    }
}

// Namespace airstrike
// Params 3
// Checksum 0xcd70d2af, Offset: 0x14bc
// Size: 0x1b2
function weaponfiredairstrike( streakinfo, firedweaponobj, firedprojectile )
{
    self setclientomnvar( "ui_using_airstrike", 0 );
    
    if ( !isdefined( streakinfo.targetoverride ) )
    {
        mappoint = airstrike_getownerlookatpos( self );
        bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
        
        if ( bundle.var_8771a3dbfc3b5dbe && !namespace_9d8e359c3b1041e5::function_99585ce0ed7d5df7( streakinfo, mappoint ) )
        {
            return "continue";
        }
        
        if ( !level.in_play_limits_in_use )
        {
            useresult = airstrike_canbeused( streakinfo, mappoint );
            
            if ( useresult != "success" )
            {
                if ( level.var_b8195296368ddbda )
                {
                    timesec = gettimeremainingsec( useresult, mappoint );
                    
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult, timesec );
                    }
                }
                else if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult );
                }
                
                return "continue";
            }
        }
    }
    
    if ( emp_debuff::is_empd() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
        }
        
        return "continue";
    }
    
    return "success";
}

// Namespace airstrike
// Params 1
// Checksum 0x6b7c305, Offset: 0x1677
// Size: 0x29
function tryuseairstrike( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return tryuseairstrikefromstruct( streakinfo );
}

// Namespace airstrike
// Params 1
// Checksum 0x640b65d, Offset: 0x16a9
// Size: 0x372, Type: bool
function tryuseairstrikefromstruct( streakinfo )
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
    
    self.var_74cf4c4f3d95aaf5 = self getcurrentweapon();
    deployresult = undefined;
    airstrikeeventname = "";
    
    if ( streakinfo.bundle.airstrike_settings )
    {
        deployweaponobj = weapon_utility::function_d2c8356dc369d9ce( streakinfo.bundle.deployweaponname ?? "iw9_spotter_scope_mp" );
        
        if ( isbrgamemode() && self.kstargetlocation )
        {
            streakinfo.targetoverride = self.kstargetlocation;
            self.kstargetlocation = undefined;
        }
        
        if ( streakinfo.targetoverride )
        {
            firedresult = weaponfiredairstrike( streakinfo, undefined, undefined );
            deployresult = firedresult == "success";
        }
        else
        {
            if ( level.var_dd721280128f94ac )
            {
                streakinfo.var_21f1b0b4d8d3ea8f = level.var_dd721280128f94ac;
            }
            
            deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweaponobj, "weapon_fired", &weapongivenairstrike, &weaponswitchendedairstrike, &weaponfiredairstrike );
        }
        
        airstrikeeventname = "precisionAirStrikeUsed";
    }
    else
    {
        deployweaponobj = level.airstrikesettings[ streakinfo.streakname ].deployweaponobj;
        
        switch ( streakinfo.streakname )
        {
            case #"hash_42fd64e842a4c3d7":
            case #"hash_8c766d6477287bb6":
                if ( isbrgamemode() && isdefined( self.kstargetlocation ) )
                {
                    streakinfo.targetoverride = self.kstargetlocation;
                    self.kstargetlocation = undefined;
                }
                
                if ( isdefined( streakinfo.targetoverride ) )
                {
                    firedresult = weaponfiredairstrike( streakinfo, undefined, undefined );
                    deployresult = firedresult == "success";
                }
                else
                {
                    if ( isdefined( level.var_dd721280128f94ac ) )
                    {
                        streakinfo.var_21f1b0b4d8d3ea8f = level.var_dd721280128f94ac;
                    }
                    
                    deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweaponobj, "weapon_fired", &weapongivenairstrike, &weaponswitchendedairstrike, &weaponfiredairstrike );
                }
                
                airstrikeeventname = "precisionAirStrikeUsed";
                break;
            case #"hash_4220be38a5f150b8":
            case #"hash_62810d05099e0103":
                deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &weapongivenairstrike, &weaponswitchendedairstrike );
                airstrikeeventname = "fuelAirStrikeUsed";
                break;
        }
    }
    
    if ( !deployresult )
    {
        self setclientomnvar( "ui_using_airstrike", 0 );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    useresult = selectairstrikelocation( streakinfo );
    
    if ( !useresult )
    {
        return false;
    }
    
    if ( streakinfo.streakname == "precision_airstrike" )
    {
        self.var_5d67576f2d0341bc = gettime();
    }
    
    if ( utility::issharedfuncdefined( #"airstrike", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"airstrike", #"munitionused" ) ]]( streakinfo );
    }
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, airstrikeeventname );
    }
    
    return true;
}

// Namespace airstrike
// Params 1
// Checksum 0x3443bd55, Offset: 0x1a24
// Size: 0x5ce, Type: bool
function selectairstrikelocation( streakinfo )
{
    mappoint = ( 0, 0, 0 );
    mappointinfo = undefined;
    targetmarker = undefined;
    directionalselection = undefined;
    splashref = "used_" + streakinfo.streakname;
    
    if ( streakinfo.bundle.airstrike_settings )
    {
        mappoint = streakinfo.targetoverride ? streakinfo.targetoverride : airstrike_getownerlookatpos( self, 1 );
    }
    else if ( streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "napalm_strike" )
    {
        if ( isdefined( streakinfo.targetoverride ) )
        {
            mappoint = streakinfo.targetoverride;
        }
        else
        {
            mappoint = airstrike_getownerlookatpos( self, 1 );
        }
    }
    else if ( streakinfo.streakname == "multi_airstrike" )
    {
        var_1c3990ebf042c055 = 3;
        directionalselection = 1;
        val::set( "select_airstrike_location", "weapon_switch", 0 );
        self setsoundsubmix( "mp_killstreak_overlay" );
        mappointinfo = undefined;
        
        if ( utility::issharedfuncdefined( #"airstrike", #"getselectmappoint" ) )
        {
            mappointinfo = self [[ utility::getsharedfunc( #"airstrike", #"getselectmappoint" ) ]]( streakinfo, var_1c3990ebf042c055, 1 );
        }
        
        val::reset_all( "select_airstrike_location" );
    }
    else if ( streakinfo.streakname == "fuel_airstrike" )
    {
        var_1c3990ebf042c055 = 3;
        val::set( "select_airstrike_location", "weapon_switch", 0 );
        self setsoundsubmix( "mp_killstreak_overlay" );
        mappointinfo = undefined;
        
        if ( utility::issharedfuncdefined( #"airstrike", #"getselectmappoint" ) )
        {
            mappointinfo = self [[ utility::getsharedfunc( #"airstrike", #"getselectmappoint" ) ]]( streakinfo, var_1c3990ebf042c055 );
        }
        
        val::reset_all( "select_airstrike_location" );
    }
    
    if ( isdefined( mappointinfo ) )
    {
        foreach ( info in mappointinfo )
        {
            useresult = airstrike_canbeused( streakinfo, info.location );
            
            if ( useresult != "success" )
            {
                if ( level.var_b8195296368ddbda )
                {
                    timesec = gettimeremainingsec( useresult, info.location );
                    
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult, timesec );
                    }
                }
                else if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult );
                }
                
                return false;
            }
        }
        
        thread finishmapselectairstrikeusage( mappointinfo, directionalselection, mappoint, targetmarker, streakinfo );
        self clearsoundsubmix( "mp_killstreak_overlay" );
    }
    
    if ( streakinfo.bundle.airstrike_settings )
    {
        if ( !emp_debuff::is_empd() )
        {
            thread finishstandardairstrikeusage( mappoint, targetmarker, streakinfo );
        }
    }
    else if ( !isdefined( mappointinfo ) && ( streakinfo.streakname == "multi_airstrike" || streakinfo.streakname == "fuel_airstrike" ) )
    {
        self clearsoundsubmix( "mp_killstreak_overlay" );
        return false;
    }
    else if ( streakinfo.streakname == "precision_airstrike" )
    {
        if ( !emp_debuff::is_empd() )
        {
            thread finishstandardairstrikeusage( mappoint, targetmarker, streakinfo );
        }
    }
    else if ( streakinfo.streakname == "napalm_strike" )
    {
        mappointinfo = { #angles:( self.angles[ 1 ] + ( streakinfo.rotation ?? 0 ) ) % 360, #location:mappoint };
        thread napalm_strike_shared::function_fa0f45ba10feed3d( streakinfo, mappointinfo );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    self notify( #"successful_fire" );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( splashref, self );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakinfo.streakname, mappoint );
    }
    
    if ( level.var_a2eeb9e32ace684e )
    {
        killstreak_utility::killstreak_dangernotifyplayersinrange( self, self.team, level.airstrikedangerradius, streakinfo.streakname, mappoint, isbrgamemode() ? 6000 : 1000, streakinfo.bundle.var_3b809fb44d3a9e3c, mappointinfo.angles ?? self.angles[ 1 ] );
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 3;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, streakinfo.streakname + "_use", #"use", 1, var_65934120c2efeb81 );
    return true;
}

// Namespace airstrike
// Params 2
// Checksum 0xa2e9a0e9, Offset: 0x1ffb
// Size: 0x27, Type: bool
function function_e9578c9ff31bc96( strikenumber, mappointinfo )
{
    return mappointinfo.size > 1 && strikenumber < mappointinfo.size - 1;
}

// Namespace airstrike
// Params 1
// Checksum 0x8f09767d, Offset: 0x202b
// Size: 0xc8
function function_4b1898a568db9b24( mappointinfo )
{
    strikedelays = [];
    totaldelay = 0;
    
    foreach ( strikenumber, pointinfo in mappointinfo )
    {
        if ( function_e9578c9ff31bc96( strikenumber, mappointinfo ) )
        {
            nextdelay = randomfloatrange( 0.8, 1 );
            totaldelay += nextdelay;
            strikedelays[ strikenumber ] = nextdelay;
        }
    }
    
    return [ totaldelay, strikedelays ];
}

// Namespace airstrike
// Params 5
// Checksum 0x8221d74e, Offset: 0x20fc
// Size: 0x256
function finishmapselectairstrikeusage( mappointinfo, directionalselection, mappoint, targetmarker, streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    animname = level.scr_anim[ streakinfo.streakname ][ "airstrike_flyby" ];
    strikeanimlength = getanimlength( animname );
    var_75da1ce20ce2f629 = utility::get_notetrack_time( animname, "attack" );
    var_f2b8f790428b478f = strikeanimlength - 5;
    [ totaldelay, strikedelays ] = function_4b1898a568db9b24( mappointinfo );
    airstrikeid = airstrike_addactivestrike( self.origin, self, var_f2b8f790428b478f + totaldelay );
    thread airstrike_watchkills( streakinfo, var_75da1ce20ce2f629 * 2, airstrikeid );
    thread watchairstrikeowner( airstrikeid );
    thread airstrike_watchgameend( streakinfo, airstrikeid );
    
    foreach ( strikenumber, pointinfo in mappointinfo )
    {
        mappoint = pointinfo.location;
        directionyaw = self.angles[ 1 ];
        
        if ( directionalselection )
        {
            directionyaw = pointinfo.angles;
        }
        
        finishairstrikeusage( mappoint, directionyaw, targetmarker, streakinfo, animname, airstrikeid );
        
        if ( function_e9578c9ff31bc96( strikenumber, mappointinfo ) )
        {
            wait strikedelays[ strikenumber ];
        }
    }
    
    level thread function_f767ade14cc614ec( self, airstrikeid, var_f2b8f790428b478f );
    hostmigration::waitlongdurationwithpause( strikeanimlength );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x24>" + streakinfo.streakname, self );
        }
    #/
    
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace airstrike
// Params 3
// Checksum 0x3586dfc6, Offset: 0x235a
// Size: 0x2c1
function finishstandardairstrikeusage( location, targetmarker, streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    animname = level.scr_anim[ streakinfo.streakname ][ "airstrike_flyby" ];
    strikeanimlength = getanimlength( animname );
    var_75da1ce20ce2f629 = utility::get_notetrack_time( animname, "attack" );
    var_f2b8f790428b478f = strikeanimlength - 11;
    airstrikeid = airstrike_addactivestrike( location, self, var_f2b8f790428b478f );
    thread airstrike_watchkills( streakinfo, var_75da1ce20ce2f629 * 2, airstrikeid );
    thread watchairstrikeowner( airstrikeid );
    thread airstrike_watchgameend( streakinfo, airstrikeid );
    directionyaw = undefined;
    
    if ( streakinfo.bundle.var_f1d2ae7ed36e4b82 && isplayer( self ) )
    {
        directionyaw = self.angles[ 1 ];
    }
    
    if ( isdefined( streakinfo.directionyawoverride ) )
    {
        directionyaw = streakinfo.directionyawoverride;
    }
    
    finishairstrikeusage( location, directionyaw, targetmarker, streakinfo, animname, airstrikeid );
    level thread function_f767ade14cc614ec( self, airstrikeid, var_f2b8f790428b478f );
    
    if ( streakinfo.bundle.var_ce39e27ec067b60 )
    {
        strikeanimlength = streakinfo.bundle.var_ce39e27ec067b60;
    }
    
    if ( streakinfo.bundle.airstrike_settings && streakinfo.bundle.var_dd70dbbeefe6017b )
    {
        strikeanimlength -= streakinfo.bundle.var_dd70dbbeefe6017b;
    }
    
    hostmigration::waitlongdurationwithpause( strikeanimlength );
    
    for ( i = 0; i < ( streakinfo.bundle.var_c26d238c3c9b0f6f ?? 1 ) ; i++ )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ getxhash( streakinfo.streakname ) ][ #"hash_f5fca5626ef5bce9" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self thread [[ var_32dbca3143d9c4a5 ]]( location );
        }
        
        wait streakinfo.bundle.var_f178c84835190a4f ?? 0;
    }
    
    level callback::callback( #"killstreak_finish_use", { #location:location, #streakinfo:streakinfo } );
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x24>" + streakinfo.streakname, self );
        }
    #/
    
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace airstrike
// Params 6
// Checksum 0x1cc4f7f0, Offset: 0x2623
// Size: 0x71
function finishairstrikeusage( location, directionyaw, targetmarker, streakinfo, animname, airstrikeid )
{
    self notify( #"used" );
    self notify( #"airstrike_used" );
    doairstrike( location, directionyaw, self, self.pers[ "team" ], targetmarker, streakinfo, animname, airstrikeid );
}

// Namespace airstrike
// Params 8
// Checksum 0x4d27c9d2, Offset: 0x269c
// Size: 0x68
function doairstrike( origin, yaw, owner, team, targetmarker, streakinfo, animname, airstrikeid )
{
    assert( isdefined( origin ) );
    level thread callstrike( owner, origin, yaw, targetmarker, streakinfo, animname, airstrikeid );
}

// Namespace airstrike
// Params 1
// Checksum 0x36f08ce7, Offset: 0x270c
// Size: 0x43
function watchairstrikeowner( airstrikeid )
{
    level endon( "airstrike_finished" + "_" + airstrikeid );
    level endon( #"game_ended" );
    utility::waittill_any( "disconnect", "joined_team" );
    airstrike_removeactivestrike( airstrikeid );
}

// Namespace airstrike
// Params 7
// Checksum 0x6868cf1e, Offset: 0x2757
// Size: 0x686
function callstrike( owner, coord, yaw, targetmarker, streakinfo, animname, airstrikeid )
{
    var_52a7c56f48361b92 = 0;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    planehalfdistance = 24000;
    planeflyspeed = 6500;
    planeflyheight = 2500;
    var_52a7c56f48361b92 = 1500;
    
    if ( isdefined( heightent ) )
    {
        planeflyheight = heightent.origin[ 2 ];
    }
    
    if ( isdefined( streakinfo.planeflyheightoverride ) )
    {
        planeflyheight = streakinfo.planeflyheightoverride;
    }
    else if ( isdefined( streakinfo.bundle.var_85ece3782dc656bb ) )
    {
        planeflyheight = streakinfo.bundle.var_85ece3782dc656bb;
    }
    else
    {
        localeid = game_utility::getlocaleid();
        
        if ( localeid == "locale_6" )
        {
            planeflyheight += 500;
        }
        
        if ( game_utility::islargemap() )
        {
            planeflyheight += getdvarint( @"hash_d4fc72a2dd7e5e3a", 2500 );
        }
        
        /#
            var_2672c681761eb965 = getdvarint( @"hash_698613e6c8c52243", 0 );
            planeflyheight += var_2672c681761eb965;
        #/
    }
    
    var_52a7c56f48361b92 = getexplodedistance( planeflyheight );
    direction = undefined;
    var_2df14d15022f74fc = undefined;
    
    if ( isdefined( yaw ) )
    {
        direction = ( 0, yaw, 0 );
    }
    else
    {
        direction = callstrike_findoptimaldirection( owner, coord, planeflyheight, planehalfdistance );
        var_2df14d15022f74fc = 1;
    }
    
    flightpath = getflightpath( coord, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_52a7c56f48361b92, streakinfo.streakname, var_2df14d15022f74fc );
    
    if ( streakinfo.bundle.airstrike_settings )
    {
        if ( owner emp_debuff::is_empd() )
        {
            return;
        }
        
        var_22b95d281e70befb = streakinfo.bundle.var_2b3e910f133ca69f;
        airstrikecircles = {};
        
        if ( var_22b95d281e70befb )
        {
            sizemultiplier = getmatchrulesdata( "commonOption", "airstrikeZoneSizeMultiplier" );
            
            if ( sizemultiplier <= 1 )
            {
                sizemultiplier = 1;
            }
            
            flightdir = vectornormalize( flightpath[ "endPoint" ] - flightpath[ "startPoint" ] );
            airstrikecircles.owner = owner;
            airstrikecircles.damagepos = coord;
            stretchmultiplier = 5.41333;
            var_f8068b0b6432fcdf = function_2ea7adb19ae7907c( coord, flightdir, 300, stretchmultiplier );
            airstrikecircles.enemycircle = function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, 0, sizemultiplier, 300, stretchmultiplier );
            airstrikecircles.friendlycircle = function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, 1, sizemultiplier, 300, stretchmultiplier );
            function_ab921f167ae4f60( owner, airstrikeid, var_f8068b0b6432fcdf, flightdir, streakinfo.streakname, planeflyheight );
            
            /#
                if ( getdvarint( @"hash_de3bb82d99946baf", 0 ) )
                {
                    airstrikecircles.debugcircle = function_b0d8b242379ba61( coord, flightdir, 0, 1 );
                    airstrikecircles function_afdb990176a991aa( var_f8068b0b6432fcdf, flightdir );
                }
            #/
            
            airstrikecircles thread function_a70c0b39149ecb27();
        }
        
        if ( level.var_d8f10f1cfdbaac7e )
        {
            thread [[ level.var_d8f10f1cfdbaac7e ]]( streakinfo );
        }
        
        for ( i = 0; i < ( streakinfo.bundle.var_c26d238c3c9b0f6f ?? 1 ) ; i++ )
        {
            if ( !isdefined( streakinfo.planeflyheightoverride ) && !isdefined( streakinfo.bundle.var_85ece3782dc656bb ) )
            {
                planeflyheight += randomintrange( 200, 300 );
            }
            
            if ( !owner emp_debuff::is_empd() )
            {
                level thread doplanestrike( coord, flightpath[ "startPoint" ], flightpath[ "endPoint" ], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid );
            }
            
            wait streakinfo.bundle.var_f178c84835190a4f ?? 0;
        }
        
        thread function_61dfbab623d6717( streakinfo );
        
        if ( var_22b95d281e70befb )
        {
            wait 4;
            airstrikecircles thread function_7224c68634b1cf55();
        }
        
        return;
    }
    
    if ( streakinfo.streakname == "precision_airstrike" )
    {
        if ( !owner emp_debuff::is_empd() )
        {
            var_22b95d281e70befb = level.airstrikeprops.mapdraw;
            airstrikecircles = spawnstruct();
            
            if ( var_22b95d281e70befb )
            {
                sizemultiplier = getmatchrulesdata( "commonOption", "airstrikeZoneSizeMultiplier" );
                
                if ( sizemultiplier <= 1 )
                {
                    sizemultiplier = 1;
                }
                
                flightdir = vectornormalize( flightpath[ "endPoint" ] - flightpath[ "startPoint" ] );
                airstrikecircles.owner = owner;
                airstrikecircles.damagepos = coord;
                stretchmultiplier = 5.41333;
                var_f8068b0b6432fcdf = function_2ea7adb19ae7907c( coord, flightdir, 300, stretchmultiplier );
                airstrikecircles.enemycircle = function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, 0, sizemultiplier, 300, stretchmultiplier );
                airstrikecircles.friendlycircle = function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, 1, sizemultiplier, 300, stretchmultiplier );
                function_ab921f167ae4f60( owner, airstrikeid, var_f8068b0b6432fcdf, flightdir, streakinfo.streakname, planeflyheight );
                
                /#
                    var_b255dd561badba32 = getdvarint( @"hash_de3bb82d99946baf", 0 );
                    
                    if ( var_b255dd561badba32 )
                    {
                        airstrikecircles.debugcircle = function_b0d8b242379ba61( coord, flightdir, 0, 1 );
                        airstrikecircles function_afdb990176a991aa( var_f8068b0b6432fcdf, flightdir );
                    }
                #/
                
                airstrikecircles thread function_a70c0b39149ecb27();
            }
            
            if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
            {
                thread [[ level.var_d8f10f1cfdbaac7e ]]( streakinfo );
            }
            
            numstrikes = 2;
            
            for ( i = 0; i < numstrikes ; i++ )
            {
                if ( !isdefined( streakinfo.planeflyheightoverride ) )
                {
                    planeflyheight += randomintrange( 200, 300 );
                }
                
                if ( !owner emp_debuff::is_empd() )
                {
                    level thread doplanestrike( coord, flightpath[ "startPoint" ], flightpath[ "endPoint" ], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid );
                }
                
                var_8ca0b933ffb61fde = streakinfo.var_c8000fc9c5002f1e ?? 3;
                wait var_8ca0b933ffb61fde;
            }
            
            thread function_61dfbab623d6717( streakinfo );
            
            if ( var_22b95d281e70befb )
            {
                wait 4;
                airstrikecircles thread function_7224c68634b1cf55();
            }
        }
        
        return;
    }
    
    if ( streakinfo.streakname == "fuel_airstrike" )
    {
        if ( !owner emp_debuff::is_empd() )
        {
            level thread doplanestrike( coord, flightpath[ "startPoint" ], flightpath[ "endPoint" ], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid );
        }
        
        return;
    }
    
    level thread doplanestrike( coord, flightpath[ "startPoint" ], flightpath[ "endPoint" ], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid );
}

// Namespace airstrike
// Params 1
// Checksum 0x8a310dd3, Offset: 0x2de5
// Size: 0x2a
function function_61dfbab623d6717( streakinfo )
{
    wait 5;
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( streakinfo );
    }
}

// Namespace airstrike
// Params 6
// Checksum 0x8f963658, Offset: 0x2e17
// Size: 0x4e1
function callstrike_findoptimaldirection( owner, coord, planeflyheight, planehalfdistance, loopcount, var_a826e9e4efad514e )
{
    if ( var_a826e9e4efad514e )
    {
        coord += anglestoup( owner.angles ) * 20;
    }
    else
    {
        var_147ece74855f6277 = anglestoforward( owner getplayerangles() );
        contents = trace::create_default_contents( 1 );
        trace = trace::ray_trace( coord - var_147ece74855f6277 * 30, coord + var_147ece74855f6277 * 1000, undefined, contents );
        coord = trace[ "position" ] + trace[ "normal" ] * 20;
    }
    
    targetpos = coord;
    targetheightoffset = planeflyheight;
    ownerforward = anglestoforward( owner.angles );
    ownerright = anglestoright( owner.angles );
    var_4159891f0b5bc03 = [ targetpos + ownerforward * 100, targetpos - ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + ( ownerforward + ownerright ) * 100, targetpos + ( ownerforward - ownerright ) * 100, targetpos + ( ownerright - ownerforward ) * 100, targetpos + ( -1 * ownerforward - ownerright ) * 100 ];
    
    if ( coord[ 2 ] > planeflyheight )
    {
        targetheightoffset = coord[ 2 ] + planeflyheight - owner.origin[ 2 ];
    }
    
    if ( !isdefined( loopcount ) )
    {
        loopcount = 0;
    }
    
    if ( level.var_42550a45fe36ac22 )
    {
        bestdirection = vectornormalize( var_4159891f0b5bc03[ 2 ] - targetpos );
    }
    else
    {
        bestdirection = vectornormalize( var_4159891f0b5bc03[ 0 ] - targetpos );
    }
    
    var_102bbb6895ac37ca = 0;
    bestfraction = 0;
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstriketraces", 0 );
    #/
    
    tracepassed = 0;
    
    foreach ( dirpos in var_4159891f0b5bc03 )
    {
        var_8ba4b8834e7ce583 = vectornormalize( dirpos - targetpos );
        var_95a138eeb696530a = targetpos * ( 1, 1, 0 ) + ( 0, 0, targetheightoffset );
        var_abf75242f26b5e61 = var_95a138eeb696530a - var_8ba4b8834e7ce583 * planehalfdistance;
        var_fe99d25d98da8c34 = var_95a138eeb696530a + var_8ba4b8834e7ce583 * planehalfdistance;
        traceresult = trace::ray_trace_passed( var_abf75242f26b5e61, var_fe99d25d98da8c34, undefined, contents );
        
        if ( !traceresult )
        {
            continue;
        }
        else
        {
            tracepassed = 1;
        }
        
        /#
            if ( airstrikedebugon )
            {
                level thread debug_utility::drawline( var_abf75242f26b5e61, var_fe99d25d98da8c34, 30, ( 1, 1, 0 ) );
            }
        #/
        
        var_74b5881494d6d647 = var_95a138eeb696530a - var_8ba4b8834e7ce583 * int( planehalfdistance / 3 );
        var_34a14ec7788b1717 = [ targetpos, targetpos - var_8ba4b8834e7ce583 * 512, targetpos - var_8ba4b8834e7ce583 * 256, targetpos + var_8ba4b8834e7ce583 * 256, targetpos + var_8ba4b8834e7ce583 * 512 ];
        successfulhits = 0;
        
        foreach ( endtracepos in var_34a14ec7788b1717 )
        {
            results = trace::ray_trace( var_74b5881494d6d647, endtracepos, undefined, contents );
            traceresult = results[ "fraction" ] == 1;
            
            if ( level.var_7f037608a27072f4 )
            {
                if ( results[ "fraction" ] > bestfraction )
                {
                    bestdirection = var_8ba4b8834e7ce583;
                    bestfraction = results[ "fraction" ];
                }
            }
            
            if ( !traceresult )
            {
                /#
                    if ( airstrikedebugon )
                    {
                        line( var_74b5881494d6d647, results[ "<dev string:x38>" ], ( 1, 1, 0 ), 1, 0, 500 );
                        line( results[ "<dev string:x38>" ], endtracepos, ( 1, 0, 0 ), 1, 0, 500 );
                    }
                #/
                
                wait 0.05;
                continue;
            }
            
            successfulhits++;
            
            /#
                if ( airstrikedebugon )
                {
                    line( var_74b5881494d6d647, endtracepos, ( 0, 1, 0 ), 1, 0, 500 );
                }
            #/
            
            wait 0.05;
        }
        
        if ( successfulhits > var_102bbb6895ac37ca )
        {
            bestdirection = var_8ba4b8834e7ce583;
            var_102bbb6895ac37ca = successfulhits;
            
            if ( successfulhits >= 3 )
            {
                break;
            }
        }
    }
    
    if ( !tracepassed && loopcount < 3 )
    {
        bestdirection = callstrike_findoptimaldirection( owner, coord, planeflyheight + 500, planehalfdistance, loopcount + 1 );
    }
    
    return bestdirection;
}

// Namespace airstrike
// Params 9
// Checksum 0x2696cfd3, Offset: 0x3301
// Size: 0x9dc
function doplanestrike( targetsite, var_bbcd7c6de5c8f8b, var_4c67c7deb1a274ee, planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_3d90777bfb7fc504 ) )
    {
        badplace = function_30c25bea1909556f( targetsite, ( level.airstrikedangerradius, level.airstrikedangerradius, 100 ), ( 0, 0, 0 ), level.var_3d90777bfb7fc504 );
    }
    else
    {
        badplace = createnavbadplacebybounds( targetsite, ( level.airstrikedangerradius, level.airstrikedangerradius, 100 ), ( 0, 0, 0 ) );
    }
    
    owner thread function_6f9faf7f2510c659( badplace, airstrikeid );
    
    if ( streakinfo.streakname != "precision_airstrike" && isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( streakinfo, targetsite );
    }
    
    strikeanimlength = getanimlength( animname );
    var_4b1088f3f528603 = utility::get_notetrack_time( animname, "attack" );
    planestartpos = targetsite * ( 1, 1, 0 ) + ( 0, 0, planeflyheight );
    var_aa3618dd78b3981d = vectortoangles( var_4c67c7deb1a274ee - var_bbcd7c6de5c8f8b );
    
    if ( streakinfo.bundle.airstrike_settings )
    {
        planemodel = streakinfo.bundle.var_13f11f54006e1ded;
    }
    else
    {
        planemodel = level.airstrikesettings[ streakinfo.streakname ].modelbase;
    }
    
    plane = spawn( "script_model", planestartpos );
    plane setmodel( planemodel );
    plane.angles = var_aa3618dd78b3981d;
    plane.flightdir = anglestoforward( var_aa3618dd78b3981d );
    plane.flightheight = planeflyheight;
    plane.owner = owner;
    plane.team = owner.team;
    plane.lifeid = streakinfo.lifeid;
    plane.streakinfo = streakinfo;
    plane.airstrikeid = airstrikeid;
    plane setotherent( owner );
    plane scriptmoveroutline();
    plane scriptmoverthermal();
    plane scriptmoverplane();
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        plane [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    }
    
    if ( utility::issharedfuncdefined( #"br", #"challengeevaluator" ) )
    {
        paramstruct = spawnstruct();
        paramstruct.plane = plane;
        paramstruct.targetsite = targetsite;
        owner [[ utility::getsharedfunc( #"br", #"challengeevaluator" ) ]]( "br_mastery_pointBlank_airstrike", paramstruct );
    }
    
    planeicon = "hud_icon_minimap_killstreak_airstrike";
    
    if ( streakinfo.bundle.airstrike_settings && streakinfo.bundle.var_86c8c8df7b6fba01 )
    {
        planeicon = streakinfo.bundle.var_86c8c8df7b6fba01;
    }
    else if ( streakinfo.streakname == "fuel_airstrike" )
    {
        planeicon = "hud_icon_minimap_killstreak_fuel_airstrike";
    }
    
    plane.minimapid = plane objidpoolmanager::createobjective( planeicon, plane.team, undefined, 1, 1 );
    function_38c992e07c477802( plane.minimapid, 1 );
    
    if ( level.streakglobals.var_3feb5f5305e6fe83 )
    {
        function_46a5a0ae8a411d8d( plane.minimapid, streakinfo.bundle.var_77216bac95c39355 );
        function_a9992b78cd05e28b( plane.minimapid, streakinfo.bundle.var_4d7d4b6afc661107 );
        function_82408b23a25468f3( plane.minimapid, targetsite );
    }
    
    var_74793eabc3f75fc = var_4b1088f3f528603 - 0.75;
    var_9daf341a437915da = 0.05;
    var_9de01f1a43af76e8 = var_74793eabc3f75fc;
    var_9ac627c2a5aa0173 = 8.596;
    
    if ( streakinfo.streakname == "fuel_airstrike" )
    {
        var_74793eabc3f75fc = var_4b1088f3f528603 + 1;
    }
    
    if ( isbrgamemode() )
    {
        var_74793eabc3f75fc = var_4b1088f3f528603 - 1;
    }
    
    if ( streakinfo.bundle.var_ed6b005860552a0c )
    {
        var_74793eabc3f75fc = var_4b1088f3f528603 - streakinfo.bundle.var_ed6b005860552a0c;
    }
    
    if ( streakinfo.bundle.airstrike_settings && streakinfo.bundle.var_4216358a11dc821c )
    {
        var_1cc3597535367267 = streakinfo.bundle.var_4216358a11dc821c;
    }
    else
    {
        var_1cc3597535367267 = level.airstrikesettings[ streakinfo.streakname ].var_a9893cd64762fe63 ?? "ks_airstrike_mp";
    }
    
    if ( streakinfo.bundle.airstrike_settings && streakinfo.bundle.var_b3662eee215fd785 )
    {
        playsoundatpos( targetsite + ( 0, 0, 7000 ), streakinfo.bundle.var_b3662eee215fd785 );
    }
    
    plane thread airstrike_delayplayscriptable( 0.05 );
    level thread airstrike_playplaneattackfx( plane, var_74793eabc3f75fc, streakinfo );
    level airstrike_playflyfx( plane, var_1cc3597535367267, var_bbcd7c6de5c8f8b, anglestoforward( var_aa3618dd78b3981d ), var_9daf341a437915da, var_9de01f1a43af76e8, var_9ac627c2a5aa0173, strikeanimlength, streakinfo );
    plane.bulletpoint = spawn( "script_model", plane.origin );
    
    if ( streakinfo.bundle.airstrike_settings && streakinfo.bundle.var_757b2440fa1cce32 )
    {
        plane.bulletpoint setmodel( streakinfo.bundle.var_757b2440fa1cce32 );
    }
    else
    {
        plane.bulletpoint setmodel( "ks_airstrike_target_mp" );
    }
    
    plane.bulletpoint setentityowner( owner );
    plane.bulletpoint.weapon_name = "artillery_mp";
    plane.bulletpoint.streakinfo = streakinfo;
    plane.bulletpoint.angles = plane.angles;
    plane.bulletpoint dontinterpolate();
    plane.animname = streakinfo.streakname;
    plane animation::setanimtree();
    plane.scenenode = spawn( "script_model", planestartpos );
    plane.scenenode.angles = plane.angles;
    plane.scenenode setmodel( "tag_origin" );
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            plane thread debugairstrikeline( var_bbcd7c6de5c8f8b, var_4c67c7deb1a274ee, ( 1, 1, 1 ), 20 );
            plane thread function_bc7388025d453a4e( planeflyheight - targetsite[ 2 ], targetsite );
        }
    #/
    
    if ( streakinfo.bundle.airstrike_settings )
    {
        if ( streakinfo.bundle.var_c925fe82805624fa == #"cannon" )
        {
            level thread callstrike_precisionbulleteffect( plane, var_74793eabc3f75fc, strikeanimlength, targetsite, owner, streakinfo );
        }
    }
    else if ( streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "multi_airstrike" )
    {
        level thread callstrike_precisionbulleteffect( plane, var_74793eabc3f75fc, strikeanimlength, targetsite, owner, streakinfo );
    }
    else if ( streakinfo.streakname == "fuel_airstrike" )
    {
        level thread function_8fcae754374c2868( plane, var_74793eabc3f75fc, strikeanimlength, targetsite, owner, streakinfo );
    }
    
    plane.scenenode animation::anim_single_solo( plane, "airstrike_flyby" );
    
    if ( isdefined( plane.minimapid ) )
    {
        if ( !plane.removedobjid )
        {
            plane.removedobjid = 1;
            
            if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
            {
                [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( plane.minimapid );
            }
        }
    }
    
    plane notify( #"delete" );
    
    if ( isdefined( plane.turrettarget ) )
    {
        plane.turrettarget delete();
    }
    
    if ( isdefined( plane.bulletpoint ) )
    {
        plane.bulletpoint delete();
        
        if ( isdefined( plane.bulletpoint.killcament ) )
        {
            plane.bulletpoint.killcament delete();
        }
    }
    
    if ( isdefined( plane.scenenode ) )
    {
        plane.scenenode delete();
    }
    
    if ( isdefined( plane ) )
    {
        plane delete();
    }
    
    if ( streakinfo.streakname != "precision_airstrike" && isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( streakinfo );
    }
}

// Namespace airstrike
// Params 3
// Checksum 0x5989f3ae, Offset: 0x3ce5
// Size: 0xa1
function airstrike_playplaneattackfx( plane, var_74793eabc3f75fc, streakinfo )
{
    plane endon( #"death" );
    level endon( #"game_ended" );
    
    if ( streakinfo.streakname == "fuel_airstrike" )
    {
        return;
    }
    
    hostmigration::waitlongdurationwithpause( var_74793eabc3f75fc );
    
    if ( plane )
    {
        playsoundatpos( plane.origin, "ks_a10_fire_dist_crack" );
        plane setscriptablepartstate( "fire", "on", 0 );
        plane waittill( #"fire_finished" );
        plane setscriptablepartstate( "fire", "off", 0 );
    }
}

// Namespace airstrike
// Params 9
// Checksum 0xf4057a9e, Offset: 0x3d8e
// Size: 0xd8
function airstrike_playflyfx( plane, var_1cc3597535367267, planestartpos, var_aa3618dd78b3981d, var_9daf341a437915da, var_9de01f1a43af76e8, var_9ac627c2a5aa0173, var_4cb38e466d08f81b, streakinfo )
{
    flyoutfx = spawn( "script_model", planestartpos );
    flyoutfx setmodel( var_1cc3597535367267 );
    flyoutfx dontinterpolate();
    flyoutfx thread airstrike_playapproachfx( var_9daf341a437915da );
    flyoutfx thread airstrike_playflybyfx( var_9de01f1a43af76e8 );
    flyoutfx thread airstrike_playflyoutfx( var_9ac627c2a5aa0173 );
    flyoutfx thread airstrike_handleflyoutfxdeath( var_4cb38e466d08f81b );
    flyoutfx thread airstrike_movewithplane( plane );
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            level thread testsoundplacement( flyoutfx );
        }
    #/
    
    return flyoutfx;
}

// Namespace airstrike
// Params 1
// Checksum 0x6414c332, Offset: 0x3e6f
// Size: 0x3e
function airstrike_playapproachfx( var_d9e2a891ce8fad8c )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( var_d9e2a891ce8fad8c );
    self setscriptablepartstate( "approach", "on", 0 );
}

// Namespace airstrike
// Params 1
// Checksum 0x60b30853, Offset: 0x3eb5
// Size: 0x3e
function airstrike_playflybyfx( var_9de01f1a43af76e8 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( var_9de01f1a43af76e8 );
    self setscriptablepartstate( "flyby", "on", 0 );
}

// Namespace airstrike
// Params 1
// Checksum 0x7dad09da, Offset: 0x3efb
// Size: 0x3e
function airstrike_playflyoutfx( var_9ac627c2a5aa0173 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( var_9ac627c2a5aa0173 );
    self setscriptablepartstate( "flyout", "on", 0 );
}

// Namespace airstrike
// Params 1
// Checksum 0x815cc55f, Offset: 0x3f41
// Size: 0x36
function airstrike_handleflyoutfxdeath( var_473369a4cd9ee15d )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( var_473369a4cd9ee15d + 10 );
    self delete();
}

// Namespace airstrike
// Params 1
// Checksum 0xde621af0, Offset: 0x3f7f
// Size: 0x47
function airstrike_movewithplane( plane )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( isdefined( plane ) )
    {
        self.origin = plane.origin;
        wait 0.05;
    }
}

// Namespace airstrike
// Params 3
// Checksum 0x1a079c99, Offset: 0x3fce
// Size: 0x11a
function airstrike_watchkills( streakinfo, var_e41c9dd8df48b729, airstrikeid )
{
    self endon( #"disconnect" );
    self notify( #"airstrike_watch_kills" );
    self endon( #"airstrike_watch_kills" );
    waittillnotify = "airstrike_finished" + "_" + airstrikeid;
    self.airstrikekillcount = 0;
    self.var_bf76d1814a73cd34 = 0;
    childthread airstrike_watchkillscount( waittillnotify );
    childthread function_8aec81f56fb88ddd( waittillnotify );
    utility::waittill_any_timeout_no_endon_death( var_e41c9dd8df48b729, waittillnotify );
    playerskilled = self.airstrikekillcount >= 1;
    playersdowned = self.var_bf76d1814a73cd34 >= 1;
    
    if ( playerskilled || playersdowned )
    {
        killstreak_utility::playkillstreaktacomdialog( streakinfo, streakinfo.streakname + "_hit_target", #"hit", 1 );
    }
    else
    {
        killstreak_utility::playkillstreaktacomdialog( streakinfo, streakinfo.streakname + "_miss_target", #"miss", 1 );
    }
    
    self.var_bf76d1814a73cd34 = undefined;
}

// Namespace airstrike
// Params 1
// Checksum 0xfbf2c1e5, Offset: 0x40f0
// Size: 0x67
function airstrike_watchkillscount( endonnotify )
{
    self endon( endonnotify );
    
    while ( true )
    {
        self waittill( #"update_rapid_kill_buffered", recentkillcount, var_95795539e2a8343 );
        
        if ( isstring( var_95795539e2a8343 ) && ( var_95795539e2a8343 == "artillery_mp" || var_95795539e2a8343 == "fuelstrike_proj_mp" ) )
        {
            self.airstrikekillcount++;
        }
    }
}

// Namespace airstrike
// Params 1
// Checksum 0x2e51c59e, Offset: 0x415f
// Size: 0x67
function function_8aec81f56fb88ddd( endonnotify )
{
    self endon( endonnotify );
    
    while ( true )
    {
        self waittill( #"update_rapid_agent_kill_buffered", recentkillcount, var_bda53394c108f2e );
        
        if ( isstring( var_bda53394c108f2e ) && ( var_bda53394c108f2e == "artillery_mp" || var_bda53394c108f2e == "fuelstrike_proj_mp" ) )
        {
            self.airstrikekillcount++;
        }
    }
}

/#

    // Namespace airstrike
    // Params 1
    // Checksum 0x69c13871, Offset: 0x41ce
    // Size: 0x4c, Type: dev
    function testsoundplacement( flyoutfx )
    {
        flyoutfx endon( #"death" );
        
        while ( true )
        {
            sphere( flyoutfx.origin, 100, ( 0, 1, 0 ), 0, 1 );
            wait 0.05;
        }
    }

#/

// Namespace airstrike
// Params 6
// Checksum 0x46403725, Offset: 0x4222
// Size: 0x89f
function callstrike_precisionbulleteffect( plane, launchtime, strikelength, damagepos, owner, streakinfo )
{
    plane endon( #"death" );
    planedir = plane.flightdir;
    camdamagepos = damagepos + ( 0, 0, plane.flightheight + 750 );
    killcamstartpos = camdamagepos - planedir * 15000;
    killcamendpos = camdamagepos - planedir * 500;
    var_2c466f277f13f9b4 = camdamagepos;
    var_2f193e4ea5eb994d = 0;
    var_c8301d358b0c5264 = randomintrange( 3, 9 );
    var_9bd35ae01a54f053 = randomintrange( var_c8301d358b0c5264 + 1, 16 );
    strafe = [ var_2f193e4ea5eb994d, var_c8301d358b0c5264, var_9bd35ae01a54f053 ];
    strafecounter = 0;
    killcament = spawn( "script_model", killcamstartpos );
    killcament thread airstrike_killcammove( launchtime - 3, killcamendpos, var_2c466f277f13f9b4 );
    plane.bulletpoint.killcament = killcament;
    var_b4e7c7bc64dd3642 = [ damagepos - planedir * 512, damagepos - planedir * 256, damagepos, damagepos + planedir * 256, damagepos + planedir * 512 ];
    
    if ( level.var_5da8387c8cf123d9 )
    {
        foreach ( targetpos in var_b4e7c7bc64dd3642 )
        {
            killstreak_utility::killstreak_dangernotifyplayersinrange( owner, owner.team, level.airstrikedangerradius, streakinfo.streakname, targetpos );
        }
    }
    
    hostmigration::waitlongdurationwithpause( launchtime );
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    repeat = 5;
    hitpos = ( 0, 0, 0 );
    lasthitpos = hitpos;
    shotcounter = 0;
    var_7b120e129f2b6442 = 0;
    var_b4e7c7bc64dd3642 = [ damagepos - planedir * 512, damagepos - planedir * 256, damagepos, damagepos + planedir * 256, damagepos + planedir * 512 ];
    assert( var_b4e7c7bc64dd3642.size == 5 );
    owner.var_95676d6e92993060 = var_b4e7c7bc64dd3642;
    
    foreach ( targetpos in var_b4e7c7bc64dd3642 )
    {
        if ( utility::issharedfuncdefined( #"airstrike", #"addSpawnInfluencer" ) )
        {
            [[ utility::getsharedfunc( #"airstrike", #"addSpawnInfluencer" ) ]]( #"hash_39046aa32b2153cf", targetpos, owner.team, owner );
        }
    }
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            foreach ( pos in var_b4e7c7bc64dd3642 )
            {
                sphere( pos, 100, ( 1, 1, 1 ), 0, 500 );
            }
        }
    #/
    
    traceheightoffset = damagepos[ 2 ] + plane.flightheight * 3;
    
    for ( i = 0; i < repeat ; i++ )
    {
        if ( !isdefined( owner ) )
        {
            break;
        }
        
        originalmin = -50;
        originalmax = 150;
        
        while ( shotcounter < var_7b120e129f2b6442 + 4 )
        {
            var_a818d9dfbc367210 = callstrike_getrandomshotoffset( originalmin, originalmax, var_b4e7c7bc64dd3642[ i ], plane.angles );
            turretlocation = undefined;
            
            if ( streakinfo.bundle.airstrike_settings )
            {
                if ( streakinfo.bundle.var_827856ca936754c2 )
                {
                    turretlocation = plane gettagorigin( streakinfo.bundle.var_827856ca936754c2 );
                }
                else
                {
                    turretlocation = plane getorigin();
                }
            }
            else
            {
                turretlocation = plane gettagorigin( "tag_turret_fx" );
            }
            
            turrettracestart = turretlocation * ( 1, 1, 0 ) + ( 0, 0, traceheightoffset ) + planedir * 1000;
            
            /#
                bombingstyle = getdvarint( @"hash_f6e58fc941b6935d", 0 );
                
                if ( bombingstyle == 1 )
                {
                    turrettracestart = var_a818d9dfbc367210 + ( 0, 0, 10000 );
                }
            #/
            
            var_a8c770722ef90716 = vectornormalize( var_a818d9dfbc367210 - turrettracestart );
            turrettraceend = var_a818d9dfbc367210 + var_a8c770722ef90716 * 30000;
            tracertrace = trace::ray_trace( turrettracestart, turrettraceend, undefined, trace::create_contents( 0, 1, 0, 1, 0, 1, 0 ) );
            var_ab31691ae7d43ebd = tracertrace[ "position" ];
            var_1829728c07d93ddb = tracertrace[ "normal" ];
            var_7eb207350c7ffa2e = var_ab31691ae7d43ebd + var_1829728c07d93ddb * 10;
            var_3896fed9a8469836 = vectornormalize( var_ab31691ae7d43ebd - turretlocation );
            var_44ed7779e7223ff1 = vectorcross( var_3896fed9a8469836, ( 0, 0, 1 ) );
            var_c43f83664a9df0cc = vectorcross( var_44ed7779e7223ff1, var_3896fed9a8469836 );
            plane thread callstrike_playmultitracerfx( utility::getfx( "airstrike_tracer" ), var_7eb207350c7ffa2e, var_3896fed9a8469836, var_c43f83664a9df0cc );
            
            if ( getdvarint( @"redeploy_ascenders_enabled", 0 ) )
            {
                if ( tracertrace[ "hittype" ] == "hittype_world" && tracertrace[ "position" ][ 2 ] > 3000 )
                {
                    scr_drone = undefined;
                    
                    if ( utility::issharedfuncdefined( #"redeploy_drone", #"get_closest_redeploy_drone" ) )
                    {
                        scr_drone = [[ utility::getsharedfunc( #"redeploy_drone", #"get_closest_redeploy_drone" ) ]]( tracertrace[ "position" ] );
                    }
                    
                    if ( isdefined( scr_drone ) && distancesquared( tracertrace[ "position" ], scr_drone.origin ) < squared( 150 ) )
                    {
                        if ( utility::issharedfuncdefined( #"redeploy_drone", #"precision_airstrike_death" ) )
                        {
                            scr_drone thread [[ utility::getsharedfunc( #"redeploy_drone", #"precision_airstrike_death" ) ]]( owner );
                        }
                    }
                }
                
                if ( tracertrace[ "hittype" ] == "hittype_entity" && isdefined( tracertrace[ "entity" ] ) && isdefined( tracertrace[ "entity" ].model ) && ( tracertrace[ "entity" ].model == "veh9_mil_air_drone_redeploy_relocate" || tracertrace[ "entity" ].model == "veh9_mil_air_drone_redeploy_relocate_hack" ) )
                {
                    if ( utility::issharedfuncdefined( #"redeploy_drone", #"precision_airstrike_death" ) )
                    {
                        tracertrace[ "entity" ] thread [[ utility::getsharedfunc( #"redeploy_drone", #"precision_airstrike_death" ) ]]( owner );
                    }
                }
            }
            
            plane.bulletpoint thread moveanddamagepoint( shotcounter + 1, var_7eb207350c7ffa2e );
            
            if ( strafecounter < strafe.size && shotcounter == strafe[ strafecounter ] )
            {
                plane.bulletpoint thread strafes( strafecounter + 1, var_7eb207350c7ffa2e );
                strafecounter++;
            }
            
            lasthitpos = var_ab31691ae7d43ebd;
            shotcounter++;
            plane.bulletpoint.streakinfo.shots_fired++;
            originalmin += 20;
            originalmax += 40;
            traceheightoffset -= 200;
            
            if ( traceheightoffset < plane.flightheight )
            {
                traceheightoffset = plane.flightheight;
            }
            
            wait 0.05;
        }
        
        var_7b120e129f2b6442 = shotcounter;
        
        if ( i == 0 && isdefined( level.var_845fe19bc9ff4b8e ) )
        {
            thread [[ level.var_845fe19bc9ff4b8e ]]( streakinfo, lasthitpos, 0 );
        }
    }
    
    plane notify( #"fire_finished" );
}

// Namespace airstrike
// Params 4
// Checksum 0xb25adebc, Offset: 0x4ac9
// Size: 0xa6
function callstrike_getrandomshotoffset( minoffset, maxoffset, originalpos, planeangles )
{
    planeangles *= ( 0, 1, 0 );
    planeforward = anglestoforward( planeangles );
    planeright = anglestoright( planeangles );
    randdist = randomintrange( minoffset, maxoffset );
    randangle = randomint( 80 ) - 40;
    shotoffset = planeforward * cos( randangle ) * randdist;
    return originalpos + shotoffset + planeright * sin( randangle ) * randdist;
}

// Namespace airstrike
// Params 4
// Checksum 0x615f621e, Offset: 0x4b78
// Size: 0x94
function callstrike_playmultitracerfx( tracerfx, tracehit, var_3896fed9a8469836, var_c43f83664a9df0cc )
{
    self endon( #"death" );
    tracercounter = 0;
    var_ecadccaa6d5802b2 = 3;
    
    while ( tracercounter < var_ecadccaa6d5802b2 )
    {
        randomoffsetx = randomintrange( 25, 50 );
        randomoffsety = randomintrange( 25, 50 );
        playfx( tracerfx, tracehit + ( randomoffsetx, randomoffsety, 0 ), var_3896fed9a8469836, var_c43f83664a9df0cc );
        tracercounter++;
        wait 0.05;
    }
}

// Namespace airstrike
// Params 2
// Checksum 0x26b6f1c6, Offset: 0x4c14
// Size: 0x69
function moveanddamagepoint( index, hitpos )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( 0.18 );
    self.origin = hitpos;
    self setscriptablepartstate( "explode" + index, "active", 0 );
    hostmigration::waitlongdurationwithpause( 5 );
    self setscriptablepartstate( "explode" + index, "neutral", 0 );
}

// Namespace airstrike
// Params 2
// Checksum 0xc4c9b482, Offset: 0x4c85
// Size: 0x5d
function strafes( index, hitpos )
{
    self endon( #"death" );
    self.origin = hitpos;
    self setscriptablepartstate( "strafe" + index, "on", 0 );
    hostmigration::waitlongdurationwithpause( 5 );
    self setscriptablepartstate( "strafe" + index, "off", 0 );
}

// Namespace airstrike
// Params 6
// Checksum 0x1b96237b, Offset: 0x4cea
// Size: 0x57d
function function_8fcae754374c2868( plane, launchtime, strikelength, damagepos, owner, streakinfo )
{
    plane endon( #"death" );
    planedir = plane.flightdir;
    camdamagepos = damagepos + ( 0, 0, plane.flightheight + 750 );
    killcamstartpos = camdamagepos - planedir * 15000;
    killcamendpos = camdamagepos - planedir * 1000;
    var_2c466f277f13f9b4 = camdamagepos - planedir * 500;
    killcament = spawn( "script_model", killcamstartpos );
    killcament thread airstrike_killcammove( launchtime - 3, killcamendpos, var_2c466f277f13f9b4 );
    hostmigration::waitlongdurationwithpause( launchtime );
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( streakinfo.streakname == "fuel_airstrike" )
    {
        if ( owner emp_debuff::is_empd() )
        {
            return;
        }
    }
    
    if ( utility::issharedfuncdefined( #"airstrike", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"airstrike", #"addSpawnInfluencer" ) ]]( #"hash_39046aa32b2153cf", damagepos, owner.team, owner );
    }
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            sphere( damagepos, 100, ( 1, 1, 1 ), 0, 500 );
        }
    #/
    
    bombtracestart = damagepos + ( 0, 0, 2500 );
    bombtraceend = damagepos - ( 0, 0, 10000 );
    bombtrace = trace::ray_trace( bombtracestart, bombtraceend, undefined, trace::create_contents( 0, 1, 0, 1, 0, 1, 0 ) );
    var_82dbd83cc5863e44 = bombtrace[ "position" ];
    bombtracenormal = bombtrace[ "normal" ];
    bombhitpos = var_82dbd83cc5863e44 + bombtracenormal * 10;
    
    /#
        airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
        
        if ( airstrikedebugon )
        {
            line( bombtracestart, bombhitpos, ( 1, 0, 0 ), 1, 0, 1000 );
            line( bombhitpos, bombhitpos + bombtracenormal * 50, ( 0, 1, 0 ), 1, 0, 500 );
            sphere( bombhitpos, 50, ( 1, 0, 0 ), 0, 500 );
        }
    #/
    
    var_646306ff4db410f2 = bombhitpos + ( 0, 0, 800 );
    var_a42b9910c9af253c = spawn( "script_model", var_646306ff4db410f2 );
    var_a42b9910c9af253c.angles = plane.angles;
    var_a42b9910c9af253c.streakinfo = plane.streakinfo;
    var_a42b9910c9af253c setmodel( "ks_fuelstrike_mp" );
    var_a42b9910c9af253c setentityowner( owner );
    var_a42b9910c9af253c.killcament = killcament;
    var_31ac5feb767f50eb = spawn( "script_model", bombhitpos );
    var_31ac5feb767f50eb.angles = plane.angles;
    var_31ac5feb767f50eb.streakinfo = plane.streakinfo;
    var_31ac5feb767f50eb setmodel( "ks_fuelstrike_mp" );
    var_31ac5feb767f50eb setentityowner( owner );
    var_31ac5feb767f50eb.killcament = killcament;
    var_31ac5feb767f50eb setscriptablepartstate( "releaseVFX", "on", 0 );
    var_a42b9910c9af253c setscriptablepartstate( "releaseSFX", "on", 0 );
    wait 1.3;
    var_31ac5feb767f50eb setscriptablepartstate( "explode", "on", 0 );
    var_847f780b10d918e5 = [ var_a42b9910c9af253c, var_31ac5feb767f50eb ];
    var_1fb686143fa771fc = trace::create_contents( 0, 1, 1, 1, 0, 1, 0, 1, 0 );
    var_95c1a2ad31be6066 = function_1748d90909e99da4( bombhitpos, 750, owner, var_646306ff4db410f2, var_847f780b10d918e5, var_1fb686143fa771fc );
    vehicleshit = function_83e9ff0aa4b2fa92( bombhitpos, 750, owner, var_646306ff4db410f2, var_847f780b10d918e5, var_1fb686143fa771fc );
    bombweapon = makeweapon( "fuelstrike_proj_mp" );
    bombexplodedelay = 0.8;
    plane thread function_41722228ebb55980( var_a42b9910c9af253c, var_31ac5feb767f50eb, bombexplodedelay );
    
    /#
        owner thread function_86996cb4cc276740( bombexplodedelay, var_31ac5feb767f50eb );
    #/
    
    foreach ( enemy in var_95c1a2ad31be6066 )
    {
        enemy thread function_83813bbfeb81f148( owner, bombexplodedelay, var_a42b9910c9af253c, var_31ac5feb767f50eb, bombweapon );
        enemy thread function_98c628a357613e6c( 500, var_31ac5feb767f50eb.origin, owner, var_31ac5feb767f50eb, "MOD_EXPLOSIVE", bombweapon, bombexplodedelay );
    }
    
    foreach ( vehicle in vehicleshit )
    {
        vehicle thread function_98c628a357613e6c( 1000, var_31ac5feb767f50eb.origin, owner, var_31ac5feb767f50eb, "MOD_EXPLOSIVE", bombweapon, bombexplodedelay );
    }
    
    level thread delaydeletefxents( var_a42b9910c9af253c, var_31ac5feb767f50eb );
}

// Namespace airstrike
// Params 2
// Checksum 0xd20af22a, Offset: 0x526f
// Size: 0x84
function delaydeletefxents( var_686576a4ba9397c9, var_34fda9130b044fca )
{
    hostmigration::waitlongdurationwithpause( 1 );
    var_686576a4ba9397c9 setscriptablepartstate( "releaseSFX", "off", 0 );
    var_34fda9130b044fca setscriptablepartstate( "releaseVFX", "off", 0 );
    hostmigration::waitlongdurationwithpause( 1 );
    
    if ( isdefined( var_686576a4ba9397c9 ) )
    {
        var_686576a4ba9397c9 delete();
    }
    
    if ( isdefined( var_34fda9130b044fca ) )
    {
        if ( isdefined( var_34fda9130b044fca.killcament ) )
        {
            var_34fda9130b044fca.killcament delete();
        }
        
        var_34fda9130b044fca delete();
    }
}

// Namespace airstrike
// Params 9
// Checksum 0x4b4c5e0e, Offset: 0x52fb
// Size: 0x196
function getflightpath( coord, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_52a7c56f48361b92, streakname, var_2df14d15022f74fc )
{
    directionangles = undefined;
    
    if ( var_2df14d15022f74fc )
    {
        directionangles = direction;
    }
    else
    {
        directionangles = anglestoforward( direction );
    }
    
    startpoint = coord + directionangles * -1 * planehalfdistance;
    
    if ( isdefined( heightent ) )
    {
        startpoint *= ( 1, 1, 0 );
    }
    
    startpoint += ( 0, 0, planeflyheight );
    midpoint = coord;
    
    if ( isdefined( heightent ) )
    {
        midpoint *= ( 1, 1, 0 );
    }
    
    midpoint += ( 0, 0, planeflyheight );
    endpoint = coord + directionangles * planehalfdistance;
    
    if ( isdefined( heightent ) )
    {
        endpoint *= ( 1, 1, 0 );
    }
    
    endpoint += ( 0, 0, planeflyheight );
    d = length( startpoint - endpoint );
    flytime = d / planeflyspeed;
    d = abs( d / 2 + var_52a7c56f48361b92 );
    bombtime = d / planeflyspeed;
    assert( flytime > bombtime );
    flightpath[ "startPoint" ] = startpoint;
    flightpath[ "midPoint" ] = midpoint;
    flightpath[ "endPoint" ] = endpoint;
    flightpath[ "bombTime" ] = bombtime;
    flightpath[ "flyTime" ] = flytime;
    flightpath[ "directionAngles" ] = directionangles;
    return flightpath;
}

// Namespace airstrike
// Params 1
// Checksum 0xbe039e40, Offset: 0x549a
// Size: 0x46
function getexplodedistance( height )
{
    standardheight = 850;
    standarddistance = 1500;
    distancefrac = standardheight / height;
    newdistance = distancefrac * standarddistance;
    return newdistance;
}

/#

    // Namespace airstrike
    // Params 2
    // Checksum 0x6bb3e5ef, Offset: 0x54e9
    // Size: 0x101, Type: dev
    function function_bc7388025d453a4e( planeflyheight, targetsite )
    {
        self endon( #"death" );
        level endon( #"debug_airstrike" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debugairstrike" ) == 0 )
            {
                return;
            }
            
            anglesforward = anglestoforward( level.players[ 0 ].angles );
            scalar = ( anglesforward[ 0 ] * 300, anglesforward[ 1 ] * 300, anglesforward[ 2 ] );
            print3d( level.players[ 0 ].origin + scalar, "<dev string:x41>" + planeflyheight, ( 1, 0, 0 ) );
            print3d( level.players[ 0 ].origin + scalar - ( 0, 0, 20 ), "<dev string:x4e>" + distance2d( targetsite, self.origin ) );
            waitframe();
        }
    }

    // Namespace airstrike
    // Params 4
    // Checksum 0xf83875c1, Offset: 0x55f2
    // Size: 0x62, Type: dev
    function debugairstrikeline( start, end, color, duration )
    {
        frames = duration * 20;
        
        for ( i = 0; i < frames ; i++ )
        {
            line( start, end, color );
            wait 0.05;
        }
    }

#/

// Namespace airstrike
// Params 2
// Checksum 0xc0bcd1a1, Offset: 0x565c
// Size: 0x133
function airstrike_getownerlookatpos( owner, finalselection )
{
    content = [ "physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy" ];
    contentoverride = physics_createcontents( content );
    starttrace = owner getvieworigin();
    endtrace = starttrace + anglestoforward( owner getplayerangles() ) * 50000;
    ignoreents = owner killstreak_utility::playerkillstreakgetownerlookatignoreents();
    trace = trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
    endpos = trace[ "position" ];
    
    /#
        if ( finalselection )
        {
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( airstrikedebugon )
            {
                level thread debug_utility::drawsphere( endpos, 20, 60, ( 0, 1, 0 ) );
                line( starttrace, endpos, ( 0, 1, 0 ), 1, 0, 500 );
            }
        }
    #/
    
    if ( trace[ "hittype" ] == "hittype_none" )
    {
        endpos = undefined;
    }
    
    return endpos;
}

// Namespace airstrike
// Params 1
// Checksum 0xeca96d3e, Offset: 0x5798
// Size: 0x3c
function function_1f199e14c878a314( streakinfo )
{
    if ( getdvarint( @"hash_f6d7d855b260ce3b", 0 ) == 0 )
    {
        ownerlookatpos = airstrike_getownerlookatpos( self );
        killstreaks::function_f08df25f32bebdd7( streakinfo, ownerlookatpos );
    }
}

// Namespace airstrike
// Params 3
// Checksum 0xa6b2f3e5, Offset: 0x57dc
// Size: 0x457
function airstrike_watchforads( streakinfo, iconoverride, var_ef863fcf12549b37 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"deploy_cancelled" );
    self endon( #"deploy_fired" );
    markerscriptable = var_ef863fcf12549b37 ?? "ks_airstrike_marker_mp";
    markerent = spawn( "script_model", self.origin );
    markerent setmodel( markerscriptable );
    markerent setotherent( self );
    markerent dontinterpolate();
    markerent hide();
    
    if ( iconoverride != "" )
    {
        if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
        {
            markerent.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        }
        
        markericon = iconoverride ?? "icon_waypoint_airstrike";
        markerent airstrike_setmarkerobjective( markerent.objidnum, markericon, self, 50 );
    }
    
    markerent thread airstrike_watchownerdisown( self );
    markerent thread airstrike_watchdeployended( self );
    markerent thread airstrike_watchdeployweaponchange( self );
    markerent.updatemarker = 0;
    val::set( "ads_watcher", "fire", 0 );
    function_1f199e14c878a314( streakinfo );
    
    while ( true )
    {
        if ( emp_debuff::is_empd() )
        {
            if ( streakinfo.bundle.airstrike_settings && streakinfo.bundle.var_6de5412893c1f44c )
            {
                previousweapon = self.var_74cf4c4f3d95aaf5;
                inventory_utility::_switchtoweapon( previousweapon );
                val::set( #"ads_watcher", "fire", 0 );
                markerent hide();
                markerent setscriptablepartstate( #"marker_scope", #"off", 0 );
                self notify( #"stop_update_marker" );
                markerent.updatemarker = 0;
            }
            
            if ( streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "bunker_buster" )
            {
                previousweapon = self.var_74cf4c4f3d95aaf5;
                inventory_utility::_switchtoweapon( previousweapon );
                val::set( "ads_watcher", "fire", 0 );
                markerent hide();
                markerent setscriptablepartstate( "marker_scope", "off", 0 );
                self notify( #"stop_update_marker" );
                markerent.updatemarker = 0;
            }
            
            if ( streakinfo.streakname == "fuel_airstrike" )
            {
                previousweapon = self.var_74cf4c4f3d95aaf5;
                inventory_utility::_switchtoweapon( previousweapon );
                val::set( "ads_watcher", "fire", 0 );
                markerent hide();
                markerent setscriptablepartstate( "marker_scope", "off", 0 );
                self notify( #"stop_update_marker" );
                markerent.updatemarker = 0;
            }
        }
        
        if ( emp_debuff::is_empd() && markerent.updatemarker )
        {
            if ( streakinfo.streakname != "precision_airstrike" && streakinfo.streakname != "bunker_buster" )
            {
                val::set( "ads_watcher", "fire", 0 );
                markerent hide();
                markerent setscriptablepartstate( "marker_scope", "off", 0 );
                self notify( #"stop_update_marker" );
                markerent.updatemarker = 0;
            }
        }
        
        playerads = self playerads();
        
        if ( playerads == 1 && !markerent.updatemarker )
        {
            if ( !emp_debuff::is_empd() )
            {
                val::reset_all( "ads_watcher" );
                markerent show();
                markerent setscriptablepartstate( "marker_scope", "on", 0 );
                markerent thread airstrike_updatemarkerpos( self, streakinfo );
                markerent.updatemarker = 1;
                function_1f199e14c878a314( streakinfo );
            }
        }
        else if ( playerads < 1 && markerent.updatemarker )
        {
            val::set( "ads_watcher", "fire", 0 );
            markerent hide();
            markerent setscriptablepartstate( "marker_scope", "off", 0 );
            self notify( #"stop_update_marker" );
            markerent.updatemarker = 0;
            self setclientomnvar( "ui_spotter_scope_danger", 0 );
        }
        
        waitframe();
    }
}

// Namespace airstrike
// Params 3
// Checksum 0xa596cd84, Offset: 0x5c3b
// Size: 0x1fd
function function_d4a8690908f0ac01( streakinfo, iconoverride, var_ef863fcf12549b37 )
{
    self endon( #"death_or_disconnect", #"deploy_cancelled", #"deploy_fired" );
    markerscriptable = var_ef863fcf12549b37 ?? "ks_airstrike_marker_mp";
    markerent = spawn( "script_model", self.origin );
    markerent setmodel( markerscriptable );
    markerent setotherent( self );
    markerent dontinterpolate();
    markerent hide();
    
    if ( iconoverride != "" )
    {
        if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
        {
            markerent.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        }
        
        markericon = iconoverride ?? "icon_waypoint_airstrike";
        markerent airstrike_setmarkerobjective( markerent.objidnum, markericon, self, 50 );
    }
    
    markerent thread airstrike_watchownerdisown( self );
    markerent thread airstrike_watchdeployended( self );
    markerent thread airstrike_watchdeployweaponchange( self );
    markerent.updatemarker = 0;
    function_1f199e14c878a314( streakinfo );
    
    while ( true )
    {
        if ( emp_debuff::is_empd() )
        {
            previousweapon = self.var_74cf4c4f3d95aaf5;
            inventory_utility::_switchtoweapon( previousweapon );
            markerent hide();
            self notify( #"stop_update_marker" );
            markerent.updatemarker = 0;
        }
        
        if ( !markerent.updatemarker )
        {
            if ( !emp_debuff::is_empd() )
            {
                markerent show();
                markerent thread airstrike_updatemarkerpos( self, streakinfo );
                markerent.updatemarker = 1;
                function_1f199e14c878a314( streakinfo );
            }
        }
        else if ( markerent.updatemarker )
        {
            markerent hide();
            self notify( #"stop_update_marker" );
            markerent.updatemarker = 0;
        }
        
        waitframe();
    }
}

// Namespace airstrike
// Params 4
// Checksum 0xf51453a, Offset: 0x5e40
// Size: 0x9c
function airstrike_setmarkerobjective( objid, icon, owner, offset )
{
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
    
    objective_state( objid, "done" );
}

// Namespace airstrike
// Params 2
// Checksum 0xc25759ef, Offset: 0x5ee4
// Size: 0x1d7
function airstrike_updatemarkerpos( owner, streakinfo )
{
    self endon( #"death" );
    owner endon( #"deploy_cancelled" );
    owner endon( #"deploy_fired" );
    owner endon( #"stop_update_marker" );
    owner endon( #"death_or_disconnect" );
    dangerclose = 0;
    owner setclientomnvar( "ui_spotter_scope_danger", 0 );
    bundle = killstreak_utility::function_f943c0602acdc2af( streakinfo.streakname );
    var_3b6877b7df1ac40e = isdefined( bundle.var_7fc4b33217ec927a ) ? bundle.var_7fc4b33217ec927a * bundle.var_7fc4b33217ec927a : 1638400;
    
    while ( true )
    {
        newownerlookatpos = airstrike_getownerlookatpos( owner );
        xpos = -1;
        ypos = -1;
        zpos = -1;
        
        if ( isdefined( newownerlookatpos ) )
        {
            self.origin = newownerlookatpos;
            xpos = int( self.origin[ 0 ] );
            ypos = int( self.origin[ 1 ] );
            zpos = int( self.origin[ 2 ] );
        }
        
        owner setclientomnvar( "ui_gunship_coord3_posx", xpos );
        owner setclientomnvar( "ui_gunship_coord3_posy", ypos );
        owner setclientomnvar( "ui_gunship_coord3_posz", zpos );
        
        if ( isdefined( newownerlookatpos ) )
        {
            if ( !dangerclose && distance2dsquared( owner.origin, newownerlookatpos ) <= var_3b6877b7df1ac40e )
            {
                owner setclientomnvar( "ui_spotter_scope_danger", 1 );
                dangerclose = 1;
            }
            else if ( dangerclose && distance2dsquared( owner.origin, newownerlookatpos ) > var_3b6877b7df1ac40e )
            {
                owner setclientomnvar( "ui_spotter_scope_danger", 0 );
                dangerclose = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace airstrike
// Params 1
// Checksum 0x3b0fc3d2, Offset: 0x60c3
// Size: 0x39
function airstrike_watchownerdisown( owner )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    owner waittill( #"death_or_disconnect" );
    airstrike_removemarker();
}

// Namespace airstrike
// Params 1
// Checksum 0x54889219, Offset: 0x6104
// Size: 0x18e
function airstrike_watchdeployended( owner )
{
    owner endon( #"death_or_disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    deployresult = owner utility::waittill_any_return( "cancel_fire", "successful_fire" );
    
    if ( deployresult == "successful_fire" )
    {
        owner notify( #"deploy_fired" );
        owner val::reset_all( "ads_watcher" );
        owner playlocalsound( "kls_location_select" );
        self setscriptablepartstate( "marker_scope", "off", 0 );
        var_876a990ce3ec9ecb = anglestoforward( owner getplayerangles() );
        starttrace = self.origin - var_876a990ce3ec9ecb * 500;
        endtrace = self.origin + var_876a990ce3ec9ecb * 20;
        trace = trace::ray_trace( starttrace, endtrace, self );
        surfacenormal = trace[ "normal" ];
        self.angles = generateaxisanglesfromupvector( surfacenormal, self.angles );
        self setscriptablepartstate( "marker_placed", "on", 0 );
        
        if ( isdefined( self.objidnum ) )
        {
            objective_state( self.objidnum, "current" );
        }
        
        thread airstrike_removemarker( 7 );
        return;
    }
    
    owner setclientomnvar( "ui_using_airstrike", 0 );
    owner notify( #"deploy_cancelled" );
    
    if ( !owner player::isplayerads() )
    {
        owner val::reset_all( "ads_watcher" );
    }
    
    airstrike_removemarker();
}

// Namespace airstrike
// Params 1
// Checksum 0x780dfcfe, Offset: 0x629a
// Size: 0x68
function airstrike_watchdeployweaponchange( owner )
{
    owner endon( #"death_or_disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    spotterscope = owner getcurrentweapon();
    
    while ( true )
    {
        if ( owner getcurrentweapon() != spotterscope )
        {
            break;
        }
        
        waitframe();
    }
    
    owner notify( #"cancel_fire" );
}

// Namespace airstrike
// Params 1
// Checksum 0x84d252ca, Offset: 0x630a
// Size: 0x85
function airstrike_removemarker( delaytime )
{
    if ( isdefined( delaytime ) )
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    if ( isdefined( self.objidnum ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.objidnum );
        }
    }
    
    self delete();
}

// Namespace airstrike
// Params 1
// Checksum 0xed636aa0, Offset: 0x6397
// Size: 0x38
function airstrike_delayplayscriptable( delaytime )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait delaytime;
    self setscriptablepartstate( "bodyfx", "on", 0 );
}

// Namespace airstrike
// Params 3
// Checksum 0x2b6b3593, Offset: 0x63d7
// Size: 0x53
function airstrike_killcammove( delaytime, killcamendpos, var_2c466f277f13f9b4 )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( delaytime );
    self moveto( killcamendpos, 4 );
    hostmigration::waitlongdurationwithpause( 3.95 );
    self moveto( var_2c466f277f13f9b4, 5 );
}

// Namespace airstrike
// Params 2
// Checksum 0x13915980, Offset: 0x6432
// Size: 0x52
function airstrike_watchgameend( streakinfo, airstrikeid )
{
    level endon( "airstrike_finished" + "_" + airstrikeid );
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    
    if ( self && streakinfo )
    {
        killstreaks::function_2d953e6a25a2ccd4( streakinfo );
    }
}

// Namespace airstrike
// Params 3
// Checksum 0x7b35fae0, Offset: 0x648c
// Size: 0xe6
function airstrike_addactivestrike( origin, owner, timesec )
{
    level.airstrikecount++;
    newstrike = spawnstruct();
    newstrike.origin = origin;
    newstrike.owner = owner;
    
    if ( isplayer( owner ) )
    {
        id = owner getxuid();
    }
    else
    {
        id = abs( owner.origin[ 0 ] );
    }
    
    newstrike.id = id + "_" + level.airstrikecount;
    newstrike.starttimems = gettime();
    newstrike.timems = timesec * 1000;
    level.activeairstrikes[ newstrike.id ] = newstrike;
    return newstrike.id;
}

// Namespace airstrike
// Params 1
// Checksum 0xe2deeb12, Offset: 0x657b
// Size: 0x29
function airstrike_removeactivestrike( var_8513e683c139ca76 )
{
    level.activeairstrikes[ var_8513e683c139ca76 ] = undefined;
    level notify( "airstrike_finished" + "_" + var_8513e683c139ca76 );
}

// Namespace airstrike
// Params 3
// Checksum 0x52286f3a, Offset: 0x65ac
// Size: 0x36
function function_f767ade14cc614ec( owner, airstrikeid, delaytime )
{
    level endon( #"game_ended" );
    wait delaytime;
    airstrike_removeactivestrike( airstrikeid );
}

// Namespace airstrike
// Params 0
// Checksum 0x754e8c42, Offset: 0x65ea
// Size: 0x31
function function_6ac2148f634b641d()
{
    mindistsq = 625000000;
    
    /#
        if ( level.mapname == "<dev string:x59>" )
        {
            mindistsq = 1000000;
        }
    #/
    
    return mindistsq;
}

// Namespace airstrike
// Params 2
// Checksum 0x82930a7, Offset: 0x6624
// Size: 0x1a0
function airstrike_canbeused( streakinfo, strikelocation )
{
    useresult = "success";
    mindistsq = function_6ac2148f634b641d();
    
    if ( isdefined( strikelocation ) )
    {
        if ( level.activeairstrikes.size > 0 )
        {
            var_4cc00a73dfc68dfb = 1;
            isbrgamemode = isbrgamemode();
            
            if ( isbrgamemode )
            {
                var_4cc00a73dfc68dfb = 3;
            }
            
            if ( level.activeairstrikes.size >= var_4cc00a73dfc68dfb )
            {
                if ( level.var_b8195296368ddbda )
                {
                    useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME";
                }
                else
                {
                    useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED";
                }
            }
            else
            {
                foreach ( activestrike in level.activeairstrikes )
                {
                    if ( distance2dsquared( activestrike.origin, strikelocation ) <= mindistsq )
                    {
                        if ( level.var_b8195296368ddbda )
                        {
                            useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME";
                            continue;
                        }
                        
                        useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA";
                    }
                }
            }
        }
    }
    else
    {
        useresult = "KILLSTREAKS/INVALID_POINT";
    }
    
    if ( utility::issharedfuncdefined( #"game", #"hash_377b9525d18c0e38" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"hash_377b9525d18c0e38" ) ]]( undefined, undefined, streakinfo.streakname, undefined, undefined, undefined, useresult != "success", "airstrike_too_crowded" );
    }
    
    return useresult;
}

// Namespace airstrike
// Params 1
// Checksum 0x6237211e, Offset: 0x67cd
// Size: 0xcd
function callprecisionairstrikeonlocation( location )
{
    player = self;
    streakinfo = spawnstruct();
    streakinfo.streakname = "precision_airstrike";
    streakinfo.owner = player;
    streakinfo.score = 0;
    streakinfo.shots_fired = 0;
    streakinfo.hits = 0;
    streakinfo.damage = 0;
    streakinfo.kills = 0;
    yaw = undefined;
    targetmarker = undefined;
    animname = %mp_alfa10_flyin;
    airstrikeid = undefined;
    level thread callstrike( player, location, yaw, targetmarker, streakinfo, animname, airstrikeid );
}

// Namespace airstrike
// Params 6
// Checksum 0x28971bfd, Offset: 0x68a2
// Size: 0x1ec
function function_1748d90909e99da4( hitpos, hitradius, airstrikeowner, tracestart, var_847f780b10d918e5, var_1fb686143fa771fc )
{
    targetsinrange = utility::function_1b1340a94b43b874( hitpos, hitradius );
    enemiesinrange = [];
    
    foreach ( target in targetsinrange )
    {
        if ( !isdefined( target ) )
        {
            continue;
        }
        
        targetteam = undefined;
        
        if ( isplayer( target ) )
        {
            if ( !target player::isreallyalive() )
            {
                continue;
            }
            
            targetteam = target.pers[ "team" ];
            
            if ( isbrgamemode() )
            {
                if ( utility::issharedfuncdefined( #"game", #"hash_2000857173f60896" ) )
                {
                    targetteam = [[ utility::getsharedfunc( #"game", #"hash_2000857173f60896" ) ]]( target );
                }
            }
        }
        else if ( isagent( target ) )
        {
            if ( !isalive( target ) )
            {
                continue;
            }
            
            if ( isdefined( target.agent_type ) && issubstr( target.agent_type, "civilian" ) )
            {
                continue;
            }
            
            targetteam = target.team;
        }
        
        if ( isdefined( airstrikeowner ) )
        {
            if ( level.teambased )
            {
                if ( targetteam == airstrikeowner.team && target != airstrikeowner )
                {
                    continue;
                }
            }
        }
        
        canseetarget = trace::ray_trace_passed( tracestart, target gettagorigin( "j_head" ), var_847f780b10d918e5, var_1fb686143fa771fc );
        
        if ( canseetarget )
        {
            enemiesinrange[ enemiesinrange.size ] = target;
        }
    }
    
    return enemiesinrange;
}

// Namespace airstrike
// Params 6
// Checksum 0x6a4362b0, Offset: 0x6a97
// Size: 0x13a
function function_83e9ff0aa4b2fa92( hitpos, hitradius, airstrikeowner, tracestart, var_847f780b10d918e5, var_1fb686143fa771fc )
{
    targetsinrange = vehicle_getarrayinradius( hitpos, hitradius, hitradius );
    var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, targetsinrange );
    vehiclesinrange = [];
    
    foreach ( target in targetsinrange )
    {
        if ( !isdefined( target ) )
        {
            continue;
        }
        
        if ( level.teambased && isdefined( target.team ) && target.team == airstrikeowner.team )
        {
            continue;
        }
        
        canseetarget = trace::ray_trace_passed( tracestart, target.origin, var_847f780b10d918e5, var_1fb686143fa771fc );
        
        if ( canseetarget )
        {
            vehiclesinrange[ vehiclesinrange.size ] = target;
        }
    }
    
    return vehiclesinrange;
}

// Namespace airstrike
// Params 3
// Checksum 0x63c88ca3, Offset: 0x6bda
// Size: 0xdd
function function_41722228ebb55980( var_a42b9910c9af253c, var_31ac5feb767f50eb, bombexplodedelay )
{
    self endon( #"death" );
    shakeduration = 0.5;
    var_39bbe706cd34d2ec = 0.3;
    var_39deeb06cd5b2370 = 0.15;
    var_39def506cd5b396e = 0.08;
    radiusscalemax = 350;
    radiusscalemid = 900;
    radiusscalemin = 3500;
    wait bombexplodedelay;
    
    if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
    {
        [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( var_31ac5feb767f50eb.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin );
    }
}

// Namespace airstrike
// Params 5
// Checksum 0xc7644c72, Offset: 0x6cbf
// Size: 0xbf
function function_83813bbfeb81f148( owner, bombexplodedelay, var_a42b9910c9af253c, var_31ac5feb767f50eb, bombweapon )
{
    self endon( #"disconnect" );
    shellshock_utility_cpmp::_shellshock( %"bomb_stun_mp", #"stun", 5, 0 );
    thread function_98c628a357613e6c( 1, var_a42b9910c9af253c.origin, owner, var_a42b9910c9af253c, "MOD_EXPLOSIVE", bombweapon );
    
    if ( isbot( self ) || isagent( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "airBombVfx", "embers", 0 );
    wait bombexplodedelay - 0.1;
    self setscriptablepartstate( "airBombVfx", "explode", 0 );
    thread airstrike_delayresetscriptable( "airBombVfx" );
}

// Namespace airstrike
// Params 7, eflags: 0x4
// Checksum 0x6d6386f8, Offset: 0x6d86
// Size: 0x66
function private function_98c628a357613e6c( damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon, bombexplodedelay )
{
    self endon( #"death_or_disconnect" );
    
    if ( bombexplodedelay > 0 )
    {
        wait bombexplodedelay;
    }
    
    self dodamage( damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon );
}

// Namespace airstrike
// Params 1
// Checksum 0x33717129, Offset: 0x6df4
// Size: 0x34
function airstrike_delayresetscriptable( partname )
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 3, "spawned_player" );
    self setscriptablepartstate( partname, "off", 0 );
}

// Namespace airstrike
// Params 6
// Checksum 0x642cbd6, Offset: 0x6e30
// Size: 0xce
function function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, isfriendly, sizemultiplier, effectrange, stretchmultiplier )
{
    var_3db81ce6b08f5ca1 = spawnstruct();
    var_3db81ce6b08f5ca1.circle = spawnstruct();
    questcircleid = "Airstrike_Pill_Shape";
    
    if ( isfriendly )
    {
        questcircleid = "Airstrike_Pill_Shape_Friendly";
    }
    
    var_3db81ce6b08f5ca1.circle game_utility::questcircle_create( questcircleid, var_f8068b0b6432fcdf, effectrange * sizemultiplier );
    var_3db81ce6b08f5ca1.circle.mapcircle addyaw( vectortoyaw( flightdir ) * -1 );
    var_3db81ce6b08f5ca1.circle.mapcircle addpitch( stretchmultiplier );
    return var_3db81ce6b08f5ca1;
}

// Namespace airstrike
// Params 4
// Checksum 0x2568886d, Offset: 0x6f07
// Size: 0x135
function function_2ea7adb19ae7907c( damagepos, flightdir, effectrange, stretchmultiplier )
{
    var_112e899e83a90ecc = getmatchrulesdata( "commonOption", "airstrikeZoneSizeMultiplier" );
    var_476d441d34f95240 = getmatchrulesdata( "commonOption", "isAirstrikeZoneRandom" );
    
    if ( !isdefined( var_112e899e83a90ecc ) || var_112e899e83a90ecc <= 1 )
    {
        var_112e899e83a90ecc = 1;
        var_476d441d34f95240 = 0;
    }
    
    var_f8068b0b6432fcdf = damagepos;
    
    if ( var_476d441d34f95240 )
    {
        var_7a7ddb6543351e84 = effectrange;
        var_a19aabc9baa3fd11 = var_7a7ddb6543351e84 * var_112e899e83a90ecc;
        randomxoffset = randomfloatrange( ( var_a19aabc9baa3fd11 * -1 + effectrange ) * 0.5, ( var_a19aabc9baa3fd11 - effectrange ) * 0.5 );
        var_7a7ddc65433520b7 = effectrange * stretchmultiplier;
        dangerzoneheight = var_7a7ddc65433520b7 * var_112e899e83a90ecc;
        randomyoffset = randomfloatrange( ( dangerzoneheight * -1 + var_7a7ddc65433520b7 ) * 0.5, ( dangerzoneheight - var_7a7ddc65433520b7 ) * 0.5 );
        var_1b27cbf52ee0f21e = vectorcross( flightdir, ( 0, 0, 1 ) );
        var_f8068b0b6432fcdf = damagepos + randomxoffset * var_1b27cbf52ee0f21e + randomyoffset * flightdir;
    }
    
    return var_f8068b0b6432fcdf;
}

// Namespace airstrike
// Params 6
// Checksum 0x3f17f446, Offset: 0x7045
// Size: 0x1f6
function function_ab921f167ae4f60( owner, airstrikeid, var_a9673f63c24533f1, flightdir, streakname, planeflyheight )
{
    currentairstrike = level.activeairstrikes[ airstrikeid ];
    
    if ( !isdefined( currentairstrike ) )
    {
        return;
    }
    
    range = 300;
    sizemultiplier = 1;
    
    if ( getmatchrulesdata( "commonOption", "isAirstrikeZoneRandom" ) )
    {
        sizemultiplier = getmatchrulesdata( "commonOption", "airstrikeZoneSizeMultiplier" );
        range = 300 * sizemultiplier;
    }
    
    range += getmatchrulesdata( "commonOption", "airstrikeNotifyCircleAddedRange" );
    var_39608ff9f170fda3 = level.teamdata[ owner.team ][ "players" ];
    var_39608ff9f170fda3 = arrayremove( var_39608ff9f170fda3, owner );
    var_a11daf0a3d76391c = [];
    var_7f3d100d4b810850 = function_e39813cb83fedf3d( var_a9673f63c24533f1, flightdir, sizemultiplier );
    
    foreach ( circleorigin in var_7f3d100d4b810850 )
    {
        var_6c57ac8e6872aecb = killstreak_utility::function_1f4d8fce0c748142( circleorigin, range, var_39608ff9f170fda3, undefined, planeflyheight );
        var_a11daf0a3d76391c = arraycombineunique( var_a11daf0a3d76391c, var_6c57ac8e6872aecb );
    }
    
    foreach ( player in var_a11daf0a3d76391c )
    {
        killstreak_utility::function_1e1ca079700e042( owner, player, streakname );
    }
    
    return var_a11daf0a3d76391c;
}

/#

    // Namespace airstrike
    // Params 2
    // Checksum 0xb9b007d3, Offset: 0x7244
    // Size: 0x134, Type: dev
    function function_afdb990176a991aa( var_a9673f63c24533f1, flightdir )
    {
        self.var_984e4cbee1a6a3ac = [];
        range = 300;
        sizemultiplier = 1;
        
        if ( getmatchrulesdata( "<dev string:x69>", "<dev string:x76>" ) )
        {
            sizemultiplier = getmatchrulesdata( "<dev string:x69>", "<dev string:x8c>" );
            range = 300 * sizemultiplier;
        }
        
        range += getmatchrulesdata( "<dev string:x69>", "<dev string:xa8>" );
        var_7f3d100d4b810850 = function_e39813cb83fedf3d( var_a9673f63c24533f1, flightdir, sizemultiplier );
        
        foreach ( circleorigin in var_7f3d100d4b810850 )
        {
            currentindex = self.var_984e4cbee1a6a3ac.size;
            self.var_984e4cbee1a6a3ac[ currentindex ] = spawnstruct();
            self.var_984e4cbee1a6a3ac[ currentindex ] game_utility::questcircle_create( "<dev string:xc8>", circleorigin, range );
        }
    }

#/

// Namespace airstrike
// Params 3
// Checksum 0x5b82576a, Offset: 0x7380
// Size: 0x7f
function function_e39813cb83fedf3d( damagepos, planedir, sizemultiplier )
{
    multiplier = 1;
    
    if ( isdefined( sizemultiplier ) )
    {
        multiplier = sizemultiplier;
    }
    
    return [ damagepos - planedir * 256 * multiplier * 2, damagepos - planedir * 256 * multiplier, damagepos, damagepos + planedir * 256 * multiplier, damagepos + planedir * 256 * multiplier * 2 ];
}

// Namespace airstrike
// Params 0
// Checksum 0x1146cc7b, Offset: 0x7408
// Size: 0x308
function function_a70c0b39149ecb27()
{
    self endon( #"hash_1f12c0b3ee07e6c1" );
    level endon( #"game_ended" );
    var_d784875f966a56bb = level.airstrikeprops.var_4d7ca22e5490c24b * level.airstrikeprops.var_4d7ca22e5490c24b;
    
    /#
        var_b255dd561badba32 = getdvarint( @"hash_de3bb82d99946baf", 0 );
    #/
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            isfriendly = player_utility::isfriendly( self.owner.team, player ) && self.owner != player;
            
            if ( distance2dsquared( player.origin, self.damagepos ) <= var_d784875f966a56bb )
            {
                if ( isfriendly )
                {
                    self.friendlycircle.circle game_utility::questcircle_showtoplayer( player );
                }
                else
                {
                    self.enemycircle.circle game_utility::questcircle_showtoplayer( player );
                }
                
                /#
                    if ( var_b255dd561badba32 )
                    {
                        self.debugcircle.circle game_utility::questcircle_showtoplayer( player );
                        
                        if ( isdefined( self.var_984e4cbee1a6a3ac ) )
                        {
                            foreach ( circle in self.var_984e4cbee1a6a3ac )
                            {
                                circle game_utility::questcircle_showtoplayer( player );
                            }
                        }
                    }
                #/
                
                continue;
            }
            
            self.friendlycircle.circle game_utility::questcircle_hidefromplayer( player );
            self.enemycircle.circle game_utility::questcircle_hidefromplayer( player );
            
            /#
                if ( var_b255dd561badba32 )
                {
                    self.debugcircle.circle game_utility::questcircle_hidefromplayer( player );
                    
                    if ( isdefined( self.var_984e4cbee1a6a3ac ) )
                    {
                        foreach ( circle in self.var_984e4cbee1a6a3ac )
                        {
                            circle game_utility::questcircle_hidefromplayer( player );
                        }
                    }
                }
            #/
        }
        
        waitframe();
    }
}

// Namespace airstrike
// Params 0
// Checksum 0xb480f214, Offset: 0x7718
// Size: 0x111
function function_7224c68634b1cf55()
{
    self notify( #"hash_1f12c0b3ee07e6c1" );
    
    if ( isdefined( self.enemycircle ) )
    {
        self.enemycircle.circle game_utility::questcircle_delete();
        self.enemycircle.circle = undefined;
    }
    
    if ( isdefined( self.friendlycircle ) )
    {
        self.friendlycircle.circle game_utility::questcircle_delete();
        self.friendlycircle.circle = undefined;
    }
    
    /#
        if ( isdefined( self.debugcircle ) )
        {
            self.debugcircle.circle game_utility::questcircle_delete();
            self.debugcircle.circle = undefined;
        }
        
        if ( isdefined( self.var_984e4cbee1a6a3ac ) )
        {
            for ( i = self.var_984e4cbee1a6a3ac.size - 1; i >= 0 ; i-- )
            {
                self.var_984e4cbee1a6a3ac[ i ] game_utility::questcircle_delete();
                self.var_984e4cbee1a6a3ac[ i ] = undefined;
            }
        }
    #/
}

// Namespace airstrike
// Params 2
// Checksum 0x90ec1b1, Offset: 0x7831
// Size: 0x3a
function function_6f9faf7f2510c659( badplace, airstrikeid )
{
    level endon( #"game_ended" );
    level waittill( "airstrike_finished" + "_" + airstrikeid );
    destroynavobstacle( badplace );
}

/#

    // Namespace airstrike
    // Params 2
    // Checksum 0xdbe21090, Offset: 0x7873
    // Size: 0xe8, Type: dev
    function function_86996cb4cc276740( bombexplodedelay, var_31ac5feb767f50eb )
    {
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        self notify( #"hash_9891000d08ef42d2" );
        self endon( #"hash_9891000d08ef42d2" );
        self notifyonplayercommand( "<dev string:xd3>", "<dev string:xeb>" );
        self notifyonplayercommand( "<dev string:xd3>", "<dev string:xf6>" );
        
        while ( true )
        {
            airstrikedebugon = getdvarint( @"scr_debugairstrike", 0 );
            
            if ( !airstrikedebugon )
            {
                waitframe();
                continue;
            }
            
            self waittill( #"hash_3316da0a504d8487" );
            shellshock_utility_cpmp::_shellshock( %"bomb_stun_mp", #"stun", 2, 0 );
            self setscriptablepartstate( "<dev string:x100>", "<dev string:x10b>", 0 );
            wait bombexplodedelay - 0.1;
            self setscriptablepartstate( "<dev string:x100>", "<dev string:x112>", 0 );
        }
    }

#/
