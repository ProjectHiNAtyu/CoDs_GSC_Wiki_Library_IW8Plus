// script_470fade07a532cfa  (hash_470fade07a532cfa.gscc) (size: 11578 Bytes / 0x2d3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf39b894 (3745101972)
// size ...... 11578 (0x2d3a)
// includes .. 12  (offset: 0x2a8e)
// strings ... 39  (offset: 0x2aee)
// dev strs .. 3   (offset: 0x2d12)
// exports ... 29  (offset: 0x1a16)
// cseg ...... 0x38f + 0x1687 (0x1a16)
// imports ... 102 (offset: 0x1e9e)
// animtree1 . 0   (offset: 0x2d3a)
// animtree2 . 0   (offset: 0x2d3a)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_ghoul\zombie_ghoul_blast_attack;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_f711b4058f44f2aa;

// Namespace namespace_f711b4058f44f2aa
// Params 0, eflags: 0x5
// Checksum 0x4953edb0, Offset: 0x3ad
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_14b54f1860895909", undefined, undefined, &post_init );
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xbfc026c0, Offset: 0x3ce
// Size: 0xfc
function post_init()
{
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level._effect[ "dbee_cover_fx" ] = loadfxasset( "vfx_sat_levels_zm_firefly_fog_spawning" );
    level._effect[ "dbee_dust" ] = loadfxasset( "vfx_sat_energy_trail" );
    zm_quest::register_quest_step( #"hash_3fbb6b49a0ac2613", #"trigger_mannequin", &setup_trigger_mannequin, &cleanup_trigger_mannequin );
    zm_quest::register_quest_step( #"hash_3fbb6b49a0ac2613", #"kill_mannequin", &setup_kill_mannequin, &cleanup_kill_mannequin );
    zombie_ghoul_blast_attack::function_bb2be6939cc4c949();
    level utility::flag_wait_all( "zm_sat_mantis_quest_ee_dblink_cs_completed", "zm_quest_initialized", "scriptables_ready", "begin_round_logic" );
    
    while ( wwq_is_active() )
    {
        /#
            if ( getdvarint( @"hash_1ef28e19509f7f3e", 0 ) )
            {
                break;
            }
        #/
        
        wait 1;
    }
    
    level thread zm_quest::start_quest( #"hash_3fbb6b49a0ac2613" );
    
    /#
        level thread init_debug();
    #/
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x4195a8f, Offset: 0x4d2
// Size: 0x33, Type: bool
function wwq_is_active()
{
    wwq = level.zm_quests[ #"mantis_ww_quest" ];
    return wwq && !wwq.completed;
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x312a0ec7, Offset: 0x50e
// Size: 0x23a
function init_mannequins()
{
    var_c70991ae953ae29b = [ "m1", "m2", "m3", "m4" ];
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_3fbb6b49a0ac2613", #"hash_3a465a0b39865b8b" ) )
    {
        var_25a63701fd510264 = zm_quest::function_73720cdf21c3cfd7( #"hash_3fbb6b49a0ac2613", #"hash_3a465a0b39865b8b" );
    }
    else
    {
        var_25a63701fd510264 = randomint( var_c70991ae953ae29b.size );
        zm_quest::function_4eefe6de31f5ddab( #"hash_3fbb6b49a0ac2613", #"hash_3a465a0b39865b8b", var_25a63701fd510264 );
    }
    
    var_4f9bae735c3058f7 = var_c70991ae953ae29b[ var_25a63701fd510264 ];
    var_7eb57f76b604980f = utility::getstructarray( "db_ee_m_loc_future", "script_noteworthy" );
    
    foreach ( loc in var_7eb57f76b604980f )
    {
        if ( loc.script_label == var_4f9bae735c3058f7 )
        {
            setup_future_mannequin( loc.origin, loc.angles );
        }
    }
    
    var_8a2b2b4f1c1849ac = utility::getstructarray( "db_ee_m_loc_past", "script_noteworthy" );
    
    foreach ( loc in var_8a2b2b4f1c1849ac )
    {
        if ( loc.script_label == var_4f9bae735c3058f7 )
        {
            level.var_ba5e74e6797ca70d = spawnscriptable( "zm_sat_mantis_dblink_ee_mannquin_p", loc.origin, loc.angles );
            level.var_ba5e74e6797ca70d.v_reward_pos = utility::getstruct( loc.target, "targetname" ).origin;
        }
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0xd219107a, Offset: 0x750
// Size: 0x175
function setup_future_mannequin( v_pos, v_ang )
{
    playfx( level._effect[ "dbee_cover_fx" ], v_pos + ( 0, 0, 50 ) );
    playsoundatpos( v_pos + ( 0, 0, 50 ), #"hash_207fe2e238961aa4" );
    level.var_ba5e5ee6797c76ab = spawnscriptable( "zm_sat_mantis_dblink_ee_mannquin_f", v_pos, v_ang );
    level.var_29d4803dfdca231c = utility::spawn_model( "tag_origin", v_pos, v_ang );
    level.var_ba5e5ee6797c76ab scriptablesetparententity( level.var_29d4803dfdca231c );
    playfxontag( level._effect[ "dbee_dust" ], level.var_29d4803dfdca231c, "tag_origin" );
    
    if ( !isdefined( level.var_94a274233a48fccd ) )
    {
        level.var_94a274233a48fccd = getent( "dbee_manq_clp", "script_noteworthy" );
        
        if ( level.var_94a274233a48fccd && level.var_29d4803dfdca231c )
        {
            level.var_94a274233a48fccd solid();
            level.var_94a274233a48fccd disconnectpaths();
            level.var_94a274233a48fccd.origin = level.var_29d4803dfdca231c.origin + ( 0, 0, 30 );
            level.var_94a274233a48fccd linkto( level.var_29d4803dfdca231c );
        }
    }
    
    /#
        level.var_ba5e5ee6797c76ab thread drawsphere();
    #/
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x3d2eaa5b, Offset: 0x8cd
// Size: 0x2f
function boss_fight_start_watcher()
{
    level endon( #"game_ended" );
    
    while ( !utility::flag( "start_boss_fight" ) )
    {
        wait 1;
    }
    
    level notify( #"dbee_mannequin_cleanup" );
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0x578975ac, Offset: 0x904
// Size: 0x71
function setup_trigger_mannequin( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    init_mannequins();
    level thread function_da278819119d1f9c();
    level waittill( #"hash_3ce6bf3b99a287e6" );
    level.var_29d4803dfdca231c rotateto( level.var_169f5eaa277d9c7d.angles + ( 0, -180, 0 ), 0.1 );
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0x671f60b0, Offset: 0x97d
// Size: 0x27
function cleanup_trigger_mannequin( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        init_mannequins();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 1
// Checksum 0x2e3005e6, Offset: 0x9ac
// Size: 0x1c5
function function_da278819119d1f9c( players )
{
    level endon( #"game_ended" );
    level endon( #"hash_3ce6bf3b99a287e6" );
    var_e7ac3a162b5d1f2 = level.var_ba5e5ee6797c76ab.origin + ( 0, 0, 50 );
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    foreach ( player in players )
    {
        player.var_84fd5cf96aa94aed = 0;
    }
    
    while ( true )
    {
        foreach ( player in players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( is_player_staring( player, var_e7ac3a162b5d1f2, 200 ) )
            {
                if ( !player.var_84fd5cf96aa94aed )
                {
                    player.var_84fd5cf96aa94aed = 1;
                    player thread function_598849cca77f04e1();
                }
                
                continue;
            }
            
            if ( player.var_84fd5cf96aa94aed )
            {
                player.var_84fd5cf96aa94aed = 0;
                player notify( #"hash_a3eb6420f934035c" );
                player stoplocalsound( "evt_zm_mantis_ee_db_riser" );
                player playlocalsound( #"hash_a07be9b03c81114e" );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 3
// Checksum 0xe32cdc1f, Offset: 0xb79
// Size: 0x98, Type: bool
function is_player_staring( player = level.players[ 0 ], var_2122430e7e03235b, dis )
{
    v_eye_pos = player geteye();
    
    if ( distance( v_eye_pos, var_2122430e7e03235b ) > dis )
    {
        return false;
    }
    
    if ( abs( v_eye_pos[ 2 ] - var_2122430e7e03235b[ 2 ] ) > 100 )
    {
        return false;
    }
    
    if ( !utility::within_fov( v_eye_pos, player getplayerangles(), var_2122430e7e03235b, cos( 40 ) ) )
    {
        return false;
    }
    
    if ( !sighttracepassed( player geteye(), var_2122430e7e03235b, 0, undefined ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x14b4e5fe, Offset: 0xc1a
// Size: 0x85
function function_598849cca77f04e1()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_a3eb6420f934035c" );
    self playlocalsound( #"evt_zm_mantis_ee_db_riser" );
    wait 5;
    level notify( #"hash_3ce6bf3b99a287e6" );
    
    if ( isdefined( level.var_29d4803dfdca231c ) )
    {
        self playsoundtoplayer( #"hash_f22de827543f5b03", self, level.var_29d4803dfdca231c );
    }
    
    thread play_vo( #"hash_a3b44093d6feb0e2", 0 );
    level.var_169f5eaa277d9c7d = self;
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0x3a9b429f, Offset: 0xca7
// Size: 0x11a
function setup_kill_mannequin( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "begin_round_logic" );
    
    if ( time_travel::get_current_timeline().name == "future" )
    {
        if ( !level.var_169f5eaa277d9c7d )
        {
            level.var_169f5eaa277d9c7d = function_1898b1224a8a340f();
        }
    }
    
    scriptable::scriptable_adddamagedcallback( &mannequin_damaged );
    level thread do_chase();
    level thread reset_watcher();
    level thread complete_watcher();
    level thread boss_fight_start_watcher();
    level utility::flag_wait( "dbee_completed" );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0x38c36629, Offset: 0xdc9
// Size: 0x88
function cleanup_kill_mannequin( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( level.var_ba5e5ee6797c76ab )
        {
            level.var_ba5e5ee6797c76ab freescriptable();
        }
        
        if ( level.var_94a274233a48fccd )
        {
            level.var_94a274233a48fccd delete();
        }
        
        if ( level.var_29d4803dfdca231c )
        {
            level.var_29d4803dfdca231c delete();
        }
        
        if ( level.var_ba5e74e6797ca70d )
        {
            level.var_ba5e74e6797ca70d freescriptable();
        }
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xeac05efe, Offset: 0xe59
// Size: 0x50
function record_player_pos()
{
    level endon( #"game_ended" );
    level.var_2d647747067faf5e = [];
    
    while ( level.var_169f5eaa277d9c7d )
    {
        level.var_2d647747067faf5e[ level.var_2d647747067faf5e.size ] = level.var_169f5eaa277d9c7d.origin;
        waitframe();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x499e9e7, Offset: 0xeb1
// Size: 0x229
function mannequin_move()
{
    level endon( #"game_ended" );
    level endon( #"dbee_completed" );
    level endon( #"dbee_player_catched" );
    level endon( #"dbee_mannequin_cleanup" );
    level endon( #"dbee_player_death" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( utility::flag( "dbee_mannequin_stops" ) )
        {
            wait 1;
            continue;
        }
        
        if ( level.var_2d647747067faf5e.size > 30 )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            playfx( level._effect[ "dbee_cover_fx" ], self.origin + ( 0, 0, 50 ) );
            playsoundatpos( self.origin + ( 0, 0, 50 ), #"hash_9975766607f050b1" );
            v_new_pos = level.var_2d647747067faf5e[ level.var_2d647747067faf5e.size - 30 ];
            
            if ( level.var_94a274233a48fccd )
            {
                level.var_94a274233a48fccd connectpaths();
                level.var_94a274233a48fccd notsolid();
            }
            
            waitframe();
            self.origin = getclosestpointonnavmesh( v_new_pos );
            waitframe();
            
            if ( level.var_94a274233a48fccd )
            {
                level.var_94a274233a48fccd disconnectpaths();
                level.var_94a274233a48fccd solid();
            }
            
            var_247d22c685c1b9db = level.var_169f5eaa277d9c7d.origin - self.origin;
            var_247d22c685c1b9db = ( var_247d22c685c1b9db[ 0 ], var_247d22c685c1b9db[ 1 ], 0 );
            self.angles = axistoangles( var_247d22c685c1b9db, vectorcross( var_247d22c685c1b9db, ( 0, 0, 1 ) ), ( 0, 0, 1 ) );
            playfx( level._effect[ "dbee_cover_fx" ], self.origin + ( 0, 0, 50 ) );
            playsoundatpos( self.origin + ( 0, 0, 50 ), #"hash_207fe2e238961aa4" );
            level.var_2d647747067faf5e = [];
            zombie_utils::function_607ff821e430d594( self.origin, 100 );
            function_53be13fd64653e21();
            wait 5;
        }
        
        waitframe();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x8adc6c2e, Offset: 0x10e2
// Size: 0xf9
function function_53be13fd64653e21()
{
    foreach ( player in level.players )
    {
        if ( distance( self.origin, player.origin ) < 30 )
        {
            level.var_94a274233a48fccd notsolid();
            level.var_94a274233a48fccd connectpaths();
            player zombie_ghoul_blast_attack::function_8ea31b9698792c75();
            player earthquakeforplayer( 0.2, 2, player.origin, 500 );
            player playrumbleonentity( "damage_light" );
            player playsound( #"hash_4e3290265d1b422d" );
            level notify( #"dbee_player_catched" );
        }
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xd1ea8d17, Offset: 0x11e3
// Size: 0x148
function function_e9743e7e36a00737()
{
    level endon( #"game_ended" );
    level endon( #"dbee_completed" );
    level endon( #"dbee_player_catched" );
    level endon( #"dbee_mannequin_cleanup" );
    level endon( #"dbee_mannequin_killed" );
    level endon( #"dbee_player_death" );
    
    while ( level.var_169f5eaa277d9c7d )
    {
        var_9b0b4e8fa91e12c4 = 0;
        
        foreach ( player in level.players )
        {
            if ( is_player_staring( player, level.var_ba5e5ee6797c76ab.origin + ( 0, 0, 50 ), 9999 ) )
            {
                var_9b0b4e8fa91e12c4 = 1;
                break;
            }
        }
        
        if ( var_9b0b4e8fa91e12c4 )
        {
            if ( !utility::flag( "dbee_mannequin_stops" ) )
            {
                utility::flag_set( "dbee_mannequin_stops" );
            }
        }
        else if ( utility::flag( "dbee_mannequin_stops" ) )
        {
            utility::flag_clear( "dbee_mannequin_stops" );
        }
        
        waitframe();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xfef4ed1d, Offset: 0x1333
// Size: 0xcf
function function_1898b1224a8a340f()
{
    if ( level.players.size == 1 )
    {
        new_target = level.players[ 0 ];
    }
    else
    {
        if ( !isdefined( var_b249b4cf224fbc16 ) )
        {
            var_b249b4cf224fbc16 = [];
        }
        
        foreach ( player in level.players )
        {
            if ( player == level.dbee_last_target )
            {
                continue;
            }
            
            var_b249b4cf224fbc16[ var_b249b4cf224fbc16.size ] = player;
        }
        
        new_target = utility::array_random( var_b249b4cf224fbc16 );
    }
    
    return new_target;
}

// Namespace namespace_f711b4058f44f2aa
// Params 11
// Checksum 0x89529ffc, Offset: 0x140b
// Size: 0xcf
function mannequin_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) || !instance getscriptablehaspart( "dbee_mannequin_health" ) )
    {
        return;
    }
    
    if ( level utility::flag( "dbee_mannequin_killed" ) )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    level utility::flag_set( "dbee_mannequin_killed" );
    playsoundatpos( eattacker.origin, "evt_zm_firefly_ee_mrpeeks_stinger" );
    eattacker thread play_vo( #"hash_14712ab2f16a1ee3", 1 );
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xf2d88bbe, Offset: 0x14e2
// Size: 0x69
function do_chase()
{
    level endon( #"game_ended" );
    wait 3;
    
    if ( level.var_ba5e5ee6797c76ab )
    {
        level.var_ba5e5ee6797c76ab setscriptablepartstate( "audio", "on" );
    }
    
    if ( level.var_169f5eaa277d9c7d )
    {
        level thread record_player_pos();
        level.var_29d4803dfdca231c thread mannequin_move();
        level thread function_e9743e7e36a00737();
        level thread target_death_watcher();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0x5260f1fa, Offset: 0x1553
// Size: 0x5f
function target_death_watcher()
{
    level endon( #"game_ended" );
    level endon( #"dbee_player_catched" );
    level endon( #"dbee_mannequin_cleanup" );
    level endon( #"timetravel_ongoing" );
    
    if ( level.var_169f5eaa277d9c7d )
    {
        level.var_169f5eaa277d9c7d waittill( #"death_or_disconnect" );
        level notify( #"dbee_player_death" );
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xcb11de81, Offset: 0x15ba
// Size: 0x1a1
function reset_watcher()
{
    level endon( #"game_ended" );
    level endon( #"dbee_mannequin_killed" );
    
    while ( !utility::flag( "dbee_mannequin_killed" ) )
    {
        level utility::waittill_any( "dbee_player_catched", "dbee_mannequin_cleanup", "timetravel_ongoing", "dbee_player_death" );
        playfx( level._effect[ "dbee_cover_fx" ], level.var_29d4803dfdca231c.origin + ( 0, 0, 50 ) );
        playsoundatpos( level.var_29d4803dfdca231c.origin + ( 0, 0, 50 ), #"hash_9975766607f050b1" );
        level.var_ba5e5ee6797c76ab freescriptable();
        level.var_29d4803dfdca231c delete();
        level.dbee_last_target = level.var_169f5eaa277d9c7d;
        level.var_169f5eaa277d9c7d = undefined;
        wait 30;
        
        while ( time_travel::get_current_timeline().name != "future" || utility::flag( "start_boss_fight" ) )
        {
            wait 1;
        }
        
        level.var_169f5eaa277d9c7d = function_1898b1224a8a340f();
        
        if ( level.var_169f5eaa277d9c7d )
        {
            mannequin_spawn_pos = getclosestpointonnavmesh( level.var_169f5eaa277d9c7d.origin + anglestoforward( level.var_169f5eaa277d9c7d.angles ) * 300 );
            setup_future_mannequin( mannequin_spawn_pos, level.var_169f5eaa277d9c7d.angles + ( 0, 180, 0 ) );
        }
        
        level thread do_chase();
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 0
// Checksum 0xac780d58, Offset: 0x1763
// Size: 0xbe
function complete_watcher()
{
    level endon( #"game_ended" );
    level utility::waittill_any( "dbee_mannequin_killed" );
    
    if ( level.var_94a274233a48fccd )
    {
        level.var_94a274233a48fccd delete();
    }
    
    if ( level.var_29d4803dfdca231c )
    {
        level.var_29d4803dfdca231c.my_scriptable freescriptable();
        level.var_29d4803dfdca231c delete();
    }
    
    level thread drop_rewards( level.var_ba5e74e6797ca70d.origin + ( 0, 0, 50 ), level.var_ba5e74e6797ca70d.v_reward_pos );
    level.var_ba5e74e6797ca70d freescriptable();
    level utility::flag_set( "dbee_completed" );
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0x1af648ce, Offset: 0x1829
// Size: 0xc7
function drop_rewards( v_source_loc, var_54ab98a98b57d4a3 )
{
    level endon( #"game_ended" );
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_mantis_dbee_rewards", "default" );
    playsoundatpos( v_source_loc + ( 0, 0, 50 ), #"hash_207fe2e238961aa4" );
    playfx( level._effect[ "dbee_cover_fx" ], v_source_loc );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        if ( var_8b5270de14dff72e[ i ] )
        {
            random_point = getrandomnavpoint( var_54ab98a98b57d4a3, 100 ) + ( 0, 0, 4 );
            common_item::function_47324f290423b2d1( var_8b5270de14dff72e[ i ], v_source_loc, random_point, undefined, 1 );
            wait 0.1;
        }
    }
}

// Namespace namespace_f711b4058f44f2aa
// Params 2
// Checksum 0x8ae5441f, Offset: 0x18f8
// Size: 0x5d
function play_vo( str_vo_to_play, var_1fc51011987c93fe )
{
    level endon( #"game_ended" );
    var_d737580b6b81a394 = "";
    
    if ( var_1fc51011987c93fe )
    {
        var_d737580b6b81a394 = #"bc_flavor_player_positive";
    }
    else
    {
        var_d737580b6b81a394 = #"bc_flavor_player_negative";
    }
    
    wait 1;
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( str_vo_to_play, var_d737580b6b81a394 );
}

/#

    // Namespace namespace_f711b4058f44f2aa
    // Params 0
    // Checksum 0xeb431776, Offset: 0x195d
    // Size: 0x2e, Type: dev
    function init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x38>", "<dev string:x38>", &set_boss_fight_flag );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_f711b4058f44f2aa
    // Params 0
    // Checksum 0xb7360fb9, Offset: 0x1993
    // Size: 0x6a, Type: dev
    function drawsphere()
    {
        self notify( #"hash_6404757f8c833856" );
        self endon( #"hash_6404757f8c833856" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            color = ( 1, 1, 1 );
            sphere( self.origin, 20, color, 0 );
            waitframe();
        }
    }

    // Namespace namespace_f711b4058f44f2aa
    // Params 0
    // Checksum 0xe959eee4, Offset: 0x1a05
    // Size: 0x11, Type: dev
    function set_boss_fight_flag()
    {
        utility::flag_set( "<dev string:x4c>" );
    }

#/
