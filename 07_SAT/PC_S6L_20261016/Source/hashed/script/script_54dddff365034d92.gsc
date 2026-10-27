// script_54dddff365034d92  (hash_54dddff365034d92.gscc) (size: 41035 Bytes / 0xa04b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48404d23 (1212173603)
// size ...... 41035 (0xa04b)
// includes .. 32  (offset: 0x9187)
// strings ... 171 (offset: 0x9287)
// dev strs .. 91  (offset: 0x9b67)
// exports ... 65  (offset: 0x66df)
// cseg ...... 0xb1e + 0x5bc1 (0x66df)
// imports ... 238 (offset: 0x7107)
// animtree1 . 0   (offset: 0xa04b)
// animtree2 . 0   (offset: 0xa04b)
#using script_11135abf83b49078;
#using script_14f857806c1ea0cc;
#using script_16ea1b94f0f381b3;
#using script_190e128009243fcb;
#using script_1ccff940e7de18ed;
#using script_1ec532eb6eacdf6f;
#using script_1fc20b38e0fc8291;
#using script_38a61e43967bfd11;
#using script_46e6a605b00ce67c;
#using script_4cc8a0ecc1f50901;
#using script_5cda26b07ee216bf;
#using script_5d3960c405a24eb9;
#using script_61b40095fd0502f0;
#using script_640b69521097c6a5;
#using script_67ffbe87dc9436fa;
#using script_6a71daf1a601e6f5;
#using script_6de1b9fbdf8db6bb;
#using script_80384e18a067d91;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;

#namespace zombie_weyward;

// Namespace zombie_weyward
// Params 2
// Checksum 0xe8e09a20, Offset: 0xb3c
// Size: 0xc2
function precache( classname, aitypescriptbundle )
{
    zombie_weyward_bomb_attack::precache( aitypescriptbundle );
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "shadow_soul_shield_impact_immune", var_4b4d72d84afd1ebd.var_5795287ff8e00e8b );
        utility::add_fx( "immune_drain_beam_fx", var_4b4d72d84afd1ebd.var_6ae537cc09db47b0 );
        utility::add_fx( "fake_death_beam_fx", var_4b4d72d84afd1ebd.var_7142c00263eaa47c );
        utility::add_fx( "real_death_shadowsmith_spawn_fx", var_4b4d72d84afd1ebd.var_7a0cb2dd20f6f6ba );
        utility::add_fx( "real_death_shadowsmith_ambient_fx", var_4b4d72d84afd1ebd.var_6941367563ba0ebb );
        utility::add_fx( "real_death_beam_fx", var_4b4d72d84afd1ebd.var_9d872235db2335b5 );
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x565226a1, Offset: 0xc06
// Size: 0xaa
function private function_77638f66bcdde2b6( params )
{
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_summoned_by_weyward", &on_summoned_by_weyward );
    zombie_boss_healthbar::function_f50a10314e72caa1();
    zombie_weyward_melee::function_c0467b6eefab8cac();
    zombie_weyward_dash::function_4ae528e72a7e4964();
    zombie_weyward_skull::function_6473f38b50cfcaf7();
    zombie_weyward_charge::function_721331952e522204();
    zombie_weyward_summon_stinger::function_fa0b98206a382d06();
    zombie_weyward_shadow_soul::function_f7d097c7de4febee();
    namespace_3156272e8cb1d737::function_76eb282120e46bc6();
    zombie_weyward_wipe_attack::function_916c9689e28d0a30();
    zombie_weyward_metabones::function_420e30d2247d2ef4();
    zombie_weyward_bomb_attack::function_56ab258fe2a3cce3();
    zombie_weyward_move::function_e4d8e5546536614f();
    
    /#
        setup_zombie_weyward_devgui();
    #/
}

