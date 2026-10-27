// scripts\mp\common\killstreaks\death_switch.gsc  (hash_39101f2e3552c7a1.gscc) (size: 4754 Bytes / 0x1292 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86a8cb96 (2259209110)
// size ...... 4754 (0x1292)
// includes .. 14  (offset: 0x1092)
// strings ... 28  (offset: 0x1102)
// dev strs .. 1   (offset: 0x1286)
// exports ... 15  (offset: 0x962)
// cseg ...... 0x241 + 0x721 (0x962)
// imports ... 43  (offset: 0xbba)
// animtree1 . 0   (offset: 0x1292)
// animtree2 . 0   (offset: 0x1292)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;

#namespace death_switch;

// Namespace death_switch
// Params 0
// Checksum 0x81458338, Offset: 0x25f
// Size: 0x92
function init()
{
    killstreaks::registerkillstreak( "death_switch", &tryusedeathswitchfromstruct );
    val::group_register( "laststand_killstreak", [ "usability", "weapon_switch", "gesture", "killstreaks", "supers", "fire", "melee", "offhand_primary_weapons", "offhand_secondary_weapons" ] );
    
    /#
        setdevdvarifuninitialized( @"scr_death_switch_type", 1 );
    #/
    
    level.killstreak_laststand_func = &deathswitch_startpayloadreleasesequence;
}

// Namespace death_switch
// Params 0
// Checksum 0x29387c26, Offset: 0x2f9
// Size: 0x22
function tryusedeathswitch()
{
    streakinfo = killstreak_utility::createstreakinfo( "death_switch", self );
    return tryusedeathswitchfromstruct( streakinfo );
}

// Namespace death_switch
// Params 1
// Checksum 0x2741adbd, Offset: 0x324
// Size: 0xe6, Type: bool
function tryusedeathswitchfromstruct( streakinfo )
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
    
    deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( "ks_gesture_vest_mp" ) );
    
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
    
    killstreak_utility::playkillstreaktacomdialog( streakinfo, "use_" + "death_switch", #"use", 1 );
    utility::trycall( level.matchdata_logkillstreakevent, "death_switch", self.origin );
    thread hud_util::teamplayercardsplash( "used_" + "death_switch", self );
    thread startdeathswitch( streakinfo );
    return true;
}

// Namespace death_switch
// Params 1
// Checksum 0x59c11732, Offset: 0x413
// Size: 0xe, Type: bool
function weapongivendeathswitch( streakinfo )
{
    return true;
}

// Namespace death_switch
// Params 1
// Checksum 0x9bee8a94, Offset: 0x42a
// Size: 0xc7
function startdeathswitch( streakinfo )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self iprintlnbold( "If I go down, I'm taking them with me!" );
    perk::giveperk( "specialty_pistoldeath" );
    self.killstreaklaststand = 1;
    self.deathswitchent = spawn( "script_model", self gettagorigin( "j_helmet" ) );
    self.deathswitchent setmodel( "ks_death_switch_mp" );
    self.deathswitchent.angles = self.angles;
    self.deathswitchent linkto( self, "j_helmet", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread deathswitch_loopblinkinglight();
}

