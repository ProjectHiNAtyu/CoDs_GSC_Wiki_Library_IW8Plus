// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ltm_startroom.gsc  (hash_6adcf39e08e45fe9.gscc) (size: 4731 Bytes / 0x127b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73844329 (1938047785)
// size ...... 4731 (0x127b)
// includes .. 8   (offset: 0x10cb)
// strings ... 23  (offset: 0x110b)
// dev strs .. 5   (offset: 0x123f)
// exports ... 16  (offset: 0x99b)
// cseg ...... 0x32f + 0x66c (0x99b)
// imports ... 39  (offset: 0xc1b)
// animtree1 . 0   (offset: 0x127b)
// animtree2 . 0   (offset: 0x127b)
#using script_1fd3c1c0eb847e19;
#using script_6f3813f0ad1fc030;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\compass;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_mantis_ltm_startroom;

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x5
// Checksum 0x917eca98, Offset: 0x34d
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_rb_startroom_sat_mantis", #"zm_rb_startroom_sat", &pre_main, &post_main );
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xcfdd6a9c, Offset: 0x37a
// Size: 0x21
function private pre_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    function_19eea64bfb0db8cf();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xc3ed5783, Offset: 0x3a3
// Size: 0x22
function private post_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x45>" );
    #/
    
    level thread function_14c0b60fa27632f3();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0
// Checksum 0x91053809, Offset: 0x3cd
// Size: 0x3e
function function_19eea64bfb0db8cf()
{
    level.var_9317e385dbcadec8 = 1;
    level.var_14327a33af94412c = 1;
    utility::registersharedfunc( #"zombie", #"hash_ba1f273364ecd5ca", &function_aebfa889060b0a35 );
    level thread function_3105035ba12fa22e();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0
// Checksum 0xa58740a9, Offset: 0x413
// Size: 0x40
function function_14c0b60fa27632f3()
{
    function_a5557ecd2892850f();
    function_79307f687e440a88();
    level thread function_7053fef8c1a98161();
    level thread delete_ww_crafting_table();
    level thread function_cdb0a13fc33f45ca();
    level thread function_fcf1ab269b2f12e6();
    level thread delete_ttm_clip();
    level thread setup_mannequins();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x9662a7f7, Offset: 0x45b
// Size: 0xe7
function private function_3105035ba12fa22e()
{
    minimap_floor_triggers = getentarray( "trigger_multiple_set_minimap_floor", #classname );
    
    foreach ( trigger in minimap_floor_triggers )
    {
        if ( trigger.target == "minimap_past" )
        {
            trigger thread compass::function_8c888382369ffced( 5 );
            continue;
        }
        
        if ( trigger.target == "minimap_future" )
        {
            trigger thread compass::function_8c888382369ffced( 4 );
            continue;
        }
        
        assertmsg( "<dev string:x67>" + trigger.target );
    }
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xc28b44f6, Offset: 0x54a
// Size: 0x58
function private function_a5557ecd2892850f()
{
    truck = utility::getent_or_struct( "pap_quest_step_2_spawn_node_truck_past", "script_noteworthy" );
    
    if ( !isdefined( truck ) )
    {
        assertmsg( "<dev string:xa6>" );
        return;
    }
    
    truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move_start", truck.origin, truck.angles );
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x6935b348, Offset: 0x5aa
// Size: 0x58
function private function_79307f687e440a88()
{
    truck = utility::getent_or_struct( "pap_quest_step_2_spawn_node_truck_future", "script_noteworthy" );
    
    if ( !isdefined( truck ) )
    {
        assertmsg( "<dev string:xed>" );
        return;
    }
    
    truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move_start", truck.origin, truck.angles );
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x14688282, Offset: 0x60a
// Size: 0xd0
function private function_7053fef8c1a98161()
{
    utility::flag_wait( "scriptables_ready" );
    wall_01 = destructible::get_instances( "clean::sat_destructible_wall_mantis_01" )[ 0 ];
    wall_02 = destructible::get_instances( "clean::sat_destructible_wall_mantis_02" )[ 0 ];
    wall_03 = destructible::get_instances( "clean::sat_destructible_wall_mantis_03" )[ 0 ];
    wall_04 = destructible::get_instances( "sat_destructible_wall_mantis_01_hardened" )[ 0 ];
    wall_05 = destructible::get_instances( "sat_destructible_wall_mantis_02_hardened" )[ 0 ];
    wall_06 = destructible::get_instances( "sat_destructible_wall_mantis_03_hardened" )[ 0 ];
    wall_01 destructible::hide();
    wall_02 destructible::hide();
    wall_03 destructible::hide();
    wall_04 destructible::hide();
    wall_05 destructible::hide();
    wall_06 destructible::hide();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xc6647419, Offset: 0x6e2
// Size: 0x34
function private delete_ww_crafting_table()
{
    utility::flag_wait( "scriptables_ready" );
    getent( "ww_quest_crafting_table_future", "script_noteworthy" ) delete();
    getent( "ww_quest_crafting_table_past", "script_noteworthy" ) delete();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 1, eflags: 0x4
// Checksum 0x6d6f87a0, Offset: 0x71e
// Size: 0xad
function private function_aebfa889060b0a35( var_1bbb5557537e2c0c )
{
    foreach ( var_349a0723ed9ac19c in var_1bbb5557537e2c0c )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", var_349a0723ed9ac19c.origin ) && var_349a0723ed9ac19c.script_start )
        {
            return var_349a0723ed9ac19c;
        }
    }
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xd1e7b22, Offset: 0x7d3
// Size: 0x1a
function private function_cdb0a13fc33f45ca()
{
    level waittill( #"hash_3c00bc13d8b0818d" );
    wait 1;
    level zm_sat_mantis_time_travel::function_78b6017858b1a275();
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xff33ad2a, Offset: 0x7f5
// Size: 0xcd
function private function_fcf1ab269b2f12e6()
{
    utility::flag_wait( "destructibles_ready" );
    cysts = destructible::function_c28a5f35d1a84d43( "sat_destructible_souleater_cyst_01" );
    destructible::waittill_ready( "sat_destructible_souleater_cyst_01" );
    wait 1;
    
    foreach ( cyst in cysts )
    {
        if ( !zone_manager::function_65305a611c6226d9( cyst.origin ) )
        {
            cyst destructible::hide();
            cyst destructible::remove_action( "destructible_destroyed", zm_sat_mantis_destructibles::function_c44fb2c07b6fd897() );
        }
    }
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x3e7293ea, Offset: 0x8ca
// Size: 0x25
function private delete_ttm_clip()
{
    ttm_clips = getentarray( "ttm_clip", "script_noteworthy" );
    utility::array_delete( ttm_clips );
}

// Namespace zm_sat_mantis_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0x5ec46a8e, Offset: 0x8f7
// Size: 0xa4
function private setup_mannequins()
{
    utility::flag_wait( "scriptables_ready" );
    future_mannequins = getentitylessscriptablearray( "ww_quest_step_3_spawn_node_mannequin_future", #script_noteworthy );
    
    foreach ( mannequin in future_mannequins )
    {
        mannequin setscriptablepartstate( "model", "burned" );
    }
}

