// scripts\common\killstreaks\killstreak_shared.gsc  (hash_13647c9b340e9fa6.gscc) (size: 24203 Bytes / 0x5e8b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf61f880 (3747739776)
// size ...... 24203 (0x5e8b)
// includes .. 9   (offset: 0x59e7)
// strings ... 51  (offset: 0x5a2f)
// dev strs .. 28  (offset: 0x5d0f)
// exports ... 69  (offset: 0x3eeb)
// cseg ...... 0x4d1 + 0x3a1a (0x3eeb)
// imports ... 128 (offset: 0x49b3)
// animtree1 . 0   (offset: 0x5e8b)
// animtree2 . 0   (offset: 0x5e8b)
#using script_16ea1b94f0f381b3;
#using scripts\common\damage_tuning;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\math;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace killstreak_shared;

// Namespace killstreak_shared
// Params 0, eflags: 0x4
// Checksum 0x92d8133b, Offset: 0x4ef
// Size: 0x50
function private function_1a13ecbd66532395()
{
    if ( getdvarint( @"t10", 0 ) > 0 )
    {
        /#
            utility::scriptbundlewarning( "<dev string:x24>", "<dev string:x33>" );
        #/
        
        return %"killstreaklist:killstreak_list_t10_mp";
    }
    
    /#
        utility::scriptbundlewarning( "<dev string:x24>", "<dev string:x59>" );
    #/
    
    return %"killstreaklist:killstreak_list_iw9_mp";
}

