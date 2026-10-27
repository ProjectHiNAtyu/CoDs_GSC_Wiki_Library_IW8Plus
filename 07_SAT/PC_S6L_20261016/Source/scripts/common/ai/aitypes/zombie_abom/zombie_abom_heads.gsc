// scripts\common\ai\aitypes\zombie_abom\zombie_abom_heads.gsc  (hash_436fb062b77116ec.gscc) (size: 5505 Bytes / 0x1581 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d761041 (2641760321)
// size ...... 5505 (0x1581)
// includes .. 8   (offset: 0x1371)
// strings ... 22  (offset: 0x13b1)
// dev strs .. 14  (offset: 0x14d9)
// exports ... 19  (offset: 0xb05)
// cseg ...... 0x1c9 + 0x93c (0xb05)
// imports ... 45  (offset: 0xdfd)
// animtree1 . 0   (offset: 0x1581)
// animtree2 . 0   (offset: 0x1581)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_swallow;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_abom_heads;

// Namespace zombie_abom_heads
// Params 0
// Checksum 0x8b8f8b04, Offset: 0x1e7
// Size: 0x42
function init_zombie_abom_heads_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_105c160346f8e1eb );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_ba437e055dc116a8 );
}

// Namespace zombie_abom_heads
// Params 0
// Checksum 0xc8cc72ea, Offset: 0x231
// Size: 0x57
function init_zombie_abom_heads()
{
    self.var_96070850cb57b4e1 = undefined;
    self.var_b532e24af8a28b7 = [];
    self.var_b532e24af8a28b7[ 0 ] = 0;
    self.var_b532e24af8a28b7[ 1 ] = 0;
    self.var_b532e24af8a28b7[ 2 ] = 0;
    thread function_1d08aa30a2eacf21();
    thread function_1f091843a79a6ff5();
    
    /#
        function_d0a88666aaee23d4();
    #/
}

// Namespace zombie_abom_heads
// Params 0
// Checksum 0x7b7d8ae4, Offset: 0x290
// Size: 0x5c
function attach_heads()
{
    for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b <= 2 ; var_e8b483d049d7276b++ )
    {
        if ( namespace_ad681b768a39ef59::is_head_alive( self, var_e8b483d049d7276b ) )
        {
            utility::function_32b24db3127bff40( self.var_885001fb6c6706f8[ var_e8b483d049d7276b ], "attached" );
            continue;
        }
        
        utility::function_32b24db3127bff40( self.var_885001fb6c6706f8[ var_e8b483d049d7276b ], "destroyed" );
    }
}

// Namespace zombie_abom_heads
// Params 0
// Checksum 0x13750e09, Offset: 0x2f4
// Size: 0x35
function dettach_heads()
{
    utility::function_32b24db3127bff40( "head_le", "off" );
    utility::function_32b24db3127bff40( "head_mid", "off" );
    utility::function_32b24db3127bff40( "head_ri", "off" );
}

// Namespace zombie_abom_heads
// Params 0, eflags: 0x4
// Checksum 0x7b5ed926, Offset: 0x331
// Size: 0xfd
function private function_1d08aa30a2eacf21()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( function_6378cb1b9bdcdf1a() )
        {
            waitframe();
            continue;
        }
        
        wait 5;
        
        if ( isdefined( self.var_96070850cb57b4e1 ) )
        {
            self.var_f1399edbb1cd756f = self.var_96070850cb57b4e1;
            self.var_96070850cb57b4e1 = undefined;
            var_4aa611939344b56a = 0.5;
            
            if ( namespace_ad681b768a39ef59::get_heads_alive( self ).size <= 1 )
            {
                round_number = zombie_utils::get_zombie_round_difficulty();
                var_b53261e80c263351 = clamp( math::remap( round_number, 20, 50, 0, 5 ), 0, 5 );
                var_4aa611939344b56a += var_b53261e80c263351;
            }
            
            wait var_4aa611939344b56a;
        }
        
        var_b383b7eba88eae0d = namespace_ad681b768a39ef59::function_621da7a4dc0c0695( self );
        
        if ( isdefined( self.var_f1399edbb1cd756f ) && var_b383b7eba88eae0d.size > 1 )
        {
            var_b383b7eba88eae0d = arrayremove( var_b383b7eba88eae0d, self.var_f1399edbb1cd756f );
        }
        
        head_to_open = utility::array_random( var_b383b7eba88eae0d );
        self.var_96070850cb57b4e1 = head_to_open;
    }
}

