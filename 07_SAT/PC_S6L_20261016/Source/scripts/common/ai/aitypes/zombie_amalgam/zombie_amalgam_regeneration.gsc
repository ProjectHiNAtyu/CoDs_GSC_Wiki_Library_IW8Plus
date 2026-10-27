// scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_regeneration.gsc  (hash_142c4b49b738e3d8.gscc) (size: 5168 Bytes / 0x1430 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c90d9e9 (2358303209)
// size ...... 5168 (0x1430)
// includes .. 8   (offset: 0x12d8)
// strings ... 8   (offset: 0x1318)
// dev strs .. 14  (offset: 0x1384)
// exports ... 20  (offset: 0xb24)
// cseg ...... 0xc6 + 0xa5e (0xb24)
// imports ... 39  (offset: 0xe44)
// animtree1 . 0   (offset: 0x1430)
// animtree2 . 0   (offset: 0x1430)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_parts;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace namespace_22232c840a00551b;

// Namespace namespace_22232c840a00551b
// Params 0
// Checksum 0xd79ef051, Offset: 0xe4
// Size: 0x2c
function function_840215f8bcd481f6()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_80fa84c1d72876b6 );
    
    /#
        function_1dbe28112fa43b5e();
    #/
}

// Namespace namespace_22232c840a00551b
// Params 0
// Checksum 0xcb0f7e06, Offset: 0x118
// Size: 0x2e
function init_zombie_amalgam_regeneration()
{
    self.health_regen_percent = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthregenpercent * 0.01;
}

// Namespace namespace_22232c840a00551b
// Params 0, eflags: 0x4
// Checksum 0x33c7b758, Offset: 0x14e
// Size: 0x67
function private function_2afd9050bbe6ea7a()
{
    if ( self.var_60e8636c644ce30a > gettime() )
    {
        return;
    }
    
    zombie_stun::stun_ai( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bf64ba83352ccf24 );
    self.var_60e8636c644ce30a = gettime() + self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_97471bbdb4029a79 * 1000;
}

// Namespace namespace_22232c840a00551b
// Params 2, eflags: 0x4
// Checksum 0xca8688c6, Offset: 0x1bd
// Size: 0xdb
function private function_c05ed475e35a63d1( part_name, var_564950be1e24e158 )
{
    health = metabone::get_metabone_health( part_name, "grown" );
    max_health = metabone::get_metabone_maxhealth( part_name, "grown" );
    var_abd0e9e671ff084a = max_health - health;
    var_abd0e9e671ff084a = var_abd0e9e671ff084a > var_564950be1e24e158 ? var_564950be1e24e158 : var_abd0e9e671ff084a;
    
    if ( var_abd0e9e671ff084a > 0 )
    {
        metabone::function_dbe4a2c3b0797294( part_name, var_abd0e9e671ff084a, "grown" );
        
        if ( health + var_abd0e9e671ff084a >= max_health * 0.5 && self.var_d2cdd2dee55139b4 != gettime() )
        {
            curr_state = self getscriptablepartstate( part_name );
            
            if ( curr_state == "off" || curr_state == "destroyed" )
            {
                namespace_ef593377fdc8b4e0::function_cfb2502312f62e3b( part_name );
                self.var_19c07e250767547 = 1;
            }
        }
    }
    
    return var_564950be1e24e158 - var_abd0e9e671ff084a;
}

// Namespace namespace_22232c840a00551b
// Params 1, eflags: 0x4
// Checksum 0x80c2910d, Offset: 0x2a1
// Size: 0x137
function private function_b75a34c6bdcdc561( var_564950be1e24e158 )
{
    var_564950be1e24e158 = function_c05ed475e35a63d1( "grab_arm", var_564950be1e24e158 );
    
    if ( var_564950be1e24e158 > 0 )
    {
        foreach ( index in self.var_a2cb952f34ef148 )
        {
            var_564950be1e24e158 = function_c05ed475e35a63d1( namespace_ef593377fdc8b4e0::function_f574ecef9a97c900( index ), var_564950be1e24e158 );
            
            if ( var_564950be1e24e158 <= 0 )
            {
                break;
            }
        }
    }
    
    if ( var_564950be1e24e158 > 0 )
    {
        foreach ( index in self.var_87630a961469b28e )
        {
            var_564950be1e24e158 = function_c05ed475e35a63d1( namespace_ef593377fdc8b4e0::function_98960fd16f504e5e( index ), var_564950be1e24e158 );
            
            if ( var_564950be1e24e158 <= 0 )
            {
                break;
            }
        }
    }
}

