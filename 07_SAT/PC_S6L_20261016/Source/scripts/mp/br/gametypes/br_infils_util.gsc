// scripts\mp\br\gametypes\br_infils_util.gsc  (hash_583ac8bf721412aa.gscc) (size: 20257 Bytes / 0x4f21 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ba6865a (1806075482)
// size ...... 20257 (0x4f21)
// includes .. 11  (offset: 0x4c31)
// strings ... 46  (offset: 0x4c89)
// dev strs .. 4   (offset: 0x4ef1)
// exports ... 62  (offset: 0x3655)
// cseg ...... 0x360 + 0x32f5 (0x3655)
// imports ... 90  (offset: 0x4005)
// animtree1 . 0   (offset: 0x4f21)
// animtree2 . 0   (offset: 0x4f21)
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\operator;
#using scripts\mp\parachute;

#namespace br_infils_util;

// Namespace br_infils_util
// Params 3
// Checksum 0x38a3d818, Offset: 0x37e
// Size: 0x150
function spawn_script_model( modelname, animname, extramodels )
{
    model = spawn( "script_model", self.origin );
    model setmodel( modelname );
    model forcenetfieldhighlod( 1 );
    
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
            extra = spawn( "script_model", self.origin );
            extra setmodel( modeltag[ 0 ] );
            extra forcenetfieldhighlod( 1 );
            extra linkto( model, modeltag[ 1 ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
            model.linkedents[ model.linkedents.size ] = extra;
        }
    }
    
    return model;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xe55e57ad, Offset: 0x4d7
// Size: 0x61
function function_1c0500c7cf8f9b7( scenename )
{
    origin_name = "infil_" + scenename + "_light_origin";
    orgstruct = utility::getstruct( origin_name, "targetname" );
    
    if ( !isdefined( level.lighting_rigs ) )
    {
        level.lighting_rigs = [];
    }
    
    level.lighting_rigs[ origin_name ] = orgstruct;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xf6e4d0a5, Offset: 0x540
// Size: 0x41
function function_f172bb5e472be336( scenename )
{
    if ( !isdefined( level.lighting_rigs ) )
    {
        return;
    }
    
    origin_name = "infil_" + scenename + "_light_origin";
    return level.lighting_rigs[ origin_name ];
}

// Namespace br_infils_util
// Params 2
// Checksum 0xde425404, Offset: 0x58a
// Size: 0x3dd
function function_88dc0218d2006993( scenename, linkent )
{
    rig = spawnstruct();
    probe_name = "infil_" + scenename + "_probe";
    light_name = "infil_" + scenename + "_light";
    probes = getentarray( probe_name, #script_noteworthy );
    lights = getentarray( light_name, #targetname );
    orgstruct = function_f172bb5e472be336( scenename );
    
    if ( !isdefined( probes ) )
    {
        return;
    }
    
    foreach ( probe in probes )
    {
        if ( !isdefined( probe ) )
        {
            return;
        }
    }
    
    if ( !isdefined( lights ) )
    {
        return;
    }
    
    foreach ( light in lights )
    {
        if ( !isdefined( light ) )
        {
            return;
        }
    }
    
    if ( !isdefined( orgstruct ) )
    {
        return;
    }
    
    orgorigin = orgstruct.origin;
    organgles = orgstruct.angles;
    
    if ( !isdefined( organgles ) )
    {
        organgles = ( 0, 0, 0 );
    }
    
    foreach ( probe in probes )
    {
        probe forcenetfieldhighlod( 1 );
        
        if ( !isdefined( probe.origin_offset ) && !isdefined( probe.angles_offset ) )
        {
            probeorigin = probe.origin;
            probeangles = probe.angles;
            
            if ( !isdefined( probeangles ) )
            {
                probeangles = ( 0, 0, 0 );
            }
            
            probe.origin_offset = probeorigin - orgorigin;
            probe.angles_offset = probeangles - organgles;
        }
    }
    
    foreach ( light in lights )
    {
        light forcenetfieldhighlod( 1 );
        
        if ( !isdefined( light.origin_offset ) && !isdefined( light.angles_offset ) )
        {
            lightorigin = light.origin;
            lightangles = light.angles;
            
            if ( !isdefined( light.angles ) )
            {
                lightangles = ( 0, 0, 0 );
            }
            
            light.origin_offset = lightorigin - orgorigin;
            light.angles_offset = lightangles - organgles;
        }
    }
    
    rig.probes = probes;
    rig.lights = lights;
    rig.linkent = linkent;
    function_8b1bb889b21089( rig, 1 );
    return rig;
}

// Namespace br_infils_util
// Params 2
// Checksum 0x8d7d7c4e, Offset: 0x970
// Size: 0x1a5
function function_9b8d20089e7175e2( rig, var_3607c945e89be01 )
{
    rig.linkent = var_3607c945e89be01;
    
    foreach ( probe in rig.probes )
    {
        origin_offset = probe.origin_offset;
        angles_offset = probe.angles_offset;
        
        if ( !isdefined( angles_offset ) )
        {
            angles_offset = ( 0, 0, 0 );
        }
        
        probe linkto( rig.linkent, "tag_origin", origin_offset, angles_offset );
    }
    
    foreach ( light in rig.lights )
    {
        origin_offset = light.origin_offset;
        angles_offset = light.angles_offset;
        
        if ( !isdefined( angles_offset ) )
        {
            angles_offset = ( 0, 0, 0 );
        }
        
        light linkto( rig.linkent, "tag_origin", origin_offset, angles_offset );
    }
}

// Namespace br_infils_util
// Params 2, eflags: 0x4
// Checksum 0x79322558, Offset: 0xb1d
// Size: 0x13a
function private function_8b1bb889b21089( rig, override_og )
{
    if ( !isdefined( rig ) )
    {
        return;
    }
    
    foreach ( probe in rig.probes )
    {
        probe hide();
    }
    
    foreach ( light in rig.lights )
    {
        if ( override_og && !isdefined( light.original_intensity ) )
        {
            light.original_intensity = light getlightintensity();
        }
        
        light setlightintensity( 0 );
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0x8cc9e0b3, Offset: 0xc5f
// Size: 0x85
function create_animpack( anime, islooping )
{
    pack = spawnstruct();
    pack.ents = [];
    pack.staticents = [];
    pack.playerpositions = [];
    pack.var_ebbf2026208f047d = [];
    pack.lightingrigs = [];
    pack.anime = anime;
    pack.islooping = istrue( islooping );
    return pack;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xa3566eec, Offset: 0xced
// Size: 0x17
function set_pack_fov( fov )
{
    self.fov = fov;
}

// Namespace br_infils_util
// Params 5
// Checksum 0xccab3dec, Offset: 0xd0c
// Size: 0x67
function function_619acbbcf154f2df( fstop, focusdist, focusspeed, aperturespeed, focalpoint )
{
    self.fstop = fstop;
    self.focusdist = focusdist;
    self.focusspeed = focusspeed;
    self.aperturespeed = aperturespeed;
    self.focalpoint = focalpoint;
}

// Namespace br_infils_util
// Params 2
// Checksum 0xa37d8704, Offset: 0xd7b
// Size: 0x2b
function add_pack_startfunc( paramarray, func )
{
    self.startfunc = func;
    self.var_d664c1119b3ae972 = paramarray;
}

// Namespace br_infils_util
// Params 2
// Checksum 0x3148b3cf, Offset: 0xdae
// Size: 0x2b
function function_9597cbd14a6857e3( paramarray, func )
{
    self.playerfunc = func;
    self.var_6d8067a88da0e813 = paramarray;
}

// Namespace br_infils_util
// Params 2
// Checksum 0xe5e586a, Offset: 0xde1
// Size: 0x74
function add_pack_modelanim( ent, animation )
{
    assert( isdefined( ent.animname ) );
    assert( isdefined( self.anime ) );
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.ents[ self.ents.size ] = ent;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xf95f21be, Offset: 0xe5d
// Size: 0x23
function function_88f4d49c8d510297( ent )
{
    self.staticents[ self.staticents.size ] = ent;
}

// Namespace br_infils_util
// Params 1
// Checksum 0x52017ffb, Offset: 0xe88
// Size: 0x23
function function_cac49eb1af86a29e( rig )
{
    self.lightingrigs[ self.lightingrigs.size ] = rig;
}

// Namespace br_infils_util
// Params 3
// Checksum 0xbbedee02, Offset: 0xeb3
// Size: 0xa4
function function_9371dd9b5a3be26e( ent, animation, femaleanimation )
{
    index = self.playerpositions.size;
    newstruct = spawnstruct();
    newstruct.ent = ent;
    newstruct.animation = animation;
    newstruct.animname = getanimname( animation );
    
    if ( isdefined( femaleanimation ) )
    {
        newstruct.animationfem = femaleanimation;
        newstruct.animnamefem = getanimname( femaleanimation );
    }
    
    self.playerpositions[ index ] = newstruct;
}

// Namespace br_infils_util
// Params 2
// Checksum 0xc02156f5, Offset: 0xf5f
// Size: 0x74
function function_23a63ce49ef69d8f( ent, animation )
{
    assert( isdefined( ent.animname ) );
    assert( isdefined( self.anime ) );
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.var_ebbf2026208f047d[ self.var_ebbf2026208f047d.size ] = ent;
}

// Namespace br_infils_util
// Params 5
// Checksum 0xa4acb941, Offset: 0xfdb
// Size: 0x123
function function_4e87e96bc5852dc0( ent, var_a87edda589012079, animation, xcamasset, xcamfunction )
{
    assert( !isdefined( self.camerainfo ) );
    self.camerainfo = spawnstruct();
    self.camerainfo.ent = ent;
    self.camerainfo.var_a87edda589012079 = var_a87edda589012079;
    
    if ( isdefined( xcamasset ) )
    {
        self.camerainfo.xcamasset = xcamasset;
        self.camerainfo.xcamfunction = xcamfunction;
        
        if ( !self.islooping )
        {
            xcamlength = getxcamlength( xcamasset );
            xcamlength -= 0.033;
            xcamlength -= xcamlength % 0.05;
            self.camerainfo.xcamlength = xcamlength;
        }
        
        return;
    }
    
    if ( !self.islooping )
    {
        self.camerainfo.animlength = getanimlength( animation );
    }
}

// Namespace br_infils_util
// Params 3
// Checksum 0xf37c824c, Offset: 0x1106
// Size: 0x3f
function add_pack_fx( fxid, origin, angles )
{
    self.fx = fxid;
    self.fxorigin = origin;
    self.fxangles = angles;
}

// Namespace br_infils_util
// Params 3
// Checksum 0x53aa8d4f, Offset: 0x114d
// Size: 0xeb
function add_pack_playeranim( player, maleanim, femaleanim )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    animname = undefined;
    
    if ( !isdefined( player.brexfilanimname ) )
    {
        animname = "player" + player getentitynumber();
        player.animname = animname;
        player.brexfilanimname = animname;
    }
    else
    {
        animname = player.brexfilanimname;
    }
    
    animation = maleanim;
    
    if ( isdefined( femaleanim ) )
    {
        if ( player operator::isfemale() )
        {
            animation = femaleanim;
        }
    }
    
    level.scr_anim[ animname ][ self.anime ] = animation;
    level.scr_eventanim[ animname ][ self.anime ] = getanimname( animation );
    self.players[ self.players.size ] = player;
}

// Namespace br_infils_util
// Params 2
// Checksum 0xb3334186, Offset: 0x1240
// Size: 0x4d
function function_8e44037c2a8b1713( statename, func )
{
    assert( !isdefined( level.infilstruct.statecallbacks[ statename ] ) );
    level.infilstruct.statecallbacks[ statename ] = func;
}

// Namespace br_infils_util
// Params 2
// Checksum 0xf6cea22e, Offset: 0x1295
// Size: 0x5d
function set_orbit_cam_info( var_da03b581959292d1, var_991e456b8e5df650 )
{
    level.infilstruct.var_74e6b574e5d9fbf3 = var_da03b581959292d1;
    
    if ( isdefined( var_991e456b8e5df650 ) )
    {
        level.infilstruct.var_2af14956ebe78ee0 = var_991e456b8e5df650;
        return;
    }
    
    level.infilstruct.var_2af14956ebe78ee0 = undefined;
}

// Namespace br_infils_util
// Params 0
// Checksum 0x2379b705, Offset: 0x12fa
// Size: 0xd5
function function_33bc0165dc649d12()
{
    if ( isdefined( level.infilstruct.var_2af14956ebe78ee0 ) && isdefined( self.var_edbda953d7469bd7 ) && self.var_edbda953d7469bd7 == 1 )
    {
        return level.infilstruct.var_2af14956ebe78ee0;
    }
    
    if ( isarray( level.infilstruct.var_74e6b574e5d9fbf3 ) )
    {
        slotnumber = 0;
        
        if ( isdefined( self.infilanimindex ) )
        {
            slotnumber = self.infilanimindex - 1;
        }
        
        assert( slotnumber < level.infilstruct.var_74e6b574e5d9fbf3.size );
        return level.infilstruct.var_74e6b574e5d9fbf3[ slotnumber ];
    }
    
    return level.infilstruct.var_74e6b574e5d9fbf3;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xb5433716, Offset: 0x13d8
// Size: 0xb4
function allplayers_setfov( fov )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientdvar( @"cg_fov", fov );
        player setclientdvar( @"cg_disable_user_fov", 1 );
    }
}

// Namespace br_infils_util
// Params 0
// Checksum 0x8b9eca58, Offset: 0x1494
// Size: 0x172
function function_4b282a3b31aae42a()
{
    if ( level.infilstruct.var_ea87d0ead0c54f1c )
    {
        foreach ( player in level.infilstruct.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientdvar( @"cg_fov", 65 );
            player setclientdvar( @"cg_fov_viewmodel", 65 );
        }
        
        return;
    }
    
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientdvar( @"cg_fov", 65 );
        player setclientdvar( @"cg_fov_viewmodel", 65 );
        player setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace br_infils_util
// Params 5
// Checksum 0x84f16e6c, Offset: 0x160e
// Size: 0x133
function allplayers_setphysicaldof( fstop, focusdist, focusspeed = 100, aperturespeed = 100, focalpoint )
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.var_5d1d2a9db3eeaa3f ) )
        {
            player.var_5d1d2a9db3eeaa3f = 1;
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

// Namespace br_infils_util
// Params 0
// Checksum 0x4ef3cb4f, Offset: 0x1749
// Size: 0xa7
function allplayers_clearphysicaldof()
{
    foreach ( player in level.infilstruct.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.var_5d1d2a9db3eeaa3f ) )
        {
            player.var_5d1d2a9db3eeaa3f = undefined;
            player disablephysicaldepthoffieldscripting();
        }
    }
}

// Namespace br_infils_util
// Params 1
// Checksum 0xfca28fce, Offset: 0x17f8
// Size: 0x11c
function function_83a34c13962084d2( fadedowntime )
{
    assert( !isdefined( level.infilblackoverlay ) );
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
    level.infilblackoverlay = overlay;
    
    if ( fadedowntime > 0 )
    {
        level.infilblackoverlay.alpha = 0;
        level.infilblackoverlay fadeovertime( fadedowntime );
        level.infilblackoverlay.alpha = 1;
        return;
    }
    
    level.infilblackoverlay.alpha = 1;
}

// Namespace br_infils_util
// Params 1
// Checksum 0x194501be, Offset: 0x191c
// Size: 0x119
function function_1bcc092ff2549bba( fadeuptime )
{
    assert( isdefined( level.infilblackoverlay ) );
    
    if ( fadeuptime > 0 )
    {
        level.infilblackoverlay.alpha = 1;
        level.infilblackoverlay fadeovertime( fadeuptime );
        level.infilblackoverlay.alpha = 0;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player damage_effects::function_e8cba6f10a4635e9();
            player notify( #"deaths_door_exit" );
            player clearsoundsubmix( "mp_br_lobby_fade", 0 );
        }
        
        return;
    }
    
    level.infilblackoverlay.alpha = 0;
}

// Namespace br_infils_util
// Params 0
// Checksum 0xaf03280c, Offset: 0x1a3d
// Size: 0x2c
function function_a434d2e0ad2bfa82()
{
    assert( isdefined( level.infilblackoverlay ) );
    level.infilblackoverlay destroy();
    level.infilblackoverlay = undefined;
}

// Namespace br_infils_util
// Params 4
// Checksum 0xe9999a89, Offset: 0x1a71
// Size: 0xa7
function function_c050cae6f9bcb77f( fadedowntime, players, fadename, fadecolor )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_d36ff11e6bc121f6( fadedowntime, fadename, fadecolor );
    }
}

// Namespace br_infils_util
// Params 3
// Checksum 0x733beeea, Offset: 0x1b20
// Size: 0xb7
function function_d36ff11e6bc121f6( fadedowntime, fadename, fadecolor )
{
    function_5d4e18c9de8c44fa( fadedowntime, fadename, fadecolor );
    spectators = br_spectate::function_ff10813f2a7bd19c();
    
    if ( spectators.size > 0 )
    {
        foreach ( viewer in spectators )
        {
            viewer function_5d4e18c9de8c44fa( fadedowntime, fadename, fadecolor );
        }
    }
}

// Namespace br_infils_util
// Params 3
// Checksum 0x314b2d7a, Offset: 0x1bdf
// Size: 0x14b
function function_5d4e18c9de8c44fa( fadedowntime, fadename, fadecolor = "black" )
{
    assert( isdefined( fadename ) );
    
    if ( !isdefined( self.var_ef85badc92e7af8a ) )
    {
        self.var_ef85badc92e7af8a = [];
    }
    
    assert( !isdefined( self.var_ef85badc92e7af8a[ fadename ] ) );
    
    if ( isdefined( self.var_ef85badc92e7af8a[ fadename ] ) )
    {
        return;
    }
    
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( fadecolor, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.sort = -1;
    overlay.archived = 0;
    overlay setshowinrealism( 1 );
    
    if ( fadedowntime > 0 )
    {
        overlay.alpha = 0;
        overlay fadeovertime( fadedowntime );
    }
    
    overlay.alpha = 1;
    self.var_ef85badc92e7af8a[ fadename ] = overlay;
}

// Namespace br_infils_util
// Params 3
// Checksum 0x3e4d1d88, Offset: 0x1d32
// Size: 0x2a
function function_573cdd2bc439ec67( fadeuptime, players, fadename )
{
    level thread function_b9bf0b31c32cf409( fadeuptime, players, fadename );
}

// Namespace br_infils_util
// Params 3, eflags: 0x4
// Checksum 0x19707582, Offset: 0x1d64
// Size: 0x219
function private function_b9bf0b31c32cf409( fadeuptime, players, fadename )
{
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_333c77fc70a9408e( fadeuptime, fadename );
        spectators = player br_spectate::function_ff10813f2a7bd19c();
        
        if ( spectators.size > 0 )
        {
            foreach ( viewer in spectators )
            {
                viewer function_333c77fc70a9408e( fadeuptime, fadename );
            }
        }
    }
    
    wait fadeuptime;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_bc5d959c1f5ed566( fadename );
        spectators = player br_spectate::function_ff10813f2a7bd19c();
        
        if ( spectators.size > 0 )
        {
            foreach ( viewer in spectators )
            {
                viewer function_bc5d959c1f5ed566( fadename );
            }
        }
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0x9db0b468, Offset: 0x1f85
// Size: 0xeb
function function_333c77fc70a9408e( fadeuptime, fadename )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( isdefined( fadename ) );
    
    if ( isbot( self ) && !( isdefined( self.var_ef85badc92e7af8a ) && isdefined( self.var_ef85badc92e7af8a[ fadename ] ) ) )
    {
        return;
    }
    
    assert( isdefined( self.var_ef85badc92e7af8a ) );
    assert( isdefined( self.var_ef85badc92e7af8a[ fadename ] ) );
    overlay = self.var_ef85badc92e7af8a[ fadename ];
    
    if ( fadeuptime > 0 )
    {
        if ( isdefined( overlay ) )
        {
            overlay.alpha = 1;
            overlay fadeovertime( fadeuptime );
            overlay.alpha = 0;
        }
        
        damage_effects::function_e8cba6f10a4635e9();
        self clearsoundsubmix( "mp_br_lobby_fade", 0 );
        return;
    }
    
    if ( isdefined( overlay ) )
    {
        overlay.alpha = 0;
    }
}

// Namespace br_infils_util
// Params 1
// Checksum 0xb7399f17, Offset: 0x2078
// Size: 0xa8
function function_bc5d959c1f5ed566( fadename )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isbot( self ) && !( isdefined( self.var_ef85badc92e7af8a ) && isdefined( self.var_ef85badc92e7af8a[ fadename ] ) ) )
    {
        return;
    }
    
    assert( isdefined( self.var_ef85badc92e7af8a ) );
    assert( isdefined( self.var_ef85badc92e7af8a[ fadename ] ) );
    
    if ( isdefined( self.var_ef85badc92e7af8a[ fadename ] ) )
    {
        self.var_ef85badc92e7af8a[ fadename ] destroy();
        self.var_ef85badc92e7af8a[ fadename ] = undefined;
    }
    
    if ( self.var_ef85badc92e7af8a.size == 0 )
    {
        self.var_ef85badc92e7af8a = undefined;
    }
}

