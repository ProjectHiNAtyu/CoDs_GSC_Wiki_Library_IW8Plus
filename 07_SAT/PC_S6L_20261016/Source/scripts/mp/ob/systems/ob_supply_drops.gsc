// scripts\mp\ob\systems\ob_supply_drops.gsc  (hash_37e6b1587adf7c3d.gscc) (size: 15421 Bytes / 0x3c3d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73e482c6 (1944355526)
// size ...... 15421 (0x3c3d)
// includes .. 17  (offset: 0x38e5)
// strings ... 34  (offset: 0x396d)
// dev strs .. 10  (offset: 0x3b65)
// exports ... 32  (offset: 0x2589)
// cseg ...... 0x443 + 0x2146 (0x2589)
// imports ... 121 (offset: 0x2a89)
// animtree1 . 0   (offset: 0x3bdd)
// animtree2 . 6   (offset: 0x3bdd)
#using script_6e05fdc2c6f5fa06;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\systems\ob_cradle_gas_circle;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace ob_supply_drops;

// Namespace ob_supply_drops
// Params 0
// Checksum 0x28960c0d, Offset: 0x461
// Size: 0x48
function init()
{
    logstring( "supply drops initialized, using dmz style" );
    ob_supply_drops_init();
    airdrop::initscriptedhelidropanims();
    
    if ( level.var_bb86f77304f193c4.var_d9afaaa763fb247d )
    {
        thread function_b0bf2ab7510dfd72();
    }
    
    function_7f3ca8cb86b04037();
    
    /#
        thread ob_supply_drops_debug();
    #/
}

// Namespace ob_supply_drops
// Params 0
// Checksum 0x308718ad, Offset: 0x4b1
// Size: 0x45d
function function_b0bf2ab7510dfd72()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    waittime = getdvarint( @"scr_ob_supply_drop_timer", 1200 );
    wait waittime;
    var_8a9b24951cf0b856 = getdvarint( @"scr_ob_supply_drop_teams", 2 );
    waittime = getdvarint( @"scr_ob_supply_drop_interval", 1200 );
    var_e0098575ab65abb = isnavmeshloaded( "vehicle_large" );
    var_6da16d41a0ec6e8b = isnavmeshloaded( "zombie_large" );
    navmeshlayer = var_e0098575ab65abb ? "vehicle_large" : var_6da16d41a0ec6e8b ? "zombie_large" : undefined;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player thread hud_message::showsplash( #"hash_c96d451ada2be018", undefined, undefined, undefined, 1, undefined );
        }
        
        droppos = undefined;
        squads = function_972fbc2588da754d();
        
        if ( squads.size > 1 )
        {
            squads = arrayrandomize( squads );
            centerpos = ( 0, 0, 0 );
            count = 0;
            
            foreach ( squad in squads )
            {
                pos = function_59cf527830d85de6( squad );
                
                if ( isdefined( pos ) )
                {
                    centerpos += pos;
                    count++;
                    
                    /#
                        if ( getdvarint( @"scr_ob_supply_drop_debug", 1 ) )
                        {
                            line( pos, pos + ( 0, 0, 10000 ), ( 0, 0, 1 ), 1, 0, 1000 );
                        }
                    #/
                }
                
                if ( count >= var_8a9b24951cf0b856 )
                {
                    break;
                }
            }
            
            if ( count > 1 )
            {
                droppos = centerpos / count;
                
                /#
                    if ( getdvarint( @"scr_ob_supply_drop_debug", 1 ) )
                    {
                        line( droppos, droppos + ( 0, 0, 10000 ), ( 0, 1, 1 ), 1, 0, 1000 );
                    }
                #/
            }
        }
        
        if ( !isdefined( droppos ) )
        {
            players = arrayrandomize( level.players );
            
            foreach ( player in players )
            {
                if ( isvalidplayer( player ) )
                {
                    droppos = player.origin;
                    mindropdist = getdvarint( @"hash_277842074c7f2d21", 4000 );
                    var_c606616b1bed6e3c = getdvarint( @"scr_ob_supply_drop_rand_dist", 3000 );
                    var_980b20725ddfad46 = 10;
                    retries = 0;
                    var_635c3f97dfddb6f3 = 400;
                    
                    while ( retries < var_980b20725ddfad46 )
                    {
                        randomdroppos = droppos + vectornormalize( utility::function_9e0df7b136ab833c() ) * ( randomint( var_c606616b1bed6e3c ) + mindropdist );
                        navmeshdroppos = getclosestpointonnavmesh( randomdroppos, navmeshlayer );
                        
                        if ( distance2d( randomdroppos, navmeshdroppos ) <= var_635c3f97dfddb6f3 )
                        {
                            break;
                        }
                        
                        retries++;
                        
                        /#
                            if ( getdvarint( @"scr_ob_supply_drop_debug", 1 ) )
                            {
                                sphere( randomdroppos, 20, ( 1, 0, 0 ), 0, 1000 );
                            }
                        #/
                    }
                    
                    droppos = randomdroppos;
                    break;
                }
            }
        }
        
        if ( isdefined( droppos ) )
        {
            droppos = getclosestpointonnavmesh( droppos, navmeshlayer );
            crateoptions = {};
            crateoptions.scriptkey = "random_supply_drop";
            thread function_989989bf968b8c87( droppos, undefined, 1, crateoptions );
        }
        
        wait waittime;
    }
}

