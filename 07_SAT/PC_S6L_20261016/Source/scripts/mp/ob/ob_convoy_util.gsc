// scripts\mp\ob\ob_convoy_util.gsc  (hash_5c67a8e3564266df.gscc) (size: 17440 Bytes / 0x4420 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x295774f7 (693597431)
// size ...... 17440 (0x4420)
// includes .. 10  (offset: 0x40a0)
// strings ... 21  (offset: 0x40f0)
// dev strs .. 36  (offset: 0x426c)
// exports ... 37  (offset: 0x2a1c)
// cseg ...... 0x1f8 + 0x2824 (0x2a1c)
// imports ... 135 (offset: 0x2fe4)
// animtree1 . 0   (offset: 0x4420)
// animtree2 . 0   (offset: 0x4420)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\objidpoolmanager;

#namespace ob_convoy_util;

// Namespace ob_convoy_util
// Params 0
// Checksum 0x536fdeac, Offset: 0x216
// Size: 0xe4
function init_vehicle_callback()
{
    if ( level.var_99cdf69284448a5 )
    {
        return;
    }
    
    callbacks[ #"enterEnd" ] = &vehicle_enterend;
    callbacks[ #"exitEnd" ] = &vehicle_exitend;
    bundle = %"hash_3de7997ce7ce8832";
    register_vehicle_callbacks( bundle, callbacks );
    bundle = %"hash_56311b5cc8c94835";
    register_vehicle_callbacks( bundle, callbacks );
    level.ob_traffic_vehicles_group = [];
    
    if ( getdvarint( @"hash_5f8163198f38f41", 1 ) )
    {
        level.traffic_triggers_throttle = throttle::throttle_initialize( "traffic_triggers", 1 );
        level.ob_traffic_triggers = getnoentvolumearray( "CONVOY_TRAFFIC_TRIGGER", #targetname );
        utility::array_thread( level.ob_traffic_triggers, &function_17d81d775f362e3f );
        
        /#
            function_b8b7f62c80e0f4b8();
        #/
    }
    
    level.var_99cdf69284448a5 = 1;
}

// Namespace ob_convoy_util
// Params 2, eflags: 0x4
// Checksum 0xd55e3d8, Offset: 0x302
// Size: 0x89
function private register_vehicle_callbacks( vehicleref, callbacks )
{
    foreach ( key, func in callbacks )
    {
        utility::registersharedfunc( vehicleref, key, func );
    }
}

// Namespace ob_convoy_util
// Params 5, eflags: 0x4
// Checksum 0xd7417434, Offset: 0x393
// Size: 0x4c
function private vehicle_exitend( vehicle, seatid, newseatid, player, data )
{
    if ( data.success )
    {
        vehicle_exitendinternal( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace ob_convoy_util
// Params 5, eflags: 0x4
// Checksum 0x3c103341, Offset: 0x3e7
// Size: 0x16b
function private vehicle_exitendinternal( vehicle, seatid, newseatid, player, data )
{
    if ( vehicle.occupants.size == 0 )
    {
        if ( !isdefined( vehicle.var_1a5d5e09b4d07bd5 ) )
        {
            vehicle.var_1a5d5e09b4d07bd5 = 0;
        }
        
        if ( !vehicle.var_1a5d5e09b4d07bd5 )
        {
            vehicle ob_spawn_cover_nodes();
        }
    }
    
    if ( !data.playerdisconnect )
    {
        success = vehicle_occupancy::move_player_to_exit( vehicle, seatid, newseatid, player, data );
        
        if ( !success )
        {
            if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"handleSuicideFromVehicles" ) )
            {
                [[ utility::getsharedfunc( #"vehicle_occupancy", #"handleSuicideFromVehicles" ) ]]( player );
            }
            else if ( utility::issharedfuncdefined( #"player", #"suicide" ) )
            {
                player utility::callsharedfunc( #"player", #"suicide" );
            }
            else
            {
                player kill();
            }
        }
        
        if ( vehicle.istarget && vehicle.var_ebc1fba7906655b0 && !vehicle.chased )
        {
            objidpoolmanager::objective_playermask_addshowplayer( vehicle.var_ebc1fba7906655b0, player );
        }
    }
    
    vehicle_omnvar::function_1f2d7e52383cc345( vehicle, seatid, newseatid, player );
}

// Namespace ob_convoy_util
// Params 5, eflags: 0x4
// Checksum 0x5ffb0a76, Offset: 0x55a
// Size: 0x4c
function private vehicle_enterend( vehicle, seatid, oldseatid, player, data )
{
    if ( data.success )
    {
        vehicle_enterendinternal( vehicle, seatid, oldseatid, player, data );
    }
}

// Namespace ob_convoy_util
// Params 5, eflags: 0x4
// Checksum 0xeab09d0b, Offset: 0x5ae
// Size: 0x98
function private vehicle_enterendinternal( vehicle, seatid, oldseatid, player, data )
{
    if ( vehicle.var_b2f8e5c576d3e25f.size > 0 )
    {
        vehicle ob_disable_cover_nodes();
    }
    
    if ( vehicle.istarget && vehicle.var_ebc1fba7906655b0 && !vehicle.chased )
    {
        objidpoolmanager::objective_playermask_hidefrom( vehicle.var_ebc1fba7906655b0, player );
    }
    
    vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0x8bc25ee2, Offset: 0x64e
// Size: 0xde
function function_190a050fdcaf678f( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self.var_2f8e34c10b66c791 = ( 0, 0, 0 );
    self.last_position = ( 0, 0, 0 );
    
    while ( true )
    {
        if ( self.origin == self.last_position && self.origin != self.var_2f8e34c10b66c791 )
        {
            ob_spawn_cover_nodes();
        }
        
        if ( self.origin != self.last_position && isdefined( self.var_b2f8e5c576d3e25f ) && self.var_b2f8e5c576d3e25f.size > 0 )
        {
            ob_disable_cover_nodes();
        }
        
        self.last_position = self.origin;
        wait 1;
    }
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0x98d83637, Offset: 0x734
// Size: 0x186
function ob_spawn_cover_nodes()
{
    self.var_b2f8e5c576d3e25f = [];
    
    if ( !getdvarint( @"hash_296b75d39f3b15b3", 1 ) )
    {
        return;
    }
    
    nodes_to_spawn = [];
    
    if ( isdefined( self.model ) )
    {
        nodes_to_spawn = function_1448ce3a67eb70ff( self.model );
    }
    
    foreach ( data in nodes_to_spawn )
    {
        if ( !isdefined( self.angles ) )
        {
            self.angles = ( 0, 0, 0 );
        }
        
        var_12ef0eb32b573cf1 = coordtransform( data[ 0 ], self.origin, self.angles );
        
        if ( !isdefined( findclosesttacpoint( var_12ef0eb32b573cf1 ) ) )
        {
            assertmsg( "<dev string:x24>" + var_12ef0eb32b573cf1 );
            continue;
        }
        
        var_bf3e21e5d4373139 = self.angles + data[ 1 ];
        var_4a1ac098d5898640 = spawncovernode( var_12ef0eb32b573cf1, var_bf3e21e5d4373139, data[ 2 ] );
        
        if ( isdefined( var_4a1ac098d5898640 ) )
        {
            var_4a1ac098d5898640 connectnode();
            self.var_b2f8e5c576d3e25f = arraycombineunique( self.var_b2f8e5c576d3e25f, [ var_4a1ac098d5898640 ] );
        }
    }
    
    if ( self.var_b2f8e5c576d3e25f.size > 0 )
    {
        self.var_1a5d5e09b4d07bd5 = 1;
    }
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0x745f5740, Offset: 0x8c2
// Size: 0x93
function ob_disable_cover_nodes()
{
    foreach ( var_4a1ac098d5898640 in self.var_b2f8e5c576d3e25f )
    {
        var_4a1ac098d5898640 disconnectnode();
        
        if ( var_4a1ac098d5898640 isspawnedcovernode() )
        {
            despawncovernode( var_4a1ac098d5898640 );
        }
    }
    
    self.var_1a5d5e09b4d07bd5 = 0;
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0x5b09050a, Offset: 0x95d
// Size: 0x54
function function_2159092914a60ce0()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    utility::waittill_any( "death", "activity_end" );
    
    if ( isdefined( self ) && isdefined( self.var_b2f8e5c576d3e25f ) && self.var_b2f8e5c576d3e25f.size > 0 )
    {
        ob_disable_cover_nodes();
    }
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0xa9dbc973, Offset: 0x9b9
// Size: 0x76
function function_8d8088d29dcb67a2()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"activity_end" );
    
    while ( true )
    {
        player = function_47c86977a18df38b( level.players, self.origin, 3000 );
        
        if ( !isdefined( player ) )
        {
            break;
        }
        
        wait 1;
    }
    
    if ( self.var_b2f8e5c576d3e25f.size > 0 )
    {
        ob_disable_cover_nodes();
    }
}

// Namespace ob_convoy_util
// Params 1, eflags: 0x4
// Checksum 0x2d121fc5, Offset: 0xa37
// Size: 0x206
function private function_1448ce3a67eb70ff( var_1479f07b528e4ff7 )
{
    nodes_to_spawn = [];
    
    switch ( var_1479f07b528e4ff7 )
    {
        case #"hash_87bb213ae239c335":
            nodes_to_spawn[ 0 ] = [ ( 118, -31, 18 ), ( 0, 180, 0 ), "Cover Left" ];
            nodes_to_spawn[ 1 ] = [ ( 119, 30, 18 ), ( 0, 180, 0 ), "Cover Right" ];
            nodes_to_spawn[ 2 ] = [ ( 86, -66, 18 ), ( 0, 90, 0 ), "Cover Right" ];
            nodes_to_spawn[ 3 ] = [ ( 85, 64, 18 ), ( 0, 270, 0 ), "Cover Left" ];
            nodes_to_spawn[ 4 ] = [ ( -89, 64, 18 ), ( 0, 270, 0 ), "Cover Right" ];
            nodes_to_spawn[ 5 ] = [ ( -120, 31, 18 ), ( 0, 0, 0 ), "Cover Left" ];
            nodes_to_spawn[ 6 ] = [ ( -126, -31, 18 ), ( 0, 0, 0 ), "Cover Right" ];
            nodes_to_spawn[ 7 ] = [ ( -92, -66, 18 ), ( 0, 90, 0 ), "Cover Left" ];
            break;
        case #"hash_d44cb989edc40ab3":
            nodes_to_spawn[ 0 ] = [ ( 0, 0, 18 ), ( 0, 0, 0 ), "Exposed" ];
        default:
            break;
    }
    
    return nodes_to_spawn;
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0x2afdb38a, Offset: 0xc46
// Size: 0x4a
function function_1b365c78e86f6916( vehicle )
{
    if ( !level.ob_reinforce_vehicles )
    {
        level.ob_reinforce_vehicles = [];
    }
    
    level.ob_reinforce_vehicles[ level.ob_reinforce_vehicles.size ] = vehicle;
    vehicle vehicle_turnengineon();
    vehicle function_d8119f3de8eaa9c9();
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0xa60dfd57, Offset: 0xc98
// Size: 0x3b
function function_d8119f3de8eaa9c9()
{
    level endon( #"game_ended" );
    utility::waittill_any( "death", "unloading", "entitydeleted" );
    level.ob_reinforce_vehicles = arrayremove( level.ob_reinforce_vehicles, self );
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0x9c657823, Offset: 0xcdb
// Size: 0x54
function function_8ccf719b775fd5a0( vehicles )
{
    var_e814baa69305ee8a = spawnstruct();
    var_e814baa69305ee8a.vehicles = arraycopy( vehicles );
    var_e814baa69305ee8a.traffic_paused = 0;
    level.ob_traffic_vehicles_group[ level.ob_traffic_vehicles_group.size ] = var_e814baa69305ee8a;
    return var_e814baa69305ee8a;
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0x547f3832, Offset: 0xd38
// Size: 0x31
function function_27eb33c611286cd9( var_e814baa69305ee8a )
{
    level.ob_traffic_vehicles_group = arrayremove( level.ob_traffic_vehicles_group, var_e814baa69305ee8a );
    var_e814baa69305ee8a notify( #"vehicle_group_removed" );
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0xff84e937, Offset: 0xd71
// Size: 0xc5
function ob_vehicle_group_pause( var_e814baa69305ee8a )
{
    var_e814baa69305ee8a.origin_speed = var_e814baa69305ee8a.vehicles[ 0 ] function_24e10bf6894fa869( "p2p", "manualSpeed" );
    
    foreach ( vehicle in var_e814baa69305ee8a.vehicles )
    {
        vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
    }
    
    var_e814baa69305ee8a.traffic_paused = 1;
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0x58827991, Offset: 0xe3e
// Size: 0xa7
function ob_vehicle_group_resume( var_e814baa69305ee8a )
{
    foreach ( vehicle in var_e814baa69305ee8a.vehicles )
    {
        vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", var_e814baa69305ee8a.origin_speed );
    }
    
    var_e814baa69305ee8a.traffic_paused = 0;
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0xd18f9b17, Offset: 0xeed
// Size: 0x69
function function_beed28c14c0553d9( var_e814baa69305ee8a )
{
    lead_vehicle = var_e814baa69305ee8a.vehicles[ 0 ];
    
    if ( !lead_vehicle )
    {
        var_e814baa69305ee8a.vehicles = function_5713d46873b29625( var_e814baa69305ee8a.vehicles );
        
        if ( var_e814baa69305ee8a.vehicles.size == 0 )
        {
            return;
        }
        
        lead_vehicle = var_e814baa69305ee8a.vehicles[ 0 ];
    }
    
    return lead_vehicle;
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0xb6ae9e7d, Offset: 0xf5f
// Size: 0x130
function function_17d81d775f362e3f()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    
    /#
        if ( getdvarint( @"hash_7069ffd0db1861f7", 0 ) > 0 )
        {
            level thread function_7e00ed344fb484c3( self );
        }
    #/
    
    while ( true )
    {
        foreach ( var_e814baa69305ee8a in level.ob_traffic_vehicles_group )
        {
            lead_vehicle = function_beed28c14c0553d9( var_e814baa69305ee8a );
            
            if ( !lead_vehicle )
            {
                continue;
            }
            
            if ( ispointinvolume( lead_vehicle.origin, self ) )
            {
                if ( !var_e814baa69305ee8a.traffic_paused && function_8dcfdda51d47cfeb( self, lead_vehicle ) )
                {
                    ob_vehicle_group_pause( var_e814baa69305ee8a );
                    thread function_3c0d94996db03ce3( self, var_e814baa69305ee8a, lead_vehicle.activity_instance );
                }
            }
        }
        
        wait 0.1;
        throttle::throttle_wait_in_queue( level.traffic_triggers_throttle, self );
    }
}

// Namespace ob_convoy_util
// Params 2
// Checksum 0x39b4e35c, Offset: 0x1097
// Size: 0xf8, Type: bool
function function_8dcfdda51d47cfeb( trigger, convoy_vehicle )
{
    convoy_speed = convoy_vehicle function_24e10bf6894fa869( "p2p", "manualSpeed" );
    nearest_vehicle = function_4b696423cd6db165( trigger );
    
    if ( nearest_vehicle )
    {
        if ( !function_6b60b4f13cb61029( convoy_vehicle, nearest_vehicle ) )
        {
            return false;
        }
        
        nearest_distance = distance( nearest_vehicle.origin, trigger.origin );
        reinforce_vehicle_speed = nearest_vehicle function_24e10bf6894fa869( "p2p", "manualSpeed" );
        
        if ( reinforce_vehicle_speed )
        {
            var_9e54f4b0339d1c57 = nearest_distance / reinforce_vehicle_speed;
        }
        else
        {
            var_9e54f4b0339d1c57 = 999999;
        }
        
        var_a2255f1667b4dca = distance( convoy_vehicle.origin, trigger.origin ) + 2000;
        var_e18cd54d04f6ec6c = var_a2255f1667b4dca / convoy_speed;
        
        if ( var_9e54f4b0339d1c57 < var_e18cd54d04f6ec6c )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    return false;
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0xb2d9e474, Offset: 0x1198
// Size: 0xd5
function function_4b696423cd6db165( trigger )
{
    nearest_vehicle = undefined;
    nearest_distance = 999999;
    
    foreach ( vehicle in level.ob_reinforce_vehicles )
    {
        distance = distance( vehicle.origin, trigger.origin );
        
        if ( distance < nearest_distance )
        {
            nearest_vehicle = vehicle;
            nearest_distance = distance;
        }
    }
    
    if ( nearest_distance > 3600 )
    {
        return;
    }
    
    return nearest_vehicle;
}

// Namespace ob_convoy_util
// Params 2
// Checksum 0x722ebab2, Offset: 0x1276
// Size: 0xde, Type: bool
function function_6b60b4f13cb61029( var_c4af2031f7dfe86, var_c4af1031f7dfc53 )
{
    delta = var_c4af1031f7dfc53.origin - var_c4af2031f7dfe86.origin;
    var_27556aa9a30367a0 = anglestoforward( var_c4af2031f7dfe86.angles );
    var_72cf30a5d801ad49 = anglestoforward( var_c4af1031f7dfc53.angles );
    det = var_27556aa9a30367a0[ 0 ] * var_72cf30a5d801ad49[ 1 ] - var_27556aa9a30367a0[ 1 ] * var_72cf30a5d801ad49[ 0 ];
    
    if ( abs( det ) < 0.001 )
    {
        return false;
    }
    
    t1 = ( delta[ 0 ] * var_72cf30a5d801ad49[ 1 ] - delta[ 1 ] * var_72cf30a5d801ad49[ 0 ] ) / det;
    t2 = ( delta[ 0 ] * var_27556aa9a30367a0[ 1 ] - delta[ 1 ] * var_27556aa9a30367a0[ 0 ] ) / det;
    return t1 > 0 && t2 > 0;
}

// Namespace ob_convoy_util
// Params 3
// Checksum 0x16bfff47, Offset: 0x135d
// Size: 0x13f
function function_3c0d94996db03ce3( trigger, var_e814baa69305ee8a, activity_instance )
{
    level endon( #"game_ended" );
    trigger endon( #"entitydeleted" );
    var_e814baa69305ee8a endon( #"vehicle_group_removed" );
    timeout = 0;
    last_side = undefined;
    
    while ( timeout < 20 )
    {
        nearest_vehicle = function_4b696423cd6db165( trigger );
        
        if ( !nearest_vehicle )
        {
            ob_vehicle_group_resume( var_e814baa69305ee8a );
            return;
        }
        
        var_f3be698044d11578 = function_beed28c14c0553d9( var_e814baa69305ee8a );
        
        if ( !var_f3be698044d11578 )
        {
            return;
        }
        
        forward = anglestoforward( var_f3be698044d11578.angles );
        right = vectorcross( forward, ( 0, 0, 1 ) );
        var_ee6433c31961982d = nearest_vehicle.origin - var_f3be698044d11578.origin;
        
        if ( !last_side )
        {
            last_side = vectordot( right, var_ee6433c31961982d );
        }
        else
        {
            side = vectordot( right, var_ee6433c31961982d );
            
            if ( side * last_side < 0 )
            {
                ob_vehicle_group_resume( var_e814baa69305ee8a );
                return;
            }
        }
        
        wait 0.1;
        timeout += 0.1;
    }
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0xc6640cea, Offset: 0x14a4
// Size: 0x482
function function_9ce1eb1748c8b4fa()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    if ( !getdvarint( @"hash_5d48bd36115fc2a8", 1 ) )
    {
        return;
    }
    
    wait 5;
    vehicleinfo = level.vehicle.templates.aianims[ vehicle vehicle_code::get_vehicle_classname() ];
    
    if ( !vehicleinfo )
    {
        return;
    }
    
    while ( true )
    {
        vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( !vehicle.riders || vehicle.riders.size == 0 )
        {
            return;
        }
        
        if ( ent vehicle::is_vehicle() && isplayer( vehicle_occupancy::get_driver( ent, 1 ) ) )
        {
            attacker = vehicle_occupancy::get_driver( ent );
            attacker_vehicle = ent;
            data = vehicle::get_data( attacker_vehicle vehicle::get_ref() );
            
            if ( !data || data.canfly || data.isboat )
            {
                continue;
            }
            
            veh_mass = vehicle function_9cbba1ae667c3483();
            atk_mass = attacker_vehicle function_9cbba1ae667c3483();
            
            if ( atk_mass < veh_mass * 0.8 )
            {
                continue;
            }
            
            var_2eda7d91e58a3b6a = attacker_vehicle getboundshalfsize();
            bounds_offset = ( 0, 20, 5 );
            var_fedf7dcb3f62b0fa = var_2eda7d91e58a3b6a + bounds_offset;
            var_fb6e663749c56349 = 0.5;
            var_bb60c7365ed7c3d9 = gettime() + var_fb6e663749c56349 * 1000;
            
            while ( true )
            {
                if ( gettime() > var_bb60c7365ed7c3d9 )
                {
                    break;
                }
                
                dealt_damage = 0;
                attk_yaw = attacker_vehicle.angles[ 1 ];
                attk_center = attacker_vehicle getcentroid();
                
                /#
                    orientedbox( attk_center, var_fedf7dcb3f62b0fa * 2, attacker_vehicle.angles, ( 1, 0, 0 ), 0, 1000 );
                #/
                
                leanout_riders = [];
                
                foreach ( rider in vehicle.riders )
                {
                    if ( isalive( rider ) && rider._blackboard.chosenvehicleanimpos_seatalias )
                    {
                        var_64bbd5e0cb8e2152 = int( rider._blackboard.chosenvehicleanimpos_seatalias );
                        currentseat = vehicleinfo[ var_64bbd5e0cb8e2152 ];
                        var_93ecb85b8b30a792 = currentseat.var_14f441f730dc229d;
                        
                        if ( var_93ecb85b8b30a792 )
                        {
                            head_origin = rider gettagorigin( "j_head" );
                            var_80d417c885723875 = math::function_4cf4185ddbaca596( head_origin, attk_yaw, attk_center, var_fedf7dcb3f62b0fa );
                            
                            /#
                                debugstar( head_origin, ( 0, 1, 0 ), 1000, "<dev string:x61>" + var_80d417c885723875, 0.5 );
                            #/
                            
                            if ( var_80d417c885723875 )
                            {
                                damage = max( 100, rider.maxhealth * 0.3 );
                                var_3c9f14680f174676 = rider gettagorigin( "j_mainroot" );
                                rider dodamage( damage, head_origin, attacker, undefined, "MOD_IMPACT", undefined, var_3c9f14680f174676 );
                                dealt_damage = 1;
                            }
                            
                            leanout_riders[ leanout_riders.size ] = rider;
                        }
                    }
                }
                
                if ( dealt_damage )
                {
                    if ( vehicle::get_turrets( vehicle ).size == 0 )
                    {
                        foreach ( rider in leanout_riders )
                        {
                            rider thread function_27b5ea17ddf1fb25( vehicle );
                        }
                    }
                    
                    wait 0.15;
                    continue;
                }
                
                waitframe();
            }
        }
    }
}

// Namespace ob_convoy_util
// Params 1, eflags: 0xc
// Checksum 0x767fa4b5, Offset: 0x192e
// Size: 0xe4
function private function_27b5ea17ddf1fb25( vehicle )
{
    self notify( #"hash_a037c30dc597c199" );
    self endon( #"hash_a037c30dc597c199" );
    agent = self;
    agent endon( #"death" );
    wait randomfloatrange( 0.2, 0.8 );
    agent.var_3d189aa22108290c = 1;
    wait randomfloatrange( 7, 12 );
    
    while ( true )
    {
        if ( !vehicle || !vehicle.riders || !arraycontains( vehicle.riders, agent ) )
        {
            return;
        }
        
        if ( agent.enemy && distance( agent.enemy.origin, agent.origin ) > 500 )
        {
            agent.var_3d189aa22108290c = 0;
            return;
        }
        
        wait 1;
    }
}

// Namespace ob_convoy_util
// Params 0
// Checksum 0x31e0c14, Offset: 0x1a1a
// Size: 0x94
function function_4b9cb0a28bb6273f()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle.var_e534fd117fc8fea4 = vehicle function_24e10bf6894fa869( "p2p", "steeringMultiplier" );
    }
    
    vehicle childthread function_1bc1f0fe29a36da1();
    vehicle waittill( #"stop_pit" );
    vehicle notify( #"hash_70aedcda548f1e89" );
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle setconfigvalue( "p2p", "steeringMultiplier", vehicle.var_e534fd117fc8fea4 );
    }
}

// Namespace ob_convoy_util
// Params 0, eflags: 0x4
// Checksum 0xa79b3ac9, Offset: 0x1ab6
// Size: 0x646
function private function_1bc1f0fe29a36da1()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle endon( #"hash_70aedcda548f1e89" );
    
    while ( true )
    {
        vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        speedmph = vehicle vehicle_getspeed();
        
        /#
            if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
            {
                debugstar( position, ( 1, 0, 0 ), 1000, "<dev string:x70>" + ent getentitynumber() + "<dev string:x75>" + impulse + "<dev string:x7b>" + speedmph, 0.5 );
                line( position, position + normal * 100, ( 1, 0, 0 ), 1, 0, 1000 );
                bounds_half_size = function_decb653c5689e4ca( vehicle.model );
                orientedbox( vehicle.origin, bounds_half_size * 2, vehicle.angles, ( 0, 0, 1 ), 0, 1000 );
                bounds_half_size = vehicle getboundshalfsize();
                orientedbox( vehicle.origin, bounds_half_size * 2, vehicle.angles, ( 0, 1, 1 ), 0, 1000 );
                br = vehicle gettagorigin( "<dev string:x83>" );
                var_e89c868b2ad5aa4c = vehicle gettagorigin( "<dev string:x9f>" );
                debugstar( br, ( 1, 1, 0 ), 1000, "<dev string:xba>" + distance( br, position ), 0.5 );
                debugstar( var_e89c868b2ad5aa4c, ( 1, 1, 0 ), 1000, "<dev string:xc5>" + distance( var_e89c868b2ad5aa4c, position ), 0.5 );
            }
        #/
        
        var_fd86e706b651994 = 8;
        
        if ( ent vehicle::is_vehicle() && isplayer( vehicle_occupancy::get_driver( ent, 1 ) ) && speedmph >= var_fd86e706b651994 )
        {
            attacker_vehicle = ent;
            veh_mass = vehicle function_9cbba1ae667c3483();
            atk_mass = attacker_vehicle function_9cbba1ae667c3483();
            
            if ( atk_mass < veh_mass * 0.8 )
            {
                continue;
            }
            
            wheel_fr = vehicle gettagorigin( "tag_wheel_center_front_right" );
            wheel_fl = vehicle gettagorigin( "tag_wheel_center_front_left" );
            wheel_br = vehicle gettagorigin( "tag_wheel_center_back_right" );
            wheel_bl = vehicle gettagorigin( "tag_wheel_center_back_left" );
            var_2fae9f52c543d92a = distance( position, wheel_bl );
            var_2faea152c543dd90 = distance( position, wheel_br );
            var_2f9ca952c52fb1cc = distance( position, wheel_fr );
            var_2f9cbf52c52fe22e = distance( position, wheel_fl );
            wheel_base = distance( wheel_fr, wheel_br );
            on_br = var_2faea152c543dd90 < var_2fae9f52c543d92a;
            offset_ls = undefined;
            var_7dad858453aec9e4 = 18;
            var_f812c1f61eae852f = 50;
            
            if ( on_br )
            {
                if ( var_2f9ca952c52fb1cc <= wheel_base && var_2faea152c543dd90 <= var_7dad858453aec9e4 )
                {
                    offset_ls = var_2faea152c543dd90;
                }
                else if ( var_2f9ca952c52fb1cc >= wheel_base && var_2faea152c543dd90 <= var_f812c1f61eae852f )
                {
                    offset_ls = var_2faea152c543dd90 * -1;
                }
            }
            else if ( var_2f9cbf52c52fe22e <= wheel_base && var_2fae9f52c543d92a <= var_7dad858453aec9e4 )
            {
                offset_ls = var_2fae9f52c543d92a;
            }
            else if ( var_2f9cbf52c52fe22e >= wheel_base && var_2fae9f52c543d92a <= var_f812c1f61eae852f )
            {
                offset_ls = var_2fae9f52c543d92a * -1;
            }
            
            if ( !offset_ls )
            {
                continue;
            }
            
            vehicle notify( #"pit_begin" );
            
            if ( vehicle hascomponent( "p2p" ) )
            {
                save_chance = vehicle.pit_config.save_chance ?? getdvarfloat( @"hash_536a158c8f38d74e", 0 );
                
                if ( randomfloat( 1 ) >= save_chance )
                {
                    vehicle setconfigvalue( "p2p", "steeringMultiplier", 0.0002 );
                }
                else
                {
                    steer = randomfloatrange( 1, max( 2, vehicle.var_e534fd117fc8fea4 ) );
                    vehicle setconfigvalue( "p2p", "steeringMultiplier", steer );
                    
                    /#
                        if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
                        {
                            debugstar( vehicle.origin, ( 1, 0.5, 0 ), 1000, "<dev string:xd0>" + save_chance + "<dev string:xdf>" + steer, 0.5 );
                        }
                    #/
                }
            }
            
            vehicle function_110418aa73f1197b( on_br, offset_ls, atk_mass );
            contact_time = 1000;
            timeend = gettime() + contact_time;
            
            while ( true )
            {
                waitframe();
                
                if ( gettime() > timeend )
                {
                    break;
                }
                
                lv = vehicle vehicle_getvelocity();
                av = vehicle vehicle_getangularvelocity();
                topspeedfwd = vehicle vehicle_gettopspeedforward();
                var_7607bf718c718ce = min( utility::mph_to_ips( 30 ), utility::mph_to_ips( topspeedfwd ) );
                var_56ca10798fbcd7c4 = coordtransformtranspose( lv, ( 0, 0, 0 ), vehicle.angles );
                drifting = abs( var_56ca10798fbcd7c4[ 1 ] ) / var_7607bf718c718ce;
                var_f1a75ac75380c2e0 = 0.6;
                
                if ( drifting > var_f1a75ac75380c2e0 )
                {
                    vehicle vehphys_force( ( 0, 0.1, 0 ), ( 0, 0, 0 ), 0 );
                    
                    /#
                        if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
                        {
                            bounds_half_size = vehicle getboundshalfsize();
                            orientedbox( vehicle.origin, bounds_half_size * 2, vehicle.angles, ( 1, 1, 1 ), 0, 1000 );
                        }
                    #/
                    
                    break;
                }
                
                vehicle function_110418aa73f1197b( on_br, offset_ls, atk_mass );
            }
            
            if ( vehicle hascomponent( "p2p" ) )
            {
                vehicle setconfigvalue( "p2p", "steeringMultiplier", vehicle.var_e534fd117fc8fea4 );
            }
            
            vehicle notify( #"pit_end" );
            wait 1;
        }
    }
}

// Namespace ob_convoy_util
// Params 3, eflags: 0x4
// Checksum 0xf956fb2f, Offset: 0x2104
// Size: 0x4b9
function private function_110418aa73f1197b( on_br, offset_ls, atk_mass )
{
    veh = self;
    
    /#
        debug_draw_frame = 1000;
        debug_draw_text_scale = 0.5;
    #/
    
    wheel_fr = veh gettagorigin( "tag_wheel_center_front_right" );
    wheel_fl = veh gettagorigin( "tag_wheel_center_front_left" );
    wheel_br = veh gettagorigin( "tag_wheel_center_back_right" );
    wheel_bl = veh gettagorigin( "tag_wheel_center_back_left" );
    var_ebbbc2e767e53e43 = offset_ls;
    var_93df8b04f0cbf571 = getdvarint( @"hash_263d12241703526e", 150 );
    
    if ( on_br )
    {
        wheel_pos = wheel_br + vectornormalize( wheel_fr - wheel_br ) * var_ebbbc2e767e53e43;
        var_9c87548a821968ff = wheel_pos - vectornormalize( wheel_bl - wheel_br ) * var_93df8b04f0cbf571;
    }
    else
    {
        wheel_pos = wheel_bl + vectornormalize( wheel_fl - wheel_bl ) * var_ebbbc2e767e53e43;
        var_9c87548a821968ff = wheel_pos - vectornormalize( wheel_br - wheel_bl ) * var_93df8b04f0cbf571;
    }
    
    /#
        if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
        {
            line( wheel_pos, var_9c87548a821968ff, ( 0, 1, 1 ), 1, 0, debug_draw_frame );
            debugstar( wheel_pos, ( 0, 1, 1 ), debug_draw_frame, "<dev string:xe7>", debug_draw_text_scale );
            debugstar( var_9c87548a821968ff, ( 0, 1, 1 ), debug_draw_frame, "<dev string:xfd>", debug_draw_text_scale );
        }
    #/
    
    veh_com = veh physics_getentitycenterofmass()[ "unscaled" ];
    veh_fwd = anglestoforward( veh.angles );
    var_34ff6a6e6cfed70e = coordtransformtranspose( veh_fwd, ( 0, 0, 0 ), veh.angles );
    impulse_base = getdvarfloat( @"hash_7f408a6d89db0021", 10 );
    impulse = impulse_base * atk_mass;
    var_32345f295d0a4dd5 = var_34ff6a6e6cfed70e * -1 * impulse / level.framedurationseconds;
    var_9c605c8a81ef3d08 = coordtransformtranspose( var_9c87548a821968ff, veh.origin, veh.angles );
    veh vehphys_force( var_32345f295d0a4dd5, var_9c605c8a81ef3d08, level.framedurationseconds );
    
    /#
        if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
        {
            impulse_ls = var_32345f295d0a4dd5 * level.framedurationseconds;
            impulse_ws = coordtransform( impulse_ls, ( 0, 0, 0 ), veh.angles );
            com_offset = ( 5, 0, 23 );
            var_9c87548a821968ff += com_offset;
            var_4d069d276827da73 = var_9c87548a821968ff - veh_com;
            torque_ws = vectorcross( var_4d069d276827da73, impulse_ws );
            line( veh_com, veh_com + veh_fwd * 200, ( 0, 0, 1 ), 1, 0, 1000 );
            debugstar( veh_com + veh_fwd * 200, ( 0, 0, 1 ), debug_draw_frame, "<dev string:x107>", debug_draw_text_scale );
            line( var_9c87548a821968ff, var_9c87548a821968ff + vectornormalize( impulse_ws ) * 200, ( 1, 1, 1 ), 1, 0, 1000 );
            debugstar( var_9c87548a821968ff + vectornormalize( impulse_ws ) * 200, ( 1, 1, 1 ), debug_draw_frame, "<dev string:x10f>", debug_draw_text_scale );
            line( veh_com, veh_com + vectornormalize( var_4d069d276827da73 ) * length( var_4d069d276827da73 ), ( 1, 1, 0 ), 1, 0, 1000 );
            debugstar( veh_com + vectornormalize( var_4d069d276827da73 ) * length( var_4d069d276827da73 ), ( 1, 1, 0 ), debug_draw_frame, "<dev string:x117>", debug_draw_text_scale );
            line( veh_com, veh_com + vectornormalize( torque_ws ) * 100, ( 1, 0.5, 1 ), 1, 0, 1000 );
            accel_ang = undefined;
            
            if ( accel_ang )
            {
                debugstar( veh_com + vectornormalize( torque_ws ) * 100, ( 1, 0.5, 1 ), debug_draw_frame, "<dev string:x122>" + length( torque_ws ) + "<dev string:x12b>" + accel_ang, debug_draw_text_scale );
            }
            else
            {
                debugstar( veh_com + vectornormalize( torque_ws ) * 100, ( 1, 0.5, 1 ), debug_draw_frame, "<dev string:x122>" + length( torque_ws ), debug_draw_text_scale );
            }
            
            dot = vectordot( vectornormalize( var_4d069d276827da73 ), vectornormalize( impulse_ws ) );
            angle = acos( dot );
            debugstar( veh_com, ( 1, 0.5, 1 ), debug_draw_frame, "<dev string:x137>" + dot + "<dev string:x13c>" + angle, debug_draw_text_scale );
        }
    #/
}

// Namespace ob_convoy_util
// Params 1
// Checksum 0x34c0d65e, Offset: 0x25c5
// Size: 0x38
function function_9846981f8d3b8539( vehicle )
{
    gunner = vehicle_ai::function_b74a31eb8af242a0( vehicle, "gunner" );
    
    if ( gunner )
    {
        gunner.var_e59e24fbb46d7d5e = 1;
    }
}

/#

    // Namespace ob_convoy_util
    // Params 1
    // Checksum 0x993e6607, Offset: 0x2605
    // Size: 0x4a, Type: dev
    function function_7e00ed344fb484c3( trigger )
    {
        level endon( #"game_ended" );
        trigger endon( #"entitydeleted" );
        
        while ( true )
        {
            if ( trigger )
            {
                drawtrigger( trigger, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

    // Namespace ob_convoy_util
    // Params 0
    // Checksum 0x11f43faf, Offset: 0x2657
    // Size: 0xe6, Type: dev
    function get_nearest_vehicle_group()
    {
        var_ecee4c7a40a5452a = 999999;
        nearest_vehicle_group = undefined;
        
        foreach ( var_e814baa69305ee8a in level.ob_traffic_vehicles_group )
        {
            lead_vehicle = function_beed28c14c0553d9( var_e814baa69305ee8a );
            
            if ( lead_vehicle )
            {
                distance = distance( lead_vehicle.origin, level.players[ 0 ].origin );
                
                if ( distance < var_ecee4c7a40a5452a )
                {
                    var_ecee4c7a40a5452a = distance;
                    nearest_vehicle_group = var_e814baa69305ee8a;
                }
            }
        }
        
        return nearest_vehicle_group;
    }

    // Namespace ob_convoy_util
    // Params 0
    // Checksum 0x8a8bb95b, Offset: 0x2745
    // Size: 0x27, Type: dev
    function function_972d1cbfe75e4b55()
    {
        nearest_vehicle_group = get_nearest_vehicle_group();
        
        if ( !nearest_vehicle_group )
        {
            return;
        }
        
        ob_vehicle_group_pause( nearest_vehicle_group );
    }

    // Namespace ob_convoy_util
    // Params 0
    // Checksum 0xaada8041, Offset: 0x2774
    // Size: 0x27, Type: dev
    function function_4fa54136f480b252()
    {
        nearest_vehicle_group = get_nearest_vehicle_group();
        
        if ( !nearest_vehicle_group )
        {
            return;
        }
        
        ob_vehicle_group_resume( nearest_vehicle_group );
    }

    // Namespace ob_convoy_util
    // Params 0
    // Checksum 0x1e6ff5cc, Offset: 0x27a3
    // Size: 0x44, Type: dev
    function function_b8b7f62c80e0f4b8()
    {
        devgui::function_9082edeb5db93280( "<dev string:x145>" );
        devgui::add_devgui_func( "<dev string:x151>", "<dev string:x15f>", &function_972d1cbfe75e4b55 );
        devgui::add_devgui_func( "<dev string:x16d>", "<dev string:x17c>", &function_4fa54136f480b252 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_convoy_util
    // Params 0
    // Checksum 0x4974bab1, Offset: 0x27ef
    // Size: 0x22d, Type: dev
    function function_8f20be5c36d00164()
    {
        self endon( #"death" );
        veh = self;
        var_f646066634df681c = ( 1, 1, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_959bc8918394ee37", 0 ) )
            {
                lv = veh vehicle_getvelocity();
                av = veh vehicle_getangularvelocity();
                topspeedfwd = veh vehicle_gettopspeedforward();
                speedmph = veh vehicle_getspeed();
                var_7607bf718c718ce = min( utility::mph_to_ips( 30 ), utility::mph_to_ips( topspeedfwd ) );
                var_56ca10798fbcd7c4 = coordtransformtranspose( lv, ( 0, 0, 0 ), veh.angles );
                drifting = var_56ca10798fbcd7c4[ 1 ] / var_7607bf718c718ce;
                posx = getdvarint( @"hash_1881e8d17b53dec8", 1900 );
                posy = getdvarint( @"hash_1881e9d17b53e0fb", 500 );
                linespacing = 20;
                scale = 1.4;
                printtoscreen2d( posx, posy, "<dev string:x18b>", var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x195>" + lv + "<dev string:x1a7>" + length( lv ), var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x1ad>" + var_56ca10798fbcd7c4, var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x1c2>" + av, var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x1d5>" + speedmph + "<dev string:x1e0>" + topspeedfwd, var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x1e2>" + var_7607bf718c718ce, var_f646066634df681c, scale );
                posy += linespacing;
                printtoscreen2d( posx, posy, "<dev string:x1ef>" + drifting, var_f646066634df681c, scale );
                posy += linespacing;
                vehiclecenter = veh physics_getentitycenterofmass()[ "<dev string:x1fa>" ];
                debugstar( vehiclecenter, ( 1, 1, 1 ), 1, "<dev string:x203>", 0.5 );
            }
            
            waitframe();
        }
    }

#/
