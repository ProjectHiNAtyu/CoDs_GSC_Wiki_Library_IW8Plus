// script_6ced65faef83c9ce  (hash_6ced65faef83c9ce.gscc) (size: 10480 Bytes / 0x28f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4c75cd27 (1282788647)
// size ...... 10480 (0x28f0)
// includes .. 5   (offset: 0x27d0)
// strings ... 11  (offset: 0x27f8)
// dev strs .. 6   (offset: 0x2888)
// exports ... 31  (offset: 0x18b0)
// cseg ...... 0xdf + 0x17d1 (0x18b0)
// imports ... 86  (offset: 0x1d88)
// animtree1 . 0   (offset: 0x28f0)
// animtree2 . 0   (offset: 0x28f0)
#using scripts\common\notetrack;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\gamelogic;

#namespace namespace_f45354f07ac64b56;

// Namespace namespace_f45354f07ac64b56
// Params 1
// Checksum 0xe36996fd, Offset: 0xfd
// Size: 0x46
function _button_pressed( buttonstring )
{
    if ( getsubstr( buttonstring, 0, 5 ) == "DPAD_" )
    {
        var_99e6d880c44dce93 = getdvarint( @"hash_34ba00d2d9fa0c16", 0 );
        
        if ( var_99e6d880c44dce93 )
        {
            return 0;
        }
    }
    
    return self buttonpressed( buttonstring );
}

// Namespace namespace_f45354f07ac64b56
// Params 1
// Checksum 0x3ca18c05, Offset: 0x14c
// Size: 0x53
function create_animpack( anime )
{
    pack = spawnstruct();
    pack.ents = [];
    pack.staticents = [];
    pack.anime = anime;
    pack.packs = [];
    return pack;
}

// Namespace namespace_f45354f07ac64b56
// Params 1
// Checksum 0xac3164ef, Offset: 0x1a8
// Size: 0x17
function set_pack_fov( fov )
{
    self.fov = fov;
}

// Namespace namespace_f45354f07ac64b56
// Params 5
// Checksum 0xc3cc37ef, Offset: 0x1c7
// Size: 0x67
function function_619acbbcf154f2df( fstop, focusdist, focusspeed, aperturespeed, focalpoint )
{
    self.fstop = fstop;
    self.focusdist = focusdist;
    self.focusspeed = focusspeed;
    self.aperturespeed = aperturespeed;
    self.focalpoint = focalpoint;
}

// Namespace namespace_f45354f07ac64b56
// Params 2
// Checksum 0x9ca22c60, Offset: 0x236
// Size: 0x4e
function add_pack_modelanim( ent, animation )
{
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.ents[ self.ents.size ] = ent;
}

// Namespace namespace_f45354f07ac64b56
// Params 1
// Checksum 0xf6382bbd, Offset: 0x28c
// Size: 0x23
function function_88f4d49c8d510297( ent )
{
    self.staticents[ self.staticents.size ] = ent;
}

// Namespace namespace_f45354f07ac64b56
// Params 2
// Checksum 0x77f4b910, Offset: 0x2b7
// Size: 0x2b
function add_pack_startfunc( paramarray, func )
{
    self.startfunc = func;
    self.paramarray = paramarray;
}

// Namespace namespace_f45354f07ac64b56
// Params 2
// Checksum 0x2549641, Offset: 0x2ea
// Size: 0x2b
function function_97184132912f1dc3( paramarray, func )
{
    self.endfunc = func;
    self.var_3d181e279a220c81 = paramarray;
}

// Namespace namespace_f45354f07ac64b56
// Params 3
// Checksum 0xfc1b884f, Offset: 0x31d
// Size: 0x3f
function add_pack_fx( fxid, origin, angles )
{
    self.fx = fxid;
    self.fxorigin = origin;
    self.fxangles = angles;
}

