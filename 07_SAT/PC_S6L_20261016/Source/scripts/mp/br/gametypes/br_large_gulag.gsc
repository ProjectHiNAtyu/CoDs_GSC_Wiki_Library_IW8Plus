// scripts\mp\br\gametypes\br_large_gulag.gsc  (hash_71c7d79a732a4312.gscc) (size: 16532 Bytes / 0x4094 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad1c9866 (2904332390)
// size ...... 16532 (0x4094)
// includes .. 15  (offset: 0x3c34)
// strings ... 72  (offset: 0x3cac)
// dev strs .. 3   (offset: 0x4070)
// exports ... 40  (offset: 0x2844)
// cseg ...... 0x640 + 0x2204 (0x2844)
// imports ... 114 (offset: 0x2e84)
// animtree1 . 0   (offset: 0x4094)
// animtree2 . 0   (offset: 0x4094)
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_ai_gulag_variations;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace br_large_gulag;

// Namespace br_large_gulag
// Params 0
// Checksum 0x88bcbbde, Offset: 0x65e
// Size: 0x12f
function init_large_gulag()
{
    level.var_2c35ca12b890d4fa = spawnstruct();
    level.var_2c35ca12b890d4fa.var_a8a7d29de97c0854 = 1;
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMatchDuration", &function_b0f3cb0c9fb3889f );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMaxPlayers", &function_ae57209a7c6d3546 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsMatchPending", &function_949a5bf98b96ba72 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetClosedCircleIndex", &function_5832006e78a9cc02 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetCountdownLength", &function_f745bd210cd47809 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsOneTeamLeft", &function_4e7698f44d0a6b52 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetVictoryWait", &function_3a1866b797f57f75 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetPostVictoryWait", &function_c9d0fd71f3388cc7 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagHandleLossInfiniteEarly", &function_1ae46eba87d8bcce );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGiveAIKillRewards", &function_505685edf1e12553 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagLoseSequence", &function_6b4321c7c19f2fde );
    namespace_a8afdcd7738e364e::function_6042ec174569fa17( "gulagOvertime" );
    level ai_mp_controller::function_2b1cc53b284373( &function_f94aa7b1bdd7279e );
    level thread function_9916330497519e18();
    
    if ( !isdefined( level.supportsai ) )
    {
        thread ai_mp_controller::init();
    }
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        level thread function_b20e61e439a11aee();
    }
    
    level thread br_ai_gulag_variations::function_aad3de341555b28e();
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x9cb75a6c, Offset: 0x795
// Size: 0x25a
function function_9916330497519e18()
{
    level waittill( #"prematch_done" );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_drive", &function_c31952500357f40f );
    
    foreach ( arena in level.gulag.arenas )
    {
        arena.goaldoors = [];
        arena.keys = [];
        arena.var_82a6466a7fdadc06 = [];
        arena.lootpickedup = [];
        arenastructs = utility::getstructarray( arena.target, "targetname" );
        
        foreach ( arenastruct in arenastructs )
        {
            if ( arenastruct.script_noteworthy == "gulag_large_escape_door" )
            {
                triggerwin = spawn( "trigger_radius", arenastruct.origin, 0, 60, 10 );
                arena.goaldoors[ arena.goaldoors.size ] = triggerwin;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_large_legendary_loot_structs" && level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 != 0 )
            {
                if ( level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 < 0 || arena.keys.size < level.var_56c3cc3dc37f1728.var_20e82c0ff9edced4 )
                {
                    arena.keys[ arena.keys.size ] = spawnscriptable( "second_chance_drive", arenastruct.origin );
                }
            }
        }
        
        function_6eceefb5067122ea( arena );
        level function_6f522e7a04959896( arena );
        level thread function_9a0d224818bfc93e( arena );
    }
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x26f11215, Offset: 0x9f7
// Size: 0x14
function function_b0f3cb0c9fb3889f()
{
    return getdvarfloat( @"hash_8be34599dfa102b8", 60 );
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x7d61fb6b, Offset: 0xa14
// Size: 0x4
function function_ae57209a7c6d3546()
{
    return 8;
}

// Namespace br_large_gulag
// Params 2
// Checksum 0x6472ed7, Offset: 0xa21
// Size: 0x26
function function_949a5bf98b96ba72( nextmatch, arena )
{
    if ( nextmatch.size < 8 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x30235b4a, Offset: 0xa4f
// Size: 0x36
function function_5832006e78a9cc02( offset )
{
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"scr_br_fc_circle_disable", 4 ) - offset;
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x386b6981, Offset: 0xa8e
// Size: 0x11
function function_f745bd210cd47809()
{
    return getdvarint( @"hash_fb05c5f6825931d", 3 );
}

// Namespace br_large_gulag
// Params 0
// Checksum 0xccbcd31e, Offset: 0xaa8
// Size: 0x3, Type: bool
function function_4e7698f44d0a6b52()
{
    return false;
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x7130dc64, Offset: 0xab4
// Size: 0x7
function function_3a1866b797f57f75()
{
    return 3;
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x28d44692, Offset: 0xac4
// Size: 0x7
function function_c9d0fd71f3388cc7()
{
    return 2;
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x87e8e905, Offset: 0xad4
// Size: 0xbc
function function_cc41e13c995ac68b( arena )
{
    level thread function_9a0d224818bfc93e( arena );
    level thread gulaglarge_matchstartcamerasequence( arena );
    
    if ( arena.var_82a6466a7fdadc06.size > 0 )
    {
        foreach ( keylocation in arena.var_82a6466a7fdadc06 )
        {
            spawnscriptable( "second_chance_drive", keylocation );
        }
        
        arena.var_82a6466a7fdadc06 = [];
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x317fc273, Offset: 0xb98
// Size: 0x3bd
function function_cbe41557596c04ac( arena )
{
    level endon( #"game_ended" );
    var_19d9484bf3323ae4 = "gulagai" + arena.gulagindex;
    var_9407792f6bc33691 = "gulagplayers" + arena.gulagindex;
    
    if ( !threatbiasgroupexists( var_9407792f6bc33691 ) )
    {
        createthreatbiasgroup( var_9407792f6bc33691 );
    }
    
    if ( !threatbiasgroupexists( var_19d9484bf3323ae4 ) )
    {
        createthreatbiasgroup( var_19d9484bf3323ae4 );
        setthreatbiasagainstall( var_19d9484bf3323ae4, -100000 );
        setthreatbias( var_19d9484bf3323ae4, var_9407792f6bc33691, 2000 );
    }
    
    if ( isdefined( arena.ai_agents ) )
    {
        foreach ( ai in arena.ai_agents )
        {
            if ( isagent( ai ) )
            {
                ai setthreatbiasgroup( var_19d9484bf3323ae4 );
            }
        }
    }
    
    foreach ( goaldoor in arena.goaldoors )
    {
        goaldoor thread function_8af9e88327a254d( arena );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player thread hud_message::showsplash( "br_large_gulag_start" );
        player.gulagkills = undefined;
        player.var_f4ced78321048739 = undefined;
        player.var_82aa9e2a587b9dd7 = undefined;
        player.var_645eef13705c0695 = undefined;
        player.var_716f2b98a73614d0 = undefined;
        player.starscorepoints = undefined;
        player.var_e0a155a09c61a4ca = undefined;
        
        if ( isdefined( player.var_ba766a8c6b3f6606 ) )
        {
            player.var_ba766a8c6b3f6606 = undefined;
            arena.spawnbag = 1;
        }
        
        player namespace_a974e4dd85555bc2::function_86f9f7643fc8bc16();
        player namespace_a974e4dd85555bc2::function_7fea090e43708ff1();
        player function_ff99445c8015e1f1( 0 );
        player setthreatbiasgroup( var_9407792f6bc33691 );
        player thread gulaglarge_trackplayerbullets();
    }
    
    if ( arena.lootpickedup.size > 0 )
    {
        foreach ( loot in arena.lootpickedup )
        {
            if ( !isdefined( loot ) )
            {
                continue;
            }
            
            loot setscriptablepartstate( loot.type, "visible" );
        }
        
        arena.lootpickedup = [];
    }
    
    if ( isdefined( arena.ai_agents ) )
    {
        arena.var_4bf13b3afd1652bc = arena.ai_agents.size;
    }
    
    if ( isdefined( arena.arenaplayers ) )
    {
        arena.var_856ffb24070a6fa8 = arena.arenaplayers.size;
    }
    
    arena notify( #"hash_691033fc1a60c497" );
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xa50af6e, Offset: 0xf5d
// Size: 0x1f9
function gulaglarge_matchstartcamerasequence( arena )
{
    wait 1;
    var_dc6cbc7b4e046acb = ( -6.16415, -0.554057, 1050 );
    var_aa95b976eea8fbe4 = ( -6.16415, -0.554057, 870 );
    var_e269689fe6e709df = ( -353.134, -123.783, 273.378 );
    var_fabf3a7f1ca1acc0 = ( -438.192, -59.7148, 230.022 );
    camera = spawn( "script_model", var_dc6cbc7b4e046acb );
    camera setmodel( "tag_origin" );
    camera.angles = ( 90, 0, 0 );
    
    foreach ( player in arena.arenaplayers )
    {
        player cameralinkto( camera, "tag_origin", 1, 1 );
    }
    
    camera moveto( var_aa95b976eea8fbe4, 3, 0.5, 0.5 );
    wait 3;
    camera.origin = var_e269689fe6e709df;
    camera.angles = ( 30, 140, 0 );
    camera moveto( var_fabf3a7f1ca1acc0, 3, 0.5, 0.5 );
    wait 3;
    
    foreach ( player in arena.arenaplayers )
    {
        player cameraunlink();
    }
    
    wait 0.5;
    camera delete();
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x539f0c7, Offset: 0x115e
// Size: 0xa4
function gulaglarge_trackplayerbullets()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"gulaglarge_trackplayerbullets" );
    player endon( #"gulaglarge_trackplayerbullets" );
    player endon( #"can_show_splashes" );
    
    while ( true )
    {
        player waittill( #"weapon_fired", objweapon );
        
        if ( !isdefined( player.var_645eef13705c0695 ) )
        {
            player.var_645eef13705c0695 = 0;
        }
        
        player.var_645eef13705c0695 += 1;
    }
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x927f0e15, Offset: 0x120a
// Size: 0xb0
function function_b20e61e439a11aee()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    wait 6;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player kill();
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x8d5d4b87, Offset: 0x12c2
// Size: 0x149
function function_8af9e88327a254d( arena )
{
    goaldoor = self;
    level endon( #"game_ended" );
    
    while ( arena.arenaplayers.size > 0 )
    {
        goaldoor waittill( #"trigger", player );
        
        if ( !player.var_e0a155a09c61a4ca )
        {
            continue;
        }
        
        if ( arraycontains( arena.arenaplayers, player ) )
        {
            player thread namespace_a974e4dd85555bc2::function_bf71a0a0d9ead210( arena );
            player namespace_a974e4dd85555bc2::function_1a2c173510516f99( "win" );
            player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
            player function_ff99445c8015e1f1( -1 );
            
            foreach ( goaldoor in arena.goaldoors )
            {
                objidpoolmanager::objective_playermask_hidefrom( goaldoor.objid, player );
            }
            
            player thread br_gulag::gulagvictory( arena, player, 1, 0, "gulag_ai", undefined, undefined, undefined, 1 );
            
            if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
            {
                player thread function_4cd3914177449ad2();
            }
        }
    }
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x50ab4dfc, Offset: 0x1413
// Size: 0x32
function function_4cd3914177449ad2()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 11;
    player kill();
}

// Namespace br_large_gulag
// Params 6
// Checksum 0xf6c0c57f, Offset: 0x144d
// Size: 0x164
function function_c31952500357f40f( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( isdefined( player.var_e0a155a09c61a4ca ) )
    {
        return;
    }
    
    player thread hud_message::showsplash( "br_large_gulag_got_key_self" );
    player.var_e0a155a09c61a4ca = 1;
    level thread br_contract_manager::utilflare_shootflare( ( 57.6814, -29.0559, 450 ), "dom", 1 );
    player function_648cf28765d8fbbf();
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( isdefined( arena ) )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( p == player )
            {
                continue;
            }
            
            p thread hud_message::showsplash( "br_large_gulag_got_key_enemy" );
        }
    }
    
    arena.var_82a6466a7fdadc06[ arena.var_82a6466a7fdadc06.size ] = instance.origin;
    instance freescriptable();
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xf8a15417, Offset: 0x15b9
// Size: 0xf6
function function_6f522e7a04959896( arena )
{
    foreach ( goaldoor in arena.goaldoors )
    {
        objid = objidpoolmanager::requestobjectiveid( 99 );
        
        if ( objid != -1 )
        {
            objidpoolmanager::objective_add_objective( objid, "current", goaldoor.origin + ( 0, 0, 60 ), "ui_mp_br_mapmenu_icon_x1_05_objective" );
            objidpoolmanager::update_objective_setbackground( objid, 1 );
            objidpoolmanager::objective_playermask_hidefromall( objid );
        }
        else
        {
            println( "<dev string:x24>" );
        }
        
        goaldoor.objid = objid;
    }
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x32cfd348, Offset: 0x16b7
// Size: 0x13a
function function_648cf28765d8fbbf()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    closestdoor = arena.goaldoors[ 0 ];
    var_2995b139611c7c6e = distance( closestdoor.origin, player.origin );
    
    foreach ( goaldoor in arena.goaldoors )
    {
        tempdistance = distance( goaldoor.origin, player.origin );
        
        if ( var_2995b139611c7c6e > distance( goaldoor.origin, player.origin ) )
        {
            closestdoor = goaldoor;
            var_2995b139611c7c6e = tempdistance;
        }
    }
    
    objective_addclienttomask( closestdoor.objid, player );
    objective_showtoplayersinmask( closestdoor.objid );
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x55b3566c, Offset: 0x17f9
// Size: 0x1ac
function gulaglarge_getarenaloadout()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    
    if ( level.var_56c3cc3dc37f1728.matchstartweapons == 0 )
    {
        loadout[ "loadoutPrimary" ] = level.defaultfist.var_1616e6fbba9a722d;
    }
    else if ( level.var_56c3cc3dc37f1728.matchstartweapons == 1 )
    {
        loadout[ "loadoutPrimary" ] = "iw9_ar_mike4_mp";
    }
    else if ( level.var_56c3cc3dc37f1728.matchstartweapons == 2 )
    {
        loadout[ "loadoutPrimary" ] = "iw9_sh_mbravo_mp";
    }
    
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "none";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = "none";
    loadout[ "loadoutEquipmentSecondary" ] = "none";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_null" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    return loadout;
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x974be5ba, Offset: 0x19ae
// Size: 0x3a
function function_6b4321c7c19f2fde( arena )
{
    namespace_a974e4dd85555bc2::function_1a2c173510516f99( "lost" );
    
    if ( isdefined( arena.objid ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( arena.objid, self );
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xd2da51ec, Offset: 0x19f0
// Size: 0xc6
function function_505685edf1e12553( arena )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player.gulagkills ) )
    {
        return;
    }
    
    points = player.gulagkills;
    wait 5;
    
    while ( !player isonground() )
    {
        wait 0.5;
    }
    
    if ( points >= 2 )
    {
        player br_plunder::playerplunderpickup( 5 );
    }
    
    if ( points >= 6 )
    {
        br_pickups::br_forcegivecustompickupitem( player, "brloot_armor_plate", 1, 2 );
    }
    
    if ( points >= 8 )
    {
        player br_plunder::playerplunderpickup( 10 );
    }
    
    if ( points >= 10 )
    {
        br_pickups::br_forcegivecustompickupitem( player, "brloot_super_munitionsbox", 1 );
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x9f7301dc, Offset: 0x1abe
// Size: 0xaa
function function_f94aa7b1bdd7279e( params )
{
    agent = self;
    killer = params.eattacker;
    
    if ( !isplayer( killer ) )
    {
        return;
    }
    
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( killer );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( killer.gulagkills ) )
    {
        killer.gulagkills = 0;
    }
    
    killer.gulagkills += 1;
    killer playsoundtoplayer( "mp_killconfirm_tags_pickup", killer );
    killer function_ff99445c8015e1f1( killer.gulagkills );
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xc7c1b33c, Offset: 0x1b70
// Size: 0x18b
function gulaglarge_onplayerkilled( attacker )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( attacker );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.gulagkills ) )
    {
        attacker.gulagkills = 0;
    }
    
    attacker.gulagkills += 1;
    attacker playsoundtoplayer( "mp_killconfirm_tags_pickup", attacker );
    attacker function_ff99445c8015e1f1( attacker.gulagkills );
    
    if ( isdefined( attacker.var_e0a155a09c61a4ca ) )
    {
        return;
    }
    
    if ( !level.var_56c3cc3dc37f1728.var_1f8d0e398bd45a60 )
    {
        return;
    }
    
    attacker thread hud_message::showsplash( "br_large_gulag_got_key_self" );
    attacker.var_e0a155a09c61a4ca = 1;
    level thread br_contract_manager::utilflare_shootflare( ( 57.6814, -29.0559, 450 ), "dom", 1 );
    attacker function_648cf28765d8fbbf();
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( attacker );
    
    if ( isdefined( arena ) )
    {
        foreach ( p in arena.arenaplayers )
        {
            if ( p == attacker )
            {
                continue;
            }
            
            p thread hud_message::showsplash( "br_large_gulag_got_key_enemy" );
        }
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x61d04289, Offset: 0x1d03
// Size: 0x27
function function_ff99445c8015e1f1( value )
{
    player = self;
    player setclientomnvar( "ui_br_ai_gulag_score", value );
}

// Namespace br_large_gulag
// Params 0
// Checksum 0xefae2568, Offset: 0x1d32
// Size: 0x19e
function function_b3198967e1a679ce()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    firstplayerstatus = 0;
    var_48d949b1ae1ff465 = 0;
    
    if ( isdefined( arena.arenaplayers[ 0 ] ) && isdefined( arena.arenaplayers[ 0 ].gulagplayerstate ) )
    {
        firstplayerstatus = arena.arenaplayers[ 0 ].gulagplayerstate;
    }
    
    if ( isdefined( arena.arenaplayers[ 1 ] ) && isdefined( arena.arenaplayers[ 1 ].gulagplayerstate ) )
    {
        var_48d949b1ae1ff465 = arena.arenaplayers[ 1 ].gulagplayerstate;
    }
    
    /#
        assert( firstplayerstatus < 16, "<dev string:x4e>" );
        assert( var_48d949b1ae1ff465 < 16, "<dev string:x90>" );
    #/
    
    var_24e56c10120ade9 = ( var_48d949b1ae1ff465 << 4 ) + firstplayerstatus;
    arenaparticipants = arraycombine( arena.jailedplayers, arena.arenaplayers );
    
    foreach ( p in arenaparticipants )
    {
        p setclientomnvar( "ui_br_ai_gulag_player_state", var_24e56c10120ade9 );
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xa1fc0135, Offset: 0x1ed8
// Size: 0xf3
function function_d2247ccbf6c6f29d( player )
{
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        currentarena = level.gulag.arenas[ i ];
        
        foreach ( jailedplayers in currentarena.jailedplayers )
        {
            if ( jailedplayers == player )
            {
                arena = level.gulag.arenas[ i ];
                return arena;
            }
        }
    }
}

// Namespace br_large_gulag
// Params 0
// Checksum 0x3e0aa7b7, Offset: 0x1fd4
// Size: 0x2a, Type: bool
function function_983d14712c4c519f()
{
    if ( isdefined( level.var_2c35ca12b890d4fa ) && level.var_2c35ca12b890d4fa.var_a8a7d29de97c0854 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_large_gulag
// Params 2
// Checksum 0xc8a8630e, Offset: 0x2007
// Size: 0x7c, Type: bool
function function_ef97293189d4e914( attacker, victim )
{
    if ( !function_983d14712c4c519f() || !( isdefined( victim ) && isdefined( attacker ) ) )
    {
        return false;
    }
    
    if ( !level.var_56c3cc3dc37f1728.allowfriendlyfire )
    {
        return false;
    }
    
    if ( isplayer( victim ) && isplayer( attacker ) )
    {
        if ( victim.gulag && attacker.gulag )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x3967ab5b, Offset: 0x208c
// Size: 0x1e1
function function_1ae46eba87d8bcce( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    foreach ( goaldoor in arena.goaldoors )
    {
        objidpoolmanager::objective_playermask_hidefrom( goaldoor.objid, player );
    }
    
    if ( player.health == 0 )
    {
        wait 7;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player br_gulag::setplayervargulag( 0 );
        teammate = player;
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == player )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate br_pickups::addrespawntoken( 1 );
            player br_gulag::playergulagautowin( "largeGulag", teammate );
            wait 7;
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            player kill();
        }
        
        return;
    }
    
    player thread br_gulag::gulagvictory( arena, player, 1, 0, "shutdown" );
    wait 7;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player kill();
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x718a05ce, Offset: 0x2275
// Size: 0x59
function function_9a0d224818bfc93e( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.aiset = 1;
        
        if ( isdefined( arena.ai_structs ) )
        {
            thread gulaglarge_spawnagents( arena );
        }
        
        arena waittill( #"matchended" );
        thread function_c6ff1f85d84a460c( arena );
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x84a4655c, Offset: 0x22d6
// Size: 0x26
function function_6eceefb5067122ea( arena )
{
    category = "gulag";
    ai_mp_controller::aibudget_registercategory( category );
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xa60b1d5f, Offset: 0x2304
// Size: 0x9f
function gulaglarge_spawnagents( arena )
{
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) )
    {
        thread br_ai_gulag_variations::function_baddb8c4549731db( arena );
        return;
    }
    
    foreach ( aispawn in arena.ai_structs )
    {
        thread function_e3f7a0ab45a84fb6( arena, aispawn );
    }
}

// Namespace br_large_gulag
// Params 2
// Checksum 0x5991569a, Offset: 0x23ab
// Size: 0x111
function function_e3f7a0ab45a84fb6( arena, aispawn )
{
    aitype = "enemy_mp_smg_tier1_aq";
    spawnlocation = aispawn.origin;
    
    if ( !getdvarint( @"hash_b3d7a9483362813e", 0 ) )
    {
        spawnlocation = getclosestpointonnavmesh( aispawn.origin );
    }
    
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    
    if ( isagent( agent ) )
    {
        agent thread function_cfbfdb8431db27ca( arena );
        
        if ( getdvarint( @"hash_b3d7a9483362813e", 0 ) )
        {
            agent forceteleport( spawnlocation, aispawn.angles );
            agent setgoalpos( agent.origin, 32 );
            agent clearpath();
            agent.fixednode = 1;
            agent thread ai_behavior::behavior_GuardStationary( agent, 1, agent.origin );
            return;
        }
        
        agent thread ai_behavior::behavior_GuardStationary( agent );
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x9d232fd6, Offset: 0x24c4
// Size: 0x131
function function_1ccacf6dd3b11147( arena )
{
    if ( !arena.aiset )
    {
        function_9a0d224818bfc93e( arena );
    }
    
    var_d0fc05116223dcaf = 0;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( player namespace_a974e4dd85555bc2::function_f8df68020042aa4() )
        {
            var_d0fc05116223dcaf = 1;
            break;
        }
    }
    
    if ( var_d0fc05116223dcaf )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
            }
        }
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x8cdf0a07, Offset: 0x25fd
// Size: 0x41
function function_cfbfdb8431db27ca( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = [];
    }
    
    arena.ai_agents[ arena.ai_agents.size ] = self;
}

// Namespace br_large_gulag
// Params 1
// Checksum 0xe8dd39bc, Offset: 0x2646
// Size: 0x8b
function function_36e59f9c39a01f2a( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = arrayremove( arena.ai_agents, self );
        
        if ( isagent( self ) )
        {
            if ( isalive( self ) )
            {
                ai_mp_controller::killoffagent();
            }
            else
            {
                body = self getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body delete();
                }
            }
        }
        
        if ( arena.ai_agents.size <= 0 )
        {
            arena.ai_agents = undefined;
        }
    }
}

// Namespace br_large_gulag
// Params 1
// Checksum 0x59da63fa, Offset: 0x26d9
// Size: 0x16b
function function_c6ff1f85d84a460c( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
                agent function_36e59f9c39a01f2a( arena );
                agent setthreatbiasgroup();
            }
        }
        
        arena.ai_agents = undefined;
        arena.aiset = undefined;
    }
    
    waitframe();
    var_5a1796bfaa7e2815 = 2950;
    nearbyloot = getlootscriptablearrayinradius( undefined, undefined, arena.center, var_5a1796bfaa7e2815 );
    
    foreach ( lootitem in nearbyloot )
    {
        if ( lootitem getscriptableisreserved() && lootitem getscriptableisloot() )
        {
            lootitem pickups::deletescriptableinstance();
        }
    }
}

