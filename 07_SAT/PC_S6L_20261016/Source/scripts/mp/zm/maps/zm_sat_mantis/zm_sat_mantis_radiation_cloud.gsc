// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_radiation_cloud.gsc  (hash_6f3849067c02be9f.gscc) (size: 5346 Bytes / 0x14e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x615e1eea (1633558250)
// size ...... 5346 (0x14e2)
// includes .. 3   (offset: 0x1432)
// strings ... 12  (offset: 0x144a)
// dev strs .. 0   (offset: 0x14e2)
// exports ... 12  (offset: 0xdde)
// cseg ...... 0x145 + 0xc99 (0xdde)
// imports ... 38  (offset: 0xfbe)
// animtree1 . 0   (offset: 0x14e2)
// animtree2 . 0   (offset: 0x14e2)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace zm_sat_mantis_radiation_cloud;

// Namespace zm_sat_mantis_radiation_cloud
// Params 0
// Checksum 0xba6cd6e3, Offset: 0x163
// Size: 0xa
function main()
{
    level thread init_radiation_cloud();
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 0
// Checksum 0x95887294, Offset: 0x175
// Size: 0x2d
function init_radiation_cloud()
{
    init_radiation_cloud_data();
    level callback::add( "special_round_start", &function_520e1d4de5728993 );
    level callback::add( "special_round_end", &function_92220a041c08b6e0 );
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 0
// Checksum 0x50ae1e04, Offset: 0x1aa
// Size: 0x2d2
function init_radiation_cloud_data()
{
    if ( !isdefined( level.radiation_cloud ) )
    {
        level.radiation_cloud = {};
    }
    
    level.radiation_cloud.config = getscriptbundle( "mantisradiationcloud:zm_sat_mantis_radiation_cloud" ) ?? { #var_cbfbe7513bd633f4:6, #var_1fc8d27d8ef50e53:16, #var_ad8b0c7c19aaaf41:16, #radius:64, #damageinterval:0.45, #var_9389ec1b95df92c:14, #var_9389fc1b95dfb5f:12, #var_938a0c1b95dfd92:10, #var_f72fcbee7b1cf0ad:4, #var_f72fcaee7b1cee7a:2, #var_f72fc9ee7b1cec47:0 };
    var_5ea32d68cbe03d3d = utility::getstructarray( "radiation_cloud_spot1", "targetname" );
    var_5ea32a68cbe036a4 = utility::getstructarray( "radiation_cloud_spot2", "targetname" );
    
    if ( var_5ea32d68cbe03d3d.size > 0 && var_5ea32a68cbe036a4.size > 0 )
    {
        radiation_cloud_get_data( var_5ea32d68cbe03d3d );
        radiation_cloud_get_data( var_5ea32a68cbe036a4 );
        return;
    }
    
    spawn_origins = [ ( 55075, -31301.3, -124.919 ), ( 55259.7, -30794.7, -124.176 ), ( 54589.8, -30287.2, -122.193 ), ( 54422.2, -29923, -124.267 ), ( 54838.5, -29602.6, -129.424 ), ( 55150.3, -29309.8, -127.408 ), ( 55764, -30277.2, -126.819 ), ( 56215.1, -30445.7, -116.917 ), ( 56379.1, -30882.3, -127.088 ), ( 56526.1, -30979, -128.014 ), ( 56805.4, -31329.4, -128.936 ), ( 57329.4, -31666.4, -120.639 ), ( 57271.1, -32152.4, -126.336 ), ( 56681.1, -32277.2, -127.29 ), ( 55821.4, -31273.3, -134.926 ), ( 55804.5, -30719.5, -125 ) ];
    var_b62d5bd46c743d0a = [];
    
    foreach ( point in spawn_origins )
    {
        var_b62d5bd46c743d0a[ var_b62d5bd46c743d0a.size ] = point + ( 22528, 0, 0 );
    }
    
    spawn_origins = arraycombine( spawn_origins, var_b62d5bd46c743d0a );
    level.radiation_cloud.default_origins = spawn_origins;
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 1
// Checksum 0x1be4ca30, Offset: 0x484
// Size: 0x10e
function radiation_cloud_get_data( var_b019719ed237b270 )
{
    zone_origins = [];
    
    foreach ( struct in var_b019719ed237b270 )
    {
        zone_name = struct.script_noteworthy;
        
        if ( !isdefined( zone_origins[ zone_name ] ) )
        {
            zone_origins[ zone_name ] = [];
        }
        
        zone_origins[ zone_name ][ zone_origins[ zone_name ].size ] = struct.origin;
    }
    
    if ( !isdefined( level.radiation_cloud.cloud_origins ) )
    {
        level.radiation_cloud.cloud_origins = [];
    }
    
    level.radiation_cloud.cloud_origins[ level.radiation_cloud.cloud_origins.size ] = zone_origins;
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 1
// Checksum 0x58eb4ba0, Offset: 0x59a
// Size: 0x2d
function function_520e1d4de5728993( params )
{
    radiation_cloud_clean();
    
    if ( !getdvarint( @"disable_radiation_cloud", 0 ) )
    {
        level thread radiation_cloud_round_start();
    }
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 1
// Checksum 0x7a28d9ea, Offset: 0x5cf
// Size: 0x1f
function function_92220a041c08b6e0( params )
{
    level notify( #"hash_15b37960176646dd" );
    radiation_cloud_clean();
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 0
// Checksum 0x540fcec7, Offset: 0x5f6
// Size: 0xcf
function radiation_cloud_clean()
{
    foreach ( player in level.players )
    {
        if ( player.var_cbcff40af44c5cac )
        {
            pbgpostfxbundleend( player, level.radiation_cloud.config.var_dc543a8344b43db2 );
            player.var_cbcff40af44c5cac = undefined;
        }
        
        player.var_a6f839964f669381 = undefined;
    }
    
    level.radiation_cloud.clouds = [];
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 0
// Checksum 0xdf2a1d4b, Offset: 0x6cd
// Size: 0x456
function radiation_cloud_round_start()
{
    config = level.radiation_cloud.config;
    spawn_origins = [];
    
    if ( level.radiation_cloud.cloud_origins && level.radiation_cloud.cloud_origins.size > 0 )
    {
        foreach ( spawn_struct_timeline in level.radiation_cloud.cloud_origins )
        {
            timeline_origins = [];
            
            foreach ( origins in spawn_struct_timeline )
            {
                zone_added = 0;
                available_origins = arraycopy( origins );
                function_cdc669dbc8ea2101( available_origins );
                
                while ( zone_added < config.var_cbfbe7513bd633f4 && available_origins.size > 0 )
                {
                    random_index = randomintrange( 0, available_origins.size );
                    timeline_origins[ timeline_origins.size ] = available_origins[ random_index ];
                    available_origins[ random_index ] = undefined;
                    
                    if ( isint( random_index ) )
                    {
                        function_cdc669dbc8ea2101( available_origins );
                    }
                    
                    zone_added++;
                }
            }
            
            var_44856e6cdd540d02 = randomintrange( config.var_1fc8d27d8ef50e53, config.var_ad8b0c7c19aaaf41 + 1 );
            
            while ( timeline_origins.size > var_44856e6cdd540d02 )
            {
                index = randomint( timeline_origins.size );
                timeline_origins[ index ] = undefined;
                
                if ( isint( index ) )
                {
                    function_cdc669dbc8ea2101( timeline_origins );
                }
            }
            
            spawn_origins = arraycombine( spawn_origins, timeline_origins );
        }
    }
    else
    {
        spawn_origins = level.radiation_cloud.default_origins;
    }
    
    foreach ( origin in spawn_origins )
    {
        spawn_point = utility::drop_to_ground( origin, 200 );
        
        if ( !isdefined( spawn_point ) )
        {
            continue;
        }
        
        cloud = spawn( "script_model", spawn_point );
        cloud setmodel( "tag_origin" );
        cloud.scriptable = spawnscriptable( level.radiation_cloud.config.var_3f0fdbb8bd1b51b1, spawn_point );
        cloud.scriptable scriptablesetparententity( cloud );
        cloud.scriptable setscriptablepartstate( "base", "spawn" );
        cloud thread radiation_cloud_lifetime();
        
        if ( !isdefined( level.radiation_cloud.clouds ) )
        {
            level.radiation_cloud.clouds = [];
        }
        
        level.radiation_cloud.clouds[ level.radiation_cloud.clouds.size ] = cloud;
    }
    
    foreach ( cloud in level.radiation_cloud.clouds )
    {
        cloud.trigger = spawn( "trigger_radius", cloud.origin, 0, config.radius, config.radius );
        cloud.trigger thread radiation_cloud_damage_trigger( config );
    }
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 1
// Checksum 0xe28ac4dc, Offset: 0xb2b
// Size: 0x59
function radiation_cloud_damage_trigger( config )
{
    level endon( #"game_ended" );
    level endon( #"hash_15b37960176646dd" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            player thread radiation_cloud_damage( config, self );
        }
    }
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 2
// Checksum 0x52d14507, Offset: 0xb8c
// Size: 0x1ef
function radiation_cloud_damage( config, trigger )
{
    level endon( #"game_ended" );
    level endon( #"hash_15b37960176646dd" );
    self endon( #"death_or_disconnect" );
    player = self;
    
    if ( player.var_a6f839964f669381 )
    {
        return;
    }
    
    player.var_a6f839964f669381 = 1;
    sound_counter = 4;
    entry_time = gettime();
    
    while ( isdefined( trigger ) && player istouching( trigger ) )
    {
        elapsed = ( gettime() - entry_time ) / 1000;
        current_damage = 0;
        
        if ( elapsed >= config.var_f72fcbee7b1cf0ad )
        {
            current_damage = config.var_9389ec1b95df92c;
        }
        else if ( elapsed >= config.var_f72fcaee7b1cee7a )
        {
            current_damage = config.var_9389fc1b95dfb5f;
        }
        else if ( elapsed >= config.var_f72fc9ee7b1cec47 )
        {
            current_damage = config.var_938a0c1b95dfd92;
        }
        
        if ( current_damage > 0 && !player::isinlaststand( player ) )
        {
            if ( !player.var_cbcff40af44c5cac )
            {
                pbgpostfxbundlestart( player, level.radiation_cloud.config.var_dc543a8344b43db2 );
                player.var_cbcff40af44c5cac = 1;
            }
            
            sound_counter++;
            
            if ( sound_counter >= 4 )
            {
                sound_counter = 0;
                player playsound( #"hash_ad71d645a56af75a" );
            }
            
            player dodamage( current_damage, player.origin, player );
        }
        
        wait config.damageinterval;
    }
    
    if ( player.var_cbcff40af44c5cac )
    {
        pbgpostfxbundleend( player, level.radiation_cloud.config.var_dc543a8344b43db2 );
        player.var_cbcff40af44c5cac = undefined;
    }
    
    player.var_a6f839964f669381 = undefined;
}

// Namespace zm_sat_mantis_radiation_cloud
// Params 0
// Checksum 0xd5676a16, Offset: 0xd83
// Size: 0x5b
function radiation_cloud_lifetime()
{
    level endon( #"game_ended" );
    level waittill( #"hash_15b37960176646dd" );
    self.scriptable setscriptablepartstate( "base", "remove" );
    wait 3;
    self.scriptable freescriptable();
    self.trigger delete();
    self delete();
}

