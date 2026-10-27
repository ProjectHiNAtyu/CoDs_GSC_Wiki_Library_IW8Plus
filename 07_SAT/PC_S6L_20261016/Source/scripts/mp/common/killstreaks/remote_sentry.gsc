// scripts\mp\common\killstreaks\remote_sentry.gsc  (hash_61bd5a088a2b6668.gscc) (size: 31894 Bytes / 0x7c96 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd16d74 (215051636)
// size ...... 31894 (0x7c96)
// includes .. 25  (offset: 0x7746)
// strings ... 74  (offset: 0x780e)
// dev strs .. 2   (offset: 0x7c7a)
// exports ... 72  (offset: 0x4d46)
// cseg ...... 0x5d9 + 0x476d (0x4d46)
// imports ... 259 (offset: 0x5886)
// animtree1 . 0   (offset: 0x7c96)
// animtree2 . 0   (offset: 0x7c96)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\inplaylimits;
#using scripts\common\killstreaks\killstreak_common;
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
#using scripts\mp\common\supers\combat_link;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\rank;

#namespace remote_sentry;

// Namespace remote_sentry
// Params 0, eflags: 0x1
// Checksum 0xf7c29865, Offset: 0x5f7
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "remote_turret" ), &remotesentryinit );
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0xada0fca1, Offset: 0x616
// Size: 0xf0
function private remotesentryinit()
{
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
    
    utility::registersharedfunc( #"remote_turret", #"hack", &remotesentry_hack );
    killstreak_utility::registervisibilityomnvarforkillstreak( "remote_turret", "on", 16 );
    val::group_register( "remoteSentryUse", [ "allow_movement", "usability", "killstreaks", "supers", "reload", "offhand_weapons", "melee" ] );
    killstreaks::registerkillstreak( "remote_turret", &function_e559d6e5b3295131 );
}

// Namespace remote_sentry
// Params 1
// Checksum 0xa448a52b, Offset: 0x70e
// Size: 0x14c, Type: bool
function function_e559d6e5b3295131( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = streakinfo.bundle;
    
    if ( !isdefined( streakinfo.weaponname ) )
    {
        streakinfo.weaponname = bundle.deployweapon;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    weaponobj = remotesentry_makeweapon( streakinfo );
    self.var_8ad9c553e7688ebe = weaponobj;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"watchforplacementfirestate" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]( streakinfo, endonnotify, weaponobj );
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, weaponobj, 1, undefined, undefined, &function_deb74d92b64f7940 );
    
    if ( !deployresult )
    {
        self notify( endonnotify );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            self notify( endonnotify );
            return false;
        }
    }
    
    if ( !remotesentry_carry( undefined, streakinfo, 0 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace remote_sentry
// Params 3, eflags: 0x4
// Checksum 0xccfaca2d, Offset: 0x863
// Size: 0x2d
function private function_deb74d92b64f7940( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace remote_sentry
// Params 3, eflags: 0x4
// Checksum 0xad8149b7, Offset: 0x898
// Size: 0x60e
function private remotesentry_create( streakinfo, marker, delayspawntime )
{
    turrettype = "remote_turret";
    bundle = streakinfo.bundle;
    config = level.sentrysettings[ turrettype ];
    remotesentryvehicletype = bundle.deployedvehicle;
    spawndata = { #owner:self, #angles:marker.angles, #targetname:remotesentryvehicletype, #vehicletype:remotesentryvehicletype, #origin:marker.location };
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !turret )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    turret.team = self.team;
    turret.teamfriendlyto = self.team;
    turret.owner = self;
    turret setotherent( turret.owner );
    turret setvehicleteam( turret.team );
    turret setnodeploy( 1 );
    turret.streakinfo = streakinfo;
    turret.turrettype = turrettype;
    turret.shouldsplash = 1;
    turret.timeout = config.timeout;
    turret.health = config.maxhealth;
    turret.maxhealth = config.maxhealth;
    turret setcandamage( 0 );
    turret vehicle_damage::function_f22ce6c0cf2d903b( turret );
    turret turret::function_fa954b6b6aadaec0();
    turret turret::function_2e0a246d12d5e047( &function_86e7325ca5372f3b );
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
    #/
    
    if ( !isdefined( turret.timeout ) )
    {
        turret.timeout = 120;
    }
    
    turret.maxtimeout = turret.timeout;
    turret setscriptablepartstate( "visibility", "hide" );
    turret function_ea149ac63ec7cfa6();
    turret emp_debuff::allow_emp( 0 );
    turretweapon = turret getturretweapon();
    
    if ( turretweapon )
    {
        killstreaks::registerkillstreakdamagedealingweapon( turret.streakinfo.streakname, turretweapon.basename, #"medium" );
    }
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        endtime = gettime() + int( turret.timeout * 1000 );
        turret thread killstreak_shared::function_585fb909f40d8659( endtime, bundle.alertfulllength, bundle.var_c3193942aa25f78, bundle.var_28e5801bce7f4815, bundle.var_b84c3eae995cb030, bundle.var_ed6c729701a7f3ed );
    }
    
    turret.killcament = spawn( "script_model", turret gettagorigin( "tag_flash" ) );
    turret.killcament namespace_9d8e359c3b1041e5::setscriptmoverkillcamsharedfunc( "turret" );
    killcamoffset = ( bundle.var_15869b5e2c380579 ?? 0, bundle.var_15869a5e2c380346 ?? 0, bundle.var_1586995e2c380113 ?? 0 );
    turret.killcament linkto( turret, "tag_flash", killcamoffset, ( 0, 0, 0 ) );
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( "wm_jup_2h_remote_turret_00_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    
    if ( bundle.var_d4395803edd6f6c6 )
    {
        turret.var_d4395803edd6f6c6 = bundle.var_d4395803edd6f6c6;
        turret.navbounds = createnavbadplacebyshape( turret.origin, turret.angles, 8, bundle.var_d4395803edd6f6c6, bundle.var_d4395803edd6f6c6 );
    }
    
    killstreak_utility::function_79acee879fb17c4a( self, turret.streakinfo.streakname );
    turret.var_30656af96b2ac2a4 = [];
    turret.add_buff = &remotesentry_add_buff;
    turret.remove_buff = &remotesentry_remove_buff;
    turret.marker = marker;
    bundle = streakinfo.bundle;
    
    if ( self.var_8ad9c553e7688ebe && self hasweapon( self.var_8ad9c553e7688ebe ) )
    {
        thread killstreak_utility::killstreak_switchbacklastweapon( self.var_8ad9c553e7688ebe, 1, 1 );
    }
    
    if ( delayspawntime )
    {
        turret thread manual_turret::manualturret_disablefire( self, delayspawntime, 1 );
        wait delayspawntime;
    }
    
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    
    if ( genericblueprintname )
    {
        turret setgenericblueprintmodel( genericblueprintname, #"gunmodel" );
    }
    
    callback::callback( "remote_sentry_deployed", { #player:self } );
    utility::function_969f9f5596dba07a( turret, &function_bbfc05b71454d823 );
    return turret;
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0xfcfbfeb, Offset: 0xeaf
// Size: 0x12
function private function_bbfc05b71454d823()
{
    self notify( #"kill_turret", 1, 0, 0 );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x977b17d5, Offset: 0xec9
// Size: 0x58
function private remotesentry_delayplacementinstructions( delaytime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"turret_placement_finished" );
    level endon( #"game_ended" );
    wait delaytime;
    self setclientomnvar( "ui_turret_placement", 1 );
    thread manual_turret::manualturret_clearplacementinstructions( "death" );
    thread manual_turret::manualturret_clearplacementinstructions( "turret_placement_finished" );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xde12c1ae, Offset: 0xf29
// Size: 0x266
function private remotesentry_add_buff( params )
{
    if ( !isarray( self.var_30656af96b2ac2a4 ) )
    {
        return;
    }
    
    self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
    
    if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
    {
        basepoints = rank::getscoreinfovalue( #"hash_1871d75d82d51f83" ) ?? 0;
        params.combatlink.owner thread points::doscoreevent( #"hash_1871d75d82d51f83", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
        
        if ( !isdefined( self.var_2695e71ddf32816c ) )
        {
            self.var_2695e71ddf32816c = [];
        }
        
        self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
    }
    
    if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
    {
        self.owner thread points::doscoreevent( #"hash_16c0af7021e4a987", params.combatlink.weapon_object );
        self.var_2b2f786d6b12c032 = 1;
    }
    
    if ( self.var_30656af96b2ac2a4.size == 1 )
    {
        buffedheadicon = self.streakinfo.bundle.buffedheadicon;
        
        if ( isdefined( self.headiconid ) && isdefined( buffedheadicon ) )
        {
            setheadiconimage( self.headiconid, buffedheadicon, 1 );
        }
        
        self.var_9e87e3028beb60bf = params.bundle.var_114136d1aa809113 ?? undefined;
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

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x9d1fe670, Offset: 0x1197
// Size: 0x12f
function private remotesentry_remove_buff( params )
{
    if ( !isarray( self.var_30656af96b2ac2a4 ) )
    {
        return;
    }
    
    if ( !arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
    {
        return;
    }
    
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

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x29af9cc, Offset: 0x12ce
// Size: 0x8dd
function private remotesentry_place( turret )
{
    bundle = turret.streakinfo.bundle;
    config = level.sentrysettings[ turret.turrettype ];
    turret.empapplycallback = &remotesentry_empstarted;
    turret.empremovecallback = &function_fc508e0a096d98de;
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempapplycallback = &function_cfe9b3f826055561;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempclearcallback = &function_21e9882916884fd8;
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", turret, &function_7748ccbc38b51c5c, &function_f7cc17031651deb2 );
    
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
        
        if ( isdefined( turret.moving_platform.vehicletype ) )
        {
            turret linkto( turret.moving_platform );
        }
    }
    
    turret vehicle_teleport( marker.location, marker.angles, 0 );
    turret setturrettargetlocalangles( marker.angles, 0, 1 );
    turret clearturrettarget();
    turret setscriptablepartstate( "turret_carry_state", "turret_plant" );
    turret setscriptablepartstate( #"lights", #"blinking" );
    turret laseron();
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret );
    turret function_265731cb2481d161();
    self.placedsentries[ turret.turrettype ] = function_5713d46873b29625( self.placedsentries[ turret.turrettype ] );
    turretcount = self.placedsentries[ turret.turrettype ].size;
    
    if ( turretcount + 1 > inplaylimits::get_limit_per_player( bundle ) )
    {
        self.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo.streakname, "Killstreak_Ground", self, 0, 1, undefined, "carried" );
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
    
    turret function_9d022c4d2d0bb594();
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = &function_ace5cacee4867b11;
        data.validateaccuratetouching = 1;
        var_756db33d31c779b9 = self getcurrentweapon();
        deployablebounds = var_756db33d31c779b9 function_11cf642482e762bc();
        
        if ( deployablebounds )
        {
            data.var_222269e8fc78589a = 1;
            surfaceclearance = 1.125;
            var_f8d962eedd0b6eb2 = 2.5;
            cylinderradius = deployablebounds.var_79ac3e3bfe82e755 - var_f8d962eedd0b6eb2;
            cylinderheight = deployablebounds.var_5e0312e37bd104d8;
            data.custommidpoint = ( 0, 0, cylinderheight / 2 + surfaceclearance );
            data.customhalfsize = ( cylinderradius, cylinderradius, cylinderheight / 2 );
            
            /#
                if ( getdvarint( @"deploy_debug", 0 ) == 1 )
                {
                    start = marker.location + ( 0, 0, surfaceclearance );
                    end = start + ( 0, 0, cylinderheight );
                    cylinder( start, end, cylinderradius, ( 1, 0, 0 ), 0, 300 );
                    start = marker.location + ( 0, 0, surfaceclearance + cylinderradius );
                    end = start + ( 0, 0, cylinderheight - 2 * cylinderradius );
                    capsule( start, end, cylinderradius, ( 0, 1, 0 ), 0, 300 );
                }
            #/
        }
        
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
    thread remotesentry_delaydeletemarker( turret, marker );
    thread remotesentry_watchpickup( turret );
    thread remotesentry_disableplayeruseonconnect( turret, turret.useownerobj );
    thread function_4d05f7d52ba288ba( turret );
    turret thread function_cd6ff74a61ee19c7( self );
    turret remotesentry_setupdamagefunctionality( turret.streakinfo.streakname );
    thread function_69036a8cc55f332d( turret );
    thread remotesentry_watchtimeout( turret );
    thread remotesentry_watchdisown( turret );
    thread remotesentry_watchgameend( turret );
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        thread remotesentry_watchcancel( turret );
    }
    
    turret utility::ent_flag_set( "remote_sentry_deployed" );
    turret function_9f739b64acffa467( turret );
    self.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"munitionused" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    turret notify( #"hash_db521cf8a268eb0a" );
    self notify( #"owner_place_successful" );
}

// Namespace remote_sentry
// Params 0
// Checksum 0x99f8fdb2, Offset: 0x1bb3
// Size: 0x90
function function_9d022c4d2d0bb594()
{
    bundle = self.streakinfo.bundle;
    
    if ( bundle.var_f0d26d16d3b38e1 )
    {
        killstreak_utility::function_79acee879fb17c4a( self.owner, self.streakinfo.streakname );
        killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, &"killstreaks_hints/remote_turret_use", #"remote_control", 1 );
        thread function_5cd5474cf917c525();
    }
}

// Namespace remote_sentry
// Params 1
// Checksum 0x18c60655, Offset: 0x1c4b
// Size: 0xae
function remotesentry_setupdamagefunctionality( streakname )
{
    killstreakvehicle = self;
    scorepopup = "destroyed_" + streakname;
    vodestroyed = "destroyed_" + streakname;
    destroyedsplash = "callout_destroyed_" + streakname;
    premoddamagecallback = &function_932ac76fd6d9a701;
    deathcallback = &remotesentry_handledeathdamage;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, undefined, undefined, premoddamagecallback, undefined, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
    vehicle_occupancy::register_instance( self );
}

// Namespace remote_sentry
// Params 1
// Checksum 0x11f72889, Offset: 0x1d01
// Size: 0x130, Type: bool
function function_932ac76fd6d9a701( data )
{
    if ( data.meansofdeath == "MOD_TRIGGER_HURT" )
    {
        return false;
    }
    
    if ( !self.damagedstate && self.health < self.maxhealth * 0.5 )
    {
        self.damagedstate = 1;
        self setscriptablepartstate( #"turret_damage", #"on", 0 );
    }
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = self.streakinfo.bundle;
        data.iskillstreak = 1;
        data.damage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    
    return true;
}

// Namespace remote_sentry
// Params 1
// Checksum 0x35203e9c, Offset: 0x1e3a
// Size: 0x46, Type: bool
function remotesentry_handledeathdamage( data )
{
    if ( data.meansofdeath == "MOD_CRUSH" )
    {
        self notify( #"kill_turret", 1, 0, 0 );
    }
    else
    {
        self notify( #"kill_turret", 0, 1, 0, 0 );
    }
    
    return true;
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x109cc93f, Offset: 0x1e89
// Size: 0x1f2
function private function_5cd5474cf917c525()
{
    self notify( #"end_remote_monitor" );
    level endon( #"game_ended" );
    self endon( #"end_remote_monitor" );
    self endon( #"death" );
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"turret_hacked" );
    self.useobj endon( #"death" );
    self.useobj enableplayeruse( self.owner );
    self.useobj.activeuseobject = 1;
    self.useobj setuseholdduration( 500 );
    useobjdisabled = 0;
    
    while ( true )
    {
        if ( useobjdisabled )
        {
            if ( !self.owner utility::isusingremote() && !self.remotecontrolled || self.owner == level.flagcarrier )
            {
                wait 1;
            }
            
            if ( !self.owner utility::isusingremote() && !self.var_7568cab78e4268cc && !self.remotecontrolled && self.owner != level.flagcarrier )
            {
                self.useobj enableplayeruse( self.owner );
                self.useobj.activeuseobject = 1;
                useobjdisabled = 0;
            }
        }
        else if ( self.owner utility::isusingremote() || self.remotecontrolled || self.var_7568cab78e4268cc || self.owner == level.flagcarrier )
        {
            self.useobj disableplayeruse( self.owner );
            self.useobj.activeuseobject = 0;
            useobjdisabled = 1;
        }
        
        wait 0.1;
    }
}

// Namespace remote_sentry
// Params 2, eflags: 0xc
// Checksum 0x5b63f082, Offset: 0x2083
// Size: 0x157
function private function_4d05f7d52ba288ba( turret, delaysec )
{
    self notify( #"hash_5942c8488f2d8156" );
    self endon( #"hash_5942c8488f2d8156" );
    self endon( #"remote_sentry_empd" );
    turret endon( #"remote_sentry_death" );
    turret endon( #"hash_8f6592a5e1e74937" );
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    
    if ( !turret.streakinfo.bundle.var_f0d26d16d3b38e1 )
    {
        return;
    }
    
    if ( delaysec )
    {
        wait delaysec;
    }
    
    while ( true )
    {
        if ( !isdefined( turret.useobj ) )
        {
            break;
        }
        
        turret.useobj waittill( #"trigger", player );
        
        if ( turret.var_b36da400d4dde102 || !function_6f45a22d69a59333() )
        {
            continue;
        }
        
        function_aba93c7a1d973398( turret );
        
        if ( turret.var_b36da400d4dde102 || !function_6f45a22d69a59333() )
        {
            function_2e7a90e8ac2489bd( turret );
            turret remotesentry_activate();
            continue;
        }
        
        function_59bb7310fdba63d7( turret );
        thread function_aacfd2fbd4ffbe9a( turret );
        turret waittill( #"remote_control_stopped" );
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x672dd7c4, Offset: 0x21e2
// Size: 0xb6
function private function_7e1070b9edc1d56c( turret )
{
    turret endon( #"remote_sentry_death" );
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    self endon( #"end_remote_monitor" );
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    currentfov = self playerads();
    self setclientomnvar( "ui_killstreak_zoom_percentage", currentfov );
    
    while ( true )
    {
        if ( self playerads() != currentfov )
        {
            currentfov = self playerads();
            self setclientomnvar( "ui_killstreak_zoom_percentage", currentfov );
        }
        
        waitframe();
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x5a593e2f, Offset: 0x22a0
// Size: 0xd6
function private function_fc87adc3374cc9b3( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( streakinfo.streakname );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x319ca077, Offset: 0x237e
// Size: 0x54
function private function_59bb7310fdba63d7( turret )
{
    turret setturretscriptcontrolled( 0, 0 );
    self.restoreangles = self getplayerangles();
    self usevehicle( turret, 0, 0 );
    killstreak_shared::function_a402a9f43d6f7512( "killstreak_remote_turret" );
    thread function_fc87adc3374cc9b3( turret.streakinfo );
    thread function_7e1070b9edc1d56c( turret );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x96bc5654, Offset: 0x23da
// Size: 0x125
function private function_aba93c7a1d973398( turret )
{
    self disableweaponswitch();
    turret.remotecontrolled = 1;
    val::group_set( "remoteSentryUse", 0 );
    self notify( #"using_remote" );
    turret setscriptablepartstate( "turret_mode", "turret_mode_pre_manual" );
    turret laseroff();
    turret turret::function_9a0fa09f3acbc0cd();
    player::setusingremote( "remote_turret", 1, 1 );
    thread function_5a5f920c8117d461( turret );
    killstreak_utility::function_7ab4bfe11ada17a( turret.streakinfo.bundle );
    thread remotesentry_deploytablet( turret );
    self waittill( #"remotesentry_deploytabletfinished" );
    thread function_797ca6996adcfe22( turret );
    self waittill( #"hash_7e67061db4b45f79" );
    killstreak_shared::function_7ef9535e2b5c605b();
    ai::set_ignoreme( 1 );
    turret notify( #"remote_enter" );
    
    if ( self.isjuggernaut )
    {
        self notify( #"remote_enter" );
    }
    
    turret setscriptablepartstate( "turret_mode", "turret_mode_manual" );
    turret setscriptablepartstate( #"lights", #"steady", 0 );
    turret remotesentry_applyoverlay( self );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x2e756e94, Offset: 0x2507
// Size: 0xe1
function private function_5a5f920c8117d461( turret )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    hasendedearly = 0;
    result = utility::waittill_any_ents_return( self, "remoteSentry_deployTabletFinished", self, "remote_sentry_empd", turret, "remote_sentry_death", turret, "kill_turret", turret, "carried" );
    hasendedearly = result != "remoteSentry_deployTabletFinished";
    
    while ( true )
    {
        result = utility::waittill_any_ents_return( self, "remote_sentry_empd", turret, "remote_sentry_death", turret, "kill_turret", turret, "carried" );
        
        if ( !isdefined( result ) )
        {
            break;
        }
    }
    
    if ( !hasendedearly )
    {
        self waittill( #"hash_7e67061db4b45f79", issuccess );
        hasendedearly = !issuccess;
    }
    
    if ( hasendedearly )
    {
        killstreak_shared::function_7ef9535e2b5c605b();
        function_2e7a90e8ac2489bd( turret );
        turret remotesentry_activate();
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xc9060c01, Offset: 0x25f0
// Size: 0xe3
function private remotesentry_deploytablet( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"remote_sentry_death" );
    weaponobj = makeweapon( turret.streakinfo.bundle.deployweaponname );
    inventory_utility::_giveweapon( weaponobj, 0, 0, 1 );
    turret.tabletweaponobj = weaponobj;
    switchresult = inventory_utility::domonitoredweaponswitch( weaponobj, 0 );
    killstreak_shared::starttabletscreen( turret.streakinfo.streakname, 0 );
    killstreak_shared::function_7ef9535e2b5c605b();
    animtime = turret.streakinfo.bundle.var_d713806427672cd5;
    wait animtime;
    self notify( #"remotesentry_deploytabletfinished" );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x3fa95ea6, Offset: 0x26db
// Size: 0x208
function private function_797ca6996adcfe22( turret )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = turret.streakinfo.bundle;
    turretmodepartstate = turret getscriptablepartstate( "turret_mode" );
    
    if ( turretmodepartstate == "turret_mode_manual" )
    {
        if ( bundle.var_d30c20664d0c31fd )
        {
            turret setscriptablepartstate( "turret_mode_fade", "turret_mode_manualtosentry_fadestart" );
            thread killstreak_utility::function_7018f59706013760( bundle );
        }
        else
        {
            fullscreenfxparams = { #postfxbundlename:turret.streakinfo.bundle.var_41dccf5a25ce2c0d };
            self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
            self playlocalsound( bundle.var_d09f98defa2e28d1 );
        }
    }
    else if ( bundle.var_8b43cd747014ec7e )
    {
        turret setscriptablepartstate( "turret_mode_fade", "turret_mode_sentrytomanual_fadestart" );
        thread killstreak_utility::function_d0d9fe7a213e3bd3( bundle );
    }
    else
    {
        fullscreenfxparams = { #postfxbundlename:turret.streakinfo.bundle.var_41dccf5a25ce2c0d };
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
    }
    
    statictime = turret.streakinfo.bundle.var_beb8a30649fee52e;
    result = utility::waittill_any_ents_or_timeout_return( statictime, self, "remote_sentry_empd", turret, "remote_sentry_death", self, "death", turret, "kill_turret", turret, "carried" );
    issuccess = result == "timeout";
    
    if ( !issuccess )
    {
        turret utility::function_7c10ea82c1e305b8( "turret_mode_fade", "turret_mode_sentrytomanual_fadeinterrupted" );
    }
    
    self notify( #"hash_7e67061db4b45f79", issuccess );
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x5cd0812f, Offset: 0x28eb
// Size: 0x8c, Type: bool
function private function_6f45a22d69a59333()
{
    if ( self isswimming() || self.vehicle || self isjumping() || self isinfreefall() || self ishanging() || self isparachuting() || self == level.flagcarrier )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"showerrormessage" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( %"killstreaks/remote_turret_not_available" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x6e960a6a, Offset: 0x2980
// Size: 0x4d
function private function_2e7a90e8ac2489bd( turret )
{
    if ( turret.remotecontrolled && utility::isusingremote() )
    {
        turret remotesentry_removeoverlay( self );
        thread function_797ca6996adcfe22( turret );
        self waittill( #"hash_7e67061db4b45f79" );
        function_9c9516e3b10840bf( turret );
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x6d2d153b, Offset: 0x29d5
// Size: 0x11f
function private function_9c9516e3b10840bf( turret )
{
    if ( self isvehicleactive() )
    {
        self leavevehicle( 0, 1 );
    }
    
    killstreak_shared::function_b3302c4317df36c6();
    val::group_reset( "remoteSentryUse" );
    
    if ( utility::isusingremote() )
    {
        utility::delaycall( 0.5, &player::clearusingremote );
        
        if ( self.restoreangles )
        {
            self setplayerangles( self.restoreangles );
        }
    }
    
    ai::set_ignoreme( 0 );
    turret.remotecontrolled = 0;
    self notify( #"remote_exit" );
    function_9f739b64acffa467( turret );
    currentweapon = self getcurrentweapon().basename;
    
    if ( !turret.var_b36da400d4dde102 && currentweapon == turret.streakinfo.bundle.deployweaponname )
    {
        inventory_utility::_switchtoweapon( self.primaryweaponobj );
    }
    
    self enableweaponswitch();
    
    if ( turret.tabletweaponobj )
    {
        self takeweapon( turret.tabletweaponobj );
        turret.tabletweaponobj = undefined;
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x9b88e79e, Offset: 0x2afc
// Size: 0xa6
function private function_aacfd2fbd4ffbe9a( turret )
{
    self endon( #"remote_sentry_empd" );
    turret endon( #"remote_sentry_death" );
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    thread function_1d043bc4ed7c4d7( turret, 0.75 );
    self waittill( #"hash_597999d7b5a801e2" );
    
    /#
        if ( getdvarint( @"hash_50428b6121856c35", 0 ) == 1 )
        {
            thread function_21d9ce0a9129d691( turret );
        }
    #/
    
    function_2e7a90e8ac2489bd( turret );
    turret remotesentry_activate();
    turret notify( #"remote_control_stopped" );
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0xf808ac95, Offset: 0x2baa
// Size: 0x114
function private function_1d043bc4ed7c4d7( turret, holdtime )
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

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x7f8099d1, Offset: 0x2cc6
// Size: 0x260
function private function_696860ae66931b75( turret )
{
    turret setcandamage( 0 );
    turret.useownerobj setusableenabled( 0 );
    turret remotesentry_setinactive();
    turret.owner.placedsentries[ turret.turrettype ] = arrayremove( turret.owner.placedsentries[ turret.turrettype ], turret );
    turret notify( #"hash_6216eaad644762d1" );
    
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
    
    turret function_ea149ac63ec7cfa6();
    turret.colmodel unlink();
    turret.colmodel hide();
    turret setscriptablepartstate( "visibility", "hide" );
    killstreak_utility::function_79acee879fb17c4a( self, turret.streakinfo.streakname );
    turret.carriedby = self;
    self playsound( "kls_remote_sentry_pickup" );
    turret setscriptablepartstate( "turret_carry_state", "turret_pickup" );
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"weapons" ][ #"watchforplacementfirestate" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo, endonnotify );
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x9b900709, Offset: 0x2f2e
// Size: 0x57
function private function_355a77e663dee38c( streakinfo )
{
    self endon( #"owner_place_successful", #"hash_a202550ef980503c" );
    level endon( #"game_ended" );
    self waittill( #"death_or_disconnect" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace remote_sentry
// Params 3, eflags: 0x4
// Checksum 0x9448439e, Offset: 0x2f8d
// Size: 0x1d3, Type: bool
function private remotesentry_carry( turret, streakinfo, var_ff3ad3c9d65b87ae )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    currenttimeout = turret.timeout;
    var_a898324c17b11e35 = 0;
    
    if ( turret )
    {
        var_a898324c17b11e35 = 1;
        turret notify( #"carried" );
        damagedstate = turret.damagedstate;
        timeoutoverride = turret.timeout;
        var_c80787b925cce664 = turret.health;
        thread function_355a77e663dee38c( turret.streakinfo );
        turret function_f108038fb05a40fc();
        turret remotesentry_delete();
    }
    
    thread remotesentry_delayplacementinstructions( 2 );
    val::set( "remote_sentry", "ladder", 0 );
    marker = function_f0d1001c1e9ffc70( streakinfo, var_ff3ad3c9d65b87ae );
    
    if ( !marker )
    {
        if ( var_a898324c17b11e35 )
        {
            function_95b32ff814285b8( streakinfo );
        }
        
        val::reset( "remote_sentry", "ladder" );
        return false;
    }
    
    turret = remotesentry_create( streakinfo, marker, 0.85 );
    
    if ( !turret )
    {
        assertmsg( "<dev string:x24>" );
        
        if ( var_a898324c17b11e35 )
        {
            function_95b32ff814285b8( streakinfo );
        }
        
        return false;
    }
    
    if ( damagedstate )
    {
        turret.damagedstate = 1;
        turret setscriptablepartstate( "turret_damage", "on", 0 );
    }
    
    if ( timeoutoverride )
    {
        turret.timeout = timeoutoverride;
    }
    
    if ( var_c80787b925cce664 )
    {
        turret.health = var_c80787b925cce664;
    }
    
    if ( currenttimeout )
    {
        turret.timeout = currenttimeout;
    }
    
    remotesentry_place( turret );
    val::reset( "remote_sentry", "ladder" );
    return true;
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x2951785c, Offset: 0x3169
// Size: 0x35
function private function_95b32ff814285b8( streakinfo )
{
    self notify( #"hash_a202550ef980503c" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0xc3a5ec9b, Offset: 0x31a6
// Size: 0x10f
function private function_f0d1001c1e9ffc70( streakinfo, var_ff3ad3c9d65b87ae )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"watchforplayerenteringlaststand" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]();
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"gettargetmarker" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        marker = self [[ var_32dbca3143d9c4a5 ]]( streakinfo, var_ff3ad3c9d65b87ae );
    }
    else
    {
        marker = undefined;
    }
    
    self notify( #"turret_placement_finished" );
    
    if ( marker.string == "equip_deploy_end" || marker.string == "equip_deploy_cancel" )
    {
        if ( player::isreallyalive() && self.var_8ad9c553e7688ebe && self hasweapon( self.var_8ad9c553e7688ebe ) )
        {
            killstreak_utility::killstreak_switchbacklastweapon( self.var_8ad9c553e7688ebe );
        }
        
        return;
    }
    
    assert( marker.location, "<dev string:x43>" );
    return marker;
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x3dada6a1, Offset: 0x32be
// Size: 0x39
function private remotesentry_setinactive()
{
    turret = self;
    turret turret::function_9a0fa09f3acbc0cd();
    turret.useownerobj setusableenabled( 0 );
    turret.useownerobj unlink();
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0xa4abdb68, Offset: 0x32ff
// Size: 0x52
function private remotesentry_delaydeletemarker( turret, marker )
{
    turret endon( #"kill_turret" );
    level endon( #"game_ended" );
    wait 0.25;
    
    if ( marker.visual )
    {
        marker.visual delete();
    }
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0x2c8b8a09, Offset: 0x3359
// Size: 0x82
function private remotesentry_disableplayeruseonconnect( turret, useobj )
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

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xe5be163b, Offset: 0x33e3
// Size: 0xf7
function private remotesentry_watchpickup( turret )
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
        
        if ( player remotesentry_canpickup( turret ) )
        {
            weaponobj = remotesentry_makeweapon( turret.streakinfo );
            inventory_utility::_giveweapon( weaponobj );
            self.var_8ad9c553e7688ebe = weaponobj;
            switchsuccess = inventory_utility::domonitoredweaponswitch( weaponobj, 1 );
            
            if ( switchsuccess )
            {
                function_696860ae66931b75( turret );
                thread remotesentry_carry( turret, turret.streakinfo, 1 );
            }
        }
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xca288b6b, Offset: 0x34e2
// Size: 0x9e, Type: bool
function private remotesentry_canpickup( turret )
{
    player = self;
    
    if ( player != turret.owner || self.ishaywire || turret emp_debuff::is_empd() || self.var_7568cab78e4268cc || self.insertingarmorplate )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"remote_turret", #"allowpickupofturret" ) )
    {
        if ( !player [[ utility::getsharedfunc( #"remote_turret", #"allowpickupofturret" ) ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0xb9c84ad9, Offset: 0x3589
// Size: 0x87
function private remotesentry_disable()
{
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 0;
    }
    
    self.var_7568cab78e4268cc++;
    
    if ( self.var_7568cab78e4268cc == 1 )
    {
        self.owner notify( #"remote_sentry_empd" );
        
        if ( self.owner.usingremote == "remote_turret" && self.remotecontrolled )
        {
            self.owner thread function_2e7a90e8ac2489bd( self );
        }
        
        function_9f739b64acffa467( self );
    }
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x62be93bc, Offset: 0x3618
// Size: 0x4a
function private remotesentry_enable()
{
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 1;
    }
    
    self.var_7568cab78e4268cc--;
    
    if ( self.var_7568cab78e4268cc == 0 )
    {
        function_9f739b64acffa467( self );
        self.owner thread function_4d05f7d52ba288ba( self );
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x37f06c2c, Offset: 0x366a
// Size: 0xb1
function private function_9f739b64acffa467( jammedremotesentry )
{
    if ( jammedremotesentry.var_7568cab78e4268cc )
    {
        jammedremotesentry turret::function_9a0fa09f3acbc0cd();
        jammedremotesentry setscriptablepartstate( "empd", "on" );
        jammedremotesentry laseroff();
        
        if ( jammedremotesentry.useownerobj )
        {
            jammedremotesentry.useownerobj disableplayeruse( jammedremotesentry.owner );
        }
        
        return;
    }
    
    jammedremotesentry remotesentry_activate();
    jammedremotesentry setscriptablepartstate( "empd", "off" );
    jammedremotesentry laseron();
    
    if ( jammedremotesentry.useownerobj )
    {
        jammedremotesentry.useownerobj enableplayeruse( jammedremotesentry.owner );
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xdea9962c, Offset: 0x3723
// Size: 0x15
function private function_7748ccbc38b51c5c( jammedremotesentry )
{
    jammedremotesentry remotesentry_disable();
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x2f1b370e, Offset: 0x3740
// Size: 0x15
function private function_f7cc17031651deb2( jammedremotesentry )
{
    jammedremotesentry remotesentry_enable();
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xb6c1f2b5, Offset: 0x375d
// Size: 0xc0
function private remotesentry_empstarted( data )
{
    if ( data.attacker )
    {
        scoreevent = self.streakinfo.bundle.empedscoreevent ?? #"disabled_sentry_gun";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            data.attacker thread [[ var_32dbca3143d9c4a5 ]]( scoreevent );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"empstarted" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]();
        }
    }
    
    remotesentry_disable();
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xdb05d179, Offset: 0x3825
// Size: 0x4e
function private function_fc508e0a096d98de( isdeath )
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
    
    remotesentry_enable();
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xc034da4f, Offset: 0x387b
// Size: 0xdb
function private function_cfe9b3f826055561( data )
{
    turret = self;
    
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
            turret [[ var_32dbca3143d9c4a5 ]]();
        }
    }
    
    turret.owner notify( #"hash_e22e68cb2672e26e" );
    turret.owner notify( #"remote_sentry_empd" );
    turret setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x15f96473, Offset: 0x395e
// Size: 0x41
function private function_21e9882916884fd8( data )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"remote_turret" ][ #"empcleared" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0xbe837249, Offset: 0x39a7
// Size: 0x14, Type: bool
function private function_445cc3de92054258()
{
    return !player::isreallyalive() || player::isinlaststand( self );
}

// Namespace remote_sentry
// Params 1, eflags: 0xc
// Checksum 0x8802e091, Offset: 0x39c4
// Size: 0xae
function private function_cd6ff74a61ee19c7( owner )
{
    self notify( #"hash_fc07be9b6350b398" );
    self endon( #"hash_fc07be9b6350b398" );
    turret = self;
    turret endon( #"death" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    
    while ( true )
    {
        var_c3bb3c0be331bbf3 = owner function_445cc3de92054258();
        
        if ( turret.var_b36da400d4dde102 && !var_c3bb3c0be331bbf3 )
        {
            turret.var_b36da400d4dde102 = undefined;
        }
        else if ( var_c3bb3c0be331bbf3 )
        {
            turret.var_b36da400d4dde102 = 1;
        }
        
        wait 0.1;
    }
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xedae6848, Offset: 0x3a7a
// Size: 0xf6
function private remotesentry_delete( delay )
{
    turret = self;
    turret utility::ent_flag_clear( "remote_sentry_deployed" );
    
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
    
    if ( isdefined( turret.navbounds ) )
    {
        destroynavobstacle( turret.navbounds );
        turret.navbounds = undefined;
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

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x751dc398, Offset: 0x3b78
// Size: 0x51
function private function_f108038fb05a40fc()
{
    turret = self;
    owner = turret.owner;
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", owner );
    turret remotesentry_setinactive();
    turret function_ea149ac63ec7cfa6();
}

// Namespace remote_sentry
// Params 4, eflags: 0x4
// Checksum 0xd9251ed8, Offset: 0x3bd1
// Size: 0x230
function private function_4f98807f2ff4bc41( skipshutdown, wasdestroyed, wascancelled, var_d8d5272b051a15ee = 0 )
{
    turret = self;
    owner = turret.owner;
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", owner );
    owner function_2e7a90e8ac2489bd( turret );
    
    if ( owner )
    {
        turret remotesentry_setinactive();
        
        if ( !turret.var_a634fe6f7264e95d )
        {
            turret.streakinfo.expiredbydeath = istrue( wasdestroyed );
            owner killstreak_utility::recordkillstreakendstats( turret.streakinfo );
        }
        
        ownerturrets = owner.placedsentries[ turret.turrettype ];
        ownerturrets = arrayremove( ownerturrets, turret );
        
        if ( self.useobj )
        {
            prevturret = ownerturrets[ ownerturrets.size - 1 ];
            
            if ( prevturret )
            {
                prevturret function_9d022c4d2d0bb594();
                owner thread function_4d05f7d52ba288ba( prevturret );
            }
        }
    }
    
    if ( wasdestroyed && !turret.var_a634fe6f7264e95d )
    {
        owner killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_destroyed", #"destroyed" );
    }
    
    turret.var_c3c4d711e69d5ab9 = 1;
    
    if ( !skipshutdown )
    {
        turret setscriptablepartstate( "shutdown", "on" );
        turret setscriptablepartstate( "turret_carry_state", "off" );
        turret setcandamage( 0 );
        wait 2;
        turret setscriptablepartstate( "explode", "regular" );
    }
    else if ( !wascancelled )
    {
        var_8a191f37d248ee77 = var_d8d5272b051a15ee ? "regular" : "violent";
        turret setscriptablepartstate( "explode", var_8a191f37d248ee77 );
    }
    
    if ( !turret.var_a634fe6f7264e95d )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:turret.streakinfo } );
    }
    
    turret function_ea149ac63ec7cfa6();
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x1fc9a340, Offset: 0x3e09
// Size: 0xc0
function private function_69036a8cc55f332d( turret )
{
    turret notify( #"hash_6acbda542969337b" );
    turret endon( #"carried", #"turret_hacked", #"hash_6acbda542969337b" );
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed, wascancelled, var_d8d5272b051a15ee );
    turret notify( #"remote_sentry_death" );
    turret notify( #"death" );
    turret function_4f98807f2ff4bc41( skipshutdown, wasdestroyed, wascancelled, var_d8d5272b051a15ee );
    delay = skipshutdown && wascancelled ? 0 : 0.2;
    turret remotesentry_delete( delay );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xe0d75e8f, Offset: 0x3ed1
// Size: 0x1d
function private function_ace5cacee4867b11( data )
{
    self notify( #"kill_turret", 1, 1, 0 );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x1f949948, Offset: 0x3ef6
// Size: 0x160
function private remotesentry_watchtimeout( turret )
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
    
    var_f1d0df94595a00fa = gettime();
    
    while ( turret.timeout > 0 )
    {
        var_4c5d15cdeda35583 = gettime() - var_f1d0df94595a00fa;
        turret.timeout -= var_4c5d15cdeda35583 * 0.001;
        var_21622e853a32f8a4 = turret.timeout / turret.maxtimeout;
        
        if ( self.usingremote == "remote_turret" && turret.remotecontrolled )
        {
            self setclientomnvar( "ui_killstreak_lifetime", var_21622e853a32f8a4 );
            self setclientomnvar( "ui_killstreak_countdown", int( 100 * var_21622e853a32f8a4 ) );
        }
        
        var_f1d0df94595a00fa = gettime();
        waitframe();
    }
    
    killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_timeout", #"leave" );
    turret notify( #"kill_turret", 0, 0, 0 );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x9b2dc16d, Offset: 0x405e
// Size: 0x59
function private remotesentry_watchdisown( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    turret notify( #"kill_turret", 0, 0, 0 );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x93c48317, Offset: 0x40bf
// Size: 0x52
function private remotesentry_watchcancel( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"turret_hacked" );
    self waittill( #"killstreak_cancel" );
    turret notify( #"kill_turret", 1, 0, 1 );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xc69f95ab, Offset: 0x4119
// Size: 0x9b
function private remotesentry_watchgameend( turret )
{
    turret endon( #"kill_turret", #"carried", #"turret_hacked" );
    level waittill( #"game_ended" );
    
    if ( self && turret.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo );
        }
    }
    
    turret notify( #"kill_turret", 0, 0, 0 );
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x5d8a666a, Offset: 0x41bc
// Size: 0x135
function private function_bf0563f900b114ec()
{
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"remote_enter" );
    self.owner endon( #"remote_sentry_empd" );
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
                    self setscriptablepartstate( #"lights", #"steady" );
                }
            }
        }
        else if ( var_96cbbf3eaeaca85e && !var_af21fdaa241f1b3f )
        {
            self setscriptablepartstate( "turret_target_found", "off" );
            self setscriptablepartstate( #"lights", #"blinking" );
        }
        
        var_96cbbf3eaeaca85e = var_af21fdaa241f1b3f;
        wait updateinterval;
    }
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0xf9457275, Offset: 0x42f9
// Size: 0x3a
function private remotesentry_activate()
{
    if ( isalive( self ) )
    {
        thread function_bf0563f900b114ec();
        self setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
        self setscriptablepartstate( #"lights", #"blinking", 0 );
    }
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0x996e6424, Offset: 0x433b
// Size: 0x10f, Type: bool
function private function_86e7325ca5372f3b( target, turretindex )
{
    if ( isplayer( target ) )
    {
        if ( isdefined( target.perks[ "specialty_blindeye" ] ) )
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
    
    if ( isagent( target ) && !target val::get( "damage" ) )
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

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x875d069a, Offset: 0x4453
// Size: 0xa
function private function_265731cb2481d161()
{
    vehicle_compass::vehicle_show( self );
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0x11b900b7, Offset: 0x4465
// Size: 0xa
function private function_ea149ac63ec7cfa6()
{
    vehicle_compass::vehicle_hide( self );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x53edd840, Offset: 0x4477
// Size: 0x3a
function private remotesentry_applyoverlay( player )
{
    player killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "on" );
    player setclientomnvar( "ui_killstreak_health", 0 );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0x53bab17f, Offset: 0x44b9
// Size: 0x2d
function private remotesentry_removeoverlay( player )
{
    player killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0xb0b17542, Offset: 0x44ee
// Size: 0x3a
function private remotesentry_hack( hackeffect, attacker )
{
    if ( hackeffect.var_30e7de3d76d5a085 )
    {
        thread function_752252f558382ae5( hackeffect, attacker );
        return;
    }
    
    thread function_f780a5ba5b51ca67( hackeffect, attacker );
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0x25080579, Offset: 0x4530
// Size: 0xe2
function private function_f780a5ba5b51ca67( hackeffect, attacker )
{
    turret = self;
    turret endon( #"death_or_disconnect" );
    turret endon( #"game_ended" );
    turret endon( #"turret_hacked" );
    self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"disrupted_hacked" );
    turret.empcount = turret.empcount ? turret.empcount + 1 : 1;
    turret remotesentry_disable();
    turret function_cfe9b3f826055561( undefined );
    turret.useownerobj disableplayeruse( turret.owner );
    wait hackeffect.hackduration * 0.001;
    turret function_b374d0914d7c440();
}

// Namespace remote_sentry
// Params 0, eflags: 0x4
// Checksum 0xa90ee132, Offset: 0x461a
// Size: 0x6e
function private function_b374d0914d7c440()
{
    turret = self;
    
    if ( turret emp_debuff::is_empd() )
    {
        turret.empcount--;
        
        if ( turret.empcount <= 0 && isalive( turret ) )
        {
            turret remotesentry_enable();
            turret function_21e9882916884fd8( undefined );
            turret.useownerobj enableplayeruse( turret.owner );
        }
    }
}

// Namespace remote_sentry
// Params 2, eflags: 0x4
// Checksum 0xda08771, Offset: 0x4690
// Size: 0x5c3
function private function_752252f558382ae5( hackeffect, attacker )
{
    turret = self;
    oldowner = turret.owner;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    turret utility::callsharedfunc( #"killstreak", #"removefromactivekillstreaklist", turret.entnum ?? utility::get_entity_number( turret ) );
    turret endon( #"death_or_disconnect" );
    turret endon( #"game_ended" );
    turret endon( #"turret_hacked" );
    bundle = self.streakinfo.bundle;
    config = level.sentrysettings[ "remote_turret" ];
    
    if ( oldowner.usingremote == "remote_turret" && turret.remotecontrolled )
    {
        oldowner thread function_2e7a90e8ac2489bd( turret );
    }
    
    turret.owner = attacker;
    turret.team = turret.owner.team;
    turret.teamfriendlyto = turret.owner.team;
    turret setotherent( turret.owner );
    turret setvehicleteam( turret.team );
    turret setnodeploy( 1 );
    turret.timeout = config.timeout;
    
    if ( !isdefined( turret.timeout ) )
    {
        turret.timeout = 120;
    }
    
    turret.maxtimeout = turret.timeout;
    
    if ( isdefined( bundle.alertfulllength ) )
    {
        endtime = gettime() + int( turret.timeout * 1000 );
        turret killstreak_shared::function_852e7d8d403629e3( endtime );
    }
    
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    killstreak_utility::function_79acee879fb17c4a( oldowner, turret.streakinfo.streakname );
    
    foreach ( combatlink in self.var_30656af96b2ac2a4 )
    {
        combatlink combat_link::function_6b4e74acda72ed51( [ turret ] );
    }
    
    turret.var_a634fe6f7264e95d = 1;
    turret clearturrettarget();
    oldowner.placedsentries[ turret.turrettype ] = arrayremove( oldowner.placedsentries[ turret.turrettype ], turret );
    
    if ( !isdefined( attacker.placedsentries ) )
    {
        attacker.placedsentries = [];
    }
    
    if ( !isdefined( attacker.placedsentries[ turret.turrettype ] ) )
    {
        attacker.placedsentries[ turret.turrettype ] = [];
    }
    
    attacker.placedsentries[ turret.turrettype ] = function_5713d46873b29625( attacker.placedsentries[ turret.turrettype ] );
    turretcount = attacker.placedsentries[ turret.turrettype ].size;
    attacker.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    
    if ( turretcount + 1 > inplaylimits::get_limit_per_player( bundle ) )
    {
        attacker.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"addtoactivekillstreaklist" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret.streakinfo.streakname, "Killstreak_Ground", attacker, 0, 1, undefined, undefined );
    }
    
    foreach ( guy in level.players )
    {
        if ( guy != turret.owner )
        {
            turret.useownerobj disableplayeruse( guy );
        }
    }
    
    turret function_9d022c4d2d0bb594();
    attacker thread remotesentry_watchpickup( turret );
    attacker thread remotesentry_disableplayeruseonconnect( turret, turret.useownerobj );
    turret function_b374d0914d7c440();
    attacker thread function_4d05f7d52ba288ba( turret );
    turret thread function_cd6ff74a61ee19c7( attacker );
    attacker thread function_69036a8cc55f332d( turret );
    attacker thread remotesentry_watchtimeout( turret );
    attacker thread remotesentry_watchdisown( turret );
    attacker thread remotesentry_watchgameend( turret );
    
    if ( level.gametypebundle.var_711e33239e4c9925 )
    {
        attacker thread remotesentry_watchcancel( turret );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", turret );
}

// Namespace remote_sentry
// Params 1, eflags: 0x4
// Checksum 0xe1279408, Offset: 0x4c5b
// Size: 0x8e
function private remotesentry_makeweapon( streakinfo )
{
    bundle = streakinfo.bundle;
    blueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    
    if ( blueprintname )
    {
        weaponobj = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( blueprintname, bundle.var_9ae3b9f6528d76c0 ?? #"deployweapon" );
    }
    else
    {
        weaponobj = makeweapon( bundle.deployweapon );
    }
    
    return weaponobj;
}

/#

    // Namespace remote_sentry
    // Params 1, eflags: 0x4
    // Checksum 0x12a372ce, Offset: 0x4cf2
    // Size: 0x54, Type: dev
    function private function_21d9ce0a9129d691( turret )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        turret endon( #"death" );
        wait 0.3;
        turret function_cfe9b3f826055561( {} );
        wait 4;
        turret function_21e9882916884fd8( {} );
    }

#/
