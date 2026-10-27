// scripts\mp\common\killstreaks\loitering_munition.gsc  (hash_37df77e109b3907d.gscc) (size: 17223 Bytes / 0x4347 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeae173d1 (3940643793)
// size ...... 17223 (0x4347)
// includes .. 10  (offset: 0x3fbb)
// strings ... 47  (offset: 0x400b)
// dev strs .. 1   (offset: 0x433b)
// exports ... 45  (offset: 0x298b)
// cseg ...... 0x361 + 0x262a (0x298b)
// imports ... 118 (offset: 0x3093)
// animtree1 . 0   (offset: 0x4347)
// animtree2 . 0   (offset: 0x4347)
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;

#namespace loitering_munition;

// Namespace loitering_munition
// Params 0, eflags: 0x1
// Checksum 0x32e1d4be, Offset: 0x37f
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "loitering_munition" ), &init );
}

// Namespace loitering_munition
// Params 0, eflags: 0x4
// Checksum 0xd183d2db, Offset: 0x39e
// Size: 0x8d
function private init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "loitering_munition", &function_957ab293ec8179d6 );
    }
    
    if ( utility::issharedfuncdefined( #"loitering_munition", #"init" ) )
    {
        [[ utility::getsharedfunc( #"loitering_munition", #"init" ) ]]();
    }
    
    function_d56a7d551f56fe12();
    init_loitering_munition_vo();
    loitering_munition_initdvars();
}

// Namespace loitering_munition
// Params 0
// Checksum 0x68ac4515, Offset: 0x433
// Size: 0x94
function function_d56a7d551f56fe12()
{
    level.loiteringmunitions = [];
    level.var_68754642d6058ca8 = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.incomingloitering[ teamname ] = 0;
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0xe3c73f0c, Offset: 0x4cf
// Size: 0x7e
function init_loitering_munition_vo()
{
    game[ "dialog" ][ "loitering_munition" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "loitering_munition" + "_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ "loitering_munition" + "_crash" ] = "killstreak_remote_operator" + "_crash";
    game[ "dialog" ][ "loitering_munition" + "_confirm" ] = "killstreak_remote_operator" + "_confirm_general";
}

// Namespace loitering_munition
// Params 0
// Checksum 0x194b7102, Offset: 0x555
// Size: 0x117
function loitering_munition_initdvars()
{
    setdvarifuninitialized( @"scr_loitering_munition_debug", 0 );
    setdvarifuninitialized( @"scr_loitering_munition_debug_duration", 30 );
    setdvarifuninitialized( @"hash_172e95433cf0b88e", 350 );
    setdvarifuninitialized( @"hash_cf8d560a06e3c99a", 12 );
    setdvarifuninitialized( @"hash_c7de055e8594d50d", 5 );
    setdvarifuninitialized( @"hash_78f9a29ffb7613a4", 6 );
    setdvarifuninitialized( @"hash_58038edaa16cb940", 10000 );
    setdvarifuninitialized( @"scr_loitering_munition_fly_height", 5500 );
    setdvarifuninitialized( @"hash_d24a6beafc09520d", 3000 );
    setdvarifuninitialized( @"scr_loitering_munition_velocity", 500 );
    setdvarifuninitialized( @"hash_eb1b674b807cfef7", 65 );
    setdvarifuninitialized( @"hash_8a2477633227e955", 12 );
    setdvarifuninitialized( @"hash_370e4d3dc0144183", 20 );
    setdvarifuninitialized( @"hash_42b452745ffc05e8", 10 );
    setdvarifuninitialized( @"hash_ef3d77b4896f28bd", 20 );
    setdvarifuninitialized( @"hash_c636877e41fa349a", 5000 );
    setdvarifuninitialized( @"hash_27c3395ed27ae0da", 1 );
}

// Namespace loitering_munition
// Params 1
// Checksum 0x12837b9d, Offset: 0x674
// Size: 0x4b, Type: bool
function function_43de8d70a773bb9d( streakinfo )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"hash_bc456c37cf700436" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"hash_bc456c37cf700436" ) ]]( undefined, undefined, undefined, undefined, streakinfo );
    }
    
    return true;
}

// Namespace loitering_munition
// Params 1
// Checksum 0x1d4c2198, Offset: 0x6c8
// Size: 0x27
function function_957ab293ec8179d6( streakinfo = killstreak_utility::createstreakinfo( "loitering_munition", self ) )
{
    return function_d4e4bbff9f8f22f7( streakinfo );
}

// Namespace loitering_munition
// Params 1
// Checksum 0x68f09de, Offset: 0x6f8
// Size: 0xa0, Type: bool
function function_d4e4bbff9f8f22f7( streakinfo )
{
    team = self.team;
    
    if ( !vehicle_tracking::reserve_vehicle() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        return false;
    }
    
    result = function_c5da0ac09e276335( streakinfo );
    
    if ( !result )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
        return false;
    }
    
    self notify( #"munitions_used", "loitering_munition" );
    return true;
}

// Namespace loitering_munition
// Params 1
// Checksum 0xe24e03b5, Offset: 0x7a1
// Size: 0x2f3, Type: bool
function function_c5da0ac09e276335( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isplayer( self ) )
    {
        deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, makeweapon( "ks_remote_map_mp" ), 1, &function_43de8d70a773bb9d );
    }
    else
    {
        deployresult = 1;
    }
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    mappointinfo = undefined;
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"getselectmappoint" ) )
        {
            mappointinfo = self [[ utility::getsharedfunc( #"killstreak", #"getselectmappoint" ) ]]( streakinfo, 1 );
        }
    }
    else if ( isdefined( self.enemy ) )
    {
        mappointinfo = self.enemy.origin;
    }
    else
    {
        var_5d89fa96b0b17c11 = self.origin;
    }
    
    streakinfo.owner notify( #"killstreak_deploy_finished", streakinfo.streakname );
    
    if ( !isdefined( mappointinfo ) )
    {
        return false;
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    loitering_munition = function_8a695b1440d88fcd( streakinfo, mappointinfo );
    
    if ( !isdefined( loitering_munition ) )
    {
        return false;
    }
    
    maxrolldegrees = getdvarint( @"hash_eb1b674b807cfef7" );
    maxyawdiff = getdvarint( @"hash_8a2477633227e955" );
    var_145553ccdeeee4fe = getdvarint( @"hash_370e4d3dc0144183" );
    var_b2408d5d438efa81 = getdvarint( @"hash_42b452745ffc05e8" );
    var_22c1b97edc05d826 = getdvarint( @"hash_ef3d77b4896f28bd" );
    loitering_munition thread functionals_utility::function_d858d002df0a2feb( maxrolldegrees, maxyawdiff );
    loitering_munition thread functionals_utility::function_3d1c0cb00ce4d44e( var_145553ccdeeee4fe, var_b2408d5d438efa81, var_22c1b97edc05d826 );
    loitering_munition thread function_500240d89154b058( streakinfo );
    
    if ( isplayer( self ) )
    {
        var_65934120c2efeb81 = undefined;
        
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
            var_65934120c2efeb81 = 2;
        }
        
        thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "loitering_munition" + "_use", #"use", 1, var_65934120c2efeb81 );
        utility::trycall( level.matchdata_logkillstreakevent, "loitering_munition", self.origin );
        
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "loitering_munition", self );
        }
    }
    
    return true;
}

