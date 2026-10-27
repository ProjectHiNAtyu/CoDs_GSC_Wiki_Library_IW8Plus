// script_35efc59124dbb5db  (hash_35efc59124dbb5db.gscc) (size: 6889 Bytes / 0x1ae9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49e8a21f (1239982623)
// size ...... 6889 (0x1ae9)
// includes .. 9   (offset: 0x1991)
// strings ... 18  (offset: 0x19d9)
// dev strs .. 2   (offset: 0x1ad1)
// exports ... 16  (offset: 0x1179)
// cseg ...... 0x1b8 + 0xfc1 (0x1179)
// imports ... 46  (offset: 0x13f9)
// animtree1 . 0   (offset: 0x1ae9)
// animtree2 . 0   (offset: 0x1ae9)
#using script_61b40095fd0502f0;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\time_travel_timewarps;
#using scripts\mp\zm\systems\zm_quest;

#namespace namespace_a7211835085600d5;

// Namespace namespace_a7211835085600d5
// Params 0, eflags: 0x5
// Checksum 0x88b8b444, Offset: 0x1d6
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_fba963fcf056176a", undefined, &function_d2a0d54ef47ef9bb, undefined );
}

// Namespace namespace_a7211835085600d5
// Params 6
// Checksum 0x1289f914, Offset: 0x1f7
// Size: 0x10b
function add_objective_mark( quest_ref, target, name, z_offset = 0, mark_timewarp = 1, guidance_data )
{
    var_d33aaea2cec8f3ec = undefined;
    
    if ( isent( target ) )
    {
        var_d33aaea2cec8f3ec = &zm_quest::function_dc297429579c6e7f;
    }
    else if ( isvector( target ) )
    {
        var_d33aaea2cec8f3ec = &zm_quest::function_b98d4144845ffc13;
    }
    
    if ( !isdefined( var_d33aaea2cec8f3ec ) )
    {
        return;
    }
    
    objective_mark = [[ var_d33aaea2cec8f3ec ]]( name, 1, "ui_icon_zm_objective", "icon_small_medium", "current", target, z_offset );
    thread function_72c6aaca6d2e931f( objective_mark, target, z_offset, quest_ref, mark_timewarp, guidance_data );
    
    if ( isdefined( quest_ref ) )
    {
        if ( !isdefined( level.var_33141fc833673a63 ) )
        {
            level.var_33141fc833673a63 = [];
        }
        
        if ( !isdefined( level.var_33141fc833673a63[ quest_ref ] ) )
        {
            level.var_33141fc833673a63[ quest_ref ] = [];
        }
        
        level.var_33141fc833673a63[ quest_ref ][ level.var_33141fc833673a63[ quest_ref ].size ] = objective_mark;
    }
    
    return objective_mark;
}

// Namespace namespace_a7211835085600d5
// Params 6, eflags: 0x4
// Checksum 0x84df5bf8, Offset: 0x30b
// Size: 0x27d
function private function_72c6aaca6d2e931f( objective_mark, target, z_offset, quest_ref, mark_timewarp, guidance_data )
{
    level endon( "end_mark_on_distance_" + objective_mark );
    
    while ( !objidpoolmanager::function_fb05d646a96ed99e( objective_mark ) )
    {
        target_origin = isvector( target ) ? target : target.origin;
        
        if ( !isdefined( target_origin ) )
        {
            return;
        }
        
        if ( level utility::flag( "exfil_active" ) )
        {
            objidpoolmanager::objective_playermask_hidefromall( objective_mark );
            level utility::flag_waitopen( "exfil_active" );
            objidpoolmanager::objective_playermask_showtoall( objective_mark );
        }
        
        if ( level utility::flag( "timetravel_ongoing" ) )
        {
            objidpoolmanager::objective_playermask_hidefromall( objective_mark );
            level utility::flag_waitopen( "timetravel_ongoing" );
            objidpoolmanager::objective_playermask_showtoall( objective_mark );
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, target_origin ) > squared( 5000 ) )
            {
                if ( mark_timewarp )
                {
                    closest_timewarp = namespace_24edb5d87524aa7f::get_closest_timewarp( player.origin );
                    target_timeline = time_travel::get_next_timeline().name;
                    objidpoolmanager::update_objective_position( objective_mark, closest_timewarp.origin + ( 0, 0, 110 - z_offset ) );
                    
                    if ( isdefined( guidance_data ) )
                    {
                        timetravel_step = target_timeline == "past" ? guidance_data.timetravel_step.past : guidance_data.timetravel_step.future;
                        thread zm_quest::update_guidance( undefined, quest_ref, timetravel_step, 1 );
                    }
                }
                else
                {
                    objidpoolmanager::objective_playermask_hidefrom( objective_mark, player );
                }
                
                continue;
            }
            
            if ( mark_timewarp )
            {
                objidpoolmanager::update_objective_position( objective_mark, target_origin );
                
                if ( isdefined( guidance_data ) )
                {
                    thread zm_quest::update_guidance( undefined, quest_ref, guidance_data.var_7be076c9078045aa, 1 );
                }
                
                continue;
            }
            
            objidpoolmanager::objective_playermask_addshowplayer( objective_mark, player );
        }
        
        wait 1;
    }
}

