// script_300adfad41dfeed4  (hash_300adfad41dfeed4.gscc) (size: 15504 Bytes / 0x3c90 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x728d74c5 (1921873093)
// size ...... 15504 (0x3c90)
// includes .. 6   (offset: 0x3a4c)
// strings ... 12  (offset: 0x3a7c)
// dev strs .. 26  (offset: 0x3b3c)
// exports ... 36  (offset: 0x2bc8)
// cseg ...... 0x191 + 0x2a37 (0x2bc8)
// imports ... 65  (offset: 0x3168)
// animtree1 . 0   (offset: 0x3c90)
// animtree2 . 0   (offset: 0x3c90)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\poi;

#namespace dmz_star_system;

// Namespace dmz_star_system
// Params 0
// Checksum 0x174598ea, Offset: 0x1af
// Size: 0x34b
function starsystem_init()
{
    if ( getdvarint( @"scr_starsystem", 1 ) == 0 )
    {
        return;
    }
    
    level.var_1d43e6e89a526030 = spawnstruct();
    level.var_1d43e6e89a526030.var_46dd4a4e46fce80b = getdvarfloat( @"hash_2c3eabf4a542ff3c", -0.5 );
    level.var_1d43e6e89a526030.var_ec6b866b9b132e1c = getdvarfloat( @"hash_bff507e30583af77", 2 );
    level.var_1d43e6e89a526030.var_5ccd74871b8d172c = getdvarfloat( @"hash_2230fc7a68495b75", 0.75 );
    level.var_1d43e6e89a526030.var_21bd8813f1e29859 = getdvarfloat( @"hash_5c438007433d1392", 10 );
    level.var_1d43e6e89a526030.reqreinforcements = [];
    level.var_1d43e6e89a526030.reqreinforcements[ 0 ] = getdvarint( @"hash_2e473219b28f0957", 0 );
    level.var_1d43e6e89a526030.reqreinforcements[ 1 ] = getdvarint( @"hash_2e473119b28f0724", 10 );
    level.var_1d43e6e89a526030.reqreinforcements[ 2 ] = getdvarint( @"hash_2e473419b28f0dbd", 10 );
    level.var_1d43e6e89a526030.reqreinforcements[ 3 ] = getdvarint( @"hash_2e473319b28f0b8a", 15 );
    level.var_1d43e6e89a526030.var_8535ffc242157aee = getdvarint( @"hash_3fd4229cd74ff0a9", 60 );
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b = [];
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 0 ] = "rex_default_tier_1";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 1 ] = "rex_default_tier_2";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 2 ] = "rex_default_tier_2";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 3 ] = "rex_default_tier_3";
    level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ 4 ] = "rex_default_tier_3";
    callback::add( #"hash_6a3e445c5100cb67", &function_11b4d752306118dd );
    callback::add( #"on_spawn_agent", &onspawnagent );
    
    /#
        level thread debug_starsystem();
        
        if ( getdvarint( @"hash_d1fa0a1f136eadfb", 0 ) == 1 )
        {
            level thread function_71c84451ec372eb9();
        }
    #/
    
    starsystem_initdialog();
    
    if ( poi::poi_issystemactive() )
    {
        level.startracker = [];
        
        foreach ( poiname, poi in level.poi )
        {
            level.startracker[ poiname ] = function_27496dd52fb66a58( poiname );
            level thread function_5aaed7f3df6d42fe( level.startracker[ poiname ] );
        }
        
        return;
    }
    
    level.startracker = function_27496dd52fb66a58();
    level thread function_5aaed7f3df6d42fe( level.startracker );
}

// Namespace dmz_star_system
// Params 1, eflags: 0x4
// Checksum 0xe8057703, Offset: 0x502
// Size: 0x16
function private onspawnagent( params )
{
    function_c12b5a2f27551abc( self, 1 );
}

// Namespace dmz_star_system
// Params 1, eflags: 0x4
// Checksum 0xc4f0cb04, Offset: 0x520
// Size: 0x41
function private function_11b4d752306118dd( params )
{
    starlevel = function_8fb952c22d4cd3da( params.poi );
    
    if ( starlevel > 3 )
    {
        return 3;
    }
    
    if ( starlevel >= 2 )
    {
        return 2;
    }
    
    return 1;
}

// Namespace dmz_star_system
// Params 0
// Checksum 0x2c4ebaa5, Offset: 0x56a
// Size: 0x5
function starsystem_initdialog()
{
    /#
    #/
}

// Namespace dmz_star_system
// Params 0
// Checksum 0x23eb0193, Offset: 0x577
// Size: 0xc, Type: bool
function function_bbf594df09859fa2()
{
    return isdefined( level.var_1d43e6e89a526030 );
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x7953822d, Offset: 0x58c
// Size: 0x559
function function_27496dd52fb66a58( poiname )
{
    struct = spawnstruct();
    struct.starlevel = 0;
    struct.starmeter = 0;
    struct.var_e2ad9e20c5a7d3b5 = 0;
    struct.var_3e391b22d54ac2c8 = 0;
    struct.script_poi = poiname;
    struct.var_c626675bcb372a47 = 0;
    struct.var_4e2eae7d356ef499 = 0;
    struct.var_4f08309a163f753f = 0;
    struct.var_d225a8ac8fd8da78 = 0;
    struct.var_f56cc0ec712ced9d = 0;
    struct.var_44109cae1d886ec0 = 0;
    struct.var_3627d1f79a942dfd = getdvarint( @"hash_245660b9079d8b97", 20 );
    struct.var_cf7e997d93a6fc77 = getdvarint( @"hash_3ab6352457da46bd", 10 );
    struct.ratingthreshold = [];
    struct.levelrange = [];
    struct.var_3912e7edbfe2f803 = [];
    struct.ratingthreshold[ 0 ] = 0;
    struct.levelrange[ 0 ] = getdvarint( @"hash_cfaeac4942cbdba", 800 );
    struct.var_3912e7edbfe2f803[ 0 ] = struct.ratingthreshold[ 0 ] + struct.levelrange[ 0 ] * struct.var_cf7e997d93a6fc77;
    struct.ratingthreshold[ 1 ] = struct.ratingthreshold[ 0 ] + struct.levelrange[ 0 ];
    struct.levelrange[ 1 ] = getdvarint( @"hash_1adeab3daea4a349", 800 );
    struct.var_3912e7edbfe2f803[ 1 ] = struct.ratingthreshold[ 1 ] + struct.levelrange[ 1 ] * struct.var_cf7e997d93a6fc77;
    struct.ratingthreshold[ 2 ] = struct.ratingthreshold[ 1 ] + struct.levelrange[ 1 ];
    struct.levelrange[ 2 ] = getdvarint( @"hash_6fc71b67a904a550", 800 );
    struct.var_3912e7edbfe2f803[ 2 ] = struct.ratingthreshold[ 2 ] + struct.levelrange[ 2 ] * struct.var_cf7e997d93a6fc77;
    struct.ratingthreshold[ 3 ] = struct.ratingthreshold[ 2 ] + struct.levelrange[ 2 ];
    struct.levelrange[ 3 ] = getdvarint( @"hash_a93f5b948731e5f", 800 );
    struct.var_3912e7edbfe2f803[ 3 ] = struct.ratingthreshold[ 3 ] + struct.levelrange[ 3 ] * struct.var_cf7e997d93a6fc77;
    struct.ratingthreshold[ 4 ] = struct.ratingthreshold[ 3 ] + struct.levelrange[ 3 ];
    struct.levelrange[ 4 ] = getdvarint( @"hash_1ec9fd7ad7047996", 800 );
    struct.var_3912e7edbfe2f803[ 4 ] = struct.ratingthreshold[ 4 ] + struct.levelrange[ 4 ] * struct.var_cf7e997d93a6fc77;
    struct.metermax = struct.ratingthreshold[ 4 ] + struct.levelrange[ 4 ];
    struct.var_dc899ed3e29db457 = [];
    struct.var_dc899ed3e29db457[ 1 ] = &function_8f1eb22c0c9b40bb;
    struct.var_dc899ed3e29db457[ 2 ] = &function_daefc22d3de36d73;
    struct.var_dc899ed3e29db457[ 3 ] = &function_38f5f8bfce21d5ee;
    struct.var_dc899ed3e29db457[ 4 ] = &function_23b7b9dd43499bb1;
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    struct.alarmlocs = [];
    keys = getarraykeys( level.struct_class_names[ "script_noteworthy" ] );
    
    foreach ( key in keys )
    {
        if ( issubstr( key, "star_alarm" ) )
        {
            foreach ( node in level.struct_class_names[ "script_noteworthy" ][ key ] )
            {
                if ( !isdefined( poiname ) || poiname == node.script_poi )
                {
                    struct.alarmlocs[ struct.alarmlocs.size ] = node;
                }
            }
        }
    }
    
    return struct;
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x498833fa, Offset: 0xaee
// Size: 0xec
function function_dbcc9d8aeb37a852( poiname )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( isalive( self ) )
        {
            if ( self [[ self.fnisinstealthidle ]]() )
            {
                function_dfc43f391533f302( level.var_1d43e6e89a526030.var_46dd4a4e46fce80b, poiname );
            }
            else if ( self [[ self.fnisinstealthinvestigate ]]() )
            {
                function_dfc43f391533f302( level.var_1d43e6e89a526030.var_5ccd74871b8d172c, poiname );
            }
            else if ( self [[ self.fnisinstealthcombat ]]() )
            {
                function_dfc43f391533f302( level.var_1d43e6e89a526030.var_21bd8813f1e29859, poiname );
            }
            else if ( self [[ self.fnisinstealthhunt ]]() )
            {
                function_dfc43f391533f302( level.var_1d43e6e89a526030.var_ec6b866b9b132e1c, poiname );
            }
        }
        
        wait 1;
    }
}

// Namespace dmz_star_system
// Params 2
// Checksum 0xf0e46d05, Offset: 0xbe2
// Size: 0xa0
function function_8058daeece34dd2f( num, poiname )
{
    if ( !isdefined( level.startracker ) )
    {
        return;
    }
    
    if ( poi::poi_issystemactive() )
    {
        if ( isdefined( poiname ) && isdefined( level.startracker[ poiname ] ) )
        {
            level.startracker[ poiname ].var_4e2eae7d356ef499 += num;
        }
        
        return;
    }
    
    level.startracker.var_4e2eae7d356ef499 += num;
}

// Namespace dmz_star_system
// Params 1
// Checksum 0xa948864a, Offset: 0xc8a
// Size: 0x19
function function_339f8a79965363d3( startracker )
{
    startracker.var_4e2eae7d356ef499 = 0;
}

// Namespace dmz_star_system
// Params 2
// Checksum 0xc7306ee6, Offset: 0xcab
// Size: 0x5b, Type: bool
function function_48eac712b1ff8f76( startracker, var_75324e53f74a58e1 )
{
    var_29c5f4aed1fa7086 = startracker.starlevel + 1;
    
    if ( !isdefined( startracker.ratingthreshold[ var_29c5f4aed1fa7086 ] ) )
    {
        return false;
    }
    
    if ( var_75324e53f74a58e1 > startracker.ratingthreshold[ var_29c5f4aed1fa7086 ] )
    {
        return true;
    }
    
    return false;
}

// Namespace dmz_star_system
// Params 2
// Checksum 0x7a97a8a1, Offset: 0xd0f
// Size: 0xad
function function_f7e083a484f8bc5( startracker, var_75324e53f74a58e1 )
{
    var_e56e65319bbd647d = 0;
    var_97ec1613c95684b0 = 0;
    
    if ( startracker.var_4e2eae7d356ef499 >= level.var_1d43e6e89a526030.reqreinforcements[ startracker.starlevel ] )
    {
        var_e56e65319bbd647d = 1;
    }
    
    var_29c5f4aed1fa7086 = startracker.starlevel + 1;
    
    if ( var_75324e53f74a58e1 >= startracker.ratingthreshold[ var_29c5f4aed1fa7086 ] )
    {
        var_97ec1613c95684b0 = 1;
    }
    
    startracker.var_c626675bcb372a47 = var_e56e65319bbd647d && var_97ec1613c95684b0;
    return startracker.var_c626675bcb372a47;
}

// Namespace dmz_star_system
// Params 2
// Checksum 0x41adcb73, Offset: 0xdc5
// Size: 0x223
function function_6f856aaf4eeead7b( startracker, var_75324e53f74a58e1 )
{
    startracker.starlevel++;
    startracker.starmeter = var_75324e53f74a58e1;
    function_339f8a79965363d3( startracker );
    ai_reinforcements::function_fa992719a805b962( level.var_1d43e6e89a526030.var_8535ffc242157aee, startracker.script_poi, "Star Level Up" );
    playerlist = level.poi[ startracker.script_poi ][ "players" ];
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_rank_up", playerlist );
    
    if ( isdefined( startracker.var_dc899ed3e29db457[ startracker.starlevel ] ) )
    {
        [[ startracker.var_dc899ed3e29db457[ startracker.starlevel ] ]]( startracker );
    }
    
    var_71966a2a81672f55 = [];
    
    if ( isdefined( startracker.script_poi ) )
    {
        foreach ( subarea in level.poi[ startracker.script_poi ][ "subAreas" ] )
        {
            var_71966a2a81672f55 = arraycombine( var_71966a2a81672f55, subarea.livingagents );
        }
    }
    else
    {
        var_71966a2a81672f55 = level.agentarray;
    }
    
    foreach ( agent in var_71966a2a81672f55 )
    {
        if ( isalive( agent ) )
        {
            function_c12b5a2f27551abc( agent, startracker.starlevel );
        }
    }
}

// Namespace dmz_star_system
// Params 2
// Checksum 0xe342402c, Offset: 0xff0
// Size: 0x65, Type: bool
function function_49b0ec690919143f( startracker, var_75324e53f74a58e1 )
{
    var_23777ff74eaf866f = startracker.starlevel - 1;
    
    if ( !isdefined( startracker.ratingthreshold[ var_23777ff74eaf866f ] ) )
    {
        return false;
    }
    
    if ( var_75324e53f74a58e1 < startracker.ratingthreshold[ startracker.starlevel ] )
    {
        return true;
    }
    
    return false;
}

// Namespace dmz_star_system
// Params 2
// Checksum 0xcf37d04d, Offset: 0x105e
// Size: 0x70, Type: bool
function function_8a178455de9ad94a( startracker, var_75324e53f74a58e1 )
{
    if ( var_75324e53f74a58e1 <= startracker.ratingthreshold[ startracker.starlevel ] )
    {
        if ( !isdefined( startracker.var_1d8780c818f880c9 ) )
        {
            startracker.var_1d8780c818f880c9 = startracker.var_3627d1f79a942dfd;
        }
        else if ( startracker.var_1d8780c818f880c9 <= 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dmz_star_system
// Params 2
// Checksum 0x792cb55e, Offset: 0x10d7
// Size: 0x201
function function_b63a5f43a229face( startracker, var_75324e53f74a58e1 )
{
    startracker.starlevel--;
    startracker.starmeter = var_75324e53f74a58e1;
    function_339f8a79965363d3( startracker );
    playerlist = level.poi[ startracker.script_poi ][ "players" ];
    roll = randomint( 100 );
    
    if ( roll < 50 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_rank_down", playerlist );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_calming_down", playerlist );
    }
    
    var_71966a2a81672f55 = [];
    
    if ( isdefined( startracker.script_poi ) )
    {
        foreach ( subarea in level.poi[ startracker.script_poi ][ "subAreas" ] )
        {
            var_71966a2a81672f55 = arraycombine( var_71966a2a81672f55, subarea.livingagents );
        }
    }
    else
    {
        var_71966a2a81672f55 = level.agentarray;
    }
    
    foreach ( agent in var_71966a2a81672f55 )
    {
        if ( isalive( agent ) )
        {
            function_c12b5a2f27551abc( agent, startracker.starlevel );
        }
    }
}

// Namespace dmz_star_system
// Params 2
// Checksum 0xc6af7387, Offset: 0x12e0
// Size: 0xa4
function function_dfc43f391533f302( amount, poiname )
{
    if ( poi::poi_issystemactive() )
    {
        if ( isdefined( poiname ) && isdefined( level.startracker[ poiname ] ) )
        {
            level.startracker[ poiname ].var_e2ad9e20c5a7d3b5 += amount;
        }
        else
        {
            println( "<dev string:x24>" + poiname );
        }
        
        return;
    }
    
    level.startracker.var_e2ad9e20c5a7d3b5 += amount;
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x4a1f446d, Offset: 0x138c
// Size: 0x11a
function function_85a0207e16d54f51( startracker )
{
    influencetotal = 0;
    [ idle, investigate, combat, hunt ] = ai_mp_controller::function_dbc2aed56a183c6b( startracker.script_poi );
    startracker.var_4f08309a163f753f = idle;
    startracker.var_d225a8ac8fd8da78 = investigate;
    startracker.var_f56cc0ec712ced9d = combat;
    startracker.var_44109cae1d886ec0 = hunt;
    influencetotal += idle * level.var_1d43e6e89a526030.var_46dd4a4e46fce80b;
    influencetotal += investigate * level.var_1d43e6e89a526030.var_5ccd74871b8d172c;
    influencetotal += combat * level.var_1d43e6e89a526030.var_21bd8813f1e29859;
    influencetotal += hunt * level.var_1d43e6e89a526030.var_ec6b866b9b132e1c;
    startracker.var_e2ad9e20c5a7d3b5 = influencetotal;
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x9e479ee6, Offset: 0x14ae
// Size: 0x1d7
function function_5aaed7f3df6d42fe( startracker )
{
    var_d6c6e7cddf4f98e6 = getdvarint( @"hash_7e30f05f2889dc4d", 15 );
    
    while ( true )
    {
        wait 1;
        function_85a0207e16d54f51( startracker );
        startracker.var_3e391b22d54ac2c8 = startracker.var_e2ad9e20c5a7d3b5;
        
        if ( startracker.var_e2ad9e20c5a7d3b5 > var_d6c6e7cddf4f98e6 )
        {
            startracker.var_e2ad9e20c5a7d3b5 = var_d6c6e7cddf4f98e6;
        }
        else if ( startracker.var_e2ad9e20c5a7d3b5 < var_d6c6e7cddf4f98e6 * -1 )
        {
            startracker.var_e2ad9e20c5a7d3b5 = var_d6c6e7cddf4f98e6 * -1;
        }
        
        var_75324e53f74a58e1 = startracker.starmeter + startracker.var_e2ad9e20c5a7d3b5;
        startracker.var_e2ad9e20c5a7d3b5 = 0;
        
        if ( var_75324e53f74a58e1 < 0 )
        {
            var_75324e53f74a58e1 = 0;
        }
        else if ( var_75324e53f74a58e1 > startracker.metermax )
        {
            var_75324e53f74a58e1 = startracker.metermax;
        }
        
        if ( function_48eac712b1ff8f76( startracker, var_75324e53f74a58e1 ) )
        {
            targetlevel = startracker.starlevel + 1;
            
            if ( !function_f7e083a484f8bc5( startracker, var_75324e53f74a58e1 ) )
            {
                if ( var_75324e53f74a58e1 > startracker.ratingthreshold[ targetlevel ] )
                {
                    startracker.starmeter = startracker.ratingthreshold[ targetlevel ];
                }
            }
            else
            {
                function_6f856aaf4eeead7b( startracker, var_75324e53f74a58e1 );
            }
            
            continue;
        }
        
        if ( function_49b0ec690919143f( startracker, var_75324e53f74a58e1 ) )
        {
            if ( !function_8a178455de9ad94a( startracker, var_75324e53f74a58e1 ) )
            {
                if ( var_75324e53f74a58e1 < startracker.ratingthreshold[ startracker.starlevel ] )
                {
                    startracker.starmeter = startracker.ratingthreshold[ startracker.starlevel ];
                }
            }
            else
            {
                function_b63a5f43a229face( startracker, var_75324e53f74a58e1 );
            }
            
            continue;
        }
        
        startracker.starmeter = var_75324e53f74a58e1;
    }
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x77a950f9, Offset: 0x168d
// Size: 0x7f
function function_8f1eb22c0c9b40bb( startracker )
{
    if ( utility::issharedfuncdefined( #"aitokens", #"tokens_issystemactive" ) )
    {
        playerlist = level.poi[ startracker.script_poi ][ "players" ];
        utility::callsharedfunc( #"aitokens", #"hash_d7f2ef75bdc51062", playerlist, level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 1 ] );
    }
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x8f24e8c0, Offset: 0x1714
// Size: 0x7f
function function_daefc22d3de36d73( startracker )
{
    if ( utility::issharedfuncdefined( #"aitokens", #"tokens_issystemactive" ) )
    {
        playerlist = level.poi[ startracker.script_poi ][ "players" ];
        utility::callsharedfunc( #"aitokens", #"hash_d7f2ef75bdc51062", playerlist, level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 2 ] );
    }
}

// Namespace dmz_star_system
// Params 1
// Checksum 0xdf016ba0, Offset: 0x179b
// Size: 0xff
function function_38f5f8bfce21d5ee( startracker )
{
    playerlist = level.poi[ startracker.script_poi ][ "players" ];
    roll = randomint( 100 );
    
    if ( roll < 50 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"dx_br_dmzo_star_ovld_thrs", playerlist );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"hash_3617c693894d9807", playerlist );
    }
    
    if ( utility::issharedfuncdefined( #"aitokens", #"tokens_issystemactive" ) )
    {
        playerlist = level.poi[ startracker.script_poi ][ "players" ];
        utility::callsharedfunc( #"aitokens", #"hash_d7f2ef75bdc51062", playerlist, level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 3 ] );
    }
}

// Namespace dmz_star_system
// Params 1
// Checksum 0xada938ef, Offset: 0x18a2
// Size: 0xff
function function_23b7b9dd43499bb1( startracker )
{
    playerlist = level.poi[ startracker.script_poi ][ "players" ];
    roll = randomint( 100 );
    
    if ( roll < 50 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"dx_br_dmzo_star_ovld_frst", playerlist );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"hash_361b49938950ac77", playerlist );
    }
    
    if ( utility::issharedfuncdefined( #"aitokens", #"tokens_issystemactive" ) )
    {
        playerlist = level.poi[ startracker.script_poi ][ "players" ];
        utility::callsharedfunc( #"aitokens", #"hash_d7f2ef75bdc51062", playerlist, level.var_1d43e6e89a526030.var_f7861862eccd2c65[ 4 ] );
    }
}

// Namespace dmz_star_system
// Params 1
// Checksum 0x833e73b7, Offset: 0x19a9
// Size: 0x153
function function_362d0d296b7c602f( startracker )
{
    if ( getdvarint( @"hash_ed3aab295415580", 1 ) == 1 )
    {
        return;
    }
    
    foreach ( loc in startracker.alarmlocs )
    {
        loc.ent = spawn( "script_origin", loc.origin );
        loc.ent playsound( "mp_dmz_alrm_star" );
    }
    
    wait 10;
    
    foreach ( loc in startracker.alarmlocs )
    {
        if ( isdefined( loc.ent ) )
        {
            loc.ent delete();
        }
    }
}

// Namespace dmz_star_system
// Params 1
// Checksum 0xf29768ec, Offset: 0x1b04
// Size: 0x73
function function_8fb952c22d4cd3da( poiname )
{
    if ( !function_bbf594df09859fa2() )
    {
        return 0;
    }
    
    startracker = level.startracker;
    
    if ( poi::poi_issystemactive() )
    {
        if ( !isdefined( poiname ) )
        {
            return 0;
        }
        
        startracker = level.startracker[ poiname ];
    }
    
    if ( !isdefined( startracker ) )
    {
        return 0;
    }
    
    if ( !isdefined( startracker.starlevel ) )
    {
        return 0;
    }
    
    return startracker.starlevel;
}

// Namespace dmz_star_system
// Params 0
// Checksum 0x1af53388, Offset: 0x1b80
// Size: 0x175
function function_8fda6759f006bced()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"enter_combat" );
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        self waittill( #"ai_events", events );
        
        if ( !utility::ent_flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        foreach ( event in events )
        {
            switch ( event.type )
            {
                case #"hash_412938e72fd9ab35":
                case #"hash_46bae15508b25675":
                case #"hash_4b0ca4ada825424a":
                case #"hash_8c8ad07529b0fca6":
                case #"hash_c910677ee9c31085":
                case #"hash_de811d1d5fa7e6b4":
                    break;
                case #"hash_9e02cd4a0f3ca981":
                    level.startracker.combat++;
                    thread function_cdee51d23582042c();
                    break;
                default:
                    break;
            }
            
            function_6e6ccc92e5487be3( event.type );
        }
    }
}

// Namespace dmz_star_system
// Params 0
// Checksum 0x7e03e515, Offset: 0x1cfd
// Size: 0x2
function function_cdee51d23582042c()
{
    
}

// Namespace dmz_star_system
// Params 1
// Checksum 0xf76e3cfb, Offset: 0x1d07
// Size: 0x64
function function_6e6ccc92e5487be3( eventtype )
{
    if ( level.startracker.lasteventindex == 10 )
    {
        level.startracker.lasteventindex = 0;
    }
    
    level.startracker.eventsrecent[ level.startracker.lasteventindex ] = eventtype;
}

// Namespace dmz_star_system
// Params 2
// Checksum 0x945efdb9, Offset: 0x1d73
// Size: 0x144
function function_c12b5a2f27551abc( agent, starlevel )
{
    if ( !function_bbf594df09859fa2() )
    {
        return;
    }
    
    var_eee6b641213731cc = undefined;
    var_a6bc754ddd59ac4b = undefined;
    var_e76fe4ca8a260f6 = 0;
    
    if ( !isdefined( starlevel ) )
    {
        starlevel = 0;
    }
    
    if ( isdefined( level.var_9fb946fd0329db79[ starlevel ] ) )
    {
        templatestring = level.var_9fb946fd0329db79[ starlevel ];
    }
    else
    {
        templatestring = level.var_1d43e6e89a526030.var_9ee2d0e553ab232b[ starlevel ];
    }
    
    switch ( starlevel )
    {
        case 0:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 5;
            break;
        case 1:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 6;
            break;
        case 2:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 7;
            break;
        case 3:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 8;
            var_e76fe4ca8a260f6 = 1;
            break;
        case 4:
            var_eee6b641213731cc = templatestring;
            var_a6bc754ddd59ac4b = 10;
            var_e76fe4ca8a260f6 = 1;
            break;
        default:
            var_eee6b641213731cc = "star_0";
            var_a6bc754ddd59ac4b = 5;
            break;
    }
    
    ai_mp_controller::function_e054dd1fa33a600a( agent, var_eee6b641213731cc );
    ai_mp_controller::function_f1fca4c3e2e0dad1( agent, var_a6bc754ddd59ac4b );
    agent function_1dd77549fda16bb3( var_e76fe4ca8a260f6 );
}

/#

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0x63297da2, Offset: 0x1ebf
    // Size: 0x249, Type: dev
    function function_866d2730cd7663ba()
    {
        if ( poi::poi_issystemactive() )
        {
            foreach ( poiname, poi in level.poi )
            {
                if ( isdefined( level.startracker[ poiname ] ) && level.startracker[ poiname ].starlevel <= 4 )
                {
                    if ( level.startracker[ poiname ].starlevel == 4 )
                    {
                        level.startracker[ poiname ].starmeter = level.startracker[ poiname ].metermax;
                        continue;
                    }
                    
                    var_ff9dae8f2831450a = level.startracker[ poiname ].starlevel + 1;
                    level.startracker[ poiname ].starmeter = level.startracker[ poiname ].ratingthreshold[ var_ff9dae8f2831450a ];
                    function_6f856aaf4eeead7b( level.startracker[ poiname ], level.startracker[ poiname ].ratingthreshold[ var_ff9dae8f2831450a ] );
                }
            }
            
            return;
        }
        
        if ( isdefined( level.startracker ) && level.startracker.starlevel < 4 )
        {
            if ( level.startracker.starlevel == 4 )
            {
                level.startracker.starmeter = level.startracker.metermax;
                return;
            }
            
            var_ff9dae8f2831450a = level.startracker.starlevel + 1;
            level.startracker.starmeter = level.startracker.ratingthreshold[ var_ff9dae8f2831450a ];
            function_6f856aaf4eeead7b( level.startracker, level.startracker.ratingthreshold[ var_ff9dae8f2831450a ] );
        }
    }

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0xe14120d9, Offset: 0x2110
    // Size: 0x1b8, Type: dev
    function function_6d11116fdbd4ca4e()
    {
        if ( poi::poi_issystemactive() )
        {
            foreach ( poiname, poi in level.poi )
            {
                if ( isdefined( level.startracker[ poiname ] ) && level.startracker[ poiname ].starlevel > 0 )
                {
                    var_ff9dae8f2831450a = level.startracker[ poiname ].starlevel - 1;
                    level.startracker[ poiname ].starmeter = level.startracker[ poiname ].ratingthreshold[ var_ff9dae8f2831450a ];
                    function_b63a5f43a229face( level.startracker[ poiname ], level.startracker[ poiname ].ratingthreshold[ var_ff9dae8f2831450a ] );
                }
            }
            
            return;
        }
        
        if ( isdefined( level.startracker ) && level.startracker.starlevel > 0 )
        {
            var_ff9dae8f2831450a = level.startracker.starlevel - 1;
            level.startracker.starmeter = level.startracker.ratingthreshold[ var_ff9dae8f2831450a ];
            function_b63a5f43a229face( level.startracker, level.startracker.ratingthreshold[ var_ff9dae8f2831450a ] );
        }
    }

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0x77ad40bf, Offset: 0x22d0
    // Size: 0x11a, Type: dev
    function function_9070f75a74a83882()
    {
        if ( poi::poi_issystemactive() )
        {
            foreach ( poiname, poi in level.poi )
            {
                if ( isdefined( level.startracker[ poiname ] ) )
                {
                    level.startracker[ poiname ].var_4e2eae7d356ef499 = level.var_1d43e6e89a526030.reqreinforcements[ level.startracker[ poiname ].starlevel ];
                }
            }
            
            return;
        }
        
        if ( isdefined( level.startracker ) )
        {
            level.startracker.var_4e2eae7d356ef499 = level.var_1d43e6e89a526030.reqreinforcements[ level.startracker.starlevel ];
        }
    }

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0xd271bd62, Offset: 0x23f2
    // Size: 0x9a, Type: dev
    function debug_starsystem()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_star_system_increase", 0 ) == 1 )
            {
                function_866d2730cd7663ba();
                setdevdvar( @"scr_star_system_increase", 0 );
            }
            
            if ( getdvarint( @"hash_404e567fa40e3be2", 0 ) == 1 )
            {
                function_6d11116fdbd4ca4e();
                setdevdvar( @"hash_404e567fa40e3be2", 0 );
            }
            
            if ( getdvarint( @"hash_d2ff761cd005bbad", 0 ) == 1 )
            {
                function_9070f75a74a83882();
                setdevdvar( @"hash_d2ff761cd005bbad", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0xaf0eb94e, Offset: 0x2494
    // Size: 0x2f6, Type: dev
    function function_c19e352e766f74d9()
    {
        playerlist = level.players;
        xpos = 700;
        ypos = 500;
        color = ( 1, 1, 1 );
        scale = 2;
        duration = 90;
        waittime = 8;
        printtoscreen2d( xpos, ypos, "<dev string:x89>", color, scale, duration );
        wait 10;
        
        while ( true )
        {
            playerlist = level.players;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_three_stars", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:xab>", color, scale, duration );
            br_gametype_dmz::showdmzsplash( "<dev string:xbd>", level.players, "<dev string:xd5>" );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_four_stars", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:xe1>", color, scale, duration );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_rank_up", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:xf2>", color, scale, duration );
            br_gametype_dmz::showdmzsplash( "<dev string:x100>", level.players, "<dev string:xd5>" );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_rank_down", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:x11d>", color, scale, duration );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:x12d>", color, scale, duration );
            br_gametype_dmz::showdmzsplash( "<dev string:x13f>", level.players, "<dev string:xd5>" );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"poi_high_alert", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:x160>", color, scale, duration );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_soldiers_incoming", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:x16f>", color, scale, duration );
            br_gametype_dmz::showdmzsplash( "<dev string:xbd>", level.players, "<dev string:xd5>" );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_specialforces_incoming", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:x187>", color, scale, duration );
            wait waittime;
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"stars_calming_down", playerlist );
            printtoscreen2d( xpos, ypos, "<dev string:x1a4>", color, scale, duration );
            wait waittime;
        }
    }

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0x4e33b346, Offset: 0x2792
    // Size: 0x385, Type: dev
    function function_b000f43b813b4a9()
    {
        wait 10;
        waittime = 10;
        
        while ( true )
        {
            br_gametype_dmz::showdmzsplash( "<dev string:xbd>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x100>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x13f>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x1b7>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x1cc>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x1e6>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x206>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x21f>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x23e>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x265>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x27a>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x293>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
            br_gametype_dmz::showdmzsplash( "<dev string:x2b1>", level.players );
            thread utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"denied_area_enter", level.players );
            wait waittime;
        }
    }

    // Namespace dmz_star_system
    // Params 0
    // Checksum 0xf965582d, Offset: 0x2b1f
    // Size: 0xa9, Type: dev
    function function_71c84451ec372eb9()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                player setclientomnvar( "<dev string:x2d2>", function_8fb952c22d4cd3da( player.closestpoi ) );
            }
            
            wait 1;
        }
    }

#/
