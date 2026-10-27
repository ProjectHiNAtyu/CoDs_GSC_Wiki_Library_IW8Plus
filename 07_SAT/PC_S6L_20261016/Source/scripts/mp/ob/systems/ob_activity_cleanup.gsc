// scripts\mp\ob\systems\ob_activity_cleanup.gsc  (hash_55995dc4c370a495.gscc) (size: 4505 Bytes / 0x1199 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65b84769 (1706575721)
// size ...... 4505 (0x1199)
// includes .. 3   (offset: 0xf71)
// strings ... 37  (offset: 0xf89)
// dev strs .. 0   (offset: 0x1199)
// exports ... 18  (offset: 0x9b9)
// cseg ...... 0x2c8 + 0x6f1 (0x9b9)
// imports ... 24  (offset: 0xc89)
// animtree1 . 0   (offset: 0x1199)
// animtree2 . 0   (offset: 0x1199)
#using scripts\common\callbacks;
#using scripts\common\vehicle;
#using scripts\mp\gametypes\ob;

#namespace ob_activity_cleanup;

// Namespace ob_activity_cleanup
// Params 0, eflags: 0x5
// Checksum 0x29053c34, Offset: 0x2e6
// Size: 0x1a
function private autoexec init()
{
    callback::add( "ob_content_process_create_script", &function_69405ecdee7dfab0 );
    cleanup_immediate();
}

