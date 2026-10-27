// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight_twins.gsc  (hash_2f7196b4188b3ba8.gscc) (size: 24834 Bytes / 0x6102 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70d47111 (1892970769)
// size ...... 24834 (0x6102)
// includes .. 13  (offset: 0x5cbe)
// strings ... 43  (offset: 0x5d26)
// dev strs .. 27  (offset: 0x5fbe)
// exports ... 45  (offset: 0x41e6)
// cseg ...... 0x319 + 0x3ecd (0x41e6)
// imports ... 154 (offset: 0x48ee)
// animtree1 . 0   (offset: 0x6102)
// animtree2 . 0   (offset: 0x6102)
#using script_1d947a67914036d6;
#using script_4739bc1bf6db3b96;
#using script_7573db1b78c0c729;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_boss_fight_twins;

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0
// Checksum 0x74932fc3, Offset: 0x337
// Size: 0x1a2
function function_dc1f2f5a8607c47()
{
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72 zm_sat_mantis_boss_fight::function_3176083662ac618d( 0, 0 );
        var_576d220b01160c72.mdl.sbl setscriptablepartstate( "vfx", "complete" );
        var_576d220b01160c72.mdl.sbl setscriptablepartstate( "defend", "complete" );
        
        if ( isdefined( var_576d220b01160c72.current_scene_struct ) )
        {
            var_576d220b01160c72.current_scene_struct thread scene::stop();
            var_576d220b01160c72.current_scene_struct = undefined;
        }
        
        if ( isdefined( var_576d220b01160c72.var_2493d58589b9976 ) )
        {
            var_576d220b01160c72.var_2493d58589b9976 delete();
            var_576d220b01160c72.var_2493d58589b9976 = undefined;
        }
        
        var_576d220b01160c72 function_9732189d573c8d81();
        
        if ( isdefined( var_576d220b01160c72.var_5ac3af3dfe03f618 ) )
        {
            var_576d220b01160c72.var_5ac3af3dfe03f618 delete();
            var_576d220b01160c72.var_5ac3af3dfe03f618 = undefined;
        }
        
        var_576d220b01160c72.n_cooldown_start_time = undefined;
        var_576d220b01160c72.n_cooldown_duration = undefined;
    }
    
    if ( isalive( level.s_dark_heart.boss_agent ) )
    {
        level.s_dark_heart.boss_agent zombie_aeon_navigation::stop_navigation();
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x65b004b6, Offset: 0x4e1
// Size: 0x22e
function function_59ca73d464acf47d( phase_name )
{
    level endon( #"game_ended" );
    level endon( #"end_twins_charge_check" );
    previous_holdout = undefined;
    
    while ( true )
    {
        wait 3;
        var_7266749a13485d9f = function_7f95d1e98f031945();
        spirit_orb = function_5d3e01181b50b579( previous_holdout );
        thread zm_quest::update_guidance( [ [ spirit_orb ] ], #"mantis_mq_guidance", #"boss_defend" );
        spirit_orb thread function_b8fb29ed2fbdf605( var_7266749a13485d9f );
        
        if ( utility::flag( var_7266749a13485d9f.script_noteworthy + "_defend_started" ) )
        {
            utility::flag_clear( var_7266749a13485d9f.script_noteworthy + "_defend_started" );
        }
        
        while ( !utility::flag( var_7266749a13485d9f.script_noteworthy + "_defend_started" ) )
        {
            if ( distance2d( spirit_orb.origin, var_7266749a13485d9f.origin ) < 60 )
            {
                level utility::flag_set( var_7266749a13485d9f.script_noteworthy + "_defend_started" );
                break;
            }
            
            waitframe();
        }
        
        spirit_orb thread function_134f0235503cab98();
        var_7266749a13485d9f function_d4e54ec76447ee4e();
        var_62a0ad0e30aa7867 = getdvarfloat( @"hash_1f852d134b173fdc", 600 );
        level.s_dark_heart.boss_agent zombie_aeon_navigation::navigate_to( var_7266749a13485d9f.origin, var_62a0ad0e30aa7867 );
        wait 0.5;
        var_7266749a13485d9f zm_sat_mantis_boss_fight::function_3176083662ac618d( 1, 0 );
        thread zm_quest::update_guidance( [ [ var_7266749a13485d9f, 100, undefined, &"zm_sat_mantis_post/protect" ] ], #"mantis_mq_guidance", #"boss_defend" );
        level thread utility::thread_on_notify( var_7266749a13485d9f.script_noteworthy + "_finish_charge", &function_c140f2838f106c1c, undefined, undefined, undefined, var_7266749a13485d9f );
        var_7266749a13485d9f function_56648d813735a6dc( phase_name );
        level utility::flag_wait( var_7266749a13485d9f.script_noteworthy + "_finish_charge" );
        level.s_dark_heart.boss_agent zombie_aeon_navigation::navigate_to_center();
        previous_holdout = var_7266749a13485d9f;
        level notify( #"boss_fight_instrument_defend_success", var_7266749a13485d9f );
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0xde2388ef, Offset: 0x717
// Size: 0x5f
function private function_c140f2838f106c1c( s_holdout )
{
    s_holdout zm_sat_mantis_boss_fight::function_3176083662ac618d( 0, 0 );
    s_holdout.mdl.sbl setscriptablepartstate( "vfx", "complete" );
    s_holdout.mdl.sbl setscriptablepartstate( "defend", "complete" );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x210f42df, Offset: 0x77e
// Size: 0x88
function function_56648d813735a6dc( phase_name )
{
    level endon( #"game_ended" );
    init_twins_scene = utility::array_random( self.twins_positions );
    self.var_2493d58589b9976 = utility::spawn_model( "sat_zm_gameplay_twins_collision_proxy", self.origin, self.angles );
    self.var_2493d58589b9976 setcandamage( 1 );
    wait 1;
    thread function_f8bf4f2c7f0e6814( phase_name, init_twins_scene );
    thread function_55722f30e86c3340( phase_name );
    function_1497200497185b09( phase_name );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2
// Checksum 0x888d9cb2, Offset: 0x80e
// Size: 0x3f4
function function_f8bf4f2c7f0e6814( phase_name, current_scene_struct )
{
    level endon( #"game_ended" );
    self endon( #"twins_interrupted" );
    self endon( #"hash_ac9772d9f24de85e" );
    var_eaa4291dfe5f4af1 = arraycopy( self.twins_positions );
    
    if ( isdefined( current_scene_struct ) )
    {
        self.current_scene_struct = current_scene_struct;
        var_eaa4291dfe5f4af1 = arrayremove( var_eaa4291dfe5f4af1, current_scene_struct );
    }
    else
    {
        self.current_scene_struct = utility::array_random( var_eaa4291dfe5f4af1 );
    }
    
    for ( var_eaa4291dfe5f4af1 = arrayremove( var_eaa4291dfe5f4af1, self.current_scene_struct ); true ; var_eaa4291dfe5f4af1 = arrayremove( var_eaa4291dfe5f4af1, self.current_scene_struct ) )
    {
        self.current_scene_struct.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_draw_chalk";
        
        if ( var_eaa4291dfe5f4af1.size == 0 )
        {
            var_eaa4291dfe5f4af1 = arraycopy( self.twins_positions );
        }
        
        self.current_scene_struct thread scene::play( undefined, "chalk_03" );
        self.var_2a345ab3ef50328c = self.current_scene_struct scene::get_entities();
        
        foreach ( model in self.var_2a345ab3ef50328c )
        {
            if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
            {
                if ( isdefined( level.s_dark_heart ) && !isdefined( level.s_dark_heart.mdl_sister_spectral ) && model.model == "body_c_sat_zmb_dlc2_npc_sister_spectral" )
                {
                    level.s_dark_heart.mdl_sister_spectral = model;
                }
                
                if ( isdefined( level.s_dark_heart ) && !isdefined( level.s_dark_heart.mdl_sister_skeletal ) && model.model == "body_c_sat_zmb_dlc2_npc_sister_skeletal" )
                {
                    level.s_dark_heart.mdl_sister_skeletal = model;
                }
                
                model utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
            }
        }
        
        wait 0.5;
        
        foreach ( model in self.var_2a345ab3ef50328c )
        {
            if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
            {
                model castshadows();
                model utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
            }
        }
        
        function_17e012098dda3f8e( phase_name );
        reveal_out_time = 3;
        wait level.s_dark_heart.phase_data[ phase_name ].var_3934681094ba96e3 - reveal_out_time;
        
        foreach ( model in self.var_2a345ab3ef50328c )
        {
            if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
            {
                model utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            }
        }
        
        wait reveal_out_time;
        
        if ( self.current_scene_struct )
        {
            self.current_scene_struct thread scene::stop();
        }
        
        function_9732189d573c8d81();
        self.current_scene_struct = utility::array_random( var_eaa4291dfe5f4af1 );
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0
// Checksum 0xba0400aa, Offset: 0xc0a
// Size: 0xe8
function function_5318b5a351d8177c()
{
    if ( isdefined( self.current_scene_struct ) )
    {
        function_9732189d573c8d81();
        var_2a345ab3ef50328c = self.current_scene_struct scene::get_entities();
        
        foreach ( model in var_2a345ab3ef50328c )
        {
            if ( isdefined( model ) && issubstr( model.model, "npc_sister" ) )
            {
                model utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            }
        }
        
        reveal_out_time = 3;
        wait reveal_out_time;
        self.current_scene_struct thread scene::stop();
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x171aee27, Offset: 0xcfa
// Size: 0x21d
function function_1497200497185b09( phase_name )
{
    level endon( #"game_ended" );
    level endon( #"end_twins_charge_check" );
    start_charge_time = gettime();
    thread twins_health_listener( phase_name );
    
    while ( true )
    {
        if ( utility::ent_flag( "twins_interrupted" ) )
        {
            self.var_5ac3af3dfe03f618 delete();
            utility::ent_flag_clear( "played_charge_beam_vfx" );
            function_ca92ec6049b52b59( 0 );
            thread function_5318b5a351d8177c();
            self.n_cooldown_start_time = gettime();
            self.n_cooldown_duration = level.s_dark_heart.phase_data[ phase_name ].var_9c7f51aca0dd6e3c;
            wait self.n_cooldown_duration;
            self.n_cooldown_start_time = undefined;
            self.n_cooldown_duration = undefined;
            function_d4e54ec76447ee4e();
            utility::ent_flag_clear( "twins_interrupted" );
            start_charge_time = gettime();
            thread twins_health_listener( phase_name );
            thread function_f8bf4f2c7f0e6814( phase_name );
            wait 1;
            zm_sat_mantis_boss_fight::function_3176083662ac618d( 1, 0 );
        }
        
        if ( !utility::ent_flag( "played_charge_beam_vfx" ) )
        {
            utility::ent_flag_set( "played_charge_beam_vfx" );
            self.var_5ac3af3dfe03f618 = playfxontagsbetweenclients( level._effect[ "dark_energy_beam" ], self.var_2493d58589b9976, "tag_origin", self.mdl, "tag_origin" );
        }
        
        if ( gettime() - start_charge_time > utility::function_4b74c15943231980( level.s_dark_heart.phase_data[ phase_name ].var_288bcccb53c9380c ) )
        {
            self notify( #"hash_ac9772d9f24de85e" );
            self.var_6eb21481f208c57f = 1;
            
            if ( isdefined( self.var_5ac3af3dfe03f618 ) )
            {
                self.var_5ac3af3dfe03f618 delete();
            }
            
            self.var_2493d58589b9976 delete();
            
            if ( isdefined( self.var_c433dfcc41ca3aba ) )
            {
                self.var_c433dfcc41ca3aba freescriptable();
            }
            
            function_5318b5a351d8177c();
            function_ca92ec6049b52b59( 0 );
            utility::ent_flag_clear( "played_charge_beam_vfx" );
            level utility::flag_set( self.script_noteworthy + "_finish_charge" );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x6125a57d, Offset: 0xf1f
// Size: 0x86
function function_ca92ec6049b52b59( var_ae740a76f0c8ef99 )
{
    if ( var_ae740a76f0c8ef99 )
    {
        zm_quest::function_fba942a1cfd85f5d( 1, 1, #"mantis_mq", #"hash_d8e3443bb8a32f8" );
        zm_quest::function_cd1f2fee4749fb0a( 1, #"mantis_mq", #"hash_d8e3443bb8a32f8" );
        zm_quest::function_9f49b2a045ece8ae( 999, 1, #"mantis_mq", #"hash_d8e3443bb8a32f8" );
        return;
    }
    
    zm_quest::function_fba942a1cfd85f5d( 0, 1, #"mantis_mq", #"hash_d8e3443bb8a32f8" );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x12b6d1b7, Offset: 0xfad
// Size: 0x3ae
function twins_health_listener( phase_name )
{
    level endon( #"game_ended" );
    self endon( #"hash_ac9772d9f24de85e" );
    self.var_2493d58589b9976.maxhealth = level.s_dark_heart.phase_data[ phase_name ].twinshealth;
    self.var_2493d58589b9976.maxhealth *= 1 + ( level.players.size - 1 ) * level.s_dark_heart.phase_data[ phase_name ].var_2670bde29175b63a;
    self.var_2493d58589b9976.var_cce7c67ea2da8902 = self.var_2493d58589b9976.maxhealth;
    self.var_2493d58589b9976 utility::function_7c10ea82c1e305b8( "base", "idle" );
    function_ca92ec6049b52b59( 1 );
    self.mdl.sbl utility::function_32b24db3127bff40( "vfx", "shield" );
    self.mdl.sbl utility::function_32b24db3127bff40( "defend", "charging" );
    
    while ( true )
    {
        self.var_2493d58589b9976 waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        self.var_2493d58589b9976.var_cce7c67ea2da8902 -= 10;
        
        if ( !isdefined( attacker ) || isplayer( attacker ) )
        {
            continue;
        }
        
        health_percentage = self.var_2493d58589b9976.var_cce7c67ea2da8902 / self.var_2493d58589b9976.maxhealth;
        health_percentage = clamp( health_percentage, 0, 1 );
        zm_quest::function_9f49b2a045ece8ae( health_percentage * 999, 1, #"mantis_mq", #"hash_d8e3443bb8a32f8" );
        
        if ( damagelocation )
        {
            playfx( utility::getfx( "twins_shield_dmg" ), damagelocation );
            playsoundatpos( damagelocation, #"hash_cf9d219d8ffe5510" );
        }
        
        if ( health_percentage <= 0.75 && health_percentage > 0.25 )
        {
            self.mdl.sbl utility::function_32b24db3127bff40( "vfx", "shield_75" );
            level notify( #"hash_7dfe3c94b6a08252" );
        }
        else if ( health_percentage <= 0.25 && health_percentage > 0 )
        {
            self.mdl.sbl utility::function_32b24db3127bff40( "vfx", "shield_25" );
            level notify( #"hash_43ba060b09af25e1" );
        }
        
        if ( self.var_2493d58589b9976.var_cce7c67ea2da8902 <= 0 )
        {
            self.mdl.sbl utility::function_32b24db3127bff40( "vfx", "break" );
            self.mdl.sbl utility::function_32b24db3127bff40( "defend", "off" );
            zm_sat_mantis_boss_fight::function_3176083662ac618d( 0, 0 );
            utility::ent_flag_set( "twins_interrupted" );
            level notify( #"boss_fight_defend_fail" );
            self.var_2493d58589b9976.var_94bcef0b627f1aca = 0;
            break;
        }
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x3f997b06, Offset: 0x1363
// Size: 0xc3
function function_17e012098dda3f8e( phase_name )
{
    if ( !self.var_2493d58589b9976 )
    {
        return;
    }
    
    self.var_5911abf1264f0db6 = function_e7c0e49a6dfb39a1( level.s_dark_heart.phase_data[ phase_name ] );
    self.var_9524d11c526b9612 = [];
    self.attractor = zombie_attractor_manager::add_attractor( self.var_2493d58589b9976, 0, 5000, 1, &twins_goal_location, &function_16248599b926f7a3, undefined, undefined, undefined, &function_3023715435c56ff6 );
    zombie_attractor_manager::function_a2aab3762aaa055f( self.attractor, self.var_2493d58589b9976.origin, ( 100, 100, 100 ), self.var_2493d58589b9976.angles );
    thread function_ef9c8deb26cb1006();
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0
// Checksum 0xedaa3266, Offset: 0x142e
// Size: 0x35
function function_9732189d573c8d81()
{
    self notify( #"hash_95a419f4e1cd8c1" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
    
    self.var_9524d11c526b9612 = [];
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0
// Checksum 0xe6374a2e, Offset: 0x146b
// Size: 0x2de
function function_ef9c8deb26cb1006()
{
    self endon( #"hash_95a419f4e1cd8c1" );
    level endon( #"game_ended" );
    
    while ( isdefined( self.attractor ) && isdefined( self.var_2493d58589b9976 ) )
    {
        a_nearby_zombies = getaiarrayinradius( self.var_2493d58589b9976.origin, 5000, zm_utility::get_zombie_team() );
        var_c317e68aa8ae7038 = [];
        
        foreach ( zombie in a_nearby_zombies )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( zombie.aicategory == "hvt" || zombie.aicategory == "elite" || zombie.aicategory == "special" )
            {
                continue;
            }
            
            if ( !zombie.mantis_boss_fight_add )
            {
                continue;
            }
            
            var_c317e68aa8ae7038[ var_c317e68aa8ae7038.size ] = zombie;
        }
        
        a_base_zombies = [];
        
        foreach ( zombie in var_c317e68aa8ae7038 )
        {
            if ( isdefined( zombie.subclass ) && zombie.subclass != "zombie_methone" )
            {
                a_base_zombies[ a_base_zombies.size ] = zombie;
            }
        }
        
        a_base_zombies = sortbydistance( a_base_zombies, self.var_2493d58589b9976.origin, 0 );
        var_e30137a573592f8e = [];
        
        foreach ( zombie in a_base_zombies )
        {
            var_e30137a573592f8e[ var_e30137a573592f8e.size ] = zombie;
        }
        
        a_new_attackers = [];
        
        for ( i = 0; i < var_e30137a573592f8e.size && a_new_attackers.size < self.var_5911abf1264f0db6 ; i++ )
        {
            zombie = var_e30137a573592f8e[ i ];
            
            if ( !arraycontains( self.var_9524d11c526b9612, zombie ) )
            {
                zombie thread function_4fe154ad5da80d6( self );
            }
            
            zombie val::set( "mantis_boss_fight_twin", "ignore_cleanup", 1 );
            a_new_attackers[ a_new_attackers.size ] = zombie;
        }
        
        self.var_9524d11c526b9612 = a_new_attackers;
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0xa479eaa9, Offset: 0x1751
// Size: 0x62
function function_4fe154ad5da80d6( var_576d220b01160c72 )
{
    self notify( #"hash_fc97505b4752bbf6" );
    self endon( #"hash_fc97505b4752bbf6" );
    self waittill( #"death" );
    
    if ( isdefined( var_576d220b01160c72 ) && isdefined( var_576d220b01160c72.var_9524d11c526b9612 ) )
    {
        var_576d220b01160c72.var_9524d11c526b9612 = arrayremove( var_576d220b01160c72.var_9524d11c526b9612, self );
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0
// Checksum 0xf786a0a0, Offset: 0x17bb
// Size: 0x1a5
function function_d4e54ec76447ee4e()
{
    var_88228f48a187a03a = 100;
    a_players_inside = getplayersinradius( self.origin, var_88228f48a187a03a );
    
    foreach ( player in a_players_inside )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        v_dir_away = vectornormalize( player.origin - self.origin );
        
        if ( lengthsquared( v_dir_away ) <= 0 )
        {
            v_dir_away = ( 0, 1, 0 );
        }
        
        var_b777a21fa7a249c0 = math::function_235fe1fdb403e4b2( v_dir_away, 45 );
        player knockback( var_b777a21fa7a249c0, 500, 1 );
    }
    
    a_zombies_inside = getaiarrayinradius( self.origin, var_88228f48a187a03a, zm_utility::get_zombie_team() );
    
    foreach ( zombie in a_zombies_inside )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        zombie zombie_knockdown::function_6fc167d4a3590991( self.origin, 400, 45 );
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2
// Checksum 0xa16a2176, Offset: 0x1968
// Size: 0x81
function twins_goal_location( attractor, zombie )
{
    proxy = attractor.source;
    
    if ( !isdefined( proxy ) )
    {
        return zombie.origin;
    }
    
    dir_to_zombie = vectornormalize( zombie.origin - proxy.origin );
    goal_pos = proxy.origin + dir_to_zombie * 100;
    return goal_pos;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2
// Checksum 0x8f287a7f, Offset: 0x19f2
// Size: 0x81
function function_3023715435c56ff6( attractor, zombie )
{
    proxy = attractor.source;
    
    if ( !isdefined( proxy ) )
    {
        return zombie.origin;
    }
    
    dir_to_zombie = vectornormalize( zombie.origin - proxy.origin );
    attack_pos = proxy.origin + dir_to_zombie * 60;
    return attack_pos;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2
// Checksum 0x5743ee70, Offset: 0x1a7c
// Size: 0x197
function function_16248599b926f7a3( attractor, zombie )
{
    if ( zombie.aicategory == "hvt" || zombie.aicategory == "elite" || zombie.aicategory == "special" )
    {
        return 0;
    }
    
    proxy = attractor.source;
    
    if ( !isdefined( proxy ) )
    {
        return 0;
    }
    
    var_576d220b01160c72 = undefined;
    
    foreach ( var_ed100f9a07836d02 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        if ( var_ed100f9a07836d02.var_2493d58589b9976 == proxy )
        {
            var_576d220b01160c72 = var_ed100f9a07836d02;
            break;
        }
    }
    
    if ( !isdefined( var_576d220b01160c72 ) )
    {
        return 1;
    }
    
    var_b7581b3aa2f7fc6 = var_576d220b01160c72.origin - zombie.origin;
    
    if ( zombie.enemy )
    {
        angle = math::anglebetweenvectors( var_b7581b3aa2f7fc6, zombie.enemy.origin - zombie.origin );
        
        if ( angle < 30 )
        {
            return 0;
        }
    }
    
    return arraycontains( var_576d220b01160c72.var_9524d11c526b9612, zombie );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1
// Checksum 0x2e7c5ae0, Offset: 0x1c1c
// Size: 0x6c
function function_e7c0e49a6dfb39a1( phase_data )
{
    values = [ phase_data.var_a45451a4855642c3, phase_data.var_a4475fa485484d08, phase_data.var_a44b65a4854c5011, phase_data.var_a46163a485647ede ];
    return values[ clamp( level.players.size, 1, 4 ) - 1 ];
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0x4c0a91b5, Offset: 0x1c91
// Size: 0x57
function private function_55722f30e86c3340( phase_name )
{
    level endon( #"game_ended" );
    level endon( #"end_twins_charge_check" );
    self endon( #"hash_ac9772d9f24de85e" );
    
    if ( phase_name == "phase_2" )
    {
        function_75e426eceaa09c05();
        return;
    }
    
    if ( phase_name == "phase_3" )
    {
        function_8d99d647853e9a4f();
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0xe80465f1, Offset: 0x1cf0
// Size: 0x188
function private function_75e426eceaa09c05()
{
    level endon( #"game_ended" );
    level endon( #"end_twins_charge_check" );
    self endon( #"hash_ac9772d9f24de85e" );
    
    while ( true )
    {
        wait getdvarfloat( @"hash_189f02e4362be76d", 4 );
        
        if ( utility::ent_flag( "twins_interrupted" ) )
        {
            continue;
        }
        
        if ( !isalive( level.s_dark_heart.boss_agent ) )
        {
            continue;
        }
        
        player_radius = getdvarfloat( @"hash_1b9d504fb600c1f4", 600 );
        closest_player = undefined;
        closest_dist = player_radius;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                continue;
            }
            
            dist = distance( player.origin, self.origin );
            
            if ( dist < closest_dist )
            {
                closest_dist = dist;
                closest_player = player;
            }
        }
        
        if ( isdefined( closest_player ) )
        {
            level.s_dark_heart.boss_agent zombie_aeon_fireball::function_c291d57fcba11539( closest_player );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0x5b5c269b, Offset: 0x1e80
// Size: 0x230
function private function_8d99d647853e9a4f()
{
    level endon( #"game_ended" );
    level endon( #"end_twins_charge_check" );
    self endon( #"hash_ac9772d9f24de85e" );
    self endon( #"death" );
    
    while ( true )
    {
        wait getdvarfloat( @"hash_5d3a6cf856329e1", 4 );
        
        if ( utility::ent_flag( "twins_interrupted" ) )
        {
            continue;
        }
        
        if ( !isalive( level.s_dark_heart.boss_agent ) )
        {
            continue;
        }
        
        player_radius = getdvarfloat( @"hash_1b9d504fb600c1f4", 600 );
        var_7d3c1031c8e3dfd7 = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                continue;
            }
            
            if ( distance( player.origin, self.origin ) < player_radius )
            {
                var_7d3c1031c8e3dfd7 = 1;
                break;
            }
        }
        
        if ( !var_7d3c1031c8e3dfd7 )
        {
            continue;
        }
        
        level.s_dark_heart.boss_agent.var_5882e5e64b6302a7 = function_5713d46873b29625( level.s_dark_heart.boss_agent.var_5882e5e64b6302a7 ?? [] );
        
        if ( level.s_dark_heart.boss_agent.var_5882e5e64b6302a7.size > 0 )
        {
            continue;
        }
        
        tornado_radius = getdvarfloat( @"hash_bdd4347ad0cb77bc", 512 );
        spawn_pos = getrandomnavpoint( self.origin, tornado_radius );
        
        if ( isdefined( spawn_pos ) )
        {
            level.s_dark_heart.boss_agent zombie_aeon_flame_tornado::spawn_flame_tornado( spawn_pos, ( 0, 0, 0 ) );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0xa00e8544, Offset: 0x20b8
// Size: 0x1de
function private function_7f95d1e98f031945()
{
    a_uncharged = [];
    
    foreach ( var_ed100f9a07836d02 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        if ( !var_ed100f9a07836d02.var_6eb21481f208c57f )
        {
            a_uncharged[ a_uncharged.size ] = var_ed100f9a07836d02;
        }
    }
    
    var_79568476e3c041 = 999999;
    var_4629425b6bba982f = level.players[ 0 ];
    
    foreach ( player in level.players )
    {
        foreach ( var_ed100f9a07836d02 in a_uncharged )
        {
            var_b6081b1b6ba5e8b5 = distance( player.origin, var_ed100f9a07836d02.origin );
            
            if ( var_b6081b1b6ba5e8b5 < var_79568476e3c041 )
            {
                var_79568476e3c041 = var_b6081b1b6ba5e8b5;
                var_4629425b6bba982f = player;
            }
        }
    }
    
    var_7266749a13485d9f = function_47c86977a18df38b( a_uncharged, var_4629425b6bba982f.origin );
    return var_7266749a13485d9f;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0x681d1e91, Offset: 0x229f
// Size: 0xeb
function private function_5d3e01181b50b579( holdout_spawn )
{
    model = level.s_dark_heart.var_2d7524092817db6;
    origin = undefined;
    
    if ( holdout_spawn )
    {
        origin = holdout_spawn.origin;
    }
    else
    {
        aeon_ground = playerphysicstrace( level.s_dark_heart.boss_agent.origin, level.s_dark_heart.boss_agent.origin - ( 0, 0, 1000 ) );
        origin = aeon_ground;
    }
    
    orb = utility::spawn_model( model, origin, ( 0, 0, 0 ) );
    assert( orb );
    level utility::thread_on_notify( "end_twins_charge_check", &function_134f0235503cab98, orb, orb, "death" );
    return orb;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0xf626f84c, Offset: 0x2393
// Size: 0x3c
function private function_134f0235503cab98()
{
    orb = self;
    orb endon( #"death" );
    orb utility::function_32b24db3127bff40( "base", "off" );
    wait 0.2;
    orb delete();
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0xcd7f2048, Offset: 0x23d7
// Size: 0x543
function private function_b8fb29ed2fbdf605( var_347996ed06f3b3b6 )
{
    self endon( #"death" );
    function_9fbff5eea6552666();
    start_pos = self.origin;
    goal_pos = var_347996ed06f3b3b6.origin + ( 0, 0, self.orb_float_height );
    self.orb_goal_pos = goal_pos;
    self.orb_start_pos = start_pos;
    self.var_b42113496b2ef39d = distance( start_pos, goal_pos );
    self.var_342a3773efbbba86 = 0;
    self.orb_velocity = ( 0, 0, 0 );
    self.orb_start_time = gettime();
    self.var_90223d894055c5cf = goal_pos;
    self.var_f4411affa8adb321 = function_ac9db6eb0771a101( start_pos, goal_pos );
    self.var_6cb21036bc3a353a = 0;
    var_48ee71281f56f926 = gettime();
    
    /#
        thread function_3623514a82882d59();
    #/
    
    while ( true )
    {
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        new_goal = var_347996ed06f3b3b6.origin + ( 0, 0, self.orb_float_height );
        
        if ( distancesquared( new_goal, self.var_90223d894055c5cf ) > 40000 )
        {
            self.orb_goal_pos = new_goal;
            self.var_90223d894055c5cf = new_goal;
            self.var_f4411affa8adb321 = function_ac9db6eb0771a101( self.origin, new_goal );
            self.var_6cb21036bc3a353a = 0;
        }
        
        progress = clamp( self.var_342a3773efbbba86 / self.var_b42113496b2ef39d, 0, 1 );
        target_waypoint = function_b66d1c9caf187370();
        
        if ( !isdefined( target_waypoint ) )
        {
            target_waypoint = self.orb_goal_pos;
        }
        
        dir_to_target = target_waypoint - self.origin;
        var_a95487008e528dc0 = length( dir_to_target );
        
        if ( var_a95487008e528dc0 > 0.1 )
        {
            dir_to_target = vectornormalize( dir_to_target );
        }
        else
        {
            dir_to_target = ( 0, 0, 0 );
        }
        
        target_speed = function_a5ec6ce1deec9546( progress );
        next_waypoint = function_ecbb4943ed884d22();
        
        if ( isdefined( next_waypoint ) && length( self.orb_velocity ) > 0.1 )
        {
            current_dir = vectornormalize( self.orb_velocity );
            next_dir = vectornormalize( next_waypoint - target_waypoint );
            corner_mult = function_56d6de7704dd35ff( current_dir, next_dir );
            target_speed *= corner_mult;
        }
        
        dist_to_goal = distance( self.origin, self.orb_goal_pos );
        stopping_dist = target_speed * target_speed / 2 * self.orb_accel;
        
        if ( dist_to_goal < stopping_dist && stopping_dist > 0 )
        {
            approach_mult = sqrt( dist_to_goal / stopping_dist );
            approach_mult = max( approach_mult, 0.1 );
            target_speed *= approach_mult;
        }
        
        b_observed = function_6ad8ed189e04c33d( var_347996ed06f3b3b6.origin );
        
        if ( !b_observed )
        {
            target_speed *= self.var_29ab7a96cdecafba;
        }
        
        desired_velocity = dir_to_target * target_speed;
        velocity_diff = desired_velocity - self.orb_velocity;
        max_steer = self.orb_accel * dt;
        
        if ( length( velocity_diff ) <= max_steer )
        {
            self.orb_velocity = desired_velocity;
        }
        else
        {
            steer_dir = vectornormalize( velocity_diff );
            self.orb_velocity += steer_dir * max_steer;
        }
        
        current_speed = length( self.orb_velocity );
        
        if ( current_speed > 0.1 )
        {
            current_dir = vectornormalize( self.orb_velocity );
            blended_dir = lerp( current_dir, dir_to_target, self.orb_turn_rate );
            blended_dir = vectornormalize( blended_dir );
            self.orb_velocity = blended_dir * current_speed;
        }
        
        movement = self.orb_velocity * dt;
        wobble_offset = function_5a46a065642663b0( current_time ) * dt;
        bob_offset = function_bb37821d68b19bd4( current_time ) * dt;
        var_a5866773ecfc542c = ( 0, 0, 0 );
        
        if ( !b_observed )
        {
        }
        
        new_pos = self.origin + movement + wobble_offset + bob_offset + var_a5866773ecfc542c;
        bounce_result = function_8958569b9d068f64( self.origin, new_pos );
        new_pos = bounce_result.position;
        
        if ( bounce_result.bounced )
        {
            self.orb_velocity = bounce_result.velocity;
        }
        
        self.var_342a3773efbbba86 += distance( self.origin, new_pos );
        self.origin = new_pos;
        function_c725c45a74c00b8c();
        
        if ( var_a95487008e528dc0 < 100 )
        {
            self.var_6cb21036bc3a353a++;
        }
        
        if ( distance2d( self.origin, self.orb_goal_pos ) < 30 )
        {
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0xf3c0188d, Offset: 0x2922
// Size: 0x301
function private function_9fbff5eea6552666()
{
    settings = level.s_dark_heart;
    self.orb_base_speed = getdvarfloat( @"hash_c61440b63331a053", settings.var_d07e037c6b464a34 ?? 200 );
    self.orb_max_speed = getdvarfloat( @"hash_95ffaeadf1b55b54", settings.var_866c19b01728299d ?? 600 );
    self.orb_accel = getdvarfloat( @"hash_bfeb599b5a71279a", settings.var_ed986d78eb317490 ?? 150 );
    self.orb_turn_rate = getdvarfloat( @"hash_f714e1844f75abe0", settings.var_ac3a72eca9614929 ?? 0.3 );
    self.var_7eaf88aa07ce3d3b = getdvarfloat( @"hash_1a593786a16118a5", settings.var_e6ce268bfd284469 ?? 0.4 );
    self.var_cb1731eb6ddc8fee = getdvarfloat( @"hash_b46703caa47553e8", settings.var_e3c2ac9fcfd8c969 ?? 0.6 );
    self.var_5094bacba8c0637c = getdvarfloat( @"hash_feac15967c65e2d6", settings.var_aef1ddbdd1302ad ?? 80 );
    self.var_fb71e00274dd3a4c = getdvarfloat( @"hash_781fba67fe9394a2", settings.var_f669562d26db78fb ?? 0.2 );
    self.orb_float_height = getdvarfloat( @"hash_9ba70bc61b3364b2", settings.var_5a7fba6ed06b555 ?? 80 );
    self.var_ef3e5fd7b18a89ff = getdvarfloat( @"hash_441213e90d43cd85", settings.var_51b0a88b4cbc8abd ?? 80 );
    self.var_1de537e5e0b5ca81 = getdvarfloat( @"hash_b1331d2ec5b3af73", settings.var_80b660108d58f4b ?? 0.3 );
    self.var_c5d0730663f8c8e0 = getdvarfloat( @"hash_3e42d783997995a6", settings.var_ebe0609bbd5a07fb ?? 300 );
    self.var_15ebf1b04a316c80 = getdvarfloat( @"hash_9b19112f5bc4b442", settings.var_44377bd2d6893340 ?? 600 );
    self.var_662b2523f10998fa = getdvarfloat( @"hash_e309d46c21557550", settings.var_b57ab356d9dfe739 ?? 0.5 );
    self.var_29ab7a96cdecafba = getdvarfloat( @"hash_a589e6237b4a26a8", settings.var_80e2f41143cffee8 ?? 0.3 );
    self.var_b79c2ee82ed858cc = getdvarfloat( @"hash_f6a579b62ef1ffe6", settings.var_19e016cb93c64f32 ?? 250 );
    self.orb_knockdown_radius = getdvarfloat( @"hash_ad60fe5279c4e849", settings.var_3df2fc04bcb8c892 ?? 80 );
    self.var_6a1aa65966401791 = getdvarfloat( @"hash_99ce1cd9060fd767", settings.var_f65206af4898988a ?? 200 );
    self.var_673f87f906d5598a = getdvarfloat( @"hash_3fedfbad0e97aba4", settings.var_b318cf494148e84a ?? 45 );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2, eflags: 0x4
// Checksum 0x2b61193f, Offset: 0x2c2b
// Size: 0x23b
function private function_ac9db6eb0771a101( start_pos, goal_pos )
{
    dist_to_goal = distance( start_pos, goal_pos );
    var_acd1d0de24cfedd6 = dist_to_goal < 500 ? dist_to_goal / 10 : 50;
    var_acd1d0de24cfedd6 = max( var_acd1d0de24cfedd6, 20 );
    start_nav = getclosestpointonnavmesh( start_pos, start_pos, 500 );
    goal_nav = getclosestpointonnavmesh( goal_pos, goal_pos, 500 );
    
    if ( !isdefined( start_nav ) )
    {
        start_nav = start_pos;
    }
    
    if ( !isdefined( goal_nav ) )
    {
        goal_nav = goal_pos;
    }
    
    spline_points = self findsplinepath( start_nav, goal_nav, 200, 200, var_acd1d0de24cfedd6, ( 0, 0, 0 ), ( 0, 0, 0 ), 100, 0.25, 0, "small_veh_jump", undefined, 0, 2 );
    
    if ( !isdefined( spline_points ) || spline_points.size <= 2 )
    {
        spline_points = [];
        num_points = int( dist_to_goal / 100 );
        num_points = clamp( num_points, 3, 128 );
        
        for ( i = 0; i <= num_points ; i++ )
        {
            t = i / float( num_points );
            point = lerp( start_pos, goal_pos, t );
            height_offset = i == num_points ? self.orb_float_height * 0.5 : self.orb_float_height;
            point = ( point[ 0 ], point[ 1 ], point[ 2 ] + height_offset );
            spline_points[ spline_points.size ] = point;
        }
        
        return spline_points;
    }
    
    if ( spline_points.size >= 128 )
    {
        spline_points = utility::array_slice( spline_points, 0, 127 );
    }
    
    adjusted_points = [];
    last_index = spline_points.size - 1;
    
    for ( i = 0; i < spline_points.size ; i++ )
    {
        point = spline_points[ i ];
        
        if ( isdefined( point ) )
        {
            height_offset = i == last_index ? self.orb_float_height * 0.5 : self.orb_float_height;
            adjusted_point = ( point[ 0 ], point[ 1 ], point[ 2 ] + height_offset );
            adjusted_points[ adjusted_points.size ] = adjusted_point;
        }
    }
    
    last_point = adjusted_points[ adjusted_points.size - 1 ];
    adjusted_points[ adjusted_points.size ] = ( goal_pos[ 0 ], goal_pos[ 1 ], last_point[ 2 ] );
    return adjusted_points;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0xb461360f, Offset: 0x2e6f
// Size: 0x54
function private function_b66d1c9caf187370()
{
    if ( !isdefined( self.var_f4411affa8adb321 ) || self.var_f4411affa8adb321.size == 0 )
    {
        return;
    }
    
    index = clamp( self.var_6cb21036bc3a353a, 0, self.var_f4411affa8adb321.size - 1 );
    return self.var_f4411affa8adb321[ index ];
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0x802a36c7, Offset: 0x2ecc
// Size: 0x56
function private function_ecbb4943ed884d22()
{
    if ( !isdefined( self.var_f4411affa8adb321 ) || self.var_f4411affa8adb321.size == 0 )
    {
        return;
    }
    
    index = self.var_6cb21036bc3a353a + 1;
    
    if ( index >= self.var_f4411affa8adb321.size )
    {
        return;
    }
    
    return self.var_f4411affa8adb321[ index ];
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0x594e0284, Offset: 0x2f2b
// Size: 0x48
function private function_a5ec6ce1deec9546( progress )
{
    speed_mult = sin( progress * 180 );
    speed_mult = max( speed_mult, 0.2 );
    return math::lerp( self.orb_base_speed, self.orb_max_speed, speed_mult );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2, eflags: 0x4
// Checksum 0xc29511b5, Offset: 0x2f7c
// Size: 0x42
function private function_56d6de7704dd35ff( current_dir, next_dir )
{
    dot = vectordot( current_dir, next_dir );
    return math::remap( dot, -1, 1, self.var_7eaf88aa07ce3d3b, 1 );
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0x71a9d607, Offset: 0x2fc7
// Size: 0x166
function private function_5a46a065642663b0( current_time )
{
    current_speed = length( self.orb_velocity );
    
    if ( current_speed < 1 )
    {
        return ( 0, 0, 0 );
    }
    
    var_4e09b54e3981b420 = vectornormalize( self.orb_velocity );
    var_8b69ebbd466a77c7 = vectorcross( var_4e09b54e3981b420, ( 0, 0, 1 ) );
    
    if ( length( var_8b69ebbd466a77c7 ) < 0.1 )
    {
        var_8b69ebbd466a77c7 = vectorcross( var_4e09b54e3981b420, ( 1, 0, 0 ) );
    }
    
    var_8b69ebbd466a77c7 = vectornormalize( var_8b69ebbd466a77c7 );
    speed_range = self.orb_max_speed - self.orb_base_speed;
    
    if ( speed_range > 0 )
    {
        speed_ratio = ( current_speed - self.orb_base_speed ) / speed_range;
        speed_ratio = clamp( speed_ratio, 0, 1 );
        freq_scale = 0.2 + speed_ratio * 0.8;
    }
    else
    {
        freq_scale = 1;
    }
    
    time_s = ( current_time - self.orb_start_time ) / 1000;
    scaled_freq = self.var_fb71e00274dd3a4c * freq_scale;
    wobble_phase = time_s * scaled_freq * 360;
    wobble_offset = var_8b69ebbd466a77c7 * sin( wobble_phase ) * self.var_5094bacba8c0637c;
    return wobble_offset;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0xcaab4c7, Offset: 0x3136
// Size: 0xf0
function private function_bb37821d68b19bd4( current_time )
{
    current_speed = length( self.orb_velocity );
    speed_range = self.orb_max_speed - self.orb_base_speed;
    
    if ( speed_range > 0 )
    {
        speed_ratio = ( current_speed - self.orb_base_speed ) / speed_range;
        speed_ratio = clamp( speed_ratio, 0, 1 );
        freq_scale = 0.2 + speed_ratio * 0.8;
    }
    else
    {
        freq_scale = 1;
    }
    
    time_s = ( current_time - self.orb_start_time ) / 1000;
    scaled_freq = self.var_1de537e5e0b5ca81 * freq_scale;
    bob_phase = time_s * scaled_freq * 360;
    bob_offset = ( 0, 0, sin( bob_phase ) * self.var_ef3e5fd7b18a89ff );
    return bob_offset;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2, eflags: 0x4
// Checksum 0x82369d27, Offset: 0x322f
// Size: 0x119
function private function_dfd77d6c755c8f2f( current_time, dir_to_goal )
{
    time_s = ( current_time - self.orb_start_time ) / 1000;
    freq = 0.15;
    amplitude = 100;
    phase = time_s * freq * 360;
    
    if ( length( dir_to_goal ) < 0.1 )
    {
        return ( 0, 0, 0 );
    }
    
    var_dc6b0f6e8da7c9f0 = vectornormalize( dir_to_goal );
    var_8b69ebbd466a77c7 = vectorcross( var_dc6b0f6e8da7c9f0, ( 0, 0, 1 ) );
    
    if ( length( var_8b69ebbd466a77c7 ) < 0.1 )
    {
        var_8b69ebbd466a77c7 = vectorcross( var_dc6b0f6e8da7c9f0, ( 1, 0, 0 ) );
    }
    
    var_8b69ebbd466a77c7 = vectornormalize( var_8b69ebbd466a77c7 );
    local_x = sin( phase ) * amplitude;
    local_z = sin( phase * 2 ) * amplitude * 0.5;
    offset = var_8b69ebbd466a77c7 * local_x + ( 0, 0, local_z );
    return offset;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 1, eflags: 0x4
// Checksum 0x9b4087e2, Offset: 0x3351
// Size: 0x14e, Type: bool
function private function_6ad8ed189e04c33d( holdout_pos )
{
    var_d7cb9e828056b254 = distance( self.origin, holdout_pos );
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        var_7e80951ba23b9b78 = distance( player.origin, self.origin );
        var_41089c54e7ced04e = distance( player.origin, holdout_pos );
        var_8b295775035496d7 = var_41089c54e7ced04e < var_d7cb9e828056b254;
        
        if ( var_8b295775035496d7 || var_7e80951ba23b9b78 <= self.var_c5d0730663f8c8e0 )
        {
            if ( player math::point_in_fov( self.origin, self.var_662b2523f10998fa, 1 ) )
            {
                return true;
            }
        }
        
        if ( var_41089c54e7ced04e <= self.var_15ebf1b04a316c80 )
        {
            if ( player math::point_in_fov( holdout_pos, self.var_662b2523f10998fa, 1 ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 0, eflags: 0x4
// Checksum 0xc5131fb5, Offset: 0x34a8
// Size: 0x107
function private function_c725c45a74c00b8c()
{
    current_speed = length( self.orb_velocity );
    
    if ( current_speed < self.var_b79c2ee82ed858cc )
    {
        return;
    }
    
    zombies = getaiarrayinradius( self.origin, self.orb_knockdown_radius + self.orb_float_height, zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie zombie_knockdown::function_99b2020a564d9c7e( self.origin ) )
        {
            zombie zombie_knockdown::function_6fc167d4a3590991( self.origin, self.var_6a1aa65966401791, self.var_673f87f906d5598a );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight_twins
// Params 2, eflags: 0x4
// Checksum 0x5c608abd, Offset: 0x35b7
// Size: 0x18e
function private function_8958569b9d068f64( old_pos, new_pos )
{
    result = spawnstruct();
    result.position = new_pos;
    result.velocity = self.orb_velocity;
    result.bounced = 0;
    trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
    trace_result = trace::ray_trace( old_pos, new_pos, self, trace_contents );
    
    if ( trace_result[ "fraction" ] < 1 )
    {
        result.bounced = 1;
        hit_pos = trace_result[ "position" ];
        var_3cb607c143ecc1a3 = trace_result[ "normal" ];
        
        if ( !isdefined( var_3cb607c143ecc1a3 ) || length( var_3cb607c143ecc1a3 ) < 0.1 )
        {
            result.velocity = self.orb_velocity * self.var_cb1731eb6ddc8fee * -1;
            result.position = old_pos;
            return result;
        }
        
        var_4b93e11d422da79d = vectordot( self.orb_velocity, var_3cb607c143ecc1a3 );
        reflected_vel = self.orb_velocity - var_3cb607c143ecc1a3 * 2 * var_4b93e11d422da79d;
        result.velocity = reflected_vel * self.var_cb1731eb6ddc8fee;
        result.position = hit_pos + var_3cb607c143ecc1a3 * 10;
        
        /#
            if ( getdvarint( @"hash_9a1170c932afb4ad" ) )
            {
                iprintln( "<dev string:x24>" );
            }
        #/
    }
    
    return result;
}

/#

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 0, eflags: 0x4
    // Checksum 0x9a9989fc, Offset: 0x374e
    // Size: 0x28c, Type: dev
    function private function_3623514a82882d59()
    {
        self endon( #"death" );
        color_orb = ( 0, 1, 1 );
        color_velocity = ( 1, 1, 0 );
        color_waypoint = ( 0, 1, 0 );
        color_path = ( 0.5, 0.5, 1 );
        color_goal = ( 1, 0, 0 );
        
        while ( true )
        {
            if ( !getdvarint( @"hash_9a1170c932afb4ad" ) )
            {
                waitframe();
                continue;
            }
            
            sphere( self.origin, 30, color_orb );
            
            if ( length( self.orb_velocity ) > 0.1 )
            {
                vel_end = self.origin + vectornormalize( self.orb_velocity ) * 100;
                line( self.origin, vel_end, color_velocity, 1 );
            }
            
            current_wp = function_b66d1c9caf187370();
            
            if ( isdefined( current_wp ) )
            {
                sphere( current_wp, 20, color_waypoint );
                line( self.origin, current_wp, color_waypoint, 1 );
            }
            
            if ( isdefined( self.var_f4411affa8adb321 ) && self.var_f4411affa8adb321.size > 1 )
            {
                for ( i = 0; i < self.var_f4411affa8adb321.size - 1 ; i++ )
                {
                    if ( isdefined( self.var_f4411affa8adb321[ i ] ) && isdefined( self.var_f4411affa8adb321[ i + 1 ] ) )
                    {
                        line( self.var_f4411affa8adb321[ i ], self.var_f4411affa8adb321[ i + 1 ], color_path, 1 );
                    }
                }
            }
            
            if ( isdefined( self.orb_goal_pos ) )
            {
                sphere( self.orb_goal_pos, 40, color_goal );
            }
            
            progress = clamp( self.var_342a3773efbbba86 / self.var_b42113496b2ef39d, 0, 1 );
            speed = length( self.orb_velocity );
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x40>" + int( progress * 100 ) + "<dev string:x4b>", color_orb, 1, 0.8, 1, 1 );
            print3d( self.origin + ( 0, 0, 45 ), "<dev string:x4d>" + int( speed ), color_velocity, 1, 0.8, 1, 1 );
            waitframe();
        }
    }

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 0
    // Checksum 0x5ae634c1, Offset: 0x39e2
    // Size: 0x58, Type: dev
    function function_f482f48de1d461b0()
    {
        current = getdvarint( @"hash_9a1170c932afb4ad", 0 );
        new_value = !current;
        setdvar( @"hash_9a1170c932afb4ad", new_value );
        
        if ( new_value )
        {
            iprintlnbold( "<dev string:x55>" );
            return;
        }
        
        iprintlnbold( "<dev string:x6a>" );
    }

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 0
    // Checksum 0xf7e1baae, Offset: 0x3a42
    // Size: 0x98, Type: dev
    function function_9f561d4f4d60fb3a()
    {
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            level utility::flag_set( var_576d220b01160c72.script_noteworthy + "<dev string:x80>" );
        }
    }

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 0
    // Checksum 0xe5f67202, Offset: 0x3ae2
    // Size: 0x65, Type: dev
    function function_e98f3fbae03fdc2d()
    {
        if ( !isdefined( level.var_824316f467dd5eab ) )
        {
            level.var_824316f467dd5eab = 0;
        }
        
        level.var_824316f467dd5eab = !level.var_824316f467dd5eab;
        
        if ( level.var_824316f467dd5eab )
        {
            iprintlnbold( "<dev string:x8f>" );
            level thread function_e94a01f58b3eed49();
            return;
        }
        
        iprintlnbold( "<dev string:xa7>" );
        level notify( #"hash_8424a1fb4970aa6a" );
    }

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 0, eflags: 0x4
    // Checksum 0xcf3a4815, Offset: 0x3b4f
    // Size: 0x48e, Type: dev
    function private function_e94a01f58b3eed49()
    {
        level endon( #"game_ended" );
        level endon( #"hash_8424a1fb4970aa6a" );
        color_uncharged = ( 0, 1, 0 );
        color_charging = ( 1, 1, 0 );
        color_charged = ( 1, 0, 0 );
        color_cooldown = ( 1, 0.5, 0 );
        color_selected = ( 0, 1, 1 );
        color_distance = ( 1, 1, 1 );
        color_twins_pos = ( 1, 0, 1 );
        
        while ( true )
        {
            if ( !isdefined( level.s_dark_heart ) || !isdefined( level.s_dark_heart.var_dd5147eb36a3795b ) )
            {
                waitframe();
                continue;
            }
            
            foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
            {
                var_cf861766ba2efd44 = "<dev string:xc0>";
                var_c9e35826ee79c05c = color_uncharged;
                str_cooldown_time = "<dev string:xca>";
                
                if ( var_576d220b01160c72.var_6eb21481f208c57f )
                {
                    var_cf861766ba2efd44 = "<dev string:xcb>";
                    var_c9e35826ee79c05c = color_charged;
                }
                else if ( isdefined( var_576d220b01160c72.n_cooldown_start_time ) && isdefined( var_576d220b01160c72.n_cooldown_duration ) )
                {
                    n_elapsed = ( gettime() - var_576d220b01160c72.n_cooldown_start_time ) / 1000;
                    var_b086e76cb5b8559f = var_576d220b01160c72.n_cooldown_duration - n_elapsed;
                    
                    if ( var_b086e76cb5b8559f < 0 )
                    {
                        var_b086e76cb5b8559f = 0;
                    }
                    
                    var_cf861766ba2efd44 = "<dev string:xd3>";
                    str_cooldown_time = "<dev string:xdf>" + int( var_b086e76cb5b8559f ) + "<dev string:xe2>";
                    var_c9e35826ee79c05c = color_cooldown;
                }
                else if ( isdefined( var_576d220b01160c72.var_2493d58589b9976 ) )
                {
                    var_cf861766ba2efd44 = "<dev string:xe5>";
                    var_c9e35826ee79c05c = color_charging;
                }
                
                sphere( var_576d220b01160c72.origin, 30, var_c9e35826ee79c05c );
                print3d( var_576d220b01160c72.origin + ( 0, 0, 80 ), var_576d220b01160c72.script_noteworthy + "<dev string:xee>" + var_cf861766ba2efd44 + "<dev string:xf1>" + str_cooldown_time, var_c9e35826ee79c05c, 1, 1, 1, 1 );
                var_b27479b9bddaae8c = 60;
                
                foreach ( player in level.players )
                {
                    var_b6081b1b6ba5e8b5 = int( distance( player.origin, var_576d220b01160c72.origin ) );
                    print3d( var_576d220b01160c72.origin + ( 0, 0, var_b27479b9bddaae8c ), "<dev string:xf3>" + player getentitynumber() + "<dev string:xf5>" + var_b6081b1b6ba5e8b5 + "<dev string:xf8>", color_distance, 1, 0.7, 1, 1 );
                    var_b27479b9bddaae8c -= 12;
                }
                
                if ( isdefined( var_576d220b01160c72.twins_positions ) )
                {
                    foreach ( var_57a91cb59fdf08bf in var_576d220b01160c72.twins_positions )
                    {
                        var_89a5574cb340ced7 = color_twins_pos;
                        
                        if ( var_576d220b01160c72.current_scene_struct == var_57a91cb59fdf08bf )
                        {
                            var_89a5574cb340ced7 = color_selected;
                            print3d( var_57a91cb59fdf08bf.origin + ( 0, 0, 30 ), "<dev string:xff>", var_89a5574cb340ced7, 1, 0.8, 1, 1 );
                        }
                        
                        sphere( var_57a91cb59fdf08bf.origin, 15, var_89a5574cb340ced7 );
                        line( var_576d220b01160c72.origin, var_57a91cb59fdf08bf.origin, var_89a5574cb340ced7 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 0
    // Checksum 0xd1a09c20, Offset: 0x3fe5
    // Size: 0x197, Type: dev
    function function_47f12e7413a9f3ba()
    {
        if ( !isdefined( level.s_dark_heart ) || !isdefined( level.s_dark_heart.var_dd5147eb36a3795b ) )
        {
            iprintlnbold( "<dev string:x106>" );
            return;
        }
        
        if ( !isdefined( level.players ) || level.players.size == 0 )
        {
            iprintlnbold( "<dev string:x128>" );
            return;
        }
        
        player_origin = level.players[ 0 ].origin;
        var_16977da367f2ad2 = level.s_dark_heart.var_dd5147eb36a3795b;
        closest_holdout = undefined;
        closest_dist_sq = 999999999;
        
        foreach ( s_holdout in var_16977da367f2ad2 )
        {
            dist_sq = distancesquared( player_origin, s_holdout.origin );
            
            if ( dist_sq < closest_dist_sq )
            {
                closest_dist_sq = dist_sq;
                closest_holdout = s_holdout;
            }
        }
        
        if ( !isdefined( closest_holdout ) )
        {
            iprintlnbold( "<dev string:x140>" );
            return;
        }
        
        spirit_orb = function_5d3e01181b50b579( undefined );
        spirit_orb thread function_b8fb29ed2fbdf605( closest_holdout );
        iprintlnbold( "<dev string:x159>" + closest_holdout.script_noteworthy );
        level thread function_e3747d32e4d50bca( spirit_orb, closest_holdout );
    }

    // Namespace zm_sat_mantis_boss_fight_twins
    // Params 2, eflags: 0x4
    // Checksum 0x59d42c14, Offset: 0x4184
    // Size: 0x62, Type: dev
    function private function_e3747d32e4d50bca( spirit_orb, target_holdout )
    {
        level endon( #"game_ended" );
        
        while ( isdefined( spirit_orb ) )
        {
            if ( distance2d( spirit_orb.origin, target_holdout.origin ) < 30 )
            {
                spirit_orb thread function_134f0235503cab98();
                iprintlnbold( "<dev string:x178>" );
                return;
            }
            
            waitframe();
        }
    }

#/
