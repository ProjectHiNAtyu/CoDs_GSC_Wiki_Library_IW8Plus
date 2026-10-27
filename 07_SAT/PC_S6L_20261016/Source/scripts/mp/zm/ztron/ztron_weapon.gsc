// scripts\mp\zm\ztron\ztron_weapon.gsc  (hash_3d91366b290e8832.gscc) (size: 20352 Bytes / 0x4f80 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf61f8fe6 (4129263590)
// size ...... 20352 (0x4f80)
// includes .. 25  (offset: 0x4ba4)
// strings ... 39  (offset: 0x4c6c)
// dev strs .. 21  (offset: 0x4e68)
// exports ... 49  (offset: 0x3428)
// cseg ...... 0x3df + 0x3049 (0x3428)
// imports ... 129 (offset: 0x3bd0)
// animtree1 . 0   (offset: 0x4f80)
// animtree2 . 0   (offset: 0x4f80)
#using script_4ce55cfc81c444ad;
#using script_54a05cbb2455bc6f;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\ammomods\shadowvortex;
#using scripts\mp\content_manager;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_weapon;

// Namespace ztron_weapon
// Params 0, eflags: 0x5
// Checksum 0x875e8d41, Offset: 0x3fd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_weapon", undefined, undefined, &post_main_init );
}

