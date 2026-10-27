// script_51a093502a988075  (hash_51a093502a988075.gscc) (size: 3378 Bytes / 0xd32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96a688c4 (2527496388)
// size ...... 3378 (0xd32)
// includes .. 5   (offset: 0xbda)
// strings ... 8   (offset: 0xc02)
// dev strs .. 17  (offset: 0xc66)
// exports ... 11  (offset: 0x72e)
// cseg ...... 0xb7 + 0x677 (0x72e)
// imports ... 26  (offset: 0x8e6)
// animtree1 . 0   (offset: 0xd32)
// animtree2 . 0   (offset: 0xd32)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_18052412ffe544da;

/#

    // Namespace namespace_18052412ffe544da
    // Params 0
    // Checksum 0x9649cafc, Offset: 0xd5
    // Size: 0xc, Type: dev
    function function_1b99bf5d23c4ac37()
    {
        function_f968583f56af6fc2();
    }

#/

// Namespace namespace_18052412ffe544da
// Params 0
// Checksum 0xacdcf963, Offset: 0xe9
// Size: 0x82
function init_zombie_ghoul_move()
{
    self.var_64f0e7fc11ccb18 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_857cc53f20a3e04f;
    self.side_roll_cooldown_s = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fc05d3bb0e0f7c6f;
    self.var_39923856a22ff6e4 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3997c4e40967cab1;
    thread zombie_wander::wander_listener();
    thread monitor_side_roll();
}

