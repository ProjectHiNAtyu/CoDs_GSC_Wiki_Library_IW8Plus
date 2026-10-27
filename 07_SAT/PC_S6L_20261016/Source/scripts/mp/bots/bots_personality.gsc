// scripts\mp\bots\bots_personality.gsc  (hash_1aaa79412e7bc206.gscc) (size: 16429 Bytes / 0x402d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe66cff9c (3865903004)
// size ...... 16429 (0x402d)
// includes .. 10  (offset: 0x3c55)
// strings ... 50  (offset: 0x3ca5)
// dev strs .. 9   (offset: 0x3f9d)
// exports ... 26  (offset: 0x29f1)
// cseg ...... 0x3c8 + 0x2629 (0x29f1)
// imports ... 115 (offset: 0x2e01)
// animtree1 . 0   (offset: 0x402d)
// animtree2 . 0   (offset: 0x402d)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\common\utility\player;

#namespace bots_personality;

// Namespace bots_personality
// Params 0
// Checksum 0xf5dbc951, Offset: 0x3e6
// Size: 0x1ee
function setup_personalities()
{
    level.bot_personality = [];
    level.bot_personality_list = [];
    level.bot_personality[ "active" ][ 0 ] = "run_and_gun";
    level.bot_personality[ "active" ][ 1 ] = "cqb";
    level.bot_personality[ "stationary" ][ 0 ] = "camper";
    level.bot_personality_type = [];
    
    foreach ( index, personality_array in level.bot_personality )
    {
        foreach ( personality in personality_array )
        {
            level.bot_personality_type[ personality ] = index;
            level.bot_personality_list[ level.bot_personality_list.size ] = personality;
        }
    }
    
    level.bot_personality_types_desired = [];
    level.bot_personality_types_desired[ "active" ] = 4;
    level.bot_personality_types_desired[ "stationary" ] = 1;
    level.bot_pers_init = [];
    level.bot_pers_init[ "run_and_gun" ] = &init_personality_default;
    level.bot_pers_init[ "camper" ] = &init_personality_camper;
    level.bot_pers_update[ "run_and_gun" ] = &update_personality_default;
    level.bot_pers_update[ "camper" ] = &update_personality_camper;
}

// Namespace bots_personality
// Params 0
// Checksum 0x1a2dfe6, Offset: 0x5dc
// Size: 0xd8
function bot_assign_personality_functions()
{
    self.personality = self botgetpersonality();
    self.pers[ "personality" ] = self.personality;
    self.personality_init_function = level.bot_pers_init[ self.personality ];
    
    if ( !isdefined( self.personality_init_function ) )
    {
        self.personality_init_function = level.bot_pers_init[ "run_and_gun" ];
    }
    
    self [[ self.personality_init_function ]]();
    
    if ( isdefined( self.custom_personality_update_function ) )
    {
        self.personality_update_function = self.custom_personality_update_function;
    }
    else
    {
        self.personality_update_function = level.bot_pers_update[ self.personality ];
    }
    
    if ( !isdefined( self.personality_update_function ) )
    {
        self.personality_update_function = level.bot_pers_update[ "run_and_gun" ];
    }
}