// Namespace loitering_munition
// Params 2
// Checksum 0x91bd54bf, Offset: 0xa9d
// Size: 0x3eb
function function_8a695b1440d88fcd( streakinfo, mappointinfo )
{
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    
    if ( isarray( mappointinfo ) )
    {
        maplocation = mappointinfo[ 0 ].location;
    }
    else
    {
        maplocation = mappointinfo;
    }
    
    droneflyheight = getdvarint( @"scr_loitering_munition_fly_height" );
    dronespawndistance = getdvarint( @"hash_58038edaa16cb940" );
    var_64b3e2d65406e6d4 = getdvarint( @"hash_d24a6beafc09520d" );
    spawnpathstart = ( maplocation[ 0 ], maplocation[ 1 ], droneflyheight ) + ( var_64b3e2d65406e6d4, 0, 0 ) + ( 0, dronespawndistance, 0 );
    loiteringmodel = bundle.loitering_model;
    loitering_munition = spawn( "script_model", spawnpathstart + ( 0, 0, droneflyheight ) );
    
    if ( !isdefined( loitering_munition ) )
    {
        return;
    }
    
    vehicle_tracking::function_4f76f5b4541acef1();
    loitering_munition setmodel( loiteringmodel );
    loitering_munition.owner = self;
    loitering_munition.team = self.team;
    loitering_munition.health = 999999;
    loitering_munition.maxhealth = bundle.maxhealth;
    loitering_munition.currenthealth = loitering_munition.maxhealth;
    loitering_munition.streakinfo = streakinfo;
    loitering_munition.streakname = streakinfo.streakname;
    loitering_munition.entrylocation = loitering_munition.origin;
    loitering_munition.maplocation = maplocation;
    loitering_munition setscriptablepartstate( "blinking_lights", "on", 0 );
    loitering_munition setscriptablepartstate( "thrusters", "active", 0 );
    loitering_munition setscriptablepartstate( "contrails", "on", 0 );
    loitering_munition.killcament = spawn( "script_model", loitering_munition gettagorigin( "tag_turret" ) );
    loitering_munition.killcament linkto( loitering_munition, "tag_origin", ( -500, 0, 500 ), ( 0, 0, 0 ) );
    level.loiteringmunitions[ level.loiteringmunitions.size ] = loitering_munition;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        loitering_munition [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 100 );
    }
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        loitering_munition.minimapid = loitering_munition [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( bundle.minimapicon, loitering_munition.team, 1, 1, 1 );
    }
    
    loitering_munition.centerpos = ( maplocation[ 0 ], maplocation[ 1 ], droneflyheight );
    loitering_munition.startpos = loitering_munition.centerpos + ( var_64b3e2d65406e6d4, 0, 0 );
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    var_7ffb14c30031ead7 = 0;
    
    if ( isdefined( heightent ) )
    {
        var_7ffb14c30031ead7 = heightent.origin[ 2 ] + 750;
    }
    
    loitering_munition.flyheight = droneflyheight;
    loitering_munition.attackheight = var_7ffb14c30031ead7;
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        loitering_munition thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( loitering_munition.maxhealth, "hitequip", &functionals_utility::functionals_handlefataldamage, &function_532a6710d12c41e8, 0 );
    }
    
    loitering_munition functionals_utility::function_f9c3bc385df6f245( streakinfo, undefined, &function_c91113d7acbd63fc );
    return loitering_munition;
}

