// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_echo.gsc  (hash_602540919c7f6f7d.gscc) (size: 8010 Bytes / 0x1f4a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e46851a (2655421722)
// size ...... 8010 (0x1f4a)
// includes .. 8   (offset: 0x1afe)
// strings ... 75  (offset: 0x1b3e)
// dev strs .. 0   (offset: 0x1f4a)
// exports ... 16  (offset: 0x13b6)
// cseg ...... 0x624 + 0xd92 (0x13b6)
// imports ... 38  (offset: 0x1636)
// animtree1 . 0   (offset: 0x1f4a)
// animtree2 . 0   (offset: 0x1f4a)
#using script_6f3813f0ad1fc030;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\perk_machines;
#using scripts\mp\zm\gametypes\zm_rb_echo;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ltm_echo_cs;

#namespace zm_sat_mantis_echo;

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x5
// Checksum 0x72fa58ab, Offset: 0x642
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_57d064258c711271", undefined, &pre_main, &post_main );
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0x743b6a48, Offset: 0x667
// Size: 0x132
function private pre_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    level.var_2add2332a4635bbb = { #var_82ea5be5455d5401:[ "zombie_ghoul_hvt", "zombie_mimic_hvt_emp", "zombie_karkinos_hvt", "zombie_orion_hvt" ], #var_b6f7856c65e288f9:&function_7de32a1b35a15766, #var_1ea74a4676fa9871:%"hash_3d45f1248a3c50b9", #var_d23b400600effd18:1, #var_f2ca359ba559c822:1, #var_fa13ef47a8925257:0, #var_8eac6e744e8c5bf1:function_1453b50f4841a1d8(), #var_ecaa27f35aef5b3c:%"hash_35fb7d95ec69b2", #var_4aa676077979d1dd:"boss", #var_8074703df595efae:"culdesac_f", #var_bcf87c357a7634ec:[ "culdesac_p", "culdesac_f", "backyard2_p", "backyard2_f", "backyard1_p", "backyard1_f", "street_p", "street_f" ], #create_script_func:&zm_sat_mantis_ltm_echo_cs::main };
    level.timetravel_disabled = 1;
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0x2ffab152, Offset: 0x7a1
// Size: 0x55
function private post_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    level thread delete_ww_crafting_table();
    level thread function_37a4ad6da36482d4();
    level thread setup_mannequins();
    level thread function_ee62a733b7a51adc();
    ttm_clips = getentarray( "ttm_clip", "script_noteworthy" );
    utility::array_delete( ttm_clips );
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0xb2c6ec29, Offset: 0x7fe
// Size: 0xe0
function private function_ee62a733b7a51adc()
{
    var_7877726dd10c7946 = utility::getstructarray( "echo_add_model", "targetname" );
    
    foreach ( struct in var_7877726dd10c7946 )
    {
        if ( !isdefined( struct.script_noteworthy ) )
        {
            continue;
        }
        
        model = spawn( "script_model", struct.origin );
        model.angles = struct.angles;
        model setmodel( struct.script_noteworthy );
        waitframe();
    }
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0xc365e0fb, Offset: 0x8e6
// Size: 0x18b
function private function_1453b50f4841a1d8()
{
    var_e1d246124da6bf1d = [];
    var_e1d246124da6bf1d[ "culdesac_p" ] = [ "zone_bus_top_p", "zone_culdesac_1_p", "zone_culdesac_2_p", "zone_culdesac_3_p", "zone_culdesac_4_p", "zone_truck_top_p" ];
    var_e1d246124da6bf1d[ "culdesac_f" ] = [ "zone_bus_top_f", "zone_culdesac_1_f", "zone_culdesac_2_f", "zone_culdesac_3_f", "zone_culdesac_4_f", "zone_truck_top_f" ];
    var_e1d246124da6bf1d[ "backyard2_p" ] = [ "zone_backyard2_a_p", "zone_backyard2_b_p" ];
    var_e1d246124da6bf1d[ "backyard2_f" ] = [ "zone_backyard2_a_f", "zone_backyard2_b_f" ];
    var_e1d246124da6bf1d[ "backyard1_p" ] = [ "zone_backyard1_a_p", "zone_backyard1_b_p" ];
    var_e1d246124da6bf1d[ "backyard1_f" ] = [ "zone_backyard1_a_f", "zone_backyard1_b_f" ];
    var_e1d246124da6bf1d[ "street_p" ] = [ "zone_street_1_p", "zone_street_2_p", "zone_street_3_p", "zone_street_4_p", "zone_street_5_p", "zone_street_6_p", "zone_street_7_p" ];
    var_e1d246124da6bf1d[ "street_f" ] = [ "zone_street_1_f", "zone_street_2_f", "zone_street_3_f", "zone_street_4_f", "zone_street_5_f", "zone_street_6_f", "zone_street_7_f" ];
    return var_e1d246124da6bf1d;
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0x6aa582af, Offset: 0xa7a
// Size: 0x479
function private function_37a4ad6da36482d4()
{
    level utility::flag_wait( "begin_round_logic" );
    doors = getentitylessscriptablearray( "doorbuy_backyard_1_f", #targetname );
    
    foreach ( door in doors )
    {
        door setscriptablepartstate( "icon", "hide" );
    }
    
    doors = getentitylessscriptablearray( "doorbuy_backyard_3_f", #targetname );
    
    foreach ( door in doors )
    {
        door setscriptablepartstate( "icon", "hide" );
    }
    
    doors = getentitylessscriptablearray( "doorbuy_backyard_1_p", #targetname );
    
    foreach ( door in doors )
    {
        door setscriptablepartstate( "icon", "hide" );
    }
    
    doors = getentitylessscriptablearray( "doorbuy_backyard_3_p", #targetname );
    
    foreach ( door in doors )
    {
        door setscriptablepartstate( "icon", "hide" );
    }
    
    doors = getentitylessscriptablearray( "doorbuy_garage_1_f", #targetname );
    
    foreach ( door in doors )
    {
        if ( door getscriptablehaspart( "icon" ) )
        {
            door setscriptablepartstate( "icon", "hide" );
        }
    }
    
    doors = getentitylessscriptablearray( "doorbuy_garage_1_p", #targetname );
    
    foreach ( door in doors )
    {
        if ( door getscriptablehaspart( "icon" ) )
        {
            door setscriptablepartstate( "icon", "hide" );
        }
    }
    
    doors = getentitylessscriptablearray( "doorbuy_house_2_f", #targetname );
    
    foreach ( door in doors )
    {
        if ( door getscriptablehaspart( "icon" ) )
        {
            door setscriptablepartstate( "icon", "hide" );
        }
    }
    
    doors = getentitylessscriptablearray( "doorbuy_house_2_p", #targetname );
    
    foreach ( door in doors )
    {
        if ( door getscriptablehaspart( "icon" ) )
        {
            door setscriptablepartstate( "icon", "hide" );
        }
    }
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0xe4305358, Offset: 0xefb
// Size: 0x37
function private function_7de32a1b35a15766()
{
    level utility::registersharedfunc( #"perk_machine", #"hash_5e022045e830ce8b", &function_a03da367ffefb522 );
    function_7422799a7ef1ef59();
    function_bccb74c47129fb3c();
    level thread function_cc63daddd08beee9();
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0x60179b5d, Offset: 0xf3a
// Size: 0x99
function private function_7422799a7ef1ef59()
{
    if ( !isdefined( level.a_s_perk_machines ) || !level.a_s_perk_machines.size )
    {
        return;
    }
    
    foreach ( s_perk_machine in level.a_s_perk_machines )
    {
        function_68b97789922f1110( s_perk_machine );
    }
}

// Namespace zm_sat_mantis_echo
// Params 1, eflags: 0x4
// Checksum 0xcce02f17, Offset: 0xfdb
// Size: 0x14
function private function_a03da367ffefb522( instance )
{
    function_68b97789922f1110( self );
}

// Namespace zm_sat_mantis_echo
// Params 1, eflags: 0x4
// Checksum 0x4ea5d37b, Offset: 0xff7
// Size: 0x66
function private function_68b97789922f1110( s_perk_machine )
{
    if ( !function_c3f69f2ae673b27c( s_perk_machine ) )
    {
        return;
    }
    
    if ( s_perk_machine.var_780e50ed7e4dd3e3 === s_perk_machine.mdl_perk_machine )
    {
        return;
    }
    
    perk_machines::function_d3eec0146d52a887( s_perk_machine );
    s_perk_machine.mdl_perk_machine thread zm_rb_echo::function_dae72b8886a70018();
    s_perk_machine.var_780e50ed7e4dd3e3 = s_perk_machine.mdl_perk_machine;
}

// Namespace zm_sat_mantis_echo
// Params 1, eflags: 0x4
// Checksum 0xf908f3a, Offset: 0x1065
// Size: 0x45, Type: bool
function private function_c3f69f2ae673b27c( s_perk_machine )
{
    if ( !isdefined( s_perk_machine.mdl_perk_machine ) )
    {
        return false;
    }
    
    if ( s_perk_machine.is_wunderfizz || s_perk_machine.content_key == "perk_machine_choice_spawn" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0xc5a58ea4, Offset: 0x10b3
// Size: 0x15b
function private function_bccb74c47129fb3c()
{
    if ( !isdefined( level.var_f301c0b95ea728e2 ) || !level.var_f301c0b95ea728e2.size )
    {
        return;
    }
    
    foreach ( s_trap_root in level.var_f301c0b95ea728e2 )
    {
        if ( !isdefined( s_trap_root.a_switch_pos ) )
        {
            continue;
        }
        
        foreach ( switch_pos in s_trap_root.a_switch_pos )
        {
            if ( !isdefined( switch_pos.switch_scriptable ) )
            {
                continue;
            }
            
            if ( !switch_pos.switch_scriptable getscriptablehaspart( "icon" ) )
            {
                continue;
            }
            
            switch_pos.switch_scriptable setscriptablepartstate( "icon", "idle" );
        }
    }
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0x22c12cfe, Offset: 0x1216
// Size: 0xb8
function private function_cc63daddd08beee9()
{
    utility::flag_wait( "destructibles_ready" );
    destructible::waittill_ready( "sat_destructible_souleater_cyst_01" );
    wait 1;
    cysts = destructible::function_c28a5f35d1a84d43( "sat_destructible_souleater_cyst_01" );
    
    foreach ( cyst in cysts )
    {
        cyst destructible::hide();
        cyst destructible::remove_action( "destructible_destroyed", zm_sat_mantis_destructibles::function_c44fb2c07b6fd897() );
    }
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0xce152007, Offset: 0x12d6
// Size: 0x34
function private delete_ww_crafting_table()
{
    utility::flag_wait( "scriptables_ready" );
    getent( "ww_quest_crafting_table_future", "script_noteworthy" ) delete();
    getent( "ww_quest_crafting_table_past", "script_noteworthy" ) delete();
}

// Namespace zm_sat_mantis_echo
// Params 0, eflags: 0x4
// Checksum 0x56b53e90, Offset: 0x1312
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

