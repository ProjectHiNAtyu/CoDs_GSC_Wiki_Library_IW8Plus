// scripts\mp\common\perks\perk_tps_damage_radar.gsc  (hash_5996808bbf788b1f.gscc) (size: 1922 Bytes / 0x782 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15e66f07 (367423239)
// size ...... 1922 (0x782)
// includes .. 3   (offset: 0x70a)
// strings ... 3   (offset: 0x722)
// dev strs .. 0   (offset: 0x782)
// exports ... 9   (offset: 0x3f6)
// cseg ...... 0xb3 + 0x343 (0x3f6)
// imports ... 15  (offset: 0x55e)
// animtree1 . 0   (offset: 0x782)
// animtree2 . 0   (offset: 0x782)
#using script_326e44f18084416a;
#using scripts\common\callbacks;
#using scripts\mp\common\utility\points;

#namespace perk_tps_damage_radar;

// Namespace perk_tps_damage_radar
// Params 0, eflags: 0x5
// Checksum 0xeae2eb6, Offset: 0xd1
// Size: 0x2e
function private autoexec main()
{
    level callback::add( #"register_perk", &function_8dea510ea7246159 );
    level callback::add( #"register_perk", &function_1e82f6e6b1878986 );
}

// Namespace perk_tps_damage_radar
// Params 1
// Checksum 0x949ddc43, Offset: 0x107
// Size: 0x104
function function_8dea510ea7246159( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_damage_radar" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_damage_radar" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_damage_radar", &function_cf316c2d135e9ee6, &function_ff9d3dea5862a055, [ "specialty_damage_radar" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_damage_radar" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_damage_radar" ] = "specialty_tps_buff_damage_radar";
        }
    }
    
    if ( perkbundle.var_140291717160affc )
    {
        level.var_140291717160affc = perkbundle.var_140291717160affc * perkbundle.var_140291717160affc;
    }
    else
    {
        level.var_140291717160affc = 640000;
    }
    
    level.var_c267f3cfc720a3be[ "specialty_tps_damage_radar" ] = &"hash_3f612526caa700f9";
}

// Namespace perk_tps_damage_radar
// Params 0
// Checksum 0x91d44de1, Offset: 0x213
// Size: 0xe
function function_cf316c2d135e9ee6()
{
    namespace_6db61cded148a258::set_team_perk( "specialty_tps_damage_radar" );
}

// Namespace perk_tps_damage_radar
// Params 0
// Checksum 0x4899e547, Offset: 0x229
// Size: 0xe
function function_ff9d3dea5862a055()
{
    namespace_6db61cded148a258::unset_team_perk( "specialty_tps_damage_radar" );
}

// Namespace perk_tps_damage_radar
// Params 0
// Checksum 0x920454d2, Offset: 0x23f
// Size: 0x17
function function_fd875cc00e1579f3()
{
    callback::add( #"hash_bdda5c524eb0eb00", &function_20ef42964ba8bc11 );
}

// Namespace perk_tps_damage_radar
// Params 0
// Checksum 0xa968e5bb, Offset: 0x25e
// Size: 0x17
function function_bb9c91cc08bbefdc()
{
    callback::remove( #"hash_bdda5c524eb0eb00", &function_20ef42964ba8bc11 );
}

// Namespace perk_tps_damage_radar
// Params 1
// Checksum 0x1ecc28a2, Offset: 0x27d
// Size: 0xac
function function_1e82f6e6b1878986( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_damage_radar" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_damage_radar" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_buff_damage_radar", &function_fd875cc00e1579f3, &function_bb9c91cc08bbefdc, [ "specialty_damage_radar" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_damage_radar" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_damage_radar" ] = "specialty_tps_buff_damage_radar";
        }
    }
}

// Namespace perk_tps_damage_radar
// Params 1
// Checksum 0x6a052f24, Offset: 0x331
// Size: 0xc5
function function_20ef42964ba8bc11( params )
{
    var_9aea4c13eca1ef55 = self.var_c4b4f21cb358d87c[ "specialty_tps_buff_damage_radar" ];
    
    foreach ( playersource in var_9aea4c13eca1ef55 )
    {
        if ( distancesquared( self.origin, playersource.origin ) <= level.var_ef60871979b5dce1 )
        {
            playersource points::doscoreevent( #"hash_d2f3704db358507c" );
        }
    }
}

