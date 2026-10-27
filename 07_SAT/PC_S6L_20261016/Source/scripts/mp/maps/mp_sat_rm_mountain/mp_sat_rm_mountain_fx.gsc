// scripts\mp\maps\mp_sat_rm_mountain\mp_sat_rm_mountain_fx.gsc  (hash_5ca59342b730b8b0.gscc) (size: 1862 Bytes / 0x746 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4414c9a8 (1142213032)
// size ...... 1862 (0x746)
// includes .. 0   (offset: 0x68e)
// strings ... 15  (offset: 0x68e)
// dev strs .. 0   (offset: 0x746)
// exports ... 4   (offset: 0x4ce)
// cseg ...... 0x217 + 0x2b7 (0x4ce)
// imports ... 10  (offset: 0x56e)
// animtree1 . 0   (offset: 0x746)
// animtree2 . 0   (offset: 0x746)
#namespace mp_sat_rm_mountain_fx;

// Namespace mp_sat_rm_mountain_fx
// Params 0
// Checksum 0xe5de8ccd, Offset: 0x235
// Size: 0x17b
function main()
{
    activateworldevent( "we_vfx_camera_snow" );
    level thread function_15c103706a01e62e();
    var_ae92086294e1e115 = [ "we_vfx_window_snow_roof_001", "we_vfx_window_snow_roof_002", "we_vfx_window_snow_roof_003", "we_vfx_window_snow_roof_004", "we_vfx_window_snow_roof_005", "we_vfx_window_snow_roof_006", "we_vfx_window_snow_roof_007", "we_vfx_window_snow_roof_008", "we_vfx_window_snow_med_001", "we_vfx_window_snow_med_002", "we_vfx_window_snow_med_003", "we_vfx_window_snow_med_004" ];
    var_70c4b363f61954e3 = 36;
    
    for ( i = 1; i < var_70c4b363f61954e3 + 1 ; i++ )
    {
        if ( i < 9 )
        {
            var_ae92086294e1e115[ var_ae92086294e1e115.size ] = "we_vfx_window_snow_sml_00" + i;
            continue;
        }
        
        var_ae92086294e1e115[ var_ae92086294e1e115.size ] = "we_vfx_window_snow_sml_0" + i;
    }
    
    level.var_fa306b437637e4be = [];
    
    foreach ( str_name in var_ae92086294e1e115 )
    {
        n_glass_id = getglassarray( str_name )[ 0 ];
        
        if ( isdefined( n_glass_id ) )
        {
            level.var_fa306b437637e4be[ str_name ] = n_glass_id;
        }
    }
    
    level thread watch_glass();
}

// Namespace mp_sat_rm_mountain_fx
// Params 0
// Checksum 0x99a05e6d, Offset: 0x3b8
// Size: 0x27
function function_15c103706a01e62e()
{
    level endon( #"disconnect" );
    level waittill( #"winners_circle_start" );
    deactivateworldevent( "we_vfx_camera_snow", 1 );
}

// Namespace mp_sat_rm_mountain_fx
// Params 0
// Checksum 0xd940d0ea, Offset: 0x3e7
// Size: 0xe7
function watch_glass()
{
    level endon( #"hash_ae78a05a1f3ffddb" );
    
    while ( level.var_fa306b437637e4be.size > 0 )
    {
        var_58e3ef9316f62aba = level.var_fa306b437637e4be;
        
        foreach ( n_glass in var_58e3ef9316f62aba )
        {
            if ( isdefined( n_glass ) )
            {
                if ( isglassdestroyed( n_glass ) )
                {
                    str_index = function_f02c63b99c9614c9( var_58e3ef9316f62aba, n_glass );
                    activateworldevent( str_index );
                    level.var_fa306b437637e4be[ str_index ] = undefined;
                    
                    if ( isint( str_index ) )
                    {
                        function_cdc669dbc8ea2101( level.var_fa306b437637e4be );
                    }
                }
            }
        }
        
        waitframe();
    }
}

