// script_5757e9f873fc5cf3  (hash_5757e9f873fc5cf3.gscc) (size: 5194 Bytes / 0x144a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa72e2c53 (2804821075)
// size ...... 5194 (0x144a)
// includes .. 15  (offset: 0x136a)
// strings ... 7   (offset: 0x13e2)
// dev strs .. 1   (offset: 0x143e)
// exports ... 11  (offset: 0xba2)
// cseg ...... 0xc9 + 0xad9 (0xba2)
// imports ... 53  (offset: 0xd5a)
// animtree1 . 0   (offset: 0x144a)
// animtree2 . 0   (offset: 0x144a)
#using script_5c65d346ac65390c;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_spawn;
#using scripts\mp\br\gametypes\br_dmz_extract;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_item;
#using scripts\mp\outofbounds;
#using scripts\mp\pickups_scriptable;

#namespace namespace_6fe0f1cba107e99;

// Namespace namespace_6fe0f1cba107e99
// Params 0
// Checksum 0x979b12a6, Offset: 0xe7
// Size: 0x61
function init()
{
    if ( getdvarint( @"scr_emptypalfa_enable", 1 ) != 1 )
    {
        return;
    }
    
    level.var_1597e9e336c903e4 = getdvarint( @"hash_62ff9f6d45bb6187", 1 );
    level.palfaspawns = vehicle_spawn::get_spawn_structs( %"hash_1dd941f8f4026e3" );
    level.var_e7f9fdc95f1c95b6 = utility::getstructarray( "palfa_fuel_spawn", "targetname" );
}

// Namespace namespace_6fe0f1cba107e99
// Params 0
// Checksum 0x9e9426b6, Offset: 0x150
// Size: 0x42e
function spawnpalfa()
{
    if ( getdvarint( @"scr_emptypalfa_enable", 1 ) != 1 )
    {
        return;
    }
    
    if ( !isdefined( level.palfaspawns ) || level.palfaspawns.size == 0 || !isdefined( level.var_e7f9fdc95f1c95b6 ) || level.var_e7f9fdc95f1c95b6.size == 0 )
    {
        return;
    }
    
    utility::registersharedfunc( 23395, #"pickedUp", &function_cddaabe218774dfa );
    palfa = vehicle::spawn( %"hash_1dd941f8f4026e3", utility::array_random( level.palfaspawns ) );
    palfa.fuel = 0;
    palfa.var_1f4f9d64c04f05db = 1;
    level.emptypalfa = palfa;
    
    if ( game_utility::getgametype() == "dmz" )
    {
        outofbounds::enableoobimmunity( palfa );
        palfa.onStartRiding = &function_22092af35f9a6070;
        palfa.onEndRiding = &function_43f304a28e771643;
        palfa.ontouchoob = &function_53517169b97c148d;
    }
    
    /#
        if ( false )
        {
            foreach ( fuelloc in level.var_e7f9fdc95f1c95b6 )
            {
                level thread debug::drawsphere( fuelloc.origin, 300, 10000, ( 1, 0, 0 ) );
            }
        }
    #/
    
    level.var_e7f9fdc95f1c95b6 = utility::array_slice( sortbydistance( level.var_e7f9fdc95f1c95b6, palfa.origin ), level.var_e7f9fdc95f1c95b6.size - 3 );
    
    if ( isdefined( level.wztrain_info ) && isdefined( level.wztrain_info.trains[ "cargo_train" ][ 4 ] ) && isdefined( level.var_acb300d2dc16529f ) )
    {
        struct = level.var_acb300d2dc16529f;
        level.var_e7f9fdc95f1c95b6[ randomint( level.var_e7f9fdc95f1c95b6.size ) ] = struct;
        struct.onmovingtrain = 1;
    }
    
    tospawn = getdvarint( @"scr_emptypalfa_numgascans", 1 );
    
    foreach ( chosen in arrayrandomize( level.var_e7f9fdc95f1c95b6 ) )
    {
        /#
            if ( false )
            {
                level thread debug::drawsphere( chosen.origin, 100, 10000, ( 0, 1, 0 ) );
            }
        #/
        
        if ( common_item::items_isenabled() )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( chosen.origin );
            dropcount = 1;
            fuel = common_item::items_spawnitemfromscriptable( "brloot_gascan_palfa", dropcount, spawnoptions );
            
            if ( isdefined( chosen.traincar ) )
            {
                fuel utility::scriptable_setparententity( chosen.traincar, chosen.origin, chosen.angles );
            }
        }
        else
        {
            fuel = spawnscriptable( "brloot_gascan_palfa", chosen.origin, chosen.angles );
            
            if ( isdefined( chosen.traincar ) )
            {
                fuel utility::scriptable_setparententity( chosen.traincar, chosen.origin, chosen.angles );
            }
            
            pickups::registerscriptableinstance( fuel );
        }
        
        fuel.count = 1;
        fuel.criticalitem = 1;
        fuel.onmovingtrain = chosen.onmovingtrain;
        tospawn -= 1;
        
        if ( tospawn <= 0 )
        {
            return;
        }
    }
}

// Namespace namespace_6fe0f1cba107e99
// Params 1, eflags: 0x4
// Checksum 0xcc463ae4, Offset: 0x586
// Size: 0x38
function private function_22092af35f9a6070( player )
{
    outofbounds::enableoobimmunity( player );
    player.ontouchoob = &function_a1bcc8acfa2996d1;
    thread function_4b71daba517300af( player.team );
}

