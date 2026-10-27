// scripts\mp\maps\mp_sat_whiteout\mp_sat_whiteout_fx.gsc  (hash_19257419c08672c2.gscc) (size: 1903 Bytes / 0x76f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x746380f9 (1952678137)
// size ...... 1903 (0x76f)
// includes .. 0   (offset: 0x6d3)
// strings ... 13  (offset: 0x6d3)
// dev strs .. 0   (offset: 0x76f)
// exports ... 4   (offset: 0x4f3)
// cseg ...... 0x1d4 + 0x31f (0x4f3)
// imports ... 11  (offset: 0x593)
// animtree1 . 0   (offset: 0x76f)
// animtree2 . 0   (offset: 0x76f)
#namespace mp_sat_whiteout_fx;

// Namespace mp_sat_whiteout_fx
// Params 0
// Checksum 0xa742e0d5, Offset: 0x1f2
// Size: 0x1c0
function main()
{
    var_d45df6ca65893c35 = getnoentvolumearray( "sliding_door", #script_noteworthy );
    
    foreach ( t_sliding_door in var_d45df6ca65893c35 )
    {
        if ( isdefined( t_sliding_door.script_fxid ) )
        {
            t_sliding_door thread watch_door( t_sliding_door.script_fxid );
        }
    }
    
    var_ae92086294e1e115 = [ "we_vfx_skylight01_snow_gust", "we_vfx_skylight02_snow_gust", "we_vfx_skylight03_snow_gust", "we_vfx_skylight04_snow_gust", "we_vfx_skylight05_snow_gust", "we_vfx_skylight06_snow_gust", "we_vfx_skylight07_snow_gust", "we_vfx_skylight08_snow_gust", "we_vfx_window01_snow_gust", "we_vfx_window02_snow_gust", "we_vfx_window03_snow_gust", "we_vfx_window04_snow_gust" ];
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

// Namespace mp_sat_whiteout_fx
// Params 1
// Checksum 0x5107b947, Offset: 0x3ba
// Size: 0x4a
function watch_door( str_world_event )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"open_start" );
        activateworldevent( str_world_event );
        self waittill( #"close_start" );
        deactivateworldevent( str_world_event, 1 );
    }
}

// Namespace mp_sat_whiteout_fx
// Params 0
// Checksum 0x1f00304d, Offset: 0x40c
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

