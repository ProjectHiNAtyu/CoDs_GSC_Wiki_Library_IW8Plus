// script_10c46fd48ca0d2a9  (hash_10c46fd48ca0d2a9.gscc) (size: 18026 Bytes / 0x466a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec19c6b (247569515)
// size ...... 18026 (0x466a)
// includes .. 25  (offset: 0x429e)
// strings ... 46  (offset: 0x4366)
// dev strs .. 2   (offset: 0x4652)
// exports ... 51  (offset: 0x2a3e)
// cseg ...... 0x429 + 0x2615 (0x2a3e)
// imports ... 134 (offset: 0x3236)
// animtree1 . 0   (offset: 0x466a)
// animtree2 . 0   (offset: 0x466a)
#using script_16ea1b94f0f381b3;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace namespace_de17882223d5e361;

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x5
// Checksum 0xd53c0733, Offset: 0x447
// Size: 0x40
function private autoexec __init__system__()
{
    system::register( #"hash_b14afdf876cb01e6", [ #"activity_common", #"hash_b6d8574c0a05ea39", #"hash_20b69f2e04df3783" ], &function_538033a540e63c70, undefined );
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x4a3fb951, Offset: 0x48f
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CAMO_CASE", &activity_type_init );
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x4562ac56, Offset: 0x4aa
// Size: 0x2f
function private function_bcee95ddd99d2a15()
{
    if ( !isdefined( level.var_70e97061620578e4 ) )
    {
        level.var_70e97061620578e4 = getdvarint( @"hash_cc41019001f07dc7", 1 );
    }
    
    return level.var_70e97061620578e4;
}

// Namespace namespace_de17882223d5e361
// Params 0
// Checksum 0x11459247, Offset: 0x4e2
// Size: 0x13c
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_CAMO_CASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CAMO_CASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CAMO_CASE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CAMO_CASE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( "saw_activity_camocase", "camocase" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CAMO_CASE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BR_CAMO_CASE" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &function_322ff9de576df571, "BR_CAMO_CASE" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &player_entered_gulag, "BR_CAMO_CASE" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &player_left_gulag, "BR_CAMO_CASE" );
    common_item::function_c7bbbfcefe78f798( "wz_consumable_camocase", &function_4a865e3b211bc8dc );
    level callback::add( #"player_item_pickup", &function_2f0c8c9fe3c88ac9 );
    scriptable::scriptable_adddamagedcallback( &function_e7bc238cb9d8fc5c );
    utility::registersharedfunc( #"flee_drone", #"package_dropped", &function_3c1c3414cee13e27 );
    level.var_6964602795119cbb = getdvarint( @"hash_545e75285fb10f56", 90 );
    register_camocase_vo();
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x2a039138, Offset: 0x626
// Size: 0x9a
function private register_camocase_vo()
{
    game[ "dialog" ][ "br_camocase_pickup_team" ] = "wzan_cacp";
    game[ "dialog_prefix" ][ "br_camocase_pickup_team" ] = "dx_br_brsd_sddd_";
    game[ "dialog" ][ "br_camocase_pickup_enemy" ] = "wzan_cace";
    game[ "dialog_prefix" ][ "br_camocase_pickup_enemy" ] = "dx_br_brsd_sddd_";
    game[ "dialog" ][ "br_camocase_extracted_team" ] = "wzan_cext";
    game[ "dialog_prefix" ][ "br_camocase_extracted_team" ] = "dx_br_brsd_sddd_";
    game[ "dialog" ][ "br_camocase_extracted_enemy" ] = "wzan_caee";
    game[ "dialog_prefix" ][ "br_camocase_extracted_enemy" ] = "dx_br_brsd_sddd_";
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x2d07804c, Offset: 0x6c8
// Size: 0x21
function private function_3c1c3414cee13e27( attacker )
{
    level.var_ca7b4a253803f535 = self;
    level.var_da7cf5d6d300a97f = attacker;
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x5aebfda5, Offset: 0x6f1
// Size: 0x2ec
function private function_4a865e3b211bc8dc( itemspawnparams )
{
    item = itemspawnparams.item;
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    id = objidpoolmanager::requestobjectiveid( 1 );
    item.camocaseobjectiveid = id;
    
    if ( id > -1 )
    {
        objidpoolmanager::objective_add_objective( id, "invisible", itemspawnparams.origin, "hud_icon_loot_squad_loot_box" );
        objidpoolmanager::objective_set_play_intro( id, 0 );
        
        foreach ( player in level.players )
        {
            objective_addclienttomask( id, player );
        }
        
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_setzoffset( id, 90 );
        function_ac9886e0e2860e18( id, 3800, 4000 );
        objective_setlabel( id, &"hash_380273757859aaf9" );
        objective_setdescription( id, &"hash_380273757859aaf9" );
        attacker = level.var_da7cf5d6d300a97f;
        fleedrone = level.var_ca7b4a253803f535;
        level.var_da7cf5d6d300a97f = undefined;
        level.var_ca7b4a253803f535 = undefined;
        
        if ( isplayer( attacker ) )
        {
            foreach ( teammember in teams::getteamdata( attacker.team, "players" ) )
            {
                var_f205ac92aa8fd344 = fleedrone.var_58cc57d664322d1d[ teammember getentitynumber() ];
                
                if ( isdefined( var_f205ac92aa8fd344 ) )
                {
                    pingowner = teammember;
                    break;
                }
            }
            
            if ( !isdefined( pingowner ) )
            {
                pingowner = attacker;
            }
            
            pingindex = var_f205ac92aa8fd344 ?? attacker calloutmarkerping::function_920a63c06abdefe8( item getscriptableindex() );
            
            if ( isdefined( pingindex ) )
            {
                foreach ( teammember in teams::getteamdata( attacker.team, "players" ) )
                {
                    objective_removeclientfrommask( id, teammember );
                }
                
                objective_showtoplayersinmask( id );
                pingowner thread function_6b60179c50d11fff( item, id, pingindex, attacker.team );
            }
        }
    }
}

// Namespace namespace_de17882223d5e361
// Params 4, eflags: 0x4
// Checksum 0xb4b91132, Offset: 0x9e5
// Size: 0xda
function private function_6b60179c50d11fff( item, objid, pingindex, team )
{
    level endon( #"game_ended" );
    waitframe();
    self waittill( "predictiveCalloutClear_" + pingindex );
    
    if ( item && item.camocaseobjectiveid == objid )
    {
        foreach ( teammember in teams::getteamdata( team, "players" ) )
        {
            objective_addclienttomask( objid, teammember );
        }
        
        objective_showtoplayersinmask( objid );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x1958368a, Offset: 0xac7
// Size: 0x184
function private function_2f0c8c9fe3c88ac9( params )
{
    if ( params.itembundlename != %"hash_48eb5e41f57e9d6c" )
    {
        return;
    }
    
    if ( params.item.camocaseobjectiveid > -1 )
    {
        objidpoolmanager::returnobjectiveid( params.item.camocaseobjectiveid );
        params.item.camocaseobjectiveid = undefined;
    }
    
    player = params.player;
    camocasevarianttag = params.item.camocasevarianttag;
    
    if ( !camocasevarianttag )
    {
        airdropvarianttag = utility::callsharedfunc( #"special_loot_drone", #"get_airdrop_variant_tag" );
        camocasevarianttag = airdropvarianttag ? airdropvarianttag + "_camocase" : "camocase";
    }
    
    activity_instance = activity_instance_common::function_9b387cb1af0d5b4b( camocasevarianttag, player.origin );
    activity_instance.carrier = player;
    activity_instance.camocasepickuptime = gettime();
    activity_participation::function_bc67362dace4370c( activity_instance, player, "PlayerJoinedInteract" );
    activity_instance function_f24ccc30549447d6( player );
    activity_instance thread function_d89af9f826e5a5cf( player );
    player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_df5a86bdd1d74ebf" );
    function_154877743557e2ac( player.team );
    show_splash_stolen( player.team );
    activity_instance thread function_69e9096cccd40ac6( player );
}

// Namespace namespace_de17882223d5e361
// Params 0
// Checksum 0x1d668363, Offset: 0xc53
// Size: 0x99
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    
    if ( !function_bcee95ddd99d2a15() )
    {
        extractionnode = function_414e11d1e4475844( activity_instance );
        
        if ( !extractionnode )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( activity_instance );
            assertmsg( "<dev string:x24>" + activity_instance.instanceid );
            return;
        }
        
        activity_instance.extractionnode = extractionnode;
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_de17882223d5e361
// Params 0
// Checksum 0x44141a3d, Offset: 0xcf4
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( function_bcee95ddd99d2a15() )
    {
        activity_instance function_261e514bcaa29e53();
        return;
    }
    
    activity_instance function_1a3ec0eebefd56c5();
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x91c3e0ce, Offset: 0xd43
// Size: 0x10c
function private function_261e514bcaa29e53()
{
    activity_instance = self;
    activity_instance notify( #"hash_a62b80420cb16e08" );
    activity_instance thread function_1d9595fd30d5726d();
    activity_instance thread function_e8b764e540a2934d( activity_instance.carrier.team );
    msg = utility::waittill_any_ents_return( activity_instance, "decryption_complete", level, "post_end_game_splash" );
    var_a7e8f2a6a74dd169 = msg == "post_end_game_splash";
    function_3afe435e41fd7122( var_a7e8f2a6a74dd169, activity_instance.carrier.team );
    
    if ( activity_instance.carrier )
    {
        activity_instance.carrier br_quest_inventory::consume_quest_item( "wz_consumable_camocase" );
        activity_instance function_ec36dfa51a4c72d2();
        activity_instance function_56bef63e60ecbba9( activity_instance.carrier.team );
        function_a4290702b80cc2f8( activity_instance.carrier.team );
    }
    
    report_challenge_complete( activity_instance );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x32cb377b, Offset: 0xe57
// Size: 0x40
function private function_1d9595fd30d5726d()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait level.var_6964602795119cbb;
    activity_instance notify( #"decryption_complete" );
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xbfd07bf, Offset: 0xe9f
// Size: 0xc1
function private function_1a3ec0eebefd56c5()
{
    activity_instance = self;
    wait 3;
    activity_instance function_ccb567f1e137fef6();
    msg = utility::waittill_any_ents_return( activity_instance, "extraction_complete", level, "post_end_game_splash" );
    var_a7e8f2a6a74dd169 = msg == "post_end_game_splash";
    function_3afe435e41fd7122( var_a7e8f2a6a74dd169, activity_instance.carrier.team );
    
    if ( activity_instance.carrier )
    {
        activity_instance.carrier br_quest_inventory::consume_quest_item( "wz_consumable_camocase" );
        activity_instance function_ec36dfa51a4c72d2();
    }
    
    activity_instance thread function_55f11a01f7f4333a();
    activity_instance waittill( #"drone_escaped" );
    report_challenge_complete( activity_instance );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0xd588db0a, Offset: 0xf68
// Size: 0x123
function private function_69e9096cccd40ac6( carrier )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 10;
    
    while ( isalive( carrier ) )
    {
        var_ef832427c68eff57 = teams::getteamdata( carrier.team, "alivePlayers" );
        
        foreach ( teammember in var_ef832427c68eff57 )
        {
            if ( !isdefined( teammember ) )
            {
                continue;
            }
            
            if ( teammember br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            teammember namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"br_camocase_hold" );
            teammember common_item::function_96119bed8ab4c5d9( { #count:25, #type:%"hash_2ad6699da7d6a0da" }, 1, 1, 1 );
        }
        
        wait 10;
    }
}

// Namespace namespace_de17882223d5e361
// Params 2, eflags: 0x4
// Checksum 0x53a4bc39, Offset: 0x1093
// Size: 0xdb
function private function_3afe435e41fd7122( var_a7e8f2a6a74dd169, carrierteam )
{
    foreach ( player in level.players )
    {
        if ( var_a7e8f2a6a74dd169 && player.team == carrierteam )
        {
            player hud_message::showsplash( #"hash_bad2d8bc3dede9dd" );
            continue;
        }
        
        if ( !var_a7e8f2a6a74dd169 && player.team != carrierteam )
        {
            player hud_message::showsplash( #"hash_70b34a7996ef8635" );
        }
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x4ed3eab0, Offset: 0x1176
// Size: 0xef
function private report_challenge_complete( activity_instance )
{
    challengename = activity_instance.var_332f929de1894b2b.challengename;
    carrier = activity_instance.carrier;
    
    if ( !challengename || !isplayer( carrier ) )
    {
        return;
    }
    
    foreach ( teammember in teams::getteamdata( carrier.team, "players" ) )
    {
        teammember namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_e7d1846eb566028c" );
    }
    
    challenges::function_37e945722d6497f3( carrier, challengename, 1, 1 );
}

// Namespace namespace_de17882223d5e361
// Params 1
// Checksum 0x65fe5fbf, Offset: 0x126d
// Size: 0x7e
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    carrier = activity_instance.carrier;
    
    if ( isplayer( carrier ) )
    {
        var_c885d4deb5f39925 = int( ( gettime() - activity_instance.camocasepickuptime ) * 0.001 );
        carrier function_c481658e5b952c1b( activity_instance.successfullycompleted, var_c885d4deb5f39925 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 0
// Checksum 0xba3fd4b0, Offset: 0x12f3
// Size: 0xa6
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.extractiondrone )
    {
        activity_instance.extractiondrone freescriptable();
    }
    
    if ( activity_instance.extractionentity )
    {
        if ( activity_instance.var_35dcdac58b50895c )
        {
            activity_instance br_contract_manager::deletequestobjicon();
        }
        
        activity_instance.extractionentity delete();
    }
    
    if ( activity_instance.carrier )
    {
        activity_instance.carrier br_quest_inventory::consume_quest_item( "wz_consumable_camocase" );
    }
    
    activity_instance function_4e96d638610c3f0e();
    activity_instance function_ec36dfa51a4c72d2();
}

// Namespace namespace_de17882223d5e361
// Params 1
// Checksum 0xb0886155, Offset: 0x13a1
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_de17882223d5e361
// Params 1
// Checksum 0x6cd78871, Offset: 0x13e1
// Size: 0x23
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace namespace_de17882223d5e361
// Params 1
// Checksum 0x974935c0, Offset: 0x140c
// Size: 0x49
function function_322ff9de576df571( relevant_info_struct )
{
    activity_instance = self;
    victim = relevant_info_struct.victim;
    
    if ( activity_instance.carrier == victim )
    {
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x7e796b10, Offset: 0x145d
// Size: 0x70
function private player_entered_gulag( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    if ( self.var_a6869205ffa60b8b > -1 )
    {
        objective_removeclientfrommask( self.var_a6869205ffa60b8b, params.player );
    }
    
    if ( self.var_bdad9c369dea9652 > -1 )
    {
        objective_removeclientfrommask( self.var_bdad9c369dea9652, params.player );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0xe08ae061, Offset: 0x14d5
// Size: 0x1e
function private player_left_gulag( params )
{
    function_4a8571255cdbf92b( params.player );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0xe0ed72f1, Offset: 0x14fb
// Size: 0x19c
function private function_414e11d1e4475844( activity_instance )
{
    searchorigin = activity_instance.var_441d26d05f86b224;
    var_332f929de1894b2b = activity_instance.var_332f929de1894b2b;
    locations = getunusedlootcachepoints( searchorigin, var_332f929de1894b2b.var_59a4e8f1b64a3aaa, var_332f929de1894b2b.var_5d0823b5fb9026e4, 1 );
    
    if ( !locations || locations.size < 1 )
    {
        return;
    }
    
    bestnode = undefined;
    bestdistsqrd = var_332f929de1894b2b.var_59a4e8f1b64a3aaa * var_332f929de1894b2b.var_59a4e8f1b64a3aaa;
    
    foreach ( node in locations )
    {
        tracestart = node.origin + anglestoforward( node.angles ) * 10 + ( 0, 0, 20 );
        
        if ( !trace::sphere_trace_passed( tracestart, tracestart + ( 0, 0, 10000 ), 15 ) )
        {
            continue;
        }
        
        distsqrd = distance2dsquared( node.origin, searchorigin );
        
        if ( distsqrd < bestdistsqrd )
        {
            bestdistsqrd = distsqrd;
            bestnode = node;
        }
    }
    
    if ( bestnode )
    {
        disablelootspawnpoint( bestnode.index );
    }
    
    return bestnode;
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x7832f927, Offset: 0x16a0
// Size: 0x10b
function private function_ccb567f1e137fef6()
{
    activity_instance = self;
    extractionnode = activity_instance.extractionnode;
    
    if ( !extractionnode )
    {
        assertmsg( "<dev string:x6d>" + activity_instance.instanceid );
        return;
    }
    
    extractionentity = spawn( "script_model", extractionnode.origin );
    extractionentity.angles = extractionnode.angles;
    extractionentity setmodel( "military_loot_crate_01_br_scavenger_01" );
    extractionentity setscriptablepartstate( "body", "scavenger_closed" );
    extractionentity common_cache::function_e35d5e97bd22367( &function_bd67faa7bb3d04f3 );
    extractionentity.activity = activity_instance;
    extractionentity function_7653c765b6c7b815();
    activity_instance.extractionentity = extractionentity;
    activity_instance function_eeca0c0b1d2bbb42();
    activity_instance waittill( #"hash_8b2ae4c24c8eb8f9" );
    extractionentity enablescriptableplayeruse( activity_instance.carrier );
    extractionentity setotherent( activity_instance.carrier );
    activity_instance thread function_b2fd5e6885eb8d5c();
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xa1be473, Offset: 0x17b3
// Size: 0x39
function private function_b2fd5e6885eb8d5c()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 30;
    activity_instance_common::endactivity( activity_instance, 0 );
}

// Namespace namespace_de17882223d5e361
// Params 6, eflags: 0x4
// Checksum 0xf3991b57, Offset: 0x17f4
// Size: 0xd2
function private function_bd67faa7bb3d04f3( instance, part, state, player, bautouse, usestring )
{
    cacheentity = instance.entity;
    activity_instance = cacheentity.activity;
    
    if ( activity_instance.carrier != player )
    {
        return;
    }
    
    if ( activity_instance.var_35dcdac58b50895c )
    {
        activity_instance br_contract_manager::deletequestobjicon();
    }
    
    activity_instance function_a7bf6cbfc740ee8a( cacheentity );
    activity_instance.extractionentity delete();
    activity_instance.extractionentity = undefined;
    player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_741bdcb04fe0c27d" );
    activity_instance notify( #"extraction_complete" );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x8141ff2a, Offset: 0x18ce
// Size: 0x121
function private function_a7bf6cbfc740ee8a( extractionentity )
{
    activity_instance = self;
    var_332f929de1894b2b = activity_instance.var_332f929de1894b2b;
    
    if ( !var_332f929de1894b2b.lootlistbundle || !var_332f929de1894b2b.lootlistcount )
    {
        return;
    }
    
    leftvector = anglestoleft( extractionentity.angles );
    startorigin = extractionentity.origin + ( 0, 0, 30 );
    endorigin = extractionentity.origin + leftvector * 30;
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( endorigin, startorigin, extractionentity.angles );
    spawnoptions.var_8d4f327170228364 = 0;
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_44d5025c8cfbd48e = var_332f929de1894b2b.lootlistcount;
    spawnoptions.var_2321e933cbdf46d8 = 10;
    common_item::function_38cde6a6acb68ea6( var_332f929de1894b2b.lootlistbundle, var_332f929de1894b2b.lootlistcount, spawnoptions );
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xe9e5f1e, Offset: 0x19f7
// Size: 0x162
function private function_eeca0c0b1d2bbb42()
{
    activity_instance = self;
    var_332f929de1894b2b = activity_instance.var_332f929de1894b2b;
    extractionorigin = activity_instance.extractionnode.origin;
    var_8af46db4ed9de27a = level.package_airdrop.var_afc3b97ba5d5d1ea[ randomint( level.package_airdrop.var_afc3b97ba5d5d1ea.size ) ];
    offset = var_8af46db4ed9de27a.offset;
    spawnorigin = ( extractionorigin[ 0 ] - offset[ 0 ], extractionorigin[ 1 ] - offset[ 1 ], extractionorigin[ 2 ] - offset[ 2 ] + 500 );
    drone = spawnscriptable( var_332f929de1894b2b.dronescriptable, spawnorigin );
    drone setscriptablepartstate( #"model", #"loaded" );
    drone.health = var_332f929de1894b2b.dronehealth;
    drone.maxhealth = drone.health;
    drone.activity = activity_instance;
    drone.var_d674b579618cf41c = 1;
    drone.var_8af46db4ed9de27a = var_8af46db4ed9de27a;
    activity_instance.extractiondrone = drone;
    activity_instance function_b2f3af745110c63f();
    activity_instance thread function_7db638e81343131b();
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xef3d8e11, Offset: 0x1b61
// Size: 0xeb
function private function_7db638e81343131b()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    drone = activity_instance.extractiondrone;
    var_8af46db4ed9de27a = drone.var_8af46db4ed9de27a;
    arrivaltime = 15 + var_8af46db4ed9de27a.traveltime + var_8af46db4ed9de27a.var_ba493c8ae1b4b618;
    activity_instance.var_24ff4253a8beb98c = arrivaltime;
    activity_instance notify( #"hash_3b29804502300945" );
    drone drone_patrol();
    drone setscriptablepartstate( #"move", var_8af46db4ed9de27a.spawnname );
    wait var_8af46db4ed9de27a.traveltime + var_8af46db4ed9de27a.var_ba493c8ae1b4b618;
    
    if ( !activity_instance.extractiondrone )
    {
        return;
    }
    
    activity_instance notify( #"hash_8b2ae4c24c8eb8f9" );
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xbab3d43d, Offset: 0x1c54
// Size: 0x108
function private drone_patrol()
{
    drone = self;
    endtime = gettime() + 15000;
    
    while ( gettime() < endtime )
    {
        patrolindex = randomint( level.package_airdrop.patrols.size );
        patrol = level.package_airdrop.patrols[ patrolindex ];
        
        if ( !patrol )
        {
            continue;
        }
        
        patrolname = patrol.patrolname;
        var_d30ef0ef2abf559f = patrol.traveltimes;
        var_233a7ffc91bf1c87 = patrol.stabtimes;
        
        for ( patrolindex = 0; patrolindex < var_d30ef0ef2abf559f.size ; patrolindex++ )
        {
            if ( gettime() >= endtime )
            {
                break;
            }
            
            drone setscriptablepartstate( patrolname, getxhash( "" + patrolindex + 1 ) );
            wait var_d30ef0ef2abf559f[ patrolindex ] + var_233a7ffc91bf1c87[ patrolindex ];
        }
        
        drone setscriptablepartstate( patrolname, #"0" );
    }
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xd3c851c8, Offset: 0x1d64
// Size: 0x7d
function private function_b2f3af745110c63f()
{
    activity_instance = self;
    activity_instance br_contract_manager::createquestobjicon( "saw_ui_map_icon_obj_special_delivery", "current", undefined, activity_instance );
    activity_instance.var_35dcdac58b50895c = activity_instance.objectiveiconid;
    objective_onentity( activity_instance.var_35dcdac58b50895c, activity_instance.extractionentity );
    objective_setzoffset( activity_instance.var_35dcdac58b50895c, 90 );
    activity_instance br_activity_util::function_87a015bf03f9d1f6( activity_instance.var_35dcdac58b50895c );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x5ccbf226, Offset: 0x1de9
// Size: 0x1ca
function private function_f24ccc30549447d6( carrier )
{
    activity_instance = self;
    friendlyid = objidpoolmanager::requestobjectiveid( 1 );
    activity_instance.var_a6869205ffa60b8b = friendlyid;
    
    if ( friendlyid > -1 )
    {
        objidpoolmanager::objective_add_objective( friendlyid, "current", carrier.origin, "hud_icon_loot_squad_loot_box" );
        objidpoolmanager::objective_set_play_intro( friendlyid, 0 );
        objidpoolmanager::update_objective_onentity( friendlyid, carrier );
        objective_setzoffset( friendlyid, 90 );
        objective_setlabel( friendlyid, &"hash_380273757859aaf9" );
        objective_setdescription( friendlyid, &"hash_380273757859aaf9" );
        objidpoolmanager::update_objective_setclientforsquadcustomcolor( friendlyid, carrier );
        objidpoolmanager::objective_showdistance( friendlyid, 0 );
    }
    
    var_299688fe2e68a9e3 = objidpoolmanager::requestobjectiveid( 1 );
    activity_instance.var_bdad9c369dea9652 = var_299688fe2e68a9e3;
    
    if ( var_299688fe2e68a9e3 > -1 )
    {
        objidpoolmanager::objective_add_objective( var_299688fe2e68a9e3, "active", carrier.origin, "hud_icon_loot_squad_loot_box" );
        objidpoolmanager::objective_set_play_intro( var_299688fe2e68a9e3, 0 );
        objidpoolmanager::update_objective_onentity( var_299688fe2e68a9e3, carrier );
        objidpoolmanager::function_373aaf492aabde6f( var_299688fe2e68a9e3, 238, 22, 22, 1 );
        objective_setlabel( var_299688fe2e68a9e3, &"hash_380273757859aaf9" );
        objective_setdescription( var_299688fe2e68a9e3, &"hash_380273757859aaf9" );
    }
    
    foreach ( player in level.players )
    {
        activity_instance function_4a8571255cdbf92b( player );
    }
    
    carrier br::function_f2d49b5c22624ea2();
    carrier setclientomnvar( "ui_br_under_uav", 1 );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x5596885a, Offset: 0x1fbb
// Size: 0xc3
function private function_4a8571255cdbf92b( player )
{
    if ( !isplayer( player ) || player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( self.var_a6869205ffa60b8b > -1 && player.team == self.carrier.team )
    {
        objective_addclienttomask( self.var_a6869205ffa60b8b, player );
        objective_showtoplayersinmask( self.var_a6869205ffa60b8b );
    }
    
    if ( self.var_bdad9c369dea9652 > -1 && player.team != self.carrier.team )
    {
        objective_addclienttomask( self.var_bdad9c369dea9652, player );
        objective_showtoplayersinmask( self.var_bdad9c369dea9652 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x7294b90b, Offset: 0x2086
// Size: 0xaa
function private function_ec36dfa51a4c72d2()
{
    activity_instance = self;
    
    if ( activity_instance.var_a6869205ffa60b8b > -1 )
    {
        objidpoolmanager::returnobjectiveid( activity_instance.var_a6869205ffa60b8b );
        activity_instance.var_a6869205ffa60b8b = undefined;
    }
    
    if ( activity_instance.var_bdad9c369dea9652 > -1 )
    {
        objidpoolmanager::returnobjectiveid( activity_instance.var_bdad9c369dea9652 );
        activity_instance.var_bdad9c369dea9652 = undefined;
    }
    
    carrier = activity_instance.carrier;
    
    if ( carrier )
    {
        if ( !carrier.var_6b6612d9ed859a59 )
        {
            carrier br::function_ccd86d629929e144();
        }
        
        carrier setclientomnvar( "ui_br_under_uav", 0 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0xae6bbd38, Offset: 0x2138
// Size: 0xba
function private function_d89af9f826e5a5cf( carrier )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( function_bcee95ddd99d2a15() )
    {
        activity_instance waittill( #"hash_a62b80420cb16e08" );
        countdownms = int( level.var_6964602795119cbb * 1000 );
        activity_instance function_4970909f06babe78( carrier, gettime() + countdownms );
        return;
    }
    
    activity_instance waittill( #"hash_3b29804502300945" );
    countdownms = int( ( 3 + activity_instance.var_24ff4253a8beb98c ) * 1000 );
    activity_instance function_4970909f06babe78( carrier, gettime() + countdownms );
    activity_instance thread function_664953996fe2d77a( carrier );
}

// Namespace namespace_de17882223d5e361
// Params 2, eflags: 0x4
// Checksum 0xd8248f6b, Offset: 0x21fa
// Size: 0xd1
function private function_4970909f06babe78( carrier, challengeendtime )
{
    foreach ( teammember in teams::getteamdata( carrier.team, "players" ) )
    {
        teammember setclientomnvar( "ui_br_weapon_case_carrier_id", carrier.sessionuimemberindex );
        teammember setclientomnvar( "ui_br_weapon_case_end_time", challengeendtime );
        teammember setclientomnvar( "ui_br_weapon_case_widget_visibility_state", teammember == carrier ? 1 : 2 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x95961b2a, Offset: 0x22d3
// Size: 0xea
function private function_664953996fe2d77a( player )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance waittill( #"hash_8b2ae4c24c8eb8f9" );
    challengeendtime = gettime() + 30000;
    player setclientomnvar( "ui_br_weapon_case_widget_visibility_state", 4 );
    
    foreach ( teammember in teams::getteamdata( player.team, "players" ) )
    {
        teammember setclientomnvar( "ui_br_weapon_case_end_time", challengeendtime );
    }
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0x231295a1, Offset: 0x23c5
// Size: 0xd5
function private function_4e96d638610c3f0e()
{
    activity_instance = self;
    carrier = activity_instance.carrier;
    issuccess = activity_instance.successfullycompleted == 1;
    
    if ( !carrier )
    {
        return;
    }
    
    foreach ( teammember in teams::getteamdata( carrier.team, "players" ) )
    {
        teammember setclientomnvar( "ui_br_weapon_case_widget_visibility_state", issuccess ? 0 : 3 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 0, eflags: 0x4
// Checksum 0xfc6a30c, Offset: 0x24a2
// Size: 0xb7
function private function_55f11a01f7f4333a()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    drone = activity_instance.extractiondrone;
    var_332f929de1894b2b = activity_instance.var_332f929de1894b2b;
    
    if ( !drone )
    {
        return;
    }
    
    drone setscriptablepartstate( #"move", #"exit" );
    wait var_332f929de1894b2b.var_f8add68a084d4abf;
    
    if ( !activity_instance.extractiondrone )
    {
        return;
    }
    
    activity_instance.extractiondrone freescriptable();
    activity_instance.extractiondrone = undefined;
    activity_instance notify( #"drone_escaped" );
}

// Namespace namespace_de17882223d5e361
// Params 11, eflags: 0x4
// Checksum 0xeee1d982, Offset: 0x2561
// Size: 0xfb
function private function_e7bc238cb9d8fc5c( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !instance.var_d674b579618cf41c )
    {
        return;
    }
    
    instance.health -= idamage;
    
    if ( isplayer( eattacker ) )
    {
        eattacker damagefeedback::updatehitmarker( "hitequip", instance.health <= 0, 0, 1 );
    }
    
    if ( instance.health <= 0 )
    {
        waitframe();
        activity_instance = instance.activity;
        activity_instance.extractiondrone = undefined;
        instance freescriptable();
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x3e5835b0, Offset: 0x2664
// Size: 0x36
function private show_splash_stolen( carrierteam )
{
    if ( !level.var_eba918121149d9f7 )
    {
        hud_util::showsplashtoallexceptteam( carrierteam, #"hash_141c373e2313a094" );
        level.var_eba918121149d9f7 = 1;
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x279d07e5, Offset: 0x26a2
// Size: 0x28
function private function_154877743557e2ac( carrierteam )
{
    br_public::brleaderdialogteam( "br_camocase_pickup_team", carrierteam );
    function_e813ab44411244ed( "br_camocase_pickup_enemy", carrierteam );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x7159aceb, Offset: 0x26d2
// Size: 0x28
function private function_56bef63e60ecbba9( carrierteam )
{
    br_public::brleaderdialogteam( "br_camocase_extracted_team", carrierteam );
    function_e813ab44411244ed( "br_camocase_extracted_enemy", carrierteam );
}

// Namespace namespace_de17882223d5e361
// Params 2, eflags: 0x4
// Checksum 0x2f38a9c0, Offset: 0x2702
// Size: 0x9a
function private function_e813ab44411244ed( dialogkey, carrierteam )
{
    enemyteams = team_utility::getenemyteams( carrierteam );
    
    foreach ( enemyteam in enemyteams )
    {
        br_public::brleaderdialogteam( dialogkey, enemyteam );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x2d65949, Offset: 0x27a4
// Size: 0xe2
function private function_e8b764e540a2934d( carrierteam )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    anticipationdelay = level.var_6964602795119cbb - 10.2;
    
    if ( anticipationdelay > 0 )
    {
        wait anticipationdelay;
    }
    
    foreach ( player in teams::getteamdata( carrierteam, "players" ) )
    {
        player playlocalsound( #"hash_5fcd25fde7be00e5" );
    }
    
    activity_instance thread function_311500b20a9bee89( carrierteam );
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0xd4ae7735, Offset: 0x288e
// Size: 0xc3
function private function_311500b20a9bee89( carrierteam )
{
    activity_instance = self;
    activity_instance endon( #"decryption_complete" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance waittill( #"activity_ended" );
    
    foreach ( player in teams::getteamdata( carrierteam, "players" ) )
    {
        player stoplocalsound( #"hash_5fcd25fde7be00e5" );
    }
}

// Namespace namespace_de17882223d5e361
// Params 1, eflags: 0x4
// Checksum 0x3585767f, Offset: 0x2959
// Size: 0x90
function private function_a4290702b80cc2f8( carrierteam )
{
    foreach ( player in teams::getteamdata( carrierteam, "players" ) )
    {
        player playlocalsound( #"hash_7621826b67a9a53e" );
    }
}

// Namespace namespace_de17882223d5e361
// Params 2, eflags: 0x4
// Checksum 0xcb88bc78, Offset: 0x29f1
// Size: 0x4d
function private function_c481658e5b952c1b( is_extraction_successful, time_held_seconds )
{
    player = self;
    player dlog_recordplayerevent( "dlog_event_br_camocase_hold", [ "is_extraction_successful", is_extraction_successful, "time_held_seconds", time_held_seconds ] );
}

