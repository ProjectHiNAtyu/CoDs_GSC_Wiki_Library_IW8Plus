// scripts\mp\common\perks\perk_tps_high_gain_antenna.gsc  (hash_3bc7efeaf9f6a50f.gscc) (size: 1308 Bytes / 0x51c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa492aa67 (2761075303)
// size ...... 1308 (0x51c)
// includes .. 2   (offset: 0x4a4)
// strings ... 4   (offset: 0x4b4)
// dev strs .. 0   (offset: 0x51c)
// exports ... 6   (offset: 0x2ec)
// cseg ...... 0xdc + 0x210 (0x2ec)
// imports ... 7   (offset: 0x3dc)
// animtree1 . 0   (offset: 0x51c)
// animtree2 . 0   (offset: 0x51c)
#using script_326e44f18084416a;
#using scripts\common\callbacks;

#namespace perk_tps_high_gain_antenna;

// Namespace perk_tps_high_gain_antenna
// Params 0, eflags: 0x5
// Checksum 0x67645430, Offset: 0xfa
// Size: 0x2e
function private autoexec main()
{
    level callback::add( #"register_perk", &function_7cce4f5207876740 );
    level callback::add( #"register_perk", &function_794513c08263d74f );
}

// Namespace perk_tps_high_gain_antenna
// Params 1
// Checksum 0x2927e2a3, Offset: 0x130
// Size: 0xe4
function function_7cce4f5207876740( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_high_gain_antenna" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_high_gain_antenna" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_high_gain_antenna", &function_58993cfa9d59afaf, &function_5ae63dffa4806f84, [ "specialty_tps_buff_high_gain_antenna" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_high_gain_antenna" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_high_gain_antenna" ] = "specialty_tps_buff_high_gain_antenna";
        }
    }
    
    if ( !isdefined( var_c08e832913e1c60f.var_fd9b39439920c808 ) )
    {
        var_c08e832913e1c60f.var_fd9b39439920c808 = "uin_cer_dlgl_greenlight";
    }
    
    level.var_c267f3cfc720a3be[ "specialty_tps_high_gain_antenna" ] = &"sat_perks/tps_high_gain_antenna";
}

// Namespace perk_tps_high_gain_antenna
// Params 0
// Checksum 0x197e44e4, Offset: 0x21c
// Size: 0xe
function function_58993cfa9d59afaf()
{
    namespace_6db61cded148a258::set_team_perk( "specialty_tps_high_gain_antenna" );
}

// Namespace perk_tps_high_gain_antenna
// Params 0
// Checksum 0x1db260b1, Offset: 0x232
// Size: 0xe
function function_5ae63dffa4806f84()
{
    namespace_6db61cded148a258::unset_team_perk( "specialty_tps_high_gain_antenna" );
}

// Namespace perk_tps_high_gain_antenna
// Params 1
// Checksum 0x1e66b864, Offset: 0x248
// Size: 0xa4
function function_794513c08263d74f( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_high_gain_antenna" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_high_gain_antenna" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_buff_high_gain_antenna", undefined, undefined, [ "specialty_expanded_minimap" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_high_gain_antenna" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_high_gain_antenna" ] = "specialty_tps_buff_high_gain_antenna";
        }
    }
}

