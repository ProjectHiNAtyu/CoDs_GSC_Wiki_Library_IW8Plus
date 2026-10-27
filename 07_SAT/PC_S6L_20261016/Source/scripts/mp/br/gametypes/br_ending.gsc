// scripts\mp\br\gametypes\br_ending.gsc  (hash_0d635bcdc5850bf7.gscc) (size: 24378 Bytes / 0x5f3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb4d98297 (3034153623)
// size ...... 24378 (0x5f3a)
// includes .. 30  (offset: 0x5a9e)
// strings ... 60  (offset: 0x5b8e)
// dev strs .. 8   (offset: 0x5eda)
// exports ... 47  (offset: 0x3d82)
// cseg ...... 0x65a + 0x3728 (0x3d82)
// imports ... 174 (offset: 0x44da)
// animtree1 . 0   (offset: 0x5f3a)
// animtree2 . 0   (offset: 0x5f3a)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\notetrack;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_accolades;
#using scripts\mp\br\gametypes\br_ending_chopper;
#using scripts\mp\br\gametypes\br_ending_chopper2;
#using scripts\mp\br\gametypes\br_ending_chopper_to_hq;
#using scripts\mp\br\gametypes\br_ending_cq;
#using scripts\mp\br\gametypes\br_ending_debug;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\manual_turret;
#using scripts\mp\common\killstreaks\remoteuav;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\execution;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\playerlogic;

#namespace br_ending;

// Namespace br_ending
// Params 0, eflags: 0x5
// Checksum 0x73a79ee8, Offset: 0x678
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"br_ending", undefined, &pre_main, &post_main );
}

// Namespace br_ending
// Params 0
// Checksum 0x400579af, Offset: 0x69d
// Size: 0x15
function pre_main()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    level.br_endings = [];
}

// Namespace br_ending
// Params 2
// Checksum 0x83ad5522, Offset: 0x6ba
// Size: 0x54
function register_exfil( name, exfilstruct )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    assert( isdefined( level.br_endings ) );
    assert( !isdefined( level.br_endings[ name ] ) );
    level.br_endings[ name ] = exfilstruct;
}

// Namespace br_ending
// Params 1, eflags: 0x4
// Checksum 0x1b7b41d4, Offset: 0x716
// Size: 0x4c
function private get_init_func( name )
{
    var_f3903e28d3877359 = level.br_endings[ name ];
    
    if ( isdefined( var_f3903e28d3877359 ) )
    {
        return [ var_f3903e28d3877359.initfunc, var_f3903e28d3877359 ];
    }
    
    return [ undefined, undefined ];
}

// Namespace br_ending
// Params 1, eflags: 0x4
// Checksum 0x6c190513, Offset: 0x76b
// Size: 0x33
function private get_play_func( name )
{
    if ( isdefined( level.br_endings[ name ] ) )
    {
        return level.br_endings[ name ].playfunc;
    }
}

// Namespace br_ending
// Params 1, eflags: 0x4
// Checksum 0x18a2a652, Offset: 0x7a7
// Size: 0x33
function private get_pack_func( name )
{
    if ( isdefined( level.br_endings[ name ] ) )
    {
        return level.br_endings[ name ].packfunc;
    }
}

// Namespace br_ending
// Params 1
// Checksum 0x905b170e, Offset: 0x7e3
// Size: 0x33
function function_bcd77f3717230834( name )
{
    if ( isdefined( level.br_endings[ name ] ) )
    {
        return level.br_endings[ name ].var_e63a9d5ec4b488a0;
    }
}

// Namespace br_ending
// Params 1
// Checksum 0xf12bc79e, Offset: 0x81f
// Size: 0x33
function get_transient_func( name )
{
    if ( isdefined( level.br_endings[ name ] ) )
    {
        return level.br_endings[ name ].transientfunc;
    }
}

// Namespace br_ending
// Params 0
// Checksum 0xccdae13a, Offset: 0x85b
// Size: 0x35
function get_exfil_bundle()
{
    name = get_exfil_type();
    var_f3903e28d3877359 = level.br_endings[ name ];
    return var_f3903e28d3877359.bundle;
}

// Namespace br_ending
// Params 0
// Checksum 0x126bc13a, Offset: 0x899
// Size: 0x35
function get_exfil_bundle_name()
{
    name = get_exfil_type();
    var_f3903e28d3877359 = level.br_endings[ name ];
    return var_f3903e28d3877359.bundlename;
}

// Namespace br_ending
// Params 2
// Checksum 0x4487308d, Offset: 0x8d7
// Size: 0x72
function set_exfil_bundle( name, bundlename )
{
    var_f3903e28d3877359 = level.br_endings[ name ];
    assert( isdefined( var_f3903e28d3877359 ) );
    
    if ( isdefined( var_f3903e28d3877359 ) )
    {
        var_f3903e28d3877359.bundlename = bundlename;
        var_f3903e28d3877359.bundle = getscriptbundle( bundlename );
        assert( isdefined( var_f3903e28d3877359.bundle ) );
    }
}

// Namespace br_ending
// Params 0
// Checksum 0x6d5296e9, Offset: 0x951
// Size: 0x12
function post_main()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    br_ending_init();
}

