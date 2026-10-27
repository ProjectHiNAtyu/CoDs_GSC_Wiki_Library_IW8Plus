// scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween.gsc  (hash_3f750a10051a3895.gscc) (size: 13014 Bytes / 0x32d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x908009e3 (2424310243)
// size ...... 13014 (0x32d6)
// includes .. 23  (offset: 0x2e22)
// strings ... 66  (offset: 0x2eda)
// dev strs .. 13  (offset: 0x322a)
// exports ... 29  (offset: 0x1aee)
// cseg ...... 0x4fc + 0x15f2 (0x1aee)
// imports ... 129 (offset: 0x1f76)
// animtree1 . 0   (offset: 0x32d6)
// animtree2 . 0   (offset: 0x32d6)
#using script_16ea1b94f0f381b3;
#using script_22b6a37515112f37;
#using script_44280f644740bac;
#using script_70fa7df687b2e3bf;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_homestead_halloween\gen\mp_sat_homestead_halloween_art;
#using scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween_fx;
#using scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween_lighting;
#using scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween_vista_zombies;

#namespace mp_sat_homestead_halloween;

// Namespace mp_sat_homestead_halloween
// Params 0
// Checksum 0x9c55f38, Offset: 0x51a
// Size: 0x2ae
function main()
{
    namespace_96c4034e0a7e108b::main();
    namespace_9e29a737285a5260::main();
    namespace_ae7890c46b309a2e::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_homestead" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    var_5a5dd2632899f151 = getdvarint( @"hash_345ca4336ac289d8", 0 ) == 1;
    var_9349e424962b8eb0 = getxhash( game_utility::getgametype() );
    var_d77656cbb092d408 = !arraycontains( [ #"prop", #"gun", #"sticks", #"oic" ], var_9349e424962b8eb0 );
    
    if ( var_d77656cbb092d408 && !var_5a5dd2632899f151 )
    {
        var_b2a916ac0b7783f9 = var_9349e424962b8eb0 == #"sd";
        level thread vignette_manager( var_b2a916ac0b7783f9 );
        level thread namespace_46686fd1b901605b::function_52d0d624138e1a34();
        callback::add( #"player_death", &onplayerdeath );
        
        if ( var_9349e424962b8eb0 != #"infect" && getxhash( game_utility::function_e9de4eeab29754c3() ) != #"koth_horde" )
        {
            callback::add( #"on_ai_killed", &onagentkilled );
        }
    }
    
    level thread cyst_loot_drop( var_d77656cbb092d408 );
    setdvar( @"hash_1673bfd92c93a024", 320 );
    callback::add( #"player_connect", &onplayerconnect );
    level.var_c4186935e13c29bf = [];
    level.t_ice_water = getent( "trigger_hurt_custom", #script_noteworthy );
    
    if ( isdefined( level.t_ice_water ) )
    {
        trigger::makeenterexittrigger( level.t_ice_water, &trigger_hurt_custom_enter, &trigger_hurt_custom_exit );
    }
    
    level thread function_6f86e9e5f1a96877();
    
    /#
        namespace_ec33f26de741e14e::function_5a52677cbdd3e5e5( "<dev string:x24>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x3e>", "<dev string:x24>", &function_11697c06b2e9b942, "<dev string:x50>", "<dev string:x74>", undefined );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x79>", "<dev string:x24>", &function_315a3838f21e2933, "<dev string:x50>", "<dev string:x8c>", undefined );
        namespace_ec33f26de741e14e::function_67acbc0c7e614803( "<dev string:x92>", "<dev string:x24>" );
    #/
}

// Namespace mp_sat_homestead_halloween
// Params 1
// Checksum 0xabe9257c, Offset: 0x7d0
// Size: 0x36
function onagentkilled( params )
{
    if ( self.var_f8c5dd66e2ca06ba )
    {
        params.eattacker thread points::doscoreevent( #"hash_33d9ea2f49af46f1", undefined, 5 );
    }
}

// Namespace mp_sat_homestead_halloween
// Params 1, eflags: 0x4
// Checksum 0x7977bfbd, Offset: 0x80e
// Size: 0x23
function private on_player_spawned( params )
{
    if ( !utility::function_cfcadadaf7557e6b( self ) )
    {
        player::_setsuit( "sat_defaultsuit_mp_snow_deep" );
    }
}

// Namespace mp_sat_homestead_halloween
// Params 2, eflags: 0x4
// Checksum 0x3e8ab342, Offset: 0x839
// Size: 0x3c
function private trigger_hurt_custom_enter( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( isplayer( var_fd3a9f9e9a2a06c2 ) )
    {
        if ( !isalive( var_fd3a9f9e9a2a06c2 ) || var_fd3a9f9e9a2a06c2 isonground() )
        {
            return;
        }
        
        var_fd3a9f9e9a2a06c2 function_184f53ac053b0b15();
    }
}

// Namespace mp_sat_homestead_halloween
// Params 2, eflags: 0x4
// Checksum 0x3213bad0, Offset: 0x87d
// Size: 0x15
function private trigger_hurt_custom_exit( var_cfc19047cc2d028c, trigger )
{
    
}

// Namespace mp_sat_homestead_halloween
// Params 0, eflags: 0x4
// Checksum 0xa546b58c, Offset: 0x89a
// Size: 0x31
function private function_184f53ac053b0b15()
{
    if ( !arraycontains( level.var_c4186935e13c29bf, self ) )
    {
        function_dc035b6d9bb172fd();
        level.var_c4186935e13c29bf[ level.var_c4186935e13c29bf.size ] = self;
    }
}

// Namespace mp_sat_homestead_halloween
// Params 0, eflags: 0x4
// Checksum 0x9605a259, Offset: 0x8d3
// Size: 0x3b
function private function_c0bb24bd300d7565()
{
    if ( arraycontains( level.var_c4186935e13c29bf, self ) )
    {
        self.var_b7fd3ebe9ccfa0fd = 0;
        function_dc035b6d9bb172fd();
        level.var_c4186935e13c29bf = arrayremove( level.var_c4186935e13c29bf, self );
    }
}

// Namespace mp_sat_homestead_halloween
// Params 2, eflags: 0x4
// Checksum 0x3a880d75, Offset: 0x916
// Size: 0x23
function private function_aeaeba94d70d29a8( e_player, str_state )
{
    e_player setscriptablepartstate( "ice_build_FX", str_state );
}

// Namespace mp_sat_homestead_halloween
// Params 0, eflags: 0x4
// Checksum 0x3e1e9bf8, Offset: 0x941
// Size: 0x47
function private function_dc035b6d9bb172fd()
{
    self.n_tick_counter = 0;
    self.var_b1147892811890e7 = 5;
    self.var_4bfcff2b7dbb34ac = 15;
    self.var_4bc4244463213448 = 0;
    self.str_current_state = "reset";
    function_aeaeba94d70d29a8( self, "reset" );
}

// Namespace mp_sat_homestead_halloween
// Params 0, eflags: 0x4
// Checksum 0xb167a74d, Offset: 0x990
// Size: 0x8d, Type: bool
function private function_f1db480eddaacea1()
{
    b_is_active_freezing = 0;
    
    if ( self isswimming() )
    {
        self.var_b7fd3ebe9ccfa0fd = 1;
        return true;
    }
    else if ( self isjumping() && self.var_b7fd3ebe9ccfa0fd )
    {
        self.var_b7fd3ebe9ccfa0fd = 0;
        return true;
    }
    else if ( self isonground() || self ismantling() )
    {
        if ( self istouching( level.t_ice_water ) )
        {
            self.var_b7fd3ebe9ccfa0fd = 1;
            return true;
        }
        else
        {
            self.var_b7fd3ebe9ccfa0fd = 0;
            return false;
        }
    }
    
    return false;
}

// Namespace mp_sat_homestead_halloween
// Params 0, eflags: 0x4
// Checksum 0xe47c5d5b, Offset: 0xa26
// Size: 0x36c
function private function_6f86e9e5f1a96877()
{
    level endon( #"game_ended" );
    
    if ( level.prematchperiodend > 0 )
    {
        level waittill( #"matchstarttimer_done" );
    }
    
    while ( true )
    {
        var_4a531313ea3ec7d = level.var_c4186935e13c29bf;
        
        foreach ( player in var_4a531313ea3ec7d )
        {
            if ( isalive( player ) )
            {
                if ( player.n_tick_counter < 1 )
                {
                    player.n_tick_counter += 0.21;
                }
                
                if ( player.n_tick_counter >= 1 )
                {
                    player.n_tick_counter = 0;
                    
                    if ( player function_f1db480eddaacea1() )
                    {
                        if ( player.var_b1147892811890e7 > 0 )
                        {
                            player.var_b1147892811890e7 -= 1;
                        }
                        else if ( player.var_4bc4244463213448 < 10 )
                        {
                            if ( player.str_current_state != "forward" )
                            {
                                player.str_current_state = "forward";
                                function_aeaeba94d70d29a8( player, "forward" );
                            }
                            
                            player.var_4bc4244463213448 += 1;
                        }
                        
                        if ( player.var_4bfcff2b7dbb34ac > 0 )
                        {
                            player.var_4bfcff2b7dbb34ac -= 1;
                        }
                        else if ( !isingodmode( player ) && !player isnoclip() )
                        {
                            player dodamage( 10, player.origin, player, level.t_ice_water, "MOD_FIRE" );
                            player playsoundtoplayer( "chr_ice_freeze_dmg", player );
                        }
                    }
                    else
                    {
                        if ( player.var_4bc4244463213448 > 0 )
                        {
                            if ( player.str_current_state != "reverse" )
                            {
                                player.str_current_state = "reverse";
                                var_44ebe474a4173728 = int( round( player.var_4bc4244463213448 / 10, 0.25 ) * 100 );
                                
                                if ( var_44ebe474a4173728 == 0 )
                                {
                                    function_aeaeba94d70d29a8( player, "reset" );
                                }
                                else
                                {
                                    function_aeaeba94d70d29a8( player, "reverse_" + var_44ebe474a4173728 );
                                }
                            }
                            
                            player.var_4bc4244463213448 -= 1;
                        }
                        else if ( player.var_b1147892811890e7 <= 5 )
                        {
                            player.var_b1147892811890e7 += 7.5;
                        }
                        else
                        {
                            player function_c0bb24bd300d7565();
                        }
                        
                        if ( player.var_4bfcff2b7dbb34ac <= 15 )
                        {
                            player.var_4bfcff2b7dbb34ac += 7.5;
                        }
                    }
                    
                    clamp( player.var_b1147892811890e7, 0, 5 );
                    clamp( player.var_4bfcff2b7dbb34ac, 0, 15 );
                    clamp( player.var_4bc4244463213448, 0, 10 );
                }
            }
            
            if ( !isalive( player ) )
            {
                player function_c0bb24bd300d7565();
            }
        }
        
        wait 0.21;
    }
}

// Namespace mp_sat_homestead_halloween
// Params 1
// Checksum 0x7317205, Offset: 0xd9a
// Size: 0x3f
function vignette_manager( var_b2a916ac0b7783f9 )
{
    level endon( #"game_ended" );
    
    while ( !level.var_f334a2aa4deb0aeb )
    {
        waitframe();
    }
    
    if ( !var_b2a916ac0b7783f9 )
    {
        level thread function_41e0f10f7224e3d6();
    }
    
    level thread function_54f1d2254e3d19bf();
}

// Namespace mp_sat_homestead_halloween
// Params 1
// Checksum 0xc0521272, Offset: 0xde1
// Size: 0x2b
function function_2780aabc3a33768( zombie )
{
    zombie namespace_9d8e359c3b1041e5::function_b739495605e4ba8a( 1 );
    namespace_3047dff6a502386b::function_896d0f86ab8af668( zombie, zombie.team );
}

// Namespace mp_sat_homestead_halloween
// Params 0
// Checksum 0x30aebb21, Offset: 0xe14
// Size: 0x1ec
function function_41e0f10f7224e3d6()
{
    level endon( #"game_ended" );
    eating_scene = utility::getstruct( "eating_corpse" );
    scene::add_scene_func( eating_scene, &init_corpse_scene, "callback_init" );
    eating_scene thread function_29a94f48e7bf7390( undefined, "looping_idle" );
    eating_scene waittill( #"scene_init_internal" );
    var_af40da5c0a40f62c = eating_scene scene::get_entity( "Actor 1" );
    var_10e7215b96a23e52 = eating_scene scene::get_entity( "Actor 2" );
    eaten_zombie = eating_scene scene::get_entity( "Actor 3" );
    
    for ( players_near_scene = getplayersinradius( eating_scene.origin, 200 ); players_near_scene.size == 0 ; players_near_scene = getplayersinradius( eating_scene.origin, 200 ) )
    {
        wait 1;
    }
    
    if ( isalive( var_af40da5c0a40f62c ) )
    {
        eating_scene thread scene::play( var_af40da5c0a40f62c, "action" );
        var_af40da5c0a40f62c thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "homestead_halloween", 1000 );
    }
    
    if ( isalive( var_10e7215b96a23e52 ) )
    {
        eating_scene thread scene::play( var_10e7215b96a23e52, "action" );
        var_10e7215b96a23e52 thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "homestead_halloween", 1000 );
    }
    
    if ( isalive( eaten_zombie ) )
    {
        eaten_zombie utility::ent_flag_set( "anim_ended" );
        eaten_zombie notify( #"anim_ended" );
        eaten_zombie.b_cleanup_no_respawn = 1;
        eaten_zombie.var_f654ebe2aeab29f7 = 1;
        eaten_zombie.noragdoll = 1;
        eaten_zombie.disabledeathorient = 1;
        eaten_zombie.var_fd5c989cd241b6c4 = 1;
        eaten_zombie val::set( "mp_eating_corpse", "allow_dismember", 0 );
        eaten_zombie val::set_allow_death( 1 );
        eaten_zombie setcandamage( 1 );
        eaten_zombie dodamage( eaten_zombie.health, eaten_zombie.origin );
        eaten_zombie thread scene::cleanup( 1 );
    }
}

// Namespace mp_sat_homestead_halloween
// Params 0
// Checksum 0x11246971, Offset: 0x1008
// Size: 0x1c
function init_corpse_scene()
{
    eating_scene = self;
    eating_scene notify( #"scene_init_internal" );
}

// Namespace mp_sat_homestead_halloween
// Params 0
// Checksum 0x90108c89, Offset: 0x102c
// Size: 0x3c
function function_54f1d2254e3d19bf()
{
    var_35fcd967e73f5151 = utility::getstructarray( "clawing_wall" );
    
    if ( var_35fcd967e73f5151.size == 0 )
    {
        return;
    }
    
    clawing_scene = var_35fcd967e73f5151[ 0 ];
    clawing_scene thread function_29a94f48e7bf7390( undefined, undefined, 1 );
}

// Namespace mp_sat_homestead_halloween
// Params 3
// Checksum 0x1ce683e0, Offset: 0x1070
// Size: 0xf2
function function_29a94f48e7bf7390( var_5567306b2b96028c, str_shotnames, b_annihilate )
{
    level endon( #"game_ended" );
    thread scene::play( var_5567306b2b96028c, str_shotnames );
    
    while ( self.scenedata.state != "Setup" )
    {
        waitframe();
    }
    
    var_fedfc0b2d535d712 = scene::get_entities();
    
    foreach ( var_a6eb29bfca330901 in var_fedfc0b2d535d712 )
    {
        function_2780aabc3a33768( var_a6eb29bfca330901 );
        var_a6eb29bfca330901.var_f8c5dd66e2ca06ba = 1;
        var_a6eb29bfca330901.forceannihilate = b_annihilate;
    }
}

// Namespace mp_sat_homestead_halloween
// Params 1, eflags: 0x4
// Checksum 0x6bdda4e, Offset: 0x116a
// Size: 0x1c
function private onplayerconnect( params )
{
    if ( !isbot( self ) )
    {
        thread jumpscare_trigger();
    }
}

// Namespace mp_sat_homestead_halloween
// Params 1
// Checksum 0xa26b35af, Offset: 0x118e
// Size: 0x139
function onplayerdeath( params )
{
    victim = params.victim;
    
    foreach ( cyst in level.var_536555dcba9b73a3 )
    {
        var_187a598536e9b63f = distance2d( victim.origin, cyst.origin );
        
        if ( var_187a598536e9b63f < 500 )
        {
            trace = trace::ray_trace( cyst.origin + ( 20, 0, 0 ), victim.origin + ( 0, 0, 20 ), level.players );
            is_in_sight = trace[ "hittype" ] == "hittype_none";
            
            if ( is_in_sight )
            {
                cyst thread function_4cbe2e0bf567e6d9( victim.origin );
            }
        }
    }
}

// Namespace mp_sat_homestead_halloween
// Params 0
// Checksum 0xa1f868e0, Offset: 0x12cf
// Size: 0x14f
function jumpscare_trigger()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    orda_corpse = getent( "jump_scare", #targetname );
    
    /#
        level thread debug_draw_orda( orda_corpse );
    #/
    
    jumpscare_fx = utility::getfx( "ruby_js_image" );
    
    if ( !isdefined( self ) || !isdefined( orda_corpse ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( isalive( self ) && self playerads() == 1 && utility::percent_chance( 30 ) )
        {
            player_forward_vec = anglestoforward( self getplayerangles() );
            var_4f2d9ae4dd87f856 = vectornormalize( orda_corpse.origin + ( 70, 66, 300 ) - self.origin );
            dot = vectordot( player_forward_vec, var_4f2d9ae4dd87f856 );
            eye_pos = self geteye();
            
            if ( isdefined( eye_pos ) && dot > 0.996 && sighttracepassed( eye_pos, orda_corpse.origin + ( 70, 66, 300 ), 1, self ) )
            {
                playfxontagforclients( jumpscare_fx, self, "j_head", self );
                self playsoundtoplayer( "evt_hs_halloween_jump_scare", self );
                return;
            }
        }
        else
        {
            wait 6;
        }
        
        waitframe();
    }
}

/#

    // Namespace mp_sat_homestead_halloween
    // Params 1
    // Checksum 0x13a1cc0a, Offset: 0x1426
    // Size: 0x45, Type: dev
    function debug_draw_orda( orda_corpse )
    {
        while ( true )
        {
            debugstar( orda_corpse.origin + ( 70, 66, 300 ), ( 1, 1, 1 ), 1 );
            waitframe();
        }
    }

#/

// Namespace mp_sat_homestead_halloween
// Params 1
// Checksum 0x1f75395, Offset: 0x1473
// Size: 0xe9
function cyst_loot_drop( var_d77656cbb092d408 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    level.var_536555dcba9b73a3 = getentitylessscriptablearray( "cyst_loot", "script_noteworthy" );
    
    foreach ( cyst in level.var_536555dcba9b73a3 )
    {
        if ( var_d77656cbb092d408 )
        {
            cyst.v_drop_location = utility::getstruct( cyst.target, "targetname" ).origin;
            continue;
        }
        
        cyst destructible::destroy();
    }
}

// Namespace mp_sat_homestead_halloween
// Params 1
// Checksum 0x6b64b8ba, Offset: 0x1564
// Size: 0x104
function function_4cbe2e0bf567e6d9( var_875548d64d193f21 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_3e580d3d63e85fa2 ) )
    {
        self.var_3e580d3d63e85fa2 = 0;
    }
    
    self.var_3e580d3d63e85fa2++;
    var_71f746e2c7e0fc6 = self.var_3e580d3d63e85fa2 >= 9;
    
    if ( var_71f746e2c7e0fc6 )
    {
        level.var_536555dcba9b73a3 = arrayremove( level.var_536555dcba9b73a3, self );
    }
    
    e_soul = utility::spawn_model( "tag_origin", var_875548d64d193f21 );
    e_soul utility::playsoundontag( "evt_zm_cyst_loot_soul_wisp", "tag_origin", 1 );
    e_soul thread soul_harvest::soul_fly( var_875548d64d193f21, self.origin, "vfx_sat_levels_mp_homestead_halloween_loot_cyst_trail", 0, undefined, 0, 5, undefined, 30, 0 );
    e_soul waittill( #"curve_done" );
    e_soul delete();
    self setscriptablepartstate( "effect", "harvest" );
    playsoundatpos( self.origin, "evt_zm_cyst_loot_soul_impact" );
    
    if ( var_71f746e2c7e0fc6 )
    {
        destructible::destroy();
        function_333fcb532616c0ae();
    }
}

// Namespace mp_sat_homestead_halloween
// Params 0
// Checksum 0x7fc87817, Offset: 0x1670
// Size: 0x1f1
function function_333fcb532616c0ae()
{
    level endon( #"game_ended" );
    wait 0.45;
    n_random_weapon_index = randomint( 5 );
    var_26c2d71737b7024f = [ "sat_ks_deathmachine", "sat_ks_warmachine", "sat_ks_handcannon", "sat_ks_smartgun_mp", "sat_ks_sniper_briefcase_mp" ];
    var_ad578871a4e37adc = var_26c2d71737b7024f[ n_random_weapon_index ];
    killstreak_weapon_drop = weapon::buildweapon( var_ad578871a4e37adc );
    var_de7a15ffafe34066 = spawn( "weapon_" + getcompleteweaponname( killstreak_weapon_drop ), self.origin );
    var_3f373c4b0462870d = [ ( 10, 0, 20 ), ( -11, 4.5, 76 ), ( 0, 38, 90 ), ( 0, 210, -90 ), ( -1, -20, 80 ) ];
    var_de7a15ffafe34066.angles = var_3f373c4b0462870d[ n_random_weapon_index ];
    var_5e267946b5747a62 = [ ( 5, 0, -9 ), ( 5, 0, -13 ), ( 10, 0, -14.8 ), ( 40, 0, -14.8 ), ( 0, 0, -13.5 ) ];
    var_de7a15ffafe34066 hudoutlineenable( "sat_hmstd_killstreak_outline" );
    e_drop_struct = utility::spawn_model( "tag_origin", self.origin, vectortoangles( self.origin - self.v_drop_location ) );
    var_de7a15ffafe34066 enablelinkto();
    var_de7a15ffafe34066 linkto( e_drop_struct, "tag_origin" );
    e_drop_struct thread drop_to_ground( self.origin, self.v_drop_location + var_5e267946b5747a62[ n_random_weapon_index ] );
    var_de7a15ffafe34066 thread function_243074465002c179( n_random_weapon_index, killstreak_weapon_drop );
}

// Namespace mp_sat_homestead_halloween
// Params 2, eflags: 0x4
// Checksum 0xcc80648, Offset: 0x1869
// Size: 0xa0
function private drop_to_ground( v_origin, v_drop_location )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"delete" );
    playfxontag( level._effect[ "vfx_t10_gameplay_zm_loot_trail_legendary" ], self, "tag_origin" );
    utility::playsoundontag( "evt_zm_cyst_loot_soul_wisp", "tag_origin", 1 );
    var_242613d130fb5363 = ( v_origin + v_drop_location ) / 2 + ( randomintrange( -10, 10 ), randomintrange( -30, 30 ), 60 );
    thread utility::function_8001268940441423( v_origin, v_drop_location, var_242613d130fb5363, 0.4, 0, 1 );
}

// Namespace mp_sat_homestead_halloween
// Params 2, eflags: 0x4
// Checksum 0xa4fb11e2, Offset: 0x1911
// Size: 0xb9
function private function_243074465002c179( n_index, killstreak_weapon_drop )
{
    level endon( #"game_ended" );
    self waittill( #"trigger", e_player );
    e_player takeweapon( killstreak_weapon_drop );
    var_946c24998d3dfad9 = [ "death_machine_gun", "war_machine_launcher", "hand_cannon", "smart_gun", "sniper_briefcase" ];
    var_bcc606d64b6668 = var_946c24998d3dfad9[ n_index ];
    e_player namespace_9d8e359c3b1041e5::awardkillstreaksharedfunc( var_bcc606d64b6668, "other", undefined, undefined, undefined, 0 );
    scorestreak_ref = e_player killstreaks::getkillstreakinslot( 0 );
    e_player killstreaks::triggerkillstreak( scorestreak_ref, 0 );
}

/#

    // Namespace mp_sat_homestead_halloween
    // Params 2
    // Checksum 0x2faabf6f, Offset: 0x19d2
    // Size: 0xaf, Type: dev
    function function_11697c06b2e9b942( host, args )
    {
        level utility::flag_wait( "<dev string:xac>" );
        var_2875abbda7e0c356 = getentitylessscriptablearray( "<dev string:xbe>", "<dev string:xc8>" );
        
        foreach ( cyst in var_2875abbda7e0c356 )
        {
            cyst thread function_333fcb532616c0ae();
        }
    }

    // Namespace mp_sat_homestead_halloween
    // Params 2
    // Checksum 0x90a3bf98, Offset: 0x1a89
    // Size: 0x65, Type: dev
    function function_315a3838f21e2933( host, args )
    {
        if ( !isdefined( level.var_82cd6c3319d72df0 ) )
        {
            level.var_82cd6c3319d72df0 = 0;
        }
        
        level.var_82cd6c3319d72df0 = !level.var_82cd6c3319d72df0;
        iprintlnbold( "<dev string:xda>" + ( level.var_82cd6c3319d72df0 ? "<dev string:x105>" : "<dev string:x10a>" ) );
    }

#/