// Namespace loitering_munition
// Params 1
// Checksum 0x1cebbc84, Offset: 0xe91
// Size: 0x60
function function_500240d89154b058( streakinfo )
{
    var_e298dcb55f5403ca = getdvarint( @"hash_c7de055e8594d50d" );
    self moveto( self.startpos, var_e298dcb55f5403ca, var_e298dcb55f5403ca * 0.1, 2 );
    self setscriptablepartstate( "movement_sfx", "enter", 0 );
    wait var_e298dcb55f5403ca;
    thread function_7e645099be2d53f7( streakinfo );
}

// Namespace loitering_munition
// Params 1
// Checksum 0x15d1268e, Offset: 0xef9
// Size: 0x19f
function function_7e645099be2d53f7( streakinfo )
{
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    flyvelocity = getdvarint( @"scr_loitering_munition_velocity" );
    thread function_6bb84ae03a6f618c( self.centerpos, self.startpos, flyvelocity );
    
    if ( isplayer( self.owner ) )
    {
        thread function_dc3f619b537b6835();
    }
    else
    {
        if ( issubstr( self.owner.agent_type, "maestro" ) )
        {
            if ( isdefined( level.exgm.bossparameters[ "Maestro" ].warlordparameters ) )
            {
                params = level.exgm.bossparameters[ "Maestro" ].warlordparameters;
            }
            
            thread utility::callsharedfunc( #"warlord_maestro", #"loiteringdeathmonitor", self );
        }
        
        thread function_743666cbb005a42f( params );
    }
    
    thread function_b0148face03c2127();
    thread function_3877444a813573cd();
    
    if ( isplayer( self.owner ) )
    {
        loiteringlifetime = bundle.loitering_lifetime;
        thread function_a2fbcfda42ddabb9( loiteringlifetime, streakinfo );
    }
    
    thread function_9d7bb7df3dc53b69();
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        self thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &function_3b702946b971f66a );
    }
}

