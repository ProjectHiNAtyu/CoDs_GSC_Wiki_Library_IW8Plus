// script_3f883e880904e5df  (hash_3f883e880904e5df.gscc) (size: 9013 Bytes / 0x2335 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd0eac062 (3505045602)
// size ...... 9013 (0x2335)
// includes .. 13  (offset: 0x222d)
// strings ... 9   (offset: 0x2295)
// dev strs .. 3   (offset: 0x2311)
// exports ... 21  (offset: 0x1695)
// cseg ...... 0x128 + 0x156d (0x1695)
// imports ... 74  (offset: 0x19dd)
// animtree1 . 0   (offset: 0x2335)
// animtree2 . 0   (offset: 0x2335)
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_f00cbee467b4e1f3;

// Namespace namespace_f00cbee467b4e1f3
// Params 0, eflags: 0x5
// Checksum 0xc2a15ca7, Offset: 0x146
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_60ba902b1d647a74", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_f00cbee467b4e1f3
// Params 0, eflags: 0x4
// Checksum 0xc8160ae7, Offset: 0x16f
// Size: 0xcb
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"can_airdrop_package", #"crate", &utility::always_true );
    utility::registersharedfunc( #"hash_c0543f4480543c68", #"crate", &createcrate );
    utility::registersharedfunc( #"hash_270838ed4fd5716e", #"crate", &function_a3e10cb868818fa8 );
    
    /#
        utility::registersharedfunc( #"hash_957e5882bc1fa7c5", #"crate", &debug_deleteall );
        utility::registersharedfunc( #"hash_da0b3038771ec485", #"crate", &debug_drawlocations );
    #/
    
    airdrop_scriptbundle::function_b4c731c3e4c3c17d( "vfx_iw9_strk_carepackage_base_fx_fade" );
    airdrop_scriptbundle::function_b4c731c3e4c3c17d( "vfx_iw9_strk_carepackage_base_fx_fade_wtr" );
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0x52297e41, Offset: 0x242
// Size: 0x23
function private function_a3e10cb868818fa8( airdropsettings )
{
    level thread function_9345a32c67fbd8f5( airdropsettings );
    
    /#
        level thread function_f8af30cb25ee91f5( airdropsettings );
    #/
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0xd55aaff3, Offset: 0x26d
// Size: 0x1ba
function private function_9345a32c67fbd8f5( airdropsettings )
{
    utility::flag_wait( "airdrop_init_crate_data" );
    leveldata = airdrop::getleveldata( airdropsettings.airdropidentifier );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    leveldata.capturestring = packagesettings.capturestring;
    leveldata.basemodel = packagesettings.packagemodel;
    leveldata.mountmantlemodel = undefined;
    leveldata.headicon = undefined;
    leveldata.timeout = undefined;
    leveldata.supportsownercapture = undefined;
    leveldata.onecaptureperplayer = packagesettings.var_6762343081e284fe ? 1 : packagesettings.var_d3dffdadce47691a;
    leveldata.exclusiveuse = packagesettings.exclusiveuse;
    leveldata.hasnointeraction = packagesettings.hasnointeraction;
    leveldata.destroyoncapture = packagesettings.var_6762343081e284fe;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.isdropcrate = 1;
    leveldata.friendlyuseonly = packagesettings.var_abc6bc2495fb4956 == "team";
    leveldata.activatecallback = &crateactivatecallback;
    leveldata.capturecallback = &cratecapturecallback;
    leveldata.destroycallback = &cratedestroycallback;
    leveldata.capturevisualscallback = &function_6cd6a0d2b0e5de75;
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0x2095aa33, Offset: 0x42f
// Size: 0x19b
function private crateactivatecallback( isfirstactivation )
{
    crate = self;
    packagesettings = level.package_airdrop.airdroptypes[ crate.airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( isdefined( crate.var_f82dd71df52f14e2 ) && packagesettings.var_c807b4cf63af6495 )
    {
        crate.var_f82dd71df52f14e2 freescriptable();
        crate.var_f82dd71df52f14e2 = undefined;
    }
    
    if ( isfirstactivation )
    {
        function_d66f1951c6625126( crate );
        utility::callsharedfunc( #"airdrop", #"registercrateforcleanup", crate );
        
        if ( packagesettings.var_54fc859286c6bbff )
        {
            nearbyloot = getlootscriptablearrayinradius( undefined, undefined, crate.origin, packagesettings.var_72cc9351de30b080 );
            
            foreach ( lootitem in nearbyloot )
            {
                if ( lootitem getscriptableisloot() && !lootitem scriptableislootcache() )
                {
                    common_item::function_869d7676e359a627( lootitem );
                }
            }
        }
    }
    
    crate airdrop_scriptbundle::function_e9dbf2aaef9f1c96( crate.airdropsettings, #"crateactivatefunc", isfirstactivation );
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0x9f1a8931, Offset: 0x5d2
// Size: 0x181
function private cratecapturecallback( player )
{
    crate = self;
    player airdrop_scriptbundle::function_e9dbf2aaef9f1c96( crate.airdropsettings, #"playerusefunc", crate );
    packagesettings = level.package_airdrop.airdroptypes[ crate.airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( packagesettings.capturesound )
    {
        player playsoundtoplayer( packagesettings.capturesound, player );
    }
    
    if ( packagesettings.capturescoreevent )
    {
        xpreward = packagesettings.var_20142244521fa24b;
        
        if ( xpreward && packagesettings.var_a507f358959be27b && level.br_circle.circleindex > 0 )
        {
            circleindex = level.br_circle.circleindex;
            
            if ( packagesettings.var_2124e43e9c927466 > 0 )
            {
                circleindex = int( min( circleindex, packagesettings.var_2124e43e9c927466 ) );
            }
            
            xpreward += packagesettings.var_a507f358959be27b * circleindex;
        }
        
        player thread points::doscoreevent( packagesettings.capturescoreevent, undefined, xpreward );
    }
    
    crate function_52a1beb41b9ae73c();
    
    if ( packagesettings.var_6762343081e284fe )
    {
        crate destroycrate();
    }
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0x609840dc, Offset: 0x75b
// Size: 0x41
function private cratedestroycallback( immediate )
{
    crate = self;
    crate airdrop_scriptbundle::function_e9dbf2aaef9f1c96( crate.airdropsettings, #"cratedestroyfunc", immediate );
    crate destroycrate();
}

// Namespace namespace_f00cbee467b4e1f3
// Params 0, eflags: 0x4
// Checksum 0x797e49a8, Offset: 0x7a4
// Size: 0x5c
function private destroycrate()
{
    crate = self;
    
    if ( !isdefined( crate ) || crate.var_cdfee38a78fe4760 )
    {
        return;
    }
    
    crate airdrop::makecrateunusable();
    crate.var_cdfee38a78fe4760 = 1;
    
    if ( isdefined( crate.var_f82dd71df52f14e2 ) )
    {
        crate.var_f82dd71df52f14e2 freescriptable();
    }
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0xe79c33c1, Offset: 0x808
// Size: 0xcb
function private function_6cd6a0d2b0e5de75( model )
{
    if ( !( isdefined( self ) && isdefined( model ) ) )
    {
        return;
    }
    
    calloutmarkerping::function_608710c894185549();
    angle = math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( self.angles ) );
    
    if ( angle <= 100 )
    {
        self setscriptablepartstate( "capture_effect", self.inwater ? "water_fade" : "land_fade", 0 );
        return;
    }
    
    fadeeffect = self.inwater ? "vfx_iw9_strk_carepackage_base_fx_fade_wtr" : "vfx_iw9_strk_carepackage_base_fx_fade";
    playfxontag( level.package_airdrop.loadedeffects[ fadeeffect ], model, "tag_origin" );
    waitframe();
    
    if ( self )
    {
        self delete();
    }
}

// Namespace namespace_f00cbee467b4e1f3
// Params 0, eflags: 0x4
// Checksum 0xb7bf552, Offset: 0x8db
// Size: 0x11f
function private function_52a1beb41b9ae73c()
{
    crate = self;
    
    if ( crate.var_cdfee38a78fe4760 )
    {
        return;
    }
    
    packagesettings = level.package_airdrop.airdroptypes[ crate.airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    var_4b7ad4b139889a6e = packagesettings.var_788f3d2c979dee70;
    
    if ( !isdefined( var_4b7ad4b139889a6e ) )
    {
        return;
    }
    
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( var_4b7ad4b139889a6e );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        droporigin = self.origin;
        dropangles = self.angles;
        itemspawnoptions = common_item::items_initspawnoptions_spawnfromposition( droporigin, dropangles );
        itemspawnoptions.ignoreents = [ crate ];
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, itemspawnoptions );
    }
}

/#

    // Namespace namespace_f00cbee467b4e1f3
    // Params 1, eflags: 0x4
    // Checksum 0x72aa522d, Offset: 0xa02
    // Size: 0xcb, Type: dev
    function private function_f8af30cb25ee91f5( airdropsettings )
    {
        packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
        var_4b7ad4b139889a6e = packagesettings.var_788f3d2c979dee70;
        
        if ( !isdefined( var_4b7ad4b139889a6e ) )
        {
            return;
        }
        
        utility::flag_wait( "<dev string:x24>" );
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( var_4b7ad4b139889a6e );
        
        if ( !( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) ) )
        {
            script::demoforcesre( "<dev string:x38>" + var_4b7ad4b139889a6e + "<dev string:x6a>" + airdropsettings.airdropidentifier );
        }
    }

#/

// Namespace namespace_f00cbee467b4e1f3
// Params 6
// Checksum 0x3b8bd626, Offset: 0xad5
// Size: 0x437
function createcrate( airdropsettings, position, destination, angles, initialvelocity, var_e9a9d186782e327b = 1 )
{
    level endon( #"game_ended" );
    function_6c0278ad62f38136( airdropsettings );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    var_26b00cc61fbc49d6 = packagesettings.var_abc6bc2495fb4956;
    var_47533c38c696f3e1 = packagesettings.var_47533c38c696f3e1;
    var_9170f56c924e5e7a = !packagesettings.useparachute || !var_e9a9d186782e327b;
    var_f1b1db4ae9e5ccbc = airdropsettings.overrideoptions.var_f1b1db4ae9e5ccbc || var_ef8325c1086c2688.type == #"drone" || var_ef8325c1086c2688.type == #"lightweight_drone" || var_ef8325c1086c2688.type == #"flee_drone" || var_ef8325c1086c2688.type == #"chopper";
    releaseoffset = airdropsettings.overrideoptions.var_a04c79fab32daf76 ?? var_ef8325c1086c2688.var_a04c79fab32daf76;
    crate = airdrop::function_c9f138f3e91e2f7f( position, destination, angles ?? ( 0, 0, 0 ), var_9ae4b3950522d64e.airdropidentifier, airdropsettings.team, var_9170f56c924e5e7a, var_e9a9d186782e327b, var_f1b1db4ae9e5ccbc, releaseoffset );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( airdropsettings.player )
    {
        crate setotherent( airdropsettings.player );
    }
    
    crate function_468070f454802d36( airdropsettings );
    crate function_72b6b321929f8b90( airdropsettings );
    
    foreach ( set in packagesettings.setonspawn )
    {
        if ( crate getscriptableparthasstate( set.part, set.state ) )
        {
            crate setscriptablepartstate( set.part, set.state );
        }
    }
    
    crate.airdropsettings = airdropsettings;
    crate.usetimeoverride = packagesettings.var_e378e8cc5a06a8e0;
    crate.friendlyuseonly = var_26b00cc61fbc49d6 == "team";
    crate.var_47533c38c696f3e1 = var_47533c38c696f3e1;
    crate.skipminimapicon = !( airdropsettings.overrideoptions.skipminimapicon === 0 );
    crate.var_506f162fae5199cc = airdropsettings.overrideoptions.var_506f162fae5199cc;
    crate airdrop_scriptbundle::function_e9dbf2aaef9f1c96( crate.airdropsettings, #"hash_f35f0e2b6123474f", airdropsettings );
    crate thread airdrop_scriptbundle::function_4c121ea2c29854e8( airdropsettings );
    
    if ( var_ef8325c1086c2688.type == #"instant_drop" )
    {
        crate thread function_340d642e069cfff3( destination );
    }
    
    if ( var_e9a9d186782e327b && utility::issharedfuncdefined( #"redeploy_drone", #"dropbag_collision_watcher" ) )
    {
        crate thread [[ utility::getsharedfunc( #"redeploy_drone", #"dropbag_collision_watcher" ) ]]();
    }
    
    return crate;
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0x98cb6be0, Offset: 0xf15
// Size: 0xbf
function private function_d66f1951c6625126( crate )
{
    airdropidentifier = crate.airdropsettings.airdropidentifier;
    
    if ( !isdefined( level.package_airdrop.crates[ airdropidentifier ] ) )
    {
        level.package_airdrop.crates[ airdropidentifier ] = [];
    }
    
    level.package_airdrop.crates[ airdropidentifier ] = function_5713d46873b29625( level.package_airdrop.crates[ airdropidentifier ] );
    level.package_airdrop.crates[ airdropidentifier ][ level.package_airdrop.crates[ airdropidentifier ].size ] = crate;
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0x428a3630, Offset: 0xfdc
// Size: 0x167
function private function_6c0278ad62f38136( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( packagesettings.var_abc6bc2495fb4956 == "team" && airdropsettings.team && packagesettings.var_e46b95a026fd1532 )
    {
        airdropidentifier = airdropsettings.airdropidentifier;
        
        if ( !isdefined( level.package_airdrop.crates[ airdropidentifier ] ) )
        {
            level.package_airdrop.crates[ airdropidentifier ] = [];
        }
        
        crates = level.package_airdrop.crates[ airdropidentifier ];
        var_d820df93aca9882e = 0;
        
        for ( i = crates.size - 1; i >= 0 ; i-- )
        {
            var_ebe1c3fe89b6613c = crates[ i ];
            
            if ( var_ebe1c3fe89b6613c.team == airdropsettings.team )
            {
                var_d820df93aca9882e++;
                
                if ( var_d820df93aca9882e >= packagesettings.var_e46b95a026fd1532 )
                {
                    crates[ i ] = undefined;
                    
                    if ( isint( i ) )
                    {
                        function_cdc669dbc8ea2101( crates );
                    }
                    
                    var_ebe1c3fe89b6613c airdrop::destroycrate();
                }
            }
        }
    }
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0xd6932b9, Offset: 0x114b
// Size: 0x111
function private function_340d642e069cfff3( destination )
{
    self endon( #"death", #"collision" );
    movingplatform = undefined;
    
    while ( true )
    {
        if ( !movingplatform )
        {
            movingplatformcheck = { #angles:( 0, 0, 0 ), #origin:destination };
            movingplatforminfo = movingplatformcheck utility::function_7c45b71b8e0d3cff();
            movingplatform = movingplatforminfo.groundent;
            
            if ( !movingplatform )
            {
                return;
            }
            
            movingplatformcheck = undefined;
            movingplatforminfo = undefined;
            original_offset = rotatevector( destination - movingplatform.origin, -1 * movingplatform.angles );
        }
        
        current_offset = rotatevector( original_offset, movingplatform.angles );
        self.origin = ( ( movingplatform.origin + current_offset )[ 0 ], ( movingplatform.origin + current_offset )[ 1 ], self.origin[ 2 ] );
        waitframe();
    }
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0xc7aa41f4, Offset: 0x1264
// Size: 0x7f
function private function_468070f454802d36( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( !isdefined( packagesettings.var_47b0cac39326a270 ) )
    {
        return;
    }
    
    self.var_f82dd71df52f14e2 = spawnscriptable( packagesettings.var_47b0cac39326a270, self.destination );
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0xd31f2e11, Offset: 0x12eb
// Size: 0x91
function private function_72b6b321929f8b90( airdropsettings )
{
    if ( !self getscriptablehaspart( #"objective" ) )
    {
        return;
    }
    
    self setscriptablepartstate( #"objective", #"active", 1 );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( packagesettings.pingonspawn )
    {
        thread function_b980bcbf4ce95ad3( airdropsettings );
    }
}

// Namespace namespace_f00cbee467b4e1f3
// Params 1, eflags: 0x4
// Checksum 0xb1e8aae3, Offset: 0x1384
// Size: 0x1a0
function private function_b980bcbf4ce95ad3( airdropsettings )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    package = self;
    var_e721f1409fd57ca9 = undefined;
    
    switch ( packagesettings.pingonspawn )
    {
        case #"hash_87d1443ef2805760":
            if ( isdefined( airdropsettings.player ) )
            {
                var_e721f1409fd57ca9 = [ airdropsettings.player ];
            }
            
            break;
        case #"hash_33857c6e26098e6c":
            if ( isdefined( airdropsettings.team ) )
            {
                var_e721f1409fd57ca9 = teams::getteamdata( airdropsettings.team, "players" );
            }
            
            break;
        case #"hash_c482c6c109150a4":
            var_e721f1409fd57ca9 = level.players;
            break;
    }
    
    foreach ( player in var_e721f1409fd57ca9 )
    {
        if ( !player::isreallyalive( player ) || player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player calloutmarkerping::function_920a63c06abdefe8( package getscriptableindex() );
    }
}

/#

    // Namespace namespace_f00cbee467b4e1f3
    // Params 0
    // Checksum 0x957895cd, Offset: 0x152c
    // Size: 0x9b, Type: dev
    function debug_deleteall()
    {
        foreach ( package in level.cratedata.crates )
        {
            if ( !isdefined( package.airdropsettings ) )
            {
                continue;
            }
            
            package airdrop::destroycrate();
        }
    }

    // Namespace namespace_f00cbee467b4e1f3
    // Params 0
    // Checksum 0xb083b870, Offset: 0x15cf
    // Size: 0xc6, Type: dev
    function debug_drawlocations()
    {
        foreach ( crate in level.cratedata.crates )
        {
            if ( !isdefined( crate.airdropsettings ) )
            {
                continue;
            }
            
            airdrop_scriptbundle::function_cbfae468752db826( crate.origin, crate.airdropsettings.airdropidentifier, ( 0, 1, 1 ) );
        }
    }

#/
