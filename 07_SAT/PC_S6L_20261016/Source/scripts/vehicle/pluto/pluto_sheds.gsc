// scripts\vehicle\pluto\pluto_sheds.gsc  (hash_0e4e57e4e5925ee0.gscc) (size: 9059 Bytes / 0x2363 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73938e43 (1939050051)
// size ...... 9059 (0x2363)
// includes .. 6   (offset: 0x209f)
// strings ... 14  (offset: 0x20cf)
// dev strs .. 39  (offset: 0x218f)
// exports ... 22  (offset: 0x159b)
// cseg ...... 0x171 + 0x142a (0x159b)
// imports ... 57  (offset: 0x190b)
// animtree1 . 0   (offset: 0x2363)
// animtree2 . 0   (offset: 0x2363)
#using script_54d7585f0a1791e6;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\systems\zm_interaction;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0
// Checksum 0x8519b332, Offset: 0x18f
// Size: 0x94
function init_repair_sheds()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_a5dabc3ab9c77048", 1 ) == 0 || isdefined( level.sheddata ) )
    {
        return;
    }
    
    function_d3f2f217f6d84475();
    repairsheds = [];
    
    /#
        function_e90e75da43d6045c( "<dev string:x24>" );
    #/
    
    var_daf4f89bdfd95a60 = function_65ebfb549c92931e();
    
    if ( isdefined( var_daf4f89bdfd95a60 ) )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x43>" );
        #/
        
        repairsheds[ repairsheds.size ] = var_daf4f89bdfd95a60;
        function_785db8d7fdd82659( repairsheds );
        level.repairsheds = repairsheds;
    }
}

// Namespace pluto_veh
// Params 0
// Checksum 0x8b8a2fcc, Offset: 0x22b
// Size: 0x116
function function_d3f2f217f6d84475()
{
    sheddata = spawnstruct();
    sheddata.radius = getdvarint( @"hash_648b519561e6f130", 525 );
    sheddata.height = getdvarint( @"hash_b0bc38edcd7a69d1", 1000 );
    sheddata.var_30de6c56297ed04b = getdvarint( @"hash_1463737441a791e3", 30 );
    sheddata.var_938a1b3e201fddd6 = getdvarfloat( @"hash_9188f6fa29a3f0fe", 0.25 );
    sheddata.repairdistance = getdvarfloat( @"hash_9e1e7802a19e841b", 1.25 );
    sheddata.origin = getdvarvector( @"hash_525a82df7399c544", ( 3876.76, -1036.16, -328.86 ) );
    
    if ( game_utility::getmapname() == "mp_sat_coredev_vehicle_test" )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x61>" );
        #/
        
        sheddata.origin = getdvarvector( @"hash_1580bdbd401e5cf5", ( 15190, -20995, 306 ) );
    }
    
    level.sheddata = sheddata;
}

// Namespace pluto_veh
// Params 0
// Checksum 0x6ec3cb4c, Offset: 0x349
// Size: 0x211
function function_65ebfb549c92931e()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_sat_firefly_script_garage_cs_completed" );
    
    if ( getdvarint( @"hash_25828ed43df92efe", 1 ) )
    {
        var_7d19d6c028fd64a3 = utility::getstruct( "s_garage", "targetname" );
        assert( isdefined( var_7d19d6c028fd64a3 ), "<dev string:x84>" );
        repairShed = var_7d19d6c028fd64a3;
        repairShed.radiussquared = squared( var_7d19d6c028fd64a3.radius );
        repairShed.minheight = var_7d19d6c028fd64a3.origin[ 2 ] - 200;
        repairShed.maxheight = var_7d19d6c028fd64a3.origin[ 2 ] + level.sheddata.height - 200;
        repairShed.triggertargetname = "repairShed";
    }
    else if ( getdvarint( @"hash_6e0894913af25102", 0 ) )
    {
        radius = level.sheddata.radius;
        origin = level.sheddata.origin;
        repairShed = spawnstruct();
        repairShed.origin = origin;
        repairShed.radiussquared = squared( radius );
        repairShed.minheight = origin[ 2 ] - 200;
        repairShed.maxheight = origin[ 2 ] + level.sheddata.height - 200;
        repairShed.triggertargetname = "repairShed";
    }
    
    repairShed.var_804ff35085534191 = gettime();
    repairShed.var_e81821a6777b40bb = 0;
    repairShed.var_f1ee3f9bbc84009 = 0;
    repairShed.var_a670580200d319bf = 0;
    repairShed.var_34a8572d9d76db13 = 0;
    
    if ( !isdefined( level.repairsheds ) )
    {
        level.repairsheds = [];
    }
    
    level.repairsheds[ level.repairsheds.size ] = repairShed;
    return repairShed;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xfdd0cbae, Offset: 0x563
