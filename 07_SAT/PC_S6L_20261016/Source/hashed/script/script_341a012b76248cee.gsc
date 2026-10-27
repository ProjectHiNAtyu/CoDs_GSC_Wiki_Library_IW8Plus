// script_341a012b76248cee  (hash_341a012b76248cee.gscc) (size: 2247 Bytes / 0x8c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a505f5 (77923829)
// size ...... 2247 (0x8c7)
// includes .. 9   (offset: 0x807)
// strings ... 8   (offset: 0x84f)
// dev strs .. 2   (offset: 0x8af)
// exports ... 7   (offset: 0x347)
// cseg ...... 0xef + 0x258 (0x347)
// imports ... 33  (offset: 0x45f)
// animtree1 . 0   (offset: 0x8c7)
// animtree2 . 0   (offset: 0x8c7)
#using script_25632053f2663648;
#using script_33b5501b1af0e7d9;
#using script_5c9c11d1cc293dbf;
#using script_6592742921d4bd1c;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace pap_quest;

// Namespace pap_quest
// Params 0, eflags: 0x5
// Checksum 0x77f9fc2f, Offset: 0x10d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mantis_pap_quest", undefined, undefined, &init );
}

// Namespace pap_quest
// Params 0
// Checksum 0x73f5d359, Offset: 0x12e
// Size: 0x101
function init()
{
    if ( level.mapname != "zm_sat_mantis" )
    {
        return;
    }
    
    if ( !getmatchrulesdata( "zmData", "papQuest" ) )
    {
        if ( utility::issharedfuncdefined( #"mantis_pap_quest", #"hash_c87b411e7826157c" ) )
        {
            level thread utility::callsharedfunc( #"mantis_pap_quest", #"hash_c87b411e7826157c" );
        }
        
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    register_quest_steps();
    level utility::flag_wait_all( "scriptables_ready", "destructibles_ready", "common_items_init" );
    level utility::registersharedfunc( #"zm_quest", #"hash_9b839bc2ba7777ff", &is_quest_complete );
    level.mantis_pap_quest = zm_quest::get_quest( #"mantis_pap_quest" );
    level val::set( #"mantis_pap_quest", "task_logic_activate", 0 );
    init_quest_steps();
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"mantis_pap_quest" );
    
    /#
        level thread open_sesame_monitor();
    #/
}

// Namespace pap_quest
// Params 0
// Checksum 0x9bd1b814, Offset: 0x237
// Size: 0x11
function is_quest_complete()
{
    return zm_quest::is_quest_complete( #"mantis_pap_quest" );
}

// Namespace pap_quest
// Params 0, eflags: 0x4
// Checksum 0x7926b99, Offset: 0x251
// Size: 0x1e
function private init_quest_steps()
{
    namespace_c358c502db1450a7::init();
    namespace_4ce8ccb0ce5a23f6::init();
    namespace_575f4843912c9847::init();
    free_the_machine::init();
}

// Namespace pap_quest
// Params 0, eflags: 0x4
// Checksum 0x17fd84e3, Offset: 0x277
// Size: 0x9e
function private register_quest_steps()
{
    zm_quest::function_3c363613c60958f5( #"mantis_pap_quest" );
    zm_quest::register_quest_step( #"mantis_pap_quest", #"hash_5db21f5065eba2db", &namespace_c358c502db1450a7::execute, &namespace_c358c502db1450a7::cleanup );
    zm_quest::register_quest_step( #"mantis_pap_quest", #"hash_b360f453042e4d5e", &namespace_4ce8ccb0ce5a23f6::execute, &namespace_4ce8ccb0ce5a23f6::cleanup );
    zm_quest::register_quest_step( #"mantis_pap_quest", #"hash_28d63457c71bcedb", &namespace_575f4843912c9847::execute, &namespace_575f4843912c9847::cleanup );
    zm_quest::register_quest_step( #"mantis_pap_quest", #"hash_5dc84c538a9da0b6", &free_the_machine::execute, &free_the_machine::cleanup );
}

/#

    // Namespace pap_quest
    // Params 0, eflags: 0x4
    // Checksum 0x9fe9c943, Offset: 0x31d
    // Size: 0x2a, Type: dev
    function private open_sesame_monitor()
    {
        level endon( #"game_ended" );
        level utility::flag_wait( "<dev string:x24>" );
        utility::flag_set( "<dev string:x30>" );
    }

#/
