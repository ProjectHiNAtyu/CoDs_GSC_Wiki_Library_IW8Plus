// script_7fbbbca181a9e900  (hash_7fbbbca181a9e900.gscc) (size: 3143 Bytes / 0xc47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9cf820b (164594187)
// size ...... 3143 (0xc47)
// includes .. 12  (offset: 0xb87)
// strings ... 8   (offset: 0xbe7)
// dev strs .. 0   (offset: 0xc47)
// exports ... 7   (offset: 0x513)
// cseg ...... 0xed + 0x426 (0x513)
// imports ... 48  (offset: 0x62b)
// animtree1 . 0   (offset: 0xc47)
// animtree2 . 0   (offset: 0xc47)
#using script_2456bc7aab0c01ca;
#using script_25c4ed88766feb47;
#using script_32a1e7eed6b19549;
#using script_35efc59124dbb5db;
#using script_5c5e5032f1170bc6;
#using script_5d7ec2b299be2712;
#using script_6dba81423ee30b72;
#using script_75ca45517b8d4e33;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_eb102c43c4541779;

// Namespace namespace_eb102c43c4541779
// Params 0, eflags: 0x5
// Checksum 0x90f886cf, Offset: 0x10b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mantis_ww_quest", undefined, undefined, &init );
}

// Namespace namespace_eb102c43c4541779
// Params 0
// Checksum 0xfc2e8592, Offset: 0x12c
// Size: 0xc6
function init()
{
    if ( level.mapname != "zm_sat_mantis" || getdvarint( @"hash_bb4d4e9d5661c0f9", 1 ) == 0 )
    {
        return;
    }
    
    if ( !getmatchrulesdata( "zmData", "wwQuest" ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    register_quest_steps();
    level utility::flag_wait_all( "scriptables_ready", "destructibles_ready", "common_items_init" );
    level utility::registersharedfunc( #"zm_quest", #"hash_85468165ad5b3400", &is_quest_complete );
    level.mantis_ww_quest = zm_quest::get_quest( #"mantis_ww_quest" );
    init_quest_steps();
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"mantis_ww_quest" );
    thread function_4e7e6dd52c2e7070();
}

// Namespace namespace_eb102c43c4541779
// Params 0
// Checksum 0x702bccc4, Offset: 0x1fa
// Size: 0x11
function is_quest_complete()
{
    return zm_quest::is_quest_complete( #"mantis_ww_quest" );
}

// Namespace namespace_eb102c43c4541779
// Params 0, eflags: 0x4
// Checksum 0x516b4072, Offset: 0x214
// Size: 0x33
function private init_quest_steps()
{
    retrieve_the_barrel::init();
    namespace_2a9676437b2f197b::init();
    namespace_ff6878b512b89ab2::init();
    namespace_b57d3f6e99f615fe::init();
    namespace_289f383f7afd552c::init();
    namespace_50685f569b0b612f::init();
    build_the_weapon::init();
}

// Namespace namespace_eb102c43c4541779
// Params 0, eflags: 0x4
// Checksum 0x344c006c, Offset: 0x24f
// Size: 0x107
function private register_quest_steps()
{
    zm_quest::function_3c363613c60958f5( #"mantis_ww_quest" );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_fb9fc3d20170d9ad", &retrieve_the_barrel::execute, &retrieve_the_barrel::cleanup );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_d1f2694a69086659", &namespace_2a9676437b2f197b::execute, &namespace_2a9676437b2f197b::cleanup );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_acf8828e1be3f348", &namespace_ff6878b512b89ab2::execute, &namespace_ff6878b512b89ab2::cleanup );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_6e4be9ca1c6f94c", &namespace_b57d3f6e99f615fe::execute, &namespace_b57d3f6e99f615fe::cleanup );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_711abfae8818f88a", &namespace_289f383f7afd552c::execute, &namespace_289f383f7afd552c::cleanup );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_8f874c86ba6e603d", &namespace_50685f569b0b612f::execute, &namespace_50685f569b0b612f::cleanup );
    zm_quest::register_quest_step( #"mantis_ww_quest", #"hash_606cf2ac9d492559", &build_the_weapon::execute, &build_the_weapon::cleanup );
}

// Namespace namespace_eb102c43c4541779
// Params 0, eflags: 0x4
// Checksum 0xb947f4be, Offset: 0x35e
// Size: 0x1b5
function private function_4e7e6dd52c2e7070()
{
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level endon( #"game_ended", #"start_boss_fight" );
    
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = {};
    }
    
    if ( !isdefined( level.directed_mode.var_f1879f50f4eeaca3 ) )
    {
        level.directed_mode.var_f1879f50f4eeaca3 = [];
    }
    
    gate_quest = zm_quest::get_quest( #"mantis_pap_quest" );
    gate_quest utility::ent_flag_wait( "zm_quest_completed" );
    guidance_steps = [ { #execute:&retrieve_the_barrel::function_bcdd8958faa3f63b, #step_ref:#"hash_fb9fc3d20170d9ad" }, { #execute:&namespace_2a9676437b2f197b::function_bcdd8958faa3f63b, #step_ref:#"hash_d1f2694a69086659" }, { #execute:&namespace_ff6878b512b89ab2::function_bcdd8958faa3f63b, #step_ref:#"hash_acf8828e1be3f348" }, { #execute:&namespace_b57d3f6e99f615fe::function_bcdd8958faa3f63b, #step_ref:#"hash_6e4be9ca1c6f94c" }, { #execute:&namespace_289f383f7afd552c::function_bcdd8958faa3f63b, #step_ref:#"hash_711abfae8818f88a" }, { #execute:&namespace_50685f569b0b612f::function_bcdd8958faa3f63b, #step_ref:#"hash_8f874c86ba6e603d" }, { #execute:&build_the_weapon::function_bcdd8958faa3f63b, #step_ref:#"hash_606cf2ac9d492559" } ];
    namespace_a7211835085600d5::function_670daf9bf33064ab( #"mantis_ww_quest", #"hash_4670d9548e1da722", guidance_steps );
}