// Namespace br_infils_util
// Params 0
// Checksum 0xa6bd352b, Offset: 0x2128
// Size: 0x80
function endprematchskydiving()
{
    var_5707ab0ca7e46d35 = 5;
    assert( isplayer( self ), "<dev string:x24>" );
    player = self;
    player skydive_setdeploymentstatus( 0 );
    player skydive_setbasejumpingstatus( 0 );
    
    if ( isdefined( player.ffsm_state ) )
    {
        player.ffsm_state = var_5707ab0ca7e46d35;
    }
    
    player parachute::parachutecleanup();
    player setshowcontrail( 0 );
    player setisinfilskydive( 0 );
    player notify( #"skydive_end" );
}

// Namespace br_infils_util
// Params 1
// Checksum 0x886e2e07, Offset: 0x21b0
// Size: 0x1f5
function refreshteamvisibility( players )
{
    if ( level.var_8f64d94451f73542 )
    {
        return;
    }
    
    hidetest = 0;
    
    /#
        hidetest = getdvarint( @"hash_484dde7ceb1b8065", 0 ) != 0;
    #/
    
    var_501f43e15c24e40 = isdefined( players ) && players.size != level.players.size;
    
    foreach ( team in level.teamnamelist )
    {
        teamplayers = teams::getteamdata( team, "players" );
        
        foreach ( player in teamplayers )
        {
            if ( var_501f43e15c24e40 && !arraycontains( players, player ) )
            {
                continue;
            }
            
            if ( !br_infils_common::function_bcca26e6456e3959( player ) )
            {
                continue;
            }
            
            player player_utility::function_dbe5a52a6654a982();
            player player_utility::function_9d378d725bb4831e( "br_infils_util::refreshTeamVisibility()" );
            
            if ( !hidetest )
            {
                foreach ( otherplayer in teamplayers )
                {
                    player showtoplayer( otherplayer );
                }
            }
        }
    }
}

// Namespace br_infils_util
// Params 1
// Checksum 0x43c5947e, Offset: 0x23ad
// Size: 0x154
function refreshteamvisibilityforteam( team )
{
    if ( level.var_8f64d94451f73542 )
    {
        return;
    }
    
    hidetest = 0;
    
    /#
        hidetest = getdvarint( @"hash_484dde7ceb1b8065", 0 ) != 0;
    #/
    
    teamplayers = teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( !br_infils_common::function_bcca26e6456e3959( player ) )
        {
            continue;
        }
        
        player player_utility::function_dbe5a52a6654a982();
        player player_utility::function_9d378d725bb4831e( "br_infils_util::refreshTeamVisibilityForTeam()" );
        
        if ( !hidetest )
        {
            foreach ( otherplayer in teamplayers )
            {
                player showtoplayer( otherplayer );
            }
        }
    }
}