// Namespace namespace_f45354f07ac64b56
// Params 4
// Checksum 0x98249d06, Offset: 0x364
// Size: 0xea
function function_4e87e96bc5852dc0( ent, tag, animation, xcamasset )
{
    assert( !isdefined( self.camerainfo ) );
    self.camerainfo = spawnstruct();
    self.camerainfo.ent = ent;
    self.camerainfo.tag = tag;
    
    if ( isdefined( xcamasset ) )
    {
        self.camerainfo.xcamasset = xcamasset;
        xcamlength = getxcamlength( xcamasset );
        xcamlength -= 0.033;
        xcamlength -= xcamlength % 0.05;
        self.camerainfo.xcamlength = xcamlength;
        return;
    }
    
    self.camerainfo.animlength = getanimlength( animation );
}

// Namespace namespace_f45354f07ac64b56
// Params 1, eflags: 0x4
// Checksum 0x8de6323f, Offset: 0x456
// Size: 0x67
function private function_dcac11cdf400ec1b( player )
{
    assert( isdefined( self.camerainfo ) );
    cameraent = self.camerainfo.ent;
    cameratag = self.camerainfo.tag;
    return [ cameraent, cameratag ];
}

// Namespace namespace_f45354f07ac64b56
// Params 0, eflags: 0x4
// Checksum 0x96155221, Offset: 0x4c6
// Size: 0x28, Type: bool
function private uses_xcam()
{
    assert( isdefined( self.camerainfo ) );
    return isdefined( self.camerainfo.xcamasset );
}

// Namespace namespace_f45354f07ac64b56
// Params 3, eflags: 0x4
// Checksum 0x1d1f4aed, Offset: 0x4f7
// Size: 0xac
function private function_46fc105ef7e82157( animstruct, player, var_f72cc7d49b1f3e1e )
{
    [ cameraent, cameratag ] = function_dcac11cdf400ec1b( player );
    
    if ( uses_xcam() )
    {
        if ( !var_f72cc7d49b1f3e1e )
        {
            player cameraunlink();
            player playxcam( self.camerainfo.xcamasset, 0, animstruct.structorigin, animstruct.structangles );
        }
        
        return;
    }
    
    player stopxcam();
    player cameralinkto( cameraent, cameratag, 1, 1 );
}

// Namespace namespace_f45354f07ac64b56
// Params 1, eflags: 0x4
// Checksum 0xcdda435e, Offset: 0x5ab
// Size: 0x6b
function private get_camera_origin_angles( player )
{
    [ cameraent, cameratag ] = function_dcac11cdf400ec1b( player );
    cameraorigin = cameraent gettagorigin( cameratag );
    cameraangles = cameraent gettagangles( cameratag );
    return [ cameraorigin, cameraangles ];
}

// Namespace namespace_f45354f07ac64b56
// Params 0, eflags: 0x4
// Checksum 0x287d08dd, Offset: 0x61f
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

// Namespace namespace_f45354f07ac64b56
// Params 3
// Checksum 0xcde0a880, Offset: 0x66f
// Size: 0x13e
function spawn_script_model( modelname, animname, extramodels )
{
    model = spawn( "script_model", self.structorigin );
    model setmodel( modelname );
    
    if ( !isdefined( animname ) )
    {
        animname = modelname;
    }
    
    model.animname = animname;
    
    if ( isdefined( extramodels ) )
    {
        model.linkedents = [];
        
        foreach ( modeltag in extramodels )
        {
            extra = spawn( "script_model", self.structorigin );
            extra setmodel( modeltag[ 0 ] );
            extra linkto( model, modeltag[ 1 ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
            model.linkedents[ model.linkedents.size ] = extra;
        }
    }
    
    return model;
}

// Namespace namespace_f45354f07ac64b56
// Params 5
// Checksum 0x6a1893fe, Offset: 0x7b6
// Size: 0x11f
function allplayers_setphysicaldof( fstop, focusdist, focusspeed = 100, aperturespeed = 100, focalpoint )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.scriptedphysicaldofenabled ) )
        {
            player.scriptedphysicaldofenabled = 1;
            player enablephysicaldepthoffieldscripting();
        }
        
        if ( isdefined( focalpoint ) )
        {
            player setphysicaldepthoffield( fstop, focusdist, focusspeed, aperturespeed, focalpoint );
            continue;
        }
        
        if ( isdefined( aperturespeed ) )
        {
            player setphysicaldepthoffield( fstop, focusdist, focusspeed, aperturespeed );
            continue;
        }
        
        if ( isdefined( focusspeed ) )
        {
            player setphysicaldepthoffield( fstop, focusdist, focusspeed );
            continue;
        }
        
        player setphysicaldepthoffield( fstop, focusdist );
    }
}

