// scripts\mp\zm\gametypes\zm_rb_battle.gsc  (hash_3c3d55308e3ac31b.gscc) (size: 22084 Bytes / 0x5644 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc56ef908 (3312384264)
// size ...... 22084 (0x5644)
// includes .. 25  (offset: 0x4f4c)
// strings ... 87  (offset: 0x5014)
// dev strs .. 15  (offset: 0x5588)
// exports ... 65  (offset: 0x30c8)
// cseg ...... 0x72a + 0x299e (0x30c8)
// imports ... 168 (offset: 0x3af0)
// animtree1 . 0   (offset: 0x5644)
// animtree2 . 0   (offset: 0x5644)
#using script_16ea1b94f0f381b3;
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\gametypes\zm_rb;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_player_damage;
#using scripts\mp\zm\zm_utility;

#namespace zm_rb_battle;

// Namespace zm_rb_battle
// Params 0, eflags: 0x5
// Checksum 0x7d4ba712, Offset: 0x748
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_rb_battle", undefined, &pre_main, &post_main );
}

// Namespace zm_rb_battle
// Params 0
// Checksum 0xce0fcf6, Offset: 0x76d
// Size: 0x36c
function main()
{
    level.var_309f8f867be84cac = level.callbackplayerdamage;
    utility::add_fx( "zm_battle_round_turn_zombie_fx", "vfx_sat_gameplay_zm_battle_zombie_upgrade" );
    utility::add_fx( "zm_battle_zombie_dot_beam_fx_pink", "vfx_sat_gameplay_zm_battle_tethering_variant_beam_pink" );
    utility::add_fx( "zm_battle_zombie_dot_beam_fx_green", "vfx_sat_gameplay_zm_battle_tethering_variant_beam_green" );
    utility::add_fx( "zm_battle_zombie_dot_beam_fx_blue", "vfx_sat_gameplay_zm_battle_tethering_variant_beam_blue" );
    utility::add_fx( "zm_battle_zombie_dot_beam_fx_orange", "vfx_sat_gameplay_zm_battle_tethering_variant_beam_orange" );
    level callback::add( #"init_shared_func", &function_4a858a1890a40761 );
    level callback::add( #"prematch_done", &on_prematch_done );
    zm_rb::main();
    level.var_7ba8e230ba9b5a6 = level.getspawnpoint;
    level.getspawnpoint = &get_player_spawn_point;
    level.forceteamassignmentoverride = &function_106b4ec52c161221;
    level.var_88b2f2f2ff4a5eb9 = 1;
    level.callbackplayerdamage = &function_d8dd6f115f9cc3e5;
    level.var_916aae8097d37e9e = &laststand_alive_check;
    level.var_4f74daf63a19988 = &respawn_on_round_end;
    level thread function_d04ad8053ddf342f();
    level.var_597f31ee570896c0 = undefined;
    level.var_a4cfd83be97ed632 = 0.1;
    level.var_322288976df3a25f = 1;
    level.var_545d992d40a9d7de = &function_47e7fd3186c92684;
    level.var_6781718da4f78d1c.spawndelay = 0.5;
    level.var_26b0e4fd32e52842 = 1;
    level.var_65957518390e3d2a = &function_1850a9749b8a371a;
    zm_round_spawning::function_47a0f02e6a5d5987( 60 );
    level.zm_battle_alive_players = [];
    level.var_65170497e30cb890 = 0;
    level callback::add( #"player_disconnect", &function_64b197e703d64c71 );
    level callback::add( #"player_death", &function_cb993eb68903e55f );
    level callback::add( #"player_connect", &onplayerconnect );
    level callback::add( #"player_spawned", &function_a98d4a7e879aad4e );
    level callback::add( "on_turned", &function_2155df2d270bd080 );
    level callback::add( "on_brainrot_end", &function_d621f384d1ce9621 );
    utility::registersharedfunc( #"gametype", #"hash_d0478e891f1b7f12", &function_a6997b7f59c5d720 );
    utility::registersharedfunc( #"zm", #"hash_275603844e04e7ac", &function_e47a14a8bc1980d );
    utility::registersharedfunc( #"zm", #"hash_8e5cbc74839b479b", &function_15d5b1b6ff9f4d32 );
    utility::registersharedfunc( #"zm", #"hash_95f8b65e45fc2ef4", &function_27d0e721b387e31b );
    utility::registersharedfunc( #"zm", #"hash_57e52c648ecc4c3c", &function_303b32452b560183 );
    utility::registersharedfunc( #"zombie", #"hash_8bb723b1f8109716", &function_28d5778f1a74e5e0 );
    level.livingworld_disabled = 1;
    level.disable_fasttravel = 1;
    level.var_96d4f8dc0c3cfea3 = 1;
    level.disable_zm_exfil = 1;
    level.var_a2ec909b9c4522c9 = 1;
    utility::registersharedfunc( #"zm", #"hash_23531ae6b4a96397", &function_b7e19ab19a8f879c );
    level callback::add( "on_round_end", &zm_rb_battle_round_end );
    level.var_5542fc8f8eafa0c0 = 1;
    level callback::add( "on_zombie_ai_spawned", &function_f065b4d5bb4b6c6d );
    level zombie_utils::function_dfae6a5bd222c586( &function_a718539dd97c6a1f );
    callback::get_template( "dawg" ) callback::add( "on_ai_init", &function_b0c254f0de61901d );
    level thread function_c92fa0d874f6fc2a();
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x1cc430db, Offset: 0xae1
// Size: 0x38
function private pre_main()
{
    if ( !is_mode_zm_rb_battle() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    utility::registersharedfunc( #"zm_player_joined", #"get_custom_grace_period", &function_aba24040138248c6 );
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x91ea47cd, Offset: 0xb21
// Size: 0x56
function private post_main()
{
    if ( !is_mode_zm_rb_battle() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x3b>" );
        setdevdvar( @"bot_notarget", 2 );
    #/
    
    level callback::add( #"register_team_data", &function_fed950ba91b95eca );
    level.modelaststandallowed = &laststand_allowed;
    level thread function_67ff27704bbf6bc0();
}

// Namespace zm_rb_battle
// Params 0
// Checksum 0xab5410a2, Offset: 0xb7f
// Size: 0x51
function function_67ff27704bbf6bc0()
{
    level endon( #"game_ended" );
    utility::registersharedfunc( #"shockstick", #"hash_282a95fe348c0434", &function_f88257b6c159b403 );
    level thread zm_battle_intro_sequence();
    utility::flag_wait_all( "scriptables_ready", "zone_setup_finished" );
    utility::flag_set( "power_on" );
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x4001864a, Offset: 0xbd8
// Size: 0xb
function private function_7d4ea2ca1855aeeb()
{
    return level.connectingplayers;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x4aaf2a63, Offset: 0xbec
// Size: 0x10e
function private function_d04ad8053ddf342f()
{
    level endon( #"game_ended" );
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        level.connectingplayers = 1;
        println( "<dev string:x53>" + level.connectingplayers );
        return;
    }
    
    level.connectingplayers = 4;
    
    while ( !level.players.size )
    {
        waitframe();
    }
    
    humancount = 0;
    partymembers = getpartyinfo();
    
    foreach ( memberinfo in partymembers )
    {
        if ( !memberinfo.isai )
        {
            humancount++;
        }
    }
    
    level.connectingplayers = humancount;
    println( "<dev string:x85>" + level.connectingplayers );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xd6c59f74, Offset: 0xd02
// Size: 0x24
function private function_4a858a1890a40761( params )
{
    if ( level.prematchperiod )
    {
        utility::flag_set( "delay_begin_round_logic" );
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x439640de, Offset: 0xd2e
// Size: 0x18
function private on_prematch_done( params )
{
    utility::flag_clear( "delay_begin_round_logic" );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x67e0b80d, Offset: 0xd4e
// Size: 0x1f
function private onplayerconnect( params )
{
    utility::ent_flag_init( "zmbattle_color_init" );
    thread function_92dd64e788a3774e();
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xaa40f516, Offset: 0xd75
// Size: 0x66
function private function_92dd64e788a3774e( time )
{
    self endon( #"disconnect" );
    timeout = gettime() + utility::function_4b74c15943231980( 60 );
    self.var_a7773b1c7453eb22 = 1;
    
    while ( true )
    {
        if ( function_791dcf0ce4bf51e7() || gettime() >= timeout )
        {
            self.var_a7773b1c7453eb22 = undefined;
            return;
        }
        
        wait 1;
    }
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x13eddeea, Offset: 0xde3
// Size: 0x17, Type: bool
function private function_791dcf0ce4bf51e7()
{
    if ( isbot( self ) )
    {
        return true;
    }
    
    return istrue( self.versusdone );
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x7b4531bc, Offset: 0xe03
// Size: 0xd2, Type: bool
function private function_1850a9749b8a371a()
{
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( !player.pers[ "streamSyncComplete" ] || player.model == "" )
        {
            continue;
        }
        
        if ( player.var_a7773b1c7453eb22 )
        {
            continue;
        }
        
        count++;
    }
    
    var_627995efe61b41ed = function_7d4ea2ca1855aeeb();
    return count >= var_627995efe61b41ed;
}

// Namespace zm_rb_battle
// Params 0
// Checksum 0xe7c0b28c, Offset: 0xede
// Size: 0x94
function zm_battle_intro_sequence()
{
    level utility::flag_wait( "begin_round_logic" );
    wait 2;
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( #"zm_rb_battle" );
    }
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x7b9f062d, Offset: 0xf7a
// Size: 0xd
function private get_player_spawn_point()
{
    return [[ level.var_7ba8e230ba9b5a6 ]]();
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xe16e6052, Offset: 0xf90
// Size: 0x4
function private function_aba24040138248c6()
{
    return 30;
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x8f17e25c, Offset: 0xf9d
// Size: 0x22
function private function_106b4ec52c161221( params )
{
    self.zm_battle_team = self getentitynumber();
    return zm::function_824ea4febe3f5318( params );
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xb6db6a40, Offset: 0xfc8
// Size: 0x19f
function private function_c92fa0d874f6fc2a()
{
    level endon( #"game_ended" );
    waitframe();
    addfaction( "zombies0" );
    addfaction( "zombies1" );
    addfaction( "zombies2" );
    addfaction( "zombies3" );
    addfaction( "friendly_agents0" );
    addfaction( "friendly_agents1" );
    addfaction( "friendly_agents2" );
    addfaction( "friendly_agents3" );
    function_12caff5f610d2f9( "friendly_agents0", "zombies0", "HOSTILE" );
    function_12caff5f610d2f9( "friendly_agents0", "zombies1", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents0", "zombies2", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents0", "zombies3", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents1", "zombies1", "HOSTILE" );
    function_12caff5f610d2f9( "friendly_agents1", "zombies0", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents1", "zombies2", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents1", "zombies3", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents2", "zombies2", "HOSTILE" );
    function_12caff5f610d2f9( "friendly_agents2", "zombies0", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents2", "zombies1", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents2", "zombies3", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents3", "zombies3", "HOSTILE" );
    function_12caff5f610d2f9( "friendly_agents3", "zombies0", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents3", "zombies1", "NEUTRAL" );
    function_12caff5f610d2f9( "friendly_agents3", "zombies2", "NEUTRAL" );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x4d33afde, Offset: 0x116f
// Size: 0x55
function private function_9e675e863e6e3d62( faction )
{
    current_faction = self getfaction();
    
    if ( current_faction == faction )
    {
        return;
    }
    
    if ( current_faction && current_faction != "" )
    {
        self leavefaction();
    }
    
    if ( faction && faction != "" )
    {
        self joinfaction( faction );
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x5898312e, Offset: 0x11cc
// Size: 0x1e
function private function_fed950ba91b95eca( _ )
{
    level.teamnamelist = level.activeteams;
}

// Namespace zm_rb_battle
// Params 18, eflags: 0x4
// Checksum 0xc48da349, Offset: 0x11f2
// Size: 0x2a2
function private function_d8dd6f115f9cc3e5( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2, poisedamage, willknockdown, additionalparams )
{
    dmg_struct = { #additionalparams:additionalparams, #willknockdown:willknockdown, #poisedamage:poisedamage, #var_cdd29ad5d1362c2:var_cdd29ad5d1362c2, #var_2300d396e46c0fe7:var_2300d396e46c0fe7, #partname:partname, #modelindex:modelindex, #timeoffset:timeoffset, #shitloc:shitloc, #vdir:vdir, #vpoint:vpoint, #objweapon:objweapon, #fdistance:fdistance, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #eattacker:eattacker, #einflictor:einflictor };
    
    if ( isplayer( eattacker ) || isplayer( eattacker.owner ) )
    {
        if ( isplayer( eattacker.owner ) )
        {
            player_attacker = eattacker.owner;
        }
        else
        {
            player_attacker = eattacker;
        }
        
        if ( player_attacker.team != self.team )
        {
            dmg_struct.idamage = 0;
        }
    }
    
    dmg_struct = zm_player_damage::function_8509d988e53f1c55( dmg_struct );
    [[ level.var_309f8f867be84cac ]]( dmg_struct.einflictor, dmg_struct.eattacker, dmg_struct.idamage, dmg_struct.idflags, dmg_struct.smeansofdeath, dmg_struct.fdistance, dmg_struct.objweapon, dmg_struct.vpoint, dmg_struct.vdir, dmg_struct.shitloc, dmg_struct.timeoffset, dmg_struct.modelindex, dmg_struct.partname, dmg_struct.var_2300d396e46c0fe7, dmg_struct.var_cdd29ad5d1362c2 );
}

// Namespace zm_rb_battle
// Params 9, eflags: 0x4
// Checksum 0x6db09715, Offset: 0x149c
// Size: 0x7b, Type: bool
function private laststand_allowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    is_teammate_alive = zm_laststand::function_d96558297a3c2b2b( undefined, [ self ] );
    return laststand::function_7072b516e6cffb7c() > 0 || is_teammate_alive;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xf386be37, Offset: 0x1520
// Size: 0x336
function private laststand_alive_check()
{
    if ( level.b_zm_game_over )
    {
        return;
    }
    
    var_2c8dd3a974851bf2 = [];
    
    foreach ( team in level.activeteams ?? [] )
    {
        var_2c8dd3a974851bf2[ var_2c8dd3a974851bf2.size ] = { #var_741060df695c7f61:0, #team:team };
    }
    
    waitframe();
    alive_players = zm_laststand::get_alive_players();
    
    if ( alive_players.size <= 1 )
    {
        if ( getdvarint( @"hash_53657f2e905ea522", 0 ) )
        {
            return;
        }
        
        level.b_zm_game_over = 1;
        level utility::flag_set( "zm_game_over" );
        waitframe();
        winner = alive_players[ 0 ];
        
        if ( isdefined( winner ) )
        {
            winner thread function_33c747f2d3395db8();
        }
        
        foreach ( player in level.players )
        {
            player val::set( "zm_rb_battle_end_game", "ignoreme", 1 );
            player val::set( "zm_rb_battle_end_game", "damage", 0 );
            player val::set( "zm_rb_battle_end_game", "usability", 0 );
            player val::set( "zm_rb_battle_end_game", "allow_revive_teammate", 0 );
            player killstreaks::clearkillstreaks();
        }
        
        level notify( #"end_round_logic" );
        
        /#
            player_number = winner ? "<dev string:xb3>" + winner getentitynumber() : "<dev string:xba>";
            iprintlnbold( "<dev string:xbf>" + player_number );
            logstring( "<dev string:xbf>" + player_number );
        #/
        
        var_21a2b6ca7b9a3e0f = 1;
        gamelogic_zm::slowmotionendofgame( var_21a2b6ca7b9a3e0f );
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                player thread function_cacb899fd5e76ff3();
                continue;
            }
            
            player thread zm_exfil_sat::function_8f261015e4f861ae( player == winner );
        }
        
        wait 4.5;
        level.var_1a7d5de49b6970b1 = 1;
        level.postgamehitmarkerwaittime = 0;
        utility::array_thread( level.players, &val::reset_all, "zm_rb_battle_end_game" );
        end_reason = game[ "end_reason" ][ "objective_completed" ];
        level gamelogic_zm::endgame( winner, end_reason, game[ "end_reason" ][ "mp_faction_eliminated" ] );
    }
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xcdcdd6e9, Offset: 0x185e
// Size: 0x79
function private function_cacb899fd5e76ff3()
{
    self endon( #"disconnect" );
    self.var_14955bc056bab547 = 1;
    thread playerlogic::spawnclient();
    self waittill( #"spawned_player" );
    val::set( "zm_rb_battle_end_game", "freezecontrols", 1 );
    val::set( "zm_rb_battle_end_game", "show_hud", 0 );
    val::set( "zm_rb_battle_end_game", "show_crosshair", 0 );
    thread hud_util::fade_out( 0, "black" );
    thread zm_exfil_sat::function_8f261015e4f861ae( 0 );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x81df7137, Offset: 0x18df
// Size: 0xc
function private respawn_on_round_end( _ )
{
    
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xe5e12db8, Offset: 0x18f3
// Size: 0x5d
function private function_33c747f2d3395db8()
{
    round_num = zm_utility::get_round_number();
    
    if ( round_num >= 15 )
    {
        gg_count = 2;
    }
    else if ( round_num >= 10 && utility::cointoss() )
    {
        gg_count = 2;
    }
    else if ( round_num >= 5 )
    {
        gg_count = 1;
    }
    else
    {
        return;
    }
    
    bgb::function_701b66d2240de5a4( gg_count );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xeb84659f, Offset: 0x1958
// Size: 0x7a
function private function_a718539dd97c6a1f( dmg_struct )
{
    player_attacker = isplayer( dmg_struct.eattacker ) ? dmg_struct.eattacker : dmg_struct.eattacker.owner;
    
    if ( isplayer( player_attacker ) && !function_15d5b1b6ff9f4d32( player_attacker, self ) )
    {
        val::set( "insta_kill", "kill_on_damage", 0 );
        return 0;
    }
    
    return -1;
}

// Namespace zm_rb_battle
// Params 0
// Checksum 0x6b1e8dd9, Offset: 0x19db
// Size: 0xe, Type: bool
function is_mode_zm_rb_battle()
{
    return game_utility::getgametype() == "zm_rb_battle";
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x79bc3024, Offset: 0x19f2
// Size: 0x14
function private function_64b197e703d64c71( params )
{
    function_b622592f0cdd80b9( self );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x45033e51, Offset: 0x1a0e
// Size: 0xa4
function private function_cb993eb68903e55f( params )
{
    function_b622592f0cdd80b9( self );
    
    foreach ( player in level.zm_battle_alive_players )
    {
        player.zmbattle_score++;
        player stats::function_fe615555f60e88b9( player.zmbattle_score );
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x3da1b2b8, Offset: 0x1aba
// Size: 0x7c
function private function_a98d4a7e879aad4e( params )
{
    /#
        if ( isbot( self ) )
        {
            zm::function_bb6410e521a32fce( params );
        }
    #/
    
    self.var_1421ac16245da12a = [];
    
    if ( level.zm_battle_alive_players.size > 0 )
    {
        val::set( "zombie_battle", "round_spawning_ignore_player", 1 );
    }
    
    level.zm_battle_alive_players[ level.zm_battle_alive_players.size ] = self;
    self.zmbattle_score = 0;
    stats::function_fe615555f60e88b9( self.zmbattle_score );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xa6b7e332, Offset: 0x1b3e
// Size: 0xfa
function private function_b622592f0cdd80b9( player )
{
    function_dfe7d8de018dafa9( player );
    var_440829c970056409 = -1;
    
    for ( index = 0; index < level.zm_battle_alive_players.size ; index++ )
    {
        if ( level.zm_battle_alive_players[ index ] == player )
        {
            var_440829c970056409 = index;
            break;
        }
    }
    
    if ( var_440829c970056409 < 0 )
    {
        return;
    }
    
    if ( var_440829c970056409 < level.var_65170497e30cb890 )
    {
        level.var_65170497e30cb890--;
    }
    else if ( level.var_65170497e30cb890 >= level.zm_battle_alive_players.size - 1 )
    {
        level.var_65170497e30cb890 = 0;
        cleanup_override_aitype();
    }
    
    level.zm_battle_alive_players = arrayremove( level.zm_battle_alive_players, player );
    assign_player = level.zm_battle_alive_players[ level.var_65170497e30cb890 ];
    
    if ( isdefined( assign_player ) )
    {
        assign_player val::reset( "zombie_battle", "round_spawning_ignore_player" );
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x6d878e97, Offset: 0x1c40
// Size: 0xf3
function private function_dfe7d8de018dafa9( player )
{
    if ( !player.var_1421ac16245da12a )
    {
        return;
    }
    
    foreach ( beam_data in player.var_1421ac16245da12a )
    {
        if ( beam_data.beam )
        {
            beam_data.beam delete();
        }
        
        if ( beam_data.zombie )
        {
            beam_data.zombie.var_91ff6dfd15819d5b = 0;
            beam_data.zombie.dot_beam_fx = undefined;
        }
    }
    
    player.var_1421ac16245da12a = [];
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xe52a0317, Offset: 0x1d3b
// Size: 0x4
function private function_47e7fd3186c92684()
{
    return 10;
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x26cd7a5, Offset: 0x1d48
// Size: 0x18c
function private zm_rb_battle_round_end( params )
{
    level endon( #"game_ended" );
    wait 3;
    var_da000f0f5791f912 = getaiarray();
    next_round = params.roundnumber + 1;
    
    foreach ( zombie in var_da000f0f5791f912 )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( !is_round_spawn_zombie( zombie ) )
        {
            continue;
        }
        
        new_health = int( namespace_9d8e359c3b1041e5::function_870440d8340968c0( zombie.subclass, next_round ) );
        
        if ( new_health > zombie.maxhealth )
        {
            current_health_percent = zombie.health / zombie.maxhealth;
            zombie ai::set_ai_max_health( new_health );
            zombie.health = int( zombie.maxhealth * current_health_percent );
        }
        
        zombie._blackboard.var_e9288b4c21f355a9 = next_round;
        
        if ( isdefined( level.var_148e14aa588539af ) )
        {
            [[ level.var_148e14aa588539af ]]( zombie, next_round );
        }
        
        playfxontag( utility::getfx( "zm_battle_round_turn_zombie_fx" ), zombie, "tag_origin" );
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x8fad6c42, Offset: 0x1edc
// Size: 0x30, Type: bool
function private function_f88257b6c159b403( shockstick )
{
    if ( isai( self ) )
    {
        if ( shockstick.owner != self.enemy )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xed841217, Offset: 0x1f15
// Size: 0x22
function private function_b0c254f0de61901d( params )
{
    setignoremegroup( "team_players", "dawg" );
    thread function_c49f4d44b2d78cdc();
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x6a05ea04, Offset: 0x1f3f
// Size: 0x173
function private function_f065b4d5bb4b6c6d( params )
{
    if ( !is_round_spawn_zombie( self ) )
    {
        return;
    }
    
    if ( !level.var_940944048759b0ed && self.var_8f7b67390c7a40b2 && !issubstr( self.var_8f7b67390c7a40b2, "zombie_base" ) )
    {
        level.var_940944048759b0ed = self.var_8f7b67390c7a40b2;
    }
    
    if ( level.var_65170497e30cb890 >= level.zm_battle_alive_players.size )
    {
        level.var_65170497e30cb890 = 0;
    }
    
    assign_player = level.zm_battle_alive_players[ level.var_65170497e30cb890 ];
    assign_player val::set( "zombie_battle", "round_spawning_ignore_player", 1 );
    zombie_utils::set_ai_target_priority( assign_player, "zm_rb_battle", -1 );
    self.favoriteenemy = assign_player;
    level.var_65170497e30cb890++;
    
    if ( level.var_65170497e30cb890 < level.zm_battle_alive_players.size )
    {
        function_384409e9f3ad9ad8( function_b3988325430ce242( self.subclass ) );
    }
    else
    {
        level.var_65170497e30cb890 = 0;
        
        if ( level.var_940944048759b0ed )
        {
            function_384409e9f3ad9ad8( level.var_940944048759b0ed );
            level.var_940944048759b0ed = undefined;
        }
        else
        {
            cleanup_override_aitype();
        }
    }
    
    assign_player = level.zm_battle_alive_players[ level.var_65170497e30cb890 ];
    assign_player val::reset( "zombie_battle", "round_spawning_ignore_player" );
    thread function_b1e2af32920822d();
    thread monitor_zombie_upgrade();
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x2423c17f, Offset: 0x20ba
// Size: 0x6e, Type: bool
function private is_round_spawn_zombie( zombie )
{
    if ( !isdefined( zombie.spawn_source ) )
    {
        return false;
    }
    
    return zombie.spawn_source == "zm_round_spawning" || zombie.spawn_source == "special_zombie_spawn" || zombie.spawn_source == "zm_cleanup" || zombie.spawn_source == "mixed_zombie_spawn";
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xc02b535c, Offset: 0x2131
// Size: 0x104
function private monitor_zombie_upgrade()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 30;
        
        if ( self.var_91ff6dfd15819d5b )
        {
            continue;
        }
        
        next_speed = "run";
        
        if ( self._blackboard.movetype == "super_sprint" )
        {
            target_player = self.favoriteenemy;
            
            if ( target_player && function_2d68335716d8f01f( target_player ) && function_a64d3c3e96a809ed( target_player ) )
            {
                thread function_1aa4dda781285561( target_player );
            }
            
            continue;
        }
        else if ( self._blackboard.movetype == "sprint" )
        {
            next_speed = "super_sprint";
        }
        
        if ( self._blackboard.movetype == "run" )
        {
            next_speed = "sprint";
        }
        
        zombie_utils::function_a8ce00e0448cb6f0( next_speed, "battle_speedup", 18 );
        
        if ( next_speed != self._blackboard.movetype )
        {
            return;
        }
    }
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x2e68b966, Offset: 0x223d
// Size: 0x13
function private function_3014f94d8df1a4a0()
{
    return int( 24 / level.zm_battle_alive_players.size );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x7da060af, Offset: 0x2259
// Size: 0x49, Type: bool
function private function_2d68335716d8f01f( player )
{
    if ( !zm_player::function_f37cfdf04b932a03( player, 1, 0 ) )
    {
        return false;
    }
    
    if ( self.target_attractor || zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( player utility::ent_flag( "aether_shroud_in_use" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xb4b08a85, Offset: 0x22ab
// Size: 0x31, Type: bool
function private function_a64d3c3e96a809ed( player )
{
    if ( !player.var_1421ac16245da12a )
    {
        return true;
    }
    
    return player.var_1421ac16245da12a.size < function_3014f94d8df1a4a0();
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x4c78b49b, Offset: 0x22e5
// Size: 0x229
function private function_1aa4dda781285561( target_player )
{
    self endon( #"death" );
    
    if ( !isdefined( self.zmbattle_color ) || !isdefined( target_player.zmbattle_color ) )
    {
        if ( !isdefined( target_player.zmbattle_color ) )
        {
            target_player function_da964da2e4ae81e0();
            
            if ( !self || !target_player )
            {
                return;
            }
            
            if ( !function_2d68335716d8f01f( target_player ) || !function_a64d3c3e96a809ed( target_player ) )
            {
                return;
            }
        }
        
        if ( !isdefined( self.zmbattle_color ) || !isdefined( target_player.zmbattle_color ) )
        {
            /#
                msg = "<dev string:xd8>";
                
                if ( !isdefined( self.zmbattle_color ) )
                {
                    msg += "<dev string:x106>" + self getentitynumber() + "<dev string:x10e>";
                }
                
                if ( !isdefined( target_player.zmbattle_color ) )
                {
                    msg += "<dev string:x135>" + target_player getentitynumber() + "<dev string:x13d>";
                }
                
                assertmsg( msg );
            #/
            
            return;
        }
    }
    
    self.var_91ff6dfd15819d5b = 1;
    self.dot_target_player = target_player;
    self.dot_beam_fx = playfxontagsbetweenclients( utility::getfx( "zm_battle_zombie_dot_beam_fx" + self.zmbattle_color ), self, "j_spine4", target_player, "j_spine4" );
    self.var_b3957a8305a0d21a = { #zombie:self, #beam:self.dot_beam_fx };
    target_player.var_1421ac16245da12a[ target_player.var_1421ac16245da12a.size ] = self.var_b3957a8305a0d21a;
    callback::add( #"on_ai_killed", &function_20980fc0323c91d3 );
    
    if ( target_player getscriptablepartstate( "ltm_mode_fx", 1 ) != "battle_tether_on" + target_player.zmbattle_color )
    {
        target_player setscriptablepartstate( "ltm_mode_fx", "battle_tether_on" + target_player.zmbattle_color, 0 );
    }
    
    while ( true )
    {
        target_player = self.favoriteenemy;
        
        if ( !target_player || !function_2d68335716d8f01f( target_player ) )
        {
            function_6851185ebe76c4f4();
            return;
        }
        
        target_player dodamage( 1, target_player.origin, self, self );
        wait 1;
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x811537af, Offset: 0x2516
// Size: 0x2f
function private function_da964da2e4ae81e0( timeout = 1 )
{
    self endon( #"death_or_disconnect" );
    utility::ent_flag_wait_or_timeout( "zmbattle_color_init", timeout );
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xe539010e, Offset: 0x254d
// Size: 0x13
function private function_20980fc0323c91d3( params )
{
    function_6851185ebe76c4f4();
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xd5906d30, Offset: 0x2568
// Size: 0xb7
function private function_6851185ebe76c4f4()
{
    callback::remove( #"on_ai_killed", &function_20980fc0323c91d3 );
    
    if ( self.dot_beam_fx )
    {
        target_player = self.dot_target_player;
        
        if ( target_player.var_1421ac16245da12a && self.var_b3957a8305a0d21a )
        {
            target_player.var_1421ac16245da12a = arrayremove( target_player.var_1421ac16245da12a, self.var_b3957a8305a0d21a );
        }
        
        self.dot_beam_fx delete();
        
        if ( target_player && !target_player.var_1421ac16245da12a.size )
        {
            target_player setscriptablepartstate( "ltm_mode_fx", "all_vfx_off", 0 );
        }
    }
    
    self.var_91ff6dfd15819d5b = 0;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xcf830a0e, Offset: 0x2627
// Size: 0x15b
function private function_b1e2af32920822d()
{
    self endon( #"death" );
    
    /#
        if ( getdvarint( @"hash_c7c69df615ba2ab4", 0 ) )
        {
            thread function_3e0e95f6310901be();
        }
    #/
    
    thread turn_off_eye_glow();
    
    while ( true )
    {
        self waittill( #"enemy" );
        thread function_8babe99d5ad21bd4();
        
        if ( !isalive( self.favoriteenemy ) && !zombie_utils::function_bf1464d09f4e4b40() )
        {
            assign_player = undefined;
            var_9751294ac742693b = 999999;
            
            foreach ( player in level.zm_battle_alive_players )
            {
                if ( !isdefined( player.var_22ccf3c1bf47d57a ) )
                {
                    player.var_22ccf3c1bf47d57a = 0;
                }
                
                if ( player.var_22ccf3c1bf47d57a < var_9751294ac742693b )
                {
                    assign_player = player;
                    var_9751294ac742693b = player.var_22ccf3c1bf47d57a;
                }
            }
            
            if ( assign_player )
            {
                assign_player.var_22ccf3c1bf47d57a++;
                zombie_utils::set_ai_target_priority( assign_player, "zm_rb_battle", -1 );
                self.favoriteenemy = assign_player;
            }
        }
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0xa1bfef5d, Offset: 0x278a
// Size: 0x2d
function private function_384409e9f3ad9ad8( aitype )
{
    level.var_fea17bce20653bd0 = 1;
    level.round_spawn_override_aitype = aitype;
    level.var_7ca494dfc830114f = 1;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x18463dc7, Offset: 0x27bf
// Size: 0x20
function private cleanup_override_aitype()
{
    level.var_fea17bce20653bd0 = 0;
    level.round_spawn_override_aitype = undefined;
    level.var_7ca494dfc830114f = 0;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x2d6f22df, Offset: 0x27e7
// Size: 0xa2
function private turn_off_eye_glow()
{
    self endon( #"death" );
    utility::ent_flag_init( "base_eye_glow_off" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    wait 0.1;
    
    if ( self isscriptable() )
    {
        if ( self.subclass && issubstr( self.subclass, "zombie_mimic" ) )
        {
            utility::function_32b24db3127bff40( #"mouth", "mouth_off" );
        }
        else
        {
            utility::function_32b24db3127bff40( #"base", "base_off" );
        }
    }
    
    val::set( "zm_rb_battle", "allow_change_zombie_eye_glow", 0 );
    utility::ent_flag_set( "base_eye_glow_off" );
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x3cbb368b, Offset: 0x2891
// Size: 0x253
function private function_8babe99d5ad21bd4()
{
    self endon( #"death" );
    utility::ent_flag_wait( "base_eye_glow_off" );
    player = self.enemy ?? self.favoriteenemy;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( player.sessionuimemberindex ) && self isscriptable() )
    {
        index = player.sessionuimemberindex;
        
        /#
            if ( getdvarint( @"hash_6840db0c9cf52e10", -1 ) >= 0 )
            {
                index = getdvarint( @"hash_6840db0c9cf52e10" );
            }
        #/
        
        if ( self.subclass && issubstr( self.subclass, "zombie_mimic" ) )
        {
            part = #"mouth";
            state_suffix = "mouth";
        }
        else
        {
            part = #"base";
            state_suffix = "eyes";
        }
        
        switch ( index )
        {
            default:
                vfx = "rb_battle_green_" + state_suffix;
                self.zmbattle_color = "_green";
                player.zmbattle_color = "_green";
                break;
            case 1:
                vfx = "rb_battle_orange_" + state_suffix;
                self.zmbattle_color = "_orange";
                player.zmbattle_color = "_orange";
                break;
            case 2:
                vfx = "rb_battle_blue_" + state_suffix;
                self.zmbattle_color = "_blue";
                player.zmbattle_color = "_blue";
                break;
            case 3:
                vfx = "rb_battle_pink_" + state_suffix;
                self.zmbattle_color = "_pink";
                player.zmbattle_color = "_pink";
                break;
        }
        
        utility::function_32b24db3127bff40( part, vfx );
        player utility::ent_flag_set( "zmbattle_color_init" );
        println( "<dev string:x106>" + self getentitynumber() + "<dev string:x163>" + self.zmbattle_color + "<dev string:x176>" + player getentitynumber() );
    }
    
    if ( isdefined( player.zm_battle_team ) )
    {
        function_9e675e863e6e3d62( "zombies" + player.zm_battle_team );
    }
}

// Namespace zm_rb_battle
// Params 1
// Checksum 0xb953f4ee, Offset: 0x2aec
// Size: 0xcf
function function_a6997b7f59c5d720( revive_entity )
{
    if ( !isplayer( revive_entity.owner ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( function_27d0e721b387e31b( player, revive_entity.owner ) && player != revive_entity.owner )
        {
            laststand::function_868823d2f6a204d2( revive_entity, player );
            continue;
        }
        
        laststand::function_9199954e53abe5f( revive_entity, player );
    }
}

// Namespace zm_rb_battle
// Params 2
// Checksum 0xe06f6e4, Offset: 0x2bc3
// Size: 0xe8, Type: bool
function function_15d5b1b6ff9f4d32( player, agent )
{
    /#
        assert( isplayer( player ) );
        assert( isai( agent ) );
    #/
    
    if ( player utility::ent_flag( "aether_shroud_in_use" ) )
    {
        return false;
    }
    
    if ( !isdefined( agent.favoriteenemy.zm_battle_team ) )
    {
        return true;
    }
    
    if ( player.zm_battle_team == agent.favoriteenemy.zm_battle_team )
    {
        return true;
    }
    
    favoriteenemy_valid = agent.favoriteenemy && zm_player::function_f37cfdf04b932a03( agent.favoriteenemy, 1, 0 );
    
    if ( favoriteenemy_valid )
    {
        return false;
    }
    
    if ( player.zm_battle_team == agent.enemy.zm_battle_team )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_rb_battle
// Params 2
// Checksum 0x63d18829, Offset: 0x2cb4
// Size: 0x4b, Type: bool
function function_27d0e721b387e31b( player, other_player )
{
    /#
        assert( isplayer( player ) );
        assert( isplayer( other_player ) );
    #/
    
    return player.zm_battle_team == other_player.zm_battle_team;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0x179a3b94, Offset: 0x2d08
// Size: 0x52
function private function_c49f4d44b2d78cdc()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    
    if ( isdefined( self.owner.zm_battle_team ) )
    {
        function_9e675e863e6e3d62( "friendly_agents" + self.owner.zm_battle_team );
    }
}

// Namespace zm_rb_battle
// Params 2
// Checksum 0x3ad1f675, Offset: 0x2d62
// Size: 0xc7
function function_e47a14a8bc1980d( agentarray, target_player )
{
    if ( !isdefined( agentarray ) || !target_player )
    {
        return [];
    }
    
    var_11699547211f9f4f = [];
    
    foreach ( agent in agentarray )
    {
        if ( !isalive( agent ) || !isai( agent ) )
        {
            continue;
        }
        
        if ( level function_15d5b1b6ff9f4d32( target_player, agent ) )
        {
            var_11699547211f9f4f[ var_11699547211f9f4f.size ] = agent;
        }
    }
    
    return var_11699547211f9f4f;
}

// Namespace zm_rb_battle
// Params 2
// Checksum 0x161c2a53, Offset: 0x2e32
// Size: 0x80, Type: bool
function function_303b32452b560183( attractor, target )
{
    if ( !attractor || !isai( target ) )
    {
        return false;
    }
    
    attractor_owner = isplayer( attractor.source ) ? attractor.source : attractor.source.owner;
    
    if ( !isplayer( attractor_owner ) )
    {
        return true;
    }
    
    return level function_15d5b1b6ff9f4d32( attractor_owner, target );
}

// Namespace zm_rb_battle
// Params 1
// Checksum 0x9f10caad, Offset: 0x2ebb
// Size: 0x36
function function_2155df2d270bd080( params )
{
    if ( function_cff0e6df5a208825( "friendly_agents" ) )
    {
        self.favoriteenemy_backup = self.favoriteenemy;
        self.favoriteenemy = undefined;
    }
}

// Namespace zm_rb_battle
// Params 1
// Checksum 0x2d5b1d46, Offset: 0x2ef9
// Size: 0x43
function function_d621f384d1ce9621( params )
{
    if ( function_cff0e6df5a208825( "zombies" ) && self.favoriteenemy_backup )
    {
        self.favoriteenemy = self.favoriteenemy_backup;
        self.favoriteenemy_backup = undefined;
    }
}

// Namespace zm_rb_battle
// Params 1
// Checksum 0xfde937a8, Offset: 0x2f44
// Size: 0x6f, Type: bool
function function_cff0e6df5a208825( var_914e56e3672a1f18 )
{
    function_9e675e863e6e3d62();
    who_turned = self.var_bd22ba6c600a23a3 ?? self.var_fb2e0070ae6f04e4;
    
    if ( isplayer( who_turned ) && isalive( who_turned ) )
    {
        if ( isdefined( who_turned.zm_battle_team ) )
        {
            function_9e675e863e6e3d62( var_914e56e3672a1f18 + who_turned.zm_battle_team );
            return true;
        }
    }
    
    return false;
}

// Namespace zm_rb_battle
// Params 0, eflags: 0x4
// Checksum 0xab75ad02, Offset: 0x2fbc
// Size: 0x32
function private function_b7e19ab19a8f879c()
{
    allow = !level.nojip ?? 1;
    setpresencejoin( allow );
    
    if ( !allow )
    {
        level thread laststand_alive_check();
    }
}

// Namespace zm_rb_battle
// Params 1, eflags: 0x4
// Checksum 0x5506b208, Offset: 0x2ff6
// Size: 0x1f, Type: bool
function private function_28d5778f1a74e5e0( augment_name )
{
    if ( augment_name == #"quick_revive_last_chance" )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace zm_rb_battle
    // Params 0, eflags: 0xc
    // Checksum 0x92a7c53b, Offset: 0x301e
    // Size: 0xaa, Type: dev
    function private function_3e0e95f6310901be()
    {
        self notify( #"hash_6ccda143fb975187" );
        self endon( #"hash_6ccda143fb975187" );
        self endon( #"death" );
        
        while ( true )
        {
            var_83e3debba79e4480 = -1;
            
            if ( isdefined( self.enemy ) )
            {
                var_83e3debba79e4480 = self.enemy getentitynumber();
            }
            
            print3d( self.origin + ( 0, 0, 64 ), "<dev string:x18e>" + var_83e3debba79e4480, var_83e3debba79e4480 >= 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, 1 );
            waitframe();
        }
    }

#/
