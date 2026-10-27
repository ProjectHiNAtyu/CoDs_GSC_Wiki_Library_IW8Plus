// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting.gsc  (hash_6c204334176dab9c.gscc) (size: 4841 Bytes / 0x12e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4289435e (1116291934)
// size ...... 4841 (0x12e9)
// includes .. 1   (offset: 0x10d9)
// strings ... 27  (offset: 0x10e1)
// dev strs .. 0   (offset: 0x12e9)
// exports ... 17  (offset: 0xa45)
// cseg ...... 0x27e + 0x7c7 (0xa45)
// imports ... 28  (offset: 0xced)
// animtree1 . 0   (offset: 0x12e9)
// animtree2 . 0   (offset: 0x12e9)
#using scripts\common\utility;

#namespace mp_sat_ob_libra_lighting;

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0xe1a4c3ab, Offset: 0x29c
// Size: 0x1e
function main()
{
    thread function_4e3e02d46ada7959();
    thread function_1a9ee3320c42edc9();
    thread function_6ad8859661f261e2();
    thread function_df258c2333596c98();
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x97fede2f, Offset: 0x2c2
// Size: 0xa1
function function_df258c2333596c98()
{
    level utility::flag_wait( "squad_play_begin" );
    blockers = getentarray( "lgt_blocker_brush", #targetname );
    
    if ( isdefined( blockers ) )
    {
        foreach ( blocker in blockers )
        {
            blocker hide();
        }
    }
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x84b857c0, Offset: 0x36b
// Size: 0x2
function post_fx()
{
    
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x8e5e5fb0, Offset: 0x375
// Size: 0x4f
function function_4e3e02d46ada7959()
{
    level utility::flag_wait( "flag_infil_door_opened" );
    wait 0.4;
    activateworldevent( "LGT_ENTRY_FLOOR_01" );
    activateworldevent( "LGT_ENTRY_FLOOR_OFF" );
    wait 0.1;
    activateworldevent( "LGT_ENTRY_FLOOR_02" );
    wait 0.1;
    activateworldevent( "LGT_ENTRY_FLOOR_03" );
    wait 0.1;
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x58165515, Offset: 0x3cc
// Size: 0x32
function function_1a9ee3320c42edc9()
{
    level utility::flag_wait( "pump_b_done" );
    function_ad915db840c90fb3( 256, 2, 12 );
    level utility::flag_wait( "flag_backtrack_done" );
    function_ad915db840c90fb3( 256, 1 );
}

// Namespace mp_sat_ob_libra_lighting
// Params 2
// Checksum 0x47424add, Offset: 0x406
// Size: 0x1ee
function function_c13c803d33601b7( var_10a8260273840499, var_10a823027383fe00 )
{
    level endon( #"start_sphere_raise" );
    var_eb1cb96d31019392 = getent( var_10a8260273840499, "targetname" );
    moveto_target = utility::getstruct( var_eb1cb96d31019392.target, "targetname" );
    var_eb1cb96d31019392.moveto_pos = moveto_target.origin;
    var_eb1cb96d31019392.maxdist_to_target = distance( var_eb1cb96d31019392.origin, var_eb1cb96d31019392.moveto_pos );
    var_eb1cb86d3101915f = getent( var_10a8260273840499, "targetname" );
    moveto_target = utility::getstruct( var_eb1cb86d3101915f.target, "targetname" );
    var_eb1cb86d3101915f.moveto_pos = moveto_target.origin;
    var_eb1cb86d3101915f.maxdist_to_target = distance( var_eb1cb86d3101915f.origin, var_eb1cb86d3101915f.moveto_pos );
    closed = 1;
    
    while ( true )
    {
        dist_to_target = distance( var_eb1cb96d31019392.origin, var_eb1cb96d31019392.moveto_pos );
        var_d7be34ab696c7899 = dist_to_target / var_eb1cb96d31019392.maxdist_to_target;
        dist_to_target = distance( var_eb1cb86d3101915f.origin, var_eb1cb86d3101915f.moveto_pos );
        var_d7be31ab696c7200 = dist_to_target / var_eb1cb96d31019392.maxdist_to_target;
        
        if ( var_d7be34ab696c7899 + var_d7be31ab696c7200 > 1.6 && !closed )
        {
            activateworldevent( "LGT_processing_pool_close" );
            level.cradle_sphere thread function_77d7f4f702cc0d6();
            closed = 1;
        }
        else if ( var_d7be34ab696c7899 + var_d7be31ab696c7200 <= 1.6 && closed )
        {
            deactivateworldevent( "LGT_processing_pool_close" );
            level.cradle_sphere thread function_70a171f22b600bac();
            closed = 0;
        }
        
        wait 0.5;
    }
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x8fa982b, Offset: 0x5fc
// Size: 0xba
function function_77d7f4f702cc0d6()
{
    killfxontag( level._effect[ "cradle_sphere_center_light" ], self, "tag_fx9" );
    killfxontag( level._effect[ "cradle_sphere_center_light" ], self, "tag_fx10" );
    waitframe();
    killfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx11" );
    killfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx12" );
    killfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx13" );
    waitframe();
    killfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx14" );
    killfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx15" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0xff65689f, Offset: 0x6be
// Size: 0xba
function function_70a171f22b600bac()
{
    playfxontag( level._effect[ "cradle_sphere_center_light" ], self, "tag_fx9" );
    playfxontag( level._effect[ "cradle_sphere_center_light" ], self, "tag_fx10" );
    waitframe();
    playfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx11" );
    playfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx12" );
    playfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx13" );
    waitframe();
    playfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx14" );
    playfxontag( level._effect[ "cradle_sphere_ring_light" ], self, "tag_fx15" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0xfaac564b, Offset: 0x780
// Size: 0x6b
function function_6ad8859661f261e2()
{
    thread function_42bb95640c553323( "pump_b_done" );
    utility::flag_init( "igc_proc_alarm" );
    utility::flag_wait( "start_processing" );
    utility::flag_set( "igc_proc_alarm" );
    thread function_42bb95640c553323( "igc_proc_alarm" );
    level waittill( #"proc_igc_alarm_off" );
    utility::flag_clear( "igc_proc_alarm" );
    deactivateworldevent( "LGT_PROC_DOOR_PRE_ALARM" );
    deactivateworldevent( "LGT_PROC_DOOR_POST_ALARM" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 1
// Checksum 0x8af6c353, Offset: 0x7f3
// Size: 0xc2
function function_42bb95640c553323( alarm_flag )
{
    level endon( #"flag_backtrack_done" );
    level endon( #"death" );
    level utility::flag_wait( "squad_play_begin" );
    utility::flag_wait( alarm_flag );
    activateworldevent( "LGT_PROC_DOOR_PRE_ALARM" );
    activateworldevent( "LGT_PROC_DOOR_POST_ALARM" );
    
    while ( utility::flag( alarm_flag ) )
    {
        wait 0.1;
        activateworldevent( "LGT_PROC_ALARM" );
        wait 0.75;
        deactivateworldevent( "LGT_PROC_ALARM" );
        wait 0.33;
        activateworldevent( "LGT_PROC_ALARM" );
        wait 0.75;
        deactivateworldevent( "LGT_PROC_ALARM" );
        wait 0.33;
        activateworldevent( "LGT_PROC_ALARM" );
        wait 0.75;
        deactivateworldevent( "LGT_PROC_ALARM" );
        wait 0.9;
    }
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x81156827, Offset: 0x8bd
// Size: 0x19
function function_430f1a03769e2382()
{
    level utility::flag_wait( "squad_play_begin" );
    activateworldevent( "LGT_processing_pool_close" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x6295fe43, Offset: 0x8de
// Size: 0x19
function function_288d889fb17fd166()
{
    level utility::flag_wait( "squad_play_begin" );
    deactivateworldevent( "LGT_processing_pool_close" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0x352a4f2, Offset: 0x8ff
// Size: 0x2d
function function_2bd21e5bfd850bd0()
{
    level utility::flag_wait( "squad_play_begin" );
    deactivateworldevent( "LGT_PROC_ALARM" );
    deactivateworldevent( "LGT_PROC_DOOR_PRE_ALARM" );
    deactivateworldevent( "LGT_PROC_DOOR_POST_ALARM" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0xc4657043, Offset: 0x934
// Size: 0x23
function function_b7ceeb7cacd224c8()
{
    level utility::flag_wait( "squad_play_begin" );
    deactivateworldevent( "LGT_storage_white_line_off" );
    deactivateworldevent( "LGT_storage_yellow_line_off" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 0
// Checksum 0xcbc13410, Offset: 0x95f
// Size: 0x39
function function_f3daa22b92d8fb8d()
{
    level utility::flag_wait( "squad_play_begin" );
    deactivateworldevent( "LGT_processing_pool_close" );
    deactivateworldevent( "LGT_PROC_DOOR_PRE_ALARM" );
    deactivateworldevent( "LGT_PROC_DOOR_POST_ALARM" );
    thread function_42bb95640c553323( "pump_b_done" );
}

// Namespace mp_sat_ob_libra_lighting
// Params 5
// Checksum 0xcf0b6125, Offset: 0x9a0
// Size: 0xa5
function function_7ba8f081958256f6( on_flag_array, off_flag, pbg_mask, on_time, off_time )
{
    flag_weight = 1 / on_flag_array.size;
    cradle_weight = 0;
    
    while ( on_flag_array.size > 0 )
    {
        used_flag = utility::flag_wait_any_array_return( on_flag_array );
        cradle_weight += flag_weight;
        function_bad804aa06ca5204( pbg_mask, 1 - cradle_weight, cradle_weight, 0, 0, 0, 0, 0, 0, on_time );
        on_flag_array = utility::function_d751969553a4bddd( on_flag_array, used_flag );
    }
    
    utility::flag_wait( off_flag );
    function_ad915db840c90fb3( pbg_mask, 1, off_time );
}

