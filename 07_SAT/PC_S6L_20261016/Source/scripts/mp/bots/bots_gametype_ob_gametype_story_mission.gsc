// scripts\mp\bots\bots_gametype_ob_gametype_story_mission.gsc  (hash_54757690e0a6562e.gscc) (size: 24609 Bytes / 0x6021 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad427f3 (181676019)
// size ...... 24609 (0x6021)
// includes .. 19  (offset: 0x59a9)
// strings ... 90  (offset: 0x5a41)
// dev strs .. 22  (offset: 0x5f19)
// exports ... 45  (offset: 0x4051)
// cseg ...... 0x929 + 0x3728 (0x4051)
// imports ... 149 (offset: 0x4759)
// animtree1 . 0   (offset: 0x6021)
// animtree2 . 0   (offset: 0x6021)
#using script_3d2770dc09c1243;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\playerlogic;
#using scripts\mp\squads;

#namespace bots_gametype_ob_gametype_story_mission;

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0
// Checksum 0xa1cb028d, Offset: 0x947
// Size: 0x73
function main()
{
    if ( mit::function_d154accecda01f06() )
    {
        mit::initialize();
        return;
    }
    
    setup_callbacks();
    setup_bot_ob_story_mission();
    callback::add( #"on_ping", &function_93f1181233a6f501 );
    level.var_cb0ad460a4d0ba7b = 1;
    level.var_d661a9efc2ea9245 = 1;
    autopilot::initialize( undefined, undefined, [ "bot_ob_story_mission_think", "clear_script_goal_on" ] );
    
    /#
        level thread function_86c1cf40cd57ba97();
    #/
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0
// Checksum 0xa93c3caf, Offset: 0x9c2
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_ob_story_mission_think;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0
// Checksum 0x6bf59492, Offset: 0x9e1
// Size: 0x2
function setup_bot_ob_story_mission()
{
    
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0
// Checksum 0x272742c2, Offset: 0x9eb
// Size: 0x39e
function bot_ob_story_mission_think()
{
    self notify( #"hash_4e7ea9588a0b8cf7" );
    self endon( #"hash_4e7ea9588a0b8cf7" );
    self endon( #"bot_ob_story_mission_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    botinfo = " player(autopilot/bot) " + self getentitynumber() + ":" + ( self.name ?? "<unknown>" );
    playerlogic::bink_complete_log( undefined, "LUI_EVENT " + "bink_complete" + botinfo );
    utility::ent_flag_set( "bink_complete" );
    self setclientomnvar( "ui_coop_bink_overlay_state", 0 );
    
    if ( getdvarint( @"hash_5ee0426b6999b5d6", 1 ) )
    {
        val::set( "bot_ob_story_mission_think", "deathShieldThreshold", 3 );
    }
    
    if ( isautopilot( self ) )
    {
        thread autopilotwatcher();
    }
    
    thread bots_util::bot_disable_movement_for_time( 10 );
    wait 10;
    self.leaderstrategy = spawnstruct();
    self.leaderstrategy.var_6291758dccfe077a = 0;
    self.leaderstrategy.interactcount = 0;
    self.leaderstrategy.interactcheat = [];
    self botsetdifficultysetting( "seeHardwareChance", 1 );
    self botsetdifficultysetting( "targetHardwareChance", 1 );
    self botsetdifficultysetting( "visionBlinded", 0.35 );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() || self.sessionstate == "spectator" )
        {
            wait 1;
            continue;
        }
        
        squadleader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
        updatecurrentweapon();
        
        if ( !squads::isvalidplayer( squadleader ) )
        {
            squads::choosesquadleader( self.team, self.sessionsquadid );
        }
        
        if ( !isnavmeshloaded() || bots_tactical_goals::has_tactical_goal() || bots_util::bot_is_remote_or_linked() || self.var_1dfed8204e3c58c9 )
        {
            if ( self isusingremoteturret() && self == squadleader )
            {
                function_f15b2cac54f7aa58();
            }
            
            waitframe();
            continue;
        }
        
        if ( self == squadleader )
        {
            function_3eea446852589a68();
            waitframe();
            continue;
        }
        
        players = get_teammates( 1 );
        
        if ( players.size > 0 )
        {
            if ( level.var_cb0ad460a4d0ba7b && !squadleader isufo() && !squadleader isnoclip() )
            {
                navpoint = self getclosestreachablepointonnavmesh( squadleader.origin );
                teleportdist = 2000;
                
                /#
                    teleportdist = getdvarint( @"hash_4c7517e5dff9c89c" );
                #/
                
                if ( distance( navpoint, squadleader.origin ) > 500 || distance( self.origin, squadleader.origin ) > teleportdist )
                {
                    teleportpos = getclosestpointonnavmesh( squadleader.origin );
                    
                    if ( distance( teleportpos, squadleader.origin ) < 100 )
                    {
                        teleportheight = 200;
                        
                        /#
                            teleportheight = getdvarint( @"bot_teleport_height" );
                        #/
                        
                        teleportpos = utility::drop_to_ground( teleportpos, teleportheight, 0 );
                        insolid = trace::player_trace( teleportpos + ( 0, 0, 70 ), teleportpos + ( 0, 0, 5 ), undefined, squadleader );
                        
                        if ( insolid[ "fraction" ] > 0.9 )
                        {
                            self setorigin( teleportpos, 1 );
                        }
                    }
                }
            }
            
            if ( !bots_scripted_defense::function_737443eaedb33690() && ispointonnavmesh( squadleader.origin ) )
            {
                bots_scripted_defense::guard_player( squadleader, 256 );
            }
        }
        
        waitframe();
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1
// Checksum 0x9adc7b8, Offset: 0xd91
// Size: 0xc1
function function_93f1181233a6f501( params )
{
    pingowner = params.player;
    pingindex = params.pingindex;
    
    if ( !isplayer( pingowner ) )
    {
        return;
    }
    
    if ( isdefined( pingowner ) && isdefined( pingindex ) )
    {
        var_6675b0888e2dbc2 = pingowner function_689a4266a29aac13( pingindex );
        pingassetname = calloutmarkerping_asset_name( var_6675b0888e2dbc2 );
        
        if ( pingassetname == getxhashasset( "ob_wheel_defend" ) )
        {
            pingowner function_885ad2eb93fdf192( pingindex );
            return;
        }
        
        if ( pingassetname == getxhashasset( "ob_wheel_regroup" ) )
        {
            pingowner function_278fa0d8aa31afd2( pingindex );
            return;
        }
        
        if ( pingassetname == getxhashasset( "ob_wheel_loot" ) )
        {
            pingowner thread function_789a070373f53368( pingindex );
        }
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xcf001ff2, Offset: 0xe5a
// Size: 0xb9
function private updatecurrentweapon()
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
        
        return;
    }
    
    if ( !currentweapon.ismelee && !self getammocount( currentweapon ) )
    {
        self givemaxammo( currentweapon );
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x9104baaa, Offset: 0xf1b
// Size: 0x33
function private autopilotwatcher()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self waittill( #"exit_autopilot" );
    val::reset_all( "bot_ob_story_mission_think" );
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x882ddf56, Offset: 0xf56
// Size: 0xe7
function private get_teammates( var_c4fbedd8264dd4fb )
{
    teammates = level.teamdata[ self.team ][ "players" ];
    
    if ( !isdefined( var_c4fbedd8264dd4fb ) )
    {
        return teammates;
    }
    
    bots = [];
    players = [];
    
    foreach ( teammate in teammates )
    {
        if ( isbot( teammate ) )
        {
            bots[ bots.size ] = teammate;
            continue;
        }
        
        if ( isplayer( teammate ) )
        {
            players[ players.size ] = teammate;
        }
    }
    
    return var_c4fbedd8264dd4fb ? players : bots;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xedc2e888, Offset: 0x1046
// Size: 0xb0
function private get_commanding_bots()
{
    bots = get_teammates( 0 );
    
    /#
        if ( isarray( level.var_28934618b9bf2324 ) )
        {
            var_a0594b95be060ccb = [];
            
            foreach ( index in level.var_28934618b9bf2324 )
            {
                var_a0594b95be060ccb[ var_a0594b95be060ccb.size ] = bots[ index ];
            }
            
            return var_a0594b95be060ccb;
        }
    #/
    
    return bots;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x4e19120c, Offset: 0x10ff
// Size: 0xd0
function private function_885ad2eb93fdf192( pingindex )
{
    self notify( #"hash_ba0dc2d5de745171" );
    bots = get_commanding_bots();
    
    foreach ( bot in bots )
    {
        bot.var_1dfed8204e3c58c9 = 1;
        bot bots_scripted_defense::function_87e8deae08ce1a0();
        bot botclearscriptgoal();
        goalposition = getclosestpointonnavmesh( self calloutmarkerping_getorigin( pingindex ) );
        bot bots_scripted_defense::protect_point( goalposition, 200 );
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xa4488630, Offset: 0x11d7
// Size: 0xa5
function private function_278fa0d8aa31afd2( pingindex )
{
    self notify( #"hash_7f71b5f76ee5366c" );
    bots = get_commanding_bots();
    
    foreach ( bot in bots )
    {
        bot botclearscriptgoal();
        bot.var_1dfed8204e3c58c9 = 0;
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0xc
// Checksum 0x32eb597d, Offset: 0x1284
// Size: 0xef
function private function_789a070373f53368( pingindex )
{
    self notify( #"hash_a0a332e5f74da691" );
    self endon( #"hash_a0a332e5f74da691" );
    self endon( #"hash_7f71b5f76ee5366c" );
    self endon( #"hash_ba0dc2d5de745171" );
    position = self calloutmarkerping_getorigin( pingindex );
    bots = get_commanding_bots();
    
    foreach ( bot in bots )
    {
        bot.var_1dfed8204e3c58c9 = isdefined( bot childthread bots_strategy::function_4b94dfba45ebf54c( position, undefined, undefined, getdvarvector( @"bot_interact_offset" ), undefined, undefined, 1 ) );
    }
}

/#

    // Namespace bots_gametype_ob_gametype_story_mission
    // Params 0
    // Checksum 0xff7271d8, Offset: 0x137b
    // Size: 0xf5, Type: dev
    function function_86c1cf40cd57ba97()
    {
        setdvar( @"hash_4c7517e5dff9c89c", 2000 );
        setdvar( @"bot_teleport_height", 200 );
        setdvar( @"bot_interact_offset", ( 0, 0, 0 ) );
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3e>", "<dev string:x4c>", &function_c920f2e35bdb9989 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5a>", "<dev string:x68>", &function_c920f2e35bdb9989 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x76>", "<dev string:x84>", &function_c920f2e35bdb9989 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x92>", "<dev string:xa3>", &function_c920f2e35bdb9989 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb1>", "<dev string:xca>", &function_87ae1809a06f5ee8 );
        devgui::add_devgui_dvar( "<dev string:xda>", "<dev string:xf5>" );
        devgui::add_devgui_dvar( "<dev string:x107>", "<dev string:x124>" );
        devgui::add_devgui_dvar( "<dev string:x138>", "<dev string:x155>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace bots_gametype_ob_gametype_story_mission
    // Params 1
    // Checksum 0x884eb653, Offset: 0x1478
    // Size: 0xae, Type: dev
    function function_c920f2e35bdb9989( params )
    {
        index = params[ 0 ];
        
        switch ( index )
        {
            case #"hash_31100fbc01bd387c":
                level.var_28934618b9bf2324 = [ 0 ];
                break;
            case #"hash_311012bc01bd3d35":
                level.var_28934618b9bf2324 = [ 1 ];
                break;
            case #"hash_311011bc01bd3ba2":
                level.var_28934618b9bf2324 = [ 2 ];
                break;
            default:
                level.var_28934618b9bf2324 = [ 0, 1, 2 ];
                break;
        }
    }

    // Namespace bots_gametype_ob_gametype_story_mission
    // Params 1
    // Checksum 0x213d174c, Offset: 0x152e
    // Size: 0x36, Type: dev
    function function_87ae1809a06f5ee8( params )
    {
        level.var_cb0ad460a4d0ba7b = !level.var_cb0ad460a4d0ba7b;
        iprintlnbold( "<dev string:x16f>" + level.var_cb0ad460a4d0ba7b );
    }

#/

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x9aacae93, Offset: 0x156c
// Size: 0x592
function private function_3eea446852589a68()
{
    function_eca1a2e595b17992();
    
    if ( function_473d34f85d2b7769() )
    {
        return;
    }
    
    if ( bots_util::bot_in_combat() && !function_c11a34de2d9ac526() )
    {
        return;
    }
    
    if ( !ispointonnavmesh( self.origin ) )
    {
        self setorigin( getclosestpointonnavmesh( self.origin ), 1 );
        return;
    }
    
    goal = function_2f786551f6fe8039();
    
    if ( function_83e94545afc78a05( goal ) )
    {
        self.leaderstrategy.var_6291758dccfe077a++;
    }
    else
    {
        self.leaderstrategy.var_6291758dccfe077a = 0;
    }
    
    self.leaderstrategy.lastgoal = goal;
    
    if ( self.leaderstrategy.var_6291758dccfe077a > 3 && self.leaderstrategy.interactcheat.size > 0 )
    {
        targetent = self.leaderstrategy.interactcheat[ 0 ];
        
        if ( targetent )
        {
            curpos = self.origin;
            interactpos = bots_util_mp::function_a55bf32f8c8ac4bb( targetent, function_a882f137c66a16d5( targetent ), ( 0, 0, 0 ) );
            
            /#
                iprintlnbold( "<dev string:x185>" + targetent.origin + "<dev string:x191>" );
            #/
            
            childthread function_57a50033a34c354e();
            self setorigin( interactpos, 1 );
            bots_strategy::bot_interact( targetent, function_fdd673581c06db1d( targetent ), 1 );
            
            if ( targetent )
            {
                targetent.var_8a379f4c7a926971 = 1;
            }
            
            self setorigin( curpos, 1 );
        }
        
        targetent.var_1dd541446acf4d4e = undefined;
        self.leaderstrategy.interactcheat[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.leaderstrategy.interactcheat );
        wait 1;
        return;
    }
    else if ( self.leaderstrategy.var_6291758dccfe077a > 6 )
    {
        foreach ( obj in bots_util_mp::function_b835a2f4a5581b50( self.origin, 2000, 0, [ "scriptable_jup_electronics_card_reader_01", "scriptable_military_ascendertop_heavy" ], [ "zmloot", "obloot", "brloot" ], [ "streak_sat_vm_care_package_physics_ob_story_mission", "sat_storage_lift_bot_01_crate_scriptable_anim", "sat_storage_lift_bot_crate_loot_silver_anim", "sat_ava_storage_lootbox_ability_case_01_anim" ] ) )
        {
            obj.var_8a379f4c7a926971 = undefined;
            obj.var_1dd541446acf4d4e = undefined;
        }
    }
    
    if ( self.leaderstrategy.var_6291758dccfe077a > 5 && isvector( self.leaderstrategy.objectivecheat ) )
    {
        if ( arraycontains( [ "objective", "waypoint", "none" ], self.leaderstrategy.goaltype ) )
        {
            /#
                iprintlnbold( "<dev string:x1d0>" + self.leaderstrategy.objectivecheat + "<dev string:x1f0>" );
            #/
            
            childthread function_57a50033a34c354e();
            self setorigin( self.leaderstrategy.objectivecheat, 1 );
            self.leaderstrategy.objectivecheat = undefined;
            wait 1;
            return;
        }
    }
    
    if ( !goal )
    {
        function_62a286a59c15a151();
        return;
    }
    
    function_120c92a730197189( goal );
    result = bots_util::bot_waittill_goal_or_fail( 30 );
    
    switch ( self.leaderstrategy.goaltype )
    {
        case #"hash_2d1406e602f0875d":
            if ( goal && isalive( goal ) )
            {
                bots_scripted_defense::function_87e8deae08ce1a0();
                goal utility::waittill_any_timeout( 20, "death" );
            }
            
            break;
        case #"hash_877191a74ee8012f":
            if ( result == "goal" || arraycontains( [ "bad_path", "timeout" ], result ) && goal && distance( self.origin, function_36308d6303a2bd47( goal ) ) < 100 )
            {
                bots_strategy::bot_interact( goal, function_fdd673581c06db1d( goal ), 1 );
                
                if ( goal )
                {
                    goal.var_8a379f4c7a926971 = 1;
                    goal.var_1dd541446acf4d4e = undefined;
                }
                
                wait 1;
            }
            else if ( goal && ( result == "bad_path" || result == "timeout" && self.leaderstrategy.var_6291758dccfe077a > 3 ) )
            {
                if ( !isdefined( goal.var_1dd541446acf4d4e ) )
                {
                    goal.var_1dd541446acf4d4e = 0;
                }
                
                goal.var_1dd541446acf4d4e++;
                self.leaderstrategy.interactcheat = arraycombineunique( self.leaderstrategy.interactcheat, [ goal ] );
            }
            
            bots_scripted_defense::function_87e8deae08ce1a0();
            break;
        case #"hash_a8c3703786dfb3da":
            if ( result == "goal" )
            {
                self.leaderstrategy.waypointindex++;
                wait 1;
            }
            
            break;
        case #"hash_15b9dadf23855b18":
        case #"hash_ab9808870a4ba1a8":
            wait 2;
            break;
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x642ba0ce, Offset: 0x1b06
// Size: 0xcb
function private function_120c92a730197189( goal )
{
    goalpos = goal;
    goalradius = 100;
    scriptgoaltype = "guard";
    
    switch ( self.leaderstrategy.goaltype )
    {
        case #"hash_2d1406e602f0875d":
            goalpos = goal.origin;
            break;
        case #"hash_877191a74ee8012f":
            goalpos = function_36308d6303a2bd47( goal );
            goalradius = function_a882f137c66a16d5( goal );
            scriptgoaltype = "tactical";
            break;
        case #"hash_ab9808870a4ba1a8":
            scriptgoaltype = "tactical";
            break;
    }
    
    navpoint = self getclosestreachablepointonnavmesh( goalpos );
    bots_scripted_defense::function_87e8deae08ce1a0();
    self botsetscriptgoal( navpoint, goalradius, scriptgoaltype );
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x3029b9d, Offset: 0x1bd9
// Size: 0x6d2
function private function_2f786551f6fe8039()
{
    self.leaderstrategy.var_461a0c5af388cbc5 = self.leaderstrategy.goaltype;
    self.leaderstrategy.goaltype = undefined;
    
    foreach ( obj in bots_util_mp::function_fe389706fe156403( self.origin, 1000, 1 ) )
    {
        if ( obj physics_getnumbodies() && !obj.var_e2505b728a186c0b && ( isalive( obj ) || function_c3e9f0f0c4273ce0( obj ) ) && !function_2df9a0ac94507862( obj ) )
        {
            obj.health = maxint( obj.health, 100 );
            obj makeentitysentient( "team_hundred_ninety", 1 );
            self function_529c3c83df97116d( obj.origin, 100 );
            obj thread damagewatcher( self, 1 );
        }
    }
    
    foreach ( obj in bots_util_mp::function_fe389706fe156403( self.origin, 5000, 1, 1 ) )
    {
        var_ff19f38d28680274 = function_2480849734eac3f7( obj );
        
        if ( var_ff19f38d28680274 )
        {
            thread function_875dfe42e3f0b150( obj, var_ff19f38d28680274 );
        }
    }
    
    foreach ( obj in self.leaderstrategy.interactcheat )
    {
        if ( bots_util::function_647587f8e2d828a7( obj.origin ) && !function_ece778217ee516b2( obj ) )
        {
            self.leaderstrategy.interactcheat = arrayremove( self.leaderstrategy.interactcheat, obj );
        }
    }
    
    if ( self.leaderstrategy.var_37674ce881b8b923 )
    {
        goal = self.leaderstrategy.var_37674ce881b8b923;
        self.leaderstrategy.goaltype = "objective_force_tactical";
        self.leaderstrategy.var_37674ce881b8b923 = undefined;
        return goal;
    }
    
    interactableobj = function_5905ff4d368c9627( self.origin );
    
    if ( interactableobj )
    {
        return interactableobj;
    }
    
    if ( self.enemy )
    {
        self.leaderstrategy.goaltype = "attack";
        self.enemy thread damagewatcher( self );
        return self.enemy;
    }
    
    objectivegoal = undefined;
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( self );
    
    foreach ( var_109d60f71f42acad in var_ccc91d79bfa22c3a )
    {
        activityinstanceid = var_109d60f71f42acad.instanceid;
        activityinstance = activity_common::getactivityinstance( activityinstanceid );
        objectivemarkers = activityinstance.objectivemarkers ?? [];
        
        foreach ( markers in getarraykeys( objectivemarkers ) )
        {
            goalpos = function_fe0373ac02a0fc59( objective_getlocation( markers, 0 ) );
            
            if ( isvector( goalpos ) )
            {
                if ( bots_util::function_647587f8e2d828a7( goalpos ) )
                {
                    self.leaderstrategy.var_a281e7e33033e976 = goalpos;
                    objectivegoal = goalpos;
                    continue;
                }
                
                interactableobj = function_5905ff4d368c9627( goalpos );
                
                if ( interactableobj )
                {
                    return interactableobj;
                }
                
                if ( ispointonnavmesh( goalpos ) )
                {
                    self.leaderstrategy.objectivecheat = goalpos;
                }
            }
        }
    }
    
    if ( objectivegoal )
    {
        self.leaderstrategy.goaltype = "objective";
        return objectivegoal;
    }
    
    activewaypoints = waypoint_objective_handler::function_22c79c4675aa5cd9();
    
    if ( activewaypoints && activewaypoints.size > 0 )
    {
        foreach ( waypointskey in getarraykeys( activewaypoints ) )
        {
            waypoints = activewaypoints[ waypointskey ];
            
            if ( !self.leaderstrategy.prevwaypoints || !arraycompare( self.leaderstrategy.prevwaypoints, waypoints ) )
            {
                self.leaderstrategy.waypointindex = 0;
            }
            
            self.leaderstrategy.prevwaypoints = waypoints;
            waypointindex = minint( self.leaderstrategy.waypointindex, waypoints.size - 1 );
            goalpos = waypoints[ waypointindex ].origin;
            
            if ( bots_util::function_647587f8e2d828a7( goalpos ) )
            {
                self.leaderstrategy.goaltype = "waypoint";
                self.leaderstrategy.var_a281e7e33033e976 = goalpos;
                return goalpos;
            }
            
            interactableobj = function_5905ff4d368c9627( goalpos );
            
            if ( interactableobj )
            {
                return interactableobj;
            }
            
            if ( ispointonnavmesh( goalpos ) )
            {
                self.leaderstrategy.objectivecheat = goalpos;
            }
        }
    }
    
    self.leaderstrategy.goaltype = "none";
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x8b8d8a0a, Offset: 0x22b3
// Size: 0x76
function private function_62a286a59c15a151()
{
    bots_scripted_defense::function_87e8deae08ce1a0();
    position = self.leaderstrategy.var_a281e7e33033e976 && bots_util::function_647587f8e2d828a7( self.leaderstrategy.var_a281e7e33033e976 ) ? self.leaderstrategy.var_a281e7e33033e976 : self.origin;
    bots_scripted_defense::patrol_area( position, 1500 );
    wait 20;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xbe847231, Offset: 0x2331
// Size: 0x165
function private function_5905ff4d368c9627( position )
{
    foreach ( obj in bots_util_mp::function_b835a2f4a5581b50( position, 2000, 0, [ "scriptable_jup_electronics_card_reader_01", "scriptable_military_ascendertop_heavy" ], [ "zmloot", "obloot", "brloot" ], [ "streak_sat_vm_care_package_physics_ob_story_mission", "sat_storage_lift_bot_01_crate_scriptable_anim", "sat_storage_lift_bot_crate_loot_silver_anim", "sat_ava_storage_lootbox_ability_case_01_anim" ] ) )
    {
        if ( !obj.var_8a379f4c7a926971 && !arraycontains( self.leaderstrategy.interactcheat, obj ) )
        {
            if ( bots_util::function_647587f8e2d828a7( obj.origin ) )
            {
                self.leaderstrategy.goaltype = "interact";
                return obj;
            }
            
            self.leaderstrategy.interactcheat = arraycombineunique( self.leaderstrategy.interactcheat, [ obj ] );
        }
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x206e95a3, Offset: 0x249e
// Size: 0xb6, Type: bool
function private function_83e94545afc78a05( newgoal )
{
    if ( !newgoal && !self.leaderstrategy.lastgoal )
    {
        return true;
    }
    
    if ( self.leaderstrategy.var_461a0c5af388cbc5 != self.leaderstrategy.goaltype )
    {
        return false;
    }
    
    if ( isvector( newgoal ) && isvector( self.leaderstrategy.lastgoal ) && distance( newgoal, self.leaderstrategy.lastgoal ) <= 5 )
    {
        return true;
    }
    
    return newgoal == self.leaderstrategy.lastgoal;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x5d5bd199, Offset: 0x255d
// Size: 0x4d
function private function_36308d6303a2bd47( goal )
{
    var_b2c0aec6fa6ee90f = function_1f39484e7d49c502( function_aff48acd07f171be() );
    return goal.origin + ( var_b2c0aec6fa6ee90f[ goal.targetname ] ?? ( 0, 0, 0 ) );
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x93fac3e3, Offset: 0x25b3
// Size: 0x25
function private function_a882f137c66a16d5( obj )
{
    if ( obj.classname == "scriptable_mcz_interact_obj" )
    {
        return 10;
    }
    
    return 30;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x8dd19449, Offset: 0x25e1
// Size: 0x108
function private function_fdd673581c06db1d( obj )
{
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( self );
    
    foreach ( var_109d60f71f42acad in var_ccc91d79bfa22c3a )
    {
        activityinstanceid = var_109d60f71f42acad.instanceid;
        activityinstance = activity_common::getactivityinstance( activityinstanceid );
        
        if ( function_4f8ff3488043056f()[ activityinstance.type ] && function_4f8ff3488043056f()[ activityinstance.type ][ obj.targetname ] )
        {
            return function_4f8ff3488043056f()[ activityinstance.type ][ obj.targetname ];
        }
    }
    
    return 1.5;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 2, eflags: 0xc
// Checksum 0x7248a1d1, Offset: 0x26f2
// Size: 0xe8
function private damagewatcher( squadleader, var_69ff5177e4f241b4 )
{
    self notify( #"hash_a6bc44f40d31aad1" );
    self endon( #"hash_a6bc44f40d31aad1" );
    
    if ( !isdefined( self.var_65d66eb6084cc20d ) )
    {
        self.var_65d66eb6084cc20d = 0;
    }
    
    while ( self && isalive( self ) && self.var_65d66eb6084cc20d < 20000 )
    {
        if ( !isalive( self ) )
        {
            break;
        }
        
        if ( squadleader.enemy == self || var_69ff5177e4f241b4 && function_c3e9f0f0c4273ce0( self ) )
        {
            self.var_65d66eb6084cc20d += getframeduration();
        }
        
        waitframe();
    }
    
    if ( !squadleader )
    {
        return;
    }
    
    if ( self )
    {
        self dodamage( max( self.health, 9000 ), squadleader.origin, squadleader, undefined );
        waitframe();
    }
    
    if ( self )
    {
        self.var_e2505b728a186c0b = 1;
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x1ae5a688, Offset: 0x27e2
// Size: 0x96, Type: bool
function private function_c3e9f0f0c4273ce0( obj )
{
    if ( obj.classname == "scriptable_force_field_power_supply" )
    {
        foreach ( ff in obj.ff )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xff71d8cc, Offset: 0x2881
// Size: 0x24, Type: bool
function private function_2df9a0ac94507862( obj )
{
    if ( obj.targetname == "veh_libra_mech_turret" )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0xc
// Checksum 0x2e842937, Offset: 0x28ae
// Size: 0x32
function private function_57a50033a34c354e()
{
    self notify( #"hash_caa287786726af5f" );
    self endon( #"hash_caa287786726af5f" );
    self.is_teleporting = 1;
    wait 1;
    self.is_teleporting = 0;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x6ea5632e, Offset: 0x28e8
// Size: 0x23a
function private function_2480849734eac3f7( obj )
{
    if ( isagent( obj ) && obj.agent_type == "actor_sat_libra_mech" && obj.aicategory == "boss" )
    {
        return [ 9000, "MOD_EXPLOSIVE" ];
    }
    
    if ( obj.model == "c_sat_nic_npc_menendez_2035_body_combat" )
    {
        return [ 100, "MOD_EXPLOSIVE" ];
    }
    
    if ( obj.model == "c_sat_aries_mars_stalk_rig" )
    {
        level.mars_ai.var_1e0c729a105495d0 += 100;
        return [ 100, "MOD_EXPLOSIVE" ];
    }
    
    if ( obj.model == "c_sat_aries_mars_flower_rig" && obj.var_cce7c67ea2da8902 )
    {
        obj.var_cce7c67ea2da8902 -= 1;
        return [ 1, "MOD_EXPLOSIVE" ];
    }
    
    if ( obj.targetname == "scene_prop_forge_turret_intro" )
    {
        if ( !obj.var_8f73db17ee23f3e2 )
        {
            obj.var_8f73db17ee23f3e2 = 1;
            self launchgrenade( "sat_emp_grenade_ob", obj.origin, ( 0, 0, 0 ) );
        }
        
        return [ 0, "MOD_EXPLOSIVE" ];
    }
    
    if ( isdefined( obj.targetname ) && arraycontains( [ "harper_clip_head", "harper_clip_chest", "harper_clip_hand_l", "harper_clip_hand_r", "sat_ob_gemini_vtol", "veh_sat_mil_vtol_ob_transport_guild" ], obj.targetname ) )
    {
        return [ 50000, "MOD_EXPLOSIVE" ];
    }
    
    if ( isdefined( obj.classname ) && arraycontains( [ "scriptable_sat_machinery_cradle_loader_01_libra_server", "scriptable_sat_machinery_cradle_loader_01_libra_server_02" ], obj.classname ) && obj getscriptablepartstate( "main" ) != "loader_dead" )
    {
        return [ 1000, undefined ];
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 2, eflags: 0xc
// Checksum 0x4ed8246, Offset: 0x2b2b
// Size: 0x7d
function private function_875dfe42e3f0b150( obj, var_ff19f38d28680274 )
{
    self notify( #"hash_8f4ebab244aeb7fe" );
    self endon( #"hash_8f4ebab244aeb7fe" );
    
    while ( obj && function_2480849734eac3f7( obj ) && isvector( self.origin ) )
    {
        obj dodamage( max( obj.health, var_ff19f38d28680274[ 0 ] ), self.origin, self, undefined, var_ff19f38d28680274[ 1 ] );
        wait 1;
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xc4860f16, Offset: 0x2bb0
// Size: 0x56
function private function_aff48acd07f171be()
{
    return [ "mp_sat_ob_gemini":[ "mcz_cliffs_interact":( -20, -30, 0 ), "mcz_basement_interact":( -10, -30, 0 ), "mcz_woods_interact":( 0, 30, 0 ), "mcz_initial_interact":( -10, 45, 0 ) ] ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xee369ac7, Offset: 0x2c0f
// Size: 0x31
function private function_4f8ff3488043056f()
{
    return [ "OB_GEMINI_CABIN_MEMORYCAPTURE":[ "mcz_basement_interact":100, "mcz_woods_interact":100, "mcz_cliffs_interact":100 ], "OB_GEMINI_CABIN_INITIALMEMORY":[ "mcz_initial_interact":50 ] ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x8f74a911, Offset: 0x2c49
// Size: 0xc
function private function_9c17fa7a2ae0712a()
{
    return [ "OB_GEMINI_TUNNELS_ELEVATOR" ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x301aee19, Offset: 0x2c5e
// Size: 0x31
function private function_91d3c54e8102e03a()
{
    return [ "mp_sat_ob_aries":[ [ ( -203.861, -1328.31, 2627.42 ), ( -1291.35, -2019.79, 2331.19 ) ] ] ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x102aa359, Offset: 0x2c98
// Size: 0x58
function private function_d664866ab3189739()
{
    return [ "mp_sat_ob_libra":[ [ ( 6954.51, -4071.95, 1208.9 ), ( 7304.65, -4185.13, 1309.46 ) ], [ ( 7019.54, -4071.96, 1208.9 ), ( 7092.05, -4000.83, 1272.46 ) ] ] ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xf83932e0, Offset: 0x2cf9
// Size: 0x223
function private function_8d26e3f9393025cf()
{
    return [ "mp_sat_ob_libra":[ [ ( -2139.46, 7058.2, 7666.88 ), level, "flag_escape_done", 300 ] ], "mp_sat_ob_gemini":[ [ ( -48764.9, 5283.07, -138.07 ), level, "flag_minecarts_armory_entrance", 1000 ], [ ( 3815, -1983.01, -96.0003 ), level, "flag_elevator_player_catchup_complete", 500 ] ], "mp_sat_ob_capricorn":[ [ ( 3658.87, -6034.4, 833 ), level, "flag_vo_hijacked_below_deck_callout", 500 ], [ ( 3658.87, -6034.4, 833 ), level, "flag_computer_throttle_begin", 1000 ], [ ( 3260.54, -5992.89, 969 ), level, "flag_computer_throttle_complete", 500 ] ], "mp_sat_ob_aries":[ [ ( -12268.2, -9792.47, 1274.5 ), level, "flag_grapple_hook_vo", 1000 ], [ ( -12268.2, -9792.47, 1274.5 ), level, "flag_look_for_woods_jungle_01", 1000 ], [ ( -995.811, -1806.69, 2388.73 ), level, "flag_cargo_inspect_intro", 1000 ], [ ( -34120.1, 13326.4, 637.878 ), level, "flag_aries_nightmare_tower_catchup_complete", 500 ], [ ( -34120.1, 13326.4, 637.878 ), level, "flag_nm_tower_weakpoints_set_a_complete", 500 ], [ ( -35204.6, 12986.7, 4609.85 ), level, "flag_aries_nightmare_crashsite_catchup_complete", 500 ] ] ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0xf38cbdad, Offset: 0x2f25
// Size: 0x9a1
function private function_15553dfe4c0539ac()
{
    return [ "mp_sat_ob_libra":[ [ ( 5154.74, -4605.34, 996 ), ( 5577.37, -4730.61, 800 ), 300, 5 ], [ ( -2125.03, 20880.3, 1536.25 ), ( -1970.29, 14458.1, 3392.64 ), 300, 1 ], [ ( -1970.29, 14458.1, 3392.64 ), ( -1979.96, 13990.2, 3426.12 ), 300, 1 ], [ ( -1997.1, 13813.6, 3402.67 ), ( -1988.72, 12734, 3536.63 ), 200, 1 ], [ ( -1944.51, 9658.48, 2341.22 ), ( -1352.4, 8947.47, 2874.74 ), 200, 3 ], [ ( -1352.4, 8947.47, 2874.74 ), ( -1136.56, 8045.53, 3410.4 ), 200, 3 ], [ ( -1136.56, 8045.53, 3410.4 ), ( -2311.96, 7330.15, 7224.95 ), 300, 15 ], [ ( -2311.96, 7330.15, 7424.95 ), ( -2139.46, 7058.2, 7666.88 ), 300, 30 ] ], "mp_sat_ob_gemini":[ [ ( 4972.74, -2386.98, -88.3715 ), ( 5088.27, -2338.26, 64 ), 150, 5 ] ], "mp_sat_ob_virgo":[ [ ( -16968.8, -13340.4, 454.342 ), ( -18080, -12850.6, 558.013 ), 300, 5 ], [ ( -18080, -12850.6, 558.013 ), ( -18003.6, -12606.7, 562.288 ), 100, 5 ], [ ( -18003.6, -12606.7, 562.288 ), ( -19573.8, -12501.1, 599.441 ), 100, 5 ], [ ( -19573.8, -12501.1, 599.441 ), ( -21969.3, -13997.4, 512.784 ), 200, 5 ], [ ( -21969.3, -13997.4, 512.784 ), ( -22624, -13832, 485.414 ), 200, 5 ], [ ( -22624, -13832, 485.414 ), ( -23292.7, -13807.4, 1136.88 ), 200, 5 ], [ ( -23292.7, -13807.4, 1136.88 ), ( -22617.9, -14349.3, 1233.44 ), 200, 5 ], [ ( -22617.9, -14349.3, 1233.44 ), ( -22299.2, -15280.5, 1877.31 ), 200, 5 ], [ ( -22299.2, -15280.5, 1877.31 ), ( -25210.2, -16680.1, 3083.44 ), 200, 5 ] ], "mp_sat_ob_capricorn":[ [ ( -5933.06, -22919, 696 ), ( -8393.84, -23421, 920.188 ), 500, 5, undefined, "OB_CAPRICORN_FORGE" ], [ ( -7290.42, -25165.9, 1107 ), ( -7096.67, -25542.6, 632 ), 500, 5, undefined, "OB_CAPRICORN_FORGE" ], [ ( -12032.7, -61445.4, -438.25 ), ( -9879.47, -59436.5, -139.393 ), 500, 5, undefined, "OB_CAPRICORN_FORGE_RESTRICTED_AREA_GARAGE_COMPLETED" ], [ ( -9879.47, -59436.5, -139.393 ), ( -11296.1, -59170.8, -92.9915 ), 300, 5 ], [ ( -11296.1, -59170.8, -92.9915 ), ( -12964.1, -59119.2, 129.015 ), 300, 5 ], [ ( -11436.7, -51915.8, 828 ), ( -11722.8, -50759.7, 1332.68 ), 600, 5 ], [ ( -11722.8, -50759.7, 1332.68 ), ( -12458.6, -51440.1, 1144.5 ), 300, 5 ], [ ( -12458.6, -51440.1, 1144.5 ), ( -14529.6, -51691.3, 1558.18 ), 300, 5 ], [ ( -14529.6, -51691.3, 1558.18 ), ( -14014.4, -48396.3, 2924.14 ), 300, 5 ], [ ( -14014.4, -48396.3, 2924.14 ), ( -12640.7, -48474.5, 2815.82 ), 300, 5 ] ], "mp_sat_ob_aries":[ [ ( -7486.82, -4518.02, 1367.78 ), ( -5737.68, -3456.5, 1959.24 ), 500, 5 ], [ ( -5737.68, -3456.5, 1959.24 ), ( -4933.95, -1723.78, 2191.42 ), 500, 5 ], [ ( -1291.35, -2019.79, 2331.19 ), ( -992.597, -1805.89, 2409.57 ), 200, 5 ], [ ( -995.811, -1806.69, 2388.73 ), ( 1797.17, -4282.11, 2269.25 ), 500, 20, ( 1825.45, -4215.72, 2324.19 ) ], [ ( 1797.17, -4282.11, 2269.25 ), ( 5081.73, -3791.16, 2910.78 ), 500, 20, ( 5069.3, -3726.99, 2953.61 ) ], [ ( 5081.73, -3791.16, 2910.78 ), ( 4240.37, 901.986, 3123.02 ), 500, 20, ( 4156.84, 974.312, 3218.42 ) ], [ ( 4240.37, 901.986, 3123.02 ), ( 936.7, -949.677, 2303.65 ), 500, 5 ], [ ( -26443, 14896.4, 10 ), ( -26412.7, 13612.1, 47.321 ), 500, 5 ], [ ( -27359.1, 12377.1, 151.948 ), ( -30313.8, 11953.9, -124.098 ), 500, 5 ], [ ( -30313.8, 11953.9, -124.098 ), ( -31574.3, 12725.9, 1.07045 ), 500, 5 ], [ ( -31574.3, 12725.9, 1.07045 ), ( -32493.4, 12684.2, 512.771 ), 500, 5 ], [ ( -32493.4, 12684.2, 512.771 ), ( -33050.8, 12720.1, 428.503 ), 300, 5 ], [ ( -33050.8, 12720.1, 428.503 ), ( -34120.1, 13326.4, 637.878 ), 300, 5 ], [ ( -35204.6, 12986.7, 4609.85 ), ( -36524.1, 14118.3, 4451.51 ), 300, 10 ], [ ( -36524.1, 14118.3, 4451.51 ), ( -38284.7, 15481.7, 4770.07 ), 300, 10 ], [ ( -34238.6, 13015.4, 2097.16 ), ( -35204.6, 12986.7, 4609.85 ), 1000, 120 ] ], "mp_sat_ob_leo":[ [ ( -7053.14, 7953.95, -2336.69 ), ( -4088.77, 5165.44, -554.927 ), 500, 5 ] ] ];
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x85b6eab, Offset: 0x38cf
// Size: 0x1b9, Type: bool
function private function_c11a34de2d9ac526()
{
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( self );
    
    foreach ( var_109d60f71f42acad in var_ccc91d79bfa22c3a )
    {
        activityinstanceid = var_109d60f71f42acad.instanceid;
        activityinstance = activity_common::getactivityinstance( activityinstanceid );
        
        if ( arraycontains( function_9c17fa7a2ae0712a(), activityinstance.type ) )
        {
            objectivemarkers = activityinstance.objectivemarkers ?? [];
            
            foreach ( markers in getarraykeys( objectivemarkers ) )
            {
                goalpos = objective_getlocation( markers, 0 );
                
                if ( isvector( goalpos ) )
                {
                    if ( bots_util::function_647587f8e2d828a7( goalpos ) )
                    {
                        self.leaderstrategy.var_a281e7e33033e976 = goalpos;
                        self.leaderstrategy.var_37674ce881b8b923 = goalpos;
                        return true;
                    }
                    
                    if ( ispointonnavmesh( goalpos ) )
                    {
                        childthread bots_util::bot_disable_movement_for_time( 1 );
                        self setorigin( goalpos, 1 );
                        wait 1;
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xf5e4fad3, Offset: 0x3a91
// Size: 0xfc, Type: bool
function private function_ece778217ee516b2( obj )
{
    var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( self );
    
    foreach ( var_109d60f71f42acad in var_ccc91d79bfa22c3a )
    {
        activityinstanceid = var_109d60f71f42acad.instanceid;
        activityinstance = activity_common::getactivityinstance( activityinstanceid );
        
        if ( function_4f8ff3488043056f()[ activityinstance.type ] && function_4f8ff3488043056f()[ activityinstance.type ][ obj.targetname ] )
        {
            return true;
        }
    }
    
    if ( obj.var_1dd541446acf4d4e >= 6 )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0x7a482808, Offset: 0x3b96
// Size: 0xa1
function private function_fe0373ac02a0fc59( goalpos )
{
    var_b2c0aec6fa6ee90f = function_1f39484e7d49c502( function_91d3c54e8102e03a() );
    
    foreach ( var_b42c86b159ff93d1 in var_b2c0aec6fa6ee90f )
    {
        if ( distance( goalpos, var_b42c86b159ff93d1[ 0 ] ) < 100 )
        {
            return var_b42c86b159ff93d1[ 1 ];
        }
    }
    
    return goalpos;
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x598019df, Offset: 0x3c40
// Size: 0xec
function private function_f15b2cac54f7aa58()
{
    var_b2c0aec6fa6ee90f = function_1f39484e7d49c502( function_d664866ab3189739() );
    
    foreach ( cheatpos in var_b2c0aec6fa6ee90f )
    {
        if ( distance( self.origin, cheatpos[ 0 ] ) < function_a882f137c66a16d5() )
        {
            starttime = gettime();
            self botlookatpoint( cheatpos[ 1 ], 10, "script_forced" );
            
            while ( gettime() - starttime < 10000 )
            {
                self botpressbutton( "attack" );
                wait 0.1;
            }
            
            wait 1;
            self notify( #"exit" );
            return;
        }
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x11daad9a, Offset: 0x3d34
// Size: 0xb6
function private function_eca1a2e595b17992()
{
    var_b2c0aec6fa6ee90f = function_1f39484e7d49c502( function_8d26e3f9393025cf() );
    
    foreach ( cheatflag in var_b2c0aec6fa6ee90f )
    {
        if ( distance( self.origin, cheatflag[ 0 ] ) < ( cheatflag.size > 3 ? cheatflag[ 3 ] : 100 ) )
        {
            cheatflag[ 1 ] utility::flag_set( cheatflag[ 2 ] );
        }
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 0, eflags: 0x4
// Checksum 0x52c49249, Offset: 0x3df2
// Size: 0x21c
function private function_473d34f85d2b7769()
{
    var_b2c0aec6fa6ee90f = function_1f39484e7d49c502( function_15553dfe4c0539ac() );
    
    foreach ( teleportinfo in var_b2c0aec6fa6ee90f )
    {
        if ( teleportinfo[ 5 ] )
        {
            shouldteleport = undefined;
            var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( self );
            
            foreach ( var_109d60f71f42acad in var_ccc91d79bfa22c3a )
            {
                activityinstanceid = var_109d60f71f42acad.instanceid;
                activityinstance = activity_common::getactivityinstance( activityinstanceid );
                
                if ( activityinstance.type == teleportinfo[ 5 ] )
                {
                    shouldteleport = 1;
                    break;
                }
            }
            
            if ( !shouldteleport )
            {
                continue;
            }
        }
        
        if ( distance( self.origin, teleportinfo[ 0 ] ) < teleportinfo[ 2 ] )
        {
            delaytime = teleportinfo.size > 3 ? teleportinfo[ 3 ] : 1;
            childthread function_57a50033a34c354e();
            childthread bots_util::bot_disable_movement_for_time( delaytime );
            self setorigin( teleportinfo[ 1 ], 1 );
            
            if ( isvector( teleportinfo[ 4 ] ) )
            {
                self botlookatpoint( teleportinfo[ 4 ], delaytime, "script_forced" );
                firetime = weaponfiretime( self getcurrentweapon() );
                starttime = gettime();
                
                while ( gettime() - starttime < delaytime * 1000 )
                {
                    self botpressbutton( "attack" );
                    wait firetime > 0 ? firetime : 0.1;
                }
            }
            else
            {
                wait delaytime;
            }
            
            return 1;
        }
    }
}

// Namespace bots_gametype_ob_gametype_story_mission
// Params 1, eflags: 0x4
// Checksum 0xe8a0f162, Offset: 0x4016
// Size: 0x3a
function private function_1f39484e7d49c502( data )
{
    mapname = game_utility::getmapname();
    var_b2c0aec6fa6ee90f = data[ mapname ];
    
    if ( !isarray( var_b2c0aec6fa6ee90f ) )
    {
        return [];
    }
    
    return var_b2c0aec6fa6ee90f;
}

