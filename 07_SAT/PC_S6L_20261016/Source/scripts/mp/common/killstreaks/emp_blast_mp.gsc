// scripts\mp\common\killstreaks\emp_blast_mp.gsc  (hash_4b489d5cbb28bb0f.gscc) (size: 15198 Bytes / 0x3b5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3428043 (3275915331)
// size ...... 15198 (0x3b5e)
// includes .. 24  (offset: 0x36ae)
// strings ... 65  (offset: 0x376e)
// dev strs .. 1   (offset: 0x3b36)
// exports ... 31  (offset: 0x23e2)
// cseg ...... 0x4e3 + 0x1eff (0x23e2)
// imports ... 118 (offset: 0x28ba)
// animtree1 . 0   (offset: 0x3b42)
// animtree2 . 1   (offset: 0x3b42)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\events;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;

#namespace emp_blast_mp;

// Namespace emp_blast_mp
// Params 0, eflags: 0x1
// Checksum 0x69624548, Offset: 0x501
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "emp_blast" ), &init );
}

// Namespace emp_blast_mp
// Params 0, eflags: 0x4
// Checksum 0xa0176780, Offset: 0x520
// Size: 0xcd
function private init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "emp_blast", &function_93cfbb16b651d0be );
    }
    
    weapon::registerkillstreakweaponmap( "emp_blast", "sat_emp_blast_dmg_weapon_mp" );
    utility::registersharedfunc( #"emp", #"hash_6781b1898af33d91", &function_50f531c87248204c );
    init_emp_blast_vo();
    level._effect[ "predator_pod_break" ] = loadfxasset( "vfx_iw8_mp_strk_cruise_predator_explo" );
    level.var_f9ef1424ef6c657a = [];
    level.var_89fe7f9fa2bc945d = [];
    level.var_36218e71baa7e689 = 1;
    level thread function_1a2be41d09afd64b();
    
    /#
        setdvarifuninitialized( @"hash_db49b1eeb256536a", 0, 0, 1 );
    #/
}