// Size: 0x141
function private function_785db8d7fdd82659( repairsheds )
{
    foreach ( var_69cef1154b5d5944 in repairsheds )
    {
        radius = int( sqrt( var_69cef1154b5d5944.radiussquared ) );
        var_69cef1154b5d5944.trigger = spawn( "noent_volume_trigger_radius", var_69cef1154b5d5944.origin - ( 0, 0, 200 ), 0, radius, level.sheddata.height );
        var_69cef1154b5d5944.trigger.radiussquared = var_69cef1154b5d5944.radiussquared;
        var_69cef1154b5d5944.var_c65e863a653ca3c7 = 0;
        var_69cef1154b5d5944 thread function_853c3587b64d8fe5( var_69cef1154b5d5944.trigger );
        var_69cef1154b5d5944 thread function_f9c48b87d90a2aef( var_69cef1154b5d5944.trigger );
        
        /#
            thread function_fbc11a7813edc0a2( var_69cef1154b5d5944.trigger );
        #/
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x929e9585, Offset: 0x6ac
// Size: 0x137, Type: bool
function private function_45dcdc40b0b6f206( trigger, vehicle )
{
    time = gettime();
    
    if ( distance2dsquared( vehicle.origin, trigger.origin ) > trigger.radiussquared )
    {
        if ( self.var_f1ee3f9bbc84009 )
        {
            /#
                function_e90e75da43d6045c( "<dev string:xb2>" );
            #/
            
            self.var_f1ee3f9bbc84009 = 0;
            self.var_34a8572d9d76db13 = vehicle.var_64e6b9756c30f33a + getdvarint( @"hash_cc324b5cfea792c3", 45 ) * 1000;
        }
        
        if ( self.var_e81821a6777b40bb )
        {
            /#
                function_e90e75da43d6045c( "<dev string:xd4>" );
            #/
            
            self.var_e81821a6777b40bb = 0;
            self.var_a670580200d319bf = vehicle.lastdamagetime + 5000;
        }
        
        return true;
    }
    
    if ( self.var_34a8572d9d76db13 > time )
    {
        /#
            function_e90e75da43d6045c( "<dev string:xfc>" );
        #/
        
        self.var_f1ee3f9bbc84009 = 1;
        return true;
    }
    else if ( self.var_a670580200d319bf > time )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x114>" );
        #/
        
        self.var_e81821a6777b40bb = 1;
        return true;
    }
    
    return false;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x14f18ea7, Offset: 0x7ec
// Size: 0x158
function private function_853c3587b64d8fe5( trigger )
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.wonder_veh.var_64e6b9756c30f33a ) )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x12a>" );
        #/
        
        waitframe();
        continue;
    }
    
    while ( true )
    {
        vehicle = level.wonder_veh;
        time = gettime();
        
        if ( function_45dcdc40b0b6f206( trigger, vehicle ) )
        {
            waitframe();
            continue;
        }
        
        if ( !self.var_f1ee3f9bbc84009 )
        {
            self.var_e81821a6777b40bb = time < vehicle.lastdamagetime + 5000;
            
            if ( !self.var_e81821a6777b40bb )
            {
                if ( time < vehicle.var_d45be1ebedba5514 + getdvarint( @"hash_21d30cf352d12378", 2500 ) )
                {
                    /#
                        function_e90e75da43d6045c( "<dev string:x160>" );
                    #/
                    
                    self.var_f1ee3f9bbc84009 = 1;
                }
            }
            else
            {
                /#
                    function_e90e75da43d6045c( "<dev string:x17c>" );
                #/
            }
        }
        else if ( vehicle.var_64e6b9756c30f33a + getdvarint( @"hash_cc324b5cfea792c3", 45 ) * 1000 < time )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x194>" );
            #/
            
            self.var_f1ee3f9bbc84009 = 0;
            vehicle.lastdamagetime = time - 5000;
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x55b4e1f7, Offset: 0x94c
// Size: 0x279
function private function_f9c48b87d90a2aef( trigger )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.1;
        vehicle = level.wonder_veh;
        
        if ( !( isdefined( vehicle ) && isdefined( vehicle.health ) ) || !vehicle.maxhealth )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x1ac>" );
            #/
            
            continue;
        }
        
        vehicle.fixpercentage = vehicle.health / vehicle.maxhealth;
        
        if ( !utility::flag( "enable_shed_repair" ) )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x1e2>" );
            #/
            
            continue;
        }
        
        /#
            function_e90e75da43d6045c( "<dev string:x203>" );
        #/
        
        if ( !vehicle vehicle::is_vehicle() || !isdefined( vehicle.origin ) )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x21d>" );
            #/
            
            continue;
        }
        
        if ( vehicle vehicle::get_ref() != %"hash_62a07b56f29782f5" )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x254>" );
            #/
            
            continue;
        }
        
        if ( !ispointinvolume( vehicle.origin, trigger ) )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x266>" );
            #/
            
            continue;
        }
        
        if ( vehicle.var_ac12f393716b424b )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x28c>" );
            #/
            
            continue;
        }
        
        if ( self.var_e81821a6777b40bb || self.var_f1ee3f9bbc84009 )
        {
            if ( self.var_e81821a6777b40bb )
            {
                /#
                    function_e90e75da43d6045c( "<dev string:x2a8>" );
                #/
            }
            else
            {
                /#
                    function_e90e75da43d6045c( "<dev string:x2d1>" );
                #/
            }
            
            if ( !self.var_c65e863a653ca3c7 )
            {
                thread function_3400dad8da46329e( vehicle );
            }
            
            continue;
        }
        
        if ( level utility::flag( "salvage_repair_pluto" ) )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x2fc>" );
            #/
            
            continue;
        }
        
        if ( vehicle.health >= vehicle.maxhealth )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x318>" );
            #/
            
            continue;
        }
        
        if ( distance2dsquared( vehicle.origin, trigger.origin ) > trigger.radiussquared )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x33c>" );
            #/
            
            continue;
        }
        
        vehicle.var_64e6b9756c30f33a = gettime();
        thread function_18cd0f411baaf2ea( vehicle, trigger.origin, trigger.radiussquared );
    }
}

