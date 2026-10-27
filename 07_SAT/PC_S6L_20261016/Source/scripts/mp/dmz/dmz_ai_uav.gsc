// scripts\mp\dmz\dmz_ai_uav.gsc  (hash_525a26f460a41507.gscc) (size: 2904 Bytes / 0xb58 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1dc068af (499148975)
// size ...... 2904 (0xb58)
// includes .. 7   (offset: 0xa58)
// strings ... 13  (offset: 0xa90)
// dev strs .. 0   (offset: 0xb58)
// exports ... 7   (offset: 0x660)
// cseg ...... 0x100 + 0x560 (0x660)
// imports ... 25  (offset: 0x778)
// animtree1 . 0   (offset: 0xb58)
// animtree2 . 0   (offset: 0xb58)
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\damage;
#using scripts\mp\dmz\star_system;

#namespace dmz_ai_uav;

// Namespace dmz_ai_uav
// Params 1
// Checksum 0x2583cddc, Offset: 0x11e
// Size: 0x7e
function function_65308382b6efbc80( poiname )
{
    fakeowner = ai_mp_controller::function_3d6581dd2c928fbc( agent_utils::function_25b40f5accbca0dd( "merc" ) );
    streakinfo = killstreak_utility::createstreakinfo( "uav", fakeowner );
    
    if ( !isdefined( level.activeuavs[ fakeowner.team ] ) )
    {
        level.activeuavs[ fakeowner.team ] = 0;
    }
    
    function_f8cece82680077db( "uav", poiname, fakeowner );
}

// Namespace dmz_ai_uav
// Params 3
// Checksum 0x1be3987b, Offset: 0x1a4
// Size: 0x1e7
function function_f8cece82680077db( uavtype, poiname, owner )
{
    poiorigin = utility::callsharedfunc( #"poi", #"hash_fc858bd1017130aa", poiname );
    uavmodel = spawn( "script_model", poiorigin + ( 0, 0, 5000 ) );
    settings = level.uavsettings[ "uav" ];
    maxhealth = settings.maxhealth;
    uavmodel setmodel( settings.modelbase );
    uavrig = spawn( "script_model", poiorigin );
    uavrig setmodel( "tag_origin" );
    uavrig.angles = ( 0, 115, 0 );
    uavrig.uavtype = "uav";
    uavrig hide();
    uavrig thread function_a830ea27df12d40( 70 );
    angle = randomint( 360 );
    xoffset = cos( angle ) * 4000;
    yoffset = sin( angle ) * 4000;
    zoffset = 6000;
    anglevector = vectornormalize( ( xoffset, yoffset, zoffset ) );
    anglevector *= zoffset;
    uavmodel linkto( uavrig, "tag_origin", anglevector, ( 0, angle + 90, 0 ) );
    uavmodel.rig = uavrig;
    uavmodel.damagestate = 0;
    uavmodel.poi = poiname;
    uavmodel setscriptablepartstate( "lights", "on", 0 );
    uavmodel setscriptablepartstate( "objective", "on", 0 );
    uavmodel thread damage::monitordamage( maxhealth, "hitequip", &function_21d06ec4f42b9f86, undefined );
    uavmodel thread function_db04c9118e499d44( 10 );
}

// Namespace dmz_ai_uav
// Params 1
// Checksum 0xee2ab085, Offset: 0x393
// Size: 0x3b
function function_a830ea27df12d40( rotatetime )
{
    self endon( #"death" );
    yawangle = 360;
    
    while ( true )
    {
        self rotateyaw( yawangle, rotatetime );
        wait rotatetime;
    }
}

// Namespace dmz_ai_uav
// Params 1
// Checksum 0x5932f422, Offset: 0x3d6
// Size: 0x68
function function_21d06ec4f42b9f86( data )
{
    self setscriptablepartstate( "lights", "off", 0 );
    self setscriptablepartstate( "explode", "on", 0 );
    self notify( #"explode", data.attacker );
    wait 5;
    self notify( #"death" );
    self.rig delete();
    self delete();
}

// Namespace dmz_ai_uav
// Params 1
// Checksum 0x7e98410a, Offset: 0x446
// Size: 0xed
function function_db04c9118e499d44( chanceinc )
{
    self endon( #"death" );
    chance = chanceinc;
    
    while ( true )
    {
        wait 5;
        players = namespace_e4f074fad347a61a::function_401d5b95f7e26b6f( self.poi, 3 );
        
        foreach ( player in players )
        {
            if ( utility::percent_chance( clamp( chance, 0, 100 ) ) )
            {
                chance = chanceinc;
                ai_reinforcements::function_d0a9530035c6dc35( player.origin, 5000, undefined, 2 );
                break;
            }
            
            chance += chanceinc;
        }
    }
}

// Namespace dmz_ai_uav
// Params 1
// Checksum 0xe239181a, Offset: 0x53b
// Size: 0x124
function function_7a1d37537907d843( data )
{
    currenthealth = self.health - data.damage;
    
    switch ( self.damagestate )
    {
        case 0:
            if ( currenthealth < self.maxhealth * 0.65 )
            {
                self.damagestate = 1;
                self setscriptablepartstate( "body_damage_light", "on", 0 );
            }
            
            break;
        case 1:
            if ( currenthealth < self.maxhealth * 0.25 )
            {
                self.damagestate = 2;
                self setscriptablepartstate( "body_damage_medium", "on", 0 );
            }
            
            break;
        case 2:
            if ( currenthealth < self.maxhealth * 0.05 )
            {
                self.damagestate = 3;
                self setscriptablepartstate( "body_damage_heavy", "on", 0 );
            }
            
            break;
        case 3:
        default:
            break;
    }
    
    return data.damage;
}

