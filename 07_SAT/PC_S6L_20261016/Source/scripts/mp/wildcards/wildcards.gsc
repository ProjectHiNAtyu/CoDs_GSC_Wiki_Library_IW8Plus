// scripts\mp\wildcards\wildcards.gsc  (hash_0cf30fc15dfaf9bb.gscc) (size: 2365 Bytes / 0x93d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7c83b06 (3888659206)
// size ...... 2365 (0x93d)
// includes .. 3   (offset: 0x889)
// strings ... 12  (offset: 0x8a1)
// dev strs .. 1   (offset: 0x931)
// exports ... 7   (offset: 0x5dd)
// cseg ...... 0x18d + 0x450 (0x5dd)
// imports ... 13  (offset: 0x6f5)
// animtree1 . 0   (offset: 0x93d)
// animtree2 . 0   (offset: 0x93d)
#using scripts\common\callbacks;
#using scripts\mp\challenges;
#using scripts\mp\common\perks\perks;

#namespace wildcards;

// Namespace wildcards
// Params 0, eflags: 0x1
// Checksum 0x97b09af0, Offset: 0x1ab
// Size: 0x1f
function autoexec preinit()
{
    function_c9e23ef0cfb78673();
    level callback::add( #"register_perk", &registerwildcards );
}

// Namespace wildcards
// Params 1
// Checksum 0x72d9d367, Offset: 0x1d2
// Size: 0xcc
function registerwildcards( params )
{
    if ( !isdefined( level.wildcardbundles ) )
    {
        return;
    }
    
    perks::registerscriptperk( "wildcard_danger_close", undefined, undefined, [ "specialty_extra_deadly" ] );
    perks::registerscriptperk( "wildcard_tactical_expert", undefined, undefined, [ "specialty_extraoffhandammo" ] );
    perks::registerscriptperk( "wildcard_overkill", undefined, undefined, undefined );
    perks::registerscriptperk( "wildcard_gunfighter", undefined, undefined, undefined );
    perks::registerscriptperk( "wildcard_field_captain", undefined, undefined, undefined );
    perks::registerscriptperk( "wildcard_perk_greed", undefined, undefined, undefined );
    perks::registerscriptperk( "wildcard_equipment_expert", undefined, undefined, [ "specialty_bandolier" ] );
    perks::registerscriptperk( "wildcard_master_tactician", undefined, undefined, [ "specialty_battle_ready" ] );
    callback::add( #"hash_f873effec093bd7d", &function_72068572f6a5f816 );
}

// Namespace wildcards
// Params 0
// Checksum 0xbc6af12e, Offset: 0x2a6
// Size: 0x164
function function_c9e23ef0cfb78673()
{
    str_list = level.gamemodebundle.wildcard_list;
    
    if ( !isdefined( str_list ) )
    {
        return;
    }
    
    if ( !isdefined( level.wildcardbundles ) )
    {
        level.wildcardbundles = [];
    }
    
    var_364b566f13cd8b14 = getscriptbundle( str_list );
    assert( isdefined( var_364b566f13cd8b14 ), "<dev string:x24>" );
    assert( isdefined( var_364b566f13cd8b14.wildcard_list ) );
    
    if ( !isdefined( var_364b566f13cd8b14.wildcard_list ) )
    {
        return;
    }
    
    foreach ( wildcardlistentry in var_364b566f13cd8b14.wildcard_list )
    {
        if ( !isdefined( wildcardlistentry ) )
        {
            continue;
        }
        
        wildcardref = wildcardlistentry.ref;
        
        if ( !isdefined( wildcardref ) )
        {
            continue;
        }
        
        wildcardbundlename = wildcardlistentry.bundle;
        
        if ( !isdefined( wildcardbundlename ) )
        {
            continue;
        }
        
        bundle = getscriptbundle( wildcardbundlename );
        
        if ( !isdefined( bundle ) )
        {
            continue;
        }
        
        level.wildcardbundles[ wildcardref ] = bundle;
    }
}

// Namespace wildcards
// Params 1
// Checksum 0xe6a9af05, Offset: 0x412
// Size: 0x22
function function_64efa89a8031a2a5( wildcardref )
{
    return level.wildcardbundles[ wildcardref ].var_a362c1b75ace930f;
}

// Namespace wildcards
// Params 1
// Checksum 0x5c004a6c, Offset: 0x43d
// Size: 0x22
function function_56215609cd11b947( wildcardref )
{
    return level.wildcardbundles[ wildcardref ].var_a5109ca42cf62f91;
}

// Namespace wildcards
// Params 1
// Checksum 0x7b8ad83, Offset: 0x468
// Size: 0x175
function function_72068572f6a5f816( params )
{
    var_78b8e4a13e63bc01 = params.var_78b8e4a13e63bc01;
    var_86c674a64c35ed94 = params.var_86c674a64c35ed94;
    var_b1c3134299e971f7 = [];
    
    foreach ( perk in var_78b8e4a13e63bc01 )
    {
        wildcardbit = function_64efa89a8031a2a5( perk );
        wildcardbitfield = function_56215609cd11b947( perk );
        
        if ( isdefined( wildcardbit ) && isdefined( wildcardbitfield ) )
        {
            switch ( wildcardbitfield )
            {
                case 1:
                    var_86c674a64c35ed94.var_ec7be02dd7cc6d7d = challenges::function_a23641f33e985edb( var_86c674a64c35ed94.var_ec7be02dd7cc6d7d, wildcardbit );
                    break;
                case 2:
                    var_86c674a64c35ed94.var_7111292ef37e4f97 = challenges::function_a23641f33e985edb( var_86c674a64c35ed94.var_7111292ef37e4f97, wildcardbit );
                    break;
                default:
                    break;
            }
            
            continue;
        }
        
        var_b1c3134299e971f7[ var_b1c3134299e971f7.size ] = perk;
    }
    
    params.var_78b8e4a13e63bc01 = var_b1c3134299e971f7;
    params.var_86c674a64c35ed94 = var_86c674a64c35ed94;
}

