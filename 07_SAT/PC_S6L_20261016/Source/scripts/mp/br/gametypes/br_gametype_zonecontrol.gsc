// scripts\mp\br\gametypes\br_gametype_zonecontrol.gsc  (hash_09d2b6b433636d1a.gscc) (size: 79979 Bytes / 0x1386b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7047e831 (1883760689)
// size ...... 79979 (0x1386b)
// includes .. 36  (offset: 0x12853)
// strings ... 206 (offset: 0x12973)
// dev strs .. 42  (offset: 0x13653)
// exports ... 221 (offset: 0xd203)
// cseg ...... 0xefc + 0xc307 (0xd203)
// imports ... 397 (offset: 0xf48b)
// animtree1 . 0   (offset: 0x1386b)
// animtree2 . 0   (offset: 0x1386b)
#using script_72af5a878a9d3397;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_multi_circle_objectives;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_rewards;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_killstreak;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace br_gametype_zonecontrol;

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x5c85376f, Offset: 0xf1a
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x98c765f5, Offset: 0xf39
// Size: 0xa7
function init()
{
    level thread br_gametype_resurgence::function_c5ef98d264c34632();
    level thread br_gametype_resurgence::function_f4e1314a5e53009a();
    function_7c1e4bf9413886d5();
    function_646c40fa1e886b7e();
    function_7a793c7c447299aa();
    function_5850370f4c35f688( 1 );
    level thread brzonecontrol_initfeatures();
    level thread brzonecontrol_initcallback();
    level thread brzonecontrol_initpostmain();
    level thread brzonecontrol_initdialog();
    level thread function_28aec95c8e28c840();
    utility::registersharedfunc( #"gametype", #"hash_ee4ee436d7fa9e38", &function_13a528304b1edd59 );
    thread audio_utility::snd_transient_load( "mp_gamemode_lockdown" );
    level.supportsai = 1;
    level thread ai_mp_controller::function_71bf1a00b0b8d267();
    thread function_48667de333523b3();
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x5f549088, Offset: 0xfe8
// Size: 0x18
function function_48667de333523b3()
{
    waittillframeend();
    function_5ba14ad001285dd0();
    function_b0a19ce79688f165();
    function_ac397f2e90f9cdd1();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x2723d4dd, Offset: 0x1008
// Size: 0xae
function brzonecontrol_initfeatures()
{
    level endon( #"game_ended" );
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"hash_56a2d01019099833" );
    br_gametypes::disablefeature( #"dropbagloop" );
    br_gametypes::disablefeature( #"randomizecirclecenter" );
    br_gametypes::enablefeature( #"planeusecircleradius" );
    br_gametypes::disablefeature( #"registerrevivecount" );
    br_gametypes::enablefeature( #"hash_e7b3c195cf4ac5ea" );
    br_gametypes::disablefeature( #"hash_a1e2467effef085c" );
    br_gametypes::enablefeature( #"hash_7bf340059947e149" );
    br_gametypes::disablefeature( #"hash_bd1f8398e2f123b" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x56b9e0de, Offset: 0x10be
// Size: 0x232
function brzonecontrol_initcallback()
{
    level endon( #"game_ended" );
    callback::add( #"player_spawned", &player_onrespawn );
    callback::add( #"hash_57a74c8771bf7e7", &brzonecontrol_dontconsiderafk );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &function_8362cdbbc97471da );
    utility::registersharedfunc( #"gametype", #"createmulticircleobjectivesstruct", &brzonecontrol_createmulticircleobjectivesstruct );
    utility::registersharedfunc( #"gametype", #"onplayerkilled", &brzonecontrol_onplayerkilled );
    utility::registersharedfunc( #"gametype", #"hash_a407cc94ad2c6279", &brzonecontrol_onplayerconnect );
    utility::registersharedfunc( #"gametype", #"hash_be8a8c525d1b00bb", &function_b0c78c44ae3c0d9f );
    utility::registersharedfunc( #"gametype", #"onplayerentervehicle", &zone_onplayerentervehicle );
    utility::registersharedfunc( #"gametype", #"hash_58f0392c3d55dee6", &function_37ca8d93c7d7b7ae );
    utility::registersharedfunc( #"gametype", #"packclientmatchdata", &brzonecontrol_packclientmatchdata );
    utility::registersharedfunc( #"gametype", #"droponplayerdeath", &function_fc95b4074361539d );
    utility::registersharedfunc( #"gametype", #"hash_6ad813eac6007239", &function_9e2f604f23599e62 );
    utility::registersharedfunc( #"gametype", #"hash_787878f1f37fb59c", &utility::always_false );
    
    if ( level.brgametype.var_4ea524dc82389417 )
    {
        callback::add( #"killstreak_removed", &function_d281b85a571a5f03 );
        utility::registersharedfunc( #"gametype", #"playerdropbonuses", &function_6237972a5037fc4f );
        utility::registersharedfunc( #"gametype", #"hash_b7651997478271e", &function_5376d4e229c13da5 );
    }
    
    br_circle::registercirclecallbacks( 17, &br_rewards::dangercircletick_dropbag, &br_rewards::dangermulticircletick_dropbag );
    level waittill( #"prematch_done" );
    
    if ( level.var_9bffc1c7425dcc18 )
    {
        callback::add( "on_agent_spawned", &namespace_ddca46d216b096e2::onentityspawned );
    }
    
    disconnect_event_aggregator::registerondisconnecteventcallback( &brzonecontrol_onplayerdisconnect );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x4140ec23, Offset: 0x12f8
// Size: 0x5e
function brzonecontrol_initpostmain()
{
    level endon( #"game_ended" );
    waittillframeend();
    brzonecontrol_cleanupents();
    level waittill( #"prematch_done" );
    function_95b185caffd6f8f2();
    function_9ecf56bef7f4ef5();
    function_cf804ff492926a08();
    function_22b60856dfb70b71();
    thread function_8bd7508a5e31b0d7();
    function_9f060979e9b8f484();
    thread function_fae2d63a1992ae5c();
    
    /#
        thread function_54b9b145d1ecc163();
    #/
}

/#

    // Namespace br_gametype_zonecontrol
    // Params 0
    // Checksum 0x1183ff5b, Offset: 0x135e
    // Size: 0x385, Type: dev
    function function_54b9b145d1ecc163()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_dfc88f79bb79d2fa", 0 ) > 0 )
            {
                ids = "<dev string:x24>";
                
                foreach ( index, element in level.objectiveidpool.active )
                {
                    if ( element )
                    {
                        ids += "<dev string:x25>" + element.objid;
                        
                        if ( element.objid != index )
                        {
                            ids += "<dev string:x27>" + index + "<dev string:x34>";
                        }
                    }
                }
                
                println( "<dev string:x37>" + ids );
                ids = "<dev string:x24>";
                
                foreach ( entry in level.objectiveidpool.reclaimed )
                {
                    ids += entry.objid + "<dev string:x25>";
                }
                
                println( "<dev string:x44>" + ids );
                ids = "<dev string:x24>";
                
                foreach ( id in level.objectiveidpool.reserved )
                {
                    ids += id + "<dev string:x25>";
                }
                
                println( "<dev string:x54>" + ids + "<dev string:x63>" );
            }
            
            if ( getdvarint( @"hash_7aee4ff3b870fcf9", 1 ) > 0 )
            {
                foreach ( entry in level.objectiveidpool.reclaimed )
                {
                    foreach ( index, element in level.objectiveidpool.active )
                    {
                        if ( entry.objid == element.objid )
                        {
                            assert( 0, "<dev string:x65>" + entry.objid + "<dev string:x75>" + index );
                        }
                    }
                }
            }
            
            delay = getdvarint( @"hash_9f29d19a5bdf9aad", -1 );
            
            if ( delay <= 0 )
            {
                waitframe();
                continue;
            }
            
            wait delay;
        }
    }

#/

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x5014bc7e, Offset: 0x16eb
// Size: 0x13
function brzonecontrol_cleanupents()
{
    game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x38e1bb4f, Offset: 0x1706
// Size: 0x306
function brzonecontrol_initdialog()
{
    level endon( #"game_ended" );
    waitframe();
    waittillframeend();
    leaderdialogs = [];
    leaderdialogs[ "match_start" ] = "name";
    leaderdialogs[ "offense_obj" ] = "boos";
    leaderdialogs[ "objective_desc" ] = "obje";
    leaderdialogs[ "zone_activation" ] = "unlo";
    leaderdialogs[ "zone_deactivation" ] = "clos";
    leaderdialogs[ "halfway_leaders" ] = "gghf";
    leaderdialogs[ "halfway_others" ] = "gghe";
    leaderdialogs[ "lead_first" ] = "ldfr";
    leaderdialogs[ "lead_marked" ] = "ldmk";
    leaderdialogs[ "lead_taking" ] = "ldtk";
    leaderdialogs[ "lead_lost" ] = "ldlo";
    leaderdialogs[ "zone_secured" ] = "secu";
    leaderdialogs[ "zone_contested" ] = "acco";
    leaderdialogs[ "attacking_zone" ] = "attk";
    leaderdialogs[ "activation_anticipation" ] = "t15n";
    leaderdialogs[ "deactivation_anticipation" ] = "tr15";
    leaderdialogs[ "play_objective" ] = "hint";
    leaderdialogs[ "overtime_start" ] = "ovtm";
    leaderdialogs[ "victory_close_leaders" ] = "vcfr";
    leaderdialogs[ "victory_close_others" ] = "vcen";
    leaderdialogs[ "high_value_zone" ] = "tihv";
    leaderdialogs[ "match_end_soon" ] = "tmed";
    leaderdialogs[ "squadmate_left" ] = "scad";
    game[ "dialog" ][ "resurgence_redeploy" ] = "";
    game[ "dialog" ][ "resurgence_disabled" ] = "";
    game[ "dialog" ][ "resurgence_ending" ] = "";
    game[ "dialog" ][ "last_man_standing" ] = "";
    game[ "dialog" ][ "resurgence_avenge_teammate" ] = "";
    game[ "dialog" ][ "resurgence_hunt_reminder" ] = "";
    game[ "dialog" ][ "resurgence_teammate_respawn" ] = "";
    game[ "dialog" ][ "resurgence_on_player_disconnect" ] = "";
    
    for ( i = 0; i < level.brgametype.var_fcfa11a2953947e3 ; i++ )
    {
        letter = level.brgametype.letters[ i ];
        var_973a305054b2ac4f = level.brgametype.var_3b03e05e711748e3[ i ];
        leaderdialogs[ "at" + letter ] = "at" + var_973a305054b2ac4f;
        leaderdialogs[ "ac" + letter ] = "ac" + var_973a305054b2ac4f;
        leaderdialogs[ "sc" + letter ] = "sc" + var_973a305054b2ac4f;
    }
    
    foreach ( key, value in leaderdialogs )
    {
        game[ "dialog" ][ key ] = value;
        game[ "dialog_prefix" ][ key ] = "dx_br_brzc_zoco_wzan_";
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xb44609f9, Offset: 0x1a14
// Size: 0x12e
function function_28aec95c8e28c840()
{
    level endon( #"game_ended" );
    level waittill( #"br_ready_to_jump" );
    
    foreach ( team in level.teamnamelist )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            player.radarmode = "slow_radar";
            player.skipuavupdate = 1;
        }
        
        setteamradar( team, 1 );
        setteamradarstrength( team, 1 );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x7a2b3f26, Offset: 0x1b4a
// Size: 0x38
function function_7c1e4bf9413886d5()
{
    if ( !isdefined( level.zonecontrol_bundle ) )
    {
        level.zonecontrol_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_zonecontrol" );
    }
    
    assert( level.zonecontrol_bundle, "<dev string:x8f>" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xecfc64fd, Offset: 0x1b8a
// Size: 0xb67
function function_646c40fa1e886b7e()
{
    level.brgametype.leaderteam = undefined;
    level.brgametype.var_6b6381c28148a048 = [];
    level.brgametype.teampoints = [];
    level.brgametype.var_88309885bbda1b58 = 0;
    level.brgametype.var_26875c92c15b38c9 = utility::function_edc4cc03e9e60b3e( @"hash_2ca9cc987f401338", level.zonecontrol_bundle.var_26875c92c15b38c9 );
    level.brgametype.var_9b7493680f7693ed = utility::function_edc4cc03e9e60b3e( @"hash_afe0ad16235c6390", level.zonecontrol_bundle.var_9356934c22c1dbbb );
    level.brgametype.var_8e6d3d96c5f72a05 = utility::function_edc4cc03e9e60b3e( @"hash_4f01d0b6c438cdfd", level.zonecontrol_bundle.var_3aab5eb4177d468a );
    level.brgametype.takeoverdelay = utility::function_edc4cc03e9e60b3e( @"hash_a0571b5581aac4ba", level.zonecontrol_bundle.takeoverdelay );
    level.brgametype.var_f5c20f652bf7dc0f = utility::function_edc4cc03e9e60b3e( @"hash_e1589d505ce76192", level.zonecontrol_bundle.var_f5c20f652bf7dc0f );
    level.brgametype.var_8091c0ed279e84f8 = level.brgametype.var_f5c20f652bf7dc0f > 1;
    level.brgametype.var_c44a4c0c38858ae3 = utility::function_edc4cc03e9e60b3e( @"hash_8564fd301e5235d6", level.zonecontrol_bundle.var_c44a4c0c38858ae3 );
    level.brgametype.var_613acf06bb2afb8e = utility::function_edc4cc03e9e60b3e( @"hash_bf61c823beacd1cb", level.zonecontrol_bundle.var_613acf06bb2afb8e );
    level.brgametype.var_d45bcb28473777b3 = utility::function_edc4cc03e9e60b3e( @"hash_d6f6d2ec934f23b3", level.zonecontrol_bundle.var_d45bcb28473777b3 );
    level.brgametype.var_421d2aa75becf29e = utility::function_edc4cc03e9e60b3e( @"hash_7efda168670cbd76", level.zonecontrol_bundle.var_421d2aa75becf29e );
    level.brgametype.var_2a5d9fd2b34be335 = utility::function_edc4cc03e9e60b3e( @"hash_d8d899b9d8d2af02", level.zonecontrol_bundle.var_ebf4f8eff801d373 );
    level.brgametype.overtimeduration = utility::function_edc4cc03e9e60b3e( @"hash_6d4c043f839d0769", level.zonecontrol_bundle.overtimeduration );
    level.brgametype.var_268d5d34b73476a4 = utility::function_edc4cc03e9e60b3e( @"hash_22339f5888777d4d", level.zonecontrol_bundle.var_268d5d34b73476a4 );
    level.brgametype.var_4ea524dc82389417 = utility::function_edc4cc03e9e60b3e( @"hash_792c00ab791748ff", level.zonecontrol_bundle.var_4ea524dc82389417 );
    level.brgametype.var_8825be0d95f46acf = utility::function_edc4cc03e9e60b3e( @"hash_1e53c26761c8caca", level.zonecontrol_bundle.var_8825be0d95f46acf );
    level.brgametype.var_54d1a3b3deced485 = utility::function_edc4cc03e9e60b3e( @"hash_bd2ad1874ddb4fe6", level.zonecontrol_bundle.var_a672fba9561cc409 );
    level.brgametype.var_29714c5c9f5c7be2 = function_1d363f74e2b8a73a();
    level.brgametype.var_415c210721d0daec = function_4575c5c7e7e82574();
    level.brgametype.var_ab40de3fc1e06240 = utility::function_edc4cc03e9e60b3e( @"hash_8b1077145e2c139", level.zonecontrol_bundle.var_7e703aeecd142657 );
    level.brgametype.var_f2d7791ac98a041b = utility::function_edc4cc03e9e60b3e( @"hash_3bf26249a54616b0", level.zonecontrol_bundle.var_f2d7791ac98a041b );
    level.brgametype.var_86fa3ba724755769 = utility::function_48f723fdc612ec65( @"hash_9b5ac8e85f9e02a", level.zonecontrol_bundle.var_d4f3828be275ae16 );
    level.brgametype.roundsdata = function_3be4d6c11c0b0863( level.zonecontrol_bundle.roundsdata );
    level.brgametype.roundscount = level.brgametype.roundsdata.size;
    level.brgametype.beforezoneactivationdelay = utility::function_edc4cc03e9e60b3e( @"hash_e562a3412034f9d5", level.zonecontrol_bundle.var_21ea4f1c1b60390d );
    level.brgametype.matchduration = function_1a26822db93e0caf();
    level.brgametype.var_891051eec61cfd2d = utility::function_edc4cc03e9e60b3e( @"hash_1d341d3600365498", level.zonecontrol_bundle.var_891051eec61cfd2d );
    level.brgametype.var_59e20095ea03a9c0 = utility::function_edc4cc03e9e60b3e( @"hash_7f61d5bfd6814ded", level.zonecontrol_bundle.var_59e20095ea03a9c0 );
    level.brgametype.var_9e848840769ab12c = function_d610260ae3dd8ecc();
    level.brgametype.var_7215bdc140ec4561 = [];
    level.brgametype.clusters = [];
    level.brgametype.letters = [ "a", "b", "c", "d", "e", "f", "g", "h" ];
    level.brgametype.var_3b03e05e711748e3 = [ "al", "br", "ch", "de", "ec", "fx", "go", "ho" ];
    level.brgametype.var_5788f6f826a95712 = utility::function_edc4cc03e9e60b3e( @"hash_39e5a4f1ba733c1f", level.zonecontrol_bundle.var_5788f6f826a95712 );
    level.brgametype.var_cd9843949dc5ac16 = utility::function_edc4cc03e9e60b3e( @"hash_a49776597b308f58", level.zonecontrol_bundle.var_38e1e941e8890bc9 );
    level.brgametype.var_8e11a23fd2d54bdb = utility::function_edc4cc03e9e60b3e( @"hash_ea138b5dad20e381", level.zonecontrol_bundle.var_a04c3357f2cf4348 );
    level.brgametype.var_ecf6c37d1dc3d7dc = utility::function_edc4cc03e9e60b3e( @"hash_c8f34fc25a965b7a", level.zonecontrol_bundle.var_709fc7a280cb6205 );
    level.brgametype.var_145e7fb4f53718f2 = utility::function_edc4cc03e9e60b3e( @"hash_cb5d885251e81b6a", level.zonecontrol_bundle.var_e0f768b47aa1e125 );
    level.brgametype.var_aa73e2aa12fcfd6f = utility::function_edc4cc03e9e60b3e( @"hash_1bc38baa909b90ef", level.zonecontrol_bundle.var_aeb48de79ddcb41c );
    level.brgametype.var_ae0144f0e7e3cc65 = utility::function_edc4cc03e9e60b3e( @"hash_19fda6a24870c61d", level.zonecontrol_bundle.var_fbaf2e1d40982556 );
    level.brgametype.var_e328bee5a35fa2d0 = utility::function_edc4cc03e9e60b3e( @"hash_c0f82f769f124250", level.zonecontrol_bundle.var_6148a6ac5882c9bf );
    level.brgametype.var_ea03bdd563ac6a00 = [];
    level.brgametype.var_c705f4a0d3395ca8 = function_1681c26f8e0d3048( level.zonecontrol_bundle.var_9dc24854dbcb4e60 );
    level.brgametype.var_b814b89099323daf = 1;
    level.brgametype.var_eb6bb120ed0fc29b = "zc_resurgence_respawn";
    level.brgametype.var_90ce4bd9339d98df = 0;
    setdvar( @"scr_br_magcount", 3 );
    level.brgametype.var_ede60d893b5c63db = utility::function_edc4cc03e9e60b3e( @"hash_a72912a60d67a816", level.zonecontrol_bundle.var_ede60d893b5c63db );
    level.brgametype.var_60b8cf489ad23d81 = utility::function_edc4cc03e9e60b3e( @"hash_2b6a5344f3239dbe", level.zonecontrol_bundle.var_60b8cf489ad23d81 );
    level.brgametype.var_176f1c4213142f8f = utility::function_edc4cc03e9e60b3e( @"hash_99b1db027dff38c6", level.zonecontrol_bundle.var_1cabb7e11544d3d7 );
    level.brgametype.var_905b2a8bfeb3d561 = utility::function_edc4cc03e9e60b3e( @"hash_1455d87aedbbb31a", level.zonecontrol_bundle.var_6ffaf5cf720f3d57 );
    level.brgametype.var_133de809c14cc8c5 = utility::function_edc4cc03e9e60b3e( @"hash_e6b26dd6c117e732", level.zonecontrol_bundle.var_133de809c14cc8c5 );
    level.brgametype.var_428c23a842f826a4 = utility::function_edc4cc03e9e60b3e( @"hash_a42a89c01b404460", level.zonecontrol_bundle.var_22b5403307c03651 );
    level.brgametype.var_c2906332d1ecf1b5 = utility::function_edc4cc03e9e60b3e( @"hash_8365ae49880f4b66", level.zonecontrol_bundle.var_2aa903f06e70921f );
    level.brgametype.var_9af355022a77c756 = utility::function_edc4cc03e9e60b3e( @"hash_cbef5b58a4b634c4", level.zonecontrol_bundle.var_9af355022a77c756 );
    level.brgametype.var_9f5bfb14b3a3056a = utility::function_edc4cc03e9e60b3e( @"hash_d2dc87d93a02c946", level.zonecontrol_bundle.var_9f5bfb14b3a3056a );
    level.brgametype.var_fdfb65e9b9a5f91b = 1;
    level.brgametype.var_6c04507ebf9c1226 = 1;
    level.brgametype.var_4eb9a38adad726dd = 1;
    level.brgametype.var_fdd9f6a1b4724bb3 = utility::function_edc4cc03e9e60b3e( @"hash_834aedb51e76fdf0", level.zonecontrol_bundle.var_fdd9f6a1b4724bb3 );
    level.brgametype.var_97e4272a1bb2acd1 = utility::function_edc4cc03e9e60b3e( @"hash_f3fe773700ec524c", level.zonecontrol_bundle.var_eb17453cf3330722 );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x192df8a, Offset: 0x26f9
// Size: 0x61
function function_977125ae85d8fcd3()
{
    level.var_f2092a97bd493b3c = [];
    function_db8c24ca0a918624( "zc_mvp", &function_9d769ac9e2516572 );
    function_db8c24ca0a918624( "zc_carrier", &function_3c20615a46c6abaa );
    function_db8c24ca0a918624( "zc_relentless", &function_d1a903a1bd90811c );
    function_db8c24ca0a918624( "zc_high_roller", &function_4d154dfad41fe8e6 );
    function_db8c24ca0a918624( "zc_conqueror", &function_33b7b749a3c1de6 );
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x60eab1a5, Offset: 0x2762
// Size: 0x59
function function_db8c24ca0a918624( accoladeref, statfunc )
{
    newaccolade = { #bestscore:0, #statfunc:statfunc, #ref:accoladeref };
    level.var_f2092a97bd493b3c[ level.var_f2092a97bd493b3c.size ] = newaccolade;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x81a08a98, Offset: 0x27c3
// Size: 0x201
function function_ec248c149ebf180e()
{
    foreach ( player in level.players )
    {
        foreach ( accolade in level.var_f2092a97bd493b3c )
        {
            val = player [[ accolade.statfunc ]]();
            
            if ( val > accolade.bestscore )
            {
                accolade.bestplayer = player;
                accolade.bestscore = val;
            }
        }
    }
    
    foreach ( accolade in level.var_f2092a97bd493b3c )
    {
        if ( accolade.bestplayer )
        {
            if ( !isdefined( accolade.bestplayer.var_f2092a97bd493b3c ) )
            {
                accolade.bestplayer.var_f2092a97bd493b3c = [];
            }
            
            accolade.bestplayer.var_f2092a97bd493b3c[ accolade.bestplayer.var_f2092a97bd493b3c.size ] = accolade.ref;
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8faafa9c, Offset: 0x29cc
// Size: 0x40
function function_13a528304b1edd59( player )
{
    if ( !isdefined( player.var_f2092a97bd493b3c ) || player.var_f2092a97bd493b3c.size == 0 )
    {
        return;
    }
    
    return utility::array_random( player.var_f2092a97bd493b3c );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x1d6ec3d9, Offset: 0x2a15
// Size: 0x15, Type: bool
function function_9d769ac9e2516572()
{
    return self.pers[ "score" ] ?? 0;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x7b3addd2, Offset: 0x2a33
// Size: 0xf, Type: bool
function function_3c20615a46c6abaa()
{
    return self.matchpoints ?? 0;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x66a2f38d, Offset: 0x2a4b
// Size: 0xf, Type: bool
function function_d1a903a1bd90811c()
{
    return self.longestscorestreak ?? 0;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x30324efe, Offset: 0x2a63
// Size: 0xf, Type: bool
function function_4d154dfad41fe8e6()
{
    return self.var_9b61e4a72e737e31 ?? 0;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x4f5b3b6, Offset: 0x2a7b
// Size: 0xf, Type: bool
function function_33b7b749a3c1de6()
{
    return self.var_58648101a675be11 ?? 0;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x94292065, Offset: 0x2a93
// Size: 0x296
function function_3be4d6c11c0b0863( roundsdata )
{
    var_bd313a05276c16d9 = getdvar( @"hash_7ac504394c8d315c", "" );
    var_293dff268925a354 = getdvar( @"hash_620ea132846d8b30", "" );
    var_e36a5dc404daaf1d = getdvar( @"hash_db8a7fa30e0130e7", "" );
    var_1c83a58a3ccfad06 = getdvar( @"hash_5d48b15a39d80e4e", "" );
    var_6c3c43c6f111d7f = getdvar( @"hash_9cd5c428deab91d7", "" );
    
    if ( var_bd313a05276c16d9 == "" && var_293dff268925a354 == "" && var_e36a5dc404daaf1d == "" && var_1c83a58a3ccfad06 == "" && var_6c3c43c6f111d7f == "" )
    {
        return roundsdata;
    }
    
    var_1b61d7c5855f00f9 = strtok( var_bd313a05276c16d9, " " );
    var_876839bcb3457e28 = strtok( var_293dff268925a354, " " );
    var_3218f93d22d89bd6 = strtok( var_e36a5dc404daaf1d, " " );
    var_2937e482fc9f5781 = strtok( var_1c83a58a3ccfad06, " " );
    var_dd5a115baeef6df4 = strtok( var_6c3c43c6f111d7f, " " );
    arrays = [ var_1b61d7c5855f00f9, var_876839bcb3457e28, var_3218f93d22d89bd6, var_2937e482fc9f5781, var_dd5a115baeef6df4 ];
    var_28052b9a16344a2 = function_92f4b96329ddf4a4( roundsdata.size, arrays );
    
    if ( var_28052b9a16344a2 )
    {
        var_c4bfd9f53255cb0b = [];
        
        for ( round = 0; round < var_28052b9a16344a2 ; round++ )
        {
            rounddata = { #var_63d8f059480ec646:var_dd5a115baeef6df4.size ? int( var_dd5a115baeef6df4[ round ] ) : roundsdata[ round ].var_63d8f059480ec646, #var_65f8b064a20c8871:var_2937e482fc9f5781.size ? int( var_2937e482fc9f5781[ round ] ) : roundsdata[ round ].var_65f8b064a20c8871, #zonescount:var_3218f93d22d89bd6.size ? int( var_3218f93d22d89bd6[ round ] ) : roundsdata[ round ].zonescount, #zonesduration:var_876839bcb3457e28.size ? int( var_876839bcb3457e28[ round ] ) : roundsdata[ round ].zonesduration, #zonesactivationdelay:var_1b61d7c5855f00f9.size ? int( var_1b61d7c5855f00f9[ round ] ) : roundsdata[ round ].zonesactivationdelay };
            var_c4bfd9f53255cb0b[ var_c4bfd9f53255cb0b.size ] = rounddata;
        }
        
        return var_c4bfd9f53255cb0b;
    }
    
    assertmsg( "<dev string:xb7>" );
    return roundsdata;
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x7d88b60, Offset: 0x2d31
// Size: 0xa7
function function_92f4b96329ddf4a4( basesize, arrays )
{
    countref = arrays[ 0 ].size > 0 ? arrays[ 0 ].size : basesize;
    
    foreach ( array in arrays )
    {
        if ( array.size != countref )
        {
            return 0;
        }
    }
    
    return countref;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x598e10c3, Offset: 0x2de1
// Size: 0xa5
function function_1a26822db93e0caf()
{
    matchduration = 0;
    
    foreach ( rounddata in level.brgametype.roundsdata )
    {
        matchduration += rounddata.zonesactivationdelay + rounddata.zonesduration;
    }
    
    return matchduration;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x42e053b6, Offset: 0x2e8f
// Size: 0x2b
function function_1d363f74e2b8a73a()
{
    var_29714c5c9f5c7be2 = getdvar( @"hash_28904496acb0d67f", "" );
    return strtok( var_29714c5c9f5c7be2, " " );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x7c41334f, Offset: 0x2ec3
// Size: 0x2b
function function_4575c5c7e7e82574()
{
    var_415c210721d0daec = getdvar( @"hash_1d1df0335cc35ef3", "" );
    return strtok( var_415c210721d0daec, " " );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xbccd4e65, Offset: 0x2ef7
// Size: 0x55
function function_d610260ae3dd8ecc()
{
    var_9e848840769ab12c = [];
    var_9e848840769ab12c[ "1" ] = { #multiplier:1, #name:"1" };
    var_9e848840769ab12c[ "2" ] = { #multiplier:2, #name:"2" };
    return var_9e848840769ab12c;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x6e654fdb, Offset: 0x2f55
// Size: 0x26c
function function_5ba14ad001285dd0()
{
    clusterscriptables = function_c5a8371fa1177437();
    assert( clusterscriptables.size > 0, "<dev string:xf3>" );
    level.brgametype.var_fcfa11a2953947e3 = 0;
    var_f92f703d45292e32 = function_53efa34859fadd9a();
    
    foreach ( clusterscriptable in clusterscriptables )
    {
        if ( arraycontains( level.brgametype.var_415c210721d0daec, clusterscriptable.targetname ) )
        {
            continue;
        }
        
        cluster = spawnstruct();
        cluster.var_be493d2e48b561a = clusterscriptable function_68ab97834772bf1c();
        assert( cluster.var_be493d2e48b561a.size >= level.brgametype.var_f2d7791ac98a041b, "<dev string:x128>" );
        cluster.zones = clusterscriptable function_231c49ded6b6bc3b();
        var_b52e77d1776a960e = cluster.zones.size;
        assert( var_b52e77d1776a960e >= var_f92f703d45292e32, "<dev string:x18a>" );
        cluster.name = clusterscriptable.target;
        cluster.origin = level.brgametype.var_fdd9f6a1b4724bb3 ? clusterscriptable.origin : function_e2b6e00195f9ec95( cluster.zones );
        level.brgametype.clusters[ cluster.name ] = cluster;
        level.brgametype.var_fcfa11a2953947e3 = max( level.brgametype.var_fcfa11a2953947e3, var_b52e77d1776a960e );
    }
    
    level.brgametype.var_fcfa11a2953947e3 = int( min( level.brgametype.var_fcfa11a2953947e3, var_f92f703d45292e32 ) );
    assert( level.brgametype.var_fcfa11a2953947e3 <= level.brgametype.letters.size );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x914dedb1, Offset: 0x31c9
// Size: 0xb5
function function_53efa34859fadd9a()
{
    maximumcount = 0;
    
    foreach ( rounddata in level.brgametype.roundsdata )
    {
        totalcount = rounddata.zonescount + rounddata.var_65f8b064a20c8871;
        
        if ( totalcount > maximumcount )
        {
            maximumcount = totalcount;
        }
    }
    
    return maximumcount;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xaaf073ca, Offset: 0x3287
// Size: 0x1d8
function function_b0a19ce79688f165()
{
    invalidclusters = [];
    ids = getdvar( @"hash_30c480d6c4bc482d", "" );
    
    if ( ids )
    {
        clusters = strtok( ids, " " );
        index = 0;
        
        foreach ( cluster in clusters )
        {
            if ( index < level.brgametype.roundscount && level.brgametype.clusters[ cluster ] )
            {
                level.brgametype.var_7215bdc140ec4561[ level.brgametype.var_7215bdc140ec4561.size ] = cluster;
            }
            
            index++;
        }
    }
    
    if ( level.brgametype.var_7215bdc140ec4561.size <= 0 )
    {
        level.brgametype.var_7215bdc140ec4561[ 0 ] = function_bd9cd17bc6510c09( randomint( level.brgametype.clusters.size ) );
    }
    
    for ( invalidclusters = function_121a7fe973916c51( invalidclusters ); level.brgametype.var_7215bdc140ec4561.size < level.brgametype.roundscount ; invalidclusters = function_121a7fe973916c51( invalidclusters ) )
    {
        level.brgametype.var_7215bdc140ec4561[ level.brgametype.var_7215bdc140ec4561.size ] = function_7c3b9c16c27f212( invalidclusters );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x242268f8, Offset: 0x3467
// Size: 0xb4
function function_bd9cd17bc6510c09( fakeindex )
{
    iteration = 0;
    
    foreach ( cluster in level.brgametype.clusters )
    {
        if ( iteration == fakeindex )
        {
            return cluster.name;
        }
        
        iteration++;
    }
    
    assert( "<dev string:x204>" );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xf4d0d14d, Offset: 0x3523
// Size: 0x60
function function_e2b6e00195f9ec95( zones )
{
    origin = ( 0, 0, 0 );
    
    if ( zones.size == 0 )
    {
        return origin;
    }
    
    for ( i = 0; i < zones.size ; i++ )
    {
        origin += zones[ i ].origin;
    }
    
    return origin / zones.size;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xe8991efa, Offset: 0x358c
// Size: 0x64
function function_121a7fe973916c51( invalidclusters )
{
    invalidclusters[ invalidclusters.size ] = level.brgametype.var_7215bdc140ec4561[ level.brgametype.var_7215bdc140ec4561.size - 1 ];
    
    if ( invalidclusters.size > level.brgametype.var_f2d7791ac98a041b )
    {
        invalidclusters[ 0 ] = undefined;
        function_cdc669dbc8ea2101( invalidclusters );
    }
    
    return invalidclusters;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xe8c7849f, Offset: 0x35f9
// Size: 0xa9
function function_7c3b9c16c27f212( invalidclusters )
{
    var_415a0d4a4a133940 = level.brgametype.var_7215bdc140ec4561[ level.brgametype.var_7215bdc140ec4561.size - 1 ];
    var_1c05552b884f7326 = level.brgametype.clusters[ var_415a0d4a4a133940 ].var_be493d2e48b561a;
    var_1c05552b884f7326 = arrayremove( var_1c05552b884f7326, invalidclusters );
    assert( var_1c05552b884f7326.size > 0, "<dev string:x227>" );
    var_f21a29e80c688a6e = randomint( var_1c05552b884f7326.size );
    nextqueueindex = var_1c05552b884f7326[ var_f21a29e80c688a6e ];
    return nextqueueindex;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xfe4492f3, Offset: 0x36ab
// Size: 0x1e
function brzonecontrol_onplayerdisconnect( player )
{
    function_6d711cb59a8582ec( player.team );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xb7e75941, Offset: 0x36d1
// Size: 0x68
function brzonecontrol_onplayerconnect( player )
{
    player.matchpoints = 0;
    player.pointsmultiplier = 1;
    player.scorestreak = 0;
    player.longestscorestreak = 0;
    player.var_9b61e4a72e737e31 = 0;
    player.var_58648101a675be11 = 0;
    player.var_661d033860ba7bd = 0;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xd33b4f53, Offset: 0x3741
// Size: 0x86
function function_c84e438a6867426c()
{
    foreach ( team in level.teamnamelist )
    {
        function_6d711cb59a8582ec( team, 1 );
        function_4fa780c42169e9e( team );
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0xc10e6e7, Offset: 0x37cf
// Size: 0x131
function function_6d711cb59a8582ec( team, isinitupdate )
{
    if ( level.brgametype.var_8091c0ed279e84f8 == 0 || teams::getteamcount( team ) == 0 )
    {
        return;
    }
    
    var_f0b8926e11571273 = [];
    teamplayers = teams::getteamdata( team, "players" );
    teamplayers = function_5713d46873b29625( teamplayers );
    
    if ( teamplayers.size != 1 )
    {
        return;
    }
    
    player = teamplayers[ 0 ];
    var_f0b8926e11571273[ var_f0b8926e11571273.size ] = player;
    player.pointsmultiplier = level.brgametype.var_f5c20f652bf7dc0f;
    
    foreach ( player in var_f0b8926e11571273 )
    {
        player hud_message::showsplash( "zc_smateleft" );
        
        if ( !isinitupdate )
        {
            level thread br_public::brleaderdialog( "squadmate_left", undefined, [ player ], 0, 1, undefined );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x113ebe3e, Offset: 0x3908
// Size: 0xb6
function function_76c3826d9be881c4( players )
{
    topscore = 0;
    topplayer = undefined;
    
    foreach ( player in players )
    {
        if ( !topplayer || player.matchpoints > topscore )
        {
            topplayer = player;
            topscore = player.matchpoints;
        }
    }
    
    return topplayer;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x9f3e3efa, Offset: 0x39c7
// Size: 0x9e
function function_cf804ff492926a08()
{
    foreach ( teamname in level.teamnamelist )
    {
        if ( teams::getteamcount( teamname ) == 0 )
        {
            continue;
        }
        
        rank = function_b0c78c44ae3c0d9f( teamname );
        function_e5cda1e38fbd50c3( teamname, rank );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x5ecc9ee8, Offset: 0x3a6d
// Size: 0xe9
function function_b0c78c44ae3c0d9f( team )
{
    rank = 1;
    score = brzonecontrol_getteamscore( team );
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( team == teamname || teams::getteamcount( teamname ) == 0 )
        {
            continue;
        }
        
        teamscore = brzonecontrol_getteamscore( teamname );
        
        if ( teamscore > score )
        {
            rank++;
        }
    }
    
    if ( rank == 1 && !function_2794703e85055cba( team ) )
    {
        rank = 2;
    }
    
    return rank;
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x81adf9eb, Offset: 0x3b5f
// Size: 0x9f
function function_e5cda1e38fbd50c3( team, rank )
{
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        player function_d923e350504fd625( rank );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xb0d67f61, Offset: 0x3c06
// Size: 0x7b
function function_cee18e6cd6b5b2b()
{
    foreach ( player in level.players )
    {
        player function_7e0d8ab999b0b096();
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x96847e87, Offset: 0x3c89
// Size: 0x318
function function_8bd7508a5e31b0d7()
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    clusterindex = 0;
    level.brgametype.var_b083451483a7abaa = clusterindex;
    function_b2c6c0054677f1af( level.brgametype.var_7215bdc140ec4561[ clusterindex ], clusterindex );
    function_1faec95992788262( "active" );
    flags::gameflagwait( "infil_animatic_complete" );
    thread function_c84e438a6867426c();
    function_a9c5d65649c975c4();
    thread function_3b133e7bf4f7d4d6( level.brgametype.matchduration + level.brgametype.var_86fa3ba724755769 );
    thread function_f0753f58d7d28578();
    thread function_40dbd89e0276ab01( level.brgametype.var_86fa3ba724755769 + level.brgametype.roundsdata[ clusterindex ].zonesactivationdelay );
    wait level.brgametype.var_86fa3ba724755769;
    function_1faec95992788262( "current" );
    level thread br_public::brleaderdialog( "objective_desc", undefined, undefined, 1, 2, undefined );
    
    while ( true )
    {
        level waittill( #"hash_3d166a8c6c0aa7f7" );
        level thread br_public::brleaderdialog( "zone_activation", undefined, undefined, 1, 0, undefined );
        function_98fc74bcdca6c506( "uin_iw9_lockdown_zone_unlock" );
        function_bbb5aad6741b533d();
        function_305bd527b7150c67();
        function_c53fdb3745db23e2();
        level.brgametype.var_b083451483a7abaa = clusterindex;
        thread function_3619b4ef26f50f63( level.brgametype.roundsdata[ clusterindex ].zonesduration, 0 );
        clusterindex++;
        
        if ( clusterindex == level.brgametype.var_7215bdc140ec4561.size )
        {
            break;
        }
        
        level waittill( #"hash_8eb3f1d99c39fe02" );
        function_b2c6c0054677f1af( level.brgametype.var_7215bdc140ec4561[ clusterindex ], clusterindex );
        function_e0b154b6074c0d86( "uin_iw9_lockdown_zone_unlocked_ping", level.brgametype.var_7215bdc140ec4561[ clusterindex ] );
        hud_util::showsplashtoall( "zc_zone_spawned" );
        level.brgametype.var_926c40d6006adfed = 1;
        
        if ( level.brgametype.beforezoneactivationdelay > 0 )
        {
            level waittill( #"hash_7d1aef19582db5b1" );
        }
        
        if ( clusterindex < level.brgametype.var_7215bdc140ec4561.size )
        {
            level thread br_public::brleaderdialog( "zone_deactivation", undefined, undefined, 1, 0, undefined );
            function_e0b154b6074c0d86( "uin_iw9_lockdown_zone_deactivated_ping", level.brgametype.var_7215bdc140ec4561[ clusterindex ] );
            function_98fc74bcdca6c506( "uin_iw9_lockdown_round_completed" );
        }
        
        function_980106c72012b616();
        function_46475ff8d5ba241b( level.brgametype.activezones );
        level.brgametype.var_926c40d6006adfed = 0;
        thread function_40dbd89e0276ab01( level.brgametype.roundsdata[ clusterindex ].zonesactivationdelay );
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x65e440ca, Offset: 0x3fa9
// Size: 0x2f
function function_b2c6c0054677f1af( clusterindex, roundindex )
{
    function_a9d74fbdf4b5661c( clusterindex, roundindex );
    function_932e3017ac6e3c9b();
    function_2341b1c101cdfc02( clusterindex );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x99d6262, Offset: 0x3fe0
// Size: 0x10e
function function_95b185caffd6f8f2()
{
    backgroundtype = 9;
    
    for ( i = 0; i < level.brgametype.var_fcfa11a2953947e3 ; i++ )
    {
        suffix = level.brgametype.letters[ i ];
        gamelogic_mp::setwaypointiconinfo( "zc_waypoint_lock_" + suffix, backgroundtype, "neutral", "MP_INGAME_ONLY/OBJ_ZC_LOCKED_CAPS", "icon_waypoint_lock_" + suffix, 0 );
        gamelogic_mp::setwaypointiconinfo( "zc_waypoint_defending_" + suffix, backgroundtype, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_" + suffix, 0 );
        gamelogic_mp::setwaypointiconinfo( "zc_waypoint_losing_" + suffix, backgroundtype, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + suffix, 0 );
        gamelogic_mp::setwaypointiconinfo( "zc_waypoint_contested_" + suffix, backgroundtype, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_" + suffix, 0 );
        gamelogic_mp::setwaypointiconinfo( "zc_waypoint_neutral_" + suffix, backgroundtype, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + suffix, 0 );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x9c1d6100, Offset: 0x40f6
// Size: 0x109
function function_2341b1c101cdfc02( clusterindex )
{
    if ( !level.brgametype.var_5788f6f826a95712 )
    {
        return;
    }
    
    objidnum = objidpoolmanager::requestobjectiveid( 99 );
    clusterorigin = level.brgametype.clusters[ clusterindex ].origin;
    objidpoolmanager::objective_add_objective( objidnum, "invisible", clusterorigin, "hud_icon_objective_zclock", "icon_medium" );
    objidpoolmanager::update_objective_setbackground( objidnum, 1 );
    objidpoolmanager::update_objective_ownerteam( objidnum, undefined );
    function_24edb8a97f6832f0( objidnum, 1 );
    objective_setshowdistance( objidnum, 1 );
    objective_sethideelevation( objidnum, 1 );
    objective_setshowoncompass( objidnum, 0 );
    function_ac9886e0e2860e18( objidnum, level.brgametype.var_cd9843949dc5ac16, level.brgametype.var_8e11a23fd2d54bdb );
    objective_setplayintro( objidnum, 1 );
    objidpoolmanager::objective_playermask_showtoall( objidnum );
    level.brgametype.var_ed872ebe4c0a6487 = objidnum;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xbef51d5d, Offset: 0x4207
// Size: 0x73
function function_bbb5aad6741b533d()
{
    if ( !level.brgametype.var_5788f6f826a95712 )
    {
        return;
    }
    
    level.brgametype.var_c3be220a25358dbf = level.brgametype.var_ed872ebe4c0a6487;
    level.brgametype.var_ed872ebe4c0a6487 = undefined;
    objidpoolmanager::update_objective_icon( level.brgametype.var_c3be220a25358dbf, "hud_icon_objective_cluster" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x7d98088c, Offset: 0x4282
// Size: 0x47
function function_980106c72012b616()
{
    if ( !level.brgametype.var_5788f6f826a95712 )
    {
        return;
    }
    
    objidpoolmanager::returnobjectiveid( level.brgametype.var_c3be220a25358dbf );
    level.brgametype.var_c3be220a25358dbf = undefined;
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x1245e425, Offset: 0x42d1
// Size: 0x36d
function function_a9d74fbdf4b5661c( clusterindex, roundindex )
{
    level.brgametype.var_c30b87d8e2392ca8 = [];
    cluster = level.brgametype.clusters[ clusterindex ];
    clusterzones = cluster.zones;
    
    /#
        if ( getdvarint( @"hash_333139864c70cc89", 0 ) == 1 )
        {
            foreach ( zone in clusterzones )
            {
                zone.var_e836c2cae9ee1657 = level.brgametype.var_9e848840769ab12c[ "<dev string:x241>" ];
                level.brgametype.var_c30b87d8e2392ca8[ level.brgametype.var_c30b87d8e2392ca8.size ] = zone;
            }
            
            level.brgametype.var_c3682fea0d4dc85a = [];
            return;
        }
    #/
    
    rounddata = level.brgametype.roundsdata[ roundindex ];
    zonescount = rounddata.zonescount;
    assert( zonescount > 0, "<dev string:x243>" );
    assert( clusterzones.size >= zonescount, "<dev string:x264>" + clusterzones.size + "<dev string:x285>" + zonescount + "<dev string:x297>" );
    var_65f8b064a20c8871 = rounddata.var_65f8b064a20c8871;
    assert( zonescount + var_65f8b064a20c8871 <= level.brgametype.letters.size, "<dev string:x2c4>" + zonescount + "<dev string:x2e7>" + var_65f8b064a20c8871 + "<dev string:x300>" );
    var_43d8f8b65e5eb16a = int( zonescount / 2 );
    var_d872d0ef3fee7354 = zonescount - var_43d8f8b65e5eb16a;
    initialzoneindex = randomint( clusterzones.size );
    var_18bfd5390c0915b7 = cluster function_b0aef598d1bf20e7( cluster.zones[ initialzoneindex ].origin, level.brgametype.var_54d1a3b3deced485 );
    var_cb4b49a42fc4c67b = cluster function_2aee46b5a4f51295( var_18bfd5390c0915b7, undefined, var_43d8f8b65e5eb16a );
    var_a57ed72e1463e605 = cluster function_2aee46b5a4f51295( initialzoneindex, var_cb4b49a42fc4c67b, var_d872d0ef3fee7354 );
    nextzones = arraycombine( var_cb4b49a42fc4c67b, var_a57ed72e1463e605 );
    var_938b9d4ab2c50d7c = 0;
    
    for ( i = 0; i < zonescount ; i++ )
    {
        if ( var_938b9d4ab2c50d7c >= nextzones.size )
        {
            break;
        }
        
        zone = nextzones[ var_938b9d4ab2c50d7c ];
        zone.letter = level.brgametype.letters[ var_938b9d4ab2c50d7c ];
        zone.var_e836c2cae9ee1657 = level.brgametype.var_9e848840769ab12c[ "1" ];
        level.brgametype.var_c30b87d8e2392ca8[ level.brgametype.var_c30b87d8e2392ca8.size ] = zone;
        var_938b9d4ab2c50d7c++;
    }
    
    var_65f8b064a20c8871 = rounddata.var_65f8b064a20c8871;
    function_9005a8e618af6685( initialzoneindex, cluster, var_938b9d4ab2c50d7c, var_65f8b064a20c8871 );
}

// Namespace br_gametype_zonecontrol
// Params 4
// Checksum 0xaa1a61e1, Offset: 0x4646
// Size: 0x14a
function function_9005a8e618af6685( zoneindex, cluster, lettersindex, var_65f8b064a20c8871 )
{
    level.brgametype.var_c3682fea0d4dc85a = [];
    
    if ( var_65f8b064a20c8871 == 0 )
    {
        return;
    }
    
    var_c3682fea0d4dc85a = cluster function_2aee46b5a4f51295( zoneindex, level.brgametype.var_c30b87d8e2392ca8, var_65f8b064a20c8871 );
    
    foreach ( zone in var_c3682fea0d4dc85a )
    {
        zone.letter = level.brgametype.letters[ lettersindex ];
        zone.var_e836c2cae9ee1657 = level.brgametype.var_9e848840769ab12c[ "2" ];
        level.brgametype.var_c3682fea0d4dc85a[ level.brgametype.var_c3682fea0d4dc85a.size ] = zone;
        lettersindex++;
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x1e5c766f, Offset: 0x4798
// Size: 0xa6
function function_1faec95992788262( newstate )
{
    foreach ( zone in level.brgametype.var_c30b87d8e2392ca8 )
    {
        if ( zone.objidnum )
        {
            objective_state( zone.objidnum, newstate );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x13e5af89, Offset: 0x4846
// Size: 0xc2
function function_305bd527b7150c67( zones )
{
    level.brgametype.activezones = level.brgametype.var_c30b87d8e2392ca8;
    
    foreach ( zone in level.brgametype.activezones )
    {
        zone function_fdcdef5e0b7ac9da();
    }
    
    hud_util::showsplashtoall( "zc_zone_activated" );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x90cb828e, Offset: 0x4910
// Size: 0x238
function function_46475ff8d5ba241b( zones )
{
    foreach ( zone in zones )
    {
        if ( zone.objidnum )
        {
            level callback::callback( #"hash_d280a4114456eaae", { #zone:zone } );
            
            foreach ( player in zone.players )
            {
                objidpoolmanager::objective_unpin_player( zone.objidnum, player, 1 );
                
                if ( player.var_b5d437dfc1d85c31 == 1 )
                {
                    player.var_b5d437dfc1d85c31 = 0;
                    player function_9bfc7816d33741a6( player.var_b5d437dfc1d85c31 );
                    player function_e59f310d36a9173c( 0 );
                    player function_1085623b4243b0f1( 0 );
                }
            }
            
            if ( zone.var_e836c2cae9ee1657.name == "2" )
            {
                function_c97f0baa8ba1ccc6( zone.objidnum, "icon_waypoint_base_empty" );
                waitframe();
            }
            
            zone function_71802e0968524d2b();
            objidpoolmanager::returnobjectiveid( zone.objidnum );
            zone.objidnum = undefined;
        }
        
        zone.var_e836c2cae9ee1657 = undefined;
        zone.players = undefined;
        zone.vehicles = undefined;
        zone.var_659a99ca66a4b8ff = undefined;
        zone.owner = undefined;
        zone.previousowner = undefined;
        zone.isactive = 0;
        zone.islock = 0;
        zone function_c0ef94abafeaeb2b();
        zone notify( #"deactivate_zone" );
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x8d2aa2c4, Offset: 0x4b50
// Size: 0x8f
function function_8ee2d4f91915a584( roundduration, rounddata )
{
    if ( rounddata.var_65f8b064a20c8871 <= 0 || level.brgametype.isovertime )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"overtime" );
    level endon( #"hash_7d1aef19582db5b1" );
    eventduration = 4 + rounddata.var_63d8f059480ec646;
    
    if ( eventduration >= roundduration )
    {
        return;
    }
    
    wait roundduration - eventduration;
    function_ed4e9a0dd63a73bd();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x7067dfbf, Offset: 0x4be7
// Size: 0x85
function function_932e3017ac6e3c9b()
{
    foreach ( zone in level.brgametype.var_c30b87d8e2392ca8 )
    {
        zone function_6ca3bc896c83a061();
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x8e6a7490, Offset: 0x4c74
// Size: 0x4a
function function_ed4e9a0dd63a73bd()
{
    if ( !level.brgametype.var_c3682fea0d4dc85a )
    {
        return;
    }
    
    hud_util::showsplashtoall( "zc_extra_zones" );
    wait 4;
    level thread br_public::brleaderdialog( "high_value_zone", undefined, level.players, 0, 0, undefined );
    function_a06fa1914f5015f();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x11cfbb40, Offset: 0x4cc6
// Size: 0xb9
function function_a06fa1914f5015f()
{
    foreach ( zone in level.brgametype.var_c3682fea0d4dc85a )
    {
        zone function_6ca3bc896c83a061();
        zone function_fdcdef5e0b7ac9da();
        level.brgametype.activezones[ level.brgametype.activezones.size ] = zone;
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x1cc95bcc, Offset: 0x4d87
// Size: 0x132
function function_3619b4ef26f50f63( time, timertype )
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    brzonecontrol_settimer( time, timertype );
    thread function_8ee2d4f91915a584( time, level.brgametype.roundsdata[ level.brgametype.var_b083451483a7abaa ] );
    thread function_30681ecaadc8f6c( time );
    thread function_58c8e53ac67fe848( time, timertype );
    var_2e5c3330e3adc81d = level.brgametype.var_b083451483a7abaa < level.brgametype.var_7215bdc140ec4561.size && time > 16 && timertype != 2;
    
    if ( var_2e5c3330e3adc81d )
    {
        thread function_f47b30962145ed06( time );
    }
    
    var_dd14ba68bb870cc3 = min( level.brgametype.beforezoneactivationdelay, time );
    wait time - var_dd14ba68bb870cc3;
    level notify( #"hash_8eb3f1d99c39fe02" );
    wait var_dd14ba68bb870cc3;
    function_d10f091cf2ac7fbe( level.brgametype.var_b083451483a7abaa );
    level notify( #"hash_7d1aef19582db5b1" );
    function_cee18e6cd6b5b2b();
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x4a2fe45e, Offset: 0x4ec1
// Size: 0x53
function function_30681ecaadc8f6c( time )
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    level endon( #"hash_7d1aef19582db5b1" );
    
    while ( time > 1 )
    {
        function_4d84dfae3600e6b5();
        wait 1;
        time--;
        level.roundtimeremaining = time;
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xcf7d512c, Offset: 0x4f1c
// Size: 0x1c, Type: bool
function brzonecontrol_dontconsiderafk( params )
{
    if ( self.zone )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x59c9e7b0, Offset: 0x4f41
// Size: 0x2f
function function_a9c5d65649c975c4()
{
    level.brgametype.starttime = gettime();
    level.brgametype.addedtime = 0;
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0xc98cb334, Offset: 0x4f78
// Size: 0x7a
function brzonecontrol_settimer( time, type )
{
    level.brgametype.addedtime += time;
    
    if ( isdefined( type ) )
    {
        function_5850370f4c35f688( type );
        
        if ( type == 2 )
        {
            thread function_39cd010d52cf2fbe( time );
            return;
        }
    }
    
    function_1845e8b110eac2db( level.brgametype.addedtime );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x43279081, Offset: 0x4ffa
// Size: 0x6b
function function_40dbd89e0276ab01( time )
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    brzonecontrol_settimer( time, 1 );
    
    if ( time > 16 )
    {
        anticipationdelay = time - 16;
        level thread br_public::brleaderdialog( "activation_anticipation", undefined, undefined, 1, anticipationdelay, undefined );
    }
    
    wait time;
    level notify( #"hash_3d166a8c6c0aa7f7" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xbc57030e, Offset: 0x506d
// Size: 0x86
function function_f0753f58d7d28578()
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    wait level.brgametype.matchduration + level.brgametype.var_86fa3ba724755769 - level.brgametype.var_9af355022a77c756;
    level thread br_public::brleaderdialog( "match_end_soon", undefined, undefined, 1, 0, undefined );
    wait level.brgametype.var_9af355022a77c756;
    function_dd3365ef6c44c6d8( 1 );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x3bf79412, Offset: 0x50fb
// Size: 0x377
function function_1681c26f8e0d3048( var_2db5dfbd9bfe1298 )
{
    var_c705f4a0d3395ca8 = [];
    
    foreach ( resurgencedata in var_2db5dfbd9bfe1298 )
    {
        timerdata = function_d32c17a67064a5d8( resurgencedata.milestone, resurgencedata.quadstimer, resurgencedata.triostimer, resurgencedata.duostimer, resurgencedata.solostimer );
        var_c705f4a0d3395ca8[ var_c705f4a0d3395ca8.size ] = timerdata;
    }
    
    var_7e66cd1c197a3b7d = getdvar( @"hash_4fddbfb63e4afffa", "" );
    var_902955d6a5801ddc = getdvar( @"hash_160ec17f1e8ac9c1", "" );
    var_1bd6354382a2fc47 = getdvar( @"hash_7dc38c428e8bdd42", "" );
    var_90a7de9d0651e7f1 = getdvar( @"hash_46a4356e51d99b2e", "" );
    var_c2fcebf7da4efefc = getdvar( @"hash_ccc152e2ce3af431", "" );
    
    if ( var_7e66cd1c197a3b7d == "" && var_902955d6a5801ddc == "" && var_1bd6354382a2fc47 == "" && var_90a7de9d0651e7f1 == "" && var_c2fcebf7da4efefc == "" )
    {
        return var_c705f4a0d3395ca8;
    }
    
    var_eda4acfe56ca480d = strtok( var_7e66cd1c197a3b7d, " " );
    var_1154b81d3db6b17e = strtok( var_902955d6a5801ddc, " " );
    var_b8c1373d8b71fef3 = strtok( var_1bd6354382a2fc47, " " );
    var_d15fce260e60b201 = strtok( var_90a7de9d0651e7f1, " " );
    var_5d621726964bbb1e = strtok( var_c2fcebf7da4efefc, " " );
    arrays = [ var_eda4acfe56ca480d, var_1154b81d3db6b17e, var_b8c1373d8b71fef3, var_d15fce260e60b201, var_5d621726964bbb1e ];
    var_28052b9a16344a2 = function_92f4b96329ddf4a4( var_c705f4a0d3395ca8.size, arrays );
    
    if ( var_28052b9a16344a2 )
    {
        var_2329aca0d508ea38 = [];
        
        for ( i = 0; i < var_28052b9a16344a2 ; i++ )
        {
            milestone = var_eda4acfe56ca480d.size ? float( var_eda4acfe56ca480d[ i ] ) : var_c705f4a0d3395ca8[ i ].milestone;
            quadsvalue = var_1154b81d3db6b17e.size ? float( var_1154b81d3db6b17e[ i ] ) : var_c705f4a0d3395ca8[ i ].respawntimes[ "_quads" ];
            triosvalue = var_b8c1373d8b71fef3.size ? float( var_b8c1373d8b71fef3[ i ] ) : var_c705f4a0d3395ca8[ i ].respawntimes[ "_trios" ];
            duosvalue = var_d15fce260e60b201.size ? float( var_d15fce260e60b201[ i ] ) : var_c705f4a0d3395ca8[ i ].respawntimes[ "_duos" ];
            solosvalue = var_5d621726964bbb1e.size ? float( var_5d621726964bbb1e[ i ] ) : var_c705f4a0d3395ca8[ i ].respawntimes[ "_solos" ];
            timerdata = function_d32c17a67064a5d8( milestone, quadsvalue, triosvalue, duosvalue, solosvalue );
            var_2329aca0d508ea38[ var_2329aca0d508ea38.size ] = timerdata;
        }
        
        return var_2329aca0d508ea38;
    }
    
    assertmsg( "<dev string:x326>" );
    return var_c705f4a0d3395ca8;
}

// Namespace br_gametype_zonecontrol
// Params 5
// Checksum 0xdfac6c10, Offset: 0x547a
// Size: 0xa4
function function_d32c17a67064a5d8( milestone, quadsvalue, triosvalue, duosvalue, solosvalue )
{
    respawntimes = [];
    respawntimes[ "_quads" ] = int( quadsvalue );
    respawntimes[ "_trios" ] = int( triosvalue );
    respawntimes[ "_duos" ] = int( duosvalue );
    respawntimes[ "_solos" ] = int( solosvalue );
    return { #respawntimes:respawntimes, #milestone:float( milestone ) * level.brgametype.var_26875c92c15b38c9 };
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x50568cdb, Offset: 0x5527
// Size: 0x16a
function function_4fa780c42169e9e( team )
{
    if ( teams::getteamcount( team ) == 0 )
    {
        return;
    }
    
    var_e01aecffec1634ac = function_12dfcd8d63d2ef26( team );
    
    if ( var_e01aecffec1634ac == level.brgametype.var_c705f4a0d3395ca8.size - 1 )
    {
        return;
    }
    
    teamscore = level.brgametype.teampoints[ team ];
    var_f4d1827112ad9433 = var_e01aecffec1634ac;
    
    if ( teamscore >= level.brgametype.var_c705f4a0d3395ca8[ var_e01aecffec1634ac + 1 ].milestone )
    {
        var_f4d1827112ad9433 = var_e01aecffec1634ac + 1;
    }
    
    if ( !isdefined( level.brgametype.var_ea03bdd563ac6a00[ team ] ) )
    {
        level.brgametype.var_ea03bdd563ac6a00[ team ] = spawnstruct();
    }
    
    if ( !level.brgametype.var_ea03bdd563ac6a00[ team ].timerindex || var_e01aecffec1634ac != var_f4d1827112ad9433 )
    {
        level.brgametype.var_ea03bdd563ac6a00[ team ].timerindex = var_f4d1827112ad9433;
        level.brgametype.var_ea03bdd563ac6a00[ team ].respawntimes = level.brgametype.var_c705f4a0d3395ca8[ var_f4d1827112ad9433 ].respawntimes;
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x2f3c3ec0, Offset: 0x5699
// Size: 0x47
function function_12dfcd8d63d2ef26( team )
{
    if ( level.brgametype.var_ea03bdd563ac6a00[ team ] )
    {
        return level.brgametype.var_ea03bdd563ac6a00[ team ].timerindex;
    }
    
    return 0;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x3c067b61, Offset: 0x56e9
// Size: 0xb3
function function_9ecf56bef7f4ef5()
{
    foreach ( teamname in level.teamnamelist )
    {
        if ( teams::getteamcount( teamname ) == 0 )
        {
            continue;
        }
        
        if ( !isdefined( level.brgametype.teampoints[ teamname ] ) )
        {
            level.brgametype.teampoints[ teamname ] = 0;
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x51cd4ef2, Offset: 0x57a4
// Size: 0x25a
function function_4d84dfae3600e6b5()
{
    foreach ( zone in level.brgametype.activezones )
    {
        var_d276411e0e036b5e = zone function_372e98865ecd0b00();
        
        if ( zone.state != "occupied" )
        {
            continue;
        }
        
        var_d44337046f8d5216 = 0;
        var_a604811912dece2b = zone function_573103d6898027b4( level.brgametype.var_9b7493680f7693ed );
        var_465b8c15c7d5d2e4 = var_a604811912dece2b;
        pointssource = zone.var_e836c2cae9ee1657.name == "2" ? "highValueZone" : "normalZone";
        
        if ( var_d276411e0e036b5e )
        {
            var_a604811912dece2b += level.brgametype.var_c44a4c0c38858ae3;
        }
        
        foreach ( player in zone.players )
        {
            playerscore = player function_20f85f1629dfb2dd( var_a604811912dece2b, zone );
            
            if ( var_d276411e0e036b5e )
            {
                player function_e8d280f836a1339f( zone );
            }
            
            if ( playerscore > var_a604811912dece2b )
            {
                var_a604811912dece2b = playerscore;
            }
            
            player.var_661d033860ba7bd++;
            player.objectivescore = player.var_661d033860ba7bd;
        }
        
        function_9f2b86c8803611de( zone.players[ 0 ].team, var_465b8c15c7d5d2e4, pointssource );
        brzonecontrol_giveteampoints( zone.players[ 0 ].team, var_a604811912dece2b );
        var_d44337046f8d5216 += var_a604811912dece2b;
        zone function_41d03ae8d3eb01ed( var_d44337046f8d5216 );
    }
    
    function_22b60856dfb70b71();
    function_cf804ff492926a08();
    function_dd3365ef6c44c6d8();
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x19cc1b6, Offset: 0x5a06
// Size: 0xf1
function brzonecontrol_giveteampoints( team, points )
{
    if ( !team )
    {
        return;
    }
    
    score = brzonecontrol_getteamscore( team ) + points;
    level.brgametype.teampoints[ team ] = score;
    
    foreach ( player in level.players )
    {
        if ( player.team == team )
        {
            player function_d4c5b95dad2ed752( score );
        }
        
        player function_99ea746a5409671d( player.team );
    }
    
    function_4fa780c42169e9e( team );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x73a008b3, Offset: 0x5aff
// Size: 0x3f
function brzonecontrol_getteamscore( team )
{
    return level.brgametype.teampoints[ team ] ? level.brgametype.teampoints[ team ] : 0;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x4811d18e, Offset: 0x5b47
// Size: 0x281
function function_8fda175650d99e4( team )
{
    if ( level.brgametype.var_c44a4c0c38858ae3 == 0 )
    {
        return;
    }
    
    teamplayers = function_5713d46873b29625( teams::getteamdata( team, "players" ) );
    zones = arraycombine( level.brgametype.activezones, level.brgametype.var_c30b87d8e2392ca8 );
    
    foreach ( zone in zones )
    {
        if ( !zone.players )
        {
            continue;
        }
        
        var_957293701cbdc8f2 = arrayintersection( teamplayers, zone.players );
        
        foreach ( player in var_957293701cbdc8f2 )
        {
            var_81116eb73631d204 = zone.state == "occupied" && var_957293701cbdc8f2.size > 1;
            var_b5d437dfc1d85c31 = var_81116eb73631d204 ? 1 : 0;
            
            if ( player.var_b5d437dfc1d85c31 != var_b5d437dfc1d85c31 )
            {
                player.var_b5d437dfc1d85c31 = var_b5d437dfc1d85c31;
                player function_9bfc7816d33741a6( player.var_b5d437dfc1d85c31 );
            }
            
            teamplayers = arrayremove( teamplayers, player );
            
            if ( teamplayers.size == 0 )
            {
                return;
            }
        }
    }
    
    foreach ( player in teamplayers )
    {
        if ( player.var_b5d437dfc1d85c31 == 1 )
        {
            player.var_b5d437dfc1d85c31 = 0;
            player function_9bfc7816d33741a6( player.var_b5d437dfc1d85c31 );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xc78aa5cd, Offset: 0x5dd0
// Size: 0x8b
function function_22b60856dfb70b71()
{
    foreach ( team in level.teamnamelist )
    {
        if ( teams::getteamcount( team ) == 0 )
        {
            continue;
        }
        
        function_d6fefdf49dc089b5( team );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x986f89ee, Offset: 0x5e63
// Size: 0x20c
function function_d6fefdf49dc089b5( team )
{
    teamscore = brzonecontrol_getteamscore( team );
    highscore = function_981c7acd697864a8();
    var_88309885bbda1b58 = 0;
    
    if ( level.brgametype.leaderteam )
    {
        var_88309885bbda1b58 = brzonecontrol_getteamscore( level.brgametype.leaderteam );
    }
    
    ishighscore = teamscore == highscore;
    var_3a77cbf7f6ec7022 = level.brgametype.leaderteam == team;
    var_ab26002917d85bb9 = var_88309885bbda1b58 < highscore;
    
    if ( ishighscore && ( var_3a77cbf7f6ec7022 || var_ab26002917d85bb9 ) )
    {
        level.brgametype.leaderteam = team;
        level.brgametype.var_88309885bbda1b58 = teamscore;
        
        if ( function_12dcae6d22f9bac8() && ( !level.brgametype.var_1ed08df236a6ba22 || var_ab26002917d85bb9 ) )
        {
            level notify( #"new_leaders" );
            function_1ea8964305baa19d();
            function_6f3d5763552335b();
        }
        
        if ( !level.brgametype.var_da7b0c0ecb0ac970 && level.brgametype.var_88309885bbda1b58 > level.brgametype.var_ede60d893b5c63db )
        {
            function_4a6e0734829f2477( "zc_midscore_leaders", "zc_midscore_others", "halfway_leaders", "halfway_others" );
            level.brgametype.var_da7b0c0ecb0ac970 = 1;
        }
        
        if ( !level.brgametype.var_323ad04bb8473f91 && level.brgametype.var_88309885bbda1b58 > level.brgametype.var_60b8cf489ad23d81 )
        {
            function_4a6e0734829f2477( "zc_majorityscore_leaders", "zc_majorityscore_others", "victory_close_leaders", "victory_close_others" );
            level.brgametype.var_323ad04bb8473f91 = 1;
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x57b7c313, Offset: 0x6077
// Size: 0xac
function function_981c7acd697864a8()
{
    highscore = 0;
    
    foreach ( team in level.teamnamelist )
    {
        if ( teams::getteamcount( team ) == 0 )
        {
            continue;
        }
        
        teamscore = brzonecontrol_getteamscore( team );
        
        if ( teamscore > highscore )
        {
            highscore = teamscore;
        }
    }
    
    return highscore;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x5dccf5a5, Offset: 0x612c
// Size: 0x3a, Type: bool
function function_2794703e85055cba( team )
{
    if ( level.brgametype.leaderteam )
    {
        return ( team == level.brgametype.leaderteam );
    }
    
    return false;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xcdbf9d83, Offset: 0x616f
// Size: 0x29, Type: bool
function function_12dcae6d22f9bac8()
{
    return level.brgametype.var_88309885bbda1b58 >= level.brgametype.var_d45bcb28473777b3;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x3e4a58af, Offset: 0x61a1
// Size: 0x218
function function_6f3d5763552335b()
{
    level.brgametype.var_1ed08df236a6ba22 = level.brgametype.leaderteam;
    teamplayers = teams::getteamdata( level.brgametype.var_1ed08df236a6ba22, "players" );
    hasbeentracked = arraycontains( level.brgametype.var_6b6381c28148a048, level.brgametype.var_1ed08df236a6ba22 );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            if ( arraycontains( teamplayers, player ) )
            {
                splash = hasbeentracked ? "zc_lead_won" : "zc_top_marked";
                vo = hasbeentracked ? "lead_taking" : "lead_first";
                player hud_message::showsplash( splash );
                level thread br_public::brleaderdialog( vo, undefined, [ player ], 1, 0, undefined );
                player thread function_9d55936c58a0b8b8();
                continue;
            }
            
            if ( !level.brgametype.var_32388ea8b7d1e4f9 )
            {
                player hud_message::showsplash( "zc_top_team_marked" );
                level thread br_public::brleaderdialog( "lead_marked", undefined, [ player ], 1, 0, undefined );
            }
        }
    }
    
    if ( !isdefined( level.brgametype.var_32388ea8b7d1e4f9 ) )
    {
        level.brgametype.var_32388ea8b7d1e4f9 = 1;
    }
    
    if ( !hasbeentracked )
    {
        level.brgametype.var_6b6381c28148a048[ level.brgametype.var_6b6381c28148a048.size ] = level.brgametype.var_1ed08df236a6ba22;
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xc513c326, Offset: 0x63c1
// Size: 0xd4
function function_1ea8964305baa19d( hidesplash )
{
    if ( !level.brgametype.var_1ed08df236a6ba22 )
    {
        return;
    }
    
    teamplayers = teams::getteamdata( level.brgametype.var_1ed08df236a6ba22, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( isalive( player ) )
        {
            function_94b8864e7b6c6909( player, player.objidnum, hidesplash );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xc3795328, Offset: 0x649d
// Size: 0xc4
function function_651586a2fc6e385c()
{
    leaderplayers = [];
    otherplayers = [];
    
    foreach ( player in level.players )
    {
        if ( function_2794703e85055cba( player.team ) )
        {
            leaderplayers[ leaderplayers.size ] = player;
            continue;
        }
        
        otherplayers[ otherplayers.size ] = player;
    }
    
    return { #others:otherplayers, #leaders:leaderplayers };
}

// Namespace br_gametype_zonecontrol
// Params 4
// Checksum 0xa82f2540, Offset: 0x656a
// Size: 0x163
function function_4a6e0734829f2477( leaderssplash, otherssplash, leadersvo, othersvo )
{
    players = function_651586a2fc6e385c();
    
    foreach ( player in players.leaders )
    {
        player hud_message::showsplash( leaderssplash );
    }
    
    foreach ( player in players.others )
    {
        player hud_message::showsplash( otherssplash );
    }
    
    if ( leadersvo )
    {
        level thread br_public::brleaderdialog( leadersvo, undefined, players.leaders, 1, 0, undefined );
    }
    
    if ( othersvo )
    {
        level thread br_public::brleaderdialog( othersvo, undefined, players.others, 1, 0, undefined );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x928ce1c6, Offset: 0x66d5
// Size: 0x9e
function function_7f03256d065e7032()
{
    level.brgametype.var_e6027a52dd829a52 = 1;
    
    foreach ( player in level.players )
    {
        player br::function_ccd86d629929e144();
        player.var_ddc7b37701611eb8 = 0;
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xd5c09880, Offset: 0x677b
// Size: 0x73
function function_dd3365ef6c44c6d8( var_fded9a32438b46ed )
{
    if ( level.brgametype.isendgame )
    {
        return;
    }
    
    if ( var_fded9a32438b46ed || level.brgametype.var_88309885bbda1b58 >= level.brgametype.var_26875c92c15b38c9 )
    {
        level.brgametype.isendgame = 1;
        brzonecontrol_checkforovertime( istrue( var_fded9a32438b46ed ) );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8670d895, Offset: 0x67f6
// Size: 0xfe
function brzonecontrol_checkforovertime( var_fded9a32438b46ed )
{
    if ( level.brgametype.overtimeduration == 0 )
    {
        thread function_852bcab89bc18b79( var_fded9a32438b46ed );
        return;
    }
    
    foreach ( team, teampoint in level.brgametype.teampoints )
    {
        if ( !function_2794703e85055cba( team ) )
        {
            scorediff = level.brgametype.var_88309885bbda1b58 - teampoint;
            
            if ( scorediff <= level.brgametype.var_2a5d9fd2b34be335 )
            {
                thread brzonecontrol_overtime();
                return;
            }
        }
    }
    
    thread function_852bcab89bc18b79( var_fded9a32438b46ed );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xa0ef8953, Offset: 0x68fc
// Size: 0x7f
function function_4c3e3bb45c0c72bc()
{
    foreach ( player in level.players )
    {
        player notify( #"hash_6217cc802658b82" );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x305ebd7a, Offset: 0x6983
// Size: 0xa5
function brzonecontrol_overtime()
{
    level endon( #"game_ended" );
    level notify( #"overtime" );
    level.brgametype.isovertime = 1;
    thread br_multi_circle_objectives::function_f1d7541d9064ecfd( level.brgametype.var_b083451483a7abaa, level.brgametype.overtimeduration );
    hud_util::showsplashtoall( "zc_overtime" );
    level thread br_public::brleaderdialog( "overtime_start", undefined, undefined, 0, 0, undefined );
    function_f9c26dbd3a13d95b();
    function_3619b4ef26f50f63( level.brgametype.overtimeduration, 2 );
    thread brzonecontrol_timeout();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x656b5680, Offset: 0x6a30
// Size: 0xcf
function function_f9c26dbd3a13d95b()
{
    function_a06fa1914f5015f();
    
    foreach ( zone in level.brgametype.activezones )
    {
        zone.var_e836c2cae9ee1657 = level.brgametype.var_9e848840769ab12c[ "2" ];
        zone function_db347eb0979c2ca2( zone.var_e836c2cae9ee1657.name );
        zone function_9b6411317227cf82();
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xecbb2efd, Offset: 0x6b07
// Size: 0x49
function brzonecontrol_timeout()
{
    level endon( #"game_ended" );
    function_4c3e3bb45c0c72bc();
    
    if ( level.brgametype.var_8091c0ed279e84f8 > 0 )
    {
        level.brgametype.var_8091c0ed279e84f8 = 0;
    }
    
    brzonecontrol_endgame();
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xb01ecaa4, Offset: 0x6b58
// Size: 0x69
function function_852bcab89bc18b79( var_fded9a32438b46ed )
{
    function_4c3e3bb45c0c72bc();
    function_46475ff8d5ba241b( level.brgametype.activezones );
    level.skipplaybodycountsound = 1;
    omnvar_utility::function_8b206c75cb7ad548( "ui_zonecontrol_game_data", 15, 1, var_fded9a32438b46ed ? 1 : 0 );
    
    if ( var_fded9a32438b46ed )
    {
        thread brzonecontrol_timeout();
        return;
    }
    
    brzonecontrol_endgame();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xe8b0b2e, Offset: 0x6bc9
// Size: 0x285
function brzonecontrol_endgame()
{
    if ( level.brgametype.zonecontrolgameended )
    {
        return;
    }
    
    thread brzonecontrol_setupnonleaderplayersonexfil();
    
    if ( level.brgametype.var_8091c0ed279e84f8 > 0 )
    {
        level.brgametype.var_8091c0ed279e84f8 = 0;
    }
    
    function_7f03256d065e7032();
    level.brgametype.zonecontrolgameended = 1;
    firstplace = 0;
    secondplace = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( teams::getteamcount( teamname ) == 0 )
        {
            continue;
        }
        
        rank = function_b0c78c44ae3c0d9f( teamname );
        
        if ( rank == 1 )
        {
            firstplace = brzonecontrol_getteamscore( teamname );
        }
        else if ( rank == 2 )
        {
            secondplace = brzonecontrol_getteamscore( teamname );
        }
        
        brzonecontrol_handleendgamesplash( teamname, rank );
        teamplayers = teams::getteamdata( teamname, "players" );
        
        foreach ( player in teamplayers )
        {
            if ( isalive( player ) )
            {
                player.plotarmor = 1;
                player damage_effects::disableburnfx();
            }
        }
    }
    
    if ( level.brgametype.activezones )
    {
        function_46475ff8d5ba241b( level.brgametype.activezones );
    }
    
    function_c6ab481e40c37019( level.brgametype.var_b083451483a7abaa, firstplace - secondplace );
    function_977125ae85d8fcd3();
    function_ec248c149ebf180e();
    winner = level.brgametype.leaderteam ?? "tie";
    thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "objective_completed" ], game[ "end_reason" ][ "br_eliminated" ] );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x96849a22, Offset: 0x6e56
// Size: 0x132
function brzonecontrol_setupnonleaderplayersonexfil()
{
    level waittill( #"hash_7c482f218be7a5f6" );
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( teams::getteamcount( teamname ) == 0 || function_2794703e85055cba( teamname ) )
        {
            continue;
        }
        
        foreach ( player in teams::getteamdata( teamname, "players" ) )
        {
            player.plotarmor = 1;
            player player_utility::function_dbe5a52a6654a982();
            player player_utility::function_9d378d725bb4831e( "br_gametype_zonecontrol::brZoneControl_setupNonLeaderPlayersOnExfil()" );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x1574dbef, Offset: 0x6f90
// Size: 0xb2
function brzonecontrol_handleendgamesplash( team, teamrank )
{
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        player setclientomnvar( "ui_br_player_position", teamrank );
        
        if ( teamrank > 1 )
        {
            player setclientomnvar( "ui_br_squad_eliminated_active", 1 );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x1dfbbd5e, Offset: 0x704a
// Size: 0x84
function function_c53fdb3745db23e2()
{
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player thread player_tryplayobjectivedialog();
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xc66252a9, Offset: 0x70d6
// Size: 0x4b
function function_f47b30962145ed06( time )
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    anticipationdelay = time - 16;
    wait anticipationdelay;
    level thread br_public::brleaderdialog( "deactivation_anticipation", undefined, undefined, 1, 0, undefined );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xc4effedf, Offset: 0x7129
// Size: 0x24
function function_7a793c7c447299aa()
{
    omnvar_utility::function_8b206c75cb7ad548( "ui_zonecontrol_game_data", 0, 13, level.brgametype.var_26875c92c15b38c9 );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x7c9785e0, Offset: 0x7155
// Size: 0x86
function function_3b133e7bf4f7d4d6( value )
{
    level endon( #"game_ended" );
    setomnvar( "ui_br_circle_state", 5 );
    time = value * 1000;
    setomnvar( "ui_hardpoint_timer", int( level.brgametype.starttime + time ) );
    wait int( max( value - level.brgametype.var_176f1c4213142f8f, 0 ) );
    setomnvar( "ui_br_circle_state", 6 );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x6a0d14c0, Offset: 0x71e3
// Size: 0x42
function function_1845e8b110eac2db( value )
{
    time = value * 1000;
    setomnvar( "ui_zonecontrol_round_timer_value", int( level.brgametype.starttime + time ) );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xed38f1ea, Offset: 0x722d
// Size: 0x1e
function function_5850370f4c35f688( value )
{
    omnvar_utility::function_8b206c75cb7ad548( "ui_zonecontrol_game_data", 13, 2, value );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8e14bce3, Offset: 0x7253
// Size: 0x94
function function_39cd010d52cf2fbe( value )
{
    level endon( #"game_ended" );
    setomnvar( "ui_br_circle_state", 5 );
    gametime = gettime();
    time = value * 1000;
    setomnvar( "ui_hardpoint_timer", int( gametime + time ) );
    setomnvar( "ui_zonecontrol_round_timer_value", int( gametime + time ) );
    wait int( max( value - level.brgametype.var_905b2a8bfeb3d561, 0 ) );
    setomnvar( "ui_br_circle_state", 6 );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x42aa8f54, Offset: 0x72ef
// Size: 0x157
function brzonecontrol_packclientmatchdata()
{
    longestscorestreak = minint( self.longestscorestreak, 1023 );
    matchpoints = minint( self.matchpoints, 4095 );
    var_93d21e3fbcd50ca8 = minint( self.var_661d033860ba7bd, 1023 );
    
    if ( self.teamplacement )
    {
        setclientmatchdata( "players", self.clientmatchdataid, "placement", self.teamplacement );
    }
    
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", longestscorestreak );
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore5", matchpoints );
    setclientmatchdata( "players", self.clientmatchdataid, "objectivescore", var_93d21e3fbcd50ca8 );
    
    /#
        println( "<dev string:x367>" + self.name + "<dev string:x375>" + self.clientmatchdataid + "<dev string:x377>" + longestscorestreak );
        println( "<dev string:x367>" + self.name + "<dev string:x375>" + self.clientmatchdataid + "<dev string:x38b>" + matchpoints );
        println( "<dev string:x367>" + self.name + "<dev string:x375>" + self.clientmatchdataid + "<dev string:x39f>" + var_93d21e3fbcd50ca8 );
    #/
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x52bf05e1, Offset: 0x744e
// Size: 0x29, Type: bool
function function_fb4e88d357c53ee5( ent )
{
    return ent vehicle::is_vehicle() || ent.classname == "script_vehicle";
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x4b4ae8c0, Offset: 0x7480
// Size: 0x239
function function_231c49ded6b6bc3b()
{
    cluster = self;
    zones = [];
    zones = function_f621f87cbfb289c2( cluster.target );
    bspzones = getentarray( cluster.target, "targetname" );
    
    foreach ( bspzone in bspzones )
    {
        var_bb02e129bebcc7ec = 0;
        
        foreach ( zone in zones )
        {
            if ( zone.target == bspzone.target )
            {
                var_bb02e129bebcc7ec = 1;
                break;
            }
        }
        
        if ( !var_bb02e129bebcc7ec )
        {
            bspzone.triggervolumes = [ bspzone ];
            zones[ zones.size ] = bspzone;
        }
    }
    
    clusterzones = [];
    zoneindex = 0;
    
    foreach ( zone in zones )
    {
        if ( arraycontains( level.brgametype.var_29714c5c9f5c7be2, zone.target ) )
        {
            continue;
        }
        
        zone function_79867e6fa9a0c098();
        zone.letter = level.brgametype.letters[ zoneindex ];
        clusterzones[ clusterzones.size ] = zone;
        zoneindex++;
    }
    
    return clusterzones;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xafd9a03f, Offset: 0x76c2
// Size: 0x10c
function function_68ab97834772bf1c()
{
    cluster = self;
    assert( cluster.script_noteworthy, "<dev string:x3b6>" );
    var_2f77c53e7bcd2570 = cluster.script_noteworthy;
    var_2f2b5be3b7a9f82d = [];
    
    if ( var_2f77c53e7bcd2570 != "" )
    {
        var_6d98827c4ac6ade = strtok( var_2f77c53e7bcd2570, cluster.is_cs_scriptable ? "," : " " );
        
        foreach ( var_a0f7a5e86d0637d9 in var_6d98827c4ac6ade )
        {
            if ( arraycontains( level.brgametype.var_415c210721d0daec, var_a0f7a5e86d0637d9 ) )
            {
                continue;
            }
            
            var_2f2b5be3b7a9f82d[ var_2f2b5be3b7a9f82d.size ] = var_a0f7a5e86d0637d9;
        }
    }
    
    return var_2f2b5be3b7a9f82d;
}

// Namespace br_gametype_zonecontrol
// Params 4
// Checksum 0xaddc08f0, Offset: 0x77d7
// Size: 0x7f
function function_2aee46b5a4f51295( zoneindex, excluders, var_f75599ee5cb8b1b6, minimumdistance )
{
    cluster = self;
    origin = cluster.zones[ zoneindex ].origin;
    var_e7a886b1a3d7e609 = utility::get_array_of_closest( origin, cluster.zones, excluders, var_f75599ee5cb8b1b6, undefined, minimumdistance );
    return arrayrandomize( var_e7a886b1a3d7e609 );
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x6de1d8d2, Offset: 0x785f
// Size: 0xd0, Type: bool
function function_b0aef598d1bf20e7( origin, mindistance )
{
    cluster = self;
    closestzoneindex = undefined;
    smallestdistance = undefined;
    fallbackzoneindex = undefined;
    var_9d1303901fcbf20d = -1;
    
    for ( i = 0; i < cluster.zones.size ; i++ )
    {
        zonedistance = distance2d( origin, cluster.zones[ i ].origin );
        
        if ( !smallestdistance || zonedistance < smallestdistance )
        {
            if ( zonedistance >= mindistance )
            {
                smallestdistance = zonedistance;
                closestzoneindex = i;
                continue;
            }
            
            if ( zonedistance > var_9d1303901fcbf20d )
            {
                var_9d1303901fcbf20d = zonedistance;
                fallbackzoneindex = i;
            }
        }
    }
    
    return closestzoneindex ?? fallbackzoneindex;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x766c2c4c, Offset: 0x7938
// Size: 0x132
function function_79867e6fa9a0c098()
{
    zone = self;
    chevrons = [];
    chevrons = function_e84d5280a269391( zone.target );
    
    if ( chevrons.size == 0 )
    {
        chevrons = getentitylessscriptablearray( zone.target, "targetname" );
    }
    
    var_6c118050e544e604 = [];
    
    foreach ( chevron in chevrons )
    {
        arrowscount = chevron.arrowscount ?? chevron.script_noteworthy;
        
        if ( arrowscount )
        {
            assert( int( arrowscount ) <= 4, "<dev string:x40e>" );
            chevron.arrowscount = int( arrowscount );
            var_6c118050e544e604[ var_6c118050e544e604.size ] = chevron;
            continue;
        }
        
        assertmsg( "<dev string:x45b>" );
    }
    
    zone.chevrons = var_6c118050e544e604;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x157b04a1, Offset: 0x7a72
// Size: 0x18e
function function_db347eb0979c2ca2( var_24a9d84de80fff54 )
{
    zone = self;
    
    foreach ( var_e836c2cae9ee1657 in level.brgametype.var_9e848840769ab12c )
    {
        if ( var_24a9d84de80fff54 == var_e836c2cae9ee1657.name )
        {
            zone.var_e836c2cae9ee1657 = var_e836c2cae9ee1657;
            break;
        }
    }
    
    foreach ( chevron in zone.chevrons )
    {
        for ( i = 0; i < chevron.arrowscount ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), zone.var_e836c2cae9ee1657.name );
        }
    }
    
    zone function_37b3667484f19cf0();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x5430f085, Offset: 0x7c08
// Size: 0xde
function function_6ca3bc896c83a061()
{
    zone = self;
    zone.players = [];
    zone.vehicles = [];
    zone.var_a50c1fd9b9190527 = [];
    zone.var_f9286f011a80b2dd = [];
    zone.score = 0;
    zone.isactive = 0;
    zone.islock = 1;
    zone.state = "lock";
    zone.var_46d2c06bea16f3ce = undefined;
    zone.var_f8a9407d7ab5c9a0 = undefined;
    zone function_fb870a73c3e2dfe0();
    zone function_37b3667484f19cf0();
    zone function_c0ef94abafeaeb2b();
    zone thread function_8ae948ba22eceafa();
    zone thread function_70803eb07f4a1fae();
    level callback::callback( #"hash_2eb0a1e942877ead", { #zone:zone } );
    return zone;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xa7915587, Offset: 0x7cef
// Size: 0x91
function function_fdcdef5e0b7ac9da()
{
    zone = self;
    zone function_db347eb0979c2ca2( zone.var_e836c2cae9ee1657.name );
    zone.isactive = 1;
    zone.takeoverteams = [];
    zone.islock = 0;
    zone function_c0ef94abafeaeb2b();
    zone thread function_54d8d0b75d93df4c();
    zone notify( #"zone_activated" );
    level callback::callback( #"zonecontrol_zone_activated", { #zone:zone } );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x5499e6e9, Offset: 0x7d88
// Size: 0x47c
function function_c0ef94abafeaeb2b()
{
    zone = self;
    newstate = zone.state;
    newowner = undefined;
    ownerleft = 0;
    zoneteams = [];
    
    if ( zone.isactive )
    {
        if ( zone.islock )
        {
            zone.islock = 0;
        }
        
        if ( zone.players.size == 0 )
        {
            newstate = "idle";
        }
        else
        {
            foreach ( player in zone.players )
            {
                if ( !arraycontains( zoneteams, player.team ) )
                {
                    zoneteams[ zoneteams.size ] = player.team;
                }
            }
            
            if ( zoneteams.size > 1 )
            {
                newstate = "contested";
            }
            else
            {
                newstate = "occupied";
                newowner = zoneteams[ 0 ];
            }
        }
    }
    else
    {
        newstate = zone.islock ? "lock" : "off";
    }
    
    islock = newstate == "lock";
    isidle = newstate == "idle";
    iscontested = newstate == "contested";
    isoccupied = newstate == "occupied";
    isnewstate = zone.state != newstate;
    var_cdc4f606253c293e = !zone.owner && newowner;
    ownerchanged = zone.owner && newowner && zone.owner != newowner;
    ownerleft = zone.owner && zone.owner != "" && iscontested && !arraycontains( zoneteams, zone.owner );
    isnewowner = var_cdc4f606253c293e || ownerchanged;
    
    if ( isnewowner )
    {
        zone.owner = newowner;
        
        if ( ownerchanged )
        {
            zone.previousowner = newowner;
        }
        
        if ( var_cdc4f606253c293e )
        {
            if ( zone.previousowner && zone.previousowner != newowner )
            {
                zone.var_659a99ca66a4b8ff = zone.previousowner;
            }
            else
            {
                zone.var_659a99ca66a4b8ff = newowner;
            }
        }
        
        zone notify( #"hash_4ac1f0e4df61eb78" );
    }
    
    if ( ownerleft )
    {
        zone.var_659a99ca66a4b8ff = zone.owner;
        zone.owner = "";
        zone notify( #"hash_401bde320236295" );
    }
    
    if ( isnewstate )
    {
        zone notify( #"state_changed" );
        zone notify( "zone_is_" + newstate );
        zone.state = newstate;
        
        if ( iscontested )
        {
            zone function_81ef638d6b4c90f0();
        }
        else if ( isoccupied )
        {
            zone function_b32d584b02a2785();
            
            if ( zone.var_659a99ca66a4b8ff && zone.owner != zone.var_659a99ca66a4b8ff )
            {
                zone.var_659a99ca66a4b8ff = undefined;
            }
        }
        else if ( isidle )
        {
            zone.previousowner = zone.owner;
            zone.owner = undefined;
            zone.var_659a99ca66a4b8ff = undefined;
        }
    }
    
    if ( islock || isnewstate || isnewowner )
    {
        zone function_37b3667484f19cf0();
        
        if ( zone.objidnum )
        {
            zone function_9b6411317227cf82();
        }
        
        zone function_74a3b891b058f764();
        
        foreach ( team in zoneteams )
        {
            function_8fda175650d99e4( team );
        }
    }
    
    zone notify( #"state_updated" );
}

// Namespace br_gametype_zonecontrol
// Params 0, eflags: 0x4
// Checksum 0x7c4ab818, Offset: 0x820c
// Size: 0x35
function private function_aece1e9a15fb5753()
{
    zone = self;
    zone function_c0ef94abafeaeb2b();
    level callback::callback( #"hash_c7a132c7acf7744d", { #zone:zone } );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xc7bec77c, Offset: 0x8249
// Size: 0xe9
function function_b32d584b02a2785()
{
    zone = self;
    
    foreach ( player in zone.players )
    {
        if ( player.var_7f263dacdd491742 && !player.var_7f263dacdd491742 )
        {
            continue;
        }
        
        if ( player.team == zone.owner )
        {
            level thread br_public::brleaderdialog( "zone_secured", undefined, [ player ], 0, 0, undefined );
            player thread function_1c4fc5b102e07724();
        }
    }
    
    zone function_3e8f36c9dff4fe98( "sc" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x1eec8439, Offset: 0x833a
// Size: 0x16e
function function_81ef638d6b4c90f0()
{
    zone = self;
    contestingteams = [];
    
    foreach ( player in zone.players )
    {
        if ( player.team == zone.owner )
        {
            level thread br_public::brleaderdialog( "zone_contested", undefined, [ player ], 0, 0, undefined );
            continue;
        }
        
        level thread br_public::brleaderdialog( "attacking_zone", undefined, [ player ], 0, 0, undefined );
        contestingteams = arraycombineunique( contestingteams, [ player.team ] );
    }
    
    zone function_3e8f36c9dff4fe98( "ac" );
    
    foreach ( team in contestingteams )
    {
        zone function_8ab45e0260f066c2( team );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x79a4735a, Offset: 0x84b0
// Size: 0xe8
function function_8ab45e0260f066c2( contestingteam )
{
    if ( !level.brgametype.var_133de809c14cc8c5 )
    {
        return;
    }
    
    zone = self;
    teamplayers = teams::getteamdata( contestingteam, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( !arraycontains( zone.players, player ) )
        {
            level thread br_public::brleaderdialog( "at" + zone.letter, undefined, [ player ], 0, 0, undefined );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xc9f8ad25, Offset: 0x85a0
// Size: 0x11f
function function_3e8f36c9dff4fe98( var_dd55efcecb742da9 )
{
    zone = self;
    
    if ( !level.brgametype.var_133de809c14cc8c5 || !zone.owner )
    {
        return;
    }
    
    if ( !level.teamdata[ zone.owner ] )
    {
        return;
    }
    
    teamplayers = teams::getteamdata( zone.owner, "players" );
    
    if ( !teamplayers )
    {
        return;
    }
    
    foreach ( player in teamplayers )
    {
        if ( !arraycontains( zone.players, player ) )
        {
            level thread br_public::brleaderdialog( var_dd55efcecb742da9 + zone.letter, undefined, [ player ], 0, 0, undefined );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8f5fa5be, Offset: 0x86c7
// Size: 0xc9
function function_cdccb5d63161292e( team )
{
    zone = self;
    teamplayers = teams::getteamdata( team, "players" );
    playersinzone = [];
    
    foreach ( player in teamplayers )
    {
        if ( isalive( player ) && arraycontains( zone.players, player ) )
        {
            playersinzone[ playersinzone.size ] = player;
        }
    }
    
    return playersinzone;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xbbe8ff82, Offset: 0x8799
// Size: 0x2e
function function_113474b9a587a8f6( team )
{
    self.var_6c0a712311f8e867[ team ] = { #players:[], #progress:0 };
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xc9fad87f, Offset: 0x87cf
// Size: 0x9b
function function_54d8d0b75d93df4c()
{
    if ( level.brgametype.var_8e6d3d96c5f72a05 == 0 )
    {
        return;
    }
    
    zone = self;
    level endon( #"game_ended" );
    zone endon( #"deactivate_zone" );
    zone.var_6c0a712311f8e867 = [];
    zone childthread function_6189e147ffe71b51();
    
    while ( true )
    {
        zone waittill( #"hash_4ac1f0e4df61eb78" );
        
        if ( zone.var_659a99ca66a4b8ff != zone.owner )
        {
            zone thread function_f291b519a40b1a0d( zone.owner );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x11e7d278, Offset: 0x8872
// Size: 0x1f2
function function_f291b519a40b1a0d( team )
{
    zone = self;
    zone endon( #"hash_4ac1f0e4df61eb78" );
    zone endon( #"takeover" );
    zone endon( #"hash_401bde320236295" );
    zone endon( #"deactivate_zone" );
    takeoverdelay = level.brgametype.takeoverdelay;
    
    while ( zone.isactive && zone.owner == team )
    {
        while ( zone.state == "occupied" )
        {
            wait 1;
            
            if ( zone.state != "occupied" )
            {
                continue;
            }
            
            takeoverdelay--;
            var_957293701cbdc8f2 = zone function_cdccb5d63161292e( team );
            
            foreach ( player in var_957293701cbdc8f2 )
            {
                if ( !zone.var_6c0a712311f8e867[ player.team ] )
                {
                    zone function_113474b9a587a8f6( player.team );
                }
                
                progress = level.brgametype.takeoverdelay - takeoverdelay;
                zone.var_6c0a712311f8e867[ player.team ].progress = progress;
                player function_1085623b4243b0f1( progress );
            }
            
            if ( takeoverdelay == 0 )
            {
                zone.var_659a99ca66a4b8ff = team;
                zone function_97cd2413b7b4fd66( team );
                zone notify( #"takeover" );
            }
        }
        
        zone waittill( #"state_updated" );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x5f80b007, Offset: 0x8a6c
// Size: 0x31c
function function_6189e147ffe71b51()
{
    zone = self;
    var_72ed415b19e88392 = [];
    effectiveownerteam = undefined;
    
    while ( zone.isactive )
    {
        effectiveownerteam = zone.owner ?? zone.previousowner;
        zone utility::waittill_any( "state_updated", "player_left" );
        var_ef8e85adfae249d6 = [];
        var_c13c84b5b791067f = [];
        var_ef8e85adfae249d6 = arrayremove( var_72ed415b19e88392, zone.players );
        var_c13c84b5b791067f = arrayremove( zone.players, var_72ed415b19e88392 );
        
        foreach ( player in var_c13c84b5b791067f )
        {
            if ( effectiveownerteam && player.team != effectiveownerteam )
            {
                if ( !zone.var_6c0a712311f8e867[ player.team ] )
                {
                    zone function_113474b9a587a8f6( player.team );
                }
                
                zone.var_6c0a712311f8e867[ player.team ].players[ zone.var_6c0a712311f8e867[ player.team ].players.size ] = player;
                player function_1085623b4243b0f1( zone.var_6c0a712311f8e867[ player.team ].progress );
                player function_e59f310d36a9173c( 1 );
            }
        }
        
        foreach ( player in var_ef8e85adfae249d6 )
        {
            if ( !player )
            {
                continue;
            }
            
            player function_e59f310d36a9173c( 0 );
            player function_1085623b4243b0f1( 0 );
            
            if ( zone.var_6c0a712311f8e867[ player.team ] )
            {
                zone.var_6c0a712311f8e867[ player.team ].players = arrayremove( zone.var_6c0a712311f8e867[ player.team ].players, player );
                
                if ( zone.var_6c0a712311f8e867[ player.team ].players.size == 0 )
                {
                    zone.var_6c0a712311f8e867[ player.team ] = undefined;
                    
                    if ( zone.var_659a99ca66a4b8ff == player.team )
                    {
                        zone.var_659a99ca66a4b8ff = undefined;
                    }
                }
            }
        }
        
        var_72ed415b19e88392 = arraycopy( zone.players );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xed953a80, Offset: 0x8d90
// Size: 0x136
function function_97cd2413b7b4fd66( owner )
{
    zone = self;
    
    foreach ( player in zone.players )
    {
        if ( player.team == owner )
        {
            player function_20f85f1629dfb2dd( level.brgametype.var_8e6d3d96c5f72a05, zone, 1 );
            player.var_58648101a675be11++;
        }
    }
    
    function_9f2b86c8803611de( owner, level.brgametype.var_8e6d3d96c5f72a05, "takeover" );
    brzonecontrol_giveteampoints( owner, level.brgametype.var_8e6d3d96c5f72a05 );
    zone function_41d03ae8d3eb01ed( level.brgametype.var_8e6d3d96c5f72a05 );
    function_d6fefdf49dc089b5( owner );
    function_cf804ff492926a08();
    function_dd3365ef6c44c6d8();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x2191a03a, Offset: 0x8ece
// Size: 0xab
function function_74a3b891b058f764()
{
    zone = self;
    
    if ( !zone.players || zone.players.size == 0 )
    {
        return;
    }
    
    foreach ( player in zone.players )
    {
        player function_17ea0f699b95e16d( zone );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x8ebf9729, Offset: 0x8f81
// Size: 0x15b
function function_37b3667484f19cf0()
{
    zone = self;
    state = zone.state;
    
    if ( zone.state != "off" )
    {
        state += zone.var_e836c2cae9ee1657.name;
    }
    
    foreach ( chevron in zone.chevrons )
    {
        for ( i = 0; i < chevron.arrowscount ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
            
            if ( zone.state == "occupied" )
            {
                chevron function_474bcbb86b733bef( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), zone.owner );
            }
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xff18b88b, Offset: 0x90e4
// Size: 0x116
function function_fb870a73c3e2dfe0()
{
    zone = self;
    zone.objective = gameobjects::createobjidobject( zone.origin, "neutral", ( 0, 0, 0 ), undefined, "any" );
    objidnum = zone.objective.objidnum;
    zone.objidnum = objidnum;
    objective_setshowdistance( objidnum, 1 );
    objective_sethideelevation( objidnum, 0 );
    function_c3ced8df0f5cc479( objidnum, 1 );
    objective_setshowoncompass( objidnum, 1 );
    function_24edb8a97f6832f0( objidnum, 1 );
    function_5a1f9b4d7de0b23b( objidnum, 1 );
    
    if ( level.brgametype.var_ecf6c37d1dc3d7dc )
    {
        function_ac9886e0e2860e18( objidnum, level.brgametype.var_145e7fb4f53718f2, level.brgametype.var_aa73e2aa12fcfd6f );
        function_a50725c23cddbf00( objidnum, level.brgametype.var_ae0144f0e7e3cc65, level.brgametype.var_e328bee5a35fa2d0 );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x9898be47, Offset: 0x9202
// Size: 0x278
function function_9b6411317227cf82()
{
    zone = self;
    islocked = zone.state == "lock";
    iscontested = zone.state == "contested";
    var_d09bc8d443c89f75 = zone.letter;
    var_8c5e59d6e1a6fef4 = islocked ? "icon_waypoint_base_frame_lock" : "icon_waypoint_base_frame_idle";
    var_57bc7614602b7adb = var_8c5e59d6e1a6fef4 + zone.var_e836c2cae9ee1657.name;
    zone.objective.cancontestclaim = !islocked;
    zone.objective.stalemate = iscontested;
    
    switch ( zone.state )
    {
        case #"hash_7dca1839ef64aba2":
            zone.objective gameobjects::setobjectivestatusicons( "zc_waypoint_lock_" + var_d09bc8d443c89f75 );
            break;
        case #"hash_1c39674e5b0de0f3":
            zone.objective gameobjects::setobjectivestatusicons( "zc_waypoint_neutral_" + var_d09bc8d443c89f75 );
            break;
        case #"hash_86bf1a776a7c4cbe":
            zone.objective gameobjects::setobjectivestatusicons( "zc_waypoint_contested_" + var_d09bc8d443c89f75 );
            break;
        case #"hash_6c1bd689daa03029":
            zone.objective gameobjects::setobjectivestatusicons( "zc_waypoint_defending_" + var_d09bc8d443c89f75, "zc_waypoint_losing_" + var_d09bc8d443c89f75, zone.objidnum, zone.owner );
            break;
    }
    
    var_b469267e5a4a2950 = zone.state == "lock" || zone.state == "idle";
    objidpoolmanager::function_373aaf492aabde6f( zone.objidnum, 255, 255, 255, var_b469267e5a4a2950 );
    zone.objective.wasstalemate = zone.objective.stalemate;
    var_daf54221aec1d98b = zone.var_e836c2cae9ee1657.name == "2" && zone.state != "lock";
    foregroundicon = var_daf54221aec1d98b ? var_57bc7614602b7adb : "icon_waypoint_base_empty";
    function_c97f0baa8ba1ccc6( zone.objidnum, foregroundicon );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xfd56f29a, Offset: 0x9482
// Size: 0xa9
function function_8ae948ba22eceafa()
{
    zone = self;
    level endon( #"game_ended" );
    zone endon( #"deactivate_zone" );
    
    while ( true )
    {
        triggerer = utility::function_247f4cc1c6c325d1( zone.triggervolumes, "trigger" );
        
        if ( isplayer( triggerer ) )
        {
            if ( arraycontains( zone.players, triggerer ) )
            {
                continue;
            }
            
            zone thread function_ef7fadff7d889068( triggerer );
            continue;
        }
        
        if ( function_fb4e88d357c53ee5( triggerer ) )
        {
            if ( arraycontains( zone.vehicles, triggerer ) )
            {
                continue;
            }
            
            zone thread function_2bec746e3ff969cd( triggerer );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0, eflags: 0x4
// Checksum 0x2447d499, Offset: 0x9533
// Size: 0x145
function private function_80cf40ce9fb97a2a()
{
    zone = self;
    zonehalfsize = zone getboundshalfsize();
    zoneradius = sqrt( squared( zonehalfsize[ 0 ] ) + squared( zonehalfsize[ 1 ] ) );
    scriptablesarray = getlootscriptablearrayinradius( undefined, undefined, zone.origin, zoneradius );
    var_d8146b8d005f70b1 = [];
    
    if ( scriptablesarray )
    {
        foreach ( scriptableinstance in scriptablesarray )
        {
            isreserved = scriptableinstance getscriptableisreserved();
            hasid = isdefined( scriptableinstance.index );
            var_3cd12dda687dc40b = ispointinvolume( scriptableinstance.origin, zone );
            var_376c3c07e6da6c10 = isreserved && hasid && var_3cd12dda687dc40b;
            
            if ( var_376c3c07e6da6c10 && br_pickups::function_6a85ec799fb98a0c( scriptableinstance, 0 ) )
            {
                var_d8146b8d005f70b1[ var_d8146b8d005f70b1.size ] = scriptableinstance;
            }
        }
    }
    
    return var_d8146b8d005f70b1;
}

// Namespace br_gametype_zonecontrol
// Params 2, eflags: 0x4
// Checksum 0xb6be4c5b, Offset: 0x9681
// Size: 0x68, Type: bool
function private function_fa5630785fa594bf( loota, lootb )
{
    assert( loota );
    assert( isdefined( loota.index ) );
    assert( lootb );
    assert( isdefined( lootb.index ) );
    return loota.index < lootb.index;
}

// Namespace br_gametype_zonecontrol
// Params 0, eflags: 0x4
// Checksum 0xfe1967b0, Offset: 0x96f2
// Size: 0x9a
function private function_70803eb07f4a1fae()
{
    zone = self;
    level endon( #"game_ended" );
    zone endon( #"deactivate_zone" );
    
    while ( true )
    {
        lootarray = function_80cf40ce9fb97a2a();
        lootarray = arraysort( lootarray, undefined, &function_fa5630785fa594bf );
        var_bf1d8574c251d1c9 = max( lootarray.size - level.brgametype.var_ab40de3fc1e06240, 0 );
        
        for ( i = 0; i < var_bf1d8574c251d1c9 ; i++ )
        {
            pickups::loothide( lootarray[ i ] );
        }
        
        wait 10;
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0xe40fc535, Offset: 0x9794
// Size: 0x95, Type: bool
function function_53766e556d9a7f2f( point, zone )
{
    foreach ( triggervolume in zone.triggervolumes )
    {
        if ( ispointinvolume( point, triggervolume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8078ac44, Offset: 0x9832
// Size: 0xc0
function function_ef7fadff7d889068( player )
{
    zone = self;
    level endon( #"game_ended" );
    zone endon( #"deactivate_zone" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        waitframe();
        
        if ( function_53766e556d9a7f2f( player.origin + ( 0, 0, 10 ), zone ) )
        {
            if ( arraycontains( zone.players, player ) )
            {
                continue;
            }
            
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            zone function_4787919a8abc2ccd( player );
            continue;
        }
        
        if ( arraycontains( zone.players, player ) )
        {
            zone function_7c4b81f3ac92229d( player );
            break;
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x1b5ef3c9, Offset: 0x98fa
// Size: 0xb1
function function_2bec746e3ff969cd( vehicle )
{
    zone = self;
    level endon( #"game_ended" );
    zone endon( #"deactivate_zone" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( function_53766e556d9a7f2f( vehicle.origin + ( 0, 0, 10 ), zone ) )
        {
            if ( arraycontains( zone.vehicles, vehicle ) )
            {
                continue;
            }
            
            zone function_7542647a8babc7d0( vehicle );
            continue;
        }
        
        if ( arraycontains( zone.vehicles, vehicle ) )
        {
            zone function_f74ba3c8f67c249c( vehicle );
            break;
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xfd22615f, Offset: 0x99b3
// Size: 0xa6
function function_71802e0968524d2b()
{
    zone = self;
    
    if ( zone.players.size == 0 )
    {
        return;
    }
    
    foreach ( player in zone.players )
    {
        objidpoolmanager::objective_unpin_player( zone.objidnum, player, 0 );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x670ed520, Offset: 0x9a61
// Size: 0x40
function function_41d03ae8d3eb01ed( pointadded )
{
    zone = self;
    zone.score += pointadded;
    zone notify( #"hash_728ac56633ba6fe" );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xba3c85ab, Offset: 0x9aa9
// Size: 0x31
function function_573103d6898027b4( score )
{
    zone = self;
    return score * zone.var_e836c2cae9ee1657.multiplier;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xdc945411, Offset: 0x9ae3
// Size: 0x20e
function function_372e98865ecd0b00()
{
    if ( level.brgametype.var_c44a4c0c38858ae3 == 0 )
    {
        return 0;
    }
    
    zone = self;
    
    if ( !zone.var_46d2c06bea16f3ce || !zone.var_f8a9407d7ab5c9a0 )
    {
        zone function_2fd8f5900e4fa289();
    }
    
    var_25608aa13c84ac99 = 0;
    
    switch ( zone.state )
    {
        case #"hash_6c1bd689daa03029":
            if ( zone.players.size >= 2 )
            {
                var_cb11292e201c020e = zone.players[ 0 ].team;
                
                if ( zone.var_46d2c06bea16f3ce == var_cb11292e201c020e )
                {
                    zone.var_f8a9407d7ab5c9a0--;
                    
                    if ( zone.var_f8a9407d7ab5c9a0 == 0 )
                    {
                        function_9f2b86c8803611de( var_cb11292e201c020e, level.brgametype.var_c44a4c0c38858ae3, "squadBonus" );
                        var_25608aa13c84ac99 = 1;
                        zone function_2fd8f5900e4fa289( var_cb11292e201c020e );
                    }
                }
                else
                {
                    zone function_2fd8f5900e4fa289( var_cb11292e201c020e );
                }
            }
            else
            {
                zone function_2fd8f5900e4fa289();
            }
            
            break;
        case #"hash_86bf1a776a7c4cbe":
            if ( zone.var_46d2c06bea16f3ce != "" )
            {
                var_c66f3f5dcdc563b7 = 0;
                
                foreach ( player in zone.players )
                {
                    if ( player.team == zone.var_46d2c06bea16f3ce )
                    {
                        var_c66f3f5dcdc563b7 = 1;
                        break;
                    }
                }
                
                if ( !var_c66f3f5dcdc563b7 )
                {
                    zone function_2fd8f5900e4fa289();
                }
            }
            
            break;
        default:
            zone function_2fd8f5900e4fa289();
            break;
    }
    
    return var_25608aa13c84ac99;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xbeeb8b6f, Offset: 0x9cfa
// Size: 0x4e
function function_2fd8f5900e4fa289( var_cb11292e201c020e )
{
    zone = self;
    zone.var_f8a9407d7ab5c9a0 = level.brgametype.var_613acf06bb2afb8e;
    zone.var_46d2c06bea16f3ce = var_cb11292e201c020e ?? "";
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x56cace74, Offset: 0x9d50
// Size: 0xbb
function function_4787919a8abc2ccd( player )
{
    zone = self;
    zone.players[ zone.players.size ] = player;
    player.zone = zone;
    player thread function_11e0c44f31c3f2ee( zone );
    zone thread function_747c8de89000d086( player );
    objidpoolmanager::objective_pin_player( zone.objidnum, player );
    
    if ( zone.state == "contested" )
    {
        level thread br_public::brleaderdialog( "attacking_zone", undefined, [ player ], 0, 0, undefined );
    }
    
    player thread function_5ce960c8670bd1c( zone );
    zone function_aece1e9a15fb5753();
    function_8fda175650d99e4( player.team );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xbd57622f, Offset: 0x9e13
// Size: 0x96
function function_7c4b81f3ac92229d( player )
{
    zone = self;
    player notify( #"player_left_zone" );
    player function_6cabb43505eae2b2( zone );
    objidpoolmanager::objective_unpin_player( zone.objidnum, player, 1 );
    zone.players = arrayremove( zone.players, player );
    player.zone = undefined;
    zone function_aece1e9a15fb5753();
    zone notify( #"player_left" );
    function_8fda175650d99e4( player.team );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x74d5d0c, Offset: 0x9eb1
// Size: 0xd8
function function_7542647a8babc7d0( vehicle )
{
    zone = self;
    zone.vehicles[ zone.vehicles.size ] = vehicle;
    
    foreach ( player in vehicle.occupants )
    {
        if ( !arraycontains( zone.players, player ) )
        {
            zone function_4787919a8abc2ccd( player );
        }
        
        zone thread function_f8f4bc86ad0d2e24( vehicle, player );
    }
    
    zone thread function_548b77fb506de99( vehicle );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x33305c4a, Offset: 0x9f91
// Size: 0xd1
function function_f74ba3c8f67c249c( vehicle )
{
    zone = self;
    vehicle notify( #"hash_3ec679360f6cc634" );
    
    foreach ( player in vehicle.occupants )
    {
        if ( arraycontains( zone.players, player ) )
        {
            zone function_7c4b81f3ac92229d( player );
        }
    }
    
    zone.vehicles = arrayremove( zone.vehicles, vehicle );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xd25d1db6, Offset: 0xa06a
// Size: 0xac
function function_747c8de89000d086( player )
{
    zone = self;
    level endon( #"game_ended" );
    player endon( #"player_left_zone" );
    zone endon( #"deactivate_zone" );
    player waittill( #"death_or_disconnect" );
    
    if ( player )
    {
        objidpoolmanager::objective_unpin_player( zone.objidnum, player, 1 );
        zone.players = arrayremove( zone.players, player );
    }
    else
    {
        zone.players = function_5713d46873b29625( zone.players );
    }
    
    zone function_aece1e9a15fb5753();
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x7c3d569b, Offset: 0xa11e
// Size: 0x92
function function_548b77fb506de99( vehicle )
{
    zone = self;
    level endon( #"game_ended" );
    vehicle endon( #"hash_3ec679360f6cc634" );
    zone endon( #"deactivate_zone" );
    vehicle utility::waittill_any( "death", "player_enter" );
    
    if ( vehicle )
    {
        zone.vehicles = arrayremove( zone.vehicles, vehicle );
        return;
    }
    
    zone.vehicles = function_5713d46873b29625( zone.vehicles );
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0xc3247382, Offset: 0xa1b8
// Size: 0xa0
function function_f8f4bc86ad0d2e24( vehicle, player )
{
    zone = self;
    level endon( #"game_ended" );
    vehicle endon( #"hash_3ec679360f6cc634" );
    zone endon( #"deactivate_zone" );
    utility::waittill_any_ents( vehicle, "death", player, "vehicle_exit", player, "death_or_disconnect" );
    
    if ( arraycontains( zone.players, player ) )
    {
        zone function_7c4b81f3ac92229d( player );
        return;
    }
    
    zone.players = function_5713d46873b29625( zone.players );
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0xd9b39545, Offset: 0xa260
// Size: 0x27
function zone_onplayerentervehicle( vehicle, player )
{
    if ( vehicle )
    {
        vehicle notify( #"player_enter" );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xd90fc9ac, Offset: 0xa28f
// Size: 0x46
function function_7cdfa73aada10100( player )
{
    zone = self;
    var_d7abd21d517fa051 = zone.isactive && !arraycontains( zone.var_a50c1fd9b9190527, player );
    return var_d7abd21d517fa051;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xeb1417d2, Offset: 0xa2de
// Size: 0x46
function function_d53cc7dff7c7ae8c( player )
{
    zone = self;
    var_d7abd21d517fa051 = zone.isactive && !arraycontains( zone.var_f9286f011a80b2dd, player );
    return var_d7abd21d517fa051;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x702d0c45, Offset: 0xa32d
// Size: 0x70
function function_42278947f58d9e98( player )
{
    zone = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    zone.var_a50c1fd9b9190527[ zone.var_a50c1fd9b9190527.size ] = player;
    wait 0.3;
    zone.var_a50c1fd9b9190527 = arrayremove( zone.var_a50c1fd9b9190527, player );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x5a51d562, Offset: 0xa3a5
// Size: 0x70
function function_4f467dfe707aec64( player )
{
    zone = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    zone.var_f9286f011a80b2dd[ zone.var_f9286f011a80b2dd.size ] = player;
    wait 0.3;
    zone.var_f9286f011a80b2dd = arrayremove( zone.var_f9286f011a80b2dd, player );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x1844df03, Offset: 0xa41d
// Size: 0x57
function function_8362cdbbc97471da()
{
    player = self;
    player endon( #"disconnect" );
    player waittill( #"spawned_player" );
    wait 1;
    
    if ( !level.br_infils_disabled )
    {
        player waittill( #"joining_infil" );
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
}

// Namespace br_gametype_zonecontrol
// Params 3
// Checksum 0x24c9545, Offset: 0xa47c
// Size: 0x23a
function function_20f85f1629dfb2dd( points, zone, istakeover )
{
    player = self;
    canscore = zone && ( zone.state == "occupied" || istakeover );
    
    if ( !canscore )
    {
        return 0;
    }
    
    if ( !istakeover )
    {
        points *= player.pointsmultiplier;
    }
    
    player.matchpoints += points;
    player.pers[ "matchPoints" ] = player.matchpoints;
    player br_public::updatebrscoreboardstat( "matchPoints", player.matchpoints );
    
    if ( zone.var_e836c2cae9ee1657.name == "2" )
    {
        player.var_9b61e4a72e737e31 += points;
    }
    
    if ( zone && player.scorestreak == 0 )
    {
        player function_f95022bb82ee8fc7( zone );
    }
    
    player thread function_a3428f722eaac831( zone );
    player.scorestreak += points;
    player function_1aded9bbe1f65bd7( player.scorestreak );
    
    if ( player.scorestreak >= 3 && !player.var_3c75c21f4f88ffe5 && zone )
    {
        player thread function_50fceb065f9d6a81();
    }
    
    if ( player.scorestreak > player.longestscorestreak )
    {
        player.longestscorestreak = player.scorestreak;
        player.pers[ "longestScoreStreak" ] = player.scorestreak;
        player br_public::updatebrscoreboardstat( "longestScoreStreak", int( min( player.longestscorestreak, 1023 ) ) );
    }
    
    if ( istakeover )
    {
        challenges::function_37e945722d6497f3( player, "lockdown_takeover", 1 );
    }
    else if ( zone.var_e836c2cae9ee1657.name == "2" )
    {
        challenges::function_37e945722d6497f3( player, "lockdown_high_value_occupation", 1 );
    }
    
    return points;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x6f2a800a, Offset: 0xa6bf
// Size: 0xf6
function brzonecontrol_onplayerkilled( deathdata )
{
    victim = self;
    attacker = deathdata.attacker;
    
    if ( !isplayer( attacker ) || !isdefined( attacker.zone ) || attacker == victim )
    {
        return;
    }
    
    zone = attacker.zone;
    
    if ( zone.state != "occupied" && zone.state != "contested" )
    {
        return;
    }
    
    if ( !ispointinvolume( attacker.origin + ( 0, 0, 10 ), zone ) )
    {
        return;
    }
    
    if ( victim.team == level.brgametype.var_1ed08df236a6ba22 )
    {
        attacker points::doscoreevent( #"hash_aa8de88677f7703e" );
        return;
    }
    
    attacker function_73319e70b9d689f( zone );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x21588941, Offset: 0xa7bd
// Size: 0x10c
function function_17ea0f699b95e16d( zone )
{
    player = self;
    
    switch ( zone.state )
    {
        case #"hash_7dca1839ef64aba2":
            player objidpoolmanager::function_101225acbc89c1c1( 1, &"MP_INGAME_ONLY/OBJ_ZC_LOCKED_CAPS", 0 );
            break;
        case #"hash_86bf1a776a7c4cbe":
            player objidpoolmanager::function_101225acbc89c1c1( 1, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 0 );
            break;
        case #"hash_1c39674e5b0de0f3":
            player objidpoolmanager::function_101225acbc89c1c1( 1, &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0 );
            break;
        case #"hash_6c1bd689daa03029":
            if ( zone.owner && player.team == zone.owner )
            {
                player objidpoolmanager::function_101225acbc89c1c1( 1, &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0 );
            }
            else
            {
                player objidpoolmanager::function_101225acbc89c1c1( 1, &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0 );
            }
            
            break;
        default:
            break;
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x1c3ec521, Offset: 0xa8d1
// Size: 0x3b
function function_6cabb43505eae2b2( zone )
{
    player = self;
    
    if ( zone function_d53cc7dff7c7ae8c( player ) )
    {
        player playlocalsound( "uin_iw9_lockdown_zone_exit" );
        zone thread function_4f467dfe707aec64( player );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x7127c396, Offset: 0xa914
// Size: 0xe7
function function_11e0c44f31c3f2ee( zone )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"player_left_zone" );
    
    if ( !zone.isactive )
    {
        zone waittill( #"zone_activated" );
    }
    
    if ( ispointinvolume( player.origin + ( 0, 0, 10 ), zone ) )
    {
        if ( zone function_7cdfa73aada10100( player ) )
        {
            ishighvalue = zone.var_e836c2cae9ee1657.name == "2";
            entersfx = ishighvalue ? "uin_iw9_lockdown_zone_enter_special" : "uin_iw9_lockdown_zone_enter";
            player playlocalsound( entersfx );
            zone thread function_42278947f58d9e98( player );
        }
        
        player thread function_b44c7b1a8f199749( zone );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x8fe779d1, Offset: 0xaa03
// Size: 0x57
function function_1c4fc5b102e07724()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player.var_7f263dacdd491742 = 0;
    wait level.brgametype.var_9f5bfb14b3a3056a;
    player.var_7f263dacdd491742 = 1;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x9ef4d0b5, Offset: 0xaa62
// Size: 0x59
function function_b44c7b1a8f199749( zone )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"player_left_zone" );
    zone waittill( #"deactivate_zone" );
    player playlocalsound( "uin_iw9_lockdown_zone_exit" );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xf18365e0, Offset: 0xaac3
// Size: 0x5c
function function_50fceb065f9d6a81()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( level.roundtimeremaining < 15 )
    {
        return;
    }
    
    musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_36dbc2b972083cfc" );
    player.var_3c75c21f4f88ffe5 = 1;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x2908095e, Offset: 0xab27
// Size: 0x28
function function_7e0d8ab999b0b096()
{
    player = self;
    player setplayermusicstate( "" );
    player.var_3c75c21f4f88ffe5 = 0;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x9f4090a4, Offset: 0xab57
// Size: 0x46
function function_f95022bb82ee8fc7( zone )
{
    player = self;
    
    if ( player.var_7d26ac8d5154e5c3 == 0 )
    {
        return;
    }
    
    player points::doscoreevent( #"hash_c96052f73cdd535" );
    player thread function_1ccda0f02fa10e59( zone );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x994da28b, Offset: 0xaba5
// Size: 0x7d
function function_1ccda0f02fa10e59( zone )
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player.var_7d26ac8d5154e5c3 = 0;
    utility::waittill_any_ents( player, "death", player, "player_left_zone", zone, "deactivate_zone" );
    wait level.brgametype.var_891051eec61cfd2d;
    player.var_7d26ac8d5154e5c3 = 1;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x17d85179, Offset: 0xac2a
// Size: 0x4f
function function_73319e70b9d689f( zone )
{
    player = self;
    scoreevent = hashcat( #"hash_47a10fc2dcd83760", zone.var_e836c2cae9ee1657.name );
    player points::doscoreevent( scoreevent );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x5e589a75, Offset: 0xac81
// Size: 0xc3
function function_5ce960c8670bd1c( zone )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"player_left_zone" );
    zone endon( #"deactivate_zone" );
    
    while ( true )
    {
        wait level.brgametype.var_59e20095ea03a9c0;
        
        if ( zone.state == "occupied" )
        {
            scoreevent = hashcat( #"hash_c53d998f9895672b", zone.var_e836c2cae9ee1657.name );
            player points::doscoreevent( scoreevent );
            continue;
        }
        
        zone waittill( #"state_changed" );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xe86b5eb7, Offset: 0xad4c
// Size: 0x116
function function_e8d280f836a1339f( zone )
{
    player = self;
    
    if ( level.brgametype.var_c44a4c0c38858ae3 == 0 )
    {
        return;
    }
    
    teamplayers = teams::getteamdata( player.team, "players" );
    playercount = 0;
    
    foreach ( teamplayer in teamplayers )
    {
        if ( teamplayer && arraycontains( zone.players, teamplayer ) )
        {
            playercount++;
        }
    }
    
    if ( playercount < 2 )
    {
        return;
    }
    
    player function_35cd9e4bc267bad4();
    scoreevent = hashcat( #"hash_8e73d19416d829d9", playercount );
    player points::doscoreevent( scoreevent );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x540e7243, Offset: 0xae6a
// Size: 0x112
function function_a4346b81bbfd7c66( player )
{
    assert( player );
    assert( isalive( player ) );
    
    if ( player.var_ddc7b37701611eb8 )
    {
        return;
    }
    
    player.var_ddc7b37701611eb8 = 1;
    player.objidnum = objidpoolmanager::requestobjectiveid( 99 );
    objidpoolmanager::objective_add_objective( player.objidnum, "active", player.origin, "ui_mp_br_mapmenu_icon_assassin_objective_enemy" );
    objidpoolmanager::update_objective_setbackground( player.objidnum, 1 );
    objidpoolmanager::objective_mask_showtoenemyteam( player.objidnum, player );
    objective_disableping( player.objidnum, 1 );
    player thread function_2492e4eafa797656();
    player thread function_f1c092238d808129();
    playerisinvehicle = player vehicle::is_in_vehicle();
    
    if ( !level.brgametype.var_e6027a52dd829a52 && !playerisinvehicle )
    {
        player br::function_f2d49b5c22624ea2( "prop_zc_game_flag" );
    }
    
    player thread function_783f6dd72aecb8fd( playerisinvehicle );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x4a82aa54, Offset: 0xaf84
// Size: 0x89
function function_2492e4eafa797656()
{
    player = self;
    level endon( #"game_ended" );
    level endon( #"new_leaders" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait level.brgametype.var_421d2aa75becf29e;
        
        if ( player.objidnum )
        {
            objidpoolmanager::update_objective_position( player.objidnum, player.origin + ( 0, 0, 80 ) );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x267ed3ef, Offset: 0xb015
// Size: 0x57
function function_f1c092238d808129()
{
    player = self;
    level endon( #"game_ended" );
    level endon( #"new_leaders" );
    leaderobjectiveid = player.objidnum;
    utility::waittill_any_ents( player, "death_or_disconnect" );
    level function_94b8864e7b6c6909( player, leaderobjectiveid, 1 );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x80ef1609, Offset: 0xb074
// Size: 0x99
function function_783f6dd72aecb8fd( playerisinvehicle )
{
    player = self;
    level endon( #"game_ended" );
    level endon( #"new_leaders" );
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( !playerisinvehicle )
        {
            player waittill( #"vehicle_enter" );
            player br::function_ccd86d629929e144();
        }
        
        player waittill( #"vehicle_exit" );
        playerisinvehicle = 0;
        
        if ( !level.brgametype.var_e6027a52dd829a52 )
        {
            player br::function_f2d49b5c22624ea2( "prop_zc_game_flag" );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 3
// Checksum 0xa9e1c906, Offset: 0xb115
// Size: 0xa1
function function_94b8864e7b6c6909( player, leaderobjectiveid, hidesplash )
{
    isplayerdisconnected = !player;
    
    if ( isplayerdisconnected )
    {
        objidpoolmanager::returnobjectiveid( leaderobjectiveid );
        return;
    }
    
    if ( player.var_ddc7b37701611eb8 )
    {
        player.var_ddc7b37701611eb8 = undefined;
        objidpoolmanager::returnobjectiveid( leaderobjectiveid );
        player.objidnum = undefined;
        player br::function_ccd86d629929e144();
        
        if ( !hidesplash )
        {
            player hud_message::showsplash( "zc_lead_lost" );
            level thread br_public::brleaderdialog( "lead_lost", undefined, [ player ], 1, 0, undefined );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x9df06d3e, Offset: 0xb1be
// Size: 0x11b
function function_a3428f722eaac831( zone )
{
    player = self;
    player notify( #"beginscorestreak" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"beginscorestreak" );
    
    for ( isinzone = 1; isinzone ; isinzone = 0 )
    {
        utility::waittill_any_ents( player, "death", player, "player_left_zone", zone, "deactivate_zone" );
        
        if ( isalive( player ) && !player.zone )
        {
            wait level.brgametype.var_268d5d34b73476a4;
        }
        
        if ( isalive( player ) && player.zone && ( player.zone.state == "occupied" || player.zone.state == "contested" ) )
        {
            zone = player.zone;
            continue;
        }
    }
    
    player player_resetscorestreak();
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8fec10a4, Offset: 0xb2e1
// Size: 0x87
function player_onrespawn( params )
{
    player = self;
    player thread player_tryplayobjectivedialog();
    player damage::resetplayervariables();
    player damage::resetplayeromnvarsonspawn();
    
    if ( !level.brgametype.var_1ed08df236a6ba22 )
    {
        return;
    }
    
    var_5d0870b3ab3a06d9 = teams::getteamdata( level.brgametype.var_1ed08df236a6ba22, "players" );
    
    if ( arraycontains( var_5d0870b3ab3a06d9, player ) )
    {
        player thread function_9d55936c58a0b8b8();
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x561989fa, Offset: 0xb370
// Size: 0xab
function function_2b586a41d8df9ca3()
{
    count = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        players = teams::getteamdata( teamname, "players" );
        
        if ( players.size && !isbot( players[ 0 ] ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x89ae9d88, Offset: 0xb424
// Size: 0xe3
function function_7d7431471a5dde0b( team )
{
    rank = 1;
    score = brzonecontrol_getteamscore( team );
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( team == teamname )
        {
            continue;
        }
        
        teamplayers = teams::getteamdata( teamname, "players" );
        
        if ( !teamplayers.size || isbot( teamplayers[ 0 ] ) )
        {
            continue;
        }
        
        if ( brzonecontrol_getteamscore( teamname ) > score )
        {
            rank++;
        }
    }
    
    return rank;
}

// Namespace br_gametype_zonecontrol
// Params 2, eflags: 0x4
// Checksum 0x2a74522d, Offset: 0xb510
// Size: 0x9c
function private function_669ee7b58b9d59c2( team, rounddata )
{
    var_430ab1165dad5333 = function_2b586a41d8df9ca3();
    rank = function_7d7431471a5dde0b( team );
    var_2adbd35d570e08c7 = int( ( var_430ab1165dad5333 + 2 ) / 3 );
    var_8685b65542813ba2 = int( ( 2 * var_430ab1165dad5333 + 2 ) / 3 );
    
    if ( rank <= var_2adbd35d570e08c7 )
    {
        return rounddata.var_15f56834ff4ff8cd;
    }
    else if ( rank <= var_8685b65542813ba2 )
    {
        return rounddata.var_b73d4ff3b72326f1;
    }
    
    return rounddata.var_d77dde0d7130f163;
}

// Namespace br_gametype_zonecontrol
// Params 1, eflags: 0x4
// Checksum 0xb9566d6f, Offset: 0xb5b5
// Size: 0x17e
function private function_83f0093c58376a81( pool )
{
    if ( !pool.poolentry.size )
    {
        return;
    }
    
    totalweight = 0;
    
    foreach ( entry in pool.poolentry )
    {
        totalweight += entry.weight;
    }
    
    if ( totalweight <= 0 )
    {
        return;
    }
    
    roll = randomintrange( 0, totalweight );
    cumulative = 0;
    
    foreach ( entry in pool.poolentry )
    {
        cumulative += entry.weight;
        
        if ( roll < cumulative )
        {
            return entry.scriptableitem;
        }
    }
    
    return pool.poolentry[ pool.poolentry.size - 1 ].scriptableitem;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xb1aee148, Offset: 0xb73c
// Size: 0x22
function function_6237972a5037fc4f()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( isbot( self ) )
    {
        return;
    }
    
    thread function_3c5011bd447b329c();
}

// Namespace br_gametype_zonecontrol
// Params 0, eflags: 0xc
// Checksum 0x39246fea, Offset: 0xb766
// Size: 0x3c
function private function_3c5011bd447b329c()
{
    self notify( #"hash_75f93915b691888b" );
    self endon( #"hash_75f93915b691888b" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 6;
    function_c6007bf78b1b7dba();
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x61a0023e, Offset: 0xb7aa
// Size: 0x1d
function function_d281b85a571a5f03( params )
{
    if ( !item_killstreak::iskillstreakavailable() )
    {
        thread function_bf2189b3830109c6();
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xc59376c7, Offset: 0xb7cf
// Size: 0x71
function function_bf2189b3830109c6( var_4755798373853ab5 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    refilldelay = level.brgametype.var_8825be0d95f46acf;
    self setclientomnvar( "ui_zonecontrol_gift_refill_end_time", int( gettime() + refilldelay * 1000 ) );
    wait refilldelay;
    
    if ( !item_killstreak::iskillstreakavailable() )
    {
        function_c6007bf78b1b7dba();
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xa9c0fb77, Offset: 0xb848
// Size: 0x154
function function_c6007bf78b1b7dba()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    roundindex = min( level.brgametype.var_b083451483a7abaa, level.zonecontrol_bundle.roundsdata.size - 1 );
    rounddata = level.zonecontrol_bundle.roundsdata[ roundindex ];
    pool = function_669ee7b58b9d59c2( self.team, rounddata );
    scriptableitem = function_83f0093c58376a81( pool );
    
    if ( !isdefined( scriptableitem ) )
    {
        return;
    }
    
    tempitem = { #type:scriptableitem };
    itembundle = common_item::function_6b8ff3d5f2688336( tempitem );
    defaultcount = common_item::function_ea3b3088d82fd357( itembundle );
    respawnkillstreak = { #count:defaultcount, #type:scriptableitem };
    common_item::function_96119bed8ab4c5d9( respawnkillstreak, 0, 1 );
    self setclientomnvar( "ui_zonecontrol_gift_refill_end_time", 1 );
    self playlocalsound( "uin_saw_feature_lockdown_killstreak_randomize" );
    wait 2.9;
    var_e51d12435de1696b = common_item::function_33a2c00e46263d99( tempitem );
    function_3a9e4429f349bd3c( var_e51d12435de1696b );
    self playlocalsound( "uin_saw_feature_lockdown_killstreak_confirmation" );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x903df936, Offset: 0xb9a4
// Size: 0x35
function function_3a9e4429f349bd3c( var_e51d12435de1696b )
{
    var_9ffea708a12df7c3 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", var_e51d12435de1696b );
    hud_message::showsplash( "zc_killstreak_acquired", var_9ffea708a12df7c3 );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xd5e37589, Offset: 0xb9e1
// Size: 0x11
function function_5376d4e229c13da5( streakitem )
{
    return 2.9;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x1acccc95, Offset: 0xb9fb
// Size: 0x32, Type: bool
function function_9e2f604f23599e62( itemtype )
{
    if ( level.brgametype.var_4ea524dc82389417 && itemtype == "killstreak" )
    {
        return false;
    }
    
    return true;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x72e4ec0c, Offset: 0xba36
// Size: 0x73, Type: bool
function function_fc95b4074361539d( attacker )
{
    if ( level.brgametype.var_23e46d09e7e50331 || level.brgametype.loadoutrestore && !isdefined( self.savedloadout ) )
    {
        br::function_d8d054ee4230fa94();
    }
    
    if ( level.brgametype.var_4ea524dc82389417 )
    {
        common_item::function_bbba261e6fdc7e52( "killstreak", {} );
    }
    
    return false;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xb41e704b, Offset: 0xbab2
// Size: 0x11e
function player_tryplayobjectivedialog()
{
    player = self;
    zoneinactive = !level.brgametype.activezones || level.brgametype.activezones.size == 0 || !level.brgametype.activezones[ 0 ].isactive;
    
    if ( !level.brgametype.var_428c23a842f826a4 || zoneinactive || player.var_d1eaede99787154b )
    {
        return;
    }
    
    player notify( #"tryplayobjectivedialog" );
    level endon( #"game_ended" );
    level endon( #"hash_7d1aef19582db5b1" );
    player endon( #"death_or_disconnect" );
    player endon( #"beginscorestreak" );
    player endon( #"tryplayobjectivedialog" );
    wait level.brgametype.var_c2906332d1ecf1b5;
    level thread br_public::brleaderdialog( "play_objective", undefined, [ player ], 0, 0, undefined );
    player.var_d1eaede99787154b = 1;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xbad7ab74, Offset: 0xbbd8
// Size: 0x8a
function function_9d55936c58a0b8b8()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( !level.brgametype.var_1ed08df236a6ba22 )
    {
        return;
    }
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    var_5d0870b3ab3a06d9 = teams::getteamdata( level.brgametype.var_1ed08df236a6ba22, "players" );
    
    if ( arraycontains( var_5d0870b3ab3a06d9, player ) )
    {
        level function_a4346b81bbfd7c66( player );
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xffd5d967, Offset: 0xbc6a
// Size: 0x39
function player_resetscorestreak()
{
    player = self;
    player.scorestreak = 0;
    player function_1aded9bbe1f65bd7( player.scorestreak );
    player function_7e0d8ab999b0b096();
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x8dc07f0d, Offset: 0xbcab
// Size: 0x2d
function function_1aded9bbe1f65bd7( scorestreak )
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 6, 13, scorestreak );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x164daa2c, Offset: 0xbce0
// Size: 0x2c
function function_d923e350504fd625( rank )
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 0, 6, rank );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x7003a33c, Offset: 0xbd14
// Size: 0x2d
function function_e59f310d36a9173c( active )
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 20, 1, active );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xad8803f7, Offset: 0xbd49
// Size: 0x2d
function function_1085623b4243b0f1( var_bd61d7667c4369c7 )
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 22, 3, var_bd61d7667c4369c7 );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x67a1534c, Offset: 0xbd7e
// Size: 0x37
function function_35cd9e4bc267bad4()
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 21, 1, 1 );
    waitframe();
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 21, 1, 0 );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xb10f936d, Offset: 0xbdbd
// Size: 0x2d
function function_9bfc7816d33741a6( isactive )
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data2", 19, 1, isactive );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x7512c660, Offset: 0xbdf2
// Size: 0x2c
function function_d4c5b95dad2ed752( score )
{
    player = self;
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data", 0, 13, score );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x81fefec3, Offset: 0xbe26
// Size: 0xc5
function function_99ea746a5409671d( playerteam )
{
    player = self;
    enemyscore = 0;
    
    foreach ( team, teampoints in level.brgametype.teampoints )
    {
        if ( playerteam == team )
        {
            continue;
        }
        
        if ( teampoints > enemyscore )
        {
            enemyscore = teampoints;
        }
    }
    
    player omnvar_utility::function_85d5f88af471ac4b( "ui_zonecontrol_client_data", 13, 13, enemyscore );
}

// Namespace br_gametype_zonecontrol
// Params 3
// Checksum 0x255e591f, Offset: 0xbef3
// Size: 0x41
function function_37ca8d93c7d7b7ae( forcefallback, timeuntilspawn, overrideheight )
{
    spawnorigin = br_circle::getrandompointinboundssafecircle();
    
    if ( spawnorigin )
    {
        spawnorigin = br_public::droptogroundmultitrace( spawnorigin );
    }
    
    return spawnorigin;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x28699965, Offset: 0xbf3d
// Size: 0x13b
function function_ac397f2e90f9cdd1()
{
    circlesorigin = [];
    circlesradius = [];
    additionalradiussize = utility::function_edc4cc03e9e60b3e( @"hash_b0e54987b343400d", level.zonecontrol_bundle.var_451b5a02d8992668 );
    
    foreach ( cluster in level.brgametype.var_7215bdc140ec4561 )
    {
        circlesorigin[ circlesorigin.size ] = level.brgametype.clusters[ cluster ].origin;
        circlesradius[ circlesradius.size ] = ( level.brgametype.var_97e4272a1bb2acd1 ? function_56ce6ca1ea5b797f( cluster ) : 0 ) + additionalradiussize;
    }
    
    level.brgametype.circlesorigin = circlesorigin;
    level.brgametype.circlesradius = circlesradius;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x6356c584, Offset: 0xc080
// Size: 0xfc
function function_56ce6ca1ea5b797f( clustername )
{
    clusterorigin = level.brgametype.clusters[ clustername ].origin;
    clusterzones = level.brgametype.clusters[ clustername ].zones;
    circleradius = 0;
    
    foreach ( zone in clusterzones )
    {
        distbetween = distance2d( clusterorigin, zone.origin );
        
        if ( circleradius < distbetween )
        {
            circleradius = distbetween;
        }
    }
    
    return circleradius;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xad760388, Offset: 0xc185
// Size: 0x12f
function brzonecontrol_createmulticircleobjectivesstruct()
{
    var_8ac5d73cfaea5985 = utility::function_edc4cc03e9e60b3e( @"hash_ec013a11954ccefc", level.zonecontrol_bundle.var_8ac5d73cfaea5985 );
    zonesdurations = [];
    var_249c4a832bada449 = [];
    
    foreach ( rounddata in level.brgametype.roundsdata )
    {
        zonesdurations[ zonesdurations.size ] = rounddata.zonesduration;
        var_249c4a832bada449[ var_249c4a832bada449.size ] = rounddata.zonesactivationdelay;
    }
    
    circlespath = br_multi_circle_objectives::createmulticircleobjectivesstruct( level.brgametype.var_86fa3ba724755769, zonesdurations, var_8ac5d73cfaea5985, var_249c4a832bada449, level.brgametype.circlesorigin, level.brgametype.circlesradius );
    return circlespath;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x91d5d4f4, Offset: 0xc2bd
// Size: 0x88
function function_fae2d63a1992ae5c()
{
    level waittill( #"prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        player thread function_a0c777a5dc12a1f6();
    }
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0xc6826fb9, Offset: 0xc34d
// Size: 0x50
function function_a0c777a5dc12a1f6()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    br::function_db10c8f42ea08ad5( -1, -1, -1 );
    
    while ( self && !self istacmapactive() )
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_60e98bb53cda5ce8();
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x4c04eac5, Offset: 0xc3a5
// Size: 0x77
function function_60e98bb53cda5ce8()
{
    endpos = level.brgametype.circlesorigin[ 0 ];
    zoomradius = level.brgametype.circlesradius[ 0 ];
    zoomradius += getdvarint( @"hash_d495131bff7bb215", level.zonecontrol_bundle.var_3c7d33cd0bbf5ecd );
    br::function_db10c8f42ea08ad5( endpos[ 0 ], endpos[ 1 ], zoomradius );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x981b6599, Offset: 0xc424
// Size: 0x147
function function_c5a8371fa1177437()
{
    var_65e94ac6c9acb0c7 = utility::getstructarray( "zc_cluster", "targetname" );
    clusterscriptables = getentitylessscriptablearray( "zc_cluster", "targetname" );
    
    foreach ( scriptcluster in var_65e94ac6c9acb0c7 )
    {
        var_c12ec7f11dcc61ff = undefined;
        
        foreach ( bspcluster in clusterscriptables )
        {
            if ( bspcluster.target == scriptcluster.target )
            {
                var_c12ec7f11dcc61ff = bspcluster;
                break;
            }
        }
        
        if ( var_c12ec7f11dcc61ff )
        {
            clusterscriptables = arrayremove( clusterscriptables, var_c12ec7f11dcc61ff );
        }
        
        clusterscriptables[ clusterscriptables.size ] = scriptcluster;
    }
    
    return clusterscriptables;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x44b7933b, Offset: 0xc574
// Size: 0x10b
function function_f621f87cbfb289c2( target )
{
    triggervolumes = getnoentvolumearray( target, "targetname" );
    zones = [];
    
    while ( triggervolumes.size > 0 )
    {
        zone = triggervolumes[ 0 ];
        zone.triggervolumes = [];
        
        foreach ( triggervolume in triggervolumes )
        {
            if ( zone.target == triggervolume.target )
            {
                zone.triggervolumes[ zone.triggervolumes.size ] = triggervolume;
            }
        }
        
        triggervolumes = arrayremove( triggervolumes, zone.triggervolumes );
        zones[ zones.size ] = zone;
    }
    
    return zones;
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0x2964566, Offset: 0xc688
// Size: 0xe0
function function_e84d5280a269391( zonetarget )
{
    chevronstructs = utility::getstructarray( zonetarget, "targetname" );
    chevrons = [];
    
    foreach ( chevronstruct in chevronstructs )
    {
        chevron = spawnscriptable( "zonecontrol_chevron", chevronstruct.origin, chevronstruct.angles );
        chevron.arrowscount = chevronstruct.script_noteworthy;
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace br_gametype_zonecontrol
// Params 3
// Checksum 0x1088840a, Offset: 0xc771
// Size: 0xb4
function function_75a15c747f39b96d( str_friendly_team, var_df6e272c88e8f1fe, str_enemy_dialog )
{
    foreach ( team in level.teamnamelist )
    {
        if ( team == str_friendly_team )
        {
            level thread br_public::brleaderdialogteam( var_df6e272c88e8f1fe, team, undefined, 1 );
            continue;
        }
        
        level thread br_public::brleaderdialogteam( str_enemy_dialog, team, undefined, 1 );
    }
}

/#

    // Namespace br_gametype_zonecontrol
    // Params 0
    // Checksum 0x2ad5b8fa, Offset: 0xc82d
    // Size: 0x5a, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4a6>" );
        devgui::add_devgui_func( "<dev string:x4b7>", "<dev string:x4c6>", &debug_showallzones );
        devgui::add_devgui_func( "<dev string:x4d7>", "<dev string:x4e6>", &function_6e19c67325881c60 );
        devgui::add_devgui_func( "<dev string:x4f7>", "<dev string:x508>", &function_2d8e81093485e997 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gametype_zonecontrol
    // Params 0
    // Checksum 0x98a9980d, Offset: 0xc88f
    // Size: 0x19e, Type: dev
    function debug_showallzones()
    {
        if ( level.brgametype.var_636723dd4990079 )
        {
            function_6e19c67325881c60();
        }
        
        level.brgametype.var_636723dd4990079 = 1;
        maxobjectives = 32;
        roundindex = 0;
        
        foreach ( clustername in level.brgametype.var_7215bdc140ec4561 )
        {
            function_b2c6c0054677f1af( clustername, roundindex );
            roundindex++;
            cluster = level.brgametype.clusters[ clustername ];
            
            foreach ( zone in cluster.zones )
            {
                if ( !zone.objidnum )
                {
                    zone function_fb870a73c3e2dfe0();
                }
                
                objective_state( zone.objidnum, "<dev string:x51f>" );
                maxobjectives--;
                
                if ( maxobjectives <= 0 )
                {
                    return;
                }
            }
        }
    }

    // Namespace br_gametype_zonecontrol
    // Params 0
    // Checksum 0x12f98557, Offset: 0xca35
    // Size: 0x12f, Type: dev
    function function_6e19c67325881c60()
    {
        foreach ( cluster in level.brgametype.clusters )
        {
            foreach ( zone in cluster.zones )
            {
                if ( zone.objidnum )
                {
                    objidpoolmanager::returnobjectiveid( zone.objidnum );
                    zone.objidnum = undefined;
                }
            }
        }
        
        level.brgametype.var_636723dd4990079 = 0;
    }

    // Namespace br_gametype_zonecontrol
    // Params 0
    // Checksum 0x6cafd58e, Offset: 0xcb6c
    // Size: 0x67, Type: dev
    function function_2d8e81093485e997()
    {
        shownewzones = istrue( level.brgametype.var_636723dd4990079 );
        
        if ( shownewzones )
        {
            function_6e19c67325881c60();
        }
        
        level.brgametype.var_7215bdc140ec4561 = [];
        function_b0a19ce79688f165();
        function_ac397f2e90f9cdd1();
        br_circle::initcircle();
        
        if ( shownewzones )
        {
            debug_showallzones();
        }
    }

#/

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x4c875593, Offset: 0xcbdb
// Size: 0xb8
function function_58c8e53ac67fe848( time, timertype )
{
    level endon( #"game_ended" );
    level endon( #"overtime" );
    
    if ( time >= 15 && timertype == 0 )
    {
        wait time - 15;
        ticksfx = level.brgametype.var_b083451483a7abaa == level.brgametype.roundscount - 1 ? "uin_iw9_lockdown_final_round_end_time_15sec" : "uin_iw9_lockdown_round_end_time_15sec";
        function_98fc74bcdca6c506( ticksfx );
        return;
    }
    
    if ( time >= 15 && timertype == 2 )
    {
        wait time - 20;
        function_98fc74bcdca6c506( "uin_iw9_lockdown_overtime_timer_20sec" );
    }
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xaacac402, Offset: 0xcc9b
// Size: 0x93
function function_98fc74bcdca6c506( sfx )
{
    foreach ( player in level.players )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player playlocalsound( sfx );
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x7588198d, Offset: 0xcd36
// Size: 0x3b
function function_e0b154b6074c0d86( sfx, clusterindex )
{
    playsoundatpos( level.brgametype.clusters[ clusterindex ].origin, sfx );
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x1c7371b0, Offset: 0xcd79
// Size: 0x12e
function function_9f060979e9b8f484()
{
    level.brgametype.var_c43c77d3f3861f3f = [];
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( teams::getteamcount( teamname ) == 0 )
        {
            continue;
        }
        
        level.brgametype.var_c43c77d3f3861f3f[ teamname ] = [];
        level.brgametype.var_c43c77d3f3861f3f[ teamname ][ "takeover" ] = 0;
        level.brgametype.var_c43c77d3f3861f3f[ teamname ][ "squadBonus" ] = 0;
        level.brgametype.var_c43c77d3f3861f3f[ teamname ][ "normalZone" ] = 0;
        level.brgametype.var_c43c77d3f3861f3f[ teamname ][ "highValueZone" ] = 0;
    }
    
    thread function_67740fde63c51a24();
}

// Namespace br_gametype_zonecontrol
// Params 3
// Checksum 0x936b6c3e, Offset: 0xceaf
// Size: 0xb8
function function_9f2b86c8803611de( teamname, value, source )
{
    if ( !isdefined( level.brgametype.var_c43c77d3f3861f3f[ teamname ] ) )
    {
        level.brgametype.var_c43c77d3f3861f3f[ teamname ] = [];
    }
    
    if ( !isdefined( level.brgametype.var_c43c77d3f3861f3f[ teamname ][ source ] ) )
    {
        level.brgametype.var_c43c77d3f3861f3f[ teamname ][ source ] = 0;
    }
    
    level.brgametype.var_c43c77d3f3861f3f[ teamname ][ source ] += value;
}

// Namespace br_gametype_zonecontrol
// Params 0
// Checksum 0x4f0eef63, Offset: 0xcf6f
// Size: 0x100
function function_67740fde63c51a24()
{
    level waittill( #"game_ended" );
    
    foreach ( teamname, var_65161ccc27f2e5ba in level.brgametype.var_c43c77d3f3861f3f )
    {
        teamplayers = teams::getteamdata( teamname, "players" );
        isbots = teamplayers.size && isbot( teamplayers[ 0 ] );
        
        if ( function_97de808fe549b3b7() )
        {
            function_ad05aed95a44741e( -62951499030874489, [ 8:isbots, 7:var_65161ccc27f2e5ba[ "highValueZone" ], 6:var_65161ccc27f2e5ba[ "normalZone" ], 5:var_65161ccc27f2e5ba[ "squadBonus" ], var_65161ccc27f2e5ba[ "takeover" ], 3:teamname ] );
        }
    }
}

// Namespace br_gametype_zonecontrol
// Params 2
// Checksum 0x9c7598b3, Offset: 0xd077
// Size: 0x57
function function_c6ab481e40c37019( roundindex, scorediff )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "round_index";
    eventparams[ eventparams.size ] = roundindex;
    eventparams[ eventparams.size ] = "score_diff";
    eventparams[ eventparams.size ] = int( scorediff );
    dlog_recordevent( "dlog_event_zc_match_end", eventparams );
}

// Namespace br_gametype_zonecontrol
// Params 1
// Checksum 0xb524736b, Offset: 0xd0d6
// Size: 0x12d
function function_d10f091cf2ac7fbe( roundindex )
{
    totalscore = 0;
    
    foreach ( zone in level.brgametype.activezones )
    {
        if ( zone.score )
        {
            totalscore += zone.score;
        }
    }
    
    totalscore /= level.brgametype.activezones.size;
    eventparams = [];
    eventparams[ eventparams.size ] = "round_index";
    eventparams[ eventparams.size ] = roundindex;
    eventparams[ eventparams.size ] = "average_points_given";
    eventparams[ eventparams.size ] = int( totalscore );
    eventparams[ eventparams.size ] = "is_overtime";
    eventparams[ eventparams.size ] = istrue( level.brgametype.isovertime );
    dlog_recordevent( "dlog_event_zc_round_end", eventparams );
}

