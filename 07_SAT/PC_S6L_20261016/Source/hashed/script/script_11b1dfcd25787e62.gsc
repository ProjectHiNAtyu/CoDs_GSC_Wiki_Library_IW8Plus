// script_11b1dfcd25787e62  (hash_11b1dfcd25787e62.gscc) (size: 19179 Bytes / 0x4aeb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb44a7990 (3024779664)
// size ...... 19179 (0x4aeb)
// includes .. 17  (offset: 0x46e3)
// strings ... 37  (offset: 0x476b)
// dev strs .. 31  (offset: 0x4977)
// exports ... 69  (offset: 0x294b)
// cseg ...... 0x317 + 0x2634 (0x294b)
// imports ... 159 (offset: 0x3413)
// animtree1 . 0   (offset: 0x4aeb)
// animtree2 . 0   (offset: 0x4aeb)
#using script_73b5bd3338b6bce4;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\ob\systems\ob_exfil_door;
#using scripts\mp\objidpoolmanager;

#namespace ob_ally_guild_bot;

/#

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x5
    // Checksum 0xfe57efa2, Offset: 0x335
    // Size: 0x1c, Type: dev
    function private autoexec __init__system__()
    {
        system::register( #"sat_ob_ally_guild_bot", undefined, undefined, &post_main );
    }

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0xc0ab2630, Offset: 0x359
    // Size: 0xc, Type: dev
    function private post_main()
    {
        devgui_init();
    }

#/

// Namespace ob_ally_guild_bot
// Params 2
// Checksum 0x7c6b683c, Offset: 0x36d
// Size: 0xfd
function do_spawn( ai_type, aparams )
{
    if ( !ai_type )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    function_dae30526b3926999( aparams.death_explosion_params );
    userdata = { #aparams:aparams, #owner:self };
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", aparams.managed_group_id, &function_4abc67f473410cc4, userdata );
    ai_spawn_director::function_9893a28f1d682a28( aparams.managed_group_id, ai_type, aparams.location, self.angles, 1, 0, 1, self.team );
    assert( !level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) );
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x72e003b3, Offset: 0x472
// Size: 0x6c
function private function_dae30526b3926999( aparams )
{
    if ( !level._effect[ aparams.vfx ] )
    {
        level._effect[ aparams.vfx ] = loadfxasset( aparams.vfx );
    }
    
    assert( level._effect[ aparams.vfx ], "<dev string:x69>" );
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xe94e5a9f, Offset: 0x4e6
// Size: 0xab
function private function_8c5e06ee1e60aeb7( params )
{
    if ( params.einflictor.agent_type != #"sat_ob_ally_guild_bot" )
    {
        return;
    }
    
    guild_bot = params.einflictor;
    
    if ( guild_bot.currenttarget == params.victim && guild_bot.var_37fde8ee38ad094a == "update_combat_position" )
    {
        guild_bot clearenemy();
        guild_bot asm_bb::bb_clearmeleetarget();
        guild_bot clearbtgoal( 3 );
        guild_bot setgoalpos( guild_bot.origin );
        guild_bot.var_37fde8ee38ad094a = undefined;
    }
}

// Namespace ob_ally_guild_bot
// Params 2
// Checksum 0xea969763, Offset: 0x599
// Size: 0x47
function function_943d8dd3946c8611( aparams, guild_bot )
{
    if ( aparams.smeansofdeath == "MOD_MELEE" && guild_bot && guild_bot.var_521ed6bcb7ebcbb0 )
    {
        function_f1a6418a70c1740b( guild_bot );
    }
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xe582ca3d, Offset: 0x5e8
// Size: 0x202
function private function_f1a6418a70c1740b( guild_bot )
{
    swarm_data = guild_bot.var_521ed6bcb7ebcbb0;
    
    /#
        if ( getdvarint( @"hash_212654c94e942179", 0 ) )
        {
            sphere( guild_bot.origin, swarm_data.check_radius, ( 1, 0, 0 ), 1, 30 );
        }
    #/
    
    wrist_origin = guild_bot gettagorigin( "j_wrist_ri" );
    playfx( swarm_data.attack_vfx, wrist_origin );
    var_892fe0140557dda1 = guild_bot get_nearby_ai( guild_bot.origin, swarm_data.check_radius );
    
    if ( var_892fe0140557dda1.size < swarm_data.var_258b7dc6c1bbbd92 )
    {
        return;
    }
    
    attack_origin = swarm_data.var_a0e3497b50010602 ? wrist_origin : guild_bot.origin;
    
    /#
        if ( getdvarint( @"hash_212654c94e942179", 0 ) )
        {
            sphere( attack_origin, swarm_data.attack_radius, ( 0, 0, 1 ), 1, 30 );
        }
    #/
    
    var_f2fb9e2e65d1d6d6 = guild_bot get_nearby_ai( attack_origin, swarm_data.attack_radius );
    
    foreach ( agent in var_f2fb9e2e65d1d6d6 )
    {
        if ( !agent zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            agent zombie_knockdown::function_6fc167d4a3590991( attack_origin, swarm_data.attack_impulse, swarm_data.attack_angle );
        }
        
        if ( agent != self )
        {
            agent dodamage( swarm_data.attack_damage, attack_origin, guild_bot.owner, guild_bot, "MOD_PROJECTILE_SPLASH" );
        }
    }
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xb668cb4e, Offset: 0x7f2
// Size: 0xc9
function private get_nearby_ai( origin, radius )
{
    var_867e6d3c28e16267 = [];
    var_ce6d2397a480b9a0 = getaiarrayinradius( origin, radius );
    
    foreach ( agent in var_ce6d2397a480b9a0 )
    {
        if ( !isalive( agent ) || agent.team == self.team )
        {
            continue;
        }
        
        var_867e6d3c28e16267[ var_867e6d3c28e16267.size ] = agent;
    }
    
    return var_867e6d3c28e16267;
}

// Namespace ob_ally_guild_bot
// Params 4, eflags: 0x4
// Checksum 0x133415b3, Offset: 0x8c4
// Size: 0x308
function private function_4abc67f473410cc4( groupid, userdata, guild_bot, var_6d63bc1fea0a37c2 )
{
    owner = userdata.owner;
    aparams = userdata.aparams;
    guild_bot.owner = owner;
    guild_bot.team = owner.team;
    owner.activecompanion = guild_bot;
    guild_bot zombie_utils::function_c2cee1190760989c( owner );
    guild_bot.distances = aparams.distances;
    guild_bot.actioncooldown = aparams.cooldowns;
    guild_bot.wander_data = aparams.wander_data;
    guild_bot.var_611078ba810d865a = aparams.var_611078ba810d865a;
    guild_bot.var_f6f934adb2ca08fd = [];
    guild_bot.revive_teammate_score_event = aparams.revive_teammate_score_event;
    guild_bot.var_62eb9a798fdb4b6c = aparams.var_62eb9a798fdb4b6c;
    guild_bot.var_789cb6b6be71394b = aparams.var_789cb6b6be71394b;
    guild_bot.dontmeleeme = 0;
    guild_bot.lookfordoorsalongpath = 1;
    guild_bot.dontattackme = 0;
    guild_bot.newenemyreaction = 0;
    guild_bot.forcenewenemyreaction = 0;
    guild_bot.dontsyncmelee = 1;
    guild_bot.var_f804f723ca248cee = 1;
    guild_bot val::set( #"sat_ob_ally_guild_bot", "disallow_stun", 1 );
    guild_bot val::set( #"sat_ob_ally_guild_bot", "disallow_slow", 1 );
    guild_bot val::set( #"sat_ob_ally_guild_bot", "disallow_knockdown", 1 );
    guild_bot pushplayer( 1 );
    guild_bot setcanusecover( 0 );
    guild_bot disableexecutionvictim();
    guild_bot ai::disable_long_death();
    guild_bot function_a56384645868237a( aparams.objective_image, aparams.objective_text );
    guild_bot create_squad_objective( aparams.objective_image, aparams.objective_text );
    guild_bot ob_ally_guild_bot_revive::setup();
    guild_bot thread function_5af8dfb87e340bf3( aparams );
    weapon = guild_bot.weapon;
    userdata.weaponname = isxhashasset( weapon ) ? weapon : isstring( weapon ) ? getxhashasset( weapon ) : weapon.basenamehash;
    guild_bot callback::add( "killed_body_cloned", &on_killed_body_cloned, userdata );
    guild_bot [[ aparams.on_spawn_callback ]]( owner );
    guild_bot callback::add( #"on_ai_killed", &function_2c5153c38516e2bf );
    
    /#
        guild_bot thread function_f8d34429b70a241c();
    #/
    
    owner callback::callback( "spawn_ally_guild_bot", { #guild_bot:guild_bot } );
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xe91d730b, Offset: 0xbd4
// Size: 0x40
function private function_2c5153c38516e2bf( params )
{
    if ( self.owner_objective )
    {
        objective_delete( self.owner_objective );
    }
    
    if ( self.squad_objective )
    {
        objective_delete( self.squad_objective );
    }
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x83232906, Offset: 0xc1c
// Size: 0xea
function private function_5af8dfb87e340bf3( aparams )
{
    awareness_delay = aparams.awareness_delay;
    
    if ( awareness_delay )
    {
        msg = utility::waittill_notify_or_timeout_return( "death", awareness_delay );
        
        if ( msg != "timeout" )
        {
            return;
        }
    }
    
    awareness_distance = aparams.distances[ "perfect_awareness_zone" ];
    awareness_height = aparams.distances[ "update_combat_max_vertical_distance" ];
    perfect_awareness_volume = spawn( "noent_volume_trigger_radius", self.origin, 0, awareness_distance, awareness_height );
    self function_23741795e43fc95c( perfect_awareness_volume );
    
    while ( true )
    {
        perfect_awareness_volume.origin = self.origin;
        msg = utility::waittill_notify_or_timeout_return( "death", 3 );
        
        if ( msg != "timeout" )
        {
            break;
        }
    }
    
    perfect_awareness_volume delete();
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x8ea16c75, Offset: 0xd0e
// Size: 0x45
function private function_a56384645868237a( objective_image, objective_text )
{
    self.owner_objective = function_6ae004ca2f6fdaca( objective_image, objective_text, 255, 255, 0 );
    objidpoolmanager::objective_playermask_addshowplayer( self.owner_objective, self.owner );
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xc588b6c9, Offset: 0xd5b
// Size: 0xcf
function private create_squad_objective( objective_image, objective_text )
{
    self.squad_objective = function_6ae004ca2f6fdaca( objective_image, objective_text, 0, 128, 255 );
    var_538c0694c880e740 = self.owner squad_utility::getsquadmembers();
    
    foreach ( member in var_538c0694c880e740 )
    {
        if ( member != self.owner )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.squad_objective, member );
        }
    }
}

// Namespace ob_ally_guild_bot
// Params 5, eflags: 0x4
// Checksum 0xbfe6df5b, Offset: 0xe32
// Size: 0xa9
function private function_6ae004ca2f6fdaca( objective_image, objective_text, tint_r, tint_g, tint_b )
{
    objective_id = objidpoolmanager::requestobjectiveid( 0 );
    objidpoolmanager::objective_add_objective( objective_id, "current", self.origin, objective_image, "icon_regular" );
    objidpoolmanager::update_objective_onentity( objective_id, self );
    objidpoolmanager::objective_playermask_hidefromall( objective_id );
    objidpoolmanager::function_373aaf492aabde6f( objective_id, tint_r, tint_g, tint_b, 1 );
    objidpoolmanager::objective_showdistance( objective_id, 0 );
    function_771fb62e0d43ad8( objective_id, objective_text );
    objective_setbackground( objective_id, 1 );
    objective_setzoffset( objective_id, 90 );
    return objective_id;
}

/#

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0x64dbc86f, Offset: 0xee4
    // Size: 0x7a, Type: dev
    function private function_f8d34429b70a241c()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( self.desireddistance && getdvarint( @"hash_173b29302edadd92", 0 ) )
            {
                color = get_debug_sphere_color( self.var_37fde8ee38ad094a );
                sphere( self.owner.origin, self.desireddistance, color, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_ally_guild_bot
    // Params 1, eflags: 0x4
    // Checksum 0x977219b5, Offset: 0xf66
    // Size: 0x6e, Type: dev
    function private get_debug_sphere_color( action )
    {
        if ( action == "<dev string:x96>" )
        {
            return ( 0, 1, 0 );
        }
        else if ( action == "<dev string:xa3>" )
        {
            return ( 1, 0, 0 );
        }
        else if ( action == "<dev string:xb7>" )
        {
            return ( 0, 0, 1 );
        }
        
        return ( 1, 1, 0 );
    }

#/

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xb1e9edd8, Offset: 0xfdc
// Size: 0x35
function private on_killed_body_cloned( aparams, userdata )
{
    aparams.body endon( #"death" );
    thread do_death_explosion( aparams, userdata );
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x5636e95b, Offset: 0x1019
// Size: 0x9b
function private do_death_explosion( aparams, userdata )
{
    death_explosion_params = userdata.aparams.death_explosion_params;
    
    if ( death_explosion_params.delay )
    {
        wait death_explosion_params.delay;
    }
    
    explode( userdata );
    
    if ( aparams.body )
    {
        aparams.body delete();
    }
    
    if ( userdata.owner )
    {
        userdata.owner notify( #"ally_guild_bot_destroyed" );
    }
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xa44fd696, Offset: 0x10bc
// Size: 0x21f
function private explode( userdata )
{
    death_explosion_params = userdata.aparams.death_explosion_params;
    
    /#
        if ( getdvarint( @"hash_6867572c73313f8b", 0 ) )
        {
            sphere( self.origin, death_explosion_params.radius, ( 1, 0, 0 ), 1, 30 );
        }
    #/
    
    earthquake( death_explosion_params.earthquake_scale, death_explosion_params.earthquake_duration, self.origin, death_explosion_params.radius );
    weaponname = userdata.weaponname;
    enemy_ai = get_nearby_ai( self.origin, death_explosion_params.radius );
    
    foreach ( enemy in enemy_ai )
    {
        enemy dodamage( death_explosion_params.damage, self.origin, userdata.owner, undefined, "MOD_EXPLOSIVE", weaponname, "torso_upper" );
    }
    
    self.var_c0b2e8ebae7fced0 = &ignore_vehicle_damage;
    self.owner = userdata.owner;
    self radiusdamage( self.origin, death_explosion_params.radius, death_explosion_params.damage, 1, self, "MOD_MELEE", "<explicitweaponnone>", 1 );
    self.var_c0b2e8ebae7fced0 = undefined;
    self.owner = undefined;
    playfx( level._effect[ death_explosion_params.vfx ], self.origin );
    playsoundatpos( self.origin + ( 0, 0, 5 ), #"hash_40ef3497abe6f53f" );
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x22300852, Offset: 0x12e3
// Size: 0x52, Type: bool
function private ignore_vehicle_damage( vehicle )
{
    if ( self.owner player_utility::function_cb195d25060312a( vehicle ) )
    {
        return true;
    }
    
    if ( self.owner player_utility::function_36e9830807a5007( vehicle ) )
    {
        return true;
    }
    
    if ( self.owner player_utility::function_452d7021e128ff08( vehicle ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0xc
// Checksum 0x8725a277, Offset: 0x133e
// Size: 0xb7
function private function_62f38dc947f4d41c( move_speed )
{
    self notify( #"hash_dbbd67aabff665f2" );
    self endon( #"hash_dbbd67aabff665f2" );
    self endon( #"death" );
    self.reachedtarget = 0;
    self aisetdesiredspeed( move_speed );
    
    /#
        if ( getdvarint( @"hash_c1ee37c6ff2f74ee", 0 ) )
        {
            sphere( self.targetpos, 10, ( 0, 1, 1 ), 0, 150 );
        }
    #/
    
    self setbtgoalpos( 3, self.targetpos );
    msg = utility::waittill_any_return( "bt_goal", "bad_path" );
    handle_goal_result( msg );
    self.reachedtarget = 1;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x628a1144, Offset: 0x13fd
// Size: 0x53
function private handle_goal_result( msg )
{
    if ( msg == "bad_path" )
    {
        if ( self.should_teleport_on_fail )
        {
            thread function_83da3205e9b1478( 90 );
        }
        
        if ( self.var_4339493427dae5a6 )
        {
            self.var_4a1ef5432da98876 = 1;
            function_aecc0da25e92826f( self.var_37fde8ee38ad094a );
        }
    }
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x69fa4e11, Offset: 0x1458
// Size: 0x1a
function private function_aecc0da25e92826f( var_40829265aee4392d )
{
    self.var_f6f934adb2ca08fd[ var_40829265aee4392d ] = 0;
}

// Namespace ob_ally_guild_bot
// Params 2
// Checksum 0x6321a228, Offset: 0x147a
// Size: 0xe4
function get_front_position( target, distancefromplayer )
{
    var_15be0a02a972604d = vectornormalize( target.origin - self.origin );
    targetorigin = target.origin + ( var_15be0a02a972604d[ 0 ] * -1, var_15be0a02a972604d[ 1 ] * -1, 0 ) * distancefromplayer;
    safeorigin = self getclosestreachablepointonnavmesh( targetorigin, 0 );
    maxdist = squared( 1200 );
    
    if ( !isdefined( safeorigin ) || distance2dsquared( safeorigin, target.origin ) > maxdist )
    {
        safeorigin = getclosestpointonnavmesh( targetorigin, self, undefined, undefined, 0 );
        
        if ( !isdefined( safeorigin ) || distance2dsquared( safeorigin, target.origin ) > maxdist )
        {
            safeorigin = undefined;
        }
    }
    
    if ( isdefined( safeorigin ) )
    {
        safeorigin = getgroundposition( safeorigin, 15 );
    }
    
    return safeorigin;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x820bcb7, Offset: 0x1567
// Size: 0x29
function private handle_traversals( var_40829265aee4392d )
{
    if ( var_40829265aee4392d == "wander" )
    {
        self enabletraversals( 0 );
        return;
    }
    
    self enabletraversals( 1 );
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xf39c4a7b, Offset: 0x1598
// Size: 0x22
function private function_1148d3732c44422c( var_40829265aee4392d )
{
    if ( var_40829265aee4392d == "revive_teammate" )
    {
        self.ignoreall = 1;
    }
}

// Namespace ob_ally_guild_bot
// Params 2
// Checksum 0x21c3e7cb, Offset: 0x15c2
// Size: 0x140
function function_2302933c94ec30b2( taskid, var_40829265aee4392d )
{
    assert( self.owner, "<dev string:xc7>" );
    self.currenttarget = get_target_ent( var_40829265aee4392d );
    
    if ( !self.currenttarget )
    {
        return anim.failure;
    }
    
    self.desireddistance = self.distances[ var_40829265aee4392d ];
    
    if ( self.desireddistance )
    {
        self.desireddistance -= 10;
    }
    
    self.targetpos = get_target_pos( var_40829265aee4392d );
    
    if ( !self.targetpos )
    {
        return anim.failure;
    }
    
    self.should_teleport_on_fail = get_should_teleport_on_fail( var_40829265aee4392d );
    self.var_4339493427dae5a6 = function_ca010c958e2007f5( var_40829265aee4392d );
    self.var_37fde8ee38ad094a = var_40829265aee4392d;
    self.desireddistance = self.distances[ var_40829265aee4392d ];
    
    if ( self.desireddistance )
    {
        self.desireddistance -= 10;
    }
    
    self.var_f6f934adb2ca08fd[ var_40829265aee4392d ] = gettime();
    handle_traversals( var_40829265aee4392d );
    function_1148d3732c44422c( var_40829265aee4392d );
    return anim.success;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x76c8a96f, Offset: 0x170b
// Size: 0x3f
function private get_target_ent( var_40829265aee4392d )
{
    if ( var_40829265aee4392d == "update_combat_position" )
    {
        return self.enemy;
    }
    
    if ( var_40829265aee4392d == "revive_teammate" )
    {
        return self.revivetarget;
    }
    
    return self.owner;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xc9caed38, Offset: 0x1753
// Size: 0x20, Type: bool
function private get_should_teleport_on_fail( var_40829265aee4392d )
{
    return var_40829265aee4392d == "follow_owner" || var_40829265aee4392d == "revive_teammate";
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x458b4aee, Offset: 0x177c
// Size: 0x14, Type: bool
function private function_ca010c958e2007f5( var_40829265aee4392d )
{
    return var_40829265aee4392d == "wander";
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x80099973, Offset: 0x1799
// Size: 0x51
function private get_target_pos( var_40829265aee4392d )
{
    if ( var_40829265aee4392d == "wander" )
    {
        return function_4ac209e5f1f28a8f();
    }
    
    if ( var_40829265aee4392d == "update_combat_position" )
    {
        return function_8e12c79774fb8b44( self.enemy );
    }
    
    return get_front_position( self.currenttarget, self.desireddistance );
}

// Namespace ob_ally_guild_bot
// Params 2
// Checksum 0x874a2b84, Offset: 0x17f3
// Size: 0x62
function function_ba57d282e9d00ec0( taskid, move_speed )
{
    assert( self.currenttarget, "<dev string:xfb>" );
    assert( self.targetpos, "<dev string:x135>" );
    assert( move_speed, "<dev string:x16b>" );
    thread function_62f38dc947f4d41c( move_speed );
    return anim.success;
}

// Namespace ob_ally_guild_bot
// Params 2
// Checksum 0xac18f52b, Offset: 0x185e
// Size: 0x52
function function_217bc6aeb24dc0ac( taskid, target_type )
{
    assert( self.currenttarget, "<dev string:x1a2>" );
    
    if ( istargetinrange_internal( self.currenttarget, target_type ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x55159bba, Offset: 0x18b9
// Size: 0x4c, Type: bool
function private istargetinrange_internal( target, target_type )
{
    distances = self.distances[ target_type ];
    return distancesquared( self.origin, target.origin ) < squared( distances );
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0xb0de167d, Offset: 0x190e
// Size: 0x4b
function function_c0a851f02d9a1b39( taskid )
{
    assert( self.owner, "<dev string:x1df>" );
    
    if ( !self.has_nearby_enemies && can_follow( self.owner, "follow_owner" ) )
    {
        return 2;
    }
    
    return 0;
}

// Namespace ob_ally_guild_bot
// Params 0, eflags: 0x4
// Checksum 0xdd012efc, Offset: 0x1962
// Size: 0xa7, Type: bool
function private function_99cf5fc7edf323a2()
{
    foreach ( door in level.exfildoors.activedoors )
    {
        vtol = door.escapevehicle;
        
        if ( vtol && vtol ob_exfil_door::function_a8ed7f4bb436e7a0( self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x3f4b706c, Offset: 0x1a12
// Size: 0xe5, Type: bool
function private can_follow( target, key )
{
    if ( !getdvarint( @"hash_d5ec93f6f0503ac", 1 ) )
    {
        return false;
    }
    
    if ( target function_99cf5fc7edf323a2() )
    {
        return false;
    }
    
    if ( function_b70cfe4ef7ebd5a8( key ) )
    {
        return false;
    }
    
    if ( self.var_37fde8ee38ad094a == "revive_teammate" || self.var_37fde8ee38ad094a == "update_combat_position" )
    {
        return false;
    }
    
    if ( target.laststandreviveent )
    {
        return false;
    }
    
    if ( istargetinrange_internal( self.owner, key ) )
    {
        return false;
    }
    
    distance_from_player = self.distances[ key ] - 10;
    position = get_front_position( target, distance_from_player );
    
    if ( !isdefined( position ) )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, position ) < squared( 200 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x34079f09, Offset: 0x1b00
// Size: 0x9e
function function_670f84c48ab6a001( taskid )
{
    if ( !getdvarint( @"hash_f86b7c82dd78c7b5", 1 ) )
    {
        return anim.failure;
    }
    
    if ( self.var_37fde8ee38ad094a == "revive_teammate" )
    {
        return anim.failure;
    }
    
    if ( !self.enemy )
    {
        return anim.failure;
    }
    
    if ( self.enemy.immune )
    {
        self clearenemy();
        return anim.failure;
    }
    
    if ( !self canshootenemy() )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x3216db42, Offset: 0x1ba7
// Size: 0xc6
function function_94f490e3bd94a0f4( taskid )
{
    if ( !getdvarint( @"hash_e50e118eb90a83bd", 1 ) )
    {
        return 0;
    }
    
    if ( function_b70cfe4ef7ebd5a8( "update_combat_position" ) )
    {
        return 0;
    }
    
    if ( self.var_37fde8ee38ad094a == "update_combat_position" )
    {
        return 0;
    }
    
    if ( !self.enemy )
    {
        return 0;
    }
    
    if ( self canshootenemy() )
    {
        return 0;
    }
    
    if ( self.enemy != self.var_1c3497d519561530 )
    {
        self.var_1c3497d519561530 = self.enemy;
        self.var_bb547cf0e9818979 = gettime();
    }
    
    if ( gettime() - self.var_bb547cf0e9818979 > self.var_611078ba810d865a )
    {
        self.var_1c3497d519561530 = undefined;
        self.var_bb547cf0e9818979 = 0;
        return 3;
    }
    
    return 0;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x5b35c1e9, Offset: 0x1c76
// Size: 0xea
function private function_8e12c79774fb8b44( enemy )
{
    var_789c7307bf230467 = self.distances[ "update_combat_max_horizontal_distance" ];
    var_e94c499876caa455 = self.distances[ "update_combat_max_vertical_distance" ];
    distance_to_target = self.distances[ "update_combat_target_offset" ];
    newlocation = function_c8bb944124742167( enemy.origin, distance_to_target, distance_to_target + 10 );
    
    if ( !newlocation )
    {
        return;
    }
    
    var_62e932568fd2d303 = distance2dsquared( self.owner.origin, newlocation );
    
    if ( var_62e932568fd2d303 > squared( var_789c7307bf230467 ) )
    {
        return;
    }
    
    var_ef44e9f025e66a19 = squared( newlocation[ 2 ] - self.owner.origin[ 2 ] );
    
    if ( var_ef44e9f025e66a19 > squared( var_e94c499876caa455 ) )
    {
        return;
    }
    
    return newlocation;
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x743f14d5, Offset: 0x1d69
// Size: 0x4a
function function_68fe63a4f602aee9( taskid )
{
    assert( self.owner, "<dev string:x215>" );
    
    if ( self.has_nearby_enemies && can_follow( self.owner, "follow_owner_combat" ) )
    {
        return 2;
    }
    
    return 0;
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x773ebe57, Offset: 0x1dbc
// Size: 0x38
function function_cec1c729f8eb9a1f( taskid )
{
    assert( self.owner, "<dev string:x251>" );
    
    if ( function_f2e7c97cd003cf8a( self.owner ) )
    {
        return 4;
    }
    
    return 0;
}

// Namespace ob_ally_guild_bot
// Params 3, eflags: 0x4
// Checksum 0xcea764de, Offset: 0x1dfd
// Size: 0x4f, Type: bool
function private function_50a004eb44ace11f( position, mindistance, maxdistance )
{
    horizontaldist = distance2d( position, self.owner.origin );
    return horizontaldist >= mindistance && horizontaldist <= maxdistance;
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x5045634b, Offset: 0x1e55
// Size: 0x44, Type: bool
function private function_fa53938a8d6aa41( position, maxdistance )
{
    verticaldist = abs( position[ 2 ] - self.owner.origin[ 2 ] );
    return verticaldist <= maxdistance;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x4b3fa791, Offset: 0x1ea2
// Size: 0x9a, Type: bool
function private function_f2e7c97cd003cf8a( target )
{
    if ( !getdvarint( @"ally_guild_bot_allow_teleport", 1 ) )
    {
        return false;
    }
    
    owner = self.owner;
    
    if ( self.var_cbd9cd09720bb3f4 )
    {
        return false;
    }
    
    if ( !function_2fdb646423d9a593( owner ) )
    {
        return false;
    }
    
    if ( function_50a004eb44ace11f( self.origin, 0, self.distances[ "horizontal_teleport" ] ) && function_fa53938a8d6aa41( self.origin, self.distances[ "vertical_teleport" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x6f381fd3, Offset: 0x1f45
// Size: 0x4e, Type: bool
function private function_2fdb646423d9a593( owner )
{
    if ( owner vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( owner iswingsuitdeployed() || owner isparachutedeployed() || !owner isonground() )
    {
        return false;
    }
    
    if ( self isonladder() || self ismantling() )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x76c76f4b, Offset: 0x1f9c
// Size: 0x2b
function function_fcbe34cd23418396( taskid )
{
    thread function_83da3205e9b1478( self.distances[ "post_teleport_distance" ] );
    return anim.success;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0xc
// Checksum 0x34d54c62, Offset: 0x1fd0
// Size: 0x100
function private function_83da3205e9b1478( var_12c07c6a7293a4ee )
{
    self notify( #"hash_6bf82e66696ff069" );
    self endon( #"hash_6bf82e66696ff069" );
    assert( var_12c07c6a7293a4ee, "<dev string:x290>" );
    self endon( #"death" );
    
    if ( !function_2fdb646423d9a593( self.owner ) )
    {
        return;
    }
    
    position = get_front_position( self.owner, var_12c07c6a7293a4ee );
    
    if ( !isdefined( position ) )
    {
        return;
    }
    
    self.var_cbd9cd09720bb3f4 = 1;
    self setscriptablepartstate( "teleport", "fade_out" );
    wait 1;
    
    if ( function_2fdb646423d9a593( self.owner ) )
    {
        self forceteleport( position, self.owner.angles );
        self setbtgoalpos( 3, self.origin );
        self setgoalpos( self.origin );
    }
    
    self setscriptablepartstate( "teleport", "fade_in" );
    wait 1;
    self.var_cbd9cd09720bb3f4 = 0;
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x898f09e3, Offset: 0x20d8
// Size: 0x38, Type: bool
function function_6247656309b531d5( taskid )
{
    assert( self.owner, "<dev string:x2ce>" );
    
    if ( can_wander( self.owner ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xe47dc47f, Offset: 0x2119
// Size: 0x67, Type: bool
function private can_wander( target )
{
    if ( !getdvarint( @"hash_1de6c185e20d67c0", 1 ) )
    {
        return false;
    }
    
    if ( self.reachedtarget == 0 || self.var_cbd9cd09720bb3f4 )
    {
        return false;
    }
    
    if ( function_b70cfe4ef7ebd5a8( "wander" ) )
    {
        return false;
    }
    
    if ( self.enemy && self canshootenemy() )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x3939df7b, Offset: 0x2189
// Size: 0x60, Type: bool
function private function_b70cfe4ef7ebd5a8( var_40829265aee4392d )
{
    can_check_cooldown = isdefined( self.var_f6f934adb2ca08fd[ var_40829265aee4392d ] ) && self.actioncooldown[ var_40829265aee4392d ];
    
    if ( can_check_cooldown && gettime() < self.var_f6f934adb2ca08fd[ var_40829265aee4392d ] + self.actioncooldown[ var_40829265aee4392d ] )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_ally_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x36cf15c7, Offset: 0x21f2
// Size: 0x51
function private function_4ac209e5f1f28a8f()
{
    result_pos = self.var_4a1ef5432da98876 ? function_20792934c8db414( self.origin ) : function_20792934c8db414( self.owner.origin );
    self.var_4a1ef5432da98876 = 0;
    return result_pos;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xa3b16d66, Offset: 0x224c
// Size: 0x163
function private function_20792934c8db414( searchorigin )
{
    traceoffset = ( 0, 0, 30 );
    overridecontents = trace::create_contents( 0, 1, 1, 1 );
    
    for ( i = 0; i < 10 ; i++ )
    {
        randpos = function_c8bb944124742167( searchorigin, self.wander_data.radius_min, self.wander_data.radius_max );
        
        if ( !randpos )
        {
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_36b061ec5dc316f", 0 ) )
            {
                sphere( searchorigin, self.wander_data.radius_min, ( 1, 1, 0 ), 1, 150 );
                sphere( searchorigin, self.wander_data.radius_max, ( 0, 0, 1 ), 1, 150 );
            }
        #/
        
        if ( distancesquared( self.origin, randpos ) < squared( self.wander_data.movement_distance ) )
        {
            continue;
        }
        
        result = trace::ray_trace( searchorigin + traceoffset, randpos + traceoffset, [ self ], overridecontents );
        
        if ( result[ "fraction" ] < 0.95 )
        {
            continue;
        }
        
        return randpos;
    }
}

// Namespace ob_ally_guild_bot
// Params 3, eflags: 0x4
// Checksum 0xca9b32e2, Offset: 0x23b8
// Size: 0xa7
function private function_c8bb944124742167( center, minradius, maxradius )
{
    angle = randomfloat( 360 );
    distance = randomfloatrange( minradius, maxradius );
    xoffset = distance * cos( angle );
    yoffset = distance * sin( angle );
    randpos = ( center[ 0 ] + xoffset, center[ 1 ] + yoffset, center[ 2 ] );
    navpos = getclosestpointonnavmesh( randpos, self, undefined, undefined, 0 );
    
    if ( !navpos )
    {
        return;
    }
    
    return getgroundposition( navpos, 15 );
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0x9bf779e7, Offset: 0x2468
// Size: 0xba
function on_player_pinged( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    player = params.player;
    guild_bot = player.guild_bot_ent;
    
    if ( !guild_bot )
    {
        return;
    }
    
    callout_ent = player calloutmarkerping_getent( params.pingindex );
    
    if ( callout_ent )
    {
        if ( callout_ent.origin && !guild_bot is_pos_reachable( callout_ent.origin ) )
        {
            return;
        }
        
        if ( function_8d71bf0179d9d9c7( callout_ent, guild_bot.team ) )
        {
            guild_bot function_3953751a50269d5a( callout_ent );
            guild_bot thread function_7b90ab28d46a585( callout_ent );
        }
    }
}

// Namespace ob_ally_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xd8d3e61e, Offset: 0x252a
// Size: 0x6f, Type: bool
function private function_8d71bf0179d9d9c7( callout_ent, guild_bot_team )
{
    if ( isai( callout_ent ) )
    {
        return ( callout_ent.team != guild_bot_team && isalive( callout_ent ) );
    }
    
    if ( callout_ent vehicle::is_vehicle() )
    {
        return ( isdefined( callout_ent.team ) && callout_ent.team != guild_bot_team && !callout_ent vehicle::is_destroyed() );
    }
    
    return false;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x40c6318c, Offset: 0x25a2
// Size: 0x2f
function private function_7b90ab28d46a585( victim )
{
    self endon( #"death" );
    victim waittill( #"death" );
    function_275c1fdf83748df1( victim );
}

// Namespace ob_ally_guild_bot
// Params 1
// Checksum 0xc9faaac4, Offset: 0x25d9
// Size: 0x7f
function function_81d22b5715e4cb21( params )
{
    player = params.player;
    guild_bot = player.guild_bot_ent;
    
    if ( !guild_bot )
    {
        return;
    }
    
    callout_ent = player calloutmarkerping_getent( params.pingindex );
    
    if ( callout_ent && ( isai( callout_ent ) || callout_ent vehicle::is_vehicle() ) )
    {
        guild_bot function_275c1fdf83748df1( callout_ent );
    }
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xf024f4b1, Offset: 0x2660
// Size: 0x61, Type: bool
function private is_pos_reachable( pos )
{
    if ( !pos )
    {
        return false;
    }
    
    if ( !getclosestpointonnavmesh( pos, self ) )
    {
        return false;
    }
    
    max_ping_radius = self.distances[ "ping_range" ];
    
    if ( max_ping_radius > 0 && distancesquared( self.origin, pos ) > squared( max_ping_radius ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x2189e2fa, Offset: 0x26ca
// Size: 0x4a
function private function_3953751a50269d5a( target )
{
    if ( !isdefined( self.ping_targets ) )
    {
        self.ping_targets = [];
    }
    
    self.ping_targets[ self.ping_targets.size ] = target;
    zombie_utils::set_ai_target_priority( target, "guildbot_ping", 999 );
}

// Namespace ob_ally_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x9457a098, Offset: 0x271c
// Size: 0x6e
function private function_275c1fdf83748df1( target )
{
    zombie_utils::set_ai_target_priority( target, "guildbot_ping", 0 );
    self.ping_targets = arrayremove( self.ping_targets, target );
    
    if ( self.ping_targets.size > 0 )
    {
        next_target = self.ping_targets[ self.ping_targets.size - 1 ];
        zombie_utils::set_ai_target_priority( next_target );
    }
}

// Namespace ob_ally_guild_bot
// Params 0
// Checksum 0x6b22178c, Offset: 0x2792
// Size: 0x6d
function destroy()
{
    assert( level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) );
    level callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    guild_bot = self.activecompanion;
    
    if ( guild_bot.is_reviving_teammate )
    {
        guild_bot waittill( #"ally_guild_bot_revive_finished" );
    }
    
    guild_bot kill();
}

/#

    // Namespace ob_ally_guild_bot
    // Params 0
    // Checksum 0x6d6aaa5f, Offset: 0x2807
    // Size: 0x9a, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x304>" );
        devgui::add_devgui_func( "<dev string:x334>", "<dev string:x343>", &function_22533f08b0dc0c39, 1, 100 );
        devgui::add_devgui_func( "<dev string:x357>", "<dev string:x366>", &function_caf095894afcfc6d, 1, 101 );
        devgui::add_devgui_func( "<dev string:x37a>", "<dev string:x399>", &function_881e77a426d3fac, 1, 102 );
        devgui::add_devgui_func( "<dev string:x3bd>", "<dev string:x3cc>", &function_5fc8f54b9bb8aee4, 1, 103 );
        devgui::add_devgui_func( "<dev string:x3e0>", "<dev string:x3f1>", &function_b68e23654e478237, 1, 104 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0x47cd2aff, Offset: 0x28a9
    // Size: 0x1a, Type: dev
    function private function_22533f08b0dc0c39()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x407>", @"hash_d5ec93f6f0503ac" );
    }

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0x93e0a4fa, Offset: 0x28cb
    // Size: 0x1a, Type: dev
    function private function_caf095894afcfc6d()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x423>", @"hash_1de6c185e20d67c0" );
    }

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0x32fe03a9, Offset: 0x28ed
    // Size: 0x1a, Type: dev
    function private function_881e77a426d3fac()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x43f>", @"hash_e50e118eb90a83bd" );
    }

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0x10d5490e, Offset: 0x290f
    // Size: 0x1a, Type: dev
    function private function_5fc8f54b9bb8aee4()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x46b>", @"hash_f86b7c82dd78c7b5" );
    }

    // Namespace ob_ally_guild_bot
    // Params 0, eflags: 0x4
    // Checksum 0xb771d857, Offset: 0x2931
    // Size: 0x1a, Type: dev
    function private function_b68e23654e478237()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x487>", @"ally_guild_bot_allow_teleport" );
    }

#/
