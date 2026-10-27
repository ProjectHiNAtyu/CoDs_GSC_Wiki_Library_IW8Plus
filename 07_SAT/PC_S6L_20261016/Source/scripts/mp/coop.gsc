// scripts\mp\coop.gsc  (hash_00ecfe50bdafd9af.gscc) (size: 41310 Bytes / 0xa15e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf42b4c19 (4096478233)
// size ...... 41310 (0xa15e)
// includes .. 24  (offset: 0x9766)
// strings ... 140 (offset: 0x9826)
// dev strs .. 12  (offset: 0xa0ca)
// exports ... 62  (offset: 0x6e5a)
// cseg ...... 0xbf6 + 0x6264 (0x6e5a)
// imports ... 220 (offset: 0x780a)
// animtree1 . 0   (offset: 0xa15e)
// animtree2 . 0   (offset: 0xa15e)
#using script_16ea1b94f0f381b3;
#using script_60cd1c57e94be8d7;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\scripted_widgets;
#using scripts\common\squad_notification;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\playerlogic;

#namespace coop;

// Namespace coop
// Params 0, eflags: 0x5
// Checksum 0xa5cd4d15, Offset: 0xc14
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"coop", undefined, &pre_main, undefined );
}

// Namespace coop
// Params 0, eflags: 0x4
// Checksum 0x8d9d3ab2, Offset: 0xc35
// Size: 0x16d
function private pre_main()
{
    setdvarifuninitialized( @"hash_1aafe4e89bdab328", 120 );
    setdvarifuninitialized( @"hash_d5d17ffd60db08fc", 0 );
    setdvarifuninitialized( @"hash_687467591b3414bd", 5 );
    setdvarifuninitialized( @"hash_b69915ff26107a89", -1 );
    setdvarifuninitialized( @"hash_85d1dfb1364cfef4", 0 );
    setdvarifuninitialized( @"hash_70e0b48e9ed1fb6f", 0 );
    setdvarifuninitialized( @"hash_fad480b7b3734a97", 1 );
    setdvarifuninitialized( @"hash_f9e79bfa26284f02", 1 );
    setdvarifuninitialized( @"hash_61fb74018ddc6bea", 0 );
    setdvar( @"hash_a6b2701d60f1b815", 0 );
    level._effect[ "vfx_pullforward_3p_teleport" ] = loadfxasset( "vfx_sat_wc_chr_pull_forward_burst" );
    level callback::add( #"hash_cc06eb1d45f33a0c", &function_37904b06ac0bfaf1 );
    level callback::add( #"hash_8f04f402f9d538d4", &player_map_to_map_start );
    level callback::add( #"hash_6b9543d4417040a", &function_cc279baa40340449 );
    level callback::add( #"player_laststand_set_revive_progress", &function_98c7be7c1655efc4 );
    level.var_c549dc94926fcc57 = &function_64817edb5faeca93;
    
    /#
        setdvarifuninitialized( @"hash_cb9489aecc9a5cc1", 0 );
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_c4e9a44fe95e0dae", &debug_cinematic );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_34381bd9fea7c6ae", &debug_igc );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"coop_debug_world_fade", &debug_world_fade );
}

/#

    // Namespace coop
    // Params 0
    // Checksum 0xa9943999, Offset: 0xdaa
    // Size: 0x5, Type: dev
    function function_dcad0253131f704b()
    {
        
    }

#/

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x2948c06c, Offset: 0xdb7
// Size: 0x3d
function private debug_cinematic( params )
{
    cinematicname = params[ 0 ] ?? "";
    level thread play_cinematic( cinematicname, { #players:[ self ] } );
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x1c7ead2b, Offset: 0xdfc
// Size: 0x195
function private debug_igc( params )
{
    scenename = params[ 0 ] ?? "";
    players = level.players;
    
    if ( isplayer( self ) )
    {
        squad = teams::function_72b89edf6b47c40a( self );
        players = squad.players;
    }
    
    setdvar( @"hash_810e50766e7264d4", 1 );
    setdvar( @"hash_cffb92d798962e79", 0 );
    setdvar( @"hash_75386e2ad496a07a", 3 );
    setdvar( @"r_ssrmode", 2 );
    setdvar( @"r_texfilter", 5 );
    setdvar( @"hash_5b1b97d800e6521a", 2 );
    setdvar( @"hash_143a1e29e4919916", 0 );
    setdvar( @"hash_9dae7d2931a373dd", 0 );
    setdvar( @"hash_f1d740f1f4306d8f", 0 );
    setdvar( @"hash_3dc4c955c68f0e3", 500 );
    setdvar( @"hash_bd8b77266f341d71", 500 );
    
    foreach ( s_scene in level.a_scene_structs )
    {
        if ( s_scene.script_scenescriptbundle == scenename )
        {
            s_scene thread debug_igc_thread( scenename, players );
            return;
        }
    }
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x65199e66, Offset: 0xf99
// Size: 0x73
function private debug_world_fade( params )
{
    if ( isplayer( self ) )
    {
        if ( !self.debug_world_fade )
        {
            val::set( "debug_world_fade", "world_fade", 1 );
            val::set( "debug_world_fade", "show_hud", 0 );
        }
        else
        {
            val::reset_all( "debug_world_fade" );
        }
        
        self.debug_world_fade = self.debug_world_fade ? undefined : 1;
    }
}

// Namespace coop
// Params 2, eflags: 0xc
// Checksum 0x7f893d55, Offset: 0x1014
// Size: 0x299
function private debug_igc_thread( scenename, players )
{
    self notify( #"hash_62931bad26b7e13b" );
    self endon( #"hash_62931bad26b7e13b" );
    scene::pre_stream( players, undefined, -1 );
    prestreamend = gettime() + 5000;
    msg = "Prestreaming " + scenename + " ";
    
    if ( !isdefined( level.var_5e87f19df8b72ab5 ) )
    {
        hudelem = newhudelem();
        hudelem.alignx = "center";
        hudelem.aligny = "middle";
        hudelem.x = 320;
        hudelem.y = 320;
        hudelem.foreground = 1;
        hudelem.color = ( 1, 0.33, 0.33 );
        hudelem.fontscale = 2;
        level.var_5e87f19df8b72ab5 = hudelem;
    }
    
    foreach ( player in players )
    {
        player val::set( "debug_igc_thread", "hide", 2 );
        player val::set( "debug_igc_thread", "damage", 0 );
        player val::set( "debug_igc_thread", "ignoreme", 1 );
        player val::set( "debug_igc_thread", "weapon", 0 );
    }
    
    while ( gettime() < prestreamend )
    {
        if ( isdefined( level.var_5e87f19df8b72ab5 ) )
        {
            /#
                level.var_5e87f19df8b72ab5 setdevtext( msg + int( ( prestreamend - gettime() ) / 1000 ) );
            #/
        }
        
        wait 1;
    }
    
    if ( isdefined( level.var_5e87f19df8b72ab5 ) )
    {
        level.var_5e87f19df8b72ab5 destroy();
        level.var_5e87f19df8b72ab5 = undefined;
    }
    
    waitframe();
    scene::play( players );
    
    foreach ( player in players )
    {
        player val::reset_all( "debug_igc_thread" );
    }
}

// Namespace coop
// Params 2
// Checksum 0x9c6f6a13, Offset: 0x12b5
// Size: 0x42c
function play_cinematic( var_58bb242dbcd8b7e1, options )
{
    self notify( #"hash_67e2a4a77a95f8a1" );
    self endon( #"hash_67e2a4a77a95f8a1" );
    assert( isstring( var_58bb242dbcd8b7e1 ) );
    squad = options.squad;
    
    while ( !isdefined( squad ) )
    {
        if ( isstruct( self ) && self != level && isarray( self.players ) )
        {
            squad = self;
            break;
        }
        
        if ( isarray( options.players ) && isplayer( options.players[ 0 ] ) )
        {
            squad = teams::function_72b89edf6b47c40a( options.players[ 0 ] );
        }
        else
        {
            assert( level.var_91466c5be0885e53 );
            squad = teams::function_72b89edf6b47c40a( level.players[ 0 ] );
        }
        
        if ( isdefined( squad ) )
        {
            options.squad = squad;
            break;
        }
        
        waitframe();
    }
    
    var_48b1eea32dd9b523 = squad function_9bd80c0b7d85aef7();
    assert( isstruct( squad ) );
    assert( isarray( squad.players ) );
    
    if ( options.var_1fea8eb2ea91b7ac )
    {
        squad utility::ent_flag_set( "squad_play_begin" );
    }
    else
    {
        assert( squad utility::ent_flag( "<dev string:x24>" ), "<dev string:x35>" );
    }
    
    if ( isarray( options.structs ) )
    {
        teleport_struct_prepare( squad, options.structs );
    }
    
    squad player_ready_check( squad, 1 );
    
    if ( !isdefined( options.var_227ead15d2892709 ) )
    {
        options.var_227ead15d2892709 = !options.fadestartnone;
    }
    
    squad function_164d95b45992525( options );
    
    if ( !should_play_igcs() )
    {
        if ( isarray( options.structs ) )
        {
            foreach ( player in squad.players )
            {
                teleport_struct_teleport( squad, player );
            }
        }
        
        if ( isdefined( options.flag ) )
        {
            level utility::flag_set( options.flag );
        }
        
        foreach ( player in squad.players )
        {
            player utility::letterbox_enable( 0, 0 );
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"overlord", #"hash_5041a8f1a1c8b981" ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_5041a8f1a1c8b981", squad.players );
    }
    
    if ( isdefined( options.var_a012c884853e8bb6 ) )
    {
        level utility::flag_set( options.var_a012c884853e8bb6 );
    }
    
    squad thread squad_movie_wait( var_58bb242dbcd8b7e1, options );
    squad utility::ent_flag_wait( "bink_complete" + "_" + var_58bb242dbcd8b7e1 );
    squad utility::ent_flag_clear( "bink_complete" + "_" + var_58bb242dbcd8b7e1 );
    
    foreach ( player in squad.players )
    {
        player utility::letterbox_enable( 0, 2 );
    }
    
    if ( isdefined( options.flag ) )
    {
        level utility::flag_set( options.flag );
    }
    
    waitframe();
}

// Namespace coop
// Params 0
// Checksum 0x31a5c4c5, Offset: 0x16e9
// Size: 0x11, Type: bool
function should_play_igcs()
{
    return !getdvarint( @"hash_d519483cd05fc667", 0 );
}

// Namespace coop
// Params 1
// Checksum 0xcf1d1eac, Offset: 0x1703
// Size: 0x22e
function function_6b96c51a1cdab478( options )
{
    if ( !isdefined( options.var_227ead15d2892709 ) )
    {
        options.var_227ead15d2892709 = 0;
    }
    
    if ( !isdefined( options.var_9172157ef0919145 ) )
    {
        options.var_9172157ef0919145 = 0;
    }
    
    options.spawnpoints = options.structs;
    teleport_struct_prepare( options.squad, options.structs );
    function_a9cf9217d1f518( options );
    
    foreach ( player in options.squad.players )
    {
        teleport_struct_teleport( options.squad, player );
    }
    
    foreach ( player in options.squad.players )
    {
        player set_player_frozen_vars( 1, "teleport_no_cinematic" );
    }
    
    utility::players_stream_wait( options.squad.players );
    
    foreach ( player in options.squad.players )
    {
        player set_player_frozen_vars( 0, "teleport_no_cinematic" );
    }
}

// Namespace coop
// Params 2
// Checksum 0x3fedb066, Offset: 0x1939
// Size: 0x32c
function combat_cleanup( var_de6b8b26899ec0b7 = 1, cleanup_loot = 1 )
{
    level thread callback::callback( #"combat_cleanup" );
    var_5c34f4fc27000b0f = [];
    assert( level.var_91466c5be0885e53 );
    
    foreach ( player in level.players )
    {
        if ( player && player isconnected() && player.sessionstate == "playing" )
        {
            player function_eb6e09941acb48e9();
            var_5c34f4fc27000b0f[ var_5c34f4fc27000b0f.size ] = player.team;
        }
    }
    
    var_8dd99459bf87533e = createentitytypemask( [ "etype_corpse", "etype_missile" ] );
    cleanupents = getentarraybytype( var_8dd99459bf87533e );
    
    foreach ( entity in cleanupents )
    {
        if ( !isdefined( entity ) )
        {
            continue;
        }
        
        entity delete();
    }
    
    if ( isdefined( level.agentarray ) && var_de6b8b26899ec0b7 )
    {
        foreach ( agent in level.agentarray )
        {
            if ( isalive( agent ) && isdefined( agent.team ) && !arraycontains( var_5c34f4fc27000b0f, agent.team ) )
            {
                agent.nocorpse = 1;
                agent.var_a13bed1ac47e1b2c = 1;
                agent.dropweapon = 0;
                
                if ( agent.magic_bullet_shield )
                {
                    agent ai::stop_magic_bullet_shield();
                }
                
                agent agent_utils::despawnagent();
            }
        }
    }
    
    if ( cleanup_loot )
    {
        lootarray = getlootscriptablearray();
        
        foreach ( loot in lootarray )
        {
            common_item::function_869d7676e359a627( loot );
        }
    }
    
    stopallrumbles();
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x1de7528b, Offset: 0x1c6d
// Size: 0x159
function private function_a9cf9217d1f518( options )
{
    if ( options.ignore_cleanup )
    {
        return;
    }
    
    if ( level.gametypebundle.var_ed644d8136588392 )
    {
        level combat_cleanup();
    }
    
    if ( isarray( options.squad.players ) && isdefined( level.var_2a486bda36a2b6e1 ) )
    {
        options.waitrevived = 1;
        
        if ( !isdefined( options.var_9172157ef0919145 ) )
        {
            options.var_9172157ef0919145 = !options.fadestartnone;
        }
        
        options.squad [[ level.var_2a486bda36a2b6e1 ]]( options );
        
        if ( !options.var_227ead15d2892709 && options.var_9172157ef0919145 )
        {
            foreach ( player in options.squad.players )
            {
                player thread player_fade_with_shader( 0, 0.5 );
            }
        }
    }
}

// Namespace coop
// Params 0
// Checksum 0xda293462, Offset: 0x1dce
// Size: 0xa5
function function_84a4cb79f12b855()
{
    assert( level.var_91466c5be0885e53 );
    
    foreach ( player in level.players )
    {
        if ( player.var_76d11c34dc9ca0bf )
        {
            player.var_76d11c34dc9ca0bf = undefined;
            player thread playerlogic::spawnclient();
        }
    }
}

// Namespace coop
// Params 2
// Checksum 0xd49f7ae9, Offset: 0x1e7b
// Size: 0x23
function teleport_struct_prepare( squad, structarray )
{
    squad.teleport_structs = structarray;
}

// Namespace coop
// Params 1
// Checksum 0x5e7b61c8, Offset: 0x1ea6
// Size: 0xee
function teleport_struct_claim( squad )
{
    assert( isplayer( self ) );
    result = undefined;
    
    if ( isarray( squad.teleport_structs ) && squad.teleport_structs.size > 0 )
    {
        foreach ( index, squadplayer in squad.players )
        {
            if ( squadplayer == self )
            {
                index = int( clamp( index, 0, squad.teleport_structs.size - 1 ) );
                return squad.teleport_structs[ index ];
            }
        }
    }
    
    return result;
}

// Namespace coop
// Params 2
// Checksum 0x55b2146, Offset: 0x1f9d
// Size: 0x50
function teleport_struct_teleport( squad, player )
{
    assert( isstruct( squad ) );
    assert( isplayer( player ) );
    var_a1e68c33991c906f = player teleport_struct_claim( squad );
    teleport_player( player, var_a1e68c33991c906f );
}

// Namespace coop
// Params 3
// Checksum 0x2060ed56, Offset: 0x1ff5
// Size: 0x1b7
function teleport_player( player, var_a1e68c33991c906f, b_waitframe = 0 )
{
    assert( isplayer( player ) );
    
    if ( player.sessionstate != "playing" )
    {
        return;
    }
    
    if ( !isdefined( var_a1e68c33991c906f.origin ) )
    {
        return;
    }
    
    playfx( level._effect[ "vfx_pullforward_3p_teleport" ], var_a1e68c33991c906f.origin + ( 0, 0, 0 ) );
    player set_player_frozen_vars( 1, "player_teleport" );
    
    if ( player vehicle::is_in_vehicle() )
    {
        vehicle = player vehicle::get_vehicle();
        seat = vehicle_occupancy::get_occupant_seat( vehicle, player );
        vehicle_occupancy::exit( vehicle, seat, player );
    }
    
    player notify( #"skydive_end" );
    player cancelmantle();
    player dropoffascender();
    player cancelgrapple();
    player skydive_interrupt();
    player function_64f1800c957cf63c();
    
    if ( b_waitframe )
    {
        waitframe();
    }
    
    player dontinterpolate();
    player setorigin( var_a1e68c33991c906f.origin );
    
    if ( isdefined( var_a1e68c33991c906f.angles ) )
    {
        player setplayerangles( var_a1e68c33991c906f.angles );
    }
    
    player function_a4a572d8d09b0f46();
    player set_player_frozen_vars( 0, "player_teleport" );
    player setvelocity( ( 0, 0, 0 ) );
    player setstance( "stand", 1, 1 );
    player cleardamageindicators();
    player utility::callsharedfunc( #"damage_effects", #"hash_7ff5e70e05a98fb0" );
    player.var_cdd6f983c2cfdff = var_a1e68c33991c906f.origin;
}

// Namespace coop
// Params 2
// Checksum 0x3cac9dfe, Offset: 0x21b4
// Size: 0xae
function teleport_players( players, teleport_structs )
{
    assert( isarray( players ) );
    assert( isarray( teleport_structs ) );
    teleport_struct_prepare( level, teleport_structs );
    
    foreach ( player in players )
    {
        teleport_struct_teleport( level, player );
    }
}

// Namespace coop
// Params 4
// Checksum 0xdc8cca3e, Offset: 0x226a
// Size: 0x1bb
function set_player_frozen_vars( var_94d1ab5da995e573, str_id, visible = 1, hidehud = 1 )
{
    if ( var_94d1ab5da995e573 )
    {
        if ( player::isinlaststand( self ) )
        {
            val::set( str_id, "fire", 0 );
        }
        
        if ( !visible )
        {
            val::set( str_id, "hide", 2 );
        }
        
        if ( hidehud )
        {
            val::set( str_id, "show_hud", 0 );
        }
        
        val::set( str_id, "action_slot_weapon", 0 );
        val::set( str_id, "ads", 0 );
        val::set( str_id, "armor", 0 );
        val::set( str_id, "crouch", 0 );
        val::set( str_id, "damage", 0 );
        val::set( str_id, "interactions", 0 );
        val::set( str_id, "killstreaks", 0 );
        val::set( str_id, "melee", 0 );
        val::set( str_id, "allow_movement", 0 );
        val::set( str_id, "offhand_primary_weapons", 0 );
        val::set( str_id, "offhand_secondary_weapons", 0 );
        val::set( str_id, "prone", 0 );
        val::set( str_id, "allow_revive_teammate", 0 );
        val::set( str_id, "supers", 0 );
        val::set( str_id, "usability", 0 );
        val::set( str_id, "vehicle_use", 0 );
        val::set( str_id, "weapon_switch", 0 );
        val::set( str_id, "weapon", 0 );
        val::set( str_id, "freezecontrols", 1 );
        val::set( str_id, "ignoreme", 1 );
        return;
    }
    
    val::reset_all( str_id );
}

// Namespace coop
// Params 2, eflags: 0x4
// Checksum 0x198a553d, Offset: 0x242d
// Size: 0xfa
function private function_d4282187ba0b2786( var_ba7c3b8fa9d3823, structs )
{
    if ( !isvector( var_ba7c3b8fa9d3823 ) )
    {
        var_ba7c3b8fa9d3823 = var_ba7c3b8fa9d3823.origin;
    }
    
    if ( !isvector( var_ba7c3b8fa9d3823 ) )
    {
        return;
    }
    
    if ( !structs )
    {
        return;
    }
    
    if ( !isarray( structs ) )
    {
        structs = [ structs ];
    }
    
    foreach ( struct in structs )
    {
        dest = isvector( struct ) ? struct : struct.origin;
        
        if ( isvector( dest ) && distancesquared( dest, var_ba7c3b8fa9d3823 ) > 1000000 )
        {
            return;
        }
    }
    
    return 1;
}

// Namespace coop
// Params 3
// Checksum 0xfda18971, Offset: 0x2530
// Size: 0x2f3, Type: bool
function player_ready_check( squad = undefined, var_5c2c32049337d029 = 1, waitplaying = 1 )
{
    start = gettime();
    
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        waitframe();
    }
    
    while ( !isdefined( squad ) )
    {
        assert( level.var_91466c5be0885e53 );
        squad = teams::function_72b89edf6b47c40a( level.players[ 0 ] );
        
        if ( isdefined( squad ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( squad utility::ent_flag( "player_ready_check" ) )
    {
        return true;
    }
    
    timeoutend = gettime() + getdvarint( @"hash_1aafe4e89bdab328" ) * 1000;
    
    for ( waitseconds = 0; gettime() < timeoutend && squad squad_party_size() < squad function_b94746b692bbca7c() ; waitseconds++ )
    {
        squad playerlogic::bink_complete_log( undefined, "Squad player_ready_check() waiting on party " + squad squad_party_size() + "/" + squad function_b94746b692bbca7c() + " " + waitseconds );
        squad function_58789647c0a8d6fb();
        wait 1;
    }
    
    if ( squad.players.size < squad function_b94746b692bbca7c() )
    {
        squad playerlogic::bink_complete_log( undefined, "Squad player_ready_check() PLAYER_READY_CHECK_TIMEOUT " + squad.players.size + "/" + squad function_b94746b692bbca7c() );
    }
    else
    {
        squad playerlogic::bink_complete_log( undefined, "Squad player_ready_check() party present " + squad squad_party_size() + "/" + squad function_b94746b692bbca7c() );
    }
    
    nextlog = 0;
    waitseconds = 0;
    
    while ( waitplaying )
    {
        allspawned = 1;
        
        foreach ( player in squad.players )
        {
            if ( player.var_76d11c34dc9ca0bf )
            {
                continue;
            }
            
            if ( player.sessionstate != "playing" )
            {
                allspawned = 0;
                break;
            }
        }
        
        squad function_58789647c0a8d6fb();
        
        if ( allspawned )
        {
            squad playerlogic::bink_complete_log( undefined, "Squad player_ready_check() all spawned" );
            break;
        }
        
        if ( gettime() > nextlog )
        {
            squad playerlogic::bink_complete_log( undefined, "Squad player_ready_check() waiting for all to spawn " + waitseconds );
            nextlog = gettime() + 1000;
            waitseconds++;
        }
        
        waitframe();
    }
    
    level utility::flag_set( "player_ready_check" );
    squad utility::ent_flag_set( "player_ready_check" );
    
    if ( var_5c2c32049337d029 )
    {
        squad playerlogic::bink_complete_log( undefined, "Squad player_ready_check() ready." );
        squad utility::ent_flag_wait( "squad_play_begin" );
    }
    
    return false;
}

/#

    // Namespace coop
    // Params 0
    // Checksum 0xaa0b260f, Offset: 0x282c
    // Size: 0x5, Type: dev
    function function_4accf94162189d75()
    {
        
    }

#/

// Namespace coop
// Params 2
// Checksum 0x9e105034, Offset: 0x2839
// Size: 0x10b9
function squad_movie_wait( var_58bb242dbcd8b7e1 = undefined, options = undefined )
{
    level endon( #"game_ended" );
    squad = self;
    assert( isarray( squad.players ) );
    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "squad_movie_wait() called" );
    var_8eb50b495cebd4b6 = 0;
    var_75e6d406cbbb7340 = 0;
    specificplayers = options.specificplayers;
    var_3363e9df0e40551b = !isdefined( var_58bb242dbcd8b7e1 );
    skipname = ( var_3363e9df0e40551b ? utility::callsharedfunc( #"coop", #"hash_4aaedbb78cff8174", squad.players[ 0 ] ) : var_58bb242dbcd8b7e1 ) ?? "";
    
    if ( options.fadestarthold )
    {
        if ( !isdefined( options.fadestartshader ) )
        {
            options.fadestartshader = "total_black";
        }
    }
    
    if ( options.fadeendhold )
    {
        if ( !isdefined( options.fadeendshader ) )
        {
            options.fadeendshader = "total_black";
        }
    }
    
    var_5e35119886b112e6 = var_3363e9df0e40551b ? getdvarint( @"hash_61fb74018ddc6bea", 0 ) : 0;
    var_2c714a609b237d9c = getdvarint( @"hash_687467591b3414bd", 0 );
    var_bf3f2de1d9355f7f = var_2c714a609b237d9c * 1000;
    assert( var_3363e9df0e40551b || squad utility::ent_flag( "<dev string:x24>" ), "<dev string:x7c>" );
    
    if ( !var_3363e9df0e40551b && !isdefined( specificplayers ) )
    {
        squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "squad notify/endon 'squad_movie_all'" );
        squad.var_62c7b7472b8ae149 = var_58bb242dbcd8b7e1;
        squad notify( #"squad_movie_all" );
        squad endon( #"squad_movie_all" );
    }
    else if ( var_3363e9df0e40551b && isdefined( specificplayers ) )
    {
        assert( specificplayers.size <= 1 );
        
        foreach ( player in specificplayers )
        {
            player endon( #"hash_a2507ffa9a254c4f" );
        }
    }
    
    flagstring = "bink_complete";
    
    if ( !var_3363e9df0e40551b )
    {
        flagstring = "bink_complete" + "_" + var_58bb242dbcd8b7e1;
    }
    
    if ( getdvarint( @"cine_force_none" ) == 1 )
    {
        squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "CINE_FORCE_NONE skipped" );
        squad function_e898bd3317a1c67e( var_58bb242dbcd8b7e1, flagstring, specificplayers );
        return;
    }
    
    squad thread squad_stream_mates( var_58bb242dbcd8b7e1, 50, specificplayers );
    originalskip = options.skip ?? 1;
    var_26c39e21f22efcb3 = getdvarint( @"hash_70e0b48e9ed1fb6f", 0 );
    
    if ( var_26c39e21f22efcb3 )
    {
        seencount = 0;
        relevantcount = 0;
        
        foreach ( player in squad.players )
        {
            if ( isdefined( specificplayers ) && !arraycontains( specificplayers, player ) )
            {
                continue;
            }
            
            relevantcount++;
            
            if ( player utility::callsharedfunc( #"cinematic", #"get_seen", skipname ) ?? 1 )
            {
                seencount++;
            }
        }
        
        if ( var_26c39e21f22efcb3 == 1 && seencount == 0 || var_26c39e21f22efcb3 == 2 && seencount < relevantcount )
        {
            if ( !isdefined( options ) )
            {
                options = {};
            }
            
            options.skip = 0;
        }
    }
    
    foreach ( player in squad.players )
    {
        if ( isdefined( specificplayers ) && !arraycontains( specificplayers, player ) )
        {
            continue;
        }
        
        player function_5c30b188e14a5ca3( squad, "start", var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring );
    }
    
    if ( !var_3363e9df0e40551b && !options.fadestartnone )
    {
        wait 0.25;
    }
    
    if ( options.fadestarthold )
    {
        var_e7e4c462ee30436a = gettime() + options.fadestarthold * 1000;
        squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "FadeStartHold " + options.fadestarthold + " seconds." );
        
        while ( gettime() < var_e7e4c462ee30436a )
        {
            foreach ( player in squad.players )
            {
                if ( isdefined( specificplayers ) && !arraycontains( specificplayers, player ) )
                {
                    continue;
                }
                
                player function_5c30b188e14a5ca3( squad, "active_settings", var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring );
            }
            
            waitframe();
        }
    }
    
    starttime = gettime();
    timeoutms = ( options.timeout ?? 0 ) * 1000;
    timeouttime = starttime + timeoutms;
    var_b8d2e1a718a35f90 = 0;
    readytime = undefined;
    doteleport = isarray( options.structs );
    var_598865406adf5ea9 = undefined;
    donecount = 0;
    donetarget = 0;
    var_775a7eaa6f811d3e = 0;
    var_2534466c004ea849 = [];
    doneset = [];
    latejoinset = [];
    var_ebb23af58dc180b = [];
    var_16c231ff8c67f641 = [];
    var_7b9f88da61238c69 = [];
    
    while ( true )
    {
        now = gettime();
        var_fd39f133321711b1 = donecount;
        var_b12c48384a14d89b = donetarget;
        donecount = 0;
        donetarget = specificplayers.size ?? squad.players.size;
        var_9e7e94bf96a3c74 = 0;
        var_68efaf8941173f4e = 0;
        var_7ec116158e5dcc5a = 0;
        var_5efbb0c94a856184 = var_8eb50b495cebd4b6;
        var_d75da918241e14be = var_75e6d406cbbb7340;
        var_c1bf13bce657de68 = [];
        var_d81d24e66a35e4b = var_b12c48384a14d89b > 1 && var_fd39f133321711b1 > 0 && var_fd39f133321711b1 < var_b12c48384a14d89b;
        
        foreach ( player in squad.players )
        {
            squaderror = player.sessionsquadid != squad function_9bd80c0b7d85aef7();
            playerbit = squad_movie_wait_bit( player );
            playerentnum = player getentitynumber();
            playerkey = player player_key();
            
            if ( var_d81d24e66a35e4b )
            {
                var_7b9f88da61238c69[ playerkey ] = ( var_7b9f88da61238c69[ playerkey ] ?? 0 ) + level.framedurationseconds;
            }
            else
            {
                var_7b9f88da61238c69[ playerkey ] = undefined;
            }
            
            var_c1bf13bce657de68[ playerkey ] = !isdefined( specificplayers ) || arraycontains( specificplayers, player );
            
            if ( var_c1bf13bce657de68[ playerkey ] )
            {
                var_9e7e94bf96a3c74++;
                
                if ( !player utility::function_9a642b48e5d7a5af() )
                {
                    var_7ec116158e5dcc5a++;
                }
            }
            
            var_df18e3148ce20c2d = var_5e35119886b112e6 > 0 && !doneset[ playerkey ] && var_7b9f88da61238c69[ playerkey ] && var_7b9f88da61238c69[ playerkey ] >= var_5e35119886b112e6;
            
            if ( var_df18e3148ce20c2d )
            {
                if ( !player utility::ent_flag( flagstring ) )
                {
                    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Giving up waiting on player " + playerentnum );
                }
                
                player utility::ent_flag_set( flagstring );
            }
            
            netlost = function_56e7612ea9a99c63( player.guid );
            
            if ( netlost != ( var_2534466c004ea849[ playerkey ] ?? 0 ) )
            {
                var_775a7eaa6f811d3e = 0;
            }
            
            var_2534466c004ea849[ playerkey ] = netlost ? 1 : undefined;
            var_7fecf68298659dfe = !var_3363e9df0e40551b && squad utility::ent_flag( "bink_complete" ) && !player utility::ent_flag( "bink_complete" );
            
            if ( var_7fecf68298659dfe != ( latejoinset[ playerkey ] ?? 0 ) )
            {
                var_775a7eaa6f811d3e = 0;
            }
            
            latejoinset[ playerkey ] = var_7fecf68298659dfe ? 1 : undefined;
            
            if ( ( !doteleport || player.var_868f53c382d30586 && isvector( player.var_cdd6f983c2cfdff ) ) && !player.var_b5ee26cfe57fb43a )
            {
                streamloc = doteleport ? player.var_cdd6f983c2cfdff : player.origin;
                player setadditionalstreamposuntilcleared( streamloc );
                player.var_b5ee26cfe57fb43a = now;
            }
            
            var_16c231ff8c67f641[ playerkey ] = player.var_b5ee26cfe57fb43a && now - player.var_b5ee26cfe57fb43a < player utility::function_8088d408510470b8() && !player isadditionalstreamposready();
            
            if ( var_16c231ff8c67f641[ playerkey ] )
            {
                var_d75da918241e14be &= ~playerbit;
            }
            else
            {
                var_d75da918241e14be |= playerbit;
            }
            
            if ( netlost || var_7fecf68298659dfe || isautopilot( player ) || isbot( player ) || squaderror || !var_c1bf13bce657de68[ playerkey ] )
            {
                if ( var_c1bf13bce657de68[ playerkey ] )
                {
                    donecount++;
                    
                    if ( !player utility::function_9a642b48e5d7a5af() )
                    {
                        var_68efaf8941173f4e++;
                    }
                }
                
                if ( !doneset[ playerkey ] )
                {
                    var_775a7eaa6f811d3e = 0;
                }
                
                doneset[ playerkey ] = 1;
                var_5efbb0c94a856184 |= playerbit;
                
                if ( var_7fecf68298659dfe )
                {
                    player.var_93c66a5b4b95f54e = 1;
                }
                
                continue;
            }
            
            if ( !var_7fecf68298659dfe )
            {
                if ( !var_3363e9df0e40551b )
                {
                    if ( !isdefined( player.var_dc89f0b26466673e ) && ( var_ebb23af58dc180b[ playerkey ] ?? 0 ) )
                    {
                        squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Waiting " + var_2c714a609b237d9c + " sec to start late join scripted bink - Player " + playerentnum );
                        player.var_dc89f0b26466673e = now + var_bf3f2de1d9355f7f;
                    }
                    
                    if ( player.var_dc89f0b26466673e )
                    {
                        player function_b5a19bcadac968bd( player.var_dc89f0b26466673e - level.frameduration );
                    }
                    
                    if ( now >= player.var_dc89f0b26466673e )
                    {
                        player.var_dc89f0b26466673e = undefined;
                        var_5efbb0c94a856184 &= ~playerbit;
                        var_8eb50b495cebd4b6 &= ~playerbit;
                        doneset[ playerkey ] = undefined;
                        player notify( #"hash_a2507ffa9a254c4f" );
                        player.var_5b418207f7cbf491 = undefined;
                        player.var_3e9257ceac1a3a23 = undefined;
                        player function_5c30b188e14a5ca3( squad, "start", var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring );
                    }
                }
                
                if ( !isdefined( player.var_dc89f0b26466673e ) )
                {
                    if ( !var_b8d2e1a718a35f90 )
                    {
                        starttime = now;
                        var_b8d2e1a718a35f90 = 1;
                    }
                    
                    player function_5c30b188e14a5ca3( squad, "active", var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring, now - starttime );
                }
            }
            
            player function_5c30b188e14a5ca3( squad, "active_settings", var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring, now - starttime );
            
            if ( player utility::ent_flag( flagstring ) && !var_16c231ff8c67f641[ playerkey ] )
            {
                donecount++;
                
                if ( !player utility::function_9a642b48e5d7a5af() )
                {
                    var_68efaf8941173f4e++;
                }
                
                if ( !doneset[ playerkey ] )
                {
                    var_775a7eaa6f811d3e = 0;
                }
                
                doneset[ playerkey ] = 1;
                var_5efbb0c94a856184 |= playerbit;
                continue;
            }
            
            if ( doneset[ playerkey ] )
            {
                var_775a7eaa6f811d3e = 0;
            }
            
            doneset[ playerkey ] = undefined;
        }
        
        if ( originalskip && var_7ec116158e5dcc5a > 0 && var_68efaf8941173f4e >= var_7ec116158e5dcc5a )
        {
            if ( !isdefined( options ) )
            {
                options = {};
            }
            
            if ( !options.skip )
            {
                squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Opening ui_is_bink_skippable = true for everyone in squad" );
            }
            
            options.skip = 1;
        }
        
        istimedout = isdefined( options.timeout ) && now > timeouttime;
        
        if ( var_8eb50b495cebd4b6 != var_5efbb0c94a856184 || var_75e6d406cbbb7340 != var_d75da918241e14be )
        {
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "state changed: PM:" + var_8eb50b495cebd4b6 + " NM:" + var_5efbb0c94a856184 + " PL:" + var_75e6d406cbbb7340 + " NL:" + var_d75da918241e14be + " Done: " + donecount + " Target: " + donetarget + " Timeout: " + istimedout );
        }
        
        if ( now >= var_775a7eaa6f811d3e )
        {
            playersmsg = squad function_5dfad59e8e99843e( var_c1bf13bce657de68, doneset, var_2534466c004ea849, latejoinset, var_16c231ff8c67f641 );
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Waiting. " + playersmsg + " Done: " + donecount + " Target: " + donetarget + " Sec: " + ( now - starttime ) / 1000 );
            var_775a7eaa6f811d3e = now + 1000;
        }
        
        var_8eb50b495cebd4b6 = var_5efbb0c94a856184;
        var_75e6d406cbbb7340 = var_d75da918241e14be;
        var_ebb23af58dc180b = arraycopy( latejoinset );
        
        if ( donecount == donetarget || istimedout )
        {
            finished = 1;
            
            if ( options.fadeendhold )
            {
                if ( !isdefined( var_598865406adf5ea9 ) )
                {
                    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "FadeEndHold " + options.fadeendhold + " seconds." );
                    var_598865406adf5ea9 = now + options.fadeendhold * 1000;
                    
                    foreach ( player in squad.players )
                    {
                        playerkey = player player_key();
                        playerentnum = player getentitynumber();
                        
                        if ( !var_c1bf13bce657de68[ playerkey ] )
                        {
                            continue;
                        }
                        
                        squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "FadeEndHold stop cinematic - Player: " + playerentnum );
                        player stopcinematicforplayer( 1, 1 );
                        player setclientomnvar( "ui_coop_bink_overlay_state", 0 );
                    }
                }
                
                if ( now < var_598865406adf5ea9 )
                {
                    finished = 0;
                }
            }
            
            if ( finished )
            {
                if ( var_3363e9df0e40551b && !isdefined( readytime ) && !isdefined( specificplayers ) )
                {
                    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "READY. Waiting " + var_2c714a609b237d9c + " seconds before continuing. Count: " + donecount + " Target: " + donetarget + " Timeout: " + istimedout );
                    readytime = now;
                }
                
                if ( var_3363e9df0e40551b && readytime )
                {
                    var_71435dea6601e5dc = readytime + var_bf3f2de1d9355f7f;
                    
                    foreach ( player in squad.players )
                    {
                        playerkey = player player_key();
                        
                        if ( !var_c1bf13bce657de68[ playerkey ] || latejoinset[ playerkey ] && !isautopilot( player ) && !isbot( player ) )
                        {
                            continue;
                        }
                        
                        player function_b5a19bcadac968bd( var_71435dea6601e5dc - level.frameduration );
                    }
                }
                
                if ( !isdefined( readytime ) || now - readytime >= var_bf3f2de1d9355f7f )
                {
                    playersmsg = squad function_5dfad59e8e99843e( var_c1bf13bce657de68, doneset, var_2534466c004ea849, latejoinset, var_16c231ff8c67f641 );
                    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "DONE. " + playersmsg + " Done: " + donecount + " Target: " + donetarget + " Timeout: " + istimedout );
                    
                    foreach ( player in squad.players )
                    {
                        playerkey = player player_key();
                        
                        if ( !var_3363e9df0e40551b && player.var_93c66a5b4b95f54e )
                        {
                            player.var_93c66a5b4b95f54e = undefined;
                        }
                        
                        if ( !var_c1bf13bce657de68[ playerkey ] || latejoinset[ playerkey ] && !isautopilot( player ) && !isbot( player ) )
                        {
                            continue;
                        }
                        
                        player function_5c30b188e14a5ca3( squad, "finished", var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring );
                        player utility::callsharedfunc( #"cinematic", #"set_seen", skipname, 1 );
                    }
                    
                    squad function_e898bd3317a1c67e( var_58bb242dbcd8b7e1, flagstring, specificplayers );
                    squad thread squad_stream_mates( var_58bb242dbcd8b7e1, -1, specificplayers );
                    return;
                }
            }
        }
        else
        {
            readytime = undefined;
        }
        
        if ( var_9e7e94bf96a3c74 == 0 && now - starttime > 1000 )
        {
            squad thread squad_stream_mates( var_58bb242dbcd8b7e1, -1, specificplayers );
            return;
        }
        
        waitframe();
    }
    
    squad thread squad_stream_mates( var_58bb242dbcd8b7e1, -1, specificplayers );
}

// Namespace coop
// Params 5, eflags: 0x4
// Checksum 0x60e1a47, Offset: 0x38fa
// Size: 0x191
function private function_5dfad59e8e99843e( var_c1bf13bce657de68, doneset, var_2534466c004ea849, latejoinset, var_16c231ff8c67f641 )
{
    squad = self;
    assert( self != level );
    assert( isarray( squad.players ) );
    playersmsg = " ";
    
    foreach ( player in squad.players )
    {
        playerkey = player player_key();
        
        if ( !var_c1bf13bce657de68[ playerkey ] )
        {
            continue;
        }
        
        playerentnum = player getentitynumber();
        playersmsg = playersmsg + playerentnum + ":";
        playersmsg = playersmsg + ( player.name ?? "??" ) + ":";
        playersmsg += doneset[ playerkey ] ? "D" : var_16c231ff8c67f641[ playerkey ] ? "s" : "w";
        playersmsg += var_2534466c004ea849[ playerkey ] ? "L " : latejoinset[ playerkey ] ? "J " : " ";
    }
    
    return "players:<" + playersmsg + ">";
}

// Namespace coop
// Params 3, eflags: 0x4
// Checksum 0xff0a1aae, Offset: 0x3a94
// Size: 0x207
function private function_e898bd3317a1c67e( var_58bb242dbcd8b7e1, flagstring, specificplayers )
{
    squad = self;
    assert( self != level );
    assert( isarray( squad.players ) );
    var_3363e9df0e40551b = !isdefined( var_58bb242dbcd8b7e1 );
    
    foreach ( player in squad.players )
    {
        var_c1bf13bce657de68 = !isdefined( specificplayers ) || arraycontains( specificplayers, player );
        
        if ( !var_c1bf13bce657de68 )
        {
            continue;
        }
        
        if ( !var_3363e9df0e40551b )
        {
            player utility::ent_flag_clear( flagstring, 1 );
        }
        
        if ( !player utility::ent_flag( "squad_play_begin" ) )
        {
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "SQUAD_PLAY_BEGIN flag set for player " + ( isent( player ) ? player getentitynumber() : "<unknown>" ) );
        }
        
        player utility::ent_flag_set( "squad_play_begin" );
    }
    
    if ( var_3363e9df0e40551b && !isdefined( specificplayers ) )
    {
        if ( !squad utility::ent_flag( "squad_play_begin" ) )
        {
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "SQUAD_PLAY_BEGIN flag set for squad " + ( squad.index ?? "<unknown>" ) );
        }
        
        squad utility::ent_flag_set( "squad_play_begin" );
        
        if ( !level utility::flag( "squad_play_begin" ) )
        {
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "SQUAD_PLAY_BEGIN flag set for level" );
        }
        
        level utility::flag_set( "squad_play_begin" );
    }
    
    squad utility::ent_flag_set( flagstring );
    
    if ( !var_3363e9df0e40551b && !isdefined( specificplayers ) && squad.var_62c7b7472b8ae149 == var_58bb242dbcd8b7e1 )
    {
        squad.var_62c7b7472b8ae149 = undefined;
    }
    
    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, flagstring + " flag set for squad" );
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x6484b9d0, Offset: 0x3ca3
// Size: 0x6b
function private function_a3b614d6201361b8( var_75e6d406cbbb7340 )
{
    assert( isplayer( self ) );
    player = self;
    longloader = getdvarint( @"hash_b69915ff26107a89", -1 );
    
    if ( longloader >= 0 && gettime() < 30000 )
    {
        var_75e6d406cbbb7340 &= ~( 1 << longloader );
    }
    
    player setclientomnvar( "ui_player_load_state", var_75e6d406cbbb7340 );
}

// Namespace coop
// Params 8, eflags: 0x4
// Checksum 0x6315ac58, Offset: 0x3d16
// Size: 0x6c5
function private function_5c30b188e14a5ca3( squad, state, var_58bb242dbcd8b7e1, var_8eb50b495cebd4b6, var_75e6d406cbbb7340, options, flagstring, var_10e9e1fdbbd10ab0 = 0 )
{
    assert( isplayer( self ) );
    player = self;
    playerentnum = player getentitynumber();
    doteleport = isarray( options.structs );
    player setclientomnvar( "ui_player_movie_state", var_8eb50b495cebd4b6 );
    player function_a3b614d6201361b8( var_75e6d406cbbb7340 );
    
    switch ( state )
    {
        case #"hash_c6514c88e37149bf":
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Player start : ui_player_movie_state: " + var_8eb50b495cebd4b6 + ", Player: " + playerentnum );
            player val::set( "squad_movie_wait_hud", "show_hud", 0 );
            
            if ( isdefined( var_58bb242dbcd8b7e1 ) )
            {
                squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Player notify 'squad_movie_all', " + flagstring + " cleared for Player: " + playerentnum );
                player notify( #"squad_movie_all" );
                player.waitingmovie = var_58bb242dbcd8b7e1;
                player utility::ent_flag_clear( flagstring, 1 );
            }
            
            if ( isdefined( var_58bb242dbcd8b7e1 ) && !options.fadestartnone && !player.var_f7b891d8cdeddf0 )
            {
                player thread player_fade_with_shader( 1, 0.25, options.fadestartshader ?? "black" );
            }
            else if ( ( options.fadestartshader ?? "black" ) != "none" )
            {
                player thread player_fade_with_shader( 1, 0, options.fadestartshader ?? "black" );
            }
            
            player.var_f7b891d8cdeddf0 = undefined;
            player setclientomnvar( "ui_is_bink_skippable", options.skip ?? 1 );
            player setclientomnvar( "ui_player_movie_fade", 0 );
            player.var_868f53c382d30586 = undefined;
            player.var_b5ee26cfe57fb43a = undefined;
            player.var_cdd6f983c2cfdff = undefined;
            
            if ( ( isautopilot( player ) || isbot( player ) ) && doteleport && !player.var_868f53c382d30586 )
            {
                teleport_struct_teleport( squad, player );
                player.var_868f53c382d30586 = 1;
            }
            
            break;
        case #"hash_bee8aefcdf5a9a8f":
            if ( isdefined( var_58bb242dbcd8b7e1 ) && !player.var_f83d003b37bd66ba[ var_58bb242dbcd8b7e1 ] )
            {
                squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "PlayCinematicForPlayer('" + var_58bb242dbcd8b7e1 + "') - Player: " + playerentnum );
                player playcinematicforplayer( var_58bb242dbcd8b7e1, 1, undefined, undefined, var_10e9e1fdbbd10ab0 );
                player.var_f83d003b37bd66ba[ var_58bb242dbcd8b7e1 ] = 1;
                player utility::ent_flag_set( "cinematic_playing" );
            }
            
            if ( doteleport && !player.var_868f53c382d30586 )
            {
                var_a2ae9555f63e9411 = max( 0, ( options.teleportdelay ?? 0 ) - float( ( var_10e9e1fdbbd10ab0 ?? 0 ) / 1000 ) );
                squad utility::delaythreadendon( var_a2ae9555f63e9411, "squad_movie_all", &teleport_struct_teleport, squad, player );
                player.var_868f53c382d30586 = 1;
            }
            
            var_77c8e17e4af4d9e0 = isdefined( var_58bb242dbcd8b7e1 ) ? 1 : 3;
            
            if ( player.var_2977cfad7dc5beb4 != var_77c8e17e4af4d9e0 )
            {
                squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "ui_coop_bink_overlay_state" + " set: " + var_77c8e17e4af4d9e0 + ", Player: " + playerentnum );
                player setclientomnvar( "ui_coop_bink_overlay_state", var_77c8e17e4af4d9e0 );
                player.var_2977cfad7dc5beb4 = var_77c8e17e4af4d9e0;
            }
            
            if ( options.fadeendshader && var_10e9e1fdbbd10ab0 > 500 && !player.var_3e9257ceac1a3a23 )
            {
                player thread player_fade_with_shader( 1, 0, options.fadeendshader );
                player.var_3e9257ceac1a3a23 = 1;
            }
            
            break;
        case #"hash_e1b459fa6d1d6fdd":
            player setclientomnvar( "ui_is_bink_skippable", options.skip ?? 1 );
            
            if ( !player.var_5b418207f7cbf491 )
            {
                if ( isdefined( var_58bb242dbcd8b7e1 ) )
                {
                    player.waitingmovie = var_58bb242dbcd8b7e1;
                }
                
                player set_player_frozen_vars( 1, "squad_movie_wait", 0, 0 );
                player.var_5b418207f7cbf491 = 1;
            }
            
            break;
        case #"hash_498c64936fbf5103":
            squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Player finished - Player: " + playerentnum );
            
            if ( player.var_149d4dd34a19276f )
            {
                squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Player had load movie hold. Leaving cinematic and bink overlay state active - Player: " + playerentnum );
            }
            
            if ( isdefined( var_58bb242dbcd8b7e1 ) || !player.var_93c66a5b4b95f54e )
            {
                if ( isdefined( var_58bb242dbcd8b7e1 ) && player.var_f83d003b37bd66ba[ var_58bb242dbcd8b7e1 ] )
                {
                    player.var_f83d003b37bd66ba[ var_58bb242dbcd8b7e1 ] = undefined;
                    
                    if ( !player.var_149d4dd34a19276f )
                    {
                        player stopcinematicforplayer( 1, 1 );
                        player utility::ent_flag_clear( "cinematic_playing", 1 );
                    }
                }
                
                fadeenddelay = options.fadeenddelay ?? level.framedurationseconds * 2;
                player utility::delaythreadendon( fadeenddelay, "squad_movie_all", &set_player_frozen_vars, 0, "squad_movie_wait" );
                
                if ( !options.fadeendnone )
                {
                    player utility::delaythreadendon( fadeenddelay + level.framedurationseconds * 1, "squad_movie_all", &player_fade_with_shader, 0, 0.4, options.fadeendshader ?? "black" );
                    player utility::delaythreadendon( fadeenddelay + 0.4 + level.framedurationseconds * 1, "squad_movie_all", &val::reset_all, "player_fade_with_shader" );
                    player utility::delaythreadendon( fadeenddelay + level.framedurationseconds * 3, "squad_movie_all", &val::reset_all, "squad_movie_wait_hud" );
                }
                
                player.var_93c66a5b4b95f54e = undefined;
                player.var_dc89f0b26466673e = undefined;
                player.var_5b418207f7cbf491 = undefined;
                player.var_2977cfad7dc5beb4 = undefined;
                player.var_868f53c382d30586 = undefined;
                player.waitingmovie = undefined;
                player.var_3e9257ceac1a3a23 = undefined;
                
                if ( player.var_b5ee26cfe57fb43a )
                {
                    player clearadditionalstreampos();
                    player.var_b5ee26cfe57fb43a = undefined;
                }
                
                if ( !player.var_149d4dd34a19276f )
                {
                    player setclientomnvar( "ui_coop_bink_overlay_state", 0 );
                }
                
                player setclientomnvar( "ui_is_bink_skippable", 0 );
                player setclientomnvar( "ui_player_movie_fade", 0 );
                squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "Player finished : Enable Controls, Show Hud, ui_is_bink_skippable 0, " + "ui_coop_bink_overlay_state" + " " + 0 + ", Player: " + playerentnum );
            }
            
            break;
        default:
            assert( 0, "<dev string:xd4>" + state + "<dev string:xfe>" );
            break;
    }
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x177d7cf4, Offset: 0x43e3
// Size: 0xa0
function private function_b5a19bcadac968bd( var_71435dea6601e5dc )
{
    assert( isplayer( self ) );
    max_value = 63;
    player = self;
    now = gettime();
    fadefraction = 0;
    var_d4d7c50dd1b9a6ff = 1000;
    var_7d650414729a6f15 = var_71435dea6601e5dc - var_d4d7c50dd1b9a6ff;
    
    if ( now > var_7d650414729a6f15 )
    {
        fadefraction = clamp( float( now - var_7d650414729a6f15 ) / float( var_d4d7c50dd1b9a6ff ), 0, 1 );
    }
    
    player setclientomnvar( "ui_player_movie_fade", int( fadefraction * max_value ) );
}

// Namespace coop
// Params 1
// Checksum 0x57049912, Offset: 0x448b
// Size: 0x30
function function_367a5824a0d5edd4( player )
{
    player.var_149d4dd34a19276f = 1;
    player playerlogic::bink_complete_log( undefined, "Load movie hold acquired - Player: " + player getentitynumber() );
}

// Namespace coop
// Params 1
// Checksum 0xac05ec28, Offset: 0x44c3
// Size: 0x8d
function function_c3c78f0c69cbacc5( player )
{
    if ( player.var_149d4dd34a19276f )
    {
        player.var_149d4dd34a19276f = undefined;
        moviestopped = 0;
        
        if ( !isdefined( player.waitingmovie ) )
        {
            moviestopped = 1;
            player stopcinematicforplayer( 1, 1 );
            player setclientomnvar( "ui_coop_bink_overlay_state", 0 );
            player utility::ent_flag_clear( "cinematic_playing", 1 );
        }
        
        player playerlogic::bink_complete_log( undefined, "Releasing load movie hold. - Player: " + player getentitynumber() + " MovieStopped: " + moviestopped );
    }
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x5d611630, Offset: 0x4558
// Size: 0x18
function private player_map_to_map_start( params )
{
    self notify( #"squad_movie_all" );
}

// Namespace coop
// Params 0, eflags: 0x4
// Checksum 0xe8f9f7a1, Offset: 0x4578
// Size: 0x10f
function private function_58789647c0a8d6fb()
{
    assert( isarray( self.players ) );
    var_75e6d406cbbb7340 = 0;
    
    foreach ( player in self.players )
    {
        var_75e6d406cbbb7340 |= squad_movie_wait_bit( player );
    }
    
    foreach ( player in self.players )
    {
        player function_a3b614d6201361b8( var_75e6d406cbbb7340 );
    }
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x2459dea7, Offset: 0x468f
// Size: 0x30
function private squad_movie_wait_bit( player )
{
    playerentnum = player getentitynumber();
    assert( playerentnum < 32 );
    return 1 << playerentnum;
}

// Namespace coop
// Params 0, eflags: 0x4
// Checksum 0x63f085a7, Offset: 0x46c8
// Size: 0x93
function private function_e06b3278f97c59c7()
{
    squad = self;
    assert( isarray( squad.players ) );
    
    if ( !squad.var_4dbb4ab0ed21aab5 )
    {
        squad.var_4dbb4ab0ed21aab5 = 1;
        
        if ( !squad utility::ent_flag( "bink_complete" ) )
        {
            if ( !level.coop_reload )
            {
                squad thread squad_movie_wait();
                squad utility::ent_flag_wait( "bink_complete" );
            }
            
            level utility::flag_set( "bink_complete" );
            squad utility::ent_flag_set( "bink_complete" );
        }
    }
}

// Namespace coop
// Params 0, eflags: 0x4
// Checksum 0x8ef50034, Offset: 0x4763
// Size: 0x18f
function private squad_party_size()
{
    squad = self;
    assert( isarray( squad.players ) );
    var_219a5a278e231aa5 = 0;
    connected = [];
    
    foreach ( player in squad.players )
    {
        connected[ player.guid ] = 1;
        var_219a5a278e231aa5++;
    }
    
    allplayersparty = getpartyinfo();
    
    foreach ( allplayersmember in allplayersparty )
    {
        var_c3a69aba587eb18f = teams::getsquaddata( allplayersmember.team, allplayersmember.sessionsquadid );
        
        if ( var_c3a69aba587eb18f != squad )
        {
            continue;
        }
        
        if ( !connected[ allplayersmember.xuid ] && function_56e7612ea9a99c63( allplayersmember.xuid ) )
        {
            var_219a5a278e231aa5++;
        }
    }
    
    return var_219a5a278e231aa5;
}

// Namespace coop
// Params 0, eflags: 0x4
// Checksum 0x1fa7908, Offset: 0x48fb
// Size: 0x15f
function private function_b94746b692bbca7c()
{
    squad = self;
    assert( isarray( squad.players ) );
    var_219a5a278e231aa5 = 0;
    
    if ( level.onlinegame )
    {
        allplayersparty = getpartyinfo();
        
        foreach ( allplayersmember in allplayersparty )
        {
            var_c3a69aba587eb18f = teams::getsquaddata( allplayersmember.team, allplayersmember.sessionsquadid );
            
            if ( var_c3a69aba587eb18f != squad )
            {
                continue;
            }
            
            var_219a5a278e231aa5++;
        }
    }
    else if ( isdedicatedserver() )
    {
        var_7c8e85bdcf4722fb = getdvarint( @"hash_10a81f3d3159dfd6", 0 );
        var_f52e2f2af3cdb7af = getdvarint( @"hash_d5d17ffd60db08fc", 0 );
        var_ffc409c605b57d71 = level.maxsquadsize ?? 4;
        var_219a5a278e231aa5 = int( min( var_ffc409c605b57d71, var_7c8e85bdcf4722fb > 0 ? var_7c8e85bdcf4722fb : var_f52e2f2af3cdb7af > 0 ? var_f52e2f2af3cdb7af : 4 ) );
    }
    
    return var_219a5a278e231aa5;
}

// Namespace coop
// Params 0
// Checksum 0xb66126e6, Offset: 0x4a63
// Size: 0x224
function function_9bd80c0b7d85aef7()
{
    squad = self;
    assert( isarray( squad.players ) );
    var_6027bcabacd3a0a8 = -1;
    var_51ba7a8884885dfc = [];
    var_13441f8ced62ac01 = 0;
    squaderror = 0;
    
    foreach ( player in squad.players )
    {
        var_51ba7a8884885dfc[ player.sessionsquadid ] = ( var_51ba7a8884885dfc[ player.sessionsquadid ] ?? 0 ) + 1;
        
        if ( var_13441f8ced62ac01 < var_51ba7a8884885dfc[ player.sessionsquadid ] )
        {
            var_13441f8ced62ac01 = var_51ba7a8884885dfc[ player.sessionsquadid ];
            var_6027bcabacd3a0a8 = player.sessionsquadid;
        }
        
        if ( player.sessionsquadid != var_6027bcabacd3a0a8 )
        {
            squaderror = 1;
        }
    }
    
    if ( squaderror && gettime() - ( squad.var_a3966b32e8f7d61e ?? 0 ) > 5000 )
    {
        msg = "SQUAD_PARTY_ID_MISMATCH: ";
        
        foreach ( player in squad.players )
        {
            msg = msg + "<" + ( player.name ?? "?" ) + ":" + player.sessionsquadid + "> ";
        }
        
        msg += "\n";
        logstring( msg );
        
        /#
            iprintlnbold( msg );
        #/
        
        squad.var_a3966b32e8f7d61e = gettime();
    }
    
    return var_6027bcabacd3a0a8;
}

// Namespace coop
// Params 1
// Checksum 0xb3a8225, Offset: 0x4c90
// Size: 0x23f
function function_ca1c6723a350447f( options )
{
    options.triggerradius = options.triggerradius ?? 200;
    
    if ( !isdefined( options.squad ) )
    {
        if ( isarray( options.players ) && isplayer( options.players[ 0 ] ) )
        {
            options.squad = teams::function_72b89edf6b47c40a( options.players[ 0 ] );
        }
        else
        {
            options.squad = teams::function_72b89edf6b47c40a( level.players[ 0 ] );
        }
    }
    
    if ( isdefined( options.var_ba7c3b8fa9d3823 ) )
    {
        initiator_origin = options.var_ba7c3b8fa9d3823.origin;
    }
    
    function_164d95b45992525( options );
    
    if ( options.triggertargetname )
    {
        proximity_zone = getent( options.triggertargetname, #targetname );
    }
    else if ( initiator_origin )
    {
        if ( isvector( options.var_ba7c3b8fa9d3823.origin ) )
        {
            proximity_zone = spawn( "trigger_radius", initiator_origin, 0, options.triggerradius, 90 );
        }
    }
    
    var_b0c8e210a11835de = [];
    
    if ( proximity_zone )
    {
        foreach ( player in options.squad.players )
        {
            is_in_proximity = player istouching( proximity_zone );
            
            if ( !is_in_proximity )
            {
                var_b0c8e210a11835de[ var_b0c8e210a11835de.size ] = player;
            }
        }
    }
    
    if ( isarray( options.teleport_structs ) && var_b0c8e210a11835de.size > 0 )
    {
        teleport_players( var_b0c8e210a11835de, options.teleport_structs );
    }
    
    if ( isdefined( options.flag_completed ) )
    {
        level utility::flag_set( options.flag_completed );
    }
}

// Namespace coop
// Params 1
// Checksum 0x5a721f6, Offset: 0x4ed7
// Size: 0x6be
function function_164d95b45992525( options )
{
    triggertargetname = options.triggertargetname;
    triggerradius = options.triggerradius ?? 400;
    var_ba7c3b8fa9d3823 = options.var_ba7c3b8fa9d3823;
    options.var_c730a865d18af814 = [];
    
    if ( !isdefined( options.var_de58f4091168696e ) )
    {
        options.var_de58f4091168696e = 1;
    }
    
    if ( !isdefined( options.var_bc9975ee52154653 ) )
    {
        options.var_bc9975ee52154653 = 60;
    }
    
    if ( !isdefined( options.countdown ) )
    {
        options.countdown = options.var_30215d8ee868ab1b ?? 5;
    }
    
    if ( !isdefined( options.squad ) )
    {
        if ( isarray( options.players ) && options != level && isplayer( options.players[ 0 ] ) )
        {
            options.squad = teams::function_72b89edf6b47c40a( options.players[ 0 ] );
        }
        else
        {
            assert( level.var_91466c5be0885e53 );
            options.squad = teams::function_72b89edf6b47c40a( level.players[ 0 ] );
        }
    }
    
    squad = options.squad;
    
    foreach ( player in options.squad.players )
    {
        player setclientomnvar( "ui_coop_activity_squad_ready_count", 0 );
    }
    
    if ( options.countdown <= 0 || squad.players.size <= 1 && !getdvarint( @"hash_85d1dfb1364cfef4", 0 ) )
    {
        options.var_227ead15d2892709 = 1;
        function_3e380f3e105e720e( options );
        return;
    }
    
    if ( isdefined( triggertargetname ) )
    {
        proximity_zone = getent( triggertargetname, #targetname );
    }
    
    if ( !isdefined( proximity_zone ) && !isvector( var_ba7c3b8fa9d3823.origin ) )
    {
        options.noregroup = 1;
    }
    
    if ( !isdefined( options.teleporthere ) )
    {
        options.teleporthere = function_d4282187ba0b2786( var_ba7c3b8fa9d3823, options.structs );
    }
    
    if ( !options.noregroup )
    {
        if ( isdefined( triggertargetname ) )
        {
            assert( isdefined( proximity_zone ), "<dev string:x100>" + triggertargetname + "<dev string:x11b>" );
        }
        
        if ( !isdefined( proximity_zone ) )
        {
            if ( isvector( var_ba7c3b8fa9d3823.origin ) )
            {
                options.proximity_zone = spawn( "trigger_radius", var_ba7c3b8fa9d3823.origin + ( 0, 0, -35 ), 0, triggerradius, 120 );
            }
            else
            {
                assertmsg( "<dev string:x129>" );
                function_3e380f3e105e720e( options );
                return;
            }
            
            proximity_zone = options.proximity_zone;
        }
        
        bounds = proximity_zone getboundscorners();
        center = vectorlerp( bounds[ 0 ], bounds[ 1 ], 0.5 );
        options.obj_circle = spawnquestcircle( "Quest_Ob", center[ 0 ], center[ 1 ], distance( bounds[ 1 ], center ) * 0.7, undefined );
        options.obj_circle hide();
        
        if ( !options.var_53b92de89ec442c4 && isdefined( level.gametypebundle.var_eaa79060d068dbfa ) )
        {
            options.obj_id = level namespace_d7fa4530141146a5::function_f94c04cdce542f08( level.gametypebundle.var_eaa79060d068dbfa );
            objidpoolmanager::objective_set_play_intro( options.obj_id, 1 );
            objidpoolmanager::objective_set_play_outro( options.obj_id, 1 );
            obj_marker_origin = isvector( var_ba7c3b8fa9d3823.origin ) ? var_ba7c3b8fa9d3823.origin : center;
            obj_marker_origin = getgroundposition( obj_marker_origin + ( 0, 0, 1 ), 5 );
            objidpoolmanager::update_objective_position( options.obj_id, obj_marker_origin + ( 0, 0, 32 ) );
            objidpoolmanager::objective_playermask_hidefromallplayers( options.obj_id );
            function_2b8e3d3ae2a6414a( options.obj_id, 0 );
        }
        
        if ( !options.noobjectivehide )
        {
            foreach ( player in squad.players )
            {
                var_1a2b03ec7506797d = function_6303f951225dbd49( player );
                
                foreach ( objid in var_1a2b03ec7506797d )
                {
                    objidpoolmanager::objective_playermask_hidefrom( objid, player );
                }
            }
        }
        
        foreach ( player in squad.players )
        {
            playerkey = player player_key();
            options.var_c730a865d18af814[ playerkey ] = player istouching( proximity_zone ) || !( player.sessionstate == "playing" && !player::isinlaststand( player ) );
            options.obj_circle showtoplayer( player );
        }
        
        trigger::makeenterexittrigger( proximity_zone, &function_dde632a1594ac256, &function_bfcbfbb629488b20, undefined, undefined, &function_c3684ef19ddc6510, options );
    }
    
    squad thread function_77421d983614ec57( options );
    squad utility::ent_flag_wait( "COOP_SQUAD_REGROUP_COMPLETE" );
    squad utility::ent_flag_clear( "COOP_SQUAD_REGROUP_COMPLETE" );
    function_3e380f3e105e720e( options );
}

// Namespace coop
// Params 2, eflags: 0x4
// Checksum 0x3e709c9c, Offset: 0x559d
// Size: 0x226
function private function_3e380f3e105e720e( options, regrouponly = 0 )
{
    var_48b1eea32dd9b523 = "squad_id_not_found";
    
    if ( options.squad )
    {
        var_48b1eea32dd9b523 = options.squad function_9bd80c0b7d85aef7();
    }
    
    if ( isdefined( options.proximity_zone ) )
    {
        options.proximity_zone delete();
        options.proximity_zone = undefined;
    }
    
    if ( isdefined( options.obj_circle ) )
    {
        options.obj_circle delete();
        options.obj_circle = undefined;
    }
    
    if ( isdefined( options.obj_id ) )
    {
        level namespace_d7fa4530141146a5::function_501e44ea1cb9219d( options.obj_id );
        options.obj_id = undefined;
    }
    
    foreach ( player in options.squad.players )
    {
        player.var_de884b95ddb0f44 = undefined;
        
        if ( player.var_752047c2c0651b50 )
        {
            player.var_752047c2c0651b50 = undefined;
            player clearadditionalstreampos();
        }
    }
    
    if ( regrouponly )
    {
        return;
    }
    
    level function_a9cf9217d1f518( options );
    
    if ( isdefined( options.flag_countdown ) )
    {
        level utility::flag_set( options.flag_countdown );
    }
    
    foreach ( player in options.squad.players )
    {
        player setclientomnvar( "ui_coop_activity_squad_ready_count", 0 );
    }
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x7422e3a5, Offset: 0x57cb
// Size: 0xa9
function private function_77421d983614ec57( options )
{
    assert( isstruct( self ) );
    assert( self != level );
    assert( isarray( self.players ) );
    squad = self;
    squad endon( #"COOP_SQUAD_REGROUP_COMPLETE" );
    
    if ( !options.noregroup )
    {
        squad function_89d9f28c0ea96fe7( options, 1, options.var_bc9975ee52154653, options.countdown );
    }
    
    squad function_89d9f28c0ea96fe7( options, 2, options.countdown );
    squad utility::ent_flag_set( "COOP_SQUAD_REGROUP_COMPLETE" );
}

// Namespace coop
// Params 3, eflags: 0x4
// Checksum 0x111bd699, Offset: 0x587c
// Size: 0x106
function private function_dde632a1594ac256( ent, trigger, options )
{
    if ( ent vehicle::is_vehicle() )
    {
        vehicle_occupants = vehicle_occupancy::get_all_occupants( ent );
        
        foreach ( player in vehicle_occupants )
        {
            if ( isplayer( player ) && isdefined( options.squad.players ) && arraycontains( options.squad.players, player ) )
            {
                player function_33e1e1cf2898439e( options );
            }
        }
        
        return;
    }
    
    if ( isplayer( ent ) )
    {
        ent function_33e1e1cf2898439e( options );
    }
}

// Namespace coop
// Params 3, eflags: 0x4
// Checksum 0x5a6f658f, Offset: 0x598a
// Size: 0x5a
function private function_bfcbfbb629488b20( player, trigger, options )
{
    if ( options.var_2b79828dcc50cbcc && isplayer( player ) )
    {
        playerkey = player player_key();
        options.var_c730a865d18af814[ playerkey ] = 0;
    }
}

// Namespace coop
// Params 3, eflags: 0x4
// Checksum 0x87ad047f, Offset: 0x59ec
// Size: 0x75, Type: bool
function private function_c3684ef19ddc6510( ent, trigger, options )
{
    if ( ent vehicle::is_vehicle() )
    {
        return false;
    }
    
    if ( !isplayer( ent ) )
    {
        return true;
    }
    
    if ( isdefined( options.squad.players ) && !arraycontains( options.squad.players, ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x222f2cea, Offset: 0x5a6a
// Size: 0x3c
function private function_33e1e1cf2898439e( options )
{
    player = self;
    playerkey = player player_key();
    options.var_c730a865d18af814[ playerkey ] = 1;
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x3ead4ea1, Offset: 0x5aae
// Size: 0x28d
function private function_b1fefba5894618ff( options )
{
    var_7b65f8b92373d30a = 0;
    
    foreach ( player in options.squad.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        playerkey = player player_key();
        
        if ( options.var_c730a865d18af814[ playerkey ] || isautopilot( player ) || isbot( player ) )
        {
            var_7b65f8b92373d30a++;
        }
    }
    
    foreach ( squadplayer in options.squad.players )
    {
        if ( !isplayer( squadplayer ) )
        {
            continue;
        }
        
        squadplayer setclientomnvar( "ui_coop_activity_squad_ready_count", var_7b65f8b92373d30a );
    }
    
    if ( getdvarint( @"hash_85d1dfb1364cfef4", 0 ) )
    {
        var_7b65f8b92373d30a = 0;
    }
    
    if ( var_7b65f8b92373d30a >= options.squad.players.size || options.forcecomplete || options.noregroup )
    {
        foreach ( player in options.squad.players )
        {
            player squad_notification::close( "squad_notification" );
            player.var_de884b95ddb0f44 = undefined;
            player.var_d95b1a0515b61111 = undefined;
            player.var_aecda9778743c358 = undefined;
            player setclientomnvar( "ui_coop_activity_squad_ready_count", 0 );
        }
        
        function_3e380f3e105e720e( options, 1 );
        options.squad utility::ent_flag_set( "COOP_SQUAD_REGROUP_COMPLETE" );
    }
}

// Namespace coop
// Params 4
// Checksum 0xccc27f2f, Offset: 0x5d43
// Size: 0x560
function function_89d9f28c0ea96fe7( options, displaypriority, starttime, endtime = 0 )
{
    self notify( #"hash_108ae6f4ec70ac38" );
    self endon( #"hash_108ae6f4ec70ac38" );
    assert( isstruct( self ) );
    assert( self != level );
    assert( isarray( self.players ) );
    squad = self;
    squad endon( #"COOP_SQUAD_REGROUP_COMPLETE" );
    
    switch ( displaypriority )
    {
        case 2:
            scriptedwidget = level.gametypebundle.var_2fb304cdde78a01d;
            var_f354cdc3b111873c = 1;
            default_str = &"coop_game_play/squad_notification_syncing";
            var_88a024ac4a605522 = options.var_560eecb53e318cbf ? 0 : 1;
            break;
        case 1:
            scriptedwidget = "scripted_widget_squad_notification_mp_sat_ob_low";
            var_f354cdc3b111873c = 0;
            default_str = &"coop_game_play/squad_notification_objective_engaged_regroup";
            var_c08d5d798de8a94d = &"coop_game_play/squad_notification_objective_engaged_waiting";
            var_88a024ac4a605522 = 0;
            break;
        case 0:
        default:
            scriptedwidget = undefined;
            var_f354cdc3b111873c = 0;
            var_88a024ac4a605522 = 0;
            break;
    }
    
    var_29474af0cf462b9f = starttime - endtime;
    endtimems = gettime() + var_29474af0cf462b9f * 1000;
    
    while ( gettime() < endtimems )
    {
        foreach ( player in squad.players )
        {
            playerkey = player player_key();
            
            if ( !( player isconnected() && player.sessionstate == "playing" ) )
            {
                options.var_c730a865d18af814[ playerkey ] = 1;
                continue;
            }
            
            if ( player::isinlaststand( player ) )
            {
                var_6a008b9c5948dbbc = int( max( player.var_eb94252c823f3478 ?? 0, player.laststandstarttime ?? 0 ) );
                var_1e0253700c4383d3 = gettime() - var_6a008b9c5948dbbc > 1500;
                options.var_c730a865d18af814[ playerkey ] = var_1e0253700c4383d3 ? 1 : undefined;
            }
        }
        
        function_b1fefba5894618ff( options );
        
        foreach ( player in squad.players )
        {
            assert( isplayer( player ) );
            
            if ( !( player isconnected() && player.sessionstate == "playing" ) )
            {
                continue;
            }
            
            playerkey = player player_key();
            
            if ( isdefined( scriptedwidget ) )
            {
                if ( player.var_de884b95ddb0f44 != scriptedwidget )
                {
                    if ( isdefined( player.var_de884b95ddb0f44 ) )
                    {
                        player squad_notification::close( "squad_notification" );
                    }
                    
                    player thread squad_notification::create( "squad_notification", scriptedwidget, var_f354cdc3b111873c ? starttime + 1 : 0, undefined, default_str );
                    player.var_de884b95ddb0f44 = scriptedwidget;
                }
                else if ( isdefined( var_c08d5d798de8a94d ) && player scripted_widgets::is_active( "squad_notification" ) )
                {
                    if ( options.var_c730a865d18af814[ playerkey ] )
                    {
                        player thread squad_notification::update_message( "squad_notification", var_c08d5d798de8a94d );
                    }
                    else if ( options.var_2b79828dcc50cbcc )
                    {
                        player thread squad_notification::update_message( "squad_notification", default_str );
                    }
                }
            }
            
            if ( var_88a024ac4a605522 && !player.var_d95b1a0515b61111 )
            {
                player utility::letterbox_enable( 1, starttime );
                player.var_d95b1a0515b61111 = 1;
            }
            else if ( !var_88a024ac4a605522 && player.var_d95b1a0515b61111 )
            {
                player utility::letterbox_enable( 0, gettime() );
                player.var_d95b1a0515b61111 = undefined;
            }
            
            if ( options.teleporthere && displaypriority == 2 && options.obj_circle )
            {
                shouldstream = distancesquared( player.origin, options.obj_circle.origin ) > 1000000;
                
                if ( shouldstream && !player.var_752047c2c0651b50 )
                {
                    player setadditionalstreamposuntilcleared( options.obj_circle.origin );
                    player.var_752047c2c0651b50 = 1;
                }
                else if ( !shouldstream && player.var_752047c2c0651b50 )
                {
                    player.var_752047c2c0651b50 = undefined;
                    player clearadditionalstreampos();
                }
            }
            
            if ( isdefined( options.obj_id ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( options.obj_id, player );
            }
        }
        
        waitframe();
    }
}

// Namespace coop
// Params 3, eflags: 0x4
// Checksum 0x1b481997, Offset: 0x62ab
// Size: 0x2ef
function private squad_stream_mates( var_58bb242dbcd8b7e1, dist, specificplayers )
{
    assert( isstruct( self ) );
    assert( self != level );
    assert( isarray( self.players ) );
    endonkey = "squad_stream_mates_" + ( var_58bb242dbcd8b7e1 ?? "LOAD" );
    
    if ( specificplayers && specificplayers.size > 0 )
    {
        endonkey = endonkey + "_" + specificplayers[ 0 ].guid;
    }
    
    squad = self;
    squad notify( endonkey );
    squad endon( endonkey );
    
    if ( !getdvarint( @"hash_f9e79bfa26284f02", 0 ) )
    {
        return;
    }
    
    if ( dist >= 0 )
    {
        squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "squad_stream_mates starting..." );
        
        while ( true )
        {
            foreach ( player in squad.players )
            {
                if ( isdefined( specificplayers ) && !arraycontains( specificplayers, player ) )
                {
                    continue;
                }
                
                foreach ( otherplayer in squad.players )
                {
                    if ( player == otherplayer )
                    {
                        continue;
                    }
                    
                    player prestreamasset( "entity", otherplayer, dist );
                }
            }
            
            waitframe();
        }
    }
    
    foreach ( player in squad.players )
    {
        if ( isdefined( specificplayers ) && !arraycontains( specificplayers, player ) )
        {
            continue;
        }
        
        foreach ( otherplayer in squad.players )
        {
            if ( player == otherplayer )
            {
                continue;
            }
            
            player prestreamasset( "entity", otherplayer, dist );
        }
    }
    
    squad playerlogic::bink_complete_log( var_58bb242dbcd8b7e1, "squad_stream_mates finished." );
}

/#

    // Namespace coop
    // Params 0
    // Checksum 0x18e80711, Offset: 0x65a2
    // Size: 0x5, Type: dev
    function function_5f7caa8f260a1c22()
    {
        
    }

#/

// Namespace coop
// Params 0, eflags: 0x4
// Checksum 0xc6dbefb0, Offset: 0x65af
// Size: 0x18
function private player_key()
{
    assert( isplayer( self ) );
    return self.guid;
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x1bbd87a6, Offset: 0x65d0
// Size: 0x19
function private function_98c7be7c1655efc4( params )
{
    self.var_eb94252c823f3478 = gettime();
}

// Namespace coop
// Params 0
// Checksum 0x6a590f6, Offset: 0x65f1
// Size: 0x7a
function function_eb6e09941acb48e9()
{
    assert( isplayer( self ) );
    player = self;
    
    if ( player isconnected() && player.sessionstate == "playing" )
    {
        player killstreak_utility::function_2f40c2fdba00ff2b();
        player canceloffhands();
        player releaseoffhand();
        player stopgestureviewmodel();
        
        if ( player isviewmodelanimplaying() )
        {
            player stopviewmodelanim();
        }
        
        player thread callback::callback( #"super_cancel" );
    }
}

// Namespace coop
// Params 1
// Checksum 0xb2a8fd1b, Offset: 0x6673
// Size: 0x1d
function function_cc279baa40340449( params )
{
    self.var_da890394bac5ecb9 = gettime() + 30000;
}

// Namespace coop
// Params 3
// Checksum 0xfcb5d6a2, Offset: 0x6698
// Size: 0x1b6
function player_fade_with_shader( fadeout, time, shader = "black" )
{
    /#
        var_6b1d4f126d9b18b9 = getdvarint( @"hash_6e9c46287d470d9b", 0 );
        var_e08d163654bd3390 = getdvarint( @"hash_83fc05b450670092", 1 );
        
        if ( var_6b1d4f126d9b18b9 && !var_e08d163654bd3390 )
        {
            fadeout = 0;
            time = 0;
        }
    #/
    
    if ( self.player_fade_with_shader && shader != self.player_fade_with_shader )
    {
        if ( self.player_fade_with_shader == "black" )
        {
            utility::fadetoblackforplayerkeepui( self, 0, 0, undefined, "player_fade_with_shader" );
            val::reset_all( "player_fade_with_shader" );
        }
        else
        {
            hud_util::fade_in( 0, self.player_fade_with_shader == "total_black" ? "black" : self.player_fade_with_shader );
        }
    }
    
    if ( fadeout )
    {
        self.player_fade_with_shader = shader;
        
        if ( shader == "black" )
        {
            utility::fadetoblackforplayerkeepui( self, 1, time, undefined, "player_fade_with_shader" );
            val::set( "player_fade_with_shader", "show_hud", 0 );
        }
        else
        {
            hud_util::fade_out( time, shader == "total_black" ? "black" : shader );
        }
        
        return;
    }
    
    if ( shader == "black" )
    {
        utility::fadetoblackforplayerkeepui( self, 0, time, undefined, "player_fade_with_shader" );
        utility::delaythread( time + level.framedurationseconds, &val::reset, "player_fade_with_shader", "show_hud" );
    }
    else
    {
        hud_util::fade_in( time, shader == "total_black" ? "black" : shader );
    }
    
    self.player_fade_with_shader = undefined;
}

// Namespace coop
// Params 2
// Checksum 0xef765bcc, Offset: 0x6856
// Size: 0x145
function achievement_simple( var_b321eb6cdb8168ba, includesquad = 1 )
{
    assert( isstring( var_b321eb6cdb8168ba ) );
    playerlist = level.players;
    
    if ( isarray( self.players ) )
    {
        playerlist = self.players;
    }
    else if ( isplayer( self ) )
    {
        playerlist = [ self ];
        
        if ( includesquad )
        {
            squad = teams::function_72b89edf6b47c40a( self );
            
            if ( isarray( squad.players ) )
            {
                playerlist = squad.players;
            }
        }
    }
    
    foreach ( player in playerlist )
    {
        level callback::callback( #"hash_6c71d319dc089c27", { #var_b321eb6cdb8168ba:var_b321eb6cdb8168ba, #player:player, #event:#"achievement_simple" } );
    }
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x57cf287f, Offset: 0x69a3
// Size: 0x63
function private function_56e7612ea9a99c63( xuidstring )
{
    netlost = 0;
    
    if ( ( level.gametypebundle.var_272df6d1a6e8a6eb ?? 0 ) > 0 )
    {
        var_92ae61e7baa5022c = function_ba559a90ebdd3a2( xuidstring );
        netlost = var_92ae61e7baa5022c > level.gametypebundle.var_272df6d1a6e8a6eb * 1000;
    }
    
    return netlost;
}

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x36349c2c, Offset: 0x6a0f
// Size: 0x3a, Type: bool
function private function_64817edb5faeca93( soundevent )
{
    if ( level.gametypebundle.var_46b7ca041d39ad29 )
    {
        overlordactive = overlord::function_3802335534c6ffd3();
        return !overlordactive;
    }
    
    return true;
}

/#

    // Namespace coop
    // Params 0
    // Checksum 0x3276f5a3, Offset: 0x6a52
    // Size: 0x5, Type: dev
    function function_eb2a926c201ed7b1()
    {
        
    }

#/

// Namespace coop
// Params 1, eflags: 0x4
// Checksum 0x87b02dbe, Offset: 0x6a5f
// Size: 0x1e4
function private function_37904b06ac0bfaf1( params )
{
    assert( isplayer( self ) );
    assert( isdefined( params.squad ) );
    player = self;
    squad = params.squad;
    
    if ( squad.var_2c44544a01cc415e )
    {
        level thread game_utility::fadetoblackforplayer( player, 0, 0 );
    }
    
    playermsg = " player " + player getentitynumber() + ":" + ( player.name ?? "<unknown>" );
    squad playerlogic::bink_complete_log( undefined, "Joined Squad -" + playermsg );
    
    if ( player utility::ent_flag( "squad_play_begin" ) )
    {
        return;
    }
    
    /#
        player thread function_1df25f9a519a07f5();
    #/
    
    if ( isdefined( level.gametypebundle.var_b2753c83057ab87a ) )
    {
        if ( player.var_b2753c83057ab87a )
        {
            return;
        }
        
        player.var_b2753c83057ab87a = 1;
        alreadyready = player_ready_check( squad, 0 );
        squad thread function_e06b3278f97c59c7();
        
        if ( !squad utility::ent_flag( "bink_complete" ) )
        {
            return;
        }
        
        if ( alreadyready )
        {
            squad playerlogic::bink_complete_log( undefined, "coop::on_player_connect() trigger isolated squad movie wait for" + playermsg );
            squad thread squad_movie_wait( undefined, { #specificplayers:[ player ] } );
            
            if ( ob::nightmare() )
            {
                player thread function_73377144b1490274( "bink_complete" );
            }
        }
        
        return;
    }
    
    level utility::flag_set( "bink_complete" );
    level utility::flag_set( "squad_play_begin" );
    squad utility::ent_flag_set( "bink_complete" );
    squad utility::ent_flag_set( "squad_play_begin" );
    player utility::ent_flag_set( "bink_complete" );
    player utility::ent_flag_set( "squad_play_begin" );
    player setclientomnvar( "ui_player_movie_state", -1 );
    player setclientomnvar( "ui_player_load_state", -1 );
}

// Namespace coop
// Params 1, eflags: 0xc
// Checksum 0xf83cfb26, Offset: 0x6c4b
// Size: 0xd8
function private function_73377144b1490274( entflag )
{
    self notify( #"hash_a08f4f2402aba5fc" );
    self endon( #"hash_a08f4f2402aba5fc" );
    assert( isplayer( self ) );
    player = self;
    player endon( #"disconnect" );
    var_1bff7d9d2e7125e5 = "invuln_until_a";
    var_8e5fd65ed35c145b = "invuln_until_b";
    level.var_ddd4489f3a9d5b8f = 1;
    player val::set( var_1bff7d9d2e7125e5, "damage", 0 );
    player val::set( var_1bff7d9d2e7125e5, "ignoreme", 1 );
    player val::set( var_8e5fd65ed35c145b, "freezecontrols", 1 );
    player val::set( var_8e5fd65ed35c145b, "freezecontrols_allowlook", 1 );
    player utility::ent_flag_wait( entflag );
    player val::reset_all( var_8e5fd65ed35c145b );
    wait 3;
    player val::reset_all( var_1bff7d9d2e7125e5 );
}

/#

    // Namespace coop
    // Params 0, eflags: 0xc
    // Checksum 0x6619496b, Offset: 0x6d2b
    // Size: 0x12f, Type: dev
    function private function_1df25f9a519a07f5()
    {
        self notify( #"hash_b6104ffad5205fb8" );
        self endon( #"hash_b6104ffad5205fb8" );
        assert( isplayer( self ) );
        player = self;
        player endon( #"disconnect" );
        hudelem = newclienthudelem( player );
        hudelem.alignx = "<dev string:x177>";
        hudelem.aligny = "<dev string:x17e>";
        hudelem.x = 320;
        hudelem.y = 300;
        hudelem.foreground = 1;
        hudelem.color = ( 1, 0.5, 0.5 );
        hudelem.fontscale = 2;
        lastvalue = 1;
        
        while ( true )
        {
            var_ecf1b0bfe3103b57 = !getdvarint( @"hash_cb9489aecc9a5cc1", 0 ) || player function_64817edb5faeca93();
            
            if ( var_ecf1b0bfe3103b57 != lastvalue )
            {
                hudelem setdevtext( var_ecf1b0bfe3103b57 ? "<dev string:x185>" : "<dev string:x186>" );
            }
            
            lastvalue = var_ecf1b0bfe3103b57;
            wait 0.25;
        }
    }

#/
