// scripts\mp\biometric_scan.gsc  (hash_774d323cdd56cb0c.gscc) (size: 40986 Bytes / 0xa01a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2cc853db (751326171)
// size ...... 40986 (0xa01a)
// includes .. 26  (offset: 0x973a)
// strings ... 107 (offset: 0x980a)
// dev strs .. 19  (offset: 0x9ec6)
// exports ... 109 (offset: 0x6586)
// cseg ...... 0x8be + 0x5cc8 (0x6586)
// imports ... 267 (offset: 0x768e)
// animtree1 . 1   (offset: 0x9faa)
// animtree2 . 6   (offset: 0x9fba)
#using script_239a365a92ee4476;
#using script_75b994f10201e95c;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\playerachievements;
#using scripts\mp\structspawnconfig;

#namespace biometric_scan;

// Namespace biometric_scan
// Params 0, eflags: 0x5
// Checksum 0xdc55281e, Offset: 0x8dc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ftue_biometric_scanner", #"br_ftue", undefined, &post_main );
}

// Namespace biometric_scan
// Params 0, eflags: 0x5
// Checksum 0x3bc5cf29, Offset: 0x905
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace biometric_scan
// Params 0
// Checksum 0x6442c3f6, Offset: 0x916
// Size: 0x17
function post_main()
{
    if ( ftue_progress::ftue_enabled() )
    {
        namespace_44e8cefed76aa88e::function_feeeaf4be5bd0641( &function_5fe1ee61f16472ee );
    }
}