// Namespace bots_personality
// Params 0
// Checksum 0xd0c4b79c, Offset: 0x6bc
// Size: 0x649
function function_e29000cf21a9c3be()
{
    if ( self.has_balanced_personality || self.var_9bb25959617b9a1c )
    {
        return;
    }
    
    my_team = self.team ?? self.pers[ "team" ];
    assert( isdefined( my_team ) );
    assert( level.bot_personality.size == level.bot_personality_types_desired.size );
    var_6061d7aa05513fdc = getarraykeys( level.bot_personality_types_desired );
    perscounts = [];
    var_781f249346139817 = [];
    
    foreach ( personality_type, personality_array in level.bot_personality )
    {
        var_781f249346139817[ personality_type ] = 0;
        
        foreach ( personality in personality_array )
        {
            perscounts[ personality ] = 0;
        }
    }
    
    foreach ( participant in level.participants )
    {
        if ( participant == self )
        {
            continue;
        }
        
        if ( !( isautopilot( participant ) || isbot( participant ) ) )
        {
            continue;
        }
        
        if ( !game_utility_common::isteamparticipant( participant ) )
        {
            continue;
        }
        
        if ( !participant.has_balanced_personality || !participant.var_9bb25959617b9a1c )
        {
            continue;
        }
        
        participant_team = participant.team ?? participant.pers[ "team" ];
        
        if ( participant_team == my_team || !level.teambased )
        {
            personality = participant botgetpersonality();
            personality_type = level.bot_personality_type[ personality ];
            perscounts[ personality ] += 1;
            var_781f249346139817[ personality_type ] += 1;
        }
    }
    
    var_82c696833ec7bd0a = [];
    
    foreach ( type in var_6061d7aa05513fdc )
    {
        var_82c696833ec7bd0a[ type ] = int( var_781f249346139817[ type ] / level.bot_personality_types_desired[ type ] );
    }
    
    type_needed = undefined;
    
    for ( i = 0; i < var_6061d7aa05513fdc.size && !isdefined( type_needed ) ; i++ )
    {
        pers_type_i = var_6061d7aa05513fdc[ i ];
        var_401f2a03b34caa13 = 1;
        
        for ( j = 0; j < var_6061d7aa05513fdc.size ; j++ )
        {
            var_567fd14100a8f466 = var_6061d7aa05513fdc[ j ];
            
            if ( pers_type_i != var_567fd14100a8f466 )
            {
                if ( var_82c696833ec7bd0a[ pers_type_i ] >= var_82c696833ec7bd0a[ var_567fd14100a8f466 ] )
                {
                    var_401f2a03b34caa13 = 0;
                }
            }
        }
        
        if ( var_401f2a03b34caa13 )
        {
            type_needed = pers_type_i;
        }
    }
    
    if ( !isdefined( type_needed ) )
    {
        var_270ea48d32761d18 = [];
        
        foreach ( type in var_6061d7aa05513fdc )
        {
            var_270ea48d32761d18[ type ] = level.bot_personality_types_desired[ type ] - var_781f249346139817[ type ] % level.bot_personality_types_desired[ type ];
        }
        
        total_weight = 0;
        
        foreach ( type in var_6061d7aa05513fdc )
        {
            total_weight += var_270ea48d32761d18[ type ];
        }
        
        random_choice = randomfloat( total_weight );
        
        foreach ( type in var_6061d7aa05513fdc )
        {
            if ( random_choice < var_270ea48d32761d18[ type ] )
            {
                type_needed = type;
                break;
            }
            
            random_choice -= var_270ea48d32761d18[ type ];
        }
    }
    
    personality_needed = undefined;
    var_5151e4d016fb3fb2 = undefined;
    var_21cefba8b0c69497 = 9999;
    var_716ab0377452e32d = -9999;
    var_12f1726625d4d7f8 = arrayrandomize( level.bot_personality[ type_needed ] );
    
    foreach ( personality in var_12f1726625d4d7f8 )
    {
        if ( perscounts[ personality ] < var_21cefba8b0c69497 )
        {
            var_5151e4d016fb3fb2 = personality;
            var_21cefba8b0c69497 = perscounts[ personality ];
        }
        
        if ( perscounts[ personality ] > var_716ab0377452e32d )
        {
            var_716ab0377452e32d = perscounts[ personality ];
        }
    }
    
    if ( var_716ab0377452e32d - var_21cefba8b0c69497 >= 2 )
    {
        personality_needed = var_5151e4d016fb3fb2;
    }
    else
    {
        personality_needed = utility::array_random( level.bot_personality[ type_needed ] );
    }
    
    self.has_balanced_personality = 1;
    return personality_needed;
}

// Namespace bots_personality
// Params 0
// Checksum 0x3e4c3727, Offset: 0xd0e
// Size: 0x9
function init_personality_camper()
{
    clear_camper_data();
}

// Namespace bots_personality
// Params 0
// Checksum 0x788a58a5, Offset: 0xd1f
// Size: 0x9
function init_personality_default()
{
    clear_camper_data();
}

