// scripts\mp\common\killstreaks\missile_turret.gsc  (hash_696443fd7c8f7ef5.gscc) (size: 38574 Bytes / 0x96ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d1d02ec (2099053292)
// size ...... 38574 (0x96ae)
// includes .. 20  (offset: 0x8fb2)
// strings ... 80  (offset: 0x9052)
// dev strs .. 17  (offset: 0x95c2)
// exports ... 80  (offset: 0x6596)
// cseg ...... 0x58d + 0x6009 (0x6596)
// imports ... 235 (offset: 0x7216)
// animtree1 . 0   (offset: 0x96ae)
// animtree2 . 0   (offset: 0x96ae)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;

#namespace missile_turret;

// Namespace missile_turret
// Params 0, eflags: 0x1
// Checksum 0x7212775d, Offset: 0x5ab
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "missile_turret" ), &init );
}

// Namespace missile_turret
// Params 0, eflags: 0x4
// Checksum 0xa65a7f77, Offset: 0x5ca
// Size: 0x16d
function private init()
{
    level callback::add( #"killstreak_damaged", &onkillstreakdamaged );
    level callback::add( #"killstreak_destroyed", &onkillstreakdestroyed );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "missile_turret", &function_e3ee3b0145fdc56d );
    }
    
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    
    if ( isdefined( bundle.var_2dd1862acd385522 ) && utility::issharedfuncdefined( #"killstreak", #"registerKillstreakDamageDealingWeapon" ) )
    {
        registerfunction = utility::getsharedfunc( #"killstreak", #"registerKillstreakDamageDealingWeapon" );
        [[ registerfunction ]]( "missile_turret", bundle.var_2dd1862acd385522, #"large" );
        [[ registerfunction ]]( "missile_turret", bundle.var_a3b254e7f7650b04, #"large" );
    }
    
    utility::registersharedfunc( #"missile_turret", #"missile_turret_hack", &missileturret_hack );
    utility::registersharedfunc( #"missile_turret", #"hack", &hack );
    missileturret_initdvars();
    function_916413fb74063e28();
    function_8c4052ee85fae2cf();
}

// Namespace missile_turret
// Params 0
// Checksum 0x149eff57, Offset: 0x73f
// Size: 0x33
function missileturret_initdvars()
{
    /#
        setdevdvarifuninitialized( @"hash_c9bd691ce96079ac", 0 );
        setdevdvarifuninitialized( @"hash_8339cedf7d2c80b9", 0 );
        setdvarifuninitialized( @"hash_a42516bfaeb6df0f", 10 );
    #/
}

// Namespace missile_turret
// Params 3
// Checksum 0x8df8f91a, Offset: 0x77a
// Size: 0x2d
function function_5322f4e14ebd3fe4( streakinfo, switchresult, weaponobj )
{
    if ( !switchresult )
    {
        killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0xdc9bcd7e, Offset: 0x7af
// Size: 0x29
function tryusemissileturret( streakname )
{
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    return function_e3ee3b0145fdc56d( streakinfo );
}

// Namespace missile_turret
// Params 1
// Checksum 0xb20c49fa, Offset: 0x7e1
// Size: 0x365, Type: bool
function function_e3ee3b0145fdc56d( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            self.var_515e21ffd3b980ab = 0;
            return false;
        }
    }
    
    weapon_utility::saveweaponstates();
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    endonnotify = "sentry_placement_failed";
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    weaponobj = makeweapon( bundle.deployweapon );
    
    if ( utility::issharedfuncdefined( #"weapons", #"watchforplacementfirestate" ) )
    {
        self thread [[ utility::getsharedfunc( #"weapons", #"watchforplacementfirestate" ) ]]( streakinfo, endonnotify );
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, weaponobj, 1, undefined, undefined, &function_5322f4e14ebd3fe4 );
    
    if ( !deployresult )
    {
        self notify( endonnotify );
        self.var_515e21ffd3b980ab = 0;
        return false;
    }
    
    manual_turret::manualturret_toggleallowplacementactions( 0 );
    turret = missileturret_create( "missile_turret", streakinfo );
    
    if ( !isdefined( turret ) )
    {
        manual_turret::manualturret_toggleallowplacementactions( 1 );
        self.var_515e21ffd3b980ab = 0;
        return false;
    }
    
    turret function_1049f1c113ec3a57( bundle );
    marker = missileturret_watchplacement( turret, streakinfo, 0, 1.25, weaponobj );
    
    if ( !isdefined( marker ) )
    {
        manual_turret::manualturret_toggleallowplacementactions( 1 );
        turret delete();
        self.var_515e21ffd3b980ab = 0;
        return false;
    }
    
    streakinfo.streakduration = turret.timeout;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            self.var_515e21ffd3b980ab = 0;
            return false;
        }
    }
    
    turret namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( turret, &missileturret_empapplied, &missileturret_empstarted, &missileturret_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        turret.var_5b3dbacfeda0fd01 = &missileturret_empstarted;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempapplycallback = &missileturret_empapplied;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempclearcallback = &function_88734c4efa69fc41;
    }
    
    turret haywire::function_7f69a1eb3d590f76( &missileturret_haywireapplied );
    turret haywire::function_d7496c23fe4085d4( &function_67223403f6df88f0 );
    turret.lifetimeendtime = int( turret.timeout * 1000 + gettime() );
    manual_turret::manualturret_toggleallowplacementactions( 1 );
    missileturret_setplaced( turret, marker );
    turret setscriptablepartstate( "InitialLids", "init" );
    turret setscriptablepartstate( #"visibility", #"show" );
    
    if ( utility::issharedfuncdefined( #"missile_turret", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( #"missile_turret", #"munitionused" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"player", #"doonactionscoreevent" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"doonactionscoreevent" ) ]]( 2, "missileTurretUsed" );
    }
    
    self notify( #"munitions_used", "missile_turret" );
    return true;
}

// Namespace missile_turret
// Params 1
// Checksum 0x61b32bb2, Offset: 0xb4f
// Size: 0xa0
function function_1049f1c113ec3a57( bundle )
{
    var_38a606b2e7efe23e = istrue( bundle.var_71a44f6c2af3daa9 );
    
    if ( var_38a606b2e7efe23e )
    {
        self.shootingpositions = [ 1, 2, 3, 4, 5, 6, 7, 8 ];
        return;
    }
    
    self.shootingpositions = [ 1, 5, 2, 6, 3, 7, 4, 8 ];
}

// Namespace missile_turret
// Params 5
// Checksum 0xfbe40338, Offset: 0xbf7
// Size: 0x1d6
function missileturret_watchplacement( turret, streakinfo, ignorecancel, var_c6c7c3535d7e7bda, deployweapon )
{
    self.var_515e21ffd3b980ab = 1;
    turret laseroff();
    thread utility::callsharedfunc( #"killstreak", #"manualturret_delayplacementinstructions", var_c6c7c3535d7e7bda );
    thread utility::callsharedfunc( #"killstreak", #"hash_29252bc7877f4fbe" );
    marker = undefined;
    val::set( "missile_turret", "mantle", 0 );
    val::set( "missile_turret", "ladder", 0 );
    marker = missileturret_gettargetmarker( streakinfo, ignorecancel );
    val::set( "missile_turret", "mantle", 1 );
    val::set( "missile_turret", "ladder", 1 );
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    
    if ( !( isdefined( marker ) && isdefined( marker.location ) ) )
    {
        if ( player::isreallyalive() && self getcurrentweapon() == deployweapon )
        {
            killstreak_utility::killstreak_switchbacklastweapon( deployweapon );
        }
        
        self notify( #"turret_placement_finished" );
        return;
    }
    
    turret thread manual_turret::manualturret_disablefire( self, 1, 1 );
    
    if ( self getcurrentweapon() == deployweapon )
    {
        thread killstreak_utility::killstreak_switchbacklastweapon( deployweapon, 1, 1 );
    }
    
    var_1f804af8a4435c33 = 1;
    delayspawntime = 0.85;
    timeout = hostmigration::waittillnotifyortimeoutpause( "equip_deploy_cancel", delayspawntime );
    
    if ( !isdefined( timeout ) || isstring( timeout ) && timeout == "timeout" )
    {
        var_1f804af8a4435c33 = 0;
        waitframe();
    }
    
    self notify( #"turret_placement_finished" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    return var_1f804af8a4435c33 ? marker : undefined;
}

// Namespace missile_turret
// Params 2
// Checksum 0xd5e71090, Offset: 0xdd6
// Size: 0x49a
function missileturret_create( turrettype, streakinfo )
{
    config = level.missilesettings[ turrettype ];
    verticalspawnoffset = getdvarint( @"hash_a42516bfaeb6df0f" );
    turret = spawnturret( "misc_turret", self.origin + ( 0, 0, verticalspawnoffset ), level.missilesettings[ turrettype ].weaponinfo );
    turret.owner = self;
    turret.team = self.team;
    
    /#
        forceenemyteam = getdvarint( @"hash_8339cedf7d2c80b9", 0 );
        
        if ( forceenemyteam )
        {
            turret.team = self.team == "<dev string:x24>" ? "<dev string:x2b>" : "<dev string:x24>";
        }
    #/
    
    turret.angles = self.angles;
    turret.health = 9999;
    turret.maxhealth = config.maxhealth;
    turret.lowhealth = config.lowhealth;
    turret.streakinfo = streakinfo;
    turret.turrettype = turrettype;
    turret.shouldsplash = 1;
    turret.ammocount = config.ammo;
    turret.timeout = config.timeout;
    turret.var_87ec6969d861f7b6 = config.nummissiles;
    turret.var_1beb33a92b9d178d = config.nummissiles;
    turret.var_d41782dc2248f73d = config.var_d41782dc2248f73d;
    turret.var_eea7488374f7ee93 = 0;
    
    /#
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            turret.timeout = 9999;
        }
    #/
    
    turret.carriedby = self;
    turret missileturret_setturretmodel( "placed" );
    turret setturretowner( turret.owner );
    turret setturretteam( turret.team );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( level.missilesettings[ turret.turrettype ].defaultdroppitch );
    turret hide();
    turret setautorotationdelay( 0.2 );
    turret.momentum = 0;
    
    switch ( turrettype )
    {
        case #"hash_b571a6187bf67f9e":
        default:
            turret maketurretinoperable();
            turret setleftarc( 180 );
            turret setrightarc( 180 );
            turret setbottomarc( 50 );
            turret settoparc( 120 );
            turret setconvergencetime( 0.2, "pitch" );
            turret setconvergencetime( 0.2, "yaw" );
            turret setconvergenceheightpercent( 0.65 );
            turret setdefaultdroppitch( level.missilesettings[ turret.turrettype ].defaultdroppitch );
            break;
    }
    
    turret setturretmodechangewait( 1 );
    turret emp_debuff::allow_emp( 0 );
    killcamforward = anglestoforward( turret.angles );
    killcampos = turret gettagorigin( "tag_laser" ) + ( 0, 0, 10 );
    killcampos -= killcamforward * 20;
    killcament = spawn( "script_model", killcampos );
    killcament linkto( turret );
    turret.killcament = killcament;
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( bundle.playercolmodel ?? "vm_jup_2h_sam_turret_00_ivisi_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    return turret;
}

// Namespace missile_turret
// Params 2
// Checksum 0x2f8cbb1d, Offset: 0x1279
// Size: 0x68f
function missileturret_setplaced( turret, marker )
{
    config = level.missilesettings[ turret.turrettype ];
    function_e83ae446f2daa5f4( turret, self );
    level.missileturrets = arraycombineunique( level.missileturrets, [ turret ] );
    turret missileturret_setturretmodel( "placed" );
    
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
        
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) && isdefined( splashname ) )
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
    
    self.var_515e21ffd3b980ab = 0;
    turret.origin = marker.location;
    turret setscriptablepartstate( "turret_carry_state", "turret_plant" );
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret, "tag_turret" );
    turret missileturret_createobjective();
    turretcount = self.placedsentries[ turret.turrettype ].size;
    self.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    
    if ( turretcount + 1 > 2 )
    {
        self.placedsentries[ turret.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
    }
    
    turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeon );
    hinttag = "bi_base";
    var_287007dfbb80ea59 = anglestoup( turret gettagangles( hinttag ) ) * 20;
    hintpos = turret gettagorigin( hinttag ) + var_287007dfbb80ea59;
    
    if ( !isdefined( turret.useownerobj ) )
    {
        turret.useownerobj = missileturret_createhintobject( hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show" );
    }
    else
    {
        turret.useownerobj setusableenabled( 1 );
        turret.useownerobj dontinterpolate();
        turret.useownerobj.origin = hintpos;
    }
    
    turret.useownerobj linkto( turret, hinttag );
    
    foreach ( guy in level.players )
    {
        if ( guy != turret.owner )
        {
            turret.useownerobj disableplayeruse( guy );
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"handlemovingplatform" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"handlemovingplatform" ) ]]( turret );
    }
    
    headiconoffset = 70;
    
    if ( isdefined( level.missilesettings[ turret.turrettype ].modelbasecover ) )
    {
        if ( turret.model == level.missilesettings[ turret.turrettype ].modelbasecover )
        {
            headiconoffset = 35;
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        turret [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried" );
    }
    
    turret emp_debuff::allow_emp( 1 );
    
    if ( utility::issharedfuncdefined( #"game", #"registersentient" ) )
    {
        turret [[ utility::getsharedfunc( #"game", #"registersentient" ) ]]( "Killstreak_Static", self );
    }
    
    turret function_b941d43ea16efa31( turret );
    turret thread missile_attacktargets( undefined, self );
    
    /#
        turret thread function_9d59ff59c7fd4c40();
    #/
    
    turret thread missile_beepsounds();
    thread missileturret_delaydeletemarker( turret, marker );
    thread function_67b338799b32144b( turret );
    thread missileturret_watchpickup( turret );
    thread missileturret_watchdamage( turret );
    thread missileturret_watchdeath( turret );
    thread missileturret_watchtimeout( turret );
    thread missileturret_watchdisown( turret );
    thread missileturret_watchgameend( turret );
    turret notify( #"hash_db521cf8a268eb0a" );
    thread function_a4c72e1a5f24194b( turret );
    thread function_6ddb4ead21cd3b2a( turret );
    utility::function_969f9f5596dba07a( turret, &function_d037750b1c2b9d92 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_ca0042e3cac99672" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret, &function_b941d43ea16efa31, &function_b941d43ea16efa31 );
    }
}

// Namespace missile_turret
// Params 0
// Checksum 0xa6054ebd, Offset: 0x1910
// Size: 0x12
function function_d037750b1c2b9d92()
{
    self notify( #"kill_turret", 1, 1 );
}

// Namespace missile_turret
// Params 0
// Checksum 0x6e3b7f0b, Offset: 0x192a
// Size: 0x41
function missileturret_createobjective()
{
    killstreakbundle = level.streakglobals.streakbundles[ "missile_turret" ];
    self.minimapid = killstreak_utility::function_99456b220fc6798e( "missile_turret", undefined, killstreakbundle, undefined, 1 );
}

// Namespace missile_turret
// Params 1
// Checksum 0xeca4c0de, Offset: 0x1973
// Size: 0x8e
function function_d5daba294b1701cb( targetent )
{
    if ( isdefined( targetent ) && isdefined( targetent.owner ) && player_utility::isenemy( targetent.owner ) )
    {
        if ( isdefined( targetent.streakname ) && utility::issharedfuncdefined( targetent.streakname, #"lockedon" ) )
        {
            targetent.owner [[ utility::getsharedfunc( targetent.streakname, #"lockedon" ) ]]( self, targetent );
        }
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x78770268, Offset: 0x1a09
// Size: 0x8e
function function_b8131970d170ca0d( targetent )
{
    if ( isdefined( targetent ) && isdefined( targetent.owner ) && player_utility::isenemy( targetent.owner ) )
    {
        if ( isdefined( targetent.streakname ) && utility::issharedfuncdefined( targetent.streakname, #"lockedoncanceled" ) )
        {
            targetent.owner [[ utility::getsharedfunc( targetent.streakname, #"lockedoncanceled" ) ]]( self, targetent );
        }
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x8dcb5838, Offset: 0x1a9f
// Size: 0x9d
function function_6ddb4ead21cd3b2a( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    level endon( #"game_ended" );
    prevtargetent = undefined;
    
    while ( true )
    {
        targetent = turret.targetentityref;
        
        if ( !isdefined( prevtargetent ) && !isdefined( targetent ) )
        {
            waitframe();
            continue;
        }
        
        if ( !( isdefined( prevtargetent ) && isdefined( targetent ) ) || prevtargetent != targetent )
        {
            turret function_b8131970d170ca0d( prevtargetent );
            turret function_d5daba294b1701cb( targetent );
        }
        
        prevtargetent = targetent;
        waitframe();
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0xaac041e5, Offset: 0x1b44
// Size: 0x6df
function function_a4c72e1a5f24194b( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    vehicletargetscategory = [];
    turret setsentrypitch( level.missilesettings[ turret.turrettype ].var_c27094ce883af2ba );
    
    if ( !isdefined( bundle ) || !bundle.var_d0a9b08c5629912a )
    {
        vehicletargetscategory = [ "chopper_gunner", "counter_uav", "scrambler_drone_guard", "uav", "valkyrie_rocket", "switchblade_drone", "loitering_munition", "hover_jet", "gunship", "airdrop_escort" ];
    }
    else
    {
        foreach ( vehicleentry in bundle.vehicleentries )
        {
            if ( isdefined( vehicleentry.name ) )
            {
                vehicletargetscategory[ vehicletargetscategory.size ] = vehicleentry.name;
            }
        }
    }
    
    while ( true )
    {
        wait 1;
        
        if ( turret.isdisabled )
        {
            turret cleartargetentity();
            turret.targetentityref = undefined;
            continue;
        }
        
        targetent = turret gettargetentity();
        
        if ( !isdefined( targetent ) || targetent.var_b8aae568e66b4bc7 )
        {
            entitiesfound = [];
            var_9373d2c56cb4b452 = [];
            targetcategory = undefined;
            
            if ( isdefined( level.activekillstreaks ) )
            {
                foreach ( ent in level.activekillstreaks )
                {
                    isdifferentteam = isdefined( ent.team ) && ent.team != turret.team;
                    
                    if ( !isdifferentteam )
                    {
                        continue;
                    }
                    
                    isvalidtarget = 0;
                    
                    foreach ( category in vehicletargetscategory )
                    {
                        if ( ent.streakname == category || ent.vehiclename == category )
                        {
                            if ( ent.var_b8aae568e66b4bc7 )
                            {
                                continue;
                            }
                            
                            isvalidtarget = 1;
                            targetcategory = category;
                            break;
                        }
                    }
                    
                    if ( isdifferentteam && isvalidtarget )
                    {
                        var_9373d2c56cb4b452[ var_9373d2c56cb4b452.size ] = ent;
                    }
                }
            }
            
            if ( isdefined( level.vehicle.instances ) )
            {
                foreach ( category in vehicletargetscategory )
                {
                    if ( isdefined( level.vehicle.instances[ category ] ) )
                    {
                        foreach ( vehicle in level.vehicle.instances[ category ] )
                        {
                            if ( isdefined( vehicle.ownerteam ) && isenemyteam( vehicle.ownerteam, turret.team ) )
                            {
                                var_9373d2c56cb4b452[ var_9373d2c56cb4b452.size ] = vehicle;
                                targetcategory = category;
                                continue;
                            }
                            
                            if ( isdefined( vehicle.team ) && vehicle.team != "neutral" && isenemyteam( vehicle.team, turret.team ) )
                            {
                                if ( vehicle.owner == turret.owner )
                                {
                                    continue;
                                }
                                
                                var_9373d2c56cb4b452[ var_9373d2c56cb4b452.size ] = vehicle;
                                targetcategory = category;
                            }
                        }
                    }
                }
            }
            
            targetent = undefined;
            
            foreach ( ent in var_9373d2c56cb4b452 )
            {
                if ( isdefined( ent ) && function_ee8a94b6ffa3bf53( turret, ent ) )
                {
                    targetent = ent;
                    break;
                }
                
                waitframe();
            }
            
            if ( utility::issharedfuncdefined( #"flare_system", #"hash_bb66c31dec02b91a" ) )
            {
                flaresystemresult = turret [[ utility::getsharedfunc( #"flare_system", #"hash_bb66c31dec02b91a" ) ]]( targetent );
                
                if ( flaresystemresult != #"lockon_success" )
                {
                    continue;
                }
            }
            
            if ( isdefined( targetent ) )
            {
                turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeon );
                wait 0.5;
                
                if ( isdefined( targetent ) )
                {
                    turret settargetentity( targetent );
                    turret.var_eea7488374f7ee93 = 1;
                    turret.var_9b458beec84087f7 = targetent.health;
                    turret.var_ec23dfbb76c91253 = targetent.maxhealth;
                    turret.var_8d7c59163952d631 = function_2861348911093875( targetcategory );
                    turret.var_8cb1ce303473fc3d = turret.var_8d7c59163952d631;
                }
            }
            
            if ( !isdefined( targetent ) )
            {
                turret setsentrypitch( level.missilesettings[ turret.turrettype ].var_c27094ce883af2ba );
            }
            
            turret.targetentityref = targetent;
        }
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x230cc149, Offset: 0x222b
// Size: 0x1db
function function_2861348911093875( targetcategory )
{
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    nummissiles = 0;
    
    if ( !isdefined( bundle ) || !bundle.var_d0a9b08c5629912a )
    {
        switch ( targetcategory )
        {
            case #"hash_349713b5ad494dda":
                nummissiles = 3;
                break;
            case #"hash_10e585c25e7e9f60":
            case #"hash_27002778019fb447":
                nummissiles = 1;
                break;
            case #"hash_634b246c3da5c56f":
                nummissiles = 1;
                break;
            case #"hash_1fd582647e25c2c1":
                nummissiles = 1;
                break;
            case #"hash_7a687f6a4d685110":
                nummissiles = 1;
                break;
            case #"hash_a1031216158c7882":
                nummissiles = 3;
                break;
            case #"hash_bf2f9adbd2b41d5":
                nummissiles = 3;
                break;
            case #"hash_413c38e72fe8b5bf":
                nummissiles = 3;
                break;
            case #"hash_887ad77192b9c4fb":
                nummissiles = 3;
                break;
            case #"hash_9e36e3bd3a9dd00d":
                nummissiles = 1;
                break;
        }
    }
    else
    {
        foreach ( vehicleentry in bundle.vehicleentries )
        {
            if ( isdefined( vehicleentry.name ) && isdefined( vehicleentry.nummissiles ) )
            {
                if ( vehicleentry.name == targetcategory )
                {
                    nummissiles = vehicleentry.nummissiles;
                    break;
                }
            }
        }
    }
    
    return nummissiles;
}

// Namespace missile_turret
// Params 2
// Checksum 0x5e391177, Offset: 0x240f
// Size: 0x1d1
function function_ee8a94b6ffa3bf53( turret, ent )
{
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    contentoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
    flashid = ( turret.var_1beb33a92b9d178d - turret.var_87ec6969d861f7b6 ) % bundle.var_b51d4ae420498089;
    muzzletag = "tag_fx_0" + turret.shootingpositions[ flashid ];
    var_f5ff53e334389506 = turret gettagorigin( muzzletag );
    radius = 16;
    height = 64;
    heightvector = ( 0, 0, height );
    getsurfacetype = 0;
    trace = trace::capsule_trace( var_f5ff53e334389506, ent.origin, radius, height, ( 0, 0, 0 ), [], contentoverride, getsurfacetype );
    
    /#
        if ( getdvarint( @"hash_c9bd691ce96079ac", 0 ) == 1 )
        {
            var_8646192b9ab59b3a = var_f5ff53e334389506;
            var_73af7df4495e02f = ent.origin;
            var_ae62152fb47594a8 = var_8646192b9ab59b3a + heightvector;
            var_fbbc5e7fd6671e39 = var_73af7df4495e02f + heightvector;
            function_dcae7e2a011d331f( var_ae62152fb47594a8, var_fbbc5e7fd6671e39, radius );
            function_b6b1ca4bd64e5a06( var_8646192b9ab59b3a, var_73af7df4495e02f, trace[ "<dev string:x30>" ], radius );
        }
    #/
    
    result = 0;
    
    if ( trace[ "hittype" ] != "hittype_world" )
    {
        result = 1;
    }
    else if ( trace[ "hittype" ] == "hittype_world" && trace[ "position" ][ 2 ] > 10000 )
    {
        result = 1;
    }
    
    return result;
}

// Namespace missile_turret
// Params 2
// Checksum 0xc46054e0, Offset: 0x25e9
// Size: 0x36a
function missileturret_handlemissilefire( turret, player )
{
    var_9a481c545b16bb6 = 0;
    
    if ( isdefined( turret ) && isdefined( turret.targetentityref ) && turret.canshootmissile )
    {
        distancetotarget = distance( turret.origin, turret.targetentityref.origin );
        
        if ( distancetotarget <= level.missilesettings[ turret.turrettype ].attackrange )
        {
            bundle = level.streakglobals.streakbundles[ "missile_turret" ];
            flashid = ( turret.var_1beb33a92b9d178d - turret.var_87ec6969d861f7b6 ) % bundle.var_b51d4ae420498089;
            muzzletag = "tag_fx_0" + turret.shootingpositions[ flashid ];
            var_f5ff53e334389506 = turret gettagorigin( muzzletag ) + anglestoforward( turret gettagangles( muzzletag ) ) * 10;
            missilestart = var_f5ff53e334389506;
            missileend = turret.targetentityref.origin;
            missileweapon = "chopper_gunner_proj_mp";
            
            if ( isdefined( bundle ) && isdefined( bundle.var_a3b254e7f7650b04 ) )
            {
                missileweapon = bundle.var_a3b254e7f7650b04;
            }
            
            missile = weapon_utility::_magicbullet( makeweapon( missileweapon ), missilestart, missileend, player, turret );
            missile.streakinfo = turret.streakinfo;
            missile.var_49796e09a967fd8e = turret.var_49796e09a967fd8e;
            offsetlocal = ( 0, 0, 0 );
            targettag = turret.targetentityref.veh_targettag;
            targettag = targettag ?? "tag_deathfx";
            tagvalue = undefined;
            hastag = turret.targetentityref tagexists( targettag );
            
            if ( hastag )
            {
                tagvalue = turret.targetentityref gettagorigin( targettag );
            }
            
            if ( isdefined( tagvalue ) )
            {
                offsetwc = tagvalue - turret.targetentityref.origin;
                offsetlocal = rotatevectorinverted( offsetwc, turret.targetentityref.angles );
            }
            
            thread missileturret_delaymissiletracking( missile, turret.targetentityref );
            
            if ( utility::issharedfuncdefined( #"flare_system", #"attacker_fire_missile" ) )
            {
                turret [[ utility::getsharedfunc( #"flare_system", #"attacker_fire_missile" ) ]]( missile, turret.targetentityref );
            }
            
            level notify( #"stinger_fired", player, missile, turret.targetentityref );
            var_9a481c545b16bb6 = 1;
            turret setscriptablepartstate( "turret_firing_state", "turret_firing" );
            
            if ( turret getscriptableparthasstate( muzzletag, "fire" ) )
            {
                turret setscriptablepartstate( muzzletag, "fire" );
            }
            
            wait 0.05;
            turret setscriptablepartstate( "turret_firing_state", "off" );
            
            if ( turret getscriptableparthasstate( muzzletag, "off" ) )
            {
                turret setscriptablepartstate( muzzletag, "off" );
            }
        }
    }
    
    return var_9a481c545b16bb6;
}

// Namespace missile_turret
// Params 1, eflags: 0x4
// Checksum 0x91cb73c6, Offset: 0x295c
// Size: 0xcb
function private onkillstreakdamaged( params )
{
    trackingdata = params.inflictor.var_49796e09a967fd8e;
    
    if ( !isstruct( trackingdata ) )
    {
        return;
    }
    
    if ( trackingdata.player != params.attacker )
    {
        return;
    }
    
    if ( !isdefined( params.damagedkillstreak.missileturretdamagedata ) )
    {
        params.damagedkillstreak.missileturretdamagedata = [];
    }
    
    if ( params.damagedkillstreak.missileturretdamagedata[ trackingdata.id ] )
    {
        return;
    }
    
    params.damagedkillstreak.missileturretdamagedata[ trackingdata.id ] = trackingdata;
}

// Namespace missile_turret
// Params 1, eflags: 0x4
// Checksum 0xcce56a34, Offset: 0x2a2f
// Size: 0x118
function private onkillstreakdestroyed( params )
{
    foreach ( trackingdata in params.killedkillstreak.missileturretdamagedata )
    {
        if ( !trackingdata.player || trackingdata.var_8b11f112278a86ee )
        {
            continue;
        }
        
        trackingdata.var_b3ff6477eb144b2b++;
        
        if ( trackingdata.var_b3ff6477eb144b2b == 2 )
        {
            trackingdata.var_8b11f112278a86ee = 1;
            trackingdata.player thread points::doscoreevent( #"sam_turret_double" );
            function_136ac95488e03ddc( trackingdata.player, trackingdata );
        }
    }
    
    params.killedkillstreak.missileturretdamagedata = undefined;
}

// Namespace missile_turret
// Params 2, eflags: 0x4
// Checksum 0xcd3727bd, Offset: 0x2b4f
// Size: 0x10b
function private function_e83ae446f2daa5f4( turret, player )
{
    if ( player.var_49796e09a967fd8e[ turret.birthtime ] )
    {
        return;
    }
    
    trackingdata = { #var_b3ff6477eb144b2b:0, #var_8b11f112278a86ee:0, #id:player.guid + "_" + turret.birthtime, #player:player, #var_e56636f24d9ffae8:turret.birthtime, #turret:turret };
    
    if ( !isdefined( player.var_49796e09a967fd8e ) )
    {
        player.var_49796e09a967fd8e = [];
    }
    
    player.var_49796e09a967fd8e[ turret.birthtime ] = trackingdata;
    
    if ( !isdefined( player.var_81fbf5451beb540d ) )
    {
        player.var_81fbf5451beb540d = 0;
    }
    
    player.var_81fbf5451beb540d++;
    turret.var_49796e09a967fd8e = trackingdata;
}

// Namespace missile_turret
// Params 2, eflags: 0x4
// Checksum 0xc60c65b4, Offset: 0x2c62
// Size: 0xb6
function private function_136ac95488e03ddc( player, trackingdata )
{
    if ( player.var_49796e09a967fd8e[ trackingdata.var_e56636f24d9ffae8 ] == trackingdata )
    {
        player.var_49796e09a967fd8e[ trackingdata.var_e56636f24d9ffae8 ] = undefined;
        player.var_81fbf5451beb540d--;
        
        if ( player.var_81fbf5451beb540d == 0 )
        {
            player.var_49796e09a967fd8e = undefined;
            player.var_81fbf5451beb540d = undefined;
        }
    }
    
    if ( trackingdata.turret.var_49796e09a967fd8e == trackingdata )
    {
        trackingdata.turret.var_49796e09a967fd8e = undefined;
    }
    
    trackingdata.turret = undefined;
}

// Namespace missile_turret
// Params 1, eflags: 0x4
// Checksum 0xaab1888a, Offset: 0x2d20
// Size: 0x3d
function private function_a3b1df4341f35224( trackingdata )
{
    level endon( #"game_ended" );
    wait 5;
    
    if ( trackingdata.player )
    {
        function_136ac95488e03ddc( trackingdata.player, trackingdata );
    }
}

// Namespace missile_turret
// Params 2
// Checksum 0xfeaf9253, Offset: 0x2d65
// Size: 0x4d
function missileturret_delaymissiletracking( missile, missiletargetent )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 0.1 );
    
    if ( isdefined( missile ) && isdefined( missiletargetent ) )
    {
        missile missile_settargetent( missiletargetent );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x97ceab7e, Offset: 0x2dba
// Size: 0x42f
function missileturret_setcarried( turret )
{
    turret endon( #"kill_turret" );
    level endon( #"game_ended" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_c33ceb91d0ca7a9d" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    
    if ( isdefined( turret.moving_platform ) )
    {
        turret.moving_platform = undefined;
        turret.moving_platform_offset = undefined;
        turret.moving_platform_angles_offset = undefined;
        turret unlink();
    }
    
    turret emp_debuff::allow_emp( 0 );
    
    if ( utility::issharedfuncdefined( #"game", #"unregistersentient" ) )
    {
        turret [[ utility::getsharedfunc( #"game", #"unregistersentient" ) ]]( turret.sentientpool, turret.sentientpoolindex );
    }
    
    linkedchildren = turret getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( isdefined( child ) )
        {
            child unlink();
        }
    }
    
    if ( isdefined( turret.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( turret.minimapid );
        }
        
        turret.minimapid = undefined;
    }
    
    turret.colmodel unlink();
    turret.colmodel hide();
    missileturret_setinactive( turret );
    turret hide();
    turret.carriedby = self;
    turret notify( #"carried" );
    turret playsound( "kls_sam_turret_pickup" );
    
    if ( isdefined( turret.targetentityref ) )
    {
        turret function_b8131970d170ca0d( turret.targetentityref );
        turret.targetentityref = undefined;
    }
    
    weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    
    if ( utility::issharedfuncdefined( #"weapons", #"watchforplacementfirestate" ) )
    {
        self thread [[ utility::getsharedfunc( #"weapons", #"watchforplacementfirestate" ) ]]( turret.streakinfo, endonnotify );
    }
    
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    weaponobj = makeweapon( bundle.deployweapon );
    turret.streakinfo.var_53cb7968c54bb61d = 1;
    turret.streakinfo.var_37df6fe5dd599cc0 = 0;
    switchresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( turret.streakinfo, weaponobj, 1, undefined, undefined, &function_5322f4e14ebd3fe4 );
    
    if ( !switchresult )
    {
        self notify( endonnotify );
        level.missileturrets = arrayremove( level.missileturrets, turret );
        turret delete();
        self.var_515e21ffd3b980ab = 0;
        utility::callsharedfunc( #"killstreak", #"refundkillstreak", "missile_turret", 1, 0, 0, 1 );
        return 0;
    }
    
    manual_turret::manualturret_toggleallowplacementactions( 0 );
    marker = missileturret_watchplacement( turret, turret.streakinfo, 1, 2, weaponobj );
    
    if ( !isdefined( marker ) )
    {
        manual_turret::manualturret_toggleallowplacementactions( 1 );
        level.missileturrets = arrayremove( level.missileturrets, turret );
        turret delete();
        self.var_515e21ffd3b980ab = 0;
        utility::callsharedfunc( #"killstreak", #"refundkillstreak", "missile_turret", 1, 0, 0, 1 );
        return 0;
    }
    
    manual_turret::manualturret_toggleallowplacementactions( 1 );
    missileturret_setplaced( turret, marker );
}

// Namespace missile_turret
// Params 1
// Checksum 0xbbc3b6c6, Offset: 0x31f1
// Size: 0x6b
function missileturret_switchbacklastweapon( immediateswitch )
{
    if ( immediateswitch )
    {
        inventory_utility::_switchtoweaponimmediate( self.lastdroppableweaponobj );
    }
    else
    {
        inventory_utility::_switchtoweapon( self.lastdroppableweaponobj );
    }
    
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    inventory_utility::_takeweapon( bundle.deployweapon );
}

// Namespace missile_turret
// Params 1
// Checksum 0x65bc95bf, Offset: 0x3264
// Size: 0x79
function missileturret_setinactive( turret )
{
    turret setdefaultdroppitch( level.missilesettings[ turret.turrettype ].defaultdroppitch );
    turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeoff );
    turret.useownerobj setusableenabled( 0 );
    turret.useownerobj unlink();
}

// Namespace missile_turret
// Params 2
// Checksum 0x290e8991, Offset: 0x32e5
// Size: 0x10b
function function_b2dd7de238a43b26( turret, wasdestroyed )
{
    if ( !wasdestroyed )
    {
        turret cleartargetentity();
        turret laseroff();
        turret.targetentityref = undefined;
        
        if ( turret.var_87ec6969d861f7b6 > 0 )
        {
            turret setdefaultdroppitch( level.missilesettings[ turret.turrettype ].timeoutpitch );
        }
        else
        {
            turret setdefaultdroppitch( level.missilesettings[ turret.turrettype ].var_472f2ff38d4db8ad );
        }
        
        turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeoff );
        wait 0.4;
    }
    
    if ( level.missilesettings[ turret.turrettype ].var_f6155b6ff58b6811 )
    {
        turret setturretholdstill( 1 );
    }
    
    turret.useownerobj setusableenabled( 0 );
    turret.useownerobj unlink();
}

// Namespace missile_turret
// Params 2
// Checksum 0x7928cff2, Offset: 0x33f8
// Size: 0x53
function missileturret_delaydeletemarker( turret, marker )
{
    turret endon( #"kill_turret" );
    level endon( #"game_ended" );
    wait 0.25;
    
    if ( isdefined( marker.visual ) )
    {
        marker.visual delete();
    }
}

// Namespace missile_turret
// Params 2
// Checksum 0xe164a04c, Offset: 0x3453
// Size: 0x76
function missileturret_disableplayeruseonconnect( turret, useobj )
{
    if ( isdefined( turret ) )
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

// Namespace missile_turret
// Params 1
// Checksum 0xd099cf2b, Offset: 0x34d1
// Size: 0x15c
function missileturret_watchpickup( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    turret endon( #"missile_turret_hacked" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        turret.useownerobj waittill( #"trigger", player );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player != self )
        {
            continue;
        }
        
        if ( !player missileturret_canpickup() )
        {
            continue;
        }
        
        if ( player.isjuggernaut )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_picked_up" );
            }
            
            continue;
        }
        
        turret.useownerobj setusableenabled( 0 );
        turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeoff );
        self.placedsentries[ turret.turrettype ] = arrayremove( self.placedsentries[ turret.turrettype ], turret );
        thread missileturret_setcarried( turret );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x1d91f5d5, Offset: 0x3635
// Size: 0xb3
function function_67b338799b32144b( turret )
{
    self notify( #"hash_f53fb5aacfcced79" );
    self endon( #"hash_f53fb5aacfcced79" );
    turret endon( #"kill_turret" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    var_3ee8c27e7e469912 = turret.streakinfo;
    markerinfo = function_2ef42d72eb1e2d7a( "equip_deploy_cancel" );
    
    if ( markerinfo.string == "equip_deploy_cancel" )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:var_3ee8c27e7e469912 } );
        turret notify( #"turret_deploy_cancelled" );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0xdba5548c, Offset: 0x36f0
// Size: 0x7f
function missileturret_disableplayerpickuponconnect( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player waittill( #"spawned_player" );
        turret.useownerobj disableplayeruse( player );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x903fdb55, Offset: 0x3777
// Size: 0x11f
function missileturret_watchdismantle( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( level.teambased )
        {
            if ( player.team != self.team )
            {
                continue;
            }
            
            continue;
        }
        
        if ( player != self )
        {
        }
    }
    
    thread missileturret_disableplayerdismantleonconnect( turret );
    
    while ( true )
    {
        turret.dismantleobj waittill( #"trigger", player );
        turret notify( #"kill_turret", 0, 1 );
        break;
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x97b7a370, Offset: 0x389e
// Size: 0x47
function missileturret_watchdamage( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    missileturret_monitordamage( turret );
}

// Namespace missile_turret
// Params 1
// Checksum 0x30a8a553, Offset: 0x38ed
// Size: 0x94
function missileturret_disableplayerdismantleonconnect( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player waittill( #"spawned_player" );
        
        if ( level.teambased )
        {
            if ( player.team != self.team )
            {
                continue;
            }
        }
    }
}

// Namespace missile_turret
// Params 1, eflags: 0x4
// Checksum 0x8c1bd892, Offset: 0x3989
// Size: 0x40
function private missileturret_empapplied( data )
{
    if ( emp_debuff::emp_debuff_get_emp_count() >= 2 )
    {
        turret = data.victim;
        turret notify( #"kill_turret", 1, 1 );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x333c6733, Offset: 0x39d1
// Size: 0xd5
function missileturret_empstarted( data )
{
    if ( isdefined( data.attacker ) )
    {
        if ( !data.var_fe6111ff085b2063 )
        {
            scoreevent = self.streakinfo.bundle.empedscoreevent ?? #"emp_disable";
            data.attacker thread utility::callsharedfunc( #"player", #"doScoreEvent", scoreevent );
        }
    }
    
    self setscriptablepartstate( #"empd", #"active", 0 );
    self turretfiredisable();
    self setmode( level.missilesettings[ self.turrettype ].sentrymodeoff );
    self laseroff();
    function_b941d43ea16efa31( self );
}

// Namespace missile_turret
// Params 1
// Checksum 0x4269f9ee, Offset: 0x3aae
// Size: 0x33
function missileturret_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    function_b941d43ea16efa31( self );
    self setscriptablepartstate( #"empd", #"neutral", 0 );
}

// Namespace missile_turret
// Params 1
// Checksum 0x99d9190d, Offset: 0x3ae9
// Size: 0x35
function function_88734c4efa69fc41( data )
{
    self turretfireenable();
    self setmode( level.missilesettings[ self.turrettype ].sentrymodeon );
}

// Namespace missile_turret
// Params 1
// Checksum 0x46ff6aa, Offset: 0x3b26
// Size: 0x206
function function_b941d43ea16efa31( turret )
{
    turret.isdisabled = turret emp_debuff::is_empd() || turret.isjammed || turret.ishaywire || turret.var_87ec6969d861f7b6 <= 0 || turret.hackdisrupted;
    
    if ( turret.isdisabled )
    {
        turret setdefaultdroppitch( level.missilesettings[ turret.turrettype ].defaultdroppitch );
        turret setsentrypitch( level.missilesettings[ turret.turrettype ].var_c27094ce883af2ba );
        turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeoff );
        self.useownerobj disableplayeruse( self.owner );
        wait 0.4;
        turret.isdisabled = turret emp_debuff::is_empd() || turret.isjammed || turret.ishaywire || turret.var_87ec6969d861f7b6 <= 0;
        
        if ( turret.isdisabled )
        {
            turret turretfiredisable();
            
            if ( level.missilesettings[ turret.turrettype ].var_f6159be88c224226 )
            {
                turret setturretholdstill( 1 );
            }
            
            turret laseroff();
        }
        else
        {
            function_b941d43ea16efa31( turret );
        }
        
        return;
    }
    
    turret setsentrypitch( level.missilesettings[ turret.turrettype ].var_c27094ce883af2ba );
    turret setturretholdstill( 0 );
    turret turretfireenable();
    turret setmode( level.missilesettings[ turret.turrettype ].sentrymodeon );
    self.useownerobj enableplayeruse( self.owner );
}

// Namespace missile_turret
// Params 1
// Checksum 0xf03dad62, Offset: 0x3d34
// Size: 0x5d
function missileturret_haywireapplied( data )
{
    attacker = data.attacker;
    
    if ( !self.ishaywire )
    {
        if ( player_utility::playersareenemies( self.owner, attacker ) )
        {
            self.ishaywire = 1;
            
            if ( isdefined( attacker ) )
            {
            }
            
            function_b941d43ea16efa31( self );
        }
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0xaebfee24, Offset: 0x3d99
// Size: 0x1e
function function_67223403f6df88f0( data )
{
    self.ishaywire = 0;
    function_b941d43ea16efa31( self );
}

// Namespace missile_turret
// Params 3, eflags: 0x4
// Checksum 0xe40b8494, Offset: 0x3dbf
// Size: 0x6b
function private function_5ff64135d5e8601e( attacker, duration, var_fe6111ff085b2063 )
{
    data = {};
    data.attacker = attacker;
    data.var_fe6111ff085b2063 = var_fe6111ff085b2063;
    missileturret_empstarted( data );
    utility::waittill_any_timeout( duration / 1000, "hacked_while_disrupted" );
    function_88734c4efa69fc41( data );
}

// Namespace missile_turret
// Params 1, eflags: 0xc
// Checksum 0xb3d88a3f, Offset: 0x3e32
// Size: 0x89
function private function_84e047e3ccc739e3( duration )
{
    self notify( #"hash_909a638196623bcd" );
    self endon( #"hash_909a638196623bcd" );
    self endon( #"death" );
    self.hackdisrupted = 1;
    utility::waittill_any_timeout( duration / 1000, "hacked_while_disrupted" );
    self setscriptablepartstate( #"hacked", #"neutral", 0 );
    self setscriptablepartstate( #"empd", #"neutral", 0 );
    self.hackdisrupted = undefined;
}

// Namespace missile_turret
// Params 2, eflags: 0x4
// Checksum 0x72c0a43b, Offset: 0x3ec3
// Size: 0x106
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        if ( self.owner )
        {
            self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"disrupted_hacked" );
        }
        
        thread function_84e047e3ccc739e3( hackeffect.hackduration );
        thread function_5ff64135d5e8601e( attacker, hackeffect.hackduration, hackeffect.var_fe6111ff085b2063 );
        self setscriptablepartstate( #"hacked", #"active", 0 );
        return;
    }
    
    if ( self.owner )
    {
        self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"stolen_hacked" );
    }
    
    self notify( #"hacked_while_disrupted" );
    missileturret_hack( attacker, self.owner );
    self setscriptablepartstate( #"hacked", #"neutral", 0 );
}

// Namespace missile_turret
// Params 2
// Checksum 0x604ef539, Offset: 0x3fd1
// Size: 0x46a
function missileturret_hack( newowner, oldowner )
{
    if ( isdefined( newowner ) )
    {
        self notify( #"missile_turret_hacked" );
        self setturretowner( newowner );
        self setturretteam( newowner.team );
        self.owner = newowner;
        self.team = newowner.team;
        
        if ( self.var_49796e09a967fd8e )
        {
            level thread function_a3b1df4341f35224( self.var_49796e09a967fd8e );
        }
        
        function_e83ae446f2daa5f4( self, newowner );
        bundle = level.streakglobals.streakbundles[ "missile_turret" ];
        
        if ( isdefined( oldowner ) )
        {
            oldowner.placedsentries[ self.turrettype ] = arrayremove( oldowner.placedsentries[ self.turrettype ], self );
        }
        
        if ( !isdefined( newowner.placedsentries ) )
        {
            newowner.placedsentries = [];
        }
        
        if ( !isdefined( newowner.placedsentries[ self.turrettype ] ) )
        {
            newowner.placedsentries[ self.turrettype ] = [];
        }
        
        turretcount = newowner.placedsentries[ self.turrettype ].size;
        newowner.placedsentries[ self.turrettype ][ turretcount ] = self;
        
        if ( turretcount + 1 > 2 )
        {
            newowner.placedsentries[ self.turrettype ][ 0 ] notify( #"kill_turret", 0, 0 );
        }
        
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            newowner [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( self.streakinfo.streakname );
        }
        
        killstreak_utility::killstreak_dangernotifyplayersinrange( newowner, newowner.team, 2000, self.streakinfo.streakname );
        hinttag = "bi_base";
        config = level.missilesettings[ self.turrettype ];
        var_287007dfbb80ea59 = anglestoup( self gettagangles( hinttag ) ) * 20;
        hintpos = self gettagorigin( hinttag ) + var_287007dfbb80ea59;
        
        if ( !isdefined( self.useownerobj ) )
        {
            self.useownerobj = missileturret_createhintobject( hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show" );
        }
        else
        {
            self.useownerobj setusableenabled( 1 );
            self.useownerobj dontinterpolate();
            self.useownerobj.origin = hintpos;
        }
        
        self.useownerobj linkto( self, hinttag );
        
        foreach ( guy in level.players )
        {
            if ( guy != self.owner )
            {
                self.useownerobj disableplayeruse( guy );
                continue;
            }
            
            self.useownerobj enableplayeruse( guy );
        }
        
        config = level.missilesettings[ self.turrettype ];
        self.timeout = config.timeout;
        newowner thread missileturret_watchtimeout( self );
        newowner thread missileturret_watchpickup( self );
        thread missile_attacktargets( undefined, newowner );
        functionals_utility::clearminimapid();
        
        if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
        {
            self.minimapid = self [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.minimapicon, newowner.team, undefined, 1, 1 );
        }
        
        utility::callsharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", self );
        
        if ( level.teambased )
        {
            self filteroutplayermarks( newowner.team );
            return;
        }
        
        self filteroutplayermarks( newowner );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x190d6f66, Offset: 0x4443
// Size: 0x32d
function missileturret_watchdeath( turret )
{
    turret endon( #"carried" );
    turret endon( #"turret_deploy_cancelled" );
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_c33ceb91d0ca7a9d" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        turret [[ var_32dbca3143d9c4a5 ]]( turret );
    }
    
    if ( isdefined( turret.targetentityref ) )
    {
        turret function_b8131970d170ca0d( turret.targetentityref );
        turret.targetentityref = undefined;
    }
    
    turret namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( turret );
    level.missileturrets = arrayremove( level.missileturrets, turret );
    
    if ( isdefined( self ) )
    {
        self.placedsentries[ turret.turrettype ] = arrayremove( self.placedsentries[ turret.turrettype ], turret );
        
        if ( level.missilesettings[ turret.turrettype ].var_f6155b6ff58b6811 )
        {
            function_b2dd7de238a43b26( turret, wasdestroyed );
        }
        else
        {
            missileturret_setinactive( turret );
        }
        
        /#
            if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
            {
                self [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x39>", self );
            }
        #/
        
        turret.streakinfo.expiredbydeath = istrue( wasdestroyed );
        killstreak_utility::recordkillstreakendstats( turret.streakinfo );
    }
    
    turret missileturret_setturretmodel( "destroyed" );
    level thread function_a3b1df4341f35224( turret.var_49796e09a967fd8e );
    turret setturretowner( undefined );
    
    if ( !skipshutdown )
    {
        turret setscriptablepartstate( "shutdown", "on" );
        turret setscriptablepartstate( "turret_carry_state", "off" );
        hostmigration::waitlongdurationwithpause( 2 );
        turret setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        turret setscriptablepartstate( "explode", "violent" );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:turret.streakinfo } );
    
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
    
    if ( isdefined( turret.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( turret.minimapid );
        }
        
        turret.minimapid = undefined;
    }
    
    wait 3;
    turret delete();
}

// Namespace missile_turret
// Params 1
// Checksum 0x6d7c42d5, Offset: 0x4778
// Size: 0xe2
function missileturret_watchtimeout( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( turret.var_87ec6969d861f7b6 > 0 && turret.timeout > 0 )
    {
        turret.timeout -= 0.5;
        hostmigration::waitlongdurationwithpause( 0.5 );
    }
    
    hostmigration::waitlongdurationwithpause( turret.var_d41782dc2248f73d );
    killstreak_utility::playkillstreakteamleaderdialog( turret.streakinfo, turret.streakinfo.streakname + "_teamleader_timeout", #"leave" );
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace missile_turret
// Params 1
// Checksum 0x9343e5cd, Offset: 0x4862
// Size: 0x4b
function missileturret_watchdisown( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
    utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    turret notify( #"kill_turret", 0, 0 );
}

// Namespace missile_turret
// Params 1
// Checksum 0xeaa6e903, Offset: 0x48b5
// Size: 0x95
function missileturret_watchgameend( turret )
{
    turret endon( #"kill_turret" );
    turret endon( #"carried" );
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

// Namespace missile_turret
// Params 1
// Checksum 0x36eed5be, Offset: 0x4952
// Size: 0x7d
function missileturret_setturretmodel( type )
{
    turretmodel = undefined;
    
    if ( type == "placed" )
    {
        turretmodel = level.missilesettings[ self.turrettype ].modelbaseground;
    }
    else
    {
        turretmodel = level.missilesettings[ self.turrettype ].modeldestroyedground;
    }
    
    assert( isdefined( turretmodel ), "<dev string:x5b>" );
    self setmodel( turretmodel );
}

// Namespace missile_turret
// Params 2
// Checksum 0x7a3965a8, Offset: 0x49d7
// Size: 0xaa
function missile_attacktargets( var_926c66af24bdeb68, player )
{
    /#
        self.owner endon( #"manual_shoot_at_target" );
    #/
    
    self endon( #"kill_turret" );
    self endon( #"carried" );
    self endon( #"missile_turret_hacked" );
    level endon( #"game_ended" );
    self.momentum = 0;
    
    while ( true )
    {
        self waittill( #"turretstatechange" );
        
        if ( self isfiringturret() )
        {
            self laseron();
            thread missile_burstfirestart( var_926c66af24bdeb68, player );
            continue;
        }
        
        self laseroff();
        missile_spindown();
        thread missile_burstfirestop();
    }
}

/#

    // Namespace missile_turret
    // Params 1
    // Checksum 0x2b701d5a, Offset: 0x4a89
    // Size: 0x268, Type: dev
    function function_9d59ff59c7fd4c40( var_926c66af24bdeb68 )
    {
        self endon( #"kill_turret" );
        self endon( #"carried" );
        level endon( #"game_ended" );
        self.turrettarget = spawn( "<dev string:xa0>", self gettagorigin( "<dev string:xad>" ) + anglestoforward( self gettagangles( "<dev string:xad>" ) * 300 ) );
        self.turrettarget.targeton = 0;
        self.turrettarget dontinterpolate();
        self.turrettarget thread function_e9ed766b61f7c35b( self );
        self.turrettarget thread function_3642fec2b9d4a717( self );
        var_da2d7a72e68a9626 = undefined;
        
        if ( isdefined( var_926c66af24bdeb68 ) )
        {
            var_da2d7a72e68a9626 = var_926c66af24bdeb68;
        }
        else
        {
            var_da2d7a72e68a9626 = level.missilesettings[ self.turrettype ];
        }
        
        sentrymode = var_da2d7a72e68a9626.sentrymodeon;
        manualmode = "<dev string:xb7>";
        turretmode = sentrymode;
        notifyon = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_c9bd691ce96079ac", 0 ) == 1 )
            {
                if ( !notifyon )
                {
                    self.owner notifyonplayercommand( "<dev string:xc5>", "<dev string:xdc>" );
                    notifyon = 1;
                }
                
                self.owner waittill( #"manual_shoot_at_target" );
                
                if ( turretmode != manualmode )
                {
                    self setmode( manualmode );
                    turretmode = manualmode;
                    starttrace = self.owner getvieworigin();
                    endtrace = starttrace + anglestoforward( self.owner getplayerangles() ) * 50000;
                    trace = trace::ray_trace( starttrace, endtrace, self.owner );
                    endpos = undefined;
                    
                    if ( isdefined( trace[ "<dev string:xe9>" ] ) && trace[ "<dev string:xe9>" ] != "<dev string:xf1>" )
                    {
                        endpos = trace[ "<dev string:x30>" ];
                    }
                    
                    if ( isdefined( endpos ) )
                    {
                        thread function_b031241b0af941cb( endpos );
                    }
                }
                else
                {
                    function_8731a42628253fc1();
                    turretmode = sentrymode;
                    self setmode( turretmode );
                    thread missile_attacktargets();
                }
                
                continue;
            }
            
            notifyon = 0;
            
            if ( turretmode != sentrymode )
            {
                self.owner notifyonplayercommandremove( "<dev string:xc5>", "<dev string:xdc>" );
                function_8731a42628253fc1();
                turretmode = sentrymode;
                self setmode( turretmode );
                thread missile_attacktargets();
            }
            
            waitframe();
        }
    }

    // Namespace missile_turret
    // Params 1
    // Checksum 0x19d2924, Offset: 0x4cf9
    // Size: 0x1bc, Type: dev
    function function_b031241b0af941cb( firepos )
    {
        self.owner endon( #"stop_manual_target" );
        self.owner endon( #"manual_shoot_at_target" );
        self endon( #"kill_turret" );
        self endon( #"carried" );
        level endon( #"game_ended" );
        self laseroff();
        thread missile_burstfirestop();
        self.turrettarget.origin = firepos;
        self settargetentity( self.turrettarget );
        self.turrettarget.targeton = 1;
        starttag = "<dev string:xfe>";
        
        if ( self.streakinfo.streakname == "<dev string:x10f>" )
        {
            starttag = "<dev string:x11a>";
        }
        
        endtag = "<dev string:xad>";
        wait 1;
        self laseron();
        
        while ( true )
        {
            var_22d188c5c239532c = self gettagorigin( starttag );
            var_5f44ac430764d62e = self gettagangles( starttag );
            thread debug_utility::drawsphere( var_22d188c5c239532c, 2, 1, ( 0, 1, 1 ) );
            thread debug_utility::drawline( var_22d188c5c239532c, var_22d188c5c239532c + anglestoforward( var_5f44ac430764d62e ) * 1800, 1, ( 0, 1, 1 ) );
            flashtagorigin = self gettagorigin( endtag );
            var_9d1c6b53d42e88 = self gettagangles( endtag );
            thread debug_utility::drawsphere( flashtagorigin, 2, 1, ( 1, 1, 0 ) );
            thread debug_utility::drawline( flashtagorigin, flashtagorigin + anglestoforward( var_9d1c6b53d42e88 ) * 1800, 1, ( 1, 1, 0 ) );
            wait 1;
        }
    }

    // Namespace missile_turret
    // Params 0
    // Checksum 0xa66012e3, Offset: 0x4ebd
    // Size: 0x41, Type: dev
    function function_8731a42628253fc1()
    {
        self cleartargetentity();
        self laseroff();
        thread missile_burstfirestop();
        self.turrettarget.targeton = 0;
        self.owner notify( #"stop_manual_target" );
    }

    // Namespace missile_turret
    // Params 1
    // Checksum 0x4a71c642, Offset: 0x4f06
    // Size: 0x76, Type: dev
    function function_e9ed766b61f7c35b( turret )
    {
        turret endon( #"kill_turret" );
        turret endon( #"carried" );
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( self.targeton )
            {
                sphere( self.origin, 20, ( 1, 1, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace missile_turret
    // Params 1
    // Checksum 0xdff112e5, Offset: 0x4f84
    // Size: 0x55, Type: dev
    function function_3642fec2b9d4a717( turret )
    {
        turret endon( #"kill_turret" );
        turret endon( #"carried" );
        self endon( #"death" );
        level endon( #"game_ended" );
        turret waittill( #"death" );
        self delete();
    }

#/

// Namespace missile_turret
// Params 0
// Checksum 0x8e50b5e7, Offset: 0x4fe1
// Size: 0x1e
function missile_targetlocksound()
{
    self endon( #"death" );
    self setscriptablepartstate( "turret_target_found", "target_found" );
}

// Namespace missile_turret
// Params 1
// Checksum 0xc547d733, Offset: 0x5007
// Size: 0x4c
function missile_spinup( var_926c66af24bdeb68 )
{
    thread missile_targetlocksound();
    
    while ( self.momentum < var_926c66af24bdeb68.spinuptime )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
}

// Namespace missile_turret
// Params 0
// Checksum 0x9ae11b59, Offset: 0x505b
// Size: 0x1c
function missile_spindown()
{
    self.momentum = 0;
    self setscriptablepartstate( "turret_target_found", "off" );
}

// Namespace missile_turret
// Params 2
// Checksum 0x282f4978, Offset: 0x507f
// Size: 0xa0
function missile_burstfirestart( var_926c66af24bdeb68, player )
{
    self endon( #"death" );
    self endon( #"stop_shooting" );
    self endon( #"target_cleared" );
    level endon( #"game_ended" );
    var_da2d7a72e68a9626 = undefined;
    
    if ( isdefined( var_926c66af24bdeb68 ) )
    {
        var_da2d7a72e68a9626 = var_926c66af24bdeb68;
    }
    else
    {
        var_da2d7a72e68a9626 = level.missilesettings[ self.turrettype ];
    }
    
    missile_spinup( var_da2d7a72e68a9626 );
    firetime = weaponfiretime( var_da2d7a72e68a9626.weaponinfo );
    missile_burstfire( var_da2d7a72e68a9626, player );
}

// Namespace missile_turret
// Params 2
// Checksum 0xda9de92f, Offset: 0x5127
// Size: 0x279
function missile_burstfire( var_da2d7a72e68a9626, player )
{
    while ( true )
    {
        if ( utility::issharedfuncdefined( #"flare_system", #"hash_bb66c31dec02b91a" ) )
        {
            while ( true )
            {
                flaresystemresult = self [[ utility::getsharedfunc( #"flare_system", #"hash_bb66c31dec02b91a" ) ]]( self.targetentityref );
                
                if ( flaresystemresult == #"lockon_success" )
                {
                    break;
                }
                else
                {
                    self cleartargetentity();
                    self notify( #"target_cleared" );
                }
                
                waitframe();
            }
        }
        
        while ( true )
        {
            if ( self.var_87ec6969d861f7b6 <= 0 || !isdefined( self.targetentityref ) )
            {
                waitframe();
                continue;
            }
            
            if ( self.var_9b458beec84087f7 - self.targetentityref.health >= self.targetentityref.maxhealth )
            {
                waitframe();
                continue;
            }
            
            break;
        }
        
        thread function_9ad795d85d9da00c();
        
        if ( self.var_eea7488374f7ee93 && isdefined( self.targetentityref.streakinfo ) )
        {
            self.targetentityref.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, getxhash( "target_" + self.targetentityref.streakinfo.streakname ), 1 );
        }
        
        if ( self.var_eea7488374f7ee93 || self.var_8cb1ce303473fc3d <= 0 )
        {
            wait var_da2d7a72e68a9626.initiallockontime;
        }
        else
        {
            wait var_da2d7a72e68a9626.consecutivelockontime;
        }
        
        if ( utility::issharedfuncdefined( #"flare_system", #"hash_bb66c31dec02b91a" ) )
        {
            flaresystemresult = self [[ utility::getsharedfunc( #"flare_system", #"hash_bb66c31dec02b91a" ) ]]( self.targetentityref );
            
            if ( flaresystemresult != #"lockon_success" )
            {
                self cleartargetentity();
                self notify( #"target_cleared" );
            }
        }
        
        if ( self.var_8cb1ce303473fc3d <= 0 )
        {
            self.var_8cb1ce303473fc3d = self.var_8d7c59163952d631;
        }
        
        self.canshootmissile = 1;
        var_9a481c545b16bb6 = missileturret_handlemissilefire( self, player );
        
        if ( var_9a481c545b16bb6 )
        {
            self.var_eea7488374f7ee93 = 0;
            self.var_87ec6969d861f7b6--;
            self.var_8cb1ce303473fc3d--;
        }
        
        wait var_da2d7a72e68a9626.cooldowntime;
    }
}

// Namespace missile_turret
// Params 0
// Checksum 0xbb5b11d, Offset: 0x53a8
// Size: 0x87
function function_9ad795d85d9da00c()
{
    self notify( #"hash_f34fede1754a26fe" );
    self endon( #"hash_f34fede1754a26fe" );
    self endon( #"death" );
    self endon( #"target_cleared" );
    level endon( #"game_ended" );
    var_9b99fa4a8fb18a7d = level.sharedfuncs[ #"flare_system" ][ #"hash_c402efcb2b8bce33" ];
    
    if ( !isdefined( var_9b99fa4a8fb18a7d ) )
    {
        return;
    }
    
    while ( true )
    {
        self [[ var_9b99fa4a8fb18a7d ]]( self.targetentityref );
        waitframe();
    }
}

// Namespace missile_turret
// Params 0
// Checksum 0x51d105d5, Offset: 0x5437
// Size: 0x18
function missile_burstfirestop()
{
    self.canshootmissile = 0;
    self notify( #"stop_shooting" );
}

// Namespace missile_turret
// Params 0
// Checksum 0xffec5ce2, Offset: 0x5457
// Size: 0x72
function missile_beepsounds()
{
    self endon( #"death" );
    self endon( #"carried" );
    self endon( #"kill_turret" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 3;
        
        if ( self isfiringturret() )
        {
            waitframe();
            continue;
        }
        
        self setscriptablepartstate( "turret_target_search", "target_search" );
        wait 0.05;
        self setscriptablepartstate( "turret_target_search", "off" );
    }
}

// Namespace missile_turret
// Params 2
// Checksum 0x98fd5247, Offset: 0x54d1
// Size: 0x61
function missileturret_gettargetmarker( streakinfo, ignorecancel )
{
    assert( isplayer( self ), "<dev string:x12d>" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"gettargetmarker" ) )
    {
        return self [[ utility::getsharedfunc( #"killstreak", #"gettargetmarker" ) ]]( streakinfo, ignorecancel );
    }
}

// Namespace missile_turret
// Params 11
// Checksum 0x58dd4b8b, Offset: 0x553b
// Size: 0xab
function missileturret_createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    if ( utility::issharedfuncdefined( #"game", #"createhintobject" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"createhintobject" ) ]]( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0xedb6cd03, Offset: 0x55ee
// Size: 0x7f
function missileturret_monitordamage( turret )
{
    assert( isplayer( self ), "<dev string:x12d>" );
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        turret notify( #"hash_132222844eaf7009" );
        turret thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( turret.maxhealth, "hitequip", &missileturret_handledeathdamage, &missileturret_modifydamage, 1 );
    }
}

// Namespace missile_turret
// Params 1
// Checksum 0x3e30a5b0, Offset: 0x5675
// Size: 0x17b
function missileturret_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = level.missilesettings[ self.turrettype ];
    
    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
    {
        additionalparams = { #inflictor:data.inflictor };
        notifyattacker = self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash, 0, additionalparams );
    }
    
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" || type == "MOD_CRUSH" )
    {
        explosivedamage = 1;
    }
    
    self notify( #"enemy_destroyed_equipment", attacker );
    self notify( #"kill_turret", explosivedamage, 1 );
}

// Namespace missile_turret
// Params 1
// Checksum 0xd9ae85b0, Offset: 0x57f8
// Size: 0x1ad
function missileturret_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "missile_turret" ];
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 3, 400 );
    }
    
    var_9f6142336d9d2052 = self.damagetaken + modifieddamage;
    
    if ( var_9f6142336d9d2052 >= self.lowhealth && !self.damagedstate )
    {
        self.damagedstate = 1;
        self setscriptablepartstate( "turret_damage", "on", 0 );
    }
    
    return modifieddamage;
}

// Namespace missile_turret
// Params 0
// Checksum 0xd0ef4210, Offset: 0x59ae
// Size: 0x729
function function_916413fb74063e28()
{
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    assert( isdefined( bundle ), "<dev string:x161>" );
    
    if ( !isdefined( bundle ) )
    {
        bundle = spawnstruct();
    }
    
    level.missilesettings[ "missile_turret" ] = spawnstruct();
    level.missilesettings[ "missile_turret" ].health = 999999;
    level.missilesettings[ "missile_turret" ].maxhealth = bundle.maxhealth ?? 650;
    level.missilesettings[ "missile_turret" ].lowhealth = bundle.missileturretlowhealth ?? level.missilesettings[ "missile_turret" ].maxhealth * 0.75;
    level.missilesettings[ "missile_turret" ].burstmin = 10;
    level.missilesettings[ "missile_turret" ].burstmax = 20;
    level.missilesettings[ "missile_turret" ].pausemin = 1;
    level.missilesettings[ "missile_turret" ].pausemax = 1.25;
    level.missilesettings[ "missile_turret" ].lockstrength = 6;
    level.missilesettings[ "missile_turret" ].sentrymodeon = "sentryManual";
    level.missilesettings[ "missile_turret" ].sentrymodeoff = "sentry_offline";
    level.missilesettings[ "missile_turret" ].timeout = bundle.missileturrettimeout ?? 75;
    level.missilesettings[ "missile_turret" ].cooldowntime = bundle.var_5d4f9f55e9450240 ?? 1.25;
    level.missilesettings[ "missile_turret" ].spinuptime = bundle.var_cd96a155c41485dc ?? 0.65;
    level.missilesettings[ "missile_turret" ].fxtime = 0.3;
    level.missilesettings[ "missile_turret" ].streakname = "missile_turret";
    level.missilesettings[ "missile_turret" ].weaponinfo = bundle.var_2dd1862acd385522;
    level.missilesettings[ "missile_turret" ].playerweaponinfo = bundle.var_2dd1862acd385522;
    level.missilesettings[ "missile_turret" ].scriptable = "ks_sentry_turret_mp";
    level.missilesettings[ "missile_turret" ].modelbaseground = bundle.var_8e255e58b2f354c8;
    level.missilesettings[ "missile_turret" ].modeldestroyedground = bundle.var_315728f292adda1c;
    level.missilesettings[ "missile_turret" ].placementhintstring = &"killstreaks_hints/sentry_gun_place";
    level.missilesettings[ "missile_turret" ].ownerusehintstring = &"killstreaks_hints/missile_turret_use";
    level.missilesettings[ "missile_turret" ].otherusehintstring = &"killstreaks_hints/sentry_other_use";
    level.missilesettings[ "missile_turret" ].dismantlehintstring = &"killstreaks_hints/sentry_dismantle";
    level.missilesettings[ "missile_turret" ].headicon = 1;
    
    if ( !isdefined( bundle.var_3cdbe3475f352143 ) )
    {
        level.missilesettings[ "missile_turret" ].teamsplash = "used_missile_turret";
    }
    else
    {
        level.missilesettings[ "missile_turret" ].teamsplash = bundle.var_3cdbe3475f352143;
    }
    
    level.missilesettings[ "missile_turret" ].destroyedsplash = "callout_destroyed_sentry_gun";
    level.missilesettings[ "missile_turret" ].shouldsplash = 1;
    level.missilesettings[ "missile_turret" ].votimeout = "missile_turret_teamleader_destroyed";
    level.missilesettings[ "missile_turret" ].vodestroyed = "missile_turret_teamleader_destroyed";
    level.missilesettings[ "missile_turret" ].scorepopup = "destroyed_sentry";
    level.missilesettings[ "missile_turret" ].lightfxtag = "tag_fx";
    level.missilesettings[ "missile_turret" ].iskillstreak = 1;
    level.missilesettings[ "missile_turret" ].headiconoffset = ( 0, 0, 75 );
    level.missilesettings[ "missile_turret" ].nummissiles = bundle.var_b51d4ae420498089 ?? 3;
    level.missilesettings[ "missile_turret" ].attackrange = bundle.var_98d0c7fac91b0659 ?? 100000;
    level.missilesettings[ "missile_turret" ].initiallockontime = bundle.var_e4b6cfe85554a4a7 ?? 2.5;
    level.missilesettings[ "missile_turret" ].consecutivelockontime = bundle.var_32d4e431d876eeb5 ?? 0;
    level.missilesettings[ "missile_turret" ].var_d41782dc2248f73d = bundle.var_ee35c7d670f2327f ?? 10;
    level.missilesettings[ "missile_turret" ].var_c27094ce883af2ba = bundle.var_bbe82b06420c5418 ?? 0;
    level.missilesettings[ "missile_turret" ].defaultdroppitch = bundle.var_c286c9fc09dc8a22 ?? 0;
    level.missilesettings[ "missile_turret" ].var_472f2ff38d4db8ad = bundle.var_faf93280f336ae63 ?? level.missilesettings[ "missile_turret" ].defaultdroppitch;
    level.missilesettings[ "missile_turret" ].timeoutpitch = bundle.var_d60b210ec6c7e1c7 ?? level.missilesettings[ "missile_turret" ].defaultdroppitch;
    level.missilesettings[ "missile_turret" ].var_f6159be88c224226 = istrue( bundle.var_d7b82e4118e00054 );
    level.missilesettings[ "missile_turret" ].var_f6155b6ff58b6811 = istrue( bundle.var_ce65b76d0185df8f );
    level.missileturrets = [];
}

// Namespace missile_turret
// Params 0
// Checksum 0x5ca03c18, Offset: 0x60df
// Size: 0x16b
function function_8c4052ee85fae2cf()
{
    bundle = level.streakglobals.streakbundles[ "missile_turret" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    foreach ( vehicleentry in bundle.vehicleentries )
    {
        if ( vehicleentry.isvehicle && isdefined( vehicleentry.name ) && isdefined( vehicleentry.nummissiles ) && isdefined( bundle.var_a3b254e7f7650b04 ) )
        {
            weapondata = vehicle_damage::get_weapon_hit_damage_data( bundle.var_a3b254e7f7650b04 );
            vehicledata = vehicle_damage::get_vehicle_hit_damage_data( vehicleentry.name );
            var_fc11c2595e58467b = undefined;
            
            if ( isdefined( weapondata ) && weapondata.hitsperattack > 0 )
            {
                var_fc11c2595e58467b = weapondata.hitsperattack * vehicleentry.nummissiles;
                vehicle_damage::set_vehicle_hit_damage_data_for_weapon( vehicleentry.name, var_fc11c2595e58467b, bundle.var_a3b254e7f7650b04 );
            }
        }
    }
}

// Namespace missile_turret
// Params 0
// Checksum 0x269d2159, Offset: 0x6252
// Size: 0x74, Type: bool
function missileturret_canpickup()
{
    if ( inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        return false;
    }
    
    if ( killstreak_utility::iskillstreakdeployweapon( self getcurrentweapon() ) )
    {
        return false;
    }
    
    if ( self isswimming() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_picked_up_water" );
        }
        
        return false;
    }
    
    if ( !self isonground() )
    {
        return false;
    }
    
    return true;
}

// Namespace missile_turret
// Params 1
// Checksum 0xe455be67, Offset: 0x62cf
// Size: 0xdd
function function_2ef42d72eb1e2d7a( cancelstring )
{
    ent = spawnstruct();
    
    if ( isdefined( cancelstring ) )
    {
        childthread missileturret_waittill_return( cancelstring, ent );
    }
    
    childthread missileturret_waittill_return( "death", ent );
    ent waittill( #"returned", vfxoffset, weaponname, location, angle, string );
    ent notify( #"die" );
    returninfo = spawnstruct();
    returninfo.weapon = weaponname;
    returninfo.location = location;
    returninfo.angles = angle;
    returninfo.string = string;
    returninfo.fxoffset = vfxoffset;
    return returninfo;
}

// Namespace missile_turret
// Params 2
// Checksum 0x75156170, Offset: 0x63b5
// Size: 0x7d
function missileturret_waittill_return( confirmstring, ent )
{
    if ( confirmstring != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( confirmstring, vfxoffset, weapon, location, angle );
    ent notify( #"returned", vfxoffset, weapon, location, angle, confirmstring );
}

/#

    // Namespace missile_turret
    // Params 3
    // Checksum 0x396884ca, Offset: 0x643a
    // Size: 0x9a, Type: dev
    function function_dcae7e2a011d331f( raycaststart, raycastend, radius )
    {
        duration = 100;
        red = ( 255, 0, 0 );
        green = ( 0, 255, 0 );
        blue = ( 0, 0, 255 );
        sphere( raycaststart, radius, red, 0, duration );
        sphere( raycastend, radius, blue, 0, duration );
        line( raycaststart, raycastend, green, 1, 0, duration );
    }

    // Namespace missile_turret
    // Params 4
    // Checksum 0x4a7889dc, Offset: 0x64dc
    // Size: 0xba, Type: dev
    function function_b6b1ca4bd64e5a06( raycaststart, raycastend, position, radius )
    {
        duration = 100;
        red = ( 255, 0, 0 );
        green = ( 0, 255, 0 );
        blue = ( 0, 0, 255 );
        yellow = ( 255, 255, 0 );
        sphere( raycastend, radius, blue, 0, duration );
        sphere( position, radius, yellow, 0, duration );
        line( raycaststart, raycastend, green, 1, 0, duration );
    }

#/
