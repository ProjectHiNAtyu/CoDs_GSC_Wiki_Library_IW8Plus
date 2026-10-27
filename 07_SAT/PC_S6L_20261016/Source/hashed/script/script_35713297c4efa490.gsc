// script_35713297c4efa490  (hash_35713297c4efa490.gscc) (size: 2946 Bytes / 0xb82 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16a29da3 (379755939)
// size ...... 2946 (0xb82)
// includes .. 4   (offset: 0xb56)
// strings ... 1   (offset: 0xb76)
// dev strs .. 0   (offset: 0xb82)
// exports ... 15  (offset: 0x6ee)
// cseg ...... 0x66 + 0x688 (0x6ee)
// imports ... 18  (offset: 0x946)
// animtree1 . 0   (offset: 0xb82)
// animtree2 . 0   (offset: 0xb82)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace ob_story_mission_activity_setup;

// Namespace ob_story_mission_activity_setup
// Params 3
// Checksum 0xe6600d3f, Offset: 0x84
// Size: 0xee
function function_a27e17544ac7654a( var_3078f4ad8b524dff, activity_name, phase_struct_array )
{
    level.current_activity_name = activity_name;
    var_751e8dda85292b5e = function_689b29a451b96e59( var_3078f4ad8b524dff );
    activity_struct = { #phase_struct_array:phase_struct_array, #activity_name:activity_name };
    var_751e8dda85292b5e.ordered_array[ var_751e8dda85292b5e.ordered_array.size ] = activity_struct;
    
    if ( !level.var_ddccc36eb7e41187 )
    {
        level.var_ddccc36eb7e41187 = [];
    }
    
    level.var_ddccc36eb7e41187[ activity_name ] = var_751e8dda85292b5e;
    activity_common::registeractivitytype( activity_name, &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( activity_name, 0, &generic_activity_setup );
    activity_common::function_944074f3079c1d4e( activity_name, 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( activity_name, 3, &generic_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity_generic, activity_name );
}

// Namespace ob_story_mission_activity_setup
// Params 2
// Checksum 0xdb898f59, Offset: 0x17a
// Size: 0x37
function function_13cff85d193f6c27( var_3078f4ad8b524dff, setup_function )
{
    var_751e8dda85292b5e = function_689b29a451b96e59( var_3078f4ad8b524dff );
    var_751e8dda85292b5e.setup_function = setup_function;
}

// Namespace ob_story_mission_activity_setup
// Params 2
// Checksum 0xc30ccc85, Offset: 0x1b9
// Size: 0x37
function function_159af14427677b6c( var_3078f4ad8b524dff, destroy_function )
{
    var_751e8dda85292b5e = function_689b29a451b96e59( var_3078f4ad8b524dff );
    var_751e8dda85292b5e.destroy_function = destroy_function;
}

// Namespace ob_story_mission_activity_setup
// Params 2
// Checksum 0x37fc9d78, Offset: 0x1f8
// Size: 0x37
function function_2f991abf23ddce4c( var_3078f4ad8b524dff, player_setup_function )
{
    var_751e8dda85292b5e = function_689b29a451b96e59( var_3078f4ad8b524dff );
    var_751e8dda85292b5e.player_setup_function = player_setup_function;
}

// Namespace ob_story_mission_activity_setup
// Params 1, eflags: 0x4
// Checksum 0xa4e1ec4c, Offset: 0x237
// Size: 0x54
function private function_689b29a451b96e59( var_3078f4ad8b524dff )
{
    if ( !level.var_486e367d92ce19aa[ var_3078f4ad8b524dff ] )
    {
        level.var_486e367d92ce19aa[ var_3078f4ad8b524dff ] = { #var_6c59fa92d86867dd:0, #var_bd384718a90a3ba2:0, #ordered_array:[] };
    }
    
    return level.var_486e367d92ce19aa[ var_3078f4ad8b524dff ];
}

// Namespace ob_story_mission_activity_setup
// Params 1, eflags: 0x4
// Checksum 0xd7d277fa, Offset: 0x294
// Size: 0x18
function private function_faa10ab8de2df757( activity_type )
{
    return level.var_ddccc36eb7e41187[ activity_type ];
}

// Namespace ob_story_mission_activity_setup
// Params 0, eflags: 0x4
// Checksum 0x72f6f12d, Offset: 0x2b5
// Size: 0xf0
function private function_477932e3884ea1fd()
{
    activity_instance = self;
    level.activity_instance = activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_751e8dda85292b5e = function_faa10ab8de2df757( activity_instance.type );
    
    if ( !var_751e8dda85292b5e.var_bd384718a90a3ba2 )
    {
        if ( var_751e8dda85292b5e.setup_function )
        {
            self [[ var_751e8dda85292b5e.setup_function ]]();
        }
        
        var_751e8dda85292b5e.var_bd384718a90a3ba2 = 1;
    }
    
    [ current_phase_struct_array, is_last_activity ] = function_97597aa01c2a5d6c( var_751e8dda85292b5e, activity_instance );
    function_345bf2955930627c( current_phase_struct_array, activity_instance );
    
    if ( is_last_activity && var_751e8dda85292b5e.destroy_function )
    {
        self [[ var_751e8dda85292b5e.destroy_function ]]();
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace ob_story_mission_activity_setup
// Params 2, eflags: 0x4
// Checksum 0x8ace0511, Offset: 0x3ad
// Size: 0x5c
function private function_2ef9c8b4ca46aad3( activity_instance, phase_struct_array )
{
    for ( struct_index = 0; struct_index < phase_struct_array.size ; struct_index++ )
    {
        phase_struct = phase_struct_array[ struct_index ];
        
        if ( phase_struct.result )
        {
            activity_instance [[ phase_struct.result ]]();
        }
    }
}

// Namespace ob_story_mission_activity_setup
// Params 2, eflags: 0x4
// Checksum 0x2b291c00, Offset: 0x411
// Size: 0xe4
function private function_97597aa01c2a5d6c( var_751e8dda85292b5e, activity_instance )
{
    current_phase_struct_array = undefined;
    is_last_activity = 0;
    
    for ( activity_index = 0; activity_index < var_751e8dda85292b5e.ordered_array.size ; activity_index++ )
    {
        activity_struct = var_751e8dda85292b5e.ordered_array[ activity_index ];
        is_last_activity = activity_index == var_751e8dda85292b5e.ordered_array.size - 1;
        
        if ( activity_struct.activity_name == activity_instance.type )
        {
            current_phase_struct_array = activity_struct.phase_struct_array;
            break;
        }
        
        if ( !var_751e8dda85292b5e.var_6c59fa92d86867dd )
        {
            function_2ef9c8b4ca46aad3( activity_instance, activity_struct.phase_struct_array );
        }
    }
    
    var_751e8dda85292b5e.var_6c59fa92d86867dd = 1;
    return [ current_phase_struct_array, is_last_activity ];
}

// Namespace ob_story_mission_activity_setup
// Params 2, eflags: 0x4
// Checksum 0xc83b0fc8, Offset: 0x4fe
// Size: 0x7a
function private function_345bf2955930627c( current_phase_struct_array, activity_instance )
{
    for ( struct_index = 0; struct_index < current_phase_struct_array.size ; struct_index++ )
    {
        phase_struct = current_phase_struct_array[ struct_index ];
        
        if ( phase_struct.var_de54801bc657ab2c )
        {
            activity_instance [[ phase_struct.var_de54801bc657ab2c ]]();
        }
        
        if ( phase_struct.result )
        {
            activity_instance [[ phase_struct.result ]]();
        }
    }
}

// Namespace ob_story_mission_activity_setup
// Params 0, eflags: 0x4
// Checksum 0xf15f0f2b, Offset: 0x580
// Size: 0x32
function private generic_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace ob_story_mission_activity_setup
// Params 0, eflags: 0x4
// Checksum 0x711f2808, Offset: 0x5ba
// Size: 0x2
function private generic_activity_destroy()
{
    
}

// Namespace ob_story_mission_activity_setup
// Params 1, eflags: 0x4
// Checksum 0x70a768f9, Offset: 0x5c4
// Size: 0xb4
function private player_joined_activity_generic( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

// Namespace ob_story_mission_activity_setup
// Params 1, eflags: 0x4
// Checksum 0xef8a00dc, Offset: 0x680
// Size: 0x6e
function private player_setup( player )
{
    activity_instance = self;
    var_751e8dda85292b5e = function_faa10ab8de2df757( activity_instance.type );
    
    if ( var_751e8dda85292b5e.player_setup_function )
    {
        activity_instance [[ var_751e8dda85292b5e.player_setup_function ]]( player );
    }
    
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
}

