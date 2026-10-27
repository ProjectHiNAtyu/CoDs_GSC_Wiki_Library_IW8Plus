// scripts\mp\ai_sentry_turret.gsc  (hash_60e3273df6b5f7d1.gscc) (size: 13561 Bytes / 0x34f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52269a5b (1378261595)
// size ...... 13561 (0x34f9)
// includes .. 12  (offset: 0x31f9)
// strings ... 39  (offset: 0x3259)
// dev strs .. 2   (offset: 0x34dd)
// exports ... 30  (offset: 0x2081)
// cseg ...... 0x308 + 0x1d79 (0x2081)
// imports ... 109 (offset: 0x2531)
// animtree1 . 0   (offset: 0x34f9)
// animtree2 . 0   (offset: 0x34f9)
#using scripts\common\ai\stealth\debug;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\hostmigration;
#using scripts\mp\poi;
#using scripts\mp\supers;

#namespace ai_sentry_turret;

// Namespace ai_sentry_turret
// Params 0
// Checksum 0xd8bacc98, Offset: 0x326
// Size: 0x3fc
function init()
{
    if ( getdvarint( @"scr_ai_sentry_turret", 1 ) == 0 )
    {
        return;
    }
    
    level.aisentryturrets = spawnstruct();
    level.aisentryturrets.maxtotal = getdvarint( @"hash_e2a4ecaa972fb581", 15 );
    level.aisentryturrets.var_6803a28acbb52a49 = getdvarint( @"hash_6a8c234b065d124c", 3 );
    level.aisentryturrets.spawnedturrets = [];
    level.aisentryturrets.var_7de9f530917919d3 = &function_6a5739927fc5b471;
    level.sentrysettings[ "ai_sentry_turret" ] = spawnstruct();
    level.sentrysettings[ "ai_sentry_turret" ].health = 999999;
    level.sentrysettings[ "ai_sentry_turret" ].maxhealth = 650;
    level.sentrysettings[ "ai_sentry_turret" ].burstmin = 20;
    level.sentrysettings[ "ai_sentry_turret" ].burstmax = 120;
    level.sentrysettings[ "ai_sentry_turret" ].pausemin = 0.15;
    level.sentrysettings[ "ai_sentry_turret" ].pausemax = 0.35;
    level.sentrysettings[ "ai_sentry_turret" ].lockstrength = 6;
    level.sentrysettings[ "ai_sentry_turret" ].sentrymodeon = "sentry";
    level.sentrysettings[ "ai_sentry_turret" ].var_3f1bd78402246e78 = "manual";
    level.sentrysettings[ "ai_sentry_turret" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 1.5;
    level.sentrysettings[ "ai_sentry_turret" ].overheattime = 8;
    level.sentrysettings[ "ai_sentry_turret" ].cooldowntime = 0.3;
    level.sentrysettings[ "ai_sentry_turret" ].burstmaxtime = 3;
    level.sentrysettings[ "ai_sentry_turret" ].var_d435b063b8c608b2 = 3;
    level.sentrysettings[ "ai_sentry_turret" ].var_cb2d3675356e0b50 = 1;
    level.sentrysettings[ "ai_sentry_turret" ].leftarc = 80;
    level.sentrysettings[ "ai_sentry_turret" ].rightarc = 80;
    level.sentrysettings[ "ai_sentry_turret" ].fxtime = 0.3;
    level.sentrysettings[ "ai_sentry_turret" ].targetrange = 1024;
    level.sentrysettings[ "ai_sentry_turret" ].weaponinfo = "sentry_turret_mp";
    level.sentrysettings[ "ai_sentry_turret" ].playerweaponinfo = "sentry_turret_mp";
    level.sentrysettings[ "ai_sentry_turret" ].modelbaseground = "wpn_rex_lm_mobile_turret";
    level.sentrysettings[ "ai_sentry_turret" ].modeldestroyedground = "wpn_rex_lm_mobile_turret";
    level.sentrysettings[ "ai_sentry_turret" ].bullettag = "tag_flash";
    level.sentrysettings[ "ai_sentry_turret" ].scorepopup = "destroyed_sentry";
    level.sentrysettings[ "ai_sentry_turret" ].lightfxtag = "tag_fx";
    
    if ( poi::poi_issystemactive() )
    {
        utility::callsharedfunc( #"poi", #"subarea_addfeaturearray", "aiSentryTurrets" );
    }
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0xbe8e5e7, Offset: 0x72a
// Size: 0x304
function function_6a5739927fc5b471()
{
    while ( !utility::flag_exist( "create_script_initialized" ) )
    {
        if ( !utility::flag_exist( "poi_initialized" ) )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    while ( !utility::flag_exist( "poi_initialized" ) )
    {
        utility::flag_wait( "create_script_initialized" );
    }
    
    /#
        level thread function_c204142bd904e3ec();
    #/
    
    var_db5395b28af5fc21 = poi::poi_issystemactive();
    level.aisentryturrets.var_8ac28db1d6e83438 = utility::getstructarray( "aiSentryTurret", "script_noteworthy" );
    level.aisentryturrets.var_8ac28db1d6e83438 = arrayrandomize( level.aisentryturrets.var_8ac28db1d6e83438 );
    
    foreach ( spawnloc in level.aisentryturrets.var_8ac28db1d6e83438 )
    {
        spawnapproved = 1;
        
        if ( level.aisentryturrets.spawnedturrets.size >= level.aisentryturrets.maxtotal )
        {
            spawnapproved = 0;
        }
        else if ( var_db5395b28af5fc21 )
        {
            if ( !isdefined( spawnloc.script_poi ) )
            {
                spawnloc.script_poi = poi::poi_findpoioriginisin( spawnloc.origin );
            }
            
            if ( !isdefined( spawnloc.script_poi ) || !poi::poi_ispoiactive( spawnloc.script_poi ) )
            {
                spawnapproved = 0;
            }
            else if ( level.poi[ spawnloc.script_poi ][ "aiSentryTurrets" ].size >= level.aisentryturrets.var_6803a28acbb52a49 )
            {
                spawnapproved = 0;
            }
        }
        
        if ( spawnapproved )
        {
            if ( utility::issharedfuncdefined( #"ai_sentry_turret", #"hash_cca6885723d54980" ) )
            {
                spawnapproved = [[ utility::getsharedfunc( #"ai_sentry_turret", #"hash_cca6885723d54980" ) ]]( spawnloc );
            }
        }
        
        if ( spawnapproved )
        {
            spawnloc.var_c567e9db3aea3999 = 1;
            turret = turret_spawn( spawnloc );
            level.aisentryturrets.spawnedturrets[ level.aisentryturrets.spawnedturrets.size ] = turret;
            
            if ( var_db5395b28af5fc21 && isdefined( spawnloc.script_poi ) )
            {
                level.poi[ spawnloc.script_poi ][ "aiSentryTurrets" ][ level.poi[ spawnloc.script_poi ][ "aiSentryTurrets" ].size ] = turret;
                utility::callsharedfunc( #"poi", #"subarea_registerfeatureelement", spawnloc.script_poi, "aiSentryTurrets", turret );
            }
        }
    }
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0x9b8f497e, Offset: 0xa36
// Size: 0x5f
function function_41b481bcd74d1af0()
{
    wait 10;
    turretstruct = spawnstruct();
    turretstruct.origin = ( 2644, -4359, 10 );
    turretstruct.angles = ( 0, 180, 0 );
    
    if ( isdefined( turretstruct ) )
    {
        turret = turret_spawn( turretstruct );
    }
}

// Namespace ai_sentry_turret
// Params 2
// Checksum 0x126d0ebb, Offset: 0xa9d
// Size: 0x3ef
function turret_spawn( turretstruct, team )
{
    if ( getdvarint( @"scr_ai_sentry_turret", 1 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( team ) )
    {
        team = "team_hundred_ninety_four";
    }
    
    config = level.sentrysettings[ "ai_sentry_turret" ];
    
    if ( !isdefined( turretstruct.angles ) )
    {
        turretstruct.angles = ( 0, 0, 0 );
    }
    
    turretweapon = turretstruct.weaponoverride ?? config.weaponinfo;
    turret = spawnturret( "misc_turret", turretstruct.origin, turretweapon );
    
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    turret.turretstruct = turretstruct;
    turret.angles = turretstruct.angles;
    turret.health = 9999;
    turret.maxhealth = turretstruct.var_dcd10429f4f0d1fc ?? config.maxhealth;
    turret.ammocount = config.ammo;
    turret.timeout = config.timeout;
    turret.momentum = 0;
    turret.heatlevel = 0;
    turret.overheated = 0;
    turret.cooldownwaittime = 0.1;
    turret.sentrytype = "ai_sentry_turret";
    turret.owningteam = team;
    turret.team = team;
    turret setmodel( config.modelbaseground );
    turret setturretteam( turret.owningteam );
    turret setcandamage( 1 );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    turret setautorotationdelay( 0.5 );
    turret maketurretinoperable();
    leftarc = float( turretstruct.leftarc ?? config.leftarc );
    turret.leftarc = leftarc;
    turret setleftarc( leftarc );
    rightarc = float( turretstruct.rightarc ?? config.rightarc );
    turret.rightarc = rightarc;
    turret setrightarc( rightarc );
    turret setbottomarc( 50 );
    turret settoparc( 60 );
    turret setconvergencetime( 1, "pitch" );
    turret setconvergencetime( 1, "yaw" );
    turret setconvergenceheightpercent( 0.9 );
    turret setturretmodechangewait( 0 );
    turret emp_debuff::set_start_emp_callback( &aisentryturret_empstarted );
    turret emp_debuff::set_clear_emp_callback( &aisentryturret_empcleared );
    turret laseron();
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( "weapon_vm_mg_sentry_turret_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &turret_handledeathdamage, &turret_modifydamage, 1 );
    turret thread turret_watchdeath( turret );
    turret thread turret_watchtargeting();
    turret thread function_a99c369d4ea722b1();
    turret thread function_f9a3d2f1b2cd1e4d();
    turret.turreton = 1;
    turret setmode( config.sentrymodeon );
    return turret;
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xe05dcbb8, Offset: 0xe95
// Size: 0x141
function turret_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" )
    {
        explosivedamage = 1;
    }
    
    if ( isdefined( attacker ) )
    {
        guy = attacker.owner ?? attacker;
        
        if ( isplayer( guy ) )
        {
            eventinfo = { #var_ef32324b503188b8:1, #isdestroyedkillstreak:1 };
            guy thread points::doscoreevent( #"kill_ss_sentry_gun", objweapon, undefined, undefined, self, undefined, undefined, undefined, undefined, 0, eventinfo );
        }
        
        if ( !isplayer( self.owner ) )
        {
            callback::callback( #"hash_86d4084ead08d3be", data );
        }
    }
    
    self.var_24954f14e27b448d = 0;
    self.stopfiring = 1;
    self laseroff();
    self notify( #"kill_turret", explosivedamage, 1 );
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0x369e0991, Offset: 0xfde
// Size: 0x25
function turret_modifydamage( data )
{
    damage = data.damage;
    return damage;
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0xa85f2fd8, Offset: 0x100c
// Size: 0x16d
function turret_watchtargeting()
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    config = level.sentrysettings[ self.sentrytype ];
    
    while ( true )
    {
        if ( !self.turreton || self.turretdisabled || self.var_4b7baeb6c421bc04 )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( self.get_best_target_func ) )
        {
            besttarget = [[ self.get_best_target_func ]]();
        }
        else if ( utility::issharedfuncdefined( #"sentry", #"hash_6353a5a5526a09b3" ) )
        {
            besttarget = utility::callsharedfunc( #"sentry", #"hash_6353a5a5526a09b3" );
        }
        else
        {
            besttarget = turret_getbesttarget();
        }
        
        istargetalive = 1;
        
        if ( isdefined( besttarget ) )
        {
            if ( !player::isreallyalive( besttarget ) )
            {
                istargetalive = 0;
            }
            
            if ( istargetalive )
            {
                if ( getdvarint( @"hash_1c1c7aa145afb94d", 0 ) )
                {
                    thread debug_utility::drawline( besttarget.origin, self.origin, 5, ( 0, 0, 1 ) );
                }
                
                if ( isdefined( self.var_b2acf874181ff696 ) )
                {
                    self [[ self.var_b2acf874181ff696 ]]( besttarget );
                }
                else
                {
                    function_a199cbd08c22f28f( besttarget );
                }
                
                hostmigration::waitlongdurationwithpause( config.cooldowntime );
            }
        }
        
        waitframe();
    }
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xcc38498, Offset: 0x1181
// Size: 0xb9
function function_a199cbd08c22f28f( besttarget )
{
    self endon( #"hash_669ce9944631d3cd" );
    config = level.sentrysettings[ self.sentrytype ];
    
    while ( self.turreton && !self.stopfiring && function_e1f225241e3a8c74( besttarget ) )
    {
        self settargetentity( besttarget );
        
        if ( isplayer( besttarget ) )
        {
            pauseinterval = config.var_d435b063b8c608b2;
        }
        else
        {
            pauseinterval = config.var_cb2d3675356e0b50;
        }
        
        function_b1685d4bdad9300f( config.burstmaxtime, besttarget );
        hostmigration::waitlongdurationwithpause( pauseinterval );
        self cleartargetentity();
    }
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0x7a67d7e6, Offset: 0x1242
// Size: 0x159
function turret_getbesttarget()
{
    config = level.sentrysettings[ self.sentrytype ];
    targetrange = config.targetrange;
    var_eab089682021fc7c = targetrange * targetrange;
    potentialtargetlist = utility::playersinsphere( self.origin, targetrange );
    besttarget = undefined;
    bestrange = undefined;
    
    foreach ( potentialtarget in potentialtargetlist )
    {
        validtarget = turret_isvalidtarget( potentialtarget );
        
        if ( !validtarget )
        {
            continue;
        }
        
        startpoint = self gettagorigin( "tag_flash" );
        endpoint = potentialtarget.origin;
        currentrange = distancesquared( startpoint, endpoint );
        
        if ( currentrange <= var_eab089682021fc7c )
        {
            if ( !isdefined( besttarget ) && !isdefined( bestrange ) || currentrange < bestrange )
            {
                besttarget = potentialtarget;
                bestrange = currentrange;
            }
        }
    }
    
    return besttarget;
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0x7df41e09, Offset: 0x13a4
// Size: 0x5e, Type: bool
function turret_isvalidtarget( potentialtarget )
{
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( potentialtarget ) )
    {
        return false;
    }
    
    if ( potentialtarget.notarget )
    {
        return false;
    }
    
    if ( player::isinlaststand( potentialtarget ) )
    {
        return false;
    }
    
    if ( !function_a5047949bce8d2ce( potentialtarget ) )
    {
        return false;
    }
    
    if ( !turret_canseetarget( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xc16a7cb8, Offset: 0x140b
// Size: 0x97, Type: bool
function function_e1f225241e3a8c74( besttarget )
{
    config = level.sentrysettings[ self.sentrytype ];
    targetrange = config.targetrange;
    
    if ( isdefined( self.var_235f5fa87d26b55c ) )
    {
        targetrange = self.var_235f5fa87d26b55c;
    }
    
    maxrangesq = targetrange * targetrange;
    
    if ( distancesquared( self gettagorigin( "tag_flash" ), besttarget.origin ) > maxrangesq )
    {
        return false;
    }
    
    if ( !turret_isvalidtarget( besttarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0x3ea0bdef, Offset: 0x14ab
// Size: 0x79, Type: bool
function function_a5047949bce8d2ce( potentialtarget )
{
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_cec866141311dfad ) )
    {
        level.var_cec866141311dfad = spawnstruct();
    }
    
    offset = vectornormalize( potentialtarget.origin - self.origin );
    dotproduct = vectordot( anglestoforward( self gettagangles( "tag_flash" ) ), offset );
    return dotproduct > 0.5;
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xb6c1ff7a, Offset: 0x152d
// Size: 0xe9
function turret_canseetarget( potentialtarget )
{
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 1, 1 );
    targetpoints = [ "j_mainroot", "tag_origin", "j_head" ];
    canseetarget = 0;
    
    foreach ( point in targetpoints )
    {
        canseetarget = trace::ray_trace_passed( self gettagorigin( "tag_flash" ), potentialtarget geteye(), self, contentsoverride );
        
        if ( canseetarget )
        {
            break;
        }
    }
    
    return canseetarget;
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xce16a241, Offset: 0x161f
// Size: 0x132
function turret_watchdeath( turret )
{
    turret waittill( #"kill_turret", skipshutdown, wasdestroyed );
    turret.killed = 1;
    turret turret_setturretmodel( "destroyed" );
    turret setturretowner( undefined );
    
    if ( !skipshutdown )
    {
        turret playsound( "sentry_explode_smoke" );
        turret setscriptablepartstate( "shutdown", "on" );
        turret.turreton = 0;
        turret.turretdisabled = 1;
        hostmigration::waitlongdurationwithpause( 2 );
        turret setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        turret setscriptablepartstate( "explode", "violent" );
    }
    
    turret playsound( "mp_equip_destroyed" );
    
    if ( isdefined( turret.colmodel ) )
    {
        turret.colmodel delete();
    }
    
    wait 0.2;
    
    if ( false )
    {
        level thread function_7507f82172efb630( turret.origin, turret.angles, turret.leftarc, turret.rightarc, 4 );
    }
    
    turret delete();
}

// Namespace ai_sentry_turret
// Params 5
// Checksum 0xa7aa9119, Offset: 0x1759
// Size: 0x8d
function function_7507f82172efb630( origin, angles, leftarc, rightarc, var_be63f780b363da7a )
{
    wait var_be63f780b363da7a;
    turretstruct = spawnstruct();
    turretstruct.origin = origin;
    turretstruct.angles = angles;
    turretstruct.leftarc = leftarc;
    turretstruct.rightarc = rightarc;
    turret = turret_spawn( turretstruct );
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xfc7c9dba, Offset: 0x17ee
// Size: 0x73
function turret_setturretmodel( type )
{
    turretmodel = undefined;
    
    if ( type == "destroyed" )
    {
        turretmodel = level.sentrysettings[ self.sentrytype ].modeldestroyedground;
        
        if ( isdefined( self.var_f6c9eb318a6c67de ) )
        {
            turretmodel = self.var_f6c9eb318a6c67de;
        }
    }
    
    assert( isdefined( turretmodel ), "<dev string:x24>" );
    self setmodel( turretmodel );
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0x83e1417f, Offset: 0x1869
// Size: 0x41
function function_a99c369d4ea722b1()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( isdefined( self ) && isdefined( self.colmodel ) )
    {
        self.colmodel delete();
        self delete();
    }
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0x9dbd3f1, Offset: 0x18b2
// Size: 0x3d
function function_d11c6ec328d0cdd6()
{
    self endon( #"death" );
    self endon( #"stop_shooting" );
    self endon( #"kill_turret" );
    level endon( #"game_ended" );
    self playsound( "kls_sentry_alert_target" );
}

// Namespace ai_sentry_turret
// Params 2
// Checksum 0xa096b61c, Offset: 0x18f7
// Size: 0x23b
function function_b1685d4bdad9300f( maxbursttime, potentialtarget )
{
    turret_spinup();
    
    if ( isdefined( self.var_b204ca511f8231dd ) )
    {
        self [[ self.var_b204ca511f8231dd ]]();
    }
    
    config = level.sentrysettings[ self.sentrytype ];
    weaponinfo = self.turretstruct.weaponoverride ?? config.weaponinfo;
    firetime = weaponfiretime( weaponinfo );
    minshots = config.burstmin;
    maxshots = config.burstmax;
    minpause = config.pausemin;
    maxpause = config.pausemax;
    lockstrength = config.lockstrength;
    currenttime = 0;
    
    for ( istargetalive = 1; self.turreton && !self.stopfiring && currenttime < maxbursttime && istargetalive ; istargetalive = player::isreallyalive( potentialtarget ) )
    {
        numshots = randomintrange( minshots, maxshots + 1 );
        
        for ( i = 0; i < numshots && !self.overheated ; i++ )
        {
            if ( !self.turreton || self.stopfiring || potentialtarget supers_mp::function_60dbd7e2f1b02c22() )
            {
                break;
            }
            
            target = self getturrettarget( 1 );
            
            if ( !isdefined( target ) && !isdefined( self.besttarget ) )
            {
                break;
            }
            
            self shootturret( "tag_flash", lockstrength );
            wait firetime;
            currenttime += firetime;
        }
        
        if ( !self.turreton || self.stopfiring )
        {
            break;
        }
        
        if ( potentialtarget supers_mp::function_60dbd7e2f1b02c22() )
        {
            self cleartargetentity();
            break;
        }
        
        randwait = randomfloatrange( minpause, maxpause );
        wait randwait;
        currenttime += randwait;
    }
    
    function_9375ac30cc9925b9();
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0x9a1b1f54, Offset: 0x1b3a
// Size: 0x9
function function_5db58e888c2c2ff5()
{
    function_9375ac30cc9925b9();
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0xccdba922, Offset: 0x1b4b
// Size: 0x6e
function turret_spinup()
{
    config = level.sentrysettings[ self.sentrytype ];
    thread function_d11c6ec328d0cdd6();
    
    while ( self.turreton && self.momentum < config.spinuptime )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0xc14005ac, Offset: 0x1bc1
// Size: 0xc
function function_9375ac30cc9925b9()
{
    self.momentum = 0;
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0xde6e7636, Offset: 0x1bd5
// Size: 0x47
function function_f9a3d2f1b2cd1e4d()
{
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
        
        playsoundatpos( self.origin, "kls_sentry_alert_idle" );
    }
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0x7c82ba52, Offset: 0x1c24
// Size: 0xe6
function turret_watchmodeswitch( turrettrigger )
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    config = level.sentrysettings[ self.sentrytype ];
    self setmode( config.sentrymodeoff );
    self.turreton = 0;
    
    while ( true )
    {
        turrettrigger waittill( #"trigger", player );
        
        if ( !self.turreton )
        {
            self.turreton = 1;
            self setmode( config.sentrymodeon );
            
            while ( isalive( player ) && player istouching( turrettrigger ) )
            {
                waitframe();
            }
            
            self.turreton = 0;
            self setmode( config.sentrymodeoff );
            self notify( #"stop_shooting" );
        }
    }
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xcbb2cea2, Offset: 0x1d12
// Size: 0x9f
function aisentryturret_empstarted( data )
{
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_sentry_gun" );
        }
        
        if ( utility::issharedfuncdefined( #"sentry_gun", #"empstarted" ) )
        {
            self [[ utility::getsharedfunc( #"sentry_gun", #"empstarted" ) ]]();
        }
    }
    
    aisentryturret_empupdate();
}

// Namespace ai_sentry_turret
// Params 1
// Checksum 0xfd64e0c5, Offset: 0x1db9
// Size: 0x50
function aisentryturret_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"sentry_gun", #"empstarted" ) )
    {
        self [[ utility::getsharedfunc( #"sentry_gun", #"empcleared" ) ]]();
    }
    
    aisentryturret_empupdate();
}

// Namespace ai_sentry_turret
// Params 0
// Checksum 0x4b72c240, Offset: 0x1e11
// Size: 0x79
function aisentryturret_empupdate()
{
    if ( emp_debuff::is_empd() )
    {
        self turretfiredisable();
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        self laseroff();
        return;
    }
    
    if ( !self.killed )
    {
        self turretfireenable();
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
        self laseron();
    }
}

/#

    // Namespace ai_sentry_turret
    // Params 0
    // Checksum 0xce0dc64e, Offset: 0x1e92
    // Size: 0x18d, Type: dev
    function function_c204142bd904e3ec()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"scr_sentry_show", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_sentry_show", 0 ) == 1 )
            {
                foreach ( loc in level.aisentryturrets.var_8ac28db1d6e83438 )
                {
                    color = ( 1, 0, 0 );
                    
                    if ( loc.var_c567e9db3aea3999 )
                    {
                        color = ( 0, 1, 0 );
                        leftarc = level.sentrysettings[ "<dev string:x69>" ].leftarc;
                        rightarc = level.sentrysettings[ "<dev string:x69>" ].rightarc;
                        startpoint = loc.origin + ( 0, 0, 60 );
                        debug::draw_arc( startpoint, 0 - rightarc, leftarc, loc.angles, 100, 1, 5, color );
                    }
                    
                    /#
                        sphere( loc.origin, 64, color );
                    #/
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_sentry_turret
    // Params 2
    // Checksum 0xb63e5246, Offset: 0x2027
    // Size: 0x5a, Type: dev
    function debug_text( text, time )
    {
        stoptime = gettime() + time;
        
        while ( gettime() < stoptime )
        {
            /#
                printtoscreen2d( 750, 100, text, ( 0, 0, 1 ), 2.5 );
            #/
            
            waitframe();
        }
    }

#/