// Namespace zombie_weyward
// Params 1
// Checksum 0x9a05f042, Offset: 0xcb8
// Size: 0x25a
function function_dc3675a1bcb7673f( taskid )
{
    profilestart();
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    
    /#
        self.var_578d003dc0623cbd = &function_e9f572c2adcb0d78;
    #/
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.fake_death_duration = settings.var_39cdd2de355e53c3 ?? 7;
    thread function_7927969b837352d3();
    zombie_weyward_melee::init_zombie_weyward_melee();
    zombie_weyward_dash::init_zombie_weyward_dash();
    zombie_weyward_skull::init_zombie_weyward_skull();
    zombie_weyward_charge::init_zombie_weyward_charge();
    zombie_weyward_summon_stinger::init_zombie_weyward_summon_stinger();
    zombie_weyward_shadow_soul::init_zombie_weyward_shadow_soul();
    namespace_3156272e8cb1d737::function_c30fcfbe8423b180();
    zombie_weyward_wipe_attack::init_zombie_weyward_wipe_attack();
    zombie_weyward_metabones::init_zombie_weyward_metabones();
    zombie_weyward_bomb_attack::init_zombie_weyward_bomb_attack();
    zombie_weyward_move::init_zombie_weyward_move();
    namespace_c57c4bda2cd4484a::function_be7f75e77fc81607();
    val::set( "weyward_init", "death", 0 );
    self.nocorpse = undefined;
    self.noragdoll = 1;
    self.script_noragdoll = 1;
    self.allowstrafe = 0;
    self function_dc61b81ec6b63cc4( 1 );
    self function_786bb6aa1b76c7ee( "in_intro_sequence", 0 );
    self function_786bb6aa1b76c7ee( "in_fake_death", 0 );
    self function_786bb6aa1b76c7ee( "in_real_death", 0 );
    self function_786bb6aa1b76c7ee( "no_enemies_detected", 0 );
    self function_786bb6aa1b76c7ee( "force_disable_agressive", 0 );
    self.var_5aec25c2f3f2ef0f = 0;
    self.var_d0bf4e98be69cc46 = undefined;
    self.var_1953f9c670e48fc3 = 0;
    self.var_16d1d2c5e65fa11 = undefined;
    self.var_8f4c35508fccfde8 = 0;
    self.var_d5f0dfdd198e4f63 = 0;
    self.var_13518fb33ec73cc = 30;
    self.prevent_knockdown = 1;
    self.allowfriendlyfire = 1;
    self.var_f968344e6801d0c1 = 1;
    self.var_1e0c6c188b1cfd56 = "j_spineupper";
    self.fake_death_triggered = 0;
    self function_10006c8216ad87fd( "focus_behaviors", "fsm", "no_focus" );
    self enableavoidance( 0, 1 );
    self function_78a8bbd6805e6296( "custom_default_on", 0 );
    self enabletraversals( 0 );
    val::set( "zombie_weyward_init", "high_net_lod", 1 );
    self function_43a971093c992365( 1 );
    self disableaimassist();
    zombie_utils::function_dfae6a5bd222c586( &function_7adbda7119ff11f5 );
    callback::add( "on_first_ai_init", &function_77638f66bcdde2b6 );
    thread function_1fa648263bc554ee();
    thread function_25ab54d73644285a();
    profilestop();
    return anim.success;
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x602e3ac9, Offset: 0xf1c
// Size: 0x127
function private function_25ab54d73644285a()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_912f1d9eafed3219 = squared( sqrt( squared( 1350 ) ) - 320 );
    
    while ( true )
    {
        if ( self.var_cb0f79c5c25b23f4 )
        {
            /#
                if ( function_62adaef14350a13e() )
                {
                    function_9d8db956cabecb5d( self.var_cb0f79c5c25b23f4, sqrt( squared( 1350 ) ) );
                }
            #/
            
            var_7595c8f737d17d6b = distance2dsquared( self.origin, self.var_cb0f79c5c25b23f4 );
            
            if ( var_7595c8f737d17d6b >= var_912f1d9eafed3219 )
            {
                while ( self.var_cb0f79c5c25b23f4 && var_7595c8f737d17d6b >= var_912f1d9eafed3219 )
                {
                    if ( !function_888999886bd5e3b8() && !ispointonnavmesh( self.origin, self ) )
                    {
                        closest_navmesh_point = getclosestpointonnavmesh( self.origin, self, 0, 1, 1 );
                        
                        if ( closest_navmesh_point )
                        {
                            self forceteleport( closest_navmesh_point, self.angles, 3000 );
                        }
                    }
                    
                    var_7595c8f737d17d6b = distance2dsquared( self.origin, self.var_cb0f79c5c25b23f4 );
                    waitframe();
                }
                
                continue;
            }
        }
        
        wait 0.25;
    }
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x5775d1bb, Offset: 0x104b
// Size: 0x21d
function private function_1fa648263bc554ee()
{
    var_e67be7806b6bbc09 = 1;
    self endon( #"death" );
    level endon( #"game_ended" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 1 );
    
    while ( true )
    {
        var_2407eeb13e7a18 = [];
        var_dc4d5eb958479095 = [];
        var_78b235f08db9352e = function_e20925e94ead934d();
        multiple_players = level.players.size > 1;
        
        if ( multiple_players )
        {
            self.var_d9215b502d26ae72 = [];
        }
        
        foreach ( player in level.players )
        {
            if ( var_78b235f08db9352e )
            {
                function_ab6c257e70d2d3be( player );
            }
            else if ( function_4d51c1da012a5f1a( player ) )
            {
                var_dc4d5eb958479095[ var_dc4d5eb958479095.size ] = player;
            }
            
            player_detectable = isalive( player ) && !player.inlaststand && !player.ignoreme && !player.notarget && !player.aether_shroud_active && player getthreatbiasgroup() != "ignored_by_zombies" && player.sessionstate == "playing" && player_in_arena( player );
            
            if ( multiple_players )
            {
                namespace_c57c4bda2cd4484a::function_1604db740fdad59( player, player_detectable );
            }
            
            if ( !player_detectable )
            {
                continue;
            }
            
            var_2407eeb13e7a18[ var_2407eeb13e7a18.size ] = player;
        }
        
        self.var_2407eeb13e7a18 = var_2407eeb13e7a18;
        
        if ( multiple_players )
        {
            namespace_c57c4bda2cd4484a::function_cfa262d4ab9638ed();
        }
        else
        {
            namespace_c57c4bda2cd4484a::function_a6147cfb6703733();
        }
        
        all_players_undetectable = level.players.size > 0 && var_2407eeb13e7a18.size == 0;
        self function_786bb6aa1b76c7ee( "no_enemies_detected", all_players_undetectable );
        function_5e360dbf5656a306( var_2407eeb13e7a18 );
        function_dd0617be62388deb( var_dc4d5eb958479095 );
        wait var_e67be7806b6bbc09;
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x75cc80d6, Offset: 0x1270
// Size: 0x1d
function private player_in_arena( player )
{
    return function_4e021654cae8cb02( player.origin );
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xac74b159, Offset: 0x1296
// Size: 0x4c, Type: bool
function private function_4e021654cae8cb02( origin )
{
    if ( !self.var_cb0f79c5c25b23f4 )
    {
        return true;
    }
    
    if ( self.var_cb0f79c5c25b23f4[ 2 ] - origin[ 2 ] > 50 )
    {
        return false;
    }
    
    return distance2dsquared( origin, self.var_cb0f79c5c25b23f4 ) <= squared( 1350 );
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xd15bd786, Offset: 0x12eb
// Size: 0x114
function private function_4d51c1da012a5f1a( player )
{
    if ( !self.var_cb0f79c5c25b23f4 || !isalive( player ) || player.inlaststand || player.sessionstate != "playing" )
    {
        function_ab6c257e70d2d3be( player );
        return 0;
    }
    
    above_arena = player.origin[ 2 ] - self.var_cb0f79c5c25b23f4[ 2 ] >= 200;
    
    if ( !above_arena || !function_4e021654cae8cb02( player.origin ) )
    {
        function_ab6c257e70d2d3be( player );
        return 0;
    }
    
    if ( !player.var_2c06300a33790e78 || distancesquared( player.origin, player.var_2c06300a33790e78 ) > squared( 150 ) )
    {
        player.var_2c06300a33790e78 = player.origin;
        player.var_20a8b738082b892a = gettime();
        return 0;
    }
    
    return utility::time_has_passed( player.var_20a8b738082b892a, 7 );
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xa2cb7bf5, Offset: 0x1408
// Size: 0x22
function private function_ab6c257e70d2d3be( player )
{
    player.var_2c06300a33790e78 = undefined;
    player.var_20a8b738082b892a = undefined;
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x2c64beb4, Offset: 0x1432
// Size: 0x3f
function private function_e20925e94ead934d()
{
    if ( !getdvarint( @"hash_77007b659c3a2501", 1 ) )
    {
        return 1;
    }
    
    if ( self getaiblackboarddynamic( "in_real_death" ) )
    {
        return 1;
    }
    
    if ( utility::flag( "playing_game_over_scene" ) )
    {
        return 1;
    }
    
    return function_888999886bd5e3b8();
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xec101518, Offset: 0x147a
// Size: 0x134
function private function_dd0617be62388deb( var_dc4d5eb958479095 )
{
    if ( !var_dc4d5eb958479095.size || !level.var_7014be48b4467a43 )
    {
        return;
    }
    
    foreach ( player in var_dc4d5eb958479095 )
    {
        if ( player.var_1a85d869e714ca25 && !utility::time_has_passed( player.var_1a85d869e714ca25, 20 ) )
        {
            continue;
        }
        
        player.var_1a85d869e714ca25 = gettime();
        function_ab6c257e70d2d3be( player );
        var_99064b9592368173 = get_arena_camper_teleport_pos();
        params = { #player:player };
        
        if ( var_99064b9592368173 )
        {
            params.origin = var_99064b9592368173.origin;
            params.angles = var_99064b9592368173.angles;
        }
        
        [[ level.var_7014be48b4467a43 ]]( params );
    }
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0xd1512494, Offset: 0x15b6
// Size: 0xe4
function private get_arena_camper_teleport_pos()
{
    base_yaw = self.angles[ 1 ];
    yaw_step = 45;
    var_54c8b28c07e49694 = squared( 150 );
    
    for ( i = 0; i < 8 ; i++ )
    {
        candidate = self.origin + anglestoforward( ( 0, base_yaw + i * yaw_step, 0 ) ) * 220;
        var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( candidate, self, 1, 1, 0, 0 );
        
        if ( !var_4d7d4fdebb3384d2 || !function_4e021654cae8cb02( var_4d7d4fdebb3384d2 ) )
        {
            continue;
        }
        
        if ( distance2dsquared( var_4d7d4fdebb3384d2, self.origin ) < var_54c8b28c07e49694 )
        {
            continue;
        }
        
        return { #angles:( 0, vectortoyaw( self.origin - var_4d7d4fdebb3384d2 ), 0 ), #origin:var_4d7d4fdebb3384d2 };
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xd090003c, Offset: 0x16a3
// Size: 0x156
function private function_5e360dbf5656a306( var_2407eeb13e7a18 )
{
    if ( var_2407eeb13e7a18.size == 0 )
    {
        function_5d07340e64dec2b6( 0 );
        self.var_d0bf4e98be69cc46 = undefined;
        return;
    }
    
    if ( self.var_5aec25c2f3f2ef0f )
    {
        override_expired = utility::time_has_passed( self.var_d5f0dfdd198e4f63, 6 );
        var_786eb0f60c811cf3 = self.var_8f4c35508fccfde8;
        
        if ( override_expired || var_786eb0f60c811cf3 )
        {
            function_5d07340e64dec2b6( 1 );
            return;
        }
        
        zombie_utils::set_ai_target_priority( function_aef20a4a27bea6ec( var_2407eeb13e7a18 ), "arena_bounds", 50 );
        return;
    }
    
    var_75dd362491e6949d = self.var_d0bf4e98be69cc46 && utility::time_has_passed( self.var_1953f9c670e48fc3, 2 );
    
    if ( self.var_d0bf4e98be69cc46 && ( self.enemy != self.var_d0bf4e98be69cc46 || player_in_arena( self.var_d0bf4e98be69cc46 ) || var_75dd362491e6949d ) )
    {
        self.var_d0bf4e98be69cc46 = undefined;
    }
    
    enemy_out_of_arena = isplayer( self.enemy ) && !player_in_arena( self.enemy );
    
    if ( enemy_out_of_arena && self.enemy != self.var_d0bf4e98be69cc46 )
    {
        function_fd92d9b2546fb993( self.enemy, var_2407eeb13e7a18 );
    }
}

// Namespace zombie_weyward
// Params 2, eflags: 0x4
// Checksum 0x591af8c2, Offset: 0x1801
// Size: 0x61
function private function_fd92d9b2546fb993( prev_enemy, var_2407eeb13e7a18 )
{
    self.var_5aec25c2f3f2ef0f = 1;
    self.var_d5f0dfdd198e4f63 = gettime();
    self.var_16d1d2c5e65fa11 = prev_enemy;
    self.var_8f4c35508fccfde8 = 0;
    zombie_utils::set_ai_target_priority( function_aef20a4a27bea6ec( var_2407eeb13e7a18 ), "arena_bounds", 50 );
    thread function_93f70a5e61594361( prev_enemy );
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x251321df, Offset: 0x186a
// Size: 0x76
function private function_5d07340e64dec2b6( var_3a1086783f266408 )
{
    if ( !self.var_5aec25c2f3f2ef0f )
    {
        return;
    }
    
    self notify( #"hash_85fd15fa8c3b57e1" );
    zombie_utils::set_ai_target_priority( undefined, "arena_bounds", 0 );
    self.var_5aec25c2f3f2ef0f = 0;
    
    if ( var_3a1086783f266408 )
    {
        self.var_d0bf4e98be69cc46 = self.var_16d1d2c5e65fa11;
        self.var_1953f9c670e48fc3 = gettime();
    }
    
    self.var_16d1d2c5e65fa11 = undefined;
    self.var_8f4c35508fccfde8 = 0;
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x362b67f5, Offset: 0x18e8
// Size: 0x54
function private function_93f70a5e61594361( prev_enemy )
{
    self endon( #"death" );
    self endon( #"hash_85fd15fa8c3b57e1" );
    level endon( #"game_ended" );
    
    if ( !isplayer( prev_enemy ) )
    {
        return;
    }
    
    prev_enemy waittill( #"hash_11aa35d863af9e64" );
    self.var_8f4c35508fccfde8 = 1;
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xb6057c9e, Offset: 0x1944
// Size: 0xd5
function private function_aef20a4a27bea6ec( var_2407eeb13e7a18 )
{
    closest_player = undefined;
    closest_dist_sq = undefined;
    
    foreach ( player in var_2407eeb13e7a18 )
    {
        if ( !player_in_arena( player ) )
        {
            continue;
        }
        
        dist_sq = distance2dsquared( self.origin, player.origin );
        
        if ( !isdefined( closest_player ) || dist_sq < closest_dist_sq )
        {
            closest_player = player;
            closest_dist_sq = dist_sq;
        }
    }
    
    return closest_player;
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x8a1b7c6f, Offset: 0x1a22
// Size: 0x2e, Type: bool
function private function_888999886bd5e3b8()
{
    if ( utility::ent_flag( "in_soul_phase_transition" ) )
    {
        return true;
    }
    
    return utility::flag( "scarab_boss_fight_start" ) && !utility::flag( "scarab_boss_intro_done" );
}

// Namespace zombie_weyward
// Params 1
// Checksum 0x86bfa98c, Offset: 0x1a59
// Size: 0x17
function function_8b23d58e736c94f9( var_bbf1019a9b87e7d2 )
{
    self.var_cb0f79c5c25b23f4 = var_bbf1019a9b87e7d2;
}

// Namespace zombie_weyward
// Params 1
// Checksum 0x77942e1c, Offset: 0x1a78
// Size: 0xc0
function function_2d15de9b85618782( value )
{
    if ( value )
    {
        val::set( "weyward_real_death", "damage", !value );
        val::set( "weyward_real_death", "death", !value );
        val::set( "weyward_real_death", "fire", !value );
        val::set( "weyward_real_death", "offhand_weapons", !value );
        val::set( "weyward_real_death", "melee", !value );
        val::set( "weyward_real_death", "allow_scripted_bgb_use", !value );
        val::set( "weyward_real_death", "killstreaks", !value );
        val::set( "weyward_real_death", "show_hud", !value );
        return;
    }
    
    val::reset_all( "weyward_real_death" );
}

// Namespace zombie_weyward
// Params 2
// Checksum 0x761a480a, Offset: 0x1b40
// Size: 0x9d
function function_71469b0e178ed1d7( taskid, params )
{
    if ( getdvarfloat( @"hash_7248180ae9768807", 0 ) > 0 )
    {
        return anim.success;
    }
    
    if ( self.active_attractors.size || utility::flag( "playing_game_over_scene" ) )
    {
        zombie_utils::update_bt_goal( self.origin );
        return anim.success;
    }
    
    patrol_pos = function_c6861d04ef1fe32c();
    
    if ( !isdefined( patrol_pos ) )
    {
        return anim.success;
    }
    
    zombie_utils::update_bt_goal( patrol_pos );
    return anim.success;
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x23564621, Offset: 0x1be6
// Size: 0x2086
function private function_7adbda7119ff11f5( params )
{
    if ( self.shadow_soul_immune )
    {
        if ( isdefined( params.vpoint ) )
        {
            var_1d4d1f382e7d2c0c = utility::getfx( "shadow_soul_shield_impact_immune" );
            
            if ( isdefined( var_1d4d1f382e7d2c0c ) )
            {
                playfx( var_1d4d1f382e7d2c0c, params.vpoint );
            }
        }
        
        return 0;
    }
    
    if ( isdefined( params.metabonename ) )
    {
        utility::function_7c10ea82c1e305b8( "impact", params.metabonename );
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_bbb7a6d50d6904d1 = getdvarfloat( @"hash_3ad92b4b19dd5c0e", 2 );
    var_52eec01ca61dbf15 = getdvarint( @"hash_7c2eeaa5882f1322", 6000 );
    var_3f2e80330371bcc1 = getdvarint( @"hash_5c4fe90a98534e8b", 7500 );
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_e5091200a2871f75", 2 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_22dc74cd54ff3baa", 0.09 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_635c7df2a8c34ea1", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_100d86e203b9c264", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_6b5f33756fc7b300", 3.5 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_bd801717e88cb024", 0.5 );
    var_ed407dcb475395c = getdvarfloat( @"hash_cc437986385dc473", 0.4 );
    var_e6b3918506ea5e30 = getdvarfloat( @"hash_9596e40d51252f8f", 0.6 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_105513890b4f7303", 0.7 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_460a97f646306d54", 0.8 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_3d86ffad60739b75", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_d77ea8da19c61943", 0.75 );
    var_31ff27f24504c5c6 = getdvarfloat( @"hash_5cfc823ea1be1df8", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_ce50d1df735720c0", 0.7 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_8e814f30e1f26482", 6 );
    var_1b8b28636737013e = getdvarfloat( @"hash_91a3e95040c9100", 0.45 );
    var_4f79672e8ec957ce = getdvarfloat( @"hash_d5e48b027bede5ea", 0.65 );
    var_cef89d00885df997 = getdvarfloat( @"hash_216f5d063490d234", 3.5 );
    var_d48cf9ae0101f824 = getdvarfloat( @"hash_b800824d7c3092cf", 0.6 );
    var_2735afaab8d7322e = getdvarfloat( @"hash_f5f04f5994ee6f69", 0.8 );
    var_30e23d6f68aeab2f = getdvarfloat( @"hash_2cf47988045bb588", 0.2 );
    var_cbe1b29ad713515f = getdvarfloat( @"hash_541719eb0e371fec", 1 );
    var_11ffd83c4978f00a = getdvarfloat( @"hash_48b57949680faf05", 9 );
    var_27290881d032efef = getdvarfloat( @"hash_8d586dd016f4188c", 5 );
    var_20ad41a7190f3038 = getdvarfloat( @"hash_8988cb97294d29df", 1 );
    var_44534fdcf7bf3e3e = getdvarfloat( @"hash_fd31a90a517a0569", 0.35 );
    var_908e47d7962b0ec7 = getdvarfloat( @"hash_254c4b165a8bd458", 0.35 );
    var_87adbecba0c9b50b = getdvarfloat( @"hash_31eecd7d510afa24", 1 );
    var_e53b66a0bc564ac7 = getdvarfloat( @"hash_666c9c42520cb208", 0.45 );
    var_1ee624ee6ce0fe17 = getdvarfloat( @"hash_756484ba95e183c8", 0.5 );
    var_9a63c8107d8fe6bc = getdvarfloat( @"hash_cf86ee4d7836fb23", 0.3 );
    var_f68435a7c71028a9 = getdvarfloat( @"hash_6dd9cc45ab41840a", 0.5 );
    var_db0d136f8ce8451e = getdvarfloat( @"hash_355928cb359775d", 0.75 );
    var_fa6ae129f40e640d = getdvarfloat( @"hash_a896a5e8c8202252", 0.75 );
    var_3a0dd038443396ba = getdvarfloat( @"hash_d82d0238710c4ff5", 0.75 );
    var_83d37edf201b2cfd = getdvarfloat( @"hash_51856d4d0f36320e", 0.95 );
    var_95511d95a93958e7 = getdvarfloat( @"hash_8bbe46d3e8d04ce8", 1.35 );
    var_e5ee15bc1309375a = getdvarfloat( @"hash_e00572f39f33a7a9", 1 );
    var_66b304267f9502e = getdvarfloat( @"hash_1f357bea2deb6eed", 0.75 );
    var_741aaacb780e3fcb = getdvarfloat( @"hash_168576b96ecb7ec8", 0.65 );
    var_d425946c0ecce92b = getdvarfloat( @"hash_84f0ffec00e6d16c", 1 );
    var_7de7ff1e14998598 = getdvarfloat( @"hash_c55d187d201230d3", 1 );
    var_e8ac91a5ef2b0fd1 = getdvarfloat( @"hash_28e6b5081244f4a6", 0.65 );
    var_f835858b1b1cbcca = getdvarfloat( @"hash_8f08881644c61d5", 0.45 );
    var_ca16f864fec9a903 = getdvarfloat( @"hash_f7dbb22440970c5c", 0.45 );
    var_18e2266ff0e121f5 = getdvarfloat( @"hash_52b75059453efee2", 0.75 );
    var_64021406c1e284a4 = getdvarfloat( @"hash_c6059b42b9edbcab", 0.15 );
    var_dcb0e656c9c82522 = getdvarfloat( @"hash_faffc529fd9572b5", 0.15 );
    var_822e9de3dfba30c0 = getdvarfloat( @"hash_2341b3bb6266271f", 0.2 );
    var_d60770d185f48ebf = getdvarfloat( @"hash_b51d78386403e354", 0.23 );
    var_5ad4058fe42539a = getdvarfloat( @"hash_2ca9be1dbd406b1d", 0.16 );
    var_41d6ed60e93466cc = getdvarfloat( @"hash_6adac911f39e41b7", 0.2 );
    var_4902ecca444e0a0a = getdvarfloat( @"hash_d52824ead5e187d", 0.25 );
    var_954e3c92eeaffe8a = getdvarfloat( @"hash_6b8c62b866b0e481", 0.15 );
    var_1db18fb14b819f46 = getdvarfloat( @"hash_779f917305a5b2d5", 0.35 );
    var_bbeff31a90e06ee5 = getdvarfloat( @"hash_fb1a07bca05b008e", 0.25 );
    var_a3ca9f131d6300f9 = getdvarfloat( @"hash_b78f9a890783c4ee", 0.11 );
    var_8519d2664696609c = getdvarfloat( @"hash_b15a8bf77dcccbe7", 0.15 );
    var_b3b83a5ab245b7ec = getdvarfloat( @"hash_86b1245416a948cb", 0.35 );
    var_171f46ae7095831b = getdvarfloat( @"hash_f56f729971098310", 0.15 );
    var_f5cdb22b4777022d = getdvarfloat( @"hash_a3bc5f7a5236729e", 0.5 );
    var_4b7fa7312581b7d3 = getdvarfloat( @"hash_28f1deee87da92e0", 0.7 );
    var_16ae1125a6a7d307 = getdvarfloat( @"hash_7f761b3717abb188", 0.6 );
    var_bcf3b1b24a202f81 = getdvarfloat( @"hash_fbe3c722010eca1a", 0.55 );
    var_9a4640a410338ccc = getdvarfloat( @"hash_baa101c6695bfdff", 1 );
    var_db3bf1b6cee753a3 = getdvarfloat( @"hash_f21605093fe7c8a4", 0.8 );
    var_40dcccd28b9da5b3 = getdvarfloat( @"hash_ed19f1bde60798d4", 0.25 );
    var_77ef519a48ec9faf = getdvarfloat( @"hash_79997ff75f68c408", 1 );
    var_5224d35948c59281 = getdvarfloat( @"hash_f8c2105062c22846", 0.15 );
    var_f53f8a2bd0180b20 = getdvarfloat( @"hash_90b355042312722f", 0.8 );
    var_c33aa7ef17cfe845 = getdvarfloat( @"hash_e0699ce4447b8fde", 0.8 );
    var_4c06ef375c13ea1e = getdvarfloat( @"hash_3643712c98858195", 1 );
    var_b32d5c9566b620f9 = getdvarfloat( @"hash_b67ab9a775809176", 1 );
    var_a78294aeffce90c4 = getdvarfloat( @"hash_50ba1dc4a4d01cb", 1 );
    var_59faf3eff2f9ce2c = getdvarfloat( @"hash_6b564b4225293d13", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_226d0d9e4a594b4f", 0.2 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_5a99a2956ced6e60", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_2d0b7bcb1a3caa96", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_a81be1c1cfa08bc8", 0.6 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_b937c7d57c29e010", 0.125 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_dff1e8597fdb11cb", 0.1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_2196b3c79249863c", 0.4 );
    var_74e212ac00fe353 = getdvarfloat( @"hash_2f06b65a89b98c8c", 1 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_49d54c002fd21666", 0.8 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_41ea915739fcc78b", 0.7 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_fd740efbfeac732d", 0.32 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_9e836d2e88b7e645", 0.25 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_fb43cc6aef14ae55", 0.2 );
    var_7156e77b2b8e5cd4 = getdvarfloat( @"hash_56f303c0b0a0077f", 0.4 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_9c2cd0184db27268", 0.4 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_66f5d89b899a7dd1", 0.4 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_29498f375121f02a", 0.1 );
    var_54d187cadce293b3 = getdvarfloat( @"hash_16a39f7c5a9b2c44", 0.1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_b3c9aae58d7d14f0", 0.3 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_49da04650f6c749d", 0.7 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_8330c154a9684509", 0.3 );
    damage = params.idamage;
    params.var_d3006097a8584457 = 1;
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    var_2428aee138922248 = arraycontains( [ "sniper" ], params.sweapon.classname );
    
    if ( weakspotdata )
    {
        damage *= var_bbb7a6d50d6904d1;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( paplevel >= 4 )
        {
            damage *= var_66f4771e76a64f91;
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= var_c5e0225cba147a92;
        }
    }
    
    if ( is_wonder )
    {
        damage *= var_d572e4d281047f87;
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
            
            if ( weakspotdata )
            {
                damage *= var_ed407dcb475395c;
            }
        }
        
        is_firefly_ww = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "sat_ww_firefly" );
        
        if ( is_firefly_ww )
        {
            damage *= var_e6b3918506ea5e30;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
        var_97497870082defe6 = issubstr( params.sweapon.basename, "lm_hades" );
        
        if ( var_97497870082defe6 )
        {
            damage *= var_e8ac91a5ef2b0fd1;
        }
        
        var_a95df4abd89a0a73 = issubstr( params.sweapon.basename, "lm_typhon" );
        
        if ( var_a95df4abd89a0a73 )
        {
            damage *= var_f835858b1b1cbcca;
        }
        
        var_928626a121064218 = issubstr( params.sweapon.basename, "lm_zeus" );
        
        if ( var_928626a121064218 )
        {
            damage *= var_18e2266ff0e121f5;
        }
        
        var_a9a126b53752ab54 = issubstr( params.sweapon.basename, "lm_hildr" );
        
        if ( var_a9a126b53752ab54 )
        {
            damage *= var_ca16f864fec9a903;
        }
    }
    else if ( arraycontains( [ "pistol" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
        isakita = issubstr( params.sweapon.basename, "akita" );
        isvulture = issubstr( params.sweapon.basename, "vulture" );
        iscorso = issubstr( params.sweapon.basename, "sh_corso" );
        isshepherd = issubstr( params.sweapon.basename, "sh_shepherd" );
        isterrier = issubstr( params.sweapon.basename, "sh_terrier" );
        
        if ( isvulture )
        {
            damage *= var_5224d35948c59281;
        }
        else if ( isakita )
        {
            damage *= var_20ad41a7190f3038;
        }
        else if ( iscorso )
        {
            damage *= var_44534fdcf7bf3e3e;
        }
        else if ( isshepherd )
        {
            damage *= var_908e47d7962b0ec7;
        }
        else if ( isterrier )
        {
            damage *= var_c33aa7ef17cfe845;
        }
        
        var_60aa7bde8e31bcd0 = issubstr( params.sweapon.attachments, "akimbo_pi" );
        
        if ( var_60aa7bde8e31bcd0 )
        {
            damage *= var_4f79672e8ec957ce;
        }
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) && !is_wonder )
    {
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
        else
        {
            damage *= var_5ed48d2a95f6cd41;
        }
        
        var_b564b55a357ad0a = issubstr( params.sweapon.basename, "ar_albatross" );
        
        if ( var_b564b55a357ad0a )
        {
            damage *= var_83d37edf201b2cfd;
        }
        
        var_e21b89a1a48eda24 = issubstr( params.sweapon.basename, "ar_egret" );
        
        if ( var_e21b89a1a48eda24 )
        {
            damage *= var_95511d95a93958e7;
        }
        
        var_9b71ed22ad8b7a11 = issubstr( params.sweapon.basename, "ar_finch" );
        
        if ( var_9b71ed22ad8b7a11 )
        {
            damage *= var_e5ee15bc1309375a;
        }
        
        var_2a51c3aa6c24cbdd = issubstr( params.sweapon.basename, "ar_heron" );
        
        if ( var_2a51c3aa6c24cbdd )
        {
            damage *= var_66b304267f9502e;
            
            if ( weakspotdata )
            {
                damage *= var_741aaacb780e3fcb;
            }
        }
        
        var_d2f5e7854e17e59c = issubstr( params.sweapon.basename, "ar_macaw" );
        
        if ( var_d2f5e7854e17e59c )
        {
            damage *= var_d425946c0ecce92b;
        }
        
        var_c6591c705a2d6871 = issubstr( params.sweapon.basename, "ar_kiwi" );
        
        if ( var_c6591c705a2d6871 )
        {
            damage *= var_7de7ff1e14998598;
        }
        
        var_bcac5e82fe0848e = issubstr( params.sweapon.basename, "ar_emu" );
        
        if ( var_bcac5e82fe0848e )
        {
            damage *= var_b32d5c9566b620f9;
        }
        
        var_22804e07a2a1c56c = issubstr( params.sweapon.basename, "dm_kara" );
        
        if ( var_22804e07a2a1c56c )
        {
            damage *= var_fa6ae129f40e640d;
            
            if ( weakspotdata )
            {
                damage *= var_3a0dd038443396ba;
            }
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
        var_8a43871038dc6168 = issubstr( params.sweapon.basename, "sn_drake" );
        var_69693f78dd52645d = issubstr( params.sweapon.basename, "sn_aden" );
        var_53b88c53bcb5a948 = issubstr( params.sweapon.basename, "sn_caspian" );
        var_f8ce92563efe07d0 = issubstr( params.sweapon.basename, "sn_coral" );
        
        if ( var_8a43871038dc6168 )
        {
            damage *= var_4b7fa7312581b7d3;
        }
        else if ( var_69693f78dd52645d )
        {
            damage *= var_9a4640a410338ccc;
        }
        else if ( var_53b88c53bcb5a948 )
        {
            damage *= var_db3bf1b6cee753a3;
        }
        else if ( var_f8ce92563efe07d0 )
        {
            damage *= var_77ef519a48ec9faf;
        }
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
        
        var_8ac364248fe9da03 = issubstr( params.sweapon.basename, "sm_orca" );
        var_2c4d0ef07c7b125f = issubstr( params.sweapon.basename, "sm_cobra" );
        var_6be2efa37f2d3915 = issubstr( params.sweapon.basename, "sm_hyena" );
        var_4ed004c75b6bb987 = issubstr( params.sweapon.basename, "sm_stoat" );
        var_6f864e32448705a1 = issubstr( params.sweapon.basename, "sm_komodo" );
        var_a460b22a1a51592f = issubstr( params.sweapon.basename, "sm_mammoth" );
        var_99614ccf137caca2 = issubstr( params.sweapon.basename, "sm_marmot" );
        var_781e96facb01fe60 = issubstr( params.sweapon.basename, "sm_otter" );
        var_892ec3c5e970e683 = issubstr( params.sweapon.basename, "sm_puma" );
        var_39f282945ecff933 = issubstr( params.sweapon.basename, "sm_serval" );
        var_958786a6a63535e0 = issubstr( params.sweapon.basename, "sm_zebraexotic" );
        var_22b6f1891552563e = issubstr( params.sweapon.basename, "sm_zebra" ) && !var_958786a6a63535e0;
        var_ea535479834326a5 = issubstr( params.sweapon.basename, "sm_civet" );
        var_bef4a086c89f2d8d = issubstr( params.sweapon.basename, "sm_bengal" );
        var_85cc380f1fded69d = issubstr( params.sweapon.basename, "sm_gecko" );
        var_28bdf7213142e18c = issubstr( params.sweapon.basename, "sm_bear" );
        
        if ( var_8ac364248fe9da03 )
        {
            damage *= var_64021406c1e284a4;
        }
        else if ( var_2c4d0ef07c7b125f )
        {
            damage *= var_5ad4058fe42539a;
        }
        else if ( var_6be2efa37f2d3915 )
        {
            damage *= var_41d6ed60e93466cc;
        }
        else if ( var_4ed004c75b6bb987 )
        {
            damage *= var_4902ecca444e0a0a;
        }
        else if ( var_6f864e32448705a1 )
        {
            damage *= var_954e3c92eeaffe8a;
        }
        else if ( var_a460b22a1a51592f )
        {
            damage *= var_1db18fb14b819f46;
        }
        else if ( var_99614ccf137caca2 )
        {
            damage *= var_bbeff31a90e06ee5;
        }
        else if ( var_781e96facb01fe60 )
        {
            damage *= var_a3ca9f131d6300f9;
        }
        else if ( var_892ec3c5e970e683 )
        {
            damage *= var_8519d2664696609c;
        }
        else if ( var_39f282945ecff933 )
        {
            damage *= var_b3b83a5ab245b7ec;
        }
        else if ( var_958786a6a63535e0 )
        {
            damage *= var_f5cdb22b4777022d;
        }
        else if ( var_22b6f1891552563e )
        {
            damage *= var_171f46ae7095831b;
        }
        else if ( var_ea535479834326a5 )
        {
            damage *= var_a78294aeffce90c4;
        }
        else if ( var_bef4a086c89f2d8d )
        {
            damage *= var_dcb0e656c9c82522;
        }
        else if ( var_85cc380f1fded69d )
        {
            damage *= var_822e9de3dfba30c0;
        }
        else if ( var_28bdf7213142e18c )
        {
            damage *= var_d60770d185f48ebf;
        }
    }
    else if ( arraycontains( [ "dm" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_31ff27f24504c5c6;
        istasman = issubstr( params.sweapon.basename, "tasman" );
        
        if ( istasman )
        {
            damage *= var_f53f8a2bd0180b20;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        iscrossbow = issubstr( params.sweapon.basename, "sl_crossbow" );
        var_ba45de6833daade9 = issubstr( params.sweapon.basename, "ks_compound" );
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( iscrossbow )
        {
            damage *= var_d48cf9ae0101f824;
        }
        else if ( var_ba45de6833daade9 )
        {
            damage *= var_2735afaab8d7322e;
            
            if ( weakspotdata )
            {
                damage *= var_30e23d6f68aeab2f;
            }
        }
        else if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
        else if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        else if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        else
        {
            damage *= var_4a0cd941a5b615d1;
        }
        
        ispolis = issubstr( params.sweapon.basename, "polis" );
        
        if ( ispolis )
        {
            damage *= var_cef89d00885df997;
        }
        
        isfang = issubstr( params.sweapon.basename, "la_fang" );
        
        if ( isfang )
        {
            damage *= var_4c06ef375c13ea1e;
        }
        
        isatria = issubstr( params.sweapon.basename, "sl_atria" );
        
        if ( isatria )
        {
            damage *= var_cbe1b29ad713515f;
        }
        
        iscarina = issubstr( params.sweapon.basename, "sl_carina" );
        
        if ( iscarina )
        {
            damage *= var_59faf3eff2f9ce2c;
        }
        
        issargas = issubstr( params.sweapon.basename, "sl_sargas" );
        
        if ( issargas )
        {
            damage *= var_27290881d032efef;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        var_d9e7bcfde8e48be5 = issubstr( params.sweapon.basename, "ground_drone_unit" );
        
        if ( var_d9e7bcfde8e48be5 )
        {
            damage *= var_7156e77b2b8e5cd4;
        }
        else
        {
            damage *= var_2067935b2ea13ba;
        }
        
        isnembus = issubstr( params.sweapon.basename, "sl_nembus" );
        
        if ( isnembus )
        {
            damage *= var_11ffd83c4978f00a;
        }
        
        if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
        {
            damage *= var_3b1f952caa88011e;
        }
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_d79bd6287ec31835", var_74e212ac00fe353 );
        }
    }
    else if ( arraycontains( [ "throwingknife" ], params.sweapon.classname ) )
    {
        damage *= 0.1;
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_ec2bba193fda4b60", 0.35 );
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_underbarrel_shotgun_sn_caspian" ) )
    {
        damage *= var_40dcccd28b9da5b3;
    }
    
    if ( issubstr( params.sweapon.basename, "oman" ) )
    {
        damage *= var_87adbecba0c9b50b;
    }
    
    if ( issubstr( params.sweapon.basename, "sn_baltic" ) )
    {
        damage *= var_16ae1125a6a7d307;
        
        if ( arraycontains( params.sweapon.attachments, "sat_ub_crossbar_sn_baltic" ) )
        {
            damage *= var_bcf3b1b24a202f81;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_atlas" ) )
    {
        damage *= var_e53b66a0bc564ac7;
    }
    
    if ( issubstr( params.sweapon.basename, "pi_alcor" ) )
    {
        damage *= var_1ee624ee6ce0fe17;
        
        if ( weakspotdata )
        {
            damage *= var_9a63c8107d8fe6bc;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_orion" ) )
    {
        damage *= var_f68435a7c71028a9;
        
        if ( weakspotdata )
        {
            damage *= var_db0d136f8ce8451e;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    
    if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    
    if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "frost_blast" ) )
    {
        damage *= var_54d187cadce293b3;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_bbb2abe1a3014b6d", var_b614da05a3be6674 );
    }
    
    if ( params.smeansofdeath == "MOD_BLEEDOUT" )
    {
        damage *= 0.1;
    }
    
    if ( self.shadow_soul_shield_active )
    {
        params.var_4f9d5587bf9a2b1e = 1;
        var_1d4d1f382e7d2c0c = utility::getfx( "shadow_soul_shield_impact_immune" );
        
        if ( isdefined( var_1d4d1f382e7d2c0c ) && isdefined( params.vpoint ) )
        {
            playfx( var_1d4d1f382e7d2c0c, params.vpoint );
        }
    }
    
    damage *= zombie_weyward_shadow_soul::get_shadow_soul_damage_reduction();
    solo_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( self.subclass, zombie_utils::get_zombie_round_difficulty(), 1 );
    var_f27162ef1912d024 = 0.075 * solo_max_health / self.maxhealth;
    params.var_ff33243f5be1fe3b = min( params.var_ff33243f5be1fe3b, var_f27162ef1912d024 );
    
    if ( getdvarint( @"hash_308871e6be295b74", 0 ) )
    {
        damage *= 25;
    }
    
    zombie_weyward_shadow_soul::function_f4eba3e3630cd623( damage );
    damage = zombie_weyward_shadow_soul::function_2d0e28a49756190e( damage );
    damage = function_bd924e62aafac328( params, damage );
    
    if ( weakspotdata && params.biscritical )
    {
        damage = min( damage, var_3f2e80330371bcc1 );
    }
    
    if ( !weakspotdata && !armordata && !var_2428aee138922248 && !is_wonder )
    {
        damage = min( damage, var_52eec01ca61dbf15 );
    }
    
    return int( damage );
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x6e360411, Offset: 0x3c75
// Size: 0xc6
function private function_7927969b837352d3()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_77da056a39d77283", weyward_bone_name, ava_bone_name );
        
        if ( !isdefined( weyward_bone_name ) )
        {
            weyward_bone_name = "j_wrist_le";
        }
        
        if ( !isdefined( ava_bone_name ) )
        {
            ava_bone_name = "j_mainroot";
        }
        
        var_79382bc24c4e774c = utility::getfx( self.fake_death_triggered ? "fake_death_beam_fx" : "immune_drain_beam_fx" );
        beam_ent = playfxontagsbetweenclients( var_79382bc24c4e774c, self, weyward_bone_name, self.s_ava_caged.mdl_ava_caged, ava_bone_name );
        thread utility::delete_on_death( beam_ent );
        utility::waittill_any_timeout( 30, "drain_beam_effect_end" );
        
        if ( isdefined( beam_ent ) )
        {
            beam_ent delete();
        }
    }
}

// Namespace zombie_weyward
// Params 2, eflags: 0x4
// Checksum 0x7aab8702, Offset: 0x3d43
// Size: 0x3c
function private cleanup_beam_effect( beam_begin, beam_end )
{
    self waittill( #"death" );
    
    if ( isdefined( beam_begin ) )
    {
        beam_begin delete();
    }
    
    if ( isdefined( beam_end ) )
    {
        beam_end delete();
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x92b8194e, Offset: 0x3d87
// Size: 0x2b
function private play_death_fx( params )
{
    if ( isdefined( params.body ) )
    {
        params.body delete();
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xc2c659e6, Offset: 0x3dba
// Size: 0x131
function private real_death_anim_end( params )
{
    var_6a8b269c4d56f7fb = 22;
    utility::waittill_notify_or_timeout( "death_end", var_6a8b269c4d56f7fb );
    
    foreach ( shadowsmith in self.shadowsmiths )
    {
        if ( isdefined( shadowsmith ) )
        {
            if ( isdefined( shadowsmith.e_beam ) )
            {
                shadowsmith.e_beam delete();
            }
            
            shadowsmith delete();
        }
    }
    
    level.var_8eb019fd327a4643 = 1;
    val::reset_all( "weyward_init" );
    self kill( self.origin, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
    level.var_8eb019fd327a4643 = undefined;
    utility::delaythread( 10, &utility::flag_set, "weyward_real_death_sequence_end" );
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x592bfe2d, Offset: 0x3ef3
// Size: 0x10e
function private function_34d561a2c1f044a8()
{
    if ( !level.var_643e99d5a18faa82 )
    {
        return;
    }
    
    monkeybombs = arraycopy( level.var_643e99d5a18faa82 );
    level.var_643e99d5a18faa82 = [];
    
    foreach ( var_74d01f1a0e2d4d5f in monkeybombs )
    {
        if ( !var_74d01f1a0e2d4d5f )
        {
            continue;
        }
        
        if ( var_74d01f1a0e2d4d5f.attractor )
        {
            zombie_attractor_manager::remove_attractor( var_74d01f1a0e2d4d5f.attractor );
        }
        
        grenade = var_74d01f1a0e2d4d5f.grenade;
        
        if ( grenade )
        {
            if ( grenade.damagearea )
            {
                grenade.damagearea delete();
            }
        }
        
        var_74d01f1a0e2d4d5f delete();
        
        if ( grenade )
        {
            grenade delete();
        }
    }
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x33841da4, Offset: 0x4009
// Size: 0xba
function private function_cf471a813b09b58c()
{
    if ( !self.var_425766479c15a2a0 )
    {
        return;
    }
    
    gdus = arraycopy( self.var_425766479c15a2a0 );
    
    foreach ( gdu in gdus )
    {
        if ( gdu )
        {
            gdu utility::callsharedfunc( #"ground_drone_unit", #"teardown" );
        }
    }
    
    self.var_425766479c15a2a0 = [];
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x7dce62b2, Offset: 0x40cb
// Size: 0xc9
function private function_8d85feddb6ab63f4()
{
    if ( !self.placedsentries )
    {
        return;
    }
    
    var_8803ffdb26e00e9b = self.placedsentries[ "radiation_blast" ];
    
    if ( !var_8803ffdb26e00e9b )
    {
        return;
    }
    
    var_8803ffdb26e00e9b = function_5713d46873b29625( var_8803ffdb26e00e9b );
    
    foreach ( ioncore in var_8803ffdb26e00e9b )
    {
        if ( ioncore )
        {
            ioncore notify( #"kill_turret", 1, 0, 1 );
        }
    }
    
    self.placedsentries[ "radiation_blast" ] = [];
}

// Namespace zombie_weyward
// Params 2, eflags: 0x4
// Checksum 0x7c63f03c, Offset: 0x419c
// Size: 0xab
function private function_bd924e62aafac328( params, damage )
{
    min_health_threshold = 1000;
    
    if ( self.health - damage <= min_health_threshold )
    {
        if ( !self.fake_death_triggered )
        {
            self.fake_death_triggered = 1;
            self notify( #"begin_fake_death" );
            thread begin_fake_death();
        }
        else if ( !self.real_death_triggered )
        {
            self.real_death_triggered = 1;
            self notify( #"begin_real_death" );
            thread begin_real_death( params );
        }
        
        params.var_d20799805edf0194 = istrue( self.real_death_triggered );
        return 0;
    }
    
    return damage;
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x9de2e183, Offset: 0x4250
// Size: 0x119
function private function_842c893863451773()
{
    var_47b6008d65dc98c0 = 200;
    var_31afa733ed50dcd9 = 300;
    var_9deb743e05a70121 = 30;
    a_players = getplayersinradius( self.origin, var_47b6008d65dc98c0 );
    
    foreach ( player in a_players )
    {
        if ( !isalive( player ) || player.inlaststand )
        {
            continue;
        }
        
        var_c51215b779b5fe59 = vectornormalize2( player.origin - self.origin );
        to_player_perp = anglestoright( vectortoangles( var_c51215b779b5fe59 ) );
        knockback_dir = rotatepointaroundvector( to_player_perp, var_c51215b779b5fe59, var_9deb743e05a70121 );
        player knockback( knockback_dir, var_31afa733ed50dcd9, 1 );
    }
}

// Namespace zombie_weyward
// Params 2
// Checksum 0xf60b66d6, Offset: 0x4371
// Size: 0xcc
function function_b19cb2bcc6d43a1( var_106f19ddaccc47d7, var_e523d75737023d39 )
{
    self function_786bb6aa1b76c7ee( "in_intro_sequence", 0 );
    self function_786bb6aa1b76c7ee( "in_full_pain", 0 );
    self function_786bb6aa1b76c7ee( "in_move_turn", 0 );
    self function_786bb6aa1b76c7ee( "charge_into_dash_combo", 0 );
    
    if ( !var_e523d75737023d39 )
    {
        self function_786bb6aa1b76c7ee( "in_game_over_scene", 0 );
    }
    
    if ( !var_106f19ddaccc47d7 )
    {
        self function_786bb6aa1b76c7ee( "in_real_death", 0 );
    }
    
    zombie_weyward_dash::cancel_dash();
    zombie_weyward_melee::cancel_melee();
    zombie_weyward_charge::cancel_charge();
    self notify( #"hash_730c53e28810a592" );
    self notify( #"charge_turn_orient_end" );
    self notify( #"charge_turn_orient_internal_stop" );
    self notify( #"hash_836efc1107f5d88c" );
    zombie_weyward_bomb_attack::cancel_bomb_attack();
    zombie_weyward_summon_stinger::cancel_summon_stingers();
    
    if ( zombie_stun::is_stunned() )
    {
        zombie_stun::function_d738299157923d28();
    }
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x78c9f3f0, Offset: 0x4445
// Size: 0x473
function private begin_fake_death()
{
    self endon( #"death" );
    death_yaw = self.angles[ 1 ];
    self function_786bb6aa1b76c7ee( "in_fake_death", 1 );
    val::set( "fake_death", "damage", 0 );
    val::set( "fake_death", "special_pain", 0 );
    zombie_boss_healthbar::function_57cec007b96540a4();
    self.skull_enabled = 0;
    self function_786bb6aa1b76c7ee( "shadow_soul_immune", 1 );
    function_b19cb2bcc6d43a1();
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x45>" );
        }
    #/
    
    asm::asm_setstate( "neutral_passthrough" );
    waitframe();
    
    foreach ( player in level.players )
    {
        player.var_7197c4b3db0665fe = 1;
        
        if ( player.dawglist )
        {
            foreach ( dawg in player.dawglist )
            {
                if ( dawg.turret )
                {
                    dawg.turret.var_b508c7d8b689b9bf = 1;
                }
            }
        }
    }
    
    thread function_adc3801ac01e64fb();
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            thread function_e9f572c2adcb0d78( "<dev string:x59>", 1 );
        }
    #/
    
    thread function_59a1642a946314fc( death_yaw );
    zombie_weyward_metabones::function_82487bddb09162ca();
    zombie_weyward_metabones::function_d59c74543d02814f( 0 );
    utility::function_7c10ea82c1e305b8( "fake_death", "on" );
    function_842c893863451773();
    self.stingers_empowered = 1;
    utility::waittill_notify_or_timeout( "fake_death_loop", 5 );
    state_name = asm::asm_getcurrentstatename( self.asmname );
    
    if ( state_name != "fake_death_intro" && state_name != "fake_death_loop" )
    {
        /#
            if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
            {
                zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x64>" );
            }
        #/
        
        asm::asm_setstate( "fake_death" );
    }
    
    wait self.fake_death_duration;
    self function_f2df0257c63f229( "in_fake_death" );
    utility::waittill_notify_or_timeout( "fake_death_restore", 5 );
    thread zombie_weyward_skull::function_99d24b01ae59404f( 1 );
    zombie_weyward_metabones::function_d59c74543d02814f( 1 );
    utility::waittill_notify_or_timeout( "fake_death_end", 5 );
    self function_f2df0257c63f229( "shadow_soul_immune" );
    restore_health_pct = self.fake_death_restore_health_pct ?? 0.333333;
    self.health = int( self.maxhealth * restore_health_pct );
    self.skull_enabled = 1;
    self.var_864f7da030e1538 = 1;
    val::reset_all( "fake_death" );
    zombie_boss_healthbar::init_zombie_boss_healthbar();
    utility::function_7c10ea82c1e305b8( "fake_death", "off" );
    
    foreach ( player in level.players )
    {
        player.var_7197c4b3db0665fe = undefined;
        
        if ( player.dawglist )
        {
            foreach ( dawg in player.dawglist )
            {
                if ( dawg.turret )
                {
                    dawg.turret.var_b508c7d8b689b9bf = undefined;
                }
            }
        }
    }
    
    callback::callback( "weyward_restore_from_fake_death" );
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x93c03722, Offset: 0x48c0
// Size: 0xb4
function private function_adc3801ac01e64fb()
{
    self endon( #"death" );
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x6f>", "<dev string:x64>" );
        }
    #/
    
    asm::asm_setstate( "fake_death" );
    
    while ( self getaiblackboarddynamic( "in_fake_death" ) )
    {
        waitframe();
        state_name = asm::asm_getcurrentstatename( self.asmname );
        
        if ( state_name == "fake_death_intro" || state_name == "fake_death_loop" )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
            {
                zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x6f>", "<dev string:x64>" );
            }
        #/
        
        asm::asm_setstate( "fake_death" );
    }
}

/#

    // Namespace zombie_weyward
    // Params 2, eflags: 0x4
    // Checksum 0x8da88b88, Offset: 0x497c
    // Size: 0x186, Type: dev
    function private function_e9f572c2adcb0d78( log_context, is_fake_death )
    {
        self endon( #"death" );
        
        if ( is_fake_death )
        {
            self endon( #"fake_death_end" );
        }
        else
        {
            self endon( #"bmeleeended" );
        }
        
        previous_state_name = asm::asm_getcurrentstatename( self.asmname );
        var_8edf647424dfbfb1 = function_22e659eaa75bd61e();
        frame_number = 0;
        
        while ( true )
        {
            waitframe();
            frame_number++;
            logstring( "<dev string:x9b>" + log_context + "<dev string:xb3>" + frame_number );
            state_name = asm::asm_getcurrentstatename( self.asmname );
            bt_status = function_22e659eaa75bd61e();
            request_source = self.var_1255ebc938b150f7;
            request_target = self.var_89d59e0ee13dba2b;
            
            if ( state_name != previous_state_name )
            {
                logstring( "<dev string:x9b>" + log_context + "<dev string:xb3>" + frame_number + "<dev string:xbc>" + previous_state_name + "<dev string:xca>" + state_name + "<dev string:xcf>" + function_f09300bedc6f3349( previous_state_name, state_name, request_source, request_target, is_fake_death ) );
                previous_state_name = state_name;
            }
            
            if ( function_4390ab4528865786( request_target, state_name, is_fake_death ) )
            {
                self.var_1255ebc938b150f7 = undefined;
                self.var_89d59e0ee13dba2b = undefined;
            }
            
            if ( bt_status != var_8edf647424dfbfb1 )
            {
                logstring( "<dev string:x9b>" + log_context + "<dev string:xb3>" + frame_number + "<dev string:xd2>" + var_8edf647424dfbfb1 + "<dev string:xca>" + bt_status );
                var_8edf647424dfbfb1 = bt_status;
            }
        }
    }

    // Namespace zombie_weyward
    // Params 0, eflags: 0x4
    // Checksum 0x542afdb1, Offset: 0x4b0a
    // Size: 0x24a, Type: dev
    function private function_22e659eaa75bd61e()
    {
        state_name = asm::asm_getcurrentstatename( self.asmname );
        debug_status = "<dev string:xdf>" + self getaiblackboarddynamic( "<dev string:xf4>" );
        debug_status += "<dev string:x108>" + self getaiblackboarddynamic( "<dev string:x123>" );
        debug_status += "<dev string:x13b>" + self getaiblackboarddynamic( "<dev string:x155>" );
        
        if ( self getaiblackboarddynamic( "<dev string:x16c>" ) )
        {
            debug_status += "<dev string:x17e>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:x192>" ) )
        {
            debug_status += "<dev string:x1a5>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:x1ba>" ) )
        {
            debug_status += "<dev string:x1c8>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:x1d8>" ) )
        {
            debug_status += "<dev string:x1eb>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:x20b>" ) )
        {
            debug_status += "<dev string:x215>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:x221>" ) )
        {
            debug_status += "<dev string:x22e>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:x23d>" ) )
        {
            debug_status += "<dev string:x24a>";
        }
        
        if ( zombie_stun::is_stunned() )
        {
            debug_status += "<dev string:x259>";
        }
        
        if ( state_name == "<dev string:x272>" )
        {
            debug_status += "<dev string:x27f>";
        }
        
        if ( utility::ent_flag( "<dev string:x290>" ) || self.var_7cbde7b93399a096 || namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
        {
            debug_status += "<dev string:x298>";
        }
        
        if ( utility::ent_flag( "<dev string:x2c7>" ) )
        {
            if ( self.var_a2638d3c0a211262 )
            {
                debug_status += "<dev string:x2d1>";
            }
            else
            {
                debug_status += "<dev string:x2fc>";
            }
        }
        
        if ( namespace_f8b8d50b63bcec41::function_36394163e6e2ab8d() )
        {
            debug_status += "<dev string:x317>";
        }
        
        if ( namespace_77f0670c8a2e733c::function_37f4de727b08b964() )
        {
            debug_status += "<dev string:x33a>";
        }
        
        if ( utility::ent_flag( "<dev string:x359>" ) )
        {
            debug_status += "<dev string:x362>";
        }
        
        if ( namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
        {
            debug_status += "<dev string:x37c>";
        }
        
        if ( self.var_dbc00b9502a3c1b0.size || self.var_1b1b971af5d4da6f.size || self.var_8a9deea3bbabb237.size )
        {
            debug_status += "<dev string:x3a2>";
        }
        
        if ( self getaiblackboarddynamic( "<dev string:xf4>" ) && !self getaiblackboarddynamic( "<dev string:x123>" ) && !utility::ent_flag( "<dev string:x2c7>" ) )
        {
            debug_status += "<dev string:x3e9>";
        }
        
        return debug_status;
    }

    // Namespace zombie_weyward
    // Params 5, eflags: 0x4
    // Checksum 0x378c2ac2, Offset: 0x4d5c
    // Size: 0xef, Type: dev
    function private function_f09300bedc6f3349( previous_state_name, state_name, request_source, request_target, is_fake_death )
    {
        if ( request_source && function_4390ab4528865786( request_target, state_name, is_fake_death ) )
        {
            return ( "<dev string:x402>" + request_source + "<dev string:xca>" + request_target );
        }
        
        if ( !is_fake_death )
        {
            return "<dev string:x413>";
        }
        
        if ( previous_state_name == "<dev string:x43a>" && state_name == "<dev string:x44b>" )
        {
            return "<dev string:x45b>";
        }
        
        if ( previous_state_name == "<dev string:x44b>" && state_name == "<dev string:x469>" )
        {
            return "<dev string:x47a>";
        }
        
        if ( previous_state_name == "<dev string:x469>" && state_name == "<dev string:x49b>" )
        {
            return "<dev string:x45b>";
        }
        
        if ( previous_state_name == "<dev string:x49b>" && state_name == "<dev string:x45>" )
        {
            return "<dev string:x4aa>";
        }
        
        if ( state_name == "<dev string:x43a>" )
        {
            return "<dev string:x4c4>";
        }
        
        return "<dev string:x413>";
    }

    // Namespace zombie_weyward
    // Params 3, eflags: 0x4
    // Checksum 0x27e69053, Offset: 0x4e53
    // Size: 0x44, Type: dev
    function private function_4390ab4528865786( request_target, state_name, is_fake_death )
    {
        return request_target == state_name || is_fake_death && request_target == "<dev string:x64>" && state_name == "<dev string:x43a>";
    }

#/

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x567c0a9c, Offset: 0x4e9f
// Size: 0x3a
function private function_59a1642a946314fc( death_yaw )
{
    self endon( #"death" );
    self endon( #"fake_death_end" );
    
    while ( true )
    {
        self orientmode( "face angle", death_yaw );
        waitframe();
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xb2617bb8, Offset: 0x4ee1
// Size: 0x31d
function private begin_real_death( params )
{
    self endon( #"death" );
    death_yaw = self.angles[ 1 ];
    var_f0de97382386790f = 4;
    self function_786bb6aa1b76c7ee( "in_real_death", 1 );
    val::set( "real_death", "damage", 0 );
    val::set( "real_death", "special_pain", 0 );
    zombie_boss_healthbar::function_57cec007b96540a4();
    self.skull_enabled = 0;
    function_b19cb2bcc6d43a1( 1 );
    asm::asm_setstate( "neutral_passthrough" );
    waitframe();
    level notify( #"hash_10fa63cc8152d54f" );
    function_34d561a2c1f044a8();
    
    foreach ( player in level.players )
    {
        player function_2d15de9b85618782( 1 );
        player notify( #"killstreak_cancel" );
        player notify( #"cancel_all_killstreak_deployments" );
        player callback::callback( #"killstreak_cancel" );
        
        if ( player.dawglist )
        {
            dawglist = arraycopy( player.dawglist );
            
            foreach ( dawg in dawglist )
            {
                if ( dawg )
                {
                    dawg dawg::dawg_self_destruct();
                }
            }
        }
        
        player function_cf471a813b09b58c();
        player function_8d85feddb6ab63f4();
    }
    
    thread function_9b0370ca335ffc2e();
    thread function_59a1642a946314fc( death_yaw );
    zombie_weyward_metabones::function_d59c74543d02814f( 0 );
    callback::callback( "weyward_real_death_start", params );
    
    if ( !self.var_c2a0567bd21bb86b )
    {
        positions = function_de3efb15a5315cd0();
        thread real_death_anim_end( params );
        
        for ( var_155a24d364f43d78 = 0; var_155a24d364f43d78 < var_f0de97382386790f ; var_155a24d364f43d78++ )
        {
            self waittill( #"shadowsmith_spawn", var_45fce3d9854d3283 );
            var_45fce3d9854d3283 = int( var_45fce3d9854d3283 );
            shadowsmith = spawn_shadowsmith( positions[ var_45fce3d9854d3283 - 1 ], var_45fce3d9854d3283 );
            shadowsmith thread spawn_beam( self );
        }
    }
    
    utility::waittill_notify_or_timeout( "fade_out_begin", 16 );
    
    foreach ( player in level.players )
    {
        player thread function_4e8b3cdd86f68b5c( self );
    }
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0xeda899dc, Offset: 0x5206
// Size: 0x70
function private function_9b0370ca335ffc2e()
{
    self endon( #"death" );
    state_to_use = self getaiblackboarddynamic( "is_in_br" ) == 1 ? "real_death_br" : "real_death";
    asm::asm_setstate( state_to_use );
    
    while ( self getaiblackboarddynamic( "in_real_death" ) )
    {
        waitframe();
        
        if ( asm::asm_getcurrentstatename( self.asmname ) == state_to_use )
        {
            return;
        }
        
        asm::asm_setstate( state_to_use );
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x2d395918, Offset: 0x527e
// Size: 0xe2
function private function_4e8b3cdd86f68b5c( weyward )
{
    self endon( #"disconnect" );
    var_b361aa579056cc52 = 2.3;
    var_1df14056b26e0c17 = 2.2;
    var_21feac9099a1eb7c = 1;
    var_551f36c571399f05 = 3.5;
    hud_util::fade_out( var_b361aa579056cc52, "white" );
    level utility::waittill_notify_or_timeout( "end_wayward_fade_to_white", var_1df14056b26e0c17 );
    
    if ( isalive( weyward ) && !weyward.var_c2a0567bd21bb86b )
    {
        hud_util::fade_out( getdvarfloat( @"hash_5d23ed789520181", var_21feac9099a1eb7c ), "black" );
        level utility::waittill_notify_or_timeout( "end_wayward_fade_to_black", var_551f36c571399f05 );
        utility::flag_set( "weyward_real_death_sequence_end" );
        return;
    }
    
    var_8735573210d42c52 = 1;
    thread hud_util::fade_in( var_8735573210d42c52, "white" );
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0x2ec55685, Offset: 0x5368
// Size: 0x47
function private spawn_beam( weyward )
{
    self waittill( #"spawn_beam", var_8f9691c1019abaf4 );
    self.e_beam = playfxontagsbetweenclients( utility::getfx( "real_death_beam_fx" ), weyward, "j_spine4", self, var_8f9691c1019abaf4 );
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0x6b2b13f2, Offset: 0x53b7
// Size: 0x116
function private function_de3efb15a5315cd0()
{
    var_f0de97382386790f = 4;
    var_d3f50096408aab5a = 200;
    var_23023c6d414ae475 = 300;
    var_2c075fa23c46910f = getdvarfloat( @"hash_5e36d7da2cb62a72", var_d3f50096408aab5a );
    radius = getdvarfloat( @"hash_995ec96d6dbd21e9", var_23023c6d414ae475 );
    center = self.origin + ( 0, 0, var_2c075fa23c46910f );
    angle_step = 360 / var_f0de97382386790f;
    base_angle = self.angles[ 1 ];
    positions = [];
    
    for ( i = 0; i < var_f0de97382386790f ; i++ )
    {
        angle = base_angle + angle_step * ( i + 1 ) + 45;
        x = cos( angle ) * radius;
        y = sin( angle ) * radius;
        pos = center + ( x, y, 0 );
        positions[ positions.size ] = pos;
    }
    
    return positions;
}

// Namespace zombie_weyward
// Params 2
// Checksum 0x95c1f203, Offset: 0x54d6
// Size: 0x1f2
function spawn_shadowsmith( target_pos, var_45fce3d9854d3283 )
{
    var_54421a691ae14668 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    yaw = vectortoyaw( self.origin - target_pos );
    v_facing_angles = ( 0, yaw, 0 );
    shadowsmith = spawn( "script_model", target_pos );
    shadowsmith.angles = v_facing_angles;
    
    switch ( var_45fce3d9854d3283 )
    {
        case 1:
            shadowsmithmodel = var_54421a691ae14668.var_217450ca58d93bf7;
            shadowsmithanim = var_54421a691ae14668.var_8eb9faabce167363;
            break;
        case 2:
            shadowsmithmodel = var_54421a691ae14668.var_6b36cbeffc8937a;
            shadowsmithanim = var_54421a691ae14668.var_7500cd5698215190;
            break;
        case 3:
            shadowsmithmodel = var_54421a691ae14668.var_d17bd16d79ae8cc;
            shadowsmithanim = var_54421a691ae14668.var_72140331e4d2216;
            break;
        case 4:
            shadowsmithmodel = var_54421a691ae14668.var_c16e861211e2fb6a;
            shadowsmithanim = var_54421a691ae14668.var_ddb390c68b77d5e0;
            break;
    }
    
    shadowsmith setmodel( shadowsmithmodel );
    shadowsmith scriptmodelplayanim( shadowsmithanim.id, "shadowsmith_anim" );
    shadowsmith playsoundonmovingent( #"hash_99cf68062707ae17" );
    shadowsmith playloopsound( #"hash_839da0fffa8112f4" );
    playfxontag( utility::getfx( "real_death_shadowsmith_spawn_fx" ), shadowsmith, "tag_origin" );
    playfxontag( utility::getfx( "real_death_shadowsmith_ambient_fx" ), shadowsmith, "j_mainroot" );
    thread function_dba47d82b77924d1( shadowsmith, target_pos );
    visibility_mode::function_3afc3bc470c80e61( shadowsmith, "allies" );
    
    if ( !isdefined( self.shadowsmiths ) )
    {
        self.shadowsmiths = [];
    }
    
    self.shadowsmiths[ self.shadowsmiths.size ] = shadowsmith;
    return shadowsmith;
}

// Namespace zombie_weyward
// Params 3
// Checksum 0x178acb88, Offset: 0x56d1
// Size: 0x12d
function function_dba47d82b77924d1( shadowsmith, target_pos, fly_speed_override )
{
    self endon( #"death" );
    shadowsmith notify( #"hash_1a10772d8288db20" );
    shadowsmith endon( #"death", #"hash_1a10772d8288db20" );
    var_76854d0fe536795d = 300;
    fly_speed = fly_speed_override ?? getdvarfloat( @"hash_38caaf6b23e08a2", var_76854d0fe536795d );
    arrival_threshold = 5;
    
    while ( true )
    {
        dir = target_pos - shadowsmith.origin;
        dist = length( dir );
        
        if ( dist <= arrival_threshold )
        {
            shadowsmith.origin = target_pos;
            shadowsmith.shadow_soul_arrived = 1;
            return;
        }
        
        move_dist = fly_speed * level.framedurationseconds;
        
        if ( move_dist >= dist )
        {
            shadowsmith.origin = target_pos;
        }
        else
        {
            shadowsmith.origin += vectornormalize( dir ) * move_dist;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward
// Params 1, eflags: 0x4
// Checksum 0xadcf5d7d, Offset: 0x5806
// Size: 0xec
function private on_summoned_by_weyward( params )
{
    ent = params.ent;
    ent.var_13518fb33ec73cc = self.var_13518fb33ec73cc;
    
    if ( self.var_84edf9b8d56d401 )
    {
        ent.var_a13bed1ac47e1b2c = 1;
        ent.var_50c96a5c56dab386 = undefined;
    }
    
    if ( ent.subclass == "zombie_weyward_stinger" )
    {
        if ( self.var_328dbd9b5f06834d )
        {
            ent.elementalweakness = [];
        }
        
        ent.armor_health_damage_multiplier = self.var_cc4a45daf4c0a8d5 ?? 1;
    }
    
    if ( ent.subclass == "zombie_wither_boss_fight" )
    {
        if ( self.var_bfec04d50947b318 )
        {
            utility::function_7c10ea82c1e305b8( "empowerment_status", "level_4" );
            return;
        }
        
        utility::function_7c10ea82c1e305b8( "empowerment_status", "off" );
    }
}

// Namespace zombie_weyward
// Params 0, eflags: 0x4
// Checksum 0xbc6a2113, Offset: 0x58fa
// Size: 0x4b
function private function_c6861d04ef1fe32c()
{
    goal_pos = self getgoalpos();
    recalculate_dist = getdvarfloat( @"hash_7bfb490562cb185a", 400 );
    
    if ( isdefined( goal_pos ) && self pathdisttogoal() > recalculate_dist )
    {
        return;
    }
    
    goal_pos = function_290f8c14dbc57398( self );
    return goal_pos;
}

// Namespace zombie_weyward
// Params 2
// Checksum 0x4e292711, Offset: 0x594e
// Size: 0x325
function function_290f8c14dbc57398( ai_entity, var_cfb5dc6e8df2500f )
{
    var_cfb5dc6e8df2500f = getdvarfloat( @"hash_52e79f07a52e547f", var_cfb5dc6e8df2500f ?? 600 );
    top_x = getdvarfloat( @"hash_f4fba691777d1fe6", 5 );
    max_bounces = getdvarfloat( @"hash_419accedbc8828b", 1 );
    var_e6ef1231966449aa = ai_entity.origin;
    base_angles = ai_entity.angles;
    forward_dir = anglestoforward( base_angles );
    
    for ( b = 0; b < max_bounces ; b++ )
    {
        trace_results = [];
        
        for ( i = 0; i < 8 ; i++ )
        {
            if ( i == 3 || i == 5 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            test_yaw = base_angles[ 1 ] + i * 45;
            test_angles = ( base_angles[ 0 ], test_yaw, base_angles[ 2 ] );
            check_dir = anglestoforward( test_angles );
            check_end = var_e6ef1231966449aa + check_dir * var_cfb5dc6e8df2500f;
            nav_end = getclosestpointonnavmesh( check_end, ai_entity, 1, 1, 0, 0 );
            
            if ( !isdefined( nav_end ) || distance( nav_end, var_e6ef1231966449aa ) < 200 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            distance_val = distance( var_e6ef1231966449aa, nav_end );
            dot_val = vectordot( forward_dir, check_dir );
            
            /#
                line( var_e6ef1231966449aa, nav_end, ( 0.9, 0.1, 0 ) );
            #/
            
            trace_results[ i ] = [ nav_end, distance_val, dot_val ];
        }
        
        for ( j = 0; j < trace_results.size ; j++ )
        {
            for ( k = j + 1; k < trace_results.size ; k++ )
            {
                if ( trace_results[ k ][ 1 ] > trace_results[ j ][ 1 ] )
                {
                    temp = trace_results[ j ];
                    trace_results[ j ] = trace_results[ k ];
                    trace_results[ k ] = temp;
                }
            }
        }
        
        best_position = var_e6ef1231966449aa;
        found_valid = 0;
        max_candidates = min( top_x, trace_results.size );
        
        while ( !found_valid )
        {
            var_e3eab751eefd3bd0 = -999999;
            best_dot_index = -1;
            
            for ( m = 0; m < max_candidates ; m++ )
            {
                dot_val = trace_results[ m ][ 2 ];
                
                if ( dot_val > var_e3eab751eefd3bd0 )
                {
                    var_e3eab751eefd3bd0 = dot_val;
                    best_dot_index = m;
                }
            }
            
            if ( best_dot_index <= -1 )
            {
                break;
            }
            
            var_35b8f54c259f8b32 = trace_results[ best_dot_index ][ 0 ];
            best_position = var_35b8f54c259f8b32;
            found_valid = 1;
        }
        
        if ( !found_valid || best_position == var_e6ef1231966449aa )
        {
            break;
        }
        
        var_e6ef1231966449aa = best_position;
    }
    
    /#
        sphere( var_e6ef1231966449aa, 10, ( 0, 1, 0 ) );
    #/
    
    return var_e6ef1231966449aa;
}

/#

    // Namespace zombie_weyward
    // Params 0, eflags: 0x4
    // Checksum 0xeaf41df7, Offset: 0x5c7c
    // Size: 0x17c, Type: dev
    function private setup_zombie_weyward_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4e0>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4f9>" + "<dev string:x505>", "<dev string:x50d>" + "<dev string:x505>", &function_91034eaf1bffa901 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4f9>" + "<dev string:x521>", "<dev string:x50d>" + "<dev string:x521>", &function_91034eaf1bffa901 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4f9>" + "<dev string:x526>", "<dev string:x50d>" + "<dev string:x526>", &function_91034eaf1bffa901 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4f9>" + "<dev string:x52b>", "<dev string:x50d>" + "<dev string:x52b>", &function_91034eaf1bffa901 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x531>", "<dev string:x54a>", &function_feb974ab0e061976 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x568>", "<dev string:x582>", &function_feb974ab0e061976 );
        devgui::add_devgui_func( "<dev string:x5a0>", "<dev string:x5b6>", &function_590ad460bc2d17b8 );
        devgui::add_devgui_func( "<dev string:x5d4>", "<dev string:x5ea>", &function_4cec6bd282904ae3 );
        devgui::add_devgui_func( "<dev string:x608>", "<dev string:x614>", &function_476140e1c3d5acf );
        devgui::add_devgui_func( "<dev string:x628>", "<dev string:x634>", &function_476150e1c3d5d02 );
        devgui::add_devgui_func( "<dev string:x648>", "<dev string:x654>", &function_476160e1c3d5f35 );
        devgui::add_devgui_func( "<dev string:x668>", "<dev string:x67b>", &function_ab9b9c8d805175b );
        devgui::add_devgui_func( "<dev string:x69d>", "<dev string:x6b1>", &function_f4d5bbb8b7651a1 );
        devgui::add_devgui_func( "<dev string:x6d3>", "<dev string:x6ed>", &function_2427909304ffbcdd );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward
    // Params 2, eflags: 0x4
    // Checksum 0xd4487c90, Offset: 0x5e00
    // Size: 0x55, Type: dev
    function private function_9d8db956cabecb5d( var_bbf1019a9b87e7d2, arena_radius )
    {
        utility::draw_circle( var_bbf1019a9b87e7d2, arena_radius, ( 0, 1, 0 ), 1, 0, 1 );
        utility::draw_circle( var_bbf1019a9b87e7d2, arena_radius - 320, ( 1, 0.5, 0 ), 1, 0, 1 );
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0xc5bd014d, Offset: 0x5e5d
    // Size: 0x24, Type: dev
    function private function_ab9b9c8d805175b( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x70f>", @"hash_8553c6ae46f9fda4" );
    }

    // Namespace zombie_weyward
    // Params 0, eflags: 0x4
    // Checksum 0xb25317fa, Offset: 0x5e89
    // Size: 0x16, Type: dev
    function private function_62adaef14350a13e()
    {
        return getdvarint( @"hash_8553c6ae46f9fda4", 0 ) > 0;
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0xb30af7d6, Offset: 0x5ea7
    // Size: 0x7e, Type: dev
    function private function_f4d5bbb8b7651a1( params )
    {
        if ( getdvarint( @"hash_974533c76db4988e", 0 ) )
        {
            setdvar( @"hash_974533c76db4988e", 0 );
            return;
        }
        
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        setdvar( @"hash_974533c76db4988e", 1 );
        weyward thread function_b177b0afd0fb32cd();
    }

    // Namespace zombie_weyward
    // Params 0, eflags: 0x4
    // Checksum 0x27814eda, Offset: 0x5f2d
    // Size: 0x15e, Type: dev
    function private function_b177b0afd0fb32cd()
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( getdvarint( @"hash_974533c76db4988e", 0 ) )
        {
            if ( self.var_cb0f79c5c25b23f4 )
            {
                utility::draw_circle( self.var_cb0f79c5c25b23f4 + ( 0, 0, 200 ), sqrt( squared( 1350 ) ), ( 1, 0, 1 ), 1, 0, 1 );
            }
            
            foreach ( player in level.players )
            {
                if ( !player.var_20a8b738082b892a )
                {
                    continue;
                }
                
                held_seconds = ( gettime() - player.var_20a8b738082b892a ) * 0.001;
                print3d( player.origin + ( 0, 0, 80 ), "<dev string:x739>" + held_seconds + "<dev string:x747>" + 7, ( 1, 0, 1 ), 1, 0.5 );
            }
            
            waitframe();
        }
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0x4e3d4724, Offset: 0x6093
    // Size: 0xcf, Type: dev
    function private function_2427909304ffbcdd( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            player.var_1a85d869e714ca25 = undefined;
        }
        
        weyward function_dd0617be62388deb( level.players );
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0x12592f30, Offset: 0x616a
    // Size: 0x8e, Type: dev
    function private function_91034eaf1bffa901( params )
    {
        metabone_name = params[ 0 ];
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        weyward._blackboard.var_3a0516652d1efb68 = metabone_name;
        weyward.var_80521f0adf3a76b9 = undefined;
        zombie_weyward_asm::function_69ff524cca32dbff( weyward, undefined );
        println( "<dev string:x74b>" + metabone_name );
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0x8c57fe6a, Offset: 0x6200
    // Size: 0x8a, Type: dev
    function private function_feb974ab0e061976( params )
    {
        is_left = int( params[ 0 ] );
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        weyward.var_73073e5c8c13a868 = undefined;
        zombie_weyward_asm::function_ba47976c06174596( weyward, is_left );
        println( "<dev string:x762>" + ( is_left ? "<dev string:x782>" : "<dev string:x787>" ) );
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0x537aea59, Offset: 0x6292
    // Size: 0x109, Type: dev
    function private function_590ad460bc2d17b8( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        weyward.health = 1010;
        weyward zombie_weyward_shadow_soul::set_weyward_phase( 3 );
        weyward.fake_death_triggered = 0;
        weyward.var_9dd11279d5e371c7 = 0.1;
        
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::healthbar_set_health( weyward.health, weyward.maxhealth );
        }
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0xd877efa1, Offset: 0x63a3
    // Size: 0x116, Type: dev
    function private function_4cec6bd282904ae3( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( !isdefined( weyward ) )
        {
            return;
        }
        
        weyward.health = 1;
        weyward zombie_weyward_shadow_soul::set_weyward_phase( 3 );
        weyward.fake_death_triggered = 1;
        weyward.real_death_triggered = 0;
        weyward.var_9dd11279d5e371c7 = 0.1;
        
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::healthbar_set_health( weyward.health, weyward.maxhealth );
        }
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0x51c568f1, Offset: 0x64c1
    // Size: 0x4d, Type: dev
    function private function_476140e1c3d5acf( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( isdefined( weyward ) )
        {
            function_e05161f7742e77cd( weyward, 1 );
        }
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0xc8cc3948, Offset: 0x6516
    // Size: 0x4d, Type: dev
    function private function_476150e1c3d5d02( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( isdefined( weyward ) )
        {
            function_e05161f7742e77cd( weyward, 2 );
        }
    }

    // Namespace zombie_weyward
    // Params 1, eflags: 0x4
    // Checksum 0xbfcb09df, Offset: 0x656b
    // Size: 0x4d, Type: dev
    function private function_476160e1c3d5f35( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x72a>" );
        
        if ( isdefined( weyward ) )
        {
            function_e05161f7742e77cd( weyward, 3 );
        }
    }

    // Namespace zombie_weyward
    // Params 2, eflags: 0x4
    // Checksum 0x4311bd26, Offset: 0x65c0
    // Size: 0x11f, Type: dev
    function private function_e05161f7742e77cd( weyward, target_phase )
    {
        health_ratios = [];
        health_ratios[ 1 ] = 1;
        health_ratios[ 2 ] = 0.55;
        health_ratios[ 3 ] = 0.2;
        ratio = health_ratios[ target_phase ] ?? 1;
        weyward zombie_weyward_shadow_soul::set_weyward_phase( target_phase );
        weyward.health = int( weyward.maxhealth * ratio );
        weyward.var_9dd11279d5e371c7 = 0.1;
        
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::healthbar_set_health( weyward.health, weyward.maxhealth );
        }
    }

#/