// Namespace namespace_18052412ffe544da
// Params 0, eflags: 0x4
// Checksum 0x35fe1e04, Offset: 0x173
// Size: 0x2d2
function private monitor_side_roll()
{
    self endon( #"death" );
    var_b66f12450dde8590 = 0;
    
    while ( true )
    {
        while ( true )
        {
            wait 1;
            
            /#
                if ( level.var_7cb7a6fd13bdb83b )
                {
                    break;
                }
            #/
            
            if ( self.var_ec7fc0485821787b )
            {
                if ( var_b66f12450dde8590 )
                {
                    var_b66f12450dde8590 = 0;
                    break;
                }
                else
                {
                    var_b66f12450dde8590 = 1;
                }
            }
            
            if ( isdefined( self.last_dmg_struct ) )
            {
                if ( self.last_dmg_struct.timehit + 1200 > gettime() )
                {
                    break;
                }
            }
        }
        
        timeout = 0;
        
        while ( timeout <= self.var_39923856a22ff6e4 )
        {
            if ( timeout )
            {
                wait 1;
            }
            
            timeout += 1;
            
            if ( !isplayer( self.enemy ) || !self function_cd4e36c96335b50c() || distancesquared( self.origin, self.enemy.origin ) < squared( 128 ) )
            {
                continue;
            }
            
            roll_dir = utility::cointoss() ? 1 : -1;
            left_dir = anglestoleft( self.angles );
            start = self.origin + ( 0, 0, 50 );
            end = start + left_dir * roll_dir * 240;
            trace = trace::ray_trace_detail( start, end, [ self ] );
            tr_dist = trace[ "fraction" ] * 240;
            
            if ( tr_dist < 80 )
            {
                roll_dir *= -1;
                end = start + left_dir * roll_dir * 240;
                trace = trace::ray_trace_detail( start, end, [ self ] );
                tr_dist = trace[ "fraction" ] * 240;
                
                if ( tr_dist < 80 )
                {
                    continue;
                }
            }
            
            /#
                if ( level.var_89ec840c5f0351ca )
                {
                    tr_dist = 40;
                }
                
                if ( level.var_52f3b0506f961ef2 )
                {
                    tr_dist = 170;
                }
                
                if ( level.var_65c5e2226d2a04d3 )
                {
                    tr_dist = 240;
                }
            #/
            
            var_4dd9c210b998e030 = roll_dir > 0 ? "roll_left" : "roll_right";
            
            if ( tr_dist >= 240 )
            {
                var_4dd9c210b998e030 += "_long";
            }
            else if ( tr_dist > 160 )
            {
                var_4dd9c210b998e030 += "_mid";
            }
            else
            {
                var_4dd9c210b998e030 += "_short";
            }
            
            self function_786bb6aa1b76c7ee( "in_side_roll", 1 );
            self function_695b8e1b655c2796( "side_roll", var_4dd9c210b998e030 );
            self waittill( #"side_roll_start" );
            childthread function_a6573901add319b7();
            thread function_e3dff68bdc925f2d();
            
            if ( randomint( 100 ) > self.var_64f0e7fc11ccb18 )
            {
                break;
            }
            
            timeout = self.var_39923856a22ff6e4 - 1;
            self waittill( #"side_roll_end" );
            wait randomfloat( 1 );
        }
        
        wait self.side_roll_cooldown_s;
    }
}

// Namespace namespace_18052412ffe544da
// Params 0, eflags: 0x4
// Checksum 0x9241d6be, Offset: 0x44d
// Size: 0x29
function private function_e3dff68bdc925f2d()
{
    self endon( #"death" );
    self.var_da701e38d0bbf750 = 1;
    wait 1.25;
    self.var_da701e38d0bbf750 = undefined;
}

// Namespace namespace_18052412ffe544da
// Params 0, eflags: 0x4
// Checksum 0xc9203e46, Offset: 0x47e
// Size: 0x2e
function private function_a6573901add319b7()
{
    self endon( #"side_roll_end" );
    
    while ( true )
    {
        zombie_utils::function_607ff821e430d594( self.origin, 64 );
        wait 0.25;
    }
}

/#

    // Namespace namespace_18052412ffe544da
    // Params 0, eflags: 0x4
    // Checksum 0x3850bbda, Offset: 0x4b4
    // Size: 0x70, Type: dev
    function private function_f968583f56af6fc2()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x42>", "<dev string:x59>", &function_c367c1614ea007ba );
        devgui::add_devgui_func( "<dev string:x70>", "<dev string:x8c>", &function_236dcca34496eb47 );
        devgui::add_devgui_func( "<dev string:xa3>", "<dev string:xbd>", &function_481fabc4af69a6f3 );
        devgui::add_devgui_func( "<dev string:xd2>", "<dev string:xed>", &function_cc7a51980b1a84f5 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_18052412ffe544da
    // Params 0, eflags: 0x4
    // Checksum 0x6e9fccbe, Offset: 0x52c
    // Size: 0x4c, Type: dev
    function private function_c367c1614ea007ba()
    {
        if ( !isdefined( level.var_7cb7a6fd13bdb83b ) )
        {
            level.var_7cb7a6fd13bdb83b = 0;
        }
        
        level.var_7cb7a6fd13bdb83b = !level.var_7cb7a6fd13bdb83b;
        iprintlnbold( level.var_7cb7a6fd13bdb83b ? "<dev string:x103>" : "<dev string:x119>" );
    }

    // Namespace namespace_18052412ffe544da
    // Params 0, eflags: 0x4
    // Checksum 0xa820839c, Offset: 0x580
    // Size: 0x8a, Type: dev
    function private function_236dcca34496eb47()
    {
        if ( !isdefined( level.var_89ec840c5f0351ca ) )
        {
            level.var_89ec840c5f0351ca = 0;
        }
        
        if ( level.var_52f3b0506f961ef2 )
        {
            level.var_52f3b0506f961ef2 = !level.var_52f3b0506f961ef2;
        }
        
        if ( level.var_74632c165656617e )
        {
            level.var_74632c165656617e = !level.var_74632c165656617e;
        }
        
        level.var_89ec840c5f0351ca = !level.var_89ec840c5f0351ca;
        iprintlnbold( level.var_89ec840c5f0351ca ? "<dev string:x130>" : "<dev string:x149>" );
    }

    // Namespace namespace_18052412ffe544da
    // Params 0, eflags: 0x4
    // Checksum 0x27a8a397, Offset: 0x612
    // Size: 0x8a, Type: dev
    function private function_481fabc4af69a6f3()
    {
        if ( !isdefined( level.var_52f3b0506f961ef2 ) )
        {
            level.var_52f3b0506f961ef2 = 0;
        }
        
        if ( level.var_89ec840c5f0351ca )
        {
            level.var_89ec840c5f0351ca = !level.var_89ec840c5f0351ca;
        }
        
        if ( level.var_74632c165656617e )
        {
            level.var_74632c165656617e = !level.var_74632c165656617e;
        }
        
        level.var_52f3b0506f961ef2 = !level.var_52f3b0506f961ef2;
        iprintlnbold( level.var_52f3b0506f961ef2 ? "<dev string:x165>" : "<dev string:x17c>" );
    }

    // Namespace namespace_18052412ffe544da
    // Params 0, eflags: 0x4
    // Checksum 0xc01a8245, Offset: 0x6a4
    // Size: 0x8a, Type: dev
    function private function_cc7a51980b1a84f5()
    {
        if ( !isdefined( level.var_74632c165656617e ) )
        {
            level.var_74632c165656617e = 0;
        }
        
        if ( level.var_89ec840c5f0351ca )
        {
            level.var_89ec840c5f0351ca = !level.var_89ec840c5f0351ca;
        }
        
        if ( level.var_52f3b0506f961ef2 )
        {
            level.var_52f3b0506f961ef2 = !level.var_52f3b0506f961ef2;
        }
        
        level.var_74632c165656617e = !level.var_74632c165656617e;
        iprintlnbold( level.var_74632c165656617e ? "<dev string:x196>" : "<dev string:x1ae>" );
    }

#/
