// script_647f89a5ad29de54  (hash_647f89a5ad29de54.gscc) (size: 10521 Bytes / 0x2919 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43a50bb0 (1134889904)
// size ...... 10521 (0x2919)
// includes .. 6   (offset: 0x2759)
// strings ... 11  (offset: 0x2789)
// dev strs .. 19  (offset: 0x2829)
// exports ... 30  (offset: 0x19e1)
// cseg ...... 0xee + 0x18f3 (0x19e1)
// imports ... 69  (offset: 0x1e91)
// animtree1 . 0   (offset: 0x2919)
// animtree2 . 0   (offset: 0x2919)
#using script_46e6a605b00ce67c;
#using script_640b69521097c6a5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\math;
#using scripts\common\utility;

#namespace namespace_aa44c48b952946c7;

// Namespace namespace_aa44c48b952946c7
// Params 4
// Checksum 0x19fe73f9, Offset: 0x10c
// Size: 0x69, Type: bool
function function_e0684a86e68e1dce( asmname, statename, tostatename, params )
{
    charge_result = function_93878015f3cac174();
    self function_786bb6aa1b76c7ee( "charge_result", charge_result );
    
    if ( charge_result == 2 )
    {
        function_766777eb71a8d2d6();
    }
    
    if ( charge_result != 0 )
    {
        asm::function_d82cb83c9c260d49( 1 );
    }
    
    return charge_result != 0;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x87c28ce7, Offset: 0x17e
// Size: 0x12b
function private function_93878015f3cac174()
{
    if ( zombie_stun::is_stunned() )
    {
        return 2;
    }
    
    if ( !function_5cc81d72313a23cc() )
    {
        return 2;
    }
    
    if ( self.var_a2638d3c0a211262 && !self getaiblackboarddynamic( "no_enemies_detected" ) )
    {
        if ( !self.var_ef3716baeb3bf171 )
        {
            if ( function_9d60c5a8cad973d3() )
            {
                self.var_ef3716baeb3bf171 = 1;
            }
            else
            {
                /#
                    charge_print( "<dev string:x24>" );
                #/
                
                return 2;
            }
        }
    }
    
    lookahead_result = function_16ee2f3c74433ddc();
    
    if ( lookahead_result != 0 )
    {
        return lookahead_result;
    }
    
    forward_now = anglestoforward( self.angles );
    back_now = forward_now * -1;
    var_4c31afcb4655c31a = get_charge_target_pos();
    dist_behind = vectordot( var_4c31afcb4655c31a - self.origin, back_now );
    
    if ( dist_behind > getdvarfloat( @"hash_b6069be07d5ffd9c", self.var_cbb999639e24fefa ) )
    {
        /#
            charge_print( "<dev string:x52>" );
        #/
        
        if ( function_5ab0ff58f870b957() )
        {
            return begin_charge_turn();
        }
        
        return 2;
    }
    
    /#
        if ( debug_charge() )
        {
            function_2b64cacb2d892633();
        }
    #/
    
    return 0;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x2b0065b4, Offset: 0x2b2
// Size: 0x199, Type: bool
function private function_9d60c5a8cad973d3()
{
    var_1d46774ca6c9c5b9 = 20;
    a_detected_players = self.var_2407eeb13e7a18 ?? [];
    
    if ( !a_detected_players.size )
    {
        return false;
    }
    
    forward = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    path_width = getdvarfloat( @"hash_e7225b45ca5b8a6", self.charge_impact_radius ) + var_1d46774ca6c9c5b9;
    path_length = self.var_ee97cb0dc3d17280 ? length2d( self.var_ee97cb0dc3d17280 - self.origin ) : 510;
    
    foreach ( player in a_detected_players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        var_c51215b779b5fe59 = ( player.origin[ 0 ] - self.origin[ 0 ], player.origin[ 1 ] - self.origin[ 1 ], 0 );
        forward_dist = vectordot( var_c51215b779b5fe59, forward );
        
        if ( forward_dist <= 0 || forward_dist > path_length )
        {
            continue;
        }
        
        lateral_dist = length( var_c51215b779b5fe59 - forward * forward_dist );
        
        if ( lateral_dist <= path_width )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0xae8f9fea, Offset: 0x454
// Size: 0x95
function private function_16ee2f3c74433ddc()
{
    if ( function_f847f8d6a6fc8460() )
    {
        if ( function_3ddc19af0f40c2ea( 260 ) )
        {
            /#
                charge_print( "<dev string:x66>" );
            #/
            
            return 2;
        }
        
        return 0;
    }
    
    if ( !self.var_bbf410354c080fd2 )
    {
        self.var_bbf410354c080fd2 = function_3ddc19af0f40c2ea( 510 );
        
        if ( !self.var_bbf410354c080fd2 )
        {
            return 0;
        }
    }
    
    if ( !function_3ddc19af0f40c2ea( 260 ) )
    {
        return 0;
    }
    
    self.var_8d997ae2ed25a10f = 260;
    
    if ( function_5ab0ff58f870b957() )
    {
        return begin_charge_turn();
    }
    
    /#
        charge_print( "<dev string:x81>" );
    #/
    
    return 2;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x534b78c8, Offset: 0x4f2
// Size: 0x12, Type: bool
function private function_f847f8d6a6fc8460()
{
    return self.var_1d1af87ed98220e5 >= function_68a3f9a7ec520d1();
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x3c2423a5, Offset: 0x50d
// Size: 0x46
function private function_68a3f9a7ec520d1()
{
    var_77882d7b603bb1ba = 4;
    var_fe2cdd14e156b484 = getdvarint( @"hash_5c4dabbd1ba0bc73", self.var_c2656b40a74679a9 );
    
    if ( self.var_a2638d3c0a211262 )
    {
        return max( var_fe2cdd14e156b484, var_77882d7b603bb1ba );
    }
    
    return var_fe2cdd14e156b484;
}

// Namespace namespace_aa44c48b952946c7
// Params 1, eflags: 0x4
// Checksum 0xf093f9fa, Offset: 0x55c
// Size: 0xeb
function private function_3ddc19af0f40c2ea( var_bf08dc3cda0a683 )
{
    var_ce4c30c67311cb7b = function_79852d5ebbf60813( var_bf08dc3cda0a683 );
    trace = navtrace( self.origin, var_ce4c30c67311cb7b, self, 1 );
    
    /#
        self.var_14042064a05acc4b = var_ce4c30c67311cb7b;
        self.var_aaef1c0f8c8c99be = undefined;
        self.var_2c35bd2d28a257ef = undefined;
    #/
    
    if ( trace[ "fraction" ] < 1 )
    {
        nearby_stinger = function_cd387a3827ee6d1b();
        
        if ( nearby_stinger )
        {
            return function_85035edab8201816( var_ce4c30c67311cb7b, var_bf08dc3cda0a683, nearby_stinger );
        }
        
        /#
            self.var_aaef1c0f8c8c99be = trace[ "<dev string:x99>" ];
            var_90ec0886f9ccf215 = trace[ "<dev string:xa2>" ];
            
            if ( var_90ec0886f9ccf215 )
            {
                self.var_2c35bd2d28a257ef = var_90ec0886f9ccf215.targetname ?? var_90ec0886f9ccf215.script_noteworthy ?? var_90ec0886f9ccf215.classname;
            }
        #/
        
        return 1;
    }
    
    return 0;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x6ff41062, Offset: 0x650
// Size: 0xb4
function private function_cd387a3827ee6d1b()
{
    ignore_range_sq = squared( function_dd1ffa4adab710f7() );
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( !isalive( stinger ) )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, stinger.origin ) <= ignore_range_sq )
        {
            return stinger;
        }
    }
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x6e856614, Offset: 0x70d
// Size: 0x3a
function private function_dd1ffa4adab710f7()
{
    var_bd97904c47587f18 = 80;
    var_fe16d0ec2b7a6917 = 15;
    return ( self.var_11e27b50f16bf174 ?? var_bd97904c47587f18 ) + getdvarfloat( @"hash_c9a998c7f7e2d84b", var_fe16d0ec2b7a6917 );
}

// Namespace namespace_aa44c48b952946c7
// Params 3, eflags: 0x4
// Checksum 0x428f1adb, Offset: 0x750
// Size: 0x11d, Type: bool
function private function_85035edab8201816( var_ce4c30c67311cb7b, var_bf08dc3cda0a683, stinger )
{
    var_46f9b7abe5601ff4 = vectornormalize2( var_ce4c30c67311cb7b - self.origin );
    var_73da20fd0e1f6cf5 = vectordot( stinger.origin - self.origin, var_46f9b7abe5601ff4 );
    var_7e560d85af76be24 = var_73da20fd0e1f6cf5 + function_dd1ffa4adab710f7();
    
    if ( var_7e560d85af76be24 >= var_bf08dc3cda0a683 )
    {
        return false;
    }
    
    var_69f1da2725cd036a = self.origin + var_46f9b7abe5601ff4 * var_7e560d85af76be24;
    trace = navtrace( var_69f1da2725cd036a, var_ce4c30c67311cb7b, self, 1 );
    
    /#
        if ( trace[ "<dev string:xa9>" ] < 1 )
        {
            self.var_aaef1c0f8c8c99be = trace[ "<dev string:x99>" ];
            var_90ec0886f9ccf215 = trace[ "<dev string:xa2>" ];
            
            if ( var_90ec0886f9ccf215 )
            {
                self.var_2c35bd2d28a257ef = var_90ec0886f9ccf215.targetname ?? var_90ec0886f9ccf215.script_noteworthy ?? var_90ec0886f9ccf215.classname;
            }
        }
    #/
    
    return trace[ "fraction" ] < 1;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x93fcedd7, Offset: 0x876
// Size: 0xb6, Type: bool
function private function_5ab0ff58f870b957()
{
    if ( function_d0cc4eb0f2c40b91() )
    {
        return false;
    }
    
    if ( self.var_1d1af87ed98220e5 >= function_68a3f9a7ec520d1() )
    {
        return false;
    }
    
    if ( self.var_a2638d3c0a211262 && !self getaiblackboarddynamic( "no_enemies_detected" ) )
    {
        return false;
    }
    
    if ( self.var_a2638d3c0a211262 )
    {
        self.var_ee97cb0dc3d17280 = function_9c857088d8d07e7c();
        
        if ( !self.var_ee97cb0dc3d17280 )
        {
            return false;
        }
        
        return true;
    }
    
    if ( function_c0394339655e55e7( self.charge_target, 1 ) )
    {
        return true;
    }
    
    self.charge_target = function_2840ace6d427c30b();
    
    if ( isalive( self.charge_target ) )
    {
        namespace_c57c4bda2cd4484a::function_5d712bb2b5876699( self.charge_target );
        return true;
    }
    
    return false;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x22ee919f, Offset: 0x935
// Size: 0x83, Type: bool
function private function_d0cc4eb0f2c40b91()
{
    if ( !self.var_c7a3c3c3948d55f9 || !self.var_62aa1e12007f1437 )
    {
        return false;
    }
    
    delta = self.origin - self.var_c7a3c3c3948d55f9;
    return abs( delta[ 0 ] ) <= self.var_62aa1e12007f1437[ 0 ] && abs( delta[ 1 ] ) <= self.var_62aa1e12007f1437[ 1 ] && abs( delta[ 2 ] ) <= self.var_62aa1e12007f1437[ 2 ];
}

// Namespace namespace_aa44c48b952946c7
// Params 0
// Checksum 0x419a40d2, Offset: 0x9c1
// Size: 0xb0
function function_9c857088d8d07e7c()
{
    var_8dded88f1bbe7697 = 45;
    
    if ( !isdefined( self.var_cb0f79c5c25b23f4 ) )
    {
        return;
    }
    
    var_2c4828419dca09c5 = vectornormalize2( self.var_cb0f79c5c25b23f4 - self.origin );
    charge_dir = rotatepointaroundvector( ( 0, 0, 1 ), var_2c4828419dca09c5, randomfloatrange( var_8dded88f1bbe7697 * -1, var_8dded88f1bbe7697 ) );
    trace_dist = getdvarfloat( @"hash_a99c861b3858d66d", 5000 );
    trace = navtrace( self.origin, self.origin + charge_dir * trace_dist, self, 1 );
    return trace[ "position" ];
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x8a2bd4fa, Offset: 0xa7a
// Size: 0xc5, Type: bool
function private begin_charge_turn()
{
    if ( !isdefined( self.var_8d997ae2ed25a10f ) )
    {
        self.var_8d997ae2ed25a10f = 260;
    }
    
    function_ff602d78795dcc6e();
    weyward_right_vec = anglestoright( self.angles );
    charge_turn_alias = vectordot( weyward_right_vec, get_charge_target_pos() - self.origin ) > 0 ? "right" : "left";
    self.charge_turn_direction = charge_turn_alias;
    self function_695b8e1b655c2796( "charge_turn", charge_turn_alias );
    self.var_83b85309a5e414ed = undefined;
    self.var_6bcb9c76ec6f1870 = ( 0, 0, 0 );
    self.var_bbf410354c080fd2 = 0;
    self.var_1d1af87ed98220e5 += 1;
    return true;
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0xccf76fb8, Offset: 0xb48
// Size: 0x80
function private function_ff602d78795dcc6e()
{
    var_1a585dfc606ad776 = 10;
    start_pos = self.origin;
    end_pos = start_pos + anglestoforward( self.angles ) * ( self.var_8d997ae2ed25a10f - var_1a585dfc606ad776 );
    end_pos = utility::drop_to_ground( end_pos );
    self.var_ebd26f6520cc1e89 = 0;
    self settraversalattributes( start_pos, end_pos, self.angles, end_pos );
    
    /#
        self.var_404380a5a2b10d34 = end_pos;
    #/
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x6ebefb5, Offset: 0xbd0
// Size: 0x70
function private function_766777eb71a8d2d6()
{
    var_1a585dfc606ad776 = 10;
    start_pos = self.origin;
    end_pos = start_pos + anglestoforward( self.angles ) * ( 260 - var_1a585dfc606ad776 );
    end_pos = utility::drop_to_ground( end_pos );
    self settraversalattributes( start_pos, end_pos, self.angles, end_pos );
    
    /#
        self.var_404380a5a2b10d34 = end_pos;
    #/
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0xd7bc335e, Offset: 0xc48
// Size: 0x175
function private function_2840ace6d427c30b()
{
    chargeable_players = [];
    
    foreach ( player in level.players )
    {
        if ( self.charge_target == player )
        {
            continue;
        }
        
        if ( function_c0394339655e55e7( player, 1 ) )
        {
            chargeable_players[ chargeable_players.size ] = player;
        }
    }
    
    if ( !chargeable_players.size )
    {
        /#
            self.var_9389fd9e3a844818 = undefined;
        #/
        
        return;
    }
    
    closest_target = undefined;
    closest_dist_sq = undefined;
    
    foreach ( player in chargeable_players )
    {
        dist_sq = distancesquared( self.origin, player.origin );
        
        if ( !closest_target || dist_sq < closest_dist_sq )
        {
            closest_target = player;
            closest_dist_sq = dist_sq;
        }
    }
    
    /#
        self.var_9389fd9e3a844818 = closest_target;
    #/
    
    return closest_target;
}

// Namespace namespace_aa44c48b952946c7
// Params 2, eflags: 0x4
// Checksum 0xfc18d4f3, Offset: 0xdc6
// Size: 0x13d, Type: bool
function private function_c0394339655e55e7( target, require_behind )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) && target.inlaststand )
    {
        return false;
    }
    
    target_pos = target.origin;
    
    if ( isplayer( target ) && target.var_940d7b16bf043325 )
    {
        landing_spot = function_633564ba53089520( target, target.origin, target getvelocity() );
        target.charge_knockback_landing_spot = landing_spot;
        
        if ( !landing_spot )
        {
            return false;
        }
        
        target_pos = landing_spot;
    }
    
    if ( isplayer( target ) && target.team == self.team )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, target_pos ) < squared( getdvarfloat( @"hash_bfa92105c9e37972", self.var_1a040542fe3e0928 ) ) )
    {
        return false;
    }
    
    if ( require_behind && math::is_point_in_front( target_pos ) )
    {
        return false;
    }
    
    nav_trace = navtrace( self.origin, target_pos, self, 1 );
    
    if ( nav_trace[ "fraction" ] < 0.95 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_aa44c48b952946c7
// Params 3
// Checksum 0x7f0909da, Offset: 0xf0c
// Size: 0x1b3
function function_633564ba53089520( ent, start_pos, velocity )
{
    var_2691a80dcaa37e26 = 800;
    var_b52616da90e31c73 = 4;
    var_5b7cf827cfb16121 = 0.05;
    vertical_speed = velocity[ 2 ];
    horizontal_vel = ( velocity[ 0 ], velocity[ 1 ], 0 );
    horizontal_speed = length( horizontal_vel );
    horizontal_dir = horizontal_speed > 0.001 ? vectornormalize( horizontal_vel ) : ( 0, 0, 0 );
    
    if ( vertical_speed > 0 )
    {
        var_31552df94d338841 = 2 * vertical_speed / var_2691a80dcaa37e26;
        var_a0231e92fb8cddd1 = start_pos + horizontal_dir * horizontal_speed * var_31552df94d338841;
    }
    else
    {
        var_a0231e92fb8cddd1 = start_pos + horizontal_dir * horizontal_speed * var_b52616da90e31c73;
    }
    
    landing_trace = navtrace( start_pos, var_a0231e92fb8cddd1, ent, 1 );
    var_8cd509590831d98 = landing_trace[ "position" ][ 2 ];
    airborne_time_s = 0;
    
    while ( airborne_time_s < var_b52616da90e31c73 )
    {
        airborne_time_s += var_5b7cf827cfb16121;
        simulated_z = start_pos[ 2 ] + vertical_speed * airborne_time_s - 0.5 * var_2691a80dcaa37e26 * airborne_time_s * airborne_time_s;
        
        if ( simulated_z <= var_8cd509590831d98 )
        {
            projected_end_pos = start_pos + horizontal_dir * horizontal_speed * airborne_time_s;
            landing_trace = navtrace( start_pos, projected_end_pos, ent, 1 );
            b_on_navmesh = landing_trace[ "fraction" ] >= 1;
            
            /#
                if ( debug_charge() )
                {
                    function_13ef72247f938ea( start_pos, horizontal_dir, horizontal_speed, vertical_speed, var_2691a80dcaa37e26, airborne_time_s, landing_trace[ "<dev string:x99>" ], b_on_navmesh );
                }
            #/
            
            if ( !b_on_navmesh )
            {
                return;
            }
            
            return landing_trace[ "position" ];
        }
    }
}

// Namespace namespace_aa44c48b952946c7
// Params 0
// Checksum 0x8058824c, Offset: 0x10c8
// Size: 0x29b
function function_3e1fc22f8d6ba1e8()
{
    if ( self.var_a2638d3c0a211262 && self.var_ee97cb0dc3d17280 )
    {
        self.charge_target = undefined;
    }
    else
    {
        self.charge_target = self.charge_attack_target;
        
        if ( isplayer( self.charge_target ) && self.charge_target.inlaststand )
        {
            self.charge_target = undefined;
        }
        
        if ( !self.charge_target || !isalive( self.charge_target ) )
        {
            self.charge_target = self.enemy;
            
            if ( isplayer( self.charge_target ) && self.charge_target.inlaststand )
            {
                self.charge_target = undefined;
            }
        }
        
        if ( !isalive( self.charge_target ) )
        {
            foreach ( player in level.players )
            {
                if ( isalive( player ) && function_c0394339655e55e7( player, 0 ) )
                {
                    self.charge_target = player;
                    break;
                }
            }
            
            if ( !self.charge_target || !isalive( self.charge_target ) )
            {
                self.charge_target = undefined;
                return;
            }
        }
    }
    
    if ( !self.var_a2638d3c0a211262 && isalive( self.charge_target ) )
    {
        namespace_c57c4bda2cd4484a::function_169e0fd0d1155118( "charge", self.charge_target );
    }
    
    self.charge_attack_target = undefined;
    self.charge_turn_direction = undefined;
    self.var_83b85309a5e414ed = undefined;
    self.var_6bcb9c76ec6f1870 = ( 0, 0, 0 );
    self.var_bbf410354c080fd2 = 0;
    self.var_8d997ae2ed25a10f = 510;
    self.var_1d1af87ed98220e5 = 1;
    self.var_ef3716baeb3bf171 = 0;
    
    /#
        self.var_404380a5a2b10d34 = undefined;
        self.var_9389fd9e3a844818 = undefined;
        self.var_14042064a05acc4b = undefined;
        self.var_aaef1c0f8c8c99be = undefined;
        self.var_2c35bd2d28a257ef = undefined;
    #/
    
    self clearbtgoal( 0 );
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:xb2>", "<dev string:xee>" );
        }
    #/
    
    asm::function_7256f5ba459c840b( "charge_in" );
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x4ac470e2, Offset: 0x136b
// Size: 0x54, Type: bool
function private function_5cc81d72313a23cc()
{
    return self.var_a2638d3c0a211262 && isdefined( self.var_ee97cb0dc3d17280 ) || isalive( self.charge_target ) && ( !isplayer( self.charge_target ) || !self.charge_target.inlaststand );
}

// Namespace namespace_aa44c48b952946c7
// Params 0, eflags: 0x4
// Checksum 0x27193bc7, Offset: 0x13c8
// Size: 0x6c
function private get_charge_target_pos()
{
    if ( self.var_a2638d3c0a211262 )
    {
        return self.var_ee97cb0dc3d17280;
    }
    
    if ( self.charge_target.var_940d7b16bf043325 && self.charge_target.charge_knockback_landing_spot )
    {
        return self.charge_target.charge_knockback_landing_spot;
    }
    
    return self.charge_target.origin;
}

// Namespace namespace_aa44c48b952946c7
// Params 0
// Checksum 0x4bf09ebf, Offset: 0x143d
// Size: 0x49, Type: bool
function is_in_charge_state()
{
    if ( isalive( self ) && isai( self ) && ( asm::asm_getcurrentstatename( self.asmname ) == "charge_intro" || asm::asm_getcurrentstatename( self.asmname ) == "charge_loop" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_aa44c48b952946c7
// Params 0
// Checksum 0xd9abbff6, Offset: 0x148f
// Size: 0xf, Type: bool
function is_charge_result_stop()
{
    return self getaiblackboarddynamic( "charge_result" ) == 2;
}

// Namespace namespace_aa44c48b952946c7
// Params 1, eflags: 0x4
// Checksum 0x4cb3a79c, Offset: 0x14a7
// Size: 0x46
function private function_79852d5ebbf60813( lookahead_dist_multiplier )
{
    var_bf08dc3cda0a683 = lookahead_dist_multiplier ?? 510;
    var_ce4c30c67311cb7b = self.origin + anglestoforward( self.angles ) * var_bf08dc3cda0a683;
    return var_ce4c30c67311cb7b;
}

/#

    // Namespace namespace_aa44c48b952946c7
    // Params 0, eflags: 0x4
    // Checksum 0x1bfe19a1, Offset: 0x14f6
    // Size: 0x16, Type: dev
    function private debug_charge()
    {
        return getdvarint( @"hash_34bb01539c3a8b10", 0 ) > 0;
    }

    // Namespace namespace_aa44c48b952946c7
    // Params 0, eflags: 0x4
    // Checksum 0x650d66cb, Offset: 0x1514
    // Size: 0x2e7, Type: dev
    function private function_2b64cacb2d892633()
    {
        if ( function_5cc81d72313a23cc() )
        {
            charge_target_pos = get_charge_target_pos();
            var_c2475684cedeca5e = !self.var_a2638d3c0a211262 && isalive( self.charge_target ) && self.charge_target.var_940d7b16bf043325 && self.charge_target.charge_knockback_landing_spot;
            charge_target_color = var_c2475684cedeca5e ? ( 1, 0.2, 0.9 ) : ( 1, 0.6, 0 );
            line( self.origin, charge_target_pos, charge_target_color );
            sphere( charge_target_pos, 22, charge_target_color );
            charge_print( var_c2475684cedeca5e ? "<dev string:xf8>" : "<dev string:x11d>", charge_target_pos + ( 0, 0, 34 ) );
        }
        
        if ( self.var_404380a5a2b10d34 )
        {
            line( self.origin, self.var_404380a5a2b10d34, ( 1, 0, 0 ) );
            sphere( self.var_404380a5a2b10d34, 20, ( 1, 0, 0 ) );
            charge_print( "<dev string:x12f>", self.var_404380a5a2b10d34 + ( 0, 0, 20 ) );
        }
        
        /#
            if ( self.var_14042064a05acc4b )
            {
                line( self.origin, self.var_14042064a05acc4b, ( 0.2, 0.8, 0.2 ) );
                sphere( self.var_14042064a05acc4b, 14, ( 0.2, 0.8, 0.2 ) );
                charge_print( "<dev string:x13d>", self.var_14042064a05acc4b + ( 0, 0, 20 ) );
            }
            
            if ( self.var_aaef1c0f8c8c99be )
            {
                line( self.origin, self.var_aaef1c0f8c8c99be, ( 0.95, 0.2, 0.95 ) );
                sphere( self.var_aaef1c0f8c8c99be, 16, ( 0.95, 0.2, 0.95 ) );
                var_1c3e7435f77b1b81 = self.var_2c35bd2d28a257ef ?? "<dev string:x14b>";
                charge_print( "<dev string:x153>" + var_1c3e7435f77b1b81, self.var_aaef1c0f8c8c99be + ( 0, 0, 20 ) );
            }
        #/
        
        if ( isalive( self.var_9389fd9e3a844818 ) )
        {
            line( self.origin, self.var_9389fd9e3a844818.origin, ( 0.1, 0.8, 1 ) );
            sphere( self.var_9389fd9e3a844818.origin, 28, ( 0.1, 0.8, 1 ) );
            charge_print( "<dev string:x162>", self.var_9389fd9e3a844818.origin + ( 0, 0, 70 ) );
        }
    }

    // Namespace namespace_aa44c48b952946c7
    // Params 8, eflags: 0x4
    // Checksum 0xef3a363d, Offset: 0x1803
    // Size: 0x17b, Type: dev
    function private function_13ef72247f938ea( start_pos, horizontal_dir, horizontal_speed, vertical_speed, gravity, landing_time_s, landing_pos, b_on_navmesh )
    {
        var_cc9efba54db89ec1 = 0.05;
        arc_color = b_on_navmesh ? ( 0.2, 0.9, 1 ) : ( 1, 0.35, 0.1 );
        landing_color = b_on_navmesh ? ( 0.2, 1, 0.2 ) : ( 1, 0.1, 0.1 );
        var_1a1170342901570a = start_pos;
        t = 0;
        
        while ( t < landing_time_s )
        {
            t = min( t + var_cc9efba54db89ec1, landing_time_s );
            point = ( start_pos[ 0 ] + horizontal_dir[ 0 ] * horizontal_speed * t, start_pos[ 1 ] + horizontal_dir[ 1 ] * horizontal_speed * t, start_pos[ 2 ] + vertical_speed * t - 0.5 * gravity * t * t );
            line( var_1a1170342901570a, point, arc_color );
            var_1a1170342901570a = point;
        }
        
        sphere( landing_pos, 18, landing_color );
        line( landing_pos, landing_pos + ( 0, 0, 70 ), landing_color );
        charge_print( b_on_navmesh ? "<dev string:x16f>" : "<dev string:x181>", landing_pos + ( 0, 0, 80 ) );
    }

    // Namespace namespace_aa44c48b952946c7
    // Params 2
    // Checksum 0x97f8b002, Offset: 0x1986
    // Size: 0x5b, Type: dev
    function charge_print( text, pos )
    {
        if ( debug_charge() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x1a1>" + text, ( 0.2, 0.8, 0.2 ) );
        }
    }

#/
