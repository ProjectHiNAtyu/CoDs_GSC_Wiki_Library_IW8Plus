// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_ee_scarf.gsc  (hash_689cb4531fef0acb.gscc) (size: 18095 Bytes / 0x46af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee133ab5 (3994237621)
// size ...... 18095 (0x46af)
// includes .. 20  (offset: 0x41bb)
// strings ... 60  (offset: 0x425b)
// dev strs .. 10  (offset: 0x4623)
// exports ... 37  (offset: 0x2beb)
// cseg ...... 0x4ed + 0x26fe (0x2beb)
// imports ... 132 (offset: 0x31b3)
// animtree1 . 0   (offset: 0x46af)
// animtree2 . 0   (offset: 0x46af)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_quest_ee_scarf;

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x5
// Checksum 0x6f445d45, Offset: 0x50b
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_ee_scarf", undefined, &pre_main, &post_main );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0x104ba632, Offset: 0x530
// Size: 0x90
function private pre_main()
{
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    level thread setup_scarf_quest();
    zm_quest::register_quest_step( #"mantis_ee_scarf", #"found_scarf", &function_e5f0fad12ddd6bdb, &function_35e19cec8e96e224 );
    zm_quest::register_quest_step( #"mantis_ee_scarf", #"passing_mannequin", &function_e5f0fbd12ddd6e0e, &function_35e19fec8e96e8bd );
    zm_quest::register_quest_step( #"mantis_ee_scarf", #"morse", &function_e5f0fcd12ddd7041, &function_35e19eec8e96e68a );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0x868a13b3, Offset: 0x5c8
// Size: 0x91
function private post_main()
{
    clip = getent( "scarf_mannequin_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "zm_sat_mantis_quest_ee_scarf_cs_completed" );
    zm_save::function_1f44a48caae2acbf();
    
    while ( function_88019988a923b7b0() )
    {
        /#
            if ( getdvarint( @"hash_1ef28e19509f7f3e", 0 ) )
            {
                break;
            }
        #/
        
        wait 1;
    }
    
    level thread zm_quest::start_quest( #"mantis_ee_scarf" );
    
    /#
        setup_scarf_ee_devgui();
    #/
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0x7eb0222d, Offset: 0x661
// Size: 0x33, Type: bool
function private function_88019988a923b7b0()
{
    wwq = level.zm_quests[ #"mantis_ww_quest" ];
    return wwq && !wwq.completed;
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0x364231b9, Offset: 0x69d
// Size: 0x4d
function private function_fff8803f7fcc8087()
{
    level._effect[ "scarf_soul_impact" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_hardcore_spawn" );
    level._effect[ "scarf_soul_trail" ] = loadfxasset( "vfx_sat_mantis_loot_cyst_trail" );
    level._effect[ "scarf_blast" ] = loadfxasset( "vfx_t10_gameplay_zm_device_blast_clean" );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0
// Checksum 0x95b9cb7a, Offset: 0x6f2
// Size: 0x520
function setup_scarf_quest()
{
    function_fff8803f7fcc8087();
    level utility::flag_wait( "scriptables_ready" );
    a_mannequins = utility::getstructarray( "scarf_mannequin_body", "script_noteworthy" );
    
    if ( !isdefined( level.scarf_ee ) )
    {
        level.scarf_ee = spawnstruct();
    }
    
    level.scarf_ee.var_1b497e7ce34254ff = [];
    
    foreach ( var_a55c75982cff1ac in a_mannequins )
    {
        var_a55c75982cff1ac.mdl = utility::spawn_model( "tag_origin", var_a55c75982cff1ac.origin, var_a55c75982cff1ac.angles );
        var_a55c75982cff1ac.mdl.mannequin = spawnscriptable( %"zm_sat_mantis_scarf_ee_mannequin", var_a55c75982cff1ac.origin, var_a55c75982cff1ac.angles );
        var_a55c75982cff1ac.mdl.mannequin utility::scriptable_setparententity( var_a55c75982cff1ac.mdl );
        
        if ( var_a55c75982cff1ac.mdl.mannequin )
        {
            var_a55c75982cff1ac.mdl.mannequin setscriptablepartstate( "base", var_a55c75982cff1ac.script_label );
        }
        
        a_arms = utility::getstructarray( var_a55c75982cff1ac.target );
        
        foreach ( s_arm in a_arms )
        {
            if ( s_arm.script_parameters == "left" )
            {
                var_a55c75982cff1ac.mdl.mannequin.arm_l = spawnscriptable( %"zm_sat_mantis_scarf_ee_mannequin_arm_l", s_arm.origin, s_arm.angles );
                
                if ( var_a55c75982cff1ac.mdl.mannequin.arm_l )
                {
                    var_a55c75982cff1ac.mdl.mannequin.arm_l setscriptablepartstate( "base", var_a55c75982cff1ac.script_label );
                }
                
                continue;
            }
            
            if ( s_arm.script_parameters == "right" )
            {
                var_a55c75982cff1ac.mdl.mannequin.arm_r = spawnscriptable( %"zm_sat_mantis_scarf_ee_mannequin_arm_r", s_arm.origin, s_arm.angles );
                
                if ( var_a55c75982cff1ac.mdl.mannequin.arm_r )
                {
                    var_a55c75982cff1ac.mdl.mannequin.arm_r setscriptablepartstate( "base", var_a55c75982cff1ac.script_label );
                }
            }
        }
        
        level.scarf_ee.var_1b497e7ce34254ff[ level.scarf_ee.var_1b497e7ce34254ff.size ] = var_a55c75982cff1ac.mdl.mannequin;
    }
    
    clip = getent( "scarf_mannequin_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip disconnectpaths();
        clip solid();
    }
    
    while ( function_88019988a923b7b0() )
    {
        /#
            if ( getdvarint( @"hash_1ef28e19509f7f3e", 0 ) )
            {
                break;
            }
        #/
        
        wait 1;
    }
    
    var_c5fb7b9c0ca383b7 = utility::getstruct( "scarf_ee_item", "script_noteworthy" );
    var_cc9dbb3fbaaec44e = utility::getstruct( "scarf_ee_interact", "script_noteworthy" );
    scarf_parent = utility::spawn_model( "tag_origin", var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    level.scarf_ee.scarf = spawnscriptable( %"zm_sat_mantis_ee_scarf", var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
    level.scarf_ee.scarf utility::scriptable_setparententity( scarf_parent );
    level.scarf_ee.scarf.parent = scarf_parent;
    level.scarf_ee.scarf.interact = zm_quest::function_91f9590e98d57ff6( var_cc9dbb3fbaaec44e.origin, &function_2fe8a0a177c50c92, &function_84949c8420ac2d16, "small" );
    utility::flag_set( "setup_scarf_quest_complete" );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0x8854489e, Offset: 0xc1a
// Size: 0x39
function function_e5f0fad12ddd6bdb( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level endon( #"game_ended" );
    utility::flag_wait( "scarf_touched" );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1
// Checksum 0x8ae5d835, Offset: 0xc5b
// Size: 0x62
function function_2fe8a0a177c50c92( player )
{
    if ( utility::flag( "start_boss_fight" ) )
    {
        return;
    }
    
    if ( player zm_vo::is_hero_operator() )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"scarf_ee_activate" );
    }
    else
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    }
    
    utility::flag_set( "scarf_touched" );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0x55534633, Offset: 0xcc5
// Size: 0x86
function private function_b4321f3996e16026()
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    
    while ( true )
    {
        if ( utility::flag( "start_boss_fight" ) && level.scarf_ee.scarf && level.scarf_ee.current_node.script_label )
        {
            level.scarf_ee.scarf thread deactivate_scarf();
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0x95fc087b, Offset: 0xd53
// Size: 0x36
function function_84949c8420ac2d16( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0x5a66d4e, Offset: 0xd92
// Size: 0x70
function function_35e19cec8e96e224( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        utility::flag_set( "scarf_touched" );
    }
    
    if ( level.scarf_ee.scarf.interact )
    {
        level.scarf_ee.scarf.interact zm_quest::function_9170db4686f796e2();
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0x304f8314, Offset: 0xe0a
// Size: 0x1c3
function function_e5f0fbd12ddd6e0e( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    utility::flag_wait( "setup_scarf_quest_complete" );
    level thread function_b4321f3996e16026();
    next_target = utility::getstruct( utility::getstruct( "scarf_ee_item", "script_noteworthy" ).target );
    
    if ( !level callback::exists( "on_zombie_ai_killed", &energy_charge_check ) )
    {
        level callback::add( "on_zombie_ai_killed", &energy_charge_check );
    }
    
    while ( true )
    {
        if ( b_skipped )
        {
            break;
        }
        
        level.scarf_ee.scarf setscriptablepartstate( "fx", "on" );
        level.scarf_ee.scarf.parent function_9d3f28e9d2aeeefc( next_target );
        
        if ( next_target.script_label && next_target.script_label != "scarf_final_beat_node" )
        {
            level.scarf_ee.current_node = next_target;
            level.scarf_ee.scarf.parent thread function_9e9b12bf9706770f();
            function_7687dc526480c2ae( next_target.script_label );
            level.scarf_ee.scarf function_7dd19c7687d0cb80( next_target.script_label );
            wait 2;
        }
        
        if ( next_target.target )
        {
            next_target = utility::getstruct( next_target.target );
            continue;
        }
        
        break;
    }
    
    level utility::flag_set( "scarf_ee_step_2_complete" );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1
// Checksum 0x65af6e94, Offset: 0xfd5
// Size: 0x18a
function function_7dd19c7687d0cb80( label )
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    self setscriptablepartstate( "fx", "absorbing" );
    thread function_fc825e8543087003( label );
    
    switch ( label )
    {
        case #"hash_f0d268e579e84827":
            thread function_9464570ccdf080fd( "scarf_1st_beat_node_spawner", label, 20 );
            break;
        case #"hash_722cdf0fd71ad8bf":
            thread function_9464570ccdf080fd( "scarf_2nd_beat_node_spawner", label, 20 );
            break;
        case #"hash_cd42b99ab6524a2c":
            thread function_9464570ccdf080fd( "scarf_3rd_beat_node_spawner", label, 30 );
            break;
    }
    
    utility::flag_wait_any( label + "_complete", label + "_failed" );
    level.var_5eda1cda9455636 = function_46f9072493651dc9( level.var_5eda1cda9455636 );
    
    foreach ( zombie in level.var_5eda1cda9455636 )
    {
        if ( isalive( zombie ) )
        {
            zombie kill();
        }
    }
    
    level.var_5eda1cda9455636 = [];
    
    if ( utility::flag( label + "_failed" ) )
    {
        while ( utility::flag( label + "_failed" ) )
        {
            waitframe();
        }
        
        function_7dd19c7687d0cb80( label );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1
// Checksum 0x9003c8d7, Offset: 0x1167
// Size: 0xaa
function energy_charge_check( params )
{
    if ( !params.eattacker || !isplayer( params.eattacker ) || !self.is_scarf_ee_zombie || !level.scarf_ee.scarf )
    {
        return;
    }
    
    if ( distance( self.origin, level.scarf_ee.scarf.origin ) <= 500 )
    {
        level.scarf_ee.scarf thread energy_fly( self.origin );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 4, eflags: 0x4
// Checksum 0x85ba3364, Offset: 0x1219
// Size: 0x2c1
function private function_9464570ccdf080fd( var_fac9c6efcac66658, flag, amount = 20, n_difficulty_modifier = 0 )
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    level endon( flag + "_complete" );
    level endon( flag + "_failed" );
    
    if ( !isdefined( level.var_5eda1cda9455636 ) )
    {
        level.var_5eda1cda9455636 = [];
    }
    
    /#
        amount = getdvarint( @"hash_521d306c40b35e73", 20 );
    #/
    
    var_6469c1e4d3ac4060 = utility::getstruct( var_fac9c6efcac66658 );
    a_s_spawners = utility::getstructarray( var_6469c1e4d3ac4060.target, "targetname" );
    self.absorb_amount = amount;
    self.flag = flag;
    
    while ( true )
    {
        wait 2;
        
        foreach ( spawner in a_s_spawners )
        {
            wait randomfloatrange( 0.1, 0.7 );
            zombie = agent_manager::spawn_agent( "zombie_base", spawner.origin );
            
            if ( !zombie )
            {
                continue;
            }
            
            zombie val::set( "ee_scarf", "ignore_cleanup", 1 );
            zombie.var_7ee152b43c7188e1 = 1;
            zombie.ignore_enemy_count = 1;
            zombie.var_eb92c31552620100 = 1;
            zombie.is_scarf_ee_zombie = 1;
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.no_powerups = 1;
            zombie.kiastring = #"zombie_kia_mission_kill";
            zombie thread zone_spawner::function_ce10e453e7f7bb8e( spawner, spawner.origin );
            var_49f7091014d2c59 = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( spawner.origin );
            zombie zombie_utils::set_zombie_round_difficulty( var_49f7091014d2c59 + n_difficulty_modifier );
            zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "scarf_ee", 6 );
            zombie setscriptablepartstate( "base", "base_purple_eyes" );
            
            if ( !isdefined( level.var_5eda1cda9455636 ) )
            {
                level.var_5eda1cda9455636 = [];
            }
            
            level.var_5eda1cda9455636[ level.var_5eda1cda9455636.size ] = zombie;
            waitframe();
        }
        
        while ( level.var_5eda1cda9455636.size >= a_s_spawners.size / 2 )
        {
            level.var_5eda1cda9455636 = function_46f9072493651dc9( level.var_5eda1cda9455636 );
            waitframe();
        }
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1, eflags: 0x4
// Checksum 0x185457c6, Offset: 0x14e2
// Size: 0xb0
function private function_7687dc526480c2ae( label )
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    
    foreach ( player in level.players )
    {
        player thread function_2fcdca4533f23d85( label, 300 );
    }
    
    utility::flag_wait( label + "_approach" );
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2, eflags: 0x4
// Checksum 0xe028bbf1, Offset: 0x159a
// Size: 0xe6
function private function_2fcdca4533f23d85( label, n_distance = 300 )
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    
    if ( !self )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    s_des = level.scarf_ee.current_node;
    level endon( level.scarf_ee.current_node.script_label + "_approach" );
    
    while ( isdefined( self ) )
    {
        if ( distance( s_des.origin, self.origin ) < n_distance )
        {
            level utility::flag_set( level.scarf_ee.current_node.script_label + "_approach" );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 4
// Checksum 0x976eafb8, Offset: 0x1688
// Size: 0x161
function energy_fly( original_pos, target_pos, override_z_offset, str_notify )
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    level endon( self.flag + "_complete" );
    level endon( self.flag + "_failed" );
    target_pos = level.scarf_ee.scarf.origin;
    fx_proxy = utility::spawn_model( "tag_origin", original_pos );
    fx_proxy playsound( #"evt_zm_cyst_loot_soul_wisp" );
    fx_proxy thread zm_quest::function_b8743f5a9219cf9b( fx_proxy.origin, target_pos, "scarf_soul_trail", 0, undefined, 0, 15 );
    fx_proxy waittill( #"curve_done" );
    playsoundatpos( target_pos, #"evt_zm_cyst_loot_soul_impact" );
    playfx( level._effect[ "scarf_soul_impact" ], target_pos );
    
    if ( fx_proxy )
    {
        fx_proxy delete();
    }
    
    self.absorb_amount--;
    
    if ( self.absorb_amount <= 0 )
    {
        level.scarf_ee.scarf.parent notify( #"stop_bobbing" );
        utility::flag_set( self.flag + "_complete" );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0xe7011a79, Offset: 0x17f1
// Size: 0x53
function function_35e19fec8e96e8bd( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "scarf_ee_step_2_complete" );
    }
    
    if ( level callback::exists( "on_zombie_ai_killed", &energy_charge_check ) )
    {
        level callback::remove( "on_zombie_ai_killed", &energy_charge_check );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0x50207d92, Offset: 0x184c
// Size: 0x3b7
function function_e5f0fcd12ddd7041( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( level.scarf_ee.scarf )
    {
        level.scarf_ee.scarf thread blast_nearby_zombies( 1000, 1 );
    }
    
    zm_round_spawning::pause_round_spawning( 1, "mantis_scarf_ee" );
    
    foreach ( player in level.players )
    {
        if ( zone_manager::is_touching_zone( "zone_house2_upstairs_p", player ) )
        {
            player val::set( "scarf_ee_end", "ignoreme", 1 );
        }
    }
    
    var_285fb9202668bdc6 = undefined;
    a_mannequins = utility::getstructarray( "scarf_mannequin_body", "script_noteworthy" );
    
    foreach ( var_a55c75982cff1ac in a_mannequins )
    {
        if ( var_a55c75982cff1ac.script_label == "phase_3" )
        {
            var_285fb9202668bdc6 = var_a55c75982cff1ac;
            break;
        }
    }
    
    if ( var_285fb9202668bdc6.mdl )
    {
        var_285fb9202668bdc6.mdl.mannequin.arm_l freescriptable();
        var_285fb9202668bdc6.mdl.mannequin.arm_r freescriptable();
        var_285fb9202668bdc6.mdl.mannequin setscriptablepartstate( "base", "reward" );
    }
    
    if ( level.scarf_ee.scarf )
    {
        level.scarf_ee.scarf setscriptablepartstate( "base", "hide" );
    }
    
    wait 2;
    
    if ( var_285fb9202668bdc6.mdl )
    {
        var_5ab0a355db2f214e = 3240;
        
        if ( var_285fb9202668bdc6.mdl )
        {
            var_285fb9202668bdc6.mdl rotateyaw( var_5ab0a355db2f214e, 3, 0.5, 0.5 );
        }
    }
    
    wait 3.3;
    var_285fb9202668bdc6.mdl.mannequin setscriptablepartstate( "base", "hide" );
    
    if ( var_285fb9202668bdc6.mdl.mannequin )
    {
        var_285fb9202668bdc6.mdl.mannequin freescriptable();
    }
    
    function_21c48a3c32414000();
    zm_round_spawning::pause_round_spawning( 0, "mantis_scarf_ee" );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "scarf_ee_end" );
    }
    
    clip = getent( "scarf_mannequin_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip connectpaths();
        clip notsolid();
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2
// Checksum 0x89ff66f0, Offset: 0x1c0b
// Size: 0x1c5
function function_35e19eec8e96e68a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_285fb9202668bdc6 = undefined;
        a_mannequins = utility::getstructarray( "scarf_mannequin_body", "script_noteworthy" );
        
        foreach ( var_a55c75982cff1ac in a_mannequins )
        {
            if ( var_a55c75982cff1ac.script_label == "phase_3" )
            {
                var_285fb9202668bdc6 = var_a55c75982cff1ac;
                break;
            }
        }
        
        if ( var_285fb9202668bdc6.mdl )
        {
            var_285fb9202668bdc6.mdl.mannequin.arm_l freescriptable();
            var_285fb9202668bdc6.mdl.mannequin.arm_r freescriptable();
            var_285fb9202668bdc6.mdl.mannequin setscriptablepartstate( "base", "hide" );
        }
        
        if ( level.scarf_ee.scarf )
        {
            level.scarf_ee.scarf freescriptable();
        }
        
        clip = getent( "scarf_mannequin_clip", "script_noteworthy" );
        
        if ( clip )
        {
            clip connectpaths();
            clip notsolid();
        }
    }
    
    if ( level.scarf_ee.current_node )
    {
        level.scarf_ee.current_node = undefined;
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2, eflags: 0x4
// Checksum 0x93be4cbf, Offset: 0x1dd8
// Size: 0x1bb
function private blast_nearby_zombies( var_2a9029c4dff4dca, var_74292dbfd1a437c0 )
{
    playfx( level._effect[ "scarf_blast" ], self.origin );
    playsoundatpos( self.origin, #"hash_f460cae5d1c27fc3" );
    a_zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in a_zombies )
    {
        if ( distance( zombie.origin, self.origin ) < var_2a9029c4dff4dca )
        {
            if ( zombie.var_448e341eabe9a3f5 )
            {
                continue;
            }
            
            zombie.var_a13bed1ac47e1b2c = 1;
            
            if ( var_74292dbfd1a437c0 )
            {
                zombie zm_cleanup_manager::function_dd62e2042418b7e5( var_74292dbfd1a437c0 );
            }
            
            zombie kill();
        }
    }
    
    foreach ( player in level.players )
    {
        if ( distance( player.origin, self.origin ) < 1000 )
        {
            player thread function_c473ef2ca3032767();
            player stoprumble( "damage_light" );
        }
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0x89871f99, Offset: 0x1f9b
// Size: 0x1d2
function private function_c473ef2ca3032767()
{
    self notify( #"play_nuke_screen_flash" );
    self endon( #"death_or_disconnect" );
    self endon( #"play_nuke_screen_flash" );
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        self.white_screen_overlay setshader( "white", 640, 480 );
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.alpha = 0;
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
    }
    
    var_24c3037417857a23 = 0.2;
    n_target_alpha = 0.9;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = n_target_alpha;
    wait 1;
    var_24c3037417857a23 = 0.5;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = 0;
    wait var_24c3037417857a23;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0xeb42273a, Offset: 0x2175
// Size: 0x207
function private function_21c48a3c32414000()
{
    level endon( #"game_ended" );
    scarf = level.scarf_ee.scarf;
    
    if ( !scarf )
    {
        return;
    }
    
    v_reward_location = getclosestpointonnavmesh( scarf.origin );
    itemorigin = level.scarf_ee.current_node.origin;
    
    if ( !v_reward_location )
    {
        v_reward_location = getclosestpointonnavmesh( level.scarf_ee.current_node.origin );
    }
    
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarf_ee_rewards", "Reward" );
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"scarf_ee";
    params.var_be82617e5e8087bd = level.players;
    params.event = #"zm_sq_quest_complete";
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( #"zm_sq_quest_complete", params );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    }
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        if ( var_8b5270de14dff72e[ i ] )
        {
            random_point = getrandomnavpoint( v_reward_location, 200 ) + ( 0, 0, 4 );
            common_item::function_47324f290423b2d1( var_8b5270de14dff72e[ i ], itemorigin, random_point, undefined, 1 );
            waitframe();
        }
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1, eflags: 0x4
// Checksum 0x240d8d2c, Offset: 0x2384
// Size: 0x133
function private function_9d3f28e9d2aeeefc( s_des )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    dis = distance( self.origin, s_des.origin );
    n_time = dis / 200;
    
    if ( s_des.script_parameters == "start" )
    {
        n_time = dis / 30;
    }
    
    var_d45bd791a39e2d93 = n_time * 0.1;
    var_a367bb3bd81e5f8a = n_time * 0.1;
    self moveto( s_des.origin, n_time, var_d45bd791a39e2d93, var_a367bb3bd81e5f8a );
    self rotateto( s_des.angles, n_time, var_d45bd791a39e2d93, var_a367bb3bd81e5f8a );
    wait n_time;
    
    if ( s_des.script_parameters == "start" )
    {
        wait 1;
        return;
    }
    
    if ( s_des.script_parameters )
    {
        function_b4d0ead0e577133e();
        thread function_9e9b12bf9706770f();
        level utility::flag_wait( self.targetname + "_arrived" );
        level utility::flag_clear( self.targetname + "_arrived" );
        self notify( #"stop_bobbing" );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 2, eflags: 0x4
// Checksum 0xa6bb08e2, Offset: 0x24bf
// Size: 0xa8
function private function_9e9b12bf9706770f( n_offset, time )
{
    level endon( #"game_ended" );
    self endon( #"stop_bobbing" );
    self endon( #"death" );
    
    if ( isdefined( n_offset ) )
    {
        offset = n_offset;
    }
    else
    {
        offset = 12;
    }
    
    if ( !isdefined( time ) )
    {
        time = 2;
    }
    
    while ( true )
    {
        self movez( offset, time, time / 2, time / 2 );
        self waittill( #"movedone" );
        self movez( offset * -1, time, time / 2, time / 2 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1
// Checksum 0xcc56aa14, Offset: 0x256f
// Size: 0x57
function function_fc825e8543087003( flag )
{
    level endon( #"game_ended" );
    level endon( flag + "_complete" );
    time_remaining = 60;
    self.failed_flag = flag;
    
    while ( time_remaining > 0 )
    {
        wait 1;
        time_remaining--;
    }
    
    if ( self )
    {
        thread deactivate_scarf();
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0
// Checksum 0xe0f76a6f, Offset: 0x25ce
// Size: 0x191
function deactivate_scarf()
{
    level endon( #"game_ended" );
    level endon( #"scarf_ee_step_2_complete" );
    self setscriptablepartstate( "fx", "off" );
    self.parent notify( #"stop_bobbing" );
    s_drop = utility::getstruct( self.failed_flag + "_drop", "script_noteworthy" );
    
    if ( level.scarf_ee.scarf )
    {
        level.scarf_ee.scarf thread blast_nearby_zombies( 1000, 1 );
    }
    
    self.parent moveto( s_drop.origin, 0.5, 0.5 );
    self.parent rotateto( s_drop.angles, 0.5 );
    utility::flag_set( self.failed_flag + "_failed" );
    wait 10;
    level.scarf_ee.scarf.interact = zm_quest::function_91f9590e98d57ff6( s_drop.origin, &active_scarf, &function_84949c8420ac2d16, "small" );
    level.scarf_ee.scarf.interact.scarf = self;
    level.scarf_ee.scarf.interact.failed_flag = self.failed_flag + "_failed";
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1
// Checksum 0xe8fe4bc8, Offset: 0x2767
// Size: 0xc1
function active_scarf( player )
{
    next_target = level.scarf_ee.current_node;
    
    if ( self.scarf.parent )
    {
        self.scarf.parent function_9d3f28e9d2aeeefc( next_target );
        
        if ( self.scarf.parent )
        {
            self.scarf.parent thread function_9e9b12bf9706770f();
        }
    }
    
    utility::flag_clear( self.failed_flag );
    level.scarf_ee.scarf.interact zm_quest::function_9170db4686f796e2();
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 0, eflags: 0x4
// Checksum 0xb7543761, Offset: 0x2830
// Size: 0x8b
function private function_b4d0ead0e577133e()
{
    foreach ( player in level.players )
    {
        if ( player && isalive( player ) )
        {
            player thread function_b83a9f5fcf61b682( self );
        }
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf
// Params 1, eflags: 0x4
// Checksum 0xae9eac03, Offset: 0x28c3
// Size: 0x7b
function private function_b83a9f5fcf61b682( s_scarf )
{
    level endon( #"game_ended" );
    level endon( s_scarf.targetname + "_arrived" );
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( self ) )
    {
        if ( distance( s_scarf.origin, self.origin ) <= 200 )
        {
            level utility::flag_set( s_scarf.targetname + "_arrived" );
            break;
        }
        
        waitframe();
    }
}

/#

    // Namespace zm_sat_mantis_quest_ee_scarf
    // Params 0
    // Checksum 0xc3861f27, Offset: 0x2946
    // Size: 0x37, Type: dev
    function draw_sphere()
    {
        self endon( #"death_or_disconnect" );
        
        while ( true )
        {
            sphere( self.origin, 10, ( 1, 0, 0 ) );
            waitframe();
        }
    }

    // Namespace zm_sat_mantis_quest_ee_scarf
    // Params 0, eflags: 0x4
    // Checksum 0x54ca56ca, Offset: 0x2985
    // Size: 0x68, Type: dev
    function private setup_scarf_ee_devgui()
    {
        level utility::flag_wait( "<dev string:x24>" );
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x39>" );
        devgui::add_devgui_func( "<dev string:x4c>", "<dev string:x4c>", &debug_show_scarf );
        devgui::add_devgui_func( "<dev string:x57>", "<dev string:x57>", &debug_screen_flash );
        devgui::add_devgui_func( "<dev string:x64>", "<dev string:x64>", &debug_scarf_path );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_mantis_quest_ee_scarf
    // Params 0
    // Checksum 0x282d33ce, Offset: 0x29f5
    // Size: 0x1a, Type: dev
    function debug_show_scarf()
    {
        level endon( #"game_ended" );
        function_e5f0fad12ddd6bdb( 0, 0 );
    }

    // Namespace zm_sat_mantis_quest_ee_scarf
    // Params 0
    // Checksum 0xb724058, Offset: 0x2a17
    // Size: 0x25, Type: dev
    function debug_screen_flash()
    {
        player = level.players[ 0 ];
        player thread function_c473ef2ca3032767();
    }

    // Namespace zm_sat_mantis_quest_ee_scarf
    // Params 0
    // Checksum 0x1191dda9, Offset: 0x2a44
    // Size: 0x1a7, Type: dev
    function debug_scarf_path()
    {
        var_c5fb7b9c0ca383b7 = utility::getstruct( "<dev string:x6f>", "<dev string:x7d>" );
        scarf_parent = utility::spawn_model( "<dev string:x8f>", var_c5fb7b9c0ca383b7.origin, var_c5fb7b9c0ca383b7.angles );
        
        if ( !level.scarf_ee.scarf )
        {
            level.scarf_ee.scarf = spawnscriptable( %"zm_sat_mantis_ee_scarf", ( 0, 0, 0 ), var_c5fb7b9c0ca383b7.angles, scarf_parent );
        }
        
        if ( !level.scarf_ee.scarf.parent )
        {
            level.scarf_ee.scarf.parent = scarf_parent;
        }
        
        next_target = utility::getstruct( utility::getstruct( "<dev string:x6f>", "<dev string:x7d>" ).target );
        
        while ( true )
        {
            level.scarf_ee.scarf setscriptablepartstate( "<dev string:x9a>", "<dev string:x9d>" );
            level.scarf_ee.scarf.parent function_9d3f28e9d2aeeefc( next_target );
            
            if ( next_target.script_label )
            {
                level.scarf_ee.current_node = next_target;
                wait 3;
            }
            
            if ( next_target.target )
            {
                next_target = utility::getstruct( next_target.target );
                continue;
            }
            
            break;
        }
    }

#/