// Namespace br_ending
// Params 0
// Checksum 0x3c5c8558, Offset: 0x96b
// Size: 0x1dd
function br_ending_init()
{
    if ( !level.gametypebundle.var_e27eb9a08d81a38d || getdvarint( @"hash_3939d9bfb2b1103e", 0 ) )
    {
        if ( isdefined( level.brwinnerscircle ) )
        {
            br_accolades::accolades_init();
        }
        
        return;
    }
    
    setdvarifuninitialized( @"scr_br_ending_enabled", 1 );
    
    /#
        setdvarifuninitialized( @"hash_dd3266b5409a856b", 0 );
        setdvarifuninitialized( @"scr_br_ending_placement", 0 );
        setdvarifuninitialized( @"hash_2d200a3da7fb2518", 0 );
        setdvarifuninitialized( @"scr_br_ending_testclients", 0 );
        setdvarifuninitialized( @"scr_br_ending_play", 0 );
        
        for ( i = 0; i < 6 ; i++ )
        {
            setdvarifuninitialized( hashcat( @"hash_e340a5ee5afde790", string( i ) ), "<dev string:x24>" );
        }
    #/
    
    level.var_e0308e22e5b02b6c = undefined;
    exfiltype = get_exfil_type();
    [ initfunc, var_f3903e28d3877359 ] = get_init_func( exfiltype );
    
    if ( isdefined( initfunc ) )
    {
        var_f3903e28d3877359 [[ initfunc ]]();
    }
    else
    {
        switch ( exfiltype )
        {
            case #"hash_d9cfbe7fb5447f0e":
                br_accolades::accolades_init();
                br_ending_chopper2::chopperexfil_init();
                break;
            case #"hash_18208461fac4f35e":
            case #"hash_ce37a6540166b6f7":
                br_accolades::accolades_init();
                br_ending_chopper_to_hq::chopperhqexfil_init();
                break;
            case #"hash_1136bc3322c0a548":
            default:
                br_accolades::accolades_init();
                br_ending_chopper::chopperexfil_init();
                break;
        }
    }
    
    if ( isdefined( level.brwinnerscircle ) && !isdefined( level.var_3abb05bb58a5e16e ) )
    {
        br_accolades::accolades_init();
    }
    
    thread init_ending_structs( exfiltype );
    
    /#
        level thread br_ending_debug::debug_exfil();
    #/
}

// Namespace br_ending
// Params 1
// Checksum 0xe7a5d8b8, Offset: 0xb50
// Size: 0x40
function function_15b39b5fac9cbb1c( player )
{
    if ( isdefined( level.var_1b8c0b90b91e0b3 ) )
    {
        player visionsetnakedforplayer( level.var_1b8c0b90b91e0b3, 0 );
        return;
    }
    
    player visionsetnakedforplayer( "", 0 );
}

// Namespace br_ending
// Params 0
// Checksum 0x1987f300, Offset: 0xb98
// Size: 0x3e, Type: bool
function can_play_ending()
{
    if ( !getdvarint( @"scr_br_ending_enabled" ) )
    {
        return false;
    }
    
    if ( !level.gametypebundle.var_e27eb9a08d81a38d )
    {
        return false;
    }
    
    if ( level.br_skipending )
    {
        return false;
    }
    
    return true;
}

// Namespace br_ending
// Params 2
// Checksum 0xba5930ea, Offset: 0xbdf
// Size: 0x66
function preload_ending( winners, var_410ded744dab958f )
{
    if ( !can_play_ending() )
    {
        return;
    }
    
    exfiltype = get_exfil_type();
    transientfunc = get_transient_func( exfiltype );
    
    if ( isdefined( transientfunc ) )
    {
        transientname = level [[ transientfunc ]]();
        
        if ( isdefined( transientname ) )
        {
            loadinfiltransient( transientname );
        }
    }
}

// Namespace br_ending
// Params 1
// Checksum 0x74638534, Offset: 0xc4d
// Size: 0x1c
function watchforendnotify( notifystring )
{
    level waittill( notifystring );
    logstring( "EXFIL SEQUENCE - watchForEndNotify endon notified" );
}

