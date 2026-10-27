// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_echo.gsc  (hash_5aed18102c53ae9d.gscc) (size: 5566 Bytes / 0x15be / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8195d866 (2174081126)
// size ...... 5566 (0x15be)
// includes .. 5   (offset: 0x11f2)
// strings ... 69  (offset: 0x121a)
// dev strs .. 0   (offset: 0x15be)
// exports ... 10  (offset: 0xd6e)
// cseg ...... 0x5e5 + 0x789 (0xd6e)
// imports ... 25  (offset: 0xefe)
// animtree1 . 0   (offset: 0x15be)
// animtree2 . 0   (offset: 0x15be)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ltm_echo_cs;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_mq;

#namespace zm_sat_ruby_echo;

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x5
// Checksum 0x629b21cf, Offset: 0x603
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_57d064258c711271", undefined, &pre_main, &post_main );
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0xff3516bc, Offset: 0x628
// Size: 0x13e
function private pre_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    level.var_2add2332a4635bbb = { #var_82ea5be5455d5401:[ "zombie_ghoul_hvt", "zombie_amalgam", "zombie_viper", "zombie_callisto_hvt", "zombie_abom" ], #var_1ea74a4676fa9871:%"hash_3d45f1248a3c50b9", #var_d23b400600effd18:1, #var_f2ca359ba559c822:1, #var_fa13ef47a8925257:0, #var_8eac6e744e8c5bf1:function_1453b50f4841a1d8(), #var_ecaa27f35aef5b3c:%"hash_25ce401fe191e56a", #var_4aa676077979d1dd:"boss", #var_8074703df595efae:"start", #var_faa951df3f188328:[ "start2", "cliffside2" ], #var_bcf87c357a7634ec:[ "start", "cliffside", "courtyard", "orrery", "mars", "telescope", "mainhall", "planetarium" ], #create_script_func:&zm_sat_ruby_ltm_echo_cs::main };
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0x9c92b871, Offset: 0x76e
// Size: 0x1af
function private function_1453b50f4841a1d8()
{
    var_e1d246124da6bf1d = [];
    var_e1d246124da6bf1d[ "start" ] = [ "zone_landing", "zone_landing_upper" ];
    var_e1d246124da6bf1d[ "start2" ] = [ "zone_landing", "zone_landing_upper" ];
    var_e1d246124da6bf1d[ "cliffside" ] = [ "zone_cliffside_close_to_planetarium", "zone_cliffside", "zone_cliffside_close_to_telescope" ];
    var_e1d246124da6bf1d[ "cliffside2" ] = [ "zone_cliffside_close_to_planetarium", "zone_cliffside", "zone_cliffside_close_to_telescope" ];
    var_e1d246124da6bf1d[ "courtyard" ] = [ "zone_courtyard_upper", "zone_courtyard_2", "zone_courtyard", "zone_courtyard_lower", "zone_courtyard_close_to_orrery" ];
    var_e1d246124da6bf1d[ "orrery" ] = [ "zone_orrery_lower", "zone_orrery", "zone_orrery_upper_floor", "zone_orrery_close_to_mainhall" ];
    var_e1d246124da6bf1d[ "mars" ] = [ "zone_temple", "zone_temple_center", "zone_temple_displays", "zone_temple_left", "zone_temple_right", "zone_temple_tech" ];
    var_e1d246124da6bf1d[ "telescope" ] = [ "zone_telescope", "zone_telescope_close_to_pathway", "zone_telescope_pathway_upper", "zone_telescope_pathway_lower" ];
    var_e1d246124da6bf1d[ "mainhall" ] = [ "zone_mainhall", "zone_mainhall_left" ];
    var_e1d246124da6bf1d[ "planetarium" ] = [ "zone_planetarium_hallway_01", "zone_planetarium_hallway_02", "zone_planetarium_hallway_03", "zone_planetarium", "zone_planetarium_outside" ];
    return var_e1d246124da6bf1d;
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0x3604b9b7, Offset: 0x926
// Size: 0x3a
function private post_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    level thread function_37a4ad6da36482d4();
    level thread function_e2671a4d4ebbbd3e();
    level thread function_c36a32de05ca1a18();
    level thread function_d36c3134a54ef717();
    level thread function_c0622fb32fd23ced();
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0x98dde60e, Offset: 0x968
// Size: 0x22d
function private function_c36a32de05ca1a18()
{
    level utility::flag_wait( "laser_trap_switch_trap_init_finished" );
    
    if ( !isdefined( level.var_f301c0b95ea728e2 ) )
    {
        return;
    }
    
    foreach ( s_trap_root in level.var_f301c0b95ea728e2 )
    {
        if ( s_trap_root.targetname != "laser_trap_switch" )
        {
            continue;
        }
        
        s_trap_root.power_on_flag = undefined;
        
        if ( isdefined( s_trap_root.a_switch_pos ) )
        {
            foreach ( switch_pos in s_trap_root.a_switch_pos )
            {
                if ( isdefined( switch_pos.interact ) )
                {
                    switch_pos.interact.state = "buyable";
                }
                
                if ( isdefined( switch_pos.switch_scriptable ) )
                {
                    switch_pos.switch_scriptable setscriptablepartstate( "base", "ready" );
                }
            }
        }
        
        if ( isdefined( s_trap_root.trap_positions ) )
        {
            foreach ( trap_pos in s_trap_root.trap_positions )
            {
                if ( isdefined( trap_pos.trap_scriptable ) )
                {
                    trap_pos.trap_scriptable setscriptablepartstate( "base", "ready" );
                }
            }
        }
        
        break;
    }
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0x9f576f66, Offset: 0xb9d
// Size: 0x65
function private function_37a4ad6da36482d4()
{
    level utility::flag_wait( "begin_round_logic" );
    doors = getentitylessscriptablearray( "doorbuy_door_landing_to_planetarium", #targetname );
    doors[ 0 ] setscriptablepartstate( "icon", "hide" );
    doors = getentitylessscriptablearray( "doorbuy_door_planetarium_to_cliff", #targetname );
    doors[ 0 ] setscriptablepartstate( "icon", "hide" );
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0xf0605d02, Offset: 0xc0a
// Size: 0x52
function private function_e2671a4d4ebbbd3e()
{
    level utility::flag_wait( "begin_round_logic" );
    level.var_eafbf349af925860 = getent( "step3_orrey_clip", "script_noteworthy" );
    level.var_eafbf349af925860 notsolid();
    level.var_eafbf349af925860 connectpaths();
    level thread zm_sat_ruby_quest_mq::init_defend_event_doors();
    level zm_sat_ruby_quest_mq::spawn_portal();
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0x718585e1, Offset: 0xc64
// Size: 0x3f
function private function_d36c3134a54ef717()
{
    level utility::flag_wait( "begin_round_logic" );
    pap = getent( "pack_a_punch_machine", "script_noteworthy" );
    
    if ( pap )
    {
        pap.interact setusableenabled( 0 );
    }
}

// Namespace zm_sat_ruby_echo
// Params 0, eflags: 0x4
// Checksum 0x1cbc03c0, Offset: 0xcab
// Size: 0xc3
function private function_c0622fb32fd23ced()
{
    level utility::flag_wait( "begin_round_logic" );
    var_e6463a9524897ae4 = utility::getstruct( "step3_portal_computer", "targetname" );
    computer = spawnscriptable( %"sat_zm_ruby_mq_portal_machine", var_e6463a9524897ae4.origin, var_e6463a9524897ae4.angles );
    computer utility::function_7c10ea82c1e305b8( "model", "on" );
    computer utility::function_7c10ea82c1e305b8( "machine_states", "off" );
    var_4455616196599590 = utility::getstruct( "step3_perfusion_connect_off", "targetname" );
    wire = utility::spawn_model( "sat_zm_perfusion_machine_wire_01_unconnect", var_4455616196599590.origin, var_4455616196599590.angles );
}

