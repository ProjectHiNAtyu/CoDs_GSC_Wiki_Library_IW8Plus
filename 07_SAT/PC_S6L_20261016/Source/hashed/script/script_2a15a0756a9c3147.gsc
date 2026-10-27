// script_2a15a0756a9c3147  (hash_2a15a0756a9c3147.gscc) (size: 6210 Bytes / 0x1842 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39016295 (956392085)
// size ...... 6210 (0x1842)
// includes .. 14  (offset: 0x1696)
// strings ... 10  (offset: 0x1706)
// dev strs .. 12  (offset: 0x17aa)
// exports ... 16  (offset: 0xc4e)
// cseg ...... 0x127 + 0xb27 (0xc4e)
// imports ... 69  (offset: 0xece)
// animtree1 . 0   (offset: 0x1842)
// animtree2 . 0   (offset: 0x1842)
#using script_2528fc84e11f3e4b;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\objidpoolmanager;

#namespace activity_blight_crate_drop;

// Namespace activity_blight_crate_drop
// Params 0, eflags: 0x5
// Checksum 0xbda1152, Offset: 0x145
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_blight_crate_drop", [ #"activity_common", #"hash_60ba902b1d647a74" ], &function_538033a540e63c70, undefined );
}

// Namespace activity_blight_crate_drop
// Params 0, eflags: 0x4
// Checksum 0x39f30ad, Offset: 0x180
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BLIGHT_CRATE_DROP", &activity_type_init );
}

// Namespace activity_blight_crate_drop
// Params 0
// Checksum 0x51a4ab06, Offset: 0x19b
// Size: 0x8f
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BLIGHT_CRATE_DROP", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BLIGHT_CRATE_DROP", 1, &function_477932e3884ea1fd );
    airdrop_scriptbundle::registerairdrop( "saw_airdrop_blight_reward", &on_crate_capture, undefined, &function_620e812f69192e26 );
    shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_CRATE_DROP" );
    shared_data.crate_drop_count = getdvarint( @"hash_a39fd5aa4421473f", 3 );
    shared_data.crates = [];
    level thread cache_spawn_locations();
    
    /#
        init_debug();
    #/
}

// Namespace activity_blight_crate_drop
// Params 0
// Checksum 0xf6eeaa26, Offset: 0x232
// Size: 0x64
function cache_spawn_locations()
{
    flag_name = level.blight_data.cs_flag_name + ( "_completed" ?? "create_script_initialized" );
    utility::flag_wait( flag_name );
    shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_CRATE_DROP" );
    shared_data.crate_spawn_structs = utility::getstructarray( "blight_crate_drop_location" );
}

