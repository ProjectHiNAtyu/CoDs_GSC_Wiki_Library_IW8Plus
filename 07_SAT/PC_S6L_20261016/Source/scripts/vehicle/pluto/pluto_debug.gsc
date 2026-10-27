// scripts\vehicle\pluto\pluto_debug.gsc  (hash_19128044cd6ef404.gscc) (size: 6314 Bytes / 0x18aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35615cdf (895573215)
// size ...... 6314 (0x18aa)
// includes .. 10  (offset: 0x14a6)
// strings ... 2   (offset: 0x14f6)
// dev strs .. 76  (offset: 0x150e)
// exports ... 18  (offset: 0xbd6)
// cseg ...... 0x85 + 0xb51 (0xbd6)
// imports ... 46  (offset: 0xea6)
// animtree1 . 0   (offset: 0x18aa)
// animtree2 . 0   (offset: 0x18aa)
#using script_16ea1b94f0f381b3;
#using script_54d7585f0a1791e6;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\systems\zone_manager;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0, eflags: 0x1
// Checksum 0xf54bb51c, Offset: 0xa3
// Size: 0x13
function autoexec init()
{
    callback::add( "on_pluto_spawned", &function_9af8b5078d16c4ae );
}

// Namespace pluto_veh
// Params 1
// Checksum 0x4fa079c, Offset: 0xbe
// Size: 0xbe
function function_9af8b5078d16c4ae( params )
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"firefly_pluto_stage", &function_ec77a59ee2149246 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"firefly_pluto_spawn", &function_d0a830cd4a565f58 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_5f0ea49431936512", &function_8198c96636b9ce5 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_4050ace02e2fe698", &function_4af3503e9fa9058d );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"firefly_pluto_repair_time", &function_412845b40c6e2308 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9037b6a90524a549", &function_9edf8e1bbd653b68 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_22bb3c5ddbcb0d21", &function_d3d2e64439859e78 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_2cff65d062848791", &function_80d203bd4df28e40 );
    
    /#
        thread function_60f1992a01b289da();
    #/
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xbcfffd7e, Offset: 0x184
// Size: 0x2f
function private function_8198c96636b9ce5( params )
{
    autohealstart = int( params[ 0 ] );
    setdvar( @"hash_7782e26f82a4502b", autohealstart );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x39da0327, Offset: 0x1bb
// Size: 0x2f
function private function_4af3503e9fa9058d( params )
{
    autohealrate = int( params[ 0 ] );
    setdvar( @"hash_2b4c8822dd1d39d8", autohealrate );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xdc5d3c43, Offset: 0x1f2
// Size: 0x45
function private function_d0a830cd4a565f58( params )
{
    vehicle::spawn( "veh_sat_firefly_pluto", { #origin:level.players[ 0 ].origin + ( 0, 0, 100 ) } );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x7c51e108, Offset: 0x23f
// Size: 0x35
function private function_ec77a59ee2149246( params )
{
    upgrade_index = int( params[ 0 ] );
    level.wonder_veh.stagerequested = upgrade_index;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x1b6a0da4, Offset: 0x27c
// Size: 0x2f
function private function_412845b40c6e2308( params )
{
    repairtime = int( params[ 0 ] );
    setdvar( @"firefly_pluto_repair_time", repairtime );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xb55f691e, Offset: 0x2b3
// Size: 0x2f
function private function_9edf8e1bbd653b68( params )
{
    var_ec1bbd3106084234 = int( params[ 0 ] );
    setdvar( @"hash_29812b097ceae62", var_ec1bbd3106084234 );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xa2cf9848, Offset: 0x2ea
// Size: 0x2f
function private function_d3d2e64439859e78( params )
{
    recalibrationtime = int( params[ 0 ] );
    setdvar( @"hash_297bc858a9f54d76", recalibrationtime );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x4ab844ce, Offset: 0x321
// Size: 0x2f
function private function_80d203bd4df28e40( params )
{
    var_fa1cd1ec82e6562d = int( params[ 0 ] );
    setdvar( @"hash_35ce93feb5b3e8d2", var_fa1cd1ec82e6562d );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xcc8c34db, Offset: 0x358
// Size: 0x19a
function private process_debug_vehicle_health()
{
    if ( getdvarint( @"firefly_pluto_health" ) == 1 )
    {
        setdvar( @"firefly_pluto_health", 0 );
        vehicle_damage::set_health( 50 );
        set_vehicle_usable_state( self, 0 );
    }
    
    if ( getdvarint( @"hash_18deb644feb21a48" ) == 1 )
    {
        setdvar( @"hash_18deb644feb21a48", 0 );
        vehicle_damage::set_health( 50 );
        self.secondarylife = 50;
        set_vehicle_usable_state( self, 0 );
    }
    
    if ( getdvarint( @"firefly_pluto_autoheal" ) > 0 )
    {
        setdvar( @"firefly_pluto_autoheal", 0 );
        self.autohealskip = 1;
    }
    
    /#
        if ( getdvarint( @"hash_e8f85f0100f7d4f0" ) == 1 )
        {
            teleport_pos = utility::getstructarray( "<dev string:x24>", "<dev string:x3a>" );
            
            foreach ( spawnpoint in teleport_pos )
            {
                zone_struct = zone_manager::function_90e5c3e2272b0130( spawnpoint.origin );
                
                if ( zone_struct.is_enabled )
                {
                    debug::sphere( spawnpoint.origin, 500, "<dev string:x45>" );
                    continue;
                }
                
                debug::sphere( spawnpoint.origin, 500, "<dev string:x4b>" );
            }
        }
    #/
}

/#

    // Namespace pluto_veh
    // Params 0
    // Checksum 0x2a675a52, Offset: 0x4fa
    // Size: 0xd8, Type: dev
    function function_3f67fe231df1c8af()
    {
        var_a9c87d0ba47a162c = [];
        var_f262560bd9b8123e = [];
        var_6c6fb5efd83fb72d = [];
        currpos = 0;
        self.var_b0cab7711b26265d = 1;
        setdvar( @"hash_d35a819e8fd62a8c", 0 );
        
        while ( true )
        {
            var_a9c87d0ba47a162c[ currpos ] = self.origin;
            var_f262560bd9b8123e[ currpos ] = self.angles;
            var_6c6fb5efd83fb72d[ currpos ] = self vehicle_getspeed();
            currpos++;
            println( "<dev string:x4f>" + currpos );
            wait 2.5;
            
            if ( currpos >= 20 )
            {
                println( "<dev string:x5e>" );
                function_c9b2ccf2402a4b09( "<dev string:x72>", var_a9c87d0ba47a162c );
                function_c9b2ccf2402a4b09( "<dev string:x76>", var_f262560bd9b8123e );
                function_c9b2ccf2402a4b09( "<dev string:x7a>", var_6c6fb5efd83fb72d );
                self.var_b0cab7711b26265d = 0;
                return;
            }
        }
    }

    // Namespace pluto_veh
    // Params 2
    // Checksum 0x9bad9854, Offset: 0x5da
    // Size: 0x16a, Type: dev
    function function_c9b2ccf2402a4b09( type, datastruct )
    {
        fileextension = "<dev string:x7e>";
        var_4490d72360f3a54c = "<dev string:x83>" + type + fileextension;
        var_c16e659bb0f9780f = "<dev string:x91>" + game_utility::getmapname();
        println( "<dev string:xa2>" + var_4490d72360f3a54c + "<dev string:xb6>" + var_c16e659bb0f9780f );
        var_9f36f70c7b33491c = openfile( var_c16e659bb0f9780f + "<dev string:xbb>" + var_4490d72360f3a54c, "<dev string:xbd>" );
        
        if ( var_9f36f70c7b33491c == -1 )
        {
            println( "<dev string:xc3>" );
            return;
        }
        
        fprintln( var_9f36f70c7b33491c, "<dev string:xe1>" );
        firsttime = 1;
        
        foreach ( val in datastruct )
        {
            if ( !firsttime )
            {
                tooutput = "<dev string:xe3>" + val;
            }
            else
            {
                tooutput = val;
            }
            
            println( "<dev string:xe6>" + var_9f36f70c7b33491c + "<dev string:xee>" + tooutput );
            fprintln( var_9f36f70c7b33491c, tooutput );
        }
        
        fprintln( var_9f36f70c7b33491c, "<dev string:xfa>" );
        closefile( var_9f36f70c7b33491c );
    }

    // Namespace pluto_veh
    // Params 0, eflags: 0x4
    // Checksum 0xb40a92db, Offset: 0x74c
    // Size: 0x330, Type: dev
    function private function_60f1992a01b289da()
    {
        vehicle = self;
        vehicle endon( #"death" );
        setdvarifuninitialized( @"firefly_pluto_stage", -1 );
        setdvarifuninitialized( @"firefly_pluto_repair", 0 );
        devgui::function_9082edeb5db93280( "<dev string:xfc>" );
        devgui::add_devgui_command( "<dev string:x11b>", "<dev string:x133>" );
        devgui::add_devgui_command( "<dev string:x14d>", "<dev string:x164>" );
        devgui::add_devgui_command( "<dev string:x17e>", "<dev string:x196>" );
        devgui::add_devgui_command( "<dev string:x1b0>", "<dev string:x1ca>" );
        devgui::add_devgui_command( "<dev string:x1e4>", "<dev string:x200>" );
        devgui::add_devgui_command( "<dev string:x21b>", "<dev string:x235>" );
        devgui::add_devgui_command( "<dev string:x250>", "<dev string:x26f>" );
        devgui::add_devgui_command( "<dev string:x28a>", "<dev string:x2ab>" );
        devgui::add_devgui_command( "<dev string:x2c9>", "<dev string:x2e5>" );
        devgui::add_devgui_command( "<dev string:x302>", "<dev string:x320>" );
        devgui::add_devgui_command( "<dev string:x346>", "<dev string:x36b>" );
        devgui::add_devgui_command( "<dev string:x394>", "<dev string:x3b9>" );
        devgui::add_devgui_command( "<dev string:x3e2>", "<dev string:x407>" );
        devgui::add_devgui_command( "<dev string:x430>", "<dev string:x453>" );
        devgui::add_devgui_command( "<dev string:x47a>", "<dev string:x49d>" );
        devgui::add_devgui_command( "<dev string:x4c4>", "<dev string:x4e7>" );
        devgui::add_devgui_command( "<dev string:x50e>", "<dev string:x53e>" );
        devgui::add_devgui_command( "<dev string:x565>", "<dev string:x586>" );
        devgui::add_devgui_command( "<dev string:x5a9>", "<dev string:x5c0>" );
        devgui::add_devgui_command( "<dev string:x5dd>", "<dev string:x5f8>" );
        devgui::add_devgui_command( "<dev string:x617>", "<dev string:x63b>" );
        devgui::add_devgui_command( "<dev string:x660>", "<dev string:x682>" );
        devgui::function_77df7fe7dd273e10();
        
        while ( true )
        {
            var_9ad1b1bdf284b928 = getdvarint( @"firefly_pluto_stage" );
            
            if ( var_9ad1b1bdf284b928 != vehicle.var_7493baa2cd62443 && var_9ad1b1bdf284b928 != -1 && vehicle.stagerequested == -1 )
            {
                vehicle.var_e36cfae7a208562c = var_9ad1b1bdf284b928;
            }
            
            if ( getdvarint( @"hash_8b545170ec0a5b56" ) > 0 )
            {
                vehicle utility::function_7c10ea82c1e305b8( "<dev string:x6a8>", "<dev string:x6ba>" );
                setdvar( @"hash_8b545170ec0a5b56", 0 );
            }
            else if ( vehicle utility::function_9f2c41c1dcc8c94( "<dev string:x6a8>", "<dev string:x6ba>" ) )
            {
                wait 10;
                vehicle utility::function_7c10ea82c1e305b8( "<dev string:x6a8>", "<dev string:x6bd>" );
            }
            
            if ( getdvarint( @"hash_d35a819e8fd62a8c" ) == 1 )
            {
                if ( self.var_7493baa2cd62443 == 0 )
                {
                    vehicle.var_e36cfae7a208562c = 1;
                }
                
                if ( !vehicle.var_b0cab7711b26265d )
                {
                    vehicle thread function_3f67fe231df1c8af();
                }
            }
            
            vehicle process_debug_vehicle_health();
            vehicle function_e3f711e1e9331a7a();
            
            if ( isdefined( vehicle.repairinteract ) && vehicle.repairinteract function_45c212dce7227aa7() )
            {
                sphere( vehicle.repairinteract.origin, vehicle.var_8789c2b2203e37fb, ( 1, 0.5, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace pluto_veh
    // Params 0, eflags: 0x4
    // Checksum 0xf7315608, Offset: 0xa84
    // Size: 0x9a, Type: dev
    function private function_e3f711e1e9331a7a()
    {
        var_7887ee50033fbcfb = "<dev string:x6c1>";
        
        switch ( self.var_7493baa2cd62443 )
        {
            case 1:
                var_7887ee50033fbcfb = "<dev string:x6d6>";
                break;
            case 2:
                var_7887ee50033fbcfb = "<dev string:x6f3>";
                break;
            case 3:
                var_7887ee50033fbcfb = "<dev string:x70e>";
                break;
            case 4:
                var_7887ee50033fbcfb = "<dev string:x728>";
                break;
        }
        
        printtoscreen2d( 500, 25, var_7887ee50033fbcfb, ( 1, 1, 0 ), 5 );
    }

    // Namespace pluto_veh
    // Params 1, eflags: 0x4
    // Checksum 0xc00045c5, Offset: 0xb26
    // Size: 0x40, Type: dev
    function private function_f66e165e3a9bb4dc( player )
    {
        iprintlnbold( "<dev string:x73d>" + self.stage );
        self.vehicle.var_e36cfae7a208562c = self.stage;
    }

    // Namespace pluto_veh
    // Params 1, eflags: 0x4
    // Checksum 0x37bcc7eb, Offset: 0xb6e
    // Size: 0x68, Type: dev
    function private debug_draw_interact( text )
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        if ( !isdefined( self.origin ) )
        {
            return;
        }
        
        while ( isdefined( self ) )
        {
            waitframe();
            
            if ( getdvarint( @"hash_e0aac917468a1d4c", 1 ) )
            {
                print3d( self.origin, text, undefined, undefined, 0.8 );
            }
        }
    }

#/
