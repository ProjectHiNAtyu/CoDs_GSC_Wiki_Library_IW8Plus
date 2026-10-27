// script_80384e18a067d91  (hash_080384e18a067d91.gscc) (size: 4971 Bytes / 0x136b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4fc05f4d (1338007373)
// size ...... 4971 (0x136b)
// includes .. 8   (offset: 0x1213)
// strings ... 12  (offset: 0x1253)
// dev strs .. 10  (offset: 0x12f3)
// exports ... 11  (offset: 0xb47)
// cseg ...... 0xf1 + 0xa56 (0xb47)
// imports ... 41  (offset: 0xcff)
// animtree1 . 0   (offset: 0x136b)
// animtree2 . 0   (offset: 0x136b)
#using script_1fc20b38e0fc8291;
#using script_46e6a605b00ce67c;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug;

#namespace zombie_weyward_move;

// Namespace zombie_weyward_move
// Params 0
// Checksum 0x470db331, Offset: 0x10f
// Size: 0x2
function function_e4d8e5546536614f()
{
    
}

// Namespace zombie_weyward_move
// Params 0
// Checksum 0x9e2301ee, Offset: 0x119
// Size: 0x48
function init_zombie_weyward_move()
{
    self.var_a91bd029284b1261 = getdvarint( @"hash_a1f1fbbb2b1d18f7", 1 );
    self.turnrate = getdvarfloat( @"weyward_turn_rate", 0.1 );
    self function_786bb6aa1b76c7ee( "in_move_turn", 0 );
    thread update_speed();
}

