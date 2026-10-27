// scripts\mp\common\killstreaks\airdrop.gsc  (hash_400030cfadc03f31.gscc) (size: 122755 Bytes / 0x1df83 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf7b163f (3480950335)
// size ...... 122755 (0x1df83)
// includes .. 42  (offset: 0x1c97b)
// strings ... 251 (offset: 0x1cacb)
// dev strs .. 51  (offset: 0x1dc1b)
// exports ... 293 (offset: 0x14457)
// cseg ...... 0x1513 + 0x12f44 (0x14457)
// imports ... 661 (offset: 0x1721f)
// animtree1 . 2   (offset: 0x1deb3)
// animtree2 . 11  (offset: 0x1ded3)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\common\visibility_mode;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\entityheadicons;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\sentientpoolmanager;

#namespace airdrop;

// Namespace airdrop
// Params 0
// Checksum 0x25782416, Offset: 0x1531
// Size: 0x167
function init()
{
    utility::callsharedfunc( #"airdrop", #"init" );
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    level._effect[ "airdrop_crate_impact_ground" ] = loadfxasset( bundle.var_9521dd7e6e6d9020 ?? "vfx_iw9_strk_smoke_signal_carepkg_landing_dust" );
    level._effect[ "airdrop_crate_impact_water" ] = loadfxasset( bundle.var_3c72495a67e87a9e ?? "vfx_iw9_strk_smoke_signal_carepkg_landing_water" );
    level.carepackagedropnodes = getentarray( "carepackage_drop_area", #targetname );
    level.var_b3201a857e731284 = getdvarint( @"scr_airdrop_common_item", 2 );
    initkillstreak();
    initheli();
    initcratedata();
    function_4899b9f58533fad4();
    init_airdrop_vo();
    function_10ea3a42505e0ba8();
    
    if ( getdvarint( @"hash_d52f9a7ae705ece", 0 ) == 1 )
    {
        function_79183053f61d4891();
    }
    
    utility::callsharedfunc( #"airdrop", #"airdropmultipleinit" );
    utility::callsharedfunc( #"airdrop", #"airdropescortinit" );
    
    if ( isdefined( bundle.deployweaponname ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "airdrop", bundle.deployweaponname, #"donotregister" );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xc8b2b695, Offset: 0x16a0
// Size: 0xa9
function initkillstreak()
{
    /#
        setdevdvarifuninitialized( @"scr_crateoverride", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_22186e8d4f1020da", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_23ed746952207d2b", 1200 );
        setdevdvarifuninitialized( @"hash_87413e0e6fc00a5f", 600 );
        setdevdvarifuninitialized( @"scr_airdrop_sticky", 0 );
        setdevdvarifuninitialized( @"scr_airdrop_ownership", 0 );
        setdevdvarifuninitialized( @"hash_a62fccdf77b23d67", 0 );
        setdevdvarifuninitialized( @"scr_airdrop_use_weapon", 1 );
        setdevdvarifuninitialized( @"hash_d1c5f84bb717c57", 0 );
        setdevdvarifuninitialized( @"scr_airdrop_water_impact", 1 );
    #/
}

// Namespace airdrop
// Params 0
// Checksum 0xba618fda, Offset: 0x1751
// Size: 0x25
function initheli()
{
    level.littlebirds = [];
    utility::callsharedfunc( #"airdrop", #"registerscoreinfo" );
}

// Namespace airdrop
// Params 0
// Checksum 0x8cb7a737, Offset: 0x177e
// Size: 0x331
function initcratedata()
{
    leveldata = spawnstruct();
    leveldata.configs = [];
    leveldata.crates = [];
    leveldata.usablecrates = [];
    level.cratedata = leveldata;
    level.cratedata.unresolvedcollisiontolerancesqr = pow( getdvarfloat( @"hash_a0cbf9e8d23fb12c", 2 ), 2 );
    
    /#
        var_f49b9544396e05ea = getentarray( "<dev string:x25>", #targetname );
        assert( isdefined( var_f49b9544396e05ea ), "<dev string:x36>" );
        assert( isdefined( var_f49b9544396e05ea ) && var_f49b9544396e05ea.size <= 1, "<dev string:x64>" );
    #/
    
    level.cratedata.mountmantlemodel = getent( "care_package_col", #targetname );
    level.cratedata.crateDestroyThrottle = throttle::throttle_initialize( "crateDestroyThrottle", 5, level.framedurationseconds, 50 );
    utility::callsharedfunc( #"airdrop", #"registeractionset" );
    gametype = "mp";
    
    if ( isbrgamemode() )
    {
        gametype = "br";
    }
    else
    {
        gametype = game_utility::getgametype();
    }
    
    switch ( gametype )
    {
        case #"hash_1a53256c17b7d2ee":
        case #"hash_7fb7ea2cb6529446":
        case #"hash_b7ddfbe1d0e2457a":
        case #"hash_c4f97a56da3b7cde":
        case #"hash_c636c850b4f608fd":
        case #"hash_dcb9324af7bb9f35":
            utility::callsharedfunc( #"airdrop", #"getgamemodespecificcratedata" );
        case #"hash_fa21c4f6bd5e3815":
            initkillstreakcratedata();
            initdropzonekillstreakcratedata();
            function_c06b02fb0c4450d3();
            initbattleroyalec130airdropcratedata();
            initbattleroyalelootchoppercratedata();
            initbattleroyalejuggernautcratedata();
            function_1f69008e8ca9fd06();
            function_d10c6d162d5d1216();
            function_46d9c17b7b6ba509();
            function_7807eb9e1ad62087();
            break;
        case #"hash_ca6516c10db2c95":
        case #"hash_7f9c384a34cc392f":
            initarmcratedata();
            initkillstreakcratedata();
            initdropzonekillstreakcratedata();
            function_c06b02fb0c4450d3();
            function_cbd29a2dd516680d();
            break;
        case #"hash_b9458959b10637f8":
        case #"hash_dd5b900f435d3f36":
        case #"hash_ddd385f0a27d71bb":
            initdropzonekillstreakcratedata();
            function_c06b02fb0c4450d3();
            break;
        case #"hash_c065cef60f38490a":
            function_e9e0ed77db3e85fc();
            initkillstreakcratedata();
            function_c06b02fb0c4450d3();
            break;
        default:
            initkillstreakcratedata();
            function_c06b02fb0c4450d3();
            function_7807eb9e1ad62087();
            break;
    }
    
    utility::callsharedfunc( #"airdrop", #"getmapspecificcratedata" );
    initcratedropdata();
    callback::add( #"mantle_begin", &function_6eecc517e4bdf52b );
    utility::registersharedfunc( #"airdrop_crate", #"hack", &hack );
    thread watchallcrateusability();
    function_786e8501a325fa33();
    utility::flag_set( "airdrop_init_crate_data" );
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0xb2c94753, Offset: 0x1ab7
// Size: 0x12b
function private hack( hackeffect, attacker )
{
    if ( !self.boobytrapped )
    {
        boobytrapfunc = level.sharedfuncs[ #"blackhat" ][ #"boobytrapcrate" ];
        
        if ( !boobytrapfunc )
        {
            return;
        }
        
        self thread [[ boobytrapfunc ]]( attacker );
        self.boobytrapped = 1;
        attacker challenges::function_8e891c96efe9f293( "airdrop_escort" );
        level.var_80c6e313f9c36e80 = function_a5c1175d3ea3c25a( level.var_80c6e313f9c36e80, self );
        
        if ( level.var_80c6e313f9c36e80.size <= 0 )
        {
            level.var_80c6e313f9c36e80 = undefined;
        }
        
        leveldata = getleveldata( self.cratetype );
        
        if ( isdefined( leveldata.capturecallback ) )
        {
            if ( self.owner )
            {
                self.owner thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"stolen_hacked" );
            }
            
            attacker.var_44d0b4d50106847e = 1;
            self thread [[ leveldata.capturecallback ]]( attacker );
            attacker.var_44d0b4d50106847e = undefined;
        }
        
        thread watchcratedestroyearly();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x2aeb9f7a, Offset: 0x1bea
// Size: 0x45
function function_4899b9f58533fad4()
{
    level.var_d6dbcfd3322e6005 = "airdrop_placement";
    val::group_register( level.var_d6dbcfd3322e6005, [ "offhand_weapons", "melee", "execution_attack", "weapon_pickup" ] );
}

// Namespace airdrop
// Params 0
// Checksum 0x7ae4def6, Offset: 0x1c37
// Size: 0x1b
function init_airdrop_vo()
{
    game[ "dialog" ][ "airdrop_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace airdrop
// Params 1
// Checksum 0x725e5f71, Offset: 0x1c5a
// Size: 0x6e
function getleveldata( cratetype )
{
    assert( isdefined( level.cratedata ), "<dev string:xa9>" );
    leveldata = level.cratedata.configs[ cratetype ];
    
    if ( !isdefined( leveldata ) )
    {
        leveldata = getemptyleveldata();
        level.cratedata.configs[ cratetype ] = leveldata;
    }
    
    return leveldata;
}

// Namespace airdrop
// Params 0
// Checksum 0xd04f1f14, Offset: 0x1cd1
// Size: 0x24c
function getemptyleveldata()
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    minimapicon = killstreak_utility::function_d734101502c23572( "airdrop" ) ?? "hud_icon_minimap_killstreak_carepackage";
    leveldata = { #supportsothercapture:1, #supportsownercapture:1, #supportsreroll:0, #headicon:minimapicon, #rerollstring:&"KILLSTREAKS_HINTS/CRATE_REROLL", #capturestring:bundle.var_d926f4ab63048f5e ?? &"killstreaks_hints/crate_pickup", #capturevisualsdeletiondelay:getdefaultcapturevisualsdeletiondelay(), #capturevisualscallback:getdefaultcapturevisualscallback(), #destroyvisualsdeletiondelay:getdefaultdestroyvisualsdeletiondelay(), #destroyvisualscallback:getdefaultdestroyvisualscallback(), #var_8d45872a539aa837:0, #hasnointeraction:0, #onecaptureperplayer:0, #var_22cefb9f8c5c26d2:0, #destroyoncapture:1, #dangerzoneradius:128, #dangerzoneheight:1000, #navobstacleupdatedistsqr:64, #navobstaclebounds:( 30, 10, 64 ), #exclusiveuse:0, #friendlyuseonly:0, #enemyusetime:3, #friendlyusetime:0.5, #ownerusetime:0.5, #usepriority:0, #usefov:360, #breakuserangesqr:30625, #userange:128, #usetag:"tag_use", #minimapicon:minimapicon, #headiconnaturalrange:400, #headicondrawrange:10000, #headiconoffset:0, #timeout:bundle.var_d060572cec0dc7be ?? 90, #objweapon:nullweapon(), #mountmantlemodel:getdefaultmountmantlemodel(), #halfheight:27.5, #basemodel:"military_carepackage_03_mp" };
    return leveldata;
}

// Namespace airdrop
// Params 1
// Checksum 0x1f04ac68, Offset: 0x1f26
// Size: 0x23, Type: bool
function hasleveldata( cratetype )
{
    return isdefined( level.cratedata.configs[ cratetype ] );
}

// Namespace airdrop
// Params 0
// Checksum 0xd94de894, Offset: 0x1f52
// Size: 0x1d
function function_10ea3a42505e0ba8()
{
    level.var_3274d32eee49c85 = getnoentvolumearray( "care_package_physics_on_trigger", #targetname );
}

// Namespace airdrop
// Params 14
// Checksum 0xee6d1151, Offset: 0x1f77
// Size: 0x7b2
function createcrate( owner, team, cratetype, position, angles, destination, hasnophysics, var_e9a9d186782e327b, data, skipminimapicon, markerposition, streakinfo, var_35efbbc9c198b2f3, var_f1b1db4ae9e5ccbc )
{
    assert( hasleveldata( cratetype ), "<dev string:xd7>" );
    leveldata = getleveldata( cratetype );
    
    if ( leveldata.supportsownercapture )
    {
        assert( isdefined( owner ), "<dev string:x107>" );
    }
    
    if ( leveldata.supportsreroll )
    {
        assert( isdefined( owner ), "<dev string:x13e>" );
    }
    
    crate = spawn( "script_model", position );
    crate.angles = angles;
    
    if ( !var_f1b1db4ae9e5ccbc )
    {
        var_e5b7cf20763b32e = 1;
        
        if ( !var_e9a9d186782e327b && cratetype == "battle_royale_c130_loot" )
        {
            var_e5b7cf20763b32e = 0;
        }
        else if ( cratetype == "battle_royale_cash_crate" )
        {
            var_e5b7cf20763b32e = 0;
        }
        
        if ( var_e5b7cf20763b32e )
        {
            if ( utility::issharedfuncdefined( #"entity", #"touchingbadtrigger" ) )
            {
                if ( crate [[ utility::getsharedfunc( #"entity", #"touchingbadtrigger" ) ]]() )
                {
                    crate delete();
                    return;
                }
            }
        }
    }
    
    if ( !isdefined( crate ) )
    {
        println( "<dev string:x190>" + cratetype );
        return;
    }
    
    crate.owner = owner;
    crate.team = team;
    crate.objweapon = leveldata.objweapon;
    crate.cratetype = cratetype;
    crate.navobstacle = undefined;
    crate.headiconid = undefined;
    crate.minimapid = undefined;
    crate.dangerzoneid = undefined;
    crate.navobstacleid = undefined;
    crate.destination = destination;
    crate.markerposition = markerposition;
    crate.headiconactive = 0;
    crate.minimapiconactive = 0;
    crate.hasnophysics = istrue( hasnophysics );
    crate.physicsactivated = 0;
    crate.isdestroyed = 0;
    crate.data = data;
    crate.airdropidentifier = data.airdropidentifier;
    crate.usetimeoverride = data.usetimeoverride;
    crate.skipminimapicon = skipminimapicon;
    crate.inwater = 0;
    crate.isdropcrate = leveldata.isdropcrate;
    crate.players = [];
    crate.streakinfo = streakinfo;
    crate.bundle = streakinfo.bundle;
    crate.var_35efbbc9c198b2f3 = istrue( var_35efbbc9c198b2f3 );
    crate.var_552ae1e7524db825 = istrue( leveldata.var_552ae1e7524db825 );
    crate.var_f6d516ce0060e74c = leveldata.var_f6d516ce0060e74c;
    crate.headicon = leveldata.headicon;
    crate.minimapicon = leveldata.minimapicon;
    crate.capturestring = leveldata.capturestring;
    crate.rerollstring = leveldata.rerollstring;
    crate.supportsreroll = crate.bundle.var_fa534b5f381ca151 ?? leveldata.supportsreroll;
    crate.isteamonlycrate = leveldata.isteamonlycrate;
    crate.exclusiveuse = leveldata.exclusiveuse;
    crate.friendlyuseonly = leveldata.friendlyuseonly;
    crate.var_58f58ae1d854e3e4 = leveldata.var_58f58ae1d854e3e4;
    
    if ( level.disallowheadiconid )
    {
        crate.disallowheadiconid = level.disallowheadiconid;
        crate.skipminimapicon = level.disallowheadiconid;
    }
    
    crate.basemodel = leveldata.basemodel;
    
    if ( !leveldata.var_bd47ae8cbb082196 )
    {
        if ( isdefined( data ) && isdefined( data.var_9400fe1a9c9b659d ) )
        {
            crate.basemodel = data.var_9400fe1a9c9b659d;
        }
    }
    
    crate setmodel( crate.basemodel );
    crate setnodeploy( 1 );
    crate setcandamage( 0 );
    crate makeunusable();
    
    if ( utility::issharedfuncdefined( #"airdrop", #"attachxrays" ) )
    {
        crate = [[ utility::getsharedfunc( #"airdrop", #"attachxrays" ) ]]( crate );
    }
    
    if ( crate.team != "neutral" )
    {
        crate enableplayermarks( #"killstreak" );
        
        if ( level.teambased && crate.team != "contested" )
        {
            crate filteroutplayermarks( crate.team );
        }
        else
        {
            crate filteroutplayermarks( crate.owner );
        }
    }
    
    killcament = undefined;
    
    if ( !crate.hasnophysics )
    {
        if ( !isbrgamemode() && level.killcam )
        {
            killcament = spawn( "script_model", position + ( 50, 50, 225 ) );
            killcament linkto( crate );
        }
    }
    
    if ( isdefined( crate.owner ) )
    {
        crate.owner.isffprotectedaction = 1;
    }
    
    crate.killcament = killcament;
    
    if ( isdefined( crate.killcament ) )
    {
        crate.killcament.linked = 1;
    }
    
    crate.unresolved_collision_notify_min = 1;
    var_1fdcec774597ba61 = crate createmountmantlemodel( data.crateclip ?? leveldata.mountmantlemodel );
    
    if ( !var_1fdcec774597ba61 )
    {
        crate.unresolved_collision_func = &crateunresolvedcollisioncallback;
    }
    
    crate addtolists();
    
    if ( level.script != "mp_bm_tut" )
    {
        crate thread watchcratedestroyearly();
    }
    
    if ( !crate.var_35efbbc9c198b2f3 )
    {
        assert( !level callback::exists( #"combat_cleanup", &function_54bc1d815c83f117, crate ) );
        level callback::add( #"combat_cleanup", &function_54bc1d815c83f117, crate );
    }
    
    if ( crate.hasnophysics )
    {
        crate activatecratefirsttime();
    }
    else if ( var_e9a9d186782e327b )
    {
        crate cratephysicson();
    }
    
    if ( isdefined( leveldata.var_a077b56baf606492 ) )
    {
        crate thread [[ leveldata.var_a077b56baf606492 ]]( streakinfo );
    }
    
    if ( !isdefined( level.var_80c6e313f9c36e80 ) )
    {
        level.var_80c6e313f9c36e80 = [];
    }
    
    level.var_80c6e313f9c36e80[ level.var_80c6e313f9c36e80.size ] = crate;
    crate.streakref = "airdrop_crate";
    function_834dc48056bc6679( crate );
    function_93131a7c7bf0090e( crate, [ "destination":destination, "position":position, "func":"createCrate" ] );
    return crate;
}

// Namespace airdrop
// Params 0
// Checksum 0x1fe0ea86, Offset: 0x2732
// Size: 0xb
function activatecratefirsttime()
{
    activatecrate( 1 );
}

// Namespace airdrop
// Params 1
// Checksum 0xa8989c2, Offset: 0x2745
// Size: 0x134
function activatecrate( isfirstactivation )
{
    self notify( #"hash_ad6e7f03ccc6749b" );
    self.isfirstactivation = undefined;
    
    if ( self.destroyonactivate )
    {
        thread destroycrate();
        return;
    }
    
    _createnavobstacle();
    self notify( #"crate_dropped" );
    
    if ( self.waitforobjectiveactivate && isfirstactivation )
    {
        self waittill( #"objective_activate" );
    }
    
    if ( isfirstactivation && !self.skipminimapicon )
    {
        createminimapicon();
    }
    
    _createheadicon();
    makecrateusable();
    callback::callback( #"airdrop_crate_activated", { #isfirstactivation:isfirstactivation } );
    leveldata = getleveldata( self.cratetype );
    
    if ( isdefined( leveldata.activatecallback ) )
    {
        self thread [[ leveldata.activatecallback ]]( isfirstactivation );
    }
    
    do_roulette = getdvarint( @"scr_airdrop_roulette", self.bundle.airdrop_roulette ?? 0 );
    
    /#
        setdvarifuninitialized( @"scr_airdrop_roulette", do_roulette );
    #/
    
    if ( do_roulette )
    {
        thread airdrop_roulette();
    }
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0xe684af09, Offset: 0x2881
// Size: 0x1b7
function private airdrop_roulette()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    foreach ( tier in self.bundle.var_e613415f5d6d43ba ?? [] )
    {
        count = 0;
        reward_previous = undefined;
        delay = tier.tier_delay ?? 0.25;
        limit = tier.tier_limit ?? 10;
        rewards = tier.tier_rewards ?? [];
        
        while ( count < limit )
        {
            wait delay;
            
            while ( self.curprogress > 0 )
            {
                waitframe();
            }
            
            reward_ref = function_d3baa6b67f536b46( rewards, reward_previous );
            reward_bundle = killstreak::function_85b2d8e857ab4898( reward_ref );
            reward_previous = reward_ref;
            self.data.streakname = reward_ref;
            
            if ( isdefined( reward_bundle.name ) )
            {
                overridecapturestring( reward_bundle.name );
            }
            
            if ( isdefined( reward_bundle.icon ) )
            {
                overrideminimapicon( reward_bundle.icon );
                overrideheadicon( reward_bundle.icon );
            }
            
            count += 1;
        }
    }
}

// Namespace airdrop
// Params 2
// Checksum 0xc15da82b, Offset: 0x2a40
// Size: 0x5e
function function_d3baa6b67f536b46( rewards, previous )
{
    reward = undefined;
    assert( rewards.size > 1, "<dev string:x1b0>" );
    
    while ( !isdefined( reward ) || reward == previous )
    {
        reward = utility::array_random( rewards ).reward_ref;
        waitframe();
    }
    
    return reward;
}

// Namespace airdrop
// Params 1
// Checksum 0x4548f7f2, Offset: 0x2aa7
// Size: 0x61
function deactivatecrate( ispermanent )
{
    if ( ispermanent )
    {
        destroyminimapicon();
    }
    
    _destroyheadicon();
    makecrateunusable();
    leveldata = getleveldata( self.cratetype );
    
    if ( isdefined( leveldata.deactivatecallback ) )
    {
        self thread [[ leveldata.deactivatecallback ]]( ispermanent );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x2b022fd2, Offset: 0x2b10
// Size: 0x356
function capturecrate( player )
{
    self endon( #"death" );
    leveldata = getleveldata( self.cratetype );
    var_b2ab1d2050cbf49e = isdefined( self.owner );
    bundle = self.streakinfo.bundle ?? level.streakglobals.streakbundles[ "airdrop" ];
    deleteimmediately = istrue( bundle.var_9f13e9febe5c5526 );
    self.var_7b7833e7ae988b16 = 1;
    
    if ( var_b2ab1d2050cbf49e && self.owner.isffprotectedaction )
    {
        self.owner.isffprotectedaction = 0;
    }
    
    if ( !self.boobytrapped )
    {
        if ( leveldata.var_8d45872a539aa837 )
        {
            params = { #player:player, #instance:self };
            player callback::callback( #"hash_51a6b1f1e6e29d3c", params );
        }
        
        if ( isdefined( leveldata.capturecallback ) )
        {
            self thread [[ leveldata.capturecallback ]]( player );
        }
        
        player thread utility::callsharedfunc( #"player", #"doScoreEvent", #"care_package_capture", undefined, undefined, undefined, undefined, undefined, undefined, undefined, self.streakinfo );
    }
    
    if ( !self.boobytrapped && player.var_44d0b4d50106847e )
    {
        boobytrapfunc = level.sharedfuncs[ #"perk" ][ #"boobytrapcrate" ];
        
        if ( isdefined( boobytrapfunc ) )
        {
            self thread [[ boobytrapfunc ]]( player );
        }
        
        self.boobytrapped = 1;
        player challenges::function_8e891c96efe9f293( "airdrop_escort" );
        return;
    }
    
    if ( self.boobytrapped )
    {
        detonatefunc = level.sharedfuncs[ #"perk" ][ #"hash_3b864e571f199211" ] ?? level.sharedfuncs[ #"blackhat" ][ #"hash_3b864e571f199211" ];
        
        if ( detonatefunc )
        {
            explosion_bundle = level.streakglobals.streakbundles[ "airdrop_explosion" ];
            
            if ( explosion_bundle.var_31bfffbff5c08ae1 )
            {
                self.streakinfo = killstreak_utility::createstreakinfo( "airdrop_explosion", self.owner );
            }
            
            self thread [[ detonatefunc ]]();
        }
        
        if ( deleteimmediately )
        {
            utility::waittill_notify_or_timeout( "carepackage_detonated", self.var_88529b256d95a199 ?? 2.5 );
            thread deletecrateimmediate();
        }
        else
        {
            thread deletecrate( self.var_88529b256d95a199 ?? 2.5 );
        }
        
        return;
    }
    
    if ( leveldata.destroyoncapture )
    {
        if ( deleteimmediately )
        {
            thread deletecrateimmediate();
            return;
        }
        
        if ( leveldata.var_22cefb9f8c5c26d2 )
        {
            destroyminimapicon();
            function_1787568701349ce2();
            _destroyheadicon();
        }
        
        deletiondelay = 0;
        
        if ( isdefined( leveldata.capturevisualscallback ) )
        {
            self thread [[ leveldata.capturevisualscallback ]]( self );
            deletiondelay = leveldata.capturevisualsdeletiondelay;
        }
        
        wait deletiondelay;
        thread deletecrate();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xeada73c3, Offset: 0x2e6e
// Size: 0x264
function destroycrate( immediate )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( !isdefined( immediate ) )
    {
        if ( isdefined( self.scenenode ) )
        {
            if ( isdefined( self.animdroptime ) )
            {
                if ( gettime() >= self.animdroptime )
                {
                    self.destroyonactivate = 1;
                    return;
                }
                else
                {
                    immediate = 1;
                }
            }
        }
        else if ( self.physicsactivated )
        {
            if ( !self.physicssettled )
            {
                self.destroyonactivate = 1;
                return;
            }
        }
    }
    
    if ( self.numuses > 0 && isplayer( self.owner ) )
    {
        if ( ( isdefined( self.streakinfo ) && isdefined( self.streakinfo.airdroptype ) ) & self.streakinfo.airdroptype == "loadout_drop" )
        {
            self.owner challenges::function_a0936b0e5b4550f3( "super_loadout_drop", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.numuses );
        }
    }
    
    self.destroyonactivate = undefined;
    self.players = [];
    leveldata = getleveldata( self.cratetype );
    
    if ( isdefined( self.owner ) && self.owner.isffprotectedaction )
    {
        self.owner.isffprotectedaction = 0;
    }
    
    if ( isdefined( leveldata.destroycallback ) )
    {
        self thread [[ leveldata.destroycallback ]]( immediate );
    }
    
    function_9cdf32dcb730c2();
    self notsolid();
    
    if ( !immediate )
    {
        deletiondelay = undefined;
        
        if ( !self.physicsactivated || !self.physicssettled )
        {
            if ( isdefined( leveldata.destroyvisualscallback ) )
            {
                self thread [[ leveldata.destroyvisualscallback ]]( self );
                deletiondelay = leveldata.destroyvisualsdeletiondelay;
            }
        }
        else if ( isdefined( leveldata.capturevisualscallback ) )
        {
            self thread [[ leveldata.capturevisualscallback ]]( self );
            deletiondelay = leveldata.capturevisualsdeletiondelay;
        }
        
        wait deletiondelay;
        
        if ( !isdefined( self ) || self.isdestroyed )
        {
            return;
        }
        
        thread deletecrate();
        return;
    }
    
    thread deletecrateimmediate();
}

// Namespace airdrop
// Params 1
// Checksum 0x1f7fa815, Offset: 0x30da
// Size: 0x25a
function deletecrate( delay )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    self notify( #"death" );
    self endon( #"death" );
    self.isdestroyed = 1;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"hash_59b4e0bb0811b551" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]();
    }
    
    function_ee6542baef351b7f();
    
    if ( self.var_3a9cbf7a21dc0849 )
    {
        self.var_3a9cbf7a21dc0849 delete();
    }
    
    if ( !self.var_35efbbc9c198b2f3 )
    {
        assert( level callback::exists( #"combat_cleanup", &function_54bc1d815c83f117, self ) );
        level callback::remove( #"combat_cleanup", &function_54bc1d815c83f117, self );
    }
    
    if ( isdefined( self.scenenode ) )
    {
        if ( isdefined( self.scenenode.crates ) )
        {
            self.scenenode.crates[ self getentitynumber() ] = undefined;
        }
        
        if ( isdefined( self.scenenode.crate ) )
        {
            self.scenenode.crate = undefined;
        }
        
        self.scenenode = undefined;
    }
    
    removefromlists( self getentitynumber() );
    utility::callsharedfunc( #"airdrop", #"unregistercrateforcleanup", self );
    self disableplayermarks( #"killstreak" );
    
    if ( self.var_88accb953478a622 )
    {
        self.var_88accb953478a622 disableplayermarks( #"killstreak" );
    }
    
    self setcandamage( 0 );
    self setnonstick( 1 );
    makecrateunusable();
    destroydangerzone();
    _destroynavobstacle();
    destroymountmantlemodel();
    cratephysicsoff();
    destroyminimapicon();
    function_1787568701349ce2();
    _destroyheadicon();
    self notsolid();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    wait delay;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.useteammodels )
    {
        self.var_b410f5d243619d25 delete();
        self.var_88accb953478a622 delete();
        self.var_36e300d147bf6f25 delete();
    }
    
    self delete();
}

// Namespace airdrop
// Params 0
// Checksum 0x22dbe9f3, Offset: 0x333c
// Size: 0x3b
function deletecrateimmediate()
{
    deletiondelay = level.framedurationseconds;
    function_1e43ba09f65e2eb6( #"visibility", #"hide", 1 );
    deletecrate( deletiondelay );
}

// Namespace airdrop
// Params 0
// Checksum 0xe87191cd, Offset: 0x337f
// Size: 0x5d
function function_262024e71bd1dfd0()
{
    self notify( #"hash_156fa21df0981461" );
    self endon( #"hash_156fa21df0981461" );
    self endon( #"death" );
    self endon( #"collision" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner waittill( #"disconnect" );
        thread destroycrate( 1 );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x11d4a61, Offset: 0x33e4
// Size: 0xe9
function watchcratedestroyearly()
{
    self notify( #"hash_3a6e8b5f33e3a156" );
    self endon( #"hash_3a6e8b5f33e3a156" );
    self endon( #"death" );
    leveldata = getleveldata( self.cratetype );
    
    /#
        nolifetime = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( nolifetime )
        {
            leveldata.timeout = undefined;
        }
    #/
    
    if ( isdefined( leveldata.timeout ) )
    {
        assert( leveldata.timeout > 0, "<dev string:x1ea>" );
    }
    
    if ( self.owner )
    {
        thread function_262024e71bd1dfd0();
    }
    
    watchcratedestroyearlyinternal( leveldata.timeout );
    
    if ( self.nevertimeout )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.cratedata.crateDestroyThrottle, self );
    thread destroycrate();
}

// Namespace airdrop
// Params 2
// Checksum 0xc12d3a73, Offset: 0x34d5
// Size: 0x26
function function_54bc1d815c83f117( params, crate )
{
    if ( isdefined( crate ) )
    {
        crate thread destroycrate( 1 );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x9f04a9a, Offset: 0x3503
// Size: 0x12a
function watchcratedestroyearlyinternal( timeout )
{
    self endon( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( #"joined_team" );
        self.owner endon( #"joined_spectators" );
    }
    
    level endon( #"game_ended" );
    
    if ( isdefined( timeout ) )
    {
        hostmigration::waitlongdurationwithpause( timeout );
        
        while ( isdefined( self.playersusing ) && self.playersusing.size > 0 )
        {
            validuser = 0;
            
            foreach ( player in self.playersusing )
            {
                if ( isdefined( player ) )
                {
                    validuser = 1;
                    break;
                }
            }
            
            if ( !validuser )
            {
                break;
            }
            
            waitframe();
        }
        
        return;
    }
    
    level waittill( #"forever" );
}

// Namespace airdrop
// Params 0
// Checksum 0xbbf897b3, Offset: 0x3635
// Size: 0x15d
function destroycrateinbadtrigger()
{
    if ( utility::issharedfuncdefined( #"entity", #"touchingbadtrigger" ) )
    {
        if ( self [[ utility::getsharedfunc( #"entity", #"touchingbadtrigger" ) ]]() )
        {
            thread destroycrate();
        }
    }
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = self [[ level.var_59abd25eeb5b2fed ]]( self.origin );
        
        if ( !canplant )
        {
            owneralive = player::isreallyalive( self.owner );
            
            if ( !owneralive )
            {
                thread destroycrate();
                return;
            }
            
            self.owner utility::callsharedfunc( #"hud", #"showerrormessage", %"equipment/plant_failed" );
            
            if ( self.cratetype == "loadout_drop" )
            {
                self.owner utility::callsharedfunc( #"supers", #"refundsuper" );
                return;
            }
            
            if ( isdefined( self.streakinfo ) && isdefined( self.streakinfo.mpstreaksysteminfo ) )
            {
                self.owner utility::callsharedfunc( #"killstreak", #"awardkillstreakfromstruct", self.streakinfo.mpstreaksysteminfo, "other" );
            }
        }
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x51a66e8a, Offset: 0x379a
// Size: 0x73
function initcratedropdata()
{
    leveldata = spawnstruct();
    leveldata.helis = [];
    var_34f9b311d535222 = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( var_34f9b311d535222 ) )
    {
        leveldata.heliheight = var_34f9b311d535222.origin[ 2 ] - 750;
    }
    
    leveldata.heliheightoffset = 128;
    level.cratedropdata = leveldata;
    initscriptedhelidropdata();
}

// Namespace airdrop
// Params 0
// Checksum 0x62e02af4, Offset: 0x3815
// Size: 0x9
function initscriptedhelidropdata()
{
    initscriptedhelidropanims();
}

// Namespace airdrop
// Params 0
// Checksum 0x82adaec6, Offset: 0x3826
// Size: 0x386
function initscriptedhelidropanims()
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    
    if ( isdefined( bundle.var_b5851abf9b39129d.animtree.id ) && isdefined( bundle.var_b5851abf9b39129d.animname.id ) )
    {
        level.scr_animtree[ "care_package" ] = bundle.var_b5851abf9b39129d.animtree.id;
        level.scr_anim[ "care_package" ][ "care_package_drop" ] = bundle.var_b5851abf9b39129d.animname.id;
        
        if ( !bundle.var_9fec9dc3a6901e62 )
        {
            if ( isdefined( bundle.var_c42a4ad215d8f1b5.animname.id ) )
            {
                level.scr_anim[ "care_package" ][ "care_package_capture" ] = bundle.var_c42a4ad215d8f1b5.animname.id;
            }
            else
            {
                function_64a403955b8c369a();
            }
        }
    }
    else
    {
        function_287145c350d97ac9();
    }
    
    if ( bundle.var_cc91890139224ab3 == "ROPE" )
    {
        if ( isdefined( bundle.var_a05a1b30a046c34e.animtree.id ) && isdefined( bundle.var_a05a1b30a046c34e.animname.id ) )
        {
            level.scr_animtree[ "care_package_rope" ] = bundle.var_a05a1b30a046c34e.animtree.id;
            level.scr_anim[ "care_package_rope" ][ "care_package_drop" ] = bundle.var_a05a1b30a046c34e.animname.id;
        }
        else
        {
            function_3da97f2a0a19d720();
        }
    }
    else if ( isdefined( bundle.var_d87c2080b867d837.animtree.id ) && isdefined( bundle.var_d87c2080b867d837.animname.id ) )
    {
        level.scr_animtree[ "care_package_chute" ] = bundle.var_d87c2080b867d837.animtree.id;
        level.scr_anim[ "care_package_chute" ][ "care_package_drop" ] = bundle.var_d87c2080b867d837.animname.id;
    }
    else
    {
        function_5e7da07da8622f7f();
    }
    
    if ( isdefined( bundle.var_f7555cd09510f33d.animtree.id ) && isdefined( bundle.var_f7555cd09510f33d.animname.id ) )
    {
        level.scr_animtree[ "care_package_veh" ] = bundle.var_f7555cd09510f33d.animtree.id;
        level.scr_anim[ "care_package_veh" ][ "care_package_drop" ] = bundle.var_f7555cd09510f33d.animname.id;
    }
    else
    {
        function_c31c67b148cd4c4a();
    }
    
    initbrc130airdropdropanims();
}

#using_animtree( "script_model" );

// Namespace airdrop
// Params 0
// Checksum 0x522470d3, Offset: 0x3bb4
// Size: 0x3a
function function_287145c350d97ac9()
{
    level.scr_animtree[ "care_package" ] = #animtree;
    level.scr_anim[ "care_package" ][ "care_package_drop" ] = %mp_carepackage_ckpg_flyin;
    function_64a403955b8c369a();
}

// Namespace airdrop
// Params 0
// Checksum 0xcb9d9b6b, Offset: 0x3bf6
// Size: 0x21
function function_64a403955b8c369a()
{
    level.scr_anim[ "care_package" ][ "care_package_capture" ] = %mp_military_carepackage_straps_falling;
}

// Namespace airdrop
// Params 0
// Checksum 0xaa148220, Offset: 0x3c1f
// Size: 0x33
function function_5e7da07da8622f7f()
{
    level.scr_animtree[ "care_package_chute" ] = #animtree;
    level.scr_anim[ "care_package_chute" ][ "care_package_drop" ] = %mp_carepackage_parachute_flyin;
}

// Namespace airdrop
// Params 0
// Checksum 0x5def3c8f, Offset: 0x3c5a
// Size: 0x33
function function_3da97f2a0a19d720()
{
    level.scr_animtree[ "care_package_rope" ] = #animtree;
    level.scr_anim[ "care_package_rope" ][ "care_package_drop" ] = %iw9_air_heli_rope_dropoff_1;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace airdrop
// Params 0
// Checksum 0x3efddede, Offset: 0x3c95
// Size: 0x33
function function_c31c67b148cd4c4a()
{
    level.scr_animtree[ "care_package_veh" ] = #animtree;
    level.scr_anim[ "care_package_veh" ][ "care_package_drop" ] = %mp_carepackage_lbravo_flyin;
}

#using_animtree( "script_model" );

// Namespace airdrop
// Params 0
// Checksum 0x2d40426, Offset: 0x3cd0
// Size: 0xbc
function initbrc130airdropdropanims()
{
    level.scr_anim[ "care_package" ][ "brc130_drop_high" ] = %mp_carepackage_ckpg_flyin_10500;
    level.scr_anim[ "care_package" ][ "brc130_drop_med" ] = %mp_carepackage_ckpg_flyin_7500;
    level.scr_anim[ "care_package" ][ "brc130_drop_low" ] = %mp_carepackage_ckpg_flyin_3000;
    level.scr_anim[ "care_package_chute" ][ "brc130_drop_high" ] = %mp_carepackage_parachute_flyin_10500;
    level.scr_anim[ "care_package_chute" ][ "brc130_drop_med" ] = %mp_carepackage_parachute_flyin_7500;
    level.scr_anim[ "care_package_chute" ][ "brc130_drop_low" ] = %mp_carepackage_parachute_flyin_3000;
}

// Namespace airdrop
// Params 7
// Checksum 0xfc02959, Offset: 0x3d94
// Size: 0x57
function placecrate( owner, team, cratetype, position, angles, data, skipminimapicon )
{
    return createcrate( owner, team, cratetype, position, angles, undefined, 0, 1, data, skipminimapicon, position );
}

// Namespace airdrop
// Params 10
// Checksum 0x5e8c3ae8, Offset: 0x3df4
// Size: 0xa4
function dropcrate( owner, team, cratetype, position, angles, destination, data, skipminimapicon, var_35efbbc9c198b2f3, streakinfo )
{
    if ( !isdefined( destination ) )
    {
        caststart = getcratedropcaststart( position, 0 );
        destination = getcratedropdestination( caststart, getcratedropcastend( caststart, 0 ) );
    }
    
    return createcrate( owner, team, cratetype, position, angles, destination, undefined, 1, data, skipminimapicon, position, streakinfo, var_35efbbc9c198b2f3 );
}

// Namespace airdrop
// Params 9
// Checksum 0xa90463d2, Offset: 0x3ea1
// Size: 0x21e
function dropcratefrommanualheli( owner, team, cratetype, position, angles, enteroffset, exitoffset, destination, data )
{
    position = getcratedropcaststart( position, 1 );
    
    if ( !isdefined( destination ) )
    {
        destination = getcratedropdestination( position, getcratedropcastend( position, 1 ) );
        
        if ( !isdefined( destination ) )
        {
            return;
        }
    }
    
    dropstruct = spawnstruct();
    dropstruct.owner = owner;
    dropstruct.team = team;
    dropstruct.hasowner = isdefined( owner );
    angles *= ( 0, 1, 0 );
    enterposition = position + -1 * anglestoforward( angles ) * enteroffset;
    dropstruct.dropposition = position;
    dropstruct.exitposition = position + anglestoforward( angles ) * exitoffset;
    vehicleisreserved = undefined;
    
    if ( isdefined( data ) )
    {
        vehicleisreserved = data.vehicleisreserved;
    }
    
    heli = createheli( owner, team, enterposition, angles, vehicleisreserved );
    heli.dropstruct = dropstruct;
    
    if ( isbrgamemode() )
    {
        heli vehicle_setspeed( 100, 60 );
    }
    else
    {
        heli vehicle_setspeed( 200, 100 );
    }
    
    heli setmaxpitchroll( 15, 15 );
    heli setscriptablepartstate( #"lights", #"active", 1 );
    dropstruct.heli = heli;
    crate = createcrate( owner, team, cratetype, enterposition, heli.angles, destination, undefined, 0, data, undefined, position );
    crate.dropstruct = dropstruct;
    crate linkto( heli, "tag_origin", ( 16, 0, -156 ), ( 0, 0, 0 ) );
    dropstruct.crate = crate;
    dropstruct thread watchdropcratefrommanualheli();
    return dropstruct;
}

// Namespace airdrop
// Params 0
// Checksum 0x56e93bb7, Offset: 0x40c8
// Size: 0x4f
function watchdropcratefrommanualheli()
{
    self endon( #"death" );
    watchdropcratefrommanualheliinternal();
    
    if ( isdefined( self.crate ) )
    {
        self.crate thread destroycrate();
    }
    
    if ( isdefined( self.heli ) )
    {
        self.heli thread destroyheli();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xaee820e1, Offset: 0x411f
// Size: 0x282
function watchdropcratefrommanualheliinternal()
{
    if ( self.hasowner )
    {
        self.owner endon( #"disconnect" );
        self.owner endon( #"joined_team" );
        self.owner endon( #"joined_spectators" );
        self.owner endon( #"killstreak_cancel" );
    }
    
    level endon( #"game_ended" );
    self.heli setvehgoalpos( self.dropposition, 1 );
    self.heli utility::waittill_notify_or_timeout( "death", 2 );
    
    if ( !isdefined( self.heli ) || self.heli.isdestroyed )
    {
        thread docratedropfrommanualheli();
        return;
    }
    
    self.heli setyawspeed( 40, 20, 20, 0.3 );
    
    if ( distancesquared( self.heli.origin, self.dropposition ) > 5184 )
    {
        self.heli utility::waittill_any( "death", "goal" );
        
        if ( !isdefined( self.heli ) || self.heli.isdestroyed )
        {
            thread docratedropfrommanualheli();
            return;
        }
        
        self.heli utility::waittill_notify_or_timeout( "death", 0.25 );
        
        if ( isdefined( self.crate ) && !self.crate.isdestroyed )
        {
            thread docratedropfrommanualheli();
        }
        
        if ( !isdefined( self.heli ) || self.heli.isdestroyed )
        {
            return;
        }
        
        self.heli utility::waittill_notify_or_timeout( "death", 0.5 );
        
        if ( !isdefined( self.heli ) || self.heli.isdestroyed )
        {
            return;
        }
        
        if ( distancesquared( self.heli.origin, self.exitposition ) > 5184 )
        {
            if ( isbrgamemode() )
            {
                self.heli vehicle_setspeed( 100, 60 );
            }
            else
            {
                self.heli vehicle_setspeed( 150, 50 );
            }
            
            self.heli setvehgoalpos( self.exitposition, 1 );
            self.heli utility::waittill_any( "death", "goal" );
        }
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x3c9102b7, Offset: 0x43a9
// Size: 0x3d
function docratedropfrommanualheli()
{
    crate = self.crate;
    self.crate.dropstruct = undefined;
    self.crate = undefined;
    crate cratephysicson();
}

// Namespace airdrop
// Params 14
// Checksum 0x394fb825, Offset: 0x43ee
// Size: 0x363
function createcrateforscripteddrop( owner, team, cratetype, destination, hasnophysics, var_e9a9d186782e327b, data, streakinfo, scenenode, animname, _anim, clearanimdroptime, markerposition, var_35efbbc9c198b2f3 )
{
    if ( isdefined( streakinfo ) && isdefined( streakinfo.streakname ) && isstruct( data ) )
    {
        streakbundle = undefined;
        
        if ( isdefined( level.streakglobals ) )
        {
            streakbundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
        }
        
        if ( isdefined( streakbundle ) )
        {
            basemodel = streakbundle.var_520def0bab23e6bc;
            cliptargetname = streakbundle.var_80733e7476cf449e;
            
            if ( isdefined( basemodel ) || isdefined( cliptargetname ) )
            {
                assert( isdefined( basemodel ) && isdefined( cliptargetname ), "<dev string:x223>" + ( basemodel ?? "<dev string:x28c>" ) + "<dev string:x296>" + ( cliptargetname ?? "<dev string:x28c>" ) );
                data.var_9400fe1a9c9b659d = basemodel;
                data.crateclip = getent( cliptargetname, #targetname );
                assert( isdefined( data.crateclip ), "<dev string:x2b6>" + cliptargetname );
            }
            
            var_da903b1e8121ea2 = streakbundle.var_bbfff1671c79a1e;
        }
    }
    
    crate = createcrate( owner, team, cratetype, scenenode.origin, scenenode.angles, destination, hasnophysics, var_e9a9d186782e327b, data, undefined, markerposition, streakinfo, var_35efbbc9c198b2f3 );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    crate.scenenode = scenenode;
    crate.streakinfo = streakinfo;
    crate.var_da903b1e8121ea2 = var_da903b1e8121ea2;
    crate.var_39123595a72543ea = streakbundle.var_aff097f95f7da3f7;
    
    if ( !isdefined( scenenode.crates ) )
    {
        scenenode.crates = [];
    }
    
    scenenode.crates[ crate getentitynumber() ] = crate;
    crate function_1e43ba09f65e2eb6( #"visibility", #"hide", 0 );
    crate.animname = animname;
    crate animation::setanimtree();
    crateanim = level.scr_anim[ animname ][ _anim ];
    crateanimtime = getanimlength( crateanim ) * 1000;
    crate.animdroptime = undefined;
    crate.animstoptrailtime = undefined;
    crate.animendtime = gettime() + crateanimtime;
    
    if ( !clearanimdroptime )
    {
        crate.animdroptime = gettime() + getnotetracktimes( crateanim, "carepackage_drop" )[ 0 ] * crateanimtime;
        crate.animstoptrailtime = gettime() + getnotetracktimes( crateanim, "carepackage_trail_end" )[ 0 ] * crateanimtime;
    }
    
    scenenode.latestanimendtime = crate.animendtime > scenenode.latestanimendtime ? crate.animendtime : scenenode.latestanimendtime;
    return crate;
}

// Namespace airdrop
// Params 4
// Checksum 0xd7cf590c, Offset: 0x475a
// Size: 0x1f7
function function_ecc053a7d7f480b2( scenenode, crate, animname, _anim )
{
    if ( !isdefined( scenenode.ropes ) )
    {
        scenenode.ropes = [];
    }
    
    rope = spawn( "script_model", scenenode.origin );
    rope.angles = scenenode.origin;
    rope.scenenode = scenenode;
    rope.crate = crate;
    rope.crateanimdroptime = crate.animdroptime;
    scenenode.ropes[ rope getentitynumber() ] = rope;
    streakbundle = level.streakglobals.streakbundles[ "airdrop" ];
    rope setmodel( streakbundle.var_ca8f51fc3f6f9fb8 ?? "veh9_mil_air_heli_airdrop_rig_mp" );
    rope setscriptablepartstate( #"visibility", #"hide", 0 );
    rope.animname = animname;
    rope animation::setanimtree();
    ropeanim = level.scr_anim[ animname ][ _anim ];
    ropeanimtime = getanimlength( ropeanim ) * 1000;
    rope.animendtime = gettime() + getanimlength( level.scr_anim[ animname ][ _anim ] ) * 1000;
    rope.animunhidetime = gettime() + getnotetracktimes( ropeanim, "rope_unhide" )[ 0 ] * ropeanimtime;
    rope.animendtime = gettime() + ropeanimtime;
    scenenode.latestanimendtime = rope.animendtime > scenenode.latestanimendtime ? rope.animendtime : scenenode.latestanimendtime;
    return rope;
}

// Namespace airdrop
// Params 0
// Checksum 0xbbe5b40e, Offset: 0x495a
// Size: 0x2e
function destroyrope()
{
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode.ropes[ self getentitynumber() ] = undefined;
    }
    
    self delete();
}

// Namespace airdrop
// Params 4
// Checksum 0x4be63045, Offset: 0x4990
// Size: 0x1f7
function createchuteforscripteddrop( scenenode, crate, animname, _anim )
{
    if ( !isdefined( scenenode.chutes ) )
    {
        scenenode.chutes = [];
    }
    
    chute = spawn( "script_model", scenenode.origin );
    chute.angles = scenenode.origin;
    chute.scenenode = scenenode;
    chute.crate = crate;
    chute.crateanimdroptime = crate.animdroptime;
    scenenode.chutes[ chute getentitynumber() ] = chute;
    streakbundle = level.streakglobals.streakbundles[ "airdrop" ];
    chute setmodel( streakbundle.var_6a771cd706a5f3a1 ?? "veh9_mil_lnd_parachute_carepackage_mp" );
    chute setscriptablepartstate( #"visibility", #"hide", 0 );
    chute.animname = animname;
    chute animation::setanimtree();
    chuteanim = level.scr_anim[ animname ][ _anim ];
    chuteanimtime = getanimlength( chuteanim ) * 1000;
    chute.animendtime = gettime() + getanimlength( level.scr_anim[ animname ][ _anim ] ) * 1000;
    chute.animunhidetime = gettime() + getnotetracktimes( chuteanim, "chute_unhide" )[ 0 ] * chuteanimtime;
    chute.animendtime = gettime() + chuteanimtime;
    scenenode.latestanimendtime = chute.animendtime > scenenode.latestanimendtime ? chute.animendtime : scenenode.latestanimendtime;
    return chute;
}

// Namespace airdrop
// Params 0
// Checksum 0xf0f2225d, Offset: 0x4b90
// Size: 0x2e
function destroychute()
{
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode.chutes[ self getentitynumber() ] = undefined;
    }
    
    self delete();
}

// Namespace airdrop
// Params 12
// Checksum 0x41b2fb27, Offset: 0x4bc6
// Size: 0x605
function dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, data, streakinfo, var_35efbbc9c198b2f3, var_a330d92f0460fb53, var_b7602a691d9e673d, var_c3c4d711e69d5ab9 )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"currentactivevehiclecount" ) && utility::issharedfuncdefined( #"killstreak", #"maxvehiclesallowed" ) )
    {
        if ( [[ utility::getsharedfunc( #"killstreak", #"currentactivevehiclecount" ) ]]() >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() )
        {
            if ( level.debugvehiclespawns )
            {
                logstring( "dropCrateFromScriptedHeli failed - currentActiveVehicleCount too high (" + [[ utility::getsharedfunc( #"killstreak", #"currentactivevehiclecount" ) ]]() + "/" + [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() + ")" );
                vehicle_tracking::function_4cfe9b5ba30f80c4();
            }
            
            return;
        }
    }
    
    if ( isdefined( level.var_e584ab91aed38e8c ) )
    {
        exfils = level.var_e584ab91aed38e8c;
        
        foreach ( exfil in exfils )
        {
            if ( exfil.b_exfil_started && distancesquared( exfil.origin, position ) < squared( 750 ) )
            {
                return;
            }
        }
    }
    
    var_eec3699c230ad7a5 = getcratedropcaststart( position, 1, undefined, owner );
    var_e64bd5306c74ab7e = angles * ( 0, 1, 0 );
    
    if ( data.var_eec3699c230ad7a5 )
    {
        var_eec3699c230ad7a5 = data.var_eec3699c230ad7a5;
    }
    
    destination = getcratedropdestination( var_eec3699c230ad7a5, getcratedropcastend( var_eec3699c230ad7a5, 1 ), destination );
    
    if ( !isdefined( destination ) )
    {
        return;
    }
    
    bundle = killstreak::function_85b2d8e857ab4898( "airdrop" );
    heliheight = bundle.var_ce0e97e9c41b8396 ?? 2000;
    var_eec3699c230ad7a5 = destination + ( 0, 0, heliheight );
    
    if ( data.var_bbb9b031a7db1020 )
    {
        var_eec3699c230ad7a5 += ( 0, 0, data.var_bbb9b031a7db1020 );
    }
    
    scenenode = spawn( "script_model", var_eec3699c230ad7a5 );
    scenenode.angles = var_e64bd5306c74ab7e;
    scenenode setmodel( "tag_origin" );
    scenenode.owner = owner;
    scenenode.team = team;
    scenenode.hasowner = isdefined( owner );
    vehicleisreserved = data.vehicleisreserved;
    var_7542529562fe8695 = data.var_a9a8df5367d9ad4b;
    var_7b7b510220360d13 = data.var_fd2ab891d645a196;
    var_25504a98837cabe0 = ( var_eec3699c230ad7a5[ 0 ], var_eec3699c230ad7a5[ 1 ], -5000 );
    heli = createheli( owner, team, var_25504a98837cabe0, var_e64bd5306c74ab7e, vehicleisreserved, streakinfo, var_a330d92f0460fb53, var_b7602a691d9e673d, var_7542529562fe8695, var_7b7b510220360d13 );
    
    if ( !isdefined( heli ) )
    {
        scenenode delete();
        return;
    }
    
    foreach ( model_override in bundle.var_b6e36b250a73be73 )
    {
        if ( getdvarint( model_override.dvarstring, 0 ) && level._effect[ model_override.var_4d6b96b09a993801 ] )
        {
            playfxontag( level._effect[ model_override.var_4d6b96b09a993801 ], heli, "tag_body_animate" );
            break;
        }
    }
    
    heli.scenenode = heli;
    heli setscriptablepartstate( #"visibility", #"hide", 0 );
    heli.animname = "care_package_veh";
    scenenode.heli = heli;
    scenenode.heliendtime = gettime() + getanimlength( level.scr_anim[ "care_package_veh" ][ "care_package_drop" ] ) * 1000;
    scenenode.latestanimendtime = scenenode.heliendtime;
    crate = data.crateoverride;
    
    if ( !isdefined( crate ) )
    {
        crate = createcrateforscripteddrop( owner, team, cratetype, destination, undefined, 0, data, streakinfo, scenenode, "care_package", "care_package_drop", undefined, position, var_35efbbc9c198b2f3 );
    }
    
    if ( !isdefined( crate ) || heli.ksempd )
    {
        return;
    }
    
    crate.var_c3c4d711e69d5ab9 = var_c3c4d711e69d5ab9;
    
    if ( bundle.var_ce0d70ea5df84ecb )
    {
        function_4acf81c10675ced9( crate, streakinfo, team );
    }
    else
    {
        function_4df55287e8514eb2( crate, streakinfo );
    }
    
    if ( bundle.var_cc91890139224ab3 == "ROPE" )
    {
        rope = function_ecc053a7d7f480b2( scenenode, crate, "care_package_rope", "care_package_drop" );
        
        if ( !isdefined( rope ) )
        {
            return;
        }
        
        rope setscriptablepartstate( #"visibility", #"hide", 0 );
    }
    else
    {
        chute = createchuteforscripteddrop( scenenode, crate, "care_package_chute", "care_package_drop" );
        
        if ( !isdefined( chute ) )
        {
            return;
        }
        
        chute setscriptablepartstate( #"visibility", #"hide", 0 );
    }
    
    scenenode thread watchdropcratefromscriptedheli();
    return scenenode;
}

// Namespace airdrop
// Params 3
// Checksum 0x9e44fff1, Offset: 0x51d4
// Size: 0x3ae
function function_4acf81c10675ced9( crate, streakinfo, team )
{
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ?? "airdrop" ];
    blueprintindex = streakinfo.mpstreaksysteminfo.blueprintindex;
    blueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    
    if ( !blueprintindex )
    {
        foreach ( model_override in bundle.var_b6e36b250a73be73 )
        {
            if ( getdvarint( model_override.dvarstring, 0 ) )
            {
                friendlymodel = model_override.var_e8daadc389c6f7cc;
                enemymodel = model_override.var_cfb1d8b7fabf235d;
                boobytrappedModel = model_override.var_d79ebca0803adc14;
                break;
            }
        }
    }
    
    if ( !isdefined( friendlymodel ) )
    {
        friendlymodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( blueprintname, #"xmodel", "friendlyModel" );
    }
    
    if ( !isdefined( enemymodel ) )
    {
        enemymodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( blueprintname, #"xmodel", "enemyModel" );
    }
    
    if ( !isdefined( boobytrappedModel ) )
    {
        boobytrappedModel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( blueprintname, #"xmodel", "boobytrappedModel" );
    }
    
    crate.useteammodels = 1;
    crate.var_b410f5d243619d25 = utility::spawn_model( friendlymodel, crate.origin, crate.angles );
    crate.var_b410f5d243619d25 linkto( crate );
    crate.var_88accb953478a622 = utility::spawn_model( enemymodel, crate.origin, crate.angles );
    crate.var_88accb953478a622 linkto( crate );
    crate.var_88accb953478a622 enableplayermarks( #"killstreak" );
    
    if ( level.teambased )
    {
        crate.var_88accb953478a622 filteroutplayermarks( crate.team );
    }
    else
    {
        crate.var_88accb953478a622 filteroutplayermarks( crate.owner );
    }
    
    crate.var_36e300d147bf6f25 = utility::spawn_model( boobytrappedModel, crate.origin, crate.angles );
    crate.var_36e300d147bf6f25 linkto( crate );
    
    foreach ( player in level.players )
    {
        if ( level.var_6c7da61a12ef9d1b || !crate.team )
        {
            crate.var_88accb953478a622 hidefromplayer( player );
        }
        else if ( player.team == team )
        {
            crate.var_88accb953478a622 hidefromplayer( player );
        }
        else
        {
            crate.var_b410f5d243619d25 hidefromplayer( player );
        }
        
        crate.var_36e300d147bf6f25 hidefromplayer( player );
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x2b1a4a0c, Offset: 0x558a
// Size: 0x116
function function_4df55287e8514eb2( crate, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ?? "airdrop" ];
    blueprintindex = streakinfo.mpstreaksysteminfo.blueprintindex;
    
    if ( !blueprintindex )
    {
        foreach ( model_override in bundle.var_b6e36b250a73be73 )
        {
            if ( getdvarint( model_override.dvarstring, 0 ) )
            {
                basemodel = model_override.var_16cb1dc6dfe676a2;
                
                if ( isdefined( basemodel ) )
                {
                    crate setmodel( basemodel );
                }
                
                break;
            }
        }
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x2dbf129f, Offset: 0x56a8
// Size: 0x396
function watchdropcratefromscriptedheli()
{
    self endon( #"death" );
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    
    if ( isdefined( self.heli ) && !self.heli vehicle::is_vehicle() )
    {
        animation::anim_first_frame_solo( self.heli, "care_package_drop" );
    }
    
    foreach ( crate in self.crates )
    {
        animation::anim_first_frame_solo( crate, "care_package_drop" );
    }
    
    if ( bundle.var_cc91890139224ab3 == "ROPE" )
    {
        foreach ( rope in self.ropes )
        {
            animation::anim_first_frame_solo( rope, "care_package_drop" );
        }
    }
    else
    {
        foreach ( chute in self.chutes )
        {
            animation::anim_first_frame_solo( chute, "care_package_drop" );
        }
    }
    
    watchdropcratefromscriptedheliinternal();
    
    if ( isdefined( self.heli ) )
    {
        self.heli thread destroyheli( 1 );
    }
    
    foreach ( crate in self.crates )
    {
        if ( isdefined( crate ) )
        {
            crate thread destroycrate();
        }
    }
    
    if ( bundle.var_cc91890139224ab3 == "ROPE" )
    {
        foreach ( rope in self.ropes )
        {
            if ( isdefined( rope ) )
            {
                rope thread destroyrope();
            }
        }
    }
    else
    {
        foreach ( chute in self.chutes )
        {
            if ( isdefined( chute ) )
            {
                chute thread destroychute();
            }
        }
    }
    
    self delete();
}

// Namespace airdrop
// Params 0
// Checksum 0x248c53ea, Offset: 0x5a46
// Size: 0x839
function watchdropcratefromscriptedheliinternal()
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    firstframe = undefined;
    
    while ( gettime() <= self.latestanimendtime )
    {
        if ( self.hasowner )
        {
            if ( !isdefined( self.ownerdisconnected ) )
            {
                if ( isdefined( self.owner ) )
                {
                    if ( !isdefined( self.ownerjoinedteam ) )
                    {
                        if ( self.team != self.owner.team )
                        {
                            self.ownerjoinedteam = 1;
                        }
                    }
                }
                else
                {
                    self.ownerdisconnected = 1;
                }
            }
        }
        
        if ( !isdefined( firstframe ) )
        {
            firstframe = 1;
        }
        else if ( firstframe )
        {
            if ( isdefined( self.heli ) )
            {
                self.heli setscriptablepartstate( #"visibility", #"show", 0 );
                
                if ( self.heli getscriptablehaspart( #"lights" ) )
                {
                    self.heli setscriptablepartstate( #"lights", #"active", 1 );
                }
                
                thread animation::anim_single_solo( self.heli, "care_package_drop" );
            }
            
            foreach ( crate in self.crates )
            {
                if ( isdefined( crate ) )
                {
                    crate function_1e43ba09f65e2eb6( #"visibility", #"show", 0 );
                    thread animation::anim_single_solo( crate, "care_package_drop" );
                }
            }
            
            if ( bundle.var_cc91890139224ab3 == "ROPE" )
            {
                foreach ( rope in self.ropes )
                {
                    if ( isdefined( rope ) )
                    {
                        thread animation::anim_single_solo( rope, "care_package_drop" );
                    }
                }
            }
            else
            {
                foreach ( chute in self.chutes )
                {
                    if ( isdefined( chute ) )
                    {
                        thread animation::anim_single_solo( chute, "care_package_drop" );
                        chute playsoundonmovingent( bundle.var_2e5b2613e4e79571 ?? "iw9_carepackage_parachute_drop" );
                    }
                }
            }
            
            firstframe = 0;
        }
        else
        {
            disowned = self.ownerdisconnected || self.ownerjoinedteam || self.heli.cratedestroyed;
            
            if ( isdefined( self.heli ) )
            {
                if ( disowned || gettime() > self.heliendtime )
                {
                    self.heli destroyheli();
                }
            }
            
            foreach ( crate in self.crates )
            {
                if ( isdefined( crate ) )
                {
                    if ( gettime() > crate.animendtime || self.heli.ksempd )
                    {
                        if ( disowned )
                        {
                            crate thread destroycrate();
                            continue;
                        }
                        
                        if ( !self.droppedcrate )
                        {
                            thread docratedropfromscripted( crate );
                            self.droppedcrate = 1;
                            
                            if ( isdefined( self.heli ) )
                            {
                                self.heli.droppedcrate = 1;
                            }
                        }
                        
                        continue;
                    }
                    
                    if ( gettime() > crate.animdroptime )
                    {
                        if ( disowned )
                        {
                            crate thread destroycrate();
                            continue;
                        }
                        
                        if ( !self.droppedcrate )
                        {
                            var_3112a568fd49b411 = crate getscriptablehaspart( #"trail" );
                            
                            if ( var_3112a568fd49b411 && gettime() > crate.animstoptrailtime )
                            {
                                crate setscriptablepartstate( #"trail", #"neutral", 1 );
                            }
                            else if ( var_3112a568fd49b411 )
                            {
                                crate setscriptablepartstate( #"trail", #"active", 1 );
                            }
                            
                            thread docratedropfromscripted( crate );
                            self.droppedcrate = 1;
                            
                            if ( isdefined( self.heli ) )
                            {
                                self.heli.droppedcrate = 1;
                            }
                        }
                        
                        continue;
                    }
                    
                    if ( disowned )
                    {
                        crate thread destroycrate();
                        continue;
                    }
                    
                    if ( ( !isdefined( self.heli ) || self.heli.isdestroyed ) && !self.droppedcrate )
                    {
                        thread docratedropfromscripted( crate );
                        self.droppedcrate = 1;
                        
                        if ( isdefined( self.heli ) )
                        {
                            self.heli.droppedcrate = 1;
                        }
                    }
                }
            }
            
            if ( bundle.var_cc91890139224ab3 == "ROPE" )
            {
                foreach ( rope in self.ropes )
                {
                    if ( isdefined( rope ) )
                    {
                        if ( gettime() > rope.animendtime || self.heli.ksempd )
                        {
                            rope thread destroyrope();
                            continue;
                        }
                        
                        if ( gettime() <= rope.crateanimdroptime && isdefined( self.crates ) && !( isdefined( rope.crate ) && isdefined( self.crates[ rope.crate getentitynumber() ] ) ) )
                        {
                            rope thread destroyrope();
                            continue;
                        }
                        
                        if ( gettime() > rope.animunhidetime )
                        {
                            rope setscriptablepartstate( #"visibility", #"show", 0 );
                        }
                    }
                }
            }
            else
            {
                foreach ( chute in self.chutes )
                {
                    if ( isdefined( chute ) )
                    {
                        if ( gettime() > chute.animendtime || self.heli.ksempd )
                        {
                            chute thread destroychute();
                            continue;
                        }
                        
                        if ( gettime() <= chute.crateanimdroptime && isdefined( self.crates ) && !( isdefined( chute.crate ) && isdefined( self.crates[ chute.crate getentitynumber() ] ) ) )
                        {
                            chute thread destroychute();
                            continue;
                        }
                        
                        if ( gettime() > chute.animunhidetime )
                        {
                            chute setscriptablepartstate( #"visibility", #"show", 0 );
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xac2ee149, Offset: 0x6287
// Size: 0xc6
function docratedropfromscripted( crate )
{
    crate.scenenode = undefined;
    self.crates[ crate getentitynumber() ] = undefined;
    crate.animname = undefined;
    crate.animendtime = undefined;
    crate.animdroptime = undefined;
    crate.animstoptrailtime = undefined;
    crate notify( #"hash_69ed097f6fe2343b" );
    crate stopanimscripted();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"hash_5a322d704b74ab61" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        crate [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( crate.var_fe2a17068a3c0fa6 )
    {
        crate [[ crate.var_fe2a17068a3c0fa6 ]]();
        return;
    }
    
    crate cratephysicson();
}

// Namespace airdrop
// Params 4
// Checksum 0x3ea800c0, Offset: 0x6355
// Size: 0x77
function getcratedropcaststart( position, fromheli, droptype, owner = undefined )
{
    caststart = undefined;
    
    if ( fromheli )
    {
        caststart = position * ( 1, 1, 1 ) + ( 0, 0, getscriptedhelidropheight( droptype, owner ) );
    }
    else
    {
        caststart = position + ( 0, 0, 25 );
    }
    
    return caststart;
}

// Namespace airdrop
// Params 2
// Checksum 0x7cd5df0f, Offset: 0x63d5
// Size: 0x2d
function getcratedropcastend( caststart, fromheli )
{
    return caststart + ( 0, 0, -1 * ( istrue( fromheli ) ? 25000 : 25000 ) );
}

// Namespace airdrop
// Params 3
// Checksum 0xb29257a3, Offset: 0x640b
// Size: 0xa7
function getcratedropdestination( caststart, castend, destination )
{
    ignorelist = getcratedropignorelist();
    contentoverride = trace::create_contents( 0, 1, 0, 1, 0, 0 );
    droptrace = trace::sphere_trace( caststart, castend, 100, ignorelist, contentoverride );
    
    if ( droptrace[ "hittype" ] != "hittype_none" && isdefined( droptrace[ "position" ] ) )
    {
        if ( isdefined( destination ) )
        {
            destination = ( destination[ 0 ], destination[ 1 ], droptrace[ "position" ][ 2 ] );
        }
        else
        {
            destination = droptrace[ "position" ];
        }
    }
    
    /#
    #/
    
    return destination;
}

// Namespace airdrop
// Params 0
// Checksum 0x244d19d0, Offset: 0x64bb
// Size: 0x9c
function getcratedropignorelist()
{
    if ( isdefined( level.cratedata.helis ) && isdefined( level.cratedata.ac130s ) )
    {
        return arraycombine( level.cratedropdata.helis, level.cratedropdata.ac130s, level.cratedata.crates );
    }
    
    return arraycombine( level.cratedropdata.helis, level.cratedata.crates );
}

// Namespace airdrop
// Params 1
// Checksum 0xceb29f64, Offset: 0x655f
// Size: 0x4b
function function_6d2c704914d1e4b5( position )
{
    movingplatformcheck = spawnstruct();
    movingplatformcheck.origin = position;
    movingplatformcheck.angles = ( 0, 0, 0 );
    return movingplatformcheck utility::function_7c45b71b8e0d3cff();
}

// Namespace airdrop
// Params 2
// Checksum 0x179a9852, Offset: 0x65b3
// Size: 0xaf
function function_340d642e069cfff3( pos, movingplatform )
{
    self endon( #"collision" );
    original_offset = rotatevector( pos - movingplatform.origin, -1 * movingplatform.angles );
    waitframe();
    
    while ( isdefined( self ) && isdefined( movingplatform ) )
    {
        current_offset = rotatevector( original_offset, movingplatform.angles );
        self.origin = ( ( movingplatform.origin + current_offset )[ 0 ], ( movingplatform.origin + current_offset )[ 1 ], self.origin[ 2 ] );
        waitframe();
    }
}

// Namespace airdrop
// Params 10
// Checksum 0x15255691, Offset: 0x666a
// Size: 0x46c
function createheli( owner, team, position, angles, vehicleisreserved, streakinfo, var_a330d92f0460fb53, var_b7602a691d9e673d, var_7542529562fe8695, var_7b7b510220360d13 )
{
    heli = undefined;
    streakbundle = streakinfo.bundle;
    streakref = streakbundle.killstreakref ?? "airdrop";
    heliname = var_7542529562fe8695 ?? streakbundle.airdropvehicle ?? var_a330d92f0460fb53;
    helimodel = var_7b7b510220360d13 ?? streakbundle.var_5c2c78d8c8afcf86 ?? var_b7602a691d9e673d;
    
    if ( vehicleisreserved )
    {
        vehicle_tracking::function_4f76f5b4541acef1();
    }
    
    if ( true )
    {
        spawndata = { #var_ebc893de25479201:1, #targetname:"airdrop", #modelname:helimodel, #vehicletype:heliname, #angles:angles, #origin:position };
        faildata = {};
        heli = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    }
    else
    {
        heli = vehicle_tracking::spawn_helicopter( undefined, position, angles, heliname, helimodel );
    }
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1, 1 );
    }
    
    if ( !isdefined( team ) )
    {
        team = "neutral";
    }
    
    if ( team != "neutral" )
    {
        heli setvehicleteam( team );
    }
    
    heli.owner = owner;
    heli.team = team;
    destroyedsplash = undefined;
    vodestroyed = undefined;
    scorepopup = undefined;
    
    if ( streakbundle.var_156a03d2f4ec6ea2 )
    {
        heli.maxhealth = streakbundle.maxhealth ?? 1;
        heli.health = streakbundle.maxhealth ?? 1;
    }
    else if ( isdefined( streakbundle.maxhealth ) )
    {
        heli.maxhealth = streakbundle.maxhealth;
        heli.health = streakbundle.maxhealth;
    }
    else if ( isdefined( level.heliconfigs[ "airdrop" ] ) )
    {
        config = level.heliconfigs[ "airdrop" ];
        heli.health = config.maxhealth;
        heli.maxhealth = config.maxhealth;
        vodestroyed = config.vodestroyed;
        scorepopup = config.scorepopup;
    }
    else
    {
        heli.maxhealth = 999999;
        heli.health = heli.maxhealth;
    }
    
    heli.streakinfo = streakinfo;
    heli.helitype = streakref;
    heli setscriptablepartstate( #"engine", #"on", 0 );
    level thread killstreak_utility::function_6348c97b79ee8a08( heli, owner, undefined, undefined, 1 );
    
    if ( isdefined( owner ) )
    {
        heli utility::callsharedfunc( #"killstreak", #"addtoactivekillstreaklist", streakref, "Killstreak_Air", owner, 0, 0 );
        
        if ( team != "neutral" )
        {
            heli sentientpoolmanager::registersentient( "Killstreak_Air", owner );
        }
    }
    
    heli airdrop_setupdamagefunctionality( streakbundle, streakref, scorepopup, vodestroyed, destroyedsplash );
    
    if ( !isdefined( streakbundle ) || !streakbundle.candamage )
    {
        heli setcandamage( 0 );
    }
    else if ( !streakbundle.var_156a03d2f4ec6ea2 )
    {
        if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
        {
            heli thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( heli.maxhealth, "hitequip", &function_7d2f0f7dd9409d6e, &_airdrop_handle_damage, 1, 1 );
        }
    }
    
    heli vehicle_occupancy::turn_engine_on();
    heli thread watchhelidestroyearly();
    
    /#
        heli thread function_f2cead86631d5741();
    #/
    
    if ( level.var_36218e71baa7e689 )
    {
        heli.var_c5ccf9dff3b5e393 = &function_c2a50796f40c0150;
    }
    
    return heli;
}

/#

    // Namespace airdrop
    // Params 0, eflags: 0x4
    // Checksum 0x760f2af4, Offset: 0x6adf
    // Size: 0x4a, Type: dev
    function private function_f2cead86631d5741()
    {
        self endon( #"death" );
        
        while ( self )
        {
            if ( getdvarint( @"hash_b4fe29a00bfde823" ) == 4 || getdvarint( @"hash_b4fe29a00bfde823" ) == 5 )
            {
                thread destroyheli();
                break;
            }
            
            waitframe();
        }
    }

#/

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0xec00f32d, Offset: 0x6b31
// Size: 0x181
function private function_c2a50796f40c0150( empstruct )
{
    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
    {
        scorepopup = ( self.scorepopup ?? "destroyed_" ) + "airdrop";
        vodestroyed = ( self.vodestroyed ?? "destroyed_" ) + "airdrop";
        destroyedsplash = ( self.destroyedsplash ?? "callout_destroyed_" ) + "airdrop";
        attacker = empstruct.attacker;
        
        if ( isplayer( attacker ) )
        {
            if ( !isdefined( self.attackerdata[ attacker.guid ] ) )
            {
                self.attackerdata[ attacker.guid ] = {};
            }
            
            self.attackerdata[ attacker.guid ].attacker = attacker;
            self.attackerdata[ attacker.guid ].damage = empstruct.damage;
        }
        
        self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( "airdrop", attacker, empstruct.objweapon, empstruct.meansofdeath, empstruct.damage, scorepopup, vodestroyed, destroyedsplash, 0 );
    }
    
    self.ksempd = 1;
    thread destroyheli();
}

// Namespace airdrop
// Params 5, eflags: 0x4
// Checksum 0xb8c1e4ef, Offset: 0x6cba
// Size: 0xd6
function private airdrop_setupdamagefunctionality( streakbundle, streakname, scorepopup, vodestroyed, destroyedsplash )
{
    killstreakvehicle = self;
    
    if ( !isdefined( scorepopup ) )
    {
        scorepopup = "destroyed_" + streakname;
    }
    
    if ( !isdefined( vodestroyed ) )
    {
        vodestroyed = "destroyed_" + streakname;
    }
    
    if ( !isdefined( destroyedsplash ) )
    {
        destroyedsplash = "callout_destroyed_" + streakname;
    }
    
    var_c96bcef6709d6df1 = undefined;
    var_d188942a41771ea1 = undefined;
    premoddamagecallback = &_airdrop_handle_damage;
    postmoddamagecallback = undefined;
    
    if ( streakbundle.var_156a03d2f4ec6ea2 )
    {
        deathcallback = &function_7d2f0f7dd9409d6e;
    }
    else
    {
        deathcallback = &destroyhelicallback;
    }
    
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0x91cc34ae, Offset: 0x6d98
// Size: 0x137
function private function_7d2f0f7dd9409d6e( data )
{
    veh = data.victim;
    
    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
    {
        self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( "airdrop", data.attacker, data.objweapon, data.meansofdeath, data.damage, "destroyed_" + "airdrop", undefined, #"perform_callout", 1, { #inflictor:data.inflictor } );
    }
    
    streakref = veh.streakinfo.streakname;
    assert( isdefined( veh.streakinfo.streakname ) );
    streakbundle = level.streakglobals.streakbundles[ streakref ];
    
    if ( !streakbundle.var_156a03d2f4ec6ea2 )
    {
        veh thread destroyheli();
    }
    
    return data.damage;
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0x11b7b003, Offset: 0x6ed8
// Size: 0x43
function private function_e7340048684ce336( veh )
{
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    veh thread destroyheli();
    level callback::callback( #"killstreak_finish_use", { #streakinfo:veh.streakinfo } );
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0xb55e979f, Offset: 0x6f23
// Size: 0x14f
function private _airdrop_handle_damage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    modifieddamage = data.damage;
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        bundle = level.streakglobals.streakbundles[ "airdrop" ];
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, 1, 1, 1 );
    }
    
    data.damage = modifieddamage;
    return data.damage;
}

// Namespace airdrop
// Params 0
// Checksum 0xdcbcb796, Offset: 0x707b
// Size: 0x59
function watchhelidestroyearly()
{
    thread function_7b154781966cca3d();
    watchhelidestroyearlyinternal();
    
    if ( self )
    {
        bundle = level.streakglobals.streakbundles[ "airdrop" ];
        
        if ( bundle.var_89cb2d9d0ca613bb )
        {
            self.cratedestroyed = 1;
        }
        
        thread destroyheli();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x1add3c50, Offset: 0x70dc
// Size: 0x85
function watchhelidestroyearlyinternal()
{
    self endon( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( #"disconnect", #"joined_team", #"joined_spectators" );
        
        if ( !level.gametypebundle.var_b6052f3a3c7d27b2 )
        {
            self.owner endon( #"killstreak_cancel" );
        }
    }
    
    level endon( #"game_ended" );
    level waittill( #"forever" );
}

// Namespace airdrop
// Params 0
// Checksum 0xa7048e2f, Offset: 0x7169
// Size: 0xce
function function_7b154781966cca3d()
{
    level endon( #"game_over" );
    self endon( #"death" );
    
    while ( true )
    {
        origin = self getorigin();
        
        if ( origin[ 0 ] < -125000 || origin[ 0 ] > 125000 || origin[ 1 ] < -125000 || origin[ 1 ] > 125000 )
        {
            println( "<dev string:x2ef>" + self.streakname + "<dev string:x302>" + origin[ 0 ] + "<dev string:x312>" + origin[ 1 ] + "<dev string:x315>" + -125000 + "<dev string:x312>" + 125000 + "<dev string:x33a>" + ( self.droppedcrate ?? 0 ) );
            thread destroyheli();
            return;
        }
        
        wait 0.1;
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x38e91c13, Offset: 0x723f
// Size: 0xa6
function destroyheli( var_fbbc049604f06150 )
{
    if ( !self.isdestroyed )
    {
        self.isdestroyed = 1;
        
        if ( !var_fbbc049604f06150 )
        {
            self setscriptablepartstate( #"destruction", #"explode", 0 );
        }
        
        self setscriptablepartstate( #"visibility", #"hide", 0 );
        bundle = level.streakglobals.streakbundles[ "airdrop" ];
        
        if ( bundle.var_156a03d2f4ec6ea2 )
        {
            thread deleteheli( 0.1 );
            return;
        }
        
        thread deleteheli( 0 );
    }
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0x970ae87c, Offset: 0x72ed
// Size: 0x59
function private deleteheli( delay )
{
    self notify( #"death" );
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode.heli = undefined;
        self.scenenode = undefined;
    }
    
    removehelidroppingcratefromlist( self getentitynumber() );
    wait delay;
    vehicle_tracking::delete_vehicle( self );
}

// Namespace airdrop
// Params 1
// Checksum 0xe3f21348, Offset: 0x734e
// Size: 0x72
function destroyhelicallback( data )
{
    bundle = level.streakglobals.streakbundles[ self.streakinfo.killstreakref ?? self.streakname ];
    
    if ( bundle.killstreaksetpremoddamagecallback )
    {
        assertmsg( "<dev string:x34d>" );
        return 0;
    }
    
    destroyheli();
}

// Namespace airdrop
// Params 2
// Checksum 0xadf8a005, Offset: 0x73c8
// Size: 0x7f
function getscriptedhelidropheightbase( droptype, owner = undefined )
{
    assert( isdefined( level.cratedropdata ), "<dev string:x386>" );
    
    if ( !isdefined( level.cratedropdata.heliheight ) && isdefined( owner ) )
    {
        return ( owner.origin[ 2 ] + 2000 );
    }
    
    return level.cratedropdata.heliheight ?? 2000;
}

// Namespace airdrop
// Params 2
// Checksum 0x6ed130b2, Offset: 0x7450
// Size: 0x4f
function getscriptedhelidropheight( droptype, owner = undefined )
{
    return getscriptedhelidropheightbase( droptype, owner ) + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

// Namespace airdrop
// Params 1
// Checksum 0xb66e543a, Offset: 0x74a8
// Size: 0x4d
function addhelidroppingcratetolist( heli )
{
    assert( isdefined( level.cratedropdata ), "<dev string:x3c9>" );
    entnum = heli getentitynumber();
    level.cratedropdata.helis[ entnum ] = heli;
}

// Namespace airdrop
// Params 1
// Checksum 0x3b1c711e, Offset: 0x74fd
// Size: 0x22
function removehelidroppingcratefromlist( entnum )
{
    level.cratedropdata.helis[ entnum ] = undefined;
}

// Namespace airdrop
// Params 0
// Checksum 0x8c83ff96, Offset: 0x7527
// Size: 0xf9
function makecrateusable()
{
    leveldata = getleveldata( self.cratetype );
    
    if ( leveldata.hasnointeraction )
    {
        return;
    }
    
    level.cratedata.usablecrates[ self getentitynumber() ] = self;
    function_5cf5f4fb8e335590( self );
    self.isusable = 1;
    assert( leveldata.supportsownercapture || leveldata.supportsothercapture, "<dev string:x408>" );
    
    if ( leveldata.supportsownercapture && leveldata.supportsothercapture )
    {
        usetype = 3;
    }
    else if ( leveldata.supportsownercapture )
    {
        usetype = 1;
    }
    else
    {
        usetype = 2;
    }
    
    if ( self.supportsreroll )
    {
        function_328efb7329a5f244();
        thread function_35f1e9acdb5f8b73();
        thread watchcrateuse( usetype, self.var_3a9cbf7a21dc0849 );
    }
    
    thread watchcrateuse( usetype );
}

// Namespace airdrop
// Params 2
// Checksum 0xf06620c3, Offset: 0x7628
// Size: 0x39f
function watchcrateuse( usetype, triggerobject )
{
    self endon( #"death" );
    self endon( #"hash_59d62d244d792cf9" );
    
    if ( isdefined( self.owner ) && ( usetype == 1 || usetype == 3 ) )
    {
        self.owner endon( #"joined_team" );
        self.owner endon( #"joined_spectators" );
        self.owner.isffprotectedaction = 1;
    }
    
    streakname = self.streakinfo.streakname ?? "airdrop";
    bundle = level.streakglobals.streakbundles[ streakname ];
    leveldata = getleveldata( self.cratetype );
    
    if ( !isdefined( triggerobject ) )
    {
        triggerobject = self;
    }
    
    triggerobject.usetype = usetype;
    triggerobject.userate = 1;
    triggerobject.curprogress = 0;
    
    if ( isdefined( triggerobject.usetimeoverride ) )
    {
        triggerobject.usetimefriendly = triggerobject.usetimeoverride;
        triggerobject.usetimeenemy = triggerobject.usetimeoverride;
    }
    else
    {
        triggerobject.usetimeowner = bundle.var_1df958c7473ce41d ?? leveldata.ownerusetime;
        triggerobject.usetimefriendly = bundle.var_3cce644139163e8 ?? leveldata.friendlyusetime;
        triggerobject.usetimeenemy = bundle.var_1bf88fd6cf63d622 ?? leveldata.enemyusetime;
    }
    
    common_item::function_85051688452b7927( triggerobject, 0 );
    triggerobject.playerusing = undefined;
    
    if ( bundle.var_61e028bbc91b5dfc && isdefined( self.team ) )
    {
        function_5929a0eafa52c5bf( self.team );
    }
    
    while ( true )
    {
        triggerobject waittill( #"trigger", player );
        
        if ( getdvarint( @"hash_618b9c003b5b3883", 0 ) == 0 )
        {
            if ( isdefined( self.disabled_use_for ) && self.disabled_use_for[ player getentitynumber() ] )
            {
                player utility::callsharedfunc( #"airdrop", #"airdrop_cannotuseloadoutcratehint" );
                continue;
            }
        }
        
        if ( player.isjuggernaut && !player juggcanusecrate( self ) )
        {
            player utility::callsharedfunc( #"hud", #"showerrormessage", player.juggcontext.var_fa60812bd871fca1 ?? %"killstreaks/jugg_cannot_be_used" );
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"airdrop", #"hash_c9560231ec2a7c59" ) )
        {
            if ( !player [[ utility::getsharedfunc( #"airdrop", #"hash_c9560231ec2a7c59" ) ]]( self ) )
            {
                continue;
            }
        }
        
        if ( player.hashostage )
        {
            player utility::callsharedfunc( #"hud", #"showerrormessage", %"MP/CANNOT_USE_GENERIC" );
            continue;
        }
        
        if ( arraycontains( self.players, player ) )
        {
            continue;
        }
        
        if ( self.exclusiveuse == 0 )
        {
            self.players[ self.players.size ] = player;
            thread usecrate( player, leveldata, triggerobject );
            continue;
        }
        
        usecrate( player, leveldata, triggerobject );
    }
}

// Namespace airdrop
// Params 3
// Checksum 0xe7395a7c, Offset: 0x79cf
// Size: 0x162
function usecrate( player, leveldata, triggerobject = self )
{
    if ( canstartusingcrate( player ) )
    {
        player.var_44d0b4d50106847e = 0;
        
        if ( isdefined( self.owner ) && isenemyteam( player.team, self.owner.team ) )
        {
            player.var_44d0b4d50106847e = isdefined( player.perks[ "specialty_carepackage_boobytrap" ] );
        }
        
        startusingcrate( player, triggerobject );
        player.isffprotectedaction = 1;
        triggerobject.playerusing = player;
        result = watchcrateuseinternal( player, triggerobject );
        
        if ( isdefined( player ) )
        {
            stopusingcrate( player, triggerobject, result );
        }
        
        triggerobject.playerusing = undefined;
        
        if ( result )
        {
            if ( isdefined( player ) )
            {
                player.isffprotectedaction = 0;
            }
            
            if ( leveldata.onecaptureperplayer )
            {
                if ( getdvarint( @"hash_618b9c003b5b3883" ) == 0 )
                {
                    if ( !isdefined( self.playerscaptured ) )
                    {
                        self.playerscaptured = [];
                    }
                    
                    self.playerscaptured[ player getentitynumber() ] = player;
                }
            }
            
            if ( self.targetname != "btm_flag_primary_inside" )
            {
                thread capturecrate( player );
            }
        }
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x59030de1, Offset: 0x7b39
// Size: 0x3a0, Type: bool
function watchcrateuseinternal( player, triggerobject = self )
{
    if ( triggerobject.usetype == 2 )
    {
        player endon( #"disconnect" );
        player endon( #"joined_team" );
        player endon( #"joined_spectators" );
    }
    
    leveldata = getleveldata( self.cratetype );
    
    if ( leveldata.objectid )
    {
        triggerobject.id = leveldata.objectid;
    }
    else
    {
        triggerobject.id = function_ecbca7dc774f0b46();
    }
    
    triggerobject.userate = player.objectivescaler ?? 1;
    
    if ( self.var_332923074ceef731 && !isdefined( triggerobject.clientprogress ) )
    {
        triggerobject.clientprogress = [];
    }
    
    if ( isdefined( triggerobject.clientprogress ) && !isdefined( triggerobject.clientprogress[ player.clientid ] ) )
    {
        triggerobject.clientprogress[ player.clientid ] = 0;
    }
    
    /#
        var_44429f7b386705a8 = getdvarint( @"scr_airdrop_ownership", 0 );
        
        if ( isdefined( triggerobject.usetimeoverride ) )
        {
            triggerobject.usetimefriendly = triggerobject.usetimeoverride;
            triggerobject.usetimeenemy = triggerobject.usetimeoverride;
        }
        else if ( game_utility::getgametype() != "<dev string:x460>" )
        {
            if ( var_44429f7b386705a8 )
            {
                triggerobject.usetimeowner = 0.5;
                triggerobject.usetimefriendly = 0.5;
                triggerobject.usetimeenemy = 3;
            }
        }
    #/
    
    playusesound( player );
    currentprogress = self.var_332923074ceef731 ? triggerobject.clientprogress[ player.clientid ] : triggerobject.curprogress;
    usetime = getusetime( player, triggerobject );
    player.usepressed = 0;
    player.toggleuse = 0;
    
    while ( isdefined( player ) && player player::isreallyalive() && cankeepusingcrate( player ) && ( player usebuttonpressed( 1 ) || player.toggleuse ) )
    {
        player playerlogic::function_3765e79e200dd60f();
        currentprogress += level.framedurationseconds * triggerobject.userate;
        
        if ( currentprogress >= usetime )
        {
            currentprogress = 0;
            function_b4f4e6a44ef460e( currentprogress, triggerobject, player );
            
            if ( isdefined( self.var_5d1048e735f64728 ) && self [[ self.var_5d1048e735f64728 ]]( player ) )
            {
                thread capturecrate( player );
            }
            else
            {
                if ( self && self.players.size > 0 )
                {
                    self.players = arrayremove( self.players, player );
                }
                
                return true;
            }
        }
        
        if ( utility::issharedfuncdefined( #"airdrop", #"updateuiprogress" ) )
        {
            function_b4f4e6a44ef460e( currentprogress, triggerobject, player );
            player [[ utility::getsharedfunc( #"airdrop", #"updateuiprogress" ) ]]( triggerobject, 1 );
        }
        
        waitframe();
    }
    
    currentprogress = 0;
    function_b4f4e6a44ef460e( currentprogress, triggerobject, player );
    
    if ( self && self.players.size > 0 )
    {
        self.players = arrayremove( self.players, player );
    }
    
    return false;
}

// Namespace airdrop
// Params 2
// Checksum 0x89198710, Offset: 0x7ee2
// Size: 0xe5
function getusetime( player, triggerobject = self )
{
    usetime = triggerobject.usetimefriendly;
    
    if ( isdefined( triggerobject.owner ) )
    {
        if ( player == triggerobject.owner )
        {
            usetime = triggerobject.usetimeowner;
        }
        else
        {
            usetime = player player_utility::isenemy( triggerobject.owner ) ? triggerobject.usetimeenemy : triggerobject.usetimefriendly;
        }
    }
    else if ( isdefined( triggerobject.team ) )
    {
        usetime = triggerobject.team != "neutral" && player player_utility::isenemy( triggerobject ) ? triggerobject.usetimeenemy : triggerobject.usetimefriendly;
    }
    
    return usetime;
}

// Namespace airdrop
// Params 3
// Checksum 0x6c5b9bbc, Offset: 0x7fd0
// Size: 0x5c
function function_b4f4e6a44ef460e( currentprogress, triggerobject, player )
{
    if ( !triggerobject )
    {
        return;
    }
    
    if ( self.var_332923074ceef731 )
    {
        triggerobject.clientprogress[ player.clientid ] = currentprogress;
        return;
    }
    
    triggerobject.curprogress = currentprogress;
}

// Namespace airdrop
// Params 0
// Checksum 0xc280485f, Offset: 0x8034
// Size: 0x16
function function_ecbca7dc774f0b46()
{
    if ( game_utility::function_245a95d184375f25() )
    {
        return "open";
    }
    
    return "care_package";
}

// Namespace airdrop
// Params 0
// Checksum 0x646569ad, Offset: 0x8053
// Size: 0x100
function makecrateunusable()
{
    self notify( #"hash_59d62d244d792cf9" );
    assert( isdefined( level.cratedata ), "<dev string:x465>" );
    level.cratedata.usablecrates[ self getentitynumber() ] = undefined;
    function_8bcdedef0fc068c3( self );
    self.isusable = 0;
    
    if ( isdefined( self.playerusing ) )
    {
        stopusingcrate( self.playerusing );
    }
    
    var_ff3221237b32fa8d = self.playersusing;
    
    foreach ( usingplayer in var_ff3221237b32fa8d )
    {
        stopusingcrate( usingplayer );
    }
    
    self.playerusing = undefined;
    self makeunusable();
}

// Namespace airdrop
// Params 2
// Checksum 0x8b15f187, Offset: 0x815b
// Size: 0x18c
function startusingcrate( player, triggerobject )
{
    if ( !isdefined( self.playersusing ) )
    {
        self.playersusing = [];
    }
    
    if ( !arraycontains( self.playersusing, player ) )
    {
        self.playersusing[ self.playersusing.size ] = player;
    }
    
    if ( !isdefined( triggerobject ) )
    {
        triggerobject = self;
    }
    
    leveldata = getleveldata( self.cratetype );
    
    if ( player.isjuggernaut )
    {
        player utility::callsharedfunc( #"airdrop", #"allowactionset", "juggCrateUse", 0 );
    }
    else
    {
        var_55b610f22013b3ac = getdvarint( @"scr_airdrop_use_weapon", 1 );
        var_fe2e02bb9639a437 = leveldata.var_fe2e02bb9639a437;
        
        if ( var_fe2e02bb9639a437 )
        {
            if ( player isgestureplaying( var_fe2e02bb9639a437 ) )
            {
                player stopgestureviewmodel( var_fe2e02bb9639a437, 0, 1 );
            }
            
            player forceplaygestureviewmodel( var_fe2e02bb9639a437 );
        }
        else if ( !leveldata.var_5090c989abb19ef4 && var_55b610f22013b3ac )
        {
            player thread airdrop_givecrateuseweapon( self );
        }
        
        player utility::callsharedfunc( #"airdrop", #"allowactionset", "crateUse", 0 );
    }
    
    player utility::callsharedfunc( #"airdrop", #"updateuiprogress", triggerobject, 0 );
    
    if ( leveldata.var_e42378c24a1e25aa )
    {
        self [[ leveldata.var_e42378c24a1e25aa ]]( player );
    }
    
    player callback::callback( #"player_used_crate" );
}

// Namespace airdrop
// Params 1
// Checksum 0x68a0faef, Offset: 0x82ef
// Size: 0x87
function airdrop_givecrateuseweapon( crate )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    weapon_utility::saveweaponstates();
    var_fc765584ce032f1b = self.lastnormalweaponobj;
    crateweaponobj = makeweapon( crate.bundle.var_4222d2cf0099c465 ?? killstreak_utility::function_7f760f39556df2e2() );
    inventory_utility::_giveweapon( crateweaponobj );
    thread airdrop_watchforcrateuseend( crateweaponobj, var_fc765584ce032f1b );
    self switchtoweapon( crateweaponobj );
}

// Namespace airdrop
// Params 2
// Checksum 0x81d806f1, Offset: 0x837e
// Size: 0xcc
function airdrop_watchforcrateuseend( crateweaponobj, var_fc765584ce032f1b )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"crate_use_end" );
    
    if ( isdefined( var_fc765584ce032f1b ) && !isnullweapon( var_fc765584ce032f1b ) )
    {
        self.lastnormalweaponobj = var_fc765584ce032f1b;
    }
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( crateweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( crateweaponobj );
        return;
    }
    
    inventory_utility::_takeweapon( crateweaponobj );
    
    if ( isdefined( self.lastdroppableweaponobj ) )
    {
        var_834e1ea1f94aef8a = getdvarint( @"hash_dba4a054e67dd255", 0 ) == 1;
        lastweaponobj = weapon_utility::restoreweaponstates( self.lastdroppableweaponobj, var_834e1ea1f94aef8a );
        self switchtoweapon( lastweaponobj );
        thread inventory_utility::forcevalidweapon( lastweaponobj );
    }
}

// Namespace airdrop
// Params 3
// Checksum 0x69ade6bf, Offset: 0x8452
// Size: 0x140
function stopusingcrate( player, triggerobject, fromsuccess )
{
    if ( self && arraycontains( self.playersusing, player ) )
    {
        self.playersusing = arrayremove( self.playersusing, player );
    }
    
    if ( !isdefined( triggerobject ) )
    {
        triggerobject = self;
    }
    
    leveldata = getleveldata( self.cratetype );
    var_fe2e02bb9639a437 = leveldata.var_fe2e02bb9639a437;
    
    if ( var_fe2e02bb9639a437 && player isgestureplaying( var_fe2e02bb9639a437 ) )
    {
        player stopgestureviewmodel( var_fe2e02bb9639a437, 0.1 );
    }
    
    action = player.isjuggernaut ? "juggCrateUse" : "crateUse";
    player utility::callsharedfunc( #"airdrop", #"allowactionset", action, 1 );
    player utility::callsharedfunc( #"airdrop", #"updateuiprogress", triggerobject, 0 );
    player stopusesound( self );
    
    if ( self && leveldata.var_d21f48cf6177d272 )
    {
        self [[ leveldata.var_d21f48cf6177d272 ]]( player, fromsuccess );
    }
    
    player notify( #"crate_use_end" );
}

// Namespace airdrop
// Params 2
// Checksum 0x4910ee17, Offset: 0x859a
// Size: 0x1e1
function canstartusingcrate( player, var_b5f0b2f693d55745 )
{
    if ( utility::issharedfuncdefined( #"airdrop", #"specialcase_canusecrate" ) )
    {
        if ( !player [[ utility::getsharedfunc( #"airdrop", #"specialcase_canusecrate" ) ]]() )
        {
            return 0;
        }
    }
    
    if ( !player val::get( "crate_use" ) )
    {
        return 0;
    }
    
    if ( !player player::isreallyalive() )
    {
        return 0;
    }
    
    if ( player isonladder() )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_618b9c003b5b3883", 0 ) == 0 )
    {
        if ( isdefined( self.playerscaptured[ player getentitynumber() ] ) )
        {
            return 0;
        }
    }
    
    if ( self.issquadonlycrate )
    {
        if ( isdefined( self.playersused ) && arraycontains( self.playersused, player ) )
        {
            return 0;
        }
        
        if ( player.sessionsquadid != self.sessionsquadid || player.team != self.team )
        {
            return 0;
        }
    }
    
    if ( self.isteamonlycrate )
    {
        if ( isdefined( self.playersused ) && arraycontains( self.playersused, player ) )
        {
            return 0;
        }
        
        if ( player.team != self.team )
        {
            return 0;
        }
    }
    
    if ( !self.isusable )
    {
        return 0;
    }
    
    leveldata = getleveldata( self.cratetype );
    
    if ( leveldata.destroyoncapture && self.var_7b7833e7ae988b16 && !self.boobytrapped )
    {
        return 0;
    }
    
    if ( !isdefined( var_b5f0b2f693d55745 ) )
    {
        var_b5f0b2f693d55745 = 1;
    }
    
    if ( var_b5f0b2f693d55745 )
    {
        return canstartusingcratetriggerobject( player );
    }
    
    if ( isbrgamemode() && player isskydiving() )
    {
        return 0;
    }
    
    if ( player.inlaststand )
    {
        return 0;
    }
    
    return 1;
}

// Namespace airdrop
// Params 1
// Checksum 0x2bbe447f, Offset: 0x8784
// Size: 0x119, Type: bool
function canstartusingcratetriggerobject( player )
{
    triggerobject = self;
    assert( isdefined( self.exclusiveuse ), "<dev string:x498>" );
    
    if ( ( !isdefined( self.exclusiveuse ) || self.exclusiveuse ) && isdefined( triggerobject.playerusing ) && triggerobject.playerusing != player )
    {
        return false;
    }
    
    if ( level.teambased && isdefined( self.team ) && self.team != "neutral" )
    {
        leveldata = getleveldata( self.cratetype );
        friendlyuseonly = self.friendlyuseonly ?? leveldata.friendlyuseonly;
        
        if ( friendlyuseonly && player.team != self.team )
        {
            return false;
        }
    }
    
    if ( self.playersusing && arraycontains( self.playersusing, player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace airdrop
// Params 1
// Checksum 0x4cc9b705, Offset: 0x88a6
// Size: 0x147, Type: bool
function cankeepusingcrate( player )
{
    if ( !val::get( "crate_use" ) )
    {
        return false;
    }
    
    if ( !player player::isreallyalive() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    if ( !self.origin )
    {
        return false;
    }
    
    leveldata = getleveldata( self.cratetype );
    
    if ( distancesquared( player.origin, self.origin ) >= leveldata.breakuserangesqr )
    {
        return false;
    }
    
    if ( !self.isusable )
    {
        return false;
    }
    
    if ( self.cratetype == "loadout_drop" )
    {
        if ( !player isonground() && !player isswimming() )
        {
            return false;
        }
    }
    
    if ( player ismeatshieldvictim() )
    {
        return false;
    }
    
    if ( isdefined( self.usecondition ) && !self [[ self.usecondition ]]( player ) )
    {
        return false;
    }
    
    leveldata = getleveldata( self.cratetype );
    
    if ( leveldata.destroyoncapture && self.var_7b7833e7ae988b16 && !self.boobytrapped )
    {
        return false;
    }
    
    return true;
}

// Namespace airdrop
// Params 2
// Checksum 0x9dc660f1, Offset: 0x89f6
// Size: 0x6a
function makecrateusableforplayer( crate, player )
{
    triggerobject = crate gettriggerobject( player );
    function_b65695a6f6fb92df( triggerobject, crate );
    triggerobject enableplayeruse( player );
    
    if ( !crate canstartusingcrate( player, 0 ) )
    {
        triggerobject disableplayeruse( player );
        return;
    }
    
    if ( !crate canstartusingcratetriggerobject( player ) )
    {
        triggerobject disableplayeruse( player );
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x6e87b636, Offset: 0x8a68
// Size: 0x14d
function function_b65695a6f6fb92df( triggerobject, crate )
{
    leveldata = getleveldata( crate.cratetype );
    triggerobject setcursorhint( "HINT_NOICON" );
    triggerobject sethintonobstruction( "hide" );
    triggerobject sethinttag( leveldata.usetag );
    triggerobject sethintdisplayrange( leveldata.userange );
    triggerobject sethintdisplayfov( leveldata.usefov );
    triggerobject setuserange( leveldata.userange );
    triggerobject setusefov( leveldata.usefov );
    triggerobject setusepriority( leveldata.usepriority );
    triggerobject setuseholdduration( "duration_none" );
    
    if ( triggerobject.var_a1e27814a6bc19d5 )
    {
        triggerobject sethintrequiresmashing( 1 );
        triggerobject setusehideprogressbar( 1 );
        holddurationms = ( crate.bundle.var_39ffb255538eabd4 ?? 0.255 ) * 1000;
        triggerobject setuseholdduration( int( holddurationms ) );
        triggerobject sethintstring( crate.rerollstring );
        triggerobject sethintonobstruction( "show" );
        return;
    }
    
    triggerobject sethintstring( crate.capturestring );
}

// Namespace airdrop
// Params 0
// Checksum 0x2c69294e, Offset: 0x8bbd
// Size: 0x294
function watchallcrateusability()
{
    var_920653309e35cbff = 0;
    
    if ( getdvarint( @"scr_airdrop_fast_usable_crates", 0 ) )
    {
        var_920653309e35cbff = 1;
    }
    
    while ( true )
    {
        foreach ( crate in level.cratedata.usablecrates )
        {
            if ( !isdefined( crate ) )
            {
                continue;
            }
            
            crate makeusable();
            crate disableplayeruseforallplayers();
            
            if ( var_920653309e35cbff )
            {
                friendlyuseonly = crate.friendlyuseonly ?? getleveldata( crate.cratetype ).friendlyuseonly;
                
                if ( level.teambased && isdefined( crate.team ) && crate.team != "neutral" && friendlyuseonly )
                {
                    playerlist = function_6a293b884c444a20( level.teamdata[ crate.team ][ "alivePlayers" ], crate.origin, 240 );
                }
                else
                {
                    playerlist = getplayersinradius( crate.origin, 240 );
                }
            }
            else
            {
                playerlist = level.players;
            }
            
            if ( isdefined( crate.var_9d00a9e419829084 ) )
            {
                foreach ( player in playerlist )
                {
                    if ( !crate [[ crate.var_9d00a9e419829084 ]]( player ) )
                    {
                        continue;
                    }
                    
                    makecrateusableforplayer( crate, player );
                }
                
                continue;
            }
            
            foreach ( player in playerlist )
            {
                makecrateusableforplayer( crate, player );
            }
        }
        
        wait 0.1;
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x85726e1, Offset: 0x8e59
// Size: 0x96
function playusesound( player )
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    triggerobject = self;
    
    if ( triggerobject.usetype == 1 || triggerobject.usetype == 3 )
    {
        player playloopsound( bundle.var_b02e477f9e593009 ?? "mp_care_package_owner_cap" );
        return;
    }
    
    player playloopsound( bundle.var_49d9a501d689df0a ?? "mp_care_package_non_owner_cap" );
}

// Namespace airdrop
// Params 1
// Checksum 0x961fbc9e, Offset: 0x8ef7
// Size: 0xb7
function stopusesound( crate )
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    triggerobject = crate;
    
    if ( triggerobject.usetype == 1 || triggerobject.usetype == 3 )
    {
        self stoploopsound( bundle.var_b02e477f9e593009 ?? "mp_care_package_owner_cap" );
    }
    else
    {
        self stoploopsound( bundle.var_49d9a501d689df0a ?? "mp_care_package_non_owner_cap" );
    }
    
    if ( player::isreallyalive() )
    {
        self playsoundonmovingent( bundle.var_f7a3060eb276f885 ?? "mp_care_package_cap_tail" );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x12a4b3f6, Offset: 0x8fb6
// Size: 0x37
function gettriggerobject( player )
{
    if ( player == self.owner && self.supportsreroll )
    {
        return ( self.var_3a9cbf7a21dc0849 ?? self );
    }
    
    return self;
}

// Namespace airdrop
// Params 2
// Checksum 0x4493584b, Offset: 0x8ff6
// Size: 0x199
function cratephysicson( contactpoint, force )
{
    leveldata = getleveldata( self.cratetype );
    
    if ( isdefined( leveldata.cratephysicsoncallback ) )
    {
        self thread [[ leveldata.cratephysicsoncallback ]]();
    }
    
    if ( !isdefined( contactpoint ) )
    {
        contactpoint = ( 0, 0, 0 );
    }
    
    if ( !isdefined( force ) )
    {
        force = ( 0, 0, 0 );
    }
    
    self unlink();
    self physicslaunchserver( contactpoint, force );
    
    if ( isdefined( self.killcament ) && !self.killcament.linked )
    {
        self.killcament linkto( self, "tag_origin", ( 50, 50, 225 ), ( 0, 0, 0 ) );
    }
    
    bodyid = self physics_getbodyid( 0 );
    physics_setbodycenterofmassnormal( bodyid, ( 0, 0, leveldata.var_5cb105a0623aab8c ?? -0.75 ) );
    self.physicsactivated = 1;
    createdangerzone();
    thread monitoraveragevelocityandupdate();
    thread monitorplayerimpact();
    thread function_8ee48acd584ff181();
    
    if ( isdefined( level.wztrain_info ) && utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        data = spawnstruct();
        data.deathoverridecallback = &function_b9f8ca96ebb9ed3a;
        self thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
    
    thread monitorimpact();
}

// Namespace airdrop
// Params 1
// Checksum 0x195bfdf7, Offset: 0x9197
// Size: 0x14c
function function_b9f8ca96ebb9ed3a( data )
{
    engine = train_utility::get_train_engine();
    assert( isdefined( engine ) );
    
    if ( !isdefined( engine ) )
    {
        return;
    }
    
    if ( data.lasttouchedplatform == engine && function_3d0226752ee6e57f( self, engine ) )
    {
        if ( !self.hitbytrain || self.cratetype == "battle_royale_elite_chopper" )
        {
            force = engine.velocity * 150;
            contactpoint = engine.origin + rotatevector( ( 375, 0, -100 ), engine.angles );
            bundle = level.streakglobals.streakbundles[ "airdrop" ];
            self playsound( bundle.var_5e85ae84841a6bfc ?? "mp_care_package_high_impact" );
            self physicslaunchserver( contactpoint, force );
            self.hitbytrain = 1;
        }
        else
        {
            destroycrate();
            return;
        }
    }
    
    wait 1;
    data = spawnstruct();
    data.deathoverridecallback = &function_b9f8ca96ebb9ed3a;
    self thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0x3eb8dec4, Offset: 0x92eb
// Size: 0x80, Type: bool
function private function_3d0226752ee6e57f( crate, train )
{
    trainforward = anglestoforward( train.angles );
    var_b8ff4b8a8631b515 = train getpointinbounds( 1, 0, 0 );
    tocrate = crate.origin - var_b8ff4b8a8631b515;
    var_87206c2adee9ca78 = vectordot( tocrate, trainforward );
    return var_87206c2adee9ca78 > -50;
}

// Namespace airdrop
// Params 0
// Checksum 0x177335fd, Offset: 0x9374
// Size: 0x6b
function cratephysicsoff()
{
    if ( !self.physicsactivated )
    {
        return;
    }
    
    self.physicsactivated = undefined;
    self.physicssettled = undefined;
    
    if ( !self.var_a25ec78207d6214a )
    {
        if ( self function_3d815cf843fd788e() )
        {
            self physicsstopserver();
        }
        else
        {
            assertmsg( "<dev string:x4ec>" );
        }
    }
    
    clearaveragevelocities();
    monitorimpactend();
    monitorplayerimpactend();
    cancelchecklinktotrain();
}

// Namespace airdrop
// Params 0
// Checksum 0x12462915, Offset: 0x93e7
// Size: 0x250
function monitoraveragevelocityandupdate()
{
    self endon( #"death" );
    self notify( #"hash_31db7c73df6bc319" );
    self endon( #"hash_31db7c73df6bc319" );
    checkfrequency = 0.1;
    thread monitoraveragevelocities( checkfrequency, 8 );
    settlecount = 0;
    var_5674a5ca1503ebfd = 0;
    self.isfirstactivation = 1;
    var_ef372701e009cf49 = undefined;
    
    while ( true )
    {
        avlinvel = getaveragelinearvelocity();
        avangvel = getaverageangularvelocity();
        
        if ( isdefined( avlinvel ) && isdefined( avangvel ) )
        {
            if ( avlinvel <= function_31b29cacaf6712bc() && avangvel <= function_a8eef8b3fdb0f7d5() )
            {
                settlecount++;
                var_5674a5ca1503ebfd = 0;
                
                if ( settlecount == function_a28d377e7109bc81() )
                {
                    self.physicssettled = 1;
                    var_ef372701e009cf49 = self.origin;
                    thread activatecrate( self.isfirstactivation );
                    
                    if ( game_utility_mp::lpcfeaturegated() )
                    {
                        monitorimpactend();
                        
                        if ( isdefined( self.killcament ) )
                        {
                            self.killcament delete();
                        }
                    }
                    
                    var_df326735c41ee295 = 0;
                    
                    if ( isdefined( level.var_3274d32eee49c85 ) )
                    {
                        foreach ( trigger in level.var_3274d32eee49c85 )
                        {
                            if ( self istouching( trigger ) )
                            {
                                var_df326735c41ee295 = 1;
                            }
                        }
                    }
                    
                    if ( self.var_da903b1e8121ea2 && !var_df326735c41ee295 )
                    {
                        thread cratephysicsoff();
                    }
                    
                    self notify( #"airdrop_crate_settled" );
                    checkfrequency = 0.1;
                    thread monitoraveragevelocities( checkfrequency, 3, 3 );
                    destroycrateinbadtrigger();
                }
            }
            else
            {
                if ( isdefined( var_ef372701e009cf49 ) )
                {
                    if ( distancesquared( self.origin, var_ef372701e009cf49 ) <= 22500 )
                    {
                        wait checkfrequency;
                        continue;
                    }
                }
                
                var_5674a5ca1503ebfd++;
                settlecount = 0;
                
                if ( var_5674a5ca1503ebfd == 1 )
                {
                    self.physicssettled = undefined;
                    thread deactivatecrate();
                    checkfrequency = 0.1;
                    thread monitoraveragevelocities( checkfrequency, 8 );
                }
            }
            
            wait checkfrequency;
            continue;
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 3
// Checksum 0xb5182e5f, Offset: 0x963f
// Size: 0x1ef
function monitoraveragevelocities( checkfrequency, numdatapoints, var_6771c376279449a3 )
{
    clearaveragevelocities();
    self endon( #"death" );
    self endon( #"hash_5c5f798f003a5cfc" );
    self.linvels = [];
    self.angvels = [];
    self.velstartid = 0;
    self.velendid = 0;
    self.velnumdatapoints = numdatapoints;
    
    if ( isdefined( var_6771c376279449a3 ) )
    {
        var_6771c376279449a3 = int( clamp( var_6771c376279449a3, 0, numdatapoints ) );
        
        if ( var_6771c376279449a3 > 0 )
        {
            for ( i = 0; i < var_6771c376279449a3 ; i++ )
            {
                self.linvels[ self.velstartid + i ] = 0;
                self.angvels[ self.velstartid + i ] = 0;
            }
        }
    }
    
    while ( true )
    {
        bodyid = self physics_getbodyid( 0 );
        linvel = physics_getbodylinvel( bodyid );
        angvel = physics_getbodyangvel( bodyid );
        self.linvels[ self.velendid ] = length( linvel );
        self.angvels[ self.velendid ] = length( angvel );
        self.velendid++;
        var_477dec384248882a = self.velendid - self.velstartid;
        
        if ( var_477dec384248882a > numdatapoints )
        {
            shift = int( var_477dec384248882a ) % int( numdatapoints );
            
            for ( i = 0; i < shift ; i++ )
            {
                self.linvels[ self.velstartid + i ] = undefined;
                self.angvels[ self.velstartid + i ] = undefined;
            }
            
            self.velstartid += shift;
        }
        
        self.avlinvel = undefined;
        self.avangvel = undefined;
        wait checkfrequency;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xa6f972a6, Offset: 0x9836
// Size: 0x60
function getaveragelinearvelocity()
{
    var_7237854e3be197ca = self.avlinvel;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( self.linvels ) )
    {
        return;
    }
    
    if ( self.velendid - self.velstartid < self.velnumdatapoints )
    {
        return;
    }
    
    calculateaveragevelocities();
    return self.avlinvel;
}

// Namespace airdrop
// Params 0
// Checksum 0xe4464bc4, Offset: 0x989f
// Size: 0x60
function getaverageangularvelocity()
{
    var_7237854e3be197ca = self.avangvel;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( self.angvels ) )
    {
        return;
    }
    
    if ( self.velendid - self.velstartid < self.velnumdatapoints )
    {
        return;
    }
    
    calculateaveragevelocities();
    return self.avangvel;
}

// Namespace airdrop
// Params 0
// Checksum 0xc070499a, Offset: 0x9908
// Size: 0x9e
function calculateaveragevelocities()
{
    var_7484219e0f3c28de = 0;
    var_1657b9bf9a60ef51 = 0;
    
    for ( i = self.velstartid; i < self.velendid ; i++ )
    {
        var_7484219e0f3c28de += self.linvels[ i ] ?? 0;
        var_1657b9bf9a60ef51 += self.angvels[ i ] ?? 0;
    }
    
    self.avlinvel = var_7484219e0f3c28de / ( self.velnumdatapoints ?? 1 );
    self.avangvel = var_1657b9bf9a60ef51 / ( self.velnumdatapoints ?? 1 );
}

// Namespace airdrop
// Params 0
// Checksum 0x37808b65, Offset: 0x99ae
// Size: 0x54
function clearaveragevelocities()
{
    self notify( #"hash_5c5f798f003a5cfc" );
    self.linvels = undefined;
    self.angvels = undefined;
    self.velnumdatapoints = undefined;
    self.velstartid = undefined;
    self.velendid = undefined;
    self.avlinvel = undefined;
    self.avangvel = undefined;
}

// Namespace airdrop
// Params 1
// Checksum 0x76bba596, Offset: 0x9a0a
// Size: 0x59
function monitorimpact( delay )
{
    monitorimpactend();
    self endon( #"hash_2d12967047b9fe48" );
    self.monitoringimpact = 1;
    function_bd1ccba5feb9eb8e();
    self physics_registerforcollisioncallback();
    
    if ( !self.monitorimpactinternal )
    {
        monitorimpactinternal( delay );
        
        if ( isdefined( self ) )
        {
            thread monitorimpactend();
        }
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xb7caba55, Offset: 0x9a6b
// Size: 0x524
function monitorimpactinternal( delay )
{
    self endon( #"death" );
    self endon( #"hash_d3f3db20c94f67a0" );
    
    /#
        assert( !self.monitorimpactinternal );
        self.monitorimpactinternal = 1;
    #/
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    var_a0dc21757f0d4d96 = 0;
    firstimpact = 0;
    leveldata = getleveldata( self.cratetype );
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( !firstimpact )
        {
            if ( isdefined( self.killcament ) )
            {
                self.killcament unlink();
                self.killcament.linked = 0;
            }
        }
        
        if ( isdefined( leveldata.var_45ed207b4ae8c3b8 ) )
        {
            self thread [[ leveldata.var_45ed207b4ae8c3b8 ]]( !firstimpact );
        }
        
        if ( bundle.var_c226de898c0e2034 && !firstimpact )
        {
            activatecrate( 1 );
        }
        
        if ( isdefined( ent ) )
        {
            if ( impactshoulddestroyent( ent, bundle.var_649eed4af78825d9 ) )
            {
                if ( isdefined( ent.vehicletype ) )
                {
                    if ( isdefined( ent.streakinfo ) )
                    {
                        if ( isdefined( ent.var_1ed880df52e3f6df ) && isdefined( ent.var_1ed880df52e3f6df.cleanupfunc ) )
                        {
                            ent thread [[ ent.var_1ed880df52e3f6df.cleanupfunc ]]();
                        }
                        else if ( ent helper_drone::ishelperdrone() )
                        {
                            ent thread helper_drone::helperdrone_handledeathdamage();
                        }
                    }
                    else
                    {
                        var_d30f1abdff579aac = getdvarint( @"scr_crate_destroy_vehicle", 1 );
                        
                        if ( var_d30f1abdff579aac == 2 && !firstimpact || var_d30f1abdff579aac == 1 )
                        {
                            isbossvehicle = ent vehicle::is_boss();
                            
                            if ( !isbossvehicle && !ent.exfilhelicopter && ent getcandamage() )
                            {
                                ent.dontspawnhusk = 1;
                                
                                if ( ent vehicle::can_explode() )
                                {
                                    ent vehicle::explode();
                                }
                                else
                                {
                                    ent dodamage( 1000, position, self.owner ?? self, self, "MOD_CRUSH" );
                                }
                            }
                        }
                    }
                }
                else if ( ent.classname == "scriptable_iw8_chicken_01" )
                {
                    thread airdrop_crushchicken( ent );
                }
                else if ( ent.equipmentref == "equip_tac_cover" )
                {
                    ent [[ ent.deletefunc ]]( 0, 1, 1 );
                }
                else if ( ent.turrettype == "sentry_turret" )
                {
                    ent notify( #"kill_turret", 1, 1 );
                }
                else if ( isagent( ent ) || ent.equipmentref )
                {
                    ent dodamage( 1000, position, self.owner ?? self, self, "MOD_CRUSH" );
                }
            }
            
            if ( !ent.var_b6a3f46ec4332fd8 )
            {
                function_c51a4281288a6e46( normal, ent );
                checklinktogenericmovingplatform( ent );
                checklinktotrain( ent );
            }
            else
            {
                var_3112a568fd49b411 = self getscriptablehaspart( "impact_vfx" );
                
                if ( var_3112a568fd49b411 )
                {
                    self setscriptablepartstate( "impact_vfx", "high" );
                }
                
                playfx( utility::getfx( "airdrop_crate_impact_ground" ), position, normal );
                self playsurfacesound( "mp_care_package_low_impact", "user_terrain_1" );
                function_c59b61455f5e334();
                
                if ( self.var_25ea9d29adb026a7 )
                {
                    thread destroycrate( 1 );
                }
                else
                {
                    activatecrate( self.isfirstactivation );
                }
                
                self notify( #"hash_d3f3db20c94f67a0" );
                return;
            }
        }
        
        var_48326eada7705348 = bundle.var_f284855847797bfd || self.var_552ae1e7524db825;
        
        if ( var_48326eada7705348 && !firstimpact && self.physicsactivated )
        {
            self physicsstopserver();
            thread reactivatephysics( 1 );
        }
        
        firstimpact = 1;
        surface = physics_getsurfacetypefromflags( flag1 );
        surfacetype = getsubstr( surface[ "name" ], 9 );
        
        if ( surfacetype == "water" && !self.inwater )
        {
            self.inwater = 1;
        }
        
        if ( surfacetype == "glass_pane" )
        {
            radius = level.var_37d1bac25fa1646 ?? 100;
            glassradiusdamage( self.origin - ( 0, 0, 10 ), radius, 1000, 1000 );
            thread reactivatephysics( 0 );
        }
        
        if ( gettime() - var_a0dc21757f0d4d96 >= 200 )
        {
            var_a0dc21757f0d4d96 = gettime();
            impact_fx_play( position, normal, impulse, surfacetype );
        }
    }
}

// Namespace airdrop
// Params 4
// Checksum 0x41114af6, Offset: 0x9f97
// Size: 0x6a
function impact_fx_play( position, normal, impulse, surfacetype )
{
    if ( surfacetype == "user_terrain1" )
    {
        surfacetype = "user_terrain_1";
    }
    
    if ( surfacetype == "user_terrain5" )
    {
        surfacetype = "oil_puddle";
    }
    
    if ( surfacetype == "unused0" )
    {
        surfacetype = "unused_0";
    }
    
    playimpactfx( position, normal, impulse, surfacetype );
}

// Namespace airdrop
// Params 1
// Checksum 0x8ac17790, Offset: 0xa009
// Size: 0x76
function reactivatephysics( physics_stopped = 0 )
{
    self notify( #"hash_2be7fee714296062" );
    self endon( #"hash_2be7fee714296062" );
    self.var_a25ec78207d6214a = physics_stopped;
    waitframe();
    self.var_a25ec78207d6214a = undefined;
    
    if ( !self.physicsactivated )
    {
        return;
    }
    
    self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self physics_registerforcollisioncallback();
}

// Namespace airdrop
// Params 1
// Checksum 0x435afc0f, Offset: 0xa087
// Size: 0xdf
function checklinktogenericmovingplatform( ent )
{
    if ( !getdvarint( @"hash_9399ef9aeef7716c", 1 ) )
    {
        return;
    }
    
    if ( isdefined( ent.cratetype ) )
    {
        return;
    }
    
    if ( !isdefined( ent ) || ent.var_5ae0f89cc91f22ec == 0 )
    {
        return;
    }
    
    if ( isdefined( self.var_2c72c325ed305aee ) )
    {
        return;
    }
    
    self.var_2c72c325ed305aee = 1;
    
    if ( isdefined( ent ) && isdefined( ent.velocity ) )
    {
        istrain = isdefined( ent.script_noteworthy ) && isstartstr( ent.script_noteworthy, "train_" );
        
        if ( !istrain )
        {
            self physics_applyimpulse( self physics_getentitycenterofmass()[ "unscaled" ], ent.velocity * 60 * 10 );
        }
    }
    
    thread function_8a19b100e472c5ad();
    thread function_9e9ed222570799d4( 10 );
}

// Namespace airdrop
// Params 0
// Checksum 0x62225556, Offset: 0xa16e
// Size: 0x2e5
function function_8a19b100e472c5ad()
{
    level endon( #"game_ended" );
    self endon( #"hash_a04dcda8721334ec" );
    v_up_previous = anglestoup( self.angles );
    v_forward_previous = anglestoforward( self.angles );
    v_right_previous = anglestoright( self.angles );
    self.v_good = ( 0, 0, 0 );
    waitframe();
    
    while ( isdefined( self ) )
    {
        ignorearr = [];
        
        if ( level.cratedata.crates.size > 0 )
        {
            cratearr = level.cratedata.crates;
        }
        else
        {
            cratearr = [ self ];
        }
        
        foreach ( crate in cratearr )
        {
            ignorearr[ ignorearr.size ] = crate;
            
            if ( crate.mountmantlemodel )
            {
                ignorearr[ ignorearr.size ] = crate.mountmantlemodel;
            }
        }
        
        var_d96339dcf91fd6cd = utility::function_7c45b71b8e0d3cff( ignorearr, 50, -70 );
        
        if ( !var_d96339dcf91fd6cd.groundent || var_d96339dcf91fd6cd.groundent == self || var_d96339dcf91fd6cd.groundent.classname == "script_vehicle" || var_d96339dcf91fd6cd.groundent.var_ce8cb07fc75576b1 )
        {
            waitframe();
            continue;
        }
        else
        {
            ent = var_d96339dcf91fd6cd.groundent;
        }
        
        v_up = anglestoup( self.angles );
        var_bc7b9b7063d85bd0 = 0;
        
        if ( vectordot( v_up, v_up_previous ) > 0.997 )
        {
            var_bc7b9b7063d85bd0 = 1;
            self.v_good = v_up;
        }
        else
        {
            v_up_previous = v_up;
        }
        
        v_forward = anglestoforward( self.angles );
        var_e0bc2ca132936d0a = 0;
        
        if ( vectordot( v_forward, v_forward_previous ) > 0.997 )
        {
            var_e0bc2ca132936d0a = 1;
            self.v_good = v_forward;
        }
        else
        {
            v_forward_previous = v_forward;
        }
        
        v_right = anglestoright( self.angles );
        var_10af56654fde7b35 = 0;
        
        if ( vectordot( v_right, v_right_previous ) > 0.997 )
        {
            var_10af56654fde7b35 = 1;
            self.v_good = v_right;
        }
        else
        {
            v_right_previous = v_right;
        }
        
        if ( var_bc7b9b7063d85bd0 || var_e0bc2ca132936d0a || var_10af56654fde7b35 )
        {
            self.var_573cb169eb46c54d = ent;
        }
        else
        {
            self.var_573cb169eb46c54d = undefined;
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x25e21169, Offset: 0xa45b
// Size: 0x14e
function function_c51a4281288a6e46( hitnormal, hitent )
{
    v_up = anglestoup( self.angles );
    f_check = vectordot( v_up, ( 0, 0, 1 ) );
    v_check = v_up;
    str_normal_up = "up";
    v_forward = anglestoforward( self.angles );
    f_forward = vectordot( v_forward, ( 0, 0, 1 ) );
    
    if ( abs( f_forward ) > abs( f_check ) )
    {
        f_check = f_forward;
        v_check = v_forward;
        str_normal_up = "forward";
    }
    
    v_right = anglestoright( self.angles );
    f_right = vectordot( v_right, ( 0, 0, 1 ) );
    
    if ( abs( f_right ) > abs( f_check ) )
    {
        f_check = f_right;
        v_check = v_right;
        str_normal_up = "right";
    }
    
    if ( abs( vectordot( v_check, hitnormal ) ) > 0.997 )
    {
        self.var_592a178cf29dd766 = hitent;
        self.v_normal = hitnormal;
        self.str_normal_up = str_normal_up;
        return;
    }
    
    self.var_592a178cf29dd766 = undefined;
}

// Namespace airdrop
// Params 1
// Checksum 0x9ab81131, Offset: 0xa5b1
// Size: 0x30b
function function_9e9ed222570799d4( time )
{
    level endon( #"game_ended" );
    
    /#
        if ( getdvarint( @"hash_309011a4a9533351" ) )
        {
            thread function_97e5b073e1c7916();
        }
    #/
    
    self endon( #"hash_a04dcda8721334ec" );
    end_time = gettime() + time * 1000;
    
    while ( isdefined( self ) && gettime() < end_time )
    {
        if ( isdefined( self.var_573cb169eb46c54d ) && isdefined( self.var_592a178cf29dd766 ) )
        {
            if ( self.var_573cb169eb46c54d ismovingplatform() )
            {
                if ( vectordot( self.v_normal, ( 0, 0, 1 ) ) < 0 )
                {
                    self.v_normal *= -1;
                }
                
                switch ( self.str_normal_up )
                {
                    case #"hash_fa3db8f6bd73eb80":
                        math::set_matrix_from_up( self.v_normal );
                        break;
                    case #"hash_87171c4dee93dfa":
                        v_new_up = vectorcross( anglestoright( self.angles ), self.v_normal );
                        math::build_matrix_from_up_and_angles( v_new_up, vectortoangles( self.v_normal ) );
                        break;
                    case #"hash_96815ce4f2a3dbc5":
                        v_new_up = vectorcross( self.v_normal, anglestoforward( self.angles ) );
                        math::build_matrix_from_up_and_angles( v_new_up, vectortoangles( self.v_normal ) );
                        break;
                    default:
                        assert( "<dev string:x608>" );
                        break;
                }
                
                contents = trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
                ignorelist = [ self ];
                caststart = self.origin + anglestoup( self.angles ) * 10;
                castend = self.origin;
                traceresult = trace::ray_trace( caststart, castend, ignorelist, contents );
                
                if ( isdefined( traceresult[ "position" ] ) && traceresult[ "entity" ] == self.var_573cb169eb46c54d )
                {
                    self.origin = traceresult[ "position" ] + vectornormalize( self.v_normal ) * 0.1;
                }
                
                if ( self islinked() || self.var_573cb169eb46c54d getlinkedparent() == self )
                {
                    self unlink();
                }
                
                if ( self.var_573cb169eb46c54d getlinkedparent() == self )
                {
                    self.var_573cb169eb46c54d unlink();
                }
                
                if ( utility::function_f77200072cabe8bc( self, self.var_573cb169eb46c54d ) )
                {
                    self linkto( self.var_573cb169eb46c54d );
                }
                
                activatecrate( self.isfirstactivation );
                self.physicsactivated = 0;
                self.physicssettled = 1;
                self notify( #"hash_d3f3db20c94f67a0" );
                self notify( #"hash_a04dcda8721334ec" );
                break;
            }
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_a04dcda8721334ec" );
    }
}

/#

    // Namespace airdrop
    // Params 0
    // Checksum 0xda8b8f0b, Offset: 0xa8c4
    // Size: 0x1e8, Type: dev
    function function_97e5b073e1c7916()
    {
        while ( isdefined( self ) )
        {
            line( self.origin, self.origin + anglestoforward( self.angles ) * 25, ( 1, 0, 0 ), 1, 0, 1 );
            line( self.origin, self.origin + anglestoright( self.angles ) * 25, ( 0, 1, 0 ), 1, 0, 1 );
            line( self.origin, self.origin + anglestoup( self.angles ) * 25, ( 1, 0, 1 ), 1, 0, 1 );
            
            if ( isdefined( self.str_normal_up ) )
            {
                print3d( self.origin + ( 0, 0, 50 ), self.str_normal_up, ( 1, 1, 1 ), 1, 1, 1, 1 );
            }
            
            if ( isdefined( self.v_normal ) )
            {
                line( self.origin, self.origin + self.v_normal * 100, ( 1, 1, 0 ), 1, 0, 1 );
            }
            
            if ( isdefined( self.v_good ) && isdefined( self.v_normal ) )
            {
                v_cross = vectorcross( self.v_good, self.v_normal );
                line( self.origin, self.origin + vectornormalize( v_cross ) * 100, ( 0, 1, 1 ), 1, 0, 1 );
                line( self.origin, self.origin + vectornormalize( v_cross ) * -100, ( 0, 1, 1 ), 1, 0, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace airdrop
// Params 1
// Checksum 0x4bcfe1b9, Offset: 0xaab4
// Size: 0x9f
function checklinktotrain( ent )
{
    if ( isdefined( ent ) && isdefined( ent.script_noteworthy ) && ( isstartstr( ent.script_noteworthy, "train_" ) || ent.script_noteworthy == "moving_platform" ) && !isdefined( self getlinkedparent() ) )
    {
        if ( isdefined( self.trainent ) )
        {
            if ( self.trainent == ent )
            {
                return;
            }
            else
            {
                cancelchecklinktotrain();
            }
        }
        
        self.trainent = ent;
        self.traincylestolink = 4;
        thread checklinktotraininternal( ent );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xd1d4f0a, Offset: 0xab5b
// Size: 0x28c
function checklinktotraininternal( platform )
{
    self endon( #"death" );
    self endon( #"hash_fc03f18325da2879" );
    platform endon( #"death" );
    leveldata = getleveldata( self.cratetype );
    contents = trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
    ignorelist = [ self ];
    
    foreach ( linkedent in self getlinkedchildren( 1 ) )
    {
        ignorelist[ ignorelist.size ] = linkedent;
    }
    
    self.var_cf9be163700309b8 = undefined;
    self.traintracefails = 0;
    self.traintracesuccesses = 0;
    
    while ( self.traintracefails < 20 )
    {
        caststart = self.origin + anglestoup( self.angles ) * leveldata.halfheight;
        castend = caststart + ( 0, 0, -200 );
        traceresult = trace::ray_trace( caststart, castend, ignorelist, contents );
        
        if ( traceresult.size > 0 && isdefined( traceresult[ "entity" ] ) && utility::is_moving_platform_ent( traceresult[ "entity" ] ) )
        {
            var_a3732bdcc2f9c6ed = traceresult[ "position" ];
            var_b2bb7649b876774b = platform.origin;
            var_bac8f3551b7966db = platform.angles;
            var_cf9be163700309b8 = var_a3732bdcc2f9c6ed - var_b2bb7649b876774b;
            var_cf9be163700309b8 = rotatevectorinverted( var_cf9be163700309b8, var_bac8f3551b7966db );
            
            if ( self.var_cf9be163700309b8 )
            {
                var_a490143dc6878f78 = distancesquared( var_cf9be163700309b8, self.var_cf9be163700309b8 );
                
                if ( var_a490143dc6878f78 > 10 )
                {
                    self.traintracefails++;
                    self.traintracesuccesses = 0;
                }
                else
                {
                    self.traintracesuccesses++;
                    
                    if ( self.traintracesuccesses >= 4 )
                    {
                        self linkto( platform );
                        activatecrate( self.isfirstactivation );
                        thread cratephysicsoff();
                        break;
                    }
                }
            }
            
            self.var_cf9be163700309b8 = var_cf9be163700309b8;
        }
        else
        {
            break;
        }
        
        wait 0.1;
    }
    
    thread cancelchecklinktotrain();
}

// Namespace airdrop
// Params 0
// Checksum 0x3f8ab345, Offset: 0xadef
// Size: 0x36
function cancelchecklinktotrain()
{
    self notify( #"hash_fc03f18325da2879" );
    self.trainent = undefined;
    self.var_cf9be163700309b8 = undefined;
    self.traintracefails = undefined;
    self.traintracesuccesses = undefined;
}

// Namespace airdrop
// Params 1
// Checksum 0x371498f6, Offset: 0xae2d
// Size: 0x5a
function airdrop_crushchicken( chicken )
{
    self endon( #"death" );
    crushtime = gettime();
    
    while ( gettime() - crushtime < 3000 )
    {
        chicken dodamage( 100, chicken.origin, self, self, "MOD_CRUSH" );
        wait 0.5;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x3b09026a, Offset: 0xae8f
// Size: 0x9c
function monitorimpactend()
{
    if ( !self.monitoringimpact )
    {
        return;
    }
    
    self notify( #"hash_2d12967047b9fe48" );
    self.monitoringimpact = undefined;
    function_c59b61455f5e334();
    var_3112a568fd49b411 = self getscriptablehaspart( "idle_sfx" );
    
    if ( var_3112a568fd49b411 )
    {
        self setscriptablepartstate( "idle_sfx", "sfx_on" );
    }
    else
    {
        function_30c0a0dcc3612e25();
    }
    
    self physics_unregisterforcollisioncallback();
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"hash_9ff09166359e2ed7" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( self );
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x44160d9b, Offset: 0xaf33
// Size: 0x18e, Type: bool
function impactshoulddestroyent( entity, var_d0917dc64344cc99 = 0 )
{
    if ( level.streakglobals.streakbundles[ entity.streakname ].var_67ee820944886d2d )
    {
        return false;
    }
    
    var_40e73568b07a178a = max( abs( self.avangvel ?? var_d0917dc64344cc99 ), abs( self.avlinvel ?? var_d0917dc64344cc99 ) );
    
    if ( var_40e73568b07a178a < ( var_d0917dc64344cc99 ?? 0 ) )
    {
        return false;
    }
    
    if ( !self.physicssettled )
    {
        if ( isdefined( entity.classname ) )
        {
            if ( entity.var_b6a3f46ec4332fd8 )
            {
                return false;
            }
            else if ( entity.classname == "worldspawn" )
            {
                return false;
            }
            else if ( entity.classname == "script_vehicle" )
            {
                if ( entity.targetname == "veh_jup_nuclear_locomotive" || entity.targetname == "veh_sat_mil_lnd_scud_truck_cq" )
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            else if ( entity.classname == "misc_turret" )
            {
                return true;
            }
            else if ( issubstr( entity.classname, "scriptable_" ) )
            {
                return true;
            }
            else if ( entity.classname == "script_model" )
            {
                return true;
            }
            else if ( isagent( entity ) )
            {
                return true;
            }
            else if ( entity.equipmentref )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace airdrop
// Params 0
// Checksum 0x53b49022, Offset: 0xb0ca
// Size: 0x16d
function monitorplayerimpact()
{
    monitorplayerimpactend();
    self endon( #"death" );
    self endon( #"hash_d5d8f2838d9f5493" );
    pushent = self;
    
    if ( isdefined( self.mountmantlemodel ) )
    {
        pushent = self.mountmantlemodel;
    }
    
    damageent = undefined;
    
    if ( isdefined( self.owner ) )
    {
        damageent = self.owner;
    }
    
    while ( isdefined( pushent ) )
    {
        pushent waittill( #"player_pushed", player, linearvelocity );
        
        if ( isdefined( player ) && ( isplayer( player ) || isagent( player ) ) && player player::isreallyalive() )
        {
            isfalling = linearvelocity[ 2 ] <= -8;
            isaboveplayer = 0;
            playerposition = undefined;
            
            if ( player tagexists( "j_mainroot" ) )
            {
                playerposition = player gettagorigin( "j_mainroot" );
                leveldata = getleveldata( self.cratetype );
                midpoint = self.origin + anglestoup( self.angles ) * leveldata.halfheight;
                isaboveplayer = playerposition[ 2 ] <= midpoint[ 2 ];
            }
            
            if ( isfalling && isaboveplayer )
            {
                eattacker = damageent;
                
                if ( !isdefined( eattacker ) )
                {
                    eattacker = player;
                }
            }
        }
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xe2c77883, Offset: 0xb23f
// Size: 0xe
function monitorplayerimpactend()
{
    self notify( #"hash_d5d8f2838d9f5493" );
}

// Namespace airdrop
// Params 4
// Checksum 0xef7d5c47, Offset: 0xb255
// Size: 0x1b7
function playimpactfx( position, normal, impulse, surfacetype )
{
    bundle = self.bundle ?? level.streakglobals.streakbundles[ "airdrop" ];
    
    if ( surfacetype != "glass_pane" )
    {
        var_d3d13cba7f1b4616 = "airdrop_crate_impact_ground";
        impactsound = "mp_care_package_low_impact";
        var_3112a568fd49b411 = self getscriptablehaspart( "impact_vfx" );
        scriptablepartstate = "low";
        
        if ( surfacetype == "water" )
        {
            var_d3d13cba7f1b4616 = "airdrop_crate_impact_water";
            impactsound = bundle.var_a9a11a07bbb53c6b ?? "mp_care_package_impact_water_body";
            scriptablepartstate = "water";
        }
        else if ( impulse > 350 )
        {
            var_d3d13cba7f1b4616 = "airdrop_crate_impact_ground";
            impactsound = bundle.var_ba804cdec182e814 ?? "mp_care_package_high_impact";
            scriptablepartstate = "high";
        }
        else if ( 350 >= impulse && impulse > 175 )
        {
            var_d3d13cba7f1b4616 = "airdrop_crate_impact_ground";
            impactsound = bundle.var_6677c1e08fb05f70 ?? "mp_care_package_med_impact";
            scriptablepartstate = "medium";
        }
        else if ( 175 >= impulse && impulse > 30 )
        {
            var_d3d13cba7f1b4616 = "airdrop_crate_impact_ground";
            impactsound = bundle.var_9241b22c21a176f8 ?? "mp_care_package_low_impact";
            scriptablepartstate = "low";
        }
        
        if ( var_3112a568fd49b411 )
        {
            self setscriptablepartstate( "impact_vfx", scriptablepartstate );
        }
        else
        {
            playfx( utility::getfx( var_d3d13cba7f1b4616 ), position, normal );
            
            if ( surfacetype == "unused1" )
            {
                surfacetype = "user_terrain_1";
            }
            
            self playsurfacesound( impactsound, surfacetype );
        }
    }
    
    function_c59b61455f5e334();
}

// Namespace airdrop
// Params 0
// Checksum 0xd158b508, Offset: 0xb414
// Size: 0x114
function function_bd1ccba5feb9eb8e()
{
    foreach ( override in level.streakglobals.streakbundles[ "airdrop" ].var_b6e36b250a73be73 )
    {
        if ( getdvarint( override.dvarstring, 0 ) )
        {
            fallingsound = override.var_a4b7def0c6a7752b;
            break;
        }
    }
    
    if ( !fallingsound )
    {
        bundle = self.bundle ?? level.streakglobals.streakbundles[ "airdrop" ];
        fallingsound = bundle.var_a4b7def0c6a7752b ?? "mp_care_package_drop_lp";
    }
    
    self playloopsound( fallingsound );
    self.fallingsound = fallingsound;
}

// Namespace airdrop
// Params 0
// Checksum 0x761b4774, Offset: 0xb530
// Size: 0x27
function function_c59b61455f5e334()
{
    if ( self.fallingsound )
    {
        self stoploopsound( self.fallingsound );
        self.fallingsound = undefined;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xd03a09ff, Offset: 0xb55f
// Size: 0xd4
function function_30c0a0dcc3612e25()
{
    var_e817d31340df4fc7 = undefined;
    
    foreach ( override in level.streakglobals.streakbundles[ "airdrop" ].var_b6e36b250a73be73 )
    {
        if ( getdvarint( override.dvarstring, 0 ) )
        {
            var_e817d31340df4fc7 = override.var_ca78330d914a94e;
            break;
        }
    }
    
    if ( !var_e817d31340df4fc7 )
    {
        return;
    }
    
    self playloopsound( var_e817d31340df4fc7 );
    self.var_e817d31340df4fc7 = var_e817d31340df4fc7;
}

// Namespace airdrop
// Params 0
// Checksum 0x97c12b6f, Offset: 0xb63b
// Size: 0x27
function function_ee6542baef351b7f()
{
    if ( self.var_e817d31340df4fc7 )
    {
        self stoploopsound( self.var_e817d31340df4fc7 );
        self.var_e817d31340df4fc7 = undefined;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x62ed8635, Offset: 0xb66a
// Size: 0x84
function createdangerzone()
{
    if ( game_utility_mp::lpcfeaturegated() )
    {
        return;
    }
    
    if ( !utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        return;
    }
    
    destroydangerzone();
    
    if ( isdefined( self.markerposition ) )
    {
        self.dangerzoneid = [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"carepackage_drop", self.markerposition, self.team, self.owner );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x485ac437, Offset: 0xb6f6
// Size: 0x9b
function destroydangerzone()
{
    if ( utility::issharedfuncdefined( #"spawn", #"isspawninfluenceractive" ) && utility::issharedfuncdefined( #"spawn", #"removeSpawnInfluencer" ) )
    {
        dangerzoneid = self.dangerzoneid;
        
        if ( isdefined( dangerzoneid ) && [[ utility::getsharedfunc( #"spawn", #"isspawninfluenceractive" ) ]]( dangerzoneid ) )
        {
            [[ utility::getsharedfunc( #"spawn", #"removeSpawnInfluencer" ) ]]( dangerzoneid );
        }
        
        self.dangerzoneid = undefined;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xdf008e76, Offset: 0xb799
// Size: 0xa5
function _createnavobstacle()
{
    self notify( #"createnavobstacle" );
    self endon( #"createnavobstacle" );
    
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
    }
    
    leveldata = getleveldata( self.cratetype );
    navobstacleid = createnavobstaclebybounds( self.origin, leveldata.navobstaclebounds, self.angles );
    self.navobstacleid = navobstacleid;
    childthread _watchnavobstacle( navobstacleid, self.origin, leveldata.navobstacleupdatedistsqr );
    return navobstacleid;
}

// Namespace airdrop
// Params 3
// Checksum 0x2910ef29, Offset: 0xb847
// Size: 0x4f
function _watchnavobstacle( id, origin, updatedistsqr )
{
    self endon( #"death" );
    
    while ( distancesquared( origin, self.origin ) < updatedistsqr )
    {
        wait 0.5;
    }
    
    thread _createnavobstacle();
}

// Namespace airdrop
// Params 0
// Checksum 0xa395867d, Offset: 0xb89e
// Size: 0x33
function _destroynavobstacle()
{
    self notify( #"createnavobstacle" );
    
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
    }
    
    self.navobstacleid = undefined;
}

// Namespace airdrop
// Params 1
// Checksum 0x5d8c29c6, Offset: 0xb8d9
// Size: 0x129, Type: bool
function createmountmantlemodel( prefab_brushmodel )
{
    leveldata = getleveldata( self.cratetype );
    
    if ( !isdefined( prefab_brushmodel ) )
    {
        return false;
    }
    
    if ( isdefined( self.mountmantlemodel ) )
    {
        self.mountmantlemodel delete();
    }
    
    mountmantlemodel = spawn( "script_model", self.origin );
    mountmantlemodel dontinterpolate();
    mountmantlemodel.angles = self.angles;
    mountmantlemodel.owner = self.owner;
    mountmantlemodel.unresolved_collision_func = &crateunresolvedcollisioncallback;
    mountmantlemodel.killcament = self.killcament;
    mountmantlemodel.mountmantlemodel = 1;
    mountmantlemodel.var_7814545a8310756d = 1;
    mountmantlemodel.var_58f58ae1d854e3e4 = leveldata.var_58f58ae1d854e3e4;
    mountmantlemodel.unresolved_collision_notify_min = 1;
    mountmantlemodel clonebrushmodeltoscriptmodel( prefab_brushmodel );
    mountmantlemodel linkto( self );
    self.mountmantlemodel = mountmantlemodel;
    mountmantlemodel.crate = self;
    return true;
}

// Namespace airdrop
// Params 0
// Checksum 0xf349fc95, Offset: 0xba0b
// Size: 0x27
function destroymountmantlemodel()
{
    if ( isdefined( self.mountmantlemodel ) )
    {
        self.mountmantlemodel delete();
    }
    
    self.mountmantlemodel = undefined;
}

// Namespace airdrop
// Params 2
// Checksum 0x16ed8c35, Offset: 0xba3a
// Size: 0x152
function crateunresolvedcollisioncallback( hitent, penetration )
{
    assert( isdefined( level.cratedata ), "<dev string:x65a>" );
    
    if ( level.cratedata.unresolvedcollisiontolerancesqr > 0 )
    {
        if ( lengthsquared( penetration ) <= level.cratedata.unresolvedcollisiontolerancesqr )
        {
            return;
        }
    }
    
    crate_bundle = level.streakglobals.streakbundles[ "airdrop_crate" ];
    
    if ( isdefined( crate_bundle ) && isdefined( crate_bundle.var_f35887e9870ee93d ) )
    {
        objweapon = makeweapon( crate_bundle.var_f35887e9870ee93d );
        self.streakinfo = killstreak_utility::createstreakinfo( "airdrop_crate", self.owner );
    }
    
    if ( !crate_bundle.var_aff097f95f7da3f7 )
    {
        hitent dodamage( 1000, hitent.origin, self.owner, self, "MOD_CRUSH", objweapon );
    }
    
    self endon( #"death" );
    hitent endon( #"death_or_disconnect" );
    
    if ( isplayer( hitent ) && hitent player::isreallyalive() )
    {
        utility::callsharedfunc( #"airdrop", #"unresolvedcollisionnearestnode", hitent, undefined, self );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xe8665f53, Offset: 0xbb94
// Size: 0x1b4
function _createheadicon()
{
    if ( self.disallowheadiconid || self.headiconactive )
    {
        return;
    }
    
    streakname = self.streakinfo.streakname ?? "airdrop";
    airdropbundle = self.bundle ?? killstreak_utility::function_f943c0602acdc2af( streakname );
    imageoverride = undefined;
    var_2647798941f03f3b = undefined;
    headiconid = undefined;
    
    if ( isdefined( airdropbundle ) )
    {
        if ( airdropbundle.var_a9ce51c7cc9d726a )
        {
            imageoverride = airdropbundle.var_310d27bcf76a7615;
            var_2647798941f03f3b = airdropbundle.var_dde030a4aeac1694;
        }
        
        headiconid = entityheadicons::setheadicon_killstreak( self, imageoverride, undefined, var_2647798941f03f3b );
        
        if ( airdropbundle.var_300b7486c8af76bc && isdefined( self.owner ) )
        {
            self.headiconid = headiconid;
            rewardbundle = killstreak_utility::function_f943c0602acdc2af( self.data.streakname );
            function_b8253b38b4a378b1( rewardbundle.overheadicon, self.owner );
        }
    }
    else
    {
        leveldata = getleveldata( self.cratetype );
        headiconid = entityheadicons::setheadicon_singleimage( self.team, leveldata.headicon, leveldata.headiconoffset, 1, leveldata.headicondrawrange, leveldata.headiconnaturalrange, undefined, 1 );
    }
    
    if ( isdefined( headiconid ) )
    {
        if ( game_utility_mp::ismlgmatch() )
        {
            addteamtoheadiconmask( headiconid, "spectator" );
        }
    }
    
    self.headiconid = headiconid;
    self.headiconactive = 1;
    return headiconid;
}

// Namespace airdrop
// Params 2
// Checksum 0x74c8744a, Offset: 0xbd51
// Size: 0xd9
function function_b8253b38b4a378b1( ownericon, owner )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( isdefined( self.headiconid ) )
    {
        removeclientfromheadiconmask( self.headiconid, owner );
    }
    
    var_faad3f6fb94da1b3 = entityheadicons::setheadicon_killstreak( self, ownericon, undefined, undefined );
    
    foreach ( player in level.players )
    {
        if ( player != owner )
        {
            removeclientfromheadiconmask( var_faad3f6fb94da1b3, player );
        }
    }
    
    self.var_faad3f6fb94da1b3 = var_faad3f6fb94da1b3;
}

// Namespace airdrop
// Params 0
// Checksum 0xdc9dbaa, Offset: 0xbe32
// Size: 0x4e
function _destroyheadicon()
{
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    
    if ( isdefined( self.var_faad3f6fb94da1b3 ) )
    {
        entityheadicons::setheadicon_deleteicon( self.var_faad3f6fb94da1b3 );
        self.var_faad3f6fb94da1b3 = undefined;
    }
    
    self.headiconactive = 0;
    waitframe();
}

// Namespace airdrop
// Params 0
// Checksum 0xa6ac5585, Offset: 0xbe88
// Size: 0x6a
function function_1787568701349ce2()
{
    if ( isdefined( self.scriptedobjid ) )
    {
        objective_delete( self.scriptedobjid );
        objidpoolmanager::returnobjectiveid( self.scriptedobjid );
        self.scriptedobjid = undefined;
        return;
    }
    
    if ( self isscriptable() && self getscriptablehaspart( "objective" ) )
    {
        self setscriptablepartstate( "objective", "inactive" );
        self.objectivevisible = undefined;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x99d7dd9e, Offset: 0xbefa
// Size: 0x183
function createminimapicon()
{
    destroyminimapicon();
    leveldata = getleveldata( self.cratetype );
    minimapicon = self.minimapicon;
    streakname = leveldata.streakname ?? "airdrop";
    minimapid = undefined;
    
    if ( isdefined( minimapicon ) && !self.visibilitymanuallycontrolled )
    {
        if ( level.teambased && isdefined( self.team ) )
        {
            bundle = level.streakglobals.streakbundles[ streakname ];
            
            if ( bundle.var_7f46c26d4083b9fe )
            {
                minimapid = objidpoolmanager::createobjective( minimapicon, self.team, 0, 1 );
                
                if ( bundle.var_1f8f8d871a9f9205 )
                {
                    function_e2a7e8b2b7c92531( minimapid, bundle.var_1f8f8d871a9f9205 );
                }
            }
            else
            {
                minimapid = objidpoolmanager::createobjective( minimapicon, self.team, 1, 1 );
            }
            
            function_771fb62e0d43ad8( minimapid, bundle.name );
        }
        else if ( isdefined( self.owner ) )
        {
            minimapid = objidpoolmanager::createobjective( minimapicon, undefined, 1, 1 );
        }
        else
        {
            minimapid = objidpoolmanager::createobjective( minimapicon, undefined, 0, 1 );
        }
    }
    
    objidpoolmanager::update_objective_objectiveid( minimapid, 24 );
    objidpoolmanager::function_e4d6a71507372662( minimapid, 0 );
    function_461834c350793158( minimapid, 1 );
    self.minimapid = minimapid;
    self.minimapiconactive = 1;
    return minimapid;
}

// Namespace airdrop
// Params 0
// Checksum 0xd122b8b6, Offset: 0xc086
// Size: 0x45
function destroyminimapicon()
{
    if ( isdefined( self.minimapid ) )
    {
        utility::callsharedfunc( #"game", #"returnobjectiveid", self.minimapid );
    }
    
    self.minimapid = undefined;
    self.minimapiconactive = 0;
}

// Namespace airdrop
// Params 3
// Checksum 0xf4448568, Offset: 0xc0d3
// Size: 0x7e
function looselinkto( parent, offset, instancedata )
{
    self endon( #"death" );
    parent endon( #"death" );
    self notify( #"hash_606ee9824ef1c7b4" );
    self endon( #"hash_d01f4aa931d1de29" );
    
    while ( self.physicsactivated )
    {
        self.origin = parent.origin + offset;
        waitframe();
    }
    
    self linkto( parent );
}

// Namespace airdrop
// Params 0
// Checksum 0x9cbd9fb5, Offset: 0xc159
// Size: 0x34
function addtolists()
{
    assert( isdefined( level.cratedata ), "<dev string:x69c>" );
    level.cratedata.crates[ self getentitynumber() ] = self;
}

// Namespace airdrop
// Params 1
// Checksum 0xf5e33c25, Offset: 0xc195
// Size: 0x31
function removefromlists( id )
{
    if ( !isdefined( level.cratedata ) )
    {
        return;
    }
    
    level.cratedata.crates[ id ] = undefined;
}

// Namespace airdrop
// Params 2
// Checksum 0xa084a892, Offset: 0xc1ce
// Size: 0x251
function getrandomkeyfromweightsarray( arr, exclusionlist )
{
    if ( isdefined( exclusionlist ) )
    {
        if ( !isarray( exclusionlist ) )
        {
            exclusionlist = [ exclusionlist ];
        }
    }
    
    exclusionoverrides = strtok( getdvar( @"hash_6c87e00bb60f9903", "" ), " " );
    
    foreach ( exclusion in exclusionoverrides )
    {
        if ( !isdefined( exclusionlist ) )
        {
            exclusionlist = [];
        }
        
        exclusionlist[ exclusionlist.size ] = exclusion;
    }
    
    arrkeys = [];
    var_3e0c8c6bf8c2fcbb = [];
    maxval = 0;
    
    foreach ( key, weight in arr )
    {
        if ( weight > 0 )
        {
            isexcluded = 0;
            
            if ( isdefined( exclusionlist ) )
            {
                if ( exclusionlist.size > 0 )
                {
                    foreach ( id, excludedkey in exclusionlist )
                    {
                        if ( excludedkey == key )
                        {
                            exclusionlist[ id ] = undefined;
                            isexcluded = 1;
                            break;
                        }
                    }
                }
                else
                {
                    exclusionlist = undefined;
                }
            }
            
            if ( !isexcluded )
            {
                maxval += weight;
                arrkeys[ arrkeys.size ] = key;
                var_3e0c8c6bf8c2fcbb[ var_3e0c8c6bf8c2fcbb.size ] = maxval;
            }
        }
    }
    
    randint = randomint( maxval );
    key = undefined;
    
    for ( i = 0; i < arrkeys.size ; i++ )
    {
        maxval = var_3e0c8c6bf8c2fcbb[ i ];
        
        if ( randint < maxval )
        {
            key = arrkeys[ i ];
            break;
        }
    }
    
    return key;
}

// Namespace airdrop
// Params 0
// Checksum 0x4c73684b, Offset: 0xc428
// Size: 0x7
function getdefaultcapturevisualscallback()
{
    return &defaultcapturevisualscallback;
}

// Namespace airdrop
// Params 0
// Checksum 0x4e74315c, Offset: 0xc438
// Size: 0x86
function getdefaultcapturevisualsdeletiondelay()
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    animid = bundle.var_c42a4ad215d8f1b5.animname.id;
    
    if ( !isdefined( animid ) )
    {
        return ( bundle.var_a1dd0a92d042281d ?? ( level.frameduration ?? 48 ) * 10 * 0.001 );
    }
    
    return getanimlength( animid ) + 1;
}

// Namespace airdrop
// Params 1
// Checksum 0x2e5cbc46, Offset: 0xc4c7
// Size: 0x1ab
function defaultcapturevisualscallback( model )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.isdummyarmcrate )
    {
        return;
    }
    
    if ( !isdefined( model ) )
    {
        return;
    }
    
    self endon( #"death" );
    bundle = level.streakglobals.streakbundles[ self.streakinfo.streakname ?? "airdrop" ];
    leveldata = getleveldata( self.cratetype );
    
    if ( !bundle.var_9fec9dc3a6901e62 && !leveldata.var_1f9d95948c1756fc )
    {
        animtime = getanimlength( level.scr_anim[ "care_package" ][ "care_package_capture" ] );
        
        if ( isdefined( animtime ) )
        {
            animtime = max( 0, animtime );
        }
        
        model.animname = "care_package";
        model animation::setanimtree();
        model thread animation::anim_single_solo( model, "care_package_capture" );
    }
    
    model setscriptablepartstate( #"capture", #"start", 0 );
    
    if ( bundle.var_e386a86db6e35dd3 )
    {
        model destroymountmantlemodel();
    }
    
    waitframe();
    capturestate = #"fade";
    var_510635e18adc9e6 = #"land_fade";
    
    if ( self.inwater )
    {
        capturestate = #"fade_water";
        var_510635e18adc9e6 = #"water_fade";
    }
    
    model setscriptablepartstate( #"capture", capturestate, 0 );
    model setscriptablepartstate( #"capture_effect", var_510635e18adc9e6, 0 );
    
    if ( isdefined( animtime ) )
    {
        wait animtime;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x5a9be5ed, Offset: 0xc67a
// Size: 0x3, Type: bool
function getdefaultdestroyvisualsdeletiondelay()
{
    return false;
}

// Namespace airdrop
// Params 0
// Checksum 0x4c73684b, Offset: 0xc686
// Size: 0x7
function getdefaultdestroyvisualscallback()
{
    return &defaultdestroyvisualscallback;
}

// Namespace airdrop
// Params 1
// Checksum 0x2e8029e9, Offset: 0xc696
// Size: 0xc
function defaultdestroyvisualscallback( model )
{
    
}

// Namespace airdrop
// Params 0
// Checksum 0xe1710734, Offset: 0xc6aa
// Size: 0x15
function getdefaultmountmantlemodel()
{
    return level.cratedata.mountmantlemodel;
}

// Namespace airdrop
// Params 0
// Checksum 0x4004014f, Offset: 0xc6c8
// Size: 0x26
function getnumdroppedcrates()
{
    if ( !isdefined( level.cratedata ) )
    {
        return 0;
    }
    
    return level.cratedata.crates.size;
}

// Namespace airdrop
// Params 0
// Checksum 0x5343801f, Offset: 0xc6f7
// Size: 0x42
function function_2346ed193aa61aa4()
{
    if ( utility::issharedfuncdefined( #"damage", #"_suicide" ) )
    {
        self thread [[ utility::getsharedfunc( #"damage", #"_suicide" ) ]]();
        return;
    }
    
    self suicide();
}

// Namespace airdrop
// Params 1
// Checksum 0x8c34259a, Offset: 0xc741
// Size: 0x96
function function_6eecc517e4bdf52b( params )
{
    if ( !isdefined( level.cratedata.crates ) )
    {
        return;
    }
    
    if ( level.cratedata.crates.size == 0 )
    {
        return;
    }
    
    entmantling = self getmovingplatformparent();
    
    if ( isdefined( entmantling.crate ) )
    {
        self.entmantling = entmantling;
        self.entmantlingcrate = entmantling.crate;
    }
    
    self.entmantlingendtime = gettime() + 1000;
    thread function_f5e41cf9693f5f9();
}

// Namespace airdrop
// Params 0
// Checksum 0x559b47ef, Offset: 0xc7df
// Size: 0x60
function function_366f11c5ee0f1d67()
{
    self.entmantling = undefined;
    self.entmantlingcrate = undefined;
    self.entmantlingendtime = undefined;
    
    if ( utility::issharedfuncdefined( #"damage", #"_suicide" ) )
    {
        self thread [[ utility::getsharedfunc( #"damage", #"_suicide" ) ]]();
        return;
    }
    
    self suicide();
}

// Namespace airdrop
// Params 0
// Checksum 0x7bc760c1, Offset: 0xc847
// Size: 0x1b8
function function_f5e41cf9693f5f9()
{
    self notify( #"hash_66b392521db05f06" );
    self endon( #"hash_66b392521db05f06" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( gettime() >= self.entmantlingendtime )
        {
            self.entmantling = undefined;
            self.entmantlingcrate = undefined;
            self.entmantlingendtime = undefined;
            return;
        }
        
        foreach ( crate in level.cratedata.crates )
        {
            if ( isdefined( crate ) && crate.physicsactivated && !crate.physicssettled )
            {
                if ( isdefined( self.entmantling ) )
                {
                    if ( isdefined( crate.mountmantlemodel ) )
                    {
                        if ( self.entmantling != crate.mountmantlemodel )
                        {
                            if ( self istouching( crate.mountmantlemodel ) )
                            {
                                function_366f11c5ee0f1d67();
                                return;
                            }
                        }
                    }
                    
                    if ( self.entmantlingcrate != crate )
                    {
                        if ( self istouching( crate ) )
                        {
                            function_366f11c5ee0f1d67();
                            return;
                        }
                    }
                    
                    continue;
                }
                
                if ( getdvarint( @"hash_efc091c1cec199a5", 0 ) )
                {
                    if ( self istouching( crate ) || isdefined( crate.mountmantlemodel ) && self istouching( crate.mountmantlemodel ) )
                    {
                        function_366f11c5ee0f1d67();
                        return;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x55103725, Offset: 0xca07
// Size: 0x230
function function_5f1f0812c8683273()
{
    entmask = createentitytypemask( [ "etype_player" ] );
    radius = getdvarint( @"hash_e9b16488fdec1843", 100 );
    
    while ( true )
    {
        foreach ( crate in level.cratedata.crates )
        {
            if ( !isdefined( crate ) || !crate.physicsactivated || crate.physicssettled )
            {
                continue;
            }
            
            nearplayers = getentitiesinradiusfrompartitiongrid( crate.origin, radius, entmask );
            
            foreach ( p in nearplayers )
            {
                if ( p ismantling() )
                {
                    entmantling = p getmovingplatformparent();
                    
                    if ( isdefined( entmantling ) && isdefined( entmantling.crate ) )
                    {
                        if ( isdefined( crate.mountmantlemodel ) )
                        {
                            if ( entmantling != crate.mountmantlemodel && p istouching( crate.mountmantlemodel ) )
                            {
                                p function_2346ed193aa61aa4();
                            }
                        }
                        else if ( entmantling.crate != crate )
                        {
                            if ( p istouching( crate ) )
                            {
                                p function_2346ed193aa61aa4();
                            }
                        }
                        
                        continue;
                    }
                    
                    if ( p istouching( crate ) || isdefined( crate.mountmantlemodel ) && p istouching( crate.mountmantlemodel ) )
                    {
                        p function_2346ed193aa61aa4();
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x19e7defc, Offset: 0xcc3f
// Size: 0xf1
function overridecapturestring( stringoverride )
{
    assert( isdefined( stringoverride ), "<dev string:x6c8>" );
    
    if ( self.capturestring == stringoverride )
    {
        return;
    }
    
    self.capturestring = stringoverride;
    triggerobjects = [ self ];
    
    foreach ( triggerobject in triggerobjects )
    {
        if ( !self.supportsreroll || triggerobject.usetype == 2 || triggerobject.usetype == 3 )
        {
            triggerobject sethintstring( self.capturestring );
        }
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xe26355d, Offset: 0xcd38
// Size: 0xf0
function overridererollstring( stringoverride )
{
    assert( isdefined( stringoverride ), "<dev string:x700>" );
    
    if ( self.rerollstring == stringoverride )
    {
        return;
    }
    
    self.rerollstring = stringoverride;
    triggerobjects = [ self ];
    
    foreach ( triggerobject in triggerobjects )
    {
        if ( self.supportsreroll && ( triggerobject.usetype == 1 || triggerobject.usetype == 3 ) )
        {
            triggerobject sethintstring( self.rerollstring );
        }
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xcd904060, Offset: 0xce30
// Size: 0x8c
function overrideheadicon( iconoverride )
{
    if ( !isdefined( self.headicon ) && !isdefined( iconoverride ) )
    {
        return;
    }
    
    if ( self.headicon == iconoverride )
    {
        return;
    }
    
    if ( !isdefined( iconoverride ) )
    {
        self.headicon = undefined;
        _destroyheadicon();
        return;
    }
    
    self.headicon = iconoverride;
    
    if ( self.headiconactive )
    {
        if ( isdefined( self.headiconid ) )
        {
            setheadiconimage( self.headiconid, iconoverride );
            return;
        }
        
        _createheadicon();
    }
}

// Namespace airdrop
// Params 2
// Checksum 0xeed7d9ff, Offset: 0xcec4
// Size: 0xab
function function_f38e1899f2e7828e( iconoverride, owner )
{
    if ( !isdefined( self.ownerheadicon ) && !isdefined( iconoverride ) )
    {
        return;
    }
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( !isdefined( iconoverride ) )
    {
        entityheadicons::setheadicon_deleteicon( self.var_faad3f6fb94da1b3 );
        self.var_faad3f6fb94da1b3 = undefined;
        
        if ( isdefined( self.headiconid ) )
        {
            addclienttoheadiconmask( self.headiconid, owner );
        }
        
        return;
    }
    
    if ( self.headiconactive )
    {
        if ( isdefined( self.var_faad3f6fb94da1b3 ) )
        {
            setheadiconimage( self.var_faad3f6fb94da1b3, iconoverride );
            return;
        }
        
        function_b8253b38b4a378b1( iconoverride, owner );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xac17c75c, Offset: 0xcf77
// Size: 0x8e
function overrideminimapicon( iconoverride )
{
    if ( !isdefined( self.minimapicon ) && !isdefined( iconoverride ) )
    {
        return;
    }
    
    if ( self.minimapicon == iconoverride )
    {
        return;
    }
    
    if ( !isdefined( iconoverride ) )
    {
        self.minimapicon = undefined;
        destroyminimapicon();
        return;
    }
    
    self.minimapicon = iconoverride;
    
    if ( self.minimapiconactive )
    {
        if ( isdefined( self.minimapid ) )
        {
            objidpoolmanager::update_objective_icon( self.minimapid, iconoverride );
            return;
        }
        
        createminimapicon();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x9b640299, Offset: 0xd00d
// Size: 0x467
function initkillstreakcratedata()
{
    level.cratedata.ksweights = [];
    level.cratedata.kscapturestrings = [];
    level.cratedata.ksrerollstrings = [];
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    activatecallback = &killstreakcrateactivatecallback;
    capturecallback = &killstreakcratecapturecallback;
    leveldata = getleveldata( "killstreak" );
    leveldata.activatecallback = activatecallback;
    leveldata.capturecallback = capturecallback;
    leveldata.var_1f9d95948c1756fc = bundle.var_9fec9dc3a6901e62 ?? 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.var_22cefb9f8c5c26d2 = 1;
    leveldata = getleveldata( "killstreak_no_owner" );
    leveldata.activatecallback = activatecallback;
    leveldata.capturecallback = capturecallback;
    leveldata.supportsownercapture = 0;
    leveldata.var_1f9d95948c1756fc = bundle.var_9fec9dc3a6901e62 ?? 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.basemodel = bundle.var_520def0bab23e6bc;
    leveldata.var_22cefb9f8c5c26d2 = 1;
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    
    if ( isdefined( level.var_57f09ef6d4980bdb ) )
    {
        [[ level.var_57f09ef6d4980bdb ]]();
        return;
    }
    
    if ( bundle.airdrop_roulette )
    {
        foreach ( reward in bundle.var_e613415f5d6d43ba[ 0 ].tier_rewards )
        {
            addkillstreakcratedata( reward.reward_ref, undefined, undefined, 1 );
        }
        
        return;
    }
    
    if ( !isdefined( bundle ) || !bundle.var_54e010ee8345d9a0 )
    {
        addkillstreakcratedata( "assault_drone", undefined, undefined, 300 );
        addkillstreakcratedata( "uav", undefined, undefined, 300 );
        addkillstreakcratedata( "cluster_spike", undefined, undefined, 300 );
        addkillstreakcratedata( "scrambler_drone_guard", undefined, undefined, 300 );
        addkillstreakcratedata( "switchblade_drone", undefined, undefined, 300 );
        addkillstreakcratedata( "cruise_predator", undefined, undefined, 150 );
        addkillstreakcratedata( "toma_strike", undefined, undefined, 150 );
        addkillstreakcratedata( "precision_airstrike", undefined, undefined, 150 );
        addkillstreakcratedata( "remote_turret", undefined, undefined, 150 );
        addkillstreakcratedata( "lrad", undefined, undefined, 150 );
        addkillstreakcratedata( "fuel_airstrike", undefined, undefined, 100 );
        addkillstreakcratedata( "hover_jet", undefined, undefined, 100 );
        addkillstreakcratedata( "airdrop_escort", undefined, undefined, 100 );
        addkillstreakcratedata( "pac_sentry", undefined, undefined, 100 );
        addkillstreakcratedata( "juggernaut_recon", undefined, undefined, 100 );
        addkillstreakcratedata( "auto_drone", undefined, undefined, 50 );
        addkillstreakcratedata( "chopper_gunner", undefined, undefined, 50 );
        addkillstreakcratedata( "directional_uav", undefined, undefined, 25 );
        addkillstreakcratedata( "gunship", undefined, undefined, 25 );
        addkillstreakcratedata( "juggernaut", undefined, undefined, 10 );
        return;
    }
    
    if ( isdefined( bundle.crateentries ) )
    {
        foreach ( crateentry in bundle.crateentries )
        {
            if ( isdefined( crateentry.name ) && isdefined( crateentry.weight ) )
            {
                addkillstreakcratedata( crateentry.name, undefined, undefined, crateentry.weight );
            }
        }
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xa955389d, Offset: 0xd47c
// Size: 0x364
function initdropzonekillstreakcratedata()
{
    level.cratedata.ksweights = [];
    level.cratedata.kscapturestrings = [];
    level.cratedata.ksrerollstrings = [];
    activatecallback = &killstreakcrateactivatecallback;
    capturecallback = &killstreakcratecapturecallback;
    leveldata = getleveldata( "killstreak" );
    leveldata.activatecallback = activatecallback;
    leveldata.capturecallback = capturecallback;
    leveldata = getleveldata( "killstreak_no_owner" );
    leveldata.activatecallback = activatecallback;
    leveldata.capturecallback = capturecallback;
    leveldata.supportsownercapture = 0;
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    leveldata.basemodel = bundle.var_520def0bab23e6bc;
    
    if ( isdefined( level.var_57f09ef6d4980bdb ) )
    {
        [[ level.var_57f09ef6d4980bdb ]]();
    }
    else if ( !isdefined( bundle ) || !bundle.var_54e010ee8345d9a0 )
    {
        addkillstreakcratedata( "assault_drone", undefined, undefined, 300 );
        addkillstreakcratedata( "uav", undefined, undefined, 300 );
        addkillstreakcratedata( "cluster_spike", undefined, undefined, 300 );
        addkillstreakcratedata( "scrambler_drone_guard", undefined, undefined, 300 );
        addkillstreakcratedata( "switchblade_drone", undefined, undefined, 300 );
        addkillstreakcratedata( "cruise_predator", undefined, undefined, 150 );
        addkillstreakcratedata( "toma_strike", undefined, undefined, 150 );
        addkillstreakcratedata( "precision_airstrike", undefined, undefined, 150 );
        addkillstreakcratedata( "remote_turret", undefined, undefined, 150 );
        addkillstreakcratedata( "lrad", undefined, undefined, 150 );
        addkillstreakcratedata( "fuel_airstrike", undefined, undefined, 100 );
        addkillstreakcratedata( "hover_jet", undefined, undefined, 100 );
        addkillstreakcratedata( "airdrop_escort", undefined, undefined, 100 );
        addkillstreakcratedata( "pac_sentry", undefined, undefined, 100 );
        addkillstreakcratedata( "juggernaut_recon", undefined, undefined, 100 );
        addkillstreakcratedata( "auto_drone", undefined, undefined, 50 );
        addkillstreakcratedata( "chopper_gunner", undefined, undefined, 50 );
        addkillstreakcratedata( "directional_uav", undefined, undefined, 25 );
        addkillstreakcratedata( "gunship", undefined, undefined, 25 );
        addkillstreakcratedata( "juggernaut", undefined, undefined, 10 );
    }
    else if ( isdefined( bundle.crateentries ) )
    {
        foreach ( crateentry in bundle.crateentries )
        {
            if ( isdefined( crateentry.name ) && isdefined( crateentry.weight ) )
            {
                addkillstreakcratedata( crateentry.name, undefined, undefined, crateentry.weight );
            }
        }
    }
    
    if ( game_utility::isinfectedgametype() )
    {
        leveldata.isteamonlycrate = 1;
        return;
    }
    
    addkillstreakcratedata( "scrambler_drone_guard", undefined, undefined, 300 );
}

// Namespace airdrop
// Params 4
// Checksum 0x26189a04, Offset: 0xd7e8
// Size: 0x8b
function addkillstreakcratedata( streakname, capturestring, rerollstring, weight )
{
    if ( !isdefined( level.streakglobals.streakbundles[ streakname ] ) )
    {
        return;
    }
    
    level.cratedata.kscapturestrings[ streakname ] = capturestring;
    level.cratedata.ksrerollstrings[ streakname ] = rerollstring;
    level.cratedata.ksweights[ streakname ] = weight;
}

// Namespace airdrop
// Params 2
// Checksum 0x34edf8bf, Offset: 0xd87b
// Size: 0x43
function getkillstreakcratedatabystreakname( streakname, supportsreroll )
{
    data = spawnstruct();
    data.streakname = streakname;
    data.supportsreroll = supportsreroll;
    return data;
}

// Namespace airdrop
// Params 2
// Checksum 0x557c292a, Offset: 0xd8c7
// Size: 0x86
function overridekillstreakcrateweight( streakname, weightoverride )
{
    assert( isdefined( level.cratedata ), "<dev string:x737>" );
    assert( isdefined( level.cratedata.ksweights ), "<dev string:x776>" );
    assert( isdefined( level.cratedata.ksweights ), "<dev string:x7bf>" );
    level.cratedata.ksweights[ streakname ] = weightoverride;
}

// Namespace airdrop
// Params 1
// Checksum 0x121eb491, Offset: 0xd955
// Size: 0xda
function killstreakcrateactivatecallback( isfirstactivation )
{
    data = self.data;
    capturestring = level.cratedata.kscapturestrings[ data.streakname ];
    
    if ( common_item::items_isenabled() && level.var_b3201a857e731284 == 2 )
    {
        self makeusable();
        self.capturestring = &"killstreaks_hints/crate_loot";
        self sethintstring( self.capturestring );
        self makeunusable();
    }
    else if ( isdefined( capturestring ) )
    {
        overridecapturestring( capturestring );
    }
    
    rerollstring = level.cratedata.ksrerollstrings[ data.streakname ];
    
    if ( isdefined( rerollstring ) )
    {
        overridererollstring( rerollstring );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x6e2c22b9, Offset: 0xda37
// Size: 0x6f9
function killstreakcratecapturecallback( player )
{
    streakname = self.data.streakname;
    self.var_97303da1d93bf55c = undefined;
    useimmediate = 0;
    var_caff9af74141de98 = 0;
    
    switch ( streakname )
    {
        case #"hash_cd0a0403551fc411":
            var_caff9af74141de98 = 1;
        case #"hash_4ad475e6e15635bd":
            if ( !player.isjuggernaut )
            {
                useimmediate = 1;
                
                if ( utility::issharedfuncdefined( #"airdrop", #"applyimmediatejuggernaut" ) )
                {
                    player [[ utility::getsharedfunc( #"airdrop", #"applyimmediatejuggernaut" ) ]]( useimmediate, var_caff9af74141de98 );
                }
                else if ( var_caff9af74141de98 )
                {
                    tryusefunc = level.sharedfuncs[ #"killstreak_juggernaut_recon" ][ #"hash_de6e33eee211848" ];
                    
                    if ( isdefined( tryusefunc ) )
                    {
                        player [[ tryusefunc ]]( useimmediate );
                    }
                }
                else
                {
                    player juggernaut::tryusejuggernaut( useimmediate );
                }
                
                player thread challenges::usedkillstreak( streakname, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
            }
            
            break;
        case #"hash_de9cf1c4a4d2521d":
            if ( !isdefined( player.var_3743638e74262366 ) )
            {
                useimmediate = 1;
                
                if ( utility::issharedfuncdefined( #"airdrop", #"hash_a69ebda852324758" ) )
                {
                    player [[ utility::getsharedfunc( #"airdrop", #"hash_a69ebda852324758" ) ]]( player );
                }
                else
                {
                    useimmediate = 0;
                }
            }
            
            break;
    }
    
    if ( !useimmediate )
    {
        var_fef370645e63bc2a = common_item::items_isenabled();
        
        if ( var_fef370645e63bc2a && level.var_b3201a857e731284 > 0 && level.var_b3201a857e731284 <= 2 )
        {
            if ( level.var_b3201a857e731284 == 1 )
            {
                itembundle = getscriptbundle( level.commonitem.var_4d60369c227dcd1e[ streakname ] );
                
                if ( namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( itembundle.scriptable ) )
                {
                    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
                    item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
                    common_item::items_scriptable_used( item, undefined, undefined, player, 0 );
                }
            }
            else if ( level.var_b3201a857e731284 == 2 )
            {
                var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_killstreak_carepackage" );
                
                if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
                {
                    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
                    
                    if ( !isdefined( spawnoptions.ignoreents ) )
                    {
                        spawnoptions.ignoreents = [];
                    }
                    
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self;
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self.data.crateclip;
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self.var_573cb169eb46c54d;
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self.var_36e300d147bf6f25;
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self.var_88accb953478a622;
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self.var_b410f5d243619d25;
                    spawnoptions.ignoreents[ spawnoptions.ignoreents.size ] = self.mountmantlemodel;
                    spawnoptions.ignoreents = function_5713d46873b29625( spawnoptions.ignoreents );
                    spawnoptions.ignoreents = arrayremoveduplicates( spawnoptions.ignoreents );
                    common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
                }
            }
        }
        else
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"awardkillstreak" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                player thread [[ var_32dbca3143d9c4a5 ]]( streakname, player, self );
            }
        }
        
        if ( !var_fef370645e63bc2a || level.var_b3201a857e731284 != 2 )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"showkillstreaksplash" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                player [[ var_32dbca3143d9c4a5 ]]( streakname, undefined, 1 );
            }
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"giveplayerpointsoncratecapture" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            player [[ var_32dbca3143d9c4a5 ]]( self );
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"hash_737e51bff1a56876" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            player [[ var_32dbca3143d9c4a5 ]]();
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"airdrop" ][ #"hash_59b4e0bb0811b551" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]();
        }
    }
    
    if ( player != self.owner && player.team != self.team && !level.var_6c7da61a12ef9d1b )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "stolenCarePackages" ] ) )
            {
                player.leaderboarddata[ "stolenCarePackages" ] = player.leaderboarddata[ "stolenCarePackages" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "stolenCarePackages" ] ) )
            {
                [[ level.leaderboardfunc[ "stolenCarePackages" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x802>" );
            
            if ( isdefined( player.pers[ "stolenCarePackages" ] ) )
            {
                player.pers[ "stolenCarePackages" ] = player.pers[ "stolenCarePackages" ] + 1;
            }
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"doScoreEvent" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            player [[ var_32dbca3143d9c4a5 ]]( #"hijacker" );
        }
        
        if ( isdefined( self.owner ) )
        {
            var_7c3122ec71b02fdb = !self.boobytrapped && player.var_44d0b4d50106847e;
            
            if ( !var_7c3122ec71b02fdb )
            {
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"showsplash" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    self.owner [[ var_32dbca3143d9c4a5 ]]( #"hijacked_airdrop", undefined, player );
                }
            }
            
            if ( self.owner != player )
            {
                streakinfo = player killstreaks::getkillstreakinslot( player.var_97303da1d93bf55c );
                
                if ( streakinfo )
                {
                    streakinfo.var_36d265ac42039b40 = self.owner;
                }
            }
        }
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xe4e50c6a, Offset: 0xe138
// Size: 0x109
function getrandomkillstreak( var_e0a275ac51a62494 )
{
    assert( isdefined( level.cratedata ), "<dev string:x828>" );
    assert( isdefined( level.cratedata.ksweights ), "<dev string:x85d>" );
    
    if ( level.var_8f92f9719855e8f1 )
    {
        var_6ecc85d31894f2bb = [[ level.var_8f92f9719855e8f1 ]]();
        
        if ( var_6ecc85d31894f2bb )
        {
            foreach ( var_185c7265d4282cba in var_6ecc85d31894f2bb )
            {
                if ( !isdefined( var_e0a275ac51a62494 ) )
                {
                    var_e0a275ac51a62494 = [];
                }
                
                var_e0a275ac51a62494[ var_e0a275ac51a62494.size ] = var_185c7265d4282cba;
            }
        }
    }
    
    streakname = getrandomkeyfromweightsarray( level.cratedata.ksweights, var_e0a275ac51a62494 );
    return streakname;
}

// Namespace airdrop
// Params 5
// Checksum 0xa9b9d504, Offset: 0xe24a
// Size: 0xe3
function placekillstreakcrate( owner, team, streakname, position, angles )
{
    if ( !isdefined( streakname ) || streakname == "random" )
    {
        streakname = getrandomkillstreak();
    }
    
    cratetype = isdefined( owner ) ? "killstreak" : "killstreak_no_owner";
    cratedropdata = getkillstreakcratedatabystreakname( streakname, 0 );
    crate = placecrate( owner, team, cratetype, position, angles, cratedropdata );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_airdrop", owner );
        }
    }
    
    return crate;
}

// Namespace airdrop
// Params 8
// Checksum 0x59d95f40, Offset: 0xe336
// Size: 0x104
function dropkillstreakcrate( owner, team, streakname, position, angles, destination, skipminimapicon, var_8e0edd0d66fd1238 )
{
    if ( !isdefined( streakname ) || streakname == "random" )
    {
        streakname = getrandomkillstreak();
    }
    
    cratetype = isdefined( owner ) ? "killstreak" : "killstreak_no_owner";
    cratedropdata = getkillstreakcratedatabystreakname( streakname, 0 );
    crate = dropcrate( owner, team, cratetype, position, angles, destination, cratedropdata, skipminimapicon, undefined, var_8e0edd0d66fd1238 );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_airdrop", owner );
        }
    }
    
    return crate;
}

// Namespace airdrop
// Params 9
// Checksum 0x10d0a0b6, Offset: 0xe443
// Size: 0x1e9
function dropkillstreakcratefromscriptedheli( owner, team, streakname, position, angles, destination, vehicleisreserved, streakinfo, var_bbb9b031a7db1020 = 0 )
{
    if ( !isdefined( streakname ) || streakname == "random" )
    {
        streakname = getrandomkillstreak();
    }
    
    /#
        thread utility::debugprinttoscreen( "<dev string:x89c>" + streakname, 10, 1900, 1000 );
    #/
    
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "airdrop" ];
    cratetype = undefined;
    
    if ( bundle.var_f9da2681d567d414 )
    {
        cratetype = "care_package_loot_container";
    }
    else
    {
        cratetype = isdefined( owner ) ? "killstreak" : "killstreak_no_owner";
    }
    
    cratedropdata = getkillstreakcratedatabystreakname( streakname, 0 );
    cratedropdata.vehicleisreserved = vehicleisreserved;
    cratedropdata.var_bbb9b031a7db1020 = var_bbb9b031a7db1020;
    var_fbbfc679e46932c2 = function_bd2eb7c465e874f7( position, 1, owner );
    
    if ( var_fbbfc679e46932c2.size > 0 )
    {
        position = var_fbbfc679e46932c2[ 0 ];
        destination = var_fbbfc679e46932c2[ 0 ];
    }
    else
    {
        return;
    }
    
    scenenode = dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, cratedropdata, streakinfo );
    
    if ( !isdefined( scenenode ) )
    {
        return;
    }
    else if ( !( isdefined( scenenode.crates ) && isdefined( utility::array_get_first_item( scenenode.crates ) ) ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_airdrop", owner );
        }
    }
    
    return scenenode;
}

// Namespace airdrop
// Params 6
// Checksum 0xa384b594, Offset: 0xe635
// Size: 0x2bb
function function_5f514aed135bd60f( owner, position, angles, streakinfo, streakname, skipminimapicon )
{
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "airdrop" ];
    startpos = getcratedropcaststart( position, 1, undefined, owner );
    destination = getcratedropdestination( startpos, getcratedropcastend( startpos, 1 ), position );
    
    if ( !isdefined( destination ) )
    {
        return;
    }
    
    dropheight = bundle.var_44f84625210e3fe0 ?? 2000;
    startpos = destination + ( 0, 0, dropheight );
    cratetype = isdefined( owner ) ? "killstreak" : "killstreak_no_owner";
    cratedropdata = getkillstreakcratedatabystreakname( streakname ?? streakinfo.streakname, 0 );
    basemodel = bundle.var_520def0bab23e6bc;
    cliptargetname = bundle.var_80733e7476cf449e;
    
    if ( isdefined( basemodel ) || isdefined( cliptargetname ) )
    {
        assert( isdefined( basemodel ) && isdefined( cliptargetname ), "<dev string:x223>" + ( basemodel ?? "<dev string:x28c>" ) + "<dev string:x296>" + ( cliptargetname ?? "<dev string:x28c>" ) );
        cratedropdata.var_9400fe1a9c9b659d = basemodel;
        cratedropdata.crateclip = getent( cliptargetname, #targetname );
        assert( isdefined( cratedropdata.crateclip ), "<dev string:x2b6>" + cliptargetname );
    }
    
    var_da903b1e8121ea2 = bundle.var_bbfff1671c79a1e;
    crate = dropcrate( owner, owner.team, cratetype, startpos, angles, destination, cratedropdata, skipminimapicon, undefined, streakinfo );
    
    if ( isdefined( crate ) )
    {
        movingplatforminfo = function_6d2c704914d1e4b5( destination );
        
        if ( isdefined( movingplatforminfo ) && isdefined( movingplatforminfo.groundent ) )
        {
            crate thread function_340d642e069cfff3( destination, movingplatforminfo.groundent );
        }
        
        crate.var_da903b1e8121ea2 = var_da903b1e8121ea2;
        crate.var_39123595a72543ea = bundle.var_aff097f95f7da3f7;
        
        if ( bundle.var_ce0d70ea5df84ecb )
        {
            function_4acf81c10675ced9( crate, streakinfo, owner.team );
        }
        else
        {
            function_4df55287e8514eb2( crate, streakinfo );
        }
        
        crate function_1e43ba09f65e2eb6( #"visibility", #"show", 0 );
        return { #crates:[ crate ] };
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x987d321a, Offset: 0xe8f8
// Size: 0x4d
function airdrop_playdeploydialog( streakinfo )
{
    if ( level.gametype == "grnd" || game_utility::isinfectedgametype() )
    {
        return;
    }
    
    utility::callsharedfunc( #"sound", #"playkillstreakdeploydialog", streakinfo.streakname );
}

// Namespace airdrop
// Params 7
// Checksum 0x72d0632f, Offset: 0xe94d
// Size: 0x128
function dropkillstreakcratefrommanualheli( owner, team, streakname, position, angles, destination, vehicleisreserved )
{
    if ( !isdefined( streakname ) || streakname == "random" )
    {
        streakname = getrandomkillstreak();
    }
    
    cratetype = isdefined( owner ) ? "killstreak" : "killstreak_no_owner";
    cratedropdata = getkillstreakcratedatabystreakname( streakname, 0 );
    cratedropdata.vehicleisreserved = vehicleisreserved;
    dropstruct = dropcratefrommanualheli( owner, team, cratetype, position, angles, 30000, 30000, destination, cratedropdata );
    
    if ( !isdefined( dropstruct ) )
    {
        return;
    }
    else if ( !isdefined( dropstruct.crate ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_airdrop", owner );
        }
    }
    
    return dropstruct.crate;
}

// Namespace airdrop
// Params 1
// Checksum 0x689b7c13, Offset: 0xea7e
// Size: 0x1a3, Type: bool
function tryairdroptriggered( streakinfo )
{
    streakname = streakinfo.streakname;
    droptype = streakname;
    
    if ( !isdefined( droptype ) )
    {
        droptype = "airdrop";
    }
    
    var_11013b06ec122e43 = level.littlebirds.size;
    maxvehiclecount = 4;
    
    if ( game_utility::islargemap() )
    {
        maxvehiclecount = 10;
    }
    
    if ( streakname == "airdrop_escort" )
    {
        var_11013b06ec122e43 = level.cratedropdata.escortchoppers.size;
        maxvehiclecount = 1;
    }
    
    var_766d9694d6cd52f7 = 1;
    
    if ( ( var_11013b06ec122e43 >= maxvehiclecount || level.fauxvehiclecount >= maxvehiclecount ) && droptype != "airdrop_mega" )
    {
        utility::callsharedfunc( #"hud", #"showerrormessage", %"killstreaks/max_airdrops" );
        return false;
    }
    else if ( utility::issharedfuncdefined( #"killstreak", #"currentactivevehiclecount" ) && utility::issharedfuncdefined( #"killstreak", #"maxvehiclesallowed" ) )
    {
        if ( [[ utility::getsharedfunc( #"killstreak", #"currentactivevehiclecount" ) ]]() >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() || level.fauxvehiclecount + var_766d9694d6cd52f7 >= [[ utility::getsharedfunc( #"killstreak", #"maxvehiclesallowed" ) ]]() )
        {
            utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/TOO_MANY_VEHICLES" );
            return false;
        }
    }
    
    return true;
}

// Namespace airdrop
// Params 2
// Checksum 0xde373aec, Offset: 0xec2a
// Size: 0x23
function airdropmarkerswitchended( streakinfo, switchresult )
{
    if ( switchresult )
    {
        thread airdrop_watchplayerweapon( streakinfo );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x49ec1a27, Offset: 0xec55
// Size: 0x92
function airdrop_watchplayerweapon( streakinfo )
{
    self endon( #"disconnect" );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
        self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
        self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
        self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    }
    
    result = utility::waittill_any_return( "cancel_deploy", "weapon_switch_started" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace airdrop
// Params 1
// Checksum 0x81c41a65, Offset: 0xecef
// Size: 0xf3, Type: bool
function airdropvisualmarkerfired( streakinfo )
{
    streakinfo.airdroptype = streakinfo.streakname;
    utility::callsharedfunc( #"vehicle", #"incrementfauxvehiclecount" );
    marker = undefined;
    
    if ( utility::issharedfuncdefined( #"airdrop", #"gettargetmarker" ) )
    {
        marker = self [[ utility::getsharedfunc( #"airdrop", #"gettargetmarker" ) ]]( streakinfo );
    }
    
    if ( !isdefined( marker.location ) )
    {
        utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
        return false;
    }
    
    utility::callsharedfunc( #"killstreak", #"logkillstreakevent", streakinfo.airdroptype, self.origin );
    airdropvisualmarkeractivate( marker, streakinfo.airdroptype, streakinfo );
    return true;
}

// Namespace airdrop
// Params 3
// Checksum 0xa7140bb8, Offset: 0xedeb
// Size: 0xff
function airdropvisualmarkeractivate( marker, droptype, streakinfo )
{
    fxposition = utility::drop_to_ground( marker.location, 50, -200, ( 0, 0, 1 ) );
    fxposition += ( 0, 0, 1 );
    canister = spawn( "script_model", fxposition );
    canister setmodel( "offhand_wm_grenade_smoke" );
    canister.angles = ( 0, 90, 90 );
    fxent = spawn( "script_model", fxposition );
    fxent setmodel( "ks_crate_marker_mp" );
    fxent setscriptablepartstate( #"smoke", #"on", 0 );
    
    if ( isdefined( marker.visual ) )
    {
        marker.visual delete();
    }
    
    assertmsg( "<dev string:x8b0>" );
}

// Namespace airdrop
// Params 0
// Checksum 0x65018005, Offset: 0xeef2
// Size: 0x22
function tryuseairdropmarker()
{
    streakinfo = killstreak_utility::createstreakinfo( "airdrop", self );
    return tryuseairdropmarkerfromstruct( streakinfo );
}

// Namespace airdrop
// Params 1
// Checksum 0xc0bc7352, Offset: 0xef1d
// Size: 0x291, Type: bool
function tryuseairdropmarkerfromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    bundle = killstreak_utility::function_f943c0602acdc2af( streakinfo.streakname );
    deploymentweapon = "deploy_airdrop_mp";
    
    if ( isdefined( bundle.deployweaponname ) )
    {
        deploymentweapon = bundle.deployweaponname;
    }
    
    streakinfo.deployweaponobj = makeweapon( deploymentweapon );
    sticky = getdvarint( @"scr_airdrop_sticky", 0 );
    
    if ( sticky )
    {
        streakinfo.deployweaponobj = makeweapon( "deploy_airdrop_sticky_mp" );
    }
    
    var_cebc7028dd797105 = undefined;
    
    switch ( streakinfo.streakname )
    {
        case #"hash_2289ec11d77bce8f":
        case #"hash_56979e0566996b2e":
        case #"hash_887ad77192b9c4fb":
        case #"hash_b0491209df7b4b5c":
            var_cebc7028dd797105 = 1;
            break;
        default:
            var_cebc7028dd797105 = 0;
            break;
    }
    
    if ( var_cebc7028dd797105 )
    {
        if ( !vehicle_tracking::reserve_vehicle() )
        {
            utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
            return false;
        }
    }
    
    if ( !tryairdroptriggered( streakinfo ) )
    {
        if ( var_cebc7028dd797105 )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
        }
        
        return false;
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            if ( var_cebc7028dd797105 )
            {
                vehicle_tracking::function_4f76f5b4541acef1();
            }
            
            utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
            return false;
        }
    }
    
    if ( isdefined( level.var_d6dbcfd3322e6005 ) )
    {
        streakinfo.var_21f1b0b4d8d3ea8f = level.var_d6dbcfd3322e6005;
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, streakinfo.deployweaponobj, "grenade_fire", undefined, &airdropmarkerswitchended, &airdropmarkerfired, undefined, &airdropmarkertaken );
    
    if ( !deployresult )
    {
        if ( var_cebc7028dd797105 )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
        }
        
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( level.in_play_limits_in_use )
    {
        bundle = level.streakglobals.streakbundles[ streakinfo.streakname ];
        
        if ( bundle.inplaylimits[ 0 ].name )
        {
            streakinfo.var_dba2ed457f8ace3e = 1;
        }
    }
    
    return true;
}

// Namespace airdrop
// Params 1
// Checksum 0xcaef4b55, Offset: 0xf1b7
// Size: 0xa3
function function_fef0f76d28a245b5( streakinfo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3ab39a4e976b0270" );
    level endon( #"game_ended" );
    deployweaponobj = streakinfo.deployweaponobj;
    
    while ( true )
    {
        self waittill( #"grenade_thrown", grenade );
        
        if ( deployweaponobj.basename == grenade.weapon_name )
        {
            airdropmarkerfired( streakinfo, deployweaponobj, grenade, 1 );
            break;
        }
        
        /#
            iprintln( "<dev string:x8f4>" );
        #/
        
        break;
    }
}

// Namespace airdrop
// Params 4
// Checksum 0xa81358e8, Offset: 0xf262
// Size: 0xff
function airdropmarkerfired( streakinfo, weaponobj, projectile, gestureactivation )
{
    streakinfo.airdroptype = streakinfo.streakname;
    utility::callsharedfunc( #"killstreak", #"incrementfauxvehiclecount" );
    projectile.owner = self;
    projectile.streakinfo = streakinfo;
    assert( isdefined( streakinfo.airdroptype ), "<dev string:x920>" );
    projectile thread airdropmarkeractivate( streakinfo.airdroptype, undefined, streakinfo, gestureactivation );
    thread airdrop_playdeploydialog( streakinfo );
    utility::callsharedfunc( #"killstreak", #"logkillstreakevent", streakinfo.airdroptype, self.origin );
    streakinfo.airdropmarkerfired = 1;
    
    if ( !gestureactivation )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    }
    
    return "success";
}

// Namespace airdrop
// Params 4
// Checksum 0x695f1204, Offset: 0xf36a
// Size: 0x7d1
function airdropmarkeractivate( droptype, lifeid, streakinfo, gestureactivation )
{
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    ownerangles = self.owner.angles;
    
    if ( isdefined( bundle.var_a1129a3d5d0fd1b ) )
    {
        wait bundle.var_a1129a3d5d0fd1b;
        position = self.origin;
        timeout = bundle.var_722d7f5324f714da ?? 12;
        thread function_258019ea0befa68f( streakinfo, timeout );
    }
    else
    {
        timeout = bundle.var_6d80674972d79d92 ?? 5;
        thread function_258019ea0befa68f( streakinfo, timeout );
        self waittill( #"explode", position );
    }
    
    if ( gestureactivation )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
    
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
        vehicle_tracking::function_4f76f5b4541acef1();
        return;
    }
    
    waitframe();
    
    if ( bundle.var_dbfea3f1e4729be2 )
    {
        if ( bundle.var_4e04b04353c097e9 )
        {
            function_b95bf7142b05bb4b( self, owner, streakinfo );
        }
        else if ( bundle.var_5f11945d472e905f )
        {
            function_bc00ec3d2a3b972c( position, owner );
        }
        
        if ( isdefined( bundle.var_ce544f2860d06f9c ) )
        {
            wait bundle.var_ce544f2860d06f9c;
        }
    }
    
    if ( isdefined( self ) )
    {
        position = self.origin;
    }
    
    leveldata = getleveldata( droptype );
    var_82af9175060cf6ec = position;
    
    if ( isdefined( leveldata.var_8dea9376fe45b5dc ) )
    {
        position = owner [[ leveldata.var_8dea9376fe45b5dc ]]( position );
    }
    
    flightangles = ownerangles + ( 0, 180, 0 );
    targetpos = position;
    targetheightoffset = getscriptedhelidropheight( droptype, owner );
    ownerforward = anglestoforward( owner.angles );
    ownerright = anglestoright( owner.angles );
    contents = trace::create_contents( 1, 1, 1, 1, 1, 1, 0, 0, 1, 0 );
    var_4159891f0b5bc03 = [ targetpos - ownerforward * 100, targetpos + ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + ( ownerforward + ownerright ) * 100, targetpos + ( ownerforward - ownerright ) * 100, targetpos + ( ownerright - ownerforward ) * 100, targetpos + ( -1 * ownerforward - ownerright ) * 100 ];
    var_3c9505d1c4902076 = 0;
    var_bbb9b031a7db1020 = 0;
    verticalclearance = 500;
    
    while ( !var_3c9505d1c4902076 )
    {
        foreach ( dirpos in var_4159891f0b5bc03 )
        {
            var_8ba4b8834e7ce583 = vectornormalize( dirpos - targetpos );
            var_95a138eeb696530a = targetpos + ( 0, 0, targetheightoffset ) + ( 0, 0, var_bbb9b031a7db1020 );
            var_abf75242f26b5e61 = var_95a138eeb696530a - var_8ba4b8834e7ce583 * 25000;
            var_fe99d25d98da8c34 = var_95a138eeb696530a + var_8ba4b8834e7ce583 * 25000;
            traceresult = trace::ray_trace_passed( var_abf75242f26b5e61, var_fe99d25d98da8c34, undefined, contents );
            
            /#
            #/
            
            if ( !traceresult )
            {
                continue;
            }
            
            var_95a138eeb696530a = targetpos + ( 0, 0, targetheightoffset ) + ( 0, 0, var_bbb9b031a7db1020 ) + ( 0, 0, verticalclearance );
            var_abf75242f26b5e61 = var_95a138eeb696530a - var_8ba4b8834e7ce583 * 25000;
            var_fe99d25d98da8c34 = var_95a138eeb696530a + var_8ba4b8834e7ce583 * 25000;
            traceresult = trace::ray_trace_passed( var_abf75242f26b5e61, var_fe99d25d98da8c34, undefined, contents );
            
            /#
            #/
            
            if ( !traceresult )
            {
                continue;
            }
            
            flightangles = vectortoangles( var_8ba4b8834e7ce583 );
            var_3c9505d1c4902076 = 1;
            
            /#
                level thread debug_utility::drawline( var_abf75242f26b5e61, var_fe99d25d98da8c34, 30, ( 1, 1, 0 ) );
            #/
            
            break;
        }
        
        if ( !var_3c9505d1c4902076 )
        {
            var_bbb9b031a7db1020 += 750;
        }
    }
    
    /#
        if ( droptype == "<dev string:x97a>" )
        {
            crateoverride = getdvar( @"scr_crateoverride" );
            
            if ( crateoverride != "<dev string:x24>" )
            {
                utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
                dropkillstreakcratefromscriptedheli( owner, owner.team, crateoverride, position, flightangles, position, 1, streakinfo, var_bbb9b031a7db1020 );
                return;
            }
        }
    #/
    
    utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
    dropresult = undefined;
    var_73c8a0f18bbf93be = 0;
    
    if ( droptype == "airdrop" )
    {
        if ( bundle.var_9589b989d4bd184f )
        {
            dropresult = function_5f514aed135bd60f( owner, position, flightangles, streakinfo );
        }
        else
        {
            dropresult = dropkillstreakcratefromscriptedheli( owner, owner.team, undefined, position, flightangles, position, 1, streakinfo, var_bbb9b031a7db1020 );
            var_73c8a0f18bbf93be = !isdefined( dropresult );
        }
    }
    else if ( droptype == "airdrop_multiple" )
    {
        if ( utility::issharedfuncdefined( #"airdrop", #"airdropmultipledropcrates" ) )
        {
            dropresult = [[ utility::getsharedfunc( #"airdrop", #"airdropmultipledropcrates" ) ]]( owner, owner.team, position, flightangles, position, 1, streakinfo, var_bbb9b031a7db1020 );
        }
    }
    else if ( droptype == "airdrop_escort" )
    {
    }
    else if ( droptype == "loadout_drop" || droptype == "dawg" )
    {
        dropresult = function_a4039c3256bd5f4a( owner, owner.team, droptype, position, flightangles, position, 1, streakinfo, var_bbb9b031a7db1020 );
    }
    
    if ( isdefined( owner ) )
    {
        if ( streakinfo.var_dba2ed457f8ace3e )
        {
            if ( dropresult.crates && leveldata.timeout )
            {
                timestamp = gettime();
                
                foreach ( crate in dropresult.crates )
                {
                    if ( crate && !crate.isdestroyed )
                    {
                        crate.timeouttimestamp = timestamp + leveldata.timeout * 1000;
                    }
                }
            }
            
            streakinfo.dropresult = dropresult;
        }
        
        if ( !isdefined( dropresult ) )
        {
            if ( !var_73c8a0f18bbf93be )
            {
                owner utility::callsharedfunc( #"hud", #"showerrormessage", %"killstreaks/vehicle_refund_killstreak" );
            }
            
            if ( streakinfo.mpstreaksysteminfo )
            {
                owner utility::callsharedfunc( #"killstreak", #"awardkillstreakfromstruct", streakinfo.mpstreaksysteminfo, "other", undefined, undefined, undefined, streakinfo.var_9384480e6997afd7, #"hash_cf2240111acdc7d9" );
            }
            
            return;
        }
        
        owner thread function_5ea6360b53f7b8e9( owner, streakinfo, dropresult.crates );
    }
    
    if ( !bundle.var_dbfea3f1e4729be2 )
    {
        if ( bundle.var_4e04b04353c097e9 )
        {
            function_b95bf7142b05bb4b( self, owner, streakinfo );
            return;
        }
        
        if ( bundle.var_5f11945d472e905f )
        {
            function_bc00ec3d2a3b972c( var_82af9175060cf6ec, owner );
        }
    }
}

// Namespace airdrop
// Params 2
// Checksum 0xc0965eb3, Offset: 0xfb43
// Size: 0x15a
function function_bc00ec3d2a3b972c( position, owner )
{
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    markerscriptable = bundle.var_cbcbafdeabcea062 ?? "airdrop_marker";
    smokescriptable = undefined;
    
    if ( level.teambased )
    {
        smokescriptable = spawnscriptable( markerscriptable, position, ( 0, 0, 1 ) );
        smokescriptable setscriptablepartstate( "smokeSignal", "active" );
        smokescriptable function_474bcbb86b733bef( "smokeSignal", owner.team );
    }
    else
    {
        payload = [ #"teamselect", owner getentitynumber() ];
        smokescriptable = spawnscriptable( markerscriptable, position, ( 0, 0, 1 ), undefined, payload );
        smokescriptable setscriptablepartstate( "smokeSignal", "activeFFA" );
    }
    
    movingplatforminfo = function_6d2c704914d1e4b5( position );
    
    if ( isdefined( movingplatforminfo ) && isdefined( movingplatforminfo.groundent ) )
    {
        offset = position - movingplatforminfo.groundent.origin;
        smokescriptable utility::scriptable_setparententity( movingplatforminfo.groundent, offset );
    }
}

// Namespace airdrop
// Params 3
// Checksum 0xa72e38b6, Offset: 0xfca5
// Size: 0xb9
function function_b95bf7142b05bb4b( grenade, owner, streakinfo )
{
    grenade setotherent( owner );
    
    switch ( streakinfo.streakname )
    {
        case #"hash_56979e0566996b2e":
            grenade setscriptablepartstate( "smokeSignal", "airdrop" );
            break;
        case #"hash_2289ec11d77bce8f":
            grenade setscriptablepartstate( "smokeSignal", "airdrop_multiple" );
            break;
        case #"hash_b597e9a707180461":
            grenade setscriptablepartstate( "smokeSignal", "loadout_drop" );
            break;
        default:
            grenade setscriptablepartstate( "smokeSignal", "airdrop" );
            break;
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xda85f494, Offset: 0xfd66
// Size: 0x99
function airdropmarkertaken( streakinfo )
{
    if ( streakinfo.airdropmarkerfired && ( streakinfo.streakname == "airdrop" || streakinfo.streakname == "airdrop_multiple" ) )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
    
    if ( isdefined( streakinfo.airdroptype ) && !streakinfo.airdropmarkerfired )
    {
        utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
    }
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0x9e95e98, Offset: 0xfe07
// Size: 0x88
function private function_258019ea0befa68f( streakinfo, timeout )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explode" );
    wait timeout;
    
    if ( streakinfo.streakname != "airdrop" && streakinfo.streakname != "airdrop_multiple" )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
    
    self delete();
}

// Namespace airdrop
// Params 0
// Checksum 0xe48e9e45, Offset: 0xfe97
// Size: 0x141
function function_c06b02fb0c4450d3()
{
    leveldata = getleveldata( "loadout_drop" );
    leveldata.capturestring = &"mp/br_crate_loadout";
    leveldata.basemodel = "military_carepackage_01_loadout_mp";
    leveldata.supportsownercapture = 1;
    leveldata.headicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
    leveldata.minimapicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
    leveldata.usepriority = -1;
    leveldata.usefov = 360;
    leveldata.timeout = 60;
    leveldata.friendlyuseonly = 1;
    leveldata.maxusage = 5;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.activatecallback = &loadoutcrateactivatecallback;
    leveldata.capturecallback = &loadoutcratecapturecallback;
    leveldata.destroyoncapture = 0;
    leveldata.onecaptureperplayer = 1;
    leveldata.isteamonlycrate = 1;
    leveldata.var_8d45872a539aa837 = 0;
}

// Namespace airdrop
// Params 1
// Checksum 0xafbe70a3, Offset: 0xffe0
// Size: 0x2b
function loadoutcrateactivatecallback( isfirstactivation )
{
    if ( isfirstactivation )
    {
        utility::callsharedfunc( #"airdrop", #"registercrateforcleanup", self );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xbc890d8e, Offset: 0x10013
// Size: 0x45
function loadoutcratecapturecallback( player )
{
    if ( utility::issharedfuncdefined( #"airdrop", #"airdropselectloadout" ) )
    {
        player thread [[ utility::getsharedfunc( #"airdrop", #"airdropselectloadout" ) ]]( self );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x9b244bb6, Offset: 0x10060
// Size: 0x66
function loadoutcratepostcapture( player )
{
    if ( !isdefined( self.numuses ) )
    {
        self.numuses = 0;
    }
    
    self.numuses++;
    leveldata = getleveldata( self.cratetype );
    
    if ( self.numuses >= leveldata.maxusage )
    {
        thread destroycrate();
    }
}

// Namespace airdrop
// Params 9
// Checksum 0x9ae2784f, Offset: 0x100ce
// Size: 0xf7
function function_a4039c3256bd5f4a( owner, team, streakname, position, angles, destination, vehicleisreserved, streakinfo, var_bbb9b031a7db1020 = 0 )
{
    cratetype = streakname;
    cratedropdata = getkillstreakcratedatabystreakname( streakname, 0 );
    cratedropdata.vehicleisreserved = vehicleisreserved;
    cratedropdata.var_bbb9b031a7db1020 = var_bbb9b031a7db1020;
    scenenode = dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, cratedropdata, streakinfo );
    
    if ( !isdefined( scenenode ) )
    {
        return;
    }
    else if ( !( isdefined( scenenode.crates ) && isdefined( utility::array_get_first_item( scenenode.crates ) ) ) )
    {
        return;
    }
    
    if ( isdefined( owner ) )
    {
        owner thread airdrop_playdeploydialog( streakinfo );
    }
    
    return scenenode;
}

// Namespace airdrop
// Params 0
// Checksum 0x4804242c, Offset: 0x101ce
// Size: 0x163
function initbattleroyalec130airdropcratedata()
{
    leveldata = getleveldata( "battle_royale_c130_loot" );
    
    if ( game_utility::getgametype() == "plunder" )
    {
        leveldata.capturestring = &"mp/dmz_loot_crate_capture";
    }
    else
    {
        leveldata.capturestring = &"mp/generic_loot_crate_capture";
    }
    
    leveldata.basemodel = "military_carepackage_01_br";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.timeout = 600;
    leveldata.friendlyuseonly = 1;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.activatecallback = &brc130airdropcrateactivatecallback;
    leveldata.capturecallback = &brc130airdropcratecapturecallback;
    leveldata.destroycallback = &brc130airdropcratedestroycallback;
    leveldata.cratephysicsoncallback = &brc130airdropcratephysicsoncallback;
    leveldata.destroyoncapture = 1;
    leveldata.isdropcrate = 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
}

// Namespace airdrop
// Params 1
// Checksum 0xaadcdb2f, Offset: 0x10339
// Size: 0xc
function brc130airdropcrateactivatecallback( isfirstactivation )
{
    
}

// Namespace airdrop
// Params 1
// Checksum 0xc125b1e7, Offset: 0x1034d
// Size: 0xbb
function brc130airdropcratecapturecallback( player )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    utility::callsharedfunc( #"br_c130airdrop", #"c130airdrop_oncrateuse", player );
    utility::callsharedfunc( #"br_c130airdrop", #"dmztut_crateused", player );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
    
    if ( isdefined( level.c130successfulairdrops ) )
    {
        level.c130successfulairdrops = arrayremove( level.c130successfulairdrops, self );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xe761b6b9, Offset: 0x10410
// Size: 0x85
function brc130airdropcratedestroycallback( immediate )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
    
    if ( isdefined( level.c130successfulairdrops ) )
    {
        level.c130successfulairdrops = arrayremove( level.c130successfulairdrops, self );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xd9f4bd7b, Offset: 0x1049d
// Size: 0x1b
function brc130airdropcratephysicsoncallback()
{
    self setscriptablepartstate( #"crate_audio", #"detach", 0 );
}

// Namespace airdrop
// Params 8
// Checksum 0xee9d3fb3, Offset: 0x104c0
// Size: 0x168
function dropbrc130airdropcrate( dropposition, dropdestination, dropangles, var_4e6ac319ac3c8a28, var_50f673dd2f486dbb, nodropanim, team, var_8a457bb1dd3d1ed4 )
{
    droplootid = var_4e6ac319ac3c8a28 ?? "battle_royale_c130_loot";
    
    if ( !isdefined( nodropanim ) )
    {
        nodropanim = 0;
    }
    
    crate = function_c9f138f3e91e2f7f( dropposition, dropdestination, dropangles, droplootid, team, nodropanim );
    
    if ( isdefined( crate ) )
    {
        var_fc7bb437732e8a83 = #"cashdrop_common";
        var_f73f7b78f923e259 = getdvarint( @"hash_ff7bb52f31b387e1", 1 );
        
        if ( var_f73f7b78f923e259 )
        {
            var_fc7bb437732e8a83 = #"cashdrop_common_world";
        }
        
        if ( isdefined( var_50f673dd2f486dbb ) )
        {
            var_fc7bb437732e8a83 = var_50f673dd2f486dbb;
        }
        
        crate setscriptablepartstate( "objective_map", var_fc7bb437732e8a83, 0 );
        
        if ( !nodropanim )
        {
            crate setscriptablepartstate( "crate_audio", "parachuting", 0 );
        }
        
        var_8a457bb1dd3d1ed4 = var_8a457bb1dd3d1ed4 ?? crate.var_f6d516ce0060e74c;
        var_f6d516ce0060e74c = var_8a457bb1dd3d1ed4 ?? "ks_airdrop_crate_br";
        crate.smokesignal = spawn( "script_model", dropdestination );
        crate.smokesignal setmodel( var_f6d516ce0060e74c );
        crate.smokesignal setscriptablepartstate( #"smoke_signal", #"on", 0 );
    }
    
    return crate;
}

// Namespace airdrop
// Params 9
// Checksum 0x496a6c07, Offset: 0x10631
// Size: 0x30f
function function_c9f138f3e91e2f7f( dropposition, dropdestination, dropangles, airdropidentifier, team, var_f64b79b9f428aac1, var_e9a9d186782e327b = 1, var_f1b1db4ae9e5ccbc, var_cca7c771258933b6 )
{
    releaseoffset = var_cca7c771258933b6 ?? 1000;
    var_5e099e0a8b648eb6 = 10500;
    var_8916acc776c8a2d3 = 7500;
    var_a139d4d9ddb0bc58 = 3000;
    releasedestination = dropdestination + ( 0, 0, releaseoffset );
    releasedestination = ( releasedestination[ 0 ], releasedestination[ 1 ], min( releasedestination[ 2 ], dropposition[ 2 ] - 0.1 ) );
    crate = createcrate( undefined, team, airdropidentifier, dropposition, ( 0, 0, 0 ), dropdestination, undefined, 0, undefined, undefined, undefined, undefined, undefined, var_f1b1db4ae9e5ccbc );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    crate.skipminimapicon = 1;
    
    if ( !var_f64b79b9f428aac1 && releasedestination[ 2 ] < dropposition[ 2 ] )
    {
        animid = undefined;
        var_f416a7ab30e46875 = distance( dropposition, releasedestination );
        
        if ( var_f416a7ab30e46875 >= var_5e099e0a8b648eb6 )
        {
            animid = "brc130_drop_high";
        }
        else if ( var_f416a7ab30e46875 >= var_8916acc776c8a2d3 )
        {
            animid = "brc130_drop_med";
        }
        else if ( var_f416a7ab30e46875 >= var_a139d4d9ddb0bc58 )
        {
            animid = "brc130_drop_low";
        }
        
        if ( isdefined( animid ) )
        {
            animzoffset = 1000;
            scenenode = { #angles:dropangles, #origin:releasedestination + ( 0, 0, animzoffset ) };
            crate.animname = "care_package";
            crate.dropanim = level.scr_anim[ crate.animname ][ animid ];
            crate.animlength = getanimlength( crate.dropanim );
            crate animation::setanimtree();
            
            if ( isdefined( team ) )
            {
                visibility_mode::function_3afc3bc470c80e61( crate, team );
            }
            
            chute = spawn( "script_model", crate.origin );
            chute.angles = crate.angles;
            chute.animname = "care_package_chute";
            chute.dropanim = level.scr_anim[ chute.animname ][ animid ];
            chute.animlength = getanimlength( chute.dropanim );
            chutemodel = getleveldata( airdropidentifier ).parachutemodel ?? "veh9_mil_lnd_parachute_carepackage_br";
            chute setmodel( chutemodel );
            chute animation::setanimtree();
            scenenode thread animation::anim_single_solo( crate, animid );
            scenenode thread animation::anim_single_solo( chute, animid );
            crate thread watchbrc130aidropcrateanimend();
            chute thread watchbrc130airdropchuteanimend();
        }
        else if ( var_e9a9d186782e327b )
        {
            crate cratephysicson();
        }
    }
    else if ( var_e9a9d186782e327b )
    {
        crate cratephysicson();
    }
    
    return crate;
}

// Namespace airdrop
// Params 0
// Checksum 0xf8dc3386, Offset: 0x10949
// Size: 0x3c
function watchbrc130aidropcrateanimend()
{
    self endon( #"death" );
    wait self.animlength;
    
    if ( isdefined( self ) )
    {
        level notify( self.cratetype + "drop_anim_completed" );
        self stopanimscripted();
        cratephysicson();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xf04a8f0d, Offset: 0x1098d
// Size: 0x2d
function watchbrc130airdropchuteanimend( scenenode )
{
    wait self.animlength;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    if ( scenenode )
    {
        scenenode delete();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x5081c21d, Offset: 0x109c2
// Size: 0x12b
function initbattleroyalelootchoppercratedata()
{
    leveldata = getleveldata( "battle_royale_chopper_loot" );
    leveldata.capturestring = &"mp/dmz_plunder_crate_capture";
    leveldata.basemodel = "military_carepackage_01_br";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.timeout = 600;
    leveldata.friendlyuseonly = 1;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.activatecallback = &brlootchoppercrateactivatecallback;
    leveldata.capturecallback = &brlootchoppercratecapturecallback;
    leveldata.destroycallback = &brlootchoppercratedestroycallback;
    leveldata.destroyoncapture = 1;
    leveldata.isdropcrate = 1;
}

// Namespace airdrop
// Params 1
// Checksum 0x27a8271d, Offset: 0x10af5
// Size: 0xc
function brlootchoppercrateactivatecallback( isfirstactivation )
{
    
}

// Namespace airdrop
// Params 1
// Checksum 0x7af9f0d, Offset: 0x10b09
// Size: 0x97
function brlootchoppercratecapturecallback( player )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    utility::callsharedfunc( #"br_lootchopper", #"lootchopper_oncrateuse", player );
    utility::callsharedfunc( #"br_lootchopper", #"championchopper_oncrateuse", player );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xbe2425cd, Offset: 0x10ba8
// Size: 0x61
function brlootchoppercratedestroycallback( immediate )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x9c5cdb94, Offset: 0x10c11
// Size: 0xf0
function dropbrlootchoppercrate( position, destination )
{
    crate = dropcrate( undefined, undefined, "battle_royale_chopper_loot", position, ( 0, randomfloat( 360 ), 0 ), destination );
    
    if ( isdefined( crate ) )
    {
        crate.skipminimapicon = 1;
        var_fc7bb437732e8a83 = #"cashdrop_common";
        var_f73f7b78f923e259 = getdvarint( @"hash_ff7bb52f31b387e1", 1 );
        
        if ( var_f73f7b78f923e259 )
        {
            var_fc7bb437732e8a83 = #"cashdrop_common_world";
        }
        
        crate setscriptablepartstate( #"objective_map", var_fc7bb437732e8a83, 0 );
        crate.smokesignal = spawn( "script_model", destination );
        crate.smokesignal setmodel( "ks_airdrop_crate_br" );
        crate.smokesignal setscriptablepartstate( #"smoke_signal", #"on", 0 );
    }
    
    return crate;
}

// Namespace airdrop
// Params 2
// Checksum 0x6d2fa0c8, Offset: 0x10d0a
// Size: 0xbb
function dropbrlootchoppercrateforpublicevent( position, destination )
{
    crate = dropcrate( undefined, undefined, "battle_royale_chopper_loot", position, ( 0, randomfloat( 360 ), 0 ), destination );
    
    if ( isdefined( crate ) )
    {
        crate.skipminimapicon = 1;
        crate setscriptablepartstate( #"objective_map", #"pe_chopper_crate", 0 );
        crate.smokesignal = spawn( "script_model", destination );
        crate.smokesignal setmodel( "ks_airdrop_crate_br" );
        crate.smokesignal setscriptablepartstate( #"smoke_signal", #"pe_chopper_on", 0 );
    }
    
    return crate;
}

// Namespace airdrop
// Params 0
// Checksum 0xe01a96df, Offset: 0x10dce
// Size: 0x11d
function function_d10c6d162d5d1216()
{
    leveldata = getleveldata( "battle_royale_elite_chopper" );
    leveldata.capturestring = &"BR_ELITE_IRONCLAD/BR_CRATE_ELITE";
    leveldata.basemodel = "military_carepackage_01_elite_chopper";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.timeout = 600;
    leveldata.friendlyuseonly = 1;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.activatecallback = &function_ab3c6b008b414049;
    leveldata.capturecallback = &function_90d636452594b9cc;
    leveldata.destroycallback = &function_b46674f83d29a8c;
    leveldata.destroyoncapture = 1;
    leveldata.isdropcrate = 1;
}

// Namespace airdrop
// Params 1
// Checksum 0xb151bfc9, Offset: 0x10ef3
// Size: 0xc
function function_ab3c6b008b414049( isfirstactivation )
{
    
}

// Namespace airdrop
// Params 1
// Checksum 0x245d2a3f, Offset: 0x10f07
// Size: 0x7c
function function_90d636452594b9cc( player )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    utility::callsharedfunc( #"br_elitechopper", #"elitechopper_oncrateuse", player );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x4e147f87, Offset: 0x10f8b
// Size: 0x61
function function_b46674f83d29a8c( immediate )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x5c5a7b51, Offset: 0x10ff4
// Size: 0xbb
function function_30f0e86320b9c8cc( position, destination )
{
    crate = dropcrate( undefined, undefined, "battle_royale_elite_chopper", position, ( 0, randomfloat( 360 ), 0 ), destination );
    
    if ( isdefined( crate ) )
    {
        crate.skipminimapicon = 1;
        crate setscriptablepartstate( #"objective_map", #"elite_chopper_crate", 0 );
        crate.smokesignal = spawn( "script_model", destination );
        crate.smokesignal setmodel( "ks_airdrop_crate_br" );
        crate.smokesignal setscriptablepartstate( #"smoke_signal", #"pe_chopper_on", 0 );
    }
    
    return crate;
}

// Namespace airdrop
// Params 0
// Checksum 0x4f635b45, Offset: 0x110b8
// Size: 0x139
function function_2754449e14898546()
{
    leveldata = getleveldata( "battle_royale_cash_crate" );
    leveldata.capturestring = &"mp/dmz_plunder_crate_capture";
    leveldata.basemodel = "military_carepackage_01_br";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.timeout = 600;
    leveldata.friendlyuseonly = 1;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.var_1fc61fdb8add2a40 = 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.activatecallback = &function_321b312b4471ab66;
    leveldata.capturecallback = &function_f2de1be81484bca9;
    leveldata.destroycallback = &function_732abe54ddf2fb59;
    leveldata.destroyoncapture = 1;
    leveldata.isdropcrate = 1;
}

// Namespace airdrop
// Params 1
// Checksum 0xdd77a620, Offset: 0x111f9
// Size: 0x26
function function_321b312b4471ab66( isfirstactivation )
{
    utility::callsharedfunc( #"airdrop", #"registercrateforcleanup", self );
}

// Namespace airdrop
// Params 1
// Checksum 0x124e8c0c, Offset: 0x11227
// Size: 0x7d
function function_f2de1be81484bca9( player )
{
    self setscriptablepartstate( "objective_map", "inactive", 0 );
    self setscriptablepartstate( "objective", "inactive", 0 );
    utility::callsharedfunc( #"br_cashcrate", #"cashcrate_oncrateuse", player );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( "smoke_signal", "off", 0 );
        self.smokesignal delete();
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xc7d6032a, Offset: 0x112ac
// Size: 0x62
function function_732abe54ddf2fb59( immediate )
{
    self setscriptablepartstate( "objective_map", "inactive", 0 );
    self setscriptablepartstate( "objective", "inactive", 0 );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( "smoke_signal", "off", 0 );
        self.smokesignal delete();
    }
}

// Namespace airdrop
// Params 2
// Checksum 0xf08f9f54, Offset: 0x11316
// Size: 0xdc
function function_48f27fbf02934533( position, destination )
{
    crate = dropcrate( undefined, undefined, "battle_royale_cash_crate", position, ( 0, randomfloat( 360 ), 0 ), destination );
    
    if ( isdefined( crate ) )
    {
        crate.skipminimapicon = 1;
        var_fc7bb437732e8a83 = "cashdrop_common";
        var_f73f7b78f923e259 = getdvarint( @"hash_ff7bb52f31b387e1", 1 );
        
        if ( var_f73f7b78f923e259 )
        {
            var_fc7bb437732e8a83 = "cashdrop_common_world";
        }
        
        crate setscriptablepartstate( "objective_map", var_fc7bb437732e8a83, 0 );
        crate.smokesignal = spawn( "script_model", destination );
        crate.smokesignal setmodel( "ks_airdrop_crate_br" );
        crate.smokesignal setscriptablepartstate( "smoke_signal", "on", 0 );
    }
    
    return crate;
}

// Namespace airdrop
// Params 0
// Checksum 0x239b2721, Offset: 0x113fb
// Size: 0x13c
function initplundercratedata()
{
    leveldata = getleveldata( "esc_cache" );
    leveldata.capturestring = &"mp/esc_cache_use_hint";
    leveldata.usetag = "tag_origin";
    leveldata.userange = 200;
    leveldata.usefov = 160;
    leveldata.usepriority = 0;
    leveldata.basemodel = "military_crate_large_stackable_01";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -10000;
    leveldata.headicon = undefined;
    leveldata.minimapicon = undefined;
    
    if ( utility::issharedfuncdefined( #"airdrop", #"capturelootcachecallback" ) )
    {
        leveldata.capturecallback = utility::getsharedfunc( #"airdrop", #"capturelootcachecallback" );
    }
    
    leveldata.destroyoncapture = 0;
    leveldata.onecaptureperplayer = 1;
    leveldata.capturevisualscallback = undefined;
    leveldata.destroyvisualscallback = undefined;
    leveldata.timeout = undefined;
}

// Namespace airdrop
// Params 1
// Checksum 0x2426ceef, Offset: 0x1153f
// Size: 0x2c
function getplcratedata( contents )
{
    data = spawnstruct();
    data.contents = contents;
    return data;
}

// Namespace airdrop
// Params 3
// Checksum 0x430e9cc5, Offset: 0x11574
// Size: 0x44
function placeplcrate( contents, position, angles )
{
    crate = placecrate( undefined, undefined, "esc_cache", position, angles, getplcratedata( contents ) );
    return crate;
}

// Namespace airdrop
// Params 0
// Checksum 0xee5ce2a2, Offset: 0x115c1
// Size: 0x128
function initarmcratedata()
{
    level.cratedata.armweights = [];
    level.cratedata.armcapturestrings = [];
    leveldata = getleveldata( "arm_no_owner" );
    leveldata.activatecallback = &armcrateactivatecallback;
    leveldata.capturecallback = &armcratecapturecallback;
    leveldata.supportsownercapture = 0;
    leveldata.headicondrawrange = 5000;
    leveldata.timeout = 180;
    addarmcratedata( "uav", undefined, 5, 10 );
    addarmcratedata( "manual_turret", undefined, 5, 5 );
    addarmcratedata( "cruise_predator", undefined, 4, 40 );
    addarmcratedata( "scrambler_drone_guard", undefined, 4, 20 );
    addarmcratedata( "precision_airstrike", undefined, 3, 60 );
    addarmcratedata( "toma_strike", undefined, 2, 40 );
    addarmcratedata( "chopper_gunner", undefined, 2, 30 );
    addarmcratedata( "pac_sentry", undefined, 2, 30 );
    addarmcratedata( "gunship", undefined, 2, 30 );
}

// Namespace airdrop
// Params 4
// Checksum 0x17a81148, Offset: 0x116f1
// Size: 0x6f
function addarmcratedata( streakname, capturestring, defconlevel, weight )
{
    level.cratedata.armdefconlevels[ streakname ] = defconlevel;
    level.cratedata.armweights[ streakname ] = weight;
    level.cratedata.armcapturestrings[ streakname ] = capturestring;
}

// Namespace airdrop
// Params 1
// Checksum 0xaa9b2369, Offset: 0x11768
// Size: 0x2c
function getarmcratedatabystreakname( streakname )
{
    data = spawnstruct();
    data.streakname = streakname;
    return data;
}

// Namespace airdrop
// Params 1
// Checksum 0x25431da4, Offset: 0x1179d
// Size: 0x59
function armcrateactivatecallback( isfirstactivation )
{
    data = self.data;
    capturestring = level.cratedata.armcapturestrings[ data.streakname ];
    
    if ( isdefined( capturestring ) )
    {
        overridecapturestring( capturestring );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0xd0364292, Offset: 0x117fe
// Size: 0x67
function armcratecapturecallback( player )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"awardkillstreak" ) )
    {
        player thread [[ utility::getsharedfunc( #"killstreak", #"awardkillstreak" ) ]]( self.data.streakname, "airdrop", undefined, undefined, self.owner );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x1cf5d90, Offset: 0x1186d
// Size: 0x7f
function getrandomarmkillstreak( team )
{
    assert( isdefined( level.cratedata ), "<dev string:x982>" );
    assert( isdefined( level.cratedata.armweights ), "<dev string:x9ba>" );
    var_e0a275ac51a62494 = getarmkillsteakstoexcludebyteamdefconlevel( team );
    streakname = getrandomkeyfromweightsarray( level.cratedata.armweights, var_e0a275ac51a62494 );
    return streakname;
}

// Namespace airdrop
// Params 1
// Checksum 0xe825a646, Offset: 0x118f5
// Size: 0xf7
function getarmkillsteakstoexcludebyteamdefconlevel( team )
{
    assert( isdefined( level.cratedata.armdefconlevels ), "<dev string:x9f5>" );
    assert( isdefined( level.defconlevel ), "<dev string:xa44>" );
    defconlevel = level.defconlevel;
    var_ccffab4cf7372d0e = undefined;
    
    if ( defconlevel > 1 )
    {
        var_ccffab4cf7372d0e = [];
        
        foreach ( streakname, var_1b46b37e6835f349 in level.cratedata.armdefconlevels )
        {
            if ( defconlevel > var_1b46b37e6835f349 )
            {
                var_ccffab4cf7372d0e[ var_ccffab4cf7372d0e.size ] = streakname;
            }
        }
    }
    
    return var_ccffab4cf7372d0e;
}

// Namespace airdrop
// Params 5
// Checksum 0x68adf3df, Offset: 0x119f5
// Size: 0x123
function droparmcratefromscriptedheli( team, streakname, position, angles, destination )
{
    if ( !isdefined( streakname ) || streakname == "random" )
    {
        streakname = getrandomarmkillstreak( team );
    }
    
    cratedropdata = getarmcratedatabystreakname( streakname );
    scenenode = dropcratefromscriptedheli( undefined, team, "arm_no_owner", position, angles, destination, cratedropdata );
    
    if ( !isdefined( scenenode ) )
    {
        return;
    }
    else if ( !( isdefined( scenenode.crates ) && isdefined( utility::array_get_first_item( scenenode.crates ) ) ) )
    {
        return;
    }
    
    foreach ( crate in scenenode.crates )
    {
        return crate;
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xcb47bf5, Offset: 0x11b20
// Size: 0x134
function function_e9e0ed77db3e85fc()
{
    level.cratedata.gwtdmweights = [];
    level.cratedata.var_54d76583d485c977 = [];
    leveldata = getleveldata( "gwtdm_no_owner" );
    leveldata.activatecallback = &function_3dc005c4734adb4c;
    leveldata.capturecallback = &armcratecapturecallback;
    leveldata.supportsownercapture = 0;
    leveldata.enemymodel = undefined;
    leveldata.headicondrawrange = 5000;
    leveldata.timeout = 180;
    function_ce1666fad60c8645( "cruise_predator", 40 );
    function_ce1666fad60c8645( "precision_airstrike", 40 );
    function_ce1666fad60c8645( "toma_strike", 40 );
    function_ce1666fad60c8645( "fuel_airstrike", 40 );
    function_ce1666fad60c8645( "remote_turret", 40 );
    function_ce1666fad60c8645( "pac_sentry", 30 );
    function_ce1666fad60c8645( "auto_drone", 20 );
    function_ce1666fad60c8645( "hover_jet", 20 );
    function_ce1666fad60c8645( "chopper_gunner", 20 );
    function_ce1666fad60c8645( "gunship", 10 );
    function_ce1666fad60c8645( "juggernaut", 10 );
}

// Namespace airdrop
// Params 2
// Checksum 0xf2261694, Offset: 0x11c5c
// Size: 0x2d
function function_ce1666fad60c8645( streakname, weight )
{
    level.cratedata.gwtdmweights[ streakname ] = weight;
}

// Namespace airdrop
// Params 1
// Checksum 0x104c2e90, Offset: 0x11c91
// Size: 0x59
function function_3dc005c4734adb4c( isfirstactivation )
{
    data = self.data;
    capturestring = level.cratedata.var_54d76583d485c977[ data.streakname ];
    
    if ( isdefined( capturestring ) )
    {
        overridecapturestring( capturestring );
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x35495b19, Offset: 0x11cf2
// Size: 0x6b
function function_7d75d85a4d6963a4( team )
{
    assert( isdefined( level.cratedata ), "<dev string:x982>" );
    assert( isdefined( level.cratedata.gwtdmweights ), "<dev string:x9ba>" );
    streakname = getrandomkeyfromweightsarray( level.cratedata.gwtdmweights );
    return streakname;
}

// Namespace airdrop
// Params 1
// Checksum 0xb61619bb, Offset: 0x11d66
// Size: 0x2c
function function_a29302308c1ae8e2( streakname )
{
    data = spawnstruct();
    data.streakname = streakname;
    return data;
}

// Namespace airdrop
// Params 5
// Checksum 0x6ab80877, Offset: 0x11d9b
// Size: 0x123
function function_33be22261f18a20d( team, streakname, position, angles, destination )
{
    if ( !isdefined( streakname ) || streakname == "random" )
    {
        streakname = function_7d75d85a4d6963a4( team );
    }
    
    cratedropdata = function_a29302308c1ae8e2( streakname );
    scenenode = dropcratefromscriptedheli( undefined, team, "gwtdm_no_owner", position, angles, destination, cratedropdata );
    
    if ( !isdefined( scenenode ) )
    {
        return;
    }
    else if ( !( isdefined( scenenode.crates ) && isdefined( utility::array_get_first_item( scenenode.crates ) ) ) )
    {
        return;
    }
    
    foreach ( crate in scenenode.crates )
    {
        return crate;
    }
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0xb8163204, Offset: 0x11ec6
// Size: 0xcd
function private function_cbd29a2dd516680d()
{
    level.cratedata.var_b5fdaa4276539681 = [];
    function_fe15c6650157768c( "drill_charge_bomb", 115 );
    function_fe15c6650157768c( "glider", 115 );
    function_fe15c6650157768c( "sticky_artillery", 30 );
    function_fe15c6650157768c( "turret_drone", 30 );
    function_fe15c6650157768c( "pac_sentry", 30 );
    function_fe15c6650157768c( "railgun", 30 );
    function_fe15c6650157768c( "crossfire", 10 );
    function_fe15c6650157768c( "dual_minigun_heli", 10 );
    function_fe15c6650157768c( "attack_chopper", 10 );
    function_fe15c6650157768c( "gunship", 5 );
    function_fe15c6650157768c( "minijugg", 5 );
    function_fe15c6650157768c( "cruise_package", 5 );
    function_fe15c6650157768c( "air_lockdown", 5 );
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0xd01f951, Offset: 0x11f9b
// Size: 0x2d
function private function_fe15c6650157768c( streakname, weight )
{
    level.cratedata.var_b5fdaa4276539681[ streakname ] = weight;
}

// Namespace airdrop
// Params 0
// Checksum 0xff50d0fa, Offset: 0x11fd0
// Size: 0x61
function function_1e33ae1ce2ad299f()
{
    assert( isdefined( level.cratedata ), "<dev string:x982>" );
    assert( isdefined( level.cratedata.var_b5fdaa4276539681 ), "<dev string:x9ba>" );
    streakname = getrandomkeyfromweightsarray( level.cratedata.var_b5fdaa4276539681 );
    return streakname;
}

// Namespace airdrop
// Params 0
// Checksum 0x2d9f4927, Offset: 0x1203a
// Size: 0x138
function initbattleroyalejuggernautcratedata()
{
    leveldata = getleveldata( "battle_royale_juggernaut" );
    leveldata.capturestring = &"killstreaks_hints/jugg_crate_pickup";
    leveldata.basemodel = "military_carepackage_03_jugg_br";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.timeout = undefined;
    leveldata.friendlyuseonly = 1;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.capturecallback = &brjuggernautcratecapturecallback;
    leveldata.destroycallback = &brjuggernautcratedestroycallback;
    leveldata.activatecallback = &brjuggernautcrateactivatecallback;
    leveldata.cratephysicsoncallback = &brjuggernautcratephysicsoncallback;
    leveldata.destroyoncapture = 1;
    leveldata.isdropcrate = 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
}

// Namespace airdrop
// Params 1
// Checksum 0xedcbae7, Offset: 0x1217a
// Size: 0x30
function brjuggernautcrateactivatecallback( isfirstactivation )
{
    juggernaut::oncrateactivated( isfirstactivation );
    utility::callsharedfunc( #"br_juggernaut", #"oncrateactivate", isfirstactivation );
}

// Namespace airdrop
// Params 1
// Checksum 0x24880622, Offset: 0x121b2
// Size: 0xb0
function brjuggernautcratecapturecallback( player )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    leveldata = getleveldata( self.cratetype );
    
    if ( isdefined( self.smokesignal ) && leveldata.destroyoncapture )
    {
        self.smokesignal setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smokesignal delete();
    }
    
    utility::callsharedfunc( #"br_juggernaut", #"oncrateuse", player, leveldata );
    juggernaut::oncratecaptured( player );
}

// Namespace airdrop
// Params 1
// Checksum 0x10b79f8a, Offset: 0x1226a
// Size: 0x74
function brjuggernautcratedestroycallback( immediate )
{
    self setscriptablepartstate( #"objective_map", #"inactive", 0 );
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( "smoke_signal", "off", 0 );
        self.smokesignal delete();
    }
    
    utility::callsharedfunc( #"br_juggernaut", #"oncratedestroy", immediate );
}

// Namespace airdrop
// Params 2
// Checksum 0xed7d7548, Offset: 0x122e6
// Size: 0x2e
function brjuggernautcratephysicsoncallback( position, destination )
{
    self setscriptablepartstate( #"crate_audio", #"detach", 0 );
}

// Namespace airdrop
// Params 3
// Checksum 0x2e67fc71, Offset: 0x1231c
// Size: 0x55
function dropjuggernautcrate( team, position, destination )
{
    streakinfo = killstreak_utility::createstreakinfo( "juggernaut", self );
    return dropcrate( undefined, team, "battle_royale_juggernaut", position, ( 0, randomfloat( 360 ), 0 ), destination, streakinfo, 1 );
}

// Namespace airdrop
// Params 2
// Checksum 0xfdad7461, Offset: 0x1237a
// Size: 0xf8
function spawnjuggernautcrateatposition( pos, isfromgrenade )
{
    crate = dropjuggernautcrate( self.team, pos + ( 0, 0, 4096 ), pos + ( 0, 0, 512 ) );
    assert( isdefined( crate ) );
    crate endon( #"death" );
    enablejuggernautcrateobjective( crate );
    choosejuggernautcratemodel( crate );
    
    foreach ( teammate in level.teamdata[ self.team ][ "alivePlayers" ] )
    {
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x6ac9cf0a, Offset: 0x1247a
// Size: 0x2d
function enablejuggernautcrateobjective( crate )
{
    crate setotherent( self );
    crate setscriptablepartstate( #"objective_map", #"jugg_world" );
}

// Namespace airdrop
// Params 1
// Checksum 0xd9f8ad38, Offset: 0x124af
// Size: 0x2d
function choosejuggernautcratemodel( crate )
{
    crate setotherent( self );
    crate setscriptablepartstate( #"model", #"choose" );
}

// Namespace airdrop
// Params 1
// Checksum 0xd0104029, Offset: 0x124e4
// Size: 0x7f
function juggcanusecrate( crate )
{
    if ( crate.airdropsettings.airdropidentifier == "airdrop_loadout_crate" )
    {
        return self.juggcontext.juggconfig.useweaponpickups;
    }
    
    return !crate.var_47533c38c696f3e1 && !arraycontains( self.juggcontext.var_cada3a2b875f08a2 ?? [], crate.cratetype );
}

// Namespace airdrop
// Params 0
// Checksum 0x17caf600, Offset: 0x1256c
// Size: 0x1b
function function_31b29cacaf6712bc()
{
    return self.inwater ? 50 : 5;
}

// Namespace airdrop
// Params 0
// Checksum 0x1f1465d5, Offset: 0x12590
// Size: 0x1b
function function_a8eef8b3fdb0f7d5()
{
    return self.inwater ? 5 : 1;
}

// Namespace airdrop
// Params 0
// Checksum 0x9716932f, Offset: 0x125b4
// Size: 0x15
function function_a28d377e7109bc81()
{
    return self.inwater ? 3 : 6;
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0xbe246c9a, Offset: 0x125d2
// Size: 0x39
function private function_a7820994ed9a184a()
{
    leveldata = getleveldata( self.cratetype );
    return self.inwater ? 5 : leveldata.headiconoffset;
}

// Namespace airdrop
// Params 0
// Checksum 0xfcfca0b9, Offset: 0x12614
// Size: 0x7a
function function_1f69008e8ca9fd06()
{
    leveldata = getleveldata( "elite_arrow_bombsite" );
    leveldata.basemodel = "military_carepackage_01_cq";
    leveldata.var_4878e2bb6b50c0ba = 1;
    leveldata.minimapicon = undefined;
    leveldata.headicon = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.hasnointeraction = 1;
    leveldata.timeout = 0.1;
}

// Namespace airdrop
// Params 0
// Checksum 0x516e3dd, Offset: 0x12696
// Size: 0xe9
function function_46d9c17b7b6ba509()
{
    leveldata = getleveldata( "legendary_supply_drop" );
    leveldata.basemodel = "military_carepackage_03_br";
    leveldata.mountmantlemodel = undefined;
    leveldata.usepriority = -1;
    leveldata.minimapicon = undefined;
    leveldata.headicon = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.timeout = 180;
    leveldata.ownerusetime = 0.5;
    leveldata.friendlyusetime = 0.5;
    leveldata.enemyusetime = 3;
    leveldata.capturecallback = &function_67c028bd0948e56c;
    leveldata.destroyoncapture = 1;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.capturestring = &"mp/generic_loot_crate_capture";
}

// Namespace airdrop
// Params 1
// Checksum 0x913f86cc, Offset: 0x12787
// Size: 0x27
function function_67c028bd0948e56c( player )
{
    utility::callsharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", player );
}

// Namespace airdrop
// Params 0
// Checksum 0x609f65ce, Offset: 0x127b6
// Size: 0x49
function function_786e8501a325fa33()
{
    if ( !getdvarint( @"hash_512579d69cfe8e6f", 1 ) )
    {
        return;
    }
    
    assert( isdefined( level.cratedata ) );
    level.cratedata.var_48f65f7b1c01c1c0 = [];
    join_team_aggregator::registeronplayerjointeamcallback( &function_294d1f3b431a9470 );
}

// Namespace airdrop
// Params 1
// Checksum 0xb33acfbb, Offset: 0x12807
// Size: 0x12b
function function_5929a0eafa52c5bf( team )
{
    if ( function_291762b3fcfef0fb( team ) )
    {
        bitindex = function_6dd4e1ae9bd36f78( team );
        teammates = teams::getteamdata( team, "players" );
        
        foreach ( teammate in teammates )
        {
            teammate function_47457b9ec007482e( "scriptable_crate_outline_mask", bitindex, 1, 1 );
        }
        
        return;
    }
    
    if ( !isdefined( self.playeroutlines ) )
    {
        self.playeroutlines = [];
    }
    
    if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
    {
        self.playeroutlines[ self.playeroutlines.size ] = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( self, team, "outline_depth_cyan", "level_script" );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xdca4f410, Offset: 0x1293a
// Size: 0xdf
function function_9cdf32dcb730c2()
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( function_17c7369ddd51e758() )
    {
        assert( isdefined( self.team ) );
        function_70eb23b34377abd2( self.team );
        return;
    }
    
    if ( !isdefined( self.playeroutlines ) )
    {
        return;
    }
    
    foreach ( outline in self.playeroutlines )
    {
        utility::callsharedfunc( #"airdrop", #"outlinedisable", outline, self );
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x9c558366, Offset: 0x12a21
// Size: 0x128
function function_b9fc17612f972c6f( player, ison )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    if ( function_17c7369ddd51e758() )
    {
        if ( player.team != self.team )
        {
            return;
        }
        
        bitindex = function_26adae1bce6dc7e9();
        isbitset = ( player getclientomnvar( "scriptable_crate_outline_mask" ) & 1 << bitindex ) > 0;
        InvalidOpCode( 0x5e, isbitset, ison );
        // Unknown operator ( 0x5e, t11, Black Ops 7 )
    }
    
    if ( !isdefined( self.playeroutlines ) )
    {
        return;
    }
    
    if ( !ison )
    {
        if ( !isdefined( self.var_d056228c95a8f722 ) )
        {
            self.var_d056228c95a8f722 = [];
        }
        
        self.var_d056228c95a8f722[ self.var_d056228c95a8f722.size ] = player;
    }
    else
    {
        if ( !isdefined( self.var_d056228c95a8f722 ) )
        {
            return;
        }
        
        if ( !arraycontains( self.var_d056228c95a8f722, player ) )
        {
            return;
        }
        
        self.var_d056228c95a8f722 = arrayremove( self.var_d056228c95a8f722, player );
    }
    
    function_d05fd8ff47dcfbce( player.team );
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0xaa3cb2f3, Offset: 0x12b51
// Size: 0xb1, Type: bool
function private function_291762b3fcfef0fb( team )
{
    if ( !getdvarint( @"hash_512579d69cfe8e6f", 1 ) )
    {
        return false;
    }
    
    if ( !isdefined( self ) || self.isdestroyed || !self isscriptableinstance() )
    {
        return false;
    }
    
    if ( !self.var_506f162fae5199cc )
    {
        return false;
    }
    
    if ( !self getscriptablehaspart( "outline" ) )
    {
        return false;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return false;
    }
    
    currentmask = level.cratedata.var_48f65f7b1c01c1c0[ team ] ?? 0;
    fullyused = !function_87482b004f694707( currentmask, 4 );
    
    if ( fullyused )
    {
        return false;
    }
    
    return true;
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0x5a7af28a, Offset: 0x12c0b
// Size: 0x40, Type: bool
function private function_17c7369ddd51e758()
{
    if ( !isdefined( self ) || self.isdestroyed || !self isscriptableinstance() )
    {
        return false;
    }
    
    if ( self getscriptablehaspart( "outline" ) )
    {
        return ( self getscriptablepartstate( "outline" ) != "none" );
    }
    
    return false;
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0xe0cf9611, Offset: 0x12c54
// Size: 0xb0
function private function_6dd4e1ae9bd36f78( team )
{
    if ( !isdefined( level.cratedata.var_48f65f7b1c01c1c0[ team ] ) )
    {
        level.cratedata.var_48f65f7b1c01c1c0[ team ] = 0;
    }
    
    [ bitindex, newmask ] = function_532b9ad63eaa313( level.cratedata.var_48f65f7b1c01c1c0[ team ], 4 );
    level.cratedata.var_48f65f7b1c01c1c0[ team ] = newmask;
    self setscriptablepartstate( "outline", "spawn_wave_" + bitindex );
    return bitindex;
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0xb899813f, Offset: 0x12d0d
// Size: 0x6d
function private function_70eb23b34377abd2( team )
{
    bitindex = function_26adae1bce6dc7e9();
    self setscriptablepartstate( "outline", "none" );
    newmask = function_4678646c237e8994( level.cratedata.var_48f65f7b1c01c1c0[ team ], bitindex );
    level.cratedata.var_48f65f7b1c01c1c0[ team ] = newmask;
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0x7ec87fb1, Offset: 0x12d82
// Size: 0x37
function private function_26adae1bce6dc7e9()
{
    outlinestate = self getscriptablepartstate( "outline" );
    waveindex = getsubstr( outlinestate, "spawn_wave_".size, outlinestate.size );
    return int( waveindex );
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0x6138143a, Offset: 0x12dc2
// Size: 0x50
function private function_294d1f3b431a9470( player )
{
    if ( !isdefined( player.team ) || player.team == "spectator" || player.team == "codcaster" )
    {
        return;
    }
    
    thread crateoutlineonplayerspawned( player );
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0x936b6624, Offset: 0x12e1a
// Size: 0xaa
function private crateoutlineonplayerspawned( player )
{
    player notify( #"crateoutlineonplayerspawned" );
    player endon( #"crateoutlineonplayerspawned" );
    player endon( #"disconnect" );
    player waittill( #"spawned_player" );
    
    if ( isdefined( level.cratedata.var_48f65f7b1c01c1c0 ) )
    {
        numcrates = level.cratedata.var_48f65f7b1c01c1c0[ player.team ];
        
        if ( numcrates > 0 )
        {
            mask = ( 1 << numcrates ) - 1;
            player setclientomnvar( "scriptable_crate_outline_mask", mask );
        }
    }
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0x93998b42, Offset: 0x12ecc
// Size: 0x205
function private function_d05fd8ff47dcfbce( team )
{
    foreach ( outlineid in self.playeroutlines )
    {
        if ( isdefined( self.outlines ) && isdefined( self.outlines[ outlineid ] ) && isdefined( self.outlines[ outlineid ].playersvisibleto ) )
        {
            utility::callsharedfunc( #"outline", #"outlinedisable", outlineid, self );
            self.playeroutlines = arrayremove( self.playeroutlines, outlineid );
            totalteamplayers = level.teamdata[ team ][ "players" ];
            var_b169491a7be42627 = totalteamplayers;
            
            foreach ( teammate in totalteamplayers )
            {
                if ( arraycontains( self.var_d056228c95a8f722, teammate ) )
                {
                    var_b169491a7be42627 = arrayremove( var_b169491a7be42627, teammate );
                }
            }
            
            if ( var_b169491a7be42627.size > 0 )
            {
                if ( utility::issharedfuncdefined( #"outline", #"outlineenableforteam" ) )
                {
                    self.playeroutlines[ self.playeroutlines.size ] = [[ utility::getsharedfunc( #"outline", #"outlineenableforteam" ) ]]( self, self.team, "outline_depth_cyan", "level_script", self.var_d056228c95a8f722 );
                }
            }
            
            break;
        }
    }
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0x50f12928, Offset: 0x130d9
// Size: 0x41
function private function_87482b004f694707( mask, var_88e79776618f505e )
{
    assert( var_88e79776618f505e > 0 && var_88e79776618f505e < 64 );
    fullmask = ( 1 << var_88e79776618f505e ) - 1;
    InvalidOpCode( 0x5e, mask, fullmask );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0xcb82d44e, Offset: 0x13126
// Size: 0x81
function private function_532b9ad63eaa313( mask, var_88e79776618f505e )
{
    assert( var_88e79776618f505e > 0 && var_88e79776618f505e < 64 );
    bitindex = 0;
    
    while ( bitindex < var_88e79776618f505e )
    {
        alreadyoccupied = 1 << bitindex & mask;
        
        if ( alreadyoccupied == 0 )
        {
            newmask = 1 << bitindex | mask;
            return [ bitindex, newmask ];
        }
        
        bitindex += 1;
    }
}

// Namespace airdrop
// Params 2, eflags: 0x4
// Checksum 0x4e78812, Offset: 0x131af
// Size: 0x2b
function private function_4678646c237e8994( mask, bitpos )
{
    keepmask = ~( 1 << bitpos );
    return mask & keepmask;
}

// Namespace airdrop
// Params 0
// Checksum 0x8b306cf7, Offset: 0x131e3
// Size: 0x170
function function_79183053f61d4891()
{
    level.cratedata.luckykillstreakweights = [];
    var_787f9eba601091aa = "mp/mp_killstreaktdm_killstreaklist_mgl.csv";
    var_701ae5d68590c8dd = tablelookupgetnumrows( var_787f9eba601091aa );
    
    if ( !isdefined( var_701ae5d68590c8dd ) )
    {
        return;
    }
    
    ks_name_column = 0;
    ks_chance_column = 1;
    ks_time_column = 2;
    
    for ( i = 0; i < var_701ae5d68590c8dd ; i++ )
    {
        ks_name = tablelookupbyrow( var_787f9eba601091aa, i, ks_name_column );
        ks_chance = int( tablelookupbyrow( var_787f9eba601091aa, i, ks_chance_column ) );
        ks_time = int( tablelookupbyrow( var_787f9eba601091aa, i, ks_time_column ) );
        
        if ( ks_time == 0 )
        {
            level.cratedata.luckykillstreakweights[ ks_name ] = ks_chance;
            continue;
        }
        
        if ( !isdefined( level.cratedata.var_ddc8951034fe1035 ) )
        {
            level.cratedata.var_ddc8951034fe1035 = [];
        }
        
        if ( !isdefined( level.cratedata.var_ddc8951034fe1035[ ks_time ] ) )
        {
            level.cratedata.var_ddc8951034fe1035[ ks_time ] = [];
        }
        
        level.cratedata.var_ddc8951034fe1035[ ks_time ][ ks_name ] = ks_chance;
    }
    
    if ( isdefined( level.cratedata.var_ddc8951034fe1035 ) )
    {
        level thread function_28c3aa703a7923f6();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xaeb86a29, Offset: 0x1335b
// Size: 0x1aa
function function_28c3aa703a7923f6()
{
    if ( !isdefined( level.cratedata.var_ddc8951034fe1035 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    prematchdonetime = gettime();
    
    while ( true )
    {
        elapsedtime = int( ( gettime() - prematchdonetime ) / 1000 );
        waittime = 0;
        
        foreach ( ks_time, ks_info in level.cratedata.var_ddc8951034fe1035 )
        {
            if ( ks_time <= elapsedtime )
            {
                foreach ( ks_name, ks_chance in ks_info )
                {
                    level.cratedata.luckykillstreakweights[ ks_name ] = ks_chance;
                }
                
                level.cratedata.var_ddc8951034fe1035[ ks_time ] = undefined;
                continue;
            }
            
            if ( waittime == 0 || ks_time < waittime )
            {
                waittime = ks_time;
            }
        }
        
        waittime -= elapsedtime;
        
        if ( waittime < 0 )
        {
            return;
        }
        
        wait waittime;
    }
}

// Namespace airdrop
// Params 1
// Checksum 0x8b4b70c9, Offset: 0x1350d
// Size: 0x6d
function function_b77b0ab5e9d69f35( var_e0a275ac51a62494 )
{
    assert( isdefined( level.cratedata ), "<dev string:xaa5>" );
    assert( isdefined( level.cratedata.luckykillstreakweights ), "<dev string:xadf>" );
    streakname = getrandomkeyfromweightsarray( level.cratedata.luckykillstreakweights, var_e0a275ac51a62494 );
    return streakname;
}

// Namespace airdrop
// Params 3, eflags: 0x4
// Checksum 0x46630c20, Offset: 0x13583
// Size: 0x82
function private function_1e43ba09f65e2eb6( part, state, var_c756319095dad4a5 )
{
    if ( self.useteammodels )
    {
        if ( self.var_b410f5d243619d25 isscriptable() )
        {
            self.var_b410f5d243619d25 setscriptablepartstate( part, state, var_c756319095dad4a5 );
        }
        
        if ( self.var_88accb953478a622 isscriptable() )
        {
            self.var_88accb953478a622 setscriptablepartstate( part, state, var_c756319095dad4a5 );
        }
    }
    
    if ( self getscriptablehaspart( part ) )
    {
        self setscriptablepartstate( part, state, var_c756319095dad4a5 );
    }
}

// Namespace airdrop
// Params 3, eflags: 0x4
// Checksum 0xa085ab84, Offset: 0x1360d
// Size: 0x60
function private function_5ea6360b53f7b8e9( owner, streakinfo, crates )
{
    if ( crates.size == 0 )
    {
        wait 60;
    }
    else
    {
        crate = utility::array_get_first_item( crates );
        
        if ( isdefined( crate ) )
        {
            crate utility::waittill_notify_or_timeout( "crate_dropped", 60 );
        }
    }
    
    owner killstreak_utility::recordkillstreakendstats( streakinfo );
}

// Namespace airdrop
// Params 4
// Checksum 0x2eec1742, Offset: 0x13675
// Size: 0x350
function function_bd2eb7c465e874f7( destination, var_81c72f5d443af135, owner, var_9f37e1fb0444d037 = 0 )
{
    droppositions = [];
    var_28e87a1f02e07cc6 = 25000;
    var_690718aebbf50da7 = 65;
    var_440140a1c3dd57ef = 200;
    caststart = destination + ( 0, 0, var_28e87a1f02e07cc6 );
    
    /#
    #/
    
    cratewidth = 50;
    currring = var_9f37e1fb0444d037 ? 2 : 1;
    theta = 0;
    radius = 0;
    maxrings = 7;
    testposition = undefined;
    densitymodifier = 1.5;
    var_dc094266722ef0cc = 0;
    ignorelist = getcratedropignorelist();
    contentoverride = trace::create_contents( 0, 1, 0, 1, 0, 0 );
    caststart = destination + ( 0, 0, var_28e87a1f02e07cc6 );
    sampleposition = destination;
    castend = destination - ( 0, 0, var_440140a1c3dd57ef );
    droptrace = trace::sphere_trace( caststart, castend, 50, ignorelist, contentoverride );
    
    if ( droptrace[ "hittype" ] != "hittype_none" && isdefined( droptrace[ "position" ] ) )
    {
        testposition = droptrace[ "position" ];
        heightdelta = abs( testposition[ 2 ] - sampleposition[ 2 ] );
        
        if ( !outofbounds::ispointinoutofbounds( testposition, owner.team ) && !utility::ispointinwater( testposition ) && heightdelta > 0 && heightdelta < var_690718aebbf50da7 || heightdelta < 0 && abs( heightdelta ) < var_440140a1c3dd57ef )
        {
            droppositions[ droppositions.size ] = testposition;
        }
    }
    
    while ( droppositions.size < var_81c72f5d443af135 && currring <= maxrings )
    {
        radius = cratewidth * densitymodifier * currring;
        offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
        
        if ( !var_dc094266722ef0cc )
        {
            caststart = destination + offset + ( 0, 0, var_28e87a1f02e07cc6 );
            sampleposition = destination + offset;
            castend = destination + offset - ( 0, 0, var_440140a1c3dd57ef );
            droptrace = trace::sphere_trace( caststart, castend, 50, ignorelist, contentoverride );
            
            if ( droptrace[ "hittype" ] != "hittype_none" && isdefined( droptrace[ "position" ] ) )
            {
                testposition = droptrace[ "position" ];
                heightdelta = abs( testposition[ 2 ] - sampleposition[ 2 ] );
                
                if ( !outofbounds::ispointinoutofbounds( testposition, owner.team ) && !utility::ispointinwater( testposition ) && heightdelta > 0 && heightdelta < var_690718aebbf50da7 || heightdelta < 0 && abs( heightdelta ) < var_440140a1c3dd57ef )
                {
                    droppositions[ droppositions.size ] = testposition;
                    var_dc094266722ef0cc = 1;
                }
            }
        }
        else
        {
            var_dc094266722ef0cc = 0;
        }
        
        var_b06806e8544a1176 = cratewidth * densitymodifier * 2 / radius;
        var_e67529a936be4ce1 = math::radians_to_degrees( var_b06806e8544a1176 );
        theta += var_e67529a936be4ce1;
        
        if ( theta + var_e67529a936be4ce1 / 2 >= 360 )
        {
            theta = 360;
        }
        
        if ( theta >= 360 )
        {
            theta = 0;
            currring += 1;
        }
    }
    
    return droppositions;
}

// Namespace airdrop
// Params 1, eflags: 0x4
// Checksum 0xc01d755f, Offset: 0x139ce
// Size: 0x6c
function private function_834dc48056bc6679( crate )
{
    if ( getdvar( @"hash_9c93e935b4a4d781", "battle_royale_loadout" ) == crate.cratetype )
    {
        crate.var_be7118f1d4f4f6e3 = { #var_22a3293c13fba1ab:[], #var_9729e58485e7513f:crate.angles, #var_6ba08fde38270171:crate.origin };
    }
}

// Namespace airdrop
// Params 2
// Checksum 0x1c36562e, Offset: 0x13a42
// Size: 0x52
function function_93131a7c7bf0090e( crate, keyvalues )
{
    if ( crate.var_be7118f1d4f4f6e3 )
    {
        crate.var_be7118f1d4f4f6e3.var_22a3293c13fba1ab[ crate.var_be7118f1d4f4f6e3.var_22a3293c13fba1ab.size ] = keyvalues;
    }
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0xfa462c98, Offset: 0x13a9c
// Size: 0x39
function private function_8ee48acd584ff181()
{
    crate = self;
    level endon( #"game_ended" );
    crate utility::waittill_any_timeout( 10, "death", "airdrop_crate_settled" );
    crate function_a9b7ca1978b882c4();
}

// Namespace airdrop
// Params 0, eflags: 0x4
// Checksum 0xf984344d, Offset: 0x13add
// Size: 0x2a3
function private function_a9b7ca1978b882c4()
{
    crate = self;
    var_43f36d8eb0f46e02 = 60;
    var_bf80142f6527339a = 30;
    
    if ( !crate.var_be7118f1d4f4f6e3 )
    {
        return;
    }
    
    groundorigin = getclosestpointonnavmesh( crate.origin );
    
    if ( !isdefined( groundorigin ) || distance2dsquared( groundorigin, crate.origin ) > squared( var_bf80142f6527339a ) )
    {
        groundorigin = utility::drop_to_ground( ( crate.origin[ 0 ], crate.origin[ 1 ], 0 ) );
    }
    
    var_e19d3f45bafc368f = level.br_level.var_cd92896f34e2d8ef ?? -2400;
    var_f2874a5ccd790b9c = isdefined( groundorigin ) && groundorigin[ 2 ] - crate.origin[ 2 ] > var_43f36d8eb0f46e02;
    var_358b9fa60aa8e677 = var_e19d3f45bafc368f - crate.origin[ 2 ] > var_43f36d8eb0f46e02;
    
    if ( var_f2874a5ccd790b9c || var_358b9fa60aa8e677 )
    {
        var_faed6c42757150ae = "";
        
        for ( i = 0; i < crate.var_be7118f1d4f4f6e3.var_22a3293c13fba1ab.size ; i++ )
        {
            if ( i > 0 )
            {
                var_faed6c42757150ae += ", ";
            }
            
            frame = crate.var_be7118f1d4f4f6e3.var_22a3293c13fba1ab[ i ];
            var_faed6c42757150ae += "{";
            
            foreach ( key, value in frame )
            {
                var_faed6c42757150ae += "\"" + key + "\": \"" + value + "\", ";
            }
            
            var_faed6c42757150ae = getsubstr( var_faed6c42757150ae, 0, var_faed6c42757150ae.size - 2 );
            var_faed6c42757150ae += "}";
        }
        
        script::function_2e2007575f92910d( "[UNDERGROUND_AIRDROP_CRATE] {\"crate\":{\"crateType\":\"" + crate.cratetype + "\", \"origin\":\"" + crate.origin + "\", \"angles\":\"" + crate.angles + "\"}, \"originOnCreate\":\"" + crate.var_be7118f1d4f4f6e3.var_6ba08fde38270171 + "\", \"anglesOnCreate\":\"" + crate.var_be7118f1d4f4f6e3.var_9729e58485e7513f + "\", \"callstackOnCreate\":[" + var_faed6c42757150ae + "]}" );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x82ce7b02, Offset: 0x13d88
// Size: 0xeb
function function_7807eb9e1ad62087()
{
    leveldata = getleveldata( "care_package_loot_container" );
    bundle = level.streakglobals.streakbundles[ "airdrop" ];
    leveldata.capturestring = &"mp/br_crate";
    leveldata.basemodel = bundle.var_520def0bab23e6bc;
    leveldata.var_bd47ae8cbb082196 = 1;
    leveldata.hasnointeraction = 1;
    leveldata.usepriority = -1;
    leveldata.activatecallback = &function_1a62545e167c690f;
    leveldata.capturecallback = &function_7d9755eba62ae526;
    level.scr_anim[ "care_package" ][ "care_package_capture_open_idle" ][ 0 ] = bundle.var_19944295a5934c11.animname.id;
}

// Namespace airdrop
// Params 1
// Checksum 0x3970ae6b, Offset: 0x13e7b
// Size: 0x1f2
function function_1a62545e167c690f( isfirstactivation )
{
    if ( !isfirstactivation )
    {
        return;
    }
    
    crate = self;
    crate.supportsreroll = 0;
    crate.cratetype = "br_supply_drops_common";
    crate setscriptablepartstate( "body", "partially_open_usable" );
    crate.alreadyopened = 0;
    crate.physicsactivated = 0;
    crate.animname = "care_package";
    crate animation::setanimtree();
    waitframe();
    cratescriptable = crate getlinkedscriptableinstance();
    cratescriptable setscriptablepartstate( "body", "partially_open_usable" );
    extraloot = crate.owner common_cache::smartloot( cratescriptable );
    
    if ( extraloot )
    {
        common_cache::function_a09e7cf5bad99b64( cratescriptable, extraloot, 1 );
    }
    else
    {
        var_16d763e03ef0bbc = getscriptbundlefieldvalues( hashcat( %"itemspawnzonedef:", level.commonitem.var_f4a0cd0e44af4832 ), [ #"hash_32a95aa45b53f917" ] );
        
        foreach ( cacheentry in var_16d763e03ef0bbc.var_a72bc938c97bce90 )
        {
            if ( cacheentry.scriptkey == #"dmz_care_package" )
            {
                common_cache::function_e69b07abaa3e643b( cratescriptable, hashcat( %"itemspawnlist:", cacheentry.itemspawnlist ), cacheentry.itemspawnquantity, level.players );
                break;
            }
        }
    }
    
    cratescriptable callback::add( #"cache_opened", &function_607d1b29480bd4a6 );
    crate thread function_376b6314e6002da2();
}

// Namespace airdrop
// Params 1
// Checksum 0x8de63b27, Offset: 0x14075
// Size: 0xa9
function function_607d1b29480bd4a6( params )
{
    crate = params.cache.entity;
    
    if ( crate.alreadyopened )
    {
        return;
    }
    
    crate.alreadyopened = 1;
    animtime = getanimlength( level.scr_anim[ "care_package" ][ "care_package_capture" ] );
    
    if ( isdefined( animtime ) )
    {
        animtime = max( 0, animtime );
    }
    
    crate thread animation::anim_single_solo( crate, "care_package_capture" );
    
    if ( isdefined( animtime ) )
    {
        wait animtime;
    }
    
    if ( isdefined( crate ) )
    {
        crate thread animation::anim_loop_solo( crate, "care_package_capture_open_idle" );
    }
}

// Namespace airdrop
// Params 0
// Checksum 0xa852760a, Offset: 0x14126
// Size: 0x7b
function function_376b6314e6002da2()
{
    self notify( #"hash_75553cc24f8f3084" );
    self endon( #"hash_75553cc24f8f3084" );
    cratescriptable = self getlinkedscriptableinstance();
    
    while ( isdefined( cratescriptable ) )
    {
        if ( common_cache::iscontainerempty( cratescriptable ) )
        {
            self setscriptablepartstate( #"capture", #"start", 0 );
            waitframe();
            self setscriptablepartstate( #"capture", #"fade", 0 );
            thread deletecrateimmediate();
            return;
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x498eb258, Offset: 0x141a9
// Size: 0x2
function function_7d9755eba62ae526()
{
    
}

// Namespace airdrop
// Params 0
// Checksum 0x827df07f, Offset: 0x141b3
// Size: 0x107
function function_35f1e9acdb5f8b73()
{
    self endon( #"death" );
    self endon( #"hash_59d62d244d792cf9" );
    owner = self.owner;
    
    if ( !owner )
    {
        return;
    }
    
    owner endon( #"disconnect" );
    thread function_4e2bbbc138177b32();
    buttontime = 0;
    maxdistancesquared = 16384;
    
    while ( true )
    {
        if ( owner usebuttonpressed() )
        {
            buttontime = 0;
            
            while ( owner usebuttonpressed() )
            {
                buttontime += level.framedurationseconds;
                waitframe();
            }
            
            if ( buttontime >= 0.5 )
            {
                continue;
            }
            
            buttontime = 0;
            
            while ( !owner usebuttonpressed() && buttontime < 0.5 )
            {
                buttontime += level.framedurationseconds;
                waitframe();
            }
            
            if ( buttontime >= 0.5 )
            {
                continue;
            }
            
            if ( distance2dsquared( owner.origin, self.origin ) > maxdistancesquared )
            {
                continue;
            }
            
            self notify( #"crate_reroll" );
            return;
        }
        
        waitframe();
    }
}

// Namespace airdrop
// Params 0
// Checksum 0x30d63cc4, Offset: 0x142c2
// Size: 0x129
function function_4e2bbbc138177b32()
{
    self endon( #"death" );
    self endon( #"hash_59d62d244d792cf9" );
    owner = self.owner;
    
    if ( !owner )
    {
        return;
    }
    
    owner endon( #"disconnect" );
    self waittill( #"crate_reroll" );
    self.data.streakname = getrandomkillstreak( self.data.streakname );
    
    if ( isdefined( self.var_faad3f6fb94da1b3 ) && isdefined( self.owner ) )
    {
        rewardbundle = killstreak_utility::function_f943c0602acdc2af( self.data.streakname );
        imageoverride = rewardbundle.overheadicon;
        
        if ( imageoverride )
        {
            function_f38e1899f2e7828e( imageoverride, self.owner );
        }
    }
    
    /#
        thread utility::debugprinttoscreen( "<dev string:xb28>" + self.data.streakname, 10, 1900, 1000 );
    #/
    
    self.supportsreroll = 0;
    self.var_3a9cbf7a21dc0849 disableplayeruseforallplayers();
}

// Namespace airdrop
// Params 0
// Checksum 0xe4f6cc84, Offset: 0x143f3
// Size: 0x64
function function_328efb7329a5f244()
{
    var_3a9cbf7a21dc0849 = spawn( "script_model", self.origin );
    var_3a9cbf7a21dc0849 linkto( self );
    var_3a9cbf7a21dc0849 makeusable();
    var_3a9cbf7a21dc0849 disableplayeruseforallplayers();
    var_3a9cbf7a21dc0849.owner = self.owner;
    var_3a9cbf7a21dc0849.var_a1e27814a6bc19d5 = 1;
    self.var_3a9cbf7a21dc0849 = var_3a9cbf7a21dc0849;
}

