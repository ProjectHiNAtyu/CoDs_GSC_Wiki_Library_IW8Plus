// scripts\mp\gametypes\wm_buildable.gsc  (hash_28144ebcb239e561.gscc) (size: 24553 Bytes / 0x5fe9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x14b154e9 (347165929)
// size ...... 24553 (0x5fe9)
// includes .. 19  (offset: 0x594d)
// strings ... 84  (offset: 0x59e5)
// dev strs .. 16  (offset: 0x5f19)
// exports ... 61  (offset: 0x3ad9)
// cseg ...... 0x611 + 0x34c8 (0x3ad9)
// imports ... 168 (offset: 0x4461)
// animtree1 . 0   (offset: 0x5fe9)
// animtree2 . 0   (offset: 0x5fe9)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_safecrack_quest;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;

#namespace wm_buildable;

// Namespace wm_buildable
// Params 0
// Checksum 0x5b0a4360, Offset: 0x62f
// Size: 0x50, Type: bool
function function_7a76ffb01722e5e1()
{
    if ( !function_c9f9d65349132307() )
    {
        return false;
    }
    
    level.var_b8373a77bd36aa7d = &function_b8373a77bd36aa7d;
    gamelogic_mp::setwaypointiconinfo( "waypoint_Buildable_ToBuild", 1, "neutral", undefined, "ui_icon_minimap_warmode_buildable_empty" );
    gamelogic_mp::setwaypointiconinfo( "waypoint_Buildable_Built", 1, "neutral", undefined, "ui_icon_minimap_warmode_buildable_teardown" );
    return true;
}

// Namespace wm_buildable
// Params 0
// Checksum 0x22135a62, Offset: 0x688
// Size: 0xf
function function_c9f9d65349132307()
{
    return dvars::function_13909a5327c395b9( "buildableEnabled", 1 );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xb78195da, Offset: 0x6a0
// Size: 0x35
function function_b8373a77bd36aa7d( animname )
{
    if ( animname == "EarthenWall" || animname == "Hesco" || animname == "TankTrap" )
    {
        return "slow";
    }
}

// Namespace wm_buildable
// Params 6
// Checksum 0xc2d7224b, Offset: 0x6de
// Size: 0x4fb
function function_b1b8c1bd62c625bf( objname, triggerent, zonename, currentprogress, origin, angles )
{
    if ( !isdefined( level.buildables ) )
    {
        level.buildables = [];
    }
    
    buildinfo = level.buildablepool[ objname ];
    buildable = spawnstruct();
    buildable.name = objname;
    buildable.triggerent = triggerent;
    buildable.triggeroutline = triggerent.outline;
    buildable.zonename = zonename;
    buildable.id = triggerent.script_label;
    useobject = function_a4d5088e0f45a9ba( triggerent, buildinfo.hintstring, buildinfo.buildusetime, buildinfo.buildteam, buildinfo.var_b1bcdf4caa00e49 );
    buildable.useobj = useobject;
    useobject.buildable = buildable;
    buildable.gestureweapon = buildinfo.gestureweapon;
    buildable.var_33237f45f5760876 = buildinfo.var_33237f45f5760876;
    buildable.var_6a7941b3aef1c16 = buildinfo.var_6a7941b3aef1c16;
    buildable.var_3b45d6c373f01b69 = buildinfo.var_3b45d6c373f01b69;
    buildable.var_ebd73781da1158ea = buildinfo.var_ebd73781da1158ea;
    buildable.phases = [ 0, 1 ];
    
    if ( isdefined( buildinfo.phases ) )
    {
        buildable.phases = buildinfo.phases;
    }
    
    buildable.buildphase = 0;
    buildable.models = [];
    
    if ( isdefined( buildinfo.models ) && buildinfo.models.size > 0 )
    {
        for ( i = 0; i < buildinfo.models.size ; i++ )
        {
            model = spawn( "script_model", origin );
            model setmodel( buildinfo.models[ i ] );
            model.angles = angles;
            buildable.models[ i ] = model;
            model notsolid();
            model connectpaths();
        }
        
        assert( buildable.phases.size - buildable.models.size == 1, objname + "<dev string:x24>" + "<dev string:x5a>" + buildable.phases.size - 1 + "<dev string:x6a>" + buildable.models.size );
    }
    
    buildable.buildanimations = [];
    buildable.idleanimations = [];
    buildable.destroyanimations = [];
    
    if ( isdefined( buildinfo.animations ) && buildinfo.animations.size > 0 )
    {
        animname = buildinfo.animations[ 0 ];
        buildanimations = buildinfo.animations[ 1 ];
        idleanimations = buildinfo.animations[ 2 ];
        assert( buildanimations.size == buildable.models.size, animname + "<dev string:x7a>" + "<dev string:xbe>" + buildanimations.size + "<dev string:x6a>" + buildable.models.size );
        assert( buildanimations.size == idleanimations.size, animname + "<dev string:xd2>" + "<dev string:xbe>" + buildanimations.size + "<dev string:x121>" + idleanimations.size );
        buildable.animname = animname;
        
        for ( i = 0; i < buildanimations.size ; i++ )
        {
            buildable.models[ i ].animname = animname;
            buildable.models[ i ] animation::setanimtree();
            buildable.buildanimations[ i ] = buildanimations[ i ];
            buildable.idleanimations[ i ] = idleanimations[ i ];
        }
        
        destroyanimations = buildinfo.animations[ 3 ];
        
        if ( isdefined( destroyanimations ) )
        {
            assert( destroyanimations.size == buildable.models.size, animname + "<dev string:x13a>" + "<dev string:xbe>" + destroyanimations.size + "<dev string:x6a>" + buildable.models.size );
            
            for ( i = 0; i < destroyanimations.size ; i++ )
            {
                buildable.destroyanimations[ i ] = destroyanimations[ i ];
            }
        }
    }
    
    buildable updateprogress( undefined, currentprogress, 1 );
    buildable thread function_1b74bbc9ce89ab4b();
    level.buildables[ level.buildables.size ] = buildable;
    return buildable;
}

// Namespace wm_buildable
// Params 0
// Checksum 0xc52cd2fd, Offset: 0xbe2
// Size: 0x137
function function_1b74bbc9ce89ab4b()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.zonename ) )
    {
        flags::gameflagwait( self.zonename + "_objective_start" );
        
        if ( self.zonename == level.zone.name )
        {
            self.useobj.offset3d = ( -20, 30, -30 );
            self.useobj gameobjects::requestid( 1, 0 );
            self.useobj gameobjects::setobjectivestatusicons( "waypoint_Buildable_ToBuild" );
            self.useobj gameobjects::setvisibleteam( "any" );
            objidpoolmanager::function_586b631e7bbb592a( self.useobj.objidnum, 1 );
        }
        else
        {
            self.useobj gameobjects::releaseid( 1, 1 );
        }
    }
    else
    {
        assertmsg( "<dev string:x180>" + self.name + "<dev string:x1a8>" + self.origin );
        return;
    }
    
    flags::gameflagwait( self.zonename + "_objective_end" );
    self.useobj gameobjects::releaseid( 1, 1 );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xf38234e6, Offset: 0xd21