// Namespace emp_blast_mp
// Params 0, eflags: 0xc
// Checksum 0x68dff289, Offset: 0x5f5
// Size: 0x53
function private function_1a2be41d09afd64b()
{
    self notify( #"hash_8703bc91cc2b652e" );
    self endon( #"hash_8703bc91cc2b652e" );
    level endon( #"game_ended" );
    level endon( #"emp_blast_applied" );
    
    while ( true )
    {
        level.var_89fe7f9fa2bc945d = function_5713d46873b29625( level.var_89fe7f9fa2bc945d );
        wait 10;
    }
}

// Namespace emp_blast_mp
// Params 0, eflags: 0x4
// Checksum 0x4dae32ed, Offset: 0x650
// Size: 0x1b
function private init_emp_blast_vo()
{
    game[ "dialog" ][ "emp_blast_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace emp_blast_mp
// Params 1
// Checksum 0xc08088cb, Offset: 0x673
// Size: 0x3a
function function_93cfbb16b651d0be( streakinfo )
{
    if ( !streakinfo )
    {
        streakinfo = killstreak_utility::createstreakinfo( "emp_blast", self );
    }
    
    self.var_ec0bb630fbaa253a[ "sat_emp_blast_dmg_weapon_mp" ] = streakinfo;
    return function_3712f99f4d17169f( streakinfo );
}

// Namespace emp_blast_mp
// Params 1
// Checksum 0xd0c9ad54, Offset: 0x6b6
// Size: 0x216
function function_3712f99f4d17169f( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    bundle = streakinfo.bundle;
    deployweaponname = bundle.deployweaponname ?? "ks_gesture_walkie_sat_mp";
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deployweaponname ) );
    
    if ( !deployresult )
    {
        return 0;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        }
        
        thread killstreak_utility::playkillstreakoperatordialog( streakinfo.streakname, streakinfo.streakname + "_use", #"emp_blast_used" );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + streakinfo.streakname, self );
    }
    
    if ( !isdefined( level.var_f9ef1424ef6c657a[ self.team ] ) )
    {
        level.var_f9ef1424ef6c657a[ self.team ] = 0;
    }
    
    level.var_f9ef1424ef6c657a[ self.team ]++;
    
    /#
        if ( getdvarint( @"hash_db49b1eeb256536a", 0 ) )
        {
            function_68e86ff96611ef5( level.mapcenter + ( 0, 0, 5000 ), streakinfo );
            return 1;
        }
    #/
    
    result = function_22796ba52e1d0fd0( streakinfo );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive" );
    return result;
}

// Namespace emp_blast_mp
// Params 1
// Checksum 0x9e318d43, Offset: 0x8d5
// Size: 0x2a7
function function_22796ba52e1d0fd0( streakinfo )
{
    heightoffset = 6000;
    horizontaloffset = 8000;
    targetoffset = 5000;
    spawncenterpos = level.mapcenter;
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
    missilepod setmodel( "sat_wmd_vm_missile_cruise_mp" );
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
    result = function_88be63dc21260d91( missilepod, targetpos, streakinfo );
    return result;
}

#using_animtree( "script_model" );

// Namespace emp_blast_mp
// Params 3
// Checksum 0x76fd7b6, Offset: 0xb85
// Size: 0x1ad, Type: bool
function function_88be63dc21260d91( pod, breakpos, streakinfo )
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

// Namespace emp_blast_mp
// Params 3
// Checksum 0xbb2ef13c, Offset: 0xd3b
// Size: 0x24a
function missile_fireout( pod, streakinfo, targetpos )
{
    pod endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    pod setscriptablepartstate( "sub_thruster", "off", 0 );
    missile = spawn( "script_model", pod gettagorigin( "tag_missile" ) );
    missile.angles = pod.angles;
    missile setmodel( "sat_wmd_vm_missile_cruise_warhead_mp" );
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
    fxent = spawn( "script_model", missile gettagorigin( "tag_fx" ) );
    fxent setmodel( "sat_killstreak_emp_blast_mp" );
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

// Namespace emp_blast_mp
// Params 0
// Checksum 0xbad8c47e, Offset: 0xf8d
// Size: 0x198
function function_34773c4f4c67a20b()
{
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        objid = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        self.var_c7045413fdea88bc = objid;
        bundle = self.streakinfo.bundle;
        icon = bundle.var_994ed5722da55a8c ?? "hud_icon_minimap_killstreak_cruise_missile";
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

// Namespace emp_blast_mp
// Params 0
// Checksum 0xdc79d8f2, Offset: 0x112d
// Size: 0x41
function function_4a6006efcf48d282()
{
    destpoint = self.origin + anglestoforward( self.angles ) * 50000;
    missilemovetime = 16.6667;
    self moveto( destpoint, missilemovetime );
}

// Namespace emp_blast_mp
// Params 2
// Checksum 0x9620e2, Offset: 0x1176
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

// Namespace emp_blast_mp
// Params 2
// Checksum 0x40518afd, Offset: 0x1202
// Size: 0xc8
function missile_watchgameend( missile, streakinfo )
{
    missile endon( #"death", #"cruise_missile_explode" );
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

// Namespace emp_blast_mp
// Params 1
// Checksum 0x8e394e3e, Offset: 0x12d2
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

// Namespace emp_blast_mp
// Params 1
// Checksum 0xce900c60, Offset: 0x1323
// Size: 0x1c0
function missile_watchmissileexplosion( missile )
{
    missile endon( #"hash_d492b41c9971638f" );
    explodepos = undefined;
    streakinfo = missile.streakinfo;
    explodeinfo = undefined;
    
    while ( true )
    {
        explodeinfo = missile missile_waittillexplode( "collision", "explode", "death", "disowned", "emp_blast_defused", "trophy_blocked" );
        
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
        
        if ( isdefined( missile ) )
        {
            missile delete();
        }
        
        if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
        {
            [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( explodepos );
        }
        
        thread missile_handlevfxstates( explodeinfo, missile.owner, streakinfo );
    }
}

// Namespace emp_blast_mp
// Params 6
// Checksum 0x7d55ce95, Offset: 0x14eb
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

// Namespace emp_blast_mp
// Params 2
// Checksum 0x35caee18, Offset: 0x16a0
// Size: 0x89
function waittill_explodestring( msg, ent )
{
    self endon( #"death" );
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6 );
}

// Namespace emp_blast_mp
// Params 1
// Checksum 0x2b06bd9c, Offset: 0x1731
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

// Namespace emp_blast_mp
// Params 1
// Checksum 0xeeb613f3, Offset: 0x1790
// Size: 0x39
function missile_watchtimer( rider )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( 10.1 );
    self notify( #"explode", self.origin );
}

// Namespace emp_blast_mp
// Params 3
// Checksum 0x5f175f5c, Offset: 0x17d1
// Size: 0x17c
function missile_handlevfxstates( explodeinfo, owner, streakinfo )
{
    self endon( #"death" );
    self unlink();
    
    if ( !isdefined( explodeinfo ) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_blast_defused" || explodeinfo.msg == "trophy_blocked" )
    {
        self setscriptablepartstate( "emp_air_explosion", "on", 0 );
        hostmigration::waitlongdurationwithpause( 0.2 );
        owner thread function_2f4090fbaaeb0c47();
        owner thread function_68e86ff96611ef5( self.origin, streakinfo );
        wait 2;
        self delete();
        return;
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
    owner thread function_2f4090fbaaeb0c47();
    owner function_68e86ff96611ef5( self.origin, streakinfo );
    self delete();
}

// Namespace emp_blast_mp
// Params 0
// Checksum 0xd684b11c, Offset: 0x1955
// Size: 0x81
function function_2f4090fbaaeb0c47()
{
    teamtocheck = self.pers[ "team" ];
    characterref = dialog_utility::function_8f16d04b74c7bcd1( teamtocheck );
    character = dialog_utility::function_b857dac241739eeb( "Character", characterref );
    
    if ( !isdefined( character ) )
    {
        character = "mili";
    }
    
    dialogalias = "dx_mp_core_anno_" + character + "_cege";
    thread killstreak_utility::playkillstreakoperatordialog( "emp_blast", dialogalias, #"emp_detonated" );
}

// Namespace emp_blast_mp
// Params 2
// Checksum 0x55fa5fa7, Offset: 0x19de
// Size: 0x45c
function function_68e86ff96611ef5( explodelocation, streakinfo )
{
    level endon( #"game_ended" );
    level notify( #"emp_blast_applied" );
    bundle = streakinfo.bundle;
    var_f634448ec700952e = bundle.var_30db3099bbbead30 ?? 6;
    var_a807e6ced449532f = bundle.emp_blast_do_stun;
    var_fbe6ef4bfb7c9ae5 = bundle.var_1a91e7b4d472bbe7;
    var_bad703b72b883810 = bundle.var_93984c2eb049d09e;
    myteam = self.team;
    enemyplayers = team_utility::getenemyplayers( myteam, 1 ) ?? [];
    objweapon = makeweapon( "sat_emp_blast_dmg_weapon_mp" );
    var_1ccdfb12d88b35e0 = [];
    
    foreach ( enemy in enemyplayers )
    {
        if ( enemy thread function_788cb5548c96a17d( self, objweapon, explodelocation, var_f634448ec700952e, var_a807e6ced449532f, var_fbe6ef4bfb7c9ae5, var_bad703b72b883810 ) )
        {
            var_1ccdfb12d88b35e0[ var_1ccdfb12d88b35e0.size ] = enemy;
        }
    }
    
    if ( var_1ccdfb12d88b35e0.size > 0 )
    {
        basescore = 10;
        overridescore = basescore * var_1ccdfb12d88b35e0.size;
        points::doscoreevent( #"emped_player", objweapon, overridescore );
    }
    
    level.var_89fe7f9fa2bc945d = function_5713d46873b29625( level.var_89fe7f9fa2bc945d );
    var_b786ee27025030c9 = level.var_89fe7f9fa2bc945d;
    killstreakarray = level.activekillstreaks;
    minearray = weapon::function_3aafcaf7ff6dea9e();
    supportboxarray = level.allsupportboxes;
    ents = [];
    ents = arraycombineunique( ents, var_b786ee27025030c9, killstreakarray, minearray, supportboxarray );
    entsaffected = [];
    
    foreach ( ent in ents )
    {
        if ( ent.isdestroyed )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            continue;
        }
        
        if ( !ent.owner || player_utility::playersareenemies( self, ent.owner ) )
        {
            if ( ent.var_835075bb2467fb1b )
            {
                continue;
            }
            
            if ( ent thread function_7594e211517adfba( self, objweapon, streakinfo, var_f634448ec700952e ) )
            {
                entsaffected[ entsaffected.size ] = ent;
            }
        }
    }
    
    if ( entsaffected.size >= 5 )
    {
        thread points::doscoreevent( #"emp_white_noise", objweapon );
    }
    
    challenges::function_3d7a169dbae062fb( "emp_blast", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ), entsaffected.size ?? 0 );
    challenges::function_3d7a169dbae062fb( "emp_blast", self, undefined, undefined, var_1ccdfb12d88b35e0.size ?? 0, undefined, undefined, var_1ccdfb12d88b35e0[ 0 ] );
    wait var_f634448ec700952e;
    
    foreach ( enemy in var_1ccdfb12d88b35e0 )
    {
        enemy thread function_50f531c87248204c();
    }
    
    foreach ( ent in entsaffected )
    {
        ent thread function_29befc909c33075d();
    }
    
    level thread function_1a2be41d09afd64b();
    
    if ( self )
    {
        killstreak_utility::recordkillstreakendstats( streakinfo );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace emp_blast_mp
// Params 7
// Checksum 0xedcf725b, Offset: 0x1e42
// Size: 0x1f3, Type: bool
function function_788cb5548c96a17d( attacker, objweapon, explodelocation, var_f634448ec700952e, var_a807e6ced449532f, var_fbe6ef4bfb7c9ae5, var_bad703b72b883810 )
{
    if ( isdefined( self.perks[ "specialty_tac_mask" ] ) && isdefined( self.perks[ "specialty_emp_immunity" ] ) )
    {
        if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
        {
            perks::function_142df1226093bce0( "specialty_tac_mask" );
        }
        else
        {
            perks::activateperk( "specialty_tac_mask" );
        }
        
        return false;
    }
    
    if ( !self || isdefined( self.perks[ "specialty_emp_immunity" ] ) || isdefined( self.perks[ "specialty_empimmune" ] ) )
    {
        return false;
    }
    
    empdata = damage_utility::packdamagedata( attacker, self, 1, objweapon, "MOD_EXPLOSIVE", attacker, explodelocation );
    self.var_c7dc16398800176e = empdata;
    self.ksempd = 1;
    self.empcount = self.empcount ? self.empcount + 1 : 1;
    telemetry_mp::function_594cbdc6a4d8098a( self, attacker, objweapon );
    self notify( #"emp_started" );
    
    if ( self.var_9169e6e8e1b6fc53 )
    {
        self thread [[ self.var_9169e6e8e1b6fc53 ]]( empdata );
    }
    
    self notify( #"emp_applied" );
    
    if ( self.var_c5ccf9dff3b5e393 )
    {
        self thread [[ self.var_c5ccf9dff3b5e393 ]]( empdata );
    }
    
    if ( var_a807e6ced449532f )
    {
        shellshock_utility_cpmp::_shellshock( %"emp", #"stun", var_f634448ec700952e, 1 );
    }
    
    if ( var_fbe6ef4bfb7c9ae5 )
    {
        val::set( "ksEMPBlast", "supers", 0 );
        thread function_42abcf5abdefbe8c();
    }
    
    if ( var_bad703b72b883810 )
    {
        val::set( "ksEMPBlast", "killstreaks", 0 );
    }
    
    function_b0053a96fc4c5b55();
    self setempjammed( 1 );
    return true;
}

// Namespace emp_blast_mp
// Params 0, eflags: 0xc
// Checksum 0x6ca61ae9, Offset: 0x203e
// Size: 0x93
function private function_42abcf5abdefbe8c()
{
    self notify( #"hash_a5a2283eb6eddb9b" );
    self endon( #"hash_a5a2283eb6eddb9b" );
    level endon( #"game_ended" );
    self endon( #"disconnect", #"emp_cleared" );
    
    while ( true )
    {
        if ( self superbuttonpressed() && supers_mp::issuperready() && player::isreallyalive( self ) && self.ksempd )
        {
            utility::callsharedfunc( #"hud", #"showerrormessage", %"mp/supers_unavailable" );
            wait 2;
        }
        
        waitframe();
    }
}

// Namespace emp_blast_mp
// Params 0
// Checksum 0xbefe43af, Offset: 0x20d9
// Size: 0x8a
function function_50f531c87248204c()
{
    if ( !self.ksempd )
    {
        return;
    }
    
    emp_debuff::clear_emp();
    val::reset( "ksEMPBlast", "killstreaks" );
    val::reset( "ksEMPBlast", "supers" );
    function_5bb48ea0916dc188();
    self notify( #"emp_cleared" );
    
    if ( isdefined( self.var_3ad9cec860d7aaa ) )
    {
        self [[ self.var_3ad9cec860d7aaa ]]( self.var_c7dc16398800176e );
    }
    
    self.ksempd = undefined;
    self.var_c7dc16398800176e = undefined;
    self setempjammed( 0 );
}

// Namespace emp_blast_mp
// Params 0
// Checksum 0x17d8ad15, Offset: 0x216b
// Size: 0x1d
function function_b0053a96fc4c5b55()
{
    self playsoundtoplayer( #"hash_e537c3a826c5a0ba", self );
    emp_debuff::play_emp_scramble( 3, 1 );
}

// Namespace emp_blast_mp
// Params 0
// Checksum 0x37069759, Offset: 0x2190
// Size: 0x46
function function_5bb48ea0916dc188()
{
    if ( self.vehiclescramble )
    {
        self.vehiclescramble = undefined;
        thread emp_debuff::stop_emp_scramble( 4 );
    }
    
    if ( player::isreallyalive( self ) )
    {
        self playsoundtoplayer( #"kls_emp_hud_activate", self );
    }
    
    emp_debuff::stop_emp_scramble( 3, 1 );
}

// Namespace emp_blast_mp
// Params 4
// Checksum 0xcf3954af, Offset: 0x21de
// Size: 0x154, Type: bool
function function_7594e211517adfba( attacker, objweapon, streakinfo, duration )
{
    if ( !self )
    {
        return false;
    }
    
    dmg = 33033;
    empdata = damage_utility::packdamagedata( attacker, self, dmg, objweapon, "MOD_EXPLOSIVE", attacker, self.origin );
    empdata.time = duration;
    self.ksempd = 1;
    self.var_c7dc16398800176e = empdata;
    self.empcount = self.empcount ? self.empcount + 1 : 1;
    self notify( #"emp_started" );
    
    if ( self.var_9169e6e8e1b6fc53 )
    {
        self [[ self.var_9169e6e8e1b6fc53 ]]( empdata );
    }
    
    self notify( #"emp_applied" );
    
    if ( self.var_c5ccf9dff3b5e393 )
    {
        self [[ self.var_c5ccf9dff3b5e393 ]]( empdata );
        
        if ( streakinfo )
        {
            events::killedequipment( empdata.victim, attacker, objweapon, streakinfo );
        }
    }
    else if ( self.empapplycallback )
    {
        self [[ self.empapplycallback ]]( empdata );
    }
    else
    {
        self dodamage( dmg, self.origin, attacker, attacker, "MOD_EXPLOSIVE", objweapon );
    }
    
    return true;
}

// Namespace emp_blast_mp
// Params 0
// Checksum 0xa8d65c10, Offset: 0x233b
// Size: 0x8e
function function_29befc909c33075d()
{
    self.empcount = self.empcount ? self.empcount - 1 : 0;
    self notify( #"emp_cleared" );
    
    if ( self.var_3ad9cec860d7aaa )
    {
        self [[ self.var_3ad9cec860d7aaa ]]( self.var_c7dc16398800176e );
    }
    else if ( self.empclearcallback )
    {
        self [[ self.empclearcallback ]]( self.var_c7dc16398800176e );
    }
    
    self.ksempd = undefined;
    self.var_c7dc16398800176e = undefined;
}

// Namespace emp_blast_mp
// Params 0
// Checksum 0x27e93d2c, Offset: 0x23d1
// Size: 0x11
function function_b93b3b95d11cddaf()
{
    wait 5;
    audio_utility::snd_transient_unload( "kls_jup_emp" );
}