// Namespace killstreak_shared
// Params 0
// Checksum 0x5a2bf316, Offset: 0x548
// Size: 0x87
function function_7b7d717a49b7ecc7()
{
    bundlename = undefined;
    
    if ( isdefined( level.gametypebundle.killstreak_list ) )
    {
        bundlename = level.gametypebundle.killstreak_list;
    }
    else if ( isdefined( level.gamemodebundle.killstreak_list ) )
    {
        bundlename = level.gamemodebundle.killstreak_list;
    }
    
    if ( !isdefined( bundlename ) )
    {
        bundlename = function_1a13ecbd66532395();
    }
    
    assert( isxhashasset( bundlename ) );
    return bundlename;
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x6eb51ab2, Offset: 0x5d8
// Size: 0x54
function registerkillstreakinitfunction( bundlenamexhash, initfunc )
{
    if ( !isdefined( level.var_1e50876feee745ad ) )
    {
        level.var_1e50876feee745ad = [];
    }
    
    assert( !isdefined( level.var_1e50876feee745ad[ bundlenamexhash ] ), "<dev string:x7f>" );
    level.var_1e50876feee745ad[ bundlenamexhash ] = initfunc;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xf49050d7, Offset: 0x634
// Size: 0x41
function initializekillstreak( streakrefxhash )
{
    if ( !isdefined( level.var_1e50876feee745ad ) )
    {
        return;
    }
    
    initfunc = level.var_1e50876feee745ad[ streakrefxhash ];
    
    if ( !isdefined( initfunc ) )
    {
        return;
    }
    
    level [[ initfunc ]]();
}

// Namespace killstreak_shared
// Params 1, eflags: 0x4
// Checksum 0x63c4d2f6, Offset: 0x67d
// Size: 0x1ac
function private function_1e0d70f6bcabbf4d( bundle )
{
    assert( isstruct( bundle ) );
    
    if ( isarray( bundle.airpatrolvehicleentries ) && bundle.airpatrolvehicleentries.size == 0 )
    {
        bundle.airpatrolvehicleentries = undefined;
    }
    
    if ( isarray( bundle.crateentries ) && bundle.crateentries.size == 0 )
    {
        bundle.crateentries = undefined;
    }
    
    if ( isarray( bundle.vehicleentries ) && bundle.vehicleentries.size == 0 )
    {
        bundle.vehicleentries = undefined;
    }
    
    if ( isarray( bundle.var_8f21800662496353 ) && bundle.var_8f21800662496353.size == 0 )
    {
        bundle.var_8f21800662496353 = undefined;
    }
    
    damage_tuning::function_c851d31a9ad2e67( bundle );
    bundle.unlockableprojects = undefined;
    
    if ( getdvarint( @"scr_killstreak_bundle_purge", 1 ) )
    {
        bundle.availableprojects = undefined;
        bundle.description = undefined;
        bundle.displayname = undefined;
        bundle.unlocktype = undefined;
        bundle.visibilitylevel = undefined;
        bundle.availableoffline = undefined;
        bundle.var_15642e668475ba1a = undefined;
        bundle.availablegamemodes = undefined;
        bundle.var_7352c2073d1e6cec = undefined;
        bundle.var_5cfb1af2fd2e5eac = undefined;
        bundle.var_bcb5afbc3fb1dd39 = undefined;
        bundle.tabletimage = undefined;
        bundle.tutorialvideo = undefined;
        bundle.fullimage = undefined;
        bundle.var_f5afe1a75546822c = undefined;
        bundle.var_6f8870069a3470b8 = undefined;
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x146d115a, Offset: 0x831
// Size: 0x4c2, Type: bool
function parsestreakbundles( killstreaklistname )
{
    if ( !isdefined( killstreaklistname ) )
    {
        return false;
    }
    
    globals = level.streakglobals;
    
    if ( isdefined( globals.streakbundles ) )
    {
        return false;
    }
    
    globals.streakbundles = [];
    globals.var_9e0ca257f60b78aa = [];
    killstreaklistbundle = getscriptbundle( killstreaklistname );
    
    if ( !isdefined( killstreaklistbundle ) )
    {
        return false;
    }
    
    var_8f34e01a145e99e2 = level.sharedfuncs[ #"splash" ][ #"registersplashbundle" ];
    level.var_80c8fcefb5ff5fe7 = killstreaklistbundle.var_80c8fcefb5ff5fe7;
    
    foreach ( index, killstreaklistentry in killstreaklistbundle.killstreak_list )
    {
        if ( !isnumber( index ) )
        {
            continue;
        }
        
        if ( !isdefined( killstreaklistentry ) )
        {
            continue;
        }
        
        killstreakbundlename = killstreaklistentry.bundle;
        
        if ( !isdefined( killstreakbundlename ) )
        {
            continue;
        }
        
        assert( isxhashasset( killstreakbundlename ) );
        
        if ( killstreakbundlename == %"killstreak:killstreak_none" )
        {
            continue;
        }
        
        if ( killstreakbundlename == %"killstreak:replace_me" )
        {
            continue;
        }
        
        bundle = getscriptbundle( killstreakbundlename );
        
        if ( !isdefined( bundle ) )
        {
            continue;
        }
        
        streakref = bundle.killstreakref;
        
        if ( !isdefined( streakref ) || streakref == "none" )
        {
            assert( isdefined( streakref ) );
            continue;
        }
        
        bundle.var_d80db24c90d421fb = killstreakbundlename;
        function_716a814f97ead08e( killstreaklistentry, streakref );
        function_1e0d70f6bcabbf4d( bundle );
        globals.streakbundles[ streakref ] = bundle;
        globals.var_9e0ca257f60b78aa[ streakref ] = index;
        assert( isstring( streakref ) );
        streakrefxhash = getxhash( streakref );
        
        if ( bundle.lootid )
        {
            level.var_efc6cfed3c343e5b[ streakrefxhash ] = bundle.lootid;
        }
        
        game[ "dialog" ][ streakrefxhash ] = "killstreak_team_leader" + "_earned";
        game[ "dialog" ][ streakref + "_teamleader_friendly_inbound" ] = "killstreak_team_leader" + "_ally_callout";
        game[ "dialog" ][ streakref + "_teamleader_enemy_inbound" ] = "killstreak_team_leader" + "_enemy_callout";
        game[ "dialog" ][ streakref + "_teamleader_destroyed" ] = "killstreak_team_leader" + "_crash";
        game[ "dialog" ][ streakref + "_teamleader_timeout" ] = "killstreak_team_leader" + "_timeout";
        streakpoints = bundle.score;
        
        if ( streakpoints > 0 )
        {
            namespace_9d8e359c3b1041e5::registerscoreinfosharedfunc( hashcat( #"killstreak_", streakref ), #"value", streakpoints );
        }
        
        weaponentries = namespace_9d8e359c3b1041e5::function_19145ff013934a47( streakref );
        
        if ( isdefined( weaponentries ) )
        {
            foreach ( entry in weaponentries )
            {
                if ( isdefined( entry.weaponname ) )
                {
                    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( streakref, entry.weaponname, entry.var_e2bc8b2314f1db1a, entry.var_c58f9c252482645d );
                }
            }
        }
        
        thread initializekillstreak( getxhash( streakref ) );
        
        if ( level.in_play_limits_in_use )
        {
            [[ level.in_play_limits.var_e46d8978833c534c ]]( bundle );
        }
        
        if ( isdefined( var_8f34e01a145e99e2 ) )
        {
            [[ var_8f34e01a145e99e2 ]]( streakrefxhash, bundle.earnedsplash );
            [[ var_8f34e01a145e99e2 ]]( bundle.usedsplashref, bundle.usedsplash );
        }
        
        /#
            name = isdefined( bundle.name ) ? debugtranslatestring( bundle.name ) : streakref;
            devgui::add_devgui_command( "<dev string:xa6>" + name + "<dev string:xc5>" + streakref + "<dev string:xc8>", "<dev string:xca>" + streakref + "<dev string:xe4>", index );
            devgui::add_devgui_command( "<dev string:x10a>" + name + "<dev string:xc5>" + streakref + "<dev string:xc8>", "<dev string:x126>" + streakref + "<dev string:x148>", index );
        #/
    }
    
    return true;
}

// Namespace killstreak_shared
// Params 0
// Checksum 0x33e2efba, Offset: 0xcfc
// Size: 0x315
function function_71ff9c4f9fbef98f()
{
    if ( !level.var_ac98e7cc4b10cb11 )
    {
        return;
    }
    
    globals = level.streakglobals;
    
    if ( !isarray( globals.streakbundles ) || globals.var_91bdb7de5b47da10 )
    {
        return;
    }
    
    globals.var_91bdb7de5b47da10 = [];
    globals.var_c42c4e57b5d38c79 = [];
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x14a>" );
    #/
    
    foreach ( var_7ce08877f8d926d9 in globals.streakbundles )
    {
        if ( !isarray( var_7ce08877f8d926d9.var_8f21800662496353 ) )
        {
            continue;
        }
        
        var_501d323a381fb0a6 = var_7ce08877f8d926d9.killstreakref;
        
        /#
            modindex = 0;
        #/
        
        foreach ( entry in var_7ce08877f8d926d9.var_8f21800662496353 )
        {
            if ( entry.proasset )
            {
                var_87ca8b277fef4dc3 = getscriptbundle( entry.proasset );
                
                if ( !var_87ca8b277fef4dc3 )
                {
                    continue;
                }
            }
            
            if ( var_87ca8b277fef4dc3.var_f088013d20169bf3 == #"none" )
            {
                assertmsg( "<dev string:x173>" );
                continue;
            }
            
            var_87ca8b277fef4dc3.var_d80db24c90d421fb = entry.proasset;
            function_1e0d70f6bcabbf4d( var_87ca8b277fef4dc3 );
            globals.var_91bdb7de5b47da10[ entry.proasset ] = var_87ca8b277fef4dc3;
            globals.var_99bf84bbdcdf0052[ var_87ca8b277fef4dc3.lootid ] = entry.proasset;
            globals.var_4384a813e6a0950[ var_87ca8b277fef4dc3.lootid ] = var_501d323a381fb0a6;
            globals.var_32104ba222114444[ var_87ca8b277fef4dc3.lootid ] = var_7ce08877f8d926d9.lootid;
            
            /#
                var_4358efe67733cf48 = getxhashsourcename( entry.proasset );
                prostreaktype = getxhashsourcename( var_87ca8b277fef4dc3.var_f088013d20169bf3 );
                devgui::add_devgui_command( "<dev string:x1b0>" + var_501d323a381fb0a6 + "<dev string:xc5>" + prostreaktype + "<dev string:x1b2>" + modindex + "<dev string:x1b4>" + var_87ca8b277fef4dc3.var_f306b2ded8a0a34c + "<dev string:xc8>", "<dev string:x1b6>" + var_4358efe67733cf48 + "<dev string:x1d4>" + var_501d323a381fb0a6 );
                modindex++;
            #/
        }
    }
    
    level utility::flag_set( "ProContentStreakBundlesParsed" );
    
    /#
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x97671c89, Offset: 0x1019
// Size: 0x5c
function function_716a814f97ead08e( killstreaklistentry, bundledref )
{
    if ( !isdefined( killstreaklistentry.ref ) )
    {
        assert( isdefined( killstreaklistentry.ref ) );
        return;
    }
    
    if ( bundledref == "replace_me" )
    {
        return;
    }
    
    assert( bundledref == killstreaklistentry.ref );
}

// Namespace killstreak_shared
// Params 0
// Checksum 0xb5009fb9, Offset: 0x107d
// Size: 0x70
function killstreak_savenvgstate()
{
    if ( !isdefined( self.pers[ "useNVG" ] ) )
    {
        return;
    }
    
    if ( self isnightvisionon() )
    {
        self.pers[ "useNVG" ] = 1;
        self.pers[ "killstreak_forcedNVGOff" ] = 1;
        self nightvisionviewoff( 1 );
        return;
    }
    
    self.pers[ "useNVG" ] = 0;
    self.pers[ "killstreak_forcedNVGOff" ] = 0;
}

// Namespace killstreak_shared
// Params 0
// Checksum 0x39e90816, Offset: 0x10f5
// Size: 0x42
function killstreak_restorenvgstate()
{
    if ( !isdefined( self.pers[ "useNVG" ] ) )
    {
        return;
    }
    
    if ( self.pers[ "useNVG" ] )
    {
        self nightvisionviewon( 1 );
        self.pers[ "killstreak_forcedNVGOff" ] = 0;
    }
}

// Namespace killstreak_shared
// Params 0
// Checksum 0x178ce9f, Offset: 0x113f
// Size: 0x10c
function function_38dc8b5c461532cb()
{
    if ( isdefined( level.killstreakthermalvisionset ) )
    {
        function_28d986de72ce85f8( level.killstreakthermalvisionset );
    }
    
    function_28d986de72ce85f8( "killstreak_thermal" );
    function_28d986de72ce85f8( "killstreak_thermal_fog" );
    function_28d986de72ce85f8( "killstreak_flash", 0.1 );
    function_28d986de72ce85f8( "killstreak_static", 0.1 );
    function_28d986de72ce85f8( "killstreak_slamzoom", 0.1 );
    function_28d986de72ce85f8( "killstreak_color_light_damage", 0.1, 0.1, 0.3 );
    function_28d986de72ce85f8( "killstreak_color_heavy_damage", 0.1, 0.2, 0.5 );
    function_28d986de72ce85f8( "killstreak_thermal_light_damage", 0.1, 0.1, 0.3 );
    function_28d986de72ce85f8( "killstreak_thermal_heavy_damage", 0.1, 0.2, 0.5 );
    function_28d986de72ce85f8( "killstreak_ads_shutter", 0.25, 0.1, 0.25 );
    function_28d986de72ce85f8( "killstreak_weapon_change_shutter", 0.025, 0.08, 0.15 );
}

// Namespace killstreak_shared
// Params 4
// Checksum 0xd6d17833, Offset: 0x1253
// Size: 0xd5
function function_28d986de72ce85f8( visionsetname, fadeintime, fadewait, fadeouttime )
{
    if ( !isdefined( level.killstreakvisionsets ) )
    {
        level.killstreakvisionsets = [];
    }
    else if ( isdefined( level.killstreakvisionsets[ visionsetname ] ) )
    {
        return;
    }
    
    visionsetinfo = spawnstruct();
    visionsetinfo.name = visionsetname;
    visionsetinfo.type = function_8d4076adc7c5f2d9( visionsetname );
    
    if ( !isdefined( fadeintime ) )
    {
        fadeintime = 0;
    }
    
    visionsetinfo.fadeintime = fadeintime;
    
    if ( !isdefined( fadewait ) )
    {
        fadewait = 0;
    }
    
    visionsetinfo.fadewait = fadewait;
    
    if ( !isdefined( fadeouttime ) )
    {
        fadeouttime = 0;
    }
    
    visionsetinfo.fadeouttime = fadeouttime;
    level.killstreakvisionsets[ visionsetname ] = visionsetinfo;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x717bd355, Offset: 0x1330
// Size: 0x52
function function_8d4076adc7c5f2d9( visionsetname )
{
    if ( isxhashasset( visionsetname ) )
    {
        return;
    }
    
    visionsetformat = undefined;
    
    if ( issubstr( visionsetname, "thermal" ) )
    {
        visionsetformat = "thermal";
    }
    else if ( issubstr( visionsetname, "color" ) )
    {
        visionsetformat = "color";
    }
    
    return visionsetformat;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x57dc0f9c, Offset: 0x138b
// Size: 0x31
function function_8bd91ec764c0390b( visionsetname )
{
    visionsetinfo = function_dfddef6ddb119ee9( visionsetname );
    
    if ( !isdefined( visionsetinfo ) )
    {
        return;
    }
    
    thread namespace_9d8e359c3b1041e5::killstreak_setsubvisionsharedfunc( visionsetinfo );
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x9fddd479, Offset: 0x13c4
// Size: 0x5f
function function_9fd22f7d1a941d8a( visionsetname, visionsetstrength )
{
    visionsettype = function_8d4076adc7c5f2d9( visionsetname );
    
    if ( !isdefined( visionsetstrength ) )
    {
        visionsetstrength = "light";
    }
    
    damagevisionset = "killstreak_" + visionsettype + "_" + visionsetstrength + "_damage";
    function_8bd91ec764c0390b( damagevisionset );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x86fffcef, Offset: 0x142b
// Size: 0x40
function function_dfddef6ddb119ee9( visionsetname )
{
    if ( !( isdefined( visionsetname ) && isdefined( level.killstreakvisionsets[ visionsetname ] ) ) )
    {
        assertmsg( "<dev string:x1f0>" );
        return;
    }
    
    return level.killstreakvisionsets[ visionsetname ];
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x6eafe990, Offset: 0x1474
// Size: 0x1ad
function function_1a327e2380d538a0( killstreakname, bundle = killstreak::function_85b2d8e857ab4898( killstreakname ) )
{
    assert( isdefined( bundle.var_d873bcb05e77fbdc ), "<dev string:x27b>" );
    
    if ( !isdefined( level.var_b0c513b2a2a0cc2d ) )
    {
        level.var_b0c513b2a2a0cc2d = [];
    }
    else if ( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ) )
    {
        return;
    }
    
    var_b5a8cace8cecc00b = spawnstruct();
    var_b5a8cace8cecc00b.var_b0bede2bb644da11 = "NONE";
    var_b5a8cace8cecc00b.container_bundle = undefined;
    var_b5a8cace8cecc00b.ref_name = killstreakname;
    var_b5a8cace8cecc00b.killstreak = bundle;
    var_b5a8cace8cecc00b.var_5316e5adb9da5416 = [];
    container_bundle = getscriptbundle( bundle.var_d873bcb05e77fbdc );
    
    if ( bundle.var_f45963b9b9b16d30 )
    {
        foreach ( entry in bundle.var_e99c26c95799bb96 )
        {
            if ( level.mapname == entry.level_name )
            {
                container_bundle = getscriptbundle( entry.var_de6402f0cd2f5671 );
                break;
            }
        }
    }
    
    assert( isdefined( container_bundle ), "<dev string:x2b5>" );
    var_b5a8cace8cecc00b.container_bundle = container_bundle;
    level.var_b0c513b2a2a0cc2d[ killstreakname ] = var_b5a8cace8cecc00b;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xe0c111e, Offset: 0x1629
// Size: 0x6f
function function_5dc3335c1b599ca2( killstreakname )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    pbgpostfxbundlestart( self, level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_638b38ab1efd6bc1 );
    level.var_b0c513b2a2a0cc2d[ killstreakname ].var_b0bede2bb644da11 = "COLOR";
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xebf3aef4, Offset: 0x16a0
// Size: 0x6f
function function_bea0fa24fb02d1f9( killstreakname )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    pbgpostfxbundleend( self, level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_638b38ab1efd6bc1 );
    level.var_b0c513b2a2a0cc2d[ killstreakname ].var_b0bede2bb644da11 = "NONE";
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x62ab169b, Offset: 0x1717
// Size: 0x95
function function_818b852f9e5b9( killstreakname )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    function_55af6d015c4cb895( self, level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_d9fdbe549693a0b2 );
    pbgpostfxbundlestart( self, level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_fa6e3bae2440607d );
    level.var_b0c513b2a2a0cc2d[ killstreakname ].var_b0bede2bb644da11 = "NVT";
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xe6e3f317, Offset: 0x17b4
// Size: 0x75
function function_ce6ab05f481f1d2e( killstreakname )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    function_fe2123dba85371ec( self );
    pbgpostfxbundleend( self, level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_fa6e3bae2440607d );
    level.var_b0c513b2a2a0cc2d[ killstreakname ].var_b0bede2bb644da11 = "NONE";
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x9910206, Offset: 0x1831
// Size: 0x12e
function function_84c9ccafa62f748f( killstreakname, var_45e2f2c9fe0120e6 )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    postfx = undefined;
    
    switch ( var_45e2f2c9fe0120e6 )
    {
        case #"hash_aeb945e26332684b":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_11005c05e92a4e9a;
            break;
        case #"hash_53ac04d47fad647c":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_754beb4adc37c52d;
            break;
        case #"hash_49c8711fceccda37":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_b9c1638795e2b499;
            break;
        case #"hash_8cf3416df26a7b58":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_a64520ff92b6d2e4;
            break;
        default:
            break;
    }
    
    if ( isdefined( postfx ) )
    {
        pbgpostfxbundlestart( self, postfx );
    }
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x8bccb181, Offset: 0x1967
// Size: 0xf7
function function_e00269fccf073417( killstreakname, var_ffef04fa6bbf9292 )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    postfx = undefined;
    
    switch ( var_ffef04fa6bbf9292 )
    {
        case #"hash_b8875768bff1e8e9":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_343e43023ea1690c;
            break;
        case #"hash_18acfaee950aed1b":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_67d317792dcc016c;
            break;
        case #"hash_e17687d1aa4fa707":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_820dd3d670f2ae78;
            break;
        default:
            break;
    }
    
    pbgpostfxbundlestart( self, postfx );
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x2f8778c0, Offset: 0x1a66
// Size: 0xf7
function function_b9ce99a83ff28b5c( killstreakname, var_ffef04fa6bbf9292 )
{
    assert( isdefined( level.var_b0c513b2a2a0cc2d[ killstreakname ] ), "<dev string:x2e0>" + string( killstreakname ) );
    postfx = undefined;
    
    switch ( var_ffef04fa6bbf9292 )
    {
        case #"hash_b8875768bff1e8e9":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_343e43023ea1690c;
            break;
        case #"hash_18acfaee950aed1b":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_67d317792dcc016c;
            break;
        case #"hash_e17687d1aa4fa707":
            postfx = level.var_b0c513b2a2a0cc2d[ killstreakname ].container_bundle.var_820dd3d670f2ae78;
            break;
        default:
            break;
    }
    
    pbgpostfxbundleend( self, postfx );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xa324ad53, Offset: 0x1b65
// Size: 0x18
function function_c428d29a2932ffb2( killstreakname )
{
    return level.var_b0c513b2a2a0cc2d[ killstreakname ];
}

// Namespace killstreak_shared
// Params 6
// Checksum 0x625da625, Offset: 0x1b86
// Size: 0x1ac
function killstreak_waittillexplode( var_19eee95063be9ec9, var_19eee65063be9830, var_19eee75063be9a63, var_19eeec5063bea562, var_19eeed5063bea795, var_19eeea5063bea0fc )
{
    ent = spawnstruct();
    
    if ( isdefined( var_19eee95063be9ec9 ) )
    {
        thread killstreak_waittill_explodestring( var_19eee95063be9ec9, ent );
    }
    
    if ( isdefined( var_19eee65063be9830 ) )
    {
        thread killstreak_waittill_explodestring( var_19eee65063be9830, ent );
    }
    
    if ( isdefined( var_19eee75063be9a63 ) )
    {
        thread killstreak_waittill_explodestring( var_19eee75063be9a63, ent );
    }
    
    if ( isdefined( var_19eeec5063bea562 ) )
    {
        thread killstreak_waittill_explodestring( var_19eeec5063bea562, ent );
    }
    
    if ( isdefined( var_19eeed5063bea795 ) )
    {
        thread killstreak_waittill_explodestring( var_19eeed5063bea795, ent );
    }
    
    if ( isdefined( var_19eeea5063bea0fc ) )
    {
        thread killstreak_waittill_explodestring( var_19eeea5063bea0fc, ent );
    }
    
    ent waittill( #"returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( #"die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace killstreak_shared
// Params 2
// Checksum 0xabfe0492, Offset: 0x1d3b
// Size: 0x94
function killstreak_waittill_explodestring( msg, ent )
{
    if ( msg != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6 );
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x1c127e23, Offset: 0x1dd7
// Size: 0x47, Type: bool
function is_indoors( ent, contents )
{
    targetpos = ent.origin;
    return !trace::ray_trace_passed( targetpos, targetpos + ( 0, 0, 10000 ), ent, contents );
}

// Namespace killstreak_shared
// Params 3
// Checksum 0xc8f65f01, Offset: 0x1e27
// Size: 0x73
function function_6296243da142211b( ent, contents, killstreakowner )
{
    ignoreents = [ self, ent ];
    
    if ( isarray( killstreakowner.var_7c32ee3e9ab8715e ) )
    {
        ignoreents = arraycombine( ignoreents, killstreakowner.var_7c32ee3e9ab8715e );
    }
    
    return trace::ray_trace_passed( ent getcentroid(), self.origin, ignoreents, contents );
}

// Namespace killstreak_shared
// Params 1, eflags: 0x4
// Checksum 0xe927947f, Offset: 0x1ea3
// Size: 0xd1
function private function_e3a8672cd7c37a64( killstreakowner )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    suffix = killstreakowner.name;
    
    if ( !isdefined( suffix ) )
    {
        suffix = "";
    }
    
    self endon( "kill_streak_target_marker_end_" + suffix );
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    while ( isdefined( self ) && isdefined( killstreakowner.enemytargetmarkergroup ) && targetmarkergroups::targetmarkergroupexists( killstreakowner.enemytargetmarkergroup ) )
    {
        if ( is_indoors( self, contents ) )
        {
            targetmarkergroupsetentitystate( killstreakowner.enemytargetmarkergroup, self, 1 );
        }
        else
        {
            targetmarkergroupsetentitystate( killstreakowner.enemytargetmarkergroup, self, 0 );
        }
        
        wait 0.5;
    }
}

// Namespace killstreak_shared
// Params 2, eflags: 0x4
// Checksum 0x3cf006c5, Offset: 0x1f7c
// Size: 0x104
function private function_e2d919a48c6ec5b6( killstreakowner, entitylos )
{
    enemyplayer = self;
    enemyplayer endon( #"death", #"disconnect", "kill_streak_target_marker_end_" + ( killstreakowner.name ?? "" ) );
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    while ( isdefined( entitylos ) && isdefined( enemyplayer ) && isdefined( killstreakowner.enemytargetmarkergroup ) && targetmarkergroups::targetmarkergroupexists( killstreakowner.enemytargetmarkergroup ) )
    {
        if ( entitylos function_6296243da142211b( enemyplayer, contents, killstreakowner ) )
        {
            function_38187ef7c844fb3a( killstreakowner.enemytargetmarkergroup, enemyplayer, 1 );
            targetmarkergroupsetentitystate( killstreakowner.enemytargetmarkergroup, enemyplayer, 0 );
        }
        else
        {
            function_3fc498b880daf5fd( killstreakowner.enemytargetmarkergroup, enemyplayer, 1 );
            targetmarkergroupsetentitystate( killstreakowner.enemytargetmarkergroup, enemyplayer, 1 );
        }
        
        wait 0.5;
    }
}

// Namespace killstreak_shared
// Params 2
// Checksum 0xaa750fdd, Offset: 0x2088
// Size: 0x59
function function_dab42d4ffc561af3( ent, removenotifies )
{
    if ( !self || !ent )
    {
        return;
    }
    
    if ( !isdefined( self.var_7c32ee3e9ab8715e ) )
    {
        self.var_7c32ee3e9ab8715e = [];
    }
    
    self.var_7c32ee3e9ab8715e[ self.var_7c32ee3e9ab8715e.size ] = ent;
    thread function_733139edf4e697d5( ent, removenotifies );
}

// Namespace killstreak_shared
// Params 2, eflags: 0x4
// Checksum 0x5be47a15, Offset: 0x20e9
// Size: 0x97
function private function_733139edf4e697d5( ent, removenotifies )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( removenotifies ) )
    {
        removenotifies = [];
    }
    
    removenotifies[ removenotifies.size ] = "death";
    ent utility::waittill_any_in_array( removenotifies );
    
    if ( isarray( self.var_7c32ee3e9ab8715e ) )
    {
        if ( ent && arraycontains( self.var_7c32ee3e9ab8715e, ent ) )
        {
            self.var_7c32ee3e9ab8715e = arrayremove( self.var_7c32ee3e9ab8715e, ent );
            return;
        }
        
        self.var_7c32ee3e9ab8715e = function_5713d46873b29625( self.var_7c32ee3e9ab8715e );
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xb662d200, Offset: 0x2188
// Size: 0x44
function function_5a4e3aca08ef7a29( killstreakowner )
{
    if ( !isdefined( killstreakowner.enemytargetmarkergroup ) || !targetmarkergroups::targetmarkergroupexists( killstreakowner.enemytargetmarkergroup ) )
    {
        return 0;
    }
    
    return targetmarkergroupgetentitystate( killstreakowner.enemytargetmarkergroup, self );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x8bd89a6d, Offset: 0x21d5
// Size: 0x46
function function_f87d3123e9b737d6( killstreakowner )
{
    if ( !isdefined( killstreakowner.enemytargetmarkergroup ) || !targetmarkergroups::targetmarkergroupexists( killstreakowner.enemytargetmarkergroup ) )
    {
        return 0;
    }
    
    return function_57f8e816e780d266( killstreakowner.enemytargetmarkergroup, self, 1 );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x675ceeec, Offset: 0x2224
// Size: 0x55
function function_4b478d49af66b9e5( var_1112474ebb264f99 )
{
    players = level.players;
    ais = getaiarray();
    vehicles = vehicle_getarray();
    assignments = function_c1ca7e2880e58443( var_1112474ebb264f99, players, ais, vehicles );
    return assignments;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x9abf281d, Offset: 0x2282
// Size: 0x8b
function function_cd44f136c8bbe504( var_1112474ebb264f99 )
{
    var_e6d74ef8b978a0b0 = getdvarint( @"hash_dd84f6cd69e771b8", 7800 );
    nearbyais = getaiarrayinradius( self.origin, var_e6d74ef8b978a0b0 );
    nearbyplayers = getplayersinradius( self.origin, var_e6d74ef8b978a0b0 );
    nearbyvehicles = vehicle_getarrayinradius( self.origin, var_e6d74ef8b978a0b0 );
    assignments = function_c1ca7e2880e58443( var_1112474ebb264f99, nearbyplayers, nearbyais, nearbyvehicles );
    return assignments;
}

// Namespace killstreak_shared
// Params 4, eflags: 0x4
// Checksum 0x4c4af804, Offset: 0x2316
// Size: 0x361
function private function_c1ca7e2880e58443( var_1112474ebb264f99, playerarray, aiarray, var_3bb7799023459887 )
{
    var_d164bd71a2690aba = [];
    var_361a7ab2055af3a = [];
    var_d79ad8c4fb866425 = [];
    
    if ( isdefined( playerarray ) )
    {
        foreach ( player in playerarray )
        {
            if ( self == player || !isenemyteam( self.team, player.team ) )
            {
                var_d79ad8c4fb866425[ var_d79ad8c4fb866425.size ] = player;
                continue;
            }
            
            if ( isdefined( player.perks[ "specialty_covert_ops" ] ) || isdefined( player.perks[ "specialty_blindeye" ] ) )
            {
                continue;
            }
            
            var_361a7ab2055af3a[ var_361a7ab2055af3a.size ] = player;
            var_d164bd71a2690aba[ var_d164bd71a2690aba.size ] = player;
        }
    }
    
    if ( isdefined( aiarray ) )
    {
        foreach ( ai in aiarray )
        {
            if ( ai.var_5b2c75a18725dcd9 )
            {
                continue;
            }
            
            if ( !isenemyteam( self.team, ai.team ) )
            {
                var_d79ad8c4fb866425[ var_d79ad8c4fb866425.size ] = ai;
                continue;
            }
            
            var_361a7ab2055af3a[ var_361a7ab2055af3a.size ] = ai;
            var_d164bd71a2690aba[ var_d164bd71a2690aba.size ] = ai;
        }
    }
    
    if ( !var_1112474ebb264f99 && !level.var_5d54f1947348e054 && isdefined( var_3bb7799023459887 ) )
    {
        foreach ( vehicle in var_3bb7799023459887 )
        {
            if ( vehicle.var_5b2c75a18725dcd9 )
            {
                continue;
            }
            
            isenemy = 0;
            
            if ( level.teambased )
            {
                team = vehicle.team;
                
                if ( !isdefined( team ) || team == "neutral" )
                {
                    if ( isdefined( vehicle.owner ) )
                    {
                        vehicle.team = vehicle.owner.team;
                    }
                }
                
                if ( !isdefined( team ) )
                {
                    isenemy = 0;
                }
                else
                {
                    isenemy = vehicle.team != self.team;
                }
            }
            else
            {
                isenemy = isdefined( vehicle.owner ) && vehicle.owner != self;
            }
            
            if ( isenemy )
            {
                var_361a7ab2055af3a[ var_361a7ab2055af3a.size ] = vehicle;
            }
        }
    }
    
    assignments = spawnstruct();
    assignments.var_d164bd71a2690aba = var_d164bd71a2690aba;
    assignments.enemytargetmarkergroup = var_361a7ab2055af3a;
    assignments.friendlytargetmarkergroup = var_d79ad8c4fb866425;
    return assignments;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xd8a4663f, Offset: 0x2680
// Size: 0x663
function function_2f6864f010a9890d( params )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    if ( isdefined( params.bundle ) && params.bundle.targetmarkersettings )
    {
        var_7b36cc26fecf0947 = getscriptbundle( params.bundle.targetmarkersettings );
        
        if ( !isdefined( params.enemymarkerwidget ) )
        {
            params.enemymarkerwidget = var_7b36cc26fecf0947.var_598d79add3230927;
        }
        
        if ( !isdefined( params.friendlymarkerwidget ) )
        {
            params.friendlymarkerwidget = var_7b36cc26fecf0947.var_f057b69340b14a5c;
        }
        
        if ( !isdefined( params.var_4ab3b60142bb6ee ) )
        {
            params.var_4ab3b60142bb6ee = !var_7b36cc26fecf0947.var_225c495bde49787b;
        }
        
        if ( !isdefined( params.hideoverlaytargetmarkerfriendly ) )
        {
            params.hideoverlaytargetmarkerfriendly = var_7b36cc26fecf0947.hideoverlaytargetmarkerfriendly ?? var_7b36cc26fecf0947.var_3f3a323868e1d507;
        }
        
        if ( !isdefined( params.var_1e1ecace3b3c2a63 ) )
        {
            params.var_1e1ecace3b3c2a63 = var_7b36cc26fecf0947.var_1e1ecace3b3c2a63;
        }
        
        if ( !isdefined( params.var_ee7bc8b53cebd37e ) )
        {
            params.var_ee7bc8b53cebd37e = var_7b36cc26fecf0947.var_ee7bc8b53cebd37e;
        }
        
        if ( !isdefined( params.var_20fb10612153223 ) )
        {
            params.var_20fb10612153223 = var_7b36cc26fecf0947.var_20fb10612153223;
        }
        
        if ( !isdefined( params.var_4c96a742e6e746c9 ) )
        {
            params.var_4c96a742e6e746c9 = var_7b36cc26fecf0947.var_4c96a742e6e746c9;
        }
    }
    
    var_c7b32611b1635bc4 = utility::issharedfuncdefined( #"game", #"targetmarkergroup_on" );
    var_b68899ade11685af = utility::issp() || utility::iszm() || isdefined( params.var_c8595a1483701acb );
    
    if ( !var_b68899ade11685af )
    {
        var_d4e1dc0ed539a8da = [];
        var_63106d9fec5f8a63 = [];
        
        foreach ( player in level.players )
        {
            if ( level.teambased && player.team == self.team || player == self )
            {
                var_63106d9fec5f8a63[ var_63106d9fec5f8a63.size ] = player;
                continue;
            }
            
            if ( isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
            {
                continue;
            }
            
            var_d4e1dc0ed539a8da[ var_d4e1dc0ed539a8da.size ] = player;
        }
        
        var_d164bd71a2690aba = var_d4e1dc0ed539a8da;
    }
    else
    {
        assignmentfunction = &function_4b478d49af66b9e5;
        
        if ( isbrgamemode() && getdvarint( @"hash_dd84f6cd69e771b8", 7800 ) > 0 )
        {
            assignmentfunction = &function_cd44f136c8bbe504;
        }
        
        if ( utility::issharedfuncdefined( params.var_c8595a1483701acb, #"assigntargetmarkers" ) )
        {
            assignmentfunction = utility::getsharedfunc( params.var_c8595a1483701acb, #"assigntargetmarkers" );
        }
        
        profilestart();
        assignments = self [[ assignmentfunction ]]();
        profilestop();
        var_d4e1dc0ed539a8da = assignments.enemytargetmarkergroup ?? [];
        var_63106d9fec5f8a63 = assignments.friendlytargetmarkergroup ?? [];
        var_d164bd71a2690aba = assignments.var_d164bd71a2690aba ?? [];
    }
    
    enemymarkerwidget = params.enemymarkerwidget ?? %"overlaytargetmarkerenemy";
    friendlymarkerwidget = params.friendlymarkerwidget ?? %"overlaytargetmarkerfriendly";
    
    if ( !var_c7b32611b1635bc4 )
    {
        self.enemytargetmarkergroup = targetmarkergroups::targetmarkergroup_on( enemymarkerwidget, self, var_d4e1dc0ed539a8da, self, 0, 1, 1, params.var_1e1ecace3b3c2a63, params.var_ee7bc8b53cebd37e );
    }
    else
    {
        self.enemytargetmarkergroup = namespace_9d8e359c3b1041e5::targetmarkergroup_onsharedfunc( enemymarkerwidget, self, var_d4e1dc0ed539a8da, self, 0, 1, 1, params.var_1e1ecace3b3c2a63, params.var_ee7bc8b53cebd37e );
    }
    
    friendlytargets = var_63106d9fec5f8a63;
    var_cf5cdab1be14467c = !params.hideoverlaytargetmarkerfriendly;
    var_def1ff63d8a13201 = 0;
    
    if ( params.hideoverlaytargetmarkerfriendly && params.var_4c96a742e6e746c9 )
    {
        friendlytargets = [ self ];
        var_cf5cdab1be14467c = 1;
        var_def1ff63d8a13201 = 1;
    }
    
    if ( var_cf5cdab1be14467c )
    {
        if ( !var_c7b32611b1635bc4 )
        {
            self.friendlytargetmarkergroup = targetmarkergroups::targetmarkergroup_on( friendlymarkerwidget, self, friendlytargets, self, 1, 1, 1, params.var_1e1ecace3b3c2a63, params.var_ee7bc8b53cebd37e, var_def1ff63d8a13201 );
        }
        else
        {
            self.friendlytargetmarkergroup = namespace_9d8e359c3b1041e5::targetmarkergroup_onsharedfunc( friendlymarkerwidget, self, friendlytargets, self, 1, 1, 1, params.var_1e1ecace3b3c2a63, params.var_ee7bc8b53cebd37e, var_def1ff63d8a13201 );
        }
    }
    
    if ( params.var_4ab3b60142bb6ee )
    {
        foreach ( enemy in var_d164bd71a2690aba )
        {
            enemy thread function_e3a8672cd7c37a64( self );
        }
        
        thread function_a1aacce800541871();
    }
    
    if ( params.var_20fb10612153223 )
    {
        entitylos = params.var_b7a68f2e2c6a8ba1 ?? self;
        
        foreach ( enemy in var_d164bd71a2690aba )
        {
            enemy thread function_e2d919a48c6ec5b6( self, entitylos );
        }
        
        thread function_a3593a3e56607ba2( entitylos );
    }
    
    self.var_875dab35c0a0a5b = var_d164bd71a2690aba;
    markedgroups = spawnstruct();
    markedgroups.enemies = var_d4e1dc0ed539a8da;
    markedgroups.friendlies = var_63106d9fec5f8a63;
    markedgroups.var_d164bd71a2690aba = var_d164bd71a2690aba;
    return markedgroups;
}

// Namespace killstreak_shared
// Params 6
// Checksum 0x8c50d75a, Offset: 0x2cec
// Size: 0xb1
function function_a402a9f43d6f7512( var_9b094ae36f612d1c, enemymarkerwidget, friendlymarkerwidget, var_feaf3a15592bdcb2, var_20fb10612153223, var_b7a68f2e2c6a8ba1 )
{
    params = { #var_b7a68f2e2c6a8ba1:var_b7a68f2e2c6a8ba1, #var_20fb10612153223:var_20fb10612153223, #var_4ab3b60142bb6ee:!var_feaf3a15592bdcb2, #friendlymarkerwidget:friendlymarkerwidget ?? %"killstreakfriendlytarget", #enemymarkerwidget:enemymarkerwidget ?? %"killstreakenemytarget", #var_c8595a1483701acb:var_9b094ae36f612d1c ?? "" };
    return function_2f6864f010a9890d( params );
}

// Namespace killstreak_shared
// Params 0
// Checksum 0xf0386979, Offset: 0x2da6
// Size: 0xb8
function function_a1aacce800541871()
{
    level endon( #"hash_7ab028711a912edc" );
    level endon( "removed_targetMarkerGroup_" + self.targetmarkergroupid );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        
        if ( !self.team )
        {
            return;
        }
        
        if ( !player.team )
        {
            continue;
        }
        
        if ( !isenemyteam( self.team, player.team ) )
        {
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_covert_ops" ] ) || isdefined( player.perks[ "specialty_coldblooded_and_hidden" ] ) )
        {
            continue;
        }
        
        player thread function_e3a8672cd7c37a64( self );
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xa993944f, Offset: 0x2e66
// Size: 0xc4
function function_a3593a3e56607ba2( entitylos )
{
    level endon( #"hash_7ab028711a912edc" );
    level endon( "removed_targetMarkerGroup_" + self.targetmarkergroupid );
    
    while ( true )
    {
        level waittill( #"player_spawned", enemyplayer );
        
        if ( !self.team )
        {
            return;
        }
        
        if ( !enemyplayer.team )
        {
            continue;
        }
        
        if ( !isenemyteam( self.team, enemyplayer.team ) )
        {
            continue;
        }
        
        if ( isdefined( enemyplayer.perks[ "specialty_covert_ops" ] ) || isdefined( enemyplayer.perks[ "specialty_coldblooded_and_hidden" ] ) )
        {
            continue;
        }
        
        enemyplayer thread function_e2d919a48c6ec5b6( self, entitylos );
    }
}

// Namespace killstreak_shared
// Params 3
// Checksum 0x821cf02, Offset: 0x2f32
// Size: 0x66
function function_21284b2e0a08d8df( target, player, var_feaf3a15592bdcb2 )
{
    if ( isdefined( player.enemytargetmarkergroup ) && targetmarkergroups::targetmarkergroupexists( player.enemytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_markentity( target, player.enemytargetmarkergroup );
        
        if ( !var_feaf3a15592bdcb2 )
        {
            target thread function_e3a8672cd7c37a64( player );
        }
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x8fb02fe9, Offset: 0x2fa0
// Size: 0x43
function function_70e34750441c92eb( killstreakowner )
{
    if ( isdefined( killstreakowner.enemytargetmarkergroup ) && targetmarkergroups::targetmarkergroupexists( killstreakowner.enemytargetmarkergroup ) )
    {
        targetmarkergroupsetextrastate( killstreakowner.enemytargetmarkergroup, self, 1 );
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x1ee8c114, Offset: 0x2feb
// Size: 0x42
function function_2b135a54666d89ce( killstreakowner )
{
    if ( isdefined( killstreakowner.enemytargetmarkergroup ) && targetmarkergroups::targetmarkergroupexists( killstreakowner.enemytargetmarkergroup ) )
    {
        targetmarkergroupsetextrastate( killstreakowner.enemytargetmarkergroup, self, 0 );
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xb484ce94, Offset: 0x3035
// Size: 0x66
function killstreak_assigntargetmarkers( params = {} )
{
    if ( !isdefined( params.enemymarkerwidget ) )
    {
        params.enemymarkerwidget = params.var_d33b439c3dce3f3d;
    }
    
    if ( !isdefined( params.friendlymarkerwidget ) )
    {
        params.friendlymarkerwidget = params.var_4ef38b0aefb507c6;
    }
    
    return function_2f6864f010a9890d( params );
}

// Namespace killstreak_shared
// Params 2
// Checksum 0x64144c8, Offset: 0x30a4
// Size: 0x19f
function function_505d16f50dee75d2( var_4565558cb4444c1e, var_a713170297a2e4b )
{
    team = self.team;
    
    if ( level.teambased && !isdefined( team ) )
    {
        return;
    }
    
    if ( var_4565558cb4444c1e.size == 0 )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( isdefined( level.activekillstreaks ) && isdefined( self.enemytargetmarkergroup ) )
        {
            foreach ( ent in level.activekillstreaks )
            {
                if ( level.teambased )
                {
                    if ( ent.team === team )
                    {
                        continue;
                    }
                }
                else if ( ent.owner == self )
                {
                    continue;
                }
                
                if ( ent.streakname && arraycontains( var_4565558cb4444c1e, ent.streakname ) || ent.vehiclename && arraycontains( var_4565558cb4444c1e, ent.vehiclename ) )
                {
                    targetmarkergroups::targetmarkergroup_markentity( ent, self.enemytargetmarkergroup );
                    
                    if ( isarray( var_a713170297a2e4b ) && !arraycontains( var_a713170297a2e4b, ent ) )
                    {
                        var_a713170297a2e4b[ var_a713170297a2e4b.size ] = ent;
                    }
                    
                    if ( !isdefined( self.enemytargetmarkergroup ) )
                    {
                        return;
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace killstreak_shared
// Params 0
// Checksum 0xd9bcd694, Offset: 0x324b
// Size: 0x116
function function_b3302c4317df36c6()
{
    if ( isbot( self ) )
    {
        return;
    }
    
    suffix = self.name;
    
    if ( !isdefined( suffix ) )
    {
        suffix = "";
    }
    
    if ( isdefined( self.var_875dab35c0a0a5b ) )
    {
        foreach ( player in self.var_875dab35c0a0a5b )
        {
            player notify( "kill_streak_target_marker_end_" + suffix );
        }
    }
    
    self.var_875dab35c0a0a5b = undefined;
    self.var_7c32ee3e9ab8715e = undefined;
    waitframe();
    
    if ( isdefined( self.enemytargetmarkergroup ) )
    {
        namespace_9d8e359c3b1041e5::targetmarkergroup_offsharedfunc( self.enemytargetmarkergroup );
        self.enemytargetmarkergroup = undefined;
    }
    
    if ( isdefined( self.friendlytargetmarkergroup ) )
    {
        namespace_9d8e359c3b1041e5::targetmarkergroup_offsharedfunc( self.friendlytargetmarkergroup );
        self.friendlytargetmarkergroup = undefined;
    }
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x5072e18b, Offset: 0x3369
// Size: 0x54
function function_9fc2f7ee10890d99( streakname )
{
    bundle = killstreak::function_85b2d8e857ab4898( streakname );
    assetindex = function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb );
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_killstreak_index", assetindex );
    }
}

// Namespace killstreak_shared
// Params 0
// Checksum 0x46dffa4d, Offset: 0x33c5
// Size: 0x39
function function_76bbbe12ce816ed2()
{
    assetindex = function_43b5ed5a14a56573( #"scriptbundle_killstreak", %"killstreak:killstreak_none" );
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_killstreak_index", assetindex );
    }
}

// Namespace killstreak_shared
// Params 3
// Checksum 0x3b9561ef, Offset: 0x3406
// Size: 0xc6
function starttabletscreen( streakname, dofstartdelay, var_d254691d42ccc242 )
{
    screeninfo = function_30ef463cef7f8d2d( streakname );
    
    if ( !isdefined( screeninfo ) )
    {
        return;
    }
    
    thread tabletomnvarset( screeninfo.omnvar, screeninfo.index );
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        bundle = level.superglobals.staticsuperdata[ streakname ].bundle;
    }
    
    if ( !var_d254691d42ccc242 && ( !isdefined( bundle ) || !bundle.var_9f3a5648f6f44ca2 ) )
    {
        thread tabletdofset( dofstartdelay, 0 );
    }
}

// Namespace killstreak_shared
// Params 3
// Checksum 0x8043a393, Offset: 0x34d4
// Size: 0xb6
function stoptabletscreen( streakname, var_c12847357f18c6d6, var_d86a55c18547aeb9 )
{
    screeninfo = function_30ef463cef7f8d2d( streakname );
    
    if ( !isdefined( screeninfo ) )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( var_d86a55c18547aeb9 && ( !isdefined( bundle ) || !bundle.var_9f3a5648f6f44ca2 ) )
    {
        function_da69ab0b14abcbce();
    }
    
    thread tabletomnvarset( screeninfo.omnvar, -1, var_c12847357f18c6d6 );
    
    if ( !isdefined( bundle ) || !bundle.var_9f3a5648f6f44ca2 )
    {
        thread tabletdofset( var_c12847357f18c6d6, 1 );
    }
}

// Namespace killstreak_shared
// Params 3
// Checksum 0xcc5087b1, Offset: 0x3592
// Size: 0x5b
function tabletomnvarset( omnvar, omnvarval, omnvardelay )
{
    self endon( #"disconnect" );
    self notify( #"omnvar_set_tablet" );
    self endon( #"omnvar_set_tablet" );
    
    if ( omnvardelay > 0 )
    {
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( omnvardelay );
    }
    
    self setclientomnvar( omnvar, omnvarval );
}

// Namespace killstreak_shared
// Params 1, eflags: 0x4
// Checksum 0xfcb38435, Offset: 0x35f5
// Size: 0xdf
function private function_30ef463cef7f8d2d( streakname )
{
    if ( !isdefined( streakname ) )
    {
        /#
            iprintlnbold( "<dev string:x31a>" );
        #/
        
        return;
    }
    
    if ( isdefined( streakname ) && isdefined( level.streakglobals ) )
    {
        screenindex = level.streakglobals.var_9e0ca257f60b78aa[ streakname ];
    }
    else
    {
        screenindex = 0;
    }
    
    screenomnvar = "ui_remote_control_sequence";
    
    if ( !isdefined( screenindex ) )
    {
        screenindex = level.superglobals.staticsuperdata[ streakname ].id;
        screenomnvar = "ui_super_tablet_sequence";
        
        if ( !isdefined( screenindex ) )
        {
            /#
                iprintlnbold( "<dev string:x368>" + streakname );
            #/
            
            return;
        }
    }
    
    tabletinfo = spawnstruct();
    tabletinfo.index = screenindex;
    tabletinfo.omnvar = screenomnvar;
    return tabletinfo;
}

// Namespace killstreak_shared
// Params 2, eflags: 0x4
// Checksum 0x47c53ebc, Offset: 0x36dd
// Size: 0x9a
function private tabletdofset( dofdelay, stopdof )
{
    self endon( #"disconnect" );
    self notify( #"hash_cf5a85b43a7d3c56" );
    self endon( #"hash_cf5a85b43a7d3c56" );
    
    if ( isdefined( level.var_3bcca8adc0170ed4 ) )
    {
        val::group_set( level.var_3bcca8adc0170ed4, 0 );
    }
    
    if ( dofdelay > 0 )
    {
        namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( dofdelay );
    }
    
    if ( stopdof )
    {
        function_7ef9535e2b5c605b();
    }
    else
    {
        function_da69ab0b14abcbce();
    }
    
    if ( isdefined( level.var_3bcca8adc0170ed4 ) )
    {
        val::group_reset( level.var_3bcca8adc0170ed4 );
    }
}

// Namespace killstreak_shared
// Params 0
// Checksum 0x21efdb2a, Offset: 0x377f
// Size: 0x4b
function function_da69ab0b14abcbce()
{
    self enablephysicaldepthoffieldscripting();
    
    if ( namespace_9d8e359c3b1041e5::function_cfb5f8c2e930a89b() )
    {
        self enablephysicaldepthoffieldscripting( 1, 1 );
    }
    
    self setphysicaldepthoffield( 1, 0 );
    focusdist = namespace_9d8e359c3b1041e5::function_cfb5f8c2e930a89b() ? 10 : 256;
    self setphysicalviewmodeldepthoffield( 30, focusdist );
}

// Namespace killstreak_shared
// Params 0
// Checksum 0xe52d3258, Offset: 0x37d2
// Size: 0x1a
function function_7ef9535e2b5c605b()
{
    self disablephysicaldepthoffieldscripting();
    
    if ( namespace_9d8e359c3b1041e5::function_cfb5f8c2e930a89b() )
    {
        self enablephysicaldepthoffieldscripting( 1, 0 );
    }
}

// Namespace killstreak_shared
// Params 3, eflags: 0x4
// Checksum 0x1e470abe, Offset: 0x37f4
// Size: 0x56
function private function_5fe2177368586e2f( currenttime, starttime, duration )
{
    if ( duration > 0 )
    {
        timefraction = ( currenttime - starttime ) / duration;
        return clamp( timefraction, 0, 1 );
    }
    
    return 1;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x1d7f4d08, Offset: 0x3852
// Size: 0x5e
function function_852e7d8d403629e3( vehicleendtimems )
{
    if ( !isdefined( self.var_28cd81d46fd0a204 ) )
    {
        return;
    }
    
    var_de3b6d44a01e5998 = self.var_28cd81d46fd0a204 - self.var_134d670aa6c214cd;
    self.var_28cd81d46fd0a204 = vehicleendtimems;
    self.var_134d670aa6c214cd = vehicleendtimems - var_de3b6d44a01e5998;
    self notify( #"remoteCountdown_endTimeUpdated" );
}

// Namespace killstreak_shared
// Params 6
// Checksum 0xfcf8bdfc, Offset: 0x38b8
// Size: 0x2ac
function function_585fb909f40d8659( vehicleendtimems, var_d61c36eb638dde39, var_e8e1545192745f6d, var_6f6f6a50c6ae29e2, var_333357d527ec8015, var_165c49caef499b8a )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_de3b6d44a01e5998 = utility::function_4b74c15943231980( var_d61c36eb638dde39 );
    self.var_134d670aa6c214cd = vehicleendtimems - var_de3b6d44a01e5998;
    self.var_28cd81d46fd0a204 = vehicleendtimems;
    var_da416466614061ce = utility::function_4b74c15943231980( var_d61c36eb638dde39 - var_165c49caef499b8a );
    assert( var_da416466614061ce >= 0, "<dev string:x3ae>" );
    assert( var_6f6f6a50c6ae29e2 > 0, "<dev string:x3f3>" );
    assert( var_e8e1545192745f6d > 0, "<dev string:x419>" );
    
    if ( var_333357d527ec8015 > 0.05 )
    {
        var_333357d527ec8015 = 0.05;
    }
    
    currenttime = gettime();
    
    while ( currenttime < self.var_28cd81d46fd0a204 )
    {
        while ( currenttime < self.var_134d670aa6c214cd )
        {
            waittimesec = utility::function_6f5d2e1f1ff70482( self.var_134d670aa6c214cd - currenttime );
            utility::waittill_any_timeout( waittimesec, "remoteCountdown_endTimeUpdated" );
            currenttime = gettime();
        }
        
        while ( currenttime < self.var_28cd81d46fd0a204 )
        {
            self setscriptablepartstate( #"alert", #"on" );
            wait var_e8e1545192745f6d;
            self setscriptablepartstate( #"alert", #"off" );
            currenttime = gettime();
            
            if ( currenttime < self.var_134d670aa6c214cd )
            {
                break;
            }
            
            timefraction = function_5fe2177368586e2f( currenttime, self.var_134d670aa6c214cd, var_da416466614061ce );
            var_c760be110b328576 = utility::function_4b74c15943231980( math::lerp( var_6f6f6a50c6ae29e2, var_333357d527ec8015, timefraction ) );
            var_f7671337e135d613 = currenttime + var_c760be110b328576;
            var_bc17ff58ac9ed455 = currenttime;
            
            while ( currenttime < var_f7671337e135d613 )
            {
                waittimesec = utility::function_6f5d2e1f1ff70482( var_f7671337e135d613 - currenttime );
                waitres = utility::waittill_any_timeout( waittimesec, "remoteCountdown_endTimeUpdated" );
                currenttime = gettime();
                
                if ( waitres == "remoteCountdown_endTimeUpdated" && currenttime < var_f7671337e135d613 )
                {
                    if ( currenttime < self.var_134d670aa6c214cd )
                    {
                        break;
                    }
                    
                    var_f41adc2a595e83d = 1 - function_5fe2177368586e2f( currenttime, var_bc17ff58ac9ed455, var_c760be110b328576 );
                    timefraction = function_5fe2177368586e2f( currenttime, self.var_134d670aa6c214cd, var_da416466614061ce );
                    var_c760be110b328576 = var_f41adc2a595e83d * utility::function_4b74c15943231980( math::lerp( var_6f6f6a50c6ae29e2, var_333357d527ec8015, timefraction ) );
                    var_f7671337e135d613 = currenttime + var_c760be110b328576;
                }
            }
            
            if ( currenttime < self.var_134d670aa6c214cd )
            {
                break;
            }
            
            currenttime = gettime();
        }
    }
}

// Namespace killstreak_shared
// Params 8
// Checksum 0x58b86c94, Offset: 0x3b6c
// Size: 0x1bc
function function_51a64dfe550d76fa( player, vehicle, backoffset, upoffset, camerasphereradius, orbitdistanceoverride, var_efb1c56250121594, var_fcd28111ec91a02 )
{
    focuspos = vehicle.origin + vehicle function_90701fac2fe199e1();
    camangles = undefined;
    
    if ( isdefined( player ) )
    {
        camangles = player getplayerangles();
    }
    else
    {
        camangles = vehicle.angles;
    }
    
    camforward = anglestoforward( camangles );
    camanglesflat = utility::flat_angle( camangles );
    camforwardflat = anglestoforward( camanglesflat );
    orbitrange = orbitdistanceoverride ?? vehicle function_4313f2a677d66f0b();
    desiredcampos = focuspos - orbitrange * camforward - camforwardflat * backoffset + ( 0, 0, upoffset );
    zoffset = ( 0, 0, camerasphereradius );
    
    if ( isnumber( var_fcd28111ec91a02 ) )
    {
        zoffset = anglestoup( vehicle.angles ) * var_fcd28111ec91a02;
    }
    
    collisioncontents = var_efb1c56250121594 ?? trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1 );
    spheretrace = trace::sphere_trace( focuspos + zoffset, desiredcampos, camerasphereradius, vehicle, collisioncontents );
    result = spawnstruct();
    result.success = 0;
    
    if ( spheretrace[ "fraction" ] > 0 )
    {
        result.success = 1;
        result.focuspos = focuspos;
        result.camerapos = spheretrace[ "shape_position" ];
    }
    
    return result;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xad6dc9cd, Offset: 0x3d31
// Size: 0x21, Type: bool
function isremotekillstreakweapon( weapon )
{
    return weapon.killstreakdeploycategory != #"none";
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x47939209, Offset: 0x3d5b
// Size: 0x40, Type: bool
function iskillstreaklockonable( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( bundle.var_1378fa6b2a0cff51 )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreak_shared
// Params 1
// Checksum 0x8b5abdb, Offset: 0x3da4
// Size: 0x3a, Type: bool
function iskillstreakauto( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    return istrue( bundle.isauto );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xd01d7869, Offset: 0x3de7
// Size: 0x3a, Type: bool
function iskillstreakgrounded( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    return istrue( bundle.isground );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xecd56b95, Offset: 0x3e2a
// Size: 0x3a, Type: bool
function function_2e80bd8941888e8e( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    return istrue( bundle.isaerial );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xa0614fe3, Offset: 0x3e6d
// Size: 0x3a, Type: bool
function iskillstreaksupport( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    return istrue( bundle.issupport );
}

// Namespace killstreak_shared
// Params 1
// Checksum 0xa0614fe3, Offset: 0x3eb0
// Size: 0x3a, Type: bool
function iskillstreakvehicle( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    return istrue( bundle.isvehicle );
}

