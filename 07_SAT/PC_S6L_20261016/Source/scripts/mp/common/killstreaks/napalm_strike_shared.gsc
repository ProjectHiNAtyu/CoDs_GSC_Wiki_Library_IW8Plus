// scripts\mp\common\killstreaks\napalm_strike_shared.gsc  (hash_384c7fe70ee74476.gscc) (size: 27774 Bytes / 0x6c7e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4fc7058 (4110184536)
// size ...... 27774 (0x6c7e)
// includes .. 20  (offset: 0x6756)
// strings ... 56  (offset: 0x67f6)
// dev strs .. 17  (offset: 0x6b96)
// exports ... 55  (offset: 0x4866)
// cseg ...... 0x459 + 0x440d (0x4866)
// imports ... 176 (offset: 0x50fe)
// animtree1 . 1   (offset: 0x6c62)
// animtree2 . 1   (offset: 0x6c6e)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\spawnlogic;

#namespace napalm_strike_shared;

// Namespace napalm_strike_shared
// Params 0, eflags: 0x1
// Checksum 0xc846364f, Offset: 0x477
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "napalm_strike" ), &init );
}

// Namespace napalm_strike_shared
// Params 0
// Checksum 0xd3d8e3cf, Offset: 0x496
// Size: 0x1ba
function init()
{
    bundle = level.streakglobals.streakbundles[ "napalm_strike" ];
    var_8ab304004650682f = level function_173be8ad13be529f( bundle );
    
    if ( !var_8ab304004650682f )
    {
        return;
    }
    
    killstreaks::registerkillstreak( "napalm_strike", &function_e823558acdea93f );
    killstreaks::registerkillstreakdamagedealingweapon( "napalm_strike", bundle.var_56c53538a90fd37a, #"large" );
    killstreaks::registerkillstreakdamagedealingweapon( "napalm_strike", bundle.napalmstrikefireweapon, #"large" );
    level.napalmstrikesettings = spawnstruct();
    level.napalmstrikesettings.var_56c53538a90fd37a = bundle.var_56c53538a90fd37a;
    level.napalmstrikesettings.var_af1fca9e54d85b22 = bundle.var_af1fca9e54d85b22;
    level.napalmstrikesettings.var_e563f409e186a794 = bundle.var_e563f409e186a794;
    level thread function_f333d340dbacc260();
    level thread register_on_kill_medal();
    level thread function_25341aa849820218();
    level.var_39b70ae728838d71 = [ "mp_t10_fallout":-500 ];
    var_5fccee06d36e2121 = getarraykeys( level.var_39b70ae728838d71 );
    
    if ( arraycontains( var_5fccee06d36e2121, level.mapname ) )
    {
        level.var_8bd25d405e116328 = level.var_39b70ae728838d71[ level.mapname ];
    }
    
    utility::registersharedfunc( #"napalm_strike", #"hash_50a3e263ce95377", &function_d294fa76468c7928 );
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        callback::add( #"smoke_spawned", &function_48a9cd9f27dcf8b6 );
    }
}

// Namespace napalm_strike_shared
// Params 1, eflags: 0x4
// Checksum 0x3dababac, Offset: 0x658
// Size: 0x1a
function private function_48a9cd9f27dcf8b6( params )
{
    level notify( #"hash_532abab9f2509cc5", params );
}

// Namespace napalm_strike_shared
// Params 0, eflags: 0x4
// Checksum 0xc4a5aa38, Offset: 0x67a
// Size: 0xbb
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        if ( isdefined( level.napalmstrikesettings.var_56c53538a90fd37a ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", level.napalmstrikesettings.var_56c53538a90fd37a, &on_killed_medal );
        }
        
        if ( isdefined( level.napalmstrikesettings.napalmstrikefireweapon ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", level.napalmstrikesettings.napalmstrikefireweapon, &on_killed_medal );
        }
    }
}

// Namespace napalm_strike_shared
// Params 0, eflags: 0x4
// Checksum 0xd2d43a17, Offset: 0x73d
// Size: 0xd7
function private function_25341aa849820218()
{
    level utility::flag_wait( "ProContentStreakBundlesParsed" );
    bundle = level.streakglobals.streakbundles[ "napalm_strike" ];
    
    foreach ( entry in bundle.var_8f21800662496353 )
    {
        probundle = level.streakglobals.var_91bdb7de5b47da10[ entry.proasset ];
        level function_173be8ad13be529f( probundle );
    }
}

// Namespace napalm_strike_shared
// Params 4
// Checksum 0x9a46af33, Offset: 0x81c
// Size: 0x9e
function function_f9fd18647678656e( player, locationoverride, angleoverride, heightoverride )
{
    streakinfo = killstreak_utility::createstreakinfo( "napalm_strike", player );
    streakinfo.streakitem = player killstreaks::createstreakitemstruct( "napalm_strike" );
    streakinfo.var_3343592587469cb5 = [];
    streakinfo.var_3343592587469cb5[ 0 ] = locationoverride;
    streakinfo.var_3343592587469cb5[ 1 ] = angleoverride;
    streakinfo.heightoverride = heightoverride;
    return player function_e823558acdea93f( streakinfo );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x59d9db6b, Offset: 0x8c3
// Size: 0x208
function function_e823558acdea93f( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.napalmstrikesettings.var_af1fca9e54d85b22 )
    {
        streakinfo.rotation = level.napalmstrikesettings.var_e563f409e186a794;
        return airstrike::tryuseairstrikefromstruct( streakinfo );
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    bundle = streakinfo.bundle;
    streakinfo.weaponname = bundle.deployweaponname;
    deployweaponobj = makeweapon( bundle.deployweaponname );
    deployresult = 1;
    
    if ( !isdefined( streakinfo.var_3343592587469cb5 ) )
    {
        deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &function_963073be5c6dd746 );
    }
    
    if ( !deployresult )
    {
        return 0;
    }
    
    if ( isdefined( streakinfo.owner.vehicle ) )
    {
        return 0;
    }
    
    useresult = napalmstrike_deploy( streakinfo );
    
    if ( !useresult )
    {
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"airstrike", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"airstrike", #"munitionused" ) ]]();
    }
    
    self.var_e73f627a785541a2[ "napalm_strike" ] = 0;
    killstreak_utility::function_e4f54128963e182( level.napalmstrikesettings.var_56c53538a90fd37a );
    killstreak_utility::function_3fcc14f5507d62f4( level.napalmstrikesettings.var_56c53538a90fd37a, level.napalmstrikesettings.napalmstrikefireweapon );
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
    
    return 1;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x25a85a73, Offset: 0xad4
// Size: 0xd9, Type: bool
function function_963073be5c6dd746( streakinfo )
{
    useresult = napalmstrike_canuse( self.origin );
    
    if ( useresult != "success" )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult );
        }
        
        return false;
    }
    
    streakinfo.var_d53d8dea4a240bbc = 1;
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    var_a86b041c65e59e27 = bundle.var_c7f8c07f173aede5 ?? 1;
    radarshowenemydirection = bundle.var_eb70d537f7f35720 ?? 0;
    mapselect::function_74e31405d43e142( 0, 1, undefined, undefined, streakinfo, undefined, 1, var_a86b041c65e59e27, radarshowenemydirection );
    return true;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xeb61ebd4, Offset: 0xbb6
// Size: 0x1f4, Type: bool
function napalmstrike_deploy( streakinfo )
{
    val::set( "select_airstrike_location", "weapon_switch", 0 );
    self setsoundsubmix( "mp_killstreak_overlay" );
    var_bdf48412a571c938 = [];
    
    if ( isdefined( streakinfo.var_3343592587469cb5 ) )
    {
        var_bdf48412a571c938[ 0 ] = spawnstruct();
        var_bdf48412a571c938[ 0 ].location = streakinfo.var_3343592587469cb5[ 0 ];
        var_bdf48412a571c938[ 0 ].angles = streakinfo.var_3343592587469cb5[ 1 ];
        var_bdf48412a571c938[ 0 ].string = "confirm_location";
    }
    else
    {
        var_bdf48412a571c938 = mapselect::function_ec95e9f1b6d329fb( streakinfo, undefined, 1 );
    }
    
    val::reset_all( "select_airstrike_location" );
    self clearsoundsubmix( "mp_killstreak_overlay" );
    
    if ( !isdefined( var_bdf48412a571c938 ) )
    {
        return false;
    }
    
    mappointinfo = var_bdf48412a571c938[ 0 ];
    useresult = napalmstrike_canuse( mappointinfo );
    
    if ( useresult != "success" )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( useresult );
        }
        
        return false;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    flybyanimname = level.scr_anim[ "napalm_strike" ][ "flyby" ];
    streakinfo.streakduration = bundle.var_7c7a81775b4d2700 + getanimlength( flybyanimname ) / 2;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( level.var_8bd25d405e116328 )
    {
        mappointinfo.location = ( mappointinfo.location[ 0 ], mappointinfo.location[ 1 ], level.var_8bd25d405e116328 );
    }
    
    thread function_fa0f45ba10feed3d( streakinfo, mappointinfo );
    thread function_3a73913d7af6adf6( streakinfo );
    return true;
}

// Namespace napalm_strike_shared
// Params 2
// Checksum 0xc1abc86, Offset: 0xdb3
// Size: 0x161
function function_fa0f45ba10feed3d( streakinfo, mappointinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    
    if ( bundle.var_eb70d537f7f35720 )
    {
        self.radarshowenemydirection = streakinfo.var_80b8aead1e08d421;
    }
    
    animname = level.scr_anim[ "napalm_strike" ][ "flyby" ];
    strikeanimlength = getanimlength( animname );
    
    if ( isdefined( streakinfo.heightoverride ) )
    {
        mappointinfo.heightoverride = streakinfo.heightoverride;
    }
    
    flightpath = function_8da002eae6a4ce0f( mappointinfo );
    thread function_ecfcc3860e618584( flightpath, streakinfo, animname );
    thread napalmstrike_watchgameend( streakinfo );
    wait strikeanimlength;
    level callback::callback( #"killstreak_finish_use", { #var_fd5888eb625b1ce3:1, #streakinfo:streakinfo } );
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x24>" + streakinfo.streakname, self );
        }
    #/
    
    killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xd26468d0, Offset: 0xf1c
// Size: 0xd4
function function_8da002eae6a4ce0f( mappointinfo )
{
    forward = anglestoforward( ( 0, mappointinfo.angles, 0 ) );
    startpoint = mappointinfo.location + forward * -24000;
    startpoint += ( 0, 0, 4300 );
    flightpath = spawnstruct();
    flightpath.startpoint = startpoint;
    flightpath.forward = vectornormalize( forward );
    flightpath.height = 4300;
    flightpath.target = mappointinfo.location;
    
    if ( isdefined( mappointinfo.heightoverride ) )
    {
        flightpath.height = mappointinfo.heightoverride;
    }
    
    return flightpath;
}

// Namespace napalm_strike_shared
// Params 3
// Checksum 0x1d1e7789, Offset: 0xff9
// Size: 0x580
function function_ecfcc3860e618584( flightpath, streakinfo, animname )
{
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    strikeanimlength = getanimlength( animname );
    var_4b1088f3f528603 = utility::get_notetrack_time( animname, "attack" );
    planestartpos = flightpath.target + ( 0, 0, flightpath.height );
    plane = function_b95e742abdd302d0( planestartpos, flightpath, streakinfo, bundle );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        plane [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 0, 100 );
    }
    
    if ( !bundle.candamage )
    {
        plane setcandamage( 0 );
    }
    else if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        plane thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( plane.maxhealth, "hitequip", &function_8bd3e5362a8d1ec7, &_napalm_strike_handle_damage, 1, 1 );
        plane napalmstrike_setupdamagefunctionality( streakinfo.streakname );
    }
    
    plane.minimapid = plane killstreak_utility::function_99456b220fc6798e( streakinfo.streakname, "icon_minimap_fuelairstrike", bundle, undefined, 1 );
    
    if ( level.streakglobals.var_3feb5f5305e6fe83 )
    {
        function_46a5a0ae8a411d8d( plane.minimapid, streakinfo.bundle.var_77216bac95c39355 );
        function_a9992b78cd05e28b( plane.minimapid, streakinfo.bundle.var_4d7d4b6afc661107 );
        function_82408b23a25468f3( plane.minimapid, flightpath.target );
    }
    
    plane hide();
    function_2b8e3d3ae2a6414a( plane.minimapid, 1 );
    var_22b95d281e70befb = level.airstrikeprops.mapdraw;
    airstrikecircles = spawnstruct();
    
    if ( var_22b95d281e70befb )
    {
        sizemultiplier = getmatchrulesdata( "commonOption", "airstrikeZoneSizeMultiplier" );
        
        if ( sizemultiplier <= 1 )
        {
            sizemultiplier = 1;
        }
        
        flightdir = flightpath.forward;
        airstrikecircles.owner = self;
        airstrikecircles.damagepos = flightpath.target;
        effectrange = bundle.var_d699609e011425b8;
        stretchmultiplier = ( bundle.var_7004f893ab4ee28f * bundle.var_e49996a186f281a5 + effectrange * 2 ) / effectrange;
        var_f8068b0b6432fcdf = airstrike::function_2ea7adb19ae7907c( flightpath.target, flightdir, effectrange, stretchmultiplier );
        airstrikecircles.enemycircle = airstrike::function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, 0, sizemultiplier, effectrange, stretchmultiplier );
        airstrikecircles.friendlycircle = airstrike::function_b0d8b242379ba61( var_f8068b0b6432fcdf, flightdir, 1, sizemultiplier, effectrange, stretchmultiplier );
        function_96ee9486b36d5d51( self, var_f8068b0b6432fcdf, flightpath, streakinfo.streakname );
        airstrikecircles thread airstrike::function_a70c0b39149ecb27();
    }
    
    var_74793eabc3f75fc = var_4b1088f3f528603 + 0.87;
    var_9ac627c2a5aa0173 = 8.596;
    plane.animname = streakinfo.streakname;
    plane animation::setanimtree();
    plane.scenenode = spawn( "script_model", planestartpos );
    plane.scenenode.angles = plane.angles;
    plane.scenenode setmodel( "tag_origin" );
    planedir = vectornormalize( anglestoforward( plane.angles ) );
    killcament = spawn( "script_model", plane.origin - planedir * 1000 );
    killcament.starttime = gettime();
    killcament setscriptmoverkillcam( "airstrike" );
    killcament linkto( plane, "tag_origin" );
    plane.killcament = killcament;
    influencer = spawnlogic::addspawninfluencer( #"killstreak_napalm_strike", flightpath.target, plane.team, plane.owner );
    codeid = [[ utility::getsharedfunc( #"spawn", #"getcodehandlefromscripthandle" ) ]]( influencer );
    
    if ( isdefined( influencer ) )
    {
        function_209b9b14037cef43( codeid, flightpath.forward );
    }
    
    level thread function_15d5089bbf3a9f85( plane, flightpath.startpoint, var_9ac627c2a5aa0173, strikeanimlength );
    thread napalm_strike_bomb( plane, var_74793eabc3f75fc, flightpath.target, streakinfo );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1, 2.5 );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"leave", 1, var_9ac627c2a5aa0173 + bundle.var_b0dd9b735f339b49 + 1 );
    wait var_74793eabc3f75fc + 4;
    
    if ( var_22b95d281e70befb )
    {
        airstrikecircles thread airstrike::function_7224c68634b1cf55();
    }
}

// Namespace napalm_strike_shared
// Params 4
// Checksum 0xd51591ab, Offset: 0x1581
// Size: 0x184
function function_b95e742abdd302d0( planestartpos, flightpath, streakinfo, bundle )
{
    plane = spawn( "script_model", planestartpos );
    plane setmodel( bundle.var_7d62648955a706c5 );
    plane.angles = vectortoangles( flightpath.forward );
    plane.forward = flightpath.forward;
    plane.flightheight = flightpath.height;
    plane.owner = self;
    plane.team = self.team;
    plane.lifeid = streakinfo.lifeid;
    plane.streakinfo = streakinfo;
    plane setotherent( self );
    plane scriptmoveroutline();
    plane scriptmoverthermal();
    plane scriptmoverplane();
    maxhealth = bundle.maxhealth ?? 800;
    plane.health = maxhealth;
    plane.maxhealth = maxhealth;
    plane.currenthealth = maxhealth;
    
    if ( level.var_36218e71baa7e689 )
    {
        level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = plane;
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        plane.var_c5ccf9dff3b5e393 = &function_27ddac38a798fde1;
    }
    
    return plane;
}

// Namespace napalm_strike_shared
// Params 1, eflags: 0x4
// Checksum 0xde09df36, Offset: 0x170e
// Size: 0x37
function private function_8bd3e5362a8d1ec7( data )
{
    veh = data.victim;
    veh thread destroyplane();
    return data.damage;
}

// Namespace napalm_strike_shared
// Params 1, eflags: 0x4
// Checksum 0x7b5eac31, Offset: 0x174e
// Size: 0x145
function private _napalm_strike_handle_damage( data )
{
    modifieddamage = data.damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( data.attacker, data.objweapon, data.meansofdeath, modifieddamage, self.maxhealth, 1, 1, 1 );
    }
    
    data.damage = modifieddamage;
    return data.damage;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x5b1149ae, Offset: 0x189c
// Size: 0x52
function function_27ddac38a798fde1( data )
{
    veh = data.victim;
    data.attacker thread points::doscoreevent( #"kill_ss_fuel_airstrike", data.objweapon );
    veh thread destroyplane();
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x6a97d7f5, Offset: 0x18f6
// Size: 0xd9
function napalmstrike_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = undefined;
    destroyedsplash = "callout_destroyed_" + streakname;
    var_c96bcef6709d6df1 = &function_6845183046ab518a;
    var_d188942a41771ea1 = &function_dd0c54e8afc9856e;
    premoddamagecallback = &napalmstrike_premodifydamage;
    postmoddamagecallback = &napalmstrike_postmodifydamage;
    deathcallback = &napalmstrike_handledeathdamage;
    killstreak_utility::killstreak_setupvehicledamagefunctionality( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    
    if ( isdefined( self.owner ) )
    {
        vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    }
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xf6e7b3c9, Offset: 0x19d7
// Size: 0x17
function function_6845183046ab518a( streakname )
{
    vehicle_damage::set_vehicle_hit_damage_data( streakname, 12 );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x91ab93cc, Offset: 0x19f6
// Size: 0xc
function function_dd0c54e8afc9856e( streakname )
{
    
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xfb879802, Offset: 0x1a0a
// Size: 0xe, Type: bool
function napalmstrike_premodifydamage( data )
{
    return true;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x6c101180, Offset: 0x1a21
// Size: 0x4a, Type: bool
function napalmstrike_postmodifydamage( data )
{
    damage = data.damage;
    self.currenthealth -= damage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return true;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xc8f16776, Offset: 0x1a74
// Size: 0x29, Type: bool
function napalmstrike_handledeathdamage( data )
{
    self.killedbyweapon = data.objweapon;
    thread destroyplane();
    return true;
}

// Namespace napalm_strike_shared
// Params 0
// Checksum 0xa5447c29, Offset: 0x1aa6
// Size: 0x1f
function destroyplane()
{
    self setscriptablepartstate( "explode", "on", 0 );
    thread deleteplane( 0.35 );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xa0d9146e, Offset: 0x1acd
// Size: 0x23
function deleteplane( delay )
{
    self notify( #"death" );
    self.isdestroyed = 1;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xf678185d, Offset: 0x1af8
// Size: 0x13
function function_8683c56995040945( data )
{
    destroyplane();
}

// Namespace napalm_strike_shared
// Params 4
// Checksum 0x5d5ebe19, Offset: 0x1b13
// Size: 0x14d
function function_15d5089bbf3a9f85( plane, planestartpos, var_9ac627c2a5aa0173, var_4cb38e466d08f81b )
{
    plane endon( #"death" );
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    bombardmentdelay = bundle.var_b0dd9b735f339b49;
    var_1cc3597535367267 = bundle.var_4f5167dd9507e990;
    flyoutfx = spawn( "script_model", planestartpos );
    flyoutfx setmodel( var_1cc3597535367267 );
    flyoutfx dontinterpolate();
    plane.flyoutfx = flyoutfx;
    flyoutfx thread function_bb24e4b93f355dc3( var_9ac627c2a5aa0173 + bombardmentdelay );
    flyoutfx thread function_8eeacfb7aec15333( plane );
    flyoutfx setscriptablepartstate( "approach", "on", 0 );
    plane setscriptablepartstate( "bodyfx", "on", 0 );
    wait bombardmentdelay;
    flyoutfx setscriptablepartstate( "flyby", "on", 0 );
    function_2b8e3d3ae2a6414a( plane.minimapid, 0 );
    plane show();
    plane.scenenode animation::anim_single_solo( plane, "flyby" );
    plane hide();
    function_2b8e3d3ae2a6414a( plane.minimapid, 1 );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x250e8402, Offset: 0x1c68
// Size: 0x38
function function_bb24e4b93f355dc3( var_9ac627c2a5aa0173 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait var_9ac627c2a5aa0173;
    self setscriptablepartstate( "flyout", "on", 0 );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xcd893bf4, Offset: 0x1ca8
// Size: 0x2d
function function_9aba881f045fa725( var_473369a4cd9ee15d )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait var_473369a4cd9ee15d;
    self delete();
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xd3ee1b3e, Offset: 0x1cdd
// Size: 0x53
function function_8eeacfb7aec15333( plane )
{
    self endon( #"death" );
    self endon( #"hash_9cfa9e9c404ddeb2" );
    level endon( #"game_ended" );
    
    while ( isdefined( plane ) )
    {
        self.origin = plane.origin;
        wait 0.05;
    }
}

// Namespace napalm_strike_shared
// Params 4
// Checksum 0xb67c09a8, Offset: 0x1d38
// Size: 0x4c2
function napalm_strike_bomb( plane, launchtime, damagepos, streakinfo )
{
    plane endon( #"death" );
    self endon( #"disconnect" );
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    bombardmentdelay = bundle.var_b0dd9b735f339b49;
    wait bombardmentdelay + launchtime;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    bombtracestart = damagepos + ( 0, 0, 4300 );
    bombtraceend = damagepos - ( 0, 0, 10000 );
    contentoverride = trace::create_shotclip_contents();
    bombtrace = trace::ray_trace( bombtracestart, bombtraceend, undefined, contentoverride );
    targetlocation = bombtrace[ "position" ] + bombtrace[ "normal" ] * 10;
    
    /#
        if ( getdvarint( @"scr_napalm_strike_debug", 0 ) )
        {
            sphere( targetlocation, 25, ( 0, 1, 0 ), 0, 600 );
        }
    #/
    
    var_87a08c5f3a6510f8 = function_e5331978758cbe71( targetlocation, plane.forward, bundle.var_e49996a186f281a5, bundle.var_76dba03198d5862b, bundle.var_7004f893ab4ee28f, bundle.var_2fbd2cea4ded3e0d );
    firepositions = function_ff3d1b85a9c0f92( targetlocation, plane.forward );
    doexplosionfx = 1;
    explosiontimeoffset = 0.1;
    plane setscriptablepartstate( "releaseSFX", "on" );
    canistercount = 0;
    
    foreach ( row in var_87a08c5f3a6510f8 )
    {
        wait explosiontimeoffset;
        
        foreach ( loc in row )
        {
            canistercount += 1;
            childthread function_376c59202ec1c37b( loc, plane, doexplosionfx, canistercount );
            doexplosionfx = 0;
        }
    }
    
    firecount = 0;
    firedamage = spawn( "script_model", targetlocation + ( 0, 0, 300 ) );
    firedamage.streakinfo = plane.streakinfo;
    emitters = [];
    
    foreach ( fireinfo in firepositions )
    {
        if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) && utility::callsharedfunc( #"smokemanager", #"hash_eee3d7a747ac525b", fireinfo.fireposition ) )
        {
            fireinfo.var_53e0d37197a62abb = 1;
            continue;
        }
        
        if ( isdefined( level.var_1b58ecf0375bb714 ) && ![[ level.var_1b58ecf0375bb714 ]]( fireinfo.fireposition ) )
        {
            continue;
        }
        
        emitters[ firecount ] = spawn( "script_model", fireinfo.fireposition );
        emitters[ firecount ].angles = plane.angles;
        emitters[ firecount ] setmodel( bundle.var_4f5167dd9507e990 );
        emitters[ firecount ].firevfx = fireinfo.firevfx;
        emitters[ firecount ].var_37b51af21c19b08 = fireinfo.var_37b51af21c19b08;
        emitters[ firecount ] setotherent( self );
        firecount++;
        waitframe();
    }
    
    firedamage thread napalmstrike_fire( emitters, plane.forward, bundle, streakinfo, firepositions, targetlocation );
    firedamage thread function_736aedff5f174946( plane, 5 );
    firedamage thread function_817f4e5260ecbbb( emitters );
    firedamage thread function_15cfeb64668ff1c3();
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        firedamage thread function_25c504b41068fb21( emitters, firepositions );
    }
}

// Namespace napalm_strike_shared
// Params 0
// Checksum 0xe558650b, Offset: 0x2202
// Size: 0x27
function function_15cfeb64668ff1c3()
{
    self endon( #"napalmStrike_end" );
    level waittill( #"game_ended" );
    self notify( #"napalmStrike_end" );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xb037508c, Offset: 0x2231
// Size: 0x66
function napalmstrike_watchgameend( streakinfo )
{
    self endon( #"disconnect" );
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

// Namespace napalm_strike_shared
// Params 2
// Checksum 0x5b5eb5e, Offset: 0x229f
// Size: 0x848
function function_ff3d1b85a9c0f92( targetloc, forward )
{
    firelocations = [];
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    strikelength = bundle.var_3110d8f38328585a;
    strikewidth = bundle.var_db95a1f1c500edba;
    var_6930d19400830582 = bundle.var_ec0c15d32256816f;
    var_5805e58585c4448e = bundle.var_7930185b06d1d229;
    var_2e597a7717ba542 = bundle.var_36b37d9327d827fd;
    var_242de62403f1268c = bundle.var_2e328c466d3579b3;
    var_207a92fc77bfc686 = bundle.var_5484defa796b1d4b;
    vforward = vectornormalize2( forward );
    vright = rotatevector( vforward, ( 0, -90, 0 ) );
    maxxoffset = int( 0.5 * strikewidth );
    maxyoffset = int( 0.5 * strikelength );
    contentoverride = trace::create_contents( 0, 1, 0, 1, 1 );
    var_cadf207a47808efe = vforward * -1 * maxyoffset;
    
    for ( i = 0; i < var_6930d19400830582 ; i++ )
    {
        dropinfo = spawnstruct();
        xoffset = randomintrange( int( maxxoffset * -1 / 3 ), int( maxxoffset / 3 ) ) * vright;
        yoffset = strikelength / var_6930d19400830582 * ( i + 0.5 ) * vforward;
        offsetlocation = targetloc + var_cadf207a47808efe + xoffset + yoffset;
        offsetlocation += ( 0, 0, 4300 );
        dropinfo.fireposition = utility::drop_to_ground( offsetlocation, undefined, undefined, undefined, contentoverride );
        dropinfo.firevfx = "fire_xlrg";
        inwater = 0;
        
        if ( utility::ispointinwater( dropinfo.fireposition - ( 0, 0, 32 ) ) )
        {
            inwater = 1;
        }
        
        dropinfo.var_37b51af21c19b08 = function_5e10adcd64ade5c8( 3, inwater );
        
        if ( bundle.var_7c0d4dae01b0ee42 && !inwater )
        {
            dropinfo.triggervolume = spawn( "noent_volume_trigger_box", dropinfo.fireposition, 0, ( 50, 50, 50 ), ( 50, 50, 50 ) );
        }
        
        firelocations[ firelocations.size ] = dropinfo;
        
        /#
            if ( getdvarint( @"hash_2c7ace3f8a31c71e", 0 ) )
            {
                sphere( dropinfo.fireposition, 25, ( 0, 1, 0 ), 0, 1000 );
            }
        #/
    }
    
    for ( i = 0; i < var_5805e58585c4448e ; i++ )
    {
        dropinfo = spawnstruct();
        xoffset = randomintrange( maxxoffset * -1, maxxoffset ) * vright;
        yoffset = randomintrange( maxyoffset * -1, maxyoffset ) * vforward;
        offsetlocation = targetloc + xoffset + yoffset;
        offsetlocation += ( 0, 0, 4300 );
        dropinfo.fireposition = utility::drop_to_ground( offsetlocation, undefined, undefined, undefined, contentoverride );
        dropinfo.firevfx = "fire_xlrg";
        inwater = 0;
        
        if ( utility::ispointinwater( dropinfo.fireposition - ( 0, 0, 32 ) ) )
        {
            inwater = 1;
        }
        
        dropinfo.var_37b51af21c19b08 = function_5e10adcd64ade5c8( 3, inwater );
        
        if ( bundle.var_7c0d4dae01b0ee42 && !inwater )
        {
            dropinfo.triggervolume = spawn( "noent_volume_trigger_box", dropinfo.fireposition, 0, ( 50, 50, 50 ), ( 50, 50, 50 ) );
        }
        
        firelocations[ firelocations.size ] = dropinfo;
        
        /#
            if ( getdvarint( @"hash_2c7ace3f8a31c71e", 0 ) )
            {
                sphere( dropinfo.fireposition, 25, ( 0, 1, 0 ), 0, 1000 );
            }
        #/
    }
    
    for ( i = 0; i < var_2e597a7717ba542 ; i++ )
    {
        dropinfo = spawnstruct();
        xoffset = randomintrange( maxxoffset * -1, maxxoffset ) * vright;
        yoffset = randomintrange( maxyoffset * -1, maxyoffset ) * vforward;
        offsetlocation = targetloc + xoffset + yoffset;
        offsetlocation += ( 0, 0, 4300 );
        dropinfo.fireposition = utility::drop_to_ground( offsetlocation, undefined, undefined, undefined, contentoverride );
        dropinfo.firevfx = "fire_med";
        inwater = 0;
        
        if ( utility::ispointinwater( dropinfo.fireposition - ( 0, 0, 32 ) ) )
        {
            inwater = 1;
        }
        
        dropinfo.var_37b51af21c19b08 = function_5e10adcd64ade5c8( 1, inwater );
        
        if ( bundle.var_7c0d4dae01b0ee42 && !inwater )
        {
            dropinfo.triggervolume = spawn( "noent_volume_trigger_box", dropinfo.fireposition, 0, ( 100, 100, 20 ), ( 100, 100, 20 ) );
        }
        
        firelocations[ firelocations.size ] = dropinfo;
        
        /#
            if ( getdvarint( @"hash_2c7ace3f8a31c71e", 0 ) )
            {
                sphere( dropinfo.fireposition, 10, ( 0, 0, 1 ), 0, 1000 );
            }
        #/
    }
    
    for ( i = 0; i < var_242de62403f1268c ; i++ )
    {
        dropinfo = spawnstruct();
        
        if ( i < var_242de62403f1268c / 2 )
        {
            xoffset = randomintrange( maxxoffset * -1, maxxoffset ) * vright;
            yoffset = randomintrange( maxyoffset * -1 - 40, maxyoffset * -1 + 40 ) * vforward;
        }
        else
        {
            xoffset = randomintrange( maxxoffset * -1, maxxoffset ) * vright;
            yoffset = randomintrange( maxyoffset - 40, maxyoffset + 40 ) * vforward;
        }
        
        offsetlocation = targetloc + xoffset + yoffset;
        offsetlocation += ( 0, 0, 4300 );
        dropinfo.fireposition = utility::drop_to_ground( offsetlocation, undefined, undefined, undefined, contentoverride );
        dropinfo.firevfx = "fire_sml";
        
        if ( utility::ispointinwater( dropinfo.fireposition - ( 0, 0, 32 ) ) )
        {
            continue;
        }
        
        dropinfo.var_37b51af21c19b08 = function_5e10adcd64ade5c8( 0 );
        
        if ( bundle.var_7c0d4dae01b0ee42 )
        {
            dropinfo.triggervolume = spawn( "noent_volume_trigger_box", dropinfo.fireposition, 0, ( 10, 10, 10 ), ( 10, 10, 10 ) );
        }
        
        firelocations[ firelocations.size ] = dropinfo;
        
        /#
            if ( getdvarint( @"hash_2c7ace3f8a31c71e", 0 ) )
            {
                sphere( dropinfo.fireposition, 10, ( 0, 1, 0 ), 0, 1000 );
            }
        #/
    }
    
    for ( i = 0; i < var_207a92fc77bfc686 ; i++ )
    {
        dropinfo = spawnstruct();
        
        if ( i < var_207a92fc77bfc686 / 2 )
        {
            xoffset = randomintrange( maxxoffset * -1 - 40, maxxoffset * -1 + 40 ) * vright;
            yoffset = randomintrange( maxyoffset * -1, maxyoffset ) * vforward;
        }
        else
        {
            xoffset = randomintrange( maxxoffset - 40, maxxoffset + 40 ) * vright;
            yoffset = randomintrange( maxyoffset * -1, maxyoffset ) * vforward;
        }
        
        offsetlocation = targetloc + xoffset + yoffset;
        offsetlocation += ( 0, 0, 4300 );
        dropinfo.fireposition = utility::drop_to_ground( offsetlocation, undefined, undefined, undefined, contentoverride );
        dropinfo.firevfx = "fire_sml";
        
        if ( utility::ispointinwater( dropinfo.fireposition - ( 0, 0, 32 ) ) )
        {
            continue;
        }
        
        dropinfo.var_37b51af21c19b08 = function_5e10adcd64ade5c8( 0 );
        
        if ( bundle.var_7c0d4dae01b0ee42 )
        {
            dropinfo.triggervolume = spawn( "noent_volume_trigger_box", dropinfo.fireposition, 0, ( 10, 10, 10 ), ( 10, 10, 10 ) );
        }
        
        firelocations[ firelocations.size ] = dropinfo;
        
        /#
            if ( getdvarint( @"hash_2c7ace3f8a31c71e", 0 ) )
            {
                sphere( dropinfo.fireposition, 10, ( 0, 1, 0 ), 0, 1000 );
            }
        #/
    }
    
    return firelocations;
}

// Namespace napalm_strike_shared
// Params 2
// Checksum 0x4fcecb67, Offset: 0x2af0
// Size: 0x1ac
function function_25c504b41068fb21( emitters, firepositions )
{
    self endon( #"napalmStrike_end" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_532abab9f2509cc5", params );
        
        foreach ( fireinfo in firepositions )
        {
            if ( ispointinvolume( fireinfo.fireposition + ( 0, 0, 10 ), params.trigger, 1 ) )
            {
                fireinfo.var_53e0d37197a62abb = 1;
            }
        }
        
        emitterkeys = getarraykeys( emitters );
        
        foreach ( key in emitterkeys )
        {
            if ( !isdefined( emitters[ key ] ) )
            {
                continue;
            }
            
            if ( ispointinvolume( emitters[ key ].origin + ( 0, 0, 10 ), params.trigger, 1 ) )
            {
                emitters[ key ] delete();
            }
        }
    }
}

// Namespace napalm_strike_shared
// Params 2
// Checksum 0xc369fc4, Offset: 0x2ca4
// Size: 0x92
function function_5e10adcd64ade5c8( size, inwater )
{
    if ( inwater )
    {
        if ( size == 0 || size == 1 )
        {
            idx = randomint( 1 );
            
            if ( idx == 0 )
            {
                return "water impact variant 1";
            }
            else
            {
                return "water impact variant 2";
            }
        }
        else
        {
            return "water impact";
        }
    }
    
    if ( size == 0 || size == 1 )
    {
        idx = randomint( 1 );
        
        if ( idx == 0 )
        {
            return "variant 1 on";
        }
        else
        {
            return "variant 2 on";
        }
        
        return;
    }
    
    return "on";
}

// Namespace napalm_strike_shared
// Params 2
// Checksum 0x97da19c0, Offset: 0x2d3e
// Size: 0xcd
function function_736aedff5f174946( plane, delay )
{
    utility::waittill_notify_or_timeout( "napalmStrike_end", delay );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"game" ][ #"returnobjectiveid" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        plane [[ var_32dbca3143d9c4a5 ]]( plane.minimapid );
    }
    
    if ( isdefined( plane.scenenode ) )
    {
        plane.scenenode delete();
    }
    
    if ( isdefined( plane.killcament ) )
    {
        plane.killcament delete();
    }
    
    if ( isdefined( plane.flyoutfx ) )
    {
        plane.flyoutfx delete();
    }
    
    if ( isdefined( plane ) )
    {
        plane delete();
    }
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xebbab3c3, Offset: 0x2e13
// Size: 0xb3
function function_817f4e5260ecbbb( emitters )
{
    self waittill( #"napalmStrike_end" );
    
    if ( isdefined( emitters ) )
    {
        emitterkeys = getarraykeys( emitters );
        
        foreach ( key in emitterkeys )
        {
            if ( !isdefined( emitters[ key ] ) )
            {
                continue;
            }
            
            emitters[ key ] delete();
        }
    }
    
    self delete();
}

// Namespace napalm_strike_shared
// Params 6
// Checksum 0xcc8c4da6, Offset: 0x2ece
// Size: 0x18e
function function_e5331978758cbe71( targetloc, forward, rows, cols, rowoffset, coloffset )
{
    hitlocs = [];
    maxxoffset = function_c84a774706a9daa1( cols, coloffset, 0 );
    maxyoffset = function_c84a774706a9daa1( rows, rowoffset, 1 );
    vright = rotatevector( forward, ( 0, -90, 0 ) );
    var_33ac2b2239da4cf4 = forward * rowoffset;
    var_d66aef5ec4861e43 = vright * coloffset;
    var_2857fe614b13bcb5 = vright * -1 * maxxoffset + forward * -1 * maxyoffset;
    contentoverride = trace::create_shotclip_contents();
    
    for ( row = 0; row < rows ; row++ )
    {
        hitlocs[ row ] = [];
        
        for ( col = 0; col < cols ; col++ )
        {
            if ( row == 0 && col == 0 )
            {
                hitloc = targetloc + var_2857fe614b13bcb5;
            }
            else if ( col == 0 )
            {
                var_8f110c9cebd42469 = hitlocs[ row - 1 ][ col ];
                hitloc = var_8f110c9cebd42469 + var_33ac2b2239da4cf4;
            }
            else
            {
                prevloc = hitlocs[ row ][ col - 1 ];
                hitloc = prevloc + var_d66aef5ec4861e43;
            }
            
            hitloc += ( 0, 0, 4300 );
            hitlocs[ row ][ col ] = utility::drop_to_ground( hitloc, undefined, undefined, undefined, contentoverride );
        }
    }
    
    return hitlocs;
}

// Namespace napalm_strike_shared
// Params 3
// Checksum 0x90f12aef, Offset: 0x3065
// Size: 0x57
function function_c84a774706a9daa1( count, offset, isrow )
{
    if ( count == 1 )
    {
        return 0;
    }
    
    if ( count % 2 == 0 )
    {
        return ( 0.5 * offset * ( count - 1 ) );
    }
    
    return int( 0.5 * count ) * offset;
}

// Namespace napalm_strike_shared
// Params 4
// Checksum 0xb00fa7e4, Offset: 0x30c4
// Size: 0x216
function function_376c59202ec1c37b( targetlocation, plane, doexplosionfx, canistercount )
{
    if ( targetlocation[ 2 ] < level.var_8bd25d405e116328 )
    {
        return;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    vforward = vectornormalize2( plane.forward );
    var_6b48e0219ac15737 = vforward * -400;
    droplocation = targetlocation + var_6b48e0219ac15737;
    var_34fda9130b044fca = spawn( "script_model", droplocation );
    var_34fda9130b044fca.angles = plane.angles;
    var_34fda9130b044fca.streakinfo = plane.streakinfo;
    var_34fda9130b044fca setmodel( bundle.var_4f5167dd9507e990 );
    var_34fda9130b044fca setentityowner( self );
    
    if ( canistercount == 1 )
    {
        var_7bbff1c7082272f2 = "releaseVFX";
    }
    else if ( canistercount == 2 || canistercount == 4 )
    {
        var_7bbff1c7082272f2 = "releaseVFX_2";
    }
    else
    {
        var_7bbff1c7082272f2 = "releaseVFX_3";
    }
    
    var_34fda9130b044fca setscriptablepartstate( var_7bbff1c7082272f2, "on", 0 );
    wait 1.3;
    var_34fda9130b044fca setscriptablepartstate( "explode", "on", 0 );
    
    if ( canistercount == 1 )
    {
        var_34fda9130b044fca setscriptablepartstate( "explodeSFXLarge", "on" );
    }
    
    level thread delaydeletefxents( var_34fda9130b044fca );
    projectileweapon = makeweapon( bundle.var_56c53538a90fd37a );
    targetlocation += ( 0, 0, 32 );
    plane radiusdamage( targetlocation, bundle.var_d699609e011425b8, bundle.var_c9083dd60da3bad7, bundle.var_c9083dd60da3bad7, self, "MOD_EXPLOSIVE", projectileweapon );
    
    /#
        if ( getdvarint( @"scr_napalm_strike_debug", 0 ) )
        {
            sphere( targetlocation, bundle.var_d699609e011425b8, ( 1, 0, 0 ), 0, 600 );
            sphere( targetlocation, 25, ( 1, 0, 1 ), 0, 600 );
        }
    #/
}

// Namespace napalm_strike_shared
// Params 6
// Checksum 0xd048b76f, Offset: 0x32e2
// Size: 0x1bd
function napalmstrike_fire( emitters, planeforward, bundle, streakinfo, firepositions, targetlocation )
{
    if ( emitters.size == 0 )
    {
        return;
    }
    
    wait bundle.var_ae8174a2a8e5018;
    var_6690c65264b5e0e = emitters[ 0 ].origin[ 2 ];
    var_9388c464d2855330 = emitters[ 0 ].origin[ 2 ];
    
    foreach ( emitter in emitters )
    {
        if ( !isdefined( emitter ) )
        {
            continue;
        }
        
        if ( emitter.origin[ 2 ] < var_6690c65264b5e0e )
        {
            var_6690c65264b5e0e = emitter.origin[ 2 ];
        }
        
        if ( emitter.origin[ 2 ] > var_9388c464d2855330 )
        {
            var_9388c464d2855330 = emitter.origin[ 2 ];
        }
        
        emitter setscriptablepartstate( emitter.firevfx, emitter.var_37b51af21c19b08 );
        waitframe();
    }
    
    thread function_199cc068cac2e3dc( firepositions, streakinfo.owner, planeforward, targetlocation, var_6690c65264b5e0e, var_9388c464d2855330 );
    wait bundle.var_7c7a81775b4d2700;
    self notify( #"napalmStrike_end" );
    
    if ( isdefined( streakinfo.owner ) )
    {
        streakinfo.owner.var_de2230a467dc7058[ streakinfo.id ] = undefined;
    }
}

// Namespace napalm_strike_shared
// Params 6
// Checksum 0x192fad8c, Offset: 0x34a7
// Size: 0x54a
function function_199cc068cac2e3dc( firepositions, owner, planeforward, targetlocation, var_6690c65264b5e0e, var_9388c464d2855330 )
{
    level endon( #"game_ended" );
    self endon( #"napalmStrike_end" );
    self endon( #"disconnect" );
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    var_ab3e529f0efadca5 = function_69e676d98f2df464( firepositions, planeforward, targetlocation );
    center = var_ab3e529f0efadca5[ 0 ];
    backleft = var_ab3e529f0efadca5[ 1 ];
    frontright = var_ab3e529f0efadca5[ 3 ];
    backright = var_ab3e529f0efadca5[ 4 ];
    farthestdist = distance2d( backleft, center );
    boundaryhorizontal = backleft - backright;
    boundaryvertical = frontright - backright;
    weapon = makeweapon( bundle.napalmstrikefireweapon );
    var_f8b836839b3fb74f = gettime();
    damageperiod = 1 / bundle.var_473b7a27bcdd21e5;
    
    while ( true )
    {
        potentialplayertargets = [];
        
        if ( level.friendlyfire == 0 )
        {
            if ( bundle.var_61f686dc75feaf49 )
            {
                potentialplayertargets = getplayersandaiarrayinradius( center, farthestdist );
            }
            else
            {
                enemyteams = team_utility::getenemyteams( owner.team, 1 );
                potentialplayertargets = getplayersandaiarrayinradius( center, farthestdist, enemyteams );
            }
            
            potentialplayertargets[ potentialplayertargets.size ] = owner;
        }
        else
        {
            potentialplayertargets = getplayersandaiarrayinradius( center, farthestdist );
        }
        
        confirmedplayertargets = [];
        
        foreach ( potentialtarget in potentialplayertargets )
        {
            if ( !player::isreallyalive( potentialtarget ) )
            {
                continue;
            }
            
            if ( potentialtarget.isjuggernaut && bundle.var_e60696b03b3db621 )
            {
                continue;
            }
            
            if ( !potentialtarget isonground() && !potentialtarget isswimming() )
            {
                continue;
            }
            
            if ( potentialtarget isswimunderwater() )
            {
                continue;
            }
            
            if ( function_974cfa86f3b99cae( potentialtarget, boundaryvertical, boundaryhorizontal, var_6690c65264b5e0e, var_9388c464d2855330, backleft, frontright, firepositions, bundle ) )
            {
                confirmedplayertargets[ confirmedplayertargets.size ] = potentialtarget;
            }
        }
        
        var_a2614b896df20125 = [];
        grenadeents = getentarrayinradius( "grenade", #classname, center, farthestdist );
        
        foreach ( potentialtarget in grenadeents )
        {
            if ( function_974cfa86f3b99cae( potentialtarget, boundaryvertical, boundaryhorizontal, var_6690c65264b5e0e, var_9388c464d2855330, backleft, frontright, firepositions, bundle ) )
            {
                var_a2614b896df20125[ var_a2614b896df20125.size ] = potentialtarget;
            }
        }
        
        turretents = getentarrayinradius( "misc_turret", #classname, center, farthestdist );
        
        foreach ( potentialtarget in turretents )
        {
            if ( function_974cfa86f3b99cae( potentialtarget, boundaryvertical, boundaryhorizontal, var_6690c65264b5e0e, var_9388c464d2855330, backleft, frontright, firepositions, bundle ) )
            {
                var_a2614b896df20125[ var_a2614b896df20125.size ] = potentialtarget;
            }
        }
        
        timeelapsed = ( gettime() - var_f8b836839b3fb74f ) * 0.001;
        
        if ( timeelapsed >= bundle.var_a9f0c2068369fb47 )
        {
            var_6f9ccb5a5d8a798a = bundle.var_8be69c613337166a;
        }
        else if ( timeelapsed >= bundle.var_3d11210a0ec50e48 )
        {
            var_6f9ccb5a5d8a798a = bundle.var_8be69d613337189d;
        }
        else
        {
            var_6f9ccb5a5d8a798a = bundle.var_8be69a6133371204;
        }
        
        foreach ( playertarget in confirmedplayertargets )
        {
            playertarget thread napalmstrike_burn( var_6f9ccb5a5d8a798a, bundle.var_678f9d6198923a16, bundle.var_473b7a27bcdd21e5, owner, weapon, self, 1 );
        }
        
        foreach ( entitytarget in var_a2614b896df20125 )
        {
            entitytarget thread napalmstrike_burn( var_6f9ccb5a5d8a798a, bundle.var_678f9d6198923a16, bundle.var_473b7a27bcdd21e5, owner, weapon, self, 0 );
        }
        
        wait damageperiod;
    }
}

// Namespace napalm_strike_shared
// Params 3
// Checksum 0x3e828b50, Offset: 0x39f9
// Size: 0x1e7
function function_69e676d98f2df464( firepositions, forward, targetlocation )
{
    vforward = vectornormalize2( forward );
    vleft = rotatevector( forward, ( 0, 90, 0 ) );
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    strikelength = bundle.var_3110d8f38328585a;
    strikewidth = bundle.var_db95a1f1c500edba;
    maxxoffset = 0.5 * strikewidth;
    maxyoffset = 0.5 * strikelength;
    p1 = targetlocation + maxxoffset * vleft + maxyoffset * vforward * -1;
    p2 = targetlocation + maxxoffset * vleft + maxyoffset * vforward;
    p3 = targetlocation + maxxoffset * vleft * -1 + maxyoffset * vforward;
    p4 = targetlocation + maxxoffset * vleft * -1 + maxyoffset * vforward * -1;
    p1 = ( p1[ 0 ], p1[ 1 ], targetlocation[ 2 ] );
    p2 = ( p2[ 0 ], p2[ 1 ], targetlocation[ 2 ] );
    p3 = ( p3[ 0 ], p3[ 1 ], targetlocation[ 2 ] );
    p4 = ( p4[ 0 ], p4[ 1 ], targetlocation[ 2 ] );
    
    /#
        if ( getdvarint( @"hash_2c7ace3f8a31c71e", 0 ) )
        {
            line( p1, p2, ( 1, 0, 0 ), 1, 0, 1200 );
            line( p2, p3, ( 1, 0, 0 ), 1, 0, 1200 );
            line( p3, p4, ( 1, 0, 0 ), 1, 0, 1200 );
            line( p4, p1, ( 1, 0, 0 ), 1, 0, 1200 );
        }
    #/
    
    return [ targetlocation, p1, p2, p3, p4 ];
}

// Namespace napalm_strike_shared
// Params 9
// Checksum 0x55fc6fb7, Offset: 0x3be9
// Size: 0x257, Type: bool
function function_974cfa86f3b99cae( potentialtarget, boundaryvertical, boundaryhorizontal, var_6690c65264b5e0e, var_9388c464d2855330, backleft, frontright, firepositions, bundle )
{
    if ( !isdefined( potentialtarget ) || !isplayer( potentialtarget ) && !isai( potentialtarget ) )
    {
        return false;
    }
    
    if ( !( potentialtarget.origin[ 2 ] >= var_6690c65264b5e0e && potentialtarget.origin[ 2 ] <= var_9388c464d2855330 ) )
    {
        if ( !potentialtarget function_fbf06f80548d841d() )
        {
            return false;
        }
    }
    
    var_5b83747fb813bd82 = 0;
    
    if ( bundle.var_7c0d4dae01b0ee42 )
    {
        foreach ( fire in firepositions )
        {
            if ( !fire.var_53e0d37197a62abb && isdefined( fire.triggervolume ) && ispointinvolume( potentialtarget.origin, fire.triggervolume, 1 ) )
            {
                var_5b83747fb813bd82 = 1;
                break;
            }
        }
    }
    else
    {
        var_6884153aca3d752d = 2 * potentialtarget.origin - backleft - frontright;
        dot1 = vectordot( boundaryvertical, var_6884153aca3d752d - boundaryvertical );
        dot2 = vectordot( boundaryvertical, var_6884153aca3d752d + boundaryvertical );
        dot3 = vectordot( boundaryhorizontal, var_6884153aca3d752d - boundaryhorizontal );
        dot4 = vectordot( boundaryhorizontal, var_6884153aca3d752d + boundaryhorizontal );
        check1 = dot1 <= 0;
        check2 = dot2 >= 0;
        check3 = dot3 <= 0;
        check4 = dot4 >= 0;
        var_5b83747fb813bd82 = check1 && check2 && check3 && check4;
    }
    
    if ( var_5b83747fb813bd82 )
    {
        var_9da681dc0a567c6f = potentialtarget function_fbf06f80548d841d();
        
        if ( function_1c3b3b3abb06b615( potentialtarget, var_9da681dc0a567c6f ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace napalm_strike_shared
// Params 7
// Checksum 0xb9f4fab9, Offset: 0x3e49
// Size: 0x12f
function napalmstrike_burn( damage, burntime, var_b049b1c24f5ca31e, owner, weapon, killcament, var_96677ca80359130b )
{
    self notify( #"napalmstrikeburning" );
    self endon( #"napalmstrikeburning" );
    self endon( #"death" );
    self.napalmstrikeburning = 1;
    childthread function_d294fa76468c7928( burntime, var_96677ca80359130b );
    damageperiod = 1 / var_b049b1c24f5ca31e;
    
    while ( isdefined( self ) && self.napalmstrikeburning )
    {
        if ( var_96677ca80359130b && self isswimunderwater() )
        {
            self notify( #"clearburnfx" );
            thread damage_effects::disableburnfx();
            self.napalmstrikeburning = 0;
            return;
        }
        
        damagethisframe = damage;
        
        if ( self ismeatshieldvictim() )
        {
            damagethisframe *= level.meatshieldhealthscale ?? 1;
        }
        
        self dodamage( damagethisframe, self.origin, owner, killcament, "MOD_FIRE", weapon );
        
        if ( var_96677ca80359130b && !isdefined( self.unittype ) )
        {
            thread damage_effects::enableburnfxfortime( burntime );
        }
        
        wait damageperiod;
    }
}

// Namespace napalm_strike_shared
// Params 2
// Checksum 0x9ba53d96, Offset: 0x3f80
// Size: 0x56
function function_d294fa76468c7928( burntime, var_96677ca80359130b )
{
    self endon( #"death" );
    utility::waittill_any_timeout( burntime, "death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        self.napalmstrikeburning = 0;
    }
    
    if ( var_96677ca80359130b )
    {
        self notify( #"clearburnfx" );
        thread damage_effects::disableburnfx();
    }
}

// Namespace napalm_strike_shared
// Params 2
// Checksum 0x97dec428, Offset: 0x3fde
// Size: 0x83, Type: bool
function function_1c3b3b3abb06b615( potentialtarget, inwater )
{
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    if ( inwater )
    {
        targetpos = potentialtarget.origin + ( 0, 0, 32 );
    }
    else
    {
        targetpos = potentialtarget.origin;
    }
    
    return !trace::ray_trace_passed( targetpos, targetpos + ( 0, 0, 10000 ), potentialtarget, contents );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x83b2dc80, Offset: 0x406a
// Size: 0x1a
function delaydeletefxents( var_34fda9130b044fca )
{
    waitframe();
    
    if ( isdefined( var_34fda9130b044fca ) )
    {
        var_34fda9130b044fca delete();
    }
}

#using_animtree( "script_model" );

// Namespace napalm_strike_shared
// Params 0
// Checksum 0x48828b2b, Offset: 0x408c
// Size: 0x46
function function_f333d340dbacc260()
{
    level.scr_animtree[ "napalm_strike" ] = #animtree;
    level.scr_anim[ "napalm_strike" ][ "flyby" ] = %t10_killstreak_napalm_strike_jet;
    game[ "dialog" ][ "airstrike_good_hit" ] = "precision_airstrike_hit";
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x5781d004, Offset: 0x40da
// Size: 0xd4
function function_3a73913d7af6adf6( streakinfo )
{
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    self notify( #"successful_fire" );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_napalm_strike", self );
    }
    
    utility::trycall( level.matchdata_logkillstreakevent, "napalm_strike", self.origin );
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
    
    val::set( "select_airstrike_location", "interactions", 1 );
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0xacfc712b, Offset: 0x41b6
// Size: 0x30e
function function_173be8ad13be529f( bundle )
{
    if ( !isdefined( bundle ) )
    {
        assertmsg( "<dev string:x38>" );
        return 0;
    }
    
    var_e6b5a6862d3471e5 = 1;
    
    if ( !isdefined( bundle.var_56c53538a90fd37a ) )
    {
        assertmsg( "<dev string:x62>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_d699609e011425b8 ) )
    {
        assertmsg( "<dev string:xa9>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_c9083dd60da3bad7 ) )
    {
        assertmsg( "<dev string:xf3>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_7c7a81775b4d2700 ) )
    {
        assertmsg( "<dev string:x13d>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_473b7a27bcdd21e5 ) )
    {
        assertmsg( "<dev string:x181>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_8be69a6133371204 ) )
    {
        assertmsg( "<dev string:x1ce>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_8be69d613337189d ) )
    {
        assertmsg( "<dev string:x21f>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_8be69c613337166a ) )
    {
        assertmsg( "<dev string:x270>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_3d11210a0ec50e48 ) )
    {
        assertmsg( "<dev string:x2c1>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_a9f0c2068369fb47 ) )
    {
        assertmsg( "<dev string:x30f>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_e49996a186f281a5 ) )
    {
        assertmsg( "<dev string:x35d>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_76dba03198d5862b ) )
    {
        assertmsg( "<dev string:x39f>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_7004f893ab4ee28f ) )
    {
        assertmsg( "<dev string:x3e1>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.var_2fbd2cea4ded3e0d ) )
    {
        bundle.var_2fbd2cea4ded3e0d = 0;
    }
    
    if ( !isdefined( bundle.var_b0dd9b735f339b49 ) )
    {
        bundle.var_b0dd9b735f339b49 = 0;
    }
    
    if ( !isdefined( bundle.var_72b2bb87dda51346 ) )
    {
        bundle.var_72b2bb87dda51346 = 0;
    }
    
    if ( !isdefined( bundle.var_ec0c15d32256816f ) )
    {
        bundle.var_ec0c15d32256816f = 15;
    }
    
    if ( !isdefined( bundle.var_7930185b06d1d229 ) )
    {
        bundle.var_7930185b06d1d229 = 17;
    }
    
    if ( !isdefined( bundle.var_36b37d9327d827fd ) )
    {
        bundle.var_36b37d9327d827fd = 15;
    }
    
    if ( !isdefined( bundle.var_2e328c466d3579b3 ) )
    {
        bundle.var_2e328c466d3579b3 = 15;
    }
    
    if ( !isdefined( bundle.var_5484defa796b1d4b ) )
    {
        bundle.var_5484defa796b1d4b = 37;
    }
    
    if ( !isdefined( bundle.var_ae8174a2a8e5018 ) )
    {
        bundle.var_ae8174a2a8e5018 = 0.75;
    }
    
    if ( !isdefined( bundle.var_678f9d6198923a16 ) )
    {
        assertmsg( "<dev string:x429>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    if ( !isdefined( bundle.napalmstrikefireweapon ) )
    {
        assertmsg( "<dev string:x474>" );
        var_e6b5a6862d3471e5 = 0;
    }
    
    return var_e6b5a6862d3471e5;
}

// Namespace napalm_strike_shared
// Params 1
// Checksum 0x5a8f630e, Offset: 0x44cd
// Size: 0x11
function napalmstrike_canuse( strikelocation )
{
    return "success";
}

// Namespace napalm_strike_shared
// Params 4, eflags: 0x4
// Checksum 0xa9be7469, Offset: 0x44e7
// Size: 0xed
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "napalm_strike" );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "napalm_strike" ] ) && self.rapidkill_data[ "napalm_strike" ].rapidkill_count === 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_toasty" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "napalm_strike", victim );
    }
}

// Namespace napalm_strike_shared
// Params 4
// Checksum 0x355d2da7, Offset: 0x45dc
// Size: 0x289
function function_96ee9486b36d5d51( owner, var_a9673f63c24533f1, flightpath, streakname )
{
    bundle = killstreak::function_85b2d8e857ab4898( "napalm_strike" );
    range = bundle.var_d699609e011425b8;
    
    if ( getmatchrulesdata( "commonOption", "isAirstrikeZoneRandom" ) )
    {
        sizemultiplier = getmatchrulesdata( "commonOption", "airstrikeZoneSizeMultiplier" );
        range = bundle.var_d699609e011425b8 * sizemultiplier;
    }
    
    range += getmatchrulesdata( "commonOption", "airstrikeNotifyCircleAddedRange" );
    var_39608ff9f170fda3 = level.teamdata[ owner.team ][ "players" ];
    var_39608ff9f170fda3 = arrayremove( var_39608ff9f170fda3, owner );
    var_a11daf0a3d76391c = [];
    impactlocations = function_e5331978758cbe71( flightpath.target, flightpath.forward, bundle.var_e49996a186f281a5, bundle.var_76dba03198d5862b, bundle.var_7004f893ab4ee28f, bundle.var_2fbd2cea4ded3e0d );
    
    foreach ( row in impactlocations )
    {
        foreach ( loc in row )
        {
            var_6c57ac8e6872aecb = killstreak_utility::function_1f4d8fce0c748142( loc, range, var_39608ff9f170fda3 );
            var_a11daf0a3d76391c = arraycombineunique( var_a11daf0a3d76391c, var_6c57ac8e6872aecb );
        }
    }
    
    foreach ( player in var_a11daf0a3d76391c )
    {
        killstreak_utility::function_1e1ca079700e042( owner, player, streakname );
    }
    
    return var_a11daf0a3d76391c;
}