// Namespace zombie_weyward_move
// Params 0, eflags: 0x4
// Checksum 0x44cc7cd3, Offset: 0x169
// Size: 0x34a
function private update_speed()
{
    self endon( #"death" );
    self.norm_speed = 0;
    
    while ( true )
    {
        var_316149904859a0e = getdvarfloat( @"weyward_speed", -1 );
        
        if ( var_316149904859a0e > 0 )
        {
            self aisetdesiredspeed( var_316149904859a0e );
            self aisettargetspeed( var_316149904859a0e );
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "in_melee" ) )
        {
            waitframe();
            continue;
        }
        
        speed_range = undefined;
        
        if ( asm_bb::bb_movetyperequested( "run" ) )
        {
            speed_range = [ 260, getdvarfloat( @"hash_1a0eb0fd8cdd198a", 350 ) ];
        }
        else if ( asm_bb::bb_movetyperequested( "walk" ) )
        {
            speed_range = [ 150, getdvarfloat( @"hash_4fd588e67f963012", 210 ) ];
        }
        
        if ( !isdefined( speed_range ) )
        {
            waitframe();
            continue;
        }
        
        var_73907523da8accb4 = getdvarfloat( @"hash_b6fdcb9b404ef572", 1 );
        var_4d395e738e5475e0 = getdvarfloat( @"hash_2e5344b7474fceec", 2 );
        var_f94281509c5def5 = getdvarfloat( @"hash_d97fc82bdda9ab95", 250 );
        var_5950ad72c654d5c1 = level.framedurationseconds / var_73907523da8accb4;
        var_7d1a27a574d80981 = level.framedurationseconds / var_4d395e738e5475e0;
        is_recently_damaged = isdefined( self.last_dmg_struct.timehit ) && gettime() - self.last_dmg_struct.timehit < var_f94281509c5def5;
        var_1e709a6c59e3ec5d = 0;
        var_bfd9a1b518cc6aa6 = self.health / self.maxhealth;
        
        if ( var_bfd9a1b518cc6aa6 > 0.5 && var_bfd9a1b518cc6aa6 < 0.75 || var_bfd9a1b518cc6aa6 < 0.25 )
        {
            var_1e709a6c59e3ec5d = 0.5;
        }
        
        var_12232b932fba82de = var_1e709a6c59e3ec5d;
        
        if ( is_recently_damaged )
        {
            var_12232b932fba82de = 1;
        }
        else if ( isdefined( self.enemy ) )
        {
            var_68e2834572008705 = distance( self.enemy.origin, self.origin );
            max_dist = 1000;
            
            if ( var_68e2834572008705 < max_dist )
            {
                var_12232b932fba82de = 1 - math::remap( var_68e2834572008705, 300, max_dist, var_1e709a6c59e3ec5d, 1 );
            }
        }
        
        if ( var_12232b932fba82de > self.norm_speed )
        {
            self.norm_speed = min( self.norm_speed + var_5950ad72c654d5c1, var_12232b932fba82de );
        }
        else if ( var_12232b932fba82de < self.norm_speed )
        {
            self.norm_speed = max( self.norm_speed - var_7d1a27a574d80981, var_12232b932fba82de );
        }
        
        new_speed = math::remap( self.norm_speed, 0, 1, speed_range[ 0 ], speed_range[ 1 ] );
        new_speed *= self.var_4d4dba5080e52e89 ?? 1;
        self aisetdesiredspeed( new_speed );
        self aisettargetspeed( new_speed );
        
        /#
            if ( debug_move() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x24>" + self.norm_speed + "<dev string:x37>" + new_speed, ( 0.5, 0.7, 0.5 ), 1, 1.2 );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_weyward_move
// Params 4
// Checksum 0xc36cfd0f, Offset: 0x4bb
// Size: 0x187, Type: bool
function function_e8a03612c9e074d2( asmname, statename, tostatename, params )
{
    if ( zombie_stun::is_stunned() )
    {
        return false;
    }
    
    if ( self.var_59a67f4a2bd3b5f7 || self.var_9c344f8b4d3d4884 || utility::ent_flag( "in_dash" ) )
    {
        return false;
    }
    
    move_turn_target = get_move_turn_target();
    var_d2a5c08c61e99d85 = namespace_c57c4bda2cd4484a::function_4ba53d85ae1fd91c();
    
    if ( !isdefined( move_turn_target ) || !isalive( move_turn_target ) )
    {
        move_turn_path = self getpath( 1 );
        
        if ( !isdefined( move_turn_path ) || move_turn_path.size == 0 )
        {
            return false;
        }
        
        move_turn_target_pos = move_turn_path[ 0 ];
    }
    else
    {
        move_turn_target_pos = move_turn_target.origin;
    }
    
    to_enemy_dir = vectornormalize( move_turn_target_pos - self.origin );
    forward_dir = anglestoforward( self.angles );
    var_28f520279565e71e = vectordot( forward_dir, to_enemy_dir );
    
    if ( var_28f520279565e71e <= 0.4 && ( var_d2a5c08c61e99d85 || !zombie_weyward_dash::function_43a5a5d8f21362b8() ) )
    {
        self.var_586e492099e32b94 = vectortoyaw( to_enemy_dir );
        target_yaw_delta = angleclamp180( self.var_586e492099e32b94 - self.angles[ 1 ] );
        self.move_turn_direction = target_yaw_delta >= 0 ? 1 : -1;
        self.move_turn_target_pos = move_turn_target_pos;
        return true;
    }
    
    return false;
}

// Namespace zombie_weyward_move
// Params 4
// Checksum 0xf01948ee, Offset: 0x64b
// Size: 0x11f
function function_3ee0cd12cb1d87f2( asmname, statename, tostatename, params )
{
    if ( zombie_stun::is_stunned() )
    {
        self function_786bb6aa1b76c7ee( "in_move_turn", 0 );
        return;
    }
    
    if ( self.var_59a67f4a2bd3b5f7 || self.var_9c344f8b4d3d4884 || utility::ent_flag( "in_dash" ) )
    {
        self function_786bb6aa1b76c7ee( "in_move_turn", 0 );
        return;
    }
    
    move_turn_alias = self.move_turn_direction == 1 ? "left" : "right";
    self function_695b8e1b655c2796( "move_turn", move_turn_alias );
    
    /#
        if ( debug_move() )
        {
            println( "<dev string:x43>" + move_turn_alias + "<dev string:x5e>" + self.angles[ 1 ] + "<dev string:x65>" + self.var_586e492099e32b94 );
        }
    #/
    
    animid = asm::asm_getanim( asmname, statename );
    
    if ( animid != -1 )
    {
        thread asm::asm_playanimstate( asmname, statename, params );
        thread function_490a0706b110aeff();
        return;
    }
    
    self function_786bb6aa1b76c7ee( "in_move_turn", 0 );
}

// Namespace zombie_weyward_move
// Params 0, eflags: 0x4
// Checksum 0xcc7b8db5, Offset: 0x772
// Size: 0x274
function private function_490a0706b110aeff()
{
    self endon( #"death" );
    self endon( #"move_turn_end" );
    self endon( #"move_turn_orient_end" );
    move_turn_target = get_move_turn_target();
    
    if ( isdefined( move_turn_target ) && isalive( move_turn_target ) )
    {
        enemy_pos = move_turn_target.origin;
    }
    else
    {
        enemy_pos = self.move_turn_target_pos;
    }
    
    to_enemy_dir = vectornormalize( enemy_pos - self.origin );
    forward_dir = anglestoforward( self.angles );
    var_28f520279565e71e = vectordot( forward_dir, to_enemy_dir );
    turn_rate_min = getdvarfloat( @"hash_c1a064042f9e6767", 0.5 );
    turn_rate_max = getdvarfloat( @"hash_c1c352042fc48789", 0.8 );
    var_29e02dab080043bc = self.turnrate;
    move_turn_turnrate = math::remap( var_28f520279565e71e, -1, 0.4, turn_rate_max, turn_rate_min );
    thread move_turn_orient_end( var_29e02dab080043bc );
    self waittill( #"hash_9661bf246d6cd509" );
    last_target_pos = enemy_pos;
    
    while ( true )
    {
        self.turnrate = move_turn_turnrate;
        move_turn_target = get_move_turn_target();
        
        if ( !isalive( move_turn_target ) )
        {
            target_pos = last_target_pos;
        }
        else
        {
            target_pos = move_turn_target.origin;
        }
        
        target_yaw = vectortoyaw( target_pos - self.origin );
        target_yaw_delta = angleclamp180( target_yaw - self.angles[ 1 ] );
        
        /#
            if ( debug_move() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x73>" + target_yaw + "<dev string:x8a>" + target_yaw_delta + "<dev string:x97>" + target_pos, ( 0.2, 0.8, 1 ), 1, 1.2 );
                dist = distance( self.origin, target_pos );
                var_209713b4c3b299a8 = self.origin + anglestoforward( ( 0, target_yaw, 0 ) ) * dist;
                level thread debug::drawline( self.origin, var_209713b4c3b299a8, 0.5, ( 0, 0, 1 ) );
            }
        #/
        
        self orientmode( "face angle", target_yaw );
        last_target_pos = target_pos;
        waitframe();
    }
}

// Namespace zombie_weyward_move
// Params 0, eflags: 0x4
// Checksum 0xaba4ace4, Offset: 0x9ee
// Size: 0x22, Type: bool
function private get_move_turn_target()
{
    var_d2a5c08c61e99d85 = namespace_c57c4bda2cd4484a::function_4ba53d85ae1fd91c();
    return var_d2a5c08c61e99d85 ?? self.enemy;
}

// Namespace zombie_weyward_move
// Params 1, eflags: 0x4
// Checksum 0x1f1db94b, Offset: 0xa19
// Size: 0x4a
function private move_turn_orient_end( var_29e02dab080043bc )
{
    self endon( #"death" );
    utility::waittill_any_in_array_or_timeout( [ "move_turn_end", "move_turn_orient_end" ], 5 );
    self.turnrate = var_29e02dab080043bc;
    self orientmode( "face enemy" );
}

// Namespace zombie_weyward_move
// Params 1, eflags: 0x4
// Checksum 0x65b9e92d, Offset: 0xa6b
// Size: 0xc0
function private function_34603a4d629f26c8( target )
{
    var_ac81d876a4bc6d3b = 1000000;
    distance_to_target = clamp( distancesquared( self.origin, target.origin ), 0, var_ac81d876a4bc6d3b );
    prediction_time = math::remap( distance_to_target, var_ac81d876a4bc6d3b, 0, getdvarfloat( @"hash_15232c74dd3e5ed2", 0.1 ), getdvarfloat( @"hash_14ff3674dd15fa18", 0.5 ) );
    var_df9adb69b75ff5f3 = target getvelocity();
    
    /#
        if ( debug_move() )
        {
            println( "<dev string:xa5>" + var_df9adb69b75ff5f3 + "<dev string:xc1>" + prediction_time );
        }
    #/
    
    return target.origin + var_df9adb69b75ff5f3 * prediction_time;
}

// Namespace zombie_weyward_move
// Params 0, eflags: 0x4
// Checksum 0xd79ff40d, Offset: 0xb34
// Size: 0x12, Type: bool
function private debug_move()
{
    return getdvarint( @"hash_1fe0a6ca689647ad", 0 ) > 0;
}

