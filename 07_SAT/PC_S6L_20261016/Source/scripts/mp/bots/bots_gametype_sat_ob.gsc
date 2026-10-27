// scripts\mp\bots\bots_gametype_sat_ob.gsc  (hash_09260d00c5d7c9bd.gscc) (size: 7316 Bytes / 0x1c94 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9962f6a (3918933866)
// size ...... 7316 (0x1c94)
// includes .. 14  (offset: 0x1a8c)
// strings ... 26  (offset: 0x1afc)
// dev strs .. 0   (offset: 0x1c94)
// exports ... 12  (offset: 0x10d8)
// cseg ...... 0x202 + 0xed6 (0x10d8)
// imports ... 68  (offset: 0x12b8)
// animtree1 . 0   (offset: 0x1c94)
// animtree2 . 0   (offset: 0x1c94)
#using script_3d2770dc09c1243;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\flags;
#using scripts\mp\squads;

#namespace bots_gametype_sat_ob;

// Namespace bots_gametype_sat_ob
// Params 0
// Checksum 0x7fc93281, Offset: 0x220
// Size: 0x53
function main()
{
    if ( mit::function_d154accecda01f06() )
    {
        mit::initialize();
        return;
    }
    
    setup_callbacks();
    setup_bot_sat_ob();
    level.var_cb0ad460a4d0ba7b = 1;
    level.var_d661a9efc2ea9245 = 1;
    autopilot::initialize( undefined, undefined, [ "bot_sat_ob_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_sat_ob
// Params 0
// Checksum 0xc04af2fe, Offset: 0x27b
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_sat_ob_think;
}

// Namespace bots_gametype_sat_ob
// Params 0
// Checksum 0xf449acdd, Offset: 0x29a
// Size: 0x2
function setup_bot_sat_ob()
{
    
}

// Namespace bots_gametype_sat_ob
// Params 0
// Checksum 0xf3339a6c, Offset: 0x2a4
// Size: 0x1cb
function bot_sat_ob_think()
{
    self notify( #"hash_4439178447bcec26" );
    self endon( #"hash_4439178447bcec26" );
    self endon( #"bot_sat_ob_think", #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_5ee0426b6999b5d6", 1 ) )
    {
        val::set( "bot_sat_ob_think", "deathShieldThreshold", 3 );
    }
    
    if ( isautopilot( self ) )
    {
        thread autopilotwatcher();
        thread function_6e19e94cdf78ef8f();
        thread function_19fbe89f737e500e();
    }
    
    wait 10;
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    self.leaderstrategy = spawnstruct();
    self.leaderstrategy.var_6da8916558fe3971 = 0;
    self.leaderstrategy.var_6291758dccfe077a = 0;
    self.leaderstrategy.interactcount = 0;
    self.leaderstrategy.interactablehack = [];
    
    while ( true )
    {
        if ( self function_bece775663e54d92() || self.sessionstate == "spectator" )
        {
            wait 1;
            continue;
        }
        
        if ( !isnavmeshloaded() || bots_tactical_goals::has_tactical_goal() || bots_util::bot_is_remote_or_linked() || self.var_1dfed8204e3c58c9 )
        {
            waitframe();
            continue;
        }
        
        squadleader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
        
        if ( !squads::isvalidplayer( squadleader ) )
        {
            squads::choosesquadleader( self.team, self.sessionsquadid );
        }
        
        if ( self == squadleader )
        {
            function_3eea446852589a68();
            waitframe();
            continue;
        }
        
        if ( !namespace_14346d439f44a158::function_737443eaedb33690() && ispointonnavmesh( squadleader.origin ) )
        {
            namespace_14346d439f44a158::guard_player( squadleader, 256 );
        }
        
        waitframe();
    }
}

// Namespace bots_gametype_sat_ob
// Params 0, eflags: 0x4
// Checksum 0x31661375, Offset: 0x477
// Size: 0x33
function private autopilotwatcher()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self waittill( #"exit_autopilot" );
    val::reset_all( "bot_sat_ob_think" );
}

// Namespace bots_gametype_sat_ob
// Params 0, eflags: 0xc
// Checksum 0xa9f25529, Offset: 0x4b2
// Size: 0x76
function private function_6e19e94cdf78ef8f()
{
    self notify( #"hash_ec5be5c6fcda7d20" );
    self endon( #"hash_ec5be5c6fcda7d20" );
    self endon( #"death_or_disconnect", #"exit_autopilot" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_ecda19d4dee34737" );
        wait 2;
        self notify( randomint( self.selectableskills.size ) == 0 ? "SkillSelectLeft" : "SkillSelectRight" );
    }
}

// Namespace bots_gametype_sat_ob
// Params 0, eflags: 0xc
// Checksum 0x38bae0ad, Offset: 0x530
// Size: 0xfd
function private function_19fbe89f737e500e()
{
    self notify( #"hash_9edfb5781635f1ee" );
    self endon( #"hash_9edfb5781635f1ee" );
    self endon( #"death_or_disconnect", #"exit_autopilot" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        
        if ( !currentweapon || currentweapon.basename == "none" )
        {
            if ( isarray( self.primaryweapons ) && self.primaryweapons.size > 0 )
            {
                self switchtoweaponimmediate( self.primaryweapons[ 0 ] );
            }
            else if ( isarray( self.meleeweapons ) && self.meleeweapons.size > 0 )
            {
                self switchtoweaponimmediate( self.meleeweapons[ 0 ] );
            }
        }
        else if ( !currentweapon.ismelee && !self getammocount( currentweapon ) )
        {
            self givemaxammo( currentweapon );
        }
        
        wait 20;
    }
}

// Namespace bots_gametype_sat_ob
// Params 0, eflags: 0x4
// Checksum 0x405331bc, Offset: 0x635
// Size: 0x5df
function private function_3eea446852589a68()
{
    activity = namespace_e55955ff7520be97::function_227ea43efd2cfb5c( self, [ "REV_OB_CONTRACT_HVT", "REV_OB_MERC_STRONGHOLD", "REV_OB_MERC_CAMP" ] );
    
    if ( bots_util::bot_in_combat() && activity && activity.type != "REV_OB_CRADLE_VENTS" )
    {
        return;
    }
    
    goal = function_2f786551f6fe8039();
    
    if ( !goal )
    {
        function_62a286a59c15a151();
        return;
    }
    
    function_120c92a730197189( goal );
    result = bots_util::bot_waittill_goal_or_fail( 30 );
    goalindex = self.leaderstrategy.goalindex;
    
    switch ( self.leaderstrategy.goaltype )
    {
        case #"hash_2103aa2d1f280263":
            if ( result == "goal" )
            {
                bots_strategy::bot_interact( goal, 0.5, 1 );
            }
            
            break;
        case #"hash_7b2e5c0423bf0ea0":
            if ( result == "goal" )
            {
                bots_strategy::function_da9dba34334aaba( goal.hvt_spawnpoints[ 0 ].origin, 2000, [ "team_hundred_ninety", "axis" ], 120 );
                self.leaderstrategy.var_6da8916558fe3971++;
            }
            
            break;
        case #"hash_87fc920520ec2075":
            if ( result == "goal" || result == "bad_path" && distance( self.origin, goal.door_interact_nodes[ 0 ].origin ) <= 100 )
            {
                bots_strategy::bot_interact( goal.door_interact_nodes[ 0 ], 7, 1 );
                bots_strategy::function_da9dba34334aaba( goal.var_441d26d05f86b224, 1000, [ "team_hundred_ninety", "axis" ], 120 );
                self.leaderstrategy.var_6da8916558fe3971++;
            }
            
            break;
        case #"hash_18347fa7b15eb832":
            bots_strategy::function_da9dba34334aaba( goal.var_441d26d05f86b224, 1000, [ "team_hundred_ninety", "axis" ], 120 );
            self.leaderstrategy.var_6da8916558fe3971++;
            break;
        case #"hash_77403ff8dd65777":
            if ( result == "goal" )
            {
                var_3f696ebfb0ffe19b = goal.vent_scriptable.var_3f696ebfb0ffe19b;
                leg = var_3f696ebfb0ffe19b[ getarraykey( var_3f696ebfb0ffe19b, goalindex ) ];
                thread bots_util::bot_disable_movement_for_time( 10 );
                thread bots_util::function_d84fd08da3207687( 10 );
                self botlookatpoint( leg.origin + ( 0, 0, 30 ), 10, "script_forced" );
                self botpressbutton( "use", 10 );
                wait 10;
                
                if ( leg.curprogress < leg.usetime )
                {
                    leg.curprogress = leg.usetime;
                    utility::callsharedfunc( #"ob_activity_cradle_vent", #"hash_a0e1817df2e33c21", goal.vent_scriptable, getarraykey( var_3f696ebfb0ffe19b, goalindex ), "usable", self );
                }
                
                self.leaderstrategy.goalindex++;
                
                if ( goalindex >= var_3f696ebfb0ffe19b.size )
                {
                    self.leaderstrategy.var_6da8916558fe3971++;
                }
            }
            
            break;
        case #"hash_9a3def342a73ca1a":
            if ( result == "goal" || result == "bad_path" )
            {
                damageent = goal.cleanup_cysts[ goalindex ];
                thread bots_util::bot_disable_movement_for_time( 7 );
                self botlookatpoint( damageent.origin, 7, "script_forced" );
                firetime = weaponfiretime( self getcurrentweapon() );
                starttime = gettime();
                
                while ( gettime() - starttime < 7000 )
                {
                    self botpressbutton( "attack" );
                    wait firetime > 0 ? firetime : 0.1;
                }
                
                if ( damageent.health > 0 )
                {
                    damageent scriptabledodamage( 300 );
                }
                
                self.leaderstrategy.goalindex++;
                
                if ( goalindex >= goal.cleanup_cysts.size )
                {
                    bots_strategy::function_da9dba34334aaba( self.origin, 1000, [ "team_hundred_ninety", "axis" ] );
                    self.leaderstrategy.var_6da8916558fe3971++;
                }
            }
            
            break;
        case #"hash_7c31479cf04292f":
            if ( result == "goal" || result == "bad_path" && distance( self.origin, goal.origin ) <= 300 )
            {
                bots_strategy::bot_interact( goal, 2, 1 );
                
                if ( goal.escapevehicle )
                {
                    namespace_14346d439f44a158::function_87e8deae08ce1a0();
                    namespace_14346d439f44a158::patrol_area( goal.origin, 300 );
                    goal.escapevehicle waittill( #"vehicle_parked" );
                    wait 3;
                    
                    foreach ( squadmember in squad_utility::getsquadmembers( self.team, 1 ) )
                    {
                        squadmember setorigin( goal.escapevehicle.origin + ( 0, 0, -50 ), 1 );
                        squadmember thread bots_util::bot_disable_movement_for_time( 30 );
                    }
                    
                    wait 30;
                }
            }
            
            break;
    }
    
    waitframe();
}

// Namespace bots_gametype_sat_ob
// Params 0, eflags: 0x4
// Checksum 0x90d1f7ef, Offset: 0xc1c
// Size: 0x26c
function private function_2f786551f6fe8039()
{
    if ( level.exfildoors.activedoors.size > 0 && self.leaderstrategy.var_6da8916558fe3971 >= 2 || gettime() > 1800000 )
    {
        self.leaderstrategy.goaltype = "exfil";
        activedoor = sortbydistance( level.exfildoors.activedoors, self.origin )[ 0 ];
        
        if ( activedoor isscriptableinstance() )
        {
            return activedoor;
        }
        else
        {
            return activedoor getlinkedscriptableinstance();
        }
    }
    
    if ( !activity_participation::function_75a087aafc3f50a4( self, [ "REV_OB_CONTRACT_HVT", "REV_OB_MERC_STRONGHOLD", "REV_OB_MERC_CAMP" ] ) )
    {
        starters = [];
        
        foreach ( activity in activity_common::function_394486cf35d84dc8() )
        {
            if ( activity.state == "Idle" && activity.type == "REV_OB_CONTRACT_HVT" && activity.activity_starter_scriptable )
            {
                if ( bots_util::function_647587f8e2d828a7( activity.activity_starter_scriptable.origin ) )
                {
                    starters[ starters.size ] = activity.activity_starter_scriptable;
                }
            }
        }
        
        if ( starters.size > 0 )
        {
            self.leaderstrategy.goaltype = "contract";
            self.leaderstrategy.goalindex = 0;
            starters = sortbydistance( starters, self.origin );
            return starters[ 0 ];
        }
    }
    
    activity = namespace_e55955ff7520be97::function_227ea43efd2cfb5c( self, [ "REV_OB_CONTRACT_HVT", "REV_OB_MERC_STRONGHOLD", "REV_OB_MERC_CAMP" ] );
    
    if ( self.leaderstrategy.goaltype != activity.type )
    {
        self.leaderstrategy.goaltype = activity.type;
        self.leaderstrategy.goalindex = 0;
    }
    
    return activity;
}

// Namespace bots_gametype_sat_ob
// Params 1, eflags: 0x4
// Checksum 0xe2f8e12e, Offset: 0xe91
// Size: 0x1fc
function private function_120c92a730197189( goal )
{
    navpoint = undefined;
    goalindex = self.leaderstrategy.goalindex;
    goalradius = 100;
    scriptgoaltype = "guard";
    
    switch ( self.leaderstrategy.goaltype )
    {
        case #"hash_7b2e5c0423bf0ea0":
            goalradius = 200;
            navpoint = self getclosestreachablepointonnavmesh( goal.hvt_spawnpoints[ goalindex ].origin );
            break;
        case #"hash_87fc920520ec2075":
            goalradius = 50;
            navpoint = self getclosestreachablepointonnavmesh( goal.door_interact_nodes[ goalindex ].origin );
            break;
        case #"hash_18347fa7b15eb832":
            navpoint = self getclosestreachablepointonnavmesh( goal.var_441d26d05f86b224 );
            break;
        case #"hash_77403ff8dd65777":
            goalradius = 30;
            scriptgoaltype = "tactical";
            var_3f696ebfb0ffe19b = goal.vent_scriptable.var_3f696ebfb0ffe19b;
            var_b1e8e9146211ab9a = var_3f696ebfb0ffe19b[ getarraykey( var_3f696ebfb0ffe19b, goalindex ) ].origin;
            interactionpos = vectorlerp( var_b1e8e9146211ab9a, goal.vent_scriptable.origin, 0.05 );
            navpoint = self getclosestreachablepointonnavmesh( interactionpos );
            break;
        case #"hash_9a3def342a73ca1a":
            groundpos = utility::groundpos( goal.cleanup_cysts[ goalindex ].origin );
            navpoint = self getclosestreachablepointonnavmesh( groundpos );
            break;
        case #"hash_7c31479cf04292f":
            scriptgoaltype = "tactical";
        default:
            navpoint = self getclosestreachablepointonnavmesh( goal.origin );
            break;
    }
    
    namespace_14346d439f44a158::function_87e8deae08ce1a0();
    self botsetscriptgoal( navpoint, goalradius, scriptgoaltype );
}

// Namespace bots_gametype_sat_ob
// Params 0, eflags: 0x4
// Checksum 0xe5e479d1, Offset: 0x1095
// Size: 0x43
function private function_62a286a59c15a151()
{
    namespace_14346d439f44a158::function_87e8deae08ce1a0();
    position = self.leaderstrategy.var_a281e7e33033e976 ?? self.origin;
    namespace_14346d439f44a158::patrol_area( position, 1500 );
    wait 20;
}

