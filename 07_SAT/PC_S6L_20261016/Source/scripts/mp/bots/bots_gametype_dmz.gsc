// scripts\mp\bots\bots_gametype_dmz.gsc  (hash_288cdb9bfd17c42e.gscc) (size: 3823 Bytes / 0xeef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53e4d9e4 (1407506916)
// size ...... 3823 (0xeef)
// includes .. 4   (offset: 0xe57)
// strings ... 9   (offset: 0xe77)
// dev strs .. 1   (offset: 0xee3)
// exports ... 13  (offset: 0x80f)
// cseg ...... 0x106 + 0x709 (0x80f)
// imports ... 38  (offset: 0xa17)
// animtree1 . 0   (offset: 0xeef)
// animtree2 . 0   (offset: 0xeef)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_util;
#using scripts\mp\dmz\mission_manager;

#namespace bots_gametype_dmz;

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0x57dc5223, Offset: 0x124
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_dmz();
}

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0x7f9205dd, Offset: 0x13c
// Size: 0x2
function setup_bot_dmz()
{
    
}

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0xa0286f06, Offset: 0x146
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_dmz_think;
    autopilot::initialize( undefined, undefined, [ "bot_dmz_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0x88376b49, Offset: 0x181
// Size: 0xa8
function bot_dmz_think()
{
    self notify( #"bot_dmz_think" );
    self endon( #"bot_dmz_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    thread ammo_manager();
    thread target_tracker();
    self switchtoweapon( "none" );
    self botsetflag( "ignore_script_weapon", 1 );
    bots_util_mp::bot_set_personality( "run_and_gun" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        has_mission = follow_missions();
        
        if ( !has_mission )
        {
            self [[ self.personality_update_function ]]();
        }
        
        wait 0.05;
    }
}

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0x3afc9b2d, Offset: 0x231
// Size: 0xc8
function target_tracker()
{
    self endon( #"death_or_disconnect" );
    var_f80130e05418b367 = 300;
    last_enemy = undefined;
    
    for ( switch_time_seconds = undefined; true ; switch_time_seconds = current_time_seconds )
    {
        wait 1;
        
        if ( !isalive( self.enemy ) )
        {
            last_enemy = undefined;
            continue;
        }
        
        current_time_seconds = gettime() / 1000;
        
        if ( last_enemy == self.enemy )
        {
            time_on_enemy = current_time_seconds - switch_time_seconds;
            too_long = time_on_enemy > var_f80130e05418b367;
            assert( !too_long, "<dev string:x24>" + self.enemy.classname );
            continue;
        }
        
        last_enemy = self.enemy;
    }
}

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0x122f5a1a, Offset: 0x301
// Size: 0x191, Type: bool
function follow_missions()
{
    var_b9253130eab8994c = 5;
    current_time = gettime();
    
    if ( self.mission_update_time && ( current_time - self.mission_update_time ) / 1000 > var_b9253130eab8994c )
    {
        return isdefined( self.missionref );
    }
    
    self.mission_update = current_time;
    
    if ( !self.missionref )
    {
        newmission = get_mission();
        
        if ( !newmission )
        {
            self botclearscriptgoal();
            return false;
        }
        
        self.missionref = newmission mission_manager::get_unique_id();
        self.mission_step = undefined;
    }
    
    mission_step = mission_manager::getactivestep( mission_manager::get_mission() );
    
    if ( mission_step != self.mission_step )
    {
        self.mission_step = mission_step;
        self.mission_time = current_time;
        self.mission_objective = undefined;
    }
    
    current_objective = get_objective( self.mission_step );
    
    if ( !current_objective )
    {
        self.missionref = undefined;
        return true;
    }
    else if ( current_objective != self.mission_objective )
    {
        self.mission_objective = current_objective;
        bot_set_goal( self.mission_objective.origin, self.mission_objective.radius );
    }
    
    timeout = 240;
    time_on_mission = ( current_time - self.mission_time ) / 1000;
    
    if ( time_on_mission > timeout )
    {
        self.missionref = undefined;
    }
    
    return true;
}

// Namespace bots_gametype_dmz
// Params 2, eflags: 0x4
// Checksum 0xae020ae4, Offset: 0x49b
// Size: 0x59
function private bot_set_goal( goal_pos, radius )
{
    self botclearscriptgoal();
    waitframe();
    reachable_pos = self getclosestreachablepointonnavmesh( goal_pos );
    optional_params[ "override_goal_type" ] = "objective";
    optional_params[ "dont_leave_goal_during_combat" ] = 1;
    bots_scripted_defense::patrol_area( reachable_pos, radius, optional_params );
}

// Namespace bots_gametype_dmz
// Params 2, eflags: 0x4
// Checksum 0x2b0b7474, Offset: 0x4fc
// Size: 0x2c, Type: bool
function private function_c82ab0a7eec014db( a, b )
{
    return a.distance < b.distance;
}

// Namespace bots_gametype_dmz
// Params 1, eflags: 0x4
// Checksum 0x15240f49, Offset: 0x531
// Size: 0x46, Type: bool
function private is_objective_active( objective )
{
    return objective.teams[ self.team ].active || objective.teams[ 0 ].active;
}

// Namespace bots_gametype_dmz
// Params 1, eflags: 0x4
// Checksum 0xddddb63f, Offset: 0x580
// Size: 0x93
function private get_objective( step )
{
    foreach ( objective in step mission_manager::get_mission().objectives )
    {
        if ( is_objective_active( objective ) )
        {
            return objective;
        }
    }
}

// Namespace bots_gametype_dmz
// Params 0, eflags: 0x4
// Checksum 0x5fa5f2c, Offset: 0x61c
// Size: 0x137
function private get_mission()
{
    var_6ad6e45750821f50 = [];
    
    foreach ( mission in level.missionmanager.missions )
    {
        step = mission_manager::getactivestep( mission );
        
        if ( step.origin )
        {
            missionstruct = spawnstruct();
            missionstruct.data = mission;
            missionstruct.distance = distance( self.origin, step.origin );
            var_6ad6e45750821f50[ var_6ad6e45750821f50.size ] = missionstruct;
        }
    }
    
    if ( var_6ad6e45750821f50.size == 0 )
    {
        return;
    }
    
    var_6ad6e45750821f50 = arraysort( var_6ad6e45750821f50, undefined, &function_c82ab0a7eec014db );
    max_pick = int( min( var_6ad6e45750821f50.size, 5 ) );
    mission = var_6ad6e45750821f50[ getarraykey( var_6ad6e45750821f50, randomint( max_pick ) ) ];
    return mission.data;
}

// Namespace bots_gametype_dmz
// Params 0
// Checksum 0x6edb385c, Offset: 0x75c
// Size: 0xb3
function ammo_manager()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        weapon_list = self getweaponslistprimaries();
        
        foreach ( weapon in weapon_list )
        {
            if ( self getweaponammostock( weapon ) < weaponclipsize( weapon ) )
            {
                self setweaponammostock( weapon, weaponclipsize( weapon ) );
            }
        }
        
        wait 0.1;
    }
}

