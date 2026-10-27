// scripts\mp\br\gametypes\br_multi_circle.gsc  (hash_170706c35acd0a56.gscc) (size: 33496 Bytes / 0x82d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8993b691 (2308159121)
// size ...... 33496 (0x82d8)
// includes .. 26  (offset: 0x7dd8)
// strings ... 56  (offset: 0x7ea8)
// dev strs .. 24  (offset: 0x81ac)
// exports ... 58  (offset: 0x5894)
// cseg ...... 0x539 + 0x535b (0x5894)
// imports ... 227 (offset: 0x61a4)
// animtree1 . 0   (offset: 0x82d8)
// animtree2 . 0   (offset: 0x82d8)
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\scriptable_group;
#using scripts\common\scriptable_group_spatial;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_activewarzone;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\weaponrank;

#namespace br_multi_circle;

// Namespace br_multi_circle
// Params 0
// Checksum 0xc01599f3, Offset: 0x557
// Size: 0xc4
function init()
{
    if ( getdvarint( @"scr_br_multi_circle", 0 ) == 0 )
    {
        return;
    }
    
    logstring( "br_multi_circle::init" );
    
    if ( getdvarint( @"hash_5bd161f5b9367829", 0 ) != 0 )
    {
        br_gametypes::enablefeature( #"circleearlystart" );
    }
    
    game[ "dialog" ][ "circle_split" ] = "gmst_wzan_crsp";
    game[ "dialog" ][ "circle_merge" ] = "gmst_wzan_crmr";
    game[ "dialog" ][ "circle_victory" ] = "gmst_wzan_crsv";
    initleveldata();
    initmulticircleconfigdata();
    function_82cfc105f01b86ed();
    
    if ( getdvarint( @"hash_f4a50b0871efa9e9", 1 ) != 0 )
    {
        br_circle::registercirclecallbacks( 12, undefined, undefined, undefined, &function_bbe499b2e187b75 );
    }
    
    level.var_897bde4d916801b4 = &function_ad210a54055486b9;
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x9991634c, Offset: 0x623
// Size: 0x24c
function initleveldata()
{
    level.br_multi_circle_enabled = 1;
    level.br_multi_circle = spawnstruct();
    level.br_multi_circle.circlecount = getdvarint( @"scr_br_multi_circle_count", 1 );
    level.br_multi_circle.splitindex = getdvarint( @"scr_br_multi_circle_split_index", 1 );
    level.br_multi_circle.mergeindex = getdvarint( @"scr_br_multi_circle_merge_index", 1 );
    level.br_multi_circle.splitangle = getdvarfloat( @"scr_br_multi_circle_split_angle", 0 );
    level.br_multi_circle.var_9e11935280811e82 = getdvarint( @"hash_4e2f0d19a2f755ee", 1 );
    level.br_multi_circle.var_ecfc0115dc62c2b1 = getdvarint( @"hash_dc93c4d0bfb9cf05", 1 );
    level.br_multi_circle.var_55d52b10d06cb653 = getdvarint( @"hash_8382dae948fa600f", 1 );
    level.br_multi_circle.var_2341710fcc40ced1 = getdvarfloat( @"hash_9e74a59c2151d0a", 0.5 );
    level.br_multi_circle.var_fc672ac81c22b2af = getdvarfloat( @"hash_e87e2d1053dae898", 0.5 );
    level.br_multi_circle.splittimescale = getdvarfloat( @"scr_br_multi_circle_split_time_scale", 1 );
    level.br_multi_circle.mergetimescale = getdvarfloat( @"scr_br_multi_circle_merge_time_scale", 2 );
    level.br_multi_circle.innertimescale = getdvarfloat( @"hash_5d8995f6d065bc6", 0.5 );
    level.br_multi_circle.var_18fe6f8a036a96bc = getdvarint( @"hash_744515d8c05e3243", 1 );
    level.br_multi_circle.var_92d86ba4c5a7850c = getdvarint( @"hash_c8f6fbc981b7f489", 0 );
    level.br_multi_circle.damagedebug = getdvarint( @"hash_317adf8ca39c83ae", 0 );
    level.br_multi_circle.configs = [];
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xe71c537d, Offset: 0x877
// Size: 0x15b
function initmulticircleconfigdata()
{
    if ( getdvarint( @"hash_56bf37e58750811d", 0 ) )
    {
        return;
    }
    
    logstring( "br_multi_circle::initMultiCircleConfigData" );
    configlist = level.br_level.var_3e33f6f2aa777d47;
    
    if ( !configlist || configlist.size == 0 )
    {
        return;
    }
    
    foreach ( cfg in configlist )
    {
        function_9bffd1b9886db0a2( cfg );
    }
    
    function_931b76bbe477e9c4();
    
    if ( configlist.size == 1 )
    {
        foreach ( config in level.br_multi_circle.configs )
        {
            applymulticircleconfig( config );
            break;
        }
        
        return;
    }
    
    function_b22f2da5fcf44995();
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xe79727a1, Offset: 0x9da
// Size: 0x2b
function function_b22f2da5fcf44995()
{
    if ( !level.br_multi_circle_enabled )
    {
        return;
    }
    
    config = choosemulticircleconfig();
    applymulticircleconfig( config );
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x7fb85292, Offset: 0xa0d
// Size: 0x28b
function function_9bffd1b9886db0a2( cfg )
{
    assert( isdefined( cfg.configname ), "<dev string:x24>" );
    circleradii = undefined;
    
    if ( isdefined( cfg.radius_list ) && cfg.radius_list.size > 0 )
    {
        assert( isarray( cfg.radius_list ) && cfg.mergeindex - cfg.splitindex + 1 == cfg.radius_list.size, "<dev string:x47>" );
        circleradii = [];
        
        for ( i = 0; i < cfg.radius_list.size ; i++ )
        {
            circleradii[ circleradii.size ] = cfg.radius_list[ i ].radius;
        }
    }
    
    configstruct = spawnstruct();
    configstruct.name = cfg.configname ?? "";
    configstruct.weight = cfg.weight ?? 0;
    configstruct.circlecount = cfg.circlecount;
    configstruct.splitindex = cfg.splitindex;
    configstruct.mergeindex = cfg.mergeindex;
    configstruct.var_9e11935280811e82 = cfg.var_9e11935280811e82 ?? 0;
    configstruct.var_ecfc0115dc62c2b1 = cfg.var_ecfc0115dc62c2b1 ?? 0;
    configstruct.var_55d52b10d06cb653 = cfg.var_55d52b10d06cb653 ?? 0;
    configstruct.var_2341710fcc40ced1 = cfg.splitminpercent ?? 0;
    configstruct.var_fc672ac81c22b2af = cfg.var_8e004a5720987089 ?? 0;
    configstruct.splittimescale = cfg.splittimescale ?? 0;
    configstruct.mergetimescale = cfg.mergetimescale ?? 0;
    configstruct.innertimescale = cfg.innertimescale ?? 0;
    configstruct.circleradii = circleradii;
    level.br_multi_circle.configs[ configstruct.name ] = configstruct;
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x8887bcfc, Offset: 0xca0
// Size: 0x13b
function function_931b76bbe477e9c4()
{
    var_d2839c3e26dbe60 = getdvar( @"hash_a963ed27ec05a745", "" );
    
    if ( var_d2839c3e26dbe60 != "" && isdefined( level.br_multi_circle.configs[ var_d2839c3e26dbe60 ] ) )
    {
        level.br_multi_circle.var_d2839c3e26dbe60 = var_d2839c3e26dbe60;
        return;
    }
    
    var_3b4eba747deb2cc3 = [];
    
    foreach ( config in level.br_multi_circle.configs )
    {
        if ( config.weight <= 0 )
        {
            continue;
        }
        
        if ( config.circlecount > 1 && br_circle::function_cd50329a10799649() )
        {
            continue;
        }
        
        var_3b4eba747deb2cc3[ config.name ] = config;
    }
    
    level.br_multi_circle.configs = var_3b4eba747deb2cc3;
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x6664f64f, Offset: 0xde3
// Size: 0x183
function choosemulticircleconfig()
{
    if ( isdefined( level.br_multi_circle.var_d2839c3e26dbe60 ) )
    {
        return level.br_multi_circle.configs[ level.br_multi_circle.var_d2839c3e26dbe60 ];
    }
    
    weightedsum = 0;
    
    foreach ( config in level.br_multi_circle.configs )
    {
        weightedsum += config.weight;
    }
    
    randchoice = randomfloat( weightedsum );
    choicesum = 0;
    
    foreach ( config in level.br_multi_circle.configs )
    {
        choicesum += config.weight;
        
        if ( randchoice <= choicesum )
        {
            return config;
        }
    }
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x57397f9f, Offset: 0xf6f
// Size: 0x24f
function applymulticircleconfig( config )
{
    if ( !isdefined( config ) )
    {
        return;
    }
    
    level.br_multi_circle.config = config;
    level.br_multi_circle.circlecount = config.circlecount;
    level.br_multi_circle.splitindex = config.splitindex;
    level.br_multi_circle.mergeindex = config.mergeindex;
    level.br_multi_circle.var_9e11935280811e82 = config.var_9e11935280811e82;
    level.br_multi_circle.var_ecfc0115dc62c2b1 = config.var_ecfc0115dc62c2b1;
    level.br_multi_circle.var_55d52b10d06cb653 = config.var_55d52b10d06cb653;
    level.br_multi_circle.var_2341710fcc40ced1 = config.var_2341710fcc40ced1;
    level.br_multi_circle.var_fc672ac81c22b2af = config.var_fc672ac81c22b2af;
    level.br_multi_circle.splittimescale = config.splittimescale;
    level.br_multi_circle.mergetimescale = config.mergetimescale;
    level.br_multi_circle.innertimescale = config.innertimescale;
    logstring( "br_multi_circle::applyMultiCircleConfig -> name=" + config.name + " count=" + config.circlecount + " split=" + config.splitindex + " merge=" + config.mergeindex );
    
    if ( !isdefined( config.createfunc ) )
    {
        if ( isdefined( config.splitindex ) && isdefined( config.circleradii ) )
        {
            for ( i = 0; i < config.circleradii.size ; i++ )
            {
                level.br_level.br_circleradii[ config.splitindex + i ] = config.circleradii[ i ];
            }
        }
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x284aa089, Offset: 0x11c6
// Size: 0x32
function function_82cfc105f01b86ed()
{
    if ( level.br_multi_circle.circlecount > 1 && br_circle::function_cd50329a10799649() )
    {
        assertmsg( "<dev string:x94>" );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x38200edb, Offset: 0x1200
// Size: 0x7d
function function_f34344b1123f1dc0()
{
    if ( !level.br_multi_circle_enabled )
    {
        return;
    }
    
    function_a0c21c05d952dc1e();
    br_circle_util::logtotalmatchtime();
    config = level.br_multi_circle.config;
    
    if ( isdefined( config ) && isdefined( config.createfunc ) )
    {
        function_9eeb8d86e581b268();
        [[ config.createfunc ]]();
    }
    else
    {
        function_b8bba7914486922b();
    }
    
    level notify( #"calc_circle_centers" );
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x6ab528d0, Offset: 0x1285
// Size: 0x211
function function_ad210a54055486b9( var_e4b308e319a579e1 )
{
    if ( !level.br_multi_circle_enabled )
    {
        return;
    }
    
    function_de089a2a18f44505();
    function_e00a6f21f4f1fd81();
    level thread function_cfd243edbbc49780();
    
    if ( var_e4b308e319a579e1 && !br_gametypes::isfeatureenabled( #"circleearlystart" ) )
    {
        level waittill( #"infils_ready" );
    }
    
    if ( br_circle::function_cd50329a10799649() )
    {
        utility::flag_wait( "wztrain_anim_playing" );
    }
    
    if ( level.usegulag )
    {
        br_gulag::setupgulagtimer();
    }
    
    level thread function_f93ddc35478ce86();
    level thread function_ee943ec3c49a1c5f();
    level thread function_5820bd3df87afa08();
    level thread function_6e692f817772110d();
    level thread br_circle::stopcirclesatgameend();
    level.br_circle.circleinittime = gettime();
    flags::gameflaginit( "br_circle_init", 1 );
    
    if ( isdefined( level.br_level.br_circledelaytimes ) )
    {
        for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
        {
            function_fd10b0df6348f061( i );
            
            if ( isdefined( level.var_10a51e753c9ee204 ) )
            {
                foreach ( callback in level.var_10a51e753c9ee204 )
                {
                    [[ callback ]]();
                }
            }
        }
    }
    
    if ( isdefined( level.var_24ab63605cf6c1d1 ) )
    {
        foreach ( callback in level.var_24ab63605cf6c1d1 )
        {
            [[ callback ]]();
        }
    }
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x6ea73058, Offset: 0x149e
// Size: 0xd10
function function_fd10b0df6348f061( circleindex )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    
    /#
        br_circle::function_3a56eb4241432224();
    #/
    
    if ( utility::callsharedfunc( #"gametype", #"circletimer", circleindex ) )
    {
        return;
    }
    
    level.br_circle.starttime = gettime();
    level.br_circle.circleindex = circleindex;
    var_fade5044da9ae670 = circleindex == 0;
    var_b2827c0c6de965f2 = circleindex == level.br_level.br_circleclosetimes.size - 1;
    var_65369abccd6ca1e = circleindex + 1 == level.br_multi_circle.splitindex;
    var_5e466e184ea07a96 = circleindex + 1 == level.br_multi_circle.mergeindex;
    
    if ( var_b2827c0c6de965f2 )
    {
        level notify( #"br_final_circle" );
        utility::flag_set( "br_final_circle" );
        function_5c9ddcba6203ddee();
        function_d91ea0c341fce1d0();
    }
    
    function_b3038175405aa2e3();
    var_801afebad9f27629 = br_circle::function_9448d46c0e4395c1();
    
    if ( isdefined( var_801afebad9f27629 ) )
    {
        var_a30e8698313a3b9e = var_801afebad9f27629 - 1;
        var_f4f4ffd140a75c21 = var_801afebad9f27629 - 2;
        var_b8f9360342cad7e5 = getdvarint( @"hash_a72502fd7665f68a", 1 );
        
        if ( circleindex == var_f4f4ffd140a75c21 )
        {
            callback::callback( #"hash_f618f647217d4f3a" );
        }
        
        if ( circleindex == var_a30e8698313a3b9e )
        {
            callback::callback( #"hash_7014d0cf3f61f55a" );
        }
        
        if ( circleindex == var_801afebad9f27629 )
        {
            callback::callback( #"hash_c5624369ab1bdafc" );
        }
        
        var_480f42f20e17a313 = br_circle::function_a860b6cc615c4bdb( circleindex );
        var_5ffc67d4f8308ea7 = var_b8f9360342cad7e5 && circleindex == var_a30e8698313a3b9e;
    }
    else
    {
        var_480f42f20e17a313 = 0;
        var_5ffc67d4f8308ea7 = 0;
    }
    
    prewaittime = level.br_level.br_circledelaytimes[ circleindex ];
    closetime = level.br_level.br_circleclosetimes[ circleindex ];
    targetradius = level.br_level.br_circleradii[ circleindex + 1 ];
    
    if ( !isdefined( level.chokeholdcircle ) )
    {
        if ( br_circle::function_8bdcbb2e3fe350() )
        {
            setomnvar( "ui_br_circle_num", circleindex );
        }
        else
        {
            setomnvar( "ui_br_circle_num", circleindex + 1 );
        }
    }
    
    thread br_gulag::circletimer( circleindex );
    utility::callsharedfunc( #"gametype", #"hash_7b9ee3109b54b52b", circleindex );
    assert( isdefined( level.br_level.br_circleminimapradii[ circleindex ] ), "<dev string:xe2>" + circleindex + "<dev string:x109>" );
    level thread br_circle::br_lerp_minimap_zoom( circleindex );
    groundposcenter = level.br_level.br_circlecenters[ circleindex + 1 ];
    level.br_circle.centertarget = groundposcenter;
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    if ( br_circle::function_42b27c52d689e0bc() )
    {
        function_afac4e148fb1d554( multicirclecount, var_b2827c0c6de965f2 );
    }
    
    br_circle::function_6e7a2c1b9f799487();
    function_f4065e5c3f151601( circleindex );
    br_circle::cleanupoutercrates();
    function_199746fb92c3d85d();
    centertargets = [];
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        centertarget = level.br_multi_circle.circles[ i ].circlecenters[ circleindex + 1 ];
        centertargets[ i ] = centertarget;
        circleents = level.br_multi_circle.circles[ i ].entdata;
        
        if ( var_480f42f20e17a313 )
        {
            circleents.safeent.origin = ( circleents.dangerent.origin[ 0 ], circleents.dangerent.origin[ 1 ], targetradius );
            continue;
        }
        
        circleents.safeent.origin = ( centertarget[ 0 ], centertarget[ 1 ], targetradius );
    }
    
    if ( getdvarint( @"scr_br_multi_circle_hide_with_delay", 0 ) )
    {
        br_circle_util::function_ea3debeb59476d66( circleindex );
    }
    
    var_57febce8394b810d = ( var_65369abccd6ca1e || var_5e466e184ea07a96 ) && multicirclecount != 1;
    level thread br_circle::startuiclosetimer( prewaittime, var_fade5044da9ae670, var_b2827c0c6de965f2, circleindex, var_57febce8394b810d );
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        circleents = level.br_multi_circle.circles[ i ].entdata;
        circleents.dangerui.origin = circleents.dangerent.origin;
        
        if ( var_5ffc67d4f8308ea7 )
        {
            circleents.safeui.origin = ( circleents.dangerent.origin[ 0 ], circleents.dangerent.origin[ 1 ], targetradius );
            continue;
        }
        
        circleents.safeui.origin = circleents.safeent.origin;
    }
    
    wait 0.05;
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        circleents = level.br_multi_circle.circles[ i ].entdata;
        function_95fb7c198c90802d( circleents.dangerent, circleents.safeui, circleents.dangerui, prewaittime, var_b2827c0c6de965f2 );
    }
    
    br_circle_util::playcircleopendialog( circleindex, var_fade5044da9ae670 );
    
    if ( multicirclecount != 1 && !var_fade5044da9ae670 )
    {
        level thread function_fa6307cbd123195f( circleindex + 1, 1 );
    }
    
    if ( level.usegulag )
    {
        level thread br_gulag::transitioncircle( targetradius, prewaittime );
    }
    
    if ( br_circle::function_cd50329a10799649() && isdefined( level.br_level.var_105c73c4aed728af[ circleindex ] ) )
    {
        if ( utility::issharedfuncdefined( #"br_movingtrain", #"changecargotrainspeed" ) )
        {
            if ( var_fade5044da9ae670 && !level.var_4391838d26dd3baf )
            {
                br_circle::relocatecircles();
            }
            
            var_5227b9441bada4af = utility::getsharedfunc( #"br_movingtrain", #"changecargotrainspeed" );
            thread [[ var_5227b9441bada4af ]]( level.br_level.var_105c73c4aed728af[ circleindex ], level.br_level.var_45fd3e811cfba537 );
        }
        else
        {
            assertmsg( "<dev string:x162>" );
        }
    }
    
    params = { #circleindex:circleindex };
    params.var_fade5044da9ae670 = var_fade5044da9ae670;
    callback::callback( #"on_circle_set", params );
    level notify( #"br_circle_set" );
    
    if ( var_65369abccd6ca1e )
    {
        level notify( #"hash_93e5439a482402f2" );
    }
    else if ( var_5e466e184ea07a96 )
    {
        level notify( #"multi_circle_show_merge" );
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        circleents = level.br_multi_circle.circles[ i ].entdata;
        
        if ( var_480f42f20e17a313 )
        {
            level thread function_388c60788af2b0e9( circleents.dangerent );
            level thread function_388c60788af2b0e9( circleents.dangerui );
            level thread function_388c60788af2b0e9( circleents.safeent );
            level thread function_388c60788af2b0e9( circleents.safeui );
            continue;
        }
        
        if ( var_5ffc67d4f8308ea7 )
        {
            level thread function_388c60788af2b0e9( circleents.safeui );
        }
    }
    
    wait max( 0, prewaittime - 0.05 );
    level notify( #"hash_e9292579c66398d7" );
    
    if ( br_circle::function_42b27c52d689e0bc() )
    {
        function_afac4e148fb1d554( multicirclecount, var_b2827c0c6de965f2 );
    }
    
    br_circle::function_6e7a2c1b9f799487();
    
    if ( multicirclecount > 1 )
    {
        if ( circleindex + 1 == level.br_multi_circle.splitindex )
        {
            level notify( #"multi_circle_split" );
            br_analytics::function_623b979c5cc36014( gettime() );
        }
        else if ( circleindex + 1 == level.br_multi_circle.mergeindex )
        {
            [ playercounts, teamcounts ] = function_3e9affae58ab0556();
            br_analytics::function_407c9211584f9690( gettime(), playercounts, teamcounts );
        }
    }
    
    level notify( #"br_circle_started" );
    level.circleclosing = 1;
    params = { #closetime:closetime, #circleindex:circleindex };
    callback::callback( #"on_circle_started", params );
    
    if ( !level.var_b30d3cfccd6d0b0f )
    {
        setomnvar( "ui_hardpoint_timer", gettime() + int( closetime * 1000 ) );
    }
    
    br_circle_util::playcircleclosedialog( circleindex, var_b2827c0c6de965f2 );
    
    if ( multicirclecount != 1 )
    {
        level thread function_fa6307cbd123195f( circleindex + 1, 0 );
    }
    
    var_33f90e7904f6c7f0 = [];
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        circleents = level.br_multi_circle.circles[ i ].entdata;
        circleents.safeui.origin = circleents.safeent.origin;
        circleents.dangerui.origin = circleents.dangerent.origin;
        var_33f90e7904f6c7f0[ var_33f90e7904f6c7f0.size ] = circleents.dangerent br_circle::function_99d7e80e97d57e3d();
        function_d7d5b45d6631c960( circleents.dangerent, circleents.safeui, circleents.dangerui, circleents.safeent, int( closetime ), var_b2827c0c6de965f2 );
        
        if ( var_480f42f20e17a313 )
        {
            level thread function_388c60788af2b0e9( circleents.dangerent, targetradius, closetime );
            level thread function_388c60788af2b0e9( circleents.dangerui );
            level thread function_388c60788af2b0e9( circleents.safeent );
            level thread function_388c60788af2b0e9( circleents.safeui );
            continue;
        }
        
        var_65dd385e92a79762 = closetime - level.framedurationseconds;
        circleents.dangerent brcirclemoveto( centertargets[ i ][ 0 ], centertargets[ i ][ 1 ], targetradius, var_65dd385e92a79762 );
        
        if ( var_5ffc67d4f8308ea7 )
        {
            level thread function_388c60788af2b0e9( circleents.safeui );
        }
    }
    
    isplayingmusic = !level.br_circle.var_bdb61cc517e4942d && !( isdefined( level.isstandardsandbox ) && !level.isstandardsandbox );
    
    if ( isplayingmusic )
    {
        level thread music_br::function_fe87426d6e01e1a5( level.br_circle.circleindex, level.br_level.br_circleclosetimes.size, 0.4 );
    }
    
    wait closetime;
    level notify( #"hash_e9292579c66398d7" );
    level notify( #"br_circle_stopped" );
    
    if ( br_circle::function_42b27c52d689e0bc() )
    {
        function_afac4e148fb1d554( multicirclecount, var_b2827c0c6de965f2 );
    }
    
    br_circle::function_6e7a2c1b9f799487();
    
    if ( multicirclecount > 1 )
    {
        if ( var_65369abccd6ca1e )
        {
            level.br_multi_circle.issplit = 1;
            [ playercounts, teamcounts ] = function_3e9affae58ab0556();
            br_analytics::function_6eabc85117589f13( gettime(), playercounts, teamcounts );
        }
        else if ( var_5e466e184ea07a96 )
        {
            level.br_multi_circle.issplit = 0;
            level notify( #"multi_circle_merge" );
            br_analytics::function_fe227f5efacf59f7( gettime() );
        }
    }
    
    if ( br_circle::resetdangercircleorigin( circleindex ) )
    {
        if ( getdvarint( @"hash_e0a1364a76dd764e", 1 ) )
        {
            for ( i = 0; i < multicirclecount ; i++ )
            {
                circleents = level.br_multi_circle.circles[ i ].entdata;
                circleents.dangerent.origin = ( centertargets[ i ][ 0 ], centertargets[ i ][ 1 ], targetradius );
            }
        }
    }
    
    level.circleclosing = 0;
    callback::callback( #"br_circle_closed", { #centertarget:level.br_circle.centertarget, #closetime:closetime, #targetradius:targetradius, #initialradius:var_33f90e7904f6c7f0[ 0 ], #var_b2827c0c6de965f2:var_b2827c0c6de965f2, #circleindex:circleindex } );
    var_6b76927ceb6baf97 = 5;
    
    if ( var_6b76927ceb6baf97 > 0 && circleindex < var_6b76927ceb6baf97 )
    {
        rank::addglobalrankxpmultiplier( 1.2, "cirlceMult_" + string( circleindex ) );
        weaponrank::addweaponrankxpmultiplier( 1.2, "cirlceMult_" + string( circleindex ) );
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        br_circle::cleanupouterspawnclosets( centertargets[ i ], targetradius );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x184e707e, Offset: 0x21b6
// Size: 0x19
function function_5c9ddcba6203ddee()
{
    level.var_ea96217a33eb6457 = getdvarint( @"hash_45e63325bd676d5c", 0 );
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xd99de780, Offset: 0x21d7
// Size: 0xca
function function_d91ea0c341fce1d0()
{
    if ( !level.vehicle.aircraft )
    {
        return;
    }
    
    foreach ( vehicle in level.vehicle.aircraft )
    {
        if ( !vehicle || !isalive( vehicle ) )
        {
            continue;
        }
        
        vehicle vehicle_occupancy::disable_engine();
        vehicle dodamage( 99999, vehicle.origin, undefined, undefined );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x837f879e, Offset: 0x22a9
// Size: 0x63
function function_b3038175405aa2e3()
{
    var_5874cb17289c382d = getdvar( @"hash_439cce5f9d1de509", "brloot_health_adrenaline_saw,brloot_self_revive,brloot_self_revive_advanced,brloot_offhand_deconstation" );
    var_f3018484d12da4e8 = strtok( var_5874cb17289c382d, "," );
    
    if ( level.commonitem.var_d9665d85ee830b4c == 0 )
    {
        scriptable_group::function_cf6114f2daaf2924( var_f3018484d12da4e8 );
        return;
    }
    
    level thread scriptable_group_spatial::function_50e6dd6d052fdd09( var_f3018484d12da4e8 );
}

// Namespace br_multi_circle
// Params 3
// Checksum 0x75c57c69, Offset: 0x2314
// Size: 0x5e
function function_388c60788af2b0e9( circleent, targetradius, closetime )
{
    InvalidOpCode( 0x5e, isdefined( closetime ), isdefined( targetradius ) );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace br_multi_circle
// Params 2
// Checksum 0x45326680, Offset: 0x244b
// Size: 0x116
function function_afac4e148fb1d554( multicirclecount, var_b2827c0c6de965f2 )
{
    level endon( #"game_ended" );
    level.br_circle endon( #"circle_unpaused" );
    
    while ( true )
    {
        for ( i = 0; i < multicirclecount ; i++ )
        {
            circleents = level.br_multi_circle.circles[ i ].entdata;
            circleents.safeui.origin = circleents.safeent.origin;
            circleents.dangerui.origin = circleents.dangerent.origin;
            function_d7d5b45d6631c960( circleents.dangerent, circleents.safeui, circleents.dangerui, circleents.safeent, int( 16777 ), var_b2827c0c6de965f2 );
        }
        
        wait 1;
    }
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x70f1f4be, Offset: 0x2569
// Size: 0x74
function function_f93ddc35478ce86( extradelaytime )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    
    while ( level.br_circle.circleindex < 0 )
    {
        waitframe();
    }
    
    if ( br_gametypes::isfeatureenabled( #"circleearlystart" ) )
    {
        level waittill( #"infils_ready" );
    }
    
    if ( isdefined( extradelaytime ) )
    {
        wait extradelaytime;
    }
    
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_multi_circle
// Params 5
// Checksum 0x195e3ebe, Offset: 0x25e5
// Size: 0xa2
function function_95fb7c198c90802d( circleent, safeent, dangerent, duration, var_b2827c0c6de965f2 )
{
    circleduration = br_circle::function_bd089538e624a41a( duration );
    setomnvar( "ui_br_circle0_start_time", gettime() );
    setomnvar( "ui_br_circle0_duration", circleduration );
    
    if ( var_b2827c0c6de965f2 )
    {
        br_circle::_hidesafecircleui();
    }
    
    circleduration = br_circle::function_679d03d3bcd0aadc( duration );
    setomnvar( "ui_br_circle1_start_time", gettime() );
    setomnvar( "ui_br_circle1_duration", circleduration );
    circleent setbrcircleents( safeent, dangerent, dangerent );
    thread br_circle::updatecirclehide( duration );
}

// Namespace br_multi_circle
// Params 6
// Checksum 0x519597d5, Offset: 0x268f
// Size: 0xab
function function_d7d5b45d6631c960( circleent, safeent, var_e97c0f0f995ad2b4, var_75bc7d84703a4c6f, duration, var_b2827c0c6de965f2 )
{
    circleduration = br_circle::function_bd089538e624a41a( duration );
    setomnvar( "ui_br_circle0_start_time", gettime() );
    setomnvar( "ui_br_circle0_duration", circleduration );
    
    if ( var_b2827c0c6de965f2 )
    {
        br_circle::_hidesafecircleui();
    }
    
    circleduration = br_circle::function_679d03d3bcd0aadc( duration );
    setomnvar( "ui_br_circle1_start_time", gettime() );
    setomnvar( "ui_br_circle1_duration", circleduration );
    circleent setbrcircleents( safeent, var_e97c0f0f995ad2b4, var_75bc7d84703a4c6f );
    thread br_circle::updatecirclehide( duration );
}

// Namespace br_multi_circle
// Params 2
// Checksum 0xe785082b, Offset: 0x2742
// Size: 0x19b
function function_fa6307cbd123195f( circleindex, circleopen )
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    splashkey = undefined;
    var_165ee9f16da14bd = undefined;
    
    if ( circleindex == level.br_multi_circle.splitindex )
    {
        splashkey = "br_multi_circle_split";
        var_165ee9f16da14bd = 10;
        br_public::brleaderdialog( "circle_split" );
    }
    else if ( circleindex == level.br_multi_circle.mergeindex )
    {
        splashkey = "br_multi_circle_merge";
        var_165ee9f16da14bd = 11;
        br_public::brleaderdialog( "circle_merge" );
    }
    
    if ( !isdefined( splashkey ) )
    {
        return;
    }
    
    if ( circleopen )
    {
        splashkey += "_open";
    }
    else
    {
        splashkey += "_close";
    }
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) )
        {
            if ( !player br_public::isplayeringulag() )
            {
                player thread hud_message::showsplash( splashkey );
            }
            
            player setclientomnvar( "ui_br_circle_state", var_165ee9f16da14bd );
        }
    }
    
    if ( level.br_multi_circle.var_92d86ba4c5a7850c )
    {
        wait 2;
        setomnvar( "ui_minimap_pulse", 1 );
        wait 2;
        setomnvar( "ui_minimap_pulse", 0 );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xc362bc89, Offset: 0x28e5
// Size: 0x128
function function_bbe499b2e187b75()
{
    level.br_circle.dangercircleui.origin = br_circle::getdangercircleorigin() + ( 0, 0, br_circle::getdangercircleradius() );
    level.br_circle.dangercircleent.origin = br_circle::getdangercircleorigin() + ( 0, 0, br_circle::getdangercircleradius() );
    duration = getdvarint( @"hash_d8db46472f1970a3", 300 );
    setomnvar( "ui_br_circle0_start_time", 0 );
    setomnvar( "ui_br_circle1_start_time", gettime() );
    setomnvar( "ui_br_circle1_duration", int( duration * 1000 ) );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_br_infil_started", 0 );
        }
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x6f1b84c4, Offset: 0x2a15
// Size: 0xa0
function function_ee943ec3c49a1c5f()
{
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    level endon( #"hash_87ff3ffade90233e" );
    
    while ( level.br_circle.circleindex < 0 )
    {
        waitframe();
    }
    
    if ( br_gametypes::isfeatureenabled( #"circleearlystart" ) )
    {
        level waittill( #"infils_ready" );
    }
    
    level childthread function_54579273600f1eb6();
    
    if ( level.br_multi_circle.var_18fe6f8a036a96bc )
    {
        level childthread function_3773296a6aed8072();
        
        if ( getdvarint( @"activewarzone_enabled", 0 ) )
        {
            level childthread function_f0890306f3106723();
        }
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x4f86879c, Offset: 0x2abd
// Size: 0x55a
function function_54579273600f1eb6()
{
    var_16fa12dd34d85976 = br_circle::function_60fec44444cbd5d2();
    maxplayercount = getdvarint( @"party_maxplayers", 150 );
    var_57c823b74d21bfcb = 1 / level.framedurationseconds;
    var_bb83ea67c648abba = int( ceil( maxplayercount / var_57c823b74d21bfcb ) );
    damage_throttle = throttle::function_ac02df3f2e81cbab( "multi_circle_damage_players", var_bb83ea67c648abba, undefined, 1 );
    
    while ( true )
    {
        throttle::function_706ed379a3746335( damage_throttle );
        
        if ( isdefined( level.br_circle.dangercircleent ) )
        {
            damagetick = br_circle::function_592a1188adc2f827();
            
            if ( damagetick > 0 )
            {
                foreach ( player in level.players )
                {
                    throttle::function_1302aa73badc74f0( damage_throttle );
                    
                    if ( !isdefined( player.origin ) || !isalive( player ) )
                    {
                        continue;
                    }
                    
                    if ( player getinairpocket() )
                    {
                        continue;
                    }
                    
                    if ( br_gametypes::isfeatureenabled( #"circleearlystart" ) && player.plotarmor )
                    {
                        player br_circle::function_15ffd24619fcfc01();
                        continue;
                    }
                    
                    var_d3d5e207911ff294 = 0;
                    var_ab48f32caa0a08a0 = player.origin;
                    
                    if ( utility::issharedfuncdefined( #"gametype", #"hash_cb7f08e35dbda7cf" ) )
                    {
                        var_ab48f32caa0a08a0 = player utility::callsharedfunc( #"gametype", #"hash_cb7f08e35dbda7cf" );
                    }
                    
                    var_9cd84f966afffa4c = 0;
                    
                    if ( !br_gametypes::isfeaturedisabled( #"hash_5aaafc2b620d773c" ) )
                    {
                        var_9cd84f966afffa4c = br_circle_util::function_4c6afbf2b757376a( var_ab48f32caa0a08a0, 1 );
                    }
                    
                    if ( !br_circle_util::ispointinmulticircledanger( var_ab48f32caa0a08a0 ) || var_9cd84f966afffa4c )
                    {
                        if ( player br_circle::cancircledamageplayer( player, var_ab48f32caa0a08a0 ) )
                        {
                            var_d3d5e207911ff294 = 1;
                            player br_circle::function_37a534e2ce4843e();
                            
                            if ( getdvarint( @"scr_time_in_gas_damage_modifier_enabled", 0 ) == 1 )
                            {
                                modifieddamagetick = player br_circle::function_eaac348121cbeb8c( var_16fa12dd34d85976, damagetick );
                            }
                            else
                            {
                                modifieddamagetick = damagetick;
                            }
                            
                            /#
                                if ( level.br_multi_circle.damagedebug )
                                {
                                    player iprintln( "<dev string:x1fc>" + "<dev string:x205>" + modifieddamagetick + "<dev string:x208>" );
                                }
                            #/
                            
                            if ( getdvarint( @"hash_5854369d7b98c88b", 0 ) )
                            {
                                player setclientomnvar( "ui_br_multi_circle_player_inside", 1 );
                            }
                            
                            gasmaskdamage = modifieddamagetick;
                            
                            if ( isdefined( level.var_8939aaad719c1058 ) && isdefined( level.var_a497e1f1038f9d84 ) && level.br_circle.circleindex <= level.var_8939aaad719c1058 )
                            {
                                gasmaskdamage *= level.var_a497e1f1038f9d84;
                            }
                            
                            var_2750d2ea26afa177 = 0;
                            
                            if ( gasmask::function_a062bf98847b605a( player ) )
                            {
                                var_2750d2ea26afa177 = 1;
                                
                                if ( gasmask::function_e949a578c3db30d( player ) )
                                {
                                    if ( player.var_ccaedd955fabd3b4 )
                                    {
                                        player notify( #"gasmask_buffer_reset" );
                                    }
                                    else if ( level.var_48fc5a6351d1343c > 0 )
                                    {
                                        player.var_ccaedd955fabd3b4 = 1;
                                        player thread br_pickups::function_cde7bb308b1cf12f();
                                    }
                                }
                                
                                if ( player.var_ccaedd955fabd3b4 )
                                {
                                    if ( !player.gasmaskequipped )
                                    {
                                        player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                                    }
                                    
                                    player gasmask::processdamage( gasmaskdamage );
                                }
                                else if ( player.gasmaskhealth <= 0 )
                                {
                                    if ( !level.var_c7bf4af6240a235 )
                                    {
                                        player br_pickups::function_5375ae93bfe708df();
                                        player br_pickups::function_219547e563ff9527();
                                        player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                    }
                                }
                                else
                                {
                                    if ( !level.var_c7bf4af6240a235 )
                                    {
                                        player br_pickups::gasmaskon( "br_multi_circle" );
                                    }
                                    
                                    player gasmask::processdamage( gasmaskdamage );
                                }
                            }
                            else
                            {
                                player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                            }
                            
                            if ( var_2750d2ea26afa177 )
                            {
                                player br_circle::function_a1994b835c9c1590();
                            }
                            else
                            {
                                player br_circle::function_f7798f06003358e2();
                            }
                            
                            if ( common_inventory::function_5c64d2b24a8c3e18() )
                            {
                                player common_inventory::function_6525f6bbec67b15e( level.var_6a8b6f867f6e7ad4, gasmaskdamage );
                            }
                        }
                        else
                        {
                            player br_circle::function_15ffd24619fcfc01();
                            player br_circle::function_7877e6f8368fbec2();
                        }
                    }
                    else
                    {
                        player br_circle::function_15ffd24619fcfc01();
                        player br_circle::function_7877e6f8368fbec2();
                        
                        if ( gasmask::hasgasmask( player ) )
                        {
                            if ( gasmask::function_e949a578c3db30d( player ) )
                            {
                                if ( player.var_ccaedd955fabd3b4 )
                                {
                                    player notify( #"gasmask_buffer_reset" );
                                }
                                else if ( level.var_48fc5a6351d1343c > 0 )
                                {
                                    player.var_ccaedd955fabd3b4 = 1;
                                    player thread br_pickups::function_cde7bb308b1cf12f();
                                }
                            }
                            
                            if ( player.var_ccaedd955fabd3b4 )
                            {
                                continue;
                            }
                            else if ( !level.var_c7bf4af6240a235 )
                            {
                                if ( player.gasmaskhealth <= 0 )
                                {
                                    player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                    player br_pickups::function_5375ae93bfe708df();
                                }
                                else
                                {
                                    player br_pickups::gasmaskoff( "br_multi_circle" );
                                }
                            }
                        }
                        
                        if ( getdvarint( @"hash_5854369d7b98c88b", 0 ) )
                        {
                            player setclientomnvar( "ui_br_multi_circle_player_inside", 0 );
                        }
                    }
                    
                    if ( isbrgamemode() )
                    {
                        player br_circle::updateindangercirclestate( var_d3d5e207911ff294 );
                    }
                }
            }
        }
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x2439faa1, Offset: 0x301f
// Size: 0x27
function function_3773296a6aed8072()
{
    wait 0.25;
    
    while ( true )
    {
        if ( !br_circle_util::function_32ead8efde5943f5() )
        {
            br_circle_util::function_cfd14b927e016846();
        }
        
        wait 1;
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x3ae43a33, Offset: 0x304e
// Size: 0x2a
function function_f0890306f3106723()
{
    wait 0.5;
    
    while ( true )
    {
        br_activewarzone::function_82e8374a0533d4de();
        wait 1;
        br_activewarzone::function_8dc9574aa63ad64b();
        wait 1;
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x9847d5b6, Offset: 0x3080
// Size: 0x1a3
function function_5820bd3df87afa08()
{
    if ( br_circle_util::function_62474efd1bbaa12d() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    level endon( #"hash_87ff3ffade90233e" );
    
    while ( level.br_circle.circleindex < 0 )
    {
        waitframe();
    }
    
    if ( br_gametypes::isfeatureenabled( #"circleearlystart" ) )
    {
        level waittill( #"infils_ready" );
    }
    
    while ( true )
    {
        wait 1;
        
        if ( isdefined( level.var_af97f7342b1418a9 ) )
        {
            foreach ( var_51b8d621f112d544, var_a55cae7e74790f0e in level.var_af97f7342b1418a9 )
            {
                var_a55cae7e74790f0e = function_5713d46873b29625( var_a55cae7e74790f0e );
                
                foreach ( hiddenobject in var_a55cae7e74790f0e )
                {
                    safetime = br_circle_util::function_7d356b8881fbc2ca( hiddenobject.origin );
                    
                    if ( safetime > 0 )
                    {
                        utility::delaythread( safetime, &function_911f6b28800d893a, hiddenobject, var_51b8d621f112d544 );
                    }
                }
                
                level.var_af97f7342b1418a9[ var_51b8d621f112d544 ] = [];
            }
        }
    }
}

// Namespace br_multi_circle
// Params 2
// Checksum 0xe1815d9d, Offset: 0x322b
// Size: 0x51
function function_911f6b28800d893a( obj, var_51b8d621f112d544 )
{
    if ( !isdefined( obj ) )
    {
        return;
    }
    
    var_bbecc5e5ad46aa13 = undefined;
    
    if ( isdefined( level.var_3c9c22b4e483957 ) )
    {
        var_bbecc5e5ad46aa13 = level.var_3c9c22b4e483957[ var_51b8d621f112d544 ];
    }
    
    if ( isdefined( var_bbecc5e5ad46aa13 ) )
    {
        [[ var_bbecc5e5ad46aa13 ]]( obj );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x6c9de982, Offset: 0x3284
// Size: 0xb4
function function_199746fb92c3d85d()
{
    if ( !isdefined( level.br_pickups ) )
    {
        return;
    }
    
    foreach ( crate in level.br_crates )
    {
        if ( isdefined( crate ) && !br_circle_util::function_7dba95e6f0e08799( crate.origin ) )
        {
            level.var_e091695dc2372402[ level.var_e091695dc2372402.size ] = crate;
        }
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xa3f70626, Offset: 0x3340
// Size: 0x10
function function_6e692f817772110d()
{
    function_e37d36cc097ed84();
    function_76c9461519b7c1c8();
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x82fd49ed, Offset: 0x3358
// Size: 0x303
function function_e37d36cc097ed84()
{
    if ( level.br_multi_circle.circlecount == 1 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_3250cdab1dfb0ac4", 1 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    level endon( #"multi_circle_merge" );
    level waittill( #"multi_circle_split" );
    overlays = [];
    
    if ( getdvarint( @"hash_37133e3ee3beae30", 0 ) )
    {
        overlays = function_481cb87ab4bf1296();
    }
    
    safecirclecount = getdvarint( @"hash_db6f837f9260ec08", 0 );
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    while ( true )
    {
        circleplayercount = [];
        var_e2d4d720d68ba987 = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            circleplayercount[ i ] = 0;
            var_e2d4d720d68ba987[ i ] = [];
        }
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player br_public::isplayeringulag() )
            {
                continue;
            }
            
            var_ac6eafc7bc8282fb = 0;
            
            for ( i = 0; i < multicirclecount ; i++ )
            {
                inside = 0;
                
                if ( safecirclecount )
                {
                    inside = br_circle_util::function_4266883c02ceeb35( player.origin, i );
                }
                else
                {
                    inside = br_circle_util::function_b957f8171f4facfb( player.origin, i );
                }
                
                if ( inside )
                {
                    var_ac6eafc7bc8282fb |= 1 << i;
                    circleplayercount[ i ]++;
                    
                    if ( isdefined( player.team ) )
                    {
                        var_e2d4d720d68ba987[ i ][ player.team ] = player.team;
                    }
                }
            }
            
            player setclientomnvar( "ui_br_multi_circle_player_data", var_ac6eafc7bc8282fb );
        }
        
        playercountpacked = 0;
        teamcountpacked = 0;
        circlecount = int( min( multicirclecount, 4 ) );
        
        for ( i = 0; i < circlecount ; i++ )
        {
            playercountpacked |= circleplayercount[ i ] << i * 8;
            teamcountpacked |= var_e2d4d720d68ba987[ i ].size << i * 8;
        }
        
        setomnvar( "ui_br_multi_circle_player_count", playercountpacked );
        setomnvar( "ui_br_multi_circle_team_count", teamcountpacked );
        
        for ( i = 0; i < circlecount ; i++ )
        {
            if ( var_e2d4d720d68ba987[ i ].size == 1 )
            {
                function_73491d8748bde470( i, utility::array_get_first_item( var_e2d4d720d68ba987[ i ] ) );
            }
            
            if ( isdefined( overlays[ i ] ) )
            {
                overlay = overlays[ i ];
                value = circleplayercount[ i ];
                
                if ( getdvarint( @"hash_7042bbd75f3ffc34", 1 ) )
                {
                    value = var_e2d4d720d68ba987[ i ].size;
                }
                
                overlay setvalue( value );
            }
        }
        
        wait 1;
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x2e97e16f, Offset: 0x3663
// Size: 0x18
function function_76c9461519b7c1c8()
{
    setomnvar( "ui_br_multi_circle_player_count", 0 );
    setomnvar( "ui_br_multi_circle_team_count", 0 );
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xe11efe8a, Offset: 0x3683
// Size: 0x183
function function_3e9affae58ab0556()
{
    circleplayercount = [];
    var_e2d4d720d68ba987 = [];
    circleteamcount = [];
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        circleplayercount[ i ] = 0;
        var_e2d4d720d68ba987[ i ] = [];
        circleteamcount[ i ] = 0;
    }
    
    for ( i = multicirclecount; i < 4 ; i++ )
    {
        circleplayercount[ i ] = -1;
        circleteamcount[ i ] = -1;
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player br_public::isplayeringulag() )
        {
            continue;
        }
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            if ( br_circle_util::function_b957f8171f4facfb( player.origin, i ) )
            {
                circleplayercount[ i ]++;
                
                if ( isdefined( player.team ) )
                {
                    var_e2d4d720d68ba987[ i ][ player.team ] = player.team;
                }
            }
        }
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        circleteamcount[ i ] = var_e2d4d720d68ba987[ i ].size;
    }
    
    return [ circleplayercount, circleteamcount ];
}

// Namespace br_multi_circle
// Params 2
// Checksum 0x5770e8e8, Offset: 0x380f
// Size: 0xa8
function function_73491d8748bde470( index, team )
{
    if ( !getdvarint( @"scr_br_multi_circle_winner", 1 ) )
    {
        return;
    }
    
    if ( !level.br_multi_circle.issplit )
    {
        return;
    }
    
    circle = level.br_multi_circle.circles[ index ];
    
    if ( !isdefined( circle ) || circle.won )
    {
        return;
    }
    
    circle.won = 1;
    function_f64ff24af0972778( team );
    function_b758690e8acae874( team );
    br_public::brleaderdialogteam( "circle_victory", team );
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x5c2fe36c, Offset: 0x38bf
// Size: 0xaf
function function_f64ff24af0972778( team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( isalive( player ) && !isbot( player ) && !player br_public::isplayeringulag() )
        {
            player thread hud_message::showsplash( "br_multi_circle_winner" );
        }
    }
}

// Namespace br_multi_circle
// Params 1
// Checksum 0x3ecb73ab, Offset: 0x3976
// Size: 0xa4
function function_b758690e8acae874( team )
{
    rewardcash = getdvarint( @"scr_br_multi_circle_winner_plunder", 500 );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player br_plunder::playerplunderpickup( rewardcash );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xe26fe364, Offset: 0x3a22
// Size: 0x157
function function_cfd243edbbc49780()
{
    if ( !getdvarint( @"scr_br_multi_circle_objectives", 1 ) || level.br_multi_circle.circlecount == 1 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"br_ending_start" );
    level endon( #"multi_circle_show_merge" );
    
    if ( level.br_multi_circle.splitindex != 1 )
    {
        level waittill( #"hash_93e5439a482402f2" );
    }
    
    function_195b7bf01fd66207();
    level thread function_a0250a0eba92899d();
    
    while ( true )
    {
        multicirclecount = br_circle_util::function_7c3401c47d505872();
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            objid = level.br_multi_circle.circles[ i ].objid;
            pos = level.br_multi_circle.circles[ i ].entdata.safeent.origin;
            objpos = br_public::droptogroundmultitrace( ( pos[ 0 ], pos[ 1 ], 0 ) );
            objidpoolmanager::update_objective_position( objid, objpos );
        }
        
        level waittill( #"br_circle_set" );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xcff35ebd, Offset: 0x3b81
// Size: 0x15d
function function_195b7bf01fd66207()
{
    objectiveids = [ 20, 21, 22, 23 ];
    objectiveicons = [ "icon_waypoint_circle_a", "icon_waypoint_circle_b", "icon_waypoint_circle_c", "icon_waypoint_circle_d" ];
    objectivelabels = [ &"mp_br_ingame/multi_circle_label_alpha", &"mp_br_ingame/multi_circle_label_bravo", &"mp_br_ingame/multi_circle_label_charlie", &"mp_br_ingame/multi_circle_label_delta" ];
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        objid = objidpoolmanager::requestobjectiveid( 1 );
        
        if ( objid != -1 )
        {
            objidpoolmanager::objective_add_objective( objid, "active", ( 0, 0, 0 ), objectiveicons[ i ], "icon_regular" );
            objidpoolmanager::update_objective_objectiveid( objid, objectiveids[ i ] );
            objidpoolmanager::update_objective_setbackground( objid, 1 );
            function_3759e26b1b750f5( objid, function_aa4ad5b012d66046() );
            objective_setlabel( objid, objectivelabels[ i ] );
            objidpoolmanager::objective_playermask_showtoall( objid );
            objective_sethideelevation( objid, 1 );
            level.br_multi_circle.circles[ i ].objid = objid;
        }
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x53d0f25a, Offset: 0x3ce6
// Size: 0x9c
function function_a0250a0eba92899d()
{
    level utility::waittill_any( "game_ended", "br_ending_start", "multi_circle_show_merge" );
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        objid = level.br_multi_circle.circles[ i ].objid;
        
        if ( isdefined( objid ) )
        {
            objidpoolmanager::returnobjectiveid( objid );
            level.br_multi_circle.circles[ i ].objid = undefined;
        }
    }
}

// Namespace br_multi_circle
// Params 1
// Checksum 0xa2ab5677, Offset: 0x3d8a
// Size: 0x5b
function function_b8bba7914486922b( isrelocate )
{
    function_fd60b18340556a80( isrelocate );
    maxattempts = getdvarint( @"scr_br_multi_circle_reroll", 100 );
    
    for ( attempts = 0; attempts < maxattempts && function_f6eca16970073991() ; attempts++ )
    {
        function_fd60b18340556a80( isrelocate );
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x9b8b5ce7, Offset: 0x3ded
// Size: 0x1e9
function function_a0c21c05d952dc1e()
{
    if ( br_circle_util::function_7c3401c47d505872() <= 1 )
    {
        return;
    }
    
    splittimeindex = level.br_multi_circle.splitindex - 1;
    
    if ( splittimeindex >= 0 && splittimeindex < level.br_level.br_circleclosetimes.size )
    {
        level.br_level.br_circleclosetimes[ splittimeindex ] *= level.br_multi_circle.splittimescale;
    }
    
    var_fb5a0b8dc2ed4271 = level.br_multi_circle.mergeindex - 1;
    
    if ( var_fb5a0b8dc2ed4271 >= 0 && var_fb5a0b8dc2ed4271 < level.br_level.br_circleclosetimes.size )
    {
        level.br_level.br_circleclosetimes[ var_fb5a0b8dc2ed4271 ] *= level.br_multi_circle.mergetimescale;
    }
    
    for ( i = splittimeindex + 1; i < var_fb5a0b8dc2ed4271 ; i++ )
    {
        if ( i < level.br_level.br_circleclosetimes.size )
        {
            level.br_level.br_circleclosetimes[ i ] *= level.br_multi_circle.innertimescale;
        }
        
        if ( i < level.br_level.br_circledelaytimes.size )
        {
            level.br_level.br_circledelaytimes[ i ] *= level.br_multi_circle.innertimescale;
        }
    }
}

// Namespace br_multi_circle
// Params 1, eflags: 0x4
// Checksum 0x8dfe5692, Offset: 0x3fde
// Size: 0x6d2
function private function_fd60b18340556a80( isrelocate )
{
    if ( !isdefined( level.br_level.br_circlecenters ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_multi_circle ) )
    {
        return;
    }
    
    if ( !isrelocate )
    {
        level.br_multi_circle.circles = [];
    }
    
    var_f5661efe10a6d8d5 = getdvarint( @"hash_67a8c844bad5a45b", 0 );
    
    if ( !var_f5661efe10a6d8d5 && br_gametypes::isfeatureenabled( #"circlesnaptonavmesh" ) )
    {
        var_f5661efe10a6d8d5 = 1;
    }
    
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    if ( !isrelocate )
    {
        for ( i = 0; i < multicirclecount ; i++ )
        {
            level.br_multi_circle.circles[ i ] = spawnstruct();
            level.br_multi_circle.circles[ i ].circlecenters = [];
        }
    }
    
    splitindex = level.br_multi_circle.splitindex;
    mergeindex = level.br_multi_circle.mergeindex;
    splitcount = mergeindex - splitindex;
    
    if ( level.br_multi_circle.circlecount == 1 )
    {
        splitindex = level.br_level.br_circlecenters.size;
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        for ( j = 0; j < splitindex ; j++ )
        {
            level.br_multi_circle.circles[ i ].circlecenters[ j ] = level.br_level.br_circlecenters[ j ];
        }
    }
    
    if ( level.br_multi_circle.circlecount == 1 )
    {
        return;
    }
    
    splitangle = level.br_multi_circle.splitangle;
    angleoffset = 360 / multicirclecount;
    splitoffset = getdvarfloat( @"scr_br_multi_circle_split_offset", 0 );
    
    if ( getdvarint( @"hash_79b501617ac641bd", 1 ) )
    {
        splitoffset += randomfloat( angleoffset ) - angleoffset / 2;
    }
    
    splitpct = undefined;
    var_2341710fcc40ced1 = level.br_multi_circle.var_2341710fcc40ced1;
    var_fc672ac81c22b2af = level.br_multi_circle.var_fc672ac81c22b2af;
    originindex = splitindex;
    
    if ( level.br_multi_circle.var_55d52b10d06cb653 )
    {
        originindex--;
    }
    
    origin = level.br_level.br_circlecenters[ originindex ];
    radius = level.br_level.br_circleradii[ originindex ];
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        splitorigin = origin;
        theta = i * angleoffset + splitoffset;
        
        if ( level.br_multi_circle.var_ecfc0115dc62c2b1 )
        {
            splitorigin = br_circle::getrandompointinboundscircle( origin, radius, var_2341710fcc40ced1, var_fc672ac81c22b2af, 1, var_f5661efe10a6d8d5, 1, undefined, theta, theta );
        }
        else
        {
            thetaoffset = randomfloat( splitangle ) - splitangle / 2;
            
            if ( !isdefined( splitpct ) || !level.br_multi_circle.var_9e11935280811e82 )
            {
                splitpct = var_2341710fcc40ced1 + randomfloat( var_fc672ac81c22b2af - var_2341710fcc40ced1 );
            }
            
            theta += thetaoffset;
            originoffset = ( radius * splitpct * cos( theta ), radius * splitpct * sin( theta ), 0 );
            splitorigin = origin + originoffset;
        }
        
        level.br_multi_circle.circles[ i ].circlecenters[ splitindex ] = splitorigin;
    }
    
    if ( splitcount > 1 )
    {
        slicestart = splitindex;
        sliceend = splitindex + splitcount;
        circleradii = utility::array_slice( level.br_level.br_circleradii, slicestart, sliceend );
        circleclosetimes = utility::array_slice( level.br_level.br_circleclosetimes, slicestart, sliceend );
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            origin = level.br_multi_circle.circles[ i ].circlecenters[ splitindex ];
            circlecenters = br_circle_util::calcsafecirclecenters( origin, circleradii, circleclosetimes, 1 );
            
            if ( isdefined( circlecenters ) )
            {
                for ( j = 1; j < circlecenters.size ; j++ )
                {
                    newindex = level.br_multi_circle.circles[ i ].circlecenters.size;
                    level.br_multi_circle.circles[ i ].circlecenters[ newindex ] = circlecenters[ j ];
                }
            }
        }
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        for ( j = mergeindex; j < level.br_level.br_circlecenters.size ; j++ )
        {
            newindex = level.br_multi_circle.circles[ i ].circlecenters.size;
            level.br_multi_circle.circles[ i ].circlecenters[ newindex ] = level.br_level.br_circlecenters[ j ];
        }
    }
    
    if ( getdvarint( @"hash_4b45bb60c8b9d7a", 0 ) > 0 )
    {
        movingcirclecount = level.br_level.br_movingcirclecount;
        var_f5661efe10a6d8d5 = getdvarint( @"hash_67a8c844bad5a45b", 0 );
        
        if ( !var_f5661efe10a6d8d5 && br_gametypes::isfeatureenabled( #"circlesnaptonavmesh" ) )
        {
            var_f5661efe10a6d8d5 = 1;
        }
        
        slicestart = mergeindex;
        sliceend = mergeindex + movingcirclecount + 1;
        circlecenters = utility::array_slice( level.br_level.br_circlecenters, slicestart, sliceend );
        circleradii = utility::array_slice( level.br_level.br_circleradii, slicestart, sliceend );
        movingcircles = br_circle_util::function_8bf41372019ee411( movingcirclecount, circlecenters, circleradii, var_f5661efe10a6d8d5 );
        
        if ( isdefined( movingcircles ) )
        {
            for ( i = 0; i < multicirclecount ; i++ )
            {
                for ( j = 0; j < movingcircles.size ; j++ )
                {
                    newindex = level.br_multi_circle.circles[ i ].circlecenters.size;
                    level.br_multi_circle.circles[ i ].circlecenters[ newindex ] = movingcircles[ j ];
                }
            }
        }
    }
}

// Namespace br_multi_circle
// Params 0, eflags: 0x4
// Checksum 0x25f3f439, Offset: 0x46b8
// Size: 0x26a, Type: bool
function private function_f6eca16970073991()
{
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    if ( multicirclecount <= 1 )
    {
        return false;
    }
    
    var_b9e9038886cd8ec9 = getdvarfloat( @"hash_6c976cff653fe181", 0.5 );
    var_6eb7f72b93b3c85d = getdvarfloat( @"hash_2d35a2046d6899a9", 0.5 );
    
    for ( c = level.br_multi_circle.splitindex; c < level.br_multi_circle.mergeindex ; c++ )
    {
        radius = level.br_level.br_circleradii[ c ];
        
        if ( radius == 0 )
        {
            return false;
        }
        
        for ( i = 0; i < multicirclecount - 1 ; i++ )
        {
            for ( j = i + 1; j < multicirclecount ; j++ )
            {
                origina = level.br_multi_circle.circles[ i ].circlecenters[ c ];
                originb = level.br_multi_circle.circles[ j ].circlecenters[ c ];
                dist = distance2d( origina, originb );
                pct = dist / 2 * radius;
                
                if ( pct < var_b9e9038886cd8ec9 )
                {
                    return true;
                }
            }
        }
    }
    
    index = level.br_multi_circle.mergeindex - 1;
    
    if ( index < 1 )
    {
        return false;
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        origina = level.br_multi_circle.circles[ i ].circlecenters[ index ];
        originb = level.br_multi_circle.circles[ i ].circlecenters[ index + 1 ];
        radiusa = level.br_level.br_circleradii[ index ];
        radiusb = level.br_level.br_circleradii[ index + 1 ];
        
        if ( radiusa + radiusb == 0 )
        {
            return false;
        }
        
        dist = distance2d( origina, originb );
        pct = dist / ( radiusa + radiusb );
        
        if ( pct < var_6eb7f72b93b3c85d )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_multi_circle
// Params 0
// Checksum 0xeb084e91, Offset: 0x492b
// Size: 0x2a4
function function_de089a2a18f44505()
{
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        var_2edfb6e2080cc053 = level.br_multi_circle.circles[ i ].circlecenters[ 1 ];
        var_26b83da5cb1b5065 = level.br_level.br_circlecenters[ 0 ];
        safecircleent = spawn( "script_model", ( var_2edfb6e2080cc053[ 0 ], var_2edfb6e2080cc053[ 1 ], level.br_level.br_circleradii[ 1 ] ) );
        safecircleui = spawn( "script_model", safecircleent.origin );
        dangercircleent = spawnbrcircle( var_26b83da5cb1b5065[ 0 ], var_26b83da5cb1b5065[ 1 ], level.br_level.br_circleradii[ 0 ] );
        dangercircleui = spawn( "script_model", dangercircleent.origin );
        circleents = spawnstruct();
        circleents.safeent = safecircleent;
        circleents.safeui = safecircleui;
        circleents.dangerent = dangercircleent;
        circleents.dangerui = dangercircleui;
        level.br_multi_circle.circles[ i ].entdata = circleents;
        dangercircleent thread br_circle::dangercircleenthidefromplayers();
        dangercircleent setbrcircleents( safecircleent, dangercircleui, dangercircleui );
    }
    
    circleents = level.br_multi_circle.circles[ 0 ].entdata;
    level.br_circle.safecircleent = circleents.safeent;
    level.br_circle.safecircleui = circleents.safeui;
    level.br_circle.dangercircleent = circleents.dangerent;
    level.br_circle.dangercircleui = circleents.dangerui;
    level.br_circle.safecircleent.hidden = 0;
    level.br_circle.safecircleui.hidden = 0;
    level.br_circle.dangercircleent.hidden = 0;
    level.br_circle.dangercircleui.hidden = 0;
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x7c8cda25, Offset: 0x4bd7
// Size: 0x7e
function function_9eeb8d86e581b268()
{
    level.br_multi_circle.circles = [];
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        level.br_multi_circle.circles[ i ] = spawnstruct();
        level.br_multi_circle.circles[ i ].circlecenters = [];
    }
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x624d9481, Offset: 0x4c5d
// Size: 0xb3
function function_e00a6f21f4f1fd81()
{
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleui ) ) )
    {
        return;
    }
    
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        entdata = level.br_multi_circle.circles[ i ].entdata;
        
        if ( isdefined( entdata ) && isdefined( entdata.dangerent ) )
        {
            entdata.dangerent show();
            entdata.dangerent hide( 1 );
        }
    }
}

/#

    // Namespace br_multi_circle
    // Params 0
    // Checksum 0xd18f1026, Offset: 0x4d18
    // Size: 0x45, Type: dev
    function function_23e719f866c35f1d()
    {
        level notify( #"hash_d4bada988c582e57" );
        multicirclecount = br_circle_util::function_7c3401c47d505872();
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            level thread function_d7b471bd6367fcdc( i );
        }
    }

    // Namespace br_multi_circle
    // Params 1
    // Checksum 0xfbb761e3, Offset: 0x4d65
    // Size: 0x33c, Type: dev
    function function_d7b471bd6367fcdc( circlenum )
    {
        if ( !level.br_multi_circle_enabled )
        {
            return;
        }
        
        circle = level.br_multi_circle.circles[ circlenum ];
        
        if ( !isdefined( circle ) )
        {
            return;
        }
        
        level endon( #"hash_d4bada988c582e57" );
        colors = [ ( 1, 1, 1 ), ( 0.764706, 0.25098, 0.129412 ), ( 0.380392, 0.647059, 0.309804 ), ( 0.427451, 0.811765, 0.964706 ), ( 0.929412, 0.796078, 0.337255 ), ( 1, 0.0431373, 0.843137 ), ( 0.380392, 0.278431, 0.517647 ), ( 1, 0.658824, 0.647059 ), ( 0.380392, 0.780392, 0.803922 ), ( 1, 1, 1 ), ( 0.501961, 0.501961, 0.501961 ), ( 0.898039, 0.6, 0 ), ( 0, 0, 0 ), ( 0.929412, 0.796078, 0.337255 ) ];
        firstcolorindex = 1;
        lastcolorindex = 1;
        skipcolor = [];
        skipcolor[ firstcolorindex ] = 1;
        skipcolor[ lastcolorindex ] = 1;
        skipcolor[ 0 ] = 1;
        skipcolor[ 9 ] = 1;
        skipcolor[ 10 ] = 1;
        skipcolor[ 12 ] = 1;
        skipcolor[ 13 ] = 1;
        thread function_103bd7de3cf1143a();
        test_colors = [ "<dev string:x20b>", "<dev string:x212>", "<dev string:x217>" ];
        
        for ( spawnents = 1; true ; spawnents = 0 )
        {
            waitframe();
            colorindex = 0;
            
            for ( circleindex = 0; circleindex < circle.circlecenters.size ; circleindex++ )
            {
                radius = level.br_level.br_circleradii[ circleindex ];
                center = circle.circlecenters[ circleindex ];
                
                if ( circleindex == 0 )
                {
                    currentcolorindex = firstcolorindex;
                }
                else if ( circleindex == circle.circlecenters.size - 1 )
                {
                    currentcolorindex = lastcolorindex;
                }
                else
                {
                    while ( skipcolor[ colorindex ] )
                    {
                        colorindex = ( colorindex + 1 ) % colors.size;
                    }
                    
                    currentcolorindex = colorindex;
                    colorindex = ( colorindex + 1 ) % colors.size;
                }
                
                color = colors[ currentcolorindex ];
                utility::draw_circle( center, max( 5, radius ), color, 1, 0, 1 );
                print3d( center, "<dev string:x21e>" + circleindex + "<dev string:x221>" + radius, color, 1, 1, 1, 1 );
                
                if ( spawnents )
                {
                    circleent = spawnstruct();
                    circleent game_utility::questcircle_create( "<dev string:x226>" + test_colors[ circleindex % test_colors.size ], center, max( 50, radius ) );
                    circleent game_utility::questcircle_showtoall();
                    circleent thread br_circle::function_c9108882f07c55a9();
                }
            }
        }
    }

    // Namespace br_multi_circle
    // Params 0
    // Checksum 0x1636bea, Offset: 0x50a9
    // Size: 0x25, Type: dev
    function function_103bd7de3cf1143a()
    {
        level endon( #"hash_d4bada988c582e57" );
        level waittill( #"calc_circle_centers" );
        thread function_23e719f866c35f1d();
    }

    // Namespace br_multi_circle
    // Params 0
    // Checksum 0x3d1e5e80, Offset: 0x50d6
    // Size: 0x28d, Type: dev
    function function_6a26e18509ebc65b()
    {
        level notify( #"hash_485ac4dd2dab80df" );
        
        if ( !level.br_multi_circle_enabled )
        {
            return;
        }
        
        level endon( #"hash_485ac4dd2dab80df" );
        var_9dc2de549a844a66 = "<dev string:x232>";
        var_d8887acaaaf92cc1 = "<dev string:x252>";
        trainicon = "<dev string:x268>";
        createmarkerfunc = utility::getsharedfunc( #"game", #"requestobjectiveid" );
        multicirclecount = br_circle_util::function_7c3401c47d505872();
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            circle = level.br_multi_circle.circles[ i ];
            
            if ( !isdefined( circle ) )
            {
                return;
            }
            
            for ( circleindex = 0; circleindex < circle.circlecenters.size ; circleindex++ )
            {
                center = circle.circlecenters[ circleindex ];
                markerid = [[ createmarkerfunc ]]( 99 );
                objective_state( markerid, "<dev string:x287>" );
                objective_icon( markerid, var_9dc2de549a844a66 );
                objective_position( markerid, center );
                level thread function_310872fbaa64f368( markerid );
            }
        }
        
        var_d81f8f3b9d5bed6b = [[ createmarkerfunc ]]( 99 );
        level thread function_310872fbaa64f368( var_d81f8f3b9d5bed6b );
        
        if ( level.br_level.var_7a7b3389cf47133f )
        {
            var_c199f212f55cc2a3 = [[ createmarkerfunc ]]( 99 );
            level thread function_310872fbaa64f368( var_c199f212f55cc2a3 );
        }
        
        while ( true )
        {
            waitframe();
            curcircleindex = level.br_circle.circleindex;
            lastcircleindex = level.br_level.br_circleradii.size - 1 - level.br_level.br_movingcirclecount;
            
            if ( curcircleindex < lastcircleindex )
            {
                objective_state( var_d81f8f3b9d5bed6b, "<dev string:x287>" );
                objective_icon( var_d81f8f3b9d5bed6b, var_d8887acaaaf92cc1 );
                objective_position( var_d81f8f3b9d5bed6b, level.br_level.br_circlecenters[ curcircleindex + 1 ] );
            }
            
            if ( level.br_level.var_7a7b3389cf47133f )
            {
                trainent = level.wztrain_info.animent[ "<dev string:x28e>" ];
                
                if ( isdefined( trainent ) )
                {
                    trainpos = trainent.origin;
                    objective_state( var_c199f212f55cc2a3, "<dev string:x287>" );
                    objective_icon( var_c199f212f55cc2a3, trainicon );
                    objective_position( var_c199f212f55cc2a3, trainpos );
                }
            }
        }
    }

    // Namespace br_multi_circle
    // Params 0
    // Checksum 0xfc6b742f, Offset: 0x536b
    // Size: 0x11, Type: dev
    function function_6b1da0467bcbe34c()
    {
        level notify( #"hash_485ac4dd2dab80df" );
    }

    // Namespace br_multi_circle
    // Params 1
    // Checksum 0xa4c31b95, Offset: 0x5384
    // Size: 0x46, Type: dev
    function function_310872fbaa64f368( markerid )
    {
        level waittill( #"hash_485ac4dd2dab80df" );
        var_9b5b937fd6011bb1 = utility::getsharedfunc( #"game", #"returnobjectiveid" );
        [[ var_9b5b937fd6011bb1 ]]( markerid );
    }

    // Namespace br_multi_circle
    // Params 0
    // Checksum 0x90823798, Offset: 0x53d2
    // Size: 0x2e0, Type: dev
    function function_5c10608b47a4f791()
    {
        level notify( #"hash_3dd01fe0a47ac1a7" );
        level endon( #"hash_3dd01fe0a47ac1a7" );
        segmentpositions = level.br_level.var_c0b6a8a6ac25a9fa;
        segmentradii = level.br_level.var_40380d99600dbf9;
        segmenttimes = level.br_level.var_9a633989648fd22;
        segmentmetadata = level.br_level.var_4589b8916defbe51;
        
        if ( !isdefined( segmentmetadata ) )
        {
            return;
        }
        
        while ( true )
        {
            waitframe();
            coloroptions = [ ( 1, 0, 1 ), ( 0, 1, 1 ) ];
            offsetstep = 30;
            
            foreach ( circleidx, metadata in segmentmetadata )
            {
                if ( !br_circle::function_a860b6cc615c4bdb( circleidx ) )
                {
                    continue;
                }
                
                curcolor = coloroptions[ circleidx % 2 ];
                curoffset = offsetstep * ( circleidx - br_circle::function_9448d46c0e4395c1() + 1 );
                
                for ( i = metadata.firstidx; i <= metadata.lastidx ; i++ )
                {
                    startpos = segmentpositions[ i ] + ( 0, 0, curoffset );
                    endpos = segmentpositions[ i + 1 ] + ( 0, 0, curoffset );
                    line( startpos, endpos, curcolor );
                    
                    if ( i == metadata.firstidx )
                    {
                        print3d( startpos, "<dev string:x29a>" + string( circleidx + 1 ), curcolor );
                        sphere( startpos, 10, curcolor );
                        continue;
                    }
                    
                    if ( i == metadata.firstidx + metadata.var_6de279516d254c77 )
                    {
                        print3d( startpos, "<dev string:x2a1>" + string( circleidx + 1 ), curcolor );
                        sphere( startpos, 10, curcolor );
                        continue;
                    }
                    
                    if ( i == metadata.lastidx )
                    {
                        print3d( endpos, "<dev string:x2a8>" + string( circleidx + 1 ), curcolor );
                        sphere( endpos, 10, curcolor );
                        continue;
                    }
                    
                    sphere( startpos, 3, curcolor );
                }
            }
            
            trainent = level.wztrain_info.animent[ "<dev string:x28e>" ];
            
            if ( isdefined( trainent ) )
            {
                sphere( trainent.origin, 10, ( 1, 1, 1 ) );
            }
        }
    }

    // Namespace br_multi_circle
    // Params 0
    // Checksum 0x988933b8, Offset: 0x56ba
    // Size: 0x11, Type: dev
    function function_ff4c2b4a2efd2cce()
    {
        level notify( #"hash_3dd01fe0a47ac1a7" );
    }

#/

// Namespace br_multi_circle
// Params 0
// Checksum 0x59804d88, Offset: 0x56d3
// Size: 0xac
function function_481cb87ab4bf1296()
{
    y_offset = 10;
    labels = [ &"mp/br_multi_circle_label_a", &"mp/br_multi_circle_label_b", &"mp/br_multi_circle_label_c", &"mp/br_multi_circle_label_d" ];
    overlays = [];
    multicirclecount = br_circle_util::function_7c3401c47d505872();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        overlay = function_d31b12879d9b8207( labels[ i ], y_offset * i );
        overlay thread function_b3f4964c01376475();
        overlays[ overlays.size ] = overlay;
    }
    
    return overlays;
}

// Namespace br_multi_circle
// Params 2
// Checksum 0xb018c329, Offset: 0x5788
// Size: 0xce
function function_d31b12879d9b8207( label, yoffset )
{
    hudelem = newhudelem();
    hudelem.label = label;
    hudelem.x = 720;
    hudelem.y = 50 + yoffset;
    hudelem.alignx = "right";
    hudelem.aligny = "middle";
    hudelem.sort = 1;
    hudelem.foreground = 1;
    hudelem.hidewheninmenu = 1;
    hudelem.alpha = 1;
    hudelem.fontscale = 1;
    hudelem.font = "objective";
    return hudelem;
}

// Namespace br_multi_circle
// Params 0
// Checksum 0x6a47834a, Offset: 0x585f
// Size: 0x35
function function_b3f4964c01376475()
{
    level endon( #"game_ended" );
    hudelem = self;
    level waittill( #"multi_circle_merge" );
    
    if ( isdefined( hudelem ) )
    {
        hudelem destroy();
    }
}