// Namespace br_infils_util
// Params 1
// Checksum 0x48d616ac, Offset: 0x2509
// Size: 0x5b
function registerbrsquadleaderjumpcommands( brsquadleader )
{
    if ( !brsquadleader.jumpcomandsregistered )
    {
        brsquadleader.jumpcomandsregistered = 1;
        brsquadleader br_public::updatebrscoreboardstat( "jumpMasterState", 2 );
        brsquadleader notifyonplayercommand( "halo_jump_c130", "+gostand" );
        brsquadleader notifyonplayercommand( "br_break_squad", "+breath_sprint" );
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0xac49070a, Offset: 0x256c
// Size: 0x67
function watchbrsquadleaderdisconnect( team, squadindex )
{
    utility::waittill_any( "death", "disconnect" );
    squadmates = teams::function_d032b36d01bbbab3( team, squadindex );
    brsquadleader = setupbrsquadleader( squadmates );
    
    if ( isdefined( brsquadleader ) )
    {
        registerbrsquadleaderjumpcommands( brsquadleader );
        brsquadleader thread watchbrsquadleaderdisconnect( team, squadindex );
    }
}

// Namespace br_infils_util
// Params 1
// Checksum 0xb553b1ac, Offset: 0x25db
// Size: 0x304
function setupbrsquadleader( teamplayers )
{
    if ( teamplayers.size == 0 )
    {
        return;
    }
    
    brsquadleader = undefined;
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player ) && player br_public::isplayerbrsquadleader() )
        {
            return player;
        }
    }
    
    foreach ( player in teamplayers )
    {
        if ( level.onlinegame && player isfireteamleader() )
        {
            brsquadleader = player;
            break;
        }
    }
    
    if ( !isdefined( brsquadleader ) )
    {
        var_d12106d2a1133307 = 0;
        
        /#
            var_d12106d2a1133307 = getdvarint( @"hash_e65dc975d6fcfca0", 0 ) != 0;
        #/
        
        numplayerschecked = 0;
        
        foreach ( player in teamplayers )
        {
            var_bd73200b8d7663bb = var_d12106d2a1133307 == isbot( player );
            
            if ( var_bd73200b8d7663bb )
            {
                numplayerschecked++;
                var_f39933a5baba5a30 = 1 / numplayerschecked;
                
                if ( randomfloat( 1 ) < var_f39933a5baba5a30 )
                {
                    brsquadleader = player;
                }
            }
        }
    }
    
    if ( !isdefined( brsquadleader ) )
    {
        foreach ( player in teamplayers )
        {
            brsquadleader = player;
            break;
        }
    }
    
    if ( !isdefined( brsquadleader ) )
    {
        return;
    }
    
    brsquadleader br::setplayerbrsquadleader( 1 );
    
    foreach ( player in teamplayers )
    {
        if ( player != brsquadleader )
        {
            player br::setplayerbrsquadleader( 0 );
        }
        
        infilstatus = player br_public::isplayerbrsquadleader() ? 2 : 1;
        br_c130::setteammateomnvarsforplayer( player, teamplayers, infilstatus );
    }
    
    return brsquadleader;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xf1a171ee, Offset: 0x28e8
