// scripts\mp\zm\systems\zm_energy_barriers.gsc  (hash_51395d59f6807e9a.gscc) (size: 3739 Bytes / 0xe9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x667ca2f3 (1719444211)
// size ...... 3739 (0xe9b)
// includes .. 2   (offset: 0xddb)
// strings ... 13  (offset: 0xdeb)
// dev strs .. 0   (offset: 0xe9b)
// exports ... 10  (offset: 0x8e7)
// cseg ...... 0x182 + 0x765 (0x8e7)
// imports ... 29  (offset: 0xa77)
// animtree1 . 0   (offset: 0xe9b)
// animtree2 . 0   (offset: 0xe9b)
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace zm_energy_barriers;

// Namespace zm_energy_barriers
// Params 0
// Checksum 0xf9f15ebc, Offset: 0x1a0
// Size: 0x2e
function init_permanent_energy_barrier_trigger()
{
    var_5390463e961f2c67 = getentarray( "permanent_energy_barrier", #targetname );
    utility::array_thread( var_5390463e961f2c67, &permanent_energy_barrier_trigger );
}

// Namespace zm_energy_barriers
// Params 0
// Checksum 0xbe68c171, Offset: 0x1d6
// Size: 0x47
function function_dba6a6ed7ec1162f()
{
    level._effect[ "scrnfx_mobile_barrier" ] = loadfxasset( "vfx_t10_levels_zm_garnet_energy_barrier_laser_camera" );
    var_63331a6b9da5cf84 = getentarray( "trig_rumble_mobile_barrier", #script_noteworthy );
    utility::array_thread( var_63331a6b9da5cf84, &function_2119ce2cd9179747 );
}

// Namespace zm_energy_barriers
// Params 0
// Checksum 0x8e0c1059, Offset: 0x225
// Size: 0x104
function function_2119ce2cd9179747()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            if ( !player.var_1f3601c593b0fd1b )
            {
                player thread function_16f6dab3545fe2bc( self );
                
                if ( player utility::flag( "rcxd_begin" ) || player utility::flag( "hellstorm_begin" ) )
                {
                    player.scrnfx_played = 0;
                    continue;
                }
                
                player earthquakeforplayer( 0.1, 0.5, player.origin, 200 );
                player playrumbleonentity( "viewmodel_large" );
                
                if ( !player.scrnfx_played )
                {
                    level thread function_f04da0521ab41ffc();
                    player setclientomnvar( "is_in_energy_barrier", 1 );
                    player utility::function_7c10ea82c1e305b8( "energy_barrier_cam_fx", "fx_on" );
                    player.scrnfx_played = 1;
                }
            }
        }
        
        wait 0.3;
    }
}