// Namespace death_switch
// Params 0
// Checksum 0xb401c2d8, Offset: 0x4f9
// Size: 0x5a
function deathswitch_loopblinkinglight()
{
    self endon( #"disconnect" );
    self endon( #"deathswitch_release" );
    
    while ( true )
    {
        self.deathswitchent setscriptablepartstate( "blinking_light", "on", 0 );
        wait 0.5;
        self.deathswitchent setscriptablepartstate( "blinking_light", "off", 0 );
    }
}

/#

    // Namespace death_switch
    // Params 0
    // Checksum 0x542f29c4, Offset: 0x55b
    // Size: 0x3a, Type: dev
    function debugloc()
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin, 5, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

#/

// Namespace death_switch
// Params 0
// Checksum 0xda0a29d9, Offset: 0x59d
// Size: 0x4c
function deathswitch_startpayloadreleasesequence()
{
    laststandweapon = level.laststandweapon;
    inventory_utility::_giveweapon( laststandweapon, undefined, undefined, 1 );
    thread laststand::switchtofists( laststandweapon );
    val::group_set( "laststand_killstreak", 0 );
    thread deathswitch_payloadrelease( 3 );
    thread deathswitch_watchbleedout( 3 );
}

// Namespace death_switch
// Params 1
// Checksum 0x4afabad1, Offset: 0x5f1
// Size: 0xfa
function deathswitch_payloadrelease( payloadreleasetimer )
{
    self endon( #"payload_release" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    payloadtype = 1;
    
    /#
        payloadtype = getdvarint( @"scr_death_switch_type", 1 );
    #/
    
    projectile = weapon::_launchgrenade( "death_switch_blast_mp", self gettagorigin( "j_mainroot" ), ( 0, 0, 0 ), payloadreleasetimer, 1 );
    projectile linkto( self );
    thread deathswitch_payloadreleaseondeath( payloadtype, projectile );
    
    for ( startingwait = 1; payloadreleasetimer > 0 ; startingwait = 0.05 )
    {
        self iprintlnbold( "Death Switch Countdown: " + payloadreleasetimer );
        payloadreleasetimer -= startingwait;
        playsoundatpos( self.origin, "death_switch_beep" );
        wait startingwait;
        startingwait -= 0.2;
        
        if ( startingwait < 0.05 )
        {
        }
    }
    
    deathswitch_payloadreleasetype( payloadtype, projectile );
}

// Namespace death_switch
// Params 2
// Checksum 0xbfd2239f, Offset: 0x6f3
// Size: 0x68
function deathswitch_payloadreleaseondeath( payloadtype, projectile )
{
    self endon( #"payload_release" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_c29d758202572f06" );
    self endon( #"hash_c29d758202572f06" );
    self waittill( #"death" );
    deathswitch_payloadreleasetype( payloadtype, projectile );
}

// Namespace death_switch
// Params 2
// Checksum 0xa25f80f5, Offset: 0x763
// Size: 0x96
function deathswitch_payloadreleasetype( payloadtype, projectile )
{
    if ( isdefined( projectile ) )
    {
        projectile delete();
    }
    
    switch ( payloadtype )
    {
        case 0:
            thread deathswitch_releaselocalexplosion();
            break;
        case 1:
            thread deathswitch_releaseartilleryexplosion();
            break;
        default:
            assertmsg( "<dev string:x24>" );
            break;
    }
    
    self.killstreaklaststand = undefined;
    perk::removeperk( "specialty_pistoldeath" );
    self notify( #"payload_release" );
}

// Namespace death_switch
// Params 0
// Checksum 0x2080073b, Offset: 0x801
// Size: 0x79
function deathswitch_releaselocalexplosion()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"deathswitch_release" );
    self.deathswitchent setscriptablepartstate( "blinking_light", "off", 0 );
    self.deathswitchent setscriptablepartstate( "explode", "on", 0 );
    self.deathswitchent setentityowner( self );
    self.deathswitchent thread script::delayentdelete( 5 );
}

// Namespace death_switch
// Params 0
// Checksum 0x64447c2, Offset: 0x882
// Size: 0xa4
function deathswitch_releaseartilleryexplosion()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"deathswitch_release" );
    launchpoint = self.origin + ( 0, 0, 20000 );
    goalpoint = self.origin;
    missile = weapon_utility::_magicbullet( makeweapon( "death_switch_proj_mp" ), launchpoint, goalpoint, self );
    self.deathswitchent setscriptablepartstate( "blinking_light", "off", 0 );
    self.deathswitchent thread script::delayentdelete( 5 );
}

// Namespace death_switch
// Params 1
// Checksum 0xe32fb01a, Offset: 0x92e
// Size: 0x34
function deathswitch_watchbleedout( bleedouttime )
{
    level endon( #"game_ended" );
    level endon( #"death_or_disconnect" );
    hostmigration::waitlongdurationwithpause( bleedouttime );
    damage::_suicide();
}

