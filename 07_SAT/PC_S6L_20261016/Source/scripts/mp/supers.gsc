// scripts\mp\supers.gsc  (hash_4fca32f463c5e4fa.gscc) (size: 103260 Bytes / 0x1935c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7cfdac57 (2096999511)
// size ...... 103260 (0x1935c)
// includes .. 41  (offset: 0x1816c)
// strings ... 206 (offset: 0x182b4)
// dev strs .. 65  (offset: 0x19010)
// exports ... 344 (offset: 0xfff4)
// cseg ...... 0x106d + 0xef87 (0xfff4)
// imports ... 562 (offset: 0x135b4)
// animtree1 . 0   (offset: 0x1935c)
// animtree2 . 0   (offset: 0x1935c)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\equipment\balloon_extract;
#using scripts\mp\common\equipment\weapon_drop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\supers\gas_trap;
#using scripts\mp\common\supers\honeypot;
#using scripts\mp\common\supers\vehicle_drop;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\outofbounds;
#using scripts\mp\oxygenmask;
#using scripts\mp\persistence;
#using scripts\mp\squads;
#using scripts\mp\weapons;

#namespace supers_mp;

// Namespace supers_mp
// Params 0
// Checksum 0xd2d1e684, Offset: 0x108b
// Size: 0x3ac
function init()
{
    if ( utility::flag( "supers_initialized" ) )
    {
        return;
    }
    
    function_cd1719a14d935a1c();
    globals = spawnstruct();
    level.superglobals = globals;
    globals.staticsuperdata = [];
    globals.superweapons = [];
    globals.supersbyid = [];
    globals.var_da0d0ae8681f98ba = [];
    globals.supersbyoffhand = [];
    globals.supersbyextraweapon = [];
    globals.pointeventdata = [];
    globals.var_b9ca1ef11042f4 = getdvarint( @"hash_ec4c4df4cf064acf", 1 ) == 1;
    globals.var_57964f8d603b610a = getdvarint( @"hash_d9a4449e71b65ed9", 13 );
    function_1f950c8e75f84411( globals );
    function_ddc24473fe4cd472();
    registersupers();
    level notify( #"register_supers" );
    var_82a011cdcb9fa474 = spawnstruct();
    var_82a011cdcb9fa474.var_a3817c24c60dccd2 = &function_48aaa60b2ce7b8a1;
    function_6a42e8e596474559();
    callback::callback( #"register_super", var_82a011cdcb9fa474 );
    callback::remove( #"register_super", #"all" );
    initsuperdvars();
    function_2da12fb909f15abd();
    callback::add( #"player_spawned", &clearsuperreminderondeath );
    thread watchforgameend();
    
    if ( getdvarint( @"scr_superlotteryenabled", 0 ) > 0 )
    {
        thread watchsuperlottery();
    }
    
    if ( level.allowsupers || isbrgamemode() )
    {
        level thread handlesuperearnovertime();
    }
    
    level notify( #"init_supers" );
    
    if ( issuper( "super_balloon_extract" ) )
    {
        balloon_extract::function_9450f115cc82ffbd();
    }
    
    if ( utility::issharedfuncdefined( #"hash_fcab2be2130a4b27", #"init" ) )
    {
        [[ utility::getsharedfunc( #"hash_fcab2be2130a4b27", #"init" ) ]]();
    }
    
    gas_trap::gas_trap_init();
    oxygenmask::init_oxygenmask();
    
    if ( utility::issharedfuncdefined( #"super_med_box", #"init" ) )
    {
        [[ utility::getsharedfunc( #"super_med_box", #"init" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"super_comm_scrambler", #"init" ) )
    {
        [[ utility::getsharedfunc( #"super_comm_scrambler", #"init" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"super_hb_sensor", #"init" ) )
    {
        [[ utility::getsharedfunc( #"super_hb_sensor", #"init" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"super_launcher", #"init" ) )
    {
        [[ utility::getsharedfunc( #"super_launcher", #"init" ) ]]();
    }
    
    utility::registersharedfunc( #"supers", #"hash_59b4aa5398e4f70c", &function_2ec8bb8170acceb9 );
    val::register( "field_upgrade_recharge_mult", 1, 1, "$self", &set_field_upgrade_recharge_mult, "$value" );
    waittillframeend();
    callback::add( #"player_spawned", &super_onspawned );
    level.var_ae67ab0a1e16af15 = strtok( getdvar( @"hash_51bbc6411bd93fea", "" ), " " );
    level.var_b7e70fa484e134dc = function_fe4678cde55a525d();
    utility::registersharedfunc( #"supers", #"hash_28aeb93023a8a138", &function_579d273895a60bdb );
    utility::registersharedfunc( #"supers", #"hash_dc23d30a02afb5f0", &function_3328c97bfc08fe09 );
    utility::flag_set( "supers_initialized" );
}

// Namespace supers_mp
// Params 0, eflags: 0x4
// Checksum 0x2299d117, Offset: 0x143f
// Size: 0x64
function private function_3328c97bfc08fe09()
{
    if ( !isdefined( game[ #"hash_82ddb37df296c11e" ] ) )
    {
        game[ #"hash_82ddb37df296c11e" ] = { #var_e0650c077e69da28:0 };
    }
    
    var_f0a87c63bbeea0a3 = game[ #"hash_82ddb37df296c11e" ];
    
    if ( isdefined( var_f0a87c63bbeea0a3.var_e0650c077e69da28 ) )
    {
        var_f0a87c63bbeea0a3.var_e0650c077e69da28++;
    }
    
    return var_f0a87c63bbeea0a3.var_e0650c077e69da28;
}

// Namespace supers_mp
// Params 0, eflags: 0x4
// Checksum 0x2cad33cf, Offset: 0x14ac
// Size: 0x79
function private function_391017e903b2f974()
{
    if ( isdefined( level.gametypebundle.super_list ) )
    {
        superlist = level.gametypebundle.super_list;
    }
    else if ( isdefined( level.gamemodebundle.super_list ) )
    {
        superlist = level.gamemodebundle.super_list;
    }
    
    assert( isdefined( superlist ), "<dev string:x24>" );
    return superlist;
}

// Namespace supers_mp
// Params 0
// Checksum 0xb8ea7acb, Offset: 0x152e
// Size: 0x128
function function_cd1719a14d935a1c()
{
    if ( isdefined( level.var_b72c376264827891 ) )
    {
        return;
    }
    
    superlist = function_391017e903b2f974();
    level.var_7754f4a940c42add = superlist;
    var_8b7d9c28ea0c2e99 = getscriptbundle( superlist ?? "" );
    
    foreach ( super in var_8b7d9c28ea0c2e99.super_list )
    {
        if ( !( isdefined( super.ref ) && isdefined( super.bundle ) ) )
        {
            continue;
        }
        
        superref = super.override_ref ?? super.ref;
        level.var_b72c376264827891[ superref ] = super.bundle;
    }
    
    if ( !isdefined( level.var_b72c376264827891 ) )
    {
        level.var_b72c376264827891 = [];
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0x8687b7cd, Offset: 0x165e
// Size: 0x54
function function_adf2820d5daa2e81( var_19658764c9cb00b2, initfunc )
{
    if ( !isdefined( level.var_7d715b8567fd529e ) )
    {
        level.var_7d715b8567fd529e = [];
    }
    
    assert( !isdefined( level.var_7d715b8567fd529e[ var_19658764c9cb00b2 ] ), "<dev string:x73>" );
    level.var_7d715b8567fd529e[ var_19658764c9cb00b2 ] = initfunc;
}

// Namespace supers_mp
// Params 2
// Checksum 0x6e692fd8, Offset: 0x16ba
// Size: 0x54
function function_c3a8f689b66dfef( var_19658764c9cb00b2, beginusefunc )
{
    if ( !isdefined( level.var_8bc26f04233ed010 ) )
    {
        level.var_8bc26f04233ed010 = [];
    }
    
    assert( !isdefined( level.var_8bc26f04233ed010[ var_19658764c9cb00b2 ] ), "<dev string:x95>" );
    level.var_8bc26f04233ed010[ var_19658764c9cb00b2 ] = beginusefunc;
}

// Namespace supers_mp
// Params 1
// Checksum 0xebe4c246, Offset: 0x1716
// Size: 0xa3
function function_1f950c8e75f84411( globals )
{
    if ( isdefined( level.gametypebundle ) )
    {
        globals.givesuperonspawn = istrue( level.gametypebundle.givesuperonspawn );
        globals.var_7528e3d743bcb734 = istrue( level.gametypebundle.var_7528e3d743bcb734 );
        globals.var_a817308d8d92ff8c = istrue( level.gametypebundle.var_a817308d8d92ff8c );
        return;
    }
    
    globals.givesuperonspawn = 0;
    globals.var_7528e3d743bcb734 = 0;
    globals.var_a817308d8d92ff8c = 0;
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xb5743d98, Offset: 0x17c1
// Size: 0x41
function private initializesuper( var_19658764c9cb00b2 )
{
    if ( !isdefined( level.var_7d715b8567fd529e ) )
    {
        return;
    }
    
    initfunc = level.var_7d715b8567fd529e[ var_19658764c9cb00b2 ];
    
    if ( !isdefined( initfunc ) )
    {
        return;
    }
    
    level [[ initfunc ]]();
}

// Namespace supers_mp
// Params 1
// Checksum 0xf9edd4d4, Offset: 0x180a
// Size: 0x35
function function_4f3849ddacf0b0c0( var_55f5ea554bfe390a )
{
    assert( !isdefined( level.var_5baf51b4058a08a2 ) );
    level.var_5baf51b4058a08a2 = [];
    level.var_55f5ea554bfe390a = istrue( var_55f5ea554bfe390a );
}

// Namespace supers_mp
// Params 1
// Checksum 0xc4199d6a, Offset: 0x1847
// Size: 0x49
function function_f8580c22ea1b1d30( bundle )
{
    level.var_bed70a0c85276706 = istrue( bundle.var_bed70a0c85276706 );
    level.var_97b22765d09c99c7 = bundle.var_97b22765d09c99c7;
    level.var_26c61fbdbc9fc246 = bundle.var_26c61fbdbc9fc246;
}

// Namespace supers_mp
// Params 1
// Checksum 0x36c16f10, Offset: 0x1898
// Size: 0x41
function function_a57064278d4e8136( var_3372ada1629751e5 = 96 )
{
    var_c118d8c9ce92053a = 0.05 * var_3372ada1629751e5 / 60;
    function_16ccf60113bf29a9( #"time", var_c118d8c9ce92053a );
}

// Namespace supers_mp
// Params 2
// Checksum 0x1cb18b47, Offset: 0x18e1
// Size: 0x68
function function_16ccf60113bf29a9( eventref, points )
{
    if ( !isdefined( points ) )
    {
        return;
    }
    
    assert( isxhash( eventref ) );
    assert( isdefined( level.var_5baf51b4058a08a2 ) );
    
    if ( level.var_55f5ea554bfe390a && eventref != #"time" )
    {
        return;
    }
    
    level.var_5baf51b4058a08a2[ eventref ] = points;
}

// Namespace supers_mp
// Params 0
// Checksum 0x3459540, Offset: 0x1951
// Size: 0x446
function registersupers()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    function_48aaa60b2ce7b8a1( "super_test", undefined, undefined, &testsuperbeginuse, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_br_extract", undefined, undefined, &brcircleextract, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_scramble", undefined, undefined, &scramblebeginuse, &scrambleusefinished, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_weapon_drop", undefined, undefined, &superweapondropbeginuse, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_select", &superselectonset, &superselectonunset, &superselectbeginuse, undefined, undefined, &selectongive, &function_912b93e3713c8d84, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_fulton", undefined, undefined, &superfultonbeginuse, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_supply_drop", undefined, undefined, &supersupplydropbeginuse, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_balloon_extract", undefined, undefined, &superfultonbeginuse, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_oxygen_mask", undefined, undefined, &oxygenmask::give_oxygenmask, undefined, &function_7e9dfc75ee02fb34, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_deployable_kiosk", undefined, undefined, &function_30cf20678e7024d5, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_honeypot", undefined, undefined, &function_4ea1a134644a2eab, &function_710e709d51f03fbf, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_laststand_syringe", undefined, undefined, &function_ff9ba713901cfaeb, &function_25796e9fde1a9aff, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_spykit", undefined, undefined, &spykitbeginuse, &function_92a81da74a54495c, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_acoustic_amp", undefined, undefined, &function_bf3102573af5c490, &function_262676e0279bbd70, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_contract_skipper", undefined, &function_62ee57bc0d973e27, &function_4ef0fe1d10775a2e, &function_ed90b28fca65b4c6, undefined, &function_fc8b4aa9c1978f92, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_pop_candy", undefined, &popcandyunset, &popcandybeginuse, &function_427e881721868562, undefined, &popcandyongive, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_mutation_ninja_vanish", undefined, undefined, &function_49fc50b678e39594, &function_7ab0ca01e6a3d614, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_mutation_shuriken_fury", undefined, undefined, &function_4967df4f1b779332, &function_efd6f6278efa9cda, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_mutation_turtle_power", undefined, undefined, &function_f8d8d71909e4d670, &function_5a2ff6e9d94d5250, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_mutation_ninja_sense", undefined, undefined, &function_ce1365413503ca17, &function_ef339a2cdcaf030b, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_mutation_boba_stim", undefined, undefined, &function_e5cfebb7610612fa, undefined, undefined, undefined, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_mutation_shell_shocked", undefined, undefined, &function_247d5bb630e92344, &function_77cb1af7cc3abcc4, undefined, &function_9cb5a52d7a8a4a81, undefined, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_blowtorch" );
    function_48aaa60b2ce7b8a1( "super_defibrillator", undefined, undefined, utility::getsharedfunc( #"hash_f83d1f091b9a1e8e", #"hash_385fad80a2c0510a" ) );
    function_48aaa60b2ce7b8a1( "super_la_rpapa7", &launcherset, &launcherunset, &launcherbeginuse, &launcherenduse, &function_4dc3365911c16eac, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_la_gromeo", &launcherset, &launcherunset, &launcherbeginuse, &launcherenduse, &function_4dc3365911c16eac, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_la_juliet", &launcherset, &launcherunset, &launcherbeginuse, &launcherenduse, &function_4dc3365911c16eac, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_la_kgolf", &launcherset, &launcherunset, &launcherbeginuse, &launcherenduse, &function_4dc3365911c16eac, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_la_mike32", &launcherset, &launcherunset, &launcherbeginuse, &launcherenduse, &function_4dc3365911c16eac, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_la_jp22_dromeo", &launcherset, &launcherunset, &launcherbeginuse, &launcherenduse, &function_4dc3365911c16eac, undefined, undefined );
    function_48aaa60b2ce7b8a1( "super_evg", undefined, undefined, undefined, undefined, undefined, &function_b05dbd2d306d946a, &function_c805ff9720d542d1 );
    
    if ( isdefined( level.register_super_custom_func ) )
    {
        [[ level.register_super_custom_func ]]();
    }
    
    registersuperextraweapon( "super_emp_drone", %"emp_drone_player_mp" );
    registersuperextraweapon( "super_emp_drone", %"emp_drone_non_player_mp" );
    registersuperextraweapon( "super_emp_drone", %"emp_drone_non_player_direct_mp" );
    registersuperextraweapon( "super_weapon_drop", "deploy_weapondrop_mp" );
    registersuperextraweapon( "super_trophy", %"trophy_submunition" );
}

// Namespace supers_mp
// Params 10
// Checksum 0x84ec2759, Offset: 0x1d9f
// Size: 0x150
function function_48aaa60b2ce7b8a1( ref, setfunc, unsetfunc, beginusefunc, endusefunc, var_49661824f9845c52, ongivefunc, var_a7ba5cee6855a3ad, reclaimfunc, var_9d4e2d5725711898 )
{
    staticdata = level.superglobals.staticsuperdata[ ref ];
    
    if ( !isdefined( staticdata ) )
    {
        println( "<dev string:xbc>" + ref + "<dev string:xe6>" + getxhashsourcename( level.var_7754f4a940c42add ) );
        return;
    }
    
    staticdata.setfunc = setfunc;
    staticdata.unsetfunc = unsetfunc;
    staticdata.beginusefunc = beginusefunc;
    staticdata.endusefunc = endusefunc;
    staticdata.var_49661824f9845c52 = var_49661824f9845c52;
    staticdata.ongivefunc = ongivefunc;
    staticdata.var_a7ba5cee6855a3ad = var_a7ba5cee6855a3ad;
    staticdata.reclaimfunc = reclaimfunc;
    staticdata.var_2a67c6f950e71cf7 = var_9d4e2d5725711898;
    
    if ( !isdefined( var_49661824f9845c52 ) && staticdata.var_44a1d1cf563489e4 )
    {
        staticdata.var_49661824f9845c52 = &function_a456d0290912f49;
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0x2e7bd2ba, Offset: 0x1ef7
// Size: 0xbd
function registersuperextraweapon( ref, weapon )
{
    weaponnamekey = isxhashasset( weapon ) ? weapon : isstring( weapon ) ? getxhashasset( weapon ) : weapon.basenamehash;
    staticdata = level.superglobals.staticsuperdata[ ref ];
    
    if ( !isdefined( staticdata ) )
    {
        println( "<dev string:x11b>" + ref + "<dev string:x12e>" );
        return;
    }
    
    staticdata.extraweapons[ staticdata.extraweapons.size ] = weapon;
    level.superglobals.supersbyextraweapon[ weaponnamekey ] = staticdata;
}

// Namespace supers_mp
// Params 2
// Checksum 0x6fc87736, Offset: 0x1fbc
// Size: 0x4d
function function_19492daedcf2689a( ref, function )
{
    staticdata = level.superglobals.staticsuperdata[ ref ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    staticdata.var_5124e8da6c8c548a = function;
}

// Namespace supers_mp
// Params 2
// Checksum 0x47547b8f, Offset: 0x2011
// Size: 0x4d
function function_b8086f6e4874df4a( ref, function )
{
    staticdata = level.superglobals.staticsuperdata[ ref ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    staticdata.var_5afeac4251aa48da = function;
}

// Namespace supers_mp
// Params 2
// Checksum 0xbce914d1, Offset: 0x2066
// Size: 0x23
function function_2cf33fc9d4b30c04( ref, superpointsmod )
{
    level.var_8a3e2af27738ffdc[ ref ] = superpointsmod;
}

// Namespace supers_mp
// Params 1
// Checksum 0x130b4212, Offset: 0x2091
// Size: 0xe2
function super_onspawned( params )
{
    if ( isdefined( self.super ) && level.superglobals.givesuperonspawn )
    {
        givesuperpoints( getsuperpointsneeded(), undefined, 0 );
        
        if ( level.var_b7e70fa484e134dc && self.tacticalsuper )
        {
            givesuperpoints( getsuperpointsneeded( undefined, #"tactical" ), undefined, 0, undefined, undefined, undefined, #"tactical" );
        }
        
        thread function_68ad64dd2c11d62f();
    }
    
    updatesuperuiprogress();
    updatesuperuistate();
    function_1b82c2193d15ea65();
    
    if ( level.var_b7e70fa484e134dc && self.tacticalsuper )
    {
        updatesuperuiprogress( #"tactical" );
        updatesuperuistate( #"tactical" );
        function_1b82c2193d15ea65( #"tactical" );
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xc7492e34, Offset: 0x217b
// Size: 0x92
function function_68ad64dd2c11d62f()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_50e469abe551e7d" );
    self endon( #"hash_50e469abe551e7d" );
    
    while ( true )
    {
        self waittill( #"super_set" );
        givesuperpoints( getsuperpointsneeded() );
        
        if ( level.var_b7e70fa484e134dc && self.tacticalsuper )
        {
            givesuperpoints( getsuperpointsneeded( undefined, #"tactical" ), undefined, undefined, undefined, undefined, undefined, #"tactical" );
        }
    }
}

// Namespace supers_mp
// Params 3
// Checksum 0xcb4c7df4, Offset: 0x2215
// Size: 0xb4
function waitsetsuperref( superref, superid, slot )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    omnvar = function_c1488fa73d55ae70( slot, "ui_super_ref" );
    
    if ( omnvar )
    {
        self notify( "waitSetSuperRef_" + omnvar );
        self endon( "waitSetSuperRef_" + omnvar );
    }
    
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        assertmsg( "<dev string:x165>" + ( slot ?? "<dev string:x195>" ) + "<dev string:x19f>" + superref );
        return;
    }
    
    if ( omnvar )
    {
        self setclientomnvar( omnvar, superref );
    }
    
    function_dbc8badb3eff31fc( superid );
}

// Namespace supers_mp
// Params 6
// Checksum 0xdbd14bcf, Offset: 0x22d1
// Size: 0x9b5
function givesuper( superref, savesuperpoints, immediate, blueprintindex, attachments, slot )
{
    self endon( function_cc6f5a44b1441e16( slot, "give_super_cancel" ) );
    
    if ( getdvarint( @"scr_supers_killswitch" ) != 0 )
    {
        return;
    }
    
    var_3c61abef8e067a20 = superref == "" || superref == "none";
    staticdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( !staticdata )
    {
        overrideinfo = level.superglobals.refoverrides[ superref ];
        
        if ( overrideinfo )
        {
            superref = overrideinfo.overrideref;
            staticdata = level.superglobals.staticsuperdata[ superref ];
        }
        
        if ( !staticdata && !var_3c61abef8e067a20 )
        {
            assertmsg( "<dev string:x1ac>" + superref + "<dev string:x1d3>" + getxhashsourcename( level.var_7754f4a940c42add ) );
            return;
        }
    }
    
    if ( !isdefined( level.var_6f8cfae8c8ed3506 ) )
    {
        level.var_6f8cfae8c8ed3506 = getdvarint( @"hash_de5ee22f3273b921", 0 );
    }
    
    if ( level.var_6f8cfae8c8ed3506 && superisrestricted( superref ) )
    {
        return;
    }
    
    if ( issuperinuse( slot ) )
    {
        currentsuper = getcurrentsuper( slot );
        
        if ( superref == currentsuper.staticdata.ref && currentsuper.staticdata.persistondeath )
        {
            if ( currentsuper.staticdata.bundle.var_490e39e8f67ff43c )
            {
                return;
            }
            else if ( currentsuper.staticdata.bundle.var_4cdd483439d92e04 )
            {
                maxclipammo = weaponmaxammo( currentsuper.staticdata.useweapon );
                ammopool = currentsuper.var_91cdf2de88e5a13a.clipammo + currentsuper.var_91cdf2de88e5a13a.stockammo;
                
                if ( maxclipammo <= ammopool )
                {
                    return;
                }
            }
        }
    }
    
    clearsuper( savesuperpoints, superref, 0, slot );
    assert( !issuperinuse( slot ), "<dev string:x1f2>" );
    
    if ( var_3c61abef8e067a20 )
    {
        return;
    }
    
    function_9da92555efee3676( superref );
    function_d6ffc5c7abc5689( 0 );
    superinfo = spawnstruct();
    
    if ( slot == #"tactical" )
    {
        self.tacticalsuper = superinfo;
        superinfo.slot = #"tactical";
    }
    else
    {
        self.super = superinfo;
        superinfo.slot = #"default";
    }
    
    superinfo.staticdata = staticdata;
    superinfo.allowrefund = 1;
    superinfo.numkills = 0;
    superinfo.wasrefunded = 0;
    superinfo.canstow = 0;
    superinfo.lifeid = killstreak_utility::getcurrentplayerlifeidforkillstreak();
    superinfo.basepoints = 0;
    superinfo.extrapoints = 0;
    superinfo.usestarttime = undefined;
    superinfo.usepercent = 0;
    superinfo.overridepointsneeded = undefined;
    superinfo.var_a957044d064c9048 = 0;
    superinfo.var_3107a3601c2d758b = 0;
    superinfo.var_aba4427f72a2cbe7 = 1;
    
    if ( superinfo.staticdata.weapon == %"super_default_mp" || superinfo.staticdata.weapon == %"super_minor_default_mp" )
    {
        superinfo.weaponobj = buildsuper( staticdata.weapon, blueprintindex, [] );
        
        if ( superinfo.staticdata.weapontype == "BULLETWEAPON" && superinfo.staticdata.useweapon )
        {
            superinfo.var_7ef7600ff6978d76 = superinfo.staticdata.useweapon;
            superinfo.var_7ef7600ff6978d76 = superinfo.var_7ef7600ff6978d76 withattachments( attachments );
        }
    }
    else
    {
        superinfo.weaponobj = buildsuper( staticdata.weapon, blueprintindex, attachments );
    }
    
    superinfo.attachments = superinfo.var_7ef7600ff6978d76.attachments ?? superinfo.weaponobj.attachments;
    superinfo.blueprintindex = blueprintindex;
    superinfo.var_8ed30a6619c8fe36 = 0;
    function_c7a8c9a907d7e68b( undefined, slot );
    function_dd6d97545b84597d( 0, slot );
    setsuperisinuse( 0, slot );
    setsuperisactive( 0, slot );
    
    if ( isdefined( superinfo.staticdata.useweapon ) )
    {
        function_68ef53f6862aedd9( slot );
    }
    
    superonset( superref, slot );
    function_ae196637f78e0ead( superinfo );
    var_a9ad810a74eceb17 = function_8738421e46f2cfbc( superref );
    thread waitsetsuperref( var_a9ad810a74eceb17, superinfo.staticdata.id, slot );
    
    if ( function_cc252fb1315910e5( superinfo, slot ) )
    {
        function_437d9d55b3dd7693( superinfo, slot );
    }
    else
    {
        superbasepoints = self.pers[ slot == #"tactical" ? "tacticalSuperBasePoints" : "superBasePoints" ];
        
        if ( !isdefined( superbasepoints ) )
        {
            superbasepoints = 0;
        }
        
        self.pers[ slot == #"tactical" ? "tacticalSuperBasePoints" : "superBasePoints" ] = undefined;
        setsuperbasepoints( superbasepoints, 1, slot );
        superextrapoints = self.pers[ slot == #"tactical" ? "tacticalSuperExtraPoints" : "superExtraPoints" ];
        
        if ( !isdefined( superextrapoints ) )
        {
            superextrapoints = 0;
        }
        
        self.pers[ slot == #"tactical" ? "tacticalSuperExtraPoints" : "superExtraPoints" ] = undefined;
        setsuperextrapoints( superextrapoints, 0, slot );
        
        if ( slot == #"tactical" )
        {
            if ( isdefined( self.pers[ "tacticalSuperAmmo" ] ) )
            {
                equipmentref = equipment_mp::getcurrentequipment( "secondary" );
                equipment_mp::setequipmentammo( equipmentref, self.pers[ "tacticalSuperAmmo" ] );
            }
        }
    }
    
    if ( !isdefined( self.pers[ slot == #"tactical" ? "tacticalSuperExpended" : "superExpended" ] ) )
    {
        setsuperexpended( 0, slot );
    }
    
    if ( immediate )
    {
        givesuperpoints( getsuperpointsneeded( superinfo ), undefined, undefined, undefined, undefined, undefined, slot );
        
        if ( isbrgamemode() && ( flags::gameflag( "prematch_done" ) || getdvarint( @"hash_16adc8396fb1019e", 1 ) != 0 ) )
        {
            self.var_33129007db246c94 = 1;
        }
        
        superinfo.madeavailabletime = gettime();
        analyticslog::logevent_superearned( superinfo.madeavailabletime );
    }
    
    inventory_utility::_giveweapon( superinfo.weaponobj, undefined, undefined, 0 );
    
    if ( slot != #"tactical" )
    {
        ammo = issuperready( superinfo ) ? 1 : 0;
        self setweaponammoclip( superinfo.weaponobj, ammo );
    }
    else
    {
        ref = equipment_mp::getcurrentequipment( "secondary" );
        equipbundle = equipment_mp::function_c90a9aa89b223dd7( ref );
        
        if ( equipbundle.issuper && !issuperready( superinfo ) )
        {
            equipment_mp::setequipmentammo( ref, 0 );
        }
    }
    
    firstupgrade = level.superglobals.staticsuperdata[ perkpackage::perkpackage_getfirstfieldupgrade() ];
    secondupgrade = level.superglobals.staticsuperdata[ perkpackage::perkpackage_getsecondfieldupgrade() ];
    var_1188fe0b0d60467d = "none";
    var_2cd454266f054f27 = "none";
    
    if ( isdefined( firstupgrade ) && firstupgrade != staticdata )
    {
        var_1188fe0b0d60467d = firstupgrade.weapon;
    }
    
    if ( isdefined( secondupgrade ) && secondupgrade != staticdata )
    {
        var_2cd454266f054f27 = secondupgrade.weapon;
    }
    
    if ( slot == #"tactical" && staticdata.weapontype == "OFFHANDWEAPON" )
    {
        self assignweaponoffhandsecondary( superinfo.weaponobj );
    }
    
    if ( slot != #"tactical" )
    {
        self assignweaponoffhandspecial( superinfo.weaponobj, var_1188fe0b0d60467d, var_2cd454266f054f27 );
    }
    
    params = spawnstruct();
    params.player = self;
    params.superref = superref;
    callback::callback( "equipped_super", params );
    thread watchforsuperusebegin( slot );
    thread handlespectating( slot );
    
    if ( !isbrgamemode() || level.allowsupers )
    {
        thread watchforrespawn( slot );
        thread storesupercooldownforroundchange( slot );
        thread handleteamchange( slot );
    }
    
    if ( isbrgamemode() )
    {
        if ( isdefined( superinfo.staticdata.ongivefunc ) )
        {
            self thread [[ superinfo.staticdata.ongivefunc ]]();
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x1f47d1c9, Offset: 0x2c8e
// Size: 0x40
function function_6a42e8e596474559()
{
    level.super_omnvars = [];
    level.super_omnvars[ #"tactical" ] = [];
    level.super_omnvars[ #"tactical" ][ "ui_super_progress" ] = "ui_tactical_recharge_progress";
}

// Namespace supers_mp
// Params 1
// Checksum 0x4acaf736, Offset: 0x2cd6
// Size: 0x2b
function function_8738421e46f2cfbc( super )
{
    if ( isdefined( level.var_e18313301e451da3[ super ] ) )
    {
        return level.var_e18313301e451da3[ super ];
    }
    
    return super;
}

// Namespace supers_mp
// Params 1
// Checksum 0x5a3589fc, Offset: 0x2d0a
// Size: 0x57
function function_ae196637f78e0ead( superinfo )
{
    if ( !hasomnvar( "ui_super_segments" ) )
    {
        return;
    }
    
    ammopool = getsupermaxammo( superinfo, isdefined( superinfo.staticdata.useweapon ) );
    
    if ( isdefined( ammopool ) )
    {
        self setclientomnvar( "ui_super_segments", ammopool );
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x42cd4f43, Offset: 0x2d69
// Size: 0x1f2
function handlesuperearnovertime()
{
    level endon( #"game_ended" );
    
    if ( level.superglobals.var_7528e3d743bcb734 )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    if ( getdvarint( @"hash_88b7d92b6caff1df", 0 ) )
    {
        waitinfil = 1;
        var_bb86f77304f193c4 = level.var_bb86f77304f193c4;
        
        if ( var_bb86f77304f193c4 )
        {
            waitinfil = !var_bb86f77304f193c4.var_aab22481530ff9ff;
        }
        
        if ( waitinfil )
        {
            utility::flag_wait( "ob_infil_completed" );
        }
    }
    
    starttime = gettime();
    waitframe();
    var_1fc7087bbfefb716 = getdvarint( @"hash_926f122e92eef315", 15 );
    
    while ( true )
    {
        if ( level.var_17ebe57584c369c9 )
        {
            starttime = gettime();
            waitframe();
            continue;
        }
        
        playercount = level.players.size;
        var_70598aa0cb8b02c2 = ( gettime() - starttime ) / 50;
        
        if ( var_70598aa0cb8b02c2 < 11 )
        {
            wait ( 11 - var_70598aa0cb8b02c2 ) * 0.05;
            var_70598aa0cb8b02c2 = 11;
        }
        
        starttime = gettime();
        allowsupers = istrue( level.allowsupers );
        startplayer = 0;
        
        while ( startplayer < playercount )
        {
            for ( updateindex = 0; updateindex < var_1fc7087bbfefb716 ; updateindex++ )
            {
                playerindex = startplayer + updateindex;
                player = level.players[ playerindex ];
                
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( player.pausesuperpointsovertime )
                {
                    continue;
                }
                
                if ( !( player.var_760a3e04da86556f || allowsupers ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( player ) )
                {
                    continue;
                }
                
                player function_6c63b3c513bcb950( #"default", var_70598aa0cb8b02c2 );
                player function_6c63b3c513bcb950( #"tactical", var_70598aa0cb8b02c2 );
            }
            
            waitframe();
            startplayer += var_1fc7087bbfefb716;
        }
        
        waitframe();
    }
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0x996cf0c0, Offset: 0x2f63
// Size: 0x95
function private function_6c63b3c513bcb950( slot, var_70598aa0cb8b02c2 )
{
    if ( slot == #"tactical" && !level.var_b7e70fa484e134dc )
    {
        return;
    }
    
    if ( !function_2041e16ed18271bc( slot ) || isbrgamemode() )
    {
        currentsuper = getcurrentsuper( slot );
        
        if ( isdefined( currentsuper ) && !currentsuper.isinuse )
        {
            if ( !function_cc252fb1315910e5( currentsuper ) )
            {
                givesuperpoints( 0, #"time", 0, var_70598aa0cb8b02c2, undefined, undefined, slot );
            }
        }
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xbdc57470, Offset: 0x3000
// Size: 0x116
function shouldunsetsuper( var_286c115939b6daf0, slot )
{
    if ( !isdefined( var_286c115939b6daf0 ) )
    {
        return 1;
    }
    
    if ( !isdefined( self.perkpackagedata ) )
    {
        return 1;
    }
    
    if ( var_286c115939b6daf0 == "super_select" )
    {
        return 0;
    }
    
    if ( isbrgamemode() )
    {
        if ( self.perkpackagedata.firstupgrade == var_286c115939b6daf0 )
        {
            return 0;
        }
        else
        {
            return 1;
        }
    }
    
    var_ea76711a6b70cb6 = self.perkpackagedata.lastsuper;
    
    if ( !isdefined( var_ea76711a6b70cb6 ) )
    {
        return 1;
    }
    
    if ( var_286c115939b6daf0 == var_ea76711a6b70cb6 )
    {
        return 1;
    }
    
    var_fdccd473bc22741f = function_6cb748aa8fcb575b( var_ea76711a6b70cb6 );
    var_3f87df7ed782a6a9 = function_6cb748aa8fcb575b( var_286c115939b6daf0 );
    var_6d6795272a56d9a5 = function_3f90266754288234();
    
    if ( var_3f87df7ed782a6a9 )
    {
        if ( var_6d6795272a56d9a5 != var_286c115939b6daf0 )
        {
            function_6bb6a62fab30a411();
        }
        
        superonunset( var_ea76711a6b70cb6, slot );
        return 1;
    }
    
    if ( var_fdccd473bc22741f && !var_3f87df7ed782a6a9 )
    {
        function_e588c6513c782be0( var_ea76711a6b70cb6 );
        return 0;
    }
    
    superonunset( var_ea76711a6b70cb6, slot );
    return 1;
}

// Namespace supers_mp
// Params 1
// Checksum 0x7973252, Offset: 0x311e
// Size: 0x43, Type: bool
function function_6cb748aa8fcb575b( superref )
{
    staticdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( !isdefined( staticdata ) )
    {
        return false;
    }
    
    return istrue( staticdata.var_2c56f0068dd07712 );
}

// Namespace supers_mp
// Params 1
// Checksum 0xb97a4904, Offset: 0x316a
// Size: 0x3b
function function_e588c6513c782be0( superref )
{
    if ( isdefined( self.var_6d6795272a56d9a5 ) && self.var_6d6795272a56d9a5 != superref )
    {
        function_6bb6a62fab30a411();
    }
    
    self.var_6d6795272a56d9a5 = superref;
}

// Namespace supers_mp
// Params 0
// Checksum 0x8e8595b3, Offset: 0x31ad
// Size: 0x74
function function_6bb6a62fab30a411()
{
    if ( !isdefined( self.var_6d6795272a56d9a5 ) )
    {
        return;
    }
    
    if ( self.var_7498cbde80958ac7 )
    {
        return;
    }
    
    staticdata = level.superglobals.staticsuperdata[ self.var_6d6795272a56d9a5 ];
    unsetfunc = staticdata.unsetfunc;
    
    if ( !isdefined( unsetfunc ) )
    {
        return;
    }
    
    self thread [[ unsetfunc ]]();
    self.var_6d6795272a56d9a5 = undefined;
}

// Namespace supers_mp
// Params 0
// Checksum 0x9d585020, Offset: 0x3229
// Size: 0xb
function function_3f90266754288234()
{
    return self.var_6d6795272a56d9a5;
}

// Namespace supers_mp
// Params 5
// Checksum 0x3ab4a2ff, Offset: 0x323d
// Size: 0x22f
function clearsuper( savesuperpoints, var_286c115939b6daf0, playerkilled, slot, clearoverclock )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    superinfo = getcurrentsuper( slot );
    canrecharge = function_31f00fe6e0334d03( slot );
    
    if ( issuperinuse( slot ) && ( superinfo.staticdata.persistondeath || superhastimedusage( superinfo ) || isusingsuperweapon( slot ) ) )
    {
        superusefinished( 0, istrue( playerkilled ), 0, 0, undefined, 1, slot );
    }
    
    if ( isdefined( superinfo.staticdata ) )
    {
        if ( shouldunsetsuper( var_286c115939b6daf0, slot ) )
        {
            superonunset( superinfo.staticdata.ref, slot );
        }
    }
    
    if ( savesuperpoints && superinfo )
    {
        storesuperpoints( slot );
    }
    
    if ( !slot || slot == #"default" )
    {
        self clearoffhandspecial();
    }
    
    if ( superinfo )
    {
        inventory_utility::_takeweapon( superinfo.weaponobj );
    }
    
    if ( level.codcasterenabled && !isagent( self ) )
    {
        self setspecialactive( 0 );
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    
    if ( slot == #"tactical" )
    {
        self.tacticalsuper = undefined;
    }
    else
    {
        self.super = undefined;
    }
    
    function_9da92555efee3676( "none" );
    function_d6ffc5c7abc5689( 0 );
    
    if ( function_ec7e2ab9a462557b() )
    {
        function_2dccac3e12d95853( 0 );
    }
    
    if ( !canrecharge && isbrgamemode() )
    {
        self.var_33129007db246c94 = 0;
    }
    
    thread handlesuperuistatechange( 0, slot );
    thread function_cb3e288a8ed4df3e( 0, slot );
    var_607fdcfd1d65cbfe = function_c1488fa73d55ae70( slot, "ui_super_second_progress" );
    
    if ( var_607fdcfd1d65cbfe )
    {
        self setclientomnvar( var_607fdcfd1d65cbfe, 0 );
    }
    
    var_85a5c4886dbfacb1 = function_c1488fa73d55ae70( slot, "ui_super_ref" );
    
    if ( var_85a5c4886dbfacb1 )
    {
        self setclientomnvar( var_85a5c4886dbfacb1, "none" );
    }
    
    if ( clearoverclock )
    {
        self.overclockcharge = 0;
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0x73952e82, Offset: 0x3474
// Size: 0x10f
function superonset( superref, slot )
{
    if ( !isdefined( superref ) )
    {
        return;
    }
    
    if ( superref == "none" || superref == "" )
    {
        return;
    }
    
    staticdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    clientnum = self getentitynumber();
    codcaster_utils::function_daf7fb7edb6acdbd( 2, clientnum, undefined );
    
    if ( isdefined( staticdata.var_49661824f9845c52 ) )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_block_fu_not_ready_error" );
        
        if ( omnvar )
        {
            self setclientomnvar( omnvar, 1 );
        }
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "super_set" ) );
    setfunc = staticdata.setfunc;
    
    if ( !isdefined( setfunc ) )
    {
        return;
    }
    
    if ( level.superglobals.givesuperonspawn )
    {
        givesuperpoints( getsuperpointsneeded( undefined, slot ), undefined, 0, undefined, undefined, undefined, slot );
    }
    
    self thread [[ setfunc ]]();
}

// Namespace supers_mp
// Params 2
// Checksum 0xf2d2ef3e, Offset: 0x358b
// Size: 0xce
function superonunset( superref, slot )
{
    if ( !isdefined( superref ) )
    {
        return;
    }
    
    if ( superref == "none" || superref == "" )
    {
        return;
    }
    
    staticdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    if ( isdefined( staticdata.var_49661824f9845c52 ) )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_block_fu_not_ready_error" );
        
        if ( omnvar )
        {
            self setclientomnvar( omnvar, 0 );
        }
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    function_dbc8badb3eff31fc( 0 );
    unsetfunc = staticdata.unsetfunc;
    
    if ( !isdefined( unsetfunc ) )
    {
        return;
    }
    
    self thread [[ unsetfunc ]]();
}

// Namespace supers_mp
// Params 1
// Checksum 0x17f2a1ca, Offset: 0x3661
// Size: 0xa6
function function_235acb90dc5ccdbe( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( superinfo.isinuse )
    {
        thread function_3c0eb749ec559ae( slot );
    }
    else
    {
        setsuperbasepoints( getsuperpointsneeded( undefined, slot ), 1, slot );
    }
    
    updatesuperuiprogress( slot );
    updatesuperuistate( slot );
    function_1b82c2193d15ea65( slot );
    superinfo = getcurrentsuper( slot );
    
    if ( slot != #"tactical" )
    {
        self setweaponammoclip( superinfo.weaponobj, 1 );
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "super_ready" ), 0 );
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x81ae338b, Offset: 0x370f
// Size: 0x4d
function private function_3c0eb749ec559ae( slot )
{
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    self waittill( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    setsuperbasepoints( getsuperpointsneeded( undefined, slot ), 1, slot );
}

// Namespace supers_mp
// Params 3
// Checksum 0xcf50db11, Offset: 0x3764
// Size: 0x104
function setsuperbasepoints( points, setonly, slot )
{
    assert( isdefined( points ) );
    superinfo = getcurrentsuper( slot );
    assert( !superinfo.isinuse, "<dev string:x247>" );
    pointsneeded = getsuperpointsneeded( superinfo );
    superinfo.basepoints = clamp( points, 0, pointsneeded );
    
    if ( isdefined( self.overclockcharge ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        if ( self.overclockcharge >= pointsneeded )
        {
            var_b4b0ce3ba4c5edde = 2;
        }
        else if ( superinfo.basepoints >= pointsneeded )
        {
            var_b4b0ce3ba4c5edde = 1;
        }
        else
        {
            var_b4b0ce3ba4c5edde = 0;
        }
        
        if ( var_b4b0ce3ba4c5edde != ( self.var_225bc3d2a79af41f ?? -1 ) )
        {
            function_ff6b94c648420440( var_b4b0ce3ba4c5edde );
        }
    }
    
    if ( setonly )
    {
        return;
    }
    
    superpointschanged( slot, pointsneeded );
}

// Namespace supers_mp
// Params 3
// Checksum 0x1ba5b467, Offset: 0x3870
// Size: 0x8d
function setsuperextrapoints( points, setonly, slot )
{
    assert( isdefined( points ) );
    superinfo = getcurrentsuper( slot );
    assert( !superinfo.isinuse, "<dev string:x27e>" );
    superpointsneeded = getsuperpointsneeded( superinfo );
    superinfo.extrapoints = clamp( points, 0, superpointsneeded );
    
    if ( setonly )
    {
        return;
    }
    
    superpointschanged( slot, superpointsneeded );
}

// Namespace supers_mp
// Params 3
// Checksum 0xcac48ebc, Offset: 0x3905
// Size: 0xd8
function function_1f9b6b3c1d1f1404( points, setonly, slot )
{
    assert( isdefined( points ) );
    
    if ( isdefined( self.overclockcharge ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        pointsneeded = getsuperpointsneeded( undefined, slot );
        self.overclockcharge = clamp( points, 0, pointsneeded );
        
        if ( ( self.var_225bc3d2a79af41f ?? 0 ) < 2 )
        {
            if ( self.overclockcharge >= pointsneeded )
            {
                function_ff6b94c648420440( 2 );
            }
        }
        else if ( self.overclockcharge < pointsneeded )
        {
            function_ff6b94c648420440( 1 );
        }
        
        if ( !setonly )
        {
            function_7d55dcbfe177d86f( self.overclockcharge, slot );
            function_1b82c2193d15ea65( slot );
        }
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xf1297a57, Offset: 0x39e5
// Size: 0x2b
function function_ff6b94c648420440( value )
{
    self.var_225bc3d2a79af41f = value;
    self setclientomnvar( "ui_super_charge_num", self.var_225bc3d2a79af41f );
}

/#

    // Namespace supers_mp
    // Params 3, eflags: 0x4
    // Checksum 0xa66123fb, Offset: 0x3a18
    // Size: 0x92, Type: dev
    function private function_e211887f5aad024a( x, y, color )
    {
        hudelem = newclienthudelem( self );
        hudelem.alignx = "<dev string:x2b6>";
        hudelem.aligny = "<dev string:x2bb>";
        hudelem.x = x;
        hudelem.y = y;
        hudelem.fontscale = 1;
        hudelem.color = color;
        return hudelem;
    }

    // Namespace supers_mp
    // Params 1, eflags: 0x4
    // Checksum 0x90954f3c, Offset: 0x3ab2
    // Size: 0x192, Type: dev
    function private function_e56bb265f7ba627d( slot )
    {
        current_points = getcurrentsuperpoints( slot );
        needed_points = getsuperpointsneeded( undefined, slot );
        dvar_value = getdvarint( @"hash_4d0613a9bb47526d", 0 );
        show_major = dvar_value == 1 || dvar_value == 3;
        show_minor = dvar_value == 2 || dvar_value == 3;
        
        if ( show_major && slot == #"default" )
        {
            if ( !self.var_6fa1a4c123445355 )
            {
                self.var_6fa1a4c123445355 = function_e211887f5aad024a( 30, 100, ( 1, 1, 0 ) );
            }
            
            self.var_6fa1a4c123445355 setdevtext( "<dev string:x2bf>" + current_points + "<dev string:x2ce>" + needed_points );
        }
        else if ( !show_major && self.var_6fa1a4c123445355 )
        {
            self.var_6fa1a4c123445355 setdevtext( "<dev string:x2d0>" );
        }
        
        if ( show_minor && slot == #"tactical" )
        {
            if ( !self.var_ce10c5967b0ab359 )
            {
                self.var_ce10c5967b0ab359 = function_e211887f5aad024a( 30, 120, ( 0, 1, 1 ) );
            }
            
            self.var_ce10c5967b0ab359 setdevtext( "<dev string:x2d1>" + current_points + "<dev string:x2ce>" + needed_points );
            return;
        }
        
        if ( !show_minor && self.var_ce10c5967b0ab359 )
        {
            self.var_ce10c5967b0ab359 setdevtext( "<dev string:x2d0>" );
        }
    }

#/

// Namespace supers_mp
// Params 2
// Checksum 0xf4601403, Offset: 0x3c4c
// Size: 0x70
function superpointschanged( slot, superpointsneeded )
{
    /#
        if ( getdvarint( @"hash_4d0613a9bb47526d", 0 ) )
        {
            function_e56bb265f7ba627d( slot );
        }
    #/
    
    if ( getcurrentsuperpoints( slot ) >= ( superpointsneeded ?? getsuperpointsneeded( undefined, slot ) ) )
    {
        superearned( slot );
    }
    
    updatesuperuiprogress( slot );
    updatesuperuistate( slot );
    function_1b82c2193d15ea65( slot );
}

// Namespace supers_mp
// Params 8
// Checksum 0x5d9049d5, Offset: 0x3cc4
// Size: 0x47a
function givesuperpoints( points, scoreevent, bypassdisable, pointsmultiplier, var_d73fefb7a81fcefc, var_aca8ef08dd5590be, slot, eventinfo )
{
    var_8a0d69408b6ccb02 = function_2041e16ed18271bc( slot );
    var_bcbb003851bd5742 = isdefined( self.var_760a3e04da86556f ) || var_8a0d69408b6ccb02;
    
    if ( ( game[ "isLaunchChunk" ] || !level.allowsupers ) && !var_bcbb003851bd5742 )
    {
        return;
    }
    
    if ( !function_31f00fe6e0334d03( slot, bypassdisable ) || function_cc252fb1315910e5( getcurrentsuper( slot ), slot ) )
    {
        return;
    }
    
    if ( eventinfo.var_3edd9547c2f1faad )
    {
        return;
    }
    
    assert( isdefined( points ) );
    
    if ( getdvarint( @"hash_eba0ef12e9c9260b", 0 ) && !bypassdisable )
    {
        return;
    }
    
    if ( var_8a0d69408b6ccb02 )
    {
        superinfo = getcurrentsuper( slot );
        
        if ( !superinfo.staticdata.bundle.var_63d091183ff3a2dc )
        {
            points = superinfo.var_78ab73ad3b93eef1;
        }
    }
    else if ( isdefined( scoreevent ) )
    {
        points = getsuperpointsforevent( scoreevent );
    }
    
    if ( isdefined( pointsmultiplier ) )
    {
        points *= pointsmultiplier;
    }
    
    var_631aa26a24f9312e = level.gamemodebundle.var_631aa26a24f9312e ?? 1;
    
    if ( isdefined( self.perks[ "specialty_faster_field_upgrade" ] ) && var_631aa26a24f9312e )
    {
        if ( isnumber( self.var_7f51fbc2a4951e75 ) )
        {
            points *= self.var_7f51fbc2a4951e75;
        }
        else
        {
            points *= getdvarfloat( @"perk_faster_field_upgrade_rate" );
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_d786003560132ad3" ) )
    {
        points = utility::callsharedfunc( #"zombie", #"hash_d786003560132ad3", points );
    }
    
    superinfo = getcurrentsuper( slot );
    
    if ( utility::issharedfuncdefined( #"skills", #"hash_a6980b8a3e3542b2" ) )
    {
        points = utility::callsharedfunc( #"skills", #"hash_a6980b8a3e3542b2", superinfo.staticdata.ref, points );
    }
    
    if ( scoreevent == #"time" )
    {
        modifiedpoints = points * level.superfastchargerate;
    }
    else if ( level.superglobals.givesuperonspawn || var_aca8ef08dd5590be )
    {
        modifiedpoints = points;
    }
    else if ( !var_aca8ef08dd5590be )
    {
        superpointsmod = level.var_8a3e2af27738ffdc[ superinfo.staticdata.ref ] ?? level.superpointsmod;
        modifiedpoints = points * superpointsmod;
    }
    
    if ( modifiedpoints <= 0 )
    {
        return;
    }
    
    if ( isdefined( scoreevent ) && scoreevent != #"time" )
    {
        if ( level.var_bed70a0c85276706 )
        {
            if ( isdefined( self.perks[ "specialty_faster_field_upgrade" ] ) && var_631aa26a24f9312e )
            {
                if ( modifiedpoints > level.var_26c61fbdbc9fc246 && level.var_26c61fbdbc9fc246 > 0 )
                {
                    modifiedpoints = level.var_26c61fbdbc9fc246;
                }
            }
            else if ( modifiedpoints > level.var_97b22765d09c99c7 && level.var_97b22765d09c99c7 > 0 )
            {
                modifiedpoints = level.var_97b22765d09c99c7;
            }
        }
    }
    
    if ( level.superglobals.givesuperonspawn )
    {
        superinfo.var_1bb9f740d1d85b2c = 1;
        skiprefill = 0;
    }
    else
    {
        skiprefill = issuperready( superinfo );
    }
    
    if ( !var_aca8ef08dd5590be )
    {
        if ( !isdefined( superinfo ) || skiprefill || superinfo.isinuse )
        {
            doovercharge = !isbrgamemode() || self.var_eba31f12191a731f;
            
            if ( isdefined( superinfo ) && isdefined( self.overclockcharge ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) && doovercharge )
            {
                function_1f9b6b3c1d1f1404( self.overclockcharge + modifiedpoints, undefined, slot );
            }
            
            updatesppm( points, 0, scoreevent );
            return;
        }
    }
    
    newpointtotal = min( modifiedpoints + superinfo.basepoints, getsuperpointsneeded( superinfo ) );
    setsuperbasepoints( newpointtotal, undefined, slot );
    updatesppm( points, 1, scoreevent );
}

// Namespace supers_mp
// Params 1
// Checksum 0xfce03fe0, Offset: 0x4146
// Size: 0x187
function function_1b82c2193d15ea65( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( player::isinkillcam() || !isalive( self ) )
    {
        self.var_84d4131840f94e48 = undefined;
        return;
    }
    
    if ( !isdefined( self.var_ad3d5ed8f39cd225 ) )
    {
        self.var_ad3d5ed8f39cd225 = 1;
    }
    
    pointsneeded = getsuperpointsneeded( superinfo );
    progress = 0;
    
    if ( superinfo.isinuse )
    {
        progress = getsuperuseuiprogress( slot );
    }
    else if ( function_cc252fb1315910e5( superinfo, slot ) )
    {
        super = self.pers[ "rechargeSupers" ][ slot ];
        
        if ( isdefined( super ) )
        {
            progress = clamp( 1 - super.rechargeremaining / super.rechargetime, 0, 1 );
        }
    }
    else if ( pointsneeded > 0 )
    {
        progress = clamp( getcurrentsuperbasepoints( slot ) / pointsneeded, 0, 1 );
    }
    
    var_778425f0a4e3a2fd = 0;
    
    if ( isdefined( self.overclockcharge ) )
    {
        if ( pointsneeded > 0 )
        {
            var_778425f0a4e3a2fd = clamp( self.overclockcharge / pointsneeded, 0, 1 );
        }
    }
    
    if ( self.var_ad3d5ed8f39cd225 > 0 )
    {
        codcasterprogress = progress + var_778425f0a4e3a2fd;
        self setplayersupermeterprogress( codcasterprogress );
    }
    
    self.var_84d4131840f94e48 = self.var_ad3d5ed8f39cd225;
}

// Namespace supers_mp
// Params 2
// Checksum 0x181de364, Offset: 0x42d5
// Size: 0x122
function function_7d55dcbfe177d86f( overclockprogress, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( !isdefined( self.overclockcharge ) )
    {
        return;
    }
    
    if ( player::isinkillcam() || !isalive( self ) )
    {
        self.var_8b8b3732177535fd = undefined;
        return;
    }
    
    pointsneeded = getsuperpointsneeded( superinfo );
    progress = 0;
    
    if ( pointsneeded > 0 )
    {
        progress = clamp( overclockprogress / pointsneeded, 0, 1 );
    }
    
    if ( !isdefined( self.var_8b8b3732177535fd ) || progress != self.var_8b8b3732177535fd )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_super_second_progress" );
        
        if ( omnvar )
        {
            self setclientomnvar( "ui_super_second_progress", progress );
        }
    }
    else if ( progress == self.var_8b8b3732177535fd )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_super_second_progress" );
        
        if ( omnvar )
        {
            self setclientomnvar( "ui_super_second_progress", self.var_8b8b3732177535fd );
        }
    }
    
    self.var_8b8b3732177535fd = progress;
}

// Namespace supers_mp
// Params 1
// Checksum 0x32c99648, Offset: 0x43ff
// Size: 0x11e
function updatesuperuiprogress( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( player::isinkillcam() || !isalive( self ) )
    {
        superinfo.oldprogress = undefined;
        return;
    }
    
    progress = 0;
    
    if ( superinfo.isinuse )
    {
        var_c2fb965c9cd3dc5c = superinfo.staticdata.var_c2fb965c9cd3dc5c;
        
        if ( var_c2fb965c9cd3dc5c == "ONUSE" )
        {
            progress = 0;
        }
        else
        {
            progress = getsuperuseuiprogress( slot );
        }
    }
    else
    {
        pointsneeded = getsuperpointsneeded( superinfo );
        
        if ( pointsneeded > 0 )
        {
            progress = clamp( getcurrentsuperbasepoints( slot ) / pointsneeded, 0, 1 );
        }
    }
    
    if ( !isdefined( superinfo.oldprogress ) || progress != superinfo.oldprogress || superinfo.var_1b8dba4c46fda7f8 )
    {
        thread function_cb3e288a8ed4df3e( progress, slot );
    }
    
    superinfo.oldprogress = progress;
}

// Namespace supers_mp
// Params 2
// Checksum 0xa136bf3c, Offset: 0x4525
// Size: 0x129
function handlesuperuistatechange( state, slot )
{
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    level endon( #"game_ended" );
    self notify( function_cc6f5a44b1441e16( slot, "super_state_change" ) );
    self endon( function_cc6f5a44b1441e16( slot, "super_state_change" ) );
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        supername = self.super.weaponobj.basename ?? "undefined";
        var_707c6849cd07dabe = function_cc6f5a44b1441e16( slot, "ui_super_state" ) ?? "undefined";
        assertmsg( "<dev string:x2e0>" + ( slot ?? "<dev string:x195>" ) + "<dev string:x319>" + state + "<dev string:x323>" + var_707c6849cd07dabe + "<dev string:x335>" + supername );
        return;
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "ui_super_state" ), state );
    omnvar = function_c1488fa73d55ae70( slot, "ui_super_state" );
    
    if ( omnvar )
    {
        self setclientomnvar( omnvar, state );
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xa82bbc58, Offset: 0x4656
// Size: 0x162
function function_cb3e288a8ed4df3e( progress, slot )
{
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    level endon( #"game_ended" );
    self notify( function_cc6f5a44b1441e16( slot, "super_progress_change" ) );
    self endon( function_cc6f5a44b1441e16( slot, "super_progress_change" ) );
    superinfo = getcurrentsuper( slot );
    var_99eeae77ad5b750c = superinfo.var_1b8dba4c46fda7f8;
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isconnected() )
    {
        supername = self.super.weaponobj.basename ?? "undefined";
        var_707c6849cd07dabe = function_cc6f5a44b1441e16( slot, "ui_super_state" ) ?? "undefined";
        assertmsg( "<dev string:x33f>" + ( slot ?? "<dev string:x195>" ) + "<dev string:x37b>" + progress + "<dev string:x323>" + var_707c6849cd07dabe + "<dev string:x335>" + supername );
        return;
    }
    
    if ( var_99eeae77ad5b750c )
    {
        thread function_7a4890453632df3f( slot, superinfo, progress );
        return;
    }
    
    if ( superinfo )
    {
        superinfo.oldprogress = progress;
    }
    
    omnvar = function_c1488fa73d55ae70( slot, "ui_super_progress" );
    
    if ( omnvar )
    {
        self setclientomnvar( omnvar, progress );
    }
}

// Namespace supers_mp
// Params 3, eflags: 0xc
// Checksum 0x3abac85, Offset: 0x47c0
// Size: 0xaa
function private function_7a4890453632df3f( slot, superinfo, progress )
{
    self notify( #"hash_f383ed897e712884" );
    self endon( #"hash_f383ed897e712884" );
    self endon( #"disconnect" );
    omnvar = function_c1488fa73d55ae70( slot, "ui_super_progress" );
    hackprogress = max( progress - 0.2, 0 );
    superinfo.oldprogress = hackprogress;
    self setclientomnvar( omnvar, hackprogress );
    wait 0.2;
    self setclientomnvar( omnvar, progress );
    superinfo.oldprogress = progress;
}

// Namespace supers_mp
// Params 1
// Checksum 0x13792290, Offset: 0x4872
// Size: 0x10f
function updatesuperuistate( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( !isdefined( superinfo.isactive ) )
    {
        return;
    }
    
    if ( player::isinkillcam() || !isalive( self ) )
    {
        superinfo.state = undefined;
        return;
    }
    
    oldstate = superinfo.state;
    state = 1;
    
    if ( issuperexpended() )
    {
        state = 4;
    }
    else if ( issuperready( superinfo ) )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_super_can_use" );
        
        if ( omnvar )
        {
            self setclientomnvar( omnvar, 1 );
        }
        
        state = 2;
    }
    else if ( issuperinuse( slot ) )
    {
        state = 3;
    }
    
    if ( !isdefined( oldstate ) || state != oldstate )
    {
        if ( state == 1 )
        {
            self notify( function_cc6f5a44b1441e16( slot, "super_use_charging" ) );
        }
        
        thread handlesuperuistatechange( state, slot );
    }
    
    superinfo.state = state;
}

// Namespace supers_mp
// Params 1
// Checksum 0x464825e4, Offset: 0x4989
// Size: 0x64
function watchforrespawn( slot )
{
    superinfo = getcurrentsuper( slot );
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    
    while ( true )
    {
        self waittill( #"spawned_player" );
        superinfo = getcurrentsuper( slot );
        givesuperweapon( superinfo );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xf670478b, Offset: 0x49f5
// Size: 0x48
function storesupercooldownforroundchange( slot )
{
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    flags::levelflagwait( "game_over" );
    
    if ( game[ "practiceRound" ] )
    {
        return;
    }
    
    storesuperpoints( slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0x1fcffbc5, Offset: 0x4a45
// Size: 0x5a
function handlespectating( slot )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    self waittill( #"joined_spectators" );
    
    if ( issuperinuse( slot ) )
    {
        waitframe();
    }
    
    thread clearsuper( 1, undefined, undefined, slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0xd5dca846, Offset: 0x4aa7
// Size: 0x7c
function handleteamchange( slot )
{
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    oldteam = self.team;
    self waittill( #"joined_team" );
    
    if ( issuperinuse( slot ) )
    {
        waitframe();
    }
    
    if ( self.team != oldteam )
    {
        self.currentfirstupgrade = undefined;
        thread clearsuper( 1, undefined, undefined, slot );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x94cef41, Offset: 0x4b2b
// Size: 0xb0
function handlepointdecay( slot )
{
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    level endon( #"game_ended" );
    superinfo = getcurrentsuper( slot );
    pointreduction = getdvarfloat( @"scr_super_decay_rate", 6 ) * level.framedurationseconds;
    
    while ( true )
    {
        if ( !issupercharging( slot ) )
        {
            waitframe();
            continue;
        }
        
        points = max( superinfo.extrapoints - pointreduction, 0 );
        setsuperextrapoints( points, undefined, slot );
        waitframe();
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xf1ad44f5, Offset: 0x4be3
// Size: 0x3ef
function superearned( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( superinfo.blueprintindex > 0 && superinfo.staticdata.bundle.genericblueprintlist.blueprints[ superinfo.blueprintindex - 1 ] )
    {
        genericblueprintname = superinfo.staticdata.bundle.genericblueprintlist.blueprints[ superinfo.blueprintindex - 1 ].genericblueprint;
        self function_24af687a8b7297f6( genericblueprintname );
    }
    
    var_25cebf2da5219905 = 0;
    
    if ( slot == #"tactical" )
    {
        ref = equipment_mp::getcurrentequipment( "secondary" );
        equipbundle = equipment_mp::function_c90a9aa89b223dd7( ref );
        
        if ( equipbundle.issuper )
        {
            assert( equipbundle.superref == superinfo.staticdata.ref, "<dev string:x388>" );
            maxammo = equipment_mp::getequipmentmaxammo( ref );
            var_85757b5f36975ee7 = superhasammousage( superinfo, slot );
            var_ba3c72e37a969131 = var_85757b5f36975ee7 ? maxammo : 1;
            equipment_mp::incrementequipmentslotammo( "secondary", var_ba3c72e37a969131 );
            newammo = equipment_mp::getequipmentammo( ref );
            
            if ( newammo < maxammo )
            {
                setsuperbasepoints( 0, 1, slot );
                var_25cebf2da5219905 = 1;
            }
        }
    }
    
    if ( function_cc252fb1315910e5( superinfo, slot ) )
    {
        var_25cebf2da5219905 = 1;
    }
    
    if ( slot != #"tactical" )
    {
        self setweaponammoclip( superinfo.weaponobj, 1 );
    }
    
    wasearned = !superinfo.wasrefunded && !superinfo.var_1bb9f740d1d85b2c;
    superinfo.var_1bb9f740d1d85b2c = undefined;
    
    if ( isbrgamemode() && slot != #"tactical" )
    {
        self.var_33129007db246c94 = 1;
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "super_ready" ), wasearned );
    
    if ( slot != #"tactical" )
    {
        thread function_a61d5327d4ea6657();
        thread watchforsuperhold();
    }
    
    if ( isdefined( superinfo.staticdata.useweapon ) )
    {
        function_68ef53f6862aedd9( slot );
    }
    
    if ( isdefined( superinfo.staticdata.ongivefunc ) )
    {
        self thread [[ superinfo.staticdata.ongivefunc ]]();
    }
    
    if ( wasearned )
    {
        if ( !isdefined( self.pers[ "supersEarned" ] ) )
        {
            self.pers[ "supersEarned" ] = 0;
        }
        
        self.pers[ "supersEarned" ]++;
        
        if ( !isdefined( self.challengedata ) )
        {
            self.challengedata = {};
        }
        
        self.challengedata.var_4be7ad89b5be7807 = superinfo.staticdata.ref;
        self notify( function_cc6f5a44b1441e16( slot, "super_earned" ) );
        
        if ( level.var_dc61a9eb0da4d624 ?? analyticslog::function_f432eaae9387e0e4() )
        {
            recordsuperearnedanalytics( superinfo );
        }
    }
    
    superinfo.numkills = 0;
    
    if ( level.var_dc61a9eb0da4d624 ?? analyticslog::function_f432eaae9387e0e4() )
    {
        superinfo.madeavailabletime = gettime();
        analyticslog::logevent_superearned( superinfo.madeavailabletime );
    }
    
    if ( !var_25cebf2da5219905 )
    {
        setsuperextrapoints( 0, 1, slot );
        setsuperbasepoints( getsuperpointsneeded( superinfo ), 1, slot );
    }
    
    if ( isdefined( self.matchdatalifeindex ) )
    {
        analyticslog::logevent_fieldupgradeearned( self, superinfo.staticdata.id );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xf4f2accc, Offset: 0x4fda
// Size: 0x11d
function watchforsuperusebegin( slot )
{
    if ( slot == #"tactical" )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( slot, "remove_super" ) );
    
    while ( true )
    {
        self waittill( #"special_weapon_fired", objweapon );
        var_77278bb457af652a = trysuperusebegin( objweapon, slot );
        
        if ( !var_77278bb457af652a )
        {
            if ( getdvarint( @"hash_c8b6c4e40dcae41e", 1 ) == 1 )
            {
                currentsuper = getcurrentsuper( slot );
                
                if ( isdefined( currentsuper ) && isdefined( currentsuper.staticdata ) && isdefined( currentsuper.weaponobj ) && isdefined( objweapon ) && objweapon.basename == currentsuper.weaponobj.basename )
                {
                    refundsuper( slot );
                }
            }
            else
            {
                refundsuper( slot );
            }
            
            continue;
        }
        
        self waittill( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x6cbac6e6, Offset: 0x50ff
// Size: 0xb9
function function_a61d5327d4ea6657()
{
    self endon( #"disconnect" );
    self endon( #"remove_super" );
    self endon( #"super_use_finished" );
    superinfo = getcurrentsuper();
    
    while ( true )
    {
        if ( self function_5a2599b2ccb2a751() )
        {
            if ( self superbuttonpressed() )
            {
                if ( !superinfo.var_8ed30a6619c8fe36 )
                {
                    msg = utility::waittill_any_return( "superWeaponForceHoldSucceed" );
                    superinfo.var_8ed30a6619c8fe36 = isdefined( msg );
                }
                else
                {
                    superinfo.var_8ed30a6619c8fe36 = 0;
                }
                
                while ( self superbuttonpressed() )
                {
                    waitframe();
                }
            }
            else
            {
                waitframe();
            }
            
            continue;
        }
        
        superinfo.var_8ed30a6619c8fe36 = 0;
        wait 0.25;
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x2ded150e, Offset: 0x51c0
// Size: 0x17e
function watchforsuperhold()
{
    self endon( #"disconnect" );
    self endon( #"remove_super" );
    self endon( #"super_use_finished" );
    self notify( #"watchforsuperhold" );
    self endon( #"watchforsuperhold" );
    
    while ( true )
    {
        superinfo = getcurrentsuper();
        
        if ( isdefined( self.var_a969a83671f32937 ) )
        {
            self.var_a969a83671f32937 = undefined;
        }
        
        self.var_a969a83671f32937 = spawnstruct();
        childthread function_9cfea33721fbadb6( superinfo );
        utility::waittill_any( "weapon_switch_started", "perkPackage_endThink", "grenade_pullback" );
        childthread function_73465821049cc6a8();
        childthread function_b0e29300977604bb();
        msg = utility::waittill_any_return( "superWeaponHoldFail", "superWeaponHoldSucceed" );
        
        if ( msg == "superWeaponHoldSucceed" )
        {
            if ( isdefined( superinfo ) && isdefined( superinfo.weaponobj ) )
            {
                objweapon = superinfo.weaponobj;
                
                if ( function_4a4cffccb8b0d51a() || self.var_a969a83671f32937.var_ab29f3ca53568cbd )
                {
                    if ( isdefined( superinfo.staticdata.var_a7ba5cee6855a3ad ) )
                    {
                        self thread [[ superinfo.staticdata.var_a7ba5cee6855a3ad ]]( objweapon );
                    }
                    
                    params = { #superinfo:superinfo, #player:self };
                    callback::callback( #"super_held", params );
                }
            }
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x321c6f51, Offset: 0x5346
// Size: 0x27
function function_4a4cffccb8b0d51a()
{
    if ( self function_5a2599b2ccb2a751() )
    {
        return self.super.var_8ed30a6619c8fe36;
    }
    
    return self superbuttonpressed();
}

// Namespace supers_mp
// Params 1
// Checksum 0xc6456091, Offset: 0x5375
// Size: 0xd0
function function_9cfea33721fbadb6( superinfo )
{
    self endon( #"hash_b69f9619ea3dd586" );
    
    while ( true )
    {
        self waittill( #"offhand_pullback", weapon );
        var_6890d8a9f8432e58 = 0;
        
        if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) && isdefined( weapon.basename ) )
        {
            var_1592d752b0ed8fa1 = superinfo.weaponobj.basename;
            
            if ( weapon.basename == var_1592d752b0ed8fa1 )
            {
                var_6890d8a9f8432e58 = 1;
            }
        }
        
        if ( var_6890d8a9f8432e58 )
        {
            self.var_a969a83671f32937.var_b9b4d161fedc9eef = gettime();
            self.var_a969a83671f32937.objweapon = weapon;
        }
        
        waitframe();
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xb2d8b9f0, Offset: 0x544d
// Size: 0x1f
function function_b0e29300977604bb()
{
    waitframe();
    childthread function_14a7d14a232ef57a();
    childthread function_69138bbe75925d6c();
    childthread function_9324a120620cf246();
    childthread function_7a14d7d4bc4a88d0();
}

// Namespace supers_mp
// Params 0
// Checksum 0x8ab2063a, Offset: 0x5474
// Size: 0x30
function function_7a14d7d4bc4a88d0()
{
    timeout_time = 10;
    utility::waittill_notify_or_timeout( "superWeaponForceHoldSucceed", timeout_time );
    wait 0.3;
    self notify( #"superWeaponHoldSucceed" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xda7659e6, Offset: 0x54ac
// Size: 0x3f
function function_14a7d14a232ef57a()
{
    self endon( #"superWeaponHoldFail" );
    self endon( #"superWeaponHoldSucceed" );
    self endon( #"superWeaponForceHoldSucceed" );
    self waittill( #"weapon_change" );
    self notify( #"superWeaponHoldFail" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x9039ab3a, Offset: 0x54f3
// Size: 0x33
function function_69138bbe75925d6c()
{
    self endon( #"superWeaponHoldFail" );
    self endon( #"superWeaponHoldSucceed" );
    self waittill( #"death" );
    self notify( #"superWeaponHoldFail" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xf420a459, Offset: 0x552e
// Size: 0x14d
function function_9324a120620cf246()
{
    self endon( #"superWeaponHoldFail" );
    self endon( #"superWeaponForceHoldSucceed" );
    self notify( #"hash_b69f9619ea3dd586" );
    objweapon = undefined;
    struct = self.var_a969a83671f32937;
    var_d68ba72ae682ea9 = 0;
    
    if ( isdefined( struct.var_b9b4d161fedc9eef ) )
    {
        if ( gettime() - struct.var_b9b4d161fedc9eef < 500 )
        {
            objweapon = struct.objweapon;
            var_d68ba72ae682ea9 = 1;
        }
    }
    else
    {
        self waittill( #"offhand_pullback", objweapon );
    }
    
    if ( !isdefined( objweapon ) )
    {
        self notify( #"superWeaponHoldFail" );
        return;
    }
    
    var_1ec8224aee967212 = 1;
    
    if ( !player::isreallyalive( self ) )
    {
        var_1ec8224aee967212 = 0;
    }
    
    super = getcurrentsuper();
    
    if ( isdefined( super ) && objweapon.basename != super.weaponobj.basename )
    {
        var_1ec8224aee967212 = 0;
    }
    
    if ( !val::get( "supers" ) )
    {
        var_1ec8224aee967212 = 0;
    }
    
    if ( var_1ec8224aee967212 )
    {
        if ( var_d68ba72ae682ea9 )
        {
            waitframe();
            self notify( #"superWeaponForceHoldSucceed" );
        }
        else
        {
            self notify( #"superWeaponHoldSucceed" );
        }
        
        return;
    }
    
    self notify( #"superWeaponHoldFail" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x34e0ddd9, Offset: 0x5683
// Size: 0x8b
function function_73465821049cc6a8()
{
    self notify( #"hash_3f7955853556adc9" );
    self endon( #"hash_3f7955853556adc9" );
    level endon( #"game_ended" );
    counter = 0;
    
    while ( function_4a4cffccb8b0d51a() )
    {
        self setclientomnvar( "ui_super_activation_button_held", 1 );
        
        if ( counter >= 0.75 )
        {
            self.var_a969a83671f32937.var_ab29f3ca53568cbd = 1;
            break;
        }
        
        counter += level.framedurationseconds;
        waitframe();
    }
    
    self setclientomnvar( "ui_super_activation_button_held", 0 );
}

// Namespace supers_mp
// Params 2
// Checksum 0x37163318, Offset: 0x5716
// Size: 0x86
function trysuperusebegin( objweapon, slot )
{
    if ( !player::isreallyalive( self ) )
    {
        return 0;
    }
    
    if ( isdefined( getcurrentsuper( slot ).staticdata.weaponname ) && objweapon.basename != getcurrentsuper( slot ).staticdata.weaponname )
    {
        return 0;
    }
    
    if ( self.var_b5bed2b7dafd7815 )
    {
        return 0;
    }
    
    return beginsuperuse( slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0x644102f1, Offset: 0x57a5
// Size: 0x726, Type: bool
function beginsuperuse( slot )
{
    self endon( #"disconnect" );
    superinfo = getcurrentsuper( slot );
    
    if ( superinfo.staticdata )
    {
        bundle = superinfo.staticdata.bundle;
    }
    
    self notify( function_cc6f5a44b1441e16( slot, "super_started" ) );
    gamelogic_mp::sethasdonecombat( self, 1 );
    telemetry_utils::function_8fab541f1654a751( superinfo.staticdata.ref );
    
    if ( superinfo.weaponobj.basename == "support_box_mp" )
    {
        self playlocalsound( "iw9_support_box_bring_up_plr_1" );
    }
    else if ( superinfo.weaponobj.basename == "tempv_mp" && soundexists( "iw9_mtx_tb_stim_activate_plr" ) )
    {
        self playsoundtoplayer( #"iw9_mtx_tb_stim_activate_plr", self );
        
        if ( isdefined( self.team ) && soundexists( "iw9_mtx_tb_stim_activate_npc" ) )
        {
            self playsoundtoteam( "iw9_mtx_tb_stim_activate_npc", self.team, self, self );
        }
    }
    
    if ( isdefined( superinfo ) && !superinfo.isinuse && !superinfo.staticdata.var_2584b4581346d6d1 )
    {
        var_1427b67aa86aa286 = self.inlaststand && !superinfo.staticdata.canuseinlaststand;
        function_2dccac3e12d95853( 1 );
        var_ea8325d2b8b272e8 = superinfo.staticdata.useweapon;
        
        if ( var_ea8325d2b8b272e8 )
        {
            var_82228a71c67e676f = 1;
            
            if ( self.var_56afaf49dab1548d )
            {
                return false;
            }
            
            [ var_82228a71c67e676f, useweapon ] = function_3149e635fc09575( superinfo, var_1427b67aa86aa286, slot );
            
            if ( var_82228a71c67e676f )
            {
                function_adad2f3472143f6a( superinfo.staticdata, useweapon, slot );
            }
        }
        else if ( var_1427b67aa86aa286 )
        {
            if ( !val::get_specific_id( "supers", "_group_laststand" ) )
            {
                var_1427b67aa86aa286 = 0;
            }
        }
        
        if ( ( !var_ea8325d2b8b272e8 || var_82228a71c67e676f ) && !var_1427b67aa86aa286 )
        {
            /#
                print::printgameaction( "<dev string:x3b7>" + superinfo.staticdata.ref, self );
            #/
            
            superweapon = function_6c912116c8af1159( superinfo ) ?? superinfo.weaponobj ?? superinfo.staticdata.objweapon;
            
            if ( isdefined( superweapon ) )
            {
                thread gamelogic_mp::threadedsetweaponstatbyname( superweapon, 1, "shots" );
            }
            
            if ( !isdefined( superinfo.staticdata.beginusefunc ) || self [[ superinfo.staticdata.beginusefunc ]]() )
            {
                if ( superinfo.staticdata.bundle.var_f9d8e5cb24dca7c2 )
                {
                    self playsoundevent( superinfo.staticdata.bundle.var_f9d8e5cb24dca7c2 );
                }
                
                function_2dccac3e12d95853( 0 );
                endonnotifications = [];
                endonnotifications[ 0 ] = "super_use_finished_lb";
                endonnotifications[ 1 ] = "super_switched";
                var_99e1c295ee659eb6 = 0;
                
                if ( slot == #"tactical" )
                {
                    ref = equipment_mp::getcurrentequipment( "secondary" );
                    equipbundle = equipment_mp::function_c90a9aa89b223dd7( ref );
                    
                    if ( equipbundle.issuper )
                    {
                        assert( equipbundle.superref == superinfo.staticdata.ref, "<dev string:x388>" );
                        maxammo = equipment_mp::getequipmentmaxammo( ref );
                        ammo = equipment_mp::getequipmentammo( ref );
                        var_99e1c295ee659eb6 = ammo < maxammo - 1;
                    }
                }
                
                var_dd3261b0d1394c00 = function_cc252fb1315910e5( superinfo, slot );
                
                if ( var_dd3261b0d1394c00 )
                {
                    function_1838b741d6675e2c( superinfo, slot );
                    var_99e1c295ee659eb6 = 1;
                }
                
                if ( !var_99e1c295ee659eb6 )
                {
                    setsuperbasepoints( 0, undefined, slot );
                    setsuperextrapoints( 0, undefined, slot );
                }
                
                setsuperisinuse( 1, slot );
                setsuperisactive( 1, slot );
                function_4638d756ccdfa46f( superinfo.staticdata, slot );
                
                if ( bundle.var_bab7f416b6f9542b && bundle.var_ad89baaa6b8ac5b8 > 0 )
                {
                    if ( !superinfo.remainingcharges )
                    {
                        function_6a2a50cbce896c7d( bundle.var_ad89baaa6b8ac5b8, slot );
                    }
                    
                    function_f8002b3eecad1760( slot );
                }
                
                if ( isbrgamemode() )
                {
                    self.var_33129007db246c94 = 0;
                }
                
                superinfo.allowrefund = superinfo.staticdata.graceperiod > 0 ? 1 : 0;
                superinfo.usestarttime = gettime();
                superinfo.usepercent = 1;
                
                if ( !var_dd3261b0d1394c00 )
                {
                    updatesuperuiprogress( slot );
                }
                
                function_d6ffc5c7abc5689( 1 );
                self notify( function_cc6f5a44b1441e16( slot, "super_use_started" ) );
                
                if ( isdefined( superinfo.staticdata.var_49661824f9845c52 ) )
                {
                    thread function_9432f5ebf987e7aa( slot );
                }
                
                if ( isdefined( superinfo.staticdata.reclaimfunc ) && bundle.var_67296742aaa265f9 )
                {
                    thread function_fa24f3dcd0584d92( slot );
                }
                
                function_902329bf76c382ef( slot );
                
                if ( isdefined( self.matchdatalifeindex ) )
                {
                    analyticslog::logevent_fieldupgradeactivated( self, superinfo.staticdata.id );
                }
                
                combatrecordsuperuse( superinfo.staticdata.ref );
                
                if ( level.codcasterenabled )
                {
                    self setspecialactive( 1 );
                    clientnum = self getentitynumber();
                    codcaster_utils::function_daf7fb7edb6acdbd( 3, clientnum, undefined );
                }
                
                if ( isdefined( self.var_f1e4d080692469de ) )
                {
                    self.var_f1e4d080692469de = undefined;
                }
                
                battlechatter_mp::function_f3ffc3fa6aa3a992( slot );
                params = spawnstruct();
                params.player = self;
                params.superinfo = superinfo;
                callback::callback( #"on_used_super", params );
                return true;
            }
            else
            {
                if ( function_cc252fb1315910e5( superinfo, slot ) )
                {
                    function_1838b741d6675e2c( superinfo, slot );
                }
                
                refundsuper( slot );
                function_2dccac3e12d95853( 0 );
                return false;
            }
        }
        else if ( var_ea8325d2b8b272e8 )
        {
            if ( var_82228a71c67e676f )
            {
                thread switchandtakesuperuseweapon( undefined, undefined, slot );
            }
            else
            {
                function_2dccac3e12d95853( 0 );
                
                if ( function_cc252fb1315910e5( superinfo, slot ) )
                {
                    function_1838b741d6675e2c( superinfo, slot );
                }
                else
                {
                    setsuperbasepoints( 0, undefined, slot );
                    setsuperextrapoints( 0, undefined, slot );
                }
                
                setsuperisinuse( 1, slot );
                superusefinished( 1, undefined, undefined, undefined, undefined, undefined, slot );
            }
        }
        
        if ( function_ec7e2ab9a462557b() )
        {
            function_2dccac3e12d95853( 0 );
        }
    }
    
    return false;
}

// Namespace supers_mp
// Params 3, eflags: 0x4
// Checksum 0x665a4c52, Offset: 0x5ed4
// Size: 0xf0
function private function_3149e635fc09575( superinfo, var_1427b67aa86aa286, slot )
{
    useweapon = function_6c912116c8af1159( superinfo );
    var_82228a71c67e676f = function_11fddb38e7512160( useweapon );
    
    if ( var_1427b67aa86aa286 )
    {
        var_82228a71c67e676f = 0;
    }
    else if ( var_82228a71c67e676f )
    {
        clipammo = function_9927ca332693e216( superinfo );
        stockammo = function_6b9d4ebfab10a956( superinfo );
        var_686ab1c37bca9979 = undefined;
        
        if ( superinfo.staticdata.var_b04dc4f3e9e1f24c )
        {
            useweapon = function_c0901f58a21692ee( superinfo, useweapon );
            var_686ab1c37bca9979 = 1;
        }
        
        var_82228a71c67e676f = trygiveuseweapon( useweapon, clipammo, stockammo, superinfo.staticdata.skipfirstraise, superinfo.staticdata.useimmediate, var_686ab1c37bca9979, slot );
    }
    
    return [ var_82228a71c67e676f, useweapon ];
}

// Namespace supers_mp
// Params 2
// Checksum 0x585b3f31, Offset: 0x5fcd
// Size: 0x9f
function function_4638d756ccdfa46f( staticdata, slot )
{
    if ( staticdata.var_3b02a37f9ab4242f )
    {
        thread function_d163e492964f1035( slot );
    }
    
    if ( staticdata.var_b1c59c047766624b )
    {
        thread function_9410896cdb56758d( slot );
    }
    
    if ( staticdata.var_dd8ff255774d56c7 )
    {
        thread function_a8273a34671d9ad9( slot );
    }
    
    if ( staticdata.var_980cf09f642fcf52 )
    {
        thread function_de73422373f37d50( slot );
    }
    
    if ( staticdata.var_68d8c680f1dea54f )
    {
        thread function_fcd582d47a050e55( slot );
    }
    
    if ( staticdata.var_380d432f91817bb2 )
    {
        thread function_d33b96cd112a2a8( slot );
    }
}

// Namespace supers_mp
// Params 3
// Checksum 0x31cac3cd, Offset: 0x6074
// Size: 0x69
function function_adad2f3472143f6a( staticdata, useweapon, slot )
{
    if ( staticdata.var_602e39dd9e151671 )
    {
        thread function_c848b9c65633180f( useweapon, slot );
    }
    
    if ( staticdata.var_98922bd78bbe0a12 )
    {
        thread function_50ec387011d88004( useweapon, slot );
        return;
    }
    
    if ( staticdata.var_baf4edb3e045bc5b )
    {
        thread function_1a650befde1a5d15( useweapon, slot );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xaaeaf256, Offset: 0x60e5
// Size: 0xc0
function function_11fddb38e7512160( useweapon )
{
    can_deploy_weapon = 1;
    
    if ( !useweapon.var_96197b173c565dab && self isswimunderwater() )
    {
        can_deploy_weapon = 0;
    }
    
    if ( !useweapon.var_2ccf79819a194301 && self function_fbf06f80548d841d() )
    {
        can_deploy_weapon = 0;
    }
    
    if ( !can_deploy_weapon && utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        key = utility::callsharedfunc( #"hud", #"hash_30cfbd3bcf7e335b" ) ?? %"mp/supers_unavailable";
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( key );
    }
    
    return can_deploy_weapon;
}

// Namespace supers_mp
// Params 1
// Checksum 0x14a5ec72, Offset: 0x61ae
// Size: 0xaa
function function_902329bf76c382ef( slot )
{
    if ( !issuperinuse( slot ) )
    {
        return;
    }
    
    superinfo = getcurrentsuper( slot );
    assert( isdefined( superinfo.staticdata.var_c2fb965c9cd3dc5c ), "<dev string:x3cc>" );
    var_c2fb965c9cd3dc5c = superinfo.staticdata.var_c2fb965c9cd3dc5c;
    
    if ( var_c2fb965c9cd3dc5c == "ONUSE" || var_c2fb965c9cd3dc5c == "TIME" )
    {
        thread updateusetimedecay( slot );
        return;
    }
    
    if ( var_c2fb965c9cd3dc5c == "AMMO" )
    {
        thread function_77b806821b63adfe( slot );
        return;
    }
    
    return;
}

// Namespace supers_mp
// Params 3
// Checksum 0x65f5cb11, Offset: 0x6260
// Size: 0xd1, Type: bool
function activatesuper( altmode, preventrefund, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( altmode ) )
    {
        altmode = 0;
    }
    
    assert( superinfo.isinuse, "<dev string:x42e>" );
    
    if ( altmode && isdefined( superinfo.staticdata.activatepenaltyalt ) )
    {
        reducesuperusepercent( superinfo.staticdata.activatepenaltyalt, preventrefund, undefined, slot );
    }
    else if ( isdefined( superinfo.staticdata.activatepenalty ) )
    {
        reducesuperusepercent( superinfo.staticdata.activatepenalty, preventrefund, undefined, slot );
    }
    
    return true;
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xfa71f7a, Offset: 0x633a
// Size: 0x40
function private function_c56286fb49be44aa( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !superinfo.staticdata.var_9fdae8aefe811c2a )
    {
        return 0;
    }
    
    return self ishanging();
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x6ff4aa7d, Offset: 0x6383
// Size: 0x41, Type: bool
function private function_60198225b0364aac( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !superinfo.staticdata.var_99afe05c38b6392c )
    {
        return false;
    }
    
    return player::isreviving();
}

// Namespace supers_mp
// Params 3
// Checksum 0x2e5b7728, Offset: 0x63cd
// Size: 0x9c
function function_9ac5eb9572fa3a0a( useweapon, newweapon, slot )
{
    if ( !function_c56286fb49be44aa( slot ) && !function_60198225b0364aac( slot ) && !issameweapon( useweapon, newweapon, 1 ) && newweapon != level.defaultknifestab && newweapon.basename != "iw9_lm_dblmg_execution_mp" && newweapon.basename != "iw9_gunless" && newweapon.basename != "none" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0xdc012522, Offset: 0x6471
// Size: 0xbe
function private function_c848b9c65633180f( superuseweapon, slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    while ( true )
    {
        self waittill( #"weapon_fired", firedweapon );
        
        if ( firedweapon != superuseweapon )
        {
            continue;
        }
        
        clipammo = self getweaponammoclip( superuseweapon );
        stockammo = self getweaponammostock( superuseweapon );
        currentammo = clipammo + stockammo;
        
        if ( currentammo == 0 )
        {
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
        }
    }
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0xa95bfccb, Offset: 0x6537
// Size: 0x8d
function private function_50ec387011d88004( superuseweapon, slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    while ( true )
    {
        self waittill( #"weapon_change", changedweapon );
        
        if ( !function_9ac5eb9572fa3a0a( superuseweapon, changedweapon ) )
        {
            continue;
        }
        
        superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
    }
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0x91bb3fa4, Offset: 0x65cc
// Size: 0xf2
function private function_1a650befde1a5d15( useweapon, slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    superinfo = getcurrentsuper( slot );
    
    if ( slot != #"tactical" )
    {
        childthread function_4b86fea42ff296ef( superinfo );
    }
    
    while ( true )
    {
        self waittill( #"special_weapon_fired" );
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.basename == useweapon.basename )
        {
            continue;
        }
        
        var_1427b67aa86aa286 = self.inlaststand && !superinfo.staticdata.canuseinlaststand;
        function_3149e635fc09575( superinfo, var_1427b67aa86aa286, slot );
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xe29706db, Offset: 0x66c6
// Size: 0x40
function private function_4b86fea42ff296ef( superinfo )
{
    while ( true )
    {
        self waittill( #"weapon_change", changedweapon );
        self setweaponammoclip( superinfo.weaponobj, 1 );
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x1670bff2, Offset: 0x670e
// Size: 0x60
function private function_d163e492964f1035( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    self waittill( #"swim_breathing_disabled_begin" );
    superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x15119439, Offset: 0x6776
// Size: 0x60
function private function_9410896cdb56758d( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    self waittill( #"swim_begin" );
    superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x85ea432f, Offset: 0x67de
// Size: 0x68
function private function_d33b96cd112a2a8( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    while ( true )
    {
        if ( self.ismutantinjection )
        {
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
        }
        
        waitframe();
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x2d687d94, Offset: 0x684e
// Size: 0x9e
function private function_a8273a34671d9ad9( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    while ( true )
    {
        waitframe();
        
        if ( player_utility::function_cb195d25060312a() )
        {
            self.var_699f73faca9beeb1 = 1;
            val::set( "super_driving_vehicle", "script_weapon_switch", 1 );
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
            self.var_699f73faca9beeb1 = undefined;
            val::reset( "super_driving_vehicle", "script_weapon_switch" );
        }
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xaa1fa56, Offset: 0x68f4
// Size: 0x9e
function private function_de73422373f37d50( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    while ( true )
    {
        waitframe();
        
        if ( player_utility::function_36e9830807a5007() )
        {
            self.var_699f73faca9beeb1 = 1;
            val::set( "super_passenger_vehicle", "script_weapon_switch", 1 );
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
            self.var_699f73faca9beeb1 = undefined;
            val::reset( "super_passenger_vehicle", "script_weapon_switch" );
        }
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xcdadc7dd, Offset: 0x699a
// Size: 0x68
function private function_fcd582d47a050e55( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    while ( true )
    {
        waitframe();
        
        if ( self.inlaststand )
        {
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
        }
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xde7f485f, Offset: 0x6a0a
// Size: 0x6f
function function_719fe414226610d0( slot, agent )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    
    while ( true )
    {
        waitframe();
        
        if ( !agent.maxhealth || !isalive( agent ) )
        {
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
        }
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x8dd22983, Offset: 0x6a81
// Size: 0xf7
function function_9927ca332693e216( superinfo )
{
    if ( utility::issharedfuncdefined( #"skills", #"hash_cff4503d5032d9d2" ) )
    {
        var_29672f4a17617f43 = utility::callsharedfunc( #"skills", #"hash_cff4503d5032d9d2", superinfo.staticdata.ref );
        
        if ( var_29672f4a17617f43 )
        {
            return var_29672f4a17617f43;
        }
    }
    
    if ( perkpackage::function_3cec82ba2ae6e1c3() )
    {
        clipammo = self.perkpackagedata.weaponclipammo[ superinfo.staticdata.ref ];
        self.super.var_af5bd93c7223b946 = clipammo;
        return clipammo;
    }
    
    if ( isdefined( superinfo.var_91cdf2de88e5a13a ) )
    {
        return superinfo.var_91cdf2de88e5a13a.clipammo;
    }
    
    return superinfo.staticdata.useweaponclipammo;
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xa18cf5f7, Offset: 0x6b81
// Size: 0x9d
function private function_6b9d4ebfab10a956( superinfo )
{
    if ( perkpackage::function_3cec82ba2ae6e1c3() )
    {
        stockammo = self.perkpackagedata.weaponstockammo[ superinfo.staticdata.ref ];
        self.super.var_c25aa4af3452dc6 = stockammo;
        return stockammo;
    }
    
    if ( isdefined( superinfo.var_91cdf2de88e5a13a ) )
    {
        return superinfo.var_91cdf2de88e5a13a.stockammo;
    }
    
    return superinfo.staticdata.useweaponstockammo;
}

// Namespace supers_mp
// Params 1
// Checksum 0x86ddd63, Offset: 0x6c27
// Size: 0xaf
function function_9432f5ebf987e7aa( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    
    while ( true )
    {
        waitframe();
        
        if ( isbot( self ) )
        {
            return;
        }
        
        if ( !function_b7237d45d4df0c9a( slot ) )
        {
            continue;
        }
        
        repeatresult = function_8047e8231c2e86b2( slot );
        
        if ( !repeatresult )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/supers_unavailable" );
            }
        }
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xc08d26dc, Offset: 0x6cde
// Size: 0x82, Type: bool
function function_b7237d45d4df0c9a( slot )
{
    if ( slot == #"tactical" )
    {
        return false;
    }
    
    success = function_99c6158d329ad896( slot );
    superinfo = getcurrentsuper( slot );
    
    if ( !success )
    {
        return false;
    }
    
    if ( !issuperinuse( slot ) )
    {
        return false;
    }
    
    if ( function_f863d9ef10bf403f( slot ) && !superinfo.staticdata.var_161740a20792292 )
    {
        return false;
    }
    
    return true;
}

// Namespace supers_mp
// Params 1
// Checksum 0x952e14e7, Offset: 0x6d69
// Size: 0x53, Type: bool
function function_99c6158d329ad896( slot )
{
    childthread function_63dcc4ff1dda9316( slot );
    childthread function_ce731345fd5bb066( slot );
    childthread function_8431cb348bce2a35( slot );
    self waittill( function_cc6f5a44b1441e16( slot, "superRepeatUse" ), msg );
    thread function_b2c265eac24778f2();
    return msg == "success";
}

// Namespace supers_mp
// Params 0
// Checksum 0x9a53c8db, Offset: 0x6dc5
// Size: 0x52
function function_b2c265eac24778f2()
{
    self notifyonplayercommandremove( "tacButtonPress", "+smoke" );
    self notifyonplayercommandremove( "tacButtonPress", "+actionslot 1" );
    self notifyonplayercommandremove( "fragButtonPress", "+frag" );
    self notifyonplayercommandremove( "fragButtonPress", "+equip_toggle_throw" );
    self notifyonplayercommandremove( "repeatUseActivate", "+special" );
}

// Namespace supers_mp
// Params 1
// Checksum 0x5f535272, Offset: 0x6e1f
// Size: 0x4e
function function_63dcc4ff1dda9316( slot )
{
    self endon( function_cc6f5a44b1441e16( slot, "superRepeatUse" ) );
    self notifyonplayercommand( "repeatUseActivate", "+special" );
    self waittill( #"repeatuseactivate" );
    self notify( function_cc6f5a44b1441e16( slot, "superRepeatUse" ), "success" );
}

// Namespace supers_mp
// Params 1
// Checksum 0xa18678c2, Offset: 0x6e75
// Size: 0xa2
function function_ce731345fd5bb066( slot )
{
    self endon( function_cc6f5a44b1441e16( slot, "superRepeatUse" ) );
    self notifyonplayercommand( "tacButtonPress", "+smoke" );
    self notifyonplayercommand( "fragButtonPress", "+frag" );
    var_ae907018b4147d20 = [ "tacButtonPress", "fragButtonPress" ];
    thread function_59e580eaf8854be2( var_ae907018b4147d20, [ "superRepeatUse" ], 0.75, slot );
    self waittill( function_cc6f5a44b1441e16( slot, "controllerSuperPress" ), msg );
    self notify( function_cc6f5a44b1441e16( slot, "superRepeatUse" ), msg );
}

// Namespace supers_mp
// Params 1
// Checksum 0x386df1b, Offset: 0x6f1f
// Size: 0xa2
function function_8431cb348bce2a35( slot )
{
    self endon( function_cc6f5a44b1441e16( slot, "superRepeatUse" ) );
    self notifyonplayercommand( "tacButtonPress", "+actionslot 1" );
    self notifyonplayercommand( "fragButtonPress", "+equip_toggle_throw" );
    var_ae907018b4147d20 = [ "tacButtonPress", "fragButtonPress" ];
    thread function_59e580eaf8854be2( var_ae907018b4147d20, [ "superRepeatUse" ], 0.75, slot );
    self waittill( function_cc6f5a44b1441e16( slot, "controllerSuperPress" ), msg );
    self notify( function_cc6f5a44b1441e16( slot, "superRepeatUse" ), msg );
}

// Namespace supers_mp
// Params 4
// Checksum 0x965709a8, Offset: 0x6fc9
// Size: 0x1fb
function function_59e580eaf8854be2( var_ab9ec058017ae13, var_2d0993b24a32cf26, time, slot )
{
    level endon( #"game_ended" );
    ent = spawnstruct();
    ent.threads = 0;
    
    foreach ( endonnotify in var_2d0993b24a32cf26 )
    {
        self endon( endonnotify );
    }
    
    foreach ( stringnotify in var_ab9ec058017ae13 )
    {
        childthread utility::waittill_string_no_endon_death( stringnotify, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        if ( ent.threads == 1 )
        {
            if ( isdefined( time ) )
            {
                ent childthread utility::timeout_struct( time );
                ent waittill( #"returned", msg );
                
                if ( msg == "timeout" )
                {
                    self notify( function_cc6f5a44b1441e16( slot, "controllerSuperPress" ), "timeout" );
                }
                else
                {
                    self notify( function_cc6f5a44b1441e16( slot, "controllerSuperPress" ), "success" );
                }
                
                ent.threads--;
            }
            
            continue;
        }
        
        ent waittill( #"returned", message );
        ent.threads--;
    }
    
    ent notify( #"die" );
}

// Namespace supers_mp
// Params 1
// Checksum 0x240f7dc1, Offset: 0x71cc
// Size: 0xc6
function function_8047e8231c2e86b2( slot )
{
    if ( !player::isreallyalive( self ) )
    {
        return 0;
    }
    
    if ( !val::get( "supers" ) )
    {
        return 0;
    }
    
    if ( utility::isusingremote() )
    {
        return 0;
    }
    
    if ( self.oob )
    {
        return 0;
    }
    
    if ( self isonladder() )
    {
        return 0;
    }
    
    if ( self ismantling() )
    {
        return 0;
    }
    
    if ( !self isonground() )
    {
        if ( self isparachuting() || self isinfreefall() )
        {
            return 0;
        }
    }
    
    superinfo = getcurrentsuper( slot );
    repeatresult = 0;
    
    if ( isdefined( superinfo.staticdata.var_49661824f9845c52 ) )
    {
        repeatresult = [[ superinfo.staticdata.var_49661824f9845c52 ]]();
    }
    
    return repeatresult;
}

// Namespace supers_mp
// Params 1
// Checksum 0x88539ead, Offset: 0x729b
// Size: 0xd1
function function_fa24f3dcd0584d92( slot )
{
    self notify( #"hash_f1d81b2071745f65" );
    self endon( #"hash_f1d81b2071745f65" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( level.allowsupers )
    {
        self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    }
    
    superinfo = getcurrentsuper( slot );
    superinfo.var_611bd12db8bb4cbe = 0;
    
    while ( true )
    {
        self waittill( function_cc6f5a44b1441e16( slot, "super_reclaimed" ), super, player );
        super.owner = player;
        player function_dfed18bd848c4169( super, superinfo );
        
        if ( superinfo )
        {
            superinfo.var_611bd12db8bb4cbe = 0;
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x4dba5808, Offset: 0x7374
// Size: 0x1f
function function_867458c6f9c3d1f5()
{
    self makeunusable();
    self notify( function_cc6f5a44b1441e16( self.slot, "disabled_super_reclaim" ) );
}

// Namespace supers_mp
// Params 2
// Checksum 0x24331e66, Offset: 0x739b
// Size: 0x159
function function_dfed18bd848c4169( super, superinfo )
{
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( superinfo.var_611bd12db8bb4cbe )
    {
        return;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        return 0;
    }
    
    if ( !val::get( "supers" ) )
    {
        return 0;
    }
    
    if ( utility::isusingremote() )
    {
        return 0;
    }
    
    if ( self.oob )
    {
        return 0;
    }
    
    if ( self isonladder() )
    {
        return 0;
    }
    
    if ( self ismantling() )
    {
        return 0;
    }
    
    if ( !self isonground() )
    {
        if ( self isparachuting() || self isinfreefall() )
        {
            return 0;
        }
    }
    
    superinfo.var_611bd12db8bb4cbe = 1;
    superref = superinfo.staticdata.ref;
    reclaimresult = 0;
    
    if ( isdefined( level.superglobals.staticsuperdata[ superref ].reclaimfunc ) )
    {
        reclaimresult = [[ level.superglobals.staticsuperdata[ superref ].reclaimfunc ]]( super );
        
        if ( reclaimresult )
        {
            callbackparams = { #supername:superref, #player:self };
            callback::callback( #"super_reclaimed", callbackparams );
        }
    }
    
    self.deployedsuper = undefined;
    return reclaimresult;
}

// Namespace supers_mp
// Params 0
// Checksum 0xfcc89d62, Offset: 0x74fd
// Size: 0x130
function function_484ca0a545e40e20()
{
    super = self;
    
    if ( isdefined( super.owner.superdurability ) )
    {
        super.damagetaken = super.owner.superdurability;
        super.timeremaining = super.owner.var_ce99ca57a38ec2a0;
        
        if ( isdefined( super.owner.superammo ) )
        {
            super.ammo = super.owner.superammo;
        }
    }
    else
    {
        super.damagetaken = 0;
        super.timeremaining = super.timeout;
        
        if ( isdefined( super.ammo ) )
        {
            super.ammo = super.ammo;
        }
    }
    
    super.owner.superdurability = undefined;
    super.owner.var_ce99ca57a38ec2a0 = undefined;
    super.owner.superammo = undefined;
}

// Namespace supers_mp
// Params 2
// Checksum 0xe6ce0df9, Offset: 0x7635
// Size: 0x4e
function function_5c28588f733c7388( timeremaining, totallifetime )
{
    superowner = self;
    var_934dd764f4a9e210 = isdefined( timeremaining ) ? round( timeremaining / totallifetime, 0.1 ) : 1;
    superowner thread function_cb3e288a8ed4df3e( var_934dd764f4a9e210 );
}

// Namespace supers_mp
// Params 5, eflags: 0x4
// Checksum 0x9799326b, Offset: 0x768b
// Size: 0xee
function private function_dc6a731f53d33a2( slot, equipmentref, var_cb3150b79c09643f, var_ad5ed056cc5bb841, var_552fb1337ddf8d06 )
{
    assert( slot == #"tactical" );
    currentammo = equipment_mp::getequipmentammo( equipmentref );
    var_edb241331f332a1c = ( currentammo - var_ad5ed056cc5bb841 ) * var_552fb1337ddf8d06;
    callbackparams = { #var_edb241331f332a1c:var_edb241331f332a1c, #currentammo:currentammo, #var_ad5ed056cc5bb841:var_ad5ed056cc5bb841, #slot:slot, #superref:getsuperref( slot ) };
    callback::callback( #"hash_ffc49165b0271655", callbackparams );
    currentammo = equipment_mp::getequipmentammo( equipmentref );
    var_edb241331f332a1c = ( var_ad5ed056cc5bb841 - currentammo ) * var_552fb1337ddf8d06;
    
    if ( var_edb241331f332a1c > 0 )
    {
        thread function_e39fe9f7f0484f10( var_cb3150b79c09643f, var_cb3150b79c09643f, var_edb241331f332a1c, slot );
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x1b76abfa, Offset: 0x7781
// Size: 0x103
function private function_cb0003c953cde62f( slot )
{
    assert( slot == #"tactical" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    var_302cf72dfb8a97f8 = equipment_mp::getcurrentequipment( "secondary" );
    var_9acafc27edfcfdbc = equipment_mp::getweaponfromequipmentref( var_302cf72dfb8a97f8 );
    maxammo = equipment_mp::getequipmentmaxammo( var_302cf72dfb8a97f8 );
    var_552fb1337ddf8d06 = 1 / maxammo;
    function_dc6a731f53d33a2( slot, var_302cf72dfb8a97f8, var_9acafc27edfcfdbc, maxammo, var_552fb1337ddf8d06 );
    
    for ( var_ad5ed056cc5bb841 = equipment_mp::getequipmentammo( var_302cf72dfb8a97f8 ); true ; var_ad5ed056cc5bb841 = equipment_mp::getequipmentammo( var_302cf72dfb8a97f8 ) )
    {
        self waittill( #"offhand_fired", firedoffhand );
        
        if ( firedoffhand == var_9acafc27edfcfdbc )
        {
            function_dc6a731f53d33a2( slot, var_302cf72dfb8a97f8, var_9acafc27edfcfdbc, var_ad5ed056cc5bb841, var_552fb1337ddf8d06 );
        }
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xe650bbe7, Offset: 0x788c
// Size: 0x1aa
function function_77b806821b63adfe( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    
    if ( slot == #"tactical" )
    {
        thread function_cb0003c953cde62f( slot );
        return;
    }
    
    superinfo = getcurrentsuper( slot );
    usinguseweapon = isdefined( superinfo.staticdata.useweapon );
    useweaponclipammo = superinfo.staticdata.useweaponclipammo;
    var_e2be0686d1eeb904 = superinfo.staticdata.weaponammo;
    
    if ( ( !usinguseweapon || useweaponclipammo < 1 ) && var_e2be0686d1eeb904 <= 1 )
    {
        return;
    }
    
    weaponnotify = "weapon_fired";
    
    if ( !usinguseweapon )
    {
        weaponnotify = "offhand_fired";
    }
    
    var_4588ed7d75a32bf6 = usinguseweapon ? function_6c912116c8af1159( superinfo ) : superinfo.weaponobj;
    
    if ( superinfo.staticdata.var_44a1d1cf563489e4 )
    {
        allowsuperweaponstow( slot );
    }
    
    var_4282a11eba938eca = function_88ef58d2fa3e72c0( superinfo, usinguseweapon );
    bulletsfired = function_e33f44960be55a1f( usinguseweapon, slot );
    thread function_e39fe9f7f0484f10( var_4588ed7d75a32bf6, var_4588ed7d75a32bf6, var_4282a11eba938eca * bulletsfired + 0.001, slot );
    
    while ( true )
    {
        self waittill( weaponnotify, firedweapon );
        thread function_e39fe9f7f0484f10( firedweapon, var_4588ed7d75a32bf6, var_4282a11eba938eca, slot );
    }
}

// Namespace supers_mp
// Params 4
// Checksum 0x619ad05a, Offset: 0x7a3e
// Size: 0xd5
function function_e39fe9f7f0484f10( firedweapon, superweapon, percentreduced, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superweapon ) )
    {
        if ( !( isdefined( superinfo ) && isdefined( superinfo.staticdata ) ) )
        {
            return;
        }
        
        superweapon = function_6c912116c8af1159( superinfo ) ?? superinfo.weaponobj;
    }
    
    if ( isweapon( firedweapon ) )
    {
        firedweapon = firedweapon.basename;
    }
    
    if ( isweapon( superweapon ) )
    {
        superweapon = superweapon.basename;
    }
    
    if ( firedweapon == superweapon )
    {
        function_7d5785345fab2710( slot );
        reducesuperusepercent( percentreduced, undefined, undefined, slot );
        updatesuperuiprogress( slot );
        updatesuperuistate( slot );
        function_1b82c2193d15ea65( slot );
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xfc060a28, Offset: 0x7b1b
// Size: 0x85
function function_e33f44960be55a1f( usinguseweapon, slot )
{
    if ( !usinguseweapon )
    {
        return 1;
    }
    
    ammo = function_9e6dc95ca52d8e3f( slot );
    maxammo = getcurrentsuper( slot ).staticdata.useweaponstockammo + getcurrentsuper( slot ).staticdata.useweaponclipammo;
    ammoused = maxammo - ammo;
    return ammoused;
}

// Namespace supers_mp
// Params 0
// Checksum 0x16cfdc50, Offset: 0x7ba9
// Size: 0x2e
function function_d22e4b5721a063eb()
{
    if ( !isdefined( self.var_3bd6d05c20649e30 ) )
    {
        self.var_3bd6d05c20649e30 = [];
    }
    
    self.var_3bd6d05c20649e30[ self.var_3bd6d05c20649e30.size ] = 0;
}

// Namespace supers_mp
// Params 1
// Checksum 0x47fddde, Offset: 0x7bdf
// Size: 0x94
function function_68ef53f6862aedd9( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo.var_91cdf2de88e5a13a ) )
    {
        superinfo.var_91cdf2de88e5a13a = spawnstruct();
    }
    
    superinfo.var_91cdf2de88e5a13a.clipammo = superinfo.staticdata.useweaponclipammo;
    superinfo.var_91cdf2de88e5a13a.stockammo = superinfo.staticdata.useweaponstockammo;
}

// Namespace supers_mp
// Params 3
// Checksum 0x96480888, Offset: 0x7c7b
// Size: 0x1be
function function_b8c330b10d1729bb( ammo, type, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( superinfo.staticdata.ref, #"setammo" ) )
    {
        self [[ utility::getsharedfunc( superinfo.staticdata.ref, #"setammo" ) ]]( ammo );
    }
    
    if ( isdefined( self.var_3bd6d05c20649e30 ) )
    {
        currentindex = function_e48058725c0c163a();
        
        if ( isdefined( currentindex ) )
        {
            self.var_3bd6d05c20649e30[ currentindex ] = ammo;
        }
    }
    
    ammostruct = superinfo.var_91cdf2de88e5a13a;
    
    if ( !isdefined( ammostruct ) )
    {
        return;
    }
    
    useweapon = function_6c912116c8af1159( superinfo );
    
    if ( !isdefined( useweapon ) )
    {
        return;
    }
    
    if ( !isdefined( type ) )
    {
        type = "all";
    }
    
    maxclipammo = weaponclipsize( useweapon );
    remainder = 0;
    
    if ( type == "clip" || type == "all" )
    {
        if ( ammo > maxclipammo )
        {
            remainder = ammo - maxclipammo;
            ammo = maxclipammo;
        }
        
        ammostruct.clipammo = ammo;
    }
    
    if ( type == "stock" )
    {
        ammostruct.stockammo = ammo;
        return;
    }
    
    if ( type == "clip" )
    {
        ammostruct.stockammo += remainder;
        return;
    }
    
    if ( type == "all" )
    {
        ammostruct.stockammo = remainder;
        return;
    }
    
    assert( 0, "<dev string:x471>" );
}

// Namespace supers_mp
// Params 1
// Checksum 0x36267c32, Offset: 0x7e41
// Size: 0xad, Type: bool
function isusingsuperweapon( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return false;
    }
    
    hasammostruct = isdefined( superinfo.var_91cdf2de88e5a13a );
    hasammocallbacks = isdefined( superinfo.staticdata ) && utility::issharedfuncdefined( superinfo.staticdata.ref, #"getammo" ) && utility::issharedfuncdefined( superinfo.staticdata.ref, #"setammo" );
    return hasammostruct || hasammocallbacks;
}

// Namespace supers_mp
// Params 1
// Checksum 0x1ed978ce, Offset: 0x7ef7
// Size: 0x52
function function_e9399f7a98e27919( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return 0;
    }
    
    ammostruct = superinfo.var_91cdf2de88e5a13a;
    
    if ( !isdefined( ammostruct ) )
    {
        return 0;
    }
    
    return ammostruct.clipammo;
}

// Namespace supers_mp
// Params 1
// Checksum 0x1921f38b, Offset: 0x7f52
// Size: 0x52
function function_fa89e20fdbd5df53( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return 0;
    }
    
    ammostruct = superinfo.var_91cdf2de88e5a13a;
    
    if ( !isdefined( ammostruct ) )
    {
        return 0;
    }
    
    return ammostruct.stockammo;
}

// Namespace supers_mp
// Params 1
// Checksum 0x89462478, Offset: 0x7fad
// Size: 0xbd
function function_9e6dc95ca52d8e3f( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return 0;
    }
    
    if ( isdefined( superinfo.staticdata ) && utility::issharedfuncdefined( superinfo.staticdata.ref, #"getammo" ) )
    {
        return self [[ utility::getsharedfunc( superinfo.staticdata.ref, #"getammo" ) ]]();
    }
    
    ammostruct = superinfo.var_91cdf2de88e5a13a;
    
    if ( !isdefined( ammostruct ) )
    {
        return 0;
    }
    
    return ammostruct.stockammo + ammostruct.clipammo;
}

// Namespace supers_mp
// Params 1
// Checksum 0x481048ac, Offset: 0x8073
// Size: 0x1c, Type: bool
function function_80e360decf364829( superindex )
{
    return self.var_3bd6d05c20649e30[ superindex ] ?? undefined;
}

// Namespace supers_mp
// Params 2
// Checksum 0x8a9a20d8, Offset: 0x8098
// Size: 0x50
function function_78d95dc7f8d14c64( superindex, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    superinfo.var_91cdf2de88e5a13a = undefined;
    
    if ( !isdefined( superindex ) )
    {
        return;
    }
    
    self.var_3bd6d05c20649e30[ superindex ] = undefined;
}

// Namespace supers_mp
// Params 1
// Checksum 0x33bd2233, Offset: 0x80f0
// Size: 0x91
function function_7d5785345fab2710( slot )
{
    superinfo = getcurrentsuper( slot );
    useweapon = function_6c912116c8af1159( superinfo );
    
    if ( !isdefined( useweapon ) )
    {
        return;
    }
    
    if ( superinfo.staticdata.var_b04dc4f3e9e1f24c )
    {
        useweapon = function_c0901f58a21692ee( superinfo, useweapon );
    }
    
    clipammo = self getweaponammoclip( useweapon );
    stockammo = self getweaponammostock( useweapon );
    function_b8c330b10d1729bb( clipammo + stockammo, "all", slot );
}

// Namespace supers_mp
// Params 2
// Checksum 0xd84dc113, Offset: 0x8189
// Size: 0x93
function function_2ec8bb8170acceb9( newammo, slot )
{
    var_b5760b81c1db982e = function_e48058725c0c163a();
    
    if ( isdefined( var_b5760b81c1db982e ) )
    {
        callbackparams = { #newammo:newammo, #oldammo:self.var_3bd6d05c20649e30[ var_b5760b81c1db982e ], #superinfo:getcurrentsuper( slot ), #player:self };
        callback::callback( #"super_ammo_used", callbackparams );
        self.var_3bd6d05c20649e30[ var_b5760b81c1db982e ] = newammo;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x5eac98c5, Offset: 0x8224
// Size: 0x75
function function_5edde74ac0c929eb( superinfo )
{
    if ( isdefined( superinfo.staticdata.var_5124e8da6c8c548a ) )
    {
        usetime = self [[ superinfo.staticdata.var_5124e8da6c8c548a ]]( superinfo );
        
        if ( isdefined( usetime ) )
        {
            return usetime;
        }
        else
        {
            assertmsg( "<dev string:x4c2>" );
        }
    }
    
    return function_b302d192481449e7( superinfo.staticdata );
}

// Namespace supers_mp
// Params 1
// Checksum 0x8a711537, Offset: 0x82a2
// Size: 0x69
function function_b302d192481449e7( var_49dab4db2a5b9f23 )
{
    if ( utility::issharedfuncdefined( #"skills", #"hash_2ae7f8231121f66c" ) )
    {
        usetime = utility::callsharedfunc( #"skills", #"hash_2ae7f8231121f66c", var_49dab4db2a5b9f23.ref );
        
        if ( usetime )
        {
            return usetime;
        }
    }
    
    return var_49dab4db2a5b9f23.usetime;
}

// Namespace supers_mp
// Params 1
// Checksum 0xa256f8eb, Offset: 0x8314
// Size: 0x17d
function updateusetimedecay( slot )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    self endon( function_cc6f5a44b1441e16( slot, "unset_super" ) );
    superinfo = getcurrentsuper( slot );
    var_c2fb965c9cd3dc5c = superinfo.staticdata.var_c2fb965c9cd3dc5c;
    
    if ( !superhastimedusage( superinfo ) )
    {
        waitframe();
        
        if ( var_c2fb965c9cd3dc5c == "ONUSE" )
        {
            superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
        }
        
        return;
    }
    
    var_d7b80a5bef393fd5 = function_5edde74ac0c929eb( superinfo );
    
    while ( true )
    {
        waitframe();
        
        if ( isdefined( superinfo.staticdata.usedelay ) )
        {
            usedtime = gettime() - superinfo.usestarttime;
            
            if ( usedtime < superinfo.staticdata.usedelay )
            {
                continue;
            }
        }
        
        percentreduction = level.framedurationseconds / var_d7b80a5bef393fd5;
        
        if ( function_8d1504409d190469( slot ) )
        {
            percentreduction = 0;
        }
        
        var_55af697e0e35662a = function_73cd30ebdbeeadab( superinfo ) ?? 0;
        percentaddition = var_55af697e0e35662a / var_d7b80a5bef393fd5;
        reducesuperusepercent( percentreduction - percentaddition, undefined, undefined, slot );
        updatesuperuiprogress( slot );
        updatesuperuistate( slot );
        function_1b82c2193d15ea65( slot );
    }
}

// Namespace supers_mp
// Params 4
// Checksum 0xabe3399d, Offset: 0x8499
// Size: 0xa5
function reducesuperusepercent( percentoff, preventrefund, var_d9427e066f7fe5fc, slot )
{
    superinfo = getcurrentsuper( slot );
    assert( superinfo.isinuse, "<dev string:x4fd>" );
    superinfo.usepercent = clamp( superinfo.usepercent - percentoff, 0, 1 );
    
    if ( preventrefund )
    {
        superinfo.allowrefund = 0;
    }
    
    if ( !isdefined( var_d9427e066f7fe5fc ) || var_d9427e066f7fe5fc == 0 )
    {
        superusedurationupdated( slot );
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xb14b25dc, Offset: 0x8546
// Size: 0x5f
function function_1c604c2b23642f2a( percentage, slot )
{
    superinfo = getcurrentsuper( slot );
    var_f8a511b25db931a4 = superinfo.usepercent + percentage;
    superinfo.usepercent = clamp( var_f8a511b25db931a4, 0, 1 );
    return var_f8a511b25db931a4;
}

// Namespace supers_mp
// Params 2
// Checksum 0xbfe38337, Offset: 0x85ae
// Size: 0x7e
function function_55f1ba3202014e0b( seconds, slot )
{
    superinfo = getcurrentsuper( slot );
    maxseconds = function_5edde74ac0c929eb( superinfo );
    
    if ( !isdefined( seconds ) )
    {
        return 0;
    }
    
    if ( seconds <= 0 )
    {
        return 0;
    }
    
    if ( seconds > maxseconds )
    {
        seconds = maxseconds;
    }
    
    percentage = 0;
    
    if ( maxseconds > 0 )
    {
        percentage = seconds / maxseconds;
    }
    
    function_1c604c2b23642f2a( percentage, slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0x3c92101b, Offset: 0x8634
// Size: 0x52
function resetsuperusepercent( slot )
{
    superinfo = getcurrentsuper( slot );
    assert( superinfo.isinuse, "<dev string:x53b>" );
    superinfo.usepercent = 1;
    superusedurationupdated( slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0xf30638a9, Offset: 0x868e
// Size: 0xdb
function superusedurationupdated( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( superinfo.usepercent <= superinfo.staticdata.bundle.var_816962e221e0174f && !self.var_8c7b4c1fd17706cc )
    {
        if ( superinfo.staticdata.bundle.var_fe26504c3ea31d5b )
        {
            self playsoundevent( superinfo.staticdata.bundle.var_fe26504c3ea31d5b );
            self.var_8c7b4c1fd17706cc = 1;
        }
    }
    
    if ( superinfo.usepercent <= 0 )
    {
        self.var_8c7b4c1fd17706cc = undefined;
        superusefinished( undefined, undefined, undefined, undefined, undefined, undefined, slot );
    }
}

// Namespace supers_mp
// Params 7
// Checksum 0x8d1de28c, Offset: 0x8771
// Size: 0x60e
function superusefinished( forcerefund, fromdeath, var_320ffc6ef12e2e34, var_b8d7eebc66b044cc, attacker, fromclear, slot )
{
    profilestart();
    superinfo = getcurrentsuper( slot );
    self notify( function_cc6f5a44b1441e16( slot, "super_use_finished_lb" ) );
    clientnum = self getentitynumber();
    codcaster_utils::function_daf7fb7edb6acdbd( 4, clientnum, undefined );
    
    if ( isdefined( superinfo ) )
    {
        shouldrefund = 0;
        
        if ( !forcerefund && !var_b8d7eebc66b044cc )
        {
            shouldrefund = shouldrefundsuper( slot );
        }
        
        setsuperisinuse( 0, slot );
        setsuperisactive( 0, slot );
        superinfo.canstow = 0;
        
        if ( superinfo.staticdata.bundle.var_b0f969efd931edf9 )
        {
            self playsoundevent( superinfo.staticdata.bundle.var_b0f969efd931edf9 );
        }
        
        var_3aec6a92e1f1acd9 = undefined;
        
        if ( isdefined( superinfo.staticdata.endusefunc ) )
        {
            if ( !isdefined( fromdeath ) )
            {
                fromdeath = 0;
            }
            
            var_3aec6a92e1f1acd9 = self [[ superinfo.staticdata.endusefunc ]]( fromdeath, attacker );
        }
        
        if ( shouldrefund || forcerefund || var_3aec6a92e1f1acd9 )
        {
            setsuperexpended( 0, slot );
            refundsuper( slot );
        }
        else if ( var_320ffc6ef12e2e34 )
        {
            setsuperexpended( 0, slot );
            superinfo.wasrefunded = 1;
            
            if ( function_cc252fb1315910e5( superinfo, slot ) )
            {
                var_61456d6a6cb404d1 = superinfo.staticdata.bundle.var_7ac7eeaab6f92f3d * superinfo.usepercent;
                self.pers[ "rechargeSupers" ][ slot ].rechargeremaining = var_61456d6a6cb404d1;
            }
            else
            {
                var_61456d6a6cb404d1 = getsuperpointsneeded( superinfo ) * superinfo.usepercent;
                setsuperbasepoints( var_61456d6a6cb404d1, undefined, slot );
            }
        }
        else if ( function_2041e16ed18271bc( slot ) )
        {
            setsuperexpended( 0, slot );
            setsuperbasepoints( 0, undefined, slot );
            superinfo.lastfinishtime = gettime();
            superinfo.wasrefunded = 0;
        }
        else if ( self.var_760a3e04da86556f && function_31f00fe6e0334d03( slot ) || !self.var_760a3e04da86556f && isdefined( self.overclockcharge ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
        {
            setsuperexpended( 0, slot );
            
            if ( !utility::iszm() )
            {
                setsuperbasepoints( self.overclockcharge, undefined, slot );
                function_1f9b6b3c1d1f1404( 0, undefined, slot );
            }
            
            superinfo.lastfinishtime = gettime();
            superinfo.wasrefunded = 0;
        }
        else if ( !fromclear )
        {
            thread expendsuper( slot );
            superinfo.lastfinishtime = gettime();
            superinfo.wasrefunded = 0;
        }
        
        if ( !superinfo.staticdata.var_20ce3b96f3fc30d4 )
        {
            thread switchandtakesuperuseweapon( 1, 1, slot );
        }
        
        if ( isbrgamemode() )
        {
            if ( !level.allowsupers && !isdefined( self.var_760a3e04da86556f ) && !function_2041e16ed18271bc( slot ) )
            {
                if ( !forcerefund )
                {
                    self setclientomnvar( "ui_perk_package_state", 0 );
                    thread function_cb3e288a8ed4df3e( 0, slot );
                    br_instance_inventory::function_ba66e7c85bc79054( self, "super" );
                    self.var_33129007db246c94 = 0;
                    
                    if ( function_ec58b00bf38b48a8( superinfo.staticdata.ref ) )
                    {
                        clearsuper( undefined, undefined, undefined, slot );
                    }
                }
            }
            else if ( isdefined( superinfo.staticdata.brsingleuse ) || function_ec58b00bf38b48a8( superinfo.staticdata.ref ) )
            {
                clearsuper( undefined, undefined, undefined, slot );
                thread function_cb3e288a8ed4df3e( 0, slot );
                thread handlesuperuistatechange( 0, slot );
            }
        }
        
        if ( superinfo.blueprintindex > 0 && superinfo.staticdata.bundle.genericblueprintlist.blueprints[ superinfo.blueprintindex - 1 ] )
        {
            genericblueprintname = superinfo.staticdata.bundle.genericblueprintlist.blueprints[ superinfo.blueprintindex - 1 ].genericblueprint;
            self function_b06c41e6d4ed36c( genericblueprintname );
        }
        
        if ( level.var_dc61a9eb0da4d624 ?? analyticslog::function_f432eaae9387e0e4() )
        {
            if ( isdefined( superinfo.usestarttime ) && isdefined( superinfo.madeavailabletime ) )
            {
                timedifference = superinfo.usestarttime - superinfo.madeavailabletime;
                analyticslog::logevent_superended( superinfo.staticdata.ref, timedifference, 0, superinfo.numkills );
            }
        }
        
        if ( slot != #"tactical" && superinfo.remainingcharges > 0 )
        {
            self setweaponammoclip( superinfo.weaponobj, 1 );
        }
        
        /#
            print::printgameaction( "<dev string:x578>" + superinfo.staticdata.ref, self );
        #/
        
        if ( !function_2041e16ed18271bc( slot ) )
        {
            function_dbc8badb3eff31fc( 0 );
        }
    }
    
    if ( level.codcasterenabled )
    {
        self setspecialactive( 0 );
    }
    
    level.b_field_upgrade_used = 1;
    callback::callback( #"on_super_use_finished", superinfo );
    self notify( function_cc6f5a44b1441e16( slot, "super_use_finished" ) );
    profilestop();
}

// Namespace supers_mp
// Params 1
// Checksum 0xa30ef33c, Offset: 0x8d87
// Size: 0x80
function function_f8002b3eecad1760( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo.remainingcharges ) )
    {
        return;
    }
    
    superinfo.remainingcharges -= 1;
    
    if ( superinfo.remainingcharges <= 0 )
    {
        superinfo.remainingcharges = undefined;
        utility::delaythread( level.framedurationseconds, &clearsuper, undefined, undefined, undefined, slot );
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xb473bf0c, Offset: 0x8e0f
// Size: 0x3f
function function_6a2a50cbce896c7d( numcharges, slot )
{
    if ( !isdefined( numcharges ) )
    {
        return;
    }
    
    superinfo = getcurrentsuper( slot );
    superinfo.remainingcharges = numcharges;
}

// Namespace supers_mp
// Params 1
// Checksum 0x2939df32, Offset: 0x8e56
// Size: 0x3a
function expendsuper( slot )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    setsuperexpended( 1, slot );
    waitframe();
    setsuperexpended( 0, slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0xc3ff2e63, Offset: 0x8e98
// Size: 0x24f
function refundsuper( slot )
{
    profilestart();
    
    if ( isbrgamemode() && getdvarint( @"hash_507569690567abeb", 1 ) )
    {
        super = self.equipment[ "super" ] ?? self.perkpackagedata.super;
        
        if ( isdefined( super ) )
        {
            br_pickups::function_c8443eb135b6c738( super, self.super.staticdata.ref );
        }
    }
    else
    {
        superinfo = getcurrentsuper( slot );
        
        if ( superinfo.var_1b8dba4c46fda7f8 )
        {
            profilestop();
            return;
        }
        
        superinfo.var_1b8dba4c46fda7f8 = 1;
        
        if ( superinfo.isinuse )
        {
            superusefinished( 1, undefined, undefined, undefined, undefined, undefined, slot );
        }
        
        if ( isdefined( superinfo ) )
        {
            superinfo.wasrefunded = 1;
            
            if ( superinfo.isinuse )
            {
                superusefinished( 0, undefined, undefined, undefined, undefined, undefined, slot );
            }
            
            var_8e18cbf8a73d0dfd = 0;
            
            if ( slot == #"tactical" )
            {
                ref = equipment_mp::getcurrentequipment( "secondary" );
                equipbundle = equipment_mp::function_c90a9aa89b223dd7( ref );
                
                if ( equipbundle.issuper )
                {
                    assert( equipbundle.superref == superinfo.staticdata.ref, "<dev string:x388>" );
                    equipment_mp::incrementequipmentslotammo( "secondary", 1 );
                    maxammo = equipment_mp::getequipmentmaxammo( ref );
                    ammo = equipment_mp::getequipmentammo( ref );
                    
                    if ( ammo < maxammo )
                    {
                        var_8e18cbf8a73d0dfd = 1;
                    }
                }
            }
            
            if ( function_cc252fb1315910e5( superinfo, slot ) )
            {
                if ( isdefined( self.pers[ "rechargeSupers" ][ slot ] ) )
                {
                    self.pers[ "rechargeSupers" ][ slot ].rechargeremaining = 0;
                }
                
                var_8e18cbf8a73d0dfd = 1;
            }
            
            if ( !var_8e18cbf8a73d0dfd )
            {
                givesuperpoints( getsuperpointsneeded( superinfo ), undefined, undefined, undefined, undefined, 1, slot );
            }
            
            if ( slot != #"tactical" )
            {
                self setweaponammoclip( superinfo.weaponobj, 1 );
            }
            
            superinfo.var_1b8dba4c46fda7f8 = undefined;
        }
    }
    
    profilestop();
}

// Namespace supers_mp
// Params 2
// Checksum 0xa1b537ca, Offset: 0x90ef
// Size: 0xea
function function_e7c245e9675fdabb( timeleft, destroyfunc )
{
    super = self;
    super.owner endon( function_cc6f5a44b1441e16( super.slot, "super_reclaimed" ) );
    super.owner endon( #"death_or_disconnect" );
    super endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isdefined( super.timeremaining ) )
    {
        timeleft = super.timeremaining;
    }
    
    while ( true )
    {
        super.timeremaining = timeleft;
        
        if ( super.timeremaining == 0 )
        {
            if ( isdefined( destroyfunc ) )
            {
                self [[ destroyfunc ]]();
            }
            else
            {
                script::demoforcesre( "[trackSuperTimeRemaining] destroy function not defined for super " + super.type );
            }
        }
        
        wait 1;
        timeleft -= 1;
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xee8461dc, Offset: 0x91e1
// Size: 0x75
function function_bfbe7cd057368e6e( dropbundle, item )
{
    player = self;
    
    if ( isdefined( player.superdurability ) )
    {
        item.durability = player.superdurability;
        item.timeremaining = player.var_ce99ca57a38ec2a0;
        player.superdurability = undefined;
        player.var_ce99ca57a38ec2a0 = undefined;
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xc87d6323, Offset: 0x925e
// Size: 0x55
function function_4f73c9b5d3c9875c()
{
    super = self;
    
    if ( isdefined( super.owner.superfuncs.var_2a67c6f950e71cf7 ) )
    {
        self thread [[ super.owner.superfuncs.var_2a67c6f950e71cf7 ]]();
    }
}

// Namespace supers_mp
// Params 3
// Checksum 0xd48b5152, Offset: 0x92bb
// Size: 0xb6
function function_35c926889c754091( pickup, player, slot )
{
    if ( !isdefined( pickup.fromground ) )
    {
        return;
    }
    
    if ( isdefined( pickup.timeremaining ) )
    {
        player.var_ce99ca57a38ec2a0 = pickup.timeremaining;
    }
    
    if ( isdefined( pickup.durability ) )
    {
        player.superdurability = pickup.durability;
    }
    else
    {
        player.superdurability = 0;
    }
    
    superinfo = getcurrentsuper( slot );
    player.superfuncs = superinfo.staticdata;
}

// Namespace supers_mp
// Params 3
// Checksum 0x7b9b61f5, Offset: 0x9379
// Size: 0xb9
function function_e2c263f3ee5d2d92( durability, timeremaining, ammo )
{
    reclaimedsuper = self;
    reclaimedsuper.owner.superdurability = durability;
    reclaimedsuper.owner.var_ce99ca57a38ec2a0 = timeremaining;
    
    if ( isdefined( ammo ) )
    {
        reclaimedsuper.owner.superammo = ammo;
    }
    
    superinfo = reclaimedsuper.owner.super;
    reclaimedsuper.owner.superfuncs = superinfo.staticdata;
}

// Namespace supers_mp
// Params 2
// Checksum 0x754acc35, Offset: 0x943a
// Size: 0x313
function function_3a21005bdaf91ac2( superbundle, allowsquadmates = 0 )
{
    super = self;
    super endon( #"death" );
    level endon( #"game_ended" );
    super.owner endon( #"disconnect" );
    self endon( function_cc6f5a44b1441e16( super.slot, "disabled_super_reclaim" ) );
    
    if ( level.allowsupers )
    {
        super childthread function_521b332130afd0be();
    }
    
    if ( superbundle.var_727bcc82f6e443de )
    {
        super childthread function_56cfc12c0767edc0();
        super.owner endon( #"death" );
    }
    
    super childthread function_f8b9a03adee506e4();
    super makeusable();
    super enablemissilehint( 1 );
    super setcursorhint( "HINT_BUTTON" );
    duration = superbundle.var_5473781d4c60acc8 ?? "duration_medium";
    reclaim_distance = superbundle.var_9467903d76b9950d ?? 128;
    super setuseholdduration( duration );
    super sethinttag( "tag_use" );
    super setuserange( reclaim_distance );
    
    if ( superbundle.var_490c0b395d32a7e5 )
    {
        super sethintstring( superbundle.var_490c0b395d32a7e5 );
    }
    else
    {
        super sethintstring( &"MP/BR_PICK_UP_SUPER" );
    }
    
    super disableplayeruseforallplayers();
    
    if ( allowsquadmates )
    {
        friendlies = teams::function_d032b36d01bbbab3( super.owner.team, super.owner.sessionsquadid );
        
        foreach ( friendly in friendlies )
        {
            super enableplayeruse( friendly );
        }
    }
    else
    {
        super enableplayeruse( super.owner );
    }
    
    super function_4f73c9b5d3c9875c();
    movingplatform = super utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatform.groundent ) && movingplatform.groundent vehicle::is_vehicle() )
    {
        super setuserange( 64 );
    }
    
    while ( true )
    {
        super waittill( #"trigger", player );
        
        if ( !isdefined( super.owner ) || !allowsquadmates && player != super.owner )
        {
            continue;
        }
        
        var_942d1a76488d714 = distancesquared( player.origin, super.origin );
        
        if ( var_942d1a76488d714 > reclaim_distance * reclaim_distance )
        {
            continue;
        }
        
        super.owner notify( function_cc6f5a44b1441e16( super.slot, "super_reclaimed" ), super, player );
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x990b43ad, Offset: 0x9755
// Size: 0x1e
function function_56cfc12c0767edc0()
{
    self.owner waittill( #"death" );
    function_867458c6f9c3d1f5();
}

// Namespace supers_mp
// Params 0
// Checksum 0xb716a0a8, Offset: 0x977b
// Size: 0x29
function function_521b332130afd0be()
{
    self.owner waittill( function_cc6f5a44b1441e16( self.slot, "unset_super" ) );
    function_867458c6f9c3d1f5();
}

// Namespace supers_mp
// Params 0
// Checksum 0x85e73c8a, Offset: 0x97ac
// Size: 0x16
function function_f8b9a03adee506e4()
{
    self waittill( #"hash_3f50e42da99b4c0" );
    function_867458c6f9c3d1f5();
}

// Namespace supers_mp
// Params 1
// Checksum 0x881ddc0b, Offset: 0x97ca
// Size: 0xae
function function_24bd67c384c2e606( lifetimetotal )
{
    super = self;
    super endon( #"death" );
    level endon( #"game_ended" );
    super endon( #"disabled_super_reclaim" );
    timeremaining = super.owner.var_ce99ca57a38ec2a0 ?? lifetimetotal;
    var_94b57aecec7ff249 = super.bundle.var_c829e6aa94adb778 ?? 0;
    var_7d2d5846c3255f0 = timeremaining - var_94b57aecec7ff249;
    
    if ( var_7d2d5846c3255f0 > 0 )
    {
        super function_94b57aecec7ff249( var_7d2d5846c3255f0 );
    }
    
    super function_867458c6f9c3d1f5();
}

// Namespace supers_mp
// Params 1
// Checksum 0x7a1adc28, Offset: 0x9880
// Size: 0x5c
function function_94b57aecec7ff249( timetowait )
{
    super = self;
    super endon( #"death" );
    level endon( #"game_ended" );
    super endon( #"entity_damage_received" );
    super endon( #"missile_stuck" );
    super endon( #"trophy_ammo_used" );
    wait timetowait;
}

// Namespace supers_mp
// Params 1
// Checksum 0x5cd03319, Offset: 0x98e4
// Size: 0x3e
function function_82d9b795fa73b4fd( superinfo )
{
    if ( isdefined( superinfo.staticdata.var_2a67c6f950e71cf7 ) )
    {
        self thread [[ superinfo.staticdata.var_2a67c6f950e71cf7 ]]();
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0x6e72d1ee, Offset: 0x992a
// Size: 0x98
function handledeath( attacker, slot )
{
    self endon( #"disconnect" );
    
    if ( !issuperinuse( slot ) )
    {
        return;
    }
    
    superinfo = getcurrentsuper( slot );
    forcerefund = superinfo.staticdata.refundondeath;
    persistondeath = superinfo.staticdata.persistondeath;
    
    if ( !persistondeath )
    {
        superusefinished( forcerefund, 1, 0, 0, attacker, undefined, slot );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x82686e2f, Offset: 0x99ca
// Size: 0x5d
function monitoruseweaponfiring( var_4588ed7d75a32bf6 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"super_use_finished" );
    self endon( #"remove_super" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( issameweapon( objweapon, var_4588ed7d75a32bf6, 1 ) )
        {
        }
    }
}

// Namespace supers_mp
// Params 7
// Checksum 0x5dca9597, Offset: 0x9a2f
// Size: 0xf2, Type: bool
function trygiveuseweapon( useweapon, clipammo, stockammo, skipfirstraise, isimmediate, var_686ab1c37bca9979, slot )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( skipfirstraise ) )
    {
        skipfirstraise = 0;
    }
    
    if ( inventory_utility::iscurrentweapon( useweapon ) )
    {
        inventory_utility::_takeweapon( useweapon );
    }
    
    inventory_utility::_giveweapon( useweapon, undefined, undefined, skipfirstraise );
    
    if ( !isdefined( clipammo ) )
    {
        clipammo = function_e9399f7a98e27919( slot );
    }
    
    if ( !isdefined( stockammo ) )
    {
        stockammo = function_fa89e20fdbd5df53( slot );
    }
    
    if ( clipammo + stockammo == 0 )
    {
        return false;
    }
    
    self setweaponammoclip( useweapon, clipammo );
    self setweaponammostock( useweapon, stockammo );
    switchresult = inventory_utility::domonitoredweaponswitch( useweapon, isimmediate );
    
    if ( switchresult )
    {
        if ( !var_686ab1c37bca9979 )
        {
            thread function_38fe8fa86d555c03( useweapon, slot );
        }
        
        function_7d5785345fab2710( slot );
        return true;
    }
    
    inventory_utility::abortmonitoredweaponswitch( useweapon );
    return false;
}

// Namespace supers_mp
// Params 2
// Checksum 0xcb8cbbc2, Offset: 0x9b2a
// Size: 0x76
function function_38fe8fa86d555c03( useweapon, slot )
{
    self endon( #"death_or_disconnect" );
    self endon( #"super_use_finished" );
    self waittill( #"weapon_change", useweapon );
    
    while ( true )
    {
        self waittill( #"weapon_change", newweapon );
        
        if ( function_9ac5eb9572fa3a0a( useweapon, newweapon ) )
        {
            switchandtakesuperuseweapon( 1, undefined, slot );
            return;
        }
    }
}

// Namespace supers_mp
// Params 4
// Checksum 0xbe638af7, Offset: 0x9ba8
// Size: 0xf1
function switchandtakesuperuseweapon( cacheammo, onend, slot, var_42d7193faa612585 )
{
    self endon( #"death" );
    superinfo = getcurrentsuper( slot );
    useweapon = var_42d7193faa612585 ?? function_6c912116c8af1159( superinfo );
    
    if ( !isdefined( useweapon ) )
    {
        return;
    }
    
    if ( cacheammo && issameweapon( self getcurrentweapon(), useweapon ) )
    {
        function_7d5785345fab2710( slot );
    }
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( useweapon ) )
    {
        inventory_utility::abortmonitoredweaponswitch( useweapon );
    }
    
    if ( onend )
    {
        self notify( function_cc6f5a44b1441e16( slot, "super_switched" ) );
    }
    
    if ( superinfo.staticdata.var_b04dc4f3e9e1f24c )
    {
        useweapon = function_c0901f58a21692ee( superinfo, useweapon );
    }
    
    inventory_utility::getridofweapon( useweapon, self.var_699f73faca9beeb1 );
    
    if ( !onend )
    {
        setsuperisactive( 0, slot );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x72c5884d, Offset: 0x9ca1
// Size: 0x1d0
function storesuperpoints( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( issupercharging( slot ) || issuperready( superinfo ) )
    {
        self.pers[ slot == #"tactical" ? "tacticalSuperBasePoints" : "superBasePoints" ] = superinfo.basepoints;
        self.pers[ slot == #"tactical" ? "tacticalSuperExtraPoints" : "superExtraPoints" ] = superinfo.extrapoints;
    }
    else if ( issuperinuse( slot ) && shouldrefundsuper( slot ) )
    {
        pointsneeded = getsuperpointsneeded( superinfo );
        self.pers[ slot == #"tactical" ? "tacticalSuperPoints" : "superPoints" ] = superinfo.usepercent * pointsneeded;
        self.pers[ slot == #"tactical" ? "tacticalSuperExtraPoints" : "superExtraPoints" ] = 0;
    }
    else
    {
        self.pers[ slot == #"tactical" ? "tacticalSuperBasePoints" : "superBasePoints" ] = 0;
        self.pers[ slot == #"tactical" ? "tacticalSuperExtraPoints" : "superExtraPoints" ] = 0;
    }
    
    if ( slot == #"tactical" )
    {
        equipmentref = equipment_mp::getcurrentequipment( "secondary" );
        
        if ( equipmentref )
        {
            equipmentammo = equipment_mp::getequipmentammo( equipmentref );
        }
        
        self.pers[ "tacticalSuperAmmo" ] = equipmentammo ?? 0;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x575e4361, Offset: 0x9e79
// Size: 0x46
function getsuperuseuiprogress( slot )
{
    superinfo = getcurrentsuper( slot );
    assert( superinfo.isinuse, "<dev string:x58b>" );
    
    /#
    #/
    
    return superinfo.usepercent;
}

// Namespace supers_mp
// Params 1
// Checksum 0x90b80498, Offset: 0x9ec8
// Size: 0x26, Type: bool
function getcurrentsuperbasepoints( slot )
{
    return getcurrentsuper( slot ).basepoints ?? 1;
}

// Namespace supers_mp
// Params 1
// Checksum 0x6fb9ceaa, Offset: 0x9ef7
// Size: 0x1e
function getcurrentsuperextrapoints( slot )
{
    return getcurrentsuper( slot ).basepoints;
}

// Namespace supers_mp
// Params 1
// Checksum 0x2152a524, Offset: 0x9f1e
// Size: 0x40
function getcurrentsuperpoints( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return 0;
    }
    
    return superinfo.basepoints + superinfo.extrapoints;
}

// Namespace supers_mp
// Params 2
// Checksum 0x3814dee, Offset: 0x9f67
// Size: 0x18d
function getsuperpointsneeded( superinfo, slot = superinfo.slot ?? #"default" )
{
    if ( !isdefined( level.var_6740b83eee843d5c ) )
    {
        level.var_6740b83eee843d5c = getdvarfloat( @"hash_44bfa52881f906e2", 1 );
    }
    
    if ( slot == #"default" && isdefined( self.perkpackagedata.overridepointsneeded ) )
    {
        return ( self.perkpackagedata.overridepointsneeded * level.var_6740b83eee843d5c );
    }
    
    if ( !isdefined( superinfo ) )
    {
        superinfo = getcurrentsuper( slot );
    }
    
    if ( isdefined( level.sharedfuncs[ #"skills" ][ #"getsuperpointsneeded" ] ) )
    {
        funcresult = self [[ level.sharedfuncs[ #"skills" ][ #"getsuperpointsneeded" ] ]]( superinfo.staticdata.ref );
        
        if ( isdefined( funcresult ) )
        {
            return ( funcresult * level.var_6740b83eee843d5c );
        }
    }
    
    if ( superinfo.staticdata.var_5afeac4251aa48da )
    {
        funcresult = self [[ superinfo.staticdata.var_5afeac4251aa48da ]]( superinfo );
        
        if ( isdefined( funcresult ) )
        {
            return ( funcresult * level.var_6740b83eee843d5c );
        }
    }
    
    return ( superinfo.staticdata.pointsneeded ?? 0 ) * level.var_6740b83eee843d5c;
}

// Namespace supers_mp
// Params 2
// Checksum 0xd0749705, Offset: 0xa0fd
// Size: 0x9f
function issuperready( superinfo, slot )
{
    if ( isbrgamemode() )
    {
        return self.var_33129007db246c94;
    }
    
    superinfo = superinfo ?? getcurrentsuper( slot );
    slot = slot ?? superinfo.slot;
    
    if ( !isdefined( superinfo ) || superinfo.isinuse )
    {
        return 0;
    }
    
    if ( function_cc252fb1315910e5( superinfo, slot ) )
    {
        return ( self.pers[ "rechargeSupers" ][ slot ].rechargeremaining <= 0 );
    }
    
    return getcurrentsuperpoints( slot ) >= getsuperpointsneeded( superinfo );
}

// Namespace supers_mp
// Params 1
// Checksum 0xd180003f, Offset: 0xa1a4
// Size: 0x6f, Type: bool
function function_7dcdfecb3848b30e( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) || superinfo.isinuse )
    {
        return false;
    }
    
    if ( !isdefined( self.overclockcharge ) || !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        return false;
    }
    
    return self.overclockcharge >= getsuperpointsneeded( superinfo );
}

// Namespace supers_mp
// Params 1
// Checksum 0x61926809, Offset: 0xa21c
// Size: 0x1f, Type: bool
function function_f863d9ef10bf403f( slot )
{
    return istrue( getcurrentsuper( slot ).isactive );
}

// Namespace supers_mp
// Params 1
// Checksum 0xa328debf, Offset: 0xa244
// Size: 0x1f, Type: bool
function issuperinuse( slot )
{
    return istrue( getcurrentsuper( slot ).isinuse );
}

// Namespace supers_mp
// Params 0
// Checksum 0xda3ebda2, Offset: 0xa26c
// Size: 0xc, Type: bool
function function_ec7e2ab9a462557b()
{
    return istrue( self.var_758feed359019083 );
}

// Namespace supers_mp
// Params 0
// Checksum 0x95c1a047, Offset: 0xa281
// Size: 0x60, Type: bool
function function_eb397a0f982351d6()
{
    superinfo = getcurrentsuper();
    
    if ( !issuperinuse() )
    {
        return false;
    }
    
    if ( !superinfo || !superinfo.staticdata )
    {
        assertmsg( "<dev string:x5c2>" );
        return false;
    }
    
    return superinfo.staticdata.weapontype == "BULLETWEAPON";
}

// Namespace supers_mp
// Params 1
// Checksum 0x5e285479, Offset: 0xa2ea
// Size: 0x1f
function function_2dccac3e12d95853( isactivating )
{
    self.var_758feed359019083 = isactivating;
    self function_81b935d669fd68a8( isactivating );
}

// Namespace supers_mp
// Params 2
// Checksum 0xf5f91a7, Offset: 0xa311
// Size: 0x37
function function_dd6d97545b84597d( ispaused, slot )
{
    superinfo = getcurrentsuper( slot );
    superinfo.var_56758aae9172d1a0 = ispaused;
}

// Namespace supers_mp
// Params 2
// Checksum 0xc55b9e00, Offset: 0xa350
// Size: 0x40
function setsuperisinuse( isinuse, slot )
{
    superinfo = getcurrentsuper( slot );
    superinfo.isinuse = isinuse;
    updatesuperuistate( slot );
}

// Namespace supers_mp
// Params 2
// Checksum 0xee1572e6, Offset: 0xa398
// Size: 0xb7
function setsuperisactive( isactive, slot )
{
    superinfo = getcurrentsuper( slot );
    superinfo.isactive = isactive;
    
    if ( !isactive && issuperinuse( slot ) )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_super_can_use" );
        
        if ( omnvar )
        {
            self setclientomnvar( omnvar, 1 );
        }
        
        return;
    }
    
    if ( isactive && superinfo.staticdata.ref == "super_evg" )
    {
        return;
    }
    
    omnvar = function_c1488fa73d55ae70( slot, "ui_super_can_use" );
    
    if ( omnvar )
    {
        self setclientomnvar( omnvar, 0 );
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x9d958449, Offset: 0xa457
// Size: 0x23, Type: bool
function issupercharging( slot )
{
    return !issuperready( undefined, slot ) && !issuperinuse( slot );
}

// Namespace supers_mp
// Params 0
// Checksum 0x1ed1e8a2, Offset: 0xa483
// Size: 0x12, Type: bool
function issuperexpended()
{
    return istrue( self.pers[ "superExpended" ] );
}

// Namespace supers_mp
// Params 1
// Checksum 0x4d59a2ae, Offset: 0xa49e
// Size: 0x3e
function function_ec58b00bf38b48a8( superref )
{
    if ( !isdefined( superref ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_ae67ab0a1e16af15 ) )
    {
        return 0;
    }
    
    if ( !isbrgamemode() )
    {
        return 0;
    }
    
    return arraycontains( level.var_ae67ab0a1e16af15, superref );
}

// Namespace supers_mp
// Params 2
// Checksum 0x81c6d0a3, Offset: 0xa4e5
// Size: 0x46
function setsuperexpended( var_530edf25b4e179f7, slot )
{
    self.pers[ slot == #"tactical" ? "tacticalSuperExpended" : "superExpended" ] = var_530edf25b4e179f7;
    updatesuperuistate( slot );
}

// Namespace supers_mp
// Params 1
// Checksum 0x4c535587, Offset: 0xa533
// Size: 0x30
function getcurrentsuper( slot )
{
    return slot == #"tactical" ? self.tacticalsuper : self.super;
}

// Namespace supers_mp
// Params 1
// Checksum 0xa2cf5e62, Offset: 0xa56c
// Size: 0x43
function getsuperslot( superref )
{
    bundle = function_5ffd3dfa9cc1e8de( superref );
    return bundle.var_5cf25d35be09368b ? #"tactical" : #"default";
}

// Namespace supers_mp
// Params 1
// Checksum 0x8a15be84, Offset: 0xa5b8
// Size: 0x3d
function getcurrentsuperref( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    return superinfo.staticdata.ref;
}

// Namespace supers_mp
// Params 1
// Checksum 0xe0f89527, Offset: 0xa5fe
// Size: 0x46
function function_8d1504409d190469( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( superinfo.var_56758aae9172d1a0 ) )
    {
        return 0;
    }
    
    return superinfo.var_56758aae9172d1a0;
}

// Namespace supers_mp
// Params 1
// Checksum 0x1bb02ecf, Offset: 0xa64d
// Size: 0x7b
function function_73cd30ebdbeeadab( superinfo )
{
    if ( !superinfo.isinuse )
    {
        return;
    }
    
    var_db965f16d1093247 = max( 0, superinfo.var_a957044d064c9048 - superinfo.var_3107a3601c2d758b );
    refillrate = min( superinfo.var_aba4427f72a2cbe7, var_db965f16d1093247 );
    superinfo.var_3107a3601c2d758b += refillrate;
    return refillrate;
}

// Namespace supers_mp
// Params 2
// Checksum 0x5cabaef0, Offset: 0xa6d1
// Size: 0x60
function function_9f116b8da4a01a94( seconds, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) || !superinfo.isinuse )
    {
        return;
    }
    
    superinfo.var_a957044d064c9048 += max( 0, seconds );
}

// Namespace supers_mp
// Params 2
// Checksum 0xf0dec2ce, Offset: 0xa739
// Size: 0x44
function function_f91122ed42f4ead2( var_9a15da07f7d8c5eb, slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    superinfo.var_aba4427f72a2cbe7 = max( 0, var_9a15da07f7d8c5eb );
}

// Namespace supers_mp
// Params 1
// Checksum 0xcfde414f, Offset: 0xa785
// Size: 0xa1
function shouldrefundsuper( slot )
{
    assert( issuperinuse( slot ) );
    superinfo = getcurrentsuper( slot );
    graceperiod = superinfo.staticdata.graceperiod;
    
    if ( !isdefined( superinfo.usestarttime ) )
    {
        return 0;
    }
    
    usedtime = gettime() - superinfo.usestarttime;
    
    if ( usedtime >= graceperiod )
    {
        return 0;
    }
    
    if ( superinfo.numkills > 0 )
    {
        return 0;
    }
    
    return superinfo.allowrefund;
}

// Namespace supers_mp
// Params 1
// Checksum 0x7365c276, Offset: 0xa82f
// Size: 0x2c
function function_f669caef50cf98bc( var_b541b98c7febbc0 )
{
    return level.superglobals.superweapons[ var_b541b98c7febbc0 ].ref;
}

// Namespace supers_mp
// Params 1
// Checksum 0x4739f6bb, Offset: 0xa864
// Size: 0x41
function getsuperrefforsuperuseweapon( weapon )
{
    weapon = isxhashasset( weapon ) ? weapon : isstring( weapon ) ? getxhashasset( weapon ) : weapon.basenamehash;
    return function_f669caef50cf98bc( weapon );
}

// Namespace supers_mp
// Params 1
// Checksum 0xd52a819d, Offset: 0xa8ae
// Size: 0x2c
function function_c664ac8b29a1a8f( var_b541b98c7febbc0 )
{
    return level.superglobals.supersbyoffhand[ var_b541b98c7febbc0 ].ref;
}

// Namespace supers_mp
// Params 1
// Checksum 0x81f32f1, Offset: 0xa8e3
// Size: 0x41
function getsuperrefforsuperoffhand( weapon )
{
    weapon = isxhashasset( weapon ) ? weapon : isstring( weapon ) ? getxhashasset( weapon ) : weapon.basenamehash;
    return function_c664ac8b29a1a8f( weapon );
}

// Namespace supers_mp
// Params 1
// Checksum 0xf3833c57, Offset: 0xa92d
// Size: 0x2c
function function_be4acf11e79b1559( var_b541b98c7febbc0 )
{
    return level.superglobals.supersbyextraweapon[ var_b541b98c7febbc0 ].ref;
}

// Namespace supers_mp
// Params 1
// Checksum 0x6cef18b6, Offset: 0xa962
// Size: 0x41
function getsuperrefforsuperextraweapon( weapon )
{
    weapon = isxhashasset( weapon ) ? weapon : isstring( weapon ) ? getxhashasset( weapon ) : weapon.basenamehash;
    return function_be4acf11e79b1559( weapon );
}

// Namespace supers_mp
// Params 1
// Checksum 0x8c33e19, Offset: 0xa9ac
// Size: 0xe8
function function_4ae7eb52b7c57b( weaponname )
{
    weaponname = isxhashasset( weaponname ) ? weaponname : isstring( weaponname ) ? getxhashasset( weaponname ) : weaponname.basenamehash;
    superref = function_f669caef50cf98bc( weaponname );
    
    if ( isdefined( superref ) )
    {
        return superref;
    }
    
    superref = function_c664ac8b29a1a8f( weaponname );
    
    if ( isdefined( superref ) )
    {
        return superref;
    }
    
    superref = function_be4acf11e79b1559( weaponname );
    
    if ( isdefined( superref ) )
    {
        return superref;
    }
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    switch ( weaponname )
    {
        case %"tac_insert_trigger":
            return "super_tac_insert";
        case %"deploy_loadout_drop_mp":
            return "super_loadout_drop";
        case %"super_laser_charge_mp":
            return "super_laser_charge";
        case %"sat_ar_eagle_ally_guild_bot_mp":
            return "super_guild_bot";
        case %"sat_mega_jump_ob":
            return "super_mega_jump";
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x2c8d962b, Offset: 0xaa9d
// Size: 0x23
function getsuperrefforsuperweapon( weapon )
{
    if ( !isdefined( level.superglobals ) )
    {
        return;
    }
    
    return function_4ae7eb52b7c57b( weapon );
}

// Namespace supers_mp
// Params 1
// Checksum 0xea6a524c, Offset: 0xaac9
// Size: 0x59
function getsuperrefoverride( superref )
{
    if ( !superref )
    {
        assertmsg( "<dev string:x5f3>" );
        return;
    }
    
    refoverride = level.superglobals.refoverrides[ superref ];
    
    if ( refoverride )
    {
        superref = refoverride.baseref;
    }
    
    return superref;
}

// Namespace supers_mp
// Params 1
// Checksum 0xeb2ec14a, Offset: 0xab2b
// Size: 0x52
function shouldtracksuperweaponstats( objweapon )
{
    ref = getsuperrefforsuperweapon( objweapon );
    
    if ( isdefined( ref ) )
    {
        data = level.superglobals.staticsuperdata[ ref ];
        return data.useweapontrackstats;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x78d690d2, Offset: 0xab86
// Size: 0x68
function getsuperid( superref )
{
    if ( !( isdefined( superref ) && isdefined( level.superglobals ) && isdefined( level.superglobals.staticsuperdata[ superref ] ) ) || superref == "none" )
    {
        return 0;
    }
    
    return level.superglobals.staticsuperdata[ superref ].id;
}

// Namespace supers_mp
// Params 1
// Checksum 0x7aeff11b, Offset: 0xabf7
// Size: 0x14
function getrootsuperref( superref )
{
    return getsubstr( superref, 6 );
}

// Namespace supers_mp
// Params 1
// Checksum 0xe8a5efcf, Offset: 0xac14
// Size: 0x59, Type: bool
function getsuperweapon( superref )
{
    return level.superglobals.staticsuperdata[ superref ].useweapon.basename ?? level.superglobals.staticsuperdata[ superref ].weapon;
}

// Namespace supers_mp
// Params 1
// Checksum 0x3ae52e8, Offset: 0xac76
// Size: 0x2f, Type: bool
function function_6c912116c8af1159( superinfo )
{
    return superinfo.var_7ef7600ff6978d76 ?? superinfo.staticdata.useweapon;
}

// Namespace supers_mp
// Params 0
// Checksum 0x8cb2f284, Offset: 0xacae
// Size: 0x31
function function_e48058725c0c163a()
{
    if ( isdefined( self.var_3bd6d05c20649e30 ) && self.var_3bd6d05c20649e30.size > 0 )
    {
        return ( self.var_3bd6d05c20649e30.size - 1 );
    }
    
    return;
}

// Namespace supers_mp
// Params 0
// Checksum 0x56db70e3, Offset: 0xace7
// Size: 0x2e
function function_6b9f009cbd685872()
{
    if ( isdefined( self.var_3bd6d05c20649e30 ) && self.var_3bd6d05c20649e30.size > 0 )
    {
        return self.var_3bd6d05c20649e30.size;
    }
    
    return;
}

// Namespace supers_mp
// Params 1
// Checksum 0xba12e3a2, Offset: 0xad1d
// Size: 0x58
function getsuperbundlefromoffhandweaponname( weaponname )
{
    superref = getsuperrefforsuperoffhand( weaponname );
    
    if ( isdefined( superref ) )
    {
        superdata = level.superglobals.staticsuperdata[ superref ];
        
        if ( isdefined( superdata ) )
        {
            return superdata.bundle;
        }
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xeb20baa6, Offset: 0xad7e
// Size: 0x40
function function_3d6f3b9b75f1a86( superref )
{
    superdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( isdefined( superdata ) )
    {
        return superdata.var_d4ee70327fda7d31;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xe780c0c4, Offset: 0xadc7
// Size: 0x40
function function_f8f61f6a3f73eff2( superref )
{
    superdata = level.superglobals.staticsuperdata[ superref ];
    
    if ( isdefined( superdata ) )
    {
        return superdata.unlocksublocation;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xf30783af, Offset: 0xae10
// Size: 0x46
function allowsuperweaponstow( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) || !superinfo.isinuse )
    {
        return;
    }
    
    superinfo.canstow = 1;
}

// Namespace supers_mp
// Params 1
// Checksum 0xf10c8831, Offset: 0xae5e
// Size: 0x84
function unstowsuperweapon( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) || !superinfo.canstow )
    {
        return;
    }
    
    useweapon = function_6c912116c8af1159( superinfo );
    
    if ( !superinfo.isinuse || !useweapon )
    {
        superinfo.canstow = 0;
        return;
    }
    
    inventory_utility::domonitoredweaponswitch( useweapon );
    superinfo.canstow = 0;
}

// Namespace supers_mp
// Params 1
// Checksum 0xd55a9ac9, Offset: 0xaeea
// Size: 0x5c
function getsuperpointsforevent( eventref )
{
    if ( !isxhash( eventref ) )
    {
        assert( 0, eventref );
        eventref = getxhash( eventref );
    }
    
    if ( !isdefined( level.var_5baf51b4058a08a2 ) )
    {
        return 0;
    }
    
    points = level.var_5baf51b4058a08a2[ eventref ];
    
    if ( !isdefined( points ) )
    {
        return 0;
    }
    
    return points;
}

// Namespace supers_mp
// Params 0
// Checksum 0xe50be9dc, Offset: 0xaf4f
// Size: 0x91
function watchforgameend()
{
    level waittill( #"game_ended" );
    
    if ( game_utility_mp::waslastround() )
    {
        foreach ( player in level.players )
        {
            player writesppmstats();
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x93a92c3b, Offset: 0xafe8
// Size: 0xc1
function getsppmdata()
{
    if ( getdvarint( @"scr_sppm_data", 0 ) == 0 )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.sppmdata ) )
    {
        self.sppmdata = self.pers[ "sppmData" ];
        
        if ( !isdefined( self.sppmdata ) )
        {
            self.sppmdata = spawnstruct();
            self.sppmdata.totalpoints = 0;
            self.sppmdata.totalappliedpoints = 0;
            self.sppmdata.eventtotals = [];
            self.pers[ "sppmData" ] = self.sppmdata;
        }
    }
    
    return self.sppmdata;
}

// Namespace supers_mp
// Params 3
// Checksum 0x31cf42e9, Offset: 0xb0b2
// Size: 0xd8
function updatesppm( pointsearned, var_595ec03e2a167c16, eventref )
{
    if ( getdvarint( @"scr_sppm_data", 0 ) == 0 )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    data = getsppmdata();
    data.totalpoints += pointsearned;
    
    if ( var_595ec03e2a167c16 )
    {
        data.totalappliedpoints += pointsearned;
    }
    
    if ( !isdefined( eventref ) )
    {
        eventref = "undefined";
    }
    
    if ( !isdefined( data.eventtotals[ eventref ] ) )
    {
        data.eventtotals[ eventref ] = pointsearned;
        return;
    }
    
    data.eventtotals[ eventref ] += pointsearned;
}

// Namespace supers_mp
// Params 0
// Checksum 0x651b44a9, Offset: 0xb192
// Size: 0x1ca
function writesppmstats()
{
    if ( getdvarint( @"scr_sppm_data", 0 ) == 0 )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    data = getsppmdata();
    totaltime = persistence::statgetchildbuffered( "round", "timePlayed", 1 ) / 60;
    sppm = 0;
    appliedsppm = 0;
    
    if ( totaltime > 0 )
    {
        sppm = data.totalpoints / totaltime;
        appliedsppm = data.totalappliedpoints / totaltime;
    }
    
    bestevent = "";
    var_b94f6c6e27dd87c2 = -1;
    
    foreach ( event, eventtotal in data.eventtotals )
    {
        if ( eventtotal > var_b94f6c6e27dd87c2 )
        {
            var_b94f6c6e27dd87c2 = eventtotal;
            bestevent = event;
        }
    }
    
    if ( isxhash( bestevent ) )
    {
        bestevent = getxhashhexname( bestevent );
    }
    
    dlog_recordevent( "mpscript_sppm", [ "sppm", sppm, "sppm_applied", appliedsppm, "gamemode", game_utility::getgametype(), "kills", self.kills, "time_played", totaltime, "best_event", bestevent, "script_version", getscriptdataversion() ] );
}

// Namespace supers_mp
// Params 5
// Checksum 0x61b94b4e, Offset: 0xb364
// Size: 0x61
function modifysuperequipmentdamage( attacker, objweapon, type, damage, idflags )
{
    modifieddamage = damage;
    
    if ( attacker == self.owner )
    {
        modifieddamage = int( ceil( damage * 0.5 ) );
    }
    
    return modifieddamage;
}

// Namespace supers_mp
// Params 9
// Checksum 0xcbfa9809, Offset: 0xb3ce
// Size: 0x247
function updateactivesupers( einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir, slot )
{
    var_b96f96baf7dd109b = isplayer( einflictor );
    var_43788540dda8c517 = weapon::isthrowingknife( objweapon );
    var_aee30680fae0c4a5 = var_43788540dda8c517 && isdefined( einflictor ) && isdefined( einflictor.classname ) && einflictor.classname == "grenade";
    var_da7932e22db79808 = isplayer( attacker ) && attacker != victim;
    
    if ( var_da7932e22db79808 )
    {
        var_fd922dc8826e6e95 = attacker getcurrentsuper( slot );
        
        if ( weapon::function_1344ad15d2d7bd21( objweapon ) || var_b96f96baf7dd109b || var_aee30680fae0c4a5 )
        {
            if ( isdefined( var_fd922dc8826e6e95 ) && attacker issuperinuse( slot ) && isplayer( victim ) && player_utility::playersareenemies( attacker, victim ) )
            {
                if ( var_fd922dc8826e6e95.staticdata.ref == "super_deadsilence" )
                {
                    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"super_deadsilence" ][ #"hash_7dff8b8d09af9e50" ];
                    
                    if ( isdefined( var_32dbca3143d9c4a5 ) )
                    {
                        attacker thread [[ var_32dbca3143d9c4a5 ]]();
                    }
                }
                
                if ( var_fd922dc8826e6e95.staticdata.ref == "super_battlerage" || var_fd922dc8826e6e95.staticdata.ref == "super_squadrage" )
                {
                    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"battlerage" ][ #"hash_7dff8b8d09af9e50" ];
                    
                    if ( isdefined( var_32dbca3143d9c4a5 ) )
                    {
                        attacker thread [[ var_32dbca3143d9c4a5 ]]();
                    }
                }
                
                if ( var_fd922dc8826e6e95.staticdata.ref == "super_honeypot" )
                {
                    attacker thread honeypot::function_894a81aaf80f7b0b( victim );
                }
            }
        }
        
        if ( var_b96f96baf7dd109b )
        {
            if ( isdefined( einflictor.perks[ "specialty_bulletdamage" ] ) )
            {
                var_32dbca3143d9c4a5 = level.sharedfuncs[ #"super_stoppingpower" ][ #"hash_7dff8b8d09af9e50" ];
                
                if ( isdefined( var_32dbca3143d9c4a5 ) )
                {
                    attacker thread [[ var_32dbca3143d9c4a5 ]]( objweapon );
                }
            }
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xe70c0b2f, Offset: 0xb61d
// Size: 0xfa
function watchsuperdelay()
{
    level endon( #"super_delay_end" );
    level endon( #"round_end" );
    level endon( #"game_ended" );
    
    if ( game_utility_mp::isanymlgmatch() )
    {
        level.superdelay = 0;
    }
    else
    {
        level.superdelay = getdvarfloat( @"scr_superdelay", 0 );
    }
    
    if ( !isbrgamemode() )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    if ( level.superdelay == 0 )
    {
        level.superdelaystarttime = gettime();
        level.superdelayendtime = level.superdelaystarttime;
        level notify( #"super_delay_end" );
    }
    
    level.superdelaystarttime = gettime();
    level.superdelayendtime = level.superdelaystarttime + level.superdelay * 1000;
    level notify( #"super_delay_start" );
    
    while ( gettime() < level.superdelayendtime )
    {
        waitframe();
    }
    
    level notify( #"super_delay_end" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x2614384e, Offset: 0xb71f
// Size: 0x79
function watchplayersuperdelayweapon()
{
    level endon( #"round_end" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"clearedallows" );
    self notify( #"watchPlayerSuperDelayWeapon" );
    
    if ( superdelaypassed() )
    {
        return;
    }
    
    val::set( "super_delay", "supers", 0 );
    utility::waittill_any_ents( level, "super_delay_end", self, "watchPlayerSuperDelayWeapon" );
    val::reset_all( "super_delay" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xe9076c49, Offset: 0xb7a0
// Size: 0x1e, Type: bool
function superdelaypassed()
{
    return isdefined( level.superdelayendtime ) && gettime() >= level.superdelayendtime;
}

// Namespace supers_mp
// Params 0
// Checksum 0xe4b61ca8, Offset: 0xb7c7
// Size: 0x37
function cancelsuperdelay()
{
    level.superdelay = 0;
    level.superdelaystarttime = gettime();
    level.superdelayendtime = level.superdelaystarttime;
    level notify( #"super_delay_end" );
}

// Namespace supers_mp
// Params 1
// Checksum 0xf1ee2db6, Offset: 0xb806
// Size: 0x89
function givesuperweapon( superinfo )
{
    weapon = superinfo.staticdata.weapon;
    
    if ( isdefined( superinfo.weaponobj ) )
    {
        weapon = superinfo.weaponobj;
    }
    
    if ( !self hasweapon( weapon ) )
    {
        ammo = issuperready( superinfo ) ? 1 : 0;
        inventory_utility::_giveweapon( weapon );
        self setweaponammoclip( weapon, ammo );
        self assignweaponoffhandspecial( weapon );
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xe387179e, Offset: 0xb897
// Size: 0xe, Type: bool
function issuperdisabled()
{
    return !val::get( "supers" );
}

// Namespace supers_mp
// Params 2
// Checksum 0xb2260ed9, Offset: 0xb8ae
// Size: 0xbc
function watchobjuse( drainrate, var_127a3aeb37da3919 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e6579049d8a76e1d" );
    self endon( #"ball_dropped" );
    
    if ( game_utility_mp::getbasegametype() == "sd" || game_utility::getgametype() == "sr" || game_utility::getgametype() == "dd" )
    {
        if ( var_127a3aeb37da3919 )
        {
            self waittill( #"hash_b104d266cdc3b33b" );
        }
    }
    else if ( !isdefined( self.carryobject ) )
    {
        self waittill( #"obj_picked_up" );
    }
    else
    {
        wait 0.05;
    }
    
    while ( issuperinuse() )
    {
        reducesuperusepercent( drainrate );
        wait 0.05;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xc789c396, Offset: 0xb972
// Size: 0x79
function combatrecordsuperuse( super )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    safesuper = function_8738421e46f2cfbc( super );
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "superStats", safesuper, "uses" );
    self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "superStats", safesuper, "uses", oldvalue + 1 );
}

// Namespace supers_mp
// Params 1
// Checksum 0x61b79735, Offset: 0xb9f3
// Size: 0x67
function combatrecordsuperkill( super )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    oldvalue = self getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "superStats", super, "kills" );
    self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "superStats", super, "kills", oldvalue + 1 );
}

// Namespace supers_mp
// Params 2
// Checksum 0x6adbc8fe, Offset: 0xba62
// Size: 0x61
function combatrecordsupermisc( super, increment )
{
    if ( !stats::canrecordcombatrecordstats() )
    {
        return;
    }
    
    if ( !isdefined( increment ) )
    {
        increment = 1;
    }
    
    oldvalue = getcombatrecordsupermisc( super );
    self setplayerdata( level.var_6f9b00680ed002d8, "playerStats", "superStats", super, "misc1", oldvalue + increment );
}

// Namespace supers_mp
// Params 1
// Checksum 0x7e648772, Offset: 0xbacb
// Size: 0x2b
function getcombatrecordsupermisc( super )
{
    return self getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "superStats", super, "misc1" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x28a51293, Offset: 0xbaff
// Size: 0xd
function choppergunnerbeginuse()
{
    return killstreaks::trytriggerkillstreakfromsuper( "chopper_gunner" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x55d83e89, Offset: 0xbb15
// Size: 0xd
function cruisepredatorbeginuse()
{
    return killstreaks::trytriggerkillstreakfromsuper( "cruise_predator" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xf9b2fe88, Offset: 0xbb2b
// Size: 0xda, Type: bool
function scramblebeginuse()
{
    scrambleent = spawn( "script_model", self.origin + ( 0, 0, 400 ) );
    self.scrambleent = scrambleent;
    self.scrambleent setmodel( "super_scramble_mp" );
    self.scrambleent linkto( self );
    self.scrambleent.owner = self;
    self.scrambleent.team = self.team;
    self.scrambleent setotherent( self );
    self.scrambleent setscriptablepartstate( "scramble_sfx", "on", 0 );
    self.scrambleent thread utility::callsharedfunc( #"scrambler_drone_guard", #"watchjammedeffectdist", self );
    return true;
}

// Namespace supers_mp
// Params 1
// Checksum 0xcc7ebd8c, Offset: 0xbc0e
// Size: 0x41
function scrambleusefinished( fromdeath )
{
    self.scrambleent unlink();
    self.scrambleent delete();
    utility::callsharedfunc( #"scrambler_drone_guard", #"endjammedeffect" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xcbab1352, Offset: 0xbc57
// Size: 0x2
function remotedetonateonset()
{
    
}

// Namespace supers_mp
// Params 0
// Checksum 0x23c83b6f, Offset: 0xbc61
// Size: 0x2
function remotedetonatebeginuse()
{
    
}

// Namespace supers_mp
// Params 0
// Checksum 0x40f00a74, Offset: 0xbc6b
// Size: 0xd
function precisionairstrikebeginuse()
{
    return killstreaks::trytriggerkillstreakfromsuper( "precision_airstrike" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xe82e9560, Offset: 0xbc81
// Size: 0xd
function tomastrikebeginuse()
{
    return killstreaks::trytriggerkillstreakfromsuper( "toma_strike" );
}

// Namespace supers_mp
// Params 0
// Checksum 0xa6312800, Offset: 0xbc97
// Size: 0xd
function pacsentrybeginuse()
{
    return killstreaks::trytriggerkillstreakfromsuper( "pac_sentry" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x56b71b19, Offset: 0xbcad
// Size: 0x2
function brcircleextract()
{
    
}

// Namespace supers_mp
// Params 0
// Checksum 0x22902902, Offset: 0xbcb7
// Size: 0xd
function uavbeginuse()
{
    return killstreaks::trytriggerkillstreakfromsuper( "uav" );
}

// Namespace supers_mp
// Params 0
// Checksum 0x90fcaccb, Offset: 0xbccd
// Size: 0x4, Type: bool
function function_30cf20678e7024d5()
{
    return true;
}

// Namespace supers_mp
// Params 1
// Checksum 0x688990aa, Offset: 0xbcda
// Size: 0x46
function function_c805ff9720d542d1( objweapon )
{
    if ( utility::issharedfuncdefined( #"super_evg", #"hash_4427bf052c5b31fb" ) )
    {
        return utility::callsharedfunc( #"super_evg", #"hash_4427bf052c5b31fb", objweapon );
    }
    
    return;
}

// Namespace supers_mp
// Params 1
// Checksum 0x43beddbc, Offset: 0xbd28
// Size: 0x46
function function_b05dbd2d306d946a( objweapon )
{
    if ( utility::issharedfuncdefined( #"super_evg", #"given" ) )
    {
        return utility::callsharedfunc( #"super_evg", #"given", objweapon );
    }
    
    return;
}

// Namespace supers_mp
// Params 0
// Checksum 0x233e64f2, Offset: 0xbd76
// Size: 0x8
function superweapondropbeginuse()
{
    return weapon_drop::weapondrop_beginsuper();
}

// Namespace supers_mp
// Params 0
// Checksum 0xf27a83f5, Offset: 0xbd87
// Size: 0x39
function popcandybeginuse()
{
    if ( utility::issharedfuncdefined( #"super_pop_candy", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_pop_candy", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x43cdcac1, Offset: 0xbdc9
// Size: 0x4c
function function_427e881721868562( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_pop_candy", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_pop_candy", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x90d73f94, Offset: 0xbe1e
// Size: 0x39
function popcandyongive()
{
    if ( utility::issharedfuncdefined( #"super_pop_candy", #"ongive" ) )
    {
        return [[ utility::getsharedfunc( #"super_pop_candy", #"ongive" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x38daa844, Offset: 0xbe60
// Size: 0x39
function popcandyunset()
{
    if ( utility::issharedfuncdefined( #"super_pop_candy", #"unset" ) )
    {
        return [[ utility::getsharedfunc( #"super_pop_candy", #"unset" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x31eeabca, Offset: 0xbea2
// Size: 0x39
function function_49fc50b678e39594()
{
    if ( utility::issharedfuncdefined( #"super_mutation_ninja_vanish", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_ninja_vanish", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x37738b83, Offset: 0xbee4
// Size: 0x4c
function function_7ab0ca01e6a3d614( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_mutation_ninja_vanish", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_ninja_vanish", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x702c9156, Offset: 0xbf39
// Size: 0x39
function function_4967df4f1b779332()
{
    if ( utility::issharedfuncdefined( #"super_mutation_shuriken_fury", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_shuriken_fury", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x7b5692b9, Offset: 0xbf7b
// Size: 0x4c
function function_efd6f6278efa9cda( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_mutation_shuriken_fury", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_shuriken_fury", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0xac222a94, Offset: 0xbfd0
// Size: 0x39
function function_f8d8d71909e4d670()
{
    if ( utility::issharedfuncdefined( #"super_mutation_turtle_power", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_turtle_power", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0xff0ec9a9, Offset: 0xc012
// Size: 0x39
function function_247d5bb630e92344()
{
    if ( utility::issharedfuncdefined( #"super_mutation_shell_shocked", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_shell_shocked", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0xf993157, Offset: 0xc054
// Size: 0x4c
function function_77cb1af7cc3abcc4( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_mutation_shell_shocked", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_shell_shocked", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0xbf8f287c, Offset: 0xc0a9
// Size: 0x39
function function_9cb5a52d7a8a4a81()
{
    if ( utility::issharedfuncdefined( #"super_mutation_shell_shocked", #"ongive" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_shell_shocked", #"ongive" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0xc0706611, Offset: 0xc0eb
// Size: 0x4c
function function_5a2ff6e9d94d5250( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_mutation_turtle_power", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_turtle_power", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x789ca447, Offset: 0xc140
// Size: 0x39
function function_ce1365413503ca17()
{
    if ( utility::issharedfuncdefined( #"super_mutation_ninja_sense", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_ninja_sense", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x7e1616d6, Offset: 0xc182
// Size: 0x4c
function function_ef339a2cdcaf030b( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_mutation_ninja_sense", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_ninja_sense", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0xc68241e, Offset: 0xc1d7
// Size: 0x39
function function_e5cfebb7610612fa()
{
    if ( utility::issharedfuncdefined( #"super_mutation_boba_stim", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_mutation_boba_stim", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x6dd7bd6c, Offset: 0xc219
// Size: 0x39
function function_4ef0fe1d10775a2e()
{
    if ( utility::issharedfuncdefined( #"super_contract_skipper", #"beginuse" ) )
    {
        return [[ utility::getsharedfunc( #"super_contract_skipper", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x2e18dc98, Offset: 0xc25b
// Size: 0x4c
function function_ed90b28fca65b4c6( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_contract_skipper", #"enduse" ) )
    {
        return [[ utility::getsharedfunc( #"super_contract_skipper", #"enduse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0xfd0229cd, Offset: 0xc2b0
// Size: 0x39
function function_fc8b4aa9c1978f92()
{
    if ( utility::issharedfuncdefined( #"super_contract_skipper", #"ongive" ) )
    {
        return [[ utility::getsharedfunc( #"super_contract_skipper", #"ongive" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x30281a51, Offset: 0xc2f2
// Size: 0x39
function function_62ee57bc0d973e27()
{
    if ( utility::issharedfuncdefined( #"super_contract_skipper", #"unset" ) )
    {
        return [[ utility::getsharedfunc( #"super_contract_skipper", #"unset" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x2cfdbfaf, Offset: 0xc334
// Size: 0x38
function launcherset()
{
    if ( utility::issharedfuncdefined( #"super_launcher", #"launcher_set" ) )
    {
        return [[ utility::getsharedfunc( #"super_launcher", #"launcher_set" ) ]]();
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x108b9a3a, Offset: 0xc375
// Size: 0x38
function launcherunset()
{
    if ( utility::issharedfuncdefined( #"super_launcher", #"launcher_unset" ) )
    {
        return [[ utility::getsharedfunc( #"super_launcher", #"launcher_unset" ) ]]();
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x47e4921a, Offset: 0xc3b6
// Size: 0x38
function launcherbeginuse()
{
    if ( utility::issharedfuncdefined( #"super_launcher", #"launcher_begin_use" ) )
    {
        return [[ utility::getsharedfunc( #"super_launcher", #"launcher_begin_use" ) ]]();
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0x97b074fd, Offset: 0xc3f7
// Size: 0x4d
function launcherenduse( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_launcher", #"hash_8a3d7d37704cafeb" ) )
    {
        return [[ utility::getsharedfunc( #"super_launcher", #"hash_8a3d7d37704cafeb" ) ]]( fromdeath );
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x5473bc0b, Offset: 0xc44d
// Size: 0x38
function function_4dc3365911c16eac()
{
    if ( utility::issharedfuncdefined( #"super_launcher", #"launcher_repeat" ) )
    {
        return [[ utility::getsharedfunc( #"super_launcher", #"launcher_repeat" ) ]]();
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xe82b02b, Offset: 0xc48e
// Size: 0x26
function function_7e9dfc75ee02fb34()
{
    success = 0;
    success = function_a456d0290912f49();
    
    if ( success )
    {
        success = oxygenmask::function_c5fe7c2382c44c3b();
    }
    
    return success;
}

// Namespace supers_mp
// Params 0
// Checksum 0x8997b1d4, Offset: 0xc4bd
// Size: 0x2
function tempvongive()
{
    
}

// Namespace supers_mp
// Params 0
// Checksum 0x15001ddc, Offset: 0xc4c7
// Size: 0x2
function tempvbeginuse()
{
    
}

// Namespace supers_mp
// Params 2
// Checksum 0x5a8d4481, Offset: 0xc4d1
// Size: 0x15
function function_3a2b91c6106b9aaa( fromdeath, attacker )
{
    
}

// Namespace supers_mp
// Params 0
// Checksum 0x8f4a10b5, Offset: 0xc4ee
// Size: 0x8
function function_4ea1a134644a2eab()
{
    return honeypot::honeypotbeginuse();
}

// Namespace supers_mp
// Params 2
// Checksum 0x621f16, Offset: 0xc4ff
// Size: 0x1d
function function_710e709d51f03fbf( fromdeath, attacker )
{
    return honeypot::function_9e58ff472f719f2c( attacker );
}

// Namespace supers_mp
// Params 0
// Checksum 0x22e42a5c, Offset: 0xc525
// Size: 0x3a
function function_bf3102573af5c490()
{
    func = level.sharedfuncs[ #"super_acoustic_amp" ][ #"beginuse" ];
    return isdefined( func ) ? self [[ func ]]() : 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x12413e6d, Offset: 0xc568
// Size: 0x50
function function_262676e0279bbd70( fromdeath, attacker )
{
    func = level.sharedfuncs[ #"super_acoustic_amp" ][ #"enduse" ];
    return isdefined( func ) ? self [[ func ]]( fromdeath, attacker ) : 0;
}

// Namespace supers_mp
// Params 1
// Checksum 0x6d517ae4, Offset: 0xc5c1
// Size: 0x5c
function superselectonset( slot )
{
    superinfo = getcurrentsuper( slot );
    firstupgrade = perkpackage::perkpackage_getfirstfieldupgrade();
    superinfo.firstupgrade = firstupgrade;
    secondupgrade = perkpackage::perkpackage_getsecondfieldupgrade();
    superinfo.secondupgrade = secondupgrade;
}

// Namespace supers_mp
// Params 2
// Checksum 0xcb21368a, Offset: 0xc625
// Size: 0xcc
function function_f520ad17bbf59ded( firstupgrade = perkpackage::perkpackage_getfirstfieldupgrade(), secondupgrade = perkpackage::perkpackage_getsecondfieldupgrade() )
{
    staticdata = level.superglobals.staticsuperdata[ firstupgrade ];
    var_2a3ea900428a2b6a = 0;
    
    if ( isdefined( staticdata ) )
    {
        var_2a3ea900428a2b6a = staticdata.pointsneeded;
    }
    
    staticdata = level.superglobals.staticsuperdata[ secondupgrade ];
    var_6a4a5b1cbfd2c0cc = 0;
    
    if ( isdefined( staticdata ) )
    {
        var_6a4a5b1cbfd2c0cc = staticdata.pointsneeded;
    }
    
    var_5a4121583f3e739e = max( var_2a3ea900428a2b6a, var_6a4a5b1cbfd2c0cc );
    self.perkpackagedata.overridepointsneeded = var_5a4121583f3e739e;
}

// Namespace supers_mp
// Params 1
// Checksum 0x6ad92f13, Offset: 0xc6f9
// Size: 0xc1
function function_b2ad0e92714d61d7( superref )
{
    if ( !superref )
    {
        return 0;
    }
    
    if ( isdefined( level.superglobals.staticsuperdata[ superref ].var_b2ad0e92714d61d7 ) )
    {
        return level.superglobals.staticsuperdata[ superref ].var_b2ad0e92714d61d7;
    }
    
    superbundle = function_5ffd3dfa9cc1e8de( superref );
    
    if ( !superbundle )
    {
        return 0;
    }
    
    level.superglobals.staticsuperdata[ superref ].var_b2ad0e92714d61d7 = superbundle.var_b2ad0e92714d61d7;
    return level.superglobals.staticsuperdata[ superref ].var_b2ad0e92714d61d7;
}

// Namespace supers_mp
// Params 1
// Checksum 0x6ad92f13, Offset: 0xc7c3
// Size: 0xc1
function function_5cf25d35be09368b( superref )
{
    if ( !superref )
    {
        return 0;
    }
    
    if ( isdefined( level.superglobals.staticsuperdata[ superref ].var_5cf25d35be09368b ) )
    {
        return level.superglobals.staticsuperdata[ superref ].var_5cf25d35be09368b;
    }
    
    superbundle = function_5ffd3dfa9cc1e8de( superref );
    
    if ( !superbundle )
    {
        return 0;
    }
    
    level.superglobals.staticsuperdata[ superref ].var_5cf25d35be09368b = superbundle.var_5cf25d35be09368b;
    return level.superglobals.staticsuperdata[ superref ].var_5cf25d35be09368b;
}

// Namespace supers_mp
// Params 0
// Checksum 0xa7228d13, Offset: 0xc88d
// Size: 0x15
function function_7c7012c332084e14()
{
    self.perkpackagedata.overridepointsneeded = undefined;
}

// Namespace supers_mp
// Params 0
// Checksum 0x8a23419d, Offset: 0xc8aa
// Size: 0x9
function superselectonunset()
{
    function_29f357380e385305();
}

// Namespace supers_mp
// Params 1
// Checksum 0x9c42e186, Offset: 0xc8bb
// Size: 0x6f
function function_912b93e3713c8d84( objweapon )
{
    if ( isdefined( self.var_6d6795272a56d9a5 ) )
    {
        var_dac3862f45fca33f = level.superglobals.staticsuperdata[ self.var_6d6795272a56d9a5 ];
        
        if ( isdefined( var_dac3862f45fca33f.var_a7ba5cee6855a3ad ) )
        {
            if ( [[ var_dac3862f45fca33f.var_a7ba5cee6855a3ad ]]( objweapon ) )
            {
                self notify( #"perkpackagemenu_close" );
            }
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xf0b63925, Offset: 0xc932
// Size: 0x8
function superselectbeginuse()
{
    return perkpackage::perkpackage_openselect();
}

// Namespace supers_mp
// Params 0
// Checksum 0x2fef0f83, Offset: 0xc943
// Size: 0x93
function selectongive()
{
    firstupgrade = perkpackage::perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage::perkpackage_getsecondfieldupgrade();
    
    if ( !isdefined( self.var_6d6795272a56d9a5 ) || self.var_6d6795272a56d9a5 == "super_emp_pulse" )
    {
        if ( firstupgrade == "super_emp_pulse" || secondupgrade == "super_emp_pulse" )
        {
            if ( utility::issharedfuncdefined( #"super_emp_pulse", #"hash_74c6903d2738b02c" ) )
            {
                self [[ utility::getsharedfunc( #"super_emp_pulse", #"hash_74c6903d2738b02c" ) ]]();
            }
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x83207186, Offset: 0xc9de
// Size: 0xb, Type: bool
function testsuperbeginuse()
{
    thread testsuperrefundwatcher();
    return true;
}

// Namespace supers_mp
// Params 0
// Checksum 0xd0b3a81b, Offset: 0xc9f2
// Size: 0x4, Type: bool
function superfultonbeginuse()
{
    return true;
}

// Namespace supers_mp
// Params 0
// Checksum 0xd7a266cd, Offset: 0xc9ff
// Size: 0x4, Type: bool
function supersupplydropbeginuse()
{
    return true;
}

// Namespace supers_mp
// Params 0
// Checksum 0x1d2d1530, Offset: 0xca0c
// Size: 0x8
function function_f747ac7ddc6fb58a()
{
    return vehicle_drop::function_7d294a933f391ac0();
}

// Namespace supers_mp
// Params 0
// Checksum 0x990d5eb, Offset: 0xca1d
// Size: 0x3b
function function_ff9ba713901cfaeb()
{
    if ( utility::issharedfuncdefined( #"super_laststand_syringe", #"beginuse", 1 ) )
    {
        return [[ utility::getsharedfunc( #"super_laststand_syringe", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x39e719fe, Offset: 0xca61
// Size: 0x50
function function_25796e9fde1a9aff( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_laststand_syringe", #"enduse", 1 ) )
    {
        return [[ utility::getsharedfunc( #"super_laststand_syringe", #"enduse" ) ]]( fromdeath );
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0xbf8a7b8e, Offset: 0xcaba
// Size: 0x3b
function spykitbeginuse()
{
    if ( utility::issharedfuncdefined( #"super_spykit", #"beginuse", 1 ) )
    {
        return [[ utility::getsharedfunc( #"super_spykit", #"beginuse" ) ]]();
    }
    
    return 0;
}

// Namespace supers_mp
// Params 2
// Checksum 0x66509130, Offset: 0xcafe
// Size: 0x50
function function_92a81da74a54495c( fromdeath, attacker )
{
    if ( utility::issharedfuncdefined( #"super_spykit", #"enduse", 1 ) )
    {
        return [[ utility::getsharedfunc( #"super_spykit", #"enduse" ) ]]( fromdeath );
    }
    
    return 0;
}

// Namespace supers_mp
// Params 0
// Checksum 0x8d968752, Offset: 0xcb57
// Size: 0x48
function testsuperrefundwatcher()
{
    self endon( #"super_use_finished" );
    
    while ( true )
    {
        if ( self buttonpressed( "BUTTON_X" ) )
        {
            superusefinished( 0, 0, 1 );
        }
        else if ( self buttonpressed( "BUTTON_Y" ) )
        {
            superusefinished( 1 );
        }
        
        waitframe();
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0x70fbe9a, Offset: 0xcba7
// Size: 0x83
function showsuperremindersplash()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !self.superreminderset )
    {
        self notify( #"hash_2f38db64a6e34c16" );
        self endon( #"hash_2f38db64a6e34c16" );
        self.superreminderset = 1;
        self setclientomnvar( "ui_super_reminder", 1 );
        wait 0.5;
        thread clearsuperremindersplash();
        return;
    }
    
    thread clearsuperremindersplash();
    self endon( #"hash_2f38db64a6e34c16" );
    waitframe();
    thread showsuperremindersplash();
    return;
}

// Namespace supers_mp
// Params 0
// Checksum 0xa2872e14, Offset: 0xcc32
// Size: 0x24
function clearsuperremindersplash()
{
    self notify( #"hash_2f38db64a6e34c16" );
    self.superreminderset = undefined;
    self setclientomnvar( "ui_super_reminder", 0 );
}

// Namespace supers_mp
// Params 1
// Checksum 0x252a3562, Offset: 0xcc5e
// Size: 0x2d
function clearsuperreminderondeath( params )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    thread clearsuperreminderondeathinternal( player );
}

// Namespace supers_mp
// Params 1
// Checksum 0x3fad5b98, Offset: 0xcc93
// Size: 0x30
function clearsuperreminderondeathinternal( player )
{
    player endon( #"disconnect" );
    player waittill( #"death" );
    player clearsuperremindersplash();
}

// Namespace supers_mp
// Params 0
// Checksum 0x5bddbf63, Offset: 0xcccb
// Size: 0x75
function initsuperdvars()
{
    /#
        setdevdvarifuninitialized( @"hash_eba0ef12e9c9260b", 0 );
        setdevdvarifuninitialized( @"scr_superlotteryenabled", 0 );
        setdevdvarifuninitialized( @"hash_89ab277fb91d0852", 60 );
        setdevdvarifuninitialized( @"hash_eea9235538d727fe", 45 );
        setdevdvarifuninitialized( @"hash_ee86355538b107dc", 90 );
        setdevdvarifuninitialized( @"hash_71b04bfc490e137a", 0 );
    #/
    
    setdvarifuninitialized( @"scr_super_decay_rate", 6 );
}

// Namespace supers_mp
// Params 0
// Checksum 0x2cb86961, Offset: 0xcd48
// Size: 0xa3
function function_2da12fb909f15abd()
{
    givesuperonspawn = 0;
    var_385fefa79e4f1bde = 0;
    gametypebundle = level.gametypebundle;
    
    if ( isdefined( gametypebundle ) )
    {
        givesuperonspawn = istrue( gametypebundle.givesuperonspawn );
        var_385fefa79e4f1bde = istrue( gametypebundle.var_385fefa79e4f1bde );
    }
    
    var_36df84c97a17f61e = getdvarint( @"hash_71b04bfc490e137a", 0 );
    
    if ( givesuperonspawn || var_36df84c97a17f61e )
    {
        level.superglobals.givesuperonspawn = var_36df84c97a17f61e;
    }
    
    if ( var_385fefa79e4f1bde )
    {
        level.superglobals.var_385fefa79e4f1bde = var_385fefa79e4f1bde;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x7ca8bc5, Offset: 0xcdf3
// Size: 0x341
function watchsuperlottery( slot )
{
    level endon( #"game_ended" );
    var_20e4a5a95890f981 = getdvarint( @"hash_89ab277fb91d0852", 60 );
    var_e0d047cdb3d5953d = getdvarint( @"hash_eea9235538d727fe", 45 );
    var_e0ad51cdb3af6383 = getdvarint( @"hash_ee86355538b107dc", 90 );
    var_6af9de7341ca5f60 = var_e0ad51cdb3af6383 - var_e0d047cdb3d5953d;
    assert( var_e0d047cdb3d5953d > 0 && var_e0d047cdb3d5953d < var_e0ad51cdb3af6383 );
    waitframe();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_over" );
    }
    
    wait var_20e4a5a95890f981;
    superlotteryenabledold = undefined;
    superlotteryenabled = undefined;
    var_c11761acef9bc363 = [];
    teamwinners = [];
    
    foreach ( entry in level.teamnamelist )
    {
        var_c11761acef9bc363[ entry ] = undefined;
        teamwinners[ entry ] = [];
    }
    
    while ( true )
    {
        superlotteryenabledold = superlotteryenabled;
        superlotteryenabled = getdvarint( @"scr_superlotteryenabled", 0 ) > 0;
        
        if ( superlotteryenabledold != superlotteryenabled )
        {
            if ( superlotteryenabled )
            {
                level notify( function_cc6f5a44b1441e16( slot, "superLotteryEnabled" ) );
            }
            else
            {
                level notify( function_cc6f5a44b1441e16( slot, "superLotteryDisabled" ) );
            }
        }
        
        foreach ( entry in level.teamnamelist )
        {
            if ( !isdefined( var_c11761acef9bc363[ entry ] ) )
            {
                var_c11761acef9bc363[ entry ] = gettime() + ( var_e0d047cdb3d5953d + randomint( var_6af9de7341ca5f60 ) ) * 1000;
                continue;
            }
            
            if ( var_c11761acef9bc363[ entry ] <= gettime() )
            {
                players = teams::getteamdata( entry, "players" );
                
                if ( players.size > 0 )
                {
                    players = arrayrandomize( players );
                    var_8a2cb40d19a343fc = [];
                    bestplayer = undefined;
                    
                    foreach ( player in players )
                    {
                        if ( !arraycontains( teamwinners[ entry ], player ) )
                        {
                            if ( isdefined( player getcurrentsuper( slot ) ) )
                            {
                                bestplayer = player;
                                break;
                            }
                            
                            continue;
                        }
                        
                        if ( isdefined( player getcurrentsuper( slot ) ) )
                        {
                            var_8a2cb40d19a343fc[ var_8a2cb40d19a343fc.size ] = player;
                        }
                    }
                    
                    if ( !isdefined( bestplayer ) )
                    {
                        if ( isdefined( var_8a2cb40d19a343fc[ 0 ] ) )
                        {
                            bestplayer = var_8a2cb40d19a343fc[ 0 ];
                        }
                        else
                        {
                            bestplayer = players[ 0 ];
                        }
                    }
                    
                    if ( superlotteryenabled )
                    {
                        childthread awardsuperlottery( bestplayer, slot );
                    }
                    
                    teamwinners[ teamwinners.size ] = bestplayer;
                }
                
                var_c11761acef9bc363[ entry ] = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0x53db9284, Offset: 0xd13c
// Size: 0xb1
function awardsuperlottery( player, slot )
{
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    level endon( function_cc6f5a44b1441e16( slot, "superLotteryDisabled" ) );
    player notify( function_cc6f5a44b1441e16( slot, "awardSuperLottery" ) );
    player endon( function_cc6f5a44b1441e16( slot, "awardSuperLottery" ) );
    
    while ( true )
    {
        superinfo = player getcurrentsuper( slot );
        
        if ( !isdefined( superinfo ) )
        {
            return;
        }
        
        if ( !player issuperinuse( slot ) )
        {
            break;
        }
        
        waitframe();
    }
    
    player givesuperpoints( getsuperpointsneeded( undefined, slot ), undefined, 1, undefined, undefined, undefined, slot );
}

// Namespace supers_mp
// Params 0
// Checksum 0x5723fa5c, Offset: 0xd1f5
// Size: 0x30
function getscriptdataversion()
{
    if ( getdvarint( @"scr_playtest_qa", 0 ) != 0 )
    {
        return 254;
    }
    
    if ( getdvarint( @"scr_playtest", 0 ) != 0 )
    {
        return 7;
    }
    
    return 254;
}

// Namespace supers_mp
// Params 3
// Checksum 0x559abcf0, Offset: 0xd22e
// Size: 0x11c
function function_8cb3b4861e05f17( supername, durability, timeremaining )
{
    player = self;
    
    if ( !isdefined( supername ) )
    {
        return;
    }
    
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_super_reclaimed", [ "super_name", supername, "durability", durability ?? -1, "time_remaining", timeremaining ?? -1, "playlist_name", getplaylistname(), "playlist_id", getplaylistid(), "map_name", level.mapname, "circle_index", circleindex, "reclaim_time", int( gettime() / 1000 ) ] );
}

// Namespace supers_mp
// Params 1
// Checksum 0x278e072a, Offset: 0xd352
// Size: 0xc2
function recordsuperearnedanalytics( superinfo )
{
    if ( getdvarint( @"hash_13856880331b5596", 0 ) == 0 )
    {
        return;
    }
    
    timeplayed = persistence::statgetchildbuffered( "round", "timePlayed", 1 ) / 60;
    dlog_recordevent( "mpscript_super_earning", [ "super_ref", superinfo.staticdata.ref, "earn_time", timeplayed, "gamemode", game_utility::getgametype(), "script_version", getscriptdataversion(), "earned_count", self.pers[ "supersEarned" ] ] );
}

// Namespace supers_mp
// Params 2
// Checksum 0x15f23727, Offset: 0xd41c
// Size: 0x106
function getsupermaxammo( superinfo, var_5a3c88492f192508 )
{
    superweapon = var_5a3c88492f192508 ? function_6c912116c8af1159( superinfo ) : superinfo.weaponobj;
    
    if ( !isdefined( superweapon ) )
    {
        return 1;
    }
    
    maxclipammo = weaponmaxammo( superweapon );
    ammopool = 0;
    
    if ( var_5a3c88492f192508 )
    {
        ammopool += superinfo.staticdata.useweaponclipammo;
        ammopool += min( maxclipammo, superinfo.staticdata.useweaponstockammo );
    }
    else
    {
        ammopool += min( maxclipammo, superinfo.staticdata.weaponammo );
    }
    
    if ( ammopool == 0 )
    {
        ammopool = 1;
        supername = superinfo.staticdata.ref ?? "none";
        script::demoforcesre( "Ammo Pool of 0 warning! Divide by 0 likely imminent. [getSuperMaxAmmo] for super " + supername );
    }
    
    return ammopool;
}

// Namespace supers_mp
// Params 2
// Checksum 0x3f12ca4, Offset: 0xd52b
// Size: 0x2f
function function_88ef58d2fa3e72c0( superinfo, var_5a3c88492f192508 )
{
    ammopool = getsupermaxammo( superinfo, var_5a3c88492f192508 );
    return 1 / ammopool;
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xdf91cd62, Offset: 0xd563
// Size: 0x15c
function private function_6aeefc1da271daa4( superinfo )
{
    if ( !isdefined( level.gamemodebundle ) || !level.gamemodebundle.var_ed83f0f1668a6ed2 )
    {
        return 0;
    }
    
    if ( !( isdefined( self.perkpackagedata ) && isdefined( self.perkpackagedata.weaponclipammo[ superinfo.staticdata.ref ] ) && isdefined( self.perkpackagedata.weaponstockammo[ superinfo.staticdata.ref ] ) ) )
    {
        return 0;
    }
    
    maxclipammo = weaponmaxammo( function_6c912116c8af1159( superinfo ) );
    ammopool = 0;
    ammopool += superinfo.staticdata.useweaponclipammo;
    ammopool += min( maxclipammo, superinfo.staticdata.useweaponstockammo );
    curammo = self.perkpackagedata.weaponclipammo[ superinfo.staticdata.ref ] + self.perkpackagedata.weaponstockammo[ superinfo.staticdata.ref ];
    return ammopool - curammo;
}

// Namespace supers_mp
// Params 1
// Checksum 0x8238c2bc, Offset: 0xd6c8
// Size: 0x68
function function_75a8cc70a1a5d51f( destroyfunc )
{
    isoob = outofbounds::ispointinoutofbounds( self.origin, self.owner.team );
    
    if ( isoob )
    {
        if ( isdefined( destroyfunc ) )
        {
            self thread [[ destroyfunc ]]();
        }
        
        if ( isdefined( self.owner ) )
        {
            self.owner refundsuper();
        }
    }
}

// Namespace supers_mp
// Params 0
// Checksum 0xed02894, Offset: 0xd738
// Size: 0xeb
function function_29f357380e385305()
{
    fullclear = 0;
    
    if ( isdefined( self.var_6d6795272a56d9a5 ) )
    {
        var_7a07f4324da3a7a1 = level.superglobals.staticsuperdata[ self.var_6d6795272a56d9a5 ].var_1836be75d110dd2f;
        
        if ( !isdefined( var_7a07f4324da3a7a1 ) )
        {
            fullclear = 1;
        }
        else
        {
            id = level.superglobals.staticsuperdata[ self.var_6d6795272a56d9a5 ].id;
            var_1c309c36998b8efe = [[ level.superglobals.staticsuperdata[ self.var_6d6795272a56d9a5 ].var_1836be75d110dd2f ]]();
            
            if ( var_1c309c36998b8efe )
            {
                function_2ea603a86a682ab0( id, 0, 1 );
            }
            else
            {
                fullclear = 1;
            }
        }
    }
    else
    {
        fullclear = 1;
    }
    
    if ( fullclear )
    {
        function_2ea603a86a682ab0( 0 );
    }
}

// Namespace supers_mp
// Params 4
// Checksum 0x22b81602, Offset: 0xd82b
// Size: 0x1e6
function function_2ea603a86a682ab0( superid, var_e4f8988f56d45272, forceshow, slot )
{
    assert( isdefined( superid ), "<dev string:x61b>" );
    
    if ( superid == 0 )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_field_upgrade_use" );
        self setclientomnvar( omnvar, superid );
        
        if ( !var_e4f8988f56d45272 )
        {
            self.parkedwidgetid = undefined;
        }
        
        return;
    }
    
    canshow = 0;
    superinfo = getcurrentsuper( slot );
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( self.perkpackagedata.istwomode && !forceshow )
    {
        if ( !isdefined( self.perkpackagedata.lastsuper ) )
        {
            canshow = 1;
        }
        else if ( isdefined( self.parkedwidgetid ) )
        {
            var_f56bcce83a6f61bc = level.superglobals.supersbyid[ self.parkedwidgetid ];
            var_bda78a723a9d340d = level.superglobals.supersbyid[ superid ];
            var_25c0ea6a233d872b = level.superglobals.staticsuperdata[ var_f56bcce83a6f61bc ].var_3aeac118e14d2377;
            var_6aa8b6415a9b1848 = level.superglobals.staticsuperdata[ var_bda78a723a9d340d ].var_3aeac118e14d2377;
            
            if ( var_6aa8b6415a9b1848 == -1 )
            {
                canshow = 0;
            }
            else if ( var_6aa8b6415a9b1848 <= var_25c0ea6a233d872b )
            {
                canshow = 1;
            }
            else
            {
                canshow = 1;
                superid = self.parkedwidgetid;
            }
        }
        else
        {
            canshow = 1;
        }
    }
    else
    {
        canshow = 1;
    }
    
    if ( canshow || forceshow )
    {
        omnvar = function_c1488fa73d55ae70( slot, "ui_field_upgrade_use" );
        
        if ( omnvar )
        {
            self setclientomnvar( omnvar, superid );
        }
        
        self.parkedwidgetid = superid;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0xda225981, Offset: 0xda19
// Size: 0x50, Type: bool
function function_328cd660d9471655( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    switch ( objweapon.basename )
    {
        case #"hash_e2c74e289201361":
        case #"hash_c0d55eb64b4656ff":
        case #"hash_ca1eabc559246db2":
            return true;
    }
    
    return false;
}

// Namespace supers_mp
// Params 2
// Checksum 0xd8f6ffc6, Offset: 0xda72
// Size: 0x14e
function function_d629c90761cd2a1c( objweapon, isimmediate )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( !isweapon( objweapon ) )
    {
        if ( isstring( objweapon ) )
        {
            objweapon = makeweapon( objweapon );
        }
        
        assert( isweapon( objweapon ), "<dev string:x666>" );
    }
    
    if ( !val::get( "supers" ) )
    {
        return 0;
    }
    
    if ( !isweapon( objweapon ) )
    {
        self notify( #"hash_9d63d2adbbb146d1", objweapon );
        return 0;
    }
    
    if ( objweapon.classname == "grenade" )
    {
        self giveandfireoffhand( objweapon );
    }
    else
    {
        return inventory_utility::domonitoredweaponswitch( objweapon, isimmediate );
    }
    
    if ( !self hasweapon( objweapon ) )
    {
        self notify( #"hash_9d63d2adbbb146d1", objweapon );
        return 0;
    }
    
    result = spawnstruct();
    result childthread function_2d122fdfb0689311( self, objweapon );
    result childthread function_aa2ca0651f9872ec( self, objweapon );
    result waittill( #"race_start" );
    waittillframeend();
    result notify( #"race_end" );
    
    if ( result.success )
    {
        self notify( #"hash_81f31920b90c5146", objweapon );
        return 1;
    }
    
    if ( result.failure )
    {
        self notify( #"hash_3ab39a4e976b0270", objweapon );
        return 0;
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xa55f56c9, Offset: 0xdbc8
// Size: 0x4a
function function_2d122fdfb0689311( player, objweapon )
{
    self endon( #"race_end" );
    player waittillmatch( #"offhand_fired", objweapon );
    self.success = 1;
    self notify( #"race_start" );
}

// Namespace supers_mp
// Params 2
// Checksum 0xabbfeb3c, Offset: 0xdc1a
// Size: 0x55
function function_aa2ca0651f9872ec( player, objweapon )
{
    self endon( #"race_end" );
    
    while ( player hasweapon( objweapon ) && val::get( "supers" ) )
    {
        waitframe();
    }
    
    self.failure = 1;
    self notify( #"race_start" );
}

// Namespace supers_mp
// Params 2
// Checksum 0xce0ae72c, Offset: 0xdc77
// Size: 0x79, Type: bool
function superhastimedusage( superinfo = getcurrentsuper( slot ), slot )
{
    if ( !isdefined( superinfo ) )
    {
        return false;
    }
    
    assert( isdefined( superinfo.staticdata.var_c2fb965c9cd3dc5c ), "<dev string:x3cc>" );
    var_c2fb965c9cd3dc5c = superinfo.staticdata.var_c2fb965c9cd3dc5c;
    return var_c2fb965c9cd3dc5c == "TIME";
}

// Namespace supers_mp
// Params 2
// Checksum 0xe9583a33, Offset: 0xdcf9
// Size: 0x79, Type: bool
function superhasammousage( superinfo = getcurrentsuper( slot ), slot )
{
    if ( !isdefined( superinfo ) )
    {
        return false;
    }
    
    assert( isdefined( superinfo.staticdata.var_c2fb965c9cd3dc5c ), "<dev string:x3cc>" );
    var_c2fb965c9cd3dc5c = superinfo.staticdata.var_c2fb965c9cd3dc5c;
    return var_c2fb965c9cd3dc5c == "AMMO";
}

// Namespace supers_mp
// Params 4
// Checksum 0x18cf1fd0, Offset: 0xdd7b
// Size: 0x10d, Type: bool
function function_a456d0290912f49( skipfirstraise, isimmediate, var_686ab1c37bca9979, slot )
{
    setsuperisactive( 1, slot );
    superinfo = getcurrentsuper( slot );
    clipammo = superinfo.staticdata.useweaponclipammo;
    stockammo = superinfo.staticdata.useweaponstockammo;
    
    if ( isdefined( superinfo.var_91cdf2de88e5a13a ) )
    {
        clipammo = superinfo.var_91cdf2de88e5a13a.clipammo;
        stockammo = superinfo.var_91cdf2de88e5a13a.stockammo;
    }
    
    useweapon = function_6c912116c8af1159( superinfo );
    result = trygiveuseweapon( useweapon, clipammo, stockammo, skipfirstraise, isimmediate, var_686ab1c37bca9979, slot );
    
    if ( result )
    {
        setsuperisactive( 1, slot );
    }
    else
    {
        setsuperisactive( 0, slot );
    }
    
    return istrue( result );
}

// Namespace supers_mp
// Params 1
// Checksum 0xb6f1e88, Offset: 0xde91
// Size: 0x3c
function getsuperref( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( isdefined( superinfo ) )
    {
        return superinfo.staticdata.ref;
    }
}

// Namespace supers_mp
// Params 1
// Checksum 0x1d758b41, Offset: 0xded6
// Size: 0x58, Type: bool
function issuperpower( superref )
{
    switch ( superref )
    {
        case #"hash_758dccf604db9844":
        case #"hash_7fabc8194cf34999":
        case #"hash_d90c2bd8c6e12ea2":
        case #"hash_d9df50cd7638b51d":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace supers_mp
// Params 1
// Checksum 0x49105bbd, Offset: 0xdf37
// Size: 0x4e, Type: bool
function function_2041e16ed18271bc( slot )
{
    superinfo = getcurrentsuper( slot );
    
    if ( !( isdefined( superinfo ) && isdefined( superinfo.staticdata ) ) )
    {
        return false;
    }
    
    return istrue( superinfo.staticdata.isinfinite );
}

// Namespace supers_mp
// Params 2
// Checksum 0xeaf314f7, Offset: 0xdf8e
// Size: 0xad
function function_c7a8c9a907d7e68b( var_97c55dbdc94a406e, slot )
{
    if ( !function_2041e16ed18271bc( slot ) )
    {
        return;
    }
    
    superinfo = getcurrentsuper( slot );
    pointsneeded = getsuperpointsneeded( superinfo );
    var_50daf13c043521b9 = superinfo.staticdata.var_50daf13c043521b9;
    
    if ( isdefined( var_97c55dbdc94a406e ) && isdefined( var_50daf13c043521b9 ) )
    {
        var_50daf13c043521b9 *= var_97c55dbdc94a406e;
    }
    
    if ( !isdefined( var_50daf13c043521b9 ) || var_50daf13c043521b9 <= 0 )
    {
        superinfo.var_78ab73ad3b93eef1 = pointsneeded;
        return;
    }
    
    superinfo.var_78ab73ad3b93eef1 = pointsneeded / var_50daf13c043521b9 * 0.05;
}

// Namespace supers_mp
// Params 2
// Checksum 0xec51db64, Offset: 0xe043
// Size: 0xe0
function function_579d273895a60bdb( attacker, weaponobj )
{
    if ( !( isdefined( self.owner ) && isdefined( attacker ) ) || !isplayer( attacker ) || !player_utility::playersareenemies( self.owner, attacker ) )
    {
        return;
    }
    
    if ( isdefined( self.bundle ) )
    {
        superbundle = self.bundle;
    }
    else if ( isdefined( self.weapon_name ) )
    {
        superbundle = function_5ffd3dfa9cc1e8de( getsuperrefforsuperweapon( self.weapon_name ) );
    }
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    if ( isdefined( superbundle.var_5d7006fb6c782ce2 ) )
    {
        attacker thread points::doscoreevent( superbundle.var_5d7006fb6c782ce2, weaponobj );
        return;
    }
    
    attacker thread points::doscoreevent( #"destroyed_equipment" );
    attacker battlechatter_mp::equipmentdestroyed( self );
}

// Namespace supers_mp
// Params 2
// Checksum 0x448b0802, Offset: 0xe12b
// Size: 0xbc, Type: bool
function function_31f00fe6e0334d03( slot, bypassdisable )
{
    assert( isplayer( self ) );
    currentsuper = getcurrentsuper( slot );
    
    if ( !isdefined( currentsuper ) )
    {
        return false;
    }
    
    if ( level.allowsupers && ( !isbrgamemode() || getdvarint( @"hash_cff5a345501a7470", 0 ) ) )
    {
        return true;
    }
    
    if ( !self.var_760a3e04da86556f && !function_2041e16ed18271bc( slot ) )
    {
        return false;
    }
    
    if ( function_ec58b00bf38b48a8( currentsuper.staticdata.ref ) )
    {
        return false;
    }
    
    if ( self.var_2364be08b6facb67 && !bypassdisable )
    {
        return false;
    }
    
    return true;
}

// Namespace supers_mp
// Params 1
// Checksum 0x8c4f99ce, Offset: 0xe1f0
// Size: 0x144
function getsuperattachments( var_eca4b5330f088749 )
{
    /#
        if ( isbot( self ) )
        {
            superweaponname = level.superglobals.staticsuperdata[ var_eca4b5330f088749 ].weapon;
            
            if ( superweaponname )
            {
                superweapon = makeweapon( superweaponname );
                return function_a5902968fb664288( superweapon );
            }
        }
    #/
    
    superinfo = getcurrentsuper();
    
    if ( superinfo.staticdata.ref == var_eca4b5330f088749 )
    {
        if ( isarray( superinfo.attachments ) )
        {
            return superinfo.attachments;
        }
        
        if ( isarray( superinfo.var_7ef7600ff6978d76.attachments ) )
        {
            return superinfo.var_7ef7600ff6978d76.attachments;
        }
        
        if ( isarray( superinfo.weaponobj.attachments ) )
        {
            return superinfo.weaponobj.attachments;
        }
    }
    
    if ( self.loadoutfieldupgrade1 == var_eca4b5330f088749 )
    {
        return self.loadoutFieldUpgrade1Attachments;
    }
    else if ( self.loadoutfieldupgrade2 == var_eca4b5330f088749 )
    {
        return self.loadoutFieldUpgrade2Attachments;
    }
    
    return [];
}

// Namespace supers_mp
// Params 2
// Checksum 0x480092e5, Offset: 0xe33d
// Size: 0x7f, Type: bool
function function_d45945781d29204a( var_eca4b5330f088749, attachmentname )
{
    attachments = getsuperattachments( var_eca4b5330f088749 ) ?? [];
    var_af04b6fb987d0b = isxhashasset( attachmentname );
    
    for ( i = 0; i < attachments.size ; i++ )
    {
        var_763bd961b8332362 = var_af04b6fb987d0b ? getxhashasset( attachments[ i ] ) : attachments[ i ];
        
        if ( attachmentname == var_763bd961b8332362 )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace supers_mp
    // Params 1
    // Checksum 0x9d92cf04, Offset: 0xe3c5
    // Size: 0xbd, Type: dev
    function function_a5902968fb664288( var_4588ed7d75a32bf6 )
    {
        result = [];
        
        if ( !isdefined( self.var_e23e2367dfbe3011 ) )
        {
            self.var_e23e2367dfbe3011 = [];
        }
        
        foreach ( attachment in self.var_e23e2367dfbe3011 )
        {
            if ( var_4588ed7d75a32bf6 && function_5b465daf157fa9a1( var_4588ed7d75a32bf6, attachment ) != -1 )
            {
                result[ result.size ] = attachment;
            }
        }
        
        return result;
    }

#/

// Namespace supers_mp
// Params 0
// Checksum 0x50a600ec, Offset: 0xe48a
// Size: 0x21, Type: bool
function function_60dbd7e2f1b02c22()
{
    if ( isdefined( self.var_5564ebebb4cc0609 ) && !self.var_6eeba5380f051b )
    {
        return true;
    }
    
    return false;
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x8f5f9397, Offset: 0xe4b4
// Size: 0x51
function private function_9da92555efee3676( var_eca4b5330f088749 )
{
    if ( !isdefined( self._blackboard ) )
    {
        return;
    }
    
    self._blackboard.var_7b027229ad59ba7f = var_eca4b5330f088749;
    self._blackboard.var_ce2d65196d27fb6d = level.var_b72c376264827891[ var_eca4b5330f088749 ];
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xb9c2b1fa, Offset: 0xe50d
// Size: 0xdf
function private function_dbc8badb3eff31fc( superid )
{
    if ( isbrgamemode() )
    {
        [ squadmemberindex, squadmates ] = squads::function_53d0f06555f0036b();
        
        if ( !isdefined( squadmemberindex ) || !isdefined( squadmates ) || squadmates.size == 1 )
        {
            return;
        }
        
        foreach ( player in squadmates )
        {
            if ( isdefined( player ) )
            {
                player omnvar_utility::function_85d5f88af471ac4b( "ui_squad_field_upgrades", 8 * squadmemberindex, 8, superid );
            }
        }
    }
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0x24f4a83c, Offset: 0xe5f4
// Size: 0x31
function private function_d6ffc5c7abc5689( inuse )
{
    if ( !isdefined( self._blackboard ) )
    {
        return;
    }
    
    self._blackboard.var_f4284858019607d8 = inuse;
}

// Namespace supers_mp
// Params 1, eflags: 0x4
// Checksum 0xa7c5bb9b, Offset: 0xe62d
// Size: 0x107
function private set_field_upgrade_recharge_mult( value = 1 )
{
    assert( isplayer( self ) );
    assert( isnumber( value ) );
    scalar = 1;
    value_states = self.values[ "field_upgrade_recharge_mult" ];
    
    if ( isdefined( value_states ) && value_states.size )
    {
        foreach ( val in value_states )
        {
            scalar *= float( val );
        }
    }
    
    var_5b735f3136b34424 = !isdefined( value_states ) ? 1 : 0;
    self.var_7f51fbc2a4951e75 = var_5b735f3136b34424 ? undefined : scalar;
}

// Namespace supers_mp
// Params 0
// Checksum 0x7228d8ca, Offset: 0xe73c
// Size: 0x28, Type: bool
function function_fe4678cde55a525d()
{
    return !getdvarint( @"hash_d188ebd6aec32680", 0 ) && level.gametypebundle.var_b7e70fa484e134dc;
}

// Namespace supers_mp
// Params 2
// Checksum 0xda6e13aa, Offset: 0xe76d
// Size: 0x4d
function function_cc6f5a44b1441e16( slot, notify_str )
{
    if ( !isdefined( slot ) )
    {
        return notify_str;
    }
    
    switch ( slot )
    {
        case #"tactical":
            return ( "tactical_" + notify_str );
        default:
            return notify_str;
    }
}

// Namespace supers_mp
// Params 2
// Checksum 0xb151c8da, Offset: 0xe7c2
// Size: 0x3c
function function_c1488fa73d55ae70( slot, omnvar )
{
    if ( !slot || slot == #"default" )
    {
        return omnvar;
    }
    
    return level.super_omnvars[ slot ][ omnvar ];
}

// Namespace supers_mp
// Params 1
// Checksum 0xccdbf095, Offset: 0xe807
// Size: 0x38, Type: bool
function function_d703a675aad9f961( supername )
{
    is_in_use = issuperinuse();
    super_name = getcurrentsuperref();
    return is_in_use && super_name == supername;
}

// Namespace supers_mp
// Params 1
// Checksum 0xe868e890, Offset: 0xe848
// Size: 0xa1, Type: bool
function function_fb6534db15e3869c( supername )
{
    squadmates = teams::getsquadmates( self.team, undefined, 1 );
    
    foreach ( current_squadmate in squadmates )
    {
        if ( current_squadmate function_d703a675aad9f961( supername ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace supers_mp
// Params 2
// Checksum 0xfb395026, Offset: 0xe8f2
// Size: 0xeb
function function_c0901f58a21692ee( superinfo, useweapon )
{
    assert( isdefined( useweapon ), "<dev string:x6a6>" );
    
    foreach ( attachment in self.super.attachments )
    {
        if ( !useweapon hasattachment( attachment ) )
        {
            useweapon = weapons::addattachmenttoweapon( useweapon, attachment );
        }
        
        if ( !superinfo.var_7ef7600ff6978d76 hasattachment( attachment ) )
        {
            superinfo.var_7ef7600ff6978d76 = weapons::addattachmenttoweapon( superinfo.var_7ef7600ff6978d76, attachment );
        }
    }
    
    return useweapon;
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0xfb8c3596, Offset: 0xe9e6
// Size: 0x17f
function private function_437d9d55b3dd7693( superinfo, slot )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( slot ) )
    {
        slot = #"default";
    }
    
    if ( !isdefined( superinfo ) )
    {
        superinfo = getcurrentsuper( slot );
    }
    
    bundle = superinfo.staticdata.bundle;
    
    if ( self.pers[ "rechargeSupers" ][ slot ].ref != superinfo.staticdata.ref && slot == #"default" )
    {
        if ( !isdefined( self.pers[ "rechargeSupers" ][ slot ].ref ) )
        {
            thread function_a2252c20554fbfce();
        }
        
        self.pers[ "rechargeSupers" ][ slot ] = { #slot:slot, #var_85982bdb4573326b:bundle.var_85982bdb4573326b, #rechargetime:bundle.var_7ac7eeaab6f92f3d, #ref:superinfo.staticdata.ref };
        self.pers[ "rechargeSupers" ][ slot ].rechargeremaining = bundle.var_7ac7eeaab6f92f3d;
        function_ae5fac7304d0c32( superinfo, slot, 0 );
        updatesuperuistate( slot );
    }
}

// Namespace supers_mp
// Params 0, eflags: 0xc
// Checksum 0xcbfa45de, Offset: 0xeb6d
// Size: 0x2e0
function private function_a2252c20554fbfce()
{
    self notify( #"hash_a4e42b316e0281d5" );
    self endon( #"hash_a4e42b316e0281d5" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    rechargeinterval = getdvarfloat( @"hash_b840b298f92dae43", 0.1 );
    
    while ( true )
    {
        result = utility::waittill_any_timeout_no_endon_death( rechargeinterval, "super_started" );
        slot = #"default";
        superinfo = getcurrentsuper( slot );
        bundle = superinfo.staticdata.bundle;
        
        if ( !superinfo || !bundle.var_cc252fb1315910e5 )
        {
            self.pers[ "rechargeSupers" ][ slot ] = undefined;
            return;
        }
        
        if ( superinfo.isinuse )
        {
            continue;
        }
        
        if ( !player::isreallyalive( self ) && !bundle.var_85982bdb4573326b )
        {
            continue;
        }
        
        if ( !isdefined( self.pers[ "rechargeSupers" ] ) )
        {
            self.pers[ "rechargeSupers" ] = [];
        }
        
        if ( self.pers[ "rechargeSupers" ][ superinfo.slot ].ref != superinfo.staticdata.ref )
        {
            self.pers[ "rechargeSupers" ][ slot ] = { #slot:slot, #var_85982bdb4573326b:bundle.var_85982bdb4573326b, #rechargetime:bundle.var_7ac7eeaab6f92f3d, #ref:superinfo.staticdata.ref };
            self.pers[ "rechargeSupers" ][ slot ].rechargeremaining = bundle.var_7ac7eeaab6f92f3d;
        }
        
        super = self.pers[ "rechargeSupers" ][ slot ];
        
        if ( super.rechargeremaining > 0 )
        {
            rechargemod = 1;
            
            if ( isdefined( self.perks[ "specialty_faster_field_upgrade" ] ) )
            {
                rechargemod = getdvarfloat( @"perk_faster_field_upgrade_rate" );
            }
            
            super.rechargeremaining = max( super.rechargeremaining - rechargeinterval * rechargemod, 0 );
            progress = clamp( 1 - super.rechargeremaining / super.rechargetime, 0, 1 );
            
            if ( progress >= 1 )
            {
                superearned( slot );
            }
        }
        
        function_ae5fac7304d0c32( superinfo, slot, progress );
        updatesuperuistate( slot );
        function_1b82c2193d15ea65( slot );
    }
}

// Namespace supers_mp
// Params 3, eflags: 0x4
// Checksum 0xb4733752, Offset: 0xee55
// Size: 0x99
function private function_ae5fac7304d0c32( superinfo, slot, progress )
{
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( player::isinkillcam() || !player::isreallyalive( self ) )
    {
        superinfo.oldprogress = undefined;
        return;
    }
    
    if ( superinfo.isinuse )
    {
        progress = getsuperuseuiprogress( slot );
    }
    
    if ( !isdefined( superinfo.oldprogress ) || progress != superinfo.oldprogress )
    {
        thread function_cb3e288a8ed4df3e( progress, slot );
    }
    
    superinfo.oldprogress = progress;
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0xb0852b32, Offset: 0xeef6
// Size: 0x5d, Type: bool
function private function_cc252fb1315910e5( superinfo, slot )
{
    if ( getdvarint( @"hash_60cd4e941844e4cf", 0 ) )
    {
        return false;
    }
    
    if ( !isdefined( superinfo ) )
    {
        superinfo = getcurrentsuper( slot );
    }
    
    if ( superinfo.staticdata.bundle.var_cc252fb1315910e5 )
    {
        return true;
    }
    
    return false;
}

// Namespace supers_mp
// Params 2, eflags: 0x4
// Checksum 0x2174e7d5, Offset: 0xef5c
// Size: 0x89
function private function_1838b741d6675e2c( superinfo = getcurrentsuper( slot ), slot = #"default" )
{
    self.pers[ "rechargeSupers" ][ slot ].rechargeremaining = self.pers[ "rechargeSupers" ][ slot ].rechargetime ?? 0;
    function_ae5fac7304d0c32( superinfo, slot, 0 );
    updatesuperuistate( slot );
}

// Namespace supers_mp
// Params 0
// Checksum 0xd05bb693, Offset: 0xefed
// Size: 0xab7
function function_ddc24473fe4cd472()
{
    var_9b94963d80b15283 = function_391017e903b2f974();
    var_8b7d9c28ea0c2e99 = getscriptbundle( var_9b94963d80b15283 );
    
    for ( i = 0; i < var_8b7d9c28ea0c2e99.super_list.size ; i++ )
    {
        superref = var_8b7d9c28ea0c2e99.super_list[ i ].override_ref ?? var_8b7d9c28ea0c2e99.super_list[ i ].ref;
        superbundlename = var_8b7d9c28ea0c2e99.super_list[ i ].bundle;
        baseref = var_8b7d9c28ea0c2e99.super_list[ i ].ref;
        overrideref = var_8b7d9c28ea0c2e99.super_list[ i ].override_ref;
        
        if ( baseref && overrideref )
        {
            if ( !isdefined( level.superglobals.refoverrides ) )
            {
                level.superglobals.refoverrides = [];
            }
            
            level.superglobals.refoverrides[ baseref ] = { #overrideref:overrideref, #baseref:baseref };
            level.superglobals.refoverrides[ overrideref ] = { #overrideref:overrideref, #baseref:baseref };
        }
        
        if ( superref == "none" )
        {
            continue;
        }
        
        if ( isdefined( superbundlename ) && isdefined( superref ) && superref != "" )
        {
            superbundle = getscriptbundle( superbundlename );
            
            if ( isdefined( superbundle ) )
            {
                staticdata = {};
                level.superglobals.staticsuperdata[ superref ] = staticdata;
                staticdata.id = i;
                staticdata.ref = superref;
                staticdata.var_efcbef98efb5e5d = superbundle.superref ?? getxhash( superref );
                staticdata.var_4298b03a50e4e614 = superbundle.var_7b8bdbd6bf8e2b6d ?? staticdata.var_efcbef98efb5e5d;
                weapontype = superbundle.weapontype;
                weaponname = superbundle.offhandweapon;
                
                if ( weapontype == "BULLETWEAPON" || weapontype == "NOWEAPON" )
                {
                    if ( superbundle.var_5cf25d35be09368b )
                    {
                        weaponname = %"super_minor_default_mp";
                    }
                    else
                    {
                        weaponname = %"super_default_mp";
                    }
                }
                
                staticdata.weapontype = weapontype;
                staticdata.weapon = weaponname;
                blueprints = getweaponblueprintnames( weaponname );
                
                foreach ( blueprint, index in blueprints )
                {
                    var_5b5a4f8ed605f4d6 = weaponname + "|" + string( index );
                    level.superblueprints[ var_5b5a4f8ed605f4d6 ] = function_6a820129c91338cb( weaponname, blueprint );
                }
                
                staticdata.bundle = superbundle;
                pointsneeded = undefined;
                usetime = undefined;
                graceperiod = undefined;
                isanymlgmatch = 0;
                isanymlgmatch = game_utility_mp::isanymlgmatch();
                
                if ( isanymlgmatch )
                {
                    pointsneeded = superbundle.var_a79d3267e54b08ce;
                    usetime = superbundle.cwlusetime;
                    graceperiod = superbundle.cwlgraceperiod;
                }
                
                if ( !isdefined( pointsneeded ) )
                {
                    pointsneeded = superbundle.pointsneeded;
                }
                
                if ( !isdefined( usetime ) )
                {
                    usetime = superbundle.usetime;
                }
                
                if ( !isdefined( graceperiod ) )
                {
                    graceperiod = superbundle.graceperiod;
                }
                
                staticdata.pointsneeded = pointsneeded ?? 0;
                staticdata.usetime = usetime;
                staticdata.graceperiod = graceperiod;
                staticdata.refundondeath = superbundle.refundondeath;
                staticdata.useweapon = superbundle.useweapon;
                staticdata.weaponname = weaponname;
                staticdata.defaultslot = "super";
                
                if ( isdefined( staticdata.weaponname ) && staticdata.weaponname != "none" )
                {
                    staticdata.objweapon = weapon_utility::function_d2c8356dc369d9ce( staticdata.weaponname );
                }
                
                staticdata.useweaponclipammo = superbundle.useweaponclipammo ?? 0;
                staticdata.useweaponstockammo = superbundle.useweaponstockammo ?? 0;
                staticdata.useweapontrackstats = superbundle.var_977af528f4a39373 ?? 0;
                staticdata.movespeed = superbundle.movespeed;
                staticdata.isweapon = superbundle.isweapon;
                staticdata.canuseinlaststand = superbundle.canuseinlaststand;
                staticdata.persistondeath = superbundle.persistondeath;
                staticdata.var_44a1d1cf563489e4 = superbundle.var_44a1d1cf563489e4;
                staticdata.var_b04dc4f3e9e1f24c = superbundle.var_b04dc4f3e9e1f24c;
                staticdata.isinfinite = superbundle.isinfinite;
                staticdata.var_50daf13c043521b9 = superbundle.var_50daf13c043521b9;
                staticdata.var_2584b4581346d6d1 = superbundle.var_2584b4581346d6d1;
                staticdata.var_2c56f0068dd07712 = istrue( superbundle.var_8898d75e1941ef20 );
                staticdata.var_3aeac118e14d2377 = superbundle.var_416409658c43cb45;
                staticdata.weaponammo = superbundle.var_e2be0686d1eeb904;
                staticdata.var_c2fb965c9cd3dc5c = superbundle.var_c2fb965c9cd3dc5c;
                staticdata.var_161740a20792292 = superbundle.var_161740a20792292;
                staticdata.var_20ce3b96f3fc30d4 = superbundle.var_20ce3b96f3fc30d4;
                staticdata.var_602e39dd9e151671 = superbundle.var_602e39dd9e151671;
                staticdata.var_98922bd78bbe0a12 = superbundle.var_98922bd78bbe0a12;
                staticdata.var_baf4edb3e045bc5b = superbundle.var_baf4edb3e045bc5b;
                staticdata.var_3b02a37f9ab4242f = superbundle.var_3b02a37f9ab4242f;
                staticdata.var_68d8c680f1dea54f = superbundle.var_68d8c680f1dea54f;
                staticdata.var_b1c59c047766624b = superbundle.var_b1c59c047766624b;
                staticdata.var_9fdae8aefe811c2a = superbundle.var_9fdae8aefe811c2a;
                staticdata.var_99afe05c38b6392c = superbundle.var_99afe05c38b6392c;
                staticdata.skipfirstraise = superbundle.skipfirstraise;
                staticdata.useimmediate = superbundle.useimmediate;
                staticdata.var_dd8ff255774d56c7 = superbundle.var_dd8ff255774d56c7;
                staticdata.var_980cf09f642fcf52 = superbundle.var_980cf09f642fcf52;
                staticdata.var_380d432f91817bb2 = superbundle.var_380d432f91817bb2;
                staticdata.extraweapons = [];
                
                if ( isdefined( staticdata.useweapon ) && staticdata.useweapon != "" )
                {
                    if ( level.gametype == "dungeons" )
                    {
                        staticdata.useweapon = weapon::buildweapon( weapon::getweaponrootname( staticdata.useweapon ), undefined, "camo_none", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
                    }
                    else
                    {
                        staticdata.useweapon = weapon::buildweapon( staticdata.useweapon );
                    }
                }
                
                level.superglobals.supersbyid[ i ] = superref;
                level.superglobals.var_da0d0ae8681f98ba[ superref ] = i;
                
                if ( !isdefined( staticdata.objweapon ) )
                {
                    assertmsg( "<dev string:x6dc>" + superref + "<dev string:x70e>" );
                    level.superglobals.staticsuperdata[ superref ] = undefined;
                }
                else
                {
                    offhandweapon = superbundle.offhandweapon ?? staticdata.objweapon.basenamehash;
                    level.superglobals.supersbyoffhand[ offhandweapon ] = staticdata;
                }
                
                if ( !isdefined( staticdata.pointsneeded ) )
                {
                    assertmsg( "<dev string:x710>" + superref + "<dev string:x70e>" );
                    level.superglobals.staticsuperdata[ superref ] = undefined;
                }
                
                if ( isdefined( staticdata.maxactivations ) )
                {
                    if ( staticdata.maxactivations > 0 )
                    {
                        staticdata.activatepenalty = 1 / staticdata.maxactivations;
                    }
                    else
                    {
                        staticdata.activatepenalty = 1;
                    }
                }
                
                if ( isdefined( staticdata.maxactivationsalt ) )
                {
                    if ( staticdata.maxactivationsalt > 0 )
                    {
                        staticdata.activatepenaltyalt = 1 / staticdata.maxactivationsalt;
                    }
                }
                
                if ( isweapon( staticdata.useweapon ) )
                {
                    assert( isdefined( staticdata.useweaponclipammo ), "<dev string:x749>" + superref + "<dev string:x75e>" );
                    assert( isdefined( staticdata.useweaponstockammo ), "<dev string:x749>" + superref + "<dev string:x799>" );
                    assert( isdefined( staticdata.useweapontrackstats ), "<dev string:x749>" + superref + "<dev string:x7d5>" );
                    level.superglobals.superweapons[ staticdata.useweapon.basenamehash ] = staticdata;
                }
                
                if ( isdefined( staticdata.graceperiod ) )
                {
                    staticdata.graceperiod *= 1000;
                }
                else
                {
                    staticdata.graceperiod = 0;
                }
                
                initializesuper( staticdata.var_efcbef98efb5e5d );
            }
        }
    }
    
    /#
        if ( level.var_ac98e7cc4b10cb11 )
        {
            function_879b5573ac8bdeed();
        }
    #/
}

/#

    // Namespace supers_mp
    // Params 0
    // Checksum 0xfdae983c, Offset: 0xfaac
    // Size: 0x22a, Type: dev
    function function_879b5573ac8bdeed()
    {
        devgui::function_9082edeb5db93280( "<dev string:x812>" );
        
        foreach ( super, entry in level.superglobals.staticsuperdata )
        {
            if ( !entry.weaponname || entry.weaponname == "<dev string:x83e>" || entry.weaponname == "<dev string:x843>" )
            {
                continue;
            }
            else if ( entry.weapontype == "<dev string:x84e>" && entry.useweapon )
            {
                weapon = entry.useweapon;
            }
            else
            {
                weapon = entry.weaponname;
            }
            
            attachments = function_2e5ecdd8ac47f308( weapon, "<dev string:x85b>" );
            
            if ( isarray( attachments ) )
            {
                foreach ( attachment in attachments )
                {
                    var_89dda19d4cb51236 = super;
                    
                    if ( issubstr( super, "<dev string:x863>" ) )
                    {
                        var_89dda19d4cb51236 = getsubstr( super, 6 );
                    }
                    
                    attachmentdisplayname = attachment;
                    
                    if ( issubstr( attachment, "<dev string:x86a>" ) )
                    {
                        attachmentdisplayname = "<dev string:x86a>";
                    }
                    else if ( issubstr( attachment, "<dev string:x870>" ) )
                    {
                        attachmentdisplayname = "<dev string:x870>";
                    }
                    
                    devgui::add_devgui_command( "<dev string:x2ce>" + var_89dda19d4cb51236 + "<dev string:x874>" + attachmentdisplayname + "<dev string:x877>", "<dev string:x879>" + attachment + "<dev string:x89c>" + super );
                }
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace supers_mp
// Params 1
// Checksum 0xc3422fe3, Offset: 0xfcde
// Size: 0x23, Type: bool
function issuper( superref )
{
    return isdefined( level.superglobals.staticsuperdata[ superref ] );
}

// Namespace supers_mp
// Params 1
// Checksum 0x99c08aa2, Offset: 0xfd0a
// Size: 0x2c, Type: bool
function function_12ae76428d4cf386( ent )
{
    return issuper( ent.superref ) && ent.var_54ae3a087350bf6f;
}

// Namespace supers_mp
// Params 3, eflags: 0x4
// Checksum 0xf9d1504b, Offset: 0xfd3f
// Size: 0x17a
function private buildsuper( weaponname, blueprintindex, attachments )
{
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    if ( !isdefined( attachments ) )
    {
        attachments = [];
    }
    
    if ( blueprintindex > 0 )
    {
        var_5b5a4f8ed605f4d6 = weaponname + "|" + string( blueprintindex );
        attachmentblueprints = level.superblueprints[ var_5b5a4f8ed605f4d6 ];
        
        if ( !isdefined( attachmentblueprints ) )
        {
            /#
                errormessage = "<dev string:x8ba>" + weaponname + "<dev string:x8f7>" + blueprintindex + "<dev string:x913>";
                println( errormessage );
                iprintlnbold( errormessage );
            #/
            
            return makeweapon( weaponname );
        }
        
        blueprintattachments = [];
        var_b92e7b59e45233fe = [];
        arrayindex = 0;
        
        foreach ( attachment, blueprintindex in attachmentblueprints )
        {
            blueprintattachments[ arrayindex ] = attachment;
            var_b92e7b59e45233fe[ arrayindex ] = blueprintindex;
            arrayindex++;
        }
        
        weapon = makeweapon( weaponname, blueprintattachments, undefined, undefined, blueprintindex, var_b92e7b59e45233fe );
        
        /#
            if ( isbrgamemode() )
            {
                assertmsg( "<dev string:x935>" );
            }
        #/
    }
    else
    {
        weapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
    }
    
    weapon = weapon withattachments( attachments );
    return weapon;
}

// Namespace supers_mp
// Params 1
// Checksum 0xd5d768a6, Offset: 0xfec2
// Size: 0x2c
function function_5ffd3dfa9cc1e8de( superref )
{
    return level.superglobals.staticsuperdata[ superref ].bundle;
}

// Namespace supers_mp
// Params 1
// Checksum 0x1d52dba2, Offset: 0xfef7
// Size: 0x2a
function function_4b7b32d1d5b0c427( ref )
{
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    return level.superglobals.staticsuperdata[ ref ];
}

// Namespace supers_mp
// Params 0
// Checksum 0x9b1c7a34, Offset: 0xff2a
// Size: 0xca
function function_326afcb6cbf66a93()
{
    superinfo = getcurrentsuper( undefined );
    var_407b5771b45f4b0a = function_6c912116c8af1159( superinfo );
    var_82228a71c67e676f = function_11fddb38e7512160( var_407b5771b45f4b0a );
    
    if ( var_82228a71c67e676f && superinfo.staticdata.var_b04dc4f3e9e1f24c )
    {
        clipammo = function_9927ca332693e216( superinfo );
        stockammo = function_6b9d4ebfab10a956( superinfo );
        var_fe59cbc2df7a6d07 = function_c0901f58a21692ee( superinfo, var_407b5771b45f4b0a );
        
        if ( !issameweapon( var_407b5771b45f4b0a, var_fe59cbc2df7a6d07, 1 ) )
        {
            var_82228a71c67e676f = trygiveuseweapon( var_fe59cbc2df7a6d07, clipammo, stockammo, 1, superinfo.staticdata.useimmediate, 1, undefined );
            inventory_utility::_takeweapon( var_407b5771b45f4b0a );
        }
    }
}

