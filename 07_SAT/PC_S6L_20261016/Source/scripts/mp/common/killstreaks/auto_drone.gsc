// scripts\mp\common\killstreaks\auto_drone.gsc  (hash_1c6bb6c699d4cbdc.gscc) (size: 17088 Bytes / 0x42c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1871da8 (4052164008)
// size ...... 17088 (0x42c0)
// includes .. 11  (offset: 0x3ec0)
// strings ... 49  (offset: 0x3f18)
// dev strs .. 6   (offset: 0x4278)
// exports ... 37  (offset: 0x2c60)
// cseg ...... 0x371 + 0x28ef (0x2c60)
// imports ... 100 (offset: 0x3228)
// animtree1 . 0   (offset: 0x42c0)
// animtree2 . 0   (offset: 0x42c0)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\hostmigration;

#namespace auto_drone;

// Namespace auto_drone
// Params 0
// Checksum 0x2aee259, Offset: 0x38f
// Size: 0x79
function init()
{
    if ( utility::issharedfuncdefined( "auto_drone", #"init" ) )
    {
        [[ utility::getsharedfunc( "auto_drone", #"init" ) ]]();
    }
    
    /#
        setdevdvarifuninitialized( @"hash_30dee5c8d013379b", 0 );
        setdevdvarifuninitialized( @"hash_62b493e13a7a2273", 0 );
    #/
    
    level function_f256ea7bb93ee165();
    level initactionsets();
    level initanims();
    level initvo();
    level initfx();
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x2c20e1b2, Offset: 0x410
// Size: 0x50, Type: bool
function private weapongivenautodrone( streakinfo )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_bc456c37cf700436" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"hash_bc456c37cf700436" ) ]]( 0, 1, "long_arrow", undefined, streakinfo );
    }
    
    return true;
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0x1c278573, Offset: 0x469
// Size: 0x94
function private function_f256ea7bb93ee165()
{
    level.autodrones = [];
    level.var_cf5b224ebb26fc5 = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.var_666831fe79dbde6e[ teamname ] = 0;
    }
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xe2c1f8f7, Offset: 0x505
// Size: 0x2
function private initactionsets()
{
    
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0x4b1bb59f, Offset: 0x50f
// Size: 0x2
function private initanims()
{
    
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xe4f2695, Offset: 0x519
// Size: 0x5f
function private initvo()
{
    game[ "dialog" ][ "auto_drone" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "auto_drone" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "auto_drone" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0x986329f1, Offset: 0x580
// Size: 0x2
function private initfx()
{
    
}

// Namespace auto_drone
// Params 0
// Checksum 0x70bc82af, Offset: 0x58a
// Size: 0x22
function tryuseautodrone()
{
    streakinfo = killstreak_utility::createstreakinfo( "auto_drone", self );
    return function_948ef213e45dfc60( streakinfo );
}

// Namespace auto_drone
// Params 5
// Checksum 0x97fafde9, Offset: 0x5b5
// Size: 0x9c
function function_cf4745ec4a7b893b( player, locationoverride, anglesoverride, flyheightoverride, speedoverride )
{
    streakinfo = killstreak_utility::createstreakinfo( "auto_drone", player );
    streakinfo.var_3343592587469cb5 = [];
    streakinfo.var_3343592587469cb5[ 0 ] = locationoverride;
    streakinfo.var_3343592587469cb5[ 1 ] = anglesoverride;
    streakinfo.flyheightoverride = flyheightoverride;
    streakinfo.speedoverride = speedoverride;
    return player function_948ef213e45dfc60( streakinfo );
}

// Namespace auto_drone
// Params 1
// Checksum 0x38e4d5e, Offset: 0x65a
// Size: 0x251
function function_948ef213e45dfc60( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "auto_drone", bundle.auto_drone_weapon ?? "auto_drone_proj_mp", #"large" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "auto_drone", bundle.projectileweapon ?? "auto_drone_proj_mp", #"large" );
    bundleid = function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb );
    setomnvar( "auto_drone_xhash_asset_idx", bundleid );
    team = self.team;
    level.var_cf5b224ebb26fc5++;
    var_d8cdb986e5779f97 = 1;
    
    if ( game_utility::islargemap() )
    {
        var_d8cdb986e5779f97 = 2;
    }
    
    if ( level.autodrones.size >= var_d8cdb986e5779f97 || level.autodrones.size + level.var_cf5b224ebb26fc5 > var_d8cdb986e5779f97 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        level.var_cf5b224ebb26fc5--;
        return 0;
    }
    
    if ( game_utility::islargemap() && level.teambased )
    {
        var_21bc9482d3131c3d = 1;
        level.var_666831fe79dbde6e[ team ]++;
        
        if ( killstreak_utility::getnumactivekillstreakperteam( team, level.autodrones ) + level.var_666831fe79dbde6e[ team ] > var_21bc9482d3131c3d )
        {
            level.var_cf5b224ebb26fc5--;
            level.var_666831fe79dbde6e[ team ]--;
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
            }
            
            return 0;
        }
    }
    
    result = function_a57bf427184475e1( streakinfo );
    level.var_cf5b224ebb26fc5--;
    
    if ( game_utility::islargemap() && level.teambased )
    {
        level.var_666831fe79dbde6e[ team ]--;
    }
    
    return result;
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0xcb2b53ab, Offset: 0x8b4
// Size: 0x2c7, Type: bool
function private function_a57bf427184475e1( streakinfo )
{
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    deployresult = 1;
    
    if ( !isdefined( streakinfo.var_3343592587469cb5 ) )
    {
        deployweaponobj = makeweapon( bundle.deployweaponname ?? "ks_remote_map_mp" );
        deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 1, &weapongivenautodrone );
    }
    
    if ( !deployresult )
    {
        return false;
    }
    
    mappointinfo = undefined;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"getselectmappoint" ) )
    {
        if ( isdefined( streakinfo.var_3343592587469cb5 ) )
        {
            mappointinfo = [];
            mappointinfo[ 0 ] = {};
            mappointinfo[ 0 ].location = streakinfo.var_3343592587469cb5[ 0 ];
            mappointinfo[ 0 ].angles = streakinfo.var_3343592587469cb5[ 1 ];
            mappointinfo[ 0 ].string = "confirm_location";
        }
        else
        {
            mappointinfo = self [[ utility::getsharedfunc( #"killstreak", #"getselectmappoint" ) ]]( streakinfo, bundle.var_c5e42903dea26506 ?? 1, 1 );
        }
    }
    
    streakinfo.owner notify( #"killstreak_deploy_finished", streakinfo.streakname );
    
    if ( !isdefined( mappointinfo ) )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    level thread startuse( self, streakinfo, mappointinfo );
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "auto_drone" + "_use", #"use", 1, var_65934120c2efeb81 );
    utility::trycall( level.matchdata_logkillstreakevent, "auto_drone", self.origin );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "auto_drone", self );
    }
    
    killstreak_utility::function_e4f54128963e182( bundle.auto_drone_weapon ?? "auto_drone_proj_mp" );
    return true;
}

// Namespace auto_drone
// Params 3, eflags: 0x4
// Checksum 0xd8c9eeed, Offset: 0xb84
// Size: 0xf7
function private startuse( player, streakinfo, mappointinfo )
{
    level endon( #"game_ended" );
    player notify( #"auto_drone_used" );
    targetlocations = mappointinfo;
    
    for ( i = 0; i < targetlocations.size ; i++ )
    {
        autodrone = create( player, streakinfo, targetlocations[ i ], 1 );
        autodrone thread watchgameend();
        autodrone thread watchowner();
        autodrone thread function_e0793e6ee5c08cbb();
        autodrone thread function_74a247e1592e5c79();
        autodrone thread function_a701126c2d2b2503();
        autodrone thread handlecamerashake();
        
        if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
        {
            autodrone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", player );
        }
    }
}

// Namespace auto_drone
// Params 4, eflags: 0x4
// Checksum 0xc08787ee, Offset: 0xc83
// Size: 0xa2c
function private create( owner, streakinfo, targetlocationinfo, nonvehicle )
{
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    dronehalfdistance = 36000;
    droneflyheight = 3000;
    droneflyspeed = bundle.var_2528919c5e84502f ?? 200;
    
    if ( isdefined( streakinfo.speedoverride ) )
    {
        droneflyspeed = streakinfo.speedoverride;
    }
    
    var_ec286788755ec07a = 1500;
    var_2df14d15022f74fc = 0;
    
    if ( isdefined( heightent ) )
    {
        droneflyheight = heightent.origin[ 2 ] + 500;
    }
    
    var_66c94816813e719a = targetlocationinfo.location;
    
    /#
        var_99474b73dc3a5eab = getdvarint( @"hash_62b493e13a7a2273", 0 );
        var_66c94816813e719a += anglestoforward( owner.angles ) * var_99474b73dc3a5eab;
        var_2672c681761eb965 = getdvarint( @"hash_698613e6c8c52243", 0 );
        droneflyheight += var_2672c681761eb965;
    #/
    
    if ( isdefined( streakinfo.flyheightoverride ) )
    {
        droneflyheight = streakinfo.flyheightoverride;
    }
    
    strikedirection = ( 0, targetlocationinfo.angles, 0 );
    flightpath = airstrike::getflightpath( var_66c94816813e719a, strikedirection, dronehalfdistance, heightent, droneflyheight, droneflyspeed, var_ec286788755ec07a, streakinfo.streakname, var_2df14d15022f74fc );
    pathstart = flightpath[ "startPoint" ];
    pathgoal = flightpath[ "endPoint" ];
    droneangles = strikedirection;
    payload_distance = bundle.auto_drone_payload_distance ?? 500;
    autodrone = spawn( "script_model", pathstart );
    autodrone setmodel( bundle.auto_drone_model ?? "veh9_mil_air_stealth_bomber_mp" );
    autodrone.explosionsradius = bundle.auto_drone_explosion_radius ?? 500;
    autodrone.var_2afecf61a98a5d37 = bundle.var_a5004bc8de611c58 ?? 512;
    autodrone.var_2b21bd61a9b07d59 = bundle.var_2ba73dfc0c7f0379 ?? 200;
    autodrone.speed = droneflyspeed;
    autodrone.accel = 100;
    autodrone.angles = droneangles;
    autodrone.team = owner.team;
    autodrone.owner = owner;
    owner.var_e73f627a785541a2[ "auto_drone" ] = 0;
    autodrone.streakinfo = streakinfo;
    autodrone.streakname = streakinfo.streakname;
    autodrone.currentdamagestate = 0;
    autodrone.flyheight = droneflyheight;
    autodrone.pers[ "team" ] = autodrone.team;
    autodrone.flightdir = flightpath[ "directionAngles" ];
    autodrone.var_47a3d36f2571b9c7 = droneflyspeed * 17.6;
    autodrone.flightstartpos = pathstart;
    
    if ( isdefined( bundle.var_734cd2aa2fc1b8ff ) )
    {
        var_d9eca545329b9284 = dronehalfdistance * 2 - bundle.var_734cd2aa2fc1b8ff;
        autodrone.var_79e1765e6cb378a2 = pathstart + anglestoforward( autodrone.angles ) * var_d9eca545329b9284 * 0.5;
        autodrone.var_18662e6d4135c6d1 = pathgoal - anglestoforward( autodrone.angles ) * var_d9eca545329b9284 * 0.5;
    }
    else
    {
        autodrone.var_79e1765e6cb378a2 = pathstart + anglestoforward( autodrone.angles ) * int( dronehalfdistance * 0.67 );
        autodrone.var_18662e6d4135c6d1 = pathgoal - anglestoforward( autodrone.angles ) * int( dronehalfdistance * 0.67 );
    }
    
    autodrone.flightendpos = pathgoal;
    autodrone.var_8071667f98fecd4c = length( autodrone.var_79e1765e6cb378a2 - autodrone.var_18662e6d4135c6d1 );
    autodrone.flighttime = length( autodrone.flightstartpos - autodrone.flightendpos ) / autodrone.var_47a3d36f2571b9c7;
    autodrone.var_bd07f4530bf6de33 = length( autodrone.flightstartpos - autodrone.var_79e1765e6cb378a2 ) / autodrone.var_47a3d36f2571b9c7;
    autodrone.var_7f467d4dedc462bb = length( autodrone.flightstartpos - autodrone.var_18662e6d4135c6d1 ) / autodrone.var_47a3d36f2571b9c7;
    autodrone.var_cb4780560be1e374 = bundle.var_8d556b4be610d4ed ?? 3;
    autodrone.var_b75835295fe69f86 = payload_distance / autodrone.var_47a3d36f2571b9c7;
    autodrone.var_453db8d55ecf01d9 = int( autodrone.var_8071667f98fecd4c / payload_distance );
    
    if ( utility::issharedfuncdefined( #"auto_drone", #"attachxrays" ) )
    {
        autodrone = [[ utility::getsharedfunc( #"auto_drone", #"attachxrays" ) ]]( autodrone );
    }
    
    planedir = vectornormalize( anglestoforward( autodrone.angles ) );
    originoffset = ( bundle.var_15869b5e2c380579 ?? 0, bundle.var_15869a5e2c380346 ?? 0, bundle.var_1586995e2c380113 ?? 0 );
    killcament = spawn( "script_model", autodrone.origin - planedir * 1000 + originoffset );
    killcament linkto( autodrone, "tag_origin" );
    autodrone.killcament = killcament;
    autodrone.minimapid = autodrone killstreak_utility::function_99456b220fc6798e( streakinfo.streakname, "hud_icon_minimap_killstreak_drone_auto", bundle, "icon_medium", 1 );
    linewidth = bundle.var_dc664158de908ec3 ?? 1000;
    midpos = ( autodrone.var_79e1765e6cb378a2 + autodrone.var_18662e6d4135c6d1 ) / 2;
    minimapent = spawn( "script_model", ( midpos[ 0 ], midpos[ 1 ], linewidth ) );
    minimapent addyaw( vectortoyaw( autodrone.flightendpos - autodrone.flightstartpos ) );
    minimapent addpitch( 16 );
    minimapent setotherent( owner );
    autodrone.minimapent = minimapent;
    autodrone.firequeue = [];
    autodrone.firequeue[ "target_line_left" ] = [];
    autodrone.firequeue[ "target_line_right" ] = [];
    autodrone.fireents = [];
    autodrone.fireents[ "target_line_left" ] = [];
    autodrone.fireents[ "target_line_right" ] = [];
    
    /#
        debugtarget = getdvarint( @"hash_30dee5c8d013379b", 0 );
        
        if ( debugtarget )
        {
            level thread debug_utility::drawline( autodrone.flightstartpos, autodrone.flightendpos, autodrone.flighttime, ( 1, 1, 1 ) );
            level thread debug_utility::drawsphere( autodrone.flightstartpos, 50, autodrone.flighttime, ( 1, 0, 0 ) );
            level thread debug_utility::drawsphere( autodrone.flightendpos, 50, autodrone.flighttime, ( 0, 1, 0 ) );
            level thread debug_utility::drawsphere( autodrone.var_79e1765e6cb378a2, 100, autodrone.flighttime, ( 0, 1, 1 ) );
            level thread debug_utility::drawsphere( autodrone.var_18662e6d4135c6d1, 100, autodrone.flighttime, ( 0, 1, 1 ) );
            level thread debug_utility::drawsphere( var_66c94816813e719a, 100, autodrone.flighttime, ( 1, 0, 1 ) );
            forwarddebug = anglestoforward( autodrone.angles );
            forwarddebugpos = pathstart + forwarddebug * 200;
            level thread debug_utility::drawline( autodrone.flightstartpos, forwarddebugpos, autodrone.flighttime, ( 1, 0, 0 ) );
        }
    #/
    
    autodrone.initialtargetlocation = targetlocationinfo.location;
    autodrone setscriptablepartstate( "contrails", "on", 0 );
    autodrone setscriptablepartstate( "lights", "on", 0 );
    autodrone setscriptablepartstate( "approach", "on", 0 );
    level.autodrones[ level.autodrones.size ] = autodrone;
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) && utility::issharedfuncdefined( #"spawn", #"getcodehandlefromscripthandle" ) )
    {
        influencer = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"killstreak_auto_drone", var_66c94816813e719a, autodrone.team, autodrone.owner );
        codeid = [[ utility::getsharedfunc( #"spawn", #"getcodehandlefromscripthandle" ) ]]( influencer );
        direction = anglestoforward( strikedirection );
        halflength = function_2478f52db476d256( codeid ) * 0.5;
        startpoint = var_66c94816813e719a + direction * -1 * halflength;
        spawninfluencersetorigin( codeid, startpoint );
        function_209b9b14037cef43( codeid, direction );
    }
    
    return autodrone;
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x37a63b44, Offset: 0x16b8
// Size: 0x29a
function private cleanup( wasdestroyed )
{
    self notify( #"cleaning_up" );
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
    
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    
    if ( isdefined( self.owner ) )
    {
        self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    
    if ( isdefined( self.fireents ) )
    {
        /#
            var_c80d19fa9c9c6398 = self.fireents[ "<dev string:x24>" ].size + self.fireents[ "<dev string:x35>" ].size;
            iprintlnbold( "<dev string:x47>" + var_c80d19fa9c9c6398 + "<dev string:x5f>" );
        #/
        
        foreach ( ent in self.fireents[ "target_line_left" ] )
        {
            if ( isdefined( ent ) )
            {
                ent delete();
            }
        }
        
        foreach ( ent in self.fireents[ "target_line_right" ] )
        {
            if ( isdefined( ent ) )
            {
                ent delete();
            }
        }
    }
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    thread function_462141d248cd38a0( 3 );
    
    if ( isdefined( self.minimapent ) )
    {
        self.minimapent delete();
    }
    
    level.autodrones = arrayremove( level.autodrones, self );
    self delete();
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0x94a67c59, Offset: 0x195a
// Size: 0x7a
function private watchgameend()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xcdd3ab57, Offset: 0x19dc
// Size: 0xaa
function private watchowner()
{
    self endon( #"death" );
    self endon( #"cleaning_up" );
    self.owner utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self.reachedgoal = 1;
    
    if ( isdefined( self.flyfxent ) )
    {
        self.flyfxent delete();
    }
    
    self setscriptablepartstate( "release", "neutral", 0 );
    self setscriptablepartstate( "contrails", "off", 0 );
    self setscriptablepartstate( "lights", "off", 0 );
    self notify( #"hash_3e2fc3bd2952edca" );
    self notify( #"hash_fe360df1ecb78997" );
}

// Namespace auto_drone
// Params 4
// Checksum 0x730d520b, Offset: 0x1a8e
// Size: 0x184
function handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    missiletarget endon( #"death" );
    missiletarget endon( #"crashing" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
            {
                [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( missiletarget );
            }
            
            if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
            {
                missiletarget thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( "jet_flares", fxtagoverride );
            }
            
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xa84b315f, Offset: 0x1c1a
// Size: 0x1bf
function private function_a701126c2d2b2503()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    droneowner = self.owner;
    droneowner endon( #"disconnect" );
    var_a229c5f32fed7bef = self.flighttime;
    var_e72ce1c6e05c9902 = self.var_7f467d4dedc462bb;
    var_2807d12f3316a4f8 = var_a229c5f32fed7bef - var_e72ce1c6e05c9902;
    plane = self;
    var_1cc3597535367267 = bundle.var_a7b209edb355ecb2 ?? "ks_auto_drone_mp";
    planestartpos = self.flightstartpos;
    var_aa3618dd78b3981d = self.angles;
    var_9daf341a437915da = 0.05;
    var_9de01f1a43af76e8 = self.var_bd07f4530bf6de33;
    var_9ac627c2a5aa0173 = var_e72ce1c6e05c9902;
    var_4cb38e466d08f81b = var_a229c5f32fed7bef;
    var_df19f52de73ec0ec = self.var_bd07f4530bf6de33 - self.var_cb4780560be1e374 + 3;
    var_df19f52de73ec0ec = max( var_df19f52de73ec0ec, 0 );
    self.flyfxent = level airstrike::airstrike_playflyfx( plane, var_1cc3597535367267, planestartpos, var_aa3618dd78b3981d, var_9daf341a437915da, var_9de01f1a43af76e8, var_9ac627c2a5aa0173, var_4cb38e466d08f81b, self.streakinfo );
    self moveto( self.flightendpos, var_a229c5f32fed7bef );
    
    if ( self.var_cb4780560be1e374 > 0 )
    {
        thread function_c66f3c4ccaa8298e( var_df19f52de73ec0ec );
    }
    
    wait var_e72ce1c6e05c9902;
    self.isleaving = 1;
    thread function_462141d248cd38a0( 3 );
    wait var_2807d12f3316a4f8;
    self hide();
    self.reachedgoal = 1;
    self notify( #"hash_3e2fc3bd2952edca" );
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xa48340b8, Offset: 0x1de1
// Size: 0xd8
function private handlecamerashake()
{
    self endon( #"death" );
    self endon( #"hash_3e2fc3bd2952edca" );
    level endon( #"game_ended" );
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    
    while ( true )
    {
        earthquakeadvanced( bundle.var_580057de9daf7acc ?? 0.15, bundle.var_58245bde9dd7fe50 ?? 0.075, bundle.var_582465de9dd8144e ?? 0.0075, bundle.auto_drone_duration ?? 0.05, self.origin, bundle.var_2c83a86ce9075816 ?? 10000, bundle.var_d0245639c2a9a20a ?? 15000, bundle.var_c8a0002369369e78 ?? 50000 );
        wait 0.05;
    }
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xa98025d5, Offset: 0x1ec1
// Size: 0xb6
function private function_e0793e6ee5c08cbb()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self.var_47c5d136c04a6152 = 0;
    childthread watchkills();
    childthread function_bb9eb9e6f01758e3();
    self waittill( #"hash_fe360df1ecb78997" );
    hostmigration::waitlongdurationwithpause( 1 );
    
    if ( self.var_47c5d136c04a6152 >= 1 )
    {
        killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "auto_drone" + "_hit_target", #"hit" );
        return;
    }
    
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "auto_drone" + "_miss_target", #"miss" );
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xb8a0148f, Offset: 0x1f7f
// Size: 0x4a
function private watchkills()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_kill_buffered", recentkills, var_95795539e2a8343 );
        
        if ( iskillstreakweapon( var_95795539e2a8343 ) )
        {
            self.var_47c5d136c04a6152++;
        }
    }
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0x62c6e25a, Offset: 0x1fd1
// Size: 0x4a
function private function_bb9eb9e6f01758e3()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_agent_kill_buffered", recentkills, var_bda53394c108f2e );
        
        if ( iskillstreakweapon( var_bda53394c108f2e ) )
        {
            self.var_47c5d136c04a6152++;
        }
    }
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x21992ee0, Offset: 0x2023
// Size: 0x43, Type: bool
function private iskillstreakweapon( weaponname )
{
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    return isstring( weaponname ) && weaponname == ( bundle.auto_drone_weapon ?? "auto_drone_proj_mp" );
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xc2ee088f, Offset: 0x206f
// Size: 0x2b7
function private function_74a247e1592e5c79()
{
    self endon( #"death" );
    self endon( #"hash_fe360df1ecb78997" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    thread function_b8e30897b7f90caf();
    self setscriptablepartstate( "approach", "off", 0 );
    
    if ( !self.owner.ksempd )
    {
        attackdelay = self.var_bd07f4530bf6de33;
        wait attackdelay;
        self setscriptablepartstate( "control_bomb_deploy", "bomb_open", 1 );
        self setscriptablepartstate( "flyby", "on", 0 );
        
        if ( !self.owner.ksempd )
        {
            self setscriptablepartstate( "release", "active", 0 );
            childthread function_a74495081346e793( "target_line_left" );
            childthread function_a74495081346e793( "target_line_right" );
            contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 0, 0, 0 );
            launchside = "none";
            explodeindex = 1;
            launchpos = self.origin - ( 0, 0, 100 );
            launchangles = self.angles;
            planeforward = anglestoforward( launchangles );
            bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
            
            for ( i = 0; i < self.var_453db8d55ecf01d9 ; i++ )
            {
                for ( j = 0; j < 2 ; j++ )
                {
                    if ( j == 1 )
                    {
                        launchside = "target_line_right";
                    }
                    else
                    {
                        launchside = "target_line_left";
                    }
                    
                    targetpos = function_fce704d13f6e1abb( launchside, contentoverride, launchpos );
                    
                    if ( isdefined( bundle.var_60195d2098b79b55 ) )
                    {
                        maxvariance = bundle.var_60195d2098b79b55;
                        var_c44d367e13554c0d = randomintrange( maxvariance * -1, maxvariance );
                        targetpos += planeforward * var_c44d367e13554c0d;
                    }
                    
                    if ( isdefined( targetpos ) )
                    {
                        thread function_6264c29f32cc516c( launchside, targetpos, explodeindex );
                        explodeindex++;
                        
                        if ( explodeindex > 25 )
                        {
                            explodeindex = 1;
                        }
                    }
                }
                
                wait self.var_b75835295fe69f86;
                launchpos += anglestoforward( launchangles ) * ( bundle.auto_drone_payload_distance ?? 500 );
            }
            
            self setscriptablepartstate( "release", "neutral", 0 );
            waitforscriptables();
        }
        
        self setscriptablepartstate( "control_bomb_deploy", "bomb_closed", 1 );
        self setscriptablepartstate( "flyby", "off", 0 );
    }
    
    self notify( #"hash_fe360df1ecb78997" );
}

// Namespace auto_drone
// Params 3, eflags: 0x4
// Checksum 0xa269463f, Offset: 0x232e
// Size: 0x16a
function private function_fce704d13f6e1abb( launchside, contentoverride, launchorigin = self.origin )
{
    launchangles = self.angles;
    launchcenter = undefined;
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    target_offset = bundle.auto_drone_target_offset ?? 300;
    
    switch ( launchside )
    {
        case #"hash_ac43add84a7bdc09":
            launchcenter = launchorigin - anglestoright( launchangles ) * target_offset;
            break;
        case #"hash_fedc29c8476c33aa":
            launchcenter = launchorigin + anglestoright( launchangles ) * target_offset;
            break;
        default:
            launchcenter = launchorigin;
            break;
    }
    
    if ( isdefined( launchcenter ) )
    {
        launchpos = function_f0d55f18f00a71d8( launchcenter, bundle.auto_drone_random_offset ?? 300 );
        bombtracestart = launchpos;
        bombtraceend = launchpos - ( 0, 0, 50000 );
        bombtrace = trace::ray_trace( bombtracestart, bombtraceend, undefined, contentoverride );
        bombexplodepos = undefined;
        
        if ( isdefined( bombtrace[ "position" ] ) )
        {
            bombexplodepos = bombtrace[ "position" ] + ( 0, 0, 10 );
        }
        
        return bombexplodepos;
    }
}

// Namespace auto_drone
// Params 2, eflags: 0x4
// Checksum 0xc5aa6083, Offset: 0x24a1
// Size: 0x86
function private function_f0d55f18f00a71d8( launchcenter, launchradius )
{
    randdist = randomint( launchradius );
    randangle = randomint( 360 );
    x = launchcenter[ 0 ] + randdist * cos( randangle );
    y = launchcenter[ 1 ] + randdist * sin( randangle );
    z = launchcenter[ 2 ];
    point = ( x, y, z );
    return point;
}

// Namespace auto_drone
// Params 3, eflags: 0x4
// Checksum 0x6a8b4e27, Offset: 0x2530
// Size: 0x33
function private function_6264c29f32cc516c( launchside, targetlocation, explodeindex )
{
    function_fcaa40d9a4dfa68b( launchside, explodeindex, targetlocation, 1, 3 );
}

// Namespace auto_drone
// Params 5, eflags: 0x4
// Checksum 0x263c597c, Offset: 0x256b
// Size: 0xab
function private function_fcaa40d9a4dfa68b( firetype, fireindex, firelocation, fireduration, startdelayoffset = 0 )
{
    var_42ee4adf490ef37c = spawnstruct();
    var_42ee4adf490ef37c.scriptablepart = "explode_" + fireindex;
    var_42ee4adf490ef37c.location = firelocation;
    var_42ee4adf490ef37c.duration = fireduration;
    var_42ee4adf490ef37c.starttime = gettime() + startdelayoffset * 1000;
    self.firequeue[ firetype ][ self.firequeue[ firetype ].size ] = var_42ee4adf490ef37c;
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x57a62e1e, Offset: 0x261e
// Size: 0x18b
function private function_a74495081346e793( firetype )
{
    for ( currentindex = 0; true ; currentindex++ )
    {
        if ( self.firequeue[ firetype ].size < currentindex + 1 )
        {
            waitframe();
            continue;
        }
        
        fireinfo = self.firequeue[ firetype ][ currentindex ];
        firepart = fireinfo.scriptablepart;
        firelocation = fireinfo.location;
        fireduration = fireinfo.duration;
        firestarttime = fireinfo.starttime;
        
        while ( gettime() < firestarttime )
        {
            waitframe();
        }
        
        fireent = function_a701d167a901b81b( firetype );
        
        if ( !isdefined( fireent ) )
        {
            /#
                iprintlnbold( "<dev string:x6c>" + firetype + "<dev string:xa9>" );
            #/
            
            waitframe();
            continue;
        }
        
        fireent.inuse = 1;
        fireent.origin = firelocation;
        
        /#
            debugtarget = getdvarint( @"hash_30dee5c8d013379b", 0 );
            
            if ( debugtarget )
            {
                level thread debug_utility::drawsphere( fireent.origin, 25, self.flighttime, ( 0, 1, 0 ) );
                level thread debug_utility::drawsphere( fireent.origin, 400, self.flighttime, ( 1, 0, 0 ) );
            }
        #/
        
        waitframe();
        fireent childthread firescriptable( firepart, fireduration, self );
    }
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x3700a9d0, Offset: 0x27b1
// Size: 0x2a
function private function_c66f3c4ccaa8298e( timedelay )
{
    if ( timedelay < 0 )
    {
        return;
    }
    
    wait timedelay;
    setomnvar( "ui_auto_drone_ent", self.minimapent );
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x55135870, Offset: 0x27e3
// Size: 0x22
function private function_462141d248cd38a0( timedelay )
{
    if ( timedelay < 0 )
    {
        return;
    }
    
    wait timedelay;
    setomnvar( "ui_auto_drone_ent", undefined );
}

// Namespace auto_drone
// Params 3, eflags: 0x4
// Checksum 0xf5a50101, Offset: 0x280d
// Size: 0xbd
function private firescriptable( scriptablepart, fireduration, autodrone )
{
    self setscriptablepartstate( scriptablepart, "active", 0 );
    autodrone radiusdamage( self.origin, autodrone.explosionsradius, autodrone.var_2afecf61a98a5d37, autodrone.var_2b21bd61a9b07d59, autodrone.owner, "MOD_EXPLOSIVE", self.weapon_name );
    wait fireduration;
    
    if ( isdefined( level.var_845fe19bc9ff4b8e ) )
    {
        thread [[ level.var_845fe19bc9ff4b8e ]]( self.streakinfo, self.origin, 0 );
    }
    
    self setscriptablepartstate( scriptablepart, "neutral", 0 );
    self.inuse = 0;
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xf523427, Offset: 0x28d2
// Size: 0x5c
function private function_b8e30897b7f90caf()
{
    level endon( #"game_ended" );
    self waittill( #"hash_fe360df1ecb78997" );
    self setscriptablepartstate( "flyout", "on", 0 );
    
    while ( true )
    {
        if ( self.reachedgoal )
        {
            break;
        }
        
        waitframe();
    }
    
    self setscriptablepartstate( "flyout", "off", 0 );
    cleanup();
}

// Namespace auto_drone
// Params 0, eflags: 0x4
// Checksum 0xbfe477d0, Offset: 0x2936
// Size: 0x127
function private waitforscriptables()
{
    level endon( #"game_ended" );
    var_7425b73b06a91091 = 1;
    
    while ( true )
    {
        var_7425b73b06a91091 = 1;
        
        foreach ( var_eacedda35a66cf7b in self.fireents )
        {
            foreach ( fireent in var_eacedda35a66cf7b )
            {
                if ( fireent.inuse )
                {
                    var_7425b73b06a91091 = 0;
                    break;
                }
            }
            
            if ( !var_7425b73b06a91091 )
            {
                break;
            }
        }
        
        if ( !var_7425b73b06a91091 )
        {
            waitframe();
            continue;
        }
        
        break;
    }
}

// Namespace auto_drone
// Params 1, eflags: 0x4
// Checksum 0x631f713c, Offset: 0x2a65
// Size: 0x12b
function private function_a701d167a901b81b( firetype )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    fireent = undefined;
    firemodel = bundle.var_a7b209edb355ecb2 ?? "ks_auto_drone_target_mp";
    
    if ( self.fireents[ firetype ].size == 0 )
    {
        fireent = function_dd9d53116d1bf55b( firetype, firemodel );
    }
    else
    {
        entlist = self.fireents[ firetype ];
        
        foreach ( ent in entlist )
        {
            if ( !ent.inuse )
            {
                fireent = ent;
                break;
            }
        }
        
        if ( !isdefined( fireent ) && entlist.size < 11 )
        {
            fireent = function_dd9d53116d1bf55b( firetype, firemodel );
        }
    }
    
    return fireent;
}

// Namespace auto_drone
// Params 2, eflags: 0x4
// Checksum 0x7b7c20c5, Offset: 0x2b99
// Size: 0xc6
function private function_dd9d53116d1bf55b( firetype, firemodel )
{
    bundle = killstreak::function_85b2d8e857ab4898( "auto_drone" );
    fireent = spawn( "script_model", self.origin );
    fireent.inuse = 0;
    fireent.streakinfo = self.streakinfo;
    fireent.weapon_name = bundle.auto_drone_weapon ?? "auto_drone_proj_mp";
    fireent setmodel( firemodel );
    fireent dontinterpolate();
    fireent setentityowner( self.owner );
    self.fireents[ firetype ][ self.fireents[ firetype ].size ] = fireent;
    return fireent;
}