// Namespace bots_personality
// Params 0
// Checksum 0xf9645bf2, Offset: 0xd30
// Size: 0x2d0
function update_personality_camper()
{
    self endon( #"start_scripted_mode" );
    
    if ( should_select_new_ambush_point() && !namespace_14346d439f44a158::is_defending() && !bots_util::bot_is_remote_or_linked() )
    {
        goaltype = self botgetscriptgoaltype();
        var_14d53ef8360e6e6d = 0;
        
        if ( !isdefined( self.camper_time_started_hunting ) )
        {
            self.camper_time_started_hunting = 0;
        }
        
        is_hunting = goaltype == "hunt";
        var_2a3d762879c8271e = gettime() > self.camper_time_started_hunting + 10000;
        
        if ( ( !is_hunting || var_2a3d762879c8271e ) && !bots_util::bot_out_of_ammo() )
        {
            if ( !self bothasscriptgoal() )
            {
                function_b3eb4967dba60db9( "update_personality_camper" );
            }
            
            if ( isdefined( level.override_find_camp_tacpoint ) )
            {
                var_14d53ef8360e6e6d = [[ level.override_find_camp_tacpoint ]]();
            }
            
            if ( !var_14d53ef8360e6e6d )
            {
                var_14d53ef8360e6e6d = find_camp_tacpoint( "update_personality_camper" );
                
                if ( !var_14d53ef8360e6e6d )
                {
                    self.camper_time_started_hunting = gettime();
                }
            }
        }
        
        if ( var_14d53ef8360e6e6d )
        {
            self.ambush_entrances = bots_util::bot_queued_process( "update_personality_camper -> find ambush entrances", "bot_find_ambush_entrances", &bot_find_ambush_entrances, self.var_624c9f3d7225954, 1 );
            
            if ( self.ambush_entrances.size == 0 )
            {
                self.camper_time_started_hunting = gettime();
                clear_camper_data();
                return;
            }
            
            trap_item = bots_strategy::function_c6152abaead059f6( [ "trap_directional", "trap", "trap_activate" ] );
            
            if ( isdefined( trap_item ) )
            {
                traptime = gettime();
                bots_strategy::bot_set_ambush_trap( trap_item, self.ambush_entrances, self.var_624c9f3d7225954, self.ambush_yaw );
                traptime = gettime() - traptime;
                
                if ( traptime > 0 && isdefined( self.ambush_end ) && isdefined( self.var_624c9f3d7225954 ) )
                {
                    self.ambush_end += traptime;
                    self.var_624c9f3d7225954.bot_ambush_end = self.ambush_end + 10000;
                }
            }
            
            if ( !bots_tactical_goals::has_tactical_goal() && !namespace_14346d439f44a158::is_defending() && isdefined( self.var_624c9f3d7225954 ) )
            {
                set_goal = self botsetscriptgoal( self.var_624c9f3d7225954, 0, "camp", self.ambush_yaw );
                
                if ( set_goal )
                {
                    childthread clear_script_goal_on( "bad_path", "out_of_ammo" );
                    childthread watch_out_of_ammo();
                    childthread bot_add_ambush_time_delayed( "clear_camper_data", "goal" );
                    childthread bot_watch_entrances_delayed( "clear_camper_data", "bot_add_ambush_time_delayed", self.ambush_entrances, self.ambush_yaw );
                }
                else
                {
                    clear_camper_data();
                }
            }
            
            return;
        }
        
        if ( goaltype == "camp" )
        {
            self botclearscriptgoal();
        }
        
        update_personality_default();
    }
}

// Namespace bots_personality
// Params 0
// Checksum 0xb19a44fe, Offset: 0x1008
// Size: 0x45e
function update_personality_default()
{
    self endon( #"start_scripted_mode" );
    script_goal = undefined;
    var_eabf7a316fa7ceea = self bothasscriptgoal();
    
    if ( var_eabf7a316fa7ceea )
    {
        script_goal = self botgetscriptgoal();
    }
    
    if ( !bots_tactical_goals::has_tactical_goal() && !bots_util::bot_is_remote_or_linked() )
    {
        distsq = undefined;
        goalradius = undefined;
        
        if ( var_eabf7a316fa7ceea )
        {
            distsq = distancesquared( self.origin, script_goal );
            goalradius = self botgetscriptgoalradius();
            goalradiusdbl = goalradius * 2;
            
            if ( isdefined( self.bot_memory_goal ) && distsq < goalradiusdbl * goalradiusdbl )
            {
                var_833fe842656d9569 = botmemoryflags( "investigated" );
                botflagmemoryevents( 0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, goalradiusdbl, "kill", var_833fe842656d9569, self );
                botflagmemoryevents( 0, gettime() - self.bot_memory_goal_time, 1, self.bot_memory_goal, goalradiusdbl, "death", var_833fe842656d9569, self );
                self.bot_memory_goal = undefined;
                self.bot_memory_goal_time = undefined;
            }
        }
        
        if ( !var_eabf7a316fa7ceea || distsq < goalradius * goalradius )
        {
            set_random_path = function_b3eb4967dba60db9( "update_personality_default 1" );
            original_goal_pos = undefined;
            original_goal_type = undefined;
            
            if ( set_random_path )
            {
                original_goal_pos = self botgetscriptgoal();
                original_goal_type = self botgetscriptgoaltype();
            }
            
            var_cce7eae1cbadab30 = 25;
            
            if ( self function_4a416cbec96dbbcf() || self function_40704e1fc9df1a06() )
            {
                var_cce7eae1cbadab30 = 100;
            }
            
            if ( set_random_path && randomfloat( 100 ) < var_cce7eae1cbadab30 )
            {
                trap_item = bots_strategy::function_c6152abaead059f6( [ "trap_directional", "trap" ] );
                
                if ( isdefined( trap_item ) )
                {
                    goal_tac = self function_2ce9558d679a85ff();
                    
                    if ( !isdefined( goal_tac ) )
                    {
                        goal_tac = findclosesttacpointinsight( self botgetscriptgoal() );
                    }
                    
                    nearest_tac = self getnearesttacpoint();
                    
                    if ( isdefined( goal_tac ) && isdefined( nearest_tac ) && isdefined( goal_tac.var_e94b81e2231e2a9 ) && isdefined( nearest_tac.var_e94b81e2231e2a9 ) )
                    {
                        zonepath = getnodesonpath( nearest_tac.var_e94b81e2231e2a9, goal_tac.var_e94b81e2231e2a9 );
                        
                        if ( !isdefined( zonepath ) || zonepath.size == 0 )
                        {
                            assertmsg( "<dev string:x24>" + nearest_tac.navzoneindex + "<dev string:x47>" + getzoneorigin( nearest_tac.navzoneindex ) + "<dev string:x53>" + goal_tac.navzoneindex + "<dev string:x47>" + getzoneorigin( goal_tac.navzoneindex ) + "<dev string:x5d>" + "<dev string:x60>" );
                            return;
                        }
                        
                        var_cdd4a880167f31b = [];
                        centerindex = int( zonepath.size / 2 );
                        curoffset = 0;
                        var_3b5b70630cadd294 = 0;
                        
                        while ( var_cdd4a880167f31b.size < zonepath.size )
                        {
                            nextindex = centerindex + curoffset;
                            
                            if ( isdefined( zonepath[ nextindex ] ) )
                            {
                                var_cdd4a880167f31b[ var_cdd4a880167f31b.size ] = zonepath[ nextindex ];
                            }
                            
                            var_3b5b70630cadd294 = int( ( abs( var_3b5b70630cadd294 ) + 1 ) * -1 * utility::sign( var_3b5b70630cadd294 ) );
                            curoffset += var_3b5b70630cadd294;
                        }
                        
                        zone_picked = utility::random_weight_sorted( var_cdd4a880167f31b );
                        var_a422bca110805843 = getzonetacpoints( getzoneindexforzonenode( zone_picked ) );
                        
                        if ( var_a422bca110805843.size > 0 )
                        {
                            var_20cf3c3a21d5f0db = utility::array_random( var_a422bca110805843 );
                            ambush_entrances = bots_util::bot_queued_process( "update_personality_default -> find ambush entrances", "bot_find_ambush_entrances", &bot_find_ambush_entrances, var_20cf3c3a21d5f0db, 0 );
                            
                            if ( ambush_entrances.size > 0 )
                            {
                                set_trap = bots_strategy::bot_set_ambush_trap( trap_item, ambush_entrances, var_20cf3c3a21d5f0db );
                                
                                if ( !isdefined( set_trap ) || set_trap )
                                {
                                    self botclearscriptgoal();
                                    set_random_path = function_b3eb4967dba60db9( "update_personality_default 2" );
                                    
                                    if ( set_random_path )
                                    {
                                        original_goal_pos = self botgetscriptgoal();
                                        original_goal_type = self botgetscriptgoaltype();
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            if ( set_random_path && self bothasscriptgoal() )
            {
                current_goal_pos = self botgetscriptgoal();
                current_goal_type = self botgetscriptgoaltype();
                same_goal_pos = bots_util_mp::bot_vectors_are_equal( original_goal_pos, current_goal_pos );
                same_goal_type = original_goal_type == current_goal_type;
                
                if ( same_goal_pos && same_goal_type )
                {
                    childthread clear_script_goal_on( "enemy", "bad_path", "goal", "search_end" );
                }
            }
        }
    }
}

// Namespace bots_personality
// Params 5
// Checksum 0x9c199da0, Offset: 0x146e
// Size: 0x12d
function clear_script_goal_on( event1, event2, event3, event4, event5 )
{
    self notify( #"clear_script_goal_on" );
    self endon( #"clear_script_goal_on" );
    self endon( #"death_or_disconnect" );
    self endon( #"start_tactical_goal" );
    assert( self bothasscriptgoal(), "<dev string:xc6>" );
    goal_at_start = self botgetscriptgoal();
    keep_looping = 1;
    
    while ( keep_looping )
    {
        result = utility::waittill_any_return( event1, event2, event3, event4, event5, "script_goal_changed" );
        keep_looping = 0;
        var_d086203761b93873 = 1;
        
        if ( result == "goal" || result == "script_goal_changed" )
        {
            if ( !self bothasscriptgoal() )
            {
                var_d086203761b93873 = 0;
            }
            else
            {
                var_f4c30d58c3e65 = self botgetscriptgoal();
                var_d086203761b93873 = bots_util_mp::bot_vectors_are_equal( goal_at_start, var_f4c30d58c3e65 );
            }
        }
        
        if ( result == "enemy" && isdefined( self.enemy ) )
        {
            var_d086203761b93873 = 0;
            keep_looping = 1;
        }
        
        if ( var_d086203761b93873 )
        {
            self botclearscriptgoal();
        }
    }
}

// Namespace bots_personality
// Params 0
// Checksum 0x66191ac1, Offset: 0x15a3
// Size: 0x45
function watch_out_of_ammo()
{
    self notify( #"watch_out_of_ammo" );
    self endon( #"watch_out_of_ammo" );
    self endon( #"death_or_disconnect" );
    
    while ( !bots_util::bot_out_of_ammo() )
    {
        wait 0.5;
    }
    
    self notify( #"out_of_ammo" );
}

// Namespace bots_personality
// Params 2
// Checksum 0xa7dd641f, Offset: 0x15f0
// Size: 0xcd
function bot_add_ambush_time_delayed( endevent, waitfor )
{
    self notify( #"bot_add_ambush_time_delayed" );
    self endon( #"bot_add_ambush_time_delayed" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( endevent ) )
    {
        self endon( endevent );
    }
    
    self endon( #"bad_path" );
    starttime = gettime();
    
    if ( isdefined( waitfor ) )
    {
        self waittill( waitfor );
    }
    
    if ( isdefined( self.ambush_end ) && isdefined( self.var_624c9f3d7225954 ) )
    {
        self.ambush_end += gettime() - starttime;
        self.var_624c9f3d7225954.bot_ambush_end = self.ambush_end + 10000;
    }
    
    self notify( #"bot_add_ambush_time_delayed" );
}

// Namespace bots_personality
// Params 4
// Checksum 0xcf4b0abe, Offset: 0x16c5
// Size: 0xa3
function bot_watch_entrances_delayed( endevent, waitfor, entrances, yaw )
{
    self notify( #"bot_watch_entrances_delayed" );
    
    if ( entrances.size > 0 )
    {
        self endon( #"bot_watch_entrances_delayed" );
        self endon( #"death_or_disconnect" );
        self endon( #"exit_autopilot" );
        self endon( endevent );
        self endon( #"bad_path" );
        
        if ( isdefined( waitfor ) )
        {
            self waittill( waitfor );
        }
        
        self endon( #"path_enemy" );
        childthread bots_util_mp::bot_watch_tacpoints( entrances, yaw, 0, self.ambush_end );
        childthread bot_monitor_watch_entrances_camp();
    }
}

// Namespace bots_personality
// Params 0
// Checksum 0x8db855f3, Offset: 0x1770
// Size: 0x127
function bot_monitor_watch_entrances_camp()
{
    self notify( #"bot_monitor_watch_entrances_camp" );
    self endon( #"bot_monitor_watch_entrances_camp" );
    self notify( #"bot_monitor_watch_entrances" );
    self endon( #"bot_monitor_watch_entrances" );
    self endon( #"bot_watch_tacpoints_stop" );
    self endon( #"death_or_disconnect" );
    
    while ( !isdefined( self.watch_tacpoints ) )
    {
        wait 0.05;
    }
    
    while ( isdefined( self.watch_tacpoints ) )
    {
        foreach ( tacpoint in self.watch_tacpoints )
        {
            tacpoint.watch_tacpoint_chance[ self.entity_number ] = tacpoint.var_40758809a01da5b5[ self.entity_number ];
        }
        
        bots_util_mp::function_d041b15a08f29830( 0.5 );
        wait randomfloatrange( 0.5, 0.75 );
    }
}

// Namespace bots_personality
// Params 2
// Checksum 0xcf19cda7, Offset: 0x189f
// Size: 0x136
function bot_find_ambush_entrances( ambush_tacpoint, var_dd6fd797b22681ae )
{
    self endon( #"death_or_disconnect" );
    useentrances = [];
    entrances = findentrances( ambush_tacpoint );
    
    if ( entrances.size > 0 )
    {
        wait 0.05;
        
        if ( var_dd6fd797b22681ae )
        {
            entrances = self bottacpointscoremultiple( entrances, "exposure_vis", ambush_tacpoint.groundpos, "crouch" );
        }
        
        foreach ( tacpoint in entrances )
        {
            if ( distancesquared( self.origin, tacpoint.groundpos ) < 90000 )
            {
                continue;
            }
            
            if ( var_dd6fd797b22681ae )
            {
                wait 0.05;
                
                if ( !bots_util_mp::entrance_visible_from( tacpoint.groundpos, ambush_tacpoint.groundpos, "crouch" ) )
                {
                    continue;
                }
            }
            
            useentrances[ useentrances.size ] = tacpoint;
        }
    }
    
    return useentrances;
}

// Namespace bots_personality
// Params 1
// Checksum 0x3ced6bf7, Offset: 0x19de
// Size: 0x90
function bot_filter_ambush_inuse( tacpoints )
{
    assert( isdefined( tacpoints ) );
    resulttacpoints = [];
    now = gettime();
    tacpointssize = tacpoints.size;
    
    for ( i = 0; i < tacpointssize ; i++ )
    {
        tacpoint = tacpoints[ i ];
        
        if ( !isdefined( tacpoint.bot_ambush_end ) || now > tacpoint.bot_ambush_end )
        {
            resulttacpoints[ resulttacpoints.size ] = tacpoint;
        }
    }
    
    return resulttacpoints;
}

// Namespace bots_personality
// Params 3
// Checksum 0xf57b310b, Offset: 0x1a77
// Size: 0x1c9
function bot_filter_ambush_vicinity( tacpoints, bot, radius )
{
    resulttacpoints = [];
    checkpoints = [];
    radiussq = radius * radius;
    
    if ( level.teambased )
    {
        foreach ( player in level.participants )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( player.team == bot.team && player != bot && isdefined( player.var_624c9f3d7225954 ) )
            {
                checkpoints[ checkpoints.size ] = player.var_624c9f3d7225954.groundpos;
            }
        }
    }
    
    checkpointssize = checkpoints.size;
    tacpointssize = tacpoints.size;
    
    for ( i = 0; i < tacpointssize ; i++ )
    {
        tooclose = 0;
        tacpoint = tacpoints[ i ];
        
        for ( j = 0; !tooclose && j < checkpointssize ; j++ )
        {
            distsq = distancesquared( checkpoints[ j ], tacpoint.groundpos );
            tooclose = distsq < radiussq;
        }
        
        if ( !tooclose )
        {
            resulttacpoints[ resulttacpoints.size ] = tacpoint;
        }
    }
    
    return resulttacpoints;
}

// Namespace bots_personality
// Params 0
// Checksum 0x4c9a0c58, Offset: 0x1c49
// Size: 0x8b
function clear_camper_data()
{
    self notify( #"clear_camper_data" );
    
    if ( isdefined( self.var_624c9f3d7225954 ) && isdefined( self.var_624c9f3d7225954.bot_ambush_end ) )
    {
        self.var_624c9f3d7225954.bot_ambush_end = undefined;
    }
    
    self.var_624c9f3d7225954 = undefined;
    self.point_to_ambush = undefined;
    self.ambush_yaw = undefined;
    self.ambush_entrances = undefined;
    self.ambush_duration = randomintrange( 20000, 30000 );
    self.ambush_end = -1;
}

// Namespace bots_personality
// Params 0
// Checksum 0x5947bb1f, Offset: 0x1cdc
// Size: 0x2e, Type: bool
function should_select_new_ambush_point()
{
    if ( bots_tactical_goals::has_tactical_goal() )
    {
        return false;
    }
    
    if ( gettime() > self.ambush_end )
    {
        return true;
    }
    
    if ( !self bothasscriptgoal() )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_personality
// Params 1
// Checksum 0x155b9632, Offset: 0x1d13
// Size: 0x36
function find_camp_tacpoint( source )
{
    self notify( #"find_camp_tacpoint" );
    self endon( #"find_camp_tacpoint" );
    return bots_util::bot_queued_process( source, "find_camp_tacpoint_worker", &find_camp_tacpoint_worker );
}

// Namespace bots_personality
// Params 1
// Checksum 0xebe725f0, Offset: 0x1d52
// Size: 0x33, Type: bool
function function_e432984589c28ba4( zoneindex )
{
    auto_zone_node = getzonenodeforzoneindex( zoneindex );
    linked_zone_nodes = getlinkednodes( auto_zone_node );
    return linked_zone_nodes.size == 0;
}

// Namespace bots_personality
// Params 0
// Checksum 0xe3bf9718, Offset: 0x1d8e
// Size: 0x61e, Type: bool
function find_camp_tacpoint_worker()
{
    self notify( #"find_camp_tacpoint_worker" );
    self endon( #"find_camp_tacpoint_worker" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    clear_camper_data();
    
    if ( getzonecount() <= 0 )
    {
        return false;
    }
    
    mytacpoint = self getnearesttacpoint();
    
    if ( !isdefined( mytacpoint ) )
    {
        return false;
    }
    
    myzone = mytacpoint.navzoneindex;
    targetzoneindex = undefined;
    nextzoneindex = undefined;
    faceangles = self getplayerangles();
    
    if ( isdefined( myzone ) && myzone != -1 )
    {
        var_5be8d50723cef7d9 = int( ceil( function_3b1eaad892314d98() / function_cffa80e118ebdb89() ) );
        var_8898f77bd6bd9274 = botzonenearestcount( myzone, self.team, var_5be8d50723cef7d9, "enemy_predict", ">", 0, "ally", "<", 1 );
        
        if ( !isdefined( var_8898f77bd6bd9274 ) )
        {
            var_8898f77bd6bd9274 = botzonenearestcount( myzone, self.team, var_5be8d50723cef7d9, "enemy_predict", ">", 0 );
        }
        
        if ( isdefined( var_8898f77bd6bd9274 ) && function_e432984589c28ba4( var_8898f77bd6bd9274 ) )
        {
            var_8898f77bd6bd9274 = undefined;
        }
        
        if ( !isdefined( var_8898f77bd6bd9274 ) )
        {
            furthestdist = -1;
            furthestzone = -1;
            var_355e19d5d838f3c1 = function_5a0bc874a4a08aa1( mytacpoint.navzoneindex );
            count = 0;
            
            foreach ( zone in var_355e19d5d838f3c1 )
            {
                if ( function_e432984589c28ba4( zone ) )
                {
                    continue;
                }
                
                var_b02d894657cce306 = getzonenodeforzoneindex( myzone );
                var_9fc5a521c89c9a4 = getzonenodeforzoneindex( zone );
                zonepath = getnodesonpath( var_b02d894657cce306, var_9fc5a521c89c9a4 );
                
                if ( !isdefined( zonepath ) || zonepath.size == 0 )
                {
                    continue;
                }
                
                var_7df56b9dfd7f7ac5 = distancesquared( getzoneorigin( zone ), self.origin );
                
                if ( var_7df56b9dfd7f7ac5 > furthestdist )
                {
                    furthestdist = var_7df56b9dfd7f7ac5;
                    furthestzone = zone;
                }
                
                count++;
                
                if ( count >= 10 )
                {
                    waitframe();
                    count = 0;
                }
            }
            
            if ( furthestzone >= 0 )
            {
                var_8898f77bd6bd9274 = furthestzone;
            }
        }
        
        if ( !isdefined( var_8898f77bd6bd9274 ) )
        {
            assertmsg( "<dev string:xff>" + myzone + "<dev string:x47>" + getzoneorigin( myzone ) + "<dev string:x5d>" + "<dev string:x129>" );
            return false;
        }
        
        var_b02d894657cce306 = getzonenodeforzoneindex( myzone );
        var_352f4e66faff74b8 = getzonenodeforzoneindex( var_8898f77bd6bd9274 );
        zonepath = getnodesonpath( var_b02d894657cce306, var_352f4e66faff74b8 );
        
        if ( !isdefined( zonepath ) || zonepath.size == 0 )
        {
            assertmsg( "<dev string:x24>" + myzone + "<dev string:x47>" + getzoneorigin( myzone ) + "<dev string:x53>" + var_8898f77bd6bd9274 + "<dev string:x47>" + getzoneorigin( var_8898f77bd6bd9274 ) + "<dev string:x5d>" + "<dev string:x60>" );
            return false;
        }
        
        for ( index = 0; index <= int( zonepath.size / 2 ) ; index++ )
        {
            var_82706b543826cb95 = zonepath[ index ];
            var_2af7ab97216c71b5 = zonepath[ int( min( index + 1, zonepath.size - 1 ) ) ];
            targetzoneindex = getzoneindexforzonenode( var_82706b543826cb95 );
            nextzoneindex = getzoneindexforzonenode( var_2af7ab97216c71b5 );
            
            if ( botzonegetcount( nextzoneindex, self.team, "enemy_predict" ) != 0 )
            {
                break;
            }
        }
        
        if ( isdefined( targetzoneindex ) && isdefined( nextzoneindex ) && targetzoneindex != nextzoneindex )
        {
            face_dir = getzoneorigin( nextzoneindex ) - getzoneorigin( targetzoneindex );
            faceangles = vectortoangles( face_dir );
        }
    }
    
    var_4b4b402fd00ea7f4 = undefined;
    
    if ( isdefined( targetzoneindex ) )
    {
        keep_searching = 1;
        var_8d265da4082df1ec = 0;
        
        while ( keep_searching )
        {
            max_zone_dist = 800;
            var_6cd6595c2127b5c0 = function_1e2acfbcb6aee49e( targetzoneindex, max_zone_dist, 1, undefined, 1, 1 );
            waitframe();
            
            if ( var_6cd6595c2127b5c0 > botgetmaxnumscoreitems() )
            {
                max_zone_dist = 600;
                var_6cd6595c2127b5c0 = function_1e2acfbcb6aee49e( targetzoneindex, max_zone_dist, 1, undefined, 1, 1 );
                waitframe();
            }
            
            if ( var_6cd6595c2127b5c0 > botgetmaxnumscoreitems() )
            {
                max_zone_dist = 400;
                var_6cd6595c2127b5c0 = function_1e2acfbcb6aee49e( targetzoneindex, max_zone_dist, 1, undefined, 1, 1 );
                waitframe();
            }
            
            if ( var_6cd6595c2127b5c0 > botgetmaxnumscoreitems() )
            {
                max_zone_dist = 200;
                var_6cd6595c2127b5c0 = function_1e2acfbcb6aee49e( targetzoneindex, max_zone_dist, 1, undefined, 1, 1 );
                waitframe();
            }
            
            var_e437ce7a9c5d8619 = undefined;
            
            if ( var_6cd6595c2127b5c0 <= botgetmaxnumscoreitems() )
            {
                var_e437ce7a9c5d8619 = function_1e2acfbcb6aee49e( targetzoneindex, max_zone_dist, 1, undefined, 1 );
            }
            else
            {
                var_e437ce7a9c5d8619 = getzonetacpoints( targetzoneindex );
                waitframe();
                var_e437ce7a9c5d8619 = bots_util::function_4eb61a3985ad712c( var_e437ce7a9c5d8619 );
            }
            
            waitframe();
            randomroll = randomint( 100 );
            
            if ( randomroll < 66 && randomroll >= 33 )
            {
                faceangles = ( faceangles[ 0 ], faceangles[ 1 ] + 45, 0 );
            }
            else if ( randomroll < 33 )
            {
                faceangles = ( faceangles[ 0 ], faceangles[ 1 ] - 45, 0 );
            }
            
            if ( var_e437ce7a9c5d8619.size > 0 )
            {
                selectcount = int( clamp( var_e437ce7a9c5d8619.size * 0.15, 1, 15 ) );
                
                if ( var_8d265da4082df1ec )
                {
                    var_e437ce7a9c5d8619 = self bottacpointpickmultiple( var_e437ce7a9c5d8619, selectcount, selectcount, "camp", anglestoforward( faceangles ), "lenient" );
                }
                else
                {
                    var_e437ce7a9c5d8619 = self bottacpointpickmultiple( var_e437ce7a9c5d8619, selectcount, selectcount, "camp", anglestoforward( faceangles ) );
                }
                
                var_e437ce7a9c5d8619 = bot_filter_ambush_inuse( var_e437ce7a9c5d8619 );
                
                if ( !self.can_camp_near_others )
                {
                    vicinity_radius = 800;
                    var_e437ce7a9c5d8619 = bot_filter_ambush_vicinity( var_e437ce7a9c5d8619, self, vicinity_radius );
                }
                
                if ( var_e437ce7a9c5d8619.size > 0 )
                {
                    var_4b4b402fd00ea7f4 = utility::random_weight_sorted( var_e437ce7a9c5d8619 );
                }
            }
            
            if ( isdefined( var_4b4b402fd00ea7f4 ) )
            {
                keep_searching = 0;
            }
            else if ( !var_8d265da4082df1ec )
            {
                var_8d265da4082df1ec = 1;
            }
            else
            {
                keep_searching = 0;
            }
            
            if ( keep_searching )
            {
                waitframe();
            }
        }
    }
    
    if ( !isdefined( var_4b4b402fd00ea7f4 ) )
    {
        return false;
    }
    
    self.var_624c9f3d7225954 = var_4b4b402fd00ea7f4;
    self.ambush_end = gettime() + self.ambush_duration;
    self.var_624c9f3d7225954.bot_ambush_end = self.ambush_end;
    self.ambush_yaw = faceangles[ 1 ];
    return true;
}

// Namespace bots_personality
// Params 2
// Checksum 0x73e8b541, Offset: 0x23b5
// Size: 0x1ed, Type: bool
function find_ambush_tacpoint( optional_point_to_ambush, optional_ambush_radius )
{
    clear_camper_data();
    
    if ( isdefined( optional_point_to_ambush ) )
    {
        self.point_to_ambush = optional_point_to_ambush;
    }
    else
    {
        tacpoint_to_ambush = undefined;
        var_3f4b399be4a15181 = function_a034a927128ada11( self.origin, 5000, 0, 2000 );
        
        if ( var_3f4b399be4a15181.size > 0 )
        {
            tacpoint_to_ambush = bots_util::function_ec1247a9311f67a4( "find_ambush_tacpoint -> tacpoint pick exposed", var_3f4b399be4a15181, var_3f4b399be4a15181.size * 0.25, "exposed" );
        }
        
        if ( isdefined( tacpoint_to_ambush ) )
        {
            self.point_to_ambush = tacpoint_to_ambush.groundpos;
        }
        else
        {
            return false;
        }
    }
    
    ambush_radius = 2000;
    
    if ( isdefined( optional_ambush_radius ) )
    {
        ambush_radius = optional_ambush_radius;
    }
    
    var_8e0a55e3e0103871 = function_a034a927128ada11( self.point_to_ambush, ambush_radius, 0, 1000, 1250 );
    ambush_tacpoint_trying = undefined;
    assert( isdefined( var_8e0a55e3e0103871 ) );
    
    if ( var_8e0a55e3e0103871.size > 0 )
    {
        selectcount = int( max( 1, int( var_8e0a55e3e0103871.size * 0.15 ) ) );
        var_8e0a55e3e0103871 = bots_util::function_75c1dc4534eb4f5d( "find_ambush_tacpoint -> tacpoint pick multiple ambush", var_8e0a55e3e0103871, selectcount, selectcount, "ambush", self.point_to_ambush );
    }
    
    assert( isdefined( var_8e0a55e3e0103871 ) );
    var_8e0a55e3e0103871 = bot_filter_ambush_inuse( var_8e0a55e3e0103871 );
    
    if ( var_8e0a55e3e0103871.size > 0 )
    {
        ambush_tacpoint_trying = utility::random_weight_sorted( var_8e0a55e3e0103871 );
    }
    
    if ( !isdefined( ambush_tacpoint_trying ) )
    {
        return false;
    }
    
    self.var_624c9f3d7225954 = ambush_tacpoint_trying;
    self.ambush_end = gettime() + self.ambush_duration;
    self.var_624c9f3d7225954.bot_ambush_end = self.ambush_end;
    var_3e57c1c9cb8e4edc = vectornormalize( self.point_to_ambush - self.var_624c9f3d7225954.groundpos );
    var_f193c8544a702125 = vectortoangles( var_3e57c1c9cb8e4edc );
    self.ambush_yaw = var_f193c8544a702125[ 1 ];
    return true;
}

// Namespace bots_personality
// Params 0
// Checksum 0x7e70772c, Offset: 0x25ab
// Size: 0x76, Type: bool
function bot_random_path()
{
    if ( bots_util::bot_is_remote_or_linked() )
    {
        return false;
    }
    
    var_50f7076087b1cce = 50;
    
    if ( self.personality == "camper" )
    {
        var_50f7076087b1cce = 0;
    }
    
    goalpos = undefined;
    
    if ( randomint( 100 ) < var_50f7076087b1cce )
    {
        goalpos = bots_util_mp::bot_recent_point_of_interest();
    }
    
    if ( !isdefined( goalpos ) )
    {
        goalpos = self botfindrandomgoal();
    }
    
    if ( isdefined( goalpos ) )
    {
        if ( self botsetscriptgoal( goalpos, 128, "hunt" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_personality
// Params 1
// Checksum 0x42b5d9c4, Offset: 0x262a
// Size: 0x1e
function function_b3eb4967dba60db9( source )
{
    return bots_util::bot_queued_process( source, "RandomPath", &bot_random_path );
}

// Namespace bots_personality
// Params 0
// Checksum 0x47019fc2, Offset: 0x2651
// Size: 0x212
function function_1c968146be113694()
{
    current_weapons = self getweaponslistprimaries();
    possible_weapons = [];
    
    foreach ( weapon in current_weapons )
    {
        if ( weapon.inventorytype != "primary" )
        {
            continue;
        }
        
        if ( weapon::isfistweapon( weapon ) || weapon.classname == "fist" || class::ismeleeweapon( weapon ) )
        {
            continue;
        }
        
        possible_weapons[ possible_weapons.size ] = weapon;
    }
    
    foreach ( weapon in possible_weapons )
    {
        if ( weapon.classname == "sniper" || weapon.classname == "mg" || weapon.classname == "rifle" || weapon.classname == "smg" || weapon.classname == "spread" )
        {
            return weapon;
        }
    }
    
    foreach ( weapon in possible_weapons )
    {
        if ( weapon.classname == "pistol" )
        {
            return weapon;
        }
    }
}

// Namespace bots_personality
// Params 1
// Checksum 0xa4f1b364, Offset: 0x286c
// Size: 0x185
function function_cc26fb6ecde979dc( var_5ae0243485af8289 )
{
    weapon = function_1c968146be113694();
    
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    assert( weapon.basename != "<dev string:x19b>" );
    personalitychoices = level.var_3beefd63b25fbb90[ weapon.basename ];
    
    if ( !isdefined( personalitychoices ) || personalitychoices.size == 0 )
    {
        if ( weapon.classname == "sniper" )
        {
            personalitychoices = [ "camper" ];
        }
        else if ( weapon.classname == "mg" )
        {
            personalitychoices = [ "run_and_gun", "camper" ];
        }
        else if ( weapon.classname == "rifle" )
        {
            personalitychoices = [ "run_and_gun" ];
        }
        else if ( weapon.classname == "smg" || weapon.classname == "spread" || weapon.classname == "pistol" )
        {
            personalitychoices = [ "cqb" ];
        }
    }
    
    if ( personalitychoices.size > 0 )
    {
        choice = undefined;
        
        if ( var_5ae0243485af8289 && arraycontains( personalitychoices, self.personality ) )
        {
            choice = self.personality;
        }
        else
        {
            choice = utility::array_random( personalitychoices );
        }
        
        if ( self.personality != choice )
        {
            bots_util_mp::bot_set_personality( choice );
        }
    }
}