// Namespace zombie_abom_heads
// Params 0, eflags: 0x4
// Checksum 0x48f20e03, Offset: 0x436
// Size: 0x194
function private function_1f091843a79a6ff5()
{
    self endon( #"death" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    var_b267f289d57ea806 = 0;
    var_fe8f72e69a247472 = undefined;
    
    while ( true )
    {
        if ( function_be0ee721fcb0de8e() )
        {
            var_75bd3818905237d6 = function_6378cb1b9bdcdf1a();
            var_f38aaa84d5e5d34a = function_6b19a952ba6bce9e();
            
            if ( var_75bd3818905237d6 || var_f38aaa84d5e5d34a )
            {
                var_b267f289d57ea806 = 0;
                var_fe8f72e69a247472 = undefined;
            }
            else if ( !var_b267f289d57ea806 )
            {
                if ( !isdefined( var_fe8f72e69a247472 ) )
                {
                    var_fe8f72e69a247472 = gettime();
                }
                
                var_e7ee87bae20add18 = gettime() - var_fe8f72e69a247472;
                
                if ( var_e7ee87bae20add18 >= 1000 )
                {
                    var_b267f289d57ea806 = 1;
                    var_fe8f72e69a247472 = undefined;
                }
                else
                {
                    /#
                        function_5dcda37da381780d( "<dev string:x24>" + 1000 - var_e7ee87bae20add18 );
                    #/
                }
            }
            
            state_name = undefined;
            
            if ( isdefined( self.asmname ) )
            {
                state_name = self asmgetcurrentstate( self.asmname );
            }
            
            if ( !var_b267f289d57ea806 )
            {
                var_f38aaa84d5e5d34a = 1;
            }
            
            for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b <= 2 ; var_e8b483d049d7276b++ )
            {
                if ( namespace_ad681b768a39ef59::is_head_alive( self, var_e8b483d049d7276b ) )
                {
                    if ( var_75bd3818905237d6 )
                    {
                        set_abom_head_state( self, var_e8b483d049d7276b, 2 );
                    }
                    else if ( var_f38aaa84d5e5d34a )
                    {
                        set_abom_head_state( self, var_e8b483d049d7276b, 1 );
                    }
                    else if ( var_e8b483d049d7276b == self.var_96070850cb57b4e1 )
                    {
                        set_abom_head_state( self, var_e8b483d049d7276b, 2 );
                    }
                    else
                    {
                        set_abom_head_state( self, var_e8b483d049d7276b, 1 );
                    }
                    
                    continue;
                }
                
                set_abom_head_state( self, var_e8b483d049d7276b, 0 );
            }
        }
        else
        {
            function_477109a9a88a0eb8();
            var_b267f289d57ea806 = 1;
            var_fe8f72e69a247472 = undefined;
        }
        
        waitframe();
    }
}

