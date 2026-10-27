// scripts\mp\br\gametypes\br_stadium_puzzle.gsc  (hash_029026d2f0cc5744.gscc) (size: 16308 Bytes / 0x3fb4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b37c7cb (725075915)
// size ...... 16308 (0x3fb4)
// includes .. 17  (offset: 0x3a3c)
// strings ... 68  (offset: 0x3ac4)
// dev strs .. 12  (offset: 0x3f18)
// exports ... 38  (offset: 0x284c)
// cseg ...... 0x5ae + 0x229e (0x284c)
// imports ... 97  (offset: 0x2e3c)
// animtree1 . 0   (offset: 0x3fb4)
// animtree2 . 0   (offset: 0x3fb4)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerlogic;

#namespace br_stadium_puzzle;

// Namespace br_stadium_puzzle
// Params 0, eflags: 0x5
// Checksum 0x4da16f33, Offset: 0x5cc
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xc2106244, Offset: 0x5dd
// Size: 0x61
function init()
{
    if ( getdvarint( @"hash_9a7cd11d2d7a7b37", 1 ) == 0 )
    {
        level thread function_62e0f49e864677e9();
        return;
    }
    
    quest = { #on_prematch_end:&on_prematch_end, #on_init:&on_init, #name:"stadium_puzzle" };
    br_map_quest::register( quest );
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xd307c084, Offset: 0x646
// Size: 0x7c
function on_init()
{
    level.stadium_puzzle = spawnstruct();
    level.stadium_puzzle.hints = [];
    level.stadium_puzzle.code = [];
    scriptable::scriptable_addusedcallbackbypart( "maphint_stadium_code_computer", &codecomputerscriptableused );
    scriptable::scriptable_addusedcallbackbypart( "maphint_stadium_access_reader", &accessreaderscriptableused );
    scriptable::scriptable_addusedcallbackbypart( "maphint_stadium_keypad", &keypadscriptableused );
    level thread initpostmain();
    level thread function_c16f77c317d19a76();
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xb666eaeb, Offset: 0x6ca
// Size: 0x194
function on_prematch_end()
{
    foreach ( keypad in level.stadium_puzzle.hints[ "stadium_boardroom_keypad" ] )
    {
        keypad.scriptable setscriptablepartstate( "maphint_stadium_keypad", "on" );
    }
    
    codelength = getdvarint( @"hash_2b534a885f537dfa", 8 );
    setupboardroomcode( codelength, level.stadium_puzzle );
    level function_23e9ae6242aef4e1( self.var_dcf6ac8bf4b7c072 );
    level thread function_d384fa0da8df4b20( "qwe_sidequest_bar", level.stadium_puzzle.dlogs.var_f1781a432d60715c, "stadium_concourse_access_reader" );
    level thread function_d384fa0da8df4b20( "qwe_sidequest_storage", level.stadium_puzzle.dlogs.var_125886877b981398, "stadium_upper_level_access_card" );
    level thread function_d384fa0da8df4b20( "qwe_sidequest_parking", level.stadium_puzzle.dlogs.var_9e08290132e9b605, "stadium_parking_garage_access_reader" );
    level thread function_d384fa0da8df4b20( "qwe_sidequest_executive", level.stadium_puzzle.dlogs.var_a167504d3bf83f9f, "stadium_boardroom_keypad" );
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xb7b03c8b, Offset: 0x866
// Size: 0x3a
function function_62e0f49e864677e9()
{
    level waittill( #"scriptables_ready" );
    function_b02930ddb6868d33( "stadium_upper_level_access_card" );
    function_b02930ddb6868d33( "stadium_concourse_access_reader" );
    function_b02930ddb6868d33( "stadium_parking_garage_access_reader" );
    function_2ec0797ec2b1df09();
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xa4ca1afc, Offset: 0x8a8
// Size: 0x58
function initpostmain()
{
    level waittill( #"scriptables_ready" );
    gatherstadiumlocs();
    quest = level.br_map_quest.quests[ "stadium_puzzle" ];
    quest.var_dcf6ac8bf4b7c072 = function_e19278fe421c22f9();
    
    /#
        level thread function_3f20b8b021dae877();
    #/
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0x7a9d48be, Offset: 0x908
// Size: 0x151
function function_2ec0797ec2b1df09()
{
    locs = utility::getstructarray( "stadium_boardroom_keypad", "targetname" );
    
    foreach ( loc in locs )
    {
        doors = getentitylessscriptablearray( loc.target, #targetname );
        
        foreach ( door in doors )
        {
            door scriptabledoorfreeze( 1 );
        }
        
        keypad = spawnscriptable( "maphint_stadium_keypad", loc.origin, loc.angles );
        keypad setscriptablepartstate( "maphint_stadium_keypad", "inactive" );
    }
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x725f3ac9, Offset: 0xa61
// Size: 0xb7
function function_b02930ddb6868d33( var_ad39d17f9c5e9e44 )
{
    loc = utility::getstruct( var_ad39d17f9c5e9e44, "targetname" );
    doors = getentitylessscriptablearray( loc.target, #targetname );
    
    foreach ( door in doors )
    {
        door scriptabledoorfreeze( 1 );
    }
}

// Namespace br_stadium_puzzle
// Params 2
// Checksum 0x229f716c, Offset: 0xb20
// Size: 0x1e1
function setupboardroomcode( codelength, codestruct )
{
    br_bunker_utility::generatenumbercode( codelength, codestruct, 1, 1 );
    codestruct.displaycodes = br_bunker_utility::generatecodestoshow( codestruct.code, 3, 1, 1 );
    br_bunker_utility::assigncodecomputersdisplaycodes( codestruct.hints[ "maphint_stadium_code_computer" ], codestruct.displaycodes );
    
    /#
        foreach ( keypad in level.stadium_puzzle.hints[ "<dev string:x24>" ] )
        {
            codestruct.code[ "<dev string:x3d>" ] = getdvarint( @"hash_82eec2aed4b76c08", 0 ) == 1 ? "<dev string:x44>" : codestruct.code[ "<dev string:x3d>" ];
        }
    #/
    
    foreach ( keypad in level.stadium_puzzle.hints[ "stadium_boardroom_keypad" ] )
    {
        keypad.scriptable.code = codestruct.code;
        keypad.scriptable.successfunction = &boardroomdoorcodeentrysuccess;
    }
    
    if ( false )
    {
    }
}

// Namespace br_stadium_puzzle
// Params 6
// Checksum 0x36f70864, Offset: 0xd09
// Size: 0x58
function codecomputerscriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x4d>" );
    level thread _codecomputerscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_stadium_puzzle
// Params 5
// Checksum 0x81dd9a9b, Offset: 0xd69
// Size: 0x240
function _codecomputerscriptableused( instance, part, state, player, bautouse )
{
    if ( state != "on" )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        playsoundatpos( instance.origin, "br_computer_deny" );
        instance setscriptablepartstate( "maphint_stadium_code_computer", "off" );
        wait 3;
        instance setscriptablepartstate( "maphint_stadium_code_computer", "on" );
        return;
    }
    
    player playerlogic::playerhasmoved();
    displaycode = br_bunker_utility::getcodecomputerdisplaycode( level.stadium_puzzle, instance.displaycodeindex );
    instance setscriptablepartstate( "maphint_stadium_code_computer", "off" );
    
    while ( instance.computermakingnose )
    {
        waitframe();
    }
    
    instance notify( #"computer_used" );
    playsoundatpos( instance.origin, "stadium_computer_code_start" );
    instance.computerscriptable setscriptablepartstate( "stadium_code_computer", "blank" );
    wait 2;
    
    foreach ( screenid in displaycode )
    {
        if ( isint( screenid ) )
        {
            screenid = "num" + screenid;
        }
        
        instance.computerscriptable setscriptablepartstate( "stadium_code_computer", screenid );
        playsoundatpos( instance.origin, "stadium_computer_code_number" );
        wait 1.5;
        instance.computerscriptable setscriptablepartstate( "stadium_code_computer", "blank" );
        wait 0.1;
    }
    
    instance.computerscriptable setscriptablepartstate( "stadium_code_computer", "reset" );
    playsoundatpos( instance.origin, "stadium_computer_code_end" );
    wait 3;
    instance.computerscriptable setscriptablepartstate( "stadium_code_computer", "intro" );
    instance setscriptablepartstate( "maphint_stadium_code_computer", "on" );
}

// Namespace br_stadium_puzzle
// Params 6
// Checksum 0x95fdcc77, Offset: 0xfb1
// Size: 0x48
function accessreaderscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _accessreaderscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_stadium_puzzle
// Params 5
// Checksum 0x6b484b42, Offset: 0x1001
// Size: 0xd3
function _accessreaderscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x6b>" );
    
    if ( getdvarint( @"hash_c18b5c0b64eb7d60", 0 ) == 1 || player br_quest_inventory::has_quest_item( instance.requiredcardtype ) )
    {
        br_bunker_utility::openscriptabledoors( instance );
        instance setscriptablepartstate( "maphint_stadium_access_reader", "off" );
        player br_quest_inventory::consume_quest_item( instance.requiredcardtype );
        return;
    }
    
    instance setscriptablepartstate( "maphint_stadium_access_reader", "disable" );
    player hud_message::showerrormessage( %"hash_7cae943bb2f78a30" );
    wait 3;
    instance setscriptablepartstate( "maphint_stadium_access_reader", "on" );
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0xb25471d9, Offset: 0x10dc
// Size: 0x22a
function boardroomdoorcodeentrysuccess( instance )
{
    playsoundatpos( instance.origin, "br_phone_code_correct" );
    
    foreach ( loc in level.stadium_puzzle.keypads )
    {
        loc.scriptable.doors = getentitylessscriptablearray( loc.target, #targetname );
        br_bunker_utility::unlockscriptabledoors( loc.scriptable );
        loc.scriptable setscriptablepartstate( "maphint_stadium_keypad", "off" );
    }
    
    foreach ( teammate in teams::getteamdata( self.team, "players" ) )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        teammate points::doscoreevent( #"hash_6e35364887f65743" );
    }
    
    level.stadium_puzzle.boardroomopen = 1;
    spawnboardroomblueprintweapons();
    
    if ( !arraycontains( level.stadium_puzzle.dlogs.var_3d551e3511667bbd, instance ) )
    {
        level.stadium_puzzle.dlogs.var_3d551e3511667bbd[ level.stadium_puzzle.dlogs.var_3d551e3511667bbd.size ] = instance;
    }
    
    utility::exploder( "stad_fireworks" );
    challenges::function_37e945722d6497f3( self, "sierra_sidequest_10", 1, 1 );
}

// Namespace br_stadium_puzzle
// Params 6
// Checksum 0x6bd66e84, Offset: 0x130e
// Size: 0x48
function keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_stadium_puzzle
// Params 5
// Checksum 0x7cd986ce, Offset: 0x135e
// Size: 0xa0
function _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x89>" || part == "<dev string:xa8>" || part == "<dev string:xbf>" );
    instance setscriptablepartstate( part, "off" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    wait 1;
    
    if ( instance.codestatus != 2 )
    {
        instance setscriptablepartstate( part, "on" );
    }
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xfe2141f, Offset: 0x1406
// Size: 0x185
function function_c16f77c317d19a76()
{
    level.stadium_puzzle.dlogs = { #var_a167504d3bf83f9f:[], #var_3d551e3511667bbd:[], #var_9e08290132e9b605:[], #var_125886877b981398:[], #var_f1781a432d60715c:[], #var_b5c89f8f3a11938a:[] };
    level waittill( #"game_ended" );
    dlog_recordevent( "dlog_event_br_sierra_sidequest_10", [ "players_obtained_keycards", level.stadium_puzzle.dlogs.var_b5c89f8f3a11938a.size ?? 0, "players_accessed_storage", level.stadium_puzzle.dlogs.var_f1781a432d60715c.size ?? 0, "players_accessed_bar", level.stadium_puzzle.dlogs.var_125886877b981398.size ?? 0, "players_accessed_parking", level.stadium_puzzle.dlogs.var_9e08290132e9b605.size ?? 0, "players_unlocked_executive", level.stadium_puzzle.dlogs.var_3d551e3511667bbd.size ?? 0, "players_accessed_executive", level.stadium_puzzle.dlogs.var_b5c89f8f3a11938a.size ?? 0 ] );
}

// Namespace br_stadium_puzzle
// Params 3
// Checksum 0x4f782, Offset: 0x1593
// Size: 0xad
function function_d384fa0da8df4b20( ent, dlog, var_ad39d17f9c5e9e44 )
{
    var_3e67b105b7897a0a = getnoentvolumearray( ent, #targetname );
    
    foreach ( trigger in var_3e67b105b7897a0a )
    {
        trigger thread function_27ccd0c9b18b1442( trigger, dlog, var_ad39d17f9c5e9e44 );
    }
}

// Namespace br_stadium_puzzle
// Params 3, eflags: 0x4
// Checksum 0xde6a0783, Offset: 0x1649
// Size: 0xfa
function private function_27ccd0c9b18b1442( trigger, dlogarray, var_ad39d17f9c5e9e44 )
{
    level endon( #"game_end" );
    loc = level.stadium_puzzle.hints[ var_ad39d17f9c5e9e44 ];
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            if ( var_ad39d17f9c5e9e44 == "stadium_boardroom_keypad" )
            {
                if ( !level.stadium_puzzle.boardroomopen )
                {
                    ent kill();
                    return;
                }
            }
            else
            {
                currentstate = loc.scriptable getscriptablepartstate( loc.scriptable.type );
                
                if ( currentstate == "on" )
                {
                    ent kill();
                    return;
                }
            }
            
            if ( !arraycontains( dlogarray, ent ) )
            {
                dlogarray[ dlogarray.size ] = ent;
            }
        }
        
        wait 0.1;
    }
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xad6a55a, Offset: 0x174b
// Size: 0xca
function spawnboardroomblueprintweapons()
{
    squadsize = teams::getteamdata( self.team, "players" );
    var_7b9c397db9ee656f = utility::array_sort_by_script_index( level.stadium_puzzle.var_c43e302cb7a685e0 );
    
    for ( i = 0; i < squadsize.size ; i++ )
    {
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( var_7b9c397db9ee656f[ i ].origin, var_7b9c397db9ee656f[ i ].angles );
        scriptable = common_item::function_61c2c0251e742ffd( %"hash_65b672d94f6c42dd", undefined, spawnoptions );
        scriptable.var_244eda363f575084 = 1;
    }
    
    level callback::add( #"item_weapon_picked_up", &function_89889ce9333427a6 );
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0xb38f3d6f, Offset: 0x181d
// Size: 0x56
function function_89889ce9333427a6( params )
{
    if ( !params.item.var_244eda363f575084 || params.item.type != "brloot_weapon_ar_p47_gilroy_secret" )
    {
        return;
    }
    
    challenges::function_37e945722d6497f3( self, "sierra_enigma_blueprint", 1, 1 );
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x3e48bcb8, Offset: 0x187b
// Size: 0xdc, Type: bool
function awardstadiumblueprint( player )
{
    foreach ( teammate in teams::getteamdata( player.team, "players" ) )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        challenges::function_37e945722d6497f3( teammate, "blueprint_unlock_629" );
        teammate analyticslog::logevent_challengeitemunlocked( teammate, "blueprint_unlock_629", "blueprint", 629 );
        optionalnumber = 0;
        
        if ( optionalnumber > 0 )
        {
            teammate thread hud_message::showsplash( "br_unlockable_weapon_splash", optionalnumber );
        }
    }
    
    return true;
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0x5bc639af, Offset: 0x1960
// Size: 0x8b
function activatemusictrigger()
{
    forward = anglestoforward( level.stadium_puzzle.interiordoor.angles );
    trigger = spawn( "trigger_radius", level.stadium_puzzle.interiordoor.origin + forward * -128, 0, 128, 128 );
    level thread musictriggerthink( trigger );
    wait 120;
    trigger notify( #"hash_6c86ce98e6503a6f" );
    trigger delete();
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x510c12b7, Offset: 0x19f3
// Size: 0x8b
function musictriggerthink( trigger )
{
    trigger endon( #"hash_6c86ce98e6503a6f" );
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        waitframe();
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.bunkermusicstarted )
        {
            continue;
        }
        
        player.bunkermusicstarted = 1;
        player setplayermusicstate( "br_bunker_reveal" );
    }
}

// Namespace br_stadium_puzzle
// Params 2
// Checksum 0x76e0d8aa, Offset: 0x1a86
// Size: 0xdd
function function_749ac7219f83fb2d( var_ad39d17f9c5e9e44, cardname )
{
    loc = utility::getstruct( var_ad39d17f9c5e9e44, "targetname" );
    
    if ( !loc )
    {
        return;
    }
    
    loc.scriptable = spawnscriptable( "maphint_stadium_access_reader", loc.origin );
    loc.scriptable.name = var_ad39d17f9c5e9e44;
    loc.scriptable.requiredcardtype = cardname;
    loc.scriptable.doors = getentitylessscriptablearray( loc.target, #targetname );
    br_bunker_utility::lockscriptabledoors( loc.scriptable );
    level.stadium_puzzle.hints[ var_ad39d17f9c5e9e44 ] = loc;
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xe59ccda4, Offset: 0x1b6b
// Size: 0x371
function gatherstadiumlocs()
{
    function_749ac7219f83fb2d( "stadium_upper_level_access_card", "wz_consumable_access_card_blue_stadium_" + "executive" );
    function_749ac7219f83fb2d( "stadium_concourse_access_reader", "wz_consumable_access_card_blue_stadium_" + "concourse" );
    function_749ac7219f83fb2d( "stadium_parking_garage_access_reader", "wz_consumable_access_card_blue_stadium_" + "parking" );
    locs = utility::getstructarray( "maphint_stadium_code_computer", "targetname" );
    level.stadium_puzzle.hints[ "maphint_stadium_code_computer" ] = [];
    
    foreach ( i, loc in locs )
    {
        computerscriptable = spawnscriptable( "stadium_code_computer", loc.origin, loc.angles );
        
        if ( false )
        {
            level thread computer_debugtestloop( computerscriptable );
        }
        
        targetarray = utility::getstructarray( loc.target, "targetname" );
        loc.scriptable = spawnscriptable( "maphint_stadium_code_computer", targetarray[ 0 ].origin, targetarray[ 0 ].angles );
        loc.scriptable.computerscriptable = computerscriptable;
        level.stadium_puzzle.hints[ "maphint_stadium_code_computer" ][ i ] = loc;
    }
    
    locs = utility::getstructarray( "stadium_boardroom_keypad", "targetname" );
    level.stadium_puzzle.keypads = locs;
    
    foreach ( loc in locs )
    {
        collisionorigin = undefined;
        
        if ( distance2dsquared( loc.origin, ( 31075, -521, 42 ) ) < 1024 )
        {
            loc.origin -= ( 5, 5, 0 );
            collisionorigin = ( 31226, -510, 0 );
        }
        else
        {
            collisionorigin = ( 31499, -192, 0 );
        }
        
        loc.scriptable = spawnscriptable( "maphint_stadium_keypad", loc.origin );
        loc.scriptable setscriptablepartstate( "maphint_stadium_keypad", "off" );
        loc.scriptable.doors = getentitylessscriptablearray( loc.target, #targetname );
        loc.scriptable.name = "stadium_boardroom_keypad";
        br_bunker_utility::lockscriptabledoors( loc.scriptable );
    }
    
    level.stadium_puzzle.hints[ "stadium_boardroom_keypad" ] = locs;
    level.stadium_puzzle.var_c43e302cb7a685e0 = utility::getstructarray( "stadium_ee_reward_blueprint", "targetname" );
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0x85e1233a, Offset: 0x1ee4
// Size: 0xee
function function_e19278fe421c22f9()
{
    var_dcf6ac8bf4b7c072 = [];
    var_dcf6ac8bf4b7c072[ "concourse" ] = [];
    var_dcf6ac8bf4b7c072[ "parking" ] = [];
    var_dcf6ac8bf4b7c072[ "executive" ] = [];
    utility::flag_wait( "scriptables_ready" );
    locs = utility::getstructarray( "stadium_ee_access_card", "targetname" );
    
    foreach ( loc in locs )
    {
        var_90abd0b765c18ae2 = getsubstr( loc.script_noteworthy, "wz_item_access_card_blue_stadium_".size );
        var_dcf6ac8bf4b7c072[ var_90abd0b765c18ae2 ][ var_dcf6ac8bf4b7c072[ var_90abd0b765c18ae2 ].size ] = loc.origin;
    }
    
    return var_dcf6ac8bf4b7c072;
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x447829a5, Offset: 0x1fdb
// Size: 0xee
function function_23e9ae6242aef4e1( var_dcf6ac8bf4b7c072 )
{
    foreach ( cardtype, spawnpoints in var_dcf6ac8bf4b7c072 )
    {
        if ( spawnpoints.size <= 0 )
        {
            return;
        }
        
        level.br_map_quest.quests[ "stadium_puzzle" ] br_quest_inventory::register_quest_item_funcs( "wz_consumable_access_card_blue_stadium_" + cardtype, { #used:&function_7bd35032e7733090 } );
        
        if ( getdvarint( @"hash_bd858729a3a3d5a2", 0 ) == 1 )
        {
            function_b68006e5f498c341( spawnpoints, "wz_consumable_access_card_blue_stadium_" + cardtype );
            continue;
        }
        
        function_f94b1c2d2723f7a5( spawnpoints, "wz_consumable_access_card_blue_stadium_" + cardtype );
    }
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x17383be7, Offset: 0x20d1
// Size: 0x72
function function_7bd35032e7733090( instance )
{
    if ( !arraycontains( level.stadium_puzzle.dlogs.var_b5c89f8f3a11938a, instance ) )
    {
        level.stadium_puzzle.dlogs.var_b5c89f8f3a11938a[ level.stadium_puzzle.dlogs.var_b5c89f8f3a11938a.size ] = instance;
    }
}

// Namespace br_stadium_puzzle
// Params 2
// Checksum 0xa53111e, Offset: 0x214b
// Size: 0x8f
function function_f94b1c2d2723f7a5( spawnpoints, var_32f24acf35e9e2e2 )
{
    origin = utility::array_random( spawnpoints );
    itembundle = common_item::function_cf68ad18114498b2( var_32f24acf35e9e2e2 );
    accesscard = common_item::function_a87dc047f584d2c7( itembundle, origin, ( 0, 0, 0 ), undefined, 1 );
    
    if ( getdvarint( @"hash_ab1148c5efd4f79a", 0 ) == 1 )
    {
        thread debug::drawsphere( origin, 64, 10000, ( 0, 1, 0 ) );
    }
    
    return accesscard;
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0xdb328fa9, Offset: 0x21e3
// Size: 0x4e
function showdebugresult( resulttext )
{
    timeshown = 0;
    
    while ( timeshown < 5 )
    {
        /#
            printtoscreen2d( 500, 500, resulttext, ( 1, 1, 1 ), 1 );
        #/
        
        waitframe();
        timeshown += 0.05;
    }
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x2a94f04f, Offset: 0x2239
// Size: 0x128
function debug_printcode( codestruct )
{
    level notify( #"hash_b8a65bbbbf4aa8d2" );
    level endon( #"hash_b8a65bbbbf4aa8d2" );
    numberspacing = 10;
    
    while ( true )
    {
        /#
            printtoscreen2d( 500, 100, "<dev string:xd5>", ( 1, 1, 1 ), 1 );
        #/
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            /#
                printtoscreen2d( 600, 100, "<dev string:xee>", ( 1, 1, 1 ), 1 );
            #/
        }
        else
        {
            foreach ( i, number in codestruct.code[ "array" ] )
            {
                /#
                    printtoscreen2d( 700 + numberspacing * i, 100, number, ( 1, 1, 1 ), 1 );
                #/
            }
        }
        
        waitframe();
    }
}

// Namespace br_stadium_puzzle
// Params 2
// Checksum 0xd0c656f1, Offset: 0x2369
// Size: 0xda
function function_b68006e5f498c341( spawnpoints, var_d861ef82838646fd )
{
    foreach ( loc in spawnpoints )
    {
        origin = loc;
        itembundle = common_item::function_cf68ad18114498b2( var_d861ef82838646fd );
        accesscard = common_item::function_a87dc047f584d2c7( itembundle, origin, ( 0, 0, 0 ), undefined, 1 );
        thread debug::drawsphere( origin, 64, 10000, ( 0, 1, 0 ) );
    }
}

// Namespace br_stadium_puzzle
// Params 1
// Checksum 0x3edb140d, Offset: 0x244b
// Size: 0x131
function computer_debugtestloop( scriptable )
{
    if ( !isdefined( scriptable ) )
    {
        return;
    }
    
    states = [ "intro", "num0", "num1", "num2", "num3", "num4", "num5", "num6", "num7", "num8", "num9", "symbol1", "symbol2", "symbol3", "symbol4", "reset" ];
    
    while ( true )
    {
        foreach ( state in states )
        {
            scriptable setscriptablepartstate( "stadium_code_computer", state );
            wait 1;
        }
    }
}

// Namespace br_stadium_puzzle
// Params 0
// Checksum 0xe3256209, Offset: 0x2584
// Size: 0xd1
function debug_showcardlocs()
{
    level notify( #"hash_c0ae25f22b6b7a50" );
    level endon( #"hash_c0ae25f22b6b7a50" );
    
    while ( true )
    {
        foreach ( scriptable in level.stadium_puzzle.var_4f94d2fdf720a40d )
        {
            if ( isdefined( scriptable.origin ) )
            {
                thread debug::drawsphere( scriptable.origin, 128, 1, ( 0, 1, 0 ) );
            }
        }
        
        wait 1;
    }
}

// Namespace br_stadium_puzzle
// Params 2
// Checksum 0x61d888d0, Offset: 0x265d
// Size: 0x65
function debug_show2dvotext( text, time )
{
    if ( true )
    {
        return;
    }
    
    curtime = 0;
    
    while ( curtime < time )
    {
        /#
            printtoscreen2d( 500, 350, "<dev string:x107>" + text, ( 1, 1, 1 ), 1.5 );
        #/
        
        waitframe();
        curtime += 0.05;
    }
}

/#

    // Namespace br_stadium_puzzle
    // Params 0
    // Checksum 0x3c7de16b, Offset: 0x26ca
    // Size: 0x182, Type: dev
    function function_3f20b8b021dae877()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_b816c5e95360de9e", 0 ) == 1 )
            {
                if ( !level.stadium_puzzle.boardroomopen )
                {
                    if ( level.stadium_puzzle.hints[ "<dev string:x24>" ].size > 0 )
                    {
                        foreach ( keypad in level.stadium_puzzle.hints[ "<dev string:x24>" ] )
                        {
                            boardroomdoorcodeentrysuccess( keypad.scriptable );
                        }
                    }
                    else
                    {
                        level.stadium_puzzle.boardroomopen = 1;
                    }
                }
                else
                {
                    utility::exploder( "<dev string:x10f>" );
                }
                
                setdvar( @"hash_b816c5e95360de9e", 0 );
            }
            
            if ( getdvarint( @"hash_ed073eb605049cef", 0 ) == 1 )
            {
                level thread debug_printcode( level.stadium_puzzle );
            }
            else
            {
                level notify( #"hash_b8a65bbbbf4aa8d2" );
            }
            
            if ( getdvarint( @"hash_6d2b60f74eb2d6f7", 0 ) == 1 )
            {
                level thread debug_showcardlocs();
            }
            else
            {
                level notify( #"hash_c0ae25f22b6b7a50" );
            }
            
            wait 1;
        }
    }

#/
