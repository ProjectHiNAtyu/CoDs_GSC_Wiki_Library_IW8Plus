// script_5c9c11d1cc293dbf  (hash_5c9c11d1cc293dbf.gscc) (size: 3162 Bytes / 0xc5a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6b489b0 (3602155952)
// size ...... 3162 (0xc5a)
// includes .. 7   (offset: 0xb82)
// strings ... 12  (offset: 0xbba)
// dev strs .. 0   (offset: 0xc5a)
// exports ... 9   (offset: 0x742)
// cseg ...... 0x19c + 0x5a6 (0x742)
// imports ... 25  (offset: 0x8aa)
// animtree1 . 0   (offset: 0xc5a)
// animtree2 . 0   (offset: 0xc5a)
#using script_35efc59124dbb5db;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_c358c502db1450a7;

// Namespace namespace_c358c502db1450a7
// Params 0
// Checksum 0x7ab4b6e7, Offset: 0x1ba
// Size: 0x8e
function init()
{
    level callback::add( #"player_connect", &on_player_connect );
    data = { #doors_paths:[ [ "door_cul_to_back2_f" ], [ "door_cul_to_downstairs2_f" ], [ "door_cul_to_garage2_f" ] ], #truck_keys:spawn_keys() };
    level.mantis_pap_quest.var_1e5d943acb8a2ef8 = data;
    utility::flag_set( #"hash_db7ca544f5bb3e10" );
}

// Namespace namespace_c358c502db1450a7
// Params 1, eflags: 0x4
// Checksum 0x3984e853, Offset: 0x250
// Size: 0x4a
function private on_player_connect( params )
{
    if ( utility::flag( "papq_truck_keys_picked_up" ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"mantis_instruments", 0, #"sat_zm_quest_mantis_papq_truck_keys", 1, 1, self );
    }
    
    callback::add( "quest_item_used", &function_72d23666df81d131 );
}

// Namespace namespace_c358c502db1450a7
// Params 2
// Checksum 0x38eb0e40, Offset: 0x2a2
// Size: 0x4a
function execute( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( #"hash_db7ca544f5bb3e10" );
    level thread function_4915a58579af1aa9();
    utility::flag_wait_any( "papq_truck_keys_picked_up", "open_sesame" );
}

// Namespace namespace_c358c502db1450a7
// Params 2
// Checksum 0x5cb50d64, Offset: 0x2f4
// Size: 0xfd
function cleanup( skipped, save_restored )
{
    quest_data = level.mantis_pap_quest.var_1e5d943acb8a2ef8;
    
    foreach ( player in level.players )
    {
        zm_quest::function_b57dfe9625966b0b( #"mantis_instruments", 0, #"sat_zm_quest_mantis_papq_truck_keys", 1, 1, player );
    }
    
    if ( isdefined( quest_data.truck_keys ) )
    {
        quest_data.truck_keys freescriptable();
    }
    
    utility::flag_set( "papq_truck_keys_picked_up" );
    namespace_a7211835085600d5::clear_objective_marks( #"mantis_pap_quest" );
}

// Namespace namespace_c358c502db1450a7
// Params 1, eflags: 0x4
// Checksum 0x9df0bd74, Offset: 0x3f9
// Size: 0x59
function private spawn_keys( from_entity )
{
    var_30085f70fc117162 = utility::getstruct( "pap_quest_step_1_spawn_node_truck_keys", "script_noteworthy" );
    
    if ( !isdefined( var_30085f70fc117162 ) )
    {
        return;
    }
    
    return zm_quest::spawn_quest_item( var_30085f70fc117162.origin, var_30085f70fc117162.angles, getscriptbundle( %"hash_47cc02901afa720a" ) );
}

// Namespace namespace_c358c502db1450a7
// Params 1, eflags: 0x4
// Checksum 0x1acb0892, Offset: 0x45b
// Size: 0x113
function private function_72d23666df81d131( params )
{
    if ( params.scriptable != level.mantis_pap_quest.var_1e5d943acb8a2ef8.truck_keys )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_quest_pap_turck_key_pickup", player );
        zm_quest::show_splash_item_picked_up( #"mantis_instruments", #"sat_zm_quest_mantis_papq_truck_keys", 1, player );
    }
    
    utility::flag_set( "papq_truck_keys_picked_up" );
    
    while ( dialogue::is_anyone_speaking() )
    {
        wait 1;
    }
    
    params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_5db21f5065eba2db", #"hash_5212ed7ec42f115a" );
}

// Namespace namespace_c358c502db1450a7
// Params 0, eflags: 0x4
// Checksum 0x9991abf7, Offset: 0x576
// Size: 0x127
function private function_4915a58579af1aa9()
{
    truck_keys = level.mantis_pap_quest.var_1e5d943acb8a2ef8.truck_keys;
    
    if ( !level zm_sat_mantis::function_80daf2f20b4e6e6d() && isdefined( truck_keys ) )
    {
        namespace_a7211835085600d5::add_objective_mark( #"mantis_pap_quest", truck_keys.origin + ( 0, 20, 50 ), "papq_truck_keys", undefined, 1, { #timetravel_step:{ #future:#"hash_a580f6b981b231ff", #past:#"hash_f71e6b42189a1a3c" }, #var_7be076c9078045aa:#"hash_5db21f5065eba2db" } );
    }
    
    foreach ( player in level.players )
    {
        player thread function_2c166621dcc593e0( truck_keys );
    }
}

// Namespace namespace_c358c502db1450a7
// Params 1, eflags: 0x4
// Checksum 0x6a23097b, Offset: 0x6a5
// Size: 0x9d
function private function_2c166621dcc593e0( truck_keys )
{
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( self ) && isdefined( truck_keys ) && !utility::flag( "papq_truck_keys_picked_up" ) )
    {
        keys_distance = distance2d( self.origin, truck_keys.origin );
        var_b813a17c57d7c206 = undefined;
        
        if ( keys_distance <= 400 )
        {
            var_b813a17c57d7c206 = "dx_zm_ffet_esdt_dtwn_ffesdtsgn";
        }
        else if ( keys_distance <= 1200 )
        {
            var_b813a17c57d7c206 = "dx_zm_ffet_esdt_dtwn_ffesdtswi";
        }
        
        if ( isdefined( var_b813a17c57d7c206 ) )
        {
            self playsoundtoplayer( var_b813a17c57d7c206, self );
            wait 5;
        }
        
        wait 1;
    }
}

