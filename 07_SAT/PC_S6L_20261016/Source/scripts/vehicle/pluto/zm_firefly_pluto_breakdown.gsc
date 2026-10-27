// scripts\vehicle\pluto\zm_firefly_pluto_breakdown.gsc  (hash_339c102ed45ddc0a.gscc) (size: 2954 Bytes / 0xb8a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd27a087 (220700807)
// size ...... 2954 (0xb8a)
// includes .. 6   (offset: 0xae6)
// strings ... 9   (offset: 0xb16)
// dev strs .. 0   (offset: 0xb8a)
// exports ... 7   (offset: 0x6aa)
// cseg ...... 0xc9 + 0x5e1 (0x6aa)
// imports ... 28  (offset: 0x7c2)
// animtree1 . 0   (offset: 0xb8a)
// animtree2 . 0   (offset: 0xb8a)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\zm_utility;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0
// Checksum 0x75a26d27, Offset: 0xe7
// Size: 0xf3
function function_cadac76a5d6fe53a()
{
    if ( self.var_40eed1312db06ecd )
    {
        return;
    }
    
    thread function_dd8799bff44cec91();
    thread function_f4dc875cc9ecefc9();
    thread pluto_breakdown_blast();
    data = vehicle::get_data( %"hash_62a07b56f29782f5" );
    a_players = getplayersinradius( self.origin, data.wondervehicle.var_b778a8190d433900 );
    
    foreach ( player in a_players )
    {
        player thread function_191f3271a3fd4887();
    }
    
    self.var_40eed1312db06ecd = 1;
    self stopsounds();
    vehicle_occupancy::turn_engine_off();
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0xdfa3774b, Offset: 0x1e2
// Size: 0x6c
function private function_191f3271a3fd4887()
{
    self notify( #"hash_b4740c82868cdbf5" );
    self endon( #"hash_b4740c82868cdbf5" );
    level endon( #"game_ended" );
    player = self;
    player endon( #"death_or_disconnect" );
    player val::set( "pluto_breakdown", "ignoreme" );
    wait 1.5;
    player val::reset( "pluto_breakdown", "ignoreme" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x93d4be61, Offset: 0x256
// Size: 0x22
function private pluto_breakdown_blast()
{
    self setscriptablepartstate( "breakdown_blast_vfx", "on" );
    function_85ea1ebcf7aa4529( self.origin );
}

// Namespace pluto_veh
// Params 1
// Checksum 0x74857c02, Offset: 0x280
// Size: 0x1da
function function_85ea1ebcf7aa4529( origin )
{
    data = vehicle::get_data( %"hash_62a07b56f29782f5" );
    a_ai = getaiarrayinradius( origin, data.wondervehicle.var_b778a8190d433900, zm_utility::get_zombie_team() );
    
    foreach ( var_915257d4b1251540 in a_ai )
    {
        if ( !isalive( var_915257d4b1251540 ) )
        {
            continue;
        }
        
        if ( var_915257d4b1251540.var_698cf8d8d4a8cbb9 )
        {
            if ( !var_915257d4b1251540 val::get( "damageshield" ) )
            {
                var_915257d4b1251540.nuked = 1;
                var_915257d4b1251540.full_gib = 1;
                var_915257d4b1251540.forceannihilate = 1;
                var_915257d4b1251540.no_powerups = 1;
                var_915257d4b1251540.var_a13bed1ac47e1b2c = 1;
                var_915257d4b1251540 kill();
            }
            
            continue;
        }
        
        if ( var_915257d4b1251540.aicategory != "normal" )
        {
            if ( var_915257d4b1251540.aicategory == "hvt" || var_915257d4b1251540.aicategory == "boss" )
            {
                continue;
            }
            
            var_915257d4b1251540 zm_cleanup_manager::function_44f5bec4abb163f1( undefined, 1 );
            continue;
        }
        
        var_915257d4b1251540.nuked = 1;
        var_915257d4b1251540.full_gib = 1;
        var_915257d4b1251540.forceannihilate = 1;
        var_915257d4b1251540.no_powerups = 1;
        var_915257d4b1251540.var_a13bed1ac47e1b2c = 1;
        var_915257d4b1251540 zm_cleanup_manager::function_dd62e2042418b7e5();
        var_915257d4b1251540 kill();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xc311631f, Offset: 0x462
// Size: 0x12f
function private function_f4dc875cc9ecefc9()
{
    a_players = vehicle_occupancy::get_all_occupants( self, 0 );
    
    if ( !a_players )
    {
        a_players = [];
    }
    
    foreach ( player in level.players )
    {
        if ( player getmovingplatformparent() == self && !arraycontains( a_players, player ) )
        {
            a_players[ a_players.size ] = player;
        }
    }
    
    foreach ( player in a_players )
    {
        player playrumbleonentity( "heavy_1s" );
        player earthquakeforplayer( 0.5, 1, self.origin, 150 );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x1d057e63, Offset: 0x599
// Size: 0x111
function private function_dd8799bff44cec91()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle = self;
    
    if ( !vehicle.tedd.var_6d2e819ffaca153a )
    {
        vehicle.tedd.var_6d2e819ffaca153a = 0;
    }
    
    if ( vehicle.tedd.var_6d2e819ffaca153a < 6 )
    {
        currenttime = gettime();
        
        if ( !vehicle.tedd.var_378646e8fe2bf8c7 || currenttime - vehicle.tedd.var_378646e8fe2bf8c7 >= utility::function_4b74c15943231980( 1200 ) )
        {
            vehicle.tedd.var_378646e8fe2bf8c7 = currenttime;
            vehicle.tedd.var_6d2e819ffaca153a++;
            vehicle utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_1ada61fb670b3e69" );
        }
    }
}

