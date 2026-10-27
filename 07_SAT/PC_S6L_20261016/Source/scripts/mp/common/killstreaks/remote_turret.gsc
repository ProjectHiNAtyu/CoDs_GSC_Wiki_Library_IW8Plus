// scripts\mp\common\killstreaks\remote_turret.gsc  (hash_0dcf29fb8387d999.gscc) (size: 27219 Bytes / 0x6a53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd07b478b (3497740171)
// size ...... 27219 (0x6a53)
// includes .. 22  (offset: 0x653b)
// strings ... 67  (offset: 0x65eb)
// dev strs .. 3   (offset: 0x6a1f)
// exports ... 56  (offset: 0x429f)
// cseg ...... 0x590 + 0x3d0f (0x429f)
// imports ... 213 (offset: 0x4b5f)
// animtree1 . 0   (offset: 0x6a43)
// animtree2 . 1   (offset: 0x6a43)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\rank;

#namespace remote_turret;

// Namespace remote_turret
// Params 0, eflags: 0x1
// Checksum 0x4e9e408a, Offset: 0x5ae
// Size: 0x2
function autoexec main()
{
    
}

// Namespace remote_turret
// Params 0, eflags: 0x4
// Checksum 0xb2983712, Offset: 0x5b8
// Size: 0xfa
function private init()
{
    assert( 1, "<dev string:x24>" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"init" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"initsentrysettings" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    utility::registersharedfunc( #"remote_turret", #"hack", &remoteturret_hack );
    killstreak_utility::registervisibilityomnvarforkillstreak( "remote_turret", "on", 16 );
    val::group_register( "remoteTurretUse", [ "allow_movement", "usability", "killstreaks", "supers", "reload", "offhand_weapons", "melee" ] );
    utility::flag_set( "remote_turret_initialized" );
}

// Namespace remote_turret
// Params 3
// Checksum 0x9d668da0, Offset: 0x6ba
// Size: 0x2d
function function_a5a9708459b927f9( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0xbc22e8f3, Offset: 0x6ef
// Size: 0x29
function tryuseremoteturret( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return function_dffc10d1e7460e97( streakinfo );
}

// Namespace remote_turret
// Params 1
// Checksum 0x1b77e720, Offset: 0x721
// Size: 0x251, Type: bool
function function_dffc10d1e7460e97( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    
    if ( !isdefined( streakinfo.weaponname ) )
    {
        streakinfo.weaponname = bundle.deployweapon;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            self.bgivensentry = 0;
            return false;
        }
    }
    
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    weaponobj = makeweapon( bundle.deployweapon );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"watchforplacementfirestate" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]( streakinfo, endonnotify, weaponobj );
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, weaponobj, 1, undefined, undefined, &function_a5a9708459b927f9 );
    
    if ( !deployresult )
    {
        self.bgivensentry = 0;
        self notify( endonnotify );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            self.bgivensentry = 0;
            return false;
        }
    }
    
    turret = remoteturret_watchplacement( streakinfo, 0, 1.25 );
    
    if ( !isdefined( turret.marker ) )
    {
        self.bgivensentry = 0;
        return false;
    }
    
    turret emp_debuff::set_start_emp_callback( &remoteturret_empstarted );
    turret.empremovecallback = &empremoved;
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempapplycallback = &function_8fcb60e7e36b3536;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempclearcallback = &function_950ddee650b31dbb;
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", turret, &function_f2fdd019aa1d97a6, &function_655bd8caffa5d850 );
    remoteturret_setplaced( turret, streakinfo );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"munitionused" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    self.remoteturretactive = 1;
    return true;
}

// Namespace remote_turret
// Params 3
// Checksum 0xf807e870, Offset: 0x97b
// Size: 0x1d6
function remoteturret_watchplacement( streakinfo, ignorecancel, var_c6c7c3535d7e7bda )
{
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    self.bgivensentry = 1;
    thread remoteturret_delayplacementinstructions( var_c6c7c3535d7e7bda );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"watchforplayerenteringlaststand" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]();
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"gettargetmarker" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        marker = self [[ var_32dbca3143d9c4a5 ]]( streakinfo, ignorecancel );
    }
    else
    {
        marker = undefined;
    }
    
    self notify( #"turret_placement_finished" );
    
    if ( !( isdefined( marker ) && isdefined( marker.location ) ) )
    {
        if ( player::isreallyalive() )
        {
            killstreak_utility::killstreak_switchbacklastweapon( bundle.deployweapon );
        }
        
        return;
    }
    
    turret = remoteturret_create( "remote_turret", streakinfo );
    
    if ( !isdefined( turret ) )
    {
        if ( player::isreallyalive() )
        {
            killstreak_utility::killstreak_switchbacklastweapon( bundle.deployweapon );
        }
        
        return;
    }
    
    turret.marker = marker;
    turret thread manual_turret::manualturret_disablefire( self, 1, 1 );
    
    if ( self hasweapon( bundle.deployweapon ) )
    {
        thread killstreak_utility::killstreak_switchbacklastweapon( bundle.deployweapon, 1, 1 );
    }
    
    delayspawntime = 0.85;
    wait delayspawntime;
    
    if ( !turret )
    {
        return;
    }
    
    params = spawnstruct();
    params.player = self;
    callback::callback( "remote_turret_deployed", params );
    utility::function_969f9f5596dba07a( turret, &function_fb3b9c035597125d );
    return turret;
}

// Namespace remote_turret
// Params 1
// Checksum 0x96b1fb5d, Offset: 0xb5a
// Size: 0x58
function remoteturret_delayplacementinstructions( delaytime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"turret_placement_finished" );
    level endon( #"game_ended" );
    wait delaytime;
    self setclientomnvar( "ui_turret_placement", 1 );
    thread manual_turret::manualturret_clearplacementinstructions( "death" );
    thread manual_turret::manualturret_clearplacementinstructions( "turret_placement_finished" );
}