// Namespace activity_blight_crate_drop
// Params 0
// Checksum 0x6d7e7b5b, Offset: 0x29e
// Size: 0x8d
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    namespace_80082437c22b4d6e::setup_participation_conditions( activity_instance );
    activity_instance.shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_CRATE_DROP" );
    
    if ( !level callback::exists( #"player_death", &function_7a70d42be25aa70a ) )
    {
        level callback::add( #"player_death", &function_7a70d42be25aa70a );
    }
    
    flags::gameflagwait( "prematch_fade_done" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace activity_blight_crate_drop
// Params 0
// Checksum 0x363234a, Offset: 0x333
// Size: 0x10f
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    drop_origins = get_crate_drop_origins( activity_instance );
    
    foreach ( origin in drop_origins )
    {
        crate = airdrop_scriptbundle::startairdrop( "saw_airdrop_blight_reward", undefined, "allies", { #droporigin:origin } )[ 0 ];
        shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_CRATE_DROP" );
        shared_data.crates[ shared_data.crates.size ] = crate;
        crate create_objectives();
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace activity_blight_crate_drop
// Params 1, eflags: 0x4
// Checksum 0x701a0076, Offset: 0x44a
// Size: 0x10d
function private get_crate_drop_origins( activity_instance )
{
    crate_drop_count = activity_instance.shared_data.crate_drop_count;
    
    if ( activity_instance.shared_data.crate_spawn_structs.size > 0 )
    {
        selected_structs = utility::array_slice( arrayrandomize( activity_instance.shared_data.crate_spawn_structs ), 0, crate_drop_count );
        origins = [];
        
        foreach ( spawn_struct in selected_structs )
        {
            origins[ origins.size ] = spawn_struct.origin + utility::function_9e0df7b136ab833c() * 500;
        }
        
        return origins;
    }
    
    return function_935126facfb1b9a5( crate_drop_count );
}

// Namespace activity_blight_crate_drop
// Params 1, eflags: 0x4
// Checksum 0x3c7390e2, Offset: 0x560
// Size: 0x1db
function private function_935126facfb1b9a5( count )
{
    origins = [];
    
    if ( !isdefined( level.mapcorners ) || level.mapcorners.size < 2 )
    {
        return origins;
    }
    
    minx = min( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    maxx = max( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 0 ] );
    miny = min( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    maxy = max( level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 1 ] );
    var_43af8f0213b642cd = maxx - minx;
    var_43af8e0213b6409a = maxy - miny;
    minx += var_43af8f0213b642cd * 0.1;
    maxx -= var_43af8f0213b642cd * 0.1;
    miny += var_43af8e0213b6409a * 0.1;
    maxy -= var_43af8e0213b6409a * 0.1;
    attempts = 0;
    
    while ( origins.size < count && attempts < 32 )
    {
        attempts++;
        candidate = ( randomfloatrange( minx, maxx ), randomfloatrange( miny, maxy ), 0 );
        var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( candidate );
        
        if ( isdefined( var_4d7d4fdebb3384d2 ) )
        {
            origins[ origins.size ] = var_4d7d4fdebb3384d2;
        }
    }
    
    return origins;
}

// Namespace activity_blight_crate_drop
// Params 1, eflags: 0x4
// Checksum 0x276efcf4, Offset: 0x744
// Size: 0x8c
function private on_crate_capture( crate )
{
    points::doscoreevent( #"hash_bf46ff1323b1c468" );
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( crate.origin + ( 0, 0, 20 ) );
    dna_amount = getdvarint( @"hash_2fe32bb7fd70e7a2", 75 );
    item_name = item_currency::function_a3eadb2d3c329589( "dna_sample", dna_amount );
    common_item::function_57b88e025e5fb03e( item_name, dna_amount, spawn_options );
    crate function_620e812f69192e26( 0 );
}

// Namespace activity_blight_crate_drop
// Params 1, eflags: 0x4
// Checksum 0x424f8418, Offset: 0x7d8
// Size: 0x67
function private function_620e812f69192e26( immediate )
{
    profilestart();
    
    if ( self.obj_id )
    {
        objidpoolmanager::returnobjectiveid( self.obj_id );
        self.obj_id = undefined;
    }
    
    shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_CRATE_DROP" );
    shared_data.crates = arrayremove( shared_data.crates, self );
    profilestop();
}

// Namespace activity_blight_crate_drop
// Params 0, eflags: 0x4
// Checksum 0x2c327e19, Offset: 0x847
// Size: 0xc1
function private create_objectives()
{
    obj_id = objidpoolmanager::requestobjectiveid( 98 );
    
    if ( obj_id != -1 )
    {
        objidpoolmanager::objective_add_objective( obj_id, "current", self.origin, "saw_ui_icon_supply_drop" );
        objidpoolmanager::update_objective_setbackground( obj_id, 1 );
        objidpoolmanager::function_586b631e7bbb592a( obj_id, 1 );
        objidpoolmanager::update_objective_onentity( obj_id, self );
        objidpoolmanager::objective_set_play_intro( obj_id, 0 );
        objidpoolmanager::objective_set_play_outro( obj_id, 0 );
        function_ac9886e0e2860e18( obj_id, 7500, 8000 );
        function_8eab38514b79538d( obj_id, 1000 );
        objidpoolmanager::function_19410dd520bff519( obj_id, "allies" );
        objidpoolmanager::function_373aaf492aabde6f( obj_id, 237, 203, 86, 1 );
        objidpoolmanager::update_objective_description( obj_id, &"MP_INGAME_ONLY/SUPPLY_CRATE_CAPS" );
        self.obj_id = obj_id;
    }
}

// Namespace activity_blight_crate_drop
// Params 1
// Checksum 0x3a4f0399, Offset: 0x910
// Size: 0xed
function function_7a70d42be25aa70a( params )
{
    if ( !params.victim || params.victim.team != "allies" )
    {
        return;
    }
    
    shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_CRATE_DROP" );
    
    foreach ( crate in shared_data.crates )
    {
        if ( crate.obj_id )
        {
            objidpoolmanager::objective_playermask_hidefrom( crate.obj_id, params.victim );
        }
    }
}

/#

    // Namespace activity_blight_crate_drop
    // Params 0, eflags: 0x4
    // Checksum 0xde92223b, Offset: 0xa05
    // Size: 0x44, Type: dev
    function private init_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x37>", "<dev string:x4f>", &function_7a786abd839be646 );
        devgui::add_devgui_func( "<dev string:x6a>", "<dev string:x75>", &debug_drop_crate );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_blight_crate_drop
    // Params 0, eflags: 0x4
    // Checksum 0x98db2ca3, Offset: 0xa51
    // Size: 0x16b, Type: dev
    function private function_7a786abd839be646()
    {
        if ( !isdefined( level.debug_blight_crate_drop ) )
        {
            level.debug_blight_crate_drop = {};
        }
        
        if ( level.debug_blight_crate_drop.show_loc )
        {
            level.debug_blight_crate_drop.show_loc = 0;
            level notify( #"hash_1d21eba240b946d7" );
            return;
        }
        
        level.debug_blight_crate_drop.show_loc = 1;
        shared_data = activity_common::function_9b15260622ed4dbe( "<dev string:x92>" );
        
        if ( shared_data.crate_spawn_structs.size == 0 )
        {
            iprintlnbold( "<dev string:xa4>" + "<dev string:xbc>" + "<dev string:xd7>" );
            return;
        }
        
        foreach ( spawn_struct in shared_data.crate_spawn_structs )
        {
            debug::line( spawn_struct, spawn_struct.origin + ( 0, 0, 3000 ), ( 0, 1, 0 ), undefined, "<dev string:x11f>" );
            debug::sphere( spawn_struct, 10, ( 0, 1, 0 ), undefined, "<dev string:x11f>" );
        }
    }

    // Namespace activity_blight_crate_drop
    // Params 0, eflags: 0x4
    // Checksum 0xb28a3e5c, Offset: 0xbc4
    // Size: 0x8a, Type: dev
    function private debug_drop_crate()
    {
        shared_data = activity_common::function_9b15260622ed4dbe( "<dev string:x92>" );
        origin = utility::array_random( shared_data.crate_spawn_structs ).origin ?? function_935126facfb1b9a5( 1 )[ 0 ].origin;
        crate = airdrop_scriptbundle::startairdrop( "<dev string:x13c>", undefined, "<dev string:x156>", { #droporigin:origin } )[ 0 ];
        crate create_objectives();
    }

#/