// Namespace br_ending
// Params 2
// Checksum 0xcb7aeb49, Offset: 0xc71
// Size: 0x123d
function play_ending( winners, var_410ded744dab958f )
{
    if ( !can_play_ending() )
    {
        return;
    }
    
    if ( get_exfil_type() == "gametype" )
    {
        assert( utility::issharedfuncdefined( #"gametype", #"play_br_ending" ), "<dev string:x25>" );
        level notify( #"br_ending_start", winners );
        utility::callsharedfunc( #"gametype", #"play_br_ending", winners, var_410ded744dab958f );
        return;
    }
    
    logstring( "EXFIL SEQUENCE - play_ending - Start" );
    level thread watchforendnotify( "endingSceneStop" );
    level endon( #"endingSceneStop" );
    
    foreach ( player in level.players )
    {
        if ( player isskydiving() )
        {
            player skydive_interrupt();
            player skydive_setbasejumpingstatus( 0 );
            player perk::giveperk( "specialty_falldamage" );
        }
    }
    
    winners = function_5713d46873b29625( winners );
    winners = arraysort( winners, undefined, &compare_higher_score );
    logstring( "EXFIL SEQUENCE - play_ending - update_winning_players" );
    update_winning_players( winners );
    level notify( #"br_ending_start", winners );
    winnersstruct = { #winners:winners };
    level callback::callback( #"ending_start", winnersstruct );
    level.brdisablefinalkillcam = 1;
    
    /#
        winners = br_ending_debug::function_f61879e453b76ae6( winners );
    #/
    
    if ( !isdefined( level.var_fa1be1f101b545a3 ) )
    {
        level.var_fa1be1f101b545a3 = winners.size;
    }
    
    exfiltype = get_exfil_type();
    logstring( "EXFIL SEQUENCE - play_ending - exfilType = " + exfiltype );
    usingscenesystem = function_e8228be037475bb0( exfiltype );
    logstring( "EXFIL SEQUENCE - play_ending - usingSceneSystem = " + usingscenesystem );
    animstruct = create_exfil_animstruct( exfiltype, winners, var_410ded744dab958f, usingscenesystem );
    logstring( "EXFIL SEQUENCE - play_ending - Pack" );
    animstruct set_ending_pack( exfiltype, var_410ded744dab958f );
    logstring( "EXFIL SEQUENCE - play_ending - update_winning_players" );
    winners = function_5713d46873b29625( winners );
    winners = arraysort( winners, undefined, &compare_higher_score );
    update_winning_players( winners );
    winners = undefined;
    level.br_ending = animstruct;
    println( "<dev string:x92>" );
    
    if ( usingscenesystem )
    {
        logstring( "EXFIL SEQUENCE - play_ending - ending_viewing_players_setup" );
        ending_viewing_players_setup( animstruct );
        logstring( "EXFIL SEQUENCE - play_ending - ending_winning_players_setup" );
        ending_winning_players_setup( animstruct );
        logstring( "EXFIL SEQUENCE - play_ending - clear_vehicles" );
        clear_vehicles( animstruct.origin, 1000 );
        logstring( "EXFIL SEQUENCE - play_ending - clear_outlines" );
        clear_outlines();
        setomnvar( "scriptable_loot_hide", 1 );
        logstring( "EXFIL SEQUENCE - play_ending - endingWeaponWaittills" );
        level notify( #"br_ending_playing" );
        wait 0.5;
        logstring( "EXFIL SEQUENCE - play_ending - play_sceneSystem_scenes" );
        animstruct play_scenesystem_scenes();
    }
    else
    {
        logstring( "EXFIL SEQUENCE - play_ending - non scene system block" );
        ending_viewing_players_setup( animstruct );
        player_rigs = ending_winning_players_setup( animstruct );
        clear_vehicles( animstruct.origin, 1000 );
        clear_outlines();
        setomnvar( "scriptable_loot_hide", 1 );
        animstruct animation::anim_first_frame_solo( animstruct.cam, animstruct.packs[ 0 ].anime );
        
        foreach ( player in level.players )
        {
            /#
                if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
                {
                    continue;
                }
            #/
            
            player cameralinkto( animstruct.cam, "tag_player", 1, 1 );
        }
        
        foreach ( pack in animstruct.packs )
        {
            println( "<dev string:xc7>" + pack.anime + "<dev string:xd7>" );
            
            if ( pack.var_c9ef7dbce2d4764e )
            {
                foundvalidplayer = 0;
                
                foreach ( player in pack.players )
                {
                    if ( isplayer( player ) && isdefined( level.scr_anim[ player.animname ][ pack.anime ] ) )
                    {
                        foundvalidplayer = 1;
                        break;
                    }
                }
                
                if ( !foundvalidplayer )
                {
                    continue;
                }
            }
            
            if ( isdefined( pack.startfunc ) )
            {
                animstruct [[ pack.startfunc ]]( pack.paramarray );
            }
            
            if ( isdefined( pack.fov ) )
            {
                br_ending_util::allplayers_setfov( pack.fov );
            }
            else
            {
                br_ending_util::function_4b282a3b31aae42a();
            }
            
            if ( isdefined( pack.fstop ) && isdefined( pack.focusdist ) )
            {
                br_ending_util::allplayers_setphysicaldof( pack.fstop, pack.focusdist, pack.focusspeed, pack.aperturespeed, pack.focalpoint );
            }
            
            if ( isdefined( pack.playerfunc ) )
            {
                foreach ( player in level.players )
                {
                    [[ pack.playerfunc ]]( player, pack.var_6d8067a88da0e813 );
                }
            }
            
            if ( isdefined( pack.fx ) )
            {
                playfx( utility::getfx( pack.fx ), pack.fxorigin, anglestoforward( pack.fxangles ), anglestoup( pack.fxangles ) );
            }
            
            if ( pack.players.size > 0 )
            {
                pack.players = function_5713d46873b29625( pack.players );
                
                foreach ( player in pack.players )
                {
                    player dontinterpolate();
                    
                    if ( isdefined( player.linkedtoent ) )
                    {
                        if ( !isplayer( player ) )
                        {
                            if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) && isdefined( player.player_rig.avatar ) )
                            {
                                avatar = player.player_rig.avatar;
                                avatar scriptmodelplayanimdeltamotionfrompos( level.scr_eventanim[ avatar.animname ][ pack.anime ], animstruct.origin, animstruct.angles, avatar.animname );
                                avatar thread notetrack::start_notetrack_wait( avatar, avatar.animname, pack.anime, avatar.animname, level.scr_anim[ avatar.animname ][ pack.anime ] );
                            }
                            else
                            {
                                player.linkedtoent thread animation::anim_single_solo( player.player_rig, pack.anime, player.linkedtotag );
                            }
                        }
                        else
                        {
                            player.linkedtoent thread anim_mp::anim_player_solo( player, player.player_rig, pack.anime, player.linkedtotag );
                        }
                        
                        continue;
                    }
                    
                    if ( !isplayer( player ) )
                    {
                        if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) && isdefined( player.player_rig.avatar ) )
                        {
                            avatar = player.player_rig.avatar;
                            avatar scriptmodelplayanimdeltamotionfrompos( level.scr_eventanim[ avatar.animname ][ pack.anime ], animstruct.origin, animstruct.angles, avatar.animname );
                            avatar thread notetrack::start_notetrack_wait( avatar, avatar.animname, pack.anime, avatar.animname, level.scr_anim[ avatar.animname ][ pack.anime ] );
                        }
                        else
                        {
                            animstruct thread animation::anim_single_solo( player.player_rig, pack.anime );
                        }
                        
                        continue;
                    }
                    
                    animstruct thread anim_mp::anim_player_solo( player, player.player_rig, pack.anime );
                }
                
                if ( isdefined( animstruct.player_rigs ) )
                {
                    if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) )
                    {
                        foreach ( rig in animstruct.player_rigs )
                        {
                            if ( isdefined( rig.avatar ) && isdefined( level.scr_anim[ rig.avatar.animname ][ pack.anime ] ) )
                            {
                                avatar = rig.avatar;
                                avatar scriptmodelplayanimdeltamotionfrompos( level.scr_eventanim[ avatar.animname ][ pack.anime ], animstruct.origin, animstruct.angles, avatar.animname );
                                avatar thread notetrack::start_notetrack_wait( avatar, avatar.animname, pack.anime, avatar.animname, level.scr_anim[ avatar.animname ][ pack.anime ] );
                            }
                        }
                    }
                    else
                    {
                        foreach ( rig in animstruct.player_rigs )
                        {
                            if ( isdefined( rig.player ) )
                            {
                                continue;
                            }
                            
                            if ( !isdefined( level.scr_anim[ rig.animname ][ pack.anime ] ) )
                            {
                                continue;
                            }
                            
                            if ( isdefined( rig.linkedtoent ) )
                            {
                                rig.linkedtoent thread animation::anim_single_solo( rig, pack.anime, rig.linkedtotag );
                                continue;
                            }
                            
                            animstruct thread animation::anim_single_solo( rig, pack.anime );
                        }
                    }
                }
            }
            
            if ( pack.ents.size > 0 )
            {
                foreach ( ent in pack.ents )
                {
                    if ( !ent.dontteleport )
                    {
                        ent dontinterpolate();
                    }
                }
                
                animstruct thread animation::anim_single( pack.ents, pack.anime );
            }
            
            foreach ( rig in pack.lightingrigs )
            {
                linkedtag = level.var_2c3d783630787a16 ?? "tag_origin";
                
                foreach ( probe in rig.probes )
                {
                    origin_offset = probe.origin_offset;
                    angles_offset = probe.angles_offset;
                    
                    if ( !isdefined( angles_offset ) )
                    {
                        angles_offset = ( 0, 0, 0 );
                    }
                    
                    probe show();
                    probe linkto( rig.linkent, linkedtag, origin_offset, angles_offset );
                }
                
                foreach ( light in rig.lights )
                {
                    if ( isdefined( light.override_intensity ) )
                    {
                        light setlightintensity( light.override_intensity );
                    }
                    else if ( isdefined( light.original_intensity ) )
                    {
                        light setlightintensity( light.original_intensity );
                    }
                    
                    origin_offset = light.origin_offset;
                    angles_offset = light.angles_offset;
                    
                    if ( !isdefined( angles_offset ) )
                    {
                        angles_offset = ( 0, 0, 0 );
                    }
                    
                    light linkto( rig.linkent, linkedtag, origin_offset, angles_offset );
                }
            }
            
            animstruct thread faderunner( pack );
            
            if ( isdefined( pack.xcamasset ) )
            {
                animstruct.cam dontinterpolate();
                animstruct thread animation::anim_single_solo( animstruct.cam, pack.anime );
                
                foreach ( player in level.players )
                {
                    player cameraunlink();
                    
                    /#
                        if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
                        {
                            continue;
                        }
                    #/
                    
                    player playxcam( pack.xcamasset, 0, animstruct.origin, animstruct.angles, undefined, undefined, level.var_2d27808cb381bc1d );
                }
                
                xcamlength = getxcamlength( pack.xcamasset );
                xcamlength -= 0.033;
                xcamlength -= xcamlength % 0.05;
                level utility::waittill_notify_or_timeout( "br_ending_skip_scene", xcamlength );
            }
            else
            {
                foreach ( player in level.players )
                {
                    player stopxcam();
                    
                    /#
                        if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
                        {
                            continue;
                        }
                    #/
                    
                    player cameralinkto( animstruct.cam, "tag_player", 1, 1 );
                }
                
                animstruct.cam dontinterpolate();
                animstruct thread animation::anim_single_solo( animstruct.cam, pack.anime );
                utility::waittill_any_ents( animstruct, pack.anime, level, "br_ending_skip_scene" );
            }
            
            waitframe();
            
            if ( isdefined( pack.endfunc ) )
            {
                animstruct [[ pack.endfunc ]]( pack.var_3d181e279a220c81 );
            }
        }
        
        wait 1;
    }
    
    logstring( "EXFIL SEQUENCE - play_ending - cleanup" );
    cleanup_ending( level.br_ending );
    
    if ( isfunction( level.var_32d03de8d8bb6794 ) )
    {
        level [[ level.var_32d03de8d8bb6794 ]]( level.br_ending );
    }
}

// Namespace br_ending
// Params 0
// Checksum 0x9e996202, Offset: 0x1eb6
// Size: 0x98
function play_scenesystem_scenes()
{
    logstring( "EXFIL SEQUENCE - play_sceneSystem_scenes - Start" );
    exfiltype = get_exfil_type();
    logstring( "EXFIL SEQUENCE - play_sceneSystem_scenes - exfilType = " + exfiltype );
    playfunc = get_play_func( exfiltype );
    
    if ( isdefined( playfunc ) )
    {
        self [[ playfunc ]]();
        return;
    }
    
    logstring( "EXFIL SEQUENCE - play_sceneSystem_scenes - bad play func" );
    
    switch ( exfiltype )
    {
        case #"hash_18208461fac4f35e":
            br_ending_chopper_to_hq::chopperhqexfil_play();
            break;
        case #"hash_ce37a6540166b6f7":
            br_ending_cq::function_e9479a12331670c4();
        default:
            break;
    }
}

// Namespace br_ending
// Params 1
// Checksum 0xf371e6f7, Offset: 0x1f56
// Size: 0x4d9
function cleanup_ending( animstruct )
{
    if ( isdefined( animstruct ) )
    {
        if ( !animstruct.usingscenesystem )
        {
            foreach ( pack in animstruct.packs )
            {
                foreach ( ent in pack.ents )
                {
                    if ( isdefined( ent ) )
                    {
                        if ( isdefined( ent.linkedents ) )
                        {
                            utility::array_delete( ent.linkedents );
                        }
                        
                        ent delete();
                    }
                }
                
                foreach ( player in pack.players )
                {
                    if ( isdefined( player ) && player.isdisconnectplayer )
                    {
                        assert( !isplayer( player ) );
                        
                        if ( isdefined( player.player_rig ) )
                        {
                            if ( isdefined( player.player_rig.avatar ) )
                            {
                                if ( isdefined( player.player_rig.avatar.weaponent ) )
                                {
                                    player.player_rig.avatar.weaponent delete();
                                }
                                
                                player.player_rig.avatar delete();
                            }
                            
                            player.player_rig delete();
                        }
                        
                        player delete();
                    }
                }
            }
        }
        
        if ( isdefined( animstruct.cam ) )
        {
            animstruct.cam delete();
        }
        
        animstruct stopfaderunner();
    }
    
    br_ending_util::function_4b282a3b31aae42a();
    br_ending_util::allplayers_clearphysicaldof();
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player visionsetnakedforplayer( "", 1 );
            
            if ( player.sessionstate == "spectator" )
            {
                player setspectatedefaults( animstruct.origin, animstruct.angles );
            }
            else
            {
                player setorigin( animstruct.origin );
            }
            
            if ( isdefined( player.player_rig ) )
            {
                if ( isdefined( player.player_rig.avatar ) )
                {
                    if ( isdefined( player.player_rig.avatar.weaponent ) )
                    {
                        player.player_rig.avatar.weaponent delete();
                    }
                    
                    player.player_rig.avatar delete();
                }
                
                player.player_rig delete();
            }
        }
    }
    
    if ( !animstruct.usingscenesystem )
    {
        foreach ( rig in animstruct.player_rigs )
        {
            if ( !isdefined( rig ) )
            {
                continue;
            }
            
            if ( isdefined( rig.avatar ) )
            {
                if ( isdefined( rig.avatar.weaponent ) )
                {
                    rig.avatar.weaponent delete();
                }
                
                rig.avatar delete();
            }
            
            rig delete();
        }
    }
}

// Namespace br_ending
// Params 0
// Checksum 0xb7db0099, Offset: 0x2437
// Size: 0x29
function stopfaderunner()
{
    self notify( #"stopfaderunner" );
    
    if ( isdefined( self.fadeoverlay ) )
    {
        self.fadeoverlay destroy();
    }
}

// Namespace br_ending
// Params 1
// Checksum 0x63a9c3e1, Offset: 0x2468
// Size: 0x280
function faderunner( pack )
{
    self notify( #"faderunner" );
    self endon( #"faderunner" );
    self endon( #"stopfaderunner" );
    
    if ( !isdefined( self.fadeoverlay ) )
    {
        overlay = newhudelem();
        overlay.x = 0;
        overlay.y = 0;
        overlay setshader( "black", 640, 480 );
        overlay.alignx = "left";
        overlay.aligny = "top";
        overlay.horzalign = "fullscreen";
        overlay.vertalign = "fullscreen";
        overlay.sort = -1;
        overlay setshowinrealism( 1 );
        self.fadeoverlay = overlay;
    }
    
    if ( !isdefined( pack.fadeinlength ) && !isdefined( pack.fadeoutlength ) )
    {
        self.fadeoverlay.alpha = 0;
        return;
    }
    
    if ( isdefined( pack.fadeinlength ) )
    {
        self.fadeoverlay.alpha = 1;
        self.fadeoverlay fadeovertime( pack.fadeinlength );
        self.fadeoverlay.alpha = 0;
        wait pack.fadeinlength;
    }
    
    if ( isdefined( pack.fadeoutlength ) )
    {
        packlength = undefined;
        
        if ( isdefined( pack.xcamasset ) )
        {
            xcamlength = getxcamlength( pack.xcamasset );
            xcamlength -= 0.033;
            xcamlength -= xcamlength % 0.05;
            packlength = xcamlength;
        }
        else
        {
            animref = level.scr_anim[ "endingCam" ][ pack.anime ];
            animlength = getanimlength( animref );
            packlength = animlength;
        }
        
        if ( isdefined( pack.fadeinlength ) )
        {
            packlength -= pack.fadeinlength;
        }
        
        wait packlength - pack.fadeoutlength;
        self.fadeoverlay.alpha = 0;
        self.fadeoverlay fadeovertime( pack.fadeoutlength );
        self.fadeoverlay.alpha = 1;
    }
}

// Namespace br_ending
// Params 2
// Checksum 0x758d095b, Offset: 0x26f0
// Size: 0x38, Type: bool
function compare_higher_score( player1, player2 )
{
    return player1.pers[ "score" ] > player2.pers[ "score" ];
}

// Namespace br_ending
// Params 2
// Checksum 0x118ccfd7, Offset: 0x2731
// Size: 0x1f8
function function_6211c053901cea1e( team1, team2 )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_2481d9b8e5d3278c" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_2481d9b8e5d3278c", team1, team2 );
    }
    
    team1players = function_5713d46873b29625( teams::getteamdata( team1, "alivePlayers" ) );
    team1score = 0;
    
    if ( level.teambased && game[ "teamScores" ] && game[ "teamScores" ][ team1 ] )
    {
        team1score = game[ "teamScores" ][ team1 ];
    }
    else
    {
        foreach ( player in team1players )
        {
            team1score += player.pers[ "score" ];
        }
    }
    
    team2players = function_5713d46873b29625( teams::getteamdata( team2, "alivePlayers" ) );
    team2score = 0;
    
    if ( level.teambased && game[ "teamScores" ] && game[ "teamScores" ][ team2 ] )
    {
        team2score = game[ "teamScores" ][ team2 ];
    }
    else
    {
        foreach ( player in team2players )
        {
            team2score += player.pers[ "score" ];
        }
    }
    
    return team1score > team2score;
}

// Namespace br_ending
// Params 0
// Checksum 0x68a8bd40, Offset: 0x2932
// Size: 0x81
function temp_debug_wait_and_stop_music_loop()
{
    wait 25;
    
    foreach ( player in level.players )
    {
        player setplayermusicstate( "" );
    }
}

// Namespace br_ending
// Params 1
// Checksum 0x37dafe6b, Offset: 0x29bb
// Size: 0x271
function ending_viewing_players_setup( animstruct )
{
    level.brspawnplayersending = 1;
    level notify( #"hash_bcd7948d1417bc21" );
    
    foreach ( player in level.players )
    {
        function_15b39b5fac9cbb1c( player );
        
        /#
            if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
            {
                continue;
            }
        #/
        
        player function_e19ccf4da1a61ba7( animstruct.origin );
        player utility::hidehudenable();
        player setcinematicmotionoverride( "disabled" );
        
        if ( !player.var_ee74e8eed7f0fe09 )
        {
            player setclientomnvar( "ui_br_squad_eliminated_active", 0 );
        }
        
        if ( isdefined( player.sessionstate ) )
        {
            if ( ( player.team == "spectator" || player.team == "codcaster" ) && !getdvarint( @"hash_cf7e9f3447526b4d", 0 ) )
            {
                continue;
            }
            
            if ( player.sessionstate == "intermission" )
            {
                player player::updatesessionstate( "spectator" );
            }
            
            if ( player.sessionstate == "spectator" )
            {
                if ( animstruct.usingscenesystem )
                {
                    player setspectatedefaults( animstruct.origin, animstruct.angles );
                    player spawn( animstruct.origin, animstruct.angles );
                }
                else
                {
                    player setspectatedefaults( animstruct.cam.origin, animstruct.cam.angles );
                    player spawn( animstruct.cam.origin, animstruct.cam.angles );
                }
                
                continue;
            }
            
            player player_equipment_use_stop();
            player player_abilities_disable();
            player setorigin( animstruct.origin + ( 0, 0, 100 ) );
        }
    }
    
    level notify( #"hash_7c482f218be7a5f6" );
}

// Namespace br_ending
// Params 1
// Checksum 0x5db06025, Offset: 0x2c34
// Size: 0x473
function ending_winning_players_setup( animstruct )
{
    players = animstruct.winners;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( level.var_1f9f1f1326580faa )
        {
            player.var_cc837d733375812c = [];
            
            if ( isdefined( player getcurrentweapon() ) )
            {
                player.var_cc837d733375812c = arraycombineunique( player.var_cc837d733375812c, [ player getcurrentweapon() ] );
            }
            
            if ( isdefined( player.primaryweaponobj ) )
            {
                player.var_cc837d733375812c = arraycombineunique( player.var_cc837d733375812c, [ player.primaryweaponobj ] );
            }
            
            if ( isdefined( player.secondaryweaponobj ) )
            {
                player.var_cc837d733375812c = arraycombineunique( player.var_cc837d733375812c, [ player.secondaryweaponobj ] );
            }
        }
    }
    
    spawnorigin = undefined;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.sessionstate == "playing" )
        {
            spawnorigin = player.origin;
            break;
        }
    }
    
    player_rigs = [];
    ui_num = 0;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( ( player.team == "spectator" || player.team == "codcaster" ) && !getdvarint( @"hash_cf7e9f3447526b4d", 0 ) )
        {
            continue;
        }
        
        if ( isdefined( player.sessionstate ) && player.sessionstate != "playing" )
        {
            player.forcespawnorigin = spawnorigin;
            player.alreadyaddedtoalivecount = 1;
            player playerlogic::spawnplayer( 0 );
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player utility::hidehudenable();
        }
        
        player player_equipment_use_stop();
        player player_abilities_disable();
        player.plotarmor = 1;
        player.oobimmunity = 1;
        player.linkedtoent = undefined;
        player.linkedtotag = undefined;
        player.winindex = ui_num;
        ui_num++;
        
        if ( player.animname != player.brexfilanimname )
        {
            player.animname = player.brexfilanimname;
        }
        
        if ( getdvarint( @"scr_br_ending_play", 0 ) == 0 )
        {
            player thread player_set_weapon();
        }
        else
        {
            player player_set_weapon();
        }
        
        if ( animstruct.usingscenesystem )
        {
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
            {
                continue;
            }
        #/
        
        player br_ending_util::create_player_rig( player.animname, "viewhands_base_iw8", animstruct );
        
        if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) )
        {
            player br_ending_util::create_player_rig_avatar( player.animname, animstruct.origin );
        }
        
        level thread br_ending_util::ending_player_disconnect_thread( player );
        player_rigs[ player_rigs.size ] = player.player_rig;
    }
    
    return player_rigs;
}