// Namespace namespace_a7211835085600d5
// Params 1
// Checksum 0x26fc4d15, Offset: 0x590
// Size: 0x9d
function clear_objective_marks( quest_ref )
{
    foreach ( objective_mark in level.var_33141fc833673a63[ quest_ref ] )
    {
        if ( !isdefined( objective_mark ) )
        {
            continue;
        }
        
        level notify( "end_mark_on_distance_" + objective_mark );
        zm_quest::complete_objective_waypoints( objective_mark );
    }
}

// Namespace namespace_a7211835085600d5
// Params 2
// Checksum 0x591bab97, Offset: 0x635
// Size: 0x28f
function function_45750fc2b2afc77b( door_paths, objective_marks = [] )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    var_3a3e5a4b731e9905 = [];
    paths_chosen = [];
    
    foreach ( path in door_paths )
    {
        doors = function_ee02c937eb2e96e1( path[ 0 ] );
        
        if ( !isdefined( doors ) )
        {
            assertmsg( "<dev string:x24>" + path[ 0 ] + "<dev string:x4d>" );
            continue;
        }
        
        foreach ( door in doors )
        {
            door.path = path;
            objective_mark = add_objective_mark( door.origin, "door_objective_mark" );
            var_3a3e5a4b731e9905 = arraycombineunique( var_3a3e5a4b731e9905, [ door ] );
            objective_marks[ objective_marks.size ] = objective_mark;
        }
    }
    
    while ( paths_chosen.size <= 0 )
    {
        level waittill( #"door_opened", opened_door );
        
        foreach ( door in var_3a3e5a4b731e9905 )
        {
            if ( opened_door.script_flag_set == door.script_flag_set )
            {
                door.path[ 0 ] = undefined;
                
                if ( isint( 0 ) )
                {
                    function_cdc669dbc8ea2101( door.path );
                }
                
                clear_objective_marks( objective_marks );
                
                if ( door.path.size <= 0 )
                {
                    return;
                }
                
                paths_chosen = arraycombineunique( paths_chosen, [ door.path ] );
            }
        }
    }
    
    function_45750fc2b2afc77b( paths_chosen );
}

// Namespace namespace_a7211835085600d5
// Params 1, eflags: 0x4
// Checksum 0x4c61ba9e, Offset: 0x8cc
// Size: 0xa1
function private function_ee02c937eb2e96e1( script_flag_set )
{
    doors = [];
    
    foreach ( door in level.a_s_doorbuys )
    {
        if ( door.script_flag_set == script_flag_set )
        {
            doors[ doors.size ] = door;
        }
    }
    
    return doors;
}

// Namespace namespace_a7211835085600d5
// Params 3
// Checksum 0xe3e3270, Offset: 0x976
// Size: 0xbd
function knockback_nearby_players( origin, radius, force )
{
    nearby_players = getplayersinradius( origin, radius );
    
    foreach ( player in nearby_players )
    {
        knockback = vectornormalize( player.origin - origin );
        player knockback( knockback, force );
    }
}

