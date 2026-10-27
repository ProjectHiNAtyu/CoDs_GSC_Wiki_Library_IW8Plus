// scripts\mp\br\gametypes\br_staged_items.gsc  (hash_4e799892aa6878b1.gscc) (size: 4719 Bytes / 0x126f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x370cda84 (923589252)
// size ...... 4719 (0x126f)
// includes .. 7   (offset: 0x116b)
// strings ... 8   (offset: 0x11a3)
// dev strs .. 9   (offset: 0x1203)
// exports ... 11  (offset: 0xad7)
// cseg ...... 0xdf + 0x9f8 (0xad7)
// imports ... 42  (offset: 0xc8f)
// animtree1 . 0   (offset: 0x126f)
// animtree2 . 0   (offset: 0x126f)
#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\structspawnconfig;

#namespace br_staged_items;

// Namespace br_staged_items
// Params 0
// Checksum 0x43910a00, Offset: 0xfd
// Size: 0x66
function init()
{
    if ( !getdvarint( @"hash_2bd08bfff808053a", 1 ) || !getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        return;
    }
    
    function_44e3ccf970763fcd();
    
    /#
        utility::callsharedfunc( #"staged_items_debug", #"init_debug" );
        utility::callsharedfunc( #"staged_items_debug", #"hash_3cb77d76691c1485" );
    #/
}

// Namespace br_staged_items
// Params 0, eflags: 0x4
// Checksum 0x1e83a9cb, Offset: 0x16b
// Size: 0x173, Type: bool
function private function_44e3ccf970763fcd()
{
    var_5b2cf4681042f093 = utility::getstructarray( "staged_item", "script_noteworthy" );
    var_d37fed4a867de20 = [];
    
    foreach ( stageditem in var_5b2cf4681042f093 )
    {
        stageditemtype = stageditem.targetname;
        
        if ( isdefined( stageditemtype ) )
        {
            var_d37fed4a867de20 = arraycombineunique( var_d37fed4a867de20, [ stageditemtype ] );
        }
    }
    
    if ( var_d37fed4a867de20.size == 0 )
    {
        return false;
    }
    
    utility::flag_wait( "ssc_initialized" );
    
    foreach ( stageditemtype in var_d37fed4a867de20 )
    {
        if ( getdvarint( hashcat( @"hash_ea224dc24c0b7e07", stageditemtype ), 1 ) )
        {
            structspawnconfig::function_7418a260adaec05( stageditemtype, &function_25cd16d3f9a7e32 );
            structspawnconfig::function_8c0a09968efe9138( stageditemtype, &function_4d95582da43898b3 );
            structspawnconfig::function_36050499b5f48983( stageditemtype, &function_22c3b0628511d82b );
        }
    }
    
    return true;
}

// Namespace br_staged_items
// Params 2, eflags: 0x4
// Checksum 0x4c693180, Offset: 0x2e7
// Size: 0x66
function private function_4d95582da43898b3( structname, var_ed3e809a549ab852 )
{
    if ( !isdefined( level.var_53ca2e0467fd5ffc ) )
    {
        level.var_53ca2e0467fd5ffc = [];
    }
    
    if ( !isdefined( level.var_53ca2e0467fd5ffc[ structname ] ) )
    {
        level.var_53ca2e0467fd5ffc[ structname ] = [];
    }
    
    level.var_53ca2e0467fd5ffc[ structname ][ level.var_53ca2e0467fd5ffc[ structname ].size ] = var_ed3e809a549ab852;
    return var_ed3e809a549ab852;
}

// Namespace br_staged_items
// Params 0, eflags: 0x4
// Checksum 0xe1e30cb6, Offset: 0x356
// Size: 0x150
function private function_26061270b210b88b()
{
    level.stagedweapons = [];
    assert( isdefined( level.commonitem.var_f4a0cd0e44af4832 ) );
    var_16d763e03ef0bbc = getscriptbundlefieldvalues( "itemspawnzonedef:" + level.commonitem.var_f4a0cd0e44af4832, [ #"hash_ca6f316d7a8beef" ] );
    
    if ( !isdefined( var_16d763e03ef0bbc.var_88632f10666b4174 ) )
    {
        return;
    }
    
    var_5dc5600e6b578149 = getscriptbundlefieldvalues( hashcat( %"itemspawnlist:", var_16d763e03ef0bbc.var_88632f10666b4174 ), [ #"hash_634158c584fe2866" ] );
    
    if ( !isdefined( var_5dc5600e6b578149.itementries ) )
    {
        return;
    }
    
    foreach ( item in var_5dc5600e6b578149.itementries )
    {
        if ( !isdefined( item.itemspawnentry ) )
        {
            continue;
        }
        
        level.stagedweapons[ item.itemspawnentry ] = 1;
    }
}

// Namespace br_staged_items
// Params 2, eflags: 0x4
// Checksum 0x9fa88667, Offset: 0x4ae
// Size: 0x3b, Type: bool
function private function_38e12bb816cd39a4( itembundle, itembundlename )
{
    if ( !itembundle.baseweapon )
    {
        return true;
    }
    
    if ( !level.stagedweapons[ itembundlename ] )
    {
        return false;
    }
    
    return true;
}

// Namespace br_staged_items
// Params 1, eflags: 0x4
// Checksum 0x55491845, Offset: 0x4f2
// Size: 0x230
function private function_83011eb4b8fb6343( var_ed3e809a549ab852 )
{
    if ( !isdefined( var_ed3e809a549ab852.script_parameters ) )
    {
        return;
    }
    
    scriptable = undefined;
    spawnlist = function_41bec0232e24ee41( var_ed3e809a549ab852.script_parameters, "itemspawnlist:" );
    
    if ( spawnlist != var_ed3e809a549ab852.script_parameters )
    {
        itemname = common_item::items_selectfromlist( spawnlist, 1 )[ 0 ];
        scriptable = getscriptbundlefieldvalue( itemname, #"scriptable" );
    }
    else
    {
        scriptables = strtok( var_ed3e809a549ab852.script_parameters, " " );
        scriptable = utility::array_random( scriptables );
    }
    
    if ( !isdefined( scriptable ) )
    {
        return;
    }
    
    if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( scriptable ) )
    {
        return;
    }
    
    itembundlename = common_item_database::function_ca9ca606e66b5911( scriptable );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x24>" + scriptable + "<dev string:x45>" );
        return;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x66>" + scriptable );
        return;
    }
    
    if ( !function_38e12bb816cd39a4( itembundle, itembundlename ) )
    {
        assertmsg( "<dev string:xa1>" + scriptable + "<dev string:xc2>" + level.commonitem.var_f4a0cd0e44af4832 + "<dev string:x106>" );
        return;
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( var_ed3e809a549ab852.origin, var_ed3e809a549ab852.angles );
    spawnoptions.critical = 1;
    spawnoptions.staged = 1;
    scriptable = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    
    if ( scriptable )
    {
        visiblestate = utility::callsharedfunc( #"staged_items", #"hash_11115aeb1542dcb9" ) ?? #"visible_staged_weapon";
        
        if ( visiblestate && scriptable getscriptableparthasstate( scriptable.type, visiblestate ) )
        {
            scriptable setscriptablepartstate( scriptable.type, visiblestate );
        }
        
        /#
            if ( level.var_478e2a05269c0d46 )
            {
                scriptable.var_35de80c7b58c9a95 = 1;
            }
        #/
    }
    
    return var_ed3e809a549ab852;
}

// Namespace br_staged_items
// Params 1, eflags: 0x4
// Checksum 0xc975829d, Offset: 0x72b
// Size: 0x213
function private function_22c3b0628511d82b( structname )
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    waitframe();
    
    if ( !isdefined( level.var_53ca2e0467fd5ffc[ structname ] ) || level.var_53ca2e0467fd5ffc[ structname ].size == 0 )
    {
        return;
    }
    
    function_26061270b210b88b();
    
    /#
        uniquedebugcolor = ( 0, randomfloat( 1 ), randomfloat( 1 ) );
    #/
    
    foreach ( loc in level.var_53ca2e0467fd5ffc[ structname ] )
    {
        var_7e7ecf6d2277e522 = isdefined( loc.areaswap_name ) && isdefined( loc.areaswap_state );
        
        if ( var_7e7ecf6d2277e522 && !hasareaswap( loc.areaswap_name ) )
        {
            assertmsg( "<dev string:x12f>" + loc.script_parameters + "<dev string:x13c>" + loc.areaswap_name + "<dev string:x15b>" );
            continue;
        }
        
        if ( var_7e7ecf6d2277e522 )
        {
            statename = getareaswapstate( loc.areaswap_name );
            var_7e7ecf6d2277e522 = statename != getxhash( loc.areaswap_state );
        }
        
        if ( var_7e7ecf6d2277e522 )
        {
            function_5899b267b318c34e( loc, getxhash( loc.areaswap_name ), getxhash( loc.areaswap_state ) );
        }
        else
        {
            function_83011eb4b8fb6343( loc );
        }
        
        /#
            if ( getdvarint( @"hash_61b94d31059f975", 0 ) )
            {
                thread debug::drawsphere( loc.origin, 128, 10000, uniquedebugcolor );
            }
        #/
    }
    
    if ( isdefined( level.var_b611ad42e8b7548a ) )
    {
        level thread function_8afdea0800fd8dba();
    }
    
    level.var_53ca2e0467fd5ffc[ structname ] = undefined;
    level.stagedweapons = undefined;
}

// Namespace br_staged_items
// Params 3, eflags: 0x4
// Checksum 0xbf29cebd, Offset: 0x946
// Size: 0x92
function private function_5899b267b318c34e( loc, areaswap_name, areaswap_state )
{
    if ( !isdefined( level.var_b611ad42e8b7548a ) )
    {
        level.var_b611ad42e8b7548a = [];
    }
    
    if ( !isdefined( level.var_b611ad42e8b7548a[ areaswap_name ] ) )
    {
        level.var_b611ad42e8b7548a[ areaswap_name ] = [];
    }
    
    if ( !isdefined( level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ] ) )
    {
        level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ] = [];
    }
    
    level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ][ level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ].size ] = loc;
}

// Namespace br_staged_items
// Params 0, eflags: 0x4
// Checksum 0xf84cd4b, Offset: 0x9e0
// Size: 0xd5
function private function_8afdea0800fd8dba()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"areaswap_changed", areaswap_name, areaswap_state );
        
        if ( isdefined( level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ] ) )
        {
            foreach ( loc in level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ] )
            {
                function_83011eb4b8fb6343( loc );
            }
            
            level.var_b611ad42e8b7548a[ areaswap_name ][ areaswap_state ] = undefined;
        }
    }
}

// Namespace br_staged_items
// Params 1, eflags: 0x4
// Checksum 0x95958b92, Offset: 0xabd
// Size: 0x19
function private function_25cd16d3f9a7e32( structname )
{
    return utility::getstructarray( structname, "targetname" );
}