// Namespace loitering_munition
// Params 3
// Checksum 0x813eb446, Offset: 0x10a0
// Size: 0x163
function function_6bb84ae03a6f618c( centerpos, startpos, flyvelocity )
{
    self notify( #"hash_ca59c633a924494c" );
    self endon( #"death" );
    self endon( #"hash_ca59c633a924494c" );
    self endon( #"hash_e1984df46a17d425" );
    self endon( #"leavesequence" );
    self endon( #"movetolocation" );
    level endon( #"game_ended" );
    anglevector = centerpos - startpos;
    flyradius = distance( startpos, centerpos );
    totaltime = float( 6.28 * flyradius / flyvelocity ) * 1000;
    starttime = gettime();
    startangle = 0;
    endangle = -180;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        assert( totaltime > 0 );
        fraction = min( timepassed / totaltime, 1 );
        var_a5339e30ffa145c1 = math::angle_lerp( startangle, endangle, fraction );
        newvector = rotatevector( anglevector, ( 0, var_a5339e30ffa145c1, 0 ) );
        newpos = centerpos - newvector;
        self.origin = newpos;
        
        if ( fraction == 1 )
        {
            starttime = gettime();
            anglevector = newvector;
        }
        
        waitframe();
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0xdccb2681, Offset: 0x120b
// Size: 0x1b0
function function_b0148face03c2127()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    loiteringowner = self.owner;
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    
    if ( isplayer( loiteringowner ) )
    {
        loiteringowner thread function_148281622d28f946();
        loiteringowner notifyonplayercommand( "loitering_munition_trigger", "+loitering_munition_trigger" );
    }
    
    self.missilefireside = undefined;
    armdelay = getdvarint( @"hash_27c3395ed27ae0da" );
    wait armdelay;
    
    if ( isplayer( loiteringowner ) )
    {
        isusinggamepad = self.owner utility::is_player_gamepad_enabled();
        hintref = &"killstreaks_hints/loitering_munition_kbm_hint";
        
        if ( isusinggamepad )
        {
            hintref = &"killstreaks_hints/loitering_munition_controller_hint";
        }
        
        killstreak_utility::function_92b58f17af03198f( self.streakinfo.streakname, self.owner, hintref, #"fire_rockets", 1 );
        self.useobj setuseholdduration( 250 );
        self.useobj setcursorhint( "HINT_NOICON" );
        thread function_1c50bbac63b0449f();
    }
    
    while ( true )
    {
        loiteringowner waittill( #"loitering_munition_trigger" );
        
        if ( !self.ismoving )
        {
            if ( isplayer( loiteringowner ) )
            {
                killstreak_utility::function_bea4bda17e40ffb0( self.owner, self.useobj );
            }
            
            thread function_70585159b44b7822();
            break;
        }
    }
    
    loiteringowner notifyonplayercommandremove( "loitering_munition_trigger", "+loitering_munition_trigger" );
}

// Namespace loitering_munition
// Params 0
// Checksum 0x18ed60b6, Offset: 0x13c3
// Size: 0x9e
function function_148281622d28f946()
{
    self endon( #"attacksequence_started" );
    self notifyonplayercommand( "LStickPress", "+breath_sprint" );
    self notifyonplayercommand( "LStickPress", "+actionslot 1" );
    self notifyonplayercommand( "RStickPress", "+melee_zoom" );
    self notifyonplayercommand( "RStickPress", "+stance" );
    self.lstickpressed = 0;
    self.rstickpressed = 0;
    thread function_8b5dcc3603d09dce();
    thread function_a61ad0b8a266ed44();
    
    while ( true )
    {
        if ( self.lstickpressed && self.rstickpressed )
        {
            self notify( #"loitering_munition_trigger" );
        }
        
        waitframe();
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0x8d3e684a, Offset: 0x1469
// Size: 0x33
function function_8b5dcc3603d09dce()
{
    while ( true )
    {
        self waittill( #"LStickPress" );
        self.lstickpressed = 1;
        wait 0.1;
        self.lstickpressed = 0;
        waitframe();
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0xeb0e582d, Offset: 0x14a4
// Size: 0x33
function function_a61ad0b8a266ed44()
{
    while ( true )
    {
        self waittill( #"RStickPress" );
        self.rstickpressed = 1;
        wait 0.1;
        self.rstickpressed = 0;
        waitframe();
    }
}

// Namespace loitering_munition
// Params 1
// Checksum 0xa0c57277, Offset: 0x14df
// Size: 0x9d
function function_743666cbb005a42f( ai_params )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        while ( !isdefined( self.owner.enemy ) )
        {
            wait 2;
        }
        
        thread function_2589679550bf4422( 1, self.owner.enemy, ai_params );
        delay = ai_params.var_a01ad51c6e1300cc;
        wait delay;
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0x8801fef0, Offset: 0x1584
// Size: 0xe3
function function_70585159b44b7822()
{
    self notify( #"attacksequence_started" );
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    totalswoops = bundle.var_ecb4e125a485c98e;
    var_846c26da3fd829e = bundle.loitering_wavedelay;
    
    for ( var_2f326a3aa6de9f56 = 0; var_2f326a3aa6de9f56 < totalswoops ; var_2f326a3aa6de9f56++ )
    {
        self playsoundonmovingent( "kls_loitering_munition_dive" );
        thread function_2589679550bf4422( 1 );
        function_65d972fe6405a8a6();
        flyvelocity = getdvarint( @"scr_loitering_munition_velocity" );
        self.startpos = self.origin;
        thread function_6bb84ae03a6f618c( self.centerpos, self.startpos, flyvelocity );
        wait var_846c26da3fd829e;
    }
    
    function_c6510cae9300ffce( 1 );
}

// Namespace loitering_munition
// Params 0
// Checksum 0x22cbf291, Offset: 0x166f
// Size: 0x1b8
function function_65d972fe6405a8a6()
{
    self notify( #"hash_e1984df46a17d425" );
    divestartposition = self.origin;
    diveheight = 3250;
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        diveheight = heightent.origin[ 2 ];
    }
    
    divetargetposition = ( self.centerpos[ 0 ], self.centerpos[ 1 ], diveheight );
    circlemidpoint = divestartposition - ( divestartposition - divetargetposition ) / 2;
    divetime = getdvarint( @"hash_c636877e41fa349a" );
    var_bc823ebf842c9958 = divetime / 2;
    elapsedtime = 0;
    var_c6326e28dd478523 = 1.6;
    var_3e8e8cb2ba9f9225 = 1.6;
    divestarttime = gettime();
    
    while ( elapsedtime < divetime )
    {
        elapsedtime = gettime() - divestarttime;
        var_851ad60162111176 = 0;
        
        if ( elapsedtime < var_bc823ebf842c9958 )
        {
            var_851ad60162111176 = elapsedtime / var_bc823ebf842c9958;
            verticalcomponent = vectorlerp( divestartposition, divetargetposition, easepower( var_851ad60162111176, var_c6326e28dd478523, 1, 0 ) );
        }
        else
        {
            var_851ad60162111176 = ( elapsedtime - var_bc823ebf842c9958 ) / var_bc823ebf842c9958;
            verticalcomponent = vectorlerp( divetargetposition, divestartposition, easepower( var_851ad60162111176, var_c6326e28dd478523, 1, 1 ) );
        }
        
        var_f5d5979768e60b44 = easepower( elapsedtime / divetime, var_3e8e8cb2ba9f9225, 1, 1 );
        circleangles = ( 0, math::lerp( 360, 0, var_f5d5979768e60b44 ), 0 );
        anglevector = divestartposition - circlemidpoint;
        circlecomponent = circlemidpoint + rotatevector( anglevector, circleangles );
        self.origin = ( circlecomponent[ 0 ], circlecomponent[ 1 ], verticalcomponent[ 2 ] );
        waitframe();
    }
}

// Namespace loitering_munition
// Params 3
// Checksum 0xa664dd16, Offset: 0x182f
// Size: 0x21b
function function_2589679550bf4422( delaytime, targetoverride, ai_params )
{
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    var_8185723ccaf73fcf = bundle.var_67826a300520b881;
    var_16c10b17e4f1d47e = bundle.var_ed12d2351e771de7;
    missileradius = bundle.var_c612b6b48a6b5e9e;
    var_23ccba0f6f1d048d = 3;
    
    if ( isdefined( delaytime ) )
    {
        wait delaytime;
    }
    
    if ( isdefined( self.owner ) && !isplayer( self.owner ) )
    {
        if ( isdefined( ai_params ) )
        {
            var_8185723ccaf73fcf = ai_params.var_2be99f60b29a6504;
            var_16c10b17e4f1d47e = ai_params.var_44ec90a21f025837;
            missileradius = ai_params.var_cf057f294d9cf683;
            var_23ccba0f6f1d048d = ai_params.var_ba2d734e8ba59472;
        }
    }
    
    var_b7f9287b2724c282 = ceil( float( var_8185723ccaf73fcf - 1 ) / float( var_23ccba0f6f1d048d ) );
    var_5e544bc74ea52480 = missileradius / var_b7f9287b2724c282;
    radiusbuffer = var_5e544bc74ea52480 * 0.2;
    var_8cbfd47876fa06b0 = 360 / var_23ccba0f6f1d048d;
    anglebuffer = var_8cbfd47876fa06b0 * 0.2;
    thread function_c365cbb41b36a210( radiusbuffer, var_5e544bc74ea52480 - radiusbuffer, 0, 360, targetoverride );
    hostmigration::waitlongdurationwithpause( var_16c10b17e4f1d47e );
    
    for ( var_cbe448d097443768 = 1; var_cbe448d097443768 < var_b7f9287b2724c282 ; var_cbe448d097443768++ )
    {
        var_45819821a5d6d5e1 = var_cbe448d097443768 * var_5e544bc74ea52480 + radiusbuffer;
        var_880ed7483b440364 = var_45819821a5d6d5e1 + var_5e544bc74ea52480 - radiusbuffer;
        var_19ae16b8055009af = min( var_23ccba0f6f1d048d, var_8185723ccaf73fcf - 1 - ( var_cbe448d097443768 - 1 ) * var_23ccba0f6f1d048d );
        
        for ( var_c7d4161e0dd4f81 = 0; var_c7d4161e0dd4f81 < var_19ae16b8055009af ; var_c7d4161e0dd4f81++ )
        {
            startangle = var_c7d4161e0dd4f81 * var_8cbfd47876fa06b0 + anglebuffer;
            endangle = ( var_c7d4161e0dd4f81 + 1 ) * var_8cbfd47876fa06b0 - anglebuffer;
            thread function_c365cbb41b36a210( var_45819821a5d6d5e1, var_880ed7483b440364, startangle, endangle, targetoverride, var_c7d4161e0dd4f81 );
            hostmigration::waitlongdurationwithpause( var_16c10b17e4f1d47e );
        }
    }
}

// Namespace loitering_munition
// Params 6
// Checksum 0xa1c237b, Offset: 0x1a52
// Size: 0x14d
function function_c365cbb41b36a210( startradius, endradius, startangle, endangle, targetoverride, missilenum )
{
    randomradius = randomintrange( int( startradius ), int( endradius ) );
    randomangle = ( 0, randomintrange( int( startangle ), int( endangle ) ), 0 );
    
    if ( isdefined( targetoverride ) )
    {
        if ( isvector( targetoverride ) )
        {
            radiuscenter = targetoverride;
        }
        else if ( isdefined( targetoverride.origin ) )
        {
            radiuscenter = targetoverride.origin;
        }
        else
        {
            var_d8d7fe4c5acbd0a5 = self.centerpos;
        }
    }
    else
    {
        radiuscenter = self.centerpos;
    }
    
    anglevector = ( randomradius, 0, 0 );
    anglevector = rotatevector( anglevector, randomangle );
    targetvector = radiuscenter + anglevector;
    targetvector = ( targetvector[ 0 ], targetvector[ 1 ], 0 );
    
    if ( !isdefined( missilenum ) )
    {
        missilenum = 1;
    }
    
    index = missilenum % 4 + 1;
    self setscriptablepartstate( "fire_missile_" + index, "off", 0 );
    self setscriptablepartstate( "fire_missile_" + index, "on", 0 );
    thread function_fded4e8b67732d83( targetvector );
}

// Namespace loitering_munition
// Params 1
// Checksum 0x401ce8fd, Offset: 0x1ba7
// Size: 0x1a9
function function_fded4e8b67732d83( targetlocation )
{
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    firedirection = vectornormalize( targetlocation - self.origin );
    missilestart = self.origin + firedirection * 250;
    missile_ref = bundle.loitering_missileweapon;
    missile = weapon_utility::_magicbullet( makeweapon( missile_ref ), missilestart, targetlocation, self.owner );
    missile.streakinfo = self.streakinfo;
    missile playsoundonmovingent( "kls_loitering_munition_proj_travel" );
    missile.killcament = spawn( "script_model", missile.origin );
    missile.killcament linkto( missile, "tag_origin", ( -100, 0, 500 ), ( 0, 0, 0 ) );
    missile.killcament thread function_91e4ff043c3f0395( targetlocation, missile.angles );
    missile thread function_5e3e79e179eef44b( targetlocation );
    missile thread function_190fb42927eecb16( self.owner );
    self notify( #"fired_missile", missile );
    debugactive = getdvarint( @"scr_loitering_munition_debug" );
    
    /#
        debugduration = getdvarint( @"scr_loitering_munition_debug_duration" );
        
        if ( debugactive )
        {
            line( missilestart, targetlocation, ( 255, 0, 0 ), 1, 0, debugduration );
        }
    #/
}

// Namespace loitering_munition
// Params 1
// Checksum 0xf50b97bf, Offset: 0x1d58
// Size: 0x31
function function_5e3e79e179eef44b( missiletargetpos )
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( 0.05 );
    
    if ( isdefined( self ) )
    {
        self missile_settargetpos( missiletargetpos );
    }
}

// Namespace loitering_munition
// Params 1
// Checksum 0x7edfbb14, Offset: 0x1d91
// Size: 0x9b
function function_190fb42927eecb16( owner )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"explode", position );
    owner notify( #"hash_1d549d1ced46afba", position );
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_eafb9a6b88def4ca", position, owner.team, owner );
    }
}

// Namespace loitering_munition
// Params 2
// Checksum 0x2a14c66c, Offset: 0x1e34
// Size: 0x54
function function_91e4ff043c3f0395( impactlocation, missileangles )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( 2 );
    self unlink();
    self moveto( impactlocation - anglestoforward( missileangles ) * 750, 6 );
    hostmigration::waitlongdurationwithpause( 7 );
    self delete();
}

// Namespace loitering_munition
// Params 1
// Checksum 0xba2024d6, Offset: 0x1e90
// Size: 0x58
function function_20b25faff3a87c1a( missileindex )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "fire_missile_" + missileindex, "on", 0 );
    hostmigration::waitlongdurationwithpause( 1 );
    self setscriptablepartstate( "fire_missile_" + missileindex, "off", 0 );
}

// Namespace loitering_munition
// Params 4
// Checksum 0x9c44e02d, Offset: 0x1ef0
// Size: 0x184
function function_3b702946b971f66a( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    missiletarget endon( #"death" );
    missiletarget endon( #"crashing" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
            {
                [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( missiletarget );
            }
            
            if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
            {
                missiletarget thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( "jet_flares", fxtagoverride );
            }
            
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        
        waitframe();
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0xf82f01ab, Offset: 0x207c
// Size: 0xed
function function_1c50bbac63b0449f()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    while ( isdefined( self.useobj ) )
    {
        timeused = 0;
        self.useobj waittill( #"trigger", player );
        
        if ( player utility::isusingremote() )
        {
            continue;
        }
        
        self setscriptablepartstate( "thrusters", "active", 0 );
        
        /#
            debugon = getdvarint( @"scr_loitering_munition_debug" );
            
            if ( debugon )
            {
                player iprintlnbold( "<dev string:x24>" );
            }
        #/
        
        if ( isdefined( player ) )
        {
            goalposition = ( player.origin[ 0 ], player.origin[ 1 ], self.origin[ 2 ] );
            thread function_24baea74a7948130( goalposition );
        }
    }
}

// Namespace loitering_munition
// Params 1
// Checksum 0xaf1f14b9, Offset: 0x2171
// Size: 0x118
function function_24baea74a7948130( targetpos )
{
    self notify( #"movetolocation" );
    self.ismoving = 1;
    killstreak_utility::function_bea4bda17e40ffb0( self.owner, self.useobj );
    flyradius = getdvarfloat( @"hash_d24a6beafc09520d" );
    flyvelocity = getdvarfloat( @"scr_loitering_munition_velocity" );
    movestartpos = self.origin;
    self.centerpos = targetpos;
    self.startpos = self.centerpos + vectornormalize( movestartpos - self.centerpos ) * flyradius;
    movedistance = distance( targetpos, movestartpos );
    movetime = movedistance / flyvelocity;
    self moveto( self.startpos, movetime );
    wait movetime;
    self.ismoving = 0;
    killstreak_utility::function_c463ddccb4054cc2( self.owner );
    thread function_6bb84ae03a6f618c( self.centerpos, self.startpos, flyvelocity );
}

// Namespace loitering_munition
// Params 2
// Checksum 0xeaee934a, Offset: 0x2291
// Size: 0x75
function function_a2fbcfda42ddabb9( lifetime, streakinfo )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( lifetime );
    killstreak_utility::playkillstreaktacomdialog( streakinfo, "loitering_munition" + "_leave", #"leave", 1 );
    thread function_c6510cae9300ffce( 0 );
}

// Namespace loitering_munition
// Params 0
// Checksum 0x411c1d58, Offset: 0x230e
// Size: 0x7a
function function_3877444a813573cd()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0x7e24af74, Offset: 0x2390
// Size: 0x4a
function function_dc3f619b537b6835()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    thread function_49c511c9058145cf( "disconnect" );
    thread function_49c511c9058145cf( "joined_team" );
}

// Namespace loitering_munition
// Params 1
// Checksum 0xdb207633, Offset: 0x23e2
// Size: 0x52
function function_49c511c9058145cf( notifymsg )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self.owner waittill( notifymsg );
    thread function_c6510cae9300ffce( 0 );
}

// Namespace loitering_munition
// Params 1
// Checksum 0xf5cdb3a7, Offset: 0x243c
// Size: 0xbc
function function_c6510cae9300ffce( hastriggered )
{
    bundle = level.streakglobals.streakbundles[ "loitering_munition" ];
    
    if ( !hastriggered && bundle.var_625b89d9d3f280b8 )
    {
        function_65d972fe6405a8a6();
    }
    
    self notify( #"leavesequence" );
    var_4491de27d1c08ea9 = getdvarint( @"hash_78f9a29ffb7613a4" );
    exitlocation = self.origin + anglestoforward( self.angles ) * 10000;
    self moveto( exitlocation, var_4491de27d1c08ea9, 1 );
    self setscriptablepartstate( "movement_sfx", "exit", 0 );
    wait var_4491de27d1c08ea9;
    function_71a107ee343705ad( 0 );
}

// Namespace loitering_munition
// Params 0
// Checksum 0x376a2fab, Offset: 0x2500
// Size: 0x4a
function function_9d7bb7df3dc53b69()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    thread function_d6ef9393da59924e();
    self setscriptablepartstate( "thrusters", "idle", 0 );
}

// Namespace loitering_munition
// Params 1
// Checksum 0xefb4781b, Offset: 0x2552
// Size: 0x65
function function_532a6710d12c41e8( data )
{
    if ( !isdefined( self.currenthealth ) )
    {
        self.currenthealth = self.maxhealth;
    }
    
    modifieddamage = functionals_utility::functionals_handledamage( data );
    self.currenthealth -= modifieddamage;
    killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
    return modifieddamage;
}

// Namespace loitering_munition
// Params 0
// Checksum 0xb1f1e274, Offset: 0x25c0
// Size: 0x12
function function_401cb5584cbb2605()
{
    self setscriptablepartstate( "body_damage_light", "on" );
}

// Namespace loitering_munition
// Params 0
// Checksum 0x4be7550, Offset: 0x25da
// Size: 0x12
function function_462a5622d64fe4b6()
{
    self setscriptablepartstate( "body_damage_medium", "on" );
}

// Namespace loitering_munition
// Params 0
// Checksum 0x1992c18d, Offset: 0x25f4
// Size: 0x12
function function_11629912ef9c63f4()
{
    self setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace loitering_munition
// Params 0
// Checksum 0xb1da9f5a, Offset: 0x260e
// Size: 0x65
function function_d6ef9393da59924e()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"missile_fire", projectile );
        projectile.streakinfo = self.streakinfo;
        projectile.killcament = self.killcament;
    }
}

// Namespace loitering_munition
// Params 0
// Checksum 0xc5242af3, Offset: 0x267b
// Size: 0x2e
function function_c91113d7acbd63fc()
{
    self notify( #"explode" );
    self setscriptablepartstate( "explode", "on", 0 );
    wait 0.35;
    thread function_71a107ee343705ad( 1 );
}

// Namespace loitering_munition
// Params 1
// Checksum 0xa15bc6ee, Offset: 0x26b1
// Size: 0x169
function function_71a107ee343705ad( wasdestroyed )
{
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    self setscriptablepartstate( "blinking_lights", "off", 0 );
    self setscriptablepartstate( "thrusters", "off", 0 );
    loiteringowner = self.owner;
    loiteringowner notifyonplayercommandremove( "LStickPress", "+breath_sprint" );
    loiteringowner notifyonplayercommandremove( "LStickPress", "+actionslot 1" );
    loiteringowner notifyonplayercommandremove( "RStickPress", "+melee_zoom" );
    loiteringowner notifyonplayercommandremove( "RStickPress", "+stance" );
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    level.loiteringmunitions = arrayremove( level.loiteringmunitions, self );
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    self delete();
}

/#

    // Namespace loitering_munition
    // Params 3
    // Checksum 0x33342857, Offset: 0x2822
    // Size: 0x169, Type: dev
    function function_5056a735d80c69f( aabbmin, aabbmax, duration )
    {
        self notify( #"hash_9e5b01133d526474" );
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"hash_9e5b01133d526474" );
        drawcolor = ( 0, 255, 0 );
        var_a5ccc18b2dcf3501 = ( aabbmax[ 0 ] - aabbmin[ 0 ], 0, 0 );
        var_dfbdac49197a14fa = ( 0, aabbmax[ 1 ] - aabbmin[ 1 ], 0 );
        var_1a919c03f8b2c732 = ( 0, 0, aabbmax[ 2 ] - aabbmin[ 2 ] );
        line( aabbmin, aabbmin + ( aabbmax - aabbmin ) / 2, drawcolor, 1, 0, duration );
        line( aabbmin, aabbmin + var_a5ccc18b2dcf3501, drawcolor, 1, 0, duration );
        line( aabbmin, aabbmin + var_dfbdac49197a14fa, drawcolor, 1, 0, duration );
        line( aabbmin, aabbmin + var_1a919c03f8b2c732, drawcolor, 1, 0, duration );
        sphere( aabbmin, 5, drawcolor, 0, duration );
        drawcolor = ( 255, 0, 0 );
        line( aabbmax, aabbmax + ( aabbmin - aabbmax ) / 2, drawcolor, 1, 0, duration );
        line( aabbmax, aabbmax - var_a5ccc18b2dcf3501, drawcolor, 1, 0, duration );
        line( aabbmax, aabbmax - var_dfbdac49197a14fa, drawcolor, 1, 0, duration );
        line( aabbmax, aabbmax - var_1a919c03f8b2c732, drawcolor, 1, 0, duration );
        sphere( aabbmax, 5, drawcolor, 0, duration );
    }

#/
