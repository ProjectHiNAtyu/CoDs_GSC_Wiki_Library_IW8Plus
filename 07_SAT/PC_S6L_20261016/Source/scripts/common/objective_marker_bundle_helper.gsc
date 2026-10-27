// scripts\common\objective_marker_bundle_helper.gsc  (hash_18dfb2efa90825ca.gscc) (size: 1134 Bytes / 0x46e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe587ae11 (3850874385)
// size ...... 1134 (0x46e)
// includes .. 1   (offset: 0x3ee)
// strings ... 10  (offset: 0x3f6)
// dev strs .. 0   (offset: 0x46e)
// exports ... 5   (offset: 0x27e)
// cseg ...... 0xdd + 0x1a1 (0x27e)
// imports ... 6   (offset: 0x346)
// animtree1 . 0   (offset: 0x46e)
// animtree2 . 0   (offset: 0x46e)
#using scripts\common\utility;

#namespace objective_marker_bundle_helper;

// Namespace objective_marker_bundle_helper
// Params 0
// Checksum 0xe6e23088, Offset: 0xfb
// Size: 0x1b
function function_aded78d14325f551()
{
    if ( function_276df282305685bb() )
    {
        return;
    }
    
    level.var_fdb512e0da2d2fc7 = function_9cb17c0e99d13db8();
}

// Namespace objective_marker_bundle_helper
// Params 2
// Checksum 0x30a0b9f, Offset: 0x11e
// Size: 0x59
function function_d98e9d627f2d8c28( bundlename, cache )
{
    bundlexhash = bundlename;
    
    if ( !isxhashasset( bundlename ) )
    {
        bundlexhash = hashcat( %"hash_334a4b8da1c7fd3f", bundlename );
    }
    
    return utility::callsharedfunc( #"objective_marker_bundle_helper", #"createobjectivemarkerfrombundlexhash", bundlexhash, cache );
}

// Namespace objective_marker_bundle_helper
// Params 0
// Checksum 0x5765b752, Offset: 0x180
// Size: 0xc, Type: bool
function function_276df282305685bb()
{
    return isdefined( level.var_fdb512e0da2d2fc7 );
}

// Namespace objective_marker_bundle_helper
// Params 0, eflags: 0x4
// Checksum 0x285acb2d, Offset: 0x195
// Size: 0xe8
function private function_9cb17c0e99d13db8()
{
    var_fdb512e0da2d2fc7 = spawnstruct();
    var_fdb512e0da2d2fc7.backgroundoptions = [];
    var_fdb512e0da2d2fc7.backgroundoptions[ "default" ] = 0;
    var_fdb512e0da2d2fc7.backgroundoptions[ "no_background" ] = 1;
    var_fdb512e0da2d2fc7.backgroundoptions[ "carry_object" ] = 2;
    var_fdb512e0da2d2fc7.backgroundoptions[ "mission" ] = 3;
    var_fdb512e0da2d2fc7.backgroundoptions[ "mission_tracked" ] = 4;
    var_fdb512e0da2d2fc7.backgroundoptions[ "poi" ] = 5;
    var_fdb512e0da2d2fc7.backgroundoptions[ "circle" ] = 6;
    var_fdb512e0da2d2fc7.backgroundoptions[ "diamond" ] = 7;
    var_fdb512e0da2d2fc7.backgroundoptions[ "stronghold" ] = 8;
    var_fdb512e0da2d2fc7.backgroundoptions[ "side_relative" ] = 9;
    return var_fdb512e0da2d2fc7;
}

