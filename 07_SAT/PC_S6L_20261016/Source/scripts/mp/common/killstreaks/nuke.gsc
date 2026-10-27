// scripts\mp\common\killstreaks\nuke.gsc  (hash_22f61a68d5c6190b.gscc) (size: 48221 Bytes / 0xbc5d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12c4ab57 (314878807)
// size ...... 48221 (0xbc5d)
// includes .. 22  (offset: 0xb4cd)
// strings ... 104 (offset: 0xb57d)
// dev strs .. 15  (offset: 0xbba1)
// exports ... 106 (offset: 0x7dc9)
// cseg ...... 0x755 + 0x7674 (0x7dc9)
// imports ... 304 (offset: 0x8e59)
// animtree1 . 0   (offset: 0xbc5d)
// animtree2 . 0   (offset: 0xbc5d)
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\events;
#using scripts\mp\hostmigration;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;

#namespace nuke;

// Namespace nuke
// Params 0
// Checksum 0xda3c948, Offset: 0x773
// Size: 0xfa
function init()
{
    if ( utility::issharedfuncdefined( #"nuke", #"init" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"init" ) ]]();
    }
    
    level function_dd2e08a55a02e7e4();
    
    /#
        setdevdvarifuninitialized( @"scr_nuke_type", 0 );
        setdevdvarifuninitialized( @"hash_aff3efc76e4dfeb2", 1 );
        setdevdvarifuninitialized( @"hash_256c32636f3dcef2", 0 );
        setdevdvarifuninitialized( @"hash_35e0e06e57d92306", 0 );
        setdevdvarifuninitialized( @"hash_7943c6ec7e44f87c", 0 );
        setdevdvarifuninitialized( @"scr_debug_nuke", 0 );
        setdevdvarifuninitialized( @"hash_44ef9f4ed4e26790", -2 );
        setdevdvarifuninitialized( @"hash_be0a984424433eac", 0 );
        setdevdvarifuninitialized( @"hash_35459e73bd0470ca", 0 );
        setdevdvarifuninitialized( @"scr_debug_nuke_replay", -1 );
        level thread init_nuke_debug();
    #/
    
    level callback::add( #"hash_47bd32b09a74f83f", &can_end_game );
}

// Namespace nuke
// Params 0
// Checksum 0x20f14c39, Offset: 0x875
// Size: 0x46
function function_dd2e08a55a02e7e4()
{
    level.nukeinfo = spawnstruct();
    level.nukecost = killstreak_utility::function_e88d91359aa0273();
    level.nuke_expl_struct = game_utility::getlocalestruct( "nuke_expl_pos" );
    level.nuke_origin_struct = game_utility::getlocalestruct( "nuke_origin" );
}

// Namespace nuke
// Params 2
// Checksum 0x91da2e43, Offset: 0x8c3
// Size: 0x4c
function tryusenuke( var_c29aea62f3c08aa1, var_675fa2b77488d3f7 )
{
    nukestreak = "nuke";
    
    if ( isdefined( var_c29aea62f3c08aa1 ) )
    {
        nukestreak = var_c29aea62f3c08aa1;
    }
    
    streakinfo = killstreak_utility::createstreakinfo( nukestreak, self );
    return tryusenukefromstruct( streakinfo, var_675fa2b77488d3f7 );
}

// Namespace nuke
// Params 2
// Checksum 0xf30e7792, Offset: 0x918
// Size: 0x478, Type: bool
function tryusenukefromstruct( streakinfo, var_675fa2b77488d3f7 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    var_770e7ff156fb2e40 = streakinfo.var_770e7ff156fb2e40 ?? undefined;
    var_9b19d2b58e2d5c9 = undefined;
    var_5fefba97e6418b1c = streakinfo.var_5fefba97e6418b1c ?? undefined;
    bundle = killstreak_utility::function_f943c0602acdc2af( streakinfo.streakname ?? "nuke" );
    
    if ( !isdefined( level.nukeinfo.incoming ) )
    {
        level.nukeinfo.incoming = 1;
        level.nukeinfo.player = self;
    }
    else
    {
        nukeerror = bundle.var_fc72e0fe9f062060 ?? %"killstreaks/nuke_already_inbound";
        
        if ( !isxhashasset( nukeerror ) )
        {
            nukeerror = getxhashasset( nukeerror );
        }
        
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( nukeerror );
        }
        
        return false;
    }
    
    var_b66d311ce603ce94 = isdefined( bundle ) && isdefined( bundle.deployweaponname );
    
    if ( streakinfo.streakname == "nuke_select_location" )
    {
        if ( var_b66d311ce603ce94 )
        {
            deploymentweapon = bundle.deployweaponname;
        }
        else
        {
            deploymentweapon = "iw9_spotter_scope_mp";
        }
        
        deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, weapon_utility::function_d2c8356dc369d9ce( deploymentweapon ), "weapon_fired", &weapongivennuke, &weaponswitchendednuke, &weaponfirednuke );
        var_9b19d2b58e2d5c9 = airstrike::airstrike_getownerlookatpos( self );
        var_5fefba97e6418b1c = 25;
        otherteam = team_utility::getotherteam( streakinfo.owner.team );
        
        if ( isdefined( otherteam ) )
        {
            level thread nuke_warnenemiesnukeincoming( otherteam );
        }
    }
    else if ( !level.mercywintriggered )
    {
        if ( var_b66d311ce603ce94 )
        {
            deploymentweapon = bundle.deployweaponname;
        }
        else
        {
            deploymentweapon = "ks_remote_nuke_mp";
        }
        
        var_c798ac99eca111f5 = makeweapon( deploymentweapon );
        
        if ( killstreak_utility::function_8bec29aceea719c3( var_c798ac99eca111f5 ) )
        {
            deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, undefined, undefined, undefined, undefined, deploymentweapon, 0 );
        }
        else
        {
            if ( utility::issharedfuncdefined( #"nuke", #"onusesequence", 0 ) )
            {
                utility::callsharedfunc( #"nuke", #"onusesequence" );
            }
            else if ( bundle.var_aa88a7c836c913d4 )
            {
                gestureanimtime = self getgestureanimlength( bundle.var_3e96ee2e3dc74467 ) ?? 5;
                thread function_e0cdb607fd8469b4( 0, gestureanimtime );
            }
            else
            {
                thread function_853cd7724edb2119();
            }
            
            deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, var_c798ac99eca111f5, "nj[DEbvKlSnlyx^UQyg_", 0 );
            
            if ( !deployresult )
            {
                self notify( #"hash_8d5929299a430b00" );
            }
        }
    }
    else
    {
        deployresult = 1;
    }
    
    if ( !deployresult || level.gameended )
    {
        level.nukeinfo.incoming = undefined;
        level.nukeinfo.player = undefined;
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            level.nukeinfo.incoming = undefined;
            level.nukeinfo.player = undefined;
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    thread nuke_start( streakinfo, 0, undefined, var_9b19d2b58e2d5c9, var_770e7ff156fb2e40, var_5fefba97e6418b1c, var_675fa2b77488d3f7, bundle );
    
    if ( streakinfo.streakname != "nuke_select_location" && !level.mercywintriggered )
    {
        utility::trycall( level.matchdata_logkillstreakevent, "nuke", self.origin );
    }
    
    points::doscoreevent( #"ss_nuke_deployed" );
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
    }
    
    return true;
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x839e4b98, Offset: 0xd99
// Size: 0x121
function private function_853cd7724edb2119()
{
    self endon( #"death_or_disconnect", #"hash_8d5929299a430b00" );
    var_26ffef530dd46d79 = #"nuke_walkie_screen";
    
    if ( !self getscriptablehaspart( var_26ffef530dd46d79 ) )
    {
        return;
    }
    
    self waittill( #"nj[DEbvKlSnlyx^UQyg_" );
    self setscriptablepartstate( var_26ffef530dd46d79, #"start" );
    self waittill( #"offhand_pullback" );
    wait 0.71;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_1" );
    wait 0.65;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_2" );
    wait 0.18;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_3" );
    wait 0.4;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_4" );
    wait 0.25;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_5" );
    wait 0.75;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_6" );
    wait 0.2;
    self setscriptablepartstate( var_26ffef530dd46d79, #"press_7" );
    wait 0.1;
    self setscriptablepartstate( var_26ffef530dd46d79, #"nuke_incoming" );
    wait 0.1;
}

// Namespace nuke
// Params 1
// Checksum 0x5b19bb67, Offset: 0xec2
// Size: 0xe, Type: bool
function weapongivennuke( streakinfo )
{
    return true;
}

// Namespace nuke
// Params 2
// Checksum 0xc4f5e32c, Offset: 0xed9
// Size: 0x28
function weaponswitchendednuke( streakinfo, switchresult )
{
    if ( switchresult )
    {
        thread airstrike::airstrike_watchforads( streakinfo, "splash_icon_nuke" );
    }
}

// Namespace nuke
// Params 3
// Checksum 0xd0a8d271, Offset: 0xf09
// Size: 0x83
function weaponfirednuke( streakinfo, firedweaponobj, firedprojectile )
{
    mappoint = airstrike::airstrike_getownerlookatpos( self );
    
    if ( !isdefined( mappoint ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/INVALID_POINT" );
        }
        
        return "continue";
    }
    
    return "success";
}

// Namespace nuke
// Params 4
// Checksum 0xd962f7b5, Offset: 0xf95
// Size: 0x7a
function nuke_delaythread( delay, func, owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    
    if ( isdefined( delay ) )
    {
        if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
        {
            [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( delay );
        }
    }
    
    level thread [[ func ]]( owner, streakinfo );
}

// Namespace nuke
// Params 8
// Checksum 0xf2543e2c, Offset: 0x1017
// Size: 0x697
function nuke_start( streakinfo, allowcancel, launchposoverride, explodeposoverride, var_770e7ff156fb2e40, var_5fefba97e6418b1c, weaponoverride, bundle )
{
    level endon( #"nuke_cancelled" );
    level notify( #"used_nuke" );
    self notify( #"used_nuke" );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon", 1 );
    nukeinfo = spawnstruct();
    nukeinfo.team = self.pers[ "team" ];
    nukeinfo.allowcancel = istrue( allowcancel );
    nukeinfo.cancelled = undefined;
    nukeinfo.detonated = undefined;
    nukeinfo.gameover = undefined;
    nukeinfo.visioninprogress = 0;
    nukeinfo.timescalefactor = 0;
    nukeinfo.nuketype = streakinfo.streakname;
    nukeinfo.streakinfo = streakinfo;
    nukeinfo.incoming = 1;
    nukeinfo.bundle = bundle ?? killstreak_utility::function_f943c0602acdc2af( streakinfo.streakname ?? "nuke" );
    
    if ( isplayer( self ) )
    {
        nukeinfo.player = self;
    }
    
    defaultstarttimer = bundle.nukestarttimer ?? 6;
    var_9fde233a0de1b36b = bundle.var_c8e3eb7874635b39 ?? 10;
    var_81368f2be0e4e68a = bundle.var_e3034fae8b863b70 ?? 0;
    var_15d4fcebdac0935 = bundle.var_8f77f69b329c343e ?? 1;
    
    if ( !var_15d4fcebdac0935 )
    {
        var_5fefba97e6418b1c = bundle.var_12130cca92d2fea7 ?? 10;
    }
    
    nukegoalpoint = function_e987813b53243a97( nukeinfo.nuketype, explodeposoverride, bundle );
    var_5cc3bfbb33b6b34e = function_e245eabc34354517( nukeinfo.nuketype, nukegoalpoint, launchposoverride, bundle );
    
    /#
        if ( getdvarint( @"scr_debug_nuke", 0 ) )
        {
            level thread debug_utility::drawsphere( nukegoalpoint, 50, 30, ( 1, 1, 0 ) );
            level thread debug_utility::drawsphere( var_5cc3bfbb33b6b34e, 50, 30, ( 1, 1, 0 ) );
            level thread debug_utility::drawline( var_5cc3bfbb33b6b34e, nukegoalpoint, 30, ( 1, 1, 0 ) );
        }
    #/
    
    nukestarttimer = function_96b3c1c1db4aba59( nukeinfo.nuketype, defaultstarttimer, var_770e7ff156fb2e40 );
    var_80190f60538acc9f = function_b95b8d0e48825b80( nukeinfo.nuketype, var_9fde233a0de1b36b, var_5fefba97e6418b1c );
    nukeweapon = nuke_getweapon( streakinfo, nukeinfo.nuketype, weaponoverride, bundle );
    var_93276ef91758dc84 = function_911b4916fa84c2e5( nukeinfo.nuketype, var_5cc3bfbb33b6b34e, nukegoalpoint );
    
    if ( !isdefined( nukeinfo.clockobject ) )
    {
        nukeinfo.clockobject = spawn( "script_origin", var_93276ef91758dc84 + ( 0, 0, 100 ) );
        nukeinfo.clockobject dontinterpolate();
        nukeinfo.clockobject hide();
    }
    else
    {
        nukeinfo.clockobject.origin = var_93276ef91758dc84 + ( 0, 0, 100 );
    }
    
    nukeinfo.launchpoint = var_5cc3bfbb33b6b34e;
    nukeinfo.goalpoint = nukegoalpoint;
    nukeinfo.starttimer = nukestarttimer;
    nukeinfo.var_ee7d35f769f5e251 = bundle.var_6475b09c71022fc6 ?? 1;
    nukeinfo.explosiontimer = var_80190f60538acc9f;
    nukeinfo.var_88f920889184c39c = nukestarttimer + var_80190f60538acc9f;
    nukeinfo.var_53b9cf5fb0ec77a3 = var_81368f2be0e4e68a;
    nukeinfo.weapon = nukeweapon;
    nukeinfo.inflictor = spawn( "script_model", nukegoalpoint + ( 0, 0, 5000 ) );
    nukeinfo.inflictor setmodel( "tag_origin" );
    nukeinfo.inflictor.team = nukeinfo.team;
    nukeinfo.inflictor.owner = self;
    nukeinfo.inflictor.streakinfo = streakinfo;
    level.nukeinfo = nukeinfo;
    level thread nuke_startlaunchsequence( self, streakinfo, explodeposoverride );
    
    if ( nukeinfo.nuketype == "nuke_multi" )
    {
        level thread utility::delaythread( nukeinfo.starttimer, &function_b0bc682ca7bc17ec, self, streakinfo );
        level thread utility::delaythread( nukeinfo.starttimer, &function_28d6684a96cab3e0, self, streakinfo );
        level thread utility::delaythread( nukeinfo.starttimer, &function_feec581b7f380db9, self, streakinfo );
        level thread utility::delaythread( nukeinfo.starttimer, &function_984972b0639d3d61, self, streakinfo );
        level thread utility::delaythread( nukeinfo.starttimer, &function_e8442f18b85ce76f, self, streakinfo );
    }
    else
    {
        if ( streakinfo.nuketype == "nuke_select_location" )
        {
            level thread nuke_delaythread( nukeinfo.var_88f920889184c39c, &nuke_createradiationzone, self, streakinfo );
        }
        
        level thread nuke_delaythread( nukeinfo.var_88f920889184c39c, &nuke_slowmo, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_88f920889184c39c, &nuke_explosion, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_88f920889184c39c, &nuke_earthquake, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_88f920889184c39c + 0.075, &nuke_vision, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_88f920889184c39c + 5, &nuke_death, self, streakinfo );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( utility::issharedfuncdefined( #"nuke", #"hash_f15ae3904539c3ac" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_f15ae3904539c3ac" ) ]]( 2, level.nukeinfo.team, "nuke" );
    }
    
    if ( level.nukeinfo.allowcancel )
    {
        level thread nuke_watchownerdisconnect( nukeinfo.player );
    }
}

// Namespace nuke
// Params 1
// Checksum 0x5a666c83, Offset: 0x16b6
// Size: 0x64
function nuke_watchownerdisconnect( owner )
{
    if ( !level.nukeinfo.timescalefactor )
    {
        soundsettimescalefactorfromtable( "nuke" );
        level.nukeinfo.timescalefactor = 1;
    }
    
    level endon( #"game_ended" );
    owner waittill( #"disconnect" );
    nuke_cancel();
}

// Namespace nuke
// Params 0
// Checksum 0xae752a6c, Offset: 0x1722
// Size: 0x5b
function nuke_cancel()
{
    level.nukeinfo.cancelled = 1;
    level.nukeinfo.incoming = undefined;
    level.nukeinfo.player = undefined;
    nuke_cleartimer();
    setslowmotion( 1, 1, 0 );
    level notify( #"nuke_cancelled" );
}

// Namespace nuke
// Params 3
// Checksum 0xac9344c9, Offset: 0x1785
// Size: 0x12b
function nuke_starttimer( streakinfo, traveltime, splashdelay )
{
    level endon( #"nuke_cancelled" );
    
    if ( traveltime <= 1 )
    {
        return;
    }
    
    if ( !isdefined( splashdelay ) )
    {
        splashdelay = 0;
    }
    
    if ( splashdelay > 0 )
    {
        wait splashdelay;
    }
    
    bundle = level.nukeinfo.bundle;
    level.nukeinfo.clockobject playsound( bundle.var_5d8866ec9782787f ?? "iw9_mgb_splash" );
    
    if ( level.mercywintriggered )
    {
        setomnvar( "ui_nuke_timer_type", 2 );
    }
    else
    {
        setomnvar( "ui_nuke_timer_type", 0 );
    }
    
    setomnvar( "ui_nuke_countdown_active", 1 );
    
    if ( isdefined( level.nukeinfo.player ) )
    {
        setomnvar( "ui_nuke_player_id", level.nukeinfo.player getentitynumber() );
    }
    
    var_54a3cc7eee03047e = traveltime - splashdelay;
    level thread nuke_updateuitimers( var_54a3cc7eee03047e );
    level thread function_851f88a83329ee87( var_54a3cc7eee03047e + ( bundle.var_755cde6f48ff591d ?? 0 ) );
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x33d4bdd3, Offset: 0x18b8
// Size: 0x29
function private function_851f88a83329ee87( delay )
{
    level endon( #"nuke_cancelled" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    nuke_cleartimer();
}

// Namespace nuke
// Params 0
// Checksum 0xfd902f0, Offset: 0x18e9
// Size: 0xe
function nuke_cleartimer()
{
    setomnvar( "ui_nuke_countdown_active", -1 );
}

// Namespace nuke
// Params 5
// Checksum 0x2d16dcd4, Offset: 0x18ff
// Size: 0x35a
function nuke_startlaunchsequence( owner, streakinfo, explodeposoverride, var_7f9fa5efaee9bddf, var_d9ea6da83ae723a1 )
{
    nuketype = level.nukeinfo.nuketype;
    nukestarttimer = level.nukeinfo.starttimer;
    var_104cba40ca6f6726 = level.nukeinfo.var_ee7d35f769f5e251;
    var_80190f60538acc9f = level.nukeinfo.explosiontimer;
    var_d5dc54fdd93283f4 = level.nukeinfo.var_88f920889184c39c;
    var_f8d6198e61c1a19c = level.nukeinfo.var_53b9cf5fb0ec77a3;
    launchpos = level.nukeinfo.launchpoint;
    explodepos = level.nukeinfo.goalpoint;
    nukeweapon = level.nukeinfo.weapon;
    var_e2f4e710e1dc15dc = nuketype == "nuke_multi";
    var_41dde4d7f3d7373b = nuketype == "nuke_select_location";
    bundle = level.nukeinfo.bundle;
    level thread nuke_startprelaunchalarm( nukestarttimer, streakinfo, owner );
    level thread function_3c9d3b258ed49487( owner, bundle, var_d9ea6da83ae723a1 );
    level thread function_7f79e8ff6442d6( owner, bundle, launchpos, explodepos );
    level thread function_8eddd743ee520031( owner, streakinfo, var_d9ea6da83ae723a1 );
    
    if ( var_e2f4e710e1dc15dc && !bundle.var_186d818de7519ac3 )
    {
        level thread function_6a276019731c5517( launchpos, explodepos, var_d5dc54fdd93283f4, streakinfo, owner );
    }
    
    if ( !var_41dde4d7f3d7373b )
    {
        gametype = game_utility::getgametype();
        
        if ( utility::issharedfuncdefined( #"nuke", #"stoptheclock" ) )
        {
            [[ utility::getsharedfunc( #"nuke", #"stoptheclock" ) ]]( gametype );
        }
        
        if ( isdefined( level.timelimit ) )
        {
            if ( utility::issharedfuncdefined( #"game", #"hash_3bc9379704a85a6" ) )
            {
                [[ utility::getsharedfunc( #"game", #"hash_3bc9379704a85a6" ) ]]( level.timelimit );
            }
        }
        
        level.dontendonscore = 1;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player notify( #"abort_killcam" );
                player.cancelkillcam = 1;
            }
        }
        
        level thread nuke_abortkillcamonspawn();
        level.disablespawncamera = 1;
        function_4e5beac0a580e766();
        
        if ( !var_7f9fa5efaee9bddf )
        {
            level thread utility::delaythread( nukestarttimer, &nuke_starttimer, streakinfo, var_80190f60538acc9f, bundle.var_4dca107e134bc3a9 );
        }
        
        level thread utility::delaythread( var_104cba40ca6f6726, &function_cc12880d629ea681, owner, streakinfo, launchpos, explodepos, explodeposoverride, var_80190f60538acc9f, nukeweapon, var_f8d6198e61c1a19c, var_e2f4e710e1dc15dc );
    }
}

// Namespace nuke
// Params 9
// Checksum 0x908fe71e, Offset: 0x1c61
// Size: 0xbe
function function_cc12880d629ea681( owner, streakinfo, launchpos, explodepos, explodeposoverride, var_80190f60538acc9f, nukeweapon, var_f8d6198e61c1a19c, var_e2f4e710e1dc15dc )
{
    bundle = level.nukeinfo.bundle;
    
    if ( var_e2f4e710e1dc15dc )
    {
        if ( bundle.var_186d818de7519ac3 )
        {
            level thread function_dc6da7889c4ea16d( owner, streakinfo, launchpos, explodepos, explodeposoverride, var_80190f60538acc9f, nukeweapon, var_f8d6198e61c1a19c );
        }
        else
        {
            level thread function_6a231b60817b09a2( owner, streakinfo, explodepos, var_80190f60538acc9f, nukeweapon );
        }
        
        return;
    }
    
    level thread nuke_launchmissile( owner, streakinfo, launchpos, explodepos, var_80190f60538acc9f, nukeweapon );
}

// Namespace nuke
// Params 3
// Checksum 0x58389524, Offset: 0x1d27
// Size: 0x149
function nuke_startprelaunchalarm( var_3cc33f7a67e15593, streakinfo, owner )
{
    level endon( #"game_ended" );
    
    if ( streakinfo.skipprelaunch )
    {
        return;
    }
    
    var_c3c21e7a1a905089 = 0;
    
    if ( isdefined( streakinfo ) && isdefined( owner ) )
    {
        owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, streakinfo.streakname + "_use", #"use", 1, 1 );
        owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1, 2 );
    }
    
    while ( var_3cc33f7a67e15593 > 0 )
    {
        if ( isdefined( level.nukeinfo.clockobject ) && !var_c3c21e7a1a905089 )
        {
            bundle = level.nukeinfo.bundle;
            level.nukeinfo.clockobject playsound( bundle.var_86724668ee3d2b37 ?? #"hash_111dae09f39abb0b" );
            var_c3c21e7a1a905089 = 1;
        }
        
        if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
        {
            [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( 2 );
        }
        
        var_3cc33f7a67e15593 -= 2;
    }
}

// Namespace nuke
// Params 5
// Checksum 0x8694af6d, Offset: 0x1e78
// Size: 0x122
function function_6a276019731c5517( var_2801f7da37580e7e, baseexplosionpoint, var_d5dc54fdd93283f4, streakinfo, owner )
{
    level endon( #"game_ended" );
    dronemodel = "veh9_mil_air_large_drone_mp";
    bundle = level.nukeinfo.bundle;
    
    if ( isdefined( bundle ) && isdefined( bundle.var_a2640887d9e9ecb8 ) )
    {
        dronemodel = bundle.var_a2640887d9e9ecb8;
    }
    
    drone = spawn( "script_model", var_2801f7da37580e7e );
    drone setmodel( dronemodel );
    drone setcandamage( 0 );
    drone.angles = vectortoangles( ( baseexplosionpoint[ 0 ], baseexplosionpoint[ 1 ], 0 ) - ( var_2801f7da37580e7e[ 0 ], var_2801f7da37580e7e[ 1 ], 0 ) );
    drone setscriptablepartstate( #"engine", #"on", 0 );
    drone moveto( var_2801f7da37580e7e + anglestoforward( drone.angles ) * 5000, var_d5dc54fdd93283f4 );
    level.nukeinfo.drone = drone;
}

// Namespace nuke
// Params 5, eflags: 0x4
// Checksum 0x9259275b, Offset: 0x1fa2
// Size: 0x3d2
function private function_6a231b60817b09a2( owner, streakinfo, explodepos, traveltime, nukeweapon )
{
    level endon( #"game_ended" );
    assert( isdefined( level.nukeinfo.drone ), "<dev string:x24>" );
    function_1a2c1f6c63819d4b( owner );
    level.nukeinfo.bombs = [];
    drone = level.nukeinfo.drone;
    nukegravity = ( 0, 0, -1 * getdvarfloat( @"bg_gravity", 800 ) );
    explodeposlist = [ explodepos - anglestoforward( drone.angles ) * 2500, explodepos - anglestoforward( drone.angles ) * 1000, explodepos + anglestoforward( drone.angles ) * 1000, explodepos + anglestoforward( drone.angles ) * 2500, explodepos ];
    tracecontents = trace::create_contents( 0, 1, 1, 1 );
    rightoffset = 500;
    bundle = level.streakglobals.streakbundles[ streakinfo.streakname ?? "nuke" ];
    var_a73b04cc78c5ee0 = bundle.var_68eb6cbfbe4fa719 ?? 5;
    streakinfo.var_3f92b9fa482c7bdb = 1;
    
    for ( i = 0; i < var_a73b04cc78c5ee0 ; i++ )
    {
        lastbomb = 0;
        nextindex = i + 1;
        
        if ( nextindex == var_a73b04cc78c5ee0 )
        {
            lastbomb = 1;
        }
        
        launchoffset = drone.origin - ( 0, 0, 100 ) + anglestoforward( drone.angles ) * 500;
        launchpos = launchoffset + anglestoright( drone.angles ) * rightoffset;
        potentialpos = explodeposlist[ i ];
        
        if ( !lastbomb )
        {
            randdist = randomintrange( 1000, 2500 );
            randangle = randomint( 360 );
            x = explodeposlist[ i ][ 0 ] + randdist * cos( randangle );
            y = explodeposlist[ i ][ 1 ] + randdist * sin( randangle );
            z = explodeposlist[ i ][ 2 ];
            potentialpos = ( x, y, z );
        }
        
        bombtrace = trace::ray_trace( launchpos, potentialpos, drone, tracecontents );
        newexplodepos = potentialpos;
        
        if ( isdefined( bombtrace ) && isdefined( bombtrace[ "hittype" ] != "hittype_none" ) )
        {
            newexplodepos = bombtrace[ "position" ];
        }
        
        nukevelocity = ( newexplodepos - 0.5 * nukegravity * squared( traveltime ) - launchpos ) / traveltime;
        bomb = magicgrenademanual( nukeweapon, launchpos, nukevelocity, traveltime );
        bomb setscriptablepartstate( #"launch_bomb_source", #"on", 0 );
        bomb setscriptablepartstate( #"launch", #"on", 0 );
        
        if ( lastbomb )
        {
            level notify( #"hash_55462fd1ecb1f35c" );
        }
        
        level thread function_148cb0e61f6cc046( bomb, streakinfo, traveltime, lastbomb );
        level.nukeinfo.bombs[ level.nukeinfo.bombs.size ] = bomb;
        wait randomfloatrange( 0.5, 1 );
        rightoffset -= 250;
    }
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0xf51e21ae, Offset: 0x237c
// Size: 0x53
function private function_1a2c1f6c63819d4b( owner )
{
    if ( isplayer( owner ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_nuke_multi", owner );
        }
    }
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x9999af84, Offset: 0x23d7
// Size: 0x8e
function private function_b85866b8ce2e497()
{
    level.disableannouncer = 1;
    level.battlechatterenabled = 0;
    
    foreach ( player in level.players )
    {
        player function_971e406eb1e08f74();
    }
}

// Namespace nuke
// Params 8, eflags: 0x4
// Checksum 0x314e86a3, Offset: 0x246d
// Size: 0x473
function private function_dc6da7889c4ea16d( owner, streakinfo, launchpos, explodepos, var_cea9f6441a566558, traveltime, nukeweapon, var_53b9cf5fb0ec77a3 )
{
    level endon( #"game_ended" );
    bundle = level.nukeinfo.bundle;
    var_a73b04cc78c5ee0 = bundle.var_68eb6cbfbe4fa719 ?? 5;
    var_4f42dff7f973721e = bundle.var_23cc712698359974;
    streakinfo.var_3f92b9fa482c7bdb = var_a73b04cc78c5ee0;
    function_1a2c1f6c63819d4b( owner );
    function_b85866b8ce2e497();
    level.nukeinfo.bombs = [];
    spawnangles = undefined;
    
    if ( var_4f42dff7f973721e )
    {
        if ( isdefined( var_cea9f6441a566558 ) )
        {
            spawnangles = vectortoangles( var_cea9f6441a566558 - launchpos );
        }
        else
        {
            spawnangles = angleclamp180( owner getplayerangles( 1 ) + ( 0, 225, 0 ) );
        }
    }
    
    var_7da0be60a30319cf = 5000;
    var_41bc361ed7fd090 = 10000;
    startingangles = vectortoangles( ( explodepos[ 0 ], explodepos[ 1 ], 0 ) - ( launchpos[ 0 ], launchpos[ 1 ], 0 ) );
    
    if ( !isdefined( var_53b9cf5fb0ec77a3 ) )
    {
        var_53b9cf5fb0ec77a3 = 0;
    }
    
    var_80d25b7ccc5b95b3 = traveltime;
    
    if ( !bundle.var_8f77f69b329c343e )
    {
        var_80d25b7ccc5b95b3 = bundle.var_c8e3eb7874635b39 ?? 10;
    }
    
    for ( i = 0; i < var_a73b04cc78c5ee0 ; i++ )
    {
        lastbomb = 0;
        nextindex = i + 1;
        
        if ( nextindex == var_a73b04cc78c5ee0 )
        {
            lastbomb = 1;
        }
        
        if ( var_4f42dff7f973721e )
        {
            bomb = spawn( "script_model", launchpos );
            bomb hide( 1 );
            bomb.angles = spawnangles;
            bomb setmodel( bundle.nukebombmodel );
            
            /#
                bomb thread function_5b7c4bbf4869cc16( i );
            #/
            
            bomb.animname = "Prop " + i + 1;
            bomb thread function_bdc28c39487f4a14( 0.25 );
        }
        else
        {
            if ( lastbomb )
            {
                var_7da0be60a30319cf = 0;
                var_41bc361ed7fd090 = 0;
            }
            
            newexplodepos = explodepos + anglestoforward( startingangles ) * var_7da0be60a30319cf;
            newexplodepos += anglestoright( startingangles ) * var_41bc361ed7fd090;
            
            /#
                if ( getdvarint( @"scr_debug_nuke", 0 ) )
                {
                    level thread debug_utility::drawline( launchpos, newexplodepos, 30, ( 1, 0, 0 ) );
                    level thread debug_utility::drawsphere( newexplodepos, 50, 30, ( 1, 0, 0 ) );
                }
            #/
            
            var_3817089140682249 = var_80d25b7ccc5b95b3;
            
            if ( i == 0 )
            {
                var_3817089140682249 = 6;
            }
            else if ( i == 1 )
            {
                var_3817089140682249 = 8.5;
            }
            
            var_7dae7f8ea43ba5c8 = ( 0, 0, -1 * getdvarfloat( @"bg_gravity", 800 ) );
            var_9dce17a116cdf149 = ( newexplodepos - 0.5 * var_7dae7f8ea43ba5c8 * squared( var_3817089140682249 ) - launchpos ) / var_3817089140682249;
            bomb = owner weapon::_launchgrenade( bundle.var_72930cc4438eb700, launchpos, var_9dce17a116cdf149, 60 );
            bomb.index = i;
            var_7da0be60a30319cf -= 2500;
            var_41bc361ed7fd090 -= 20000;
        }
        
        if ( bomb getscriptablehaspart( #"launch_bomb_source" ) )
        {
            bomb setscriptablepartstate( #"launch_bomb_source", #"on", 0 );
        }
        
        if ( bomb getscriptablehaspart( #"launch" ) )
        {
            bomb setscriptablepartstate( #"launch", #"on", 0 );
        }
        
        level thread function_148cb0e61f6cc046( bomb, streakinfo, var_3817089140682249, lastbomb );
        level.nukeinfo.bombs[ level.nukeinfo.bombs.size ] = bomb;
        
        if ( lastbomb )
        {
            if ( var_4f42dff7f973721e )
            {
                var_b59a72bf8a2b7b5c = { #angles:spawnangles, #origin:launchpos };
                var_b59a72bf8a2b7b5c thread scene::play( level.nukeinfo.bombs, "shot_010", bundle.var_8771d1a9def69831 );
                sceneduration = var_b59a72bf8a2b7b5c scene::function_b3c7b792a7a154fa( "shot_010" );
            }
            
            level notify( #"hash_55462fd1ecb1f35c" );
        }
        
        if ( var_53b9cf5fb0ec77a3 > 0 )
        {
            wait var_53b9cf5fb0ec77a3;
            continue;
        }
        
        waitframe();
    }
}

// Namespace nuke
// Params 3, eflags: 0x4
// Checksum 0xafb13e8d, Offset: 0x28e8
// Size: 0xa9
function private function_3c9d3b258ed49487( owner, bundle, var_d9ea6da83ae723a1 )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !bundle.var_abe317952859e066 )
    {
        return;
    }
    
    /#
        if ( var_d9ea6da83ae723a1 )
        {
            return;
        }
    #/
    
    owner player_utility::_freezecontrols( 1 );
    owner setclientomnvar( "ui_bink_overlay_state", 1 );
    owner playcinematicforplayer( bundle.var_f8a2cffc958db961, 1 );
    wait bundle.var_fe87fffb6585cd02 ?? 4;
    owner setclientomnvar( "ui_bink_overlay_state", 0 );
    owner stopcinematicforplayer( 1, 1 );
}

// Namespace nuke
// Params 4, eflags: 0x4
// Checksum 0x288ad4ab, Offset: 0x2999
// Size: 0x9f
function private function_7f79e8ff6442d6( owner, bundle, launchpos, explodepos )
{
    if ( !bundle.var_7356d1b3c8fe4af9 )
    {
        return;
    }
    
    nukescriptable = spawn( "script_model", launchpos );
    nukescriptable setmodel( bundle.var_629c2841e954d55 );
    nukescriptable.angles = vectortoangles( ( explodepos[ 0 ], explodepos[ 1 ], 0 ) - ( launchpos[ 0 ], launchpos[ 1 ], 0 ) );
    level thread function_6a0094e9e2eb7e67( nukescriptable );
    nukescriptable setscriptablepartstate( "launch_missile_source", "on", 0 );
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0xd6ab69cc, Offset: 0x2a40
// Size: 0x32
function private function_6a0094e9e2eb7e67( scriptable )
{
    level endon( #"game_ended" );
    level waittill( #"nuke_detonated" );
    
    if ( isdefined( scriptable ) )
    {
        scriptable delete();
    }
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0xcb6512df, Offset: 0x2a7a
// Size: 0x4a
function private function_bdc28c39487f4a14( delay )
{
    self endon( #"death" );
    wait delay;
    
    if ( isdefined( self ) )
    {
        self show();
    }
    
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( #"exhaust", #"on", 0 );
    }
}

/#

    // Namespace nuke
    // Params 1, eflags: 0x4
    // Checksum 0x6e705452, Offset: 0x2acc
    // Size: 0xd8, Type: dev
    function private function_5b7c4bbf4869cc16( bombindex )
    {
        self endon( #"death" );
        self endon( #"single_nuke_explo" );
        level notify( "<dev string:x5d>" + bombindex );
        var_63708a99e4f3aa46 = getdvarint( @"hash_35e0e06e57d92306", 0 );
        
        if ( var_63708a99e4f3aa46 == 0 )
        {
            return;
        }
        
        if ( !isdefined( level.var_202b702f60120143 ) )
        {
            level.var_202b702f60120143 = [];
        }
        
        level.var_202b702f60120143[ bombindex ] = [];
        thread function_f50a982f9aecd95b( bombindex );
        
        while ( true )
        {
            pos = self gettagorigin( #"tag_origin" );
            
            if ( !arraycontains( level.var_202b702f60120143[ bombindex ], pos ) )
            {
                level.var_202b702f60120143[ bombindex ][ level.var_202b702f60120143[ bombindex ].size ] = pos;
            }
            
            wait 0.1;
        }
    }

    // Namespace nuke
    // Params 1, eflags: 0x4
    // Checksum 0x17ab2404, Offset: 0x2bac
    // Size: 0xb1, Type: dev
    function private function_f50a982f9aecd95b( bombindex )
    {
        level endon( "<dev string:x5d>" + bombindex );
        
        while ( true )
        {
            foreach ( pos in level.var_202b702f60120143[ bombindex ] )
            {
                sphere( pos, 200, ( 1, bombindex * 50 / 255, bombindex ), 0, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace nuke
// Params 4
// Checksum 0x121438a, Offset: 0x2c65
// Size: 0x54d
function function_148cb0e61f6cc046( bomb, streakinfo, traveltime, lastbomb )
{
    bundle = level.nukeinfo.bundle;
    
    if ( bundle.var_5fade1b3b01895ff )
    {
        bomb waittill( #"detonate" );
    }
    else if ( lastbomb && !bundle.var_d33617f114b4b820 )
    {
        wait traveltime - 2.8;
        
        if ( bomb getscriptablehaspart( #"last_bomb_sfx" ) )
        {
            bomb setscriptablepartstate( #"last_bomb_sfx", #"on", 0 );
        }
        
        wait 2.8;
    }
    else
    {
        wait traveltime;
    }
    
    if ( bomb getscriptablehaspart( #"exhaust" ) )
    {
        bomb setscriptablepartstate( #"exhaust", #"off", 0 );
    }
    
    position = bomb.origin;
    bombowner = level.nukeinfo.player;
    
    if ( bundle.nukeshockwave )
    {
        shockref = bundle.nukeshockwave;
        
        if ( !lastbomb )
        {
            shockref += "_no_shake";
        }
        
        utility::function_ce86ddbb7d60e9bd( position, shockref, bombowner );
    }
    else
    {
        shakeduration = 3;
        var_39bbe706cd34d2ec = 0.3;
        var_39deeb06cd5b2370 = 0.15;
        var_39def506cd5b396e = 0.1;
        radiusscalemax = 1500;
        radiusscalemid = 5000;
        radiusscalemin = 10000;
        
        if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
        {
            [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( position, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1 );
        }
    }
    
    killradius = 3000;
    var_1cf23c74ee1714f6 = nuke_cankilleverything();
    
    if ( var_1cf23c74ee1714f6 )
    {
        function_aa8b1b4adf8f6b80( bombowner, position, killradius );
    }
    
    if ( isdefined( streakinfo.var_3f92b9fa482c7bdb ) )
    {
        if ( !isdefined( streakinfo.var_95add84cbd26b06a ) )
        {
            streakinfo.var_95add84cbd26b06a = 0;
        }
        
        streakinfo.var_95add84cbd26b06a++;
        
        if ( streakinfo.var_95add84cbd26b06a == streakinfo.var_3f92b9fa482c7bdb )
        {
            function_851f88a83329ee87( bundle.var_755cde6f48ff591d );
        }
    }
    
    if ( lastbomb )
    {
        level notify( #"hash_b097322db210669", position );
        
        if ( !isdefined( streakinfo.var_3f92b9fa482c7bdb ) )
        {
            function_851f88a83329ee87( bundle.var_755cde6f48ff591d );
        }
        
        level.nukeinfo.detonated = 1;
        level notify( #"nuke_detonated" );
        var_9b2213362002c049 = "iw9_mgb_post_fire";
        bundle = level.nukeinfo.bundle;
        
        if ( isdefined( bundle ) && isdefined( bundle.var_66e66fa35d7d805c ) )
        {
            var_9b2213362002c049 = bundle.var_66e66fa35d7d805c;
        }
        
        utility::play_loopsound_in_space( var_9b2213362002c049, bomb.origin );
        
        if ( !level.mercywintriggered && isdefined( level.nukeinfo.player ) && isdefined( streakinfo ) )
        {
            killedcount = 0;
            nukeattacker = level.nukeinfo.player;
            nukeweapon = makeweapon( level.nukeinfo.weapon );
            
            foreach ( victim in level.players )
            {
                if ( !isdefined( victim ) )
                {
                    continue;
                }
                
                killedcount++;
                events::function_7fae313f10bc9d47( nukeattacker, victim, nukeattacker, nukeweapon, streakinfo );
            }
            
            streakinfo.kills = killedcount;
            nukeattacker killstreak_utility::recordkillstreakendstats( streakinfo );
        }
    }
    
    if ( bundle.var_23cc712698359974 )
    {
        bomb notify( #"single_nuke_explo" );
        bomb setscriptablepartstate( #"payload", level.var_261de636e755e4f4 ?? #"detonate", 0 );
        
        if ( lastbomb )
        {
            bomb setscriptablepartstate( #"blast", #"blast", 0 );
        }
        
        return;
    }
    
    if ( bundle.var_843eecfac716f967 )
    {
        bomb show();
        
        if ( lastbomb )
        {
            bomb setscriptablepartstate( #"last_explode", #"on", 0 );
        }
        else if ( bomb.index == 0 )
        {
            bomb setscriptablepartstate( #"first_explode", #"on", 0 );
        }
        else
        {
            bomb setscriptablepartstate( #"second_explode", #"on", 0 );
        }
        
        wait 0.05;
        bomb delete();
        return;
    }
    
    bomb detonate();
}

// Namespace nuke
// Params 2
// Checksum 0x40e44848, Offset: 0x31ba
// Size: 0x6a
function function_978dcf15de4c2c31( bomb, traveltime )
{
    bomb endon( #"death" );
    bomb endon( #"explode" );
    timecounter = 0;
    var_4389ac0c404fdb4 = 0;
    
    while ( true )
    {
        if ( timecounter >= 8 )
        {
            break;
        }
        
        timecounter += 0.05;
        wait 0.05;
    }
}

// Namespace nuke
// Params 3
// Checksum 0xa2cd4eb6, Offset: 0x322c
// Size: 0x342
function function_aa8b1b4adf8f6b80( owner, position, killradius )
{
    killradiussq = killradius * killradius;
    nukeattacker = owner;
    nukeweapon = makeweapon( level.nukeinfo.weapon );
    characterlist = utility::function_1b1340a94b43b874( position, killradius );
    
    foreach ( character in characterlist )
    {
        if ( !isdefined( character ) )
        {
            continue;
        }
        
        if ( player::isreallyalive( character ) )
        {
            character.nuked = 1;
            
            if ( level.teambased )
            {
                if ( isdefined( owner ) && character.team == owner.team || !isdefined( owner ) )
                {
                    nukeattacker = character;
                }
            }
            else if ( !isdefined( owner ) )
            {
                nukeattacker = character;
            }
            
            character dodamage( 999999, level.nukeinfo.inflictor.origin, nukeattacker, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", nukeweapon, "none" );
        }
    }
    
    killstreaklist = level.activekillstreaks;
    vehiclelist = undefined;
    
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.interact ) && isdefined( level.vehicle.interact.vehicles ) )
    {
        vehiclelist = level.vehicle.interact.vehicles;
    }
    
    equipmentlist = [[ level.getactiveequipmentarray ]]();
    activeobjects = [];
    activeobjects = arraycombineunique( activeobjects, killstreaklist, vehiclelist, equipmentlist );
    
    foreach ( object in activeobjects )
    {
        if ( !isdefined( object ) )
        {
            continue;
        }
        
        if ( distancesquared( object.origin, position ) > killradiussq )
        {
            continue;
        }
        
        if ( object vehicle::is_vehicle() && !isdefined( object.streakinfo ) )
        {
            object.dontspawnhusk = 1;
            object vehicle::explode();
            continue;
        }
        
        object dodamage( 99999, level.nukeinfo.inflictor.origin, nukeattacker, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", nukeweapon, "none" );
    }
}

// Namespace nuke
// Params 6
// Checksum 0xb8345c33, Offset: 0x3576
// Size: 0x1c3
function nuke_launchmissile( owner, streakinfo, launchpos, explodepos, traveltime, nukeweapon )
{
    level endon( #"game_ended" );
    
    if ( isplayer( owner ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
        {
            level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_nuke", owner );
        }
    }
    
    nukegravity = ( 0, 0, -1 * getdvarfloat( @"bg_gravity", 800 ) );
    nukevelocity = ( explodepos - 0.5 * nukegravity * squared( traveltime ) - launchpos ) / traveltime;
    level.nukeinfo.missile = magicgrenademanual( nukeweapon, launchpos, nukevelocity, traveltime );
    level.nukeinfo.missile setscriptablepartstate( #"launch", #"on", 0 );
    
    /#
        var_63708a99e4f3aa46 = getdvarint( @"hash_35e0e06e57d92306", 0 );
        
        if ( var_63708a99e4f3aa46 )
        {
            sphere( launchpos, 500, ( 0, 1, 0 ), 0, 1000 );
            sphere( explodepos, 500, ( 1, 0, 0 ), 0, 1000 );
            
            while ( isdefined( level.nukeinfo.missile ) )
            {
                sphere( level.nukeinfo.missile.origin, 100, ( 1, 1, 1 ), 0, 1 );
                wait 0.05;
            }
        }
    #/
}

// Namespace nuke
// Params 3
// Checksum 0x704470c8, Offset: 0x3741
// Size: 0x157
function nuke_findunobstructedfiringinfo( nukestart, nukeend, var_78e59aa159b9a7e2 )
{
    nukeinfo = spawnstruct();
    collisioncontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    currentmin = -2000;
    currentmax = 2000;
    nukegravity = ( 0, 0, -1 * getdvarfloat( @"bg_gravity", 800 ) );
    
    while ( true )
    {
        var_59c193ecf13ab5b1 = nukestart;
        var_54de6522fa6c5f28 = var_59c193ecf13ab5b1 + ( 0, 0, 5000 );
        
        if ( trace::ray_trace_passed( var_59c193ecf13ab5b1, var_54de6522fa6c5f28, undefined, collisioncontents ) )
        {
            nukevelocity = ( nukeend - 0.5 * nukegravity * squared( var_78e59aa159b9a7e2 ) - var_59c193ecf13ab5b1 ) / var_78e59aa159b9a7e2;
            nukeinfo.sourcepos = var_59c193ecf13ab5b1;
            nukeinfo.goalpos = nukeend;
            nukeinfo.initvelocity = nukevelocity;
            break;
        }
        
        var_59c193ecf13ab5b1 += anglestoright( self.angles ) * randomintrange( currentmin, currentmax );
        currentmin = int( currentmin * 1.3 );
        currentmax = int( currentmax * 1.3 );
        waitframe();
    }
    
    return nukeinfo;
}

// Namespace nuke
// Params 2
// Checksum 0x6fa316fb, Offset: 0x38a1
// Size: 0x2aa
function nuke_explosion( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    nuke_cleartimer();
    level.nukeinfo.detonated = 1;
    level notify( #"nuke_detonated" );
    
    if ( streakinfo.skipexplosion )
    {
        return;
    }
    
    if ( isdefined( level.nukeinfo.missile ) )
    {
        level.nukeinfo.missile setscriptablepartstate( #"launch", #"off", 0 );
        level.nukeinfo.missile delete();
    }
    
    var_6731f527e8cddba3 = spawn( "script_model", level.nukeinfo.goalpoint );
    var_6731f527e8cddba3 setmodel( "ks_nuke_mp" );
    var_6731f527e8cddba3 setscriptablepartstate( #"explode", #"on", 0 );
    
    if ( utility::issharedfuncdefined( #"entity", #"hash_cb0d9e569e0f2002" ) )
    {
        var_6731f527e8cddba3 thread [[ utility::getsharedfunc( #"entity", #"hash_cb0d9e569e0f2002" ) ]]( 50 );
    }
    
    thread nuke_startexplosionaudio( level.nukeinfo.goalpoint, streakinfo );
    
    if ( level.nukeinfo.nuketype != "nuke_select_location" )
    {
        foreach ( character in level.characters )
        {
            if ( [[ utility::getsharedfunc( #"nuke", #"cankill" ) ]]( character, nuke_cankilleverything() ) )
            {
                if ( isplayer( character ) )
                {
                    if ( player::isreallyalive( character ) )
                    {
                        character thread nuke_startnukedeathfx();
                    }
                }
            }
        }
        
        return;
    }
    
    foreach ( character in level.characters )
    {
        if ( isplayer( character ) && player::isreallyalive( character ) )
        {
            character thread nuke_startnukedeathfx_chooselocationversion();
        }
    }
}

// Namespace nuke
// Params 2
// Checksum 0xef881ab6, Offset: 0x3b53
// Size: 0xde
function nuke_startexplosionaudio( explosionpos, streakinfo )
{
    if ( !isdefined( bundle ) )
    {
        bundle = level.streakglobals.streakbundles[ streakinfo.streakname ?? "nuke" ];
    }
    
    if ( isdefined( bundle.var_78651b78e6419e7e ) )
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( bundle.var_78651b78e6419e7e, 6 );
        }
    }
}

// Namespace nuke
// Params 2
// Checksum 0x36e60e92, Offset: 0x3c39
// Size: 0xa6
function nuke_slowmo( owner, streakinfo )
{
    if ( level.nukeinfo.nuketype == "nuke_select_location" )
    {
        return;
    }
    
    level endon( #"nuke_cancelled" );
    
    if ( streakinfo.skipslowmo )
    {
        return;
    }
    
    setnuketimescalefactor();
    level waittill( #"hash_44e31ad9646385b5" );
    setslowmotion( 1, 0.25, 0.1 );
    
    /#
        endgameoff = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !endgameoff )
        {
            wait 3;
            setslowmotion( 0.25, 1, 0 );
        }
    #/
}

// Namespace nuke
// Params 0
// Checksum 0x3a015240, Offset: 0x3ce7
// Size: 0x39
function setnuketimescalefactor()
{
    if ( !level.nukeinfo.timescalefactor )
    {
        soundsettimescalefactorfromtable( "nuke" );
        level.nukeinfo.timescalefactor = 1;
    }
}

// Namespace nuke
// Params 2
// Checksum 0xcec0fdc8, Offset: 0x3d28
// Size: 0x9a
function nuke_dof( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    
    foreach ( player in level.players )
    {
        player thread nuke_adjustexplosiondof();
    }
}

// Namespace nuke
// Params 0
// Checksum 0x82f6b212, Offset: 0x3dca
// Size: 0x1c
function nuke_adjustexplosiondof()
{
    self endon( #"disconnect" );
    self setphysicaldepthoffield( 2, 1500 );
}

// Namespace nuke
// Params 2
// Checksum 0xd8138fec, Offset: 0x3dee
// Size: 0x199
function nuke_vision( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    level.nukeinfo.visioninprogress = 1;
    
    if ( streakinfo.skipvision )
    {
        return;
    }
    
    visionsetnaked( "nuke_global_flash", 0.05 );
    setdvar( @"hash_d18838f3e4b65d16", 0 );
    
    if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( 0.5 );
    }
    
    level notify( #"hash_e682344e5c5e14f0" );
    level thread nuke_fadeflashvision( 1, 2 );
    level waittill( #"hash_44e31ad9646385b5" );
    level thread nuke_updatevisiononhostmigration();
    level nuke_setaftermathvision( 5 );
    wait 1;
    
    if ( !level.var_4389235061115e3a )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_world_fade", 1 );
            level thread game_utility::fadetoblackforplayer( player, 0, 0.25 );
        }
    }
    
    level.nukeinfo.visioninprogress = 0;
}

// Namespace nuke
// Params 2
// Checksum 0xb92dc3b9, Offset: 0x3f8f
// Size: 0x59
function nuke_fadeflashvision( var_d174c51744023a2f, var_f1056821009d3dce )
{
    if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( var_d174c51744023a2f );
    }
    
    visionsetnaked( "", var_f1056821009d3dce );
}

// Namespace nuke
// Params 2
// Checksum 0x989c4651, Offset: 0x3ff0
// Size: 0x54a
function nuke_death( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    level notify( #"hash_44e31ad9646385b5" );
    winner = level.nukeinfo.player;
    
    if ( level.teambased )
    {
        winner = level.nukeinfo.inflictor.team;
    }
    
    if ( utility::issharedfuncdefined( #"nuke", #"hostmigration_waittillhostmigrationdone" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hostmigration_waittillhostmigrationdone" ) ]]();
    }
    
    var_a75c483bd9b64c5d = nuke_cankilleverything();
    
    if ( isdefined( level.nukeinfo.player ) )
    {
        if ( level.nukeinfo.nuketype != "nuke_select_location" )
        {
            foreach ( character in level.characters )
            {
                if ( [[ utility::getsharedfunc( #"nuke", #"cankill" ) ]]( character, var_a75c483bd9b64c5d ) )
                {
                    if ( isplayer( character ) )
                    {
                        character.nuked = 1;
                        
                        if ( player::isreallyalive( character ) )
                        {
                            if ( !character.safefromnuke )
                            {
                                if ( utility::issharedfuncdefined( #"nuke", #"killplayerwithattacker" ) )
                                {
                                    [[ utility::getsharedfunc( #"nuke", #"killplayerwithattacker" ) ]]( character );
                                }
                            }
                        }
                    }
                }
            }
            
            if ( var_a75c483bd9b64c5d )
            {
                if ( utility::issharedfuncdefined( #"nuke", #"hash_41868e03ee00f30d" ) )
                {
                    [[ utility::getsharedfunc( #"nuke", #"hash_41868e03ee00f30d" ) ]]();
                }
            }
            else if ( !level.blocknukekills )
            {
                enemyteams = team_utility::getenemyteams( level.nukeinfo.inflictor.team );
                
                foreach ( entry in enemyteams )
                {
                    if ( utility::issharedfuncdefined( #"nuke", #"hash_41868e03ee00f30d" ) )
                    {
                        [[ utility::getsharedfunc( #"nuke", #"hash_41868e03ee00f30d" ) ]]( entry );
                    }
                }
            }
            
            /#
                if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
                {
                    [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:x71>", level.nukeinfo.player );
                }
            #/
        }
        else
        {
            foreach ( character in level.characters )
            {
                isplayerinradzone = 0;
                
                if ( utility::issharedfuncdefined( #"nuke", #"isplayerinradzone" ) )
                {
                    isplayerinradzone = [[ utility::getsharedfunc( #"nuke", #"isplayerinradzone" ) ]]( character, level.nukeinfo.goalpoint, 25000000 );
                }
                
                if ( isplayerinradzone )
                {
                    character.nuked = 1;
                    
                    if ( player::isreallyalive( character ) )
                    {
                        if ( utility::issharedfuncdefined( #"nuke", #"hash_578d8cafcdd67404" ) )
                        {
                            [[ utility::getsharedfunc( #"nuke", #"hash_578d8cafcdd67404" ) ]]( character );
                        }
                    }
                }
            }
        }
        
        if ( !level.mercywintriggered )
        {
            if ( isdefined( level.nukeinfo.player ) && isdefined( streakinfo ) )
            {
                level.nukeinfo.player killstreak_utility::recordkillstreakendstats( streakinfo );
            }
        }
    }
    
    if ( var_a75c483bd9b64c5d )
    {
        /#
            var_491df81ff35fe9bb = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
            
            if ( !var_491df81ff35fe9bb )
            {
                level.nukeinfo.incoming = undefined;
                level.nukeinfo.player = undefined;
                return;
            }
        #/
        
        while ( level.nukeinfo.visioninprogress )
        {
            waitframe();
        }
        
        level.nukeinfo.gameover = 1;
        level thread nuke_delayendgame( 0, winner, 1, undefined, streakinfo );
    }
}

// Namespace nuke
// Params 2
// Checksum 0xa83a2a8, Offset: 0x4542
// Size: 0x184
function function_28d6684a96cab3e0( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    level waittill( #"hash_55462fd1ecb1f35c" );
    
    if ( !streakinfo.var_9065341eff512952 )
    {
        explodetime = level.nukeinfo.explosiontimer;
        flashvisionset = "nuke_global_flash";
        bundle = level.nukeinfo.bundle;
        
        if ( isdefined( bundle ) && isdefined( bundle.var_b4268101081288b1 ) )
        {
            flashvisionset = bundle.var_b4268101081288b1;
        }
        
        visionsetfadetoblack( flashvisionset, explodetime * 1.75 );
    }
    
    if ( !isdefined( bundle ) )
    {
        bundle = level.streakglobals.streakbundles[ streakinfo.streakname ?? "nuke" ];
    }
    
    if ( isdefined( bundle.var_78651b78e6419e7e ) )
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( bundle.var_78651b78e6419e7e, 6 );
        }
    }
}

// Namespace nuke
// Params 3
// Checksum 0x5d223797, Offset: 0x46ce
// Size: 0x22d
function function_984972b0639d3d61( owner, streakinfo, var_d9ea6da83ae723a1 )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    level waittill( #"hash_b097322db210669", position );
    bundle = level.nukeinfo.bundle;
    
    if ( isdefined( bundle.var_300e136be2f389b7 ) )
    {
        if ( bundle.var_674f73a081d449bc == #"gesture" )
        {
            level thread function_94c2edd1631896d( streakinfo );
        }
        else if ( bundle.var_674f73a081d449bc == #"animation" )
        {
            level thread function_48a0946d482b9b52( streakinfo, position, var_d9ea6da83ae723a1 );
        }
        
        wait bundle.var_300e136be2f389b7;
    }
    
    shouldfreeze = 1;
    
    /#
        if ( getdvarint( @"hash_256c32636f3dcef2", 0 ) > 0 )
        {
            shouldfreeze = 0;
        }
    #/
    
    if ( shouldfreeze )
    {
        foreach ( player in level.players )
        {
            player player::_freezecontrols( 1 );
        }
    }
    
    function_9d0bbd078749eaa9();
    wait bundle.var_ad011ecd8000b5a1 ?? 0.25;
    function_b0a970aaed5e354f( streakinfo );
    
    if ( !level.var_4389235061115e3a )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            level thread game_utility::fadetoblackforplayer( player, 0, 3 );
        }
    }
    
    level notify( #"hash_1c088db2222668c4" );
}

// Namespace nuke
// Params 3, eflags: 0x4
// Checksum 0xd156c59b, Offset: 0x4903
// Size: 0xec
function private function_8eddd743ee520031( owner, streakinfo, var_d9ea6da83ae723a1 )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    bundle = level.nukeinfo.bundle;
    
    if ( streakinfo.var_30a453e5257cf0c8 )
    {
        return;
    }
    
    var_39608ff9f170fda3 = [ owner ];
    
    /#
        if ( var_d9ea6da83ae723a1 )
        {
            var_39608ff9f170fda3 = undefined;
        }
    #/
    
    if ( bundle.var_67b1129c17594f92 )
    {
        gestureanimtime = owner getgestureanimlength( bundle.var_38970da1c7eca0a5 ) ?? 5;
        function_71a571e2c726559b( bundle.var_67b1129c17594f92, var_39608ff9f170fda3, bundle.var_aa88a7c836c913d4, gestureanimtime, undefined, var_d9ea6da83ae723a1 );
        wait gestureanimtime;
        function_9abc2816eb2c62b( bundle.var_67b1129c17594f92, var_39608ff9f170fda3 );
    }
}

// Namespace nuke
// Params 3, eflags: 0x4
// Checksum 0x2cde2a31, Offset: 0x49f7
// Size: 0x152
function private function_b0bc682ca7bc17ec( owner, streakinfo, var_d9ea6da83ae723a1 )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    bundle = level.nukeinfo.bundle;
    
    if ( !bundle.var_a7e2fa48cae4a661 )
    {
        return;
    }
    
    /#
        if ( var_d9ea6da83ae723a1 )
        {
            return;
        }
    #/
    
    var_c53eeb0669417ca7 = level.nuke_origin_struct.origin ?? owner.origin;
    var_d55b70613afb2d69 = level.nuke_origin_struct.angles ?? owner.angles;
    var_1d491b0d753ed72e = var_c53eeb0669417ca7 - anglestoforward( var_d55b70613afb2d69 ) * 200;
    var_e5c97a18524de84 = vectortoangles( var_1d491b0d753ed72e - var_c53eeb0669417ca7 );
    var_f93f6e63c4071a1b = spawnstruct();
    var_f93f6e63c4071a1b.origin = var_1d491b0d753ed72e;
    var_f93f6e63c4071a1b.angles = var_e5c97a18524de84;
    owner inventory_utility::_takeweapon( owner getcurrentweapon() );
    var_f93f6e63c4071a1b scene::function_b95eab90f9ebc981( owner );
    var_f93f6e63c4071a1b thread scene::play( owner, "fulton_extract", bundle.var_2e234c979f476521 );
    outofbounds::enableoobimmunity( owner );
}

// Namespace nuke
// Params 3, eflags: 0x4
// Checksum 0xf30c0d4c, Offset: 0x4b51
// Size: 0x103
function private function_48a0946d482b9b52( streakinfo, position, var_d9ea6da83ae723a1 )
{
    bundle = level.nukeinfo.bundle;
    var_1546c6fefab1d139 = !bundle.var_a7e2fa48cae4a661;
    
    /#
        if ( var_d9ea6da83ae723a1 )
        {
            var_1546c6fefab1d139 = 1;
        }
    #/
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || player == level.nukeinfo.player && !var_1546c6fefab1d139 )
        {
            continue;
        }
        
        level thread function_e2f1c5fe22d7e290( player, position );
    }
}

// Namespace nuke
// Params 3, eflags: 0x4
// Checksum 0xbe321bcd, Offset: 0x4c5c
// Size: 0x381
function private function_e2f1c5fe22d7e290( victim, explodepos, var_5be7429006ed5782 )
{
    victim endon( #"disconnect" );
    bundle = level.nukeinfo.bundle ?? killstreak_utility::function_f943c0602acdc2af( "nuke_multi" );
    level thread function_9ec8847240644ab1( victim, explodepos );
    
    if ( isdefined( bundle.var_f3b9f1d22e9c4542 ) )
    {
        wait bundle.var_f3b9f1d22e9c4542;
    }
    
    victim notify( #"hash_74cfdff39bbe866d" );
    
    if ( !isdefined( var_5be7429006ed5782 ) && ( !bundle.var_240a5d0687e666a7 || !isplayer( victim ) || !player::isreallyalive( victim ) ) )
    {
        return;
    }
    
    outofbounds::enableoobimmunity( victim );
    var_b021735cd0bc82d9 = bundle.var_240a5d0687e666a7;
    var_71f0d8be54819537 = spawnstruct();
    var_71f0d8be54819537.origin = victim.origin;
    var_71f0d8be54819537.angles = victim.angles;
    var_71f0d8be54819537 scene::function_b95eab90f9ebc981( victim );
    var_30e92c60219ca356 = 100;
    var_d380ed92bd90c63f = anglestoforward( victim.angles );
    victimright = anglestoright( victim.angles );
    viewoffsets = [];
    viewoffsets[ "victim_impact_right" ] = 0.707 * ( victimright - var_d380ed92bd90c63f ) * var_30e92c60219ca356;
    viewoffsets[ "victim_impact_left" ] = 0.707 * ( -1 * var_d380ed92bd90c63f - victimright ) * var_30e92c60219ca356;
    victimshot = undefined;
    shotdirection = undefined;
    
    foreach ( offsetindex, viewoffset in viewoffsets )
    {
        victimpos = victim gettagorigin( "j_mainroot" );
        viewpos = victimpos + viewoffset;
        collisioncontents = trace::create_default_contents( 1 );
        raytrace = trace::ray_trace( victimpos, viewpos, victim, collisioncontents );
        
        if ( raytrace[ "hittype" ] != "hittype_none" )
        {
            continue;
        }
        
        shotdirection = offsetindex;
        victimshot = offsetindex + "_0" + randomint( 3 ) + 1;
        break;
    }
    
    /#
        if ( isdefined( level.var_25807bc61fd6685b ) )
        {
            victimshot = level.var_25807bc61fd6685b;
        }
        
        if ( var_5be7429006ed5782 )
        {
            switch ( var_5be7429006ed5782 )
            {
                case -1:
                    victimshot = undefined;
                    break;
                default:
                    if ( var_5be7429006ed5782 >= 1 )
                    {
                        shotdirection = "<dev string:x89>";
                        var_5357422b28af44e3 = getdvarint( @"hash_be0a984424433eac", 0 );
                        
                        if ( var_5357422b28af44e3 == 1 )
                        {
                            shotdirection = "<dev string:x97>";
                        }
                        else if ( var_5357422b28af44e3 == 2 )
                        {
                            shotdirection = "<dev string:xab>";
                        }
                        
                        victimshot = shotdirection + "<dev string:xbe>" + var_5be7429006ed5782;
                    }
                    
                    break;
            }
            
            if ( isdefined( victimshot ) )
            {
                level.var_25807bc61fd6685b = victimshot;
            }
        }
    #/
    
    if ( victimshot )
    {
        var_71f0d8be54819537 thread scene::play( victim, victimshot, var_b021735cd0bc82d9 );
    }
    else if ( victim getscriptablehaspart( "burning" ) )
    {
        victim setscriptablepartstate( "burning", "nuke_active" );
    }
    
    /#
        victim thread function_b76d744a800db80( var_71f0d8be54819537, victimshot, 1 );
    #/
}

// Namespace nuke
// Params 2, eflags: 0x4
// Checksum 0x91ee61fe, Offset: 0x4fe5
// Size: 0xa3
function private function_9ec8847240644ab1( victim, explodepos )
{
    victim endon( #"death_or_disconnect" );
    victim endon( #"hash_74cfdff39bbe866d" );
    bundle = level.nukeinfo.bundle ?? killstreak_utility::function_f943c0602acdc2af( "nuke_multi" );
    targetangles = vectortoangles( explodepos - victim.origin );
    var_2cb7fd4a8b799381 = bundle.var_f3b9f1d22e9c4542 / ( 2 ?? 0.5 );
    wait var_2cb7fd4a8b799381;
    victim setplayerangles( targetangles );
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x1be96eb6, Offset: 0x5090
// Size: 0xb7
function private function_94c2edd1631896d( streakinfo )
{
    if ( streakinfo.var_30a453e5257cf0c8 )
    {
        return;
    }
    
    bundle = level.nukeinfo.bundle;
    wait bundle.var_4f374c5e8b23b008 ?? 0.5;
    function_71a571e2c726559b( bundle.var_b528cd3a29e0a075 ?? "t10_test_nuke_death_start" );
    thread function_f5fd107ec5da40d2( streakinfo, 0.5 );
    wait bundle.var_dde46135cdc6562b ?? 1.5;
    function_9abc2816eb2c62b();
    function_71a571e2c726559b( bundle.var_8059c43b20dbe4cc ?? "t10_test_nuke_death_end" );
    setomnvarforallclients( "nuke_detonated", 1 );
}

// Namespace nuke
// Params 2, eflags: 0x4
// Checksum 0xd871ac61, Offset: 0x514f
// Size: 0x6a
function private function_f5fd107ec5da40d2( streakinfo, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    bundle = level.nukeinfo.bundle;
    var_14d3c11303c2f664 = bundle.var_14d3c11303c2f664;
    
    if ( !isdefined( var_14d3c11303c2f664 ) )
    {
        return;
    }
    
    pbgpostfxbundlestart( #"all", var_14d3c11303c2f664 );
}

// Namespace nuke
// Params 2, eflags: 0x4
// Checksum 0x99b16589, Offset: 0x51c1
// Size: 0x6a
function private function_b0a970aaed5e354f( streakinfo, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    bundle = level.nukeinfo.bundle;
    var_14d3c11303c2f664 = bundle.var_14d3c11303c2f664;
    
    if ( !isdefined( var_14d3c11303c2f664 ) )
    {
        return;
    }
    
    pbgpostfxbundleend( #"all", var_14d3c11303c2f664 );
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x9407aa9e, Offset: 0x5233
// Size: 0xa5
function private function_88ccc42d0a7f120c( partstate )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player setscriptablepartstate( #"nuke_burned", partstate );
    }
}

// Namespace nuke
// Params 6, eflags: 0x4
// Checksum 0xa5d5aee0, Offset: 0x52e0
// Size: 0x130
function private function_71a571e2c726559b( gestureweaponname, var_39608ff9f170fda3, var_b49fd32716635b41, var_b7c677cd8b24372d, phoneomnvaroverride, var_7d6f1f2ea07396ca )
{
    gestureweaponobj = makeweapon( gestureweaponname );
    
    if ( isdefined( gestureweaponobj ) && !isnullweapon( gestureweaponobj ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || var_39608ff9f170fda3.size > 0 && arraycontains( var_39608ff9f170fda3, player ) )
            {
                continue;
            }
            
            if ( var_b49fd32716635b41 )
            {
                var_7af0b6704a4242f2 = var_7d6f1f2ea07396ca ?? ( player == level.nukeinfo.player ? 0 : 1 );
                player thread function_e0cdb607fd8469b4( var_7af0b6704a4242f2, var_b7c677cd8b24372d, phoneomnvaroverride );
            }
            
            player giveandfireoffhand( gestureweaponobj );
        }
    }
}

// Namespace nuke
// Params 2, eflags: 0x4
// Checksum 0xdb960804, Offset: 0x5418
// Size: 0xe4
function private function_9abc2816eb2c62b( weaponoverride, var_39608ff9f170fda3 )
{
    if ( isdefined( weaponoverride ) )
    {
        var_6ca7f82e4130a28b = makeweapon( weaponoverride );
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || var_39608ff9f170fda3.size > 0 && arraycontains( var_39608ff9f170fda3, player ) )
        {
            continue;
        }
        
        currentweapon = var_6ca7f82e4130a28b ?? player getcurrentweapon();
        player.var_e056a1714810bc81 = currentweapon;
        player takeweapon( currentweapon );
    }
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0xd8681d3b, Offset: 0x5504
// Size: 0x96
function private function_4e5beac0a580e766()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player ismeatshieldattacker() )
        {
            player stopmeatshield( 14 );
        }
        
        player function_3181733c19782bcc( 0 );
    }
}

/#

    // Namespace nuke
    // Params 0, eflags: 0x4
    // Checksum 0x8592d7e5, Offset: 0x55a2
    // Size: 0xb5, Type: dev
    function private function_38be74a52a4953b9()
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_e056a1714810bc81 = player.var_e056a1714810bc81;
            
            if ( isdefined( var_e056a1714810bc81 ) && !isnullweapon( var_e056a1714810bc81 ) )
            {
                player giveweapon( var_e056a1714810bc81 );
                player switchtoweaponimmediate( var_e056a1714810bc81 );
            }
        }
    }

#/

// Namespace nuke
// Params 2
// Checksum 0x26b741c1, Offset: 0x565f
// Size: 0x186
function function_feec581b7f380db9( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    explodetime = level.nukeinfo.explosiontimer;
    var_7b302fea6c41269c = explodetime / 3;
    var_fd5a139b97ad3270 = [ "far", "mid", "near" ];
    
    for ( motionindex = 0; motionindex < var_fd5a139b97ad3270.size ; motionindex++ )
    {
        var_dd080ebd18ba0667 = "player_mgb_shake_" + var_fd5a139b97ad3270[ motionindex ] + "_mp";
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player notify( #"hash_ffe4628f6df846ee" );
            
            if ( !player player::isreallyalive() )
            {
                level thread function_b9e8378d81bcc11d( player, var_dd080ebd18ba0667, "spawned_player" );
                continue;
            }
            
            if ( player utility::isusingremote() )
            {
                level thread function_b9e8378d81bcc11d( player, var_dd080ebd18ba0667, "stopped_using_remote" );
                continue;
            }
            
            player_utility::function_99d180c3f0ca93b8( player, var_dd080ebd18ba0667, 0, 1 );
        }
        
        wait var_7b302fea6c41269c;
    }
}

// Namespace nuke
// Params 3
// Checksum 0xfbb2f1e6, Offset: 0x57ed
// Size: 0x71
function function_b9e8378d81bcc11d( player, var_dd080ebd18ba0667, triggernotify )
{
    player endon( #"death_or_disconnect" );
    player endon( #"hash_ffe4628f6df846ee" );
    player endon( #"hash_158ab826f827bb4" );
    level endon( #"game_ended" );
    player waittill( triggernotify );
    player_utility::function_99d180c3f0ca93b8( player, var_dd080ebd18ba0667, 0, 1 );
    player notify( #"hash_158ab826f827bb4" );
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x6179d947, Offset: 0x5866
// Size: 0x83
function private function_b99c13d2129b3f37()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player clearcinematicmotionoverride();
    }
}

// Namespace nuke
// Params 2
// Checksum 0xe634820a, Offset: 0x58f1
// Size: 0x15b
function function_e8442f18b85ce76f( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    level endon( #"game_ended" );
    
    if ( streakinfo.var_9d7850c81d7e0d81 )
    {
        return;
    }
    
    level waittill( #"hash_1c088db2222668c4" );
    level notify( #"nuke_end_game" );
    winner = level.nukeinfo.player;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"winners_circle" ][ #"hash_4f3082ac2c8b6511" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( level.teambased )
    {
        winner = level.nukeinfo.inflictor.team;
    }
    
    /#
        var_491df81ff35fe9bb = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !var_491df81ff35fe9bb )
        {
            level.nukeinfo.incoming = undefined;
            level.nukeinfo.player = undefined;
            setomnvarforallclients( "<dev string:xc1>", 0 );
            function_38be74a52a4953b9();
            function_b99c13d2129b3f37();
            return;
        }
    #/
    
    level.nukeinfo.gameover = 1;
    level thread nuke_delayendgame( 10, winner, 1, undefined, streakinfo );
}

// Namespace nuke
// Params 5
// Checksum 0xa892fa4d, Offset: 0x5a54
// Size: 0x104
function nuke_delayendgame( delaytime, winner, playbnk, var_b04e5d98684d277b, streakinfo )
{
    level endon( #"game_ended" );
    bundle = level.nukeinfo.bundle;
    delaytime = bundle.var_37058a84b4c45911 ?? delaytime;
    playbnk = bundle.var_5c65549e08d71062 ?? playbnk;
    var_736d3d6bcba15860 = bundle.var_a6905ad9893a2c29 ?? 0;
    
    if ( var_736d3d6bcba15860 )
    {
        level function_3be1a7d5f41be3f( level.nukeinfo.player );
    }
    else if ( playbnk )
    {
        level thread function_426373314ff64956( var_b04e5d98684d277b, streakinfo );
    }
    
    if ( utility::issharedfuncdefined( #"nuke", #"delayendgame" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"delayendgame" ) ]]( delaytime, winner );
    }
}

// Namespace nuke
// Params 2
// Checksum 0xd5d3ebd5, Offset: 0x5b60
// Size: 0x139
function function_426373314ff64956( delaytime, streakinfo )
{
    level endon( #"game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        hostmigration::waitlongdurationwithpause( delaytime );
    }
    
    level notify( #"hash_1b0ff2ac68105ebb" );
    bundle = level.nukeinfo.bundle;
    var_fc127f5de08c590 = function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb ) ?? -1;
    setomnvarforallclients( "ui_movie_parent_bundle", var_fc127f5de08c590 );
    setomnvarforallclients( "post_game_state", 12 );
    level utility::flag_set( "nuke_bink_done" );
    
    if ( !level.var_4389235061115e3a )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            level thread game_utility::fadetoblackforplayerkeepui( player, 0, 1 );
        }
    }
}

// Namespace nuke
// Params 2
// Checksum 0xe8458104, Offset: 0x5ca1
// Size: 0x11a
function function_3be1a7d5f41be3f( owner, shotoverride )
{
    bundle = level.nukeinfo.bundle ?? killstreak_utility::function_f943c0602acdc2af( "nuke_multi" );
    var_a291348383831c01 = level.mapcenter + ( 0, 0, 25000 );
    var_dcbeee83d06f880f = owner.angles;
    var_3a62806b46789c6f = shotoverride ?? "exfil_0" + randomint( 3 ) + 1;
    owner unlink();
    endgameroot = { #angles:var_dcbeee83d06f880f, #origin:var_a291348383831c01 };
    scene::add_scene_func( bundle.var_9ba79d927fe36ddf, &function_35bc74aa24f5f20a, "callback_play" );
    scene::add_scene_func( bundle.var_9ba79d927fe36ddf, &function_9f9db04a52a1700d, "callback_done" );
    endgameroot thread scene::play( owner, var_3a62806b46789c6f, bundle.var_9ba79d927fe36ddf );
    
    /#
        owner thread function_b76d744a800db80( endgameroot, var_3a62806b46789c6f );
    #/
}

// Namespace nuke
// Params 0
// Checksum 0x62df149c, Offset: 0x5dc3
// Size: 0x28
function function_35bc74aa24f5f20a()
{
    gunboatent = scene::get_entity( "Prop 2" );
    
    if ( isdefined( gunboatent ) )
    {
        gunboatent function_4ad5dfcbcd39af6e();
    }
}

// Namespace nuke
// Params 0
// Checksum 0x294002f1, Offset: 0x5df3
// Size: 0x28
function function_9f9db04a52a1700d()
{
    gunboatent = scene::get_entity( "Prop 2" );
    
    if ( isdefined( gunboatent ) )
    {
        gunboatent function_bcd01c99c2f119e7();
    }
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0x21f6ed08, Offset: 0x5e23
// Size: 0x122
function private init_gunboat_lighting()
{
    lgt_rig = spawnstruct();
    lgt_origin = getent( "ks_gunship_lighting_origin", "targetname" );
    
    if ( !isdefined( lgt_origin ) )
    {
        return;
    }
    
    linked_ents = lgt_origin utility::get_linked_ents();
    
    if ( isdefined( linked_ents ) && linked_ents.size != 0 )
    {
        foreach ( ent in linked_ents )
        {
            ent linkto( lgt_origin );
            
            if ( ent.classname == "refelction_probe" )
            {
                lgt_rig.refl_probe = ent;
            }
        }
    }
    
    lgt_rig.og_origin = lgt_origin.origin;
    lgt_rig.og_angles = lgt_origin.angles;
    lgt_rig.lgt_origin = lgt_origin;
    return lgt_rig;
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0xfec832ef, Offset: 0x5f4e
// Size: 0x98
function private function_4ad5dfcbcd39af6e()
{
    if ( !isdefined( level.var_f815cdd10e7efc34 ) )
    {
        level.var_f815cdd10e7efc34 = init_gunboat_lighting();
    }
    
    if ( !isdefined( level.var_f815cdd10e7efc34 ) )
    {
        return;
    }
    
    level.var_f815cdd10e7efc34.lgt_origin.origin = self.origin;
    level.var_f815cdd10e7efc34.lgt_origin.angles = self.angles;
    level.var_f815cdd10e7efc34.lgt_origin linkto( self, "tag_origin" );
}

// Namespace nuke
// Params 0, eflags: 0x4
// Checksum 0xde9548ee, Offset: 0x5fee
// Size: 0x8b
function private function_bcd01c99c2f119e7()
{
    if ( !isdefined( level.var_f815cdd10e7efc34 ) )
    {
        return;
    }
    
    level.var_f815cdd10e7efc34.lgt_origin unlink();
    level.var_f815cdd10e7efc34.lgt_origin.origin = level.var_f815cdd10e7efc34.og_origin;
    level.var_f815cdd10e7efc34.lgt_origin.angles = level.var_f815cdd10e7efc34.og_angles;
}

// Namespace nuke
// Params 2
// Checksum 0x828fe4c1, Offset: 0x6081
// Size: 0x12c
function nuke_earthquake( owner, streakinfo )
{
    level endon( #"nuke_cancelled" );
    earthquakeorigin = level.nukeinfo.goalpoint;
    earthquake( 0.4, 1.5, earthquakeorigin, 100000 );
    level thread nuke_playshockwaveearthquake( streakinfo );
    level waittill( #"hash_44e31ad9646385b5" );
    
    if ( level.nukeinfo.nuketype == "nuke_select_location" )
    {
        earthquake( 0.3, 1, earthquakeorigin, 100000 );
    }
    else
    {
        earthquake( 0.7, 3, earthquakeorigin, 100000 );
    }
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace nuke
// Params 1
// Checksum 0x88db92da, Offset: 0x61b5
// Size: 0x8f
function nuke_playshockwaveearthquake( streakinfo )
{
    level endon( #"nuke_cancelled" );
    level endon( #"hash_44e31ad9646385b5" );
    earthquakeintensity = 0.01;
    earthquakeorigin = level.nukeinfo.goalpoint;
    
    while ( true )
    {
        earthquake( earthquakeintensity, 0.05, earthquakeorigin, 100000 );
        wait 0.05;
        earthquakeintensity += 0.0015;
        
        if ( earthquakeintensity >= 0.3 )
        {
            earthquakeintensity = 0.3;
        }
    }
}

// Namespace nuke
// Params 0
// Checksum 0xfc15fbb9, Offset: 0x624c
// Size: 0x22
function onplayerspawned()
{
    if ( isdefined( level.nukeinfo.detonated ) )
    {
        thread nuke_setvisionforplayer( 0, 0 );
    }
}

// Namespace nuke
// Params 2
// Checksum 0xc7230fba, Offset: 0x6276
// Size: 0x51
function nuke_setvisionforplayer( delaytime, transitiontime )
{
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    /#
        var_491df81ff35fe9bb = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !var_491df81ff35fe9bb )
        {
            return;
        }
    #/
    
    self visionsetnakedforplayer( "nuke_global_aftermath", transitiontime );
}

// Namespace nuke
// Params 1
// Checksum 0x5c66a5fa, Offset: 0x62cf
// Size: 0xc7
function nuke_updateuitimers( traveltime )
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level endon( #"nuke_cancelled" );
    level endon( #"hash_44e31ad9646385b5" );
    var_d83f0fd6ab64c192 = int( traveltime * 1000 + gettime() );
    setomnvar( "ui_nuke_end_milliseconds", var_d83f0fd6ab64c192 );
    level waittill( #"host_migration_begin" );
    timepassed = 0;
    
    if ( utility::issharedfuncdefined( #"nuke", #"hostmigration_waittillhostmigrationdone" ) )
    {
        timepassed = [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]();
    }
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_nuke_end_milliseconds", var_d83f0fd6ab64c192 + timepassed );
    }
}

// Namespace nuke
// Params 0
// Checksum 0x9397f84e, Offset: 0x639e
// Size: 0x2c
function nuke_updatevisiononhostmigration()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"host_migration_end" );
        level nuke_setaftermathvision( 0 );
    }
}

// Namespace nuke
// Params 1
// Checksum 0x8f46c85c, Offset: 0x63d2
// Size: 0x82
function nuke_setaftermathvision( transitiontime )
{
    /#
        var_491df81ff35fe9bb = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !var_491df81ff35fe9bb )
        {
            return;
        }
    #/
    
    shouldnukeendgame = 1;
    
    if ( utility::issharedfuncdefined( #"nuke", #"shouldnukeendgame" ) )
    {
        shouldnukeendgame = [[ utility::getsharedfunc( #"nuke", #"shouldnukeendgame" ) ]]();
    }
    
    if ( !shouldnukeendgame )
    {
        return;
    }
    
    function_9d0bbd078749eaa9();
}

// Namespace nuke
// Params 0
// Checksum 0xf29d5f6f, Offset: 0x645c
// Size: 0xb9
function function_9d0bbd078749eaa9()
{
    setomnvarforallclients( "post_game_state", 11 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !level.var_4389235061115e3a )
        {
            level thread game_utility::fadetoblackforplayer( player, 1 );
        }
        
        player setclienttriggeraudiozonepartialwithfade( "nuke_killstreak", 2, "ambient", "ambient_events" );
    }
}

// Namespace nuke
// Params 0
// Checksum 0x1c3afaea, Offset: 0x651d
// Size: 0xe3
function nuke_startnukedeathfx()
{
    self endon( #"disconnect" );
    
    if ( !self.safefromnuke )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"hash_ab76b187280ae421" ) )
        {
            self [[ utility::getsharedfunc( #"weapons", #"hash_ab76b187280ae421" ) ]]( 1, "nuke_active" );
        }
    }
    
    thread nuke_playrollingdeathfx( 3.25 );
    level waittill( #"hash_44e31ad9646385b5" );
    
    if ( self.burnfxenabled > 0 )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"hash_7d3fa27f0a2ead54" ) )
        {
            self [[ utility::getsharedfunc( #"weapons", #"hash_7d3fa27f0a2ead54" ) ]]( 1, "nuke_active" );
        }
    }
    
    nukedeathtype = 0;
    
    /#
        nukedeathtype = getdvarint( @"hash_7943c6ec7e44f87c", 0 );
    #/
    
    if ( nukedeathtype )
    {
    }
}

// Namespace nuke
// Params 0
// Checksum 0xdafd46c9, Offset: 0x6608
// Size: 0xa3
function nuke_startnukedeathfx_chooselocationversion()
{
    self endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"weapons", #"hash_ab76b187280ae421" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"hash_ab76b187280ae421" ) ]]( 1, "nuke_active" );
    }
    
    thread nuke_playrollingdeathfx( 3.25 );
    level waittill( #"hash_44e31ad9646385b5" );
    
    if ( utility::issharedfuncdefined( #"weapons", #"hash_7d3fa27f0a2ead54" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"hash_7d3fa27f0a2ead54" ) ]]( 1, "nuke_active" );
    }
}

// Namespace nuke
// Params 1
// Checksum 0xc17f8592, Offset: 0x66b3
// Size: 0xc9
function nuke_playrollingdeathfx( delaytime )
{
    self endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( delaytime );
    }
    
    if ( !utility::isusingremote() )
    {
        self visionsetnakedforplayer( "nuke_deathblur", 4 );
    }
    
    fxlocation = self.origin;
    explosionloc = level.nukeinfo.goalpoint;
    bodyloc = fxlocation;
    bodyfx = "nuke_rolling_death";
    playfx( utility::getfx( bodyfx ), fxlocation, explosionloc - bodyloc, undefined, self );
}

// Namespace nuke
// Params 0
// Checksum 0xb8f4835a, Offset: 0x6784
// Size: 0x2b8
function nuke_atomizebody()
{
    self endon( #"disconnect" );
    loc[ 0 ][ 0 ][ "org" ] = self gettagorigin( "j_spineupper" );
    loc[ 0 ][ 0 ][ "angles" ] = self gettagangles( "j_spineupper" );
    loc[ 0 ][ 1 ][ "org" ] = self gettagorigin( "j_spinelower" );
    loc[ 0 ][ 1 ][ "angles" ] = self gettagangles( "j_spinelower" );
    loc[ 0 ][ 2 ][ "org" ] = self gettagorigin( "j_head" );
    loc[ 0 ][ 2 ][ "angles" ] = self gettagangles( "j_head" );
    loc[ 1 ][ 0 ][ "org" ] = self gettagorigin( "j_knee_ri" );
    loc[ 1 ][ 0 ][ "angles" ] = self gettagangles( "j_knee_ri" );
    loc[ 1 ][ 1 ][ "org" ] = self gettagorigin( "j_knee_le" );
    loc[ 1 ][ 1 ][ "angles" ] = self gettagangles( "j_knee_le" );
    loc[ 1 ][ 2 ][ "org" ] = self gettagorigin( "j_elbow_ri" );
    loc[ 1 ][ 2 ][ "angles" ] = self gettagangles( "j_elbow_ri" );
    loc[ 1 ][ 3 ][ "org" ] = self gettagorigin( "j_elbow_le" );
    loc[ 1 ][ 3 ][ "angles" ] = self gettagangles( "j_elbow_le" );
    loc[ 2 ][ 0 ][ "org" ] = self gettagorigin( "j_ankle_le" );
    loc[ 2 ][ 0 ][ "angles" ] = self gettagangles( "j_ankle_le" );
    loc[ 2 ][ 1 ][ "org" ] = self gettagorigin( "j_ankle_ri" );
    loc[ 2 ][ 1 ][ "angles" ] = self gettagangles( "j_ankle_ri" );
    loc[ 2 ][ 2 ][ "org" ] = self gettagorigin( "j_wrist_le" );
    loc[ 2 ][ 2 ][ "angles" ] = self gettagangles( "j_wrist_le" );
    loc[ 2 ][ 3 ][ "org" ] = self gettagorigin( "j_wrist_ri" );
    loc[ 2 ][ 3 ][ "angles" ] = self gettagangles( "j_wrist_ri" );
    self.body hide();
    fxlocation = self.body.origin;
    inflictorloc = level.nukeinfo.inflictor.origin * ( 1, 1, 0 );
    bodyloc = fxlocation * ( 1, 1, 0 );
    bodyfx = "nuke_atomize_body";
    playfx( utility::getfx( bodyfx ), fxlocation, inflictorloc - bodyloc );
}

// Namespace nuke
// Params 0
// Checksum 0x8e6df1d, Offset: 0x6a44
// Size: 0x45, Type: bool
function nuke_cankilleverything()
{
    bundle = level.nukeinfo.bundle;
    
    if ( !bundle.nukecankilleverything )
    {
        return false;
    }
    
    if ( game_utility::getgametype() == "benchmark" )
    {
        return false;
    }
    
    return true;
}

// Namespace nuke
// Params 2
// Checksum 0x1cdb2086, Offset: 0x6a92
// Size: 0x123
function nuke_createradiationzone( owner, streakinfo )
{
    if ( false )
    {
        wait 10;
        playfx( utility::getfx( "vfx_nuke_zone_5000_static_s" ), ( 0, 0, 0 ) );
        nuke_registerradzone( ( 0, 0, 0 ) );
    }
    else
    {
        streakinfo.sealevelorigin = ( level.nukeinfo.goalpoint[ 0 ], level.nukeinfo.goalpoint[ 1 ], parachute::getc130sealevel() );
        playfx( utility::getfx( "vfx_nuke_zone_5000_static_s" ), streakinfo.sealevelorigin );
        nuke_registerradzone( streakinfo.sealevelorigin );
    }
    
    if ( !isdefined( level.nukedangerzones ) )
    {
        level.nukedangerzones = [];
    }
    
    level.nukedangerzones[ level.nukedangerzones.size ] = utility::callsharedfunc( #"spawn", #"addSpawnInfluencer", #"killstreak_nuke", level.nukeinfo.goalpoint );
    thread nuke_finalizelocationnuke( owner );
}

// Namespace nuke
// Params 1
// Checksum 0x5a9de131, Offset: 0x6bbd
// Size: 0x43
function nuke_registerradzone( origin )
{
    if ( !isdefined( level.radzones ) )
    {
        level.radzones = [];
        level thread nuke_radzones_think();
    }
    
    level.radzones[ level.radzones.size ] = origin;
}

// Namespace nuke
// Params 1
// Checksum 0x1485786f, Offset: 0x6c08
// Size: 0x24
function nuke_removeradzone( zoneent )
{
    level.radzones = arrayremove( level.radzones, zoneent );
}

// Namespace nuke
// Params 0
// Checksum 0x7a684c7f, Offset: 0x6c34
// Size: 0x2e5
function nuke_radzones_think()
{
    level endon( #"game_ended" );
    damagetick = 10;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player.inradzone = 0;
            
            foreach ( zoneorigin in level.radzones )
            {
                isplayerinradzone = 0;
                
                if ( utility::issharedfuncdefined( #"nuke", #"isplayerinradzone" ) )
                {
                    isplayerinradzone = [[ utility::getsharedfunc( #"nuke", #"isplayerinradzone" ) ]]( player, zoneorigin, 25000000 );
                }
                
                if ( isplayerinradzone )
                {
                    if ( player.gasmaskequipped )
                    {
                        player gasmask::processdamage( damagetick );
                    }
                    else
                    {
                        if ( utility::issharedfuncdefined( #"game", #"hash_ba0793a371e873b6" ) )
                        {
                            player thread [[ utility::getsharedfunc( #"game", #"hash_ba0793a371e873b6" ) ]]( "MP/NUKE_RADIATION_HURT", 2 );
                        }
                        
                        player dodamage( damagetick, player.origin, player, undefined, "MOD_TRIGGER_HURT" );
                    }
                    
                    player.inradzone = 1;
                    break;
                }
            }
            
            if ( player.inradzone )
            {
                continue;
            }
            
            foreach ( zoneorigin in level.radzones )
            {
                isplayerinradzone = 0;
                
                if ( utility::issharedfuncdefined( #"nuke", #"isplayerinradzone" ) )
                {
                    isplayerinradzone = [[ utility::getsharedfunc( #"nuke", #"isplayerinradzone" ) ]]( player, zoneorigin, 36000000 );
                }
                
                if ( isplayerinradzone )
                {
                    if ( utility::issharedfuncdefined( #"game", #"hash_ba0793a371e873b6" ) )
                    {
                        player thread [[ utility::getsharedfunc( #"game", #"hash_ba0793a371e873b6" ) ]]( "MP/NUKE_RADIATION_WARNING", 2 );
                    }
                    
                    break;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace nuke
// Params 1
// Checksum 0x8f883ecd, Offset: 0x6f21
// Size: 0xe3
function nuke_warnenemiesnukeincoming( var_2d27861c4d19faa2 )
{
    level endon( #"hash_44e31ad9646385b5" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.team == var_2d27861c4d19faa2 )
            {
                if ( utility::issharedfuncdefined( #"game", #"hash_ba0793a371e873b6" ) )
                {
                    player thread [[ utility::getsharedfunc( #"game", #"hash_ba0793a371e873b6" ) ]]( "MP/NUKE_SELECT_LAUNCH_DETECTED", 2 );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace nuke
// Params 1
// Checksum 0x7d949ec5, Offset: 0x700c
// Size: 0x52
function nuke_finalizelocationnuke( owner )
{
    wait 20;
    
    if ( owner.hasnukeselectks )
    {
        owner.hasnukeselectks = 0;
    }
    
    if ( isdefined( owner.killcountthislife ) )
    {
        owner.killcountthislife = 0;
    }
    
    visionsetnaked( "", 1 );
}

// Namespace nuke
// Params 0
// Checksum 0x651dbf3d, Offset: 0x7066
// Size: 0x50
function nuke_abortkillcamonspawn()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( isdefined( player ) )
        {
            player notify( #"abort_killcam" );
            player.cancelkillcam = 1;
        }
    }
}

// Namespace nuke
// Params 3
// Checksum 0x4f35f563, Offset: 0x70be
// Size: 0xe9
function function_e987813b53243a97( nuketype, goalposoverride, bundle )
{
    goalpoint = self.origin + anglestoforward( self.angles ) * 15000;
    
    if ( isdefined( level.nuke_expl_struct ) )
    {
        goalpoint = level.nuke_expl_struct.origin;
    }
    
    if ( nuketype == "nuke_multi" )
    {
        goalpoint = killstreak_utility::killstreak_getmapcenter();
        
        if ( bundle.var_37c4ccffac0530ba )
        {
            goalpoint = level.nuke_origin_struct.origin ?? self.origin;
            goalpoint += anglestoforward( level.nuke_origin_struct.angles ?? self.angles ) * bundle.var_37c4ccffac0530ba;
        }
    }
    
    if ( isdefined( goalposoverride ) )
    {
        goalpoint = goalposoverride;
    }
    
    return goalpoint;
}

// Namespace nuke
// Params 4
// Checksum 0x42d3e0ad, Offset: 0x71b0
// Size: 0x1cb
function function_e245eabc34354517( nuketype, goalpoint, launchposoverride, bundle )
{
    launchpoint = goalpoint + ( 0, 0, 30000 ) + anglestoforward( self.angles ) * 30000;
    
    if ( nuketype == "nuke_multi" )
    {
        launchpoint = goalpoint + ( 0, 0, 15000 ) + anglestoforward( self.angles ) * 15000;
        
        if ( bundle.var_23cc712698359974 )
        {
            launchpoint = killstreak_utility::killstreak_getmapcenter();
            launchpoint += level.var_7f0aa6db090b81f ?? ( 0, 0, 0 );
        }
        else if ( bundle.var_91a5b00a5f0924a )
        {
            launchpoint = level.nuke_origin_struct.origin ?? self.origin;
            launchpoint -= anglestoforward( level.nuke_origin_struct.angles ?? self.angles ) * bundle.var_91a5b00a5f0924a;
            
            if ( bundle.var_e7dafa3e35465e4e )
            {
                launchpoint += ( 0, 0, bundle.var_e7dafa3e35465e4e );
            }
        }
    }
    else if ( isdefined( level.nuke_expl_struct ) )
    {
        var_8d68033c2e85fc8f = vectornormalize( ( goalpoint[ 0 ], goalpoint[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
        launchpoint = goalpoint + var_8d68033c2e85fc8f * 15000;
        launchpoint = launchpoint + ( 0, 0, 30000 ) + var_8d68033c2e85fc8f * 5000;
    }
    else if ( nuketype != "nuke_select_location" )
    {
        /#
            self iprintlnbold( "<dev string:xd1>" );
        #/
    }
    
    if ( isdefined( launchposoverride ) )
    {
        launchpoint = launchposoverride;
    }
    
    return launchpoint;
}

// Namespace nuke
// Params 3
// Checksum 0xb451a73a, Offset: 0x7384
// Size: 0x71
function function_911b4916fa84c2e5( nuketype, var_5cc3bfbb33b6b34e, nukegoalpoint )
{
    bundle = level.nukeinfo.bundle;
    
    if ( bundle.var_23cc712698359974 )
    {
        var_5cc3bfbb33b6b34e = nukegoalpoint + ( 0, 0, 30000 ) + anglestoforward( self.angles ) * 30000;
    }
    
    return var_5cc3bfbb33b6b34e;
}

// Namespace nuke
// Params 3
// Checksum 0x7b87d18c, Offset: 0x73fe
// Size: 0x4b
function function_96b3c1c1db4aba59( nuketype, starttime, starttimeoverride )
{
    starttimer = starttime;
    
    if ( level.mercywintriggered )
    {
        starttimer = 0.7;
    }
    
    if ( isdefined( starttimeoverride ) )
    {
        starttimer = starttimeoverride;
    }
    
    return starttimer;
}

// Namespace nuke
// Params 3
// Checksum 0xba698841, Offset: 0x7452
// Size: 0x25, Type: bool
function function_b95b8d0e48825b80( nuketype, explodetime, var_5fefba97e6418b1c )
{
    return var_5fefba97e6418b1c ?? explodetime;
}

// Namespace nuke
// Params 4
// Checksum 0x67a66fa6, Offset: 0x7480
// Size: 0x95
function nuke_getweapon( streakinfo, nuketype, weaponoverride, bundle )
{
    baseweapon = "nuke_mp";
    
    if ( !isdefined( bundle ) )
    {
        bundle = killstreak_utility::function_f943c0602acdc2af( streakinfo.streakname ?? "nuke" );
    }
    
    if ( isdefined( bundle.var_72930cc4438eb700 ) )
    {
        baseweapon = bundle.var_72930cc4438eb700;
    }
    else if ( nuketype == "nuke_multi" )
    {
        baseweapon = "nuke_multi_mp";
    }
    
    if ( isdefined( weaponoverride ) )
    {
        baseweapon = weaponoverride;
    }
    
    return baseweapon;
}

// Namespace nuke
// Params 1, eflags: 0x4
// Checksum 0x1afa4786, Offset: 0x751e
// Size: 0x5c
function private can_end_game( params )
{
    if ( params.var_3c7ef276ad41c284 )
    {
        return;
    }
    
    if ( level.nukeinfo.incoming && params.endreasontext != game[ "end_reason" ][ "nuke_end" ] )
    {
        params.var_3c7ef276ad41c284 = 1;
    }
}

// Namespace nuke
// Params 3, eflags: 0x4
// Checksum 0x1c827c8f, Offset: 0x7582
// Size: 0x5e
function private function_e0cdb607fd8469b4( var_7af0b6704a4242f2, deployanimtime, phoneomnvaroverride )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( var_7af0b6704a4242f2 == 0 )
    {
        wait 0.525;
    }
    
    self setclientomnvar( phoneomnvaroverride ?? "ui_remote_nuke_sequence", var_7af0b6704a4242f2 );
    thread function_3b663f7bfb376a90( deployanimtime, phoneomnvaroverride );
}

// Namespace nuke
// Params 2, eflags: 0xc
// Checksum 0x8191d795, Offset: 0x75e8
// Size: 0x65
function private function_3b663f7bfb376a90( animlength, phoneomnvaroverride )
{
    self notify( #"hash_eec3c62d1b2f1b58" );
    self endon( #"hash_eec3c62d1b2f1b58" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    utility::waittill_any_timeout( animlength, "death" );
    self setclientomnvar( phoneomnvaroverride ?? "ui_remote_nuke_sequence", -1 );
}

/#

    // Namespace nuke
    // Params 0, eflags: 0x4
    // Checksum 0xf15a6285, Offset: 0x7655
    // Size: 0x1d, Type: dev
    function private init_nuke_debug()
    {
        level thread function_ea7a89a8225a9d31();
        level thread function_5866c69f08c0a155();
        level thread function_b028c19d4ca740e3();
    }

    // Namespace nuke
    // Params 0, eflags: 0x4
    // Checksum 0x3931fda8, Offset: 0x767a
    // Size: 0x8d, Type: dev
    function private function_ea7a89a8225a9d31()
    {
        level endon( #"game_ended" );
        level waittill( #"player_spawned", testvictim );
        
        while ( true )
        {
            var_6ed699685926e841 = getdvarint( @"hash_44ef9f4ed4e26790", -2 );
            
            if ( var_6ed699685926e841 > -2 )
            {
                function_e2f1c5fe22d7e290( testvictim, testvictim.origin + anglestoforward( testvictim.angles ) * 10, var_6ed699685926e841 );
                setdvar( @"hash_44ef9f4ed4e26790", -2 );
            }
            
            waitframe();
        }
    }

    // Namespace nuke
    // Params 0, eflags: 0x4
    // Checksum 0xe8b859be, Offset: 0x770f
    // Size: 0x72, Type: dev
    function private function_5866c69f08c0a155()
    {
        level endon( #"game_ended" );
        level waittill( #"player_spawned", testowner );
        
        while ( true )
        {
            var_82303a2d875af9b0 = getdvarint( @"hash_35459e73bd0470ca", 0 );
            
            if ( var_82303a2d875af9b0 > 0 )
            {
                function_3be1a7d5f41be3f( testowner, "<dev string:x14f>" + var_82303a2d875af9b0 );
                setdvar( @"hash_35459e73bd0470ca", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace nuke
    // Params 0, eflags: 0x4
    // Checksum 0xc4732f90, Offset: 0x7789
    // Size: 0x86, Type: dev
    function private function_b028c19d4ca740e3()
    {
        level endon( #"game_ended" );
        level waittill( #"player_spawned", testowner );
        
        while ( true )
        {
            debuglaunch = getdvarint( @"scr_debug_nuke_replay", -1 );
            
            if ( debuglaunch > -1 )
            {
                streakinfo = killstreak_utility::createstreakinfo( "<dev string:x157>", testowner );
                testowner thread function_c336091a7b0b9f03( streakinfo, debuglaunch );
                setdvar( @"scr_debug_nuke_replay", -1 );
            }
            
            waitframe();
        }
    }

    // Namespace nuke
    // Params 2, eflags: 0x4
    // Checksum 0xd8dc3f6e, Offset: 0x7817
    // Size: 0x514, Type: dev
    function private function_c336091a7b0b9f03( streakinfo, var_d9ea6da83ae723a1 )
    {
        self endon( #"disconnect" );
        bundle = killstreak_utility::function_f943c0602acdc2af( streakinfo.streakname ?? "<dev string:x162>" );
        var_c798ac99eca111f5 = makeweapon( bundle.deployweaponname );
        
        if ( !var_d9ea6da83ae723a1 )
        {
            if ( killstreak_utility::function_8bec29aceea719c3( var_c798ac99eca111f5 ) )
            {
                deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, undefined, undefined, undefined, undefined, var_c798ac99eca111f5, 0 );
            }
            else
            {
                if ( utility::issharedfuncdefined( #"nuke", #"onusesequence", 0 ) )
                {
                    utility::callsharedfunc( #"nuke", #"onusesequence" );
                }
                else if ( bundle.var_aa88a7c836c913d4 )
                {
                    gestureanimtime = self getgestureanimlength( bundle.var_3e96ee2e3dc74467 ) ?? 5;
                    thread function_e0cdb607fd8469b4( 0, gestureanimtime );
                }
                else
                {
                    thread function_853cd7724edb2119();
                }
                
                deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, var_c798ac99eca111f5, "<dev string:x167>", 0 );
            }
            
            if ( !deployresult )
            {
                return;
            }
        }
        
        nukeinfo = spawnstruct();
        nukeinfo.team = self.pers[ "<dev string:x17c>" ];
        nukeinfo.visioninprogress = 0;
        nukeinfo.timescalefactor = 0;
        nukeinfo.nuketype = streakinfo.streakname;
        nukeinfo.streakinfo = streakinfo;
        nukeinfo.incoming = 1;
        
        if ( isplayer( self ) )
        {
            nukeinfo.player = self;
        }
        
        defaultstarttimer = bundle.nukestarttimer ?? 6;
        var_9fde233a0de1b36b = bundle.var_c8e3eb7874635b39 ?? 10;
        var_81368f2be0e4e68a = bundle.var_e3034fae8b863b70 ?? 0;
        var_15d4fcebdac0935 = bundle.var_8f77f69b329c343e ?? 1;
        
        if ( !var_15d4fcebdac0935 )
        {
            var_5fefba97e6418b1c = bundle.var_12130cca92d2fea7 ?? 10;
        }
        
        nukegoalpoint = function_e987813b53243a97( nukeinfo.nuketype, undefined, bundle );
        var_5cc3bfbb33b6b34e = function_e245eabc34354517( nukeinfo.nuketype, nukegoalpoint, undefined, bundle );
        
        /#
            if ( getdvarint( @"scr_debug_nuke", 0 ) )
            {
                level thread debug_utility::drawsphere( nukegoalpoint, 50, 30, ( 1, 1, 0 ) );
                level thread debug_utility::drawsphere( var_5cc3bfbb33b6b34e, 50, 30, ( 1, 1, 0 ) );
                level thread debug_utility::drawline( var_5cc3bfbb33b6b34e, nukegoalpoint, 30, ( 1, 1, 0 ) );
            }
        #/
        
        nukestarttimer = function_96b3c1c1db4aba59( nukeinfo.nuketype, defaultstarttimer, undefined );
        var_80190f60538acc9f = function_b95b8d0e48825b80( nukeinfo.nuketype, var_9fde233a0de1b36b, var_5fefba97e6418b1c );
        nukeweapon = nuke_getweapon( streakinfo, nukeinfo.nuketype, undefined, bundle );
        var_93276ef91758dc84 = function_911b4916fa84c2e5( nukeinfo.nuketype, var_5cc3bfbb33b6b34e, nukegoalpoint );
        
        if ( !isdefined( nukeinfo.clockobject ) )
        {
            nukeinfo.clockobject = spawn( "<dev string:x181>", var_93276ef91758dc84 + ( 0, 0, 100 ) );
            nukeinfo.clockobject dontinterpolate();
            nukeinfo.clockobject hide();
        }
        else
        {
            nukeinfo.clockobject.origin = var_93276ef91758dc84 + ( 0, 0, 100 );
        }
        
        nukeinfo.launchpoint = var_5cc3bfbb33b6b34e;
        nukeinfo.goalpoint = nukegoalpoint;
        nukeinfo.starttimer = nukestarttimer;
        nukeinfo.var_ee7d35f769f5e251 = bundle.var_6475b09c71022fc6 ?? 1;
        nukeinfo.explosiontimer = var_80190f60538acc9f;
        nukeinfo.var_88f920889184c39c = nukestarttimer + var_80190f60538acc9f;
        nukeinfo.var_53b9cf5fb0ec77a3 = var_81368f2be0e4e68a;
        nukeinfo.weapon = nukeweapon;
        nukeinfo.bundle = bundle;
        nukeinfo.player = self;
        level.nukeinfo = nukeinfo;
        level thread nuke_startlaunchsequence( self, streakinfo, undefined, 0, var_d9ea6da83ae723a1 );
        level thread utility::delaythread( nukeinfo.starttimer, &function_b0bc682ca7bc17ec, self, streakinfo, var_d9ea6da83ae723a1 );
        level thread utility::delaythread( nukeinfo.starttimer, &function_28d6684a96cab3e0, self, streakinfo );
        level thread utility::delaythread( nukeinfo.starttimer, &function_feec581b7f380db9, self, streakinfo );
        level thread utility::delaythread( nukeinfo.starttimer, &function_984972b0639d3d61, self, streakinfo, var_d9ea6da83ae723a1 );
        
        if ( !var_d9ea6da83ae723a1 )
        {
            level waittill( #"hash_1c088db2222668c4" );
            level function_3be1a7d5f41be3f( self );
        }
    }

    // Namespace nuke
    // Params 3, eflags: 0x4
    // Checksum 0xb99f6072, Offset: 0x7d33
    // Size: 0x96, Type: dev
    function private function_b76d744a800db80( var_7c36cb338a197cdf, animshot, clearscene )
    {
        level endon( #"game_ended" );
        var_1ed7d0449a60cfe8 = var_7c36cb338a197cdf scene::function_b3c7b792a7a154fa( animshot );
        
        if ( !var_1ed7d0449a60cfe8 )
        {
            var_1ed7d0449a60cfe8 = 5;
        }
        
        wait var_1ed7d0449a60cfe8;
        self setclientomnvar( "<dev string:xc1>", 0 );
        player_utility::_freezecontrols( 0 );
        function_b99c13d2129b3f37();
        level.nukeinfo.incoming = undefined;
        
        if ( animshot && clearscene )
        {
            var_7c36cb338a197cdf scene::cleanup( 1 );
        }
    }

#/