// Size: 0x164
function function_8fa0e0e9181d322( player )
{
    forceindex = undefined;
    possibleindices = [ 1, 2, 3, 4 ];
    teamplayers = teams::function_72b89edf6b47c40a( player ).players;
    assert( teamplayers.size <= possibleindices.size );
    player.var_edbda953d7469bd7 = teamplayers.size;
    
    foreach ( teamplayer in teamplayers )
    {
        if ( teamplayer == player )
        {
            continue;
        }
        
        if ( isdefined( teamplayer.infilanimindex ) )
        {
            possibleindices = arrayremove( possibleindices, teamplayer.infilanimindex );
        }
        
        if ( teamplayer br_public::isplayerbrsquadleader() )
        {
            possibleindices = arrayremove( possibleindices, 1 );
        }
    }
    
    if ( possibleindices.size == 0 )
    {
        possibleindices[ 0 ] = 1;
    }
    
    player.infilanimindex = possibleindices[ 0 ];
    
    /#
        forceindex = getdvarint( @"hash_441165c7b355dd1b", -1 );
        
        if ( forceindex > 0 )
        {
            player.infilanimindex = forceindex;
        }
    #/
}

// Namespace br_infils_util
// Params 0
// Checksum 0xd37c1673, Offset: 0x2a54
// Size: 0x12
function getinfilspawnoffset()
{
    return getdvarfloat( @"scr_br_dropspawnoffsetminz", 11400 );
}

