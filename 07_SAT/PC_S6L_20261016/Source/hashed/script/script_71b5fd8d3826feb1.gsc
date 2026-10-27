// script_71b5fd8d3826feb1  (hash_71b5fd8d3826feb1.gscc) (size: 27477 Bytes / 0x6b55 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ed68d24 (2664860964)
// size ...... 27477 (0x6b55)
// includes .. 35  (offset: 0x65d5)
// strings ... 58  (offset: 0x66ed)
// dev strs .. 22  (offset: 0x6a4d)
// exports ... 79  (offset: 0x3f6d)
// cseg ...... 0x5aa + 0x39c3 (0x3f6d)
// imports ... 215 (offset: 0x4bc5)
// animtree1 . 0   (offset: 0x6b55)
// animtree2 . 0   (offset: 0x6b55)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\compass_ping;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_safecrack_cs;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_bongo_safecrack_cs;
#using scripts\mp\objidpoolmanager;

#namespace activity_bongo_safecrack;

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x5
// Checksum 0x8087ddfe, Offset: 0x5c8
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"bongo_activity_safecrack", #"activity_common", &function_538033a540e63c70, &init );
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0x502c1fc2, Offset: 0x5f5
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_SAFECRACK", &safecrack_activity_type_init );
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0xf73f05d2, Offset: 0x610
// Size: 0x45
function private init()
{
    level endon( #"game_ended" );
    level callback::add( #"player_death", &function_2340b35c6216fbb3 );
    level callback::add( #"player_disconnect", &function_2340b35c6216fbb3 );
    
    /#
        level thread function_6ff293d64c33db84();
    #/
}

/#

    // Namespace activity_bongo_safecrack
    // Params 0, eflags: 0x4
    // Checksum 0xc4724c5, Offset: 0x65d
    // Size: 0xb2, Type: dev
    function private function_6ff293d64c33db84()
    {
        if ( getdvarint( @"hash_9e02f8a7e7fa1987", 0 ) )
        {
            flags::function_2f3408423ccc9b2e( "<dev string:x24>" );
            deflist = activity_definition_utils::function_326a5e04c9b438f5( "<dev string:x37>" );
            
            if ( deflist.size == 0 )
            {
                return;
            }
            
            foreach ( variant, def in deflist )
            {
                activity_instance_common::function_9b387cb1af0d5b4b( variant );
            }
        }
    }

#/

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xc41b822a, Offset: 0x717
// Size: 0x1bd
function safecrack_activity_type_init()
{
    level.var_63a7c842afe0c9c3 = spawnstruct();
    level.var_63a7c842afe0c9c3.revealradius = getdvarint( @"hash_de0487f3e5f484a3", 24000 );
    level.var_63a7c842afe0c9c3.enabledefenders = getdvarint( @"hash_d69ece7d8e88eaad", 0 );
    level.var_63a7c842afe0c9c3.var_f5e72b1c9ef8c4f2 = getdvarint( @"hash_134e75ab81aab7de", 0 );
    level.var_63a7c842afe0c9c3.revealradiussq = squared( level.var_63a7c842afe0c9c3.revealradius );
    
    /#
        level thread function_15c3b0e05cedcd17();
        level thread function_76b1a0e0fd10330f();
    #/
    
    activity_common::function_944074f3079c1d4e( "BONGO_SAFECRACK", 0, &safecrack_activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_SAFECRACK", 1, &safecrack_activity_begin );
    activity_common::function_944074f3079c1d4e( "BONGO_SAFECRACK", 2, &safecrack_activity_end );
    activity_common::function_944074f3079c1d4e( "BONGO_SAFECRACK", 3, &safecrack_activity_destroy );
    activity_common::function_944074f3079c1d4e( "BONGO_SAFECRACK", 4, &safecrack_get_center );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_e0f00b697069364a, "BONGO_SAFECRACK" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &safecrack_player_joined_activity, "BONGO_SAFECRACK" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_daa35cb39708004f, "BONGO_SAFECRACK" );
    scriptable::scriptable_addusedcallbackbypart( "safecrack_body", &function_379c55ca02f6afc7 );
    level callback::add( #"player_item_pickup", &function_67c95e5133aba77 );
    level callback::add( "scripted_item_can_use", &scripted_item_can_use );
    level callback::add( "scripted_item_can_autouse", &scripted_item_can_autouse );
    level callback::add( #"cache_opened", &on_cache_opened );
    function_917ecb108bc83c14();
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xf2aa9844, Offset: 0x8dc
// Size: 0x22
function function_917ecb108bc83c14()
{
    if ( game_utility::getmapname() == "mp_saw_mechanics" )
    {
        mp_saw_mechanics_bongo_safecrack_cs::main();
        return;
    }
    
    mp_saw_avalon_bongo_safecrack_cs::main();
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x58164fb2, Offset: 0x906
// Size: 0x91
function private safecrack_player_joined_activity( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        function_48919b897287aff8( player );
        br_analytics::function_63a0465c6e14c930( self, player );
    }
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x8e07970, Offset: 0x99f
// Size: 0x88
function function_daa35cb39708004f( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_d9845418c8b51cff( self, player );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0x2524b78d, Offset: 0xa2f
// Size: 0x5e5
function safecrack_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_837a0c8626c9b419();
    self.var_8a5f3e13cb58e019 = activity_definition_utils::function_9129cd8075c85c09( self );
    self.capture_radius = self.var_8a5f3e13cb58e019.captureradius ?? 800;
    self.var_c81a917552049716 = self.var_8a5f3e13cb58e019.attractradius ?? 2048;
    self.var_260c21764f5eeb65 = self.var_8a5f3e13cb58e019.var_28ac127dce8c6d85 ?? 1;
    self.var_a4c086caa1cbfd68 = self.var_8a5f3e13cb58e019.encounter ?? "jup_ob_safecrack_encounter";
    self.capture_height = self.var_8a5f3e13cb58e019.captureheight ?? 256;
    self.var_d7902a99156f281e = &function_d7902a99156f281e;
    function_bc041d7a3efbfe87( self.varianttag, self.var_8a5f3e13cb58e019 );
    var_1be24234bf288e29 = function_bad1cc1b764d96be();
    assert( isdefined( var_1be24234bf288e29 ), "<dev string:x47>" + self.varianttag );
    self.origin = var_1be24234bf288e29.origin;
    self.angles = var_1be24234bf288e29.angles;
    self.script_poi = var_1be24234bf288e29.script_poi;
    self.var_546e4eb5269dbafa = "difficulty_easy";
    difficultyproperties = undefined;
    
    switch ( self.var_546e4eb5269dbafa )
    {
        default:
            self.var_546e4eb5269dbafa = "difficulty_easy";
        case #"hash_7bb2cd766703d463":
            difficultyproperties = self.var_8a5f3e13cb58e019.var_872ac21eea2eea99;
            self.success_score_event = #"ob_minor_activity_complete_green";
            break;
        case #"hash_af83e47edfa8900a":
            difficultyproperties = self.var_8a5f3e13cb58e019.var_af20af95bacaf226;
            self.success_score_event = #"ob_minor_activity_complete_yellow";
            break;
        case #"hash_5343b465e56ec9a4":
            difficultyproperties = self.var_8a5f3e13cb58e019.var_64cef80d60717670;
            self.success_score_event = #"ob_minor_activity_complete_orange";
            break;
        case #"hash_651f76c0ad6741ec":
            difficultyproperties = self.var_8a5f3e13cb58e019.var_5286f38ae823e769;
            self.success_score_event = #"ob_minor_activity_complete_red";
            break;
    }
    
    self.var_fadb2dc0da30d15b = difficultyproperties.capturetime ?? 75;
    self.alarm_duration = difficultyproperties.alarmduration ?? 75;
    self.var_2ad5d67cf23b589d = difficultyproperties.var_c7343eddac5edaaf ?? 75;
    self.lootlist_bundle = difficultyproperties.lootlist ?? "wz_sat_br_bongo_spawn_list_loot_cache_lege";
    self.capture_radius = getdvarint( hashcat( @"hash_f72308758abea239", self.varianttag ), self.capture_radius );
    self.capture_height = getdvarint( hashcat( @"hash_6ebbafbfeb721c26", self.varianttag ), self.capture_height );
    self.var_c81a917552049716 = getdvarint( hashcat( @"hash_c4827b6b41a3159e", self.varianttag ), self.var_c81a917552049716 );
    self.var_260c21764f5eeb65 = getdvarint( hashcat( @"hash_406af6bb3dff6667", self.varianttag ), self.var_260c21764f5eeb65 );
    self.var_fadb2dc0da30d15b = getdvarint( hashcat( @"hash_4795d743464e3550", self.varianttag ), self.var_fadb2dc0da30d15b );
    self.lootlist_bundle = getdvar( hashcat( @"hash_66f7a80db137f8e9", self.varianttag ), self.lootlist_bundle );
    self.var_a4c086caa1cbfd68 = getdvar( hashcat( @"hash_1c069aa79535cca4", self.varianttag ), self.var_a4c086caa1cbfd68 );
    self.var_fadb2dc0da30d15b = getdvarint( @"hash_463cdb91a204da2c", self.var_fadb2dc0da30d15b );
    self.alarm_duration = getdvarint( @"hash_f2d8c31071af4dbc", self.alarm_duration );
    self.var_2ad5d67cf23b589d = getdvarint( @"hash_9587815608a3facd", self.var_2ad5d67cf23b589d );
    self.var_fadb2dc0da30d15b = float( self.var_fadb2dc0da30d15b );
    self.capture_radius_sq = squared( self.capture_radius );
    self.attract_radius_sq = squared( self.var_c81a917552049716 );
    self.var_d92ef581fc6402d = getdvarint( @"hash_538068dd04d11f04", 6 );
    safe = function_dbf9fc6567a8e762( "saw_bongo_safecrack_safe_hackable", self.origin, self.angles );
    safe setscriptablepartstate( #"safecrack_body", #"usable_not_open" );
    self.safe = safe;
    self notify( #"safe_spawned" );
    function_f6ddcade348cfca9();
    
    if ( !isdefined( level.safes ) )
    {
        level.safes = [];
    }
    
    level.safes[ level.safes.size ] = self.safe;
    var_e3149b5f4f3301c7 = getnoentvolumearray( self.varianttag, "targetname" )[ 0 ];
    
    if ( isdefined( var_e3149b5f4f3301c7 ) )
    {
        thread function_2fa369b54be73334( var_e3149b5f4f3301c7 );
    }
    
    activity_definition_utils::updateprogress( 0, self, 1, { #players:undefined } );
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    activity_participation::function_a45fd1c5cc774007( self );
    self.safe waittill( #"safe_unlocking" );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_bongo_safecrack
// Params 2, eflags: 0x4
// Checksum 0x7d2a264c, Offset: 0x101c
// Size: 0xb1
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:xc5>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "safecrack_" + variantname + "_start" ] ) )
    {
        game[ "dialog" ][ "safecrack_" + variantname + "_start" ] = data.var_a996cbdc20244121;
        game[ "dialog" ][ "safecrack_" + variantname + "_success" ] = data.var_722663430868f18e;
        game[ "dialog" ][ "safecrack_key_pickup" ] = data.var_d33e6d1b5b56ba9b;
        level.var_3ad32dfbcf662854 = data.var_236cf35e0473e6af;
    }
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0xa0ef0a5f, Offset: 0x10d5
// Size: 0x86
function function_2fa369b54be73334( notice_trigger )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.safe endon( #"safe_unlocking" );
    var_c04533e67204c2c0 = [];
    
    while ( true )
    {
        notice_trigger waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( arraycontains( var_c04533e67204c2c0, ent ) )
        {
            continue;
        }
        
        var_c04533e67204c2c0[ var_c04533e67204c2c0.size ] = ent;
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xbf369505, Offset: 0x1163
// Size: 0x39
function safecrack_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.safe waittill( #"safe_unlocked" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x3a3187cf, Offset: 0x11a4
// Size: 0x32
function safecrack_activity_end( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    
    if ( activity_succeeded )
    {
        br_activity_util::function_381d1d8f56715c32( self.capturing_team, "activitiesCompleted" );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xd0a143f9, Offset: 0x11de
// Size: 0x34
function safecrack_activity_destroy()
{
    self.safe.objective delete();
    self.safe freescriptable();
    self endon( #"instance_destroyed" );
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0x5f8a15a, Offset: 0x121a
// Size: 0x15
function safecrack_get_center()
{
    return self.safe.origin;
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x3320778a, Offset: 0x1238
// Size: 0xc
function function_e0f00b697069364a( relevant_info_struct )
{
    
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x38cbdae3, Offset: 0x124c
// Size: 0x83
function private function_48919b897287aff8( player )
{
    if ( self.safe.cracking_started )
    {
        activity_definition_utils::function_a0a94881bc380bbf( 2, self, { #players:[ player ] } );
        return;
    }
    
    if ( player get_squad_has_key() )
    {
        activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:[ player ] } );
        return;
    }
    
    activity_definition_utils::function_a0a94881bc380bbf( 0, self, { #players:[ player ] } );
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x7832e7e0, Offset: 0x12d7
// Size: 0xb0
function private function_e6e7ab1dfe07b679( player )
{
    if ( self.safe.cracking_started )
    {
        activity_definition_utils::function_a0a94881bc380bbf( 2, self, { #players:teams::getteamdata( player.team, "players" ) } );
        return;
    }
    
    if ( player get_squad_has_key() )
    {
        activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:teams::getteamdata( player.team, "players" ) } );
        return;
    }
    
    activity_definition_utils::function_a0a94881bc380bbf( 0, self, { #players:teams::getteamdata( player.team, "players" ) } );
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0x7c82e90a, Offset: 0x138f
// Size: 0x23
function private function_ffa4bd8bd61f7dec()
{
    if ( self.safe.cracking_started )
    {
        activity_definition_utils::function_a0a94881bc380bbf( 2, self, {} );
    }
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x64f68744, Offset: 0x13ba
// Size: 0x51
function private function_d7902a99156f281e( player )
{
    switch ( function_a9df07d08c8c8813( self.safe, player ) )
    {
        case #"hash_f9ab7810749a7f66":
            return 0;
        case #"hash_952e6b6661bce78b":
            return 2;
        default:
            return 1;
    }
}

// Namespace activity_bongo_safecrack
// Params 4
// Checksum 0x4aa67aa9, Offset: 0x1413
// Size: 0x8e
function function_c17622fe3216c0a4( safe, part, state, player )
{
    if ( level.var_63a7c842afe0c9c3.var_f5e72b1c9ef8c4f2 )
    {
        safe.var_183d02c9ee4eaa73 = zombie_attractor_manager::add_attractor( { #origin:safe.origin, #safe:safe }, 1, safe.activity.var_c81a917552049716, 0, undefined, &function_6223ed24fb2ea728, 0 );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0x8ce0e29a, Offset: 0x14a9
// Size: 0x91
function function_f6ddcade348cfca9()
{
    var_1be24234bf288e29 = function_bad1cc1b764d96be();
    
    if ( !isdefined( var_1be24234bf288e29.var_e05fe85000437d0c ) || int( var_1be24234bf288e29.var_e05fe85000437d0c ) == 0 )
    {
        return;
    }
    
    enc_targetname = "guard_enc_" + self.varianttag;
    self.var_24346738f0fdf761 = activity_ai_encounters::function_92b671064b0b1ce2( enc_targetname, 1, 0, 1, 2 );
    
    if ( isdefined( self.var_24346738f0fdf761 ) )
    {
        function_1a9d724a960fa19d( self.var_24346738f0fdf761, self.var_546e4eb5269dbafa, 1 );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0x781f9262, Offset: 0x1542
// Size: 0x8f
function function_c4364df61c0f1d60()
{
    activity_instance = self.activity;
    self.agents = [];
    encounterid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( activity_instance.varianttag, 1, 0, 1, 2 );
    
    if ( isdefined( encounterid ) )
    {
        function_1a9d724a960fa19d( encounterid, self.activity.var_546e4eb5269dbafa, 1 );
        ai_spawn_director::function_ee0b7976619e1cb8( encounterid, &function_385e0606ab5605e4, [ self ] );
        ai_spawn_director::function_5c8b22954b3bfa37( encounterid, &function_c4aeb6aca62ed73, [ self ] );
    }
}

// Namespace activity_bongo_safecrack
// Params 4
// Checksum 0xfe84649d, Offset: 0x15d9
// Size: 0x71
function function_385e0606ab5605e4( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    safe = userdata[ 0 ];
    
    if ( isalive( agent ) )
    {
        safe.agents[ safe.agents.size ] = agent;
        agent function_fee664c56442c995( safe );
    }
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x9660c711, Offset: 0x1652
// Size: 0x75
function function_fee664c56442c995( safe )
{
    if ( safe.var_6a16d65744e61715.size > 0 )
    {
        random_safe_cracker = utility::array_random( safe.var_6a16d65744e61715 );
        self getenemyinfo( random_safe_cracker );
        self.favoriteenemy = random_safe_cracker;
        self forcethreatupdate();
    }
    
    thread ai_behavior::behavior_combatRushOrigin( self, safe.origin, 128, 256 );
    thread function_3c2fe0e228e18e5( 8192 );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x87a25e13, Offset: 0x16cf
// Size: 0xce
function function_3c2fe0e228e18e5( validtargetdist )
{
    self endon( #"death" );
    self notify( #"hash_f6a8ce3d44c98a7c" );
    self endon( #"hash_f6a8ce3d44c98a7c" );
    
    if ( !isdefined( validtargetdist ) )
    {
        validtargetdist = 1024;
    }
    
    while ( true )
    {
        self waittill( #"damage" );
        
        if ( self.combatrushing )
        {
            thread ai_behavior::function_b72d8af48880734d( validtargetdist, self.scriptgoalpos );
            self.combatrushing = 0;
            self notify( #"hash_7078c4bdb4d4c709" );
            
            /#
                if ( getdvarint( @"hash_ed4743622c486038", 0 ) )
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:xcc>", ( 1, 1, 1 ), 1, 2, 300, 1 );
                }
            #/
        }
    }
}

// Namespace activity_bongo_safecrack
// Params 3
// Checksum 0xd25f3a3, Offset: 0x17a5
// Size: 0x5a, Type: bool
function function_c4aeb6aca62ed73( requestid, userdata, wavenumber )
{
    safe = userdata[ 0 ];
    
    if ( safe.progress_percentage >= 0.25 )
    {
        ai_spawn_director::function_baa5d26d8804d5da( requestid, &function_385e0606ab5605e4, [ safe ] );
        return true;
    }
    
    return false;
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0x7b35066d, Offset: 0x1808
// Size: 0x7e
function function_b20b278b5e936d97()
{
    if ( level.var_63a7c842afe0c9c3.enabledefenders )
    {
        thread function_c4364df61c0f1d60();
    }
    
    if ( level.var_63a7c842afe0c9c3.var_f5e72b1c9ef8c4f2 )
    {
        self.var_183d02c9ee4eaa73 = zombie_attractor_manager::add_attractor( { #origin:self.origin, #safe:self }, 1, self.activity.var_c81a917552049716, 0, undefined, &function_6223ed24fb2ea728, 0 );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xf6338ca7, Offset: 0x188e
// Size: 0x28
function function_b81d9aee00d8f643()
{
    if ( level.var_63a7c842afe0c9c3.var_f5e72b1c9ef8c4f2 )
    {
        zombie_attractor_manager::remove_attractor( self.var_183d02c9ee4eaa73 );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xb6c07926, Offset: 0x18be
// Size: 0x174
function function_33a340601c8fcbf4()
{
    agents = entity::function_cd55d7a649cb9c44( self.origin, self.activity.var_c81a917552049716, "team_hundred_ninety" );
    var_386ca8f5974e4ce = [];
    
    foreach ( agent in agents )
    {
        if ( !isplayer( agent ) )
        {
            var_386ca8f5974e4ce[ var_386ca8f5974e4ce.size ] = agent;
        }
    }
    
    agents = var_386ca8f5974e4ce;
    
    foreach ( agent in agents )
    {
        agent thread ai_behavior::behavior_combatRushOrigin( agent, self.origin, 128, 64, undefined, 1, agents, 0 );
        agent utility::ent_flag_init( "activity_safe_attracted" );
    }
    
    if ( !isdefined( self.agents ) )
    {
        self.agents = [];
    }
    
    self.agents = arraycombineunique( self.agents, agents );
}

// Namespace activity_bongo_safecrack
// Params 2
// Checksum 0x2d9a99da, Offset: 0x1a3a
// Size: 0xb4, Type: bool
function function_6223ed24fb2ea728( attractor, zombie )
{
    safe = attractor.source.safe;
    
    if ( zombie.aicategory == "normal" && distance( zombie.origin, safe.origin ) > safe.activity.capture_radius / 2 )
    {
        if ( zombie.team == "team_two_hundred" )
        {
            safe.agents[ safe.agents.size ] = zombie;
            return true;
        }
    }
    
    return false;
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x2ce5e516, Offset: 0x1af7
// Size: 0xd1
function function_beb844fa8f8659ba( player )
{
    wait 4;
    player thread hud_message::showsplash( "safecrack_revealed", undefined, undefined, undefined, 1, "splash_list_jup_ob" );
    
    foreach ( safe in level.safes )
    {
        if ( distance2dsquared( safe.origin, player.origin ) <= level.var_63a7c842afe0c9c3.revealradiussq )
        {
            function_4df03c4205ddd701( safe );
        }
    }
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x6f6bae3e, Offset: 0x1bd0
// Size: 0x2e
function function_4df03c4205ddd701( safe )
{
    safe.objective setscriptablepartstate( #"icon", #"shown" );
}

// Namespace activity_bongo_safecrack
// Params 3, eflags: 0x4
// Checksum 0x4871499c, Offset: 0x1c06
// Size: 0x12f
function private function_dbf9fc6567a8e762( safe_scriptable, origin, angles )
{
    origin = function_fd8fc0e0d2300792( origin );
    angles = function_fd8fc0e0d2300792( angles );
    safe = spawnscriptable( safe_scriptable, origin, angles );
    safe setscriptablepartstate( #"safecrack_body", "usable_not_open" );
    safe.activity = self;
    interaction::register_scriptable_interact( safe, undefined, undefined, undefined, &safe_interact_hint, 1 );
    safe.objective = spawn( "script_model", safe.origin + anglestoforward( safe.angles ) * 30 );
    safe.objective.angles = safe.angles;
    safe.objective setmodel( "saw_bongo_safecrack_safe_hackable_objective" );
    safe.objective setscriptablepartstate( #"icon", #"shown" );
    utility::callsharedfunc( #"bongo", #"hash_ccf830b44797af61", safe.objective );
    return safe;
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xb04bc22a, Offset: 0x1d3e
// Size: 0xb6
function private init_safe_objective_marker( safe )
{
    safe.obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_safecrack_marker", 0, 0 );
    objidpoolmanager::update_objective_state( self.safe.obj_id, "active" );
    objidpoolmanager::update_objective_position( safe.obj_id, safe.origin + ( 0, 0, 60 ) );
    objidpoolmanager::function_eb808b97701a4793( safe.obj_id );
    objidpoolmanager::function_daf59ee8ea2cb071( safe.obj_id );
    objective_sethideelevation( safe.obj_id, 0 );
    function_461834c350793158( safe.obj_id, 1 );
}

// Namespace activity_bongo_safecrack
// Params 2
// Checksum 0x5d709443, Offset: 0x1dfc
// Size: 0x278
function function_c999ec35984b9893( safe, player )
{
    if ( safe.cracking_started )
    {
        return;
    }
    
    safe.cracking_started = 1;
    safe.trigger = spawn( "noent_volume_trigger_radius", safe.origin, 0, self.capture_radius, self.capture_height );
    safe thread function_9c4ad71e4713d397();
    safe thread function_d3073f9fbfbd38a( getdvarfloat( @"hash_b1e5cf7cef064f84", 590.551 ), self.var_2ad5d67cf23b589d );
    var_e3149b5f4f3301c7 = getnoentvolumearray( self.varianttag, "targetname" )[ 0 ];
    
    if ( var_e3149b5f4f3301c7 )
    {
        foreach ( p in level.players )
        {
            if ( ispointinvolume( p.origin, var_e3149b5f4f3301c7 ) )
            {
                activity_participation::function_bc67362dace4370c( self, p, p == player ? "PlayerJoinedInteract" : "PlayerJoinedProximity" );
            }
        }
    }
    
    safe function_b20b278b5e936d97();
    level thread br_contract_manager::utilflare_shootflare( safe.origin, "dom" );
    safe setscriptablepartstate( #"safecrack_body", "unusable_intro_drilling" );
    safe.objective setscriptablepartstate( #"icon", #"shown_cracking" );
    safe.capturingteam = player.team;
    activity_player_common::function_674cca638cafcae3( teams::getteamdata( player.team, "players" ), self, "ui_activity_scriptable_index", safe.index, -1 );
    function_4c6cd4783450e543( safe.capturingteam );
    function_e6e7ab1dfe07b679( player );
    activity_definition_utils::function_16b3cfd89a1669f7( 1, self );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_ad01fbce0f57133e" ][ #"safeunlocking" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        safe [[ var_32dbca3143d9c4a5 ]]( player, self );
    }
    
    safe notify( #"safe_unlocking" );
    safe thread function_91fb77db771b0afd( self.var_fadb2dc0da30d15b );
    thread safe_alarm( safe );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x38db3ee, Offset: 0x207c
// Size: 0xb8
function function_4c6cd4783450e543( team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        level thread br_public::brleaderdialogplayer( "safecrack_" + self.varianttag + "_start", player, 1, undefined, 2, undefined, self.var_8a5f3e13cb58e019.var_b38da3de526dca55 );
    }
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x3eb76842, Offset: 0x213c
// Size: 0x44
function function_72a1e44f90026ea0( player )
{
    level thread br_public::brleaderdialogplayer( "safecrack_" + self.varianttag + "_success", player, 1, undefined, 2, undefined, self.var_8a5f3e13cb58e019.var_11f87a6ededa3182 );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0xf2d7ef4f, Offset: 0x2188
// Size: 0x2a
function function_c4f138f91b506363( player )
{
    level thread br_public::brleaderdialogplayer( "safecrack_key_pickup", player, 1, undefined, 2, undefined, level.var_3ad32dfbcf662854 );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x955447ca, Offset: 0x21ba
// Size: 0xd2
function safe_alarm( safe )
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    start_time = gettime();
    end_time = start_time + self.alarm_duration * 1000;
    alarm_alias = "sat_ob_activity_safecrack_alarm_01";
    awareness_zone_origin = self.safe.origin;
    alarm_origin = ( awareness_zone_origin[ 0 ], awareness_zone_origin[ 1 ], awareness_zone_origin[ 2 ] + 100 );
    duration = max( level.framedurationseconds, lookupsoundlength( alarm_alias ) / 1000 );
    wait 1.5;
    
    while ( gettime() < end_time )
    {
        playsoundatpos( alarm_origin, alarm_alias );
        wait duration;
    }
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xf2f67bbc, Offset: 0x2294
// Size: 0x16d
function private function_91fb77db771b0afd( var_4fb00ccb3d299051 )
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.activity endon( #"instance_destroyed" );
    self.progress_percentage = 0;
    var_d3de89249989197c = 0;
    var_e35d4f37e797fddd = getdvarint( @"hash_c981058c67eb054c", 1 );
    activity_definition_utils::updateprogress( 0, self.activity, 100 );
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !self.trigger.trigger_off )
        {
            if ( var_e35d4f37e797fddd || self.var_6a16d65744e61715.size > 0 )
            {
                var_d3de89249989197c = min( var_4fb00ccb3d299051, var_d3de89249989197c + level.framedurationseconds );
            }
            else if ( self.activity.var_260c21764f5eeb65 && var_d3de89249989197c > 0 )
            {
                var_d3de89249989197c = max( 0, var_d3de89249989197c - level.framedurationseconds * 0.5 );
            }
            
            self.progress_percentage = var_d3de89249989197c / var_4fb00ccb3d299051;
            activity_definition_utils::updateprogress( int( self.progress_percentage * 100 ), self.activity );
            self function_70576dbab4f88e19( "progress_percentage", self.progress_percentage );
            
            if ( self.progress_percentage >= 1 )
            {
                thread unlock_safe();
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0xd8f2725f, Offset: 0x2409
// Size: 0x20f
function private unlock_safe()
{
    if ( !self.unlocked )
    {
        self.unlocked = 1;
    }
    
    self setscriptablepartstate( #"safecrack_body", "opening" );
    self setscriptablepartstate( #"icon", #"hidden" );
    self.objective setscriptablepartstate( #"icon", #"hidden" );
    self.objective calloutmarkerping::function_608710c894185549();
    function_b81d9aee00d8f643();
    self.trigger delete();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_ad01fbce0f57133e" ][ #"hash_cc0191b67a6cf165" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( self.capturingteam, self.activity );
    }
    
    self notify( #"safe_unlocked" );
    sparams = spawnstruct();
    sparams.safe = self;
    
    foreach ( player in teams::getteamdata( self.capturingteam, "players" ) )
    {
        self.activity function_72a1e44f90026ea0( player );
        player hud_message::showsplash( "br_bongo_safecrack_complete" );
    }
    
    foreach ( player in self.var_6a16d65744e61715 )
    {
        player callback::callback( "safe_opened_nearby", sparams );
    }
    
    function_7bb9d6a4e74170ac();
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0x637860b6, Offset: 0x2620
// Size: 0x102
function private function_9c4ad71e4713d397()
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.activity endon( #"instance_destroyed" );
    self.var_6a16d65744e61715 = [];
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.var_6a16d65744e61715, player ) )
        {
            continue;
        }
        
        activity_participation::function_bc67362dace4370c( self.activity, player, "PlayerJoinedProximity" );
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_ad01fbce0f57133e" ][ #"hash_eda224ea644b260d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( player, self.activity );
        }
        
        level notify( #"safe_interaction_started" );
        self.var_6a16d65744e61715[ self.var_6a16d65744e61715.size ] = player;
        childthread function_9392a51a8014544e( player );
    }
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x9ac85258, Offset: 0x272a
// Size: 0x57
function private function_9392a51a8014544e( player )
{
    while ( isdefined( self.trigger ) && isalive( player ) && player istouching( self.trigger ) )
    {
        wait 0.2;
    }
    
    self.var_6a16d65744e61715 = arrayremove( self.var_6a16d65744e61715, player );
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0xb0a0be52, Offset: 0x2789
// Size: 0x1d0
function private function_7bb9d6a4e74170ac()
{
    lootspawnpoint = self.origin + anglestoforward( self.angles ) * 25;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( lootspawnpoint + ( 0, 0, 20 ), self.angles );
    spawnoptions.var_8e48a889d5a11dee = 0;
    spawnoptions.var_cb3b9e54c815a592 = 1;
    spawnoptions.var_8934e0ace9b7d996 = 15;
    spawnoptions.var_8958d2ace9e03584 = 20;
    
    if ( self.capturingteam )
    {
        spawnoptions.payload = [ #"teamselect", self.capturingteam ];
        spawnoptions.spawningteam = self.capturingteam;
    }
    
    lootlist_bundle = level.var_e59843fd7ff816d1 ? level.var_e59843fd7ff816d1 : self.activity.lootlist_bundle;
    var_d92ef581fc6402d = level.var_3849192d8ea84f19 ? level.var_3849192d8ea84f19 : self.activity.var_d92ef581fc6402d;
    common_item::function_38cde6a6acb68ea6( lootlist_bundle, var_d92ef581fc6402d, spawnoptions );
    
    foreach ( player in self.var_6a16d65744e61715 )
    {
        player callback::callback( #"lootCacheAddAdditionalLoot", { #cache:self } );
    }
}

// Namespace activity_bongo_safecrack
// Params 2, eflags: 0x4
// Checksum 0x5e7f2824, Offset: 0x2961
// Size: 0xde
function private safe_interact_hint( usable, player )
{
    switch ( function_a9df07d08c8c8813( usable, player ) )
    {
        case #"hash_7746a10b0d76f87c":
            return { #string:&"", #type:"HINT_NOBUTTON" };
        case #"hash_952e6b6661bce78b":
            return { #string:&"hash_bcc8ed9efa7d4f5", #type:"HINT_NOBUTTON" };
        case #"hash_f9ab7810749a7f66":
            return { #string:&"br_gametype_bongo/activity_safecracker_cannot_use_no_key", #type:"HINT_NOBUTTON" };
        case #"hash_6cf0fecd49dc6429":
            return { #string:&"sat_ob_activities/hack_the_safe", #type:"HINT_BUTTON" };
    }
}

// Namespace activity_bongo_safecrack
// Params 2, eflags: 0x4
// Checksum 0x4df9d684, Offset: 0x2a47
// Size: 0x54
function private function_a9df07d08c8c8813( usable, player )
{
    if ( usable.unlocked )
    {
        return "unlocked";
    }
    
    if ( usable.cracking_started )
    {
        return "unlocking";
    }
    
    if ( !player self_has_key() )
    {
        return "no_key";
    }
    
    return "usable";
}

// Namespace activity_bongo_safecrack
// Params 6, eflags: 0x4
// Checksum 0x537ca7c, Offset: 0x2aa4
// Size: 0x9f
function private function_379c55ca02f6afc7( instance, part, state, player, bautouse, usestring )
{
    if ( !instance.activity )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    if ( player isreloading() || player isgestureplaying() )
    {
        return;
    }
    
    if ( function_a9df07d08c8c8813( instance, player ) != "usable" )
    {
        return;
    }
    
    instance thread function_8ded8703c4d4048c( player );
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x1e7096f4, Offset: 0x2b4b
// Size: 0xb6
function private function_8ded8703c4d4048c( player )
{
    player endon( #"disconnect" );
    
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    if ( !isdefined( self.noticed_player ) )
    {
        self.noticed_player = [];
    }
    
    if ( !arraycontains( self.noticed_player, player ) )
    {
        self.noticed_player[ self.noticed_player.size ] = player;
    }
    
    var_fab006cdb4f6e516 = 1;
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        player key_remove();
        player thread pickups::playerplaygestureweaponanim( "saw_ges_plyr_bongo_usb", 1.5 );
        self.activity thread function_c999ec35984b9893( self, player );
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xe445b87, Offset: 0x2c09
// Size: 0x2d
function function_bad1cc1b764d96be()
{
    linked_structs = activity_instance_common::function_c78d8509d1f980d4( self );
    return function_389a4f515c2668d4( linked_structs, #targetname, self.varianttag );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0xa0da52f5, Offset: 0x2c3f
// Size: 0x3e
function function_fd8fc0e0d2300792( vector )
{
    if ( !isvector( vector ) )
    {
        assertmsg( "<dev string:xe0>" );
        return vector;
    }
    
    return ( int( vector[ 0 ] ), int( vector[ 1 ] ), int( vector[ 2 ] ) );
}

// Namespace activity_bongo_safecrack
// Params 2, eflags: 0x4
// Checksum 0x79039ee, Offset: 0x2c86
// Size: 0x3c
function private function_d3073f9fbfbd38a( radius, duration )
{
    function_c49c256040076efd( radius );
    self.activity utility::waittill_any_timeout( duration, "instance_destroyed" );
    function_bb24de75db5e318a();
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xb4c40c4, Offset: 0x2cca
// Size: 0x9f
function private function_c49c256040076efd( radius )
{
    height = radius;
    self.var_fe2943d566cb78a9 = spawn( "noent_volume_trigger_radius", self.origin, 0, radius, height );
    self.var_fe2943d566cb78a9.radius = radius;
    self.var_fe2943d566cb78a9 thread function_e88430a9a404779();
    self.var_fe2943d566cb78a9 thread function_40fbab04d55d4f0();
    self.var_fe2943d566cb78a9 game_utility::questcircle_create( "radarCircleEnemy", self.origin, radius );
    self.var_fe2943d566cb78a9 game_utility::questcircle_showtoall();
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0xa461e5fc, Offset: 0x2d71
// Size: 0x2c
function private function_bb24de75db5e318a()
{
    if ( self.var_fe2943d566cb78a9 )
    {
        self.var_fe2943d566cb78a9 game_utility::questcircle_delete();
        self.var_fe2943d566cb78a9 delete();
    }
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0x618934ae, Offset: 0x2da5
// Size: 0x188
function private function_40fbab04d55d4f0()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    period = getdvarfloat( @"hash_d3a6985dc9c52134", 3 );
    
    while ( true )
    {
        wait period;
        self.var_6a16d65744e61715 = function_5713d46873b29625( self.var_6a16d65744e61715 );
        uav_bigmap::function_ba754e08de8b60cf( self.var_6a16d65744e61715, period + 1 );
        
        foreach ( player in self.var_6a16d65744e61715 )
        {
            player compass_ping::ping();
        }
        
        foreach ( team_nearby in utility::function_d6c8833c6628c415( self.origin, 1200, 500, 0 ) )
        {
            triggerportableradarpingteam( self.origin, team_nearby, int( self.radius ), 2000, 0, 0, -1, 0 );
        }
    }
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0xe2d70b27, Offset: 0x2f35
// Size: 0x85
function private function_e88430a9a404779()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_6a16d65744e61715 = [];
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.var_6a16d65744e61715, player ) )
        {
            continue;
        }
        
        self.var_6a16d65744e61715[ self.var_6a16d65744e61715.size ] = player;
        childthread function_8f8f7346d42d61b8( player );
    }
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xbfe123a7, Offset: 0x2fc2
// Size: 0x47
function private function_8f8f7346d42d61b8( player )
{
    while ( isdefined( self ) && isalive( player ) && player istouching( self ) )
    {
        wait 0.2;
    }
    
    self.var_6a16d65744e61715 = arrayremove( self.var_6a16d65744e61715, player );
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xdb27def1, Offset: 0x3011
// Size: 0x3f, Type: bool
function private scripted_item_can_use( params )
{
    if ( params.bundle.ref != "brloot_usb" )
    {
        return true;
    }
    
    return !params.player self_has_key();
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xa0c47dbb, Offset: 0x3059
// Size: 0x2e, Type: bool
function private scripted_item_can_autouse( params )
{
    if ( params.bundle.ref != "brloot_usb" )
    {
        return true;
    }
    
    return false;
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0x2c55e33d, Offset: 0x3090
// Size: 0x52
function private on_cache_opened( params )
{
    if ( randomfloatrange( 0, 1 ) < getdvarfloat( @"hash_11bce16762073c02", 0 ) )
    {
        common_cache::function_a09e7cf5bad99b64( params.cache, [ %"hash_6fa6f9389e567d3b" ], 1 );
    }
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x42bc4a7e, Offset: 0x30ea
// Size: 0x4b
function function_67c95e5133aba77( params )
{
    if ( !isdefined( params.itembundle ) || params.itembundle.ref != "brloot_usb" )
    {
        return;
    }
    
    function_c4f138f91b506363( self );
    function_9a347c28670d888d();
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xecfdb727, Offset: 0x313d
// Size: 0x4b
function private function_2340b35c6216fbb3( params )
{
    if ( self_has_key() )
    {
        key_remove();
        
        if ( !level.var_6d454742ba233c0b )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            common_item::function_325e28c0fb65c36a( "brloot_usb", undefined, spawnoptions );
        }
    }
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0xeb92eb67, Offset: 0x3190
// Size: 0xd, Type: bool
function self_has_key()
{
    return self.var_e8ab75a13918b70e > 0;
}

// Namespace activity_bongo_safecrack
// Params 0
// Checksum 0x5fe3b549, Offset: 0x31a6
// Size: 0x2e, Type: bool
function get_squad_has_key()
{
    return teams::function_b00ab7e503f33379( self.team, "activity_bongo_safecrack_has_key" ) && teams::getteamdata( self.team, "activity_bongo_safecrack_has_key" );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0xdee0d599, Offset: 0x31dd
// Size: 0x23
function set_squad_has_key( squad_has_key )
{
    teams::setteamdata( self.team, "activity_bongo_safecrack_has_key", squad_has_key );
}

// Namespace activity_bongo_safecrack
// Params 1
// Checksum 0x71d19cca, Offset: 0x3208
// Size: 0x2f
function give_key( showsplash )
{
    self.var_e8ab75a13918b70e = 1;
    function_464b22db183175af();
    
    if ( showsplash )
    {
        hud_message::showsplash( "br_bongo_activity_safecrack_key_obtained" );
    }
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0x93f6f6d1, Offset: 0x323f
// Size: 0x20
function private function_9a347c28670d888d()
{
    self.var_e8ab75a13918b70e = 1;
    function_464b22db183175af();
    hud_message::showsplash( "br_bongo_activity_safecrack_key_obtained" );
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0x674fbcef, Offset: 0x3267
// Size: 0x13
function private key_remove()
{
    self.var_e8ab75a13918b70e = undefined;
    function_464b22db183175af();
}

// Namespace activity_bongo_safecrack
// Params 1, eflags: 0x4
// Checksum 0xfca2c28c, Offset: 0x3282
// Size: 0xf2
function private function_7c93c77dcad98ca6( haskey )
{
    oldvalue = self getclientomnvar( "ui_bongo_safecrack_squad_has_key_status" );
    squadindex = self.sessionuimemberindex;
    
    if ( squadindex == -1 )
    {
        squadindex = self.var_64f4581741c21af7;
    }
    
    newvalue = omnvar_utility::repackomnvar( squadindex, 1, oldvalue, haskey );
    teammates = teams::getteamdata( self.team, "players" );
    
    foreach ( teammate in teammates )
    {
        teammate setclientomnvar( "ui_bongo_safecrack_squad_has_key_status", newvalue );
    }
}

// Namespace activity_bongo_safecrack
// Params 0, eflags: 0x4
// Checksum 0xd7c76987, Offset: 0x337c
// Size: 0x1e9
function private function_464b22db183175af()
{
    squad_has_key = 0;
    
    foreach ( teammate in teams::getteamdata( self.team, "players" ) )
    {
        if ( teammate self_has_key() )
        {
            squad_has_key = 1;
            break;
        }
    }
    
    set_squad_has_key( squad_has_key );
    
    foreach ( activity_info_struct in activity_participation::function_e8eabd79cc49540e( self, [ "BONGO_SAFECRACK" ] ) )
    {
        activity_instance = level.activities.instances[ activity_info_struct.instanceid ];
        activity_instance function_e6e7ab1dfe07b679( self );
    }
    
    self setclientomnvar( "ui_bongo_safecrack_self_has_key", self_has_key() );
    function_7c93c77dcad98ca6( self_has_key() );
    
    foreach ( teammate in teams::getteamdata( self.team, "players" ) )
    {
        teammate setclientomnvar( "ui_bongo_safecrack_squad_has_key", squad_has_key );
    }
}

/#

    // Namespace activity_bongo_safecrack
    // Params 0, eflags: 0x4
    // Checksum 0x546b3b4a, Offset: 0x356d
    // Size: 0xd5, Type: dev
    function private function_15c3b0e05cedcd17()
    {
        devgui::function_9082edeb5db93280( "<dev string:x110>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x122>", @"scr_safes_reveal" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x136>", @"hash_4f2cd88d61f31a05" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x147>", @"hash_7bba049efb029baa" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x155>", @"hash_3ec6799528b8c3a3" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x16b>", @"hash_e80ff5758ab695aa" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x17d>", @"hash_ecc9f2ec79830d8" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x188>", @"hash_3cf803c8fb8e7b16" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x19f>", @"hash_95bcb70ae8cbe4cf" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x1b7>", @"hash_1902f346336c9d19" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_bongo_safecrack
    // Params 0, eflags: 0x4
    // Checksum 0x975311fe, Offset: 0x364a
    // Size: 0x767, Type: dev
    function private function_76b1a0e0fd10330f()
    {
        timer = 0;
        drawframeduration = 10;
        
        while ( true )
        {
            if ( !( isdefined( level.safes ) && isdefined( level.players ) ) )
            {
                wait 5;
                continue;
            }
            
            if ( getdvarint( @"scr_safes_reveal", 0 ) )
            {
                setdvar( @"scr_safes_reveal", 0 );
                
                foreach ( player in level.players )
                {
                    thread function_beb844fa8f8659ba( player );
                }
            }
            
            if ( getdvarint( @"hash_4f2cd88d61f31a05", 0 ) )
            {
                setdvar( @"hash_4f2cd88d61f31a05", 0 );
                
                foreach ( safe in level.safes )
                {
                    function_4df03c4205ddd701( safe );
                }
            }
            
            if ( getdvarint( @"hash_7bba049efb029baa", 0 ) )
            {
                foreach ( safe in level.safes )
                {
                    function_7913f71c4b798102( safe, drawframeduration );
                    function_3847f8d4f20c04f( safe, drawframeduration );
                    function_b9daea4484ced277( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_3ec6799528b8c3a3", 0 ) && timer == 0 )
            {
                foreach ( safe in level.safes )
                {
                    function_7913f71c4b798102( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_e80ff5758ab695aa", 0 ) && timer == 0 )
            {
                foreach ( safe in level.safes )
                {
                    function_3847f8d4f20c04f( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_ecc9f2ec79830d8", 0 ) && timer == 0 )
            {
                foreach ( safe in level.safes )
                {
                    function_b9daea4484ced277( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_3cf803c8fb8e7b16", 0 ) )
            {
                setdvar( @"hash_3cf803c8fb8e7b16", 0 );
                var_d95cd5cf93852980 = 0;
                
                foreach ( player in level.players )
                {
                    var_f387f39cdc09099a = sortbydistance( level.safes, player.origin );
                    
                    foreach ( safe in var_f387f39cdc09099a )
                    {
                        if ( !isdefined( safe.progress_percentage ) )
                        {
                            safe function_bce8bd380a53046( player );
                            var_d95cd5cf93852980 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_d95cd5cf93852980 )
                {
                    iprintln( "<dev string:x1cf>" );
                }
            }
            
            if ( getdvarint( @"hash_95bcb70ae8cbe4cf", 0 ) )
            {
                setdvar( @"hash_95bcb70ae8cbe4cf", 0 );
                var_d95cd5cf93852980 = 0;
                
                foreach ( player in level.players )
                {
                    var_f387f39cdc09099a = sortbydistance( level.safes, player.origin );
                    
                    foreach ( safe in var_f387f39cdc09099a )
                    {
                        if ( isdefined( safe.progress_percentage ) && !safe.unlocked )
                        {
                            safe function_e8bf1dc5561b43cd();
                            var_d95cd5cf93852980 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_d95cd5cf93852980 )
                {
                    iprintln( "<dev string:x216>" );
                }
            }
            
            if ( getdvarint( @"hash_1902f346336c9d19", 0 ) )
            {
                setdvar( @"hash_1902f346336c9d19", 0 );
                var_d95cd5cf93852980 = 0;
                
                foreach ( player in level.players )
                {
                    var_f387f39cdc09099a = sortbydistance( level.safes, player.origin );
                    
                    foreach ( safe in var_f387f39cdc09099a )
                    {
                        if ( safe.unlocked )
                        {
                            safe function_569ec4ae1c552be9();
                            var_d95cd5cf93852980 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_d95cd5cf93852980 )
                {
                    iprintln( "<dev string:x25b>" );
                }
            }
            
            waitframe();
            timer++;
            
            if ( timer >= drawframeduration )
            {
                timer = 0;
            }
        }
    }

    // Namespace activity_bongo_safecrack
    // Params 2
    // Checksum 0x53ac300, Offset: 0x3db9
    // Size: 0x53, Type: dev
    function function_7913f71c4b798102( safe, drawframeduration )
    {
        line( safe.origin, safe.origin + ( 0, 0, 3000 ), ( 1, 0, 1 ), 1, 0, drawframeduration );
    }

    // Namespace activity_bongo_safecrack
    // Params 2
    // Checksum 0xa8cd306b, Offset: 0x3e14
    // Size: 0x4a, Type: dev
    function function_3847f8d4f20c04f( safe, drawframeduration )
    {
        orientedbox( safe scriptablegetmidpoint(), 2 * function_decb653c5689e4ca( "<dev string:x2aa>" ), safe.angles, ( 1, 1, 1 ), 0, drawframeduration );
    }

    // Namespace activity_bongo_safecrack
    // Params 2
    // Checksum 0x5f4f60cf, Offset: 0x3e66
    // Size: 0x82, Type: dev
    function function_b9daea4484ced277( safe, drawframeduration )
    {
        sphere( safe.origin, safe.activity.capture_radius, ( 0, 1, 0 ), 0, drawframeduration );
        sphere( safe.origin, safe.activity.var_c81a917552049716, ( 1, 1, 0 ), 0, drawframeduration );
    }

    // Namespace activity_bongo_safecrack
    // Params 1
    // Checksum 0x278bb4c4, Offset: 0x3ef0
    // Size: 0x24, Type: dev
    function function_bce8bd380a53046( player )
    {
        level thread function_c17622fe3216c0a4( self, "<dev string:x2dd>", "<dev string:x2e2>", player );
    }

    // Namespace activity_bongo_safecrack
    // Params 0
    // Checksum 0x94526aaa, Offset: 0x3f1c
    // Size: 0x13, Type: dev
    function function_e8bf1dc5561b43cd()
    {
        self.progress_percentage = 1;
    }

    // Namespace activity_bongo_safecrack
    // Params 0
    // Checksum 0x563016a1, Offset: 0x3f37
    // Size: 0x36, Type: dev
    function function_569ec4ae1c552be9()
    {
        self.contents = [];
        self.weaponslotcontents = undefined;
        common_cache::fillcontentsfromlist( self, self.activity.lootlist_bundle, 5 );
    }

#/
