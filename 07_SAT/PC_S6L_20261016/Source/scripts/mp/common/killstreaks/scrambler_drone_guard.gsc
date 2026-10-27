// scripts\mp\common\killstreaks\scrambler_drone_guard.gsc  (hash_424cb770516e49dc.gscc) (size: 13515 Bytes / 0x34cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7297201b (1922506779)
// size ...... 13515 (0x34cb)
// includes .. 13  (offset: 0x3147)
// strings ... 38  (offset: 0x31af)
// dev strs .. 2   (offset: 0x3497)
// exports ... 30  (offset: 0x20ab)
// cseg ...... 0x35e + 0x1d4d (0x20ab)
// imports ... 101 (offset: 0x255b)
// animtree1 . 1   (offset: 0x34af)
// animtree2 . 1   (offset: 0x34bb)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\emp_debuff;
#using scripts\mp\hud_message;

#namespace scrambler_drone_guard;

// Namespace scrambler_drone_guard
// Params 0, eflags: 0x1
// Checksum 0x6284dd69, Offset: 0x37c
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "scrambler_drone_guard" ), &init );
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0xc6e72e43, Offset: 0x39b
// Size: 0x51
function init()
{
    killstreaks::registerkillstreak( "scrambler_drone_guard", &function_44b4704c6e0460d3 );
    
    /#
        setdevdvarifuninitialized( @"hash_643d7bc6577dad8d", 0 );
        setdevdvarifuninitialized( @"hash_7fcadff9d357faf3", 0 );
    #/
    
    level thread function_a3bfe7fa70233b45();
    init_scrambler_drone_guard_vo();
    init_scrambler_drone_guard_anim();
    init_scrambler_drone_guard_shared();
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0x684c8fb0, Offset: 0x3f4
// Size: 0x463
function function_a3bfe7fa70233b45()
{
    level endon( #"game_ended" );
    utility::flag_wait( "helper_drone_settings_loaded" );
    bundle = killstreak_utility::function_f943c0602acdc2af( "scrambler_drone_guard" );
    level.helperdronesettings[ "scrambler_drone_guard" ] = spawnstruct();
    level.helperdronesettings[ "scrambler_drone_guard" ].timeout = bundle.scramblerdronelifetime ?? 45;
    level.helperdronesettings[ "scrambler_drone_guard" ].maxhealth = bundle.scramblerdronemaxhealth ?? 150;
    level.helperdronesettings[ "scrambler_drone_guard" ].startheight = bundle.var_1075cf133216f8a4 ?? 3000;
    level.helperdronesettings[ "scrambler_drone_guard" ].speed = 140;
    level.helperdronesettings[ "scrambler_drone_guard" ].accel = 20;
    level.helperdronesettings[ "scrambler_drone_guard" ].halfsize = 50;
    level.helperdronesettings[ "scrambler_drone_guard" ].spawndist = 100;
    level.helperdronesettings[ "scrambler_drone_guard" ].streakname = "scrambler_drone_guard";
    level.helperdronesettings[ "scrambler_drone_guard" ].modelbase = bundle.scramblerdronemodel ?? "tag_origin";
    level.helperdronesettings[ "scrambler_drone_guard" ].teamsplash = "used_scrambler_drone_guard";
    level.helperdronesettings[ "scrambler_drone_guard" ].destroyedsplash = "callout_destroyed_scrambler_drone_guard";
    level.helperdronesettings[ "scrambler_drone_guard" ].sound_explode = "scrambler_drone_explode";
    level.helperdronesettings[ "scrambler_drone_guard" ].vodestroyed = undefined;
    level.helperdronesettings[ "scrambler_drone_guard" ].votimedout = undefined;
    level.helperdronesettings[ "scrambler_drone_guard" ].scorepopup = "destroyed_scrambler_drone_guard";
    level.helperdronesettings[ "scrambler_drone_guard" ].playfxcallback = &helper_drone::helperdrone_playfx;
    level.helperdronesettings[ "scrambler_drone_guard" ].primarymodefunc = &function_3afd0e350567148d;
    level.helperdronesettings[ "scrambler_drone_guard" ].premoddamagefunc = undefined;
    level.helperdronesettings[ "scrambler_drone_guard" ].postmoddamagefunc = undefined;
    level.helperdronesettings[ "scrambler_drone_guard" ].deathfunc = undefined;
    level.helperdronesettings[ "scrambler_drone_guard" ].explodefunc = &function_38e6811e16b03688;
    level.helperdronesettings[ "scrambler_drone_guard" ].damagemonitorfunc = &helper_drone::helperdrone_watchdamage;
    level.helperdronesettings[ "scrambler_drone_guard" ].deployweaponname = bundle.deployweaponname ?? "ks_gesture_phone_mp";
    level.helperdronesettings[ "scrambler_drone_guard" ].voontimeout = 1;
    level.helperdronesettings[ "scrambler_drone_guard" ].dropfunc = &function_45eb8e7629e9e58e;
    level.helperdronesettings[ "scrambler_drone_guard" ].empfunc = &function_627aedc48c584f0c;
    level.helperdronesettings[ "scrambler_drone_guard" ].deletedelay = bundle.var_814e1170d90bb0f6;
    level.helperdronesettings[ "scrambler_drone_guard" ].movetostring = bundle.var_2264e5d1c9ca10c7;
    level.helperdronesettings[ "scrambler_drone_guard" ].bundle = bundle;
    level.helperdronesettings[ "scrambler_drone_guard" ].autonomous = 1;
    level.helperdronesettings[ "scrambler_drone_guard" ].droneradius = utility::function_edc4cc03e9e60b3e( @"hash_b4b4a769159b8672", 1000, level.gametypebundle.scramblerdroneradius );
    
    if ( isbrgamemode() )
    {
        level.helperdronesettings[ "scrambler_drone_guard" ].diewithowner = 1;
    }
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0x61758313, Offset: 0x85f
// Size: 0x4d
function init_scrambler_drone_guard_vo()
{
    game[ "dialog" ][ "scrambler_drone_guard_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "scrambler_drone_guard_timeout" ] = "killstreak_remote_operator" + "_timeout";
    game[ "dialog" ][ "scrambler_drone_guard_destroyed" ] = "killstreak_remote_operator" + "_crash";
}

#using_animtree( "script_model" );

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0x29ed60a7, Offset: 0x8b4
// Size: 0x4e
function init_scrambler_drone_guard_anim()
{
    level.scr_animtree[ "scrambler_drone_guard" ] = #animtree;
    level.scr_anim[ "scrambler_drone_guard" ][ "rotor_spin" ] = %mp_cuniform_rotor_spin;
    level.animrefs[ "scrambler_drone_guard" ][ "rotor_spin" ] = "mp_cuniform_rotor_spin";
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0x33637311, Offset: 0x90a
// Size: 0x98
function init_scrambler_drone_guard_shared()
{
    utility::registersharedfunc( #"scrambler_drone_guard", #"setjammed", &function_6589dde963b7634b );
    utility::registersharedfunc( #"scrambler_drone_guard", #"endjammedeffect", &function_9649bf784ff6e767 );
    utility::registersharedfunc( #"scrambler_drone_guard", #"counteruavmodeon", &function_3a5bb1071cd8e6bd );
    utility::registersharedfunc( #"scrambler_drone_guard", #"hash_87bcff4c7b2718a7", &function_3069fda470dd0259 );
    utility::registersharedfunc( #"scrambler_drone_guard", #"watchjammedeffectdist", &function_e3d68eafb638baf5 );
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0xf5cbff03, Offset: 0x9aa
// Size: 0x22
function function_616741c3f8d2b682()
{
    streakinfo = killstreak_utility::createstreakinfo( "scrambler_drone_guard", self );
    return function_44b4704c6e0460d3( streakinfo );
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0xc797bb10, Offset: 0x9d5
// Size: 0x3e8, Type: bool
function function_44b4704c6e0460d3( streakinfo )
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
    
    helperdronetype = streakinfo.streakname;
    config = level.helperdronesettings[ helperdronetype ];
    deployresult = undefined;
    var_65934120c2efeb81 = undefined;
    var_d3bad8b7042c10da = 0;
    deployweaponname = level.helperdronesettings[ streakinfo.streakname ].deployweaponname;
    var_1075cf133216f8a4 = level.helperdronesettings[ helperdronetype ].startheight;
    
    if ( isplayer( self ) )
    {
        deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deployweaponname ) );
    }
    else
    {
        deployresult = 1;
    }
    
    if ( !deployresult )
    {
        hud_message::showerrormessage( %"killstreaks/unavailable" );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    location = self.origin;
    
    if ( isdefined( level.traceselectedmaplocation ) )
    {
        tracedata = [[ level.traceselectedmaplocation ]]( self.origin );
        location = tracedata[ "position" ];
    }
    else
    {
        startspawnorigin = location + ( 0, 0, var_1075cf133216f8a4 );
        spawntrace = trace::sphere_trace( startspawnorigin, self.origin, 15, undefined, trace::create_contents( 0, 1, 1 ) );
        
        if ( spawntrace[ "hittype" ] != "hittype_none" )
        {
            location = spawntrace[ "position" ];
        }
    }
    
    killstreak_utility::killstreak_dangernotifyplayersinrange( self, self.team, 15000, helperdronetype, location, isbrgamemode() ? 6000 : 1000 );
    streakinfo.abilityrange = config.droneradius ?? 1000;
    helperdrone = helper_drone::createhelperdrone( location + ( 0, 0, var_1075cf133216f8a4 ), self.angles, helperdronetype, streakinfo, 1 );
    
    if ( !isdefined( helperdrone ) )
    {
        hud_message::showerrormessage( %"killstreaks/unavailable" );
        return false;
    }
    
    helperdrone thread helper_drone::perkengineer_manageminimap();
    thread helper_drone::starthelperdrone( helperdrone );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"uav_bigmap", #"hash_acaf7bc0b1152d15" ) )
    {
        self [[ utility::getsharedfunc( #"uav_bigmap", #"hash_acaf7bc0b1152d15" ) ]]( 1000 );
    }
    
    if ( isplayer( self ) && !var_d3bad8b7042c10da )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
            var_65934120c2efeb81 = 2.5;
        }
        
        thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1, var_65934120c2efeb81 );
    }
    
    teamsplash = config.teamsplash;
    helperdrone emp_debuff::function_6e0986f750cd4259( &function_627aedc48c584f0c );
    utility::callsharedfunc( #"killstreak", #"logkillstreakevent", "scrambler_drone_guard", self.origin );
    thread utility::callsharedfunc( #"hud", #"teamplayercardsplash", "used_" + "scrambler_drone_guard", self );
    
    if ( isbrgamemode() )
    {
        var_1f39d5da859f3177 = level.teamdata[ self.team ][ "players" ];
        enemyplayersinrange = utility::function_f754506ecfae9afb( location, streakinfo.abilityrange, var_1f39d5da859f3177 );
        
        if ( enemyplayersinrange.size > 0 )
        {
            thread points::doscoreevent( #"hash_69ba80fa5f6605cc" );
        }
    }
    
    return true;
}

// Namespace scrambler_drone_guard
// Params 2, eflags: 0x40 variadic
// Checksum 0x83696afd, Offset: 0xdc6
// Size: 0x1c
function function_38e6811e16b03688( ... )
{
    function_4a23342741ec8957();
}

// Namespace scrambler_drone_guard
// Params 4
// Checksum 0xb2e1cf0d, Offset: 0xdea
// Size: 0x2e
function function_45eb8e7629e9e58e( config, wasdestroyed, wasexited, timedout )
{
    function_4a23342741ec8957();
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0x4d765151, Offset: 0xe20
// Size: 0x15
function function_627aedc48c584f0c( data )
{
    helper_drone::helperdrone_explode( 1 );
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0x549ee6, Offset: 0xe3d
// Size: 0x17
function function_4a23342741ec8957()
{
    function_3069fda470dd0259();
    function_9649bf784ff6e767();
    helper_drone::function_eccf8adbfdb03edc();
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0xc2c1ee47, Offset: 0xe5c
// Size: 0x106, Type: bool
function function_3afd0e350567148d( config )
{
    bundle = killstreak_utility::function_f943c0602acdc2af( "scrambler_drone_guard" );
    self.bundle = bundle;
    
    if ( isent( self ) )
    {
        newzoffset = int( self.origin[ 2 ] * 0.25 );
        var_f47e521b59f496ea = self.origin - ( 0, 0, newzoffset );
        function_39f1bb46a9c33ac3( var_f47e521b59f496ea );
        helper_drone::helperdrone_handleteamvisibility();
        self setscriptablepartstate( "looping_wave", "on", 0 );
        self setscriptablepartstate( "scramble_sfx", "on", 0 );
        self setscriptablepartstate( "lights", "on", 0 );
        self setscriptablepartstate( "rotors", "on", 0 );
        
        if ( isdefined( bundle.var_d2793d01f2e76fbc ) )
        {
            self rotatepitch( bundle.var_d2793d01f2e76fbc, 0.1 );
        }
        
        if ( bundle.scramblermovetolocation )
        {
            thread function_92e9ba467d542c3d();
        }
    }
    
    function_3a5bb1071cd8e6bd();
    return true;
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0x76330618, Offset: 0xf6b
// Size: 0x96
function function_92e9ba467d542c3d()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, level.helperdronesettings[ "scrambler_drone_guard" ].movetostring, #"move_to", undefined, undefined, 250 );
    
    while ( true )
    {
        self.useobj waittill( #"trigger", player );
        function_8f23299fdbb02ce2( self, player );
    }
}

// Namespace scrambler_drone_guard
// Params 2
// Checksum 0x94ed7b50, Offset: 0x1009
// Size: 0x91
function function_8f23299fdbb02ce2( drone, player )
{
    drone endon( #"death" );
    drone.ismoving = 1;
    movementduration = 3;
    drone moveto( ( player.origin[ 0 ], player.origin[ 1 ], drone.origin[ 2 ] ), movementduration );
    drone function_3069fda470dd0259();
    wait movementduration;
    drone.ismoving = undefined;
    drone function_3a5bb1071cd8e6bd();
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0xf24d035e, Offset: 0x10a2
// Size: 0x114
function function_39f1bb46a9c33ac3( var_f47e521b59f496ea )
{
    self.stoppedatlocation = 1;
    dronetrace = trace::sphere_trace( self.origin, var_f47e521b59f496ea, 200, self );
    
    if ( isdefined( dronetrace ) )
    {
        if ( isdefined( dronetrace[ "entity" ] ) )
        {
            var_f47e521b59f496ea = dronetrace[ "entity" ].origin + ( 0, 0, randomintrange( 100, 200 ) );
            
            if ( isdefined( dronetrace[ "entity" ].guardlocation ) )
            {
                var_f47e521b59f496ea = dronetrace[ "entity" ].guardlocation + ( 0, 0, randomintrange( 100, 200 ) );
            }
        }
        else if ( isdefined( dronetrace[ "hittype" ] ) && isdefined( dronetrace[ "position" ] ) && dronetrace[ "hittype" ] != "hittype_none" )
        {
            var_f47e521b59f496ea = dronetrace[ "position" ] + ( 0, 0, randomintrange( 300, 500 ) );
        }
    }
    
    /#
        guardoffset = ( 0, 0, getdvarint( @"hash_7fcadff9d357faf3", 0 ) );
        var_f47e521b59f496ea += guardoffset;
    #/
    
    thread function_8dd01afb21143603( var_f47e521b59f496ea );
    self.guardlocation = var_f47e521b59f496ea;
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0x6fb77338, Offset: 0x11be
// Size: 0x10f
function function_8dd01afb21143603( var_f47e521b59f496ea )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "rotors", "on", 0 );
    self moveto( var_f47e521b59f496ea - ( 0, 0, 20 ), 3, 2, 1 );
    wait 3.2;
    self moveto( var_f47e521b59f496ea, 1, 0.5, 0.5 );
    wait 1.2;
    
    while ( true )
    {
        if ( self.ismoving )
        {
            var_f47e521b59f496ea = self.origin;
            waitframe();
            continue;
        }
        
        var_6c2472797631d37a = randomintrange( -60, 60 );
        var_9299b28af45ad4d = randomintrange( -30, 30 );
        randomx = var_f47e521b59f496ea[ 0 ] + var_6c2472797631d37a;
        randomy = var_f47e521b59f496ea[ 1 ] + var_6c2472797631d37a;
        randomz = var_f47e521b59f496ea[ 2 ] + var_9299b28af45ad4d;
        var_1b5c3eb2a0ef2733 = ( randomx, randomy, randomz );
        self moveto( var_1b5c3eb2a0ef2733, 3, 2, 1 );
        wait 3.5;
    }
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0xd600c9ee, Offset: 0x12d5
// Size: 0x81
function function_3a5bb1071cd8e6bd()
{
    radarstate = "on";
    
    /#
        var_c0448fc5132d4ecb = getdvarint( @"hash_643d7bc6577dad8d", 0 );
        
        if ( var_c0448fc5132d4ecb == 1 )
        {
            radarstate += "<dev string:x24>";
        }
        else if ( var_c0448fc5132d4ecb == 2 )
        {
            radarstate += "<dev string:x2e>";
        }
    #/
    
    radarresult = game_utility::set_scriptable_radar( self, radarstate );
    
    if ( !radarresult )
    {
        uav::uav_addactivecounteruav();
        level notify( #"uav_update" );
    }
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0xbb62444b, Offset: 0x135e
// Size: 0x49
function function_3069fda470dd0259()
{
    radarresult = game_utility::set_scriptable_radar( self, "off" );
    
    /#
        self.owner.var_640ea62fa70ae194 = undefined;
    #/
    
    if ( !radarresult )
    {
        uav::uav_removeactivecounteruav();
        level notify( #"uav_update" );
    }
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0xfa59ae25, Offset: 0x13af
// Size: 0x340
function function_e3d68eafb638baf5( owner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"explode" );
    self endon( #"drop" );
    self endon( #"hash_ee1f68bd0482b52d" );
    
    if ( !isdefined( owner ) )
    {
        owner = self.owner;
    }
    
    var_2065bd56148d8bc6 = 0;
    
    if ( self.var_2065bd56148d8bc6 )
    {
        var_2065bd56148d8bc6 = 1;
    }
    
    self.var_1cc33a06670dae36 = [];
    skipteamcheck = 0;
    
    /#
        skipteamcheck = getdvarint( @"hash_7786353439eb384c", 0 );
    #/
    
    scramblerradius = getdvarfloat( @"compassscramblerradius", 1000 );
    
    if ( isdefined( self.var_54b9b80a3d6bdb93 ) )
    {
        scramblerradius = self.var_54b9b80a3d6bdb93;
    }
    
    var_bb2d4f1c40bafd12 = scramblerradius * scramblerradius;
    playercontents = physics_createcontents( [ "physicscontents_characterproxy" ] );
    pointtocheck = self.origin - ( 0, 0, 3000 );
    radiusvector = ( scramblerradius, scramblerradius, 3000 );
    aabbmin = pointtocheck - radiusvector;
    aabbmax = pointtocheck + radiusvector;
    
    while ( true )
    {
        if ( self.var_60faaf18afc7ae3f )
        {
            if ( isdefined( self.var_54b9b80a3d6bdb93 ) )
            {
                scramblerradius = self.var_54b9b80a3d6bdb93;
            }
            
            var_bb2d4f1c40bafd12 = scramblerradius * scramblerradius;
            pointtocheck = self.origin - ( 0, 0, 3000 );
            radiusvector = ( scramblerradius, scramblerradius, 3000 );
            aabbmin = pointtocheck - radiusvector;
            aabbmax = pointtocheck + radiusvector;
        }
        
        var_58b7071085483160 = physics_aabbbroadphasequery( aabbmin, aabbmax, playercontents, [] );
        
        foreach ( scrambledent in var_58b7071085483160 )
        {
            isimmune = isdefined( scrambledent.perks[ "specialty_scrambler_resist" ] );
            isimmune |= isagent( scrambledent );
            
            if ( isdefined( scrambledent ) && scrambledent player::isreallyalive() && !isimmune )
            {
                if ( distance2dsquared( self.origin, scrambledent.origin ) > var_bb2d4f1c40bafd12 )
                {
                    continue;
                }
                
                if ( skipteamcheck || level.teambased && scrambledent.team != self.team && scrambledent.team != "spectator" || !level.teambased && scrambledent != self.owner )
                {
                    if ( scrambledent utility::isusingremote() )
                    {
                        continue;
                    }
                    
                    if ( scrambledent function_650496b85fe7062e( self, skipteamcheck ) )
                    {
                        continue;
                    }
                    
                    scrambledent function_6589dde963b7634b( 1, self, skipteamcheck, var_2065bd56148d8bc6 );
                }
                
                continue;
            }
            
            if ( isdefined( scrambledent.scrambledby ) && arraycontains( scrambledent.scrambledby, self ) )
            {
                scrambledent notify( "scramble_off" + self getentitynumber() );
            }
        }
        
        waitframe();
    }
}

// Namespace scrambler_drone_guard
// Params 2
// Checksum 0x3e93f49f, Offset: 0x16f7
// Size: 0x147
function function_44470d7a5f44b34( buff, buffent )
{
    if ( function_650496b85fe7062e( buffent ) && buff )
    {
        return;
    }
    
    if ( buff )
    {
        buffent.friendliesaffectedbyscrambler[ buffent.friendliesaffectedbyscrambler.size ] = self;
        thread function_db94aaef8bf8dc2a( buffent );
        
        if ( utility::issharedfuncdefined( #"perk", #"giveperk" ) )
        {
            self [[ utility::getsharedfunc( #"perk", #"giveperk" ) ]]( "specialty_blindeye" );
        }
        
        if ( utility::issharedfuncdefined( #"perk", #"giveperk" ) )
        {
            self [[ utility::getsharedfunc( #"perk", #"giveperk" ) ]]( "specialty_noscopeoutline" );
        }
        
        return;
    }
    
    if ( isdefined( self ) )
    {
        if ( utility::issharedfuncdefined( #"perk", #"removeperk" ) )
        {
            self [[ utility::getsharedfunc( #"perk", #"removeperk" ) ]]( "specialty_blindeye" );
        }
        
        if ( utility::issharedfuncdefined( #"perk", #"removeperk" ) )
        {
            self [[ utility::getsharedfunc( #"perk", #"removeperk" ) ]]( "specialty_noscopeoutline" );
        }
    }
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0xf9542c15, Offset: 0x1846
// Size: 0x2e
function function_db94aaef8bf8dc2a( buffent )
{
    utility::waittill_any( "death_or_disconnect", "scramble_off" + buffent getentitynumber() );
    function_44470d7a5f44b34( 0, buffent );
}

// Namespace scrambler_drone_guard
// Params 4
// Checksum 0x5cbe382d, Offset: 0x187c
// Size: 0x16b
function function_6589dde963b7634b( jam, jammerent, skipteamcheck, var_fddfd3341b09e1e9 )
{
    var_7dddba2edbb2be51 = self;
    
    if ( jam )
    {
        if ( !isdefined( var_7dddba2edbb2be51.scrambledby ) )
        {
            var_7dddba2edbb2be51.scrambledby = [];
        }
        
        var_7dddba2edbb2be51.scrambledby = arraycombineunique( var_7dddba2edbb2be51.scrambledby, [ jammerent ] );
        
        if ( !arraycontains( jammerent.var_1cc33a06670dae36, var_7dddba2edbb2be51 ) )
        {
            jammerent.var_1cc33a06670dae36[ jammerent.var_1cc33a06670dae36.size ] = var_7dddba2edbb2be51;
        }
        
        var_7dddba2edbb2be51 thread function_cf6af933697579b3( jammerent, skipteamcheck, var_fddfd3341b09e1e9 );
        var_7dddba2edbb2be51 thread function_383c3b481070b91( jammerent, var_fddfd3341b09e1e9 );
        return;
    }
    
    if ( isdefined( jammerent ) && isdefined( var_7dddba2edbb2be51 ) && isdefined( var_7dddba2edbb2be51.scrambledby ) )
    {
        if ( arraycontains( var_7dddba2edbb2be51.scrambledby, jammerent ) )
        {
            var_7dddba2edbb2be51.scrambledby = arrayremove( var_7dddba2edbb2be51.scrambledby, jammerent );
            
            if ( isdefined( jammerent.var_7205a3b476fcdc36 ) )
            {
                scramblerstrength = jammerent.var_7205a3b476fcdc36[ self getentitynumber() ];
                
                if ( isdefined( scramblerstrength ) )
                {
                    jammerent.var_7205a3b476fcdc36[ self getentitynumber() ] = undefined;
                    var_7dddba2edbb2be51 emp_debuff::stop_scramble( scramblerstrength, var_fddfd3341b09e1e9 );
                    jammerent.var_7205a3b476fcdc36[ var_7dddba2edbb2be51 getentitynumber() ] = undefined;
                }
            }
        }
    }
}

// Namespace scrambler_drone_guard
// Params 3
// Checksum 0xccadbcc9, Offset: 0x19ef
// Size: 0xb7
function function_cf6af933697579b3( jammerent, skipteamcheck, var_fddfd3341b09e1e9 )
{
    level endon( #"game_ended" );
    utility::waittill_any( "death", "scramble_off" + jammerent getentitynumber() );
    
    if ( isdefined( self ) )
    {
        function_6589dde963b7634b( 0, jammerent, skipteamcheck, var_fddfd3341b09e1e9 );
        
        if ( isdefined( jammerent ) && isdefined( jammerent.var_1cc33a06670dae36 ) )
        {
            jammerent.var_1cc33a06670dae36 = arrayremove( jammerent.var_1cc33a06670dae36, self );
        }
        
        return;
    }
    
    if ( isdefined( jammerent ) && isdefined( jammerent.var_1cc33a06670dae36 ) )
    {
        jammerent.var_1cc33a06670dae36 = function_5713d46873b29625( jammerent.var_1cc33a06670dae36 );
    }
}

// Namespace scrambler_drone_guard
// Params 2
// Checksum 0x10b2025a, Offset: 0x1aae
// Size: 0x71
function function_3b9fd378b2c4e6df( jammerent, skipteamcheck )
{
    jammerent endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        if ( self.owner function_650496b85fe7062e( jammerent, skipteamcheck ) )
        {
            self.owner function_6589dde963b7634b( 0, jammerent, skipteamcheck );
        }
    }
}

// Namespace scrambler_drone_guard
// Params 2
// Checksum 0x881460cb, Offset: 0x1b27
// Size: 0x1f0
function function_383c3b481070b91( jammerent, var_fddfd3341b09e1e9 )
{
    self endon( #"death" );
    self endon( "scramble_off" + self getentitynumber() );
    self endon( #"disconnect" );
    jammerent endon( #"death" );
    
    if ( !isdefined( jammerent.var_7205a3b476fcdc36 ) )
    {
        jammerent.var_7205a3b476fcdc36 = [];
    }
    
    previousstrength = 0;
    scramblerstrength = 0;
    scramblerradius = getdvarfloat( @"compassscramblerradius", 1000 );
    
    if ( isdefined( jammerent.var_54b9b80a3d6bdb93 ) )
    {
        scramblerradius = jammerent.var_54b9b80a3d6bdb93;
    }
    
    var_bb2d4f1c40bafd12 = scramblerradius * scramblerradius;
    
    while ( true )
    {
        if ( jammerent.var_60faaf18afc7ae3f )
        {
            if ( isdefined( jammerent.var_54b9b80a3d6bdb93 ) )
            {
                scramblerradius = jammerent.var_54b9b80a3d6bdb93;
            }
            
            var_bb2d4f1c40bafd12 = scramblerradius * scramblerradius;
        }
        
        distancechecksq = 0;
        
        if ( jammerent.var_1b26f4a5de9c8b48 )
        {
            distancechecksq = distancesquared( jammerent.origin, self.origin );
        }
        else
        {
            distancechecksq = distance2dsquared( jammerent.origin, self.origin );
        }
        
        if ( distancechecksq > var_bb2d4f1c40bafd12 )
        {
            scramblerstrength = 0;
        }
        else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.8 )
        {
            scramblerstrength = 1;
        }
        else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.6 )
        {
            scramblerstrength = 2;
        }
        else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.4 )
        {
            scramblerstrength = 3;
        }
        else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.2 )
        {
            scramblerstrength = 4;
        }
        else
        {
            scramblerstrength = 5;
        }
        
        var_7c07fabfd38bcdf3 = scramblerstrength != previousstrength;
        
        if ( previousstrength == 0 || var_7c07fabfd38bcdf3 )
        {
            jammerent.var_7205a3b476fcdc36[ self getentitynumber() ] = scramblerstrength;
            emp_debuff::stop_scramble( previousstrength, var_fddfd3341b09e1e9 );
            emp_debuff::play_scramble( scramblerstrength, var_fddfd3341b09e1e9 );
            previousstrength = scramblerstrength;
        }
        
        waitframe();
    }
}

// Namespace scrambler_drone_guard
// Params 2
// Checksum 0x48f87391, Offset: 0x1d1f
// Size: 0x216
function function_650496b85fe7062e( scramblerent, skipteamcheck )
{
    scrambled = 0;
    scrambleentarray = undefined;
    
    if ( level.supportdrones.size > 0 )
    {
        foreach ( drone in level.supportdrones )
        {
            if ( drone.var_7147e0c8ab2f0702 != "scrambler_drone_guard" )
            {
                continue;
            }
            
            if ( level.teambased )
            {
                if ( !isdefined( skipteamcheck ) && drone.team == self.team )
                {
                    scrambleentarray = drone.friendliesaffectedbyscrambler;
                }
                else
                {
                    scrambleentarray = drone.var_1cc33a06670dae36;
                }
            }
            else if ( !isdefined( skipteamcheck ) && drone.owner == self )
            {
                scrambleentarray = drone.friendliesaffectedbyscrambler;
            }
            else
            {
                scrambleentarray = drone.var_1cc33a06670dae36;
            }
            
            if ( !isdefined( scrambleentarray ) )
            {
                continue;
            }
            
            if ( scrambleentarray.size > 0 )
            {
                foreach ( ent in scrambleentarray )
                {
                    if ( self == ent || self == ent.owner )
                    {
                        scrambled = 1;
                        break;
                    }
                }
                
                if ( scrambled )
                {
                    break;
                }
            }
        }
    }
    
    if ( !scrambled )
    {
        if ( isdefined( scramblerent ) && isdefined( scramblerent.var_1cc33a06670dae36 ) )
        {
            if ( arraycontains( scramblerent.var_1cc33a06670dae36, self ) )
            {
                scrambled = 1;
            }
        }
    }
    
    return scrambled;
}

// Namespace scrambler_drone_guard
// Params 1
// Checksum 0xbcd33948, Offset: 0x1f3e
// Size: 0x3d
function function_9d0c7426477871a0( enemyent )
{
    if ( isdefined( enemyent ) )
    {
        if ( isdefined( enemyent.owner ) )
        {
            enemyent = enemyent.owner;
        }
        
        enemyent notify( "scramble_off" + self getentitynumber() );
    }
}

// Namespace scrambler_drone_guard
// Params 0
// Checksum 0xabb947b6, Offset: 0x1f83
// Size: 0x128
function function_9649bf784ff6e767()
{
    self notify( #"hash_ee1f68bd0482b52d" );
    
    if ( self.var_1cc33a06670dae36.size > 0 )
    {
        foreach ( enemy in self.var_1cc33a06670dae36 )
        {
            function_9d0c7426477871a0( enemy );
        }
    }
    
    if ( self.friendliesaffectedbyscrambler.size > 0 )
    {
        foreach ( friendly in self.friendliesaffectedbyscrambler )
        {
            if ( isdefined( friendly ) )
            {
                friendly notify( "scramble_off" + self getentitynumber() );
            }
        }
    }
}