/#

    // Namespace br_infils_util
    // Params 0
    // Checksum 0xbf95dd06, Offset: 0x2a6f
    // Size: 0x16, Type: dev
    function function_6f01e2b77b9b7e5c()
    {
        return getdvarint( @"hash_8545857262882e35", 0 ) != 0;
    }

    // Namespace br_infils_util
    // Params 0
    // Checksum 0xc8ac8da, Offset: 0x2a8d
    // Size: 0x16, Type: dev
    function function_e2a545749781eeb4()
    {
        return getdvarint( @"hash_a6a8289d97746380", 0 ) != 0;
    }

    // Namespace br_infils_util
    // Params 0
    // Checksum 0x696be2a8, Offset: 0x2aab
    // Size: 0x18, Type: dev
    function function_4c779466069dbe9e()
    {
        setdvar( @"hash_a6a8289d97746380", "<dev string:x55>" );
    }

    // Namespace br_infils_util
    // Params 1
    // Checksum 0x397afea, Offset: 0x2acb
    // Size: 0x46, Type: dev
    function function_ba73477f944b8de( timesec )
    {
        if ( function_6f01e2b77b9b7e5c() )
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
            
            return 1;
        }
        
        return 0;
    }

#/

// Namespace br_infils_util
// Params 0
// Checksum 0x98033f71, Offset: 0x2b19
// Size: 0x2e
function function_7d2f9d2a086bd511()
{
    movinginfil = 1;
    
    /#
        if ( function_6f01e2b77b9b7e5c() )
        {
            movinginfil = getdvarint( @"hash_f6b3b7c2e066bf97", 0 );
        }
    #/
    
    return movinginfil;
}

