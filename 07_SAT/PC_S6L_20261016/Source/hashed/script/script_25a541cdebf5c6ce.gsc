// script_25a541cdebf5c6ce  (hash_25a541cdebf5c6ce.gscc) (size: 10923 Bytes / 0x2aab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4526fd24 (1160183076)
// size ...... 10923 (0x2aab)
// includes .. 9   (offset: 0x268f)
// strings ... 33  (offset: 0x26d7)
// dev strs .. 38  (offset: 0x28cb)
// exports ... 19  (offset: 0x186b)
// cseg ...... 0x277 + 0x15f4 (0x186b)
// imports ... 88  (offset: 0x1b63)
// animtree1 . 0   (offset: 0x2aab)
// animtree2 . 0   (offset: 0x2aab)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_a572abe18fc0aa97;

// Namespace namespace_a572abe18fc0aa97
// Params 0
// Checksum 0xc5e775d7, Offset: 0x295
// Size: 0x67
function init_zombie_abom_bull_charge()
{
    thread function_f2ba70283419eb29();
    thread function_87bfc2155e40bc5();
    thread roar_rumble_listener();
    utility::ent_flag_set( "can_bull_charge_off_ledge" );
    var_43a03a0c4547cd1a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.bullchargecooldown * 1000;
    self function_786bb6aa1b76c7ee( "bull_charge_cooldown", var_43a03a0c4547cd1a );
    
    /#
        function_51c81a5a4e5a7e4a();
    #/
}

// Namespace namespace_a572abe18fc0aa97
// Params 4
// Checksum 0xaec3e111, Offset: 0x304
// Size: 0x3b6, Type: bool
function function_b80b5d4fe1c402ee( asmname, statename, tostatename, params )
{
    velocity = self.velocity;
    
    if ( !isdefined( self.var_116916bdaa890b87 ) )
    {
        self.var_116916bdaa890b87 = velocity;
    }
    
    var_ce4c30c67311cb7b = function_ca4724391a27eb8d();
    var_d3d10fbd56987b9c = vectornormalize( velocity );
    trace_end = var_ce4c30c67311cb7b + var_d3d10fbd56987b9c * 20;
    trace = navtrace( self.origin, trace_end, self, 1 );
    var_e3413ffc094b80d9 = trace[ "fraction" ] < 1 && isdefined( trace[ "normal" ] );
    self.var_dd17c4ace797e0e5 = var_e3413ffc094b80d9;
    
    /#
        if ( debug_bull_charge() )
        {
            line( self.origin, var_ce4c30c67311cb7b + var_d3d10fbd56987b9c * 30, ( 1, 0, 0 ) );
        }
    #/
    
    if ( var_e3413ffc094b80d9 )
    {
        self.var_6d182fd45ca4a269 = !utility::ent_flag( "can_bull_charge_off_ledge" );
        
        if ( !self.var_6d182fd45ca4a269 && isdefined( trace[ "area_usage_flags" ] ) )
        {
            area_usage_flags = trace[ "area_usage_flags" ];
            
            if ( area_usage_flags & -1 )
            {
                self.var_6d182fd45ca4a269 = 1;
            }
        }
        
        if ( !self.var_6d182fd45ca4a269 && self.var_368f7aa9c5be8b3a == "gravity" )
        {
            self animmode( "gravity_off_nav" );
            self.var_368f7aa9c5be8b3a = "gravity_off_nav";
        }
        
        var_3d3830e45d9ae7f7 = vectordot( var_d3d10fbd56987b9c, trace[ "normal" ] );
        
        /#
            if ( debug_bull_charge() )
            {
                line( trace[ "<dev string:x24>" ], trace[ "<dev string:x24>" ] + trace[ "<dev string:x2d>" ] * 30, ( 1, 0, 1 ) );
                function_d5babdc51b90afcd( "<dev string:x34>" + var_3d3830e45d9ae7f7, trace[ "<dev string:x24>" ] );
            }
        #/
        
        if ( var_3d3830e45d9ae7f7 < -0.88 )
        {
            halfsize = self getboundshalfsize();
            var_7b1cc3333d74a224 = min( 40, halfsize[ 2 ] * 0.66 );
            trace_point_start = trace[ "position" ] + ( 0, 0, var_7b1cc3333d74a224 );
            var_3af8104146c25e5 = utility::flatten_vector( var_d3d10fbd56987b9c, ( 0, 0, 1 ) );
            trace_point_end = trace_point_start + var_3af8104146c25e5 * max( 80, halfsize[ 0 ] );
            var_4c9bd4b7fb44bb3e = physicstrace( trace_point_start, trace_point_end );
            var_dc46be63a119221 = var_4c9bd4b7fb44bb3e != trace_point_end;
            
            if ( var_dc46be63a119221 )
            {
                /#
                    if ( debug_bull_charge() )
                    {
                        function_d5babdc51b90afcd( "<dev string:x3e>" );
                        line( trace_point_start, trace_point_end, ( 1, 0, 0 ) );
                    }
                #/
                
                function_1a6ba3a4ec0875e();
                return true;
            }
            else
            {
                /#
                    if ( debug_bull_charge() )
                    {
                        function_d5babdc51b90afcd( "<dev string:x4f>" );
                        line( trace_point_start, trace_point_end, ( 0, 1, 0 ) );
                    }
                #/
            }
        }
        else
        {
            /#
                if ( debug_bull_charge() )
                {
                    function_d5babdc51b90afcd( "<dev string:x68>" );
                    sphere( trace[ "<dev string:x24>" ], 25, self.var_6d182fd45ca4a269 ? ( 1, 0, 0 ) : ( 0, 1, 0 ) );
                }
            #/
        }
    }
    else if ( self.var_368f7aa9c5be8b3a == "gravity_off_nav" )
    {
        var_1e6ec689f38f1550 = self isonground() && ispointonnavmesh( self.origin, self, 1 );
        
        if ( var_1e6ec689f38f1550 || !utility::ent_flag( "can_bull_charge_off_ledge" ) )
        {
            self animmode( "gravity" );
            self.var_368f7aa9c5be8b3a = "gravity";
        }
    }
    
    return false;
}

