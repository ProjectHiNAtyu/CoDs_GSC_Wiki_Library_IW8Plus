// scripts\autotests\autotests_telemetry.gsc  (hash_088b3fd3730cb78b.gscc) (size: 7313 Bytes / 0x1c91 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff9671d4 (4288049620)
// size ...... 7313 (0x1c91)
// includes .. 1   (offset: 0x18ed)
// strings ... 61  (offset: 0x18f5)
// dev strs .. 1   (offset: 0x1c85)
// exports ... 18  (offset: 0x13cd)
// cseg ...... 0x665 + 0xd68 (0x13cd)
// imports ... 17  (offset: 0x169d)
// animtree1 . 0   (offset: 0x1c91)
// animtree2 . 0   (offset: 0x1c91)
#using scripts\autotests\autotests;

#namespace autotests_telemetry;

// Namespace autotests_telemetry
// Params 6
// Checksum 0xd1f81c31, Offset: 0x683
// Size: 0xe0
function spatial_event_create( geometry_wkt, geometry_metadata_json, event_type, event_source, result, metadata_json )
{
    if ( !function_30e400fd65a943b6( geometry_wkt, geometry_metadata_json, event_type, event_source, result, metadata_json ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: Missing required argument(s) for spatial_event_create." );
        return;
    }
    
    s = spawnstruct();
    s.geometry_wkt = geometry_wkt;
    s.geometry_metadata_json = geometry_metadata_json;
    s.time = gettime();
    s.event_type = event_type;
    s.event_source = event_source;
    s.result = result;
    s.metadata_json = metadata_json;
    s.mapextents_json = get_mapextents();
    return s;
}

// Namespace autotests_telemetry
// Params 0
// Checksum 0x44aa354d, Offset: 0x76c
// Size: 0x1e5
function get_mapextents()
{
    if ( !( isdefined( level ) && isdefined( level.mapname ) && isdefined( level.mapcorners[ 0 ] ) && isdefined( level.mapcorners[ 1 ] ) && isdefined( level.mapcorners[ 0 ].origin[ 0 ] ) && isdefined( level.mapcorners[ 0 ].origin[ 1 ] ) && isdefined( level.mapcorners[ 1 ].origin[ 0 ] ) && isdefined( level.mapcorners[ 1 ].origin[ 1 ] ) ) )
    {
        return "{}";
    }
    
    mapcomponent = level.script_parameters ?? "";
    submapname = level.script_noteworthy ?? "";
    top_left_x = level.mapcorners[ 0 ].origin[ 0 ];
    top_left_y = level.mapcorners[ 0 ].origin[ 1 ];
    bottom_right_x = level.mapcorners[ 1 ].origin[ 0 ];
    bottom_right_y = level.mapcorners[ 1 ].origin[ 1 ];
    extents_json = "{\"map_name\": \"" + level.mapname + "\", " + "\"map_component\": \"" + mapcomponent + "\", " + "\"submap_name\": \"" + submapname + "\", " + "\"top_left_x\": " + top_left_x + ", " + "\"top_left_y\": " + top_left_y + ", " + "\"bottom_right_x\": " + bottom_right_x + ", " + "\"bottom_right_y\": " + bottom_right_y + " }";
    return extents_json;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0x635cee98, Offset: 0x95a
// Size: 0x83
function function_464ddcba1fc9adbb( positions )
{
    wkt = "MULTIPOINT Z (";
    
    for ( i = 0; i < positions.size ; i++ )
    {
        pos = positions[ i ];
        wkt += pos[ 0 ] + " " + pos[ 1 ] + " " + pos[ 2 ];
        
        if ( i < positions.size - 1 )
        {
            wkt += ", ";
        }
    }
    
    wkt += ")";
    return wkt;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0x635cee98, Offset: 0x9e6
// Size: 0x83
function function_f6a7c392efedf019( positions )
{
    wkt = "LINESTRING Z (";
    
    for ( i = 0; i < positions.size ; i++ )
    {
        pos = positions[ i ];
        wkt += pos[ 0 ] + " " + pos[ 1 ] + " " + pos[ 2 ];
        
        if ( i < positions.size - 1 )
        {
            wkt += ", ";
        }
    }
    
    wkt += ")";
    return wkt;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0xf9ed68af, Offset: 0xa72
// Size: 0x78, Type: bool
function spatial_event_validate( event )
{
    return isdefined( event ) && isdefined( event.geometry_wkt ) && isdefined( event.geometry_metadata_json ) && isdefined( event.time ) && isdefined( event.event_type ) && isdefined( event.event_source ) && isdefined( event.result ) && isdefined( event.metadata_json );
}

// Namespace autotests_telemetry
// Params 4
// Checksum 0x28fd6a19, Offset: 0xaf3
// Size: 0x146
function spatial_event_send( event, table, callback, dry_run = 1 )
{
    if ( !spatial_event_validate( event ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] Spatial event invalid, not sending." + event );
        return;
    }
    
    if ( !isdefined( table ) )
    {
        table = "spatial_event_default_table";
    }
    
    var_1bc3f12607be2ac6 = [];
    var_1bc3f12607be2ac6[ 0 ] = function_e655872d8bd4dc90( event );
    arr = function_3f1cbe3376c3976b( table, var_1bc3f12607be2ac6 );
    data = spawnstruct();
    data.spatial_event = arr;
    
    if ( !isdefined( callback ) )
    {
        callback = &function_6b32ec20b1548ad3;
        callback_provided = 0;
    }
    
    level.autotests.test_runtime.var_552e784db1ce905d = 0;
    autotests::http_post( function_335b65ad4ff72231( dry_run ), data, callback );
    
    if ( !callback_provided )
    {
        starttime = gettime();
        
        while ( !level.autotests.test_runtime.var_552e784db1ce905d )
        {
            waitframe();
            
            if ( gettime() - starttime > 15000 )
            {
                autotests::function_d84657f448aaeef6( "HTTP response did not come back in 15 sec!", 0, "scripts/autotests/autotests_telemetry.gsc", 240 );
                return;
            }
        }
    }
}

// Namespace autotests_telemetry
// Params 4
// Checksum 0xbe586e80, Offset: 0xc41
// Size: 0x1bc
function function_5530fe2e62fb63db( events, table, callback, dry_run )
{
    if ( !isdefined( events ) || events.size == 0 )
    {
        autotests::print_both( "[SPATIAL_EVENT] No events to send." + events );
        return;
    }
    
    if ( !isdefined( dry_run ) )
    {
        dry_run = 1;
    }
    
    if ( !isdefined( table ) )
    {
        table = "spatial_event_default_table";
    }
    
    var_1bc3f12607be2ac6 = [];
    invalid_events = 0;
    
    for ( i = 0; i < events.size ; i++ )
    {
        if ( !spatial_event_validate( events[ i ] ) )
        {
            autotests::print_both( "[SPATIAL_EVENT] Event " + i + " invalid, skipping." );
            invalid_events++;
            continue;
        }
        
        var_1bc3f12607be2ac6[ i ] = function_e655872d8bd4dc90( events[ i ] );
    }
    
    if ( invalid_events == events.size )
    {
        autotests::print_both( "[SPATIAL_EVENT] All events invalid, not sending." );
        return;
    }
    
    arr = function_3f1cbe3376c3976b( table, var_1bc3f12607be2ac6 );
    data = spawnstruct();
    data.spatial_event = arr;
    
    if ( !isdefined( callback ) )
    {
        callback = &function_6b32ec20b1548ad3;
        callback_provided = 0;
    }
    
    autotests::print_both( "[SPATIAL_EVENT] Attempting to send batch of spatial events." );
    level.autotests.test_runtime.var_552e784db1ce905d = 0;
    autotests::http_post( function_335b65ad4ff72231( dry_run ), data, callback );
    
    if ( !callback_provided )
    {
        starttime = gettime();
        
        while ( !level.autotests.test_runtime.var_552e784db1ce905d )
        {
            waitframe();
            
            if ( gettime() - starttime > 15000 )
            {
                autotests::function_d84657f448aaeef6( "HTTP response did not come back in 15 sec!", 0, "scripts/autotests/autotests_telemetry.gsc", 307 );
                return;
            }
        }
    }
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0xbbc036d8, Offset: 0xe05
// Size: 0xac
function function_6b32ec20b1548ad3( response )
{
    if ( !isdefined( response ) || !isdefined( response.statuscode ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] WARNING: no response received." );
        return;
    }
    
    println( "<dev string:x24>" + response );
    level.autotests.test_runtime.var_552e784db1ce905d = 1;
    
    if ( response.statuscode != 200 )
    {
        autotests::print_both( "[SPATIAL_EVENT] WARNING: unexpected status code: " + response.statuscode );
        return 1;
    }
    
    autotests::print_both( "[SPATIAL_EVENT] OK: event sent successfully (" + response.statuscode + ")." );
    return 0;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0x2f50e30, Offset: 0xeba
// Size: 0x1b
function spatial_event_log( event )
{
    autotests::print_both( function_b06f509649277c92( event ) );
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0xfeff36ee, Offset: 0xedd
// Size: 0x93
function build_geometry_metadata_json( entries )
{
    json = "[";
    
    for ( i = 0; i < entries.size ; i++ )
    {
        entry = entries[ i ];
        json += "{\"type\":\"" + entry.type + "\",\"description\":\"" + entry.description + "\"}";
        
        if ( i < entries.size - 1 )
        {
            json += ",";
        }
    }
    
    json += "]";
    return json;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0x57468e78, Offset: 0xf79
// Size: 0xd1
function function_f65481dc1156878e( kv )
{
    json = "{";
    
    for ( i = 0; i < kv.size ; i++ )
    {
        if ( isstring( kv[ i ].value ) )
        {
            json += "\"" + kv[ i ].key + "\":\"" + kv[ i ].value + "\"";
        }
        else
        {
            json += "\"" + kv[ i ].key + "\":" + kv[ i ].value;
        }
        
        if ( i < kv.size - 1 )
        {
            json += ",";
        }
    }
    
    json += "}";
    return json;
}

// Namespace autotests_telemetry
// Params 3
// Checksum 0x933fa275, Offset: 0x1053
// Size: 0x50
function function_90fb06735d383d9a( table, session_id, event_json )
{
    return "{" + "\"" + table + "\":[{" + "\"apollo_test_session_id\":\"" + session_id + "\"," + event_json + "}]" + "}";
}

// Namespace autotests_telemetry
// Params 2
// Checksum 0x3294ba09, Offset: 0x10ac
// Size: 0x5f
function function_3f1cbe3376c3976b( table, var_1bc3f12607be2ac6 )
{
    arr = [];
    session_id = autotests::get_apollo_test_session_id();
    
    for ( i = 0; i < var_1bc3f12607be2ac6.size ; i++ )
    {
        arr[ i ] = function_90fb06735d383d9a( table, session_id, var_1bc3f12607be2ac6[ i ] );
    }
    
    return arr;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0x5e9bc2b3, Offset: 0x1114
// Size: 0xd1
function function_b06f509649277c92( event )
{
    return "{" + "\"geometry_wkt\":\"" + event.geometry_wkt + "\"," + "\"geometry_metadata_json\":" + event.geometry_metadata_json + "," + "\"time\":" + event.time + "," + "\"event_type\":\"" + event.event_type + "\"," + "\"event_source\":\"" + event.event_source + "\"," + "\"result\":" + event.result + "," + "\"metadata_json\":" + event.metadata_json + "," + "\"mapextents_json\":" + event.mapextents_json + "}";
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0xb7a766fe, Offset: 0x11ee
// Size: 0xc5
function function_e655872d8bd4dc90( event )
{
    return "\"geometry_wkt\":\"" + event.geometry_wkt + "\"," + "\"geometry_metadata_json\":" + event.geometry_metadata_json + "," + "\"time\":" + event.time + "," + "\"event_type\":\"" + event.event_type + "\"," + "\"event_source\":\"" + event.event_source + "\"," + "\"result\":" + event.result + "," + "\"metadata_json\":" + event.metadata_json + "," + "\"mapextents_json\":" + event.mapextents_json;
}

// Namespace autotests_telemetry
// Params 1
// Checksum 0x7fb64007, Offset: 0x12bc
// Size: 0x39
function function_335b65ad4ff72231( dry_run )
{
    var_1e63d4f838b9fb17 = "http://ta-am-apollo.activision.com/record_dryrun";
    standard_url = "http://ta-am-apollo.activision.com/record";
    
    if ( dry_run == 1 )
    {
        return var_1e63d4f838b9fb17;
    }
    
    return standard_url;
}

// Namespace autotests_telemetry
// Params 6
// Checksum 0x7d2a1007, Offset: 0x12fe
// Size: 0xce, Type: bool
function function_30e400fd65a943b6( geometry_wkt, geometry_metadata_json, event_type, event_source, result, metadata_json )
{
    if ( !isdefined( geometry_wkt ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: geometry_wkt is not defined." );
        return false;
    }
    
    if ( !isdefined( geometry_metadata_json ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: geometry_metadata_json is not defined." );
        return false;
    }
    
    if ( !isdefined( event_type ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: event_type is not defined." );
        return false;
    }
    
    if ( !isdefined( event_source ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: event_source is not defined." );
        return false;
    }
    
    if ( !isdefined( result ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: result is not defined." );
        return false;
    }
    
    if ( !isdefined( metadata_json ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: metadata_json is not defined." );
        return false;
    }
    
    if ( !isdefined( event_source ) )
    {
        autotests::print_both( "[SPATIAL_EVENT] ERROR: event_source is not defined." );
        return false;
    }
    
    return true;
}