// Namespace pluto_veh
// Params 3, eflags: 0x4
// Checksum 0x3cfcc411, Offset: 0xbcd
// Size: 0xad, Type: bool
function private function_c460094a4d0fef5d( vehicle, point, sqradius )
{
    if ( distance2dsquared( vehicle.origin, point ) > sqradius )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x35f>" );
        #/
        
        return false;
    }
    
    if ( vehicle.health >= vehicle.maxhealth )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x38a>" );
        #/
        
        return false;
    }
    
    if ( self.var_e81821a6777b40bb )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x3b3>" );
        #/
        
        return false;
    }
    
    if ( self.var_f1ee3f9bbc84009 )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x3dc>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace pluto_veh
// Params 3, eflags: 0x4
// Checksum 0x88119063, Offset: 0xc83
// Size: 0x19c
function private function_18cd0f411baaf2ea( vehicle, point, sqradius )
{
    level endon( #"game_ended" );
    
    /#
        function_e90e75da43d6045c( "<dev string:x407>" );
    #/
    
    vehicle.var_ac12f393716b424b = 1;
    vehicle thread function_e8e44af278d37592();
    
    if ( vehicle isscriptable() )
    {
        vehicle setscriptablepartstate( "repair_audio", "on" );
        vehicle setscriptablepartstate( "garage_repair_vfx", "on" );
    }
    
    while ( function_c460094a4d0fef5d( vehicle, point, sqradius ) )
    {
        vehicle function_5c7765b200e8c1d5();
        set_vehicle_usable_state( vehicle, 1, 0 );
        vehicle vehicle_damage::add_health( vehicle.maxhealth / level.sheddata.var_30de6c56297ed04b * level.sheddata.var_938a1b3e201fddd6 );
        wait level.sheddata.var_938a1b3e201fddd6;
        continue;
    }
    
    if ( vehicle isscriptable() )
    {
        vehicle setscriptablepartstate( "garage_repair_vfx", "off" );
        
        if ( vehicle.health < vehicle.maxhealth )
        {
            vehicle setscriptablepartstate( "repair_audio", "off" );
        }
        else
        {
            vehicle setscriptablepartstate( "repair_audio", "complete" );
        }
    }
    
    /#
        function_e90e75da43d6045c( "<dev string:x425>" );
    #/
    
    if ( vehicle.health < vehicle.maxhealth )
    {
        vehicle.var_d45be1ebedba5514 = gettime();
    }
    
    vehicle.var_ac12f393716b424b = 0;
    self.var_f1ee3f9bbc84009 = 0;
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0xc8ee55c9, Offset: 0xe27
// Size: 0x85
function private function_915cef37956c19fe( show, fixpercentage )
{
    if ( self.is_upgrading )
    {
        return;
    }
    
    if ( show )
    {
        if ( !zm_interaction::function_f575e8a9ce7d5b58() && vehicle::is_in_vehicle() )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x43e>" );
            #/
            
            zm_interaction::function_307c21197e0798d4( &"zm_sat_firefly/pluto_cool_title" );
            zm_interaction::function_45e51da251cd5e3a( fixpercentage );
        }
        
        return;
    }
    
    if ( zm_interaction::function_f575e8a9ce7d5b58() )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x457>" );
        #/
        
        zm_interaction::function_7c7ed762cd4d0333();
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x20c926e1, Offset: 0xeb4
// Size: 0x7b
function private function_5d40c7fd9e0073d6( show, fixpercentage )
{
    if ( self.is_upgrading )
    {
        return;
    }
    
    if ( show )
    {
        if ( !zm_interaction::function_f575e8a9ce7d5b58() )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x46f>" );
            #/
            
            zm_interaction::function_307c21197e0798d4( &"zm_sat_firefly/pluto_damage_title" );
        }
        
        zm_interaction::function_45e51da251cd5e3a( fixpercentage );
        return;
    }
    
    if ( zm_interaction::function_f575e8a9ce7d5b58() )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x486>" );
        #/
        
        zm_interaction::function_7c7ed762cd4d0333();
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0xab8f543f, Offset: 0xf37
// Size: 0x85
function private function_1dc65b79125b259e( show, fixpercentage )
{
    if ( self.is_upgrading )
    {
        return;
    }
    
    if ( show )
    {
        if ( !zm_interaction::function_f575e8a9ce7d5b58() && vehicle::is_in_vehicle() )
        {
            /#
                function_e90e75da43d6045c( "<dev string:x49c>" );
            #/
            
            zm_interaction::function_307c21197e0798d4( &"zm_sat_firefly/pluto_r_caption" );
            zm_interaction::function_45e51da251cd5e3a( fixpercentage );
        }
        
        return;
    }
    
    if ( zm_interaction::function_f575e8a9ce7d5b58() )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x4b0>" );
        #/
        
        zm_interaction::function_7c7ed762cd4d0333();
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xd2244670, Offset: 0xfc4
// Size: 0xec
function private function_e8e44af278d37592( vehicle )
{
    level endon( #"game_ended" );
    
    while ( self.var_ac12f393716b424b )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ].vehicle.bundlename == %"hash_62a07b56f29782f5" )
            {
                level.players[ i ] function_93eb821a3c11d075( 1, self.fixpercentage );
                continue;
            }
            
            level.players[ i ] function_93eb821a3c11d075( 0, self.fixpercentage );
        }
        
        waitframe();
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] function_93eb821a3c11d075( 0, self.fixpercentage );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x8a8c6992, Offset: 0x10b8
// Size: 0x1d2
function private function_3400dad8da46329e( vehicle )
{
    level endon( #"game_ended" );
    
    while ( self.var_f1ee3f9bbc84009 )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ].vehicle.bundlename == %"hash_62a07b56f29782f5" )
            {
                level.players[ i ] function_915cef37956c19fe( 1, vehicle.fixpercentage );
                continue;
            }
            
            level.players[ i ] function_915cef37956c19fe( 0, vehicle.fixpercentage );
        }
        
        function_8bfa93984ea696b0( vehicle );
        self.var_c65e863a653ca3c7 = 1;
        waitframe();
    }
    
    while ( self.var_e81821a6777b40bb )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ].vehicle.bundlename == %"hash_62a07b56f29782f5" )
            {
                level.players[ i ] function_5d40c7fd9e0073d6( 1, vehicle.fixpercentage );
                continue;
            }
            
            level.players[ i ] function_5d40c7fd9e0073d6( 0, vehicle.fixpercentage );
        }
        
        self.var_c65e863a653ca3c7 = 1;
        waitframe();
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] function_915cef37956c19fe( 0, vehicle.fixpercentage );
        level.players[ i ] function_5d40c7fd9e0073d6( 0, vehicle.fixpercentage );
    }
    
    self.var_c65e863a653ca3c7 = 0;
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x6167f815, Offset: 0x1292
// Size: 0x31
function private function_93eb821a3c11d075( visible, fixpercentage )
{
    /#
        function_e90e75da43d6045c( "<dev string:x4c3>" + visible );
    #/
    
    function_1dc65b79125b259e( visible, fixpercentage );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xd61179b7, Offset: 0x12cb
// Size: 0x14
function private function_791504b7932b7a7d( var_d74b0bb7139b61ef )
{
    return var_d74b0bb7139b61ef * 0.001;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x642cbe95, Offset: 0x12e8
// Size: 0xf6
function private function_8bfa93984ea696b0( vehicle )
{
    currenttime = function_791504b7932b7a7d( gettime() );
    var_903c9aa679ee4fe3 = function_791504b7932b7a7d( vehicle.var_64e6b9756c30f33a );
    var_d53798471ea8e125 = currenttime - var_903c9aa679ee4fe3;
    secsleft = ceil( var_903c9aa679ee4fe3 + getdvarint( @"hash_cc324b5cfea792c3", 45 ) - currenttime );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] zm_interaction::function_f575e8a9ce7d5b58() && level.players[ i ] vehicle::is_in_vehicle() )
        {
            level.players[ i ] zm_interaction::function_307c21197e0798d4( &"zm_sat_firefly/pluto_cool_title", secsleft );
            level.players[ i ] zm_interaction::function_45e51da251cd5e3a( vehicle.fixpercentage );
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xeaa7466f, Offset: 0x13e6
// Size: 0xa1
function private function_5c7765b200e8c1d5()
{
    self.fixpercentage = self.health / self.maxhealth;
    
    /#
        function_e90e75da43d6045c( "<dev string:x4e3>" + self.fixpercentage );
    #/
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] zm_interaction::function_f575e8a9ce7d5b58() && level.players[ i ] vehicle::is_in_vehicle() )
        {
            level.players[ i ] zm_interaction::function_45e51da251cd5e3a( self.fixpercentage );
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xd42447ed, Offset: 0x148f
// Size: 0x6c
function private function_999744ffddb8cad3()
{
    currenttime = gettime();
    
    if ( currenttime - 4000 > self.var_804ff35085534191 )
    {
        /#
            function_e90e75da43d6045c( "<dev string:x4f5>" );
        #/
        
        var_9436e120295fed17 = "veh_pluto_repair_start";
        playsoundatpos( self.origin + ( 0, 0, 75 ), var_9436e120295fed17 );
        self.var_804ff35085534191 = currenttime;
    }
}

/#

    // Namespace pluto_veh
    // Params 1, eflags: 0x4
    // Checksum 0xb02c3df6, Offset: 0x1503
    // Size: 0x67, Type: dev
    function private function_fbc11a7813edc0a2( trigger )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_a2efa748b708441d" ) == 1 )
            {
                sphere( trigger.origin, level.sheddata.radius, ( 1, 1, 1 ) );
            }
            
            waitframe();
        }
    }

    // Namespace pluto_veh
    // Params 1, eflags: 0x4
    // Checksum 0x5ff11ec, Offset: 0x1572
    // Size: 0x29, Type: dev
    function private function_e90e75da43d6045c( message )
    {
        if ( getdvarint( @"hash_30a47bd07405bb23" ) == 1 )
        {
            println( message );
        }
    }

#/
