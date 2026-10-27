// scripts\autotests\mp\autotests_utility_mit.gsc  (hash_2228449c483f09ab.gscc) (size: 10080 Bytes / 0x2760 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x368382a1 (914588321)
// size ...... 10080 (0x2760)
// includes .. 7   (offset: 0x25cc)
// strings ... 23  (offset: 0x2604)
// dev strs .. 1   (offset: 0x2754)
// exports ... 34  (offset: 0x17dc)
// cseg ...... 0x1ef + 0x15ed (0x17dc)
// imports ... 71  (offset: 0x1d2c)
// animtree1 . 0   (offset: 0x2760)
// animtree2 . 0   (offset: 0x2760)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_telemetry;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\mp\bots\bots_util;
#using scripts\mp\flags;

#namespace autotests_utility_mit;

// Namespace autotests_utility_mit
// Params 3
// Checksum 0x616b237, Offset: 0x20d
// Size: 0x4c
function function_45effcfcc139e74a( var_226234d9282b67f1, var_4d21cea83a72feb0, parameterize_function )
{
    autotests::register_tests( var_226234d9282b67f1, #"test", var_4d21cea83a72feb0, &mit_setup, &mit_cleanup, parameterize_function );
    autotests::function_8037d0283ed66d77( var_226234d9282b67f1, &function_e86bb091569f75da );
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0x2e72a767, Offset: 0x261
// Size: 0x66, Type: bool
function function_e86bb091569f75da( parsed_params )
{
    var_b9f6eca1adc6e9fa = int( parsed_params.named[ "index" ] ?? -1 );
    
    if ( var_b9f6eca1adc6e9fa < 0 )
    {
        return false;
    }
    
    found_index = function_35af25b427c6e001();
    
    if ( var_b9f6eca1adc6e9fa != found_index )
    {
        setdvar( @"hash_2e6e24fa707c7726", var_b9f6eca1adc6e9fa );
        return true;
    }
    
    return false;
}

// Namespace autotests_utility_mit
// Params 0
// Checksum 0xd97e827, Offset: 0x2d0
// Size: 0x43
function function_35af25b427c6e001()
{
    if ( hasomnvar( o"ui_dev_action_park_combo_index" ) )
    {
        found_index = getomnvar( o"ui_dev_action_park_combo_index" );
    }
    
    if ( !isdefined( found_index ) )
    {
        found_index = getdvarint( @"hash_2e6e24fa707c7726", -1 );
    }
    
    return found_index;
}

// Namespace autotests_utility_mit
// Params 2
// Checksum 0x4606b22f, Offset: 0x31c
// Size: 0x137
function function_662871d9ef7d6a6c( selected_label, var_5a77e25b1afd78df )
{
    found_volume = undefined;
    
    if ( true )
    {
        minimap_volumes = getnoentvolumearray( "noent_volume_minimap", #classname );
        
        foreach ( minimap_volume in minimap_volumes )
        {
            if ( minimap_volume.script_noteworthy == selected_label )
            {
                found_volume = minimap_volume;
                level.script_noteworthy = minimap_volume.script_noteworthy;
                level.script_parameters = minimap_volume.script_parameters;
                level.var_c9730d48ae5087bf = minimap_volume.origin[ 2 ];
                break;
            }
        }
    }
    
    if ( found_volume )
    {
        bounds = function_a1ad2fe6de62f6a( found_volume );
        return [[ var_5a77e25b1afd78df ]]( bounds.min, bounds.max );
    }
    
    return [[ var_5a77e25b1afd78df ]]();
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0xaaae4b31, Offset: 0x45c
// Size: 0x43
function function_a1ad2fe6de62f6a( volume )
{
    halfsize = volume getboundshalfsize();
    InvalidOpCode( 0x83, volume.origin[ 0 ] + halfsize[ 0 ], volume.origin[ 1 ] + halfsize[ 1 ], {} );
    // Unknown operator ( 0x83, t11, Black Ops 7 )
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0xc01d874b, Offset: 0x4e0
// Size: 0x31
function function_dc2e211727d1d124( origin )
{
    return int( origin[ 0 ] ) + "_" + int( origin[ 1 ] ) + "_" + int( origin[ 2 ] );
}

// Namespace autotests_utility_mit
// Params 0
// Checksum 0x5de3e3cf, Offset: 0x51a
// Size: 0x66
function get_autopilot()
{
    player = autotests_utility_player::get_player();
    
    if ( !isautopilot( player ) )
    {
        player function_ffb0711adb6d8d0d();
        starttime = gettime();
        
        while ( !isautopilot( player ) )
        {
            waitframe();
            
            if ( gettime() - starttime > 1000 )
            {
                autotests::function_d84657f448aaeef6( "Player did not enter autopilot mode in 1 second.", 0, "scripts/autotests/mp/autotests_utility_mit.gsc", 108 );
                return;
            }
        }
    }
    
    return player;
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0x86cfa946, Offset: 0x589
// Size: 0x5a
function validatevector( value )
{
    if ( !isdefined( value ) )
    {
        return [ -1, -1, -1 ];
    }
    
    return [ value[ 0 ] * 1, value[ 1 ] * 1, value[ 2 ] * 1 ];
}

// Namespace autotests_utility_mit
// Params 6
// Checksum 0xb93940ef, Offset: 0x5ec
// Size: 0x149
function send_spatial_event( eventtype, file, result, positions, var_210fff1f5e19cace, metadefs )
{
    wkt = autotests_telemetry::function_464ddcba1fc9adbb( positions );
    geo_meta = [];
    
    for ( i = 0; i < var_210fff1f5e19cace.size ; i++ )
    {
        geo_meta[ i ] = spawnstruct();
        geo_meta[ i ].type = var_210fff1f5e19cace[ i ].type;
        geo_meta[ i ].description = var_210fff1f5e19cace[ i ].description;
    }
    
    meta = [];
    
    for ( i = 0; i < metadefs.size ; i++ )
    {
        meta[ i ] = spawnstruct();
        meta[ i ].key = metadefs[ i ].key;
        meta[ i ].value = metadefs[ i ].value;
    }
    
    event = autotests_telemetry::spatial_event_create( wkt, autotests_telemetry::build_geometry_metadata_json( geo_meta ), eventtype, file, result, autotests_telemetry::function_f65481dc1156878e( meta ) );
    autotests_telemetry::spatial_event_send( event, "spatial_events", undefined, 0 );
}

// Namespace autotests_utility_mit
// Params 1, eflags: 0x4
// Checksum 0xd7172a09, Offset: 0x73d
// Size: 0x8c
function private function_85eb3b03aba8e321( player )
{
    key = "" + player getentitynumber();
    
    if ( !isdefined( level.autotests.test_runtime.var_28d13cba9347077c[ key ] ) )
    {
        level.autotests.test_runtime.var_28d13cba9347077c[ key ] = spawnstruct();
    }
    
    return level.autotests.test_runtime.var_28d13cba9347077c[ key ];
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0x72767d92, Offset: 0x7d2
// Size: 0x54
function function_e017acd43781f5a3( player )
{
    w = function_85eb3b03aba8e321( player );
    w._positions = [];
    w._geo_meta = [];
    w._meta = [];
    w.var_94052c835737bd85 = 0;
}

// Namespace autotests_utility_mit
// Params 4
// Checksum 0xa83f2e20, Offset: 0x82e
// Size: 0xa1
function function_51e9e46c136ac9c3( player, name, description, origin )
{
    w = function_85eb3b03aba8e321( player );
    w._positions[ w._positions.size ] = validatevector( origin );
    geo = spawnstruct();
    geo.type = name;
    geo.description = description;
    w._geo_meta[ w._geo_meta.size ] = geo;
}

// Namespace autotests_utility_mit
// Params 3
// Checksum 0x699be771, Offset: 0x8d7
// Size: 0x7f
function function_fc203072b5b37c65( player, key, value )
{
    w = function_85eb3b03aba8e321( player );
    meta = spawnstruct();
    meta.key = key;
    meta.value = value ?? "";
    w._meta[ w._meta.size ] = meta;
}

// Namespace autotests_utility_mit
// Params 4
// Checksum 0x13bc6cab, Offset: 0x95e
// Size: 0xeb
function function_3ccb8044cdb16827( player, eventtype, file, result )
{
    w = function_85eb3b03aba8e321( player );
    
    if ( w.var_94052c835737bd85 )
    {
        return;
    }
    
    positions = w._positions ?? [];
    geo_meta = w._geo_meta ?? [];
    meta = w._meta ?? [];
    wkt = autotests_telemetry::function_464ddcba1fc9adbb( positions );
    event = autotests_telemetry::spatial_event_create( wkt, autotests_telemetry::build_geometry_metadata_json( geo_meta ), eventtype, file, result, autotests_telemetry::function_f65481dc1156878e( meta ) );
    autotests_telemetry::spatial_event_send( event, "spatial_events", undefined, 0 );
    w.var_94052c835737bd85 = 1;
}

// Namespace autotests_utility_mit
// Params 1, eflags: 0x4
// Checksum 0x90c24ee4, Offset: 0xa51
// Size: 0xfc
function private function_62018041898ad91( assetid )
{
    latest = autotests::function_47d83c11a21b624e();
    
    if ( !isdefined( latest ) || !latest.size )
    {
        return 0;
    }
    
    worst = 0;
    found = 0;
    
    foreach ( tcr in latest )
    {
        if ( tcr.asset != assetid )
        {
            continue;
        }
        
        found = 1;
        
        if ( tcr.result_int == 6 )
        {
            return 6;
        }
        
        if ( !autotests::function_5a030dd4450c1448( tcr.result_int ) )
        {
            worst = 1;
        }
    }
    
    return found ? worst : 0;
}

// Namespace autotests_utility_mit
// Params 2, eflags: 0x4
// Checksum 0x8fe108b2, Offset: 0xb56
// Size: 0x75
function private function_a67501b11baacf96( idstring, player )
{
    function_e017acd43781f5a3( player );
    autotests::set_current_asset_name( idstring );
    function_fc203072b5b37c65( player, "asset_id", idstring );
    function_fc203072b5b37c65( player, "script_noteworthy", level.script_noteworthy ?? "" );
    function_fc203072b5b37c65( player, "script_parameters", level.script_parameters ?? "" );
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0xbf625a2b, Offset: 0xbd3
// Size: 0x5d
function build_lookup( config )
{
    found_index = function_35af25b427c6e001();
    
    if ( found_index != -1 )
    {
        selected_label = getxhash( "multi_arena_map_" + found_index );
        return function_662871d9ef7d6a6c( selected_label, config.var_4182163638fd37ed );
    }
    
    return [[ config.var_4182163638fd37ed ]]();
}

// Namespace autotests_utility_mit
// Params 2
// Checksum 0x71b99c1b, Offset: 0xc39
// Size: 0xb4
function function_b9d5c5769852731d( parameters, paramsuffix )
{
    if ( !isdefined( parameters ) || parameters.size == 0 || paramsuffix == "" )
    {
        return parameters;
    }
    
    result = [];
    
    foreach ( parameter in parameters )
    {
        result[ result.size ] = parameter + paramsuffix;
    }
    
    return result;
}

// Namespace autotests_utility_mit
// Params 2
// Checksum 0xe38b5750, Offset: 0xcf6
// Size: 0x52
function function_b7fe9eed6b7b2a72( test_setup, config )
{
    parsed = test_setup.var_875fc462a0bca171;
    base = function_4a2e79ad8e28bece( test_setup, config );
    return function_b9d5c5769852731d( base, parsed.paramsuffix );
}

// Namespace autotests_utility_mit
// Params 2
// Checksum 0x35ef43f8, Offset: 0xd51
// Size: 0x6f
function function_4a2e79ad8e28bece( test_setup, config )
{
    level.mit_lookup = undefined;
    parsed = test_setup.var_875fc462a0bca171;
    range = function_49ecc308f2226722( parsed );
    
    if ( isdefined( range ) )
    {
        return range;
    }
    
    level.mit_lookup = build_lookup( config );
    return getarraykeys( level.mit_lookup );
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0x7fe7d2f5, Offset: 0xdc9
// Size: 0xb9
function function_49ecc308f2226722( parsed )
{
    if ( parsed.positional.size == 0 )
    {
        return;
    }
    
    if ( parsed.positional.size == 2 )
    {
        lower = int( parsed.positional[ 0 ] );
        upper = int( parsed.positional[ 1 ] );
        result = [];
        
        for ( i = lower; i <= upper ; i++ )
        {
            result[ result.size ] = "index=" + i;
        }
        
        return result;
    }
    
    assertmsg( "<dev string:x24>" + parsed.positional.size );
    return [];
}

// Namespace autotests_utility_mit
// Params 1, eflags: 0x4
// Checksum 0xbcff9477, Offset: 0xe8b
// Size: 0xcc
function private function_4ef5978f0b0a72be( parsed_params )
{
    arenaindex = int( parsed_params.named[ "index" ] ?? -1 );
    botcount = int( parsed_params.named[ "bots" ] ?? 1 );
    var_c3014a1a06716dfe = parsed_params.positional.size > 0;
    
    if ( botcount > 1 )
    {
        mode = "queue";
    }
    else if ( !var_c3014a1a06716dfe )
    {
        mode = "sweep";
    }
    else
    {
        mode = "single";
    }
    
    return { #params:parsed_params, #botcount:botcount, #arenaindex:arenaindex, #mode:mode };
}

// Namespace autotests_utility_mit
// Params 0
// Checksum 0xd85df6a6, Offset: 0xf60
// Size: 0xbd, Type: bool
function mit_setup()
{
    function_3abe1f9532a7887b( "set cg_drawAutotestResultPanel 0" );
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    autotests::set_dvar( @"hash_aa5c2e28a06af46", 2 );
    self._mit_mode = function_4ef5978f0b0a72be( self.parsed_params );
    
    if ( self._mit_mode.mode == "sweep" || self._mit_mode.mode == "queue" )
    {
        autotests::set_dvar( @"hash_9e49766c62b3af0d", 7200 );
        autotests::set_dvar( @"hash_d391034358a8f258", 60 );
        self.var_8b1ba281d4d11a1f = &function_1c38128f794d88c1;
    }
    
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace autotests_utility_mit
// Params 0
// Checksum 0x5cc12ecf, Offset: 0x1026
// Size: 0x4a
function mit_cleanup()
{
    autotests_utility::cleanup();
    player = autotests_utility_player::get_player();
    player playerexitautopilotmode();
    level.mit_lookup = undefined;
    self._mit_mode = undefined;
    self.var_8b1ba281d4d11a1f = undefined;
    function_3abe1f9532a7887b( "set cg_drawAutotestResultPanel 1" );
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0x5bed5cf9, Offset: 0x1078
// Size: 0x20d
function function_a10f1915e22ab0d4( config )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Has parameter?", self.parameters.size >= 1, "scripts/autotests/mp/autotests_utility_mit.gsc", 450 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    m = function_4ef5978f0b0a72be( self.parsed_params );
    
    if ( m.arenaindex >= 0 )
    {
        flags::function_2f3408423ccc9b2e( "prematch_done" );
    }
    
    if ( m.mode == "sweep" || m.mode == "queue" )
    {
        level.mit_lookup = build_lookup( config );
        
        if ( m.mode == "queue" )
        {
            player = get_autopilot();
            workers = [ player ];
            
            for ( i = 1; i < m.botcount ; i++ )
            {
                workers[ workers.size ] = autotests_utility_bot::function_b04d08d80ae08dcb( player, undefined );
            }
            
            function_cb6b3721b0ea598e( config, workers );
            
            for ( i = 1; i < workers.size ; i++ )
            {
                workers[ i ] autotests_utility_bot::cleanup();
            }
        }
        else
        {
            run_all_tests( config, get_autopilot() );
        }
        
        self.var_28d13cba9347077c = undefined;
        return;
    }
    
    if ( !isdefined( level.mit_lookup ) )
    {
        level.mit_lookup = build_lookup( config );
    }
    
    idstring = self.parsed_params.positional[ 0 ];
    player = get_autopilot();
    function_a67501b11baacf96( idstring, player );
    [[ config.var_db86da194d47f8f2 ]]( player, idstring );
    result = function_62018041898ad91( idstring );
    function_3ccb8044cdb16827( player, config.var_6b7f0911cb91054a, config.sourcefile, result );
    self.var_28d13cba9347077c = undefined;
}

// Namespace autotests_utility_mit
// Params 1, eflags: 0x4
// Checksum 0xc414d9c2, Offset: 0x128d
// Size: 0x2f
function private function_1c38128f794d88c1( test_case_result )
{
    autotests::function_8829c20450ba3a5( test_case_result );
    
    if ( test_case_result.result_int == 6 )
    {
        autotests::test_case_result_add( test_case_result );
    }
}

// Namespace autotests_utility_mit
// Params 1, eflags: 0x4
// Checksum 0x118ea4b, Offset: 0x12c4
// Size: 0x14
function private function_f6f208f3ba085a91( keys )
{
    return autotests::function_d3af680806999308( keys );
}

// Namespace autotests_utility_mit
// Params 2
// Checksum 0x2b7d0540, Offset: 0x12e1
// Size: 0xdd
function run_all_tests( config, player )
{
    foreach ( idstring in function_f6f208f3ba085a91( getarraykeys( level.mit_lookup ) ) )
    {
        function_a67501b11baacf96( idstring, player );
        [[ config.var_db86da194d47f8f2 ]]( player, idstring );
        result = function_62018041898ad91( idstring );
        function_3ccb8044cdb16827( player, config.var_6b7f0911cb91054a, config.sourcefile, result );
    }
}

// Namespace autotests_utility_mit
// Params 2
// Checksum 0x1a92601a, Offset: 0x13c6
// Size: 0xd0
function function_cb6b3721b0ea598e( config, bots )
{
    level.var_c92998934d6deda0 = function_f6f208f3ba085a91( getarraykeys( level.mit_lookup ) );
    level.var_e330ced85839e497 = 0;
    
    foreach ( bot in bots )
    {
        thread function_fe42af69647a83df( config, bot );
    }
    
    while ( level.var_c92998934d6deda0.size > 0 || level.var_e330ced85839e497 > 0 )
    {
        waitframe();
    }
}

// Namespace autotests_utility_mit
// Params 2, eflags: 0x4
// Checksum 0xc500b0df, Offset: 0x149e
// Size: 0xc3
function private function_fe42af69647a83df( config, player )
{
    level.var_e330ced85839e497++;
    
    while ( level.var_c92998934d6deda0.size > 0 )
    {
        idstring = level.var_c92998934d6deda0[ level.var_c92998934d6deda0.size - 1 ];
        level.var_c92998934d6deda0[ level.var_c92998934d6deda0.size - 1 ] = undefined;
        function_a67501b11baacf96( idstring, player );
        [[ config.var_db86da194d47f8f2 ]]( player, idstring );
        result = function_62018041898ad91( idstring );
        function_3ccb8044cdb16827( player, config.var_6b7f0911cb91054a, config.sourcefile, result );
    }
    
    level.var_e330ced85839e497--;
}

// Namespace autotests_utility_mit
// Params 1
// Checksum 0xa7bc87ba, Offset: 0x1569
// Size: 0x11f
function function_4895ec4bcf553671( datasets )
{
    positional = [];
    named = [];
    paramsuffix = "";
    
    foreach ( entry in datasets )
    {
        parts = strtok( entry, "=" );
        
        if ( parts.size >= 2 )
        {
            named[ parts[ 0 ] ] = parts[ 1 ];
            paramsuffix += "$" + parts[ 0 ] + "=" + parts[ 1 ];
            continue;
        }
        
        positional[ positional.size ] = entry;
    }
    
    result = spawnstruct();
    result.positional = positional;
    result.named = named;
    result.paramsuffix = paramsuffix;
    return result;
}

// Namespace autotests_utility_mit
// Params 3
// Checksum 0x7f7dfe13, Offset: 0x1691
// Size: 0xce
function function_8adc45a70f34952d( count, minbounds, maxbounds )
{
    var_c00f525c21927ad0 = [];
    
    for ( i = 0; i < count ; i++ )
    {
        startpos = _random_nav_point( minbounds, maxbounds );
        endpos = _random_nav_point( minbounds, maxbounds );
        
        if ( !isdefined( startpos ) || !isdefined( endpos ) )
        {
            continue;
        }
        
        id = function_dc2e211727d1d124( startpos ) + "_to_" + function_dc2e211727d1d124( endpos );
        pair = spawnstruct();
        pair.startpos = startpos;
        pair.endpos = endpos;
        var_c00f525c21927ad0[ id ] = pair;
    }
    
    return var_c00f525c21927ad0;
}

// Namespace autotests_utility_mit
// Params 2, eflags: 0x4
// Checksum 0xa90f8bcf, Offset: 0x1768
// Size: 0x73
function private _random_nav_point( minbounds, maxbounds )
{
    if ( minbounds && maxbounds )
    {
        x = randomfloatrange( minbounds[ 0 ], maxbounds[ 0 ] );
        y = randomfloatrange( minbounds[ 1 ], maxbounds[ 1 ] );
        z = level.var_c9730d48ae5087bf ?? 0;
        return getclosestpointonnavmesh( ( x, y, z ) );
    }
    
    return bots_util_mp::function_478281ff275ed942();
}