// Namespace zombie_abom_heads
// Params 0, eflags: 0x4
// Checksum 0x25839542, Offset: 0x5d2
// Size: 0x92, Type: bool
function private function_be0ee721fcb0de8e()
{
    if ( self.in_melee )
    {
        return false;
    }
    
    if ( self.var_3e29de3ad9354cd2 )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "in_bull_charge" ) )
    {
        /#
            function_5dcda37da381780d( "<dev string:x49>" );
        #/
        
        return false;
    }
    
    if ( ( self getaiblackboarddynamic( "recent_bull_charge_stun" ) ?? 0 ) > gettime() && !self getaiblackboarddynamic( "in_roar_loop" ) )
    {
        /#
            function_5dcda37da381780d( "<dev string:x62>" );
        #/
        
        return false;
    }
    
    if ( self getaiblackboarddynamic( "in_react" ) )
    {
        /#
            function_5dcda37da381780d( "<dev string:x7a>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace zombie_abom_heads
// Params 0, eflags: 0x4
// Checksum 0x47a753ac, Offset: 0x66d
// Size: 0x30, Type: bool
function private function_6378cb1b9bdcdf1a()
{
    if ( self getaiblackboarddynamic( "in_roar_loop" ) || self getaiblackboarddynamic( "in_beam_attack" ) )
    {
        /#
            function_5dcda37da381780d( "<dev string:x8d>" );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace zombie_abom_heads
// Params 0, eflags: 0x4
// Checksum 0x51dc64e6, Offset: 0x6a6
// Size: 0x62, Type: bool
function private function_6b19a952ba6bce9e()
{
    if ( namespace_2c5c73b3013cc64a::zombie_abom_swallow_on_cooldown() )
    {
        /#
            function_5dcda37da381780d( "<dev string:xb4>" );
        #/
        
        return true;
    }
    
    if ( isdefined( self.asmname ) )
    {
        state_name = self asmgetcurrentstate( self.asmname );
        
        if ( state_name == "move_exit" )
        {
            /#
                function_5dcda37da381780d( "<dev string:xd2>" );
            #/
            
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_abom_heads
// Params 2
// Checksum 0x1d0c145e, Offset: 0x711
// Size: 0x23
function get_abom_head_state( entity, var_e8b483d049d7276b )
{
    return entity.var_b532e24af8a28b7[ var_e8b483d049d7276b ];
}

// Namespace zombie_abom_heads
// Params 3, eflags: 0x4
// Checksum 0x93c34b98, Offset: 0x73d
// Size: 0xe8
function private set_abom_head_state( entity, var_e8b483d049d7276b, state )
{
    if ( entity.var_b532e24af8a28b7[ var_e8b483d049d7276b ] == state )
    {
        return;
    }
    
    entity.var_b532e24af8a28b7[ var_e8b483d049d7276b ] = state;
    assert( isdefined( var_e8b483d049d7276b ) );
    entity function_68f2f6fd8a4ffcae( var_e8b483d049d7276b, state );
    
    /#
        function_5dcda37da381780d( "<dev string:xef>" + var_e8b483d049d7276b + "<dev string:xf3>" + state, self.origin + ( 0, 0, 100 + 20 * var_e8b483d049d7276b ) );
    #/
    
    namespace_ad681b768a39ef59::set_head_open_state( entity, var_e8b483d049d7276b, state == 2 );
    scriptable_state = "weakpoint_" + ( state == 2 && !self getaiblackboarddynamic( "in_beam_attack" ) ? "on" : "off" );
    utility::function_32b24db3127bff40( entity.var_885001fb6c6706f8[ var_e8b483d049d7276b ] + "_weakpoint", scriptable_state );
}

// Namespace zombie_abom_heads
// Params 0, eflags: 0x4
// Checksum 0x659310c0, Offset: 0x82d
// Size: 0x22
function private function_477109a9a88a0eb8()
{
    set_abom_head_state( self, 0, 0 );
    set_abom_head_state( self, 1, 0 );
    set_abom_head_state( self, 2, 0 );
}

// Namespace zombie_abom_heads
// Params 1, eflags: 0x4
// Checksum 0x468624be, Offset: 0x857
// Size: 0x11c
function private function_ba437e055dc116a8( params )
{
    if ( isdefined( self.last_dmg_struct ) )
    {
        if ( self.last_dmg_struct.biscritical && isdefined( self.last_dmg_struct.metabonename ) )
        {
            params.body utility::function_32b24db3127bff40( self.last_dmg_struct.metabonename, "destroyed" );
            
            if ( isplayer( self.last_dmg_struct.eattacker ) )
            {
                var_dead3393656a4eff = 1;
                
                for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b <= 2 ; var_e8b483d049d7276b++ )
                {
                    metabone = level.var_93e6be4b24339ce4[ var_e8b483d049d7276b ];
                    
                    if ( metabone != self.last_dmg_struct.metabonename && namespace_ad681b768a39ef59::is_head_alive( self, var_e8b483d049d7276b ) )
                    {
                        var_dead3393656a4eff = 0;
                        break;
                    }
                }
                
                if ( var_dead3393656a4eff )
                {
                    self.last_dmg_struct.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"abom_guillotined" );
                }
            }
        }
    }
}

// Namespace zombie_abom_heads
// Params 1, eflags: 0x4
// Checksum 0x257e4e12, Offset: 0x97b
// Size: 0xb1
function private function_105c160346f8e1eb( params )
{
    var_850a457725b15e0f = params.metabonename;
    
    if ( !isdefined( var_850a457725b15e0f ) )
    {
        return;
    }
    
    var_e8b483d049d7276b = namespace_ad681b768a39ef59::function_316f556358b6282b( var_850a457725b15e0f );
    
    if ( !isdefined( var_e8b483d049d7276b ) )
    {
        return;
    }
    
    var_d5fe158ae1ee58f6 = get_abom_head_state( self, var_e8b483d049d7276b );
    
    if ( var_d5fe158ae1ee58f6 != 2 )
    {
        return;
    }
    
    if ( var_e8b483d049d7276b == 0 )
    {
        utility::function_32b24db3127bff40( "head_le_weakpoint_impact", "weakpoint_impact" );
        return;
    }
    
    if ( var_e8b483d049d7276b == 1 )
    {
        utility::function_32b24db3127bff40( "head_mid_weakpoint_impact", "weakpoint_impact" );
        return;
    }
    
    if ( var_e8b483d049d7276b == 2 )
    {
        utility::function_32b24db3127bff40( "head_ri_weakpoint_impact", "weakpoint_impact" );
    }
}

/#

    // Namespace zombie_abom_heads
    // Params 0
    // Checksum 0x6f96ee89, Offset: 0xa34
    // Size: 0x2e, Type: dev
    function function_d0a88666aaee23d4()
    {
        devgui::function_9082edeb5db93280( "<dev string:xfa>" );
        devgui::add_devgui_func( "<dev string:x117>", "<dev string:x129>", &function_c8ab84dc2e952398 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_abom_heads
    // Params 0, eflags: 0x4
    // Checksum 0xc898851b, Offset: 0xa6a
    // Size: 0x1a, Type: dev
    function private function_c8ab84dc2e952398()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x140>", @"hash_c6978e619bf9de3b" );
    }

    // Namespace zombie_abom_heads
    // Params 0, eflags: 0x4
    // Checksum 0xaf4e3c, Offset: 0xa8c
    // Size: 0x16, Type: dev
    function private function_e713e927057e56cb()
    {
        return getdvarint( @"hash_c6978e619bf9de3b", 0 ) > 0;
    }

    // Namespace zombie_abom_heads
    // Params 2, eflags: 0x4
    // Checksum 0x979b23b8, Offset: 0xaaa
    // Size: 0x5b, Type: dev
    function private function_5dcda37da381780d( text, pos )
    {
        if ( function_e713e927057e56cb() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x157>" + text, ( 1, 0, 0 ) );
        }
    }

#/
