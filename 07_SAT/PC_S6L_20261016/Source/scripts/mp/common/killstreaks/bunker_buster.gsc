// scripts\mp\common\killstreaks\bunker_buster.gsc  (hash_3b0857aacc0e973b.gscc) (size: 17816 Bytes / 0x4598 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa91324 (11080484)
// size ...... 17816 (0x4598)
// includes .. 15  (offset: 0x4188)
// strings ... 51  (offset: 0x4200)
// dev strs .. 11  (offset: 0x4510)
// exports ... 44  (offset: 0x2afc)
// cseg ...... 0x402 + 0x26fa (0x2afc)
// imports ... 130 (offset: 0x31dc)
// animtree1 . 0   (offset: 0x4598)
// animtree2 . 0   (offset: 0x4598)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;

#namespace bunker_buster;

// Namespace bunker_buster
// Params 0, eflags: 0x1
// Checksum 0x709e0be9, Offset: 0x420
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "bunker_buster" ), &init );
}

// Namespace bunker_buster
// Params 0, eflags: 0x4
// Checksum 0xa7a6eca7, Offset: 0x43f
// Size: 0x9d
function private init()
{
    /#
        utility::function_95db22f620602461( @"scr_bunker_buster_debug", &debug_init );
    #/
    
    if ( utility::issharedfuncdefined( "bunker_buster", #"init" ) )
    {
        [[ utility::getsharedfunc( "bunker_buster", #"init" ) ]]();
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "bunker_buster", &function_ff697471ad2c7dbf, undefined, undefined );
    utility::registersharedfunc( "bunker_buster", #"tryusekillstreak", &function_ff697471ad2c7dbf );
    utility::registersharedfunc( "bunker_buster", #"hash_640202cd3ccf3fc5", &getplayersinradius, 1 );
    thread postmaininit();
    init_vars();
}

// Namespace bunker_buster
// Params 0, eflags: 0x4
// Checksum 0xcbb0bcf4, Offset: 0x4e4
// Size: 0x19
function private postmaininit()
{
    waitframe();
    equipment_mp::registercallback( "bunker_buster", "onDestroyedByTrophy", &function_6171ed266f3dbf63 );
}

// Namespace bunker_buster
// Params 0, eflags: 0x4
// Checksum 0x74ed512f, Offset: 0x505
// Size: 0x462
function private init_vars()
{
    level.bunker_buster = { #count:0, #active:[] };
    level.bunker_buster.max_active = getdvarint( @"hash_fefb922caac82d40", 3 );
    level.bunker_buster.var_a6570338284f600d = getdvarint( @"hash_22beca14dc5c5e9e", 1 );
    level.bunker_buster.var_cbb670a6fa03722d = getdvarint( @"hash_7531df69c5e1c03c", 25000 );
    level.bunker_buster.var_cbb670a6fa03722d *= level.bunker_buster.var_cbb670a6fa03722d;
    level.bunker_buster.var_a6753d342149ca80 = getdvarint( @"hash_f6c741cacf5a1bd1", 1 );
    level.bunker_buster.cooldown = getdvarint( @"hash_359501fa941316db", 10 );
    bundle = level.streakglobals.streakbundles[ "bunker_buster" ];
    assert( isdefined( bundle ), "<dev string:x24>" + "<dev string:x3d>" + "<dev string:x54>" + "<dev string:x62>" );
    
    if ( utility::callsharedfunc( #"gas", #"hash_43bf0d88a1c3c9b8", bundle ) )
    {
        gasbundle = getscriptbundle( bundle.gassettings );
        
        if ( !utility::callsharedfunc( #"gas", #"hash_72b9083857205f79", "bunker_buster" ) )
        {
            utility::callsharedfunc( #"gas", #"hash_b1acc2201b601807", "bunker_buster", gasbundle );
        }
        
        level.bunker_buster.var_8411ba005ba2ff6a = 1;
        level.bunker_buster.gassettings = gasbundle;
        level.bunker_buster.gas_lifetime = gasbundle.duration ?? 25;
        level.bunker_buster.gas_radius = gasbundle.radius ?? 350;
        level.bunker_buster.gas_height = gasbundle.height;
        level.bunker_buster.create_trigger_func = utility::getsharedfunc( #"gas", #"hash_87b583f48f67914e" );
    }
    
    if ( !level.bunker_buster.var_8411ba005ba2ff6a )
    {
        level.bunker_buster.gas_lifetime = getdvarint( @"scr_ks_bunker_buster_gas_lifetime", bundle.var_aac8e5e1ba638468 );
        level.bunker_buster.gas_radius = getdvarint( @"scr_ks_bunker_buster_gas_radius", bundle.var_6f4710262b529771 );
    }
    
    level.bunker_buster.travel_distance = getdvarint( @"scr_ks_bunker_buster_distance", bundle.bunker_buster_distance ?? 1000 );
    level.bunker_buster.explosion_radius = getdvarint( @"hash_e9222aff0b6e25e4", bundle.bunker_buster_explosionradius );
    level.bunker_buster.explosion_min_damage = getdvarint( @"hash_3dd9eddc725440b6", bundle.var_fa219ea5797e949e );
    level.bunker_buster.explosion_max_damage = getdvarint( @"hash_c84afea8311a2900", bundle.var_e5ab5bd980acb36c );
    level.bunker_buster.drop_time = getdvarint( @"hash_183522347c70eb09", bundle.bunker_buster_droptime );
    level.bunker_buster.trophy_damage_mod = getdvarfloat( @"hash_eaad723ebfc7e367", bundle.var_d5aad4bcdef5303c ?? 0 );
    level.bunker_buster.var_ecb67aaa6ecc60f3 = getdvarfloat( @"hash_1947c7dc6cc31067", bundle.var_fa1fe3b4a66e42ad ?? 275 );
    level.bunker_buster.projectile_weapon = bundle.projectileweapon;
}

// Namespace bunker_buster
// Params 1, eflags: 0x4
// Checksum 0x83054211, Offset: 0x96f
// Size: 0x197, Type: bool
function private function_ff697471ad2c7dbf( streakinfo = killstreak_utility::createstreakinfo( "bunker_buster", self ) )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isbrgamemode() && isdefined( self.kstargetlocation ) )
    {
        streakinfo.targetoverride = self.kstargetlocation;
        self.kstargetlocation = undefined;
    }
    
    if ( isdefined( streakinfo.targetoverride ) )
    {
        firedresult = airstrike::weaponfiredairstrike( streakinfo, undefined, undefined );
        deployresult = firedresult == "success";
    }
    else
    {
        bundle = level.streakglobals.streakbundles[ "bunker_buster" ];
        deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweaponfireddeploysharedfunc( streakinfo, weapon_utility::function_d2c8356dc369d9ce( bundle.deployweaponname ), "weapon_fired", &function_a578351d4bc8e939, &airstrike::weaponswitchendedairstrike, &function_b941d514a33a7dcc );
    }
    
    if ( !deployresult )
    {
        self setclientomnvar( "ui_using_bunkerbuster", 0 );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "bunker_buster", self );
    }
    
    strike_create( streakinfo );
    
    if ( isbrgamemode() )
    {
        self.var_4ab6da7bfb8323fa = gettime();
    }
    
    return true;
}

// Namespace bunker_buster
// Params 0, eflags: 0x4
// Checksum 0x10e98f43, Offset: 0xb0f
// Size: 0x3f
function private function_25b433d2826a9b5f()
{
    mindistsq = level.bunker_buster.var_cbb670a6fa03722d;
    
    /#
        if ( level.mapname == "<dev string:x71>" )
        {
            mindistsq = 1000000;
        }
    #/
    
    return mindistsq;
}

// Namespace bunker_buster
// Params 1
// Checksum 0x61f0de4d, Offset: 0xb57
// Size: 0xd3
function function_26fedf018210141d( strikelocation )
{
    shortestleft = 2147483647;
    
    foreach ( activestrike in level.bunker_buster.active )
    {
        timeleft = int( max( 1, activestrike.endtimems - gettime() ) );
        
        if ( timeleft < shortestleft )
        {
            shortestleft = timeleft;
        }
    }
    
    return int( utility::function_6f5d2e1f1ff70482( shortestleft ) ) + 1;
}

// Namespace bunker_buster
// Params 1
// Checksum 0x8c163705, Offset: 0xc33
// Size: 0x105
function function_6448949393da3017( strikelocation )
{
    shortestleft = 2147483647;
    mindistsq = function_25b433d2826a9b5f();
    numactive = 0;
    
    foreach ( activestrike in level.bunker_buster.active )
    {
        if ( distance2dsquared( activestrike.origin, strikelocation ) <= mindistsq )
        {
            timeleft = int( max( 1, activestrike.endtimems - gettime() ) );
            
            if ( timeleft < shortestleft )
            {
                shortestleft = timeleft;
            }
        }
    }
    
    return int( utility::function_6f5d2e1f1ff70482( shortestleft ) ) + 1;
}

// Namespace bunker_buster
// Params 1, eflags: 0x4
// Checksum 0xbf33e317, Offset: 0xd41
// Size: 0xac, Type: bool
function private function_a578351d4bc8e939( streakinfo )
{
    if ( !level.in_play_limits_in_use )
    {
        if ( !bunker_buster_can_be_used_globally( streakinfo.streakname ) )
        {
            if ( level.bunker_buster.var_a6753d342149ca80 )
            {
                timesec = function_26fedf018210141d();
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME", timesec );
            }
            else
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
            }
            
            return false;
        }
    }
    
    self setclientomnvar( "ui_using_bunkerbuster", 1 );
    return true;
}

// Namespace bunker_buster
// Params 1, eflags: 0x4
// Checksum 0x75474a4e, Offset: 0xdf6
// Size: 0x8f
function private bunker_buster_can_be_used_globally( killstreakname )
{
    var_2017875ee0a56884 = 1;
    
    if ( level.bunker_buster.active.size >= level.bunker_buster.max_active )
    {
        var_2017875ee0a56884 = 0;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"hash_377b9525d18c0e38" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"hash_377b9525d18c0e38" ) ]]( undefined, undefined, killstreakname, undefined, undefined, undefined, var_2017875ee0a56884, "bunker_buster_can_be_used_globally" );
    }
    
    return var_2017875ee0a56884;
}

// Namespace bunker_buster
// Params 3, eflags: 0x4
// Checksum 0x2168342e, Offset: 0xe8e
// Size: 0x13b
function private function_b941d514a33a7dcc( streakinfo, firedweaponobj, firedprojectile )
{
    if ( !isdefined( streakinfo.targetoverride ) )
    {
        mappoint = airstrike::airstrike_getownerlookatpos( self, 1 );
        
        if ( isdefined( mappoint ) )
        {
            bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
            
            if ( bundle.var_8771a3dbfc3b5dbe && !namespace_9d8e359c3b1041e5::function_99585ce0ed7d5df7( streakinfo, mappoint ) )
            {
                return "continue";
            }
        }
        else
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/INVALID_POINT" );
            }
            
            return "continue";
        }
    }
    
    if ( namespace_9d8e359c3b1041e5::is_empdsharedfunc() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/CANNOT_BE_USED" );
        }
        
        return "continue";
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_using_bunkerbuster", 0 );
    }
    
    return "success";
}

// Namespace bunker_buster
// Params 2
// Checksum 0x246745c6, Offset: 0xfd2
// Size: 0xa2
function function_6e88bee04cdc4b1c( origin, streakinfo )
{
    newstrike = spawnstruct();
    newstrike.origin = origin;
    newstrike.id = streakinfo.uid;
    newstrike.endtimems = gettime() + 1000 * ( level.bunker_buster.cooldown + 5 );
    level.bunker_buster.active[ newstrike.id ] = newstrike;
    return newstrike.id;
}

// Namespace bunker_buster
// Params 0, eflags: 0x4
// Checksum 0xf175f93a, Offset: 0x107d
// Size: 0xe
function private function_6171ed266f3dbf63()
{
    self notify( #"trophy_blocked" );
}

// Namespace bunker_buster
// Params 1, eflags: 0x4
// Checksum 0x79bffe99, Offset: 0x1093
// Size: 0x40
function private strike_create( streakinfo )
{
    self notify( #"successful_fire" );
    streakinfo.uid = function_284de62c881a1cee();
    thread strike_fire( streakinfo );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace bunker_buster
// Params 1
// Checksum 0x221f0ba0, Offset: 0x10db
// Size: 0x1eb
function strike_fire( streakinfo )
{
    streakinfo.shots_fired++;
    marker_pos = streakinfo.targetoverride ?? toma_strike::tomastrike_getownerlookat( self );
    
    if ( !isdefined( marker_pos ) )
    {
        return;
    }
    
    marker = utility::spawn_model( "ks_toma_strike_marker_mp", marker_pos );
    marker.objidnum = 0;
    marker.icon = streakinfo.bundle.markericon ?? "icon_waypoint_bunker_buster";
    function_6e88bee04cdc4b1c( marker_pos, streakinfo );
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        marker.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
    }
    
    marker setotherent( self );
    marker toma_strike::toma_strike_setmarkerobjective( marker.objidnum, marker.icon, self, 50 );
    marker thread missile_marker_objective();
    thread utility::callsharedfunc( "bunker_buster", #"dialog_deploy", self );
    predictedimpactpos = function_b987c23db3b090ab( marker_pos );
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( self, self.team, 1024, "bunker_buster", predictedimpactpos, isbrgamemode() ? 6000 : 1000 );
    notify_players = function_bf39041329833efb( self, self.team, 1024, predictedimpactpos );
    utility::callsharedfunc( "bunker_buster", #"dialog_warning", notify_players[ 0 ], notify_players[ 1 ] );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( level.bunker_buster.drop_time );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    strike_logic( marker_pos, streakinfo );
    wait level.bunker_buster.cooldown;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    strike_end( streakinfo );
}

// Namespace bunker_buster
// Params 1
// Checksum 0x4067ed68, Offset: 0x12ce
// Size: 0x62
function strike_end( streakinfo )
{
    level.bunker_buster.active[ streakinfo.uid ] = undefined;
    level notify( "bunker_buster" + "_finished_" + streakinfo.uid );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace bunker_buster
// Params 4, eflags: 0x4
// Checksum 0xee40ff4, Offset: 0x1338
// Size: 0xf3
function private function_bf39041329833efb( owner, team, range, location )
{
    players = getplayersinradius( location, range, 1000 );
    friendlies = [];
    enemies = [];
    
    foreach ( player in players )
    {
        if ( player == owner )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            friendlies[ friendlies.size ] = player;
            continue;
        }
        
        enemies[ enemies.size ] = player;
    }
    
    return [ friendlies, enemies ];
}

// Namespace bunker_buster
// Params 0
// Checksum 0x9103ed13, Offset: 0x1434
// Size: 0x35
function function_284de62c881a1cee()
{
    level.bunker_buster.count++;
    return self getxuid() + "_" + level.bunker_buster.count;
}

// Namespace bunker_buster
// Params 2
// Checksum 0x6a877ac6, Offset: 0x1472
// Size: 0x42b
function strike_logic( position, streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level endon( "bunker_buster" + "_finished_" + streakinfo.uid );
    missile = missile_spawn( streakinfo.bundle, position, 5000, ( 0, 0, -1000 ) );
    missile.streakinfo = streakinfo;
    missile.streakname = streakinfo.streakname;
    results = missile function_dd3af078950c0d15( self, streakinfo.bundle );
    stuck_to = results[ 0 ];
    missile = results[ 1 ];
    hit = results[ 2 ];
    
    if ( !isdefined( missile ) )
    {
        return;
    }
    
    streakinfo.impact_location = missile.origin;
    streakinfo.water_impact = missile.water_impact;
    streakinfo.trophy_blocked = missile.trophy_blocked;
    streakinfo.impact_time = game_utility::gettimepassed();
    
    if ( streakinfo.trophy_blocked )
    {
        streakinfo.override_travel_dist = level.bunker_buster.var_ecb67aaa6ecc60f3;
    }
    
    activestrike = level.bunker_buster.active[ streakinfo.uid ];
    
    if ( isdefined( activestrike ) )
    {
        activestrike.endtimems = gettime() + 1000 * ( level.bunker_buster.cooldown + 1 );
    }
    
    missile function_9221089e695f3198();
    missile.angles = ( 0, 0, 0 );
    missile cleartrajectory();
    
    if ( missile islinked() )
    {
        missile unlink();
    }
    
    missile setscriptablepartstate( "visibility", "hide" );
    missile.exploded = 1;
    streakinfo.explosion_victims = get_explosion_victims( streakinfo, self );
    function_707635fca9cd562b( streakinfo.explosion_victims );
    streakinfo.gas_victims = [];
    waitframe();
    
    if ( isdefined( missile ) )
    {
        explosionstate = "explode";
        
        if ( streakinfo.trophy_blocked )
        {
            explosionstate = "explode_trophy";
        }
        else if ( streakinfo.water_impact )
        {
            explosionstate = "explode_water";
        }
        
        missile setscriptablepartstate( "explode", explosionstate );
        missile missile_explosion_calculation();
    }
    
    if ( hit )
    {
        streakinfo.explosion_victims[ "exception_credit" ] = 1;
    }
    
    wait 0.25;
    currentradius = 30;
    streakinfo.mapcircle = spawnquestcircle( "NovaGas_Br", streakinfo.impact_location[ 0 ], streakinfo.impact_location[ 1 ], currentradius, self );
    streakinfo.mapcircle show();
    deltaradius = level.bunker_buster.gas_radius - currentradius;
    level thread function_218109a24320109f( streakinfo, &game_utility::function_d46d8731ed9d281, currentradius, deltaradius, 1.25 );
    wait 0.75;
    
    if ( isdefined( missile ) )
    {
        missile delete();
    }
    
    utility::callsharedfunc( "bunker_buster", #"missile_gas_volume", streakinfo.impact_location + ( 0, 0, 128 ), streakinfo.impact_location - ( 0, 0, streakinfo.override_travel_dist ?? level.bunker_buster.travel_distance ), level.bunker_buster.gas_radius, streakinfo );
    thread function_7cfa0c408b9f741f( 3, streakinfo );
    level thread missile_spawn_sfx( streakinfo );
    streakinfo.mapcircle thread utility::delete_after_delay( level.bunker_buster.gas_lifetime );
    level thread function_80c6b1985742de93( level.bunker_buster.gas_lifetime, streakinfo );
}

// Namespace bunker_buster
// Params 2
// Checksum 0x620bc3f0, Offset: 0x18a5
// Size: 0x36
function function_80c6b1985742de93( delay, streak_info )
{
    level endon( #"game_ended" );
    wait delay;
    thread function_a64c03b1be1f21cc( streak_info );
    thread function_d8c74cc5f82dd371( streak_info );
}

// Namespace bunker_buster
// Params 2, eflags: 0x4
// Checksum 0x7aafaf9e, Offset: 0x18e3
// Size: 0x135
function private get_explosion_victims( streakinfo, owner )
{
    affected_players = utility::callsharedfunc( "bunker_buster", #"hash_640202cd3ccf3fc5", streakinfo.impact_location, streakinfo.override_travel_dist ?? level.bunker_buster.travel_distance );
    victims = [];
    
    foreach ( player in affected_players )
    {
        if ( player != owner && player.team == owner.team )
        {
            continue;
        }
        
        if ( distance2d( player.origin, streakinfo.impact_location ) > level.bunker_buster.explosion_radius )
        {
            continue;
        }
        
        victims[ victims.size ] = player;
    }
    
    return victims;
}

// Namespace bunker_buster
// Params 2, eflags: 0x4
// Checksum 0x3b5e729c, Offset: 0x1a21
// Size: 0x48
function private function_7cfa0c408b9f741f( delay, streak_info )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait delay;
    utility::callsharedfunc( "bunker_buster", #"dialog_hits", self, streak_info );
}

// Namespace bunker_buster
// Params 6
// Checksum 0x5c8abb53, Offset: 0x1a71
// Size: 0x2a5
function missile_spawn( streakbundle, origin, offset = 4096, velocity = ( 0, 0, 0 ), exp_time = 6, prev_missile )
{
    bombing_info = { #initvelocity:velocity, #sourcepos:origin + ( 0, 0, offset ), #goalpos:origin };
    missile = magicgrenademanual( "bunker_buster_proj_jup_mp", bombing_info.sourcepos, bombing_info.initvelocity, exp_time );
    
    if ( !isdefined( prev_missile ) )
    {
        missile setscriptablepartstate( "trail", "active", 0 );
    }
    else
    {
        missile setscriptablepartstate( "trail", "continue", 0 );
    }
    
    if ( !isdefined( prev_missile ) )
    {
        missile setscriptablepartstate( "launch", "active", 0 );
        missile thread function_61470e88ae1b28d1( self );
    }
    
    if ( isdefined( prev_missile ) )
    {
        minimapid = prev_missile.minimapid;
        streakinfo = prev_missile.streakinfo;
        prev_missile delete();
    }
    else
    {
        minimapid = undefined;
        
        if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
        {
            minimapid = missile [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( "hud_icon_minimap_killstreak_bunker_buster", self.team, undefined, 1, 1 );
        }
        
        if ( level.streakglobals.var_3feb5f5305e6fe83 && isdefined( minimapid ) )
        {
            function_46a5a0ae8a411d8d( minimapid, streakbundle.var_77216bac95c39355 );
            function_a9992b78cd05e28b( minimapid, streakbundle.var_4d7d4b6afc661107 );
            function_82408b23a25468f3( minimapid, origin );
        }
    }
    
    missile.minimapid = minimapid;
    missile.owner = self;
    
    if ( isdefined( streakinfo ) )
    {
        missile.streakinfo = streakinfo;
        missile.streakname = streakinfo.streakname;
    }
    
    missile setentityowner( self );
    missile setotherent( self );
    missile forcenetfieldhighlod( 1 );
    missile thread missile_watch_owner();
    missile thread function_bff692c8d5114633();
    missile.empapplycallback = &missile_empapplied;
    
    if ( utility::issharedfuncdefined( #"emp", #"setemp_applied_callback" ) )
    {
        missile [[ utility::getsharedfunc( #"emp", #"setemp_applied_callback" ) ]]( &missile_empapplied );
    }
    
    return missile;
}

// Namespace bunker_buster
// Params 1
// Checksum 0x79db13f7, Offset: 0x1d1f
// Size: 0x69
function function_61470e88ae1b28d1( owner )
{
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_244bebf6d2833440" );
    self endon( #"missile_stuck" );
    self endon( #"missile_water_impact" );
    wait 1;
    function_9221089e695f3198( 1 );
    self setmissileminimapvisible( 1 );
}

// Namespace bunker_buster
// Params 0
// Checksum 0x6a0d3b51, Offset: 0x1d90
// Size: 0x162
function missile_explosion_calculation()
{
    streakinfo = self.streakinfo;
    damagemodifier = streakinfo.trophy_blocked ? level.bunker_buster.trophy_damage_mod : 1;
    
    if ( isdefined( streakinfo.explosion_victims ) )
    {
        foreach ( player in streakinfo.explosion_victims )
        {
            v_dist = abs( self.origin[ 2 ] - player.origin[ 2 ] );
            travel_time = mapfloat( 0, level.bunker_buster.travel_distance, 0, 0.5, v_dist );
            thread missile_player_damage( player, travel_time, damagemodifier );
        }
    }
    
    earthquakeadvanced( 0.5, 0.3, 0.2, 1.5, self.origin, level.bunker_buster.explosion_radius, 1000, 5000 );
}

// Namespace bunker_buster
// Params 3
// Checksum 0x5dddbd34, Offset: 0x1efa
// Size: 0xed
function missile_player_damage( player, travel_time, var_220f5bea680d39e5 )
{
    player endon( #"disconnect" );
    
    if ( travel_time >= level.framedurationseconds )
    {
        wait travel_time;
    }
    
    h_dist = distance2d( player.origin, self.origin );
    damage = int( mapfloat( 0, level.bunker_buster.explosion_radius, level.bunker_buster.explosion_max_damage, level.bunker_buster.explosion_min_damage, h_dist ) * var_220f5bea680d39e5 );
    player dodamage( damage, self.origin, self.owner, self, "MOD_EXPLOSIVE", level.bunker_buster.projectile_weapon, "none", undefined, 1 );
}

// Namespace bunker_buster
// Params 0
// Checksum 0xaa6c019a, Offset: 0x1fef
// Size: 0x98
function function_bff692c8d5114633()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"missile_stuck" );
    self endon( #"missile_water_impact" );
    self waittill( #"hash_244bebf6d2833440" );
    self setscriptablepartstate( "explode", "explode_air" );
    self setscriptablepartstate( "visibility", "hide" );
    waitframe();
    missile_explosion_calculation();
    function_9221089e695f3198();
    strike_end( self.streakinfo );
    self delete();
}

// Namespace bunker_buster
// Params 0
// Checksum 0x46824deb, Offset: 0x208f
// Size: 0x4c
function missile_watch_owner()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.owner waittill( #"disconnect" );
    function_9221089e695f3198();
    strike_end( self.streakinfo );
    self delete();
}

// Namespace bunker_buster
// Params 0
// Checksum 0x5bc131b0, Offset: 0x20e3
// Size: 0x72
function missile_marker_objective()
{
    self endon( #"death" );
    self setscriptablepartstate( "target", "on", 0 );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 6 );
    
    if ( isdefined( self ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.objidnum );
        }
        
        self delete();
    }
}

// Namespace bunker_buster
// Params 1
// Checksum 0xd8d06ab4, Offset: 0x215d
// Size: 0x77
function function_9221089e695f3198( obj_only = 0 )
{
    if ( !obj_only )
    {
        self setmissileminimapvisible( 0 );
    }
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
}

// Namespace bunker_buster
// Params 2
// Checksum 0xd6f4e747, Offset: 0x21dc
// Size: 0x2fc
function function_dd3af078950c0d15( player, streakbundle )
{
    missile = self;
    hit = 0;
    
    while ( true )
    {
        impact_info = missile killstreak_shared::killstreak_waittillexplode( "missile_stuck", "missile_water_impact", "death", "trophy_blocked" );
        stuck_to = undefined;
        
        if ( isdefined( impact_info ) )
        {
            if ( impact_info.msg == "missile_stuck" )
            {
                stuck_to = impact_info.param1;
            }
            else if ( impact_info.msg == "missile_water_impact" )
            {
                missile.water_impact = 1;
            }
            else if ( impact_info.msg == "trophy_blocked" )
            {
                missile.trophy_blocked = 1;
            }
            else if ( impact_info.msg == "death" )
            {
                break;
            }
        }
        
        if ( !isdefined( stuck_to ) && isdefined( impact_info.param5 ) )
        {
            scr_closest_redeploy_drone = undefined;
            
            if ( utility::issharedfuncdefined( #"redeploy_drone", #"get_closest_redeploy_drone" ) )
            {
                scr_closest_redeploy_drone = [[ utility::getsharedfunc( #"redeploy_drone", #"get_closest_redeploy_drone" ) ]]( impact_info.param5 );
            }
            
            if ( isdefined( scr_closest_redeploy_drone ) && distancesquared( impact_info.param5, scr_closest_redeploy_drone.origin ) < squared( 100 ) )
            {
                if ( !scr_closest_redeploy_drone.b_skip_repopulate )
                {
                    if ( utility::issharedfuncdefined( #"redeploy_drone", #"redeploy_drone_repopulation_watcher" ) )
                    {
                        level thread [[ utility::getsharedfunc( #"redeploy_drone", #"redeploy_drone_repopulation_watcher" ) ]]( scr_closest_redeploy_drone );
                    }
                }
                
                if ( utility::issharedfuncdefined( #"redeploy_drone", #"redeploy_drone_destroyed" ) )
                {
                    scr_closest_redeploy_drone [[ utility::getsharedfunc( #"redeploy_drone", #"redeploy_drone_destroyed" ) ]]( player, undefined, 1 );
                }
                
                hit = 1;
                missile = player missile_spawn( streakbundle, missile.origin, 0, ( 0, 0, -3000 ), undefined, missile );
                continue;
            }
        }
        
        if ( isdefined( stuck_to ) && stuck_to.classname == "script_vehicle" && stuck_to getcandamage() && !stuck_to.var_dc6529e31dd31da1 )
        {
            data = spawnstruct();
            data.inflictor = self;
            data.objweapon = undefined;
            data.meansofdeath = "MOD_CRUSH";
            data.attacker = player;
            stuck_to thread vehicle::explode( data, 1 );
            hit = 1;
            missile = player missile_spawn( streakbundle, missile.origin, 0, ( 0, 0, -3000 ), undefined, missile );
            continue;
        }
        
        break;
    }
    
    return [ stuck_to, missile, hit ];
}

// Namespace bunker_buster
// Params 1
// Checksum 0x1cc74d97, Offset: 0x24e1
// Size: 0x19b
function missile_spawn_sfx( streakinfo )
{
    level endon( #"game_ended" );
    scriptables = [];
    
    if ( !streakinfo.water_impact )
    {
        dir = ( 0, 0, -1 );
        base_offset = ( streakinfo.override_travel_dist ?? level.bunker_buster.travel_distance ) / 2 * dir;
        height_offset = base_offset * 0.5;
        
        for ( i = 0; i < 2 ; i++ )
        {
            s = spawnscriptable( "ks_bunker_buster_gas_sfx", streakinfo.impact_location + base_offset * i + height_offset );
            s setscriptablepartstate( "ks_bunker_buster_gas_sfx", "on" );
            scriptables[ scriptables.size ] = s;
        }
    }
    else
    {
        s = spawnscriptable( "ks_bunker_buster_gas_sfx", streakinfo.impact_location );
        s setscriptablepartstate( "ks_bunker_buster_gas_sfx", "on" );
        scriptables[ scriptables.size ] = s;
    }
    
    wait level.bunker_buster.gas_lifetime + 1;
    
    foreach ( scriptable in scriptables )
    {
        scriptable freescriptable();
    }
}

// Namespace bunker_buster
// Params 1
// Checksum 0xc2100629, Offset: 0x2684
// Size: 0x38
function missile_empapplied( data )
{
    if ( isdefined( self ) && isdefined( self.owner ) && !self.exploded )
    {
        self notify( #"hash_244bebf6d2833440" );
    }
}

// Namespace bunker_buster
// Params 1
// Checksum 0x9a97fa46, Offset: 0x26c4
// Size: 0xbf
function function_a64c03b1be1f21cc( streak_info )
{
    eventparams = [ "pos_x", streak_info.impact_location[ 0 ], "pos_y", streak_info.impact_location[ 1 ], "pos_z", streak_info.impact_location[ 2 ], "impact_time", streak_info.impact_time, "explosion_victims", streak_info.explosion_victims.size, "gas_victims", streak_info.gas_victims.size ];
    dlog_recordevent( "dlog_event_br_bunker_buster_complete", eventparams );
}

// Namespace bunker_buster
// Params 1
// Checksum 0xfc7494ee, Offset: 0x278b
// Size: 0x56
function function_d8c74cc5f82dd371( streak_info )
{
    if ( !isdefined( streak_info.owner ) )
    {
        return;
    }
    
    victims = streak_info.explosion_victims;
    
    if ( victims.size > 0 )
    {
        challenges::function_37e945722d6497f3( streak_info.owner, "br_decay_ks_strike_hit", victims.size );
    }
}

// Namespace bunker_buster
// Params 5, eflags: 0x4
// Checksum 0x2dfa1c1c, Offset: 0x27e9
// Size: 0x9d
function private function_218109a24320109f( object, func, currentparam, deltaparam, seconds )
{
    level endon( #"game_ended" );
    starttime = gettime();
    seconds *= 1000;
    
    while ( true )
    {
        elapsedtime = gettime() - starttime;
        
        if ( elapsedtime >= seconds )
        {
            break;
        }
        
        scale = elapsedtime / seconds;
        newparam = currentparam + deltaparam * scale;
        object [[ func ]]( newparam );
        waitframe();
    }
}

// Namespace bunker_buster
// Params 1, eflags: 0x4
// Checksum 0x16994199, Offset: 0x288e
// Size: 0x88
function private function_b987c23db3b090ab( markerpos )
{
    startpos = markerpos + ( 0, 0, 5000 );
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 0 );
    droptrace = trace::ray_trace( startpos, markerpos, undefined, contentoverride );
    
    if ( droptrace[ "hittype" ] != "hittype_none" && isdefined( droptrace[ "position" ] ) )
    {
        return ( markerpos[ 0 ], markerpos[ 1 ], droptrace[ "position" ][ 2 ] );
    }
    
    return markerpos;
}

// Namespace bunker_buster
// Params 1, eflags: 0x4
// Checksum 0x3e807a6, Offset: 0x291f
// Size: 0xa8
function private function_707635fca9cd562b( players )
{
    if ( !isdefined( players ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( player.team == self.team )
        {
            continue;
        }
        
        thread points::doscoreevent( #"hash_6daefc4cdcda801f" );
    }
}

/#

    // Namespace bunker_buster
    // Params 0
    // Checksum 0xca7d2ac4, Offset: 0x29cf
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace bunker_buster
    // Params 0
    // Checksum 0x6761db88, Offset: 0x29dc
    // Size: 0xd, Type: dev
    function debug_init()
    {
        level thread function_6c025e2cb9e2dd26();
    }

    // Namespace bunker_buster
    // Params 0
    // Checksum 0x79c38910, Offset: 0x29f1
    // Size: 0x44, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x81>" );
        devgui::add_devgui_func( "<dev string:xab>", "<dev string:xb7>", &function_8aa9bb3168ebaa46 );
        devgui::add_devgui_func( "<dev string:xd1>", "<dev string:xe1>", &debug_update_settings );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace bunker_buster
    // Params 0
    // Checksum 0xc6092fc3, Offset: 0x2a3d
    // Size: 0xaa, Type: dev
    function function_8aa9bb3168ebaa46()
    {
        v_pos = ( 3673, 7719, 5000 );
        heli = sortbydistance( level.vehicle.instances[ "<dev string:xff>" ], v_pos )[ 0 ];
        
        if ( heli === level.research_vessel.heli )
        {
            heli = sortbydistance( level.vehicle.instances[ "<dev string:xff>" ], v_pos )[ 1 ];
        }
        
        while ( isalive( heli ) )
        {
            heli vehicle_teleport( v_pos, ( 0, 0, 0 ), 1 );
            waitframe();
        }
    }

    // Namespace bunker_buster
    // Params 0
    // Checksum 0x7c5acda4, Offset: 0x2aef
    // Size: 0xd, Type: dev
    function debug_update_settings()
    {
        level init_vars();
    }

#/
