// scripts\mp\common\perks\perk_tps_health_on_kill.gsc  (hash_5c403fed476f3d5e.gscc) (size: 2419 Bytes / 0x973 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa29a9939 (2728040761)
// size ...... 2419 (0x973)
// includes .. 2   (offset: 0x8d3)
// strings ... 6   (offset: 0x8e3)
// dev strs .. 0   (offset: 0x973)
// exports ... 12  (offset: 0x54b)
// cseg ...... 0xdd + 0x46e (0x54b)
// imports ... 15  (offset: 0x72b)
// animtree1 . 0   (offset: 0x973)
// animtree2 . 0   (offset: 0x973)
#using script_326e44f18084416a;
#using scripts\common\callbacks;

#namespace perk_tps_health_on_kill;

// Namespace perk_tps_health_on_kill
// Params 0, eflags: 0x5
// Checksum 0xf3714518, Offset: 0xfb
// Size: 0x2e
function private autoexec main()
{
    level callback::add( #"register_perk", &function_4c52fc048b2a533d );
    level callback::add( #"register_perk", &registerteambuffhealthonkill );
}

// Namespace perk_tps_health_on_kill
// Params 1
// Checksum 0x6ebdca78, Offset: 0x131
// Size: 0xe4
function function_4c52fc048b2a533d( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_health_on_kill" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_health_on_kill" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_health_on_kill", &function_c72513f5353b3e54, &function_968e39152ae98171, [ "specialty_tps_buff_health_on_kill" ] );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_health_on_kill" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_health_on_kill" ] = "specialty_tps_buff_health_on_kill";
        }
    }
    
    if ( !isdefined( var_c08e832913e1c60f.var_fd9b39439920c808 ) )
    {
        var_c08e832913e1c60f.var_fd9b39439920c808 = "uin_cer_splash_medal_small";
    }
    
    level.var_c267f3cfc720a3be[ "specialty_tps_health_on_kill" ] = &"sat_perks/tps_health_on_kill";
}

// Namespace perk_tps_health_on_kill
// Params 0
// Checksum 0x12a25423, Offset: 0x21d
// Size: 0xe
function function_c72513f5353b3e54()
{
    namespace_6db61cded148a258::set_team_perk( "specialty_tps_health_on_kill" );
}

// Namespace perk_tps_health_on_kill
// Params 0
// Checksum 0xb086e5b6, Offset: 0x233
// Size: 0xe
function function_968e39152ae98171()
{
    namespace_6db61cded148a258::unset_team_perk( "specialty_tps_health_on_kill" );
}

// Namespace perk_tps_health_on_kill
// Params 1
// Checksum 0x1760b2dc, Offset: 0x249
// Size: 0xdf
function registerteambuffhealthonkill( params )
{
    perkbundle = level.perkbundles[ "specialty_tps_health_on_kill" ];
    var_c08e832913e1c60f = level.perkbundles[ "specialty_tps_buff_health_on_kill" ];
    
    if ( !( isdefined( perkbundle ) && isdefined( var_c08e832913e1c60f ) ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tps_buff_health_on_kill", &setteambuffhealthonkill, &unsetteambuffhealthonkill );
        
        if ( !isdefined( level.var_e8baaf9a6a5a10e0[ "specialty_tps_health_on_kill" ] ) )
        {
            level.var_e8baaf9a6a5a10e0[ "specialty_tps_health_on_kill" ] = "specialty_tps_buff_health_on_kill";
        }
    }
    
    if ( isdefined( params.var_5109b530c69d18a1 ) )
    {
        level [[ params.var_5109b530c69d18a1 ]]( "specialty_tps_buff_health_on_kill", &function_eefb6c9f97f6e78 );
    }
    
    callback::add( #"hash_6a8a551945faab9", &function_84857b5be08cb7b3 );
}

// Namespace perk_tps_health_on_kill
// Params 0
// Checksum 0x1659c5c9, Offset: 0x330
// Size: 0xc
function setteambuffhealthonkill()
{
    self.var_c5daf17dab506187 = 0;
}

// Namespace perk_tps_health_on_kill
// Params 0
// Checksum 0xd9db7819, Offset: 0x344
// Size: 0xa
function unsetteambuffhealthonkill()
{
    function_c8a2e9a86aca9fa8( 0 );
}

// Namespace perk_tps_health_on_kill
// Params 1
// Checksum 0x843a3fbc, Offset: 0x356
// Size: 0x56
function function_eefb6c9f97f6e78( params )
{
    smeansofdeath = params.smeansofdeath ?? "";
    
    if ( smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_EXECUTION" )
    {
        return;
    }
    
    self notify( #"teambuffhealthonkill_applybuff" );
    teambuffhealthonkill_applybuff();
}

// Namespace perk_tps_health_on_kill
// Params 0
// Checksum 0x143cf7d8, Offset: 0x3b4
// Size: 0xb7
function teambuffhealthonkill_applybuff()
{
    if ( !isdefined( self.cranked ) )
    {
        self.var_c5daf17dab506187 = 1;
        var_5222dcea1434af75 = level.perkbundles[ "specialty_tps_health_on_kill" ].var_7b39691c9f15ba3 ?? 3;
        thread function_c8a2e9a86aca9fa8( var_5222dcea1434af75 );
        var_f427dd18ac2fe135 = level.sharedfuncs[ #"playerhealth" ][ #"hash_edc16c12ca11400" ];
        
        if ( isdefined( var_f427dd18ac2fe135 ) )
        {
            var_e532634220155578 = level.perkbundles[ "specialty_tps_health_on_kill" ].var_73e1e9ac7f4fc693 ?? 0.5;
            self [[ var_f427dd18ac2fe135 ]]( #"hash_c4b233e642a6a1d2", var_e532634220155578 );
        }
    }
}

// Namespace perk_tps_health_on_kill
// Params 1
// Checksum 0x379122d6, Offset: 0x473
// Size: 0x74
function function_c8a2e9a86aca9fa8( buffduration )
{
    if ( buffduration )
    {
        self endon( #"teambuffhealthonkill_applybuff" );
        self endon( #"death_or_disconnect" );
        wait buffduration;
    }
    
    self.var_c5daf17dab506187 = 0;
    var_1c2fdadc1c73aca8 = level.sharedfuncs[ #"playerhealth" ][ #"hash_325a50f0cddc1ff" ];
    
    if ( isdefined( var_1c2fdadc1c73aca8 ) )
    {
        self [[ var_1c2fdadc1c73aca8 ]]( #"hash_c4b233e642a6a1d2" );
    }
}

// Namespace perk_tps_health_on_kill
// Params 1
// Checksum 0x7fc9dc53, Offset: 0x4ef
// Size: 0x5c
function function_84857b5be08cb7b3( params )
{
    if ( self.var_c5daf17dab506187 )
    {
        var_45e18ebe6e47c2b5 = level.perkbundles[ "specialty_tps_health_on_kill" ].var_8ee970329e41f084 ?? 5;
        params.var_2b32a8de075bfd54 *= var_45e18ebe6e47c2b5;
    }
}