// Namespace remote_turret
// Params 2
// Checksum 0x785ea20c, Offset: 0xbba
// Size: 0x533
function remoteturret_create( turrettype, streakinfo )
{
    config = level.sentrysettings[ turrettype ];
    remoteturretvehicletype = streakinfo.bundle.deployedvehicle ?? "veh_remote_turret";
    spawndata = { #owner:self, #angles:( 0, 0, 0 ), #targetname:remoteturretvehicletype, #vehicletype:remoteturretvehicletype, #origin:self.origin };
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    vehicle_tracking::register_instance( turret );
    vehicle_occupancy::register_instance( turret );
    turret.team = self.team;
    turret.owner = self;
    turret setotherent( turret.owner );
    turret setvehicleteam( turret.team );
    turret setnodeploy( 1 );
    turret.streakinfo = streakinfo;
    turret.turrettype = turrettype;
    turret.shouldsplash = 1;
    turret.timeout = config.timeout;
    turret.var_aadc7fa8ab5c6601 = 0;
    turret.maxhealth = int( max( 1, config.maxhealth ?? 0 ) );
    turret setcandamage( 0 );
    turret vehicle_damage::function_f22ce6c0cf2d903b( turret );
    turret turret::function_fa954b6b6aadaec0();
    turret turret::function_2e0a246d12d5e047( &function_d327ab4c0ad1af1 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"attachxrays" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret = self [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    else
    {
        turret = undefined;
    }
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            turret.timeout = 9999;
        }
        else if ( isdvardefined( @"hash_d17291ec1b4e806e" ) )
        {
            turret.timeout = getdvarint( @"hash_d17291ec1b4e806e" );
        }
    #/
    
    if ( !isdefined( turret.timeout ) )
    {
        turret.timeout = 120;
    }
    
    turret.maxtimeout = turret.timeout;
    turret.carriedby = self;
    turret setscriptablepartstate( "visibility", "hide" );
    turret function_43f074733c63d2d3();
    imageoverride = self.var_30656af96b2ac2a4.size > 0 ? turret.streakinfo.bundle.buffedheadicon : undefined;
    turret emp_debuff::allow_emp( 0 );
    turretweapon = turret getturretweapon();
    
    if ( turretweapon )
    {
        killstreaks::registerkillstreakdamagedealingweapon( turret.streakinfo.streakname, turretweapon.basename, #"medium" );
    }
    
    bundle = turret.streakinfo.bundle;
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        endtime = gettime() + int( turret.timeout * 1000 );
        turret thread killstreak_shared::function_585fb909f40d8659( endtime, bundle.alertfulllength, bundle.var_c3193942aa25f78, bundle.var_28e5801bce7f4815, bundle.var_b84c3eae995cb030, bundle.var_ed6c729701a7f3ed );
    }
    
    bundle = streakinfo.bundle;
    originoffset = ( bundle.var_15869b5e2c380579 ?? 0, bundle.var_15869a5e2c380346 ?? 0, bundle.var_1586995e2c380113 ?? 0 );
    killcament = spawn( "script_model", turret.origin + originoffset );
    killcament linkto( turret );
    turret.killcament = killcament;
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( "wm_jup_2h_remote_turret_00_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    killstreak_utility::function_79acee879fb17c4a( self, turret.streakinfo.streakname );
    turret.var_30656af96b2ac2a4 = [];
    turret.add_buff = &remoteturret_add_buff;
    turret.remove_buff = &remoteturret_remove_buff;
    return turret;
}

// Namespace remote_turret
// Params 1
// Checksum 0xb51e53a9, Offset: 0x10f6
// Size: 0x255
function remoteturret_add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.owner.var_e80e4a20752f898[ self.streakinfo.id ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_1871d75d82d51f83" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_1871d75d82d51f83", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( params.combatlink.owner != self.owner )
            {
                self.owner thread points::doscoreevent( #"hash_16c0af7021e4a987", params.combatlink.weapon_object );
            }
            
            self.owner.var_e80e4a20752f898[ self.streakinfo.id ] = 1;
            
            if ( !isdefined( self.owner.var_e80e4a20752f898 ) )
            {
                self.owner.var_e80e4a20752f898 = [];
            }
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.streakinfo.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.streakinfo.bundle.buffedheadicon, 1 );
            }
        }
        
        var_5131a1ab27961d5e = params.bundle.var_176181366c8eb5f1 ?? 1;
        shouldstack = params.bundle.var_a08a237d27780cdd ?? 0;
        
        if ( shouldstack )
        {
            self function_cc3104fbc8530bd8( self.var_30656af96b2ac2a4.size * var_5131a1ab27961d5e );
            return;
        }
        
        self function_cc3104fbc8530bd8( var_5131a1ab27961d5e );
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0x857d8d72, Offset: 0x1353
// Size: 0x12b
function remoteturret_remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_345ef9e4a8b98096 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_345ef9e4a8b98096, 1 );
                }
                
                self function_cc3104fbc8530bd8( 1 );
                return;
            }
            
            var_5131a1ab27961d5e = params.bundle.var_176181366c8eb5f1 ?? 1;
            shouldstack = params.bundle.var_a08a237d27780cdd ?? 0;
            
            if ( shouldstack )
            {
                self function_cc3104fbc8530bd8( self.var_30656af96b2ac2a4.size * var_5131a1ab27961d5e );
                return;
            }
            
            self function_cc3104fbc8530bd8( var_5131a1ab27961d5e );
        }
    }
}

