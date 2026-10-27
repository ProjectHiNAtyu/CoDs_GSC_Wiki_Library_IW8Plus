// scripts\mp\gametypes\prop_controls.gsc  (hash_1592976110071c28.gscc) (size: 13255 Bytes / 0x33c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c632edf (476262111)
// size ...... 13255 (0x33c7)
// includes .. 12  (offset: 0x3117)
// strings ... 38  (offset: 0x3177)
// dev strs .. 2   (offset: 0x33af)
// exports ... 35  (offset: 0x1cd3)
// cseg ...... 0x274 + 0x1a5f (0x1cd3)
// imports ... 125 (offset: 0x224b)
// animtree1 . 0   (offset: 0x33c7)
// animtree2 . 0   (offset: 0x33c7)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\flags;
#using scripts\mp\gametypes\prop_util;
#using scripts\mp\sentientpoolmanager;

#namespace prop_controls;

// Namespace prop_controls
// Params 0
// Checksum 0x1da93da8, Offset: 0x292
// Size: 0xcb
function function_8d1d8ac7a51591b4()
{
    if ( isai( self ) )
    {
        return;
    }
    
    self notifyonplayercommand( "lock", "+attack" );
    self notifyonplayercommand( "propAbility", "+smoke" );
    self notifyonplayercommand( "cloneProp", "+frag" );
    self notifyonplayercommand( "hide", "+melee" );
    self notifyonplayercommand( "hide", "+melee_zoom" );
    self notifyonplayercommand( "changeProp", "+weapnext" );
    self notifyonplayercommand( "changeProp", "+weapprev" );
    self notifyonplayercommand( "changeProp", "selectweapon1" );
    self notifyonplayercommand( "changeProp", "selectweapon2" );
    self notifyonplayercommand( "changeProp", "selectweapon3" );
    self notifyonplayercommand( "setToSlope", "+reload" );
    self notifyonplayercommand( "setToSlope", "+usereload" );
}

