// scripts\mp\common\killstreaks\juggernaut.gsc  (hash_2ad7dff7e51218da.gscc) (size: 14385 Bytes / 0x3831 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x436715b3 (1130829235)
// size ...... 14385 (0x3831)
// includes .. 22  (offset: 0x34b5)
// strings ... 40  (offset: 0x3565)
// dev strs .. 7   (offset: 0x37dd)
// exports ... 34  (offset: 0x20ed)
// cseg ...... 0x31d + 0x1dd0 (0x20ed)
// imports ... 121 (offset: 0x263d)
// animtree1 . 0   (offset: 0x3831)
// animtree2 . 0   (offset: 0x3831)
#using script_13865ca76df87ea;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\juggernaut;
#using scripts\mp\mtx_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons;

#namespace juggernaut;

// Namespace juggernaut
// Params 0
// Checksum 0xadbd1958, Offset: 0x33b
// Size: 0x101
function init()
{
    if ( utility::issharedfuncdefined( #"juggernaut", #"init" ) )
    {
        [[ utility::getsharedfunc( #"juggernaut", #"init" ) ]]();
    }
    
    val::group_register( "fakeJugg", [ "slide", "prone" ] );
    initmarker();
    init_jugg_vo();
    
    /#
        setdevdvarifuninitialized( @"hash_3f1bd355bf340abb", 0 );
        setdevdvarifuninitialized( @"hash_841d9a60f75a35c8", 0 );
    #/
    
    if ( !utility::callsharedfunc( #"game", #"isjuggermoshgamemode" ) )
    {
        killstreak_utility::registervisibilityomnvarforkillstreak( "juggernaut", "mask_on", 1 );
        killstreak_utility::registervisibilityomnvarforkillstreak( "juggernaut", "mask_damage_low", 2 );
        killstreak_utility::registervisibilityomnvarforkillstreak( "juggernaut", "mask_damage_med", 3 );
        killstreak_utility::registervisibilityomnvarforkillstreak( "juggernaut", "mask_damage_high", 4 );
        killstreak_utility::registervisibilityomnvarforkillstreak( "juggernaut", "mask_damage_critical", 5 );
    }
}

// Namespace juggernaut
// Params 4
// Checksum 0x88bbbe54, Offset: 0x444
// Size: 0x107
function function_2ef6e7bd444b89ea( config, headpct = 0.9, torsopct = 0.5, limbpct = 0.1 )
{
    config.head_health = config.maxhealth * headpct;
    torsohealth = config.maxhealth * torsopct;
    config.torso_upper_health = torsohealth;
    config.torso_lower_health = torsohealth;
    limbhealth = config.maxhealth * limbpct;
    config.right_upper_arm_health = limbhealth;
    config.right_lower_arm_health = limbhealth;
    config.left_upper_arm_health = limbhealth;
    config.left_lower_arm_health = limbhealth;
    config.right_leg_health = limbhealth;
    config.left_leg_health = limbhealth;
}

// Namespace juggernaut
// Params 1
// Checksum 0xe96c3ea5, Offset: 0x553
// Size: 0xcd
function function_7a7d89de25fa010c( bundle )
{
    assert( bundle.juggernautconfig, "<dev string:x24>" );
    config = jugg_createconfig( bundle.juggernautconfig );
    var_52603d9eb229bc67 = getscriptbundle( bundle.juggernautconfig );
    
    if ( var_52603d9eb229bc67.var_2f3a1d7605311b4f )
    {
        function_7924c531a3aff66e( config.classstruct.loadoutprimary, var_52603d9eb229bc67.var_2f3a1d7605311b4f, config, 1 );
    }
    
    if ( var_52603d9eb229bc67.var_4fec5f888e9a96df )
    {
        function_7924c531a3aff66e( config.classstruct.loadoutsecondary, var_52603d9eb229bc67.var_4fec5f888e9a96df, config, 0 );
    }
    
    return config;
}

// Namespace juggernaut
// Params 3
// Checksum 0x804710f4, Offset: 0x629
// Size: 0x466
function function_720e16a787ba326f( bundle, baseconfig, blueprintindex )
{
    config = structcopy( baseconfig, 1 );
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    config.deployweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( genericblueprintname, #"deployweapon" );
    primaryweaponname = namespace_de7b719e85d98dcc::genericblueprint_getweaponname( genericblueprintname, #"primaryweapon" );
    var_150394dea7e8048c = namespace_de7b719e85d98dcc::function_6ebf762b1c13c233( genericblueprintname, #"primaryweapon" );
    secondaryweaponname = namespace_de7b719e85d98dcc::genericblueprint_getweaponname( genericblueprintname, #"secondaryweapon" );
    var_659b0011a16c0e1c = namespace_de7b719e85d98dcc::function_6ebf762b1c13c233( genericblueprintname, #"secondaryweapon" );
    lethalequipmentname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"string", #"lethalequipment" );
    tacticalequipmentname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"string", #"tacticalequipment" );
    lethalequipmentblueprintindex = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"string", #"lethalequipmentblueprintindex" );
    tacticalequipmentblueprintindex = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"string", #"tacticalequipmentblueprintindex" );
    suitname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"suit", #"suit" );
    executionname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"execution", #"execution" );
    bodymodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"bodymodel" );
    headmodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"headmodel" );
    viewmodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"viewmodel" );
    cratemodel = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"xmodel", #"cratemodel" );
    usearmorparts = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( genericblueprintname, #"string", #"usearmorparts" );
    config.classstruct.loadoutprimary = "none";
    
    if ( isdefined( primaryweaponname ) )
    {
        config.classstruct.loadoutprimary = primaryweaponname;
    }
    
    config.classstruct.loadoutsecondary = "none";
    
    if ( isdefined( secondaryweaponname ) )
    {
        config.classstruct.loadoutsecondary = secondaryweaponname;
    }
    
    function_7924c531a3aff66e( config.classstruct.loadoutprimary, var_150394dea7e8048c, config, 1 );
    function_7924c531a3aff66e( config.classstruct.loadoutsecondary, var_659b0011a16c0e1c, config, 0 );
    config.classstruct.loadoutequipmentprimary = "none";
    
    if ( isdefined( lethalequipmentname ) )
    {
        config.classstruct.loadoutequipmentprimary = lethalequipmentname;
    }
    
    config.classstruct.loadoutequipmentsecondary = "none";
    
    if ( isdefined( tacticalequipmentname ) )
    {
        config.classstruct.loadoutequipmentsecondary = tacticalequipmentname;
    }
    
    config.classstruct.var_a1191d5606e653f0 = 0;
    
    if ( isdefined( lethalequipmentblueprintindex ) )
    {
        config.classstruct.var_a1191d5606e653f0 = int( lethalequipmentblueprintindex );
    }
    
    config.classstruct.var_9481e959139fe88 = 0;
    
    if ( isdefined( tacticalequipmentblueprintindex ) )
    {
        config.classstruct.var_9481e959139fe88 = int( tacticalequipmentblueprintindex );
    }
    
    config.execution = executionname;
    config.suit = suitname;
    config.bodymodel = bodymodel;
    config.headmodel = headmodel;
    config.viewmodel = viewmodel;
    config.cratemodel = cratemodel;
    config.usearmorparts = isdefined( usearmorparts ) ? int( usearmorparts ) > 0 : 1;
    return config;
}

// Namespace juggernaut
// Params 4
// Checksum 0x6bb40654, Offset: 0xa98
// Size: 0x12f
function function_7924c531a3aff66e( weaponname, blueprintname, config, isprimary )
{
    if ( !isdefined( blueprintname ) || weaponname == "none" )
    {
        return;
    }
    
    blueprintbundle = function_18358df7912f6208( weaponname, blueprintname );
    
    if ( !isdefined( blueprintbundle ) )
    {
        return;
    }
    
    var_ad27c576a9fd9d52 = function_4d465a88a4c974d3( blueprintbundle.lootid );
    weaponrootname = weapon::getweaponrootname( weaponname );
    attachments = [];
    attachmentids = [];
    
    if ( isprimary )
    {
        config.classstruct.loadoutprimaryvariantid = var_ad27c576a9fd9d52;
        config.classstruct.loadoutprimaryattachments = attachments;
        config.classstruct.loadoutprimaryattachmentids = attachmentids;
        return;
    }
    
    config.classstruct.loadoutsecondaryvariantid = var_ad27c576a9fd9d52;
    config.classstruct.loadoutsecondaryattachments = attachments;
    config.classstruct.loadoutsecondaryattachmentids = attachmentids;
}

// Namespace juggernaut
// Params 0
// Checksum 0x78e0a567, Offset: 0xbcf
// Size: 0x9c
function initmarker()
{
    leveldata = airdrop::getleveldata( "juggernaut" );
    leveldata.capturecallback = &oncratecaptured;
    leveldata.destroycallback = &oncratedestroyed;
    leveldata.activatecallback = &oncrateactivated;
    leveldata.minimapicon = "ui_map_icon_jugg_drop";
    leveldata.headicon = "ui_map_icon_jugg_drop";
    leveldata.capturestring = &"killstreaks_hints/jugg_crate_pickup";
    
    if ( !isbrgamemode() )
    {
        leveldata.basemodel = "military_carepackage_03_jugg_mp";
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x263a28cf, Offset: 0xc73
// Size: 0x21
function init_jugg_vo()
{
    game[ "dialog" ][ "juggernaut" + "_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace juggernaut
// Params 3
// Checksum 0x700f3256, Offset: 0xc9c
// Size: 0x5c
function tryusejuggernaut( activateimmediate, var_babeddfae778862b, config )
{
    streakinfo = killstreak_utility::createstreakinfo( "juggernaut", self );
    streakinfo.var_babeddfae778862b = var_babeddfae778862b;
    streakinfo.config = config;
    tryusejuggernautfromstruct( streakinfo, activateimmediate );
}

// Namespace juggernaut
// Params 2
// Checksum 0x29b65e7d, Offset: 0xd00
// Size: 0x157, Type: bool
function tryusejuggernautfromstruct( streakinfo, activateimmediate )
{
    if ( !streakinfo.config )
    {
        if ( level.var_4a236ad5127e311f )
        {
            streakinfo.config = [[ level.var_4a236ad5127e311f ]]();
        }
        else
        {
            streakinfo.config = function_7a7d89de25fa010c( level.streakglobals.streakbundles[ "juggernaut" ] );
        }
    }
    
    if ( !function_11863370c607058c( streakinfo ) )
    {
        return false;
    }
    
    if ( level.killstreaktriggeredfunc && !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
    {
        return false;
    }
    
    if ( !isdefined( activateimmediate ) )
    {
        activateimmediate = getdvarint( @"hash_3f1bd355bf340abb" );
    }
    
    if ( activateimmediate )
    {
        thread activatejugg( streakinfo );
    }
    else
    {
        vehicle_tracking::reserve_vehicle();
        deployweaponobj = makeweapon( "deploy_juggernaut_mp" );
        
        if ( level.var_d6dbcfd3322e6005 )
        {
            streakinfo.var_21f1b0b4d8d3ea8f = level.var_d6dbcfd3322e6005;
        }
        
        deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweaponobj, "grenade_fire", undefined, undefined, &markerthrown );
        
        if ( !deployresult )
        {
            vehicle_tracking::function_4f76f5b4541acef1();
            return false;
        }
    }
    
    if ( level.killstreakbeginusefunc && !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
    {
        return false;
    }
    
    return true;
}

// Namespace juggernaut
// Params 3
// Checksum 0x6a1d23b, Offset: 0xe60
// Size: 0xc8
function markerthrown( streakinfo, weaponobj, projectile )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"incrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"incrementfauxvehiclecount" ) ]]();
    }
    
    projectile.owner = self;
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakinfo.streakname, self.origin );
    }
    
    projectile thread watchmarkeractivate( streakinfo );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    return "success";
}

// Namespace juggernaut
// Params 1
// Checksum 0x4dd8b1c1, Offset: 0xf31
// Size: 0x1c9
function watchmarkeractivate( streakinfo )
{
    level endon( #"game_ended" );
    ownerangles = self.owner.angles;
    owner = self.owner;
    streakinfo.airdroptype = streakinfo.streakname;
    self waittill( #"explode", position );
    
    if ( !owner )
    {
        utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
        vehicle_tracking::function_4f76f5b4541acef1();
        return;
    }
    
    utility::callsharedfunc( #"vehicle", #"decrementfauxvehiclecount" );
    owner thread airdrop::airdrop_playdeploydialog( streakinfo );
    
    if ( !isbrgamemode() )
    {
        streakinfo.vehicleisreserved = 1;
        data = streakinfo;
        scenenode = airdrop::dropcratefromscriptedheli( owner, owner.team, "juggernaut", position, ownerangles, position, data, streakinfo );
        
        if ( !scenenode )
        {
            owner utility::callsharedfunc( #"hud", #"showerrormessage", %"killstreaks/vehicle_refund_killstreak" );
            owner utility::callsharedfunc( #"killstreak", #"awardkillstreakfromstruct", streakinfo.mpstreaksysteminfo, "other" );
        }
        
        return;
    }
    
    vehicle_tracking::function_4f76f5b4541acef1();
    
    if ( isbrgamemode() )
    {
        if ( !level.var_236a38f198a8e72a )
        {
            assertmsg( "<dev string:x75>" + "<dev string:x95>" );
            return;
        }
        
        overridestruct = { #droporigin:position };
        airdrop_scriptbundle::startairdrop( level.var_236a38f198a8e72a, owner, owner.team, overridestruct );
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0x91b13caf, Offset: 0x1102
// Size: 0x22
function oncrateactivated( firstactivation )
{
    if ( firstactivation )
    {
        self setscriptablepartstate( "smoke_cover", "active", 0 );
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0x6938c471, Offset: 0x112c
// Size: 0x174
function oncratecaptured( player )
{
    streakinfo = self.data ? self.data : self.streakinfo;
    
    if ( player.isjuggernaut )
    {
        if ( utility::issharedfuncdefined( #"airdrop", #"awardkillstreak" ) )
        {
            self.streakinfo = streakinfo;
            player [[ utility::getsharedfunc( #"airdrop", #"awardkillstreak" ) ]]( streakinfo.streakname, player, self );
        }
        
        if ( utility::issharedfuncdefined( #"airdrop", #"showkillstreaksplash" ) )
        {
            player [[ utility::getsharedfunc( #"airdrop", #"showkillstreaksplash" ) ]]( streakinfo.streakname, undefined, 1 );
        }
        
        return;
    }
    
    assert( streakinfo.config, "<dev string:xec>" );
    
    if ( streakinfo.config.activatefunc )
    {
        player [[ streakinfo.config.activatefunc ]]( streakinfo );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"juggernaut", #"activatejuggernaut" ) )
    {
        player [[ utility::getsharedfunc( #"juggernaut", #"activatejuggernaut" ) ]]();
        return;
    }
    
    player activatejugg( streakinfo );
}

// Namespace juggernaut
// Params 1
// Checksum 0xf83d9c09, Offset: 0x12a8
// Size: 0x3e
function oncratedestroyed( immediate )
{
    streakinfo = self.data;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace juggernaut
// Params 1
// Checksum 0x1a0cdcb4, Offset: 0x12ee
// Size: 0x151
function activatejugg( streakinfo )
{
    assert( streakinfo.config, "<dev string:x120>" );
    config = streakinfo.config;
    result = jugg_makejuggernaut( config, streakinfo );
    
    if ( !result )
    {
        return 0;
    }
    
    talking_gun::talkinggun_event( self, #"become_juggernaut" );
    mtx_weapon::function_554ad3c9ed9bc64();
    
    if ( self isnightvisionon() && !self.gulag )
    {
        self nightvisionviewoff( 1 );
        self notify( #"night_vision_off" );
    }
    
    battlechatter_mp::playkillstreakdeploydialog( streakinfo.streakname );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_juggernaut", self );
    }
    
    createjuggobjective();
    operator::function_89e5e91ee0fb0836();
    
    if ( !streakinfo.var_babeddfae778862b )
    {
        self setsoundsubmix( "mp_juggernaut", 0.5 );
    }
    
    thread watchforjuggernautgameend( streakinfo );
    thread watchforjuggernautend( streakinfo );
    thread watchforjuggernautdisconnect( streakinfo );
    
    if ( getdvarint( @"hash_452a3eb9af12510c", 1 ) && !isbrgamemode() )
    {
        thread dropminigunondeath();
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0xcf566821, Offset: 0x1447
// Size: 0xfc
function dropminigunondeath()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( !self.juggcontext.juggconfig.classstruct.loadoutprimary )
    {
        assertmsg( "<dev string:x151>" );
        return;
    }
    
    minigunref = self.juggcontext.juggconfig.classstruct.loadoutprimary;
    minigunweapon = weapon_utility::function_d2c8356dc369d9ce( minigunref );
    self giveweapon( minigunweapon );
    droppedgun = self dropitem( minigunweapon );
    
    if ( !isdefined( droppedgun ) )
    {
        self takeallweapons();
        return;
    }
    
    droppedgun.objweapon = minigunweapon;
    droppedgun.targetname = "dropped_weapon";
    droppedgun thread weapons::watchpickup( self );
    waitframe();
    self takeallweapons();
}

// Namespace juggernaut
// Params 1
// Checksum 0x98d89a81, Offset: 0x154b
// Size: 0x72
function watchforjuggernautgameend( streakinfo )
{
    self endon( #"disconnect" );
    self endon( #"juggernaut_end" );
    level waittill( #"game_ended" );
    
    if ( self && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0xa3418f1e, Offset: 0x15c5
// Size: 0x67
function watchforjuggernautend( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    juggcontext = self.juggcontext;
    self waittill( #"juggernaut_end" );
    operator::setgendersoundcontext();
    self clearsoundsubmix( "mp_juggernaut", 0.5 );
    onjuggernautend( streakinfo, juggcontext );
}

// Namespace juggernaut
// Params 2
// Checksum 0xac3352fd, Offset: 0x1634
// Size: 0x61
function onjuggernautend( streakinfo, juggcontext )
{
    if ( !isbrgamemode() )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        streakinfo.expiredbydeath = 1;
        killstreak_utility::recordkillstreakendstats( streakinfo );
    }
    
    mtx_weapon::function_f890ffd15106d12d();
    cleanupjuggobjective( juggcontext );
}

// Namespace juggernaut
// Params 1
// Checksum 0x118c8891, Offset: 0x169d
// Size: 0x4f
function watchforjuggernautdisconnect( streakinfo )
{
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    juggcontext = self.juggcontext;
    self waittill( #"disconnect" );
    cleanupjuggobjective( juggcontext );
}

// Namespace juggernaut
// Params 1
// Checksum 0x63aa4438, Offset: 0x16f4
// Size: 0x1ba
function createjuggobjective( var_88af6173785ba972 )
{
    if ( isbrgamemode() )
    {
        if ( !isdefined( var_88af6173785ba972 ) )
        {
            var_88af6173785ba972 = "playerObjective";
        }
        
        if ( self.gulag )
        {
            thread function_9c38f1c6502444d6( var_88af6173785ba972 );
        }
        else
        {
            self setscriptablepartstate( var_88af6173785ba972, "juggernaut", 0 );
        }
        
        return;
    }
    
    requestfunc = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        requestfunc = utility::getsharedfunc( #"game", #"requestobjectiveid" );
    }
    
    if ( isdefined( requestfunc ) )
    {
        objid = [[ requestfunc ]]( 99 );
        self.juggcontext.juggobjid = objid;
        objidpoolmanager::objective_add_objective( objid, "active", self.origin, "hud_icon_minimap_killstreak_juggernaut" );
        objidpoolmanager::objective_set_play_intro( objid, 0 );
        objidpoolmanager::objective_set_play_outro( objid, 0 );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || isbot( player ) || player == self )
            {
                continue;
            }
            
            objidpoolmanager::objective_playermask_addshowplayer( objid, player );
        }
        
        objidpoolmanager::update_objective_onentity( objid, self );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        
        if ( level.teambased )
        {
            objidpoolmanager::update_objective_ownerteam( objid, self.team );
            return;
        }
        
        objidpoolmanager::update_objective_ownerclient( objid, self );
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0xde1e2cb9, Offset: 0x18b6
// Size: 0x65
function function_9c38f1c6502444d6( var_88af6173785ba972 )
{
    level endon( #"game_ended" );
    self endon( #"juggernaut_end" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_aa4cab92b4f0ae71" );
    self setscriptablepartstate( var_88af6173785ba972, "off", 0 );
    self waittill( #"hash_88b506e95217aeab" );
    self setscriptablepartstate( var_88af6173785ba972, "juggernaut", 0 );
}

// Namespace juggernaut
// Params 2
// Checksum 0xae2161cd, Offset: 0x1923
// Size: 0x8c
function cleanupjuggobjective( juggcontext, var_88af6173785ba972 )
{
    self notify( #"hash_aa4cab92b4f0ae71" );
    
    if ( isdefined( self ) && isbrgamemode() )
    {
        if ( !isdefined( var_88af6173785ba972 ) )
        {
            var_88af6173785ba972 = "playerObjective";
        }
        
        self setscriptablepartstate( var_88af6173785ba972, "off", 0 );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
    {
        [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( juggcontext.juggobjid );
    }
}

// Namespace juggernaut
// Params 2
// Checksum 0x722e0a0a, Offset: 0x19b7
// Size: 0x64
function watchjuggernautweaponenduse( juggernautweaponobject, prevweaponobject )
{
    thread removejuggernautweapononaction( "switched_from_minigun", prevweaponobject );
    thread removejuggernautweapononaction( "minigun_ammo_depleted", prevweaponobject );
    thread removejuggernautweapononaction( "death" );
    thread removejuggernautweapononaction( "scr_change_swim_state" );
    thread watchjuggernautweaponswitch( juggernautweaponobject );
    thread function_98ad0ce857c3fcb9( juggernautweaponobject );
    thread watchjuggernautweaponammo( juggernautweaponobject );
}

// Namespace juggernaut
// Params 1
// Checksum 0x4ff6e8cd, Offset: 0x1a23
// Size: 0xc3
function watchjuggernautweaponswitch( juggernautweaponobject )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_82aae102a5349d66" );
    self endon( #"dropped_minigun" );
    level endon( #"game_ended" );
    self notifyonplayercommand( "manual_switch_from_minigun", "+weapnext" );
    self notifyonplayercommand( "manual_switch_from_minigun", "+weapprev" );
    
    while ( true )
    {
        self waittill( #"manual_switch_from_minigun" );
        
        if ( self getcurrentweapon() != juggernautweaponobject )
        {
            continue;
        }
        
        var_45012c57cd99a5c8 = weapon::getgrenadeinpullback();
        
        if ( var_45012c57cd99a5c8.basename != "none" )
        {
            continue;
        }
        
        self notify( #"switched_from_minigun" );
        break;
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0xba280370, Offset: 0x1aee
// Size: 0x9a
function function_98ad0ce857c3fcb9( juggernautweaponobject )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_82aae102a5349d66" );
    self endon( #"dropped_minigun" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"weapon_pickup", newweaponobj, droppedweaponobj );
        
        if ( self getcurrentweapon() != juggernautweaponobject )
        {
            continue;
        }
        
        if ( !isdefined( droppedweaponobj ) )
        {
            continue;
        }
        
        self notify( #"switched_from_minigun" );
        break;
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0xb03b6be0, Offset: 0x1b90
// Size: 0x7a
function watchjuggernautweaponammo( juggernautweaponobject )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_82aae102a5349d66" );
    self endon( #"dropped_minigun" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        currentweaponclipammo = self getweaponammoclip( juggernautweaponobject );
        
        if ( currentweaponclipammo <= 0 )
        {
            self notify( #"minigun_ammo_depleted" );
            break;
        }
        
        waitframe();
    }
}

// Namespace juggernaut
// Params 2
// Checksum 0x626a1786, Offset: 0x1c12
// Size: 0x55
function removejuggernautweapononaction( action, prevweaponobject )
{
    self endon( #"disconnect" );
    self endon( #"hash_82aae102a5349d66" );
    self endon( #"dropped_minigun" );
    level endon( #"game_ended" );
    self waittill( action );
    dropjuggernautweapon( action, prevweaponobject );
}

// Namespace juggernaut
// Params 2
// Checksum 0xa3ba8cfa, Offset: 0x1c6f
// Size: 0x1d9
function dropjuggernautweapon( action, prevweaponobject )
{
    if ( !self.var_94074bee8ae28b5e )
    {
        assertmsg( "<dev string:x1b5>" );
        return;
    }
    
    minigunweapon = self.var_94074bee8ae28b5e;
    self.pickedupcoreminigun = undefined;
    self.var_94074bee8ae28b5e = undefined;
    self.minigunprevweaponobject = undefined;
    self.playerstreakspeedscale = undefined;
    
    if ( common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
        common::function_65276d8c156b2ec9( 2 );
    }
    
    weapons::updatemovespeedscale();
    val::group_set( "fakeJugg", 1 );
    
    if ( !level.disablemount )
    {
        val::set( "fakeJugg", "mount_top", 1 );
        val::set( "fakeJugg", "mount_side", 1 );
    }
    
    if ( action == "switched_from_minigun" || action == "used_ammo_box" || action == "death" )
    {
        if ( self hasweapon( minigunweapon ) && getdvarint( @"hash_452a3eb9af12510c", 1 ) )
        {
            droppedgun = self dropitem( minigunweapon );
            droppedgun.objweapon = minigunweapon;
            droppedgun.targetname = "dropped_weapon";
            droppedgun thread weapons::watchpickup( self );
        }
    }
    else if ( action == "minigun_ammo_depleted" )
    {
        if ( self hasweapon( minigunweapon ) )
        {
            thread delaytakeminigun( 0.5, minigunweapon );
        }
    }
    else if ( action == "scr_change_swim_state" )
    {
        if ( self hasweapon( minigunweapon ) )
        {
            oldammo = self getweaponammoclip( minigunweapon );
            self takeweapon( minigunweapon );
            thread function_fa4385fa5cb20ccc( action, minigunweapon, oldammo );
        }
    }
    
    if ( isdefined( prevweaponobject ) )
    {
        self.lastdroppableweaponobj = prevweaponobject;
        self switchtoweapon( prevweaponobject );
    }
    
    self notify( #"dropped_minigun" );
}

// Namespace juggernaut
// Params 2
// Checksum 0x13585f2d, Offset: 0x1e50
// Size: 0x3e
function delaytakeminigun( delaytime, minigunweapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( delaytime );
    self takeweapon( minigunweapon );
}

// Namespace juggernaut
// Params 3
// Checksum 0x5e7a5b62, Offset: 0x1e96
// Size: 0xd5
function function_fa4385fa5cb20ccc( action, minigunweapon, oldammo )
{
    self endon( #"death_or_disconnect" );
    self waittill( action );
    
    while ( true )
    {
        var_45012c57cd99a5c8 = weapon::getgrenadeinpullback();
        
        if ( !self isswimming() && !( isdefined( self.carryobject ) && self.carryobject.carryobjectasset == "hostage_rescue" ) )
        {
            self giveweapon( minigunweapon );
            self switchtoweaponimmediate( minigunweapon );
            self setweaponammoclip( minigunweapon, oldammo );
            previousweapon = self.lastdroppableweaponobj;
            
            if ( !isdefined( previousweapon ) )
            {
                [ previousweapon ] = inventory_utility::getcurrentprimaryweaponsminusalt();
            }
            
            juggernautweaponpickedup( minigunweapon, previousweapon );
            break;
        }
        
        waitframe();
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0x7c5c352c, Offset: 0x1f73
// Size: 0x6d, Type: bool
function function_11863370c607058c( streakinfo )
{
    if ( getdvarint( @"hash_e33f3513a88f530c", 0 ) )
    {
        return true;
    }
    
    if ( killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= killstreak::maxvehiclesallowed() )
    {
        utility::callsharedfunc( #"hud", #"showerrormessage", %"KILLSTREAKS/TOO_MANY_VEHICLES" );
        return false;
    }
    
    return true;
}

// Namespace juggernaut
// Params 2
// Checksum 0x5a73de28, Offset: 0x1fe9
// Size: 0x104
function juggernautweaponpickedup( juggernautweaponobject, prevweaponobject )
{
    if ( self.isjuggernaut )
    {
        return;
    }
    
    if ( self.var_94074bee8ae28b5e )
    {
        maxclipammo = weaponclipsize( prevweaponobject );
        self setweaponammoclip( prevweaponobject, maxclipammo );
        return;
    }
    
    self.pickedupcoreminigun = 1;
    self.var_94074bee8ae28b5e = juggernautweaponobject;
    self.minigunprevweaponobject = prevweaponobject;
    self.playerstreakspeedscale = jugg_getmovespeedscalar();
    
    if ( isdefined( self.playerstreakspeedscale ) && !common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
    }
    
    weapons::updatemovespeedscale();
    val::group_set( "fakeJugg", 0 );
    
    if ( !level.disablemount )
    {
        val::set( "fakeJugg", "mount_top", 0 );
        val::set( "fakeJugg", "mount_side", 0 );
    }
    
    watchjuggernautweaponenduse( juggernautweaponobject, prevweaponobject );
}

