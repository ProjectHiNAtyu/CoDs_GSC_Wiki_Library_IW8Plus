// scripts\mp\ob\ob_infils.gsc  (hash_35b4377a4acf9201.gscc) (size: 20037 Bytes / 0x4e45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2d1e1b1 (4073841073)
// size ...... 20037 (0x4e45)
// includes .. 15  (offset: 0x47b1)
// strings ... 74  (offset: 0x4829)
// dev strs .. 34  (offset: 0x4c41)
// exports ... 27  (offset: 0x31a1)
// cseg ...... 0x68b + 0x2b16 (0x31a1)
// imports ... 141 (offset: 0x35d9)
// animtree1 . 1   (offset: 0x4e39)
// animtree2 . 0   (offset: 0x4e45)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\overlord;
#using scripts\mp\spawnlogic;

#namespace ob_infils;

// Namespace ob_infils
// Params 0
// Checksum 0xea615d43, Offset: 0x6a9
// Size: 0x37d
function obinfil_init()
{
    /#
        level thread function_370d08c2c8f12766();
    #/
    
    setomnvar( "ui_mp_extended_load_screen", 1 );
    mapname = game_utility::getmapname();
    
    if ( mapname == "mp_jup_bigmap" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_jup_blima_tr";
    }
    else if ( mapname == "mp_sat_ob_core_features" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_sat_blima_tr";
    }
    else if ( mapname == "mp_sat_avalon_quad_01_ob" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_sat_avalon_quad_01_blima_tr";
    }
    else if ( mapname == "mp_sat_avalon_quad_02_ob" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_sat_avalon_quad_02_blima_tr";
    }
    else if ( mapname == "mp_sat_avalon_quad_03_ob" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_sat_avalon_quad_03_blima_tr";
    }
    else if ( mapname == "mp_sat_avalon_quad_04_ob" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_sat_avalon_quad_04_blima_tr";
    }
    else if ( mapname == "mp_sat_lm_avalon_ob" )
    {
        level.var_ea11dd76b3db7f9 = "mp_infil_ob_sat_avalon_blima_tr";
    }
    else
    {
        setdvar( @"hash_2fe0283b419ff08a", 1 );
    }
    
    level.obinfil_bonustime = level.var_bb86f77304f193c4.infilbonustime ?? 0;
    
    if ( getdvarint( @"hash_2fe0283b419ff08a", 0 ) == 1 || !function_cb3f113c9a5d56f7( level.var_ea11dd76b3db7f9 ) )
    {
        level.prematchperiodend = level.obinfil_bonustime;
        level thread function_ff30624deecf5c49();
        return;
    }
    
    callback::add( #"player_connect", &function_1c077eb1ecd1777e );
    scene::add_scene_func( "jup_cin_zm_infil", &function_e4afceb05fa614bf, "callback_play" );
    scene::add_scene_func( "jup_cin_zm_infil", &function_fbca43e8e9945461, "callback_done" );
    level.var_493c0f5a977f1638 = getdvarint( @"hash_5cc93a1ff8e7a881", 1 );
    level.var_db6fbecd827736f0 = getdvarint( @"hash_d6c6f27e2890ab87", 3 );
    level.var_9a444bb9ea0a9130 = getdvarfloat( @"hash_39ea6191970eb227", 30 );
    level.var_e3f4fd0372087287 = getdvarint( @"hash_4a2b6a2a09fd036", 0 );
    level.var_cab646388fad4998 = getdvarfloat( @"hash_d0703186b655c867", 5 );
    level.var_60b97092c45e32fa = getdvarint( @"hash_81a3a2e9c63e736d", 0 );
    level.var_59009ffcf4d3874c = [];
    level.var_8afd2d97bc4003e4 = 1;
    level.var_65957518390e3d2a = &function_1850a9749b8a371a;
    
    foreach ( team in level.teamnamelist )
    {
        level.requiredplayercount[ team ] = 0;
    }
    
    level.prematchperiod = getdvarint( @"scr_game_graceperiod", 60 );
    infilduration = 15.0333;
    level.matchcountdowntime = infilduration + level.obinfil_bonustime + getdvarint( @"hash_7061556e5a6fcbc7", 15 );
    level.prematchperiodend = infilduration + level.obinfil_bonustime + getdvarint( @"hash_7061556e5a6fcbc7", 15 );
    thread gamelogic_mp::matchstarttimer( "match_starting_in", level.prematchperiod + level.prematchperiodend );
    audio_utility::snd_transient_load( "blima_infil" );
    level.var_c57ff57d8b66d391 = 1;
    level thread function_ec67c977529042be();
}

// Namespace ob_infils
// Params 0
// Checksum 0xff5e141, Offset: 0xa2e
// Size: 0x21d
function function_ff30624deecf5c49()
{
    level utility::waittill_any( "match_start_real_countdown", "match_start_timer_skip" );
    level thread function_36d9ccd59d06c104();
    
    foreach ( teamname, squadarray in level.squaddata )
    {
        foreach ( squad in squadarray )
        {
            if ( squad.players.size > 0 )
            {
                if ( isdefined( squad.players[ 0 ].starting_squad_spawn ) )
                {
                    spawnpoint = squad.players[ 0 ].starting_squad_spawn;
                }
                else if ( isdefined( level.var_3aa9646314b3783c ) )
                {
                    spawnpoint = squad.players[ 0 ] [[ level.var_3aa9646314b3783c ]]();
                }
                else
                {
                    spawnpoint = level.teamdata[ teamname ][ "startPoint" ];
                }
                
                level thread function_eb3f0e1760928e5f( spawnpoint, teamname );
                
                foreach ( player in squad.players )
                {
                    if ( !isdefined( player ) )
                    {
                        continue;
                    }
                    
                    player val::reset_all( "ob_infil" );
                    player playershow( 1 );
                }
            }
        }
    }
}

// Namespace ob_infils
// Params 1
// Checksum 0x4cc7fd8e, Offset: 0xc53
// Size: 0xa0
function function_1c077eb1ecd1777e( params )
{
    if ( !level utility::flag( "ob_infil_completed" ) )
    {
        self endon( #"disconnect" );
        self.b_hide_ui_match_start_countdown = 1;
        val::set( "ob_infil", "show_hud", 0 );
        val::set( "ob_infil", "freezecontrols", 1 );
        game_utility::fadetoblackforplayerkeepui( self, 1, 0 );
        level utility::flag_wait( "ob_infil_completed" );
        wait 1;
        
        if ( isdefined( self ) )
        {
            self.b_hide_ui_match_start_countdown = undefined;
            val::reset_all( "ob_infil" );
            self playershow( 1 );
            game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
        }
    }
}

// Namespace ob_infils
// Params 2
// Checksum 0x6e3077aa, Offset: 0xcfb
// Size: 0x49
function function_c723d839a132fba( var_8c30ce1c9d24c62e, playerstring )
{
    assert( isdefined( var_8c30ce1c9d24c62e ) );
    level endon( #"prematch_done" );
    level endon( #"prematch_over" );
    
    if ( isdefined( playerstring ) )
    {
        self endon( playerstring );
    }
    
    self waittill( var_8c30ce1c9d24c62e );
}

// Namespace ob_infils
// Params 0
// Checksum 0xee91468a, Offset: 0xd4c
// Size: 0x2b8
function function_1850a9749b8a371a()
{
    if ( !isdefined( level.var_eb1a708a1a7033d ) )
    {
        level.var_eb1a708a1a7033d = gettime();
    }
    
    /#
        if ( !isdefined( level.var_b7a5a82134d03454 ) )
        {
            level.var_2f18482440d39478 = gettime();
        }
        else
        {
            level.var_d2fbde5bc2efbcc9 = gettime();
        }
    #/
    
    streamcomplete = 0;
    lobbysize = function_e2939bfa2e5a9527();
    
    if ( level.players.size < lobbysize )
    {
        level.var_eb1a708a1a7033d = gettime();
        return 0;
    }
    
    n_max_wait_time = level.var_eb1a708a1a7033d + utility::function_4b74c15943231980( level.var_9a444bb9ea0a9130 );
    
    if ( gettime() > n_max_wait_time )
    {
        return 1;
    }
    
    if ( gettime() - level.var_eb1a708a1a7033d < utility::function_4b74c15943231980( level.var_cab646388fad4998 ) )
    {
        return 0;
    }
    
    if ( level.players.size > 0 )
    {
        streamcomplete = 1;
        
        foreach ( team in level.teamnamelist )
        {
            players = teams::getteamdata( team, "players" );
            
            foreach ( player in players )
            {
                if ( !player.pers[ "streamSyncComplete" ] || player.model == "" || !player ispredictedstreamposready() || !player isadditionalstreamposready() )
                {
                    /#
                        if ( !player.pers[ "<dev string:x24>" ] )
                        {
                            if ( !isdefined( player.var_2026ac71f6bc1c54 ) )
                            {
                                player.var_2026ac71f6bc1c54 = gettime();
                            }
                            else
                            {
                                player.var_27e229d293709d8d = gettime();
                            }
                        }
                        
                        if ( player.model == "<dev string:x37>" )
                        {
                            if ( !isdefined( player.var_dcb5b1ad013e10a6 ) )
                            {
                                player.var_dcb5b1ad013e10a6 = gettime();
                            }
                            else
                            {
                                player.var_f316f2fcfd40ea63 = gettime();
                            }
                        }
                    #/
                    
                    streamcomplete = 0;
                    break;
                }
            }
            
            if ( !streamcomplete )
            {
                break;
            }
        }
    }
    
    return streamcomplete;
}

// Namespace ob_infils
// Params 0
// Checksum 0xd8098ffd, Offset: 0x100d
// Size: 0x17d
function function_ec67c977529042be()
{
    flags::gameflagset( "infil_will_run" );
    level utility::waittill_any( "match_start_real_countdown", "match_start_timer_skip" );
    level thread function_36d9ccd59d06c104();
    
    /#
        if ( isdefined( level.var_b7a5a82134d03454 ) )
        {
            println( "<dev string:x38>" + level.var_b7a5a82134d03454 );
        }
        
        if ( isdefined( level.var_d2fbde5bc2efbcc9 ) )
        {
            println( "<dev string:x65>" + level.var_d2fbde5bc2efbcc9 );
        }
    #/
    
    if ( !getdvarint( @"hash_ef6cb2cc556223b", 0 ) )
    {
        foreach ( teamname, squadarray in level.squaddata )
        {
            foreach ( squad in squadarray )
            {
                if ( squad.players.size > 0 )
                {
                    level thread function_2c026628e2e1a109( teamname, squad.index );
                    waitframe();
                }
            }
        }
    }
}

// Namespace ob_infils
// Params 0
// Checksum 0xca6ae1f1, Offset: 0x1192
// Size: 0x1e7
function function_36d9ccd59d06c104()
{
    setomnvar( "ui_mp_extended_load_screen", 0 );
    
    if ( getdvarint( @"hash_2fe0283b419ff08a", 0 ) )
    {
        setomnvar( "ui_in_infil", -1 );
    }
    else if ( getdvarint( @"hash_ef6cb2cc556223b", 0 ) )
    {
        foreach ( player in level.players )
        {
            player val::set( "ob_infil_no_igc", "show_hud", 0 );
            player val::set( "ob_infil_no_igc", "freezecontrols", 1 );
        }
        
        wait 3;
        setomnvar( "ui_in_infil", 1 );
    }
    else
    {
        setomnvar( "ui_in_infil", 1 );
        level utility::flag_wait_or_timeout( "ob_infil_igc_start", level.prematchperiod );
        setomnvar( "ui_in_infil", 2 );
    }
    
    level notify( #"hash_f5b0b2f086d63ac6" );
    flags::gameflagwait( "prematch_done" );
    setomnvar( "ui_in_infil", -1 );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "ob_infil_no_igc" );
    }
    
    level.infilcompleted = 1;
    level utility::flag_set( "ob_infil_completed" );
    level utility::delaythread( 50, &audio_utility::snd_transient_unload, "blima_infil" );
    callback::callback( "on_ob_infil_complete" );
}

#using_animtree( "script_model" );

// Namespace ob_infils
// Params 3
// Checksum 0xee0776d9, Offset: 0x1381
// Size: 0x84
function obinfil_spawncamera( pos, angles, var_25f925f48ee1e217 )
{
    var_a86a5dbc6ba054c8 = var_25f925f48ee1e217 ?? 0;
    cameraent = spawn( "script_model", pos );
    
    if ( isdefined( angles ) )
    {
        cameraent.angles = angles;
    }
    
    cameraent setmodel( "tag_origin" );
    cameraent.animname = "ob_infil_cam" + var_a86a5dbc6ba054c8;
    cameraent useanimtree( #animtree );
    return cameraent;
}

// Namespace ob_infils
// Params 2
// Checksum 0x5abdf783, Offset: 0x140e
// Size: 0x68
function function_eb3f0e1760928e5f( spawnpoint, teamname )
{
    if ( isvector( spawnpoint.origin ) )
    {
        utility::flag_wait( "ai_spawn_director_initialized" );
        var_1ad2ee9e5a2b12fb = teamname + "_Infil";
        function_1c4c7ef874191be2( var_1ad2ee9e5a2b12fb, spawnpoint.origin, 2000, 1 );
        function_71799ce2c69ce5a9( var_1ad2ee9e5a2b12fb, 300 );
    }
}

// Namespace ob_infils
// Params 4
// Checksum 0x26dd7740, Offset: 0x147e
// Size: 0x5ff
function function_2c026628e2e1a109( teamname, squadid, overridespawnpoint, overridewaittime )
{
    if ( !( isdefined( teamname ) && isdefined( squadid ) && isdefined( level.squaddata[ teamname ][ squadid ] ) ) )
    {
        return;
    }
    
    players = level.squaddata[ teamname ][ squadid ].players;
    
    if ( isdefined( overridespawnpoint ) )
    {
        spawnpoint = overridespawnpoint;
    }
    else if ( isdefined( level.var_3aa9646314b3783c ) )
    {
        a_squad_spawns = [];
        
        foreach ( player in players )
        {
            if ( isdefined( player.starting_squad_spawn ) )
            {
                squad_spawn = player.starting_squad_spawn;
            }
            else
            {
                squad_spawn = player [[ level.var_3aa9646314b3783c ]]();
            }
            
            a_squad_spawns[ a_squad_spawns.size ] = squad_spawn;
        }
        
        highest_squad_spawn = a_squad_spawns[ 0 ];
        
        foreach ( squad_spawn in a_squad_spawns )
        {
            if ( squad_spawn.origin[ 2 ] > highest_squad_spawn.origin[ 2 ] )
            {
                highest_squad_spawn = squad_spawn;
            }
        }
        
        spawnpoint = highest_squad_spawn;
    }
    else
    {
        spawnpoint = level.teamdata[ teamname ][ "startPoint" ];
    }
    
    level thread function_eb3f0e1760928e5f( spawnpoint, teamname );
    players = function_5713d46873b29625( players );
    
    /#
        foreach ( player in players )
        {
            if ( isdefined( player.var_dcb5b1ad013e10a6 ) )
            {
                println( "<dev string:x90>" + player.name + "<dev string:x98>" + player.var_dcb5b1ad013e10a6 );
            }
            
            if ( isdefined( player.var_f316f2fcfd40ea63 ) )
            {
                println( "<dev string:x90>" + player.name + "<dev string:xb1>" + player.var_f316f2fcfd40ea63 );
            }
            
            if ( isdefined( player.var_2026ac71f6bc1c54 ) )
            {
                println( "<dev string:x90>" + player.name + "<dev string:xc8>" + player.var_2026ac71f6bc1c54 );
            }
            
            if ( isdefined( player.var_27e229d293709d8d ) )
            {
                println( "<dev string:x90>" + player.name + "<dev string:xe2>" + player.var_27e229d293709d8d );
            }
            
            println( "<dev string:x90>" + player.name + "<dev string:xfa>" + gettime() );
        }
    #/
    
    if ( getdvarint( @"hash_7b68b0ae5369bbe4", 0 ) == 1 )
    {
        players = arrayrandomize( players );
    }
    
    assert( players.size <= 4, "<dev string:x10b>" );
    assert( players.size > 0, "<dev string:x146>" );
    
    if ( !players.size )
    {
        return;
    }
    
    waittime = getdvarint( @"hash_7061556e5a6fcbc7", 15 );
    waittime = overridewaittime ?? waittime;
    
    if ( getdvarint( @"hash_20aac00f832266c", 1 ) )
    {
        spawnpoint scene::pre_stream( players, undefined, waittime + 2, "jup_cin_zm_infil" );
    }
    else
    {
        spawnpoint scene::init( players, undefined, "jup_cin_zm_infil" );
    }
    
    sceneentities = spawnpoint scene::get_entities();
    
    foreach ( entity in sceneentities )
    {
        if ( isent( entity ) && !isplayer( entity ) )
        {
            entity hide();
        }
    }
    
    foreach ( player in players )
    {
        player thread function_5f4425c42c7f2264( waittime );
        player val::set( "ob_infil", "show_hud", 0 );
        player val::set( "ob_infil", "freezecontrols", 1 );
        var_e00f1d1efd565e9e = level.prematchperiodend - 20;
        
        if ( var_e00f1d1efd565e9e < 0 )
        {
            var_e00f1d1efd565e9e = 1;
        }
        
        foreach ( entity in sceneentities )
        {
            if ( isent( entity ) && !isplayer( entity ) )
            {
                entity showtoplayer( player );
            }
        }
    }
    
    wait waittime;
    level utility::flag_set( "ob_infil_igc_start" );
    flags::gameflagset( "infil_started" );
    callback::callback( "on_ob_infil_start_music" );
    players = function_5713d46873b29625( players );
    function_9f225d537dd27cfa( players, spawnpoint, "jup_cin_zm_infil" );
}

// Namespace ob_infils
// Params 3
// Checksum 0xe28e7a90, Offset: 0x1a85
// Size: 0x326
function function_9f225d537dd27cfa( players, spawnpoint, scenename )
{
    foreach ( player in players )
    {
        player notify( #"hash_ba17b2d8aee8e7fb" );
        player cameraunlink();
        player thread function_22b6419b99bb387();
        player clearsoundsubmix( "jup_ob_prematch", 1 );
        player setsoundsubmix( "jup_ob_infil" );
        player setsoundsubmix( "jup_ob_infil_secondary" );
        player.b_hide_ui_match_start_countdown = undefined;
        player utility::delaythread( 1, &val::reset, "ob_infil", "show_hud" );
        player lerpfovscalefactor( 0, 0 );
        println( "<dev string:x172>" + player.name + "<dev string:x184>" + gettime() );
        logstring( "OB INFIL: Player " + player.name + " starting infil! at time " + gettime() );
    }
    
    n_wait = getdvarfloat( @"hash_45ce1e830caba62a", 0 );
    wait n_wait;
    players = function_5713d46873b29625( players );
    
    if ( players.size )
    {
        spawnpoint scene::play( players, undefined, scenename );
    }
    else
    {
        println( "<dev string:x19e>" + ( spawnpoint.script_noteworthy ?? "<dev string:x37>" ) + "<dev string:x1e0>" + spawnpoint.origin );
        logstring( "OB INFIL No players in squad for infil scene at spawnPoint group " + ( spawnpoint.script_noteworthy ?? "" ) + " at location " + spawnpoint.origin );
        wait 15.0333;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player player::_freezelookcontrols( 0, 1 );
        player val::reset_all( "ob_infil" );
        player playershow( 1 );
        player lerpfovbypreset( "default" );
        player cameraunlink();
        player notify( #"hash_e5e3bd276d973376" );
        player lerpfovscalefactor( 1, 1 );
        logstring( "OB INFIL: Player " + player.name + " status of participating in cinematics after infil: [" + player function_e7d19d7e4403c48() + "] at time " + gettime() );
        assert( !player function_e7d19d7e4403c48(), "<dev string:x1ee>" );
        player thread function_29c847ef71838f4b();
        println( "<dev string:x172>" + player.name + "<dev string:x248>" + gettime() );
        logstring( "OB INFIL: Player " + player.name + " done with infil at time " + gettime() );
    }
}

// Namespace ob_infils
// Params 0
// Checksum 0x49ba9be3, Offset: 0x1db3
// Size: 0x14d
function function_29c847ef71838f4b()
{
    self endon( #"disconnect" );
    
    if ( !self isonground() || self isskydiving() )
    {
        v_ground = getgroundposition( self.origin, 32, 500, 1000 );
        
        if ( isdefined( v_ground ) )
        {
            self setorigin( v_ground );
            waitframe();
            
            if ( !self isonground() && isdefined( self.starting_squad_spawn ) )
            {
                self setorigin( self.starting_squad_spawn.origin );
                return;
            }
        }
    }
    
    if ( !ispointonnavmesh( self.origin ) )
    {
        var_5fb4fe43f49ba675 = getclosestpointonnavmesh( self.origin );
        
        if ( isdefined( var_5fb4fe43f49ba675 ) )
        {
            self setorigin( var_5fb4fe43f49ba675 );
            return;
        }
    }
    
    v_start_origin = self.origin;
    var_c1a14e755426a501 = 15;
    var_a9a5f546b4c9e8c0 = 0;
    
    while ( var_c1a14e755426a501 > 0 )
    {
        if ( distance( self.origin, v_start_origin ) > 5 )
        {
            var_a9a5f546b4c9e8c0 = 1;
            break;
        }
        
        wait 1;
        var_c1a14e755426a501 -= 1;
    }
    
    if ( !var_a9a5f546b4c9e8c0 )
    {
        self setorigin( self.origin + ( 0, 0, 32 ) );
    }
    
    val::reset_all( "scene_shot" );
    val::reset_all( "scene_scene" );
}

// Namespace ob_infils
// Params 0
// Checksum 0xd876bb80, Offset: 0x1f08
// Size: 0x4f
function function_22b6419b99bb387()
{
    self endon( #"disconnect" );
    self endon( #"hash_bc1f45fd4dd0dddc" );
    self.var_7efe9d6a267112b9 = self getplayerdata( "common", "mpProgression", "thirdPerson" );
    
    while ( true )
    {
        if ( self getcamerathirdperson() )
        {
            self setcamerathirdperson( 0 );
        }
        
        waitframe();
    }
}

// Namespace ob_infils
// Params 0, eflags: 0x4
// Checksum 0x9bd0aa1e, Offset: 0x1f5f
// Size: 0x22d
function private function_e4afceb05fa614bf()
{
    players = [];
    
    foreach ( s_object in self.scenedata.sceneobjectdata )
    {
        if ( isplayer( s_object.entity ) )
        {
            players[ players.size ] = s_object.entity;
            thread handle_weapon_raise( s_object.entity );
            continue;
        }
        
        if ( isdefined( s_object.entity ) && s_object.entity vehicle::is_vehicle() )
        {
            s_object.entity notify( #"hash_c7314d2e7ddc8591" );
        }
    }
    
    thread function_dc6d3311e2f10bdb( players );
    wait 0.5;
    var_eef62296093f5009 = [];
    
    if ( players.size == 2 )
    {
        var_eef62296093f5009 = [ "tablet3" ];
    }
    else if ( players.size == 1 )
    {
        var_eef62296093f5009 = [ "tablet2", "tablet3" ];
    }
    
    foreach ( s_object in self.scenedata.sceneobjectdata )
    {
        if ( isdefined( s_object.entity ) && isdefined( s_object.entity.animname ) && arraycontains( var_eef62296093f5009, s_object.entity.animname ) )
        {
            s_object.entity delete();
        }
    }
    
    if ( getdvarint( @"hash_8da4a5e690432cd0", 0 ) == 1 )
    {
        thread function_72fc82a89fedaa17( players );
    }
}

// Namespace ob_infils
// Params 1, eflags: 0x4
// Checksum 0xdc40dd3e, Offset: 0x2194
// Size: 0x199
function private handle_weapon_raise( player )
{
    player endon( #"disconnect" );
    player.scene_player_rig endon( #"death" );
    var_9a7e59ee60b89322 = player getcurrentweapon();
    
    if ( isnullweapon( var_9a7e59ee60b89322 ) )
    {
        foreach ( weapon in player.primaryweapons )
        {
            if ( !isnullweapon( weapon ) )
            {
                var_9a7e59ee60b89322 = weapon;
                break;
            }
        }
    }
    
    player takeweapon( var_9a7e59ee60b89322 );
    msg = player utility::waittill_any_timeout( 20, "ws_raise" );
    player.scene_player_rig hidefromplayer( player );
    player hidefromplayer( player );
    player setdemeanorviewmodel( "normal" );
    player val::reset( "scene_shot", "weapon" );
    player takeweapon( var_9a7e59ee60b89322 );
    player giveweapon( var_9a7e59ee60b89322 );
    player switchtoweaponimmediate( var_9a7e59ee60b89322 );
    player notify( #"hash_bc1f45fd4dd0dddc" );
    var_f6a9e7e9096b632 = istrue( player.var_7efe9d6a267112b9 );
    player setcamerathirdperson( var_f6a9e7e9096b632 );
    player setclientomnvar( "ui_toggle_third_person", var_f6a9e7e9096b632 );
    player setplayerdata( "common", "mpProgression", "thirdPerson", var_f6a9e7e9096b632 );
    player.var_7efe9d6a267112b9 = undefined;
}

// Namespace ob_infils
// Params 0, eflags: 0x4
// Checksum 0x819bc1fe, Offset: 0x2335
// Size: 0x11b
function private function_fbca43e8e9945461()
{
    players = [];
    helis = [];
    
    foreach ( s_object in self.scenedata.sceneobjectdata )
    {
        if ( isdefined( s_object.entity ) )
        {
            if ( isplayer( s_object.entity ) )
            {
                players[ players.size ] = s_object.entity;
                continue;
            }
            
            if ( s_object.sceneobject.variant_type === "Types_Vehicle" )
            {
                s_object.entity.var_ef1f396045fd1479 = &function_ea6810b140d70ffc;
                helis[ helis.size ] = s_object.entity;
            }
        }
    }
    
    level thread function_94bc7cb3bb0efe54( helis );
}

// Namespace ob_infils
// Params 1, eflags: 0x4
// Checksum 0xff3050c, Offset: 0x2458
// Size: 0x30
function private function_94bc7cb3bb0efe54( helis )
{
    while ( helis.size > 0 )
    {
        helis = function_46f9072493651dc9( helis );
        wait 1;
    }
    
    unloadinfiltransient( level.var_ea11dd76b3db7f9 );
}

// Namespace ob_infils
// Params 0
// Checksum 0xc2f5a9fd, Offset: 0x2490
// Size: 0xd8
function function_ea6810b140d70ffc()
{
    self notify( #"hash_c7314d2e7ddc8591" );
    self endon( #"hash_c7314d2e7ddc8591" );
    self endon( #"death" );
    println( "<dev string:x262>" );
    logstring( "OB INFIL: Helicopter done with scene!" );
    self function_d2b8ee2e1275daaf( 1 );
    n_speed = 75;
    var_e1d9153de85f91ab = 25000;
    v_facingdirection = anglestoforward( self.angles * ( 0, 1, 0 ) );
    v_end = self.origin + ( 0, 0, 2500 ) + v_facingdirection * var_e1d9153de85f91ab;
    self vehicle_setspeed( n_speed, 15 );
    self setvehgoalpos( v_end, 0 );
    thread function_d165934a3b5d133c();
    self waittill( #"goal" );
    self delete();
}

// Namespace ob_infils
// Params 0, eflags: 0x4
// Checksum 0x9a68a4f5, Offset: 0x2570
// Size: 0x100
function private function_d165934a3b5d133c()
{
    self endon( #"death" );
    wait 8;
    
    while ( true )
    {
        var_b39211a02e6399a9 = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                continue;
            }
            
            if ( !isbot( player ) && utility::within_fov( player.origin, player getplayerangles(), self.origin, 0.7 ) )
            {
                var_b39211a02e6399a9 = 1;
            }
            
            waitframe();
        }
        
        if ( !var_b39211a02e6399a9 )
        {
            self delete();
        }
        
        wait 0.5;
    }
}

// Namespace ob_infils
// Params 1
// Checksum 0x79ff73bf, Offset: 0x2678
// Size: 0xbf
function function_dc6d3311e2f10bdb( players )
{
    self notify( #"endon_obinfil_playinfilvo" );
    self endon( #"endon_obinfil_playinfilvo" );
    var_46e5b584d39ece6f = [ "fang", "greene", "ravenov", "soap" ];
    str_handler_override = getdvar( @"hash_a9078d5ae739b39a", "" );
    
    if ( arraycontains( var_46e5b584d39ece6f, str_handler_override ) )
    {
        var_982bf6b956622b02 = str_handler_override;
    }
    else
    {
        var_982bf6b956622b02 = utility::array_random( var_46e5b584d39ece6f );
    }
    
    var_40fbc79658a286a8 = "ob_infil_" + var_982bf6b956622b02;
    wait 5;
    players = function_5713d46873b29625( players );
    overlord::playevent( var_40fbc79658a286a8, players, undefined, undefined, 1 );
}

// Namespace ob_infils
// Params 1
// Checksum 0x445f87ef, Offset: 0x273f
// Size: 0x137
function function_72fc82a89fedaa17( players )
{
    wait getdvarint( @"hash_120410411ba2e0d1", 15 );
    players = function_5713d46873b29625( players );
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_dmz_mission_overlay", 1 );
        player player::_freezecontrols( 0, 1 );
        player player::_freezelookcontrols( 0, 1 );
    }
    
    wait getdvarint( @"hash_65aacd5faa9482f2", 4 );
    players = function_5713d46873b29625( players );
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_dmz_mission_overlay", 0 );
    }
}

// Namespace ob_infils
// Params 1
// Checksum 0x6c74f10e, Offset: 0x287e
// Size: 0x3f
function function_5f4425c42c7f2264( waittime )
{
    self endon( #"disconnect" );
    game_utility::fadetoblackforplayerkeepui( self, 1, 0 );
    wait waittime + getdvarfloat( @"hash_45ce1e830caba62a", 0 );
    game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
}

/#

    // Namespace ob_infils
    // Params 0
    // Checksum 0xbea497a6, Offset: 0x28c5
    // Size: 0x29f, Type: dev
    function function_370d08c2c8f12766()
    {
        while ( !isdefined( level.squadspawnpointsets ) )
        {
            waitframe();
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x288>" );
        devgui::add_devgui_func( "<dev string:x2a3>", "<dev string:x2c1>", &function_959b57a71203fe56, 1 );
        
        foreach ( n_spawn_set, var_87984ea4210fab1c in level.squadspawnpointsets )
        {
            foreach ( var_10084b90df86f2dc, s_squad_spawn in var_87984ea4210fab1c )
            {
                if ( !isdefined( s_squad_spawn.script_noteworthy ) )
                {
                    continue;
                }
                
                str_noteworthy_group = s_squad_spawn.script_noteworthy;
                devgui::function_cd4e263c1f3018ae( "<dev string:x2d0>" + str_noteworthy_group + "<dev string:x2e8>" + var_10084b90df86f2dc + "<dev string:x2f0>", "<dev string:x302>" + n_spawn_set + "<dev string:x311>" + var_10084b90df86f2dc, &function_fcdcc2344617a61b );
                devgui::function_cd4e263c1f3018ae( "<dev string:x2d0>" + str_noteworthy_group + "<dev string:x2e8>" + var_10084b90df86f2dc + "<dev string:x313>", "<dev string:x32b>" + n_spawn_set + "<dev string:x311>" + var_10084b90df86f2dc, &function_b32ad8cb396a10f8 );
            }
        }
        
        if ( level.var_9cf78b20e77139e1 )
        {
            var_77a37c3d42aac1b = spawnlogic::getspawnpointarray( "<dev string:x33b>" );
            
            foreach ( var_10084b90df86f2dc, var_c556b247e9097616 in var_77a37c3d42aac1b )
            {
                str_noteworthy_group = "<dev string:x355>";
                n_spawn_set = "<dev string:x355>";
                devgui::function_cd4e263c1f3018ae( "<dev string:x2d0>" + str_noteworthy_group + "<dev string:x2e8>" + var_10084b90df86f2dc + "<dev string:x2f0>", "<dev string:x302>" + n_spawn_set + "<dev string:x311>" + var_10084b90df86f2dc, &function_fcdcc2344617a61b );
                devgui::function_cd4e263c1f3018ae( "<dev string:x2d0>" + str_noteworthy_group + "<dev string:x2e8>" + var_10084b90df86f2dc + "<dev string:x313>", "<dev string:x32b>" + n_spawn_set + "<dev string:x311>" + var_10084b90df86f2dc, &function_b32ad8cb396a10f8 );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_infils
    // Params 0
    // Checksum 0xc3a7fecb, Offset: 0x2b6c
    // Size: 0x1c1, Type: dev
    function function_959b57a71203fe56()
    {
        while ( true )
        {
            foreach ( var_87984ea4210fab1c in level.squadspawnpointsets )
            {
                foreach ( var_10084b90df86f2dc, s_squad_spawn in var_87984ea4210fab1c )
                {
                    if ( !isdefined( s_squad_spawn.script_noteworthy ) )
                    {
                        continue;
                    }
                    
                    print3d( s_squad_spawn.origin, "<dev string:x365>" + s_squad_spawn.classname, undefined, undefined, 0.25 );
                    print3d( s_squad_spawn.origin + ( 0, 0, -5 ), "<dev string:x371>" + s_squad_spawn.script_noteworthy, undefined, undefined, 0.25 );
                    print3d( s_squad_spawn.origin + ( 0, 0, -10 ), "<dev string:x38a>" + var_10084b90df86f2dc, undefined, undefined, 0.25 );
                    utility::draw_angles( s_squad_spawn.angles, s_squad_spawn.origin );
                    utility::draw_capsule( s_squad_spawn.origin, 16, 64, s_squad_spawn.angles );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_infils
    // Params 1
    // Checksum 0xc6e2b1c7, Offset: 0x2d35
    // Size: 0x1e6, Type: dev
    function function_fcdcc2344617a61b( params )
    {
        a_squad_players = level.players[ 0 ] squad_utility::getsquadmembers( undefined, 1 );
        
        if ( params[ 0 ] == "<dev string:x355>" )
        {
            var_77a37c3d42aac1b = spawnlogic::getspawnpointarray( "<dev string:x33b>" );
            var_10084b90df86f2dc = int( params[ 1 ] );
            
            foreach ( player in a_squad_players )
            {
                spawnpoint = var_77a37c3d42aac1b[ var_10084b90df86f2dc ];
                player setorigin( spawnpoint.origin );
                player setplayerangles( spawnpoint.angles );
                var_10084b90df86f2dc++;
                
                if ( var_10084b90df86f2dc >= var_77a37c3d42aac1b.size )
                {
                    var_10084b90df86f2dc = 0;
                }
            }
            
            return;
        }
        
        n_spawn_set = int( params[ 0 ] );
        var_10084b90df86f2dc = int( params[ 1 ] );
        a_squad_players = level.players[ 0 ] squad_utility::getsquadmembers( undefined, 1 );
        
        foreach ( player in a_squad_players )
        {
            spawnpoint = level.squadspawnpointsets[ n_spawn_set ][ var_10084b90df86f2dc ];
            player setorigin( spawnpoint.origin );
            player setplayerangles( spawnpoint.angles );
            var_10084b90df86f2dc++;
            
            if ( var_10084b90df86f2dc >= level.squadspawnpointsets[ n_spawn_set ].size )
            {
                var_10084b90df86f2dc = 0;
            }
        }
    }

    // Namespace ob_infils
    // Params 1
    // Checksum 0xc260804c, Offset: 0x2f23
    // Size: 0x27e, Type: dev
    function function_b32ad8cb396a10f8( params )
    {
        if ( params[ 0 ] == "<dev string:x355>" )
        {
            var_77a37c3d42aac1b = spawnlogic::getspawnpointarray( "<dev string:x33b>" );
            var_10084b90df86f2dc = int( params[ 1 ] );
            spawnpoint = var_77a37c3d42aac1b[ var_10084b90df86f2dc ];
            
            foreach ( teamname, squadarray in level.squaddata )
            {
                foreach ( squad in squadarray )
                {
                    if ( arraycontains( squad.players, level.players[ 0 ] ) )
                    {
                        level thread function_2c026628e2e1a109( teamname, squad.index, spawnpoint, 2 );
                        return;
                    }
                }
            }
            
            return;
        }
        
        n_spawn_set = int( params[ 0 ] );
        var_10084b90df86f2dc = int( params[ 1 ] );
        spawnpoint = level.squadspawnpointsets[ n_spawn_set ][ var_10084b90df86f2dc ];
        
        foreach ( teamname, squadarray in level.squaddata )
        {
            foreach ( squad in squadarray )
            {
                if ( arraycontains( squad.players, level.players[ 0 ] ) )
                {
                    level thread function_2c026628e2e1a109( teamname, squad.index, spawnpoint, 2 );
                    return;
                }
            }
        }
    }

#/
