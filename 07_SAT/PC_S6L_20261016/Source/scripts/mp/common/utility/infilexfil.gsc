// scripts\mp\common\utility\infilexfil.gsc  (hash_7f744468f2c6a371.gscc) (size: 18941 Bytes / 0x49fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe27647b (3190252667)
// size ...... 18941 (0x49fd)
// includes .. 6   (offset: 0x4699)
// strings ... 44  (offset: 0x46c9)
// dev strs .. 15  (offset: 0x4939)
// exports ... 46  (offset: 0x31d5)
// cseg ...... 0x692 + 0x2b43 (0x31d5)
// imports ... 103 (offset: 0x3905)
// animtree1 . 1   (offset: 0x49f1)
// animtree2 . 0   (offset: 0x49fd)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;

#namespace infilexfil;

// Namespace infilexfil
// Params 0
// Checksum 0xb99b29d1, Offset: 0x6b0
// Size: 0x106
function function_b466622b2e40ba1()
{
    brinfils = getscriptbundlenames( #"brinfil" );
    
    foreach ( brinfil in brinfils )
    {
        values = getscriptbundlefieldvalues( brinfil, [ #"hash_1f23721f6d7d1cb4", #"hash_32567649fda74cfb" ] );
        
        if ( values.var_6f9b41f7dd7d93f3 && values.var_394fd6963d38cbac )
        {
            c130 = getent( values.var_394fd6963d38cbac, "targetname" );
            
            if ( isdefined( c130 ) )
            {
                if ( isbrgamemode() )
                {
                    c130 hide();
                    continue;
                }
                
                c130 delete();
            }
        }
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x452518b1, Offset: 0x7be
// Size: 0xde
function getinfilpath( targetname )
{
    paths = utility::getstructarray( targetname, "targetname" );
    
    if ( !isdefined( paths ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    foreach ( path in paths )
    {
        if ( level.interactiveinfil )
        {
            if ( path.script_noteworthy == "interactive" )
            {
                return path;
            }
            
            continue;
        }
        
        if ( path.script_noteworthy != "interactive" )
        {
            return path;
        }
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x151ae333, Offset: 0x8a4
// Size: 0x51
function player_unlink( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    if ( player islinked() )
    {
        player unlink();
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x87e6cd12, Offset: 0x8fd
// Size: 0x5c
function player_free_look( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    if ( player islinked() )
    {
        player lerpviewangleclamp( 0, 0, 0, 45, 45, 45, 45 );
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x833f8d43, Offset: 0x961
// Size: 0x4d
function player_fov_80_instant( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player lerpfovbypreset( "80_instant" );
}

// Namespace infilexfil
// Params 1
// Checksum 0xdc94503b, Offset: 0x9b6
// Size: 0x4d
function player_fov_default_1( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player lerpfovbypreset( "zombiearcade" );
}

// Namespace infilexfil
// Params 1
// Checksum 0xc97e45e8, Offset: 0xa0b
// Size: 0x60
function player_fov_default_2( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    if ( isplayer( player ) || isagent( player ) )
    {
        player lerpfovbypreset( "default_2seconds" );
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x669c3a58, Offset: 0xa73
// Size: 0x61
function player_lock_look_1_second( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    if ( player islinked() )
    {
        player lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0xe8133db8, Offset: 0xadc
// Size: 0x61
function player_lock_look_2_second( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    if ( player islinked() )
    {
        player lerpviewangleclamp( 2, 0.5, 0.5, 0, 0, 0, 0 );
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x7fe896a8, Offset: 0xb45
// Size: 0x58
function player_lock_look_instant( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    if ( player islinked() )
    {
        player lerpviewangleclamp( 0, 0, 0, 0, 0, 0, 0 );
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x21db029, Offset: 0xba5
// Size: 0x5e
function rumble_low( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread updateshakeonplayer( undefined, undefined, undefined, undefined, undefined, "mig_rumble", 0.05, 0.1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x9edd6eb6, Offset: 0xc0b
// Size: 0x73
function cam_shake_low( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread updateshakeonplayer( 0.06, 0.075, 2, player.origin, 8000, "mig_rumble", 0.05, 0.1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x589ad028, Offset: 0xc86
// Size: 0x6f
function cam_shake_running( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread updateshakeonplayer( 0.09, 0.115, 2, player.origin, 8000, undefined, 0.15, 0.5 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x119d9aec, Offset: 0xcfd
// Size: 0x72
function cam_shake_parked( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread updateshakeonplayer( 0.065, 0.09, 0.5, player.origin, 8000, undefined, 0.15, 0.5 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xe5243e06, Offset: 0xd77
// Size: 0x4e
function cam_shake_off( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player notify( #"hash_d4693469e96d92a0" );
}

// Namespace infilexfil
// Params 8
// Checksum 0xca700cc0, Offset: 0xdcd
// Size: 0xe5
function updateshakeonplayer( quakemin, quakemax, quakedur, quakeorg, quakeradius, rumblename, waitmin, waitmax )
{
    if ( level.interactiveinfil && self.interactivecombat )
    {
        return;
    }
    
    self notify( #"hash_d4693469e96d92a0" );
    self endon( #"hash_d4693469e96d92a0" );
    level endon( #"prematch_over" );
    level endon( #"infil_done" );
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( self ) )
    {
        if ( isdefined( quakemin ) && isdefined( quakemax ) )
        {
            self earthquakeforplayer( randomfloatrange( quakemin, quakemax ), quakedur, quakeorg, quakeradius );
        }
        
        if ( isdefined( rumblename ) )
        {
            self playrumbleonpositionforclient( rumblename, self.origin );
        }
        
        wait randomfloatrange( waitmin, waitmax );
    }
}

// Namespace infilexfil
// Params 0
// Checksum 0x549a0240, Offset: 0xeba
// Size: 0x88
function hideactors()
{
    if ( !isdefined( self.actors ) )
    {
        return;
    }
    
    foreach ( actor in self.actors )
    {
        actor hide();
    }
}

// Namespace infilexfil
// Params 0
// Checksum 0x1d97e756, Offset: 0xf4a
// Size: 0x88
function showactors()
{
    if ( !isdefined( self.actors ) )
    {
        return;
    }
    
    foreach ( actor in self.actors )
    {
        actor show();
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0xe88b19c, Offset: 0xfda
// Size: 0x4d
function setcinematicmotion_heli( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player setcinematicmotionoverride( "player_heli_ride" );
}

// Namespace infilexfil
// Params 1
// Checksum 0x3c9511ad, Offset: 0x102f
// Size: 0x4d
function setcinematicmotion_playermotion( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player setcinematicmotionoverride( "iw9_playermotion" );
}

// Namespace infilexfil
// Params 1
// Checksum 0x232fe515, Offset: 0x1084
// Size: 0x4d
function setcinematicmotion_disabled( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player setcinematicmotionoverride( "disabled" );
}

// Namespace infilexfil
// Params 1
// Checksum 0xafd8ea7b, Offset: 0x10d9
// Size: 0x40
function set_cinematicmotionomnvaroverrides( value )
{
    self setclientomnvar( "handheld_camera_rotation_move_mod_override", value );
    self setclientomnvar( "handheld_camera_rotation_view_mod_override", value );
    self setclientomnvar( "handheld_camera_translation_move_mod_override", value );
    self setclientomnvar( "handheld_camera_translation_view_mod_override", value );
}

// Namespace infilexfil
// Params 3
// Checksum 0xa45ae51f, Offset: 0x1121
// Size: 0xd2
function set_cinematicmotionomnvarovertime( startval, endval, duration )
{
    self endon( #"death_or_disconnect" );
    currenttime = gettime();
    duration *= 1000;
    endtime = int( currenttime + duration );
    diff = abs( startval - endval );
    
    while ( true )
    {
        currenttime = gettime();
        t = clamp( 1 - ( endtime - currenttime ) / duration, 0, 1 );
        frac = startval < endval ? diff * t + startval : startval - diff * t;
        set_cinematicmotionomnvaroverrides( frac );
        
        if ( t == 1 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0xc81e26c3, Offset: 0x11fb
// Size: 0x4f
function setcinematicmotion_omnvaroverride_max_instant( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player set_cinematicmotionomnvaroverrides( 1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xa88b9c9d, Offset: 0x1252
// Size: 0x59
function setcinematicmotion_omnvaroverride_max_1( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 0, 1, 1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x4e02cd27, Offset: 0x12b3
// Size: 0x59
function setcinematicmotion_omnvaroverride_max_2( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 0, 1, 2 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x3945fdb1, Offset: 0x1314
// Size: 0x59
function setcinematicmotion_omnvaroverride_max_3( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 0, 1, 3 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xa7e16812, Offset: 0x1375
// Size: 0x59
function setcinematicmotion_omnvaroverride_max_4( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 0, 1, 4 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xd0c65884, Offset: 0x13d6
// Size: 0x59
function setcinematicmotion_omnvaroverride_max_5( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 0, 1, 5 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x3b935dcc, Offset: 0x1437
// Size: 0x4f
function setcinematicmotion_omnvaroverride_min_instant( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player set_cinematicmotionomnvaroverrides( 0 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x75946bb0, Offset: 0x148e
// Size: 0x59
function setcinematicmotion_omnvaroverride_min_1( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 1, 0, 1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x931d3a0a, Offset: 0x14ef
// Size: 0x59
function setcinematicmotion_omnvaroverride_min_2( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 1, 0, 2 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xe45a0a9c, Offset: 0x1550
// Size: 0x59
function setcinematicmotion_omnvaroverride_min_3( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 1, 0, 3 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x7afe9f3f, Offset: 0x15b1
// Size: 0x59
function setcinematicmotion_omnvaroverride_min_4( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 1, 0, 4 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xdd9afa9, Offset: 0x1612
// Size: 0x59
function setcinematicmotion_omnvaroverride_min_5( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player thread set_cinematicmotionomnvarovertime( 1, 0, 5 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xc53a67f3, Offset: 0x1673
// Size: 0x53
function player_equip_nvg( guy )
{
    if ( !utility::function_2a082dafe6f4bd5b() )
    {
        return;
    }
    
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    player nightvisionviewon();
}

// Namespace infilexfil
// Params 1
// Checksum 0xdb95f0b4, Offset: 0x16ce
// Size: 0x11b
function getgroundcompensationheight( guy )
{
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.player ) )
    {
        player = guy.player;
    }
    else
    {
        player = guy;
    }
    
    currentz = player.origin[ 2 ];
    contents = trace::create_solid_ai_contents( 1 );
    startpos = player.origin + 12 * ( 0, 0, 1 );
    endpos = player.origin - 24 * ( 0, 0, 1 );
    groundpos = trace::player_trace( startpos, endpos, player.angles, [ player, player.infil.linktoent ], contents )[ "position" ];
    groundz = groundpos[ 2 ];
    player.infilheightcompensation = groundz - currentz;
}

// Namespace infilexfil
// Params 0
// Checksum 0x42724c52, Offset: 0x17f1
// Size: 0xf3
function compensatetoground()
{
    level endon( #"prematch_over" );
    self endon( #"death_or_disconnect" );
    var_fe3ef0ee00518bc7 = 0;
    self.personalscenenode unlink();
    
    while ( isdefined( self.personalscenenode ) )
    {
        getgroundcompensationheight( self.player_rig );
        var_d11398e27cfccdd1 = ( self.personalscenenode.origin[ 0 ], self.personalscenenode.origin[ 1 ], self.personalscenenode.origin[ 2 ] + self.infilheightcompensation );
        
        if ( abs( var_fe3ef0ee00518bc7 - self.infilheightcompensation ) > 0.01 )
        {
            var_fe3ef0ee00518bc7 = self.infilheightcompensation;
            self.personalscenenode moveto( var_d11398e27cfccdd1, 0.25, 0.05, 0.2 );
        }
        
        waitframe();
    }
}

#using_animtree( "script_model" );

// Namespace infilexfil
// Params 5
// Checksum 0x3a915014, Offset: 0x18ec
// Size: 0x2d6
function infil_player_rig_updated( animname, spawnpos, spawnang, unlinkvelocity, takegunless = 1 )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    if ( !( self.var_cb3ce103d58a19f6 ?? 0 ) )
    {
        self function_e19ccf4da1a61ba7( spawnpos );
        self.var_cb3ce103d58a19f6 = 1;
    }
    
    player_rig = spawn( "script_arms", spawnpos, 0, 0, self );
    player_rig.angles = spawnang;
    player_rig.player = self;
    self.player_rig = player_rig;
    self.player_rig hide( 1 );
    self.player_rig.animname = animname;
    self.player_rig useanimtree( #animtree );
    self.player_rig.updatedversion = 1;
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    self.player_rig.cinematic_motion_override = &handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &handledofnotetrack;
    var_cfaa30c5137a59a3 = self.player_rig gettagangles( "tag_camera_scripted" );
    
    if ( getdvarint( @"hash_7b07a2b6dabbfd16", 1 ) == 1 )
    {
        var_cfaa30c5137a59a3 = ( var_cfaa30c5137a59a3[ 0 ], var_cfaa30c5137a59a3[ 1 ], 0 );
    }
    
    self setplayerangles( var_cfaa30c5137a59a3 );
    self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    println( "<dev string:x3f>" + self.name + "<dev string:x75>" + animname + "<dev string:x82>" + isdefined( self.player_rig ) + "<dev string:x91>" + self.player_rig.updatedversion );
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( level.gameended || !isdefined( self ) )
    {
        return;
    }
    
    println( "<dev string:xa4>" + self.name + "<dev string:xd7>" + animname + "<dev string:xe4>" + isdefined( self.player_rig ) );
    
    if ( isdefined( unlinkvelocity ) )
    {
        self playerunlinkvelocity( unlinkvelocity );
    }
    else
    {
        self unlink();
    }
    
    if ( takegunless )
    {
        thread inventory_utility::takegunlessweapon();
    }
    
    if ( isdefined( player_rig ) )
    {
        if ( isdefined( player_rig.var_f7ce4eecb40898f ) )
        {
            player_rig.var_f7ce4eecb40898f delete();
        }
        
        player_rig delete();
    }
    
    self notify( #"rig_cleanup" );
}

// Namespace infilexfil
// Params 1
// Checksum 0xbae146ef, Offset: 0x1bca
// Size: 0xbd6
function handledofnotetrack( type )
{
    if ( !( isdefined( self ) && isdefined( self.player ) ) )
    {
        return;
    }
    
    switch ( type )
    {
        case #"hash_4ec2c14f2118f275":
            self.player enablephysicaldepthoffieldscripting();
            
            switch ( self.animname )
            {
                case #"hash_9f02a28a98823bce":
                    self.player setphysicaldepthoffield( 1.9, 50, 20, 20 );
                    break;
                case #"hash_9f02a38a98823d61":
                    self.player setphysicaldepthoffield( 1.9, 50, 20, 20 );
                    break;
                case #"hash_9f02a08a988238a8":
                    self.player setphysicaldepthoffield( 2.2, 70, 20, 20 );
                    break;
                case #"hash_9f02a18a98823a3b":
                    self.player setphysicaldepthoffield( 2.2, 70, 20, 20 );
                    break;
                case #"hash_9f02a68a9882421a":
                    self.player setphysicaldepthoffield( 2.2, 60, 20, 20 );
                    break;
                case #"hash_9f02a78a988243ad":
                    self.player setphysicaldepthoffield( 2.2, 60, 20, 20 );
                    break;
            }
            
            break;
        case #"hash_411d0bd57be3a71d":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
        case #"hash_76a3cb4c3b753bf":
            self.player enablephysicaldepthoffieldscripting();
            
            switch ( self.animname )
            {
                case #"hash_9f02a28a98823bce":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case #"hash_9f02a38a98823d61":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case #"hash_9f02a08a988238a8":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case #"hash_9f02a18a98823a3b":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case #"hash_9f02a68a9882421a":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
                case #"hash_9f02a78a988243ad":
                    self.player setphysicaldepthoffield( 2.4, 50, 20, 20 );
                    break;
            }
            
            break;
        case #"hash_47f397a041d6f287":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
        case #"hash_cf5920097f34bf5f":
            self.player enablephysicaldepthoffieldscripting();
            
            switch ( self.animname )
            {
                case #"hash_9f02a28a98823bce":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case #"hash_9f02a38a98823d61":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case #"hash_9f02a08a988238a8":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case #"hash_9f02a18a98823a3b":
                    self.player setphysicaldepthoffield( 2.1, 40, 20, 20 );
                    break;
                case #"hash_9f02a68a9882421a":
                    self.player setphysicaldepthoffield( 2.3, 60, 20, 20 );
                    break;
                case #"hash_9f02a78a988243ad":
                    self.player setphysicaldepthoffield( 2.3, 60, 20, 20 );
                    break;
            }
            
            break;
        case #"hash_2ae5939ed559cf27":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
        case #"hash_517726d59c8d65d8":
            self.player enablephysicaldepthoffieldscripting();
            
            switch ( self.animname )
            {
                case #"hash_9f02a28a98823bce":
                    self.player setphysicaldepthoffield( 4, 100, 20, 20 );
                    break;
                case #"hash_9f02a38a98823d61":
                    self.player setphysicaldepthoffield( 4, 100, 20, 20 );
                    break;
                case #"hash_9f02a08a988238a8":
                    self.player setphysicaldepthoffield( 4.8, 70, 20, 20 );
                    break;
                case #"hash_9f02a18a98823a3b":
                    self.player setphysicaldepthoffield( 4.8, 70, 20, 20 );
                    break;
                case #"hash_9f02a68a9882421a":
                    self.player setphysicaldepthoffield( 4.8, 80, 20, 20 );
                    break;
                case #"hash_9f02a78a988243ad":
                    self.player setphysicaldepthoffield( 4.8, 80, 20, 20 );
                    break;
                case #"hash_9f02a48a98823ef4":
                    self.player setphysicaldepthoffield( 4.8, 90, 20, 20 );
                    break;
                case #"hash_9f02a58a98824087":
                    self.player setphysicaldepthoffield( 4.8, 90, 20, 20 );
                    break;
                case #"hash_9f029a8a98822f36":
                    self.player setphysicaldepthoffield( 5.6, 100, 20, 20 );
                    break;
                case #"hash_9f029b8a988230c9":
                    self.player setphysicaldepthoffield( 5.6, 100, 20, 20 );
                    break;
                case #"hash_d364c42e15068683":
                    self.player setphysicaldepthoffield( 5.6, 60, 20, 20 );
                    break;
                case #"hash_d364c32e150684f0":
                    self.player setphysicaldepthoffield( 5.6, 60, 20, 20 );
                    break;
                case #"hash_d364c62e150689a9":
                    self.player setphysicaldepthoffield( 5.6, 70, 20, 20 );
                    break;
                case #"hash_d364c52e15068816":
                    self.player setphysicaldepthoffield( 5.6, 70, 20, 20 );
                    break;
                case #"hash_d364c82e15068ccf":
                    self.player setphysicaldepthoffield( 5.6, 80, 20, 20 );
                    break;
                case #"hash_d364c72e15068b3c":
                    self.player setphysicaldepthoffield( 5.6, 80, 20, 20 );
                    break;
                case #"hash_d364ca2e15068ff5":
                    self.player setphysicaldepthoffield( 5.6, 80, 20, 20 );
                    break;
                case #"hash_d364c92e15068e62":
                    self.player setphysicaldepthoffield( 5.6, 80, 20, 20 );
                    break;
                case #"hash_d364cc2e1506931b":
                    self.player setphysicaldepthoffield( 5.6, 90, 20, 20 );
                    break;
                case #"hash_d364cb2e15069188":
                    self.player setphysicaldepthoffield( 5.6, 90, 20, 20 );
                    break;
            }
            
            break;
        case #"hash_e32097fc4efa5138":
            self.player enablephysicaldepthoffieldscripting();
            self.player setphysicaldepthoffield( 2.8, 500, 4, 4 );
            break;
        case #"hash_a65609faf77c04b7":
            self.player enablephysicaldepthoffieldscripting();
            
            switch ( self.animname )
            {
                case #"hash_9f02a28a98823bce":
                    self.player setphysicaldepthoffield( 2.2, 500, 50, 50 );
                    break;
                case #"hash_9f02a38a98823d61":
                    self.player setphysicaldepthoffield( 2.2, 500, 50, 50 );
                    break;
                case #"hash_9f02a08a988238a8":
                    self.player setphysicaldepthoffield( 2.2, 500, 50, 50 );
                    break;
                case #"hash_9f02a18a98823a3b":
                    self.player setphysicaldepthoffield( 2.2, 500, 50, 50 );
                    break;
                case #"hash_9f02a68a9882421a":
                    self.player setphysicaldepthoffield( 2.2, 500, 50, 50 );
                    break;
                case #"hash_9f02a78a988243ad":
                    self.player setphysicaldepthoffield( 2.2, 500, 50, 50 );
                    break;
            }
            
            break;
        case #"hash_625d6429b07451ec":
            self.player enablephysicaldepthoffieldscripting();
            
            switch ( self.animname )
            {
                case #"hash_9f02a28a98823bce":
                    self.player setphysicaldepthoffield( 2.2, 50, 50, 50 );
                    break;
                case #"hash_9f02a38a98823d61":
                    self.player setphysicaldepthoffield( 2.2, 40, 50, 50 );
                    break;
                case #"hash_9f02a08a988238a8":
                    self.player setphysicaldepthoffield( 2.2, 40, 50, 50 );
                    break;
                case #"hash_9f02a18a98823a3b":
                    self.player setphysicaldepthoffield( 2.2, 45, 50, 50 );
                    break;
                case #"hash_9f02a68a9882421a":
                    self.player setphysicaldepthoffield( 2.2, 45, 50, 50 );
                    break;
                case #"hash_9f02a78a988243ad":
                    self.player setphysicaldepthoffield( 2.2, 40, 50, 50 );
                    break;
                case #"hash_9f02a48a98823ef4":
                    self.player setphysicaldepthoffield( 2.2, 50, 50, 50 );
                    break;
                case #"hash_9f02a58a98824087":
                    self.player setphysicaldepthoffield( 2.2, 50, 50, 50 );
                    break;
                case #"hash_9f029a8a98822f36":
                    self.player setphysicaldepthoffield( 2.2, 50, 50, 50 );
                    break;
                case #"hash_9f029b8a988230c9":
                    self.player setphysicaldepthoffield( 2.2, 50, 50, 50 );
                    break;
                case #"hash_d364c42e15068683":
                    self.player setphysicaldepthoffield( 2.2, 50, 50, 50 );
                    break;
            }
            
            break;
        case #"hash_23d3b48a2fabf145":
            self.player disablephysicaldepthoffieldscripting();
            break;
        default:
            properties = strtok( type, "," );
            player = self.player ?? self;
            
            if ( properties.size >= 2 )
            {
                player enablephysicaldepthoffieldscripting();
                player setphysicaldepthoffield( float( properties[ 0 ] ?? 0 ), float( properties[ 1 ] ?? 0 ), float( properties[ 2 ] ?? 0 ), float( properties[ 3 ] ?? 0 ) );
            }
            else
            {
                var_fa3b8d0109b9108f = int( properties[ 0 ] );
                
                if ( var_fa3b8d0109b9108f == 65 )
                {
                    player disablephysicaldepthoffieldscripting();
                    
                    if ( !player.var_62bbe9eeb1139562 )
                    {
                        player.var_62bbe9eeb1139562 = 1;
                        player lerpfov( 65, 2 );
                        player lerpfovscalefactor( player.var_a892a7a5b2c8b016 ?? 1, 2 );
                    }
                }
                else if ( var_fa3b8d0109b9108f )
                {
                    player lerpfov( var_fa3b8d0109b9108f, 0 );
                    player lerpfovscalefactor( 0, 0 );
                }
            }
            
            break;
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x224d1ec1, Offset: 0x27a8
// Size: 0x181
function handlecinematicmotionnotetrack( cmtype )
{
    if ( !( isdefined( self ) && isdefined( self.player ) ) )
    {
        return;
    }
    
    prefix = getsubstr( cmtype, 0, 4 );
    
    if ( prefix == "set_" )
    {
        override = getsubstr( cmtype, 4 );
        self.player setcinematicmotionoverride( override );
        return;
    }
    
    switch ( cmtype )
    {
        case #"hash_a6c78cbbbff2556b":
            setcinematicmotion_omnvaroverride_max_instant( self );
            break;
        case #"hash_299b5843a6ce39d9":
            setcinematicmotion_omnvaroverride_max_1( self );
            break;
        case #"hash_299b5543a6ce3520":
            setcinematicmotion_omnvaroverride_max_2( self );
            break;
        case #"hash_299b5643a6ce36b3":
            setcinematicmotion_omnvaroverride_max_3( self );
            break;
        case #"hash_299b5b43a6ce3e92":
            setcinematicmotion_omnvaroverride_max_4( self );
            break;
        case #"hash_299b5c43a6ce4025":
            setcinematicmotion_omnvaroverride_max_5( self );
            break;
        case #"hash_68b242ebbe127151":
            setcinematicmotion_omnvaroverride_min_instant( self );
            break;
        case #"hash_519726130b56caab":
            setcinematicmotion_omnvaroverride_min_1( self );
            break;
        case #"hash_519727130b56cc3e":
            setcinematicmotion_omnvaroverride_min_2( self );
            break;
        case #"hash_519728130b56cdd1":
            setcinematicmotion_omnvaroverride_min_3( self );
            break;
        case #"hash_519729130b56cf64":
            setcinematicmotion_omnvaroverride_min_4( self );
            break;
        case #"hash_51972a130b56d0f7":
            setcinematicmotion_omnvaroverride_min_5( self );
            break;
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x43647c36, Offset: 0x2931
// Size: 0x654
function handleweaponstatenotetrack( state )
{
    if ( !( isdefined( self ) && isdefined( self.player ) ) )
    {
        return;
    }
    
    self.player endon( #"death_or_disconnect" );
    
    switch ( state )
    {
        case #"hash_30b20a099c3735ec":
            println( "<dev string:xec>" + self.player.name + "<dev string:x91>" + self.updatedversion + "<dev string:x127>" + self.player islinked() );
            self.player setdemeanorviewmodel( "normal" );
            self.player utility::ent_flag_init( "swapLoadout_blocked" );
            self.player utility::ent_flag_init( "swapLoadout_pending" );
            self.player utility::ent_flag_init( "swapLoadout_complete" );
            self.player utility::ent_flag_set( "swapLoadout_blocked" );
            self.player thread cleanupswaploadoutflags();
            
            if ( !isai( self.player ) && isdefined( self ) && isdefined( self.player ) && isalive( self.player ) )
            {
                self.player inventory_utility::givegunlessweapon();
            }
            
            if ( self.updatedversion )
            {
                println( "<dev string:x134>" + self.player.name );
                self showonlytoplayer( self.player );
            }
            else
            {
                println( "<dev string:x17c>" + self.player.name );
            }
            
            if ( isdefined( self.player ) )
            {
                self.player val::set( "notetrack_drop", "reload", 0 );
            }
            
            break;
        case #"hash_5281b0cd075003":
            if ( isdefined( self.player.infilweapon ) && self.player hasweapon( self.player.infilweapon ) )
            {
                self.player inventory_utility::_takeweapon( self.player.infilweapon );
            }
            
            self.player.infilweaponraise = 1;
            
            if ( self.player utility::ent_flag_exist( "swapLoadout_blocked" ) && self.player utility::ent_flag( "swapLoadout_blocked" ) )
            {
                self.player utility::ent_flag_clear( "swapLoadout_blocked" );
            }
            
            self.player setdemeanorviewmodel( "normal" );
            
            if ( !self.updatedversion )
            {
                self.player stopviewmodelanim();
            }
            
            if ( utility::issharedfuncdefined( #"player", #"hash_99817435900eafd7" ) )
            {
                self.player [[ utility::getsharedfunc( #"player", #"hash_99817435900eafd7" ) ]]();
            }
            
            if ( !isai( self.player ) )
            {
                self.player inventory_utility::takegunlessweapon();
            }
            
            if ( self.updatedversion && self.player islinked() )
            {
                self.player playerlinkedsetforceparentvisible( 0 );
            }
            
            self.player val::reset_all( "notetrack_drop" );
            break;
        case #"hash_9682e089e580b4b8":
            if ( isdefined( self.var_485fdf94290bd0fa ) )
            {
                self.player setdemeanorviewmodel( "normal" );
                wait 0.05;
                self.player setdemeanorviewmodel( "safe", self.var_485fdf94290bd0fa );
            }
            else
            {
                self.player setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe" );
            }
            
            break;
        case #"hash_9c964a6cbaac0576":
            if ( !isai( self ) )
            {
                self showonlytoplayer( self.player );
            }
            
            self.player setdemeanorviewmodel( "normal" );
            wait 0.05;
            self.player setdemeanorviewmodel( "safe", "iw9_ges_demeanor_safe_van_gundown" );
            self.var_485fdf94290bd0fa = "iw8_ges_demeanor_safe_van";
            break;
        case #"hash_14c87da9a703f912":
            if ( !isai( self ) )
            {
                self showonlytoplayer( self.player );
            }
            
            self.player setdemeanorviewmodel( "relaxed", "iw9_ges_demeanor_safe_van_gundown" );
            self.var_485fdf94290bd0fa = "iw8_ges_demeanor_safe_van";
            break;
        case #"hash_84fcf5e68d7230b2":
            self.player setdemeanorviewmodel( "normal" );
            break;
        case #"hash_a8f0b714fb0cb53b":
            self.player val::reset_all( "notetrack_hold" );
            break;
        case #"hash_dd93195493d0c818":
            self.player val::set( "notetrack_hold", "fire", 0 );
            self.player val::set( "notetrack_hold", "ads", 0 );
            self.player val::set( "notetrack_hold", "reload", 0 );
            break;
        case #"hash_1e3d8afe88d3b4f":
            if ( !isai( self.player ) )
            {
                self showonlytoplayer( self.player );
                
                if ( isdefined( self.player.infilweapon ) )
                {
                    self.var_f7ce4eecb40898f = self.player dropitem( self.player.infilweapon );
                }
                else
                {
                    self.var_f7ce4eecb40898f = self.player dropitem( self.player.lastdroppableweaponobj );
                }
                
                self.var_f7ce4eecb40898f showonlytoplayer( self.player );
                self.var_f7ce4eecb40898f linkto( self.player, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            
            break;
        case #"hash_dd0c557fa98ca956":
            if ( !isai( self.player ) )
            {
                if ( isdefined( self.var_f7ce4eecb40898f ) )
                {
                    self.var_f7ce4eecb40898f delete();
                }
            }
            
            break;
    }
}

// Namespace infilexfil
// Params 0
// Checksum 0x558a1df9, Offset: 0x2f8d
// Size: 0x4b
function cleanupswaploadoutflags()
{
    self endon( #"disconnect" );
    utility::waittill_any_ents( self, "death", level, "prematch_over" );
    utility::ent_flag_clear( "swapLoadout_blocked", 1 );
    utility::ent_flag_clear( "swapLoadout_pending", 1 );
    utility::ent_flag_clear( "swapLoadout_complete", 1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0xff5adfe9, Offset: 0x2fe0
// Size: 0xe9
function function_effadc1d337cc03f( vehicle )
{
    if ( isdefined( vehicle.infil.type ) )
    {
        switch ( vehicle.infil.type )
        {
            case #"hash_84cf3499469c73f9":
            case #"hash_ffbece8c8ed62d87":
                return "heli";
            case #"hash_3147dc8dc0e0168e":
            case #"hash_6acd072bc2514d60":
                return "bigheli";
            case #"hash_9cca7c109971cb":
            case #"hash_7fc07a30c0958e55":
                return "truck";
            case #"hash_216654e0e29260df":
            case #"hash_34c49a3fbd94f043":
            case #"hash_a1ff4c2b58ee2047":
            case #"hash_ab94c4e0a50be6d3":
                return "car";
            default:
                return "generic";
        }
    }
    
    return "generic";
}

// Namespace infilexfil
// Params 3
// Checksum 0x839aee84, Offset: 0x30d2
// Size: 0x103
function function_72938eb66da2e44b( structname, effectname, waittime )
{
    level endon( #"game_ended" );
    effectstruct = utility::getstructarray( structname, "script_noteworthy" );
    
    if ( !isdefined( effectstruct ) )
    {
        assertmsg( "<dev string:x1e9>" + structname + "<dev string:x213>" + game_utility::getmapname() + "<dev string:x224>" );
        return;
    }
    
    titlefwd = anglestoforward( effectstruct[ 0 ].angles );
    var_a80e97dbe68588ae = effectstruct[ 0 ].origin;
    
    if ( getdvarint( @"infil_debug_display" ) == 1 )
    {
        thread debug_utility::drawsphere( var_a80e97dbe68588ae, 5, 60, ( 0, 1, 0 ) );
        thread debug_utility::drawangles( var_a80e97dbe68588ae, var_a80e97dbe68588ae + 4 * titlefwd, 60, ( 0, 1, 0 ) );
    }
    
    wait waittime;
    playfx( level._effect[ effectname ], var_a80e97dbe68588ae, titlefwd );
}