// Namespace ob_supply_drops
// Params 1, eflags: 0x4
// Checksum 0x8487898c, Offset: 0x916
// Size: 0x21, Type: bool
function private isvalidplayer( player )
{
    return player::isreallyalive( player ) && !player ob_laststand::is_eliminated();
}

// Namespace ob_supply_drops
// Params 1, eflags: 0x4
// Checksum 0xedc08b16, Offset: 0x940
// Size: 0xda
function private function_59cf527830d85de6( squad )
{
    pos = ( 0, 0, 0 );
    count = 0;
    
    foreach ( player in squad.players )
    {
        if ( isvalidplayer( player ) && isdefined( player.origin ) )
        {
            pos += player.origin;
            count++;
        }
    }
    
    if ( count > 0 )
    {
        return ( pos / count );
    }
}

// Namespace ob_supply_drops
// Params 0, eflags: 0x4
// Checksum 0xab7a1220, Offset: 0xa23
// Size: 0x181
function private function_972fbc2588da754d()
{
    squads = [];
    
    foreach ( teamname in level.teamswithplayers )
    {
        var_3075f96a37ec0e36 = level.squaddata[ teamname ];
        
        foreach ( squad in var_3075f96a37ec0e36 )
        {
            foreach ( player in squad.players )
            {
                if ( isvalidplayer( player ) )
                {
                    squads[ squads.size ] = squad;
                    break;
                }
            }
        }
    }
    
    return squads;
}

// Namespace ob_supply_drops
// Params 2
// Checksum 0x5e335db6, Offset: 0xbad
// Size: 0xec
function function_446ff087bbc41922( target, var_92a113d51788eb02 )
{
    ping_info = spawnstruct();
    ping_info.owner = self;
    ping_info.ping_id = ping_info.owner calloutmarkerping::function_920a63c06abdefe8( target getscriptableindex() );
    
    if ( target.var_d26c6dba74c8a179 )
    {
        target.var_d26c6dba74c8a179[ self getentitynumber() ] = self;
        target.var_58cc57d664322d1d[ self getentitynumber() ] = ping_info.ping_id;
        
        if ( !isdefined( self.recordedpings ) )
        {
            self.recordedpings = [];
        }
        
        self.recordedpings[ ping_info.ping_id ] = target;
    }
    
    if ( !var_92a113d51788eb02 )
    {
        self calloutmarkerping_hide( ping_info.ping_id );
        self calloutmarkerping_show( ping_info.ping_id, self );
    }
    
    return ping_info;
}

