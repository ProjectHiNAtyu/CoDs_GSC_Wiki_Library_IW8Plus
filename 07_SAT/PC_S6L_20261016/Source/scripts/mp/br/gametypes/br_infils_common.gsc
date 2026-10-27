// scripts\mp\br\gametypes\br_infils_common.gsc  (hash_01d39a5cfaa26c5f.gscc) (size: 45806 Bytes / 0xb2ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37592664 (928589412)
// size ...... 45806 (0xb2ee)
// includes .. 43  (offset: 0xaa52)
// strings ... 102 (offset: 0xabaa)
// dev strs .. 25  (offset: 0xb176)
// exports ... 99  (offset: 0x6eea)
// cseg ...... 0x7c2 + 0x6728 (0x6eea)
// imports ... 352 (offset: 0x7e62)
// animtree1 . 0   (offset: 0xb2ee)
// animtree2 . 0   (offset: 0xb2ee)
#using script_213aa5354290e47d;
#using script_23eca243497ca70a;
#using script_26ccbfe3954cacf4;
#using script_53b7545c53ce9f5a;
#using scripts\common\notetrack;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_infils_ac130;
#using scripts\mp\br\gametypes\br_infils_ac130_short;
#using scripts\mp\br\gametypes\br_infils_ac130_v0;
#using scripts\mp\br\gametypes\br_infils_chopper;
#using scripts\mp\br\gametypes\br_infils_legacy;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\class;
#using scripts\mp\common\equipment\combataxe;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\equipment\thermite;
#using scripts\mp\common\equipment\throwing_knife;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\deathicons;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\meatshield;
#using scripts\mp\music_br;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\weapons;

#namespace br_infils_common;

// Namespace br_infils_common
// Params 0, eflags: 0x5
// Checksum 0x24267b5e, Offset: 0x7e0
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"br_infils_common", undefined, &pre_main, &post_main );
}

// Namespace br_infils_common
// Params 0
// Checksum 0xa80f5946, Offset: 0x805
// Size: 0x15
function pre_main()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    level.br_infil_funcs = [];
}

// Namespace br_infils_common
// Params 2
// Checksum 0xdb259089, Offset: 0x822
// Size: 0x54
function register_infil( name, init_func )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    assert( isdefined( level.br_infil_funcs ) );
    assert( !isdefined( level.br_infil_funcs[ name ] ) );
    level.br_infil_funcs[ name ] = init_func;
}

// Namespace br_infils_common
// Params 0
// Checksum 0xf45655da, Offset: 0x87e
// Size: 0x12a
function post_main()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 )
    {
        return;
    }
    
    if ( !isbrgamemode() || level.istrainingcourse )
    {
        return;
    }
    
    br_infils_legacy::init();
    
    if ( br_infils_legacy::function_bb14cfd60cc8058() )
    {
        return;
    }
    
    assert( !isdefined( level.infilstruct ) );
    level.infilstruct = { #players:[] };
    register_state( 0, "prematch", &state_prematch, "infil_prematch" );
    register_state( 1, "fadedown", &state_fadedown, "infil_fadedown" );
    register_state( 2, "streaming", &state_streaming, "infil_streaming" );
    register_state( 3, "cinematic", &state_cinematic, "infil_cinematic" );
    register_state( 4, "animatic", &state_animatic, "infil_animatic" );
    register_state( 5, "flyover", &state_flyover, "infil_flyover" );
    register_state( 6, "done", &state_done, "infil_done" );
    function_daaef2ba44d450df();
    function_ced01d2fc0a3dec2();
    level thread run_state_machine();
    
    /#
        thread testdvarloop();
    #/
}