// Namespace br_ending
// Params 1
// Checksum 0x567a171c, Offset: 0x30b0
// Size: 0x42
function update_winning_players( winnerplayers )
{
    if ( !isdefined( winnerplayers ) )
    {
        return;
    }
    
    winnerplayers = function_5713d46873b29625( winnerplayers );
    winnerplayers = arraysort( winnerplayers, undefined, &compare_higher_score );
    function_7832dc112ff6b22f( "winners", winnerplayers );
    level.var_fa1be1f101b545a3 = winnerplayers.size;
}

// Namespace br_ending
// Params 1
// Checksum 0x2c7c2377, Offset: 0x30fa
// Size: 0x114
function function_c64a9bbb6771df41( winnerplayers )
{
    if ( !isdefined( winnerplayers ) )
    {
        return;
    }
    
    winnerplayers = function_5713d46873b29625( winnerplayers );
    winnerplayers = arraysort( winnerplayers, undefined, &compare_higher_score );
    accolades = [];
    
    foreach ( winner in winnerplayers )
    {
        if ( !isdefined( winner.var_4f97df463efd71b5 ) )
        {
            continue;
        }
        
        accoladeindex = level.var_3abb05bb58a5e16e[ winner.var_4f97df463efd71b5 ];
        
        if ( isdefined( winner.var_327968da5c5c251f ) )
        {
            accoladeindex = level.var_3abb05bb58a5e16e[ winner.var_327968da5c5c251f ];
        }
        
        assert( isdefined( accoladeindex ) );
        accolades[ accolades.size ] = accoladeindex;
    }
    
    function_7832dc112ff6b22f( "accolades", accolades );
}