// Namespace namespace_a7211835085600d5
// Params 1
// Checksum 0x634914fa, Offset: 0xa3b
// Size: 0x36
function wait_rounds( rounds )
{
    for ( i = 0; i < rounds ; i++ )
    {
        level waittill( #"on_round_end" );
        wait 1;
    }
}

// Namespace namespace_a7211835085600d5
// Params 2
// Checksum 0xff6d99b9, Offset: 0xa79
// Size: 0x85, Type: bool
function function_47c84fef8317b8f1( a, b )
{
    a_sum = a.origin[ 0 ] + a.origin[ 1 ] + a.origin[ 2 ];
    b_sum = b.origin[ 0 ] + b.origin[ 1 ] + b.origin[ 2 ];
    return a_sum > b_sum;
}

// Namespace namespace_a7211835085600d5
// Params 2
// Checksum 0x6038214d, Offset: 0xb07
// Size: 0x1ba
function function_e524e3a82390272( origin, radius )
{
    level endon( #"game_ended" );
    var_5da372bdcdfd7eb7 = function_15c22b3b8fb5cfa8( origin, radius );
    
    foreach ( equipment in var_5da372bdcdfd7eb7 )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            equipment childthread utility::callsharedfunc( #"mini_sentry", #"destroy" );
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment childthread dawg::dawg_self_destruct();
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment notify( #"kill_turret", 1, 1, 0, 1 );
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment childthread utility::callsharedfunc( #"killstreak_rcxd", #"explode" );
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            equipment childthread smart_seeker::function_16e1c3f278107106();
        }
    }
}

// Namespace namespace_a7211835085600d5
// Params 2, eflags: 0x4
// Checksum 0xd3725db, Offset: 0xcc9
// Size: 0x169
function private function_15c22b3b8fb5cfa8( origin, radius )
{
    equipment_in_level = level.activekillstreaks;
    equipment_in_level = arraycombineunique( equipment_in_level, weapon::function_3aafcaf7ff6dea9e() );
    
    if ( !equipment_in_level || equipment_in_level.size < 1 )
    {
        return;
    }
    
    equipment_in_level = sortbydistancecullbyradius( equipment_in_level, origin, radius );
    var_5da372bdcdfd7eb7 = [];
    
    foreach ( equipment in equipment_in_level )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
        }
    }
    
    return var_5da372bdcdfd7eb7;
}

// Namespace namespace_a7211835085600d5
// Params 3
// Checksum 0xe48e1cc3, Offset: 0xe3b
// Size: 0x162
function function_d5a2c6e5a0e2040e( item, var_95b3a4fa478b8c5c, rumble_medium )
{
    level endon( #"game_ended" );
    
    while ( isdefined( item ) )
    {
        frequency = 0.7;
        
        foreach ( player in level.players )
        {
            var_fc87d1de1dc1a06b = distancesquared( player.origin, item.origin );
            
            if ( var_fc87d1de1dc1a06b < squared( 80 ) )
            {
                player playrumbleonentity( rumble_medium );
                player.var_2a010bf55f972ee3 = rumble_medium;
                frequency = 0.35;
                continue;
            }
            
            if ( var_fc87d1de1dc1a06b < squared( 220 ) )
            {
                player playrumbleonentity( var_95b3a4fa478b8c5c );
                player.var_2a010bf55f972ee3 = var_95b3a4fa478b8c5c;
                continue;
            }
            
            if ( var_fc87d1de1dc1a06b >= squared( 80 ) && player.var_2a010bf55f972ee3 )
            {
                player stoprumble( player.var_2a010bf55f972ee3 );
                player.var_2a010bf55f972ee3 = undefined;
            }
        }
        
        wait frequency;
    }
}

// Namespace namespace_a7211835085600d5
// Params 0
// Checksum 0xf4c3e97e, Offset: 0xfa5
// Size: 0xba
function function_d2a0d54ef47ef9bb()
{
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    setdvarifuninitialized( @"hash_614c73605c999a65", "directed_mode_timetravel" );
    setdvarifuninitialized( @"hash_2185a348d3e2a74b", 0 );
    setdvarifuninitialized( @"hash_cae386dc274b4c2e", "papq_truck_keys_picked_up" );
    setdvarifuninitialized( @"hash_aa5de2f19d89c8a2", "directed_mode_deactivate_timewarps" );
    setdvarifuninitialized( @"hash_a76bba0bd306ca6", 0 );
    setdvarifuninitialized( @"hash_2cd8051593e6964a", 15 );
    setdvarifuninitialized( @"hash_d37b2335f30a90f", 75 );
    setdvarifuninitialized( @"hash_5964fab32d307bc3", 3 );
    setdvarifuninitialized( @"hash_876eeec0635806b8", 0.003 );
    setdvarifuninitialized( @"hash_931d69cae570f208", 0.5 );
}

// Namespace namespace_a7211835085600d5
// Params 3
// Checksum 0x940308a6, Offset: 0x1067
// Size: 0xe8
function function_670daf9bf33064ab( quest_ref, guidance_quest_ref, guidance_steps )
{
    thread function_9c1a5158b8a94595( guidance_quest_ref );
    
    foreach ( guidance_step in guidance_steps )
    {
        quest_step = zm_quest::get_quest_step( quest_ref, guidance_step.step_ref );
        
        if ( quest_step.completed )
        {
            continue;
        }
        
        quest_step childthread [[ guidance_step.execute ]]();
        quest_step waittill( #"hash_2c4eefaf7e2b24b6" );
        clear_objective_marks( guidance_quest_ref );
        wait 1;
    }
}

// Namespace namespace_a7211835085600d5
// Params 1, eflags: 0x4
// Checksum 0xe354318c, Offset: 0x1157
// Size: 0x22
function private function_9c1a5158b8a94595( guidance_quest_ref )
{
    level utility::waittill_any( "start_boss_fight" );
    clear_objective_marks( guidance_quest_ref );
}

