// scripts\mp\common\killstreaks\autosentry.gsc  (hash_491f292846afb8ca.gscc) (size: 40294 Bytes / 0x9d66 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13a93837 (329857079)
// size ...... 40294 (0x9d66)
// includes .. 27  (offset: 0x93e6)
// strings ... 126 (offset: 0x94be)
// dev strs .. 8   (offset: 0x9d02)
// exports ... 93  (offset: 0x662e)
// cseg ...... 0xabd + 0x5b71 (0x662e)
// imports ... 242 (offset: 0x74b6)
// animtree1 . 0   (offset: 0x9d66)
// animtree2 . 0   (offset: 0x9d66)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\helicopter;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\events;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\movers;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace autosentry;

// Namespace autosentry
// Params 0
// Checksum 0x42c507d0, Offset: 0xadb
// Size: 0x710
function init()
{
    level.sentrytype = [];
    level.sentrytype[ "super_trophy" ] = "super_trophy";
    level.sentrytype[ "sentry_shock" ] = "sentry_shock";
    level.sentrytype[ "manual_turret" ] = "manual_turret";
    assertmsg( "<dev string:x24>" );
    level.sentrysettings = [];
    level.sentrysettings[ "super_trophy" ] = spawnstruct();
    level.sentrysettings[ "super_trophy" ].health = 999999;
    level.sentrysettings[ "super_trophy" ].maxhealth = 100;
    level.sentrysettings[ "super_trophy" ].sentrymodeon = "sentry";
    level.sentrysettings[ "super_trophy" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "super_trophy" ].weaponinfo = "sentry_laser_mp";
    level.sentrysettings[ "super_trophy" ].modelbase = "super_trophy_mp";
    level.sentrysettings[ "super_trophy" ].modelgood = "super_trophy_mp_placement";
    level.sentrysettings[ "super_trophy" ].modelbad = "super_trophy_mp_placement_fail";
    level.sentrysettings[ "super_trophy" ].modeldestroyed = "super_trophy_mp";
    level.sentrysettings[ "super_trophy" ].hintstring = &"hash_5548dfb84eb47cf1";
    level.sentrysettings[ "super_trophy" ].headicon = 1;
    level.sentrysettings[ "super_trophy" ].teamsplash = "used_super_trophy";
    level.sentrysettings[ "super_trophy" ].shouldsplash = 0;
    level.sentrysettings[ "super_trophy" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "sentry_shock" ] = spawnstruct();
    level.sentrysettings[ "sentry_shock" ].health = 999999;
    level.sentrysettings[ "sentry_shock" ].maxhealth = 670;
    level.sentrysettings[ "sentry_shock" ].burstmin = 20;
    level.sentrysettings[ "sentry_shock" ].burstmax = 120;
    level.sentrysettings[ "sentry_shock" ].pausemin = 0.15;
    level.sentrysettings[ "sentry_shock" ].pausemax = 0.35;
    level.sentrysettings[ "sentry_shock" ].sentrymodeon = "sentry";
    level.sentrysettings[ "sentry_shock" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "sentry_shock" ].timeout = 90;
    level.sentrysettings[ "sentry_shock" ].spinuptime = 0.05;
    level.sentrysettings[ "sentry_shock" ].overheattime = 8;
    level.sentrysettings[ "sentry_shock" ].cooldowntime = 0.1;
    level.sentrysettings[ "sentry_shock" ].fxtime = 0.3;
    level.sentrysettings[ "sentry_shock" ].streakname = "sentry_shock";
    level.sentrysettings[ "sentry_shock" ].weaponinfo = "sentry_shock_mp";
    level.sentrysettings[ "sentry_shock" ].scriptable = "ks_shock_sentry_mp";
    level.sentrysettings[ "sentry_shock" ].modelbase = "shock_sentry_gun_wm";
    level.sentrysettings[ "sentry_shock" ].modelgood = "shock_sentry_gun_wm_obj";
    level.sentrysettings[ "sentry_shock" ].modelbad = "shock_sentry_gun_wm_obj_red";
    level.sentrysettings[ "sentry_shock" ].modeldestroyed = "shock_sentry_gun_wm_destroyed";
    level.sentrysettings[ "sentry_shock" ].hintstring = &"hash_5548dfb84eb47cf1";
    level.sentrysettings[ "sentry_shock" ].headicon = 1;
    level.sentrysettings[ "sentry_shock" ].teamsplash = "used_shock_sentry";
    level.sentrysettings[ "sentry_shock" ].destroyedsplash = "callout_destroyed_sentry_shock";
    level.sentrysettings[ "sentry_shock" ].shouldsplash = 1;
    level.sentrysettings[ "sentry_shock" ].votimeout = "sentry_gun_teamleader_crash";
    level.sentrysettings[ "sentry_shock" ].vodestroyed = "sentry_gun_teamleader_crash";
    level.sentrysettings[ "sentry_shock" ].scorepopup = "destroyed_sentry";
    level.sentrysettings[ "sentry_shock" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "sentry_shock" ].iskillstreak = 1;
    level.sentrysettings[ "sentry_shock" ].headiconoffset = 75;
    level._effect[ "sentry_overheat_mp" ] = loadfxasset( "vfx_core_mp_strk_sg_overheat_smoke" );
    level._effect[ "sentry_explode_mp" ] = loadfxasset( "vfx_iw7_requests_mp_generic_equip_explo_lg" );
    level._effect[ "sentry_sparks_mp" ] = loadfxasset( "vfx_core_mp_strk_sentry_gun_explo" );
    level._effect[ "sentry_smoke_mp" ] = loadfxasset( "vfx_iw7_requests_mp_gen_equip_dam_spark_runner" );
    level._effect[ "sentry_shock_charge" ] = loadfxasset( "missing" );
    level._effect[ "sentry_shock_screen" ] = loadfxasset( "vfx_iw7_requests_mp_sentry_shock_screen" );
    level._effect[ "sentry_shock_base" ] = loadfxasset( "vfx_iw7_requests_mp_sentry_shock_base" );
    level._effect[ "sentry_shock_radius" ] = loadfxasset( "vfx_iw7_requests_mp_sentry_shock_radius" );
    level._effect[ "sentry_shock_explosion" ] = loadfxasset( "vfx_iw7_requests_mp_sentry_shock_end" );
    level._effect[ "sentry_shock_trail" ] = loadfxasset( "vfx_iw7_requests_mp_sentry_shock_proj_trail" );
    level._effect[ "sentry_shock_arc" ] = loadfxasset( "missing" );
    
    /#
        setdevdvarifuninitialized( @"scr_sentry_timeout", 90 );
    #/
}

// Namespace autosentry
// Params 2
// Checksum 0xc2a636be, Offset: 0x11f3
// Size: 0x65
function tryuseautosentry( lifeid, streakname )
{
    result = givesentry( "sentry_minigun" );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, level.sentrysettings[ "sentry_minigun" ].streakname, self.origin );
    }
    
    return result;
}

// Namespace autosentry
// Params 2
// Checksum 0xed15438f, Offset: 0x1261
// Size: 0x65
function tryusesam( lifeid, streakname )
{
    result = givesentry( "sam_turret" );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, level.sentrysettings[ "sam_turret" ].streakname, self.origin );
    }
    
    return result;
}

// Namespace autosentry
// Params 1
// Checksum 0x354a98f5, Offset: 0x12cf
// Size: 0x55
function tryuseshocksentry( streakinfo )
{
    result = givesentry( "sentry_shock", undefined, streakinfo );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, streakinfo.streakname, self.origin );
    }
    else
    {
        waitframe();
    }
    
    return result;
}

// Namespace autosentry
// Params 1
// Checksum 0x9d230063, Offset: 0x132d
// Size: 0x55
function tryusemanualturret( streakinfo )
{
    result = givesentry( "manual_turret", undefined, streakinfo );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, streakinfo.streakname, self.origin );
    }
    else
    {
        waitframe();
    }
    
    return result;
}