// Size: 0xb3
function removebuildable( buildable )
{
    foreach ( model in buildable.models )
    {
        model delete();
    }
    
    level.buildables = arrayremove( level.buildables, buildable );
    buildable.useobj gameobjects::releaseid( 1, 1 );
}

// Namespace wm_buildable
// Params 0
// Checksum 0xaeee24c0, Offset: 0xddc
// Size: 0x68
function function_c1d9d2eab153422f()
{
    for ( i = 0; i < self.phases.size ; i++ )
    {
        if ( self.phases[ i ] == self.buildphase )
        {
            return i;
        }
    }
    
    assert( "<dev string:x1b0>" + self.name + "<dev string:x1d4>" + self.buildphase );
}

// Namespace wm_buildable
// Params 2
// Checksum 0xb0c54f3a, Offset: 0xe4d
// Size: 0x96
function function_101c7dfb51c1acf9( phasesinfo, currentprogress )
{
    buildphase = 0;
    
    foreach ( phase in phasesinfo )
    {
        if ( currentprogress >= phase )
        {
            buildphase = phase;
        }
    }
    
    return buildphase;
}

// Namespace wm_buildable
// Params 3
// Checksum 0x2f3588f2, Offset: 0xeec
// Size: 0x178
function updateprogress( player, progress, isinit )
{
    assert( progress >= 0, "<dev string:x1e3>" + self.name );
    buildphase = function_101c7dfb51c1acf9( self.phases, progress );
    
    if ( buildphase > self.buildphase )
    {
        if ( isinit )
        {
        }
        else
        {
            model = function_32a9398e2ca78701();
            
            if ( isdefined( model ) )
            {
                model solid();
                model disconnectpaths();
            }
        }
        
        self.buildphase = buildphase;
        
        if ( self.buildphase >= 1 && isdefined( self.var_ebd73781da1158ea ) )
        {
            level [[ self.var_ebd73781da1158ea ]]( player, self );
            function_73bc3f96296c7400( player, "build" );
            
            if ( isinit )
            {
                self.useobj function_d0547687fedbb678();
            }
        }
        else if ( isdefined( self.var_3b45d6c373f01b69 ) )
        {
            level [[ self.var_3b45d6c373f01b69 ]]( player, self, function_c1d9d2eab153422f() );
            function_73bc3f96296c7400( player, "build" );
        }
        
        if ( buildphase > 0 )
        {
            if ( isinit )
            {
            }
            else
            {
                function_a9add4936a4c4a2e();
            }
        }
        
        return;
    }
    
    if ( self.forceanimation )
    {
        if ( isdefined( self.var_33237f45f5760876 ) )
        {
            level [[ self.var_33237f45f5760876 ]]( player, self );
        }
        
        function_a9add4936a4c4a2e();
        return;
    }
    
    if ( isinit )
    {
        function_cc27145c90db4509();
    }
}

// Namespace wm_buildable
// Params 0
// Checksum 0x4d2bc3b3, Offset: 0x106c
// Size: 0x12
function function_d57f2d0d381b22()
{
    return self.buildanimations[ function_c1d9d2eab153422f() ];
}

// Namespace wm_buildable
// Params 0
// Checksum 0xe8155f86, Offset: 0x1087
// Size: 0x12
function function_57fd776e14313704()
{
    return self.idleanimations[ function_c1d9d2eab153422f() ];
}

// Namespace wm_buildable
// Params 0
// Checksum 0x65df137f, Offset: 0x10a2
// Size: 0x12
function function_32a9398e2ca78701()
{
    return self.models[ function_c1d9d2eab153422f() ];
}

// Namespace wm_buildable
// Params 0
// Checksum 0x34b6f1b2, Offset: 0x10bd
// Size: 0x67
function function_cc27145c90db4509()
{
    for ( i = 0; i < self.idleanimations.size ; i++ )
    {
        idleanimname = self.idleanimations[ i ];
        model = self.models[ i ];
        
        if ( isdefined( idleanimname ) && isdefined( model ) )
        {
            thread function_da52ec68857cf8f5( model, idleanimname );
        }
    }
}

// Namespace wm_buildable
// Params 2
// Checksum 0x5e879eab, Offset: 0x112c
// Size: 0x3e
function function_da52ec68857cf8f5( model, animname )
{
    model animation::anim_single_solo( model, animname );
    model clearanim( level.scr_anim[ self.animname ][ animname ], 0 );
}

// Namespace wm_buildable
// Params 0
// Checksum 0x9798434e, Offset: 0x1172
// Size: 0xe9
function function_91c49e3d59044210()
{
    if ( isdefined( self.models[ 1 ] ) && utility::fxexists( "wall_explode" ) )
    {
        playfxontag( utility::getfx( "wall_explode" ), self.models[ 1 ], "tag_origin" );
        playsoundatpos( self.models[ 1 ].origin, "jup_launchfacility_buildable_wall_destroyed" );
    }
    
    for ( i = 0; i < self.idleanimations.size ; i++ )
    {
        idleanimname = self.idleanimations[ i ];
        model = self.models[ i ];
        
        if ( isdefined( idleanimname ) && isdefined( model ) )
        {
            if ( i == self.idleanimations.size - 1 )
            {
                model animation::anim_single_solo( model, idleanimname );
                continue;
            }
            
            model thread animation::anim_single_solo( model, idleanimname );
        }
    }
}

