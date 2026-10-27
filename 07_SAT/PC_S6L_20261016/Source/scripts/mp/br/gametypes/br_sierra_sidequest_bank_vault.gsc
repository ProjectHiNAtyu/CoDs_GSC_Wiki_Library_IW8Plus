// scripts\mp\br\gametypes\br_sierra_sidequest_bank_vault.gsc  (hash_3ab73c7bc51977e4.gscc) (size: 9957 Bytes / 0x26e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f213cb3 (2401320115)
// size ...... 9957 (0x26e5)
// includes .. 11  (offset: 0x23ed)
// strings ... 43  (offset: 0x2445)
// dev strs .. 0   (offset: 0x26e5)
// exports ... 34  (offset: 0x14fd)
// cseg ...... 0x42d + 0x10d0 (0x14fd)
// imports ... 82  (offset: 0x1a4d)
// animtree1 . 0   (offset: 0x26e5)
// animtree2 . 0   (offset: 0x26e5)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;

#namespace br_sierra_sidequest_bank_vault;

// Namespace br_sierra_sidequest_bank_vault
// Params 0, eflags: 0x1
// Checksum 0x725eae4b, Offset: 0x44b
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x68d46a6d, Offset: 0x45c
// Size: 0x79
function init()
{
    if ( !getdvarint( @"hash_82add6ae60484787", 1 ) )
    {
        return;
    }
    
    quest = { #on_prematch_end:&on_prematch_end, #on_init:&on_init, #name:"bank_vault" };
    br_map_quest::register( quest );
    level.var_b30d859af2609680 = &function_a4c6e70e6a1653c6;
    callback::add( #"player_death", &onplayerdeath );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0xde5b5211, Offset: 0x4dd
// Size: 0x17
function on_init()
{
    setupsettings();
    thread setupscanner();
    function_8714af9aabae4b23();
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x3a6bbf34, Offset: 0x4fc
// Size: 0x2d
function on_prematch_end()
{
    function_a1008d21d5ee6d10();
    function_5ba4848833c9a97a();
    function_eb280717f3202608();
    
    /#
        function_b4ffcc9795c4d621( level.players[ 0 ], self );
    #/
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x769f8e3d, Offset: 0x531
// Size: 0x2d
function setupsettings()
{
    br_map_quest::add_setting( "reward_radius", 1000 );
    br_map_quest::add_setting( "team_reward_enabled", 1 );
    br_map_quest::add_setting( "staged_reward_enabled", 1 );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0xa3cd98c2, Offset: 0x566
// Size: 0x69
function setupscanner()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_e1444d61c810be01 = utility::getstructarray( "biometric_scan_bank_vault", "targetname" );
    var_e1444d61c810be01 = arrayrandomize( var_e1444d61c810be01 );
    self.var_740794cab9186fcc = var_e1444d61c810be01[ 0 ];
    
    if ( !self.var_740794cab9186fcc )
    {
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "biometric_scanner_bank_vault", &scannerused );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0xc6f521f8, Offset: 0x5d7
// Size: 0xd7
function function_8714af9aabae4b23()
{
    self.bankdoor = getent( "bank_vault_door", "targetname" );
    self.bankdoor setmoverantilagged( 1 );
    var_50f0249bdb80c456 = getent( self.bankdoor.target, #targetname );
    var_50f0249bdb80c456 setmoverantilagged( 1 );
    var_50f0249bdb80c456 enablelinkto();
    var_50f0249bdb80c456 linkto( self.bankdoor );
    self.banktrigger = getent( "bank_vault_hurt", "script_noteworthy" );
    self.var_8c98f15165ba7088 = utility::getstruct( "bank_vault_door_drill", "targetname" );
    
    if ( br_map_quest::get_setting( "staged_reward_enabled" ) == 1 )
    {
        level thread br_bunker_utility::function_570a0e83663d22a4( "bunker_staged_reward_bank_vault" );
    }
    
    self.var_d8183666649cf462 = [];
    self.var_c56fc00921fb2bf5 = [];
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x583c1fa5, Offset: 0x6b6
// Size: 0x7b
function function_a1008d21d5ee6d10()
{
    scannerscriptable = spawnscriptable( "wz_biometric_scanner_bank_vault", self.var_740794cab9186fcc.origin, self.var_740794cab9186fcc.angles );
    scannerscriptable setscriptablepartstate( "biometric_scanner_screen", "screen_closed" );
    scannerscriptable interaction::set_interact_hint_callback( &function_3cf4ef437089c9b3 );
    scannerscriptable thread function_829704847004f78f();
    self.var_740794cab9186fcc.var_9a6f37e38a82410a = scannerscriptable;
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x56c29a89, Offset: 0x739
// Size: 0xe0
function function_5ba4848833c9a97a()
{
    self.var_8c98f15165ba7088.scriptable = spawnscriptable( "wz_bank_vault_drill", self.var_8c98f15165ba7088.origin, self.var_8c98f15165ba7088.angles );
    
    foreach ( player in level.players )
    {
        self.var_8c98f15165ba7088.scriptable disablescriptableplayeruse( player );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "bank_vault_drill_model", &function_f51adfe00846e20a );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x78a1ceba, Offset: 0x821
// Size: 0x54
function function_eb280717f3202608()
{
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_bank_vault_drill", { #dropped:&function_fed36cfb38ff266, #used:&function_f481449f5771af5d } );
    br_quest_inventory::register_quest_item_funcs( "wz_consumable_quest_bank_vault_card", { #dropped:&function_e256b275cfcd5c29, #used:&function_7bd35032e7733090 } );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0x8789f188, Offset: 0x87d
// Size: 0xb1
function function_f481449f5771af5d( params )
{
    quest = level.br_map_quest.quests[ "bank_vault" ];
    quest.var_8c98f15165ba7088.scriptable enablescriptableplayeruse( self );
    
    if ( !arraycontains( quest.var_c56fc00921fb2bf5, self.team ) )
    {
        quest.var_c56fc00921fb2bf5[ quest.var_c56fc00921fb2bf5.size ] = self.team;
        dlog_recordevent( "dlog_event_br_sierra_sidequest_22", [ "progression_step", 3 ] );
    }
    
    /#
        function_e6e470c19aacfd13( self, quest );
    #/
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0xe9b6ae81, Offset: 0x936
// Size: 0x4c
function function_fed36cfb38ff266( params )
{
    quest = level.br_map_quest.quests[ "bank_vault" ];
    quest.var_8c98f15165ba7088.scriptable disablescriptableplayeruse( self );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0x3c5ce428, Offset: 0x98a
// Size: 0xbc
function function_7bd35032e7733090( params )
{
    quest = level.br_map_quest.quests[ "bank_vault" ];
    lootid = common_item::function_779887309ec71dfe( params.bundle );
    self setclientomnvar( "ui_biometric_scan_consumable_loot_id", lootid );
    
    if ( !arraycontains( quest.var_d8183666649cf462, self.team ) )
    {
        quest.var_d8183666649cf462[ quest.var_d8183666649cf462.size ] = self.team;
        dlog_recordevent( "dlog_event_br_sierra_sidequest_22", [ "progression_step", 2 ] );
    }
    
    /#
        function_fd7529270749fae4( self );
    #/
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0x97e6affa, Offset: 0xa4e
// Size: 0x3d
function function_e256b275cfcd5c29( params )
{
    quest = level.br_map_quest.quests[ "bank_vault" ];
    self setclientomnvar( "ui_biometric_scan_consumable_loot_id", 0 );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 3, eflags: 0x4
// Checksum 0x93699746, Offset: 0xa93
// Size: 0x7b
function private function_a4c6e70e6a1653c6( player, kiosk, lootid )
{
    player br_quest_inventory::consume_quest_item( "wz_consumable_quest_bank_vault_card" );
    spawnoptions = common_item::function_b94327aa4c1b718b( kiosk.origin + ( 0, 0, 40 ) + anglestoforward( kiosk.angles ) * 30, kiosk );
    common_item::items_spawnitemfromscriptable( "brloot_quest_bank_vault_drill", undefined, spawnoptions );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 6
// Checksum 0xd0a1ee1d, Offset: 0xb16
// Size: 0xf6
function scannerused( instance, part, state, player, bautouse, usestring )
{
    quest = level.br_map_quest.quests[ "bank_vault" ];
    instance setscriptablepartstate( "biometric_scanner_bank_vault", "in_use" );
    player points::doscoreevent( #"br_biometric_scanner_used" );
    quest function_919fdae16c227cd7( "ui_bv_scan_card_available", 0 );
    quest.var_3e674573d3684b07 = 1;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( instance.origin, instance.angles );
    keycardscriptable = common_item::items_spawnitemfromscriptable( "brloot_quest_bank_vault_card", undefined, spawnoptions );
    dlog_recordevent( "dlog_event_br_sierra_sidequest_22", [ "progression_step", 1 ] );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 6
// Checksum 0x1fa100c4, Offset: 0xc14
// Size: 0x76
function function_f51adfe00846e20a( instance, part, state, player, bautouse, usestring )
{
    quest = level.br_map_quest.quests[ "bank_vault" ];
    quest thread drillinginprogress( player );
    player br_quest_inventory::consume_quest_item( "wz_consumable_quest_bank_vault_drill" );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0xf5072043, Offset: 0xc92
// Size: 0x68
function drillinginprogress( player )
{
    level endon( #"game_ended" );
    self.var_8c98f15165ba7088.scriptable setscriptablepartstate( "bank_vault_drill_model", "drill_using" );
    self.var_8c98f15165ba7088.scriptable setscriptablepartstate( "bank_vault_drill_effects", "drill_using" );
    wait 10;
    questcompleted( player );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0xe1e4b680, Offset: 0xd02
// Size: 0x36
function opendoor()
{
    self.banktrigger delete();
    self.bankdoor rotateby( ( 0, 130, 0 ), 6.25, 0, 5.5 );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0x620f17e9, Offset: 0xd40
// Size: 0x11b
function givereward( player )
{
    rewardradius = br_map_quest::get_setting( "reward_radius" );
    playersinradius = [ player ];
    
    if ( br_map_quest::get_setting( "team_reward_enabled" ) )
    {
        playersinradius = getplayersinradius( self.bankdoor.origin, rewardradius, undefined, undefined, undefined, player.team );
    }
    
    foreach ( teamplayer in playersinradius )
    {
        if ( player::isreallyalive( teamplayer ) )
        {
            teamplayer points::doscoreevent( #"hash_519d41107863f752" );
        }
    }
    
    dlog_recordevent( "dlog_event_br_sierra_sidequest_22", [ "progression_step", 4 ] );
    challenges::function_37e945722d6497f3( player, "sierra_sidequest_22", 1, 1 );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0xbbda4ca8, Offset: 0xe63
// Size: 0x60
function questcompleted( player )
{
    self.var_8c98f15165ba7088.scriptable setscriptablepartstate( "bank_vault_drill_model", "drill_complete" );
    self.var_8c98f15165ba7088.scriptable setscriptablepartstate( "bank_vault_drill_effects", "drill_complete" );
    opendoor();
    givereward( player );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 2, eflags: 0x4
// Checksum 0x17e85474, Offset: 0xecb
// Size: 0x5e
function private function_3cf4ef437089c9b3( usable, player )
{
    if ( isdefined( player ) )
    {
        return { #string:&"mp/br_biometric_scan_activate_hint", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x241710f1, Offset: 0xf32
// Size: 0x5e
function function_829704847004f78f()
{
    level endon( #"game_ended" );
    quest = level.br_map_quest.quests[ "bank_vault" ];
    var_1f94c6e0df0da332 = cos( 90 );
    
    while ( true )
    {
        function_542b4282bcde82de( var_1f94c6e0df0da332, quest );
        wait 0.25;
    }
}

// Namespace br_sierra_sidequest_bank_vault
// Params 2
// Checksum 0xd438a74a, Offset: 0xf98
// Size: 0x113
function function_542b4282bcde82de( var_1f94c6e0df0da332, quest )
{
    quest.var_c097378f12f874a7 = 0;
    var_8353a1575cfc213a = getplayersinradius( self.origin, 300 );
    quest.nearbyplayers = getplayersinradius( self.origin, 900 );
    
    foreach ( player in var_8353a1575cfc213a )
    {
        if ( utility::within_fov( self.origin, self.angles, player.origin, var_1f94c6e0df0da332 ) && function_6e1c2a09354e7c11( player ) )
        {
            quest.var_c097378f12f874a7 = 1;
            break;
        }
    }
    
    function_f41b9b1db32c3b05( quest );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0x29aa0241, Offset: 0x10b3
// Size: 0x119
function function_6e1c2a09354e7c11( player )
{
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    scannereyepos = self.origin + ( 0, 0, 100 );
    var_765973574aeb2d9b = [ "j_head", "j_spine4", "j_shoulder_le", "j_shoulder_ri", "j_knee_le", "j_knee_ri" ];
    sighttracepassed = 0;
    
    foreach ( playertag in var_765973574aeb2d9b )
    {
        var_f24faa2a30005d2f = player gettagorigin( playertag );
        
        if ( sighttracepassed( scannereyepos, var_f24faa2a30005d2f, 1, player, undefined, 1 ) )
        {
            sighttracepassed = 1;
            break;
        }
    }
    
    return sighttracepassed;
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0xa0735466, Offset: 0x11d5
// Size: 0x7a
function function_f41b9b1db32c3b05( quest )
{
    if ( quest.var_c097378f12f874a7 )
    {
        function_2d3b1b73008fe2ad();
        quest function_919fdae16c227cd7( "ui_bv_screen_enabled", 1 );
        
        if ( quest.var_3e674573d3684b07 )
        {
            quest function_919fdae16c227cd7( "ui_bv_scan_card_available", 0 );
        }
        else
        {
            quest function_919fdae16c227cd7( "ui_bv_scan_card_available", 1 );
        }
        
        return;
    }
    
    function_9b797e2d7b688aac();
    quest function_919fdae16c227cd7( "ui_bv_screen_enabled", 0 );
}

// Namespace br_sierra_sidequest_bank_vault
// Params 1
// Checksum 0xc4f7234f, Offset: 0x1257
// Size: 0x28
function onplayerdeath( params )
{
    if ( self getclientomnvar( "ui_bv_screen_enabled" ) == 1 )
    {
        self setclientomnvar( "ui_bv_screen_enabled", 0 );
    }
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x5c1ba850, Offset: 0x1287
// Size: 0x33
function function_2d3b1b73008fe2ad()
{
    currentstate = self getscriptablepartstate( "biometric_scanner_screen" );
    
    if ( currentstate == "screen_closed" )
    {
        self setscriptablepartstate( "biometric_scanner_screen", "screen_opened" );
    }
}

// Namespace br_sierra_sidequest_bank_vault
// Params 0
// Checksum 0x7153a48a, Offset: 0x12c2
// Size: 0x4b
function function_9b797e2d7b688aac()
{
    currentstate = self getscriptablepartstate( "biometric_scanner_screen" );
    
    if ( currentstate == "screen_opened" || currentstate == "camera_scanning" || currentstate == "screen_opened_idle" )
    {
        self setscriptablepartstate( "biometric_scanner_screen", "screen_closed" );
    }
}

// Namespace br_sierra_sidequest_bank_vault
// Params 2
// Checksum 0x6a1bf438, Offset: 0x1315
// Size: 0x8e
function function_919fdae16c227cd7( omnvarname, omnvarstate )
{
    foreach ( player in self.nearbyplayers )
    {
        player setclientomnvar( omnvarname, omnvarstate );
    }
}

/#

    // Namespace br_sierra_sidequest_bank_vault
    // Params 1, eflags: 0x4
    // Checksum 0xa6e8766d, Offset: 0x13ab
    // Size: 0x7e, Type: dev
    function private function_fd7529270749fae4( player )
    {
        if ( getdvarint( @"hash_57c3fd23db79f66f", 0 ) && isdefined( level.common_armory_kiosk.instances ) )
        {
            buystation = function_47c86977a18df38b( level.common_armory_kiosk.instances, self.origin, 10000 );
            
            if ( isdefined( buystation ) )
            {
                self setorigin( buystation.origin );
            }
        }
    }

    // Namespace br_sierra_sidequest_bank_vault
    // Params 2, eflags: 0x4
    // Checksum 0x306e6119, Offset: 0x1431
    // Size: 0x62, Type: dev
    function private function_e6e470c19aacfd13( player, quest )
    {
        if ( getdvarint( @"hash_57c3fd23db79f66f", 0 ) )
        {
            player setorigin( quest.var_8c98f15165ba7088.origin + anglestoforward( quest.var_8c98f15165ba7088.origin ) * 10 );
        }
    }

    // Namespace br_sierra_sidequest_bank_vault
    // Params 2, eflags: 0x4
    // Checksum 0x1766df06, Offset: 0x149b
    // Size: 0x62, Type: dev
    function private function_b4ffcc9795c4d621( player, quest )
    {
        if ( getdvarint( @"hash_57c3fd23db79f66f", 0 ) )
        {
            player setorigin( quest.var_740794cab9186fcc.origin + anglestoforward( quest.var_740794cab9186fcc.angles ) * 10 );
        }
    }

#/
