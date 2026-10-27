// scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util.gsc  (hash_3d4b3584d0660f20.gscc) (size: 19156 Bytes / 0x4ad4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85ade10a (2242765066)
// size ...... 19156 (0x4ad4)
// includes .. 20  (offset: 0x442c)
// strings ... 104 (offset: 0x44cc)
// dev strs .. 1   (offset: 0x4ac8)
// exports ... 52  (offset: 0x2d1c)
// cseg ...... 0x7cb + 0x2551 (0x2d1c)
// imports ... 116 (offset: 0x353c)
// animtree1 . 0   (offset: 0x4ad4)
// animtree2 . 0   (offset: 0x4ad4)
#using script_61b40095fd0502f0;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;

#namespace mp_sat_ob_leo_util;

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0xf2091afe, Offset: 0x7e9
// Size: 0x1a
function player_setup( params )
{
    ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_aries_ob", 1 );
}

// Namespace mp_sat_ob_leo_util
// Params 4
// Checksum 0xc8d4ce82, Offset: 0x80b
// Size: 0x89
function update_objective_marker_location( trigger_targetname, position, var_4cc0d6c492112ce5, var_66983e9b7f1e4f98 )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    trigger = getent( trigger_targetname, #targetname );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    function_4408fb951c105cb4( trigger.targetname, var_4cc0d6c492112ce5, var_66983e9b7f1e4f98 );
    objidpoolmanager::update_objective_position( self.var_8029d4363972e15, position );
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0x99ce490c, Offset: 0x89c
// Size: 0x32
function unlock_door( var_9f7b718265f3faf9 )
{
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger scriptable_door_utility::simple_unlock_door();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0xb06f61de, Offset: 0x8d6
// Size: 0x53
function lock_door( var_9f7b718265f3faf9 )
{
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "closing" );
        trigger scriptable_door_utility::simple_lock_door();
        trigger utility::delaythread( 0.25, &scriptable_door_utility::simple_lock_door );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0x7cf9d9ba, Offset: 0x931
// Size: 0x37
function close_door( var_9f7b718265f3faf9 )
{
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "closing" );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0xea026313, Offset: 0x970
// Size: 0x37
function open_door( var_9f7b718265f3faf9 )
{
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "opening" );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0xd451445c, Offset: 0x9af
// Size: 0x128
function function_4b32b6185197e615( var_9f7b718265f3faf9, delay )
{
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        structs = utility::getstructarray( trigger.target, "targetname" );
        
        foreach ( struct in structs )
        {
            if ( struct.script_noteworthy == "console_unlock" )
            {
                prompt = gameobjects::createhintobject( struct.origin, "HINT_BUTTON", undefined, &"hash_e4f9f44bb8800d9" );
                prompt waittill( #"trigger" );
                prompt delete();
                
                if ( isdefined( delay ) )
                {
                    thread delay_opening( trigger, delay );
                    continue;
                }
                
                trigger scriptable_door_utility::simple_unlock_door();
            }
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0x99bc0889, Offset: 0xadf
// Size: 0x14b
function function_723acdc6f1e26832( var_9f7b718265f3faf9, var_490060d47d9e122a )
{
    connection_puzzle_init( var_490060d47d9e122a );
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        structs = utility::getstructarray( trigger.target, "targetname" );
        
        foreach ( index, struct in structs )
        {
            if ( struct.script_noteworthy == "console_unlock" )
            {
                struct.interact = interaction::register_interact( struct.origin, 64, &function_75188a7ccce84205, &"mp_dmz_locks/unlock_door" );
                struct.interact.var_490060d47d9e122a = var_490060d47d9e122a;
                struct.interact thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "console_unlock_" + index, level.connection_puzzle_asset );
                level waittill( #"hash_e648e2ff3818cd72" );
            }
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0x2b6ebc1, Offset: 0xc32
// Size: 0xa3
function function_75188a7ccce84205( player )
{
    if ( player connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
    {
        self makeunusable();
        finished = player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
        
        if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
        {
            player connection_puzzle::close();
            level notify( #"hash_e648e2ff3818cd72" );
            
            if ( isdefined( self ) )
            {
                self delete();
            }
            
            return;
        }
        
        waitframe();
        self makeusable();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0x71a04657, Offset: 0xcdd
// Size: 0x53
function connection_puzzle_init( var_490060d47d9e122a, var_3d410747e088bc43 )
{
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    thread connection_puzzle::init_from_layout( asset, var_490060d47d9e122a, var_490060d47d9e122a, undefined, var_3d410747e088bc43 );
    level.connection_puzzle_asset = asset;
    thread function_2e122204a2a9f941();
}

// Namespace mp_sat_ob_leo_util
// Params 0, eflags: 0x4
// Checksum 0xd32a92d0, Offset: 0xd38
// Size: 0xac
function private function_2e122204a2a9f941()
{
    level endon( #"death" );
    
    while ( true )
    {
        level waittill( #"ConnectionPuzzleCompleted", data );
        
        foreach ( player in data.players )
        {
            player notify( #"ConnectionPuzzleCompleted" );
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0xffa78588, Offset: 0xdec
// Size: 0x21
function delay_opening( trigger, delay )
{
    wait delay;
    trigger scriptable_door_utility::simple_unlock_door();
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0x618bf651, Offset: 0xe15
// Size: 0x40
function function_69a8cda9aa00992e( var_9f7b718265f3faf9 )
{
    trigger = getent( var_9f7b718265f3faf9, "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger scriptable_door_utility::simple_unlock_door();
        trigger scriptable_door_utility::function_ebbc2714ba8e6bd9( "opening" );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0x366c7201, Offset: 0xe5d
// Size: 0x2de
function function_f20a9fe6c594f5b3( var_5310aea068a35a30 )
{
    if ( var_5310aea068a35a30 )
    {
        foreach ( player in level.players )
        {
            foreach ( player in level.players )
            {
                player val::set( "cinematic", "hide", 1 );
                player val::set( "cinematic", "hide_viewmodel", 1 );
                player val::set( "cinematic", "allow_jump", 0 );
                player val::set( "cinematic", "allow_movement", 0 );
                player val::set( "cinematic", "crouch", 0 );
                player val::set( "cinematic", "prone", 0 );
                player val::set( "cinematic", "melee", 0 );
                player val::set( "cinematic", "offhand_primary_weapons", 0 );
                player val::set( "cinematic", "offhand_secondary_weapons", 0 );
                player val::set( "cinematic", "weapon", 0 );
                player val::set( "cinematic", "damage", 0 );
                player val::set( "cinematic", "killstreaks", 0 );
                player val::set( "cinematic", "ignoreme", 1 );
                player val::set( "cinematic", "freezecontrols", 1 );
                player val::set( "cinematic", "ads", 0 );
                player val::set( "cinematic", "weapon_switch", 0 );
                player val::set( "cinematic", "action_slot_weapon", 0 );
                player val::set( "cinematic", "armor", 0 );
                player val::set( "cinematic", "supers", 0 );
            }
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player val::reset_all( "cinematic" );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0x21dd637d, Offset: 0x1143
// Size: 0xd6
function function_4408fb951c105cb4( trigger_targetname, var_4cc0d6c492112ce5, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended" );
    var_5cba3aa7cba1a93c = getentarray( trigger_targetname, #targetname );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        var_5cba3aa7cba1a93c = getnoentvolumearray( trigger_targetname, #targetname );
        
        if ( !isdefined( var_5cba3aa7cba1a93c[ 0 ] ) )
        {
            /#
                iprintlnbold( "<dev string:x24>" + trigger_targetname );
            #/
            
            return;
        }
    }
    
    var_f8178163be04ed2 = spawnstruct();
    var_f8178163be04ed2.var_66983e9b7f1e4f98 = var_66983e9b7f1e4f98;
    thread utility::array_thread( var_5cba3aa7cba1a93c, &_trigger_wait_proc, var_f8178163be04ed2 );
    var_f8178163be04ed2 waittill( #"player_trigger", player );
    
    if ( isdefined( var_4cc0d6c492112ce5 ) )
    {
        level utility::flag_set( var_4cc0d6c492112ce5 );
    }
    
    return player;
}

// Namespace mp_sat_ob_leo_util
// Params 1, eflags: 0x4
// Checksum 0xc0ee45c6, Offset: 0x1222
// Size: 0x71
function private _trigger_wait_proc( var_f8178163be04ed2 )
{
    while ( true )
    {
        self waittill( #"trigger", data );
        
        if ( var_f8178163be04ed2.var_66983e9b7f1e4f98 )
        {
            if ( isplayer( data ) && !isbot( data ) )
            {
                break;
            }
        }
        else if ( isplayer( data ) )
        {
            break;
        }
        
        waitframe();
    }
    
    var_f8178163be04ed2 notify( #"player_trigger", data );
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0x201e555, Offset: 0x129b
// Size: 0x1aa
function spawn_dawgs( var_5a2d888ab5e604d8, usage_mode )
{
    a_ai_dawgs = [];
    var_263285fff9e45a22 = utility::getstructarray( var_5a2d888ab5e604d8 );
    
    foreach ( struct in var_263285fff9e45a22 )
    {
        dawg = mp_agent::spawnnewagentaitype( "sat_dawg_sm", struct.origin, struct.angles, "axis" );
        a_ai_dawgs = arraycombineunique( a_ai_dawgs, [ dawg ] );
        var_345458a731640cf2 = utility::spawn_tag_origin( struct.origin, struct.angles );
        var_345458a731640cf2.team = "axis";
        waitframe();
        dawg dawg::dawgpostinit( var_345458a731640cf2 );
        dawg.mode = usage_mode;
        dawg.dawgaisettings.var_8734919236400cef = 0.25;
        dawg.dawgaisettings.var_87117f9236199da1 = 0.5;
        dawg.dawgaisettings.var_a7eb97550bc3e63c = 1;
        dawg.dawgaisettings.var_a7c885550b9d76ee = 3;
        dawg.dawgaisettings.var_908a4957f43e8a8a = 5;
    }
    
    return a_ai_dawgs;
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0xa302f151, Offset: 0x144e
// Size: 0xd4
function set_revive_location( struct_targetname )
{
    [ struct ] = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( isdefined( struct ) )
    {
        foreach ( player in level.players )
        {
            player.var_30ee31fc6dba492a = struct.origin;
            player.var_5acd906128ef37bd = struct.angles;
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0xdb740375, Offset: 0x152a
// Size: 0x58
function function_df0396a50445e0c4( var_b441e339542b82c7, var_68b32a8bafee7061 )
{
    while ( !utility::flag( var_68b32a8bafee7061 ) )
    {
        activateworldevent( var_b441e339542b82c7 );
        wait 0.2;
        deactivateworldevent( var_b441e339542b82c7 );
        wait 0.1;
        activateworldevent( var_b441e339542b82c7 );
        wait 0.2;
        deactivateworldevent( var_b441e339542b82c7 );
        wait 0.5;
    }
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0x7f01f59a, Offset: 0x158a
// Size: 0x35
function function_eae6f210af41e04f( tick_name, period, var_68b32a8bafee7061 )
{
    while ( !utility::flag( var_68b32a8bafee7061 ) )
    {
        level notify( tick_name );
        wait period;
    }
}

// Namespace mp_sat_ob_leo_util
// Params 4
// Checksum 0xa05bd10a, Offset: 0x15c7
// Size: 0x54
function alarm_listener( alias, origin, tick_name, var_68b32a8bafee7061 )
{
    while ( !utility::flag( var_68b32a8bafee7061 ) )
    {
        level waittill( tick_name );
        
        if ( utility::flag( var_68b32a8bafee7061 ) )
        {
            break;
        }
        
        snd::play( alias, origin );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0xba1470e, Offset: 0x1623
// Size: 0x58
function function_cfe31985b0b4a074()
{
    if ( getdvarint( @"hash_d01f9382aa474535" ) == 1 )
    {
        activateworldevent( "biome_on_state" );
        activateworldevent( "presentation_on_state" );
        return;
    }
    
    level utility::flag_wait( "flag_presentation_puzzle_solved" );
    thread leo_audio::function_17dd2a88a8a7c3d2();
    wait 5;
    activateworldevent( "biome_on_state" );
    wait 5;
    activateworldevent( "presentation_on_state" );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x43aabd56, Offset: 0x1683
// Size: 0x19
function function_bc19dfd1e4b29cbd()
{
    level utility::flag_wait( "squad_play_begin" );
    activateworldevent( "presentation_on_state" );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0xa9e1ee8c, Offset: 0x16a4
// Size: 0xfe
function function_5bc972408ebad07a()
{
    level utility::flag_wait( "squad_play_begin" );
    deactivateworldevent( "presentation_on_state" );
    deactivateworldevent( "biome_on_state" );
    activateworldevent( "exfil_skylights" );
    activateworldevent( "escape_2_off_lightstate" );
    function_ad915db840c90fb3( 256, 3 );
    hwconfiguratoraddasset( %"hw_sat_ob_skyblend_1" );
    scriptables = getentitylessscriptablearray( "leo_desktop_monitor_on", #targetname );
    
    if ( isdefined( scriptables ) )
    {
        foreach ( scriptable in scriptables )
        {
            if ( scriptable getscriptableparthasstate( "base", "escape_monitor" ) )
            {
                scriptable setscriptablepartstate( "base", "escape_monitor" );
            }
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x57aa1e5f, Offset: 0x17aa
// Size: 0x53
function function_96b32ff9e4b0fc4c()
{
    level utility::flag_wait( "squad_play_begin" );
    deactivateworldevent( "exfil_skylights" );
    deactivateworldevent( "cradlelights_stage1" );
    deactivateworldevent( "cradlelights_stage3" );
    deactivateworldevent( "trapped_emergency" );
    hwconfiguratorremoveasset( %"hw_sat_ob_skyblend_1" );
    hwconfiguratorremoveasset( %"hw_sat_ob_fogheightmapfade_1" );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x735671e5, Offset: 0x1805
// Size: 0x135
function function_81942b7272d9ec15()
{
    fire_trigger = getent( "leo_burning_tree", "targetname" );
    
    if ( isdefined( fire_trigger ) )
    {
        fire_trigger utility::trigger_on();
    }
    
    shadow_geo = getent( "nic_trip_lighting_blocker", #targetname );
    
    if ( isdefined( shadow_geo ) )
    {
        shadow_geo hide();
    }
    
    leo_wall_bink_01 = getent( "leo_wall_bink_01", "targetname" );
    
    if ( isdefined( leo_wall_bink_01 ) )
    {
        leo_wall_bink_01 setmodel( "leo_02::sat_bink_sat_leo_wall_bink_01" );
    }
    
    destabilized_geo = getentarray( "guild_exfil_destabilized", "targetname" );
    
    foreach ( geo in destabilized_geo )
    {
        geo show();
    }
    
    atrium_skylight_glass = getent( "atrium_skylight_glass", "targetname" );
    
    if ( isdefined( atrium_skylight_glass ) )
    {
        atrium_skylight_glass delete();
    }
    
    utility::kill_exploder( "facility_start_atrium_ambient" );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0xced68253, Offset: 0x1942
// Size: 0xe6
function function_d2eaefb295692571()
{
    fire_trigger = getent( "leo_burning_tree", "targetname" );
    
    if ( isdefined( fire_trigger ) )
    {
        fire_trigger utility::trigger_off();
    }
    
    shadow_geo = getent( "nic_trip_lighting_blocker", #targetname );
    
    if ( isdefined( shadow_geo ) )
    {
        shadow_geo show();
    }
    
    destabilized_geo = getentarray( "guild_exfil_destabilized", "targetname" );
    
    foreach ( geo in destabilized_geo )
    {
        geo hide();
    }
    
    utility::exploder( "facility_start_atrium_ambient" );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x76b4c153, Offset: 0x1a30
// Size: 0x21a
function function_7ef23a62d6556750()
{
    if ( isdefined( level.var_6e37e4867416dc04 ) )
    {
        return;
    }
    
    level.var_6e37e4867416dc04 = utility::getstructarray( "mansion_courtyard_gate_struct", "script_noteworthy" );
    
    if ( !isdefined( level.var_6e37e4867416dc04 ) || isdefined( level.var_6e37e4867416dc04 ) && level.var_6e37e4867416dc04.size == 0 )
    {
        return;
    }
    
    foreach ( struct in level.var_6e37e4867416dc04 )
    {
        var_2625efdafde82b32 = getentarray( struct.target, #targetname );
        
        foreach ( ent in var_2625efdafde82b32 )
        {
            if ( ent.model == "sat_door_spanish_gate_03" )
            {
                ent.script_noteworthy = "right_gate";
                ent.animname = "right_gate";
                level.var_326edda0c9842ec2 = ent;
            }
            
            if ( ent.model == "sat_door_spanish_gate_03b" )
            {
                ent.script_noteworthy = "left_gate";
                ent.animname = "left_gate";
                level.var_77e9f36a18ae5ee1 = ent;
            }
        }
    }
    
    scene_struct = utility::getstruct( "scene_nic_face_to_face", "targetname" );
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct thread scene::play( [ level.var_77e9f36a18ae5ee1, level.var_326edda0c9842ec2 ], "init" );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0xa72354de, Offset: 0x1c52
// Size: 0x231
function function_b11f02a770404e83( var_ae740a76f0c8ef99 = 1, var_dc30140f96228c59 )
{
    if ( !isdefined( level.var_6e37e4867416dc04 ) )
    {
        return;
    }
    
    if ( var_ae740a76f0c8ef99 )
    {
        if ( !isdefined( level.var_4acdd47c94a8e277 ) )
        {
            if ( !isdefined( var_dc30140f96228c59 ) )
            {
                var_dc30140f96228c59 = 3;
            }
            
            foreach ( struct in level.var_6e37e4867416dc04 )
            {
                if ( issubstr( struct.targetname, "left" ) )
                {
                    struct.tag_origin rotateto( ( 0, 90, 0 ), var_dc30140f96228c59 );
                    continue;
                }
                
                if ( issubstr( struct.targetname, "right" ) )
                {
                    struct.tag_origin rotateto( ( 0, -90, 0 ), var_dc30140f96228c59 );
                }
            }
            
            level.var_4acdd47c94a8e277 = 1;
        }
        
        return;
    }
    
    if ( isdefined( level.var_4acdd47c94a8e277 ) )
    {
        if ( !isdefined( var_dc30140f96228c59 ) )
        {
            var_dc30140f96228c59 = 0.05;
        }
        
        foreach ( struct in level.var_6e37e4867416dc04 )
        {
            if ( issubstr( struct.targetname, "left" ) )
            {
                struct.tag_origin rotateto( ( 0, -90, 0 ), var_dc30140f96228c59 );
                continue;
            }
            
            if ( issubstr( struct.targetname, "right" ) )
            {
                struct.tag_origin rotateto( ( 0, 90, 0 ), var_dc30140f96228c59 );
            }
        }
        
        level.var_4acdd47c94a8e277 = undefined;
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x6a6e05eb, Offset: 0x1e8b
// Size: 0x7f
function function_f98405b711a3e3d()
{
    geo = getent( "sun_shadow_stone", #script_noteworthy );
    
    if ( isdefined( geo ) )
    {
        level utility::flag_wait( "flag_player_crests_hill" );
        time = 40;
        geo show();
        geo moveto( ( -549.5, -661.55, 3657.83 ), time );
        wait time;
        geo moveto( ( 16023.7, 32351, 2557.83 ), time );
        wait time;
        geo hide();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x1fbcf477, Offset: 0x1f12
// Size: 0x2d
function function_114cdd1a4d524d36()
{
    geo = getent( "sun_shadow_stone", #script_noteworthy );
    
    if ( isdefined( geo ) )
    {
        geo hide();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0x8353e3a7, Offset: 0x1f47
// Size: 0x26b
function menendez_sighting( struct_targetname, flag_to_stop, var_4543b73abeb48410 )
{
    scene_struct = utility::getstruct( struct_targetname, "targetname" );
    
    if ( !isdefined( scene_struct ) )
    {
        return;
    }
    
    var_35fda20e5a3e45c4 = removesubstr( flag_to_stop, "_stop" );
    trigger_str = removesubstr( var_35fda20e5a3e45c4, "flag_" );
    var_1c648dcd70df6d16 = var_35fda20e5a3e45c4 + "_start_enter";
    var_f2d713dbffc81ee0 = var_35fda20e5a3e45c4 + "_start_exit";
    start_enter_trig_targetname = trigger_str + "_start_enter_trig";
    trigger = getnoentvolumearray( start_enter_trig_targetname, #targetname )[ 0 ];
    
    if ( isdefined( trigger ) )
    {
        level utility::flag_wait( var_1c648dcd70df6d16 );
    }
    
    var_93c3096cb74c8839 = var_35fda20e5a3e45c4 + "_enter_shot_complete";
    scene_struct thread function_6a840c40f5befd16( "enter", flag_to_stop, var_93c3096cb74c8839 );
    waitframe();
    menendez = scene_struct scene::get_entity( "menendez" );
    ents = scene_struct scene::get_entities();
    menendez thread mp_sat_ob_leo_vo::function_b14917005280c04e( var_4543b73abeb48410 );
    result = utility::waittill_any_ents_return( level, var_93c3096cb74c8839, level, var_f2d713dbffc81ee0 );
    
    if ( isdefined( result ) )
    {
        if ( result == var_f2d713dbffc81ee0 )
        {
            result = utility::waittill_any_ents_return( level, var_93c3096cb74c8839, level, flag_to_stop );
            
            if ( isdefined( result ) )
            {
                if ( result == flag_to_stop )
                {
                    scene_struct function_112d405d4c9d1f98();
                    return;
                }
            }
        }
        else
        {
            scene_struct thread scene::play( ents, "idle" );
        }
    }
    else
    {
        scene_struct function_112d405d4c9d1f98();
        return;
    }
    
    start_exit_trig_targetname = trigger_str + "_start_exit_trig";
    trigger = getnoentvolumearray( start_exit_trig_targetname, #targetname )[ 0 ];
    
    if ( isdefined( trigger ) )
    {
        level utility::flag_wait( var_f2d713dbffc81ee0 );
        var_93c3096cb74c8839 = var_35fda20e5a3e45c4 + "_enter_shot_complete";
        scene_struct thread function_6a840c40f5befd16( "exit", flag_to_stop, var_93c3096cb74c8839 );
    }
    
    scene_struct scene::set_notify_note( menendez, "menendez_exit_start", "Types_Prop" );
    scene_struct scene::set_notify_note( menendez, "end", "Types_Prop" );
    result = utility::waittill_any_ents_return( menendez, "menendez_exit_start", level, flag_to_stop, level, var_93c3096cb74c8839 );
    
    if ( isdefined( result ) )
    {
        if ( result == flag_to_stop )
        {
            scene_struct function_112d405d4c9d1f98();
            return;
        }
        else if ( result == var_93c3096cb74c8839 )
        {
        }
        else
        {
            menendez waittill( #"end" );
        }
    }
    else
    {
        scene_struct function_112d405d4c9d1f98();
        return;
    }
    
    scene_struct thread scene::cleanup( 1 );
    utility::array_delete( ents );
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0xdab7f4bd, Offset: 0x21ba
// Size: 0x37
function function_6a840c40f5befd16( shot, var_68b32a8bafee7061, var_93c3096cb74c8839 )
{
    level endon( var_68b32a8bafee7061 );
    scene::play( undefined, shot );
    level utility::flag_set( var_93c3096cb74c8839 );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x1988c486, Offset: 0x21f9
// Size: 0x63
function function_112d405d4c9d1f98()
{
    menendez = scene::get_entity( "menendez" );
    ents = scene::get_entities();
    playfxontag( level._effect[ "menendez_disappear" ], menendez, "tag_origin" );
    wait 0.5;
    thread scene::stop();
    thread scene::cleanup( 1 );
    utility::array_delete( ents );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x9e2514fe, Offset: 0x2264
// Size: 0x13c
function init_butterflies()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "story_mission_party_check_complete" );
    var_4cdd3e0c7bc900e5 = getentarray( "leo_butterfly", #targetname );
    
    foreach ( trigger in var_4cdd3e0c7bc900e5 )
    {
        var_730797b3969a3049 = getscriptablearray( trigger.target, #targetname );
        
        foreach ( butterfly in var_730797b3969a3049 )
        {
            butterfly childthread butterfly_damage_watcher( trigger );
            butterfly childthread function_77339c146e36bda5();
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1, eflags: 0x4
// Checksum 0xe1d803ed, Offset: 0x23a8
// Size: 0x2d
function private butterfly_damage_watcher( trigger )
{
    self endon( #"butterfly_removed" );
    trigger waittill( #"damage" );
    butterfly_takeoff();
}

// Namespace mp_sat_ob_leo_util
// Params 0, eflags: 0x4
// Checksum 0x252d1c05, Offset: 0x23dd
// Size: 0x67
function private function_77339c146e36bda5()
{
    self endon( #"butterfly_removed" );
    self.var_d92244201002a11b = spawn( "trigger_radius", self.origin, 0, 150, 150 );
    
    while ( true )
    {
        self.var_d92244201002a11b waittill( #"trigger", ent );
        
        if ( isdefined( ent ) )
        {
            break;
        }
    }
    
    butterfly_takeoff();
}

// Namespace mp_sat_ob_leo_util
// Params 0, eflags: 0x4
// Checksum 0x2f53e0ec, Offset: 0x244c
// Size: 0x4c
function private butterfly_takeoff()
{
    if ( !isent( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "butterfly", "takeoff" );
    self notify( #"butterfly_removed" );
    
    if ( isent( self.var_d92244201002a11b ) )
    {
        self.var_d92244201002a11b delete();
    }
    
    self delete();
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x90cedaa, Offset: 0x24a0
// Size: 0xfa
function function_46c7dd890b4e2bbb()
{
    mansion_courtyard_exterior_trigger = getent( "mansion_courtyard_exterior", "script_noteworthy" );
    mansion_courtyard_interior_trigger = getent( "mansion_courtyard_interior", "script_noteworthy" );
    structs = [ { #angles:( 0, 330, 0 ), #origin:( -3945, 5088, -470 ) }, { #angles:( 0, 330, 0 ), #origin:( -3835, 5161, -470 ) } ];
    level thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "trig_fail_falls", undefined, { #structs:structs, #fails:2 } );
    
    if ( isdefined( mansion_courtyard_interior_trigger ) )
    {
        mansion_courtyard_interior_trigger notify( #"hash_24928a6c9cd6611f" );
        mansion_courtyard_interior_trigger delete();
    }
    
    if ( isdefined( mansion_courtyard_exterior_trigger ) )
    {
        mansion_courtyard_exterior_trigger notify( #"hash_24928a6c9cd6611f" );
        mansion_courtyard_exterior_trigger delete();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x2e5c156c, Offset: 0x25a2
// Size: 0x6a
function setup_force_fields()
{
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "presentation_ff", #targetname );
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "off", "labs_security_ff", #targetname );
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "quantum_computer_ff", #targetname );
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "off", "quantum_security_ff", #targetname );
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0x603bec4, Offset: 0x2614
// Size: 0xbc
function turn_off_force_field( force_field_name, key = #targetname, remove_power_supply = 0 )
{
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff mp_sat_ob_libra_util::force_field_off( undefined, remove_power_supply );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0x1ade381a, Offset: 0x26d8
// Size: 0xa8
function turn_on_force_field( force_field_name, key = #targetname )
{
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff mp_sat_ob_libra_util::force_field_on();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0xc458594b, Offset: 0x2788
// Size: 0x12a
function function_964f0734bd246983()
{
    self.var_2fc3a5fb762afb6e = 1;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    self.ignoreall = 1;
    self.team = "team_hundred_ninety";
    self.var_24954f14e27b448d = 0;
    self.battlechatter.npcid = "1";
    var_bf1316595b384341 = self.health;
    self.health = 10;
    utility::ent_flag_wait( "scene_active" );
    utility::ent_flag_waitopen_any( "scene_active" );
    self.var_2fc3a5fb762afb6e = 0;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    self.ignoreall = 0;
    self.health = var_bf1316595b384341;
    self.var_24954f14e27b448d = 1;
    level waittill( #"cleanup_scientists" );
    iprintln( "CLEAN UP SCIENTISTS" );
    wait 3;
    
    if ( isdefined( self ) )
    {
        self.nocorpse = 1;
        self.var_a13bed1ac47e1b2c = 1;
        self.dropweapon = 0;
        
        if ( self.magic_bullet_shield )
        {
            ai::stop_magic_bullet_shield();
        }
        
        agent_utils::despawnagent();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x5c7c50fb, Offset: 0x28ba
// Size: 0x106
function function_ffe2fe0ce9e850f3()
{
    self waittill( #"damage" );
    iprintln( "KILL SCIENTIST" );
    
    if ( isdefined( self ) )
    {
        scene_struct = utility::getstruct( self.sceneobjectdata.sceneroot.targetname, "targetname" );
        scene_ents = scene_struct scene::get_entities();
        
        foreach ( ent in scene_ents )
        {
            ent notify( #"damage" );
        }
        
        self.var_a13bed1ac47e1b2c = 1;
        self.dropweapon = 0;
        
        if ( self.magic_bullet_shield )
        {
            ai::stop_magic_bullet_shield();
        }
        
        self kill();
    }
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0xd045d4f7, Offset: 0x29c8
// Size: 0x31
function function_2463b23bc69b1a0a( enemies, killcount, flag )
{
    waittill_dead_or_dying( enemies, killcount );
    utility::flag_set( flag );
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0x725df4f9, Offset: 0x2a01
// Size: 0xba
function function_ac9de8895f3e4a23( guys, vol )
{
    guys = utility::array_removedead_or_dying( guys );
    goalvolume = getent( vol, "targetname" );
    
    foreach ( guy in guys )
    {
        if ( isalive( guy ) )
        {
            guy thread function_c04c50d8c93df4d3( goalvolume, 1.2, 2.7 );
        }
    }
}

// Namespace mp_sat_ob_leo_util
// Params 3
// Checksum 0x6edeb70d, Offset: 0x2ac3
// Size: 0x6e
function function_c04c50d8c93df4d3( goalvolume, delay_min, delay_max )
{
    if ( isdefined( delay_min ) && isdefined( delay_max ) )
    {
        self endon( #"death" );
        wait randomfloatrange( delay_min, delay_max );
    }
    
    if ( isalive( self ) )
    {
        self.forcegoal = 0;
        self.fixednode = 0;
        self cleargoalentity();
        self cleargoalvolume();
        self setgoalvolumeauto( goalvolume );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 2
// Checksum 0x132c8c6b, Offset: 0x2b39
// Size: 0x11a
function waittill_dead_or_dying( guys, num )
{
    newarray = [];
    
    foreach ( member in guys )
    {
        if ( isalive( member ) && !member.ignoreforfixednodesafecheck )
        {
            newarray[ newarray.size ] = member;
        }
    }
    
    guys = newarray;
    ent = spawnstruct();
    ent.count = guys.size;
    
    if ( num < ent.count )
    {
        ent.count = num;
    }
    
    utility::array_thread( guys, &waittill_dead_or_dying_thread, ent );
    
    while ( ent.count > 0 )
    {
        ent waittill( #"waittill_dead_guy_dead_or_dying" );
    }
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0x3956d602, Offset: 0x2c5b
// Size: 0x3b
function waittill_dead_or_dying_thread( ent )
{
    utility::waittill_any( "death", "long_death", "death_engaged" );
    ent.count--;
    ent notify( #"waittill_dead_guy_dead_or_dying" );
}

// Namespace mp_sat_ob_leo_util
// Params 0
// Checksum 0x36076b10, Offset: 0x2c9e
// Size: 0x18
function function_3c8a17513e90ef86()
{
    level callback::add( #"player_damaged", &onplayerdamaged );
}

// Namespace mp_sat_ob_leo_util
// Params 1
// Checksum 0xaf9c5b3a, Offset: 0x2cbe
// Size: 0x5e
function onplayerdamaged( params )
{
    attacker = params.eattacker;
    
    if ( isdefined( attacker.model ) && issubstr( attacker.model, "machete" ) )
    {
        thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, self, undefined, undefined, 1 );
    }
}

