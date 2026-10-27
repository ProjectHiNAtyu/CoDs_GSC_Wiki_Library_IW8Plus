// script_36d7680b337b15b  (hash_036d7680b337b15b.gscc) (size: 7821 Bytes / 0x1e8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4888086e (1216874606)
// size ...... 7821 (0x1e8d)
// includes .. 10  (offset: 0x1bcd)
// strings ... 25  (offset: 0x1c1d)
// dev strs .. 20  (offset: 0x1d9d)
// exports ... 17  (offset: 0x1081)
// cseg ...... 0x1d1 + 0xeb0 (0x1081)
// imports ... 73  (offset: 0x1329)
// animtree1 . 0   (offset: 0x1e8d)
// animtree2 . 0   (offset: 0x1e8d)
#using script_16ea1b94f0f381b3;
#using script_193e3e231841082f;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_arena;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_636cb8a8ba015294;

// Namespace namespace_636cb8a8ba015294
// Params 0
// Checksum 0x471e36ec, Offset: 0x1ef
// Size: 0x33
function init_snake_bite()
{
    self.worm_target_ent = undefined;
    self.worm_target_yaw = 0;
    self.worm_target_dist = 400;
    thread function_398073a26711516d();
    
    /#
        function_30d7615d3ccedd25();
    #/
}

// Namespace namespace_636cb8a8ba015294
// Params 3
// Checksum 0x3f9a6d41, Offset: 0x22a
// Size: 0xdc
function function_58efc0fd9f3b8e74( asmname, statename, params )
{
    if ( isdefined( self.var_b014f929d0a7a12a ) && gettime() - self.var_b014f929d0a7a12a < 17000 )
    {
        self function_786bb6aa1b76c7ee( "snakebite_fast", 1 );
        return;
    }
    
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    var_9c18eb30cf6a1214 = [[ self.var_3c8a8a999d3d0d2e ]]();
    var_121423597bb042b0 = self.health < self.maxhealth * 0.5;
    
    if ( var_4912869f02b165bf >= 4 || var_4912869f02b165bf > 1 && var_9c18eb30cf6a1214 >= 1 || var_121423597bb042b0 )
    {
        self function_786bb6aa1b76c7ee( "snakebite_fast", 1 );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "snakebite_fast", 0 );
}

// Namespace namespace_636cb8a8ba015294
// Params 3
// Checksum 0x9dda71b1, Offset: 0x30e
// Size: 0x37
function exitsnakebite( asmname, statename, params )
{
    self function_786bb6aa1b76c7ee( "in_snake_bite", 0 );
    self.var_b014f929d0a7a12a = gettime();
}

