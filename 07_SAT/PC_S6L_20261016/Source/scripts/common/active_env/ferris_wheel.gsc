// scripts\common\active_env\ferris_wheel.gsc  (hash_22aa15616a976096.gscc) (size: 1530 Bytes / 0x5fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5cd0e9f (3050114719)
// size ...... 1530 (0x5fa)
// includes .. 2   (offset: 0x5c6)
// strings ... 2   (offset: 0x5d6)
// dev strs .. 1   (offset: 0x5ee)
// exports ... 3   (offset: 0x3ae)
// cseg ...... 0x76 + 0x338 (0x3ae)
// imports ... 14  (offset: 0x426)
// animtree1 . 0   (offset: 0x5fa)
// animtree2 . 0   (offset: 0x5fa)
#using scripts\common\math;
#using scripts\common\utility;

#namespace ferris_wheel;

// Namespace ferris_wheel
// Params 0
// Checksum 0xfcbcaaaa, Offset: 0x94
// Size: 0x1d1
function function_608ecf2462b35d42()
{
    var_dd5cdc263802c077 = 2;
    n_angular_velocity = isdefined( self.script_parameters ) ? float( self.script_parameters ) : var_dd5cdc263802c077;
    a_s_carts = utility::getstructarray( self.target, "targetname" );
    n_delta_time = 0.5;
    n_delta_theta = n_angular_velocity / 2;
    var_e2607b109a0b1419 = self.origin;
    var_56c01eedcd65f5ee = anglestoforward( self.angles );
    a_e_carts = [];
    
    foreach ( s_cart in a_s_carts )
    {
        e_cart = spawn( "script_model", s_cart.origin );
        e_cart.angles = s_cart.angles ?? ( 0, 0, 0 );
        
        if ( isdefined( s_cart.script_modelname ) )
        {
            e_cart setmodel( s_cart.script_modelname );
            a_e_carts[ a_e_carts.size ] = e_cart;
        }
        else
        {
            assertmsg( "<dev string:x24>" );
            return;
        }
        
        e_cart setmodel( s_cart.script_modelname );
        e_cart forcenetfieldhighlod( 1 );
        e_cart setmoveroptimized( 1 );
        e_cart setmoverantilagged( 1 );
        e_cart markkeyframedmover();
    }
    
    thread function_31bdd8b4f7683e96( a_e_carts, var_e2607b109a0b1419, var_56c01eedcd65f5ee, n_delta_theta, n_delta_time );
}

// Namespace ferris_wheel
// Params 5, eflags: 0x4
// Checksum 0x9397921b, Offset: 0x26d
// Size: 0x141
function private function_31bdd8b4f7683e96( a_e_carts, var_e2607b109a0b1419, var_56c01eedcd65f5ee, n_delta_theta, n_delta_time )
{
    level endon( #"game_ended" );
    
    foreach ( e_car in a_e_carts )
    {
        e_car setmoveroptimized( 1 );
        e_car setmoverantilagged( 1 );
        e_car markkeyframedmover();
    }
    
    while ( true )
    {
        self rotateroll( n_delta_theta, n_delta_time );
        
        foreach ( e_car in a_e_carts )
        {
            e_car math::function_ad1b3fbc486397da( var_e2607b109a0b1419, var_56c01eedcd65f5ee, n_delta_theta, n_delta_time );
        }
        
        wait n_delta_time;
        waitframe();
        waitframe();
    }
}

