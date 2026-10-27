// script_5ebd466e28731b7a  (hash_5ebd466e28731b7a.gscc) (size: 8605 Bytes / 0x219d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xadd1f96 (182263702)
// size ...... 8605 (0x219d)
// includes .. 9   (offset: 0x2029)
// strings ... 7   (offset: 0x2071)
// dev strs .. 15  (offset: 0x20e9)
// exports ... 23  (offset: 0x143d)
// cseg ...... 0xb0 + 0x138d (0x143d)
// imports ... 68  (offset: 0x17d5)
// animtree1 . 0   (offset: 0x219d)
// animtree2 . 0   (offset: 0x219d)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;

#namespace namespace_f1c6181bdb874edd;

// Namespace namespace_f1c6181bdb874edd
// Params 0
// Checksum 0xf3ef0e50, Offset: 0xce
// Size: 0x45
function init()
{
    if ( !getdvarint( @"hash_37451e895de4a1ec", 1 ) )
    {
        return;
    }
    
    level callback::add( #"player_spawned", &onplayerspawned );
    
    /#
        level callback::add( #"player_connect", &onplayerconnect );
    #/
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x56088ef5, Offset: 0x11b
// Size: 0xca
function private function_4a98db0049304301( taskid )
{
    bot = self;
    chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
    
    if ( !chosenvehicle )
    {
        return anim.failure;
    }
    
    vehicle = bot vehicle::get_vehicle();
    
    if ( vehicle )
    {
        if ( vehicle == chosenvehicle )
        {
            return anim.success;
        }
        else
        {
            return anim.failure;
        }
    }
    
    if ( distancesquared( bot.origin, chosenvehicle.origin ) > 122500 )
    {
        return anim.failure;
    }
    
    if ( !bot function_c82467c1b8a89e72( chosenvehicle ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x6a44946d, Offset: 0x1ee
// Size: 0xb1
function private function_7e946cd19abff23c( taskid )
{
    bot = self;
    
    if ( bot vehicle::is_in_vehicle( 1 ) )
    {
        return anim.success;
    }
    
    chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
    
    if ( !chosenvehicle )
    {
        return anim.failure;
    }
    
    owner = bot function_e89b4e6d9db8a30();
    
    if ( owner )
    {
        return anim.failure;
    }
    
    bot.entervehiclestarttime = gettime();
    vehicle_interact::scriptable_used( chosenvehicle getlinkedscriptableinstance(), "single", "vehicle_use", bot, 0 );
    return anim.success;
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x4a3ed5df, Offset: 0x2a8
// Size: 0x43
function private function_7316848db7de4b91( taskid )
{
    bot = self;
    bot.entervehiclestarttime = undefined;
    bot.var_121d4259a71cc3f3 = undefined;
    bot.var_a12d0f1e3ab1254d = undefined;
    return anim.success;
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x1eb2269, Offset: 0x2f4
// Size: 0x1fd
function private function_34741902841a624f( taskid )
{
    bot = self;
    currenttime = gettime();
    
    if ( bot.entervehiclestarttime && currenttime - bot.entervehiclestarttime < 2000 )
    {
        return anim.running;
    }
    
    if ( currenttime < bot.var_121d4259a71cc3f3 )
    {
        return anim.running;
    }
    
    if ( currenttime < bot.var_a12d0f1e3ab1254d )
    {
        return anim.running;
    }
    
    if ( bot vehicle::is_in_vehicle( 0 ) )
    {
        vehicle = bot vehicle::get_vehicle();
        assert( vehicle );
        bot.var_121d4259a71cc3f3 = undefined;
        bot.var_a12d0f1e3ab1254d = undefined;
        
        if ( vehicle.navobstacleid )
        {
            bot.var_a12d0f1e3ab1254d = currenttime + 2000;
            vehicle vehicle_code::vehicle_disable_navobstacles();
        }
        
        if ( vehicle_occupancy::function_3080323254ba6900( bot ) )
        {
            var_d35d20dc4017dcf1 = 0;
            
            if ( vehicle hascomponent( "p2p" ) )
            {
                var_d35d20dc4017dcf1 = 1;
                vehicle removecomponent( "p2p" );
            }
            
            if ( vehicle hascomponent( "path" ) )
            {
                var_d35d20dc4017dcf1 = 1;
                vehicle removecomponent( "path" );
            }
            
            if ( var_d35d20dc4017dcf1 )
            {
                bot.var_121d4259a71cc3f3 = currenttime + 500;
            }
        }
        
        if ( bot.var_a12d0f1e3ab1254d || bot.var_121d4259a71cc3f3 )
        {
            return anim.running;
        }
        
        vehicle thread function_1f58095767088a84();
        return anim.success;
    }
    
    chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
    
    if ( !chosenvehicle )
    {
        return anim.failure;
    }
    
    if ( bot.entervehiclestarttime && gettime() - bot.entervehiclestarttime > 5000 )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Namespace namespace_f1c6181bdb874edd
// Params 0, eflags: 0xc
// Checksum 0xc3fe15be, Offset: 0x4fa
// Size: 0x152
function private function_1f58095767088a84()
{
    self notify( #"hash_cbf1fbff0a5e235b" );
    self endon( #"hash_cbf1fbff0a5e235b" );
    vehicle = self;
    level endon( #"game_ended" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        if ( !vehicle )
        {
            return;
        }
        
        driver = vehicle_occupancy::get_driver( vehicle, 1 );
        
        if ( !driver || !isbot( driver ) )
        {
            if ( vehicle hascomponent( "p2p" ) )
            {
                vehicle removecomponent( "p2p" );
            }
            
            if ( vehicle hascomponent( "path" ) )
            {
                vehicle removecomponent( "path" );
            }
        }
        
        var_b34ca244350af13f = 0;
        occupants = vehicle_occupancy::function_b6077e40739ebc4b( vehicle );
        
        foreach ( occupant in occupants )
        {
            if ( isbot( occupant ) )
            {
                var_b34ca244350af13f = 1;
                break;
            }
        }
        
        if ( !var_b34ca244350af13f )
        {
            vehicle vehicle_code::vehicle_enable_navobstacles();
            return;
        }
        
        wait 0.5;
    }
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x9c4fbd4e, Offset: 0x654
// Size: 0x27
function private onplayerspawned( params )
{
    if ( !isbot( self ) && !isautopilot( self ) )
    {
        return;
    }
    
    thread function_e35ebca8daebe97b();
}

// Namespace namespace_f1c6181bdb874edd
// Params 0, eflags: 0xc
// Checksum 0x330473e1, Offset: 0x683
// Size: 0x290
function private function_e35ebca8daebe97b()
{
    self notify( #"hash_ebe875d09e59cc89" );
    self endon( #"hash_ebe875d09e59cc89" );
    level endon( #"game_ended" );
    bot = self;
    bot endon( #"death_or_disconnect" );
    utility::flag_wait( "vehicle_init_done" );
    
    while ( true )
    {
        wait 1;
        
        if ( !bot._blackboard )
        {
            continue;
        }
        
        if ( bot isvehicleactive() )
        {
            if ( function_f5de5cea0dddfc57() )
            {
                bot._blackboard.var_e6eda0c6e95111e7 = 1;
            }
            
            continue;
        }
        
        owner = bot function_e89b4e6d9db8a30();
        
        if ( owner )
        {
            bot._blackboard.var_3767ccaf1c931fbc = undefined;
            continue;
        }
        
        chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
        teammatevehicle = bot function_bc559594818b3cf9();
        
        if ( chosenvehicle && bot function_67c82b6448c0a508( chosenvehicle ) )
        {
            if ( bot._blackboard.var_71ebeb614655ffa0 == 0 && teammatevehicle && !bot function_3bf148a82c10cf52( chosenvehicle ) )
            {
                bot._blackboard.var_3767ccaf1c931fbc = teammatevehicle;
                continue;
            }
            
            continue;
        }
        
        if ( teammatevehicle )
        {
            bot._blackboard.var_3767ccaf1c931fbc = teammatevehicle;
            continue;
        }
        
        if ( chosenvehicle )
        {
            bot._blackboard.var_3767ccaf1c931fbc = undefined;
        }
        
        candidatevehicles = [];
        nearbyvehicles = getentarrayinradius( "script_vehicle", #classname, bot.origin, ( level.var_d4909c0acc55763c.vehicle_checkradius ?? 25.4 ) * 39.3701 );
        
        foreach ( vehicle in nearbyvehicles )
        {
            if ( bot function_67c82b6448c0a508( vehicle ) )
            {
                candidatevehicles[ candidatevehicles.size ] = vehicle;
            }
        }
        
        if ( candidatevehicles.size == 0 )
        {
            continue;
        }
        
        candidatevehicles = sortbydistance( candidatevehicles, bot.origin );
        bot._blackboard.var_3767ccaf1c931fbc = candidatevehicles[ 0 ];
    }
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x2d565d36, Offset: 0x91b
// Size: 0xde, Type: bool
function private function_3bf148a82c10cf52( vehicle )
{
    if ( !vehicle )
    {
        return false;
    }
    
    bot = self;
    nearbyteammates = bot function_84b9716a1ed54a27();
    
    foreach ( teammate in nearbyteammates )
    {
        if ( teammate vehicle::get_vehicle() == vehicle )
        {
            return true;
        }
        
        if ( ( isbot( teammate ) || isautopilot( teammate ) ) && teammate._blackboard.var_3767ccaf1c931fbc == vehicle )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_f1c6181bdb874edd
// Params 0, eflags: 0x4
// Checksum 0x52d473b3, Offset: 0xa02
// Size: 0x133
function private function_bc559594818b3cf9()
{
    bot = self;
    nearbyteammates = bot function_84b9716a1ed54a27();
    
    foreach ( teammate in nearbyteammates )
    {
        var_760388c47a9c81b4 = 0;
        vehicle = teammate vehicle::get_vehicle();
        
        if ( !vehicle && ( isbot( teammate ) || isautopilot( teammate ) ) && teammate._blackboard.var_3767ccaf1c931fbc )
        {
            vehicle = teammate._blackboard.var_3767ccaf1c931fbc;
            var_760388c47a9c81b4 = 1;
        }
        
        if ( vehicle && bot function_67c82b6448c0a508( vehicle ) )
        {
            if ( var_760388c47a9c81b4 )
            {
                availableseatids = vehicle_occupancy::function_41d81defa67de264( vehicle, bot );
                
                if ( !availableseatids || availableseatids.size < 2 )
                {
                    continue;
                }
            }
            
            return vehicle;
        }
    }
}

// Namespace namespace_f1c6181bdb874edd
// Params 0, eflags: 0x4
// Checksum 0xe8be98df, Offset: 0xb3e
// Size: 0xf1
function private function_84b9716a1ed54a27()
{
    bot = self;
    var_5531ae945b7d45ee = [];
    radius = ( level.var_d4909c0acc55763c.var_772b941ad34e44df ?? 25.4 ) * 39.3701;
    teammates = getplayersinradius( bot.origin, radius, radius, 1, bot, bot.team );
    
    foreach ( player in teammates )
    {
        if ( player != bot && bot_isvalidplayer( player ) )
        {
            var_5531ae945b7d45ee[ var_5531ae945b7d45ee.size ] = player;
        }
    }
    
    return var_5531ae945b7d45ee;
}

// Namespace namespace_f1c6181bdb874edd
// Params 0, eflags: 0x4
// Checksum 0xa1672158, Offset: 0xc38
// Size: 0x4b, Type: bool
function private function_f5de5cea0dddfc57()
{
    bot = self;
    vehicle = bot vehicle::get_vehicle();
    
    if ( !vehicle )
    {
        return false;
    }
    
    if ( !vehicle_code::vehicle_isalive( vehicle ) || vehicle vehicle_damage::get_state() == "heavy" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0xc0d2b0a0, Offset: 0xc8c
// Size: 0x185, Type: bool
function private function_c82467c1b8a89e72( vehicle )
{
    bot = self;
    
    if ( !vehicle_code::vehicle_isalive( vehicle ) || vehicle vehicle_damage::get_state() == "heavy" )
    {
        return false;
    }
    
    if ( vehicle vehicle_ai::has_riders() )
    {
        return false;
    }
    
    if ( !vehicle vehicle_isphysveh() || !vehicle supportscomponent( "p2p" ) || !vehicle supportscomponent( "path" ) )
    {
        return false;
    }
    
    if ( !vehicle_occupancy::instance_is_registered( vehicle ) )
    {
        return false;
    }
    
    if ( !vehicle_interact::function_a6656fc74b98d1c9( bot, vehicle ) )
    {
        return false;
    }
    
    if ( !vehicle vehicle::is_ground_vehicle() )
    {
        if ( !( vehicle vehicle::is_boat() && level.var_d4909c0acc55763c.var_6c44618fab69148c ) )
        {
            return false;
        }
    }
    
    occupants = vehicle_occupancy::function_b6077e40739ebc4b( vehicle );
    
    foreach ( occupant in occupants )
    {
        if ( isplayer( occupant ) && occupant.team != bot.team )
        {
            return false;
        }
    }
    
    availableseatids = vehicle_occupancy::function_41d81defa67de264( vehicle, bot );
    
    if ( !availableseatids || availableseatids.size <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f1c6181bdb874edd
// Params 1, eflags: 0x4
// Checksum 0x8bb0f437, Offset: 0xe1a
// Size: 0x110, Type: bool
function private function_67c82b6448c0a508( vehicle )
{
    if ( distancesquared( self.origin, vehicle.origin ) > ( level.var_d4909c0acc55763c.vehicle_checkradius ?? 25.4 ) * 39.3701 * ( level.var_d4909c0acc55763c.vehicle_checkradius ?? 25.4 ) * 39.3701 )
    {
        return false;
    }
    
    if ( !function_c82467c1b8a89e72( vehicle ) )
    {
        return false;
    }
    
    var_5a1739ca38af324c = self._blackboard.var_6f135432b0b570;
    var_4e5539f0da5e029b = self._blackboard.var_f6d9700a95307f3f;
    
    if ( var_5a1739ca38af324c && var_4e5539f0da5e029b && var_5a1739ca38af324c != ( 0, 0, 0 ) )
    {
        if ( distancesquared( vehicle.origin, var_5a1739ca38af324c ) < 100 && vectordot( anglestoforward( vehicle.angles ), var_4e5539f0da5e029b ) > 0.906308 )
        {
            return false;
        }
    }
    
    return true;
}

/#

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0xc59999e4, Offset: 0xf33
    // Size: 0x2a, Type: dev
    function private onplayerconnect( params )
    {
        if ( !isbot( self ) && !isautopilot( self ) )
        {
            return;
        }
        
        thread function_79c93ad382b3d37d();
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 0, eflags: 0x4
    // Checksum 0xc54f7144, Offset: 0xf65
    // Size: 0x116, Type: dev
    function private function_79c93ad382b3d37d()
    {
        bot = self;
        wait 1;
        
        if ( !bot )
        {
            return;
        }
        
        basepath = "<dev string:x24>" + bot.name + "<dev string:x35>";
        devgui::function_9082edeb5db93280( basepath );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37>", "<dev string:x3e>" + bot getentitynumber(), &function_2b1d5438d3bbe0de );
        devgui::function_cd4e263c1f3018ae( "<dev string:x46>", "<dev string:x4f>" + bot getentitynumber(), &function_9b32545c919eec92 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x59>", "<dev string:x68>" + bot getentitynumber(), &function_29db01c545076f2a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x78>", "<dev string:x7d>" + bot getentitynumber(), &function_abbb8654a3d57703 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x83>", "<dev string:x88>" + bot getentitynumber(), &function_863f516a37d4755b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8e>", "<dev string:x94>" + bot getentitynumber(), &function_bc642117f8da0c03 );
        devgui::function_77df7fe7dd273e10();
        bot waittill( #"disconnect" );
        adddebugcommand( "<dev string:x9b>" + basepath );
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0x9b78bf9d, Offset: 0x1083
    // Size: 0xb6, Type: dev
    function private function_2b1d5438d3bbe0de( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        entitynumber = int( params[ 0 ] );
        bot = getentbynum( entitynumber );
        
        if ( !bot )
        {
            return;
        }
        
        chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
        
        if ( chosenvehicle )
        {
            bot._blackboard.var_4507e977ec476720 = 1;
            bot._blackboard.var_ea1d1dad4ccf00a2 = chosenvehicle.origin;
            bot._blackboard.var_8333432b91c644ca = 1;
        }
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0x18579ef8, Offset: 0x1141
    // Size: 0xcb, Type: dev
    function private function_9b32545c919eec92( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        entitynumber = int( params[ 0 ] );
        bot = getentbynum( entitynumber );
        
        if ( !bot )
        {
            return;
        }
        
        host = level.players[ 0 ];
        chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
        
        if ( chosenvehicle )
        {
            bot._blackboard.var_4507e977ec476720 = 3;
            bot._blackboard.var_ea1d1dad4ccf00a2 = host.origin;
            bot._blackboard.var_8333432b91c644ca = 1;
        }
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0xc54ede73, Offset: 0x1214
    // Size: 0xcb, Type: dev
    function private function_29db01c545076f2a( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        entitynumber = int( params[ 0 ] );
        bot = getentbynum( entitynumber );
        
        if ( !bot )
        {
            return;
        }
        
        host = level.players[ 0 ];
        chosenvehicle = bot._blackboard.var_3767ccaf1c931fbc;
        
        if ( chosenvehicle )
        {
            bot._blackboard.var_4507e977ec476720 = 2;
            bot._blackboard.var_ea1d1dad4ccf00a2 = host.origin;
            bot._blackboard.var_8333432b91c644ca = 1;
        }
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0xb4e2f56b, Offset: 0x12e7
    // Size: 0x66, Type: dev
    function private function_abbb8654a3d57703( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        entitynumber = int( params[ 0 ] );
        bot = getentbynum( entitynumber );
        
        if ( !bot )
        {
            return;
        }
        
        if ( bot vehicle::is_in_vehicle( 1 ) )
        {
            bot._blackboard.var_3e6c966a241d8dff = 1;
        }
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0xb4e2f56b, Offset: 0x1355
    // Size: 0x66, Type: dev
    function private function_863f516a37d4755b( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        entitynumber = int( params[ 0 ] );
        bot = getentbynum( entitynumber );
        
        if ( !bot )
        {
            return;
        }
        
        if ( bot vehicle::is_in_vehicle( 1 ) )
        {
            bot._blackboard.var_e6eda0c6e95111e7 = 1;
        }
    }

    // Namespace namespace_f1c6181bdb874edd
    // Params 1, eflags: 0x4
    // Checksum 0x1cbb8abb, Offset: 0x13c3
    // Size: 0x7a, Type: dev
    function private function_bc642117f8da0c03( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        entitynumber = int( params[ 0 ] );
        bot = getentbynum( entitynumber );
        
        if ( !bot )
        {
            return;
        }
        
        if ( bot vehicle::is_in_vehicle( 1 ) )
        {
            bot._blackboard.var_632bf0a5b36efd37 = !bot._blackboard.var_632bf0a5b36efd37;
        }
    }

#/