// Namespace wm_buildable
// Params 0
// Checksum 0xeb890db7, Offset: 0x1263
// Size: 0x78
function function_b587d64ff7889b69()
{
    if ( self.buildphase < 0 || self.buildphase >= 1 )
    {
        return;
    }
    
    idleanimname = function_57fd776e14313704();
    model = function_32a9398e2ca78701();
    
    if ( isdefined( idleanimname ) && isdefined( model ) )
    {
        model animation::anim_single_solo( model, idleanimname );
        model clearanim( level.scr_anim[ self.animname ][ idleanimname ], 0 );
    }
}

// Namespace wm_buildable
// Params 0
// Checksum 0xf94cd9f6, Offset: 0x12e3
// Size: 0x5a
function function_a9add4936a4c4a2e()
{
    if ( self.buildphase < 0 || self.buildphase >= 1 )
    {
        return;
    }
    
    buildanimname = function_d57f2d0d381b22();
    model = function_32a9398e2ca78701();
    
    if ( isdefined( buildanimname ) && isdefined( model ) )
    {
        model thread animation::anim_single_solo( model, buildanimname );
    }
}

// Namespace wm_buildable
// Params 0
// Checksum 0xadd50d00, Offset: 0x1345
// Size: 0x91
function function_a3a3c0ab6a187b83()
{
    if ( !isdefined( self.destroyanimations ) )
    {
        return;
    }
    else if ( self.destroyanimations.size == 0 )
    {
        function_91c49e3d59044210();
        return;
    }
    
    for ( i = 0; i < self.destroyanimations.size ; i++ )
    {
        destroyanimations = self.destroyanimations[ i ];
        model = self.models[ i ];
        
        if ( isdefined( destroyanimations ) && isdefined( model ) )
        {
            model animation::anim_single_solo( model, destroyanimations );
        }
    }
}

// Namespace wm_buildable
// Params 5
// Checksum 0xc27f2571, Offset: 0x13de
// Size: 0x1be
function function_a4d5088e0f45a9ba( triggerent, hintstring, buildusetime, buildteam, var_b1bcdf4caa00e49 )
{
    useobj = gameobjects::createuseobject( game[ "defenders" ], triggerent, [], ( 0, 0, 0 ), 1, 1 );
    
    if ( isdefined( buildteam ) )
    {
        if ( buildteam == game[ "defenders" ] )
        {
            useobj gameobjects::allowuse( "friendly" );
        }
        else
        {
            useobj gameobjects::allowuse( "enemy" );
        }
    }
    
    useobj.trigger makeusable();
    useobj.skiptouching = 1;
    useobj.interactteam = "any";
    useobj.var_b1bcdf4caa00e49 = var_b1bcdf4caa00e49;
    useobj.id = "wm_buildable";
    useobj.waitforweapononuse = 0;
    useobj.trigger setusepriority( -4 );
    useobj gameobjects::setusetime( buildusetime );
    useobj.buildusetime = buildusetime;
    useobj gameobjects::setusehinttext( hintstring );
    useobj.trigger setuseholdduration( "duration_none" );
    useobj.hintstring = hintstring;
    useobj.onbeginuse = &function_35912c8d38eeb161;
    useobj.onenduse = &function_f6cfe86126fbcca5;
    useobj.onuse = &function_c02556089942e88c;
    useobj.trigger setuserange( 96 );
    useobj.trigger setusefov( 120 );
    useobj.trigger sethintdisplayrange( 96 );
    useobj.trigger sethintdisplayfov( 120 );
    return useobj;
}

// Namespace wm_buildable
// Params 6
// Checksum 0x3506ddc0, Offset: 0x15a5
// Size: 0x1f7
function function_ce601a864bcc009( buildable, triggerent, hintstring, destroyusetime, destroyteam, var_7abfe5a392e973ee )
{
    destroyobj = gameobjects::createuseobject( game[ "defenders" ], triggerent, [], ( 0, 0, 0 ), 1, 1 );
    destroyobj.buildable = buildable;
    buildable.destroyobj = destroyobj;
    
    if ( isdefined( destroyteam ) )
    {
        if ( destroyteam == game[ "defenders" ] )
        {
            destroyobj gameobjects::allowuse( "friendly" );
        }
        else
        {
            destroyobj gameobjects::allowuse( "enemy" );
        }
    }
    
    destroyobj.gestureweapon = "jup_war_ges_c4_plant";
    destroyobj.countdowntime = 3;
    destroyobj.var_f6c949abd2d93b8d = 5 - destroyusetime;
    destroyobj.trigger makeusable();
    destroyobj.skiptouching = 1;
    destroyobj.interactteam = "any";
    destroyobj.id = "wm_buildable";
    destroyobj.waitforweapononuse = 0;
    destroyobj.trigger setusepriority( -4 );
    destroyobj gameobjects::setusetime( destroyusetime );
    destroyobj gameobjects::setusehinttext( hintstring );
    destroyobj.trigger setuseholdduration( "duration_none" );
    destroyobj.onbeginuse = &function_7fbc8bd19b90e42b;
    destroyobj.onenduse = &function_e6a4cb9faa48f93f;
    destroyobj.onuse = &function_23884a657766f5c3;
    destroyobj.var_7abfe5a392e973ee = var_7abfe5a392e973ee;
    destroyobj.trigger setuserange( 96 );
    destroyobj.trigger setusefov( 120 );
    destroyobj.trigger sethintdisplayrange( 96 );
    destroyobj.trigger sethintdisplayfov( 120 );
    return destroyobj;
}

// Namespace wm_buildable
// Params 1
// Checksum 0x4b6db0e4, Offset: 0x17a5
// Size: 0x47
function function_7fbc8bd19b90e42b( player )
{
    if ( isdefined( self.gestureweapon ) )
    {
        player wm_utility::function_6a8add6912adc43f( self.gestureweapon, 0.5 );
    }
    
    wm_utility::function_f07e90ed96504935( player, "destroy" );
    thread function_89bd58f45be38368( player );
}

