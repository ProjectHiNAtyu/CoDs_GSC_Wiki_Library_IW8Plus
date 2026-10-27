// scripts\mp\common\perks\perk_tps_overclock.gsc  (hash_396f791d627c57d9.gscc) (size: 2421 Bytes / 0x975 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe27197ad (3799095213)
// size ...... 2421 (0x975)
// includes .. 4   (offset: 0x8ad)
// strings ... 6   (offset: 0x8cd)
// dev strs .. 0   (offset: 0x975)
// exports ... 9   (offset: 0x53d)
// cseg ...... 0x100 + 0x43d (0x53d)
// imports ... 18  (offset: 0x6a5)
// animtree1 . 0   (offset: 0x975)
// animtree2 . 0   (offset: 0x975)
#using script_326e44f18084416a;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\mp\common\utility\points;

#namespace perk_tps_overclock;

// Namespace perk_tps_overclock
// Params 0, eflags: 0x5
// Checksum 0xba043d15, Offset: 0x11e
// Size: 0x2e
function private autoexec main()
{
    level callback::add( #"register_perk", &function_f55cd1da8fed735e );
    level callback::add( #"register_perk", &function_b0398411a1676bdd );
}

// Namespace perk_tps_overclock
// Params 1
// Checksum 0xda545a84, Offset: 0x154
// Size: 0x123
function function_f55cd1da8fed735e( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_overclock" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_overclock" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_overclock", &setteamoverclock, &function_fa4e1e644e1dc7fa, [ "specialty_faster_field_upgrade" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_overclock" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_overclock" ] = "specialty_tps_buff_overclock";
        }
    }
    
    if ( !isdefined( var_c08e832913e1c60f.var_fd9b39439920c808 ) )
    {
        var_c08e832913e1c60f.var_fd9b39439920c808 = "uin_friend_request_alert";
    }
    
    if ( perkbundle.var_2d567850979cfd1d )
    {
        level.var_ef60871979b5dce1 = perkbundle.var_2d567850979cfd1d * perkbundle.var_2d567850979cfd1d;
    }
    else
    {
        level.var_ef60871979b5dce1 = 640000;
    }
    
    level.var_c267f3cfc720a3be[ "specialty_tps_overclock" ] = &"hash_2626bd20008aa101";
}

// Namespace perk_tps_overclock
// Params 0
// Checksum 0x9cc4d273, Offset: 0x27f
// Size: 0x4d
function setteamoverclock()
{
    perkbundle = level.perkbundles[ "specialty_tps_overclock" ];
    val::set( "specialty_tps_overclock", "field_upgrade_recharge_mult", perkbundle.var_36874ca2672346b ?? 1.4 );
    namespace_6db61cded148a258::set_team_perk( "specialty_tps_overclock" );
}

// Namespace perk_tps_overclock
// Params 0
// Checksum 0x85eb46d8, Offset: 0x2d4
// Size: 0x1f
function function_fa4e1e644e1dc7fa()
{
    val::reset( "specialty_tps_overclock", "field_upgrade_recharge_mult" );
    namespace_6db61cded148a258::unset_team_perk( "specialty_tps_overclock" );
}

// Namespace perk_tps_overclock
// Params 0
// Checksum 0xf747ed44, Offset: 0x2fb
// Size: 0x56
function function_d8be14e83c4df924()
{
    perkbundle = level.perkbundles[ "specialty_tps_overclock" ];
    val::set( "specialty_tps_overclock", "field_upgrade_recharge_mult", perkbundle.var_36874ca2672346b ?? 1.4 );
    callback::add( #"on_used_super", &function_9e4e05d4a0277348 );
}

// Namespace perk_tps_overclock
// Params 0
// Checksum 0xf28e708d, Offset: 0x359
// Size: 0x28
function function_dc17fe0378aed8af()
{
    val::reset( "specialty_tps_overclock", "field_upgrade_recharge_mult" );
    callback::remove( #"on_used_super", &function_9e4e05d4a0277348 );
}

// Namespace perk_tps_overclock
// Params 1
// Checksum 0x404b6686, Offset: 0x389
// Size: 0xac
function function_b0398411a1676bdd( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_overclock" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_overclock" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_buff_overclock", &function_d8be14e83c4df924, &function_dc17fe0378aed8af, [ "specialty_faster_field_upgrade" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_overclock" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_overclock" ] = "specialty_tps_buff_overclock";
        }
    }
}

// Namespace perk_tps_overclock
// Params 1
// Checksum 0xcf477aca, Offset: 0x43d
// Size: 0x100
function function_9e4e05d4a0277348( params )
{
    var_9aea4c13eca1ef55 = self.var_c4b4f21cb358d87c[ "specialty_tps_buff_overclock" ];
    
    if ( params.superinfo.staticdata.ref == "super_select" )
    {
        return;
    }
    
    if ( getdvarint( @"hash_2fbba320fe582661", 0 ) )
    {
        return;
    }
    
    foreach ( playersource in var_9aea4c13eca1ef55 )
    {
        if ( distancesquared( self.origin, playersource.origin ) <= level.var_ef60871979b5dce1 )
        {
            playersource points::doscoreevent( #"hash_9af51e22b4237a27" );
        }
    }
}

