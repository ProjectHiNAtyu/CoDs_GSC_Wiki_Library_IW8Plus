// scripts\mp\zm\systems\zm_exfil.gsc  (hash_18317bad0c071e03.gscc) (size: 39227 Bytes / 0x993b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x84dc7e5 (139315173)
// size ...... 39227 (0x993b)
// includes .. 36  (offset: 0x8f57)
// strings ... 123 (offset: 0x9077)
// dev strs .. 36  (offset: 0x9773)
// exports ... 82  (offset: 0x5cf3)
// cseg ...... 0x994 + 0x535f (0x5cf3)
// imports ... 305 (offset: 0x69c3)
// animtree1 . 0   (offset: 0x993b)
// animtree2 . 0   (offset: 0x993b)
#using script_162f01e3286930e2;
#using script_4bf223434bdc0646;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\objectives\exfil;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_exfil;

// Namespace zm_exfil
// Params 1
// Checksum 0x5f10465f, Offset: 0x9b2
// Size: 0x324
function init_zm_exfil( var_ae6ec3d5ec830a1 )
{
    setdvarifuninitialized( @"hash_ccef2121830537e5", 1 );
    level.var_cdacce741094543b = &"SHARED_HINTSTRINGS/EXFIL_START_USE_ZM";
    
    if ( !isdefined( level.var_a347479bbc614700 ) )
    {
        level.var_a347479bbc614700 = "EXFIL_ZM";
    }
    
    level.var_5d57c0ef0a0a2e4f = "exfil_activity_zm_definition";
    level.var_df4e6fb4f853185b = &function_c7b3865ed73e8c10;
    level.var_cfe1d326c601b127 = 150;
    level.var_fc592a2a0271da96 = 250;
    
    if ( getdvarint( @"hash_ccef2121830537e5", 0 ) )
    {
        utility::registersharedfunc( #"exfil", #"hash_f31fd3cb1a652981", &function_f90cc615caca8f3a );
        utility::registersharedfunc( #"exfil", #"hash_879c50917e34912", &function_5eb9262e817a92ed );
        utility::registersharedfunc( #"exfil", #"hash_727362151127a027", &function_d1ef9820ea3bd7bc );
        utility::registersharedfunc( #"exfil", #"hash_c5693f391aa3429c", &function_884e764920227583 );
    }
    
    exfil::function_c9d4f32197ee2e57();
    level.zm_exfil_throttle = throttle::throttle_initialize( "zm_exfil_throttle", 1, level.framedurationseconds );
    s_exfil_activity_bundle = exfil::function_3e68f7962cd82ad3();
    level.var_d52bb6769ac8f826 = s_exfil_activity_bundle.var_c0eca7db618f362e ?? 90;
    level.var_3ab1eb83383f8760 = 10;
    level.var_d3b3ca406bfc1284 = &function_df67c49bcf9fe9f1;
    level.var_2fa29f760fb6ace5 = &zm_exfil_spawning;
    level.var_86a37deb48edc350 = &zm_exfil_visibility;
    level.var_9f0a7ee32653dd0a = &function_d09e3552ba50b071;
    level.func_exfil_opt_in = &zm_exfil_opt_in;
    level.var_890cd8c298d2e74f = &function_fd4199cc323b861c;
    level.var_c81b9848be2307f4 = &zm_exfil_spawn_destination;
    level.var_c345d20c7156a1d4 = &zm_exfil_on_ai_killed;
    level.var_a0d7720b6da9b277 = &function_a3306dd33f3aa8c2;
    level.var_7862f3f9948a7589 = &function_e15c4993674b1288;
    level.var_eb6c6cf97fb75559 = 1;
    level.var_c4d360df2f5424a6 = 1;
    callback::add( "on_round_start", &on_round_start );
    callback::add( "on_round_end", &on_round_end );
    callback::add( "on_exfil_complete_timeout", &on_exfil_complete_timeout );
    callback::add( "on_exfil_complete_kill_count", &on_exfil_complete_kill_count );
    callback::add( #"hash_8a9c77a2d77b7469", &function_130830da49814d1e );
    callback::add( "on_exfil_vehicle_spawned", &on_exfil_vehicle_spawned );
    callback::add( #"player_spawned", &function_aeabb33c7aba04e7 );
    callback::add( "zm_chopper_gunner_start", &function_39158b6c85b1c0f );
    callback::add( "zm_chopper_gunner_end", &function_103f0e52b3ecb776 );
    callback::add( "on_brainrot_end", &function_6012d439021d7047 );
    callback::add( "on_zombie_viper_eject", &track_zombie_viper_mini );
    zm_quest::function_3c363613c60958f5( "exfil_start" );
    level utility::flag_set( "rbz_allow_exfil" );
    level.var_ee4ca19d4f6062f2 = vote_system_shared::register_vote_hud();
    level thread init_exfil_vo();
    
    /#
        level thread zm_exfil_devgui();
    #/
    
    if ( var_ae6ec3d5ec830a1 )
    {
        level utility::flag_clear( "rbz_allow_exfil" );
        level.var_ae6ec3d5ec830a1 = 1;
        level thread function_308d6096485c73dd();
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xcef06b14, Offset: 0xcde
// Size: 0xa7
function track_zombie_viper_mini( params )
{
    if ( params.var_d3b87382618c1f10 == "exfil_spawned" )
    {
        foreach ( player in level.players )
        {
            exfil::function_7ab1f22f29a03979( undefined, params.eject_ai, player, 1 );
        }
    }
}

// Namespace zm_exfil
// Params 0, eflags: 0xc
// Checksum 0x4e9abcf0, Offset: 0xd8d
// Size: 0x237
function private function_308d6096485c73dd()
{
    self notify( #"hash_8bf1611d45becee0" );
    self endon( #"hash_8bf1611d45becee0" );
    level endon( #"game_ended" );
    var_4a574b62db0dd61e = 21600;
    utility::flag_wait( "begin_round_logic" );
    var_989a85c171fa19b7 = gettime();
    
    while ( true )
    {
        var_4aecf4a42bd3345b = gettime() - var_989a85c171fa19b7;
        var_e178ed096c704725 = getdvarint( @"hash_1b68e1153add8a89", var_4a574b62db0dd61e ) * 1000;
        
        if ( var_4aecf4a42bd3345b >= var_e178ed096c704725 )
        {
            msg = level utility::waittill_any_return( "bgb_time_out_on_round_end", "on_round_end" );
            
            if ( msg == "bgb_time_out_on_round_end" )
            {
                level utility::waittill_any_timeout( 15, "on_round_end" );
                continue;
            }
            
            foreach ( player in level.players )
            {
                player.var_62c769ea7a03f7b8 = 1;
            }
            
            foreach ( s_exfil in level.var_e584ab91aed38e8c )
            {
                if ( !( isdefined( s_exfil.mdl_exfil ) && isdefined( s_exfil.mdl_exfil.interact ) ) )
                {
                    continue;
                }
                
                level.var_d1c505330bef7d45 = undefined;
                a_alive_players = utility::get_alive_players();
                utility::flag_clear( "zm_vote_active" );
                game[ "telemetry" ].exfil_forced_ending = 1;
                s_exfil.mdl_exfil.interact exfil::on_use_exfil_interact( a_alive_players[ 0 ] );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x105d7a0b, Offset: 0xfcc
// Size: 0x12f
function function_39158b6c85b1c0f( params )
{
    chopper_gunner_activator = params.activator;
    
    foreach ( s_exfil in level.var_e584ab91aed38e8c )
    {
        if ( isdefined( s_exfil.mdl_exfil.var_c6883f07ae9a466 ) )
        {
            objective_removeclientfrommask( s_exfil.mdl_exfil.var_c6883f07ae9a466, chopper_gunner_activator );
        }
    }
    
    if ( !utility::flag( "exfil_start" ) )
    {
        return;
    }
    
    if ( isdefined( level.s_exfil_active.var_42ada65a735fd2f3.var_d7e282248e190b32.var_c6883f07ae9a466 ) )
    {
        objective_removeclientfrommask( level.s_exfil_active.var_42ada65a735fd2f3.var_d7e282248e190b32.var_c6883f07ae9a466, chopper_gunner_activator );
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xc061c3a0, Offset: 0x1103
// Size: 0x13c
function function_103f0e52b3ecb776( params )
{
    chopper_gunner_activator = params.activator;
    
    foreach ( s_exfil in level.var_e584ab91aed38e8c )
    {
        if ( isdefined( s_exfil.mdl_exfil.var_c6883f07ae9a466 ) && isdefined( chopper_gunner_activator ) )
        {
            objective_addclienttomask( s_exfil.mdl_exfil.var_c6883f07ae9a466, chopper_gunner_activator );
        }
    }
    
    if ( !utility::flag( "exfil_start" ) )
    {
        return;
    }
    
    if ( isdefined( level.s_exfil_active.var_42ada65a735fd2f3.var_d7e282248e190b32.var_c6883f07ae9a466 ) && isdefined( chopper_gunner_activator ) )
    {
        objective_addclienttomask( level.s_exfil_active.var_42ada65a735fd2f3.var_d7e282248e190b32.var_c6883f07ae9a466, chopper_gunner_activator );
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x9c014895, Offset: 0x1247
// Size: 0x2a
function function_aeabb33c7aba04e7( params )
{
    if ( utility::flag( "exfil_start" ) )
    {
        thread exfil::function_e20be95da96bff4f( level.s_exfil_active );
    }
}

// Namespace zm_exfil
// Params 2
// Checksum 0x6761b180, Offset: 0x1279
// Size: 0xb6
function function_c7b3865ed73e8c10( interact, player )
{
    if ( utility::flag( "zm_vote_active" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #icon:"ui_icon_zm_ping_radio", #buttoncallout:&"SHARED_HINTSTRINGS/ZM_EXFIL_BUTTON", #description:&"SHARED_HINTSTRINGS/ZM_EXFIL_DES", #title:&"SHARED_HINTSTRINGS/ZM_EXFIL_TITLE", #string:level.var_cdacce741094543b ?? &"shared_hintstrings/exfil_start_use_generic", #type:"HINT_BUTTON" };
}

// Namespace zm_exfil
// Params 1
// Checksum 0xbd8db835, Offset: 0x1338
// Size: 0xb7
function function_6012d439021d7047( params )
{
    if ( !self.s_exfil )
    {
        return;
    }
    
    if ( self.var_2e1ddf0c7b8e7c95 )
    {
        if ( !isdefined( s_exfil ) )
        {
            s_exfil = self.s_exfil;
        }
        
        if ( !isdefined( s_exfil.var_79507aedd281f84d ) )
        {
            return;
        }
        
        if ( !arraycontains( s_exfil.var_79507aedd281f84d, self ) )
        {
            s_exfil.var_79507aedd281f84d[ s_exfil.var_79507aedd281f84d.size ] = self;
        }
        
        s_exfil.var_79507aedd281f84d = utility::array_removedead_or_dying( s_exfil.var_79507aedd281f84d );
        
        if ( s_exfil.kill_count_reached )
        {
            return;
        }
        
        s_exfil.var_ce318cb2d931ad92--;
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x971c81b2, Offset: 0x13f7
// Size: 0x107
function function_a3306dd33f3aa8c2( params )
{
    player_attacker = self.var_bd22ba6c600a23a3;
    
    if ( !isdefined( player_attacker ) )
    {
        return;
    }
    
    var_2854080ef988f697 = isplayer( player_attacker ) && player_attacker.var_3560f6b1ef954e6f && player_attacker.s_exfil == self.s_exfil;
    var_95ac3c08b4b8af25 = !var_2854080ef988f697 && player_attacker exfil::function_220801213cd3f346( self.s_exfil );
    self.s_exfil.var_79507aedd281f84d = arrayremove( self.s_exfil.var_79507aedd281f84d, self );
    
    if ( var_2854080ef988f697 || var_95ac3c08b4b8af25 )
    {
        println( "<dev string:x24>" );
        exfil::update_kill_count( self.s_exfil );
        
        if ( self.aicategory == "special" || self.aicategory == "elite" )
        {
            self.var_2e1ddf0c7b8e7c95 = 1;
        }
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x633bd551, Offset: 0x1506
// Size: 0x235
function zm_exfil_on_ai_killed( params )
{
    if ( !isdefined( self.var_bd22ba6c600a23a3 ) )
    {
        attacker = params.eattacker;
        player_attacker = isplayer( attacker ) ? attacker : undefined;
        var_7aad6d75262d979 = 0;
        
        if ( !isdefined( attacker ) )
        {
            return;
        }
        
        if ( self.var_48960fedb514aedd )
        {
            return;
        }
        
        if ( self.var_71ad3441c363e3a9 )
        {
            return;
        }
        
        if ( isdefined( attacker.var_bd22ba6c600a23a3 ) )
        {
            var_7aad6d75262d979 = 1;
            player_attacker = attacker.var_bd22ba6c600a23a3;
        }
        
        if ( attacker vehicle::is_vehicle() && !var_7aad6d75262d979 )
        {
            player_attacker = params.eattacker.owner;
        }
        
        var_2854080ef988f697 = isplayer( player_attacker ) && player_attacker.var_3560f6b1ef954e6f && player_attacker.s_exfil == self.s_exfil;
        var_95ac3c08b4b8af25 = !var_2854080ef988f697 && attacker exfil::function_220801213cd3f346( self.s_exfil );
        
        if ( var_2854080ef988f697 || self.nuked || var_95ac3c08b4b8af25 )
        {
            println( "<dev string:x24>" );
            exfil::update_kill_count( self.s_exfil );
            
            if ( getdvarint( @"hash_ccef2121830537e5", 0 ) )
            {
                foreach ( player in level.players )
                {
                    if ( player.var_3560f6b1ef954e6f )
                    {
                        player zm_quest::function_9f49b2a045ece8ae( exfil::function_664072bb6ca45820( self.s_exfil ), 0, #"exfil", #"kill_hostiles" );
                        continue;
                    }
                    
                    player zm_quest::function_9f49b2a045ece8ae( exfil::function_664072bb6ca45820( self.s_exfil ), 0, #"exfil", #"reach_site" );
                }
            }
        }
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x1fdd2bf9, Offset: 0x1743
// Size: 0x43
function function_53a9db2208a1e678( msg )
{
    if ( msg == "exfil_vote_accept" )
    {
        self playlocalsound( #"uin_cer_zm_squadvote_accept" );
        return;
    }
    
    if ( msg == "exfil_vote_decline" )
    {
        self playlocalsound( #"uin_cer_zm_squadvote_decline" );
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xdb44696, Offset: 0x178e
// Size: 0x66, Type: bool
function function_e15c4993674b1288( s_exfil )
{
    zones = [];
    
    if ( isdefined( level.var_41b52e54c6e6ac2c ) )
    {
        zones = [[ level.var_41b52e54c6e6ac2c ]]( s_exfil );
    }
    
    self_zone = zone_manager::get_current_zone();
    
    if ( isdefined( self_zone ) )
    {
        self_zone = self_zone.zone_name;
        
        if ( arraycontains( zones, self_zone ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_exfil
// Params 1
// Checksum 0x27d1a58d, Offset: 0x17fd
// Size: 0x35
function on_exfil_vehicle_spawned( params )
{
    if ( isdefined( level.s_exfil_active ) )
    {
        level.s_exfil_active.vh_exfil = self;
    }
    
    thread zm_exfil_spawn_pilot();
}

// Namespace zm_exfil
// Params 0
// Checksum 0x7dfd699a, Offset: 0x183a
// Size: 0xd7
function zm_exfil_spawn_pilot()
{
    var_31682af0231fbb0d = [ "t10_ai_infil_blima_pilot_idle", "t10_ai_infil_blima_copilot_idle" ];
    var_ab5487b73a5defbc = [ "TAG_SEAT_0", "TAG_SEAT_1" ];
    
    if ( issubstr( level.mapname, "garnet" ) )
    {
        var_24be2d849dc4e375 = "c_t10_zmb_npc_exfil_pilot_fb";
    }
    else
    {
        var_24be2d849dc4e375 = "body_c_t10_zmb_npc_raptor1";
        var_388d590de2f7df63 = "head_c_t10_zmb_npc_raptor1";
    }
    
    self.pilots = [];
    
    for ( i = 0; i < 1 ; i++ )
    {
        var_90d8386c4be2a54c = exfil::function_1ed3863eb7edf534( i, var_ab5487b73a5defbc[ i ], var_31682af0231fbb0d[ i ], var_24be2d849dc4e375, var_388d590de2f7df63 );
        
        if ( isdefined( var_90d8386c4be2a54c ) )
        {
            self.pilots[ self.pilots.size ] = var_90d8386c4be2a54c;
        }
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xede7a19b, Offset: 0x1919
// Size: 0x58
function zm_exfil_spawn_destination( s_exfil )
{
    if ( !isdefined( s_exfil.var_42ada65a735fd2f3.var_d7e282248e190b32 ) )
    {
        s_exfil.var_42ada65a735fd2f3.var_d7e282248e190b32 = spawnscriptable( "cp_mp_exfil_site_entityless_zm", s_exfil.var_42ada65a735fd2f3.origin );
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x76305ced, Offset: 0x1979
// Size: 0x25
function function_c4067ee622c74198( params )
{
    if ( !params.isspecialround )
    {
        return;
    }
    
    disable_zm_exfil( 1 );
}

// Namespace zm_exfil
// Params 1
// Checksum 0x9e36d8fa, Offset: 0x19a6
// Size: 0x14
function enable_zm_exfil( params )
{
    disable_zm_exfil( 0 );
}

// Namespace zm_exfil
// Params 1
// Checksum 0x161f5ba9, Offset: 0x19c2
// Size: 0x2e
function disable_zm_exfil( var_94d1ab5da995e573 )
{
    if ( var_94d1ab5da995e573 )
    {
        level utility::flag_clear( "rbz_allow_exfil" );
        return;
    }
    
    level utility::flag_set( "rbz_allow_exfil" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0x81bae570, Offset: 0x19f8
// Size: 0x42
function init_exfil_vo()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    var_78599363b34eb4b8 = level.var_fc409d14e3e469b8 ?? "zm_t10_exfil_dialogue_overlord";
    level thread overlord::function_b606cb1cebb2a4f5( var_78599363b34eb4b8 );
}

// Namespace zm_exfil
// Params 0
// Checksum 0xd0344202, Offset: 0x1a42
// Size: 0x9
function zm_exfil_visibility()
{
    self setusableenabled( 0 );
}

// Namespace zm_exfil
// Params 1, eflags: 0x4
// Checksum 0x90c55d99, Offset: 0x1a53
// Size: 0x32
function private on_round_start( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_8b52dcc4e869e5e5" ) )
    {
        on_round_end( params, 1 );
    }
}

// Namespace zm_exfil
// Params 2
// Checksum 0xb170cc35, Offset: 0x1a8d
// Size: 0x139
function on_round_end( params, var_e388a39e979aa425 )
{
    if ( !isarray( level.var_e584ab91aed38e8c ) || level.var_e584ab91aed38e8c.size == 0 || isdefined( level.s_exfil_active ) )
    {
        return;
    }
    
    if ( level.var_ae6ec3d5ec830a1 )
    {
        return;
    }
    
    n_round_ended = zm_utility::get_round_number();
    
    if ( var_e388a39e979aa425 )
    {
        n_round_ended--;
    }
    
    foreach ( s_exfil in level.var_e584ab91aed38e8c )
    {
        if ( !( isdefined( s_exfil.mdl_exfil ) && isdefined( s_exfil.mdl_exfil.interact ) ) )
        {
            continue;
        }
        
        if ( n_round_ended >= 10 && n_round_ended % 5 == 0 )
        {
            level thread function_3b2df1e6755a8537( n_round_ended );
            s_exfil.mdl_exfil thread function_21a86762c018a414( s_exfil, 120 );
        }
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xf1baa47b, Offset: 0x1bce
// Size: 0x80
function function_3b2df1e6755a8537( n_round_ended )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ n_round_ended + 1 ] ) )
    {
        next_special_rounds = level.var_a009ab14ee0d3223.specialroundspawns[ n_round_ended + 1 ];
        level.var_a009ab14ee0d3223.specialroundspawns[ n_round_ended + 1 ] = undefined;
        zm_round_spawning::schedule_special_round( n_round_ended + 2, next_special_rounds );
    }
}

// Namespace zm_exfil
// Params 2
// Checksum 0xf17257e1, Offset: 0x1c56
// Size: 0xae
function function_21a86762c018a414( s_exfil, var_f9073b9a68fe2fe )
{
    s_exfil notify( #"hash_38aa0d5d2049ee62" );
    s_exfil endon( #"hash_38aa0d5d2049ee62" );
    level utility::flag_wait( "rbz_allow_exfil" );
    s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 1 );
    level thread function_b9442c6dc3111664();
    level val::set( "trial_exfil", "trial_logic_activate", 0 );
    wait var_f9073b9a68fe2fe;
    level val::reset( "trial_exfil", "trial_logic_activate" );
    level thread function_d45d392f11da2027();
    
    if ( !s_exfil.var_b699cd3a775ac6e1 )
    {
        s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 0 );
    }
}

// Namespace zm_exfil
// Params 0, eflags: 0x4
// Checksum 0x306b8db4, Offset: 0x1d0c
// Size: 0x36
function private function_b9442c6dc3111664()
{
    if ( !utility::flag( "rbz_allow_exfil" ) )
    {
        return;
    }
    
    overlord::function_29d8b7aaf2aa133a();
    utility::flag_waitopen( "player_banter_playing" );
    level thread function_80f850545bc9c408( #"hash_e39f887afe7d8aba" );
}

// Namespace zm_exfil
// Params 0, eflags: 0x4
// Checksum 0xf688b3e9, Offset: 0x1d4a
// Size: 0x36
function private function_d45d392f11da2027()
{
    if ( !utility::flag( "rbz_allow_exfil" ) )
    {
        return;
    }
    
    overlord::function_29d8b7aaf2aa133a();
    utility::flag_waitopen( "player_banter_playing" );
    level thread function_80f850545bc9c408( #"hash_7bf441545d4c34f3" );
}

// Namespace zm_exfil
// Params 3
// Checksum 0xdfb0186a, Offset: 0x1d88
// Size: 0x230
function zm_exfil_objective_icon( s_exfil, b_show, b_show_splash = 1 )
{
    self.interact setusableenabled( b_show );
    
    if ( !isdefined( self.var_c6883f07ae9a466 ) )
    {
        var_c6883f07ae9a466 = objidpoolmanager::requestobjectiveid( 1 );
        self.var_c6883f07ae9a466 = var_c6883f07ae9a466;
        objidpoolmanager::objective_add_objective( self.var_c6883f07ae9a466, "invisible", self.origin, "ui_icon_zm_ping_radio", "icon_regular" );
        objidpoolmanager::update_objective_setbackground( self.var_c6883f07ae9a466, 1 );
        objidpoolmanager::update_objective_onentity( self.var_c6883f07ae9a466, self );
        objective_setlabel( self.var_c6883f07ae9a466, &"shared_hintstrings/exfil" );
        objective_setplayintro( self.var_c6883f07ae9a466, 0 );
        
        foreach ( player in level.players )
        {
            objective_addclienttomask( self.var_c6883f07ae9a466, player );
            objective_showtoplayersinmask( self.var_c6883f07ae9a466 );
        }
    }
    
    if ( !isdefined( self.minimap_scriptable ) )
    {
        self.minimap_scriptable = spawnscriptable( "t10_zm_exfil_minimap", self.origin, self.angles );
    }
    
    if ( b_show )
    {
        s_exfil utility::ent_flag_set( "exfil_radio_active" );
        self.minimap_scriptable setscriptablepartstate( "content_interact", "visible" );
        
        if ( b_show_splash )
        {
            wait 0.5;
            utility::array_thread( level.players, &hud_message::showsplash, "cp_mp_exfil_ready" );
        }
    }
    else
    {
        s_exfil utility::ent_flag_clear( "exfil_radio_active" );
        self.minimap_scriptable setscriptablepartstate( "content_interact", "hidden" );
        objidpoolmanager::returnobjectiveid( self.var_c6883f07ae9a466 );
        self.var_c6883f07ae9a466 = undefined;
    }
    
    setomnvar( "ui_is_exfil_available", b_show );
}

// Namespace zm_exfil
// Params 1
// Checksum 0x464c0b12, Offset: 0x1fc0
// Size: 0x22c
function function_fd4199cc323b861c( s_exfil )
{
    var_9b29e4cdc52af3a = 20;
    n_round = zm_utility::get_round_number();
    var_688a1dc8b637411a = [];
    
    foreach ( var_42ada65a735fd2f3 in s_exfil.var_9af374cfc2dd171c )
    {
        if ( n_round < var_9b29e4cdc52af3a && ( !isdefined( var_42ada65a735fd2f3.script_noteworthy ) || var_42ada65a735fd2f3.script_noteworthy == "exfil_primary" ) )
        {
            var_688a1dc8b637411a = arraycombineunique( var_688a1dc8b637411a, [ var_42ada65a735fd2f3 ] );
            continue;
        }
        
        if ( n_round >= var_9b29e4cdc52af3a && isdefined( var_42ada65a735fd2f3.script_noteworthy ) && var_42ada65a735fd2f3.script_noteworthy == "exfil_secondary" )
        {
            var_688a1dc8b637411a = arraycombineunique( var_688a1dc8b637411a, [ var_42ada65a735fd2f3 ] );
        }
    }
    
    var_42ada65a735fd2f3 = utility::array_random( var_688a1dc8b637411a );
    
    if ( !isdefined( var_42ada65a735fd2f3 ) )
    {
        var_42ada65a735fd2f3 = utility::array_random( s_exfil.var_9af374cfc2dd171c );
    }
    
    var_255fa9c415d2f7c2 = getentitylessscriptablearray( var_42ada65a735fd2f3.target, #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_255fa9c415d2f7c2 )
    {
        var_bfb9424e344026e0 setscriptablepartstate( "chevron_0", "contested" );
    }
    
    s_exfil.var_dd154fe527c5609 = get_zm_exfil_scenes( var_42ada65a735fd2f3, "scene_exfil_success" );
    s_exfil.var_8cb3ff5a98b1bc8 = get_zm_exfil_scenes( var_42ada65a735fd2f3, "scene_exfil_fail" );
    
    if ( s_exfil.var_dd154fe527c5609.size )
    {
        s_exfil.var_9ee6eba1bf8d756b = 1;
    }
    
    return var_42ada65a735fd2f3;
}

// Namespace zm_exfil
// Params 2
// Checksum 0x2ee7fab5, Offset: 0x21f5
// Size: 0x389
function zm_exfil_spawning( s_exfil, var_5a5626a7d4b2feb )
{
    s_exfil endon( #"exfil_complete_kill_count" );
    s_exfil endon( #"exfil_complete_timeout" );
    str_player_team = var_5a5626a7d4b2feb.team ?? getdvar( @"scr_force_team", "allies" );
    var_ac07512145efb190 = getteamplayersalive( str_player_team );
    
    if ( !isdefined( var_ac07512145efb190 ) || var_ac07512145efb190 <= 0 || var_ac07512145efb190 > 4 )
    {
        var_ac07512145efb190 = level.players.size;
    }
    
    s_exfil.n_elites_spawned = 0;
    s_exfil.var_601991eb599f7049 = 1;
    function_5a89ca0aa6a34c2b( s_exfil );
    str_spawn_list = function_df5fde5401cbf767( s_exfil );
    exfil::function_73335ef7f523fb05( function_49bd8db2b945a462( str_spawn_list, var_ac07512145efb190 ) );
    n_max_ai = 60;
    var_e8874d05e088458f = int( min( n_max_ai / ( level.players.size + 1 ), n_max_ai / 3 ) );
    
    if ( !getdvarint( @"hash_ccef2121830537e5", 0 ) )
    {
        s_exfil.s_activity_instance activity_progress_tracking::function_c3f4671492898d76( "exfil_kills_remaining", exfil::function_7759b15fe5ee89e9( s_exfil ), 0 );
    }
    
    callback::add( "on_exfil_ai_spawned", &on_exfil_ai_spawned );
    var_6ac06bc3285f7d0b = level.s_exfil_active.var_42ada65a735fd2f3.origin;
    str_enemy_team = zm_utility::get_zombie_team();
    zm_round_spawning::pause_round_spawning( 1, "exfil_pause_spawning" );
    utility::flag_set( "exfil_active" );
    setomnvar( "ui_is_exfil_active", 1 );
    level thread zm_utility::util_kill_all_zombies();
    wait 5;
    level utility::flag_clear( "drop_powerups" );
    level thread exfil::function_91dd8cb89f4e9f18( s_exfil, undefined, 0, 0 );
    agent_spawner::function_da6c989ec2c8c5fa( "exfil" );
    level.var_e89fe60e34cb36f1 = 1;
    level val::set( "exfil_cleanup", "cleanup_dist_override", 500 );
    round_number = zm_utility::get_round_number();
    delay = zm_round_spawning::function_5f35aa2e209190da( round_number );
    
    while ( true )
    {
        var_840c6b3dcfb0830c = 0;
        var_f9b542d11423289b = exfil::function_376be1634c46bac2( s_exfil );
        var_41d55ee3bcfcead5 = 20;
        
        if ( var_f9b542d11423289b.size < var_41d55ee3bcfcead5 && function_f144f2b9d126c5f8( s_exfil ) )
        {
            var_840c6b3dcfb0830c = 1;
        }
        
        can_spawn_ai = function_5fa09ff7fadf3ff0( s_exfil, s_exfil.var_79507aedd281f84d );
        
        if ( !can_spawn_ai && var_840c6b3dcfb0830c )
        {
            can_spawn_ai = zm_utility::function_71d7c0e7375ef487( 1, [ "normal" ], var_f9b542d11423289b );
        }
        
        if ( can_spawn_ai )
        {
            exfil_aitype = function_45de00ea10e781d0( s_exfil, s_exfil.var_79507aedd281f84d );
            
            if ( isdefined( exfil_aitype ) )
            {
                zombie = agent_spawner::spawn_agent_custom( exfil_aitype, "exfil", { #var_774c0b07496cfb12:var_840c6b3dcfb0830c } );
                
                if ( isdefined( zombie ) )
                {
                    if ( zombie.aicategory == "elite" )
                    {
                        s_exfil.n_elites_spawned++;
                    }
                    
                    if ( zombie.subclass != "zombie_viper" )
                    {
                        exfil::function_7ab1f22f29a03979( s_exfil, zombie, self, var_840c6b3dcfb0830c );
                    }
                    else
                    {
                        zombie.var_71ad3441c363e3a9 = 1;
                        zombie.var_d3b87382618c1f10 = "exfil_spawned";
                    }
                    
                    zombie callback::callback( "on_exfil_ai_spawned" );
                }
            }
            
            var_1ff39db33bbedf84 = spawnstruct();
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, var_1ff39db33bbedf84 );
        }
        
        wait delay;
    }
}

// Namespace zm_exfil
// Params 1, eflags: 0x4
// Checksum 0x53d242a3, Offset: 0x2586
// Size: 0x79
function private function_130830da49814d1e( params )
{
    if ( !isalive( params.player ) )
    {
        return;
    }
    
    var_d0a9f6f34cfc87d1 = 4000;
    
    if ( params.var_3560f6b1ef954e6f )
    {
        params.player ai::set_threatbias_stack_score( #"zm_exfil", var_d0a9f6f34cfc87d1 );
        return;
    }
    
    params.player ai::set_threatbias_stack_score( #"zm_exfil", undefined );
}

// Namespace zm_exfil
// Params 1, eflags: 0x4
// Checksum 0x228579ac, Offset: 0x2607
// Size: 0x32, Type: bool
function private function_f144f2b9d126c5f8( s_exfil )
{
    if ( !isdefined( s_exfil.a_exfil_players ) )
    {
        return false;
    }
    
    if ( s_exfil utility::ent_flag( "player_reached_exfil" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_exfil
// Params 2, eflags: 0x4
// Checksum 0x507f77bc, Offset: 0x2642
// Size: 0x4d, Type: bool
function private function_5fa09ff7fadf3ff0( s_exfil, var_79507aedd281f84d )
{
    n_current_spawned = var_79507aedd281f84d.size;
    
    if ( n_current_spawned >= 60 )
    {
        return false;
    }
    
    n_kills_remaining = exfil::function_664072bb6ca45820( s_exfil );
    
    if ( n_current_spawned >= n_kills_remaining + 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_exfil
// Params 2, eflags: 0x4
// Checksum 0x1bbddbf6, Offset: 0x2698
// Size: 0x1d5
function private function_45de00ea10e781d0( s_exfil, var_79507aedd281f84d )
{
    ai_spawn_bundle = function_df5fde5401cbf767( s_exfil );
    var_e0cbe19de521e663 = 0;
    
    if ( !isdefined( s_exfil.var_42d2e5b0b78ea859 ) )
    {
        s_exfil.var_42d2e5b0b78ea859 = 50;
    }
    
    if ( zm_round_logic::get_rb_round_number() >= 16 )
    {
        foreach ( ai in var_79507aedd281f84d )
        {
            if ( isalive( ai ) && isdefined( ai.aicategory ) && ai.aicategory == "elite" )
            {
                var_e0cbe19de521e663++;
            }
        }
        
        if ( var_e0cbe19de521e663 < 1 && s_exfil.n_elites_spawned < s_exfil.var_601991eb599f7049 && function_f144f2b9d126c5f8( s_exfil ) )
        {
            if ( utility::percent_chance( s_exfil.var_42d2e5b0b78ea859 ) )
            {
                elite_array = namespace_c7157c2cd884c5d5::function_e05919b47b9a0cda( "elite" );
                elite_aitype = utility::array_random( elite_array );
                
                if ( isdefined( elite_aitype ) )
                {
                    s_exfil.var_42d2e5b0b78ea859 = 50;
                    return elite_aitype;
                }
            }
            else
            {
                s_exfil.var_42d2e5b0b78ea859 += 5;
            }
        }
    }
    
    var_6663d37cb38de21e = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( ai_spawn_bundle );
    aitype = function_b3988325430ce242( var_6663d37cb38de21e );
    
    if ( !isdefined( aitype ) )
    {
        aitype = var_6663d37cb38de21e;
    }
    
    assert( isdefined( aitype ), "<dev string:x34>" + var_6663d37cb38de21e );
    return aitype;
}

// Namespace zm_exfil
// Params 1
// Checksum 0xd42a1567, Offset: 0x2876
// Size: 0xa2
function function_5a89ca0aa6a34c2b( s_exfil )
{
    if ( !isdefined( s_exfil.exfil_difficulty ) )
    {
        s_exfil.exfil_difficulty = "green";
    }
    
    n_round = zm_utility::get_round_number();
    
    if ( n_round >= 31 )
    {
        s_exfil.exfil_difficulty = "red";
        return;
    }
    
    if ( n_round >= 21 )
    {
        s_exfil.exfil_difficulty = "orange";
        return;
    }
    
    if ( n_round >= 16 )
    {
        s_exfil.exfil_difficulty = "yellow";
        return;
    }
    
    s_exfil.exfil_difficulty = "green";
}

// Namespace zm_exfil
// Params 1
// Checksum 0x4dd178e, Offset: 0x2920
// Size: 0xaa
function function_df5fde5401cbf767( s_exfil )
{
    s_exfil_activity_bundle = exfil::function_3e68f7962cd82ad3();
    
    if ( isdefined( level.var_3d3494d5ae0b3e32 ) )
    {
        return [[ level.var_3d3494d5ae0b3e32 ]]();
    }
    
    switch ( s_exfil.exfil_difficulty )
    {
        case #"hash_883ff07272b4f9c":
            return s_exfil_activity_bundle.var_388a7349102a4a12;
        case #"hash_2ac407c1cd5943a9":
            return s_exfil_activity_bundle.var_ef39e81d4e5da867;
        case #"hash_35bb3bd014c77f4b":
            return s_exfil_activity_bundle.var_db562296b5d1b879;
        case #"hash_97430f6c58e61cbc":
            return s_exfil_activity_bundle.var_1d1e956ec8c79112;
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xbbc596ab, Offset: 0x29d2
// Size: 0x34
function on_exfil_ai_spawned( params )
{
    if ( issubstr( self.subclass, "zombie_base" ) )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "sprint", "exfil", 24 );
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0xbe5dca76, Offset: 0x2a0e
// Size: 0x147
function function_d09e3552ba50b071( player )
{
    level thread function_3d2d5c948faed88();
    player notify( #"cutscene_cleanup" );
    
    foreach ( other_player in level.players )
    {
        if ( player == other_player )
        {
            continue;
        }
        
        other_player notify( #"cutscene_cleanup" );
        other_player exfil::function_aafd590d53fc6ba4( self.s_exfil );
    }
    
    self makeunusable();
    self.s_exfil notify( #"end_exfil_timer" );
    level.b_zm_game_over = 1;
    function_c252ace0456096a7();
    callback::callback( "zm_exfil_success" );
    function_9ff5bd8f8a5ac994( self.s_exfil );
    level.var_1a7d5de49b6970b1 = 1;
    function_8f261015e4f861ae( 1 );
    level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
    iprintlnbold( "Entered Exfil Vehicle!" );
}

// Namespace zm_exfil
// Params 0, eflags: 0x4
// Checksum 0x8bc944ed, Offset: 0x2b5d
// Size: 0x22
function private function_3d2d5c948faed88()
{
    function_80f850545bc9c408( #"hash_3fcc2458faa42692" );
    function_80f850545bc9c408( #"hash_f1ec685f0b8b7f5e" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0x167c404, Offset: 0x2b87
// Size: 0x12d
function zm_exfil_complete()
{
    level thread function_3d2d5c948faed88();
    
    foreach ( player in level.players )
    {
        player notify( #"cutscene_cleanup" );
        player exfil::function_aafd590d53fc6ba4( self.s_exfil );
    }
    
    self makeunusable();
    self.s_exfil notify( #"end_exfil_timer" );
    function_49e1ca7d532b0fdd();
    function_c252ace0456096a7();
    level.b_zm_game_over = 1;
    function_9ff5bd8f8a5ac994( self.s_exfil );
    callback::callback( "zm_exfil_success" );
    level.var_1a7d5de49b6970b1 = 1;
    function_8f261015e4f861ae( 1 );
    level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
    iprintlnbold( "Entered Exfil Vehicle!" );
}

// Namespace zm_exfil
// Params 1
// Checksum 0xa075869, Offset: 0x2cbc
// Size: 0x95
function on_exfil_complete_timeout( s_exfil )
{
    if ( level.b_zm_game_over )
    {
        return;
    }
    
    level thread function_80f850545bc9c408( #"hash_1d427b779bd3714" );
    function_49e1ca7d532b0fdd();
    callback::callback( "zm_exfil_failure" );
    level.b_zm_game_over = 1;
    function_bc6e8d7fad337c27( s_exfil );
    level.var_1a7d5de49b6970b1 = 1;
    function_8f261015e4f861ae();
    level thread gamelogic_zm::endgame( "none", game[ "end_reason" ][ "objective_failed" ], game[ "end_reason" ][ "objective_failed" ] );
    level.b_zm_game_over = 1;
}

// Namespace zm_exfil
// Params 2
// Checksum 0xb3551326, Offset: 0x2d59
// Size: 0x219
function get_zm_exfil_scenes( s_exfil, str_scene_type )
{
    var_1fb0e131c89db725 = [];
    
    if ( isdefined( s_exfil.target2 ) )
    {
        a_s_structs = utility::getstructarray( s_exfil.target2, "targetname" );
        
        foreach ( var_16af6624858ffa21 in a_s_structs )
        {
            if ( var_16af6624858ffa21.script_noteworthy == str_scene_type )
            {
                var_1fb0e131c89db725 = arraycombineunique( var_1fb0e131c89db725, [ var_16af6624858ffa21 ] );
            }
            
            if ( str_scene_type == "scene_exfil_success" )
            {
                if ( isdefined( var_16af6624858ffa21.script_scenescriptbundle ) && issubstr( var_16af6624858ffa21.script_scenescriptbundle, "success" ) )
                {
                    var_1fb0e131c89db725 = arraycombineunique( var_1fb0e131c89db725, [ var_16af6624858ffa21 ] );
                }
                
                continue;
            }
            
            if ( str_scene_type == "scene_exfil_fail" )
            {
                if ( isdefined( var_16af6624858ffa21.script_scenescriptbundle ) && issubstr( var_16af6624858ffa21.script_scenescriptbundle, "fail" ) )
                {
                    var_1fb0e131c89db725 = arraycombineunique( var_1fb0e131c89db725, [ var_16af6624858ffa21 ] );
                }
            }
        }
    }
    
    if ( isdefined( s_exfil.var_42ada65a735fd2f3.target2 ) )
    {
        a_s_structs = utility::getstructarray( s_exfil.var_42ada65a735fd2f3.target2, "targetname" );
        
        foreach ( var_16af6624858ffa21 in a_s_structs )
        {
            if ( var_16af6624858ffa21.script_noteworthy == str_scene_type )
            {
                var_1fb0e131c89db725 = arraycombineunique( var_1fb0e131c89db725, [ var_16af6624858ffa21 ] );
            }
        }
    }
    
    return var_1fb0e131c89db725;
}

// Namespace zm_exfil
// Params 0
// Checksum 0x83659ee2, Offset: 0x2f7b
// Size: 0xcd
function kill_all_ai()
{
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, ai );
            
            if ( ai utility::ent_flag( "scene_active" ) )
            {
                continue;
            }
            
            if ( ai.magic_bullet_shield )
            {
                continue;
            }
            
            ai.nocorpse = 1;
            ai kill();
        }
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x68049c22, Offset: 0x3050
// Size: 0x15
function on_exfil_complete_kill_count( params )
{
    params thread function_593df7f219523463();
}

// Namespace zm_exfil
// Params 1
// Checksum 0x8a8b0370, Offset: 0x306d
// Size: 0xf3
function function_5eb9262e817a92ed( s_exfil )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"reach_site" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"reach_site_no_splash" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"kill_hostiles" );
    zm_quest::function_fba942a1cfd85f5d( 1, 0, #"exfil", #"escape" );
    zm_quest::function_fb3af5600f6a9441( 4, 0, #"exfil", #"reach_site_no_splash" );
    zm_quest::function_fb3af5600f6a9441( 4, 0, #"exfil", #"reach_site" );
    zm_quest::function_fb3af5600f6a9441( 4, 0, #"exfil", #"kill_hostiles" );
    zm_quest::function_fb3af5600f6a9441( 1, 0, #"exfil", #"escape" );
}

// Namespace zm_exfil
// Params 1
// Checksum 0x87280aa1, Offset: 0x3168
// Size: 0x2a9
function function_d1ef9820ea3bd7bc( s_exfil )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_b6c51a605daf0942 ) )
    {
        if ( self.var_3560f6b1ef954e6f )
        {
            utility::ent_flag_set( "played_reach_site_splash" );
            utility::ent_flag_set( "closed_reach_site_has_splash" );
        }
        
        self.var_b6c51a605daf0942 = 1;
    }
    
    if ( self.var_3560f6b1ef954e6f )
    {
        if ( utility::ent_flag( "played_reach_site_splash" ) && !utility::ent_flag( "closed_reach_site_has_splash" ) )
        {
            utility::ent_flag_set( "closed_reach_site_has_splash" );
            zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"reach_site" );
            zm_quest::function_fb3af5600f6a9441( 4, 0, #"exfil", #"reach_site" );
        }
        else
        {
            zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"reach_site_no_splash" );
            zm_quest::function_fb3af5600f6a9441( 4, 0, #"exfil", #"reach_site_no_splash" );
        }
        
        zm_quest::function_fba942a1cfd85f5d( 1, 0, #"exfil", #"kill_hostiles" );
        zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"escape" );
        zm_quest::function_fb3af5600f6a9441( 1, 0, #"exfil", #"kill_hostiles" );
        zm_quest::function_fb3af5600f6a9441( 0, 0, #"exfil", #"escape" );
        zm_quest::function_9f49b2a045ece8ae( exfil::function_664072bb6ca45820( s_exfil ), 0, #"exfil", #"kill_hostiles" );
        zm_quest::function_c2af37f835cd840b( exfil::function_7759b15fe5ee89e9( s_exfil ), 0, #"exfil", #"kill_hostiles" );
        return;
    }
    
    if ( !utility::ent_flag( "closed_reach_site_has_splash" ) )
    {
        utility::ent_flag_set( "played_reach_site_splash" );
        zm_quest::function_fba942a1cfd85f5d( 1, 0, #"exfil", #"reach_site" );
        zm_quest::function_fb3af5600f6a9441( 1, 0, #"exfil", #"reach_site" );
    }
    else
    {
        zm_quest::function_fba942a1cfd85f5d( 1, 0, #"exfil", #"reach_site_no_splash" );
        zm_quest::function_fb3af5600f6a9441( 1, 0, #"exfil", #"reach_site_no_splash" );
    }
    
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"kill_hostiles" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"escape" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"exfil", #"kill_hostiles" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"exfil", #"escape" );
}

// Namespace zm_exfil
// Params 1
// Checksum 0xe7b9848c, Offset: 0x3419
// Size: 0xe8
function function_884e764920227583( s_exfil )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !utility::ent_flag( "closed_reach_site_has_splash" ) )
    {
        zm_quest::function_fba942a1cfd85f5d( 1, 0, #"exfil", #"reach_site" );
    }
    else
    {
        zm_quest::function_fba942a1cfd85f5d( 1, 0, #"exfil", #"reach_site_no_splash" );
    }
    
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"kill_hostiles" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"escape" );
    zm_quest::function_fb3af5600f6a9441( 1, 0, #"exfil", #"reach_site" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"exfil", #"kill_hostiles" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"exfil", #"escape" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0x8c1ba646, Offset: 0x3509
// Size: 0xef
function function_49e1ca7d532b0fdd()
{
    foreach ( player in level.players )
    {
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"reach_site" );
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"reach_site_no_splash" );
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"kill_hostiles" );
        player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"exfil", #"escape" );
        player zm_quest::function_e66ab24194b8627e();
    }
}

// Namespace zm_exfil
// Params 2
// Checksum 0x77c5262b, Offset: 0x3600
// Size: 0x1fe
function function_f90cc615caca8f3a( s_exfil, n_exfil_timer )
{
    level endon( #"game_ended" );
    s_exfil endon( #"end_exfil_timer" );
    n_time_start_ms = gettime();
    var_3867b250a8978e46 = n_exfil_timer * 1000;
    var_f8afdc304bbf3ec = level.framedurationseconds;
    
    while ( true )
    {
        var_3718e9a05221fcc1 = gettime() - n_time_start_ms;
        n_time_left_ms = var_3867b250a8978e46 - var_3718e9a05221fcc1;
        n_time_left_ms = max( n_time_left_ms, 0 );
        n_time_left = n_time_left_ms / 1000;
        s_exfil.var_77be3669189a4fe3 = int( n_time_left );
        level notify( #"exfil_time_remaining", s_exfil.var_77be3669189a4fe3, s_exfil );
        
        foreach ( player in level.players )
        {
            if ( player.var_3560f6b1ef954e6f )
            {
                player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"exfil", #"kill_hostiles" );
                continue;
            }
            
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"exfil", #"reach_site" );
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"exfil", #"reach_site_no_splash" );
        }
        
        if ( s_exfil.var_77be3669189a4fe3 < 25 )
        {
            if ( utility::issharedfuncdefined( #"status_effects", #"hash_5a9731327b5c2a13" ) )
            {
                utility::callsharedfunc( #"status_effects", #"hash_5a9731327b5c2a13", "toxic" );
            }
        }
        
        if ( n_time_left_ms <= 0 )
        {
            function_49e1ca7d532b0fdd();
            return;
        }
        
        wait var_f8afdc304bbf3ec;
    }
}

// Namespace zm_exfil
// Params 0
// Checksum 0xe59b4ee7, Offset: 0x3806
// Size: 0x84
function function_593df7f219523463()
{
    level endon( #"game_ended" );
    self endon( #"end_exfil_timer" );
    
    while ( true )
    {
        level waittill( #"exfil_time_remaining", var_77be3669189a4fe3, s_exfil );
        
        if ( var_77be3669189a4fe3 <= 0 )
        {
            if ( isdefined( s_exfil.vh_exfil.interact ) )
            {
                s_exfil.vh_exfil.interact thread zm_exfil_complete();
                break;
            }
        }
    }
}

// Namespace zm_exfil
// Params 1
// Checksum 0x3d62d1f1, Offset: 0x3892
// Size: 0x2ea
function function_9ff5bd8f8a5ac994( s_exfil )
{
    setomnvarforallclients( "post_game_state", 20 );
    musicbank_utility::function_4f253fd35ec68cbc( level.players, "exfil" );
    
    foreach ( player in level.players )
    {
        player notify( #"cutscene_cleanup" );
        player.var_b9a43612c09a3d01 = 1;
        player thread zm_laststand::zm_laststand_fade_before_game_over_scene( 0, "exfil_fade_in" );
    }
    
    var_1fb0e131c89db725 = s_exfil.var_dd154fe527c5609;
    
    if ( s_exfil.vh_exfil )
    {
        s_exfil.vh_exfil.animname = "helicopter";
    }
    
    if ( var_1fb0e131c89db725.size > 0 )
    {
        s_exfil.vh_exfil exfil::exfil_vehicle_delete();
        level.var_13a27bc8430578c3[ "helicopter" ] = level.var_efa59ce269f371c8;
        level.var_13a27bc8430578c3[ "Helicopter" ] = level.var_efa59ce269f371c8;
        s_scene = utility::array_random( var_1fb0e131c89db725 );
        kill_all_ai();
        s_scene scene::add_scene_func( s_scene, &function_653cf7ed60f97d74, "callback_play" );
        s_scene scene::add_spawn_function( &function_c73d97d408379a6c );
        s_scene scene::pre_stream_play( 2, s_exfil.vh_exfil );
        level.var_13a27bc8430578c3[ "helicopter" ] = undefined;
        level.var_13a27bc8430578c3[ "Helicopter" ] = undefined;
    }
    else
    {
        foreach ( player in level.players )
        {
            player notify( #"exfil_fade_in" );
        }
        
        s_exfil.vh_exfil thread exfil::function_82f71643e34041a8( s_exfil );
        wait 4;
    }
    
    foreach ( player in level.players )
    {
        player thread zm_laststand::function_7b86ac5fadba1063();
        player thread function_a1414156912985c8();
        player.var_b9a43612c09a3d01 = undefined;
        player val::reset_all( "play_exfil_scene" );
    }
    
    utility::flag_set( "zm_exfil_scene_done" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0x9c4372bb, Offset: 0x3b84
// Size: 0x84
function function_653cf7ed60f97d74()
{
    foreach ( player in level.players )
    {
        player notify( #"exfil_fade_in" );
    }
    
    removeallcorpses();
}

// Namespace zm_exfil
// Params 0
// Checksum 0xeee0bc53, Offset: 0x3c10
// Size: 0x5f
function function_a1414156912985c8()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    spawnpoint = spawnstruct();
    spawnpoint.origin = self.origin;
    spawnpoint.angles = self.angles;
    playerlogic::spawnintermission( spawnpoint, undefined, 0 );
}

// Namespace zm_exfil
// Params 1
// Checksum 0xe63bb25b, Offset: 0x3c77
// Size: 0x389
function function_bc6e8d7fad337c27( s_exfil )
{
    function_c252ace0456096a7();
    setomnvarforallclients( "post_game_state", 20 );
    musicbank_utility::function_4f253fd35ec68cbc( level.players, "exfil" );
    
    foreach ( player in level.players )
    {
        player notify( #"cutscene_cleanup" );
        player.var_b9a43612c09a3d01 = 1;
        player thread zm_laststand::zm_laststand_fade_before_game_over_scene( 0, "exfil_fade_in" );
    }
    
    var_1fb0e131c89db725 = s_exfil.var_8cb3ff5a98b1bc8;
    
    if ( isdefined( s_exfil.vh_exfil ) )
    {
        s_exfil.vh_exfil.animname = "helicopter";
    }
    
    if ( var_1fb0e131c89db725.size > 0 )
    {
        s_exfil.vh_exfil exfil::exfil_vehicle_delete();
        level.var_13a27bc8430578c3[ "helicopter" ] = level.var_efa59ce269f371c8;
        level.var_13a27bc8430578c3[ "Helicopter" ] = level.var_efa59ce269f371c8;
        s_scene = utility::array_random( var_1fb0e131c89db725 );
        kill_all_ai();
        s_scene scene::add_scene_func( s_scene, &function_653cf7ed60f97d74, "callback_play" );
        s_scene scene::add_spawn_function( &function_c73d97d408379a6c );
        s_scene scene::pre_stream_play( 2, s_exfil.vh_exfil );
        level.var_13a27bc8430578c3[ "helicopter" ] = undefined;
        level.var_13a27bc8430578c3[ "Helicopter" ] = undefined;
    }
    else
    {
        foreach ( player in level.players )
        {
            player notify( #"exfil_fade_in" );
        }
        
        s_exfil.vh_exfil thread exfil::function_82f71643e34041a8( s_exfil );
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_hide_hud", 1 );
    }
    
    foreach ( player in level.players )
    {
        player thread zm_laststand::function_7b86ac5fadba1063();
        player.var_b9a43612c09a3d01 = undefined;
        player val::reset_all( "play_exfil_scene" );
        
        if ( isalive( player ) && player.sessionstate != "spectator" )
        {
            player utility::delaycall( 0.05, &suicide );
        }
    }
    
    utility::flag_set( "zm_exfil_scene_done" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0x847c74e6, Offset: 0x4008
// Size: 0x2ed
function function_c252ace0456096a7()
{
    cleanup_sentry_guns();
    level.var_3327cc6ea7faa2ba = 1;
    common_item::cleanup_all_items();
    var_255fa9c415d2f7c2 = getentitylessscriptablearray( level.s_exfil_active.var_42ada65a735fd2f3.target, #targetname );
    
    foreach ( var_bfb9424e344026e0 in var_255fa9c415d2f7c2 )
    {
        var_bfb9424e344026e0 setscriptablepartstate( "chevron_0", "off" );
    }
    
    utility::callsharedfunc( #"mutant_injection", #"force_exit_mutant_injection", 0 );
    powerup_root = powerups::get_powerups_root();
    
    if ( isarray( powerup_root.active_powerups ) )
    {
        foreach ( powerup in powerup_root.active_powerups )
        {
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, powerup );
            
            if ( powerup.mesh_mdl )
            {
                powerup.mesh_mdl delete();
            }
            
            if ( powerup )
            {
                powerup delete();
            }
        }
    }
    
    utility::delaythread( 3, &zm_laststand::function_3b2825685e8bfee8 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player isparachuting() )
        {
            player skydive_interrupt();
        }
        
        player val::set( "play_exfil_scene", "killstreaks", 0 );
        player val::set( "play_exfil_scene", "equipment_primary", 0 );
        player val::set( "play_exfil_scene", "equipment_secondary", 0 );
        
        if ( player::isinlaststand( player ) )
        {
            player laststand::last_stand_exit_postfx();
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player.var_14955bc056bab547 = 1;
            player.var_1e503ec3975df6f0 = 0;
            player thread playerlogic::spawnclient();
            player utility::waittill_any_timeout( 3, "spawned_player" );
        }
    }
}

// Namespace zm_exfil
// Params 0
// Checksum 0x967180e0, Offset: 0x42fd
// Size: 0x93
function cleanup_sentry_guns()
{
    var_294f90bddc79e02d = getentarray( "misc_turret", "classname" );
    
    foreach ( turret in var_294f90bddc79e02d )
    {
        turret notify( #"kill_turret", 1, 0 );
    }
}

// Namespace zm_exfil
// Params 0
// Checksum 0x31eeaa4e, Offset: 0x4398
// Size: 0x56
function function_c73d97d408379a6c()
{
    if ( isai( self ) )
    {
        val::set( "exfil_scene", "damage", 0 );
        self.var_2902ca09e32bd7d8 = 1;
        self.b_ignore_water_check = 1;
        val::set( "exfil_scene", "ignore_cleanup", 1 );
        self.b_ignore_death_perception = 1;
        self function_e8726d980fa12944();
    }
}

// Namespace zm_exfil
// Params 2
// Checksum 0x7ab44cc3, Offset: 0x43f6
// Size: 0xf0
function function_49bd8db2b945a462( str_ai_spawn_list, var_ac07512145efb190 )
{
    s_exfil_activity_bundle = exfil::function_3e68f7962cd82ad3();
    
    if ( !isdefined( level.var_560d13ea37920b75 ) )
    {
        level.var_560d13ea37920b75 = 1;
    }
    
    switch ( var_ac07512145efb190 )
    {
        case 1:
            n_spawn_count = s_exfil_activity_bundle.var_ed1df59cd2a373d ?? 35;
            break;
        case 2:
            n_spawn_count = s_exfil_activity_bundle.var_ed5c559cd2df3e6 ?? 47;
            break;
        case 3:
            n_spawn_count = s_exfil_activity_bundle.var_edacb59cd3429ef ?? 60;
            break;
        case 4:
        default:
            n_spawn_count = s_exfil_activity_bundle.var_ebbc159cd11c210 ?? 71;
            break;
    }
    
    return int( level.var_560d13ea37920b75 * n_spawn_count );
}

// Namespace zm_exfil
// Params 2
// Checksum 0x7d0c199e, Offset: 0x44ef
// Size: 0x574
function zm_exfil_opt_in( s_exfil, var_5a5626a7d4b2feb )
{
    if ( utility::flag( "zm_vote_active" ) )
    {
        return 0;
    }
    
    utility::flag_set( "zm_vote_active" );
    s_exfil.a_potential_players = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            s_exfil.a_potential_players[ s_exfil.a_potential_players.size ] = player;
            player thread hud_message::showsplash( "zm_exfil_initiated", undefined, var_5a5626a7d4b2feb );
        }
    }
    
    n_potential_players = s_exfil.a_potential_players.size;
    
    foreach ( player in s_exfil.a_potential_players )
    {
        if ( isplayer( player ) && soundexists( "uin_ob_splash_exfil_available" ) )
        {
            player playlocalsound( "uin_ob_splash_exfil_available" );
        }
    }
    
    var_adaf055e5d71bfbc = vote_system_shared::function_47e42a6b3e1c8e82( s_exfil.a_potential_players );
    utility::array_thread( s_exfil.a_potential_players, &function_f2e1afb2334c1bef, s_exfil, 10, var_5a5626a7d4b2feb, var_adaf055e5d71bfbc );
    var_3faf858e79cd17bb = { #description:&"hash_49ba07c686ce3ed7", #init_message:&"hash_566f3c48dd706eaf" };
    var_eeccc79870c8f6cc = vote_system_shared::function_d2da42a6b09b2c9( var_5a5626a7d4b2feb, var_3faf858e79cd17bb, level.var_ee4ca19d4f6062f2, s_exfil.a_exfil_players, var_adaf055e5d71bfbc );
    s_squad = vote_system_shared::function_5b06e345046c1f58();
    vote_system_shared::function_ffdd1bfcb0dbe696( var_eeccc79870c8f6cc, var_3faf858e79cd17bb, s_squad, 1, 0 );
    level thread function_f4745089edc837f7( s_exfil, var_adaf055e5d71bfbc );
    
    if ( s_exfil.a_exfil_players.size < s_exfil.a_potential_players.size )
    {
        s_exfil utility::waittill_any_timeout( 10, "exfil_opt_in_done" );
    }
    
    s_exfil notify( #"exfil_opt_in_done" );
    s_exfil.a_exfil_players = function_5713d46873b29625( s_exfil.a_exfil_players );
    var_a05a4a9cbb4a3ab9 = s_exfil.a_exfil_players.size >= var_adaf055e5d71bfbc;
    var_eeccc79870c8f6cc = vote_system_shared::function_2ffcb16b23fc1761( level.var_ee4ca19d4f6062f2, s_exfil.a_exfil_players, [], var_adaf055e5d71bfbc );
    s_squad = vote_system_shared::function_5b06e345046c1f58();
    vote_system_shared::function_2740338293f3a3ea( var_eeccc79870c8f6cc, var_a05a4a9cbb4a3ab9, s_squad );
    vote_system_shared::function_d65c80eaf108da5d( var_eeccc79870c8f6cc, 4, s_squad );
    
    if ( !var_a05a4a9cbb4a3ab9 )
    {
        foreach ( player in s_exfil.a_exfil_players )
        {
            player.s_exfil = undefined;
        }
        
        s_exfil.a_exfil_players = [];
        level.s_exfil_active = undefined;
        wait 1;
        s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 1, 0 );
        utility::flag_clear( "zm_vote_active" );
        return 0;
    }
    
    zombies = getaiarray( "team_two_hundred" );
    
    foreach ( zombie in zombies )
    {
        zombie.var_71ad3441c363e3a9 = 1;
    }
    
    s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 0 );
    s_exfil notify( #"hash_38aa0d5d2049ee62" );
    s_exfil.a_exfil_players[ 0 ] nuke::function_abd449c71a89e094( "nuke", s_exfil.mdl_exfil, 1, 1 );
    
    foreach ( player in s_exfil.a_exfil_players )
    {
        activity_participation::function_bc67362dace4370c( s_exfil.s_activity_instance, player );
    }
    
    if ( !getdvarint( @"hash_ccef2121830537e5", 0 ) )
    {
        utility::array_thread( s_exfil.a_exfil_players, &hud_message::showsplash, "cp_mp_exfil_inbound" );
    }
    
    level thread function_6f6e9fe951af2e4e( s_exfil );
    level callback::callback( "zm_exfil_started", { #var_5a5626a7d4b2feb:var_5a5626a7d4b2feb, #a_exfil_players:s_exfil.a_exfil_players, #s_exfil:s_exfil } );
    wait 2;
    utility::flag_clear( "zm_vote_active" );
    return 1;
}

// Namespace zm_exfil
// Params 1
// Checksum 0x429a8954, Offset: 0x4a6b
// Size: 0x59
function function_6f6e9fe951af2e4e( s_exfil )
{
    utility::flag_wait( "exfil_start_operator_vo_played" );
    function_80f850545bc9c408( #"hash_6159b197d58be4cf" );
    s_exfil thread function_a3af0029e5c24280();
    s_exfil thread function_c86144878da68f3c();
    s_exfil thread function_450bdd2c24b4cc7e();
    s_exfil thread function_193bb98f8fe013bb( 30 );
    s_exfil thread function_193bb98f8fe013bb( 15 );
}

// Namespace zm_exfil
// Params 4
// Checksum 0xdfae0244, Offset: 0x4acc
// Size: 0x1a2
function function_f2e1afb2334c1bef( s_exfil, n_time, var_5a5626a7d4b2feb, var_adaf055e5d71bfbc )
{
    var_f9073b9a68fe2fe = n_time ?? 10;
    self.var_28eba4283d3b4190 = 1;
    thread exfil::function_8f558ac84185c259( var_f9073b9a68fe2fe );
    utility::ent_flag_set( "waiting_for_vote" );
    
    while ( isalive( self ) && var_f9073b9a68fe2fe >= 0 )
    {
        if ( self.var_62c769ea7a03f7b8 || var_5a5626a7d4b2feb == self || s_exfil.a_exfil_players.size >= var_adaf055e5d71bfbc )
        {
            self.s_exfil = s_exfil;
            s_exfil.a_exfil_players = arraycombineunique( s_exfil.a_exfil_players, [ self ] );
            
            if ( s_exfil.a_exfil_players.size >= s_exfil.a_potential_players.size )
            {
                s_exfil notify( #"exfil_opt_in_done" );
            }
            
            callback::callback( "on_exfil_player_joined", s_exfil );
            self notify( #"exfil_opt_in_done" );
            break;
        }
        else if ( self.var_5918064de972f502 )
        {
            s_exfil.a_potential_players = arrayremove( s_exfil.a_potential_players, self );
            
            if ( s_exfil.a_exfil_players.size >= s_exfil.a_potential_players.size )
            {
                s_exfil notify( #"exfil_opt_in_done" );
            }
            
            self notify( #"exfil_opt_in_done" );
            break;
        }
        
        waitframe();
        var_f9073b9a68fe2fe -= level.framedurationseconds;
    }
    
    if ( isdefined( self ) )
    {
        self.var_28eba4283d3b4190 = undefined;
        self.var_62c769ea7a03f7b8 = undefined;
        self.var_5918064de972f502 = undefined;
        thread vote_system_shared::function_64400cb8ec45efe6();
    }
}

// Namespace zm_exfil
// Params 2
// Checksum 0x68bb81b0, Offset: 0x4c76
// Size: 0x58
function function_c0ce2e85341e0b7c( s_exfil, var_adaf055e5d71bfbc )
{
    var_eeccc79870c8f6cc = vote_system_shared::function_2ffcb16b23fc1761( level.var_ee4ca19d4f6062f2, s_exfil.a_exfil_players, [], var_adaf055e5d71bfbc );
    s_squad = vote_system_shared::function_5b06e345046c1f58();
    vote_system_shared::function_5957b1eb0fdb5b1e( var_eeccc79870c8f6cc, s_squad );
}

// Namespace zm_exfil
// Params 2
// Checksum 0xa97fb698, Offset: 0x4cd6
// Size: 0x46
function function_f4745089edc837f7( s_exfil, var_adaf055e5d71bfbc )
{
    level endon( #"game_ended" );
    s_exfil endon( #"exfil_opt_in_done" );
    
    while ( true )
    {
        function_c0ce2e85341e0b7c( s_exfil, var_adaf055e5d71bfbc );
        wait 0.5;
    }
}

// Namespace zm_exfil
// Params 0
// Checksum 0x159ef4f, Offset: 0x4d24
// Size: 0x12
function function_e6ec4f11056ffdc7()
{
    vote_system_shared::function_8d3121fa204f0320( level.var_ee4ca19d4f6062f2 );
}

// Namespace zm_exfil
// Params 1
// Checksum 0x658293d2, Offset: 0x4d3e
// Size: 0x3b
function function_df67c49bcf9fe9f1( s_exfil )
{
    if ( isdefined( s_exfil.var_42ada65a735fd2f3.script_int ) )
    {
        return s_exfil.var_42ada65a735fd2f3.script_int;
    }
}

// Namespace zm_exfil
// Params 0
// Checksum 0xe0d77d23, Offset: 0x4d82
// Size: 0x2b
function function_a3af0029e5c24280()
{
    level endon( #"game_ended" );
    utility::ent_flag_wait( "player_reached_exfil" );
    level thread function_80f850545bc9c408( #"hash_ceb82bebd79eac26" );
}

// Namespace zm_exfil
// Params 1
// Checksum 0xaf00b96f, Offset: 0x4db5
// Size: 0x8a
function function_193bb98f8fe013bb( time )
{
    level endon( #"game_ended" );
    self endon( #"end_exfil_timer" );
    str_vo = [];
    
    if ( time == 30 )
    {
        str_vo = #"hash_b61989bea2abd1a4";
    }
    else if ( time == 15 )
    {
        str_vo = #"hash_f5e42cde4ddde9a5";
    }
    
    while ( true )
    {
        if ( isdefined( self.var_77be3669189a4fe3 ) )
        {
            if ( self.var_77be3669189a4fe3 == time )
            {
                level thread function_80f850545bc9c408( str_vo );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_exfil
// Params 0
// Checksum 0x1d234ef1, Offset: 0x4e47
// Size: 0x2c
function function_c86144878da68f3c()
{
    level endon( #"game_ended" );
    self waittill( #"chopper_arrival" );
    level thread function_80f850545bc9c408( #"hash_65eae433d73bff4c" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0xac848d07, Offset: 0x4e7b
// Size: 0x2c
function function_450bdd2c24b4cc7e()
{
    level endon( #"game_ended" );
    self waittill( #"chopper_landing" );
    level thread function_80f850545bc9c408( #"hash_5f00d22d2a5206a" );
}

// Namespace zm_exfil
// Params 1
// Checksum 0x4fb01da9, Offset: 0x4eaf
// Size: 0xd9
function function_8f261015e4f861ae( var_9d6a772a7881a455 )
{
    setomnvarforallclients( "post_game_state", 1 );
    wait 2.05;
    
    if ( var_9d6a772a7881a455 )
    {
        setomnvarforallclients( "ui_dmz_extract_successful", 1 );
    }
    
    setomnvarforallclients( "ui_br_squad_eliminated_active", 1 );
    
    foreach ( player in level.players )
    {
        if ( var_9d6a772a7881a455 )
        {
            player playlocalsound( #"hash_a53e1ebf9c8b09d" );
            continue;
        }
        
        player playlocalsound( #"hash_58071393496dd03e" );
    }
    
    wait 1.75;
}

// Namespace zm_exfil
// Params 1
// Checksum 0x3ab3a77f, Offset: 0x4f90
// Size: 0x18a
function function_78b65ade21a8180b( pos )
{
    spawndata = spawnstruct();
    spawndata.origin = function_be4318402c9c1594( pos );
    spawndata.angles = ( 0, 0, 0 );
    spawndata.spawntype = "GAME_MODE";
    spawndata.var_499a16b493ff31ed = 1;
    spawndata.triggerrecycle = 1;
    spawndata.script_modelname = level.var_efa59ce269f371c8;
    var_b495c301a2d29735 = activity_definition_utils::getactivitydefinition( level.var_a347479bbc614700 );
    s_exfil_activity_bundle = activity_definition_utils::function_9129cd8075c85c09( var_b495c301a2d29735 );
    var_944b42c82cee9a53 = s_exfil_activity_bundle.var_48ea3f48f1624ab3 ?? "veh9_palfa";
    var_ace202d0c6b9306a = 0;
    
    while ( true )
    {
        vh_exfil = vehicle::spawn( var_944b42c82cee9a53, spawndata );
        
        if ( isdefined( vh_exfil ) )
        {
            break;
        }
        
        var_ace202d0c6b9306a++;
        wait 1;
        
        if ( var_ace202d0c6b9306a > 15 )
        {
            spawndata.origin = pos + ( 0, 0, 1000 );
        }
    }
    
    vh_exfil forcenetfieldhighlod( 1 );
    vh_exfil vehicle_setspeed( 1, 1 );
    vh_exfil setvehgoalpos( spawndata.origin, 1 );
    vehicle_interact::allow_use( vh_exfil, 0 );
    vh_exfil.godmode = 1;
    vh_exfil val::set( "exfil", "vehicle_disallow_lockon", 1 );
    vh_exfil vehicle_code::vehicle_disable_navobstacles();
    return vh_exfil;
}

// Namespace zm_exfil
// Params 1
// Checksum 0x5fb07b75, Offset: 0x5123
// Size: 0x9a
function zm_helo_move_to_point( var_4b4e6b999024cf0d )
{
    if ( !isdefined( str_surface_type ) )
    {
        str_surface_type = "air";
    }
    
    if ( !isdefined( n_speed ) )
    {
        n_speed = 25;
    }
    
    if ( !isdefined( var_c3b47bc557abe0e9 ) )
    {
        var_c3b47bc557abe0e9 = 15;
    }
    
    v_end = var_4b4e6b999024cf0d.origin;
    v_ang = var_4b4e6b999024cf0d.angles;
    self vehicle_setspeed( n_speed * 3, var_c3b47bc557abe0e9 );
    exfil::function_1e41fd9b66088249( v_end, 0, v_ang );
    thread exfil::function_4f2b50cdb23bab82();
    self waittill( #"goal" );
}

// Namespace zm_exfil
// Params 1
// Checksum 0xf73e7c4f, Offset: 0x51c5
// Size: 0x13c
function function_1da755bc90faa2d1( var_4b4e6b999024cf0d )
{
    if ( !isdefined( str_surface_type ) )
    {
        str_surface_type = "air";
    }
    
    if ( !isdefined( n_speed ) )
    {
        n_speed = 25;
    }
    
    if ( !isdefined( var_c3b47bc557abe0e9 ) )
    {
        var_c3b47bc557abe0e9 = 15;
    }
    
    v_end = var_4b4e6b999024cf0d.origin;
    v_ang = var_4b4e6b999024cf0d.angles;
    
    if ( !isdefined( v_end ) )
    {
        pathrandomness = 150;
        halfdistance = 25000;
        yaw = self.angles[ 1 ];
        direction = ( 0, yaw, 0 );
        v_end = self.origin + anglestoforward( direction ) * halfdistance;
        
        if ( str_surface_type == "air" )
        {
            v_end_z = max( v_end[ 2 ], getdvarfloat( @"hash_7f6b2729e5a85bb5", 6000 ) );
            v_end = ( v_end[ 0 ], v_end[ 1 ], v_end_z );
        }
    }
    
    self vehicle_setspeed( n_speed * 3, var_c3b47bc557abe0e9 );
    exfil::function_1e41fd9b66088249( v_end, 0, v_ang );
    thread exfil::function_4f2b50cdb23bab82();
    self waittill( #"goal" );
    vehicle_tracking::delete_vehicle( self );
    vehicle_tracking::reserve_vehicle();
}

// Namespace zm_exfil
// Params 1
// Checksum 0x3a9798cb, Offset: 0x5309
// Size: 0x54
function function_80f850545bc9c408( event_name )
{
    level endon( #"game_ended" );
    utility::flag_set( "exfil_vo_event_playing" );
    vo_events = zm_quest::function_9394bf2845454024( event_name );
    zm_quest::play_vo_events( vo_events );
    utility::delaythread( 3, &utility::flag_clear, "exfil_vo_event_playing" );
}

// Namespace zm_exfil
// Params 0
// Checksum 0xef4fe684, Offset: 0x5365
// Size: 0x94
function function_b7b6327aa8e97928()
{
    foreach ( s_exfil in level.var_e584ab91aed38e8c )
    {
        s_exfil notify( #"hash_38aa0d5d2049ee62" );
        s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 0 );
    }
}

/#

    // Namespace zm_exfil
    // Params 0
    // Checksum 0x9f49fa1c, Offset: 0x5401
    // Size: 0x26c, Type: dev
    function zm_exfil_devgui()
    {
        utility::flag_wait( "<dev string:x54>" );
        devgui::function_9082edeb5db93280( "<dev string:x67>" );
        
        foreach ( s_exfil in level.var_e584ab91aed38e8c )
        {
            devgui::function_cd4e263c1f3018ae( s_exfil.name, "<dev string:x8a>" + s_exfil.name, &function_af7242616e8d77e7 );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xa0>" );
        success_nodes = utility::getstructarray( "<dev string:xb3>", "<dev string:xc7>" );
        failed_nodes = utility::getstructarray( "<dev string:xd9>", "<dev string:xc7>" );
        level.exfil_scene_nodes = arraycombine( success_nodes, failed_nodes );
        var_ff3d04d0a67871f9 = [];
        
        foreach ( scene_node in level.exfil_scene_nodes )
        {
            if ( isdefined( scene_node.var_d69404e803a096ca ) )
            {
                var_851274f1ae86af93 = scene_node.script_scenescriptbundle + "<dev string:xea>" + scene_node.var_d69404e803a096ca;
            }
            else
            {
                var_851274f1ae86af93 = scene_node.script_scenescriptbundle;
            }
            
            devgui::function_cd4e263c1f3018ae( "<dev string:xec>" + var_851274f1ae86af93, "<dev string:xff>" + var_851274f1ae86af93, &devgui_play_exfil_scene );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x111>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x121>", "<dev string:x136>", &function_57b7e9ae1bfe342d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x13d>", "<dev string:x14c>", &test_end_movie );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15b>", "<dev string:x171>", &cleanup_powerups );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x182>" );
        devgui::add_devgui_func( "<dev string:x18f>", "<dev string:x19d>", &cut_parachute );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_exfil
    // Params 1
    // Checksum 0x107c8fd8, Offset: 0x5675
    // Size: 0x3e, Type: dev
    function cut_parachute( params )
    {
        if ( level.players[ 0 ] isparachuting() )
        {
            level.players[ 0 ] skydive_interrupt();
            
            /#
                iprintlnbold( "<dev string:x1ab>" );
            #/
        }
    }

    // Namespace zm_exfil
    // Params 1
    // Checksum 0xa92df673, Offset: 0x56bb
    // Size: 0xcc, Type: dev
    function cleanup_powerups( params )
    {
        powerup_root = powerups::get_powerups_root();
        
        if ( isarray( powerup_root.active_powerups ) )
        {
            foreach ( powerup in powerup_root.active_powerups )
            {
                throttle::throttle_wait_in_queue( level.zm_exfil_throttle, powerup );
                powerup.mesh_mdl delete();
                powerup delete();
            }
        }
    }

    // Namespace zm_exfil
    // Params 1
    // Checksum 0xbcc43945, Offset: 0x578f
    // Size: 0x59, Type: dev
    function test_end_movie( params )
    {
        level.players[ 0 ] setclientomnvar( "<dev string:x1b9>", 1 );
        setomnvarforallclients( "<dev string:x1d3>", 1 );
        level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "<dev string:x1f1>" ), game[ "<dev string:x1f8>" ][ "<dev string:x203>" ] );
    }

    // Namespace zm_exfil
    // Params 1
    // Checksum 0x74c31f17, Offset: 0x57f0
    // Size: 0x2da, Type: dev
    function devgui_play_exfil_scene( params )
    {
        self notify( #"hash_4842f45a58213862" );
        self endon( #"hash_4842f45a58213862" );
        var_64af815746cd2fd0 = strtok( params[ 0 ], "<dev string:xea>" );
        str_scene_selected = var_64af815746cd2fd0[ 0 ];
        var_d69404e803a096ca = var_64af815746cd2fd0[ 1 ];
        
        if ( isdefined( var_d69404e803a096ca ) )
        {
            var_d69404e803a096ca = int( var_d69404e803a096ca );
        }
        
        foreach ( root in level.exfil_scene_nodes )
        {
            if ( str_scene_selected == root.script_scenescriptbundle && ( !isdefined( var_d69404e803a096ca ) || var_d69404e803a096ca == root.var_d69404e803a096ca ) )
            {
                scene_node = root;
                break;
            }
        }
        
        zm_round_spawning::pause_round_spawning( 1, "<dev string:x217>" );
        zm_utility::util_kill_all_zombies();
        utility::delaythread( 3, &zm_laststand::function_3b2825685e8bfee8 );
        scene::add_scene_func( scene_node, &function_653cf7ed60f97d74, "<dev string:x22c>" );
        scene_node scene::add_spawn_function( &function_c73d97d408379a6c );
        function_c252ace0456096a7();
        
        foreach ( player in level.players )
        {
            player notify( #"cutscene_cleanup" );
            player.var_b9a43612c09a3d01 = 1;
            player thread zm_laststand::zm_laststand_fade_before_game_over_scene( 0, "<dev string:x23a>" );
        }
        
        level.var_13a27bc8430578c3[ "<dev string:x248>" ] = level.var_efa59ce269f371c8;
        level.var_13a27bc8430578c3[ "<dev string:x253>" ] = level.var_efa59ce269f371c8;
        scene_node scene::pre_stream_play( 2 );
        zm_round_spawning::pause_round_spawning( 0, "<dev string:x217>" );
        level.var_13a27bc8430578c3[ "<dev string:x248>" ] = undefined;
        level.var_13a27bc8430578c3[ "<dev string:x253>" ] = undefined;
        
        foreach ( player in level.players )
        {
            player.var_b9a43612c09a3d01 = undefined;
            player val::reset_all( "<dev string:x25e>" );
        }
    }

    // Namespace zm_exfil
    // Params 1
    // Checksum 0x146bbfed, Offset: 0x5ad2
    // Size: 0x173, Type: dev
    function function_57b7e9ae1bfe342d( params )
    {
        var_cb86104ee52b9fe6 = 0;
        
        foreach ( player in level.players )
        {
            if ( vote_system_shared::function_48e94cd3f360f966( level.var_ee4ca19d4f6062f2, player ) )
            {
                var_cb86104ee52b9fe6 = 1;
                break;
            }
        }
        
        if ( var_cb86104ee52b9fe6 )
        {
            vote_system_shared::function_8d3121fa204f0320( level.var_ee4ca19d4f6062f2 );
            return;
        }
        
        foreach ( player in level.players )
        {
            var_eeccc79870c8f6cc = vote_system_shared::function_2ffcb16b23fc1761( level.var_ee4ca19d4f6062f2, [], [], level.players.size - 1, player );
            var_e3654cb1d4a135f5 = vote_system_shared::function_958e8663104a59ed( [ player ] );
            vote_system_shared::function_ffdd1bfcb0dbe696( var_eeccc79870c8f6cc, undefined, var_e3654cb1d4a135f5, 1, 0 );
        }
    }

    // Namespace zm_exfil
    // Params 1
    // Checksum 0x51204e56, Offset: 0x5c4d
    // Size: 0xa6, Type: dev
    function function_af7242616e8d77e7( params )
    {
        s_exfil = exfil::function_4c8ac0dbd10c57( params[ 0 ] );
        s_exfil.var_b699cd3a775ac6e1 = !s_exfil.var_b699cd3a775ac6e1;
        
        if ( s_exfil.var_b699cd3a775ac6e1 )
        {
            iprintlnbold( "<dev string:x26f>" );
            s_exfil notify( #"hash_38aa0d5d2049ee62" );
            s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 1 );
            return;
        }
        
        iprintlnbold( "<dev string:x287>" );
        s_exfil notify( #"hash_38aa0d5d2049ee62" );
        s_exfil.mdl_exfil zm_exfil_objective_icon( s_exfil, 0 );
    }

#/
