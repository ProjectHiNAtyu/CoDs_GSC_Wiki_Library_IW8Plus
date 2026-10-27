// scripts\mp\zm\systems\zm_ee_headphones.gsc  (hash_2b686c47509152db.gscc) (size: 3197 Bytes / 0xc7d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a2cd0e (61000974)
// size ...... 3197 (0xc7d)
// includes .. 6   (offset: 0xbc1)
// strings ... 9   (offset: 0xbf1)
// dev strs .. 0   (offset: 0xc7d)
// exports ... 13  (offset: 0x6b9)
// cseg ...... 0xec + 0x5cd (0x6b9)
// imports ... 26  (offset: 0x8c1)
// animtree1 . 0   (offset: 0xc7d)
// animtree2 . 0   (offset: 0xc7d)
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_ee_headphones;

// Namespace zm_ee_headphones
// Params 0, eflags: 0x5
// Checksum 0x7d22208b, Offset: 0x10a
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ee_headphones", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_ee_headphones
// Params 0, eflags: 0x4
// Checksum 0xac36cd4d, Offset: 0x137
// Size: 0xdc
function private function_7cf8dacb278a2665()
{
    setdvarifuninitialized( @"enable_ee_headphones", 1 );
    
    if ( !getdvarint( @"enable_ee_headphones", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.ee_headphones_quest = zm_quest::get_quest( #"ee_headphones" );
    zm_quest::register_quest_step( #"ee_headphones", #"headphones", &function_6af005f349aa0bf7, &function_64ff58234fcf866d );
    zm_quest::register_quest_step( #"ee_headphones", #"use_1", &setup_step_1, &function_2da96849bb2e5994 );
    zm_quest::register_quest_step( #"ee_headphones", #"use_2", &setup_step_2, &function_2da96b49bb2e602d );
    zm_quest::register_quest_step( #"ee_headphones", #"use_3", &setup_step_3, &function_2da96a49bb2e5dfa );
}

// Namespace zm_ee_headphones
// Params 0, eflags: 0x4
// Checksum 0x7ae715f8, Offset: 0x21b
// Size: 0x81
function private postmain_init()
{
    if ( !getdvarint( @"enable_ee_headphones", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level utility::flag_wait( "scriptables_ready" );
    a_headphones = getentitylessscriptablearray( "ee_headphones", #targetname );
    
    if ( a_headphones.size < 3 )
    {
        return;
    }
    
    level utility::flag_wait( "begin_round_logic" );
    zm_save::function_1f44a48caae2acbf();
    thread zm_quest::start_quest( #"ee_headphones" );
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0x56fa2ac, Offset: 0x2a4
// Size: 0x152
function private function_6af005f349aa0bf7( b_skipped, b_save_restored )
{
    a_headphones = getentitylessscriptablearray( "ee_headphones", #targetname );
    
    foreach ( headphone in a_headphones )
    {
        headphone setscriptablepartstate( "body", "useable" );
        
        switch ( int( headphone.script_noteworthy ) )
        {
            case 1:
                level.ee_headphones_quest.headphone_1 = headphone;
                break;
            case 2:
                level.ee_headphones_quest.headphone_2 = headphone;
                break;
            case 3:
                level.ee_headphones_quest.headphone_3 = headphone;
                break;
        }
    }
    
    level.ee_headphones_quest.activation_counter = 0;
    scriptable::scriptable_addusedcallback( &headphones_used );
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0x553bd74c, Offset: 0x3fe
// Size: 0x38
function private function_64ff58234fcf866d( b_skipped, b_save_restored )
{
    if ( !b_save_restored )
    {
        wait 2;
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"headphone_song" );
    }
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0x73c74c74, Offset: 0x43e
// Size: 0x3a
function private setup_step_1( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level.ee_headphones_quest.headphone_1 waittill( #"headphones_used" );
    }
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0xdbe8f671, Offset: 0x480
// Size: 0x5f
function private function_2da96849bb2e5994( b_skipped, b_save_restored )
{
    level.ee_headphones_quest.activation_counter++;
    level.ee_headphones_quest.headphone_1 setscriptablepartstate( "body", "activated_" + level.ee_headphones_quest.activation_counter );
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0x73c74c74, Offset: 0x4e7
// Size: 0x3a
function private setup_step_2( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level.ee_headphones_quest.headphone_2 waittill( #"headphones_used" );
    }
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0xdbe8f671, Offset: 0x529
// Size: 0x5f
function private function_2da96b49bb2e602d( b_skipped, b_save_restored )
{
    level.ee_headphones_quest.activation_counter++;
    level.ee_headphones_quest.headphone_2 setscriptablepartstate( "body", "activated_" + level.ee_headphones_quest.activation_counter );
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0x73c74c74, Offset: 0x590
// Size: 0x3a
function private setup_step_3( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level.ee_headphones_quest.headphone_3 waittill( #"headphones_used" );
    }
}

// Namespace zm_ee_headphones
// Params 2, eflags: 0x4
// Checksum 0xdbe8f671, Offset: 0x5d2
// Size: 0x5f
function private function_2da96a49bb2e5dfa( b_skipped, b_save_restored )
{
    level.ee_headphones_quest.activation_counter++;
    level.ee_headphones_quest.headphone_3 setscriptablepartstate( "body", "activated_" + level.ee_headphones_quest.activation_counter );
}

// Namespace zm_ee_headphones
// Params 6, eflags: 0x4
// Checksum 0x23335fd2, Offset: 0x639
// Size: 0x80
function private headphones_used( scriptable, part, state, player, bautouse, usestring )
{
    if ( !isdefined( scriptable ) || scriptable.type != "zm_t10_ee_headphones" || scriptable.b_used )
    {
        return;
    }
    
    scriptable.b_used = 1;
    scriptable notify( #"headphones_used" );
}