// Namespace namespace_f45354f07ac64b56
// Params 1
// Checksum 0xa96794f, Offset: 0x8dd
// Size: 0xa0
function allplayers_setfov( fov )
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"cg_fov", fov );
        player setclientdvar( @"cg_disable_user_fov", 1 );
    }
}

// Namespace namespace_f45354f07ac64b56
// Params 0
// Checksum 0xbe575f9d, Offset: 0x985
// Size: 0x95
function function_4b282a3b31aae42a()
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"cg_fov", 65 );
        player setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace namespace_f45354f07ac64b56
// Params 0
// Checksum 0x91a88031, Offset: 0xa22
// Size: 0x93
function allplayers_clearphysicaldof()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.scriptedphysicaldofenabled ) )
        {
            player.scriptedphysicaldofenabled = undefined;
            player disablephysicaldepthoffieldscripting();
        }
    }
}

/#

    // Namespace namespace_f45354f07ac64b56
    // Params 1
    // Checksum 0xa0efe429, Offset: 0xabd
    // Size: 0x45, Type: dev
    function runanimatic( buildfunc )
    {
        wait 1;
        
        while ( true )
        {
            host = gamelogic_mp::gethostplayer();
            
            if ( isdefined( host ) )
            {
                animaticrunner( host, buildfunc );
            }
            
            wait 0.25;
        }
    }

#/

// Namespace namespace_f45354f07ac64b56
// Params 1
// Checksum 0xe855f6a, Offset: 0xb0a
// Size: 0x42
function function_541e634b846ac191( scenename )
{
    wait 1;
    
    while ( true )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            function_4414b8e2e0d7d710( host, scenename );
        }
        
        wait 0.25;
    }
}

// Namespace namespace_f45354f07ac64b56
// Params 2
// Checksum 0x25a870bf, Offset: 0xb54
// Size: 0x19d
function function_4414b8e2e0d7d710( player, scenename )
{
    srcstruct = utility::getstruct( "bink_scene", "targetname" );
    
    if ( !isdefined( srcstruct ) )
    {
        srcstruct = utility::getstruct( "bink_origin", "script_noteworthy" );
        
        if ( !isdefined( srcstruct ) )
        {
            srcstruct = spawnstruct();
            srcstruct.origin = player.origin;
            srcstruct.angles = player.angles;
        }
    }
    
    if ( !isdefined( srcstruct.angles ) )
    {
        srcstruct.angles = ( 0, 0, 0 );
    }
    
    while ( true )
    {
        function_279bb000a13d6ee6( player, "DPAD_RIGHT", "J" );
        startorigin = player.origin;
        startangles = player getplayerangles();
        setdvar( @"cg_drawgun", "0" );
        setdvar( @"cg_draw2d", "0" );
        srcstruct scene::set_scriptbundle( scenename );
        
        if ( isdefined( level.var_92a798344e6121f6 ) )
        {
            scene::add_scene_func( srcstruct, level.var_92a798344e6121f6, "callback_play" );
        }
        
        srcstruct scene::play( undefined, undefined, scenename );
        player setorigin( startorigin );
        player setplayerangles( startangles );
        setdvar( @"cg_drawgun", "1" );
        setdvar( @"cg_draw2d", "1" );
        wait 0.5;
        srcstruct scene::stop();
        srcstruct scene::cleanup( 1 );
    }
}

