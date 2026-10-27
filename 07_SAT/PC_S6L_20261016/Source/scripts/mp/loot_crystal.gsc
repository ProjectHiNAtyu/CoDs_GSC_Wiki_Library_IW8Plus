// scripts\mp\loot_crystal.gsc  (hash_0140a704b67b8e6d.gscc) (size: 10639 Bytes / 0x298f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a2825db (2049451483)
// size ...... 10639 (0x298f)
// includes .. 8   (offset: 0x2783)
// strings ... 25  (offset: 0x27c3)
// dev strs .. 6   (offset: 0x2947)
// exports ... 15  (offset: 0x1dbb)
// cseg ...... 0x294 + 0x1b27 (0x1dbb)
// imports ... 60  (offset: 0x2013)
// animtree1 . 0   (offset: 0x298f)
// animtree2 . 0   (offset: 0x298f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\content_manager;
#using scripts\mp\loot\common_item;

#namespace loot_crystal;

// Namespace loot_crystal
// Params 0
// Checksum 0x6c039451, Offset: 0x2b2
// Size: 0xf0
function init_loot_crystal()
{
    var_8defad34d5b70562 = level.gamemodebundle.var_8defad34d5b70562;
    
    if ( !isdefined( var_8defad34d5b70562 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    s_bundle = getscriptbundle( "lootcrystal:" + var_8defad34d5b70562 );
    level.var_8defad34d5b70562 = s_bundle;
    
    if ( level.var_8defad34d5b70562.forcetrailfx )
    {
        assert( isdefined( level.var_8defad34d5b70562.var_90e097a7e58c0416 ), "<dev string:x48>" );
        level._effect[ "vfx_loot_crystal_trail" ] = loadfxasset( level.var_8defad34d5b70562.var_90e097a7e58c0416 );
    }
    
    content_manager::function_3209da123476142f( "loot_crystal", &on_spawn_loot_crystal );
    level thread init_loot_crystal_postmain();
    scriptable::scriptable_addnotifycallback( "loot_crystal_destroyed", &loot_crystal_destroyed );
    callback::add( "ob_content_process_create_script", &function_9006f59f6ca6b230 );
}

// Namespace loot_crystal
// Params 0
// Checksum 0x954d33bc, Offset: 0x3aa
// Size: 0xe2
function init_loot_crystal_postmain()
{
    level endon( #"game_ended" );
    waittillframeend();
    var_959dbddcfff2592d = utility::getstructarray( "content_destination", "variantname" );
    
    if ( var_959dbddcfff2592d.size > 0 )
    {
        foreach ( destination in var_959dbddcfff2592d )
        {
            level thread function_8d3fe666a157f281( destination );
        }
    }
    
    wait 1;
    
    if ( level.gametypebundle.var_95661b833394af12 )
    {
        function_e5b842a308232216();
    }
    
    utility::registersharedfunc( #"dark_flare", #"hash_d3bbf1093b70aec7", &function_1f7fc83b06996fec );
}

// Namespace loot_crystal
// Params 1
// Checksum 0x950d0de, Offset: 0x494
// Size: 0xe7
function function_1f7fc83b06996fec( potential_enemies )
{
    foreach ( enemy in potential_enemies )
    {
        if ( isdefined( enemy[ "scriptable" ] ) )
        {
            if ( issubstr( enemy[ "scriptable" ].type, "zm_loot_crystal_medium_01" ) || issubstr( enemy[ "scriptable" ].type, "zm_loot_crystal_medium_02" ) )
            {
                enemy[ "scriptable" ] setscriptablepartstate( "loot_crystal", "dead" );
                loot_crystal_destroyed( enemy[ "scriptable" ], "loot_crystal_destroyed", 1, self );
            }
        }
    }
}

// Namespace loot_crystal
// Params 1
// Checksum 0x73dbdc3b, Offset: 0x583
// Size: 0x68b
function function_8d3fe666a157f281( destination )
{
    if ( level.var_8defad34d5b70562.var_228ed8925e010b74 && isdefined( level.var_bb131187d6741752 ) )
    {
        var_2b6b055b2935075 = level.var_8defad34d5b70562.var_1342aaa66e834d96 / 100;
        var_b70bd36e94fe24a2 = level.var_8defad34d5b70562.var_1ca2f1249789609 / 100;
        var_eb0cd91ac5522bbc = level.var_8defad34d5b70562.var_98fec67b8345aaf / 100;
        var_5ed7c7e4e2174021 = level.var_8defad34d5b70562.var_af5beb770ba035b2 / 100;
        var_f19c53653bd7bff1 = [];
        var_cc7775a64648e86e = [];
        var_bd3eb55587fe0154 = [];
        var_3f243a0d162f7f41 = [];
        var_8987919a3e327cb4 = [];
        
        foreach ( location in destination.locations )
        {
            loot_crystal = location.instances[ "loot_crystal" ];
            
            if ( isdefined( loot_crystal ) )
            {
                foreach ( instance in loot_crystal.versions )
                {
                    difficulty = [[ level.var_bb131187d6741752 ]]( instance.origin );
                    
                    switch ( difficulty )
                    {
                        case #"hash_7bb2cd766703d463":
                            var_f19c53653bd7bff1[ var_f19c53653bd7bff1.size ] = instance;
                            break;
                        case #"hash_af83e47edfa8900a":
                            var_cc7775a64648e86e[ var_cc7775a64648e86e.size ] = instance;
                            break;
                        case #"hash_5343b465e56ec9a4":
                            var_bd3eb55587fe0154[ var_bd3eb55587fe0154.size ] = instance;
                            break;
                        case #"hash_651f76c0ad6741ec":
                            var_3f243a0d162f7f41[ var_3f243a0d162f7f41.size ] = instance;
                            break;
                        case #"hash_a1e09f51896088fb":
                            var_8987919a3e327cb4[ var_8987919a3e327cb4.size ] = instance;
                            break;
                    }
                }
                
                green_count = 0;
                yellow_count = 0;
                var_182e202c37640be4 = 0;
                var_2e792b16e18939f9 = 0;
                var_95f6bfbf83d189d8 = var_f19c53653bd7bff1.size * var_2b6b055b2935075;
                var_20f5ed61ab5ca2a1 = var_cc7775a64648e86e.size * var_b70bd36e94fe24a2;
                var_5839d97e5bcd5f53 = var_bd3eb55587fe0154.size * var_eb0cd91ac5522bbc;
                var_f170047c96937408 = var_3f243a0d162f7f41.size * var_5ed7c7e4e2174021;
                var_f19c53653bd7bff1 = arrayrandomize( var_f19c53653bd7bff1 );
                var_cc7775a64648e86e = arrayrandomize( var_cc7775a64648e86e );
                var_bd3eb55587fe0154 = arrayrandomize( var_bd3eb55587fe0154 );
                var_3f243a0d162f7f41 = arrayrandomize( var_3f243a0d162f7f41 );
                
                foreach ( instance in var_f19c53653bd7bff1 )
                {
                    if ( green_count < var_95f6bfbf83d189d8 )
                    {
                        content_manager::function_67e4b7678fb21e11( instance );
                        green_count++;
                    }
                }
                
                foreach ( instance in var_cc7775a64648e86e )
                {
                    if ( yellow_count < var_20f5ed61ab5ca2a1 )
                    {
                        content_manager::function_67e4b7678fb21e11( instance );
                        yellow_count++;
                    }
                }
                
                foreach ( instance in var_bd3eb55587fe0154 )
                {
                    if ( var_182e202c37640be4 < var_5839d97e5bcd5f53 )
                    {
                        content_manager::function_67e4b7678fb21e11( instance );
                        var_182e202c37640be4++;
                    }
                }
                
                foreach ( instance in var_3f243a0d162f7f41 )
                {
                    if ( var_2e792b16e18939f9 < var_f170047c96937408 )
                    {
                        content_manager::function_67e4b7678fb21e11( instance );
                        var_2e792b16e18939f9++;
                    }
                }
                
                foreach ( instance in var_8987919a3e327cb4 )
                {
                    content_manager::function_67e4b7678fb21e11( instance );
                }
                
                level.var_8defad34d5b70562.green_count = green_count;
                level.var_8defad34d5b70562.yellow_count = yellow_count;
                level.var_8defad34d5b70562.var_182e202c37640be4 = var_182e202c37640be4;
                level.var_8defad34d5b70562.var_2e792b16e18939f9 = var_2e792b16e18939f9;
            }
        }
        
        return;
    }
    
    foreach ( location in destination.locations )
    {
        loot_crystal = location.instances[ "loot_crystal" ];
        
        if ( isdefined( loot_crystal ) )
        {
            foreach ( instance in loot_crystal.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace loot_crystal
// Params 1
// Checksum 0xb719139a, Offset: 0xc16
// Size: 0x24d
function on_spawn_loot_crystal( struct )
{
    assert( isstruct( struct ), "<dev string:x63>" );
    
    if ( isdefined( struct.var_1d6cddfc47031bff ) )
    {
        spawn_points = struct.var_1d6cddfc47031bff[ "loot_crystal_spawn" ];
    }
    else
    {
        spawn_points = utility::getstructarray( struct.targetname, "target" );
    }
    
    spawn_points = arrayrandomize( spawn_points );
    
    if ( level.var_8defad34d5b70562.var_228ed8925e010b74 && isdefined( level.var_bb131187d6741752 ) )
    {
        var_fa82ba9173f908e9 = level.var_8defad34d5b70562.var_71bc1cf027ff2736 / 100;
        var_bae74b5c4367fc26 = level.var_8defad34d5b70562.var_3ef3d820d7814407 / 100;
        var_3302532685d797d8 = level.var_8defad34d5b70562.var_4e36a6f42ab11db1 / 100;
        var_895d0dc8ef743d35 = level.var_8defad34d5b70562.var_fee8430bbf2d1bd2 / 100;
        difficulty = [[ level.var_bb131187d6741752 ]]( struct.origin );
        totalspawnpoints = spawn_points.size;
        
        switch ( difficulty )
        {
            case #"hash_7bb2cd766703d463":
                totalspawnpoints *= var_fa82ba9173f908e9;
                break;
            case #"hash_af83e47edfa8900a":
                totalspawnpoints *= var_bae74b5c4367fc26;
                break;
            case #"hash_5343b465e56ec9a4":
                totalspawnpoints *= var_3302532685d797d8;
                break;
            case #"hash_651f76c0ad6741ec":
                totalspawnpoints *= var_895d0dc8ef743d35;
                break;
            case #"hash_a1e09f51896088fb":
                totalspawnpoints = spawn_points.size;
                break;
        }
        
        for ( count = 0; count < totalspawnpoints ; count++ )
        {
            point = spawn_points[ count ];
            point function_ecf9c35748fd4a87( point );
        }
        
        return;
    }
    
    foreach ( point in spawn_points )
    {
        point function_ecf9c35748fd4a87( point );
    }
}

// Namespace loot_crystal
// Params 1
// Checksum 0xdbb553a7, Offset: 0xe6b
// Size: 0x188
function function_ecf9c35748fd4a87( point )
{
    randomindex = randomintrange( 0, level.var_8defad34d5b70562.var_c9769cfe21fe9706.size );
    scriptablename = level.var_8defad34d5b70562.var_c9769cfe21fe9706[ randomindex ];
    mapinfo = getactivemapinfobundle();
    var_d2e325ed1ceba400 = mapinfo.var_4a98227bf6f428ba;
    
    if ( isarray( var_d2e325ed1ceba400 ) )
    {
        foreach ( var_232bf4cbe3e7f0ce in var_d2e325ed1ceba400 )
        {
            if ( var_232bf4cbe3e7f0ce.var_5d4a55e1eb574935 == scriptablename.lootcrystal )
            {
                scriptablename.lootcrystal = var_232bf4cbe3e7f0ce.override;
            }
        }
    }
    
    var_4ff1da43e40edfbb = spawnscriptable( scriptablename.lootcrystal, point.origin, point.angles );
    
    if ( !isdefined( level.a_loot_crystals ) )
    {
        level.a_loot_crystals = [];
    }
    
    level.a_loot_crystals[ level.a_loot_crystals.size ] = var_4ff1da43e40edfbb;
    var_4ff1da43e40edfbb callback::add( #"on_ping", &function_2eb750f3c5112cfd );
}

// Namespace loot_crystal
// Params 0
// Checksum 0x4cab0a96, Offset: 0xffb
// Size: 0x9d
function function_e5b842a308232216()
{
    if ( isdefined( level.a_loot_crystals ) )
    {
        var_d68237c8f32da310 = arrayrandomize( level.a_loot_crystals );
        
        for ( i = 0; i < var_d68237c8f32da310.size - 2 ; i++ )
        {
            loot_crystal = var_d68237c8f32da310[ i ];
            
            if ( isdefined( loot_crystal ) )
            {
                loot_crystal.var_9b1d149d27bb0245 = 1;
                loot_crystal setscriptablepartstate( "loot_crystal", "dead" );
                loot_crystal.var_9b1d149d27bb0245 = undefined;
            }
        }
        
        callback::add( "on_round_end", &function_ba23d11faab713ee );
        
        /#
            init_loot_crystal_devgui();
        #/
    }
}

// Namespace loot_crystal
// Params 1
// Checksum 0x6896b274, Offset: 0x10a0
// Size: 0x306
function loot_crystal_spawn_item( var_64ffacba090c91be )
{
    self endon( #"death" );
    waitframe();
    loot_crystal_item_list = level.var_8defad34d5b70562.var_81b5c42669d4a12b;
    n_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    
    if ( n_round > 0 && n_round < 15 )
    {
        loot_crystal_item_list = level.var_8defad34d5b70562.var_81b5c42669d4a12b;
    }
    else if ( n_round >= 15 && n_round < 35 )
    {
        loot_crystal_item_list = level.var_8defad34d5b70562.var_ed76ee0d8a010ed0;
    }
    else if ( n_round >= 35 && n_round < 55 )
    {
        loot_crystal_item_list = level.var_8defad34d5b70562.var_1cf74a9e46bd9a02;
    }
    else if ( n_round >= 55 )
    {
        loot_crystal_item_list = level.var_8defad34d5b70562.var_15e07979083b6b5f;
    }
    
    if ( self.var_d5612a8f972e99e && isdefined( self.target ) )
    {
        spawnoptions = common_item::function_b94327aa4c1b718b( utility::getstruct( self.target ).origin, self );
    }
    else
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    }
    
    spawnoptions.var_c580c0e8b49f1fcc = 1;
    spawnoptions.var_4a4b419f66681601 = [];
    
    if ( isplayer( var_64ffacba090c91be ) )
    {
        level thread utility::callsharedfunc( #"zombie", #"hash_26befc250486510c", self.origin, self.angles, var_64ffacba090c91be );
        spawnoptions.var_4a4b419f66681601[ spawnoptions.var_4a4b419f66681601.size ] = var_64ffacba090c91be;
    }
    
    nearbyplayers = getplayersinradius( self.origin, 512 );
    
    foreach ( player in nearbyplayers )
    {
        if ( !( player === var_64ffacba090c91be ) )
        {
            spawnoptions.var_4a4b419f66681601[ spawnoptions.var_4a4b419f66681601.size ] = player;
        }
    }
    
    itemsspawned = level common_item::function_38cde6a6acb68ea6( loot_crystal_item_list, 1, spawnoptions );
    
    if ( level.var_8defad34d5b70562.forcetrailfx )
    {
        foreach ( item in itemsspawned )
        {
            item.var_8023db5dbe062e94 = 1;
        }
    }
    
    utility::callsharedfunc( #"daisy", #"hash_fbcc3c3ea1570205", spawnoptions );
}

// Namespace loot_crystal
// Params 2
// Checksum 0x4bb84ada, Offset: 0x13ae
// Size: 0x81
function function_fcb44a60f50e5aed( item, originpos )
{
    var_e489d7775c8f645d = spawn( "script_model", originpos );
    var_e489d7775c8f645d setmodel( "tag_origin" );
    playfxontag( utility::getfx( "vfx_loot_crystal_trail" ), var_e489d7775c8f645d, "tag_origin" );
    dirpos = item.origin - originpos;
    var_e489d7775c8f645d movegravity( dirpos, 1 );
    wait 1;
    var_e489d7775c8f645d delete();
}

// Namespace loot_crystal
// Params 4
// Checksum 0x15525084, Offset: 0x1437
// Size: 0xf3
function loot_crystal_destroyed( instance, note, param, var_64ffacba090c91be )
{
    if ( !instance.var_9b1d149d27bb0245 )
    {
        instance thread loot_crystal_spawn_item( var_64ffacba090c91be );
    }
    
    if ( isdefined( instance.var_24e64665a26e94d ) && isplayer( instance.var_24e64665a26e94d.player ) )
    {
        instance.var_24e64665a26e94d.player calloutmarkerping::function_7c0ee9d4b604e6d6( instance.var_24e64665a26e94d.pingindex );
    }
    
    sparams = spawnstruct();
    sparams.instance = instance;
    sparams.note = note;
    sparams.param = param;
    sparams.var_64ffacba090c91be = var_64ffacba090c91be;
    callback::callback( "loot_crystal_destroyed", sparams );
}

// Namespace loot_crystal
// Params 1, eflags: 0x4
// Checksum 0x9978bdac, Offset: 0x1532
// Size: 0x29
function private function_2eb750f3c5112cfd( params )
{
    if ( isplayer( params.player ) )
    {
        self.var_24e64665a26e94d = params;
    }
}

// Namespace loot_crystal
// Params 1
// Checksum 0x6f514040, Offset: 0x1563
// Size: 0x1d4
function function_ba23d11faab713ee( params )
{
    if ( isdefined( level.a_loot_crystals ) )
    {
        var_ed40354201e39c87 = 0;
        a_dead_crystals = [];
        
        foreach ( var_d02ad6c664efd3e0 in level.a_loot_crystals )
        {
            if ( isdefined( var_d02ad6c664efd3e0 ) && var_d02ad6c664efd3e0 getscriptablepartstate( "loot_crystal" ) == "healthy" )
            {
                var_ed40354201e39c87++;
                continue;
            }
            
            a_dead_crystals[ a_dead_crystals.size ] = var_d02ad6c664efd3e0;
        }
        
        var_264a5576affc857c = min( 10, level.a_loot_crystals.size );
        var_a85e5f70b1ece86a = min( var_264a5576affc857c - var_ed40354201e39c87, 2 );
        
        if ( var_a85e5f70b1ece86a > 0 )
        {
            if ( var_a85e5f70b1ece86a > a_dead_crystals.size )
            {
                foreach ( var_d02ad6c664efd3e0 in a_dead_crystals )
                {
                    if ( isdefined( var_d02ad6c664efd3e0 ) )
                    {
                        var_d02ad6c664efd3e0 setscriptablepartstate( "loot_crystal", "healthy" );
                        var_d02ad6c664efd3e0 setscriptablepartstate( "audio", "on" );
                    }
                }
                
                return;
            }
            
            a_dead_crystals = arrayrandomize( a_dead_crystals );
            
            for ( i = 0; i < var_a85e5f70b1ece86a ; i++ )
            {
                a_dead_crystals[ i ] setscriptablepartstate( "loot_crystal", "healthy" );
                a_dead_crystals[ i ] setscriptablepartstate( "audio", "on" );
            }
        }
    }
}

// Namespace loot_crystal
// Params 1
// Checksum 0xae2fbd2b, Offset: 0x173f
// Size: 0x645
function function_9006f59f6ca6b230( sparams )
{
    if ( getdvarint( @"loot_crystal_disable", 0 ) )
    {
        return;
    }
    
    if ( level.var_8defad34d5b70562.var_228ed8925e010b74 && isdefined( level.var_bb131187d6741752 ) )
    {
        var_2b6b055b2935075 = level.var_8defad34d5b70562.var_1342aaa66e834d96 / 100;
        var_b70bd36e94fe24a2 = level.var_8defad34d5b70562.var_1ca2f1249789609 / 100;
        var_eb0cd91ac5522bbc = level.var_8defad34d5b70562.var_98fec67b8345aaf / 100;
        var_5ed7c7e4e2174021 = level.var_8defad34d5b70562.var_af5beb770ba035b2 / 100;
        var_f19c53653bd7bff1 = [];
        var_cc7775a64648e86e = [];
        var_bd3eb55587fe0154 = [];
        var_3f243a0d162f7f41 = [];
        var_8987919a3e327cb4 = [];
        a_cluster_instances = [];
        var_8590d7f7a9e49ac4 = utility::getstructarray( "content_instance", "variantname" );
        
        foreach ( struct in var_8590d7f7a9e49ac4 )
        {
            if ( struct.content_script_name == "loot_crystal" )
            {
                a_cluster_instances[ a_cluster_instances.size ] = struct;
            }
        }
        
        foreach ( instance in a_cluster_instances )
        {
            difficulty = [[ level.var_bb131187d6741752 ]]( instance.origin );
            
            switch ( difficulty )
            {
                case #"hash_7bb2cd766703d463":
                    var_f19c53653bd7bff1[ var_f19c53653bd7bff1.size ] = instance;
                    break;
                case #"hash_af83e47edfa8900a":
                    var_cc7775a64648e86e[ var_cc7775a64648e86e.size ] = instance;
                    break;
                case #"hash_5343b465e56ec9a4":
                    var_bd3eb55587fe0154[ var_bd3eb55587fe0154.size ] = instance;
                    break;
                case #"hash_651f76c0ad6741ec":
                    var_3f243a0d162f7f41[ var_3f243a0d162f7f41.size ] = instance;
                    break;
                case #"hash_a1e09f51896088fb":
                    var_8987919a3e327cb4[ var_8987919a3e327cb4.size ] = instance;
                    break;
            }
        }
        
        green_count = 0;
        yellow_count = 0;
        var_182e202c37640be4 = 0;
        var_2e792b16e18939f9 = 0;
        var_95f6bfbf83d189d8 = var_f19c53653bd7bff1.size * var_2b6b055b2935075;
        var_20f5ed61ab5ca2a1 = var_cc7775a64648e86e.size * var_b70bd36e94fe24a2;
        var_5839d97e5bcd5f53 = var_bd3eb55587fe0154.size * var_eb0cd91ac5522bbc;
        var_f170047c96937408 = var_3f243a0d162f7f41.size * var_5ed7c7e4e2174021;
        var_f19c53653bd7bff1 = arrayrandomize( var_f19c53653bd7bff1 );
        var_cc7775a64648e86e = arrayrandomize( var_cc7775a64648e86e );
        var_bd3eb55587fe0154 = arrayrandomize( var_bd3eb55587fe0154 );
        var_3f243a0d162f7f41 = arrayrandomize( var_3f243a0d162f7f41 );
        
        if ( isdefined( level.var_37ee95c5464d47be ) )
        {
            var_f19c53653bd7bff1 = [[ level.var_37ee95c5464d47be ]]( "green_crystal", var_f19c53653bd7bff1 );
        }
        
        foreach ( instance in var_f19c53653bd7bff1 )
        {
            if ( green_count < var_95f6bfbf83d189d8 )
            {
                on_spawn_loot_crystal( instance );
                green_count++;
            }
        }
        
        if ( isdefined( level.var_37ee95c5464d47be ) )
        {
            var_cc7775a64648e86e = [[ level.var_37ee95c5464d47be ]]( "yellow_crystal", var_cc7775a64648e86e );
        }
        
        foreach ( instance in var_cc7775a64648e86e )
        {
            if ( yellow_count < var_20f5ed61ab5ca2a1 )
            {
                on_spawn_loot_crystal( instance );
                yellow_count++;
            }
        }
        
        if ( isdefined( level.var_37ee95c5464d47be ) )
        {
            var_bd3eb55587fe0154 = [[ level.var_37ee95c5464d47be ]]( "orange_crystal", var_bd3eb55587fe0154 );
        }
        
        foreach ( instance in var_bd3eb55587fe0154 )
        {
            if ( var_182e202c37640be4 < var_5839d97e5bcd5f53 )
            {
                on_spawn_loot_crystal( instance );
                var_182e202c37640be4++;
            }
        }
        
        if ( isdefined( level.var_37ee95c5464d47be ) )
        {
            var_3f243a0d162f7f41 = [[ level.var_37ee95c5464d47be ]]( "red_crystal", var_3f243a0d162f7f41 );
        }
        
        foreach ( instance in var_3f243a0d162f7f41 )
        {
            if ( var_2e792b16e18939f9 < var_f170047c96937408 )
            {
                on_spawn_loot_crystal( instance );
                var_2e792b16e18939f9++;
            }
        }
        
        foreach ( instance in var_8987919a3e327cb4 )
        {
            on_spawn_loot_crystal( instance );
        }
        
        level.var_8defad34d5b70562.green_count = green_count;
        level.var_8defad34d5b70562.yellow_count = yellow_count;
        level.var_8defad34d5b70562.var_182e202c37640be4 = var_182e202c37640be4;
        level.var_8defad34d5b70562.var_2e792b16e18939f9 = var_2e792b16e18939f9;
        callback::callback( "ob_crystals_create_script_done" );
    }
}

/#

    // Namespace loot_crystal
    // Params 0
    // Checksum 0x75e00fda, Offset: 0x1d8c
    // Size: 0x2f, Type: dev
    function init_loot_crystal_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7e>" );
        devgui::add_devgui_func( "<dev string:x8f>", "<dev string:xa4>", &function_ba23d11faab713ee, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