// Namespace remote_turret
// Params 2
// Checksum 0x3a1a65f, Offset: 0x1486
// Size: 0x74f
function remoteturret_setplaced( turret, streakinfo )
{
    if ( !turret )
    {
        assertmsg( "<dev string:xc9>" );
        return;
    }
    
    bundle = streakinfo.bundle;
    config = level.sentrysettings[ turret.turrettype ];
    
    if ( !isdefined( self.placedsentries ) )
    {
        self.placedsentries = [];
    }
    
    if ( !isdefined( self.placedsentries[ turret.turrettype ] ) )
    {
        self.placedsentries[ turret.turrettype ] = [];
    }
    
    if ( turret.shouldsplash )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"sound" ][ #"playkillstreakdeploydialog" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo.streakname );
        }
        
        splashname = config.teamsplash;
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"teamplayercardsplash" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level thread [[ var_32dbca3143d9c4a5 ]]( splashname, self );
        }
        
        turret.shouldsplash = 0;
    }
    
    turret setcandamage( 1 );
    turret setscriptablepartstate( "visibility", "show" );
    turret dontinterpolate();
    turret.carriedby = undefined;
    marker = turret.marker;
    
    if ( isdefined( marker.moving_platform ) )
    {
        turret.moving_platform = marker.moving_platform;
        turret.moving_platform_offset = marker.moving_platform_offset;
        turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
    }
    
    turret vehicle_teleport( marker.location, self.angles, 0 );
    turret setturrettargetlocalangles( self.angles, 0, 1 );
    turret clearturrettarget();
    self.bgivensentry = 0;
    turret setscriptablepartstate( "turret_carry_state", "turret_plant" );
    turret setscriptablepartstate( "lights", "daytime" );
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret );
    turret function_8bcf8f582a411674();
    turretcount = self.placedsentries[ turret.turrettype ].size;
    
    if ( turretcount + 1 > 1 )
    {
        self.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret.turrettype, "Killstreak_Ground", self, 0, 1, undefined, "carried" );
    }
    
    hintpos = turret gettagorigin( "tag_turret" );
    
    if ( !isdefined( turret.useownerobj ) )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"createhintobject" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            turret.useownerobj = self [[ var_32dbca3143d9c4a5 ]]( hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show" );
        }
        else
        {
            turret.useownerobj = undefined;
        }
    }
    else
    {
        hintpos = turret gettagorigin( "tag_turret" );
        turret.useownerobj setusableenabled( 1 );
        turret.useownerobj dontinterpolate();
        turret.useownerobj.origin = hintpos;
    }
    
    turret.useownerobj linkto( turret, "tag_turret" );
    
    foreach ( guy in level.players )
    {
        if ( guy != turret.owner )
        {
            turret.useownerobj disableplayeruse( guy );
        }
    }
    
    if ( turret.streakinfo.bundle.var_f0d26d16d3b38e1 )
    {
        turret killstreak_utility::function_92b58f17af03198f( turret.streakinfo.streakname, self, &"killstreaks_hints/remote_turret_use", #"remote_control", 1 );
        turret thread function_8004d1ccff3f3aec();
    }
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = &function_dc98da18f653671c;
        
        if ( isdefined( turret.moving_platform ) )
        {
            data.linkparent = turret.moving_platform;
            data.linkoffset = turret.moving_platform_offset;
            data.angleoffset = turret.moving_platform_angles_offset;
            
            if ( utility::is_moving_platform_ent( turret.moving_platform ) )
            {
                data.var_f07590e06f628942 = 1;
            }
        }
        
        turret thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
    
    turret emp_debuff::allow_emp( 1 );
    
    if ( !turret.owner.ksempd )
    {
        turret remoteturret_empupdate();
        
        if ( !turret.var_7568cab78e4268cc )
        {
            turret thread function_67269135cff268b4();
        }
        else
        {
            updatedisable( turret );
        }
    }
    
    function_7571750c169de883( killstreak_utility::function_3244fa2d2d2dac67( "remote_turret" ) );
    thread remoteturret_delaydeletemarker( turret, marker );
    thread remoteturret_watchpickup( turret );
    thread remoteturret_disableplayeruseonconnect( turret, turret.useownerobj );
    
    if ( !turret.owner.ksempd && turret.streakinfo.bundle.var_f0d26d16d3b38e1 )
    {
        thread function_ff3376352b32f9fe( turret, bundle );
    }
    
    turret thread function_13d16b2053c35584( self, bundle );
    
    if ( !turret.damagemonitored )
    {
        thread remoteturret_watchdamage( turret );
    }
    
    thread function_5f7480996bdbf4b4( turret );
    thread remoteturret_watchtimeout( turret );
    thread remoteturret_watchdisown( turret );
    thread remoteturret_watchgameend( turret );
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        thread remoteturret_watchcancel( turret );
    }
    
    turret.isplaced = 1;
    self.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    turret notify( #"hash_db521cf8a268eb0a" );
}

// Namespace remote_turret
// Params 1
// Checksum 0x2e0b265b, Offset: 0x1bdd
// Size: 0x53
function function_7571750c169de883( killstreakid )
{
    assert( isdefined( killstreakid ), "<dev string:xdb>" );
    
    if ( killstreakid == 0 )
    {
        self setclientomnvar( "ui_killstreak_use_widget", killstreakid );
        self.parkedwidgetid = undefined;
        return;
    }
    
    self setclientomnvar( "ui_killstreak_use_widget", killstreakid );
    self.parkedwidgetid = killstreakid;
}