/#

    // Namespace namespace_f45354f07ac64b56
    // Params 2
    // Checksum 0xc99548df, Offset: 0xcf9
    // Size: 0x1bb, Type: dev
    function animaticrunner( player, buildfunc )
    {
        assert( isdefined( buildfunc ) );
        animstruct = spawnstruct();
        animstruct [[ buildfunc ]]();
        
        foreach ( pack in animstruct.packs )
        {
            foreach ( ent in pack.ents )
            {
                ent hide();
            }
        }
        
        while ( true )
        {
            function_279bb000a13d6ee6( player, "<dev string:x24>", "<dev string:x2f>" );
            startorigin = player.origin;
            startangles = player getplayerangles();
            level.var_e9752d5557df31ee = 0;
            thread function_b10a01a9100e6e09( player, animstruct );
            thread pauseanims( player, animstruct );
            thread function_e1fea13d32d736ec( player, animstruct );
            function_279bb000a13d6ee6( player, "<dev string:x31>", "<dev string:x3b>" );
            endanimsequence( player, animstruct );
            player setorigin( startorigin );
            player setplayerangles( startangles );
            wait 0.5;
        }
    }

#/

// Namespace namespace_f45354f07ac64b56
// Params 3
// Checksum 0x9ad9d33e, Offset: 0xebc
// Size: 0x5a
function function_279bb000a13d6ee6( player, buttonstring, keystring )
{
    while ( player _button_pressed( buttonstring ) || player _button_pressed( keystring ) )
    {
        waitframe();
    }
    
    while ( !player _button_pressed( buttonstring ) && !player _button_pressed( keystring ) )
    {
        waitframe();
    }
}