// Namespace namespace_22232c840a00551b
// Params 1, eflags: 0x4
// Checksum 0x7268460a, Offset: 0x3e0
// Size: 0x30
function private function_80fa84c1d72876b6( params )
{
    delay_health_regen( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthregendelaydamage );
}

// Namespace namespace_22232c840a00551b
// Params 0
// Checksum 0x20b13e8, Offset: 0x418
// Size: 0xd
function pause_health_regen()
{
    self.var_510d5113ce72318e = 1;
}

// Namespace namespace_22232c840a00551b
// Params 0
// Checksum 0x13470173, Offset: 0x42d
// Size: 0xc
function function_3b5d2318de689d26()
{
    self.var_510d5113ce72318e = 0;
}

// Namespace namespace_22232c840a00551b
// Params 0
// Checksum 0x91ed52fb, Offset: 0x441
// Size: 0xc
function cancel_health_regen()
{
    self.regen_time_limit = 0;
}

// Namespace namespace_22232c840a00551b
// Params 1
// Checksum 0x1060b17b, Offset: 0x455
// Size: 0x67
function delay_health_regen( delay_s )
{
    if ( delay_s > 0 )
    {
        curr_time = gettime();
        remaining_delay_s = 0;
        
        if ( self.regen_delay_time_limit > curr_time )
        {
            remaining_delay_s = ( self.regen_delay_time_limit - curr_time ) / 1000;
        }
        
        if ( delay_s > remaining_delay_s )
        {
            self.regen_delay_time_limit = curr_time + delay_s * 1000;
        }
    }
}

// Namespace namespace_22232c840a00551b
// Params 1
// Checksum 0x8a754665, Offset: 0x4c4
// Size: 0x8f, Type: bool
function is_health_regen_active( curr_time = gettime() )
{
    return curr_time < self.regen_time_limit && self.health_regen_percent > 0 && ( !isdefined( self.var_3230a3474933ee8 ) || self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9fda561432b51680 < 0 || self.var_3230a3474933ee8 < self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9fda561432b51680 );
}

// Namespace namespace_22232c840a00551b
// Params 1
// Checksum 0xd8390817, Offset: 0x55c
// Size: 0x110
function start_health_regen( var_4439cab483dc1549 )
{
    regen_time_limit = gettime();
    
    if ( var_4439cab483dc1549 )
    {
        regen_time_limit += self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_eba72c96c055305a * 1000;
    }
    else
    {
        regen_time_limit += self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_66f8d7fa83aca561 * 1000;
    }
    
    regen_delay_s = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthregendelayabsorption;
    regen_time_limit += regen_delay_s * 1000;
    
    if ( !isdefined( self.regen_time_limit ) || self.regen_time_limit < regen_time_limit )
    {
        self.regen_time_limit = regen_time_limit;
    }
    
    thread function_1b890692cb82d22( regen_delay_s );
    
    if ( self.var_d6894f01a36b4ff3.knockdowndata_list.size > 0 && !self.var_d6894f01a36b4ff3.var_cf239a32f7448dd1 )
    {
        thread zombie_knockdown::function_a0c03faf3694150c( &function_41bc93ab79676430 );
    }
}

// Namespace namespace_22232c840a00551b
// Params 0, eflags: 0x4
// Checksum 0x537564e5, Offset: 0x674
// Size: 0x2e, Type: bool
function private function_41bc93ab79676430()
{
    curr_time = gettime();
    return self.regen_time_limit > curr_time || self.var_fa5af4b8fd716cf5 > curr_time;
}