// Namespace br_infils_common
// Params 0
// Checksum 0x121ea841, Offset: 0x9b0
// Size: 0x79
function run_state_machine()
{
    level endon( #"game_ended" );
    level endon( #"kill_state_machine" );
    level.infilcurrentstate = undefined;
    waitframe();
    startstate = 0;
    
    while ( true )
    {
        if ( !isdefined( level.infilcurrentstate ) )
        {
            set_state( startstate );
        }
        else
        {
            set_state( level.infilcurrentstate + 1 );
        }
        
        if ( level.infilcurrentstate == 6 )
        {
            break;
        }
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x3898aef8, Offset: 0xa31
// Size: 0xe
function private kill_state_machine()
{
    level notify( #"kill_state_machine" );
}

// Namespace br_infils_common
// Params 4
// Checksum 0x92138d22, Offset: 0xa47
// Size: 0x8f
function register_state( statenum, statename, statefunc, statenotify )
{
    if ( !isdefined( level.infilstates ) )
    {
        level.infilstates = [];
    }
    
    assert( !isdefined( level.infilstates[ statenum ] ) );
    newstate = { #statenotify:statenotify, #statefunc:statefunc, #name:statename };
    level.infilstates[ statenum ] = newstate;
}

// Namespace br_infils_common
// Params 1
// Checksum 0x76fa28d5, Offset: 0xade
// Size: 0xa6
function set_state( statenum )
{
    level.infilcurrentstate = statenum;
    newstatedata = level.infilstates[ level.infilcurrentstate ];
    level notify( newstatedata.statenotify );
    
    if ( isdefined( level.infilstruct.statecallbacks[ newstatedata.name ] ) )
    {
        [[ level.infilstruct.statecallbacks[ newstatedata.name ] ]]();
    }
    
    if ( isdefined( newstatedata.statefunc ) )
    {
        [[ newstatedata.statefunc ]]();
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0xe5f985a7, Offset: 0xb8c
// Size: 0x2b7
function state_prematch()
{
    c130pathstruct = undefined;
    
    if ( !level.br_infils_disabled && !level.var_32cd3f9427fdc5d9 )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"createc130pathstruct" ) )
        {
            c130pathstruct = utility::callsharedfunc( #"gametype", #"createc130pathstruct" );
        }
        else
        {
            c130pathstruct = br_c130::createtestc130path( level.var_fbd5de3a03b0c767, undefined );
        }
    }
    
    level.infilstruct.c130pathstruct = c130pathstruct;
    
    if ( getdvarint( @"hash_602981760e1c923d", 1 ) )
    {
        if ( !level.skipprematch && !level.prematchstarted )
        {
            level waittill( #"start_prematch" );
        }
        
        if ( isdefined( level.infilstruct.var_e3fb172254c8751 ) )
        {
            [[ level.infilstruct.var_e3fb172254c8751 ]]();
            br_infils_util::function_fffda20dc2c2df07( &function_10ba4f99309da0d0 );
            thread function_7fd63b8aa5976005();
        }
    }
    
    if ( !level.prematchstarted )
    {
        level waittill( #"hash_771f437aff8cc0dd" );
    }
    
    if ( level.br_infils_disabled )
    {
        level.infilstruct.players = br_utility::function_1304786bb742a29c();
        flags::gameflagset( "prematch_fade_done" );
        waitframe();
        level.allowprematchdamage = 0;
        
        if ( !level.skipprematch )
        {
            forcespawnplayers( level.infilstruct.players );
        }
        
        function_fef7342ce0e19a47();
        
        if ( !br_gametypes::isfeaturedisabled( #"onelife" ) )
        {
            level.disablespawning = 1;
            level.numlives = 1;
        }
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player.plotarmor = undefined;
            
            /#
                if ( level.var_29dfd9d7916ace30 )
                {
                    player thread br::givestandardtableloadout( 0, 1 );
                }
            #/
        }
        
        flags::gameflagset( "br_ready_to_jump" );
        kill_state_machine();
        return;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"infilsequence" ) )
    {
        utility::callsharedfunc( #"gametype", #"infilsequence" );
        flags::gameflagset( "br_ready_to_jump" );
        kill_state_machine();
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0x9b990803, Offset: 0xe4b
// Size: 0x53
function function_10ba4f99309da0d0()
{
    if ( isdefined( level.infilstruct.var_12c03eae53e9bb4c ) )
    {
        self [[ level.infilstruct.var_12c03eae53e9bb4c ]]();
    }
    else
    {
        self setallstreamloaddist( 0 );
    }
    
    self predictstreamposuntilcleared( level.infilstruct.prestreamorigin );
}

// Namespace br_infils_common
// Params 0
// Checksum 0x31a35d4a, Offset: 0xea6
// Size: 0xe3
function function_7fd63b8aa5976005()
{
    while ( true )
    {
        if ( level.infilcurrentstate > 3 )
        {
            break;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( level.infilstruct.var_12c03eae53e9bb4c ) )
            {
                player [[ level.infilstruct.var_12c03eae53e9bb4c ]]();
            }
            else
            {
                player setallstreamloaddist( 0 );
            }
            
            player predictstreamposuntilcleared( level.infilstruct.prestreamorigin );
        }
        
        wait 10;
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0xc5ecede2, Offset: 0xf91
// Size: 0x404
function state_fadedown()
{
    if ( isdefined( level.codcasters ) )
    {
        foreach ( codcaster in level.codcasters )
        {
            codcaster setclientomnvar( "ui_br_infil_started", 1 );
            codcaster setclientomnvar( "ui_br_infiled", 0 );
        }
    }
    
    if ( isdefined( level.skip_death_vo ) )
    {
        level.skip_death_vo = undefined;
    }
    
    assert( isdefined( level.infilstruct.c130pathstruct ) );
    br_c130::spawnc130( level.infilstruct.c130model, level.infilstruct.var_f265685cdcfee833, level.infilstruct.var_9d24745d02be135e, level.infilstruct.var_67c8deee3845395d, level.infilstruct.c130pathstruct, level.infilstruct.var_3ebd56e1708e1387, level.infilstruct.c130soundalias );
    assert( isdefined( level.br_ac130 ) );
    level.infilstruct.c130 = level.br_ac130;
    level.infilstruct.players = br_utility::function_1304786bb742a29c();
    
    if ( manager::function_a0e7b7d42c9dbf4b() )
    {
        manager::function_89073acfbf418766( level.infilstruct.players );
    }
    
    /#
        if ( function_35c1b8c3a14fd328() )
        {
            level.infilstruct.players = arrayremove( level.infilstruct.players, level.player );
        }
    #/
    
    function_ee08fadf2a691598();
    
    if ( level.var_8f64d94451f73542 && isdefined( level.infilstruct.prestream_scenesystem ) )
    {
        [[ level.infilstruct.prestream_scenesystem ]]( level.infilstruct.c130.animstruct );
    }
    
    deathicons::removealldeathicons();
    setomnvar( "ui_hide_player_icons", 1 );
    setomnvar( "ui_infil_hide_ui", 1 );
    level.br_c130spawndone = 0;
    level.infiltransistioning = 1;
    level.infilcinematicactive = 1;
    level.allowprematchdamage = 0;
    level.freefallstartcb = &br::freefallstartfunc;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_57a2d0c37e17457e();
    }
    
    br_infils_util::function_fffda20dc2c2df07( &function_df49a2ed87f3c40e );
    level.infilstruct.c130 thread gunship_updateplayercount();
    br_infils_util::waitandpause( 1 );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_72ef25f9bcb7da6c();
    }
    
    br_infils_util::function_fffda20dc2c2df07( &function_27498f675f37f2b0 );
    waitframe();
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x3cdb8dea, Offset: 0x139d
// Size: 0x130
function private function_57a2d0c37e17457e()
{
    if ( level.var_8f64d94451f73542 )
    {
        self predictstreamposuntilcleared( level.infilstruct.var_eebe498248baa141 );
    }
    else if ( isdefined( level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7 ) )
    {
        self predictstreamposuntilcleared( level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7.origin );
    }
    else if ( function_817017b08b045a91() == "hq_ac130_v2" )
    {
        self predictstreamposuntilcleared( level.infilstruct.c130.animstruct.origin );
    }
    else
    {
        self predictstreamposuntilcleared( level.infilstruct.c130.origin );
    }
    
    function_7e0010cfd9c634c6( level.infilstruct.c130 );
    function_396db998e7e074b0();
    br_infils_util::function_d36ff11e6bc121f6( 1, "stateMachine" );
    self setclientdvar( @"voice_proximity_enemy_client", 0 );
}

// Namespace br_infils_common
// Params 0
// Checksum 0x46c86771, Offset: 0x14d5
// Size: 0x1f
function function_df49a2ed87f3c40e()
{
    self endon( #"disconnect" );
    function_57a2d0c37e17457e();
    br_infils_util::waitandpause( 1 );
    waitframe();
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x21b931d8, Offset: 0x14fc
// Size: 0x3e
function private function_72ef25f9bcb7da6c()
{
    if ( isdefined( level.infilstruct.var_12c03eae53e9bb4c ) )
    {
        self [[ level.infilstruct.var_12c03eae53e9bb4c ]]();
        return;
    }
    
    self setallstreamloaddist( -1 );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x863370a8, Offset: 0x1542
// Size: 0x15
function private function_27498f675f37f2b0()
{
    self endon( #"disconnect" );
    function_72ef25f9bcb7da6c();
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0x3a4d760, Offset: 0x155f
// Size: 0x4b
function private function_7e0010cfd9c634c6( c130 )
{
    self.c130 = c130;
    utility::hidehudenable();
    class::blockclasschange();
    br::setplayerprematchallows();
    
    /#
        if ( self isnoclip() )
        {
            self noclip();
        }
        
        if ( self isufo() )
        {
            self ufo();
        }
    #/
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x7e76316c, Offset: 0x15b2
// Size: 0x6f
function private gunship_updateplayercount()
{
    level endon( #"game_ended" );
    self notify( #"hash_dfb177465a3238bd" );
    self endon( #"hash_dfb177465a3238bd" );
    level.infilstruct.playersinc130 = 0;
    
    while ( true )
    {
        setomnvar( "ui_br_players_left_in_plane", level.infilstruct.playersinc130 );
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        wait 0.5;
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0xc887a559, Offset: 0x1629
// Size: 0x2cc
function state_streaming()
{
    br_vehicles::emptyallvehicles();
    flags::gameflagset( "prematch_fade_done" );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_open_menu_from_script", -1 );
    }
    
    teleportorigin = level.infilstruct.c130.origin;
    var_33becf5e32e7b2ba = level.infilstruct.c130;
    
    if ( isdefined( level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7 ) )
    {
        teleportorigin = level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7.origin;
        var_33becf5e32e7b2ba = level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7;
    }
    
    forcespawnplayers( level.infilstruct.players, teleportorigin, var_33becf5e32e7b2ba );
    br_infils_util::function_fffda20dc2c2df07( &function_8ca85693ea2d4a98 );
    level.snatchspawnalltoc130done = 1;
    function_fef7342ce0e19a47();
    
    if ( !br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        level.disablespawning = 1;
        level.numlives = 1;
    }
    
    br_infils_util::waitandpause( getdvarfloat( @"hash_669c21dc4d23066d", 3 ) );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !level.infilstruct.var_cfd89587fdc657ad )
        {
            player clearpredictedstreampos();
        }
        
        player br_infils_util::endprematchskydiving();
        player.br_isininfil = 1;
    }
    
    setomnvar( "ui_infil_hide_ui", 0 );
    br_infils_util::refreshteamvisibility( level.infilstruct.players );
    br_infils_util::function_fffda20dc2c2df07( &function_f14f7f4bdcdee51e );
}

// Namespace br_infils_common
// Params 0
// Checksum 0x8b438fa7, Offset: 0x18fd
// Size: 0xf2
function function_8ca85693ea2d4a98()
{
    self endon( #"disconnect" );
    teleportorigin = level.infilstruct.c130.origin;
    var_33becf5e32e7b2ba = level.infilstruct.c130;
    
    if ( isdefined( level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7 ) )
    {
        teleportorigin = level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7.origin;
        var_33becf5e32e7b2ba = level.infilstruct.c130.animstruct.var_b6e5f06b0c65a1d7;
    }
    
    forcespawnplayers( [ self ], teleportorigin, var_33becf5e32e7b2ba );
    function_f43a943cad07968b();
}

// Namespace br_infils_common
// Params 0
// Checksum 0x13bec419, Offset: 0x19f7
// Size: 0x36
function function_f14f7f4bdcdee51e()
{
    self endon( #"disconnect" );
    self clearpredictedstreampos();
    br_infils_util::endprematchskydiving();
    self.br_isininfil = 1;
    br_infils_util::refreshteamvisibilityforteam( self.team );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xf570f1c4, Offset: 0x1a35
// Size: 0x7a
function private forcespawnplayer()
{
    self endon( #"disconnect" );
    
    if ( self.class == "" )
    {
        self.class = "custom1";
        self.pers[ "class" ] = "custom1";
    }
    
    playerlogic::spawnplayer( 0 );
    self.br_infilstarted = 1;
    self notify( #"hash_36e455a1fbf78b10" );
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Namespace br_infils_common
// Params 3, eflags: 0x4
// Checksum 0xd6467e0f, Offset: 0x1ab7
// Size: 0x288
function private forcespawnplayers( players, spawnorigin, var_8f2f34e7cc124606 )
{
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.team ) || player.team == "spectator" || player.team == "codcaster" )
        {
            assertmsg( "<dev string:x24>" );
            continue;
        }
        
        player setclientomnvar( "ui_br_transition_type", 0 );
        player setclientomnvar( "ui_br_extended_load_screen", 0 );
        prevpos = player.origin;
        
        if ( !level.br_infils_disabled )
        {
            player br_infils_util::endprematchskydiving();
        }
        
        player clearladderstate();
        
        if ( isalive( player ) )
        {
            player stopliveragdoll();
        }
        
        player meatshield::function_db06fbfec0ffa2eb();
        
        if ( !level.br_infils_disabled )
        {
            player br::playerexecutionsdisable();
            player val::set( "br_infil", "offhand_throwback", 0 );
            player val::set( "br_infil", "melee", 0 );
        }
        
        player.var_ee4e521e94b41b6a = undefined;
        
        if ( !isalive( player ) )
        {
            if ( player.waitingtospawnamortize )
            {
                player utility::waittill_any( "spawned_player", "disconnect" );
                
                if ( isdefined( player ) && isdefined( spawnorigin ) )
                {
                    player setorigin( spawnorigin );
                }
            }
            else
            {
                if ( isdefined( spawnorigin ) )
                {
                    player.forcespawnorigin = spawnorigin;
                }
                
                player forcespawnplayer();
            }
        }
        else if ( isdefined( spawnorigin ) )
        {
            player setorigin( spawnorigin );
        }
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread function_3c70719d2317d79d();
        player.br_infilstarted = 1;
        player thread [[ level.parachutetakeweaponscb ]]();
        player.plotarmor = 1;
        
        if ( isdefined( var_8f2f34e7cc124606 ) )
        {
            player playerlinkto( var_8f2f34e7cc124606 );
            player.c130 = var_8f2f34e7cc124606;
            
            if ( function_bcca26e6456e3959( player ) )
            {
                player player_utility::function_dbe5a52a6654a982();
                player player_utility::function_9d378d725bb4831e( "br_infils_common::forceSpawnPlayers()" );
            }
        }
        
        if ( player.br_iseliminated )
        {
            br_utility::unmarkplayeraseliminated( player, "forceSpawnPlayers" );
        }
        
        if ( isdefined( spawnorigin ) )
        {
            utility::callsharedfunc( #"gametype", #"onplayerteleport", player, prevpos, spawnorigin, "c130" );
        }
        
        player notify( #"hash_724abcbca37e7fc9" );
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x66b1045d, Offset: 0x1d47
// Size: 0x65
function private function_3c70719d2317d79d()
{
    self endon( #"disconnect" );
    player = self;
    waittillframeend();
    var_c21d9d544e0d1923 = getmatchrulesdata( "commonOption", "infilArmor" );
    infilreserveplates = getmatchrulesdata( "commonOption", "infilReservePlates" );
    player.spawnarmor = var_c21d9d544e0d1923;
    player armor::givestartingarmor( var_c21d9d544e0d1923, infilreserveplates );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x326b1b14, Offset: 0x1db4
// Size: 0x166
function private function_fef7342ce0e19a47()
{
    if ( br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        foreach ( team in level.teamnamelist )
        {
            teamplayers = teams::getteamdata( team, "players" );
            brsquadleader = br_infils_util::setupbrsquadleader( teamplayers );
            
            if ( isdefined( brsquadleader ) )
            {
                br_infils_util::registerbrsquadleaderjumpcommands( brsquadleader );
                brsquadleader thread br_infils_util::watchbrsquadleaderdisconnect( team );
            }
            
            br::updatesquadleaderpassstateforteam( team );
        }
        
        return;
    }
    
    foreach ( player in level.infilstruct.players )
    {
        if ( isdefined( player ) )
        {
            br_infils_util::registerbrsquadleaderjumpcommands( player );
        }
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xe845c872, Offset: 0x1f22
// Size: 0x8f
function private function_f43a943cad07968b()
{
    if ( br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        teamplayers = teams::getteamdata( self.team, "players" );
        brsquadleader = br_infils_util::setupbrsquadleader( teamplayers );
        
        if ( isdefined( brsquadleader ) )
        {
            br_infils_util::registerbrsquadleaderjumpcommands( brsquadleader );
            brsquadleader thread br_infils_util::watchbrsquadleaderdisconnect( self.team );
        }
        
        br::updatesquadleaderpassstateforteam( self.team );
        return;
    }
    
    br_infils_util::registerbrsquadleaderjumpcommands( self );
}

// Namespace br_infils_common
// Params 0
// Checksum 0x9528cbf0, Offset: 0x1fb9
// Size: 0x2b
function state_cinematic()
{
    setomnvar( "ui_in_infil", 1 );
    function_a370399950b463ad();
    thread function_9ca9aec3113074f2();
    level thread function_92b22618a3be5a58();
    function_2aa7e129d78f5583();
}

// Namespace br_infils_common
// Params 0
// Checksum 0xe109c332, Offset: 0x1fec
// Size: 0x75
function function_92b22618a3be5a58()
{
    if ( isdefined( level.infilstruct.var_3a2e6ef0dea2917f ) )
    {
        var_5081bf0daf7ab833 = level.infilstruct.var_5081bf0daf7ab833 ?? level.infilstruct.binktime;
        wait var_5081bf0daf7ab833;
        br_infils_util::function_573cdd2bc439ec67( 0.3, level.infilstruct.players, "stateMachine" );
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0xbb567277, Offset: 0x2069
// Size: 0x15
function state_cinematic_playerlatejoin()
{
    self endon( #"disconnect" );
    function_e980b6eed552f03d();
}

// Namespace br_infils_common
// Params 0
// Checksum 0x8f50c377, Offset: 0x2086
// Size: 0x70
function state_animatic()
{
    function_53da71f75821f219();
    
    if ( !isdefined( level.infilstruct.var_3a2e6ef0dea2917f ) )
    {
        br_infils_util::function_573cdd2bc439ec67( 1, level.infilstruct.players, "stateMachine" );
    }
    
    if ( level.var_8f64d94451f73542 )
    {
        br_infils_util::function_fffda20dc2c2df07( &function_c7517a99cc704f12 );
    }
    else
    {
        br_infils_util::function_fffda20dc2c2df07( &state_animatic_playerlatejoin );
    }
    
    function_35b04ee9c2c41cc5();
}

// Namespace br_infils_common
// Params 0
// Checksum 0x1e3db8a7, Offset: 0x20fe
// Size: 0x90
function function_c7517a99cc704f12()
{
    self endon( #"disconnect" );
    self notify( #"hash_724abcbca37e7fc9" );
    
    if ( level.infilcurrentstate == 4 && !level.infilstruct.c130.var_2c86924721507731 )
    {
        level.infilstruct.c130 waittill( #"hash_d0cece8150e8d326" );
    }
    
    br_infils_util::function_333c77fc70a9408e( 1, "stateMachine" );
    player::_freezelookcontrols( 0 );
    br_infils_util::refreshteamvisibilityforteam( self.team );
}

// Namespace br_infils_common
// Params 0
// Checksum 0x16941f45, Offset: 0x2196
// Size: 0x161
function state_animatic_playerlatejoin()
{
    self endon( #"disconnect" );
    self notify( #"hash_724abcbca37e7fc9" );
    br_infils_util::function_333c77fc70a9408e( 1, "stateMachine" );
    br_infils_util::function_8fa0e0e9181d322( self );
    player::_freezelookcontrols( 1 );
    activepack = undefined;
    
    if ( isdefined( level.infilstruct ) && isdefined( level.infilstruct.animstruct ) )
    {
        activepack = level.infilstruct.animstruct.activepack;
    }
    
    if ( isdefined( activepack.playerfunc ) )
    {
        level.infilstruct.animstruct [[ activepack.playerfunc ]]( self, activepack.var_6d8067a88da0e813 );
    }
    
    if ( activepack.islooping )
    {
        player::_freezelookcontrols( 0 );
        activepack attach_player_to_animatic( self );
        wait 1;
        self cameraunlink();
        self stopxcam();
        thread br_c130::orbitcam( level.infilstruct.c130 );
        br_infils_util::refreshteamvisibilityforteam( self.team );
        return;
    }
    
    self cameraunlink();
    self stopxcam();
    activepack function_46fc105ef7e82157( self );
    activepack attach_player_to_animatic( self );
    
    if ( function_bcca26e6456e3959( self ) )
    {
        player_utility::function_dbe5a52a6654a982();
        player_utility::function_9d378d725bb4831e( "br_infils_common::state_animatic_playerLateJoin()" );
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0x5eb1c4bd, Offset: 0x22ff
// Size: 0xf3
function function_939f0d1a2134fe0e()
{
    packs = level.infilstruct.c130.animstruct.packs;
    lastindex = packs.size - 2;
    totaltime = 0;
    
    for ( index = lastindex; index >= 0 ; index-- )
    {
        pack = packs[ index ];
        anime = level.scr_anim[ pack.camerainfo.ent.animname ][ pack.anime ];
        
        if ( animhasnotetrack( anime, "teleport" ) )
        {
            teleporttime = utility::get_notetrack_time( anime, "teleport" );
            totaltime += teleporttime;
            continue;
        }
        
        totaltime += pack get_pack_anim_length();
    }
    
    return totaltime;
}

// Namespace br_infils_common
// Params 0
// Checksum 0x409e28a7, Offset: 0x23fb
// Size: 0x1b5
function state_flyover()
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player state_flyover_player();
        
        if ( player isplayerheadless() )
        {
            registerheadlessinfil( player );
        }
    }
    
    if ( isdefined( level.codcasters ) )
    {
        foreach ( codcaster in level.codcasters )
        {
            codcaster setclientomnvar( "ui_br_infiled", 1 );
        }
    }
    
    level.br_ac130 utility::callsharedfunc( #"gametype", #"addtoc130infil" );
    br_infils_util::function_fffda20dc2c2df07( &state_flyover_playerlatejoin );
    setomnvar( "ui_in_infil", -1 );
    level.infiltransistioning = undefined;
    level.infilcinematicactive = 0;
    flags::gameflagset( "infil_animatic_complete" );
    level thread state_flyover_vo();
    
    if ( isdefined( level.headlessinfilplayers ) )
    {
        level thread function_924df9daf0c6849b();
    }
    
    function_7d10e65f893e0751();
    level waittill( #"br_c130_left_bounds" );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x5b29842f, Offset: 0x25b8
// Size: 0x14b
function private state_flyover_player()
{
    self setallstreamloaddist( 0 );
    br_public::playerclearstreamhintorigin();
    
    if ( !level.infilstruct.var_dfeffb86c1dd09b6 )
    {
        self setclientdvar( @"cg_fov", 65 );
        self setclientdvar( @"cg_fov_viewmodel", 65 );
        
        if ( !level.infilstruct.var_ea87d0ead0c54f1c )
        {
            self setclientdvar( @"cg_disable_user_fov", 0 );
        }
        
        self disablephysicaldepthoffieldscripting();
        player::setdof_default();
    }
    
    self.instantclassswapallowed = 1;
    class::unblockclasschange();
    
    if ( utility::get_int_or_0( self.hidehudenabled ) > 0 )
    {
        utility::hidehuddisable();
    }
    
    self visionsetfadetoblackforplayer( "", 1 );
    self notify( #"joining_infil" );
    self.br_infilstarted = 1;
    
    if ( !level.c130inbounds )
    {
        self setclientomnvar( "ui_hide_minimap", 1 );
    }
    
    self.health = self.maxhealth;
    self cameraunlink();
    self stopxcam();
    br_c130::spawnplayertoc130();
    playersetupcontrolsforinfil();
    br_public::updatebrscoreboardstat( "isInInfilPlane", 1 );
    level.infilstruct.playersinc130++;
    br_public::function_c61dc6b780cede50();
    thread playercleanupinfilondisconnect();
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xb234d9c8, Offset: 0x270b
// Size: 0xef
function private state_flyover_vo()
{
    br_public::brleaderdialog( "match_start", 0, level.infilstruct.players, undefined, undefined, undefined, level.brgametype.dialogprefix );
    level thread br_c130::waittoplayinfildialog();
    
    if ( level.brgametype.var_4eb9a38adad726dd && isdefined( game[ "dialog" ][ "offense_obj" ] ) )
    {
        soundname = br_public::function_98922162e13bc0aa( "match_start", level.brgametype.dialogprefix );
        
        if ( isdefined( soundname ) )
        {
            soundlength = lookupsoundlength( soundname, 1 ) / 1000;
            wait soundlength + 1;
        }
        
        br_public::brleaderdialog( "offense_obj", 0, level.infilstruct.players, undefined, undefined, undefined, level.brgametype.dialogprefix );
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0x7d88bd30, Offset: 0x2802
// Size: 0x83
function state_flyover_playerlatejoin()
{
    self endon( #"disconnect" );
    state_flyover_player();
    thread watchinfiljumpanim();
    br_public::brleaderdialog( "match_start", 0, [ self ], undefined, undefined, undefined, level.brgametype.dialogprefix );
    player::_freezelookcontrols( 0 );
    self cameraunlink();
    self stopxcam();
    thread br_c130::orbitcam( level.infilstruct.c130 );
    br_infils_util::refreshteamvisibilityforteam( self.team );
}

// Namespace br_infils_common
// Params 0
// Checksum 0xc31646d7, Offset: 0x288d
// Size: 0x9
function state_done()
{
    function_e893e47e20b784d7();
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0xad278f97, Offset: 0x289e
// Size: 0x39
function private registerheadlessinfil( player )
{
    if ( !isdefined( level.headlessinfilplayers ) )
    {
        level.headlessinfilplayers = [];
    }
    
    level.headlessinfilplayers[ level.headlessinfilplayers.size ] = player;
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xd1737c91, Offset: 0x28df
// Size: 0xbb
function private function_924df9daf0c6849b()
{
    level endon( #"game_ended" );
    dist = distance( level.br_ac130.pathstruct.startpt, level.br_ac130.pathstruct.endpt );
    time = dist / br_c130::getc130speed() / level.headlessinfilplayers.size;
    
    for ( i = 0; i < level.headlessinfilplayers.size ; i++ )
    {
        wait time;
        level.headlessinfilplayers[ i ] notify( #"halo_jump_c130" );
    }
    
    level.headlessinfilplayers = undefined;
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0x7cffcad5, Offset: 0x29a2
// Size: 0xa8
function private playersetupcontrolsforinfil( soloonly = 0 )
{
    self setclientomnvar( "ui_br_infil_started", 1 );
    self setclientomnvar( "ui_br_infiled", 0 );
    
    if ( !soloonly )
    {
        self notifyonplayercommand( "halo_jump_c130", "+gostand" );
        
        if ( !isbot( self ) )
        {
            self notifyonplayercommand( "halo_jump_parachute_c130", "+open_parachute" );
        }
    }
    else
    {
        self notifyonplayercommand( "halo_jump_solo_c130", "+gostand" );
        
        if ( !isbot( self ) )
        {
            self notifyonplayercommand( "halo_jump_parachute_solo_c130", "+open_parachute" );
        }
    }
    
    self notifyonplayercommand( "br_pass_squad_leader", "+usereload" );
    self notifyonplayercommand( "br_pass_squad_leader", "+activate" );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xcdc0b37, Offset: 0x2a52
// Size: 0x79
function private playercleanupinfilondisconnect()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_b6accb860df79b5f" );
    self endon( #"br_jump" );
    self waittill( #"disconnect" );
    
    if ( isdefined( level.infilstruct ) && level.infilstruct.playersinc130 > 0 )
    {
        level.infilstruct.playersinc130--;
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x411808c9, Offset: 0x2ad3
// Size: 0x99
function private function_7d10e65f893e0751()
{
    level.infiljumpentsspawned = 0;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread watchinfiljumpanim();
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0xd3c04fe2, Offset: 0x2b74
// Size: 0x35
function playjumpsoundtosquad()
{
    aliasname = "evt_br_infil_squadmate_jump";
    
    if ( br_public::isplayerbrsquadleader() )
    {
        aliasname = "evt_br_infil_squad_leader_jump";
    }
    
    self playsoundtoteam( aliasname, self.team, self );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xead70f07, Offset: 0x2bb1
// Size: 0x35
function private function_3d81eb0c4e37aed2()
{
    self endon( #"disconnect" );
    wait 5;
    self setclientdvar( @"voice_proximity_enemy_client", 1 );
    br::playerexecutionsenable();
    val::reset_all( "br_infil" );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x58068356, Offset: 0x2bee
// Size: 0x5ac
function private watchinfiljumpanim()
{
    self endon( #"death_or_disconnect" );
    self.hasspawnweapons = 0;
    self waittill( #"br_jump" );
    
    if ( isdefined( level.infilstruct.jumpfunc ) )
    {
        self thread [[ level.infilstruct.jumpfunc ]]();
    }
    
    var_d1f48918cfe61df0 = getdvarint( @"hash_8be4acc5eebb19ca", 1 ) != 0;
    
    if ( level.infiljumpentsspawned >= 100 )
    {
        var_d1f48918cfe61df0 = 0;
    }
    
    shouldteleport = undefined;
    
    if ( var_d1f48918cfe61df0 )
    {
        shouldteleport = 0;
        assert( isdefined( level.infilstruct.var_3bead1a95b75d55d ) );
        [ propanimname, propanimref, playeranimname, playerlinktag ] = [[ level.infilstruct.var_3bead1a95b75d55d ]]();
        parentent = level.infilstruct.c130;
        
        if ( isdefined( level.infilstruct.animstruct ) && level.infilstruct.animstruct.nexusversion )
        {
            parentent = level.infilstruct.animstruct.c130;
        }
        
        var_ff1429cfdb4e629a[ "parent" ] = spawn( "script_model", parentent.origin );
        level.infiljumpentsspawned++;
        var_ff1429cfdb4e629a[ "parent" ] setmodel( "generic_prop_x10" );
        var_ff1429cfdb4e629a[ "parent" ] forcenetfieldhighlod( 1 );
        var_ff1429cfdb4e629a[ "parent" ] linkto( parentent, "tag_body", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        var_ff1429cfdb4e629a[ playerlinktag ] = spawn( "script_model", var_ff1429cfdb4e629a[ "parent" ] gettagorigin( playerlinktag ) );
        level.infiljumpentsspawned++;
        var_ff1429cfdb4e629a[ playerlinktag ] setmodel( "tag_player" );
        var_ff1429cfdb4e629a[ playerlinktag ] forcenetfieldhighlod( 1 );
        var_ff1429cfdb4e629a[ playerlinktag ] linkto( var_ff1429cfdb4e629a[ "parent" ], playerlinktag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self playerlinkto( var_ff1429cfdb4e629a[ playerlinktag ], "tag_player" );
        player_utility::function_b54a1e23734ef07( 1 );
        self playanimscriptsceneevent( "scripted_scene", playeranimname );
        self.infilanimindex = undefined;
        self.var_edbda953d7469bd7 = undefined;
        self playlocalsound( "evt_br_infil_jump_stinger" );
        music_br::function_68293509b7c0bc7( self );
        playjumpsoundtosquad();
        var_ff1429cfdb4e629a[ "parent" ] scriptmodelplayanim( propanimname, "prop" );
        jumpanimlength = getanimlength( propanimref );
        var_7c1475d50024c7ab = 1;
        jumpanimlength = max( jumpanimlength, var_7c1475d50024c7ab + 0.1 );
        wait jumpanimlength - var_7c1475d50024c7ab;
        self cameradefault();
        
        if ( isdefined( level.infilstruct.var_9a4f6a9353c9055c ) )
        {
            self thread [[ level.infilstruct.var_9a4f6a9353c9055c ]]();
        }
        
        thread function_3d81eb0c4e37aed2();
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
        thread function_3d81eb0c4e37aed2();
    }
    
    self.infilanimindex = undefined;
    self.var_edbda953d7469bd7 = undefined;
    self.infilactive = undefined;
    self stopanimscriptsceneevent();
    self notify( #"hash_7bc14f19e6cb235f" );
    
    if ( shouldteleport )
    {
        waitframe();
        
        if ( isdefined( level.infilstruct.c130 ) )
        {
            if ( isdefined( level.infilstruct.c130.playeroffsets ) && isdefined( level.infilstruct.c130.currentplayeroffset ) )
            {
                offset = level.infilstruct.c130.playeroffsets[ level.infilstruct.c130.currentplayeroffset ];
                self setorigin( level.infilstruct.c130.origin + offset, 1, 1 );
                level.infilstruct.c130.currentplayeroffset++;
                
                if ( level.infilstruct.c130.currentplayeroffset == level.infilstruct.c130.playeroffsets.size )
                {
                    level.infilstruct.c130.currentplayeroffset = 0;
                }
                
                player_utility::function_b54a1e23734ef07( 1 );
                playjumpsoundtosquad();
                
                if ( isdefined( level.infilstruct.var_9a4f6a9353c9055c ) )
                {
                    self thread [[ level.infilstruct.var_9a4f6a9353c9055c ]]();
                }
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_a8cbefa722d941ce" ) )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_a8cbefa722d941ce", self );
    }
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0x99442057, Offset: 0x31a2
// Size: 0x209
function private function_f73dbf30d8185cb0( players )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        linkedchildren = player getlinkedchildren();
        
        if ( isdefined( linkedchildren ) && linkedchildren.size )
        {
            numchildren = linkedchildren.size;
            
            if ( numchildren > 0 )
            {
                message = "Infil Player (" + player.name + ") with (" + numchildren + ") linked ents: ";
                
                foreach ( childent in linkedchildren )
                {
                    var_375460e28504266b = childent function_d2f9f0194ffec5fc();
                    
                    if ( var_375460e28504266b.size > 0 )
                    {
                        message += "stack:" + var_375460e28504266b + ",";
                    }
                    
                    if ( isdefined( childent.equipmentref ) )
                    {
                        message += "equip:" + childent.equipmentref + ",";
                        continue;
                    }
                    
                    if ( isdefined( childent.weapon_name ) )
                    {
                        message += "weapon:" + childent.weapon_name + ",";
                        continue;
                    }
                    
                    if ( isdefined( childent.model ) )
                    {
                        message += "model:" + childent.model + ",";
                        continue;
                    }
                    
                    message += "?,";
                }
                
                script::demoforcesre( message );
            }
        }
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x1a6e5f5b, Offset: 0x33b3
// Size: 0x2e7
function private function_53da71f75821f219()
{
    if ( isdefined( level.skip_death_vo ) )
    {
        level.skip_death_vo = undefined;
    }
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player notify( #"hash_724abcbca37e7fc9" );
        player br_utility::function_a8021859c16f9008();
        linkedchildren = player getlinkedchildren();
        
        foreach ( childent in linkedchildren )
        {
            if ( childent.equipmentref == "equip_molotov" )
            {
                player molotov::molotov_clear_burning( 1 );
                childent delete();
                continue;
            }
            
            if ( childent.equipmentref == "equip_thermite" )
            {
                childent thread thermite::thermite_destroy( 1 );
                continue;
            }
            
            if ( childent.equipmentref == "equip_shockstick" )
            {
                childent thread shock_stick::shockstick_destroy( 1 );
            }
        }
        
        player thread weapons::deleteplacedequipment( 1 );
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
    
    if ( isdefined( level.combataxes ) )
    {
        foreach ( combataxe in level.combataxes )
        {
            if ( isdefined( combataxe ) )
            {
                combataxe thread combataxe::deletepickup();
            }
        }
    }
    
    br_infils_util::refreshteamvisibility( level.infilstruct.players );
    function_f73dbf30d8185cb0( level.infilstruct.players );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xf2ef5a82, Offset: 0x36a2
// Size: 0x31
function private function_396db998e7e074b0()
{
    videoname = level.infilstruct.var_3a2e6ef0dea2917f;
    
    if ( !isdefined( videoname ) )
    {
        return;
    }
    
    self preloadcinematicforplayer( videoname );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xbaa4b18b, Offset: 0x36db
// Size: 0xdc
function private function_a370399950b463ad()
{
    videoname = level.infilstruct.var_3a2e6ef0dea2917f;
    
    if ( !isdefined( videoname ) )
    {
        return;
    }
    
    level thread music_br::function_af7220102b36ae29( level.infilstruct.players );
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_8683380408d3d654( 0 );
        player setclientomnvar( "ui_br_bink_overlay_state", 3 );
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xc957eea4, Offset: 0x37bf
// Size: 0x49
function private function_e980b6eed552f03d()
{
    videoname = level.infilstruct.var_3a2e6ef0dea2917f;
    
    if ( !isdefined( videoname ) )
    {
        return;
    }
    
    self setplayermusicstate( "" );
    self playcinematicforplayer( videoname );
    self setclientomnvar( "ui_br_bink_overlay_state", 3 );
}

// Namespace br_infils_common
// Params 2
// Checksum 0xc664e2b8, Offset: 0x3810
// Size: 0x56
function infilvideocompletecallback( channel, val )
{
    if ( self.var_cbb6cf9a94be8458 )
    {
        return;
    }
    
    if ( channel == "bink_complete" )
    {
        level notify( #"play_video_complete" );
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        self stopcinematicforplayer();
        self.var_cbb6cf9a94be8458 = 1;
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x13a8844a, Offset: 0x386e
// Size: 0x10e
function private function_9ca9aec3113074f2()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.infilstruct.var_3a2e6ef0dea2917f ) )
    {
        return;
    }
    
    var_5081bf0daf7ab833 = level.infilstruct.var_5081bf0daf7ab833 ?? level.infilstruct.binktime;
    var_e438673271741452 = getdvarfloat( @"hash_cff458b5fb25561a", var_5081bf0daf7ab833 );
    wait var_e438673271741452;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_br_bink_overlay_state", 0 );
        player stopcinematicforplayer();
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x705f1b63, Offset: 0x3984
// Size: 0x59
function private function_2aa7e129d78f5583()
{
    videoname = level.infilstruct.var_3a2e6ef0dea2917f;
    
    if ( !isdefined( videoname ) )
    {
        return;
    }
    
    assert( isdefined( level.infilstruct.binktime ) );
    wait level.infilstruct.binktime;
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0xe229642, Offset: 0x39e5
// Size: 0x10a
function private function_dcac11cdf400ec1b( player )
{
    assert( isdefined( self.camerainfo ) );
    cameraent = self.camerainfo.ent;
    cameratag = undefined;
    
    if ( isfunction( self.camerainfo.var_a87edda589012079 ) )
    {
        cameratag = self [[ self.camerainfo.var_a87edda589012079 ]]( player );
    }
    else if ( isarray( self.camerainfo.var_a87edda589012079 ) )
    {
        assert( player.infilanimindex <= self.camerainfo.var_a87edda589012079.size );
        cameratag = self.camerainfo.var_a87edda589012079[ player.infilanimindex - 1 ];
    }
    else
    {
        cameratag = self.camerainfo.var_a87edda589012079;
    }
    
    return [ cameraent, cameratag ];
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x56b8cbb3, Offset: 0x3af8
// Size: 0x28, Type: bool
function private uses_xcam()
{
    assert( isdefined( self.camerainfo ) );
    return isdefined( self.camerainfo.xcamasset );
}

// Namespace br_infils_common
// Params 2, eflags: 0x4
// Checksum 0xf2abe80e, Offset: 0x3b29
// Size: 0x11f
function private function_46fc105ef7e82157( player, var_f72cc7d49b1f3e1e )
{
    [ cameraent, cameratag ] = function_dcac11cdf400ec1b( player );
    
    if ( uses_xcam() )
    {
        if ( !var_f72cc7d49b1f3e1e )
        {
            xcamasset = self.camerainfo.xcamasset;
            
            if ( isdefined( self.camerainfo.xcamfunction ) )
            {
                xcamasset = self [[ self.camerainfo.xcamfunction ]]( player );
            }
            
            player cameraunlink();
            animstarttime = level.var_1876c8b6eb953a37 ? getframeduration() * 0.001 : undefined;
            
            if ( level.infilstruct.var_39f40041d77aaab4 )
            {
                player playxcamontag( xcamasset, 0, cameraent, cameratag, animstarttime, 1, 1, 1 );
            }
            else
            {
                player playxcamontag( xcamasset, 0, cameraent, cameratag, animstarttime, 1 );
            }
        }
        
        return;
    }
    
    player stopxcam();
    player cameralinkto( cameraent, cameratag, 1, 1 );
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0x8bba11f3, Offset: 0x3c50
// Size: 0x6b
function private get_camera_origin_angles( player )
{
    [ cameraent, cameratag ] = function_dcac11cdf400ec1b( player );
    cameraorigin = cameraent gettagorigin( cameratag );
    cameraangles = cameraent gettagangles( cameratag );
    return [ cameraorigin, cameraangles ];
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x69085eeb, Offset: 0x3cc4
// Size: 0x48
function private get_pack_anim_length()
{
    assert( isdefined( self.camerainfo ) );
    
    if ( uses_xcam() )
    {
        return self.camerainfo.xcamlength;
    }
    
    return self.camerainfo.animlength;
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0xd99e9222, Offset: 0x3d14
// Size: 0x164
function private attach_player_to_animatic( player )
{
    assert( player.infilanimindex <= self.playerpositions.size );
    
    if ( !player.hasspawned )
    {
        logstring( "attach_player_to_animatic: player" + player getxuid() + "has not spawned yet" );
    }
    
    linkent = self.playerpositions[ player.infilanimindex - 1 ].ent;
    animname = self.playerpositions[ player.infilanimindex - 1 ].animname;
    
    if ( level.var_b248208057eef915 )
    {
        if ( isdefined( self.playerpositions[ player.infilanimindex - 1 ].animnamefem ) )
        {
            if ( player operator::isfemale() )
            {
                animname = self.playerpositions[ player.infilanimindex - 1 ].animnamefem;
            }
        }
    }
    
    var_9eae63379021fe6d = 0;
    var_a74d1430e522ad95 = player.var_9cde8b4b2a697687;
    
    if ( var_a74d1430e522ad95 != linkent )
    {
        var_9eae63379021fe6d = 1;
    }
    
    if ( var_9eae63379021fe6d )
    {
        player playerlinkto( linkent, "tag_player" );
        player.var_9cde8b4b2a697687 = linkent;
    }
    
    player playanimscriptsceneevent( "scripted_scene", animname );
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0x5df7b3e, Offset: 0x3e80
// Size: 0x9d
function private unfreezeplayercontrols( delaytime )
{
    wait delaytime;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player player::_freezelookcontrols( 0 );
    }
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0xf4d1efdf, Offset: 0x3f25
// Size: 0xc24
function private playinfilsequence( var_df720711dd79fea7 )
{
    self endon( #"stopscene" );
    level.infilstruct.animstruct = self;
    level.infilstruct.var_df720711dd79fea7 = var_df720711dd79fea7;
    self.activepack = undefined;
    level.infilstruct.var_39f40041d77aaab4 = self.var_39f40041d77aaab4 ?? 0;
    var_3a238e44047ac624 = 0;
    
    /#
        var_3a238e44047ac624 = function_5e7c30c827f65843();
    #/
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        br_infils_util::function_8fa0e0e9181d322( player );
        player player::_freezelookcontrols( 1 );
        player.infilactive = 1;
    }
    
    if ( level.infilstruct.var_39f40041d77aaab4 && isdefined( self.camerarunner ) )
    {
        self.camerarunner val::set( "br_infil", "cinematics_participant", 1 );
    }
    
    foreach ( pack in self.packs )
    {
        self.activepack = pack;
        
        /#
            if ( var_df720711dd79fea7 )
            {
                iprintlnbold( "<dev string:x72>" + pack.anime );
            }
        #/
        
        if ( pack.islooping )
        {
            br_infils_util::refreshteamvisibility( level.infilstruct.players );
        }
        
        if ( isdefined( pack.fov ) )
        {
            br_infils_util::allplayers_setfov( pack.fov );
        }
        else
        {
            br_infils_util::function_4b282a3b31aae42a();
        }
        
        if ( isdefined( pack.fstop ) && isdefined( pack.focusdist ) )
        {
            br_infils_util::allplayers_setphysicaldof( pack.fstop, pack.focusdist, pack.focusspeed, pack.aperturespeed, pack.focalpoint );
        }
        
        if ( isdefined( pack.startfunc ) )
        {
            [[ pack.startfunc ]]( pack.var_d664c1119b3ae972 );
        }
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isdefined( pack.playerfunc ) )
            {
                [[ pack.playerfunc ]]( player, pack.var_6d8067a88da0e813 );
            }
            
            if ( !isdefined( pack.var_70b246e04887fc4a ) )
            {
                player cameraunlink();
                player stopxcam();
                pack function_46fc105ef7e82157( player );
            }
        }
        
        if ( isdefined( pack.fx ) )
        {
            playfx( utility::getfx( pack.fx ), pack.fxorigin, anglestoforward( pack.fxangles ), anglestoup( pack.fxangles ) );
        }
        
        pack.ents = function_5713d46873b29625( pack.ents );
        
        foreach ( ent in pack.ents )
        {
            animstarttime = level.var_1876c8b6eb953a37 ? getframeduration() * 0.001 : undefined;
            
            if ( level.infilstruct.var_39f40041d77aaab4 )
            {
                ent val::set( "br_infil", "cinematics_participant", 1 );
                ent scriptmodelplayanim( level.scr_anim[ ent.animname ][ pack.anime ], ent.animname, animstarttime, 1, "none" );
            }
            else
            {
                if ( !ent.dontteleport )
                {
                    ent dontinterpolate();
                }
                
                ent scriptmodelplayanim( level.scr_anim[ ent.animname ][ pack.anime ], ent.animname, animstarttime );
            }
            
            ent thread notetrack::start_notetrack_wait( ent, ent.animname, pack.anime, ent.animname, level.scr_anim[ ent.animname ][ pack.anime ] );
        }
        
        foreach ( rig in pack.lightingrigs )
        {
            foreach ( probe in rig.probes )
            {
                origin_offset = probe.origin_offset;
                angles_offset = probe.angles_offset;
                
                if ( !isdefined( angles_offset ) )
                {
                    angles_offset = ( 0, 0, 0 );
                }
                
                probe show();
                probe linkto( rig.linkent, "tag_origin", origin_offset, angles_offset );
            }
            
            foreach ( light in rig.lights )
            {
                if ( isdefined( light.original_intensity ) )
                {
                    light setlightintensity( light.original_intensity );
                }
                
                origin_offset = light.origin_offset;
                angles_offset = light.angles_offset;
                
                if ( !isdefined( angles_offset ) )
                {
                    angles_offset = ( 0, 0, 0 );
                }
                
                light linkto( rig.linkent, "tag_origin", origin_offset, angles_offset );
            }
        }
        
        proxycount = 0;
        var_8f9b0f7dbb016eab = 4;
        
        /#
            var_8f9b0f7dbb016eab = function_486c89102889361c();
        #/
        
        pack.var_ebbf2026208f047d = function_5713d46873b29625( pack.var_ebbf2026208f047d );
        
        foreach ( proxy in pack.var_ebbf2026208f047d )
        {
            animstarttime = level.var_1876c8b6eb953a37 ? getframeduration() * 0.001 : undefined;
            
            if ( level.infilstruct.var_39f40041d77aaab4 )
            {
                proxy val::set( "br_infil", "cinematics_participant", 1 );
                proxy scriptmodelplayanim( level.scr_anim[ proxy.animname ][ pack.anime ], proxy.animname, animstarttime, 1, "none" );
            }
            else
            {
                proxy dontinterpolate();
                proxy scriptmodelplayanim( level.scr_anim[ proxy.animname ][ pack.anime ], proxy.animname, animstarttime );
            }
            
            if ( var_3a238e44047ac624 )
            {
                if ( !isdefined( pack.var_30043414aa6e135f ) )
                {
                    if ( proxycount < var_8f9b0f7dbb016eab )
                    {
                        proxy show();
                    }
                    else
                    {
                        proxy hide();
                    }
                }
            }
            else
            {
                proxy hide();
            }
            
            proxycount++;
        }
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( level.infilstruct.var_39f40041d77aaab4 )
            {
                player val::set( "br_infil", "cinematics_participant", 1 );
            }
            
            pack attach_player_to_animatic( player );
            
            if ( var_3a238e44047ac624 )
            {
                if ( var_df720711dd79fea7 || function_bcca26e6456e3959( player ) )
                {
                    player player_utility::function_dbe5a52a6654a982();
                    player player_utility::function_9d378d725bb4831e( "br_infils_common::playInfilSequence()" );
                }
            }
        }
        
        if ( pack.islooping )
        {
            break;
        }
        
        animlength = pack get_pack_anim_length();
        br_infils_util::waitandpause( animlength );
    }
    
    function_f623142e1cd1ac0b();
    wait 1;
    
    if ( !level.infilstruct.var_dfeffb86c1dd09b6 )
    {
        br_infils_util::allplayers_clearphysicaldof();
        br_infils_util::function_4b282a3b31aae42a();
    }
    
    if ( level.infilstruct.var_39f40041d77aaab4 )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player val::reset( "br_infil", "cinematics_participant" );
            
            if ( isdefined( player.var_9cde8b4b2a697687 ) )
            {
                player.var_9cde8b4b2a697687 = undefined;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_187e8c5233803ac8", 0 ) )
        {
            thread function_b1d6c2f045a7a342();
        }
        else if ( var_df720711dd79fea7 )
        {
            foreach ( player in level.infilstruct.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player cameraunlink();
                player stopxcam();
                player br_c130::orbitcam( level.br_ac130 );
            }
        }
    #/
    
    level thread unfreezeplayercontrols( 1.2 );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xa4095b26, Offset: 0x4b51
// Size: 0xa8
function private function_f623142e1cd1ac0b()
{
    point_radius = 4;
    contents = physics_createcontents( [ "physicscontents_playerclip" ] );
    var_5ea37490d9890e32 = self.playertags && self.playertags.size > 0 ? self.playertags[ 0 ] : self.movingc130;
    assert( var_5ea37490d9890e32, "<dev string:x80>" );
    
    while ( var_5ea37490d9890e32 )
    {
        in_collider = physics_querypoint( var_5ea37490d9890e32.origin, point_radius, contents, undefined, "physicsquery_any" );
        
        if ( !in_collider )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0xc5dab17f, Offset: 0x4c01
// Size: 0x1f8
function private function_5065b5c9173828cc( var_df720711dd79fea7 )
{
    self endon( #"stopscene" );
    level.infilstruct.animstruct = self;
    level.infilstruct.var_df720711dd79fea7 = var_df720711dd79fea7;
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        br_infils_util::function_8fa0e0e9181d322( player );
        player player::_freezelookcontrols( 1 );
    }
    
    if ( isdefined( level.infilstruct.play_scenesystem ) )
    {
        [[ level.infilstruct.play_scenesystem ]]( self );
    }
    
    if ( !level.infilstruct.var_dfeffb86c1dd09b6 )
    {
        br_infils_util::allplayers_clearphysicaldof();
        br_infils_util::function_4b282a3b31aae42a();
    }
    
    /#
        if ( getdvarint( @"hash_187e8c5233803ac8", 0 ) )
        {
            thread function_b1d6c2f045a7a342();
        }
        else if ( var_df720711dd79fea7 )
        {
            foreach ( player in level.infilstruct.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player cameraunlink();
                player stopxcam();
                player br_c130::orbitcam( level.br_ac130 );
            }
        }
    #/
    
    level thread unfreezeplayercontrols( 1.2 );
}

/#

    // Namespace br_infils_common
    // Params 0
    // Checksum 0x7208f87d, Offset: 0x4e01
    // Size: 0x3b5, Type: dev
    function function_b1d6c2f045a7a342()
    {
        if ( !level.var_8f64d94451f73542 )
        {
            transitiontime = 1;
            wait transitiontime;
        }
        
        c130 = self.movingc130;
        
        if ( !isdefined( c130 ) )
        {
            c130 = self.c130;
        }
        
        entaxis = anglestoaxis( c130.angles );
        entright = -1 * entaxis[ "<dev string:xbc>" ];
        entup = entaxis[ "<dev string:xc2>" ];
        
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            slotnumber = player.infilanimindex - 1;
            cameraorigin = undefined;
            cameraangles = undefined;
            
            if ( level.var_8f64d94451f73542 )
            {
                assert( isdefined( level.infilstruct.var_57d9814dcb2bcbed ) );
                [ cameraorigin, cameraangles ] = self [[ level.infilstruct.var_57d9814dcb2bcbed ]]( player );
            }
            else
            {
                assert( isdefined( self.activepack ) );
                [ cameraorigin, cameraangles ] = self.activepack get_camera_origin_angles( player );
            }
            
            baseorigin = player getvieworigin();
            playerparent = player getlinkedparent();
            var_3be7a68967401d37 = playerparent.angles;
            rayorigin = cameraorigin;
            raydir = anglestoforward( cameraangles );
            planenormal = ( raydir[ 0 ] * -1, raydir[ 1 ] * -1, 0 );
            planenormal = vectornormalize( planenormal );
            denominator = vectordot( planenormal, raydir * -1 );
            difference = rayorigin - baseorigin;
            numerator = vectordot( planenormal, difference );
            t = numerator / denominator;
            result = rayorigin + t * raydir;
            worldorigin = result;
            localoffset = coordtransformtranspose( worldorigin, baseorigin, var_3be7a68967401d37 );
            println( "<dev string:xc5>" + slotnumber + "<dev string:xdf>" + localoffset[ 0 ] + "<dev string:xe2>" + localoffset[ 1 ] + "<dev string:xe2>" + localoffset[ 2 ] + "<dev string:xe4>" );
            neworigin = coordtransform( localoffset, baseorigin, var_3be7a68967401d37 );
            cameradistance = distance( cameraorigin, neworigin );
            var_a2b8bd65a8f16f39 = neworigin - cameraorigin;
            var_a2b8bd65a8f16f39 = vectornormalize( var_a2b8bd65a8f16f39 );
            var_ee5bfd5117ac7406 = vectordot( raydir, var_a2b8bd65a8f16f39 );
            println( "<dev string:xe6>" + slotnumber + "<dev string:xff>" + cameradistance + "<dev string:x10c>" + var_ee5bfd5117ac7406 + "<dev string:xe4>" );
            var_124e75d9a55f7416 = cameraorigin - neworigin;
            var_cb9911ecd63f33a6 = length( var_124e75d9a55f7416 );
            var_a12f6f2f2ef29484 = acos( var_124e75d9a55f7416[ 2 ] / var_cb9911ecd63f33a6 );
            println( "<dev string:x114>" + slotnumber + "<dev string:x130>" + var_cb9911ecd63f33a6 + "<dev string:x13a>" + var_a12f6f2f2ef29484 + "<dev string:xe4>" );
        }
    }

#/

// Namespace br_infils_common
// Params 0
// Checksum 0xe24fc29, Offset: 0x51be
// Size: 0x37
function safe_delete()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.dontdelete )
    {
        return;
    }
    
    if ( isdefined( self.innards ) )
    {
        self.innards delete();
    }
    
    self delete();
}

// Namespace br_infils_common
// Params 0
// Checksum 0x579cba79, Offset: 0x51fd
// Size: 0x321
function cleanupents()
{
    foreach ( pack in self.packs )
    {
        pack.var_ebbf2026208f047d = function_5713d46873b29625( pack.var_ebbf2026208f047d );
        
        foreach ( proxy in pack.var_ebbf2026208f047d )
        {
            proxy safe_delete();
        }
        
        pack.playerpositions = function_5713d46873b29625( pack.playerpositions );
        
        foreach ( posstruct in pack.playerpositions )
        {
            if ( isdefined( posstruct.ent ) )
            {
                posstruct.ent safe_delete();
            }
        }
        
        pack.playerpositions = [];
        pack.ents = function_5713d46873b29625( pack.ents );
        
        foreach ( ent in pack.ents )
        {
            if ( isdefined( ent.linkedents ) )
            {
                utility::array_delete( ent.linkedents );
            }
            
            ent safe_delete();
        }
        
        pack.staticents = function_5713d46873b29625( pack.staticents );
        
        foreach ( ent in pack.staticents )
        {
            if ( isdefined( ent.linkedents ) )
            {
                utility::array_delete( ent.linkedents );
            }
            
            ent safe_delete();
        }
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xa1acf0ab, Offset: 0x5526
// Size: 0x5e
function private function_817017b08b045a91()
{
    defaultscenetype = "ac130";
    
    if ( level.br_infil_funcs.size > 0 )
    {
        defaultscenetype = getarraykey( level.br_infil_funcs, 0 );
    }
    
    scenetype = function_834408c69ab78ac9();
    
    if ( isdefined( scenetype ) )
    {
        return scenetype;
    }
    
    scenetype = function_c4277aec3ae78273();
    
    if ( isdefined( scenetype ) )
    {
        return scenetype;
    }
    
    return defaultscenetype;
}

// Namespace br_infils_common
// Params 0
// Checksum 0xbd945038, Offset: 0x558d
// Size: 0x9f
function function_962df7256771b267()
{
    mrule = getmatchrulesdata( "brData", "infil" );
    
    if ( !mrule )
    {
        mrule = function_baad64cedbfe2a7a();
    }
    
    infil = getdvar( @"hash_73ceea1f4554b02a" );
    
    if ( !infil )
    {
        infil = mrule;
    }
    
    if ( !infil )
    {
        return;
    }
    
    if ( isxhashasset( infil ) )
    {
        hashassetname = infil;
    }
    else
    {
        hashassetname = hashcat( %"hash_7f2c894fabf3e196", infil );
    }
    
    bundle = getscriptbundle( hashassetname );
    assert( bundle, "<dev string:x14a>" + infil );
    return bundle;
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x784018e1, Offset: 0x5635
// Size: 0x114
function private function_baad64cedbfe2a7a()
{
    mapinfo = level.mapinfobundle ?? getmapscriptbundle();
    
    foreach ( var_c0929d5b10f3f848 in mapinfo.transientdata.infilintro )
    {
        foreach ( infil in var_c0929d5b10f3f848.var_4e2a66f8f7f6141b )
        {
            return infil.bundle;
        }
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xef3c674c, Offset: 0x5751
// Size: 0x4b
function private function_c4277aec3ae78273()
{
    bundle = function_962df7256771b267();
    
    if ( !( isdefined( bundle ) && isdefined( bundle.var_54de151fd0c26a14 ) ) || bundle.var_54de151fd0c26a14 == "" )
    {
        return;
    }
    
    return bundle.var_54de151fd0c26a14;
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xabd96502, Offset: 0x57a5
// Size: 0x2e
function private function_834408c69ab78ac9()
{
    scenetype = getdvar( @"hash_2f5821f46995d1e2", "" );
    
    if ( scenetype != "" )
    {
        return scenetype;
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xb333f11c, Offset: 0x57dc
// Size: 0x133
function private function_daaef2ba44d450df()
{
    level.infilstruct.statecallbacks = [];
    level.infilstruct.var_3a2e6ef0dea2917f = undefined;
    scenetype = function_817017b08b045a91();
    
    if ( isdefined( level.br_infil_funcs[ scenetype ] ) )
    {
        [[ level.br_infil_funcs[ scenetype ] ]]();
        return;
    }
    
    switch ( scenetype )
    {
        case #"hash_1136bc3322c0a548":
            level.var_8f64d94451f73542 = 0;
            br_infils_chopper::init();
            break;
        case #"hash_5428ebdaaca96e36":
            level.var_8f64d94451f73542 = 0;
            br_infils_ac130_v0::init();
            break;
        case #"hash_ee578a15ca8b126d":
            level.var_8f64d94451f73542 = 1;
            namespace_56acda7adda17189::init();
            break;
        case #"hash_a9257f2a837c6176":
            level.var_8f64d94451f73542 = 0;
            namespace_d9bbc36a8c8a35ca::init();
            break;
        case #"hash_b730c3301d705212":
            level.var_8f64d94451f73542 = 0;
            br_infils_ac130_short::init();
            break;
        case #"hash_a9f638b560f8481f":
        default:
            level.var_8f64d94451f73542 = 0;
            br_infils_ac130::init();
            break;
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0xd90036d3, Offset: 0x5917
// Size: 0x6c
function function_ee08fadf2a691598()
{
    assert( isdefined( level.infilstruct.c130 ) );
    animstruct = function_a8719d48afa1b495( level.infilstruct.c130 );
    function_d1002b8e261cba3b( animstruct );
    level.infilstruct.c130.animstruct = animstruct;
}

// Namespace br_infils_common
// Params 0
// Checksum 0x43b2ed3b, Offset: 0x598b
// Size: 0x95
function function_35b04ee9c2c41cc5()
{
    level.infilstruct.var_2c8cdd72c4c046d7 = 1;
    assert( isdefined( level.infilstruct.c130.animstruct ) );
    
    if ( level.var_8f64d94451f73542 )
    {
        level.infilstruct.c130.animstruct function_5065b5c9173828cc();
        return;
    }
    
    level.infilstruct.c130.animstruct playinfilsequence();
}

// Namespace br_infils_common
// Params 1
// Checksum 0x93e4484f, Offset: 0x5a28
// Size: 0x3f
function function_a8719d48afa1b495( movingc130 )
{
    assert( isdefined( level.infilstruct.var_cee5041ecb30a2c5 ) );
    return [[ level.infilstruct.var_cee5041ecb30a2c5 ]]( movingc130 );
}

// Namespace br_infils_common
// Params 1
// Checksum 0x7f3d29bd, Offset: 0x5a70
// Size: 0x17
function function_66b340dfbcad4acf( origin )
{
    level.var_66b340dfbcad4acf = origin;
}

// Namespace br_infils_common
// Params 1, eflags: 0x4
// Checksum 0xb6b7f9a3, Offset: 0x5a8f
// Size: 0x4b
function private function_d1002b8e261cba3b( animstruct )
{
    staticc130 = animstruct.staticc130;
    
    if ( isdefined( staticc130 ) && isdefined( level.var_66b340dfbcad4acf ) )
    {
        staticc130.origin = level.var_66b340dfbcad4acf;
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x80f93fe0, Offset: 0x5ae2
// Size: 0x31
function private function_ced01d2fc0a3dec2()
{
    level.var_21ea52a8dfa4b9eb = [];
    level.brlatespawnplayer = &latespawnplayer;
    
    if ( recycle_manager::isenabled() )
    {
        level.var_71ba41c0c502d09c = &function_803215a11f1cacac;
    }
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xa1f782c2, Offset: 0x5b1b
// Size: 0xc
function private function_e893e47e20b784d7()
{
    level.var_21ea52a8dfa4b9eb = undefined;
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x41afc8ac, Offset: 0x5b2f
// Size: 0x1c, Type: bool
function private function_204ee26b62066dae()
{
    return isdefined( level.var_21ea52a8dfa4b9eb ) && level.var_21ea52a8dfa4b9eb.size > 0;
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0x377ee9a2, Offset: 0x5b54
// Size: 0x5b
function private missedinfilplayerhandler()
{
    if ( self.class == "" )
    {
        self.class = "custom1";
        self.pers[ "class" ] = "custom1";
    }
    
    self.br_infilstarted = 1;
    br_pickups::addrespawntoken( 1 );
    br_gulag::playergulagautowin( "missedInfil", undefined, undefined, 1 );
}

// Namespace br_infils_common
// Params 0, eflags: 0x4
// Checksum 0xdb38301b, Offset: 0x5bb7
// Size: 0x304
function private latespawnplayerafterinfil()
{
    self endon( #"disconnect" );
    self.br_isininfil = 0;
    self.br_infilstarted = 1;
    isuibot = br::function_a29e5f57c1ef9e35();
    var_5fcbad501bc25093 = isuibot && recycle_manager::isenabled();
    
    if ( !br_gametypes::isfeaturedisabled( #"hash_1d015a3890edfd10" ) )
    {
        squadmates = teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid );
        
        if ( !isdefined( squadmates ) || squadmates.size == 0 )
        {
            teamplayers = [ self ];
        }
        
        br_infils_util::setupbrsquadleader( squadmates );
    }
    
    self setallstreamloaddist( 0 );
    self clearpredictedstreampos();
    
    if ( isdefined( self.var_ef85badc92e7af8a ) )
    {
        foreach ( overlay in self.var_ef85badc92e7af8a )
        {
            if ( isdefined( overlay ) )
            {
                overlay destroy();
            }
        }
        
        self.var_ef85badc92e7af8a = undefined;
    }
    
    self setclientdvar( @"voice_proximity_enemy_client", 1 );
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "br_infils_common::lateSpawnPlayerAfterInfil()" );
    self.plotarmor = 0;
    player::_freezelookcontrols( 0, 1 );
    self cameraunlink();
    self stopxcam();
    self setclientdvar( @"cg_fov", 65 );
    self setclientdvar( @"cg_fov_viewmodel", 65 );
    self setclientdvar( @"cg_disable_user_fov", 0 );
    self disablephysicaldepthoffieldscripting();
    player::setdof_default();
    
    if ( self.hidehudenabled > 0 )
    {
        utility::hidehuddisable();
    }
    
    self visionsetfadetoblackforplayer( "", 1 );
    basevisionset = "";
    
    if ( isdefined( level.var_cd027313d113e09b ) )
    {
        basevisionset = level.var_cd027313d113e09b;
    }
    
    self visionsetnakedforplayer( basevisionset, 1 );
    br_public::function_c61dc6b780cede50();
    
    if ( !isalive( self ) )
    {
        if ( level.br_infils_disabled && isbot( self ) && !isuibot )
        {
            self.jumped = 1;
            playerlogic::addtoalivecount( "lateSpawn" );
        }
        
        if ( !self.alreadyaddedtoalivecount && game_utility::getgametype() == "playground" && !isbot( self ) )
        {
            teams::addtoteamlives( self, self.team );
        }
        
        if ( isuibot )
        {
            if ( !var_5fcbad501bc25093 )
            {
                thread playerlogic::spawnplayer( undefined, 0 );
            }
        }
        else
        {
            thread missedinfilplayerhandler();
        }
    }
    else if ( !var_5fcbad501bc25093 )
    {
        assertmsg( "<dev string:x16e>" );
    }
    
    if ( !isbot( self ) )
    {
        player::setwind( "1" );
    }
    
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_br_extended_load_screen", 0 );
}

// Namespace br_infils_common
// Params 0
// Checksum 0x124455ec, Offset: 0x5ec3
// Size: 0xdd
function latespawnplayer()
{
    if ( !function_204ee26b62066dae() )
    {
        latespawnplayerafterinfil();
        return;
    }
    
    assert( isdefined( level.infilstruct.players ) );
    
    if ( arraycontains( level.infilstruct.players, self ) )
    {
        return;
    }
    
    callbackindex = 0;
    
    while ( callbackindex < level.var_21ea52a8dfa4b9eb.size )
    {
        func = level.var_21ea52a8dfa4b9eb[ callbackindex ];
        self [[ func ]]();
        callbackindex++;
        
        if ( !function_204ee26b62066dae() )
        {
            latespawnplayerafterinfil();
            return;
        }
    }
    
    level.infilstruct.players[ level.infilstruct.players.size ] = self;
    
    if ( manager::function_a0e7b7d42c9dbf4b() )
    {
        manager::function_89073acfbf418766( [ self ] );
    }
}

// Namespace br_infils_common
// Params 0
// Checksum 0x308b6b4f, Offset: 0x5fa8
// Size: 0x93
function function_803215a11f1cacac()
{
    if ( self.var_462abd03626a7de )
    {
        return;
    }
    
    if ( level.infiltransistioning || level.snatchspawnalltoc130done || level.br_c130spawndone )
    {
        assert( isdefined( level.infilstruct.players ) );
        
        if ( !arraycontains( level.infilstruct.players, self ) )
        {
            logstring( "[Super Bots] LateSpawnUIBot " + self.name );
            latespawnplayer();
        }
        
        self.var_462abd03626a7de = 1;
    }
}

// Namespace br_infils_common
// Params 1
// Checksum 0x9817eba0, Offset: 0x6043
// Size: 0x3d
function function_bcca26e6456e3959( player )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_ad78f0f19c8707ab", 1 ) == 1 )
    {
        return isdefined( player.c130 );
    }
    
    return 1;
}

/#

    // Namespace br_infils_common
    // Params 0, eflags: 0x4
    // Checksum 0x937d7e3b, Offset: 0x6088
    // Size: 0x1d, Type: dev
    function private function_b3fc100f7154d153()
    {
        level.var_e9752d5557df31ee = 0;
        thread pauseanims();
        thread function_e1fea13d32d736ec();
    }

    // Namespace br_infils_common
    // Params 0, eflags: 0x4
    // Checksum 0x3ee93bfb, Offset: 0x60ad
    // Size: 0x18c, Type: dev
    function private function_d767a08ceb9e3087()
    {
        level.var_e9752d5557df31ee = undefined;
        self notify( #"stopscene" );
        
        foreach ( player in level.players )
        {
            player player::_freezelookcontrols( 0 );
            player cameradefault();
            player cameraunlink();
            player stopxcam();
            player lerpfov( 65, 0.5 );
            
            if ( player.var_5d1d2a9db3eeaa3f )
            {
                player disablephysicaldepthoffieldscripting();
                player player::setdof_default();
                player.var_5d1d2a9db3eeaa3f = undefined;
            }
        }
        
        wait 1;
        
        foreach ( player in level.players )
        {
            player setclientdvar( @"cg_fov", 65 );
            player setclientdvar( @"cg_fov_viewmodel", 65 );
            player setclientdvar( @"cg_disable_user_fov", 0 );
        }
        
        cleanupents();
    }

    // Namespace br_infils_common
    // Params 0, eflags: 0x4
    // Checksum 0xa4c17626, Offset: 0x6241
    // Size: 0x3bd, Type: dev
    function private pauseanims()
    {
        self endon( #"stopscene" );
        hostplayer = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        while ( true )
        {
            level.var_e9752d5557df31ee = 0;
            
            while ( hostplayer buttonpressed( "<dev string:x1c2>" ) || hostplayer buttonpressed( "<dev string:x1cd>" ) )
            {
                waitframe();
            }
            
            while ( !hostplayer buttonpressed( "<dev string:x1c2>" ) && !hostplayer buttonpressed( "<dev string:x1cd>" ) )
            {
                waitframe();
            }
            
            if ( isdefined( self.activepack ) )
            {
                self.activepack.ents = function_5713d46873b29625( self.activepack.ents );
                
                foreach ( ent in self.activepack.ents )
                {
                    ent scriptmodelpauseanim( 1 );
                }
                
                self.activepack.var_ebbf2026208f047d = function_5713d46873b29625( self.activepack.var_ebbf2026208f047d );
                
                foreach ( proxy in self.activepack.var_ebbf2026208f047d )
                {
                    proxy scriptmodelpauseanim( 1 );
                }
                
                if ( self.activepack uses_xcam() )
                {
                    hostplayer pausexcam( 1 );
                }
            }
            
            level.var_e9752d5557df31ee = 1;
            
            while ( hostplayer buttonpressed( "<dev string:x1c2>" ) || hostplayer buttonpressed( "<dev string:x1cd>" ) )
            {
                waitframe();
            }
            
            while ( !hostplayer buttonpressed( "<dev string:x1c2>" ) && !hostplayer buttonpressed( "<dev string:x1cd>" ) )
            {
                waitframe();
            }
            
            if ( isdefined( self.activepack ) )
            {
                self.activepack.ents = function_5713d46873b29625( self.activepack.ents );
                
                foreach ( ent in self.activepack.ents )
                {
                    ent scriptmodelpauseanim( 0 );
                }
                
                self.activepack.var_ebbf2026208f047d = function_5713d46873b29625( self.activepack.var_ebbf2026208f047d );
                
                foreach ( proxy in self.activepack.var_ebbf2026208f047d )
                {
                    proxy scriptmodelpauseanim( 0 );
                }
                
                if ( self.activepack uses_xcam() )
                {
                    hostplayer pausexcam( 0 );
                }
            }
        }
    }

    // Namespace br_infils_common
    // Params 0
    // Checksum 0x78582724, Offset: 0x6606
    // Size: 0x1ea, Type: dev
    function function_e1fea13d32d736ec()
    {
        self endon( #"stopscene" );
        hostplayer = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        while ( true )
        {
            while ( !hostplayer buttonpressed( "<dev string:x1d8>" ) && !hostplayer buttonpressed( "<dev string:x1e0>" ) )
            {
                waitframe();
            }
            
            hostplayer player_utility::function_b54a1e23734ef07();
            hostplayer player_utility::function_4688d689820ff1ed( "<dev string:x1e8>" );
            hostplayer cameraunlink();
            hostplayer disablephysicaldepthoffieldscripting();
            hostplayer cameradefault();
            hostplayer player::_freezelookcontrols( 0 );
            
            if ( isdefined( self.activepack ) )
            {
                [ cameraorigin, cameraangles ] = self.activepack get_camera_origin_angles( hostplayer );
                newplayerorg = cameraorigin + ( 0, 0, -60 );
                var_4273bc90e0c23d57 = cameraangles;
                hostplayer setorigin( newplayerorg );
                hostplayer setplayerangles( var_4273bc90e0c23d57 );
            }
            
            if ( !hostplayer isufo() )
            {
                hostplayer ufo();
            }
            
            setdvar( @"hash_f94addedc8e87b69", 2 );
            
            while ( hostplayer buttonpressed( "<dev string:x1d8>" ) || hostplayer buttonpressed( "<dev string:x1e0>" ) )
            {
                waitframe();
            }
            
            while ( !hostplayer buttonpressed( "<dev string:x1d8>" ) && !hostplayer buttonpressed( "<dev string:x1e0>" ) )
            {
                waitframe();
            }
            
            if ( hostplayer isufo() )
            {
                hostplayer ufo();
            }
            
            setdvar( @"hash_f94addedc8e87b69", 0 );
            
            if ( isdefined( self.activepack ) )
            {
                self.activepack function_46fc105ef7e82157( hostplayer, 1 );
            }
            
            hostplayer player_utility::function_dbe5a52a6654a982();
            hostplayer player_utility::function_9d378d725bb4831e( "<dev string:x1e8>" );
            hostplayer enablephysicaldepthoffieldscripting();
            
            while ( hostplayer buttonpressed( "<dev string:x1d8>" ) || hostplayer buttonpressed( "<dev string:x1e0>" ) )
            {
                waitframe();
            }
        }
    }

    // Namespace br_infils_common
    // Params 4, eflags: 0x4
    // Checksum 0x4eb6c3db, Offset: 0x67f8
    // Size: 0x8c, Type: dev
    function private function_279bb000a13d6ee6( player, buttonstring, keystring, var_4c8ab5f95e62bbbc )
    {
        while ( ( player buttonpressed( buttonstring ) || player buttonpressed( keystring ) ) && br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            waitframe();
        }
        
        while ( !player buttonpressed( buttonstring ) && !player buttonpressed( keystring ) && br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            if ( isdefined( var_4c8ab5f95e62bbbc ) && br_infils_util::function_e2a545749781eeb4() )
            {
                br_infils_util::function_4c779466069dbe9e();
                break;
            }
            
            waitframe();
        }
    }

    // Namespace br_infils_common
    // Params 0, eflags: 0x4
    // Checksum 0x80c05f32, Offset: 0x688c
    // Size: 0x100, Type: dev
    function private function_a26424f50a1d24b2()
    {
        c130pathstruct = undefined;
        
        if ( utility::issharedfuncdefined( #"gametype", #"createc130pathstruct" ) )
        {
            c130pathstruct = utility::callsharedfunc( #"gametype", #"createc130pathstruct" );
        }
        else
        {
            c130pathstruct = br_c130::createtestc130path( undefined, undefined );
        }
        
        level.infilstruct.c130pathstruct = c130pathstruct;
        br_c130::spawnc130( level.infilstruct.c130model, level.infilstruct.var_f265685cdcfee833, level.infilstruct.var_9d24745d02be135e, level.infilstruct.var_67c8deee3845395d, level.infilstruct.c130pathstruct, level.infilstruct.var_3ebd56e1708e1387 );
        level.infilstruct.c130 = level.br_ac130;
    }

    // Namespace br_infils_common
    // Params 0, eflags: 0x4
    // Checksum 0x7e947dd0, Offset: 0x6994
    // Size: 0x77, Type: dev
    function private function_e39f4c569ddb4b36()
    {
        if ( isdefined( level.infilstruct.c130 ) )
        {
            if ( isdefined( level.infilstruct.c130.innards ) )
            {
                level.infilstruct.c130.innards delete();
            }
            
            level.infilstruct.c130 delete();
        }
    }

    // Namespace br_infils_common
    // Params 0
    // Checksum 0x67d0a98b, Offset: 0x6a13
    // Size: 0x393, Type: dev
    function function_7930aebbba1855d()
    {
        hostplayer = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        while ( br_infils_util::function_6f01e2b77b9b7e5c() )
        {
            function_279bb000a13d6ee6( hostplayer, "<dev string:x1c2>", "<dev string:x20a>", 1 );
            
            if ( !br_infils_util::function_6f01e2b77b9b7e5c() )
            {
                break;
            }
            
            if ( !isdefined( level.infilstruct ) )
            {
                level.infilstruct = spawnstruct();
            }
            
            level.infilstruct.players = [ hostplayer ];
            startorigin = hostplayer.origin;
            startangles = hostplayer getplayerangles();
            outofbounds::enableoobimmunity( hostplayer );
            hostplayer thread [[ level.parachutetakeweaponscb ]]();
            players = level.infilstruct.players;
            level.infilstruct = spawnstruct();
            level.infilstruct.players = players;
            function_daaef2ba44d450df();
            function_a26424f50a1d24b2();
            animstruct = function_a8719d48afa1b495( level.infilstruct.c130 );
            
            if ( level.var_8f64d94451f73542 )
            {
                hostplayer predictstreamposuntilcleared( level.infilstruct.var_eebe498248baa141 );
                
                if ( level.var_8f64d94451f73542 && isdefined( level.infilstruct.prestream_scenesystem ) )
                {
                    [[ level.infilstruct.prestream_scenesystem ]]( animstruct );
                }
                
                wait 1;
                animstruct thread function_5065b5c9173828cc( 1 );
                function_279bb000a13d6ee6( hostplayer, "<dev string:x20c>", "<dev string:x216>" );
                animstruct notify( #"stopscene" );
                hostplayer clearpredictedstreampos();
                
                foreach ( player in level.players )
                {
                    player player::_freezelookcontrols( 0 );
                    player cameradefault();
                    player cameraunlink();
                    player stopxcam();
                    player lerpfov( 65, 0.5 );
                    
                    if ( player.var_5d1d2a9db3eeaa3f )
                    {
                        player disablephysicaldepthoffieldscripting();
                        player player::setdof_default();
                        player.var_5d1d2a9db3eeaa3f = undefined;
                    }
                }
                
                wait 1;
                
                foreach ( player in level.players )
                {
                    player setclientdvar( @"cg_fov", 65 );
                    player setclientdvar( @"cg_disable_user_fov", 0 );
                }
            }
            else
            {
                animstruct thread playinfilsequence( 1 );
                animstruct function_b3fc100f7154d153();
                function_279bb000a13d6ee6( hostplayer, "<dev string:x20c>", "<dev string:x216>" );
                animstruct function_d767a08ceb9e3087();
            }
            
            if ( isdefined( animstruct.cleanupfunc ) )
            {
                animstruct [[ animstruct.cleanupfunc ]]();
            }
            
            function_e39f4c569ddb4b36();
            hostplayer setorigin( startorigin );
            hostplayer setplayerangles( startangles );
            outofbounds::disableoobimmunity( hostplayer );
            wait 0.5;
        }
    }

    // Namespace br_infils_common
    // Params 0
    // Checksum 0xe69bdb36, Offset: 0x6dae
    // Size: 0x14, Type: dev
    function function_5e7c30c827f65843()
    {
        return getdvarint( @"hash_35a8afc828c370cb", 0 );
    }

    // Namespace br_infils_common
    // Params 0
    // Checksum 0x670d82c7, Offset: 0x6dca
    // Size: 0x15, Type: dev
    function function_486c89102889361c()
    {
        return getdvarint( @"hash_623aaa3d216921a", 4 );
    }

    // Namespace br_infils_common
    // Params 0
    // Checksum 0x64c60160, Offset: 0x6de7
    // Size: 0xe7, Type: dev
    function testdvarloop()
    {
        setdevdvarifuninitialized( @"br_infil_anim_pos", ( 5500, 0, 2000 ) );
        setdevdvarifuninitialized( @"hash_8545857262882e35", 0 );
        setdevdvarifuninitialized( @"hash_441165c7b355dd1b", -1 );
        setdevdvarifuninitialized( @"hash_35a8afc828c370cb", 0 );
        setdevdvarifuninitialized( @"hash_623aaa3d216921a", 4 );
        setdevdvarifuninitialized( @"hash_f6b3b7c2e066bf97", 0 );
        setdevdvarifuninitialized( @"hash_5dd356944d2c0dc5", 0 );
        setdevdvarifuninitialized( @"hash_783c8ff29b519ca5", 0 );
        wait 1;
        
        while ( true )
        {
            if ( br_infils_util::function_6f01e2b77b9b7e5c() )
            {
                function_7930aebbba1855d();
            }
            else if ( getdvarint( @"hash_783c8ff29b519ca5", 0 ) )
            {
                setdvar( @"hash_783c8ff29b519ca5", 0 );
                level.player thread [[ level.brlatespawnplayer ]]();
            }
            
            wait 0.25;
        }
    }

    // Namespace br_infils_common
    // Params 0
    // Checksum 0x1b984bec, Offset: 0x6ed6
    // Size: 0x14, Type: dev
    function function_35c1b8c3a14fd328()
    {
        return getdvarint( @"hash_5dd356944d2c0dc5", 0 );
    }

#/