// Namespace ob_supply_drops
// Params 8
// Checksum 0x2edb46b1, Offset: 0xca2
// Size: 0x270
function function_989989bf968b8c87( route_anchor_pos, route_orientation, precision_drop = 0, crate_options, activity_instance, var_90f46749b6388acb, var_20a60ad976cde992 = 1, crate_data )
{
    /#
        level notify( #"hash_c63b0e6d65853182" );
    #/
    
    crate_options.var_20a60ad976cde992 = var_20a60ad976cde992;
    plane_route = function_95476b3a80751086( route_anchor_pos, route_orientation, precision_drop );
    plane = ob_supply_drops_spawn_plane( plane_route );
    calloutmarkerping::function_6052d1ed5729bcfc( plane );
    
    if ( isdefined( activity_instance ) )
    {
        activity_instance.supply_drop_plane = plane;
    }
    
    plane setscriptablepartstate( "audio_loop", "on", 0 );
    plane setscriptablepartstate( "objective", "active_green", 0 );
    plane setscriptablepartstate( "contrails", "on", 0 );
    travel_time = plane_route.route_distance / plane.cruising_speed;
    plane.travel_time = travel_time;
    plane moveto( plane_route.end_point, travel_time );
    plane thread function_1ad74e6445aa1e5c();
    
    foreach ( player in var_90f46749b6388acb )
    {
        player function_446ff087bbc41922( plane, var_20a60ad976cde992 );
    }
    
    if ( plane_route.supply_drop_locations.size == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    crate_drop_count = precision_drop ? 1 : 3;
    
    if ( plane_route.supply_drop_locations.size < crate_drop_count )
    {
        crate_drop_count = plane_route.supply_drop_locations.size;
        assertmsg( "<dev string:x88>" );
    }
    
    var_60f55647663fa65d = arrayrandomize( plane_route.supply_drop_locations );
    
    for ( i = 0; i < crate_drop_count ; i++ )
    {
        var_60f55647663fa65d[ i ].selected_drop_point = 1;
    }
    
    plane thread function_57f2b4bcacf480b7( plane_route.supply_drop_locations, crate_drop_count, crate_options, activity_instance, crate_data );
}

// Namespace ob_supply_drops
// Params 0
// Checksum 0x53ebce8c, Offset: 0xf1a
// Size: 0xa5
function function_1ad74e6445aa1e5c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    /#
        thread function_8af5d8ae26494eae();
    #/
    
    wait self.travel_time - 1;
    self setscriptablepartstate( "audio_exit", "on", 0 );
    wait 1;
    self setscriptablepartstate( "audio_loop", "off", 0 );
    
    if ( isdefined( self.minimapid ) )
    {
        objidpoolmanager::returnobjectiveid( self.minimapid );
    }
    
    if ( isdefined( self.chassis ) )
    {
        self.chassis delete();
    }
    
    self notify( #"hash_c06f0cbf51c2eaf" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ob_supply_drops
// Params 5
// Checksum 0x253b1d15, Offset: 0xfc7
// Size: 0xe6
function function_57f2b4bcacf480b7( var_35c9cce3da4bd6bc, drop_count, crate_options, activity_instance, crate_data )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_b175584f3ba614ab = drop_count;
    
    for ( i = 0; i < var_35c9cce3da4bd6bc.size ; i++ )
    {
        while ( distance2dsquared( self.origin, var_35c9cce3da4bd6bc[ i ].origin ) > 10000 )
        {
            waitframe();
        }
        
        if ( var_35c9cce3da4bd6bc[ i ].selected_drop_point )
        {
            /#
                iprintlnbold( "<dev string:xf3>" + i + "<dev string:x112>" + var_35c9cce3da4bd6bc[ i ].origin + "<dev string:x123>" );
            #/
            
            thread function_8c77e13424abba61( var_35c9cce3da4bd6bc[ i ], crate_options, activity_instance, crate_data );
        }
    }
    
    calloutmarkerping::function_608710c894185549();
}

// Namespace ob_supply_drops
// Params 3, eflags: 0x4
// Checksum 0x350ff534, Offset: 0x10b5
// Size: 0x1b1
function private function_95476b3a80751086( var_5290e343e7cabade, var_5317be062b4be285, precision_drop )
{
    plane_heading = isdefined( var_5317be062b4be285 ) ? function_63a2ef74ebcc6413( var_5317be062b4be285 ) : randomfloatrange( 0, 360 );
    plane_altitude = namespace_cf9a4f547edbca10::function_8412c1d7c8896af1( "supply_drop" );
    r = 50000;
    to_edge = ( r * cos( plane_heading ), r * sin( plane_heading ), 0 );
    var_5290e343e7cabade = ( var_5290e343e7cabade[ 0 ], var_5290e343e7cabade[ 1 ], plane_altitude );
    start_point = to_edge + var_5290e343e7cabade;
    end_point = var_5290e343e7cabade - to_edge;
    path_orientation = vectornormalize( end_point - start_point );
    route_distance = distance( end_point, start_point );
    plane_path_struct = spawnstruct();
    plane_path_struct.start_point = start_point;
    plane_path_struct.end_point = end_point;
    plane_path_struct.plane_heading = plane_heading;
    plane_path_struct.orientation = vectortoangles( path_orientation );
    plane_path_struct.var_5290e343e7cabade = var_5290e343e7cabade;
    plane_path_struct.route_distance = route_distance;
    
    if ( precision_drop )
    {
        var_674903a9ec146334 = spawnstruct();
        var_674903a9ec146334.origin = var_5290e343e7cabade + ( 0, 0, -50 );
        var_674903a9ec146334.ground_pos = utility::groundpos( var_5290e343e7cabade );
        supply_drop_locations = [ var_674903a9ec146334 ];
    }
    else
    {
        supply_drop_locations = function_68fb5d97f2af6e00( plane_path_struct );
    }
    
    plane_path_struct.supply_drop_locations = supply_drop_locations;
    
    /#
        level thread function_5c35af8a184bcc5a( plane_path_struct, r );
    #/
    
    return plane_path_struct;
}

// Namespace ob_supply_drops
// Params 1, eflags: 0x4
// Checksum 0x2d0a1204, Offset: 0x126f
// Size: 0x134
function private function_68fb5d97f2af6e00( plane_path_struct )
{
    supply_drop_locations = [];
    drop_density = max( 10, 4 );
    var_9b075df662b141d0 = plane_path_struct.route_distance / drop_density;
    to_next_node = ( var_9b075df662b141d0 * cos( plane_path_struct.plane_heading ), var_9b075df662b141d0 * sin( plane_path_struct.plane_heading ), 0 );
    
    for ( i = 0; i < drop_density ; i++ )
    {
        pos = plane_path_struct.start_point - to_next_node * ( i + 1 );
        
        if ( i == drop_density - 1 )
        {
            break;
        }
        
        ground_pos = utility::groundpos( pos );
        validated_pos = undefined;
        
        if ( function_c9815a1ddf6edf42( pos, ground_pos ) )
        {
            var_674903a9ec146334 = spawnstruct();
            var_674903a9ec146334.origin = pos + ( 0, 0, -50 );
            var_674903a9ec146334.ground_pos = ground_pos;
            validated_pos = 1;
            supply_drop_locations[ supply_drop_locations.size ] = var_674903a9ec146334;
        }
        
        /#
            level thread function_5118fbfd021caa8f( pos, ground_pos, validated_pos, i );
        #/
    }
    
    return supply_drop_locations;
}

// Namespace ob_supply_drops
// Params 2, eflags: 0x4
// Checksum 0x630b2414, Offset: 0x13ac
// Size: 0x94, Type: bool
function private function_c9815a1ddf6edf42( starttrace, ground_pos )
{
    endtrace = starttrace - ( 0, 0, 30000 );
    ignorelist = [];
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    trace = trace::ray_trace( starttrace, endtrace, ignorelist, contents );
    
    if ( !isdefined( trace ) || trace[ "hittype" ] == "hittype_none" )
    {
        return false;
    }
    
    return !outofbounds::ispointinoutofbounds( ground_pos );
}

// Namespace ob_supply_drops
// Params 1, eflags: 0x4
// Checksum 0xb1c10c21, Offset: 0x1449
// Size: 0x9b
function private ob_supply_drops_spawn_plane( plane_path_struct )
{
    plane_model = "xcomp_veh_sat_mil_air_cargo_wc_supply_drop";
    plane = spawn( "script_model", plane_path_struct.start_point );
    plane.angles = plane_path_struct.orientation;
    plane setmodel( plane_model );
    plane setcandamage( 0 );
    plane.maxhealth = 100000;
    plane.health = plane.maxhealth;
    plane.cruising_speed = 5000;
    return plane;
}

// Namespace ob_supply_drops
// Params 0, eflags: 0x4
// Checksum 0x729f6b77, Offset: 0x14ed
// Size: 0x1b
function private function_2ae23272391c29a7()
{
    self setscriptablepartstate( "dmz_audio_explosion", "on" );
    wait 1;
    self delete();
}

// Namespace ob_supply_drops
// Params 0
// Checksum 0x584ac2b2, Offset: 0x1510
// Size: 0x17f
function ob_supply_drops_init()
{
    leveldata = airdrop::getleveldata( "sat_ob_supply_drops" );
    leveldata.capturestring = &"sat_ob_activities/activity_supply_drop_capture";
    
    if ( getdvarint( @"ob_codmas", 0 ) || getdvarint( @"hash_cccd37bc48ebd5b1", 0 ) )
    {
        leveldata.basemodel = "sat_ava_storage_lootbox_01_fxanim_ob_supply_codmas";
    }
    else
    {
        leveldata.basemodel = "sat_ava_storage_lootbox_01_fxanim_ob_supply";
    }
    
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.minimapicon = "ui_map_icon_jugg_drop";
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.friendlyuseonly = 0;
    leveldata.ownerusetime = 2.5;
    leveldata.otherusetime = 2.5;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.activatecallback = &function_fb6c3479f030388c;
    leveldata.capturecallback = &function_485a75456c8c1ba7;
    leveldata.destroycallback = &function_ac7efea98467d107;
    leveldata.destroyoncapture = 0;
    leveldata.isdropcrate = 1;
    leveldata.nevertimeout = 1;
    leveldata.objectid = "override_locks";
    namespace_cf9a4f547edbca10::function_e8d02650e81ea5b8( "supply_drop", 12000 );
}

// Namespace ob_supply_drops
// Params 1
// Checksum 0x30cf72c8, Offset: 0x1697
// Size: 0x16
function function_fb6c3479f030388c( isfirstactivation )
{
    logstring( "activate" );
}

// Namespace ob_supply_drops
// Params 1
// Checksum 0x4846abbe, Offset: 0x16b5
// Size: 0x145
function function_485a75456c8c1ba7( player )
{
    logstring( "capture" );
    self notify( #"crate_opened" );
    calloutmarkerping::function_608710c894185549();
    
    if ( isdefined( self.smoke_signal_scriptable ) )
    {
        self.smoke_signal_scriptable setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smoke_signal_scriptable freescriptable();
    }
    
    leak_percentage = self.crate_options.var_7ea9cd2acef9a15a ?? 33;
    
    if ( !self.crate_options.var_53ffcf10b13ba246 && ( utility::percent_chance( leak_percentage ) || getdvarint( @"hash_c8b931b845f6f9df", 0 ) ) )
    {
        if ( !utility::ispointinwater( self.origin ) )
        {
            thread function_4b364c2364820a();
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x126>" );
            #/
        }
    }
    
    if ( isdefined( self.crate_options.var_ef6f80c6b8c978b0 ) )
    {
        assert( isfunction( self.crate_options.var_ef6f80c6b8c978b0 ), "<dev string:x14f>" );
        self thread [[ self.crate_options.var_ef6f80c6b8c978b0 ]]( player );
    }
    
    thread function_c415d6e581079b65( player );
}

// Namespace ob_supply_drops
// Params 1
// Checksum 0xed500f2d, Offset: 0x1802
// Size: 0x16
function function_ac7efea98467d107( immediate )
{
    logstring( "destroy" );
}

// Namespace ob_supply_drops
// Params 3, eflags: 0x4
// Checksum 0xa2822c2b, Offset: 0x1820
// Size: 0xe0
function private function_7fdc6b2704e00d78( item, bundle, spawnoptions )
{
    if ( bundle.subtype != "item_select" )
    {
        return;
    }
    
    item.var_3d5f9175ae9c72f4 = 1;
    
    if ( self.crate_options.var_373694f1e81b1b15 )
    {
        item function_7653c765b6c7b815();
        
        foreach ( player in self.crate_options.var_373694f1e81b1b15 )
        {
            item enablescriptableplayeruse( player );
        }
    }
}

// Namespace ob_supply_drops
// Params 1
// Checksum 0x61f4d278, Offset: 0x1908
// Size: 0x1e2
function function_c415d6e581079b65( player )
{
    self notify( #"crate_opened" );
    self notify( #"hash_31db7c73df6bc319" );
    airdrop::makecrateunusable();
    
    if ( self.crate_options.scriptkey )
    {
        var_6d008e54234e07b0 = function_4977dfa492fb9f8( self, player );
        var_f67995529827f79 = common_cache::function_525b81b5b46043f7( self.crate_options.scriptkey, var_6d008e54234e07b0 );
        spawn_list_name = var_f67995529827f79.spawnlistname;
        spawn_item_count = var_f67995529827f79.spawncount;
    }
    else
    {
        spawn_list_name = self.crate_options.loot_item_list;
        spawn_item_count = self.crate_options.loot_item_count;
    }
    
    items = common_item::items_selectfromlist( spawn_list_name, spawn_item_count );
    
    foreach ( item in items )
    {
        common_cache::cache_additem( self, item, undefined, 0, player );
    }
    
    if ( level.var_9afcf1fa7009bc81 )
    {
        if ( self getscriptableparthasstate( #"ob_supply_drop", #"fully_opening_unusable" ) )
        {
            self setscriptablepartstate( #"ob_supply_drop", #"fully_opening_unusable" );
        }
    }
    
    wait 0.5;
    cache_scriptable = self getlinkedscriptableinstance();
    self.type = cache_scriptable.type;
    self.var_9441016ace29d51d = &function_7fdc6b2704e00d78;
    common_cache::opencache( self, player );
    thread function_ef1b5c1ce4991a7c( 180 );
}

// Namespace ob_supply_drops
// Params 2, eflags: 0x4
// Checksum 0x27633c2c, Offset: 0x1af2
// Size: 0x7a
function private function_4977dfa492fb9f8( cache, player )
{
    new_zone_def = undefined;
    
    if ( utility::issharedfuncdefined( #"ob_loot", #"hash_b5deae02f491843f" ) )
    {
        new_zone_def = utility::callsharedfunc( #"ob_loot", #"hash_b5deae02f491843f", player, cache.origin );
    }
    else
    {
        new_zone_def = ob_activity_utility::function_11635f111a5a5ae3( self.origin );
    }
    
    return new_zone_def;
}

// Namespace ob_supply_drops
// Params 4, eflags: 0x4
// Checksum 0xa6149a40, Offset: 0x1b75
// Size: 0x1b9
function private function_8c77e13424abba61( var_e71a0fd780540551, crate_options, activity_instance, crate_data )
{
    drop_loot = "sat_ob_supply_drops";
    
    if ( crate_options.drop_loot )
    {
        drop_loot = crate_options.drop_loot;
    }
    
    crate = airdrop_crate( var_e71a0fd780540551.origin, var_e71a0fd780540551.ground_pos, ( 0, randomfloat( 360 ), 0 ), drop_loot, crate_data );
    crate.nevertimeout = 1;
    
    if ( isdefined( crate_options ) )
    {
        crate.crate_options = crate_options;
    }
    
    if ( isdefined( activity_instance ) )
    {
        crate.activity_instance = activity_instance;
        
        if ( !isdefined( activity_instance.supply_drop_crates ) )
        {
            activity_instance.supply_drop_crates = [];
        }
        
        activity_instance.supply_drop_crates[ activity_instance.supply_drop_crates.size ] = crate;
    }
    
    if ( crate_options.usetimeoverride )
    {
        crate.usetimeoverride = crate_options.usetimeoverride;
    }
    
    if ( isdefined( activity_instance ) )
    {
        activity_instance notify( #"ob_supply_drop_crate_dropped", crate );
    }
    
    self.var_b175584f3ba614ab--;
    
    foreach ( player in self.var_d26c6dba74c8a179 )
    {
        player function_446ff087bbc41922( crate, crate_options.var_20a60ad976cde992 );
    }
}

// Namespace ob_supply_drops
// Params 1
// Checksum 0x53f9e31d, Offset: 0x1d36
// Size: 0x71
function function_ef1b5c1ce4991a7c( var_9522501df385679d )
{
    self notify( #"hash_4dfe0365bfdd6c68" );
    self endon( #"hash_4dfe0365bfdd6c68" );
    self endon( #"entitydeleted" );
    wait var_9522501df385679d;
    deletiondelay = level.framedurationseconds;
    self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
    airdrop::deletecrate( deletiondelay );
}

// Namespace ob_supply_drops
// Params 0, eflags: 0x4
// Checksum 0x60922e5b, Offset: 0x1daf
// Size: 0xc3
function private function_4b364c2364820a()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self ) )
    {
        self.cradle_leak = 1;
    }
    
    cradle_gas_struct = spawnstruct();
    cradle_gas_struct.origin = self.origin;
    cradle_gas_struct.angles = self.angles;
    ob_cradle_gas_circle::function_715467b4b7feb05a( cradle_gas_struct, 0, undefined, 1 );
    requestid = ai_spawn_director::spawn_request( %"hash_798367700dbacfd8", self.origin, 500, 1, 1, 0, 0 );
    
    if ( self.activity_instance )
    {
        ai_spawn_director::spawn_request_associate( requestid, self.activity_instance );
    }
    
    ai_spawn_director::function_a49c35b72d6b6fea( requestid, &function_a9ad18f3657bc746, [ cradle_gas_struct ] );
}

// Namespace ob_supply_drops
// Params 3
// Checksum 0x3bb63820, Offset: 0x1e7a
// Size: 0x36
function function_a9ad18f3657bc746( request_id, user_data, data )
{
    cradle_gas_struct = user_data[ 0 ];
    ob_cradle_gas_circle::function_ad1c37731b23fb82( cradle_gas_struct );
}

#using_animtree( "script_model" );

// Namespace ob_supply_drops
// Params 0
// Checksum 0x4933a687, Offset: 0x1eb8
// Size: 0xbc
function function_7f3ca8cb86b04037()
{
    level.scr_anim[ "care_package" ][ "ob_supply_drop_high" ] = %t10_killstreak_mp_carepackage_ckpg_flyin_10500;
    level.scr_anim[ "care_package" ][ "ob_supply_drop_med" ] = %t10_killstreak_mp_carepackage_ckpg_flyin_7500;
    level.scr_anim[ "care_package" ][ "ob_supply_drop_low" ] = %t10_killstreak_mp_carepackage_ckpg_flyin_3000;
    level.scr_anim[ "care_package_chute" ][ "ob_supply_drop_high" ] = %t10_killstreak_carepackage_parachute_flyin_10500;
    level.scr_anim[ "care_package_chute" ][ "ob_supply_drop_med" ] = %t10_killstreak_mp_carepackage_parachute_flyin_7500;
    level.scr_anim[ "care_package_chute" ][ "ob_supply_drop_low" ] = %t10_killstreak_mp_carepackage_parachute_flyin_3000;
}

// Namespace ob_supply_drops
// Params 5
// Checksum 0x60361e20, Offset: 0x1f7c
// Size: 0x306
function airdrop_crate( drop_pos, drop_dest, drop_angles, drop_loot_id, crate_data )
{
    release_dest = drop_dest + ( 0, 0, 1000 );
    crate = airdrop::createcrate( undefined, undefined, drop_loot_id, drop_pos, ( 0, 0, 0 ), drop_dest, undefined, 0, crate_data );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    crate.smoke_signal_scriptable = spawnscriptable( %"ob_supply_drop_smoke_signal", drop_dest, drop_angles );
    crate.smoke_signal_scriptable setscriptablepartstate( #"smoke_signal", #"on", 0 );
    crate.skipminimapicon = 1;
    crate.disallowheadiconid = 1;
    
    if ( release_dest[ 2 ] < drop_pos[ 2 ] )
    {
        var_6acc7b81b5df3dd9 = undefined;
        var_bd572806bee214a6 = distance( drop_pos, release_dest );
        
        if ( var_bd572806bee214a6 >= 10500 )
        {
            var_6acc7b81b5df3dd9 = "ob_supply_drop_high";
        }
        else if ( var_bd572806bee214a6 >= 7500 )
        {
            var_6acc7b81b5df3dd9 = "ob_supply_drop_med";
        }
        else if ( var_bd572806bee214a6 >= 3000 )
        {
            var_6acc7b81b5df3dd9 = "ob_supply_drop_low";
        }
        
        if ( isdefined( var_6acc7b81b5df3dd9 ) )
        {
            anim_zoffset = 1000;
            crate_offset = rotatevector( ( -4, 0, 0 ), drop_angles );
            scene_node_crate = spawn( "script_model", release_dest + ( 0, 0, anim_zoffset ) + crate_offset );
            scene_node_crate.angles = drop_angles;
            scene_node_crate setmodel( "tag_origin" );
            scene_node_chute = spawn( "script_model", release_dest + ( 0, 0, anim_zoffset ) );
            scene_node_chute.angles = drop_angles;
            scene_node_chute setmodel( "tag_origin" );
            crate.animname = "care_package";
            crate.dropanim = level.scr_anim[ crate.animname ][ var_6acc7b81b5df3dd9 ];
            crate.animlength = getanimlength( crate.dropanim );
            crate animation::setanimtree();
            chute = spawn( "script_model", crate.origin );
            chute.angles = crate.angles;
            chute.animname = "care_package_chute";
            chute.dropanim = level.scr_anim[ chute.animname ][ var_6acc7b81b5df3dd9 ];
            chute.animlength = getanimlength( chute.dropanim );
            chute setmodel( "sat_ava_decor_parachute_guild" );
            chute animation::setanimtree();
            scene_node_crate thread animation::anim_single_solo( crate, var_6acc7b81b5df3dd9 );
            scene_node_chute thread animation::anim_single_solo( chute, var_6acc7b81b5df3dd9 );
            crate thread airdrop::watchbrc130aidropcrateanimend();
            chute thread airdrop::watchbrc130airdropchuteanimend( scene_node_chute );
        }
        else
        {
            crate airdrop::cratephysicson();
        }
    }
    else
    {
        crate airdrop::cratephysicson();
    }
    
    return crate;
}

/#

    // Namespace ob_supply_drops
    // Params 0
    // Checksum 0xd113ec6, Offset: 0x228b
    // Size: 0x103, Type: dev
    function ob_supply_drops_debug()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_ob_supply_drops_do", 0 ) )
            {
                setdvar( @"scr_ob_supply_drops_do", 0 );
                pos = level.players[ 0 ].origin + vectornormalize( anglestoforward( level.players[ 0 ].angles ) ) * 100;
                var_5317be062b4be285 = level.players[ 0 ].angles[ 1 ];
                crateoptions = {};
                crateoptions.scriptkey = "<dev string:x15e>";
                thread function_989989bf968b8c87( pos, var_5317be062b4be285, 1, crateoptions, undefined, level.players );
            }
            
            if ( getdvarint( @"hash_45ee098a587f6f17", 0 ) )
            {
                setdvar( @"hash_45ee098a587f6f17", 0 );
                level notify( #"hash_c63b0e6d65853182" );
            }
            
            wait 0.2;
        }
    }

    // Namespace ob_supply_drops
    // Params 2
    // Checksum 0x252d29d8, Offset: 0x2396
    // Size: 0xab, Type: dev
    function function_5c35af8a184bcc5a( plane_path_struct, map_radius )
    {
        level endon( #"game_ended" );
        level endon( #"hash_c63b0e6d65853182" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c2b45c3b00f0a452", 0 ) )
            {
                line( plane_path_struct.start_point, plane_path_struct.end_point, ( 1, 1, 1 ), 1, 0, level.frameduration );
                utility::draw_circle( plane_path_struct.var_5290e343e7cabade, map_radius, ( 1, 1, 1 ), 1, 0, level.frameduration );
            }
            
            waitframe();
        }
    }

    // Namespace ob_supply_drops
    // Params 0
    // Checksum 0x4b464184, Offset: 0x2449
    // Size: 0x5e, Type: dev
    function function_8af5d8ae26494eae()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"hash_c06f0cbf51c2eaf" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_94ca1791a58ba473", 0 ) )
            {
                setdvar( @"hash_94ca1791a58ba473", 0 );
                function_2ae23272391c29a7();
                break;
            }
            
            wait 1;
        }
    }

    // Namespace ob_supply_drops
    // Params 4
    // Checksum 0xeb3c9d94, Offset: 0x24af
    // Size: 0xda, Type: dev
    function function_5118fbfd021caa8f( start_pos, ground_pos, validated_pos, pos_index )
    {
        level endon( #"game_ended" );
        level endon( #"hash_c63b0e6d65853182" );
        var_2de83b91ebc99054 = validated_pos ? ( 0, 1, 0 ) : ( 1, 0, 0 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_ob_supply_drops_draw_location", 0 ) )
            {
                line( ground_pos, start_pos, var_2de83b91ebc99054, 1, 0, level.frameduration );
                sphere( ground_pos, 50, var_2de83b91ebc99054, 0, level.frameduration );
                print3d( ground_pos, "<dev string:x171>" + pos_index + "<dev string:x182>", var_2de83b91ebc99054, 1, 2, level.frameduration, 1 );
            }
            
            waitframe();
        }
    }

#/
