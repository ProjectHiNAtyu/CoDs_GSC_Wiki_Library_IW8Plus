// scripts\mp\frontendutils.gsc  (hash_731d5900eb69583d.gscc) (size: 83018 Bytes / 0x1444a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf53ddae6 (4114471654)
// size ...... 83018 (0x1444a)
// includes .. 8   (offset: 0x12cd6)
// strings ... 261 (offset: 0x12d16)
// dev strs .. 96  (offset: 0x13f3a)
// exports ... 150 (offset: 0xe806)
// cseg ...... 0x267f + 0xc187 (0xe806)
// imports ... 312 (offset: 0xff76)
// animtree1 . 0   (offset: 0x1444a)
// animtree2 . 0   (offset: 0x1444a)
#using scripts\code\struct;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\frontendfiringrange;
#using scripts\mp\frontendwalkablespace;
#using scripts\mp\scene_frontend;

#namespace frontendutils;

// Namespace frontendutils
// Params 0
// Checksum 0x6a6197e5, Offset: 0x269d
// Size: 0xc1
function init_frontend_utils()
{
    /#
        setdevdvar( @"hash_728c3d23b689f98b", "<dev string:x24>" );
        setdevdvar( @"hash_d88c8215f8299404", "<dev string:x24>" );
        setdevdvar( @"hash_58304f79a99e8657", "<dev string:x24>" );
        setdevdvar( @"hash_548521177d62e3db", 0 );
        setdevdvar( @"hash_68e2d2fceab22753", 0 );
        setdevdvar( @"hash_b281f39ee3f3f20b", "<dev string:x24>" );
        setdevdvar( @"hash_89f5fb632c7ab167", "<dev string:x24>" );
        setdevdvar( @"hash_d7c75a291ea3ac1d", "<dev string:x24>" );
        setdevdvar( @"hash_8697513f4a2ac530", 0 );
        setdevdvar( @"hash_e379918c5595cef9", 0 );
    #/
    
    setup_initial_entities();
    struct::dummy();
}

/#

    // Namespace frontendutils
    // Params 0
    // Checksum 0xa63d628a, Offset: 0x2766
    // Size: 0x5e, Type: dev
    function dev_watch_scene()
    {
        while ( true )
        {
            var_a661c22541f0cc60 = getdvarint( @"hash_be485550bea2743", 0 );
            sceneroot = level;
            sceneplaying = sceneroot scene::get_state() == "<dev string:x25>";
            
            if ( !var_a661c22541f0cc60 && sceneplaying )
            {
                client_scene_stop();
            }
            
            waitframe();
        }
    }

    // Namespace frontendutils
    // Params 0
    // Checksum 0xe837400a, Offset: 0x27cc
    // Size: 0x62, Type: dev
    function function_1c648417bf9191d()
    {
        while ( true )
        {
            var_c7f7bb0d465ba9db = getdvarint( @"hash_349914f8fe26aa6b", -1 );
            
            if ( level.client_characters[ var_c7f7bb0d465ba9db ] )
            {
                var_f0b73c649149da9f = level.client_characters[ var_c7f7bb0d465ba9db ] getentitynumber();
                setdvar( @"hash_305a7db16a11dd02", var_f0b73c649149da9f );
            }
            
            waitframe();
        }
    }

    // Namespace frontendutils
    // Params 0
    // Checksum 0x9dec9f84, Offset: 0x2836
    // Size: 0x265, Type: dev
    function function_4dbf025e46bc2e18()
    {
        level.freecamactive = 0;
        
        while ( true )
        {
            freecamrequested = getdvarint( @"hash_7fda6d75e833692d" );
            
            if ( freecamrequested != level.freecamactive )
            {
                if ( freecamrequested )
                {
                    level.var_9ad00eb6a518bf32 = level.playerviewowner.origin;
                    level.var_9f0069409b7032b8 = level.playerviewowner.angles;
                    xcamdata = function_fcd62fd219292ac7();
                    
                    if ( isdefined( xcamdata ) )
                    {
                        camerapos = level.playerviewowner getxcamposition( xcamdata.name, 0, xcamdata.index, xcamdata.entity.origin, xcamdata.entity.angles );
                        cameraangles = level.playerviewowner getxcamangles( xcamdata.name, 0, xcamdata.index, xcamdata.entity.origin, xcamdata.entity.angles );
                    }
                    else
                    {
                        camerapos = level.camera_anchor.origin;
                        cameraangles = level.camera_anchor.angles;
                    }
                    
                    setdvar( @"hash_f83aafe36491d7eb", 1 );
                    setdvar( @"lui_enabled", 0 );
                    
                    if ( !level.playerviewowner isufo() )
                    {
                        level.playerviewowner ufo();
                    }
                    
                    if ( isdefined( camerapos ) && isdefined( cameraangles ) )
                    {
                        level.playerviewowner setorigin( camerapos );
                        level.playerviewowner setplayerangles( cameraangles );
                    }
                }
                else
                {
                    level.playerviewowner setorigin( level.var_9ad00eb6a518bf32 );
                    level.playerviewowner setplayerangles( level.var_9f0069409b7032b8 );
                    level.var_9ad00eb6a518bf32 = undefined;
                    level.var_9f0069409b7032b8 = undefined;
                    setdvar( @"hash_f83aafe36491d7eb", 0 );
                    setdvar( @"lui_enabled", 1 );
                    
                    if ( level.playerviewowner isufo() )
                    {
                        level.playerviewowner ufo();
                    }
                }
                
                level.freecamactive = freecamrequested;
            }
            
            waitframe();
        }
    }

    // Namespace frontendutils
    // Params 0
    // Checksum 0x7a7685c1, Offset: 0x2aa3
    // Size: 0x1f1, Type: dev
    function function_14388ba735303707()
    {
        if ( !isdefined( level.transitionarray ) )
        {
            println( "<dev string:x2d>" );
            return;
        }
        
        println( "<dev string:x57>" );
        toscenes = getarraykeys( level.transitionarray );
        
        foreach ( toscene in toscenes )
        {
            frommap = level.transitionarray[ toscene ];
            fromscenes = getarraykeys( frommap );
            
            foreach ( fromscene in fromscenes )
            {
                entry = frommap[ fromscene ];
                fov = entry[ "<dev string:x79>" ];
                speed = entry[ "<dev string:x7d>" ];
                transition = entry[ "<dev string:x83>" ];
                ignore = entry[ "<dev string:x8e>" ];
                firstxcam = entry[ "<dev string:x95>" ];
                println( "<dev string:xa4>" + toscene + "<dev string:xb2>" + fromscene + "<dev string:xb9>" + fov + "<dev string:xbf>" + speed + "<dev string:xc7>" + transition + "<dev string:xcf>" + ignore + "<dev string:xd5>" + firstxcam );
            }
        }
        
        println( "<dev string:xdc>" );
    }

    // Namespace frontendutils
    // Params 0
    // Checksum 0xb046511c, Offset: 0x2c9c
    // Size: 0xcc, Type: dev
    function function_329cf40cb5d3f853()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_8697513f4a2ac530", 0 ) )
            {
                println( "<dev string:xf2>" + getdvar( @"hash_728c3d23b689f98b", "<dev string:xfc>" ) + "<dev string:xfe>" + getdvar( @"hash_d7c75a291ea3ac1d", "<dev string:xfc>" ) + "<dev string:xd5>" + getdvar( @"hash_b281f39ee3f3f20b", "<dev string:xfc>" ) + "<dev string:x107>" + getdvar( @"hash_89f5fb632c7ab167", "<dev string:xfc>" ) + "<dev string:xc7>" + getdvar( @"hash_58304f79a99e8657", "<dev string:xfc>" ) );
            }
            
            if ( getdvarint( @"hash_e379918c5595cef9", 0 ) )
            {
                function_14388ba735303707();
                setdvar( @"hash_e379918c5595cef9", 0 );
            }
            
            wait 1;
        }
    }

#/

// Namespace frontendutils
// Params 1
// Checksum 0x47947846, Offset: 0x2d70
// Size: 0x2f
function client_scene_begin_transition( fadetime = 0.1 )
{
    frontendscenecamerafade( 0, fadetime );
    wait fadetime;
    setomnvar( "frontend_screen_black", 1 );
}

// Namespace frontendutils
// Params 1
// Checksum 0x372210f6, Offset: 0x2da7
// Size: 0x37
function client_scene_end_transition( delayms )
{
    fadetime = delayms ?? 100;
    frontendscenecamerafade( 1, fadetime / 1000 );
    setomnvar( "frontend_screen_black", 0 );
}

// Namespace frontendutils
// Params 2
// Checksum 0xd894fdff, Offset: 0x2de6
// Size: 0x190
function client_scene_play( scenename, args )
{
    channel = args[ 0 ];
    isimmediate = int( args[ 1 ] ) == 1;
    xcamtrack = args[ 2 ];
    var_8321226cd0f0bdd1 = int( args[ 3 ] ) == 1;
    var_818b09b2457de0cf = int( args[ 4 ] );
    var_b977457fdcd3c3f2 = int( args[ 5 ] ) == 1;
    shots = [];
    
    for ( i = 6; i < args.size ; i++ )
    {
        shots[ shots.size ] = args[ i ];
    }
    
    if ( shots.size == 0 )
    {
        shots = undefined;
    }
    
    if ( isdefined( scenename ) )
    {
        var_8e59acd7d1867d65 = 0;
        var_98310b34701e24fc = 0;
        var_2566aef03bf14c21 = 1;
        
        if ( var_8321226cd0f0bdd1 )
        {
            var_98310b34701e24fc = !isdefined( level.var_e1ef2c5e3a98354e );
            var_8e59acd7d1867d65 = 1;
            var_2566aef03bf14c21 = 0;
        }
        else
        {
            var_98310b34701e24fc = client_scene_stop_internal( isimmediate, var_b977457fdcd3c3f2 );
            var_8e59acd7d1867d65 = var_98310b34701e24fc;
        }
        
        if ( var_98310b34701e24fc )
        {
            level.var_e1ef2c5e3a98354e = spawnstruct();
        }
        
        if ( var_8e59acd7d1867d65 )
        {
            level.var_e1ef2c5e3a98354e scene::set_scriptbundle( scenename, var_2566aef03bf14c21 );
            
            if ( xcamtrack && xcamtrack.size > 0 )
            {
                level.var_e1ef2c5e3a98354e scene::function_a2a5e7f267b0ca05( xcamtrack );
            }
            
            level.var_e1ef2c5e3a98354e scene::function_84e9d861f1358910( shots, var_818b09b2457de0cf );
            level.var_e1ef2c5e3a98354e thread scene::play( undefined, shots, scenename, undefined );
            setomnvar( "ui_client_scene_ready_1", gettime() );
        }
    }
}