// Namespace zm_energy_barriers
// Params 1
// Checksum 0xdfb7a4b1, Offset: 0x331
// Size: 0x6b
function function_16f6dab3545fe2bc( e_trigger )
{
    level endon( #"game_ended" );
    self.var_1f3601c593b0fd1b = 1;
    
    while ( isdefined( e_trigger ) && self istouching( e_trigger ) )
    {
        wait 1;
    }
    
    utility::function_7c10ea82c1e305b8( "energy_barrier_cam_fx", "fx_off" );
    self setclientomnvar( "is_in_energy_barrier", 0 );
    self.scrnfx_played = 0;
    self.var_1f3601c593b0fd1b = 0;
}

// Namespace zm_energy_barriers
// Params 0, eflags: 0xc
// Checksum 0x1e53beab, Offset: 0x3a4
// Size: 0x1ed
function private function_f04da0521ab41ffc()
{
    self notify( #"hash_d50bfc681aa7d834" );
    self endon( #"hash_d50bfc681aa7d834" );
    level endon( #"game_ended" );
    level.var_6c95de6f1da05e45 = [];
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( player.sessionstate == "spectator" )
        {
            level.var_6c95de6f1da05e45 = arraycombineunique( level.var_6c95de6f1da05e45, [ player ] );
        }
    }
    
    level thread function_709914196b171bb2( "eb_end_watch_spectator" );
    
    while ( true )
    {
        level.var_6c95de6f1da05e45 = function_5713d46873b29625( level.var_6c95de6f1da05e45 );
        
        foreach ( player in level.var_6c95de6f1da05e45 )
        {
            var_50e77c3ac6db283 = 0;
            
            if ( player.sessionstate == "spectator" )
            {
                spectating_player = player getspectatingplayer();
                
                if ( isdefined( spectating_player ) && spectating_player getclientomnvar( "is_in_energy_barrier" ) == 1 )
                {
                    var_50e77c3ac6db283 = 1;
                }
            }
            
            player setclientomnvar( "is_in_energy_barrier", var_50e77c3ac6db283 ? 1 : 0 );
        }
        
        if ( !function_fe1e65f52edb1ea5() )
        {
            level notify( #"eb_end_watch_spectator" );
            return;
        }
        
        wait 0.3;
    }
}

// Namespace zm_energy_barriers
// Params 1, eflags: 0x4
// Checksum 0x2a6b2d, Offset: 0x599
// Size: 0x8b
function private function_709914196b171bb2( end_notify )
{
    level endon( #"game_ended" );
    
    if ( isdefined( end_notify ) )
    {
        level endon( end_notify );
    }
    
    if ( !isdefined( level.var_6c95de6f1da05e45 ) )
    {
        level.var_6c95de6f1da05e45 = [];
    }
    
    while ( true )
    {
        level waittill( #"joined_spectators", player );
        
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        level.var_6c95de6f1da05e45 = arraycombineunique( level.var_6c95de6f1da05e45, [ player ] );
    }
}

// Namespace zm_energy_barriers
// Params 0, eflags: 0x4
// Checksum 0x3774a79a, Offset: 0x62c
// Size: 0x84, Type: bool
function private function_fe1e65f52edb1ea5()
{
    foreach ( player in level.players )
    {
        if ( player.var_1f3601c593b0fd1b )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_energy_barriers
// Params 0
// Checksum 0x10650e98, Offset: 0x6b9
// Size: 0x52
function permanent_energy_barrier_trigger()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", entity );
        
        if ( isalive( entity ) && !entity.in_permanent_energy_barrier )
        {
            entity thread permanent_energy_barrier_damage( self );
        }
    }
}

// Namespace zm_energy_barriers
// Params 1
// Checksum 0xe1a0617d, Offset: 0x713
// Size: 0x1d4
function permanent_energy_barrier_damage( e_trigger )
{
    self endon( #"death" );
    self.in_permanent_energy_barrier = 1;
    
    if ( isplayer( self ) )
    {
        time = gettime();
        var_2e5c7d63779927f5 = 1;
        var_387552f46f5686c4 = 12;
        var_b0e4b11361e63ae7 = 4;
        var_360c52ce57f162b4 = 2;
        var_204bb0ad54d226e7 = gettime() + var_2e5c7d63779927f5;
        var_af5ded805ae4b60d = time >= var_204bb0ad54d226e7;
        var_d293164882c9f7cc = var_387552f46f5686c4 / var_b0e4b11361e63ae7;
        var_7e7dc449b9342aab = var_d293164882c9f7cc * 2;
        var_e86ed5730b75a6de = var_d293164882c9f7cc * 3;
        var_a02d74782f3d5bd7 = 1;
        
        while ( self istouching( e_trigger ) && !player::isinlaststand( self ) )
        {
            if ( !isdefined( self.var_b9c20761a7b2ef72 ) )
            {
                self.var_b9c20761a7b2ef72 = time;
            }
            
            elapsed_time = time - self.var_b9c20761a7b2ef72;
            
            if ( elapsed_time <= var_d293164882c9f7cc )
            {
                var_a02d74782f3d5bd7 = 1;
            }
            else if ( var_d293164882c9f7cc < elapsed_time && elapsed_time <= var_7e7dc449b9342aab )
            {
                var_a02d74782f3d5bd7 = 2;
            }
            else if ( var_7e7dc449b9342aab < elapsed_time && elapsed_time <= var_e86ed5730b75a6de )
            {
                var_a02d74782f3d5bd7 = 3;
            }
            else
            {
                var_a02d74782f3d5bd7 = 4;
            }
            
            var_f20659beaf713a7d = self.maxhealth / 12;
            var_1e214ff2e99f0e48 = int( var_f20659beaf713a7d * var_a02d74782f3d5bd7 );
            self dodamage( var_1e214ff2e99f0e48, self.origin, e_trigger );
            wait 1;
        }
        
        self.var_b9c20761a7b2ef72 = undefined;
        self.in_permanent_energy_barrier = undefined;
        return;
    }
    
    var_b0e11e540e8ce859 = int( self.maxhealth / 6 );
    self dodamage( var_b0e11e540e8ce859, self.origin, self );
    wait 1;
    self.in_permanent_energy_barrier = undefined;
}

