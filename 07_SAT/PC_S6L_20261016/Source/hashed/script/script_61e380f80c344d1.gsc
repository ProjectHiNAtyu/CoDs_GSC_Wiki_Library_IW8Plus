// script_61e380f80c344d1  (hash_061e380f80c344d1.gscc) (size: 15086 Bytes / 0x3aee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b87ddc9 (1804066249)
// size ...... 15086 (0x3aee)
// includes .. 15  (offset: 0x37a2)
// strings ... 32  (offset: 0x381a)
// dev strs .. 10  (offset: 0x3a5e)
// exports ... 38  (offset: 0x2322)
// cseg ...... 0x34b + 0x1fd7 (0x2322)
// imports ... 116 (offset: 0x2912)
// animtree1 . 0   (offset: 0x3aee)
// animtree2 . 0   (offset: 0x3aee)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_player;

#namespace namespace_f9729c60380b35b3;

// Namespace namespace_f9729c60380b35b3
// Params 0, eflags: 0x5
// Checksum 0x2d8618d0, Offset: 0x369
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_ee_lost_key", undefined, undefined, &post_init );
}

// Namespace namespace_f9729c60380b35b3
// Params 0, eflags: 0x4
// Checksum 0xc669cbee, Offset: 0x38a
// Size: 0x1a2
function private post_init()
{
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "scriptables_ready" );
    zm_quest::register_quest_step( #"mantis_ee_lost_key", #"hash_b591ac302d08d93", &function_803dcf7ace0b83b9, &function_3bc64f7912a72a5e );
    zm_quest::register_quest_step( #"mantis_ee_lost_key", #"hash_477b0d8876d8d28f", &function_803dcc7ace0b7d20, &function_3bc64e7912a7282b );
    zm_quest::register_quest_step( #"mantis_ee_lost_key", #"hash_8ba085619c7e1688", &function_803dcd7ace0b7f53, &function_3bc64d7912a725f8 );
    zm_quest::register_quest_step( #"mantis_ee_lost_key", #"hash_b4233d6a7f324d67", &function_803dd27ace0b8a52, &function_3bc6547912a7355d );
    zm_quest::register_quest_step( #"mantis_ee_lost_key", #"hash_89681be15451d30c", &function_803dd37ace0b8c85, &function_3bc6537912a7332a );
    zm_quest::register_quest_step( #"mantis_ee_lost_key", #"open_crate", &function_803da07ace0b1c5c, &function_3bc6a27912a7e0e7 );
    clip = getent( "lost_key_crate_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip connectpaths();
        clip notsolid();
    }
    
    level._effect[ "pot_damage_effect" ] = loadfxasset( "vfx_iw8_prop_script_uk_foliage_plant_potted_fern_01_hanging_debris" );
    level thread lost_key_setup();
    level callback::add( "quest_item_used", &on_quest_item_pickup );
    level utility::flag_wait( "begin_round_logic" );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"mantis_ee_lost_key" );
    level thread function_4f02561e89c6398c();
    
    /#
        function_f46e878e8ec6035e();
    #/
}

// Namespace namespace_f9729c60380b35b3
// Params 0, eflags: 0x4
// Checksum 0xb2ec81c5, Offset: 0x534
// Size: 0x81
function private lost_key_setup()
{
    level.var_78063ddc3c438563 = utility::getstructarray( "sq_lost_key_container_loc", "targetname" );
    level.var_6fbbf4bf418609c7 = utility::getstruct( "sq_lost_key_crate_loc", "targetname" );
    level.var_6da703457ef89407 = 0;
    
    for ( i = 0; i < level.var_78063ddc3c438563.size ; i++ )
    {
        loc = level.var_78063ddc3c438563[ i ];
        loc thread spawn_container( i );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 1
// Checksum 0xfba27729, Offset: 0x5bd
// Size: 0x74
function spawn_container( n_index )
{
    self.var_c503500995aa2f03 = 0;
    self.var_ab20f5da85948717 = 0;
    self.mdl_container = utility::spawn_model( "uk_foliage_plant_potted_fern_01_hanging", self.origin, self.angles );
    self.mdl_container setcandamage( 1 );
    thread function_ba830cab5c2b4126();
    
    if ( !isdefined( self.index ) )
    {
        self.index = n_index;
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 11
// Checksum 0xd03f2b28, Offset: 0x639
// Size: 0x277
function function_9e8f8aabba3a30c8( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"sat_zm_sat_scriptable_lost_key_container_pot" || instance.destroyed )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    var_2da768e7fb40c2bf = self.parent;
    var_2da768e7fb40c2bf.var_c503500995aa2f03 = 1;
    
    if ( var_2da768e7fb40c2bf.var_ab20f5da85948717 && !utility::flag( "start_boss_fight" ) )
    {
        level.var_6da703457ef89407++;
        playsoundatpos( var_2da768e7fb40c2bf.origin, #"hash_a8d89ece993dce2b" );
        
        switch ( level.var_6da703457ef89407 )
        {
            case 1:
                level utility::flag_set( "found_first_key" );
                eattacker thread function_59f83d442d0a93aa( #"hash_8f5589a17d65db0a", 1 );
                break;
            case 2:
                level utility::flag_set( "found_second_key" );
                break;
            case 3:
                level utility::flag_set( "found_third_key" );
                break;
            case 4:
                level utility::flag_set( "found_fourth_key" );
                break;
            case 5:
                level utility::flag_set( "found_fifth_key" );
                eattacker thread function_59f83d442d0a93aa( #"hash_4f1335026dd47b7b", 0 );
                zm_quest::drop_quest_item( var_2da768e7fb40c2bf.origin + ( 0, 0, 50 ), getrandomnavpoint( var_2da768e7fb40c2bf.origin, 150 ), %"hash_7ce7933eb28adac5" );
                utility::flag_set( "lost_key_drop" );
                break;
        }
        
        var_2da768e7fb40c2bf.var_ab20f5da85948717 = 0;
        
        if ( var_2da768e7fb40c2bf.var_cc32dd827033ebb5 )
        {
            var_2da768e7fb40c2bf.var_cc32dd827033ebb5 delete();
        }
    }
    else if ( !utility::flag( "lost_key_failed" ) && !utility::flag( "lost_key_drop" ) )
    {
        level thread cleanup_lost_key();
        level thread zm_quest::restart_quest( #"mantis_ee_lost_key" );
    }
    
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0x452b67de, Offset: 0x8b8
// Size: 0x422
function function_ba830cab5c2b4126()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.mdl_container waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( utility::flag( "start_boss_fight" ) )
        {
            continue;
        }
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        self.var_c503500995aa2f03 = 1;
        
        if ( self.mdl_container && self.mdl_container.origin )
        {
            playfx( level._effect[ "pot_damage_effect" ], self.mdl_container.origin );
        }
        
        zm_quest::function_6265be8d0549e1b1( #"mantis_ee_lost_key", #"hash_e1cf349ab6fc611d" );
        
        if ( self.var_ab20f5da85948717 && !utility::flag( "start_boss_fight" ) )
        {
            level.var_6da703457ef89407++;
            playsoundatpos( self.mdl_container.origin, #"hash_a8d89ece993dce2b" );
            
            switch ( level.var_6da703457ef89407 )
            {
                case 1:
                    level utility::flag_set( "found_first_key" );
                    attacker thread function_59f83d442d0a93aa( #"hash_8f5589a17d65db0a", 1 );
                    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_2084ea61da130cae", self.index );
                    break;
                case 2:
                    level utility::flag_set( "found_second_key" );
                    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_f7e8f6c9bda536c2", self.index );
                    break;
                case 3:
                    level utility::flag_set( "found_third_key" );
                    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_84cc28427b8ea945", self.index );
                    break;
                case 4:
                    level utility::flag_set( "found_fourth_key" );
                    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_421c0daceea1a0ee", self.index );
                    break;
                case 5:
                    level utility::flag_set( "found_fifth_key" );
                    attacker thread function_59f83d442d0a93aa( #"hash_4f1335026dd47b7b", 0 );
                    zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_f4e4e922dcbac399", self.index );
                    
                    if ( self.target )
                    {
                        s_drop_target = utility::getstruct( self.target );
                        drop_position = getclosestpointonnavmesh( s_drop_target.origin );
                        level thread zm_quest::drop_quest_item( self.origin, drop_position, %"hash_7ce7933eb28adac5" );
                    }
                    else
                    {
                        zm_quest::drop_quest_item( self.origin + ( 0, 0, 50 ), getrandomnavpoint( self.origin, 150 ), %"hash_7ce7933eb28adac5" );
                    }
                    
                    utility::flag_set( "lost_key_drop" );
                    break;
            }
            
            self.var_ab20f5da85948717 = 0;
            
            if ( self.var_cc32dd827033ebb5 )
            {
                self.var_cc32dd827033ebb5 delete();
            }
        }
        else if ( !utility::flag( "lost_key_failed" ) && !utility::flag( "lost_key_drop" ) )
        {
            level thread cleanup_lost_key();
            level thread zm_quest::restart_quest( #"mantis_ee_lost_key" );
        }
        
        if ( self.mdl_container )
        {
            self.mdl_container delete();
        }
        
        if ( self.var_c503500995aa2f03 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0xc65d7c9f, Offset: 0xce2
// Size: 0x69
function private function_803dcf7ace0b83b9( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( utility::flag( "lost_key_failed" ) )
    {
        level waittill( #"hash_1341555b3190641a" );
        utility::flag_clear( "lost_key_failed" );
    }
    
    level thread spawn_lost_key();
    level utility::flag_wait( "found_first_key" );
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0xfaedf4a2, Offset: 0xd53
// Size: 0x3e
function private function_3bc64f7912a72a5e( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_6da703457ef89407++;
        function_53f960e596935b5b();
        level utility::flag_set( "found_first_key" );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0x1c10f503, Offset: 0xd99
// Size: 0x36
function private function_803dcc7ace0b7d20( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread spawn_lost_key();
    level utility::flag_wait( "found_second_key" );
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0x66947d8b, Offset: 0xdd7
// Size: 0x3e
function private function_3bc64e7912a7282b( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_6da703457ef89407++;
        function_53f960e596935b5b();
        level utility::flag_set( "found_second_key" );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0xee9efb7c, Offset: 0xe1d
// Size: 0x36
function private function_803dcd7ace0b7f53( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread spawn_lost_key();
    level utility::flag_wait( "found_third_key" );
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0x941a73f4, Offset: 0xe5b
// Size: 0x3e
function private function_3bc64d7912a725f8( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_6da703457ef89407++;
        function_53f960e596935b5b();
        level utility::flag_set( "found_third_key" );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0x7aba995a, Offset: 0xea1
// Size: 0x36
function private function_803dd27ace0b8a52( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread spawn_lost_key();
    level utility::flag_wait( "found_fourth_key" );
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0x3e11d2, Offset: 0xedf
// Size: 0x3e
function private function_3bc6547912a7355d( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_6da703457ef89407++;
        function_53f960e596935b5b();
        level utility::flag_set( "found_fourth_key" );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0xac804ad5, Offset: 0xf25
// Size: 0x36
function private function_803dd37ace0b8c85( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread spawn_lost_key();
    level utility::flag_wait( "found_fifth_key" );
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0xd604c25d, Offset: 0xf63
// Size: 0x3e
function private function_3bc6537912a7332a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level.var_6da703457ef89407++;
        function_53f960e596935b5b();
        level utility::flag_set( "found_fifth_key" );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0x65f4a692, Offset: 0xfa9
// Size: 0x5a
function private function_803da07ace0b1c5c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        utility::flag_set( "lost_key_drop" );
        utility::flag_set( "lost_key_pickup" );
        return;
    }
    
    utility::flag_wait( "lost_key_pickup" );
    level thread generate_reward();
    level utility::flag_wait( "lost_key_ee_compeleted" );
}

// Namespace namespace_f9729c60380b35b3
// Params 2, eflags: 0x4
// Checksum 0xab6eb92a, Offset: 0x100b
// Size: 0x88
function private function_3bc6a27912a7e0e7( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "lost_key_ee_compeleted" );
        
        if ( level.var_6fbbf4bf418609c7.reward_cache )
        {
            level.var_6fbbf4bf418609c7.reward_cache delete();
        }
        
        clip = getent( "lost_key_crate_clip", "script_noteworthy" );
        
        if ( clip )
        {
            clip connectpaths();
            clip notsolid();
        }
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0xafd547bf, Offset: 0x109b
// Size: 0x1de
function spawn_lost_key()
{
    var_bc4f5542412fa64d = [];
    
    foreach ( loc in level.var_78063ddc3c438563 )
    {
        if ( loc && !loc.var_c503500995aa2f03 )
        {
            var_bc4f5542412fa64d[ var_bc4f5542412fa64d.size ] = loc;
        }
    }
    
    if ( var_bc4f5542412fa64d.size > 0 )
    {
        saved_index = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_e1cf349ab6fc611d" );
        
        if ( saved_index )
        {
            foreach ( loc in var_bc4f5542412fa64d )
            {
                if ( loc.index == saved_index )
                {
                    s_key_pos = loc;
                    break;
                }
            }
        }
        else
        {
            s_key_pos = utility::array_random( var_bc4f5542412fa64d );
        }
        
        s_key_pos.var_ab20f5da85948717 = 1;
        s_key_pos.var_cc32dd827033ebb5 = utility::spawn_model( s_key_pos.script_noteworthy, s_key_pos.origin + ( 0, 0, -30 ), s_key_pos.angles );
        
        if ( s_key_pos.index )
        {
            zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"hash_e1cf349ab6fc611d", s_key_pos.index );
        }
        
        s_key_pos thread function_68bc6af79054efd();
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0xf8565949, Offset: 0x1281
// Size: 0x110
function function_4f02561e89c6398c()
{
    level endon( #"game_ended" );
    level endon( #"lost_key_ee_compeleted" );
    
    while ( true )
    {
        level waittill( #"hash_e20a2fa27f8c6de7" );
        duration = level.timetravel.data.warm_up_duration + level.timetravel.data.timetravel_duration;
        wait duration;
        
        foreach ( loc in level.var_78063ddc3c438563 )
        {
            if ( loc && loc.var_c503500995aa2f03 )
            {
                loc thread spawn_container();
            }
        }
        
        level notify( #"hash_1341555b3190641a" );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0xc4d9d6c3, Offset: 0x1399
// Size: 0x10d
function cleanup_lost_key()
{
    level.var_6da703457ef89407 = 0;
    level.var_78063ddc3c438563 = utility::getstructarray( "sq_lost_key_container_loc", "targetname" );
    
    foreach ( loc in level.var_78063ddc3c438563 )
    {
        if ( loc.var_ab20f5da85948717 )
        {
            loc.var_ab20f5da85948717 = 0;
            loc.var_cc32dd827033ebb5 delete();
        }
    }
    
    level utility::flag_clear( "found_first_key" );
    level utility::flag_clear( "found_second_key" );
    level utility::flag_clear( "found_third_key" );
    level utility::flag_clear( "found_fourth_key" );
    level utility::flag_clear( "found_fifth_key" );
    utility::flag_set( "lost_key_failed" );
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0xc0b6763e, Offset: 0x14ae
// Size: 0x193
function function_68bc6af79054efd()
{
    level endon( #"game_ended" );
    self.var_cc32dd827033ebb5 endon( #"death" );
    self.a_players_show_to = [];
    
    while ( isdefined( self.var_cc32dd827033ebb5 ) )
    {
        foreach ( player in level.players )
        {
            if ( player zombie_perks::has_perk( "specialty_death_perception" ) && namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                if ( distancesquared( player.origin, self.origin ) < squared( 300 ) )
                {
                    if ( !arraycontains( self.a_players_show_to, player ) )
                    {
                        self.a_players_show_to = arraycombineunique( self.a_players_show_to, [ player ] );
                        self.var_cc32dd827033ebb5 showtoplayer( player );
                        self.var_cc32dd827033ebb5 hudoutlineenableforclient( player, "death_perception_mantis_mq" );
                    }
                    
                    continue;
                }
                
                if ( arraycontains( self.a_players_show_to, player ) )
                {
                    self.a_players_show_to = arrayremove( self.a_players_show_to, player );
                    self.var_cc32dd827033ebb5 hudoutlinedisableforclient( player );
                    self.var_cc32dd827033ebb5 hidefromplayer( player );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 1
// Checksum 0xf2b8d574, Offset: 0x1649
// Size: 0x8a
function on_quest_item_pickup( params )
{
    itembundle = params.bundle;
    player = params.player;
    
    if ( itembundle.ref == "sat_zm_quest_mantis_ee_lost_key" )
    {
        player playsoundtoteam( "evt_ee_complete_success_stinger", player.team );
        utility::flag_set( "lost_key_pickup" );
        zm_quest::function_4eefe6de31f5ddab( #"mantis_ee_lost_key", #"lost_key_picked_up", 1 );
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0xbf746800, Offset: 0x16db
// Size: 0x35f
function generate_reward()
{
    level utility::flag_wait( "begin_round_logic" );
    inventory_group = %"hash_30d1f71d3877d096";
    reward_cache_loc = level.var_6fbbf4bf418609c7;
    reward_cache_loc.reward_cache = utility::spawn_model( reward_cache_loc.script_noteworthy, reward_cache_loc.origin, reward_cache_loc.angles );
    var_da6fb44cbe49338d = [];
    clip = getent( "lost_key_crate_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip disconnectpaths();
        clip solid();
    }
    
    playsoundatpos( level.var_6fbbf4bf418609c7.origin, #"hash_ceba5926772db5b0" );
    
    foreach ( player in level.players )
    {
        var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_lost_key_ee_rewards", "Default" );
        interact = common_cache::function_74364c32a1e82886( inventory_group, reward_cache_loc.origin + ( 0, 0, 30 ), 50, &function_20c57d37ed73018a );
        interact sethintonobstruction( "show" );
        common_cache::function_61ef9e0b74e10aaf( interact.cache, var_8b5270de14dff72e );
        
        for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
        {
            item_name = var_8b5270de14dff72e[ i ];
            weapondata = undefined;
            
            if ( common_item::function_3cba34a99d02cd9( item_name ) == "weapon" )
            {
                scriptbundlestruct = getscriptbundlefieldvalues( item_name, [ #"baseweapon", #"rarity" ] );
                weaponname = scriptbundlestruct.baseweapon;
                rarity = scriptbundlestruct.rarity;
                favoriteweapon = player weaponmetadata::function_c68204eff69ed046( weaponname );
                
                if ( isdefined( favoriteweapon ) )
                {
                    item_name = item_weapon::function_3da93a43aae4473d( favoriteweapon.basename, rarity );
                    weapondata = item_weapon::function_fdc74b9be99fda2f( favoriteweapon );
                    weapondata.rarity = rarity;
                    weapondata.weaponobj = favoriteweapon;
                }
            }
            
            skipomnvars = !isdefined( weapondata );
            common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_name, undefined, skipomnvars, undefined, weapondata );
        }
        
        interact enableplayeruse( player );
        var_da6fb44cbe49338d[ var_da6fb44cbe49338d.size ] = interact;
        interact.owner = player;
        
        foreach ( otherplayer in level.players )
        {
            if ( otherplayer != player )
            {
                interact disableplayeruse( otherplayer );
            }
        }
    }
    
    level thread function_fdf18b61df226cc3( var_da6fb44cbe49338d, reward_cache_loc.reward_cache );
}

// Namespace namespace_f9729c60380b35b3
// Params 2
// Checksum 0x63cf5159, Offset: 0x1a42
// Size: 0x11d
function function_fdf18b61df226cc3( var_da6fb44cbe49338d, cache_model )
{
    level endon( #"game_ended" );
    level thread function_38c9bc2223b03( cache_model );
    
    while ( var_da6fb44cbe49338d.size > 0 )
    {
        var_d57394a345db40cf = [];
        
        foreach ( cache_interact in var_da6fb44cbe49338d )
        {
            if ( cache_interact )
            {
                if ( common_cache::iscontainerempty( cache_interact.cache ) || !isplayer( cache_interact.owner ) )
                {
                    cache_interact notify( #"death" );
                    
                    if ( cache_interact )
                    {
                        cache_interact delete();
                    }
                    
                    continue;
                }
                
                var_d57394a345db40cf[ var_d57394a345db40cf.size ] = cache_interact;
            }
        }
        
        var_da6fb44cbe49338d = var_d57394a345db40cf;
        wait 0.1;
    }
    
    level notify( #"hash_c2afd573bd86d7e0" );
    level utility::flag_set( "lost_key_ee_compeleted" );
}

// Namespace namespace_f9729c60380b35b3
// Params 1
// Checksum 0x5365b39b, Offset: 0x1b67
// Size: 0xb3
function function_38c9bc2223b03( cache_model )
{
    level endon( #"game_ended" );
    level waittill( #"hash_c2afd573bd86d7e0" );
    level waittill( #"hash_e20a2fa27f8c6de7" );
    duration = level.timetravel.data.warm_up_duration + level.timetravel.data.timetravel_duration;
    wait duration;
    
    if ( cache_model )
    {
        cache_model delete();
    }
    
    clip = getent( "lost_key_crate_clip", "script_noteworthy" );
    
    if ( clip )
    {
        clip connectpaths();
        clip notsolid();
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 2
// Checksum 0xb6617c8a, Offset: 0x1c22
// Size: 0x36
function function_20c57d37ed73018a( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_f9729c60380b35b3
// Params 2
// Checksum 0x3daa8306, Offset: 0x1c61
// Size: 0x5d
function function_59f83d442d0a93aa( str_vo_to_play, var_1fc51011987c93fe )
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

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0x13827d5f, Offset: 0x1cc6
// Size: 0x2a8
function function_53f960e596935b5b()
{
    var_c4f1208d870591b6 = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_2084ea61da130cae" );
    var_c4f11f8d87058f83 = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_f7e8f6c9bda536c2" );
    var_c4f11e8d87058d50 = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_84cc28427b8ea945" );
    var_c4f1258d87059cb5 = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_421c0daceea1a0ee" );
    var_c4f1248d87059a82 = zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"hash_f4e4e922dcbac399" );
    
    foreach ( loc in level.var_78063ddc3c438563 )
    {
        if ( var_c4f1208d870591b6 )
        {
            if ( loc.index == var_c4f1208d870591b6 )
            {
                loc function_7ec707e8c35c4f50();
                break;
            }
        }
        
        if ( var_c4f11f8d87058f83 )
        {
            if ( loc.index == var_c4f11f8d87058f83 )
            {
                loc function_7ec707e8c35c4f50();
                break;
            }
        }
        
        if ( var_c4f11e8d87058d50 )
        {
            if ( loc.index == var_c4f11e8d87058d50 )
            {
                loc function_7ec707e8c35c4f50();
                break;
            }
        }
        
        if ( var_c4f1258d87059cb5 )
        {
            if ( loc.index == var_c4f1258d87059cb5 )
            {
                loc function_7ec707e8c35c4f50();
                break;
            }
        }
        
        if ( var_c4f1248d87059a82 )
        {
            if ( loc.index == var_c4f1248d87059a82 )
            {
                loc function_7ec707e8c35c4f50();
                level utility::flag_wait_all( "zm_quest_initialized", "scriptables_ready", "begin_round_logic" );
                
                if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_ee_lost_key", #"lost_key_picked_up" ) )
                {
                    level thread generate_reward();
                }
                else if ( loc.target )
                {
                    s_drop_target = utility::getstruct( loc.target );
                    drop_position = getclosestpointonnavmesh( s_drop_target.origin );
                    level thread zm_quest::drop_quest_item( loc.origin, drop_position, %"hash_7ce7933eb28adac5" );
                    utility::flag_set( "lost_key_drop" );
                }
                else
                {
                    zm_quest::drop_quest_item( self.origin + ( 0, 0, 50 ), getrandomnavpoint( self.origin, 150 ), %"hash_7ce7933eb28adac5" );
                }
                
                break;
            }
        }
    }
}

// Namespace namespace_f9729c60380b35b3
// Params 0
// Checksum 0x28a38fa0, Offset: 0x1f76
// Size: 0x48
function function_7ec707e8c35c4f50()
{
    self.var_c503500995aa2f03 = 1;
    self.var_ab20f5da85948717 = 0;
    
    if ( self.mdl_container )
    {
        self.mdl_container delete();
    }
    
    level.var_78063ddc3c438563 = arrayremove( level.var_78063ddc3c438563, self );
}

/#

    // Namespace namespace_f9729c60380b35b3
    // Params 0
    // Checksum 0x2f075705, Offset: 0x1fc6
    // Size: 0x9a, Type: dev
    function function_f46e878e8ec6035e()
    {
        root = "<dev string:x24>";
        devgui::function_9082edeb5db93280( root + "<dev string:x41>" );
        devgui::add_devgui_func( "<dev string:x48>", "<dev string:x48>", &function_a04a3ff68025264 );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x61>", &skip_to_open_chest );
        devgui::add_devgui_func( "<dev string:x74>", "<dev string:x74>", &function_a361a1f427a6c42a );
        devgui::add_devgui_func( "<dev string:x87>", "<dev string:x87>", &function_15aadba181fa2ac3 );
        devgui::add_devgui_func( "<dev string:x9b>", "<dev string:x9b>", &function_a10ed930d9527a27 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_f9729c60380b35b3
    // Params 0
    // Checksum 0x345f45bc, Offset: 0x2068
    // Size: 0xa3, Type: dev
    function function_a04a3ff68025264()
    {
        level endon( #"game_ended" );
        level.var_78063ddc3c438563 = utility::getstructarray( "<dev string:xb0>", "<dev string:xca>" );
        
        foreach ( loc in level.var_78063ddc3c438563 )
        {
            loc thread drawsphere();
        }
    }

    // Namespace namespace_f9729c60380b35b3
    // Params 0
    // Checksum 0x26797b18, Offset: 0x2113
    // Size: 0xc, Type: dev
    function skip_to_open_chest()
    {
        generate_reward();
    }

    // Namespace namespace_f9729c60380b35b3
    // Params 0
    // Checksum 0xc337f2f2, Offset: 0x2127
    // Size: 0xee, Type: dev
    function function_a361a1f427a6c42a()
    {
        foreach ( loc in level.var_78063ddc3c438563 )
        {
            s_drop_target = utility::getstruct( loc.target );
            drop_position = getclosestpointonnavmesh( s_drop_target.origin );
            item = level zm_quest::drop_quest_item( loc.origin, drop_position, %"hash_7ce7933eb28adac5" );
            wait 1;
            
            if ( item )
            {
                item thread drawsphere( ( 0, 0, 1 ) );
            }
        }
    }

    // Namespace namespace_f9729c60380b35b3
    // Params 1
    // Checksum 0x91068e44, Offset: 0x221d
    // Size: 0xd1, Type: dev
    function drawsphere( color )
    {
        self notify( #"hash_dc8b34de5fd41fd5" );
        self endon( #"hash_dc8b34de5fd41fd5" );
        level endon( #"game_ended" );
        
        if ( self.mdl_container )
        {
            self.mdl_container endon( #"death" );
        }
        
        var_8ffb5fae1c3df313 = color ?? ( 1, 1, 1 );
        draw_origin = self.origin - ( 0, 0, 20 );
        
        while ( true )
        {
            if ( self.var_c503500995aa2f03 )
            {
                break;
            }
            
            if ( self.var_ab20f5da85948717 )
            {
                var_8ffb5fae1c3df313 = ( 1, 1, 0 );
            }
            
            sphere( draw_origin, 10, var_8ffb5fae1c3df313, 0 );
            waitframe();
        }
    }

    // Namespace namespace_f9729c60380b35b3
    // Params 0
    // Checksum 0x79046b27, Offset: 0x22f6
    // Size: 0x12, Type: dev
    function function_15aadba181fa2ac3()
    {
        level utility::flag_set( "<dev string:xd5>" );
    }

    // Namespace namespace_f9729c60380b35b3
    // Params 0
    // Checksum 0x8f5cda3c, Offset: 0x2310
    // Size: 0x12, Type: dev
    function function_a10ed930d9527a27()
    {
        level utility::flag_clear( "<dev string:xd5>" );
    }

#/