// Namespace frontendutils
// Params 2
// Checksum 0x3e47ff53, Offset: 0x2f7e
// Size: 0x4d
function client_scene_stop( immediate, args )
{
    self notify( #"hash_4fedce4c71bd8a66" );
    self endon( #"hash_4fedce4c71bd8a66" );
    var_b977457fdcd3c3f2 = int( args[ 1 ] ) == 1;
    return client_scene_stop_internal( immediate, var_b977457fdcd3c3f2 );
}

// Namespace frontendutils
// Params 2
// Checksum 0xd7bc6101, Offset: 0x2fd4
// Size: 0x1ca, Type: bool
function client_scene_stop_internal( immediate, var_b977457fdcd3c3f2 )
{
    self notify( #"hash_5195d6c4682263b5" );
    self endon( #"hash_5195d6c4682263b5" );
    level notify( #"camera_teleport" );
    
    if ( !immediate )
    {
        client_scene_begin_transition();
    }
    else if ( !var_b977457fdcd3c3f2 )
    {
        client_scene_begin_transition( 0 );
    }
    
    if ( isdefined( level.var_e1ef2c5e3a98354e ) )
    {
        level.var_e1ef2c5e3a98354e scene::stop();
        level.var_e1ef2c5e3a98354e scene::cleanup();
    }
    
    if ( isdefined( level.var_a68b535c077ea5c7 ) )
    {
        level.var_a68b535c077ea5c7 scene::stop();
        level.var_a68b535c077ea5c7 scene::cleanup();
    }
    
    if ( isdefined( level.var_3807038a8b9f5e45 ) )
    {
        level.var_3807038a8b9f5e45 scene::stop();
        level.var_3807038a8b9f5e45 scene::cleanup();
    }
    
    if ( isdefined( level.var_aa8940dcfbcb5821 ) )
    {
        level.var_aa8940dcfbcb5821 scene::stop();
        level.var_aa8940dcfbcb5821 scene::cleanup();
    }
    
    foreach ( character in level.client_characters )
    {
        if ( isdefined( character ) )
        {
            character function_de4866729f37f5d2( 1 );
        }
    }
    
    end_current_xcam();
    
    if ( isdefined( level.playerviewowner ) )
    {
        level.playerviewowner cameralinkto( level.camera_anchor, "tag_origin" );
    }
    
    setomnvar( "ui_client_scene_ready_1", gettime() );
    return true;
}

// Namespace frontendutils
// Params 2
// Checksum 0x71c65086, Offset: 0x31a7
// Size: 0x2eb
function operator_scene_play( scenename, args )
{
    if ( !isdefined( level.var_a68b535c077ea5c7 ) )
    {
        level.var_a68b535c077ea5c7 = spawnstruct();
    }
    
    if ( !isdefined( level.var_3807038a8b9f5e45 ) )
    {
        level.var_3807038a8b9f5e45 = spawnstruct();
    }
    
    channel = args[ 0 ];
    faction = args[ 1 ];
    shottype = args[ 2 ];
    resetcharacter = args[ 3 ] == "true";
    var_4f5d892f1378b0c7 = args[ 4 ] == "true";
    sceneroot = undefined;
    var_877769e93149cb16 = undefined;
    shots = undefined;
    
    if ( var_4f5d892f1378b0c7 )
    {
        if ( faction == "west" )
        {
            alignent = getent( "charroom_char_tango_scene_west_cer", #targetname );
        }
        else if ( faction == "east" )
        {
            alignent = getent( "charroom_char_tango_scene_east_cer", #targetname );
        }
        
        var_877769e93149cb16 = "ui_client_scene_ready_1";
        level.var_a68b535c077ea5c7 scene::cleanup();
        level.var_3807038a8b9f5e45 scene::cleanup();
        level.client_characters[ 15 ] function_de4866729f37f5d2( 0 );
        level.client_characters[ 14 ] function_de4866729f37f5d2( 0 );
    }
    
    if ( faction == "west" )
    {
        sceneroot = level.var_a68b535c077ea5c7;
        
        if ( !isdefined( var_877769e93149cb16 ) )
        {
            var_877769e93149cb16 = "ui_client_scene_ready_1";
        }
        
        scenecharacter = level.client_characters[ 14 ];
    }
    else if ( faction == "east" )
    {
        sceneroot = level.var_3807038a8b9f5e45;
        
        if ( !isdefined( var_877769e93149cb16 ) )
        {
            var_877769e93149cb16 = "ui_client_scene_ready_2";
        }
        
        scenecharacter = level.client_characters[ 15 ];
    }
    
    if ( !isdefined( alignent ) )
    {
        alignent = getent( "charroom_char_tango_scene_center_cer", #targetname );
    }
    
    assert( isdefined( alignent ) );
    sceneroot.origin = alignent.origin;
    sceneroot.angles = alignent.angles;
    
    if ( shottype == "select" )
    {
        shots = [ "intro", "loop" ];
    }
    else
    {
        shots = [ "conf_intro", "conf_loop" ];
    }
    
    sceneroot notify( #"operator_scene_play" );
    sceneroot endon( #"operator_scene_play" );
    setomnvar( var_877769e93149cb16, gettime() );
    
    if ( isdefined( sceneroot ) && !var_4f5d892f1378b0c7 )
    {
        sceneroot scene::cleanup();
    }
    
    if ( isdefined( level.var_e1ef2c5e3a98354e ) )
    {
        level.var_e1ef2c5e3a98354e scene::stop();
        level.var_e1ef2c5e3a98354e scene::cleanup();
    }
    
    sceneroot.script_scenescriptbundle = scenename;
    sceneroot scene::function_f40e088831060345( 0 );
    sceneroot childthread scene::play( undefined, shots, scenename );
    scenecharacter function_de4866729f37f5d2( 1 );
    
    if ( resetcharacter )
    {
        scenecharacter dontinterpolate();
    }
}

// Namespace frontendutils
// Params 3
// Checksum 0x698d3fcf, Offset: 0x349a
// Size: 0x46
function operator_scene_stop_internal( sceneroot, scenecharacter, var_877769e93149cb16 )
{
    if ( isdefined( sceneroot ) )
    {
        sceneroot scene::cleanup();
    }
    
    if ( isdefined( scenecharacter ) )
    {
        scenecharacter function_de4866729f37f5d2( 0 );
    }
    
    setomnvar( var_877769e93149cb16, gettime() );
}

// Namespace frontendutils
// Params 2
// Checksum 0xf6808e49, Offset: 0x34e8
// Size: 0xc6
function operator_scene_stop( unused, args )
{
    channel = args[ 0 ];
    faction = args[ 1 ];
    
    if ( !isdefined( faction ) || faction == "west" )
    {
        sceneroot = level.var_a68b535c077ea5c7;
        scenecharacter = level.client_characters[ 14 ];
        var_877769e93149cb16 = "ui_client_scene_ready_1";
        operator_scene_stop_internal( sceneroot, scenecharacter, var_877769e93149cb16 );
    }
    
    if ( !isdefined( faction ) || faction == "east" )
    {
        sceneroot = level.var_3807038a8b9f5e45;
        scenecharacter = level.client_characters[ 15 ];
        var_877769e93149cb16 = "ui_client_scene_ready_2";
        operator_scene_stop_internal( sceneroot, scenecharacter, var_877769e93149cb16 );
    }
}

// Namespace frontendutils
// Params 0
// Checksum 0x47c6da21, Offset: 0x35b6
// Size: 0xd1
function item_preview_scene_stop_internal()
{
    if ( !isdefined( level.var_aa8940dcfbcb5821 ) )
    {
        level.var_aa8940dcfbcb5821 = spawnstruct();
    }
    
    scenecharacters = level.var_aa8940dcfbcb5821 scene::function_48ea223b2dfda0();
    
    if ( isdefined( scenecharacters ) )
    {
        foreach ( character in scenecharacters )
        {
            level.client_characters[ character.characterindex - 1 ] function_de4866729f37f5d2( 0 );
        }
    }
    
    level.var_aa8940dcfbcb5821 scene::cleanup();
}

// Namespace frontendutils
// Params 2
// Checksum 0x8e98420a, Offset: 0x368f
// Size: 0x71
function item_preview_scene_stop( fadeouttime, args )
{
    self notify( #"hash_b5ced846efb51353" );
    self endon( #"hash_b5ced846efb51353" );
    channel = args[ 0 ];
    fadeouttime = ( fadeouttime ?? 0 ) / 1000;
    
    if ( fadeouttime >= 0.05 )
    {
        client_scene_begin_transition( fadeouttime );
    }
    
    item_preview_scene_stop_internal();
    setomnvar( "ui_client_scene_ready_2", gettime() );
}

// Namespace frontendutils
// Params 2
// Checksum 0x3a10e0c3, Offset: 0x3708
// Size: 0x12e
function item_preview_scene_play( scenename, args )
{
    channel = args[ 0 ];
    
    if ( !isdefined( level.var_aa8940dcfbcb5821 ) )
    {
        level.var_aa8940dcfbcb5821 = spawnstruct();
    }
    
    if ( isdefined( scenename ) )
    {
        item_preview_scene_stop_internal();
        level.var_aa8940dcfbcb5821.script_scenescriptbundle = scenename;
        scenecharacters = level.var_aa8940dcfbcb5821 scene::function_48ea223b2dfda0();
        
        if ( isdefined( scenecharacters ) )
        {
            foreach ( character in scenecharacters )
            {
                level.client_characters[ character.characterindex - 1 ] function_de4866729f37f5d2( 1 );
            }
        }
        
        level.var_aa8940dcfbcb5821 thread scene::play( undefined, undefined, scenename );
        setomnvar( "ui_client_scene_ready_1", gettime() );
        client_scene_end_transition();
    }
}

// Namespace frontendutils
// Params 2
// Checksum 0x953430a1, Offset: 0x383e
// Size: 0x203
function function_e61ab3600302cfb0( unused, args )
{
    level notify( #"xcam_transition" );
    level endon( #"xcam_transition" );
    channel = args[ 0 ];
    xcamref = args[ 1 ];
    alignref = args[ 2 ];
    blendtime = float( args[ 3 ] ?? 0.1 );
    fov = args[ 4 ] ? float( args[ 4 ] ) : undefined;
    fstop = args[ 5 ] ? float( args[ 5 ] ) : undefined;
    focusdistance = args[ 6 ] ? float( args[ 6 ] ) : undefined;
    focusspeed = args[ 7 ] ? float( args[ 7 ] ) : undefined;
    aperturespeed = args[ 8 ] ? float( args[ 8 ] ) : undefined;
    fadeouttime = args[ 9 ] ? float( args[ 9 ] ) : undefined;
    fadeintime = args[ 10 ] ? float( args[ 10 ] ) : undefined;
    
    if ( fadeouttime > 0 )
    {
        frontendscenecamerafade( 0, fadeouttime );
        wait fadeouttime;
    }
    
    if ( isdefined( xcamref ) && isdefined( alignref ) )
    {
        alignent = frontend_camera_get_entity( alignref );
        level.xcam_anchor.origin = alignent.origin;
        level.xcam_anchor.angles = alignent.angles;
        set_xcam_wrapper( xcamref, 0, blendtime, level.xcam_anchor );
        wait blendtime;
    }
    
    if ( isdefined( fov ) )
    {
        frontendscenecamerafov( fov, blendtime );
    }
    
    if ( isdefined( fstop ) && isdefined( focusdistance ) )
    {
        self setphysicaldepthoffield( fstop, focusdistance, focusspeed, aperturespeed );
    }
    
    if ( fadeintime > 0 )
    {
        frontendscenecamerafade( 1, fadeintime );
    }
    
    level.transition_interrupted = 0;
}

// Namespace frontendutils
// Params 2
// Checksum 0x736a44a6, Offset: 0x3a49
// Size: 0x68
function function_49ac8cd8d3cc2474( unused, args )
{
    channel = args[ 0 ];
    pbgbank = int( args[ 1 ] );
    transitiontime = int( args[ 2 ] );
    
    if ( pbgbank < 1 || pbgbank > 8 )
    {
        pbgbank = 1;
    }
    
    function_ad915db840c90fb3( 1023, pbgbank, transitiontime );
}

// Namespace frontendutils
// Params 2
// Checksum 0x733982d0, Offset: 0x3ab9
// Size: 0x10b
function function_c788a94f8af5678e( statekey, args )
{
    channel = args[ 0 ];
    scriptablename = args[ 1 ];
    partname = args[ 2 ];
    assert( isdefined( scriptablename ) );
    assert( isdefined( partname ) );
    assert( isdefined( statekey ) );
    scriptables = getscriptablearray( "scriptable_" + scriptablename, #classname );
    
    if ( scriptables.size == 0 )
    {
        scriptables = getscriptablearray( scriptablename, #classname );
    }
    
    foreach ( scriptable in scriptables )
    {
        scriptable utility::function_7c10ea82c1e305b8( partname, statekey );
    }
}

/#

    // Namespace frontendutils
    // Params 2, eflags: 0x4
    // Checksum 0x81b708, Offset: 0x3bcc
    // Size: 0xf2, Type: dev
    function private function_4aff0eb9296c6f1f( arg, msg )
    {
        posdelta = strtok( arg, "<dev string:x110>" );
        
        if ( !posdelta )
        {
            return;
        }
        
        if ( !level.entmap )
        {
            level.entmap = [ "<dev string:x112>", "<dev string:x11b>", "<dev string:x123>", "<dev string:x12c>" ];
        }
        
        currentlobby = int( posdelta[ 0 ] );
        currentent = getent( level.entmap[ currentlobby ], #targetname );
        
        if ( currentent )
        {
            var_78600f0b771be9ce = currentent.origin;
            delta = ( int( posdelta[ 1 ] ), int( posdelta[ 2 ] ), int( posdelta[ 3 ] ) );
            currentent.origin = var_78600f0b771be9ce + delta;
        }
    }

    // Namespace frontendutils
    // Params 2, eflags: 0x4
    // Checksum 0xbca217fc, Offset: 0x3cc6
    // Size: 0xf2, Type: dev
    function private function_110dbb4c40608a41( arg, msg )
    {
        angledelta = strtok( arg, "<dev string:x110>" );
        
        if ( !angledelta )
        {
            return;
        }
        
        if ( !level.entmap )
        {
            level.entmap = [ "<dev string:x112>", "<dev string:x11b>", "<dev string:x123>", "<dev string:x12c>" ];
        }
        
        currentlobby = int( angledelta[ 0 ] );
        currentent = getent( level.entmap[ currentlobby ], #targetname );
        
        if ( currentent )
        {
            var_78600f0b771be9ce = currentent.angles;
            delta = ( int( angledelta[ 1 ] ), int( angledelta[ 2 ] ), int( angledelta[ 3 ] ) );
            currentent.angles = var_78600f0b771be9ce + delta;
        }
    }

#/

// Namespace frontendutils
// Params 2
// Checksum 0xf0ee3566, Offset: 0x3dc0
// Size: 0x7d
function process_gunsmith_firingrange_message( firingrange_message, callbackname )
{
    switch ( firingrange_message )
    {
        case %"enter":
            thread frontendfiringrange::function_62bd406831db8f68();
            break;
        case %"update":
            thread frontendfiringrange::function_bb71c1fb5408ca04();
            break;
        case %"exit":
            thread frontendfiringrange::function_ffb5613c989cd070();
            break;
        default:
            println( "<dev string:x133>" );
            break;
    }
}

// Namespace frontendutils
// Params 2
// Checksum 0x1f1f4a77, Offset: 0x3e45
// Size: 0x4c
function xcam_link( unused, args )
{
    if ( isdefined( level.playerviewowner ) && isdefined( level.camera_anchor ) )
    {
        level.playerviewowner cameralinkto( level.camera_anchor, "tag_origin" );
    }
}

// Namespace frontendutils
// Params 2
// Checksum 0xaf7bded3, Offset: 0x3e99
// Size: 0x3e
function xcam_unlink( unused, args )
{
    if ( isdefined( level.playerviewowner ) && isdefined( level.camera_anchor ) )
    {
        level.playerviewowner cameraunlink();
    }
}

// Namespace frontendutils
// Params 0
// Checksum 0x24a6615c, Offset: 0x3edf
// Size: 0x2c9
function function_206e476c61647ec1()
{
    println( "<dev string:x173>" );
    function_bca7483b25613aa();
    initialize_loadout_data();
    level ui::function_770abf131329ffc7( "client_scene_play", &client_scene_play );
    level ui::function_770abf131329ffc7( "client_scene_stop", &client_scene_stop );
    level ui::lui_registercallback( "client_scene_begin_transition", &client_scene_begin_transition );
    level ui::lui_registercallback( "client_scene_end_transition", &client_scene_end_transition );
    level ui::function_770abf131329ffc7( "operator_scene_play", &operator_scene_play );
    level ui::function_770abf131329ffc7( "operator_scene_stop", &operator_scene_stop );
    level ui::function_770abf131329ffc7( "item_preview_scene_play", &item_preview_scene_play );
    level ui::function_770abf131329ffc7( "item_preview_scene_stop", &item_preview_scene_stop );
    level ui::function_770abf131329ffc7( "set_xcam", &function_e61ab3600302cfb0 );
    level ui::function_770abf131329ffc7( "enable_pbg_bank", &function_49ac8cd8d3cc2474 );
    level ui::function_770abf131329ffc7( "reset_preview_weapon_loc", &reset_preview_weapon_loc );
    level ui::function_770abf131329ffc7( "set_scriptable_part_state", &function_c788a94f8af5678e );
    level ui::function_770abf131329ffc7( "process_gunsmith_firingrange_message", &process_gunsmith_firingrange_message );
    level ui::function_770abf131329ffc7( "xcam_link", &xcam_link );
    level ui::function_770abf131329ffc7( "xcam_unlink", &xcam_unlink );
    level ui::function_770abf131329ffc7( "entered_firing_range", &frontendfiringrange::function_232489312b237c86 );
    level ui::function_770abf131329ffc7( "entered_firing_range_pause_menu", &frontendfiringrange::function_3fb8295621b2f890 );
    level ui::function_770abf131329ffc7( "entered_firing_range_from_social", &frontendfiringrange::function_3fb8295621b2f890 );
    level ui::function_770abf131329ffc7( "exit_firing_range", &frontendfiringrange::function_4dbdb6e6debb40ee );
    level ui::function_770abf131329ffc7( "force_exit_firing_range", &frontendfiringrange::function_7eb21b04340b04d );
    level ui::function_770abf131329ffc7( "start_infil_animation", &frontendwalkablespace::playinfil );
    level ui::function_770abf131329ffc7( "update_backpack_size", &frontendwalkablespace::function_1b6fa013c0c2b251 );
    level ui::function_770abf131329ffc7( "hint_walkable_space_models", &frontendwalkablespace::function_93b1960c20cec5f8 );
    level ui::function_770abf131329ffc7( "set_frontend_scriptable_part_state", &frontendwalkablespace::function_42cec6872280e398 );
    level ui::function_770abf131329ffc7( "unpause_frontend_walkable_space", &frontendwalkablespace::function_4ca96946a95337ad );
    
    /#
        thread debug_frontend();
        thread function_f6794b7a210ff9ff();
        thread function_850dd9a21b448b1();
        thread dev_watch_scene();
        thread function_1c648417bf9191d();
        thread function_4dbf025e46bc2e18();
        thread function_329cf40cb5d3f853();
        level ui::function_770abf131329ffc7( "<dev string:x1a8>", &function_4aff0eb9296c6f1f );
        level ui::function_770abf131329ffc7( "<dev string:x1bd>", &function_110dbb4c40608a41 );
    #/
    
    level thread function_78b5463da8c6f09a();
    scene::function_6c37456303b2e980();
    function_1b330152ff680483();
    function_9af2b71c5be87a60();
    init_toggle_scriptable_bink_callbacks();
    function_ad915db840c90fb3( 1023, 1, 0 );
    thread frontend_camera_watcher( &camera_section_change );
    thread luinotifylistener();
    level thread function_701e6afbffd77a75();
    callback::add( "on_camera_section_change", &on_camera_section_change );
    println( "<dev string:x1d1>" );
    setomnvar( "frontend_player_connected", 1 );
    wait 0.3;
    println( "<dev string:x209>" );
    setomnvar( "frontend_player_connected", 0 );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xf7344f06, Offset: 0x41b0
// Size: 0x126
function private function_1b330152ff680483()
{
    if ( !isdefined( level.gamemodebundle.lobbyscene ) )
    {
        return;
    }
    
    s_temp_scene_root = { #script_scenescriptbundle:level.gamemodebundle.lobbyscene };
    a_str_shot_names = s_temp_scene_root scene::get_shot_names();
    
    foreach ( str_shot_name in a_str_shot_names )
    {
        scene::add_scene_func( level.gamemodebundle.lobbyscene, &function_664032a4fd238731, str_shot_name );
    }
    
    scene::add_scene_func( level.gamemodebundle.lobbyscene, &frontend_lobby_scene_play, "callback_play" );
    scene::add_scene_func( level.gamemodebundle.lobbyscene, &frontend_lobby_scene_stop, "callback_stop" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xb9d5b6be, Offset: 0x42de
// Size: 0xe
function private frontend_lobby_scene_play()
{
    function_2fc5be39a1fe02a1( "off" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x2677b7ba, Offset: 0x42f4
// Size: 0x41
function private frontend_lobby_scene_stop()
{
    function_caec36e072ddb3b3( level.var_558465f7607afc67, "off" );
    function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
    function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xf3bdfd32, Offset: 0x433d
// Size: 0x25
function private function_2fc5be39a1fe02a1( str_state )
{
    function_bb689db6e91e0502();
    function_caec36e072ddb3b3( level.var_70ef0fa6eb5df70c, str_state );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xd8172d9, Offset: 0x436a
// Size: 0x122
function private function_df35313bef805210()
{
    switch ( getprojectname() )
    {
        case #"hash_7e32e86cd2341797":
            if ( !isdefined( level.var_558465f7607afc67 ) )
            {
                level.var_558465f7607afc67 = getscriptablearray( "scriptable_sat_frontend_bink_screen_lobby_a", #classname );
            }
            
            if ( !isdefined( level.var_558466f7607afe9a ) )
            {
                level.var_558466f7607afe9a = getscriptablearray( "scriptable_sat_frontend_bink_screen_lobby_b", #classname );
            }
            
            if ( !isdefined( level.var_558467f7607b00cd ) )
            {
                level.var_558467f7607b00cd = getscriptablearray( "scriptable_sat_frontend_bink_screen_lobby_c", #classname );
            }
            
            break;
        case #"hash_5997716cbf245d52":
        default:
            if ( !isdefined( level.var_558465f7607afc67 ) )
            {
                level.var_558465f7607afc67 = getscriptablearray( "scriptable_t10_frontend_bink_screen_lobby_a", #classname );
            }
            
            if ( !isdefined( level.var_558466f7607afe9a ) )
            {
                level.var_558466f7607afe9a = getscriptablearray( "scriptable_t10_frontend_bink_screen_lobby_b", #classname );
            }
            
            if ( !isdefined( level.var_558467f7607b00cd ) )
            {
                level.var_558467f7607b00cd = getscriptablearray( "scriptable_t10_frontend_bink_screen_lobby_c", #classname );
            }
            
            break;
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x973adb8e, Offset: 0x4494
// Size: 0x86
function private function_bb689db6e91e0502()
{
    switch ( getprojectname() )
    {
        case #"hash_7e32e86cd2341797":
            if ( !isdefined( level.var_70ef0fa6eb5df70c ) )
            {
                level.var_70ef0fa6eb5df70c = getscriptablearray( "scriptable_sat_frontend_playlist_select_bink_player", #classname );
            }
            
            break;
        case #"hash_5997716cbf245d52":
        default:
            if ( !isdefined( level.var_70ef0fa6eb5df70c ) )
            {
                level.var_70ef0fa6eb5df70c = getscriptablearray( "scriptable_t10_frontend_playlist_select_bink_player", #classname );
            }
            
            break;
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xbeef8c0a, Offset: 0x4522
// Size: 0x443
function private function_664032a4fd238731()
{
    foreach ( sceneplay in self.scenedata.sceneplay )
    {
        n_current_shot = sceneplay.currentshot;
        
        if ( isdefined( n_current_shot ) )
        {
            break;
        }
    }
    
    str_shot = self.scenedata.scenescriptbundle.shots[ n_current_shot ].variant_object.name;
    function_df35313bef805210();
    
    switch ( str_shot )
    {
        case #"hash_90dda3800030aa83":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "on" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_90e7358000384c1e":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "on" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_90ea3b80003a9427":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "off" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_90e0a9800032f28c":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "on" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_90e42f8000360415":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "off" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "on" );
            break;
        case #"hash_90c12d80001a2a72":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "on" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_90c4b380001d3bfb":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "off" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "on" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_97e5188003c5c8a5":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "off" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_97e2128003c3809c":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "on" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_97eb248003ca58b7":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "on" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
        case #"hash_97e81e8003c810ae":
            function_caec36e072ddb3b3( level.var_558465f7607afc67, "off" );
            function_caec36e072ddb3b3( level.var_558466f7607afe9a, "off" );
            function_caec36e072ddb3b3( level.var_558467f7607b00cd, "off" );
            break;
    }
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x99ecedc1, Offset: 0x496d
// Size: 0x189
function private function_caec36e072ddb3b3( a_scriptables, str_state )
{
    var_37d54380e839c06b = get_frontend_scriptables_key();
    
    if ( issubstr( str_state, "on" ) )
    {
        if ( getdvar( @"hash_641acaf7833ae51f", "" ) != "" )
        {
            var_f853cfc72c46eea = getdvar( @"hash_641acaf7833ae51f", "" );
        }
        
        if ( isdefined( var_37d54380e839c06b ) )
        {
            if ( isdefined( var_f853cfc72c46eea ) )
            {
                var_2d76d6eb8271950e = var_f853cfc72c46eea + "_" + var_37d54380e839c06b;
            }
            
            var_35cf3de562fb9379 = str_state + "_" + var_37d54380e839c06b;
        }
    }
    
    foreach ( scriptable in a_scriptables )
    {
        b_success = 0;
        
        if ( isdefined( var_2d76d6eb8271950e ) )
        {
            b_success = scriptable utility::function_7c10ea82c1e305b8( "base", var_2d76d6eb8271950e );
        }
        
        if ( !b_success && isdefined( var_35cf3de562fb9379 ) )
        {
            b_success = scriptable utility::function_7c10ea82c1e305b8( "base", var_35cf3de562fb9379 );
        }
        
        if ( !b_success && isdefined( var_f853cfc72c46eea ) )
        {
            b_success = scriptable utility::function_7c10ea82c1e305b8( "base", var_f853cfc72c46eea );
        }
        
        if ( !b_success )
        {
            b_success = scriptable utility::function_7c10ea82c1e305b8( "base", str_state );
        }
    }
    
    /#
        level thread function_79e6fee36800eae0();
    #/
}

/#

    // Namespace frontendutils
    // Params 0, eflags: 0xc
    // Checksum 0x9c605be4, Offset: 0x4afe
    // Size: 0x1eb, Type: dev
    function private function_79e6fee36800eae0()
    {
        self notify( #"hash_a24ae4d985695deb" );
        self endon( #"hash_a24ae4d985695deb" );
        function_df35313bef805210();
        function_bb689db6e91e0502();
        
        if ( !isdefined( level.var_40ff98ff027fd5e3 ) )
        {
            level.var_40ff98ff027fd5e3 = arraycombineunique( level.var_558465f7607afc67, level.var_558466f7607afe9a, level.var_558467f7607b00cd, level.var_70ef0fa6eb5df70c );
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_f5d38e563184f94c", 0 ) )
            {
                n_last_index = undefined;
                
                foreach ( index, scriptable in level.var_40ff98ff027fd5e3 )
                {
                    n_last_index = index;
                    var_d358329fd85f95c = scriptable getscriptablepartstate( "<dev string:x248>", 1 );
                    
                    if ( isdefined( var_d358329fd85f95c ) )
                    {
                        part = "<dev string:x248>";
                        state = var_d358329fd85f95c;
                    }
                    else
                    {
                        var_b3a1c4e95c8e52fb = scriptable getscriptablepartstate( "<dev string:x24d>", 1 );
                        part = "<dev string:x24d>";
                        state = var_b3a1c4e95c8e52fb;
                    }
                    
                    if ( isdefined( state ) )
                    {
                        printtoscreen2d( 750, 600 + 25 * index, function_41bec0232e24ee41( scriptable.classname, "<dev string:x256>" ) + "<dev string:x262>" + part + "<dev string:x26a>" + state, ( 0, 1, 0 ), 1.5 );
                    }
                }
                
                n_last_index++;
                printtoscreen2d( 750, 600 + 25 * n_last_index, "<dev string:x274>" + getdvar( @"hash_641acaf7833ae51f", "<dev string:x24>" ), ( 0, 1, 0 ), 1.5 );
            }
            
            waitframe();
        }
    }

#/

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x7570bd4d, Offset: 0x4cf1
// Size: 0x126
function private function_9af2b71c5be87a60()
{
    if ( !isdefined( level.gamemodebundle.playlistselectscene ) )
    {
        return;
    }
    
    s_temp_scene_root = { #script_scenescriptbundle:level.gamemodebundle.playlistselectscene };
    a_str_shot_names = s_temp_scene_root scene::get_shot_names();
    
    foreach ( str_shot_name in a_str_shot_names )
    {
        scene::add_scene_func( level.gamemodebundle.playlistselectscene, &function_32a49cbd092e6d0c, str_shot_name );
    }
    
    scene::add_scene_func( level.gamemodebundle.playlistselectscene, &frontend_playlist_select_scene_play, "callback_play" );
    scene::add_scene_func( level.gamemodebundle.playlistselectscene, &frontend_playlist_select_scene_stop, "callback_stop" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x846d7aec, Offset: 0x4e1f
// Size: 0xe
function private frontend_playlist_select_scene_play()
{
    function_2fc5be39a1fe02a1( "on" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x41b8c66b, Offset: 0x4e35
// Size: 0xe
function private frontend_playlist_select_scene_stop()
{
    function_2fc5be39a1fe02a1( "off" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x23e86bc3, Offset: 0x4e4b
// Size: 0x139
function private function_32a49cbd092e6d0c()
{
    foreach ( sceneplay in self.scenedata.sceneplay )
    {
        n_current_shot = sceneplay.currentshot;
        
        if ( isdefined( n_current_shot ) )
        {
            break;
        }
    }
    
    str_shot = self.scenedata.scenescriptbundle.shots[ n_current_shot ].variant_object.name;
    
    switch ( str_shot )
    {
        case #"hash_e99c5ce6d74f7088":
            function_2fc5be39a1fe02a1( "on" );
            break;
        case #"hash_39bff9b4728ed016":
            barracks_scriptable_state = getprojectname() == "WZ2" ? "on_barracks_wz" : "on_barracks";
            function_2fc5be39a1fe02a1( barracks_scriptable_state );
            break;
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x252cd155, Offset: 0x4f8c
// Size: 0x136
function private on_camera_section_change( params )
{
    scriptables_key = get_frontend_scriptables_key();
    
    if ( isdefined( scriptables_key ) )
    {
        if ( params.newroom == "character_faction_select_l_detail" || params.newroom == "character_tango" )
        {
            level notify( #"frontendworldevent_singleton" );
            var_4f28aae36427663 = get_frontend_world_events();
            
            if ( isdefined( var_4f28aae36427663 ) )
            {
                foreach ( lobby_world_event in var_4f28aae36427663 )
                {
                    deactivateworldevent( lobby_world_event );
                }
            }
            
            function_63289211f9b2d936( "base" );
            return;
        }
        
        if ( params.previousroom == "character_faction_select_l_detail" || params.previousroom == "character_tango" )
        {
            var_4f28aae36427663 = get_frontend_world_events();
            
            if ( isdefined( var_4f28aae36427663 ) )
            {
                level thread frontend_change_world_event( var_4f28aae36427663 );
            }
            
            function_63289211f9b2d936( scriptables_key );
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xf7e838da, Offset: 0x50ca
// Size: 0x14
function private init_toggle_scriptable_bink_callbacks()
{
    level ui::function_770abf131329ffc7( "toggle_scriptable_bink", &toggle_scriptable_bink );
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x26b66643, Offset: 0x50e6
// Size: 0x86
function private toggle_scriptable_bink( value, args )
{
    channel = args[ 0 ];
    statename = args[ 1 ];
    
    if ( statename == "on" || statename == "off" )
    {
        function_df35313bef805210();
        function_caec36e072ddb3b3( level.var_558465f7607afc67, statename );
        function_caec36e072ddb3b3( level.var_558466f7607afe9a, statename );
        function_caec36e072ddb3b3( level.var_558467f7607b00cd, statename );
    }
}

// Namespace frontendutils
// Params 0
// Checksum 0x39ab9b91, Offset: 0x5174
// Size: 0xdc
function get_frontend_world_events()
{
    var_813779cdf59c896a = [];
    level.gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( level.gamemodebundle.frontendworldeventarray ) )
    {
        foreach ( s_world_event in level.gamemodebundle.frontendworldeventarray )
        {
            if ( isdefined( s_world_event.frontendworldevententry ) )
            {
                var_813779cdf59c896a[ var_813779cdf59c896a.size ] = s_world_event.frontendworldevententry;
            }
        }
    }
    
    var_813779cdf59c896a = function_5713d46873b29625( var_813779cdf59c896a );
    
    if ( var_813779cdf59c896a.size )
    {
        return var_813779cdf59c896a;
    }
}

// Namespace frontendutils
// Params 0
// Checksum 0x88f8ac0f, Offset: 0x5259
// Size: 0x22
function get_frontend_scriptables_key()
{
    level.gamemodebundle = getgamemodescriptbundle();
    return level.gamemodebundle.var_bf2ae5dfc2aa83cd;
}

// Namespace frontendutils
// Params 1
// Checksum 0xf043e519, Offset: 0x5284
// Size: 0x199
function function_63289211f9b2d936( gametype )
{
    scriptables = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "gametype" );
    
    foreach ( thing in scriptables )
    {
        if ( thing getscriptableparthasstate( "gametype", gametype ) )
        {
            thing setscriptablepartstate( "gametype", gametype, 1 );
            continue;
        }
        
        thing setscriptablepartstate( "gametype", "base" );
    }
    
    entity_scriptables = getscriptablearray();
    
    foreach ( entity_scriptable in entity_scriptables )
    {
        if ( !entity_scriptable getscriptablehaspart( "gametype" ) )
        {
            continue;
        }
        
        if ( entity_scriptable getscriptableparthasstate( "gametype", gametype ) )
        {
            entity_scriptable setscriptablepartstate( "gametype", gametype, 1 );
            continue;
        }
        
        if ( entity_scriptable getscriptableparthasstate( "gametype", "base" ) )
        {
            entity_scriptable setscriptablepartstate( "gametype", "base" );
        }
    }
    
    /#
        level thread function_79e6fee36800eae0();
    #/
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x405ea8a3, Offset: 0x5425
// Size: 0xe5
function private frontend_change_world_event( a_world_events )
{
    self notify( #"frontendworldevent_singleton" );
    self endon( #"frontendworldevent_singleton" );
    total_time_sec = getdvarfloat( @"hash_9a16f0a0d73bb50c", 5 );
    step_wait_sec = 0.05;
    total_attempts = total_time_sec / step_wait_sec;
    
    for ( attempt = 0; attempt < total_attempts ; attempt++ )
    {
        foreach ( world_event in a_world_events )
        {
            activateworldevent( world_event );
        }
        
        wait step_wait_sec;
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x82672ca0, Offset: 0x5512
// Size: 0x54
function private function_701e6afbffd77a75()
{
    a_new_world_events = get_frontend_world_events();
    scriptables_key = get_frontend_scriptables_key() ?? "base";
    
    if ( isdefined( a_new_world_events ) )
    {
        level thread frontend_change_world_event( a_new_world_events );
    }
    else
    {
        level notify( #"frontendworldevent_singleton" );
    }
    
    function_63289211f9b2d936( scriptables_key );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x2a2a534e, Offset: 0x556e
// Size: 0x12, Type: bool
function private is_cer_ms()
{
    return getdvarint( @"hash_33590a296e061", 0 ) != 0;
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x3ae0d56e, Offset: 0x5589
// Size: 0x1d, Type: bool
function private function_294daffdcd621d5b()
{
    return level.projectbundle.var_ae604c1391d69161 ?? "";
}

// Namespace frontendutils
// Params 1
// Checksum 0xc59b72e2, Offset: 0x55af
// Size: 0x78
function frontend_camera_get_entity( entname )
{
    projectname = function_294daffdcd621d5b();
    camera_ent = getent( entname + projectname, #targetname );
    
    if ( projectname != "" && !isdefined( camera_ent ) )
    {
        println( "<dev string:x2a7>" + entname + projectname + "<dev string:x2d9>" );
        camera_ent = getent( entname, #targetname );
    }
    
    return camera_ent;
}

// Namespace frontendutils
// Params 1
// Checksum 0x29eb68f1, Offset: 0x5630
// Size: 0x78
function function_55f1609e123f6a51( entname )
{
    projectname = function_294daffdcd621d5b();
    camera_ent_array = getentarray( entname + projectname, #targetname );
    
    if ( projectname != "" && !isdefined( camera_ent_array ) )
    {
        println( "<dev string:x302>" + entname + projectname + "<dev string:x2d9>" );
        camera_ent_array = getentarray( entname, #targetname );
    }
    
    return camera_ent_array;
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0xb80cba8a, Offset: 0x56b1
// Size: 0xfe
function private frontend_camera_setup( origin, angles )
{
    level.camera_anchor = spawn( "script_model", origin );
    level.camera_anchor setmodel( "tag_origin" );
    level.camera_anchor.angles = angles;
    level.xcam_anchor = spawn( "script_model", origin );
    level.xcam_anchor setmodel( "tag_origin" );
    level.xcam_anchor.angles = angles;
    level.xcam_anchor.intransition = 0;
    function_15b08432d581df98();
    utility::flag_init( "started_mm" );
    utility::flag_init( "lobby_member_increase" );
    utility::flag_init( "zoom_triggered" );
    utility::flag_init( "zoom_clear" );
    utility::flag_init( "loadout_data_set" );
    utility::flag_init( "force_weapon_update" );
    
    /#
        level thread debugsetdof();
    #/
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xb3d968a7, Offset: 0x57b7
// Size: 0x98
function private function_15b08432d581df98()
{
    level.gunsmithblendtime = 0.3;
    level.gunsmithtags = [ "tag_silencer", "tag_barrel_attach_small", "tag_barrel_attach_large", "tag_grip_attach", "tag_mag_attach", "j_mag1", "tag_scope", "tag_reflex", "tag_pistolgrip_attach", "tag_stock_attach", "tag_rack_attach", "j_gun", "tag_bipod_attach", "ammo_display_origin" ];
}

// Namespace frontendutils
// Params 0
// Checksum 0x3a8ac71, Offset: 0x5857
// Size: 0x14
function function_43d3e8175a0475e3()
{
    var_f2c04a43f6b0017b = frontendscenegetactivesection();
    return var_f2c04a43f6b0017b;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xc9fbdfe9, Offset: 0x5874
// Size: 0x27c
function private frontend_camera_watcher( var_c445b0d2e33be572 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    assert( isdefined( var_c445b0d2e33be572 ) );
    var_552baa3ae5be9b38 = level.var_3d353e3274a23c81 && !level.var_88cd03d85d960fe0 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( !var_552baa3ae5be9b38 )
    {
        var_ceefa23be7acad18 = getdvarint( @"hash_be485550bea2743", 0 ) == 1 && !level.var_88cd03d85d960fe0;
        
        if ( var_ceefa23be7acad18 )
        {
            frontendscenecamerafade( 0, 0 );
        }
        else if ( isdefined( level.camera_anchor ) )
        {
            self cameralinkto( level.camera_anchor, "tag_origin" );
        }
    }
    
    level.active_section = function_43d3e8175a0475e3();
    [[ var_c445b0d2e33be572 ]]( level.active_section );
    waitframe();
    
    while ( true )
    {
        requested_section = function_43d3e8175a0475e3();
        camera_offsets = function_c0a66894a8558a8e();
        
        if ( !isdefined( level.camera_position_offsets ) )
        {
            function_f459249a04863bba( camera_offsets );
        }
        else if ( !function_d752a8b42b215271( camera_offsets ) )
        {
            function_f459249a04863bba( camera_offsets );
            waitframe();
            [[ var_c445b0d2e33be572 ]]( requested_section );
        }
        
        if ( requested_section.name == level.active_section.name && isdefined( level.var_24341f580e01cc98 ) && !level.var_24341f580e01cc98 )
        {
            if ( level.active_section.name == getdvar( @"lui_fe_transitioning_scene" ) && level.active_section.name.size > 0 )
            {
                completescenetransition();
            }
            
            waitframe();
            continue;
        }
        
        if ( requested_section.name.size > 0 )
        {
            level.active_section = requested_section;
            level.var_24341f580e01cc98 = 0;
            setomnvar( "frontend_weapon_position_updated", 0 );
            setomnvar( "frontend_screen_black", 0 );
            level.active_section = requested_section;
            setomnvar( "frontend_weapon_position_updated", 0 );
            setomnvar( "frontend_screen_black", 0 );
            setomnvar( "frontend_weapon_position_force_update", 0 );
            [[ var_c445b0d2e33be572 ]]( requested_section );
            println( "<dev string:x33a>" + requested_section.name );
            continue;
        }
        
        if ( getdvarint( @"hash_95db3fa9650949a0", 1 ) == 1 )
        {
            level.currentsectionname = "";
            level.active_section = requested_section;
        }
        
        waitframe();
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xaa521208, Offset: 0x5af8
// Size: 0xc0
function private function_c0a66894a8558a8e()
{
    cameraoffsets = spawnstruct();
    cameraoffsets.isenabled = getdvarint( @"hash_7e06254351806a5" );
    cameraoffsets.positionoffsets = ( getdvarfloat( @"hash_c7b84c68b4a18696", 0 ), getdvarfloat( @"hash_e26c4a7c1b9dd59f", 0 ), getdvarfloat( @"hash_b20b2898d43b8a68", 0 ) );
    cameraoffsets.orientationoffsets = ( getdvarfloat( @"hash_ff04a85e5dbe51b2", 0 ), getdvarfloat( @"hash_f443ad27538b3297", 0 ), 0 );
    cameraoffsets.var_386c5534018d8e4 = getdvarfloat( @"hash_53605a953e200942", 0 );
    return cameraoffsets;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x8c0f3fb7, Offset: 0x5bc1
// Size: 0x5c
function private function_f459249a04863bba( cameraoffsets )
{
    level.camera_offsets_enabled = cameraoffsets.isenabled;
    level.camera_position_offsets = cameraoffsets.positionoffsets;
    level.var_4d0a590761cc5e5b = cameraoffsets.orientationoffsets;
    level.var_83561b9108e1b9ac = cameraoffsets.var_386c5534018d8e4;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xd7fcd615, Offset: 0x5c25
// Size: 0x77
function private function_d752a8b42b215271( cameraoffsets )
{
    if ( level.camera_offsets_enabled == cameraoffsets.isenabled && level.camera_position_offsets == cameraoffsets.positionoffsets && level.var_4d0a590761cc5e5b == cameraoffsets.orientationoffsets && level.var_83561b9108e1b9ac == cameraoffsets.var_386c5534018d8e4 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x7764109b, Offset: 0x5ca4
// Size: 0x24f
function private camera_section_change( requestedsection )
{
    level notify( #"started_scene_change" );
    
    if ( requestedsection.name == "" )
    {
        return;
    }
    
    sectionstate = get_section_state( requestedsection );
    
    if ( !( isdefined( sectionstate[ "scene" ] ) && isdefined( sectionstate[ "camera" ] ) ) )
    {
        level.currentsectionname = requestedsection.name;
        return;
    }
    
    if ( level.transitionarray[ requestedsection.name ][ level.currentsectionname ][ "ignore" ] )
    {
        /#
            setdevdvar( @"hash_728c3d23b689f98b", requestedsection.name );
            setdevdvar( @"hash_d88c8215f8299404", level.currentsectionname );
            setdevdvar( @"hash_58304f79a99e8657", "<dev string:x8e>" );
            debugentity = "<dev string:x24>";
            
            if ( isdefined( level.var_86e3e1ec32aa44f1 ) && isdefined( level.var_86e3e1ec32aa44f1[ requestedsection.name ] ) )
            {
                debugentity = level.var_86e3e1ec32aa44f1[ requestedsection.name ];
            }
            
            setdevdvar( @"hash_89f5fb632c7ab167", debugentity );
        #/
        
        level.currentsectionname = requestedsection.name;
        return;
    }
    
    set_active_camera( sectionstate[ "scene" ], sectionstate[ "camera" ] );
    execute_transition( requestedsection, level.currentsectionname );
    callback::callback( "on_camera_section_change", { #previousroom:level.currentsectionname, #newroom:requestedsection.name } );
    
    /#
        setdevdvar( @"hash_728c3d23b689f98b", requestedsection.name );
        setdevdvar( @"hash_d88c8215f8299404", level.currentsectionname );
        debugentity = "<dev string:x24>";
        
        if ( isdefined( level.var_86e3e1ec32aa44f1 ) && isdefined( level.var_86e3e1ec32aa44f1[ requestedsection.name ] ) )
        {
            debugentity = level.var_86e3e1ec32aa44f1[ requestedsection.name ];
        }
        
        setdevdvar( @"hash_89f5fb632c7ab167", debugentity );
    #/
    
    level.currentsectionname = requestedsection.name;
    level notify( #"finished_scene_change" );
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x99d4196f, Offset: 0x5efb
// Size: 0x2b
function private set_active_camera( scene, camera )
{
    level.active_scene_data = scene;
    level.active_camera = camera;
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x2d1cc591, Offset: 0x5f2e
// Size: 0x557
function private execute_transition( requestedsection, sectionfrom )
{
    var_8bf60784d6fd5e81 = !isdefined( level.active_scene_data ) || level.transition_interrupted;
    
    while ( level.var_9a9e574f38255764 )
    {
        waitframe();
    }
    
    if ( var_8bf60784d6fd5e81 )
    {
        thread frontend_camera_teleport( level.active_camera, level.active_scene_data.myfov, level.active_scene_data.cinematic, 0, 0.2, &update_entities_and_camera );
    }
    
    assert( isdefined( level.transitionarray ), "<dev string:x358>" );
    transitionarray = level.transitionarray;
    speed = undefined;
    fov = undefined;
    callback = undefined;
    transition = undefined;
    fadeouttime = undefined;
    fadeintime = undefined;
    cinematicname = undefined;
    accelScalar = undefined;
    decelScalar = undefined;
    movetime = undefined;
    use_bounce = undefined;
    keepXCam = undefined;
    
    if ( isdefined( transitionarray[ requestedsection.name ] ) && transitionarray[ requestedsection.name ].size > 0 )
    {
        sectiontransition = transitionarray[ requestedsection.name ];
        defaulttransition = sectiontransition[ "default" ];
        
        if ( isdefined( sectionfrom ) && isdefined( sectiontransition[ sectionfrom ] ) )
        {
            callback = sectiontransition[ sectionfrom ][ "callback" ];
            fov = sectiontransition[ sectionfrom ][ "fov" ];
            speed = sectiontransition[ sectionfrom ][ "speed" ];
            fadeouttime = sectiontransition[ sectionfrom ][ "fadeOutTime" ];
            fadeintime = sectiontransition[ sectionfrom ][ "fadeInTime" ];
            cinematicname = sectiontransition[ sectionfrom ][ "cinematicName" ];
            accelScalar = sectiontransition[ sectionfrom ][ "accelScalar" ];
            decelScalar = sectiontransition[ sectionfrom ][ "decelScalar" ];
            movetime = sectiontransition[ sectionfrom ][ "moveTime" ];
            use_bounce = sectiontransition[ sectionfrom ][ "use_bounce" ];
            keepXCam = sectiontransition[ sectionfrom ][ "keepXCam" ];
            firstxcamindex = sectiontransition[ sectionfrom ][ "firstXCamIndex" ];
            
            if ( isdefined( sectiontransition[ sectionfrom ][ "transition" ] ) )
            {
                transition = sectiontransition[ sectionfrom ][ "transition" ];
            }
        }
        
        if ( !isdefined( callback ) )
        {
            callback = defaulttransition[ "callback" ];
        }
        
        if ( !isdefined( transition ) )
        {
            transition = defaulttransition[ "transition" ];
            
            if ( !isdefined( fov ) )
            {
                fov = defaulttransition[ "fov" ];
            }
            
            if ( !isdefined( speed ) )
            {
                speed = defaulttransition[ "speed" ];
            }
            
            if ( !isdefined( fadeouttime ) )
            {
                fadeouttime = defaulttransition[ "fadeOutTime" ];
            }
            
            if ( !isdefined( fadeintime ) )
            {
                fadeintime = defaulttransition[ "fadeInTime" ];
            }
            
            if ( !isdefined( cinematicname ) )
            {
                cinematicname = defaulttransition[ "cinematicName" ];
            }
            
            if ( !isdefined( accelScalar ) )
            {
                accelScalar = defaulttransition[ "accelScalar" ];
            }
            
            if ( !isdefined( decelScalar ) )
            {
                decelScalar = defaulttransition[ "decelScalar" ];
            }
            
            if ( !isdefined( movetime ) )
            {
                movetime = defaulttransition[ "moveTime" ];
            }
            
            if ( !isdefined( use_bounce ) )
            {
                use_bounce = defaulttransition[ "use_bounce" ];
            }
            
            if ( !isdefined( keepXCam ) )
            {
                keepXCam = defaulttransition[ "keepXCam" ];
            }
            
            if ( !isdefined( firstxcamindex ) )
            {
                firstxcamindex = defaulttransition[ "firstXCamIndex" ];
            }
        }
    }
    else
    {
        transition = &frontend_camera_teleport;
        callback = &update_camera_depth_of_field;
        tagname = function_8e87b77f70835fd4( requestedsection.name );
        
        if ( isdefined( tagname ) && isdefined( level.xcam_anchors[ tagname ] ) )
        {
            callback = &set_xcam;
        }
    }
    
    if ( !isdefined( transition ) )
    {
        return;
    }
    
    /#
        if ( transition == &frontend_camera_teleport )
        {
            setdevdvar( @"hash_58304f79a99e8657", "<dev string:x3a4>" );
        }
        else if ( transition == &frontend_camera_move )
        {
            setdevdvar( @"hash_58304f79a99e8657", "<dev string:x3ad>" );
        }
        else
        {
            setdevdvar( @"hash_58304f79a99e8657", "<dev string:x3b2>" );
        }
        
        setdevdvar( @"hash_548521177d62e3db", fov ?? 0 );
        setdevdvar( @"hash_68e2d2fceab22753", speed ?? 0 );
    #/
    
    if ( transition == &frontend_camera_teleport )
    {
        if ( !isdefined( fov ) )
        {
            fov = level.active_scene_data.myfov;
        }
        
        if ( !isdefined( fadeouttime ) )
        {
            fadeouttime = 0.2;
        }
        
        if ( !isdefined( fadeintime ) )
        {
            fadeintime = 0.2;
        }
        
        if ( !isdefined( cinematicname ) )
        {
            cinematicname = level.active_scene_data.cinematic;
        }
        
        if ( !isdefined( keepXCam ) )
        {
            keepXCam = 0;
        }
        
        [[ transition ]]( level.active_camera, fov, cinematicname, fadeouttime, fadeintime, callback, keepXCam );
    }
    else if ( transition == &frontend_camera_move )
    {
        if ( !isdefined( fov ) )
        {
            fov = level.active_scene_data.myfov;
        }
        
        if ( !isdefined( accelScalar ) )
        {
            accelScalar = 0.1;
        }
        
        if ( !isdefined( decelScalar ) )
        {
            decelScalar = 0.1;
        }
        
        if ( !isdefined( speed ) )
        {
            speed = 5000;
        }
        
        if ( !isdefined( use_bounce ) )
        {
            use_bounce = 0;
        }
        
        if ( !isdefined( movetime ) )
        {
            movetime = 0;
        }
        
        update_camera_depth_of_field();
        frontendscenecamerafov( fov, movetime );
        
        if ( callback == &update_camera_depth_of_field )
        {
            callback = &update_camera_depth_of_field_slowly;
        }
        
        [[ transition ]]( level.active_camera, speed, 0, 1, callback, accelScalar, decelScalar, use_bounce, movetime, fadeintime );
    }
    else
    {
        assert( 0, "<dev string:x3b9>" );
    }
    
    if ( isdefined( requestedsection.name ) && isdefined( level.var_5da65e2e8ad689d0[ requestedsection.name ] ) )
    {
        [[ level.var_5da65e2e8ad689d0[ requestedsection.name ] ]]( sectionfrom );
    }
    
    if ( isdefined( sectionfrom ) && isdefined( level.var_d66b59842079fb8e[ sectionfrom ] ) )
    {
        [[ level.var_d66b59842079fb8e[ sectionfrom ] ]]( sectionfrom );
    }
}

// Namespace frontendutils
// Params 6, eflags: 0x4
// Checksum 0x502ad938, Offset: 0x648d
// Size: 0x1ff
function private camera_move_helper( moveto, movetime, var_1adb39a59259db47, accelScalar, decelScalar, use_bounce )
{
    level.playerviewowner predictstreamposuntilcleared( moveto.origin );
    
    if ( movetime < 0.05 )
    {
        movetime = 0.05;
    }
    
    var_eb0caeeb90286a8d = 0;
    var_f7271cfc31d01b2c = 0;
    
    if ( var_1adb39a59259db47 )
    {
        var_eb0caeeb90286a8d = movetime * accelScalar;
        var_f7271cfc31d01b2c = movetime * decelScalar;
    }
    
    if ( use_bounce )
    {
        var_6ca00cff9ec79492 = 1.3;
        dir = vectornormalize( moveto.origin - level.camera_anchor.origin );
        var_b2f8071d8913b538 = moveto.origin + dir * var_6ca00cff9ec79492;
        bouncetime = movetime / 2;
        var_8dbc26a997bde5e4 = bouncetime * 0;
        var_db5b07305d884c0d = bouncetime * 0.5;
        var_7b8eef1937b0111 = bouncetime * 0.5;
        var_f53f29d2d9ed963c = bouncetime * 0;
        level.camera_anchor moveto( var_b2f8071d8913b538, bouncetime, var_8dbc26a997bde5e4, var_db5b07305d884c0d );
        level.camera_anchor rotateto( moveto.angles, bouncetime, var_8dbc26a997bde5e4, var_db5b07305d884c0d );
        wait bouncetime;
        level.camera_anchor moveto( moveto.origin, bouncetime, var_7b8eef1937b0111, var_f53f29d2d9ed963c );
        wait bouncetime;
    }
    else
    {
        level.camera_anchor.move_target = moveto;
        level.camera_anchor moveto( moveto.origin, movetime, var_eb0caeeb90286a8d, var_f7271cfc31d01b2c );
        level.camera_anchor rotateto( moveto.angles, movetime, var_eb0caeeb90286a8d, var_f7271cfc31d01b2c );
    }
    
    level.playerviewowner clearpredictedstreampos();
}

// Namespace frontendutils
// Params 10, eflags: 0x4
// Checksum 0x8ce904c3, Offset: 0x6694
// Size: 0x4a7
function private frontend_camera_move( movetoorigin, speed, var_739d2e550cb0522d, var_1adb39a59259db47, followup_func, accelScalar, decelScalar, use_bounce, movetime, fadeintime )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !( isdefined( movetoorigin.origin ) && isdefined( movetoorigin.angles ) ) )
    {
        return;
    }
    
    if ( !isdefined( level.camera_anchor_positions ) )
    {
        level.camera_anchor_positions = [];
    }
    
    if ( !isdefined( level.camera_anchor_positions[ movetoorigin.targetname ] ) )
    {
        cameraposition = spawnstruct();
        cameraposition.origin = movetoorigin.origin;
        cameraposition.angles = movetoorigin.angles;
        level.camera_anchor_positions[ movetoorigin.targetname ] = cameraposition;
    }
    
    var_e54248c1e29da7df = ( 0, 0, 0 );
    var_dbc4fbf1ce860064 = ( 0, 0, 0 );
    
    if ( getdvarint( @"hash_7e06254351806a5" ) == 1 )
    {
        var_e54248c1e29da7df = ( getdvarfloat( @"hash_c7b84c68b4a18696", 0 ), getdvarfloat( @"hash_e26c4a7c1b9dd59f", 0 ), getdvarfloat( @"hash_b20b2898d43b8a68", 0 ) );
        var_dbc4fbf1ce860064 = ( getdvarfloat( @"hash_ff04a85e5dbe51b2", 0 ), getdvarfloat( @"hash_f443ad27538b3297", 0 ), 0 );
    }
    
    if ( isdefined( level.camera_anchor.move_target ) )
    {
        level.camera_anchor.origin = level.camera_anchor.move_target.origin;
        level.camera_anchor.angles = level.camera_anchor.move_target.angles;
    }
    
    movetoorigin.origin = level.camera_anchor_positions[ movetoorigin.targetname ].origin + var_e54248c1e29da7df;
    movetoorigin.angles = level.camera_anchor_positions[ movetoorigin.targetname ].angles + var_dbc4fbf1ce860064;
    level notify( #"camera_move" );
    level endon( #"camera_move" );
    
    if ( !isdefined( speed ) )
    {
        speed = 900;
    }
    
    moveto_origin = movetoorigin;
    
    if ( movetime == 0 )
    {
        dist = distance( level.camera_anchor.origin, moveto_origin.origin );
        movetime = dist / speed;
    }
    
    xcamscene = undefined;
    
    if ( isdefined( level.active_section.name ) )
    {
        xcamscene = level.active_section.name;
        
        if ( !isdefined( level.xcam_anchors[ xcamscene ] ) )
        {
            xcamscene = function_8e87b77f70835fd4( xcamscene );
        }
    }
    
    var_ea049a95e9728e95 = isdefined( xcamscene ) && isdefined( level.xcam_anchors[ xcamscene ] );
    var_21133fa861eb1001 = followup_func == &set_xcam || followup_func == &set_loadout_xcam;
    var_4ec6cb721a39a68d = var_739d2e550cb0522d || var_ea049a95e9728e95 && var_21133fa861eb1001;
    
    if ( var_4ec6cb721a39a68d )
    {
        level.camera_anchor.origin = moveto_origin.origin;
        level.camera_anchor.angles = moveto_origin.angles;
    }
    else
    {
        camera_move_helper( moveto_origin, movetime, var_1adb39a59259db47, accelScalar, decelScalar, use_bounce );
    }
    
    var_4f75ec1e76510365 = accelScalar + decelScalar;
    
    if ( var_4f75ec1e76510365 > 1 )
    {
        accelScalar /= var_4f75ec1e76510365;
        decelScalar /= var_4f75ec1e76510365;
    }
    
    while ( isdefined( moveto_origin.target ) && !var_ea049a95e9728e95 )
    {
        if ( !isdefined( moveto_origin.target ) )
        {
            return;
        }
        
        moveto_origin = getent( moveto_origin.target, #targetname );
        camera_move_helper( moveto_origin, movetime, var_1adb39a59259db47, accelScalar, decelScalar, use_bounce );
    }
    
    level.camera_anchor.move_target = undefined;
    
    if ( isdefined( followup_func ) )
    {
        self thread [[ followup_func ]]();
    }
    
    if ( !isdefined( fadeintime ) )
    {
        fadeintime = 0;
    }
    
    if ( fadeintime > 0 )
    {
        frontendscenecamerafade( 1, fadeintime );
    }
    
    completescenetransition();
}

// Namespace frontendutils
// Params 7, eflags: 0x4
// Checksum 0x617c9fd5, Offset: 0x6b43
// Size: 0x3f5
function private frontend_camera_teleport( camera, fov, cinematicname, fadeouttime, fadeintime, var_d1ecabb6e179bdcf, keepXCam )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"camera_teleport" );
    level endon( #"camera_teleport" );
    
    if ( !( isdefined( camera.origin ) && isdefined( camera.angles ) ) )
    {
        return;
    }
    
    level.playerviewowner predictstreamposuntilcleared( camera.origin );
    level.transition_interrupted = 1;
    frontendscenecamerafade( 0, fadeouttime );
    println( "<dev string:x3e3>" );
    wait fadeouttime + 0.05;
    println( "<dev string:x3f6>" );
    setomnvar( "frontend_screen_black", 1 );
    xcam = function_fcd62fd219292ac7();
    
    if ( isdefined( xcam ) && !keepXCam )
    {
        println( "<dev string:x414>" + xcam );
        end_current_xcam();
        level.playerviewowner cameralinkto( level.camera_anchor, "tag_origin" );
    }
    
    if ( !isdefined( level.camera_anchor_positions ) )
    {
        level.camera_anchor_positions = [];
    }
    
    if ( !isdefined( level.camera_anchor_positions[ camera.targetname ] ) || issubstr( camera.targetname, "cam_bp" ) )
    {
        cameraposition = spawnstruct();
        cameraposition.origin = camera.origin;
        cameraposition.angles = camera.angles;
        level.camera_anchor_positions[ camera.targetname ] = cameraposition;
    }
    
    var_e54248c1e29da7df = ( 0, 0, 0 );
    var_dbc4fbf1ce860064 = ( 0, 0, 0 );
    fov_offset = 0;
    
    if ( getdvarint( @"hash_7e06254351806a5" ) == 1 )
    {
        var_e54248c1e29da7df = ( getdvarfloat( @"hash_c7b84c68b4a18696", 0 ), getdvarfloat( @"hash_e26c4a7c1b9dd59f", 0 ), getdvarfloat( @"hash_b20b2898d43b8a68", 0 ) );
        var_dbc4fbf1ce860064 = ( getdvarfloat( @"hash_ff04a85e5dbe51b2", 0 ), getdvarfloat( @"hash_f443ad27538b3297", 0 ), 0 );
        fov_offset = getdvarint( @"hash_53605a953e200942" );
    }
    
    println( "<dev string:x429>" );
    frontendscenecamerafov( fov + fov_offset, 0 );
    level.camera_anchor dontinterpolate();
    level.camera_anchor.origin = level.camera_anchor_positions[ camera.targetname ].origin + var_e54248c1e29da7df;
    level.camera_anchor.angles = level.camera_anchor_positions[ camera.targetname ].angles + var_dbc4fbf1ce860064;
    level.camera_anchor.move_target = undefined;
    
    if ( isdefined( cinematicname ) )
    {
        frontendscenecameracinematic( cinematicname );
    }
    
    println( "<dev string:x452>" );
    wait 0.1;
    println( "<dev string:x46f>" );
    
    if ( function_dc431df3348b6bf2( level.currentsectionname ) )
    {
        update_weapon_loc();
    }
    
    if ( isdefined( var_d1ecabb6e179bdcf ) )
    {
        waitforxcam = undefined;
        
        if ( var_d1ecabb6e179bdcf == &set_xcam )
        {
            waitforxcam = 1;
        }
        
        if ( waitforxcam )
        {
            waitforxcam = [[ var_d1ecabb6e179bdcf ]]();
        }
        else
        {
            [[ var_d1ecabb6e179bdcf ]]();
        }
        
        if ( waitforxcam )
        {
            while ( !isdefined( function_fcd62fd219292ac7() ) )
            {
                waitframe();
            }
        }
    }
    
    frontendscenecamerafade( 1, fadeintime );
    level.transition_interrupted = 0;
    completescenetransition();
    setomnvar( "frontend_screen_black", 0 );
    level.playerviewowner clearpredictedstreampos();
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xad349c02, Offset: 0x6f40
// Size: 0x10a
function private update_character_pos()
{
    /#
        level.debug_active_characters = [];
    #/
    
    if ( isdefined( level.active_scene_data.update_char_loc ) )
    {
        [[ level.active_scene_data.update_char_loc ]]();
        return;
    }
    
    if ( isdefined( level.active_scene_data.char_loc ) )
    {
        charindex = 0;
        
        if ( isdefined( level.active_scene_data.char_index ) )
        {
            charindex = level.active_scene_data.char_index;
        }
        
        if ( isdefined( level.client_characters[ charindex ] ) )
        {
            function_e2652b74f40fe569( charindex, level.active_scene_data.char_loc.origin, level.active_scene_data.char_loc.angles );
        }
        
        /#
            level debug_active_character( charindex, level.active_scene_data.char_loc, "<dev string:x491>" + charindex );
        #/
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x9154697, Offset: 0x7052
// Size: 0x17
function private update_player_character_showcase()
{
    update_character_pos();
    update_weapon_loc();
    update_camera_depth_of_field();
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xb1aa3eea, Offset: 0x7071
// Size: 0x91
function private update_camera_depth_of_field()
{
    values = level.active_camera.depthoffieldvalues;
    var_9a0cbb5acae177b2 = 0;
    
    if ( getdvarint( @"hash_7e06254351806a5" ) == 1 )
    {
        var_9a0cbb5acae177b2 = getdvarint( @"hash_53605a953e200942" );
    }
    
    fstop = values[ 0 ] ?? 0;
    focusdistance = values[ 1 ] ?? 0;
    
    if ( fstop <= 0 || focusdistance <= 0 )
    {
        return;
    }
    
    self setphysicaldepthoffield( fstop, focusdistance + var_9a0cbb5acae177b2, 20, 20 );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xbcfcc3bd, Offset: 0x710a
// Size: 0x91
function private update_camera_depth_of_field_slowly()
{
    values = level.active_camera.depthoffieldvalues;
    var_9a0cbb5acae177b2 = 0;
    
    if ( getdvarint( @"hash_7e06254351806a5" ) == 1 )
    {
        var_9a0cbb5acae177b2 = getdvarint( @"hash_53605a953e200942" );
    }
    
    fstop = values[ 0 ] ?? 0;
    focusdistance = values[ 1 ] ?? 0;
    
    if ( fstop <= 0 || focusdistance <= 0 )
    {
        return;
    }
    
    self setphysicaldepthoffield( fstop, focusdistance + var_9a0cbb5acae177b2, 3, 3 );
}

/#

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0x1d0d6799, Offset: 0x71a3
    // Size: 0xe1, Type: dev
    function private debugsetdof()
    {
        pval1 = getdvarint( @"hash_e1e483a72c23e49c", 10 );
        pval2 = getdvarint( @"hash_e1e483a72c23e49c", 10 );
        
        while ( true )
        {
            val1 = getdvarint( @"hash_e1e483a72c23e49c", 10 );
            val2 = getdvarint( @"hash_e1e486a72c23eb35", 10 );
            
            if ( isdefined( level.active_camera ) && isdefined( level.active_camera.depthoffieldvalues ) )
            {
                values = level.active_camera.depthoffieldvalues;
            }
            
            if ( pval1 != val1 || pval2 != val2 )
            {
                level.playerviewowner setphysicaldepthoffield( val1, val2, 20, 20 );
                pval1 = val1;
                pval2 = val2;
            }
            
            waitframe();
        }
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0xfd56777, Offset: 0x728c
    // Size: 0x48, Type: dev
    function private debug_frontend()
    {
        level.debug_active_characters = [];
        level thread function_9fdd941c429a2a00();
        
        while ( true )
        {
            self waittill( #"luinotifyserver", msg );
            
            if ( msg == "<dev string:x4a1>" )
            {
                dumpfrontenddata();
            }
        }
    }

    // Namespace frontendutils
    // Params 3, eflags: 0x4
    // Checksum 0x97fc105e, Offset: 0x72dc
    // Size: 0x72, Type: dev
    function private debug_active_character( charindex, charloc, name )
    {
        new_active_character = spawnstruct();
        new_active_character.charindex = charindex;
        new_active_character.charloc = charloc;
        new_active_character.name = name;
        level.debug_active_characters[ level.debug_active_characters.size ] = new_active_character;
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0x841b225d, Offset: 0x7356
    // Size: 0x5, Type: dev
    function private function_c3d15450ad4a6762()
    {
        
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0x1f98be96, Offset: 0x7363
    // Size: 0xc6, Type: dev
    function private function_93105caf41f86382()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            var_65058f47e7e11621 = getdvarint( @"hash_54d877684382d6b6" );
            
            if ( var_65058f47e7e11621 != -1 )
            {
                foreach ( active_character in level.debug_active_characters )
                {
                    if ( active_character.charindex == var_65058f47e7e11621 )
                    {
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0xb37c0ce0, Offset: 0x7431
    // Size: 0xf5, Type: dev
    function private function_9fdd941c429a2a00()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_fcf3e4b333ad71c4" ) )
            {
                foreach ( active_character in level.debug_active_characters )
                {
                    cylinder( active_character.charloc.origin, active_character.charloc.origin + ( 0, 0, 72 ), 12, ( 0, 0.9, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x194e038, Offset: 0x752e
// Size: 0x77
function private update_entities()
{
    update_character_pos();
    
    if ( isdefined( level.active_section ) )
    {
        if ( level.active_section.name == "loadout_showcase_p" || level.active_section.name == "loadout_showcase_s" )
        {
            reset_preview_weapon_loc( undefined, undefined );
        }
    }
    
    update_weapon_loc();
    update_camera_depth_of_field();
    callback::callback( #"frontend_update_entities", {} );
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x93728aed, Offset: 0x75ad
// Size: 0x36
function private update_entities_and_camera( previousscene )
{
    if ( !isdefined( previousscene ) )
    {
        end_current_xcam();
    }
    else if ( function_8e2c1dc1a32a131f( previousscene ) )
    {
        end_current_xcam();
    }
    
    update_entities();
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x6760c9df, Offset: 0x75eb
// Size: 0x7a
function private move_weapon_to_loc( index )
{
    level.weapons[ index ].origin = level.active_scene_data.weapon_locs[ index ].origin;
    level.weapons[ index ].angles = level.active_scene_data.weapon_locs[ index ].angles;
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xc38fef49, Offset: 0x766d
// Size: 0xb1
function private update_weapon_loc()
{
    if ( isdefined( level.active_scene_data.weapon_locs ) )
    {
        if ( isarray( level.active_scene_data.weapon_locs ) )
        {
            for ( locindex = 0; locindex <= 3 ; locindex++ )
            {
                assert( isdefined( level.weapons[ locindex ] ) );
                
                if ( isdefined( level.active_scene_data.weapon_locs[ locindex ] ) )
                {
                    move_weapon_to_loc( locindex );
                }
            }
        }
    }
    
    if ( issubstr( level.active_section.name, "loadout_showcase_preview" ) )
    {
        setomnvar( "frontend_weapon_position_updated", 1 );
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xb7983e2e, Offset: 0x7726
// Size: 0x154
function private function_24387b6af8430fc4()
{
    level.dmz_weapons = [];
    
    for ( wallweaponindex = 0; wallweaponindex < 12 ; wallweaponindex++ )
    {
        weapon_loc = getent( "dmz_wpn_" + wallweaponindex + 1, #targetname );
        
        if ( isdefined( weapon_loc ) )
        {
            weapon_loc hide();
            level.dmz_weapons[ wallweaponindex ] = spawn( "script_weapon", weapon_loc.origin, 0, 0, wallweaponindex );
            level.dmz_weapons[ wallweaponindex ].angles = weapon_loc.angles;
        }
    }
    
    wpnindex = 38;
    
    for ( loadoutweaponindex = 1; loadoutweaponindex <= 3 ; loadoutweaponindex++ )
    {
        for ( var_c9621a4e5e9363aa = 1; var_c9621a4e5e9363aa <= 4 ; var_c9621a4e5e9363aa++ )
        {
            weapon_loc = getent( "dmz_locker_" + loadoutweaponindex + "_wpn_" + var_c9621a4e5e9363aa, #targetname );
            
            if ( isdefined( weapon_loc ) )
            {
                weapon_loc hide();
                level.dmz_weapons[ wpnindex ] = spawn( "script_weapon", weapon_loc.origin, 0, 0, wpnindex );
                level.dmz_weapons[ wpnindex ].angles = weapon_loc.angles;
                wpnindex++;
            }
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xeda1da4c, Offset: 0x7882
// Size: 0x1a4
function private update_arena_char_loc()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    for ( charindex = 0; charindex < 8 ; charindex++ )
    {
        if ( charindex < 4 )
        {
            charloc = frontend_camera_get_entity( "tourroom_charslot_left_0" + charindex + 1 );
        }
        else
        {
            adjustedcharindex = charindex - 4;
            charloc = frontend_camera_get_entity( "tourroom_charslot_right_0" + adjustedcharindex + 1 );
        }
        
        function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
        
        /#
            if ( charindex < 4 )
            {
                level debug_active_character( charindex, charloc, "<dev string:x4b5>" + charindex + 1 );
                continue;
            }
            
            level debug_active_character( charindex, charloc, "<dev string:x4bf>" + charindex / 2 + 1 );
        #/
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        
        if ( index <= 3 )
        {
            charloc = frontend_camera_get_entity( "tourroom_charslot_left_0" + index + "_dog" );
        }
        else
        {
            adjustedindex = index - 3;
            charloc = frontend_camera_get_entity( "tourroom_charslot_right_0" + adjustedindex + "_dog" );
        }
        
        function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
        
        /#
            level debug_active_character( charindex, charloc, "<dev string:x4ca>" + index );
        #/
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x8b513d50, Offset: 0x7a2e
// Size: 0x136
function private function_56ec697557e5bcb9()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "social_charslot_01" );
    function_e2652b74f40fe569( 0, charloc.origin, charloc.angles );
    
    for ( charindex = 1; charindex < 8 ; charindex++ )
    {
        index = charindex + 1;
        
        if ( index < 10 )
        {
            charloc = frontend_camera_get_entity( "social_charslot_0" + index );
        }
        else
        {
            charloc = frontend_camera_get_entity( "social_charslot_" + index );
        }
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
        }
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        charloc = frontend_camera_get_entity( "social_charslot_0" + index + "_dog" );
        function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x140f14d9, Offset: 0x7b6c
// Size: 0x20a
function private update_lobby_char_loc()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "lobby_charslot_01" );
    function_e2652b74f40fe569( 0, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 0, charloc, "<dev string:x4d3>" );
    #/
    
    if ( isdefined( level.var_bb92290a220ddeaa ) )
    {
        level.var_bb92290a220ddeaa.origin = level.var_bb92290a220ddeaa.originallocation;
        level.var_bb92290a220ddeaa.angles = level.var_bb92290a220ddeaa.originalangles;
        
        if ( isdefined( level.var_901d015765c1117e ) )
        {
            level.var_901d015765c1117e.origin = level.var_901d015765c1117e.originallocation;
        }
    }
    
    for ( charindex = 1; charindex < 8 ; charindex++ )
    {
        index = charindex + 1;
        
        if ( index < 10 )
        {
            charloc = frontend_camera_get_entity( "lobby_charslot_0" + index );
        }
        else
        {
            charloc = frontend_camera_get_entity( "lobby_charslot_" + index );
        }
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x4e4>" + charindex );
            #/
        }
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        charloc = frontend_camera_get_entity( "lobby_charslot_0" + index + "_dog" );
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x4ca>" + index );
            #/
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x6900e783, Offset: 0x7d7e
// Size: 0x1f8
function private function_44dd9635c9699967()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "lobby_br_charslot_01" );
    function_e2652b74f40fe569( 0, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 0, charloc, "<dev string:x4ea>" );
    #/
    
    if ( isdefined( level.var_bb92290a220ddeaa ) )
    {
        level.var_bb92290a220ddeaa.origin = ( -7035, 2380, 0 );
        level.var_bb92290a220ddeaa.angles = ( 0, 90, 0 );
        
        if ( isdefined( level.var_901d015765c1117e ) )
        {
            level.var_901d015765c1117e.origin = ( 0, 0, 10000 );
        }
    }
    
    for ( charindex = 1; charindex < 8 ; charindex++ )
    {
        index = charindex + 1;
        
        if ( index < 10 )
        {
            charloc = frontend_camera_get_entity( "lobby_br_charslot_0" + index );
        }
        else
        {
            charloc = frontend_camera_get_entity( "lobby_br_charslot_" + index );
        }
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x4fd>" + charindex );
            #/
        }
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        charloc = frontend_camera_get_entity( "lobby_br_charslot_0" + index + "_dog" );
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x505>" + index );
            #/
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xf23b5f92, Offset: 0x7f7e
// Size: 0x197
function private function_150f0637729246ac()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = getent( "lobby_dmz_charslot_01", #targetname );
    function_e2652b74f40fe569( 0, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 0, charloc, "<dev string:x510>" );
    #/
    
    for ( charindex = 1; charindex < 8 ; charindex++ )
    {
        index = charindex + 1;
        
        if ( index < 10 )
        {
            charloc = getent( "lobby_dmz_charslot_0" + index, #targetname );
        }
        else
        {
            charloc = getent( "lobby_dmz_charslot_" + index, #targetname );
        }
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x524>" + charindex );
            #/
        }
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        charloc = getent( "lobby_dmz_charslot_0" + index + "_dog", #targetname );
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x52c>" + index );
            #/
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x793cb8d6, Offset: 0x811d
// Size: 0x17b
function private function_74a35d05491a35e()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "crib_dmz_charslot_01" );
    function_e2652b74f40fe569( 0, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 0, charloc, "<dev string:x510>" );
    #/
    
    for ( charindex = 1; charindex < 8 ; charindex++ )
    {
        index = charindex + 1;
        
        if ( index < 10 )
        {
            charloc = frontend_camera_get_entity( "crib_dmz_charslot_0" + index );
        }
        else
        {
            charloc = frontend_camera_get_entity( "crib_dmz_charslot_" + index );
        }
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x538>" + charindex );
            #/
        }
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        charloc = frontend_camera_get_entity( "crib_dmz_charslot_0" + index + "_dog" );
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x540>" + index );
            #/
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xcefb7d03, Offset: 0x82a0
// Size: 0x20a
function private function_31300ad368313ff2()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "lobby_uv_charslot_01" );
    function_e2652b74f40fe569( 0, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 0, charloc, "<dev string:x4d3>" );
    #/
    
    if ( isdefined( level.var_bb92290a220ddeaa ) )
    {
        level.var_bb92290a220ddeaa.origin = level.var_bb92290a220ddeaa.originallocation;
        level.var_bb92290a220ddeaa.angles = level.var_bb92290a220ddeaa.originalangles;
        
        if ( isdefined( level.var_901d015765c1117e ) )
        {
            level.var_901d015765c1117e.origin = level.var_901d015765c1117e.originallocation;
        }
    }
    
    for ( charindex = 1; charindex < 8 ; charindex++ )
    {
        index = charindex + 1;
        
        if ( index < 10 )
        {
            charloc = frontend_camera_get_entity( "lobby_uv_charslot_0" + index );
        }
        else
        {
            charloc = frontend_camera_get_entity( "lobby_uv_charslot_" + index );
        }
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x4e4>" + charindex );
            #/
        }
    }
    
    for ( petindex = 0; petindex < 6 ; petindex++ )
    {
        index = petindex + 1;
        charindex = 8 + petindex;
        charloc = frontend_camera_get_entity( "lobby_uv_charslot_" + index + "_dog" );
        
        if ( isdefined( charloc ) )
        {
            function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
            
            /#
                level debug_active_character( charindex, charloc, "<dev string:x4ca>" + index );
            #/
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x21246a79, Offset: 0x84b2
// Size: 0xcd
function private update_main_menu_char_loc()
{
    if ( level.var_3d353e3274a23c81 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "charroom_char_tango_east" );
    function_e2652b74f40fe569( 14, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 14, charloc, "<dev string:x54b>" );
    #/
    
    charloc = frontend_camera_get_entity( "charroom_char_tango_west" );
    function_e2652b74f40fe569( 15, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 15, charloc, "<dev string:x558>" );
    #/
    
    update_operator_west_char_loc();
    update_operator_east_char_loc();
    level.client_characters[ 15 ] function_de4866729f37f5d2( 1 );
    level.client_characters[ 14 ] function_de4866729f37f5d2( 1 );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x3d69235f, Offset: 0x8587
// Size: 0x4c
function private update_operator_west_char_loc()
{
    charloc = frontend_camera_get_entity( "charroom_char_west_b_dog" );
    function_e2652b74f40fe569( 6, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 6, charloc, "<dev string:x565>" );
    #/
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xd32371b8, Offset: 0x85db
// Size: 0x4c
function private update_operator_east_char_loc()
{
    charloc = frontend_camera_get_entity( "charroom_char_east_a_dog" );
    function_e2652b74f40fe569( 7, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 7, charloc, "<dev string:x575>" );
    #/
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x5dfb5cc7, Offset: 0x862f
// Size: 0x10f
function private function_c2e9d8d8407b0064()
{
    var_ec04f2fab5b324f2 = level.var_3d353e3274a23c81 && getdvarint( @"hash_ceeadc2015e19f38" );
    
    if ( var_ec04f2fab5b324f2 )
    {
        return;
    }
    
    charloc = frontend_camera_get_entity( "char_gunbench" );
    charindex = getprojectname() == "ZUL" ? 17 : 0;
    function_e2652b74f40fe569( charindex, charloc.origin, charloc.angles );
    
    if ( level.var_ccc8d1ad327315cd )
    {
        level.client_characters[ charindex ].origin -= 1000;
    }
    
    /#
        level debug_active_character( charindex, charloc, "<dev string:x585>" );
    #/
    
    charloc = frontend_camera_get_entity( "char_gunbench_dog" );
    function_e2652b74f40fe569( 6, charloc.origin, charloc.angles );
    
    /#
        level debug_active_character( 6, charloc, "<dev string:x592>" );
    #/
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x4a651ccd, Offset: 0x8746
// Size: 0xa9
function private function_b8b5fc49caf5f121( scenename, waittime )
{
    level notify( #"new_operator_xcam" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level endon( #"xcam_transition" );
    level endon( #"new_operator_xcam" );
    wait waittime / 1000;
    set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 4 ], 0, 0.05, level.xcam_anchor );
    level thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 4 ], level.xcam_anchor );
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0xd78cf3c5, Offset: 0x87f7
// Size: 0x3f9
function private function_3fad19a839960056( scenename, flagmsg, previousscene )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"xcam_transition" );
    level endon( #"xcam_transition" );
    level.xcam_anchor.intransition = 1;
    level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
    level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
    
    while ( true )
    {
        if ( !( isdefined( level.var_ddbddc069152b02f ) && isdefined( level.var_4f103db18dbbaee4 ) ) )
        {
            if ( !isdefined( function_fcd62fd219292ac7() ) )
            {
                blendtime = 0;
                
                if ( isdefined( level.xcam_anchors[ scenename ][ "blend_time" ] ) )
                {
                    blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "default" ];
                    
                    if ( isdefined( previousscene ) && isdefined( level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ] ) )
                    {
                        blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ];
                    }
                }
                
                set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 4 ], 0, blendtime, level.xcam_anchor );
                level thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 4 ], level.xcam_anchor );
            }
            else if ( function_fcd62fd219292ac7().name == "iw9_fe_op_select_east_edit_in_xcam" || function_fcd62fd219292ac7().name == "iw9_fe_op_select_west_edit_in_xcam" )
            {
                blendtime = 0;
                
                if ( isdefined( level.xcam_anchors[ scenename ][ "blend_time" ] ) )
                {
                    blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "default" ];
                    
                    if ( isdefined( previousscene ) && isdefined( level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ] ) )
                    {
                        blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ];
                    }
                }
                
                set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 4 ], 0, 0.35, level.xcam_anchor );
                level thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 4 ], level.xcam_anchor );
            }
            
            waitframe();
            continue;
        }
        
        var_e5d3fe1e80e96248 = level.var_ddbddc069152b02f;
        gender = level.var_4f103db18dbbaee4;
        
        if ( gender == 1 )
        {
            gender++;
        }
        
        xcamindex = var_e5d3fe1e80e96248 + gender;
        level.var_ddbddc069152b02f = undefined;
        level.var_4f103db18dbbaee4 = undefined;
        level notify( #"new_operator_xcam" );
        blendtime = 0;
        
        if ( isdefined( previousscene ) && isdefined( level.xcam_anchors[ scenename ][ "blend_time" ] ) && previousscene != "" )
        {
            blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "default" ];
            
            if ( isdefined( level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ] ) )
            {
                blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ];
            }
        }
        
        leng = 0;
        
        if ( !level.var_e365d8f09a7f6f27 )
        {
            set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ xcamindex ], 0, blendtime, level.xcam_anchor );
            leng = function_9773f7f795e37351( level.xcam_anchors[ scenename ][ "transitions" ][ xcamindex ] );
        }
        
        level.var_e365d8f09a7f6f27 = undefined;
        level thread function_b8b5fc49caf5f121( scenename, leng );
        previousscene = "";
        waitframe();
    }
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x7a159d3, Offset: 0x8bf8
// Size: 0x45a
function private lua_triggered_xcam_mm( scenename, flagmsg, previousscene )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"xcam_transition" );
    level endon( #"xcam_transition" );
    level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
    level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
    lobbyxcam = level.xcam_anchors[ scenename ][ "transitions" ][ 0 ];
    
    if ( isdefined( level.var_fa7c8f43d063eb71 ) )
    {
        lobbyxcam = level.var_fa7c8f43d063eb71;
    }
    
    set_xcam_wrapper( lobbyxcam, 0, 0, level.xcam_anchor );
    level.var_fa7c8f43d063eb71 = lobbyxcam;
    level.xcam_anchor.intransition = 1;
    thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], level.xcam_anchor );
    waittime = undefined;
    waitframe();
    
    while ( true )
    {
        waitframe();
        
        if ( isarray( flagmsg ) )
        {
            utility::flag_wait_any_array( flagmsg );
            
            foreach ( flagtoclear in flagmsg )
            {
                utility::flag_clear( flagtoclear );
            }
        }
        else
        {
            utility::flag_wait( flagmsg );
            utility::flag_clear( flagmsg );
        }
        
        level notify( #"xcam_loop" );
        currentcam = function_fcd62fd219292ac7();
        blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "default" ];
        
        if ( level.currentflagmsg == "match_making" )
        {
            blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "started_mm" ];
            set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 2 ], 0, blendtime, level.xcam_anchor );
            waittime = max( function_9773f7f795e37351( level.xcam_anchors[ scenename ][ "transitions" ][ 2 ] ) - 1500, 0 );
            break;
        }
        
        if ( level.currentflagmsg == "lobby_member_increase" && level.var_c111bc9d2e9166a9 == 1 && isdefined( currentcam ) && currentcam.name != "fe_lobby_plow_cam_01_idle_01_xcam" )
        {
            blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "lobby_member_increase" ];
            set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], 0, blendtime, level.xcam_anchor );
            thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], level.xcam_anchor );
            level.var_fa7c8f43d063eb71 = level.xcam_anchors[ scenename ][ "transitions" ][ 0 ];
            continue;
        }
        
        if ( level.currentflagmsg == "lobby_member_increase" && level.var_c111bc9d2e9166a9 > 1 && isdefined( currentcam ) && currentcam.name != "fe_lobby_plow_cam_01_idle_squad_01_xcam" )
        {
            blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "lobby_member_increase" ];
            set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 1 ], 0, blendtime, level.xcam_anchor );
            thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], level.xcam_anchor );
            level.var_fa7c8f43d063eb71 = level.xcam_anchors[ scenename ][ "transitions" ][ 1 ];
        }
    }
    
    level.var_fa7c8f43d063eb71 = undefined;
    
    if ( waittime > 0 )
    {
        thread function_c127478f4e169197( waittime );
    }
    
    level.xcam_anchor.intransition = 0;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x6f6e94a5, Offset: 0x905a
// Size: 0x73
function private function_c127478f4e169197( waittime )
{
    level notify( #"matchmaking_fade" );
    level endon( #"game_ended" );
    level endon( #"matchmaking_fade" );
    level endon( #"xcam_transition" );
    level endon( #"disconnect" );
    wait waittime / 1000;
    frontendscenecamerafade( 0, 1.5 );
    thread function_1820160e3d227430();
    wait 1.5;
    setomnvar( "frontend_screen_black", 1 );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xe3ba3dd, Offset: 0x90d5
// Size: 0x4f
function private function_1820160e3d227430()
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level endon( #"camera_teleport" );
    level utility::waittill_any( "xcam_set", "finished_scene_change" );
    frontendscenecamerafade( 1, 0.2 );
    setomnvar( "frontend_screen_black", 0 );
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x6b2d72dd, Offset: 0x912c
// Size: 0x50
function private function_8f61bece4244b228( scenename, flagmsg )
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level endon( #"xcam_transition" );
    utility::flag_wait( "zoom_clear" );
    level thread lua_triggered_attachment_zoom( scenename, flagmsg );
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x8fa8497, Offset: 0x9184
// Size: 0x420
function private lua_triggered_attachment_zoom( scenename, flagmsg, previousscene )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"xcam_transition" );
    level endon( #"xcam_transition" );
    level.xcam_anchor.intransition = 1;
    level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
    level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
    
    if ( distancesquared( level.xcam_anchor.origin, ( -5872.09, -3436.26, 0 ) ) > 14000 )
    {
        level.var_b039ebcdd7535c8a = undefined;
        utility::flag_clear( "force_weapon_update" );
        update_weapon_loc();
        waitframe();
        setomnvar( "frontend_weapon_position_force_update", 1 );
        utility::flag_wait( "force_weapon_update" );
        level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
        level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
    }
    
    set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], 0, 0, level.xcam_anchor );
    
    if ( isarray( flagmsg ) )
    {
        utility::flag_wait_any_array( flagmsg );
        
        foreach ( flagtoclear in flagmsg )
        {
            utility::flag_clear( flagtoclear );
        }
    }
    else
    {
        utility::flag_wait( flagmsg );
        utility::flag_clear( flagmsg );
    }
    
    index = 0;
    
    switch ( level.attach_zoom_type )
    {
        case #"hash_2630d03d6f5fc192":
            index = 1;
            break;
        case #"hash_ac8941a3f4be6fc5":
            index = 0;
            break;
        case #"hash_6fc1c97a058fdcc9":
            index = 2;
            break;
        case #"hash_c693ed0e3896fe7b":
            index = 3;
            break;
        case #"hash_3c53eb274322e803":
            index = 4;
            break;
        case #"hash_e32d2a49d1ac024c":
            index = 5;
            break;
        case #"hash_c9e63a9bddd371e":
            index = 6;
            break;
        case #"hash_412112410dc298ec":
            index = 7;
            break;
        case #"hash_754f51acf0f54d82":
            index = 8;
            break;
        case #"hash_1f1886e1d0bae31d":
            index = 9;
            break;
        case #"hash_bba42a71d53ec8d0":
            index = 0;
            break;
    }
    
    while ( level.active_section.name == scenename )
    {
        utility::flag_wait( "zoom_triggered" );
        utility::flag_clear( "zoom_triggered" );
        level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
        level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
        set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ index ], 0, level.gunsmithblendtime, level.xcam_anchor );
        
        if ( index == 0 )
        {
            level.gunsmithblendtime = 0.3;
        }
    }
    
    level.xcam_anchor.intransition = 0;
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x4248da82, Offset: 0x95ac
// Size: 0x14a
function private set_loadout_xcam( scenename, flagmsg, previousscene )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"xcam_transition" );
    level endon( #"xcam_transition" );
    blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "default" ];
    
    if ( isdefined( level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ] ) )
    {
        blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ previousscene ];
    }
    
    while ( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ] == "" )
    {
        waitframe();
    }
    
    level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
    level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
    set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], 0, blendtime, level.xcam_anchor );
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0xcff27d7b, Offset: 0x96fe
// Size: 0xb2
function private loop_xcam( xcam, xcam_anchor )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"xcam_loop" );
    level endon( #"xcam_loop" );
    level endon( #"xcam_transition" );
    level endon( #"new_operator_xcam" );
    
    while ( true )
    {
        leng = function_9773f7f795e37351( xcam );
        
        if ( leng <= 0 )
        {
            waitframe();
            continue;
        }
        else
        {
            wait leng / 1000;
        }
        
        set_xcam_wrapper( xcam, 0, 0.3, xcam_anchor );
    }
    
    level.xcam_anchor.intransition = 0;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xcefd433d, Offset: 0x97b8
// Size: 0x366
function private xcam_transition( scenename )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level notify( #"xcam_transition" );
    level endon( #"xcam_transition" );
    
    /#
        setdevdvar( @"hash_d7c75a291ea3ac1d", scenename );
    #/
    
    transitionsize = level.xcam_anchors[ scenename ][ "transitions" ].size;
    
    if ( transitionsize == 0 )
    {
        return;
    }
    
    if ( isdefined( level.xcam_anchors[ scenename ][ "callback" ] ) && isdefined( level.xcam_anchors[ scenename ][ "flag_msg" ] ) )
    {
        level thread [[ level.xcam_anchors[ scenename ][ "callback" ] ]]( scenename, level.xcam_anchors[ scenename ][ "flag_msg" ], level.currentsectionname );
        return;
    }
    
    if ( isdefined( level.xcam_anchors[ scenename ][ "blend_time" ] ) )
    {
        blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ "default" ];
        
        if ( isdefined( level.currentsectionname ) && isdefined( level.xcam_anchors[ scenename ][ "blend_time" ][ level.currentsectionname ] ) )
        {
            blendtime = level.xcam_anchors[ scenename ][ "blend_time" ][ level.currentsectionname ];
        }
    }
    
    if ( !isdefined( blendtime ) )
    {
        blendtime = 0;
    }
    
    level.xcam_anchor.origin = level.xcam_anchors[ scenename ][ "xcam_data" ].origin;
    level.xcam_anchor.angles = level.xcam_anchors[ scenename ][ "xcam_data" ].angles;
    
    if ( transitionsize == 1 )
    {
        set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], 0, blendtime, level.xcam_anchor );
        
        if ( level.xcam_anchors[ scenename ][ "loop_last" ] )
        {
            level thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ 0 ], level.xcam_anchor );
        }
        
        return;
    }
    
    level.xcam_anchor.intransition = 1;
    firstxcamindex = level.transitionarray[ scenename ][ level.currentsectionname ][ "firstXCamIndex" ];
    
    if ( !isdefined( firstxcamindex ) )
    {
        firstxcamindex = level.transitionarray[ scenename ][ "default" ][ "firstXCamIndex" ];
    }
    
    firstxcamindex = min( firstxcamindex ?? 0, transitionsize - 1 );
    
    for ( i = firstxcamindex; i < transitionsize ; i++ )
    {
        set_xcam_wrapper( level.xcam_anchors[ scenename ][ "transitions" ][ i ], 0, blendtime, level.xcam_anchor );
        
        if ( i < transitionsize - 1 )
        {
            leng = function_9773f7f795e37351( level.xcam_anchors[ scenename ][ "transitions" ][ i ] );
            wait leng / 1000;
        }
    }
    
    if ( level.xcam_anchors[ scenename ][ "loop_last" ] )
    {
        level thread loop_xcam( level.xcam_anchors[ scenename ][ "transitions" ][ transitionsize - 1 ], level.xcam_anchor );
        return;
    }
    
    level.xcam_anchor.intransition = 0;
}

// Namespace frontendutils
// Params 4, eflags: 0x4
// Checksum 0xf2680d2a, Offset: 0x9b26
// Size: 0x97
function private set_xcam_wrapper( xcam, subcamera, blendtime, xcam_anchor )
{
    tmpanchor = xcam_anchor;
    
    if ( isdefined( level.xcam_offset ) )
    {
        tmpanchor.origin += level.xcam_offset;
    }
    
    level.xcam_offset = undefined;
    function_41797a7aad14e175( xcam, subcamera, blendtime, tmpanchor );
    
    /#
        setdevdvar( @"hash_b281f39ee3f3f20b", xcam );
    #/
    
    level notify( #"xcam_set" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x1af39c84, Offset: 0x9bc5
// Size: 0xf1
function private set_xcam()
{
    update_entities_and_camera( level.currentsectionname );
    
    if ( !isdefined( level.xcam_anchors ) )
    {
        return;
    }
    
    scenename = level.active_section.name;
    
    if ( !function_270ae4327a1f5bbd( scenename ) && !function_dc431df3348b6bf2( scenename ) && level.var_b039ebcdd7535c8a )
    {
        level.var_b039ebcdd7535c8a = undefined;
    }
    
    if ( function_dc431df3348b6bf2( scenename ) )
    {
        function_adcb617248dab87e();
    }
    
    if ( !isdefined( level.xcam_anchors[ scenename ] ) )
    {
        scenename = function_8e87b77f70835fd4( scenename );
    }
    
    /#
        setdevdvar( @"hash_d7c75a291ea3ac1d", scenename ?? "<dev string:x24>" );
    #/
    
    if ( isdefined( scenename ) && isdefined( level.xcam_anchors[ scenename ] ) )
    {
        level.xcam_anchor.intransition = 0;
        level thread xcam_transition( scenename );
        return 1;
    }
    
    return 0;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x4fae9b0b, Offset: 0x9cbf
// Size: 0x177, Type: bool
function private function_8e2c1dc1a32a131f( previousscene )
{
    activexcam = function_fcd62fd219292ac7();
    scenename = level.active_section.name;
    
    if ( !isdefined( activexcam ) )
    {
        return false;
    }
    
    if ( !isdefined( level.transitionarray[ scenename ] ) )
    {
        return true;
    }
    
    transition = undefined;
    
    if ( isdefined( level.transitionarray[ scenename ][ previousscene ][ "transition" ] ) )
    {
        transition = level.transitionarray[ scenename ][ previousscene ][ "transition" ];
    }
    else if ( isdefined( level.transitionarray[ scenename ][ "default" ][ "transition" ] ) )
    {
        transition = level.transitionarray[ scenename ][ "default" ][ "transition" ];
    }
    
    if ( !isdefined( transition ) )
    {
        return true;
    }
    
    if ( transition == &frontend_camera_teleport )
    {
        return true;
    }
    
    callback = undefined;
    
    if ( isdefined( level.transitionarray[ scenename ][ previousscene ][ "callback" ] ) )
    {
        callback = level.transitionarray[ scenename ][ previousscene ][ "callback" ];
    }
    else if ( isdefined( level.transitionarray[ scenename ][ "default" ][ "callback" ] ) )
    {
        callback = level.transitionarray[ scenename ][ "default" ][ "callback" ];
    }
    
    if ( !isdefined( callback ) )
    {
        return true;
    }
    
    if ( transition == &frontend_camera_move && callback == &set_xcam )
    {
        return false;
    }
    
    return true;
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x2dcdd4e1, Offset: 0x9e3f
// Size: 0x28
function private end_current_xcam()
{
    function_88b02b89da25811d();
    level notify( #"xcam_transition" );
    level.xcam_anchor.intransition = 0;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xdeecfba1, Offset: 0x9e6f
// Size: 0x26
function private function_dd44ecf00812addc( tagarray )
{
    attachtype = tagarray[ 1 ];
    
    if ( !isdefined( attachtype ) )
    {
        return;
    }
    
    return attachtype;
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x2ece23f, Offset: 0x9e9e
// Size: 0xe7
function private function_27c7889021d20b28( tagarray, weaponpreview, currentscene )
{
    xcamname = function_b7fc60e11b93d6a8( tagarray[ 2 ], weaponpreview, currentscene );
    
    if ( !isdefined( xcamname ) )
    {
        return;
    }
    
    tagstruct = spawnstruct();
    tagstruct.name = tagarray[ 2 ];
    tagstruct.xcam = xcamname;
    tagstruct.origin = ( float( tagarray[ 3 ] ), float( tagarray[ 4 ] ), float( tagarray[ 5 ] ) );
    tagstruct.angles = ( float( tagarray[ 6 ] ), float( tagarray[ 7 ] ), float( tagarray[ 8 ] ) );
    
    if ( isdefined( tagarray[ 9 ] ) )
    {
        tagstruct.class = tagarray[ 9 ];
    }
    
    if ( isdefined( tagarray[ 10 ] ) )
    {
        tagstruct.weaponname = tagarray[ 10 ];
    }
    
    return tagstruct;
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0xf7fbed7a, Offset: 0x9f8e
// Size: 0xd4
function private function_7007bd7f0543df4a( tagarray, weaponpreview, currentscene )
{
    xcamname = function_b7fc60e11b93d6a8( tagarray[ 0 ], weaponpreview, currentscene );
    
    if ( !isdefined( xcamname ) )
    {
        return;
    }
    
    zangle = float( tagarray[ 6 ] );
    
    if ( tagarray[ 0 ] == "tag_laser_attach" )
    {
        zangle = 90;
    }
    
    tagstruct = spawnstruct();
    tagstruct.name = tagarray[ 0 ];
    tagstruct.xcam = xcamname;
    tagstruct.origin = ( float( tagarray[ 1 ] ), float( tagarray[ 2 ] ), float( tagarray[ 3 ] ) );
    tagstruct.angles = ( float( tagarray[ 4 ] ), float( tagarray[ 5 ] ), zangle );
    return tagstruct;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xbaa49fb, Offset: 0xa06b
// Size: 0x4d, Type: bool
function private function_e67750d82fc610b1( class )
{
    if ( !isdefined( class ) )
    {
        return false;
    }
    
    return class == "weapon_projectile" || class == "weapon_classic_s" || class == "weapon_melee2" || class == "weapon_melee" || class == "weapon_classic_p";
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x9fded9e0, Offset: 0xa0c1
// Size: 0x11b
function private function_f06cf0469ec1c48( currentscene )
{
    if ( !isdefined( currentscene ) )
    {
        return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_02_xcam" );
    }
    
    switch ( currentscene )
    {
        case #"hash_5cc66fe2e71f720a":
            return "fe_op_crib_xcam_gunbundle_01_xcam";
        case #"hash_7e8acee7da2d9002":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_01_xcam" );
        case #"hash_5e1d833551ca1661":
            return "fe_op_crib_xcam_gunbundle_01_xcam";
        case #"hash_c364c37a7df6456":
            return "fe_op_crib_xcam_gunbundle_02_xcam";
        case #"hash_248405f0613a37fd":
            return "fe_op_crib_xcam_gunbundle_02_xcam";
        case #"hash_19ed0e9de6d8f60e":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_02_xcam" );
        case #"hash_2ad4511c672b3479":
            return "fe_op_crib_xcam_gunbundle_02_xcam";
        case #"hash_be3bd585498a6ae6":
            return "fe_op_crib_xcam_gunbundle_03_xcam";
        case #"hash_c36ef36dd1c5f0be":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_03_xcam" );
        case #"hash_facaeaf0ac11387d":
            return "fe_op_crib_xcam_gunbundle_03_xcam";
        default:
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_02_xcam" );
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x161335c6, Offset: 0xa1e4
// Size: 0x6b
function private function_ab30ef267649ed79( currentscene )
{
    if ( !isdefined( currentscene ) )
    {
        return "fe_op_crib_xcam_gunbundle_02_xcam";
    }
    
    switch ( currentscene )
    {
        case #"hash_fb8d15ff96772235":
            return "fe_op_crib_xcam_gunbundle_01_xcam";
        case #"hash_3fec9c3219804c0d":
            return "fe_op_crib_xcam_gunbundle_02_xcam";
        case #"hash_1d26c8f742a4ef31":
            return "fe_op_crib_xcam_gunbench_03_xcam";
        default:
            return "fe_op_crib_xcam_gunbundle_02_xcam";
    }
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x6329aaad, Offset: 0xa257
// Size: 0x24b
function private function_b7fc60e11b93d6a8( tag, weaponpreview, currentscene )
{
    switch ( tag )
    {
        case #"hash_2ebbd10bc3f36e0e":
        case #"hash_7bdd7b80127fa4f4":
            return function_f06cf0469ec1c48( currentscene );
        case #"hash_2f9cdb76a336eceb":
            return function_ab30ef267649ed79( currentscene );
        case #"hash_c140f05197182dbf":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_mz_xcam" );
        case #"hash_b74aa2c7e628b458":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_br_pistol_xcam" );
        case #"hash_8aaca5091d505bc4":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_br_xcam" );
        case #"hash_96d433e5bdc6bf10":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_br_sniper_xcam" );
        case #"hash_b1b3f69cc133ac94":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_fg_xcam" );
        case #"hash_19a1970c29085405":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_lz_xcam" );
        case #"hash_635902b104004521":
        case #"hash_9a1cf7dcaacdd82c":
            return "fe_op_crib_xcam_gunbench_mg_xcam";
        case #"hash_84eed77be6815580":
        case #"hash_a52679d5a5b05b52":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_op_xcam" );
        case #"hash_d49595fe0280fea1":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_gp_xcam" );
        case #"hash_dd3f3b9997ed3d6a":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_st_pistol_xcam" );
        case #"hash_57b788e828981035":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_st_xcam" );
        case #"hash_6920bec13886425c":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_um_xcam" );
        case #"hash_385d996ef17d925d":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_ammo" );
        case #"hash_a4daec5079604c53":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_ch_xcam" );
        case #"hash_3f0ecc42f886065f":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_gs_xcam" );
        case #"hash_8501367b06a03483":
            return ( level.var_3ff084b89b959f13 + "fe_op_crib_xcam_gunbench_stkrs_xcam" );
        case #"hash_ea364af169c3280e":
            return "fe_op_crib_xcam_gunbench_stkrs_sh_xcam";
        default:
            return;
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x3f00d15e, Offset: 0xa4aa
// Size: 0x2bd
function private function_8e87b77f70835fd4( scenename )
{
    switch ( scenename )
    {
        case #"hash_2bc9361cebbbcbd2":
        case #"hash_3287498ac2bdec62":
        case #"hash_7e5fff2eb82441c6":
        case #"hash_703c7fd9224070b1":
            return "tag_silencer";
        case #"hash_21aa25df730e1363":
        case #"hash_1a02be6831832733":
        case #"hash_bed1face88fdcb22":
        case #"hash_bed1f9ce88fdc98f":
        case #"hash_b03e7af96e0cc592":
        case #"hash_5c8cf8ab59b4ef97":
            return "tag_barrel_attach";
        case #"hash_1a96f606bada8c07":
        case #"hash_3d5aa4ebe484d097":
        case #"hash_e2a532526c4b1986":
            return "tag_grip_attach";
        case #"hash_77f7b408606d1238":
        case #"hash_ea6b42a40068e528":
        case #"hash_a5e0219576906481":
        case #"hash_c3c7633ef4e5e971":
        case #"hash_c39eb86ef6e2f365":
        case #"hash_77f7b708606d16f1":
            return "tag_pistolgrip_attach";
        case #"hash_1e404931df187946":
        case #"hash_c9fc556dd4fb88f6":
        case #"hash_b91600265f2dd072":
        case #"hash_5161faf8fea12ebc":
        case #"hash_5161fdf8fea13375":
            return "tag_laser_attach";
        case #"hash_ce66d785edbb652d":
        case #"hash_72931d90e9f9c4fd":
        case #"hash_a29c118653f671":
        case #"hash_7ec8461faf149064":
        case #"hash_7ec8491faf14951d":
        case #"hash_594a0c65c7d7cc28":
        case #"hash_bce86e3a86f0c8ed":
        case #"hash_bce86b3a86f0c434":
            return "j_mag1";
        case #"hash_b254a9604b488320":
        case #"hash_b32dd453b0b185ef":
        case #"hash_a271bcda8ca803bc":
        case #"hash_ffa5b7c1c1a799f0":
            return "tag_reflex";
        case #"hash_189960eb1cd2112f":
        case #"hash_a8d85b2b5283a5cb":
        case #"hash_5890922b50b3f2ce":
        case #"hash_46b9834d37017c5f":
        case #"hash_4194b71a94fb817e":
        case #"hash_4194b61a94fb7feb":
            return "tag_stock_attach";
        case #"hash_ae36caa1297604f2":
        case #"hash_472c95bf362ca54a":
        case #"hash_472c92bf362ca091":
        case #"hash_989642de7c8f0501":
        case #"hash_472c90bf362c9d6b":
        case #"hash_4379b9c7a2831922":
        case #"hash_98963fde7c8f0048":
        case #"hash_19ed0e9de6d8f60e":
        case #"hash_fda8d24e03c1db76":
            return "j_gun";
        default:
            return;
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xd25fce66, Offset: 0xa76f
// Size: 0x395
function private function_4a31f3d861553676( tagarray )
{
    primaryarray = [];
    secondaryarray = [];
    lethalarray = [];
    tacticalarray = [];
    defaultprimaryarray = [];
    defaultprimaryarray[ 2 ] = -5910;
    defaultprimaryarray[ 3 ] = -3650;
    defaultprimaryarray[ 4 ] = 45;
    defaultprimaryarray[ 5 ] = 0;
    defaultprimaryarray[ 6 ] = 270;
    defaultprimaryarray[ 7 ] = 90;
    defaultsecondaryarray = [];
    defaultsecondaryarray[ 10 ] = -5894;
    defaultsecondaryarray[ 11 ] = -3658;
    defaultsecondaryarray[ 12 ] = 45;
    defaultsecondaryarray[ 13 ] = 360;
    defaultsecondaryarray[ 14 ] = 90;
    defaultsecondaryarray[ 15 ] = 90;
    var_5a0fcc3d02a00d32 = [];
    var_5a0fcc3d02a00d32[ 17 ] = -5878;
    var_5a0fcc3d02a00d32[ 18 ] = -3642;
    var_5a0fcc3d02a00d32[ 19 ] = 42;
    var_5a0fcc3d02a00d32[ 20 ] = 0;
    var_5a0fcc3d02a00d32[ 21 ] = 227;
    var_5a0fcc3d02a00d32[ 22 ] = 0;
    var_1ebbdd09cf4235a3 = [];
    var_1ebbdd09cf4235a3[ 24 ] = -5879;
    var_1ebbdd09cf4235a3[ 25 ] = -3659;
    var_1ebbdd09cf4235a3[ 26 ] = 44;
    var_1ebbdd09cf4235a3[ 27 ] = 0;
    var_1ebbdd09cf4235a3[ 28 ] = 235;
    var_1ebbdd09cf4235a3[ 29 ] = 0;
    
    for ( i = 0; i < tagarray.size ; i++ )
    {
        if ( i > 7 && i < 16 )
        {
            if ( tagarray[ i ] != "none" )
            {
                secondaryarray[ secondaryarray.size ] = tagarray[ i ];
            }
            else
            {
                secondaryarray[ secondaryarray.size ] = defaultsecondaryarray[ i ];
            }
            
            continue;
        }
        
        if ( i >= 16 && i < 23 )
        {
            if ( tagarray[ i ] != "none" )
            {
                lethalarray[ lethalarray.size ] = tagarray[ i ];
            }
            else
            {
                lethalarray[ lethalarray.size ] = var_5a0fcc3d02a00d32[ i ];
            }
            
            continue;
        }
        
        if ( i >= 23 )
        {
            if ( tagarray[ i ] != "none" )
            {
                tacticalarray[ tacticalarray.size ] = tagarray[ i ];
            }
            else
            {
                tacticalarray[ tacticalarray.size ] = var_1ebbdd09cf4235a3[ i ];
            }
            
            continue;
        }
        
        if ( tagarray[ i ] != "none" )
        {
            primaryarray[ primaryarray.size ] = tagarray[ i ];
            continue;
        }
        
        primaryarray[ primaryarray.size ] = defaultprimaryarray[ i ];
    }
    
    var_b60617b6b29dd45c = function_1eba9adf23e98508( primaryarray[ 1 ] );
    var_6e5290620ac09e14 = function_68190f6a4d8cf26a( secondaryarray[ 1 ] );
    
    if ( !( isdefined( var_b60617b6b29dd45c ) && isdefined( var_6e5290620ac09e14 ) ) )
    {
        return;
    }
    
    var_268bfe0a9c21273b = spawnstruct();
    var_268bfe0a9c21273b.name = "loadout_showcase_p";
    var_268bfe0a9c21273b.xcam = var_b60617b6b29dd45c;
    var_268bfe0a9c21273b.origin = ( float( primaryarray[ 2 ] ), float( primaryarray[ 3 ] ), float( primaryarray[ 4 ] ) );
    var_7f6db7f3102c6cff = spawnstruct();
    var_7f6db7f3102c6cff.name = function_da403ea21456c938( secondaryarray[ 1 ] );
    var_7f6db7f3102c6cff.xcam = var_6e5290620ac09e14;
    var_7f6db7f3102c6cff.origin = ( float( secondaryarray[ 2 ] ), float( secondaryarray[ 3 ] ), float( secondaryarray[ 4 ] ) );
    level.xcam_anchors[ "loadout_showcase_o" ][ "transitions" ] = [];
    level.xcam_anchors[ "loadout_showcase_o" ][ "transitions" ][ 0 ] = var_7f6db7f3102c6cff.xcam;
    var_b78cd189590c2281 = spawnstruct();
    var_b78cd189590c2281.name = "loadout_showcase_l";
    var_b78cd189590c2281.xcam = level.var_3ff084b89b959f13 + "fe_op_crib_xcam_loadout_equip_xcam";
    var_c6f373451cd1cf8a = spawnstruct();
    var_c6f373451cd1cf8a.name = "loadout_showcase_t";
    var_c6f373451cd1cf8a.xcam = level.var_3ff084b89b959f13 + "fe_op_crib_xcam_loadout_equip_xcam";
    return [ var_268bfe0a9c21273b, var_7f6db7f3102c6cff, var_b78cd189590c2281, var_c6f373451cd1cf8a ];
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xed952716, Offset: 0xab0d
// Size: 0xac
function private function_da403ea21456c938( weaponname )
{
    switch ( weaponname )
    {
        case #"hash_bef5ec0b3e197ae":
        case #"hash_16cf6289ab06bd30":
        case #"hash_47368bc0d2ef1565":
        case #"hash_8af0086b038622b5":
        case #"hash_9d18adab1b65a661":
        case #"hash_ab10f9c080fe4faf":
        case #"hash_c095d67337b1f5a1":
        case #"hash_dd616da0b395a0b0":
            return "loadout_showcase_s";
        case #"hash_34340d457a63e7f1":
        case #"hash_86b11ac21f992552":
            return "loadout_showcase_s";
        default:
            return "loadout_showcase_s";
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x20a36554, Offset: 0xabc1
// Size: 0xbf
function private function_1eba9adf23e98508( tag )
{
    switch ( tag )
    {
        case #"hash_a1f27f97be15d620":
        case #"hash_ab10f9c080fe4faf":
            return "fe_op_crib_xcam_loadout_smg_xcam";
        case #"hash_16cf6289ab06bd30":
        case #"hash_47368bc0d2ef1565":
        case #"hash_8af0086b038622b5":
        case #"hash_dd616da0b395a0b0":
            return "fe_op_crib_xcam_loadout_ar_xcam";
        case #"hash_bef5ec0b3e197ae":
        case #"hash_86b11ac21f992552":
        case #"hash_9d18adab1b65a661":
        case #"hash_c095d67337b1f5a1":
            return "fe_op_crib_xcam_loadout_sn_xcam";
        case #"hash_34340d457a63e7f1":
            return "fe_op_crib_xcam_loadout_pi_xcam";
        default:
            return;
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x174ef4dc, Offset: 0xac88
// Size: 0xbf
function private function_68190f6a4d8cf26a( tag )
{
    switch ( tag )
    {
        case #"hash_a1f27f97be15d620":
        case #"hash_ab10f9c080fe4faf":
            return "fe_op_crib_xcam_loadout_smg_xcam";
        case #"hash_16cf6289ab06bd30":
        case #"hash_47368bc0d2ef1565":
        case #"hash_8af0086b038622b5":
        case #"hash_dd616da0b395a0b0":
            return "fe_op_crib_xcam_loadout_ar_xcam";
        case #"hash_bef5ec0b3e197ae":
        case #"hash_86b11ac21f992552":
        case #"hash_9d18adab1b65a661":
        case #"hash_c095d67337b1f5a1":
            return "fe_op_crib_xcam_loadout_sn_xcam";
        case #"hash_34340d457a63e7f1":
            return "fe_op_crib_xcam_loadout_pi_xcam";
        default:
            return;
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xeb60a223, Offset: 0xad4f
// Size: 0x5a
function private function_bca7483b25613aa()
{
    var_870578de2aac0499 = undefined;
    
    if ( isxhashasset( level.projectbundle.frontendsectionlist ) )
    {
        var_870578de2aac0499 = getscriptbundle( level.projectbundle.frontendsectionlist );
    }
    
    assert( var_870578de2aac0499, "<dev string:x5a2>" );
    function_eebf119ddfa170c2( var_870578de2aac0499 );
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x5414570c, Offset: 0xadb1
// Size: 0x372
function private function_eebf119ddfa170c2( var_870578de2aac0499 )
{
    sectionarray = [];
    transitionarray = [];
    xcam_anchors = [];
    level.var_8418c3430977ba15 = [];
    level.var_223b66edcb3ec69 = [];
    var_15854cf4f584f005 = [];
    level.nonetransition = [ "ignore":1 ];
    
    foreach ( section in var_870578de2aac0499.frontendsectionlist )
    {
        var_eeaaf224f900837e = section.frontendsection;
        sectionscriptbundle = getscriptbundle( var_eeaaf224f900837e );
        sectionname = sectionscriptbundle.sectionname;
        
        if ( !isdefined( sectionscriptbundle ) )
        {
            assert( 0, "<dev string:x5cd>" + var_eeaaf224f900837e );
            continue;
        }
        
        if ( !( isdefined( sectionname ) && sectionname != "" ) )
        {
            assert( 0, "<dev string:x5fc>" + var_eeaaf224f900837e + "<dev string:x61d>" );
            continue;
        }
        
        if ( !!isdefined( var_15854cf4f584f005[ sectionname ] ) )
        {
            assert( 0, "<dev string:x646>" + sectionname );
            continue;
        }
        
        var_15854cf4f584f005[ sectionscriptbundle.sectionname ] = sectionscriptbundle;
        transitionarray[ sectionname ] = [];
        
        if ( sectionscriptbundle.var_8b733a02ea9e464c && isdefined( sectionscriptbundle.defaulttransition ) )
        {
            transitionarray[ sectionscriptbundle.sectionname ][ "default" ] = function_8c25621b7e6287c6( sectionscriptbundle.defaulttransition, "default" );
        }
        
        foreach ( transition in sectionscriptbundle.transitions )
        {
            transitiondata = function_31f1c684e6f92d5b( transition.transitiondata );
            transitionarray[ sectionname ][ transition.sectionref ] = transitiondata ?? level.nonetransition;
        }
        
        var_dfaa234d62e70556 = sectionscriptbundle.var_bab505ce5ab925b9;
        
        if ( isdefined( var_dfaa234d62e70556 ) && var_dfaa234d62e70556 != "" )
        {
            var_a56d9eee5b357771 = getscriptbundle( var_dfaa234d62e70556 );
            
            if ( !isdefined( var_a56d9eee5b357771 ) )
            {
                assert( 0, "<dev string:x678>" + var_dfaa234d62e70556 );
                continue;
            }
            
            if ( !!isdefined( xcam_anchors[ sectionname ] ) )
            {
                assert( 0, "<dev string:x69e>" + sectionname );
                continue;
            }
            
            xcam_anchors[ sectionname ] = function_e45f9d8520f420ed( var_dfaa234d62e70556 );
        }
        
        sectionarray[ sectionname ] = function_cac91428c03fa0e3( sectionscriptbundle );
        
        /#
            if ( !isdefined( level.var_86e3e1ec32aa44f1 ) )
            {
                level.var_86e3e1ec32aa44f1 = [];
            }
            
            level.var_86e3e1ec32aa44f1[ sectionname ] = var_a56d9eee5b357771.entity.entityname;
        #/
    }
    
    level.var_8418c3430977ba15 = undefined;
    level.var_223b66edcb3ec69 = undefined;
    level.sectionarray = sectionarray;
    level.transitionarray = transitionarray;
    level.xcam_anchors = xcam_anchors;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xbd5d2d3d, Offset: 0xb12b
// Size: 0x257
function private function_cac91428c03fa0e3( bundle )
{
    sectionstruct = spawnstruct();
    var_41242dd4b44a5c56 = bundle.basecam;
    var_c944d58bbf8aea2c = var_41242dd4b44a5c56.targetname ?? "";
    var_1b272ed380e1c1b0 = var_41242dd4b44a5c56.fstop ?? 0;
    var_49d3e1297d825fe9 = var_41242dd4b44a5c56.focusdistance ?? 0;
    var_25b2f40f80ba1069 = var_41242dd4b44a5c56.fov ?? 0;
    sectionstruct.basecam = frontend_camera_get_entity( var_c944d58bbf8aea2c ?? "" ) ?? spawnstruct();
    sectionstruct.basecam.depthoffieldvalues = [ var_1b272ed380e1c1b0, var_49d3e1297d825fe9 ];
    sectionstruct.myfov = var_25b2f40f80ba1069;
    
    foreach ( entry in bundle.spawnentities )
    {
        entType = entry.type ?? #"clientcharacter";
        entindex = entry.index ?? 0;
        targetname = entry.targetname ?? "";
        
        switch ( entType )
        {
            case #"clientcharacter":
                sectionstruct.char_index = entindex;
                sectionstruct.char_loc = frontend_camera_get_entity( targetname );
                break;
            case #"clientweapon":
                sectionstruct.weapon_locs[ entindex ] = frontend_camera_get_entity( targetname );
                break;
        }
    }
    
    sectionstruct.hwconfig = bundle.hwconfig;
    var_ef66b88312732658 = get_char_loc_callback( bundle.sectionname );
    sectionstruct.update_char_loc = var_ef66b88312732658;
    return sectionstruct;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x22bae654, Offset: 0xb38b
// Size: 0x12b
function private get_char_loc_callback( sectionname )
{
    switch ( sectionname )
    {
        case #"hash_1b3ccd8c05bf147a":
        case #"hash_a03b1add89f2d35e":
            return &update_lobby_char_loc;
        case #"hash_973939f2d2694e98":
            return &function_31300ad368313ff2;
        case #"hash_787e7e5e19624661":
        case #"hash_a4ee0391db6b651f":
            return &function_74a35d05491a35e;
        case #"hash_1319c1ff531ed768":
        case #"hash_15c453ef442d22e6":
        case #"hash_40248e51024c9732":
        case #"hash_94165ff5cf7fa155":
        case #"hash_a155b5016bfdb759":
        case #"hash_fa98418ade667a96":
            return &function_56ec697557e5bcb9;
        case #"hash_95b65e00718558d":
        case #"hash_442dd9aded5a5adb":
        case #"hash_4b6d30af28ce17f1":
        case #"hash_4b6d3aaf28ce27af":
        case #"hash_d75ba083b1c5e911":
            return &update_main_menu_char_loc;
        case #"hash_4205f17832919979":
        case #"hash_d96b102da878bf0f":
        case #"hash_eabd7b3e2f655111":
            return &function_c2e9d8d8407b0064;
        default:
            return;
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x71ff7eed, Offset: 0xb4be
// Size: 0x5b
function private function_31f1c684e6f92d5b( bundleref )
{
    if ( !isdefined( bundleref ) )
    {
        return;
    }
    
    if ( isdefined( level.var_8418c3430977ba15[ bundleref ] ) )
    {
        return level.var_8418c3430977ba15[ bundleref ];
    }
    
    transitiondata = function_8c25621b7e6287c6( getscriptbundle( bundleref ), bundleref );
    level.var_8418c3430977ba15[ bundleref ] = transitiondata;
    return transitiondata;
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x73270aa8, Offset: 0xb522
// Size: 0x284
function private function_8c25621b7e6287c6( var_2e54b8e3bc926c40, name )
{
    populatedtransition = [];
    
    if ( !isdefined( var_2e54b8e3bc926c40 ) )
    {
        assert( 0, "<dev string:x6d3>" );
    }
    
    populatedtransition[ "fadeOutTime" ] = var_2e54b8e3bc926c40.fadeouttime;
    
    if ( !isdefined( var_2e54b8e3bc926c40.fadeouttime ) && var_2e54b8e3bc926c40.var_8cdb3ce2b46cd858 )
    {
        populatedtransition[ "fadeOutTime" ] = 0;
    }
    
    populatedtransition[ "fadeInTime" ] = var_2e54b8e3bc926c40.fadeintime;
    
    if ( !isdefined( var_2e54b8e3bc926c40.fadeintime ) && var_2e54b8e3bc926c40.var_e43744f32099e34b )
    {
        populatedtransition[ "fadeInTime" ] = 0;
    }
    
    populatedtransition[ "fov" ] = var_2e54b8e3bc926c40.fieldofview;
    populatedtransition[ "speed" ] = var_2e54b8e3bc926c40.speed;
    populatedtransition[ "moveTime" ] = var_2e54b8e3bc926c40.movetime;
    populatedtransition[ "accelScalar" ] = var_2e54b8e3bc926c40.accelScalar;
    populatedtransition[ "decelScalar" ] = var_2e54b8e3bc926c40.decelScalar;
    populatedtransition[ "use_bounce" ] = var_2e54b8e3bc926c40.usebounce;
    populatedtransition[ "keepXCam" ] = var_2e54b8e3bc926c40.keepXCam;
    populatedtransition[ "firstXCamIndex" ] = var_2e54b8e3bc926c40.firstxcamindex;
    
    if ( isdefined( var_2e54b8e3bc926c40.transitiontype ) )
    {
        switch ( var_2e54b8e3bc926c40.transitiontype )
        {
            case #"hash_223f759868af15fe":
                populatedtransition[ "transition" ] = &frontend_camera_teleport;
                break;
            case #"hash_1fd03afa5ab05c54":
                populatedtransition[ "transition" ] = &frontend_camera_move;
                break;
        }
    }
    
    if ( isdefined( var_2e54b8e3bc926c40.callbacktype ) )
    {
        switch ( var_2e54b8e3bc926c40.callbacktype )
        {
            case #"hash_7906c5a21c5912ff":
                populatedtransition[ "callback" ] = &update_entities_and_camera;
                break;
            case #"hash_3e3d0b677a32918":
                populatedtransition[ "callback" ] = &set_xcam;
                break;
            case #"hash_88e0c61ba5df42cf":
                populatedtransition[ "callback" ] = &update_camera_depth_of_field;
                break;
            case #"hash_67f220df07c40521":
                populatedtransition[ "callback" ] = &update_player_character_showcase;
                break;
            case #"hash_e54d500699823fe7":
                populatedtransition[ "callback" ] = &update_entities;
                break;
            case #"hash_a2683b0b0bd42a1b":
            default:
                populatedtransition[ "callback" ] = undefined;
                break;
        }
    }
    
    populatedtransition[ "name" ] = name;
    return populatedtransition;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x73f93eb7, Offset: 0xb7af
// Size: 0x51
function private function_e45f9d8520f420ed( bundleref )
{
    if ( isdefined( level.var_223b66edcb3ec69[ bundleref ] ) )
    {
        return level.var_223b66edcb3ec69[ bundleref ];
    }
    
    var_bab505ce5ab925b9 = function_966a53d8bb70bfed( getscriptbundle( bundleref ) );
    level.var_223b66edcb3ec69[ bundleref ] = var_bab505ce5ab925b9;
    return var_bab505ce5ab925b9;
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x96ef2404, Offset: 0xb809
// Size: 0x41b
function private function_966a53d8bb70bfed( var_69828e4c36ce3972 )
{
    assert( isdefined( var_69828e4c36ce3972 ), "<dev string:x702>" );
    var_51f05b419fa744c7 = [];
    
    if ( isdefined( var_69828e4c36ce3972.origindata ) )
    {
        var_51f05b419fa744c7[ "xcam_data" ] = spawnstruct();
        origindata = var_69828e4c36ce3972.origindata;
        xcamorigin = ( origindata.xcamoriginx ?? 0, origindata.xcamoriginy ?? 0, origindata.xcamoriginz ?? 0 );
        xcamangles = ( origindata.var_b5087044b5864cff ?? 0, origindata.var_b5086f44b5864acc ?? 0, origindata.var_b5087244b5865165 ?? 0 );
        var_595e8162f476472f = ( 0, 0, 0 );
        originentityangles = ( 0, 0, 0 );
        
        if ( isdefined( var_69828e4c36ce3972.entity ) && var_69828e4c36ce3972.entity.hasentity )
        {
            originentity = frontend_camera_get_entity( var_69828e4c36ce3972.entity.entityname );
            
            if ( isdefined( originentity ) )
            {
                var_595e8162f476472f = originentity.origin;
                originentityangles = originentity.angles;
            }
        }
        
        var_51f05b419fa744c7[ "xcam_data" ].origin = var_595e8162f476472f + xcamorigin;
        var_51f05b419fa744c7[ "xcam_data" ].angles = originentityangles + xcamangles;
    }
    
    var_51f05b419fa744c7[ "transitions" ] = [];
    
    if ( isdefined( var_69828e4c36ce3972.transitions ) )
    {
        for ( i = 0; i < var_69828e4c36ce3972.transitions.size ; i++ )
        {
            var_51f05b419fa744c7[ "transitions" ][ i ] = var_69828e4c36ce3972.transitions[ i ].transition;
        }
    }
    
    var_51f05b419fa744c7[ "blend_time" ] = [];
    
    if ( isdefined( var_69828e4c36ce3972.blendtimes ) )
    {
        foreach ( blendtime in var_69828e4c36ce3972.blendtimes )
        {
            var_51f05b419fa744c7[ "blend_time" ][ blendtime.sectionref ] = blendtime.blendtime ?? 0;
        }
    }
    
    if ( var_69828e4c36ce3972.looplast )
    {
        var_51f05b419fa744c7[ "loop_last" ] = 1;
    }
    
    if ( !isdefined( var_69828e4c36ce3972.callbacktype ) )
    {
        var_69828e4c36ce3972.callbacktype = "NONE";
    }
    
    switch ( var_69828e4c36ce3972.callbacktype )
    {
        case #"hash_83e910d043e7613a":
            if ( !level.var_3d353e3274a23c81 )
            {
                var_51f05b419fa744c7[ "callback" ] = &lua_triggered_xcam_mm;
            }
            
            break;
        case #"hash_daf4861dedb70c73":
            var_51f05b419fa744c7[ "callback" ] = &function_3fad19a839960056;
            break;
        case #"hash_be26b70a0de5b599":
            var_51f05b419fa744c7[ "callback" ] = &lua_triggered_attachment_zoom;
            break;
        case #"hash_9bdce31b93c9f5ca":
            var_51f05b419fa744c7[ "callback" ] = &set_loadout_xcam;
            break;
    }
    
    if ( isarray( var_69828e4c36ce3972.flagmessages ) || var_69828e4c36ce3972.flagmessages.size > 0 )
    {
        var_51f05b419fa744c7[ "flag_msg" ] = [];
        
        foreach ( entry in var_69828e4c36ce3972.flagmessages )
        {
            var_51f05b419fa744c7[ "flag_msg" ][ var_51f05b419fa744c7[ "flag_msg" ].size ] = entry.flagmessage;
        }
    }
    
    return var_51f05b419fa744c7;
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x52659f05, Offset: 0xbc2d
// Size: 0x2f
function private initialize_loadout_data()
{
    level.var_29d3d6d1ca17b761 = [];
    level.var_29d3d6d1ca17b761[ 0 ] = "";
    level.var_29d3d6d1ca17b761[ 1 ] = "";
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x3ad760b0, Offset: 0xbc64
// Size: 0xe8
function private get_section_state( requestedsection )
{
    sectionstate = [];
    
    if ( isdefined( level.playerviewowner ) )
    {
        level.playerviewowner visionsetnakedforplayer( "", 0 );
    }
    
    section = level.sectionarray[ requestedsection.name ];
    
    if ( isdefined( section ) )
    {
        sectionstate[ "scene" ] = section;
        sectionstate[ "camera" ] = section.basecam;
        
        if ( isdefined( level.var_1dcfbe584df8a90e ) )
        {
            level.playerviewowner function_72cf2eee8e035013( level.var_1dcfbe584df8a90e );
            level.var_1dcfbe584df8a90e = undefined;
        }
        
        if ( isdefined( section.hwconfig ) )
        {
            level.playerviewowner function_a565dafac620d68e( section.hwconfig );
            level.var_1dcfbe584df8a90e = section.hwconfig;
        }
    }
    
    return sectionstate;
}

// Namespace frontendutils
// Params 0
// Checksum 0xbcbff4e5, Offset: 0xbd55
// Size: 0x8e
function hide_bouncecards()
{
    cards = getentarray( "bakeonly_bouncecards", #targetname );
    
    foreach ( card in cards )
    {
        card hide();
    }
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x97b6caa8, Offset: 0xbdeb
// Size: 0xbe
function private function_e2652b74f40fe569( charindex, origin = ( 0, 0, 0 ), angles = ( 0, 0, 0 ) )
{
    if ( !isdefined( level.client_characters[ charindex ] ) )
    {
        level.client_characters[ charindex ] = spawn( "script_character", origin, 0, 0, charindex, "MPClientCharacter" );
    }
    
    level.client_characters[ charindex ].origin = origin;
    level.client_characters[ charindex ].angles = angles;
    level.client_characters[ charindex ].characterindex = charindex;
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0xbc5e8a42, Offset: 0xbeb1
// Size: 0xa1
function private spawn_script_weapon( weaponindex, origin = ( 0, 0, 0 ), angles = ( 0, 0, 0 ) )
{
    if ( !isdefined( level.weapons[ weaponindex ] ) )
    {
        level.weapons[ weaponindex ] = spawn( "script_weapon", origin, 0, 0, weaponindex );
    }
    
    level.weapons[ weaponindex ].origin = origin;
    level.weapons[ weaponindex ].angles = angles;
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x2d8160be, Offset: 0xbf5a
// Size: 0x6df
function private setup_initial_entities()
{
    if ( !level.var_88cd03d85d960fe0 )
    {
        level.client_characters = [];
        
        if ( !isdefined( level.client_characters ) )
        {
            level.client_characters = [];
        }
        
        for ( charindex = 0; charindex < 8 ; charindex++ )
        {
            charloc = undefined;
            index = charindex + 1;
            
            if ( index < 10 )
            {
                charloc = frontend_camera_get_entity( "lobby_charslot_0" + index );
            }
            else
            {
                charloc = frontend_camera_get_entity( "lobby_charslot_" + index );
            }
            
            function_e2652b74f40fe569( charindex, charloc.origin );
        }
        
        for ( petindex = 0; petindex < 6 ; petindex++ )
        {
            index = petindex + 1;
            charindex = 8 + petindex;
            charloc = frontend_camera_get_entity( "lobby_charslot_0" + index + "_dog" );
            
            if ( isdefined( charloc ) )
            {
                function_e2652b74f40fe569( charindex, charloc.origin );
            }
        }
        
        if ( level.var_3d353e3274a23c81 )
        {
            charloc = frontend_camera_get_entity( "charroom_char_tango_solo" );
            function_e2652b74f40fe569( 18, charloc.origin, charloc.angles );
            function_e2652b74f40fe569( 14, charloc.origin, charloc.angles );
            function_e2652b74f40fe569( 15, charloc.origin, charloc.angles );
        }
        else
        {
            charloc = frontend_camera_get_entity( "charroom_char_tango_east" );
            function_e2652b74f40fe569( 18, charloc.origin );
            var_9c71223253a60ee1 = frontend_camera_get_entity( "charroom_char_tango_east" );
            function_e2652b74f40fe569( 14, var_9c71223253a60ee1.origin, var_9c71223253a60ee1.angles );
            var_8c04bce854586fe3 = frontend_camera_get_entity( "charroom_char_tango_west" );
            function_e2652b74f40fe569( 15, var_8c04bce854586fe3.origin, var_8c04bce854586fe3.angles );
            var_c8b126744b94fc67 = ( var_9c71223253a60ee1.origin + var_8c04bce854586fe3.origin ) / 2;
            var_5fadabd9c51ece29 = ( var_9c71223253a60ee1.angles + var_8c04bce854586fe3.angles ) / 2;
            function_e2652b74f40fe569( 16, var_c8b126744b94fc67, var_5fadabd9c51ece29 );
        }
        
        charloc = frontend_camera_get_entity( "battlepass_align_target_cer" );
        function_e2652b74f40fe569( 19, charloc.origin, charloc.angles );
    }
    
    if ( level.var_3d353e3274a23c81 )
    {
        charloc = frontend_camera_get_entity( "charroom_char_tango_solo" );
        function_e2652b74f40fe569( 18, charloc.origin, charloc.angles );
        function_e2652b74f40fe569( 14, charloc.origin, charloc.angles );
        function_e2652b74f40fe569( 15, charloc.origin, charloc.angles );
    }
    
    level.weapons = [];
    weapon_loc = frontend_camera_get_entity( "weapon_loc_hq1" );
    spawn_script_weapon( 0, weapon_loc.origin, weapon_loc.angles );
    
    if ( !isdefined( weapon_loc ) && ( level.var_3d353e3274a23c81 || level.var_88cd03d85d960fe0 ) )
    {
        level.weapons[ 0 ].angles = ( 0, 180, 0 );
    }
    
    weapon_loc2 = frontend_camera_get_entity( "weapon_loc_hq2" );
    spawn_script_weapon( 1, weapon_loc2.origin, weapon_loc2.angles );
    
    if ( !isdefined( weapon_loc2 ) && ( level.var_3d353e3274a23c81 || level.var_88cd03d85d960fe0 ) )
    {
        level.weapons[ 1 ].angles = ( 0, 180, 0 );
    }
    
    weapon_loc3 = frontend_camera_get_entity( "weapon_loc_hq3" );
    spawn_script_weapon( 2, weapon_loc3.origin, weapon_loc3.angles );
    
    if ( !isdefined( weapon_loc3 ) && ( level.var_3d353e3274a23c81 || level.var_88cd03d85d960fe0 ) )
    {
        level.weapons[ 2 ].angles = ( 0, 180, 0 );
    }
    
    preview_weapon_loc = frontend_camera_get_entity( "weapon_loc_preview" );
    spawn_script_weapon( 6, preview_weapon_loc.origin, preview_weapon_loc.angles );
    weapon_watch = frontend_camera_get_entity( "weapon_loc_watch" );
    spawn_script_weapon( 3, weapon_watch.origin, weapon_watch.angles );
    weapon_battlepass = frontend_camera_get_entity( "weapon_loc_preview_battlepass" );
    spawn_script_weapon( 4, weapon_battlepass.origin, weapon_battlepass.angles );
    weapon_store = frontend_camera_get_entity( "weapon_loc_preview_battlepass" );
    spawn_script_weapon( 5, weapon_store.origin, weapon_store.angles );
    
    if ( !level.var_88cd03d85d960fe0 )
    {
        level.var_bb92290a220ddeaa = getent( "br_cargoplane_exterior", #targetname );
        level.var_901d015765c1117e = getent( "br_cargoplane_car", #targetname );
        level.var_b1e0e9d9980f8174 = getentarray( "br_cargoplane", #targetname );
        
        if ( isdefined( level.var_bb92290a220ddeaa ) )
        {
            if ( isdefined( level.var_b1e0e9d9980f8174 ) )
            {
                foreach ( item in level.var_b1e0e9d9980f8174 )
                {
                    item linkto( level.var_bb92290a220ddeaa );
                }
            }
            
            level.var_bb92290a220ddeaa.originallocation = level.var_bb92290a220ddeaa.origin;
            level.var_bb92290a220ddeaa.originalangles = level.var_bb92290a220ddeaa.angles;
        }
        
        if ( isdefined( level.var_901d015765c1117e ) )
        {
            level.var_901d015765c1117e.originallocation = level.var_901d015765c1117e.origin;
        }
    }
    else
    {
        function_24387b6af8430fc4();
    }
    
    frontend_camera_setup( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread hide_bouncecards();
}

// Namespace frontendutils
// Params 2, eflags: 0x4
// Checksum 0x499176b1, Offset: 0xc641
// Size: 0x81
function private reset_preview_weapon_loc( unused, args )
{
    weapontransform = frontend_camera_get_entity( "weapon_loc_preview" );
    level.weapons[ 6 ] dontinterpolate();
    level.weapons[ 6 ].origin = weapontransform.origin;
    level.weapons[ 6 ].angles = weapontransform.angles;
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xcc80f600, Offset: 0xc6ca
// Size: 0x16
function private getgunbenchents()
{
    level.gunbenchbulletent = frontend_camera_get_entity( "gunbench_bullets" );
}

// Namespace frontendutils
// Params 3, eflags: 0x4
// Checksum 0x205b731a, Offset: 0xc6e8
// Size: 0x78
function private function_bb440638a4e00fd0( rewardscriptbundle, basecam, initialvalues )
{
    camerafstop = rewardscriptbundle.camerafstop;
    var_e21c58c4e7a3cd24 = rewardscriptbundle.var_e21c58c4e7a3cd24;
    
    if ( !isdefined( camerafstop ) )
    {
        camerafstop = initialvalues[ 0 ];
    }
    
    if ( !isdefined( var_e21c58c4e7a3cd24 ) )
    {
        var_e21c58c4e7a3cd24 = initialvalues[ 1 ];
    }
    
    basecam.depthoffieldvalues = [ camerafstop, var_e21c58c4e7a3cd24 ];
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x6738b91d, Offset: 0xc768
// Size: 0x181e
function private luinotifylistener()
{
    self endon( #"disconnect" );
    getgunbenchents();
    level.currentdropcount = 0;
    
    while ( true )
    {
        self waittill( #"luinotifyserver", msg, arg );
        channel = strtok( msg, "," )[ 0 ];
        
        if ( level.lui_callbacks[ channel ] || level.var_8140645f7e3c6266[ channel ] )
        {
            continue;
        }
        
        println( "<dev string:x737>" + msg );
        
        if ( msg == "end_current_xcam" )
        {
            end_current_xcam();
            continue;
        }
        
        if ( msg == "loadout_showcase_entered" )
        {
            level.bulletsinitialstate = 1;
            level.currentdropcount = 0;
            level.var_7ee813dc4c2b115f.origin = level.var_8015fd9f3d7dea27;
            level.var_7ee813dc4c2b115f.angles = level.var_4ed6509f8c903c94 ?? ( 0, 0, 0 );
            continue;
        }
        
        if ( msg == "primary_weapon_changed" )
        {
            sandbaglocation = int( arg );
            
            if ( level.bulletsinitialstate )
            {
                level.bulletsinitialstate = 0;
                continue;
            }
            
            if ( level.currentdropcount == 0 )
            {
            }
            
            level.currentdropcount++;
            
            if ( level.currentdropcount > 3 )
            {
                level.currentdropcount = 1;
            }
            
            continue;
        }
        
        if ( msg == "entered_firing_range_after_target_settings" && !level.var_234c2a7158e3582 )
        {
            numplates = int( arg );
            thread frontendfiringrange::function_2de3b0117ec0842c( numplates );
            end_current_xcam();
            thread frontendfiringrange::function_2e0a8c011b3d1851( 1 );
            continue;
        }
        
        if ( msg == "entered_firing_range_after_pause" && !level.var_234c2a7158e3582 )
        {
            end_current_xcam();
            thread frontendfiringrange::function_2e0a8c011b3d1851( arg );
            continue;
        }
        
        if ( msg == "switch_loadouts" && !level.var_234c2a7158e3582 )
        {
            end_current_xcam();
            
            if ( getomnvar( "ui_firing_range_has_started" ) && self.settospectate )
            {
                thread frontendfiringrange::function_2e0a8c011b3d1851( 0 );
            }
            
            thread frontendfiringrange::function_b4d2e3406027eec5();
            continue;
        }
        
        if ( msg == "restart_xcam_in_firing_range" && !level.var_234c2a7158e3582 )
        {
            thread frontendfiringrange::function_975c17bde7e82d6();
            set_xcam();
            continue;
        }
        
        if ( msg == "enter_frontend_walkable_space" && !level.var_234c2a7158e3582 )
        {
            thread frontendwalkablespace::function_867cd6025b5f3ea7( arg );
            continue;
        }
        
        if ( msg == "enter_frontend_walkable_space_paused" && !level.var_234c2a7158e3582 )
        {
            thread frontendwalkablespace::function_cc28f6ed811ee209( arg );
            continue;
        }
        
        if ( msg == "start_exfil_animation" )
        {
            thread frontendwalkablespace::playexfil( arg );
            continue;
        }
        
        if ( msg == "set_dmz_fob_scriptable_states" )
        {
            thread frontendwalkablespace::function_b14158045d06087d( arg );
            continue;
        }
        
        if ( msg == "pause_frontend_walkable_space" && !level.var_234c2a7158e3582 )
        {
            thread frontendwalkablespace::function_d86b6171373c7132();
            continue;
        }
        
        if ( msg == "pause_frontend_walkable_space_quick_access" && !level.var_234c2a7158e3582 )
        {
            thread frontendwalkablespace::function_d86b6171373c7132( 1 );
            continue;
        }
        
        if ( msg == "update_frontend_walkable_space_operator_model" && !level.var_234c2a7158e3582 )
        {
            thread frontendwalkablespace::function_56408659ca302e();
            continue;
        }
        
        if ( msg == "exit_frontend_walkable_space" && !level.var_234c2a7158e3582 )
        {
            thread frontendwalkablespace::function_b01ea89ac6576abd();
            continue;
        }
        
        if ( msg == "walkable_space_disconnect_player_camera" )
        {
            thread frontendwalkablespace::function_c15d418a735c721c( 1 );
            continue;
        }
        
        if ( msg == "walkable_space_connect_player_camera" )
        {
            thread frontendwalkablespace::function_c15d418a735c721c( 0 );
            continue;
        }
        
        if ( msg == "pre_match_making" )
        {
            thread frontendfiringrange::function_7eb21b04340b04d();
            println( "<dev string:x749>" );
            utility::flag_clear( "started_mm" );
            
            if ( !isdefined( level.active_scene_data ) )
            {
                level thread function_7e34ddd9ad834c78();
            }
            
            continue;
        }
        
        if ( msg == "match_making" )
        {
            println( "<dev string:x75e>" );
            level.mmpartysize = getpartyinfo().size;
            
            /#
                if ( getdvarint( @"hash_cbd831de958955e3" ) )
                {
                    level.mmpartysize = getdvarint( @"hash_6e71a0ce997a3f8a" );
                }
            #/
            
            level.currentflagmsg = "match_making";
            utility::flag_set( "started_mm" );
            continue;
        }
        
        if ( msg == "lobby_members_changed" )
        {
            if ( !level.overridenumplayers )
            {
                level.var_c111bc9d2e9166a9 = arg;
            }
            
            level.currentflagmsg = "lobby_member_increase";
            utility::flag_set( "lobby_member_increase" );
            continue;
        }
        
        if ( msg == "crib_op_intro_anim_rotated" )
        {
            if ( arg >> 3 )
            {
                if ( ( arg & 2 ) == 0 )
                {
                    level.client_characters[ 14 ].angles = ( 0, -153, 0 );
                }
                else
                {
                    level.client_characters[ 14 ].angles = ( 0, -126, 0 );
                }
            }
            else
            {
                level.client_characters[ 14 ].angles = ( 0, -139.143, 0 );
                level.var_ddbddc069152b02f = arg & 2;
                level.var_4f103db18dbbaee4 = arg & 1;
                level.var_e365d8f09a7f6f27 = ( arg & 2 ) >> 1;
            }
            
            continue;
        }
        
        if ( msg == "crib_op_intro_anim_forward" )
        {
            level.var_ddbddc069152b02f = arg & 2;
            level.var_4f103db18dbbaee4 = arg & 1;
            level.var_e365d8f09a7f6f27 = ( arg & 2 ) >> 1;
            continue;
        }
        
        if ( msg == "streak_select_trigger" )
        {
            if ( arg == 1 )
            {
                set_xcam_wrapper( "fe_op_crib_xcam_killstreak_01_in_xcam", 0, 0.05, level.xcam_anchor );
            }
            else
            {
                set_xcam_wrapper( "fe_op_crib_xcam_killstreak_01_out_xcam", 0, 0.05, level.xcam_anchor );
            }
            
            continue;
        }
        
        if ( msg == "operator_store_preview" )
        {
            if ( isdefined( level.var_6d9f8ea019296372 ) )
            {
                level.var_6d9f8ea019296372 setmodel( "bp_diorama_background_simple_s2_v0" );
                level.var_6d9f8ea019296372.origin = level.var_cfec6213d70ba3ae;
            }
            
            var_aed6800ca6eb0a6f = frontend_camera_get_entity( "shop_character_01" );
            
            if ( arg == "default_vision_set" || !isvisionsetloaded( arg ) )
            {
                visionset = "";
            }
            else
            {
                visionset = arg;
            }
            
            level.playerviewowner visionsetnakedforplayer( visionset, 0 );
            level.client_characters[ 0 ].angles = var_aed6800ca6eb0a6f.angles ?? ( 0, 0, 0 );
            level.client_characters[ 0 ].origin = var_aed6800ca6eb0a6f.origin ?? ( 0, 0, 0 );
            continue;
        }
        
        if ( msg == "update_operator_crib_vision" )
        {
            if ( arg == "default_vision_set" || !isvisionsetloaded( arg ) )
            {
                visionset = "";
            }
            else
            {
                visionset = arg;
            }
            
            level.playerviewowner visionsetnakedforplayer( visionset, 0 );
            continue;
        }
        
        if ( msg == "update_weapon_store_background" )
        {
            args = strtok( arg, "," );
            xoffset = int( args[ 0 ] );
            isprotuned = int( args[ 1 ] );
            isreactive = int( args[ 2 ] );
            var_cd68f937664ec541 = ( 4103.15, 3095.33, 2 );
            
            if ( isprotuned == 1 )
            {
                if ( !isdefined( level.protunevfx ) )
                {
                    level.protunevfx = spawnfx( utility::getfx( "vfx_frontend_weapon_protune_aura" ), var_cd68f937664ec541, ( 1, 0, 0 ), ( 0, -1, 0 ) );
                }
                else
                {
                    level.protunevfx delete();
                    level.protunevfx = spawnfx( utility::getfx( "vfx_frontend_weapon_protune_aura" ), var_cd68f937664ec541, ( 1, 0, 0 ), ( 0, -1, 0 ) );
                }
                
                triggerfx( level.protunevfx );
            }
            else if ( isdefined( level.protunevfx ) )
            {
                level.protunevfx delete();
            }
            
            if ( isreactive == 1 )
            {
            }
            
            level.var_7ee813dc4c2b115f setmodel( "" );
            level.var_7ee813dc4c2b115f.origin = level.var_8015fd9f3d7dea27;
            level.var_7ee813dc4c2b115f.angles = level.var_4ed6509f8c903c94 ?? ( 0, 0, 0 );
            continue;
        }
        
        if ( msg == "update_gunscreen_store_background" )
        {
            level.var_7ee813dc4c2b115f setmodel( "" );
            level.var_7ee813dc4c2b115f.origin = ( -3072, 3072, -50 );
            level.var_7ee813dc4c2b115f.angles = ( 0, 70, 0 );
            continue;
        }
        
        if ( msg == "remove_protuned_weapon_vfx" )
        {
            if ( isdefined( level.protunevfx ) )
            {
                level.protunevfx delete();
            }
            
            continue;
        }
        
        if ( msg == "swap_gun_foam" )
        {
            arg = int( arg );
            
            if ( !isdefined( arg ) )
            {
                return;
            }
            
            level.foamlarge = frontend_camera_get_entity( "foam_large" );
            level.foammedium = frontend_camera_get_entity( "foam_med" );
            level.foamsmall = frontend_camera_get_entity( "foam_small" );
            
            if ( arg == 3 )
            {
                level.foamlarge show();
                level.foammedium hide();
                level.foamsmall hide();
            }
            else if ( arg == 2 )
            {
                level.foamlarge hide();
                level.foammedium show();
                level.foamsmall hide();
            }
            else if ( arg == 1 )
            {
                level.foamlarge hide();
                level.foammedium hide();
                level.foamsmall show();
            }
            
            continue;
        }
        
        if ( msg == "camera_control_position_value" )
        {
            if ( !isdefined( arg ) )
            {
                level.camera_control_position_value = 1;
            }
            
            level.camera_control_position_value = float( arg );
            continue;
        }
        
        if ( msg == "camera_control_rotation_value" )
        {
            if ( !isdefined( arg ) )
            {
                level.camera_control_rotation_value = 1;
            }
            
            level.camera_control_rotation_value = float( arg );
            continue;
        }
        
        if ( msg == "camera_control_update" )
        {
            end_current_xcam();
            
            if ( !isdefined( arg ) )
            {
                return;
            }
            
            if ( !isdefined( level.currentcamera ) )
            {
                if ( !isdefined( level.active_camera ) )
                {
                    return;
                }
            }
            
            arg = int( arg );
            
            if ( !isdefined( level.var_a6ac8df48acba8aa ) || arg == 17 )
            {
                level.var_a6ac8df48acba8aa = ( 0, 0, 0 );
                level.currentcameraangles = ( 0, 0, 0 );
            }
            
            if ( !isdefined( level.camera_control_position_value ) )
            {
                level.camera_control_position_value = 1;
            }
            
            if ( !isdefined( level.camera_control_rotation_value ) )
            {
                level.camera_control_rotation_value = 1;
            }
            
            if ( arg == 1 )
            {
                level.var_a6ac8df48acba8aa += ( level.camera_control_position_value, 0, 0 );
            }
            else if ( arg == 2 )
            {
                level.var_a6ac8df48acba8aa += ( level.camera_control_position_value * -1, 0, 0 );
            }
            else if ( arg == 3 )
            {
                level.var_a6ac8df48acba8aa += ( 0, level.camera_control_position_value, 0 );
            }
            else if ( arg == 4 )
            {
                level.var_a6ac8df48acba8aa += ( 0, level.camera_control_position_value * -1, 0 );
            }
            else if ( arg == 5 )
            {
                level.var_a6ac8df48acba8aa += ( 0, 0, level.camera_control_position_value );
            }
            else if ( arg == 6 )
            {
                level.var_a6ac8df48acba8aa += ( 0, 0, level.camera_control_position_value * -1 );
            }
            else if ( arg == 15 )
            {
                level.var_a6ac8df48acba8aa = ( 0, 0, 0 );
            }
            else if ( arg == 7 )
            {
                level.currentcameraangles += ( level.camera_control_rotation_value, 0, 0 );
            }
            else if ( arg == 8 )
            {
                level.currentcameraangles += ( level.camera_control_rotation_value * -1, 0, 0 );
            }
            else if ( arg == 13 )
            {
                level.currentcameraangles += ( 0, level.camera_control_rotation_value, 0 );
            }
            else if ( arg == 14 )
            {
                level.currentcameraangles += ( 0, level.camera_control_rotation_value * -1, 0 );
            }
            else if ( arg == 16 )
            {
                level.currentcameraangles = ( 0, 0, 0 );
            }
            else if ( arg == 9 )
            {
                updatedfstop = level.active_camera.depthoffieldvalues[ 0 ] + 1;
                
                if ( updatedfstop <= 0 )
                {
                    updatedfstop = 0;
                }
                
                level.active_camera.depthoffieldvalues[ 0 ] = updatedfstop;
                update_camera_depth_of_field();
            }
            else if ( arg == 10 )
            {
                updatedfstop = level.active_camera.depthoffieldvalues[ 0 ] - 1;
                
                if ( updatedfstop <= 0 )
                {
                    updatedfstop = 0;
                }
                
                level.active_camera.depthoffieldvalues[ 0 ] = updatedfstop;
                update_camera_depth_of_field();
            }
            else if ( arg == 11 )
            {
                level.active_camera.depthoffieldvalues[ 1 ] += 1;
                update_camera_depth_of_field();
            }
            else if ( arg == 12 )
            {
                level.active_camera.depthoffieldvalues[ 1 ] -= 1;
                update_camera_depth_of_field();
            }
            
            movetoorigin = spawnstruct();
            camera = level.active_camera;
            
            if ( isdefined( level.currentcamera ) )
            {
                camera = level.currentcamera;
            }
            
            movetoorigin.origin = camera.origin + level.var_a6ac8df48acba8aa;
            movetoorigin.angles = camera.angles + level.currentcameraangles;
            camera_move_helper( movetoorigin, 0, 0, 0, 0, 0 );
            continue;
        }
        
        if ( msg == "pass_store_weapon_update" )
        {
            utility::flag_set( "force_weapon_update" );
            continue;
        }
        
        if ( level.var_3d353e3274a23c81 || level.var_88cd03d85d960fe0 )
        {
            continue;
        }
        
        tagarray = strtok( msg, "," );
        isloadout = tagarray.size > 7;
        var_9e4aaa1a68f7ce48 = tagarray[ 0 ] == "attach_zoom";
        isweaponpreview = tagarray[ 0 ] == "weapon_preview";
        
        if ( var_9e4aaa1a68f7ce48 || isweaponpreview )
        {
            tagstruct = function_27c7889021d20b28( tagarray, isweaponpreview, level.active_section.name );
        }
        else if ( isloadout )
        {
            tagstruct = function_4a31f3d861553676( tagarray );
        }
        else
        {
            tagstruct = function_7007bd7f0543df4a( tagarray, isweaponpreview, level.active_section.name );
        }
        
        if ( !isdefined( tagstruct ) )
        {
            continue;
        }
        
        if ( !isarray( tagstruct ) )
        {
            tagstruct = [ tagstruct ];
        }
        
        if ( isweaponpreview )
        {
            foreach ( index, struct in tagstruct )
            {
                if ( struct.name == "tag_cosmetic" )
                {
                    struct.angles = ( 10, 190, 30 );
                }
                
                if ( struct.name == "tag_sticker" || struct.name == "tag_sticker_shotgun" )
                {
                    struct.angles = ( 10, 190, 42 );
                }
                
                if ( function_e67750d82fc610b1( struct.class ) )
                {
                    struct.angles = ( 0, 180, 0 );
                }
                
                level.xcam_anchors[ struct.name ][ "transitions" ] = [];
                level.xcam_anchors[ struct.name ][ "transitions" ][ 0 ] = struct.xcam;
                level.xcam_anchors[ struct.name ][ "xcam_data" ] = spawnstruct();
                level.xcam_anchors[ struct.name ][ "xcam_data" ].origin = struct.origin;
                level.xcam_anchors[ struct.name ][ "xcam_data" ].angles = struct.angles;
                blendtime = getdvarfloat( @"hash_4773a268cb735013", 0.2 );
                
                if ( distancesquared( struct.origin, ( 25887, -5425, 73 ) ) < 10000 )
                {
                    level.xcam_anchor.origin = struct.origin;
                    level.xcam_anchor.angles = struct.angles;
                    set_xcam_wrapper( level.xcam_anchors[ struct.name ][ "transitions" ][ 0 ], 0, blendtime, level.xcam_anchor );
                }
            }
            
            continue;
        }
        
        if ( !var_9e4aaa1a68f7ce48 )
        {
            foreach ( index, struct in tagstruct )
            {
                if ( !isloadout )
                {
                    if ( struct.name == "tag_origin" )
                    {
                        struct.name = "j_gun";
                        struct.origin = level.active_camera.origin;
                    }
                    
                    level.xcam_anchors[ struct.name ][ "transitions" ] = [];
                    level.xcam_anchors[ struct.name ][ "transitions" ][ 0 ] = struct.xcam;
                    level.xcam_anchors[ struct.name ][ "xcam_data" ] = spawnstruct();
                    level.xcam_anchors[ struct.name ][ "xcam_data" ].origin = struct.origin;
                    level.xcam_anchors[ struct.name ][ "xcam_data" ].angles = struct.angles;
                    level.var_c4693a5cb9b2cebd = 1;
                    level.xcam_anchor.origin = struct.origin;
                    level.xcam_anchor.angles = struct.angles;
                    blendtime = getdvarfloat( @"hash_4773a268cb735013", 0.2 );
                    
                    if ( isdefined( struct.xcam ) )
                    {
                        println( "<dev string:x778>" + struct.xcam );
                    }
                    
                    set_xcam_wrapper( level.xcam_anchors[ struct.name ][ "transitions" ][ 0 ], 0, blendtime, level.xcam_anchor );
                    continue;
                }
                
                if ( isdefined( level.var_29d3d6d1ca17b761[ index ] ) && struct.xcam != level.var_29d3d6d1ca17b761[ index ] )
                {
                    level.xcam_anchors[ struct.name ][ "transitions" ][ 0 ] = struct.xcam;
                    level.xcam_anchors[ struct.name ][ "xcam_data" ].origin = struct.origin;
                    
                    if ( index == 1 )
                    {
                        level.xcam_anchors[ "loadout_showcase_o" ][ "transitions" ][ 0 ] = struct.xcam;
                        level.xcam_anchors[ "loadout_showcase_o" ][ "xcam_data" ].origin = struct.origin;
                    }
                    
                    continue;
                }
                
                if ( isdefined( struct.origin ) && struct.origin != level.xcam_anchors[ struct.name ][ "xcam_data" ].origin )
                {
                    level.xcam_anchors[ struct.name ][ "xcam_data" ].origin = struct.origin;
                    
                    if ( index == 1 )
                    {
                        level.xcam_anchors[ "loadout_showcase_o" ][ "xcam_data" ].origin = struct.origin;
                    }
                }
            }
            
            if ( isloadout )
            {
                level.var_29d3d6d1ca17b761[ 0 ] = tagstruct[ 0 ].xcam;
                level.var_29d3d6d1ca17b761[ 1 ] = tagstruct[ 1 ].xcam;
            }
            
            continue;
        }
        
        attach_zoom_type = function_dd44ecf00812addc( tagarray );
        
        if ( attach_zoom_type != "receiver" )
        {
            continue;
        }
        
        if ( level.var_b039ebcdd7535c8a )
        {
            utility::flag_set( "zoom_triggered" );
            level.attach_zoom_type = attach_zoom_type;
            continue;
        }
        
        foreach ( struct in tagstruct )
        {
            level.xcam_anchors[ "loadout_showcase_preview" ][ "xcam_data" ].origin = struct.origin;
            level.xcam_anchors[ "loadout_showcase_preview" ][ "xcam_data" ].angles = struct.angles;
            level.xcam_anchors[ "loadout_showcase_preview_small" ][ "xcam_data" ].origin = struct.origin;
            level.xcam_anchors[ "loadout_showcase_preview_small" ][ "xcam_data" ].angles = struct.angles;
            level.xcam_anchors[ "loadout_showcase_preview_large" ][ "xcam_data" ].origin = struct.origin;
            level.xcam_anchors[ "loadout_showcase_preview_large" ][ "xcam_data" ].angles = struct.angles;
            level.var_b039ebcdd7535c8a = 1;
            utility::flag_set( "force_weapon_update" );
        }
        
        level.attach_zoom_type = attach_zoom_type;
        utility::flag_set( "zoom_triggered" );
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x51af06a1, Offset: 0xdf8e
// Size: 0x1e, Type: bool
function private function_270ae4327a1f5bbd( scenename )
{
    if ( !isdefined( scenename ) )
    {
        return false;
    }
    
    return isdefined( function_8e87b77f70835fd4( scenename ) );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x6e000dcb, Offset: 0xdfb5
// Size: 0x1d
function private function_7e34ddd9ad834c78()
{
    level waittill( #"finished_scene_change" );
    level.currentflagmsg = "pre_match_making";
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0x84a393db, Offset: 0xdfda
// Size: 0x20
function private function_dc431df3348b6bf2( scenename )
{
    if ( !isdefined( scenename ) )
    {
        return 0;
    }
    
    return issubstr( scenename, "weapon_preview" );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xef89988b, Offset: 0xe003
// Size: 0xa9
function private function_adcb617248dab87e()
{
    level.gunsmithblendtime = 0;
    
    foreach ( tag in level.gunsmithtags )
    {
        if ( isdefined( level.xcam_anchors ) && isdefined( level.xcam_anchors[ tag ] ) )
        {
            level.xcam_anchors[ tag ] = undefined;
        }
    }
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x5c47706e, Offset: 0xe0b4
// Size: 0xb6
function private loadandplayholoeffect()
{
    if ( !isdefined( level.holoeffect ) )
    {
        level.holoeffect = loadfxasset( "vfx_iw8_mp_watches_holo_watch" );
        wait 1;
    }
    
    level.watchfx = spawnfx( level.holoeffect, level.weapons[ 3 ].origin );
    level.watchfx.angles = ( 221, -34.753, 181.997 );
    level.watchfx.origin += ( 1, -0.66, 0.98 );
    waitframe();
    triggerfx( level.watchfx );
}

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0xb0bf60b5, Offset: 0xe172
// Size: 0x55
function private updaterotatedebug()
{
    while ( true )
    {
        if ( getdvarint( @"hash_97e86d4661a38d", -1 ) != -1 )
        {
            val = getdvarint( @"hash_97e86d4661a38d" );
            moveeffect( val );
            
            /#
                setdevdvar( @"hash_97e86d4661a38d", -1 );
            #/
        }
        
        waitframe();
    }
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xb4913bd8, Offset: 0xe1cf
// Size: 0x11d
function private moveeffect( val )
{
    watchx = 0;
    watchy = 0;
    watchz = 0;
    
    if ( val == 1 )
    {
        watchx = 0.1;
    }
    
    if ( val == 2 )
    {
        watchx = -0.1;
    }
    
    if ( val == 3 )
    {
        watchy = 0.1;
    }
    
    if ( val == 4 )
    {
        watchy = -0.1;
    }
    
    if ( val == 5 )
    {
        watchz = 0.1;
    }
    
    if ( val == 6 )
    {
        watchz = -0.1;
    }
    
    angle = level.watchfx.angles;
    newpos = level.watchfx.origin + ( watchx, watchy, watchz );
    level.watchfx delete();
    level.watchfx = spawnfx( level.holoeffect, newpos );
    level.watchfx.angles = angle;
    triggerfx( level.watchfx );
    println( newpos );
}

// Namespace frontendutils
// Params 1, eflags: 0x4
// Checksum 0xda9bc381, Offset: 0xe2f4
// Size: 0x121
function private rotateeffect( val )
{
    watchx = 0;
    watchy = 0;
    watchz = 0;
    
    if ( val == 1 )
    {
        watchx = 10;
    }
    
    if ( val == 2 )
    {
        watchx = -10;
    }
    
    if ( val == 3 )
    {
        watchy = 10;
    }
    
    if ( val == 4 )
    {
        watchy = -10;
    }
    
    if ( val == 5 )
    {
        watchz = 10;
    }
    
    if ( val == 6 )
    {
        watchz = -10;
    }
    
    newangles = level.watchfx.angles + ( watchx, watchy, watchz );
    level.watchfx delete();
    level.watchfx = spawnfx( level.holoeffect, level.weapons[ 3 ].origin + ( 1, -0.66, 1.1 ) );
    level.watchfx.angles = newangles;
    triggerfx( level.watchfx );
    println( level.watchfx.angles );
}

/#

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0xf8105a90, Offset: 0xe41d
    // Size: 0xd5, Type: dev
    function private function_f6794b7a210ff9ff()
    {
        setdevdvar( @"hash_902a293944d16b28", 0 );
        setdevdvar( @"hash_47ad1705c52e610", "<dev string:x24>" );
        setdevdvar( @"hash_e4612a44320c55af", 0 );
        setdevdvar( @"hash_a2635942d6da077f", 0 );
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_e4612a44320c55af" ) == 1 )
            {
                thread function_507bb4debee300fc();
            }
            else if ( getdvarint( @"hash_902a293944d16b28" ) == 1 )
            {
                thread function_8de3d4a8ea9f37bd();
            }
            else if ( getdvar( @"hash_47ad1705c52e610", "<dev string:x24>" ) != "<dev string:x24>" )
            {
                thread function_e122c3a901c31fa7();
            }
            else if ( getdvarint( @"hash_a2635942d6da077f" ) == 1 )
            {
                thread function_1c62b0ae507c19ae();
            }
            
            wait ( level.weaponmapdata.size + 1 ) * 0.01;
        }
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0x391fbdeb, Offset: 0xe4fa
    // Size: 0x24, Type: dev
    function private function_8de3d4a8ea9f37bd()
    {
        adddebugcommand( "<dev string:x793>" + "<dev string:x79c>" );
        setdevdvar( @"hash_902a293944d16b28", 0 );
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0xdadb28f0, Offset: 0xe526
    // Size: 0xcd, Type: dev
    function private function_e122c3a901c31fa7()
    {
        var_ad3182a403eb283 = getdvar( @"hash_47ad1705c52e610" );
        
        foreach ( weaponref in level.weaponmapdata )
        {
            if ( weaponref.assetname == var_ad3182a403eb283 )
            {
                adddebugcommand( "<dev string:x7a2>" + "<dev string:x7b0>" + weaponref.weaponlootid );
            }
            
            waitframe();
        }
        
        setdevdvar( @"hash_47ad1705c52e610", "<dev string:x24>" );
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0x98bdc645, Offset: 0xe5fb
    // Size: 0xa1, Type: dev
    function private function_507bb4debee300fc()
    {
        foreach ( weaponref in level.weaponmapdata )
        {
            adddebugcommand( "<dev string:x7a2>" + "<dev string:x7b0>" + weaponref.weaponlootid );
            waitframe();
        }
        
        setdevdvar( @"hash_e4612a44320c55af", 0 );
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0x90fa3a7e, Offset: 0xe6a4
    // Size: 0x24, Type: dev
    function private function_1c62b0ae507c19ae()
    {
        adddebugcommand( "<dev string:x7ba>" + "<dev string:x7c8>" );
        setdevdvar( @"hash_a2635942d6da077f", 0 );
    }

    // Namespace frontendutils
    // Params 0, eflags: 0x4
    // Checksum 0xd9e52692, Offset: 0xe6d0
    // Size: 0x11a, Type: dev
    function private function_850dd9a21b448b1()
    {
        while ( true )
        {
            var_c523b7e898f1d9a5 = getdvarint( @"hash_c64c3bd538ca07a7", 0 );
            
            if ( var_c523b7e898f1d9a5 > 0 )
            {
                setdevdvar( @"hash_c64c3bd538ca07a7", 0 );
                level.var_c111bc9d2e9166a9 = var_c523b7e898f1d9a5;
                level.overridenumplayers = 1;
                level.currentflagmsg = "<dev string:x7d1>";
                utility::flag_set( "<dev string:x7d1>" );
            }
            
            startmm = getdvarint( @"hash_14743422cbaa5593", 0 );
            
            if ( startmm )
            {
                setdevdvar( @"hash_14743422cbaa5593", 0 );
                
                if ( !isdefined( level.var_c111bc9d2e9166a9 ) )
                {
                    level.mmpartysize = 1;
                }
                else
                {
                    level.mmpartysize = level.var_c111bc9d2e9166a9;
                }
                
                level.currentflagmsg = "<dev string:x7e7>";
                utility::flag_set( "<dev string:x7f4>" );
            }
            
            endxcam = getdvarint( @"hash_51ac823f87aca451", 0 );
            
            if ( endxcam )
            {
                setdevdvar( @"hash_51ac823f87aca451", 0 );
                end_current_xcam();
            }
            
            wait 1;
        }
    }

#/

// Namespace frontendutils
// Params 0, eflags: 0x4
// Checksum 0x53039c60, Offset: 0xe7f2
// Size: 0x14
function private function_78b5463da8c6f09a()
{
    wait 0.5;
    
    while ( !function_4fd9270e784e8871() )
    {
        waitframe();
    }
}

