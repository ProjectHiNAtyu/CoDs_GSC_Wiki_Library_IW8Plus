// scripts\mp\common\supers\super_riotshield.gsc  (hash_29f9024aee246a8e.gscc) (size: 28472 Bytes / 0x6f38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77546baa (2002021290)
// size ...... 28472 (0x6f38)
// includes .. 24  (offset: 0x6938)
// strings ... 65  (offset: 0x69f8)
// dev strs .. 12  (offset: 0x6ea0)
// exports ... 73  (offset: 0x4380)
// cseg ...... 0x474 + 0x3f0c (0x4380)
// imports ... 217 (offset: 0x4ee8)
// animtree1 . 0   (offset: 0x6f38)
// animtree2 . 0   (offset: 0x6f38)
#using scripts\common\callbacks;
#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\tactical_cover;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\usability;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\supers;

#namespace super_riotshield;

// Namespace super_riotshield
// Params 2
// Checksum 0xa9cc3daa, Offset: 0x492
// Size: 0x334
function riotshield_init( supername, plantedmodelname )
{
    if ( utility::function_9e8f69121ec4b65d( #"super_riotshield" ) )
    {
        return;
    }
    
    function_babfdd0048702449( "rs_top" );
    function_babfdd0048702449( "rs_mid" );
    function_babfdd0048702449( "rs_bottom" );
    function_babfdd0048702449( "riotShield" );
    tactical_cover::function_8d8713d52d006b82( supername, 31, 54, 5, plantedmodelname, &riotshield_destroy, &function_580840f00e72f93, &riotshield_onspawn );
    coverdata = tactical_cover::function_311c5721c8f0b0c9( supername );
    coverdata.var_b1e197b670cbb18e = 1;
    
    if ( !isdefined( level.riotshieldcollision ) )
    {
        collisionarr = getentarray( "riotshield_col", #targetname );
        
        if ( isdefined( collisionarr ) )
        {
            level.riotshieldcollision = collisionarr[ 0 ];
        }
    }
    
    level.riotshieldglobals.var_5e19ffcf3ef6920e = spawnstruct();
    level.riotshieldglobals.var_5e19ffcf3ef6920e.volumes = getnoentvolumearray( "dcover_invalid_noent", #targetname );
    level.riotshieldglobals.var_5e19ffcf3ef6920e.triggers = getentarray( "dcover_invalid", #targetname );
    level.riotshieldglobals.var_5e19ffcf3ef6920e.structs = utility::getstructarray( "dcover_invalid_struct", "targetname" );
    
    if ( isdefined( level.superglobals.staticsuperdata[ supername ] ) )
    {
        level.superglobals.staticsuperdata[ supername ].var_1836be75d110dd2f = &function_2914ca1012ca1c;
    }
    
    level.riotshieldglobals.supername = supername;
    level.riotshieldglobals.superbundle = supers_mp::function_5ffd3dfa9cc1e8de( level.riotshieldglobals.supername );
    level.riotshieldglobals.weaponobj = weapon::buildweapon( level.riotshieldglobals.superbundle.useweapon );
    level thread function_992baf7dfe84a906();
    level.riotshieldglobals.var_d56f09c2a666a952 = [ 0.75, 0.58, 0.42, 0.25, 0 ];
    level.riotshieldglobals.maxhealth = level.riotshieldglobals.superbundle.maxhealth ?? getdvarint( @"scr_super_riotshield_max_health", 1500 );
    function_b1517a0d4bbbae07();
    utility::registersharedfunc( #"super_riotshield", #"hash_dd3226361f17fd81", &riotshield_ondamage, 1 );
    utility::registersharedfunc( #"super_riotshield", #"hash_6d54acc12b075f40", &function_a56c34b9a48c2917, 1 );
    level callback::add( #"hash_752d3e269a84d3f5", &function_9cffc28af25bd374 );
    utility::flag_set( "super_riotshield_initialized" );
    
    /#
        level thread function_7ed9d2f13789486a();
    #/
}

// Namespace super_riotshield
// Params 0
// Checksum 0xfa9fa312, Offset: 0x7ce
// Size: 0x3d, Type: bool
function function_fb218b9439dcc2f0()
{
    superbundle = level.riotshieldglobals.superbundle;
    assert( isdefined( superbundle ), "<dev string:x24>" );
    return istrue( superbundle.canpickupriotshield );
}

// Namespace super_riotshield
// Params 0
// Checksum 0xd3061934, Offset: 0x814
// Size: 0x77, Type: bool
function function_4013f0059e7227c4()
{
    self notify( #"riotshield_unset" );
    superinfo = supers_mp::getcurrentsuper();
    
    if ( isdefined( superinfo.riotshielddata ) && isdefined( superinfo.riotshielddata.plantedshield ) )
    {
        superinfo.riotshielddata.plantedshield riotshield_destroy( 0, 1, 0, 0 );
    }
    
    self setclientomnvar( "ui_riot_shield_active", 0 );
    return true;
}

// Namespace super_riotshield
// Params 0
// Checksum 0x59ef2182, Offset: 0x894
// Size: 0x23, Type: bool
function function_2914ca1012ca1c()
{
    return isdefined( self.super ) && isdefined( self.super.riotshielddata );
}

// Namespace super_riotshield
// Params 1
// Checksum 0xfdb8917, Offset: 0x8c0
// Size: 0x4c
function function_a1ab803568688813( ison )
{
    if ( ison )
    {
        var_a849cca60280e7ff = level.superglobals.var_da0d0ae8681f98ba[ "super_riot_shield" ];
        supers_mp::function_2ea603a86a682ab0( var_a849cca60280e7ff );
        return;
    }
    
    supers_mp::function_2ea603a86a682ab0( 0, 1 );
}

// Namespace super_riotshield
// Params 3
// Checksum 0x75b80a41, Offset: 0x914
// Size: 0x32
function function_63697c915283b5d8( hintobj, player, var_14546e102fa89f0a )
{
    if ( player isswitchingweapon() )
    {
        return;
    }
    
    function_2d1e41d3a46c264( hintobj, player );
}

// Namespace super_riotshield
// Params 1
// Checksum 0x91a1672c, Offset: 0x94e
// Size: 0x138
function function_7539d19b473e5d97( params )
{
    if ( !( isdefined( params.usestring ) && isdefined( params.instance ) && isdefined( params.instance.entity ) ) )
    {
        return;
    }
    
    if ( !function_c0a2d41a39bef42a( params.player ) )
    {
        params.player function_40f7417422e3f78a();
        return;
    }
    
    if ( params.instance.entity.var_fc746a5bf85a02aa )
    {
        var_c574b9896a2bb13b = params.player function_46f881629e190d94();
        
        if ( var_c574b9896a2bb13b == "using" || var_c574b9896a2bb13b == "stowed" )
        {
            params.player function_40f7417422e3f78a();
            return;
        }
        
        params.player supers_mp::givesuper( "super_riot_shield", 0, 1 );
        params.player supers_mp::setsuperbasepoints( 0 );
        params.player riotshield_beginuse();
    }
    
    function_5c4e969d1aadee2( params.instance.entity, params.player );
}

// Namespace super_riotshield
// Params 1
// Checksum 0x193413b, Offset: 0xa8e
// Size: 0x166
function riotshield_enableplayeruse( cover )
{
    assert( isdefined( level.riotshieldglobals.superbundle ) );
    
    if ( level.riotshieldglobals.superbundle.var_70dc92e0d534d8bf == #"scriptable" )
    {
        foreach ( player in level.players )
        {
            cover disablescriptableplayeruse( player );
        }
        
        if ( function_fb218b9439dcc2f0() )
        {
            cover enablescriptableplayeruse( self );
        }
        
        return;
    }
    
    if ( function_fb218b9439dcc2f0() )
    {
        hintobj = cover gameobjects::createhintobject( cover.origin, "HINT_BUTTON", undefined, &"equipment_hints/riotshield_cover_pickup", undefined, undefined, "show", 128, 90, 128, 90 );
        hintobj usability::setselfusable( self );
        hintobj enableplayeruse( self );
        hintobj interactive::interactive_addusedcallbacktoentity( level.riotshieldglobals.supername );
        hintobj linkto( cover );
        cover.hintobj = hintobj;
    }
}

// Namespace super_riotshield
// Params 1
// Checksum 0x451a866d, Offset: 0xbfc
// Size: 0x382
function riotshield_onspawn( cover )
{
    superinfo = supers_mp::getcurrentsuper();
    assert( isdefined( superinfo ), "<dev string:x89>" );
    rsdata = superinfo.riotshielddata;
    assert( isdefined( rsdata ), "<dev string:xf0>" );
    startstate = rsdata.parts[ "riotShield" ].state;
    riotshield_enableplayeruse( cover );
    rsdata.plantedshield = cover;
    cover thread function_62cff8f567834715( startstate );
    thread function_e1c4cd8f7a405a29( cover );
    thread riotshield_watchdisowned( cover );
    collision = riotshield_spawncollision( cover );
    cover validatecollision( collision, level.riotshieldcollision );
    cover setscriptablepartstate( "plant", "on", 1 );
    cover setscriptablepartstate( "riotShield", rsdata.var_b4e85bfa98abc78, 0 );
    collision.riotshieldcover = cover;
    cover.collision = collision;
    cover.isriotshield = 1;
    cover.deletefunc = &riotshield_destroy;
    cover.var_df7a1b82191a68cf = &riotshield_destroy;
    cover.elevatordoorsclosecallback = &riotshield_destroy;
    cover weapon::registermine();
    cover.weapon_object = level.riotshieldglobals.weaponobj;
    cover utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_34f9d09235c7b7df", &function_7539d19b473e5d97 );
    cover emp_debuff::function_6e0986f750cd4259( &function_b6b1ee17f840647e );
    cover.superref = "super_riot_shield";
    cover.headiconid = entityheadicons::setheadicon_fieldupgrade( cover );
    cover enableplayermarks( #"equipment" );
    
    if ( level.teambased )
    {
        cover filteroutplayermarks( self.team );
    }
    else
    {
        cover filteroutplayermarks( self );
    }
    
    collision.moverdoesnotkill = 1;
    cover thread function_6e85f33b6992916f();
    
    foreach ( var_82da2cbf0836ec19 in rsdata.stuckgrenades )
    {
        grenade = var_82da2cbf0836ec19.grenade;
        bonename = cover tagexists( var_82da2cbf0836ec19.bonename ) ? var_82da2cbf0836ec19.bonename : #"tag_new";
        
        if ( isdefined( grenade ) )
        {
            grenade unlink();
            grenade dontinterpolate();
            grenade.origin = cover gettagorigin( bonename ) + anglestoforward( cover.angles ) * 6;
            grenade linkto( cover, bonename );
            grenade.var_caf8ecadb8b4bebe = 1;
            
            if ( grenade.bundle.equipmenttype && grenade.bundle.equipmenttype == "lethal" )
            {
                function_866d37f5a18f02c4( rsdata );
            }
        }
    }
    
    rsdata.stuckgrenades = [];
    self setstance( "crouch" );
}

/#

    // Namespace super_riotshield
    // Params 3
    // Checksum 0xc4c1a013, Offset: 0xf86
    // Size: 0x3b, Type: dev
    function function_f350c33a57a4da3( avgpos, dims, ang )
    {
        orientedbox( avgpos, dims, ang, ( 1, 0, 0 ), 0, 1000 );
    }

#/

// Namespace super_riotshield
// Params 0
// Checksum 0xc1938dbc, Offset: 0xfc9
// Size: 0x35
function function_992baf7dfe84a906()
{
    utility::flag_wait( "train_moving" );
    utility::callsharedfunc( #"train", #"hash_2edafff898b3de81", #"riotshield", &riotshield_handlefataldamage );
}

// Namespace super_riotshield
// Params 0
// Checksum 0x364488c3, Offset: 0x1006
// Size: 0xe1
function function_6e85f33b6992916f()
{
    riotshieldx = getdvarfloat( @"hash_d953f09c93a066aa", 15 );
    riotshieldy = getdvarfloat( @"hash_d953f19c93a068dd", 36 );
    riotshieldz = getdvarfloat( @"hash_d953ee9c93a06244", 45 );
    dims = ( riotshieldx, riotshieldy, riotshieldz );
    ang = vectortoangles( self.angles );
    neworigin = self.origin + anglestoforward( self.angles ) * riotshieldx / 3 + anglestoup( self.angles ) * riotshieldz / 2;
    self.var_df466664efb0f715 = createnavbadplacebybounds( neworigin, dims, ang );
    
    /#
        if ( getdvarint( @"hash_6cd46b09aedbc36c", 0 ) )
        {
            level thread function_f350c33a57a4da3( neworigin, dims, ang );
        }
    #/
}

// Namespace super_riotshield
// Params 1
// Checksum 0x6ca8e1b8, Offset: 0x10ef
// Size: 0x28
function riotshield_watchdisowned( plantedshield )
{
    self waittill( #"disconnect" );
    plantedshield riotshield_destroy( 1, 0, 0, 1 );
}

// Namespace super_riotshield
// Params 4
// Checksum 0x677fc1af, Offset: 0x111f
// Size: 0x70
function function_2d1e41d3a46c264( hintobj, player, cover = hintobj getlinkedparent(), var_3c583cc5c011216d )
{
    if ( isdefined( cover ) )
    {
        cover riotshield_destroy( 1, 0, 0, 1 );
    }
    else
    {
        hintobj delete();
    }
    
    if ( !var_3c583cc5c011216d )
    {
        player function_13aa3f3ec2e98b17( "stowed" );
        player function_1f861534eaef5adc();
    }
}

// Namespace super_riotshield
// Params 2
// Checksum 0x3ea35ef6, Offset: 0x1197
// Size: 0x57
function function_5c4e969d1aadee2( cover, player )
{
    if ( cover.var_fc746a5bf85a02aa && isdefined( cover.var_3ba224b3bddf3819 ) )
    {
        cover.var_3ba224b3bddf3819 notify( #"hash_44061e291cb03b1a" );
    }
    
    player function_1f861534eaef5adc( 0, cover, 1 );
}

// Namespace super_riotshield
// Params 1
// Checksum 0xbe7d489d, Offset: 0x11f6
// Size: 0x12b
function riotshield_spawncollision( shield )
{
    if ( !isdefined( level.riotshieldcollision ) )
    {
        return;
    }
    
    collision = spawn( "script_model", shield.origin );
    collision dontinterpolate();
    collision.angles = shield.angles;
    collision clonebrushmodeltoscriptmodel( level.riotshieldcollision );
    collision linkto( shield );
    collision setentityowner( shield );
    collision disconnectpaths();
    coverdir = anglestoforward( shield.angles );
    var_72425a4a8d49ae02 = shield.origin + coverdir * 25;
    var_7242594a8d49abcf = shield.origin + coverdir * -25;
    shield.var_75ceb94d9876d59c = function_658173c37a66f11();
    shield.var_75cebc4d9876dc35 = function_658173c37a66f11();
    createnavlink( shield.var_75ceb94d9876d59c, var_72425a4a8d49ae02, var_7242594a8d49abcf, "traverse_warp_across", 1920 );
    createnavlink( shield.var_75cebc4d9876dc35, var_7242594a8d49abcf, var_72425a4a8d49ae02, "traverse_warp_across", 1920 );
    return collision;
}

// Namespace super_riotshield
// Params 0
// Checksum 0xd1d3ae84, Offset: 0x132a
// Size: 0x68
function function_658173c37a66f11()
{
    if ( !isdefined( level.riotshieldglobals.navlinkindex ) )
    {
        level.riotshieldglobals.navlinkindex = 0;
    }
    
    navstring = "riotshield_navlink_" + level.riotshieldglobals.navlinkindex;
    level.riotshieldglobals.navlinkindex++;
    return navstring;
}

// Namespace super_riotshield
// Params 0
// Checksum 0xe196ba20, Offset: 0x139b
// Size: 0x63
function riotshield_watchdeath()
{
    level endon( #"game_ended" );
    self endon( #"riotshield_unset" );
    self endon( #"riotshield_end" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    shieldstate = function_46f881629e190d94();
    
    if ( shieldstate != "planted" )
    {
        thread function_521c44e6024a9626();
    }
}

// Namespace super_riotshield
// Params 1
// Checksum 0xe255e72, Offset: 0x1406
// Size: 0x26
function function_62cff8f567834715( startstate )
{
    self endon( #"death" );
    self setscriptablepartstate( "riotShield", startstate, 0 );
}

// Namespace super_riotshield
// Params 0
// Checksum 0xef5b3b0c, Offset: 0x1434
// Size: 0x87
function function_baf293b63a3b2965()
{
    self endon( #"riotshield_end" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_taken", weaponobj );
        shielddata = function_8e63adad4eb02a65();
        
        if ( shielddata.shieldstate == "using" && weapon_utility::isriotshield( weaponobj ) )
        {
            if ( isdefined( self.lastdroppableweaponobj ) )
            {
                self dropitem( self.lastdroppableweaponobj );
            }
        }
    }
}

// Namespace super_riotshield
// Params 1
// Checksum 0x6abeb8e8, Offset: 0x14c3
// Size: 0x70
function function_13aa3f3ec2e98b17( newstate )
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    riotshielddata = superinfo.riotshielddata;
    
    if ( !isdefined( riotshielddata ) )
    {
        return;
    }
    
    oldstate = riotshielddata.shieldstate;
    riotshielddata.shieldstate = newstate;
    function_e086cc2a94db1ac( oldstate, newstate );
}

// Namespace super_riotshield
// Params 2
// Checksum 0xe8a3578d, Offset: 0x153b
// Size: 0x1df
function function_e086cc2a94db1ac( oldstate, newstate )
{
    superinfo = supers_mp::getcurrentsuper();
    riotshielddata = superinfo.riotshielddata;
    
    if ( oldstate == newstate )
    {
        return;
    }
    
    if ( newstate == "using" )
    {
        val::set( "riotshield_supers", "supers", 0 );
        thread function_47fb2eed15dc2650();
    }
    else
    {
        val::reset( "riotshield_supers", "supers" );
        self notify( #"hash_7a30d06bd075573" );
    }
    
    self setclientomnvar( "ui_riot_shield_active", level.riotshieldglobals.var_94f77b63b96a6952[ newstate ] );
    
    if ( newstate == "using" )
    {
        if ( utility::issharedfuncdefined( #"super_riotshield", #"hash_5bc9402162a82eca" ) )
        {
            self [[ utility::getsharedfunc( #"super_riotshield", #"hash_5bc9402162a82eca" ) ]]();
        }
        
        function_a1ab803568688813( 1 );
        
        if ( isdefined( riotshielddata ) && isdefined( riotshielddata.canslide ) )
        {
            self allowslide( riotshielddata.canslide );
        }
        
        return;
    }
    
    if ( newstate == "stowed" )
    {
        val::set( "riotshield_stow", "prone", 0 );
        thread function_df41478f05ae17b2();
    }
    else
    {
        val::reset( "riotshield_stow", "prone" );
    }
    
    if ( oldstate == "using" && newstate != "using" )
    {
        if ( utility::issharedfuncdefined( #"super_riotshield", #"hash_1a2b1e2fa879fd26" ) )
        {
            self [[ utility::getsharedfunc( #"super_riotshield", #"hash_1a2b1e2fa879fd26" ) ]]();
        }
        
        if ( newstate != "stowed" )
        {
            function_a1ab803568688813( 0 );
        }
    }
    
    if ( isdefined( riotshielddata ) && riotshielddata.canslide == 0 )
    {
        self allowslide( !riotshielddata.canslide );
    }
}

// Namespace super_riotshield
// Params 0, eflags: 0xc
// Checksum 0xaa7ad6d9, Offset: 0x1722
// Size: 0x80
function private function_df41478f05ae17b2()
{
    self notify( #"hash_bb50f91c8ffc3b9e" );
    self endon( #"hash_bb50f91c8ffc3b9e" );
    self endon( #"riotshield_end" );
    self notifyonplayercommand( "riotshield_prone_attempt", "+prone" );
    
    while ( true )
    {
        self waittill( #"riotshield_prone_attempt" );
        
        if ( function_46f881629e190d94() != "stowed" )
        {
            self notifyonplayercommandremove( "riotshield_prone_attempt", "+prone" );
            return;
        }
        
        thread print::tutorialprint( &"rex_hints/riotshield_prone_blocked", 1.5 );
    }
}

// Namespace super_riotshield
// Params 0
// Checksum 0x83ef3881, Offset: 0x17aa
// Size: 0x5d
function function_46f881629e190d94()
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    riotshielddata = superinfo.riotshielddata;
    
    if ( !isdefined( riotshielddata ) )
    {
        return;
    }
    
    assert( isdefined( riotshielddata.shieldstate ), "<dev string:x160>" );
    return riotshielddata.shieldstate;
}

// Namespace super_riotshield
// Params 1
// Checksum 0x73e2a674, Offset: 0x1810
// Size: 0x81
function function_e1c4cd8f7a405a29( cover )
{
    superinfo = supers_mp::getcurrentsuper();
    assert( isdefined( superinfo ), "<dev string:x89>" );
    rsdata = superinfo.riotshielddata;
    assert( isdefined( rsdata ), "<dev string:xf0>" );
    currenthealth = rsdata.health;
    cover damage::monitordamage( currenthealth, "hitequip", &riotshield_handlefataldamage, &function_f1fc98f3370fddcc );
}

// Namespace super_riotshield
// Params 1
// Checksum 0xb02c7962, Offset: 0x1899
// Size: 0x47
function function_f1fc98f3370fddcc( data )
{
    if ( isdefined( self.owner ) )
    {
        return ( self.owner riotshield_ondamage( data, undefined, 1 ) ?? data.damage );
    }
    
    return data.damage;
}

// Namespace super_riotshield
// Params 1
// Checksum 0xa00e2c4f, Offset: 0x18e9
// Size: 0x13c
function function_a96046a4e4134b93( damagedata )
{
    idamage = damagedata.damage;
    objweapon = damagedata.objweapon;
    bundle = level.riotshieldglobals.superbundle;
    
    if ( isdefined( bundle.var_9cbab7f6458d089 ) )
    {
        foreach ( struct in bundle.var_9cbab7f6458d089 )
        {
            if ( objweapon.basename == struct.weaponname )
            {
                idamage *= struct.damagescalar;
                break;
            }
        }
    }
    
    if ( isexplosivedamagemod( damagedata.meansofdeath ) && idamage > 10 )
    {
        idamage = max( idamage, level.riotshieldglobals.maxhealth / 3 );
    }
    
    return idamage;
}

// Namespace super_riotshield
// Params 1
// Checksum 0x6c2341c5, Offset: 0x1a2e
// Size: 0x5a
function riotshield_handlefataldamage( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) && player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_riot_shield" );
    }
    
    thread riotshield_destroy( 0, 1 );
}

// Namespace super_riotshield
// Params 5
// Checksum 0x9daeda29, Offset: 0x1a90
// Size: 0x1fb
function riotshield_destroy( immediate, wasdestroyed, destroyedbyexplosive, waspickedup, var_74bb514eae81d )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    owner = self.owner;
    
    if ( isdefined( self.hintobj ) )
    {
        self.hintobj makeunusable();
        self.hintobj delete();
    }
    
    if ( isdefined( self.collision ) )
    {
        self.collision connectpaths();
        self.collision delete();
    }
    
    if ( isdefined( self.blockeddoor ) )
    {
        self.blockeddoor val::reset_all( "tac_cover_door" );
        self.blockeddoor.blockingcover = undefined;
    }
    
    if ( isdefined( self.blockeddoubledoor ) )
    {
        self.blockeddoubledoor val::reset_all( "tac_cover_door" );
        self.blockeddoubledoor.blockingcover = undefined;
    }
    
    if ( !waspickedup && !var_74bb514eae81d )
    {
        superinfo = self.owner supers_mp::getcurrentsuper();
        
        if ( isdefined( superinfo.riotshielddata ) )
        {
            self.owner thread function_521c44e6024a9626();
        }
    }
    
    destroynavlink( self.var_75ceb94d9876d59c );
    destroynavlink( self.var_75cebc4d9876dc35 );
    destroynavobstacle( self.var_df466664efb0f715 );
    self notify( #"death" );
    
    if ( !waspickedup && !var_74bb514eae81d )
    {
        self setscriptablepartstate( "riotShield", "destroyed", 1 );
        wait 0.25;
    }
    
    weapon::deregistermine();
    self delete();
    
    if ( isdefined( owner ) && var_74bb514eae81d )
    {
        superinfo = owner supers_mp::getcurrentsuper();
        
        if ( isdefined( superinfo.riotshielddata ) )
        {
            owner supers_mp::refundsuper();
        }
    }
}

// Namespace super_riotshield
// Params 1
// Checksum 0x89b89065, Offset: 0x1c93
// Size: 0x7b
function function_580840f00e72f93( isdoorblocked )
{
    errormessage = isdoorblocked ? %"mp/tac_cover_place_in_doorway" : %"mp/tac_cover_cannot_place";
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( errormessage );
    }
    
    self playsoundtoplayer( #"iw9_deployable_cover_plant_fail", self );
}

// Namespace super_riotshield
// Params 1
// Checksum 0x14ac5ea0, Offset: 0x1d16
// Size: 0x50
function function_babfdd0048702449( partname )
{
    if ( !isdefined( level.riotshieldglobals ) )
    {
        level.riotshieldglobals = spawnstruct();
    }
    
    if ( !isdefined( level.riotshieldglobals.partdata ) )
    {
        level.riotshieldglobals.partdata = [];
    }
}

// Namespace super_riotshield
// Params 3
// Checksum 0xe694713, Offset: 0x1d6e
// Size: 0xfa
function function_8496bf4b36d42cb3( scriptableent, currenthealth, prevhealth )
{
    maxhealth = level.riotshieldglobals.maxhealth;
    prevpercent = prevhealth / maxhealth;
    currentpercent = currenthealth / maxhealth;
    var_51a8ccb26cf11a66 = undefined;
    var_c71f51d5ca0e2d92 = undefined;
    
    for ( i = 0; i < level.riotshieldglobals.var_d56f09c2a666a952.size ; i++ )
    {
        threshold = level.riotshieldglobals.var_d56f09c2a666a952[ i ];
        
        if ( currentpercent >= threshold && !isdefined( var_51a8ccb26cf11a66 ) )
        {
            var_51a8ccb26cf11a66 = i;
        }
        
        if ( prevpercent >= threshold && !isdefined( var_c71f51d5ca0e2d92 ) )
        {
            var_c71f51d5ca0e2d92 = i;
        }
    }
    
    assert( isdefined( var_51a8ccb26cf11a66 ) && isdefined( var_c71f51d5ca0e2d92 ), "<dev string:x1c1>" );
    return var_51a8ccb26cf11a66 - var_c71f51d5ca0e2d92;
}

// Namespace super_riotshield
// Params 2
// Checksum 0xfea2ef83, Offset: 0x1e71
// Size: 0x1ec
function function_50b18ed0d697df0b( scriptableent, var_5fb67a6b1494700f )
{
    currentstate = scriptableent getscriptablepartstate( "riotShield", 1 );
    var_6f30f321853c0504 = currentstate;
    
    for ( i = 0; i < var_5fb67a6b1494700f ; i++ )
    {
        switch ( var_6f30f321853c0504 )
        {
            case #"hash_4082266c2c059af1":
                var_6f30f321853c0504 = "lgt_dmg_a";
                break;
            case #"hash_6e6b82b6f09f6553":
                var_6f30f321853c0504 = "lgt_dmg_ab";
                break;
            case #"hash_6e6b83b6f09f66e6":
                var_6f30f321853c0504 = utility::array_random( [ "lgt_dmg_ab", "lgt_dmg_bc" ] );
                break;
            case #"hash_6e6b84b6f09f6879":
                var_6f30f321853c0504 = utility::array_random( [ "lgt_dmg_ac", "lgt_dmg_bc" ] );
                break;
            case #"hash_72a3f5fccaec4a90":
            case #"hash_72a3f6fccaec4c23":
            case #"hash_72a6ddfccaee635f":
                var_6f30f321853c0504 = "lgt_dmg_abc";
                break;
            case #"hash_646a0ff371fc08c0":
                var_6f30f321853c0504 = "med_dmg";
                break;
            case #"hash_301399597149864e":
                var_6f30f321853c0504 = "destroyed";
                break;
            case #"hash_c2661c1be510479d":
                var_6f30f321853c0504 = "destroyed";
                break;
            case #"hash_f2b431c975ba652c":
                var_6f30f321853c0504 = "destroyed";
                break;
        }
    }
    
    assert( isdefined( var_6f30f321853c0504 ), "<dev string:x206>" );
    
    /#
        iprintlnbold( "<dev string:x23e>" + currentstate + "<dev string:x260>" + var_6f30f321853c0504 );
    #/
    
    rsowner = isplayer( scriptableent ) ? scriptableent : scriptableent.owner;
    shielddata = rsowner function_8e63adad4eb02a65();
    shielddata.var_b4e85bfa98abc78 = var_6f30f321853c0504;
    scriptableent setscriptablepartstate( "riotShieldFX", var_6f30f321853c0504, 0 );
    scriptableent setscriptablepartstate( "riotShield", var_6f30f321853c0504, 0 );
}

// Namespace super_riotshield
// Params 0
// Checksum 0xa64b48c5, Offset: 0x2065
// Size: 0x59
function function_dfbc6fda7a5bf02()
{
    if ( !isdefined( self.super ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.super.staticdata.useweapon ) )
    {
        return 0;
    }
    
    return weapon_utility::isriotshield( self.super.staticdata.useweapon );
}

// Namespace super_riotshield
// Params 3
// Checksum 0x4b36da92, Offset: 0x20c7
// Size: 0x4c
function function_f85ccdb9dd216133( partname, statename, damagethreshold )
{
    struct = spawnstruct();
    struct.scriptablestatename = statename;
    struct.damagethreshold = damagethreshold;
    return struct;
}

// Namespace super_riotshield
// Params 2
// Checksum 0x3ce14e4b, Offset: 0x211c
// Size: 0x3d2, Type: bool
function riotshield_beginuse( canslide, var_9eb81559fd412929 )
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( isdefined( superinfo.riotshielddata ) )
    {
        riotshielddata = superinfo.riotshielddata;
        shieldstate = function_46f881629e190d94();
        
        if ( isdefined( riotshielddata.plantedshield ) )
        {
            function_2d1e41d3a46c264( undefined, self, riotshielddata.plantedshield, 1 );
        }
    }
    
    riotshielddata = spawnstruct();
    riotshielddata.maxhealth = level.riotshieldglobals.maxhealth;
    riotshielddata.health = riotshielddata.maxhealth;
    riotshielddata.parts = [];
    riotshielddata.var_b4e85bfa98abc78 = "new";
    riotshielddata.parts[ "top" ] = spawnstruct();
    riotshielddata.parts[ "top" ].damagetaken = 0;
    riotshielddata.parts[ "top" ].state = "new";
    riotshielddata.parts[ "mid" ] = spawnstruct();
    riotshielddata.parts[ "mid" ].damagetaken = 0;
    riotshielddata.parts[ "mid" ].state = "new";
    riotshielddata.parts[ "bottom" ] = spawnstruct();
    riotshielddata.parts[ "bottom" ].damagetaken = 0;
    riotshielddata.parts[ "bottom" ].state = "new";
    riotshielddata.parts[ "riotShield" ] = spawnstruct();
    riotshielddata.parts[ "riotShield" ].damagetaken = 0;
    riotshielddata.parts[ "riotShield" ].state = "new";
    riotshielddata.isbreakable = getdvarint( @"hash_5cfe68cbbd93bf1d", 0 );
    riotshielddata.canslide = canslide;
    riotshielddata.var_9eb81559fd412929 = var_9eb81559fd412929;
    
    if ( var_9eb81559fd412929 )
    {
        riotshieldbundle = level.riotshieldglobals.superbundle;
        riotshielddata.var_f5fe006d633134bc = riotshieldbundle.var_f5fe006d633134bc ?? 0.5;
        riotshielddata.var_2a985f8909c778e = riotshieldbundle.var_215365f758ef9660;
    }
    
    superinfo.riotshielddata = riotshielddata;
    riotshielddata.owner = self;
    self setscriptablepartstate( "riotShield", "new", 0 );
    self setscriptablepartstate( "riotShieldFX", "off", 1 );
    function_13aa3f3ec2e98b17( "using" );
    thread function_3ac070f688498996();
    thread function_1b1c64b4aecab3ba();
    thread riotshield_watchdeath();
    thread function_baf293b63a3b2965();
    challenges::function_4fd386d590e901d8( riotshielddata, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_riot_shield", #fieldupgradeent:riotshielddata, #fieldupgradeowner:riotshielddata.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
    assert( isdefined( level.riotshieldglobals.superbundle ) );
    
    if ( level.riotshieldglobals.superbundle.var_70dc92e0d534d8bf == #"scriptable" )
    {
        thread function_f04b47166c103042();
    }
    
    return true;
}

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0x739886a3, Offset: 0x24f7
// Size: 0x6a
function private function_9cffc28af25bd374( params )
{
    rsdata = function_8e63adad4eb02a65();
    
    if ( !isdefined( rsdata ) )
    {
        return;
    }
    
    if ( rsdata.shieldstate == "planted" && rsdata.plantedshield )
    {
        function_9ddfddd6f1ce947d( rsdata.plantedshield, 0 );
        return;
    }
    
    function_521c44e6024a9626( rsdata, 1 );
}

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0xa2fc4c06, Offset: 0x2569
// Size: 0x55
function private function_932bbfa0d3adf5a0( params )
{
    rsdata = function_8e63adad4eb02a65();
    
    if ( rsdata.shieldstate == "planted" && rsdata.plantedshield )
    {
        function_9ddfddd6f1ce947d( rsdata.plantedshield, 1 );
    }
}

// Namespace super_riotshield
// Params 2
// Checksum 0x4ffc0dea, Offset: 0x25c6
// Size: 0x2d
function function_9ddfddd6f1ce947d( plantedshield, canuse )
{
    if ( canuse )
    {
        plantedshield enablescriptableplayeruse( self );
        return;
    }
    
    plantedshield disablescriptableplayeruse( self );
}

// Namespace super_riotshield
// Params 0
// Checksum 0x99878666, Offset: 0x25fb
// Size: 0x45
function function_3c28d213ba726ba1()
{
    self endon( #"death_or_disconnect" );
    wait 0.71;
    spot = self geteye();
    self earthquakeforplayer( 0.47, 0.477, spot, 5000 );
    self playrumbleonentity( "damage_heavy" );
}

// Namespace super_riotshield
// Params 0
// Checksum 0x8f7baf95, Offset: 0x2648
// Size: 0xaa
function function_17f15fd33e43b6f3()
{
    self notify( #"hash_1d6f06023c1490e0" );
    self endon( #"hash_1d6f06023c1490e0" );
    self endon( #"death_or_disconnect" );
    self endon( #"riotshield_end" );
    useweapon = self.currentweapon;
    
    while ( isdefined( self.super ) && isdefined( self.super.riotshielddata ) )
    {
        self waittill( #"weapon_change", newweapon );
        weapon = self getcurrentweapon();
        
        if ( supers_mp::function_9ac5eb9572fa3a0a( useweapon, newweapon ) )
        {
            supers_mp::switchandtakesuperuseweapon( 1 );
            return;
        }
    }
}

// Namespace super_riotshield
// Params 0
// Checksum 0x1ee8fecf, Offset: 0x26fa
// Size: 0x89
function function_1b1c64b4aecab3ba()
{
    self endon( #"disconnect" );
    self endon( #"game_ended" );
    self endon( #"hash_280382f2684ea238" );
    self endon( #"riotshield_end" );
    
    while ( isdefined( self.super ) && isdefined( self.super.riotshielddata ) )
    {
        success = supers_mp::function_99c6158d329ad896();
        
        if ( !success )
        {
            continue;
        }
        
        if ( !function_c0a2d41a39bef42a( self ) )
        {
            continue;
        }
        
        function_1f861534eaef5adc();
    }
}

// Namespace super_riotshield
// Params 2
// Checksum 0x2ff7541e, Offset: 0x278b
// Size: 0x1aa
function function_521c44e6024a9626( riotshielddata, immediate )
{
    self notify( #"riotshield_end" );
    self endon( #"riotshield_end" );
    self endon( #"disconnect" );
    superinfo = supers_mp::getcurrentsuper();
    self setclientomnvar( "ui_riot_shield_active", 0 );
    val::reset( "riotshield_supers", "supers" );
    val::reset( "riotshield_stow", "prone" );
    
    if ( isdefined( riotshielddata ) )
    {
        if ( riotshielddata.isdestroyed )
        {
            return;
        }
        
        riotshielddata.isdestroyed = 1;
    }
    
    if ( superinfo.riotshielddata.var_9eb81559fd412929 )
    {
        function_f233cc6a59bc237b();
    }
    
    self setscriptablepartstate( "riotShield", "destroyed", 1 );
    currentweapon = self getcurrentweapon();
    riotshieldwpn = superinfo.staticdata.useweapon;
    
    if ( !immediate )
    {
        if ( currentweapon == riotshieldwpn )
        {
            self setalternatemode( currentweapon, 1 );
            waitframe();
            val::set( "riotShieldDropping", "weapon_switch", 0 );
            waitseconds = getdvarfloat( @"hash_d209b2f83b675bb3", 0.7 );
            wait waitseconds;
            val::reset( "riotShieldDropping", "weapon_switch" );
        }
        else if ( riotshielddata.shieldstate == "stowed" )
        {
            wait 0.5;
        }
        
        thread inventory_utility::getridofweapon( riotshieldwpn, 0 );
    }
    else
    {
        inventory_utility::_takeweapon( riotshieldwpn );
    }
    
    if ( isdefined( superinfo.riotshielddata ) )
    {
        superinfo.riotshielddata = undefined;
    }
    
    function_a1ab803568688813( 0 );
}

// Namespace super_riotshield
// Params 0
// Checksum 0x8415b50d, Offset: 0x293d
// Size: 0x2
function function_36fc4219c6d8fae6()
{
    
}

// Namespace super_riotshield
// Params 0
// Checksum 0x997e3585, Offset: 0x2947
// Size: 0x143
function function_3ac070f688498996()
{
    self endon( #"death_or_disconnect" );
    self endon( #"riotshield_end" );
    self endon( #"riotshield_unset" );
    
    while ( isdefined( self.super ) && isdefined( self.super.riotshielddata ) )
    {
        msg = utility::waittill_any_return( "weapon_switch_started", "weapon_change", "weapon_switch_canceled", "grenade_fire", "offhand_end" );
        superinfo = self.super;
        
        if ( !isdefined( superinfo ) )
        {
            break;
        }
        
        shieldstate = function_46f881629e190d94();
        
        if ( msg == "weapon_switch_started" && shieldstate != "planted" )
        {
            superinfo.riotshielddata.switchingweapons = 1;
            continue;
        }
        
        superinfo.riotshielddata.switchingweapons = 0;
        
        if ( shieldstate == "planted" )
        {
            continue;
        }
        
        if ( msg == "weapon_change" )
        {
            heldwpn = self.currentweapon;
            
            if ( weapon_utility::isriotshield( heldwpn ) )
            {
                function_13aa3f3ec2e98b17( "using" );
                continue;
            }
            
            function_13aa3f3ec2e98b17( "stowed" );
        }
    }
}

// Namespace super_riotshield
// Params 6
// Checksum 0x4883c183, Offset: 0x2a92
// Size: 0x1dd
function function_d7aadf292727fed0( var_11a782884c575e09, isblocked, doorother, door, deployposition, deployangles )
{
    if ( var_11a782884c575e09 == "equip_deploy_succeeded" && isdefined( deployposition ) && isdefined( deployangles ) )
    {
        var_1f5d041d614cc263 = function_b8a118a5aee7b1db( deployposition );
        
        if ( var_1f5d041d614cc263 )
        {
            shieldplanted = 0;
        }
        else
        {
            shieldplanted = tactical_cover::function_81ce766528080691( 1, level.riotshieldglobals.supername, door, doorother, !isblocked );
            
            if ( !isdefined( shieldplanted ) )
            {
                shieldplanted = tactical_cover::function_7389707b3775a997( deployposition, deployangles, 1, level.riotshieldglobals.supername );
            }
        }
    }
    else if ( var_11a782884c575e09 == "weapon_deploy_requested" )
    {
        shieldplanted = tactical_cover::function_833ed4e3d5304b27( 1, level.riotshieldglobals.supername );
    }
    else if ( var_11a782884c575e09 == "equip_deploy_failed" )
    {
        if ( isdefined( door ) )
        {
            shieldplanted = tactical_cover::function_81ce766528080691( 1, level.riotshieldglobals.supername, door, doorother, !isblocked );
            
            if ( !isdefined( shieldplanted ) )
            {
                shieldplanted = tactical_cover::function_7389707b3775a997( deployposition, deployangles, 1, level.riotshieldglobals.supername );
            }
        }
        else
        {
            shieldplanted = 0;
        }
    }
    
    if ( !shieldplanted )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/tac_cover_cannot_place" );
        }
        
        return;
    }
    
    if ( weapon_utility::isriotshield( self.currentweapon ) )
    {
        inventory_utility::_takeweapon( self.currentweapon );
    }
    
    inventory::switchtolastweapon();
    function_13aa3f3ec2e98b17( "planted" );
    level thread battlechatter_mp::trysaylocalsound( self, #"hash_60bb19eb4239891" );
}

// Namespace super_riotshield
// Params 0
// Checksum 0xb0214d37, Offset: 0x2c77
// Size: 0xd6
function function_f04b47166c103042()
{
    self endon( #"disconnect" );
    self endon( #"riotshield_end" );
    
    while ( isdefined( self.super ) && isdefined( self.super.riotshielddata ) )
    {
        var_9a9d450c5bc5c5f1 = function_5c57f6e5a5c6089e();
        
        if ( !function_c0a2d41a39bef42a( self ) )
        {
            continue;
        }
        
        shieldstate = function_46f881629e190d94();
        
        if ( shieldstate == "planted" )
        {
            continue;
        }
        
        if ( shieldstate == "using" )
        {
            function_d7aadf292727fed0( var_9a9d450c5bc5c5f1.notifystring, var_9a9d450c5bc5c5f1.isblocked, var_9a9d450c5bc5c5f1.doorother, var_9a9d450c5bc5c5f1.door, var_9a9d450c5bc5c5f1.deployposition, var_9a9d450c5bc5c5f1.deployangles );
        }
    }
}

// Namespace super_riotshield
// Params 0
// Checksum 0x701f3447, Offset: 0x2d55
// Size: 0x12d
function function_5c57f6e5a5c6089e()
{
    self endon( #"death_or_disconnect" );
    self endon( #"riotshield_end" );
    ent = spawnstruct();
    childthread function_d9fccd5379d4e4e0( "equip_deploy_succeeded", ent );
    childthread function_d9fccd5379d4e4e0( "equip_deploy_failed", ent );
    childthread function_d9fccd5379d4e4e0( "weapon_deploy_requested", ent );
    ent waittill( #"returned", isblocked, doorother, door, deployoffset, deployweapon, deployposition, deployangles, hitent, notifystring );
    ent notify( #"die" );
    returninfo = spawnstruct();
    returninfo.isblocked = isblocked;
    returninfo.doorother = doorother;
    returninfo.door = door;
    returninfo.deployposition = deployposition;
    returninfo.deployangles = deployangles;
    returninfo.notifystring = notifystring;
    return returninfo;
}

// Namespace super_riotshield
// Params 2
// Checksum 0xafe06391, Offset: 0x2e8b
// Size: 0xab
function function_d9fccd5379d4e4e0( notifystring, ent )
{
    self endon( #"death_or_disconnect" );
    self endon( #"riotshield_end" );
    ent endon( #"die" );
    self waittill( notifystring, deployoffset, deployweapon, deployposition, deployangles, hitent, isblocked, doorother, door );
    ent notify( #"returned", isblocked, doorother, door, deployoffset, deployweapon, deployposition, deployangles, hitent, notifystring );
}

// Namespace super_riotshield
// Params 0
// Checksum 0x1450a72a, Offset: 0x2f3e
// Size: 0xce
function function_3818b1da1550e9b()
{
    assert( isdefined( level.riotshieldglobals.superbundle ) );
    
    if ( level.riotshieldglobals.superbundle.var_70dc92e0d534d8bf == #"scriptable" )
    {
        return;
    }
    
    shieldplanted = tactical_cover::function_833ed4e3d5304b27( 1, level.riotshieldglobals.supername );
    
    if ( !shieldplanted )
    {
        return 0;
    }
    
    inventory::switchtolastweapon();
    function_13aa3f3ec2e98b17( "planted" );
}

// Namespace super_riotshield
// Params 3
// Checksum 0x3851c6d4, Offset: 0x3014
// Size: 0x185, Type: bool
function function_1f861534eaef5adc( forcestand, cover, var_f11881d6138f0cc )
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return false;
    }
    
    riotshieldbundle = level.riotshieldglobals.superbundle;
    
    if ( !function_c0a2d41a39bef42a( self ) )
    {
        return false;
    }
    
    riotshielddata = superinfo.riotshielddata;
    
    if ( riotshielddata.switchingweapons || riotshielddata.isdestroyed )
    {
        return false;
    }
    
    shieldstate = function_46f881629e190d94();
    
    if ( shieldstate == "planted" && !var_f11881d6138f0cc )
    {
        return false;
    }
    else if ( shieldstate == "using" && !var_f11881d6138f0cc )
    {
        function_3818b1da1550e9b();
    }
    else
    {
        success = supers_mp::function_a456d0290912f49( riotshieldbundle.skipfirstraise, riotshieldbundle.useimmediate, 1 );
        
        if ( success )
        {
            if ( cover )
            {
                cover hide();
            }
            
            startstate = riotshielddata.var_b4e85bfa98abc78;
            self setscriptablepartstate( "riotShield", startstate, 0 );
            function_13aa3f3ec2e98b17( "using" );
            
            if ( isdefined( cover ) )
            {
                cover riotshield_destroy( 1, 0, 0, 1 );
            }
            
            if ( forcestand )
            {
                self setstance( "stand" );
            }
        }
        else
        {
            if ( cover )
            {
                cover show();
            }
            
            if ( var_f11881d6138f0cc )
            {
                self function_40f7417422e3f78a();
            }
            
            return false;
        }
    }
    
    return true;
}

// Namespace super_riotshield
// Params 0
// Checksum 0xcdbfef31, Offset: 0x31a2
// Size: 0x1b
function riotshield_ongive()
{
    if ( hasomnvar( "ui_riot_shield_active" ) )
    {
        self setclientomnvar( "ui_riot_shield_active", 1 );
    }
}

// Namespace super_riotshield
// Params 1
// Checksum 0x417bbba3, Offset: 0x31c5
// Size: 0x46
function function_b36283ce5ac00c61( cover )
{
    self endon( #"death_or_disconnect" );
    waittime = getdvarfloat( @"hash_788317f0ff91feaf", 0.05 );
    wait waittime;
    
    if ( isdefined( cover ) )
    {
        cover hide();
    }
}

// Namespace super_riotshield
// Params 1
// Checksum 0x406bcacd, Offset: 0x3213
// Size: 0x4a
function function_8858eabaddf0ecdb( superinfo )
{
    while ( !superinfo.isinuse )
    {
        waitframe();
    }
    
    superinfo.usepercent -= 0.001;
    supers_mp::updatesuperuiprogress();
    supers_mp::updatesuperuistate();
}

// Namespace super_riotshield
// Params 0
// Checksum 0xa53e728, Offset: 0x3265
// Size: 0x1f
function function_8e63adad4eb02a65()
{
    superinfo = supers_mp::getcurrentsuper();
    return superinfo.riotshielddata;
}

// Namespace super_riotshield
// Params 3
// Checksum 0x6119ac8a, Offset: 0x328d
// Size: 0x264
function riotshield_ondamage( damagedata, bonename, var_b655cd50a1b3c4ff )
{
    riotshielddata = function_8e63adad4eb02a65();
    
    if ( !isdefined( riotshielddata ) )
    {
        return;
    }
    
    scriptableent = damagedata.victim;
    idamage = function_a96046a4e4134b93( damagedata );
    
    if ( scriptableent.isdestroyed )
    {
        return;
    }
    
    previoushealth = riotshielddata.health;
    riotshielddata.health = max( 0, riotshielddata.health - idamage );
    
    if ( riotshielddata.health > 0 && riotshielddata.shieldstate == "using" )
    {
        var_7028512267d3d4e8 = damagedata.meansofdeath == "MOD_IMPACT" && weapon_utility::isgrenadeweapon( damagedata.inflictor.weapon_object );
        
        if ( var_7028512267d3d4e8 )
        {
            thread function_c29618bb038166ef( damagedata.inflictor, bonename );
        }
    }
    
    var_1fef3f0875662791 = riotshielddata.health / riotshielddata.maxhealth;
    self setclientomnvar( "ui_riot_shield_health", var_1fef3f0875662791 );
    
    /#
        print( "<dev string:x265>" + riotshielddata.health );
        print( "<dev string:x27a>" + var_1fef3f0875662791 );
    #/
    
    part = riotshield_getpartname( bonename, "player" );
    function_5d9b4ab3098211f9( scriptableent, riotshielddata.health, previoushealth );
    shoulddie = riotshielddata.health <= 0;
    
    if ( !var_b655cd50a1b3c4ff )
    {
        if ( isplayer( damagedata.attacker ) )
        {
            damagedata.attacker damagefeedback::updatedamagefeedback( "hitequip", shoulddie );
        }
        else if ( isplayer( damagedata.attacker.owner ) )
        {
            damagedata.attacker.owner damagefeedback::updatedamagefeedback( "hitequip", shoulddie );
        }
    }
    
    if ( shoulddie && !riotshielddata.isdestroyed && !var_b655cd50a1b3c4ff )
    {
        thread function_521c44e6024a9626( riotshielddata );
        level thread battlechatter_mp::trysaylocalsound( self, #"hash_ec571e69466d1969" );
    }
    
    if ( var_b655cd50a1b3c4ff )
    {
        return idamage;
    }
}

// Namespace super_riotshield
// Params 0
// Checksum 0x5aa7f832, Offset: 0x34f9
// Size: 0x57
function riotshield_ongameended()
{
    self endon( #"riotshield_unset" );
    self endon( #"riotshield_end" );
    self endon( #"disconnect" );
    level waittill( #"game_ended" );
    shieldstate = function_46f881629e190d94();
    
    if ( shieldstate != "planted" )
    {
        thread function_521c44e6024a9626();
    }
}

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0x1fc6102b, Offset: 0x3558
// Size: 0x73
function private function_b6b1ee17f840647e( data )
{
    data.damage = 1000;
    self dodamage( data.damage, data.attacker.origin, data.attacker, data.objweapon, "MOD_EXPLOSIVE", data.objweapon, "none", undefined, 524288, undefined );
}

// Namespace super_riotshield
// Params 0, eflags: 0xc
// Checksum 0x41fda84a, Offset: 0x35d3
// Size: 0x20c
function private function_47fb2eed15dc2650()
{
    self notify( #"hash_c34eab416e0db96f" );
    self endon( #"hash_c34eab416e0db96f" );
    self endon( #"riotshield_unset" );
    self endon( #"riotshield_end" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_7a30d06bd075573" );
    superinfo = supers_mp::getcurrentsuper();
    riotshieldweapon = superinfo.staticdata.useweapon;
    assert( riotshieldweapon, "<dev string:x28a>" );
    
    while ( true )
    {
        self waittill( #"victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir );
        shieldstate = function_46f881629e190d94();
        trackhit = self == einflictor && issameweapon( objweapon, riotshieldweapon ) && shieldstate == "using" && player::isreallyalive( victim ) && !victim.inlaststand;
        
        if ( !trackhit )
        {
            continue;
        }
        
        if ( victim function_d077af3e85c71b68( idflags ) )
        {
            victim function_d7d6915942fa25cf( vdir );
            rsdata = function_8e63adad4eb02a65();
            challenges::function_4fd386d590e901d8( rsdata, #"hash_c50cf868c6994df3", #"heavy_melee_knockdown" );
            challengeparams = { #fieldupgraderef:"super_riot_shield", #fieldupgradeent:rsdata, #victim:victim, #attacker:self };
            callback::callback( #"field_upgrade_hit", challengeparams );
            continue;
        }
        
        knockbackscalar = getdvarfloat( @"hash_48a13c106272e865", 250 );
        
        if ( !isdefined( vdir ) )
        {
            vdir = einflictor.angles;
        }
        
        victim utility::knockback_flat( vdir, knockbackscalar );
    }
}

// Namespace super_riotshield
// Params 2, eflags: 0xc
// Checksum 0x4357b0c5, Offset: 0x37e7
// Size: 0x1bb
function private function_c29618bb038166ef( grenade, bonename )
{
    self notify( #"hash_fca829c499da3393" );
    self endon( #"hash_fca829c499da3393" );
    self endon( #"riotshield_unset" );
    self endon( #"riotshield_end" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_7a30d06bd075573" );
    grenade endon( #"death" );
    
    if ( !grenade.riotshieldhit )
    {
        self waittill( #"hash_f87944a3f6b5abe3", grenade );
    }
    
    grenstruct = { #bonename:bonename, #grenade:grenade };
    rsdata = function_8e63adad4eb02a65();
    
    if ( !isdefined( rsdata.stuckgrenades ) )
    {
        rsdata.stuckgrenades = [];
    }
    
    rsdata.stuckgrenades[ rsdata.stuckgrenades.size ] = grenstruct;
    
    if ( isdefined( grenade ) && isplayer( grenade.owner ) )
    {
        equipmentref = undefined;
        
        if ( isdefined( grenade.equipmentref ) )
        {
            equipmentref = grenade.equipmentref;
        }
        else if ( isdefined( grenade.weapon_name ) )
        {
            equipmentref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
        }
        
        if ( isdefined( equipmentref ) )
        {
            callbackparams = { #var_8df1180983085de3:"super_riot_shield", #stuckto:self, #equipmentref:equipmentref, #attacker:grenade.owner };
            grenade.owner callback::callback( #"equipment_stuck", callbackparams );
        }
    }
}

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0xded7fae4, Offset: 0x39aa
// Size: 0x3f, Type: bool
function private function_d077af3e85c71b68( idflags )
{
    if ( !getdvarint( @"hash_e4e4dadaf3cbb08", 1 ) )
    {
        return false;
    }
    
    if ( !( idflags & 131072 ) )
    {
        return false;
    }
    
    if ( self.inlaststand )
    {
        return false;
    }
    
    return true;
}

// Namespace super_riotshield
// Params 2
// Checksum 0x9c748967, Offset: 0x39f2
// Size: 0xec
function riotshield_getpartname( bonenamehash, riotshieldtype )
{
    partname = "";
    
    if ( riotshieldtype == "player" )
    {
        partname = "riotShield";
    }
    else
    {
        switch ( bonenamehash )
        {
            case #"tag_lgt":
            case #"tag_med":
            case #"tag_new":
            case #"tag_hvy":
                partname = "rs_top";
            case #"hash_29f6d16e10bf47e":
            case #"hash_17ab4d8bda8ead1b":
            case #"hash_35c1f7af47525564":
            case #"hash_3fa4b44003127c63":
                partname = "rs_mid";
            case #"hash_16f1d3b86e137aa7":
            case #"hash_1a818317f8049c78":
            case #"hash_bb4f515b3987cc1d":
            case #"hash_eb7755bc77313f10":
                partname = "rs_bottom";
                break;
        }
    }
    
    return partname;
}

// Namespace super_riotshield
// Params 3
// Checksum 0x96e3f977, Offset: 0x3ae7
// Size: 0x47
function function_5d9b4ab3098211f9( scriptableent, currenthealth, previoushealth )
{
    thresholdspassed = function_8496bf4b36d42cb3( scriptableent, currenthealth, previoushealth );
    
    if ( thresholdspassed < 1 )
    {
        return;
    }
    
    function_50b18ed0d697df0b( scriptableent, thresholdspassed );
}

// Namespace super_riotshield
// Params 1
// Checksum 0x39af3365, Offset: 0x3b36
// Size: 0x50
function function_e68729c449289baf( partname )
{
    assert( isdefined( level.riotshieldglobals ) && isdefined( level.riotshieldglobals.partdata ), "<dev string:x2be>" );
    return level.riotshieldglobals.partdata[ partname ];
}

// Namespace super_riotshield
// Params 0
// Checksum 0x57509709, Offset: 0x3b8f
// Size: 0x73
function function_f233cc6a59bc237b()
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( !( isdefined( superinfo ) && isdefined( superinfo.riotshielddata ) ) )
    {
        return;
    }
    
    if ( superinfo.riotshielddata.var_9eb81559fd412929 )
    {
        self shellshock( superinfo.riotshielddata.var_2a985f8909c778e, superinfo.riotshielddata.var_f5fe006d633134bc );
    }
}

// Namespace super_riotshield
// Params 0, eflags: 0x4
// Checksum 0x465029ee, Offset: 0x3c0a
// Size: 0x43
function private function_b1517a0d4bbbae07()
{
    table = [];
    table[ "using" ] = 2;
    table[ "planted" ] = 3;
    table[ "stowed" ] = 4;
    level.riotshieldglobals.var_94f77b63b96a6952 = table;
}

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0xebb16189, Offset: 0x3c55
// Size: 0xb4, Type: bool
function private function_c0a2d41a39bef42a( player )
{
    state = player function_46f881629e190d94();
    
    if ( !isnullweapon( player getheldoffhand() ) )
    {
        return false;
    }
    else if ( player playermount() >= 0.1 )
    {
        return false;
    }
    else if ( player::ishaywired( player ) )
    {
        return false;
    }
    else if ( !player val::get( "supers" ) && state != "using" )
    {
        return false;
    }
    else if ( !player isonground() )
    {
        return false;
    }
    else if ( player issprintsliding() )
    {
        return false;
    }
    else if ( player isswimming() )
    {
        return false;
    }
    else if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0x71d76f40, Offset: 0x3d12
// Size: 0x284, Type: bool
function private function_b8a118a5aee7b1db( targetpos )
{
    foreach ( volume in level.riotshieldglobals.var_5e19ffcf3ef6920e.volumes )
    {
        if ( ispointinvolume( targetpos + ( 0, 0, 8 ), volume ) )
        {
            return true;
        }
    }
    
    foreach ( trigger in level.riotshieldglobals.var_5e19ffcf3ef6920e.triggers )
    {
        if ( ispointinvolume( targetpos + ( 0, 0, 8 ), trigger ) )
        {
            return true;
        }
    }
    
    foreach ( struct in level.riotshieldglobals.var_5e19ffcf3ef6920e.structs )
    {
        if ( !( isdefined( struct.radius ) && isdefined( struct.height ) && isdefined( struct.origin ) ) )
        {
            continue;
        }
        
        radiussquared = squared( struct.radius );
        zmin = struct.origin[ 2 ] - 8;
        zmax = zmin + struct.height;
        var_8f9009e7fe87802 = targetpos[ 2 ] >= zmin && targetpos[ 2 ] <= zmax;
        
        if ( var_8f9009e7fe87802 && distance2dsquared( struct.origin, targetpos ) < radiussquared )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace super_riotshield
// Params 1
// Checksum 0x1a643aad, Offset: 0x3f9f
// Size: 0x173
function function_70e2467b3bae012d( struct )
{
    shield = spawn( "script_model", struct.origin );
    shield.angles = struct.angles;
    shield setmodel( "projectile_rex_me_riotshield" );
    shield.var_fc746a5bf85a02aa = 1;
    collision = riotshield_spawncollision( shield );
    shield validatecollision( collision, level.riotshieldcollision );
    shield setscriptablepartstate( "plant", "on", 1 );
    shield setscriptablepartstate( "riotShield", "new", 0 );
    shield utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_34f9d09235c7b7df", &function_7539d19b473e5d97, 1 );
    collision.riotshieldcover = shield;
    shield.collision = collision;
    shield.isriotshield = 1;
    shield.deletefunc = &riotshield_destroy;
    shield.var_df7a1b82191a68cf = &riotshield_destroy;
    shield.elevatordoorsclosecallback = &riotshield_destroy;
    shield weapon::registermine();
    shield.weapon_object = level.riotshieldglobals.weaponobj;
    shield enableplayermarks( #"equipment" );
    shield function_6e85f33b6992916f();
    shield.var_3ba224b3bddf3819 = struct;
}

// Namespace super_riotshield
// Params 1
// Checksum 0xdbb83b58, Offset: 0x411a
// Size: 0xc6, Type: bool
function function_a56c34b9a48c2917( vehicle )
{
    bundle = level.riotshieldglobals.superbundle;
    vehicleref = vehicle vehicle::get_ref();
    
    foreach ( struct in bundle.var_726f06a086414ea4 )
    {
        if ( getxhashasset( struct.vehicleref ) == vehicleref )
        {
            return false;
        }
    }
    
    return true;
}

/#

    // Namespace super_riotshield
    // Params 0, eflags: 0x4
    // Checksum 0x696c3c4c, Offset: 0x41e9
    // Size: 0xf2, Type: dev
    function private function_7ed9d2f13789486a()
    {
        setdvarifuninitialized( @"scr_riotshield_debug_end", 0 );
        
        while ( true )
        {
            debugvalue = getdvarint( @"scr_riotshield_debug_end" );
            
            if ( debugvalue != 0 )
            {
                foreach ( player in level.players )
                {
                    if ( player ishost() )
                    {
                        riotshielddata = player.super.riotshielddata;
                        
                        if ( isdefined( riotshielddata ) )
                        {
                            player function_521c44e6024a9626( riotshielddata );
                        }
                    }
                }
                
                setdvar( @"scr_riotshield_debug_end", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace super_riotshield
// Params 1, eflags: 0x4
// Checksum 0x97367022, Offset: 0x42e3
// Size: 0x9d
function private function_866d37f5a18f02c4( riotshielddata )
{
    if ( !riotshielddata.owner challenges::challengesenabledforplayer() || !isplayer( riotshielddata.owner ) )
    {
        return;
    }
    
    challenges::function_4fd386d590e901d8( riotshielddata, #"hash_c50cf868c6994df3", #"hash_dcb6d24229296bd3" );
    challengeparams = { #fieldupgraderef:"super_riot_shield", #fieldupgradeent:riotshielddata, #fieldupgradeowner:riotshielddata.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
}

