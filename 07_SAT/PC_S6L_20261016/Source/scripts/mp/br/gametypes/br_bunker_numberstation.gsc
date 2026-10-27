// scripts\mp\br\gametypes\br_bunker_numberstation.gsc  (hash_453a10b746bba1f5.gscc) (size: 27250 Bytes / 0x6a72 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa37e9f12 (2742984466)
// size ...... 27250 (0x6a72)
// includes .. 13  (offset: 0x6086)
// strings ... 118 (offset: 0x60ee)
// dev strs .. 18  (offset: 0x699a)
// exports ... 45  (offset: 0x4b7e)
// cseg ...... 0xa96 + 0x40e8 (0x4b7e)
// imports ... 96  (offset: 0x5286)
// animtree1 . 0   (offset: 0x6a72)
// animtree2 . 0   (offset: 0x6a72)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\playerlogic;

#namespace br_bunker_numberstation;

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x6e6c90d0, Offset: 0xab4
// Size: 0x32f
function init()
{
    level.bunker11puzzleactive = getdvarint( @"hash_f0560a69d3a8b55e", 1 ) && getdvarint( @"scr_sierra_sidequest_enabled", 1 );
    flags::gameflaginit( "stop_phone_code_ringing", 0 );
    level.bunker_numberstation = spawnstruct();
    doors = getentarray( "bunker_door_11", #targetname );
    entlessdoors = getentitylessscriptablearray( "bunker_door_11", #targetname );
    level.bunker_numberstation.door = entlessdoors[ 0 ] ?? doors[ 0 ];
    level.bunker_numberstation.hints[ "keypad" ] = [];
    initbunker11keypad();
    scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_11", &keypadscriptableused );
    
    if ( level.bunker11puzzleactive )
    {
        thread function_c54a8f2e07f295a();
        level.bunker_numberstation.hints = [];
        level.bunker_numberstation.hints[ "phones_code" ] = [];
        level.bunker_numberstation.hints[ "phones_morse" ] = [];
        initvo();
        level.bunker_numberstation.code = [];
        level.bunker_numberstation.codeentered = [];
        level.bunker_numberstation.successfulteams = [];
        level.bunker_numberstation.teamcodeprogress = [];
        level.bunker_numberstation.codecorrectlyenteredbyanyone = 0;
        level.bunker_numberstation.bunkeropened = 0;
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_0", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_1", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_2", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_3", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_4", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_5", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_6", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_7", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_8", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_morse_9", &phonemorsesinglescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_phone_code", &codephonescriptableused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_computer_reboot", &computerrebootused );
        scriptable::scriptable_addusedcallbackbypart( "maphint_red_button", &redbuttonused );
        level.var_23ad0a582089f255 = utility::getstructarray( "bunker11_red_button", "targetname" );
        level.bunker11_mistswindow = utility::getstructarray( "bunker11_cleanroom_window", "targetname" );
        level.bunker11_mistsdoors = utility::getstructarray( "bunker11_cleanroom_door", "targetname" );
        level.serverroomtvs = utility::getstructarray( "bunker11_serverTV", "targetname" );
        level.warroomtvs = utility::getstructarray( "bunker11_warroomTV", "targetname" );
        level.var_a096cfd0269d42c6 = utility::getstructarray( "bunker11_serverroom_computer", "targetname" );
    }
    
    level thread initpostmain();
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xfe7da80d, Offset: 0xdeb
// Size: 0x10c
function initpostmain()
{
    waittillframeend();
    level thread br_bunker_utility::initbunkerdoor( level.bunker_numberstation.door, 0 );
    
    if ( !level.bunker11puzzleactive )
    {
        return;
    }
    
    if ( getdvarint( @"hash_b5459d30b6053605", 1 ) )
    {
        level thread br_bunker_utility::function_570a0e83663d22a4( "bunker_staged_reward_number_station" );
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    if ( level.mapname == "mp_bm_bunker01" )
    {
        initlocs_bunkertest();
    }
    else
    {
        initlocs_donetsk();
    }
    
    /#
        if ( false )
        {
            level thread debug_hintadjustmentthink();
        }
        
        if ( getdvarint( @"hash_664ec58759f1617", 0 ) )
        {
            level thread debug_bunkerpuzzledebugdraw();
        }
        
        level thread function_3f20b8b021dae877();
    #/
    
    codelength = getdvarint( @"hash_4bb3dd5af7368f36", 3 );
    generatenumbercode( codelength, level.bunker_numberstation );
    level thread phonesringing_singlemorse();
    level thread phonesringing_code();
    level thread br_pickups::registeruniquelootcallback( 1, &awardbunker11blueprint );
    
    /#
        if ( false )
        {
            computerrebootsequence_init();
            redbutton_init();
        }
    #/
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x35a7b572, Offset: 0xeff
// Size: 0x19b
function initvo()
{
    level.bunker11vo = [];
    level.bunker11vo[ "VO_MORSE_0" ] = "dx_br_vrdr_bnkr_rubc_kyp0";
    level.bunker11vo[ "VO_MORSE_1" ] = "dx_br_vrdr_bnkr_rubc_kyp1";
    level.bunker11vo[ "VO_MORSE_2" ] = "dx_br_vrdr_bnkr_rubc_kyp2";
    level.bunker11vo[ "VO_MORSE_3" ] = "dx_br_vrdr_bnkr_rubc_kyp3";
    level.bunker11vo[ "VO_MORSE_4" ] = "dx_br_vrdr_bnkr_rubc_kyp4";
    level.bunker11vo[ "VO_MORSE_5" ] = "dx_br_vrdr_bnkr_rubc_kyp5";
    level.bunker11vo[ "VO_MORSE_6" ] = "dx_br_vrdr_bnkr_rubc_kyp6";
    level.bunker11vo[ "VO_MORSE_7" ] = "dx_br_vrdr_bnkr_rubc_kyp7";
    level.bunker11vo[ "VO_MORSE_8" ] = "dx_br_vrdr_bnkr_rubc_kyp8";
    level.bunker11vo[ "VO_MORSE_9" ] = "dx_br_vrdr_bnkr_rubc_kyp9";
    level.bunker11vo[ "VO_OK_THATS_GOOD" ] = "dx_br_vrdr_bnkr_rubc_cdcr";
    level.bunker11vo[ "VO_NORTH_SECURE" ] = "dx_br_vrdr_bnkr_rubc_cdcr2";
    level.bunker11vo[ "VO_BURN_TEAM_INBOUND" ] = "dx_br_vrdr_bnkr_rubc_cdcr3";
    level.bunker11vo[ "VO_BASE_OVERRUN" ] = "dx_br_vrdr_bnkr_rubc_cdph";
    level.bunker11vo[ "VO_STAND_BY" ] = "dx_br_vrdr_bnkr_rubc_cdp2";
    level.bunker11vo[ "VO_HEAR_THAT" ] = "dx_br_vrdr_bnkr_rubc_cdp3";
    level.bunker11vo[ "VO_LOCK_DOOR" ] = "dx_br_vrdr_bnkr_rubc_cdp4";
    level.bunker11vo[ "VO_NEGATIVE" ] = "dx_br_vrdr_bnkr_rubc_cdin";
    level.bunker11vo[ "VO_WILL_COMPLY" ] = "dx_br_vrdr_bnkr_rubc_cdin2";
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x1028a683, Offset: 0x10a2
// Size: 0xd9
function initbunker11keypad()
{
    door = level.bunker_numberstation.door;
    forward = anglestoforward( door.angles );
    left = anglestoleft( door.angles );
    hintorigin = door.origin + ( 0, 0, 45 ) + forward * 37 + left * 80;
    level.bunker_numberstation.hints[ "keypad" ][ 0 ] = spawnscriptable( "maphint_keypad_bunker_11", hintorigin );
    
    if ( !level.bunker11puzzleactive )
    {
        level thread function_7d84dce43903a709( level.bunker_numberstation.hints[ "keypad" ][ 0 ] );
    }
}

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0xf1b90a00, Offset: 0x1183
// Size: 0x1e
function function_7d84dce43903a709( keypadscriptable )
{
    waitframe();
    keypadscriptable setscriptablepartstate( "maphint_keypad_bunker_11", "inaccessible" );
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x5f6fed2e, Offset: 0x11a9
// Size: 0x148
function function_c54a8f2e07f295a()
{
    level.bunker_numberstation.dlogs = { #var_c4f1a4252c0ee436:0, #eligibleteameliminated:0, #bunkeropened:0, #var_62c7d1d837f98f51:0, #var_e7a1f89840f1784:0 };
    callback::add( #"on_squad_wiped", &onsquadwiped );
    level waittill( #"game_ended" );
    dlog_recordevent( "dlog_event_br_sierra_sidequest_9", [ "code_phone_used", level.bunker_numberstation.dlogs.var_e7a1f89840f1784, "morse_phone_used", level.bunker_numberstation.dlogs.var_62c7d1d837f98f51, "bunker_opened", level.bunker_numberstation.dlogs.bunkeropened, "eligible_team_eliminated", level.bunker_numberstation.dlogs.eligibleteameliminated, "player_entered_bunker", level.bunker_numberstation.dlogs.var_c4f1a4252c0ee436 ] );
}

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0xd098f8d0, Offset: 0x12f9
// Size: 0x79
function onsquadwiped( params )
{
    if ( arraycontains( level.bunker_numberstation.successfulteams, params.victim.team ) )
    {
        level.bunker_numberstation.dlogs.eligibleteameliminated += 1;
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x1da4acf6, Offset: 0x137a
// Size: 0x10
function initlocs_donetsk()
{
    initlocs_morsephones();
    initlocs_codeprovidingphones();
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xcd44bb6a, Offset: 0x1392
// Size: 0x457
function initlocs_morsephones()
{
    level.bunker_numberstation.hints[ "phones_morse" ] = [];
    level.bunker_numberstation.hints[ "phones_morse" ][ 0 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 0 ].origin = ( 3952, 46908, 1335 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 1 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 1 ].origin = ( 23123, -18205, -33 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 2 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 2 ].origin = ( 13947, 33508, 1664 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 3 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 3 ].origin = ( 35858, 46586, 775 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 4 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 4 ].origin = ( 47021, 19903, -160 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 5 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 5 ].origin = ( 15038, 16890, 195 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 6 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 6 ].origin = ( -22142, 27099, 1170 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 7 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 7 ].origin = ( -21992, 18882, -330 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 8 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 8 ].origin = ( 9911, -12258, -236 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 9 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 9 ].origin = ( -25179, 45438, 155 );
    
    foreach ( index, hint in level.bunker_numberstation.hints[ "phones_morse" ] )
    {
        hint.scriptable = spawnscriptable( "maphint_phone_morse_" + index, hint.origin );
        hint.scriptable.ringing = 0;
        
        if ( isdefined( hint.sound ) )
        {
            hint.scriptable.sound = hint.sound;
        }
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x317d6a86, Offset: 0x17f1
// Size: 0x6d3
function initlocs_codeprovidingphones()
{
    level.bunker_numberstation.hints[ "phones_code" ] = [];
    level.bunker_numberstation.hints[ "phones_code" ][ 0 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 0 ].origin = ( -12202, -26944, 19 );
    level.bunker_numberstation.hints[ "phones_code" ][ 1 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 1 ].origin = ( -16385, -19708, -257 );
    level.bunker_numberstation.hints[ "phones_code" ][ 2 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 2 ].origin = ( -28158, -18173, -161 );
    level.bunker_numberstation.hints[ "phones_code" ][ 3 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 3 ].origin = ( 19472, -21677, 28 );
    level.bunker_numberstation.hints[ "phones_code" ][ 4 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 4 ].origin = ( 19353, -14238, 2904 );
    level.bunker_numberstation.hints[ "phones_code" ][ 5 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 5 ].origin = ( -6430, 1817, -250 );
    level.bunker_numberstation.hints[ "phones_code" ][ 6 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 6 ].origin = ( 2448, 29025, 78 );
    level.bunker_numberstation.hints[ "phones_code" ][ 7 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 7 ].origin = ( 15510, 18142, 193 );
    level.bunker_numberstation.hints[ "phones_code" ][ 8 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 8 ].origin = ( 45109, 16906, -312 );
    level.bunker_numberstation.hints[ "phones_code" ][ 9 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 9 ].origin = ( 14565, 36646, 1500 );
    level.bunker_numberstation.hints[ "phones_code" ][ 10 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 10 ].origin = ( -24445, 43755, -118 );
    level.bunker_numberstation.hints[ "phones_code" ][ 10 ].sound = "ringing2";
    level.bunker_numberstation.hints[ "phones_code" ][ 11 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 11 ].origin = ( -15261, 14334, -26 );
    level.bunker_numberstation.hints[ "phones_code" ][ 12 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 12 ].origin = ( 34295, 29141, 836 );
    level.bunker_numberstation.hints[ "phones_code" ][ 13 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 13 ].origin = ( -2836, 57277, 655 );
    level.bunker_numberstation.hints[ "phones_code" ][ 14 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 14 ].origin = ( 36572, -29087, -465 );
    level.bunker_numberstation.hints[ "phones_code" ][ 15 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 15 ].origin = ( 16482, 3011, -530 );
    level.bunker_numberstation.hints[ "phones_code" ][ 16 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 16 ].origin = ( 45714, 1255, 67 );
    
    foreach ( hint in level.bunker_numberstation.hints[ "phones_code" ] )
    {
        hint.scriptable = spawnscriptable( "maphint_phone_code", hint.origin );
        hint.scriptable.ringing = 0;
        
        if ( isdefined( hint.sound ) )
        {
            hint.scriptable.sound = hint.sound;
        }
    }
}

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0x9af6e375, Offset: 0x1ecc
// Size: 0xe2, Type: bool
function awardbunker11blueprint( player )
{
    foreach ( squadmate in teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid ) )
    {
        if ( !isdefined( squadmate ) )
        {
            continue;
        }
        
        challenges::function_37e945722d6497f3( squadmate, "blueprint_unlock_584" );
        squadmate analyticslog::logevent_challengeitemunlocked( squadmate, "blueprint_unlock_584", "blueprint", 584 );
        optionalnumber = 0;
        
        if ( optionalnumber > 0 )
        {
            squadmate thread hud_message::showsplash( "br_unlockable_weapon_splash", optionalnumber );
        }
    }
    
    return true;
}

// Namespace br_bunker_numberstation
// Params 6
// Checksum 0xd1e197f4, Offset: 0x1fb7
// Size: 0x96
function codephonescriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x24>" );
    level thread _codephonescriptableused( instance, part, state, player, bautouse );
    level.bunker_numberstation.dlogs.var_e7a1f89840f1784 += 1;
}

// Namespace br_bunker_numberstation
// Params 5
// Checksum 0x1f01cca3, Offset: 0x2055
// Size: 0x451
function _codephonescriptableused( instance, part, state, player, bautouse )
{
    if ( state != "off" )
    {
        if ( ( !flags::gameflag( "prematch_done" ) || !instance.startingcodephone ) && level.bunker_numberstation.successfulteams.size == 0 )
        {
            instance setscriptablepartstate( "maphint_phone_code", "deny" );
            wait 3;
            instance setscriptablepartstate( "maphint_phone_code", "on" );
            return;
        }
        
        player playerlogic::playerhasmoved();
        instance setscriptablepartstate( "maphint_phone_code", "off" );
        
        while ( instance.ringing )
        {
            waitframe();
        }
        
        instance notify( #"phone_picked_up" );
        
        if ( level.bunker_numberstation.successfulteams.size > 0 )
        {
            playsoundatpos( instance.origin, "br_phone_code_correct" );
            wait 1;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_NORTH_SECURE" ] );
            level thread debug_show2dvotext( "North Secure", 1.24 );
            wait 1.24;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_NORTH_SECURE" ] );
            level thread debug_show2dvotext( "North Secure", 2 );
            wait 2;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_OK_THATS_GOOD" ] );
            level thread debug_show2dvotext( "Ok. That's good.", 2 );
            wait 2;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_BURN_TEAM_INBOUND" ] );
            level thread debug_show2dvotext( "Copy. Burn team inbound.", 2 );
            wait 2;
            playsoundatpos( instance.origin, "br_phone_code_correct" );
            wait 1.5;
            
            foreach ( number in level.bunker_numberstation.code )
            {
                playsoundatpos( instance.origin, level.bunker11vo[ "VO_MORSE_" + number ] );
                wait 1.5;
            }
            
            playsoundatpos( instance.origin, "br_phone_code_correct" );
        }
        else
        {
            wait 1;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_BASE_OVERRUN" ] );
            level thread debug_show2dvotext( "All teams. Base has been overun. Switch to cryptography.", 3 );
            wait 3;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_STAND_BY" ] );
            level thread debug_show2dvotext( "Stand By", 2 );
            wait 2;
            playsoundatpos( instance.origin, "br_phone_code_correct" );
            wait 1.5;
            
            foreach ( number in level.bunker_numberstation.code )
            {
                playsoundatpos( instance.origin, level.bunker11vo[ "VO_MORSE_" + number ] );
                wait 1.5;
            }
            
            playsoundatpos( instance.origin, "br_phone_code_correct" );
            wait 1;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_HEAR_THAT" ] );
            level thread debug_show2dvotext( "You hear that?", 2 );
            wait 2;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_LOCK_DOOR" ] );
            level thread debug_show2dvotext( "Lock the door! They're coming!", 2 );
        }
        
        wait 3;
        instance setscriptablepartstate( "maphint_phone_code", "on" );
        instance thread ringphoneoccasionally();
    }
}

// Namespace br_bunker_numberstation
// Params 6
// Checksum 0x53147cf0, Offset: 0x24ae
// Size: 0x246
function phonemorsesinglescriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x37>" || part == "<dev string:x4d>" || part == "<dev string:x63>" || part == "<dev string:x79>" || part == "<dev string:x8f>" || part == "<dev string:xa5>" || part == "<dev string:xbb>" || part == "<dev string:xd1>" || part == "<dev string:xe7>" || part == "<dev string:xfd>" );
    
    switch ( part )
    {
        case #"hash_a45da4772fdfaea5":
            instance.morsenumber = 0;
            break;
        case #"hash_a45da3772fdfad12":
            instance.morsenumber = 1;
            break;
        case #"hash_a45da2772fdfab7f":
            instance.morsenumber = 2;
            break;
        case #"hash_a45da1772fdfa9ec":
            instance.morsenumber = 3;
            break;
        case #"hash_a45da0772fdfa859":
            instance.morsenumber = 4;
            break;
        case #"hash_a45d9f772fdfa6c6":
            instance.morsenumber = 5;
            break;
        case #"hash_a45d9e772fdfa533":
            instance.morsenumber = 6;
            break;
        case #"hash_a45d9d772fdfa3a0":
            instance.morsenumber = 7;
            break;
        case #"hash_a45dac772fdfbb3d":
            instance.morsenumber = 8;
            break;
        case #"hash_a45dab772fdfb9aa":
            instance.morsenumber = 9;
            break;
        default:
            assertmsg( "<dev string:x113>" );
            break;
    }
    
    level thread _phonemorsesinglescriptableused( instance, part, state, player, bautouse );
    level.bunker_numberstation.dlogs.var_62c7d1d837f98f51 += 1;
}

// Namespace br_bunker_numberstation
// Params 5
// Checksum 0x8cd9bbea, Offset: 0x26fc
// Size: 0x2cc
function _phonemorsesinglescriptableused( instance, part, state, player, bautouse )
{
    if ( state != "off" )
    {
        team = player.team;
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            playsoundatpos( instance.origin, "br_morse_" + instance.morsenumber );
            instance setscriptablepartstate( "maphint_phone_morse_" + instance.morsenumber, "off" );
            wait 3;
            instance setscriptablepartstate( "maphint_phone_morse_" + instance.morsenumber, "on" );
            return;
        }
        
        player playerlogic::playerhasmoved();
        instance setscriptablepartstate( "maphint_phone_morse_" + instance.morsenumber, "off" );
        
        while ( instance.ringing )
        {
            waitframe();
        }
        
        instance notify( #"phone_picked_up" );
        
        if ( level.bunker_numberstation.successfulteams.size > 0 )
        {
            playsoundatpos( instance.origin, "br_phone_code_correct" );
            wait 1;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_NORTH_SECURE" ] );
            level thread debug_show2dvotext( "North Secure", 1.24 );
            wait 1.24;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_NORTH_SECURE" ] );
            level thread debug_show2dvotext( "North Secure", 2 );
            wait 2;
            playsoundatpos( instance.origin, level.bunker11vo[ "VO_BURN_TEAM_INBOUND" ] );
            level thread debug_show2dvotext( "Copy. Burn team inbound.", 2 );
            wait 2;
        }
        
        if ( !arraycontains( level.bunker_numberstation.successfulteams, team ) )
        {
            playsoundatpos( instance.origin, "br_morse_" + instance.morsenumber );
            wait 2;
            
            if ( !arraycontains( level.bunker_numberstation.successfulteams, team ) )
            {
                entercodenumber( level.bunker_numberstation, instance.morsenumber, team );
                codestatus = checkcodeentered( level.bunker_numberstation, team );
                
                if ( codestatus == 1 )
                {
                    level thread correctcodeentered( instance, level.bunker_numberstation, team );
                }
                else if ( codestatus == 0 )
                {
                    level thread incorrectcodeentered( instance, level.bunker_numberstation, team );
                }
            }
        }
        
        wait 3;
        instance setscriptablepartstate( "maphint_phone_morse_" + instance.morsenumber, "on" );
        instance thread ringphoneoccasionally();
    }
}

// Namespace br_bunker_numberstation
// Params 6
// Checksum 0x8742d32c, Offset: 0x29d0
// Size: 0x48
function keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_bunker_numberstation
// Params 5
// Checksum 0x59bcb34d, Offset: 0x2a20
// Size: 0x1aa
function _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x160>" );
    
    if ( level.bunker11puzzleactive && ( getdvarint( @"hash_2b47e76d55a2b0b2", 0 ) == 1 || arraycontains( level.bunker_numberstation.successfulteams, player.team ) ) )
    {
        playsoundatpos( instance.origin, "br_keypad_confirm" );
        instance setscriptablepartstate( "maphint_keypad_bunker_11", "off" );
        wait 2.5;
        level thread br_bunker_utility::openbunkerdoor( level.bunker_numberstation.door, 1, "bunker_loot_11", "door_open_puzzle" );
        level.bunker_numberstation.bunkeropened = 1;
        level.bunker_numberstation.dlogs.bunkeropened = 1;
        level thread activatemusictrigger();
        challenges::function_37e945722d6497f3( player, "sierra_sidequest_9", 1, 1 );
        points::function_40522c040a4e7b1( player.team, #"br_bunker_opened" );
        callback::remove( #"on_squad_wiped", &onsquadwiped );
        
        if ( true )
        {
            computerrebootsequence_init();
            redbutton_init();
        }
        
        return;
    }
    
    playsoundatpos( instance.origin, "br_keypad_deny" );
    instance setscriptablepartstate( "maphint_keypad_bunker_11", "off" );
    wait 3;
    instance setscriptablepartstate( "maphint_keypad_bunker_11", "on" );
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xa299fbbc, Offset: 0x2bd2
// Size: 0x74
function activatemusictrigger()
{
    forward = anglestoforward( level.bunker_numberstation.door.angles );
    trigger = spawn( "trigger_radius", level.bunker_numberstation.door.origin + forward * -128, 0, 128, 128 );
    level thread musictriggerthink( trigger );
}

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0x99d5bf45, Offset: 0x2c4e
// Size: 0xc9
function musictriggerthink( trigger )
{
    trigger endon( #"game_ended" );
    
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
        level.bunker_numberstation.dlogs.var_c4f1a4252c0ee436 += 1;
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xd3310c08, Offset: 0x2d1f
// Size: 0x195
function phonesringing_code()
{
    var_d43c24412ecd3b95 = getdvarint( @"hash_9f70d8030533cf20", 50 );
    var_a5a3103db7c0fee1 = max( 1, level.bunker_numberstation.hints[ "phones_code" ].size * var_d43c24412ecd3b95 * 0.01 );
    level.bunker_numberstation.hints[ "phones_code" ] = arrayrandomize( level.bunker_numberstation.hints[ "phones_code" ] );
    chosenphones = [];
    
    for ( i = 0; i < int( var_a5a3103db7c0fee1 ) ; i++ )
    {
        chosenphones[ chosenphones.size ] = level.bunker_numberstation.hints[ "phones_code" ][ i ];
    }
    
    foreach ( phonelocation in chosenphones )
    {
        phonelocation.scriptable.startingcodephone = 1;
        phonelocation.scriptable thread ringcodephoneconstantly();
        phonelocation.scriptable setscriptablepartstate( "maphint_phone_code", "on" );
    }
    
    level.bunker_numberstation.chosencodephones = chosenphones;
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xd803b3ba, Offset: 0x2ebc
// Size: 0x94
function phonesringing_singlemorse()
{
    foreach ( phonelocation in level.bunker_numberstation.hints[ "phones_morse" ] )
    {
        phonelocation.scriptable thread ringphoneoccasionally();
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x64cf6db6, Offset: 0x2f58
// Size: 0xcf
function codephonescodeenteredringingfrenzy()
{
    level thread tracktimeringingfrenzy();
    
    foreach ( phonelocation in level.bunker_numberstation.hints[ "phones_code" ] )
    {
        if ( !phonelocation.scriptable.startingcodephone )
        {
            phonelocation.scriptable thread ringcodephoneconstantly();
            phonelocation.scriptable setscriptablepartstate( "maphint_phone_code", "on" );
        }
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xee64339, Offset: 0x302f
// Size: 0xd9
function ringphoneoccasionally()
{
    self endon( #"phone_picked_up" );
    wait randomintrange( 30, 55 );
    
    while ( !level.bunker_numberstation.bunkeropened )
    {
        for ( i = 0; i < 4 ; i++ )
        {
            self.ringing = 1;
            
            if ( true )
            {
                self setscriptablepartstate( self.type, "ringing" );
            }
            
            if ( false )
            {
                thread debug::drawsphere( self.origin, 32, 3, ( 0, 1, 0 ) );
            }
            
            wait 3;
            
            if ( self getscriptablepartstate( self.type ) != "off" )
            {
                self setscriptablepartstate( self.type, "on" );
            }
            
            self.ringing = 0;
            wait 3;
        }
        
        wait randomintrange( 30, 55 );
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x85b5dda8, Offset: 0x3110
// Size: 0xcc
function ringcodephoneconstantly()
{
    self endon( #"phone_picked_up" );
    
    while ( !flags::gameflag( "stop_phone_code_ringing" ) )
    {
        self.ringing = 1;
        
        if ( true )
        {
            if ( isdefined( self.sound ) )
            {
                self setscriptablepartstate( self.type, self.sound );
            }
            else
            {
                self setscriptablepartstate( self.type, "ringing" );
            }
        }
        
        if ( false )
        {
            thread debug::drawsphere( self.origin, 32, 3, ( 1, 0, 0 ) );
        }
        
        wait 3;
        
        if ( self getscriptablepartstate( self.type ) != "off" )
        {
            self setscriptablepartstate( self.type, "on" );
        }
        
        self.ringing = 0;
        wait 3;
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x23d5eae, Offset: 0x31e4
// Size: 0x11
function tracktimeringingfrenzy()
{
    wait 120;
    flags::gameflagset( "stop_phone_code_ringing" );
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x5d4f9459, Offset: 0x31fd
// Size: 0x15b
function computerrebootsequence_init()
{
    spawnscriptable( "maphint_computer_reboot", level.var_a096cfd0269d42c6[ 0 ].origin );
    
    foreach ( index, tv in level.serverroomtvs )
    {
        level.serverroomtvs[ index ].scriptable = spawnscriptable( "bunker11_serverroom_monitor", tv.origin, tv.angles );
    }
    
    foreach ( index, tv in level.warroomtvs )
    {
        level.warroomtvs[ index ].scriptable = spawnscriptable( "bunker11_warroom_monitor", tv.origin, tv.angles );
    }
}

// Namespace br_bunker_numberstation
// Params 6
// Checksum 0x98aa9f16, Offset: 0x3360
// Size: 0x44
function computerrebootused( instance, part, state, player, bautouse, usestring )
{
    level thread _computerrebootsequence_start( instance, player );
}

// Namespace br_bunker_numberstation
// Params 2
// Checksum 0xb44a9834, Offset: 0x33ac
// Size: 0x2d5
function _computerrebootsequence_start( instance, player )
{
    level endon( #"game_ended" );
    instance setscriptablepartstate( "maphint_computer_reboot", "off" );
    playsoundatpos( instance.origin, "emt_bunk_pc_keyboard_typing" );
    wait 3;
    playsoundatpos( instance.origin, "emt_bunk_pc_reboot" );
    
    foreach ( tv in level.serverroomtvs )
    {
        tv.scriptable setscriptablepartstate( "bunker11_serverroom_monitor", "rebooting" );
    }
    
    foreach ( tv in level.warroomtvs )
    {
        tv.scriptable setscriptablepartstate( "bunker11_warroom_monitor", "rebooting" );
    }
    
    wait 3;
    
    foreach ( tv in level.serverroomtvs )
    {
        tv.scriptable setscriptablepartstate( "bunker11_serverroom_monitor", "ready" );
    }
    
    foreach ( tv in level.warroomtvs )
    {
        tv.scriptable setscriptablepartstate( "bunker11_warroom_monitor", "countdown" );
    }
    
    wait 7;
    
    for ( i = 0; i < 3 ; i++ )
    {
        triggerportableradarpingteam( instance.origin, player.team, 12000, 3000 );
        wait 3;
    }
    
    wait 30;
    
    if ( getdvarint( @"hash_c11ffcf6f8a5ff27", 1 ) == 1 )
    {
        instance setscriptablepartstate( "maphint_computer_reboot", "on" );
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x43bfca7f, Offset: 0x3689
// Size: 0x1af
function redbutton_init()
{
    spawnscriptable( "maphint_red_button", level.var_23ad0a582089f255[ 0 ].origin );
    
    foreach ( index, window in level.bunker11_mistswindow )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( window.angles ) )
        {
            angles = window.angles;
        }
        
        level.bunker11_mistswindow[ index ].scriptable = spawnscriptable( "bunker11_cleanroom_mist", window.origin, angles );
    }
    
    foreach ( index, door in level.bunker11_mistsdoors )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( door.angles ) )
        {
            angles = door.angles;
        }
        
        level.bunker11_mistsdoors[ index ].scriptable = spawnscriptable( "bunker11_cleanroom_mist_door", door.origin, angles );
    }
}

// Namespace br_bunker_numberstation
// Params 6
// Checksum 0x86eda7b2, Offset: 0x3840
// Size: 0x44
function redbuttonused( instance, part, state, player, bautouse, usestring )
{
    level thread _redbuttonused_internal( instance, player );
}

// Namespace br_bunker_numberstation
// Params 2
// Checksum 0x12a08287, Offset: 0x388c
// Size: 0x161
function _redbuttonused_internal( instance, player )
{
    instance setscriptablepartstate( "maphint_red_button", "off" );
    playsoundatpos( instance.origin, "emt_bunk_red_button_press" );
    
    foreach ( window in level.bunker11_mistswindow )
    {
        window.scriptable setscriptablepartstate( "bunker11_cleanroom_mist", "off" );
    }
    
    foreach ( door in level.bunker11_mistsdoors )
    {
        door.scriptable setscriptablepartstate( "bunker11_cleanroom_mist_door", "off" );
    }
    
    wait 5;
    instance setscriptablepartstate( "maphint_red_button", "on" );
}

// Namespace br_bunker_numberstation
// Params 2
// Checksum 0xb47e6118, Offset: 0x39f5
// Size: 0x37
function generatenumbercode( codelength, codestruct )
{
    br_bunker_utility::generatenumbercode_array( codelength, codestruct );
    
    if ( false )
    {
        level thread printcodechosen( codestruct );
        level thread printcodeentered( codestruct );
    }
}

// Namespace br_bunker_numberstation
// Params 3
// Checksum 0xae4d3c78, Offset: 0x3a34
// Size: 0x5f
function entercodenumber( codestruct, number, team )
{
    if ( !isdefined( codestruct.codeentered[ team ] ) )
    {
        codestruct.codeentered[ team ] = [];
    }
    
    codestruct.codeentered[ team ][ codestruct.codeentered[ team ].size ] = number;
}

// Namespace br_bunker_numberstation
// Params 2
// Checksum 0x63d74058, Offset: 0x3a9b
// Size: 0x82
function checkcodeentered( codestruct, team )
{
    if ( codestruct.codeentered[ team ].size < codestruct.code.size )
    {
        return -1;
    }
    
    for ( i = 0; i < codestruct.code.size ; i++ )
    {
        if ( codestruct.code[ i ] != codestruct.codeentered[ team ][ i ] )
        {
            return 0;
        }
    }
    
    return 1;
}

// Namespace br_bunker_numberstation
// Params 3
// Checksum 0x2167e74e, Offset: 0x3b26
// Size: 0x1d8
function correctcodeentered( instance, codestruct, team )
{
    if ( false )
    {
        level thread showdebugresult( "Correct Code Entered!" );
    }
    
    if ( codestruct.successfulteams.size == 0 )
    {
        level.bunker_numberstation.door.lightscriptable setscriptablepartstate( "bunker_active_indicator_light", "active" );
    }
    
    codestruct.successfulteams[ codestruct.successfulteams.size ] = team;
    level.bunker_numberstation.dlogs.bunkeropened = 1;
    playsoundatpos( instance.origin, "br_phone_code_correct" );
    wait 1;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_OK_THATS_GOOD" ] );
    level thread debug_show2dvotext( "Ok. That's good.", 2 );
    wait 2;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_NORTH_SECURE" ] );
    level thread debug_show2dvotext( "North Secure", 1.1 );
    wait 1.1;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_NORTH_SECURE" ] );
    level thread debug_show2dvotext( "North Secure", 2 );
    wait 2;
    playsoundatpos( instance.origin, "br_phone_code_correct" );
    wait 1;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_BURN_TEAM_INBOUND" ] );
    level thread debug_show2dvotext( "Copy. Burn team inbound.", 2 );
    wait 2;
    
    if ( !level.bunker_numberstation.codecorrectlyenteredbyanyone )
    {
        codephonescodeenteredringingfrenzy();
        return;
    }
    
    level.bunker_numberstation.codecorrectlyenteredbyanyone = 1;
}

// Namespace br_bunker_numberstation
// Params 3
// Checksum 0x883256be, Offset: 0x3d06
// Size: 0xf1
function incorrectcodeentered( instance, codestruct, team )
{
    codestruct.codeentered[ team ] = undefined;
    
    if ( false )
    {
        level thread showdebugresult( "ERROR: Wrong Code Entered!" );
    }
    
    playsoundatpos( instance.origin, "br_phone_code_incorrect" );
    wait 1;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_NEGATIVE" ] );
    level thread debug_show2dvotext( "Negative", 1.24 );
    wait 1.24;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_NEGATIVE" ] );
    level thread debug_show2dvotext( "Negative", 1.5 );
    wait 1.5;
    playsoundatpos( instance.origin, level.bunker11vo[ "VO_WILL_COMPLY" ] );
    level thread debug_show2dvotext( "Copy. Will comply.", 2 );
}

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0x37a63201, Offset: 0x3dff
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

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0x1948419c, Offset: 0x3e55
// Size: 0x131
function printcodechosen( codestruct )
{
    level notify( #"hash_1c55759819d815ab" );
    level endon( #"hash_1c55759819d815ab" );
    numberspacing = 10;
    
    while ( true )
    {
        /#
            printtoscreen2d( 500, 400, "<dev string:x179>", ( 1, 1, 1 ), 1 );
        #/
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            /#
                printtoscreen2d( 600, 400, "<dev string:x187>", ( 1, 1, 1 ), 1 );
            #/
        }
        else
        {
            foreach ( i, number in codestruct.code )
            {
                /#
                    printtoscreen2d( 600 + numberspacing * i, 400, codestruct.code[ i ], ( 1, 1, 1 ), 1 );
                #/
            }
        }
        
        waitframe();
    }
}

// Namespace br_bunker_numberstation
// Params 1
// Checksum 0x1cd2bb53, Offset: 0x3f8e
// Size: 0x1d8
function printcodeentered( codestruct )
{
    level notify( #"hash_6cc5299f5221efb7" );
    level endon( #"hash_6cc5299f5221efb7" );
    numberspacing = 10;
    teamspacing = 30;
    
    while ( true )
    {
        teamindex = 0;
        
        foreach ( team, codegroup in codestruct.codeentered )
        {
            /#
                printtoscreen2d( 500, 430 + teamindex * teamspacing, team + "<dev string:x1a0>", ( 1, 1, 1 ), 1 );
            #/
            
            if ( !arraycontains( codestruct.successfulteams, team ) )
            {
                foreach ( i, number in codestruct.codeentered[ team ] )
                {
                    /#
                        printtoscreen2d( 700 + numberspacing * i, 430 + teamindex * teamspacing, codestruct.codeentered[ team ][ i ], ( 1, 1, 1 ), 1 );
                    #/
                }
            }
            else
            {
                /#
                    printtoscreen2d( 700, 430 + teamindex * teamspacing, "<dev string:x1cb>", ( 1, 1, 1 ), 1 );
                #/
            }
            
            teamindex++;
        }
        
        waitframe();
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0x23ea9f9, Offset: 0x416e
// Size: 0x59a
function initlocs_bunkertest()
{
    wait 5;
    level.bunker_numberstation.hints[ "phones_code" ] = [];
    level.bunker_numberstation.hints[ "phones_code" ][ 0 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 0 ].origin = ( 2673, -2032, 322 );
    level.bunker_numberstation.hints[ "phones_code" ][ 1 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_code" ][ 1 ].origin = ( 1551, -2032, 322 );
    
    foreach ( hint in level.bunker_numberstation.hints[ "phones_code" ] )
    {
        hint.scriptable = spawnscriptable( "maphint_phone_code", hint.origin );
        hint.scriptable.ringing = 0;
    }
    
    level.bunker_numberstation.hints[ "phones_morse" ] = [];
    level.bunker_numberstation.hints[ "phones_morse" ][ 0 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 0 ].origin = ( 2740, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 1 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 1 ].origin = ( 2620, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 2 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 2 ].origin = ( 2500, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 3 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 3 ].origin = ( 2360, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 4 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 4 ].origin = ( 2244, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 5 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 5 ].origin = ( 2115, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 6 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 6 ].origin = ( 1980, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 7 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 7 ].origin = ( 1850, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 8 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 8 ].origin = ( 1724, -2239, 300 );
    level.bunker_numberstation.hints[ "phones_morse" ][ 9 ] = spawnstruct();
    level.bunker_numberstation.hints[ "phones_morse" ][ 9 ].origin = ( 1600, -2239, 300 );
    
    foreach ( index, hint in level.bunker_numberstation.hints[ "phones_morse" ] )
    {
        hint.scriptable = spawnscriptable( "maphint_phone_morse_" + index, hint.origin );
        hint.scriptable.ringing = 0;
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xe160f52f, Offset: 0x4710
// Size: 0x146
function debug_hintadjustmentthink()
{
    while ( true )
    {
        foreach ( hint in level.bunker_numberstation.hints[ "phones_code" ] )
        {
            hint.scriptable freescriptable();
        }
        
        foreach ( hint in level.bunker_numberstation.hints[ "phones_morse" ] )
        {
            hint.scriptable freescriptable();
        }
        
        if ( level.mapname == "mp_bm_bunker01" )
        {
            initlocs_bunkertest();
        }
        else
        {
            initlocs_donetsk();
        }
        
        wait 1;
    }
}

// Namespace br_bunker_numberstation
// Params 0
// Checksum 0xa654b649, Offset: 0x485e
// Size: 0x21f
function debug_bunkerpuzzledebugdraw()
{
    level endon( #"hash_e870ffd9f2a3034b" );
    
    while ( true )
    {
        foreach ( hint in level.bunker_numberstation.hints[ "phones_code" ] )
        {
            thread debug::drawsphere( hint.scriptable.origin, 256, 1, ( 0, 1, 0 ) );
        }
        
        foreach ( hint in level.bunker_numberstation.hints[ "phones_morse" ] )
        {
            thread debug::drawsphere( hint.scriptable.origin, 256, 1, ( 1, 0, 0 ) );
        }
        
        if ( isdefined( level.bunker_numberstation.chosencodephones ) )
        {
            foreach ( hint in level.bunker_numberstation.chosencodephones )
            {
                thread debug::drawsphere( hint.scriptable.origin, 128, 1, ( 0, 0, 1 ) );
            }
        }
        
        wait 1;
    }
}

// Namespace br_bunker_numberstation
// Params 2
// Checksum 0x8d4c3578, Offset: 0x4a85
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
            printtoscreen2d( 500, 350, "<dev string:x1e0>" + text, ( 1, 1, 1 ), 1.5 );
        #/
        
        waitframe();
        curtime += 0.05;
    }
}

/#

    // Namespace br_bunker_numberstation
    // Params 0
    // Checksum 0xe637bda2, Offset: 0x4af2
    // Size: 0x8c, Type: dev
    function function_3f20b8b021dae877()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_664ec58759f1617", 0 ) == 1 )
            {
                level thread debug_bunkerpuzzledebugdraw();
            }
            else
            {
                level notify( #"hash_e870ffd9f2a3034b" );
            }
            
            if ( getdvarint( @"hash_4e1e0a899a9ac76c", 0 ) == 1 )
            {
                level thread printcodechosen( level.bunker_numberstation );
                level thread printcodeentered( level.bunker_numberstation );
            }
            else
            {
                level notify( #"hash_1c55759819d815ab" );
                level notify( #"hash_6cc5299f5221efb7" );
            }
            
            wait 1;
        }
    }

#/