// Namespace wm_buildable
// Params 3
// Checksum 0x5b2459a4, Offset: 0x17f4
// Size: 0x50
function function_e6a4cb9faa48f93f( team, player, result )
{
    if ( result == 0 )
    {
        if ( isdefined( self.gestureweapon ) )
        {
            player wm_utility::function_977af8dcbb181e1d();
        }
        
        wm_utility::function_6789bf4a2324b515( player );
    }
    
    self notify( #"hash_ff99783cac328216" );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xc1606c50, Offset: 0x184c
// Size: 0xc7
function function_23884a657766f5c3( player )
{
    self.trigger makeunusable();
    
    if ( isdefined( self.gestureweapon ) )
    {
        player thread wm_utility::function_5485d4fdf955437e( self.var_f6c949abd2d93b8d );
    }
    
    wm_utility::function_6789bf4a2324b515( player );
    bombcountdown( player );
    var_f9b004728de7c393 = self.buildable;
    var_f9b004728de7c393 function_a3a3c0ab6a187b83();
    var_f9b004728de7c393 function_73bc3f96296c7400( player, "destroy" );
    
    if ( isdefined( self.var_7abfe5a392e973ee ) )
    {
        self [[ self.var_7abfe5a392e973ee ]]( player );
    }
    
    var_f9b004728de7c393 notify( #"buildabledestroyed" );
    removebuildable( var_f9b004728de7c393 );
    player function_289bb264454c32d9( 0 );
    gameobjects::releaseid();
    self notify( #"deleted" );
}

// Namespace wm_buildable
// Params 2
// Checksum 0x31b7058e, Offset: 0x191b
// Size: 0x84
function function_8df0f56e40ca484b( model, notifystring )
{
    level endon( #"game_ended" );
    self endon( #"buildabledestroyed" );
    model childthread watchdamageattacker();
    model waittillmatch( #"scriptablenotification", notifystring );
    model notify( #"destroyed" );
    self.destroyobj notify( #"hash_d77f840c0b4bac06" );
    self.destroyobj function_c8fda83f06dafe0a( model.var_25d0c60022043387 );
}

// Namespace wm_buildable
// Params 0
// Checksum 0x3e10600d, Offset: 0x19a7
// Size: 0x15a
function watchdamageattacker()
{
    level endon( #"game_ended" );
    self endon( #"destroyed" );
    self endon( #"death" );
    self setcandamage( 1 );
    self.var_25d0c60022043387 = undefined;
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        self.health = 99999;
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.var_25d0c60022043387 = attacker;
        
        if ( function_b8033ff7155de18( meansofdeath ) && isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                updatedamagefeedbackfunc = utility::getsharedfunc( #"damage", #"updatedamagefeedback" );
                attacker thread [[ updatedamagefeedbackfunc ]]( "hitequip" );
            }
        }
    }
}

// Namespace wm_buildable
// Params 1
// Checksum 0x55dd48a6, Offset: 0x1b09
// Size: 0x59, Type: bool
function function_b8033ff7155de18( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        return false;
    }
    
    return meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_IMPACT";
}

// Namespace wm_buildable
// Params 1
// Checksum 0x9ce7131b, Offset: 0x1b6b
// Size: 0x5b
function function_89bd58f45be38368( player )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self notify( #"hash_ff99783cac328216" );
    self endon( #"hash_ff99783cac328216" );
    self waittill( #"hash_d77f840c0b4bac06" );
    wm_utility::function_6789bf4a2324b515( player );
    player wm_utility::function_977af8dcbb181e1d();
}

// Namespace wm_buildable
// Params 1
// Checksum 0xb7db5b1f, Offset: 0x1bce
// Size: 0x101
function function_c8fda83f06dafe0a( attacker )
{
    self.trigger makeunusable();
    var_f9b004728de7c393 = self.buildable;
    
    if ( isdefined( var_f9b004728de7c393.c4 ) )
    {
        var_f9b004728de7c393.c4 setscriptablepartstate( "body", "init" );
    }
    else if ( isdefined( var_f9b004728de7c393.c4forward ) && isdefined( var_f9b004728de7c393.c4back ) )
    {
        var_f9b004728de7c393.c4forward setscriptablepartstate( "body", "init" );
        var_f9b004728de7c393.c4back setscriptablepartstate( "body", "init" );
    }
    
    var_f9b004728de7c393 function_a3a3c0ab6a187b83();
    
    if ( isdefined( self.var_7abfe5a392e973ee ) )
    {
        self [[ self.var_7abfe5a392e973ee ]]( attacker );
    }
    
    removebuildable( var_f9b004728de7c393 );
    
    if ( isplayer( attacker ) )
    {
        attacker function_289bb264454c32d9( 0 );
    }
    
    gameobjects::releaseid();
    self notify( #"deleted" );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xa8881413, Offset: 0x1cd7
// Size: 0x39c
function bombcountdown( player )
{
    if ( !isdefined( self.buildable.c4 ) )
    {
        positionvec = player.origin - self.buildable.models[ 0 ].origin;
        var_90f9ebc24440634c = vectordot( positionvec, anglestoforward( self.buildable.models[ 0 ].angles ) );
        
        if ( var_90f9ebc24440634c > 0 )
        {
            self.buildable.c4 = self.buildable.c4forward;
            self.buildable.c4back setscriptablepartstate( "body", "init" );
            outline::outlinedisable( self.buildable.c4back.outlineid, self.buildable.c4back );
        }
        else
        {
            self.buildable.c4 = self.buildable.c4back;
            self.buildable.c4forward setscriptablepartstate( "body", "init" );
            outline::outlinedisable( self.buildable.c4forward.outlineid, self.buildable.c4forward );
        }
    }
    
    var_399500bb295d8727 = self.buildable.c4.origin;
    dangericonent = player weapon::_launchgrenade( "safe_c4_danger_icon_mp", var_399500bb295d8727, ( 0, 0, 0 ), 100, 1 );
    dangericonent setmodel( "tag_origin" );
    dangericonent.weapon_object = makeweapon( "safe_c4_danger_icon_mp" );
    self.buildable.c4 setscriptablepartstate( "body", "bomb_planted" );
    outline::outlinedisable( self.buildable.c4.outlineid, self.buildable.c4 );
    self.buildable.c4 thread br_safecrack_quest::function_867c059a96660a10( self.countdowntime );
    wait self.countdowntime;
    self.buildable.c4 setscriptablepartstate( "body", "explode" );
    
    if ( isdefined( player ) )
    {
        radiusdamage( self.buildable.c4.origin, 256, 200, 105, player, "MOD_EXPLOSIVE", "safe_c4_mp" );
    }
    else
    {
        radiusdamage( self.buildable.c4.origin, 256, 200, 105, undefined, "MOD_EXPLOSIVE", "safe_c4_mp" );
    }
    
    if ( isdefined( dangericonent.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( dangericonent.headiconid );
    }
    
    if ( isdefined( dangericonent ) )
    {
        dangericonent delete();
    }
    
    self.buildable.c4 utility::delaycall( 0.2, &setscriptablepartstate, "body", "init" );
    self.buildable.c4 notify( #"death" );
}

// Namespace wm_buildable
// Params 1
// Checksum 0x3e9a2c9c, Offset: 0x207b
// Size: 0xba
function function_35912c8d38eeb161( player )
{
    thread function_12de2235f2927d96( player );
    function_47b456c89092ffb6( player );
    gestureweapon = self.buildable.gestureweapon;
    
    if ( isdefined( player ) && isdefined( gestureweapon ) )
    {
        player wm_utility::function_6a8add6912adc43f( gestureweapon, 0.5 );
    }
    
    var_b1bcdf4caa00e49 = "build";
    
    if ( isdefined( self.var_b1bcdf4caa00e49 ) )
    {
        var_b1bcdf4caa00e49 = self.var_b1bcdf4caa00e49;
    }
    
    thread wm_utility::function_f07e90ed96504935( player, var_b1bcdf4caa00e49 );
    
    if ( isdefined( self.buildable.triggeroutline ) )
    {
        self.buildable.triggeroutline showtoplayer( player );
    }
}

// Namespace wm_buildable
// Params 1
// Checksum 0x304dd4cb, Offset: 0x213d
// Size: 0xbb
function function_47b456c89092ffb6( player )
{
    if ( !isdefined( self.buildable.models[ 0 ] ) )
    {
        return;
    }
    
    self.buildable.models[ 0 ] makeusable();
    self.buildable.models[ 0 ] disableplayeruse( player );
    self.buildable.models[ 0 ] setusepriority( -4 );
    self.buildable.models[ 0 ] setcursorhint( "HINT_NOBUTTON" );
    self.buildable.models[ 0 ] sethintstring( &"mp_jup_launchfacility/beingbuilt" );
}

// Namespace wm_buildable
// Params 1
// Checksum 0x5b854c95, Offset: 0x2200
// Size: 0xf6
function function_12de2235f2927d96( player )
{
    self endon( #"stop_build" );
    self endon( #"deleted" );
    buildendtime = gettime() + ( 1 - self.buildable.buildphase ) * self.usetime;
    progress = 1;
    self.buildable.forceanimation = 1;
    
    while ( progress > 0 )
    {
        currenttime = gettime();
        var_43e2bf627d6268da = buildendtime - currenttime;
        progress = max( 0, var_43e2bf627d6268da / self.usetime );
        self.curprogress = ( 1 - progress ) * self.usetime;
        self.buildable updateprogress( player, 1 - progress, 0 );
        self.buildable.forceanimation = 0;
        waitframe();
    }
}

// Namespace wm_buildable
// Params 3
// Checksum 0x434f9826, Offset: 0x22fe
// Size: 0x140
function function_f6cfe86126fbcca5( team, player, result )
{
    if ( result == 0 )
    {
        self notify( #"stop_build" );
        self.trigger makeunusable();
        
        if ( isdefined( self.buildable.gestureweapon ) )
        {
            player wm_utility::function_977af8dcbb181e1d();
            utility::delaythread( player.var_da6fef6dec42c01b, &restoreusetrigger );
        }
        else
        {
            utility::delaythread( 0.5, &restoreusetrigger );
        }
        
        if ( isdefined( self.buildable.var_6a7941b3aef1c16 ) )
        {
            level [[ self.buildable.var_6a7941b3aef1c16 ]]( player, self.buildable );
        }
        
        self.buildable function_b587d64ff7889b69();
    }
    
    if ( isdefined( self.buildable.triggeroutline ) )
    {
        self.buildable.triggeroutline hidefromplayer( player );
    }
    
    if ( isdefined( self.buildable.models[ 0 ] ) )
    {
        self.buildable.models[ 0 ] makeunusable();
    }
    
    wm_utility::function_6789bf4a2324b515( player );
}

// Namespace wm_buildable
// Params 0
// Checksum 0x95c66d2c, Offset: 0x2446
// Size: 0x40
function restoreusetrigger()
{
    self.trigger makeusable();
    self.trigger setusepriority( -4 );
    gameobjects::setusetime( self.buildusetime );
    gameobjects::setusehinttext( self.hintstring );
}

// Namespace wm_buildable
// Params 0
// Checksum 0xb66d954, Offset: 0x248e
// Size: 0x27
function function_d0547687fedbb678()
{
    self.trigger makeunusable();
    gameobjects::releaseid( 1, 1 );
    self notify( #"deleted" );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xf7381f0f, Offset: 0x24bd
// Size: 0x170
function function_c02556089942e88c( player )
{
    self.trigger makeunusable();
    gameobjects::releaseid();
    
    if ( isdefined( self.buildable.gestureweapon ) )
    {
        player wm_utility::function_977af8dcbb181e1d();
    }
    
    self.buildable updateprogress( player, 1, 0 );
    
    if ( isdefined( self.buildable.triggeroutline ) )
    {
        self.buildable.triggeroutline hidefromplayer( player );
    }
    
    wm_utility::function_6789bf4a2324b515( player );
    player function_289bb264454c32d9( 1 );
    
    if ( self.buildable.zonename == level.zone.name )
    {
        self.buildable.useobj gameobjects::releaseid( 1, 1 );
        self.buildable.useobj gameobjects::requestid( 1, 0 );
        self.buildable.useobj gameobjects::setobjectivestatusicons( "waypoint_Buildable_Built" );
        self.buildable.useobj gameobjects::setvisibleteam( "any" );
        objidpoolmanager::function_586b631e7bbb592a( self.buildable.useobj.objidnum, 1 );
    }
    
    self notify( #"deleted" );
}

// Namespace wm_buildable
// Params 1
// Checksum 0x81a07fde, Offset: 0x2635
// Size: 0x7e
function function_289bb264454c32d9( isbuild )
{
    assert( isdefined( isbuild ) );
    var_f32c86f71573a333 = 30000;
    
    if ( isdefined( self.var_79c0191fb0c4127d ) && gettime() - self.var_79c0191fb0c4127d < var_f32c86f71573a333 )
    {
        return;
    }
    
    self.var_79c0191fb0c4127d = gettime();
    
    if ( isbuild )
    {
        points::doscoreevent( #"wm_build" );
        return;
    }
    
    points::doscoreevent( #"wm_destroy" );
}

// Namespace wm_buildable
// Params 2
// Checksum 0x145906b, Offset: 0x26bb
// Size: 0xa0
function function_73bc3f96296c7400( player, eventname )
{
    player dlog_recordplayerevent( "dlog_event_wm_player_buildable_data", [ "match_guid", getonlinematchid(), "map_name", level.script, "player_team", player.team, "buildable_id", self.id, "event_name", eventname, "round", "" + game[ "roundsPlayed" ] ] );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xa3f57187, Offset: 0x2763
// Size: 0x42
function function_464a417a10341ea5( objname )
{
    if ( !isdefined( level.buildablepool ) )
    {
        level.buildablepool = [];
    }
    
    buildinfo = spawnstruct();
    level.buildablepool[ objname ] = buildinfo;
    return buildinfo;
}

// Namespace wm_buildable
// Params 5
// Checksum 0xfd8353d0, Offset: 0x27ae
// Size: 0x1d2
function function_1557b05caf2ccb6c( triggerent, hintstring, destroyusetime, destroyteam, var_7abfe5a392e973ee )
{
    destroyobj = gameobjects::createuseobject( game[ "defenders" ], triggerent, [], ( 0, 0, 0 ), 1, 1 );
    
    if ( isdefined( destroyteam ) )
    {
        if ( destroyteam == game[ "defenders" ] )
        {
            destroyobj gameobjects::allowuse( "friendly" );
        }
        else
        {
            destroyobj gameobjects::allowuse( "enemy" );
        }
    }
    
    destroyobj.gestureweapon = "jup_war_ges_c4_plant";
    destroyobj.countdowntime = 3;
    destroyobj.var_f6c949abd2d93b8d = 5 - destroyusetime;
    destroyobj.trigger makeusable();
    destroyobj.skiptouching = 1;
    destroyobj.interactteam = "any";
    destroyobj.id = "wm_buildable";
    destroyobj.waitforweapononuse = 0;
    destroyobj.trigger setusepriority( -4 );
    destroyobj gameobjects::setusetime( destroyusetime );
    destroyobj gameobjects::setusehinttext( hintstring );
    destroyobj.trigger setuseholdduration( "duration_none" );
    destroyobj.onbeginuse = &function_7fbc8bd19b90e42b;
    destroyobj.onenduse = &function_e6a4cb9faa48f93f;
    destroyobj.onuse = &function_23884a657766f5c3;
    destroyobj.var_7abfe5a392e973ee = var_7abfe5a392e973ee;
    destroyobj.trigger setuserange( 96 );
    destroyobj.trigger setusefov( 120 );
    destroyobj.trigger sethintdisplayrange( 96 );
    destroyobj.trigger sethintdisplayfov( 120 );
    return destroyobj;
}

// Namespace wm_buildable
// Params 2
// Checksum 0xb7c179ce, Offset: 0x2989
// Size: 0x51
function function_a6dc2f5c3b6ab417( player, buildable )
{
    outline::outlinedisable( buildable.turret.outlineid, buildable.turret );
    buildable.turret.outlineid = undefined;
}

// Namespace wm_buildable
// Params 2
// Checksum 0x57f24b94, Offset: 0x29e2
// Size: 0x46
function function_f30b810c54ffbc69( player, buildable )
{
    buildable.turret.outlineid = outline::outlineenableforall( buildable.turret, "shimmer_crafting_wm_buildable", "level_script" );
}

// Namespace wm_buildable
// Params 2
// Checksum 0xab1bd9b0, Offset: 0x2a30
// Size: 0x185
function function_7a0217910b16ae71( player, buildable )
{
    buildable.turret.outlineid = outline::outlineenableforall( buildable.turret, "shimmer_crafting_wm_buildable", "level_script" );
    buildable.turret notify( #"turret_fixed" );
    buildable.turret setdefaultdroppitch( 0 );
    buildable.turret setscriptablepartstate( "shutdown", "off" );
    buildable.turret.scriptable setscriptablepartstate( "sfx", "completed" );
    playfx( utility::getfx( "turret_fixed" ), buildable.turret.origin );
    hinttag = "j_trigger";
    hintpos = buildable.turret gettagorigin( hinttag );
    buildable.turret.useobj = gameobjects::createhintobject( hintpos, "HINT_BUTTON", "hud_icon_turret", &"mp/use_turret", undefined, "duration_none" );
    buildable.turret.useobj linkto( buildable.turret, hinttag );
    buildable.turret thread function_7b6009c1b1b34de6();
    buildable.turret.maxhealth = 1650;
}

// Namespace wm_buildable
// Params 0
// Checksum 0x9da1a4c8, Offset: 0x2bbd
// Size: 0x5f
function function_d04517180e4b2b1()
{
    level endon( #"game_ended" );
    self endon( #"turret_fixed" );
    self endon( #"kill_turret" );
    
    while ( true )
    {
        self setscriptablepartstate( "shutdown", "on" );
        self playsound( "jup_machine_gun_smoke" );
        wait 2;
        self setscriptablepartstate( "shutdown", "off" );
        wait 1;
    }
}

// Namespace wm_buildable
// Params 0
// Checksum 0xd80812c7, Offset: 0x2c24
// Size: 0x43
function function_37336c2c54615f39()
{
    level endon( #"game_ended" );
    self.turret waittill( #"kill_turret" );
    self.useobj.trigger makeunusable();
    removebuildable( self );
}

// Namespace wm_buildable
// Params 2
// Checksum 0xf7be7f71, Offset: 0x2c6f
// Size: 0x1c5
function function_9094056478654291( origin, angles )
{
    turret = spawnturret( "misc_turret", origin, "manual_turret_jup_mp", 0 );
    turret.ammocount = 120;
    turret.health = 9999;
    turret.maxhealth = 1650;
    turret.team = "neutral";
    turret.angles = angles;
    turret setmodel( "weapon_wm_mg_mobile_turret" );
    turret makeunusable();
    turret setmode( "sentry_offline" );
    turret setsentryowner( undefined );
    turret setdefaultdroppitch( 0 );
    turret setturretmodechangewait( 1 );
    turret setnodeploy( 1 );
    turret thread function_876fd7a1be0c5193();
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &function_e2db63fb01895e51, &function_ce8586fe874aa127, 0 );
    turret emp_debuff::allow_emp( 0 );
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel setmodel( "weapon_vm_mg_sentry_turret_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel.moverdoesnotkill = 1;
    turret.colmodel.turretparent = turret;
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret, "tag_aim_pivot" );
    return turret;
}

// Namespace wm_buildable
// Params 0
// Checksum 0xd41d27ba, Offset: 0x2e3d
// Size: 0x192
function function_7b6009c1b1b34de6()
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    
    while ( true )
    {
        self.useobj waittill( #"trigger", player );
        
        if ( !isalive( player ) || self.inuse )
        {
            continue;
        }
        
        self.inuse = 1;
        outline::outlinedisable( self.outlineid, self );
        player weapon_utility::saveweaponstates();
        player inventory_utility::_giveweapon( "manual_turret_jup_mp", undefined, undefined, 1 );
        result = player inventory_utility::domonitoredweaponswitch( "manual_turret_jup_mp", 1 );
        
        if ( !result )
        {
            self.inuse = undefined;
            
            if ( isdefined( player ) )
            {
                if ( isalive( player ) )
                {
                    lastweaponobj = player weapon_utility::restoreweaponstates( player.lastdroppableweaponobj );
                    player switchtoweaponimmediate( lastweaponobj );
                }
                
                player inventory_utility::_takeweapon( "manual_turret_jup_mp" );
            }
            
            continue;
        }
        
        self setmode( "manual" );
        player controlturreton( self );
        self.owner = player;
        self.team = player.team;
        self.colmodel.owner = self.owner;
        self.colmodel.team = self.team;
        function_b32906ba5995c920( player );
        thread function_329462216a02959b( player );
        thread function_aea143f38617d9a3( player );
        thread function_72437fe43d243365( player );
    }
}

// Namespace wm_buildable
// Params 1
// Checksum 0x44ee28ca, Offset: 0x2fd7
// Size: 0x4f
function function_b32906ba5995c920( player )
{
    player killstreak_utility::function_d546aaa588f088c3( "manual_turret", "on" );
    player setclientomnvar( "ui_killstreak_countdown", 0 );
    player setclientomnvar( "ui_mobile_turret_controls", 1 );
    player setclientomnvar( "ui_killstreak_weapon_1_ammo", self.ammocount );
}

// Namespace wm_buildable
// Params 1
// Checksum 0x86f5a18a, Offset: 0x302e
// Size: 0x2c
function function_60ef7055765af9d4( player )
{
    player killstreak_utility::function_d546aaa588f088c3( "manual_turret", "off" );
    player setclientomnvar( "ui_mobile_turret_controls", 0 );
}

// Namespace wm_buildable
// Params 1
// Checksum 0x7a4fe4a7, Offset: 0x3062
// Size: 0x108
function function_329462216a02959b( player )
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    player endon( #"hash_ebfdc855350d305" );
    player endon( #"disconnect" );
    player endon( #"death" );
    self.hideammoindex = 1;
    var_13463d1a4d35279b = weaponfiretime( "manual_turret_jup_mp" );
    assert( var_13463d1a4d35279b > 0, "<dev string:x204>" );
    
    while ( player isusingturret() )
    {
        while ( player attackbuttonpressed() )
        {
            self.ammocount--;
            player setclientomnvar( "ui_killstreak_weapon_1_ammo", self.ammocount );
            
            if ( self.ammocount <= 12 )
            {
                self setscriptablepartstate( "hide_ammo_" + self.hideammoindex, "on", 0 );
                self.hideammoindex++;
            }
            
            if ( self.ammocount <= 0 )
            {
                self notify( #"kill_turret" );
                break;
            }
            
            wait var_13463d1a4d35279b;
        }
        
        waitframe();
    }
}

// Namespace wm_buildable
// Params 1
// Checksum 0x851119fd, Offset: 0x3172
// Size: 0x111
function function_4321373f5dff99bd( player )
{
    self.inuse = undefined;
    self.owner = undefined;
    self.team = "neutral";
    self.colmodel.owner = self.owner;
    self.colmodel.team = self.team;
    self setmode( "sentry_offline" );
    self.outlineid = outline::outlineenableforall( self, "shimmer_crafting_wm_buildable", "level_script" );
    
    if ( isdefined( player ) )
    {
        player controlturretoff( self );
        function_60ef7055765af9d4( player );
        
        if ( isalive( player ) )
        {
            lastweaponobj = player weapon_utility::restoreweaponstates( player.lastdroppableweaponobj );
            player switchtoweaponimmediate( lastweaponobj );
            player setorigin( self.lastuserpos, 1 );
            player setplayerangles( self.lastuserangles );
        }
        
        player inventory_utility::_takeweapon( "manual_turret_jup_mp" );
        player notify( #"hash_ebfdc855350d305" );
    }
}

// Namespace wm_buildable
// Params 1
// Checksum 0x2b95ec1f, Offset: 0x328b
// Size: 0x96
function function_aea143f38617d9a3( player )
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    player endon( #"disconnect" );
    player endon( #"hash_ebfdc855350d305" );
    
    while ( player usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( player usebuttonpressed() || player isinexecutionvictim() )
        {
            function_4321373f5dff99bd( player );
            break;
        }
        
        self.lastuserpos = player.origin;
        self.lastuserangles = player getplayerangles();
        waitframe();
    }
}

// Namespace wm_buildable
// Params 1
// Checksum 0xd757de4c, Offset: 0x3329
// Size: 0x52
function function_72437fe43d243365( player )
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    player endon( #"hash_ebfdc855350d305" );
    player utility::waittill_any( "death_or_disconnect", "last_stand_enter", "death" );
    function_4321373f5dff99bd( player );
}

// Namespace wm_buildable
// Params 1
// Checksum 0xb2da17c3, Offset: 0x3383
// Size: 0x25
function function_ce8586fe874aa127( data )
{
    modifieddamage = data.damage;
    return modifieddamage;
}

// Namespace wm_buildable
// Params 1
// Checksum 0xb731f63b, Offset: 0x33b1
// Size: 0x85
function function_e2db63fb01895e51( data )
{
    attacker = data.attacker;
    type = data.meansofdeath;
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" )
    {
        explosivedamage = 1;
    }
    
    self notify( #"kill_turret", explosivedamage, attacker );
}

// Namespace wm_buildable
// Params 0
// Checksum 0xbdd9377a, Offset: 0x343e
// Size: 0xfd
function function_876fd7a1be0c5193()
{
    level endon( #"game_ended" );
    self waittill( #"kill_turret", skipshutdown, killer );
    function_4321373f5dff99bd( self.owner );
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    if ( !skipshutdown )
    {
        self playsound( "jup_machine_gun_smoke" );
        self setscriptablepartstate( "shutdown", "on" );
        hostmigration::waitlongdurationwithpause( 2 );
        self setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        self setscriptablepartstate( "explode", "violent" );
    }
    
    self playsound( "jup_machine_gun_explode" );
    
    if ( isdefined( killer ) )
    {
        if ( isplayer( killer.owner ) )
        {
            killer = killer.owner;
        }
        
        killer function_289bb264454c32d9( 0 );
    }
    
    self.colmodel delete();
    wait 0.2;
    self delete();
}

// Namespace wm_buildable
// Params 0
// Checksum 0x79256e0c, Offset: 0x3543
// Size: 0xf2
function function_c0ef0c866d826855()
{
    self notify( #"hash_6c308c799a736780" );
    self endon( #"hash_6c308c799a736780" );
    level endon( #"game_ended" );
    pathnodes = getvehiclenodearray( "tank_trap_pos", #script_noteworthy );
    pathnode = sortbydistance( pathnodes, self.origin )[ 0 ];
    flags::gameflagwait( "zone_2" + "_objective_start" );
    distsquared = distance2dsquared( self.origin, pathnode.origin );
    
    if ( distsquared > 3000 )
    {
        assertmsg( distsquared + "<dev string:x26d>" + self.origin + "<dev string:x28c>" );
        self.buildable.useobj.trigger makeunusable();
    }
    
    self.progress = pathnode.progress;
}

// Namespace wm_buildable
// Params 1
// Checksum 0xe0cc3729, Offset: 0x363d
// Size: 0x27a
function function_cd622d493f5b1bbd( zoneinfo )
{
    level endon( #"game_ended" );
    flags::gameflagwait( zoneinfo + "_objective_start" );
    tank = level.escortvehicles[ 0 ];
    
    while ( !( isdefined( self.triggerent.progress ) && isdefined( tank.progress ) && isdefined( tank.var_4f6ccc87c3912e74 ) ) )
    {
        waitframe();
    }
    
    var_a1b8191b1715d31d = spawn( "script_model", self.triggerent.origin );
    var_a1b8191b1715d31d.angles = self.triggerent.angles;
    var_a1b8191b1715d31d makeusable();
    var_a1b8191b1715d31d sethintdisplayrange( 256 );
    var_a1b8191b1715d31d sethintdisplayfov( 360 );
    var_a1b8191b1715d31d setuserange( 256 );
    var_a1b8191b1715d31d setusefov( 360 );
    var_a1b8191b1715d31d sethintonobstruction( "show" );
    var_a1b8191b1715d31d setcursorhint( "HINT_NOBUTTON" );
    var_a1b8191b1715d31d sethintstring( &"mp/unable_to_build_trap" );
    
    while ( self.buildphase == 0 )
    {
        if ( abs( self.triggerent.progress - tank.progress ) > tank.var_4f6ccc87c3912e74 * 400 )
        {
            self.useobj.trigger makeusable();
            
            foreach ( player in level.players )
            {
                var_a1b8191b1715d31d disableplayeruse( player );
            }
        }
        else
        {
            self.useobj.trigger makeunusable();
            
            foreach ( player in level.players )
            {
                var_a1b8191b1715d31d enableplayeruse( player );
            }
        }
        
        waitframe();
    }
    
    var_a1b8191b1715d31d delete();
}

// Namespace wm_buildable
// Params 1
// Checksum 0x5ca5ff08, Offset: 0x38bf
// Size: 0x1d8
function function_d6c80d4cea37db7b( zoneinfo )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    flags::gameflagwait( zoneinfo + "_objective_start" );
    ref = self.models[ 0 ] getentitynumber();
    tank = level.escortvehicles[ 0 ];
    
    while ( !( isdefined( self.triggerent.progress ) && isdefined( tank.progress ) && isdefined( tank.var_4f6ccc87c3912e74 ) ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( !tank.var_1d982a0a9bb102b3[ ref ] && function_e54c107a2419ba13( tank.var_4f6ccc87c3912e74, self.triggerent.progress, tank.progress ) )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 1;
            
            if ( self.triggerent.progress > tank.progress )
            {
                tank.directionblocked[ ref ] = "forward";
            }
            else
            {
                tank.directionblocked[ ref ] = "backward";
            }
        }
        
        msg = utility::waittill_notify_or_timeout_return( "trap_destroyed", 0.2 );
        
        if ( msg == "trap_destroyed" )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 0;
            break;
        }
        
        if ( tank.var_1d982a0a9bb102b3[ ref ] && !function_e54c107a2419ba13( tank.var_4f6ccc87c3912e74, self.triggerent.progress, tank.progress ) )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 0;
        }
    }
}

// Namespace wm_buildable
// Params 3
// Checksum 0x80391cb7, Offset: 0x3a9f
// Size: 0x39, Type: bool
function function_e54c107a2419ba13( var_4f6ccc87c3912e74, trapprogress, tankprogress )
{
    return tankprogress - trapprogress > var_4f6ccc87c3912e74 * 170 * -1 && tankprogress - trapprogress < var_4f6ccc87c3912e74 * 210;
}