/#

    // Namespace namespace_f45354f07ac64b56
    // Params 2
    // Checksum 0x5f578629, Offset: 0xf1e
    // Size: 0x1ea, Type: dev
    function pauseanims( player, animstruct )
    {
        animstruct endon( #"stopscene" );
        
        while ( true )
        {
            level.var_e9752d5557df31ee = 0;
            
            while ( player _button_pressed( "<dev string:x24>" ) )
            {
                waitframe();
            }
            
            while ( !player _button_pressed( "<dev string:x24>" ) )
            {
                waitframe();
            }
            
            if ( isdefined( animstruct.activepack ) )
            {
                foreach ( ent in animstruct.activepack.ents )
                {
                    ent scriptmodelpauseanim( 1 );
                }
                
                if ( animstruct.activepack uses_xcam() )
                {
                    player pausexcam( 1 );
                }
            }
            
            level.var_e9752d5557df31ee = 1;
            
            while ( player _button_pressed( "<dev string:x24>" ) )
            {
                waitframe();
            }
            
            while ( !player _button_pressed( "<dev string:x24>" ) )
            {
                waitframe();
            }
            
            if ( isdefined( animstruct.activepack ) )
            {
                foreach ( ent in animstruct.activepack.ents )
                {
                    ent scriptmodelpauseanim( 0 );
                }
                
                if ( animstruct.activepack uses_xcam() )
                {
                    player pausexcam( 0 );
                }
            }
        }
    }

    // Namespace namespace_f45354f07ac64b56
    // Params 2
    // Checksum 0xe84b9458, Offset: 0x1110
    // Size: 0x1a4, Type: dev
    function function_e1fea13d32d736ec( player, animstruct )
    {
        animstruct endon( #"stopscene" );
        
        while ( true )
        {
            while ( !player _button_pressed( "<dev string:x3d>" ) )
            {
                waitframe();
            }
            
            player playershow();
            player player_utility::function_4688d689820ff1ed( "<dev string:x45>" );
            player cameraunlink();
            player disablephysicaldepthoffieldscripting();
            
            if ( isdefined( animstruct.activepack ) )
            {
                [ cameraorigin, cameraangles ] = animstruct.activepack get_camera_origin_angles( player );
                newplayerorg = cameraorigin + ( 0, 0, -60 );
                var_4273bc90e0c23d57 = cameraangles;
                player setorigin( newplayerorg );
                player setplayerangles( var_4273bc90e0c23d57 );
            }
            
            if ( !player isufo() )
            {
                player ufo();
            }
            
            setdvar( @"hash_f94addedc8e87b69", 2 );
            
            while ( player _button_pressed( "<dev string:x3d>" ) )
            {
                waitframe();
            }
            
            while ( !player _button_pressed( "<dev string:x3d>" ) )
            {
                waitframe();
            }
            
            if ( player isufo() )
            {
                player ufo();
            }
            
            setdvar( @"hash_f94addedc8e87b69", 0 );
            
            if ( isdefined( animstruct.activepack ) )
            {
                animstruct.activepack function_46fc105ef7e82157( animstruct, player, 1 );
            }
            
            player playerhide();
            player player_utility::function_9d378d725bb4831e( "<dev string:x45>" );
            player enablephysicaldepthoffieldscripting();
            
            while ( player _button_pressed( "<dev string:x3d>" ) )
            {
                waitframe();
            }
        }
    }

    // Namespace namespace_f45354f07ac64b56
    // Params 1
    // Checksum 0x1fe8672a, Offset: 0x12bc
    // Size: 0x38, Type: dev
    function waitandpause( timesec )
    {
        while ( timesec > 0 )
        {
            waitframe();
            
            while ( level.var_e9752d5557df31ee )
            {
                waitframe();
            }
            
            timesec -= level.framedurationseconds;
        }
    }

    // Namespace namespace_f45354f07ac64b56
    // Params 2
    // Checksum 0xa9bf57bb, Offset: 0x12fc
    // Size: 0x3b5, Type: dev
    function function_b10a01a9100e6e09( player, animstruct )
    {
        animstruct endon( #"stopscene" );
        
        foreach ( pack in animstruct.packs )
        {
            animstruct.activepack = pack;
            
            if ( isdefined( pack.startfunc ) )
            {
                animstruct [[ pack.startfunc ]]( pack.paramarray );
            }
            
            if ( isdefined( pack.fov ) )
            {
                allplayers_setfov( pack.fov );
            }
            else
            {
                function_4b282a3b31aae42a();
            }
            
            if ( isdefined( pack.fstop ) && isdefined( pack.focusdist ) )
            {
                allplayers_setphysicaldof( pack.fstop, pack.focusdist, pack.focusspeed, pack.aperturespeed, pack.focalpoint );
            }
            
            if ( isdefined( pack.fx ) )
            {
                playfx( utility::getfx( pack.fx ), pack.fxorigin, anglestoforward( pack.fxangles ), anglestoup( pack.fxangles ) );
            }
            
            foreach ( ent in pack.ents )
            {
                ent show();
                ent dontinterpolate();
                ent scriptmodelplayanimdeltamotionfrompos( level.scr_anim[ ent.animname ][ pack.anime ], animstruct.structorigin, animstruct.structangles, ent.animname );
                ent thread notetrack::start_notetrack_wait( ent, ent.animname, pack.anime, ent.animname, level.scr_anim[ ent.animname ][ pack.anime ] );
            }
            
            foreach ( ent in pack.staticents )
            {
                ent show();
            }
            
            if ( isdefined( player ) )
            {
                if ( isdefined( pack.playerfunc ) )
                {
                    [[ pack.playerfunc ]]( player, pack.var_6d8067a88da0e813 );
                }
                
                player cameraunlink();
                player stopxcam();
                pack function_46fc105ef7e82157( animstruct, player );
            }
            
            animlength = pack get_pack_anim_length();
            waitandpause( animlength );
            waitframe();
            
            if ( isdefined( pack.endfunc ) )
            {
                animstruct [[ pack.endfunc ]]( pack.var_3d181e279a220c81 );
            }
        }
    }

    // Namespace namespace_f45354f07ac64b56
    // Params 2
    // Checksum 0x5df5440b, Offset: 0x16b9
    // Size: 0x1f7, Type: dev
    function endanimsequence( player, animstruct )
    {
        animstruct notify( #"stopscene" );
        
        if ( isdefined( animstruct.activepack ) && isdefined( animstruct.activepack.endfunc ) )
        {
            animstruct [[ animstruct.activepack.endfunc ]]( animstruct.activepack.var_3d181e279a220c81 );
        }
        
        foreach ( pack in animstruct.packs )
        {
            foreach ( ent in pack.ents )
            {
                ent scriptmodelclearanim();
                ent hide();
            }
            
            foreach ( ent in pack.staticents )
            {
                ent hide();
            }
        }
        
        player cameraunlink();
        player stopxcam();
        function_4b282a3b31aae42a();
        allplayers_clearphysicaldof();
    }

#/
