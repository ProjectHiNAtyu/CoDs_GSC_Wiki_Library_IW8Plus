// scripts\mp\br\gametypes\br_infils_legacy.gsc  (hash_67cea73211d30669.gscc) (size: 42799 Bytes / 0xa72f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x906cb089 (2423042185)
// size ...... 42799 (0xa72f)
// includes .. 22  (offset: 0x9c8b)
// strings ... 133 (offset: 0x9d3b)
// dev strs .. 28  (offset: 0xa5a3)
// exports ... 75  (offset: 0x6ddf)
// cseg ...... 0xc30 + 0x61af (0x6ddf)
// imports ... 272 (offset: 0x7997)
// animtree1 . 0   (offset: 0xa72f)
// animtree2 . 0   (offset: 0xa72f)
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\common\equipment\throwing_knife;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\deathicons;
#using scripts\mp\flags;
#using scripts\mp\music_and_dialog;
#using scripts\mp\playerlogic;

#namespace br_infils_legacy;

// Namespace br_infils_legacy
// Params 0
// Checksum 0x8c581b5f, Offset: 0xc4e
// Size: 0x5c
function init()
{
    var_cf5e8d9c0f9209e9 = utility::issharedfuncdefined( #"gametype", #"infilsequence" );
    level.var_bb14cfd60cc8058 = getdvarint( @"scr_br_infil_legacy", 0 ) || var_cf5e8d9c0f9209e9;
    
    if ( !isdefined( level.var_b1379eb981109690 ) )
    {
        level.var_b1379eb981109690 = spawnstruct();
    }
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x127a6f8, Offset: 0xcb2
// Size: 0xb
function function_bb14cfd60cc8058()
{
    return level.var_bb14cfd60cc8058;
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xa8af3ced, Offset: 0xcc6
// Size: 0xc1
function main()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 )
    {
        return;
    }
    
    init();
    
    if ( !function_bb14cfd60cc8058() )
    {
        return;
    }
    
    var_4f36a20c84898388 = getent( "infil_plane", #script_noteworthy );
    
    if ( isdefined( var_4f36a20c84898388 ) )
    {
        var_4f36a20c84898388 hide();
    }
    
    level.brlatespawnplayer = &latespawnplayer;
    setdvarifuninitialized( @"hash_4265a52f9f8a703", 1 );
    setdvarifuninitialized( @"hash_8be4acc5eebb19ca", 1 );
    setdvarifuninitialized( @"hash_e65dc975d6fcfca0", 0 );
    level._effect[ "vfx_br_ac130_clouds" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_ac130_clouds" );
    level._effect[ "vfx_br_infil_cloud_anim" ] = loadfxasset( "vfx_iw8_br_gameplay_infil_cloud_anim" );
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x161fae87, Offset: 0xd8f
// Size: 0x8b
function function_48b822fa69cfe126()
{
    if ( !function_bb14cfd60cc8058() )
    {
        return;
    }
    
    c130pathstruct = undefined;
    
    if ( !level.br_infils_disabled && !level.var_32cd3f9427fdc5d9 )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"createc130pathstruct" ) )
        {
            c130pathstruct = utility::callsharedfunc( #"gametype", #"createc130pathstruct" );
        }
        else
        {
            c130pathstruct = br_c130::createtestc130path();
        }
    }
    
    level.var_b1379eb981109690.c130pathstruct = c130pathstruct;
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x41836edf, Offset: 0xe22
// Size: 0x1e3
function postprematch()
{
    if ( !function_bb14cfd60cc8058() )
    {
        return;
    }
    
    level.br_c130spawndone = 0;
    level.br_latejoininfilready = 0;
    
    if ( !level.br_infils_disabled )
    {
        setdvarifuninitialized( @"hash_fc6ebbeb3426b854", 0 );
        
        if ( utility::issharedfuncdefined( #"gametype", #"infilsequence" ) )
        {
            utility::callsharedfunc( #"gametype", #"infilsequence" );
        }
        else
        {
            players = utility::callsharedfunc( #"gametype", #"hash_d157d0fecf23e86b" );
            assert( isdefined( level.var_b1379eb981109690.c130pathstruct ) );
            
            if ( !getdvarint( @"hash_fc6ebbeb3426b854", 0 ) )
            {
                beginbrc130playeraniminfilsequence( level.var_b1379eb981109690.c130pathstruct, "player", players );
            }
            else
            {
                beginbrc130playeraniminfilsequence( level.var_b1379eb981109690.c130pathstruct, "script_model" );
            }
            
            level thread br_c130::waittoplayinfildialog();
        }
        
        return;
    }
    
    flags::gameflagset( "prematch_fade_done" );
    waitframe();
    level.allowprematchdamage = 0;
    players = utility::callsharedfunc( #"gametype", #"hash_d157d0fecf23e86b" );
    
    if ( !isdefined( players ) || players.size > 0 )
    {
        waitforc130andforcespawnallplayers( players );
    }
    
    foreach ( player in level.players )
    {
        player.plotarmor = undefined;
    }
    
    flags::gameflagset( "br_ready_to_jump" );
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xa6df28d7, Offset: 0x100d
// Size: 0x250
function latespawnplayer()
{
    self endon( #"disconnect" );
    
    if ( !function_bb14cfd60cc8058() )
    {
        return;
    }
    
    player = self;
    istutorial = br_public::istutorial() || br_public::function_379fb7b09f4ef13e();
    
    if ( getdvar( @"hash_215446c7a0657e95", "" ) != "" || istutorial )
    {
        oldlatespawnplayer();
    }
    else if ( !isalive( player ) )
    {
        infilskipped = istrue( level.br_infils_disabled );
        latejoininfil = !level.br_c130spawndone || !isdefined( level.latejoinersanimstruct );
        
        if ( !infilskipped && latejoininfil )
        {
            var_860ed27128ac7df2 = isbot( player ) && br_public::isbrpracticemode();
            
            while ( !level.br_latejoininfilready && !var_860ed27128ac7df2 )
            {
                if ( !var_860ed27128ac7df2 )
                {
                    player br::function_db10c8f42ea08ad5();
                    player setclientomnvar( "ui_br_transition_type", 4 );
                }
                
                wait 0.3;
            }
            
            player thread latespawnsnatchtoc130();
        }
        else
        {
            player.br_isininfil = 0;
            player.br_infilstarted = 1;
            isuibot = player br::function_a29e5f57c1ef9e35();
            
            if ( infilskipped && isbot( player ) && !isuibot )
            {
                player.jumped = 1;
                player playerlogic::addtoalivecount();
            }
            
            if ( !player.alreadyaddedtoalivecount && game_utility::getgametype() == "playground" && !isbot( player ) )
            {
                teams::addtoteamlives( player, player.team );
            }
            
            if ( !br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
            {
                teamplayers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
                
                if ( !isdefined( teamplayers ) || teamplayers.size == 0 )
                {
                    teamplayers = [ self ];
                }
                
                br_infils_util::setupbrsquadleader( teamplayers );
            }
            
            if ( isuibot )
            {
                player thread playerlogic::spawnplayer( undefined, 0 );
            }
            else
            {
                player thread missedinfilplayerhandler();
            }
        }
    }
    else
    {
        assertmsg( "<dev string:x24>" );
    }
    
    player setclientomnvar( "ui_br_transition_type", 0 );
    player setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xb16d72d6, Offset: 0x1265
// Size: 0x10c
function oldlatespawnplayer()
{
    self endon( #"disconnect" );
    
    if ( !function_bb14cfd60cc8058() )
    {
        return;
    }
    
    player = self;
    println( "<dev string:x6e>" );
    
    if ( !isalive( player ) )
    {
        player playerlogic::spawnplayer( 0 );
    }
    
    if ( !br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
    {
        if ( level.teambased )
        {
            teamplayers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
            
            if ( !isdefined( teamplayers ) || teamplayers.size == 0 )
            {
                teamplayers = [ self ];
            }
            
            brsquadleader = br_infils_util::setupbrsquadleader( teamplayers );
            
            if ( isdefined( brsquadleader ) )
            {
                println( "<dev string:x8f>" );
                br_infils_util::registerbrsquadleaderjumpcommands( brsquadleader );
            }
            else
            {
                println( "<dev string:xca>" );
            }
        }
        else
        {
            player br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
            br_infils_util::registerbrsquadleaderjumpcommands( player );
        }
    }
    
    player.br_infilstarted = 1;
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xb4165b8d, Offset: 0x1379
// Size: 0x33f
function latespawnsnatchtoc130()
{
    player = self;
    player endon( #"disconnect" );
    
    if ( !isalive( player ) )
    {
        player.latetoinfil = 1;
        player playerlogic::spawnplayer( 0 );
    }
    
    player player_utility::function_dbe5a52a6654a982();
    player player_utility::function_9d378d725bb4831e( "br_infils_legacy::lateSpawnSnatchToC130()" );
    player.latetoinfil = undefined;
    player freezecontrols( 1 );
    
    if ( player br_public::isplayerbrsquadleader() )
    {
        player.infilanimindex = 1;
    }
    
    if ( !isdefined( player.infilanimindex ) && level.teambased )
    {
        teamplayers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
        possibleindices = [];
        
        for ( i = 0; i < teamplayers.size - 1 ; i++ )
        {
            possibleindices[ i ] = i + 2;
        }
        
        for ( i = 0; i < possibleindices.size ; i++ )
        {
            used = 0;
            
            foreach ( teamplayer in teamplayers )
            {
                if ( teamplayer != player && teamplayer br_public::isplayerbrsquadleader() )
                {
                    continue;
                }
                
                if ( isdefined( teamplayer.infilanimindex ) && isdefined( possibleindices[ i ] ) && teamplayer.infilanimindex == possibleindices[ i ] )
                {
                    used = 1;
                    break;
                }
            }
            
            if ( !used )
            {
                player.infilanimindex = possibleindices[ i ];
                break;
            }
        }
    }
    
    player playerjoininfil();
    player playerlinktopositionent( level.latejoinersanimstruct );
    player.c130 = level.latejoinersanimstruct.movingc130;
    player setorigin( level.latejoinersanimstruct.movingc130.origin );
    player playerplayinfilloopanim( level.latejoinersanimstruct );
    waitframe();
    
    if ( isdefined( player.team ) && level.teambased )
    {
        teamplayers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
        
        foreach ( otherplayer in teamplayers )
        {
            player showtoplayer( otherplayer );
            otherplayer showtoplayer( player );
        }
    }
    
    if ( !isbot( player ) )
    {
        br_c130::orbitcam( level.br_ac130 );
    }
    
    wait 0.5;
    player freezecontrols( 0 );
    player setclientomnvar( "ui_br_transition_type", 0 );
    player.br_infilstarted = 1;
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x6e5eafe6, Offset: 0x16c0
// Size: 0x83
function playerlinktopositionent( animstruct )
{
    if ( isai( self ) && !self.hasspawned )
    {
        return;
    }
    
    if ( !isdefined( self.infilanimindex ) )
    {
        self.infilanimindex = 1;
    }
    
    player_link_tag = "j_prop_" + self.infilanimindex;
    
    if ( isent( animstruct.playerpositionents[ player_link_tag ] ) )
    {
        self playerlinkto( animstruct.playerpositionents[ player_link_tag ], "tag_player" );
    }
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x30287fa, Offset: 0x174b
// Size: 0x10
function function_433498e67930440d()
{
    return getdvarint( @"scr_skip_infil_cinematic", 0 );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xd5919f2e, Offset: 0x1764
// Size: 0x1be
function playinfilplayeranims( animstruct, players )
{
    startanimlength = getanimlength( level.br_anim[ "sdr_mp_infil_ac130_redux_player1" ] );
    
    if ( function_433498e67930440d() )
    {
        startanimlength = 0;
    }
    
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread [[ level.parachutetakeweaponscb ]]();
        player br::playerexecutionsdisable();
        player.c130 = animstruct.movingc130;
        player.plotarmor = 1;
        player playerlinktopositionent( animstruct );
        start_anim_name = "sdr_mp_infil_ac130_redux_player" + player.infilanimindex;
        player playanimscriptsceneevent( "scripted_scene", start_anim_name );
    }
    
    wait startanimlength;
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread playerplayinfilloopanim( animstruct );
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xaeb6a5d4, Offset: 0x192a
// Size: 0x54
function playerplayinfilloopanim( animstruct )
{
    if ( !isdefined( self.infilanimindex ) )
    {
        self.infilanimindex = 1;
    }
    
    start_anim_name = "sdr_mp_infil_ac130_loop_pl0" + self.infilanimindex;
    self playanimscriptsceneevent( "scripted_scene", start_anim_name );
    thread watchinfiljumpanim( animstruct );
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x1002d803, Offset: 0x1986
// Size: 0x6f8
function watchinfiljumpanim( animstruct )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level.infiljumpentsspawned ) )
    {
        level.infiljumpentsspawned = 0;
    }
    
    self.hasspawnweapons = 0;
    self waittill( #"br_jump" );
    teamplayers = teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid );
    jumpplayers = [];
    
    if ( self.jumptype == "leader" )
    {
        foreach ( player in teamplayers )
        {
            if ( isdefined( player.infilanimindex ) )
            {
                jumpplayers[ jumpplayers.size ] = player;
            }
        }
    }
    else if ( self.jumptype == "solo" || self.jumptype == "outOfBounds" )
    {
        jumpplayers = [ self ];
    }
    
    var_290547d422ff84bc = jumpplayers.size > 0;
    
    if ( var_290547d422ff84bc )
    {
        var_d1f48918cfe61df0 = getdvarint( @"hash_8be4acc5eebb19ca", 1 ) != 0;
        
        if ( level.infiljumpentsspawned >= 100 )
        {
            var_d1f48918cfe61df0 = 0;
        }
        
        shouldteleport = undefined;
        
        if ( var_d1f48918cfe61df0 )
        {
            shouldteleport = 0;
            [ propanimname, propanimref, playeranimname ] = getanimsforplanefacing( animstruct );
            var_ff1429cfdb4e629a[ "parent" ] = spawn( "script_model", animstruct.movingc130.origin );
            level.infiljumpentsspawned++;
            var_ff1429cfdb4e629a[ "parent" ] setmodel( "generic_prop_x10" );
            var_ff1429cfdb4e629a[ "parent" ] linkto( animstruct.movingc130, "tag_body", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            
            foreach ( player in jumpplayers )
            {
                if ( !isdefined( player.infilanimindex ) )
                {
                    player.infilanimindex = 1;
                }
                
                player_link_tag = "j_prop_" + player.infilanimindex + 2;
                var_ff1429cfdb4e629a[ player_link_tag ] = spawn( "script_model", var_ff1429cfdb4e629a[ "parent" ] gettagorigin( player_link_tag ) );
                level.infiljumpentsspawned++;
                var_ff1429cfdb4e629a[ player_link_tag ] setmodel( "tag_player" );
                var_ff1429cfdb4e629a[ player_link_tag ] linkto( var_ff1429cfdb4e629a[ "parent" ], player_link_tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                player playerlinkto( var_ff1429cfdb4e629a[ player_link_tag ], "tag_player" );
                player player_utility::function_b54a1e23734ef07( 1 );
                player playanimscriptsceneevent( "scripted_scene", playeranimname );
                player.infilanimindex = undefined;
                player.var_edbda953d7469bd7 = undefined;
                player playlocalsound( "evt_br_infil_jump_stinger" );
                player setplayermusicstate( "mx_br_infil_jump" );
                player clearsoundsubmix( "mp_br_infil_music", 2 );
                level thread playjumpsoundtosquad( player );
            }
            
            var_ff1429cfdb4e629a[ "parent" ] scriptmodelplayanim( propanimname, "prop" );
            jumpanimlength = getanimlength( propanimref );
            var_7c1475d50024c7ab = 1;
            jumpanimlength = max( jumpanimlength, var_7c1475d50024c7ab + 0.1 );
            wait jumpanimlength - var_7c1475d50024c7ab;
            
            foreach ( player in jumpplayers )
            {
                player cameradefault();
            }
            
            wait var_7c1475d50024c7ab;
            
            foreach ( ent in var_ff1429cfdb4e629a )
            {
                ent delete();
                level.infiljumpentsspawned--;
            }
        }
        else
        {
            shouldteleport = 1;
            waittillframeend();
        }
        
        foreach ( player in jumpplayers )
        {
            player.infilanimindex = undefined;
            player.var_edbda953d7469bd7 = undefined;
            player stopanimscriptsceneevent();
            player notify( #"infil_jump_done" );
            player br::playerexecutionsenable();
            player utility::callsharedfunc( #"gametype", #"hash_b3f0e56e2062b3db" );
        }
        
        if ( shouldteleport )
        {
            waitframe();
            
            if ( isdefined( animstruct.movingc130 ) )
            {
                if ( isdefined( animstruct.movingc130.playeroffsets ) && isdefined( animstruct.movingc130.currentplayeroffset ) )
                {
                    foreach ( player in jumpplayers )
                    {
                        offset = animstruct.movingc130.playeroffsets[ animstruct.movingc130.currentplayeroffset ];
                        player setorigin( animstruct.movingc130.origin + offset, 1, 1 );
                        animstruct.movingc130.currentplayeroffset++;
                        
                        if ( animstruct.movingc130.currentplayeroffset == animstruct.movingc130.playeroffsets.size )
                        {
                            animstruct.movingc130.currentplayeroffset = 0;
                        }
                        
                        player player_utility::function_b54a1e23734ef07( 1 );
                        level thread playjumpsoundtosquad( player );
                    }
                }
            }
        }
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xf9bc4ced, Offset: 0x2086
// Size: 0x1a4
function getanimsforplanefacing( animstruct )
{
    var_7ac18a39f81dd485 = self getplayerangles( 1 );
    playerforward = anglestoforward( var_7ac18a39f81dd485 );
    planeforward = anglestoforward( animstruct.movingc130.angles );
    planeright = anglestoright( animstruct.movingc130.angles );
    dotforward = vectordot( playerforward, planeforward );
    dotright = vectordot( playerforward, planeright );
    cos45 = cos( 45 );
    
    if ( dotforward < -1 * cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10" ], "sdr_mp_infil_ac130_jump" ];
    }
    
    if ( dotright > cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_l", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_l" ], "sdr_mp_infil_ac130_jump_90_l" ];
    }
    
    if ( dotright < -1 * cos45 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_90_r", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_90_r" ], "sdr_mp_infil_ac130_jump_90_r" ];
    }
    
    if ( dotright > 0 )
    {
        return [ "sdr_mp_infil_ac130_jump_genpropx10_180_l", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_l" ], "sdr_mp_infil_ac130_jump_180_l" ];
    }
    
    return [ "sdr_mp_infil_ac130_jump_genpropx10_180_r", level.br_anim[ "sdr_mp_infil_ac130_jump_genpropx10_180_r" ], "sdr_mp_infil_ac130_jump_180_r" ];
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xc437574b, Offset: 0x2232
// Size: 0x44
function playjumpsoundtosquad( player )
{
    aliasname = "evt_br_infil_squadmate_jump";
    
    if ( player br_public::isplayerbrsquadleader() )
    {
        aliasname = "evt_br_infil_squad_leader_jump";
    }
    
    player playsoundtoteam( aliasname, player.team, player );
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x779ea6cf, Offset: 0x227e
// Size: 0x3a
function missedinfilplayerhandler()
{
    player = self;
    player.br_infilstarted = 1;
    player br_pickups::addrespawntoken( 1 );
    player br_gulag::playergulagautowin( "missedInfil", undefined, undefined, 1 );
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x5fa86119, Offset: 0x22c0
// Size: 0xba
function playerjoininfil()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"joining_infil" );
    player = self;
    player.br_infilstarted = 1;
    
    if ( !level.c130inbounds )
    {
        self setclientomnvar( "ui_hide_minimap", 1 );
    }
    
    player.health = player.maxhealth;
    player br_c130::spawnplayertoc130();
    player playersetupcontrolsforinfil();
    player br_public::updatebrscoreboardstat( "isInInfilPlane", 1 );
    level.infilstruct.playersinc130++;
    player br_public::function_c61dc6b780cede50();
    player thread playercleanupinfilondisconnect();
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x2e32dc8c, Offset: 0x2382
// Size: 0x76
function playersetupcontrolsforinfil( soloonly = 0 )
{
    self setclientomnvar( "ui_br_infil_started", 1 );
    self setclientomnvar( "ui_br_infiled", 0 );
    
    if ( !soloonly )
    {
        self notifyonplayercommand( "halo_jump_c130", "+gostand" );
    }
    else
    {
        self notifyonplayercommand( "halo_jump_solo_c130", "+gostand" );
    }
    
    self notifyonplayercommand( "br_pass_squad_leader", "+usereload" );
    self notifyonplayercommand( "br_pass_squad_leader", "+activate" );
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x71151039, Offset: 0x2400
// Size: 0x79
function playercleanupinfilondisconnect()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"cancel_c130" );
    self endon( #"br_jump" );
    self waittill( #"disconnect" );
    
    if ( isdefined( level.infilstruct ) && level.infilstruct.playersinc130 > 0 )
    {
        level.infilstruct.playersinc130--;
    }
}

// Namespace br_infils_legacy
// Params 3
// Checksum 0xfe1c129e, Offset: 0x2481
// Size: 0x403
function beginbrc130playeraniminfilsequence( c130pathstruct, infil_anim_type, players )
{
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( -1 );
    }
    
    level.infilstruct = spawnstruct();
    level.infilstruct.playersinc130 = 0;
    
    if ( !isdefined( c130pathstruct ) )
    {
        c130pathstruct = br_c130::createtestc130path();
    }
    
    level.infilstruct.c130pathstruct = c130pathstruct;
    br_c130::spawnc130( undefined, undefined, undefined, undefined, level.infilstruct.c130pathstruct );
    animstruct = buildac130infilanimstruct( level.br_ac130, infil_anim_type );
    level.latejoinersanimstruct = animstruct;
    infilvideopreload( players );
    
    if ( isdefined( level.preinfilstreamfunc ) )
    {
        [[ level.preinfilstreamfunc ]]( animstruct );
    }
    
    level.infilcinematicactive = 1;
    level.allowprematchdamage = 0;
    level.br_ac130 thread gunship_updateplayercount();
    infilplayers = players ?? level.players;
    transitionplayerstoac130cinematic( infilplayers, infil_anim_type, animstruct.staticc130 );
    
    if ( br_public::isbrpracticemode() || br_public::isdmzbotpracticematch() )
    {
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( isplayer( player ) )
            {
                player notify( #"hash_5fa072275c8d9ba6" );
            }
        }
    }
    
    infilvideoplay( players );
    infilvideowaituntilcomplete( players );
    level thread infilallfadetoblack( 0, 3.45, 0.6, undefined, players );
    playac130infilanim( animstruct, players );
    infilplayers = players ?? level.players;
    transitionplayersoutofac130cinematic( infilplayers, infil_anim_type );
    level.infilcinematicactive = 0;
    level.infilstruct.infil_anim_type = infil_anim_type;
    thread utility::callsharedfunc( #"gametype", #"hash_a79c043d2c0be05c", players );
    br_public::brleaderdialog( "match_start", 0, players );
    istutorial = br_public::istutorial() || br_public::function_379fb7b09f4ef13e();
    
    if ( !istutorial )
    {
        var_b2685b6bd9f8ebec = getdvar( @"hash_215446c7a0657e95", "" ) == "";
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player.br_isininfil && var_b2685b6bd9f8ebec )
            {
                continue;
            }
            
            player thread playerjoininfil();
            
            if ( player isplayerheadless() )
            {
                registerheadlessinfil( player );
            }
        }
        
        level.br_ac130 utility::callsharedfunc( #"gametype", #"addtoc130infil" );
    }
    
    if ( isdefined( level.headlessinfilplayers ) )
    {
        level thread headlessinfils();
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x80360760, Offset: 0x288c
// Size: 0xa3
function infilvideopreload( players )
{
    videoname = "mp_donetsk_c130_intro";
    
    if ( !isdefined( players ) )
    {
        preloadcinematicforall( videoname );
        return;
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player preloadcinematicforplayer( videoname );
        }
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xfd2deb40, Offset: 0x2937
// Size: 0x15
function function_6eb530979b936b3( waittime )
{
    wait waittime;
    self stopsounds();
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x6bc03558, Offset: 0x2954
// Size: 0x248
function infilvideoplay( players )
{
    infilplayers = players ?? level.players;
    allplayers = level.players.size == infilplayers.size;
    thread music_and_dialog::stopsuspensemusic();
    
    if ( allplayers )
    {
        setglobalsoundcontext( "lobby_fade", "", 2 );
    }
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !allplayers )
        {
            player setentitysoundcontext( "lobby_fade", "", 2 );
        }
        
        player playlocalsound( "br_infil_part1_lr" );
        
        if ( function_433498e67930440d() )
        {
            player thread function_6eb530979b936b3( 7 );
        }
        
        player clearsoundsubmix( "mp_br_lobby_fade", 1.5 );
        player setsoundsubmix( "solo_cin_igc_music_br_hack", 0.5 );
        player setplayermusicstate( "mx_br_infil_loop" );
    }
    
    videoname = "mp_donetsk_c130_intro";
    
    if ( allplayers )
    {
        playcinematicforall( videoname );
    }
    else
    {
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player playcinematicforplayer( videoname );
        }
    }
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player.latetoinfil )
        {
            player setclientomnvar( "ui_br_bink_overlay_state", 3 );
        }
    }
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xc305ba5d, Offset: 0x2ba4
// Size: 0x32
function infilvideocompletecallback( channel, val )
{
    if ( channel == "bink_complete" )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        self stopcinematicforplayer();
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xc836f42a, Offset: 0x2bde
// Size: 0x163
function infilvideowaituntilcomplete( players )
{
    lui_game_event_aggregator::registeronluieventcallback( &infilvideocompletecallback );
    time = 3.2;
    wait time;
    infilplayers = players ?? level.players;
    
    if ( isdefined( level.skip_death_vo ) )
    {
        level.skip_death_vo = undefined;
    }
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player notify( #"beginC130" );
    }
    
    if ( isdefined( level.throwingknives ) )
    {
        foreach ( throwingknife in level.throwingknives )
        {
            if ( isdefined( throwingknife ) )
            {
                throwingknife thread throwing_knife::throwing_knife_deletepickup();
            }
        }
    }
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xbe8e3063, Offset: 0x2d49
// Size: 0x11c
function gunship_updateplayercount()
{
    level endon( #"game_ended" );
    self notify( #"hash_dfb177465a3238bd" );
    self endon( #"hash_dfb177465a3238bd" );
    var_7f6139c8274970fb = getdvarint( @"hash_57377f405b99ecd2", 0 );
    
    if ( var_7f6139c8274970fb )
    {
        level.infilstruct.var_8d204c31b1b2bdde = level.players.size;
        
        if ( isdefined( level.uibotmanager ) && isdefined( level.uibotmanager.uibots ) )
        {
            level.infilstruct.var_8d204c31b1b2bdde += level.uibotmanager.uibots.size;
        }
    }
    
    while ( true )
    {
        if ( var_7f6139c8274970fb )
        {
            setomnvar( "ui_br_players_left_in_plane", level.infilstruct.var_8d204c31b1b2bdde );
        }
        else
        {
            setomnvar( "ui_br_players_left_in_plane", level.infilstruct.playersinc130 );
        }
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        wait 0.5;
    }
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0x1dbc2b39, Offset: 0x2e6d
// Size: 0x8d
function spawnplayerpositionparentent( animstruct, ac130 )
{
    animstruct.playerpositionents[ "parent" ] = spawn( "script_model", ac130.origin );
    animstruct.playerpositionents[ "parent" ] setmodel( "generic_prop_x5" );
    animstruct.playerpositionents[ "parent" ] linkto( ac130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0x7c264b7b, Offset: 0x2f02
// Size: 0x9c
function spawnplayerpositionent( animstruct, prop_tag )
{
    animstruct.playerpositionents[ prop_tag ] = spawn( "script_model", animstruct.playerpositionents[ "parent" ] gettagorigin( prop_tag ) );
    animstruct.playerpositionents[ prop_tag ] setmodel( "tag_player" );
    animstruct.playerpositionents[ prop_tag ] linkto( animstruct.playerpositionents[ "parent" ], prop_tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0x5b04effe, Offset: 0x2fa6
// Size: 0x5cc
function buildac130infilanimstruct( movingc130, infil_anim_type )
{
    animstruct = spawnstruct();
    
    if ( isdefined( movingc130 ) )
    {
        movingc130.animstruct = animstruct;
        animstruct.movingc130 = movingc130;
    }
    
    animstruct.staticc130 = getent( "infil_plane", #script_noteworthy );
    
    if ( isdefined( animstruct.staticc130 ) )
    {
        animstruct.staticc130 show();
    }
    else
    {
        animstruct.staticc130 = spawn( "script_model", getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) ) );
        animstruct.staticc130 setmodel( "veh8_mil_air_acharlie130_magma_animated" );
        animstruct.staticc130.cleanme = 1;
    }
    
    animstruct.cameraent = spawn( "script_model", animstruct.staticc130.origin );
    animstruct.cameraent setmodel( "generic_prop_x5" );
    
    if ( isdefined( movingc130 ) )
    {
        animstruct.cameraentmoving = spawn( "script_model", animstruct.movingc130.origin );
        animstruct.cameraentmoving setmodel( "generic_prop_x5" );
        animstruct.cameraentmoving linkto( animstruct.movingc130, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.cameraentmoving forcenetfieldhighlod( 1 );
    }
    
    spawnplayerpositionparentent( animstruct, animstruct.staticc130 );
    
    if ( infil_anim_type == "script_model" )
    {
        animstruct.playerslot1 = spawn( "script_model", animstruct.staticc130.origin );
        animstruct.playerslot1 setmodel( "fullbody_usmc_ar_br_infil" );
        animstruct.playerslot2 = spawn( "script_model", animstruct.staticc130.origin );
        animstruct.playerslot2 setmodel( "fullbody_usmc_ar_br_infil" );
        animstruct.playerslot3 = spawn( "script_model", animstruct.staticc130.origin );
        animstruct.playerslot3 setmodel( "fullbody_usmc_ar_br_infil" );
        animstruct.playerslot4 = spawn( "script_model", animstruct.staticc130.origin );
        animstruct.playerslot4 setmodel( "fullbody_usmc_ar_br_infil" );
        animstruct.playerslot1 linkto( animstruct.playerpositionents[ "parent" ], "j_prop_1", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playerslot2 linkto( animstruct.playerpositionents[ "parent" ], "j_prop_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playerslot3 linkto( animstruct.playerpositionents[ "parent" ], "j_prop_3", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.playerslot4 linkto( animstruct.playerpositionents[ "parent" ], "j_prop_4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.infil_anim_type = "script_model";
    }
    else
    {
        var_b6f53b24b3b2fdb0 = [ "j_prop_1", "j_prop_2", "j_prop_3", "j_prop_4" ];
        
        foreach ( prop_tag in var_b6f53b24b3b2fdb0 )
        {
            spawnplayerpositionent( animstruct, prop_tag );
        }
        
        animstruct.infil_anim_type = "player";
    }
    
    animstruct.aidoorchief = spawn( "script_model", animstruct.staticc130.origin );
    animstruct.aidoorchief setmodel( "fullbody_usmc_ar_br_infil" );
    
    if ( isdefined( movingc130 ) )
    {
        animstruct.movingc130.innards linkto( animstruct.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    animstruct.aidoorchief linkto( animstruct.playerpositionents[ "parent" ], "j_prop_5", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.cameraent linkto( animstruct.staticc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    animstruct.cloudanimfx = spawnfx( level._effect[ "vfx_br_infil_cloud_anim" ], animstruct.staticc130.origin );
    return animstruct;
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x7463eeb4, Offset: 0x357b
// Size: 0x93
function setuphudelemninfilblack( hudelem )
{
    hudelem.x = 0;
    hudelem.y = 0;
    hudelem setshader( "black", 640, 480 );
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.horzalign = "fullscreen";
    hudelem.vertalign = "fullscreen";
    hudelem.sort = -1;
    hudelem setshowinrealism( 1 );
}

// Namespace br_infils_legacy
// Params 6
// Checksum 0x8fe0c1ed, Offset: 0x3616
// Size: 0x566
function infilallfadetoblack( fadeintime, timeblack, fadeouttime, var_4a1ed931b2d48b58, players, skipaudio = 0 )
{
    infilplayers = players ?? level.players;
    allplayers = level.players.size == infilplayers.size;
    
    if ( allplayers && !isdefined( level.infilblackoverlay ) )
    {
        level.infilblackoverlay = newhudelem();
        setuphudelemninfilblack( level.infilblackoverlay );
    }
    else if ( !allplayers )
    {
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player.infilblackoverlay = newclienthudelem( player );
            setuphudelemninfilblack( player.infilblackoverlay );
        }
    }
    
    if ( fadeintime > 0 )
    {
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !skipaudio )
            {
                player setsoundsubmix( "iw8_br_infil_fadeout", 0 );
                player setsoundsubmix( "mp_br_infil_music", 0 );
            }
            
            if ( !allplayers )
            {
                player.infilblackoverlay.alpha = 0;
                player.infilblackoverlay fadeovertime( fadeintime );
                player.infilblackoverlay.alpha = 1;
            }
        }
        
        if ( allplayers )
        {
            level.infilblackoverlay.alpha = 0;
            level.infilblackoverlay fadeovertime( fadeouttime );
            level.infilblackoverlay.alpha = 1;
        }
        
        wait fadeintime;
    }
    
    if ( allplayers )
    {
        level.infilblackoverlay.alpha = 1;
    }
    
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !skipaudio )
        {
            player setsoundsubmix( "mp_br_infil_anim", 0 );
            player setsoundsubmix( "mp_br_infil_ac130", 0 );
        }
        
        if ( !allplayers )
        {
            player.infilblackoverlay.alpha = 1;
        }
    }
    
    if ( isdefined( var_4a1ed931b2d48b58 ) )
    {
        level waittill( var_4a1ed931b2d48b58 );
    }
    
    if ( timeblack > 0 )
    {
        wait timeblack;
    }
    
    if ( fadeouttime > 0 )
    {
        if ( allplayers )
        {
            level.infilblackoverlay.alpha = 1;
            level.infilblackoverlay fadeovertime( fadeouttime );
            level.infilblackoverlay.alpha = 0;
        }
        
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !skipaudio )
            {
                player setclienttriggeraudiozone( "mp_br_c130_infil_int", fadeouttime );
                player clearsoundsubmix( "iw8_br_infil_fadeout", 2 );
                player notify( #"deaths_door_exit" );
                player damage_effects::function_e8cba6f10a4635e9();
            }
            
            if ( !allplayers )
            {
                player.infilblackoverlay.alpha = 1;
                player.infilblackoverlay fadeovertime( fadeouttime );
                player.infilblackoverlay.alpha = 0;
            }
        }
        
        wait fadeouttime;
    }
    
    if ( allplayers )
    {
        level.infilblackoverlay.alpha = 0;
        return;
    }
    
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.infilblackoverlay ) )
        {
            player.infilblackoverlay destroy();
        }
        
        player.infilblackoverlay = undefined;
    }
}

// Namespace br_infils_legacy
// Params 3
// Checksum 0x2f34669a, Offset: 0x3b84
// Size: 0x3d4
function transitionplayerstoac130cinematic( players, infil_anim_type, c130 )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( c130 ) )
        {
            player.c130 = level.br_ac130;
        }
        
        player utility::hidehudenable();
        
        /#
            if ( player isnoclip() )
            {
                player noclip();
            }
            
            if ( player isufo() )
            {
                player ufo();
            }
        #/
    }
    
    deathicons::removealldeathicons();
    setomnvar( "ui_hide_player_icons", 1 );
    setomnvar( "ui_infil_hide_ui", 1 );
    thread infilallfadetoblack( 1, 1.5, 1, "prematch_respawn_finished", players );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player predictstreamposuntilcleared( c130.origin );
    }
    
    level.infiltransistioning = 1;
    br_infils_util::waitandpause( 1 );
    waitframe();
    br_vehicles::emptyallvehicles();
    setomnvar( "ui_in_infil", 1 );
    flags::gameflagset( "prematch_fade_done" );
    waitforc130andforcespawnallplayers( players );
    level notify( #"prematch_respawn_finished" );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.sessionstate ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        utility::callsharedfunc( #"gametype", #"onplayerteleport", player, player.origin, c130.origin, "c130" );
        player setorigin( c130.origin );
    }
    
    br_infils_util::waitandpause( 1.5 );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearpredictedstreampos();
        player br_infils_util::endprematchskydiving();
        player.br_isininfil = 1;
    }
    
    setomnvar( "ui_infil_hide_ui", 0 );
    
    if ( infil_anim_type == "script_model" )
    {
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player player_utility::function_dbe5a52a6654a982();
            player player_utility::function_9d378d725bb4831e( "br_infils_legacy::transitionPlayersToAC130Cinematic()" );
        }
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x64edb1b8, Offset: 0x3f60
// Size: 0x2c3
function waitforc130andforcespawnallplayers( players )
{
    println( "<dev string:x107>" );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player br_infils_util::endprematchskydiving();
        
        if ( !isalive( player ) )
        {
            player c130forcespawnplayer();
        }
        else
        {
            player.br_infilstarted = 1;
        }
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.br_iseliminated )
        {
            br_utility::unmarkplayeraseliminated( player );
        }
        
        player notify( #"beginC130" );
    }
    
    if ( !br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
    {
        if ( level.teambased )
        {
            foreach ( team in level.teamnamelist )
            {
                squadindices = br_public::function_ec36cf40e2b38aa6( team );
                
                for ( i = 0; i < squadindices.size ; i++ )
                {
                    squadindex = squadindices[ i ];
                    teamplayers = teams::function_d032b36d01bbbab3( team, squadindex );
                    brsquadleader = br_infils_util::setupbrsquadleader( teamplayers );
                    
                    if ( isdefined( brsquadleader ) )
                    {
                        br_infils_util::registerbrsquadleaderjumpcommands( brsquadleader );
                        brsquadleader thread br_infils_util::watchbrsquadleaderdisconnect( team, squadindex );
                    }
                    
                    br::updatesquadleaderpassstateforteam( team, squadindex );
                }
            }
        }
        else
        {
            infilplayers = players ?? level.players;
            
            foreach ( player in infilplayers )
            {
                if ( isdefined( player ) )
                {
                    br_infils_util::registerbrsquadleaderjumpcommands( player );
                }
            }
        }
    }
    
    if ( !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        level.disablespawning = 1;
        level.numlives = 1;
    }
    
    level.snatchspawnalltoc130done = 1;
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xda1eb5b8, Offset: 0x422b
// Size: 0x9a
function c130forcespawnplayer()
{
    self endon( #"disconnect" );
    
    if ( self.team == "codcaster" )
    {
        return;
    }
    
    if ( self.class == "" )
    {
        self.class = "custom1";
        self.pers[ "class" ] = "custom1";
    }
    
    println( "<dev string:x13b>" );
    playerlogic::spawnplayer( 0 );
    self.br_infilstarted = 1;
    self notify( #"hash_36e455a1fbf78b10" );
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xb1aba5fa, Offset: 0x42cd
// Size: 0x10a
function transitionplayersoutofac130cinematic( players, infil_anim_type )
{
    scriptmodeltype = infil_anim_type == "script_model";
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.instantclassswapallowed = 1;
        
        if ( utility::get_int_or_0( player.hidehudenabled ) > 0 )
        {
            player utility::hidehuddisable();
        }
        
        player visionsetfadetoblackforplayer( "", 1 );
        
        if ( scriptmodeltype )
        {
            player player_utility::function_b54a1e23734ef07();
            player player_utility::function_4688d689820ff1ed( "br_infils_legacy::transitionPlayersOutOfAC130Cinematic()" );
        }
    }
    
    setomnvar( "ui_in_infil", -1 );
    level.infiltransistioning = undefined;
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xa1a19b40, Offset: 0x43df
// Size: 0xb4
function clearsoundsubmixmpbrinfilac130( players )
{
    br_infils_util::waitandpause( 7.7 );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "mp_br_infil_ac130", 30 );
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x575db559, Offset: 0x449b
// Size: 0xb4
function clearsoundsubmixmpbrinfilanim( players )
{
    br_infils_util::waitandpause( 0.65 );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "mp_br_infil_anim", 3 );
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x99e11cc7, Offset: 0x4557
// Size: 0xb4
function clearsoundsubmixfadetoblackamb( players )
{
    br_infils_util::waitandpause( 0.5 );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb_br_hack", 1 );
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x270d3af9, Offset: 0x4613
// Size: 0xc5
function setsoundsubmixfadetoblackamb( players )
{
    br_infils_util::waitandpause( 2 );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearsoundsubmix( "solo_cin_igc_music_br_hack", 0.5 );
        player setsoundsubmix( "fade_to_black_all_except_music_scripted5_and_amb_br_hack", 2 );
    }
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xcfb676d5, Offset: 0x46e0
// Size: 0x3c
function playac130infilanim( animstruct, players )
{
    thread setsoundsubmixfadetoblackamb( players );
    playac130animinternal( animstruct, players );
    transitionac130tomovinganim( animstruct, players );
    endac130infilanimsinternal( animstruct, players );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xd59e718d, Offset: 0x4724
// Size: 0x841
function playac130animinternal( animstruct, players )
{
    animstruct endon( #"stopscene" );
    forceindex = undefined;
    
    /#
        forceindex = getdvarint( @"hash_441165c7b355dd1b", -1 );
    #/
    
    if ( animstruct.infil_anim_type == "player" )
    {
        if ( !isdefined( players ) )
        {
            foreach ( team in level.teamnamelist )
            {
                squadindices = br_public::function_ec36cf40e2b38aa6( team );
                
                for ( i = 0; i < squadindices.size ; i++ )
                {
                    squadindex = squadindices[ i ];
                    teamplayers = teams::function_d032b36d01bbbab3( team, squadindex );
                    possibleindices = [ 1, 2, 3, 4 ];
                    
                    foreach ( index, player in teamplayers )
                    {
                        player player_utility::function_dbe5a52a6654a982();
                        player player_utility::function_9d378d725bb4831e( "br_infils_legacy::playAC130AnimInternal() - if" );
                        player.infilanimindex = possibleindices[ index % possibleindices.size ];
                        
                        /#
                            if ( forceindex != -1 )
                            {
                                player.infilanimindex = forceindex;
                            }
                        #/
                        
                        foreach ( otherplayer in teamplayers )
                        {
                            player showtoplayer( otherplayer );
                        }
                    }
                }
            }
        }
        else
        {
            foreach ( player in players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player player_utility::function_dbe5a52a6654a982();
                player player_utility::function_9d378d725bb4831e( "br_infils_legacy::playAC130AnimInternal() - else" );
                player showtoplayer( player );
                player.infilanimindex = 1;
            }
        }
    }
    else
    {
        /#
            animindex = forceindex;
            
            if ( animindex < 0 )
            {
                animindex = 1;
            }
            
            infilplayers = players ?? level.players;
            
            foreach ( player in infilplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player.infilanimindex = animindex;
            }
        #/
    }
    
    var_622106951674a651 = 34;
    var_b665895fd3e1d0e = 5.6;
    var_bff7fddebc5d279a = 50.7;
    var_bbd5243e132f9459 = 2;
    var_a56a973b3b27ad02 = 4;
    
    /#
        var_622106951674a651 = getdvarfloat( @"hash_3f7dc593f9b4e95c", var_622106951674a651 );
        var_b665895fd3e1d0e = getdvarfloat( @"hash_679c9529942a3229", var_b665895fd3e1d0e );
        var_bff7fddebc5d279a = getdvarfloat( @"hash_601d2c6b86673b4", var_bff7fddebc5d279a );
        var_bbd5243e132f9459 = getdvarfloat( @"hash_dda086f6c3d3840f", var_bbd5243e132f9459 );
        var_a56a973b3b27ad02 = getdvarfloat( @"hash_e3dc33638e3c4ed4", var_a56a973b3b27ad02 );
    #/
    
    starttimesec = function_433498e67930440d() ? 12.5 : 0;
    animstruct.cameraent scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_cam", "camera", starttimesec );
    
    if ( isdefined( animstruct.cameraentmoving ) )
    {
        animstruct.cameraentmoving scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_cam", "camera", starttimesec );
    }
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130 stoploopsound();
    }
    
    animstruct.aidoorchief hide();
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setsoundsubmix( "mp_br_infil_anim", 0 );
        player setsoundsubmix( "mp_br_infil_music", 0 );
        player setsoundsubmix( "mp_br_infil_ac130", 0 );
        player setclienttriggeraudiozone( "mp_br_c130_infil_int", 1 );
        animstruct.cameraentlinktag = "j_prop_" + player.infilanimindex;
        player cameraunlink();
        player cameralinkto( animstruct.cameraent, animstruct.cameraentlinktag, 1, 1 );
        player setclientdvar( @"cg_fov", var_622106951674a651 );
        player enablephysicaldepthoffieldscripting();
        player setphysicaldepthoffield( var_b665895fd3e1d0e, var_bff7fddebc5d279a, var_bbd5243e132f9459, var_a56a973b3b27ad02 );
        player player::_freezelookcontrols( 1 );
        animstruct.aidoorchief showtoplayer( player );
    }
    
    thread clearsoundsubmixmpbrinfilanim( players );
    thread getlightingvalues();
    playfxontag( level._effect[ "vfx_br_ac130_clouds" ], animstruct.staticc130, "tag_body" );
    animstruct.staticc130 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_ac130", "plane" );
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_ac130", "plane" );
        animstruct.movingc130.innards scriptmodelplayanim( "sdr_mp_infil_ac130_redux_players_ac130", "planeInnards" );
    }
    
    animstruct.playerpositionents[ "parent" ] scriptmodelplayanim( "sdr_mp_infil_ac130_redux_character_link", "prop" );
    
    if ( animstruct.infil_anim_type == "script_model" )
    {
        animstruct.playerslot1 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player1", "p1" );
        animstruct.playerslot2 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player2", "p2" );
        animstruct.playerslot3 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player3", "p3" );
        animstruct.playerslot4 scriptmodelplayanim( "sdr_mp_infil_ac130_redux_player4", "p4" );
    }
    else if ( animstruct.infil_anim_type == "player" )
    {
        thread playinfilplayeranims( animstruct, players );
    }
    
    animstruct.aidoorchief scriptmodelplayanim( "sdr_mp_infil_ac130_redux_doorchief", "doorchief" );
    level thread offlight( animstruct );
    level thread redlight( animstruct );
    level thread greenlight( animstruct );
    level thread playerwind( animstruct, players );
    level thread cloud_cover( animstruct );
    level thread fade_cover( animstruct );
    level thread infil_light_dvars( animstruct );
    level thread delaystreamtomovingplane( animstruct, players );
    level thread infil_nameplate_display( animstruct );
    
    if ( function_433498e67930440d() )
    {
        animstruct.cameraent waittillmatch( #"camera", #"transition" );
    }
    else
    {
        animstruct.cameraent utility::waittill_match_or_timeout( "camera", "transition", 30 );
    }
    
    animstruct notify( #"infil_reset_light_dvars" );
    level clearplayerwind( animstruct, players );
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xf15da8a8, Offset: 0x4f6d
// Size: 0x88
function infil_nameplate_display( animstruct )
{
    animstruct endon( #"stopscene" );
    animstruct.cameraent waittillmatch( #"camera", #"nameplateon" );
    ui_hide_player_icons = getomnvar( "ui_hide_player_icons" );
    setomnvar( "ui_hide_player_icons", 0 );
    animstruct.cameraent utility::waittill_match_or_timeout( "camera", "nameplateoff", 15 );
    setomnvar( "ui_hide_player_icons", ui_hide_player_icons );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xae8e8f06, Offset: 0x4ffd
// Size: 0x519
function transitionac130tomovinganim( animstruct, players )
{
    var_d7f4f66ec4f5b723 = 65;
    var_7c4200010b100ec = 14;
    var_1d4a14e742bd0714 = 35;
    var_681d9487003a2cef = 2;
    var_7eed1f6046466fe4 = 4;
    
    /#
        var_d7f4f66ec4f5b723 = getdvarfloat( @"hash_f80d61afa659d962", var_d7f4f66ec4f5b723 );
        var_7c4200010b100ec = getdvarfloat( @"hash_91844e25654ff137", var_7c4200010b100ec );
        var_1d4a14e742bd0714 = getdvarfloat( @"hash_12df3e4329486542", var_1d4a14e742bd0714 );
        var_681d9487003a2cef = getdvarfloat( @"hash_a5fccaf38e6c6141", var_681d9487003a2cef );
        var_7eed1f6046466fe4 = getdvarfloat( @"hash_78941d68c2877ae6", var_7eed1f6046466fe4 );
    #/
    
    if ( isdefined( animstruct.cameraentmoving ) )
    {
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setallstreamloaddist( 0 );
            
            if ( !isdefined( player.infilanimindex ) )
            {
                player.infilanimindex = 1;
            }
            
            animstruct.cameraentlinktag = "j_prop_" + player.infilanimindex;
            player cameraunlink();
            player cameralinkto( animstruct.cameraentmoving, animstruct.cameraentlinktag, 1, 1 );
            player setclientdvar( @"cg_fov", var_d7f4f66ec4f5b723 );
            player setphysicaldepthoffield( var_7c4200010b100ec, var_1d4a14e742bd0714, var_681d9487003a2cef, var_7eed1f6046466fe4 );
            player notify( #"infil_move" );
        }
        
        thread clearsoundsubmixfadetoblackamb( players );
    }
    else
    {
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setallstreamloaddist( 0 );
        }
    }
    
    if ( isdefined( animstruct.cloudanimfx ) )
    {
        if ( isdefined( animstruct.movingc130 ) )
        {
            animstruct.cloudanimfx.origin = animstruct.movingc130.origin;
        }
    }
    
    animstruct.staticc130 hide();
    animstruct.cameraent unlink();
    animstruct.playerpositionents[ "parent" ] unlink();
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.playerpositionents[ "parent" ] linkto( animstruct.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.cameraent linkto( animstruct.movingc130, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        animstruct.movingc130 notify( #"start_moving" );
    }
    
    setomnvar( "ui_hide_player_icons", 0 );
    setomnvar( "ui_in_infil", 2 );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclienttriggeraudiozone( "mp_br_c130_infil_ext", 2 );
    }
    
    thread clearsoundsubmixmpbrinfilac130( players );
    
    if ( animstruct.infil_anim_type == "script_model" )
    {
        animstruct.playerslot1 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl01", "p1" );
        animstruct.playerslot2 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl02", "p2" );
        animstruct.playerslot3 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl03", "p3" );
        animstruct.playerslot4 scriptmodelplayanim( "sdr_mp_infil_ac130_loop_pl04", "p4" );
    }
    
    animstruct.aidoorchief scriptmodelplayanim( "sdr_mp_infil_ac130_loop_doorchief", "doorchief" );
    level thread playac130infilloopanims( animstruct );
    
    if ( isdefined( animstruct.cameraentmoving ) )
    {
        animstruct.cameraentmoving waittillmatch( #"camera", #"end" );
    }
    
    /#
    #/
    
    thread unfreezeplayercontrols( 1.2, players );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0x948d6ee, Offset: 0x551e
// Size: 0xad
function unfreezeplayercontrols( delaytime, players )
{
    wait delaytime;
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player player::_freezelookcontrols( 0 );
    }
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xd968deeb, Offset: 0x55d3
// Size: 0x13f
function endac130infilanimsinternal( animstruct, players )
{
    thread lightsreset();
    stopfxontag( level._effect[ "vfx_br_ac130_clouds" ], animstruct.staticc130, "tag_body" );
    animstruct.staticc130 stoploopsound();
    
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130 playloopsound( "br_ac130_lp" );
    }
    
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setallstreamloaddist( 0 );
        player cameraunlink();
        player setclientdvar( @"cg_fov", 65 );
        player disablephysicaldepthoffieldscripting();
        player player::setdof_default();
    }
    
    level thread stopstreamtomovingplane( animstruct, players );
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x9be2fb92, Offset: 0x571a
// Size: 0x79
function playac130infilloopanims( animstruct )
{
    if ( isdefined( animstruct.movingc130 ) )
    {
        animstruct.movingc130 scriptmodelplayanim( "sdr_mp_infil_ac130_loop2_plane", "plane" );
        animstruct.movingc130.innards scriptmodelplayanim( "sdr_mp_infil_ac130_loop2_plane", "planeInnards" );
    }
    
    animstruct.playerpositionents[ "parent" ] scriptmodelplayanim( "sdr_mp_infil_ac130_loop_genpropx10", "prop" );
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x8d7a8197, Offset: 0x579b
// Size: 0xa4
function offlight( animstruct )
{
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_off_hold", 1 );
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xd049e4d, Offset: 0x5847
// Size: 0xd3
function redlight( animstruct )
{
    animstruct endon( #"stopscene" );
    animstruct.staticc130 waittillmatch( #"plane", #"gored" );
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_on", 1 );
    }
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0x42968568, Offset: 0x5922
// Size: 0xd3
function greenlight( animstruct )
{
    animstruct endon( #"stopscene" );
    animstruct.staticc130 waittillmatch( #"plane", #"gogreen" );
    lightcontrollers = getentitylessscriptablearray( "infil_blinking_light", #script_noteworthy );
    
    foreach ( lightcontroller in lightcontrollers )
    {
        lightcontroller setscriptablepartstate( "light_blinking_slow", "light_jump", 1 );
    }
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xac361e7, Offset: 0x59fd
// Size: 0x109
function playerwind( animstruct, players )
{
    if ( function_433498e67930440d() )
    {
        return;
    }
    
    animstruct endon( #"stopscene" );
    animstruct.staticc130 utility::waittill_match_or_timeout( "plane", "opendoor", 30 );
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player player::setwind( "100", 1 );
    }
    
    animstruct.aidoorchief player::setwind( "100" );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xc587489, Offset: 0x5b0e
// Size: 0xd0
function clearplayerwind( animstruct, players )
{
    infilplayers = players ?? level.players;
    
    foreach ( player in infilplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player player::setwind( "1" );
        player.manualoverridewindmaterial = undefined;
    }
    
    animstruct.aidoorchief player::setwind( "0" );
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xef9cef29, Offset: 0x5be6
// Size: 0x4b
function cloud_cover( animstruct )
{
    animstruct endon( #"stopscene" );
    animstruct.staticc130 waittillmatch( #"plane", #"transitionstart" );
    triggerfx( animstruct.cloudanimfx );
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xb14cc1e2, Offset: 0x5c39
// Size: 0x183
function fade_cover( animstruct )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( animstruct.cameraentmoving ) )
    {
        return;
    }
    
    overlay = newhudelem();
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( "white", 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.sort = -1;
    overlay.color = ( 0.5, 0.5, 0.5 );
    overlay.alpha = 0;
    fadeintime = 0.16;
    fadeouttime = 0.5;
    animstruct.cameraentmoving waittillmatch( #"camera", #"fadeinstart" );
    overlay fadeovertime( fadeintime );
    overlay.alpha = 0.8;
    animstruct.cameraentmoving waittillmatch( #"camera", #"fadeoutstart" );
    overlay fadeovertime( fadeouttime );
    overlay.alpha = 0;
    br_infils_util::waitandpause( fadeouttime + 0.1 );
    overlay destroy();
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xf349dedd, Offset: 0x5dc4
// Size: 0x1f
function infil_light_dvars( animstruct )
{
    animstruct utility::waittill_any( "infil_reset_light_dvars", "stopScene" );
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0xb68ac834, Offset: 0x5deb
// Size: 0x174
function delaystreamtomovingplane( animstruct, players )
{
    if ( isdefined( animstruct.movingc130 ) && getdvarint( @"hash_eb8a05afa7735e5f", 1 ) == 1 )
    {
        delaytime = getdvarint( @"hash_d01d0472d843d39e", 8 );
        wait delaytime;
        streamorigin = animstruct.movingc130.origin;
        forward = getdvarint( @"hash_7abcda2d7aabbe4c", 0 );
        
        if ( forward > 0 )
        {
            dir = anglestoforward( animstruct.movingc130.angles );
            streamorigin = animstruct.movingc130.origin + dir * forward;
        }
        
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setpredictedstreamloaddist( 0 );
            player streamhint::playerstreamhintlocation( streamorigin );
        }
    }
}

// Namespace br_infils_legacy
// Params 2
// Checksum 0x8a9129a9, Offset: 0x5f67
// Size: 0xea
function stopstreamtomovingplane( animstruct, players )
{
    if ( isdefined( animstruct.movingc130 ) && getdvarint( @"hash_eb8a05afa7735e5f", 1 ) == 1 )
    {
        delaytime = getdvarint( @"hash_b7c6d487b0f5506b", 5 );
        wait delaytime;
        infilplayers = players ?? level.players;
        
        foreach ( player in infilplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player thread br_public::playerclearstreamhintorigin();
        }
    }
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0x4ff64dd0, Offset: 0x6059
// Size: 0x2
function getlightingvalues()
{
    
}

// Namespace br_infils_legacy
// Params 0
// Checksum 0xa32227a3, Offset: 0x6063
// Size: 0x2
function lightsreset()
{
    
}

/#

    // Namespace br_infils_legacy
    // Params 1
    // Checksum 0xa3c4a079, Offset: 0x606d
    // Size: 0x123, Type: dev
    function function_c6060a10501b41d5( infil_anim_type )
    {
        level.infil_vignette_anim_type = infil_anim_type;
        var_cd57efba29852a12 = spawn( "<dev string:x161>", getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) ) );
        var_cd57efba29852a12 setmodel( "<dev string:x16e>" );
        var_cd57efba29852a12.cleanme = 1;
        var_cd57efba29852a12.innards = spawn( "<dev string:x161>", getdvarvector( @"br_infil_anim_pos", ( 0, 0, 0 ) ) );
        var_cd57efba29852a12.innards setmodel( "<dev string:x196>" );
        var_cd57efba29852a12.innards linkto( var_cd57efba29852a12, "<dev string:x1bb>" );
        var_cd57efba29852a12.innards.cleanme = 1;
        planestruct = buildac130infilanimstruct( var_cd57efba29852a12, infil_anim_type );
        transitionplayerstoac130cinematic( level.players, infil_anim_type, var_cd57efba29852a12 );
        playac130infilanim( planestruct );
        transitionplayersoutofac130cinematic( level.players, infil_anim_type );
        br_public::cleanac130struct( planestruct );
        return planestruct;
    }

#/

// Namespace br_infils_legacy
// Params 4
// Checksum 0x209e38f7, Offset: 0x6198
// Size: 0x4d
function movetowithpause( point, time, accel, decel )
{
    /#
        if ( br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            thread movetopause( point, time, accel, decel );
            return;
        }
    #/
    
    self moveto( point, time, accel, decel );
}

// Namespace br_infils_legacy
// Params 4
// Checksum 0xa4d5c1d4, Offset: 0x61ed
// Size: 0x4d
function rotatetowithpause( angles, time, accel, decel )
{
    /#
        if ( br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            thread rotatetopause( angles, time, accel, decel );
            return;
        }
    #/
    
    self rotateto( angles, time, accel, decel );
}

/#

    // Namespace br_infils_legacy
    // Params 1
    // Checksum 0x5862f8db, Offset: 0x6242
    // Size: 0x1a5, Type: dev
    function function_777f6ef596fa01bf( host )
    {
        animstruct = buildac130infilanimstruct( undefined, "<dev string:x161>" );
        models = [ animstruct.cameraent, animstruct.staticc130, animstruct.playerpositionents[ "<dev string:x1bc>" ], animstruct.playerslot1, animstruct.playerslot2, animstruct.playerslot3, animstruct.playerslot4, animstruct.aidoorchief ];
        models = function_5713d46873b29625( models );
        
        while ( br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            function_279bb000a13d6ee6( host, "<dev string:x1c3>" );
            
            if ( !br_infils_util::function_6f01e2b77b9b7e5c() )
            {
                break;
            }
            
            startorigin = host.origin;
            startangles = host getplayerangles();
            animstruct.staticc130 show();
            animstruct.cameraentlinktag = undefined;
            startanimsequence( host, animstruct, models );
            transitionplayerstoac130cinematic( [ host ], "<dev string:x161>", animstruct.staticc130 );
            thread playac130animinternal( animstruct );
            function_279bb000a13d6ee6( host, "<dev string:x1ce>" );
            endanimsequence( host, animstruct, models );
            endac130infilanimsinternal( animstruct );
            transitionplayersoutofac130cinematic( [ host ], "<dev string:x161>" );
            host setorigin( startorigin );
            host setplayerangles( startangles );
            wait 0.5;
        }
        
        br_public::cleanac130struct( animstruct );
    }

    // Namespace br_infils_legacy
    // Params 3
    // Checksum 0x88d14914, Offset: 0x63ef
    // Size: 0x40, Type: dev
    function startanimsequence( player, animstruct, models )
    {
        level.var_e9752d5557df31ee = 0;
        thread pauseanims( player, models, animstruct );
        thread function_e1fea13d32d736ec( player, animstruct );
    }

    // Namespace br_infils_legacy
    // Params 3
    // Checksum 0x3c4afbd1, Offset: 0x6437
    // Size: 0xa8, Type: dev
    function endanimsequence( player, animstruct, models )
    {
        level.var_e9752d5557df31ee = undefined;
        animstruct notify( #"stopscene" );
        
        foreach ( model in models )
        {
            model scriptmodelclearanim();
        }
    }

    // Namespace br_infils_legacy
    // Params 2
    // Checksum 0x5771b8ee, Offset: 0x64e7
    // Size: 0x49, Type: dev
    function function_279bb000a13d6ee6( player, buttonstring )
    {
        while ( player buttonpressed( buttonstring ) && br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            waitframe();
        }
        
        while ( !player buttonpressed( buttonstring ) && br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            waitframe();
        }
    }

    // Namespace br_infils_legacy
    // Params 3
    // Checksum 0x873dfb64, Offset: 0x6538
    // Size: 0x16e, Type: dev
    function pauseanims( player, models, animstruct )
    {
        animstruct endon( #"stopscene" );
        
        while ( true )
        {
            level.var_e9752d5557df31ee = 0;
            
            while ( player buttonpressed( "<dev string:x1c3>" ) )
            {
                waitframe();
            }
            
            while ( !player buttonpressed( "<dev string:x1c3>" ) )
            {
                waitframe();
            }
            
            foreach ( model in models )
            {
                model scriptmodelpauseanim( 1 );
            }
            
            level.var_e9752d5557df31ee = 1;
            
            while ( player buttonpressed( "<dev string:x1c3>" ) )
            {
                waitframe();
            }
            
            while ( !player buttonpressed( "<dev string:x1c3>" ) )
            {
                waitframe();
            }
            
            foreach ( model in models )
            {
                model scriptmodelpauseanim( 0 );
            }
        }
    }

    // Namespace br_infils_legacy
    // Params 2
    // Checksum 0x6fd87248, Offset: 0x66ae
    // Size: 0x193, Type: dev
    function function_e1fea13d32d736ec( player, animstruct )
    {
        animstruct endon( #"stopscene" );
        assert( isdefined( animstruct.cameraent ) );
        
        while ( true )
        {
            while ( !player buttonpressed( "<dev string:x1d8>" ) || !isdefined( animstruct.cameraentlinktag ) )
            {
                waitframe();
            }
            
            player player_utility::function_b54a1e23734ef07();
            player player_utility::function_4688d689820ff1ed( "<dev string:x1e0>" );
            player cameraunlink();
            player disablephysicaldepthoffieldscripting();
            player player::_freezelookcontrols( 0 );
            org = animstruct.cameraent gettagorigin( animstruct.cameraentlinktag ) + ( 0, 0, -60 );
            angles = animstruct.cameraent gettagangles( animstruct.cameraentlinktag );
            player setorigin( org );
            player setplayerangles( angles );
            
            if ( !player isufo() )
            {
                player ufo();
            }
            
            while ( player buttonpressed( "<dev string:x1d8>" ) )
            {
                waitframe();
            }
            
            while ( !player buttonpressed( "<dev string:x1d8>" ) )
            {
                waitframe();
            }
            
            if ( player isufo() )
            {
                player ufo();
            }
            
            player cameralinkto( animstruct.cameraent, animstruct.cameraentlinktag, 1, 1 );
            player player_utility::function_dbe5a52a6654a982();
            player player_utility::function_9d378d725bb4831e( "<dev string:x1e0>" );
            player enablephysicaldepthoffieldscripting();
            
            while ( player buttonpressed( "<dev string:x1d8>" ) )
            {
                waitframe();
            }
        }
    }

    // Namespace br_infils_legacy
    // Params 4, eflags: 0x40 variadic
    // Checksum 0x7a2b6fc6, Offset: 0x6849
    // Size: 0x50, Type: dev
    function function_3fba43cde63bae3a( func, timer, ... )
    {
        self endon( #"disconnect" );
        self endon( #"death" );
        delaycall_procpause( func, timer, flat_args( vararg, varargcount ) );
    }

    // Namespace br_infils_legacy
    // Params 4, eflags: 0x40 variadic
    // Checksum 0x27490003, Offset: 0x68a1
    // Size: 0x3d, Type: dev
    function delaycall_procpause( func, timer, ... )
    {
        br_infils_util::waitandpause( timer );
        self builtin [[ func ]]( flat_args( vararg, varargcount ) );
    }

    // Namespace br_infils_legacy
    // Params 4
    // Checksum 0xf3345656, Offset: 0x68e6
    // Size: 0x8a, Type: dev
    function movetopause( point, timesec, accel, decel )
    {
        self moveto( point, timesec, accel, decel );
        
        while ( timesec > 0 )
        {
            waitframe();
            
            if ( level.var_e9752d5557df31ee )
            {
                self moveto( self.origin, timesec, accel, decel );
                
                while ( level.var_e9752d5557df31ee )
                {
                    waitframe();
                }
                
                self moveto( point, timesec, accel, decel );
            }
            
            timesec -= level.framedurationseconds;
        }
    }

    // Namespace br_infils_legacy
    // Params 4
    // Checksum 0xedf22d5d, Offset: 0x6978
    // Size: 0x8a, Type: dev
    function rotatetopause( angles, timesec, accel, decel )
    {
        self rotateto( angles, timesec, accel, decel );
        
        while ( timesec > 0 )
        {
            waitframe();
            
            if ( level.var_e9752d5557df31ee )
            {
                self rotateto( self.angles, timesec, accel, decel );
                
                while ( level.var_e9752d5557df31ee )
                {
                    waitframe();
                }
                
                self rotateto( angles, timesec, accel, decel );
            }
            
            timesec -= level.framedurationseconds;
        }
    }

    // Namespace br_infils_legacy
    // Params 1
    // Checksum 0xf0b32fef, Offset: 0x6a0a
    // Size: 0x2dd, Type: dev
    function function_b1d6c2f045a7a342( animstruct )
    {
        entaxis = anglestoaxis( animstruct.movingc130.angles );
        entright = -1 * entaxis[ "<dev string:x202>" ];
        entup = entaxis[ "<dev string:x208>" ];
        
        foreach ( player in level.players )
        {
            slotnumber = player.infilanimindex - 1;
            prop_name = "<dev string:x20b>" + player.infilanimindex;
            cameraorigin = animstruct.cameraentmoving gettagorigin( prop_name );
            cameraangles = animstruct.cameraentmoving gettagangles( prop_name );
            baseorigin = player getvieworigin();
            rayorigin = cameraorigin;
            raydir = anglestoforward( cameraangles );
            planenormal = ( raydir[ 0 ] * -1, raydir[ 1 ] * -1, 0 );
            planenormal = vectornormalize( planenormal );
            denominator = vectordot( planenormal, raydir );
            difference = baseorigin - rayorigin;
            t = vectordot( difference, planenormal ) / denominator;
            result = rayorigin + t * raydir;
            offset = result - baseorigin;
            println( "<dev string:x213>" + slotnumber + "<dev string:x22d>" + offset[ 0 ] + "<dev string:x230>" + offset[ 1 ] + "<dev string:x230>" + offset[ 2 ] + "<dev string:x232>" );
            entorigin = baseorigin + entright * offset[ 0 ] + entup * offset[ 2 ];
            cameradistance = distance( cameraorigin, entorigin );
            var_a2b8bd65a8f16f39 = entorigin - cameraorigin;
            var_a2b8bd65a8f16f39 = vectornormalize( var_a2b8bd65a8f16f39 );
            var_ee5bfd5117ac7406 = vectordot( raydir, var_a2b8bd65a8f16f39 );
            println( "<dev string:x234>" + slotnumber + "<dev string:x24d>" + cameradistance + "<dev string:x25a>" + var_ee5bfd5117ac7406 + "<dev string:x232>" );
            var_124e75d9a55f7416 = cameraorigin - entorigin;
            var_cb9911ecd63f33a6 = length( var_124e75d9a55f7416 );
            var_a12f6f2f2ef29484 = acos( var_124e75d9a55f7416[ 2 ] / var_cb9911ecd63f33a6 );
            println( "<dev string:x262>" + slotnumber + "<dev string:x27e>" + var_cb9911ecd63f33a6 + "<dev string:x288>" + var_a12f6f2f2ef29484 + "<dev string:x232>" );
        }
    }

#/

// Namespace br_infils_legacy
// Params 0
// Checksum 0xc272179b, Offset: 0x6cef
// Size: 0xaf
function headlessinfils()
{
    dist = distance( level.br_ac130.pathstruct.startpt, level.br_ac130.pathstruct.endpt );
    time = dist / br_c130::getc130speed() / level.headlessinfilplayers.size;
    
    for ( i = 0; i < level.headlessinfilplayers.size ; i++ )
    {
        wait time;
        level.headlessinfilplayers[ i ] notify( #"halo_jump_c130" );
    }
    
    level.headlessinfilplayers = undefined;
}

// Namespace br_infils_legacy
// Params 1
// Checksum 0xd0ee9499, Offset: 0x6da6
// Size: 0x39
function registerheadlessinfil( player )
{
    if ( !isdefined( level.headlessinfilplayers ) )
    {
        level.headlessinfilplayers = [];
    }
    
    level.headlessinfilplayers[ level.headlessinfilplayers.size ] = player;
}