// Namespace prop_controls
// Params 0
// Checksum 0xd6881e67, Offset: 0x365
// Size: 0x160
function function_b359d5089f6b5dd0()
{
    self endon( #"death", #"disconnect", #"hash_e79ffe6977c02c64" );
    level endon( #"game_ended" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    self.lock = 0;
    self.var_2742dd3ad4b6d5af = 0;
    self.prophidden = 0;
    flags::gameflagwait( "prematch_done" );
    thread function_4533ee89a7d11452();
    thread function_a622f51878a42f65();
    self.var_99b88e6aafafb483 = 1;
    
    while ( true )
    {
        msg = utility::waittill_any_return( "lock", "changeProp", "setToSlope", "propAbility", "cloneProp", "hide" );
        waittillframeend();
        
        switch ( msg )
        {
            case #"hash_7dca1839ef64aba2":
                function_36ff9b8cb7c4a134();
                break;
            case #"hash_f88e9605817163e0":
                function_121ea789bc120f7b();
                break;
            case #"hash_a5226ba6c0ae58e1":
                if ( !self usinggamepad() || self adsbuttonpressed() )
                {
                    function_898c1b1f9a08bb57();
                }
                
                break;
            case #"hash_8760003cdf21a60e":
                propAbility();
                break;
            case #"hash_7e1eeaa73d2c2c8b":
                function_b413c3ddfa4ad185();
                break;
            case #"hash_7ebb454a971d80d":
                function_6a8c5460d531b2de();
                break;
            default:
                break;
        }
    }
}

// Namespace prop_controls
// Params 1
// Checksum 0x10cd5baf, Offset: 0x4cd
// Size: 0x70
function function_22dfdf977055d577( enabled )
{
    if ( enabled != self.var_27beb331de1da5b3 )
    {
        if ( enabled && !self.var_27beb331de1da5b3 )
        {
            self setclientomnvar( o"ui_prop_lock_state", 0 );
        }
        else if ( !enabled && self.var_27beb331de1da5b3 )
        {
            self setclientomnvar( o"ui_prop_lock_state", 2 );
        }
        
        self.var_27beb331de1da5b3 = enabled;
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0xf801ba1e, Offset: 0x545
// Size: 0x2b
function function_36ff9b8cb7c4a134()
{
    if ( self.var_27beb331de1da5b3 )
    {
        if ( self.lock )
        {
            function_59c89fe615b119af();
            return;
        }
        
        function_8e913fbde3030c24();
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0xa44c2177, Offset: 0x578
// Size: 0x54
function function_59c89fe615b119af()
{
    self unlink();
    self.playeranchor unlink();
    
    if ( self.var_2742dd3ad4b6d5af )
    {
        function_898c1b1f9a08bb57();
    }
    
    self.propent proplinkto( self );
    self.lock = 0;
    self setclientomnvar( o"ui_prop_lock_state", 0 );
}

// Namespace prop_controls
// Params 0
// Checksum 0x22a89a26, Offset: 0x5d4
// Size: 0x112
function function_8e913fbde3030c24()
{
    if ( !function_1fd4858920733c8b() )
    {
        return;
    }
    
    self.playeranchor.origin = self.origin;
    waitframe();
    self.propent unlink();
    self.propent.origin = self.playeranchor.origin;
    groundentity = self getgroundentity();
    
    if ( isdefined( groundentity ) && groundentity entisalivevehicle() )
    {
        self.playeranchor proplinkto( groundentity );
    }
    
    movingplatform = self getmovingplatformparent();
    
    if ( movingplatform )
    {
        self.playeranchor proplinkto( movingplatform );
    }
    
    self playerlinkto( self.playeranchor );
    self.propent proplinkto( self.playeranchor );
    
    if ( self.var_2742dd3ad4b6d5af )
    {
        function_898c1b1f9a08bb57();
    }
    
    self.lock = 1;
    self setclientomnvar( o"ui_prop_lock_state", 1 );
}

// Namespace prop_controls
// Params 0
// Checksum 0x566aee44, Offset: 0x6ee
// Size: 0x1b5, Type: bool
function function_1fd4858920733c8b()
{
    if ( !self.var_27beb331de1da5b3 )
    {
        return false;
    }
    
    if ( self isonascender() )
    {
        return false;
    }
    
    if ( !self isonground() )
    {
        contentoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 );
        groundtraceend = self.origin - ( 0, 0, 1000 );
        groundtrace = trace::ray_trace( self.origin, groundtraceend, undefined, contentoverride );
        groundfrac = groundtrace[ "fraction" ];
        groundpos = groundtrace[ "position" ];
        
        if ( groundfrac == 1 )
        {
            return false;
        }
        
        killtriggers = getentarray( "trigger_hurt", #classname );
        
        foreach ( trigger in killtriggers )
        {
            if ( ispointinvolume( groundpos, trigger ) )
            {
                return false;
            }
        }
        
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( ispointinvolume( groundpos, trigger ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace prop_controls
// Params 0
// Checksum 0xb358d093, Offset: 0x8ac
// Size: 0x2f, Type: bool
function function_9635b4d000bdec10()
{
    groundnormal = self getgroundnormal();
    
    if ( groundnormal[ 2 ] < 0.7 )
    {
        return false;
    }
    
    if ( !self isonground() )
    {
        return false;
    }
    
    return true;
}

// Namespace prop_controls
// Params 0
// Checksum 0x5731ba07, Offset: 0x8e4
// Size: 0x24, Type: bool
function entisalivevehicle()
{
    return isalive( self ) && ( vehicle::is_vehicle() || self.classname == "script_vehicle" );
}

// Namespace prop_controls
// Params 0
// Checksum 0x9cd29f43, Offset: 0x911
// Size: 0xbf
function function_4533ee89a7d11452()
{
    self endon( #"death_or_disconnect", #"hash_e79ffe6977c02c64" );
    level endon( #"game_ended" );
    waslocked = 0;
    
    for ( wasmoving = 0; true ; wasmoving = ismoving )
    {
        waitframe();
        movement = self getnormalizedmovement();
        var_e59e24fbb46d7d5e = self jumpbuttonpressed();
        
        if ( !isdefined( movement ) )
        {
            continue;
        }
        
        ismoving = movement[ 0 ] != 0 || movement[ 1 ] != 0 || var_e59e24fbb46d7d5e;
        
        if ( self.lock )
        {
            if ( waslocked && !wasmoving && ismoving )
            {
                function_59c89fe615b119af();
            }
        }
        
        waslocked = self.lock;
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0x6bf718d0, Offset: 0x9d8
// Size: 0x1b9
function function_121ea789bc120f7b()
{
    if ( !function_6b4ad7c007d5a0bf() )
    {
        return;
    }
    
    prop_util::function_77b56b69ceda58cb( 0 );
    self notify( #"changed_prop" );
    nextprop = prop_util::getnextprop( self );
    self.usedprops[ self.var_c87757790d2ceabd ] = nextprop;
    self.var_c87757790d2ceabd++;
    
    if ( self.var_c87757790d2ceabd >= 3 )
    {
        self.var_c87757790d2ceabd = 0;
    }
    
    /#
        if ( getdvarint( @"hash_f8ba4be783de13d1", 0 ) != 0 )
        {
            if ( !isdefined( self.var_99b88e6aafafb483 ) )
            {
                self.var_99b88e6aafafb483 = 0;
            }
            
            propentry = level.propindex[ self.var_99b88e6aafafb483 ];
            nextprop = level.proplist[ propentry[ 0 ] ][ propentry[ 1 ] ];
            self.var_99b88e6aafafb483++;
            
            if ( self.var_99b88e6aafafb483 >= level.propindex.size )
            {
                self.var_99b88e6aafafb483 = 0;
            }
        }
    #/
    
    healthpercent = self.health / self.maxhealth;
    function_7a6feea14aa0f83e( nextprop );
    
    if ( prop_util::function_7bf828c229db70fb() )
    {
        self.health = max( int( healthpercent * self.maxhealth ), 1 );
    }
    
    if ( !function_b6525aee0ca7d759() )
    {
        self.changesleft--;
        self setclientomnvar( o"ui_prop_changes_remaining", self.changesleft );
    }
    
    if ( level.prop_bundle.var_7ea46841d19bff5a )
    {
        self.clonesleft = level.prop_bundle.clonesperprop;
        self setclientomnvar( o"ui_prop_clones_remaining", self.clonesleft );
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0xc5840f57, Offset: 0xb99
// Size: 0x64
function function_74370aae7c7fe123()
{
    if ( self.modelname )
    {
        if ( self.var_28c06b38aa64dc4f )
        {
            return ( self.var_28c06b38aa64dc4f + "::" + self.modelname );
        }
        
        return self.modelname;
    }
    
    if ( self.compositemodelname )
    {
        return self.compositemodelname;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace prop_controls
// Params 1
// Checksum 0xb45f6bea, Offset: 0xc06
// Size: 0x48c
function function_7a6feea14aa0f83e( propinfo )
{
    if ( self.prophidden )
    {
        function_6a8c5460d531b2de();
    }
    
    if ( self.var_2742dd3ad4b6d5af )
    {
        function_898c1b1f9a08bb57();
    }
    
    if ( self.lock )
    {
        function_59c89fe615b119af();
    }
    
    if ( isdefined( self.prop ) )
    {
        self.prop delete();
    }
    
    self.prop = spawn( "script_model", self.origin );
    self.prop.targetname = "prop";
    self.prop setentityisprop( 1, level.var_6888ad4cb966ea89 ?? 1 );
    self.prop proplinkto( self.propent );
    self.prop.owner = self;
    self.prop.health = 99999;
    self.prop.maxhealth = 99999;
    self.prop solid();
    self.prop setcandamage( 1 );
    self.prop thread prop_util::function_ab96eb7ce6578a04( &prop_util::damagewatch );
    self.prop show();
    utility::callsharedfunc( #"gametype", #"hash_1cf4167243c9f468" );
    self.prop thread prop_util::function_1a8b6bd14e6d9188();
    self.prop setscale( propinfo.propscale );
    self.prop setmodel( propinfo function_74370aae7c7fe123() );
    self.prop utility::function_32b24db3127bff40( "base", "enable" );
    self function_b63e3c462f2e452b( prop_util::function_1ec4df8434d4bfbf( propinfo ) );
    self setmovespeedscale( prop_util::function_91a77abe66add399( propinfo ) );
    self.prop.xyzoffset = ( propinfo.spawnoffsetx, propinfo.spawnoffsety, propinfo.spawnoffsetz );
    self.prop.anglesoffset = ( propinfo.anglesoffsetx, propinfo.anglesoffsety, propinfo.anglesoffsetz );
    self.prop unlink();
    self.propent unlink();
    self.propent.origin = self.origin;
    self.prop.origin = self.propent.origin;
    self.propent.angles = ( self.angles[ 0 ], self.propent.angles[ 1 ], self.angles[ 2 ] );
    self.prop.angles = self.propent.angles;
    
    if ( self.isangleoffset )
    {
        self.prop.angles = self.angles;
        self.isangleoffset = 0;
    }
    
    prop_util::applyxyzoffset();
    prop_util::applyanglesoffset();
    self.prop proplinkto( self.propent );
    
    if ( self.var_2742dd3ad4b6d5af && self.lock )
    {
        function_675c0cd078c6e71e();
    }
    
    self.propent proplinkto( self );
    prop_util::function_c6412bb9ac8de639( prop_util::getprophealth( propinfo ) );
    self setnormalhealth( 1 );
    self setpropentity( self.prop );
    self.prop function_efe38a5aece1fe83( 1 );
    
    if ( level.prop_bundle.var_3849d902b2b1d595 )
    {
        thread prop_util::function_6c11d155d255c50e();
    }
    
    if ( outline::isoutlineenabled( self, self.var_ee2e9aee4d375a6 ) )
    {
        outline::outlinedisable( self.var_ee2e9aee4d375a6, self );
        self.var_ee2e9aee4d375a6 = undefined;
    }
    
    if ( propinfo.propoutline )
    {
        self.var_ee2e9aee4d375a6 = outline::outlineenableforall( self.prop, propinfo.propoutline, "level_script", 1 );
    }
    
    self setsolid( !propinfo.var_b6c4da25d4b6a4d2 );
    self.prop.info = propinfo;
    prop_util::function_6cba282b4384d304();
}

// Namespace prop_controls
// Params 0
// Checksum 0xff13824a, Offset: 0x109a
// Size: 0x145
function function_898c1b1f9a08bb57()
{
    if ( !getdvarint( @"hash_d13563260c6c8b57", 0 ) )
    {
        if ( !self.var_2742dd3ad4b6d5af )
        {
            if ( !self.lock )
            {
                if ( !function_1fd4858920733c8b() )
                {
                    return;
                }
                
                function_8e913fbde3030c24();
            }
            
            if ( !function_9635b4d000bdec10() )
            {
                return;
            }
            
            self.var_2742dd3ad4b6d5af = 1;
            linkparent = self.propent getlinkedparent() ?? self;
            self.propent unlink();
            function_675c0cd078c6e71e();
            self.propent proplinkto( linkparent );
            return;
        }
        
        self.var_2742dd3ad4b6d5af = 0;
        
        if ( self.lock )
        {
            linkparent = self.propent getlinkedparent() ?? self;
            self.propent unlink();
            self.propent.angles = ( self.angles[ 0 ], self.propent.angles[ 1 ], self.angles[ 2 ] );
            self.propent.origin = self.origin;
            self.propent proplinkto( linkparent );
        }
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0xfb0db5c, Offset: 0x11e7
// Size: 0x42
function function_675c0cd078c6e71e()
{
    function_c8ed74ec9b0a8913( self.prop );
    self.propent.origin += ( 0, 0, self function_769d9928e26be748() );
}

// Namespace prop_controls
// Params 1
// Checksum 0x7f4ce205, Offset: 0x1231
// Size: 0x126
function function_c8ed74ec9b0a8913( traceignore )
{
    groundnormal = self getgroundnormal();
    
    if ( !isdefined( groundnormal ) || groundnormal == ( 0, 0, 0 ) )
    {
        return;
    }
    
    propyaw = ( 0, self.propent.angles[ 1 ], 0 );
    propforward = anglestoforward( propyaw );
    propright = anglestoright( propyaw );
    slopeangles = vectortoangles( groundnormal );
    pitch = angleclamp180( slopeangles[ 0 ] + 90 );
    slopeangles = ( 0, slopeangles[ 1 ], 0 );
    slopedir = anglestoforward( slopeangles );
    dot = vectordot( slopedir, propforward );
    dotright = vectordot( slopedir, propright );
    var_55d24c5acb570422 = dot * pitch;
    var_6e981a1c91bcf86f = dotright * pitch;
    self.propent.angles = ( var_55d24c5acb570422, self.propent.angles[ 1 ], var_6e981a1c91bcf86f );
}

// Namespace prop_controls
// Params 0
// Checksum 0x546a1da0, Offset: 0x135f
// Size: 0x66
function function_700d838b3b9d9028()
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_db8eabfea7043529" ) && !utility::callsharedfunc( #"gametype", #"hash_db8eabfea7043529" ) )
    {
        return 0;
    }
    
    if ( self.var_6fd01c932ee970a && self.var_6fd01c932ee970a + 500 > gettime() )
    {
        return 0;
    }
    
    return function_b4a700732ba757d4();
}

// Namespace prop_controls
// Params 0
// Checksum 0x7c440457, Offset: 0x13ce
// Size: 0x60
function propAbility()
{
    if ( !function_700d838b3b9d9028() )
    {
        return;
    }
    
    if ( level.prop_bundle.isabilityflash && !level.prop_bundle.isabilityflashandstun )
    {
        function_dcddf7eaea480be1();
    }
    else
    {
        function_fc2eadb9c9607f7d();
    }
    
    function_b4876e452afa418e();
    self.var_6fd01c932ee970a = gettime();
}

// Namespace prop_controls
// Params 0
// Checksum 0x372ba551, Offset: 0x1436
// Size: 0x2f
function function_dcddf7eaea480be1()
{
    thread propthrowgrenade( level.prop_bundle.flashgrenade, level.prop_bundle.propflashgrenade );
}

// Namespace prop_controls
// Params 0
// Checksum 0x31a9250d, Offset: 0x146d
// Size: 0x2f
function function_fc2eadb9c9607f7d()
{
    thread propthrowgrenade( level.prop_bundle.concussiongrenade, level.prop_bundle.propconcussiongrenade );
}

// Namespace prop_controls
// Params 2
// Checksum 0xa0cbd045, Offset: 0x14a4
// Size: 0xcb
function propthrowgrenade( var_8762cf76fd5b6075, var_b0bc58311cd27290 )
{
    level endon( #"game_ended", #"round_end" );
    self endon( #"death_or_disconnect", #"hash_e79ffe6977c02c64" );
    position = self.origin + ( 0, 0, 15 );
    grenade = magicgrenademanual( var_b0bc58311cd27290, position, ( 0, 0, 0 ), 0, self );
    grenade.weapon_name = var_8762cf76fd5b6075;
    grenaderadius = getgrenadedamageradius( var_b0bc58311cd27290 );
    self waittill( #"grenade_thrown" );
    grenade radiusdamage( position, grenaderadius, 1, 1, self, "MOD_EXPLOSIVE", grenade.weapon_name );
}

// Namespace prop_controls
// Params 0
// Checksum 0x5960009e, Offset: 0x1577
// Size: 0x26, Type: bool
function function_b4a700732ba757d4()
{
    /#
        if ( getdvarint( @"hash_b40c7e188c9bd610", 0 ) != 0 )
        {
            return true;
        }
    #/
    
    return self.abilityleft > 0;
}

// Namespace prop_controls
// Params 0
// Checksum 0x96873734, Offset: 0x15a6
// Size: 0x46
function function_b4876e452afa418e()
{
    /#
        if ( getdvarint( @"hash_b40c7e188c9bd610", 0 ) != 0 )
        {
            return;
        }
    #/
    
    self.abilityleft -= 1;
    self setclientomnvar( o"ui_prop_ability_remaining", self.abilityleft );
}

// Namespace prop_controls
// Params 0
// Checksum 0x23b3bcc6, Offset: 0x15f4
// Size: 0x12
function function_b413c3ddfa4ad185()
{
    if ( function_74dbffdc229213f2() )
    {
        thread cloneProp();
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0x47a9590f, Offset: 0x160e
// Size: 0x1d, Type: bool
function function_74dbffdc229213f2()
{
    if ( !isdefined( self.clonesleft ) )
    {
        return false;
    }
    
    return self.clonesleft > 0;
}

// Namespace prop_controls
// Params 0
// Checksum 0x735bae1e, Offset: 0x1634
// Size: 0x1cc
function cloneProp()
{
    if ( !isdefined( self.propclones ) )
    {
        self.propclones = [];
    }
    
    newclone = spawn( "script_model", self.prop.origin );
    newclone setentityisprop( 1, level.var_6888ad4cb966ea89 ?? 1 );
    newclone.targetname = "propClone";
    newclone setscale( self.prop.info.propscale );
    newclone setmodel( self.prop.info function_74370aae7c7fe123() );
    newclone.angles = self.prop.angles;
    newclone.health = self.health;
    newclone.playerowner = self;
    newclone.propinfo = self.prop.info;
    newclone utility::function_32b24db3127bff40( "base", "enable" );
    newclone setcandamage( 1 );
    newclone thread damage::monitordamage( newclone.health, "hitequip", &function_174f1dae9de1d99f, &function_ada2b45bdbb66fbb );
    newclone sentientpoolmanager::registersentient( "Tactical_Static", self.team );
    newclone utility::callsharedfunc( #"gametype", #"hash_c2d2d66fa9cdd850" );
    challenges::function_37e945722d6497f3( self, "prop_hunt_use_clone" );
    thread function_8c918a5692f46111( newclone );
    self.propclones[ self.propclones.size ] = newclone;
    self.clonesleft--;
    self setclientomnvar( o"ui_prop_clones_remaining", self.clonesleft );
}

// Namespace prop_controls
// Params 1
// Checksum 0x86dc3617, Offset: 0x1808
// Size: 0x5d
function function_8c918a5692f46111( newclone )
{
    level endon( #"game_ended" );
    outlineid = outline::outlineenableforteam( newclone, self.team, "outline_depth_white", "level_script" );
    utility::waittill_any_ents( self, "death_or_disconnect", newclone, "death_or_disconnect" );
    outline::outlinedisable( outlineid, newclone );
}

// Namespace prop_controls
// Params 1
// Checksum 0x9fffb7cf, Offset: 0x186d
// Size: 0x16f
function function_174f1dae9de1d99f( damagedata )
{
    if ( !isdefined( self.isdying ) )
    {
        self.isdying = 1;
    }
    
    attacker = damagedata.attacker;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
    {
        if ( isdefined( attacker.leaderboarddata[ "prop_decoys_destroyed" ] ) )
        {
            attacker.leaderboarddata[ "prop_decoys_destroyed" ] = attacker.leaderboarddata[ "prop_decoys_destroyed" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "prop_decoys_destroyed" ] ) )
        {
            [[ level.leaderboardfunc[ "prop_decoys_destroyed" ] ]]( attacker, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x67>" );
        
        if ( isdefined( attacker.pers[ "prop_decoys_destroyed" ] ) )
        {
            attacker.pers[ "prop_decoys_destroyed" ] = attacker.pers[ "prop_decoys_destroyed" ] + 1;
        }
    }
    
    attacker stats::setextrascore2( attacker.pers[ "prop_decoys_destroyed" ], "prop_decoys_destroyed" );
    attacker thread points::doscoreevent( #"hash_4981eb3b375d0d61" );
    prop_util::function_873c1489cc31954( self.origin, self.propinfo );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace prop_controls
// Params 1
// Checksum 0x367df9d5, Offset: 0x19e4
// Size: 0x74
function function_ada2b45bdbb66fbb( damagedata )
{
    if ( !isdefined( damagedata.attacker ) )
    {
        return 0;
    }
    
    if ( isplayer( damagedata.attacker ) )
    {
        if ( self.isdying )
        {
            return 0;
        }
        
        damagedata.attacker thread damagefeedback::updatedamagefeedback( "hitequip" );
        self.lastattacker = damagedata.inflictor;
    }
    
    return damagedata.damage;
}

// Namespace prop_controls
// Params 0
// Checksum 0x41eb83ec, Offset: 0x1a61
// Size: 0x71
function function_6a8c5460d531b2de()
{
    if ( !self.prophidden )
    {
        self.outlineid = outline::outlineenableforplayer( self.prop, self, level.prop_bundle.var_ca1d3c54fc0b06fb, "level_script" );
        self.prophidden = 1;
        return;
    }
    
    outline::outlinedisable( self.outlineid, self.prop );
    self.prophidden = 0;
}

// Namespace prop_controls
// Params 0
// Checksum 0x26fa7160, Offset: 0x1ada
// Size: 0x17a
function function_a622f51878a42f65()
{
    self endon( #"death", #"disconnect", #"hash_e79ffe6977c02c64" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self adsbuttonpressed() && isdefined( self.propent ) )
        {
            linkparent = self.propent getlinkedparent() ?? self;
            self.propent unlink();
            var_9c3e5f01815e7a47 = self.propent.angles[ 1 ];
            
            if ( self usinggamepad() )
            {
                var_9c3e5f01815e7a47 += self getyawmove() * level.framedurationseconds * level.prop_bundle.proprotationspeed;
            }
            else
            {
                var_9c3e5f01815e7a47 += self function_c54fea69e24b693e() * level.prop_bundle.proprotationspeedkbm;
            }
            
            self.propent.angles = ( self.propent.angles[ 0 ], var_9c3e5f01815e7a47, self.propent.angles[ 2 ] );
            self.propent.origin = linkparent.origin;
            
            if ( self.var_2742dd3ad4b6d5af && self.lock )
            {
                function_675c0cd078c6e71e();
            }
            
            self.propent proplinkto( linkparent );
        }
        
        waitframe();
    }
}

// Namespace prop_controls
// Params 0
// Checksum 0xe88844ee, Offset: 0x1c5c
// Size: 0x32, Type: bool
function function_b6525aee0ca7d759()
{
    /#
        if ( getdvarint( @"hash_f8ba4be783de13d1", 0 ) != 0 )
        {
            return true;
        }
        
        if ( getdvarint( @"hash_59db1a275cca6db3", 0 ) != 0 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace prop_controls
// Params 0
// Checksum 0xa35e0c38, Offset: 0x1c97
// Size: 0x17, Type: bool
function function_6b4ad7c007d5a0bf()
{
    return function_b6525aee0ca7d759() || self.changesleft > 0;
}

// Namespace prop_controls
// Params 1
// Checksum 0x8721f6ad, Offset: 0x1cb7
// Size: 0x1c
function proplinkto( otherent )
{
    self linkto( otherent );
    self function_7207895b28c71c79( 1 );
}