// Namespace namespace_a572abe18fc0aa97
// Params 4
// Checksum 0xfc49e84f, Offset: 0x6c3
// Size: 0x421, Type: bool
function function_160019dbdf900ba8( asmname, statename, tostatename, params )
{
    if ( !isalive( self.enemy ) )
    {
        return true;
    }
    
    var_2b502aec469e08b4 = self.origin - ( self.var_da468f53427f92a ?? self.origin );
    var_ae1b471048161f3e = 5;
    var_c8311f68a1a2f25e = lengthsquared( var_2b502aec469e08b4 );
    previous_speed_sq = lengthsquared( self.var_425a2b0ab5187bd7 );
    is_first_frame = !isdefined( self.var_da468f53427f92a );
    
    /#
        function_d5babdc51b90afcd( "<dev string:x85>" + length( var_2b502aec469e08b4 ), self.origin + ( 0, 0, 90 ) );
    #/
    
    if ( var_c8311f68a1a2f25e * squared( 5 ) < previous_speed_sq && previous_speed_sq > squared( var_ae1b471048161f3e ) )
    {
        /#
            function_d5babdc51b90afcd( "<dev string:x95>" + length( var_2b502aec469e08b4 ), self.origin + ( 0, 0, 30 ) );
        #/
        
        return true;
    }
    
    min_speed = 0.1;
    
    if ( var_c8311f68a1a2f25e < squared( min_speed ) && !is_first_frame )
    {
        /#
            function_d5babdc51b90afcd( "<dev string:xc3>" + length( var_2b502aec469e08b4 ) );
        #/
        
        return true;
    }
    
    if ( vectordot( var_2b502aec469e08b4, self.var_425a2b0ab5187bd7 ?? ( 0, 0, 0 ) ) < 0 )
    {
        /#
            function_d5babdc51b90afcd( "<dev string:xd9>" + vectordot( var_2b502aec469e08b4, self.var_425a2b0ab5187bd7 ?? ( 0, 0, 0 ) ) );
        #/
        
        return true;
    }
    
    if ( self.var_6d182fd45ca4a269 )
    {
        self.var_6d182fd45ca4a269 = undefined;
        return true;
    }
    
    self.var_da468f53427f92a = self.origin;
    self.var_425a2b0ab5187bd7 = var_2b502aec469e08b4;
    
    if ( self.var_dd17c4ace797e0e5 )
    {
        drop_height = self.height * 2;
        var_ce4c30c67311cb7b = function_ca4724391a27eb8d( 0.3 );
        dropped_lookahead_point = utility::drop_to_ground( var_ce4c30c67311cb7b, self.height, -1 * drop_height );
        
        if ( !isdefined( dropped_lookahead_point ) )
        {
            /#
                function_d5babdc51b90afcd( "<dev string:xf5>" );
            #/
            
            return true;
        }
        else if ( var_ce4c30c67311cb7b[ 2 ] - dropped_lookahead_point[ 2 ] >= drop_height )
        {
            /#
                function_d5babdc51b90afcd( "<dev string:x11c>", dropped_lookahead_point );
            #/
            
            var_64b7095e8fa67959 = self getgroundentity();
            
            if ( !isdefined( var_64b7095e8fa67959 ) )
            {
                /#
                    function_d5babdc51b90afcd( "<dev string:x144>" );
                #/
                
                return false;
            }
            else
            {
                if ( !math::within_fov_2d( self.origin, self.angles, self.enemy.origin, 0.707 ) )
                {
                    /#
                        function_d5babdc51b90afcd( "<dev string:x156>" );
                    #/
                    
                    return true;
                }
                
                /#
                    function_d5babdc51b90afcd( "<dev string:x17b>" );
                #/
            }
        }
        else
        {
            closest_navmesh_point = getclosestpointonnavmesh( dropped_lookahead_point, self );
            
            if ( isdefined( closest_navmesh_point ) )
            {
                /#
                    function_d5babdc51b90afcd( "<dev string:x19f>", closest_navmesh_point );
                #/
            }
            
            var_2d5e705f1e20a5d4 = 45;
            
            if ( !isdefined( closest_navmesh_point ) || distance2dsquared( closest_navmesh_point, dropped_lookahead_point ) > squared( var_2d5e705f1e20a5d4 ) )
            {
                /#
                    function_d5babdc51b90afcd( "<dev string:x1b5>", self.origin + ( 0, 0, 120 ) );
                    
                    if ( debug_bull_charge() )
                    {
                        line( closest_navmesh_point, dropped_lookahead_point, ( 1, 0, 0 ) );
                    }
                #/
                
                return true;
            }
        }
        
        /#
            function_d5babdc51b90afcd( "<dev string:x1dc>", dropped_lookahead_point );
        #/
    }
    
    if ( !isdefined( self.var_8a6c07d8c7aaedf ) )
    {
        self.var_8a6c07d8c7aaedf = 0;
    }
    
    if ( gettime() > self.var_8a6c07d8c7aaedf )
    {
        var_8071193c1c4c67b8 = 3000;
        self.var_8a6c07d8c7aaedf += var_8071193c1c4c67b8;
        
        if ( !math::is_point_in_front( self.enemy.origin ) )
        {
            /#
                function_d5babdc51b90afcd( "<dev string:x1f4>" );
            #/
            
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0xe1b5802, Offset: 0xaed
// Size: 0x52
function private function_f2ba70283419eb29()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bull_charge_intro_start" );
        utility::function_32b24db3127bff40( "charge_tell", "charge_tell_on" );
        self waittill( #"bull_charge_intro_end" );
        utility::function_32b24db3127bff40( "charge_tell", "charge_tell_off" );
    }
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0xf766085c, Offset: 0xb47
// Size: 0xd4
function private function_87bfc2155e40bc5()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bull_charge_loop_start" );
        self.var_da468f53427f92a = undefined;
        self.var_425a2b0ab5187bd7 = ( 0, 0, 0 );
        self.var_368f7aa9c5be8b3a = "gravity";
        self clearbtgoal( 0 );
        utility::function_32b24db3127bff40( "charge_audio", "charge_audio_start" );
        utility::function_32b24db3127bff40( "charge_vfx", "charge_vfx_on" );
        thread function_a2f78b386c1750e7();
        self waittill( #"bull_charge_loop_end" );
        utility::function_32b24db3127bff40( "charge_audio", "charge_audio_stop" );
        utility::function_32b24db3127bff40( "charge_vfx", "charge_vfx_off" );
        self clearpath();
        self clearbtgoal( 0 );
        self setbtgoalstationary( 0 );
        self forceupdategoalpos();
        self.var_368f7aa9c5be8b3a = undefined;
    }
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0xf7730165, Offset: 0xc23
// Size: 0x673
function private function_a2f78b386c1750e7()
{
    self endon( #"death" );
    self endon( #"bull_charge_loop_end" );
    
    while ( true )
    {
        damage_point = function_ca4724391a27eb8d() + ( 0, 0, self.height * 0.5 );
        damage_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8ffd4a2fde8f2a14;
        rumble_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_eb78e882ac70ec04;
        
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4abbc0d159934773 )
        {
            var_526ab22d759a55e5 = function_ca4724391a27eb8d( 0.1 ) + ( 0, 0, self.height * 0.5 );
            radiusdamage( var_526ab22d759a55e5, damage_radius, 1000, 1000, self, undefined, undefined, 1 );
        }
        
        /#
            if ( debug_bull_charge() )
            {
                sphere( damage_point, damage_radius, ( 1, 0, 0 ) );
                sphere( damage_point, rumble_radius, ( 1, 1, 0 ) );
            }
        #/
        
        players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( damage_point, rumble_radius );
        
        if ( players.size > 0 )
        {
            foreach ( player in players )
            {
                if ( isalive( player ) && player.team != self.team && !player utility::ent_flag( "abom_bull_charge_hit" ) )
                {
                    var_1f1605854588df22 = damage_point - player.origin;
                    var_27419f7ebc5d2950 = lengthsquared( var_1f1605854588df22 );
                    var_c14efa20e5f66fa4 = var_27419f7ebc5d2950 <= squared( damage_radius );
                    
                    if ( var_c14efa20e5f66fa4 )
                    {
                        var_29d80535d06f807a = player utility::function_f02ebab438642e16( "prone" );
                        var_925c7adfed1216b4 = trace::ray_trace_passed( damage_point, var_29d80535d06f807a, self );
                        
                        /#
                            if ( debug_bull_charge() )
                            {
                                line( damage_point, player.origin, ( 1, 0, 0 ) );
                            }
                        #/
                        
                        if ( var_925c7adfed1216b4 )
                        {
                            /#
                                function_d5babdc51b90afcd( "<dev string:x210>", player.origin );
                            #/
                            
                            continue;
                        }
                        
                        player utility::ent_flag_set( "abom_bull_charge_hit" );
                        player thread utility::ent_flag_clear_delayed( "abom_bull_charge_hit", 2 );
                        
                        /#
                            if ( debug_bull_charge() )
                            {
                                sphere( player.origin, 5, ( 0, 1, 1 ) );
                                function_d5babdc51b90afcd( "<dev string:x221>", player.origin );
                            }
                        #/
                        
                        player utility::knockback_flat( player.origin - damage_point, 1200 );
                        player earthquakeforplayer( 0.8, 0.8, damage_point, max( damage_radius, 300 ) );
                        player playrumbleonentity( "heavy_1s" );
                        player thread shellshock_utility::bloodmeleeeffect();
                        player shellshock_utility::_shellshock( %"bomb_stun_mp", #"stun", 2 );
                        player_damage = 50;
                        round_number = zombie_utils::get_zombie_round_difficulty();
                        player_damage *= self.var_fe048a2106d8ef00[ #"bull_charge" ];
                        player dodamage( player_damage, damage_point, self, self, "MOD_IMPACT" );
                        
                        /#
                            function_d5babdc51b90afcd( "<dev string:x22c>", damage_point );
                        #/
                        
                        continue;
                    }
                    
                    if ( !player utility::ent_flag( "abom_bull_charge_rumble" ) )
                    {
                        player utility::ent_flag_set( "abom_bull_charge_rumble" );
                        player thread utility::ent_flag_clear_delayed( "abom_bull_charge_rumble", 2 );
                        player playrumbleonentity( "light_1s" );
                        player earthquakeforplayer( 0.4, 0.8, damage_point, max( rumble_radius, 300 ) );
                        
                        /#
                            if ( debug_bull_charge() )
                            {
                                line( damage_point, player.origin, ( 1, 1, 0 ) );
                                sphere( player.origin, 5, ( 1, 1, 0 ) );
                                function_d5babdc51b90afcd( "<dev string:x23b>", player.origin );
                            }
                        #/
                    }
                }
            }
        }
        
        params = { #damage_point:damage_point };
        callback::callback( #"hash_289e122ce2477b0e", params );
        var_73ab0f5e7a91fe45 = damage_radius * 1.5;
        ai_in_radius = getaiarrayinradius( damage_point, damage_radius );
        
        if ( isalive( self.enemy ) )
        {
            if ( issentient( self.enemy ) && !isai( self.enemy ) )
            {
                disttoenemy = distance( damage_point, self.enemy.origin );
                
                if ( disttoenemy <= damage_radius )
                {
                    ai_in_radius[ ai_in_radius.size ] = self.enemy;
                }
            }
        }
        
        foreach ( ai in ai_in_radius )
        {
            if ( !isalive( ai ) || ai == self )
            {
                continue;
            }
            
            if ( ai.type == "zombie" )
            {
                if ( !ai._blackboard.zombieinknockdown )
                {
                    ai zombie_knockdown::function_6fc167d4a3590991( damage_point );
                }
                
                /#
                    if ( debug_bull_charge() )
                    {
                        line( damage_point, ai.origin, ( 1, 0, 0 ) );
                    }
                #/
            }
            
            if ( ai.team != self.team && !ai utility::ent_flag( "abom_bull_charge_hit" ) )
            {
                ai utility::ent_flag_set( "abom_bull_charge_hit" );
                ai thread utility::ent_flag_clear_delayed( "abom_bull_charge_hit", 2 );
                var_145ac622df0d6e20 = max( ai.maxhealth * 0.1, 100 );
                ai dodamage( var_145ac622df0d6e20, damage_point );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0xe0fc704f, Offset: 0x129e
// Size: 0xcf
function private function_1a6ba3a4ec0875e()
{
    earthquake( 0.5, 0.4, self.origin, 700 );
    var_899f13d46cd7e7c8 = 700;
    players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, var_899f13d46cd7e7c8 );
    
    foreach ( player in players )
    {
        player playrumbleonentity( "artillery_rumble_heavy" );
    }
    
    self function_786bb6aa1b76c7ee( "roar_end_time", 4000 );
    thread charge_stun_fx();
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0xaff802d5, Offset: 0x1375
// Size: 0x25
function private charge_stun_fx()
{
    self endon( #"death" );
    wait 0.1;
    utility::function_32b24db3127bff40( "charge_stun", "charge_stun" );
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0x6381ff33, Offset: 0x13a2
// Size: 0x114
function private roar_rumble_listener()
{
    self endon( #"death" );
    var_899f13d46cd7e7c8 = 700;
    
    while ( true )
    {
        self waittill( #"start_roar_loop" );
        utility::function_32b24db3127bff40( "roar_audio", "on" );
        thread function_f391cf40347040a7();
        
        while ( self getaiblackboarddynamic( "in_roar_loop" ) )
        {
            earthquake( 0.4, 1.5, self.origin, var_899f13d46cd7e7c8 );
            players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, var_899f13d46cd7e7c8 );
            
            foreach ( player in players )
            {
                if ( !player utility::ent_flag( "abom_roar_rumble" ) )
                {
                    thread roar_rumble_on_player( player, var_899f13d46cd7e7c8 );
                }
            }
            
            wait 1;
        }
    }
}

// Namespace namespace_a572abe18fc0aa97
// Params 0, eflags: 0x4
// Checksum 0xd9342898, Offset: 0x14be
// Size: 0x35
function private function_f391cf40347040a7()
{
    self endon( #"death" );
    
    while ( self getaiblackboarddynamic( "in_roar_loop" ) )
    {
        wait 0.25;
    }
    
    utility::function_32b24db3127bff40( "roar_audio", "off" );
}

// Namespace namespace_a572abe18fc0aa97
// Params 2, eflags: 0x4
// Checksum 0x5d44cb7, Offset: 0x14fb
// Size: 0xee
function private roar_rumble_on_player( player, var_899f13d46cd7e7c8 )
{
    player endon( #"death" );
    assert( !player utility::ent_flag( "<dev string:x249>" ) );
    player utility::ent_flag_set( "abom_roar_rumble" );
    player playrumblelooponentity( "steady_rumble" );
    
    while ( true )
    {
        var_6406b411db6be5c4 = isalive( self );
        var_142023f7e745d008 = 0;
        var_7eb7e23ce7ac5e38 = 0;
        
        if ( var_6406b411db6be5c4 )
        {
            var_48607cfdb87ffbae = distance2dsquared( self.origin, player.origin );
            var_142023f7e745d008 = var_48607cfdb87ffbae > squared( var_899f13d46cd7e7c8 );
            var_7eb7e23ce7ac5e38 = !self getaiblackboarddynamic( "in_roar_loop" );
        }
        
        if ( !var_6406b411db6be5c4 || var_7eb7e23ce7ac5e38 || var_142023f7e745d008 )
        {
            player utility::ent_flag_clear( "abom_roar_rumble" );
            player stoprumble( "steady_rumble" );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_a572abe18fc0aa97
// Params 1, eflags: 0x4
// Checksum 0x8ac14e9f, Offset: 0x15f1
// Size: 0x66
function private function_ca4724391a27eb8d( lookahead_dist_multiplier )
{
    var_bf08dc3cda0a683 = lookahead_dist_multiplier ?? 0.2;
    velocity = self.velocity;
    reduced_z_velocity = ( 0, 0, velocity[ 2 ] / 2 );
    var_ce4c30c67311cb7b = self.origin + ( velocity - reduced_z_velocity ) * var_bf08dc3cda0a683;
    return var_ce4c30c67311cb7b;
}

/#

    // Namespace namespace_a572abe18fc0aa97
    // Params 0
    // Checksum 0xc7194837, Offset: 0x1660
    // Size: 0x5a, Type: dev
    function function_51c81a5a4e5a7e4a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x25a>" );
        devgui::add_devgui_func( "<dev string:x277>", "<dev string:x289>", &force_bull_charge );
        devgui::add_devgui_func( "<dev string:x29b>", "<dev string:x2ad>", &function_ce912a3f5cfa2153 );
        devgui::add_devgui_func( "<dev string:x2bf>", "<dev string:x2ca>", &function_6167bd4dd082d22 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_a572abe18fc0aa97
    // Params 0, eflags: 0x4
    // Checksum 0xa143394, Offset: 0x16c2
    // Size: 0x7f, Type: dev
    function private force_bull_charge()
    {
        var_a4acf6c520b26c3d = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2d5>" );
        
        if ( !isdefined( var_a4acf6c520b26c3d ) )
        {
            var_a4acf6c520b26c3d = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2e1>" );
        }
        
        if ( !isdefined( var_a4acf6c520b26c3d ) )
        {
            return;
        }
        
        var_a4acf6c520b26c3d function_786bb6aa1b76c7ee( "<dev string:x2f2>", 4000 );
        var_a4acf6c520b26c3d function_786bb6aa1b76c7ee( "<dev string:x300>", 1 );
    }

    // Namespace namespace_a572abe18fc0aa97
    // Params 0, eflags: 0x4
    // Checksum 0xb766d1c, Offset: 0x1749
    // Size: 0x16, Type: dev
    function private debug_bull_charge()
    {
        return getdvarint( @"hash_9859e6325ac809fc", 0 ) > 0;
    }

    // Namespace namespace_a572abe18fc0aa97
    // Params 0, eflags: 0x4
    // Checksum 0xa7164fea, Offset: 0x1767
    // Size: 0x1a, Type: dev
    function private function_ce912a3f5cfa2153()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x30f>", @"hash_9859e6325ac809fc" );
    }

    // Namespace namespace_a572abe18fc0aa97
    // Params 0, eflags: 0x4
    // Checksum 0xfd83656b, Offset: 0x1789
    // Size: 0x7f, Type: dev
    function private function_6167bd4dd082d22()
    {
        var_a4acf6c520b26c3d = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2d5>" );
        
        if ( !isdefined( var_a4acf6c520b26c3d ) )
        {
            var_a4acf6c520b26c3d = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2e1>" );
        }
        
        if ( !isdefined( var_a4acf6c520b26c3d ) )
        {
            return;
        }
        
        var_a4acf6c520b26c3d function_786bb6aa1b76c7ee( "<dev string:x2f2>", 4000 );
        var_a4acf6c520b26c3d function_786bb6aa1b76c7ee( "<dev string:x326>", 1 );
    }

    // Namespace namespace_a572abe18fc0aa97
    // Params 2, eflags: 0x4
    // Checksum 0xf1e8ec, Offset: 0x1810
    // Size: 0x5b, Type: dev
    function private function_d5babdc51b90afcd( text, pos )
    {
        if ( debug_bull_charge() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x32e>" + text, ( 1, 0, 0 ) );
        }
    }

#/