// Namespace br_ending
// Params 0
// Checksum 0x36608c21, Offset: 0x3216
// Size: 0x124
function player_equipment_use_stop()
{
    if ( vehicle::is_in_vehicle( 1 ) )
    {
        vehicle_occupancy::eject_all_occupants( self.vehicle );
    }
    
    if ( vehicle::function_f644d495b20d4991() )
    {
        vehicle::function_c62afb315b385563();
    }
    
    if ( self isonascender() )
    {
        br_utility::function_a8021859c16f9008();
    }
    
    if ( isdefined( self.remoteuav ) )
    {
        self.remoteuav remoteuav::remoteuav_leave();
    }
    
    if ( isdefined( self.currentturret ) )
    {
        manual_turret::manualturret_endplayeruse( self.currentturret );
    }
    
    if ( isdefined( self.usingremote ) )
    {
        vehicles = vehicle_getarray();
        
        foreach ( vehicle in vehicles )
        {
            if ( vehicle.owner == self )
            {
                if ( isdefined( vehicle.helperdronetype ) )
                {
                    vehicle helper_drone::helperdrone_explode( 1 );
                }
            }
        }
    }
}

// Namespace br_ending
// Params 0
// Checksum 0xb5da1109, Offset: 0x3342
// Size: 0x8d
function player_abilities_disable()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    player::_freezecontrols( 1, undefined, "brEnding" );
    val::set( "brEnding", "offhand_weapons", 0 );
    val::set( "brEnding", "melee", 0 );
    val::set( "brEnding", "ads", 0 );
    val::set( "brEnding", "fire", 0 );
    val::set( "brEnding", "weapon_switch", 0 );
    val::set( "brEnding", "vehicle_use", 0 );
    self skydive_interrupt();
}

