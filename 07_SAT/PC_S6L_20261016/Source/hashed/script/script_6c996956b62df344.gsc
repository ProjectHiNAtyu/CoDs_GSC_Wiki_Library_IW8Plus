// script_6c996956b62df344  (hash_6c996956b62df344.gscc) (size: 3005 Bytes / 0xbbd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x553b70c7 (1429958855)
// size ...... 3005 (0xbbd)
// includes .. 9   (offset: 0xa99)
// strings ... 18  (offset: 0xae1)
// dev strs .. 0   (offset: 0xbbd)
// exports ... 9   (offset: 0x5a1)
// cseg ...... 0x205 + 0x39c (0x5a1)
// imports ... 32  (offset: 0x709)
// animtree1 . 0   (offset: 0xbbd)
// animtree2 . 0   (offset: 0xbbd)
#using script_33b5501b1af0e7d9;
#using script_6592742921d4bd1c;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\magicbox;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_30ad94408026a422;

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x5
// Checksum 0x438199ce, Offset: 0x223
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_9672be64eea1edf5", undefined, &pre_main_init, &post_main_init );
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x2a113193, Offset: 0x248
// Size: 0x46
function private pre_main_init()
{
    if ( !function_2ddb9cefb5ce928c() )
    {
        return;
    }
    
    function_a72e9a65e0b0ef94();
    setdvarifuninitialized( @"hash_662dda9fa4eae3ed", "variant_survival_future" );
    level utility::registersharedfunc( #"mantis_pap_quest", #"hash_c87b411e7826157c", &function_13246bda60adc7eb );
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x915417a3, Offset: 0x296
// Size: 0x36
function private post_main_init()
{
    if ( !function_2ddb9cefb5ce928c() )
    {
        return;
    }
    
    setup_burnt_mannequins();
    wait 1;
    level.vending_machines_powered_on_at_start = 1;
    utility::flag_set( "power_on" );
    level thread function_d659fd183b077b34();
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x384e6ac2, Offset: 0x2d4
// Size: 0x43, Type: bool
function private function_2ddb9cefb5ce928c()
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return false;
    }
    
    if ( level.mapname != "zm_sat_mantis" )
    {
        return false;
    }
    
    poiname = zm_rb_survival::function_64c3a9143299dacb();
    
    if ( poiname != "future" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x28ee18b5, Offset: 0x320
// Size: 0xee
function private function_13246bda60adc7eb()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait_all( "scriptables_ready", "destructibles_ready", "common_items_init" );
    level zm_save::function_1f44a48caae2acbf();
    level.mantis_pap_quest = zm_quest::get_quest( #"mantis_pap_quest" );
    namespace_575f4843912c9847::init();
    future_truck = level.mantis_pap_quest.var_1e5d973acb8a3591.future_truck;
    
    if ( isdefined( future_truck ) )
    {
        future_truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move", future_truck.origin, future_truck.angles );
        level utility::flag_set( "future_truck_moved" );
    }
    
    future_truck_collision = getent( "pap_quest_step_2_collision_truck_future", #script_noteworthy );
    
    if ( isdefined( future_truck_collision ) )
    {
        future_truck_collision connectpaths();
    }
    
    free_the_machine::function_979b1db26b3ca8f5();
    free_the_machine::show_pap_machine_collision();
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x55527180, Offset: 0x416
// Size: 0xb3
function private function_a72e9a65e0b0ef94()
{
    level.timetravel_disabled = 1;
    level.var_9317e385dbcadec8 = 1;
    time_conduit = getentarray( "ttm_clip", "script_noteworthy" );
    
    if ( time_conduit )
    {
        foreach ( ent in time_conduit )
        {
            ent connectpaths();
            ent notsolid();
            ent hide();
        }
    }
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x813f32e6, Offset: 0x4d1
// Size: 0xa5
function private setup_burnt_mannequins()
{
    level utility::flag_wait( "scriptables_ready" );
    future_mannequins = getentitylessscriptablearray( "ww_quest_step_3_spawn_node_mannequin_future", #script_noteworthy );
    
    foreach ( mannequin in future_mannequins )
    {
        mannequin setscriptablepartstate( "model", "burned" );
    }
}

// Namespace namespace_30ad94408026a422
// Params 0, eflags: 0x4
// Checksum 0x45268665, Offset: 0x57e
// Size: 0x23
function private function_d659fd183b077b34()
{
    utility::flag_wait( "magicbox_ready" );
    level.var_8b6bf63f61fe01f9 = "zm_sat_mantis_items_magicbox_weapon_wonder_list_survival";
    magicbox::function_b787d845dbbfa18e();
}

