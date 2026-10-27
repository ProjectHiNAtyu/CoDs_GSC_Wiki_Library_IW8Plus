// scripts\mp\br\gametypes\br_ending_util.gsc  (hash_1b6531235ffbb5de.gscc) (size: 14588 Bytes / 0x38fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x835ec3b0 (2204025776)
// size ...... 14588 (0x38fc)
// includes .. 5   (offset: 0x3690)
// strings ... 33  (offset: 0x36b8)
// dev strs .. 5   (offset: 0x389c)
// exports ... 45  (offset: 0x26ac)
// cseg ...... 0x2cf + 0x23dd (0x26ac)
// imports ... 68  (offset: 0x2db4)
// animtree1 . 1   (offset: 0x38e4)
// animtree2 . 0   (offset: 0x38fc)
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\operator;

#namespace br_ending_util;

// Namespace br_ending_util
// Params 1
// Checksum 0x63ee6fa1, Offset: 0x2ed
// Size: 0x6b
function create_animpack( anime )
{
    pack = spawnstruct();
    pack.ents = [];
    pack.players = [];
    pack.cam = undefined;
    pack.lightingrigs = [];
    pack.anime = anime;
    pack.packs = [];
    return pack;
}

// Namespace br_ending_util
// Params 0
// Checksum 0x539226ac, Offset: 0x361
// Size: 0x20
function function_fa41a73cf4c5bb7b()
{
    if ( !getdvarint( @"hash_88262f900b40e276", 0 ) )
    {
        return;
    }
    
    self.var_c9ef7dbce2d4764e = 1;
}

// Namespace br_ending_util
// Params 1
// Checksum 0xed291a90, Offset: 0x389
// Size: 0x17
function set_pack_fov( fov )
{
    self.fov = fov;
}

// Namespace br_ending_util
// Params 5
// Checksum 0x82d44990, Offset: 0x3a8
// Size: 0x67
function function_619acbbcf154f2df( fstop, focusdist, focusspeed, aperturespeed, focalpoint )
{
    self.fstop = fstop;
    self.focusdist = focusdist;
    self.focusspeed = focusspeed;
    self.aperturespeed = aperturespeed;
    self.focalpoint = focalpoint;
}

// Namespace br_ending_util
// Params 2
// Checksum 0xddba521f, Offset: 0x417
// Size: 0x4e
function add_pack_modelanim( ent, animation )
{
    level.scr_anim[ ent.animname ][ self.anime ] = animation;
    self.ents[ self.ents.size ] = ent;
}

// Namespace br_ending_util
// Params 2
// Checksum 0x36ecc76f, Offset: 0x46d
// Size: 0x2b
function add_pack_startfunc( paramarray, func )
{
    self.startfunc = func;
    self.paramarray = paramarray;
}

// Namespace br_ending_util
// Params 2
// Checksum 0x434ce83e, Offset: 0x4a0
// Size: 0x2b
function function_97184132912f1dc3( paramarray, func )
{
    self.endfunc = func;
    self.var_3d181e279a220c81 = paramarray;
}

// Namespace br_ending_util
// Params 2
// Checksum 0x7f37c7b3, Offset: 0x4d3
// Size: 0x2b
function function_9597cbd14a6857e3( paramarray, func )
{
    self.playerfunc = func;
    self.var_6d8067a88da0e813 = paramarray;
}

// Namespace br_ending_util
// Params 1
// Checksum 0x26f1aa7c, Offset: 0x506
// Size: 0x17
function function_19d9726ab575306d( fadeinlength )
{
    self.fadeinlength = fadeinlength;
}

// Namespace br_ending_util
// Params 1
// Checksum 0xe9febdc5, Offset: 0x525
// Size: 0x17
function function_6bebfdad268ca836( fadeoutlength )
{
    self.fadeoutlength = fadeoutlength;
}

// Namespace br_ending_util
// Params 3
// Checksum 0x1dd5f933, Offset: 0x544
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
    
    self.players[ self.players.size ] = player;
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
}

// Namespace br_ending_util
// Params 2
// Checksum 0xc84ce41d, Offset: 0x637
// Size: 0x47
function add_pack_camanim( animation, xcamasset )
{
    self.cam = 1;
    level.scr_anim[ "endingCam" ][ self.anime ] = animation;
    self.xcamasset = xcamasset;
}