// Namespace namespace_636cb8a8ba015294
// Params 0, eflags: 0x4
// Checksum 0x1f26fe64, Offset: 0x34d
// Size: 0x487
function private function_c3d419f59db1a3cb()
{
    self endon( #"death" );
    self endon( #"snake_bite_end" );
    self.worm_target_yaw = 0;
    self.worm_target_dist = 400;
    self.worm_target_pos = undefined;
    var_88839c319e8d83bd = istrue( self getaiblackboarddynamic( "snakebite_fast" ) );
    var_8267fc23f243b4fe = var_88839c319e8d83bd ? 2 : 1;
    var_96044cf289b656b5 = 4000;
    var_9c18eb30cf6a1214 = [[ self.var_3c8a8a999d3d0d2e ]]();
    
    if ( var_9c18eb30cf6a1214 >= 1 && self.var_6005157a6615b97f >= 7 || var_9c18eb30cf6a1214 >= 0.8 && self.var_6005157a6615b97f >= 13 )
    {
        var_96044cf289b656b5 = 6000;
    }
    
    var_676e3cc22665cd23 = gettime() + var_96044cf289b656b5 / var_8267fc23f243b4fe;
    
    while ( gettime() < var_676e3cc22665cd23 )
    {
        if ( isdefined( self.worm_target_ent ) )
        {
            if ( !namespace_473bdc208d3e708a::function_c1592b3e647c3368( self.worm_target_ent.origin ) )
            {
                target_yaw = utility::getyawtospot( self.worm_target_ent.origin );
                target_yaw = clamp( target_yaw, -70, 70 );
                var_a0d3f1c68d25c770 = distance2d( self.origin, self.worm_target_ent.origin );
                var_a0d3f1c68d25c770 = clamp( var_a0d3f1c68d25c770, 471, 1886 );
                self.worm_target_yaw = target_yaw;
                self.worm_target_dist = var_a0d3f1c68d25c770;
                self.worm_target_pos = self.worm_target_ent.origin;
                
                /#
                    if ( function_b17866d63a9e55ed() )
                    {
                        sphere( self.worm_target_pos, 20, ( 1, 0, 0 ) );
                        function_f650d1d5637bd140( "<dev string:x24>", self.worm_target_pos );
                    }
                #/
            }
            else
            {
                /#
                    function_f650d1d5637bd140( "<dev string:x2f>", self.worm_target_ent.origin );
                #/
            }
        }
        
        self function_536f8624346a747b( self.worm_target_yaw );
        self function_ba5334b674dfb9d0( self.worm_target_dist );
        
        /#
            if ( function_b17866d63a9e55ed() )
            {
                var_f06c3d8143b76949 = self gettagorigin( "<dev string:x47>" );
                line( self.origin, var_f06c3d8143b76949, ( 1, 0, 0 ) );
                function_f650d1d5637bd140( "<dev string:x4e>" + distance2d( self.origin, var_f06c3d8143b76949 ), var_f06c3d8143b76949 );
            }
        #/
        
        waitframe();
    }
    
    thread function_75817b4ccc3f3e2c();
    
    /#
        function_f650d1d5637bd140( "<dev string:x61>" + self.worm_target_dist );
    #/
    
    if ( self.worm_target_dist > 1000 )
    {
        return;
    }
    
    self endon( #"hash_bef293df542334b6" );
    
    while ( true )
    {
        var_f06c3d8143b76949 = self gettagorigin( "j_head" );
        var_cbae022e329d2a51 = self gettagangles( "j_head" );
        var_15b459a05af71a5a = anglestoforward( var_cbae022e329d2a51 );
        var_84145d9bbd2f11e0 = anglestoup( var_cbae022e329d2a51 );
        var_282b9ad1b0105a9c = getdvarfloat( @"hash_7174d8c71ecb56dc", 450 );
        up_amount = getdvarfloat( @"hash_d5be4cd033c8e19c", 150 );
        var_7d3632b7dcf723d0 = trace::create_playerclip_contents();
        trace = trace::ray_trace( var_f06c3d8143b76949 + var_15b459a05af71a5a * var_282b9ad1b0105a9c * 0.5 + var_84145d9bbd2f11e0 * up_amount, var_f06c3d8143b76949 + var_15b459a05af71a5a * var_282b9ad1b0105a9c + var_84145d9bbd2f11e0 * up_amount, self, var_7d3632b7dcf723d0 );
        trace2 = trace::ray_trace( var_f06c3d8143b76949 + var_15b459a05af71a5a * var_282b9ad1b0105a9c * 0.5 - var_84145d9bbd2f11e0 * up_amount, var_f06c3d8143b76949 + var_15b459a05af71a5a * var_282b9ad1b0105a9c - var_84145d9bbd2f11e0 * up_amount, self, var_7d3632b7dcf723d0 );
        var_839ea8241de85b00 = trace::ray_trace( var_f06c3d8143b76949 + var_15b459a05af71a5a * var_282b9ad1b0105a9c * 0.5 - var_84145d9bbd2f11e0 * up_amount, var_f06c3d8143b76949 + var_15b459a05af71a5a * var_282b9ad1b0105a9c * 0.5 - var_84145d9bbd2f11e0 * up_amount * 2, self, var_7d3632b7dcf723d0 );
        
        /#
            if ( function_b17866d63a9e55ed() )
            {
                trace::draw_trace( trace, ( 1, 0, 0 ), 1 );
                trace::draw_trace( trace2, ( 1, 0, 0 ), 1 );
                trace::draw_trace( var_839ea8241de85b00, ( 1, 0, 0 ), 1 );
            }
        #/
        
        if ( trace[ "hittype" ] == "hittype_world" || trace2[ "hittype" ] == "hittype_world" || var_839ea8241de85b00[ "hittype" ] == "hittype_world" )
        {
            self notify( #"snake_bite_hit" );
            self asmfireevent( self.asmname, "end" );
        }
        
        waitframe();
    }
}

// Namespace namespace_636cb8a8ba015294
// Params 0, eflags: 0x4
// Checksum 0x6f4c0e0b, Offset: 0x7dc
// Size: 0xb4
function private function_398073a26711516d()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_7b0da2f130e71ae9" );
        utility::ent_flag_clear( "has_snake_bite_hit" );
        thread utility::thread_on_notify( "snake_bite_end", &on_snake_bite_end, self );
        self.worm_target_ent = self.enemy;
        
        /#
            if ( function_b17866d63a9e55ed() )
            {
                if ( isdefined( self.worm_target_ent ) )
                {
                    line( self.origin, self.worm_target_ent.origin, ( 1, 0, 0 ) );
                }
                
                function_f650d1d5637bd140( "<dev string:x8b>" );
            }
        #/
        
        thread function_c3d419f59db1a3cb();
        thread function_266d9674ebed487f();
    }
}

// Namespace namespace_636cb8a8ba015294
// Params 0, eflags: 0x4
// Checksum 0x45230b75, Offset: 0x898
// Size: 0x1f4
function private function_75817b4ccc3f3e2c()
{
    self endon( #"snake_bite_hit" );
    self endon( #"snake_bite_end" );
    self endon( #"death" );
    danger_zone_radius = 200;
    self.var_b3078827ba3f8364 = [];
    
    while ( true )
    {
        if ( isdefined( self.worm_target_pos ) )
        {
            players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.worm_target_pos, danger_zone_radius );
            
            /#
                if ( function_b17866d63a9e55ed() )
                {
                    sphere( self.worm_target_pos, danger_zone_radius, ( 1, 1, 0 ) );
                    function_f650d1d5637bd140( "<dev string:x9c>", self.worm_target_pos );
                }
            #/
            
            foreach ( player in players )
            {
                if ( !player utility::ent_flag( "in_snake_bite_danger_zone" ) )
                {
                    player utility::function_7c10ea82c1e305b8( "deathwormVFX", "snake_bite_danger" );
                    thread function_fc42cbf703d2821b( player );
                    player utility::ent_flag_set( "in_snake_bite_danger_zone" );
                }
            }
            
            foreach ( var_a45ffac39833f37f in self.var_b3078827ba3f8364 )
            {
                if ( !arraycontains( players, var_a45ffac39833f37f ) )
                {
                    var_a45ffac39833f37f utility::function_7c10ea82c1e305b8( "deathwormVFX", "off" );
                    var_a45ffac39833f37f utility::ent_flag_clear( "in_snake_bite_danger_zone" );
                }
            }
            
            self.var_b3078827ba3f8364 = players;
        }
        
        waitframe();
    }
}

// Namespace namespace_636cb8a8ba015294
// Params 1, eflags: 0x4
// Checksum 0x4f8ffd30, Offset: 0xa94
// Size: 0x7a
function private function_fc42cbf703d2821b( player )
{
    self endon( #"death" );
    utility::waittill_any( "death", "snake_bite_hit", "snake_bite_end" );
    currentstate = player getscriptablepartstate( "deathwormVFX", 1 );
    
    if ( isdefined( currentstate ) && currentstate != "swallowed" )
    {
        player utility::function_7c10ea82c1e305b8( "deathwormVFX", "off" );
    }
    
    player utility::ent_flag_clear( "in_snake_bite_danger_zone" );
}

// Namespace namespace_636cb8a8ba015294
// Params 0, eflags: 0x4
// Checksum 0xd875e0ab, Offset: 0xb16
// Size: 0x3a
function private on_snake_bite_end()
{
    ai::set_blackboard_cooldown( "snake_bite_cooldown", getdvarint( @"worm_snake_bite_cooldown", 5000 ) );
    ai::set_blackboard_cooldown( "snake_bite_close_cooldown", getdvarint( @"worm_snake_bite_close_cooldown", 2000 ) );
}

// Namespace namespace_636cb8a8ba015294
// Params 3
// Checksum 0xfd49d74c, Offset: 0xb58
// Size: 0x32f
function function_48dcfbf83d16e7a5( attempt_swallow, damage_radius = 400, var_6a02108301e17dc = 420 )
{
    var_f06c3d8143b76949 = self gettagorigin( "j_head" );
    assert( isdefined( var_f06c3d8143b76949 ) );
    special_ai_damage = 60000;
    elite_ai_damage = 50000;
    targets = getplayersandaiarrayinradius( var_f06c3d8143b76949, damage_radius );
    
    foreach ( target in targets )
    {
        target_max_damage = var_6a02108301e17dc;
        
        if ( isplayer( target ) )
        {
            function_c7ced5c3433b647f( target, var_f06c3d8143b76949 );
        }
        else if ( isai( target ) )
        {
            target_max_damage = 0;
            
            if ( isdefined( target.aicategory ) && !attempt_swallow )
            {
                if ( target.aicategory == "normal" )
                {
                    target_max_damage = target.health;
                }
                else if ( target.aicategory == "special" )
                {
                    target_max_damage = 100000;
                }
                else if ( target.aicategory == "elite" || target.aicategory == "hvt" )
                {
                    target_max_damage = 50000;
                }
            }
        }
        
        var_cb5e9e6ad0ec3bf5 = distance2d( var_f06c3d8143b76949, target.origin );
        var_8bd444d2097f426c = max( ( damage_radius - var_cb5e9e6ad0ec3bf5 ) / damage_radius, 0 );
        var_34323c3349a6f257 = math::remap( var_8bd444d2097f426c, 0, 1, 10, target_max_damage );
        
        if ( isalive( target ) )
        {
            if ( attempt_swallow )
            {
                if ( self.use_lethal_attacks && self.var_6005157a6615b97f > 1 && target.armorhealth > 0 )
                {
                    target dodamage( var_34323c3349a6f257, var_f06c3d8143b76949, self, self, "MOD_MELEE" );
                }
                
                swallowed = namespace_473bdc208d3e708a::function_e918d59b09e09aa9( target, var_f06c3d8143b76949, var_34323c3349a6f257 );
                
                if ( !swallowed )
                {
                    target dodamage( var_34323c3349a6f257, var_f06c3d8143b76949, self, self, "MOD_MELEE" );
                }
            }
            else if ( isai( target ) )
            {
                target zombie_knockdown::function_6fc167d4a3590991( var_f06c3d8143b76949 );
                target dodamage( var_34323c3349a6f257, var_f06c3d8143b76949, self, self, "MOD_MELEE" );
            }
            else if ( isplayer( target ) )
            {
                target dodamage( var_34323c3349a6f257, var_f06c3d8143b76949, self, self, "MOD_MELEE" );
            }
        }
        
        /#
            function_f650d1d5637bd140( "<dev string:xa8>" + var_34323c3349a6f257, target.origin + ( 0, 0, 70 ) );
        #/
    }
    
    self setscriptablepartstate( "audio", "snake_bite_impact" );
    earthquake( 0.8, 0.4, var_f06c3d8143b76949, 1000 );
    
    /#
        if ( function_b17866d63a9e55ed() )
        {
            iprintlnbold( "<dev string:xb2>" );
            function_f650d1d5637bd140( "<dev string:xbf>" + targets.size + "<dev string:xc4>", var_f06c3d8143b76949 );
            sphere( var_f06c3d8143b76949, damage_radius, ( 1, 0, 0 ) );
        }
    #/
}

// Namespace namespace_636cb8a8ba015294
// Params 0, eflags: 0x4
// Checksum 0x71bfb341, Offset: 0xe8f
// Size: 0x70
function private function_266d9674ebed487f()
{
    self endon( #"death" );
    self endon( #"hash_7b0da2f130e71ae9" );
    self waittill( #"snake_bite_hit" );
    utility::ent_flag_set( "has_snake_bite_hit" );
    damage = 320;
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    
    if ( var_4912869f02b165bf >= 13 )
    {
        damage = 600;
    }
    
    function_48dcfbf83d16e7a5( 1, undefined, damage );
}

// Namespace namespace_636cb8a8ba015294
// Params 2, eflags: 0x4
// Checksum 0xaf0944a4, Offset: 0xf07
// Size: 0x3b
function private function_c7ced5c3433b647f( player, var_cf4c5ba48d407062 )
{
    player utility::knockback_flat( player.origin - var_cf4c5ba48d407062, 1600 );
    player playrumbleonentity( "heavy_1s" );
}

/#

    // Namespace namespace_636cb8a8ba015294
    // Params 0
    // Checksum 0x33ee3102, Offset: 0xf4a
    // Size: 0x44, Type: dev
    function function_30d7615d3ccedd25()
    {
        devgui::function_9082edeb5db93280( "<dev string:xcd>" );
        devgui::add_devgui_func( "<dev string:xe9>", "<dev string:xfa>", &function_c2a2e56a776e49fd );
        devgui::add_devgui_func( "<dev string:x10b>", "<dev string:x11c>", &function_bc80fd047d551b8c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_636cb8a8ba015294
    // Params 0, eflags: 0x4
    // Checksum 0x310abc81, Offset: 0xf96
    // Size: 0x48, Type: dev
    function private function_c2a2e56a776e49fd()
    {
        var_f39d8960915f9a15 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x12d>" );
        
        if ( !isdefined( var_f39d8960915f9a15 ) )
        {
            return;
        }
        
        var_f39d8960915f9a15 function_786bb6aa1b76c7ee( "<dev string:x13e>", 1 );
    }

    // Namespace namespace_636cb8a8ba015294
    // Params 0, eflags: 0x4
    // Checksum 0xc747b4aa, Offset: 0xfe6
    // Size: 0x16, Type: dev
    function private function_b17866d63a9e55ed()
    {
        return getdvarint( @"hash_4c15f2ff8e7fd1bf", 0 ) > 0;
    }

    // Namespace namespace_636cb8a8ba015294
    // Params 0, eflags: 0x4
    // Checksum 0xc70492cb, Offset: 0x1004
    // Size: 0x1a, Type: dev
    function private function_bc80fd047d551b8c()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x14c>", @"hash_4c15f2ff8e7fd1bf" );
    }

    // Namespace namespace_636cb8a8ba015294
    // Params 2, eflags: 0x4
    // Checksum 0x3bd1379d, Offset: 0x1026
    // Size: 0x5b, Type: dev
    function private function_f650d1d5637bd140( text, pos )
    {
        if ( function_b17866d63a9e55ed() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x167>" + text, ( 1, 0, 0 ) );
        }
    }

#/