// Namespace br_infils_util
// Params 1
// Checksum 0x460045ad, Offset: 0x2b50
// Size: 0x1e
function waitandpause( timesec )
{
    /#
        if ( function_ba73477f944b8de( timesec ) )
        {
            return;
        }
    #/
    
    wait timesec;
}

// Namespace br_infils_util
// Params 1
// Checksum 0xb757386c, Offset: 0x2b76
// Size: 0x35
function function_fffda20dc2c2df07( func )
{
    assert( isdefined( level.var_21ea52a8dfa4b9eb ) );
    level.var_21ea52a8dfa4b9eb[ level.var_21ea52a8dfa4b9eb.size ] = func;
}

// Namespace br_infils_util
// Params 0
// Checksum 0xc5d49f67, Offset: 0x2bb3
// Size: 0x74
function function_b331ca02076487e0()
{
    var_d8b9126c02dadaa5 = getdvarint( @"hash_2a44f025a172a99b", 0 );
    
    if ( var_d8b9126c02dadaa5 )
    {
        assert( isdefined( level.var_aea805ad236a525f ) );
        return utility::array_random( level.var_aea805ad236a525f );
    }
    
    skins = [ %"t10_rus_weaver_rogue_skin", %"t10_usa_pl_marshall_brawn_skin" ];
    return utility::array_random( skins );
}