// Namespace namespace_6fe0f1cba107e99
// Params 1, eflags: 0x4
// Checksum 0xcf545121, Offset: 0x5c6
// Size: 0x47
function private function_4b71daba517300af( team )
{
    wait 4;
    
    if ( isdefined( self ) && self.fuel <= 0 )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"palfa_is_grounded", team );
    }
}

// Namespace namespace_6fe0f1cba107e99
// Params 1, eflags: 0x4
// Checksum 0x7ae9d244, Offset: 0x615
// Size: 0x35
function private function_43f304a28e771643( player )
{
    if ( isdefined( player ) )
    {
        player.ontouchoob = undefined;
        
        if ( !player.extracted )
        {
            outofbounds::disableoobimmunity( player );
        }
    }
}

// Namespace namespace_6fe0f1cba107e99
// Params 2, eflags: 0x4
// Checksum 0x310753bb, Offset: 0x652
// Size: 0x42
function private function_cddaabe218774dfa( scriptable, player )
{
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"palfa_fuel_use", player.team );
}

// Namespace namespace_6fe0f1cba107e99
// Params 0
// Checksum 0xc2f7a763, Offset: 0x69c
// Size: 0xda
function function_e7ea7e530ea2a2e0()
{
    if ( level.var_16c2259e068dc98 )
    {
        return;
    }
    
    level.var_16c2259e068dc98 = 1;
    
    if ( !isdefined( level.emptypalfa ) || level.emptypalfa.fuel <= 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"palfa_refueled", self.team );
        level.emptypalfa thread exfilreminder();
    }
    
    mtx = vehicle::function_a634e7859d837381( self, %"hash_1dd941f8f4026e3" );
    vehicle::set_mtx( level.emptypalfa, mtx );
    level.emptypalfa.var_1f4f9d64c04f05db = undefined;
}

// Namespace namespace_6fe0f1cba107e99
// Params 0, eflags: 0x4
// Checksum 0xad8be28b, Offset: 0x77e
// Size: 0x48
function private exfilreminder()
{
    self endon( #"death" );
    wait 60;
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"palfa_flying_reminder", occupants );
}

// Namespace namespace_6fe0f1cba107e99
// Params 1, eflags: 0x4
// Checksum 0x1ed90160, Offset: 0x7ce
// Size: 0x1c
function private function_a1bcc8acfa2996d1( occupant )
{
    function_53517169b97c148d( level.emptypalfa );
}

// Namespace namespace_6fe0f1cba107e99
// Params 1, eflags: 0x4
// Checksum 0x3cbcdef6, Offset: 0x7f2
// Size: 0x3b0
function private function_53517169b97c148d( heli )
{
    if ( level.var_6c5e6fa6f9176ebe )
    {
        return;
    }
    
    level.var_6c5e6fa6f9176ebe = 1;
    exfilplayers = vehicle_occupancy::function_8ed9bcd8e9ea74f5( heli );
    br_dmz_extract::function_af200e33d843d3a2( exfilplayers );
    heli.endingvehicle = 1;
    vehicles = vehicle_getarrayinradius( heli.origin, 500, 500 );
    
    foreach ( vehicle in vehicles )
    {
        foreach ( occupant in vehicle.occupants )
        {
            if ( isplayer( occupant ) && player::isreallyalive( occupant ) )
            {
                exfilplayers = arraycombineunique( exfilplayers, [ occupant ] );
            }
        }
        
        if ( !vehicle.endingvehicle )
        {
            level thread vehicle::death( vehicle );
        }
    }
    
    heli.exfilpathstarted = 1;
    heli notify( #"hash_cb066c5579020915" );
    info = namespace_258bbdad74becc8::function_2656673ab5dbdb77( exfilplayers, 0, 0, 0, 1 );
    utility::callsharedfunc( "chopper_exfil", "exfil_players", exfilplayers, info );
    vehicle_occupancy::eject_all_occupants( heli );
    waitframe();
    struct = spawnstruct();
    struct.origin = heli.origin;
    struct.angles = heli.angles;
    mtx = heli.mtx;
    vehicle::death( heli );
    newheli = vehicle::spawn( %"hash_1dd941f8f4026e3", struct );
    vehicle_interact::allow_use( newheli, 0 );
    newheli vehicle_damage::set_can_damage( 0 );
    newheli function_d2b8ee2e1275daaf( 1 );
    vehicle::set_mtx( newheli, mtx );
    path = namespace_258bbdad74becc8::function_e49a3b32812fb5f4( newheli, newheli.origin + ( 0, 0, 1000 ) + 5000 * anglestoforward( newheli.angles ), level.chopperexfil.heliheight, 0 );
    path.origin = struct.origin;
    path.angles = struct.angles;
    newheli thread vehicle_paths::vehicle_paths_helicopter( path );
    
    /#
        if ( false )
        {
            pathnode = path;
            
            while ( isdefined( pathnode ) )
            {
                prev = pathnode.origin;
                sphere( pathnode.origin, 200, ( 0, 0, 1 ), 0, 10000 );
                pathnode = pathnode.target;
                
                if ( isdefined( pathnode ) )
                {
                    line( pathnode.origin, prev, ( 0, 0, 1 ), 1, 0, 10000 );
                }
            }
        }
    #/
    
    newheli.var_9dcda86f922283e3 = 1;
    newheli endon( #"death" );
    wait 15;
    level thread vehicle::death( newheli );
}