// Namespace namespace_22232c840a00551b
// Params 1, eflags: 0xc
// Checksum 0x61ecf40c, Offset: 0x6ab
// Size: 0x258
function private function_1b890692cb82d22( regen_delay_s )
{
    self notify( #"hash_6035f0d7837a63d1" );
    self endon( #"hash_6035f0d7837a63d1" );
    self endon( #"death" );
    utility::function_32b24db3127bff40( "regen", "regen_on_absorbed" );
    
    /#
        if ( getdvarint( @"hash_2bcd167469d32a8e", 0 ) )
        {
            print3d( self.origin + ( 0, 0, 40 ), "<dev string:x24>", ( 1, 1, 1 ), 1, 0.5, 30, 1 );
        }
    #/
    
    /#
        thread regen_health_debug();
    #/
    
    if ( regen_delay_s > 0 )
    {
        wait regen_delay_s;
        
        /#
            thread regen_delay_debug( regen_delay_s );
        #/
    }
    
    namespace_ef593377fdc8b4e0::function_748f95a1b04f7eb();
    
    while ( is_health_regen_active() )
    {
        if ( !self.var_510d5113ce72318e && ( !isdefined( self.regen_delay_time_limit ) || self.regen_delay_time_limit < gettime() ) )
        {
            var_abd0e9e671ff084a = self.maxhealth - self.health;
            
            if ( var_abd0e9e671ff084a > 0 )
            {
                var_10ee02e8426c31ac = self.maxhealth * self.health_regen_percent;
                var_564950be1e24e158 = int( min( var_10ee02e8426c31ac, var_abd0e9e671ff084a ) );
                
                if ( var_564950be1e24e158 > 0 )
                {
                    self.health += var_564950be1e24e158;
                    function_b75a34c6bdcdc561( var_564950be1e24e158 );
                    self.health_regen_percent -= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1a4ee6b73f5bfc96 * 0.01;
                    utility::function_32b24db3127bff40( "regen", "regen_pulse" );
                }
                
                /#
                    if ( getdvarint( @"hash_2bcd167469d32a8e", 0 ) )
                    {
                        print3d( self.origin + ( 0, 0, 30 ), "<dev string:x39>" + var_564950be1e24e158 + "<dev string:x45>" + self.health_regen_percent * 100 + "<dev string:x52>" + self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthregeninterval, ( 1, 1, 1 ), 1, 0.5, 30, 1 );
                    }
                #/
            }
        }
        
        wait self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthregeninterval;
    }
}

/#

    // Namespace namespace_22232c840a00551b
    // Params 0, eflags: 0x4
    // Checksum 0x44ab47f3, Offset: 0x90b
    // Size: 0x44, Type: dev
    function private function_1dbe28112fa43b5e()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5d>" );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x89>", &function_12072b1a5dcdba6f );
        devgui::add_devgui_func( "<dev string:x9c>", "<dev string:xaf>", &force_health_regen );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_22232c840a00551b
    // Params 0, eflags: 0x4
    // Checksum 0xa3d63bd2, Offset: 0x957
    // Size: 0x1a, Type: dev
    function private function_12072b1a5dcdba6f()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xc2>", @"hash_2bcd167469d32a8e" );
    }

    // Namespace namespace_22232c840a00551b
    // Params 0, eflags: 0x4
    // Checksum 0x1edd8d7e, Offset: 0x979
    // Size: 0x26, Type: dev
    function private force_health_regen()
    {
        var_5c51666f49f49cb4 = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( var_5c51666f49f49cb4 ) )
        {
            var_5c51666f49f49cb4 start_health_regen();
        }
    }

    // Namespace namespace_22232c840a00551b
    // Params 0, eflags: 0xc
    // Checksum 0x9c4ea94f, Offset: 0x9a7
    // Size: 0xc3, Type: dev
    function private regen_health_debug()
    {
        self notify( #"hash_67455c1edf981388" );
        self endon( #"hash_67455c1edf981388" );
        self endon( #"death" );
        
        while ( is_health_regen_active() )
        {
            if ( getdvarint( @"hash_2bcd167469d32a8e", 0 ) )
            {
                debug_str = "<dev string:xd6>" + self.health + "<dev string:xdf>" + self.maxhealth + "<dev string:x45>" + self.health_regen_percent * 100;
                
                if ( self.var_510d5113ce72318e )
                {
                    debug_str = "<dev string:xe1>" + debug_str;
                }
                
                print3d( self.origin, debug_str, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_22232c840a00551b
    // Params 1, eflags: 0xc
    // Checksum 0x7048dbee, Offset: 0xa72
    // Size: 0xb2, Type: dev
    function private regen_delay_debug( delay_s )
    {
        self notify( #"hash_168b2fb452e477a8" );
        self endon( #"hash_168b2fb452e477a8" );
        self endon( #"death" );
        end_time = gettime() + delay_s * 1000;
        
        while ( true )
        {
            if ( gettime() > end_time )
            {
                break;
            }
            
            if ( getdvarint( @"hash_2bcd167469d32a8e", 0 ) )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:xeb>" + end_time - gettime(), ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
            
            waitframe();
        }
    }

#/