// Namespace br_ending_util
// Params 3
// Checksum 0xbd03f630, Offset: 0x686
// Size: 0x3f
function add_pack_fx( fxid, origin, angles )
{
    self.fx = fxid;
    self.fxorigin = origin;
    self.fxangles = angles;
}

// Namespace br_ending_util
// Params 1
// Checksum 0x1c7e0b87, Offset: 0x6cd
// Size: 0x23
function function_cac49eb1af86a29e( rig )
{
    self.lightingrigs[ self.lightingrigs.size ] = rig;
}

#using_animtree( "script_model" );

// Namespace br_ending_util
// Params 3
// Checksum 0xf93e1d89, Offset: 0x6f8
// Size: 0x159
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
    model useanimtree( #animtree );
    
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

// Namespace br_ending_util
// Params 3
// Checksum 0xf8a0c87e, Offset: 0x85a
// Size: 0xb4
function function_7142ded48d484762( modelname, animname = modelname, vehicletype )
{
    vehicle = spawnvehicle( modelname, animname, vehicletype, self.origin, self.angles );
    vehicle.animname = animname;
    vehicle.endingvehicle = 1;
    vehicle.vehiclename = vehicletype;
    vehicle setcandamage( 0 );
    
    if ( vehicle vehicle_isphysveh() )
    {
        vehicle function_d2b8ee2e1275daaf( 1 );
        vehicle vehphys_forcekeyframedmotion();
    }
    else
    {
        vehicle notsolid();
    }
    
    vehicle vehicle_turnengineoff();
    vehicle function_3a1419fc14471ab( 1 );
    return vehicle;
}

// Namespace br_ending_util
// Params 1
// Checksum 0x33438188, Offset: 0x917
// Size: 0x61
function function_1c0500c7cf8f9b7( scenename )
{
    origin_name = "exfil_" + scenename + "_light_origin";
    orgstruct = utility::getstruct( origin_name, "targetname" );
    
    if ( !isdefined( level.lighting_rigs ) )
    {
        level.lighting_rigs = [];
    }
    
    level.lighting_rigs[ origin_name ] = orgstruct;
}

// Namespace br_ending_util
// Params 1
// Checksum 0x20f90680, Offset: 0x980
// Size: 0x41
function function_f172bb5e472be336( scenename )
{
    if ( !isdefined( level.lighting_rigs ) )
    {
        return;
    }
    
    origin_name = "exfil_" + scenename + "_light_origin";
    return level.lighting_rigs[ origin_name ];
}

// Namespace br_ending_util
// Params 3
// Checksum 0x8739979e, Offset: 0x9ca
// Size: 0x41b
function function_88dc0218d2006993( scenename, linkent, originscenename )
{
    rig = spawnstruct();
    probe_name = "exfil_" + scenename + "_probe";
    light_name = "exfil_" + scenename + "_light";
    probes = getentarray( probe_name, #script_noteworthy );
    lights = getentarray( light_name, #targetname );
    orgstruct = undefined;
    
    if ( isdefined( originscenename ) )
    {
        orgstruct = function_f172bb5e472be336( originscenename );
    }
    else
    {
        orgstruct = function_f172bb5e472be336( scenename );
    }
    
    if ( !isdefined( probes ) || !probes.size )
    {
        return;
    }
    
    foreach ( p in probes )
    {
        if ( !isdefined( p ) )
        {
            return;
        }
    }
    
    if ( !isdefined( lights ) || !lights.size )
    {
        return;
    }
    
    foreach ( l in lights )
    {
        if ( !isdefined( l ) )
        {
            return;
        }
    }
    
    orgorigin = orgstruct.origin ?? ( 0, 0, 0 );
    organgles = orgstruct.angles ?? ( 0, 0, 0 );
    
    foreach ( probe in probes )
    {
        if ( !isdefined( probe.origin_offset ) && !isdefined( probe.angles_offset ) )
        {
            probeorigin = probe.origin ?? ( 0, 0, 0 );
            probeangles = probe.angles ?? ( 0, 0, 0 );
            probe.origin_offset = probeorigin - orgorigin;
            probe.angles_offset = probeangles - organgles;
        }
    }
    
    foreach ( light in lights )
    {
        if ( !isdefined( light.origin_offset ) && !isdefined( light.angles_offset ) )
        {
            lightorigin = light.origin ?? ( 0, 0, 0 );
            lightangles = light.angles ?? ( 0, 0, 0 );
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

// Namespace br_ending_util
// Params 2
// Checksum 0x1c79bac5, Offset: 0xdee
// Size: 0x13a
function function_8b1bb889b21089( rig, override_og )
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

// Namespace br_ending_util
// Params 2
// Checksum 0x7ca8d61a, Offset: 0xf30
// Size: 0x238
function function_4db4aba34fab2da9( rigstruct, linkent )
{
    if ( isdefined( rigstruct ) )
    {
        linkedtag = level.var_2c3d783630787a16 ?? "tag_origin";
        
        foreach ( probe in rigstruct.probes )
        {
            if ( !isdefined( probe ) )
            {
                continue;
            }
            
            probe forcenetfieldhighlod( 1 );
            probe function_589df9c1869fcee4( 1 );
            origin_offset = probe.origin_offset ?? ( 0, 0, 0 );
            angles_offset = probe.angles_offset ?? ( 0, 0, 0 );
            probe show();
            probe linkto( linkent, linkedtag, origin_offset, angles_offset );
        }
        
        foreach ( light in rigstruct.lights )
        {
            if ( !isdefined( light ) )
            {
                continue;
            }
            
            light forcenetfieldhighlod( 1 );
            light function_589df9c1869fcee4( 1 );
            
            if ( isdefined( light.override_intensity ) )
            {
                light setlightintensity( light.override_intensity );
            }
            else if ( isdefined( light.original_intensity ) )
            {
                light setlightintensity( light.original_intensity );
            }
            
            origin_offset = light.origin_offset ?? ( 0, 0, 0 );
            angles_offset = light.angles_offset ?? ( 0, 0, 0 );
            light linkto( linkent, linkedtag, origin_offset, angles_offset );
        }
    }
}

// Namespace br_ending_util
// Params 5
// Checksum 0xb0c9b728, Offset: 0x1170
// Size: 0x1ca
function add_pack_characteranim( modelname, extramodels, animation, animstr, animnameoverride )
{
    model = spawn( "script_model", self.origin );
    model setmodel( modelname );
    model forcenetfieldhighlod( 1 );
    model useanimtree( #animtree );
    
    if ( isdefined( animnameoverride ) )
    {
        animname = animnameoverride;
    }
    else
    {
        animname = modelname;
    }
    
    model.animname = animname;
    level.scr_anim[ model.animname ][ "br_ending" ] = animation;
    
    if ( isdefined( animstr ) )
    {
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
    }
    
    self.pack.models[ self.pack.models.size ] = model;
    return model;
}

// Namespace br_ending_util
// Params 5
// Checksum 0x5108b5af, Offset: 0x1343
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

// Namespace br_ending_util
// Params 1
// Checksum 0x4b8e0730, Offset: 0x146a
// Size: 0xa0
function allplayers_setfov( fov )
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"cg_fov", fov );
        player setclientdvar( @"cg_disable_user_fov", 1 );
    }
}

// Namespace br_ending_util
// Params 0
// Checksum 0x689df676, Offset: 0x1512
// Size: 0xa7
function function_4b282a3b31aae42a()
{
    foreach ( player in level.players )
    {
        player setclientdvar( @"cg_fov", 65 );
        player setclientdvar( @"cg_fov_viewmodel", 65 );
        player setclientdvar( @"cg_disable_user_fov", 0 );
    }
}

// Namespace br_ending_util
// Params 0
// Checksum 0x9b0a108c, Offset: 0x15c1
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

// Namespace br_ending_util
// Params 0
// Checksum 0x6ce9f4ae, Offset: 0x165c
// Size: 0x61
function chopperexfil_set_brcircle()
{
    if ( !isdefined( level.br_circle ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_circle.dangercircleent ) )
    {
        return;
    }
    
    level.br_circle.dangercircleent brcirclemoveto( self.origin[ 0 ], self.origin[ 1 ], 9000, 0.05 );
}

// Namespace br_ending_util
// Params 1
// Checksum 0x687e441a, Offset: 0x16c5
// Size: 0x125
function create_disconnectplayer( animstruct )
{
    tempplayer = spawn( "script_model", self.origin );
    tempplayer setmodel( "tag_origin" );
    tempplayer forcenetfieldhighlod( 1 );
    tempplayer.isdisconnectplayer = 1;
    tempplayer.brexfilanimname = "player0";
    tempplayer.origin = animstruct.origin;
    tempplayer.angles = animstruct.angles;
    tempplayer create_player_rig( tempplayer.brexfilanimname, "viewhands_base_iw8", animstruct );
    
    if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) )
    {
        tempplayer create_player_rig_avatar( tempplayer.brexfilanimname, animstruct.origin );
    }
    
    tempplayer linkto( tempplayer.player_rig, "tag_player", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level thread ending_player_disconnect_thread( tempplayer, 1 );
    animstruct.winners[ 0 ] = tempplayer;
}

// Namespace br_ending_util
// Params 2
// Checksum 0x871fe86f, Offset: 0x17f2
// Size: 0xb0
function ending_player_disconnect_thread( player, skipwaittill )
{
    rig = player.player_rig;
    
    if ( !isdefined( skipwaittill ) )
    {
        player waittill( #"disconnect" );
    }
    else
    {
        wait 0.1;
    }
    
    if ( !isdefined( rig ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_bc95d8892007ebfd", 1 ) && isdefined( rig.avatar ) )
    {
        rig.avatar.playerexists = undefined;
        rig notify( #"hash_d92a6f432f33d5ed" );
        return;
    }
    
    playfxontag( utility::getfx( "player_disconnect" ), rig, "tag_player" );
}

// Namespace br_ending_util
// Params 0
// Checksum 0xd8c764be, Offset: 0x18aa
// Size: 0x51
function create_cam()
{
    model = spawn( "script_model", self.origin );
    model setmodel( "tag_origin" );
    model forcenetfieldhighlod( 1 );
    model useanimtree( #animtree );
    model.animname = "endingCam";
    return model;
}

// Namespace br_ending_util
// Params 4
// Checksum 0xe50164d5, Offset: 0x1904
// Size: 0x235
function create_player_rig( animname, rig_model, animstruct, set_ground_ref )
{
    self.animname = animname;
    origin = animstruct.origin;
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    player_rig = spawn( "script_model", origin );
    player_rig.player = self;
    self.player_rig = player_rig;
    self.player_rig setmodel( rig_model );
    self.player_rig hide();
    self.player_rig.animname = animname;
    self.player_rig useanimtree( #animtree );
    self.player_rig.winindex = self.winindex;
    self.player_rig forcenetfieldhighlod( 1 );
    self.player_rig.cinematic_motion_override = &infilexfil::handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &infilexfil::handledofnotetrack;
    
    if ( !isdefined( animstruct.player_rigs ) )
    {
        animstruct.player_rigs = [];
    }
    
    if ( isplayer( self ) )
    {
        self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        println( "<dev string:x24>" + self.name + "<dev string:x4e>" + animname + "<dev string:x5b>" + isdefined( self.player_rig ) );
        animstruct.player_rigs[ animstruct.player_rigs.size ] = self.player_rig;
        self.player_rig.playernum = self getentitynumber();
    }
    else
    {
        println( "<dev string:x63>" + animname + "<dev string:x5b>" + isdefined( self.player_rig ) );
        self.player_rig.winindex = 0;
        self.player_rig.playernum = 0;
    }
    
    self notify( #"rig_created" );
}

// Namespace br_ending_util
// Params 2
// Checksum 0xe67785de, Offset: 0x1b41
// Size: 0x1ee
function create_player_rig_avatar( animname, origin )
{
    assert( isdefined( self.player_rig ) );
    operatorskin = %"";
    gender = "";
    
    if ( isplayer( self ) && isdefined( self.operatorcustomization ) )
    {
        operatorskin = self.operatorcustomization.skinref;
        gender = self.operatorcustomization.gender;
    }
    else
    {
        operatorskin = br_infils_util::function_b331ca02076487e0();
        gender = operator::getoperatorgender( operator::function_30f20ce375c4ee40( operatorskin ) );
    }
    
    avatar = spawn( "script_model", origin );
    avatar setmodel( "fullbody_usmc_ar_br_infil" );
    avatar function_ce21f4102d5d17f6( operatorskin, "iw9_avatar_scriptable_mp" );
    avatar.operatorcustomization = spawnstruct();
    avatar.operatorcustomization.gender = gender;
    avatar hide();
    avatar.animname = animname;
    avatar.winindex = self.winindex;
    avatar forcenetfieldhighlod( 1 );
    weaponobj = weapon::buildweapon( "iw9_ar_mike4", [], "camo_none", "none" );
    weaponent = spawn( "script_weapon", origin, 0, 0, weaponobj );
    weaponent hide();
    weaponent forcenetfieldhighlod( 1 );
    weaponent linkto( avatar, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    avatar.weaponent = weaponent;
    avatar.playerexists = 1;
    avatar.forcehide = 0;
    self.player_rig.avatar = avatar;
    self.player_rig thread function_df9ee26da92cfc53();
}

// Namespace br_ending_util
// Params 0
// Checksum 0xea4826e6, Offset: 0x1d37
// Size: 0x101
function function_df9ee26da92cfc53()
{
    avatar = self.avatar;
    player = self.player;
    
    if ( isplayer( player ) )
    {
        avatar.playerexists = 1;
    }
    
    avatar.forcehide = 0;
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_d92a6f432f33d5ed" );
        
        if ( !isdefined( avatar ) )
        {
            return;
        }
        
        shouldshow = !avatar.playerexists && !avatar.forcehide;
        
        if ( shouldshow )
        {
            avatar show();
            
            if ( isdefined( avatar.weaponent ) && !avatar.forcehideweapons )
            {
                avatar.weaponent show();
            }
            
            continue;
        }
        
        avatar hide();
        
        if ( isdefined( avatar.weaponent ) )
        {
            avatar.weaponent hide();
        }
    }
}

// Namespace br_ending_util
// Params 2
// Checksum 0xf579e084, Offset: 0x1e40
// Size: 0x5a
function function_e5548380733078a6( shouldforcehide, var_2a0701d332737835 )
{
    if ( isdefined( self.avatar ) )
    {
        self.avatar.forcehide = shouldforcehide;
        self.avatar.forcehideweapons = var_2a0701d332737835;
        self notify( #"hash_d92a6f432f33d5ed" );
    }
}

// Namespace br_ending_util
// Params 0
// Checksum 0x20897341, Offset: 0x1ea2
// Size: 0xd2
function remove_player_rig()
{
    if ( isdefined( self ) )
    {
        println( "<dev string:xa3>" + self.name + "<dev string:x4e>" + self.animname + "<dev string:x5b>" + isdefined( self.player_rig ) );
        self unlink();
    }
    
    if ( isdefined( self.player_rig ) )
    {
        if ( isdefined( self.player_rig.avatar ) )
        {
            if ( isdefined( self.player_rig.avatar.weaponent ) )
            {
                self.player_rig.avatar.weaponent delete();
            }
            
            self.player_rig.avatar delete();
        }
        
        self.player_rig delete();
    }
}

// Namespace br_ending_util
// Params 1
// Checksum 0x604c9132, Offset: 0x1f7c
// Size: 0xa2
function get_center_of_array( array )
{
    center = ( 0, 0, 0 );
    
    for ( i = 0; i < array.size ; i++ )
    {
        center = ( center[ 0 ] + array[ i ].origin[ 0 ], center[ 1 ] + array[ i ].origin[ 1 ], center[ 2 ] + array[ i ].origin[ 2 ] );
    }
    
    if ( array.size != 0 )
    {
        return ( center[ 0 ] / array.size, center[ 1 ] / array.size, center[ 2 ] / array.size );
    }
}

// Namespace br_ending_util
// Params 7
// Checksum 0x6b668269, Offset: 0x2027
// Size: 0xaf
function function_37badcf00027517a( testarray, animref, animpct, originoffset, radius, height, usevehicleanimtree )
{
    newstruct = spawnstruct();
    newstruct.animref = animref;
    newstruct.animpct = animpct;
    newstruct.originoffset = originoffset;
    newstruct.cylinderradius = radius;
    newstruct.cylinderheight = height;
    newstruct.usevehicleanimtree = usevehicleanimtree;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util
// Params 7
// Checksum 0xdaa9c826, Offset: 0x20df
// Size: 0xaf
function function_382dfe458ab0a2b1( testarray, modelname, animref, animpct, originoffset, radius, usevehicleanimtree )
{
    newstruct = spawnstruct();
    newstruct.modelname = modelname;
    newstruct.animref = animref;
    newstruct.animpct = animpct;
    newstruct.originoffset = originoffset;
    newstruct.sphereradius = radius;
    newstruct.usevehicleanimtree = usevehicleanimtree;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util
// Params 8
// Checksum 0xd15eaac0, Offset: 0x2197
// Size: 0xc6
function function_4751687f65ee208c( testarray, modelname, animref, animpct, bonename, originoffset, radius, usevehicleanimtree )
{
    newstruct = spawnstruct();
    newstruct.modelname = modelname;
    newstruct.animref = animref;
    newstruct.animpct = animpct;
    newstruct.bonename = bonename;
    newstruct.originoffset = originoffset;
    newstruct.sphereradius = radius;
    newstruct.usevehicleanimtree = usevehicleanimtree;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util
// Params 7
// Checksum 0xe94b37a7, Offset: 0x2266
// Size: 0xaf
function function_687c5cf6d49f11eb( testarray, modelname, animref, originoffset, radius, numsegments, usevehicleanimtree )
{
    newstruct = spawnstruct();
    newstruct.modelname = modelname;
    newstruct.animref = animref;
    newstruct.originoffset = originoffset;
    newstruct.sphereradius = radius;
    newstruct.numsegments = numsegments;
    newstruct.usevehicleanimtree = usevehicleanimtree;
    testarray[ testarray.size ] = newstruct;
    return testarray;
}

// Namespace br_ending_util
// Params 3
// Checksum 0x27be7800, Offset: 0x231e
// Size: 0x141
function function_e89c7c78b10aa4a( fadedowntime, fadeholdtime, fadeuptime )
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
    
    if ( fadedowntime > 0 )
    {
        overlay.alpha = 0;
        overlay fadeovertime( fadedowntime );
        overlay.alpha = 1;
        wait fadedowntime;
    }
    else
    {
        overlay.alpha = 1;
    }
    
    if ( fadeholdtime > 0 )
    {
        wait fadeholdtime;
    }
    
    if ( fadeuptime > 0 )
    {
        overlay.alpha = 1;
        overlay fadeovertime( fadeuptime );
        overlay.alpha = 0;
        wait fadeuptime;
    }
    else
    {
        overlay.alpha = 0;
    }
    
    overlay destroy();
}

// Namespace br_ending_util
// Params 3
// Checksum 0x904d5b3, Offset: 0x2467
// Size: 0x160
function function_ee3a6a615e19250a( fadedowntime, fadeuptime, holdnotify )
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
    logstring( "FADE TO BLACK DEBUG:  doTransitionFadeWaitNotify fade in" );
    
    if ( fadedowntime > 0 )
    {
        overlay.alpha = 0;
        overlay fadeovertime( fadedowntime );
        overlay.alpha = 1;
        wait fadedowntime;
    }
    else
    {
        overlay.alpha = 1;
    }
    
    if ( isdefined( holdnotify ) )
    {
        thread transitionfailsafe( holdnotify );
        level waittill( holdnotify );
    }
    
    if ( fadeuptime > 0 )
    {
        overlay.alpha = 1;
        overlay fadeovertime( fadeuptime );
        overlay.alpha = 0;
        wait fadeuptime;
    }
    else
    {
        overlay.alpha = 0;
    }
    
    logstring( "FADE TO BLACK DEBUG:  doTransitionFadeWaitNotify fade out" );
    overlay destroy();
}

// Namespace br_ending_util
// Params 1
// Checksum 0x1ab81fce, Offset: 0x25cf
// Size: 0x45
function transitionfailsafe( holdnotify )
{
    level endon( holdnotify );
    
    if ( getdvarint( @"hash_d7e726b893e2a09a", 1 ) )
    {
        wait getdvarfloat( @"hash_2e838809e002cd8e", 12 );
        logstring( "FADE TO BLACK DEBUG:  transitionFailsafe hit" );
        level notify( holdnotify );
    }
}

// Namespace br_ending_util
// Params 1
// Checksum 0x3843667b, Offset: 0x261c
// Size: 0x90
function function_9711748a5c6c12c3( transientname )
{
    loadinfiltransient( transientname );
    setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
    logstring( "Exfil Transient Loading - " + transientname );
    var_9c9751620202d0b9 = 0;
    timeout = gettime() + getdvarint( @"hash_aa82e0f29875efdd", 10500 );
    
    while ( !var_9c9751620202d0b9 && gettime() < timeout )
    {
        waitframe();
        var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( transientname );
    }
    
    logstring( "Exfil Transient Loaded - " + transientname + ", timeout = " + ( gettime() >= timeout ) );
}

