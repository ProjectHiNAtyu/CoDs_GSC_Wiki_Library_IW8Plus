// scripts\mp\common\killstreaks\manual_turret.gsc  (hash_32ef8d49c67aaef5.gscc) (size: 24077 Bytes / 0x5e0d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20ceeb7a (550431610)
// size ...... 24077 (0x5e0d)
// includes .. 15  (offset: 0x5905)
// strings ... 70  (offset: 0x597d)
// dev strs .. 12  (offset: 0x5d75)
// exports ... 57  (offset: 0x3aad)
// cseg ...... 0x53a + 0x3573 (0x3aad)
// imports ... 170 (offset: 0x4395)
// animtree1 . 0   (offset: 0x5e0d)
// animtree2 . 0   (offset: 0x5e0d)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;

#namespace manual_turret;

// Namespace manual_turret
// Params 0
// Checksum 0xae8f789a, Offset: 0x558
// Size: 0xc3
function init()
{
    if ( utility::issharedfuncdefined( #"manual_turret", #"init" ) )
    {
        [[ utility::getsharedfunc( #"manual_turret", #"init" ) ]]();
    }
    
    killstreak_utility::registervisibilityomnvarforkillstreak( "manual_turret", "on", 10 );
    utility::registersharedfunc( #"killstreak", #"manualturret_disablefire", &manualturret_disablefire );
    utility::registersharedfunc( #"killstreak", #"manualturret_clearplacementinstructions", &manualturret_clearplacementinstructions );
    utility::registersharedfunc( #"killstreak", #"manualturret_delayplacementinstructions", &manualturret_delayplacementinstructions );
    utility::registersharedfunc( #"killstreak", #"hash_29252bc7877f4fbe", &function_31ec7957c5cad997 );
}

// Namespace manual_turret
// Params 3
// Checksum 0xab254255, Offset: 0x623
// Size: 0x2d
function weaponcleanupmanualturret( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xde933b69, Offset: 0x658
// Size: 0x29
function tryusemanualturret( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return tryusemanualturretfromstruct( streakinfo );
}

// Namespace manual_turret
// Params 1
// Checksum 0x2d2cea4f, Offset: 0x68a
// Size: 0x14a, Type: bool
function tryusemanualturretfromstruct( streakinfo )
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
    
    weapon_utility::saveweaponstates();
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, makeweapon( "deploy_manual_turret_mp" ), 1, undefined, undefined, &weaponcleanupmanualturret );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    manualturret_toggleallowplacementactions( 0 );
    turret = manualturret_create( "manual_turret", streakinfo );
    
    if ( !isdefined( turret ) )
    {
        manualturret_toggleallowplacementactions( 1 );
        return false;
    }
    
    marker = manualturret_watchplacement( turret, streakinfo, 0, 1.25 );
    
    if ( !isdefined( marker ) )
    {
        manualturret_toggleallowplacementactions( 1 );
        turret delete();
        return false;
    }
    
    manualturret_toggleallowplacementactions( 1 );
    manualturret_setplaced( turret, marker );
    
    if ( utility::issharedfuncdefined( #"manual_turret", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"manual_turret", #"munitionused" ) ]]();
    }
    
    return true;
}

// Namespace manual_turret
// Params 4
// Checksum 0xd0a72c4c, Offset: 0x7dd
// Size: 0x181
function manualturret_watchplacement( turret, streakinfo, ignorecancel, var_c6c7c3535d7e7bda )
{
    thread utility::callsharedfunc( #"killstreak", #"manualturret_delayplacementinstructions", var_c6c7c3535d7e7bda );
    thread utility::callsharedfunc( #"killstreak", #"hash_29252bc7877f4fbe" );
    marker = undefined;
    
    if ( utility::issharedfuncdefined( #"manual_turret", #"gettargetmarker" ) )
    {
        marker = self [[ utility::getsharedfunc( #"manual_turret", #"gettargetmarker" ) ]]( streakinfo, ignorecancel );
    }
    
    if ( !( isdefined( marker ) && isdefined( marker.location ) ) )
    {
        if ( self.inlaststand )
        {
            inventory_utility::_takeweapon( "deploy_manual_turret_mp" );
        }
        else if ( player::isreallyalive() )
        {
            killstreak_utility::killstreak_switchbacklastweapon( "deploy_manual_turret_mp" );
        }
        
        self notify( #"turret_placement_finished" );
        return;
    }
    
    turret thread manualturret_disablefire( self, 1, 1 );
    
    if ( self hasweapon( "deploy_manual_turret_mp" ) )
    {
        thread killstreak_utility::killstreak_switchbacklastweapon( "deploy_manual_turret_mp", 1, 1 );
    }
    
    var_1f804af8a4435c33 = 1;
    delayspawntime = 0.85;
    timeout = hostmigration::waittillnotifyortimeoutpause( "equip_deploy_cancel", delayspawntime );
    
    if ( !isdefined( timeout ) || timeout == "timeout" )
    {
        var_1f804af8a4435c33 = 0;
        waitframe();
    }
    
    self notify( #"turret_placement_finished" );
    return var_1f804af8a4435c33 ? marker : undefined;
}

// Namespace manual_turret
// Params 0, eflags: 0x4
// Checksum 0x95453a6, Offset: 0x967
// Size: 0x37
function private function_31ec7957c5cad997()
{
    self endon( #"turret_placement_finished" );
    self endon( #"death_or_disconnect" );
    utility::waittill_any( "last_stand_enter", "meatshield_victim_grabbed" );
    self notify( #"equip_deploy_cancel" );
}

// Namespace manual_turret
// Params 1, eflags: 0x4
// Checksum 0x52e42197, Offset: 0x9a6
// Size: 0x76
function private manualturret_delayplacementinstructions( delaytime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"turret_placement_finished" );
    self endon( #"equip_deploy_cancel" );
    level endon( #"game_ended" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( delaytime );
    self setclientomnvar( "ui_turret_placement", 2 );
    thread namespace_9d8e359c3b1041e5::manualturret_clearplacementinstructionssharedfunc( "death" );
    thread namespace_9d8e359c3b1041e5::manualturret_clearplacementinstructionssharedfunc( "turret_placement_finished" );
    thread namespace_9d8e359c3b1041e5::manualturret_clearplacementinstructionssharedfunc( "equip_deploy_cancel" );
}

// Namespace manual_turret
// Params 1
// Checksum 0x8f6c6013, Offset: 0xa24
// Size: 0x4e
function manualturret_clearplacementinstructions( clearaction )
{
    self endon( #"cleared_placement" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( clearaction );
    self setclientomnvar( "ui_turret_placement", 0 );
    self notify( #"cleared_placement" );
}

// Namespace manual_turret
// Params 2
// Checksum 0x39abb687, Offset: 0xa7a
// Size: 0x2d1
function manualturret_create( turrettype, streakinfo )
{
    config = level.sentrysettings[ turrettype ];
    turret = spawnturret( "misc_turret", self.origin, level.sentrysettings[ turrettype ].weaponinfo );
    turret.owner = self;
    turret.team = self.team;
    turret.angles = self.angles;
    turret.health = 9999;
    turret.maxhealth = config.maxhealth;
    turret.streakinfo = streakinfo;
    turret.turrettype = turrettype;
    turret.shouldsplash = 1;
    turret.ammocount = config.ammo;
    turret.reticlestate = "reticle_on";
    turret.timeout = config.timeout;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            turret.timeout = 9999;
        }
    #/
    
    turret.carriedby = self;
    turret manualturret_setturretmodel( "placed" );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    turret hide();
    turret emp_debuff::allow_emp( 0 );
    killcamforward = anglestoforward( turret.angles );
    killcampos = turret gettagorigin( "tag_laser" ) + ( 0, 0, 10 );
    killcampos -= killcamforward * 20;
    killcament = spawn( "script_model", killcampos );
    killcament linkto( turret );
    turret.killcament = killcament;
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( "weapon_vm_mg_sentry_turret_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    turret.colmodel.moverdoesnotkill = 1;
    turret.colmodel.turretparent = turret;
    return turret;
}

// Namespace manual_turret
// Params 2
// Checksum 0xd246e109, Offset: 0xd54
// Size: 0x774
function manualturret_setplaced( turret, marker )
{
    config = level.sentrysettings[ turret.turrettype ];
    turret manualturret_setturretmodel( "placed" );
    
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
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( turret.streakinfo.streakname );
        }
        
        splashname = config.teamsplash;
        
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( splashname, self );
        }
        
        turret.shouldsplash = 0;
    }
    
    turret show();
    turret dontinterpolate();
    turret.angles = marker.angles;
    turret.carriedby = undefined;
    
    if ( isdefined( marker.moving_platform ) )
    {
        turret.moving_platform = marker.moving_platform;
        turret.moving_platform_offset = marker.moving_platform_offset;
        turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
    }
    
    if ( isdefined( self.hideammoindex ) )
    {
        for ( var_873f2b0002e611c3 = self.hideammoindex; var_873f2b0002e611c3 >= 1 ; var_873f2b0002e611c3-- )
        {
            turret setscriptablepartstate( "hide_ammo_" + var_873f2b0002e611c3, "on", 0 );
        }
    }
    
    var_6b68b382ed17bd43 = "off";
    
    if ( turret.reticlestate == "reticle_off" )
    {
        var_6b68b382ed17bd43 = "on";
    }
    
    turret setscriptablepartstate( "hide_reticle", var_6b68b382ed17bd43, 0 );
    turret.origin = marker.location;
    turret playsound( "sentry_gun_plant" );
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret, "tag_aim_pivot" );
    
    if ( !isbrgamemode() )
    {
        turreticon = "icon_minimap_mobileturret";
        turret.minimapid = turret objidpoolmanager::createobjective( turreticon, turret.team, undefined, 1, 0 );
    }
    
    turretcount = self.placedsentries[ turret.turrettype ].size;
    self.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    
    if ( turretcount + 1 > 1 )
    {
        self.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    headiconoffset = 70;
    
    if ( turret.model == level.sentrysettings[ turret.turrettype ].modelbasecover )
    {
        headiconoffset = 35;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        turret [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried_turret" );
    }
    
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeon );
    usedistance = getdvarint( @"scr_manual_turret_use_distance", 17 );
    hintfov = getdvarint( @"hash_1faf82c0894746bc", 160 );
    usefov = getdvarint( @"scr_manual_turret_use_fov", 120 );
    hinttag = "j_trigger";
    
    if ( !isdefined( turret.useownerobj ) )
    {
        hintpos = turret gettagorigin( hinttag );
        hinticon = undefined;
        
        if ( self usingtouch() )
        {
            hinticon = "hud_icon_killstreak_turret";
        }
        
        if ( utility::issharedfuncdefined( #"manual_turret", #"createhintobject" ) )
        {
            turret.useownerobj = [[ utility::getsharedfunc( #"manual_turret", #"createhintobject" ) ]]( hintpos, "HINT_BUTTON", hinticon, config.ownerusehintstring, -1, "duration_none", undefined, usedistance, hintfov, usedistance, usefov );
        }
    }
    else
    {
        hintpos = turret gettagorigin( hinttag );
        turret.useownerobj setusableenabled( 1 );
        turret.useownerobj dontinterpolate();
        turret.useownerobj.origin = hintpos;
    }
    
    turret.useownerobj linkto( turret, hinttag );
    
    if ( !isdefined( turret.useotherobj ) )
    {
        hintpos = turret gettagorigin( hinttag );
        
        if ( utility::issharedfuncdefined( #"manual_turret", #"createhintobject" ) )
        {
            turret.useotherobj = [[ utility::getsharedfunc( #"manual_turret", #"createhintobject" ) ]]( hintpos, "HINT_BUTTON", undefined, config.otherusehintstring, -1, "duration_none", undefined, usedistance, hintfov, usedistance, usefov );
        }
    }
    else
    {
        hintpos = turret gettagorigin( hinttag );
        turret.useotherobj setusableenabled( 1 );
        turret.useotherobj dontinterpolate();
        turret.useotherobj.origin = hintpos;
    }
    
    turret.useotherobj linkto( turret, hinttag );
    
    if ( utility::issharedfuncdefined( #"manual_turret", #"handlemovingplatform" ) )
    {
        [[ utility::getsharedfunc( #"manual_turret", #"handlemovingplatform" ) ]]( turret );
    }
    
    turret emp_debuff::allow_emp( 1 );
    turret sentientpoolmanager::registersentient( "Killstreak_Static", self );
    turret thread manualturret_delaydeletemarker( self, marker );
    turret thread manualturret_watchuse( self, turret.useownerobj );
    turret thread manualturret_watchuse( self, turret.useotherobj );
    turret thread manualturret_watchpickup( self );
    turret thread manualturret_watchdamage( self );
    turret thread manualturret_watchdeath( self );
    turret thread manualturret_watchdeathongameend();
    turret thread manualturret_watchtimeout( self );
    turret thread manualturret_watchdisown( self );
    
    if ( isdefined( level.wztrain_info ) && utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = &function_29a50478295e6bb1;
        turret thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0x5b55181c, Offset: 0x14d0
// Size: 0x88
function function_29a50478295e6bb1( data )
{
    engine = train_utility::get_train_engine();
    assert( isdefined( engine ) );
    
    if ( !isdefined( engine ) )
    {
        return;
    }
    
    if ( data.lasttouchedplatform == engine )
    {
        self notify( #"kill_turret", 1 );
        return;
    }
    
    data = spawnstruct();
    data.deathoverridecallback = &function_29a50478295e6bb1;
    self thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
}

// Namespace manual_turret
// Params 1
// Checksum 0x59210593, Offset: 0x1560
// Size: 0x246
function manualturret_setcarried( owner )
{
    self endon( #"kill_turret" );
    owner endon( #"death_or_disconnect" );
    owner endon( #"hash_138d0c4ed8fde916" );
    level endon( #"game_ended" );
    
    if ( self.inuse )
    {
        self.inuse = undefined;
        owner manualturret_toggleallowuseactions( 1 );
    }
    
    if ( isdefined( self.moving_platform ) )
    {
        self.moving_platform = undefined;
        self.moving_platform_offset = undefined;
        self.moving_platform_angles_offset = undefined;
        self unlink();
    }
    
    emp_debuff::allow_emp( 0 );
    sentientpoolmanager::unregistersentient( self.sentientpool, self.sentientpoolindex );
    linkedchildren = self getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( isdefined( child ) )
        {
            child unlink();
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
    
    self.colmodel hide();
    owner manualturret_setinactive( self );
    self hide();
    self.carriedby = owner;
    self notify( #"carried_turret" );
    self playsound( "sentry_pickup" );
    owner weapon_utility::saveweaponstates();
    owner inventory_utility::_giveweapon( "deploy_manual_turret_mp" );
    owner inventory_utility::_switchtoweapon( "deploy_manual_turret_mp" );
    owner manualturret_toggleallowplacementactions( 0 );
    marker = owner manualturret_watchplacement( self, self.streakinfo, 1, 2 );
    
    if ( !isdefined( marker ) )
    {
        owner manualturret_toggleallowplacementactions( 1 );
        return 0;
    }
    
    owner manualturret_toggleallowplacementactions( 1 );
    owner manualturret_setplaced( self, marker );
}

// Namespace manual_turret
// Params 1
// Checksum 0x3c9e395d, Offset: 0x17ae
// Size: 0x64
function manualturret_setinactive( turret )
{
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeoff );
    turret setturretminimapvisible( 0 );
    turret manualturret_makealltriggersusable( 0 );
    turret.useownerobj unlink();
    turret.useotherobj unlink();
}

// Namespace manual_turret
// Params 2
// Checksum 0xcb5748db, Offset: 0x181a
// Size: 0x52
function manualturret_delaydeletemarker( owner, marker )
{
    self endon( #"kill_turret" );
    level endon( #"game_ended" );
    wait 0.25;
    
    if ( isdefined( marker.visual ) )
    {
        marker.visual delete();
    }
}

// Namespace manual_turret
// Params 2
// Checksum 0xe0622e10, Offset: 0x1874
// Size: 0x4e4
function manualturret_watchuse( owner, triggerobj )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        triggerobj enableplayeruse( player );
        
        if ( triggerobj == self.useownerobj )
        {
            if ( player == owner )
            {
                continue;
            }
        }
        else if ( level.teambased && player.team == owner.team && player != owner )
        {
            continue;
        }
        
        triggerobj disableplayeruse( player );
    }
    
    thread manualturret_disableplayeruseonconnect( owner, triggerobj );
    
    while ( true )
    {
        triggerobj waittill( #"trigger", player );
        
        if ( self.inuse )
        {
            continue;
        }
        
        if ( self.stopinteract )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/turret_dying" );
            }
            
            continue;
        }
        
        if ( player isonladder() || !player isonground() || player ismantling() )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
            }
            
            continue;
        }
        
        if ( player.isjuggernaut )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_used" );
            }
            
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"manual_turret", #"allowpickupofturret" ) )
        {
            if ( !player [[ utility::getsharedfunc( #"manual_turret", #"allowpickupofturret" ) ]]() )
            {
                continue;
            }
        }
        
        self.inuse = 1;
        player manualturret_toggleallowuseactions( 0 );
        player disableturretdismount();
        
        if ( player == owner )
        {
            buttontime = 0;
            
            while ( player usebuttonpressed() && buttontime < 0.25 )
            {
                waitframe();
                buttontime += level.framedurationseconds;
            }
            
            if ( buttontime >= 0.25 )
            {
                player enableturretdismount();
                continue;
            }
        }
        
        player notify( #"hash_138d0c4ed8fde916" );
        self.playerusingturret = player;
        manualturret_makealltriggersusable( 0 );
        player weapon_utility::saveweaponstates();
        player.useweapon = level.sentrysettings[ self.turrettype ].playerweaponinfo;
        player inventory_utility::_giveweapon( player.useweapon, undefined, undefined, 1 );
        turretusetime = gettime();
        result = undefined;
        
        while ( gettime() - turretusetime < 1000 )
        {
            result = manualturret_domonitoredweaponswitch( player, player.useweapon );
            
            if ( !isdefined( result ) || result )
            {
                break;
            }
            
            waitframe();
        }
        
        if ( !result )
        {
            self.inuse = undefined;
            self.playerusingturret = undefined;
            manualturret_makealltriggersusable( 1 );
            
            if ( isdefined( player ) )
            {
                if ( player player::isreallyalive() )
                {
                    player manualturret_toggleallowuseactions( 1 );
                    var_834e1ea1f94aef8a = getdvarint( @"hash_dba4a054e67dd255", 0 ) == 1;
                    lastweaponobj = player weapon_utility::restoreweaponstates( player.lastdroppableweaponobj, var_834e1ea1f94aef8a );
                    player switchtoweaponimmediate( lastweaponobj );
                }
                
                player clearhighpriorityweapon( player.useweapon );
                player inventory_utility::_takeweapon( player.useweapon );
            }
            
            continue;
        }
        
        player.currentturret = self;
        player controlturreton( self );
        
        if ( utility::function_2a082dafe6f4bd5b() )
        {
            player val::set( "nightmap_check", "nvg", 0 );
        }
        
        manualturret_applyoverlay( player );
        
        /#
            thread function_c7d9fa33a8460b2d( player );
        #/
        
        thread manualturret_disablefire( player, 0.5, 1 );
        thread manualturret_watchammotracker( player );
        thread manualturret_endturretuseonexecution( player );
        thread manualturret_endturretuseonpush( player );
        thread manualturret_endturretusewatch( player );
        thread manualturret_endturretonplayer( player );
        thread manualturret_watchplayerangles( player );
    }
}

// Namespace manual_turret
// Params 2
// Checksum 0x8426c162, Offset: 0x1d60
// Size: 0x77
function manualturret_domonitoredweaponswitch( var_9aae1059fa4e8fb5, turretuseweapon )
{
    self endon( #"kill_turret" );
    self endon( #"hash_45bcb7dbf7ea4471" );
    var_9aae1059fa4e8fb5 endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    thread manualturret_watchturretusetimeout( 1 );
    result = var_9aae1059fa4e8fb5 inventory_utility::domonitoredweaponswitch( turretuseweapon, 1 );
    self notify( #"hash_59ac09a41ced3d62" );
    return result;
}

// Namespace manual_turret
// Params 1
// Checksum 0xfe46eb10, Offset: 0x1de0
// Size: 0x45
function manualturret_watchturretusetimeout( timeout )
{
    self endon( #"kill_turret" );
    self endon( #"hash_59ac09a41ced3d62" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( timeout );
    self notify( #"hash_45bcb7dbf7ea4471" );
}

// Namespace manual_turret
// Params 2
// Checksum 0x12641ae5, Offset: 0x1e2d
// Size: 0x13d
function manualturret_watchdismantle( owner, dismantleobj )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        dismantleobj enableplayeruse( player );
        
        if ( level.teambased && player.team != owner.team )
        {
            continue;
        }
        else if ( !level.teambased )
        {
            if ( player != owner )
            {
                continue;
            }
        }
        
        dismantleobj disableplayeruse( player );
    }
    
    thread manualturret_disableplayerdismantleonconnect( owner );
    
    while ( true )
    {
        dismantleobj waittill( #"trigger", player );
        self notify( #"kill_turret", 0, 1 );
        break;
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xe6e05a17, Offset: 0x1f72
// Size: 0x50
function manualturret_applyoverlay( user )
{
    user killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "on" );
    user setclientomnvar( "ui_mobile_turret_controls", 1 );
    user setclientomnvar( "ui_killstreak_weapon_1_ammo", self.ammocount );
}

// Namespace manual_turret
// Params 1
// Checksum 0x5fe2b482, Offset: 0x1fca
// Size: 0x3a
function manualturret_removeoverlay( user )
{
    user killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
    user setclientomnvar( "ui_mobile_turret_controls", 0 );
}

/#

    // Namespace manual_turret
    // Params 1
    // Checksum 0x4bad2191, Offset: 0x200c
    // Size: 0xdf, Type: dev
    function function_c7d9fa33a8460b2d( user )
    {
        self endon( #"kill_turret" );
        self endon( #"carried_turret" );
        user endon( #"hash_ebfdc855350d305" );
        user endon( #"disconnect" );
        level endon( #"game_ended" );
        user notifyonplayercommand( "<dev string:x24>", "<dev string:x33>" );
        
        while ( true )
        {
            user waittill( #"toggle_reticle" );
            
            if ( self.reticlestate == "<dev string:x3d>" )
            {
                user iprintlnbold( "<dev string:x48>" );
                self setscriptablepartstate( "<dev string:x5e>", "<dev string:x6b>", 0 );
                self.reticlestate = "<dev string:x6e>";
                continue;
            }
            
            user iprintlnbold( "<dev string:x7a>" );
            self setscriptablepartstate( "<dev string:x5e>", "<dev string:x8f>", 0 );
            self.reticlestate = "<dev string:x3d>";
        }
    }

#/

// Namespace manual_turret
// Params 3
// Checksum 0xfbd2f8de, Offset: 0x20f3
// Size: 0x8c
function manualturret_disablefire( user, disabletime, enableendons )
{
    if ( enableendons )
    {
        user endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
    }
    
    if ( isdefined( user ) && player::isreallyalive() )
    {
        user freezecontrols( 1 );
    }
    else
    {
        return;
    }
    
    user hostmigration::waittillnotifyortimeoutpause( "equip_deploy_cancel", disabletime );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( user ) && player::isreallyalive() )
    {
        user freezecontrols( 0 );
        return;
    }
    
    return;
}

// Namespace manual_turret
// Params 1
// Checksum 0x8ce2b551, Offset: 0x2187
// Size: 0xfa
function manualturret_enableenemyoutlines( user )
{
    if ( !isdefined( self.enemyoutlineinfos ) )
    {
        self.enemyoutlineinfos = [];
    }
    
    thread manualturret_enableenemyoutlinesonconnect( user );
    
    foreach ( enemy in teams::getenemyplayers( user.team ) )
    {
        if ( isdefined( enemy.perks[ "specialty_noscopeoutline" ] ) )
        {
            if ( !enemy player::isreallyalive() )
            {
                thread manualturret_enableenemyoutlineafterprotection( user, enemy, 1 );
            }
            else if ( enemy.avoidkillstreakonspawntimer > 0 )
            {
                thread manualturret_enableenemyoutlineafterprotection( user, enemy );
            }
            
            continue;
        }
        
        manualturret_addtooutlinelist( user, enemy );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xf84d340b, Offset: 0x2289
// Size: 0x52
function manualturret_enableenemyoutlinesonconnect( user )
{
    self endon( #"kill_turret" );
    user endon( #"hash_ebfdc855350d305" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        thread manualturret_enableenemyoutlineafterprotection( user, player, 1 );
    }
}

// Namespace manual_turret
// Params 3
// Checksum 0x60fb847a, Offset: 0x22e3
// Size: 0x5f
function manualturret_removeoutlineondeath( user, var_42a12700ec944917, outlineid )
{
    self endon( #"kill_turret" );
    user endon( #"hash_ebfdc855350d305" );
    var_42a12700ec944917 waittill( #"death_or_disconnect" );
    manualturret_removefromoutlinelist( var_42a12700ec944917, outlineid );
    
    if ( isdefined( var_42a12700ec944917 ) )
    {
        thread manualturret_restoreoutlineonspawn( user, var_42a12700ec944917 );
    }
}

// Namespace manual_turret
// Params 2
// Checksum 0x14fcdde5, Offset: 0x234a
// Size: 0x70
function manualturret_restoreoutlineonspawn( user, var_42a12700ec944917 )
{
    self endon( #"kill_turret" );
    user endon( #"hash_ebfdc855350d305" );
    var_42a12700ec944917 endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( player != var_42a12700ec944917 )
        {
            continue;
        }
        
        thread manualturret_enableenemyoutlineafterprotection( user, player );
    }
}

// Namespace manual_turret
// Params 3
// Checksum 0xdb7fb9f4, Offset: 0x23c2
// Size: 0xb0
function manualturret_enableenemyoutlineafterprotection( user, var_42a12700ec944917, waitforspawn )
{
    self endon( #"kill_turret" );
    user endon( #"hash_ebfdc855350d305" );
    
    if ( waitforspawn )
    {
        var_42a12700ec944917 waittill( #"spawned_player" );
    }
    
    if ( var_42a12700ec944917.avoidkillstreakonspawntimer > 0 )
    {
        var_42a12700ec944917 waittill( #"hash_8546449be1f6bef9" );
    }
    
    if ( level.teambased && var_42a12700ec944917.team == user.team )
    {
        return;
    }
    
    if ( isdefined( var_42a12700ec944917.perks[ "specialty_noscopeoutline" ] ) )
    {
        return;
    }
    
    manualturret_addtooutlinelist( user, var_42a12700ec944917 );
}

// Namespace manual_turret
// Params 2
// Checksum 0x4d8d204c, Offset: 0x247a
// Size: 0xaf
function manualturret_addtooutlinelist( var_83734cdaf1735d3a, playertoadd )
{
    outlineinfo = spawnstruct();
    outlineinfo.ent = playertoadd;
    
    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
    {
        outlineinfo.entoutlineid = [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( playertoadd, var_83734cdaf1735d3a, "outline_nodepth_orange", "level_script" );
    }
    
    self.enemyoutlineinfos[ self.enemyoutlineinfos.size ] = outlineinfo;
    thread manualturret_removeoutlineondeath( var_83734cdaf1735d3a, playertoadd, outlineinfo.entoutlineid );
    return outlineinfo;
}

// Namespace manual_turret
// Params 2
// Checksum 0xf51cc569, Offset: 0x2532
// Size: 0xfe
function manualturret_removefromoutlinelist( var_b1c4a8fbb5b20426, outlineid )
{
    if ( !isdefined( self.enemyoutlineinfos ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
    {
        [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( outlineid, var_b1c4a8fbb5b20426 );
    }
    
    var_b9a7db48e3c41673 = [];
    
    foreach ( outlineinfo in self.enemyoutlineinfos )
    {
        if ( outlineinfo.ent == var_b1c4a8fbb5b20426 )
        {
            continue;
        }
        
        var_b9a7db48e3c41673[ var_b9a7db48e3c41673.size ] = outlineinfo;
    }
    
    self.enemyoutlineinfos = var_b9a7db48e3c41673;
}

// Namespace manual_turret
// Params 1
// Checksum 0x79afbc0, Offset: 0x2638
// Size: 0xe1
function manualturret_disableenemyoutlines( user )
{
    if ( !isdefined( self.enemyoutlineinfos ) )
    {
        return;
    }
    
    foreach ( outlineinfo in self.enemyoutlineinfos )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( outlineinfo.entoutlineid, outlineinfo.ent );
        }
    }
    
    self.enemyoutlineinfos = undefined;
}

// Namespace manual_turret
// Params 1
// Checksum 0x7a101e14, Offset: 0x2721
// Size: 0x16e
function manualturret_endplayeruse( turret )
{
    if ( isdefined( turret ) )
    {
        turret.inuse = undefined;
        turret.playerusingturret = undefined;
        turret manualturret_makealltriggersusable( 1 );
    }
    
    if ( isdefined( self ) )
    {
        if ( !self usinggamepad() )
        {
            self enableturretdismount();
        }
        
        if ( isdefined( turret ) )
        {
            if ( isdefined( self.currentturret ) && self.currentturret != turret )
            {
                return;
            }
            
            self controlturretoff( turret );
            turret manualturret_removeoverlay( self );
            
            if ( !turret.isshuttingdown )
            {
                turret thread manualturret_watchpickup( turret.owner );
            }
        }
        
        self.currentturret = undefined;
        manualturret_toggleallowuseactions( 1 );
        
        if ( utility::function_2a082dafe6f4bd5b() )
        {
            val::reset_all( "nightmap_check" );
        }
        
        if ( !isbrgamemode() || !self.inlaststand )
        {
            var_834e1ea1f94aef8a = getdvarint( @"hash_dba4a054e67dd255", 0 ) == 1;
            lastweaponobj = weapon_utility::restoreweaponstates( self.lastdroppableweaponobj, var_834e1ea1f94aef8a );
            self switchtoweaponimmediate( lastweaponobj );
        }
        
        inventory_utility::_takeweapon( self.useweapon );
        thread manualturret_disablecrouchpronemantle();
        
        if ( player::isreallyalive() )
        {
            self setorigin( turret.lastuserpos, 1 );
            self setplayerangles( turret.lastuserangles );
        }
        
        self notify( #"hash_ebfdc855350d305" );
    }
}

// Namespace manual_turret
// Params 0
// Checksum 0x9794bf23, Offset: 0x2897
// Size: 0x59
function manualturret_disablecrouchpronemantle()
{
    self endon( #"death_or_disconnect" );
    val::set( "manual_turret", "crouch", 0 );
    val::set( "manual_turret", "prone", 0 );
    val::set( "manual_turret", "mantle", 0 );
    hostmigration::waitlongdurationwithpause( 1 );
    val::reset_all( "manual_turret" );
}

// Namespace manual_turret
// Params 2
// Checksum 0x6770e933, Offset: 0x28f8
// Size: 0x74
function manualturret_disableplayeruseonconnect( owner, useobj )
{
    if ( isdefined( self ) )
    {
        self endon( #"kill_turret" );
        self endon( #"carried_turret" );
    }
    
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        useobj disableplayeruse( player );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xf18a1175, Offset: 0x2974
// Size: 0x69
function manualturret_endturretuseonexecution( user )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    user endon( #"hash_ebfdc855350d305" );
    user endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( user isinexecutionvictim() )
        {
            user manualturret_endplayeruse( self );
            break;
        }
        
        waitframe();
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0x912986f9, Offset: 0x29e5
// Size: 0x9f
function manualturret_endturretuseonpush( user )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    user endon( #"hash_ebfdc855350d305" );
    user endon( #"disconnect" );
    level endon( #"game_ended" );
    detachdistancesq = 2500;
    
    if ( isdefined( self.moving_platform ) )
    {
        detachdistancesq = 10000;
    }
    
    while ( true )
    {
        if ( distancesquared( self.origin, user.origin ) >= detachdistancesq )
        {
            user manualturret_endplayeruse( self );
            break;
        }
        
        waitframe();
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0x2f799812, Offset: 0x2a8c
// Size: 0x76
function manualturret_endturretusewatch( user )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    user endon( #"hash_ebfdc855350d305" );
    user endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( user usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( user usebuttonpressed() )
        {
            user manualturret_endplayeruse( self );
            break;
        }
        
        waitframe();
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xee1a2ca2, Offset: 0x2b0a
// Size: 0x42
function manualturret_endturretonplayer( user )
{
    user endon( #"hash_ebfdc855350d305" );
    level endon( #"game_ended" );
    user utility::waittill_any( "death_or_disconnect", "last_stand_enter" );
    user manualturret_endplayeruse( self );
}

// Namespace manual_turret
// Params 1
// Checksum 0xe1289b3b, Offset: 0x2b54
// Size: 0x6a
function manualturret_watchplayerangles( user )
{
    self endon( #"kill_turret" );
    user endon( #"hash_ebfdc855350d305" );
    user endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.lastuserpos = user.origin;
        self.lastuserangles = user getplayerangles();
        waitframe();
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0x8adc6704, Offset: 0x2bc6
// Size: 0x216
function manualturret_watchpickup( owner )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    owner endon( #"disconnect" );
    owner endon( #"hash_138d0c4ed8fde916" );
    level endon( #"game_ended" );
    
    while ( isdefined( self ) && isdefined( self.useownerobj ) )
    {
        self.useownerobj waittill( #"trigger_progress", player );
        buttontime = 0;
        
        while ( owner usebuttonpressed() && buttontime < 0.25 )
        {
            waitframe();
            buttontime += level.framedurationseconds;
        }
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( buttontime < 0.25 )
        {
            continue;
        }
        
        if ( self.stopinteract )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/turret_dying" );
            }
            
            continue;
        }
        
        if ( player.isjuggernaut )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_used" );
            }
            
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"manual_turret", #"allowpickupofturret" ) )
        {
            if ( !player [[ utility::getsharedfunc( #"manual_turret", #"allowpickupofturret" ) ]]() )
            {
                continue;
            }
        }
        
        manualturret_makealltriggersusable( 0 );
        self setmode( level.sentrysettings[ self.turrettype ].sentrymodeoff );
        owner.placedsentries[ self.turrettype ] = arrayremove( owner.placedsentries[ self.turrettype ], self );
        thread manualturret_setcarried( owner );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xede8aa4d, Offset: 0x2de4
// Size: 0x46
function manualturret_watchdelayedpickup( owner )
{
    self endon( #"kill_turret" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 0.5 );
    thread manualturret_watchpickup( owner );
}

// Namespace manual_turret
// Params 1
// Checksum 0xc61980f9, Offset: 0x2e32
// Size: 0x71
function manualturret_disableplayerpickuponconnect( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried_turret" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        turret.useownerobj disableplayeruse( player );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0x140b819e, Offset: 0x2eab
// Size: 0x5d
function manualturret_watchdamage( owner )
{
    if ( utility::issharedfuncdefined( #"manual_turret", #"monitordamage" ) )
    {
        self [[ utility::getsharedfunc( #"manual_turret", #"monitordamage" ) ]]( self.maxhealth, "hitequip", &manualturret_handledeathdamage, &manualturret_modifydamage, 1 );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xdfbd6cbb, Offset: 0x2f10
// Size: 0x153
function manualturret_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    config = level.sentrysettings[ self.turrettype ];
    
    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
    {
        notifyattacker = [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash );
    }
    
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" )
    {
        explosivedamage = 1;
    }
    
    self notify( #"kill_turret", explosivedamage, 1 );
}

// Namespace manual_turret
// Params 1
// Checksum 0xc7f9a69a, Offset: 0x306b
// Size: 0xd6
function manualturret_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, 1, 1, 2, 7, 5 );
    }
    
    return modifieddamage;
}

// Namespace manual_turret
// Params 1
// Checksum 0x5acb95f8, Offset: 0x314a
// Size: 0xa5
function manualturret_disableplayerdismantleonconnect( owner )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player waittill( #"spawned_player" );
        
        if ( level.teambased )
        {
            if ( player.team != owner.team )
            {
                continue;
            }
        }
        
        self.dismantleobj disableplayeruse( player );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xee28e1a8, Offset: 0x31f7
// Size: 0x262
function manualturret_watchdeath( owner )
{
    self endon( #"carried_turret" );
    self waittill( #"kill_turret", skipshutdown, wasdestroyed );
    self.isshuttingdown = 1;
    
    if ( isdefined( owner ) )
    {
        owner.placedsentries[ self.turrettype ] = arrayremove( owner.placedsentries[ self.turrettype ], self );
        owner manualturret_setinactive( self );
        manualturret_disableenemyoutlines( owner );
        
        /#
            if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
            {
                owner [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x93>", owner );
            }
        #/
        
        self.streakinfo.expiredbydeath = istrue( wasdestroyed );
        owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    }
    
    if ( isdefined( self.playerusingturret ) )
    {
        self.playerusingturret manualturret_endplayeruse( self );
    }
    
    if ( isdefined( self.useownerobj ) )
    {
        self.useownerobj delete();
    }
    
    if ( isdefined( self.useotherobj ) )
    {
        self.useotherobj delete();
    }
    
    if ( !skipshutdown )
    {
        self playsound( "sentry_explode_smoke" );
        self setscriptablepartstate( "shutdown", "on" );
        hostmigration::waitlongdurationwithpause( 2 );
        self setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        self setscriptablepartstate( "explode", "violent" );
    }
    
    self playsound( "mp_equip_destroyed" );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( isdefined( self.colmodel ) )
    {
        self.colmodel delete();
    }
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    wait 0.2;
    self delete();
}

// Namespace manual_turret
// Params 0
// Checksum 0xeb813831, Offset: 0x3461
// Size: 0x35
function manualturret_watchdeathongameend()
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    level waittill( #"game_ended" );
    self notify( #"kill_turret", 0, 0 );
}

// Namespace manual_turret
// Params 0
// Checksum 0x9d3ca041, Offset: 0x349e
// Size: 0x1d
function manualturret_delayscriptabledelete()
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 5 );
    self delete();
}

// Namespace manual_turret
// Params 1
// Checksum 0xff7efddd, Offset: 0x34c3
// Size: 0x15e
function manualturret_watchtimeout( owner )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    var_e33dbb456f5836a7 = self.timeout;
    
    if ( !isdefined( self.timeelapsed ) )
    {
        self.timeelapsed = 0;
    }
    
    while ( self.timeelapsed < var_e33dbb456f5836a7 )
    {
        timepercent = ( var_e33dbb456f5836a7 - self.timeelapsed ) / var_e33dbb456f5836a7;
        timepercent = int( ceil( clamp( timepercent, 0, 1 ) * 100 ) );
        
        if ( isdefined( self.playerusingturret ) )
        {
            self.playerusingturret setclientomnvar( "ui_killstreak_countdown", int( timepercent ) );
        }
        
        self.timeelapsed += level.framedurationseconds;
        
        if ( self.timeelapsed >= var_e33dbb456f5836a7 - 1.5 && !self.stopinteract )
        {
            self.stopinteract = 1;
        }
        
        waitframe();
    }
    
    owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "timeout_" + self.streakinfo.streakname, #"leave", 1 );
    self notify( #"kill_turret", 0, 0 );
}

// Namespace manual_turret
// Params 1
// Checksum 0xa5093a31, Offset: 0x3629
// Size: 0x1c6
function manualturret_watchammotracker( user )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    user endon( #"hash_ebfdc855350d305" );
    user endon( #"disconnect" );
    level endon( #"game_ended" );
    config = level.sentrysettings[ self.turrettype ];
    var_13463d1a4d35279b = weaponfiretime( config.weaponinfo );
    
    if ( !isdefined( self.hideammoindex ) )
    {
        self.hideammoindex = 1;
    }
    
    assert( var_13463d1a4d35279b > 0, "<dev string:xb4>" );
    
    while ( user isusingturret() )
    {
        while ( user attackbuttonpressed() )
        {
            self.streakinfo.shots_fired++;
            self.ammocount--;
            user setclientomnvar( "ui_killstreak_weapon_1_ammo", self.ammocount );
            
            if ( self.ammocount <= 12 )
            {
                self setscriptablepartstate( "hide_ammo_" + self.hideammoindex, "on", 0 );
                self.hideammoindex++;
            }
            
            if ( self.ammocount == 100 )
            {
                user killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_low_ammo", #"ammo_low" );
            }
            else if ( self.ammocount <= 0 )
            {
                user killstreak_utility::playkillstreaktacomdialog( self.streakinfo, self.streakinfo.streakname + "_no_ammo", #"ammo_out" );
                self notify( #"kill_turret", 0, 0 );
                break;
            }
            
            wait var_13463d1a4d35279b;
        }
        
        waitframe();
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0x6cc6d7f1, Offset: 0x37f7
// Size: 0x51
function manualturret_watchdisown( owner )
{
    self endon( #"kill_turret" );
    self endon( #"carried_turret" );
    owner thread manualturret_disownonaction( self, "disconnect" );
    owner thread manualturret_disownonaction( self, "joined_team" );
    owner thread manualturret_disownonaction( self, "joined_spectators" );
}

// Namespace manual_turret
// Params 2
// Checksum 0x5691b22e, Offset: 0x3850
// Size: 0x67
function manualturret_disownonaction( turret, action )
{
    turret endon( #"kill_turret" );
    self endon( #"carried_turret" );
    self endon( #"hash_bf7403362d3fa11f" );
    level endon( #"game_ended" );
    self waittill( action );
    turret notify( #"kill_turret", 0, 0 );
    self notify( #"hash_bf7403362d3fa11f" );
}

// Namespace manual_turret
// Params 1
// Checksum 0x9905eb88, Offset: 0x38bf
// Size: 0x7d
function manualturret_setturretmodel( type )
{
    turretmodel = undefined;
    
    if ( type == "placed" )
    {
        turretmodel = level.sentrysettings[ self.turrettype ].modelbaseground;
    }
    else
    {
        turretmodel = level.sentrysettings[ self.turrettype ].modeldestroyedground;
    }
    
    assert( isdefined( turretmodel ), "<dev string:x11d>" );
    self setmodel( turretmodel );
}

// Namespace manual_turret
// Params 1
// Checksum 0x7202180b, Offset: 0x3944
// Size: 0x53
function manualturret_makealltriggersusable( bool )
{
    if ( !bool )
    {
        self.useownerobj setusableenabled( 0 );
        self.useotherobj setusableenabled( 0 );
        return;
    }
    
    self.useownerobj setusableenabled( 1 );
    self.useotherobj setusableenabled( 1 );
}

// Namespace manual_turret
// Params 1
// Checksum 0x96ae3103, Offset: 0x399f
// Size: 0x95
function manualturret_toggleallowplacementactions( allow )
{
    if ( allow )
    {
        val::reset_all( "manual_turret_placement" );
        return;
    }
    
    if ( player::isreallyalive() )
    {
        val::set( "manual_turret_placement", "sprint", 0 );
        val::set( "manual_turret_placement", "weapon_switch", 0 );
        val::set( "manual_turret_placement", "offhand_weapons", 0 );
        val::set( "manual_turret_placement", "melee", 0 );
        val::set( "manual_turret_placement", "execution_attack", 0 );
        val::set( "manual_turret_placement", "ladder_placement", 0 );
    }
}

// Namespace manual_turret
// Params 1
// Checksum 0xbcfc96f1, Offset: 0x3a3c
// Size: 0x71
function manualturret_toggleallowuseactions( allow )
{
    if ( allow )
    {
        val::reset_all( "manual_turret_use" );
        return;
    }
    
    if ( player::isreallyalive() )
    {
        val::set( "manual_turret_use", "offhand_weapons", 0 );
        val::set( "manual_turret_use", "melee", 0 );
        val::set( "manual_turret_use", "supers", 0 );
        val::set( "manual_turret_use", "allow_movement", 0 );
    }
}

