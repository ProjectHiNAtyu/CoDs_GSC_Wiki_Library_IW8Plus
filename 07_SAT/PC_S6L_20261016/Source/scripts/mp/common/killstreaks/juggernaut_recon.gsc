// scripts\mp\common\killstreaks\juggernaut_recon.gsc  (hash_10f5cc48f3f9d862.gscc) (size: 9552 Bytes / 0x2550 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26ca7fc6 (650805190)
// size ...... 9552 (0x2550)
// includes .. 11  (offset: 0x23d4)
// strings ... 18  (offset: 0x242c)
// dev strs .. 2   (offset: 0x2538)
// exports ... 26  (offset: 0x1728)
// cseg ...... 0x1a6 + 0x1582 (0x1728)
// imports ... 69  (offset: 0x1b38)
// animtree1 . 0   (offset: 0x2550)
// animtree2 . 0   (offset: 0x2550)
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\operator;

#namespace juggernaut_recon;

// Namespace juggernaut_recon
// Params 0, eflags: 0x1
// Checksum 0x8d71f96c, Offset: 0x1c4
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "juggernaut_recon" ), &init );
}

// Namespace juggernaut_recon
// Params 0
// Checksum 0xd1a2b050, Offset: 0x1e3
// Size: 0xfe
function init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "juggernaut_recon", &function_d2ed23c7a88cbca4 );
    }
    
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"init" ) )
    {
        [[ utility::getsharedfunc( #"juggernaut_recon", #"init" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"registeractionset" ) )
    {
        [[ utility::getsharedfunc( #"juggernaut_recon", #"registeractionset" ) ]]();
    }
    
    utility::registersharedfunc( #"killstreak_juggernaut_recon", #"hash_6a6ddfa2a5228ad1", &function_d2ed23c7a88cbca4 );
    utility::registersharedfunc( #"killstreak_juggernaut_recon", #"hash_de6e33eee211848", &function_7dc26fb61f208ae9 );
    level.var_f7b85bb96725910a = spawnstruct();
    thread function_4a741db2bcc4a3d5();
}

// Namespace juggernaut_recon
// Params 0
// Checksum 0x3ec36935, Offset: 0x2e9
// Size: 0x16
function function_4a741db2bcc4a3d5()
{
    wait 0.1;
    function_44fa392253dec2d4();
    juggernaut_recon_init_vo();
}

// Namespace juggernaut_recon
// Params 0
// Checksum 0x1d6e365d, Offset: 0x307
// Size: 0x7e
function function_44fa392253dec2d4()
{
    globals = level.var_f7b85bb96725910a;
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    config = juggernaut::function_7a7d89de25fa010c( bundle );
    
    /#
    #/
    
    if ( isdefined( config ) )
    {
        if ( isdefined( level.var_ee18bc0232986f10 ) )
        {
            config [[ level.var_ee18bc0232986f10 ]]();
        }
        
        globals.config = config;
    }
}

/#

    // Namespace juggernaut_recon
    // Params 3
    // Checksum 0x4eea0264, Offset: 0x38d
    // Size: 0xc2, Type: dev
    function function_4dfb302052487d( dvar, config, isprimary )
    {
        overridestring = getdvar( dvar, "<dev string:x24>" );
        
        if ( overridestring.size == 0 )
        {
            return;
        }
        
        substrings = strtok( overridestring, "<dev string:x25>" );
        weaponname = substrings[ 0 ];
        
        if ( isprimary )
        {
            config.classstruct.loadoutprimary = weaponname;
        }
        else
        {
            config.classstruct.loadoutsecondary = weaponname;
        }
        
        weaponblueprint = undefined;
        
        if ( substrings.size > 1 )
        {
            weaponblueprint = substrings[ 1 ];
        }
        
        juggernaut::function_7924c531a3aff66e( weaponname, weaponblueprint, config, isprimary );
    }

#/

// Namespace juggernaut_recon
// Params 0
// Checksum 0x7383149b, Offset: 0x457
// Size: 0xe2
function function_1089d8159dfe2913()
{
    leveldata = undefined;
    
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"leveldata" ) )
    {
        leveldata = [[ utility::getsharedfunc( #"juggernaut_recon", #"leveldata" ) ]]( "juggernaut_recon" );
    }
    
    if ( isdefined( leveldata ) )
    {
        leveldata.capturecallback = &function_3e005bc40793c2f3;
        leveldata.destroycallback = &function_1993ecc16539ea08;
        leveldata.activatecallback = &juggernaut_recon_oncrateactivated;
        leveldata.minimapicon = "jup_ui_map_icon_jugg_recon_drop";
        leveldata.headicon = "jup_ui_map_icon_jugg_recon_drop";
        leveldata.capturestring = &"killstreaks_hints/jugg_recon_crate_pickup";
        
        if ( !isbrgamemode() )
        {
            leveldata.basemodel = self.var_1a32c6d81ba007a7.cratemodel;
        }
    }
}

// Namespace juggernaut_recon
// Params 0
// Checksum 0xaefe268b, Offset: 0x541
// Size: 0x21
function juggernaut_recon_init_vo()
{
    game[ "dialog" ][ "juggernaut_recon" + "_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace juggernaut_recon
// Params 2
// Checksum 0xffd7f928, Offset: 0x56a
// Size: 0x45
function function_7dc26fb61f208ae9( activateimmediate, var_babeddfae778862b )
{
    streakinfo = killstreak_utility::createstreakinfo( "juggernaut_recon", self );
    streakinfo.var_babeddfae778862b = var_babeddfae778862b;
    function_d2ed23c7a88cbca4( streakinfo, activateimmediate );
}

// Namespace juggernaut_recon
// Params 2
// Checksum 0x3a488009, Offset: 0x5b7
// Size: 0x1a5, Type: bool
function function_d2ed23c7a88cbca4( streakinfo, activateimmediate )
{
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"hash_fd6ae1315c480eef" ) )
    {
        if ( !self [[ utility::getsharedfunc( #"juggernaut_recon", #"hash_fd6ae1315c480eef" ) ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    self.var_1a32c6d81ba007a7 = juggernaut::function_720e16a787ba326f( bundle, level.var_f7b85bb96725910a.config, streakinfo.mpstreaksysteminfo.blueprintindex );
    function_1089d8159dfe2913();
    instantdeploy = 0;
    
    /#
        instantdeploy = getdvarint( @"hash_8324943f346018cf", 0 );
    #/
    
    if ( instantdeploy || activateimmediate )
    {
        thread juggernaut_recon_activate( streakinfo );
    }
    else
    {
        vehicle_tracking::reserve_vehicle();
        deployweaponobj = self.var_1a32c6d81ba007a7.deployweapon;
        
        if ( isdefined( level.var_d6dbcfd3322e6005 ) )
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
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace juggernaut_recon
// Params 3
// Checksum 0xa6e87929, Offset: 0x765
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
    
    projectile thread function_ae04816d0f69215( streakinfo );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    return "success";
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0x206b656e, Offset: 0x836
// Size: 0x230
function function_ae04816d0f69215( streakinfo )
{
    level endon( #"game_ended" );
    ownerangles = self.owner.angles;
    owner = self.owner;
    streakinfo.airdroptype = streakinfo.streakname;
    self waittill( #"explode", position );
    
    if ( !isdefined( owner ) )
    {
        if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
        {
            [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
        }
        
        vehicle_tracking::function_4f76f5b4541acef1();
        return;
    }
    
    if ( utility::issharedfuncdefined( #"vehicle", #"decrementfauxvehiclecount" ) )
    {
        [[ utility::getsharedfunc( #"vehicle", #"decrementfauxvehiclecount" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"dropcratefromscriptedheli" ) && !isbrgamemode() )
    {
        streakinfo.vehicleisreserved = 1;
        data = streakinfo;
        scenenode = [[ utility::getsharedfunc( #"juggernaut_recon", #"dropcratefromscriptedheli" ) ]]( owner, owner.team, "juggernaut_recon", position, ownerangles, position, data, streakinfo );
        owner thread airdrop::airdrop_playdeploydialog( streakinfo );
        
        if ( !isdefined( scenenode ) )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/vehicle_refund_killstreak" );
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"awardkillstreakfromstruct" ) )
            {
                owner [[ utility::getsharedfunc( #"killstreak", #"awardkillstreakfromstruct" ) ]]( streakinfo.mpstreaksysteminfo, "other" );
            }
        }
        
        return;
    }
    
    vehicle_tracking::function_4f76f5b4541acef1();
    
    if ( isbrgamemode() )
    {
        isfromgrenade = 1;
        owner thread airdrop::spawnjuggernautcrateatposition( position, isfromgrenade );
    }
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0xb6b03eee, Offset: 0xa6e
// Size: 0x22
function juggernaut_recon_oncrateactivated( firstactivation )
{
    if ( firstactivation )
    {
        self setscriptablepartstate( "smoke_cover", "active", 0 );
    }
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0xf960a1e, Offset: 0xa98
// Size: 0xd3
function function_3e005bc40793c2f3( player )
{
    streakinfo = self.data;
    
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
    
    player juggernaut_recon_activate( streakinfo );
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0x84f9025, Offset: 0xb73
// Size: 0x3e
function function_1993ecc16539ea08( immediate )
{
    streakinfo = self.data;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0x5db9887, Offset: 0xbb9
// Size: 0x274
function juggernaut_recon_activate( streakinfo )
{
    result = 0;
    
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"makejuggernaut" ) )
    {
        var_38bc09b0fd66fb13 = !isdefined( level.var_f7b85bb96725910a.config );
        
        /#
            var_38bc09b0fd66fb13 = var_38bc09b0fd66fb13 || getdvarint( @"hash_e84595a290967e65", 0 ) == 1;
        #/
        
        if ( var_38bc09b0fd66fb13 )
        {
            function_44fa392253dec2d4();
        }
        
        var_88f48a15ab78d42 = var_38bc09b0fd66fb13 || !isdefined( self.var_1a32c6d81ba007a7 );
        
        if ( var_88f48a15ab78d42 )
        {
            bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
            self.var_1a32c6d81ba007a7 = juggernaut::function_720e16a787ba326f( bundle, level.var_f7b85bb96725910a.config, streakinfo.mpstreaksysteminfo.blueprintindex );
        }
        
        if ( isdefined( self.var_1a32c6d81ba007a7 ) )
        {
            result = self [[ utility::getsharedfunc( #"juggernaut_recon", #"makejuggernaut" ) ]]( self.var_1a32c6d81ba007a7, streakinfo );
        }
    }
    
    if ( !result )
    {
        return 0;
    }
    
    self.isjuggernautrecon = 1;
    
    if ( self isnightvisionon() )
    {
        self nightvisionviewoff( 1 );
        self notify( #"night_vision_off" );
    }
    
    if ( utility::issharedfuncdefined( #"juggernaut_recon", #"hash_cc7f6b6f76054500" ) )
    {
        level thread [[ utility::getsharedfunc( #"juggernaut_recon", #"hash_cc7f6b6f76054500" ) ]]( self );
    }
    
    isjuggermoshgamemode = utility::callsharedfunc( #"game", #"isjuggermoshgamemode" );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) && !isjuggermoshgamemode )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_juggernaut_recon", self );
    }
    
    if ( !isjuggermoshgamemode )
    {
        juggernaut_recon_createobjective();
    }
    
    operator::function_89e5e91ee0fb0836();
    
    if ( !streakinfo.var_babeddfae778862b )
    {
        self setsoundsubmix( "mp_juggernaut", 0.5 );
    }
    
    if ( !isdefined( self.var_1a32c6d81ba007a7 ) || !self.var_1a32c6d81ba007a7.var_f405f9410ac00377 )
    {
        thread function_32c32560bba7706f();
    }
    
    thread juggernaut_recon_watchforgameend( streakinfo );
    thread function_a228213494300670( streakinfo );
    thread juggernaut_recon_watchfordisconnect( streakinfo );
}

// Namespace juggernaut_recon
// Params 0
// Checksum 0xb32c75fd, Offset: 0xe35
// Size: 0x1e9
function function_32c32560bba7706f()
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    wait 0.5;
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    
    if ( isdefined( self.var_1a32c6d81ba007a7 ) && isdefined( self.var_1a32c6d81ba007a7.var_890c0aeea9c56946 ) )
    {
        var_9e9471f9b493b3b7 = int( self.var_1a32c6d81ba007a7.var_890c0aeea9c56946.sweeptime * 1000 );
        radarradius = int( self.var_1a32c6d81ba007a7.var_890c0aeea9c56946.radius );
        var_850962423a447a3b = self.var_1a32c6d81ba007a7.var_890c0aeea9c56946.interval;
    }
    else
    {
        var_9e9471f9b493b3b7 = int( bundle.var_b97b3529107bf253 * 1000 );
        radarradius = int( bundle.var_348233ecc0e8c364 );
        
        if ( game_utility::islargemap() )
        {
            radarradius = int( bundle.var_859cdefea823a5a3 );
        }
        
        var_850962423a447a3b = bundle.var_292fd7f95a06a746;
    }
    
    if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
    {
        childthread function_56ef286096dad6ce( bundle, radarradius, bundle.var_b97b3529107bf253 );
    }
    
    while ( true )
    {
        if ( function_53bd0974da1ded36() )
        {
            self notify( #"hash_673789e62d5b264d" );
            
            if ( level.teambased )
            {
                triggerportableradarpingteam( self.origin, self.team, radarradius, var_9e9471f9b493b3b7 );
            }
            else
            {
                triggerportableradarping( self.origin, self, radarradius, var_9e9471f9b493b3b7 );
            }
        }
        
        wait var_850962423a447a3b;
        self notify( #"hash_4739a5a7ed8c3954" );
    }
}

// Namespace juggernaut_recon
// Params 0
// Checksum 0x1c354015, Offset: 0x1026
// Size: 0x1d, Type: bool
function function_53bd0974da1ded36()
{
    if ( self.var_3edfd0e6cc4a1686 )
    {
        return false;
    }
    
    if ( emp_debuff::is_empd() )
    {
        return false;
    }
    
    return true;
}

// Namespace juggernaut_recon
// Params 3
// Checksum 0x292abbd8, Offset: 0x104c
// Size: 0x1ae
function function_56ef286096dad6ce( bundle, radarradius, var_9e9471f9b493b3b7 )
{
    while ( true )
    {
        self waittill( #"hash_673789e62d5b264d" );
        pingcenter = self.origin;
        checkinterval = var_9e9471f9b493b3b7 / bundle.var_646ac2bab40c0ff9;
        characterschecked = [];
        
        for ( i = 1; i <= bundle.var_646ac2bab40c0ff9 ; i++ )
        {
            wait checkinterval;
            var_b3054a5fa39cc5d6 = i / bundle.var_646ac2bab40c0ff9 * radarradius;
            
            if ( utility::issharedfuncdefined( #"game", #"hash_a0e49d05b9afe95d" ) )
            {
                enemyteams = [[ utility::getsharedfunc( #"game", #"hash_a0e49d05b9afe95d" ) ]]( self.team );
                var_8a2708a27bb12b9b = getplayersandaiarrayinradius( pingcenter, var_b3054a5fa39cc5d6, enemyteams );
            }
            else
            {
                var_8a2708a27bb12b9b = getplayersandaiarrayinradius( pingcenter, var_b3054a5fa39cc5d6 );
            }
            
            foreach ( newcharacter in var_8a2708a27bb12b9b )
            {
                if ( !arraycontains( characterschecked, newcharacter ) )
                {
                    characterschecked[ characterschecked.size ] = newcharacter;
                    
                    if ( newcharacter isplayerghost() )
                    {
                        continue;
                    }
                    
                    newcharacter childthread function_1a992cab1a1e8f2c( self );
                }
            }
        }
        
        self waittill( #"hash_4739a5a7ed8c3954" );
    }
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0x60d84e49, Offset: 0x1202
// Size: 0xbd
function function_1a992cab1a1e8f2c( juggernautplayer )
{
    juggernautplayer endon( #"hash_4739a5a7ed8c3954" );
    self waittill( #"death", attacker );
    
    if ( isplayer( attacker ) && attacker != juggernautplayer )
    {
        isfriendly = 0;
        
        if ( utility::issharedfuncdefined( #"player", #"hash_dd0be52eabcd58ce" ) )
        {
            isfriendly = [[ utility::getsharedfunc( #"player", #"hash_dd0be52eabcd58ce" ) ]]( juggernautplayer.team, attacker );
        }
        
        if ( isfriendly )
        {
            juggernautplayer thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"jugg_recon_ping_assist" );
        }
    }
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0x4fd3a591, Offset: 0x12c7
// Size: 0x72
function juggernaut_recon_watchforgameend( streakinfo )
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

// Namespace juggernaut_recon
// Params 1
// Checksum 0x2d85fe7b, Offset: 0x1341
// Size: 0x67
function function_a228213494300670( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    juggcontext = self.juggcontext;
    self waittill( #"juggernaut_end" );
    operator::setgendersoundcontext();
    self clearsoundsubmix( "mp_juggernaut", 0.5 );
    function_7d813a62b0a6b72d( streakinfo, juggcontext );
}

// Namespace juggernaut_recon
// Params 2
// Checksum 0xcf8c88c7, Offset: 0x13b0
// Size: 0x5a
function function_7d813a62b0a6b72d( streakinfo, juggcontext )
{
    if ( !isbrgamemode() )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        streakinfo.expiredbydeath = 1;
        killstreak_utility::recordkillstreakendstats( streakinfo );
    }
    
    function_176b4470b280b214( juggcontext );
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0xe5393588, Offset: 0x1412
// Size: 0x4f
function juggernaut_recon_watchfordisconnect( streakinfo )
{
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    juggcontext = self.juggcontext;
    self waittill( #"disconnect" );
    function_176b4470b280b214( juggcontext );
}

// Namespace juggernaut_recon
// Params 1
// Checksum 0xbc706433, Offset: 0x1469
// Size: 0x237
function juggernaut_recon_createobjective( var_88af6173785ba972 )
{
    if ( isbrgamemode() )
    {
        if ( !isdefined( var_88af6173785ba972 ) )
        {
            var_88af6173785ba972 = "playerObjective";
        }
        
        self setscriptablepartstate( var_88af6173785ba972, "juggernaut", 0 );
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
        utility::callsharedfunc( #"objective", #"objective_add_objective", objid, "active", self.origin, "jup_hud_icon_minimap_killstreak_juggernaut_recon", "icon_medium" );
        utility::callsharedfunc( #"objective", #"objective_set_play_intro", objid, 0 );
        utility::callsharedfunc( #"objective", #"objective_set_play_outro", objid, 0 );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || isbot( player ) || player == self )
            {
                continue;
            }
            
            utility::callsharedfunc( #"objective", #"showtoplayer", objid, player );
        }
        
        utility::callsharedfunc( #"objective", #"update_objective_onentity", objid, self );
        utility::callsharedfunc( #"objective", #"update_objective_setbackground", objid, 1 );
        
        if ( level.teambased )
        {
            utility::callsharedfunc( #"objective", #"update_objective_ownerteam", objid, self.team );
            return;
        }
        
        utility::callsharedfunc( #"objective", #"update_objective_ownerclient", objid, self );
    }
}

// Namespace juggernaut_recon
// Params 2
// Checksum 0x36c9d39d, Offset: 0x16a8
// Size: 0x80
function function_176b4470b280b214( juggcontext, var_88af6173785ba972 )
{
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

