// scripts\mp\gametypes\multi_mode.gsc  (hash_027a52f376e386eb.gscc) (size: 88737 Bytes / 0x15aa1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x196ef9d1 (426703313)
// size ...... 88737 (0x15aa1)
// includes .. 45  (offset: 0x14849)
// strings ... 209 (offset: 0x149b1)
// dev strs .. 32  (offset: 0x158f1)
// exports ... 229 (offset: 0xdc6d)
// cseg ...... 0xe99 + 0xcdd4 (0xdc6d)
// imports ... 570 (offset: 0x10035)
// animtree1 . 0   (offset: 0x15aa1)
// animtree2 . 0   (offset: 0x15aa1)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\callouts;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\weapons\roulette_gun;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dogtag;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;

#namespace multi_mode;

// Namespace multi_mode
// Params 0
// Checksum 0x1e325889, Offset: 0xeb7
// Size: 0x212
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    allowed[ 1 ] = "conf";
    allowed[ 2 ] = "dom";
    allowed[ 3 ] = "hardpoint";
    allowed[ 4 ] = "tdm";
    allowed[ 5 ] = "hvt";
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_damaged", &onplayerdamaged );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.dogtagsenabled = 0;
    level.onstartgametype = &onstartgametype;
    level.ontimelimit = &ontimelimit;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.var_b8c14453f58b44df = &function_5b6010b72d65159e;
    level.var_93532ab90ccea78c = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_multi_mode" );
    
    if ( isdefined( level.var_93532ab90ccea78c.rgun_spawnvfx ) )
    {
        level._effect[ #"rgun_vfx" ] = loadfx( level.var_93532ab90ccea78c.rgun_spawnvfx );
    }
    
    if ( isdefined( level.var_93532ab90ccea78c.var_afe00b1d09198563 ) )
    {
        level._effect[ #"hash_5fe798776164d9a1" ] = loadfx( level.var_93532ab90ccea78c.var_afe00b1d09198563 );
    }
    
    /#
        setdvarifuninitialized( @"hash_f2deed849be2d299", "<dev string:x24>" );
        level thread function_7898c2ce8d367154();
    #/
}

// Namespace multi_mode
// Params 0
// Checksum 0x96c60fd1, Offset: 0x10d1
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace multi_mode
// Params 0
// Checksum 0xa9ed7229, Offset: 0x10e2
// Size: 0x1b2
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/multi_mode" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/multi_mode" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"hash_2ff879a5d8261b3b" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"hash_31d0cf9b9c7f4f06" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    level.var_709caf807ba884ea = [];
    function_75cf7b2c9502e831( 0 );
    
    if ( level.var_93532ab90ccea78c.var_efb7b089971f52e7 )
    {
        function_6615f58a303259ae();
    }
    
    function_db09e70b835008da();
    function_2d43a6aa7711e62d();
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x25>" );
        devgui::add_devgui_func( "<dev string:x3d>", "<dev string:x71>", &function_f04c764cba81db4f );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace multi_mode
// Params 0
// Checksum 0xf3de34d6, Offset: 0x129c
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace multi_mode
// Params 1
// Checksum 0xe2b8ae71, Offset: 0x12ad
// Size: 0xd0
function function_75cf7b2c9502e831( var_a68d83190cbd91b0 )
{
    if ( var_a68d83190cbd91b0 )
    {
        level.scoremod[ "kill" ] = getmatchrulesdata( "commonOption", "pointsPerKill" );
        level.scoremod[ "death" ] = getmatchrulesdata( "commonOption", "pointsPerDeath" );
        level.scoremod[ "headshot" ] = getmatchrulesdata( "commonOption", "pointsHeadshotBonus" );
        level.scoremod[ "kskill" ] = getmatchrulesdata( "commonOption", "pointsPerKSKill" );
        return;
    }
    
    level.scoremod[ "kill" ] = 0;
    level.scoremod[ "death" ] = 0;
    level.scoremod[ "headshot" ] = 0;
    level.scoremod[ "kskill" ] = 0;
}

// Namespace multi_mode
// Params 0
// Checksum 0x51c1277e, Offset: 0x1385
// Size: 0x3ed
function function_db09e70b835008da()
{
    level.var_7ce21c44b629266c = 0;
    level.var_9dc930cda807660d = level.var_93532ab90ccea78c.var_9dc930cda807660d;
    level.var_3b2cce0500a137f = level.var_93532ab90ccea78c.var_3b2cce0500a137f;
    game[ "mini_gametypes" ] = [];
    index = 0;
    
    foreach ( minigametype in level.var_93532ab90ccea78c.var_79ded58f3e70ecbf )
    {
        switch ( minigametype.var_e5dda7c58497530 )
        {
            case #"hash_bbae50b05f43fc4b":
                function_32de575cb560c4b4( #"hash_bbae50b05f43fc4b", index, 0, &function_af71ad89cafa5bd9, undefined, &tdm_onspawnplayer, undefined, undefined, &tdm_onplayerkilled, minigametype.timelimit ?? 90, &function_3dbc00c5a41d22c8, undefined, minigametype.splashref );
                
                if ( level.var_9dc930cda807660d )
                {
                    index++;
                    function_32de575cb560c4b4( #"piggy_bank", index, 1, &function_c6002b1189ea7fe8, undefined, &function_2fb22f25a564f66a, undefined, undefined, &tdm_onplayerkilled, level.var_93532ab90ccea78c.pbank_timelimit ?? 30, &function_7f941b35fc96e679, &pbank_oninit, level.var_93532ab90ccea78c.var_e4655369495a9cac );
                }
                
                break;
            case #"hash_4071674fc303e25a":
                function_32de575cb560c4b4( #"hash_4071674fc303e25a", index, 0, &function_89ce5385906e3200, undefined, &kc_onspawnplayer, undefined, undefined, undefined, minigametype.timelimit ?? 120, &function_343dacf8c6631ba1, &kc_initdata, minigametype.splashref );
                break;
            case #"hash_cd755ac179aea3b0":
                function_32de575cb560c4b4( #"hash_cd755ac179aea3b0", index, 0, &function_f464472089673fca, &rgun_onplayerdisconnect, &rgun_onspawnplayer, undefined, undefined, &rgun_onplayerkilled, minigametype.timelimit ?? 120, &function_ffa8c47e0f42817f, undefined, minigametype.splashref );
                break;
            case #"hardpoint":
                function_32de575cb560c4b4( #"hardpoint", index, 0, &function_29bd828380390948, &koth_onplayerdisconnect, &koth_onspawnplayer, &koth_getspawnpoint, undefined, &koth_onplayerkilled, minigametype.timelimit ?? 120, &function_885c6977159f7fd9, &koth_initdata, minigametype.splashref );
                break;
            case #"domination":
                function_32de575cb560c4b4( #"domination", index, 0, &function_59a73944bee6e872, undefined, &dom_onspawnplayer, &dom_getspawnpoint, undefined, &dom_onplayerkilled, minigametype.timelimit ?? 120, &function_7ed7f879861c5657, &dom_initdata, minigametype.splashref );
                break;
            case #"hvt":
                function_32de575cb560c4b4( #"hvt", index, 0, &function_b9a0a684a48c240c, &hvt_onplayerdisconnect, &hvt_onspawnplayer, undefined, &hvt_onplayerdamaged, &hvt_onplayerkilled, minigametype.timelimit ?? 120, &function_9a9c4d32e60542d5, &hvt_initdata, minigametype.splashref );
                break;
            default:
                assertmsg( "<dev string:x9c>" + minigametype.var_e5dda7c58497530 );
                continue;
        }
        
        index++;
    }
    
    level.var_d74199afbc210abb = level.var_7ce21c44b629266c >= level.timelimit;
    level.var_6267fb272f19d462 = level.var_7ce21c44b629266c == level.timelimit;
    level.var_1a163f0b8debe198 = level.timelimit * 1000;
}

// Namespace multi_mode
// Params 13
// Checksum 0x62515401, Offset: 0x177a
// Size: 0x1f0
function function_32de575cb560c4b4( ref, index, skipselection, startfunc, var_e51dc4e13bac35f, onspawnfunc, getspawnpointfunc, onplayerdamagedfunc, onplayerkilledfunc, timelimit, endfunc, var_c3180a9ecb5de74e, splashref )
{
    assert( isdefined( ref ), "<dev string:xc3>" );
    key = level.var_3b2cce0500a137f ? ref : index;
    game[ "mini_gametypes" ][ key ] = {};
    game[ "mini_gametypes" ][ key ].ref = ref;
    game[ "mini_gametypes" ][ key ].index = index;
    game[ "mini_gametypes" ][ key ].skipselection = skipselection;
    game[ "mini_gametypes" ][ key ].var_9f9a87a281337f7f = startfunc;
    game[ "mini_gametypes" ][ key ].onplayerdisconnect = var_e51dc4e13bac35f;
    game[ "mini_gametypes" ][ key ].onplayerspawn = onspawnfunc;
    game[ "mini_gametypes" ][ key ].getspawnpoint = getspawnpointfunc;
    game[ "mini_gametypes" ][ key ].onplayerdamaged = onplayerdamagedfunc;
    game[ "mini_gametypes" ][ key ].onplayerkilled = onplayerkilledfunc;
    game[ "mini_gametypes" ][ key ].timelimit = timelimit;
    game[ "mini_gametypes" ][ key ].var_3d0a18437a57e2ea = endfunc;
    game[ "mini_gametypes" ][ key ].splashref = splashref;
    assert( timelimit > 0, "<dev string:xe8>" );
    level.var_7ce21c44b629266c += timelimit;
    
    if ( isdefined( var_c3180a9ecb5de74e ) )
    {
        thread [[ var_c3180a9ecb5de74e ]]( key );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x139d9837, Offset: 0x1972
// Size: 0x387
function function_2d43a6aa7711e62d()
{
    if ( !level.var_3b2cce0500a137f )
    {
        if ( !isdefined( level.var_1041334232c89685 ) )
        {
            level.var_1041334232c89685 = 0;
        }
        
        if ( level.var_1041334232c89685 == game[ "mini_gametypes" ].size )
        {
            level.var_1041334232c89685 = 0;
        }
        
        level.var_f0ff8e3c752b9d2a = game[ "mini_gametypes" ][ level.var_1041334232c89685 ];
        level.var_1041334232c89685++;
        thread function_c5fd97900ef62b0b();
        return;
    }
    
    resetlist = 0;
    
    if ( level.var_709caf807ba884ea.size == game[ "mini_gametypes" ].size - 1 )
    {
        level.var_709caf807ba884ea = [];
        resetlist = 1;
        level.var_3d0e8c2da7c44abd = 1;
    }
    
    if ( isdefined( level.var_f0ff8e3c752b9d2a ) )
    {
        level.var_709caf807ba884ea[ level.var_f0ff8e3c752b9d2a.ref ] = 1;
        
        if ( resetlist && level.var_f0ff8e3c752b9d2a.ref == #"piggy_bank" )
        {
            level.var_709caf807ba884ea[ #"hash_bbae50b05f43fc4b" ] = 1;
        }
    }
    
    if ( level.var_6267fb272f19d462 && level.var_9dc930cda807660d && level.var_709caf807ba884ea.size == game[ "mini_gametypes" ].size - 3 )
    {
        if ( !level.var_709caf807ba884ea[ #"hash_bbae50b05f43fc4b" ] )
        {
            level.var_74ae00acfd3ba082 = #"hash_bbae50b05f43fc4b";
        }
    }
    
    if ( isdefined( level.var_74ae00acfd3ba082 ) )
    {
        level.var_f0ff8e3c752b9d2a = game[ "mini_gametypes" ][ level.var_74ae00acfd3ba082 ];
        level.var_74ae00acfd3ba082 = undefined;
    }
    else
    {
        var_a01ead0cf0bb5e23 = [];
        
        foreach ( minigametype in game[ "mini_gametypes" ] )
        {
            if ( level.var_709caf807ba884ea[ minigametype.ref ] == 1 )
            {
                continue;
            }
            
            if ( game[ "mini_gametypes" ][ minigametype.ref ].skipselection == 1 )
            {
                continue;
            }
            
            if ( !level.var_6267fb272f19d462 && level.var_9dc930cda807660d && minigametype.ref == #"hash_bbae50b05f43fc4b" )
            {
                var_77c6d5950a8a0421 = game_utility::gettimepassed() + ( minigametype.timelimit + game[ "mini_gametypes" ][ #"piggy_bank" ].timelimit ) * 1000;
                
                if ( level.var_1a163f0b8debe198 <= var_77c6d5950a8a0421 )
                {
                    continue;
                }
            }
            
            var_a01ead0cf0bb5e23[ var_a01ead0cf0bb5e23.size ] = minigametype.ref;
        }
        
        if ( var_a01ead0cf0bb5e23.size > 0 )
        {
            index = 0;
            
            if ( var_a01ead0cf0bb5e23.size > 1 )
            {
                index = randomint( var_a01ead0cf0bb5e23.size );
            }
            
            level.var_f0ff8e3c752b9d2a = game[ "mini_gametypes" ][ var_a01ead0cf0bb5e23[ index ] ];
        }
        else
        {
            level.var_f0ff8e3c752b9d2a = level.var_f0ff8e3c752b9d2a.ref == #"domination" ? game[ "mini_gametypes" ][ #"hardpoint" ] : game[ "mini_gametypes" ][ #"domination" ];
        }
    }
    
    thread function_c5fd97900ef62b0b();
}

// Namespace multi_mode
// Params 1
// Checksum 0xccf91780, Offset: 0x1d01
// Size: 0x4e
function function_5f3ccced3d90f2b0( timelimit )
{
    counttime = int( timelimit ) - 1;
    
    while ( counttime > 0 && !level.gameended )
    {
        setomnvar( "ui_mini_gametype_countdown", counttime );
        counttime--;
        wait 1;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x771925d8, Offset: 0x1d57
// Size: 0x6c
function function_8c8e8cd222ea15a2( timelimit )
{
    if ( level.var_9dc930cda807660d )
    {
        index = #"piggy_bank";
        
        if ( !level.var_3b2cce0500a137f )
        {
            index = level.var_f0ff8e3c752b9d2a.index + 1;
        }
        
        timelimit += game[ "mini_gametypes" ][ index ].timelimit;
    }
    
    return timelimit;
}

// Namespace multi_mode
// Params 0
// Checksum 0xc199904f, Offset: 0x1dcc
// Size: 0x428
function function_c5fd97900ef62b0b()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    level gamelogic_mp::pausetimer();
    starttime = gettime();
    timelimit = level.var_f0ff8e3c752b9d2a.timelimit;
    level.var_cda6c691a06ec205 = starttime + timelimit * 1000;
    
    if ( flags::gameflag( "intro_boost_vo_done" ) && !level.var_f0ff8e3c752b9d2a.skipselection )
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"mode_switch", level.players );
    }
    
    if ( level.var_93532ab90ccea78c.var_efb7b089971f52e7 )
    {
        if ( !level.var_f0ff8e3c752b9d2a.skipselection )
        {
            thread function_da7c88e2d90e476e();
        }
        else
        {
            foreach ( effect in level.var_b189962d15b4781 )
            {
                if ( isdefined( effect.var_9f9a87a281337f7f ) )
                {
                    thread [[ effect.var_9f9a87a281337f7f ]]();
                }
            }
        }
    }
    
    setomnvar( "ui_multi_current_gametype", function_33effd8dafba6bd6( level.var_f0ff8e3c752b9d2a.ref ) + 1 );
    
    if ( isdefined( level.var_f0ff8e3c752b9d2a.var_9f9a87a281337f7f ) )
    {
        [[ level.var_f0ff8e3c752b9d2a.var_9f9a87a281337f7f ]]( starttime );
    }
    
    thread function_53243462b456f774( timelimit );
    
    if ( level.var_f0ff8e3c752b9d2a.ref != #"piggy_bank" )
    {
        totaltimelimit = level.var_f0ff8e3c752b9d2a.ref == #"hash_bbae50b05f43fc4b" ? function_8c8e8cd222ea15a2( timelimit ) : timelimit;
        thread function_5f3ccced3d90f2b0( totaltimelimit );
    }
    
    level gamelogic_mp::resumetimer();
    level utility::waittill_notify_or_timeout( #"hash_b078537ed80e7487", timelimit );
    level notify( #"hash_56dbbc54f182022" );
    level gamelogic_mp::pausetimer();
    
    if ( isdefined( level.var_93532ab90ccea78c.var_56770f895ea91b3e.part ) && isdefined( level.var_93532ab90ccea78c.var_56770f895ea91b3e.state ) )
    {
        foreach ( player in level.players )
        {
            player setscriptablepartstate( level.var_93532ab90ccea78c.var_56770f895ea91b3e.part, level.var_93532ab90ccea78c.var_56770f895ea91b3e.state );
        }
    }
    
    if ( level.var_93532ab90ccea78c.var_efb7b089971f52e7 )
    {
        foreach ( effect in level.var_b189962d15b4781 )
        {
            if ( isdefined( effect.var_3d0a18437a57e2ea ) )
            {
                [[ effect.var_3d0a18437a57e2ea ]]();
            }
        }
    }
    
    if ( isdefined( level.var_f0ff8e3c752b9d2a.var_3d0a18437a57e2ea ) )
    {
        [[ level.var_f0ff8e3c752b9d2a.var_3d0a18437a57e2ea ]]();
    }
    
    level gamelogic_mp::resumetimer();
    
    if ( level.var_1a163f0b8debe198 == game_utility::gettimepassed() )
    {
        return;
    }
    
    function_2d43a6aa7711e62d();
}

// Namespace multi_mode
// Params 1
// Checksum 0x6711c0a7, Offset: 0x21fc
// Size: 0xe7
function function_acb0ea87ba58b65a( var_f0ff8e3c752b9d2a )
{
    playersscore = undefined;
    
    if ( var_f0ff8e3c752b9d2a.ref == #"piggy_bank" )
    {
        tdm_deathcount = getomnvar( "ui_multi_tdm_death_count" );
        points = rank::getscoreinfovalue( #"hash_63303757998cb656" );
        playersscore = tdm_deathcount * points;
    }
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( var_f0ff8e3c752b9d2a.splashref, playersscore );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x4ac216e, Offset: 0x22eb
// Size: 0xdf
function function_53243462b456f774( timelimit )
{
    self notify( #"hash_40f55b3715b8822b" );
    self endon( #"hash_40f55b3715b8822b" );
    
    if ( level.var_3d0e8c2da7c44abd || level.var_709caf807ba884ea.size > 0 )
    {
        function_acb0ea87ba58b65a( level.var_f0ff8e3c752b9d2a );
    }
    
    var_d2ef86766d74e251 = game_utility::gettimepassed() + timelimit * 1000;
    
    if ( level.var_1a163f0b8debe198 <= var_d2ef86766d74e251 )
    {
        return;
    }
    
    if ( level.var_f0ff8e3c752b9d2a.ref == #"hash_bbae50b05f43fc4b" && level.var_9dc930cda807660d )
    {
        return;
    }
    
    wait timelimit - 10;
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"mode_switch_warning", level.players );
    dialog::leaderdialogonplayers( #"hash_9c62e4378f83d3c8", level.players );
}

// Namespace multi_mode
// Params 0
// Checksum 0x19c4df13, Offset: 0x23d2
// Size: 0xd1
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace multi_mode
// Params 0
// Checksum 0xda86de75, Offset: 0x24ab
// Size: 0x3a
function getspawnpoint()
{
    if ( isdefined( level.var_f0ff8e3c752b9d2a.getspawnpoint ) )
    {
        return [[ level.var_f0ff8e3c752b9d2a.getspawnpoint ]]();
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace multi_mode
// Params 1
// Checksum 0xc95cf6f8, Offset: 0x24ed
// Size: 0x3c
function onplayerdisconnect( disconnectdata )
{
    if ( isdefined( level.var_f0ff8e3c752b9d2a.onplayerdisconnect ) )
    {
        self [[ level.var_f0ff8e3c752b9d2a.onplayerdisconnect ]]( disconnectdata );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x90ce8c91, Offset: 0x2531
// Size: 0xe2
function onspawnplayer( spawndata )
{
    if ( isdefined( level.var_f0ff8e3c752b9d2a.onplayerspawn ) )
    {
        self [[ level.var_f0ff8e3c752b9d2a.onplayerspawn ]]( spawndata );
    }
    
    if ( level.var_93532ab90ccea78c.var_efb7b089971f52e7 )
    {
        foreach ( effect in level.var_b189962d15b4781 )
        {
            if ( isdefined( effect.onplayerspawn ) )
            {
                self thread [[ effect.onplayerspawn ]]( spawndata );
            }
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x9b2ea335, Offset: 0x261b
// Size: 0x3c
function onplayerdamaged( damagedata )
{
    if ( isdefined( level.var_f0ff8e3c752b9d2a.onplayerdamaged ) )
    {
        self [[ level.var_f0ff8e3c752b9d2a.onplayerdamaged ]]( damagedata );
    }
}

// Namespace multi_mode
// Params 6
// Checksum 0x67bab1aa, Offset: 0x265f
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace multi_mode
// Params 1
// Checksum 0x5bfc00de, Offset: 0x26af
// Size: 0x13b
function function_8314535b81f548e( deathdata )
{
    victim = deathdata.victim;
    
    if ( isdefined( level.var_f0ff8e3c752b9d2a.onplayerkilled ) )
    {
        victim [[ level.var_f0ff8e3c752b9d2a.onplayerkilled ]]( deathdata );
    }
    
    if ( isdefined( level.sharedfuncs[ #"multimode" ][ #"onplayerkilled" ] ) )
    {
        victim [[ level.sharedfuncs[ #"multimode" ][ #"onplayerkilled" ] ]]( deathdata );
    }
    
    if ( level.var_93532ab90ccea78c.var_efb7b089971f52e7 )
    {
        foreach ( effect in level.var_b189962d15b4781 )
        {
            if ( isdefined( effect.onplayerkilled ) )
            {
                victim thread [[ effect.onplayerkilled ]]( deathdata );
            }
        }
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x3447774b, Offset: 0x27f2
// Size: 0x36
function ontimelimit()
{
    winner = gamescore::gethighestscoringteam();
    level notify( #"hash_56dbbc54f182022" );
    thread gamelogic_mp::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace multi_mode
// Params 0
// Checksum 0xea5d51ae, Offset: 0x2830
// Size: 0x70
function function_80b0d9f463e7cc72()
{
    level.icontarget = undefined;
    level.iconneutral = undefined;
    level.iconcapture = undefined;
    level.icondefend = undefined;
    level.icondefending = undefined;
    level.iconcontested = undefined;
    level.icontaking = undefined;
    level.iconlosing = undefined;
    level.iconnext = undefined;
    level.iconclearing = undefined;
    level.iconreinforcing = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0x39308219, Offset: 0x28a8
// Size: 0x6c
function function_33effd8dafba6bd6( gametype )
{
    return function_265b9bf821a6da34( level.gametypebundle.additionalscriptbundles[ 1 ].var_33ebe182767e4f6e, level.var_93532ab90ccea78c.var_b96545ae9bfcac55.arrayname, level.var_93532ab90ccea78c.var_b96545ae9bfcac55.key, gametype );
}

// Namespace multi_mode
// Params 0
// Checksum 0xd599919d, Offset: 0x291d
// Size: 0x314
function function_6615f58a303259ae()
{
    game[ "round_status_effects" ] = [];
    effectspopulated = [];
    index = 0;
    
    foreach ( var_6eab6acfdbb0fd41 in level.var_93532ab90ccea78c.var_c1a671620286c30d )
    {
        if ( isdefined( effectspopulated[ var_6eab6acfdbb0fd41.var_e3df95d10c8a6869 ] ) )
        {
            assertmsg( "<dev string:xfa>" + var_6eab6acfdbb0fd41.var_e3df95d10c8a6869 );
            continue;
        }
        
        switch ( var_6eab6acfdbb0fd41.var_e3df95d10c8a6869 )
        {
            case #"double_health":
                function_4e16f699598d8b86( #"double_health", index, &function_217f469fbc4dec9b, &function_4cac371821462adb, undefined, &function_6ff935b37ea192fe, &dhealth_init, var_6eab6acfdbb0fd41 );
                break;
            case #"double_jump":
                function_4e16f699598d8b86( #"double_jump", index, &djump_start, &function_e0f0a0031f31955, undefined, &djump_end, &function_d882a74228bcbd85, var_6eab6acfdbb0fd41 );
                break;
            case #"hard_core":
                function_4e16f699598d8b86( #"hard_core", index, &function_76b23e9962a9fee, &function_591738be8a245e52, undefined, &function_6b1f374eda750d5b, &function_c555eb09ded38b04, var_6eab6acfdbb0fd41 );
                break;
            case #"fake_sounds":
                function_4e16f699598d8b86( #"fake_sounds", index, &function_c8dddb178647f4b7, &function_1526ca628622f27, undefined, &function_19036c82e38b32b2, &function_2d6a5781d847c50b, var_6eab6acfdbb0fd41 );
                break;
            case #"fake_visuals":
                function_4e16f699598d8b86( #"fake_visuals", index, &function_6132050de921088a, &function_388cc5afade184ce, undefined, &function_f038d6ceaf677a3f, &function_f9d08dec51226038, var_6eab6acfdbb0fd41 );
                break;
            case #"free_score":
                function_4e16f699598d8b86( #"free_score", index, &function_87bcd3d0b73a0209, &function_4086451352cc13c5, undefined, &function_4de44666c73d3f78, undefined, var_6eab6acfdbb0fd41 );
                break;
            case #"hash_1be9be0c700155f0":
                function_4e16f699598d8b86( #"hash_1be9be0c700155f0", index, &gravity_start, &gravity_onspawn, undefined, &gravity_end, &gravity_init, var_6eab6acfdbb0fd41 );
                break;
            case #"super_speed":
                function_4e16f699598d8b86( #"super_speed", index, &function_f623eaf4de0d8a1d, &function_b45a2ac1a6ee8d39, undefined, &function_a776fd58dcd4664, &function_b1919b7402ed821, var_6eab6acfdbb0fd41 );
                break;
            case #"third_person":
                function_4e16f699598d8b86( #"third_person", index, &function_11b7cea663a29768, undefined, undefined, &function_cb55f513d08e31f9, undefined, var_6eab6acfdbb0fd41 );
                break;
            case #"none":
            default:
                assertmsg( "<dev string:x133>" + var_6eab6acfdbb0fd41.var_e3df95d10c8a6869 );
                continue;
        }
        
        effectspopulated[ var_6eab6acfdbb0fd41.var_e3df95d10c8a6869 ] = 1;
        index++;
    }
}

// Namespace multi_mode
// Params 8
// Checksum 0x4e565418, Offset: 0x2c39
// Size: 0x121
function function_4e16f699598d8b86( ref, index, startfunc, onspawnfunc, onplayerkilledfunc, endfunc, var_c3180a9ecb5de74e, var_6eab6acfdbb0fd41 )
{
    assert( isdefined( ref ), "<dev string:xc3>" );
    game[ "round_status_effects" ][ index ] = {};
    game[ "round_status_effects" ][ index ].ref = ref;
    game[ "round_status_effects" ][ index ].var_9f9a87a281337f7f = startfunc;
    game[ "round_status_effects" ][ index ].onplayerspawn = onspawnfunc;
    game[ "round_status_effects" ][ index ].onplayerkilled = onplayerkilledfunc;
    game[ "round_status_effects" ][ index ].var_3d0a18437a57e2ea = endfunc;
    game[ "round_status_effects" ][ index ].tunable = var_6eab6acfdbb0fd41.tunable;
    game[ "round_status_effects" ][ index ].var_8a1f9544bbd417eb = var_6eab6acfdbb0fd41.var_8a1f9544bbd417eb;
    
    if ( isdefined( var_c3180a9ecb5de74e ) )
    {
        thread [[ var_c3180a9ecb5de74e ]]( index );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xb4275b76, Offset: 0x2d62
// Size: 0x283
function function_da7c88e2d90e476e()
{
    assert( game[ "<dev string:x15f>" ].size > 0, "<dev string:x174>" );
    setomnvar( "ui_active_status_effects", 0 );
    var_a1e9ecf0c0acaca = int( min( level.var_93532ab90ccea78c.var_a1e9ecf0c0acaca ? level.var_93532ab90ccea78c.var_a1e9ecf0c0acaca : game[ "round_status_effects" ].size, game[ "round_status_effects" ].size ) );
    mineffects = int( min( level.var_93532ab90ccea78c.mineffects ? level.var_93532ab90ccea78c.mineffects : 0, var_a1e9ecf0c0acaca ) );
    numeffects = randomintrange( mineffects, var_a1e9ecf0c0acaca + 1 );
    level.var_b189962d15b4781 = [];
    
    for ( num = 0; num < numeffects ; num++ )
    {
        reroll = 1;
        rerollattempts = 0;
        effectindex = 0;
        
        while ( reroll && rerollattempts < 10 )
        {
            reroll = 0;
            effectindex = randomint( game[ "round_status_effects" ].size );
            effect = game[ "round_status_effects" ][ effectindex ];
            
            if ( effect.ref == #"none" || level.var_b189962d15b4781[ effect.ref ] )
            {
                reroll = 1;
                rerollattempts++;
                continue;
            }
            
            foreach ( var_6eab6acfdbb0fd41 in level.var_b189962d15b4781 )
            {
                if ( var_6eab6acfdbb0fd41.var_8a1f9544bbd417eb == effect.ref )
                {
                    reroll = 1;
                    rerollattempts++;
                    break;
                }
            }
        }
        
        if ( rerollattempts >= 10 )
        {
            assertmsg( "<dev string:x1b5>" + numeffects + "<dev string:x200>" + num + "<dev string:x212>" );
            break;
        }
        
        level.var_b189962d15b4781[ effect.ref ] = effect;
        function_a9a8165656e26139( "ui_active_status_effects", effectindex, 1, 1 );
        
        if ( isdefined( effect.var_9f9a87a281337f7f ) )
        {
            thread [[ effect.var_9f9a87a281337f7f ]]();
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x9f8b69f1, Offset: 0x2fed
// Size: 0x33
function function_af71ad89cafa5bd9( var_b84e5730f2d9c89c )
{
    thread function_82654bf32a45d52();
    level.tdm_deathcount = 1;
    setomnvar( "ui_multi_tdm_death_count", 1 );
    function_75cf7b2c9502e831( 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x457c56b0, Offset: 0x3028
// Size: 0x7a
function function_82654bf32a45d52()
{
    if ( !flags::gameflag( "intro_boost_vo_done" ) )
    {
        flags::gameflagwait( "intro_boost_vo_done" );
    }
    
    dialog::leaderdialogonplayers( #"gametype_tdm", level.players );
    wait 4;
    
    if ( level.var_9dc930cda807660d )
    {
        dialog::leaderdialogonplayers( #"hash_8d0478c9029ab956", level.players );
        return;
    }
    
    dialog::leaderdialogonplayers( #"gametype_tdm_boost", level.players );
}

// Namespace multi_mode
// Params 1
// Checksum 0xf4285532, Offset: 0x30aa
// Size: 0x1c
function tdm_onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace multi_mode
// Params 1
// Checksum 0x14055ea4, Offset: 0x30ce
// Size: 0xf9
function tdm_onplayerkilled( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    
    if ( victim damage::issuicide( deathdata.inflictor, attacker, deathdata.meansofdeath, deathdata.objweapon ) || victim damage::isteamkill( deathdata.inflictor, attacker ) )
    {
        return;
    }
    
    if ( !level.scoremod[ "kill" ] )
    {
        level gamescore::giveteamscoreforobjective( attacker.team, 1, 0 );
    }
    
    if ( level.var_9dc930cda807660d && level.var_f0ff8e3c752b9d2a.ref == #"hash_bbae50b05f43fc4b" )
    {
        level.tdm_deathcount++;
        setomnvar( "ui_multi_tdm_death_count", minint( level.tdm_deathcount, 100 ) );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x1e518edc, Offset: 0x31cf
// Size: 0x35
function function_3dbc00c5a41d22c8()
{
    if ( level.var_9dc930cda807660d )
    {
        level.var_74ae00acfd3ba082 = #"piggy_bank";
        return;
    }
    
    level.tdm_deathcount = undefined;
    function_75cf7b2c9502e831( 0 );
}

// Namespace multi_mode
// Params 0
// Checksum 0xbd942733, Offset: 0x320c
// Size: 0x1f, Type: bool
function is_tdm_active()
{
    return level.var_f0ff8e3c752b9d2a.ref == #"hash_bbae50b05f43fc4b";
}

// Namespace multi_mode
// Params 1
// Checksum 0x9a6b2c9e, Offset: 0x3234
// Size: 0x3d
function pbank_oninit( index )
{
    gamelogic_mp::setwaypointiconinfo( "pbank_spawned", 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", level.var_93532ab90ccea78c.var_cb45ec37ebb5b94b, 0, 1 );
}

// Namespace multi_mode
// Params 1
// Checksum 0x3a522e6c, Offset: 0x3279
// Size: 0x205
function function_c6002b1189ea7fe8( var_b84e5730f2d9c89c )
{
    if ( isdefined( level.pbank_zones ) )
    {
        foreach ( existingzone in level.pbank_zones )
        {
            function_8e8840a31970a1d( existingzone.useobject, existingzone );
        }
    }
    
    level.var_9854aef3af327482 = level.var_93532ab90ccea78c.var_f673e24622ac66a1 ?? 1;
    
    if ( level.var_9854aef3af327482 < 1 )
    {
        level.var_9854aef3af327482 = 1;
    }
    
    level.pbank_zones = [];
    thread function_f6534f4b758787b7();
    function_fab65e86dd9ecf2a();
    var_c5a40b65f3e17f94 = level.tdm_deathcount;
    var_c3fddb95015b321b = int( var_c5a40b65f3e17f94 / level.var_9854aef3af327482 );
    
    if ( var_c3fddb95015b321b < 1 )
    {
        var_c3fddb95015b321b = 1;
    }
    
    for ( i = 0; i < level.var_9854aef3af327482 ; i++ )
    {
        if ( i == 0 && isdefined( level.var_54c13ada4615946d ) )
        {
            bestzoneindex = [[ level.var_54c13ada4615946d ]]();
        }
        else
        {
            bestzoneindex = function_aecec0bec7bfd465( 0 );
        }
        
        if ( !isdefined( bestzoneindex ) || !isdefined( level.koth_objectives[ bestzoneindex ] ) )
        {
            break;
        }
        
        zone = level.koth_objectives[ bestzoneindex ];
        zone.pbank_origin = getclosestpointonnavmesh( zone.curorigin );
        level.pbank_zones[ level.pbank_zones.size ] = zone;
        level.pbank_zone = zone;
        zone function_8eb0e1ed0f18682( i == 0 );
        function_5c1fb83362152af2( zone, var_c3fddb95015b321b );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x9f337e7c, Offset: 0x3486
// Size: 0x50
function function_f6534f4b758787b7()
{
    dialog::leaderdialogonplayers( #"gametype_pbank", level.players );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"bank_avail", level.players );
    wait 4;
    dialog::leaderdialogonplayers( #"hash_777ca226eefe1d76", level.players );
}

// Namespace multi_mode
// Params 1
// Checksum 0xcda9fdf6, Offset: 0x34de
// Size: 0xb2
function function_8eb0e1ed0f18682( var_39d3cf45590fc0af = 1 )
{
    zone = self;
    reservedid = var_39d3cf45590fc0af ? 3 : undefined;
    zone gameobjects::requestid( 1, 1, reservedid, 1, 0 );
    level objidpoolmanager::update_objective_position( zone.objidnum, zone.pbank_origin + ( 0, 0, 60 ) );
    level objidpoolmanager::function_e4d6a71507372662( zone.objidnum, 0 );
    zone gameobjects::setvisibleteam( "any" );
    function_ca1cc2938b2b4271( zone.objidnum, zone.trigger );
}

// Namespace multi_mode
// Params 0
// Checksum 0x3ca456a7, Offset: 0x3598
// Size: 0x6f
function function_71465a8b45e7ab25()
{
    zone = self;
    level objidpoolmanager::update_objective_position( zone.objidnum, zone.visuals[ 0 ].origin + zone.offset3d );
    function_ca30be9f04600a82( zone.objidnum );
    zone gameobjects::setvisibleteam( "none" );
    zone gameobjects::releaseid( 1, 0 );
}

// Namespace multi_mode
// Params 0
// Checksum 0xa8bddb63, Offset: 0x360f
// Size: 0x10
function function_fab65e86dd9ecf2a()
{
    level.var_5bc938b43fd2f322 = "pbank_spawned";
}

// Namespace multi_mode
// Params 1
// Checksum 0x9cd05967, Offset: 0x3627
// Size: 0x1c
function function_2fb22f25a564f66a( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"multi_piggy_bank" );
}

// Namespace multi_mode
// Params 2
// Checksum 0x8d9bceb2, Offset: 0x364b
// Size: 0x11e
function function_5c1fb83362152af2( zone, var_20285537983744e6 )
{
    useobject = spawn( "script_model", zone.pbank_origin );
    useobject setmodel( level.var_93532ab90ccea78c.pbank_asset ?? %"hash_a7ac02db5579075" );
    
    if ( useobject getscriptableparthasstate( #"pulse", #"on" ) )
    {
        useobject setscriptablepartstate( #"pulse", #"on" );
    }
    
    useobject makeusable();
    useobject setuserange( 100 );
    useobject setuseholdduration( 5000 );
    useobject setcursorhint( "HINT_NOICON" );
    useobject sethintdisplayrange( 100 );
    useobject sethintstring( &"mp_ingame_only/pick_up_cash" );
    useobject.var_20285537983744e6 = var_20285537983744e6;
    useobject.pbank_zone = zone;
    zone.useobject = useobject;
    zone.iconname = undefined;
    zone gameobjects::setobjectivestatusicons( level.var_5bc938b43fd2f322 );
    useobject thread function_20ed70136032e3ca();
}

// Namespace multi_mode
// Params 0
// Checksum 0x2dba9104, Offset: 0x3771
// Size: 0x14e
function function_20ed70136032e3ca()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        gameplay_sound_fx::function_28103d3430792dce( self.origin, #"hash_ad029670ad0d4294" );
        player gameplay_sound_fx::playlocalsoundfx( #"hash_9637f0b6f9286241" );
        
        if ( isdefined( level._effect[ #"hash_5fe798776164d9a1" ] ) )
        {
            playfx( level._effect[ #"hash_5fe798776164d9a1" ], self.origin );
        }
        
        points = rank::getscoreinfovalue( #"hash_63303757998cb656" );
        xp = rank::getscoreinfoxp( #"hash_63303757998cb656" );
        player thread points::doscoreevent( #"hash_63303757998cb656", undefined, points * self.var_20285537983744e6, xp );
        player thread hud_message::showsplash( #"hash_36bc24a702b41c11", points * self.var_20285537983744e6 );
        remaining = isdefined( level.pbank_zones ) ? level.pbank_zones.size : 0;
        
        if ( remaining <= 1 )
        {
            setomnvar( "ui_multi_tdm_death_count", 0 );
        }
        
        break;
    }
    
    function_8e8840a31970a1d( self, self.pbank_zone );
}

// Namespace multi_mode
// Params 2
// Checksum 0xb033857b, Offset: 0x38c7
// Size: 0x19d
function function_8e8840a31970a1d( useobject, zone )
{
    if ( isdefined( useobject ) )
    {
        useobject makeunusable();
        useobject delete();
    }
    
    if ( !isdefined( zone ) )
    {
        zone = level.pbank_zone;
    }
    
    if ( isdefined( zone ) )
    {
        zone function_71465a8b45e7ab25();
        zone.useobject = undefined;
        
        if ( isdefined( level.pbank_zones ) )
        {
            var_4ce2cb4456f564b = [];
            
            foreach ( activezone in level.pbank_zones )
            {
                if ( activezone.objectivekey != zone.objectivekey )
                {
                    var_4ce2cb4456f564b[ var_4ce2cb4456f564b.size ] = activezone;
                }
            }
            
            level.pbank_zones = var_4ce2cb4456f564b;
            
            if ( level.pbank_zones.size == 0 )
            {
                level.pbank_zones = undefined;
            }
        }
        
        if ( isdefined( level.pbank_zone ) && level.pbank_zone.objectivekey == zone.objectivekey )
        {
            level.pbank_zone = isdefined( level.pbank_zones ) && level.pbank_zones.size > 0 ? level.pbank_zones[ 0 ] : undefined;
        }
    }
    
    if ( !isdefined( level.pbank_zones ) )
    {
        level.var_5bc938b43fd2f322 = undefined;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xe46f60bb, Offset: 0x3a6c
// Size: 0xf8
function function_7f941b35fc96e679()
{
    if ( isdefined( level.pbank_zones ) )
    {
        remaining = arraycopy( level.pbank_zones );
        
        foreach ( zone in remaining )
        {
            function_8e8840a31970a1d( zone.useobject, zone );
        }
    }
    
    level.pbank_zones = undefined;
    level.pbank_zone = undefined;
    level.tdm_deathcount = undefined;
    function_75cf7b2c9502e831( 0 );
    
    if ( level.var_d74199afbc210abb )
    {
        if ( level.var_709caf807ba884ea[ #"hardpoint" ] == 1 )
        {
            level.koth_objectives = undefined;
        }
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x97b11bcc, Offset: 0x3b6c
// Size: 0x1f, Type: bool
function is_piggy_bank_active()
{
    return level.var_f0ff8e3c752b9d2a.ref == #"piggy_bank";
}

// Namespace multi_mode
// Params 1
// Checksum 0xf6520aaf, Offset: 0x3b94
// Size: 0xb2, Type: bool
function function_cf0c70b816beab11( zone )
{
    if ( !isdefined( zone ) || !isdefined( level.pbank_zones ) )
    {
        return false;
    }
    
    foreach ( activezone in level.pbank_zones )
    {
        if ( activezone.objectivekey == zone.objectivekey )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace multi_mode
// Params 1
// Checksum 0x97710d8b, Offset: 0x3c4f
// Size: 0x5e
function kc_initdata( index )
{
    level.var_819309cd0b3afc0b = getmatchrulesdata( "confData", "pointsPerConfirm" ) ?? 1;
    level.var_b3157c1d3dcf19a3 = getmatchrulesdata( "confData", "pointsPerDeny" ) ?? 0;
    level.var_da3f8bf45d0338cc = getmatchrulesdata( "confData", "killstreakConfirmed" ) ?? 0;
}

// Namespace multi_mode
// Params 1
// Checksum 0xea21e7b9, Offset: 0x3cb5
// Size: 0x3a
function function_89ce5385906e3200( var_b84e5730f2d9c89c )
{
    level.dogtagsenabled = 1;
    level.dogtagallyonusecb = &function_96acaab667f486be;
    level.dogtagenemyonusecb = &function_345e63bd077bfdc2;
    thread function_a9d7f8cae2cfd5cf();
}

// Namespace multi_mode
// Params 0
// Checksum 0xd3e65570, Offset: 0x3cf7
// Size: 0x52
function function_a9d7f8cae2cfd5cf()
{
    if ( !flags::gameflag( "intro_boost_vo_done" ) )
    {
        flags::gameflagwait( "intro_boost_vo_done" );
    }
    
    dialog::leaderdialogonplayers( #"gametype_kc", level.players );
    wait 4;
    dialog::leaderdialogonplayers( #"gametype_kc_boost", level.players );
}

// Namespace multi_mode
// Params 1
// Checksum 0xed21a1ec, Offset: 0x3d51
// Size: 0x1c
function kc_onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill_collect_tags" );
}

// Namespace multi_mode
// Params 1
// Checksum 0x96231a90, Offset: 0x3d75
// Size: 0x86
function function_96acaab667f486be( player )
{
    if ( isplayer( player ) )
    {
        player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.var_b3157c1d3dcf19a3, 0 );
        player thread function_ea1678d330c2b61d();
        
        if ( isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_61e0fbf08357154b" ] ) )
        {
            self [[ level.sharedfuncs[ #"multimode" ][ #"hash_61e0fbf08357154b" ] ]]( player );
        }
    }
}

// Namespace multi_mode
// Params 0, eflags: 0xc
// Checksum 0xd87c8af9, Offset: 0x3e03
// Size: 0x7d
function private function_ea1678d330c2b61d()
{
    self notify( #"hash_ad09022fcc02006" );
    self endon( #"hash_ad09022fcc02006" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_f2b7bccee0e5fd0e ) )
    {
        self.var_f2b7bccee0e5fd0e = 0;
    }
    
    self.var_f2b7bccee0e5fd0e += 1;
    wait 2;
    
    if ( self.var_f2b7bccee0e5fd0e >= 5 )
    {
        thread points::doscoreevent( #"mode_kc_mass_deny" );
    }
    
    self.var_f2b7bccee0e5fd0e = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0x28704c9f, Offset: 0x3e88
// Size: 0x130
function function_345e63bd077bfdc2( player )
{
    if ( isplayer( player ) )
    {
        player gameplay_sound_fx::playlocalsoundfx( #"kill_confirmed" );
        player gameplay_sound_fx::function_28103d3430792dce( self.origin, #"hash_81785d97884f1a1b" );
        player dialog::leaderdialogonplayer( #"kill_confirmed", undefined, undefined, undefined, 4 );
        player stats::setextrascore3( player.pers[ "confirmed" ], "confirmed" );
        
        if ( level.var_da3f8bf45d0338cc )
        {
            if ( !isdefined( player.perks[ "specialty_killstreak_to_scorestreak" ] ) )
            {
                player killstreaks::givestreakpoints( #"capture", 1, 0 );
            }
            else
            {
                player killstreaks::givestreakpoints( #"capture", 1, 150 );
            }
        }
        
        if ( isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_b5e2501f9409e185" ] ) )
        {
            self [[ level.sharedfuncs[ #"multimode" ][ #"hash_b5e2501f9409e185" ] ]]( player );
        }
    }
    
    player gamescore::giveteamscoreforobjective( player.pers[ "team" ], level.var_819309cd0b3afc0b, 0 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x6873a3a2, Offset: 0x3fc0
// Size: 0xc4
function function_343dacf8c6631ba1()
{
    level.dogtagsenabled = 0;
    level.dogtagallyonusecb = undefined;
    level.dogtagenemyonusecb = undefined;
    
    foreach ( tag in level.dogtags )
    {
        thread obj_dogtag::removetag( tag, 0 );
    }
    
    if ( level.var_d74199afbc210abb )
    {
        level.var_819309cd0b3afc0b = undefined;
        level.var_b3157c1d3dcf19a3 = undefined;
        level.var_da3f8bf45d0338cc = undefined;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x7fff18e1, Offset: 0x408c
// Size: 0x144
function function_f464472089673fca( var_b84e5730f2d9c89c )
{
    level.var_f3d13b4345302e52 = 1;
    level.var_f8fa53377f8ff7d4 = level.var_93532ab90ccea78c.var_f8fa53377f8ff7d4 ?? 1;
    level.var_a8d1c7a1f8d31114 = level.var_93532ab90ccea78c.var_a8d1c7a1f8d31114 ?? 0;
    level.var_63cff0250881ce7b = 0;
    thread function_326223ecc970d061();
    
    if ( level.var_93532ab90ccea78c.rgun_weapon )
    {
        namespace_ac01858d8c215283::function_1ad10376332e09dc( level.var_93532ab90ccea78c.rgun_weapon );
    }
    
    if ( level.var_93532ab90ccea78c.var_f05b31e6cc9a3759 )
    {
        namespace_ac01858d8c215283::function_6580bb94b88148c9( level.var_93532ab90ccea78c.var_f05b31e6cc9a3759 );
    }
    
    if ( level.var_93532ab90ccea78c.var_4d4df149c3b353d5 )
    {
        namespace_ac01858d8c215283::function_5836a9aa45a9688f( level.var_93532ab90ccea78c.var_4d4df149c3b353d5 );
    }
    
    level.var_bbca0b13e126c41c = namespace_ac01858d8c215283::function_c6f6696c68eab82();
    function_86da63a6dcc35f7b( level.var_bbca0b13e126c41c );
    level callback::add( #"roulette_gun_pickup", &rgun_onpickup );
    level callback::add( #"roulette_gun_drop", &rgun_ondrop );
}

// Namespace multi_mode
// Params 1
// Checksum 0xbaaf3f94, Offset: 0x41d8
// Size: 0x92
function function_86da63a6dcc35f7b( weaponent )
{
    if ( !isdefined( weaponent ) || !isdefined( level.var_93532ab90ccea78c.rgun_spawnvfx ) )
    {
        return;
    }
    
    function_aa5cfecf55c3a7e6();
    vfxent = spawn( "script_model", weaponent.origin );
    vfxent setmodel( "tag_origin" );
    vfxent linkto( weaponent );
    playfxontag( level._effect[ #"rgun_vfx" ], vfxent, "tag_origin" );
    level.var_2112831e4872510f = vfxent;
}

// Namespace multi_mode
// Params 0
// Checksum 0xd40ac920, Offset: 0x4272
// Size: 0x27
function function_aa5cfecf55c3a7e6()
{
    if ( isdefined( level.var_2112831e4872510f ) )
    {
        level.var_2112831e4872510f delete();
        level.var_2112831e4872510f = undefined;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x2b00e29b, Offset: 0x42a1
// Size: 0x52
function function_326223ecc970d061()
{
    if ( !flags::gameflag( "intro_boost_vo_done" ) )
    {
        flags::gameflagwait( "intro_boost_vo_done" );
    }
    
    dialog::leaderdialogonplayers( #"gametype_rgun", level.players );
    wait 4;
    dialog::leaderdialogonplayers( #"gametype_rgun_boost", level.players );
}

// Namespace multi_mode
// Params 1
// Checksum 0xad740c53, Offset: 0x42fb
// Size: 0x1e
function rgun_onplayerdisconnect( params )
{
    if ( function_76582dced844bcbf() )
    {
        function_ccb3a708e5fdfe80( 1 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x8b999386, Offset: 0x4321
// Size: 0x1c
function rgun_onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
}

// Namespace multi_mode
// Params 1
// Checksum 0xf44e64a9, Offset: 0x4345
// Size: 0x123
function rgun_onplayerkilled( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    pointsPerKill = getmatchrulesdata( "commonOption", "pointsPerKill" ) ?? 1;
    
    if ( victim namespace_ac01858d8c215283::function_e77f7f5d21804ff1() )
    {
        victim function_ccb3a708e5fdfe80();
        level.var_bbca0b13e126c41c = namespace_ac01858d8c215283::function_674f912326619f8d( getclosestpointonnavmesh( victim.origin ) ?? victim.origin );
        function_86da63a6dcc35f7b( level.var_bbca0b13e126c41c );
    }
    else if ( attacker namespace_ac01858d8c215283::function_6167f4c89e47a751( deathdata.objweapon ) )
    {
        pointsPerKill *= 2;
    }
    
    if ( victim damage::issuicide( deathdata.inflictor, attacker, deathdata.meansofdeath, deathdata.objweapon ) || victim damage::isteamkill( deathdata.inflictor, attacker ) )
    {
        return;
    }
    
    level gamescore::giveteamscoreforobjective( attacker.team, pointsPerKill, 0 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x32b153f5, Offset: 0x4470
// Size: 0x117
function function_8713bcae7a2ce069()
{
    function_aa5cfecf55c3a7e6();
    
    if ( isdefined( level.var_bbca0b13e126c41c ) )
    {
        level.var_bbca0b13e126c41c namespace_ac01858d8c215283::function_9784ea68bd261ea5();
        level.var_bbca0b13e126c41c notify( #"roulette_gun_finished" );
        namespace_ac01858d8c215283::function_29afc30fe43353f1( level.var_bbca0b13e126c41c, level.var_bbca0b13e126c41c.useobject );
        level.var_bbca0b13e126c41c = undefined;
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player namespace_ac01858d8c215283::function_e77f7f5d21804ff1() )
            {
                player namespace_ac01858d8c215283::function_2a6e8233e2103ee3();
                player namespace_ac01858d8c215283::function_9784ea68bd261ea5();
                break;
            }
        }
    }
    
    if ( isdefined( level.var_db31475930153fc2 ) )
    {
        level.var_db31475930153fc2 function_ccb3a708e5fdfe80();
    }
}

// Namespace multi_mode
// Params 2
// Checksum 0xd95341c3, Offset: 0x458f
// Size: 0x85
function function_5b6010b72d65159e( origin, force = 0 )
{
    if ( level.var_f0ff8e3c752b9d2a.ref != #"hash_cd755ac179aea3b0" )
    {
        return;
    }
    
    if ( force )
    {
        function_8713bcae7a2ce069();
    }
    else if ( isdefined( level.var_bbca0b13e126c41c ) )
    {
        return;
    }
    
    level.var_bbca0b13e126c41c = namespace_ac01858d8c215283::function_674f912326619f8d( getclosestpointonnavmesh( origin ) ?? origin );
    function_86da63a6dcc35f7b( level.var_bbca0b13e126c41c );
}

// Namespace multi_mode
// Params 0
// Checksum 0xc91cffbe, Offset: 0x461c
// Size: 0x8b
function rgun_setoutline()
{
    outline::_hudoutlineviewmodelenable( level.var_93532ab90ccea78c.var_e41f1161f6e36766, 0 );
    self.friendlyoutlineid = outline::outlineenableforteam( self, self.team, level.var_93532ab90ccea78c.var_e41f1161f6e36766, "level_script", undefined, 1 );
    self.var_e82835bccfbadc6d = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), level.var_93532ab90ccea78c.var_8c6920db4b7b38f3, "level_script", undefined, 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0xa07bd1ce, Offset: 0x46af
// Size: 0x55
function function_1fa3a90f57a7ba9()
{
    thread hud_message::showsplash( level.var_93532ab90ccea78c.var_289f4512efa27d66 );
    self.var_b5cad645b41b118e = 1;
    level.var_db31475930153fc2 = self;
    self setclientomnvar( "ui_multi_roulette_marked", 1 );
    rgun_setoutline();
    gameplay_sound_fx::playlocalsoundfx( #"roulette_marked" );
}

// Namespace multi_mode
// Params 1
// Checksum 0x1cbdf955, Offset: 0x470c
// Size: 0x3b
function function_1d299fb0b5adc4ce( fromdisconnect )
{
    outline::outlinedisable( self.friendlyoutlineid, self );
    outline::outlinedisable( self.var_e82835bccfbadc6d, self );
    
    if ( !fromdisconnect )
    {
        outline::_hudoutlineviewmodeldisable();
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xb7a32a13, Offset: 0x474f
// Size: 0x35
function function_ccb3a708e5fdfe80( fromdisconnect )
{
    self.var_b5cad645b41b118e = 0;
    level.var_db31475930153fc2 = undefined;
    self setclientomnvar( "ui_multi_roulette_marked", 0 );
    function_1d299fb0b5adc4ce( fromdisconnect );
}

// Namespace multi_mode
// Params 1
// Checksum 0x7f181ad5, Offset: 0x478c
// Size: 0x33
function rgun_onpickup( pickupdata )
{
    player = pickupdata.player;
    player function_1fa3a90f57a7ba9();
    function_aa5cfecf55c3a7e6();
}

// Namespace multi_mode
// Params 1
// Checksum 0xcd0cff76, Offset: 0x47c7
// Size: 0x23
function rgun_ondrop( params )
{
    function_ccb3a708e5fdfe80();
    function_86da63a6dcc35f7b( level.var_bbca0b13e126c41c );
}

// Namespace multi_mode
// Params 0
// Checksum 0xf9069995, Offset: 0x47f2
// Size: 0xc, Type: bool
function function_76582dced844bcbf()
{
    return istrue( self.var_b5cad645b41b118e );
}

// Namespace multi_mode
// Params 0
// Checksum 0xbd51d6d5, Offset: 0x4807
// Size: 0x87
function function_ffa8c47e0f42817f()
{
    function_8713bcae7a2ce069();
    level.var_ed31c99a6e54a5fe = undefined;
    level.var_fdea99ebcf94c020 = undefined;
    
    if ( level.var_d74199afbc210abb )
    {
        level.var_654ffd608d133350 = undefined;
        level.var_f3d13b4345302e52 = undefined;
        level.var_63cff0250881ce7b = undefined;
        level.var_a8d1c7a1f8d31114 = undefined;
        level.var_a20f61201152cf5b = undefined;
    }
    
    level callback::remove( #"roulette_gun_pickup", &rgun_onpickup );
    level callback::remove( #"roulette_gun_drop", &rgun_ondrop );
}

// Namespace multi_mode
// Params 1
// Checksum 0xc5e398, Offset: 0x4896
// Size: 0x177
function koth_initdata( index )
{
    level.var_fa4a3c9179d3c225 = getmatchrulesdata( "kothData", "randomLocationOrder" ) ?? 0;
    level.var_858e6b4f99179287 = getmatchrulesdata( "kothData", "zoneLifetime" ) ?? 60;
    level.var_57af36e1fec51666 = getmatchrulesdata( "kothData", "nextZoneRevealTime" ) ?? 12;
    level.var_cf8f122775d88614 = getmatchrulesdata( "kothData", "additiveScoring" ) ?? 0;
    level.zonemajoritycapture = getmatchrulesdata( "kothData", "zoneMajorityCapture" ) ?? 0;
    level.zonecapturetime = 0;
    
    if ( game[ "mini_gametypes" ][ index ].timelimit % level.var_858e6b4f99179287 != 0 )
    {
        level.var_858e6b4f99179287 = game[ "mini_gametypes" ][ index ].timelimit / 2;
        assertmsg( "<dev string:x21d>" );
    }
    
    assert( level.var_858e6b4f99179287 >= level.var_57af36e1fec51666, "<dev string:x268>" );
    
    if ( level.var_858e6b4f99179287 < level.var_57af36e1fec51666 )
    {
        level.var_57af36e1fec51666 = level.var_858e6b4f99179287;
    }
    
    var_2b99268637844592 = game[ "mini_gametypes" ][ index ].timelimit / level.var_858e6b4f99179287;
    function_f049a46d3f254682();
    function_6f4cfc393db251a9( var_2b99268637844592 );
}

// Namespace multi_mode
// Params 1
// Checksum 0xdddd5492, Offset: 0x4a15
// Size: 0x58
function function_29bd828380390948( var_b84e5730f2d9c89c )
{
    thread function_8d22f825b4ef2f17();
    function_3675370ac82a780a();
    level.var_1e1962e4a4e8622 = &koth_onzonecapture;
    level.var_77b784031c35fecb = [];
    level.pausemodetimer = 0;
    level.objectives = level.koth_objectives;
    level thread function_73802e5d05d7045d( var_b84e5730f2d9c89c );
}

// Namespace multi_mode
// Params 0
// Checksum 0x6cc7bab7, Offset: 0x4a75
// Size: 0x52
function function_8d22f825b4ef2f17()
{
    if ( !flags::gameflag( "intro_boost_vo_done" ) )
    {
        flags::gameflagwait( "intro_boost_vo_done" );
    }
    
    dialog::leaderdialogonplayers( #"gametype_koth", level.players );
    wait 4;
    dialog::leaderdialogonplayers( #"gametype_koth_boost", level.players );
}

// Namespace multi_mode
// Params 0
// Checksum 0x25bfe172, Offset: 0x4acf
// Size: 0x80
function function_3675370ac82a780a()
{
    level.icontarget = "koth_target";
    level.iconneutral = "koth_neutral";
    level.iconcapture = "koth_destroy";
    level.icondefend = "koth_defend";
    level.iconcontested = "koth_contested";
    level.icontaking = "koth_taking";
    level.iconlosing = "koth_losing";
    level.icondefending = "koth_defending";
    level.iconnext = "koth_next";
}

// Namespace multi_mode
// Params 1
// Checksum 0x591b02c8, Offset: 0x4b57
// Size: 0x20a
function function_6f4cfc393db251a9( numzones )
{
    for ( index = 0; index < numzones ; index++ )
    {
        iconimage = "icon_waypoint_koth";
        
        if ( isdefined( level.var_93532ab90ccea78c ) && isdefined( level.var_93532ab90ccea78c.var_981f3c4d386b565e[ index ].objectiveicon ) && level.var_93532ab90ccea78c.var_981f3c4d386b565e[ index ].objectiveicon != %"" )
        {
            iconimage = level.var_93532ab90ccea78c.var_981f3c4d386b565e[ index ].objectiveicon;
        }
        
        objectivekey = "_" + index;
        gamelogic_mp::setwaypointiconinfo( "koth_neutral" + objectivekey, 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_target" + objectivekey, 0, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
        gamelogic_mp::setwaypointiconinfo( "koth_next" + objectivekey, 0, "neutral", &"MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_locked", 0, 2 );
        gamelogic_mp::setwaypointiconinfo( "koth_taking" + objectivekey, 0, "friendly", &"mp_ingame_only/obj_destroying_caps", iconimage, 1, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_defend" + objectivekey, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_defending" + objectivekey, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_destroy" + objectivekey, 0, "enemy", &"mp_ingame_only/obj_reclaim", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_losing" + objectivekey, 0, "enemy", &"mp_ingame_only/obj_reclaim", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_contested" + objectivekey, 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", iconimage, 0, 1 );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x8fd8c52b, Offset: 0x4d69
// Size: 0x1c8, Type: bool
function function_f049a46d3f254682()
{
    primaryzones = getentarray( "hardpoint_zone", #targetname );
    
    foreach ( zone in primaryzones )
    {
        zone.objectivekey = zone.script_label;
    }
    
    primaryzones = arraysort( primaryzones, undefined, &koth_comparezoneindexes );
    assert( isdefined( primaryzones ) && primaryzones.size >= 2, "<dev string:x2b5>" );
    triggers = [];
    
    for ( index = 0; index < primaryzones.size ; index++ )
    {
        triggers[ triggers.size ] = primaryzones[ index ];
    }
    
    level.koth_objectives = [];
    
    foreach ( trigger in triggers )
    {
        zone = obj_zonecapture::setupobjective( trigger, undefined, undefined, 1 );
        level.koth_objectives[ zone.objectivekey ] = zone;
    }
    
    objid = objidpoolmanager::requestreservedid( 1 );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
    setomnvar( "ui_hardpoint_active_zone_count", 2 );
    return true;
}

// Namespace multi_mode
// Params 2
// Checksum 0x8771640b, Offset: 0x4f3a
// Size: 0xe3, Type: bool
function koth_comparezoneindexes( zone_a, zone_b )
{
    script_index_a = int( zone_a.objectivekey );
    script_index_b = int( zone_b.objectivekey );
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:x2e3>" + zone_a.origin + "<dev string:x310>" + zone_b.origin );
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:x2e3>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:x2e3>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace multi_mode
// Params 0
// Checksum 0x7874006c, Offset: 0x5026
// Size: 0x188
function koth_getnextzone()
{
    if ( level.var_fa4a3c9179d3c225 )
    {
        if ( isdefined( level.var_a1ef86bb72309efc ) )
        {
            index = level.var_a1ef86bb72309efc;
            level.var_a1ef86bb72309efc = undefined;
            return index;
        }
        
        bestzoneindex = function_aecec0bec7bfd465( 1 );
        zone = level.koth_objectives[ bestzoneindex ];
        level.koth_prevzoneindex = bestzoneindex;
    }
    else
    {
        if ( !isdefined( level.koth_prevzoneindex ) )
        {
            level.koth_prevzoneindex = 0;
        }
        
        level.koth_prevzoneindex++;
        
        if ( level.koth_prevzoneindex > level.koth_objectives.size )
        {
            level.koth_prevzoneindex = 1;
        }
        
        zone = level.koth_objectives[ string( level.koth_prevzoneindex ) ];
        
        if ( function_cf0c70b816beab11( zone ) )
        {
            level.koth_prevzoneindex++;
            
            if ( level.koth_prevzoneindex > level.koth_objectives.size )
            {
                level.koth_prevzoneindex = 1;
            }
            
            zone = level.koth_objectives[ string( level.koth_prevzoneindex ) ];
        }
        
        futurezone = level.koth_prevzoneindex + 1;
        
        if ( futurezone > level.koth_objectives.size )
        {
            futurezone = 1;
        }
        
        level.var_a1ef86bb72309efc = level.koth_objectives[ string( futurezone ) ];
    }
    
    zone.iconname = "_" + level.var_466d4dfff883f4a6;
    level.var_466d4dfff883f4a6++;
    return zone;
}

// Namespace multi_mode
// Params 1
// Checksum 0xb54076ec, Offset: 0x51b7
// Size: 0x4eb
function function_aecec0bec7bfd465( var_b0d6efa2393dc817 )
{
    var_8493e175a66447ea = [];
    
    foreach ( entry in level.teamnamelist )
    {
        var_8493e175a66447ea[ entry ] = ( 0, 0, 0 );
    }
    
    livingplayers = game_utility_mp::getpotentiallivingplayers();
    
    foreach ( player in livingplayers )
    {
        if ( player.team == "spectator" )
        {
            continue;
        }
        
        var_8493e175a66447ea[ player.team ] += player.origin;
    }
    
    avgpos = [];
    
    foreach ( entry in level.teamnamelist )
    {
        players = teams::getteamdata( entry, "players" );
        teamsize = max( players.size, 1 );
        avgpos[ entry ] = var_8493e175a66447ea[ entry ] / teamsize;
    }
    
    if ( var_b0d6efa2393dc817 )
    {
        var_4cdb5790807b7ff3 = isdefined( level.pbank_zones ) ? level.pbank_zones.size : 0;
        
        if ( !isdefined( level.var_d4aafa3519a3557e ) || isdefined( level.var_d4aafa3519a3557e ) && level.var_d4aafa3519a3557e.size + var_4cdb5790807b7ff3 == level.koth_objectives.size - 1 )
        {
            level.var_d4aafa3519a3557e = [];
        }
        
        if ( isdefined( level.koth_prevzoneindex ) )
        {
            level.var_d4aafa3519a3557e[ level.var_d4aafa3519a3557e.size ] = level.koth_prevzoneindex;
        }
    }
    
    playerweight = 0.7;
    zoneweight = 0.3;
    bestzoneindex = undefined;
    bestcost = undefined;
    
    foreach ( objective in level.koth_objectives )
    {
        if ( var_b0d6efa2393dc817 )
        {
            skip = 0;
            
            foreach ( zoneindex in level.var_d4aafa3519a3557e )
            {
                if ( objective.objectivekey == string( zoneindex ) )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
        }
        
        if ( function_cf0c70b816beab11( objective ) )
        {
            continue;
        }
        
        zone = objective;
        playercost = 0;
        
        foreach ( entry in level.teamnamelist )
        {
            playercost += distance2dsquared( zone.curorigin, avgpos[ entry ] );
        }
        
        if ( isdefined( level.zone ) )
        {
            zonecost = distance2dsquared( zone.curorigin, level.zone.curorigin );
            totalcost = playercost * playerweight + zonecost * zoneweight;
        }
        else
        {
            totalcost = playercost;
        }
        
        if ( !isdefined( bestcost ) || totalcost > bestcost )
        {
            bestcost = totalcost;
            bestzoneindex = objective.objectivekey;
        }
    }
    
    return bestzoneindex;
}

// Namespace multi_mode
// Params 0
// Checksum 0xbe32886b, Offset: 0x56ab
// Size: 0x178
function function_70a956156c57683f()
{
    level.var_7db1da1f52caadb1 = level.zone.lastclaimteam;
    function_e5332e272588b005( level.zone );
    level.var_4c024662ea47c4f4++;
    level.zone = koth_getnextzone();
    level.zone obj_zonecapture::activatezone();
    level.zone.active = 1;
    level.zone.var_df26fe84a623b1b1 = gettime();
    level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    level objidpoolmanager::update_objective_position( level.zone.objidnum, level.zone.visuals[ 0 ].origin + level.zone.offset3d );
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    gameplay_sound_fx::function_28103d3430792dce( level.zone gameobjects::getorigin(), #"hash_44446e4b71cd388b" );
}

// Namespace multi_mode
// Params 2
// Checksum 0x4e1a2b93, Offset: 0x582b
// Size: 0x377
function function_68b55d8d3f1215ff( firstzone, var_b84e5730f2d9c89c )
{
    if ( firstzone )
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"obj_generic_capture", entry );
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"hp_new_location", entry );
        }
    }
    
    /#
        if ( !isdefined( level.zone ) )
        {
            assertmsg( "<dev string:x312>" );
            level waittill( #"forever" );
        }
    #/
    
    if ( isdefined( level.zone.curorigin ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( level.zone.curorigin, #"hash_a51e7d7f6ac10c9a" );
    }
    
    level callback::callback( #"music_event", { #event_type:#"hq_new" } );
    level.zone thread obj_zonecapture::hardpoint_setneutral();
    level.zone gameobjects::allowuse( "none" );
    function_9fe592760983d262( level.zone );
    
    if ( level.scoreeventglobals.var_a63e82103d31ac67 )
    {
        foreach ( player in level.players )
        {
            player.var_1f0eae9ac93b88db = 0;
        }
    }
    
    if ( isdefined( level.var_a1ef86bb72309efc ) )
    {
        objid = 1;
        level.var_a1ef86bb72309efc gameobjects::setvisibleteam( "none", objid );
    }
    
    level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    obj_zonecapture::updateservericons( "neutral", 0 );
    
    if ( level.var_858e6b4f99179287 )
    {
        obj_zonecapture::updateservericons( "neutral", 0 );
        level.var_59011156b1a94cf9 = int( var_b84e5730f2d9c89c + 1000 * level.var_858e6b4f99179287 * ( level.var_4c024662ea47c4f4 + 1 ) );
        zoneduration = level.var_858e6b4f99179287;
        zoneendtime = gettime() + 1000 * level.var_858e6b4f99179287;
        
        if ( zoneendtime > level.var_59011156b1a94cf9 )
        {
            zoneduration = level.var_858e6b4f99179287 - ( zoneendtime - level.var_59011156b1a94cf9 ) * 0.001;
        }
        
        thread koth_movezoneaftertime( zoneduration );
        setomnvar( "ui_hardpoint_timer", level.var_59011156b1a94cf9 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x2eeb5df9, Offset: 0x5baa
// Size: 0x25e
function function_73802e5d05d7045d( var_b84e5730f2d9c89c )
{
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    setomnvar( "ui_hardpoint_timer", 0 );
    level.var_4c024662ea47c4f4 = 0;
    level.var_466d4dfff883f4a6 = 0;
    level.zone = koth_getnextzone();
    firstzone = 1;
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    gameplay_sound_fx::function_28103d3430792dce( level.zone.trigger.origin, #"hash_44446e4b71cd388b" );
    setomnvar( "ui_objective_timer_stopped", 0 );
    level.zone obj_zonecapture::activatezone();
    level.zone gameobjects::setvisibleteam( "any" );
    level.zone gameobjects::setobjectivestatusicons( level.icontarget );
    level.zone.active = 0;
    firstzone = 1;
    
    while ( true )
    {
        level thread function_fcd725be920b9981();
        level.zone gameobjects::enableobject();
        level.zone.capturecount = 0;
        spawnlogic::clearlastteamspawns();
        function_68b55d8d3f1215ff( firstzone, var_b84e5730f2d9c89c );
        firstzone = 0;
        setomnvar( "ui_hq_status", 10 );
        spawnlogic::clearlastteamspawns();
        function_d93ae14031615db();
        ownerteam = level.zone gameobjects::getownerteam();
        level.lastcaptureteam = undefined;
        level.zone.active = 0;
        level.zone gameobjects::disableobject();
        level.zone gameobjects::allowuse( "none" );
        level.zone gameobjects::setownerteam( "neutral" );
        obj_zonecapture::updateservericons( "zone_shift", 0 );
        level notify( #"zone_reset" );
        setomnvar( "ui_hq_status", -1 );
        function_70a956156c57683f();
        wait 1;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x17690585, Offset: 0x5e10
// Size: 0x1ae
function function_d93ae14031615db()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level endon( #"hash_56dbbc54f182022" );
    level.var_919e1649610e40a2 = gettime();
    
    while ( true )
    {
        level.zone gameobjects::allowuse( "enemy" );
        level.zone gameobjects::setvisibleteam( "any" );
        level.zone gameobjects::setusetext( &"mp/securing_position" );
        level.zone thread obj_zonecapture::hardpoint_setneutral();
        level.zone gameobjects::cancontestclaim( 1 );
        msg = level utility::waittill_any_return( "zone_captured", "zone_destroyed" );
        
        if ( msg == "zone_destroyed" )
        {
            continue;
        }
        
        ownerteam = level.zone gameobjects::getownerteam();
        level childthread function_a03067b57d8cba9( ownerteam );
        otherteam = team_utility::getotherteam( ownerteam );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_8934f6f529f89464", teams::getteamdata( ownerteam, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_6e7daae1df44022c", teams::getteamdata( otherteam, "players" ) );
        level waittill( #"zone_destroyed", destroy_team );
        
        if ( isdefined( destroy_team ) )
        {
            level.zone gameobjects::setownerteam( destroy_team );
            continue;
        }
        
        level.zone gameobjects::setownerteam( "none" );
        gameplay_sound_fx::function_28103d3430792dce( level.zone.trigger.origin, #"koth_neutral_ping" );
    }
}

// Namespace multi_mode
// Params 4
// Checksum 0xb9b098ed, Offset: 0x5fc6
// Size: 0x82
function koth_onzonecapture( zone, credit_player, touchlist, capturetime )
{
    level thread function_8a56bfdbcaff6b5d( zone, credit_player, touchlist, capturetime );
    capture_team = credit_player.team;
    
    if ( !isdefined( level.lastcaptureteam ) || level.lastcaptureteam != capture_team )
    {
        level thread function_af285e6f5ca366e7( touchlist, capturetime, capture_team, level.lastcaptureteam, credit_player, zone );
    }
}

// Namespace multi_mode
// Params 4
// Checksum 0xbfe534cc, Offset: 0x6050
// Size: 0x47c
function function_8a56bfdbcaff6b5d( zone, credit_player, touchlist, capturetime )
{
    self notify( #"hash_13fca666823ea056" );
    self endon( #"hash_13fca666823ea056" );
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    level endon( #"zone_reset" );
    level endon( #"zone_moved" );
    level endon( #"zone_unoccupied" );
    level endon( #"zone_contested" );
    seconds = 1;
    score = 1;
    
    while ( !level.gameended )
    {
        for ( waittime = 0; waittime < seconds && !level.gameended ; waittime = 0 )
        {
            wait level.framedurationseconds;
            hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
            
            if ( level.zone.stalemate )
            {
            }
        }
        
        team = zone gameobjects::getownerteam();
        
        if ( team == "neutral" || team == "none" )
        {
            continue;
        }
        
        if ( level.gameended )
        {
            break;
        }
        
        if ( !zone.stalemate && !level.gameended )
        {
            if ( level.var_cf8f122775d88614 )
            {
                score = zone.touchlist[ team ].size;
            }
            
            gamescore::giveteamscoreforobjective( team, score, 0 );
            players = zone gameobjects::function_2c38b77b2ae4bfc5( team );
            
            foreach ( player in players )
            {
                currplayer = player;
                var_a1e1f51d44e98f43 = player;
                currplayer = gameobjects::function_96e1d4c0c873649( currplayer );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( currplayer ) ) )
                {
                    if ( isdefined( currplayer.leaderboarddata[ "objTime" ] ) )
                    {
                        currplayer.leaderboarddata[ "objTime" ] = currplayer.leaderboarddata[ "objTime" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                    {
                        [[ level.leaderboardfunc[ "objTime" ] ]]( currplayer, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x378>" );
                    
                    if ( isdefined( currplayer.pers[ "objTime" ] ) )
                    {
                        currplayer.pers[ "objTime" ] = currplayer.pers[ "objTime" ] + 1;
                    }
                }
                
                currplayer persistence::statsetchild( "round", "objTime", currplayer.pers[ "objTime" ] );
                currplayer stats::setextrascore0( currplayer.pers[ "objTime" ] );
                scoreeventinterval = level.scoreeventglobals.var_f244d41a6bc4a67d ?? 4;
                
                if ( currplayer.var_1f0eae9ac93b88db >= scoreeventinterval )
                {
                    currplayer.var_1f0eae9ac93b88db = 0;
                    
                    if ( var_a1e1f51d44e98f43 != currplayer )
                    {
                        currplayer thread points::doscoreevent( #"koth_in_obj_capture_bot" );
                    }
                    else
                    {
                        currplayer thread points::doscoreevent( #"koth_in_obj" );
                    }
                    
                    if ( isplayer( currplayer ) && isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_e8742aff4abdfd2e" ] ) )
                    {
                        currplayer [[ level.sharedfuncs[ #"multimode" ][ #"hash_e8742aff4abdfd2e" ] ]]();
                    }
                    
                    continue;
                }
                
                if ( !isdefined( currplayer.var_1f0eae9ac93b88db ) )
                {
                    currplayer.var_1f0eae9ac93b88db = 0;
                }
                
                currplayer.var_1f0eae9ac93b88db++;
                
                if ( !level.scoreeventglobals.var_c21da95c189c7f73 )
                {
                    if ( var_a1e1f51d44e98f43 != currplayer )
                    {
                        currplayer gamescore::giveplayerscore( #"koth_in_obj_capture_bot", 3 );
                        continue;
                    }
                    
                    currplayer gamescore::giveplayerscore( #"koth_in_obj", 10 );
                }
            }
        }
    }
}

// Namespace multi_mode
// Params 6
// Checksum 0x265081d9, Offset: 0x64d4
// Size: 0x632
function function_af285e6f5ca366e7( touchlist, capturetime, capture_team, lastcaptureteam, credit_player, gameobject )
{
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    captime = gettime();
    level.lastcaptime = captime;
    
    if ( isdefined( lastcaptureteam ) && lastcaptureteam != capture_team )
    {
        if ( level.scoreeventglobals.var_4a79312b90f5d2d4 )
        {
            foreach ( player in teams::getteamdata( lastcaptureteam, "players" ) )
            {
                player.var_1f0eae9ac93b88db = 0;
            }
        }
    }
    
    first_player = credit_player;
    var_cca651fd3375b9c2 = credit_player;
    timesincelastcap = isdefined( first_player.lastcaptime ) ? captime - first_player.lastcaptime : 10000;
    first_player.lastcaptime = captime;
    first_player = gameobjects::function_96e1d4c0c873649( first_player );
    
    if ( isplayer( first_player ) )
    {
        first_player stats::setextrascore2( first_player.pers[ "extrascore2" ] + 1 );
        telemetry_data = {};
        telemetry_data.player = first_player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = first_player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        
        if ( level.var_65de76cd5bea6b26 != level.zone.objectivekey )
        {
            first_player thread points::doscoreevent( #"koth_first_cap" );
            level.var_65de76cd5bea6b26 = level.zone.objectivekey;
        }
        
        first_player notify( #"player_zone_captured", level.zone.objectivekey );
        
        if ( function_18ba8059aaeea8b3( first_player ) && !game_utility_mp::isanymlgmatch() )
        {
        }
        else if ( timesincelastcap < 2100 && captime - first_player.lastkilltime > 2100 )
        {
            if ( var_cca651fd3375b9c2 != first_player )
            {
                first_player thread points::doscoreevent( #"hp_secure_capture_bot_reduced" );
            }
            else
            {
                first_player thread points::doscoreevent( #"mode_hp_secure_tiny" );
            }
        }
        else if ( !koth_isscoreboosting( first_player ) )
        {
            if ( var_cca651fd3375b9c2 != first_player )
            {
                first_player thread points::doscoreevent( #"hp_secure_capture_bot" );
            }
            else
            {
                first_player thread points::doscoreevent( #"mode_hp_secure" );
                first_player thread smoke_grenade::function_99543ad5d551cdb5();
            }
        }
        else if ( var_cca651fd3375b9c2 != first_player )
        {
            first_player thread points::doscoreevent( #"hp_secure_capture_bot_reduced" );
        }
        else
        {
            first_player thread points::doscoreevent( #"mode_hp_secure_reduced" );
        }
        
        if ( isdefined( level.zone.var_df26fe84a623b1b1 ) && captime - level.zone.var_df26fe84a623b1b1 <= 2100 )
        {
            if ( var_cca651fd3375b9c2 != first_player )
            {
                first_player thread points::doscoreevent( #"hp_quick_cap_capture_bot" );
            }
            else
            {
                if ( level.var_7db1da1f52caadb1 === first_player.team )
                {
                    first_player thread points::doscoreevent( #"koth_quick_cap" );
                    first_player challenges::function_24c3c132db024c21();
                }
                
                first_player thread points::doscoreevent( #"mode_hp_quick_cap" );
            }
        }
    }
    
    playerids = getarraykeys( touchlist );
    
    for ( i = 0; i < playerids.size ; i++ )
    {
        player = touchlist[ playerids[ i ] ].player;
        var_a1e1f51d44e98f43 = player;
        player = gameobjects::function_96e1d4c0c873649( player );
        player koth_updatecapsperminute( lastcaptureteam );
        
        if ( !koth_isscoreboosting( player ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "captures" ] ) )
                {
                    player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
                {
                    [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x378>" );
                
                if ( isdefined( player.pers[ "captures" ] ) )
                {
                    player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        }
        else
        {
            /#
                player iprintlnbold( "<dev string:x39e>" );
            #/
        }
        
        if ( first_player != player )
        {
            if ( var_a1e1f51d44e98f43 != player )
            {
                player thread points::doscoreevent( #"capture_assist_capture_bot" );
            }
            else
            {
                player thread points::doscoreevent( #"mode_dom_secure_assist" );
            }
        }
        
        wait 0.05;
    }
    
    if ( isdefined( gameobject.assisttouchlist ) )
    {
        if ( gameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            foreach ( id in playerids )
            {
                gameobject.assisttouchlist[ capture_team ][ id ] = undefined;
            }
        }
        
        if ( gameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            gameobject thread function_868082ca2ffe58d( capture_team );
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x4081e11, Offset: 0x6b0e
// Size: 0x22f
function function_868082ca2ffe58d( team )
{
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    var_e1fea56171575e06 = getarraykeys( self.assisttouchlist[ team ] );
    
    if ( var_e1fea56171575e06.size > 0 )
    {
        for ( index = 0; index < var_e1fea56171575e06.size ; index++ )
        {
            player = self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ].player;
            var_a1e1f51d44e98f43 = player;
            
            if ( !isplayer( player ) )
            {
                if ( isdefined( player.owner ) )
                {
                    if ( gameobjects::function_e17a356e69f57699( player ) && isplayer( player.owner ) )
                    {
                        var_a1e1f51d44e98f43 = player;
                        player = player.owner;
                    }
                    else
                    {
                        continue;
                    }
                }
                else
                {
                    continue;
                }
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "captures" ] ) )
                {
                    player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
                {
                    [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x378>" );
                
                if ( isdefined( player.pers[ "captures" ] ) )
                {
                    player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
            
            if ( var_a1e1f51d44e98f43 != player )
            {
                player thread points::doscoreevent( #"capture_assist_capture_bot" );
            }
            else
            {
                player thread points::doscoreevent( #"mode_dom_secure_assist" );
            }
            
            self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ] = undefined;
            wait 0.05;
        }
    }
}

// Namespace multi_mode
// Params 1, eflags: 0xc
// Checksum 0xfd081ca5, Offset: 0x6d45
// Size: 0xac
function private function_a03067b57d8cba9( ownerteam )
{
    self notify( #"hash_b43772c6d3529e33" );
    self endon( #"hash_b43772c6d3529e33" );
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    graceperiod = gettime() - level.var_919e1649610e40a2;
    
    if ( graceperiod > 2100 )
    {
        return;
    }
    
    if ( !isdefined( level.zone.touchlist ) )
    {
        return;
    }
    
    if ( graceperiod > 0 )
    {
        wait graceperiod * 0.001;
    }
    
    level.var_77b784031c35fecb = arraycopy( level.zone.touchlist[ ownerteam ] );
}

// Namespace multi_mode
// Params 1
// Checksum 0x6b017da1, Offset: 0x6df9
// Size: 0x1a, Type: bool
function koth_isscoreboosting( player )
{
    return player.capsperminute > 3;
}

// Namespace multi_mode
// Params 1
// Checksum 0x501159fd, Offset: 0x6e1c
// Size: 0x1a, Type: bool
function function_18ba8059aaeea8b3( player )
{
    return player.capsperminute > 5;
}

// Namespace multi_mode
// Params 1
// Checksum 0xcd8bd869, Offset: 0x6e3f
// Size: 0xcf
function koth_updatecapsperminute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( !isdefined( lastownerteam ) || lastownerteam == "neutral" )
    {
        return;
    }
    
    self.numcaps++;
    minutespassed = game_utility::gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x8e549e7a, Offset: 0x6f16
// Size: 0x119
function function_fcd725be920b9981()
{
    areaid = undefined;
    zonetrigger = level.zone.visuals[ 0 ];
    
    if ( !isdefined( zonetrigger ) )
    {
        return;
    }
    
    if ( isdefined( zonetrigger.script_noteworthy ) )
    {
        areaid = level.calloutglobals.areaidmap[ zonetrigger.script_noteworthy ];
    }
    
    if ( !isdefined( areaid ) )
    {
        areaid = callouts::function_69298682a76ef6c5( zonetrigger );
    }
    
    if ( isdefined( areaid ) )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_hp_callout_id", areaid );
        }
    }
    
    assert( isdefined( areaid ), "<dev string:x3e3>" + zonetrigger.script_label + "<dev string:x3ee>" );
}

// Namespace multi_mode
// Params 1
// Checksum 0x2b857d1e, Offset: 0x7037
// Size: 0x152
function koth_movezoneaftertime( time )
{
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level thread function_1eea206a8cbc9157();
    function_8235b7eeaf65b0a3( time );
    objid = 1;
    level objidpoolmanager::returnreservedobjectiveid( objid, 0 );
    
    if ( isdefined( level.var_a1ef86bb72309efc ) )
    {
        level objidpoolmanager::update_objective_state( objid, "done" );
        level objidpoolmanager::update_objective_position( objid, level.var_a1ef86bb72309efc.visuals[ 0 ].origin + level.var_a1ef86bb72309efc.offset3d );
    }
    
    foreach ( var_bdac79500cb4bb60 in level.var_77b784031c35fecb )
    {
        var_bdac79500cb4bb60.player thread points::doscoreevent( #"koth_60" );
    }
    
    level.var_77b784031c35fecb = [];
    level notify( #"zone_moved" );
    level notify( #"zone_destroyed" );
}

// Namespace multi_mode
// Params 1
// Checksum 0x886c10aa, Offset: 0x7191
// Size: 0x1db
function function_8235b7eeaf65b0a3( timer )
{
    level endon( #"game_ended" );
    minigameendingsoon = level.var_cda6c691a06ec205 - level.var_59011156b1a94cf9 == 0;
    
    if ( !minigameendingsoon && isdefined( level.var_57af36e1fec51666 ) )
    {
        timer = max( timer - level.var_57af36e1fec51666, 0 );
    }
    
    hostmigration::waitlongdurationwithhostmigrationpause( timer );
    
    if ( minigameendingsoon )
    {
        level.var_a1ef86bb72309efc = undefined;
        return;
    }
    
    if ( !isdefined( level.var_a1ef86bb72309efc ) )
    {
        level.var_a1ef86bb72309efc = koth_getnextzone();
    }
    
    objid = 1;
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::update_objective_state( objid, "current" );
    objidpoolmanager::update_objective_position( objid, level.var_a1ef86bb72309efc.visuals[ 0 ].origin + level.var_a1ef86bb72309efc.offset3d );
    level.var_a1ef86bb72309efc gameobjects::setvisibleteam( "any", objid );
    level.var_a1ef86bb72309efc gameobjects::setobjectivestatusicons( level.iconnext, level.iconnext, objid );
    
    foreach ( entry in level.teamnamelist )
    {
        level dialog::statusdialog( #"hp_move_soon", entry );
    }
    
    if ( isdefined( level.var_57af36e1fec51666 ) )
    {
        hostmigration::waitlongdurationwithhostmigrationpause( level.var_57af36e1fec51666 );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x82f2e073, Offset: 0x7374
// Size: 0x8f
function function_1eea206a8cbc9157()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level endon( #"hash_56dbbc54f182022" );
    level waittill( #"host_migration_begin" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    timepassed = hostmigration::waittillhostmigrationdone();
    setomnvar( "ui_objective_timer_stopped", 0 );
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_hardpoint_timer", level.var_59011156b1a94cf9 + timepassed );
        return;
    }
    
    setomnvar( "ui_hardpoint_timer", level.var_59011156b1a94cf9 );
}

// Namespace multi_mode
// Params 1
// Checksum 0xc365d029, Offset: 0x740b
// Size: 0x13
function koth_onunoccupied( params )
{
    function_eebc03595bee0017();
}

// Namespace multi_mode
// Params 1
// Checksum 0x8247cdf6, Offset: 0x7426
// Size: 0x1e
function function_e6a109937ff9b846( params )
{
    function_eebc03595bee0017( params.team );
}

// Namespace multi_mode
// Params 1
// Checksum 0x5be310c9, Offset: 0x744c
// Size: 0x1c
function koth_onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"koth_capture" );
}

// Namespace multi_mode
// Params 0
// Checksum 0x64a0c65, Offset: 0x7470
// Size: 0x91
function koth_getspawnpoint()
{
    if ( isdefined( level.zone ) )
    {
        spawnparams = spawnfactor::function_daea503b73d07eed( level.zone.trigger getentitynumber(), level.zone.furthestspawndistsq, 1000000, 12250000 );
        return spawnlogic::function_3f9d5fcfb93d4190( self, spawnparams, level.zone.spawngroup, #"fallback", #"default", 2 );
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace multi_mode
// Params 0
// Checksum 0x5fd47239, Offset: 0x7509
// Size: 0x133
function function_d4cab8d1dba0df62()
{
    self.spawninfluencers = [];
    origin = level.zone.trigger.origin;
    
    if ( spawnlogic::useablespawnset( self.spawnsetother ) )
    {
        self.spawninfluencers[ #"hash_7cebf9e340111eb7" ] = spawnlogic::addspawninfluencer( #"hash_7cebf9e340111eb7", origin );
        spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_7cebf9e340111eb7" ], self.spawnsetother );
    }
    
    spawnkey = #koth;
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        self.spawninfluencers[ #"gametype_hardpoint_zone" ] = spawnlogic::addspawninfluencer( #"gametype_hardpoint_zone", origin );
        
        if ( spawnlogic::useablespawnset( self.spawnset ) )
        {
            self.spawninfluencers[ #"hash_78d68ca5b33f3f12" ] = spawnlogic::addspawninfluencer( #"hash_78d68ca5b33f3f12", origin );
            spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_78d68ca5b33f3f12" ], self.spawnset );
        }
        
        function_eebc03595bee0017();
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x42fc3469, Offset: 0x7644
// Size: 0x1bd
function function_eebc03595bee0017( team = undefined )
{
    if ( isdefined( self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] ) )
    {
        spawnlogic::removespawninfluencer( self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] );
        self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] = undefined;
    }
    
    if ( isdefined( self.spawninfluencers[ #"hash_1c79f4698d55c968" ] ) )
    {
        spawnlogic::removespawninfluencer( self.spawninfluencers[ #"hash_1c79f4698d55c968" ] );
        self.spawninfluencers[ #"hash_1c79f4698d55c968" ] = undefined;
    }
    
    if ( !spawnlogic::useablespawnset( self.spawnsetanchor ) )
    {
        return;
    }
    
    origin = level.zone.trigger.origin;
    
    if ( !isdefined( team ) )
    {
        self.spawninfluencers[ #"hash_1c79f4698d55c968" ] = spawnlogic::addspawninfluencer( #"hash_1c79f4698d55c968", origin );
        spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_1c79f4698d55c968" ], self.spawnsetanchor );
        return;
    }
    
    self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] = spawnlogic::addspawninfluencer( #"hash_2592d46fa8cdaed3", origin, team );
    spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ], self.spawnsetanchor );
    self.spawninfluencers[ #"hash_1c79f4698d55c968" ] = spawnlogic::addspawninfluencer( #"hash_1c79f4698d55c968", origin, team );
    spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_1c79f4698d55c968" ], self.spawnsetanchor );
}

// Namespace multi_mode
// Params 0
// Checksum 0xa687e15, Offset: 0x7809
// Size: 0x92
function function_bce3efd336967557()
{
    if ( isdefined( self.spawninfluencers ) )
    {
        foreach ( influencer in self.spawninfluencers )
        {
            spawnlogic::removespawninfluencer( influencer );
        }
        
        self.spawninfluencers = undefined;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xa25f4094, Offset: 0x78a3
// Size: 0x6f
function function_9fe592760983d262( zone )
{
    zone callback::add( "zone_unoccupied", &koth_onunoccupied );
    zone callback::add( "zone_captured", &function_e6a109937ff9b846 );
    zone.onplayerenter = &function_9c7c26673a65fbc3;
    zone.onplayerexit = &function_13bd61fa4f33ac77;
    zone obj_zonecapture::activatezone();
    zone function_bce3efd336967557();
    zone function_d4cab8d1dba0df62();
}

// Namespace multi_mode
// Params 1
// Checksum 0x415f078a, Offset: 0x791a
// Size: 0x67
function function_e5332e272588b005( zone )
{
    zone callback::remove( "zone_unoccupied", &koth_onunoccupied );
    zone callback::remove( "zone_captured", &function_e6a109937ff9b846 );
    zone.onplayerexit = undefined;
    zone.onplayerenter = undefined;
    zone function_bce3efd336967557();
    objidpoolmanager::update_objective_state( 0, "done" );
    zone obj_zonecapture::deactivatezone();
}

// Namespace multi_mode
// Params 1
// Checksum 0x9f8ec2c9, Offset: 0x7989
// Size: 0x19
function function_9c7c26673a65fbc3( player )
{
    player.var_c36e159445e2a48b = 0;
}

// Namespace multi_mode
// Params 1
// Checksum 0x4e55091a, Offset: 0x79aa
// Size: 0x2c
function function_13bd61fa4f33ac77( player )
{
    player.var_c36e159445e2a48b = undefined;
    level.var_77b784031c35fecb[ player.guid ] = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0x90b3f162, Offset: 0x79de
// Size: 0x1f
function koth_onplayerdisconnect( params )
{
    level.var_77b784031c35fecb[ self.guid ] = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0x246d852c, Offset: 0x7a05
// Size: 0x390
function koth_onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    objweapon = deathdata.objweapon;
    victim = deathdata.victim;
    
    if ( level.scoreeventglobals.var_78e819588dff740b )
    {
        victim.var_1f0eae9ac93b88db = 0;
    }
    
    if ( !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( attacker == victim )
    {
        return;
    }
    
    if ( !isdefined( level.zone ) )
    {
        return;
    }
    
    ownerteam = level.zone.ownerteam;
    
    if ( !isdefined( ownerteam ) )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    var_a844077fc818e557 = 0;
    attackerteam = attacker.team;
    var_3585c67984f0d918 = attacker istouching( level.zone.trigger );
    var_9b43c11c6592a807 = victim istouching( level.zone.trigger );
    
    if ( attackerteam != ownerteam )
    {
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && level.zonecapturetime > 0 && var_3585c67984f0d918 )
        {
            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
        }
        else if ( var_9b43c11c6592a807 )
        {
            attacker events::function_58da673c1c3fc9f2();
            attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
            thread utility::trycall( level.matchdata_logvictimkillevent, deathdata.killid, "defending" );
            attacker thread events::function_f3b6ddfecdb144fa( level.zone.objectivekey );
        }
        
        return;
    }
    
    if ( var_3585c67984f0d918 )
    {
        attacker events::function_20a5f572df6afd43( { #extraparam:level.zone.objectivekey } );
        attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x378>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker stats::setextrascore1( attacker.pers[ "defends" ] );
        attacker.var_c36e159445e2a48b++;
        
        if ( attacker.var_c36e159445e2a48b == 5 )
        {
            attacker thread events::function_d4fd7d540188e407();
        }
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x26f7863a, Offset: 0x7d9d
// Size: 0x1d6
function function_885c6977159f7fd9()
{
    waittillframeend();
    zoneentnum = level.zone.trigger getentitynumber();
    function_e5332e272588b005( level.zone );
    level.zone notify( #"deleted" );
    function_80b0d9f463e7cc72();
    level.var_1e1962e4a4e8622 = undefined;
    level.var_a1ef86bb72309efc = undefined;
    level.var_77b784031c35fecb = undefined;
    level.var_7db1da1f52caadb1 = undefined;
    level.var_4c024662ea47c4f4 = undefined;
    level.pausemodetimer = undefined;
    level.zone = undefined;
    level.objectives = undefined;
    
    if ( level.var_d74199afbc210abb )
    {
        if ( !level.var_9dc930cda807660d || level.var_709caf807ba884ea[ #"piggy_bank" ] == 1 )
        {
            level.koth_objectives = undefined;
        }
        
        level.koth_prevzoneindex = undefined;
        level.var_d4aafa3519a3557e = undefined;
        level.var_fa4a3c9179d3c225 = undefined;
        level.var_858e6b4f99179287 = undefined;
        level.var_57af36e1fec51666 = undefined;
        level.var_cf8f122775d88614 = undefined;
        level.zonemajoritycapture = undefined;
        level.zonecapturetime = undefined;
    }
    
    foreach ( player in level.players )
    {
        player.capsperminute = undefined;
        player.var_c36e159445e2a48b = undefined;
        player.var_1f0eae9ac93b88db = undefined;
        player.touchtriggers[ zoneentnum ] = undefined;
        player.numcaps = undefined;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x63ce71a8, Offset: 0x7f7b
// Size: 0x1e0
function dom_initdata( index )
{
    level.var_171096fca96e23d0 = getmatchrulesdata( "domData", "flagsRequiredToScore" ) ?? 1;
    level.var_5d67a1172206bfda = getmatchrulesdata( "domData", "strongholdScoreInterval" ) ?? 0;
    level.var_594bd7a47e19871d = getmatchrulesdata( "domData", "pointsPerFlag" ) ?? 1;
    level.var_c5cdf3dd65ba3cf = getmatchrulesdata( "siegeData", "preCapPoints" ) ?? 0;
    level.blockcapdisabled = getmatchrulesdata( "domData", "flagblockcapdisabled" ) ?? 0;
    level.capturedecay = getmatchrulesdata( "captureData", "captureDecay" ) ?? 1;
    level.capturetype = getmatchrulesdata( "captureData", "captureType" ) ?? 1;
    level.disablemajoritycapprogress = getmatchrulesdata( "controlData", "disableMajorityCapProgress" ) ?? 0;
    level.flagcapturetime = getmatchrulesdata( "domData", "flagCaptureTime" ) ?? 10;
    level.flagdecaytime = getmatchrulesdata( "domData", "flagDecayTime" ) ?? 0;
    level.flagmodelhidden = getmatchrulesdata( "domData", "flagModelHidden" ) ?? 0;
    level.flagneutralization = getmatchrulesdata( "domData", "flagNeutralization" ) ?? 0;
    level.flagreinforcement = getmatchrulesdata( "domData", "flagReinforcement" ) ?? 0;
    level.objectivescaler = getmatchrulesdata( "domData", "objScalar" ) ?? 4;
    level.usestrongholdscoring = 0;
    
    if ( level.flagreinforcement )
    {
        level.var_5c4687f44344589a = getmatchrulesdata( "domData", "pointsPerReinforcedFlag" ) ?? 0;
        level.reinforcementstompscalar = getmatchrulesdata( "domData", "reinforcementStompScalar" ) ?? 1;
    }
    
    function_51009539ac4c6636();
}

// Namespace multi_mode
// Params 1
// Checksum 0xd84302c0, Offset: 0x8163
// Size: 0xea
function function_59a73944bee6e872( var_b84e5730f2d9c89c )
{
    thread function_d6027d4a5f15f549();
    function_2ed23752502c58b0();
    function_b2df7162ada06065();
    level.objectives = level.dom_objectives;
    level.dom_scoretick = [];
    level.lastcaptime = gettime();
    level.playholdtwovo = 0;
    level.onobjectivecomplete = &function_eff66825e18d7f36;
    level.var_6acc53d8aaa7d1e3 = &function_420eaefd3e54cba9;
    level.var_c18eb83275e643e7 = &function_e2ef95644e1c3080;
    level.checkcustomclosetoscorelimit = &function_2856ff71f24a2a32;
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    level.var_40ab710579539b1 = &game_utility_mp::function_daab43ec23b14d5c;
    
    /#
        level.domflag_setneutral = &obj_dom::domflag_setneutral;
        level.dompoint_setcaptured = &obj_dom::dompoint_setcaptured;
        level.onflagcapture = &function_eff66825e18d7f36;
    #/
    
    thread function_d70439a6ac097aa2();
}

// Namespace multi_mode
// Params 0
// Checksum 0x8859f42f, Offset: 0x8255
// Size: 0x52
function function_d6027d4a5f15f549()
{
    if ( !flags::gameflag( "intro_boost_vo_done" ) )
    {
        flags::gameflagwait( "intro_boost_vo_done" );
    }
    
    dialog::leaderdialogonplayers( #"gametype_dom", level.players );
    wait 4;
    dialog::leaderdialogonplayers( #"gametype_dom_boost", level.players );
}

// Namespace multi_mode
// Params 0
// Checksum 0xe48a3144, Offset: 0x82af
// Size: 0x9a
function function_2ed23752502c58b0()
{
    level.icontarget = "waypoint_dom_target";
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
    
    if ( level.flagreinforcement )
    {
        level.iconreinforcing = "waypoint_reinforcing";
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x61c9c9eb, Offset: 0x8351
// Size: 0x359
function function_4135918783f6eadb()
{
    var_e1a478a31edb8885 = 0;
    
    foreach ( objectivekey, obj in level.dom_objectives )
    {
        iconid = dom::function_37ea0cadc6e9022a( objectivekey );
        iconimage = "icon_waypoint_dom" + objectivekey;
        var_58d1e2130b069e62 = dom::function_ecc6f580f99fa4f4( objectivekey );
        
        if ( isdefined( level.var_93532ab90ccea78c ) && isdefined( level.var_93532ab90ccea78c.var_3f71707bd3d270e4 ) && isdefined( level.var_93532ab90ccea78c.var_3f71707bd3d270e4[ var_58d1e2130b069e62 ].objectiveicon ) && level.var_93532ab90ccea78c.var_3f71707bd3d270e4[ var_58d1e2130b069e62 ].objectiveicon != %"" )
        {
            iconimage = level.var_93532ab90ccea78c.var_3f71707bd3d270e4[ var_58d1e2130b069e62 ].objectiveicon;
        }
        
        gamelogic_mp::setwaypointiconinfo( "icon_waypoint_dom" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_taking" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_capture" + objectivekey, var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_defend" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_defending" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_blocking" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_blocked" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_losing" + objectivekey, var_e1a478a31edb8885, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_contested" + objectivekey, var_e1a478a31edb8885, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", iconimage, 0, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_clearing" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", iconimage, 1, iconid );
        gamelogic_mp::setwaypointiconinfo( "waypoint_locked" + objectivekey, var_e1a478a31edb8885, "neutral", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, iconid );
        
        if ( level.flagreinforcement )
        {
            gamelogic_mp::setwaypointiconinfo( "waypoint_reinforcing" + objectivekey, var_e1a478a31edb8885, "friendly", &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", iconimage, 1, iconid );
        }
    }
}

// Namespace multi_mode
// Params 2
// Checksum 0xd9d89e49, Offset: 0x86b2
// Size: 0x70
function function_420eaefd3e54cba9( ownerteam, lastclaimteam )
{
    if ( ownerteam != "neutral" && self.ownerteam == ownerteam )
    {
        gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        return;
    }
    
    if ( lastclaimteam != "none" )
    {
        gameobjects::setobjectivestatusicons( level.iconlosing, level.icontaking );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xebccc15e, Offset: 0x872a
// Size: 0x1c
function dom_onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"dom_cap_defend" );
}

// Namespace multi_mode
// Params 0
// Checksum 0xea4a1330, Offset: 0x874e
// Size: 0x90
function dom_getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    teamdompoints = function_80f65dba7dbcee0b( spawnteam );
    enemyteam = team_utility::getotherteam( spawnteam );
    var_1aeb62419a4ccf2d = function_80f65dba7dbcee0b( enemyteam );
    flaggroups = function_e8ed49ba125f9269( teamdompoints, var_1aeb62419a4ccf2d, spawnteam, enemyteam );
    var_5604c97df7f05c1b = spawnfactor::function_6ee12c1c8b06235e( flaggroups[ "preferred" ], flaggroups[ "secondary" ] );
    return spawnlogic::function_3f9d5fcfb93d4190( self, var_5604c97df7f05c1b );
}

// Namespace multi_mode
// Params 1
// Checksum 0xd35bfd08, Offset: 0x87e7
// Size: 0xa9
function function_80f65dba7dbcee0b( team )
{
    teamdompoints = [];
    
    foreach ( dompoint in level.dom_objectives )
    {
        owningteam = dompoint gameobjects::getownerteam();
        
        if ( owningteam == team )
        {
            teamdompoints[ teamdompoints.size ] = dompoint;
        }
    }
    
    return teamdompoints;
}

// Namespace multi_mode
// Params 4
// Checksum 0x8263d773, Offset: 0x8899
// Size: 0x2ab
function function_e8ed49ba125f9269( teamdompoints, var_1aeb62419a4ccf2d, team, enemyteam )
{
    var_be29eb2f2717d482 = [];
    
    if ( teamdompoints.size == level.dom_objectives.size )
    {
        enemyspawnflag = level.dom_bestspawnflag[ enemyteam ];
        
        foreach ( flag in teamdompoints )
        {
            if ( flag != enemyspawnflag )
            {
                var_be29eb2f2717d482[ var_be29eb2f2717d482.size ] = flag;
            }
        }
    }
    else if ( teamdompoints.size > 0 )
    {
        foreach ( flag in teamdompoints )
        {
            var_be29eb2f2717d482[ var_be29eb2f2717d482.size ] = flag;
        }
    }
    else if ( teamdompoints.size == 0 )
    {
        var_8ba8b04fdd001d1c = level.dom_bestspawnflag[ team ];
        
        if ( var_1aeb62419a4ccf2d.size > 0 && var_1aeb62419a4ccf2d.size < level.dom_objectives.size )
        {
            var_8ba8b04fdd001d1c = obj_dom::getunownedflagneareststart( team );
        }
        
        var_be29eb2f2717d482[ var_be29eb2f2717d482.size ] = var_8ba8b04fdd001d1c;
    }
    
    preferreddompoints = 0;
    secondarydompoints = 0;
    
    foreach ( flag in var_be29eb2f2717d482 )
    {
        claimteam = flag gameobjects::getclaimteam();
        
        if ( claimteam == "none" )
        {
            preferreddompoints |= flag.spawnflagid;
            continue;
        }
        
        secondarydompoints |= flag.spawnflagid;
    }
    
    if ( preferreddompoints & 1 && preferreddompoints & 2 )
    {
        preferreddompoints |= 32;
    }
    
    if ( preferreddompoints & 4 && preferreddompoints & 2 )
    {
        preferreddompoints |= 64;
    }
    
    if ( preferreddompoints & 1 && preferreddompoints & 4 )
    {
        preferreddompoints |= 128;
    }
    
    flaggroups = [];
    flaggroups[ "preferred" ] = preferreddompoints;
    flaggroups[ "secondary" ] = secondarydompoints;
    return flaggroups;
}

// Namespace multi_mode
// Params 0
// Checksum 0x9fa1b8e9, Offset: 0x8b4d
// Size: 0x13d
function function_9e942237bf00f4af()
{
    /#
        setdevdvarifuninitialized( @"scr_domdebug", "<dev string:x460>" );
    #/
    
    foreach ( domflag in level.dom_objectives )
    {
        domflag.spawnflagid = function_259cff712beb3f8( domflag.objectivekey );
    }
    
    spawnpoints = level.spawnpoints;
    
    foreach ( spawnpoint in spawnpoints )
    {
        spawnpoint.scriptdata.domflagassignments = function_2e6de802122825ed( spawnpoint );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x789e14be, Offset: 0x8c92
// Size: 0x43
function function_259cff712beb3f8( objectivekey )
{
    switch ( objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 1;
        case #"hash_fac2c2f6bddd4504":
            return 2;
        case #"hash_fac2c3f6bddd4697":
            return 4;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x59cab2, Offset: 0x8cde
// Size: 0xc1
function function_544b0d595d349aa8( stringvalue )
{
    stringvalue = tolower( stringvalue );
    
    switch ( stringvalue )
    {
        case #"hash_31103fbc01bd840c":
            return 1;
        case #"hash_311042bc01bd88c5":
            return 2;
        case #"hash_311041bc01bd8732":
            return 4;
        case #"hash_fa18c2f6bd57792a":
        case #"hash_fa21b1f6bd5e1a2c":
            return 32;
        case #"hash_fa1ecaf6bd5c02f0":
        case #"hash_fa21b3f6bd5e1d52":
            return 64;
        case #"hash_fa18c3f6bd577abd":
        case #"hash_fa1ecdf6bd5c07a9":
            return 128;
        default:
            assertmsg( "<dev string:x462>" + stringvalue + "<dev string:x494>" );
            break;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xf0bd12c3, Offset: 0x8da7
// Size: 0xd4
function function_2e6de802122825ed( spawnpoint )
{
    if ( game_utility::isarenamap() )
    {
        if ( spawnpoint.script_noteworthy == "1" || spawnpoint.script_noteworthy == "2" || spawnpoint.script_noteworthy == "3" )
        {
            spawnpoint.script_noteworthy = "";
        }
    }
    
    if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy != "" )
    {
        if ( !isdefined( game_utility::getlocaleid() ) )
        {
            var_7237854e3be197ca = function_544b0d595d349aa8( spawnpoint.script_noteworthy );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
    }
    
    return function_4c65cde74b50c3ec( spawnpoint.origin ).spawnflagid;
}

// Namespace multi_mode
// Params 1
// Checksum 0x760b5ee0, Offset: 0x8e84
// Size: 0x84
function function_f7ec2ba17fe17e7( objectivekey )
{
    switch ( objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return #"zonea";
        case #"hash_fac2c2f6bddd4504":
            return #"zoneb";
        case #"hash_fac2c3f6bddd4697":
            return #"zonec";
        case #"hash_fac2c0f6bddd41de":
            return #"zoned";
        case #"hash_fac2c1f6bddd4371":
            return #"zonee";
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x842f91b2, Offset: 0x8f11
// Size: 0x40
function function_775f1df32c1bf43a()
{
    spawn_set = function_f7ec2ba17fe17e7( self.objectivekey );
    spawn_points = spawnlogic::getspawnset( spawn_set );
    
    if ( spawn_points.size )
    {
        self.spawnset = spawn_set;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xd399ca0f, Offset: 0x8f59
// Size: 0x4d
function function_a4a3004d47d8ae77()
{
    self.influencerkeys[ "owner" ] = #"gametype_dom_owner_team";
    self.influencerkeys[ "other" ] = #"gametype_dom_other_team";
    self.influencerkeys[ "neutral" ] = #"gametype_dom_other_team";
}

// Namespace multi_mode
// Params 1
// Checksum 0xfb55ad2, Offset: 0x8fae
// Size: 0x232
function function_4c65cde74b50c3ec( pos )
{
    /#
        if ( !isnavmeshloaded() )
        {
            return dom::function_eac831db102ec430( pos );
        }
    #/
    
    navmeshpoints = [];
    
    foreach ( dompoint in level.dom_objectives )
    {
        origin = dompoint gameobjects::getorigin();
        dompoint.navmeshpos = getclosestpointonnavmesh( origin );
        navmeshpoints[ navmeshpoints.size ] = dompoint.navmeshpos;
    }
    
    var_a33a56db6de8c0f = findclosestpointbyapproxpathdist( navmeshpoints, getclosestpointonnavmesh( pos ) );
    nearestdompoint = undefined;
    
    if ( !isdefined( var_a33a56db6de8c0f ) )
    {
        nearestdist = undefined;
        
        foreach ( dompoint in level.dom_objectives )
        {
            origin = dompoint gameobjects::getorigin();
            dist = distancesquared( origin, pos );
            
            if ( !isdefined( nearestdompoint ) || dist < nearestdist )
            {
                nearestdompoint = dompoint;
                nearestdist = dist;
            }
        }
    }
    else
    {
        foreach ( dompoint in level.dom_objectives )
        {
            if ( distance2dsquared( dompoint.navmeshpos, var_a33a56db6de8c0f ) < 1 )
            {
                nearestdompoint = dompoint;
                break;
            }
        }
        
        assert( isdefined( nearestdompoint ) );
    }
    
    return nearestdompoint;
}

// Namespace multi_mode
// Params 0
// Checksum 0xfa86427e, Offset: 0x91e9
// Size: 0x25b
function function_51009539ac4c6636()
{
    primaryflags = [];
    level.changenumdomflags = getdvarint( @"scr_dom_flagcount", 0 );
    primaryflags = getentarray( "flag_primary", #targetname );
    
    if ( primaryflags.size < 2 )
    {
        assertmsg( "<dev string:x4d6>" );
        return;
    }
    
    setomnvar( "ui_num_dom_flags", primaryflags.size );
    level.dom_objectives = [];
    
    foreach ( trigger in primaryflags )
    {
        if ( trigger.script_label == "_d" || trigger.script_label == "_e" )
        {
            continue;
        }
        
        domflag = obj_dom::setupobjective( trigger, undefined, 1, 1 );
        domflag thread function_bec56a542452aacd( trigger.target, trigger.script_label );
        domflag gameobjects::disableobject();
        level.dom_objectives[ domflag.objectivekey ] = domflag;
    }
    
    spawngroup = spawnlogic::function_1f5152a92aada360( #"start" ) ? #"start" : #"primary";
    spawn_attackers = spawnlogic::function_f89ebff0bfb8555( spawngroup, game[ "attackers" ] );
    spawn_defenders = spawnlogic::function_f89ebff0bfb8555( spawngroup, game[ "defenders" ] );
    level.startpos[ game[ "attackers" ] ] = spawn_attackers[ 0 ].origin;
    level.startpos[ game[ "defenders" ] ] = spawn_defenders[ 0 ].origin;
    level.dom_bestspawnflag = [];
    level.dom_bestspawnflag[ game[ "attackers" ] ] = dom_getunownedflagneareststart( game[ "attackers" ], undefined );
    level.dom_bestspawnflag[ game[ "defenders" ] ] = dom_getunownedflagneareststart( game[ "defenders" ], level.dom_bestspawnflag[ game[ "attackers" ] ] );
    function_9e942237bf00f4af();
    function_4135918783f6eadb();
}

// Namespace multi_mode
// Params 2
// Checksum 0xe2b04ff6, Offset: 0x944c
// Size: 0x125
function dom_getunownedflagneareststart( team, excludeflag )
{
    best = undefined;
    bestdistsq = undefined;
    
    foreach ( flag in level.dom_objectives )
    {
        if ( flag gameobjects::getownerteam() != "neutral" )
        {
            continue;
        }
        
        distsq = distancesquared( flag.trigger.origin, level.startpos[ team ] );
        
        if ( isdefined( excludeflag ) )
        {
            if ( !obj_dom::isflagexcluded( flag, excludeflag ) && ( !isdefined( best ) || distsq < bestdistsq ) )
            {
                bestdistsq = distsq;
                best = flag;
            }
            
            continue;
        }
        
        if ( !isdefined( best ) || distsq < bestdistsq )
        {
            bestdistsq = distsq;
            best = flag;
        }
    }
    
    return best;
}

// Namespace multi_mode
// Params 0
// Checksum 0x1e6c495e, Offset: 0x957a
// Size: 0x217
function function_b2df7162ada06065()
{
    foreach ( flag in level.dom_objectives )
    {
        reservedobjid = obj_dom::getreservedobjid( flag.objectivekey );
        flag gameobjects::requestid( 1, 1, reservedobjid, undefined, undefined, undefined );
        function_ca1cc2938b2b4271( flag.objidnum, flag.trigger );
        flag gameobjects::enableobject();
        flag.onplayerenter = &function_6563dc83f8aa8d7;
        flag.onplayerexit = &function_9a21ddce08125ed3;
        flag.onuse = &obj_dom::dompoint_onuse;
        flag.onbeginuse = &dom_onbeginuse;
        flag.onuseupdate = &obj_dom::dompoint_onuseupdate;
        flag.onenduse = &dom_onenduse;
        flag.oncontested = &dom_oncontested;
        flag.onuncontested = &dom_onuncontested;
        flag.onunoccupied = &dom_onunoccupied;
        flag.oncleared = &obj_dom::function_759196e1bdad8cfc;
        flag.ondecayed = &obj_dom::function_759196e1bdad8cfc;
        flag.onpinnedstate = &dom_onpinnedstate;
        flag.onunpinnedstate = &dom_onunpinnedstate;
        flag.stompprogressreward = &obj_dom::dompoint_stompprogressreward;
        flag gameobjects::setobjectivestatusicons( level.icondefend, level.icontarget );
        flag gameobjects::setvisibleteam( "any" );
        flag obj_dom::domflag_setneutral();
        flag function_775f1df32c1bf43a();
        flag function_a4a3004d47d8ae77();
        flag thread function_55382222e5d3e025( "idle" );
    }
    
    if ( level.var_c5cdf3dd65ba3cf )
    {
        thread obj_dom::precap( 0 );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x71179ae2, Offset: 0x9799
// Size: 0x239
function function_7725739be11febe4()
{
    foreach ( flag in level.dom_objectives )
    {
        flag.onplayerenter = undefined;
        flag.onplayerexit = undefined;
        flag.onuse = undefined;
        flag.onbeginuse = undefined;
        flag.onuseupdate = undefined;
        flag.onenduse = undefined;
        flag.oncontested = undefined;
        flag.onuncontested = undefined;
        flag.onunoccupied = undefined;
        flag.oncleared = undefined;
        flag.ondecayed = undefined;
        flag.onpinnedstate = undefined;
        flag.onunpinnedstate = undefined;
        flag.stompprogressreward = undefined;
        flag.stalemate = 0;
        flag.wasstalemate = 0;
        flag.didstatusnotify = 0;
        flag function_55382222e5d3e025( "off" );
        
        if ( !level.var_d74199afbc210abb )
        {
            flag gameobjects::resetcaptureprogress();
            objidpoolmanager::objective_set_progress( flag.objidnum, 0 );
            flag.curprogress = 0;
        }
        
        foreach ( player in level.players )
        {
            objidpoolmanager::objective_unpin_player( flag.objidnum, player );
        }
        
        function_ca30be9f04600a82( flag.objidnum );
        flag.trigger utility::trigger_off();
        flag function_f8237e13db16946a();
        flag gameobjects::releaseid( 1, 0 );
        flag obj_dom::function_45132b4fe3e00ecc();
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xc23b0239, Offset: 0x99da
// Size: 0xf
function function_f8237e13db16946a()
{
    waitframe();
    gameobjects::setvisibleteam( "none" );
}

// Namespace multi_mode
// Params 2
// Checksum 0x8c3c0940, Offset: 0x99f1
// Size: 0x112
function function_bec56a542452aacd( target, label )
{
    wait 1;
    othervisuals = getentitylessscriptablearray( target, #targetname );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
    }
    
    self.chevrons = chevrons;
    
    if ( level.var_f0ff8e3c752b9d2a.ref == #"domination" )
    {
        function_55382222e5d3e025( "idle" );
        return;
    }
    
    function_55382222e5d3e025( "off" );
}

// Namespace multi_mode
// Params 1
// Checksum 0xa4fc8d6b, Offset: 0x9b0b
// Size: 0x10b
function function_55382222e5d3e025( state )
{
    self notify( #"hash_790176b3b87916df" );
    self endon( #"hash_790176b3b87916df" );
    level endon( #"hash_56dbbc54f182022" );
    
    while ( !isdefined( self.chevrons ) )
    {
        waitframe();
    }
    
    var_1a5d8528edba5ab0 = "chevron_";
    
    foreach ( chevron in self.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( var_1a5d8528edba5ab0 + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x545ff14b, Offset: 0x9c1e
// Size: 0xce
function function_7601b40ce88a5d76()
{
    if ( self.ownerteam == game[ "attackers" ] )
    {
        thread function_55382222e5d3e025( game[ "attackers" ] );
    }
    else if ( self.ownerteam == game[ "defenders" ] )
    {
        thread function_55382222e5d3e025( game[ "defenders" ] );
    }
    else if ( self.isunoccupied || self.ownerteam == "neutral" )
    {
        thread function_55382222e5d3e025( "idle" );
    }
    
    if ( self.stalemate )
    {
        thread function_55382222e5d3e025( "contested" );
    }
    else if ( !self.isunoccupied && !level.gametypebundle.var_f2e17118451564d8 )
    {
        thread function_55382222e5d3e025( self.mostnumtouchingteam );
    }
    
    function_e2ef95644e1c3080();
}

// Namespace multi_mode
// Params 0
// Checksum 0x9b7ff07f, Offset: 0x9cf4
// Size: 0x63
function function_e2ef95644e1c3080()
{
    zone = self;
    luaindex = zone.objidnum + 1;
    setomnvar( "ui_axis_player_count_zone_" + luaindex, zone.numtouching[ "axis" ] );
    setomnvar( "ui_allies_player_count_zone_" + luaindex, zone.numtouching[ "allies" ] );
}

// Namespace multi_mode
// Params 1
// Checksum 0x1f5a3e57, Offset: 0x9d5f
// Size: 0x19
function function_6563dc83f8aa8d7( player )
{
    player.var_c36e159445e2a48b = 0;
}

// Namespace multi_mode
// Params 1
// Checksum 0xde4b1b38, Offset: 0x9d80
// Size: 0x17
function function_9a21ddce08125ed3( player )
{
    player.var_c36e159445e2a48b = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0xe8cf301b, Offset: 0x9d9f
// Size: 0x1c
function dom_onbeginuse( player )
{
    obj_dom::dompoint_onusebegin( player );
    function_7601b40ce88a5d76();
}

// Namespace multi_mode
// Params 3
// Checksum 0xd3824c8, Offset: 0x9dc3
// Size: 0x4a
function dom_onenduse( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
    
    if ( success )
    {
        thread function_55382222e5d3e025( player.team );
        return;
    }
    
    function_7601b40ce88a5d76();
}

// Namespace multi_mode
// Params 1
// Checksum 0x275682bc, Offset: 0x9e15
// Size: 0xc3, Type: bool
function function_3fdf2cf727efa7bf( ownerteam )
{
    foreach ( flag in level.dom_objectives )
    {
        var_f58beca35e97756d = flag gameobjects::getownerteam();
        var_18faa633a2aa073d = flag gameobjects::function_70f36e1166a5877b();
        
        if ( var_f58beca35e97756d != ownerteam || var_18faa633a2aa073d != "neutral" && var_18faa633a2aa073d != "none" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace multi_mode
// Params 6
// Checksum 0xa4aac67d, Offset: 0x9ee1
// Size: 0x21d
function function_eff66825e18d7f36( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    assert( team != "<dev string:x504>" );
    otherteam = team_utility::getotherteam( team );
    
    if ( obj_dom::getteamflagcount( team ) == level.dom_objectives.size )
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"dom_flag_captured_all", teams::getteamdata( team, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"dom_flag_lost_all", teams::getteamdata( otherteam, "players" ) );
    }
    else
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"dom_flag_captured", teams::getteamdata( team, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"dom_flag_lost", teams::getteamdata( otherteam, "players" ) );
    }
    
    if ( obj_dom::getteamflagcount( team ) < level.dom_objectives.size )
    {
        dialog::statusdialog( "secured" + ( self.var_98076e259d94a508 ?? self.objectivekey ), team );
        dialog::statusdialog( "lost" + ( self.var_98076e259d94a508 ?? self.objectivekey ), otherteam );
    }
    else
    {
        level callback::callback( #"music_event", { #team:team, #event_type:#"dominating" } );
        dialog::statusdialog( #"gamestate_domwinning", team );
        
        if ( function_3fdf2cf727efa7bf( team ) )
        {
            dialog::statusdialog( #"hash_271b0905c673fb02", otherteam );
        }
        else
        {
            dialog::statusdialog( #"gamestate_domlosing", otherteam );
        }
    }
    
    if ( level.var_26957a14f92507d )
    {
        dom::function_26957a14f92507d( team );
    }
    
    if ( isdefined( level.sharedfuncs[ #"multimode" ][ #"hash_592eb0a88aedc4a" ] ) )
    {
        self [[ level.sharedfuncs[ #"multimode" ][ #"hash_592eb0a88aedc4a" ] ]]( objectivetype, label, credit_player, team, oldteam, flagobj );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xc3942399, Offset: 0xa106
// Size: 0x10
function dom_oncontested()
{
    obj_dom::dompoint_oncontested();
    function_7601b40ce88a5d76();
}

// Namespace multi_mode
// Params 1
// Checksum 0x4057f393, Offset: 0xa11e
// Size: 0x26
function dom_onuncontested( lastclaimteam )
{
    obj_dom::dompoint_onuncontested( lastclaimteam );
    utility::delaythread( 0.05, &function_7601b40ce88a5d76 );
}

// Namespace multi_mode
// Params 0
// Checksum 0xdd21f376, Offset: 0xa14c
// Size: 0x10
function dom_onunoccupied()
{
    obj_dom::dompoint_onunoccupied();
    function_7601b40ce88a5d76();
}

// Namespace multi_mode
// Params 1
// Checksum 0x2c4b962b, Offset: 0xa164
// Size: 0x1c
function dom_onpinnedstate( player )
{
    obj_dom::dompoint_onpinnedstate( player );
    function_7601b40ce88a5d76();
}

// Namespace multi_mode
// Params 1
// Checksum 0xebf3a0f6, Offset: 0xa188
// Size: 0x1c
function dom_onunpinnedstate( player )
{
    obj_dom::dompoint_onunpinnedstate( player );
    function_7601b40ce88a5d76();
}

// Namespace multi_mode
// Params 0
// Checksum 0x8a15c97e, Offset: 0xa1ac
// Size: 0xcb
function function_5b646d6359843999()
{
    domflags = [];
    
    foreach ( domflag in level.dom_objectives )
    {
        owningteam = domflag gameobjects::getownerteam();
        
        if ( owningteam != "none" && owningteam != "neutral" && owningteam != "all" && isdefined( domflag.capturetime ) )
        {
            domflags[ domflags.size ] = domflag;
        }
    }
    
    return domflags;
}

// Namespace multi_mode
// Params 0
// Checksum 0x1a1d6196, Offset: 0xa280
// Size: 0x2a3
function function_d70439a6ac097aa2()
{
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    
    while ( !level.gameended )
    {
        waittime = 5;
        
        if ( level.var_5d67a1172206bfda > 0 )
        {
            waittime = level.var_5d67a1172206bfda;
        }
        
        timeleft = level.var_cda6c691a06ec205 - gettime();
        
        if ( timeleft < 5000 && timeleft > 0 )
        {
            waittime = timeleft / 1000;
        }
        
        wait waittime;
        hostmigration::waittillhostmigrationdone();
        domflags = function_5b646d6359843999();
        timesincelastcap = gettime() - level.lastcaptime;
        
        foreach ( entry in level.teamnamelist )
        {
            level.dom_scoretick[ entry ] = 0;
        }
        
        if ( domflags.size )
        {
            foreach ( domflag in domflags )
            {
                team = domflag gameobjects::getownerteam();
                assert( team_utility::isgameplayteam( team ) );
                var_d9425977785add8f = obj_dom::getteamflagcount( team );
                
                if ( var_d9425977785add8f >= level.var_171096fca96e23d0 )
                {
                    level.dom_scoretick[ team ] += level.var_594bd7a47e19871d;
                    
                    if ( domflag.reinforced && isdefined( level.var_5c4687f44344589a ) )
                    {
                        level.scoretick[ team ] += level.var_5c4687f44344589a;
                    }
                }
                
                if ( var_d9425977785add8f == 2 && level.playholdtwovo && timesincelastcap > 30000 )
                {
                    otherteam = team_utility::getotherteam( team );
                    dialog::statusdialog( "enemy_captured_2", otherteam );
                    dialog::statusdialog( "friendly_captured_2", team );
                    level.playholdtwovo = 0;
                }
            }
            
            function_94b04a274640706d();
        }
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x53685208, Offset: 0xa52b
// Size: 0x1a5
function function_94b04a274640706d()
{
    teamshitscorelimit = [];
    
    foreach ( entry in level.teamnamelist )
    {
        targetscore = game[ "teamScores" ][ entry ] + level.dom_scoretick[ entry ];
        
        if ( targetscore >= level.roundscorelimit )
        {
            teamshitscorelimit[ teamshitscorelimit.size ] = entry;
        }
    }
    
    if ( teamshitscorelimit.size == 1 )
    {
        level.dom_scoretick[ teamshitscorelimit[ 0 ] ] = level.roundscorelimit - game[ "teamScores" ][ teamshitscorelimit[ 0 ] ];
    }
    
    var_5bd83029350992ed = gamescore::calculatewinningteam();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.dom_scoretick[ entry ] > 0 )
        {
            gamescore::giveteamscoreforobjective( entry, level.dom_scoretick[ entry ], 1, undefined, 1 );
        }
    }
    
    var_b68dc93240b77466 = gamescore::calculatewinningteam();
    
    if ( var_5bd83029350992ed != var_b68dc93240b77466 )
    {
        gamescore::playscorestatusdialog( var_b68dc93240b77466, 1, var_5bd83029350992ed );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x4c433454, Offset: 0xa6d8
// Size: 0x66, Type: bool
function function_2856ff71f24a2a32( team )
{
    assert( isdefined( team ) );
    checkroundlimit = 10;
    var_a6f903ff6a32f2a9 = 20;
    var_d262c35ec7ded597 = level.roundscorelimit - getteamscore( team );
    
    if ( var_d262c35ec7ded597 <= ( game[ "finalRound" ] ? var_a6f903ff6a32f2a9 : checkroundlimit ) )
    {
        return true;
    }
    
    return false;
}

// Namespace multi_mode
// Params 1
// Checksum 0xd54cb4af, Offset: 0xa747
// Size: 0xb6
function dom_onplayerkilled( deathdata )
{
    objweapon = deathdata.objweapon;
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    deathdata.victim obj_dom::awardgenericmedals( deathdata.inflictor, deathdata.attacker, deathdata.damage, deathdata.meansofdeath, objweapon, deathdata.direction_vec, deathdata.hitloc, deathdata.psoffsettime, deathdata.deathanimduration, deathdata.lifeid );
}

// Namespace multi_mode
// Params 0
// Checksum 0x99c27a76, Offset: 0xa805
// Size: 0x1e5
function function_7ed7f879861c5657()
{
    waittillframeend();
    function_7725739be11febe4();
    function_80b0d9f463e7cc72();
    level.var_40cd999d911308e0 = undefined;
    level.var_e16ef107a3dd572b = undefined;
    level.var_40ab710579539b1 = undefined;
    level.onobjectivecomplete = undefined;
    level.var_6acc53d8aaa7d1e3 = undefined;
    level.var_c18eb83275e643e7 = undefined;
    level.checkcustomclosetoscorelimit = undefined;
    level.lastcaptime = undefined;
    level.playholdtwovo = undefined;
    level.objectives = undefined;
    level.dom_scoretick = undefined;
    
    if ( level.var_d74199afbc210abb )
    {
        level.dom_objectives = undefined;
        level.dom_bestspawnflag = undefined;
        level.var_171096fca96e23d0 = undefined;
        level.var_5d67a1172206bfda = undefined;
        level.var_594bd7a47e19871d = undefined;
        level.var_5c4687f44344589a = undefined;
        level.var_c5cdf3dd65ba3cf = undefined;
        level.blockcapdisabled = undefined;
        level.capturedecay = undefined;
        level.capturetype = undefined;
        level.disablemajoritycapprogress = undefined;
        level.flagcapturetime = undefined;
        level.flagdecaytime = undefined;
        level.flagmodelhidden = undefined;
        level.flagneutralization = undefined;
        level.flagreinforcement = undefined;
        level.objectivescaler = undefined;
        level.reinforcementstompscalar = undefined;
        level.usestrongholdscoring = undefined;
    }
    
    /#
        level.domflag_setneutral = undefined;
        level.dompoint_setcaptured = undefined;
        level.onflagcapture = undefined;
    #/
    
    foreach ( player in level.players )
    {
        player.var_c36e159445e2a48b = undefined;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xf094e05b, Offset: 0xa9f2
// Size: 0x96
function hvt_initdata( index )
{
    level.var_24f4a122f2063403 = getmatchrulesdata( "bountyData", "hvtsPerTeam" ) ?? dvars::dvarintvalue( "hvtNumHVTPerTeam", 1, 1, 7 );
    level.var_fa25523c165c6de0 = getmatchrulesdata( "bountyData", "pointsPerHVTKill" ) ?? dvars::dvarintvalue( "hvtPointsPerHVTKilled", 10, 0, 15 );
    level.var_e506992a750491f9 = getmatchrulesdata( "hvtData", "hvtPointsPerKillAsHVT" ) ?? dvars::dvarintvalue( "hvtPointsPerKillAsHVT", 6, 0, 15 );
    level.var_6b0d628a979facca = 2;
}

// Namespace multi_mode
// Params 1
// Checksum 0xf0d47b39, Offset: 0xaa90
// Size: 0x102
function function_b9a0a684a48c240c( var_b84e5730f2d9c89c )
{
    callback::add( #"hash_5e4c0033a7bbd7f", &function_23a9691d4e03da50 );
    level.var_c4a835bb7120c6a0 = &function_c9cc5b4a072e9bb3;
    callback::add( #"player_laststand_revived", &hvt_onplayerrevived );
    level.modelaststandallowed = &function_c5be86a9da8e0276;
    level.modeonlaststandfunc = &function_8948ee4ef863bb0;
    level.modeonexitlaststandfunc = &function_5f1287d521288a60;
    level.laststand = 1;
    setomnvar( "ui_last_stand_type", level.laststand );
    level.disablelaststand = 0;
    callback::add( #"hash_6a8a551945faab9", &function_57ef7286779a9a4c );
    level.var_9f2a0d434853bf59 = [];
    level.var_9f2a0d434853bf59[ "allies" ] = 0;
    level.var_9f2a0d434853bf59[ "axis" ] = 0;
    level.var_74d4a56ce1288d31 = 1500;
    setomnvar( "allies_hvt_last_stand", 0 );
    setomnvar( "axis_hvt_last_stand", 0 );
    thread function_7419b8777ca04043();
}

// Namespace multi_mode
// Params 0
// Checksum 0x387d117a, Offset: 0xab9a
// Size: 0x52
function function_7419b8777ca04043()
{
    if ( !flags::gameflag( "intro_boost_vo_done" ) )
    {
        flags::gameflagwait( "intro_boost_vo_done" );
    }
    
    dialog::leaderdialogonplayers( #"gametype_hvt", level.players );
    wait 4;
    dialog::leaderdialogonplayers( #"gametype_hvt_boost", level.players );
}

// Namespace multi_mode
// Params 1
// Checksum 0xe43a0a42, Offset: 0xabf4
// Size: 0x21
function hvt_onplayerdisconnect( params )
{
    if ( self.ishvt )
    {
        function_83a199622d8bc604( 1 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xb7e5dbee, Offset: 0xac1d
// Size: 0xec
function hvt_onspawnplayer( spawndata )
{
    level.laststand = 1;
    
    foreach ( p in teams::getteamdata( self.team, "players" ) )
    {
        if ( p != self && isdefined( p.var_ccac6e52f3f5480d ) )
        {
            objective_addclienttomask( p.var_ccac6e52f3f5480d, self );
        }
    }
    
    if ( function_b6402b45a52d20c1( self.team ) )
    {
        if ( self.var_5991cf32f0bd6cb7 )
        {
            self.var_5991cf32f0bd6cb7 = undefined;
            return;
        }
        
        thread function_2d46711ee960e122();
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xca3535d2, Offset: 0xad11
// Size: 0x1d0
function function_2d46711ee960e122()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.ishvt = 1;
    self.var_c6a41477353707f = 0;
    function_72f191f5abbdeffe();
    self setclientomnvar( "ui_hvt_status", 1 );
    
    if ( level.var_eb54c3667a8a6653 > 0 )
    {
        self.laststandrevivehealth = level.var_eb54c3667a8a6653;
        self.var_b541f8c69a34639d = level.var_eb54c3667a8a6653;
    }
    
    playerhealth::function_fd91e6d94cab77e7( #"hash_9a03d6e363373f", 0.5 );
    function_3489139a432aba22();
    thread function_c65474efbc7592cf();
    player::showminimap();
    flags::gameflagwait( "intro_boost_vo_done" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    enemyteam = team_utility::getotherteam( self.team );
    excludelist = [ self ];
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_ally_spawned", teams::getteamdata( self.team, "players" ), self );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_enemy_spawned", teams::getteamdata( enemyteam, "players" ) );
    dialog::statusdialog( "hvt_new_friendly", self.team, "hvtUpdate", excludelist );
    dialog::statusdialog( "hvt_new_enemy", enemyteam, "hvtUpdate" );
    thread function_673dd20e512e72c1();
    setomnvar( "ui_" + self.team + "_current_hvt", self getplayerclientnum() );
    self setclientomnvar( "ui_hvt_earned_points", 0 );
    hud_message::showsplash( level.var_93532ab90ccea78c.var_ceb5bf757876f76b );
    thread dialog::leaderdialogonplayer( "hvt_self", "hvtUpdate" );
    function_8a34bb22192b77b();
    
    if ( isdefined( level.var_93532ab90ccea78c.hvt_gesture ) )
    {
        thread function_fbb5b6ef7a48f395();
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xc77e7962, Offset: 0xaee9
// Size: 0x21
function function_fbb5b6ef7a48f395()
{
    wait 2;
    self playgestureviewmodel( level.var_93532ab90ccea78c.hvt_gesture, undefined, 1 );
}

// Namespace multi_mode
// Params 1
// Checksum 0x36e4c4fb, Offset: 0xaf12
// Size: 0x4e
function function_e998a1de5a53c2ec( str_team )
{
    level.var_9f2a0d434853bf59[ str_team ] = 1;
    delay = 5;
    
    /#
        delay = getdvarint( @"scr_hvt_delay", delay );
    #/
    
    wait delay;
    level.var_9f2a0d434853bf59[ str_team ] = 0;
}

// Namespace multi_mode
// Params 1
// Checksum 0xc0d05684, Offset: 0xaf68
// Size: 0xc7
function function_bfd3c43831d2874f( team )
{
    hvtcount = 0;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( player.ishvt )
        {
            hvtcount++;
        }
    }
    
    assert( hvtcount <= level.var_24f4a122f2063403, hvtcount + "<dev string:x50c>" + level.var_24f4a122f2063403 );
    return hvtcount;
}

// Namespace multi_mode
// Params 1
// Checksum 0x422fec5e, Offset: 0xb038
// Size: 0x2f, Type: bool
function function_b6402b45a52d20c1( team )
{
    if ( level.var_9f2a0d434853bf59[ team ] )
    {
        return false;
    }
    
    return function_bfd3c43831d2874f( team ) < level.var_24f4a122f2063403;
}

// Namespace multi_mode
// Params 1
// Checksum 0x1e8479d3, Offset: 0xb070
// Size: 0x35
function function_57ef7286779a9a4c( params )
{
    if ( self.ishvt )
    {
        params.var_2b32a8de075bfd54 *= 2;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xd2e2f87a, Offset: 0xb0ad
// Size: 0xda
function hvt_onplayerdamaged( damagedata )
{
    victim = damagedata.victim;
    attacker = damagedata.attacker;
    
    if ( isdefined( victim ) && isdefined( attacker ) && victim != attacker )
    {
        if ( victim.ishvt )
        {
            if ( player::isinlaststand( victim ) )
            {
                attacker.var_ce5d6ed925aee099 = 1;
                attacker thread function_4c65638f46947e20();
            }
            else
            {
                cooldown = 20000;
                
                if ( !victim.var_c6a41477353707f )
                {
                    cooldown = 0;
                }
                
                excludelist = [ victim ];
                dialog::statusdialog( "hvt_damaged_friendly", victim.team, undefined, excludelist, undefined, cooldown );
            }
            
            victim.var_c6a41477353707f = 1;
        }
    }
}

// Namespace multi_mode
// Params 0, eflags: 0xc
// Checksum 0x9242ccfb, Offset: 0xb18f
// Size: 0x44
function private function_4c65638f46947e20()
{
    self notify( #"hash_e57300c98960b932" );
    self endon( #"hash_e57300c98960b932" );
    self endon( #"disconnect" );
    level endon( #"hash_56dbbc54f182022" );
    wait 3;
    
    if ( isdefined( self ) )
    {
        self.var_ce5d6ed925aee099 = undefined;
    }
}

// Namespace multi_mode
// Params 9
// Checksum 0x417b76b, Offset: 0xb1db
// Size: 0x111
function function_c5be86a9da8e0276( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( self.ishvt )
    {
        return 1;
    }
    else if ( player::function_73fe5f51164eb3ca( self ) )
    {
        if ( damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
        {
            return player::function_77ae038c7dbd566( "headshot" );
        }
        else if ( smeansofdeath == "MOD_FIRE" )
        {
            return player::function_77ae038c7dbd566( "fire" );
        }
        else if ( smeansofdeath == "MOD_MELEE" )
        {
            return player::function_77ae038c7dbd566( "melee" );
        }
        else if ( isexplosivedamagemod( smeansofdeath ) )
        {
            return player::function_77ae038c7dbd566( "explosive" );
        }
        else if ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" )
        {
            return player::function_77ae038c7dbd566( "world" );
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace multi_mode
// Params 0
// Checksum 0x980c7c0f, Offset: 0xb2f5
// Size: 0x1df
function function_8948ee4ef863bb0()
{
    if ( self.ishvt )
    {
        if ( self.team == "allies" )
        {
            setomnvar( "allies_hvt_last_stand", 1 );
        }
        else
        {
            setomnvar( "axis_hvt_last_stand", 1 );
        }
        
        function_2dcf02f3028a81cd( self.var_ccac6e52f3f5480d, level.gametypebundle.reviveicon ?? "ui_icon_waypoint_revive", &"mp_ingame_only/obj_revive" );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_ally_downed", teams::getteamdata( self.team, "players" ) );
        function_2dcf02f3028a81cd( self.var_dc7ba007e0d4288b, level.var_93532ab90ccea78c.var_db238310ba36c2eb ?? "ui_icon_waypoint_kill", &"mp_ingame_only/obj_finish" );
        enemyteam = team_utility::getotherteam( self.team );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_enemy_downed", teams::getteamdata( enemyteam, "players" ) );
        
        if ( isdefined( self.laststandattacker ) && self != self.laststandattacker )
        {
            self.laststandattacker points::doscoreevent( #"hvt_downed" );
        }
        
        weapons = self getweaponslistall();
        
        foreach ( weapon in weapons )
        {
            if ( weapon == self.laststandweaponobj )
            {
                self.var_348359045a2cf8e1 = 1;
                self.var_2980739399593e67 = self getammocount( weapon );
                self givestartammo( weapon );
                break;
            }
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x7ae57b5b, Offset: 0xb4dc
// Size: 0x135
function function_5f1287d521288a60( revived )
{
    if ( self.ishvt )
    {
        if ( revived )
        {
            if ( self.team == "allies" )
            {
                setomnvar( "allies_hvt_last_stand", 0 );
            }
            else
            {
                setomnvar( "axis_hvt_last_stand", 0 );
            }
            
            function_2dcf02f3028a81cd( self.var_dc7ba007e0d4288b, level.var_93532ab90ccea78c.var_db238310ba36c2eb ?? "ui_icon_waypoint_kill", &"MP_INGAME_ONLY/OBJ_KILL_CAPS" );
            function_2dcf02f3028a81cd( self.var_ccac6e52f3f5480d, level.var_93532ab90ccea78c.var_1c6567a83c4a9ee3 ?? "ui_icon_waypoint_defend", &"mp_ingame_only/obj_protect" );
            
            if ( isdefined( self.var_60ba802d319828fc ) && self.var_60ba802d319828fc != self )
            {
                self.var_60ba802d319828fc points::doscoreevent( #"hvt_revive" );
            }
            
            level thread hud_util::teamplayercardsplash( "callout_hvt_revived", self );
            
            if ( self.var_348359045a2cf8e1 )
            {
                self setweaponammoclip( self.laststandweaponobj, self.var_2980739399593e67 );
            }
            
            self.var_348359045a2cf8e1 = undefined;
            self.var_2980739399593e67 = undefined;
        }
    }
    
    self.var_60ba802d319828fc = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0xf2ea5196, Offset: 0xb619
// Size: 0x20
function hvt_onplayerrevived( params )
{
    self.var_60ba802d319828fc = params.reviver;
}

// Namespace multi_mode
// Params 1
// Checksum 0x9d3f4aeb, Offset: 0xb641
// Size: 0x35d
function hvt_onplayerkilled( deathdata )
{
    victim = deathdata.victim;
    einflictor = deathdata.inflictor;
    attacker = deathdata.attacker;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    iskillstreakweapon = deathdata.iskillstreakweapon;
    issuicide = victim damage::issuicide( einflictor, attacker, smeansofdeath, objweapon );
    
    if ( issuicide )
    {
        victim.var_5991cf32f0bd6cb7 = 1;
    }
    
    if ( victim.ishvt )
    {
        victim function_207f761cdacf48fc( attacker, iskillstreakweapon );
    }
    else if ( attacker.ishvt )
    {
        attacker points::doscoreevent( #"hvt_kill_as" );
        
        if ( attacker.killcountthislife == 5 )
        {
            attacker thread points::doscoreevent( #"hash_ddb446a223d7d8c7" );
        }
        
        teamscore = iskillstreakweapon ? 1 : level.var_e506992a750491f9;
        gamescore::giveteamscoreforobjective( attacker.team, teamscore );
        totalpoints = attacker getclientomnvar( "ui_hvt_earned_points" ) + teamscore;
        attacker setclientomnvar( "ui_hvt_earned_points", totalpoints );
        
        if ( isdefined( victim.attackers ) )
        {
            foreach ( player in victim.attackers )
            {
                if ( player == attacker || player == victim )
                {
                    continue;
                }
                
                player points::doscoreevent( #"hvt_kill_assist" );
            }
        }
    }
    else if ( !issuicide )
    {
        gamescore::giveteamscoreforobjective( attacker.team, level.var_6b0d628a979facca );
        
        foreach ( player in teams::getteamdata( attacker.team, "players" ) )
        {
            if ( !player.ishvt )
            {
                continue;
            }
            
            if ( utility::function_92fc197c20834b39( player, attacker.origin, 394 ) )
            {
                attacker thread points::doscoreevent( #"hash_6024b517dee12974" );
                attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + 1, "hvtDefends" );
            }
        }
    }
    
    if ( !( attacker.ishvt || issuicide ) && victim.var_ce5d6ed925aee099 && function_bfd3c43831d2874f( attacker.team ) > 0 )
    {
        victim.var_ce5d6ed925aee099 = undefined;
        attacker thread points::doscoreevent( #"saved_hvt" );
    }
}

// Namespace multi_mode
// Params 2
// Checksum 0x23019db6, Offset: 0xb9a6
// Size: 0x334
function function_207f761cdacf48fc( attacker, iskillstreakweapon )
{
    enemyteam = team_utility::getotherteam( self.team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_ally_killed", teams::getteamdata( self.team, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hvt_enemy_killed", teams::getteamdata( enemyteam, "players" ) );
    excludelist = [ self ];
    dialog::statusdialog( "hvt_friendly_eliminated", self.team, undefined, excludelist );
    dialog::statusdialog( "hvt_enemy_eliminated", enemyteam );
    
    if ( isdefined( attacker.team ) && self.team != attacker.team )
    {
        if ( isdefined( self.attackers ) )
        {
            foreach ( player in self.attackers )
            {
                if ( !isdefined( player ) || player == attacker || player == self )
                {
                    continue;
                }
                
                player thread points::doscoreevent( #"hash_fd3eb0cb2e45667e" );
            }
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "hvtKills" ] ) )
            {
                attacker.leaderboarddata[ "hvtKills" ] = attacker.leaderboarddata[ "hvtKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "hvtKills" ] ) )
            {
                [[ level.leaderboardfunc[ "hvtKills" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x378>" );
            
            if ( isdefined( attacker.pers[ "hvtKills" ] ) )
            {
                attacker.pers[ "hvtKills" ] = attacker.pers[ "hvtKills" ] + 1;
            }
        }
        
        attacker stats::setextrascore0( attacker.pers[ "extrascore0" ] + 1, "hvtKills" );
        attacker hud_message::showsplash( level.var_93532ab90ccea78c.var_6d5b2e9e3781bf3, level.var_fa25523c165c6de0 );
    }
    
    if ( self === attacker && player::isinlaststand( self ) )
    {
        if ( isdefined( self.laststandattacker ) )
        {
            self.laststandattacker thread points::doscoreevent( #"hvt_kill" );
        }
    }
    
    teamscore = iskillstreakweapon ? 1 : level.var_fa25523c165c6de0;
    gamescore::giveteamscoreforobjective( enemyteam, teamscore );
    totalpoints = attacker getclientomnvar( "ui_hvt_earned_points" ) + teamscore;
    attacker setclientomnvar( "ui_hvt_earned_points", totalpoints );
    function_83a199622d8bc604();
    self.var_5991cf32f0bd6cb7 = 1;
}

// Namespace multi_mode
// Params 1
// Checksum 0x8ca62187, Offset: 0xbce2
// Size: 0x60
function function_23a9691d4e03da50( deathdata )
{
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    
    if ( victim.ishvt && victim != attacker )
    {
        attacker thread points::doscoreevent( #"hvt_kill" );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x244858cd, Offset: 0xbd4a
// Size: 0x43, Type: bool
function function_c9cc5b4a072e9bb3( deathdata )
{
    if ( deathdata.victim.ishvt )
    {
        deathdata.attacker thread points::doscoreevent( #"killed_hvt" );
        return true;
    }
    
    return false;
}

// Namespace multi_mode
// Params 1
// Checksum 0xc06ca7d5, Offset: 0xbd96
// Size: 0x179
function function_83a199622d8bc604( fromdisconnect )
{
    self.ishvt = undefined;
    self.var_c6a41477353707f = undefined;
    self.var_49bb2b528c3f7586 = undefined;
    self.var_21e7571d4fe2e903 = undefined;
    self.var_d102765dfd91dd8d = undefined;
    self.var_348359045a2cf8e1 = undefined;
    self.var_2980739399593e67 = undefined;
    self.laststandrevivehealth = undefined;
    self.var_b541f8c69a34639d = undefined;
    playerhealth::function_b1fb4d148779580e( #"hash_9a03d6e363373f" );
    
    if ( isdefined( self.var_ccac6e52f3f5480d ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_ccac6e52f3f5480d );
        objidpoolmanager::returnobjectiveid( self.var_dc7ba007e0d4288b );
        self.var_ccac6e52f3f5480d = undefined;
        self.var_dc7ba007e0d4288b = undefined;
    }
    
    self setclientomnvar( "ui_hvt_status", 0 );
    self setclientomnvar( "ui_hvt_earned_points", 0 );
    outline::outlinedisable( self.var_8a0e38e7ec9bd2ed, self );
    outline::outlinedisable( self.var_f34ebb16ba1294a2, self );
    self.var_8a0e38e7ec9bd2ed = undefined;
    self.var_f34ebb16ba1294a2 = undefined;
    
    if ( !fromdisconnect )
    {
        outline::_hudoutlineviewmodeldisable();
    }
    
    self.skipuavupdate = undefined;
    
    if ( !level.minimaponbydefault )
    {
        player::hideminimap();
    }
    
    if ( level.var_f0ff8e3c752b9d2a.ref == #"hvt" )
    {
        level thread function_d1e67b8e0112168( self.team );
        level thread function_e998a1de5a53c2ec( self.team );
        function_8a34bb22192b77b();
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x35be1e60, Offset: 0xbf17
// Size: 0x61
function function_8a34bb22192b77b()
{
    setomnvar( "ui_" + self.team + "_hvt_count", function_bfd3c43831d2874f( self.team ) );
    enemyteam = team_utility::getotherteam( self.team );
    setomnvar( "ui_" + enemyteam + "_hvt_count", function_bfd3c43831d2874f( enemyteam ) );
}

// Namespace multi_mode
// Params 1
// Checksum 0x626428a, Offset: 0xbf80
// Size: 0x22
function function_d1e67b8e0112168( str_team )
{
    waitframe();
    setomnvar( "ui_" + str_team + "_current_hvt", -1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0xfb84e8fc, Offset: 0xbfaa
// Size: 0x61
function function_3489139a432aba22()
{
    outline::_hudoutlineviewmodelenable( "outlinefill_friendly_hvt", 0 );
    self.var_8a0e38e7ec9bd2ed = outline::outlineenableforteam( self, self.team, "outlinefill_friendly_hvt", "level_script", undefined, 1 );
    self.var_f34ebb16ba1294a2 = outline::outlineenableforteam( self, team_utility::getotherteam( self.team ), "outlinefill_enemy_hvt", "level_script", undefined, 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x4169bdef, Offset: 0xc013
// Size: 0x1b3
function function_72f191f5abbdeffe()
{
    self.curorigin = self.origin;
    self.var_d102765dfd91dd8d = ( 0, 0, 14 );
    self.var_ccac6e52f3f5480d = objidpoolmanager::requestobjectiveid( 1 );
    function_b693faf3d3abb1a3( self.var_ccac6e52f3f5480d, &"mp_ingame_only/obj_protect", level.var_93532ab90ccea78c.var_1c6567a83c4a9ee3 ?? "ui_icon_waypoint_defend" );
    objective_removeallfrommask( self.var_ccac6e52f3f5480d );
    
    foreach ( p in teams::getteamdata( self.team, "players" ) )
    {
        if ( p != self )
        {
            objective_addclienttomask( self.var_ccac6e52f3f5480d, p );
        }
    }
    
    objective_showtoplayersinmask( self.var_ccac6e52f3f5480d );
    self.var_dc7ba007e0d4288b = objidpoolmanager::requestobjectiveid( 1 );
    function_b693faf3d3abb1a3( self.var_dc7ba007e0d4288b, &"MP_INGAME_ONLY/OBJ_KILL_CAPS", level.var_93532ab90ccea78c.var_db238310ba36c2eb ?? "ui_icon_waypoint_kill" );
    objidpoolmanager::objective_teammask_single( self.var_dc7ba007e0d4288b, team_utility::getotherteam( self.team ) );
    
    if ( self.team == "allies" )
    {
        setomnvar( "allies_hvt_last_stand", 0 );
    }
    else
    {
        setomnvar( "axis_hvt_last_stand", 0 );
    }
    
    thread function_1e43c77d85968732();
}

// Namespace multi_mode
// Params 3
// Checksum 0x757ced2, Offset: 0xc1ce
// Size: 0x2e
function function_2dcf02f3028a81cd( objid, objicon, objlabel )
{
    objective_icon( objid, objicon );
    objective_setlabel( objid, objlabel );
}

// Namespace multi_mode
// Params 3
// Checksum 0xa70e780a, Offset: 0xc204
// Size: 0x74
function function_b693faf3d3abb1a3( objid, objlabel, objicon )
{
    objective_setbackground( objid, 0 );
    objective_setzoffset( objid, 30 );
    objective_position( objid, self geteye() + self.var_d102765dfd91dd8d );
    objective_state( objid, "current" );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, self.team );
    function_2dcf02f3028a81cd( objid, objicon, objlabel );
}

// Namespace multi_mode
// Params 0
// Checksum 0x61124818, Offset: 0xc280
// Size: 0xe5
function function_1e43c77d85968732()
{
    self notify( #"hash_e721f7f93b3ff8cf" );
    self endon( #"hash_e721f7f93b3ff8cf" );
    level endon( #"game_ended" );
    level endon( #"hash_56dbbc54f182022" );
    self endon( #"disconnect" );
    previousupdatetime = gettime();
    
    while ( isdefined( self.var_ccac6e52f3f5480d ) )
    {
        if ( !utility::isusingremote() )
        {
            objpos = self geteye() + self.var_d102765dfd91dd8d;
            objidpoolmanager::update_objective_position( self.var_ccac6e52f3f5480d, objpos );
            objective_ping( self.var_ccac6e52f3f5480d );
            currtime = gettime();
            
            if ( currtime - previousupdatetime >= level.var_74d4a56ce1288d31 )
            {
                objidpoolmanager::update_objective_position( self.var_dc7ba007e0d4288b, objpos );
                objective_ping( self.var_dc7ba007e0d4288b );
                previousupdatetime = currtime;
            }
        }
        
        waitframe();
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x36a5a6b6, Offset: 0xc36d
// Size: 0x101
function function_c65474efbc7592cf()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( self.ishvt )
    {
        level waittill( #"uav_update" );
        
        if ( uav::function_c6b46bde3b7bc0a1( self.team ) > getuavstrengthmin() )
        {
            self.skipuavupdate = 1;
            self.radarstrength = getuavstrengthlevelneutral() + 1;
            self.isradarblocked = 0;
            self.hasradar = 1;
            self.radarshowenemydirection = 1;
            self.radarmode = "constant_radar";
            var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
            
            if ( isdefined( var_ec86cf09b79859c3 ) )
            {
                level [[ var_ec86cf09b79859c3 ]]( [ self ] );
            }
            
            continue;
        }
        
        self.skipuavupdate = 0;
        radardata = uav::function_ce7678b7924e8588( self.team );
        uav::function_1d490f49c4dc99a9( self, radardata );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x8849a9dc, Offset: 0xc476
// Size: 0xe3
function function_673dd20e512e72c1()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    flags::gameflagwait( "prematch_done" );
    var_85558467df05afa8 = 5;
    self.var_49bb2b528c3f7586 = 0;
    var_9649ff786cade20d = 60;
    self.var_21e7571d4fe2e903 = 0;
    
    while ( self.ishvt )
    {
        if ( self.var_21e7571d4fe2e903 == var_9649ff786cade20d )
        {
            thread points::doscoreevent( #"hvt_survival" );
        }
        
        self.var_21e7571d4fe2e903++;
        
        if ( self.var_49bb2b528c3f7586 >= var_85558467df05afa8 )
        {
            self.var_49bb2b528c3f7586 = 0;
            points::doscoreevent( #"hvt_survival_bonus" );
        }
        else
        {
            self.var_49bb2b528c3f7586++;
        }
        
        stats::setextrascore1( self.pers[ "extrascore1" ] + 1, "hvtSurvives" );
        wait 1;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x50a5e486, Offset: 0xc561
// Size: 0x17
function function_d3dd530286c09da1()
{
    waitframe();
    
    if ( self.ishvt )
    {
        function_83a199622d8bc604( 0 );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xa88de8c2, Offset: 0xc580
// Size: 0x267
function function_9a9c4d32e60542d5()
{
    level.var_9f2a0d434853bf59 = undefined;
    level.var_74d4a56ce1288d31 = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.ishvt )
        {
            if ( player.inlaststand )
            {
                inflictor = player;
                
                if ( isdefined( player.laststandattacker ) )
                {
                    inflictor = player.laststandattacker;
                }
                else if ( isdefined( player.laststanddowneddata ) && isdefined( player.laststanddowneddata.attacker ) )
                {
                    inflictor = self.laststanddowneddata.attacker;
                }
                
                player dodamage( player.health + 1000, player.origin, player, inflictor, "MOD_TRIGGER_HURT", makeweapon( level.laststandweapon ), "none" );
            }
            
            player thread function_d3dd530286c09da1();
        }
        
        player perk::removeperk( "specialty_pistoldeath" );
        player.var_ce5d6ed925aee099 = undefined;
        player.var_5991cf32f0bd6cb7 = undefined;
        player.var_60ba802d319828fc = undefined;
        radardata = uav::function_ce7678b7924e8588( player.team );
        uav::function_1d490f49c4dc99a9( player, radardata );
    }
    
    if ( level.var_d74199afbc210abb )
    {
        level.var_24f4a122f2063403 = undefined;
        level.var_fa25523c165c6de0 = undefined;
        level.var_e506992a750491f9 = undefined;
        level.var_6b0d628a979facca = undefined;
    }
    
    callback::remove( #"hash_5e4c0033a7bbd7f", &function_23a9691d4e03da50 );
    level.var_c4a835bb7120c6a0 = undefined;
    callback::remove( #"player_laststand_revived", &hvt_onplayerrevived );
    level.modelaststandallowed = undefined;
    level.modeonlaststandfunc = undefined;
    level.modeonexitlaststandfunc = undefined;
    level.laststand = getmatchrulesdata( "commonOption", "lastStand" );
    setomnvar( "ui_last_stand_type", level.laststand );
    callback::remove( #"hash_6a8a551945faab9", &function_57ef7286779a9a4c );
}

// Namespace multi_mode
// Params 1
// Checksum 0x4d7f5125, Offset: 0xc7ef
// Size: 0x3a
function dhealth_init( index )
{
    if ( !isdefined( game[ "round_status_effects" ][ index ].tunable ) )
    {
        game[ "round_status_effects" ][ index ].tunable = 2;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x7553304, Offset: 0xc831
// Size: 0xcd
function function_217f469fbc4dec9b()
{
    level.var_eb54c3667a8a6653 = int( ( getmatchrulesdata( "commonOption", "maxHealth" ) ?? 100 ) * level.var_b189962d15b4781[ #"double_health" ].tunable );
    
    foreach ( player in level.players )
    {
        player function_2baf0e86b7c41fc9( level.var_eb54c3667a8a6653, 0 );
        playerhealth::forcehealthregen( player, 0 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x629bb27c, Offset: 0xc906
// Size: 0x1e
function function_4cac371821462adb( spawndata )
{
    function_2baf0e86b7c41fc9( level.var_eb54c3667a8a6653, 1 );
}

// Namespace multi_mode
// Params 2
// Checksum 0x4b799e9e, Offset: 0xc92c
// Size: 0x4a
function function_2baf0e86b7c41fc9( maxhealth, var_8d6017cd69685ec9 )
{
    if ( self.health >= maxhealth )
    {
        self.health = maxhealth;
    }
    
    self.maxhealth = maxhealth;
    
    if ( var_8d6017cd69685ec9 )
    {
        self.health = maxhealth;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x2238f53, Offset: 0xc97e
// Size: 0xa7
function function_6ff935b37ea192fe()
{
    maxhealth = int( getmatchrulesdata( "commonOption", "maxHealth" ) ) ?? 100;
    level.var_eb54c3667a8a6653 = undefined;
    
    foreach ( player in level.players )
    {
        function_2baf0e86b7c41fc9( maxhealth, 0 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x817a9304, Offset: 0xca2d
// Size: 0x44
function function_d882a74228bcbd85( index )
{
    setdvar( @"hash_b9e0a0a687cd9e51", 1 );
    game[ "round_status_effects" ][ index ].tunable = level.var_93532ab90ccea78c.var_a13ed56b1453e9db;
}

// Namespace multi_mode
// Params 0
// Checksum 0xdbac8640, Offset: 0xca79
// Size: 0x84
function djump_start()
{
    foreach ( player in level.players )
    {
        player allowdoublejump( 1 );
        player thread function_5ac0682529df661e();
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x2b1fcf45, Offset: 0xcb05
// Size: 0x14
function function_e0f0a0031f31955( spawndata )
{
    self allowdoublejump( 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0xd95b031b, Offset: 0xcb21
// Size: 0xce
function function_5ac0682529df661e()
{
    self notify( #"hash_3c678c2e539583" );
    self endon( #"hash_3c678c2e539583" );
    level endon( #"game_ended" );
    level endon( #"djump_end" );
    self endon( #"disconnect" );
    var_556ab02d13f6aa82 = level.var_b189962d15b4781[ #"double_jump" ].tunable;
    
    if ( !var_556ab02d13f6aa82.part || !var_556ab02d13f6aa82.state || !self getscriptablehaspart( var_556ab02d13f6aa82.part ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"doublejumpbegin" );
        self setscriptablepartstate( var_556ab02d13f6aa82.part, var_556ab02d13f6aa82.state, 0 );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x804eec93, Offset: 0xcbf7
// Size: 0x86
function djump_end()
{
    level notify( #"djump_end" );
    
    foreach ( player in level.players )
    {
        player allowdoublejump( 0 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x8e04c0db, Offset: 0xcc85
// Size: 0x3d
function gravity_init( index )
{
    if ( !isdefined( game[ "round_status_effects" ][ index ].tunable ) )
    {
        game[ "round_status_effects" ][ index ].tunable = 0.5;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x4a190002, Offset: 0xccca
// Size: 0x96
function gravity_start()
{
    foreach ( player in level.players )
    {
        player setgravityscale( level.var_b189962d15b4781[ #"hash_1be9be0c700155f0" ].tunable );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x90421ab6, Offset: 0xcd68
// Size: 0x2f
function gravity_onspawn( spawndata )
{
    self setgravityscale( level.var_b189962d15b4781[ #"hash_1be9be0c700155f0" ].tunable );
}

// Namespace multi_mode
// Params 0
// Checksum 0x55b8c481, Offset: 0xcd9f
// Size: 0x7b
function gravity_end()
{
    foreach ( player in level.players )
    {
        player setgravityscale( 1 );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x3f4116c3, Offset: 0xce22
// Size: 0x79
function function_b1919b7402ed821( index )
{
    if ( !isdefined( game[ "round_status_effects" ][ index ].tunable ) )
    {
        game[ "round_status_effects" ][ index ].tunable = 2;
    }
    
    setdvarifuninitialized( @"hash_94084550cb0f64e7", game[ "round_status_effects" ][ index ].tunable, 0.5, 4 );
    setdvar( @"hash_b7318d7f06303895", 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x21ae54d7, Offset: 0xcea3
// Size: 0x80
function function_f623eaf4de0d8a1d()
{
    foreach ( player in level.players )
    {
        player perk::giveperk( "specialty_super_speed" );
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xe632ca91, Offset: 0xcf2b
// Size: 0x18
function function_b45a2ac1a6ee8d39( spawndata )
{
    perk::giveperk( "specialty_super_speed" );
}

// Namespace multi_mode
// Params 0
// Checksum 0x838d94c0, Offset: 0xcf4b
// Size: 0x80
function function_a776fd58dcd4664()
{
    foreach ( player in level.players )
    {
        player perk::removeperk( "specialty_super_speed" );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x3965d37c, Offset: 0xcfd3
// Size: 0x9d
function function_87bcd3d0b73a0209()
{
    foreach ( player in level.players )
    {
        if ( player player::isreallyalive() )
        {
            player.var_ab1b5066b3904252 = 1;
            player thread points::doscoreevent( #"hash_c815e5534dbd74b1" );
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xc2fef0e0, Offset: 0xd078
// Size: 0x34
function function_4086451352cc13c5( spawndata )
{
    if ( !self.var_ab1b5066b3904252 )
    {
        self.var_ab1b5066b3904252 = 1;
        thread points::doscoreevent( #"hash_c815e5534dbd74b1" );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x9c27efb5, Offset: 0xd0b4
// Size: 0x7d
function function_4de44666c73d3f78()
{
    foreach ( player in level.players )
    {
        player.var_ab1b5066b3904252 = undefined;
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xca453c25, Offset: 0xd139
// Size: 0x93
function function_2d6a5781d847c50b( index )
{
    level.var_84c8b699b48ee3d1 = [ #"hash_37dc3f35fcf0564", #"hash_380a678c1259eda8", #"hash_3ada7f35ff7f992" ];
    assert( game[ "<dev string:x15f>" ][ index ].tunable > 1, "<dev string:x547>" );
    game[ "round_status_effects" ][ index ].tunable = max( game[ "round_status_effects" ][ index ].tunable, 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x5f511ca2, Offset: 0xd1d4
// Size: 0x98
function function_c8dddb178647f4b7()
{
    level.var_9a1cdda662c28b12 = level.var_cda6c691a06ec205;
    
    foreach ( player in level.players )
    {
        if ( player player::isreallyalive() )
        {
            player thread function_4196c00cffdbfdc2();
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xcefcfcd6, Offset: 0xd274
// Size: 0x13
function function_1526ca628622f27( spawndata )
{
    thread function_4196c00cffdbfdc2();
}

// Namespace multi_mode
// Params 0
// Checksum 0xf229093a, Offset: 0xd28f
// Size: 0x154
function function_4196c00cffdbfdc2()
{
    self notify( #"hash_b8cf8d1fd2970a1b" );
    self endon( #"hash_b8cf8d1fd2970a1b" );
    level endon( #"hash_62411475a8461ff4" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.var_53cd8fd8c2cd8696 ) )
    {
        self.var_53cd8fd8c2cd8696 = spawn( "script_model", self.origin );
    }
    
    while ( level.var_9a1cdda662c28b12 > gettime() + level.var_b189962d15b4781[ #"fake_sounds" ].tunable )
    {
        wait randomfloatrange( 1, level.var_b189962d15b4781[ #"fake_sounds" ].tunable );
        soundtoplay = level.var_84c8b699b48ee3d1[ randomint( level.var_84c8b699b48ee3d1.size ) ];
        gunfirex = randomfloatrange( -1000, 1000 );
        gunfirey = randomfloatrange( -1000, 1000 );
        self.var_53cd8fd8c2cd8696.origin = self.origin + ( gunfirex, gunfirey, 0 );
        gameplay_sound_fx::function_1ef72f46669e3816( soundtoplay, self.var_53cd8fd8c2cd8696 );
        wait 0.1;
        gameplay_sound_fx::function_1ef72f46669e3816( soundtoplay, self.var_53cd8fd8c2cd8696 );
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x858b7b54, Offset: 0xd3eb
// Size: 0x18
function function_19036c82e38b32b2()
{
    level notify( #"hash_62411475a8461ff4" );
    level.var_9a1cdda662c28b12 = undefined;
}

// Namespace multi_mode
// Params 1
// Checksum 0x67256606, Offset: 0xd40b
// Size: 0xd8
function function_f9d08dec51226038( index )
{
    game[ "round_status_effects" ][ index ].tunable = level.var_93532ab90ccea78c.var_177112d39fe06745;
    
    if ( !isdefined( game[ "round_status_effects" ][ index ].tunable ) )
    {
        game[ "round_status_effects" ][ index ].tunable = "cer_hallucination_gas";
    }
    
    if ( !isdefined( level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ) || !isdefined( level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ) )
    {
        assertmsg( "<dev string:x59f>" );
        game[ "round_status_effects" ][ index ].ref = #"none";
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xc428b22b, Offset: 0xd4eb
// Size: 0x96
function function_6132050de921088a()
{
    foreach ( player in level.players )
    {
        if ( player player::isreallyalive() && !player.var_29c88015f69723df )
        {
            player thread function_2e44771dc62a7066();
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x1d047dc4, Offset: 0xd589
// Size: 0x13
function function_388cc5afade184ce( spawndata )
{
    thread function_2e44771dc62a7066();
}

// Namespace multi_mode
// Params 0
// Checksum 0x6d4fa78e, Offset: 0xd5a4
// Size: 0x58
function function_2e44771dc62a7066()
{
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:level.var_b189962d15b4781[ #"fake_visuals" ].tunable }, 1, 1 );
    self.var_29c88015f69723df = 1;
}

// Namespace multi_mode
// Params 0
// Checksum 0xec27393b, Offset: 0xd604
// Size: 0x26
function function_f038d6ceaf677a3f()
{
    thread function_3b6974797163ea7f( level.var_b189962d15b4781[ #"fake_visuals" ].tunable );
}

// Namespace multi_mode
// Params 1
// Checksum 0x6dd9b522, Offset: 0xd632
// Size: 0xcf
function function_3b6974797163ea7f( var_2eeeee4a850be407 )
{
    wait 1;
    
    if ( !level.var_b189962d15b4781[ #"fake_visuals" ] )
    {
        foreach ( player in level.players )
        {
            player [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:var_2eeeee4a850be407 } );
            player.var_29c88015f69723df = undefined;
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0xa5c7507d, Offset: 0xd709
// Size: 0x3d
function function_c555eb09ded38b04( index )
{
    if ( !isdefined( game[ "round_status_effects" ][ index ].tunable ) )
    {
        game[ "round_status_effects" ][ index ].tunable = 0.5;
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0xa4202792, Offset: 0xd74e
// Size: 0x105
function function_76b23e9962a9fee()
{
    level.var_eb54c3667a8a6653 = int( ( getmatchrulesdata( "commonOption", "maxHealth" ) ?? 100 ) * level.var_b189962d15b4781[ #"hard_core" ].tunable );
    setdvar( @"cg_drawcrosshair", 0 );
    level.minimaponbydefault = 0;
    setomnvar( "ui_multi_hardcore_active", 1 );
    
    foreach ( player in level.players )
    {
        player function_2baf0e86b7c41fc9( level.var_eb54c3667a8a6653, 0 );
        
        if ( !player.ishvt )
        {
            player setclientomnvar( "ui_hide_minimap", 1 );
        }
    }
}

// Namespace multi_mode
// Params 1
// Checksum 0x380ac0e5, Offset: 0xd85b
// Size: 0x8e
function function_591738be8a245e52( spawndata )
{
    if ( !isdefined( level.var_eb54c3667a8a6653 ) )
    {
        level.var_eb54c3667a8a6653 = int( ( getmatchrulesdata( "commonOption", "maxHealth" ) ?? 100 ) * level.var_b189962d15b4781[ #"hard_core" ].tunable );
    }
    
    function_2baf0e86b7c41fc9( level.var_eb54c3667a8a6653, 1 );
    
    if ( !self.ishvt )
    {
        self setclientomnvar( "ui_hide_minimap", 1 );
    }
    
    setomnvar( "ui_multi_hardcore_active", 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x1a2e4178, Offset: 0xd8f1
// Size: 0x11a
function function_6b1f374eda750d5b()
{
    setdvar( @"cg_drawcrosshair", 1 );
    maxhealth = int( getmatchrulesdata( "commonOption", "maxHealth" ) ) ?? 100;
    setomnvar( "ui_multi_hardcore_active", 0 );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_hide_minimap", 0 );
        player function_2baf0e86b7c41fc9( maxhealth, 0 );
    }
    
    level.minimaponbydefault = ( getmatchrulesdata( "commonOption", "enableMinimap" ) != 0 || getdvarint( @"hash_bc802deb1ff2a842" ) != 0 ) && !game[ "isLaunchChunk" ] && !game_utility::function_ae97372c83da7acc();
    level.var_eb54c3667a8a6653 = undefined;
    thread function_8becebb6023bb64f();
}

// Namespace multi_mode
// Params 0
// Checksum 0x7c5828a8, Offset: 0xda13
// Size: 0x96
function function_8becebb6023bb64f()
{
    wait 1;
    
    if ( !level.var_b189962d15b4781[ #"hard_core" ] )
    {
        foreach ( player in level.players )
        {
            playerhealth::forcehealthregen( player, 0 );
        }
    }
}

// Namespace multi_mode
// Params 0
// Checksum 0x662f201c, Offset: 0xdab1
// Size: 0x12
function function_11b7cea663a29768()
{
    setdvar( @"camera_thirdperson", 1 );
}

// Namespace multi_mode
// Params 0
// Checksum 0x53e1141e, Offset: 0xdacb
// Size: 0x9
function function_cb55f513d08e31f9()
{
    thread function_9f96b255114ba093();
}

// Namespace multi_mode
// Params 0
// Checksum 0x7ebc1014, Offset: 0xdadc
// Size: 0x2b
function function_9f96b255114ba093()
{
    wait 1;
    
    if ( !level.var_b189962d15b4781[ #"third_person" ] )
    {
        setdvar( @"camera_thirdperson", 0 );
    }
}

/#

    // Namespace multi_mode
    // Params 0
    // Checksum 0x33a9e0bc, Offset: 0xdb0f
    // Size: 0xbd, Type: dev
    function function_7898c2ce8d367154()
    {
        level endon( #"game_ended" );
        lastvalue = "<dev string:x24>";
        
        while ( true )
        {
            dvarvalue = getxhash( getdvar( @"hash_f2deed849be2d299" ) );
            
            if ( dvarvalue != "<dev string:x24>" && dvarvalue != lastvalue )
            {
                level.var_74ae00acfd3ba082 = dvarvalue;
                setdvar( @"hash_f2deed849be2d299", "<dev string:x24>" );
                lastvalue = "<dev string:x24>";
                
                if ( isdefined( level.var_f0ff8e3c752b9d2a ) && level.var_f0ff8e3c752b9d2a.ref != dvarvalue )
                {
                    level notify( #"hash_b078537ed80e7487" );
                }
            }
            else
            {
                lastvalue = dvarvalue;
            }
            
            wait 0.5;
        }
    }

    // Namespace multi_mode
    // Params 0
    // Checksum 0x345bc5c7, Offset: 0xdbd4
    // Size: 0x99, Type: dev
    function function_f04c764cba81db4f()
    {
        if ( level.var_f0ff8e3c752b9d2a.ref != #"hash_cd755ac179aea3b0" )
        {
            level.var_74ae00acfd3ba082 = #"hash_cd755ac179aea3b0";
            
            if ( isdefined( level.var_f0ff8e3c752b9d2a ) && level.var_f0ff8e3c752b9d2a.ref != #"hash_cd755ac179aea3b0" )
            {
                level notify( #"hash_b078537ed80e7487" );
            }
        }
        
        wait 1;
        origin = devgui::function_97024c0a6d1256a6();
        
        if ( !isdefined( origin ) )
        {
            return;
        }
        
        function_5b6010b72d65159e( origin, 1 );
    }

#/
