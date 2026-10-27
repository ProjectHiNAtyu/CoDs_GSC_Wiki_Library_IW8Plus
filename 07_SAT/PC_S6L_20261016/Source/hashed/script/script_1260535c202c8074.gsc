// script_1260535c202c8074  (hash_1260535c202c8074.gscc) (size: 3060 Bytes / 0xbf4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x474c370b (1196177163)
// size ...... 3060 (0xbf4)
// includes .. 6   (offset: 0xb04)
// strings ... 5   (offset: 0xb34)
// dev strs .. 11  (offset: 0xb70)
// exports ... 12  (offset: 0x558)
// cseg ...... 0xa4 + 0x4b4 (0x558)
// imports ... 34  (offset: 0x738)
// animtree1 . 0   (offset: 0xbf4)
// animtree2 . 0   (offset: 0xbf4)
#using script_36d7680b337b15b;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace namespace_6698c489bf4d184b;

// Namespace namespace_6698c489bf4d184b
// Params 0
// Checksum 0xdd83e68c, Offset: 0xc2
// Size: 0x5f
function init_head_banger()
{
    self.worm_target_ent = undefined;
    self.worm_target_yaw = 0;
    self.worm_target_dist = 400;
    self.var_723b02cf115e5831 = ( 0, 0, 0 );
    self.var_e0198e6a85755d57 = ( 0, 0, 0 );
    thread function_e6790de79fa0b70e();
    
    /#
        function_3ec995479068e9dc();
    #/
}

// Namespace namespace_6698c489bf4d184b
// Params 0, eflags: 0x4
// Checksum 0xe70446e2, Offset: 0x129
// Size: 0x138
function private function_101b0b9cb270970e()
{
    self endon( #"death" );
    self endon( #"hash_50e4b2fa5b466e7" );
    self.var_723b02cf115e5831 = function_f2b86b6fe8ffbd05();
    
    while ( true )
    {
        lerp_speed = getdvarfloat( @"hash_a306914883c4c84c", 1 );
        self.var_e0198e6a85755d57 = vectorlerp( self.var_e0198e6a85755d57, self.var_723b02cf115e5831, lerp_speed * level.framedurationseconds );
        self.worm_target_yaw = math::remap( self.var_e0198e6a85755d57[ 0 ], -1, 1, -10, 10 );
        self.worm_target_dist = math::remap( self.var_e0198e6a85755d57[ 1 ], -1, 1, 500, 1000 );
        self function_536f8624346a747b( self.worm_target_yaw );
        self function_ba5334b674dfb9d0( self.worm_target_dist );
        
        /#
            if ( function_e17c89e6019b224c() )
            {
                var_f06c3d8143b76949 = self gettagorigin( "<dev string:x24>" );
                line( self.origin, var_f06c3d8143b76949, ( 1, 0, 0 ) );
                function_f650d1d5637bd140( "<dev string:x2b>" + distance2d( self.origin, var_f06c3d8143b76949 ), var_f06c3d8143b76949 );
            }
        #/
        
        waitframe();
    }
}

// Namespace namespace_6698c489bf4d184b
// Params 0, eflags: 0x4
// Checksum 0x9092309c, Offset: 0x269
// Size: 0x4d
function private function_e6790de79fa0b70e()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_4c26c28ac007e1c2" );
        thread function_101b0b9cb270970e();
        thread function_7baa0613d6ea18c2();
        ai::set_blackboard_cooldown( "head_banger_cooldown", getdvarint( @"worm_head_banger_cooldown", 15000 ) );
    }
}

// Namespace namespace_6698c489bf4d184b
// Params 0, eflags: 0x4
// Checksum 0xf63f7201, Offset: 0x2be
// Size: 0xce
function private function_7baa0613d6ea18c2()
{
    self endon( #"death" );
    self endon( #"hash_4c26c28ac007e1c2" );
    self endon( #"hash_50e4b2fa5b466e7" );
    var_9c18eb30cf6a1214 = [[ self.var_3c8a8a999d3d0d2e ]]();
    
    while ( true )
    {
        self waittill( #"hash_958d262f66dc2c1b" );
        var_f06c3d8143b76949 = self gettagorigin( "j_head" );
        self.var_723b02cf115e5831 = function_f2b86b6fe8ffbd05();
        self setscriptablepartstate( "audio", "headbanger_impact" );
        damage = 2000;
        
        if ( self.use_lethal_attacks && var_9c18eb30cf6a1214 >= 0.5 && self.var_6005157a6615b97f > 1 )
        {
            damage *= 10;
        }
        
        namespace_636cb8a8ba015294::function_48dcfbf83d16e7a5( 0, 800, damage );
    }
}

// Namespace namespace_6698c489bf4d184b
// Params 2, eflags: 0x4
// Checksum 0x24b5598b, Offset: 0x394
// Size: 0x3b
function private function_278a495c25216158( player, var_cf4c5ba48d407062 )
{
    player utility::knockback_flat( player.origin - var_cf4c5ba48d407062, 400 );
    player playrumbleonentity( "heavy_1s" );
}

// Namespace namespace_6698c489bf4d184b
// Params 0, eflags: 0x4
// Checksum 0xa52b986d, Offset: 0x3d7
// Size: 0x41
function private function_f2b86b6fe8ffbd05()
{
    target_point = ( randomfloat( 1 ) - 0.5, randomfloat( 1 ) - 0.5, 0 );
    target_point = rotatepointaroundvector( ( 0, 0, 1 ), target_point, 45 );
    return target_point;
}

/#

    // Namespace namespace_6698c489bf4d184b
    // Params 0
    // Checksum 0xc32e2006, Offset: 0x421
    // Size: 0x44, Type: dev
    function function_3ec995479068e9dc()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3e>" );
        devgui::add_devgui_func( "<dev string:x5a>", "<dev string:x6c>", &function_10074a6025bb6f5c );
        devgui::add_devgui_func( "<dev string:x83>", "<dev string:x95>", &function_f91d0e8ef3068223 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_6698c489bf4d184b
    // Params 0, eflags: 0x4
    // Checksum 0x5432f5ce, Offset: 0x46d
    // Size: 0x48, Type: dev
    function private function_10074a6025bb6f5c()
    {
        var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xac>" );
        
        if ( !isdefined( var_f39d8960915f9a15 ) )
        {
            return;
        }
        
        var_f39d8960915f9a15 function_786bb6aa1b76c7ee( "<dev string:xbd>", 1 );
    }

    // Namespace namespace_6698c489bf4d184b
    // Params 0, eflags: 0x4
    // Checksum 0x3104e85c, Offset: 0x4bd
    // Size: 0x16, Type: dev
    function private function_e17c89e6019b224c()
    {
        return getdvarint( @"hash_2602a364f90130b2", 0 ) > 0;
    }

    // Namespace namespace_6698c489bf4d184b
    // Params 0, eflags: 0x4
    // Checksum 0xe6dec6aa, Offset: 0x4db
    // Size: 0x1a, Type: dev
    function private function_f91d0e8ef3068223()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xcc>", @"hash_2602a364f90130b2" );
    }

    // Namespace namespace_6698c489bf4d184b
    // Params 2, eflags: 0x4
    // Checksum 0x988e01d9, Offset: 0x4fd
    // Size: 0x5b, Type: dev
    function private function_f650d1d5637bd140( text, pos )
    {
        if ( function_e17c89e6019b224c() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:xe8>" + text, ( 1, 0, 0 ) );
        }
    }

#/