// Namespace ztron_weapon
// Params 0
// Checksum 0xca1d6a44, Offset: 0x41e
// Size: 0x287
function init()
{
    level.ztron.var_25b826ea708ef4c = [];
    level.var_89b36f1bf8d5018 = 1;
    interaction::init_interaction();
    content_manager::init_content_manager();
    weaponmetadata::init_weaponmetadata();
    pack_a_punch::function_1df7c43f96254346();
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = "sat_la_ztronpable3_mp_secondary";
    utility::registersharedfunc( #"game", #"hash_bfde49be4ac35343", &function_9949d401c4435d40 );
    utility::registersharedfunc( #"weapon", #"hash_2fa5c15c5e96d565", &isprimaryweapon );
    level callback::add( #"player_weapon_change", &onweaponchange );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_weapon_downgraded", "evt_ztron_pickup_weapon_downgraded" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_weapon_upgraded", "evt_ztron_pickup_weapon_upgraded" );
    ztron_sound::function_4ac735395b173fe( "ztron_buzzsaw_impact_zombie", "prj_ztron_xbow_impact" );
    level.ztron.ammomodids = [ "shadowvortex", "deadwire", "cryofreeze", "napalmburst", "brainrot", "fw_ammomod", "lightray" ];
    level.ztron.var_accb0f62bb449cef = [];
    
    foreach ( mod in level.ztron.ammomodids )
    {
        level.ztron.var_accb0f62bb449cef[ getxhash( mod ) ] = mod;
    }
    
    thread init_delayed();
    level.var_2785543070d01fce = "sat_ar_ztrondg2_mp";
    utility::registersharedfunc( #"raygun", #"overrideweaponname", &function_fbe9627d3e8e1609 );
    utility::registersharedfunc( #"jetgun", #"overrideweaponname", &function_bd934b8987851dda );
    utility::registersharedfunc( #"remote_robot", #"overrideweaponname", &function_3bee7876bd01c883 );
    level callback::add( #"item_weapon_picked_up", &onpickupweapon );
    
    /#
        ztron_debug::debugmsg( "<dev string:x24>" );
    #/
}

// Namespace ztron_weapon
// Params 0
// Checksum 0x5c1edc65, Offset: 0x6ad
// Size: 0x14
function init_delayed()
{
    wait 0.25;
    shadowvortex::register_shadowvortex_validation_func( &function_4a4e22fac621b5d1 );
}

// Namespace ztron_weapon
// Params 0
// Checksum 0xd2db329, Offset: 0x6c9
// Size: 0x76
function post_main_init()
{
    assert( "<dev string:x41>" == level.jetgun_weapon_basename, "<dev string:x57>" + "<dev string:x41>" + "<dev string:x69>" + ( level.jetgun_weapon_basename ?? "<dev string:x77>" ) );
    assert( "<dev string:x81>" == level.raygun_weapon_basename, "<dev string:x97>" + "<dev string:x81>" + "<dev string:x69>" + ( level.raygun_weapon_basename ?? "<dev string:x77>" ) );
}

// Namespace ztron_weapon
// Params 0
// Checksum 0xf5e9bdc5, Offset: 0x747
// Size: 0x16, Type: bool
function function_4a4e22fac621b5d1()
{
    return !self.ztron.boss;
}

// Namespace ztron_weapon
// Params 3
// Checksum 0x6589346c, Offset: 0x766
// Size: 0x129
function function_ca69007ed23675ee( bundlename, var_fa938b44e1b390b9, type )
{
    bundlename = getxhashasset( bundlename );
    itembundle = getscriptbundle( bundlename );
    assert( isdefined( itembundle ) );
    
    if ( !isdefined( itembundle ) )
    {
        logstring( "Can't find item bundle for weapon: " + bundlename );
        return;
    }
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = itembundle.baseweapon;
    var_1e1a895196cdfff7 = spawnstruct();
    var_1e1a895196cdfff7.name = itembundle.baseweapon;
    var_1e1a895196cdfff7.type = type;
    var_1e1a895196cdfff7.bundle = getxhashasset( bundlename );
    var_1e1a895196cdfff7.var_fa938b44e1b390b9 = var_fa938b44e1b390b9;
    var_1e1a895196cdfff7.specialcb = function_e022980655535f59( itembundle.baseweapon );
    level.ztron.var_25b826ea708ef4c[ level.ztron.var_25b826ea708ef4c.size ] = var_1e1a895196cdfff7;
}

// Namespace ztron_weapon
// Params 0
// Checksum 0x6b0c88f7, Offset: 0x897
// Size: 0xb0
function function_f331fb6858460752()
{
    foreach ( var_1e1a895196cdfff7 in level.ztron.var_25b826ea708ef4c )
    {
        level thread function_c41462a58bb7295e( var_1e1a895196cdfff7 );
    }
    
    level.ztron.var_8f5f5238c371f217 = 1;
    level notify( #"build_weapon_completed" );
    level thread function_a41d743ddbd4066a();
}

// Namespace ztron_weapon
// Params 0
// Checksum 0x95a91352, Offset: 0x94f
// Size: 0x161
function preloadweapons()
{
    self endon( #"disconnect" );
    waitframe();
    
    if ( self.weaponloaded )
    {
        return;
    }
    
    while ( !level.ztron.var_8f5f5238c371f217 )
    {
        level waittill( #"build_weapon_completed" );
    }
    
    weapons = [];
    
    foreach ( var_1e1a895196cdfff7 in level.ztron.var_25b826ea708ef4c )
    {
        weapons[ weapons.size ] = var_1e1a895196cdfff7.weaponobj[ 0 ];
        baseweapon = var_1e1a895196cdfff7.weaponobj[ 0 ];
        thread function_756c3040fe876be4( baseweapon );
        
        if ( !isdefined( var_1e1a895196cdfff7.weaponmaphandle ) && !( getdvarint( @"hash_cb23258f981d9e3b", 1 ) == 1 ) )
        {
            var_1e1a895196cdfff7.weaponmaphandle = function_646cc662db6a3fe0( item_weapon::function_f75620a38a24072() ?? %"hash_6adcd450cbc57896", baseweapon );
        }
    }
    
    self loadweaponsforplayer( weapons );
    self.weaponloaded = 1;
    level thread function_a41d743ddbd4066a();
}

// Namespace ztron_weapon
// Params 0, eflags: 0xc
// Checksum 0xc1662e6e, Offset: 0xab8
// Size: 0xe7
function private function_a41d743ddbd4066a()
{
    self notify( #"hash_246ab97eb4baac01" );
    self endon( #"hash_246ab97eb4baac01" );
    level endon( #"ztron_game_is_over" );
    
    while ( ztron_main::function_4da200e9b8d58a3c() == 0 )
    {
        level waittill( #"worldstatechange" );
    }
    
    wait 10;
    
    foreach ( var_1e1a895196cdfff7 in level.ztron.var_25b826ea708ef4c )
    {
        if ( var_1e1a895196cdfff7.weaponmaphandle )
        {
            function_a76fdf4e079af7be( var_1e1a895196cdfff7.weaponmaphandle );
            var_1e1a895196cdfff7.weaponmaphandle = undefined;
        }
    }
}

// Namespace ztron_weapon
// Params 1, eflags: 0x4
// Checksum 0x1303cb8, Offset: 0xba7
// Size: 0x54
function private function_756c3040fe876be4( baseweapon )
{
    if ( !isdefined( baseweapon ) )
    {
        return;
    }
    
    weaponstreaming = function_2535619d314c1099( baseweapon, self.origin - ( 0, 0, 20 ), ( 0, 0, 0 ) );
    wait 5;
    weaponstreaming delete();
}

// Namespace ztron_weapon
// Params 1, eflags: 0x4
// Checksum 0xf29a60c0, Offset: 0xc03
// Size: 0x489
function private function_c41462a58bb7295e( var_1e1a895196cdfff7 )
{
    itembundle = getscriptbundle( var_1e1a895196cdfff7.bundle );
    baseweapon = item_weapon::function_477bf1207c6672a5( itembundle );
    
    if ( !( getdvarint( @"hash_cb23258f981d9e3b", 1 ) == 1 ) )
    {
        var_1e1a895196cdfff7.weaponmaphandle = function_646cc662db6a3fe0( item_weapon::function_f75620a38a24072() ?? %"hash_6adcd450cbc57896", baseweapon );
    }
    
    var_1e1a895196cdfff7.weaponobj = [];
    var_1e1a895196cdfff7.weaponobj[ 0 ] = baseweapon;
    var_9095f64ff8fe268e = level.ztron.itemdef.itemdata[ var_1e1a895196cdfff7.var_fa938b44e1b390b9 ].var_7a5c358d74ae224d;
    
    if ( isdefined( var_9095f64ff8fe268e ) )
    {
        var_1e1a895196cdfff7.chickenweapon = [];
        var_2857c9a4c6fd8258 = getscriptbundle( var_9095f64ff8fe268e );
        var_1e1a895196cdfff7.chickenweapon[ 0 ] = item_weapon::function_477bf1207c6672a5( var_2857c9a4c6fd8258 );
        
        if ( isdefined( var_2857c9a4c6fd8258.baseweapon ) )
        {
            level.var_44cdf5fee6853ac5 = arraycombineunique( level.var_44cdf5fee6853ac5, [ var_2857c9a4c6fd8258.baseweapon ] );
        }
    }
    
    var_57ae375a79e3d53c = level.ztron.itemdef.itemdata[ var_1e1a895196cdfff7.var_fa938b44e1b390b9 ].var_6c5d871a291da1ff;
    
    if ( isdefined( var_57ae375a79e3d53c ) )
    {
        var_134b6995fcb3353f = getscriptbundle( var_57ae375a79e3d53c );
        var_1e1a895196cdfff7.var_860deaeca058d557 = [];
        var_1e1a895196cdfff7.var_860deaeca058d557[ 0 ] = item_weapon::function_477bf1207c6672a5( var_134b6995fcb3353f );
        
        if ( isdefined( var_134b6995fcb3353f.baseweapon ) )
        {
            level.var_44cdf5fee6853ac5 = arraycombineunique( level.var_44cdf5fee6853ac5, [ var_134b6995fcb3353f.baseweapon ] );
        }
    }
    
    var_1e1a895196cdfff7.var_68dc3f96a6b65d1c = [];
    var_e8da1131e18ca4c7 = level.ztron.itemdef.itemdata[ var_1e1a895196cdfff7.var_fa938b44e1b390b9 ].var_37123176479d416c;
    var_37123176479d416c = getscriptbundle( var_e8da1131e18ca4c7 );
    var_1e1a895196cdfff7.deletetimer = 5;
    var_1e1a895196cdfff7.var_b154c382310b3535 = level.ztron.itemdef.itemdata[ var_1e1a895196cdfff7.var_fa938b44e1b390b9 ].chickenstack;
    var_1e1a895196cdfff7.var_68dc3f96a6b65d1c[ 0 ] = item_weapon::function_477bf1207c6672a5( var_37123176479d416c );
    var_1e1a895196cdfff7.var_c2e4b5f9b21824c4 = [];
    var_9e8f0509386428f = level.ztron.itemdef.itemdata[ var_1e1a895196cdfff7.var_fa938b44e1b390b9 ].var_8cd3d7b7778135d4;
    var_8cd3d7b7778135d4 = getscriptbundle( var_9e8f0509386428f );
    var_1e1a895196cdfff7.var_c2e4b5f9b21824c4[ 0 ] = item_weapon::function_477bf1207c6672a5( var_8cd3d7b7778135d4 );
    level utility::waittill_any_timeout( 1, "init_pap_postMain_end" );
    var_1e1a895196cdfff7.weaponobj[ 1 ] = pack_a_punch::function_e190a315803e2870( baseweapon, 1 );
    var_1e1a895196cdfff7.weaponobj[ 2 ] = pack_a_punch::function_e190a315803e2870( baseweapon, 2 );
    var_1e1a895196cdfff7.var_68dc3f96a6b65d1c[ 1 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.var_68dc3f96a6b65d1c[ 0 ], 1 );
    var_1e1a895196cdfff7.var_68dc3f96a6b65d1c[ 2 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.var_68dc3f96a6b65d1c[ 0 ], 2 );
    var_1e1a895196cdfff7.var_c2e4b5f9b21824c4[ 1 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.var_c2e4b5f9b21824c4[ 0 ], 1 );
    var_1e1a895196cdfff7.var_c2e4b5f9b21824c4[ 2 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.var_c2e4b5f9b21824c4[ 0 ], 2 );
    
    if ( isdefined( var_9095f64ff8fe268e ) )
    {
        var_1e1a895196cdfff7.chickenweapon[ 1 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.chickenweapon[ 0 ], 1 );
        var_1e1a895196cdfff7.chickenweapon[ 2 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.chickenweapon[ 0 ], 2 );
        
        if ( isdefined( var_1e1a895196cdfff7.var_860deaeca058d557 ) )
        {
            var_1e1a895196cdfff7.var_860deaeca058d557[ 1 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.var_860deaeca058d557[ 0 ], 1 );
            var_1e1a895196cdfff7.var_860deaeca058d557[ 2 ] = pack_a_punch::function_e190a315803e2870( var_1e1a895196cdfff7.var_860deaeca058d557[ 0 ], 2 );
        }
    }
}

// Namespace ztron_weapon
// Params 0
// Checksum 0xac62deb5, Offset: 0x1094
// Size: 0x101
function function_843cf77e99e3281()
{
    waitframe();
    bundlename = %"hash_53bb329498630087";
    var_1e1a895196cdfff7 = function_bb0a58ae27b195fe( bundlename );
    crossbowweap = item_weapon::function_477bf1207c6672a5( getscriptbundle( bundlename ) );
    var_378588de85ca72dc = pack_a_punch::function_e190a315803e2870( crossbowweap, 1 );
    var_37858bde85ca7975 = pack_a_punch::function_e190a315803e2870( crossbowweap, 2 );
    weaponbasename = getcompleteweaponname( crossbowweap );
    var_465d9fae5df18f18 = getcompleteweaponname( var_378588de85ca72dc );
    var_3be20fb2f839f1e5 = getcompleteweaponname( var_37858bde85ca7975 );
    level.ztron.specialimpact = [];
    level.ztron.specialimpact[ weaponbasename ] = &impactbuzzsaw;
    level.ztron.specialimpact[ var_465d9fae5df18f18 ] = &function_abf93bf0e39e745d;
    level.ztron.specialimpact[ var_3be20fb2f839f1e5 ] = &function_abf938f0e39e6dc4;
}

// Namespace ztron_weapon
// Params 3
// Checksum 0xf7e6b5e9, Offset: 0x119d
// Size: 0x3ce
function giveweaponpack( bundlename, weaponpickup = 0, userdropped = 0 )
{
    profilestart();
    
    if ( !isdefined( self.ztron ) )
    {
        profilestop();
        return;
    }
    
    if ( !isplayer( self ) )
    {
        profilestop();
        return;
    }
    
    itembundle = getscriptbundle( bundlename );
    assert( isdefined( itembundle ) );
    
    if ( !isdefined( itembundle ) )
    {
        logstring( "Can't find item bundle for weapon" );
        profilestop();
        return;
    }
    
    if ( function_95cbb01f7d863f27( self.ztron.var_c5c31e76e1c42198 ) && self.ztron.var_c5c31e76e1c42198 != bundlename )
    {
        self.ztron.weaponLevel = 0;
        self.ztron.weaponincrement = 0;
    }
    
    var_f27fc49acc494905 = !userdropped && gettime() < self.ztron.var_44f53f7bae20636e || function_95cbb01f7d863f27( bundlename );
    
    if ( weaponpickup )
    {
        if ( self.ztron.upgradeMask & 2048 )
        {
            var_f27fc49acc494905 = 1;
        }
        
        fill = 1;
        
        if ( self.ztron.var_c5c31e76e1c42198 == bundlename )
        {
            if ( var_f27fc49acc494905 )
            {
                deltalevel = 2 - self.ztron.weaponLevel;
                var_7d687d9cbfea4ea1 = deltalevel * 1024 / 64;
                incrementweapon( var_7d687d9cbfea4ea1 );
            }
            else if ( bundlename === self.ztron.default_weapon_bundle && self.ztron.weaponincrement == 0 )
            {
                incrementweapon( 15 );
            }
            
            incrementweapon( 16 );
            profilestop();
            return;
        }
    }
    
    if ( self.ztron.var_c5c31e76e1c42198 != bundlename )
    {
        self.ztron.var_dcf9ab22b803b383 = 0;
        self.ztron.var_1eabae5a8538db69 = 0;
        
        if ( self.ztron.weaponLevel == 0 )
        {
            if ( fill && bundlename === self.ztron.default_weapon_bundle || ztron_fate::hasfate( 1 ) )
            {
                self.ztron.weaponLevel = 1;
            }
        }
        else
        {
            fill = 0;
        }
    }
    
    if ( var_f27fc49acc494905 )
    {
        self.ztron.weaponLevel = 2;
        fill = 1;
    }
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) && isdefined( level.ztron.var_45536c77fdfa4ea7 ) )
    {
        self.ztron.weaponLevel = level.ztron.var_45536c77fdfa4ea7;
    }
    
    giveweaponto( bundlename );
    
    if ( fill )
    {
        self.ztron.weaponincrement = 1023;
    }
    
    self notify( #"new_weapon_pack" );
    
    if ( isdefined( self.ztron.var_1e1a895196cdfff7.specialcb ) )
    {
        self thread [[ self.ztron.var_1e1a895196cdfff7.specialcb ]]();
    }
    
    function_8a5e2cb6e8196529();
    
    /#
        ztron_debug::debugmsg( "<dev string:xa9>" + self.name + "<dev string:xb1>" + self.ztron.var_1e1a895196cdfff7.name + "<dev string:xc5>" + ( fill ? "<dev string:xcc>" : "<dev string:xd1>" ) );
    #/
    
    profilestop();
}

// Namespace ztron_weapon
// Params 0
// Checksum 0x3b6cf2e2, Offset: 0x1573
// Size: 0x53
function function_596b8bb19981e412()
{
    self.ztron.var_c5c31e76e1c42198 = self.ztron.default_weapon_bundle;
    self.ztron.weaponincrement = 0;
    self.ztron.weaponLevel = 0;
}

// Namespace ztron_weapon
// Params 3
// Checksum 0x6a89a1fc, Offset: 0x15ce
// Size: 0x19a
function takeweaponpack( defaultrestore = 1, userdropped = 0, forcereset = 0 )
{
    if ( defaultrestore )
    {
        if ( !function_6ec1575493ad0ab8() )
        {
            return;
        }
        
        if ( forcereset || self.ztron.var_c5c31e76e1c42198 != self.ztron.default_weapon_bundle || self.ztron.weaponLevel > 0 || self.ztron.weaponincrement > 0 )
        {
            function_596b8bb19981e412();
            giveweaponpack( self.ztron.default_weapon_bundle, undefined, userdropped );
        }
    }
    else
    {
        if ( isdefined( self.ztron.oldweapon ) )
        {
            self takeweapon( self.ztron.oldweapon );
        }
        
        if ( isdefined( self.ztron.currentweapon ) )
        {
            self takeweapon( self.ztron.currentweapon );
        }
        
        self.ztron.oldweapon = undefined;
        self.ztron.currentweapon = undefined;
        self.ztron.var_c5c31e76e1c42198 = undefined;
        self.ztron.weaponincrement = 0;
        self.ztron.weaponLevel = 0;
    }
    
    function_8a5e2cb6e8196529();
}

// Namespace ztron_weapon
// Params 0
// Checksum 0xe2f0b78a, Offset: 0x1770
// Size: 0x110
function function_85196995466c1a41()
{
    if ( isdefined( self.ztron.currentweapon ) && self hasweapon( self.ztron.currentweapon ) )
    {
        self switchtoweaponimmediate( self.ztron.currentweapon );
        return;
    }
    
    fallbackweapon = self.ztron.default_weapon_bundle && self.ztron.default_weapon_bundle != "" ? self.ztron.default_weapon_bundle : %"hash_38aaa6806435d580";
    weaponbundle = self.ztron.var_c5c31e76e1c42198 && self.ztron.var_c5c31e76e1c42198 != "" ? self.ztron.var_c5c31e76e1c42198 : fallbackweapon;
    giveweaponpack( weaponbundle, 0, 1 );
}

// Namespace ztron_weapon
// Params 1
// Checksum 0x47785d6e, Offset: 0x1888
// Size: 0x2bf
function incrementweapon( amount = 1 )
{
    if ( !isdefined( self.ztron.var_1e1a895196cdfff7 ) )
    {
        return;
    }
    
    if ( self.ztron.var_2c44544a01cc415e )
    {
        return;
    }
    
    self.ztron.weaponincrement += int( 64 * amount );
    
    if ( self.ztron.weaponincrement >= 1024 )
    {
        if ( self.ztron.weaponLevel < 2 )
        {
            var_5b2828a8d4d301ab = self.ztron.weaponLevel;
            self.ztron.weaponLevel += int( self.ztron.weaponincrement / 1024 );
            
            if ( self.ztron.weaponLevel > 2 )
            {
                self.ztron.weaponLevel = 2;
            }
            
            if ( self.ztron.weaponLevel == 2 )
            {
                ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_item_weapon_group" ) );
            }
            
            self.ztron.weaponincrement -= ( self.ztron.weaponLevel - var_5b2828a8d4d301ab ) * 1024;
            time = gettime() + 2000;
            
            if ( self.ztron.var_dcf9ab22b803b383 < time )
            {
                self.ztron.var_dcf9ab22b803b383 = time;
            }
            
            giveweaponto( self.ztron.var_1e1a895196cdfff7.bundle );
            ztron_sound::ztron_playsound( "ztron_pickup_weapon_upgraded", undefined, self );
            
            /#
                ztron_debug::debugmsg( "<dev string:xa9>" + self.name + "<dev string:xd7>" + self.ztron.weaponLevel + "<dev string:xf2>" + self.ztron.var_1e1a895196cdfff7.name );
            #/
        }
        else
        {
            self.ztron.weaponincrement = 1023;
        }
    }
    
    self.ztron.weaponincrement = clamp( self.ztron.weaponincrement, 0, 1023 );
    function_8a5e2cb6e8196529();
}

// Namespace ztron_weapon
// Params 0
// Checksum 0xe69dd6a3, Offset: 0x1b4f
// Size: 0x442
function function_bdc5e458b6cbf2bb()
{
    if ( !isdefined( self.ztron ) || !isdefined( self.ztron.var_c5c31e76e1c42198 ) )
    {
        return;
    }
    
    if ( function_6ec1575493ad0ab8() && self.ztron.var_e0d6f35f226f8a7e )
    {
        giveweaponto( self.ztron.var_c5c31e76e1c42198 );
        return;
    }
    
    if ( !isdefined( self.ztron.currentweapon ) )
    {
        return;
    }
    
    if ( isnullweapon( self getcurrentweapon() ) && self hasweapon( self.ztron.currentweapon ) && function_6ec1575493ad0ab8() )
    {
        self switchtoweaponimmediate( self.ztron.currentweapon );
    }
    
    time = gettime();
    
    if ( time < self.ztron.var_dcf9ab22b803b383 || time < self.ztron.var_f41b955260ed467e || !ztron_item::function_4b0636e7b2fc461f() || isdefined( self.ztron.vehicle ) || function_95cbb01f7d863f27( self.ztron.var_c5c31e76e1c42198 ) || ztron_player_utility::function_32883fa42c326520() )
    {
        return;
    }
    
    if ( self.ztron.weaponincrement > 0 )
    {
        decay = 0.8 + self.ztron.weaponLevel * 0.4;
        
        if ( self isshooting() )
        {
            var_ab917cce8153980e = self.ztron.var_ab917cce8153980e;
            
            if ( var_ab917cce8153980e == 0 && self.ztron.upgradeMask & 1073741824 )
            {
                var_ab917cce8153980e += 1;
            }
            
            decrement = clamp( 1.5 - var_ab917cce8153980e, 0, 1.5 );
            decay += decrement;
        }
        
        if ( self.ztron.upgradeMask & 2048 )
        {
            decay *= 3;
        }
        
        if ( level.ztron.var_371903e5801e0e08 )
        {
            decay *= 0.7;
        }
        
        self.ztron.weaponincrement -= decay;
        
        if ( self.ztron.weaponincrement < 0 )
        {
            self.ztron.weaponincrement = 0;
        }
        
        function_8a5e2cb6e8196529();
    }
    else if ( self.ztron.weaponLevel > 0 )
    {
        self.ztron.weaponLevel--;
        self.ztron.weaponincrement = 1023;
        
        if ( self.ztron.var_c5c31e76e1c42198 === self.ztron.default_weapon_bundle && self.ztron.weaponLevel == 0 )
        {
            self.ztron.weaponincrement = 0;
        }
        
        function_8a5e2cb6e8196529();
        giveweaponto( self.ztron.var_c5c31e76e1c42198 );
        ztron_sound::ztron_playsound( "ztron_pickup_weapon_downgraded", undefined, self );
        
        /#
            ztron_debug::debugmsg( "<dev string:xa9>" + self.name + "<dev string:xf9>" + self.ztron.weaponLevel + "<dev string:xf2>" + self.ztron.var_1e1a895196cdfff7.name );
        #/
    }
    
    if ( self.ztron.var_c5c31e76e1c42198 != self.ztron.default_weapon_bundle )
    {
        if ( self.ztron.weaponincrement == 0 && self.ztron.weaponLevel == 0 )
        {
            giveweaponpack( self.ztron.default_weapon_bundle );
        }
    }
}

// Namespace ztron_weapon
// Params 2
// Checksum 0x12d0a5fc, Offset: 0x1f99
// Size: 0x96
function function_951f0c703dffc47( bparticle = 1, duration = 15 )
{
    time = gettime();
    oldtimeout = self.ztron.var_dcf9ab22b803b383;
    pickuptime = ztron_player_utility::function_10777122eee28fa8( duration );
    self.ztron.var_dcf9ab22b803b383 = time + pickuptime * 1000;
    
    if ( oldtimeout < time && bparticle )
    {
        thread function_7315ec9b98f19d60();
    }
}

// Namespace ztron_weapon
// Params 0
// Checksum 0x2d85505e, Offset: 0x2037
// Size: 0x5d
function function_601fc4d0362f327b()
{
    if ( self.ztron.var_c5c31e76e1c42198 === self.ztron.default_weapon_bundle && self.ztron.weaponincrement == 0 )
    {
        incrementweapon( 15 );
    }
    
    incrementweapon( 16 );
}

// Namespace ztron_weapon
// Params 0, eflags: 0xc
// Checksum 0x5df18d73, Offset: 0x209c
// Size: 0xfe
function private function_7315ec9b98f19d60()
{
    self notify( #"hash_e1fa16ed552a0782" );
    self endon( #"hash_e1fa16ed552a0782" );
    self endon( #"disconnect" );
    ammofx = utility::getfx( "ztron_player_ammo_unlimited" );
    stopfxontag( ammofx, self, "tag_origin" );
    waitframe();
    playfxontag( ammofx, self, "tag_origin" );
    keepgoing = 1;
    
    while ( keepgoing )
    {
        time = gettime();
        keepgoing = self.ztron.var_dcf9ab22b803b383 > time;
        
        if ( self.ztron.var_f41b955260ed467e > time )
        {
            keepgoing = 1;
        }
        
        result = utility::waittill_any_timeout( 0.25, "new_weapon_pack", "death" );
        
        if ( result == "timeout" )
        {
            continue;
        }
    }
    
    self.ztron.var_dcf9ab22b803b383 = 0;
    stopfxontag( ammofx, self, "tag_origin" );
}

// Namespace ztron_weapon
// Params 1, eflags: 0x4
// Checksum 0x2e3bf5eb, Offset: 0x21a2
// Size: 0x36, Type: bool
function private function_95cbb01f7d863f27( bundlename )
{
    if ( self.ztron.var_5ef717c9a93891c3 && bundlename == %"hash_7b269d83e9f2bfac" )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_weapon
// Params 1, eflags: 0x4
// Checksum 0xe74e1c67, Offset: 0x21e1
// Size: 0x56
function private onweaponchange( params )
{
    val::set( "topdowncamera", "ads", !ztron_camera::function_4963ef31446ec8d9( self.ztron.var_a46fa357ac82e4a ) && !level.ztron.disableads );
    ztron_player_utility::updateplayerspeed();
}

// Namespace ztron_weapon
// Params 2, eflags: 0x4
// Checksum 0x3eba7ef7, Offset: 0x223f
// Size: 0x17, Type: bool
function private function_9949d401c4435d40( weapon, player )
{
    return true;
}

// Namespace ztron_weapon
// Params 1
// Checksum 0xf69d6540, Offset: 0x225f
// Size: 0xed
function isprimaryweapon( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        assertmsg( "<dev string:x116>" );
        return 0;
    }
    
    if ( objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode" )
    {
        return 0;
    }
    
    switch ( objweapon.classname )
    {
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_61e969dacaaf9881":
        case #"hash_719417cb1de832b6":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            return 1;
        case #"hash_e224d0b635d0dadd":
            if ( objweapon.basename == "sat_la_ztronwarmachine_mp" )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            return 0;
    }
}

// Namespace ztron_weapon
// Params 4, eflags: 0x4
// Checksum 0x15303b7c, Offset: 0x2354
// Size: 0x32
function private use_weapon_case( itembundle, item, autouse, var_981c264073bf1154 )
{
    return item.count;
}

// Namespace ztron_weapon
// Params 1, eflags: 0x4
// Checksum 0x15a658d5, Offset: 0x238f
// Size: 0x1d4
function private giveweaponto( bundlename )
{
    itembundle = getscriptbundle( bundlename );
    assert( isdefined( itembundle ) );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self notify( #"new_weapon_given" );
    weaponLevel = int( clamp( self.ztron.weaponLevel, 0, 2 ) );
    self.ztron.var_1e1a895196cdfff7 = function_bb0a58ae27b195fe( bundlename );
    self.ztron.var_c5c31e76e1c42198 = bundlename;
    self.ztron.weapontype = self.ztron.var_1e1a895196cdfff7.type;
    self.ztron.var_e0d6f35f226f8a7e = 0;
    baseweapon = self.ztron.var_1e1a895196cdfff7.weaponobj[ 0 ];
    scriptable_name = itembundle.scriptable;
    fakeitem = common_item::function_77600f92048df72d( itembundle, common_item::function_ea3b3088d82fd357( itembundle ), baseweapon );
    fakeitem.type = scriptable_name;
    fakeitem.var_951c89546ec50477 = self.ztron.weaponLevel;
    fakeitem.fromcache = 0;
    fakeitem.fromground = 1;
    
    if ( !function_6ec1575493ad0ab8() )
    {
        self.ztron.var_e0d6f35f226f8a7e = 1;
        return;
    }
    
    obtainresult = common_item::function_96119bed8ab4c5d9( fakeitem, 0, 1 );
    
    if ( !obtainresult )
    {
        self.ztron.var_e0d6f35f226f8a7e = 1;
        return;
    }
}

// Namespace ztron_weapon
// Params 1
// Checksum 0x438af75d, Offset: 0x256b
// Size: 0x262
function onpickupweapon( params )
{
    self.ztron.oldweapon = self.ztron.currentweapon;
    weaponLevel = int( clamp( self.ztron.weaponLevel, 0, 2 ) );
    self.ztron.currentweapon = params.newweaponobj ?? self.ztron.var_1e1a895196cdfff7.weaponobj[ weaponLevel ];
    self setweaponammoclip( self.ztron.currentweapon, weaponclipsize( self.ztron.currentweapon ) );
    self setweaponammostock( self.ztron.currentweapon, weaponmaxammo( self.ztron.currentweapon ) );
    
    if ( self.ztron.var_c5c31e76e1c42198 == self.ztron.default_weapon_bundle )
    {
        if ( isdefined( level.ztron.temp_ammo_mod[ self.name ] ) )
        {
            ammo_mod::add_ammo_mod_to_weapon( self.ztron.var_1e1a895196cdfff7.weaponobj[ self.ztron.weaponLevel ], level.ztron.temp_ammo_mod[ self.name ] );
        }
        
        if ( isdefined( self.ztron.default_ammo_mod ) )
        {
            ammo_mod::add_ammo_mod_to_weapon( self.ztron.var_1e1a895196cdfff7.weaponobj[ self.ztron.weaponLevel ], self.ztron.default_ammo_mod );
        }
    }
    
    if ( self.ztron.oldweapon && self.ztron.oldweapon != self.ztron.currentweapon )
    {
        self takeweapon( self.ztron.oldweapon );
    }
    
    thread function_bfa57b2ff258027f();
}

// Namespace ztron_weapon
// Params 0, eflags: 0xc
// Checksum 0xcb87ff5a, Offset: 0x27d5
// Size: 0x75
function private function_bfa57b2ff258027f()
{
    self notify( #"hash_202b6dd5b85db92a" );
    self endon( #"hash_202b6dd5b85db92a" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    while ( self.ztron.var_c5c31e76e1c42198 && self getcurrentweapon() != self.ztron.currentweapon )
    {
        waitframe();
    }
    
    self notify( #"ztron_weapon_change_finish" );
}

// Namespace ztron_weapon
// Params 3
// Checksum 0x98124ee3, Offset: 0x2852
// Size: 0x8a
function function_98db33bf77a21352( player, seconds, type )
{
    self notify( #"hash_79653c1432ce98cd" );
    self endon( #"hash_79653c1432ce98cd" );
    level endon( #"ztron_game_is_over" );
    name = player.name;
    level.ztron.temp_ammo_mod[ name ] = type;
    wait seconds;
    level.ztron.temp_ammo_mod[ name ] = undefined;
}

// Namespace ztron_weapon
// Params 2
// Checksum 0x11a7581c, Offset: 0x28e4
// Size: 0xb6
function giveammomod( type, duration = 0 )
{
    assert( arraycontains( level.ztron.ammomodids, type ), "<dev string:x155>" );
    
    if ( duration == 0 )
    {
        self.ztron.default_ammo_mod = type;
    }
    else
    {
        level thread function_98db33bf77a21352( self, duration, type );
    }
    
    if ( self.ztron.var_c5c31e76e1c42198 === self.ztron.default_weapon_bundle )
    {
        giveweaponpack( self.ztron.default_weapon_bundle );
    }
}

// Namespace ztron_weapon
// Params 1
// Checksum 0xe5124334, Offset: 0x29a2
// Size: 0xba
function function_8ad73e6461c844a8( hash )
{
    if ( isdefined( hash ) )
    {
        keys = getarraykeys( level.ztron.var_accb0f62bb449cef );
        
        foreach ( key in keys )
        {
            if ( key == hash )
            {
                return level.ztron.var_accb0f62bb449cef[ key ];
            }
        }
    }
}

// Namespace ztron_weapon
// Params 1
// Checksum 0x29ae143, Offset: 0x2a65
// Size: 0xbd
function function_bb0a58ae27b195fe( bundlename )
{
    hash = undefined;
    
    if ( isxhash( bundlename ) )
    {
        hash = bundlename;
    }
    else
    {
        hash = getxhashasset( bundlename );
    }
    
    foreach ( wp in level.ztron.var_25b826ea708ef4c )
    {
        if ( wp.bundle == hash )
        {
            return wp;
        }
    }
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0x56718bee, Offset: 0x2b2b
// Size: 0x91
function private function_cea3279a0daaf656()
{
    self endon( #"disconnect" );
    self endon( #"new_weapon_pack" );
    
    while ( true )
    {
        self waittill( #"missile_fire", var_8f2f51cf1451a6e5, objweapon );
        var_7008bdcb140ad387 = isdefined( objweapon ) && objweapon.basenamehash === %"sat_la_ztronpable3_mp";
        
        if ( var_7008bdcb140ad387 && self.ztron.weaponLevel == 2 )
        {
            thread function_ef4a6ed373ab05();
        }
    }
}

// Namespace ztron_weapon
// Params 1, eflags: 0x4
// Checksum 0xb95516b9, Offset: 0x2bc4
// Size: 0x1d
function private function_e022980655535f59( weaponname )
{
    if ( weaponname == "sat_la_ztronpable3_mp" )
    {
        return &function_cea3279a0daaf656;
    }
}

// Namespace ztron_weapon
// Params 2
// Checksum 0x7ea43d65, Offset: 0x2bea
// Size: 0x57
function weapon_dismember_legs( ai, eattacker )
{
    if ( !isdefined( ai ) )
    {
        return;
    }
    
    if ( ai.ztron.boss )
    {
        return;
    }
    
    ai namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
    ai thread ztron_util::function_ea0a0be5c5468c48( randomfloatrange( 5, 12 ), eattacker, "MOD_UNKNOWN" );
}

// Namespace ztron_weapon
// Params 6, eflags: 0x4
// Checksum 0x80db756c, Offset: 0x2c49
// Size: 0x62, Type: bool
function private function_ab1d106a4e2bcbb0( ai, idamage, eattacker, vdir, smeansofdeath, weaponobj )
{
    if ( !isai( ai ) || ai.nogib || smeansofdeath != "MOD_IMPACT" )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_weapon
// Params 2
// Checksum 0xbd4e0e63, Offset: 0x2cb4
// Size: 0x63
function function_eefebf1b1fc7b2ce( ai, idamage )
{
    var_98343e88448e69a3 = utility::cointoss();
    
    if ( var_98343e88448e69a3 )
    {
        ai namespace_b76ff2659823e89d::dismember_left_arm();
        return;
    }
    
    if ( ai.health - idamage <= 0 && ai.allowdeath )
    {
        ai namespace_b76ff2659823e89d::dismember_right_arm();
    }
}

// Namespace ztron_weapon
// Params 7, eflags: 0x4
// Checksum 0x98209ba4, Offset: 0x2d1f
// Size: 0xb3
function private impactbuzzsaw( ai, idamage, eattacker, vdir, vpoint, smeansofdeath, weaponobj )
{
    if ( !function_ab1d106a4e2bcbb0( ai, idamage, eattacker, vdir, smeansofdeath, weaponobj ) )
    {
        return;
    }
    
    ztron_sound::ztron_playsound( "ztron_buzzsaw_impact_zombie", undefined, ai );
    
    if ( !ai.ztron.boss )
    {
        ai zombie_knockdown::function_6fc167d4a3590991( vpoint, 200, 30 );
    }
    
    if ( randomint( 100 ) < 30 )
    {
        weapon_dismember_legs( ai, eattacker );
        ai thread ztron_util::function_ea0a0be5c5468c48( randomint( 15 ) + 1 );
    }
}

// Namespace ztron_weapon
// Params 7, eflags: 0x4
// Checksum 0x7b09a676, Offset: 0x2dda
// Size: 0xbe
function private function_abf93bf0e39e745d( ai, idamage, eattacker, vdir, vpoint, smeansofdeath, weaponobj )
{
    if ( !function_ab1d106a4e2bcbb0( ai, idamage, eattacker, vdir, smeansofdeath, weaponobj ) )
    {
        return;
    }
    
    ztron_sound::ztron_playsound( "ztron_buzzsaw_impact_zombie", undefined, ai );
    
    if ( !ai.ztron.boss )
    {
        ai zombie_knockdown::function_6fc167d4a3590991( vpoint, 300, 35 );
    }
    
    if ( randomint( 100 ) < 50 )
    {
        function_eefebf1b1fc7b2ce( ai, idamage );
        weapon_dismember_legs( ai, eattacker );
        ai thread ztron_util::function_ea0a0be5c5468c48( randomint( 8 ) + 1 );
    }
}

// Namespace ztron_weapon
// Params 7, eflags: 0x4
// Checksum 0xd2a07b2, Offset: 0x2ea0
// Size: 0x10d
function private function_abf938f0e39e6dc4( ai, idamage, eattacker, vdir, vpoint, smeansofdeath, weaponobj )
{
    if ( !function_ab1d106a4e2bcbb0( ai, idamage, eattacker, vdir, smeansofdeath, weaponobj ) )
    {
        return;
    }
    
    ztron_sound::ztron_playsound( "ztron_buzzsaw_impact_zombie", undefined, ai );
    
    if ( randomint( 100 ) < 85 && !ai.ztron.boss && !ai.ztron.elite )
    {
        ai namespace_b76ff2659823e89d::annihilate();
        return ( ai.health + 187 );
    }
    
    if ( !ai.ztron.boss )
    {
        ai zombie_knockdown::function_6fc167d4a3590991( vpoint, 500, 40 );
        function_eefebf1b1fc7b2ce( ai, idamage );
        weapon_dismember_legs( ai, eattacker );
        ai thread ztron_util::function_ea0a0be5c5468c48( randomint( 8 ) + 1 );
    }
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0x8423d52b, Offset: 0x2fb5
// Size: 0x2b2
function private function_ef4a6ed373ab05()
{
    enemies = getaiarrayinradius( self.origin, 1024, zm_utility::get_zombie_team() );
    
    if ( enemies.size == 0 )
    {
        return;
    }
    
    var_41632f3029ab478 = sortbydistance( enemies, self.origin );
    fovtargets = [];
    
    foreach ( guy in var_41632f3029ab478 )
    {
        if ( guy.ztron.boss || guy.health <= 0 )
        {
            continue;
        }
        
        playereye = self geteye();
        
        if ( utility::within_fov( playereye, self getplayerangles(), guy.origin, 0.8 ) )
        {
            const_trace_height = 300;
            start = ( guy.origin[ 0 ], guy.origin[ 1 ], const_trace_height );
            end = ( guy.origin[ 0 ], guy.origin[ 1 ], const_trace_height * -1 );
            ignorelist = [ self ];
            contents = trace::create_world_contents();
            trc = trace::ray_trace( start, end, ignorelist, contents, 1 );
            groundheight = trc[ "position" ][ 2 ];
            
            if ( groundheight > guy.origin[ 2 ] )
            {
                continue;
            }
            
            fovtargets[ fovtargets.size ] = guy;
        }
        
        if ( fovtargets.size >= 2 )
        {
            break;
        }
    }
    
    if ( fovtargets.size == 0 )
    {
        return;
    }
    
    target1 = fovtargets[ 0 ];
    target2 = fovtargets.size > 1 ? fovtargets[ 1 ] : fovtargets[ 0 ];
    v_spawn = self.origin + ( 0, 0, 100 );
    
    if ( utility::hastag( self.model, "tag_flash" ) )
    {
        v_spawn = self gettagorigin( "tag_flash" );
    }
    
    v_dir = anglestoforward( self.angles ) * 50;
    aimspot = v_spawn + v_dir + ( 0, 0, 10 );
    thread function_3430b783cc8eb0b7( v_spawn, aimspot, target1 );
    wait 0.1;
    thread function_3430b783cc8eb0b7( v_spawn, aimspot, target2 );
}

// Namespace ztron_weapon
// Params 4, eflags: 0x4
// Checksum 0xbe118a21, Offset: 0x326f
// Size: 0xdf
function private function_3430b783cc8eb0b7( origin, aimspot, target, lockdelay = 0.1 )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    var_8f2f51cf1451a6e5 = magicbullet( "sat_la_ztronpable3_mp_secondary", origin, aimspot, self );
    wait lockdelay;
    
    if ( isdefined( target ) && isdefined( var_8f2f51cf1451a6e5 ) )
    {
        if ( target.health > 0 )
        {
            var_8f2f51cf1451a6e5 missile_settargetent( target );
        }
    }
    
    /#
        targetalive = target.health > 0;
        ztron_debug::debugmsg( "<dev string:x166>" + targetalive + "<dev string:x178>" + self.origin + "<dev string:x189>" + target.origin + "<dev string:x19a>" + origin );
    #/
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0xc8ea6034, Offset: 0x3356
// Size: 0x6c
function private function_8a5e2cb6e8196529()
{
    params = { #weaponincrement:self.ztron.weaponincrement, #weaponlv:self.ztron.weaponLevel, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_400f60cbd2e2cb11", params );
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0x3952fc5a, Offset: 0x33ca
// Size: 0x7
function private function_fbe9627d3e8e1609()
{
    return "sat_pi_ztronraygun_mp";
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0x238ae1e3, Offset: 0x33da
// Size: 0x7
function private function_bd934b8987851dda()
{
    return "sat_lm_ztronjetgun_mp";
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0x8eb6dd2a, Offset: 0x33ea
// Size: 0x7
function private function_3bee7876bd01c883()
{
    return "sat_remote_robot_arm_gun_mp_ztron";
}

// Namespace ztron_weapon
// Params 0, eflags: 0x4
// Checksum 0xd4a9e87e, Offset: 0x33fa
// Size: 0x2d, Type: bool
function private function_6ec1575493ad0ab8()
{
    if ( self.ztron.var_ccae92f84b4e34b2 )
    {
        return false;
    }
    
    if ( !val::get( "weapon_pickup" ) )
    {
        return false;
    }
    
    return true;
}

