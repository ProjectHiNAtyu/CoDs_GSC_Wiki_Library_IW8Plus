// scripts\mp\br\gametypes\br_ending_debug.gsc  (hash_572322b79342ba5b.gscc) (size: 28216 Bytes / 0x6e38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x947a15f4 (2491028980)
// size ...... 28216 (0x6e38)
// includes .. 20  (offset: 0x672c)
// strings ... 0   (offset: 0x67cc)
// dev strs .. 122 (offset: 0x67cc)
// exports ... 38  (offset: 0x4970)
// cseg ...... 0xb8 + 0x48b8 (0x4970)
// imports ... 187 (offset: 0x4f60)
// animtree1 . 2   (offset: 0x6e20)
// animtree2 . 0   (offset: 0x6e38)
#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_chopper;
#using scripts\mp\br\gametypes\br_ending_chopper2;
#using scripts\mp\br\gametypes\br_ending_chopper_to_hq;
#using scripts\mp\br\gametypes\br_ending_cq;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\class;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dev;
#using scripts\mp\gamelogic;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;
#using scripts\mp\personal_bests;

#namespace br_ending_debug;

// Namespace br_ending_debug
// Params 1, eflags: 0x4
// Checksum 0xe8ff4d6c, Offset: 0xd6
// Size: 0x6b
function private function_1a36a664977880a1( type )
{
    var_e63a9d5ec4b488a0 = br_ending::function_bcd77f3717230834( type );
    
    if ( isdefined( var_e63a9d5ec4b488a0 ) )
    {
        return self [[ var_e63a9d5ec4b488a0 ]]();
    }
    
    switch ( type )
    {
        case #"hash_d9cfbe7fb5447f0e":
            return br_ending_chopper2::function_10355abd5fe8eef9();
        case #"hash_1136bc3322c0a548":
        default:
            return br_ending_chopper::function_10355abd5fe8eef9();
    }
}

// Namespace br_ending_debug
// Params 1, eflags: 0x4
// Checksum 0x85171e8c, Offset: 0x149
// Size: 0x91
function private get_ending_transient( type )
{
    transientfunc = br_ending::get_transient_func( type );
    
    if ( isdefined( transientfunc ) )
    {
        return self [[ transientfunc ]]();
    }
    
    switch ( type )
    {
        case #"hash_d9cfbe7fb5447f0e":
            return br_ending_chopper2::get_chopperexfil_transient();
        case #"hash_18208461fac4f35e":
            return br_ending_chopper_to_hq::get_chopperhqexfil_transient();
        case #"hash_ce37a6540166b6f7":
            return br_ending_cq::function_aa8e694e37bf149f();
        case #"hash_1136bc3322c0a548":
        default:
            return br_ending_chopper::get_chopperexfil_transient();
    }
}