// Namespace br_infils_util
// Params 1
// Checksum 0x37b3bd85, Offset: 0x2c2f
// Size: 0xfd
function function_3855f5796f4d2b65( transientname )
{
    if ( isdefined( level.infilstruct.var_df720711dd79fea7 ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"br_infils", #"hash_dd6d580483cd15ca" ) )
    {
        return utility::callsharedfunc( #"br_infils", #"hash_dd6d580483cd15ca", transientname );
    }
    
    if ( level.mapinfobundle )
    {
        foreach ( infilintro in level.mapinfobundle.transientdata.infilintro )
        {
            unloadinfiltransient( infilintro.transientname );
        }
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0xe996c371, Offset: 0x2d34
// Size: 0x148
function function_a9c0d3a0c0dbb2f6( lights, lightson )
{
    if ( lightson )
    {
        var_37138c1c61090afb = [];
        var_37138c1c61090afb[ "infil_light_01" ] = 0.159109;
        var_37138c1c61090afb[ "infil_light_02" ] = 0.238663;
        var_37138c1c61090afb[ "infil_light_03" ] = 0.00596659;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_37138c1c61090afb[ light.name ] );
            light forcenetfieldhighlod( 1 );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 7.95545e-05 );
        light forcenetfieldhighlod( 0 );
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0x52f542de, Offset: 0x2e84
// Size: 0x12a
function function_d235522ed1c80f20( lights, lightson )
{
    if ( lightson )
    {
        var_37138c1c61090afb = [];
        var_37138c1c61090afb[ "exfil_light_01" ] = 0.0397772;
        var_37138c1c61090afb[ "exfil_light_02" ] = 0.0994431;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_37138c1c61090afb[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 7.95545e-05 );
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0xf590a0c, Offset: 0x2fb6
// Size: 0x151
function function_b16656dc4b1d067c( lights, lightson )
{
    if ( lightson )
    {
        var_37138c1c61090afb = [];
        var_37138c1c61090afb[ "cq_exfil_light_01" ] = 0.0795545;
        var_37138c1c61090afb[ "cq_exfil_light_02" ] = 0.0795545;
        var_37138c1c61090afb[ "cq_exfil_light_03" ] = 0.0994431;
        var_37138c1c61090afb[ "cq_exfil_light_04" ] = 0.0397772;
        var_37138c1c61090afb[ "cq_exfil_light_05" ] = 0.0397772;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_37138c1c61090afb[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 7.95545e-05 );
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0x397a8ac2, Offset: 0x310f
// Size: 0x137
function function_5a725a111a851964( lights, lightson )
{
    if ( lightson )
    {
        var_37138c1c61090afb = [];
        var_37138c1c61090afb[ "2ndry_light_01" ] = 0.0198886;
        var_37138c1c61090afb[ "2ndry_light_02" ] = 0.0795545;
        var_37138c1c61090afb[ "2ndry_light_03" ] = 0.0397772;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_37138c1c61090afb[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 7.95545e-05 );
    }
}

// Namespace br_infils_util
// Params 2
// Checksum 0xf78aeb87, Offset: 0x324e
// Size: 0x137
function function_696f9cfe95a1ba79( lights, lightson )
{
    if ( lightson )
    {
        var_37138c1c61090afb = [];
        var_37138c1c61090afb[ "accolade_light_01" ] = 0.0596659;
        var_37138c1c61090afb[ "accolade_light_02" ] = 0.0795545;
        var_37138c1c61090afb[ "accolade_light_03" ] = 0.0795545;
        
        foreach ( light in lights )
        {
            light setlightintensity( var_37138c1c61090afb[ light.name ] );
        }
        
        return;
    }
    
    foreach ( light in lights )
    {
        light setlightintensity( 7.95545e-05 );
    }
}

// Namespace br_infils_util
// Params 1
// Checksum 0xb2bd543a, Offset: 0x338d
// Size: 0x1fd
function function_94c95c81b53e5532( lights )
{
    infillights = getentarray( "infil_light", #targetname );
    exfillights = getentarray( "exfil_light", #targetname );
    var_c756375eda94a18b = getentarray( "cq_exfil_light", #targetname );
    var_ef5f49dd9036e12b = getentarray( "2ndry_light", #targetname );
    accoladelights = getentarray( "accolade_light", #targetname );
    
    switch ( lights )
    {
        case #"hash_cf4e05b68aeba31a":
            function_a9c0d3a0c0dbb2f6( infillights, 1 );
            function_d235522ed1c80f20( exfillights, 0 );
            function_b16656dc4b1d067c( var_c756375eda94a18b, 0 );
            function_5a725a111a851964( var_ef5f49dd9036e12b, 0 );
            function_696f9cfe95a1ba79( accoladelights, 0 );
            break;
        case #"hash_8dabe7b0b667b264":
            function_a9c0d3a0c0dbb2f6( infillights, 0 );
            function_d235522ed1c80f20( exfillights, 1 );
            function_b16656dc4b1d067c( var_c756375eda94a18b, 0 );
            function_5a725a111a851964( var_ef5f49dd9036e12b, 0 );
            function_696f9cfe95a1ba79( accoladelights, 0 );
            break;
        case #"hash_4856b940c7c5b675":
            function_a9c0d3a0c0dbb2f6( infillights, 0 );
            function_d235522ed1c80f20( exfillights, 0 );
            function_b16656dc4b1d067c( var_c756375eda94a18b, 1 );
            function_5a725a111a851964( var_ef5f49dd9036e12b, 0 );
            function_696f9cfe95a1ba79( accoladelights, 0 );
            break;
        case #"hash_f020299c866e4289":
            function_a9c0d3a0c0dbb2f6( infillights, 0 );
            function_d235522ed1c80f20( exfillights, 0 );
            function_b16656dc4b1d067c( var_c756375eda94a18b, 0 );
            function_5a725a111a851964( var_ef5f49dd9036e12b, 1 );
            function_696f9cfe95a1ba79( accoladelights, 0 );
            break;
        case #"hash_96702057c0bd388":
            function_a9c0d3a0c0dbb2f6( infillights, 0 );
            function_d235522ed1c80f20( exfillights, 0 );
            function_b16656dc4b1d067c( var_c756375eda94a18b, 0 );
            function_5a725a111a851964( var_ef5f49dd9036e12b, 0 );
            function_696f9cfe95a1ba79( accoladelights, 1 );
            break;
        default:
            break;
    }
}

// Namespace br_infils_util
// Params 0
// Checksum 0x9ca103d0, Offset: 0x3592
// Size: 0x26
function function_8a24432634d2a043()
{
    infillights = getentarray( "infil_light", "targetname" );
    function_a9c0d3a0c0dbb2f6( infillights, 0 );
}

// Namespace br_infils_util
// Params 1
// Checksum 0x5608723c, Offset: 0x35c0
// Size: 0x95
function function_e0a802528c2de787( calloutlist )
{
    if ( !isdefined( calloutlist ) || calloutlist == "" )
    {
        mapinfo = level.mapinfobundle;
        
        if ( !isdefined( mapinfo ) )
        {
            mapinfo = getmapscriptbundle();
        }
        
        if ( !isdefined( mapinfo.var_8d79c46971b97b8e ) )
        {
            assertmsg( "<dev string:x57>" + mapinfo.mapname + "<dev string:x7e>" );
            calloutlist = "none";
        }
        else
        {
            calloutlist = mapinfo.var_8d79c46971b97b8e;
        }
    }
    
    setomnvarforallclients( o"ui_cinematic_player_callout_list", calloutlist );
}

