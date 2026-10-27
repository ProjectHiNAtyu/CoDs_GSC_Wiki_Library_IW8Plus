// scripts\mp\common\killstreaks\emp.gsc  (hash_787b275d627334e2.gscc) (size: 19054 Bytes / 0x4a6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x801639d6 (2148940246)
// size ...... 19054 (0x4a6e)
// includes .. 15  (offset: 0x45b6)
// strings ... 70  (offset: 0x462e)
// dev strs .. 1   (offset: 0x4a46)
// exports ... 39  (offset: 0x30d6)
// cseg ...... 0x515 + 0x2bc1 (0x30d6)
// imports ... 121 (offset: 0x36ee)
// animtree1 . 0   (offset: 0x4a52)
// animtree2 . 1   (offset: 0x4a52)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;

#namespace emp;

// Namespace emp
// Params 0, eflags: 0x1
// Checksum 0xa1570bcf, Offset: 0x533
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "emp" ), &init );
}

// Namespace emp
// Params 0, eflags: 0x4
// Checksum 0xdab313c2, Offset: 0x552
// Size: 0x16b
function private init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "emp", &tryuseemp );
    }
    
    if ( utility::issharedfuncdefined( #"emp", #"init" ) )
    {
        [[ utility::getsharedfunc( #"emp", #"init" ) ]]();
    }
    
    utility::registersharedfunc( #"emp", #"setemp_applied_callback", &setemp_applied_callback );
    utility::registersharedfunc( #"emp", #"setemp_started_callback", &setemp_started_callback );
    utility::registersharedfunc( #"emp", #"setemp_cleared_callback", &setemp_cleared_callback );
    utility::registersharedfunc( #"emp", #"setemp_cleared_callback", &watch_checkforlauncherweapons );
    utility::registersharedfunc( #"emp", #"hash_6781b1898af33d91", &clearempplayer );
    init_emp_vo();
    level.teamactiveemps = [];
    level.var_23141adfd483bfa9 = [];
    level._effect[ "predator_pod_break" ] = loadfxasset( "vfx_iw8_mp_strk_cruise_predator_explo" );
    utility::registersharedfunc( #"killstreak_emp", #"watch_checkforlauncherweapons", &watch_checkforlauncherweapons );
    level.killstreak_emp_initialized = 1;
}

// Namespace emp
// Params 0
// Checksum 0x160d0539, Offset: 0x6c5
// Size: 0x1b
function init_emp_vo()
{
    game[ "dialog" ][ "emp_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace emp
// Params 1
// Checksum 0xcbd8b2a0, Offset: 0x6e8
// Size: 0x27
function tryuseemp( streakinfo = killstreak_utility::createstreakinfo( "emp", self ) )
{
    return tryuseempfromstruct( streakinfo );
}

// Namespace emp
// Params 1
// Checksum 0x477280ca, Offset: 0x718
// Size: 0x27e, Type: bool
function tryuseempfromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.teamactiveemps[ self.team ] ) )
    {
        if ( level.teamactiveemps[ self.team ] > 0 )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/FRIENDLY_EMP_ACTIVE" );
            }
            
            return false;
        }
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "emp" ];
    deploymentweapon = bundle.deployweaponname ?? "ks_gesture_phone_mp";
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deploymentweapon ) );
    
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
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
            var_65934120c2efeb81 = 2.5;
        }
        
        thread killstreak_utility::playkillstreakoperatordialog( streakinfo.streakname, streakinfo.streakname + "_use", #"emp_used" );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + streakinfo.streakname, self );
        
        if ( isdefined( level.teamactiveemps[ self.team ] ) )
        {
            level.teamactiveemps[ self.team ]++;
        }
        else if ( !isdefined( level.teamactiveemps[ self.team ] ) )
        {
            level.teamactiveemps[ self.team ] = 1;
        }
    }
    
    result = function_ad647430194a20f5( streakinfo );
    audio_utility::snd_transient_load( "kls_jup_emp" );
    return true;
}

// Namespace emp
// Params 1
// Checksum 0x807d9082, Offset: 0x99f
// Size: 0x2f8
function function_ad647430194a20f5( streakinfo )
{
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = 6000;
    horizontaloffset = 8000;
    targetoffset = 5000;
    spawncenterpos = level.mapcenter;
    bundle = level.streakglobals.streakbundles[ "emp" ];
    
    if ( bundle.var_5d953ed813c06a63 )
    {
        spawncenterpos = self.origin;
        horizontaloffset = 400;
    }
    
    forwardvector = anglestoforward( ( 0, randomint( 360 ), 0 ) );
    additionaltargetoffset = ( 0, horizontaloffset, heightoffset );
    
    switch ( randomint( 8 ) )
    {
        case 1:
            additionaltargetoffset = ( horizontaloffset, 0, heightoffset );
            break;
        case 2:
            additionaltargetoffset = ( 0, horizontaloffset, heightoffset );
            break;
        case 3:
            additionaltargetoffset = ( horizontaloffset / 2, horizontaloffset / 2, heightoffset );
            break;
        case 4:
            additionaltargetoffset = ( -1 * horizontaloffset, 0, heightoffset );
            break;
        case 5:
            additionaltargetoffset = ( 0, -1 * horizontaloffset, heightoffset );
            break;
        case 6:
            additionaltargetoffset = ( -1 * horizontaloffset / 2, -1 * horizontaloffset / 2, heightoffset );
            break;
        case 7:
            additionaltargetoffset = ( -1 * horizontaloffset / 2, horizontaloffset / 2, heightoffset );
            break;
        case 8:
            additionaltargetoffset = ( horizontaloffset / 2, -1 * horizontaloffset / 2, heightoffset );
            break;
        default:
            additionaltargetoffset = ( 0, horizontaloffset, heightoffset );
            break;
    }
    
    targetpos = spawncenterpos + ( 0, 0, targetoffset );
    missileoffset = targetpos + additionaltargetoffset;
    startpos = missileoffset - forwardvector * 3000;
    missilepod = spawn( "script_model", startpos );
    missilepod setmodel( "wmd_vm_missile_cruise_mp" );
    missilepod.owner = self;
    missilepod.origin = startpos;
    missilepod.angles = vectortoangles( targetpos - startpos );
    missilepod.type = "remote";
    missilepod.team = self.team;
    missilepod.entitynumber = missilepod getentitynumber();
    missilepod.streakinfo = streakinfo;
    missilepod.duration = 30;
    missilepod.animstate = "pod_flying";
    self.restoreangles = self.angles;
    level.rockets[ missilepod.entitynumber ] = missilepod;
    level.remotemissileinprogress = 1;
    result = function_21d2d05377fadc79( missilepod, targetpos, streakinfo );
    return result;
}

#using_animtree( "script_model" );

// Namespace emp
// Params 3
// Checksum 0xc8db640, Offset: 0xca0
// Size: 0x1ad, Type: bool
function function_21d2d05377fadc79( pod, breakpos, streakinfo )
{
    var_63706ff132987a31 = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "wingtrails" );
    var_4b6bef68f2ea736e = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "shell_break" );
    var_e72939f607d577be = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "second_missile_thruster" );
    var_e848491bb74fbafc = utility::get_notetrack_time( %mp_cruise_missile_move_intro, "anim_end" );
    stage1delay = var_63706ff132987a31;
    stage2delay = var_4b6bef68f2ea736e - var_63706ff132987a31;
    stage3delay = var_e72939f607d577be - var_4b6bef68f2ea736e;
    stage4delay = var_e848491bb74fbafc - var_e72939f607d577be;
    podmoveanim = "mp_cruise_missile_move_intro";
    pod scriptmodelplayanimdeltamotion( podmoveanim );
    pod setscriptablepartstate( "main_emp_thruster", "on", 0 );
    hostmigration::waitlongdurationwithpause( stage1delay );
    pod setscriptablepartstate( "wing_trails", "on" );
    hostmigration::waitlongdurationwithpause( stage2delay );
    pod.animstate = "pod_break";
    pod setscriptablepartstate( "wing_trails", "off" );
    pod setscriptablepartstate( "main_emp_thruster", "off", 0 );
    playfxontag( utility::getfx( "predator_pod_break" ), pod, "tag_missile" );
    hostmigration::waitlongdurationwithpause( stage3delay );
    pod.animstate = "missile_thrusters";
    pod setscriptablepartstate( "sub_thruster", "on", 0 );
    hostmigration::waitlongdurationwithpause( stage4delay - 0.05 );
    thread missile_fireout( pod, streakinfo, breakpos );
    return true;
}

// Namespace emp
// Params 3
// Checksum 0x517c0a90, Offset: 0xe56
// Size: 0x297
function missile_fireout( pod, streakinfo, targetpos )
{
    pod endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    pod setscriptablepartstate( "sub_thruster", "off", 0 );
    missile = spawn( "script_model", pod gettagorigin( "tag_missile" ) );
    missile.angles = pod.angles;
    missile setmodel( "wmd_vm_missile_cruise_warhead_mp" );
    missile.team = self.team;
    missile.streakinfo = streakinfo;
    missile.owner = self;
    missile.lifetime = 10;
    missile.weapon_name = "cruise_proj_mp";
    streakinfo.shots_fired++;
    missile setscriptablepartstate( "warhead_emp_thruster", "on", 0 );
    missile thread function_34773c4f4c67a20b();
    missile thread function_4a6006efcf48d282();
    missile endon( #"death" );
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
    assert( isdefined( bundle ) );
    var_4000b8029e36dd72 = bundle.var_41ad63e9f06ff6fe ?? "ks_cruise_predator_mp";
    fxent = spawn( "script_model", missile gettagorigin( "tag_fx" ) );
    fxent setmodel( var_4000b8029e36dd72 );
    fxent.angles = missile gettagangles( "tag_fx" );
    fxent.team = missile.team;
    fxent.owner = missile.owner;
    fxent.streakinfo = missile.streakinfo;
    fxent linkto( missile, "tag_fx" );
    fxent setscriptablepartstate( "fake_trail_emp", "on", 0 );
    fxent setotherent( self );
    fxent thread missile_watchgameend( missile, streakinfo );
    fxent thread missile_watchmissileinfo( missile );
    fxent thread missile_watchmissileexplosion( missile );
    missile thread missile_watchownerdisownaction( "disconnect" );
    missile thread missile_watchownerdisownaction( "joined_team" );
    missile thread missile_watchownerdisownaction( "joined_spectators" );
    hostmigration::waitlongdurationwithpause( 0.05 );
    missile thread missile_watchtimer( self );
    missile thread function_835eac11d29696f0( self, targetpos );
    waitframe();
    
    if ( isdefined( pod ) )
    {
        pod delete();
    }
}

// Namespace emp
// Params 0
// Checksum 0x21d900f9, Offset: 0x10f5
// Size: 0x19e
function function_34773c4f4c67a20b()
{
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        objid = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        self.var_c7045413fdea88bc = objid;
        bundle = level.streakglobals.streakbundles[ "emp" ];
        icon = bundle.var_dc0066707d3fadcb ?? "hud_icon_minimap_killstreak_cruise_missile";
        objidpoolmanager::objective_add_objective( objid, "active", self.origin, icon, "icon_medium" );
        objidpoolmanager::objective_set_play_intro( objid, 0 );
        objidpoolmanager::objective_set_play_outro( objid, 0 );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || isbot( player ) || player == self )
            {
                continue;
            }
            
            objidpoolmanager::objective_playermask_addshowplayer( objid, player );
        }
        
        objidpoolmanager::update_objective_onentitywithrotation( objid, self );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        
        if ( level.teambased )
        {
            objidpoolmanager::update_objective_ownerteam( objid, self.team );
            return;
        }
        
        objidpoolmanager::update_objective_ownerclient( objid, self.owner );
    }
}

