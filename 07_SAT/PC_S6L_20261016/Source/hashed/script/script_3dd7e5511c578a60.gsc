// script_3dd7e5511c578a60  (hash_3dd7e5511c578a60.gscc) (size: 12851 Bytes / 0x3233 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11cfafcb (298823627)
// size ...... 12851 (0x3233)
// includes .. 13  (offset: 0x304b)
// strings ... 25  (offset: 0x30b3)
// dev strs .. 4   (offset: 0x3203)
// exports ... 23  (offset: 0x2077)
// cseg ...... 0x29c + 0x1ddb (0x2077)
// imports ... 104 (offset: 0x240f)
// animtree1 . 0   (offset: 0x3233)
// animtree2 . 0   (offset: 0x3233)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\loot\common_cache;
#using scripts\mp\poi;

#namespace namespace_70597ca975b0c1f0;

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x5
// Checksum 0xd3f35f53, Offset: 0x2ba
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_eb8ef51e40311347", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0x42d575ab, Offset: 0x2e3
// Size: 0x145
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    br_circle::registercirclecallbacks( 28, &dangercircletick, &dangermulticircletick );
    utility::registersharedfunc( #"can_airdrop_package", #"loot_cache", &cancreatelootcache );
    utility::registersharedfunc( #"hash_c0543f4480543c68", #"loot_cache", &function_d78f3690c78536de );
    utility::registersharedfunc( #"hash_270838ed4fd5716e", #"loot_cache", &function_a3e10cb868818fa8 );
    
    /#
        utility::registersharedfunc( #"hash_957e5882bc1fa7c5", #"loot_cache", &debug_deleteall );
        utility::registersharedfunc( #"hash_da0b3038771ec485", #"loot_cache", &debug_drawlocations );
    #/
    
    level callback::add( #"cache_opened", &function_ff0cca529842eb06 );
    level.package_airdrop.var_86ed09d46a5c6f8f = getdvarint( @"hash_599ecccae40cc871", 20 );
    level.package_airdrop.var_b6456acf0ffbf6b7 = getdvarint( @"hash_2cced7736d23f3f", 1 );
    level.package_airdrop.var_ffe0b093b922a873 = getdvarint( @"hash_3f0579704eb5d8c1", 1 );
}

// Namespace namespace_70597ca975b0c1f0
// Params 1, eflags: 0x4
// Checksum 0xea520b6e, Offset: 0x430
// Size: 0xe5
function private function_a3e10cb868818fa8( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    packagesettings.var_c8cb16da52719c73 = ( packagesettings.var_c8cb16da52719c73.x, packagesettings.var_c8cb16da52719c73.y, packagesettings.var_c8cb16da52719c73.z );
    packagesettings.var_2ac4f3c58b653a3d = ( packagesettings.var_2ac4f3c58b653a3d.x, packagesettings.var_2ac4f3c58b653a3d.y, packagesettings.var_2ac4f3c58b653a3d.z );
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0xff16b77a, Offset: 0x51d
// Size: 0x2a, Type: bool
function private cancreatelootcache()
{
    return level.package_airdrop.var_c8ea1e210052cfc0.size < level.package_airdrop.var_86ed09d46a5c6f8f;
}

// Namespace namespace_70597ca975b0c1f0
// Params 7, eflags: 0x4
// Checksum 0xd62261bf, Offset: 0x550
// Size: 0x370
function private function_d78f3690c78536de( airdropsettings, dropposition, dropdestination, dropangles, initialvelocity, var_e9a9d186782e327b = 1, var_68d5bca3cd17f657 )
{
    level endon( #"game_ended" );
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    assert( isdefined( packagesettings.lootcachemodel ), "<dev string:x24>" );
    randomimpulse = ( 0, 0, randomfloatrange( packagesettings.var_9983164080524de3, packagesettings.var_46e1cf80d4b0bf3d ) * -1 );
    cache = spawn( "script_model", dropposition );
    cache.angles = dropangles ?? ( 0, 0, 0 );
    cache setmodel( packagesettings.lootcachemodel );
    cache.spawnorigin = dropposition;
    cache.var_83f994db6ffbd58d = dropposition[ 2 ];
    
    if ( isdefined( airdropsettings.var_c1a665690b72db5b ) )
    {
        cache.var_c1a665690b72db5b = airdropsettings.var_c1a665690b72db5b;
        cache.var_f7f321cb87219557 = gettime() + 50;
    }
    
    launchvelocity = initialvelocity ?? randomimpulse;
    var_ae148aec4252c62e = utility::function_45361634b6ee16ea( packagesettings.var_c8cb16da52719c73, packagesettings.var_2ac4f3c58b653a3d );
    windroll = randomfloatrange( packagesettings.var_568a594716db1d64, packagesettings.var_56ad6747170183e6 );
    windpitch = randomfloatrange( packagesettings.var_568a594716db1d64, packagesettings.var_56ad6747170183e6 );
    
    if ( utility::cointoss() )
    {
        windroll *= -1;
    }
    
    if ( utility::cointoss() )
    {
        windpitch *= -1;
    }
    
    if ( !var_e9a9d186782e327b )
    {
        cache.var_fe2a17068a3c0fa6 = &function_b469043c6432d722;
        cache.var_1967d030207bed9d = launchvelocity;
        cache.var_2282b030b6510534 = var_ae148aec4252c62e[ 0 ] + windroll;
        cache.var_2282b130b6510767 = var_ae148aec4252c62e[ 1 ] + windpitch;
        cache.var_2282b230b651099a = var_ae148aec4252c62e[ 2 ];
    }
    else
    {
        cache physicslaunchserver( ( 0, 0, 0 ), launchvelocity );
        cache physics_registerforcollisioncallback();
        bodyid = cache physics_getbodyid( 0 );
        physics_setbodyangvel( bodyid, var_ae148aec4252c62e[ 0 ] + windroll, var_ae148aec4252c62e[ 1 ] + windpitch, var_ae148aec4252c62e[ 2 ] );
    }
    
    level.package_airdrop.var_c8ea1e210052cfc0[ level.package_airdrop.var_c8ea1e210052cfc0.size ] = cache;
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    
    /#
        cache.var_45394fecf9989389 = var_9ae4b3950522d64e.airdropidentifier;
    #/
    
    cache thread airdrop_scriptbundle::function_4c121ea2c29854e8( airdropsettings );
    cache airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_f35f0e2b6123474f", airdropsettings );
    cache airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_f2bed8cbcee2e95f", airdropsettings );
    calloutmarkerping::function_6052d1ed5729bcfc( cache );
    cache thread function_ee59dcbb53654d54( airdropsettings );
    return cache;
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0xfb502c7, Offset: 0x8c9
// Size: 0xbe
function private function_b469043c6432d722()
{
    launchvelocity = self.var_1967d030207bed9d;
    var_2bcba263e70c41db = self.var_2282b030b6510534;
    var_2bcba163e70c3fa8 = self.var_2282b130b6510767;
    var_2bcba463e70c4641 = self.var_2282b230b651099a;
    self.var_fe2a17068a3c0fa6 = undefined;
    self.var_1967d030207bed9d = undefined;
    self.var_2282b030b6510534 = undefined;
    self.var_2282b130b6510767 = undefined;
    self.var_2282b230b651099a = undefined;
    self unlink();
    self physicslaunchserver( ( 0, 0, 0 ), launchvelocity );
    self physics_registerforcollisioncallback();
    bodyid = self physics_getbodyid( 0 );
    physics_setbodyangvel( bodyid, var_2bcba263e70c41db, var_2bcba163e70c3fa8, var_2bcba463e70c4641 );
}

// Namespace namespace_70597ca975b0c1f0
// Params 3, eflags: 0x4
// Checksum 0x267e609a, Offset: 0x98f
// Size: 0x2d6
function private function_6270e2ff9468d16d( airdropsettings, origin, angles )
{
    cache = self;
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    cache physicsstopserver();
    origin = ( round( origin[ 0 ] ), round( origin[ 1 ] ), round( origin[ 2 ] ) );
    [ origin, angles ] = function_d66e95106ea59dae( origin, angles );
    scriptcache = common_cache::function_9bc018c1b8aad720( packagesettings.var_788f3d2c979dee70, origin, angles, #"closed_usable", level.commonitem.var_f4a0cd0e44af4832 );
    scriptcache.airdropsettings = airdropsettings;
    scriptcache.sourcecache = cache;
    scriptcache.var_57eb671c310bb38e = cache.var_57eb671c310bb38e;
    var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ];
    
    /#
        scriptcache.var_89753ccdb297c046 = cache.var_89753ccdb297c046;
        scriptcache.var_45394fecf9989389 = var_9ae4b3950522d64e.airdropidentifier;
    #/
    
    scriptcache airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_bf45f87bd7e526e0", airdropsettings );
    level.package_airdrop.var_4dfa54f2d1f0e195[ level.package_airdrop.var_4dfa54f2d1f0e195.size ] = scriptcache;
    
    if ( isdefined( level.package_airdrop.var_ef017093c633eeef ) )
    {
        [[ level.package_airdrop.var_ef017093c633eeef ]]( scriptcache );
    }
    
    scriptcache.var_9b37af822a368683 = cache.var_9b37af822a368683;
    calloutmarkerping::function_9bd4bf4f8fe74b16( cache, scriptcache, 9 );
    
    if ( cache.var_89753ccdb297c046.var_a64aaeb169f6702d )
    {
        attachto = cache.var_89753ccdb297c046.var_a64aaeb169f6702d;
        origin_offset = rotatevectorinverted( scriptcache.origin - attachto.origin, attachto.angles );
        angles_offset = combineangles( invertangles( attachto.angles ), scriptcache.angles );
        scriptcache utility::scriptable_setparententity( attachto, origin_offset, angles_offset );
    }
    
    waitframe();
    level.package_airdrop.var_c8ea1e210052cfc0 = arrayremove( level.package_airdrop.var_c8ea1e210052cfc0, cache );
    cache delete();
    return scriptcache;
}

// Namespace namespace_70597ca975b0c1f0
// Params 2, eflags: 0x4
// Checksum 0xd5517e55, Offset: 0xc6e
// Size: 0x2a3
function private function_c2f5e7b9310cf71a( airdropsettings, failurereason )
{
    cache = self;
    var_89753ccdb297c046 = cache.var_89753ccdb297c046;
    var_1fb5cd740dc5190a = var_89753ccdb297c046.origin ?? cache.spawnorigin;
    recoveryorigin = var_89753ccdb297c046.position ?? var_1fb5cd740dc5190a;
    recoverynormal = var_89753ccdb297c046.normal ?? ( 0, 0, 1 );
    
    if ( !isdefined( var_1fb5cd740dc5190a ) )
    {
        failuremessage = "Airdrop Scriptbundle: Dropped loot cache " + failurereason + ". Current location: " + cache.origin + ". Spawned drop origin: " + ( cache.spawnorigin ?? "<undefined>" ) + ". Scripted drop origin: " + ( airdropsettings.var_c2fa1e6335a19103 ?? "<undefined>" ) + ". Impact cache origin: " + ( var_89753ccdb297c046.origin ?? "<undefined>" ) + ". Impact cache angles: " + ( var_89753ccdb297c046.angles ?? "<undefined>" ) + ". Impact position: " + ( var_89753ccdb297c046.position ?? "<undefined>" ) + ". Impact normal: " + ( var_89753ccdb297c046.normal ?? "<undefined>" ) + ". Impact impulse: " + ( var_89753ccdb297c046.impulse ?? "<undefined>" ) + ".";
        script::demoforcesre( failuremessage + " Recovery failed because no valid impact origin was recorded before the physics error." );
        level.package_airdrop.var_c8ea1e210052cfc0 = arrayremove( level.package_airdrop.var_c8ea1e210052cfc0, cache );
        cache delete();
        return;
    }
    
    traceresult = trace::ray_trace( var_1fb5cd740dc5190a + ( 0, 0, 200 ), var_1fb5cd740dc5190a + ( 0, 0, -5120 ), cache, trace::create_solid_ai_contents( 1 ) );
    traceorigin = traceresult[ "position" ];
    var_22843a40723b373c = traceresult[ "normal" ];
    
    if ( isdefined( traceorigin ) )
    {
        recoveryorigin = traceorigin;
    }
    
    if ( isdefined( var_22843a40723b373c ) && lengthsquared( var_22843a40723b373c ) > 0 )
    {
        recoverynormal = vectornormalize( var_22843a40723b373c );
    }
    else if ( lengthsquared( recoverynormal ) > 0 )
    {
        recoverynormal = vectornormalize( recoverynormal );
    }
    else
    {
        recoverynormal = ( 0, 0, 1 );
    }
    
    recoveryangles = math::build_matrix_from_up_and_angles( recoverynormal, var_89753ccdb297c046.angles ?? cache.angles );
    cache function_6270e2ff9468d16d( airdropsettings, recoveryorigin, recoveryangles );
}

// Namespace namespace_70597ca975b0c1f0
// Params 1, eflags: 0x4
// Checksum 0xeb2bae61, Offset: 0xf19
// Size: 0xde
function private function_ee59dcbb53654d54( airdropsettings )
{
    level endon( #"game_ended" );
    cache = self;
    cache function_da42ae520c0878d( airdropsettings );
    
    if ( !cache )
    {
        level.package_airdrop.var_c8ea1e210052cfc0 = function_5713d46873b29625( level.package_airdrop.var_c8ea1e210052cfc0 );
        return;
    }
    
    origin = ( round( cache.origin[ 0 ] ), round( cache.origin[ 1 ] ), round( cache.origin[ 2 ] ) );
    angles = cache.angles;
    
    if ( origin[ 2 ] < -1500 )
    {
        cache function_c2f5e7b9310cf71a( airdropsettings, "fell below map" );
        return;
    }
    
    cache function_6270e2ff9468d16d( airdropsettings, origin, angles );
}

// Namespace namespace_70597ca975b0c1f0
// Params 1, eflags: 0x4
// Checksum 0x6767429d, Offset: 0xfff
// Size: 0x29
function private function_a2c2df16aea81b00( airdropsettings )
{
    self endon( #"death" );
    wait 30;
    function_c2f5e7b9310cf71a( airdropsettings, "timed out before settling" );
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0x3b50712b, Offset: 0x1030
// Size: 0x54
function private function_c791346ea79f212c()
{
    glassradiusdamage( self.origin - ( 0, 0, 10 ), 100, 1000, 1000 );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self physics_registerforcollisioncallback();
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0x39e710ac, Offset: 0x108c
// Size: 0xa8
function private function_6d2fd688d80f2ea2()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        surfacetype = airdrop_scriptbundle::function_aef9ca62004f1c71( flag1 );
        
        if ( !airdrop_scriptbundle::function_8372b749a15d1bab( surfacetype, self.origin, position ) )
        {
            continue;
        }
        
        function_c791346ea79f212c();
    }
}

// Namespace namespace_70597ca975b0c1f0
// Params 1, eflags: 0x4
// Checksum 0xc11a7e39, Offset: 0x113c
// Size: 0xe1
function private function_bc8863a42d52a5b1( airdropsettings )
{
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( !isdefined( packagesettings.var_67951caebac1449c ) )
    {
        return;
    }
    
    var_9b37af822a368683 = spawnscriptable( packagesettings.var_67951caebac1449c, self.origin, self.angles );
    var_9b37af822a368683 utility::scriptable_setparententity( self );
    self.var_9b37af822a368683 = var_9b37af822a368683;
    
    if ( !isdefined( packagesettings.var_bc64164ea8ee19bf ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    var_9b37af822a368683 endon( #"death" );
    wait packagesettings.var_bc64164ea8ee19bf;
    
    if ( isdefined( var_9b37af822a368683 ) )
    {
        var_9b37af822a368683 freescriptable();
    }
}

// Namespace namespace_70597ca975b0c1f0
// Params 1, eflags: 0x4
// Checksum 0x46fe3e8e, Offset: 0x1225
// Size: 0x522
function private function_da42ae520c0878d( airdropsettings )
{
    self endon( #"death" );
    childthread function_a2c2df16aea81b00( airdropsettings );
    childthread function_6d2fd688d80f2ea2();
    childthread function_d45f301f92a095c4();
    spawnheight = self.var_83f994db6ffbd58d ?? self.origin[ 2 ];
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        surfacetype = airdrop_scriptbundle::function_aef9ca62004f1c71( flag1 );
        
        if ( airdrop_scriptbundle::function_f2c0966ac33e9339( ent, surfacetype, position ) )
        {
            continue;
        }
        
        break;
    }
    
    thread function_bc8863a42d52a5b1( airdropsettings );
    self.var_89753ccdb297c046 = { #impulse:impulse, #normal:normal, #position:position, #angles:self.angles, #origin:self.origin };
    
    if ( ent.classname != "worldspawn" )
    {
        self.var_89753ccdb297c046.var_a64aaeb169f6702d = ent;
    }
    
    packagesettings = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].packages[ 0 ].variant_object;
    
    if ( level.package_airdrop.var_ffe0b093b922a873 && packagesettings.var_531443b319c39ece > 0 && packagesettings.landingdamageradius > 0 )
    {
        falldistance = max( 0, spawnheight - position[ 2 ] );
        var_a124c890e755ac35 = packagesettings.var_1ad11cb130344365 > 0 ? min( 1, falldistance / packagesettings.var_1ad11cb130344365 ) : 1;
        damage = math::lerp( packagesettings.var_46bab34e67a10abc, packagesettings.var_531443b319c39ece, var_a124c890e755ac35 );
        
        if ( damage > 0 )
        {
            nearbyplayers = getplayersinradius( position, packagesettings.landingdamageradius );
            
            foreach ( player in nearbyplayers )
            {
                eattacker = self.eattacker && self.eattacker.team != player.team ? self.eattacker : self;
                player dodamage( int( damage ), position, eattacker, self, "MOD_CRUSH" );
            }
        }
    }
    
    var_6609e08f1f7358 = 0;
    var_836011f20415e3db = 0;
    lastlocation = undefined;
    lastrotation = undefined;
    var_6041304a5fb4fe32 = 0;
    
    while ( true )
    {
        if ( var_6041304a5fb4fe32 )
        {
            var_6041304a5fb4fe32 = 0;
            waitframe();
            continue;
        }
        
        bodyid = self physics_getbodyid( 0 );
        linvel = physics_getbodylinvel( bodyid );
        squaredvelocity = lengthsquared( linvel );
        
        if ( squaredvelocity < 0.0049 )
        {
            var_836011f20415e3db++;
            
            if ( var_836011f20415e3db >= 3 )
            {
                break;
            }
        }
        else
        {
            var_836011f20415e3db = 0;
        }
        
        if ( squaredvelocity > 2500 )
        {
            var_6041304a5fb4fe32 = 1;
        }
        
        if ( level.package_airdrop.var_b6456acf0ffbf6b7 )
        {
            if ( lastlocation && distancesquared( lastlocation, self.origin ) < 0.25 && math::anglebetweenvectorsunit( lastrotation, self.angles ) < 35 )
            {
                var_6609e08f1f7358++;
                
                if ( var_6609e08f1f7358 >= 20 )
                {
                    break;
                }
            }
            else
            {
                lastlocation = self.origin;
                lastrotation = self.angles;
            }
            
            angle = math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( self.angles ) );
            
            if ( angle > 50 && angle < 100 && squaredvelocity < 2500 )
            {
                angvel = physics_getbodyangvel( bodyid );
                localup = anglestoup( self.angles );
                var_6092f7b103b764ef = vectornormalize( vectorcross( localup, ( 0, 0, 1 ) ) );
                rotationspeed = min( 0.75, ( angle - 50 ) / 40 );
                var_bb7869afc2c0de35 = var_6092f7b103b764ef * rotationspeed;
                angvel = angvel * 0.85 + var_bb7869afc2c0de35;
                physics_setbodyangvel( bodyid, angvel[ 0 ], angvel[ 1 ], angvel[ 2 ] );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0x1915f40f, Offset: 0x174f
// Size: 0x140
function private function_d45f301f92a095c4()
{
    self endon( #"death" );
    var_ae7383a9ceb529da = 0;
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        surfacetype = airdrop_scriptbundle::function_aef9ca62004f1c71( flag1 );
        
        if ( airdrop_scriptbundle::function_cb34dc3c8597c121( surfacetype ) )
        {
            continue;
        }
        
        if ( ent.classname != "worldspawn" && !airdrop_scriptbundle::function_f6a906b34d79afe( ent ) )
        {
            if ( var_ae7383a9ceb529da >= 5 )
            {
                /#
                    logstring( "<dev string:x79>" + self.origin + "<dev string:x83>" + 5 + "<dev string:x9e>" );
                #/
                
                self delete();
                return;
            }
            
            var_ae7383a9ceb529da++;
            normal += utility::randomvectorrange( 0.1, 0.3 );
            newvel = normal * 500;
            bodyid = self physics_getbodyid( 0 );
            function_92291c9a8f734d9a( bodyid, newvel[ 0 ], newvel[ 1 ], newvel[ 2 ] );
        }
    }
}

// Namespace namespace_70597ca975b0c1f0
// Params 2, eflags: 0x4
// Checksum 0x4d178a83, Offset: 0x1897
// Size: 0x181
function private function_d66e95106ea59dae( origin, angles )
{
    var_8f5b4f3c4359ea17 = origin;
    var_cfa5a08c2faad899 = angles;
    
    while ( abs( var_cfa5a08c2faad899[ 2 ] ) > 50 )
    {
        if ( var_cfa5a08c2faad899[ 2 ] > 50 )
        {
            var_cfa5a08c2faad899 = ( var_cfa5a08c2faad899[ 0 ], var_cfa5a08c2faad899[ 1 ], var_cfa5a08c2faad899[ 2 ] - 90 );
            up = anglestoup( var_cfa5a08c2faad899 );
            left = anglestoleft( var_cfa5a08c2faad899 );
            var_8f5b4f3c4359ea17 = var_8f5b4f3c4359ea17 + up * -9 + left * -9;
            continue;
        }
        
        if ( var_cfa5a08c2faad899[ 2 ] < -50 )
        {
            var_cfa5a08c2faad899 = ( var_cfa5a08c2faad899[ 0 ], var_cfa5a08c2faad899[ 1 ], var_cfa5a08c2faad899[ 2 ] + 90 );
            up = anglestoup( var_cfa5a08c2faad899 );
            left = anglestoleft( var_cfa5a08c2faad899 );
            var_8f5b4f3c4359ea17 = var_8f5b4f3c4359ea17 + up * -9 + left * 9;
        }
    }
    
    up = anglestoup( var_cfa5a08c2faad899 );
    left = anglestoleft( var_cfa5a08c2faad899 );
    var_7047403caffe1aaf = var_8f5b4f3c4359ea17 + up * 9;
    var_c6b1816748a6d57c = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    tracefront = trace::ray_trace( var_7047403caffe1aaf, var_7047403caffe1aaf + left * 50, undefined, var_c6b1816748a6d57c );
    
    if ( tracefront[ "fraction" ] < 0.99 )
    {
        tracebehind = trace::ray_trace( var_7047403caffe1aaf, var_7047403caffe1aaf + left * -50, undefined, var_c6b1816748a6d57c );
        
        if ( tracefront[ "fraction" ] < tracebehind[ "fraction" ] )
        {
            var_cfa5a08c2faad899 = ( var_cfa5a08c2faad899[ 0 ] * -1, var_cfa5a08c2faad899[ 1 ] + 180, var_cfa5a08c2faad899[ 2 ] * -1 );
        }
    }
    
    return [ var_8f5b4f3c4359ea17, var_cfa5a08c2faad899 ];
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0x9a892e00, Offset: 0x1a21
// Size: 0x23
function private function_755d01edff28a85f()
{
    if ( isdefined( self.var_9b37af822a368683 ) )
    {
        self.var_9b37af822a368683 freescriptable();
    }
    
    self freescriptable();
}

// Namespace namespace_70597ca975b0c1f0
// Params 1, eflags: 0x4
// Checksum 0xbaff212a, Offset: 0x1a4c
// Size: 0x128
function private function_ff0cca529842eb06( params )
{
    if ( !isdefined( self.airdropsettings ) )
    {
        return;
    }
    
    if ( isdefined( self.var_9b37af822a368683 ) )
    {
        self.var_9b37af822a368683 freescriptable();
        self.var_9b37af822a368683 = undefined;
    }
    
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( self.airdropsettings, #"hash_bdb69033b1b13c60", self.airdropsettings );
    
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    poi = poi::poi_findpoioriginisin( self.origin );
    poiname = poi::function_356e66e91a150a02( poi );
    params.player dlog_recordplayerevent( "dlog_event_airdrop_lootcache_used", [ "circle_index", level.br_circle.circleindex ?? -1, "airdrop_name", self.airdropsettings.airdropidentifier, "drone_instance_id", self.var_57eb671c310bb38e ?? -1, "poi_name", poiname ] );
}

// Namespace namespace_70597ca975b0c1f0
// Params 3, eflags: 0x4
// Checksum 0xe64c77f4, Offset: 0x1b7c
// Size: 0x112
function private dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( br_gametypes::isfeaturedisabled( #"hash_bd1f8398e2f123b" ) )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + ( thresholdradius ?? level.var_ea96217a33eb6457 );
    var_cbedc38ce5dedff = function_c44b31a67523b336( level.package_airdrop.var_4dfa54f2d1f0e195, dangercircleorigin, var_1bdc861911b3625e, 1 );
    
    foreach ( cache in var_cbedc38ce5dedff )
    {
        if ( isdefined( level.package_airdrop.var_9da990790d9b4759 ) )
        {
            [[ level.package_airdrop.var_9da990790d9b4759 ]]( cache );
        }
        
        cache function_755d01edff28a85f();
    }
}

// Namespace namespace_70597ca975b0c1f0
// Params 0, eflags: 0x4
// Checksum 0x96081e5, Offset: 0x1c96
// Size: 0x124
function private dangermulticircletick()
{
    if ( br_gametypes::isfeaturedisabled( #"hash_bd1f8398e2f123b" ) )
    {
        return;
    }
    
    if ( br_circle_util::function_7c3401c47d505872() == 1 )
    {
        dangercircleorigin = br_circle::getdangercircleorigin();
        dangercircleradius = br_circle::getdangercircleradius();
        dangercircletick( dangercircleorigin, dangercircleradius, level.var_ea96217a33eb6457 );
        return;
    }
    
    foreach ( cache in level.package_airdrop.var_4dfa54f2d1f0e195 )
    {
        if ( br_circle_util::ispointinmulticircledanger( cache.origin, level.var_ea96217a33eb6457 ) )
        {
            if ( isdefined( level.package_airdrop.var_9da990790d9b4759 ) )
            {
                [[ level.package_airdrop.var_9da990790d9b4759 ]]( cache );
            }
            
            cache function_755d01edff28a85f();
        }
    }
}

/#

    // Namespace namespace_70597ca975b0c1f0
    // Params 0
    // Checksum 0xe6eec7c8, Offset: 0x1dc2
    // Size: 0x158, Type: dev
    function debug_deleteall()
    {
        foreach ( cache in level.package_airdrop.var_4dfa54f2d1f0e195 )
        {
            if ( isdefined( level.package_airdrop.var_9da990790d9b4759 ) )
            {
                [[ level.package_airdrop.var_9da990790d9b4759 ]]( cache );
            }
            
            cache function_755d01edff28a85f();
        }
        
        foreach ( cache in level.package_airdrop.var_c8ea1e210052cfc0 )
        {
            cache delete();
        }
        
        level.package_airdrop.var_4dfa54f2d1f0e195 = [];
        level.package_airdrop.var_c8ea1e210052cfc0 = [];
    }

    // Namespace namespace_70597ca975b0c1f0
    // Params 0
    // Checksum 0xf46fedd, Offset: 0x1f22
    // Size: 0x155, Type: dev
    function debug_drawlocations()
    {
        foreach ( cache in level.package_airdrop.var_c8ea1e210052cfc0 )
        {
            if ( !cache )
            {
                continue;
            }
            
            airdrop_scriptbundle::function_cbfae468752db826( cache.origin, cache.var_45394fecf9989389, ( 1, 0, 0 ) );
        }
        
        foreach ( cache in level.package_airdrop.var_4dfa54f2d1f0e195 )
        {
            if ( !cache )
            {
                continue;
            }
            
            airdrop_scriptbundle::function_cbfae468752db826( cache.origin, cache.var_45394fecf9989389, ( 0, 1, 0 ) );
        }
    }

#/