// Namespace br_ending
// Params 0
// Checksum 0x4ae6c1b6, Offset: 0x33d7
// Size: 0x26
function player_abilities_enable()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    player::_freezecontrols( 0, undefined, "brEnding" );
    val::reset_all( "brEnding" );
}

// Namespace br_ending
// Params 0
// Checksum 0xe76a22e3, Offset: 0x3405
// Size: 0x34c
function player_set_weapon()
{
    self endon( #"disconnect" );
    switchweapon = undefined;
    
    if ( isdefined( self.var_cc837d733375812c ) && isdefined( level.var_f152d0d36747c32b ) && level.var_1f9f1f1326580faa && self.var_cc837d733375812c.size > 0 )
    {
        weapons = self.var_cc837d733375812c;
        self clearaccessory();
        self takeallweapons();
        waitframe();
        
        foreach ( weapon in weapons )
        {
            if ( isnullweapon( weapon ) )
            {
                continue;
            }
            
            if ( !arraycontains( level.var_f152d0d36747c32b, weapon.classname ) || weapontype( weapon ) == "riotshield" )
            {
                continue;
            }
            
            if ( weapon.ismelee )
            {
                continue;
            }
            
            if ( weapon.reloaddisabled )
            {
                continue;
            }
            
            if ( !isdefined( switchweapon ) )
            {
                switchweapon = weapon;
            }
        }
        
        if ( !isdefined( switchweapon ) )
        {
            defaultpistol = weapon::buildweapon( "iw9_pi_golf17_mp" );
            inventory_utility::_giveweapon( defaultpistol );
            switchweapon = defaultpistol;
        }
    }
    else
    {
        weapons = self getweaponslistprimaries();
        currentweapon = self getcurrentweapon();
        weapons = arraycombineunique( [ currentweapon ], weapons );
        
        foreach ( weapon in weapons )
        {
            if ( isdefined( level.var_f152d0d36747c32b ) )
            {
                if ( !arraycontains( level.var_f152d0d36747c32b, weapon.classname ) || weapontype( weapon ) == "riotshield" )
                {
                    continue;
                }
            }
            else if ( weapon.classname != "rifle" || weapon::issuperweapon( weapon ) )
            {
                continue;
            }
            
            if ( weapon.ismelee )
            {
                continue;
            }
            
            switchweapon = weapon;
            
            if ( isdefined( switchweapon ) )
            {
                break;
            }
        }
        
        if ( !isnullweapon( self.currentweapon ) )
        {
            self clearaccessory();
            self takeallweapons();
        }
        else
        {
            waitframe();
        }
        
        if ( !isdefined( switchweapon ) )
        {
            switchweapon = weapon::buildweapon( "iw9_ar_mike4", [], "camo_none", "none" );
        }
    }
    
    inventory_utility::_giveweapon( switchweapon, undefined, undefined, 1 );
    self.pers[ "primaryWeapon" ] = getcompleteweaponname( switchweapon );
    self.primaryweapon = getcompleteweaponname( switchweapon );
    self.primaryweaponobj = switchweapon;
    self.secondaryweapon = undefined;
    self.secondaryweaponobj = undefined;
    self.var_1b2725cecf82cf13 = switchweapon;
    gameplay_telemetry::function_3e91d2222fa2419f();
    
    if ( isdefined( self.executionref ) )
    {
        execution::_giveexecution( self.executionref );
    }
    
    if ( self getweaponammoclip( switchweapon ) < 5 )
    {
        self setweaponammoclip( switchweapon, 5 );
    }
    
    self switchtoweaponimmediate( switchweapon );
}

// Namespace br_ending
// Params 0
// Checksum 0xb29681aa, Offset: 0x3759
// Size: 0xc5
function get_exfil_type()
{
    defaulttype = "chopper_to_hq";
    
    if ( level.br_endings.size > 0 )
    {
        defaulttype = getarraykey( level.br_endings, 0 );
    }
    
    exfil = getmatchrulesdata( "brData", "exfil" );
    
    if ( exfil )
    {
        exfiltype = getscriptbundlefieldvalue( hashcat( %"hash_477268a66b4ea2a8", exfil ), #"exfiltype" );
        assert( exfiltype );
        
        if ( exfiltype )
        {
            defaulttype = exfiltype;
        }
    }
    
    type = getdvar( @"scr_br_ending_type", defaulttype );
    
    if ( isdefined( level.var_572d9d46430e6e25 ) )
    {
        type = level.var_572d9d46430e6e25.var_cb34d2b743970ba5;
    }
    
    return type;
}

// Namespace br_ending
// Params 1
// Checksum 0xd8f79be9, Offset: 0x3827
// Size: 0x32, Type: bool
function function_ea8177920674d8ef( type )
{
    var_e63a9d5ec4b488a0 = function_bcd77f3717230834( type );
    
    if ( isdefined( var_e63a9d5ec4b488a0 ) )
    {
        return true;
    }
    
    return !function_e8228be037475bb0( type );
}

// Namespace br_ending
// Params 1
// Checksum 0x4ba0e14b, Offset: 0x3862
// Size: 0x67
function function_e8228be037475bb0( type )
{
    if ( level.br_endings[ type ].usescenesystem )
    {
        return 1;
    }
    
    switch ( type )
    {
        case #"hash_18208461fac4f35e":
        case #"hash_8e482dd76314929c":
        case #"hash_ce37a6540166b6f7":
            return 1;
        default:
            return 0;
    }
}

// Namespace br_ending
// Params 2
// Checksum 0xff1a79dd, Offset: 0x38d1
// Size: 0xb0
function set_ending_pack( type, var_410ded744dab958f )
{
    packfunc = get_pack_func( type );
    
    if ( isdefined( packfunc ) )
    {
        self [[ packfunc ]]( var_410ded744dab958f );
        return;
    }
    
    switch ( type )
    {
        case #"hash_d9cfbe7fb5447f0e":
            br_ending_chopper2::chopperexfil_pack( var_410ded744dab958f );
            break;
        case #"hash_18208461fac4f35e":
            br_ending_chopper_to_hq::chopperhqexfil_pack( var_410ded744dab958f );
            break;
        case #"hash_ce37a6540166b6f7":
            br_ending_cq::function_a4ce9912bc284173( var_410ded744dab958f );
            break;
        case #"hash_1136bc3322c0a548":
        default:
            br_ending_chopper::chopperexfil_pack( var_410ded744dab958f );
            break;
    }
}

// Namespace br_ending
// Params 4
// Checksum 0xbdcafb23, Offset: 0x3989
// Size: 0xdb
function create_exfil_animstruct( exfiltype, winners, var_410ded744dab958f, usingscenesystem )
{
    struct = get_ending_struct( exfiltype, winners, var_410ded744dab958f );
    struct.usingscenesystem = usingscenesystem;
    
    /#
        if ( isdefined( var_410ded744dab958f ) )
        {
            println( "<dev string:xfe>" + struct.origin + "<dev string:x118>" + distance( var_410ded744dab958f, struct.origin ) );
            println( "<dev string:x135>" + var_410ded744dab958f );
        }
    #/
    
    struct.bundle = level.br_endings[ exfiltype ].bundle;
    struct.winners = winners;
    
    if ( !usingscenesystem )
    {
        struct.cam = struct br_ending_util::create_cam();
    }
    
    return struct;
}

// Namespace br_ending
// Params 1
// Checksum 0xb99433a0, Offset: 0x3a6d
// Size: 0x3e
function init_ending_structs( exfiltype )
{
    waittillframeend();
    level.br_ending_structs = get_ending_structs( exfiltype );
    level.var_3656887bb32875fc = [];
    level.var_3656887bb32875fc[ "cq_nuke" ] = get_cq_nuke_structs();
}

// Namespace br_ending
// Params 1
// Checksum 0x3e6ce42c, Offset: 0x3ab3
// Size: 0x2a, Type: bool
function get_ending_structs( exfiltype )
{
    return utility::callsharedfunc( #"br_ending", #"get_ending_locations", exfiltype ) ?? [];
}

// Namespace br_ending
// Params 0
// Checksum 0x822db93c, Offset: 0x3ae6
// Size: 0x3
function get_cq_nuke_structs()
{
    return [];
}

// Namespace br_ending
// Params 3
// Checksum 0xefa921e0, Offset: 0x3af2
// Size: 0x9a
function get_ending_struct( exfiltype, players, var_410ded744dab958f )
{
    players = function_5713d46873b29625( players );
    
    if ( players.size > 0 )
    {
        origin = br_ending_util::get_center_of_array( players );
    }
    else
    {
        origin = var_410ded744dab958f;
    }
    
    endingstructs = function_f72972bf5283c6b4( exfiltype );
    structs = sortbydistance( endingstructs, origin );
    
    if ( !isdefined( structs[ 0 ].angles ) )
    {
        structs[ 0 ].angles = ( 0, 0, 0 );
    }
    
    return structs[ 0 ];
}

// Namespace br_ending
// Params 1
// Checksum 0x687d00bd, Offset: 0x3b95
// Size: 0x24, Type: bool
function function_f72972bf5283c6b4( exfiltype )
{
    return level.var_3656887bb32875fc[ exfiltype ] ?? level.br_ending_structs;
}

// Namespace br_ending
// Params 2
// Checksum 0xea0e474a, Offset: 0x3bc2
// Size: 0xa8
function clear_vehicles( origin, radius )
{
    vehicles = vehicle_getarrayinradius( origin, radius, 20000 );
    
    foreach ( vehicle in vehicles )
    {
        if ( !vehicle.endingvehicle )
        {
            vehicle delete();
        }
    }
}

// Namespace br_ending
// Params 0
// Checksum 0x239aa0c6, Offset: 0x3c72
// Size: 0xaa
function clear_outlines()
{
    foreach ( player in level.br_ending.winners )
    {
        if ( isdefined( player.laststandoutlineid ) )
        {
            outline::outlinedisable( player.laststandoutlineid, player );
            player.laststandoutlineid = undefined;
        }
    }
}

// Namespace br_ending
// Params 3
// Checksum 0x77afd921, Offset: 0x3d24
// Size: 0x5d
function create_struct( org, ang, var_c2f0782945bb59eb )
{
    struct = spawnstruct();
    struct.origin = org;
    struct.angles = ang;
    
    /#
        struct.var_7187159a30090400 = var_c2f0782945bb59eb;
    #/
    
    return struct;
}