// Namespace emp
// Params 0
// Checksum 0x7897fcd, Offset: 0x129b
// Size: 0x41
function function_4a6006efcf48d282()
{
    destpoint = self.origin + anglestoforward( self.angles ) * 50000;
    missilemovetime = 16.6667;
    self moveto( destpoint, missilemovetime );
}

// Namespace emp
// Params 2
// Checksum 0xdb6687dd, Offset: 0x12e4
// Size: 0x84
function function_835eac11d29696f0( rider, targetpos )
{
    self endon( #"death" );
    rider endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_5ea4a0cef2c11607 = self gettagorigin( "tag_missile" );
        var_2f34fb95c2c957a8 = distancesquared( targetpos, var_5ea4a0cef2c11607 );
        
        if ( var_2f34fb95c2c957a8 <= 10000 )
        {
            self notify( #"explode" );
            break;
        }
        
        waitframe();
    }
}

// Namespace emp
// Params 2
// Checksum 0x2d1d11a8, Offset: 0x1370
// Size: 0xcc
function missile_watchgameend( missile, streakinfo )
{
    missile endon( #"death" );
    missile endon( #"cruise_missile_explode" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    if ( self.owner && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
    
    missile notify( #"hash_d492b41c9971638f" );
    
    if ( isdefined( missile ) )
    {
        missile delete();
    }
}

// Namespace emp
// Params 1
// Checksum 0x55c9e901, Offset: 0x1444
// Size: 0x49
function missile_watchmissileinfo( missile )
{
    self endon( #"death" );
    
    while ( true )
    {
        self.missilelastpos = missile.origin;
        self.missilelastangle = missile.angles;
        waitframe();
    }
}

// Namespace emp
// Params 1
// Checksum 0x9c1608eb, Offset: 0x1495
// Size: 0x232
function missile_watchmissileexplosion( missile )
{
    missile endon( #"hash_d492b41c9971638f" );
    explodepos = undefined;
    missileangles = undefined;
    streakinfo = missile.streakinfo;
    explodeinfo = undefined;
    
    while ( true )
    {
        explodeinfo = missile missile_waittillexplode( "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked" );
        
        if ( explodeinfo.msg == "collision" )
        {
            surface = physics_getsurfacetypefromflags( explodeinfo.param4 );
            surfacetype = getsubstr( surface[ "name" ], 9 );
            collisiondebug = getdvarint( @"scr_cruise_collision_debug", 0 );
            
            /#
                if ( collisiondebug )
                {
                    iprintln( "<dev string:x24>" + surfacetype );
                    continue;
                }
            #/
            
            if ( surfacetype == "glass_pane" )
            {
                continue;
            }
        }
        
        break;
    }
    
    if ( isdefined( missile ) )
    {
        missile setscriptablepartstate( "warhead_emp_thruster", "off", 0 );
        missile notify( #"cruise_missile_explode" );
        utility::callsharedfunc( #"game", #"returnobjectiveid", missile.var_c7045413fdea88bc );
    }
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "fake_trail_emp", "off", 0 );
        explodepos = self.missilelastpos;
        missileangles = self.missilelastangle;
        
        if ( isdefined( missile ) )
        {
            missile delete();
        }
        
        if ( !isdefined( explodeinfo ) || explodeinfo.msg != "emp_defused" && explodeinfo.msg != "trophy_blocked" )
        {
            explosionradius = 600;
            var_c0180fae9381b5ba = "MOD_EXPLOSIVE";
            var_d74c2c09b82e0591 = "cruise_proj_mp";
        }
        
        if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
        {
            [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( explodepos );
        }
        
        thread missile_handlevfxstates( explodeinfo, missile.owner, streakinfo );
    }
}

// Namespace emp
// Params 6
// Checksum 0xa6a569aa, Offset: 0x16cf
// Size: 0x1ac
function missile_waittillexplode( var_19eee95063be9ec9, var_19eee65063be9830, var_19eee75063be9a63, var_19eeec5063bea562, var_19eeed5063bea795, var_19eeea5063bea0fc )
{
    ent = spawnstruct();
    
    if ( isdefined( var_19eee95063be9ec9 ) )
    {
        thread waittill_explodestring( var_19eee95063be9ec9, ent );
    }
    
    if ( isdefined( var_19eee65063be9830 ) )
    {
        thread waittill_explodestring( var_19eee65063be9830, ent );
    }
    
    if ( isdefined( var_19eee75063be9a63 ) )
    {
        thread waittill_explodestring( var_19eee75063be9a63, ent );
    }
    
    if ( isdefined( var_19eeec5063bea562 ) )
    {
        thread waittill_explodestring( var_19eeec5063bea562, ent );
    }
    
    if ( isdefined( var_19eeed5063bea795 ) )
    {
        thread waittill_explodestring( var_19eeed5063bea795, ent );
    }
    
    if ( isdefined( var_19eeea5063bea0fc ) )
    {
        thread waittill_explodestring( var_19eeea5063bea0fc, ent );
    }
    
    ent waittill( #"returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( #"die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace emp
// Params 2
// Checksum 0xee3a4927, Offset: 0x1884
// Size: 0x89
function waittill_explodestring( msg, ent )
{
    self endon( #"death" );
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6 );
}

// Namespace emp
// Params 0
// Checksum 0x4b4ad1da, Offset: 0x1915
// Size: 0xc
function function_5bf5f2966445a87d()
{
    utility::exploder( 777 );
}

// Namespace emp
// Params 3
// Checksum 0x31a9b4bf, Offset: 0x1929
// Size: 0x175
function missile_handlevfxstates( explodeinfo, owner, streakinfo )
{
    self endon( #"death" );
    self unlink();
    
    if ( !isdefined( explodeinfo ) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked" )
    {
        self setscriptablepartstate( "emp_air_explosion", "on", 0 );
        hostmigration::waitlongdurationwithpause( 0.2 );
        owner thread function_210edb20b032ca15();
        owner applyemp( self.origin, streakinfo );
        self delete();
    }
    
    worldup = ( 0, 0, 1 );
    surfacenormal = explodeinfo.param6;
    self.angles = vectortoangles( surfacenormal );
    angledirection = vectordot( surfacenormal, worldup );
    
    if ( angledirection >= 0.7 )
    {
        self setscriptablepartstate( "emp_ground_explosion", "on", 0 );
    }
    else
    {
        self setscriptablepartstate( "emp_air_explosion", "on", 0 );
    }
    
    hostmigration::waitlongdurationwithpause( 1 );
    owner thread function_210edb20b032ca15();
    owner applyemp( self.origin, streakinfo );
    self delete();
}

// Namespace emp
// Params 0
// Checksum 0x3ba1abc4, Offset: 0x1aa6
// Size: 0x81
function function_210edb20b032ca15()
{
    teamtocheck = self.pers[ "team" ];
    characterref = dialog_utility::function_8f16d04b74c7bcd1( teamtocheck );
    character = dialog_utility::function_b857dac241739eeb( "Character", characterref );
    
    if ( !isdefined( character ) )
    {
        character = "mili";
    }
    
    dialogalias = "dx_mp_core_anno_" + character + "_cege";
    thread killstreak_utility::playkillstreakoperatordialog( "emp", dialogalias, #"emp_detonated" );
}

// Namespace emp
// Params 1
// Checksum 0xf0f61aa3, Offset: 0x1b2f
// Size: 0x57
function missile_watchownerdisownaction( action )
{
    self endon( #"death" );
    self endon( #"disowned" );
    level endon( #"game_ended" );
    missileowner = self.owner;
    missileowner waittill( action );
    self notify( #"disowned" );
}

// Namespace emp
// Params 0
// Checksum 0xeaf63691, Offset: 0x1b8e
// Size: 0x3a
function missile_delaymissilecollision()
{
    self endon( #"death" );
    self endon( #"cruise_missile_explode" );
    hostmigration::waitlongdurationwithpause( 0.75 );
    self vehphys_enablecollisioncallback( 1 );
    hostmigration::waitlongdurationwithpause( 1.25 );
}

// Namespace emp
// Params 1
// Checksum 0x379d219b, Offset: 0x1bd0
// Size: 0x39
function missile_watchtimer( rider )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( 500.1 );
    self notify( #"explode", self.origin );
}

// Namespace emp
// Params 3
// Checksum 0xad47bb10, Offset: 0x1c11
// Size: 0x6a
function function_ddd803a218a9926c( scriptable, empcallback, reactivatefunc )
{
    if ( !isdefined( level.var_23141adfd483bfa9 ) )
    {
        return;
    }
    
    scriptable emp_debuff::set_apply_emp_callback( empcallback );
    scriptable.var_5b3dbacfeda0fd01 = empcallback;
    scriptable.reactivatefunc = reactivatefunc;
    level.var_23141adfd483bfa9[ level.var_23141adfd483bfa9.size ] = scriptable;
}

// Namespace emp
// Params 2
// Checksum 0x1ee101fd, Offset: 0x1c83
// Size: 0x2f9
function applyemp( explodelocation, streakinfo )
{
    level endon( #"game_ended" );
    myteam = self.team;
    enemyplayers = team_utility::getenemyplayers( myteam, 1 );
    empduration = 45;
    
    /#
        empduration = getdvarfloat( @"emp_debug_duration", 45 );
    #/
    
    bundle = level.streakglobals.streakbundles[ "emp" ];
    
    if ( bundle.var_5d953ed813c06a63 )
    {
        thread function_2ec56286e722668b( explodelocation, empduration );
    }
    
    if ( isdefined( enemyplayers ) )
    {
        if ( bundle.var_5d953ed813c06a63 )
        {
            emprange = bundle.var_e54fea8c82ebdfc2 ?? 3000;
            var_5109cd376f2df1c1 = emprange * emprange;
            closeenemies = [];
            
            foreach ( enemy in enemyplayers )
            {
                if ( !isdefined( enemy ) )
                {
                    continue;
                }
                
                if ( distance2dsquared( explodelocation, enemy.origin ) < var_5109cd376f2df1c1 )
                {
                    closeenemies[ closeenemies.size ] = enemy;
                }
            }
            
            enemyplayers = closeenemies;
        }
        
        foreach ( enemy in enemyplayers )
        {
            enemy thread applyempplayer( enemy.team, self, explodelocation );
            
            if ( !bundle.var_5d953ed813c06a63 )
            {
                thread function_eff8714ec7a49a5e( enemy.team, self, explodelocation, empduration );
            }
        }
        
        wait empduration;
        
        foreach ( enemy in enemyplayers )
        {
            enemy thread clearempplayer();
            
            if ( !bundle.var_5d953ed813c06a63 )
            {
                thread function_12c0178c46c3bb2b( enemy.team, self, explodelocation, empduration );
            }
        }
    }
    
    killstreak_utility::recordkillstreakendstats( streakinfo );
    level.teamactiveemps[ self.team ]--;
    
    if ( level.teamactiveemps[ self.team ] <= 0 )
    {
        level.teamactiveemps[ self.team ] = undefined;
    }
}

// Namespace emp
// Params 2
// Checksum 0xf41493c0, Offset: 0x1f84
// Size: 0x8e
function function_2ec56286e722668b( explodelocation, empduration )
{
    bundle = level.streakglobals.streakbundles[ "emp" ];
    assert( bundle.var_5d953ed813c06a63 );
    emprange = bundle.var_e54fea8c82ebdfc2 ?? 3000;
    activeobjects = function_eff8714ec7a49a5e( undefined, self, explodelocation, empduration, emprange );
    wait empduration;
    function_d99e9e54493c897a( activeobjects, self, explodelocation, empduration );
}

// Namespace emp
// Params 5
// Checksum 0xab77fac5, Offset: 0x201a
// Size: 0xa59
function function_eff8714ec7a49a5e( victimteam, attacker, explodelocation, empduration, emprange )
{
    killstreakarray = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    taccamarray = undefined;
    
    if ( isdefined( victimteam ) )
    {
        taccamarray = level.deployable_cameras[ "tacticalCameraList" ][ victimteam ];
    }
    
    recondronearray = level.recondronesupers;
    minearray = weapon::function_3aafcaf7ff6dea9e();
    supportboxarray = level.allsupportboxes;
    vehiclearray = level.vehicle.interact.vehicles;
    trackerarray = level.trackers;
    objweapon = makeweapon( "emp" );
    activeobjects = [];
    activeobjects = arraycombineunique( activeobjects, killstreakarray, equipmentarray, taccamarray, recondronearray, minearray, supportboxarray, vehiclearray, trackerarray );
    
    if ( !isdefined( victimteam ) )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( team != attacker.team )
            {
                activeobjects = arraycombineunique( activeobjects, level.deployable_cameras[ "tacticalCameraList" ][ team ] );
            }
        }
    }
    
    if ( isdefined( level.holdprop ) && level.holdprop.canemp )
    {
        foreach ( stronghold in level.fortressstruct.chosenfortresses )
        {
            if ( isdefined( stronghold.task.holdpoint ) )
            {
                activeobjects[ activeobjects.size ] = stronghold.task.holdpoint.trigger;
            }
        }
    }
    
    if ( level.var_5ee9a89b9f9b984b )
    {
        foreach ( towerstruct in level.uavtowers )
        {
            if ( isdefined( towerstruct ) && isdefined( towerstruct.uav_station ) )
            {
                activeobjects[ activeobjects.size ] = towerstruct.uav_station;
            }
        }
    }
    
    if ( level.var_c7c34c7053a29846 )
    {
        if ( isdefined( level.redeploy_drone_info_struct.var_dc2234786c8913dd ) )
        {
            foreach ( drone in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( !drone.b_occupied )
                {
                    continue;
                }
                
                activeobjects[ activeobjects.size ] = drone;
            }
        }
        
        if ( isdefined( level.redeploy_drone_info_struct.movingdrones ) )
        {
            foreach ( movingdrone in level.redeploy_drone_info_struct.movingdrones )
            {
                activeobjects[ activeobjects.size ] = movingdrone;
            }
        }
    }
    
    foreach ( drone in level.package_airdrop.activedrones )
    {
        if ( drone.var_92c7f6e9874d8adc )
        {
            activeobjects[ activeobjects.size ] = drone;
        }
    }
    
    if ( isdefined( level.deployablekiosks ) && level.deployablekiosks.var_e253c9f921155d75 )
    {
        if ( isdefined( level.deployablekiosks.buystations ) )
        {
            foreach ( buystation in level.deployablekiosks.buystations )
            {
                activeobjects[ activeobjects.size ] = buystation;
            }
        }
    }
    
    if ( isdefined( level.var_c50ef961e291ffb7 ) && isdefined( level.var_c50ef961e291ffb7 vehicle::get_ref() ) && level.var_c50ef961e291ffb7 vehicle::get_ref() != "" && level.var_c50ef961e291ffb7.var_92c7f6e9874d8adc )
    {
        if ( isdefined( level.vehicle ) && isdefined( level.vehicle.instances[ level.var_c50ef961e291ffb7 vehicle::get_ref() ] ) )
        {
            foreach ( spy_drone in level.vehicle.instances[ level.var_c50ef961e291ffb7 vehicle::get_ref() ] )
            {
                if ( isdefined( spy_drone ) )
                {
                    activeobjects[ activeobjects.size ] = spy_drone;
                }
            }
        }
    }
    
    if ( isdefined( level.var_23141adfd483bfa9 ) )
    {
        activeobjects = arraycombineunique( activeobjects, level.var_23141adfd483bfa9 );
    }
    
    if ( isdefined( activeobjects ) )
    {
        if ( isdefined( emprange ) )
        {
            var_5109cd376f2df1c1 = emprange * emprange;
            tempobjects = [];
            
            foreach ( object in activeobjects )
            {
                if ( !isdefined( object ) )
                {
                    continue;
                }
                
                if ( distance2dsquared( explodelocation, object.origin ) < var_5109cd376f2df1c1 )
                {
                    tempobjects[ tempobjects.size ] = object;
                }
            }
            
            activeobjects = tempobjects;
        }
        
        foreach ( object in activeobjects )
        {
            if ( isdefined( object ) )
            {
                if ( isdefined( object.team ) )
                {
                    if ( object.team == attacker.team )
                    {
                        continue;
                    }
                }
                
                if ( isdefined( object.ownerteam ) )
                {
                    if ( object.ownerteam == attacker.team )
                    {
                        continue;
                    }
                }
                
                if ( isdefined( object.towerstruct ) && isdefined( object.towerstruct.uav_station ) )
                {
                    if ( object.towerstruct.uav_station.activeteam == attacker.team )
                    {
                        continue;
                    }
                }
                
                if ( isdefined( object.stronghold ) && isdefined( object.stronghold.capturedteam ) )
                {
                    if ( object.stronghold.capturedteam == attacker.team )
                    {
                        continue;
                    }
                }
                
                if ( isdefined( object.var_5b3dbacfeda0fd01 ) )
                {
                    data = damage_utility::packdamagedata( attacker, object, 1, objweapon, "MOD_EXPLOSIVE", attacker, explodelocation );
                    data.time = empduration;
                    data.reason = "EMP_KS";
                    object thread [[ object.var_5b3dbacfeda0fd01 ]]( data );
                    object notify( #"emp_started" );
                    
                    if ( !isdefined( object.ksempapplycallback ) )
                    {
                        if ( isdefined( object.empcount ) )
                        {
                            object.empcount++;
                        }
                        else
                        {
                            object.empcount = 1;
                        }
                        
                        object.ksempd = 1;
                    }
                }
                
                if ( isdefined( object.ksempapplycallback ) )
                {
                    data = damage_utility::packdamagedata( attacker, object, 1, objweapon, "MOD_EXPLOSIVE", attacker, explodelocation );
                    data.ksemp = 1;
                    object thread [[ object.ksempapplycallback ]]( data );
                    object notify( #"emp_applied" );
                    
                    if ( isdefined( object.empcount ) )
                    {
                        object.empcount++;
                    }
                    else
                    {
                        object.empcount = 1;
                    }
                    
                    object.ksempd = 1;
                }
            }
        }
    }
    
    return activeobjects;
}

// Namespace emp
// Params 4
// Checksum 0xeb3e9250, Offset: 0x2a7c
// Size: 0xf9
function function_12c0178c46c3bb2b( victimteam, attacker, explodelocation, empduration )
{
    killstreakarray = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    
    if ( isdefined( victimteam ) )
    {
        taccamarray = level.deployable_cameras[ "tacticalCameraList" ][ victimteam ];
    }
    
    recondronearray = level.recondronesupers;
    minearray = weapon::function_3aafcaf7ff6dea9e();
    supportboxarray = level.allsupportboxes;
    vehiclearray = level.vehicle.interact.vehicles;
    activeobjects = [];
    activeobjects = arraycombineunique( activeobjects, killstreakarray, equipmentarray, taccamarray, recondronearray, minearray, supportboxarray, vehiclearray );
    function_d99e9e54493c897a( activeobjects, attacker, explodelocation, empduration );
}

// Namespace emp
// Params 4
// Checksum 0xacd86e8d, Offset: 0x2b7d
// Size: 0x125
function function_d99e9e54493c897a( activeobjects, attacker, explodelocation, empduration )
{
    if ( isdefined( activeobjects ) )
    {
        objweapon = makeweapon( "emp" );
        
        foreach ( object in activeobjects )
        {
            if ( object emp_debuff::is_empd() || object.ksempd )
            {
                if ( isdefined( object.ksempclearcallback ) )
                {
                    data = damage_utility::packdamagedata( attacker, object, 1, objweapon, "MOD_EXPLOSIVE", attacker, explodelocation );
                    object thread [[ object.ksempclearcallback ]]( data );
                }
                
                object.empcount = undefined;
                object.ksempd = undefined;
                object notify( #"emp_cleared" );
            }
        }
    }
}

// Namespace emp
// Params 3
// Checksum 0x9f7aabbb, Offset: 0x2caa
// Size: 0x10b
function applyempplayer( victimteam, attacker, explodelocation )
{
    if ( isdefined( self.perks[ "specialty_emp_immunity" ] ) || isdefined( self.perks[ "specialty_empimmune" ] ) )
    {
        return;
    }
    
    objweapon = makeweapon( "emp" );
    empdata = damage_utility::packdamagedata( attacker, self, 1, objweapon, "MOD_EXPLOSIVE", attacker, explodelocation );
    self.var_c7dc16398800176e = empdata;
    
    if ( isdefined( self.empcount ) )
    {
        self.empcount++;
        self.ksempd = 1;
    }
    else
    {
        self.ksempd = 1;
        self.empcount = 1;
    }
    
    self notify( #"emp_started" );
    self notify( #"emp_applied" );
    thread function_ad817d6dd86e5ebf();
    thread watch_checkforlauncherweapons();
    thread monitorplayerdeath( attacker );
    
    if ( isdefined( self.ksempapplycallback ) )
    {
        self thread [[ self.ksempapplycallback ]]( empdata );
    }
}

// Namespace emp
// Params 1
// Checksum 0xc0a18463, Offset: 0x2dbd
// Size: 0x6c
function monitorplayerdeath( owner )
{
    self endon( #"emp_cleared" );
    level endon( #"game_ended" );
    self waittill( #"death", attacker );
    
    if ( level.var_7e83f394e7d303f3 && attacker != owner )
    {
        owner utility::callsharedfunc( #"killstreak", #"hash_42822747267e3656" );
    }
}

// Namespace emp
// Params 0
// Checksum 0xec7096eb, Offset: 0x2e31
// Size: 0x57
function function_ad817d6dd86e5ebf()
{
    self endon( #"hash_4439ed850724c2d1" );
    val::set( "ksEMP", "killstreaks", 0 );
    emp_debuff::play_emp_scramble( 3 );
    self playsoundtoplayer( #"kls_emp_hud_deactivate", self );
    wait 2;
    self setempjammed( 1 );
    utility::hidehudenable();
    emp_debuff::stop_emp_scramble( 3 );
}

// Namespace emp
// Params 1
// Checksum 0xcd4707f1, Offset: 0x2e90
// Size: 0x96
function function_3ce56134e3c212cc( immediate )
{
    self notify( #"hash_4439ed850724c2d1" );
    
    if ( self.vehiclescramble )
    {
        self.vehiclescramble = undefined;
        thread emp_debuff::stop_emp_scramble( 4 );
    }
    
    self setempjammed( 0 );
    
    if ( self.hidehudenabled > 0 )
    {
        utility::hidehuddisable();
    }
    
    val::reset( "ksEMP", "killstreaks" );
    
    if ( !immediate )
    {
        self playsoundtoplayer( #"kls_emp_hud_activate", self );
        emp_debuff::play_emp_scramble( 3 );
        wait 2;
        
        if ( self )
        {
            emp_debuff::stop_emp_scramble( 3 );
        }
    }
}

// Namespace emp
// Params 0
// Checksum 0xcce42b0b, Offset: 0x2f2e
// Size: 0x9d
function watch_checkforlauncherweapons()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f226fff401336173" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        currentweaponname = currentweapon.basename;
        
        if ( currentweaponname == "iw9_la_gromeo_mp" || currentweaponname == "iw9_la_juliet_mp" || currentweaponname == "iw9_la_kgolf_mp" || currentweaponname == "jup_jp22_la_dromeo_mp" )
        {
            weapon_utility::function_46f7fffc626f2e7b( 0 );
        }
        else
        {
            weapon_utility::function_46f7fffc626f2e7b( 1 );
        }
        
        wait 1;
    }
}

// Namespace emp
// Params 1
// Checksum 0x1b54e408, Offset: 0x2fd3
// Size: 0x8d
function clearempplayer( immediate )
{
    if ( !self.ksempd )
    {
        return;
    }
    
    self notify( #"emp_cleared" );
    self notify( #"hash_f226fff401336173" );
    emp_debuff::clear_emp();
    self.ksempd = undefined;
    self.var_c7dc16398800176e = undefined;
    
    if ( isdefined( self ) )
    {
        thread function_3ce56134e3c212cc( immediate );
    }
    
    thread function_b93b3b95d11cddaf();
    self allowfire( 1 );
    weapon_utility::function_46f7fffc626f2e7b( 1 );
    
    if ( isdefined( self.ksempclearcallback ) )
    {
        self [[ self.ksempclearcallback ]]();
    }
}

// Namespace emp
// Params 1
// Checksum 0xfbd842bb, Offset: 0x3068
// Size: 0x17
function setemp_applied_callback( applycallback )
{
    self.ksempapplycallback = applycallback;
}

// Namespace emp
// Params 1
// Checksum 0x641c422c, Offset: 0x3087
// Size: 0x17
function setemp_cleared_callback( clearcallback )
{
    self.ksempclearcallback = clearcallback;
}

// Namespace emp
// Params 1
// Checksum 0x47c5c2ae, Offset: 0x30a6
// Size: 0x17
function setemp_started_callback( startcallback )
{
    self.var_5b3dbacfeda0fd01 = startcallback;
}

// Namespace emp
// Params 0
// Checksum 0xfc199a13, Offset: 0x30c5
// Size: 0x11
function function_b93b3b95d11cddaf()
{
    wait 5;
    audio_utility::snd_transient_unload( "kls_jup_emp" );
}