// Namespace autosentry
// Params 3
// Checksum 0xa1d503ab, Offset: 0x138b
// Size: 0xef
function givesentry( sentrytype, pickuptriggeroverride, streakinfo )
{
    self.last_sentry = sentrytype;
    
    if ( !isdefined( self.placedsentries ) )
    {
        self.placedsentries = [];
    }
    
    if ( !isdefined( self.placedsentries[ sentrytype ] ) )
    {
        self.placedsentries[ sentrytype ] = [];
    }
    
    enablepickup = 1;
    
    if ( isdefined( pickuptriggeroverride ) )
    {
        enablepickup = pickuptriggeroverride;
    }
    
    sentrygun = createsentryforplayer( sentrytype, self, enablepickup, streakinfo );
    
    if ( isdefined( streakinfo ) )
    {
        streakinfo.sentrygun = sentrygun;
    }
    
    removeperks();
    self.carriedsentry = sentrygun;
    result = setcarryingsentry( sentrygun, 1, enablepickup );
    self.carriedsentry = undefined;
    thread waitrestoreperks();
    self.iscarrying = 0;
    
    if ( isdefined( sentrygun ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace autosentry
// Params 4
// Checksum 0xef26da3d, Offset: 0x1482
// Size: 0x1b7
function setcarryingsentry( sentrygun, allowcancel, enablepickup, cancelondeath )
{
    self endon( #"death_or_disconnect" );
    assert( player::isreallyalive( self ) );
    sentrygun sentry_setcarried( self, enablepickup, cancelondeath );
    val::set( "sentry", "usability", 0 );
    val::set( "sentry", "melee", 0 );
    allowweaponsforsentry( 0 );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "place_sentry", "+attack" );
        self notifyonplayercommand( "place_sentry", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancel_sentry", "+actionslot 4" );
        
        if ( !self isconsoleplayer() )
        {
            self notifyonplayercommand( "cancel_sentry", "+actionslot 5" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 6" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 7" );
        }
    }
    
    for ( ;; )
    {
        result = utility::waittill_any_return( "place_sentry", "cancel_sentry", "force_cancel_placement", "emp_applied" );
        
        if ( !isdefined( sentrygun ) )
        {
            allowweaponsforsentry( 1 );
            thread enablemeleeforsentry();
            return 1;
        }
        
        if ( result == "cancel_sentry" || result == "force_cancel_placement" || result == "emp_applied" )
        {
            if ( !allowcancel && ( result == "cancel_sentry" || result == "emp_applied" ) )
            {
                continue;
            }
            
            sentrygun sentry_setcancelled( result == "force_cancel_placement" && !isdefined( sentrygun.firstplacement ) );
            return 0;
        }
        
        if ( !sentrygun.canbeplaced )
        {
            continue;
        }
        
        sentrygun sentry_setplaced( enablepickup );
        return 1;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xe0c343d, Offset: 0x1641
// Size: 0x20
function enablemeleeforsentry()
{
    self endon( #"death_or_disconnect" );
    wait 0.25;
    val::reset_all( "sentry" );
}

// Namespace autosentry
// Params 0
// Checksum 0x3716cf1, Offset: 0x1669
// Size: 0x29
function removeweapons()
{
    if ( self hasweapon( "iw6_riotshield_mp" ) )
    {
        self.restoreweapon = "iw6_riotshield_mp";
        inventory_utility::_takeweapon( "iw6_riotshield_mp" );
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x970bfaed, Offset: 0x169a
// Size: 0x2f
function removeperks()
{
    if ( isdefined( self.perks[ "specialty_explosivebullets" ] ) )
    {
        self.restoreperk = "specialty_explosivebullets";
        perk::removeperk( "specialty_explosivebullets" );
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x1835287d, Offset: 0x16d1
// Size: 0x29
function restoreweapons()
{
    if ( isdefined( self.restoreweapon ) )
    {
        inventory_utility::_giveweapon( self.restoreweapon );
        self.restoreweapon = undefined;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x9ad97bc7, Offset: 0x1702
// Size: 0x29
function restoreperks()
{
    if ( isdefined( self.restoreperk ) )
    {
        perk::giveperk( self.restoreperk );
        self.restoreperk = undefined;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xe81fb456, Offset: 0x1733
// Size: 0x22
function waitrestoreperks()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    waitframe();
    restoreperks();
}

// Namespace autosentry
// Params 4
// Checksum 0xc46fda91, Offset: 0x175d
// Size: 0xdc
function createsentryforplayer( sentrytype, owner, enablepickup, streakinfo )
{
    assert( isdefined( owner ), "<dev string:x71>" );
    sentryweapon = level.sentrysettings[ sentrytype ].weaponinfo;
    sentrygun = spawnturret( "misc_turret", owner.origin, sentryweapon );
    sentrygun.angles = owner.angles;
    sentrygun.streakinfo = streakinfo;
    sentrygun sentry_initsentry( sentrytype, owner, enablepickup );
    sentrygun thread sentry_destroyongameend();
    sentrygun emp_debuff::allow_emp( 0 );
    sentrygun emp_debuff::set_start_emp_callback( &sentry_empstarted );
    sentrygun emp_debuff::set_clear_emp_callback( &sentry_empcleared );
    return sentrygun;
}

// Namespace autosentry
// Params 4
// Checksum 0x6eaba307, Offset: 0x1842
// Size: 0x4a1
function sentry_initsentry( sentrytype, owner, enablepickup, timeout = 1 )
{
    self.sentrytype = sentrytype;
    self.canbeplaced = 1;
    self setmodel( level.sentrysettings[ sentrytype ].modelbase );
    self setnodeploy( 1 );
    
    if ( level.sentrysettings[ sentrytype ].shouldsplash )
    {
        self.shouldsplash = 1;
    }
    else
    {
        self.shouldsplash = 0;
    }
    
    self.firstplacement = 1;
    self setcandamage( 1 );
    
    switch ( sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_8f3bfcef6a436f5b":
        case #"hash_8f3bfdef6a4370ee":
        case #"hash_8f3bfeef6a437281":
        case #"hash_8f3bffef6a437414":
        case #"hash_9cc148005b0186d6":
        case #"hash_9cc14a005b0189fc":
        case #"hash_9cc14b005b018b8f":
        case #"hash_9cc14d005b018eb5":
        case #"hash_ce05fbb198b1f5dd":
            self setleftarc( 80 );
            self setrightarc( 80 );
            self setbottomarc( 50 );
            self setdefaultdroppitch( 0 );
            self.originalowner = owner;
            break;
        case #"hash_721f6bf62b0eb1bd":
        case #"hash_c72f9e2dc5fac20b":
            self maketurretinoperable();
            self setleftarc( 180 );
            self setrightarc( 180 );
            self settoparc( 80 );
            self setdefaultdroppitch( -89 );
            self.laser_on = 0;
            killcament = spawn( "script_model", self gettagorigin( "tag_laser" ) );
            killcament linkto( self );
            self.killcament = killcament;
            self.killcament setscriptmoverkillcam( "explosive" );
            break;
        case #"hash_576b868dbf9eab17":
            self maketurretinoperable();
            killcamforward = anglestoforward( self.angles );
            killcampos = self gettagorigin( "tag_laser" ) + ( 0, 0, 10 );
            killcampos -= killcamforward * 20;
            killcament = spawn( "script_model", killcampos );
            killcament linkto( self );
            self.killcament = killcament;
            break;
        case #"hash_52d9b7ed584bec3e":
            killcamforward = anglestoforward( self.angles );
            killcampos = self gettagorigin( "tag_laser" ) + ( 0, 0, 10 );
            killcampos -= killcamforward * 20;
            killcament = spawn( "script_model", killcampos );
            killcament linkto( self );
            self.killcament = killcament;
            break;
        default:
            self maketurretinoperable();
            self setdefaultdroppitch( -89 );
            break;
    }
    
    self setturretmodechangewait( 1 );
    sentry_setinactive();
    sentry_setowner( owner );
    
    if ( timeout )
    {
        thread sentry_timeout();
    }
    
    switch ( sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_8f3bfcef6a436f5b":
        case #"hash_8f3bfdef6a4370ee":
        case #"hash_8f3bfeef6a437281":
        case #"hash_8f3bffef6a437414":
            self.momentum = 0;
            self.heatlevel = 0;
            self.overheated = 0;
            thread sentry_heatmonitor();
            break;
        case #"hash_9cc148005b0186d6":
        case #"hash_9cc14a005b0189fc":
        case #"hash_9cc14b005b018b8f":
        case #"hash_9cc14d005b018eb5":
        case #"hash_ce05fbb198b1f5dd":
            self.momentum = 0;
            self.heatlevel = 0;
            self.cooldownwaittime = 0;
            self.overheated = 0;
            thread turret_heatmonitor();
            thread turret_coolmonitor();
            break;
        case #"hash_576b868dbf9eab17":
        case #"hash_721f6bf62b0eb1bd":
        case #"hash_c72f9e2dc5fac20b":
            self.momentum = 0;
            thread sentry_handleuse( enablepickup );
            thread sentry_beepsounds();
            break;
        case #"hash_52d9b7ed584bec3e":
            self.momentum = 0;
            thread sentry_handlemanualuse();
            thread sentry_handlealteratepickup( enablepickup );
            break;
        case #"hash_b17ed5514d85b71b":
            thread sentry_handleuse( 0 );
            thread sentry_beepsounds();
            break;
        default:
            thread sentry_handleuse( enablepickup );
            thread sentry_attacktargets();
            thread sentry_beepsounds();
            break;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x21d764a, Offset: 0x1ceb
// Size: 0x5c
function sentry_setteamheadicon()
{
    headiconoffset = level.sentrysettings[ self.sentrytype ].headiconoffset;
    
    if ( !isdefined( headiconoffset ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    profilestart();
    self.headiconid = entityheadicons::setheadicon_factionimage( 0, headiconoffset, undefined, undefined, undefined, undefined, 1 );
    profilestop();
}

// Namespace autosentry
// Params 0
// Checksum 0x53d55aec, Offset: 0x1d4f
// Size: 0x43
function sentry_clearteamheadicon()
{
    headiconoffset = level.sentrysettings[ self.sentrytype ].headiconoffset;
    
    if ( !isdefined( headiconoffset ) )
    {
        return;
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconid );
}

// Namespace autosentry
// Params 0
// Checksum 0x5855ac66, Offset: 0x1d9a
// Size: 0x2c
function sentry_destroyongameend()
{
    self endon( #"death" );
    level utility::waittill_any( "bro_shot_start", "game_ended" );
    self notify( #"death" );
}

// Namespace autosentry
// Params 0
// Checksum 0x624a346c, Offset: 0x1dce
// Size: 0x51
function sentry_handledamage()
{
    self endon( #"carried" );
    maxhealth = level.sentrysettings[ self.sentrytype ].maxhealth;
    damage::monitordamage( maxhealth, "sentry", &sentryhandledeathdamage, &sentrymodifydamage, 1 );
}

// Namespace autosentry
// Params 1
// Checksum 0x36a23682, Offset: 0x1e27
// Size: 0xa9
function sentrymodifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    
    if ( type == "MOD_MELEE" )
    {
        modifieddamage = self.maxhealth * 0.34;
    }
    
    modifieddamage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4 );
    return modifieddamage;
}

// Namespace autosentry
// Params 1
// Checksum 0x82e7c7e0, Offset: 0x1ed9
// Size: 0x157
function sentryhandledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = level.sentrysettings[ self.sentrytype ];
    
    if ( config.iskillstreak )
    {
        notifyattacker = damage::onkillstreakkilled( config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash );
        return;
    }
    
    validattacker = undefined;
    tempattacker = attacker;
    
    if ( isdefined( tempattacker ) && isdefined( self.owner ) )
    {
        if ( isplayer( attacker.owner ) )
        {
            tempattacker = attacker.owner;
        }
        
        if ( self.owner player_utility::isenemy( tempattacker ) )
        {
            validattacker = tempattacker;
        }
    }
    
    if ( isdefined( validattacker ) )
    {
        validattacker thread events::supershutdown( self.owner );
    }
    
    self notify( #"death" );
}

// Namespace autosentry
// Params 1
// Checksum 0x88a9eab3, Offset: 0x2038
// Size: 0x69
function sentry_empstarted( data )
{
    self.disabled = 1;
    self setdefaultdroppitch( 40 );
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
    self cleartargetentity();
    self setscriptablepartstate( "muzzle", "neutral", 0 );
    self setscriptablepartstate( "stunned", "active" );
}

// Namespace autosentry
// Params 1
// Checksum 0x90d18e2b, Offset: 0x20a9
// Size: 0x5a
function sentry_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    self setdefaultdroppitch( -89 );
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
    self setscriptablepartstate( "stunned", "neutral" );
    self.disabled = undefined;
}

// Namespace autosentry
// Params 0
// Checksum 0x72c048d, Offset: 0x210b
// Size: 0x368
function sentry_handledeath()
{
    self endon( #"carried" );
    self waittill( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner.placedsentries[ self.sentrytype ] = arrayremove( self.owner.placedsentries[ self.sentrytype ], self );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self cleartargetentity();
    self laseroff();
    self setmodel( level.sentrysettings[ self.sentrytype ].modeldestroyed );
    
    if ( isdefined( self.fxentdeletelist ) && self.fxentdeletelist.size > 0 )
    {
        foreach ( fxent in self.fxentdeletelist )
        {
            if ( isdefined( fxent ) )
            {
                fxent delete();
            }
        }
        
        self.fxentdeletelist = undefined;
    }
    
    sentry_setinactive();
    self setdefaultdroppitch( 40 );
    self setsentryowner( undefined );
    
    if ( isdefined( self.inuseby ) )
    {
        self useby( self.inuseby );
    }
    
    self setturretminimapvisible( 0 );
    
    if ( isdefined( self.ownertrigger ) )
    {
        self.ownertrigger delete();
    }
    
    self playsound( "mp_equip_destroyed" );
    
    switch ( self.sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_ce05fbb198b1f5dd":
            self.forcedisable = 1;
            self turretfiredisable();
            break;
        default:
            break;
    }
    
    if ( isdefined( self.inuseby ) )
    {
        playfxontag( utility::getfx( "sentry_explode_mp" ), self, "tag_origin" );
        playfxontag( utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
        self.inuseby.turret_overheat_bar hud_util::destroyelem();
        self.inuseby restoreperks();
        self.inuseby restoreweapons();
        self notify( #"deleting" );
        wait 1;
        stopfxontag( utility::getfx( "sentry_explode_mp" ), self, "tag_origin" );
        stopfxontag( utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
    }
    else
    {
        self playsound( "sentry_explode_smoke" );
        self setscriptablepartstate( "destroyed", "sparks" );
        wait 5;
        playfx( utility::getfx( "sentry_explode_mp" ), self.origin + ( 0, 0, 10 ) );
        self notify( #"deleting" );
    }
    
    weapons::equipmentdeletevfx();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( isdefined( self.airlookatent ) )
    {
        self.airlookatent delete();
    }
    
    if ( isdefined( self.manualpickuptrigger ) )
    {
        self.manualpickuptrigger delete();
    }
    
    /#
        print::printgameaction( "<dev string:xa8>", self.owner );
    #/
    
    self delete();
}

// Namespace autosentry
// Params 1
// Checksum 0x8c085fe6, Offset: 0x247b
// Size: 0xfb
function sentry_handleuse( enablepickup )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"trigger", player );
        assert( player == self.owner );
        assert( !isdefined( self.carriedby ) );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret" )
        {
            self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        }
        
        player.placedsentries[ self.sentrytype ] = arrayremove( player.placedsentries[ self.sentrytype ], self );
        player setcarryingsentry( self, 0, enablepickup );
    }
}

// Namespace autosentry
// Params 1
// Checksum 0xf206d611, Offset: 0x257e
// Size: 0x174
function turret_handlepickup( turret )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    turret endon( #"death" );
    
    if ( !isdefined( turret.ownertrigger ) )
    {
        return;
    }
    
    buttontime = 0;
    
    for ( ;; )
    {
        if ( isalive( self ) && self istouching( turret.ownertrigger ) && !isdefined( turret.inuseby ) && !isdefined( turret.carriedby ) && self isonground() )
        {
            if ( self usebuttonpressed() )
            {
                buttontime = 0;
                
                while ( self usebuttonpressed() )
                {
                    buttontime += level.framedurationseconds;
                    waitframe();
                }
                
                println( "<dev string:xc8>" + buttontime );
                
                if ( buttontime >= 0.5 )
                {
                    continue;
                }
                
                buttontime = 0;
                
                while ( !self usebuttonpressed() && buttontime < 0.5 )
                {
                    buttontime += level.framedurationseconds;
                    waitframe();
                }
                
                println( "<dev string:xd5>" + buttontime );
                
                if ( buttontime >= 0.5 )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( self ) )
                {
                    continue;
                }
                
                turret setmode( level.sentrysettings[ turret.sentrytype ].sentrymodeoff );
                thread setcarryingsentry( turret, 0 );
                turret.ownertrigger delete();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x2b7ad3d4, Offset: 0x26fa
// Size: 0x450
function turret_handleuse()
{
    self notify( #"hash_e941f7a9633125b6" );
    self endon( #"hash_e3f3565bf6948aa9" );
    self endon( #"deleting" );
    level endon( #"game_ended" );
    self.forcedisable = 0;
    colorstable = ( 1, 0.9, 0.7 );
    colorunstable = ( 1, 0.65, 0 );
    coloroverheated = ( 1, 0.25, 0 );
    
    for ( ;; )
    {
        self waittill( #"trigger", player );
        
        if ( isdefined( self.carriedby ) )
        {
            continue;
        }
        
        if ( isdefined( self.inuseby ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player removeperks();
        player removeweapons();
        self.inuseby = player;
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        sentry_setowner( player );
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
        player thread turret_shotmonitor( self );
        player.turret_overheat_bar = player hud_util::createbar( colorstable, 100, 6 );
        player.turret_overheat_bar hud_util::setpoint( "CENTER", "BOTTOM", 0, -70 );
        player.turret_overheat_bar.alpha = 0.65;
        player.turret_overheat_bar.bar.alpha = 0.65;
        playingheatfx = 0;
        
        for ( ;; )
        {
            if ( !player::isreallyalive( player ) )
            {
                self.inuseby = undefined;
                player.turret_overheat_bar hud_util::destroyelem();
                break;
            }
            
            if ( !player isusingturret() )
            {
                self notify( #"player_dismount" );
                self.inuseby = undefined;
                player.turret_overheat_bar hud_util::destroyelem();
                player restoreperks();
                player restoreweapons();
                self sethintstring( level.sentrysettings[ self.sentrytype ].hintstring );
                self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
                sentry_setowner( self.originalowner );
                self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
                break;
            }
            
            if ( self.heatlevel >= level.sentrysettings[ self.sentrytype ].overheattime )
            {
                barfrac = 1;
            }
            else
            {
                barfrac = self.heatlevel / level.sentrysettings[ self.sentrytype ].overheattime;
            }
            
            player.turret_overheat_bar hud_util::updatebar( barfrac );
            
            if ( self.forcedisable || self.overheated )
            {
                self turretfiredisable();
                player.turret_overheat_bar.bar.color = coloroverheated;
                playingheatfx = 0;
            }
            else if ( self.heatlevel > level.sentrysettings[ self.sentrytype ].overheattime * 0.75 && isstartstr( self.sentrytype, "minigun_turret" ) )
            {
                player.turret_overheat_bar.bar.color = colorunstable;
                
                if ( randomintrange( 0, 10 ) < 6 )
                {
                    self turretfireenable();
                }
                else
                {
                    self turretfiredisable();
                }
                
                if ( !playingheatfx )
                {
                    playingheatfx = 1;
                    thread playheatfx();
                }
            }
            else
            {
                player.turret_overheat_bar.bar.color = colorstable;
                self turretfireenable();
                playingheatfx = 0;
                self notify( #"not_overheated" );
            }
            
            wait 0.05;
        }
        
        self setdefaultdroppitch( 0 );
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x104462f3, Offset: 0x2b52
// Size: 0x56
function sentry_handleownerdisconnect()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self notify( #"hash_def371108bf3bc8" );
    self endon( #"hash_def371108bf3bc8" );
    childthread sentry_watchownerstatus( "disconnect" );
    childthread sentry_watchownerstatus( "joined_team" );
    childthread sentry_watchownerstatus( "joined_spectators" );
}

// Namespace autosentry
// Params 1
// Checksum 0x8e959533, Offset: 0x2bb0
// Size: 0x26
function sentry_watchownerstatus( notifymsg )
{
    self.owner waittill( notifymsg );
    self notify( #"death" );
}

// Namespace autosentry
// Params 1
// Checksum 0x7abcfdeb, Offset: 0x2bde
// Size: 0xa4
function sentry_setowner( owner )
{
    assert( isdefined( owner ), "<dev string:xe1>" );
    assert( isplayer( owner ), "<dev string:x112>" + owner.classname );
    self.owner = owner;
    self setsentryowner( self.owner );
    self setturretminimapvisible( 1, self.sentrytype );
    
    if ( level.teambased )
    {
        self.team = self.owner.team;
        self setturretteam( self.team );
    }
    
    thread sentry_handleownerdisconnect();
}

// Namespace autosentry
// Params 1
// Checksum 0x779b3878, Offset: 0x2c8a
// Size: 0x18
function sentry_moving_platform_death( data )
{
    self notify( #"death" );
}

// Namespace autosentry
// Params 1
// Checksum 0x4952cb7, Offset: 0x2caa
// Size: 0x3ea
function sentry_setplaced( enablepickup )
{
    if ( isdefined( self.owner ) )
    {
        sentrycount = self.owner.placedsentries[ self.sentrytype ].size;
        self.owner.placedsentries[ self.sentrytype ][ sentrycount ] = self;
        
        if ( sentrycount + 1 > 2 )
        {
            self.owner.placedsentries[ self.sentrytype ][ 0 ] notify( #"death" );
        }
        
        self.owner allowweaponsforsentry( 1 );
        self.owner thread enablemeleeforsentry();
        self.owner enableworldup( 1 );
    }
    
    self setmodel( level.sentrysettings[ self.sentrytype ].modelbase );
    
    if ( self getmode() == "manual" )
    {
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
    }
    
    thread sentry_handledamage();
    thread sentry_handledeath();
    self setsentrycarrier( undefined );
    self setcandamage( 1 );
    
    switch ( self.sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_8f3bfcef6a436f5b":
        case #"hash_8f3bfdef6a4370ee":
        case #"hash_8f3bfeef6a437281":
        case #"hash_8f3bffef6a437414":
        case #"hash_9cc148005b0186d6":
        case #"hash_9cc14a005b0189fc":
        case #"hash_9cc14b005b018b8f":
        case #"hash_9cc14d005b018eb5":
        case #"hash_ce05fbb198b1f5dd":
            if ( enablepickup )
            {
                self.angles = self.carriedby.angles;
                
                if ( isalive( self.originalowner ) )
                {
                    self.originalowner lower_message::setlowermessage( "pickup_hint", level.sentrysettings[ self.sentrytype ].ownerhintstring, 3, undefined, undefined, undefined, undefined, undefined, 1 );
                }
                
                self.ownertrigger = spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 105, 64 );
                self.ownertrigger enablelinkto();
                self.ownertrigger linkto( self );
                assert( isdefined( self.ownertrigger ) );
                self.originalowner thread turret_handlepickup( self );
                thread turret_handleuse();
            }
            
            break;
        case #"hash_52d9b7ed584bec3e":
            self setdefaultdroppitch( 30 );
            break;
        default:
            break;
    }
    
    sentry_makesolid();
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( #"update_bombsquad" );
    }
    
    self.carriedby forceusehintoff();
    self.carriedby = undefined;
    self.firstplacement = undefined;
    
    if ( isdefined( self.owner ) )
    {
        self.owner.iscarrying = 0;
        self.owner notify( #"new_sentry", self );
    }
    
    sentry_setactive( enablepickup );
    data = spawnstruct();
    
    if ( isdefined( self.moving_platform ) )
    {
        data.linkparent = self.moving_platform;
    }
    
    data.endonstring = "carried";
    data.deathoverridecallback = &sentry_moving_platform_death;
    thread movers::handle_moving_platforms( data );
    
    if ( self.sentrytype != "multiturret" )
    {
        self playsound( "sentry_gun_plant" );
    }
    
    self notify( #"placed" );
}

// Namespace autosentry
// Params 1
// Checksum 0x33a2f165, Offset: 0x309c
// Size: 0x95
function sentry_setcancelled( var_5f7bdacda98b909a )
{
    if ( isdefined( self.carriedby ) )
    {
        owner = self.carriedby;
        owner forceusehintoff();
        owner.iscarrying = undefined;
        owner.carrieditem = undefined;
        owner allowweaponsforsentry( 1 );
        owner thread enablemeleeforsentry();
        owner enableworldup( 1 );
        
        if ( isdefined( self.bombsquadmodel ) )
        {
            self.bombsquadmodel delete();
        }
    }
    
    if ( var_5f7bdacda98b909a )
    {
        weapons::equipmentdeletevfx();
    }
    
    self delete();
}

// Namespace autosentry
// Params 3
// Checksum 0xc56c5664, Offset: 0x3139
// Size: 0x173
function sentry_setcarried( carrier, enablepickup, cancelondeath )
{
    assert( isplayer( carrier ) );
    
    if ( isdefined( self.originalowner ) )
    {
        assert( carrier == self.originalowner, "<dev string:x147>" );
    }
    else
    {
        assert( carrier == self.owner, "<dev string:x147>" );
    }
    
    if ( self.sentrytype == "sentry_shock" )
    {
        self setscriptablepartstate( "muzzle", "neutral", 0 );
    }
    
    self setmodel( level.sentrysettings[ self.sentrytype ].modelgood );
    self setsentrycarrier( carrier );
    self setcandamage( 0 );
    sentry_makenotsolid();
    carrier enableworldup( 0 );
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    self.pickupenabled = enablepickup;
    thread sentry_oncarrierdeathoremp( carrier, cancelondeath );
    carrier thread updatesentryplacement( self );
    thread sentry_oncarrierdisconnect( carrier );
    thread sentry_oncarrierchangedteam( carrier );
    thread sentry_ongameended();
    emp_debuff::allow_emp( 0 );
    self setdefaultdroppitch( -89 );
    sentry_setinactive();
    
    if ( isdefined( self getlinkedparent() ) )
    {
        self unlink();
    }
    
    self notify( #"carried" );
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel hide();
    }
}

// Namespace autosentry
// Params 1
// Checksum 0xb3083ae4, Offset: 0x32b4
// Size: 0x1f6
function updatesentryplacement( sentrygun )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    sentrygun endon( #"placed" );
    sentrygun endon( #"death" );
    sentrygun.canbeplaced = 1;
    var_eb60db22eb898e2c = -1;
    
    for ( ;; )
    {
        placement = self canplayerplacesentry( 1, 40 );
        sentrygun.origin = placement[ "origin" ];
        sentrygun.angles = placement[ "angles" ];
        var_aabe89fe02c4b1ef = arraycombine( level.turrets, level.microturrets, level.supertrophy.trophies, weapon::function_3aafcaf7ff6dea9e() );
        touchingturrets = sentrygun getistouchingentities( var_aabe89fe02c4b1ef );
        sentrygun.canbeplaced = self isonground() && placement[ "result" ] && abs( sentrygun.origin[ 2 ] - self.origin[ 2 ] ) < 30 && !entity::istouchingboundstrigger( self ) && touchingturrets.size == 0;
        
        if ( isdefined( placement[ "entity" ] ) )
        {
            sentrygun.moving_platform = placement[ "entity" ];
        }
        else
        {
            sentrygun.moving_platform = undefined;
        }
        
        if ( sentrygun.canbeplaced != var_eb60db22eb898e2c )
        {
            if ( sentrygun.canbeplaced )
            {
                sentrygun setmodel( level.sentrysettings[ sentrygun.sentrytype ].modelgood );
                sentrygun placehinton();
            }
            else
            {
                sentrygun setmodel( level.sentrysettings[ sentrygun.sentrytype ].modelbad );
                sentrygun cannotplacehinton();
            }
        }
        
        var_eb60db22eb898e2c = sentrygun.canbeplaced;
        wait 0.05;
    }
}

// Namespace autosentry
// Params 2
// Checksum 0x54ec3cd6, Offset: 0x34b2
// Size: 0x7b
function sentry_oncarrierdeathoremp( carrier, cancelondeath )
{
    self endon( #"placed" );
    self endon( #"death" );
    carrier endon( #"disconnect" );
    carrier utility::waittill_any( "death", "emp_applied" );
    
    if ( self.canbeplaced && !cancelondeath )
    {
        sentry_setplaced( self.pickupenabled );
        return;
    }
    
    sentry_setcancelled( 0 );
}

// Namespace autosentry
// Params 1
// Checksum 0xe0f1f17a, Offset: 0x3535
// Size: 0x38
function sentry_oncarrierdisconnect( carrier )
{
    self endon( #"placed" );
    self endon( #"death" );
    carrier waittill( #"disconnect" );
    self delete();
}

// Namespace autosentry
// Params 1
// Checksum 0xf0a85841, Offset: 0x3575
// Size: 0x3d
function sentry_oncarrierchangedteam( carrier )
{
    self endon( #"placed" );
    self endon( #"death" );
    carrier utility::waittill_any( "joined_team", "joined_spectators" );
    self delete();
}

// Namespace autosentry
// Params 1
// Checksum 0x69450a6d, Offset: 0x35ba
// Size: 0x37
function sentry_ongameended( carrier )
{
    self endon( #"placed" );
    self endon( #"death" );
    level waittill( #"game_ended" );
    self delete();
}

// Namespace autosentry
// Params 1
// Checksum 0x1f869b79, Offset: 0x35f9
// Size: 0x274
function sentry_setactive( enablepickup )
{
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
    
    if ( enablepickup )
    {
        self setcursorhint( "HINT_NOICON" );
        self sethintstring( level.sentrysettings[ self.sentrytype ].hintstring );
        self makeusable();
    }
    
    foreach ( player in level.players )
    {
        switch ( self.sentrytype )
        {
            case #"hash_8a144557bd5ac067":
            case #"hash_8f3bfcef6a436f5b":
            case #"hash_8f3bfdef6a4370ee":
            case #"hash_8f3bfeef6a437281":
            case #"hash_8f3bffef6a437414":
            case #"hash_9cc148005b0186d6":
            case #"hash_9cc14a005b0189fc":
            case #"hash_9cc14b005b018b8f":
            case #"hash_9cc14d005b018eb5":
            case #"hash_ce05fbb198b1f5dd":
                if ( enablepickup )
                {
                    self enableplayeruse( player );
                }
                
                break;
            default:
                killstreak::addtoactivekillstreaklist( self.sentrytype, "Killstreak_Ground", self.owner, 0, 1, 70, "carried" );
                
                if ( player == self.owner && enablepickup )
                {
                    self enableplayeruse( player );
                }
                else
                {
                    self disableplayeruse( player );
                }
                
                break;
        }
    }
    
    splashname = level.sentrysettings[ self.sentrytype ].teamsplash;
    
    if ( self.shouldsplash )
    {
        level thread hud_util::teamplayercardsplash( splashname, self.owner );
        self.shouldsplash = 0;
    }
    
    if ( self.sentrytype == "sam_turret" )
    {
        thread sam_attacktargets();
    }
    
    if ( self.sentrytype == "scramble_turret" )
    {
        thread scrambleturretattacktargets();
    }
    
    if ( self.sentrytype == "sentry_shock" )
    {
        thread sentryshocktargets();
    }
    
    emp_debuff::allow_emp( 1 );
}

// Namespace autosentry
// Params 0
// Checksum 0x8d669fd0, Offset: 0x3875
// Size: 0x4e
function sentry_setinactive()
{
    if ( self.sentrytype == "manual_turret" )
    {
        self sethintstring( "" );
        self makeunusable();
    }
    
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
    self makeunusable();
}

// Namespace autosentry
// Params 0
// Checksum 0x474b64a9, Offset: 0x38cb
// Size: 0x8
function sentry_makesolid()
{
    self solid();
}

// Namespace autosentry
// Params 0
// Checksum 0xc9047651, Offset: 0x38db
// Size: 0x8
function sentry_makenotsolid()
{
    self notsolid();
}

// Namespace autosentry
// Params 1
// Checksum 0xdfec48e1, Offset: 0x38eb
// Size: 0x35, Type: bool
function isfriendlytosentry( sentrygun )
{
    if ( level.teambased && self.team == sentrygun.team )
    {
        return true;
    }
    
    return false;
}

// Namespace autosentry
// Params 0
// Checksum 0x956affdf, Offset: 0x3929
// Size: 0x73
function sentry_attacktargets()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.momentum = 0;
    self.heatlevel = 0;
    self.overheated = 0;
    thread sentry_heatmonitor();
    
    for ( ;; )
    {
        utility::waittill_any( "turretstatechange", "cooled" );
        
        if ( self isfiringturret() )
        {
            thread sentry_burstfirestart();
            continue;
        }
        
        sentry_spindown();
        thread sentry_burstfirestop();
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xd18f3b37, Offset: 0x39a4
// Size: 0x10d
function sentry_timeout()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    lifespan = level.sentrysettings[ self.sentrytype ].timeout;
    
    /#
        if ( !isdefined( lifespan ) )
        {
            lifespan = getdvarfloat( @"scr_sentry_timeout" );
        }
    #/
    
    if ( lifespan == 0 )
    {
        return;
    }
    
    while ( lifespan )
    {
        wait 1;
        hostmigration::waittillhostmigrationdone();
        
        if ( !isdefined( self.carriedby ) )
        {
            lifespan = max( 0, lifespan - 1 );
        }
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( isdefined( level.sentrysettings[ self.sentrytype ].votimeout ) )
        {
            self.owner killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo, level.sentrysettings[ self.sentrytype ].votimeout, #"leave" );
        }
    }
    
    self notify( #"death" );
}

// Namespace autosentry
// Params 0
// Checksum 0x64d1099a, Offset: 0x3ab9
// Size: 0x3b
function sentry_targetlocksound()
{
    self endon( #"death" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

// Namespace autosentry
// Params 0
// Checksum 0x6cc2d00d, Offset: 0x3afc
// Size: 0x54
function sentry_spinup()
{
    thread sentry_targetlocksound();
    
    while ( self.momentum < level.sentrysettings[ self.sentrytype ].spinuptime )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x3e0ab880, Offset: 0x3b58
// Size: 0xc
function sentry_spindown()
{
    self.momentum = 0;
}

// Namespace autosentry
// Params 0
// Checksum 0x9f153395, Offset: 0x3b6c
// Size: 0x118
function sentry_laser_burstfirestart()
{
    self endon( #"death" );
    self endon( #"stop_shooting" );
    level endon( #"game_ended" );
    sentry_spinup();
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    minshots = level.sentrysettings[ self.sentrytype ].burstmin;
    
    if ( isdefined( self.supportturret ) && self.supportturret )
    {
        firetime = 0.05;
        numshots = 50;
    }
    else
    {
        firetime = 0.5 / ( self.listoffoundturrets.size + 1 );
        numshots = minshots;
    }
    
    for ( i = 0; i < numshots ; i++ )
    {
        turrettarget = self getturrettarget( 1 );
        
        if ( !isdefined( turrettarget ) )
        {
            break;
        }
        
        self shootturret();
        wait firetime;
    }
    
    self notify( #"donefiring" );
    self cleartargetentity();
}

// Namespace autosentry
// Params 0
// Checksum 0x8f448608, Offset: 0x3c8c
// Size: 0x166
function sentry_burstfirestart()
{
    self endon( #"death" );
    self endon( #"stop_shooting" );
    level endon( #"game_ended" );
    sentry_spinup();
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    minshots = level.sentrysettings[ self.sentrytype ].burstmin;
    maxshots = level.sentrysettings[ self.sentrytype ].burstmax;
    minpause = level.sentrysettings[ self.sentrytype ].pausemin;
    maxpause = level.sentrysettings[ self.sentrytype ].pausemax;
    
    for ( ;; )
    {
        numshots = randomintrange( minshots, maxshots + 1 );
        
        for ( i = 0; i < numshots && !self.overheated ; i++ )
        {
            self shootturret();
            self notify( #"bullet_fired" );
            self.heatlevel += firetime;
            wait firetime;
        }
        
        wait randomfloatrange( minpause, maxpause );
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xb3c53d8d, Offset: 0x3dfa
// Size: 0xe
function sentry_burstfirestop()
{
    self notify( #"stop_shooting" );
}

// Namespace autosentry
// Params 1
// Checksum 0x726346c9, Offset: 0x3e10
// Size: 0xa6
function turret_shotmonitor( turret )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    turret endon( #"death" );
    turret endon( #"player_dismount" );
    firetime = weaponfiretime( level.sentrysettings[ turret.sentrytype ].weaponinfo );
    
    for ( ;; )
    {
        turret waittill( #"turret_fire" );
        turret.heatlevel += firetime;
        turret.cooldownwaittime = firetime;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x1945f79e, Offset: 0x3ebe
// Size: 0x1b5
function sentry_heatmonitor()
{
    self endon( #"death" );
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    var_adb688986d174fb2 = 0;
    overheattime = level.sentrysettings[ self.sentrytype ].overheattime;
    overheatcooldown = level.sentrysettings[ self.sentrytype ].cooldowntime;
    
    for ( ;; )
    {
        if ( self.heatlevel != var_adb688986d174fb2 )
        {
            wait firetime;
        }
        else
        {
            self.heatlevel = max( 0, self.heatlevel - 0.05 );
        }
        
        if ( self.heatlevel > overheattime )
        {
            self.overheated = 1;
            thread playheatfx();
            
            switch ( self.sentrytype )
            {
                case #"hash_8a144557bd5ac067":
                case #"hash_8f3bfcef6a436f5b":
                case #"hash_8f3bfdef6a4370ee":
                case #"hash_8f3bfeef6a437281":
                case #"hash_8f3bffef6a437414":
                    playfxontag( utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }
            
            while ( self.heatlevel )
            {
                self.heatlevel = max( 0, self.heatlevel - overheatcooldown );
                wait 0.1;
            }
            
            self.overheated = 0;
            self notify( #"not_overheated" );
        }
        
        var_adb688986d174fb2 = self.heatlevel;
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xba5ab7f9, Offset: 0x407b
// Size: 0xd6
function turret_heatmonitor()
{
    self endon( #"death" );
    overheattime = level.sentrysettings[ self.sentrytype ].overheattime;
    
    while ( true )
    {
        if ( self.heatlevel > overheattime )
        {
            self.overheated = 1;
            thread playheatfx();
            
            switch ( self.sentrytype )
            {
                case #"hash_ce05fbb198b1f5dd":
                    playfxontag( utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }
            
            while ( self.heatlevel )
            {
                wait 0.1;
            }
            
            self.overheated = 0;
            self notify( #"not_overheated" );
        }
        
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x583bb8ca, Offset: 0x4159
// Size: 0x75
function turret_coolmonitor()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
            {
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            }
            else
            {
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x95702163, Offset: 0x41d6
// Size: 0x75
function playheatfx()
{
    self endon( #"death" );
    self endon( #"not_overheated" );
    level endon( #"game_ended" );
    self notify( #"hash_a49d775cc1653783" );
    self endon( #"hash_a49d775cc1653783" );
    
    for ( ;; )
    {
        playfxontag( utility::getfx( "sentry_overheat_mp" ), self, "tag_flash" );
        wait level.sentrysettings[ self.sentrytype ].fxtime;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xb76f4bf9, Offset: 0x4253
// Size: 0x45
function playsmokefx()
{
    self endon( #"death" );
    self endon( #"not_overheated" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        playfxontag( utility::getfx( "sentry_smoke_mp" ), self, "tag_aim" );
        wait 0.4;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x7637e6dc, Offset: 0x42a0
// Size: 0x3c
function sentry_beepsounds()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        wait 3;
        
        if ( !isdefined( self.carriedby ) )
        {
            self playsound( "sentry_gun_beep" );
        }
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xb90027ed, Offset: 0x42e4
// Size: 0x5e
function sam_attacktargets()
{
    self endon( #"carried" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.samtargetent = undefined;
    self.sammissilegroups = [];
    
    while ( true )
    {
        self.samtargetent = sam_acquiretarget();
        sam_fireontarget();
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xf41222c1, Offset: 0x434a
// Size: 0x7f5
function sam_acquiretarget()
{
    eyeline = self gettagorigin( "tag_laser" );
    
    if ( !isdefined( self.samtargetent ) )
    {
        if ( level.teambased )
        {
            entitylist = [];
            enemyteams = team_utility::getenemyteams( self.team );
            
            if ( level.var_f3d1cde89907a07a )
            {
                foreach ( team in enemyteams )
                {
                    foreach ( squadindex, squadarray in level.squaddata[ team ] )
                    {
                        index = squadindex;
                        
                        foreach ( model in level.uavmodels[ index ] )
                        {
                            entitylist[ entitylist.size ] = model;
                        }
                    }
                }
            }
            else
            {
                foreach ( entry in enemyteams )
                {
                    foreach ( uav in level.uavmodels[ entry ] )
                    {
                        entitylist[ entitylist.size ] = uav;
                    }
                }
            }
            
            foreach ( uav in entitylist )
            {
                if ( isdefined( uav.isleaving ) && uav.isleaving )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self ) )
                {
                    return uav;
                }
            }
            
            foreach ( lb in level.littlebirds )
            {
                if ( lb.team == self.team )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, lb.origin, 0, self ) )
                {
                    return lb;
                }
            }
            
            foreach ( heli in level.helis )
            {
                if ( heli.team == self.team )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, heli.origin, 0, self ) )
                {
                    return heli;
                }
            }
            
            foreach ( uav in level.remote_uav )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( uav.team == self.team )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self, uav ) )
                {
                    return uav;
                }
            }
        }
        else
        {
            foreach ( uav in level.uavmodels )
            {
                if ( isdefined( uav.isleaving ) && uav.isleaving )
                {
                    continue;
                }
                
                if ( uav.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self ) )
                {
                    return uav;
                }
            }
            
            foreach ( lb in level.littlebirds )
            {
                if ( lb.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, lb.origin, 0, self ) )
                {
                    return lb;
                }
            }
            
            foreach ( heli in level.helis )
            {
                if ( heli.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, heli.origin, 0, self ) )
                {
                    return heli;
                }
            }
            
            foreach ( uav in level.remote_uav )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( uav.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self, uav ) )
                {
                    return uav;
                }
            }
        }
        
        self cleartargetentity();
        return;
    }
    
    if ( !sighttracepassed( eyeline, self.samtargetent.origin, 0, self ) )
    {
        self cleartargetentity();
        return;
    }
    
    return self.samtargetent;
}

// Namespace autosentry
// Params 0
// Checksum 0x3e859da2, Offset: 0x4b47
// Size: 0x26c
function sam_fireontarget()
{
    if ( isdefined( self.samtargetent ) )
    {
        if ( self.samtargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.samtargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        self settargetentity( self.samtargetent );
        self waittill( #"turret_on_target" );
        
        if ( !isdefined( self.samtargetent ) )
        {
            return;
        }
        
        if ( !self.laser_on )
        {
            thread sam_watchlaser();
            thread sam_watchcrashing();
            thread sam_watchleaving();
            thread sam_watchlineofsight();
        }
        
        wait 2;
        
        if ( !isdefined( self.samtargetent ) )
        {
            return;
        }
        
        if ( self.samtargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.samtargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        rocketoffsets = [];
        rocketoffsets[ 0 ] = self gettagorigin( "tag_le_missile1" );
        rocketoffsets[ 1 ] = self gettagorigin( "tag_le_missile2" );
        rocketoffsets[ 2 ] = self gettagorigin( "tag_ri_missile1" );
        rocketoffsets[ 3 ] = self gettagorigin( "tag_ri_missile2" );
        missilegroup = self.sammissilegroups.size;
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( !isdefined( self.samtargetent ) )
            {
                return;
            }
            
            if ( isdefined( self.carriedby ) )
            {
                return;
            }
            
            self shootturret();
            rocket = weapon_utility::_magicbullet( makeweapon( "sam_projectile_mp" ), rocketoffsets[ i ], self.samtargetent.origin, self.owner );
            rocket missile_settargetent( self.samtargetent );
            rocket missile_setflightmodedirect();
            rocket.samturret = self;
            rocket.sammissilegroup = missilegroup;
            self.sammissilegroups[ missilegroup ][ i ] = rocket;
            level notify( #"sam_missile_fired", self.owner, rocket, self.samtargetent );
            
            if ( i == 3 )
            {
                break;
            }
            
            wait 0.25;
        }
        
        level notify( #"sam_fired", self.owner, self.sammissilegroups[ missilegroup ], self.samtargetent );
        wait 3;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x4405a743, Offset: 0x4dbb
// Size: 0xa1
function sam_watchlineofsight()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( isdefined( self.samtargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.samtargetent )
    {
        eyeline = self gettagorigin( "tag_laser" );
        
        if ( !sighttracepassed( eyeline, self.samtargetent.origin, 0, self, self.samtargetent ) )
        {
            self cleartargetentity();
            self.samtargetent = undefined;
            break;
        }
        
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x21f0ab7b, Offset: 0x4e64
// Size: 0x60
function sam_watchlaser()
{
    self endon( #"death" );
    self laseron();
    self.laser_on = 1;
    
    while ( isdefined( self.samtargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.samtargetent )
    {
        waitframe();
    }
    
    self laseroff();
    self.laser_on = 0;
}

// Namespace autosentry
// Params 0
// Checksum 0x10f4c357, Offset: 0x4ecc
// Size: 0x60
function sam_watchcrashing()
{
    self endon( #"death" );
    self.samtargetent endon( #"death" );
    
    if ( !isdefined( self.samtargetent.helitype ) )
    {
        return;
    }
    
    self.samtargetent waittill( #"crashing" );
    self cleartargetentity();
    self.samtargetent = undefined;
}

// Namespace autosentry
// Params 0
// Checksum 0xea7b9ad3, Offset: 0x4f34
// Size: 0x7c
function sam_watchleaving()
{
    self endon( #"death" );
    self.samtargetent endon( #"death" );
    
    if ( !isdefined( self.samtargetent.model ) )
    {
        return;
    }
    
    if ( self.samtargetent.model == "vehicle_uav_static_mp" )
    {
        self.samtargetent waittill( #"leaving" );
        self cleartargetentity();
        self.samtargetent = undefined;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x67c63f2c, Offset: 0x4fb8
// Size: 0x90
function scrambleturretattacktargets()
{
    self endon( #"carried" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.scrambletargetent = undefined;
    
    while ( true )
    {
        self.scrambletargetent = scramble_acquiretarget();
        
        if ( isdefined( self.scrambletargetent ) && isdefined( self.scrambletargetent.scrambled ) && !self.scrambletargetent.scrambled )
        {
            scrambletarget();
        }
        
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x24de3c5d, Offset: 0x5050
// Size: 0x8
function scramble_acquiretarget()
{
    return sam_acquiretarget();
}

// Namespace autosentry
// Params 0
// Checksum 0xa36d3016, Offset: 0x5061
// Size: 0x12e
function scrambletarget()
{
    if ( isdefined( self.scrambletargetent ) )
    {
        if ( self.scrambletargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.scrambletargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        self settargetentity( self.scrambletargetent );
        self waittill( #"turret_on_target" );
        
        if ( !isdefined( self.scrambletargetent ) )
        {
            return;
        }
        
        if ( !self.laser_on )
        {
            thread scramble_watchlaser();
            thread scramble_watchcrashing();
            thread scramble_watchleaving();
            thread scramble_watchlineofsight();
        }
        
        wait 2;
        
        if ( !isdefined( self.scrambletargetent ) )
        {
            return;
        }
        
        if ( self.scrambletargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.scrambletargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        if ( !isdefined( self.scrambletargetent ) )
        {
            return;
        }
        
        if ( isdefined( self.carriedby ) )
        {
            return;
        }
        
        self shootturret();
        thread setscrambled();
        self notify( #"death" );
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x16be7475, Offset: 0x5197
// Size: 0xaa
function setscrambled()
{
    scrambledtarget = self.scrambletargetent;
    scrambledtarget notify( #"scramble_fired", self.owner );
    scrambledtarget endon( #"scramble_fired" );
    scrambledtarget endon( #"death" );
    scrambledtarget thread helicopter::heli_targeting();
    scrambledtarget.scrambled = 1;
    scrambledtarget.secondowner = self.owner;
    scrambledtarget notify( #"hash_614ecaf70104d6cd" );
    wait 30;
    
    if ( isdefined( scrambledtarget ) )
    {
        scrambledtarget.scrambled = 0;
        scrambledtarget.secondowner = undefined;
        scrambledtarget thread helicopter::heli_targeting();
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xb8578e2f, Offset: 0x5249
// Size: 0xa1
function scramble_watchlineofsight()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( isdefined( self.scrambletargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.scrambletargetent )
    {
        eyeline = self gettagorigin( "tag_laser" );
        
        if ( !sighttracepassed( eyeline, self.scrambletargetent.origin, 0, self, self.scrambletargetent ) )
        {
            self cleartargetentity();
            self.scrambletargetent = undefined;
            break;
        }
        
        wait 0.05;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xe2d65b2e, Offset: 0x52f2
// Size: 0x65
function scramble_watchlaser()
{
    self endon( #"death" );
    self laseron();
    self.laser_on = 1;
    
    while ( isdefined( self.scrambletargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.scrambletargetent )
    {
        wait 0.05;
    }
    
    self laseroff();
    self.laser_on = 0;
}

// Namespace autosentry
// Params 0
// Checksum 0x406dd34e, Offset: 0x535f
// Size: 0x60
function scramble_watchcrashing()
{
    self endon( #"death" );
    self.scrambletargetent endon( #"death" );
    
    if ( !isdefined( self.scrambletargetent.helitype ) )
    {
        return;
    }
    
    self.scrambletargetent waittill( #"crashing" );
    self cleartargetentity();
    self.scrambletargetent = undefined;
}

// Namespace autosentry
// Params 0
// Checksum 0x5aae37d1, Offset: 0x53c7
// Size: 0x7c
function scramble_watchleaving()
{
    self endon( #"death" );
    self.scrambletargetent endon( #"death" );
    
    if ( !isdefined( self.scrambletargetent.model ) )
    {
        return;
    }
    
    if ( self.scrambletargetent.model == "vehicle_uav_static_mp" )
    {
        self.scrambletargetent waittill( #"leaving" );
        self cleartargetentity();
        self.scrambletargetent = undefined;
    }
}

// Namespace autosentry
// Params 0
// Checksum 0xe2fc2bf5, Offset: 0x544b
// Size: 0xd0
function sentryshocktargets()
{
    self endon( #"death" );
    self endon( #"carried" );
    level endon( #"game_ended" );
    thread watchsentryshockpickup();
    self.airlookatent = utility::spawn_tag_origin( self.origin, self.angles );
    self.airlookatent linkto( self, "tag_flash" );
    
    while ( true )
    {
        result = utility::waittill_any_timeout( 1, "turret_on_target" );
        
        if ( result == "timeout" )
        {
            continue;
        }
        
        self.sentryshocktargetent = self getturrettarget( 1 );
        
        if ( player::isreallyalive( self.sentryshocktargetent ) )
        {
            thread shocktarget( self.sentryshocktargetent );
            self waittill( #"done_firing" );
        }
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x3d9b128, Offset: 0x5523
// Size: 0x41d
function searchforshocksentryairtarget()
{
    if ( isdefined( level.uavmodels ) )
    {
        if ( level.teambased )
        {
            enemyteams = team_utility::getenemyteams( self.owner.team );
            
            if ( level.var_f3d1cde89907a07a )
            {
                foreach ( team in enemyteams )
                {
                    foreach ( squadindex, squadarray in level.squaddata[ team ] )
                    {
                        index = squadindex;
                        
                        foreach ( uav in level.uavmodels[ index ] )
                        {
                            if ( targetvisibleinfront( uav ) )
                            {
                                return uav;
                            }
                        }
                    }
                }
            }
            else
            {
                foreach ( entry in enemyteams )
                {
                    foreach ( uav in level.uavmodels[ index ] )
                    {
                        if ( targetvisibleinfront( uav ) )
                        {
                            return uav;
                        }
                    }
                }
            }
        }
        else
        {
            foreach ( uav in level.uavmodels )
            {
                if ( uav.owner == self.owner )
                {
                    continue;
                }
                
                if ( targetvisibleinfront( uav ) )
                {
                    return uav;
                }
            }
        }
    }
    
    if ( isdefined( level.helis ) )
    {
        foreach ( heli in level.helis )
        {
            if ( heli.streakname != "jackal" )
            {
                continue;
            }
            
            if ( level.teambased && heli.team == self.owner.team )
            {
                continue;
            }
            
            if ( !level.teambased && heli.owner == self.owner )
            {
                continue;
            }
            
            if ( targetvisibleinfront( heli ) )
            {
                return heli;
            }
        }
    }
}

// Namespace autosentry
// Params 1
// Checksum 0x3141ef4, Offset: 0x5948
// Size: 0x108
function targetvisibleinfront( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    infront = 0;
    var_3fc1a8d8aff344aa = self gettagorigin( "tag_flash" );
    targetpos = target.origin;
    looktargetdirection = vectornormalize( targetpos - var_3fc1a8d8aff344aa );
    attackerforward = anglestoforward( self.angles );
    ignorelist = [ self, self.owner, target ];
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item" ] );
    
    if ( trace::ray_trace_passed( var_3fc1a8d8aff344aa, targetpos, ignorelist, contents ) && vectordot( attackerforward, looktargetdirection ) > 0.25 && distance2dsquared( var_3fc1a8d8aff344aa, targetpos ) > 10000 )
    {
        infront = 1;
    }
    
    return infront;
}

// Namespace autosentry
// Params 2
// Checksum 0x224b7bb2, Offset: 0x5a59
// Size: 0x22c
function shootshocksentrysamtarget( target, fauxtarget )
{
    self endon( #"death" );
    self endon( #"carried" );
    level endon( #"game_ended" );
    self setmode( "manual" );
    thread setshocksamtargetent( target, fauxtarget );
    self.sentryshocksamtarget = undefined;
    self waittill( #"turret_on_target" );
    thread marktargetlaser( target );
    self playsound( "shock_sentry_charge_up" );
    playfxontag( utility::getfx( "sentry_shock_charge" ), self, "tag_laser" );
    sentry_spinup();
    stopfxontag( utility::getfx( "sentry_shock_charge" ), self, "tag_laser" );
    self notify( #"start_firing" );
    self setscriptablepartstate( "coil", "active" );
    firedelay = 2;
    firenum = 1;
    
    while ( isdefined( target ) && targetvisibleinfront( target ) )
    {
        var_3fc1a8d8aff344aa = self gettagorigin( "tag_flash" );
        seekingmissile = weapon_utility::_magicbullet( makeweapon( "sentry_shock_missile_mp" ), var_3fc1a8d8aff344aa, target.origin, self.owner );
        seekingmissile missile_settargetent( target );
        seekingmissile missile_setflightmodedirect();
        seekingmissile.killcament = self.killcament;
        seekingmissile.streakinfo = self.streakinfo;
        self setscriptablepartstate( "muzzle", "fire" + firenum, 0 );
        level notify( #"hash_2b53bb53f231341a", self.owner, seekingmissile, target );
        firenum++;
        
        if ( firenum > 2 )
        {
            firenum = 1;
        }
        
        wait firedelay;
    }
    
    self setscriptablepartstate( "muzzle", "neutral", 0 );
    self notify( #"sentry_lost_target" );
    fauxtarget unlink();
    fauxtarget.origin = self gettagorigin( "tag_flash" );
    fauxtarget linkto( self, "tag_flash" );
    self setmode( "sentry" );
    self cleartargetentity();
    self setscriptablepartstate( "coil", "idle" );
    sentry_spindown();
    self notify( #"done_firing" );
}

// Namespace autosentry
// Params 0
// Checksum 0x7bda4f56, Offset: 0x5c8d
// Size: 0x58
function sentry_handlemanualuse()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        while ( player isusingturret() )
        {
            if ( player attackbuttonpressed() )
            {
                self shootturret();
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace autosentry
// Params 1
// Checksum 0x28ac8819, Offset: 0x5ced
// Size: 0x162
function sentry_handlealteratepickup( enablepickup )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self.owner notifyonplayercommand( "maunal_sentry_pickup", "+weapnext" );
    self.manualpickuptrigger = spawn( "trigger_radius", self.origin, 0, 128, 128 );
    self.manualpickuptrigger enablelinkto();
    self.manualpickuptrigger linkto( self, "tag_origin" );
    
    while ( true )
    {
        if ( isdefined( self.carriedby ) )
        {
            waitframe();
        }
        
        if ( !self.owner istouching( self.manualpickuptrigger ) )
        {
            waitframe();
        }
        
        self.owner waittill( #"maunal_sentry_pickup" );
        assert( !isdefined( self.carriedby ) );
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        self.owner.placedsentries[ self.sentrytype ] = arrayremove( self.owner.placedsentries[ self.sentrytype ], self );
        self.owner setcarryingsentry( self, 0, enablepickup );
    }
}

/#

    // Namespace autosentry
    // Params 0
    // Checksum 0x3a5af801, Offset: 0x5e57
    // Size: 0x3a, Type: dev
    function function_6667363d4f84cad1()
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 50, ( 0, 1, 0 ), 0, 20 );
            waitframe();
        }
    }

#/

// Namespace autosentry
// Params 2
// Checksum 0xb844ee78, Offset: 0x5e99
// Size: 0xcf
function setshocksamtargetent( target, fauxtarget )
{
    self endon( #"death" );
    self endon( #"carried" );
    self endon( #"sentry_lost_target" );
    target endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        startpoint = self gettagorigin( "tag_aim" );
        endpoint = target.origin;
        targetdirection = vectornormalize( endpoint - startpoint );
        var_122d82bf6d4c55eb = startpoint + targetdirection * 500;
        fauxtarget unlink();
        fauxtarget.origin = var_122d82bf6d4c55eb;
        fauxtarget linkto( self );
        self settargetentity( fauxtarget );
        waitframe();
    }
}

// Namespace autosentry
// Params 0
// Checksum 0x1953c141, Offset: 0x5f70
// Size: 0x57
function watchsentryshockpickup()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"carried" );
        
        if ( isdefined( self.sentryshocktargetent ) )
        {
            self.sentryshocktargetent = undefined;
        }
        
        if ( isdefined( self.sentryshocksamtarget ) )
        {
            self.sentryshocksamtarget = undefined;
        }
        
        self cleartargetentity();
    }
}

// Namespace autosentry
// Params 1
// Checksum 0x96f33864, Offset: 0x5fcf
// Size: 0xfe
function shocktarget( target )
{
    self endon( #"death" );
    self endon( #"carried" );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    thread marktargetlaser( target );
    self playsound( "shock_sentry_charge_up" );
    sentry_spinup();
    self notify( #"start_firing" );
    level thread battlechatter_mp::saytoself( target, "plr_killstreak_target" );
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    
    while ( isdefined( self getturrettarget( 1 ) ) && player::isreallyalive( target ) && self getturrettarget( 1 ) == target && !outline::outlineoccluded( self gettagorigin( "tag_flash" ), target geteye() ) )
    {
        self shootturret();
        wait firetime;
    }
    
    self.sentryshocktargetent = undefined;
    self cleartargetentity();
    sentry_spindown();
    self notify( #"done_firing" );
}

// Namespace autosentry
// Params 1
// Checksum 0xfc953310, Offset: 0x60d5
// Size: 0x106
function missileburstfire( target )
{
    self endon( #"death" );
    self endon( #"carried" );
    missilecount = 3;
    firenum = 1;
    
    while ( missilecount > 0 )
    {
        if ( !isdefined( target ) )
        {
            return;
        }
        
        if ( !isdefined( self.owner ) )
        {
            return;
        }
        
        sentrymissile = weapon_utility::_magicbullet( makeweapon( "sentry_shock_grenade_mp" ), self gettagorigin( "tag_flash" ), target.origin, self.owner );
        sentrymissile missile_settargetent( target, gettargetoffset( target ) );
        sentrymissile.killcament = self.killcament;
        sentrymissile.streakinfo = self.streakinfo;
        self setscriptablepartstate( "muzzle", "fire" + firenum, 0 );
        firenum++;
        
        if ( firenum > 2 )
        {
            firenum = 1;
        }
        
        sentrymissile thread watchtargetchange( target );
        missilecount--;
        wait 0.2;
    }
}

// Namespace autosentry
// Params 1
// Checksum 0x636cbdf2, Offset: 0x61e3
// Size: 0x9b
function gettargetoffset( target )
{
    heightoffset = ( 0, 0, 40 );
    owner_stance = target getstance();
    
    switch ( owner_stance )
    {
        case #"hash_c6775c88e38f7803":
            heightoffset = ( 0, 0, 40 );
            break;
        case #"hash_3fed0cbd303639eb":
            heightoffset = ( 0, 0, 20 );
            break;
        case #"hash_d91940431ed7c605":
            heightoffset = ( 0, 0, 5 );
            break;
    }
    
    return heightoffset;
}

// Namespace autosentry
// Params 1
// Checksum 0x32a4386e, Offset: 0x6287
// Size: 0x49
function watchtargetchange( target )
{
    self endon( #"death" );
    target endon( #"disconnect" );
    
    while ( true )
    {
        if ( !player::isreallyalive( target ) )
        {
            self missile_settargetent( target getcorpseentity() );
            break;
        }
        
        waitframe();
    }
}

// Namespace autosentry
// Params 1
// Checksum 0xb641793f, Offset: 0x62d8
// Size: 0x4a
function marktargetlaser( target )
{
    self endon( #"death" );
    self laseron();
    self.laser_on = 1;
    utility::waittill_any( "done_firing", "carried" );
    self laseroff();
    self.laser_on = 0;
}

// Namespace autosentry
// Params 1
// Checksum 0x84af7f54, Offset: 0x632a
// Size: 0x204
function watchshockdamage( target )
{
    self endon( #"death" );
    self endon( #"done_firing" );
    
    while ( true )
    {
        self waittill( #"victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime );
        
        if ( victim == target )
        {
            damageradius = 100;
            var_1b092957892983f2 = player::getplayersinradiusview( vpoint, damageradius, victim.team, self.owner );
            playfx( utility::getfx( "sentry_shock_explosion" ), vpoint );
            
            if ( var_1b092957892983f2.size > 0 )
            {
                foreach ( info in var_1b092957892983f2 )
                {
                    if ( info.player != victim )
                    {
                        info.player dodamage( 5, vpoint, self.owner, self, smeansofdeath, objweapon );
                        var_925158f93fe17929 = undefined;
                        randomindex = undefined;
                        
                        if ( info.visiblelocations.size > 1 )
                        {
                            randomindex = randomint( info.visiblelocations.size );
                            var_925158f93fe17929 = info.visiblelocations[ randomindex ];
                        }
                        else
                        {
                            var_925158f93fe17929 = info.visiblelocations[ 0 ];
                        }
                        
                        playfxbetweenpoints( utility::getfx( "sentry_shock_arc" ), vpoint, vectortoangles( var_925158f93fe17929 - vpoint ), var_925158f93fe17929 );
                    }
                }
            }
        }
    }
}

// Namespace autosentry
// Params 1
// Checksum 0x609d5bd7, Offset: 0x6536
// Size: 0x40
function allowweaponsforsentry( allow )
{
    if ( allow )
    {
        val::reset_all( "sentry_weapons" );
        thread supers_mp::unstowsuperweapon();
        return;
    }
    
    thread supers_mp::allowsuperweaponstow();
    val::set( "sentry_weapons", "weapon", 0 );
}

// Namespace autosentry
// Params 0
// Checksum 0x3d57cda8, Offset: 0x657e
// Size: 0x54
function placehinton()
{
    sentrytype = self.sentrytype;
    
    if ( sentrytype == "super_trophy" )
    {
        self.owner forceusehinton( &"lua_menu_mp/place_super_trophy" );
        return;
    }
    
    self.owner forceusehinton( &"hash_48822a465cac70f8" );
}

// Namespace autosentry
// Params 0
// Checksum 0x3c3141c9, Offset: 0x65da
// Size: 0x54
function cannotplacehinton()
{
    sentrytype = self.sentrytype;
    
    if ( sentrytype == "super_trophy" )
    {
        self.owner forceusehinton( &"lua_menu_mp/cannot_place_super_trophy" );
        return;
    }
    
    self.owner forceusehinton( &"hash_4a37b1983ea85a3a" );
}

