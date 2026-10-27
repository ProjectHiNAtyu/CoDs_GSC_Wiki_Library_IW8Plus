// scripts\mp\ob\systems\ob_container_spawn_closet.gsc  (hash_0cdd5dd8acedd45f.gscc) (size: 7692 Bytes / 0x1e0c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x849e2d92 (2224958866)
// size ...... 7692 (0x1e0c)
// includes .. 6   (offset: 0x1ce8)
// strings ... 18  (offset: 0x1d18)
// dev strs .. 1   (offset: 0x1e00)
// exports ... 18  (offset: 0x1288)
// cseg ...... 0x212 + 0x1076 (0x1288)
// imports ... 64  (offset: 0x1558)
// animtree1 . 0   (offset: 0x1e0c)
// animtree2 . 0   (offset: 0x1e0c)
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;

#namespace ob_container_spawn_closet;

// Namespace ob_container_spawn_closet
// Params 3
// Checksum 0x2c01722f, Offset: 0x230
// Size: 0x326
function function_e6f9ca6684759ebe( var_352724c3846e9c3a, var_38b635581d7f2442, override_zombie_droplist )
{
    spawn_closets = getentarray( var_352724c3846e9c3a, #script_noteworthy );
    
    foreach ( spawn_closet in spawn_closets )
    {
        spawn_closet.var_d0361b1d8c7f1ba3 = getent( spawn_closet.script_linkto, #script_linkname );
        spawn_closet.var_d0361b1d8c7f1ba3.count = 0;
        spawn_closet.var_d0361b1d8c7f1ba3 linkto( spawn_closet );
        spawn_closet.trigger_damage = getent( spawn_closet.var_d0361b1d8c7f1ba3.target, #targetname );
        spawn_closet.trigger_damage enablelinkto();
        spawn_closet.trigger_damage linkto( spawn_closet );
        player_clip = getent( spawn_closet.trigger_damage.target, #targetname );
        player_clip linkto( spawn_closet );
        container_clip = getent( player_clip.target, #targetname );
        container_clip linkto( spawn_closet );
        [ closet_scriptable ] = getscriptablearray( container_clip.target, #targetname );
        closet_scriptable enablelinkto();
        closet_scriptable linkto( spawn_closet );
        spawn_closet.closet_scriptable = closet_scriptable;
        
        if ( isdefined( spawn_closet.target ) )
        {
            start_struct = utility::getstruct( spawn_closet.target, "targetname" );
            spawn_closet.origin = start_struct.origin;
            spawn_closet.angles = start_struct.angles;
            spawn_closet.current_target = spawn_closet.target;
        }
        
        if ( isdefined( override_zombie_droplist ) )
        {
            spawn_closet.var_d0361b1d8c7f1ba3.override_zombie_droplist = override_zombie_droplist;
        }
    }
    
    fake_floor_structs = utility::getstructarray( var_38b635581d7f2442, "script_noteworthy" );
    
    foreach ( fake_floor_struct in fake_floor_structs )
    {
        fake_floor = getent( fake_floor_struct.target, #targetname );
        
        if ( isdefined( fake_floor ) )
        {
            fake_floor delete();
        }
    }
}

// Namespace ob_container_spawn_closet
// Params 1
// Checksum 0x2ad1d935, Offset: 0x55e
// Size: 0xde
function function_3be9c58b3da706bb( shutdown_flag )
{
    level endon( shutdown_flag );
    
    while ( !utility::flag( shutdown_flag ) )
    {
        self.trigger_damage waittill( #"damage", idamage, eattacker, vhitdir, vpoint, damagetype, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( eattacker ) && damage_effects::function_ae27c589e09c3181( damagetype ) )
        {
            if ( objweapon.basenamehash != %"t10_flash_grenade_mp" )
            {
                utility::flag_set( shutdown_flag );
                
                /#
                    iprintlnbold( "<dev string:x24>" );
                #/
            }
        }
    }
}

// Namespace ob_container_spawn_closet
// Params 1
// Checksum 0xb9651660, Offset: 0x644
// Size: 0xa2
function function_93d6853cd71db592( shutdown_flag )
{
    level endon( shutdown_flag );
    
    while ( !utility::flag( shutdown_flag ) )
    {
        self.var_d0361b1d8c7f1ba3 waittill( #"hash_22170fff358de300" );
        
        do
        {
            self.var_d0361b1d8c7f1ba3.var_189c5268f29a77ab = utility::array_removedead_or_dying( self.var_d0361b1d8c7f1ba3.var_189c5268f29a77ab );
            var_f73859b3123cac42 = self.trigger_damage getistouchingentities( self.var_d0361b1d8c7f1ba3.var_189c5268f29a77ab );
            wait 1;
        }
        while ( var_f73859b3123cac42.size > 0 );
        
        utility::flag_set( shutdown_flag );
    }
}

// Namespace ob_container_spawn_closet
// Params 2
// Checksum 0x9f5977b7, Offset: 0x6ee
// Size: 0x40
function function_75c19bb02c190f86( shutdown_weak_point, shutdown_flag )
{
    level endon( shutdown_flag );
    
    while ( !utility::flag( shutdown_flag ) )
    {
        shutdown_weak_point waittill( #"hash_69fb2f0d40e6b0f0" );
        utility::flag_set( shutdown_flag );
    }
}

// Namespace ob_container_spawn_closet
// Params 12
// Checksum 0x25cc9dcc, Offset: 0x736
// Size: 0xea
function function_3cdfb2ac6ce6549d( struct_targetname, shutdown_flag, var_a4c086caa1cbfd68, encounter_tag, shutdown_amount, time_out, var_9fd703e8e079c458, var_9ffa19e8e0a03c72, move_time = 5, rotate_time = 5, acceleration_time = 0.5, deceleration_time = 0.5 )
{
    utility::flag_clear( shutdown_flag );
    level endon( shutdown_flag );
    struct = utility::getstruct( struct_targetname, "targetname" );
    thread function_e2f5560f63a19f46( struct, move_time, rotate_time, acceleration_time, deceleration_time );
    wait max( move_time, rotate_time );
    thread function_eec83e80439c009b( shutdown_flag, var_a4c086caa1cbfd68, encounter_tag, shutdown_amount, time_out );
}

// Namespace ob_container_spawn_closet
// Params 5
// Checksum 0xc10ae679, Offset: 0x828
// Size: 0x9e
function function_e2f5560f63a19f46( var_ed92d3edd3eded9, move_time = 5, rotate_time = 5, acceleration_time = 0.5, deceleration_time = 0.5 )
{
    self.current_target = var_ed92d3edd3eded9.targetname;
    self moveto( var_ed92d3edd3eded9.origin, move_time, acceleration_time, deceleration_time );
    self rotateto( var_ed92d3edd3eded9.angles, rotate_time, acceleration_time, deceleration_time );
}

// Namespace ob_container_spawn_closet
// Params 8
// Checksum 0xc1e01dfa, Offset: 0x8ce
// Size: 0x1b2
function function_eec83e80439c009b( shutdown_flag, var_a4c086caa1cbfd68, encounter_tag, shutdown_amount, time_out, shutdown_weak_point, cleanup_flag, var_1672719186d5bc22 )
{
    utility::flag_clear( self.targetname );
    self.closet_scriptable setscriptablepartstate( "base", "open_id" );
    wait 2;
    self.closet_scriptable connectpaths();
    requestid = ai_spawn_director::spawn_request( var_a4c086caa1cbfd68, self.var_d0361b1d8c7f1ba3.origin, 20, 1, 1 );
    function_c505198907e0d306( requestid, self.var_d0361b1d8c7f1ba3, 1 );
    
    if ( isdefined( encounter_tag ) )
    {
        function_1a9d724a960fa19d( requestid, encounter_tag, 1 );
    }
    
    self.var_d0361b1d8c7f1ba3.shutdown_flag = shutdown_flag;
    self.var_d0361b1d8c7f1ba3.shutdown_amount = shutdown_amount;
    self.var_d0361b1d8c7f1ba3.var_a4c086caa1cbfd68 = var_a4c086caa1cbfd68;
    self.var_d0361b1d8c7f1ba3.var_189c5268f29a77ab = [];
    ai_spawn_director::add_spawned_callback( requestid, &function_7a69f5a657e24110, self.var_d0361b1d8c7f1ba3 );
    ai_spawn_director::function_c99d360d62c49a9c( requestid, &function_877cc7f38cab197b, self );
    ai_spawn_director::function_53289c032f506bb1( requestid, &function_84b4cbf7c849cc4f, self.var_d0361b1d8c7f1ba3 );
    
    if ( isdefined( shutdown_weak_point ) )
    {
        thread function_75c19bb02c190f86( shutdown_weak_point, shutdown_flag );
    }
    else
    {
        thread function_3be9c58b3da706bb( shutdown_flag );
        thread function_93d6853cd71db592( shutdown_flag );
    }
    
    if ( isdefined( time_out ) )
    {
        thread container_watch_for_timeout( shutdown_flag, time_out );
    }
    
    thread function_7ad41370b2673e95( shutdown_flag, var_1672719186d5bc22 );
    thread function_41de747edd5c7639( cleanup_flag );
}

// Namespace ob_container_spawn_closet
// Params 4
// Checksum 0xe70e7c0c, Offset: 0xa88
// Size: 0x311
function function_7a69f5a657e24110( requestid, var_d0361b1d8c7f1ba3, agent, data )
{
    data.spawnspeed = 2;
    
    if ( utility::cointoss() )
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "ADZ", 999 );
    }
    
    if ( agent.agent_type == "actor_sat_spawner_zombie_base_ob" || agent.agent_type == "actor_sat_spawner_zombie_base_ob_aries_unknown" )
    {
        agent namespace_659599414270bd0a::function_80623a2279a4d888();
    }
    else
    {
        agent val::set( "mars_parasites", "dont_evolve", 1 );
    }
    
    if ( agent.type == "zombie" && isdefined( var_d0361b1d8c7f1ba3.override_zombie_droplist ) )
    {
        agent.override_zombie_droplist = var_d0361b1d8c7f1ba3.override_zombie_droplist;
    }
    
    var_d0361b1d8c7f1ba3.var_189c5268f29a77ab[ var_d0361b1d8c7f1ba3.var_189c5268f29a77ab.size ] = agent;
    var_d0361b1d8c7f1ba3.count++;
    
    if ( var_d0361b1d8c7f1ba3.count >= var_d0361b1d8c7f1ba3.shutdown_amount )
    {
        var_d0361b1d8c7f1ba3 notify( #"hash_22170fff358de300" );
    }
    
    agent.angles = var_d0361b1d8c7f1ba3.angles;
    
    if ( level.players.size > 0 )
    {
        player = utility::get_closest_filtered( agent.origin, level.players );
    }
    else
    {
        return;
    }
    
    agent.favoriteenemy = player;
    agent function_fa32376aaa88a7a2( player.origin, 9000 );
    agent setgoalentity( player );
    
    if ( var_d0361b1d8c7f1ba3.var_a4c086caa1cbfd68 == "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild" )
    {
        agent.goalradius = 0;
        agent thread function_724e163176bddc7e( var_d0361b1d8c7f1ba3 );
    }
    
    if ( utility::flag( "flag_spawncloset_nerf" ) )
    {
        switch ( agent.basearchetype )
        {
            case #"hash_95ca02b3cab53ad5":
                if ( level.playercount > 2 || !level.is_squad_size_small )
                {
                    agent function_7d6dc7dae304843b( 3, 5, 8 );
                }
                else
                {
                    agent function_7d6dc7dae304843b( 3, 5, 8 );
                }
                
                break;
            case #"hash_c8364cded587d807":
                if ( level.playercount > 2 || !level.is_squad_size_small )
                {
                    agent function_7d6dc7dae304843b( 3, 5, 8 );
                }
                else
                {
                    agent function_7d6dc7dae304843b( 3, 5, 8 );
                }
                
                break;
        }
    }
    
    if ( agent.agent_type == "actor_sat_spawner_zombie_base_ob_aries" || agent.agent_type == "actor_sat_spawner_zombie_base_ob_aries_unknown" )
    {
        spawnpoint = agent.origin;
        var_5cfb21298117c9fd = squared( 512 );
        
        while ( agent.health > 0 && var_5cfb21298117c9fd < squared( 256 ) )
        {
            var_5cfb21298117c9fd = distance2dsquared( spawnpoint, agent.origin );
            wait 0.5;
        }
    }
}

// Namespace ob_container_spawn_closet
// Params 3
// Checksum 0xe5926125, Offset: 0xda1
// Size: 0x41
function function_7d6dc7dae304843b( i_spit_max_target_count, var_bc1e195d3ce91986, var_c79e08a5d32f74d4 )
{
    self function_786bb6aa1b76c7ee( "spit_max_target_count", i_spit_max_target_count );
    self.var_fe9bb2f0c2468d9a = var_bc1e195d3ce91986;
    self.var_95fe29c1ef1d5ac0 = var_c79e08a5d32f74d4;
}

// Namespace ob_container_spawn_closet
// Params 2
// Checksum 0xcb80deee, Offset: 0xdea
// Size: 0x26
function container_watch_for_timeout( shutdown_flag, time_out )
{
    level endon( shutdown_flag );
    wait time_out;
    utility::flag_set( shutdown_flag );
}

// Namespace ob_container_spawn_closet
// Params 2
// Checksum 0x67060b56, Offset: 0xe18
// Size: 0x57, Type: bool
function function_877cc7f38cab197b( requestid, spawn_closet )
{
    if ( spawn_closet.moving || !isdefined( spawn_closet.var_d0361b1d8c7f1ba3 ) || utility::flag( spawn_closet.var_d0361b1d8c7f1ba3.shutdown_flag ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_container_spawn_closet
// Params 2
// Checksum 0xf4b9f7ac, Offset: 0xe78
// Size: 0x50, Type: bool
function function_84b4cbf7c849cc4f( requestid, var_d0361b1d8c7f1ba3 )
{
    if ( !isdefined( var_d0361b1d8c7f1ba3 ) || utility::flag( var_d0361b1d8c7f1ba3.shutdown_flag ) || var_d0361b1d8c7f1ba3.count >= var_d0361b1d8c7f1ba3.shutdown_amount )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_container_spawn_closet
// Params 2
// Checksum 0xbc5fcd6a, Offset: 0xed1
// Size: 0x5c
function function_7ad41370b2673e95( shutdown_flag, var_1672719186d5bc22 = 1 )
{
    utility::flag_wait( shutdown_flag );
    self.closet_scriptable setscriptablepartstate( "base", "close_id" );
    wait 3;
    
    if ( var_1672719186d5bc22 )
    {
        self.closet_scriptable disconnectpaths();
    }
    
    thread function_79f79d226d17150e();
}

// Namespace ob_container_spawn_closet
// Params 1
// Checksum 0xcb8575c0, Offset: 0xf35
// Size: 0xe8
function function_41de747edd5c7639( cleanup_flag )
{
    self waittill( #"finished_ai_cleanup" );
    linked_children = self getlinkedchildren();
    
    foreach ( children in linked_children )
    {
        if ( children.code_classname != "scriptable" && children.code_classname != "script_brushmodel" )
        {
            children delete();
            continue;
        }
        
        if ( children.code_classname == "script_brushmodel" )
        {
            children thread flag_wait_clean_up( cleanup_flag );
        }
    }
    
    self delete();
}

// Namespace ob_container_spawn_closet
// Params 1
// Checksum 0x5335f4fa, Offset: 0x1025
// Size: 0x21
function flag_wait_clean_up( cleanup_flag )
{
    if ( isdefined( cleanup_flag ) )
    {
        utility::flag_wait( cleanup_flag );
        self delete();
    }
}

// Namespace ob_container_spawn_closet
// Params 0
// Checksum 0x8775a6ed, Offset: 0x104e
// Size: 0x18c
function function_79f79d226d17150e()
{
    a_ai = getaiarrayinradius( self.var_d0361b1d8c7f1ba3.origin, 200 );
    
    foreach ( ai in a_ai )
    {
        if ( ai istouching( self.trigger_damage ) )
        {
            ai.nocorpse = 1;
            ai.diequietly = 1;
            ai kill( self.origin );
        }
    }
    
    wait 0.2;
    a_ai = getaiarrayinradius( self.origin, 200 );
    
    foreach ( ai in a_ai )
    {
        if ( ai istouching( self.trigger_damage ) )
        {
            ai.nocorpse = 1;
            ai.diequietly = 1;
            ai kill( self.origin );
        }
    }
    
    self notify( #"finished_ai_cleanup" );
}

// Namespace ob_container_spawn_closet
// Params 1
// Checksum 0x7cae0c1, Offset: 0x11e2
// Size: 0xa6
function function_724e163176bddc7e( var_d0361b1d8c7f1ba3 )
{
    self.ignoreall = 1;
    var_87980f9a28eb226c = var_d0361b1d8c7f1ba3.origin + 160 * vectornormalize( anglestoforward( var_d0361b1d8c7f1ba3.angles ) );
    ground_pos = getgroundposition( var_87980f9a28eb226c, 1 );
    
    /#
        sphere( ground_pos, 25, ( 1, 1, 1 ), undefined, 1000 );
    #/
    
    self setgoalpos( ground_pos );
    self waittill( #"goal" );
    self setgoalentity( self );
    self.goalradius = 480;
    self.ignoreall = 0;
}

