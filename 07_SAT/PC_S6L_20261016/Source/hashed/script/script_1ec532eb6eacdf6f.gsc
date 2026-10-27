// script_1ec532eb6eacdf6f  (hash_1ec532eb6eacdf6f.gscc) (size: 12077 Bytes / 0x2f2d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3bc0e461 (1002497121)
// size ...... 12077 (0x2f2d)
// includes .. 6   (offset: 0x2d41)
// strings ... 16  (offset: 0x2d71)
// dev strs .. 18  (offset: 0x2e51)
// exports ... 24  (offset: 0x1ea9)
// cseg ...... 0x15c + 0x1d4d (0x1ea9)
// imports ... 84  (offset: 0x2269)
// animtree1 . 0   (offset: 0x2f2d)
// animtree2 . 0   (offset: 0x2f2d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_3156272e8cb1d737;

// Namespace namespace_3156272e8cb1d737
// Params 0
// Checksum 0x6161b7cf, Offset: 0x17a
// Size: 0x55
function function_76eb282120e46bc6()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c430d655e960cdd4 )
    {
        utility::add_fx( "weyward_downed_attack_beam", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c430d655e960cdd4 );
    }
    
    /#
        function_be24e54f5f0026a7();
    #/
}

// Namespace namespace_3156272e8cb1d737
// Params 0
// Checksum 0xb40f2fd3, Offset: 0x1d7
// Size: 0x1e6
function function_c30fcfbe8423b180()
{
    self.var_1b1b971af5d4da6f = [];
    self.var_8a9deea3bbabb237 = [];
    self.var_dbc00b9502a3c1b0 = [];
    thread function_735885cde63e532e();
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.downed_attack_range = settings.var_12c5810a1f5cdf34 ?? 3000;
    self.var_45eddbd53ef4a2e2 = settings.var_64636e132ff8afaf ?? 3;
    self.var_a89a1c44c52f8c5c = settings.var_c3806012328f25a ?? 80;
    self.downed_attack_beam_dist = settings.var_a2686332b5984c78 ?? 100;
    self.var_9b604197c5bc9264 = settings.var_c8bbf37c55563917 ?? 60;
    self.var_47f909a7b135bd7b = settings.var_f429a2b25886e611 ?? 5;
    self.var_e46cf013bb2f61a4 = settings.var_37684f3c6312d46d ?? 20;
    self.var_2a034636f4fb6cf6 = settings.var_29732cdef33dcd1f ?? 50;
    self.var_6722e8daa105bc93 = settings.var_8bff086ae9d6868f ?? 1.5;
    self.var_3716ec8f6e2ec2d4 = settings.var_e409fd2f93d9a9c8 ?? 2;
    self.var_92a97f00257ba24b = settings.var_3f7bb2b88716e688 ?? 1;
    self.var_5e921636375a534d = settings.var_97d38efc1764065c ?? 10;
    self.var_28bce4e1acdd461b = settings.var_cbc6a67b23c0ceac ?? 0.4;
    self.var_72d983bca9be2681 = settings.var_fb9fe9b63e6e4a60 ?? 8;
    self.var_716ccecbcce893bf = settings.var_4d964924db8c59f0 ?? 0.3;
    self.var_bc1b4e49d3cdb40a = settings.var_5d55b28f119b3744 ?? 1;
}