// Namespace ob_activity_cleanup
// Params 0, eflags: 0x4
// Checksum 0xe1da48c3, Offset: 0x308
// Size: 0xa8
function private cleanup_immediate()
{
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    if ( isdefined( var_bb86f77304f193c4 ) && !var_bb86f77304f193c4.pvpsettings.enabled )
    {
        pvpregions = getnoentvolumearray( "pvp_region", #script_noteworthy );
        
        for ( index = 0; index < pvpregions.size ; index++ )
        {
            pvpregions[ index ] delete();
        }
        
        var_46dc1d7969215ed4 = getnoentvolumearray( "ob_pvp_gameplay_area", #script_noteworthy );
        
        for ( index = 0; index < var_46dc1d7969215ed4.size ; index++ )
        {
            var_46dc1d7969215ed4[ index ] delete();
        }
    }
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0xbbd8c75a, Offset: 0x3b8
// Size: 0x13
function private function_69405ecdee7dfab0( params )
{
    cleanup_level_structs();
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x3ecb5243, Offset: 0x3d3
// Size: 0x27, Type: bool
function private is_tile_enabled( tile_letter )
{
    return !getdvarint( hashcat( @"hash_479a5af6053041cf", "#" + tile_letter ), 0 );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x9959a107, Offset: 0x403
// Size: 0x1a
function private function_24f5c1e10d08ecf8( targetname )
{
    function_f7bda4bac3a2a942( "targetname", targetname );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x9744daab, Offset: 0x425
// Size: 0x1a
function private function_57ea8fa53b3c777f( script_vehicleref )
{
    function_f7bda4bac3a2a942( "script_vehicleref", script_vehicleref );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x64ca8e56, Offset: 0x447
// Size: 0x1a
function private function_9827dfe2a52b9673( target )
{
    function_f7bda4bac3a2a942( "target", target );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x9744daab, Offset: 0x469
// Size: 0x1a
function private function_c0275234e8eceacd( script_noteworthy )
{
    function_f7bda4bac3a2a942( "script_noteworthy", script_noteworthy );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x14d827f1, Offset: 0x48b
// Size: 0x1a
function private function_7f8a311687ea3db8( variantname )
{
    function_f7bda4bac3a2a942( "variantname", variantname );
}

// Namespace ob_activity_cleanup
// Params 2, eflags: 0x4
// Checksum 0x899a9e1d, Offset: 0x4ad
// Size: 0x1aa
function private function_f7bda4bac3a2a942( type, typevalue )
{
    waitframe();
    structs = level.struct_class_names[ type ][ typevalue ];
    
    if ( !isarray( structs ) )
    {
        return;
    }
    
    foreach ( struct in structs )
    {
        if ( isdefined( struct.targetname ) )
        {
            level.struct_class_names[ "targetname" ][ struct.targetname ] = [];
        }
        
        if ( isdefined( struct.target ) )
        {
            level.struct_class_names[ "target" ][ struct.target ] = [];
        }
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] = [];
        }
        
        if ( isdefined( struct.script_linkname ) )
        {
            level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] = [];
        }
        
        if ( isdefined( struct.variantname ) )
        {
            level.struct_class_names[ "variantname" ][ struct.variantname ] = [];
        }
        
        if ( isdefined( struct.script_vehicleref ) )
        {
            level.struct_class_names[ "script_vehicleref" ][ struct.script_vehicleref ] = [];
        }
    }
}

// Namespace ob_activity_cleanup
// Params 0, eflags: 0x4
// Checksum 0xb46555c8, Offset: 0x65f
// Size: 0x6e
function private function_fe0f0b805a74fa87()
{
    maxnumber = 30;
    minnumber = 0;
    
    for ( index = minnumber; index <= maxnumber ; index++ )
    {
        stringindex = string( index );
        
        if ( isdefined( level.struct_class_names[ "script_noteworthy" ][ stringindex ] ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ stringindex ] = [];
        }
    }
}

// Namespace ob_activity_cleanup
// Params 0, eflags: 0x4
// Checksum 0xc7205ef8, Offset: 0x6d5
// Size: 0x1ab
function private cleanup_level_structs()
{
    function_c0275234e8eceacd( "captivityRespawn_door" );
    function_c0275234e8eceacd( "captivitySpawnPoint" );
    function_c0275234e8eceacd( "cell_spawn" );
    function_c0275234e8eceacd( "prison_spawn" );
    function_c0275234e8eceacd( "smallHouse" );
    function_c0275234e8eceacd( "fight_spawn" );
    function_24f5c1e10d08ecf8( "front_side" );
    function_24f5c1e10d08ecf8( "gulag" );
    function_fe0f0b805a74fa87();
    level.struct_class_names[ "script_noteworthy" ][ "400" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "450" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "450.00" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "500" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "550" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "800" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "1280" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Crouch" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Left" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Right" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Stand" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "dense" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Exposed" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "info_act" ] = [];
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0xf8b9131a, Offset: 0x888
// Size: 0x1d
function private ob_wallbuys_create_script_cleanup( params )
{
    callback::remove( "ob_wallbuys_create_script_done", &ob_wallbuys_create_script_cleanup );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x44077cf2, Offset: 0x8ad
// Size: 0x1d
function private ob_perks_create_script_cleanup( params )
{
    callback::remove( "ob_perks_create_script_done", &ob_perks_create_script_cleanup );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0xf9b36398, Offset: 0x8d2
// Size: 0x1d
function private ob_essence_create_script_cleanup( params )
{
    callback::remove( "ob_essence_create_script_done", &ob_essence_create_script_cleanup );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0x4652c459, Offset: 0x8f7
// Size: 0x1d
function private ob_mysteryboxes_create_script_cleanup( params )
{
    callback::remove( "ob_mysteryboxes_create_script_done", &ob_mysteryboxes_create_script_cleanup );
}

// Namespace ob_activity_cleanup
// Params 1, eflags: 0x4
// Checksum 0xb59167cf, Offset: 0x91c
// Size: 0x9d
function private ob_vehicles_create_script_cleanup( params )
{
    foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 0 ) )
    {
        function_24f5c1e10d08ecf8( vehicleref );
        function_57ea8fa53b3c777f( vehicleref );
    }
    
    callback::remove( "ob_vehicles_create_script_done", &ob_vehicles_create_script_cleanup );
}

