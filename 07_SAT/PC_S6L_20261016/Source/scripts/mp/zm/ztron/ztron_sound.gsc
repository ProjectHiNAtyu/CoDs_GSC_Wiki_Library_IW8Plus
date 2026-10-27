// scripts\mp\zm\ztron\ztron_sound.gsc  (hash_678806a161fee2b3.gscc) (size: 8683 Bytes / 0x21eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa0c87a9b (2697493147)
// size ...... 8683 (0x21eb)
// includes .. 4   (offset: 0x1ce3)
// strings ... 60  (offset: 0x1d03)
// dev strs .. 15  (offset: 0x211f)
// exports ... 19  (offset: 0x14b7)
// cseg ...... 0x3dc + 0x10db (0x14b7)
// imports ... 39  (offset: 0x17af)
// animtree1 . 0   (offset: 0x21eb)
// animtree2 . 0   (offset: 0x21eb)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\ztron\ztron_debug;

#namespace ztron_sound;

// Namespace ztron_sound
// Params 0
// Checksum 0x17cf8781, Offset: 0x3fa
// Size: 0x10f
function init()
{
    if ( !isdefined( level.ztron.soundos ) )
    {
        level.ztron.soundos = [];
    }
    
    if ( !isdefined( level.ztron.soundlp ) )
    {
        level.ztron.soundlp = [];
    }
    
    if ( !isdefined( level.ztron.announcercooldown ) )
    {
        level.ztron.announcercooldown = 0;
    }
    
    if ( !isdefined( level.ztron.announcerdisabled ) )
    {
        level.ztron.announcerdisabled = 0;
    }
    
    /#
        level thread function_f77bc901945a7209();
    #/
    
    level.ztron.musicbankdata = [];
    function_49f2fa71bc4b774a();
    function_268bc4ee2962a3d5();
    function_5f787aae02b1766a();
    function_ec5835a87fcbfd29();
    musicbank_utility::init_musicbanks();
    level callback::add( #"player_connect", &on_player_connect );
    level thread music_bank_eventwatcher();
}

// Namespace ztron_sound
// Params 1
// Checksum 0x133ee432, Offset: 0x511
// Size: 0x7a
function on_player_connect( sparams )
{
    self endon( #"death_or_disconnect" );
    var_1ee4c3bce9c6db21 = level.gamemodebundle.var_1ee4c3bce9c6db21;
    
    if ( level.gametypebundle.var_319a3b8afacdacd5 )
    {
        var_1ee4c3bce9c6db21 = level.gametypebundle.var_1ee4c3bce9c6db21;
    }
    
    if ( !var_1ee4c3bce9c6db21 )
    {
        self setplayermusicstate( "" );
    }
    
    musicbank_utility::function_c5abc550e9f75f30();
}

// Namespace ztron_sound
// Params 3
// Checksum 0xe28c9262, Offset: 0x593
// Size: 0x125
function function_4ac735395b173fe( ref, audioalias, looping = 0 )
{
    if ( !isdefined( level.ztron.soundos ) )
    {
        level.ztron.soundos = [];
    }
    
    if ( !isdefined( level.ztron.soundlp ) )
    {
        level.ztron.soundlp = [];
    }
    
    assert( isdefined( ref ) && !isdefined( level.ztron.soundos[ ref ] ), "<dev string:x24>" );
    assert( isdefined( ref ) && !isdefined( level.ztron.soundlp[ ref ] ), "<dev string:x24>" );
    
    if ( looping )
    {
        level.ztron.soundlp[ ref ] = audioalias;
    }
    else
    {
        level.ztron.soundos[ ref ] = audioalias;
    }
    
    if ( !soundexists( audioalias ) )
    {
        ztron_debug::debugmsg( "WARNING - AUDIO ALIAS IS INVALID: " + audioalias );
    }
}

// Namespace ztron_sound
// Params 1
// Checksum 0x6be6fddf, Offset: 0x6c0
// Size: 0x20
function ztron_stopsound( ent )
{
    if ( isdefined( ent ) )
    {
        ent stopsounds();
        ent stoploopsound();
    }
}

// Namespace ztron_sound
// Params 3
// Checksum 0xf771bd7d, Offset: 0x6e8
// Size: 0x18f
function ztron_playsound( ref, origin, ent )
{
    assert( isdefined( ref ) && ( isdefined( level.ztron.soundos[ ref ] ) || isdefined( level.ztron.soundlp[ ref ] ) ), "<dev string:x4a>" );
    
    if ( isdefined( level.ztron.soundlp[ ref ] ) )
    {
        assert( isdefined( ent ), "<dev string:x5f>" );
        ent playloopsound( level.ztron.soundlp[ ref ] );
        return;
    }
    
    if ( isdefined( origin ) )
    {
        playsoundatpos( origin, level.ztron.soundos[ ref ] );
        return;
    }
    
    if ( isdefined( ent ) && ent != level )
    {
        ent playsoundonmovingent( level.ztron.soundos[ ref ] );
        return;
    }
    
    foreach ( player in level.players )
    {
        player playsound( level.ztron.soundos[ ref ] );
    }
}

// Namespace ztron_sound
// Params 2
// Checksum 0x872c4f90, Offset: 0x87f
// Size: 0x62
function ztron_stoploopsound( ref, ent )
{
    if ( isdefined( ent ) )
    {
        if ( isdefined( level.ztron.soundlp[ ref ] ) )
        {
            assert( isdefined( ent ), "<dev string:x8a>" );
            ent stoploopsound( level.ztron.soundlp[ ref ] );
        }
    }
}

// Namespace ztron_sound
// Params 2
// Checksum 0xc9ae4633, Offset: 0x8e9
// Size: 0xb4
function function_45ef7960d35e541d( ref, force = 0 )
{
    if ( level.ztron.announcerdisabled )
    {
        return;
    }
    
    time = gettime();
    
    if ( !force && level.ztron.announcercooldown > time )
    {
        return;
    }
    
    assert( isdefined( ref ) && isdefined( level.ztron.soundos[ ref ] ), "<dev string:x4a>" );
    level.ztron.announcercooldown = time + 15000;
    ztron_playsound( ref, undefined, level );
}

// Namespace ztron_sound
// Params 3
// Checksum 0x3dff5d07, Offset: 0x9a5
// Size: 0x4e
function function_ac1e49175da7897d( eventtype, eventid, param )
{
    assert( isdefined( eventtype ), "<dev string:x9b>" );
    assert( isdefined( eventid ), "<dev string:xad>" );
    level notify( #"music_bank_event", eventtype, eventid, param );
}

// Namespace ztron_sound
// Params 3
// Checksum 0x18ea30d1, Offset: 0x9fb
// Size: 0xe2
function function_dc9e7adb7077bfd6( eventtype, eventid, targetname = "undefined" )
{
    if ( isdefined( level.ztron.musicbankdata[ eventtype ][ targetname ] ) )
    {
        foreach ( data in level.ztron.musicbankdata[ eventtype ][ targetname ] )
        {
            if ( data.eventid == eventid )
            {
                return data.musictrack;
            }
        }
    }
}

// Namespace ztron_sound
// Params 5
// Checksum 0x2d413139, Offset: 0xae6
// Size: 0x12b
function function_92598fccecb552c7( eventtype, eventid, targetname = "undefined", musictrack, clearstate )
{
    if ( !isdefined( level.ztron.musicbankdata[ eventtype ] ) )
    {
        level.ztron.musicbankdata[ eventtype ] = [];
    }
    
    if ( !isdefined( level.ztron.musicbankdata[ eventtype ][ targetname ] ) )
    {
        level.ztron.musicbankdata[ eventtype ][ targetname ] = [];
    }
    
    data = spawnstruct();
    data.eventtype = eventtype;
    data.eventid = eventid;
    data.targetname = targetname;
    data.musictrack = musictrack;
    data.clearstate = 0;
    level.ztron.musicbankdata[ eventtype ][ targetname ][ level.ztron.musicbankdata[ eventtype ][ targetname ].size ] = data;
}

// Namespace ztron_sound
// Params 0
// Checksum 0x7ff51bde, Offset: 0xc19
// Size: 0x26e
function function_49f2fa71bc4b774a()
{
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "island", #"arena_island" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "babylon", #"arena_babylon" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "firebase", #"arena_firebase" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "graveyard", #"arena_graveyard" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "ritual", #"arena_ritual" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "lava_cave", #"hash_48cfddc4b8f93ef6" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "fort_courtyard", #"arena_fort" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "church", #"arena_church" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "sculpture", #"arena_sculpture" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "dry_garden", #"arena_garden" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "town_square", #"hash_ad560dc43a75a56" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "estate_courtyard", #"arena_estate" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "motel", #"arena_motel" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "museum", #"arena_museum" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "nuketown", #"arena_nuketown" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "homestead", #"peeks_2" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "melting", #"peeks_5" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "aethereal_swamp", #"peeks_3" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "aethereal_jungle", #"peeks_4" );
    function_92598fccecb552c7( "arenaEvent", "arenaActivated", "silverback_arena", #"boss_battle" );
}

// Namespace ztron_sound
// Params 0
// Checksum 0xaf64cbab, Offset: 0xe8f
// Size: 0x5f
function function_268bc4ee2962a3d5()
{
    function_92598fccecb552c7( "slayerEvent", "slayerActivated", "prototype", #"slayer" );
    function_92598fccecb552c7( "slayerEvent", "slayerActivated", "beta", #"slayer" );
    function_92598fccecb552c7( "slayerEvent", "slayerActivated", "gamma", #"slayer" );
}

// Namespace ztron_sound
// Params 0
// Checksum 0x7bbf5ec4, Offset: 0xef6
// Size: 0x230
function function_5f787aae02b1766a()
{
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "duck_farm", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "armory", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "fate", #"fate_climb" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "shadow_vault", #"cats_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "racing2", #"race_time" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "plunder", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "hangar", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "side_scroller1", #"cats_1" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "boom_room", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "fall_100", #"cats_2" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "rail_shooter", #"cats_4" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "power_room", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "side_scroller3", #"cats_2" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "side_scroller2", #"cats_3" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "racing", #"race_time" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "treasure", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "nuke_vault", #"peeks_multi" );
    function_92598fccecb552c7( "bonusRoomEvent", "bonusRoomActivated", "eggxit", #"cats_multi" );
}

// Namespace ztron_sound
// Params 0
// Checksum 0x34fd6cc7, Offset: 0x112e
// Size: 0x89
function function_ec5835a87fcbfd29()
{
    function_92598fccecb552c7( "gameEvent", "roomOfFate", undefined, #"bonus_room" );
    function_92598fccecb552c7( "gameEvent", "papabackInGameScene", undefined, #"hash_4ce4fc303541397a" );
    function_92598fccecb552c7( "gameEvent", "podiumScene", undefined, #"podium" );
    function_92598fccecb552c7( "gameEvent", "gameOver", undefined, #"gameover" );
    function_92598fccecb552c7( "gameEvent", "cabinet_attract", undefined, #"cabinet_attract" );
}

// Namespace ztron_sound
// Params 0
// Checksum 0x40892538, Offset: 0x11bf
// Size: 0x9e
function music_bank_eventwatcher()
{
    while ( true )
    {
        level waittill( #"music_bank_event", eventtype, eventid, param );
        musictrack = function_dc9e7adb7077bfd6( eventtype, eventid, param );
        ztron_debug::debugmsg( "Received music_bank_event of type: " + eventtype + " and eventID: " + eventid + ".  Param is set to: " + ( param ?? "undefined" ) + "  Track returned is: " + ( musictrack ?? "undefined" ) );
        
        if ( isdefined( musictrack ) )
        {
            level thread musicbank_utility::function_5aca66c390aa347d( level.players, musictrack );
        }
    }
}

/#

    // Namespace ztron_sound
    // Params 0
    // Checksum 0x9ff3e156, Offset: 0x1265
    // Size: 0x1a0, Type: dev
    function function_f77bc901945a7209()
    {
        level waittill( #"ztron_game_initialized" );
        devgui::function_9082edeb5db93280( "<dev string:xbd>" );
        devgui::add_devgui_func( "<dev string:xca>", "<dev string:xda>", &function_8148b87549bbf785 );
        effectname = "<dev string:xf0>";
        devgui::function_cd4e263c1f3018ae( "<dev string:xfa>" + effectname, "<dev string:x106>" + effectname, &debug_play_sfx );
        keys = getarraykeys( level.ztron.soundos );
        
        foreach ( key in keys )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:xfa>" + key, "<dev string:x106>" + key, &debug_play_sfx );
        }
        
        keys = getarraykeys( level.ztron.soundlp );
        
        foreach ( key in keys )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x116>" + key, "<dev string:x106>" + key, &debug_play_sfx );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_sound
    // Params 1
    // Checksum 0x2bc0a6b7, Offset: 0x140d
    // Size: 0x4b, Type: dev
    function debug_play_sfx( params )
    {
        player = level.players[ 0 ];
        effectname = params[ 0 ];
        
        if ( effectname != "<dev string:xf0>" )
        {
            level ztron_playsound( effectname, undefined, player );
        }
    }

    // Namespace ztron_sound
    // Params 0
    // Checksum 0xb61e6cdc, Offset: 0x1460
    // Size: 0x57, Type: dev
    function function_8148b87549bbf785()
    {
        musictrack = function_dc9e7adb7077bfd6( "<dev string:x127>", "<dev string:x132>", level.ztron.active_arena.name );
        
        if ( isdefined( musictrack ) )
        {
            level thread musicbank_utility::function_4f253fd35ec68cbc( level.players, musictrack );
        }
    }

#/