/#

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0x6b5a40f4, Offset: 0x1e2
    // Size: 0x1d0, Type: dev
    function function_f61879e453b76ae6( players )
    {
        if ( !isdefined( players ) )
        {
            players = level.players;
        }
        
        var_31b8544b63253dd4 = getdvarint( @"scr_br_ending_testclients" );
        
        if ( var_31b8544b63253dd4 > 0 )
        {
            level.custom_giveloadout = &function_26d5682c38144e50;
            count = 0;
            
            foreach ( player in level.players )
            {
                if ( istestclient( player ) )
                {
                    count++;
                }
            }
            
            if ( count < var_31b8544b63253dd4 )
            {
                setdvar( @"testclients_godmode", 1 );
                setdvar( @"hash_81f3fefd0af8548e", 0 );
                setdvar( @"hash_a99be90c92d68967", 0 );
                setdvar( @"hash_33fe5ebb83d90648", 0 );
                setdvar( @"hash_43cd2bf145682550", 0 );
                setdvar( @"testclients_domove", 0 );
                setdvar( @"hash_75663a72eb414a9a", 0 );
                dev_mp::spawn_test_clients( var_31b8544b63253dd4 );
            }
            
            wait 1;
            max_exfil_players = 7;
            
            if ( var_31b8544b63253dd4 >= max_exfil_players )
            {
                players = arrayremove( level.players, level.players[ 0 ] );
            }
            else
            {
                size = players.size;
                diff = max_exfil_players - size;
                
                if ( diff > 0 )
                {
                    for ( i = 0; i < diff ; i++ )
                    {
                        players[ players.size ] = level.players[ i + size ];
                    }
                }
            }
        }
        
        return players;
    }

    // Namespace br_ending_debug
    // Params 2
    // Checksum 0x4e7aeac3, Offset: 0x3ba
    // Size: 0x2a1, Type: dev
    function function_26d5682c38144e50( fauxspawn, revivespawn )
    {
        array = [];
        array[ "<dev string:x24>" ] = "<dev string:x2b>";
        array[ "<dev string:x3c>" ] = "<dev string:x46>";
        array[ "<dev string:x58>" ] = "<dev string:x60>";
        array[ "<dev string:x72>" ] = "<dev string:x78>";
        array[ "<dev string:x88>" ] = "<dev string:x8e>";
        array[ "<dev string:x9e>" ] = "<dev string:xa6>";
        array[ "<dev string:xb5>" ] = "<dev string:xb9>";
        array[ "<dev string:xc7>" ] = "<dev string:xcc>";
        array[ "<dev string:xdb>" ] = "<dev string:xe0>";
        array[ "<dev string:xef>" ] = "<dev string:xf4>";
        array[ "<dev string:x103>" ] = "<dev string:x109>";
        array[ "<dev string:x119>" ] = "<dev string:x11f>";
        array[ "<dev string:x12f>" ] = "<dev string:x135>";
        array[ "<dev string:x145>" ] = "<dev string:x152>";
        array[ "<dev string:x161>" ] = "<dev string:x16f>";
        array[ "<dev string:x180>" ] = "<dev string:x18e>";
        array[ "<dev string:x19f>" ] = "<dev string:x1ad>";
        array[ "<dev string:x1be>" ] = "<dev string:x1cc>";
        array[ "<dev string:x1dd>" ] = "<dev string:x1eb>";
        array[ "<dev string:x1fc>" ] = "<dev string:x20a>";
        array[ "<dev string:x21b>" ] = "<dev string:x229>";
        array[ "<dev string:x23a>" ] = "<dev string:x248>";
        array[ "<dev string:x259>" ] = "<dev string:x25e>";
        array[ "<dev string:x26d>" ] = "<dev string:x271>";
        array[ "<dev string:x27f>" ] = "<dev string:x287>";
        array[ "<dev string:x299>" ] = "<dev string:x29f>";
        array[ "<dev string:x2af>" ] = "<dev string:x2b4>";
        array[ "<dev string:x2c3>" ] = "<dev string:x2c8>";
        array[ "<dev string:x2d7>" ] = "<dev string:x2dc>";
        array[ "<dev string:x2eb>" ] = "<dev string:x2f1>";
        array[ "<dev string:x301>" ] = "<dev string:x307>";
        array[ "<dev string:x317>" ] = "<dev string:x31f>";
        array[ "<dev string:x32f>" ] = "<dev string:x338>";
        array[ "<dev string:x349>" ] = "<dev string:x351>";
        array[ "<dev string:x361>" ] = "<dev string:x369>";
        array[ "<dev string:x379>" ] = "<dev string:x382>";
        skinref = undefined;
        dvar = hashcat( @"hash_e340a5ee5afde790", self getentitynumber() );
        dvarval = getdvar( dvar );
        
        if ( dvarval != "<dev string:x396>" && isdefined( array[ dvarval ] ) )
        {
            skinref = array[ dvarval ];
        }
        else
        {
            randomkey = utility::array_random( getarraykeys( array ) );
            skinref = array[ randomkey ];
        }
        
        operatorref = operator::function_30f20ce375c4ee40( skinref );
        operator::createoperatorcustomization( operatorref, undefined );
        class::giveloadout( self.team, self.class, undefined, undefined, 0 );
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xdc001c01, Offset: 0x663
    // Size: 0x65, Type: dev
    function devgui_play_ending()
    {
        host = gamelogic_mp::gethostplayer();
        setdvarifuninitialized( @"hash_5d7942ff9a328997", 1 );
        
        if ( !isdefined( level.var_45f0ba87452c0478 ) )
        {
            level personal_bests::function_89f89d7adb07dcc0();
        }
        
        br_ending::play_ending( teams::getteamdata( host.team, "<dev string:x397>" ), host.origin );
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xbd69ea18, Offset: 0x6d0
    // Size: 0x445, Type: dev
    function debug_exfil()
    {
        self notify( #"hash_6fcde6e51c0b10f7" );
        self endon( #"hash_6fcde6e51c0b10f7" );
        devgui::function_9082edeb5db93280( "<dev string:x39f>" );
        devgui::add_devgui_func( "<dev string:x3a9>", "<dev string:x3c0>", &devgui_play_ending );
        devgui::function_77df7fe7dd273e10();
        var_e1ab4b65bff18be2 = 0;
        var_2c7ad727ac7c508 = 0;
        
        while ( !isdefined( level.players ) || level.players.size == 0 )
        {
            wait 1;
        }
        
        while ( true )
        {
            wait 0.1;
            
            if ( !var_2c7ad727ac7c508 && !var_e1ab4b65bff18be2 && getdvarint( @"scr_br_ending_placement" ) )
            {
                level.br_ending_debugmode = 1;
                thread function_e923f7db519106c6( "<dev string:x3cf>" );
                var_e1ab4b65bff18be2 = 1;
                thread function_d73f567b685181cb();
                
                foreach ( player in level.players )
                {
                    if ( player ishost() )
                    {
                        player thread function_50807ec2dc09dc0d();
                    }
                }
            }
            else if ( var_e1ab4b65bff18be2 && !getdvarint( @"scr_br_ending_placement" ) )
            {
                var_e1ab4b65bff18be2 = 0;
                level notify( #"hash_86080952b9a43f19" );
                thread function_e923f7db519106c6( "<dev string:x3ec>", 3 );
                level.br_ending_debugmode = undefined;
            }
            else if ( !var_e1ab4b65bff18be2 && !var_2c7ad727ac7c508 && getdvarint( @"hash_2d200a3da7fb2518" ) )
            {
                level.br_ending_debugmode = 1;
                mode = getdvarint( @"hash_2d200a3da7fb2518" );
                
                if ( mode == 2 )
                {
                    debug_show_locations();
                }
                else
                {
                    function_b6e168243bf8e936();
                }
                
                level.br_ending_debugmode = undefined;
            }
            else if ( !var_e1ab4b65bff18be2 && !var_2c7ad727ac7c508 && getdvarint( @"scr_br_ending_play" ) )
            {
                player = level.players[ 0 ];
                winners = teams::getteamdata( player.team, "<dev string:x397>" );
                exfiltype = br_ending::get_exfil_type();
                transientname = get_ending_transient( exfiltype );
                loadinfiltransient( transientname );
                
                for ( var_9c9751620202d0b9 = 0; !var_9c9751620202d0b9 ; var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( transientname ) )
                {
                    waitframe();
                }
                
                br_ending::play_ending( winners, player.origin );
                setdvar( @"scr_br_ending_play", 0 );
                level notify( #"hash_3e26dfc193b4fd86" );
            }
            
            if ( getdvarint( @"hash_9f63b6e7903d0e54", -1 ) > -1 )
            {
                killnum = getdvarint( @"hash_9f63b6e7903d0e54" );
                
                foreach ( player in level.players )
                {
                    if ( killnum == player getentitynumber() )
                    {
                        if ( isalive( player ) )
                        {
                            player kill();
                            break;
                        }
                    }
                }
                
                setdvar( @"hash_9f63b6e7903d0e54", -1 );
            }
            
            if ( getdvarint( @"hash_c331bd97a07debe2", -1 ) > -1 )
            {
                kicknum = getdvarint( @"hash_c331bd97a07debe2" );
                println( "<dev string:x40a>" + kicknum );
                
                foreach ( player in level.players )
                {
                    if ( kicknum == player getentitynumber() )
                    {
                        kick( kicknum, "<dev string:x41a>" );
                        break;
                    }
                }
                
                setdvar( @"hash_c331bd97a07debe2", -1 );
            }
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xd58ab80b, Offset: 0xb1d
    // Size: 0x80c, Type: dev
    function function_50807ec2dc09dc0d()
    {
        level endon( #"hash_86080952b9a43f19" );
        level.placeexfil = spawnstruct();
        level.placeexfil.var_3fbcb283c613ab1b = br_ending::get_ending_structs();
        level.placeexfil.var_8ed1681bfca46e95 = level.placeexfil.var_3fbcb283c613ab1b.size;
        level.placeexfil.var_4e6ac1c6c242696a = 0;
        
        foreach ( struct in level.placeexfil.var_3fbcb283c613ab1b )
        {
            if ( !isdefined( struct.angles ) )
            {
                struct.angles = ( 0, 0, 0 );
            }
        }
        
        exfiltype = br_ending::get_exfil_type();
        transientname = get_ending_transient( exfiltype );
        loadinfiltransient( transientname );
        
        for ( var_9c9751620202d0b9 = 0; !var_9c9751620202d0b9 ; var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( transientname ) )
        {
            waitframe();
        }
        
        if ( br_ending::function_ea8177920674d8ef( exfiltype ) )
        {
            level.placeexfil.collision_tests = get_collision_tests( exfiltype );
        }
        
        childthread cursor_think();
        
        while ( true )
        {
            waitframe();
            
            if ( self usebuttonpressed() )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    function_937ba3599d4541c3();
                }
                else if ( isdefined( level.placeexfil.cursor_highlight ) )
                {
                    function_37f3b24127eab2b1( level.placeexfil.cursor_highlight );
                    level.placeexfil.cursor_highlight = undefined;
                }
                else
                {
                    function_37f3b24127eab2b1();
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self weaponswitchbuttonpressed() )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    level.placeexfil.var_3fbcb283c613ab1b[ level.placeexfil.var_3fbcb283c613ab1b.size ] = level.placeexfil.placed_animstruct;
                    function_937ba3599d4541c3();
                }
                else
                {
                    endtime = gettime() + 2000;
                    
                    while ( gettime() < endtime && self weaponswitchbuttonpressed() )
                    {
                        waitframe();
                    }
                    
                    if ( self weaponswitchbuttonpressed() )
                    {
                        function_56f6fc211ffe222f();
                    }
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self fragbuttonpressed() )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    origin = level.placeexfil.placed_animstruct.origin;
                    angles = level.placeexfil.cursor_ang;
                    function_937ba3599d4541c3();
                    function_37f3b24127eab2b1();
                    level.placeexfil.placed_animstruct.origin = origin;
                    level.placeexfil.placed_animstruct.angles = angles;
                }
                else
                {
                    level.placeexfil.cursor_yaw_offset = angleclamp180( level.placeexfil.cursor_yaw_offset - 10 );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self secondaryoffhandbuttonpressed() )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    origin = level.placeexfil.placed_animstruct.origin;
                    angles = level.placeexfil.placed_animstruct.angles;
                    function_937ba3599d4541c3();
                    function_37f3b24127eab2b1();
                    level.placeexfil.placed_animstruct.origin = origin;
                    level.placeexfil.placed_animstruct.angles = angles;
                }
                else
                {
                    level.placeexfil.cursor_yaw_offset = angleclamp180( level.placeexfil.cursor_yaw_offset + 10 );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self buttonpressed( "<dev string:x42b>" ) )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    origin = level.placeexfil.placed_animstruct.origin + ( 0, 0, 6 );
                    angles = level.placeexfil.placed_animstruct.angles;
                    function_937ba3599d4541c3();
                    function_37f3b24127eab2b1();
                    level.placeexfil.placed_animstruct.origin = origin;
                    level.placeexfil.placed_animstruct.angles = angles;
                }
                else
                {
                    level.placeexfil.cursor_z_offset = int( level.placeexfil.cursor_z_offset + 6 );
                    iprintlnbold( "<dev string:x433>" + level.placeexfil.cursor_z_offset );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self buttonpressed( "<dev string:x448>" ) )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    origin = level.placeexfil.placed_animstruct.origin + ( 0, 0, -6 );
                    angles = level.placeexfil.placed_animstruct.angles;
                    function_937ba3599d4541c3();
                    function_37f3b24127eab2b1();
                    level.placeexfil.placed_animstruct.origin = origin;
                    level.placeexfil.placed_animstruct.angles = angles;
                }
                else
                {
                    level.placeexfil.cursor_z_offset = int( level.placeexfil.cursor_z_offset - 6 );
                    iprintlnbold( "<dev string:x433>" + level.placeexfil.cursor_z_offset );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self buttonpressed( "<dev string:x452>" ) )
            {
                level.placeexfil.cursor_z_offset = 0;
                iprintlnbold( "<dev string:x433>" + level.placeexfil.cursor_z_offset );
                wait 0.4;
                continue;
            }
            
            if ( self meleebuttonpressed() )
            {
                level.placeexfil.var_4e6ac1c6c242696a = !level.placeexfil.var_4e6ac1c6c242696a;
                setdvar( @"hash_71ca0b42fb912a31", level.placeexfil.var_4e6ac1c6c242696a );
                
                if ( level.placeexfil.var_4e6ac1c6c242696a )
                {
                    iprintlnbold( "<dev string:x45c>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x474>" );
                }
                
                wait 0.4;
                continue;
            }
            
            if ( self sprintbuttonpressed() )
            {
                if ( isdefined( level.placeexfil.placed_animstruct ) )
                {
                    endtime = gettime() + 2000;
                    
                    while ( gettime() < endtime && self sprintbuttonpressed() )
                    {
                        waitframe();
                    }
                    
                    iprintlnbold( "<dev string:x48d>" );
                    function_82cb7954abac7879( level.placeexfil.placed_animstruct );
                    wait 0.4;
                    continue;
                }
                
                function_e923f7db519106c6( "<dev string:x4b1>", 1 );
            }
        }
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0xbe6e595, Offset: 0x1331
    // Size: 0x220, Type: dev
    function get_collision_tests( exfiltype )
    {
        structs = [];
        bgbar = newhudelem();
        bgbar.vertalign = "<dev string:x4d4>";
        bgbar.horzalign = "<dev string:x4db>";
        bgbar.aligny = "<dev string:x4d4>";
        bgbar.x = -250;
        bgbar.y = 100;
        bgbar setshader( "<dev string:x4e2>", 500, 16 );
        bar = newhudelem();
        bar.vertalign = "<dev string:x4d4>";
        bar.horzalign = "<dev string:x4db>";
        bar.aligny = "<dev string:x4d4>";
        bar.x = -250 + int( 2 );
        bar.y = 100;
        bar.sort = 1;
        bar.maxwidth = 496;
        bar.maxheight = 12;
        bar setshader( "<dev string:x4e8>", 0, 12 );
        bar.percent = 0;
        level.placeexfil.bar = bar;
        argsarray = function_1a36a664977880a1( exfiltype );
        
        foreach ( i, argstruct in argsarray )
        {
            structs[ structs.size ] = create_startanim_struct( argstruct );
            adjust_bar( i / argsarray.size );
        }
        
        bar adjust_bar( 1 );
        waitframe();
        bgbar destroy();
        bar destroy();
        
        if ( isdefined( level.var_7564c00c38776fb6 ) )
        {
            level.var_7564c00c38776fb6.alpha = 0;
        }
        
        return structs;
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0x2f855a48, Offset: 0x1559
    // Size: 0x65, Type: dev
    function adjust_bar( percent )
    {
        bar = level.placeexfil.bar;
        bar.percent = percent;
        bar scaleovertime( 0.05, int( bar.maxwidth * percent ), bar.maxheight );
    }

    #using_animtree( "mp_vehicles_always_loaded" );

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0xa9ffded, Offset: 0x15c6
    // Size: 0x17, Type: dev
    function function_1f806af717f6f53f( argstruct )
    {
        self useanimtree( #animtree );
    }

    #using_animtree( "script_model" );

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0x2c9e2b83, Offset: 0x15e5
    // Size: 0x17, Type: dev
    function function_cc47c233d2dad47e( argstruct )
    {
        self useanimtree( #animtree );
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0x8252a6aa, Offset: 0x1604
    // Size: 0x32, Type: dev
    function use_anim_tree( argstruct )
    {
        if ( argstruct.usevehicleanimtree )
        {
            function_1f806af717f6f53f( argstruct );
            return;
        }
        
        function_cc47c233d2dad47e( argstruct );
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0x21c28d6b, Offset: 0x163e
    // Size: 0x313, Type: dev
    function create_startanim_struct( argstruct )
    {
        angles = ( 0, 0, 0 );
        origin = ( 0, 0, 0 );
        struct = spawnstruct();
        struct.argstruct = argstruct;
        bonename = argstruct.bonename ?? "<dev string:x4ee>";
        
        if ( isdefined( argstruct.numsegments ) )
        {
            assert( isdefined( argstruct.modelname ) );
            assert( argstruct.numsegments > 0 );
            model = spawn( "<dev string:x4f9>", origin );
            model.angles = angles;
            model setmodel( argstruct.modelname );
            model use_anim_tree( argstruct );
            model animscripted( argstruct.animref, origin, angles, argstruct.animref, undefined, undefined, 0, 0 );
            fracdiff = 1 / argstruct.numsegments;
            struct.path = [];
            
            for ( i = 0; i < argstruct.numsegments ; i++ )
            {
                model setanimtime( argstruct.animref, fracdiff * i );
                wait 0.1;
                boneorigin = model gettagorigin( bonename );
                
                if ( i > 0 )
                {
                    if ( distancesquared( struct.path[ struct.path.size - 1 ], boneorigin ) < 2500 )
                    {
                        continue;
                    }
                }
                
                struct.path[ struct.path.size ] = boneorigin;
            }
            
            model delete();
        }
        else if ( isdefined( argstruct.sphereradius ) )
        {
            model = spawn( "<dev string:x4f9>", origin );
            model.angles = angles;
            model setmodel( argstruct.modelname );
            model use_anim_tree( argstruct );
            model animscripted( argstruct.animref, origin, angles, argstruct.animref, undefined, undefined, 0, 0 );
            wait 0.1;
            model setanimtime( argstruct.animref, argstruct.animpct );
            wait 0.1;
            boneorigin = model gettagorigin( bonename );
            boneangles = model gettagangles( bonename );
            struct.origin = boneorigin;
            struct.angles = boneangles;
            model delete();
        }
        else
        {
            assert( isdefined( argstruct.cylinderradius ) );
            struct.origin = getstartorigin( origin, angles, argstruct.animref ) + ( 0, 0, 2 );
            struct.angles = getstartangles( origin, angles, argstruct.animref );
            waitframe();
        }
        
        return struct;
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x418c274e, Offset: 0x1959
    // Size: 0x16a, Type: dev
    function function_56f6fc211ffe222f()
    {
        startpos = ( -60000, -60000, 0 );
        structs = sortbydistance( level.placeexfil.var_3fbcb283c613ab1b, startpos );
        println( "<dev string:x506>" );
        println( "<dev string:x396>" );
        
        for ( i = 0; i < structs.size ; i++ )
        {
            if ( isdefined( structs[ i ].var_7187159a30090400 ) )
            {
                println( "<dev string:x55f>" + i + "<dev string:x569>" + structs[ i ].origin + "<dev string:x589>" + structs[ i ].angles + "<dev string:x58c>" );
                continue;
            }
            
            println( "<dev string:x55f>" + i + "<dev string:x569>" + structs[ i ].origin + "<dev string:x589>" + structs[ i ].angles + "<dev string:x593>" );
        }
        
        println( "<dev string:x396>" );
        total = structs.size;
        diff = total - level.placeexfil.var_8ed1681bfca46e95;
        thread function_e923f7db519106c6( "<dev string:x597>" + total + "<dev string:x5bb>" + diff, 8 );
        println( "<dev string:x5c2>" + total + "<dev string:x608>" + diff + "<dev string:x60f>" );
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x31d88f20, Offset: 0x1acb
    // Size: 0x220, Type: dev
    function function_937ba3599d4541c3()
    {
        exfiltype = br_ending::get_exfil_type();
        
        if ( !isdefined( level.placeexfil.placed_animstruct ) || !br_ending::function_e8228be037475bb0( exfiltype ) && !isdefined( level.placeexfil.placed_animstruct.packs ) )
        {
            return;
        }
        
        level.placeexfil.placed_animstruct notify( #"hash_94b93d1bf2fbbb59" );
        
        if ( !br_ending::function_e8228be037475bb0( exfiltype ) )
        {
            foreach ( pack in level.placeexfil.placed_animstruct.packs )
            {
                foreach ( ent in pack.ents )
                {
                    if ( !isdefined( ent ) )
                    {
                        continue;
                    }
                    
                    if ( isdefined( ent.linkedents ) )
                    {
                        utility::array_delete( ent.linkedents );
                    }
                    
                    ent delete();
                }
            }
            
            if ( isdefined( level.placeexfil.placed_animstruct.cam ) )
            {
                level.placeexfil.placed_animstruct.cam delete();
            }
            
            level.player cameraunlink();
            level.player stopxcam();
        }
        
        level.placeexfil.placed_animstruct = undefined;
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0xa6751809, Offset: 0x1cf3
    // Size: 0x3c, Type: dev
    function function_82cb7954abac7879( removestruct )
    {
        level.placeexfil.var_3fbcb283c613ab1b = arrayremove( level.placeexfil.var_3fbcb283c613ab1b, removestruct );
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0xd1a44d02, Offset: 0x1d37
    // Size: 0x108, Type: dev
    function function_37f3b24127eab2b1( structoverride )
    {
        if ( isdefined( structoverride ) )
        {
            animstruct = structoverride;
        }
        else
        {
            animstruct = spawnstruct();
            animstruct.origin = level.placeexfil.cursor_pos;
            animstruct.angles = level.placeexfil.cursor_ang;
        }
        
        animstruct.pack = spawnstruct();
        animstruct.pack.models = [];
        animstruct.pack.players = [];
        animstruct.pack.cams = [];
        animstruct.istemp = 1;
        level.placeexfil.placed_animstruct = animstruct;
        level.br_ending = animstruct;
        level.placeexfil.placed_animstruct function_dcc1777da33095c8();
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x86ea36b0, Offset: 0x1e47
    // Size: 0x176, Type: dev
    function function_dcc1777da33095c8()
    {
        self endon( #"hash_94b93d1bf2fbbb59" );
        waitframe();
        
        if ( level.script != "<dev string:x631>" && !isdefined( level.var_866b994abc905a9c ) )
        {
            function_84b30ed2552f7ec6();
        }
        
        players = level.var_866b994abc905a9c;
        self.winners = players;
        exfiltype = br_ending::get_exfil_type();
        br_ending::set_ending_pack( exfiltype, undefined );
        wait 1;
        
        if ( br_ending::function_e8228be037475bb0( exfiltype ) )
        {
            for ( i = 0; i < players.size ; i++ )
            {
                if ( !isdefined( players[ i ] ) )
                {
                    continue;
                }
                
                player = players[ i ];
                player setcinematicmotionoverride( "<dev string:x63e>" );
                player utility::hidehudenable();
            }
            
            childthread br_ending::play_scenesystem_scenes();
            return;
        }
        
        player = level.players[ 0 ];
        player_rigs = [];
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isdefined( players[ i ] ) )
            {
                continue;
            }
            
            player = players[ i ];
            player setcinematicmotionoverride( "<dev string:x63e>" );
            player utility::hidehudenable();
            
            if ( getdvarint( @"hash_dd3266b5409a856b" ) && player ishost() )
            {
                continue;
            }
            
            player br_ending_util::create_player_rig( player.animname, "<dev string:x647>", self );
            player_rigs[ player_rigs.size ] = player.player_rig;
        }
        
        childthread function_d667a544f7f5367d( players, player_rigs );
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x20f6a729, Offset: 0x1fc5
    // Size: 0x240, Type: dev
    function function_84b30ed2552f7ec6()
    {
        setdvar( @"testclients_godmode", 1 );
        setdvar( @"hash_81f3fefd0af8548e", 0 );
        setdvar( @"hash_a99be90c92d68967", 0 );
        setdvar( @"hash_33fe5ebb83d90648", 0 );
        setdvar( @"hash_43cd2bf145682550", 0 );
        setdvar( @"testclients_domove", 0 );
        setdvar( @"hash_75663a72eb414a9a", 0 );
        var_31b8544b63253dd4 = 4;
        dev_mp::spawn_test_clients( var_31b8544b63253dd4 );
        level.var_866b994abc905a9c = [];
        
        foreach ( player in level.players )
        {
            if ( istestclient( player ) )
            {
                level.var_866b994abc905a9c[ level.var_866b994abc905a9c.size ] = player;
            }
        }
        
        while ( true )
        {
            spawncount = 0;
            
            foreach ( player in level.var_866b994abc905a9c )
            {
                if ( player.hasspawned )
                {
                    spawncount++;
                }
            }
            
            if ( spawncount == level.var_866b994abc905a9c.size )
            {
                break;
            }
            
            waitframe();
        }
        
        foreach ( player in level.var_866b994abc905a9c )
        {
            player skydive_interrupt();
            player skydive_setdeploymentstatus( 0 );
            player skydive_setbasejumpingstatus( 0 );
            player skydive_autodeployoff();
        }
    }

    // Namespace br_ending_debug
    // Params 3
    // Checksum 0xe32c0fa8, Offset: 0x220d
    // Size: 0x3a, Type: dev
    function function_d667a544f7f5367d( players, player_rigs, play_once )
    {
        childthread function_d523e2b3b95b57d9();
        
        while ( true )
        {
            function_65157170bf822ee5( players, player_rigs );
        }
    }

    // Namespace br_ending_debug
    // Params 2
    // Checksum 0xb2988e68, Offset: 0x224f
    // Size: 0x56c, Type: dev
    function function_65157170bf822ee5( players, player_rigs )
    {
        level endon( #"hash_4ca2ba630ed7a645" );
        
        foreach ( pack in self.packs )
        {
            if ( isdefined( pack.startfunc ) )
            {
                [[ pack.startfunc ]]( pack.paramarray );
            }
            
            if ( pack.players.size > 0 )
            {
                pack.players = function_5713d46873b29625( pack.players );
                
                foreach ( player in pack.players )
                {
                    player dontinterpolate();
                    
                    if ( isdefined( player.linkedtoent ) )
                    {
                        player.linkedtoent thread anim_mp::anim_player_solo( player, player.player_rig, pack.anime, player.linkedtotag );
                        continue;
                    }
                    
                    thread anim_mp::anim_player_solo( player, player.player_rig, pack.anime );
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
                
                thread animation::anim_single( pack.ents, pack.anime );
            }
            
            shouldattach = 0;
            
            if ( !isdefined( level.placeexfil ) )
            {
                shouldattach = 1;
            }
            else if ( level.placeexfil.var_4e6ac1c6c242696a )
            {
                shouldattach = 1;
            }
            
            if ( isdefined( pack.xcamasset ) )
            {
                self.cam dontinterpolate();
                thread animation::anim_single_solo( self.cam, pack.anime );
                
                foreach ( player in level.players )
                {
                    player cameraunlink();
                }
                
                xcamlength = getxcamlength( pack.xcamasset );
                xcamlength -= 0.033;
                xcamlength -= xcamlength % 0.05;
                self.xcamasset = pack.xcamasset;
                self.xcamtime = gettime();
                
                if ( shouldattach )
                {
                    level.players[ 0 ] playxcam( pack.xcamasset, 0, self.origin, self.angles );
                    self.xcamactive = 1;
                }
                
                wait xcamlength;
            }
            else
            {
                foreach ( player in level.players )
                {
                    player stopxcam();
                }
                
                self.xcamasset = undefined;
                self.xcamtime = undefined;
                self.xcamactive = 0;
                
                if ( shouldattach )
                {
                    level.players[ 0 ] cameralinkto( self.cam, "<dev string:x65a>", 1, 1 );
                }
                
                self.cam dontinterpolate();
                animation::anim_single_solo( self.cam, pack.anime );
            }
            
            waitframe();
            
            if ( isdefined( pack.endfunc ) )
            {
                [[ pack.endfunc ]]( pack.var_3d181e279a220c81 );
            }
        }
        
        foreach ( player in level.players )
        {
            player.linkedtoent = undefined;
            player.linkedtotag = undefined;
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xad3b11cd, Offset: 0x27c3
    // Size: 0x115, Type: dev
    function function_d523e2b3b95b57d9()
    {
        wait 0.1;
        
        while ( true )
        {
            if ( level.placeexfil.var_4e6ac1c6c242696a )
            {
                if ( isdefined( self.xcamasset ) && isdefined( self.xcamtime ) )
                {
                    if ( !self.xcamactive )
                    {
                        timeoffset = ( gettime() - self.xcamtime ) * 0.001;
                        level.players[ 0 ] playxcam( self.xcamasset, 0, self.origin, self.angles, timeoffset );
                        self.xcamactive = 1;
                    }
                }
                else if ( isdefined( level.players[ 0 ].player_rig ) )
                {
                    level.players[ 0 ] cameralinkto( self.cam, "<dev string:x65a>", 1, 1 );
                }
            }
            else
            {
                level.players[ 0 ] cameraunlink();
                level.players[ 0 ] stopxcam();
                self.xcamactive = 0;
            }
            
            waitframe();
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x206b0a6b, Offset: 0x28e0
    // Size: 0x418, Type: dev
    function cursor_think()
    {
        level.placeexfil.cursor_yaw_offset = 0;
        level.placeexfil.cursor_z_offset = 0;
        level.placeexfil.cursor_pos = self.origin;
        level.placeexfil.cursor_ang = self.angles;
        level.placeexfil.cursor_highlight = undefined;
        maxdrawdist = 500000;
        var_162bac1a44c1ad71 = 1000;
        var_21e62892987fb453 = squared( var_162bac1a44c1ad71 );
        
        while ( true )
        {
            waitframe();
            update_cursor();
            level.placeexfil.cursor_pos += ( 0, 0, level.placeexfil.cursor_z_offset );
            level.placeexfil.cursor_ang = angleclamp180( self.angles + ( 0, level.placeexfil.cursor_yaw_offset, 0 ) );
            level.placeexfil.cursor_highlight = undefined;
            
            foreach ( index, struct in level.placeexfil.var_3fbcb283c613ab1b )
            {
                distsqrd = distance2dsquared( level.players[ 0 ].origin, struct.origin );
                
                if ( distsqrd < squared( maxdrawdist ) )
                {
                    if ( !isdefined( level.placeexfil.cursor_highlight ) && distance2dsquared( struct.origin, level.placeexfil.cursor_pos ) < 40000 )
                    {
                        level.placeexfil.cursor_highlight = struct;
                        level.placeexfil.cursor_pos = struct.origin;
                        level.placeexfil.cursor_ang = struct.angles;
                        continue;
                    }
                    
                    alpha = 1;
                    size = 32;
                    
                    if ( distsqrd > var_21e62892987fb453 )
                    {
                        if ( !isdefined( struct.var_7187159a30090400 ) )
                        {
                            draw_location_mark( struct.origin, alpha, size, ( 1, 1, 0 ), undefined, index );
                        }
                        else
                        {
                            draw_location_mark( struct.origin, alpha, size, undefined, undefined, index );
                        }
                        
                        continue;
                    }
                    
                    draw_node( struct.origin, struct.angles, ( 0.9, 0.9, 0.9 ), size, alpha );
                }
            }
            
            if ( isdefined( level.placeexfil.cursor_highlight ) )
            {
                function_7b5319987a462d7f();
                continue;
            }
            
            if ( isdefined( level.placeexfil.placed_animstruct ) )
            {
                draw_node( level.placeexfil.placed_animstruct.origin, level.placeexfil.placed_animstruct.angles, ( 1, 1, 0 ), 16, 0.8 );
                draw_node( level.placeexfil.placed_animstruct.origin, level.placeexfil.cursor_ang, ( 0.1, 0.9, 0.1 ), 16, 0.97 );
                continue;
            }
            
            function_79b0164b8bb922d9();
        }
    }

    // Namespace br_ending_debug
    // Params 6
    // Checksum 0x9d79989e, Offset: 0x2d00
    // Size: 0x11f, Type: dev
    function draw_location_mark( origin, alpha, size, color, serverduration, text )
    {
        if ( !isdefined( color ) )
        {
            color = ( 0.9, 0.9, 0.9 );
        }
        
        if ( !isdefined( serverduration ) )
        {
            serverduration = 1;
        }
        
        if ( distance2dsquared( level.players[ 0 ].origin, origin ) > 5.76e+08 )
        {
            return 0;
        }
        
        dist = distance2d( level.players[ 0 ].origin, origin );
        frac = ( dist - 24000 ) / -5.7597e+08;
        alpha = math::lerp( 1, 0.2, frac );
        
        if ( dist > 1000 )
        {
            frac = ( dist - 1000 ) / 29000;
            size = math::lerp( size, 100, frac );
            alpha = math::lerp( alpha, 0.5, frac );
        }
        
        if ( !isdefined( text ) )
        {
            text = "<dev string:x665>";
        }
        
        print3d( origin, text, color, alpha, size, serverduration );
        return 1;
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x742cc06, Offset: 0x2e27
    // Size: 0x283, Type: dev
    function function_7b5319987a462d7f()
    {
        if ( !isdefined( level.placeexfil.collision_tests ) )
        {
            draw_node( level.placeexfil.cursor_pos, level.placeexfil.cursor_ang, ( 1, 1, 0 ), 16 );
            return;
        }
        
        color = ( 1, 1, 0 );
        
        foreach ( test in level.placeexfil.collision_tests )
        {
            if ( isdefined( test.argstruct.numsegments ) )
            {
                continue;
            }
            
            origin = level.placeexfil.cursor_pos + rotatevector( test.origin, level.placeexfil.cursor_ang );
            angles = combineangles( level.placeexfil.cursor_ang, test.angles );
            
            if ( isdefined( test.argstruct.originoffset ) )
            {
                origin += test.argstruct.originoffset;
            }
            
            if ( isdefined( test.argstruct.cylinderradius ) )
            {
                cylinderradius = test.argstruct.cylinderradius;
                cylinderheight = test.argstruct.cylinderheight;
                cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, color );
                continue;
            }
            
            if ( isdefined( test.argstruct.sphereradius ) )
            {
                sphereradius = test.argstruct.sphereradius;
                sphere( origin, sphereradius, color );
            }
        }
        
        draw_node( level.placeexfil.cursor_pos, level.placeexfil.cursor_ang, color, 16 );
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xd984a2dc, Offset: 0x30b2
    // Size: 0x47b, Type: dev
    function function_79b0164b8bb922d9()
    {
        if ( !isdefined( level.placeexfil.collision_tests ) )
        {
            draw_node( level.placeexfil.cursor_pos, level.placeexfil.cursor_ang, ( 0.8, 0.8, 0.8 ), 16 );
            return;
        }
        
        okcolor = ( 0.8, 0.8, 0.8 );
        badcolor = ( 0.8, 0, 0 );
        warningcolor = ( 0.8, 0.8, 0 );
        floattracedist = -100;
        var_38bf967db75ba0d = abs( 2 / floattracedist );
        origin = undefined;
        
        foreach ( test in level.placeexfil.collision_tests )
        {
            if ( !isdefined( test.argstruct.numsegments ) )
            {
                origin = level.placeexfil.cursor_pos + rotatevector( test.origin, level.placeexfil.cursor_ang );
                
                if ( isdefined( test.argstruct.originoffset ) )
                {
                    origin += test.argstruct.originoffset;
                }
            }
            
            if ( isdefined( test.argstruct.numsegments ) )
            {
                for ( i = 0; i < test.path.size - 1 ; i++ )
                {
                    origin = level.placeexfil.cursor_pos + rotatevector( test.path[ i ], level.placeexfil.cursor_ang );
                    origin2 = level.placeexfil.cursor_pos + rotatevector( test.path[ i + 1 ], level.placeexfil.cursor_ang );
                    line( origin, origin2, ( 1, 1, 1 ), 1, 1 );
                }
                
                continue;
            }
            
            if ( isdefined( test.argstruct.cylinderradius ) )
            {
                cylinderradius = test.argstruct.cylinderradius;
                cylinderheight = test.argstruct.cylinderheight;
                contents = trace::create_default_contents( 1 );
                floatingtrace = trace::capsule_trace( origin, origin + ( 0, 0, floattracedist ), cylinderradius + 2, cylinderheight + 4, undefined, undefined, contents );
                
                if ( floatingtrace[ "<dev string:x667>" ] >= var_38bf967db75ba0d )
                {
                    cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, warningcolor );
                    print3d( origin, abs( floatingtrace[ "<dev string:x667>" ] * floattracedist ), warningcolor );
                }
                else if ( trace::capsule_trace_passed( origin, origin + ( 0, 0, 4 ), cylinderradius + 2, cylinderheight + 4, undefined, undefined, contents ) )
                {
                    cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, okcolor );
                }
                else
                {
                    cylinder( origin, origin + ( 0, 0, cylinderheight ), cylinderradius, badcolor );
                }
                
                continue;
            }
            
            if ( isdefined( test.argstruct.sphereradius ) )
            {
                contents = trace::create_default_contents( 1 );
                sphereradius = test.argstruct.sphereradius;
                
                if ( trace::sphere_trace_passed( origin, origin + ( 0, 0, 4 ), sphereradius, undefined, contents ) )
                {
                    sphere( origin, sphereradius, okcolor );
                    continue;
                }
                
                sphere( origin, sphereradius, badcolor );
            }
        }
        
        draw_node( level.placeexfil.cursor_pos, level.placeexfil.cursor_ang, ( 0.8, 0.8, 0.8 ), 16 );
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xa18b7592, Offset: 0x3535
    // Size: 0xa9, Type: dev
    function update_cursor()
    {
        start = self geteye();
        forward = anglestoforward( self getplayerangles() );
        start += forward * 30;
        end = start + forward * 20000;
        contents = trace::create_default_contents( 1 );
        trace = trace::ray_trace_detail( start, end, undefined, contents );
        phys_trace = trace[ "<dev string:x670>" ];
        
        if ( distance( trace[ "<dev string:x670>" ], phys_trace ) < 0.1 )
        {
            level.placeexfil.cursor_pos = phys_trace;
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x2ddbb57c, Offset: 0x35e6
    // Size: 0x30d, Type: dev
    function function_d73f567b685181cb()
    {
        minx = min( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        maxx = max( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        miny = min( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxy = max( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxz = parachute::getc130height();
        minz = parachute::getc130sealevel() - 5000;
        spacing = 4000;
        points = [];
        pos = ( minx, miny, maxz );
        rownum = 0;
        
        while ( getdvarint( @"scr_br_ending_placement" ) > 0 )
        {
            droppedpos = utility::drop_to_ground( pos, 0, -20000 );
            
            if ( droppedpos[ 2 ] > minz && !outofbounds::ispointinoutofbounds( droppedpos ) )
            {
                points[ points.size ] = droppedpos;
            }
            
            pos += ( spacing, 0, 0 );
            
            if ( pos[ 0 ] > maxx )
            {
                rownum++;
                pos = ( minx, miny + rownum * spacing, maxz );
            }
            
            if ( pos[ 1 ] > maxy )
            {
                break;
            }
            
            waitframe();
        }
        
        setdvarifuninitialized( @"print3d_throttle", int( points.size / 4 ) );
        setdvarifuninitialized( @"hash_ef8fb66dfac2f050", 5 );
        
        while ( true )
        {
            throttleamount = getdvarint( @"print3d_throttle" );
            drawcount = 0;
            
            foreach ( point in points )
            {
                inrange = 0;
                
                if ( function_85c83bc9ed9c4cc1( point ) )
                {
                    inrange = draw_location_mark( point, 1, 24, ( 0, 1, 0 ), getdvarint( @"hash_ef8fb66dfac2f050" ) );
                }
                else
                {
                    inrange = draw_location_mark( point, 1, 24, ( 1, 0, 0 ), getdvarint( @"hash_ef8fb66dfac2f050" ) );
                }
                
                if ( inrange )
                {
                    drawcount++;
                    
                    if ( throttleamount > 0 && drawcount >= throttleamount )
                    {
                        drawcount = 0;
                        waitframe();
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0xe6b14233, Offset: 0x38fb
    // Size: 0xb4, Type: dev
    function function_85c83bc9ed9c4cc1( point )
    {
        range = 64000000;
        
        foreach ( struct in level.placeexfil.var_3fbcb283c613ab1b )
        {
            if ( distance2dsquared( point, struct.origin ) < range )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace br_ending_debug
    // Params 6
    // Checksum 0xbd08789, Offset: 0x39b7
    // Size: 0xc7, Type: dev
    function draw_node( pos, angles, color, size, alpha, depthtest )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( size ) )
        {
            size = 32;
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        up = anglestoup( angles );
        fwd = anglestoforward( angles );
        start = pos + up;
        end = start + fwd * size;
        draw_small_arrow( start, end, color, alpha, depthtest );
        draw_box( pos, color, angles, size, alpha, depthtest );
    }

    // Namespace br_ending_debug
    // Params 5
    // Checksum 0xc50d9bb0, Offset: 0x3a86
    // Size: 0x11e, Type: dev
    function draw_small_arrow( start, end, color, alpha, depthtest )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        angle = vectortoangles( end - start );
        dist = length( end - start );
        forward = anglestoforward( angle );
        forwardfar = forward * dist;
        arrow_size = 5;
        forwardclose = forward * ( dist - arrow_size );
        right = anglestoright( angle );
        leftdraw = right * arrow_size * -1;
        rightdraw = right * arrow_size;
        line( start, end, color, alpha, depthtest, 1 );
        line( start, start + forwardfar, color, alpha, depthtest, 1 );
        line( start + forwardfar, start + forwardclose + rightdraw, color, alpha, depthtest, 1 );
        line( start + forwardfar, start + forwardclose + leftdraw, color, alpha, depthtest, 1 );
    }

    // Namespace br_ending_debug
    // Params 6
    // Checksum 0xe9c4a2e1, Offset: 0x3bac
    // Size: 0x1f5, Type: dev
    function draw_box( pos, color, angles, size, alpha, depthtest )
    {
        if ( !isdefined( size ) )
        {
            width = 32;
            height = 32;
        }
        else if ( !isarray( size ) )
        {
            width = size;
            height = size;
        }
        else
        {
            width = size[ 0 ];
            height = size[ 1 ];
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        up = anglestoup( angles );
        start = pos + forward * width * 0.5;
        start += right * width * 0.5;
        start += up * height * -0.5;
        points = [];
        points[ points.size ] = start;
        points[ points.size ] = points[ points.size - 1 ] + forward * width * -1;
        points[ points.size ] = points[ points.size - 1 ] + right * width * -1;
        points[ points.size ] = points[ points.size - 1 ] + forward * width;
        offset = height * up;
        
        for ( i = 0; i < points.size ; i++ )
        {
            line( points[ i ], points[ i ] + offset, color, alpha, depthtest );
            
            if ( i == points.size - 1 )
            {
                line( points[ i ], points[ 0 ], color, alpha, depthtest );
                line( points[ i ] + offset, points[ 0 ] + offset, color, alpha, depthtest );
                continue;
            }
            
            line( points[ i ], points[ i + 1 ], color, alpha, depthtest );
            line( points[ i ] + offset, points[ i + 1 ] + offset, color, alpha, depthtest );
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x4277b7e9, Offset: 0x3da9
    // Size: 0x703, Type: dev
    function function_b6e168243bf8e936()
    {
        animstruct = spawnstruct();
        animstruct.istemp = 1;
        animstruct.origin = ( -500000, -500000, 0 );
        animstruct.angles = ( 0, 0, 0 );
        structs = br_ending::function_f72972bf5283c6b4( br_ending::get_exfil_type() );
        animstruct.origin = structs[ 0 ].origin;
        animstruct.angles = structs[ 0 ].angles;
        function_84b30ed2552f7ec6();
        players = level.var_866b994abc905a9c;
        thread function_e923f7db519106c6( "<dev string:x679>" );
        animstruct.winners = players;
        level.br_ending = animstruct;
        wait 1;
        player = level.players[ 0 ];
        player_rigs = [];
        exfiltype = br_ending::get_exfil_type();
        animstruct br_ending::set_ending_pack( exfiltype, undefined );
        level.var_f0150fb52a762f08[ "<dev string:x699>" ] = 0;
        level.var_f0150fb52a762f08[ "<dev string:x69e>" ] = 0;
        level.player thread function_79cea6d0dbe1e22b( animstruct );
        
        if ( br_ending::function_e8228be037475bb0( exfiltype ) )
        {
            player = level.players[ 0 ];
            player setcinematicmotionoverride( "<dev string:x63e>" );
            player utility::hidehudenable();
            index = 0;
            previndex = 0;
            
            while ( true )
            {
                var_b606c051d5d90eb1 = 0;
                
                if ( index < 0 )
                {
                    index = 0;
                    var_b606c051d5d90eb1 = 1;
                }
                else if ( index > structs.size - 1 )
                {
                    index = structs.size - 1;
                    var_b606c051d5d90eb1 = 1;
                }
                
                struct = structs[ index ];
                
                if ( isdefined( struct.var_7187159a30090400 ) && !var_b606c051d5d90eb1 )
                {
                    println( "<dev string:x6a4>" );
                    
                    if ( index < previndex )
                    {
                        index--;
                    }
                    else
                    {
                        index++;
                    }
                    
                    continue;
                }
                
                previndex = index;
                animstruct.origin = struct.origin;
                animstruct.angles = struct.angles;
                animstruct br_ending::set_ending_pack( exfiltype, undefined );
                waitframe();
                str = index + 1 + "<dev string:x6c9>" + structs.size + "<dev string:x6cd>" + animstruct.origin;
                thread function_e923f7db519106c6( str );
                animstruct br_ending::play_scenesystem_scenes();
                
                if ( level.var_f0150fb52a762f08[ "<dev string:x699>" ] )
                {
                    index--;
                }
                else
                {
                    index++;
                }
                
                level.var_f0150fb52a762f08[ "<dev string:x699>" ] = 0;
                level.var_f0150fb52a762f08[ "<dev string:x69e>" ] = 0;
            }
            
            return;
        }
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isdefined( players[ i ] ) )
            {
                continue;
            }
            
            player = players[ i ];
            player setcinematicmotionoverride( "<dev string:x63e>" );
            player utility::hidehudenable();
            player br_ending_util::create_player_rig( player.animname, "<dev string:x647>", animstruct );
            player_rigs[ player_rigs.size ] = player.player_rig;
            outofbounds::enableoobimmunity( player );
        }
        
        animstruct.cam delete();
        
        foreach ( pack in animstruct.packs )
        {
            foreach ( ent in pack.ents )
            {
                if ( !isdefined( ent ) )
                {
                    continue;
                }
                
                if ( isdefined( ent.linkedents ) )
                {
                    utility::array_delete( ent.linkedents );
                }
                
                ent delete();
            }
        }
        
        animstruct br_ending::set_ending_pack( exfiltype, undefined );
        index = 0;
        previndex = 0;
        
        while ( true )
        {
            if ( index < 0 )
            {
                index = 0;
            }
            else if ( index > structs.size - 1 )
            {
                index = structs.size - 1;
            }
            
            struct = structs[ index ];
            
            if ( isdefined( struct.var_7187159a30090400 ) )
            {
                println( "<dev string:x6a4>" );
                
                if ( index < previndex )
                {
                    index--;
                }
                else
                {
                    index++;
                }
                
                continue;
            }
            
            previndex = index;
            setomnvarforallclients( "<dev string:x6cf>", 0 );
            animstruct.origin = struct.origin;
            animstruct.angles = struct.angles;
            animstruct br_ending_util::chopperexfil_set_brcircle();
            animstruct.cam.origin = animstruct.origin;
            animstruct.cam stopanimscripted();
            animstruct animation::anim_first_frame_solo( animstruct.cam, animstruct.packs[ 0 ].anime );
            
            foreach ( player in players )
            {
                player thread br_ending::player_set_weapon();
                player cameraunlink();
                player stopxcam();
                player playerlinktodelta( player.player_rig, "<dev string:x65a>", 1, 0, 0, 0, 0, 1 );
                player.player_rig stopanimscripted();
                player.player_rig unlink();
                player.player_rig.origin = animstruct.origin;
                player.linkedtoent = undefined;
            }
            
            waitframe();
            
            if ( isdefined( level.players[ 0 ].player_rig ) )
            {
                level.players[ 0 ] cameralinkto( animstruct.cam, "<dev string:x65a>", 1, 1 );
            }
            
            waitframe();
            str = index + 1 + "<dev string:x6c9>" + structs.size + "<dev string:x6cd>" + animstruct.origin;
            thread function_e923f7db519106c6( str );
            animstruct function_65157170bf822ee5( players, player_rigs );
            
            if ( level.var_f0150fb52a762f08[ "<dev string:x699>" ] )
            {
                index--;
            }
            else
            {
                index++;
            }
            
            level.var_f0150fb52a762f08[ "<dev string:x699>" ] = 0;
            level.var_f0150fb52a762f08[ "<dev string:x69e>" ] = 0;
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0xfc3b19aa, Offset: 0x44b4
    // Size: 0x50, Type: dev
    function function_fca67c05fdfb62a()
    {
        num = self getentitynumber();
        
        while ( true )
        {
            line( self.origin, self.player_rig.origin );
            print3d( self.origin, num );
            waitframe();
        }
    }

    // Namespace br_ending_debug
    // Params 1
    // Checksum 0x293e761a, Offset: 0x450c
    // Size: 0xcb, Type: dev
    function function_79cea6d0dbe1e22b( animstruct )
    {
        self endon( #"disconnect" );
        
        while ( true )
        {
            if ( !level.var_f0150fb52a762f08[ "<dev string:x699>" ] && self buttonpressed( "<dev string:x6dd>" ) )
            {
                level.var_f0150fb52a762f08[ "<dev string:x69e>" ] = 1;
                level notify( #"hash_4ca2ba630ed7a645" );
                animstruct notify( #"hash_94b93d1bf2fbbb59" );
                wait 0.4;
            }
            else if ( !level.var_f0150fb52a762f08[ "<dev string:x69e>" ] && self buttonpressed( "<dev string:x6e8>" ) )
            {
                level.var_f0150fb52a762f08[ "<dev string:x699>" ] = 1;
                level notify( #"hash_4ca2ba630ed7a645" );
                animstruct notify( #"hash_94b93d1bf2fbbb59" );
                wait 0.4;
            }
            
            waitframe();
        }
    }

    // Namespace br_ending_debug
    // Params 2
    // Checksum 0x786946b7, Offset: 0x45df
    // Size: 0x13e, Type: dev
    function function_e923f7db519106c6( text, time )
    {
        level notify( #"new_debugprint" );
        level endon( #"new_debugprint" );
        
        if ( !isdefined( level.var_7564c00c38776fb6 ) )
        {
            level.var_7564c00c38776fb6 = newhudelem();
            level.var_7564c00c38776fb6.archived = 0;
            level.var_7564c00c38776fb6.vertalign = "<dev string:x4d4>";
            level.var_7564c00c38776fb6.horzalign = "<dev string:x4db>";
            level.var_7564c00c38776fb6.aligny = "<dev string:x4d4>";
            level.var_7564c00c38776fb6.alignx = "<dev string:x4db>";
            level.var_7564c00c38776fb6.y = 80;
            level.var_7564c00c38776fb6.fontscale = 1.2;
        }
        
        level.var_7564c00c38776fb6.alpha = 1;
        level.var_7564c00c38776fb6 setdevtext( text );
        println( text );
        
        if ( isdefined( time ) )
        {
            wait time;
            level.var_7564c00c38776fb6.alpha = 0;
        }
    }

    // Namespace br_ending_debug
    // Params 0
    // Checksum 0x3f9afdde, Offset: 0x4725
    // Size: 0x24b, Type: dev
    function debug_show_locations()
    {
        structs = br_ending::function_f72972bf5283c6b4( br_ending::get_exfil_type() );
        minx = min( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        maxx = max( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 0 ] );
        miny = min( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxy = max( level.br_level.br_mapbounds[ 1 ][ 1 ], level.br_level.br_mapbounds[ 0 ][ 1 ] );
        maxz = parachute::getc130height();
        midpointx = minx + ( maxx - minx ) * 0.5;
        midpointy = miny + ( maxy - miny ) * 0.5;
        origin = ( midpointx, midpointy, maxz );
        angles = ( 72, 90, 0 );
        
        if ( !level.player isnoclip() )
        {
            level.player noclip();
        }
        
        level.player setorigin( origin );
        level.player setplayerangles( angles );
        
        while ( getdvarint( @"hash_2d200a3da7fb2518" ) == 2 )
        {
            foreach ( struct in structs )
            {
                draw_location_mark( struct.origin, 1, 1000 );
            }
            
            waitframe();
        }
    }

#/
