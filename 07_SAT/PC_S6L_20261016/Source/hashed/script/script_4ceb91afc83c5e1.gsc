// script_4ceb91afc83c5e1  (hash_04ceb91afc83c5e1.gscc) (size: 21217 Bytes / 0x52e1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88080fda (2282229722)
// size ...... 21217 (0x52e1)
// includes .. 28  (offset: 0x4e75)
// strings ... 62  (offset: 0x4f55)
// dev strs .. 6   (offset: 0x5299)
// exports ... 50  (offset: 0x3359)
// cseg ...... 0x5bc + 0x2d9d (0x3359)
// imports ... 158 (offset: 0x3b29)
// animtree1 . 0   (offset: 0x52e1)
// animtree2 . 0   (offset: 0x52e1)
#using script_16ea1b94f0f381b3;
#using script_7fb33ffa16b6839a;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\challenges\zombie_challenges;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_1fd313b1d0d63e6b;

// Namespace namespace_1fd313b1d0d63e6b
// Params 3
// Checksum 0xbb35e87a, Offset: 0x5da
// Size: 0x196
function spawn_hvt( ai_subclass_request, b_death_callback, round_difficulty )
{
    level endon( #"game_ended" );
    round_number = ( round_difficulty ?? zm_round_logic::get_rb_round_number() ) + 5;
    hvt = undefined;
    var_70a304b26d846d76 = 0.1;
    str_subclass = ai_subclass_request ?? utility::array_random( level.var_8bf06892f4be21c );
    ai_type = function_b3988325430ce242( str_subclass );
    var_cfdcb332178e0755 = zone_manager::get_active_zones();
    
    while ( !isdefined( hvt ) )
    {
        hvt = zone_spawner::spawn_agent( ai_type, { #zones:var_cfdcb332178e0755 } );
        waitframe();
        
        if ( hvt )
        {
            var_804bd022dd245b4a = b_death_callback ?? &function_881c1283d63accd6;
            hvt callback::add( #"on_ai_killed", var_804bd022dd245b4a );
            hvt zombie_utils::set_zombie_round_difficulty( round_number );
            hvt.var_a13bed1ac47e1b2c = 1;
            hvt.no_powerups = 1;
            hvt.var_15598d8e493afe88 = 1;
            hvt.b_cleanup_no_respawn = 1;
            hvt.var_825b17c932865df = 1;
            hvt.var_7ee152b43c7188e1 = 1;
            hvt.ignore_enemy_count = 1;
            
            if ( hvt.subclass == "zombie_viper_hvt" || hvt.subclass == "zombie_viper" )
            {
                hvt.var_c3746c711044489d = 1;
            }
            
            return hvt;
        }
        
        wait var_70a304b26d846d76;
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1
// Checksum 0x7083f054, Offset: 0x778
// Size: 0x19
function function_881c1283d63accd6( params )
{
    level utility::flag_set( "echo_challenge_complete" );
}

/#

    // Namespace namespace_1fd313b1d0d63e6b
    // Params 0
    // Checksum 0x79a168d3, Offset: 0x799
    // Size: 0x63, Type: dev
    function function_d3a5a539b3bb20e1()
    {
        while ( !getdvarint( @"hash_18098f3d9168a1cb", 0 ) )
        {
            wait 1;
        }
        
        level utility::flag_wait( "<dev string:x24>" );
        zm_round_spawning::pause_round_spawning( 1, "<dev string:x36>" );
        
        while ( true )
        {
            var_7654d704b9415bab = function_69c35de57141be08();
            var_7654d704b9415bab waittill( #"death" );
            wait 30;
        }
    }

#/

// Namespace namespace_1fd313b1d0d63e6b
// Params 0
// Checksum 0x770280ca, Offset: 0x804
// Size: 0x1b5
function function_4af0d452f670d77b()
{
    level endon( #"game_ended" );
    boss = spawn_hvt( "zombie_ghoul_hvt_echo", &function_f11715a475963b16, 40 );
    boss callback::add( #"on_ai_killed", &function_14846c33c42e3fa1 );
    function_4dfb202240ea2d44( #"hash_acacfa10b880f9c0" );
    level.var_9c0d12c8f8edeb3d = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    level.s_game_over_scene_override = spawnstruct();
    level.s_game_over_scene_override.origin = ( 46504, -354, 12 );
    level.s_game_over_scene_override.angles = ( 0, 0, 0 );
    level thread function_722953bfc26da496();
    level thread function_96d329e01ffc873( boss );
    level utility::flag_wait( "echo_challenge_complete" );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    
    foreach ( player in level.players )
    {
        player notify( #"cleanup_doppelgas_ai" );
    }
    
    function_54207e09f68a2299( boss );
    wait 3;
    
    if ( level.var_f55a0f728c0b515f )
    {
        zm_round_spawning::pause_round_spawning( 1, "last hvt killed" );
        zm_round_spawning::pause_round_spawning( 0, "echo_boss_fight_adds" );
        level thread function_efe34afb95b8c847();
        return;
    }
    
    zm_round_spawning::pause_round_spawning( 0, "echo_boss_fight_adds" );
    zm_round_logic::function_895fdc21ab019efe();
    function_15973947e8d92140();
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0
// Checksum 0xeea104a2, Offset: 0x9c1
// Size: 0x9a
function function_722953bfc26da496()
{
    while ( !level utility::flag( "echo_challenge_complete" ) )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                function_69c35de57141be08( player );
            }
        }
        
        wait 30;
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x40558241, Offset: 0xa63
// Size: 0x20
function private function_f11715a475963b16( params )
{
    function_d690ddb7282b79d6();
    level utility::flag_set( "echo_challenge_complete" );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0
// Checksum 0xe8182c10, Offset: 0xa8b
// Size: 0x71
function function_d690ddb7282b79d6()
{
    level.var_592e0ef82d974fe7++;
    
    /#
        iprintlnbold( "<dev string:x43>" + level.var_592e0ef82d974fe7 + "<dev string:x5f>" + level.var_bcdcacffcfacfe95 + "<dev string:x61>" );
    #/
    
    if ( level.var_592e0ef82d974fe7 >= level.var_bcdcacffcfacfe95 )
    {
        level.var_cf5927ac4c367a67 = 0;
        level.var_f55a0f728c0b515f = 1;
        
        /#
            iprintlnbold( "<dev string:x63>" );
        #/
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xaa2b9eeb, Offset: 0xb04
// Size: 0x178
function private function_efe34afb95b8c847()
{
    level endon( #"game_ended" );
    function_4dfb202240ea2d44( #"hash_fa9503c32f7104a4" );
    wait 5;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player zm_exfil::function_8f261015e4f861ae( 1 );
        }
    }
    
    level callback::callback( "zm_exfil_success" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            level utility::delaythreadendon( 0.25, "disconnect", &game_utility::fadetoblackforplayerkeepui, player, 0, 0.25 );
        }
    }
    
    wait 0.5;
    level.b_zm_game_over = 1;
    level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xdeee02d4, Offset: 0xc84
// Size: 0x205
function private function_15973947e8d92140()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        v_origin = player.origin;
        a_random_points = getrandomnavpoints( v_origin, 200, 3 );
        
        foreach ( var_5fb4fe43f49ba675 in a_random_points )
        {
            level thread powerups::powerup_drop( "bonus_points_team", var_5fb4fe43f49ba675 + ( 0, 0, 10 ), undefined, undefined, "quest" );
        }
        
        weapon = player getcurrentweapon();
        
        if ( !isdefined( weapon ) || weapon == level.weaponnone )
        {
            continue;
        }
        
        if ( randomint( 2 ) == 0 )
        {
            if ( player pack_a_punch::can_pap( weapon ) )
            {
                n_current_level = player pack_a_punch::get_pap_level( weapon );
                
                if ( n_current_level < 3 )
                {
                    n_target_level = n_current_level + 1;
                    player pack_a_punch::pap_weapon( weapon, n_current_level, undefined, undefined, undefined, undefined, undefined, n_target_level );
                    continue;
                }
            }
            
            player function_8cb236deb28cfac9( weapon );
            continue;
        }
        
        if ( !player function_8cb236deb28cfac9( weapon ) )
        {
            if ( player pack_a_punch::can_pap( weapon ) )
            {
                n_current_level = player pack_a_punch::get_pap_level( weapon );
                
                if ( n_current_level < 3 )
                {
                    n_target_level = n_current_level + 1;
                    player pack_a_punch::pap_weapon( weapon, n_current_level, undefined, undefined, undefined, undefined, undefined, n_target_level );
                }
            }
        }
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x50ab1eaa, Offset: 0xe91
// Size: 0x6a, Type: bool
function private function_8cb236deb28cfac9( weapon )
{
    if ( weapon::isfistweapon( weapon ) || weapon::iskillstreakweapon( weapon ) || weapon::iswonderweapon( weapon ) )
    {
        return false;
    }
    
    rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
    
    if ( rarity >= 4 )
    {
        return false;
    }
    
    var_7c0d29caa7b948c6 = rarity + 1;
    item_weapon::function_40e1cbd0e1f47d1a( weapon, var_7c0d29caa7b948c6 );
    return true;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0
// Checksum 0xa52ee772, Offset: 0xf04
// Size: 0x4f
function function_1682ed43380d6452()
{
    utility::flag_wait( "equipment_initialized" );
    equipment_mp::registercallback( "equip_gas_grenade_doppelgas", "onPlayerDamaged", &function_44f3167d0cb50b02 );
    
    if ( !isdefined( level.scripted_damage_override ) )
    {
        level.scripted_damage_override = [];
    }
    
    level.scripted_damage_override[ "doppelgas" ] = &function_ee565b9345d41bc5;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x4dc5ab9c, Offset: 0xf5b
// Size: 0x118
function private function_69c35de57141be08( player )
{
    level endon( #"game_ended" );
    round_number = zm_round_logic::get_rb_round_number();
    var_52c0369e7d25a237 = 0.1;
    ai_type = function_b3988325430ce242( "zombie_ghoul" );
    var_cfdcb332178e0755 = zone_manager::get_active_zones();
    var_7654d704b9415bab = undefined;
    
    while ( !isdefined( var_7654d704b9415bab ) )
    {
        var_7654d704b9415bab = zone_spawner::spawn_agent( ai_type, { #zones:var_cfdcb332178e0755 } );
        waitframe();
        
        if ( var_7654d704b9415bab )
        {
            var_7654d704b9415bab zombie_utils::set_zombie_round_difficulty( round_number );
            var_7654d704b9415bab.var_a13bed1ac47e1b2c = 1;
            var_7654d704b9415bab.no_powerups = 1;
            var_7654d704b9415bab.var_15598d8e493afe88 = 1;
            var_7654d704b9415bab.b_cleanup_no_respawn = 1;
            var_7654d704b9415bab.var_825b17c932865df = 1;
            var_7654d704b9415bab.ignore_enemy_count = 1;
            var_7654d704b9415bab.forceannihilate = 1;
            var_7654d704b9415bab ai::set_ai_max_health( 1000 );
            var_7654d704b9415bab thread function_7eceb02483edd008( player );
            return var_7654d704b9415bab;
        }
        
        wait var_52c0369e7d25a237;
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xa32be7b8, Offset: 0x107b
// Size: 0xe7
function private function_7eceb02483edd008( player )
{
    self endon( #"death" );
    
    if ( isdefined( player ) )
    {
        zombie_utils::set_ai_target_priority( player, "zm_echo_boss" );
    }
    
    while ( true )
    {
        if ( isplayer( self.enemy ) )
        {
            n_distance = distancesquared( self.origin, self.enemy.origin );
            
            if ( n_distance < 4096 )
            {
                grenade = namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( level.equipment.table[ "equip_gas_grenade_doppelgas" ].objweapon, self.origin, ( 0, 0, 0 ) );
                
                if ( grenade )
                {
                    grenade detonate();
                }
                
                self dodamage( self.maxhealth, self.origin );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x573797c3, Offset: 0x116a
// Size: 0xfc
function private function_44f3167d0cb50b02( data )
{
    bundle = level.equipment.table[ "equip_gas_grenade_doppelgas" ].bundle;
    
    if ( !bundle )
    {
        return;
    }
    
    data.victim endon( #"death_or_disconnect" );
    
    if ( data.victim.var_4d71b356f97bb810 )
    {
        return;
    }
    
    data.victim.var_4d71b356f97bb810 = 1;
    thread gas_grenade::gas_onplayerdamaged( data );
    data.victim thread gas_grenade::gas_applyblur( bundle );
    data.victim thread function_cd53009b9482ddfe();
    data.victim thread utility::delay_notify( 30, "cleanup_doppelgas_ai" );
    data.victim thread utility::delaythread( 30, &gas_grenade::gas_clearblur );
    data.victim thread function_ec27e3b9bd1e0cb9();
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xa80dc092, Offset: 0x126e
// Size: 0x25
function private function_ec27e3b9bd1e0cb9()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"cleanup_doppelgas_ai" );
    self.var_4d71b356f97bb810 = 0;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xf19c1ae6, Offset: 0x129b
// Size: 0x1ca
function private function_cd53009b9482ddfe()
{
    self endon( #"death_or_disconnect" );
    ai_type = function_b3988325430ce242( "zombie_amalgam" );
    var_7654d704b9415bab = undefined;
    
    while ( !isdefined( var_7654d704b9415bab ) )
    {
        spawn_pos = undefined;
        
        while ( !spawn_pos )
        {
            var_e3bd7217410a2bdf = self.origin;
            spawn_pos = getrandomnavpoint( var_e3bd7217410a2bdf, 512 );
            spawn_angles = anglestoforward( self.angles ) * -1;
            waitframe();
        }
        
        var_7654d704b9415bab = agent_manager::spawn_agent( ai_type, spawn_pos, spawn_angles );
        waitframe();
        
        if ( var_7654d704b9415bab )
        {
            var_7654d704b9415bab.var_7f06e54684fec633 = 1;
            var_7654d704b9415bab zombie_utils::set_zombie_round_difficulty( 1 );
            var_7654d704b9415bab.var_a13bed1ac47e1b2c = 1;
            var_7654d704b9415bab.no_powerups = 1;
            var_7654d704b9415bab.var_15598d8e493afe88 = 1;
            var_7654d704b9415bab.b_cleanup_no_respawn = 1;
            var_7654d704b9415bab.var_825b17c932865df = 1;
            var_7654d704b9415bab.ignore_enemy_count = 1;
            var_7654d704b9415bab.forceannihilate = 1;
            var_7654d704b9415bab ai::set_ai_max_health( 100 );
            var_7654d704b9415bab setcandamage( 0 );
            var_7654d704b9415bab zombie_utils::set_ai_target_priority( self );
            
            foreach ( player in level.players )
            {
                if ( self != player )
                {
                    var_7654d704b9415bab function_2194b5587d448a83( player );
                }
            }
            
            var_7654d704b9415bab thread function_59ccd718d7f1f691( self );
            continue;
        }
        
        wait 0.1;
    }
    
    thread function_95dcbf49de7392bf( var_7654d704b9415bab );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xcb144417, Offset: 0x146d
// Size: 0xbd
function private function_2194b5587d448a83( player )
{
    if ( !isdefined( self.var_750b739083708e95 ) )
    {
        self.var_750b739083708e95 = [];
    }
    
    foreach ( hidden_player in self.var_750b739083708e95 )
    {
        if ( hidden_player == player )
        {
            return;
        }
    }
    
    self hidefromplayer( player, 1 );
    self.var_750b739083708e95[ self.var_750b739083708e95.size ] = player;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xb850f71e, Offset: 0x1532
// Size: 0x99
function private function_bd3a27ec30188ec9()
{
    if ( !isdefined( self.var_750b739083708e95 ) )
    {
        return;
    }
    
    foreach ( player in self.var_750b739083708e95 )
    {
        if ( isdefined( player ) )
        {
            self showtoplayer( player );
        }
    }
    
    self.var_750b739083708e95 = undefined;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1
// Checksum 0x39e5e0e9, Offset: 0x15d3
// Size: 0x55
function function_95dcbf49de7392bf( var_7654d704b9415bab )
{
    var_7654d704b9415bab endon( #"death" );
    self waittill( #"cleanup_doppelgas_ai" );
    var_7654d704b9415bab function_bd3a27ec30188ec9();
    var_7654d704b9415bab setcandamage( 1 );
    var_7654d704b9415bab dodamage( var_7654d704b9415bab.maxhealth, var_7654d704b9415bab.origin );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x15adb518, Offset: 0x1630
// Size: 0x49
function private function_59ccd718d7f1f691( var_a72078e89f0d96a5 )
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( player != var_a72078e89f0d96a5 )
        {
            function_2194b5587d448a83( player );
        }
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 10, eflags: 0x4
// Checksum 0x95aee72c, Offset: 0x1681
// Size: 0x7f
function private function_ee565b9345d41bc5( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( einflictor.var_7f06e54684fec633 || eattacker.var_7f06e54684fec633 )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0
// Checksum 0xe4939aa3, Offset: 0x1709
// Size: 0x216
function boss_fight_abom()
{
    level endon( #"game_ended" );
    function_1cbd2cb2cfc8e2ec();
    boss = spawn_hvt( "zombie_abom_hvt_echo", &function_2498eb3738db3cde, 35 );
    boss callback::add( #"on_ai_killed", &function_14846c33c42e3fa1 );
    function_4dfb202240ea2d44( #"hash_5821b81618cecd24" );
    level.var_9c0d12c8f8edeb3d = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    level.s_game_over_scene_override = spawnstruct();
    level.s_game_over_scene_override.origin = ( 46504, -354, 12 );
    level.s_game_over_scene_override.angles = ( 0, 0, 0 );
    level.echo_abom_boss = boss;
    boss thread function_36240c70538f1d79();
    boss thread zombie_utils::function_a8ce00e0448cb6f0( "sprint", "echo_abom_boss", 31 );
    boss thread function_18f10fc17a56ac17();
    utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_e20ef6cd4da8f279 );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player thread function_6d5b2c1d7244a063();
        }
    }
    
    level thread function_c8c792d605818cff();
    level thread function_96d329e01ffc873( boss );
    level thread function_c80ab9c82c6d630b();
    level utility::flag_wait( "echo_challenge_complete" );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level.echo_abom_boss = undefined;
    function_54207e09f68a2299( boss );
    wait 3;
    
    if ( level.var_f55a0f728c0b515f )
    {
        zm_round_spawning::pause_round_spawning( 1, "last hvt killed" );
        level thread function_efe34afb95b8c847();
        return;
    }
    
    zm_round_spawning::pause_round_spawning( 0, "echo_boss_fight_adds" );
    zm_round_logic::function_895fdc21ab019efe();
    function_15973947e8d92140();
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xb6a37c85, Offset: 0x1927
// Size: 0x20
function private function_2498eb3738db3cde( params )
{
    function_d690ddb7282b79d6();
    level utility::flag_set( "echo_challenge_complete" );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xe38b95ad, Offset: 0x194f
// Size: 0x138
function private function_1cbd2cb2cfc8e2ec()
{
    level.var_6e43b5a06b57d4e = [];
    level.var_6e43b5a06b57d4e[ "specialty_quickrevive" ] = %"itemspawnentry:zm_t10_item_perk_quickrevive";
    level.var_6e43b5a06b57d4e[ "specialty_m_mod" ] = %"hash_342cb8b7ada6857d";
    level.var_6e43b5a06b57d4e[ "specialty_staminup" ] = %"itemspawnentry:zm_t10_item_perk_staminup";
    level.var_6e43b5a06b57d4e[ "specialty_d_mod" ] = %"itemspawnentry:zm_t10_item_perk_d_mod";
    level.var_6e43b5a06b57d4e[ "specialty_phd_flopper" ] = %"hash_35bfcd79fa72f41a";
    level.var_6e43b5a06b57d4e[ "specialty_elemental_pop" ] = %"itemspawnentry:zm_t10_item_perk_elementalpop";
    level.var_6e43b5a06b57d4e[ "specialty_death_perception" ] = %"itemspawnentry:zm_t10_item_perk_death_perception";
    level.var_6e43b5a06b57d4e[ "specialty_deadshot" ] = %"itemspawnentry:zm_t10_item_perk_deadshot";
    level.var_6e43b5a06b57d4e[ "specialty_juggernog" ] = %"itemspawnentry:zm_t10_item_perk_juggernog";
    level.var_6e43b5a06b57d4e[ "specialty_vulture_aid" ] = %"itemspawnentry:zm_t10_item_perk_vulture_aid";
    level.var_6e43b5a06b57d4e[ "specialty_speedcola" ] = %"itemspawnentry:zm_t10_item_perk_speedcola";
    level.var_6e43b5a06b57d4e[ "specialty_w_mod" ] = %"hash_52bfc7ae674793a6";
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xed20ee0f, Offset: 0x1a8f
// Size: 0x9f
function private function_36240c70538f1d79()
{
    self endon( #"death" );
    abom_heads = namespace_ad681b768a39ef59::get_heads_alive( self );
    
    foreach ( var_cc62445e986357e6 in abom_heads )
    {
        metabone::set_metabone_health( var_cc62445e986357e6, self.maxhealth, "open" );
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xcd397323, Offset: 0x1b36
// Size: 0x1dc
function private function_18f10fc17a56ac17()
{
    self endon( #"death" );
    self.weapon_tracker = [];
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( !isdefined( objweapon ) )
        {
            continue;
        }
        
        if ( !isdefined( self.weapon_tracker[ objweapon.basename ] ) )
        {
            self.weapon_tracker[ objweapon.basename ] = spawnstruct();
            self.weapon_tracker[ objweapon.basename ].count = 1;
            continue;
        }
        
        self.weapon_tracker[ objweapon.basename ].count = min( 100, self.weapon_tracker[ objweapon.basename ].count + 1 );
        
        foreach ( weap_name, weapon in self.weapon_tracker )
        {
            if ( weap_name != objweapon.basename )
            {
                weapon.count = max( 0, weapon.count - 2 );
            }
        }
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x89c4ee1b, Offset: 0x1d1a
// Size: 0xe6
function private function_e20ef6cd4da8f279( dmg_struct )
{
    idamage = dmg_struct.idamage;
    player = dmg_struct.eattacker;
    
    if ( !isplayer( player ) || !isdefined( level.echo_abom_boss ) || self != level.echo_abom_boss )
    {
        return idamage;
    }
    
    weapon = player getcurrentweapon();
    weap_basename = weapon.basename;
    
    if ( isdefined( level.echo_abom_boss.weapon_tracker[ weap_basename ] ) )
    {
        new_damage = max( 0, int( ( 100 - level.echo_abom_boss.weapon_tracker[ weap_basename ].count ) * 0.01 * idamage ) );
        return new_damage;
    }
    
    return idamage;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0x393a71e5, Offset: 0x1e09
// Size: 0x117
function private function_6d5b2c1d7244a063()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( !level utility::flag( "echo_challenge_complete" ) )
    {
        utility::ent_flag_wait( "abom_bull_charge_hit" );
        
        if ( !self.inlaststand )
        {
            keys = getarraykeys( level._custom_perks );
            
            foreach ( key in keys )
            {
                if ( zombie_perks::has_perk( key ) && !zombie_perks::has_permanent_perk( key ) )
                {
                    zombie_perks::take_perk( key );
                    
                    if ( isdefined( level.var_6e43b5a06b57d4e[ key ] ) )
                    {
                        function_e4092c26edae2972( level.var_6e43b5a06b57d4e[ key ] );
                    }
                }
                
                waitframe();
            }
        }
        
        utility::ent_flag_waitopen_any( "abom_bull_charge_hit" );
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x2be9fa11, Offset: 0x1f28
// Size: 0x3b
function private function_e4092c26edae2972( item_spawn_entry )
{
    perk_bundle = getscriptbundle( item_spawn_entry );
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    common_item::function_61c2c0251e742ffd( perk_bundle, undefined, spawnoptions );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0x54b0d7d8, Offset: 0x1f6b
// Size: 0x43
function private function_c8c792d605818cff()
{
    level endon( #"game_ended" );
    
    while ( !level utility::flag( "echo_challenge_complete" ) )
    {
        level waittill( #"connected", player );
        player thread function_6d5b2c1d7244a063();
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xd6ffdad2, Offset: 0x1fb6
// Size: 0x21
function private function_c80ab9c82c6d630b()
{
    level.var_2bb97d7a00c8fda2 = [];
    callback::add( #"on_ai_killed", &function_997dd2ee888fcab0 );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x3184a8df, Offset: 0x1fdf
// Size: 0x2c7
function private function_997dd2ee888fcab0( sparams )
{
    if ( !isdefined( level.echo_abom_boss ) )
    {
        return;
    }
    
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( self == level.echo_abom_boss )
    {
        return;
    }
    
    player = sparams.eattacker;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( randomint( 100 ) >= 30 )
    {
        return;
    }
    
    var_172cbb45d4decfe7 = sparams.sweapon;
    
    if ( !isdefined( var_172cbb45d4decfe7 ) || var_172cbb45d4decfe7 == level.weaponnone )
    {
        return;
    }
    
    n_rarity = player item_weapon::function_fb81bd2fe070faa6( var_172cbb45d4decfe7 );
    n_rarity = int( clamp( n_rarity, 0, 4 ) );
    var_951c89546ec50477 = player pack_a_punch::get_pap_level( var_172cbb45d4decfe7 );
    str_class = utility::array_random( [ "ar", "smg", "lmg", "sh", "sn", "dm", "pi" ] );
    weapon_list = level.var_feed53d8447f7479[ str_class ][ n_rarity ];
    
    if ( !isdefined( weapon_list ) )
    {
        return;
    }
    
    if ( level.var_2bb97d7a00c8fda2.size >= 10 )
    {
        oldest = level.var_2bb97d7a00c8fda2[ 0 ];
        
        if ( isdefined( oldest ) )
        {
            oldest freescriptable();
        }
        
        level.var_2bb97d7a00c8fda2 = arrayremove( level.var_2bb97d7a00c8fda2, oldest );
    }
    
    v_origin = self.origin;
    v_angles = self.angles ?? ( 0, 0, 0 );
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( v_origin, v_angles );
    spawn_options.overridepaplvl = var_951c89546ec50477;
    var_4569d8ac7cda047d = undefined;
    
    if ( var_951c89546ec50477 > 0 )
    {
        a_selected = common_item::items_selectfromlist( weapon_list, 1 );
        
        if ( isdefined( a_selected ) && a_selected.size > 0 )
        {
            item_bundle = getscriptbundle( a_selected[ 0 ] );
            
            if ( isdefined( item_bundle ) )
            {
                var_619aa3791b99968c = item_weapon::function_477bf1207c6672a5( item_bundle, spawn_options );
                
                if ( isdefined( var_619aa3791b99968c ) )
                {
                    spawn_options.weapon = player pack_a_punch::function_e190a315803e2870( var_619aa3791b99968c, var_951c89546ec50477 );
                }
                
                spawned = level common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawn_options );
                var_4569d8ac7cda047d = isdefined( spawned ) ? isarray( spawned ) ? spawned : [ spawned ] : undefined;
            }
        }
    }
    
    if ( !isdefined( var_4569d8ac7cda047d ) )
    {
        spawn_options.weapon = undefined;
        var_4569d8ac7cda047d = level common_item::function_38cde6a6acb68ea6( weapon_list, 1, spawn_options );
    }
    
    if ( isdefined( var_4569d8ac7cda047d ) )
    {
        level.var_2bb97d7a00c8fda2[ level.var_2bb97d7a00c8fda2.size ] = var_4569d8ac7cda047d[ 0 ];
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0
// Checksum 0xebda7318, Offset: 0x22ae
// Size: 0x17f
function boss_fight_amalgam()
{
    level endon( #"game_ended" );
    utility::add_fx( "echo_amalgam_leach_tether", "vfx_sat_gameplay_zm_battle_tethering_variant_beam_green" );
    boss = spawn_hvt( "zombie_amalgam_hvt_echo", &function_6d9bd22a76070971, 40 );
    boss callback::add( #"on_ai_killed", &function_14846c33c42e3fa1 );
    function_4dfb202240ea2d44( #"hash_4f78ff01b67b142b" );
    level.var_9c0d12c8f8edeb3d = "t10_cin_zm_vig_plr_dth_zmb_solo_01_global";
    level.s_game_over_scene_override = spawnstruct();
    level.s_game_over_scene_override.origin = ( 46504, -354, 12 );
    level.s_game_over_scene_override.angles = ( 0, 0, 0 );
    level.var_581e7d08b1f0633a = boss;
    utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_5396b903cf3fb08a );
    boss thread function_3c611096c2914aef();
    level thread function_96d329e01ffc873( boss );
    level utility::flag_wait( "echo_challenge_complete" );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level.var_581e7d08b1f0633a = undefined;
    function_54207e09f68a2299( boss );
    wait 3;
    
    if ( level.var_f55a0f728c0b515f )
    {
        zm_round_spawning::pause_round_spawning( 1, "last hvt killed" );
        zm_round_spawning::pause_round_spawning( 0, "echo_boss_fight_adds" );
        level thread function_efe34afb95b8c847();
        return;
    }
    
    zm_round_spawning::pause_round_spawning( 0, "echo_boss_fight_adds" );
    zm_round_logic::function_895fdc21ab019efe();
    function_15973947e8d92140();
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x1057b2d, Offset: 0x2435
// Size: 0x20
function private function_6d9bd22a76070971( params )
{
    function_d690ddb7282b79d6();
    level utility::flag_set( "echo_challenge_complete" );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xa653a2c5, Offset: 0x245d
// Size: 0x8d
function private function_5396b903cf3fb08a( dmg_struct )
{
    idamage = dmg_struct.idamage;
    player = dmg_struct.eattacker;
    
    if ( !isplayer( player ) || !isdefined( level.var_581e7d08b1f0633a ) || self != level.var_581e7d08b1f0633a )
    {
        return idamage;
    }
    
    if ( function_73194a7d5c7769d1( dmg_struct.smeansofdeath ) )
    {
        return int( idamage * 3 );
    }
    
    return int( idamage * 0.2 );
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x546b4a79, Offset: 0x24f3
// Size: 0x93
function private function_73194a7d5c7769d1( smeansofdeath )
{
    switch ( smeansofdeath )
    {
        case #"hash_1f00b716e2ac2e39":
        case #"hash_2966293823fb0656":
        case #"hash_2da6932bf991d10e":
        case #"hash_4bcded952fe44aeb":
        case #"hash_63c3623e159b1e83":
        case #"hash_9f8e4c1b4346dc4c":
        case #"hash_a26b8b3a83d4daae":
        case #"hash_ae0707fb5f8f9655":
        case #"hash_d8646db4e6ee3658":
            return 1;
        default:
            return 0;
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xa8fc9758, Offset: 0x258e
// Size: 0x239
function private function_3c611096c2914aef()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.var_688b50fd908d9a69 = [];
    
    while ( true )
    {
        a_zombies = zm_round_spawning::get_round_enemies();
        var_ce198bb8d19670cb = [];
        
        foreach ( zombie in a_zombies )
        {
            if ( !isalive( zombie ) || zombie == self )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, zombie.origin ) > 262144 )
            {
                continue;
            }
            
            var_ce198bb8d19670cb[ var_ce198bb8d19670cb.size ] = zombie;
            
            if ( var_ce198bb8d19670cb.size >= 5 )
            {
                break;
            }
        }
        
        function_6eb9757517b1114f( var_ce198bb8d19670cb );
        
        foreach ( zombie in var_ce198bb8d19670cb )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            function_80fcaa92e40419ea( zombie );
            n_drain = 50;
            var_d6cba6380eaa5e0e = function_d7d108abd83e878d( zombie );
            
            if ( var_d6cba6380eaa5e0e )
            {
                n_drain = 50000;
            }
            
            actual_drain = min( n_drain, zombie.health );
            
            if ( actual_drain > 0 )
            {
                zombie dodamage( actual_drain, zombie.origin );
                function_7f1c5fee93c0de66( zombie, actual_drain );
                
                if ( var_d6cba6380eaa5e0e )
                {
                    new_damage = actual_drain * 1000;
                    self dodamage( new_damage, self.origin );
                    function_7f1c5fee93c0de66( self, new_damage );
                    continue;
                }
                
                self.health = min( self.maxhealth, self.health + actual_drain );
            }
        }
        
        wait 2;
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x69b23e96, Offset: 0x27cf
// Size: 0x10f
function private function_80fcaa92e40419ea( zombie )
{
    foreach ( beam_data in self.var_688b50fd908d9a69 )
    {
        if ( beam_data.zombie == zombie )
        {
            return;
        }
    }
    
    fx = playfxontagsbetweenclients( utility::getfx( "echo_amalgam_leach_tether" ), self, "j_spine4", zombie, "j_spine4" );
    
    if ( isdefined( fx ) )
    {
        beam_data = { #zombie:zombie, #var_82f96f6f834b149d:fx };
        self.var_688b50fd908d9a69[ self.var_688b50fd908d9a69.size ] = beam_data;
        zombie.var_a73bef107de8fc7a = fx;
        zombie callback::add( #"on_ai_killed", &function_f3f169ef1d8dc7e6 );
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x818edcf4, Offset: 0x28e6
// Size: 0x200
function private function_6eb9757517b1114f( var_de8805294d1db6b2 )
{
    a_to_remove = [];
    
    foreach ( beam_data in self.var_688b50fd908d9a69 )
    {
        var_29ab0f4ac7126c8c = 0;
        
        foreach ( zombie in var_de8805294d1db6b2 )
        {
            if ( beam_data.zombie == zombie && isalive( zombie ) )
            {
                var_29ab0f4ac7126c8c = 1;
                break;
            }
        }
        
        if ( !var_29ab0f4ac7126c8c )
        {
            if ( isdefined( beam_data.var_82f96f6f834b149d ) )
            {
                beam_data.var_82f96f6f834b149d delete();
            }
            
            a_to_remove[ a_to_remove.size ] = beam_data;
        }
    }
    
    foreach ( beam_data in a_to_remove )
    {
        self.var_688b50fd908d9a69 = arrayremove( self.var_688b50fd908d9a69, beam_data );
        
        if ( beam_data.zombie callback::exists( #"on_ai_killed", &function_f3f169ef1d8dc7e6 ) )
        {
            beam_data.zombie callback::remove( #"on_ai_killed", &function_f3f169ef1d8dc7e6 );
        }
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xdb9e0c58, Offset: 0x2aee
// Size: 0x17d
function private function_f3f169ef1d8dc7e6( params )
{
    if ( isdefined( self.var_a73bef107de8fc7a ) )
    {
        self.var_a73bef107de8fc7a delete();
        self.var_a73bef107de8fc7a = undefined;
    }
    
    if ( isdefined( level.var_581e7d08b1f0633a ) && isdefined( level.var_581e7d08b1f0633a.var_688b50fd908d9a69 ) )
    {
        a_to_remove = [];
        
        foreach ( beam_data in level.var_581e7d08b1f0633a.var_688b50fd908d9a69 )
        {
            if ( beam_data.zombie == self )
            {
                a_to_remove[ a_to_remove.size ] = beam_data;
            }
        }
        
        foreach ( beam_data in a_to_remove )
        {
            level.var_581e7d08b1f0633a.var_688b50fd908d9a69 = arrayremove( level.var_581e7d08b1f0633a.var_688b50fd908d9a69, beam_data );
        }
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 2, eflags: 0x4
// Checksum 0xe0f0b949, Offset: 0x2c73
// Size: 0xcf
function private function_7f1c5fee93c0de66( target, n_damage )
{
    var_5fb4fe43f49ba675 = target.origin + ( 0, 0, 40 );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( player, target, "none", "MOD_UNKNOWN", undefined, n_damage, var_5fb4fe43f49ba675, 0, undefined, 0, 0, 1 );
        }
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xe9791a64, Offset: 0x2d4a
// Size: 0x7f, Type: bool
function private function_d7d108abd83e878d( zombie )
{
    if ( zombie utility::ent_flag( "cryofreeze_active" ) )
    {
        return true;
    }
    
    if ( zombie utility::ent_flag( "frost_blast_active" ) )
    {
        return true;
    }
    
    if ( zombie utility::ent_flag( "deadwire_stunned" ) )
    {
        return true;
    }
    
    if ( zombie utility::ent_flag( "napalm_burned" ) )
    {
        return true;
    }
    
    if ( zombie utility::ent_flag( "burned" ) )
    {
        return true;
    }
    
    if ( zombie utility::ent_flag( "poisoned" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xe9455fa9, Offset: 0x2dd2
// Size: 0xf3
function private function_14846c33c42e3fa1( params )
{
    additionaleventparams = [];
    additionaleventparams[ #"zm_zombie_type_bitfield" ] = zombie_shared_challenges::function_f603dd218dbf4618( self );
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( player != params.eattacker )
        {
            player namespace_b645faa035c740a7::function_8c4b87e9914a3388( #"none", additionaleventparams );
        }
    }
    
    if ( self && callback::exists( #"on_ai_killed", &function_14846c33c42e3fa1 ) )
    {
        callback::remove( #"on_ai_killed", &function_14846c33c42e3fa1 );
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x2b12b704, Offset: 0x2ecd
// Size: 0x86
function private function_4dfb202240ea2d44( splash_hash )
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( splash_hash );
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x9e6b2968, Offset: 0x2f5b
// Size: 0x10d
function private function_54207e09f68a2299( boss )
{
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie == boss )
        {
            continue;
        }
        
        if ( zombie.magic_bullet_shield || zombie.damageshield )
        {
            zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.nocorpse = 1;
        zombie.death_source = "echo_boss_fight_cleanup";
        zombie kill();
        waitframe();
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1
// Checksum 0x26972897, Offset: 0x3070
// Size: 0x1bb
function function_96d329e01ffc873( boss )
{
    boss endon( #"death" );
    level endon( #"game_ended" );
    zm_round_spawning::pause_round_spawning( 1, "echo_boss_fight_adds" );
    subclass_pool = [ "zombie_base", "zombie_base_armored_heavy" ];
    subclass_weights = [ 50, 50 ];
    
    while ( true )
    {
        player_count = get_valid_player_count();
        adds_number = function_e31820655d0f700( player_count );
        adds_pause = get_adds_pause_time( player_count );
        
        for ( i = 0; i < adds_number ; i++ )
        {
            while ( zm_utility::get_active_zombies_count() >= 35 )
            {
                waitframe();
            }
            
            subclass = utility::random_weighted( subclass_pool, subclass_weights );
            var_395649a1ecde9e39 = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_boss_arena" ], subclass );
            
            if ( !isdefined( var_395649a1ecde9e39 ) || var_395649a1ecde9e39.size == 0 )
            {
                waitframe();
                continue;
            }
            
            spawn_loc = utility::array_random( var_395649a1ecde9e39 );
            ai_type = function_b3988325430ce242( subclass );
            zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( ai_type, spawn_loc.origin, spawn_loc.angles, zm_utility::get_zombie_team() );
            
            if ( isdefined( zombie ) )
            {
                zombie thread zone_spawner::function_ce10e453e7f7bb8e( spawn_loc );
                zombie zombie_utils::set_zombie_round_difficulty( 30, 1, 1 );
                zombie.no_powerups = 1;
                zombie.var_825b17c932865df = 1;
                zombie.b_cleanup_no_respawn = 1;
                zombie.var_15598d8e493afe88 = 1;
            }
            
            waitframe();
        }
        
        wait adds_pause;
    }
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 0, eflags: 0x4
// Checksum 0xa7890366, Offset: 0x3233
// Size: 0x8d
function private get_valid_player_count()
{
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( zm_utility::is_player_valid_target( player ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0x514256ef, Offset: 0x32c9
// Size: 0x43
function private function_e31820655d0f700( player_count )
{
    batch_sizes = [ 20, 24, 28, 32 ];
    return batch_sizes[ int( clamp( player_count - 1, 0, 3 ) ) ];
}

// Namespace namespace_1fd313b1d0d63e6b
// Params 1, eflags: 0x4
// Checksum 0xfda734ba, Offset: 0x3315
// Size: 0x43
function private get_adds_pause_time( player_count )
{
    pause_times = [ 30, 15, 15, 15 ];
    return pause_times[ int( clamp( player_count - 1, 0, 3 ) ) ];
}

