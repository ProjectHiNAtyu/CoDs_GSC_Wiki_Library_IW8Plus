// script_54d7585f0a1791e6  (hash_54d7585f0a1791e6.gscc) (size: 1147 Bytes / 0x47b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ae0ff59 (2061565785)
// size ...... 1147 (0x47b)
// includes .. 1   (offset: 0x403)
// strings ... 6   (offset: 0x40b)
// dev strs .. 0   (offset: 0x47b)
// exports ... 4   (offset: 0x2bb)
// cseg ...... 0xab + 0x210 (0x2bb)
// imports ... 5   (offset: 0x35b)
// animtree1 . 0   (offset: 0x47b)
// animtree2 . 0   (offset: 0x47b)
#using scripts\common\utility;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 3
// Checksum 0x51992540, Offset: 0xc9
// Size: 0x166
function set_vehicle_usable_state( vehicle, canbeused, doinvulnerability = 0 )
{
    if ( canbeused && vehicle.var_7493baa2cd62443 != 83 )
    {
        if ( vehicle utility::function_9f2c41c1dcc8c94( "single", "vehicle_unusable" ) && vehicle.health > 50 )
        {
            if ( doinvulnerability )
            {
                vehicle.var_e80954486df087be = gettime();
            }
            
            vehicle utility::function_7c10ea82c1e305b8( "single", "vehicle_use" );
            function_2d7ec1832d72a38f( vehicle, 0 );
            vehicle notify( #"hash_8c5d9655be6145c9" );
            
            foreach ( player in level.players )
            {
                player notify( #"exit_pluto_repair_hud" );
            }
        }
        
        return;
    }
    
    if ( vehicle utility::function_9f2c41c1dcc8c94( "single", "vehicle_use" ) )
    {
        vehicle utility::function_7c10ea82c1e305b8( "single", "vehicle_unusable" );
        
        if ( vehicle.currentstate > 0 )
        {
            function_2d7ec1832d72a38f( vehicle, 1 );
        }
    }
}

// Namespace pluto_veh
// Params 2
// Checksum 0x1fad83d, Offset: 0x237
// Size: 0x6d
function function_2d7ec1832d72a38f( vehicle, damaged )
{
    if ( damaged )
    {
        if ( vehicle utility::function_9f2c41c1dcc8c94( "plutoDamage", "disabled" ) )
        {
            vehicle utility::function_7c10ea82c1e305b8( "plutoDamage", "enabled" );
        }
        
        return;
    }
    
    if ( vehicle utility::function_9f2c41c1dcc8c94( "plutoDamage", "enabled" ) )
    {
        vehicle utility::function_7c10ea82c1e305b8( "plutoDamage", "disabled" );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x4df65bbc, Offset: 0x2ac
// Size: 0xe, Type: bool
function private function_d5ded137742206c3()
{
    return self.health == 50;
}