// Namespace remote_turret
// Params 0
// Checksum 0x2dfc7827, Offset: 0x1c38
// Size: 0x126
function function_8004d1ccff3f3aec()
{
    self notify( #"end_remote_monitor" );
    self endon( #"end_remote_monitor" );
    self endon( #"death" );
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"turret_hacked" );
    level endon( #"game_ended" );
    self.useobj enableplayeruse( self.owner );
    self.useobj setuseholdduration( 500 );
    useobjdisabled = 0;
    
    while ( true )
    {
        if ( self.owner utility::isusingremote() && !useobjdisabled && self.owner.usingremote != "remote_turret" )
        {
            self.useobj disableplayeruse( self.owner );
            useobjdisabled = 1;
        }
        else if ( useobjdisabled && !self.owner utility::isusingremote() )
        {
            wait 1;
            self.useobj enableplayeruse( self.owner );
            useobjdisabled = 0;
        }
        
        wait 0.1;
    }
}

// Namespace remote_turret
// Params 2
// Checksum 0x8afb90a3, Offset: 0x1d66
// Size: 0x36e
function function_ff3376352b32f9fe( turret, bundle )
{
    self notify( #"hash_1c26b7cd410c9d8f" );
    self endon( #"hash_1c26b7cd410c9d8f" );
    self endon( #"remote_turret_empd" );
    turret endon( #"remote_turret_death" );
    turret endon( #"hash_e26721e391f4828" );
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    turret.useobj waittill( #"trigger", player );
    
    if ( !function_db153696ed4c4712() )
    {
        thread function_ff3376352b32f9fe( turret, bundle );
        return;
    }
    
    if ( !turret.isplaced || turret.owner.ksempd || utility::isusingremote() || !function_db153696ed4c4712() )
    {
        return;
    }
    
    self.deployingremoteturret = 1;
    self disableweaponswitch();
    val::group_set( "remoteTurretUse", 0 );
    self notify( #"using_remote" );
    turret setscriptablepartstate( "turret_mode", "turret_mode_pre_manual" );
    turret turret::function_9a0fa09f3acbc0cd();
    turret notify( #"enterremote" );
    thread function_b197ff96ab1ea15a( turret, turret.var_aadc7fa8ab5c6601, bundle );
    remoteturret_deploytablet( turret, bundle );
    
    if ( !turret.var_aadc7fa8ab5c6601 )
    {
        wait 2;
        turret.var_aadc7fa8ab5c6601 = 1;
    }
    else
    {
        wait 1;
    }
    
    thread function_d8ac4f5ac8559ac5( turret );
    self waittill( #"hash_94de8186570a0318" );
    killstreak_shared::function_7ef9535e2b5c605b();
    turret.var_cf5011b794080978 = 1;
    player::setusingremote( "remote_turret", 1, 1 );
    ai::set_ignoreme( 1 );
    turret notify( #"remote_enter" );
    
    if ( self.isjuggernaut )
    {
        self notify( #"remote_enter" );
    }
    
    turret setscriptablepartstate( "turret_mode", "turret_mode_manual" );
    turret setscriptablepartstate( "lights", "remoted", 0 );
    turret remoteturret_applyoverlay( self );
    
    if ( function_db153696ed4c4712() && player::isreallyalive( self ) && !player::isinlaststand( self ) )
    {
        turret setturretscriptcontrolled( 0, 0 );
        self.restoreangles = self getplayerangles();
        self usevehicle( turret, 0, 0 );
        thread function_566f3f57f2a3470d( turret, bundle );
        self.deployingremoteturret = undefined;
        return;
    }
    
    if ( !turret.isplaced )
    {
        return;
    }
    
    turret.var_cf5011b794080978 = undefined;
    
    if ( utility::isusingremote() )
    {
        player::clearusingremote();
    }
    
    ai::set_ignoreme( 0 );
    turret notify( #"remote_exit" );
    
    if ( self.isjuggernaut )
    {
        self notify( #"remote_exit" );
    }
    
    turret setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
    turret setscriptablepartstate( "lights", "daytime", 0 );
    turret remoteturret_removeoverlay( self );
    inventory_utility::_switchtoweapon( self.primaryweaponobj );
    self enableweaponswitch();
    turret thread function_67269135cff268b4();
    wait 1;
    
    if ( isdefined( turret.tabletweaponobj ) )
    {
        self takeweapon( turret.tabletweaponobj );
        turret.tabletweaponobj = undefined;
    }
    
    val::group_reset( "remoteTurretUse" );
    self.deployingremoteturret = undefined;
    thread function_ff3376352b32f9fe( turret, bundle );
}

// Namespace remote_turret
// Params 3
// Checksum 0x747281da, Offset: 0x20dc
// Size: 0x18d
function function_b197ff96ab1ea15a( turret, var_aadc7fa8ab5c6601, bundle )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    hasendedearly = 0;
    result = utility::waittill_any_ents_return( self, "remoteTurret_deployTabletFinished", self, "remote_turret_empd", turret, "remote_turret_death", turret, "kill_turret", turret, "carried" );
    hasendedearly = result != "remoteTurret_deployTabletFinished";
    
    if ( !hasendedearly )
    {
        timeout = !var_aadc7fa8ab5c6601 ? 2 : 1;
        result = utility::waittill_any_ents_or_timeout_return( timeout, self, "remote_turret_empd", turret, "remote_turret_death", turret, "kill_turret", turret, "carried" );
        hasendedearly = result != "timeout";
    }
    
    if ( !hasendedearly )
    {
        self waittill( #"hash_94de8186570a0318", issuccess );
        hasendedearly = !issuccess;
    }
    
    if ( hasendedearly )
    {
        killstreak_shared::function_7ef9535e2b5c605b();
        currentweapon = self getcurrentweapon().basename;
        
        if ( currentweapon == ( bundle.deployweaponname ?? "ks_remote_device_mp" ) )
        {
            inventory_utility::_switchtoweapon( self.primaryweaponobj );
        }
        
        self enableweaponswitch();
        
        if ( isdefined( turret.tabletweaponobj ) )
        {
            self takeweapon( turret.tabletweaponobj );
            turret.tabletweaponobj = undefined;
        }
        
        val::group_reset( "remoteTurretUse" );
        
        if ( utility::isusingremote() )
        {
            player::clearusingremote();
        }
    }
}

#using_animtree( "script_model" );

// Namespace remote_turret
// Params 2
// Checksum 0x7f852e49, Offset: 0x2271
// Size: 0xc7
function remoteturret_deploytablet( turret, bundle )
{
    turret endon( #"kill_turret" );
    turret endon( #"remote_turret_death" );
    weaponobj = makeweapon( bundle.deployweaponname ?? "ks_remote_device_mp" );
    deployanim = %vm_ks_tablet_tap_raise;
    inventory_utility::_giveweapon( weaponobj, 0, 0, 1 );
    turret.tabletweaponobj = weaponobj;
    switchresult = inventory_utility::domonitoredweaponswitch( weaponobj, 0 );
    killstreak_shared::starttabletscreen( turret.streakinfo.streakname, 0 );
    killstreak_shared::function_7ef9535e2b5c605b();
    self notify( #"remoteTurret_deployTabletFinished" );
}

// Namespace remote_turret
// Params 1
// Checksum 0x7048b363, Offset: 0x2340
// Size: 0xf9
function function_d8ac4f5ac8559ac5( turret )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    turretmodepartstate = turret getscriptablepartstate( "turret_mode" );
    
    if ( turretmodepartstate == "turret_mode_manual" )
    {
        turret setscriptablepartstate( "turret_mode_fade", "turret_mode_manualtosentry_fadestart" );
    }
    else
    {
        turret setscriptablepartstate( "turret_mode_fade", "turret_mode_sentrytomanual_fadestart" );
    }
    
    level thread game_utility::fadetoblackforplayer( self, 1, 0.3 );
    result = utility::waittill_any_ents_or_timeout_return( 0.7, self, "remote_turret_empd", turret, "remote_turret_death", self, "death", turret, "kill_turret", turret, "carried" );
    issuccess = result == "timeout";
    
    if ( !issuccess )
    {
        turret utility::function_7c10ea82c1e305b8( "turret_mode_fade", "turret_mode_sentrytomanual_fadeinterrupted" );
    }
    
    level thread game_utility::fadetoblackforplayer( self, 0, 0.3 );
    self notify( #"hash_94de8186570a0318", issuccess );
}

// Namespace remote_turret
// Params 0
// Checksum 0x2043dfae, Offset: 0x2441
// Size: 0x79, Type: bool
function function_db153696ed4c4712()
{
    if ( self isswimming() || self.isridingvehicle || self isjumping() || self isinfreefall() || self ishanging() || self isparachuting() )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"showerrormessage" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( "KILLSTREAKS/REMOTE_TURRET_NOT_AVAILABLE" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace remote_turret
// Params 1
// Checksum 0x289f79a0, Offset: 0x24c3
// Size: 0x110
function function_e0a3b6d393526e24( turret )
{
    if ( self )
    {
        if ( turret.var_cf5011b794080978 )
        {
            self.remoteturretactive = undefined;
            
            if ( self isvehicleactive() )
            {
                self leavevehicle( 0, 1 );
            }
            
            self setplayerangles( self.restoreangles );
            turret remoteturret_removeoverlay( self );
            
            if ( utility::isusingremote() )
            {
                player::clearusingremote();
            }
            
            ai::set_ignoreme( 0 );
            
            if ( self.isjuggernaut )
            {
                self notify( #"remote_exit" );
            }
            
            inventory_utility::_switchtoweapon( self.primaryweaponobj );
            self enableweaponswitch();
            val::group_reset( "remoteTurretUse" );
        }
        
        self.placedsentries[ turret.turrettype ] = arrayremove( self.placedsentries[ turret.turrettype ], turret );
    }
    
    turret.var_cf5011b794080978 = undefined;
    turret notify( #"remote_exit" );
    turret setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
    turret setscriptablepartstate( "lights", "daytime", 0 );
}

// Namespace remote_turret
// Params 2
// Checksum 0xbe2e6a0b, Offset: 0x25db
// Size: 0x101
function function_566f3f57f2a3470d( turret, bundle )
{
    self endon( #"remote_turret_empd" );
    turret endon( #"remote_turret_death" );
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    thread function_b96f262796b77898( turret, 0.75 );
    self waittill( #"hash_597999d7b5a801e2" );
    
    if ( turret.isplaced )
    {
        /#
            if ( getdvarint( @"hash_8cb86e86af6483b0", 0 ) == 1 )
            {
                thread function_3d3ef2611a5dbca0( turret );
            }
        #/
        
        thread function_d8ac4f5ac8559ac5( turret );
        self waittill( #"hash_94de8186570a0318" );
        function_e0a3b6d393526e24( turret );
        turret thread function_67269135cff268b4();
        wait 1;
        
        if ( isdefined( turret.tabletweaponobj ) )
        {
            self takeweapon( turret.tabletweaponobj );
            turret.tabletweaponobj = undefined;
        }
        
        thread function_ff3376352b32f9fe( turret, bundle );
    }
}

// Namespace remote_turret
// Params 2, eflags: 0x4
// Checksum 0x33413c25, Offset: 0x26e4
// Size: 0x12d
function private function_b96f262796b77898( turret, overrideholdtime )
{
    if ( !( isdefined( self ) && isdefined( turret ) ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"end_remote" );
    self endon( #"monitoringexit" );
    turret endon( #"death" );
    
    while ( self usebuttonpressed() )
    {
        waitframe();
    }
    
    holdtime = 0.75;
    
    if ( isdefined( overrideholdtime ) )
    {
        holdtime = overrideholdtime;
    }
    
    updaterate = level.framedurationseconds;
    timerdirty = 1;
    
    while ( true )
    {
        timeused = 0;
        
        if ( timerdirty == 1 )
        {
            self setclientomnvar( "ui_exit_progress", 0 );
            timerdirty = 0;
        }
        
        while ( self usebuttonpressed() )
        {
            if ( !self usinggamepad() && !self getuseholdkbmprofile() )
            {
                self notify( #"hash_597999d7b5a801e2" );
                return;
            }
            
            timeused += updaterate;
            timerdirty = 1;
            self setclientomnvar( "ui_exit_progress", timeused / holdtime );
            
            if ( timeused > holdtime )
            {
                self notify( #"hash_597999d7b5a801e2" );
                return;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0x4f1206f4, Offset: 0x2819
// Size: 0x314
function remoteturret_setcarried( turret )
{
    turret endon( #"kill_turret" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    turret setcandamage( 0 );
    
    if ( turret.moving_platform )
    {
        turret.moving_platform = undefined;
        turret.moving_platform_offset = undefined;
        turret.moving_platform_angles_offset = undefined;
        turret unlink();
    }
    
    turret emp_debuff::allow_emp( 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"game" ][ #"unregistersentient" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret.sentientpool, turret.sentientpoolindex );
    }
    
    linkedchildren = turret getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( child )
        {
            child unlink();
        }
    }
    
    turret function_43f074733c63d2d3();
    turret.colmodel unlink();
    turret.colmodel hide();
    remoteturret_setinactive( turret );
    turret setscriptablepartstate( "turret_carry_state", "turret_pickup" );
    function_7571750c169de883( 0 );
    killstreak_utility::function_79acee879fb17c4a( self, turret.streakinfo.streakname );
    turret.carriedby = self;
    turret notify( #"carried" );
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"watchforplacementfirestate" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo, endonnotify );
    }
    
    weaponobj = makeweapon( bundle.deployweapon );
    inventory_utility::_giveweapon( weaponobj );
    waitframe();
    streakinfo = turret.streakinfo;
    self.placedsentries[ turret.turrettype ] = arrayremove( self.placedsentries[ turret.turrettype ], turret );
    turret function_43f074733c63d2d3();
    turret remoteturret_delete();
    switchsuccess = inventory_utility::domonitoredweaponswitch( weaponobj, 1 );
    
    if ( !switchsuccess )
    {
        return 0;
    }
    
    manual_turret::manualturret_toggleallowplacementactions( 0 );
    turret = remoteturret_watchplacement( streakinfo, 1, 2 );
    manual_turret::manualturret_toggleallowplacementactions( 1 );
    
    if ( !turret.marker )
    {
        self.bgivensentry = 0;
        return 0;
    }
    
    remoteturret_setplaced( turret );
}

// Namespace remote_turret
// Params 1
// Checksum 0x4f009f3f, Offset: 0x2b35
// Size: 0x41
function remoteturret_setinactive( turret )
{
    turret.isplaced = undefined;
    turret turret::function_9a0fa09f3acbc0cd();
    turret.useownerobj setusableenabled( 0 );
    turret.useownerobj unlink();
}

// Namespace remote_turret
// Params 2
// Checksum 0xd1f13a30, Offset: 0x2b7e
// Size: 0x52
function remoteturret_delaydeletemarker( turret, marker )
{
    turret endon( #"kill_turret" );
    level endon( #"game_ended" );
    wait 0.25;
    
    if ( marker.visual )
    {
        marker.visual delete();
    }
}

// Namespace remote_turret
// Params 2
// Checksum 0x49b0d856, Offset: 0x2bd8
// Size: 0x82
function remoteturret_disableplayeruseonconnect( turret, useobj )
{
    turret endon( #"turret_hacked" );
    
    if ( turret )
    {
        turret endon( #"kill_turret" );
        turret endon( #"carried" );
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        useobj disableplayeruse( player );
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0x58520be3, Offset: 0x2c62
// Size: 0x169
function remoteturret_watchpickup( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    turret endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( isdefined( turret ) )
    {
        turret.useownerobj waittill( #"trigger", player );
        
        if ( player != turret.owner )
        {
            continue;
        }
        
        if ( self.ishaywire || turret emp_debuff::is_empd() )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"remote_turret", #"allowpickupofturret" ) )
        {
            if ( !player [[ utility::getsharedfunc( #"remote_turret", #"allowpickupofturret" ) ]]() )
            {
                continue;
            }
        }
        
        turret.useownerobj setusableenabled( 0 );
        remoteturret_setinactive( turret );
        turret.owner.placedsentries[ turret.turrettype ] = arrayremove( turret.owner.placedsentries[ turret.turrettype ], turret );
        turret.owner thread remoteturret_setcarried( turret );
        waitframe();
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0xf77cacfe, Offset: 0x2dd3
// Size: 0x83
function remoteturret_watchdamage( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"monitordamage" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    
    turret.damagemonitored = 1;
}

// Namespace remote_turret
// Params 1, eflags: 0x4
// Checksum 0x4c71aa06, Offset: 0x2e5e
// Size: 0x51
function private updatedisable( jammedremoteturret )
{
    if ( jammedremoteturret.var_7568cab78e4268cc )
    {
        jammedremoteturret turret::function_9a0fa09f3acbc0cd();
        jammedremoteturret setscriptablepartstate( "empd", "on" );
        return;
    }
    
    jammedremoteturret thread function_67269135cff268b4();
    jammedremoteturret setscriptablepartstate( "empd", "off" );
}

// Namespace remote_turret
// Params 1, eflags: 0x4
// Checksum 0xd46ec446, Offset: 0x2eb7
// Size: 0x3c
function private function_f2fdd019aa1d97a6( jammedremoteturret )
{
    if ( !isdefined( jammedremoteturret.var_7568cab78e4268cc ) )
    {
        jammedremoteturret.var_7568cab78e4268cc = 0;
    }
    
    jammedremoteturret.var_7568cab78e4268cc++;
    updatedisable( jammedremoteturret );
}

// Namespace remote_turret
// Params 1, eflags: 0x4
// Checksum 0x3a12743, Offset: 0x2efb
// Size: 0x21
function private function_655bd8caffa5d850( jammedremoteturret )
{
    jammedremoteturret.var_7568cab78e4268cc--;
    updatedisable( jammedremoteturret );
}

// Namespace remote_turret
// Params 1
// Checksum 0x2e4e25f, Offset: 0x2f24
// Size: 0xb5
function remoteturret_empstarted( data )
{
    if ( data.attacker )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            data.attacker thread [[ var_32dbca3143d9c4a5 ]]( #"disabled_sentry_gun" );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"empstarted" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]();
        }
    }
    
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 0;
    }
    
    self.var_7568cab78e4268cc++;
    updatedisable( self );
}

// Namespace remote_turret
// Params 1
// Checksum 0xa2653607, Offset: 0x2fe1
// Size: 0x59
function empremoved( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"empcleared" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    self.var_7568cab78e4268cc--;
    updatedisable( self );
}

// Namespace remote_turret
// Params 1
// Checksum 0xca7b831e, Offset: 0x3042
// Size: 0x1f3
function function_8fcb60e7e36b3536( data )
{
    if ( data.attacker )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            data.attacker thread [[ var_32dbca3143d9c4a5 ]]( "disabled_sentry_gun", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"empstarted" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]();
        }
    }
    
    if ( self.useobj )
    {
        self.useobj disableplayeruse( self.useobj.owner );
        self.useobj.activeuseobject = 0;
    }
    
    self.owner notify( #"hash_e22e68cb2672e26e" );
    self.owner notify( #"remote_turret_empd" );
    self setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
    
    if ( self.var_cf5011b794080978 )
    {
        if ( self.owner utility::isusingremote() )
        {
            self.owner player::clearusingremote();
        }
        
        self.owner ai::set_ignoreme( 0 );
        self notify( #"remote_exit" );
        
        if ( self.owner.isjuggernaut )
        {
            self.owner notify( #"remote_exit" );
        }
        
        self setscriptablepartstate( "lights", "daytime", 0 );
        remoteturret_removeoverlay( self.owner );
        
        if ( isdefined( self.owner ) )
        {
            self.owner inventory_utility::_switchtoweapon( self.owner.primaryweaponobj );
            self.owner enableweaponswitch();
            wait 1;
            val::group_reset( "remoteTurretUse" );
        }
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0xcbaa6259, Offset: 0x323d
// Size: 0xed
function function_950ddee650b31dbb( data )
{
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"empcleared" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( self.useobj )
    {
        self.useobj enableplayeruse( self.useobj.owner );
        self.useobj.activeuseobject = 1;
    }
    
    if ( self.isplaced )
    {
        if ( self.streakinfo.bundle.var_f0d26d16d3b38e1 )
        {
            self.owner thread function_ff3376352b32f9fe( self, bundle );
        }
        
        thread function_67269135cff268b4();
    }
}

/#

    // Namespace remote_turret
    // Params 1, eflags: 0x4
    // Checksum 0x7f6c5816, Offset: 0x3332
    // Size: 0x54, Type: dev
    function private function_3d3ef2611a5dbca0( turret )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        turret endon( #"death" );
        wait 0.3;
        turret function_8fcb60e7e36b3536( {} );
        wait 4;
        turret function_950ddee650b31dbb( {} );
    }

#/

// Namespace remote_turret
// Params 0
// Checksum 0x5eae56cf, Offset: 0x338e
// Size: 0x3c
function remoteturret_empupdate()
{
    if ( emp_debuff::is_empd() )
    {
        turret::function_9a0fa09f3acbc0cd();
        self setscriptablepartstate( "empd", "on" );
        return;
    }
    
    thread function_67269135cff268b4();
    self setscriptablepartstate( "empd", "off" );
}

// Namespace remote_turret
// Params 1
// Checksum 0x1940eea2, Offset: 0x33d2
// Size: 0x57
function function_863f81d3f08ff16f( owner )
{
    self endon( #"death" );
    self endon( #"turret_hacked" );
    
    while ( true )
    {
        if ( owner player::isreallyalive() && !player::isinlaststand( owner ) )
        {
            self.var_1c0e480c4d931c51 = undefined;
            break;
        }
        
        wait 0.1;
    }
}

// Namespace remote_turret
// Params 2
// Checksum 0x223f986b, Offset: 0x3431
// Size: 0xb3
function function_13d16b2053c35584( owner, bundle )
{
    self endon( #"death" );
    self endon( #"carried" );
    self endon( #"turret_hacked" );
    self.owner endon( #"death" );
    
    while ( true )
    {
        if ( !owner player::isreallyalive() || player::isinlaststand( owner ) )
        {
            if ( !self.var_1c0e480c4d931c51 )
            {
                thread function_67269135cff268b4();
                self notify( #"hash_e26721e391f4828" );
                self.var_1c0e480c4d931c51 = 1;
                thread function_863f81d3f08ff16f( owner );
                owner thread function_ff3376352b32f9fe( self, bundle );
            }
        }
        
        wait 0.1;
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0x4f8aa55e, Offset: 0x34ec
// Size: 0xd8
function remoteturret_delete( delay )
{
    turret = self;
    
    if ( isdefined( turret.damagemonitored ) )
    {
        turret.damagemonitored = undefined;
    }
    
    if ( isdefined( turret.killcament ) )
    {
        turret.killcament delete();
    }
    
    if ( isdefined( turret.useownerobj ) )
    {
        turret.useownerobj delete();
    }
    
    if ( isdefined( turret.useotherobj ) )
    {
        turret.useotherobj delete();
    }
    
    if ( isdefined( turret.colmodel ) )
    {
        turret.colmodel delete();
    }
    
    if ( delay )
    {
        wait delay;
    }
    
    if ( turret )
    {
        vehicle_occupancy::deregister_instance( turret );
        vehicle_tracking::deregister_instance( turret );
        turret vehicle_tracking::delete_vehicle( turret );
    }
}

// Namespace remote_turret
// Params 1
// Checksum 0x47d54b98, Offset: 0x35cc
// Size: 0x209
function function_5f7480996bdbf4b4( turret )
{
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed, wascanceled );
    turret notify( #"remote_turret_death" );
    turret notify( #"death" );
    waitframe();
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", self );
    
    if ( turret.var_cf5011b794080978 )
    {
        function_e0a3b6d393526e24( turret );
    }
    
    if ( isdefined( self ) )
    {
        remoteturret_setinactive( turret );
        function_7571750c169de883( 0 );
        turret.streakinfo.expiredbydeath = istrue( wasdestroyed );
        killstreak_utility::recordkillstreakendstats( turret.streakinfo );
    }
    
    if ( wasdestroyed )
    {
        killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_destroyed", #"destroyed" );
    }
    
    if ( !skipshutdown )
    {
        turret setscriptablepartstate( "shutdown", "on" );
        turret setscriptablepartstate( "turret_carry_state", "off" );
        wait 2;
        turret setscriptablepartstate( "explode", "regular" );
    }
    else if ( !wascanceled )
    {
        turret setscriptablepartstate( "explode", "violent" );
    }
    
    turret.owner.var_e80e4a20752f898[ turret.streakinfo.id ] = undefined;
    
    if ( !turret.owner.var_e80e4a20752f898.size )
    {
        turret.owner.var_e80e4a20752f898 = undefined;
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:turret.streakinfo } );
    turret function_43f074733c63d2d3();
    turret remoteturret_delete( 0.2 );
}

// Namespace remote_turret
// Params 1
// Checksum 0x3bc10497, Offset: 0x37dd
// Size: 0x1c
function function_dc98da18f653671c( data )
{
    self notify( #"kill_turret", 1, 1 );
}

// Namespace remote_turret
// Params 1
// Checksum 0x6dcc9bb0, Offset: 0x3801
// Size: 0x154
function remoteturret_watchtimeout( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( turret.maxtimeout < 0 )
    {
        return;
    }
    
    starttime_ms = gettime();
    timeout_s = turret.timeout;
    timepassed_ms = gettime() - starttime_ms;
    
    while ( timepassed_ms < timeout_s * 1000 )
    {
        turret.timeout = turret.maxtimeout - timepassed_ms * 0.001;
        var_21622e853a32f8a4 = turret.timeout / timeout_s;
        self setclientomnvar( "ui_killstreak_lifetime", var_21622e853a32f8a4 );
        timeoutpercentage = int( 100 * var_21622e853a32f8a4 );
        self setclientomnvar( "ui_killstreak_countdown", timeoutpercentage );
        timepassed_ms = gettime() - starttime_ms;
        waitframe();
    }
    
    killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_timeout", #"leave" );
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace remote_turret
// Params 1
// Checksum 0x9bda61f9, Offset: 0x395d
// Size: 0x58
function remoteturret_watchdisown( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace remote_turret
// Params 1
// Checksum 0x93332391, Offset: 0x39bd
// Size: 0x52
function remoteturret_watchcancel( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    self waittill( #"killstreak_cancel" );
    turret notify( #"kill_turret", 1, 0, 1 );
}

// Namespace remote_turret
// Params 1
// Checksum 0xbbf7d331, Offset: 0x3a17
// Size: 0x91
function remoteturret_watchgameend( turret )
{
    turret endon( #"kill_turret", #"carried" );
    level waittill( #"game_ended" );
    
    if ( self && turret.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo );
        }
    }
    
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace remote_turret
// Params 0
// Checksum 0xe8f52b0, Offset: 0x3ab0
// Size: 0x105
function function_67269135cff268b4()
{
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"enterremote" );
    self.owner endon( #"remote_turret_empd" );
    level endon( #"game_ended" );
    momentum = 0;
    var_96cbbf3eaeaca85e = 0;
    updateinterval = 0.1;
    self setturretscriptcontrolled( 1, 0 );
    turret::function_9a0fa09f3acbc0cd();
    turret::function_9b1f535339c80a4();
    
    while ( true )
    {
        var_af21fdaa241f1b3f = turret::is_turret_firing();
        
        if ( !var_96cbbf3eaeaca85e && var_af21fdaa241f1b3f )
        {
            momentum = 0;
        }
        else if ( var_af21fdaa241f1b3f )
        {
            if ( momentum < 1 )
            {
                momentum += updateinterval;
                
                if ( momentum >= 1 )
                {
                    self setscriptablepartstate( "turret_target_found", "target_found" );
                }
            }
        }
        else if ( var_96cbbf3eaeaca85e && !var_af21fdaa241f1b3f )
        {
            self setscriptablepartstate( "turret_target_found", "off" );
        }
        
        var_96cbbf3eaeaca85e = var_af21fdaa241f1b3f;
        wait updateinterval;
    }
}

// Namespace remote_turret
// Params 2, eflags: 0x4
// Checksum 0xd8600c2f, Offset: 0x3bbd
// Size: 0xf2, Type: bool
function private function_d327ab4c0ad1af1( target, turretindex )
{
    if ( isplayer( target ) )
    {
        if ( isdefined( target.perks[ "specialty_coldblooded" ] ) )
        {
            return false;
        }
        
        if ( level.sentrysettings[ self.turrettype ].ignorejuggernaut && target.isjuggernaut )
        {
            return false;
        }
    }
    
    if ( level.sentrysettings[ self.turrettype ].ignoreagent && isagent( target ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        if ( self.owner && isagent( target ) && !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self.owner, target ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace remote_turret
// Params 0, eflags: 0x4
// Checksum 0xb5bbe68, Offset: 0x3cb8
// Size: 0xa
function private function_8bcf8f582a411674()
{
    vehicle_compass::vehicle_show( self );
}

// Namespace remote_turret
// Params 0, eflags: 0x4
// Checksum 0x9dbfb845, Offset: 0x3cca
// Size: 0xa
function private function_43f074733c63d2d3()
{
    vehicle_compass::vehicle_hide( self );
}

// Namespace remote_turret
// Params 1
// Checksum 0x478040b8, Offset: 0x3cdc
// Size: 0x3a
function remoteturret_applyoverlay( player )
{
    player killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "on" );
    player setclientomnvar( "ui_killstreak_health", 0 );
}

// Namespace remote_turret
// Params 1
// Checksum 0x226f6f2, Offset: 0x3d1e
// Size: 0x2d
function remoteturret_removeoverlay( player )
{
    player killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
}

// Namespace remote_turret
// Params 2
// Checksum 0x489b2586, Offset: 0x3d53
// Size: 0x3a
function remoteturret_hack( hackeffect, attacker )
{
    if ( hackeffect.var_30e7de3d76d5a085 )
    {
        function_990c858b539fe53a( hackeffect, attacker );
        return;
    }
    
    thread function_df380b5c739d75c0( hackeffect, attacker );
}

// Namespace remote_turret
// Params 2
// Checksum 0x5ce45ac4, Offset: 0x3d95
// Size: 0x1c1
function function_df380b5c739d75c0( hackeffect, attacker )
{
    turret = self;
    turret endon( #"death_or_disconnect" );
    turret endon( #"game_ended" );
    turret endon( #"turret_hacked" );
    config = level.sentrysettings[ turret.turrettype ];
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    turret.empcount = turret.empcount ? turret.empcount + 1 : 1;
    turret remoteturret_empupdate();
    turret function_8fcb60e7e36b3536( undefined );
    turret.useownerobj disableplayeruse( turret.owner );
    
    if ( level.teambased )
    {
        turret filteroutplayermarks( level.teamnamelist );
    }
    else
    {
        turret filteroutplayermarks( level.players );
    }
    
    wait hackeffect.hackduration * 0.001;
    
    if ( turret.empcount > 0 )
    {
        turret.empcount--;
        turret remoteturret_empupdate();
        turret function_950ddee650b31dbb( undefined );
        turret.useownerobj enableplayeruse( attacker );
        
        if ( level.teambased )
        {
            turret filterinplayermarks( level.teamnamelist );
            turret filteroutplayermarks( self.owner.team );
            return;
        }
        
        turret filterinplayermarks( level.players );
        turret filteroutplayermarks( self.owner );
    }
}

// Namespace remote_turret
// Params 2
// Checksum 0x7f2a2ae6, Offset: 0x3f5e
// Size: 0x328
function function_990c858b539fe53a( hackeffect, attacker )
{
    turret = self;
    config = level.sentrysettings[ turret.turrettype ];
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    turret notify( #"turret_hacked" );
    turret.owner function_e0a3b6d393526e24( turret );
    turret.useownerobj disableplayeruse( turret.owner );
    turret.empcount = turret.empcount ? turret.empcount - 1 : undefined;
    turret remoteturret_empupdate();
    killstreak_utility::function_79acee879fb17c4a( turret.owner, turret.streakinfo.streakname );
    turret.team = attacker.team;
    turret.owner = attacker;
    turret setotherent( turret.owner );
    turret setvehicleteam( turret.team );
    turret.spawndata.owner = turret.owner;
    turret.streakinfo.owner = turret.owner;
    turret.var_aadc7fa8ab5c6601 = 0;
    turret.useownerobj enableplayeruse( attacker );
    
    if ( turret.streakinfo.bundle.var_f0d26d16d3b38e1 )
    {
        turret killstreak_utility::function_92b58f17af03198f( turret.streakinfo.streakname, turret.owner, &"killstreaks_hints/remote_turret_use", #"remote_control", 1 );
        turret thread function_8004d1ccff3f3aec();
    }
    
    turret function_950ddee650b31dbb( undefined );
    attacker thread remoteturret_disableplayeruseonconnect( turret, turret.useownerobj );
    turret thread function_13d16b2053c35584( attacker, bundle );
    attacker thread remoteturret_watchpickup( turret );
    attacker thread function_5f7480996bdbf4b4( turret );
    attacker thread remoteturret_watchtimeout( turret );
    attacker thread remoteturret_watchdisown( turret );
    namespace_9d8e359c3b1041e5::killstreak_dangernotifyplayersinrangesharedfunc( attacker, attacker.team, 2000, turret.streakinfo.streakname );
    
    if ( level.teambased )
    {
        turret filteroutplayermarks( attacker.team );
    }
    else
    {
        turret filteroutplayermarks( attacker );
    }
    
    turretcount = attacker.placedsentries[ turret.turrettype ].size ?? 0;
    
    if ( turretcount + 1 > 1 )
    {
        attacker.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    attacker.placedsentries[ turret.turrettype ][ turretcount ] = turret;
}

// Namespace remote_turret
// Params 0
// Checksum 0x7e7e869c, Offset: 0x428e
// Size: 0x11
function function_fb3b9c035597125d()
{
    self notify( #"kill_turret", 1, 0 );
}

