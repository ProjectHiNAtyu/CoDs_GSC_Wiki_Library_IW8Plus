// scripts\mp\ob\systems\ob_escalation.gsc  (hash_1488e126087867fe.gscc) (size: 8375 Bytes / 0x20b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24cfbca3 (617594019)
// size ...... 8375 (0x20b7)
// includes .. 13  (offset: 0x1e9b)
// strings ... 29  (offset: 0x1f03)
// dev strs .. 2   (offset: 0x209f)
// exports ... 18  (offset: 0x13cb)
// cseg ...... 0x28d + 0x113e (0x13cb)
// imports ... 69  (offset: 0x169b)
// animtree1 . 0   (offset: 0x20b7)
// animtree2 . 0   (offset: 0x20b7)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_starter;
#using scripts\mp\ob\systems\ob_exfil_door;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\radiation;

#namespace ob_escalation;

// Namespace ob_escalation
// Params 0, eflags: 0x5
// Checksum 0x547e46cb, Offset: 0x2ab
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ob_escalation", #"region_difficulty_manager", &_pre_main_init, &_post_main_init );
}

// Namespace ob_escalation
// Params 0, eflags: 0x4
// Checksum 0x42852d9d, Offset: 0x2d8
// Size: 0xc1
function private _pre_main_init()
{
    if ( !getdvarint( @"ob_escalation_enabled", 0 ) )
    {
        return;
    }
    
    if ( !level.var_bb86f77304f193c4.regiondifficultyenabled && level.var_bb86f77304f193c4.var_96de51e7c7623219 )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level._effect[ "vfx_skycrack_falling_embers" ] = loadfxasset( "vfx_sat_wc_cradle_skycrack_debris_falling_a" );
    callback::add( #"player_connect", &function_2211db4a758fb20b );
    
    if ( !function_784a0500412ffc56() )
    {
        callback::add( #"hash_5848300c673f351a", &function_5d7a55b875c456a2 );
    }
    
    if ( !level.ob_escalation )
    {
        level.ob_escalation = {};
    }
    
    utility::flag_set( "ob_escalation_initialized" );
}

// Namespace ob_escalation
// Params 0, eflags: 0x4
// Checksum 0x74f8bce1, Offset: 0x3a1
// Size: 0x25
function private _post_main_init()
{
    if ( !utility::flag( "ob_escalation_initialized" ) )
    {
        return;
    }
    
    if ( game_utility_mp::function_82e3606d184524fe() != 0 )
    {
        level thread do_cloud();
    }
}

// Namespace ob_escalation
// Params 1, eflags: 0x4
// Checksum 0xc9643eda, Offset: 0x3ce
// Size: 0x43
function private function_2211db4a758fb20b( params )
{
    if ( !level.var_bb86f77304f193c4.pvpsettings.var_898a321c5d608958 )
    {
        self.pvpdisabled = 1;
        self.var_5eaebe6e973bbb7b = 1;
    }
}

// Namespace ob_escalation
// Params 1, eflags: 0x4
// Checksum 0xec9ddaea, Offset: 0x419
// Size: 0xc2
function private function_5d7a55b875c456a2( params )
{
    level.ob_escalation.radiation_origin = getdvarvector( @"hash_6a0100451b136e00", ( -33348, 36870, 0 ) );
    
    if ( level.var_e584ab91aed38e8c.size == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level.ob_escalation.var_dedc7dcd0dafaf3d = sortbydistance( level.exfilspawnpoints, level.ob_escalation.radiation_origin )[ level.exfilspawnpoints.size - 1 ];
    level.exfilspawnpoints = arrayremove( level.exfilspawnpoints, level.ob_escalation.var_dedc7dcd0dafaf3d );
}

// Namespace ob_escalation
// Params 0
// Checksum 0xfd37365c, Offset: 0x4e3
// Size: 0x24
function function_16820bdfebb5ea06()
{
    if ( !level.ob_escalation )
    {
        level.ob_escalation = { #var_14266a83b5808d8d:1 };
    }
}

// Namespace ob_escalation
// Params 0
// Checksum 0xa3b0c499, Offset: 0x50f
// Size: 0x15
function function_784a0500412ffc56()
{
    return level.ob_escalation.var_14266a83b5808d8d;
}

// Namespace ob_escalation
// Params 1
// Checksum 0x707e9aa0, Offset: 0x52d
// Size: 0xd4
function function_b298bdc27f28aad3( time )
{
    if ( time <= 0 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"cancel_ob_escalation" );
    setomnvar( "ui_hardpoint_timer", int( gettime() + 1000 * time ) );
    obj_id = objidpoolmanager::requestobjectiveid( 1 );
    objidpoolmanager::objective_add_objective( obj_id, "empty", ( 0, 0, 0 ), level.exfildoors.closedicon, "icon_regular" );
    objidpoolmanager::objective_showtimer( obj_id, 1 );
    setomnvar( "ui_ob_exfil_portal_objective_id", obj_id );
    utility::waittill_notify_or_timeout( "cancel_ob_escalation", time );
    objidpoolmanager::objective_showtimer( obj_id, 0 );
    setomnvar( "ui_ob_exfil_portal_objective_id", -1 );
    objidpoolmanager::returnobjectiveid( obj_id );
}

// Namespace ob_escalation
// Params 2
// Checksum 0x21c955e0, Offset: 0x609
// Size: 0x2e6
function do_cloud( delay, duration )
{
    self notify( #"hash_bf6da6521164d193" );
    self endon( #"hash_bf6da6521164d193" );
    
    if ( !getdvarint( @"hash_fd6c204f09c17b83", 1 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"cancel_ob_escalation" );
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    
    /#
        if ( isdefined( level.ob_escalation.radiation ) )
        {
            level.ob_escalation.radiation radiation::destroy();
            level callback::remove( #"player_death", &on_player_death_aether_storm );
        }
        
        if ( delay < 0 )
        {
            factor = float( duration ) / getdvarfloat( @"hash_aa57cd34912b0bfa", 1140 );
            initial_radius = math::lerp( 1, 150000, 1 - factor );
        }
    #/
    
    if ( !isdefined( delay ) )
    {
        delay = getdvarfloat( @"hash_21997fc91690c9b9", 2100 );
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    level callback::callback( "aether_storm_expansion_started" );
    utility::flag_set( "aether_storm_expansion_started" );
    setomnvar( "ui_br_circle_state", 9 );
    setomnvar( "ui_br_circle_state", 12 );
    radiusdamage( level.ob_escalation.radiation_origin, 2000, 50, 20 );
    playsoundatpos( level.ob_escalation.radiation_origin, "exp_bombsite_lr" );
    earthquake( 0.7, 3, level.ob_escalation.radiation_origin, 20000 );
    hud_util::showsplashtoall( #"hash_3965098d41ed17e8" );
    
    if ( !isdefined( duration ) )
    {
        duration = getdvarfloat( @"hash_aa57cd34912b0bfa", 1140 );
    }
    
    level.ob_escalation.radiation = radiation::create( level.ob_escalation.radiation_origin, initial_radius ?? 1, 1, "Radiation_Ob", 1 );
    level.ob_escalation.radiation callback::add( "player_entered_radiation", &on_player_enter_aether_storm );
    level.ob_escalation.radiation callback::add( "player_exited_radiation", &on_player_exit_aether_storm );
    level callback::add( #"player_death", &on_player_death_aether_storm );
    level.ob_escalation.radiation callback::add( "radiation_transform_update", &function_46317bed7f18df71 );
    level.ob_escalation.radiation radiation::transform( level.ob_escalation.radiation_origin, 150000, duration );
    level childthread agents_update();
}

// Namespace ob_escalation
// Params 1
// Checksum 0xae81a792, Offset: 0x8f7
// Size: 0x62
function on_player_enter_aether_storm( params )
{
    if ( isdefined( params.player ) )
    {
        params.player utility::function_32b24db3127bff40( "aether_storm_sfx", "activate" );
        playfxontagforclients( utility::getfx( "vfx_skycrack_falling_embers" ), params.player, "tag_eye", params.player );
    }
}

// Namespace ob_escalation
// Params 1
// Checksum 0x8256ebc9, Offset: 0x961
// Size: 0x62
function on_player_exit_aether_storm( params )
{
    if ( isdefined( params.player ) )
    {
        params.player utility::function_32b24db3127bff40( "aether_storm_sfx", "off" );
        stopfxontagforclients( utility::getfx( "vfx_skycrack_falling_embers" ), params.player, "tag_eye", params.player );
    }
}

// Namespace ob_escalation
// Params 1
// Checksum 0xd69cec50, Offset: 0x9cb
// Size: 0x39
function on_player_death_aether_storm( params )
{
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "aether_storm_sfx", "off" );
        stopfxontagforclients( utility::getfx( "vfx_skycrack_falling_embers" ), self, "tag_eye", self );
    }
}

// Namespace ob_escalation
// Params 1
// Checksum 0x2e509b66, Offset: 0xa0c
// Size: 0x323
function function_46317bed7f18df71( params )
{
    if ( level.ob_escalation.radiation_update_waiting )
    {
        return;
    }
    
    level.ob_escalation.radiation_update_waiting = 1;
    wait 0.5;
    level.ob_escalation.radiation_update_waiting = undefined;
    
    if ( isdefined( level.var_e607236b193eb0c1 ) && isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
    {
        i = 0;
        
        while ( i < level.var_e607236b193eb0c1.var_9433e6119f67c877.size )
        {
            activity_starter = level.var_e607236b193eb0c1.var_9433e6119f67c877[ i ];
            
            if ( isdefined( activity_starter ) && radiation::is_position_inside( activity_starter.origin ) )
            {
                activity_starter.var_4d30a4ab99bcbf83 = undefined;
                activity_starter ob_activity_starter::hide_activity_starter();
            }
            
            i += 1;
        }
        
        level.var_e607236b193eb0c1.var_9433e6119f67c877 = function_5713d46873b29625( level.var_e607236b193eb0c1.var_9433e6119f67c877 );
    }
    
    var_676d82ee60430bba = 0;
    var_8ba99aaa4c08b3b2 = arraycopy( level.exfildoors.activedoors );
    
    foreach ( door in var_8ba99aaa4c08b3b2 )
    {
        if ( !radiation::is_position_inside( door.origin ) || door.location == level.ob_escalation.var_dedc7dcd0dafaf3d )
        {
            continue;
        }
        
        if ( door.nearbyplayers.size == 0 )
        {
            door.state = "closed";
            door notify( #"exfil_captured" );
            door notify( #"closed" );
            door thread ob_exfil_door::function_ae42eb835f799e63();
            continue;
        }
        
        var_676d82ee60430bba++;
    }
    
    remaining_exfils = [];
    
    foreach ( point in level.exfilspawnpoints )
    {
        if ( !radiation::is_position_inside( point.origin ) )
        {
            remaining_exfils[ remaining_exfils.size ] = point;
        }
    }
    
    level.exfilspawnpoints = remaining_exfils;
    
    if ( level.exfilspawnpoints.size == 0 && level.exfildoors.activedoors.size <= var_676d82ee60430bba && !level.ob_escalation.final_exfil_begun )
    {
        begin_final_exfil();
    }
}

// Namespace ob_escalation
// Params 0
// Checksum 0xdf8608d5, Offset: 0xd37
// Size: 0x91
function begin_final_exfil()
{
    if ( function_784a0500412ffc56() )
    {
        return;
    }
    
    if ( !isdefined( level.ob_escalation.var_dedc7dcd0dafaf3d ) )
    {
        assertmsg( "<dev string:x79>" );
        return;
    }
    
    if ( level.ob_escalation.final_exfil_begun )
    {
        return;
    }
    
    level.ob_escalation.final_exfil_begun = 1;
    hud_util::showsplashtoall( #"ob_door_final_escape" );
    wait 5;
    thread ob_exfil_door::spawnexfildoor( level.ob_escalation.var_dedc7dcd0dafaf3d, 1 );
}

// Namespace ob_escalation
// Params 0
// Checksum 0xec786eac, Offset: 0xdd0
// Size: 0x2ce
function agents_update()
{
    self notify( #"hash_bd2d9d2c9df4947c" );
    self endon( #"hash_bd2d9d2c9df4947c" );
    level endon( #"game_ended" );
    level.ob_escalation.radiation endon( #"radiation_destroyed" );
    var_dd77a4915a40fde6 = 0;
    nearby_agents = [];
    
    while ( level.ob_escalation.radiation.active )
    {
        nearby_agents = getaiarrayinradius( level.ob_escalation.radiation.origin, level.ob_escalation.radiation.radius * 1.25, "all" );
        
        foreach ( agent in nearby_agents )
        {
            if ( !isalive( agent ) )
            {
                var_dd77a4915a40fde6 += 0.1;
                continue;
            }
            
            if ( agent.type == "zombie" )
            {
                if ( !isdefined( agent.var_d6894f01a36b4ff3 ) )
                {
                    var_dd77a4915a40fde6 += 0.1;
                    continue;
                }
                else if ( level.ob_escalation.radiation radiation::is_position_inside( agent.origin ) )
                {
                    if ( !agent.var_169f013f86401cf6 )
                    {
                        agent.var_169f013f86401cf6 = 1;
                        agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
                        
                        if ( issubstr( agent.subclass, "zombie_base" ) && !agent utility::ent_flag( "disciple_bound" ) )
                        {
                            agent utility::function_32b24db3127bff40( "bound", "bound_on" );
                        }
                    }
                }
                else if ( agent.var_169f013f86401cf6 )
                {
                    agent.var_169f013f86401cf6 = 0;
                    var_fb2f98f9e8f799fa = agent.health;
                    agent region_difficulty_manager::function_410b4f83b0a5b98( region_difficulty_manager::get_region_difficulty( agent.origin ) );
                    
                    if ( var_fb2f98f9e8f799fa < agent.max_health )
                    {
                        agent.health = var_fb2f98f9e8f799fa;
                    }
                    
                    if ( issubstr( agent.subclass, "zombie_base" ) && !agent utility::ent_flag( "disciple_bound" ) )
                    {
                        agent utility::function_32b24db3127bff40( "bound", "bound_off" );
                    }
                }
            }
            
            var_dd77a4915a40fde6 += 1;
            
            if ( var_dd77a4915a40fde6 > 5 )
            {
                var_dd77a4915a40fde6 = 0;
                waitframe();
            }
        }
        
        var_dd77a4915a40fde6 = 0;
        wait 1;
    }
}

// Namespace ob_escalation
// Params 1
// Checksum 0x79fc83c9, Offset: 0x10a6
// Size: 0x2df
function function_44b901a0314f78df( difficulty = 0 )
{
    tags = [];
    
    switch ( difficulty )
    {
        case 0:
        case 1:
            tags = [ #"hash_fb3235e95a701eca":0, #"ob_zombie_encounter_light":getdvarint( @"hash_2c043a3b27dc9129", 1 ), #"ob_ambient_endgame":0, #"hash_36f587014744935e":0, #"hash_36f58a0147449877":0, #"hash_36f58901474496c4":0, #"hash_36f58c0147449bdd":1, #"difficulty_darkaether":0, #"difficulty_hard":0, #"difficulty_normal":0, #"difficulty_easy":1 ];
            break;
        case 2:
            tags = [ #"hash_fb3235e95a701eca":0, #"ob_ambient_endgame":0, #"hash_36f587014744935e":0, #"hash_36f58a0147449877":0, #"hash_36f58901474496c4":1, #"hash_36f58c0147449bdd":0, #"difficulty_darkaether":0, #"difficulty_hard":0, #"difficulty_normal":1, #"difficulty_easy":0 ];
            break;
        case 3:
            tags = [ #"hash_fb3235e95a701eca":1, #"ob_ambient_endgame":0, #"hash_36f587014744935e":0, #"hash_36f58a0147449877":1, #"hash_36f58901474496c4":0, #"hash_36f58c0147449bdd":0, #"difficulty_darkaether":0, #"difficulty_hard":1, #"difficulty_normal":0, #"difficulty_easy":0 ];
            break;
        case 4:
            tags = [ #"hash_fb3235e95a701eca":1, #"ob_ambient_endgame":0, #"hash_36f587014744935e":1, #"hash_36f58a0147449877":0, #"hash_36f58901474496c4":0, #"hash_36f58c0147449bdd":0, #"difficulty_darkaether":1, #"difficulty_hard":0, #"difficulty_normal":0, #"difficulty_easy":0 ];
            break;
        case 5:
            tags = [ #"hash_fb3235e95a701eca":1, #"ob_ambient_endgame":1, #"hash_36f587014744935e":0, #"hash_36f58a0147449877":0, #"hash_36f58901474496c4":0, #"hash_36f58c0147449bdd":0, #"difficulty_darkaether":1, #"difficulty_hard":0, #"difficulty_normal":0, #"difficulty_easy":0 ];
            break;
    }
    
    return tags;
}

// Namespace ob_escalation
// Params 1, eflags: 0x4
// Checksum 0x30483af7, Offset: 0x138e
// Size: 0x3c
function private function_cbcb4cf669191d2d( instance )
{
    return common_item::items_selectfromlist( instance.difficultylist.list, instance.difficultylist.quantity );
}