// Namespace namespace_3156272e8cb1d737
// Params 2
// Checksum 0x52d8388a, Offset: 0x3c5
// Size: 0x17a
function function_e96a54e85618b368( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( !getdvarint( @"hash_b1364919978e2b70", self.var_bc1b4e49d3cdb40a ) )
    {
        return anim.failure;
    }
    
    range = getdvarfloat( @"hash_b74dfd879aeaa40", self.downed_attack_range );
    enemies = self function_f017e352a29a57a1( self.origin, range, 0 );
    spawned_any = 0;
    
    foreach ( enemy in enemies )
    {
        if ( !isplayer( enemy ) || !isalive( enemy ) )
        {
            continue;
        }
        
        if ( !enemy.inlaststand )
        {
            continue;
        }
        
        if ( function_d2be69694ec7bdc7( enemy ) )
        {
            continue;
        }
        
        if ( function_6135c7dc95773a9d( enemy ) )
        {
            spawned_any = 1;
        }
    }
    
    if ( spawned_any )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0x5d5e1db1, Offset: 0x548
// Size: 0x1a0, Type: bool
function private function_d2be69694ec7bdc7( player )
{
    foreach ( wither in self.var_1b1b971af5d4da6f )
    {
        if ( isalive( wither ) && isdefined( wither.downed_target ) && wither.downed_target == player )
        {
            return true;
        }
    }
    
    if ( isdefined( self.var_8a9deea3bbabb237 ) )
    {
        foreach ( pending_player in self.var_8a9deea3bbabb237 )
        {
            if ( pending_player == player )
            {
                return true;
            }
        }
    }
    
    foreach ( pending_player in self.var_dbc00b9502a3c1b0 )
    {
        if ( pending_player == player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0x99f76cf, Offset: 0x6f1
// Size: 0x65, Type: bool
function private function_6135c7dc95773a9d( target_player )
{
    if ( !isalive( target_player ) || !target_player.inlaststand || function_d2be69694ec7bdc7( target_player ) || utility::flag( "playing_game_over_scene" ) )
    {
        return false;
    }
    
    self.var_dbc00b9502a3c1b0[ self.var_dbc00b9502a3c1b0.size ] = target_player;
    thread function_e3f4d5e5cda6c58f( target_player );
    return true;
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0xacd9f229, Offset: 0x75f
// Size: 0x2c7
function private function_e3f4d5e5cda6c58f( target_player )
{
    function_3fde749fb7d52be5();
    spawn_pos = self.origin;
    wither = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_downed" ), spawn_pos, ( 0, 0, 0 ), self.team );
    
    while ( !wither && isalive( self ) && isalive( target_player ) && target_player.inlaststand )
    {
        zombies = arrayrandomize( getaiarray( "team_two_hundred" ) );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || issubstr( zombie.subclass, "zombie_weyward" ) || issubstr( zombie.subclass, "zombie_wither" ) || issubstr( zombie.subclass, "hvt" ) )
            {
                continue;
            }
            
            zombie.nocorpse = 1;
            zombie kill();
            waitframe();
            waitframe();
            break;
        }
        
        wither = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_downed" ), spawn_pos, ( 0, 0, 0 ), self.team );
        
        if ( wither )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( !wither )
    {
        function_e5a23c51b07dfa2a( target_player );
        return;
    }
    
    wither.downed_target = target_player;
    wither.downed_owner = self;
    callback::callback( "on_summoned_by_weyward", { #ent:wither } );
    wither.downed_carrier = utility::spawn_tag_origin( self.origin );
    wither thread utility::delete_on_death( wither.downed_carrier );
    wither linkto( wither.downed_carrier, "tag_origin" );
    wither.downed_start_time = gettime();
    function_e5a23c51b07dfa2a( target_player );
    self.var_1b1b971af5d4da6f[ self.var_1b1b971af5d4da6f.size ] = wither;
    thread function_9109c2d03ae9cdf9( wither, target_player );
    wither callback::add( #"on_ai_killed", &function_26cf60520af4f4e6, { #target_player:target_player, #wither:wither } );
    
    /#
        if ( function_bac4a6048348f708() )
        {
            println( "<dev string:x24>" + target_player.origin + "<dev string:x59>" + self.var_1b1b971af5d4da6f.size );
        }
    #/
}

// Namespace namespace_3156272e8cb1d737
// Params 2, eflags: 0x4
// Checksum 0x3655bae9, Offset: 0xa2e
// Size: 0x452
function private function_9109c2d03ae9cdf9( wither, target_player )
{
    self endon( #"death" );
    wither endon( #"death" );
    var_e5bcedf0231124f = getdvarfloat( @"hash_89bf806c1d771ed8", self.var_45eddbd53ef4a2e2 );
    move_speed = getdvarfloat( @"hash_333864ce2798d7f6", self.var_a89a1c44c52f8c5c );
    beam_dist = getdvarfloat( @"weyward_downed_attack_beam_dist", self.downed_attack_beam_dist );
    wall_margin = getdvarfloat( @"hash_732e6933784d73e", self.var_e46cf013bb2f61a4 );
    var_2c075fa23c46910f = getdvarfloat( @"hash_ae6240df48aaab32", self.var_9b604197c5bc9264 );
    var_48ee71281f56f926 = gettime();
    
    while ( true )
    {
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        if ( !isalive( target_player ) || !target_player.inlaststand || utility::flag( "playing_game_over_scene" ) )
        {
            function_813a05ad84ca2874( wither );
            return;
        }
        
        if ( target_player.b_teleport_back || !target_player isonground() )
        {
            waitframe();
            continue;
        }
        
        horiz_dist = distance2d( wither.downed_carrier.origin, target_player.origin );
        goal_pos = target_player.origin + ( 0, 0, get_adaptive_fly_height( target_player.origin, var_2c075fa23c46910f, getdvarfloat( @"hash_7a7c9b578474cc31", self.var_47f909a7b135bd7b ), horiz_dist, beam_dist ) );
        carrier_pos = wither.downed_carrier.origin;
        dir_to_target = goal_pos - carrier_pos;
        dist_to_target = length( dir_to_target );
        
        if ( dist_to_target <= beam_dist )
        {
            break;
        }
        
        if ( dist_to_target > 0.1 )
        {
            proximity_speed_scale = clamp( horiz_dist / beam_dist, 0.2, 1 );
            effective_speed = move_speed * proximity_speed_scale;
            movement = vectornormalize( dir_to_target ) * effective_speed * dt;
            
            if ( length( movement ) > dist_to_target )
            {
                movement = dir_to_target;
            }
            
            new_pos = carrier_pos + movement;
            trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
            trace_result = trace::ray_trace( carrier_pos, new_pos, undefined, trace_contents );
            
            if ( trace_result[ "fraction" ] < 1 )
            {
                hit_pos = trace_result[ "position" ];
                var_3cb607c143ecc1a3 = trace_result[ "normal" ];
                
                if ( isdefined( var_3cb607c143ecc1a3 ) && length( var_3cb607c143ecc1a3 ) > 0.1 )
                {
                    var_4b93e11d422da79d = vectordot( vectornormalize( dir_to_target ), var_3cb607c143ecc1a3 );
                    slide_dir = vectornormalize( dir_to_target ) - var_3cb607c143ecc1a3 * var_4b93e11d422da79d;
                    
                    if ( length( slide_dir ) > 0.1 )
                    {
                        new_pos = carrier_pos + vectornormalize( slide_dir ) * move_speed * dt;
                    }
                    else
                    {
                        new_pos = hit_pos + var_3cb607c143ecc1a3 * wall_margin;
                    }
                }
                else
                {
                    new_pos = hit_pos;
                }
            }
            
            wobble_offset = function_ca55e92444cf63a4( wither, current_time ) * dt;
            bob_offset = function_21bc6c6a38af9698( wither, current_time ) * dt;
            wither.downed_carrier.origin = new_pos + wobble_offset + bob_offset;
        }
        
        if ( dist_to_target > 1 )
        {
            face_angles = vectortoangles( dir_to_target );
            wither.downed_carrier.angles = ( 0, face_angles[ 1 ], 0 );
        }
        
        /#
            if ( function_bac4a6048348f708() )
            {
                line( carrier_pos, goal_pos, ( 1, 0, 0.5 ) );
                sphere( carrier_pos, 10, ( 1, 0, 0.5 ) );
                print3d( carrier_pos + ( 0, 0, 30 ), "<dev string:x63>" + int( dist_to_target ), ( 1, 0, 0.5 ), 0.5, 0.5 );
            }
        #/
        
        waitframe();
    }
    
    function_5ad6e7ba0e1c2af8( wither, target_player );
}

// Namespace namespace_3156272e8cb1d737
// Params 2, eflags: 0x4
// Checksum 0x9a565131, Offset: 0xe88
// Size: 0x5ba
function private function_5ad6e7ba0e1c2af8( wither, target_player )
{
    self endon( #"death" );
    wither endon( #"death" );
    hover_dist = getdvarfloat( @"hash_30603f15a9b7893c", self.var_2a034636f4fb6cf6 );
    var_2c075fa23c46910f = getdvarfloat( @"hash_ae6240df48aaab32", self.var_9b604197c5bc9264 );
    fly_height_min = getdvarfloat( @"hash_7a7c9b578474cc31", self.var_47f909a7b135bd7b );
    hover_steer = getdvarfloat( @"hash_46a2b29ed22ab539", self.var_6722e8daa105bc93 );
    wall_margin = getdvarfloat( @"hash_732e6933784d73e", self.var_e46cf013bb2f61a4 );
    bleedout_scale = getdvarfloat( @"hash_6c84106fddc5100a", self.var_3716ec8f6e2ec2d4 );
    beam_vfx_setting = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c430d655e960cdd4;
    
    if ( isdefined( beam_vfx_setting ) )
    {
        wither.downed_beam_fx = playfxontagsbetweenclients( utility::getfx( "weyward_downed_attack_beam" ), wither, "j_skull_jaw", target_player, "j_mainroot" );
        wither utility::function_7c10ea82c1e305b8( "eyes", "on" );
        wither thread utility::delete_on_death( wither.downed_beam_fx );
        target_player utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4ef7e184952de7dc } );
    }
    
    var_369a76b86c78d261 = target_player.bleedout_speed_scale ?? 1;
    target_player.bleedout_speed_scale = bleedout_scale;
    wither.var_4707684c913806ff = var_369a76b86c78d261;
    wither.var_87f4d765d3a39467 = 1;
    target_player notify( #"hash_cf5205c433f5bc80", wither );
    
    /#
        if ( function_bac4a6048348f708() )
        {
            println( "<dev string:x6a>" + bleedout_scale );
        }
    #/
    
    var_48ee71281f56f926 = gettime();
    
    while ( true )
    {
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        if ( !isalive( target_player ) || !target_player.inlaststand )
        {
            function_f382a9a4d9b47401( wither );
            function_813a05ad84ca2874( wither );
            return;
        }
        
        if ( target_player.b_teleport_back || !target_player isonground() )
        {
            waitframe();
            continue;
        }
        
        horiz_dist = distance2d( wither.downed_carrier.origin, target_player.origin );
        v_player_front = target_player.origin + anglestoforward( target_player.angles ) * hover_dist / 2;
        adaptive_height = get_adaptive_fly_height( v_player_front, var_2c075fa23c46910f, fly_height_min, horiz_dist, hover_dist );
        goal_pos = v_player_front + ( 0, 0, adaptive_height );
        carrier_pos = wither.downed_carrier.origin;
        dir_to_goal = goal_pos - carrier_pos;
        dist_to_goal = length( dir_to_goal );
        
        if ( dist_to_goal < 40 )
        {
            dir_to_goal = ( 0, 0, 0 );
        }
        
        smooth_factor = clamp( hover_steer * dt, 0, 0.5 );
        movement = dir_to_goal * smooth_factor;
        new_pos = carrier_pos + movement;
        trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
        trace_result = trace::ray_trace( carrier_pos, new_pos, undefined, trace_contents );
        
        if ( trace_result[ "fraction" ] < 1 )
        {
            var_3cb607c143ecc1a3 = trace_result[ "normal" ];
            
            if ( isdefined( var_3cb607c143ecc1a3 ) && length( var_3cb607c143ecc1a3 ) > 0.1 )
            {
                var_4b93e11d422da79d = vectordot( vectornormalize( dir_to_goal ), var_3cb607c143ecc1a3 );
                slide_dir = vectornormalize( dir_to_goal ) - var_3cb607c143ecc1a3 * var_4b93e11d422da79d;
                
                if ( length( slide_dir ) > 0.1 )
                {
                    new_pos = carrier_pos + vectornormalize( slide_dir ) * length( movement );
                }
                else
                {
                    new_pos = trace_result[ "position" ] + var_3cb607c143ecc1a3 * wall_margin;
                }
            }
        }
        
        wobble_offset = function_ca55e92444cf63a4( wither, current_time ) * dt;
        bob_offset = function_21bc6c6a38af9698( wither, current_time ) * dt;
        wither.downed_carrier.origin = new_pos + wobble_offset + bob_offset;
        dir_to_player = target_player.origin - wither.downed_carrier.origin;
        
        if ( length( dir_to_player ) > 0.1 )
        {
            face_angles = vectortoangles( dir_to_player );
            wither.downed_carrier.angles = ( 0, face_angles[ 1 ], 0 );
        }
        
        /#
            if ( function_bac4a6048348f708() )
            {
                line( wither.downed_carrier.origin, target_player.origin, ( 1, 0, 0 ) );
                print3d( wither.downed_carrier.origin + ( 0, 0, 40 ), "<dev string:xa8>" + bleedout_scale + "<dev string:xb3>" + int( dist_to_goal ), ( 1, 0, 0 ), 0.8, 0.5 );
            }
        #/
        
        waitframe();
    }
}

// Namespace namespace_3156272e8cb1d737
// Params 2, eflags: 0x4
// Checksum 0x90e1e634, Offset: 0x144a
// Size: 0x153
function private function_26cf60520af4f4e6( params, s_additional_params )
{
    wither = s_additional_params.wither;
    target_player = s_additional_params.target_player;
    weyward_boss = wither.downed_owner;
    weyward_boss function_f382a9a4d9b47401( wither );
    
    if ( isdefined( wither.downed_carrier ) )
    {
        wither.downed_carrier delete();
    }
    
    weyward_boss function_3fde749fb7d52be5();
    
    /#
        if ( weyward_boss function_bac4a6048348f708() )
        {
            println( "<dev string:xb7>" + weyward_boss.var_1b1b971af5d4da6f.size );
        }
    #/
    
    if ( isalive( target_player ) && target_player.inlaststand )
    {
        weyward_boss.var_8a9deea3bbabb237[ weyward_boss.var_8a9deea3bbabb237.size ] = target_player;
        respawn_delay = getdvarfloat( @"hash_1360df24df75348f", weyward_boss.var_92a97f00257ba24b );
        wait respawn_delay;
        weyward_boss function_26da7a50e4348ea5( target_player );
        
        if ( isalive( weyward_boss ) && isalive( target_player ) && target_player.inlaststand )
        {
            weyward_boss function_6135c7dc95773a9d( target_player );
            
            /#
                if ( weyward_boss function_bac4a6048348f708() )
                {
                    println( "<dev string:xe1>" );
                }
            #/
        }
    }
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0x7b6f581b, Offset: 0x15a5
// Size: 0x84
function private function_813a05ad84ca2874( wither )
{
    if ( !isalive( wither ) )
    {
        return;
    }
    
    function_f382a9a4d9b47401( wither );
    
    if ( isdefined( wither.downed_beam_fx ) )
    {
        wither.downed_beam_fx delete();
    }
    
    if ( isdefined( wither.downed_carrier ) )
    {
        wither unlink();
        wither.downed_carrier delete();
    }
    
    wither.forceannihilate = 1;
    wither kill( self.origin, self );
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0x390047fe, Offset: 0x1631
// Size: 0xcc
function private function_f382a9a4d9b47401( wither )
{
    if ( !wither.var_87f4d765d3a39467 || !( isdefined( wither.downed_target ) && isdefined( wither.var_4707684c913806ff ) ) )
    {
        return;
    }
    
    wither.var_87f4d765d3a39467 = 0;
    target = wither.downed_target;
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    target.bleedout_speed_scale = wither.var_4707684c913806ff;
    wither.var_4707684c913806ff = undefined;
    target utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4ef7e184952de7dc } );
}

// Namespace namespace_3156272e8cb1d737
// Params 0, eflags: 0x4
// Checksum 0x14e83aed, Offset: 0x1705
// Size: 0x109
function private function_735885cde63e532e()
{
    self waittill( #"death" );
    
    foreach ( wither in self.var_1b1b971af5d4da6f )
    {
        if ( isalive( wither ) )
        {
            function_f382a9a4d9b47401( wither );
            
            if ( isdefined( wither.downed_beam_fx ) )
            {
                wither.downed_beam_fx delete();
            }
            
            if ( isdefined( wither.downed_carrier ) )
            {
                wither unlink();
                wither.downed_carrier delete();
            }
            
            wither.forceannihilate = 1;
            wither kill( self.origin, self );
        }
    }
    
    self.var_1b1b971af5d4da6f = [];
    self.var_dbc00b9502a3c1b0 = [];
}

// Namespace namespace_3156272e8cb1d737
// Params 0, eflags: 0x4
// Checksum 0x840ed5, Offset: 0x1816
// Size: 0x18
function private function_3fde749fb7d52be5()
{
    self.var_1b1b971af5d4da6f = function_46f9072493651dc9( self.var_1b1b971af5d4da6f );
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0xeacb7b05, Offset: 0x1836
// Size: 0xa7
function private function_26da7a50e4348ea5( player )
{
    filtered = [];
    
    foreach ( p in self.var_8a9deea3bbabb237 )
    {
        if ( isdefined( p ) && p != player )
        {
            filtered[ filtered.size ] = p;
        }
    }
    
    self.var_8a9deea3bbabb237 = filtered;
}

// Namespace namespace_3156272e8cb1d737
// Params 1, eflags: 0x4
// Checksum 0xa99c727, Offset: 0x18e5
// Size: 0xa7
function private function_e5a23c51b07dfa2a( player )
{
    filtered = [];
    
    foreach ( p in self.var_dbc00b9502a3c1b0 )
    {
        if ( isdefined( p ) && p != player )
        {
            filtered[ filtered.size ] = p;
        }
    }
    
    self.var_dbc00b9502a3c1b0 = filtered;
}

// Namespace namespace_3156272e8cb1d737
// Params 2, eflags: 0x4
// Checksum 0x417ab927, Offset: 0x1994
// Size: 0xa5
function private function_ca55e92444cf63a4( wither, current_time )
{
    wobble_amp = getdvarfloat( @"hash_252c27b31327c53b", self.var_5e921636375a534d );
    wobble_freq = getdvarfloat( @"hash_82f3441657c44e6d", self.var_28bce4e1acdd461b );
    time_s = ( current_time - wither.downed_start_time ) / 1000;
    wobble_phase = time_s * wobble_freq * 360;
    return ( sin( wobble_phase ) * wobble_amp, cos( wobble_phase * 1.3 ) * wobble_amp * 0.7, 0 );
}

// Namespace namespace_3156272e8cb1d737
// Params 2, eflags: 0x4
// Checksum 0xe6de9bca, Offset: 0x1a42
// Size: 0x91
function private function_21bc6c6a38af9698( wither, current_time )
{
    bob_amp = getdvarfloat( @"hash_30a37fb75e98ed2f", self.var_72d983bca9be2681 );
    bob_freq = getdvarfloat( @"hash_cb3c40d0c8b1ac31", self.var_716ccecbcce893bf );
    time_s = ( current_time - wither.downed_start_time ) / 1000;
    bob_phase = time_s * bob_freq * 360;
    return ( 0, 0, sin( bob_phase ) * bob_amp );
}

// Namespace namespace_3156272e8cb1d737
// Params 5, eflags: 0x4
// Checksum 0xb94f2d4e, Offset: 0x1adc
// Size: 0xea
function private get_adaptive_fly_height( player_origin, fly_height_max, fly_height_min, var_9612e55d981ec3c6, approach_range )
{
    proximity_ratio = clamp( var_9612e55d981ec3c6 / approach_range, 0, 1 );
    desired_height = fly_height_min + ( fly_height_max - fly_height_min ) * proximity_ratio;
    trace_start = player_origin + ( 0, 0, 5 );
    trace_end = player_origin + ( 0, 0, desired_height + 30 );
    trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
    trace_result = trace::ray_trace( trace_start, trace_end, undefined, trace_contents );
    
    if ( trace_result[ "fraction" ] < 1 )
    {
        available_height = ( desired_height + 25 ) * trace_result[ "fraction" ];
        return clamp( available_height, fly_height_min, desired_height );
    }
    
    return desired_height;
}

/#

    // Namespace namespace_3156272e8cb1d737
    // Params 0, eflags: 0x4
    // Checksum 0x944bc5fb, Offset: 0x1bcf
    // Size: 0x5a, Type: dev
    function private function_be24e54f5f0026a7()
    {
        devgui::function_9082edeb5db93280( "<dev string:x11b>" );
        devgui::add_devgui_func( "<dev string:x142>", "<dev string:x156>", &function_149be93133115b18 );
        devgui::add_devgui_func( "<dev string:x172>", "<dev string:x186>", &function_6912f294bfb6ec09 );
        devgui::add_devgui_func( "<dev string:x1a8>", "<dev string:x1bc>", &function_c82b7584d5d0e793 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_3156272e8cb1d737
    // Params 1, eflags: 0x4
    // Checksum 0x98049c2d, Offset: 0x1c31
    // Size: 0xf7, Type: dev
    function private function_149be93133115b18( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1df>" );
        
        if ( isdefined( weyward ) )
        {
            target = undefined;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && player.inlaststand )
                {
                    target = player;
                    break;
                }
            }
            
            if ( isdefined( target ) )
            {
                weyward function_6135c7dc95773a9d( target );
                return;
            }
            
            println( "<dev string:x1ee>" );
        }
    }

    // Namespace namespace_3156272e8cb1d737
    // Params 1, eflags: 0x4
    // Checksum 0x2d0d3551, Offset: 0x1d30
    // Size: 0x12f, Type: dev
    function private function_6912f294bfb6ec09( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1df>" );
        
        if ( isdefined( weyward ) )
        {
            foreach ( wither in weyward.var_1b1b971af5d4da6f )
            {
                if ( isalive( wither ) )
                {
                    if ( isdefined( wither.downed_beam_fx ) )
                    {
                        wither.downed_beam_fx delete();
                    }
                    
                    if ( isdefined( wither.downed_carrier ) )
                    {
                        wither unlink();
                        wither.downed_carrier delete();
                    }
                    
                    wither.forceannihilate = 1;
                    wither kill( weyward.origin, weyward );
                }
            }
            
            weyward.var_1b1b971af5d4da6f = [];
        }
    }

    // Namespace namespace_3156272e8cb1d737
    // Params 1, eflags: 0x4
    // Checksum 0x58a7d1c7, Offset: 0x1e67
    // Size: 0x24, Type: dev
    function private function_c82b7584d5d0e793( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x220>", @"hash_2625f90605270362" );
    }

    // Namespace namespace_3156272e8cb1d737
    // Params 0, eflags: 0x4
    // Checksum 0x446e7d67, Offset: 0x1e93
    // Size: 0x16, Type: dev
    function private function_bac4a6048348f708()
    {
        return getdvarint( @"hash_2625f90605270362", 0 ) > 0;
    }

#/