// Namespace biometric_scan
// Params 0
// Checksum 0x652d990, Offset: 0x935
// Size: 0x4b9
function init()
{
    if ( !biometric_scan_isenabled() || isdefined( level.var_904f7a4736d5940e ) )
    {
        return;
    }
    
    biometric_scan_init_data();
    
    if ( !isdefined( level.biometricscan ) )
    {
        return;
    }
    
    callback::add( #"player_connect", &on_player_connect );
    utility::registersharedfunc( #"biometricscan", #"handlekeycardexchange", &handlekeycardexchange );
    utility::registersharedfunc( #"biometricscan", #"reportkeycardcount", &reportkeycardcount );
    utility::registersharedfunc( #"biometricscan", #"updatefreeitemcount", &updatefreeitemcount );
    utility::registersharedfunc( #"biometricscan", #"hash_86e51a6d5eee9268", &function_a657979790ce1853 );
    utility::registersharedfunc( #"biometricscan", #"scanner_used", &scanner_used );
    
    if ( getdvarint( @"hash_afd1992805fd8b6d", 1 ) && getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        utility::flag_wait( "ssc_initialized" );
        structspawnconfig::function_7418a260adaec05( "biometric_scan", &function_139d58d75da4222 );
        structspawnconfig::function_8c0a09968efe9138( "biometric_scan", &function_a083f2b6e004ae80 );
        structspawnconfig::function_36050499b5f48983( "biometric_scan", &function_e205a2d61da8d464 );
    }
    else
    {
        level thread function_d88ca622c5b3be3f();
    }
    
    script_model_anims();
    callback::add( #"hash_8daeabb90e45c6bc", &function_1ff1f8c6eec74532 );
    level.biometricscan.dailycutoff = getdvarint( @"hash_8384030de1801c2f", -480 ) * 60;
    init_vo();
    level.var_904f7a4736d5940e = [];
    level.biometricscan.dvars = spawnstruct();
    level.biometricscan.dvars.var_70ae23d3c58de2b6 = getdvarfloat( @"hash_ab3f3558f8f917d5", 0.1 );
    level.biometricscan.dvars.var_86b4c0aff48167d3 = getdvarfloat( @"hash_8c7fdc461dba3431", 300 );
    level.biometricscan.dvars.scannersightfov = getdvarfloat( @"hash_caac6e8d55ab4fd2", 180 );
    level.biometricscan.dvars.var_8bb98c611427ce5a = getdvarfloat( @"hash_c985c163a80624f6", 0.25 );
    level.biometricscan.dvars.var_d76357161900b37c = getdvarint( @"hash_9892b0119ab69326", 99 );
    level.biometricscan.dvars.var_bb8c5dd46866287d = getdvarint( @"hash_33fd1ecf272fbd40", 1 );
    level.biometricscan.dvars.var_7a9c5edb76cb0d6d = getdvarint( @"hash_75c55b01a2e1226c", 1 );
    level.biometricscan.dvars.var_c7e7b7d78b58c014 = getdvarint( @"hash_c01c6933ec70d8ed", 1 );
    level.biometricscan.dvars.var_fd52f0e45929ed73 = getdvarfloat( @"hash_9bd744f9b617b85", 60 );
    level.biometricscan.dvars.var_42bb74d07f85e048 = getdvarfloat( @"hash_35b26cea7b1b247c", 1200 );
    level.biometricscan.dvars.var_43c6f5cbbf5503cc = getdvarint( @"hash_1d6744b5ec325c46", 10 );
    level.biometricscan.dvars.death_scene_time_sec = getdvarfloat( @"scr_death_scene_time", level.gamemodebundle.deathcamtime ) + 0.25;
    level.biometricscan.dvars.var_18ec3163e8e75c4e = getdvarint( @"hash_3cee7c513ae578f7", 0 );
    level.biometricscan.var_8c28d018f83d82a0 = [ "j_head", "j_shoulder_le", "j_shoulder_ri", "j_knee_le", "j_knee_ri" ];
    scriptable::scriptable_addusedcallbackbypart( "biometric_scanner", &scanner_used );
    
    if ( !namespace_8cdbb6d4564d9fae::function_8f8e633d55c4fe83() )
    {
        level thread function_957397bd820f454b();
    }
    
    level thread function_747da5c9402cd9e7();
    level thread function_d91c303de280bb4e();
    callback::add( #"game_ended", &function_330464bfe41fa0e );
    
    /#
        debug_init();
    #/
}

// Namespace biometric_scan
// Params 1
// Checksum 0xdf3544a3, Offset: 0xdf6
// Size: 0xe0
function on_player_connect( params )
{
    foreach ( keycard in level.biometricscan.keycards )
    {
        callback::add( keycard.keycarditem.ref + "_" + "quest_item_on_drop", &function_473e0257fe7a4a4e );
        callback::add( keycard.keycarditem.ref + "_" + "quest_item_delayed_respawn", &function_b8db1864ea38172c );
    }
}

// Namespace biometric_scan
// Params 0
// Checksum 0x40988907, Offset: 0xede
// Size: 0x3cb
function biometric_scan_init_data()
{
    level.biometricscan = game_utility_mp::function_cb7ed8e67866f9d0( "biometric_scan_data" );
    
    if ( !isdefined( level.biometricscan ) )
    {
        return;
    }
    
    for ( i = 0; i < level.biometricscan.accesslevels.size ; i++ )
    {
        level.biometricscan.accesslevels[ i ].var_9084d7377eba366e = i;
    }
    
    level.biometricscan.accesslevels = arraysort( level.biometricscan.accesslevels, undefined, &function_28da9178de9f074b );
    keycardnames = [];
    
    foreach ( accesslevel in level.biometricscan.accesslevels )
    {
        var_1068ca88cfb07fc0 = function_9b7443fe1500759c( accesslevel );
        accesslevel.var_9ba1f14c8daadbc6 = var_1068ca88cfb07fc0;
        
        foreach ( keycardquantity in accesslevel.var_9ba1f14c8daadbc6 )
        {
            isinstruct = 0;
            
            foreach ( key in keycardnames )
            {
                if ( key == keycardquantity.keycard )
                {
                    isinstruct = 1;
                }
            }
            
            if ( !isinstruct )
            {
                keycardnames[ keycardnames.size ] = keycardquantity.keycard;
            }
        }
        
        if ( !isdefined( accesslevel.fallbackkeycard ) || accesslevel.fallbackkeycard == "" )
        {
            assertmsg( "<dev string:x24>" );
        }
    }
    
    level.biometricscan.keycards = [];
    
    foreach ( key in keycardnames )
    {
        card = getscriptbundle( hashcat( %"hash_3c55fc6554c4ff30", key ) );
        
        if ( !isdefined( card ) )
        {
            continue;
        }
        
        carditem = getscriptbundle( hashcat( %"itemspawnentry:", card.keycarditem ) );
        
        if ( !isdefined( carditem ) )
        {
            continue;
        }
        
        lootid = common_item::function_779887309ec71dfe( carditem );
        
        if ( !isdefined( lootid ) )
        {
            continue;
        }
        
        level.biometricscan.keycards[ lootid ] = card;
        level.biometricscan.keycards[ lootid ].keycarditem = carditem;
        level.biometricscan.keycards[ lootid ].assetname = key;
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0x43f93626, Offset: 0x12b1
// Size: 0x15
function function_473e0257fe7a4a4e( params )
{
    biometric_scan_set_owner( params );
}

// Namespace biometric_scan
// Params 1
// Checksum 0x1b5f2c36, Offset: 0x12ce
// Size: 0x15
function function_b8db1864ea38172c( params )
{
    biometric_scan_set_owner( params );
}

// Namespace biometric_scan
// Params 1
// Checksum 0xc382f3dc, Offset: 0x12eb
// Size: 0x84
function biometric_scan_set_owner( params )
{
    if ( !isdefined( params.spawn_options ) )
    {
        params.spawn_options = common_item::items_initspawnoptions_spawnfromentity( self );
    }
    
    if ( self && function_8ca3e0c125311a78() )
    {
        ownerid = params.ownerid ?? self getentitynumber();
        params.spawn_options.payload = [ #"teamselect", ownerid ];
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0xcf4654c7, Offset: 0x1377
// Size: 0x3e
function function_1ff1f8c6eec74532( params )
{
    if ( params.itemdata.type != "biometric_scan_keycard" )
    {
        updatefreeitemcount( params.player, -1 );
    }
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0x8a49492c, Offset: 0x13bd
// Size: 0x26
function private function_747da5c9402cd9e7()
{
    level endon( #"game_ended" );
    waitmatchstart();
    function_6e150ba45a6aa08( level.players, 34507 );
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0xcd272ee3, Offset: 0x13eb
// Size: 0x28
function private waitmatchstart()
{
    level endon( #"game_ended" );
    
    if ( !level.skipprematch )
    {
        level waittill( #"prematch_fade_done" );
    }
}

// Namespace biometric_scan
// Params 0, eflags: 0xc
// Checksum 0x62a66d06, Offset: 0x141b
// Size: 0x41
function private function_2d7359d031b67d16()
{
    self notify( #"hash_c8a0dd7a522402f" );
    self endon( #"hash_c8a0dd7a522402f" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 1.5;
    self function_fdf029c4be6546a3( 34507 );
}

// Namespace biometric_scan
// Params 2
// Checksum 0x82ef89b7, Offset: 0x1464
// Size: 0x1dc
function function_a657979790ce1853( achievementid, progressdata )
{
    if ( achievementid != 34507 )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !self isconnected() && getdvarint( @"hash_8230998271a4ef82", 1 ) == 1 )
    {
        return;
    }
    
    var_5d5b17f9ac4d0087 = playerachievements::function_a550b9c75bcbee5e( "progress" );
    timestampid = playerachievements::function_a550b9c75bcbee5e( "timestamp" );
    dailycount = 0;
    timestamp = 0;
    
    if ( !isdefined( level.biometricscan.var_e251c0e2d2fde595 ) )
    {
        level.biometricscan.var_e251c0e2d2fde595 = [];
    }
    
    foreach ( progressvalue in progressdata.progress_values )
    {
        if ( progressvalue.progress_id == var_5d5b17f9ac4d0087 )
        {
            dailycount = progressvalue.progress;
            continue;
        }
        
        if ( progressvalue.progress_id == timestampid )
        {
            timestamp = progressvalue.progress;
        }
    }
    
    playernum = self getentitynumber();
    previousvalue = level.biometricscan.var_e251c0e2d2fde595[ playernum ];
    level.biometricscan.var_e251c0e2d2fde595[ playernum ] = { #timestamp:timestamp, #dailycount:dailycount };
    
    if ( previousvalue.timestamp != timestamp )
    {
        function_8e479f27c3b1c56a( dailycount );
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0xf4dd0e58, Offset: 0x1648
// Size: 0xf3
function function_9b7443fe1500759c( accesslevel )
{
    var_9ba1f14c8daadbc6 = [];
    
    if ( !isarray( accesslevel.var_9ba1f14c8daadbc6 ) )
    {
        return var_9ba1f14c8daadbc6;
    }
    
    foreach ( keycardquantity in accesslevel.var_9ba1f14c8daadbc6 )
    {
        if ( !function_49f15b3b332644c4( keycardquantity.keycard ) )
        {
            continue;
        }
        
        var_46313938a19900c6 = { #keycard:keycardquantity.keycard, #quantityleft:keycardquantity.quantity };
        var_9ba1f14c8daadbc6[ var_9ba1f14c8daadbc6.size ] = var_46313938a19900c6;
    }
    
    return var_9ba1f14c8daadbc6;
}

// Namespace biometric_scan
// Params 1
// Checksum 0xae9c579e, Offset: 0x1744
// Size: 0x24, Type: bool
function function_49f15b3b332644c4( keycard )
{
    return getdvarint( hashcat( @"hash_ecc5914562f950d9", keycard ), 1 ) == 1;
}

// Namespace biometric_scan
// Params 0
// Checksum 0xd572b89, Offset: 0x1771
// Size: 0x12b
function init_vo()
{
    game[ "dialog" ][ level.biometricscan.defaultvo.var_b8d641c2feac762e ] = level.biometricscan.defaultvo.var_b8d641c2feac762e;
    game[ "dialog" ][ level.biometricscan.defaultvo.var_efab2302e219d557 ] = level.biometricscan.defaultvo.var_efab2302e219d557;
    
    foreach ( uniqueevent in level.biometricscan.dailyevents.unique )
    {
        game[ "dialog" ][ uniqueevent.voname ] = uniqueevent.voname;
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0xb2bbe74c, Offset: 0x18a4
// Size: 0x29, Type: bool
function function_4244d90a04a0dd6a( lootid )
{
    return isdefined( lootid ) && isdefined( level.biometricscan.keycards[ lootid ] );
}

// Namespace biometric_scan
// Params 2
// Checksum 0xdc00d33a, Offset: 0x18d6
// Size: 0x2c, Type: bool
function function_28da9178de9f074b( var_5a393f1961ec81d9, var_5a393c1961ec7b40 )
{
    return var_5a393f1961ec81d9.rating < var_5a393c1961ec7b40.rating;
}

#using_animtree( "script_model" );

// Namespace biometric_scan
// Params 0
// Checksum 0xeca02ec8, Offset: 0x190b
// Size: 0x22a
function script_model_anims()
{
    level.scr_animtree[ "biometric_scan" ] = #animtree;
    level.scr_anim[ "biometric_scan" ][ "use_biometric_scanner_enter" ] = %jup_biometric_scan_in_plr;
    level.scr_eventanim[ "biometric_scan" ][ "use_biometric_scanner_enter" ] = %"use_biometric_scanner_enter";
    level.scr_viewmodelanim[ "biometric_scan" ][ "use_biometric_scanner_enter" ] = "jup_biometric_scan_in_plr";
    level.scr_anim[ "biometric_scan" ][ "use_biometric_scanner_enter_cancel" ] = %jup_biometric_scan_in_cancel_plr;
    level.scr_eventanim[ "biometric_scan" ][ "use_biometric_scanner_enter_cancel" ] = %"use_biometric_scanner_enter_cancel";
    level.scr_viewmodelanim[ "biometric_scan" ][ "use_biometric_scanner_enter_cancel" ] = "jup_biometric_scan_in_cancel_plr";
    level.scr_anim[ "biometric_scan" ][ "use_biometric_scanner_to_idle" ] = %jup_biometric_scan_to_idle_plr;
    level.scr_eventanim[ "biometric_scan" ][ "use_biometric_scanner_to_idle" ] = %"use_biometric_scanner_to_idle";
    level.scr_viewmodelanim[ "biometric_scan" ][ "use_biometric_scanner_to_idle" ] = "jup_biometric_scan_to_idle_plr";
    level.scr_anim[ "biometric_scan" ][ "use_biometric_scanner_to_idle_cancel" ] = %jup_biometric_scan_to_idle_cancel_plr;
    level.scr_eventanim[ "biometric_scan" ][ "use_biometric_scanner_to_idle_cancel" ] = %"use_biometric_scanner_to_idle_cancel";
    level.scr_viewmodelanim[ "biometric_scan" ][ "use_biometric_scanner_to_idle_cancel" ] = "jup_biometric_scan_to_idle_cancel_plr";
    level.scr_anim[ "biometric_scan" ][ "use_biometric_scanner_idle" ] = %jup_biometric_scan_idle_plr;
    level.scr_eventanim[ "biometric_scan" ][ "use_biometric_scanner_idle" ] = %"use_biometric_scanner_idle";
    level.scr_viewmodelanim[ "biometric_scan" ][ "use_biometric_scanner_idle" ] = "jup_biometric_scan_idle_plr";
    level.scr_anim[ "biometric_scan" ][ "use_biometric_scanner_exit" ] = %jup_biometric_scan_exit_plr;
    level.scr_eventanim[ "biometric_scan" ][ "use_biometric_scanner_exit" ] = %"use_biometric_scanner_exit";
    level.scr_viewmodelanim[ "biometric_scan" ][ "use_biometric_scanner_exit" ] = "jup_biometric_scan_exit_plr";
}

// Namespace biometric_scan
// Params 4
// Checksum 0x7e31c79e, Offset: 0x1b3d
// Size: 0x196
function create_player_rig( animname, spawnpos, spawnang, biometric_scanner )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    self function_e19ccf4da1a61ba7( spawnpos );
    player_rig = spawn( "script_arms", self.origin, 0, 0, self );
    self.player_rig = player_rig;
    player_rig.origin = spawnpos;
    player_rig.angles = spawnang;
    player_rig.player = self;
    player_rig hide( 1 );
    player_rig.animname = animname;
    player_rig useanimtree( #animtree );
    player_rig.updatedversion = 1;
    self playerlinktoabsolute( player_rig, "tag_origin" );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot", "disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self unlink();
        self stopviewmodelanim();
        hackwaitframes = level.biometricscan.dvars.var_18ec3163e8e75c4e;
        
        while ( hackwaitframes > 0 )
        {
            waitframe();
            hackwaitframes -= 1;
        }
        
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig ) && player_rig islinked() )
    {
        player_rig unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
}

// Namespace biometric_scan
// Params 2
// Checksum 0xc4207ab1, Offset: 0x1cdb
// Size: 0x107
function function_483f0ff10b4dc0a( player, scanparams )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( level.biometricscan ) && isdefined( level.biometricscan.defaultvo ) && isdefined( level.biometricscan.defaultvo.var_efab2302e219d557 ) )
    {
        endvo = level.biometricscan.defaultvo.var_efab2302e219d557;
        
        if ( isdefined( scanparams ) && !scanparams.var_dba05c7ce32fc870 && endvo != "" )
        {
            soundoffset = anglestoforward( scanparams.instance.angles ) * 15;
            soundname = "dx_br_bisc_" + endvo;
            playsoundatpos( scanparams.instance.origin + soundoffset, soundname );
        }
    }
}

// Namespace biometric_scan
// Params 2
// Checksum 0xf5485c38, Offset: 0x1dea
// Size: 0xcc
function function_f62fb96965ebeead( player, scanparams )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    function_35e495b7b9ef418( player, scanparams );
    scanninganimloop( player );
    player notify( #"hash_ebcf6fcc820d1276" );
    function_483f0ff10b4dc0a( player, scanparams );
    function_1824977716edbe04( player );
    player notify( #"interact_finished" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"remove_rig" );
    }
    
    self notify( #"biometric_scanner_anim_end" );
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0xdb8c5106, Offset: 0x1ebe
// Size: 0x1b1
function private function_e61e521a946da14d( player, scanparams )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !( isdefined( level.biometricscan ) && isdefined( level.biometricscan.defaultvo ) && isdefined( level.biometricscan.defaultvo.var_b8d641c2feac762e ) && isdefined( level.biometricscan.defaultvo.var_efab2302e219d557 ) ) )
    {
        return;
    }
    
    startvo = level.biometricscan.defaultvo.var_b8d641c2feac762e;
    actualtime = undefined;
    
    if ( isdefined( scanparams.actualtime ) )
    {
        actualtime = scanparams.actualtime;
    }
    
    var_1fe1df2703b17b73 = player function_56996edb1f62a004();
    
    if ( player function_c96c6829672c52d6( actualtime ) )
    {
        var_1fe1df2703b17b73++;
    }
    
    endvo = function_a3ec69fbb7ba89dd( player, var_1fe1df2703b17b73, actualtime );
    
    if ( endvo != level.biometricscan.defaultvo.var_efab2302e219d557 && endvo != "" )
    {
        scanparams.var_dba05c7ce32fc870 = 1;
        startvo = endvo;
    }
    
    if ( startvo == "" )
    {
        return;
    }
    
    soundoffset = anglestoforward( scanparams.instance.angles ) * 15;
    soundname = "dx_br_bisc_" + startvo;
    playsoundatpos( scanparams.instance.origin + soundoffset, soundname );
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0x7528d16b, Offset: 0x2077
// Size: 0x147
function private function_e7f6e1462f6f222b( player, scanparams )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    playerpoints = function_402b09bf61a9ce6b( player );
    var_b21611d754864d23 = 0;
    
    if ( isdefined( level.biometricscan.accesslevels ) )
    {
        foreach ( accesslevel in level.biometricscan.accesslevels )
        {
            if ( playerpoints < accesslevel.rating )
            {
                break;
            }
            
            var_b21611d754864d23++;
        }
        
        if ( var_b21611d754864d23 > 0 )
        {
            var_b21611d754864d23--;
        }
    }
    
    player.var_b21611d754864d23 = var_b21611d754864d23;
    player.var_dbe2751ce7bd5663 = level.biometricscan.accesslevels[ var_b21611d754864d23 ].var_9084d7377eba366e;
    keycardweights = function_88258078cbabb924( player, scanparams, var_b21611d754864d23 );
    function_c5d2a176aee0ebba( player, keycardweights );
}

// Namespace biometric_scan
// Params 3
// Checksum 0x2c105c18, Offset: 0x21c6
// Size: 0x1a8
function function_88258078cbabb924( player, scanparams, var_e37b99fc0828a796 )
{
    accesslevel = level.biometricscan.accesslevels[ var_e37b99fc0828a796 ];
    
    if ( !( isdefined( player ) && isdefined( accesslevel ) && isdefined( accesslevel.var_9ba1f14c8daadbc6 ) ) || !isarray( accesslevel.var_9ba1f14c8daadbc6 ) )
    {
        return;
    }
    
    keycardweights = [];
    index = 0;
    lastindex = accesslevel.var_9ba1f14c8daadbc6.size - 1;
    totalquantity = 0;
    
    foreach ( keycardquantity in accesslevel.var_9ba1f14c8daadbc6 )
    {
        keycardweights[ index ] = spawnstruct();
        keycardweights[ index ].keycard = keycardquantity.keycard;
        keycardweights[ index ].weight = keycardquantity.quantityleft;
        totalquantity += keycardweights[ index ].weight;
        index++;
    }
    
    if ( totalquantity == 0 )
    {
        fallbackreward = { #weight:1, #keycard:accesslevel.fallbackkeycard };
        return [ fallbackreward ];
    }
    
    return keycardweights;
}

// Namespace biometric_scan
// Params 2
// Checksum 0x7e81db3b, Offset: 0x2377
// Size: 0x1aa
function function_c5d2a176aee0ebba( player, keycardweights )
{
    keycardgiven = getdvar( @"hash_f2fc3c35497a2558" );
    
    if ( keycardgiven )
    {
        player.var_def39213b61e25e4 = keycardgiven;
        player.var_ec3940d66dc6a40e = keycardgiven;
        return;
    }
    
    if ( !( isdefined( player ) && isdefined( keycardweights ) ) )
    {
        return;
    }
    
    /#
        logstring( "<dev string:x7a>" + player.name );
        
        foreach ( keycardweight in keycardweights )
        {
            if ( keycardweight.keycard != "<dev string:xbc>" )
            {
                logstring( "<dev string:xbd>" + keycardweight.weight + "<dev string:xd3>" + keycardweight.keycard + "<dev string:xe1>" );
            }
        }
    #/
    
    var_e2a759cde4fce836 = !isdefined( player.var_ec3940d66dc6a40e );
    
    /#
        var_e2a759cde4fce836 |= function_563635a45c3ee38e();
    #/
    
    if ( var_e2a759cde4fce836 )
    {
        selectedkeycard = utility::random_weighted_struct( keycardweights );
        
        if ( isdefined( selectedkeycard ) )
        {
            player.var_def39213b61e25e4 = selectedkeycard.keycard;
            player.var_ec3940d66dc6a40e = selectedkeycard.keycard;
        }
        
        return;
    }
    
    player.var_def39213b61e25e4 = player.var_ec3940d66dc6a40e;
}

// Namespace biometric_scan
// Params 1
// Checksum 0x7549bffd, Offset: 0x2529
// Size: 0x12d
function function_402b09bf61a9ce6b( player )
{
    playerpoints = 0;
    
    if ( !isplayer( player ) || !( isdefined( level.biometricscan ) && isdefined( level.biometricscan.rules ) ) )
    {
        return playerpoints;
    }
    
    player.var_983369ac8d904399 = spawnstruct();
    var_417b416ce0e91f78 = 0;
    
    if ( isdefined( player.pers[ "rankXpEarnedThisMatch" ] ) )
    {
        var_417b416ce0e91f78 = level.biometricscan.rules.var_7d620bdbdc523b18 > 0 ? player.pers[ "rankXpEarnedThisMatch" ] / level.biometricscan.rules.var_7d620bdbdc523b18 : player.pers[ "rankXpEarnedThisMatch" ];
        var_417b416ce0e91f78 = int( clamp( var_417b416ce0e91f78, 0, level.biometricscan.rules.var_c213caa12501e690 ) );
    }
    
    playerpoints += var_417b416ce0e91f78;
    player.var_983369ac8d904399.var_417b416ce0e91f78 = var_417b416ce0e91f78;
    return playerpoints;
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0x8531edc7, Offset: 0x265f
// Size: 0x26
function private user_player_goal_pos()
{
    return self.origin + rotatevector( ( 28.588, 0, 0 ), self.angles );
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0xbb8b2190, Offset: 0x268e
// Size: 0x1c
function private user_player_goal_angles()
{
    return combineangles( self.angles, ( 0, 180, 0 ) );
}

// Namespace biometric_scan
// Params 2
// Checksum 0x68a4289d, Offset: 0x26b3
// Size: 0x339
function function_35e495b7b9ef418( player, scanparams )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    level endon( #"game_ended" );
    player.linktoent = player utility::spawn_tag_origin( player.origin, player getplayerangles( 0 ) );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 0 );
    goalpos = user_player_goal_pos();
    var_a5c7f9a58e98468a = ( 0, 0, 0 );
    targetlocalangles = combineangles( ( 0, 180, 0 ), var_a5c7f9a58e98468a );
    goalangles = combineangles( self.angles, targetlocalangles );
    movetotime = 0.5;
    
    if ( isdefined( self.linkedparent ) )
    {
        player.linktoent childthread function_ff6a9e0fd2df659f( self, ( 28.588, 0, 0 ), targetlocalangles, movetotime );
    }
    else
    {
        player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
        player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    }
    
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = max( 0, movetotime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000 );
    wait var_ed2a546b70aa8095;
    
    if ( isdefined( player.linktoent ) )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    player setorigin( user_player_goal_pos() );
    player setplayerangles( user_player_goal_angles() );
    self notify( #"biometric_scanner_anim_start" );
    player.var_c097c59d72afee1d = "use_biometric_scanner_enter";
    player thread create_player_rig( "biometric_scan", user_player_goal_pos(), user_player_goal_angles(), self );
    
    if ( !player getcamerathirdperson() )
    {
        player.player_rig showonlytoplayer( player );
    }
    
    if ( !isdefined( self.animstruct ) )
    {
        animstruct = spawnstruct();
        animstruct.origin = self.origin;
        animstruct.angles = combineangles( self.angles, combineangles( ( 0, 180, 0 ), ( 0, 180, 0 ) ) );
        self.animstruct = animstruct;
    }
    
    self.animstruct anim_mp::anim_player_solo( player, player.player_rig, player.var_c097c59d72afee1d );
    thread function_e61e521a946da14d( player, scanparams );
    player.var_c097c59d72afee1d = "use_biometric_scanner_to_idle";
    self.animstruct anim_mp::anim_player_solo( player, player.player_rig, player.var_c097c59d72afee1d );
}

// Namespace biometric_scan
// Params 4, eflags: 0x4
// Checksum 0xa053751f, Offset: 0x29f4
// Size: 0x17d
function private function_ff6a9e0fd2df659f( biometric_scan, goaloffset, goalangles, movetotime )
{
    start_time_ms = gettime();
    end_time_ms = gettime() + movetotime * 1000;
    startoffset = rotatevectorinverted( self.origin - biometric_scan.origin, biometric_scan.angles );
    startangles = combineanglesinverted( biometric_scan.angles, self.angles );
    var_53cd747214a41b61 = biometric_scan.origin;
    
    while ( isdefined( self ) && gettime() < end_time_ms )
    {
        eff_time = gettime() + getframeduration();
        t = ( eff_time - start_time_ms ) / movetotime * 1000;
        deltapos = biometric_scan.origin - var_53cd747214a41b61;
        targetoffset = vectorlerp( startoffset, goaloffset, t );
        self.origin = biometric_scan.origin + rotatevector( targetoffset, biometric_scan.angles ) + deltapos;
        worldangles = combineangles( biometric_scan.angles, anglelerpquatfrac( startangles, goalangles, t ) );
        self.angles = worldangles;
        var_53cd747214a41b61 = biometric_scan.origin;
        waitframe();
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0xb2b29625, Offset: 0x2b79
// Size: 0xb4
function scanninganimloop( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    player.var_c097c59d72afee1d = "use_biometric_scanner_idle";
    level.var_42253610dcf4fc1f = 0;
    thread function_903b32d0260275a3( player );
    
    while ( player::isreallyalive( player ) && !level.var_42253610dcf4fc1f )
    {
        self.animstruct anim_mp::anim_player_solo( player, player.player_rig, player.var_c097c59d72afee1d );
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0xb6466f41, Offset: 0x2c35
// Size: 0x75
function function_903b32d0260275a3( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    wait level.biometricscan.dvars.var_70ae23d3c58de2b6;
    level.var_42253610dcf4fc1f = 1;
}

// Namespace biometric_scan
// Params 1
// Checksum 0xafe3d3b, Offset: 0x2cb2
// Size: 0x1da
function function_1824977716edbe04( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    
    foreach ( card in level.biometricscan.keycards )
    {
        if ( card.assetname == player.var_def39213b61e25e4 )
        {
            scriptablename = card.keycarditem.scriptable;
            self.cardprop = spawnscriptable( scriptablename, self.origin, self.angles );
            self.cardprop setscriptablepartstate( self.cardprop.type, "scanner_anim" );
            break;
        }
    }
    
    player.var_c097c59d72afee1d = "use_biometric_scanner_exit";
    
    if ( player::isreallyalive( player ) )
    {
        self.animstruct anim_mp::anim_player_solo( player, player.player_rig, player.var_c097c59d72afee1d );
    }
    
    if ( isent( self.animstruct ) )
    {
        self.animstruct delete();
        self.animstruct = undefined;
    }
    
    if ( isdefined( self.cardprop ) )
    {
        self.cardprop freescriptable();
        self.cardprop = undefined;
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0x3a76ceba, Offset: 0x2e94
// Size: 0x193
function watchcancelinteraction( player )
{
    level endon( #"game_ended" );
    player endon( #"interact_interrupt" );
    player endon( #"interact_finished" );
    player endon( #"hash_ebcf6fcc820d1276" );
    player endon( #"disconnect" );
    self waittill( #"biometric_scanner_anim_start" );
    waitframe();
    thread function_201585ba44d024( player );
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommand( "interact_cancel_input", "+weapnext" );
    }
    
    msg = player utility::waittill_any_timeout_no_endon_death( 20, "interact_cancel_input", "damage_begin" );
    player notify( #"interact_cancelled" );
    cancelanim = player function_b548eb0755a9656a();
    
    if ( isdefined( self.animstruct ) && isdefined( cancelanim ) && isdefined( player.player_rig ) )
    {
        self.animstruct anim_mp::anim_player_solo( player, player.player_rig, cancelanim );
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"remove_rig" );
        player.var_def39213b61e25e4 = undefined;
        player.var_96a6b65de786d142 = 0;
        player function_e11e64a823cf9b2f( 0 );
        player function_1d1f951947470dd5( 1 );
    }
    
    if ( isdefined( self.cardprop ) )
    {
        self.cardprop freescriptable();
        self.cardprop = undefined;
    }
    
    self setscriptablepartstate( "biometric_scanner", "usable" );
    self setscriptablepartstate( "biometric_scanner_screen", "screen_opened_idle" );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x611a0543, Offset: 0x3030
// Size: 0x46
function private function_201585ba44d024( player )
{
    player utility::waittill_any( "interact_cancelled", "interact_interrupt", "interact_finished" );
    
    if ( isdefined( player ) && !isbot( player ) )
    {
        player notifyonplayercommandremove( "interact_cancel_input", "+weapnext" );
    }
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0x208e635, Offset: 0x307e
// Size: 0x76
function private function_b548eb0755a9656a()
{
    cancelanim = undefined;
    
    if ( isdefined( self.var_c097c59d72afee1d ) )
    {
        switch ( self.var_c097c59d72afee1d )
        {
            case #"hash_742ba8a65f9e91cd":
                cancelanim = "use_biometric_scanner_enter_cancel";
                break;
            case #"hash_505d2a54e7196797":
            case #"hash_f7725c3d78ba3d53":
                cancelanim = "use_biometric_scanner_to_idle_cancel";
                break;
            default:
                break;
        }
    }
    
    return cancelanim;
}

// Namespace biometric_scan
// Params 0
// Checksum 0x7d672e66, Offset: 0x30fd
// Size: 0x13, Type: bool
function biometric_scan_isenabled()
{
    return getdvarint( @"scr_enable_biometric_scan", 0 ) == 1;
}

// Namespace biometric_scan
// Params 0
// Checksum 0xbad49651, Offset: 0x3119
// Size: 0x14, Type: bool
function function_8ca3e0c125311a78()
{
    return getdvarint( @"hash_d18990018258dfc6", 1 ) == 1;
}

// Namespace biometric_scan
// Params 1
// Checksum 0x7da9d2d8, Offset: 0x3136
// Size: 0x64
function function_139d58d75da4222( structname )
{
    var_2255f6c3da397913 = utility::getstructarray( structname, "targetname" );
    
    if ( !isdefined( var_2255f6c3da397913 ) || var_2255f6c3da397913.size < 1 )
    {
        var_2255f6c3da397913 = utility::getstructarray( "biometric_scan", "targetname" );
    }
    
    if ( isdefined( level.var_b175dc61512a0910 ) )
    {
        var_2255f6c3da397913 = [[ level.var_b175dc61512a0910 ]]();
    }
    
    return var_2255f6c3da397913;
}

// Namespace biometric_scan
// Params 2
// Checksum 0x9c7f2de8, Offset: 0x31a3
// Size: 0x44
function function_a083f2b6e004ae80( structname, var_740794cab9186fcc )
{
    if ( !isdefined( level.var_112bd8f3812f78ae ) )
    {
        level.var_112bd8f3812f78ae = [];
    }
    
    level.var_112bd8f3812f78ae[ level.var_112bd8f3812f78ae.size ] = var_740794cab9186fcc;
    return var_740794cab9186fcc;
}

// Namespace biometric_scan
// Params 1
// Checksum 0x2e173804, Offset: 0x31f0
// Size: 0xe2
function function_e205a2d61da8d464( structname )
{
    level endon( #"game_ended" );
    waitmatchstart();
    waitframe();
    
    if ( !isdefined( level.var_112bd8f3812f78ae ) || level.var_112bd8f3812f78ae.size == 0 )
    {
        return;
    }
    
    foreach ( loc in level.var_112bd8f3812f78ae )
    {
        function_724b465f15a7879c( loc, level.biometricscan.var_e26ce79589ef9efd );
        waitframe();
    }
    
    level.var_112bd8f3812f78ae = undefined;
    level notify( #"hash_d39a712869590a04" );
}

// Namespace biometric_scan
// Params 2
// Checksum 0x6fc43156, Offset: 0x32da
// Size: 0x53
function function_724b465f15a7879c( var_740794cab9186fcc, var_72018eec9bcac4be )
{
    assert( isdefined( level.var_904f7a4736d5940e ) );
    var_2e52deef68e36854 = level.var_904f7a4736d5940e.size;
    var_9a6f37e38a82410a = function_bce5b5d6ca87ebe5( var_740794cab9186fcc, var_2e52deef68e36854, var_72018eec9bcac4be );
    return var_9a6f37e38a82410a;
}

// Namespace biometric_scan
// Params 3
// Checksum 0x82db7699, Offset: 0x3336
// Size: 0x10b
function function_bce5b5d6ca87ebe5( var_740794cab9186fcc, identifier, var_72018eec9bcac4be )
{
    if ( !isdefined( var_740794cab9186fcc.angles ) )
    {
        var_740794cab9186fcc.angles = ( 0, 0, 0 );
    }
    
    scriptablename = "jup_biometric_scanner";
    
    if ( isdefined( var_72018eec9bcac4be ) )
    {
        scriptablename = var_72018eec9bcac4be;
    }
    
    scriptable = spawnscriptable( scriptablename, var_740794cab9186fcc.origin, var_740794cab9186fcc.angles );
    scriptable setscriptablepartstate( "biometric_scanner_screen", "screen_closed" );
    var_740794cab9186fcc.biometric_scan_station = scriptable;
    scriptable.var_740794cab9186fcc = var_740794cab9186fcc;
    scriptable.identifier = identifier;
    scriptable.gasdisabled = 0;
    scriptable.typeid = 0;
    level.var_904f7a4736d5940e[ level.var_904f7a4736d5940e.size ] = var_740794cab9186fcc;
    scriptable interaction::set_interact_hint_callback( &function_3cf4ef437089c9b3 );
    scriptable thread function_829704847004f78f();
    return scriptable;
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0x4c8636b3, Offset: 0x344a
// Size: 0x5e
function private function_3cf4ef437089c9b3( usable, player )
{
    if ( isdefined( player ) )
    {
        return { #string:&"mp/br_biometric_scan_activate_hint", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace biometric_scan
// Params 1
// Checksum 0xc51b92ee, Offset: 0x34b1
// Size: 0x166
function function_1d1f951947470dd5( isallowed )
{
    if ( !isallowed )
    {
        val::set( "scanning", "allow_jump", 0 );
        val::set( "scanning", "gesture", 0 );
        val::set( "scanning", "melee", 0 );
        val::set( "scanning", "mantle", 0 );
        val::set( "scanning", "offhand_weapons", 0 );
        val::set( "scanning", "allow_movement", 0 );
        val::set( "scanning", "sprint", 0 );
        val::set( "scanning", "fire", 0 );
        val::set( "scanning", "reload", 0 );
        val::set( "scanning", "weapon_pickup", 0 );
        val::set( "scanning", "weapon_switch", 0 );
        val::set( "scanning", "offhand_weapons", 0 );
        val::set( "scanning", "execution_victim", 0 );
        val::set( "scanning", "supers", 0 );
        val::set( "scanning", "usability", 0 );
        val::set( "scanning", "allow_toggle_third_person", 0 );
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
        self function_60e112d2e106b00a();
        return;
    }
    
    val::reset_all( "scanning" );
    self setclientomnvar( "ui_br_inventory_disabled", 0 );
    self function_7d73d6786e51ae1f();
}

// Namespace biometric_scan
// Params 6
// Checksum 0xe3f5598e, Offset: 0x361f
// Size: 0x17c
function scanner_used( instance, part, state, player, bautouse, usestring )
{
    if ( !isplayer( player ) || !isdefined( level.biometricscan ) )
    {
        return;
    }
    
    if ( !player::isaliveandnotinlaststand( player ) )
    {
        return;
    }
    
    if ( player.var_96a6b65de786d142 )
    {
        return;
    }
    
    player.var_96a6b65de786d142 = 1;
    scanparams = function_505affa8e1fbfe72( instance, player );
    
    if ( !scanparams.canuse )
    {
        player function_7b52d963318174e0( scanparams.errormsg );
        player.var_96a6b65de786d142 = 0;
        return;
    }
    
    waittime = 0;
    
    if ( player getstance() == "prone" )
    {
        waittime = 0.2;
    }
    
    player setstance( "stand", 1, 1, 0 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    instance setscriptablepartstate( "biometric_scanner", "in_use" );
    instance setscriptablepartstate( "biometric_scanner_screen", "camera_scanning" );
    
    if ( scanparams.rewardskeycard )
    {
        player.var_def39213b61e25e4 = undefined;
        instance function_e7f6e1462f6f222b( player, scanparams );
        
        if ( !isdefined( player.var_def39213b61e25e4 ) )
        {
            player function_7b52d963318174e0( "MP/BR_BIOMETRIC_SCAN_USE_ERROR_MSG" );
            player.var_96a6b65de786d142 = 0;
            return;
        }
    }
    
    instance thread function_a445bc8836ab9070( player, scanparams );
}

// Namespace biometric_scan
// Params 1
// Checksum 0x9c70be70, Offset: 0x37a3
// Size: 0x5c
function function_7b52d963318174e0( message )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( soundexists( "fly_pickup_deny" ) )
    {
        player playlocalsound( "fly_pickup_deny" );
    }
    
    if ( isdefined( level.showerrormessagefunc ) )
    {
        player [[ level.showerrormessagefunc ]]( "MP/BR_BIOMETRIC_SCAN_USE_ERROR_MSG" );
    }
}

// Namespace biometric_scan
// Params 2
// Checksum 0x569f08c8, Offset: 0x3807
// Size: 0x109
function function_505affa8e1fbfe72( instance, player )
{
    params = spawnstruct();
    params.instance = instance;
    params.player = player;
    params.canuse = 0;
    params.errormsg = "MP/BR_BIOMETRIC_SCAN_USE_ERROR_MSG";
    params.var_dba05c7ce32fc870 = 0;
    params.actualtime = getsystemtime();
    isvaliduse = !isdefined( player.var_def39213b61e25e4 );
    
    /#
        isvaliduse |= function_563635a45c3ee38e();
    #/
    
    if ( isvaliduse )
    {
        params.canuse = 1;
        params.rewardskeycard = 1;
        params.requiresanimation = 1;
        params.resetui = isdefined( player.var_def39213b61e25e4 );
    }
    
    if ( isdefined( instance.var_4387eb4906496f72 ) )
    {
        [[ instance.var_4387eb4906496f72 ]]( params );
    }
    
    return params;
}

// Namespace biometric_scan
// Params 2
// Checksum 0xb5399506, Offset: 0x3919
// Size: 0x1c2
function function_a445bc8836ab9070( player, scanparams )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( player ) || !( isdefined( level.biometricscan ) && isdefined( scanparams ) ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    thread function_229c08eed7fc92a( player, scanparams );
    
    if ( scanparams.requiresanimation )
    {
        player function_1d1f951947470dd5( 0 );
        thread watchplayerdeathordisconnect( player );
        thread watchcancelinteraction( player );
        thread function_f62fb96965ebeead( player, scanparams );
        self waittill( #"biometric_scanner_anim_end" );
        player function_1d1f951947470dd5( 1 );
        self setscriptablepartstate( "biometric_scanner_screen", "screen_opened_idle" );
    }
    
    if ( getdvarint( @"hash_53f7f74faf5f5642", 1 ) && isdefined( scanparams.actualtime ) )
    {
        player function_ad9ac915bc1cdd89( scanparams.actualtime );
    }
    
    if ( scanparams.rewardskeycard && getdvarint( @"hash_4f733549eacc19e7", 1 ) )
    {
        function_ea84291a682e3f50( player );
        function_f5869a3a6d775ac2( player, player.var_def39213b61e25e4 );
        challenges::function_37e945722d6497f3( player, "biometric_scan_keycard", 1 );
    }
    
    player points::doscoreevent( #"br_biometric_scanner_used" );
    
    if ( isdefined( scanparams.var_60c9b8a3e008af5c ) )
    {
        params = { #player:player, #instance:self };
        thread [[ scanparams.var_60c9b8a3e008af5c ]]( params );
    }
    
    player.var_96a6b65de786d142 = 0;
    self setscriptablepartstate( "biometric_scanner", "usable" );
}

// Namespace biometric_scan
// Params 1
// Checksum 0xdd2c898f, Offset: 0x3ae3
// Size: 0x140
function watchplayerdeathordisconnect( player )
{
    level endon( #"game_ended" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_finished" );
    msg = player utility::waittill_any_return( "death", "disconnect", "enter_live_ragdoll", "last_stand_enter", "execution_begin_victim" );
    
    if ( isdefined( player ) )
    {
        player notify( #"interact_interrupt" );
        player stopanimscriptsceneevent();
        
        if ( isdefined( player.linktoent ) )
        {
            player unlink();
            player.linktoent delete();
            player.linktoent = undefined;
        }
        
        if ( msg == "last_stand_enter" || msg == "death" )
        {
            player notify( #"remove_rig" );
        }
        
        player.var_def39213b61e25e4 = undefined;
        player.var_96a6b65de786d142 = 0;
        player function_e11e64a823cf9b2f( 0 );
        player function_1d1f951947470dd5( 1 );
    }
    
    if ( isdefined( self.cardprop ) )
    {
        self.cardprop freescriptable();
        self.cardprop = undefined;
    }
    
    self setscriptablepartstate( "biometric_scanner", "usable" );
    self setscriptablepartstate( "biometric_scanner_screen", "screen_opened_idle" );
}

// Namespace biometric_scan
// Params 2
// Checksum 0xc85ee2cb, Offset: 0x3c2b
// Size: 0x9b
function function_229c08eed7fc92a( player, scanparams )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    player endon( #"interact_cancelled" );
    player endon( #"interact_interrupt" );
    
    if ( scanparams.resetui )
    {
        player function_e11e64a823cf9b2f( 0 );
    }
    
    if ( scanparams.requiresanimation )
    {
        self waittill( #"biometric_scanner_anim_start" );
    }
    
    function_30242cf5273a23f8( player, scanparams );
    player function_e11e64a823cf9b2f( 1 );
}

// Namespace biometric_scan
// Params 2
// Checksum 0xf0c4e56, Offset: 0x3cce
// Size: 0x191
function function_30242cf5273a23f8( player, scanparams )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( scanparams ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_983369ac8d904399 ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_dbe2751ce7bd5663 ) )
    {
        return;
    }
    
    if ( !( isdefined( level.biometricscan.keycards ) && isdefined( player.var_def39213b61e25e4 ) ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_biometric_scan_match_xp", player.var_983369ac8d904399.var_417b416ce0e91f78 );
    player function_12b7b963f8039562( player.var_dbe2751ce7bd5663 );
    
    if ( player function_c96c6829672c52d6( scanparams.actualtime ) )
    {
        player function_8e479f27c3b1c56a( player function_56996edb1f62a004() + 1 );
    }
    
    foreach ( card in level.biometricscan.keycards )
    {
        if ( card.assetname == player.var_def39213b61e25e4 )
        {
            lootid = common_item::function_779887309ec71dfe( card.keycarditem );
            player setclientomnvar( "ui_biometric_scan_keycard_loot_id", lootid );
            break;
        }
    }
}

// Namespace biometric_scan
// Params 0
// Checksum 0x9eff896f, Offset: 0x3e67
// Size: 0x7c
function function_829704847004f78f()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_1f94c6e0df0da332 = cos( level.biometricscan.dvars.scannersightfov / 2 );
    
    while ( true )
    {
        function_542b4282bcde82de( var_1f94c6e0df0da332 );
        wait level.biometricscan.dvars.var_8bb98c611427ce5a;
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0x37308a67, Offset: 0x3eeb
// Size: 0x117, Type: bool
function function_6e1c2a09354e7c11( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( !isdefined( level.biometricscan.dvars ) )
    {
        return false;
    }
    
    if ( !level.biometricscan.dvars.var_bb8c5dd46866287d )
    {
        return true;
    }
    
    scannereyepos = self.origin + ( 0, 0, 100 );
    
    foreach ( playertag in level.biometricscan.var_8c28d018f83d82a0 )
    {
        var_f24faa2a30005d2f = player gettagorigin( playertag );
        
        if ( sighttracepassed( scannereyepos, var_f24faa2a30005d2f, 1, player, undefined, 1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace biometric_scan
// Params 1
// Checksum 0x34b8f308, Offset: 0x400b
// Size: 0x11d
function function_542b4282bcde82de( var_1f94c6e0df0da332 )
{
    nearbyplayers = getplayersinradius( self.origin, level.biometricscan.dvars.var_86b4c0aff48167d3 );
    var_e2f435bb21dcacfd = 0;
    
    foreach ( player in nearbyplayers )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player function_5f4e453fd20bd4d6( self.typeid );
        
        if ( !var_e2f435bb21dcacfd && utility::within_fov( self.origin, self.angles, player.origin, var_1f94c6e0df0da332 ) && function_6e1c2a09354e7c11( player ) )
        {
            var_e2f435bb21dcacfd = 1;
        }
    }
    
    function_7996c4f81e8a3b56( var_e2f435bb21dcacfd );
}

// Namespace biometric_scan
// Params 1
// Checksum 0x39c0ac8a, Offset: 0x4130
// Size: 0x4e
function function_7996c4f81e8a3b56( var_e2f435bb21dcacfd )
{
    if ( self.var_e2f435bb21dcacfd != var_e2f435bb21dcacfd )
    {
        if ( var_e2f435bb21dcacfd )
        {
            self setscriptablepartstate( "biometric_scanner_screen", "screen_opened" );
        }
        else
        {
            self setscriptablepartstate( "biometric_scanner_screen", "screen_closed" );
        }
        
        self.var_e2f435bb21dcacfd = var_e2f435bb21dcacfd;
    }
}

// Namespace biometric_scan
// Params 0
// Checksum 0x25cd9bb1, Offset: 0x4186
// Size: 0xdf
function function_d91c303de280bb4e()
{
    level endon( #"game_ended" );
    waitmatchstart();
    level.biometricscan.throttle = throttle::throttle_initialize( "biometric_scan_proximity_check", level.biometricscan.dvars.var_43c6f5cbbf5503cc );
    
    foreach ( player in level.players )
    {
        player thread function_da283b8e9189705f();
    }
    
    callback::add( #"player_connect", &function_da283b8e9189705f );
}

// Namespace biometric_scan
// Params 1
// Checksum 0x388d5fd1, Offset: 0x426d
// Size: 0xc7
function function_da283b8e9189705f( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.biometricscan.dvars.var_42bb74d07f85e048 <= 0 )
    {
        function_603430744cd90359( 1 );
        return;
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.biometricscan.throttle, self );
        
        if ( isalive( self ) )
        {
            var_1b5caea60ff589bb = function_659a3f3a583ccb44();
            function_603430744cd90359( var_1b5caea60ff589bb );
            continue;
        }
        
        if ( var_1b5caea60ff589bb )
        {
            wait level.biometricscan.dvars.death_scene_time_sec;
            var_1b5caea60ff589bb = 0;
            function_603430744cd90359( 0 );
        }
    }
}

// Namespace biometric_scan
// Params 0
// Checksum 0xcc51038e, Offset: 0x433c
// Size: 0x46, Type: bool
function function_659a3f3a583ccb44()
{
    var_a4435d4c857b005e = function_6a293b884c444a20( level.var_904f7a4736d5940e, self.origin, level.biometricscan.dvars.var_42bb74d07f85e048 );
    return var_a4435d4c857b005e.size > 0;
}

// Namespace biometric_scan
// Params 1
// Checksum 0x757ebeda, Offset: 0x438b
// Size: 0x86
function function_330464bfe41fa0e( params )
{
    foreach ( player in level.players )
    {
        player function_603430744cd90359( 0 );
    }
}

// Namespace biometric_scan
// Params 0
// Checksum 0xc9a4278, Offset: 0x4419
// Size: 0x93
function function_d88ca622c5b3be3f()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    var_2255f6c3da397913 = function_139d58d75da4222( "biometric_scan" );
    
    if ( var_2255f6c3da397913.size == 0 )
    {
        return;
    }
    
    waitmatchstart();
    var_2e52deef68e36854 = 0;
    
    for ( var_ce01e334ae6ff40c = 0; var_ce01e334ae6ff40c < var_2255f6c3da397913.size ; var_ce01e334ae6ff40c++ )
    {
        var_740794cab9186fcc = var_2255f6c3da397913[ var_ce01e334ae6ff40c ];
        function_bce5b5d6ca87ebe5( var_740794cab9186fcc, var_2e52deef68e36854 );
        var_2e52deef68e36854++;
        waitframe();
    }
    
    level notify( #"hash_d39a712869590a04" );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x3c82ff16, Offset: 0x44b4
// Size: 0xad
function private function_e2070732b6a3ee40( keycardassetname )
{
    foreach ( card in level.biometricscan.keycards )
    {
        if ( card.assetname == keycardassetname )
        {
            return card.keycarditem.scriptable;
        }
    }
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0x2414fb9b, Offset: 0x456a
// Size: 0x18b
function private function_8cb1b20eaf219f24( scriptablename, options )
{
    if ( !( isdefined( self ) && isdefined( scriptablename ) ) )
    {
        return;
    }
    
    fakeitem = options.baseitem ?? spawnstruct();
    
    if ( !isdefined( fakeitem.type ) )
    {
        fakeitem.type = scriptablename;
    }
    
    if ( !isdefined( fakeitem.count ) )
    {
        fakeitem.count = options.count;
    }
    
    if ( !isdefined( fakeitem.fromcache ) )
    {
        fakeitem.fromcache = options.fromcache;
    }
    
    if ( !isdefined( options.forcedrop ) )
    {
        options.forcedrop = istrue( level.biometricscan.dvars.var_7a9c5edb76cb0d6d );
    }
    
    quantityequipped = options.forcedrop ? 0 : common_item::function_96119bed8ab4c5d9( fakeitem, options.autouse, 1 );
    
    if ( quantityequipped == 0 )
    {
        spawnoptions = options.spawnoptions ?? common_item::items_initspawnoptions_spawnfromentity( self );
        item = common_item::items_spawnitemfromscriptable( scriptablename, fakeitem.count, spawnoptions );
        
        if ( isdefined( fakeitem.perks ) && !isdefined( item.perks ) )
        {
            item.perks = fakeitem.perks;
        }
    }
}

// Namespace biometric_scan
// Params 3, eflags: 0x4
// Checksum 0xbdd188f8, Offset: 0x46fd
// Size: 0x15d
function private function_e7d43c841a24b00b( listbundlename, count, options )
{
    if ( !( isdefined( self ) && isdefined( listbundlename ) ) )
    {
        return;
    }
    
    if ( !isdefined( options.forcedrop ) )
    {
        options.forcedrop = istrue( level.biometricscan.dvars.var_7a9c5edb76cb0d6d );
    }
    
    if ( !options.forcedrop )
    {
        items = common_item::items_selectfromlist( listbundlename, count );
        
        foreach ( itembundlename in items )
        {
            if ( !isdefined( itembundlename ) )
            {
                continue;
            }
            
            itembundle = getscriptbundle( itembundlename );
            options.count = common_item::function_ea3b3088d82fd357( itembundle );
            function_8cb1b20eaf219f24( itembundle.scriptable, options );
        }
        
        return;
    }
    
    spawnoptions = options.spawnoptions ?? common_item::items_initspawnoptions_spawnfromentity( self );
    common_item::function_38cde6a6acb68ea6( listbundlename, count, spawnoptions );
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0x69656d8e, Offset: 0x4862
// Size: 0x115
function private function_ea84291a682e3f50( player, forcedrop = 0 )
{
    if ( !isplayer( player ) || !( isdefined( level.biometricscan ) && isdefined( level.biometricscan.keycards ) ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_def39213b61e25e4 ) )
    {
        return;
    }
    
    scriptableref = function_e2070732b6a3ee40( player.var_def39213b61e25e4 );
    
    if ( !isdefined( scriptableref ) )
    {
        return;
    }
    
    /#
        logstring( "<dev string:xe9>" + player.var_def39213b61e25e4 + "<dev string:x10c>" + player.name + "<dev string:x118>" );
    #/
    
    params = spawnstruct();
    player biometric_scan_set_owner( params );
    player function_8cb1b20eaf219f24( scriptableref, { #spawnoptions:params.spawnoptions, #forcedrop:forcedrop, #count:1 } );
    function_64ad0cd9dc93ec04( player );
    function_9974d2b12c6aa6ab( player, scriptableref );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x8113018c, Offset: 0x497f
// Size: 0xef
function private function_64ad0cd9dc93ec04( player )
{
    accesslevel = level.biometricscan.accesslevels[ player.var_b21611d754864d23 ];
    keycardname = player.var_def39213b61e25e4;
    
    foreach ( keycardquantity in accesslevel.var_9ba1f14c8daadbc6 )
    {
        if ( keycardname == keycardquantity.keycard )
        {
            keycardquantity.quantityleft = max( keycardquantity.quantityleft - 1, 0 );
            break;
        }
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0xa2b148e0, Offset: 0x4a76
// Size: 0xea, Type: bool
function function_c96c6829672c52d6( actualtime )
{
    if ( !isint( actualtime ) )
    {
        return false;
    }
    
    if ( !isdefined( level.biometricscan.dvars.var_d76357161900b37c ) )
    {
        return false;
    }
    
    var_40ddf3147a4680a3 = function_56996edb1f62a004();
    
    if ( var_40ddf3147a4680a3 >= level.biometricscan.dvars.var_d76357161900b37c )
    {
        return false;
    }
    
    /#
        if ( function_e513625ef06a8803() )
        {
            return true;
        }
    #/
    
    lasttime = function_506c23ad3e5fa8b();
    lastday = floor( ( lasttime + level.biometricscan.dailycutoff ) / 86400 );
    currentday = floor( ( actualtime + level.biometricscan.dailycutoff ) / 86400 );
    return currentday > lastday;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x16d812ea, Offset: 0x4b69
// Size: 0x39
function private function_95b4e6c3870549ec( actualtime )
{
    if ( !isint( actualtime ) )
    {
        return 0;
    }
    
    if ( function_c96c6829672c52d6( actualtime ) )
    {
        challenges::function_37e945722d6497f3( self, "biometric_scan_daily_scan", 1 );
        thread function_2d7359d031b67d16();
    }
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0xd1291aa7, Offset: 0x4baa
// Size: 0x15
function private function_ad9ac915bc1cdd89( actualtime )
{
    function_95b4e6c3870549ec( actualtime );
}

// Namespace biometric_scan
// Params 3, eflags: 0x4
// Checksum 0x64d779d6, Offset: 0x4bc7
// Size: 0x120
function private function_a3ec69fbb7ba89dd( player, dailyusecount, actualtime )
{
    if ( !isplayer( player ) )
    {
        return level.biometricscan.defaultvo.var_efab2302e219d557;
    }
    
    if ( player function_c96c6829672c52d6( actualtime ) )
    {
        foreach ( dailyevent in level.biometricscan.dailyevents.unique )
        {
            if ( dailyevent.day == dailyusecount && isdefined( dailyevent.voname ) )
            {
                return dailyevent.voname;
            }
        }
    }
    
    return level.biometricscan.defaultvo.var_efab2302e219d557;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x3203e866, Offset: 0x4cf0
// Size: 0x1ec
function private function_336cd6b0edba981e( lootgroup )
{
    filteredrewards = [];
    
    foreach ( entry in lootgroup.spawnlists )
    {
        if ( entry.spawnlist && entry.weight && entry.itemcount )
        {
            filteredrewards[ filteredrewards.size ] = entry;
        }
    }
    
    foreach ( loot in lootgroup.var_94edd5fb01b7159d )
    {
        if ( !isdefined( loot.item ) || loot.item == "" || loot.weight == 0 || loot.quantity == 0 )
        {
            continue;
        }
        
        lootitem = getscriptbundle( loot.item );
        
        if ( !isdefined( lootitem.scriptable ) || lootitem.scriptable == %"" )
        {
            continue;
        }
        
        groupitem = structcopy( loot, 0 );
        groupitem.item = lootitem.scriptable;
        filteredrewards[ filteredrewards.size ] = groupitem;
    }
    
    return filteredrewards;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0xa536fa9a, Offset: 0x4ee5
// Size: 0x119
function private function_5a3fd97afb8d7573( class )
{
    if ( !isdefined( level.biometricscan.redactedweapons ) || level.biometricscan.redactedweapons.size <= 0 )
    {
        return;
    }
    
    redactedweapons = [];
    
    foreach ( redactedweapon in level.biometricscan.redactedweapons )
    {
        if ( redactedweapon.class == class )
        {
            redactedweapons[ redactedweapons.size ] = redactedweapon;
        }
    }
    
    var_a236b1c3c8b9e130 = undefined;
    
    if ( redactedweapons.size > 0 )
    {
        var_a236b1c3c8b9e130 = utility::array_random( redactedweapons );
    }
    else
    {
        var_a236b1c3c8b9e130 = utility::array_random( level.biometricscan.redactedweapons );
    }
    
    return var_a236b1c3c8b9e130;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0xabb65bdf, Offset: 0x5007
// Size: 0x119
function private function_14cd7a636e3c3d1a( weaponcount )
{
    count = weaponcount ?? 1;
    redactedweapons = [];
    bundles = common_item::items_selectfromlist( hashcat( %"itemspawnlist:", level.biometricscan.redactedweapons ), count );
    
    foreach ( bundleref in bundles )
    {
        itembundle = getscriptbundle( bundleref );
        itemtype = common_item::function_16e8c106491eeaca( itembundle );
        
        if ( !isdefined( itembundle ) )
        {
            continue;
        }
        
        redactedweapon = { #redacteditem:itembundle, #bundleref:bundleref };
        redactedweapons[ redactedweapons.size ] = redactedweapon;
    }
    
    return redactedweapons;
}

// Namespace biometric_scan
// Params 3, eflags: 0x4
// Checksum 0xd18d1e4c, Offset: 0x5129
// Size: 0x1de
function private function_8bf318ab3782b5f3( weaponobj, itembundle, spawnoptions )
{
    if ( !( isdefined( self ) && isdefined( weaponobj ) ) )
    {
        return;
    }
    
    item = itembundle.redacteditem;
    var_30f172711509e5a6 = isdefined( item.scriptable ) && item.scriptable != %"";
    weaponscriptable = var_30f172711509e5a6 ? item.scriptable : item_weapon::function_f75620a38a24072();
    ammocount = item_weapon::function_40acef7fe7fe290( weaponobj );
    shoulddrop = istrue( level.biometricscan.dvars.var_c7e7b7d78b58c014 );
    
    if ( !shoulddrop )
    {
        var_72d58899a8793609 = { #count:ammocount, #type:weaponscriptable, #weaponobj:weaponobj };
        shoulddrop = !( var_30f172711509e5a6 ? common_item::function_96119bed8ab4c5d9( var_72d58899a8793609, 1, 1 ) : common_item::function_2b5e2ff57d5f392( var_72d58899a8793609, 1, 1 ) );
    }
    
    if ( shoulddrop )
    {
        spawnoptions = spawnoptions ? structcopy( spawnoptions, 0 ) : common_item::items_initspawnoptions_spawnfromentity( self );
        
        if ( itembundle.bundleref )
        {
            common_item::function_61c2c0251e742ffd( itembundle.bundleref, undefined, spawnoptions );
            return;
        }
        
        spawnoptions.internal = { #var_508e6a09bb574ffe:!var_30f172711509e5a6 };
        var_a2df0c82c76f136f = common_item::function_80af1e9daffacc7d( weaponscriptable );
        weapondata = item_weapon::function_fdc74b9be99fda2f( weaponobj );
        weapondata.count = ammocount;
        
        if ( !isdefined( weapondata.itembundlename ) )
        {
            weapondata.itembundlename = common_item::function_e044c3e813daec3a( var_a2df0c82c76f136f );
        }
        
        item_weapon::function_53da2af5697709f8( weaponobj, weapondata, spawnoptions );
    }
}

// Namespace biometric_scan
// Params 4, eflags: 0x4
// Checksum 0x344df113, Offset: 0x530f
// Size: 0x174
function private function_bfee9073df2bcef8( player, var_b954db1033513feb, weaponcount, spawnoptions )
{
    weaponcount = weaponcount ?? 1;
    items = function_14cd7a636e3c3d1a( weaponcount );
    
    if ( items.size > 0 )
    {
        foreach ( item in items )
        {
            itemtype = common_item::function_16e8c106491eeaca( item.redacteditem );
            
            if ( itemtype == "weapon" )
            {
                weaponobj = item_weapon::function_477bf1207c6672a5( item.redacteditem );
                player function_8bf318ab3782b5f3( weaponobj, item, spawnoptions );
                continue;
            }
            
            if ( itemtype == "ammo" )
            {
                player function_8cb1b20eaf219f24( item.redacteditem.ref, { #spawnoptions:spawnoptions } );
            }
        }
    }
    else
    {
        player function_8bf318ab3782b5f3( var_b954db1033513feb.loadoutprimaryobject, undefined, spawnoptions );
        
        if ( weaponcount >= 2 )
        {
            player function_8bf318ab3782b5f3( var_b954db1033513feb.loadoutsecondaryobject, undefined, spawnoptions );
        }
    }
    
    return items;
}

// Namespace biometric_scan
// Params 3
// Checksum 0xa1accef, Offset: 0x548c
// Size: 0x61c
function handlekeycardexchange( player, kiosk, keycardlootid )
{
    if ( !isdefined( keycardlootid ) )
    {
        return;
    }
    
    keycard = level.biometricscan.keycards[ keycardlootid ];
    var_caf3b4b0f3be501b = keycard.keycarditem;
    var_caf3b4b0f3be501b.type = "biometric_scan_keycard";
    var_caf3b4b0f3be501b.cost = 0;
    var_caf3b4b0f3be501b.var_8d51203e121463ce = 1;
    
    if ( !isdefined( var_caf3b4b0f3be501b.firesalediscount ) )
    {
        var_caf3b4b0f3be501b.firesalediscount = 0;
    }
    
    success = player br_quest_inventory::consume_quest_item( var_caf3b4b0f3be501b.ref );
    
    if ( !success )
    {
        return;
    }
    
    player points::doscoreevent( #"br_biometric_scan_keycard_exchanged", undefined, keycard.xprewarded, keycard.xprewarded );
    dropposition = kiosk.origin + ( 0, 0, 30 ) + anglestoforward( kiosk.angles ) * level.biometricscan.dvars.var_fd52f0e45929ed73;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( dropposition, kiosk.angles );
    spawnoptions.var_10a99b46418cef2 = [];
    
    foreach ( lootgroup in keycard.lootgroups )
    {
        var_837cdf85c301d9bf = randomfloat( 100 );
        
        if ( var_837cdf85c301d9bf <= lootgroup.var_d37a60a8a3bc97a8 )
        {
            validrewards = function_336cd6b0edba981e( lootgroup );
            
            if ( validrewards.size != 0 )
            {
                lootawarded = utility::random_weighted_struct( validrewards );
                
                if ( isdefined( lootawarded.item ) )
                {
                    player function_8cb1b20eaf219f24( lootawarded.item, { #spawnoptions:spawnoptions, #fromcache:1, #count:lootawarded.quantity } );
                    continue;
                }
                
                if ( isdefined( lootawarded.spawnlist ) )
                {
                    player function_e7d43c841a24b00b( lootawarded.spawnlist, lootawarded.itemcount, { #spawnoptions:spawnoptions } );
                }
            }
        }
    }
    
    if ( keycard.freebuystation.var_89077c44c5578168 )
    {
        updatefreeitemcount( player, keycard.freebuystation.var_957954ceee2acaed );
    }
    
    var_b954db1033513feb = player class::savefavoriteloadout();
    
    if ( keycard.favoriteloadout.giveprimary )
    {
        player function_8bf318ab3782b5f3( var_b954db1033513feb.loadoutprimaryobject, undefined, spawnoptions );
    }
    
    if ( keycard.favoriteloadout.givesecondary )
    {
        player function_8bf318ab3782b5f3( var_b954db1033513feb.loadoutsecondaryobject, undefined, spawnoptions );
    }
    
    if ( keycard.favoriteloadout.givetactical )
    {
        tacticalname = common_item::function_70d4affb770e8103( var_b954db1033513feb.loadoutequipmentsecondary );
        player function_8cb1b20eaf219f24( tacticalname, { #spawnoptions:spawnoptions, #count:2 } );
    }
    
    if ( keycard.favoriteloadout.givelethal )
    {
        lethalname = common_item::function_70d4affb770e8103( var_b954db1033513feb.loadoutequipmentprimary );
        player function_8cb1b20eaf219f24( lethalname, { #spawnoptions:spawnoptions, #count:2 } );
    }
    
    var_406513aa7ad2e040 = keycard.favoriteloadout.var_19fb3587e05528f3 ? 1 : 0;
    var_406513aa7ad2e040 += keycard.favoriteloadout.var_fdd80da842007b17 ? 1 : 0;
    
    if ( var_406513aa7ad2e040 > 0 )
    {
        function_bfee9073df2bcef8( player, var_b954db1033513feb, var_406513aa7ad2e040, spawnoptions );
    }
    
    if ( keycard.favoriteloadout.giveperk )
    {
        perkset = var_b954db1033513feb.loadoutperks;
        
        if ( perkset.size > 0 )
        {
            item = { #perks:arraycopy( perkset ), #fromcache:1, #count:1 };
            spawnoptions.payload = [ #"customperkpackage" ];
            
            foreach ( perk in perkset )
            {
                perkid = level.var_d97c85f03eff6eca[ perk ];
                
                if ( isdefined( perkid ) )
                {
                    spawnoptions.payload[ spawnoptions.payload.size ] = perkid + 1;
                }
            }
            
            while ( spawnoptions.payload.size < 5 )
            {
                spawnoptions.payload[ spawnoptions.payload.size ] = 0;
            }
            
            player function_8cb1b20eaf219f24( "brloot_perk_custom_pack", { #spawnoptions:spawnoptions, #baseitem:item } );
            spawnoptions.payload = undefined;
        }
    }
    
    player notify( #"hash_8798cd5799e2ad0b" );
    reportkeycardcount( player );
    function_795867e208c24041( player, keycard.assetname );
    challenges::function_37e945722d6497f3( player, "trade_biometric_card", 1 );
    return var_caf3b4b0f3be501b;
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0x38d15e80, Offset: 0x5ab1
// Size: 0xb3
function private function_795867e208c24041( player, var_b22c0b663bce9d61 )
{
    var_2a1146b60455d8b4 = function_e2070732b6a3ee40( var_b22c0b663bce9d61 );
    
    if ( !isdefined( var_2a1146b60455d8b4 ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_biometric_scan_keycard_exchanged", [ "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "map_name", level.mapname, "name_keycard_exchanged", var_2a1146b60455d8b4 ] );
}

// Namespace biometric_scan
// Params 2, eflags: 0x4
// Checksum 0x391d30d2, Offset: 0x5b6c
// Size: 0x136
function private function_f5869a3a6d775ac2( player, var_5213451bdfdb9388 )
{
    dailyusecount = player function_56996edb1f62a004();
    var_2a1146b60455d8b4 = function_e2070732b6a3ee40( var_5213451bdfdb9388 );
    
    if ( !isdefined( var_2a1146b60455d8b4 ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_biometric_scan_used", [ "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "map_name", level.mapname, "daily_use_count", dailyusecount, "name_keycard_gained", var_2a1146b60455d8b4, "instance_x", self.origin[ 0 ] ?? 0, "instance_y", self.origin[ 1 ] ?? 0, "instance_z", self.origin[ 2 ] ?? 0 ] );
}

// Namespace biometric_scan
// Params 1
// Checksum 0xa9494683, Offset: 0x5caa
// Size: 0xa6
function reportkeycardcount( player )
{
    keycardcount = 0;
    inventorysize = br_quest_inventory::function_93d24fdd85a5eb60();
    
    for ( slot = 0; slot < inventorysize ; slot++ )
    {
        lootid = player br_quest_inventory::get_quest_item_id( slot );
        keycard = level.biometricscan.keycards[ lootid ];
        
        if ( isdefined( keycard ) )
        {
            keycardcount += player br_quest_inventory::get_quest_item_amount( keycard.keycarditem.ref );
        }
    }
    
    player function_7bc8f1f19f1a95d9( keycardcount );
}

// Namespace biometric_scan
// Params 2
// Checksum 0x13e58ad7, Offset: 0x5d58
// Size: 0x65
function updatefreeitemcount( player, value )
{
    if ( !isdefined( player.var_403f571c4b488e5f ) )
    {
        player.var_403f571c4b488e5f = 0;
    }
    
    player.var_403f571c4b488e5f = clampint( player.var_403f571c4b488e5f + value, 0, 31 );
    player function_8789a72d6b38bc30( player.var_403f571c4b488e5f );
}

// Namespace biometric_scan
// Params 0
// Checksum 0xfcf96eb6, Offset: 0x5dc5
// Size: 0x59
function function_957397bd820f454b()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "billboard_init_done" );
    isenabled = getdvarint( @"scr_enable_biometric_scan_billboard", 1 );
    
    if ( isenabled && isdefined( level.billboards ) )
    {
        namespace_8cdbb6d4564d9fae::function_d89f723a1b6fa8de( "biometricCardHolder", &function_b2e292d176ae41c2 );
    }
}

// Namespace biometric_scan
// Params 2
// Checksum 0x54290bfe, Offset: 0x5e26
// Size: 0x7d
function function_9974d2b12c6aa6ab( player, scriptablekeycard )
{
    keycardlootid = common_item::function_cb980b90c836804e( scriptablekeycard );
    
    if ( level.biometricscan.keycards[ keycardlootid ].billboard )
    {
        level.biometricscan.billboardplayer = player getentitynumber();
        
        if ( namespace_8cdbb6d4564d9fae::function_8f8e633d55c4fe83() )
        {
            function_957397bd820f454b();
            namespace_8cdbb6d4564d9fae::function_821562e9aee4355f();
        }
    }
}

// Namespace biometric_scan
// Params 2, eflags: 0x40 variadic
// Checksum 0x3b60bc7e, Offset: 0x5eab
// Size: 0xb8
function function_b2e292d176ae41c2( ... )
{
    if ( !isdefined( level.biometricscan.billboardplayer ) )
    {
        return;
    }
    
    displayduration = getdvarint( @"hash_7ef16c590bb314e6", 10 );
    
    if ( namespace_8cdbb6d4564d9fae::function_8f8e633d55c4fe83() )
    {
        displayduration = level.billboards.var_63c167b9421bbb9d;
    }
    
    result = { #optionalparam:level.biometricscan.billboardplayer, #displayduration:displayduration };
    
    if ( !namespace_8cdbb6d4564d9fae::function_8f8e633d55c4fe83() )
    {
        level.biometricscan.billboardplayer = undefined;
    }
    
    return result;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x385497ee, Offset: 0x5f6c
// Size: 0x32
function private function_fa6e92276acedde8( newscore )
{
    level.biometricscan.var_e251c0e2d2fde595[ self getentitynumber() ].dailycount = newscore;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x3c2abc49, Offset: 0x5fa6
// Size: 0x32
function private function_98cc13e39884a3ef( time )
{
    level.biometricscan.var_e251c0e2d2fde595[ self getentitynumber() ].timestamp = time;
}

// Namespace biometric_scan
// Params 0
// Checksum 0xffbcd8ba, Offset: 0x5fe0
// Size: 0x50
function function_56996edb1f62a004()
{
    /#
        usecountoverride = getdvarint( @"hash_ff8fcdf73578c58c", 0 );
        
        if ( usecountoverride > 0 )
        {
            return usecountoverride;
        }
    #/
    
    return level.biometricscan.var_e251c0e2d2fde595[ self getentitynumber() ].dailycount ?? 0;
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0xbd450c4b, Offset: 0x6039
// Size: 0x29, Type: bool
function private function_506c23ad3e5fa8b()
{
    return level.biometricscan.var_e251c0e2d2fde595[ self getentitynumber() ].timestamp ?? 0;
}

// Namespace biometric_scan
// Params 0
// Checksum 0xaf36d80e, Offset: 0x606b
// Size: 0x45
function function_e7fa5bad14772d42()
{
    /#
        var_d4d1b3c87679fbd4 = getdvarint( @"hash_e68389c160601c56", 0 );
        
        if ( var_d4d1b3c87679fbd4 > 0 )
        {
            return var_d4d1b3c87679fbd4;
        }
    #/
    
    return self getplayerdata( level.var_6f9b00680ed002d8, "biometricScanBonusCount", "score" ) ?? 0;
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0xfe0ff164, Offset: 0x60b9
// Size: 0x1e, Type: bool
function private function_c21a8ac4e6c01fee()
{
    return self getplayerdata( level.var_6f9b00680ed002d8, "biometricScanBonusCount", "time" ) ?? 0;
}

// Namespace biometric_scan
// Params 0, eflags: 0x4
// Checksum 0xf03403e8, Offset: 0x60e0
// Size: 0x15
function private function_5fe1ee61f16472ee()
{
    ftue_tip::function_d454ba9425f5164c( 25, "matchBiometricScanner", &function_6e0bdfb1cd1a8b1d );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x46d1855c, Offset: 0x60fd
// Size: 0x15
function private function_6e0bdfb1cd1a8b1d( params )
{
    return self.var_96a6b65de786d142;
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x71a3ce7d, Offset: 0x611b
// Size: 0x1d
function private function_e11e64a823cf9b2f( screenenabled )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 0, 1, screenenabled );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x95dc6db1, Offset: 0x6140
// Size: 0x1e
function private function_8789a72d6b38bc30( var_3b63d9b80537ff63 )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 1, 5, var_3b63d9b80537ff63 );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x23008af3, Offset: 0x6166
// Size: 0x1e
function private function_7bc8f1f19f1a95d9( cardscount )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 6, 3, cardscount );
}

// Namespace biometric_scan
// Params 1, eflags: 0x4
// Checksum 0x118c88fd, Offset: 0x618c
// Size: 0x1e
function private function_12b7b963f8039562( var_e37b99fc0828a796 )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 9, 3, var_e37b99fc0828a796 );
}

// Namespace biometric_scan
// Params 1
// Checksum 0x2e8f81e9, Offset: 0x61b2
// Size: 0x1e
function function_3e1350bc72c5c7da( var_8f1b88b8c8784aba )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 12, 1, var_8f1b88b8c8784aba );
}

// Namespace biometric_scan
// Params 1
// Checksum 0x1ced1389, Offset: 0x61d8
// Size: 0x38
function function_5f4e453fd20bd4d6( typeid )
{
    if ( self.var_4beb621924400585 != typeid )
    {
        omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 13, 1, typeid );
        self.var_4beb621924400585 = typeid;
    }
}

// Namespace biometric_scan
// Params 1
// Checksum 0x986614dc, Offset: 0x6218
// Size: 0x1e
function function_8e479f27c3b1c56a( dayscount )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 14, 10, dayscount );
}

// Namespace biometric_scan
// Params 1
// Checksum 0xf57efae4, Offset: 0x623e
// Size: 0x38
function function_603430744cd90359( var_4d58ec36e1345c39 )
{
    if ( self.var_1b5caea60ff589bb != var_4d58ec36e1345c39 )
    {
        omnvar_utility::function_85d5f88af471ac4b( "ui_biometric_scan_data", 24, 1, var_4d58ec36e1345c39 );
        self.var_1b5caea60ff589bb = var_4d58ec36e1345c39;
    }
}

/#

    // Namespace biometric_scan
    // Params 0
    // Checksum 0xe8e7292a, Offset: 0x627e
    // Size: 0x16, Type: dev
    function function_563635a45c3ee38e()
    {
        return getdvarint( @"hash_d33e589731a8e1ea", 0 ) != 0;
    }

    // Namespace biometric_scan
    // Params 0
    // Checksum 0x22fca082, Offset: 0x629c
    // Size: 0xc, Type: dev
    function debug_init()
    {
        devgui_init();
    }

    // Namespace biometric_scan
    // Params 0
    // Checksum 0x78e59fe0, Offset: 0x62b0
    // Size: 0x12a, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x11b>" );
        
        foreach ( keycard in level.biometricscan.keycards )
        {
            var_720b85279a6e9fe2 = strtoksubstr( keycard.assetname, "<dev string:x12e>" );
            prefix = var_720b85279a6e9fe2[ var_720b85279a6e9fe2.size - 1 ] + "<dev string:x130>";
            devgui::function_cd4e263c1f3018ae( prefix + "<dev string:x13a>", "<dev string:x13f>" + keycard.assetname, &function_e8429dae87fcc94d );
            devgui::function_cd4e263c1f3018ae( prefix + "<dev string:x159>", "<dev string:x15e>" + keycard.assetname, &function_41c104ee985a52fd );
        }
        
        devgui::add_devgui_func( "<dev string:x178>", "<dev string:x196>", &function_3e937274df8cb2e1, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace biometric_scan
    // Params 1
    // Checksum 0x50561315, Offset: 0x63e2
    // Size: 0x3e, Type: dev
    function function_e8429dae87fcc94d( params )
    {
        player = level.players[ 0 ];
        player.var_def39213b61e25e4 = params[ 0 ];
        function_ea84291a682e3f50( player );
    }

    // Namespace biometric_scan
    // Params 1
    // Checksum 0xfea43a90, Offset: 0x6428
    // Size: 0x40, Type: dev
    function function_41c104ee985a52fd( params )
    {
        player = level.players[ 0 ];
        player.var_def39213b61e25e4 = params[ 0 ];
        function_ea84291a682e3f50( player, 1 );
    }

    // Namespace biometric_scan
    // Params 0
    // Checksum 0x9f05ffc, Offset: 0x6470
    // Size: 0x14, Type: dev
    function function_e513625ef06a8803()
    {
        return getdvarint( @"hash_d3e8299a9a8f2980", 0 );
    }

    // Namespace biometric_scan
    // Params 0, eflags: 0xc
    // Checksum 0x90ee632f, Offset: 0x648c
    // Size: 0xfa, Type: dev
    function private function_3e937274df8cb2e1()
    {
        self notify( #"hash_e631ade9c2ee32de" );
        self endon( #"hash_e631ade9c2ee32de" );
        level endon( #"game_ended" );
        flags::function_2f3408423ccc9b2e( "<dev string:x1b4>" );
        var_d0feb145578f55b8 = int( ceil( 1000 / level.frameduration ) );
        
        while ( true )
        {
            wait 1;
            
            foreach ( biometricscan in level.var_904f7a4736d5940e )
            {
                if ( !biometricscan )
                {
                    continue;
                }
                
                sphere( biometricscan.origin, 50, ( 0, 1, 1 ), 0, var_d0feb145578f55b8 );
            }
        }
    }

#/
