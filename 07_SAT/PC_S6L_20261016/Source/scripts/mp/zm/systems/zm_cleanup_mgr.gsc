// scripts\mp\zm\systems\zm_cleanup_mgr.gsc  (hash_7ebf3468c1644f46.gscc) (size: 16474 Bytes / 0x405a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51de044c (1373504588)
// size ...... 16474 (0x405a)
// includes .. 14  (offset: 0x3dde)
// strings ... 17  (offset: 0x3e4e)
// dev strs .. 24  (offset: 0x3f3a)
// exports ... 47  (offset: 0x26b2)
// cseg ...... 0x14a + 0x2568 (0x26b2)
// imports ... 132 (offset: 0x2e0a)
// animtree1 . 0   (offset: 0x405a)
// animtree2 . 0   (offset: 0x405a)
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_cleanup_manager;

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x7c147928, Offset: 0x168
// Size: 0x10f
function init_zm_cleanup_mgr()
{
    var_67ca46f9eb6e9fcf = spawnstruct();
    var_67ca46f9eb6e9fcf.var_e8f8a2469663d564 = 0;
    var_67ca46f9eb6e9fcf.var_e722b24f3444e929 = [];
    var_67ca46f9eb6e9fcf.var_2afe3d6a4d95065b = [];
    var_67ca46f9eb6e9fcf.var_8393b3e21b9cbb52 = 0;
    setdvarifuninitialized( @"zm_cleanup_enabled", 1 );
    level.var_f4f8c9a351eaab32 = var_67ca46f9eb6e9fcf;
    utility::registersharedfunc( #"zombie", #"hash_6c2d9080e508d382", &function_dd62e2042418b7e5 );
    utility::registersharedfunc( #"zombie", #"hash_1cfef8902e0bfcee", &function_44f5bec4abb163f1 );
    utility::registersharedfunc( #"zombie", #"hash_f6e4eb2937988fb2", &function_dac6d08a9ec88bcb );
    level callback::add( #"player_death", &on_player_death );
    
    if ( getdvarint( @"hash_35518b827e99c63", 1 ) )
    {
        level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    }
    
    level thread function_e17ed5f8b8fee8f2();
    level thread init_cleanup_triggers();
    
    /#
        function_dd75c560058bcc51();
    #/
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x65426a2f, Offset: 0x27f
// Size: 0xe
function function_cf7f1a68bb547081()
{
    level notify( #"pump_distance_check" );
}

// Namespace zm_cleanup_manager
// Params 1
// Checksum 0x2abb938d, Offset: 0x295
// Size: 0x2d
function function_a60b51ff4c3a1891( var_d7852f8cdf4f5cf4 )
{
    level.var_fe35b38a17203625 = var_d7852f8cdf4f5cf4;
    
    if ( !function_314cdb09d9c52ae8() )
    {
        level notify( #"delay_zombie_cleanup" );
    }
}

// Namespace zm_cleanup_manager
// Params 0, eflags: 0x4
// Checksum 0x7fb4b60d, Offset: 0x2ca
// Size: 0x44
function private function_314cdb09d9c52ae8()
{
    if ( isdefined( level.var_fe35b38a17203625 ) )
    {
        n_current_time = gettime() / 1000;
        n_delta_time = level.var_fe35b38a17203625 - n_current_time;
        return ( n_delta_time <= 0 );
    }
    
    return 1;
}

// Namespace zm_cleanup_manager
// Params 0, eflags: 0x4
// Checksum 0x124ebd41, Offset: 0x316
// Size: 0xfe
function private function_e17ed5f8b8fee8f2()
{
    level endon( #"game_ended" );
    level endon( #"zm_cleanup_disabled" );
    var_55adf79c3bd3fddb = 0;
    level waittill( #"begin_round_logic" );
    
    while ( !isdefined( level.round_spawn_time ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"zm_cleanup_enabled", 1 ) <= 0 )
        {
            continue;
        }
        
        n_time = gettime();
        
        if ( n_time < var_55adf79c3bd3fddb )
        {
            continue;
        }
        
        if ( function_314cdb09d9c52ae8() )
        {
            level.var_fe35b38a17203625 = undefined;
        }
        else
        {
            continue;
        }
        
        cleanup_delay = level.round_number <= 5 ? 30000 : 20000;
        
        if ( n_time - level.round_spawn_time < cleanup_delay )
        {
            continue;
        }
        
        cleanup_dist_sq_override = undefined;
        
        if ( function_2aa25a812d802967() < 5 )
        {
            cleanup_dist_sq_override = 4000000;
        }
        
        var_55adf79c3bd3fddb += 3000;
        level function_dafd965d05efbb37( cleanup_dist_sq_override );
    }
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0xd00593d0, Offset: 0x41c
// Size: 0xce
function private function_dafd965d05efbb37( cleanup_dist_sq_override )
{
    level endon( #"delay_zombie_cleanup" );
    var_35a76b9286aef10b = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( var_7654d704b9415bab in var_35a76b9286aef10b )
    {
        if ( level.var_f4f8c9a351eaab32.var_8393b3e21b9cbb52 >= 1 )
        {
            level.var_f4f8c9a351eaab32.var_8393b3e21b9cbb52 = 0;
            waitframe();
        }
        
        var_7654d704b9415bab function_1d1cd1889bf45607( cleanup_dist_sq_override );
    }
}

// Namespace zm_cleanup_manager
// Params 1
// Checksum 0x3f0b92de, Offset: 0x4f2
// Size: 0x4da
function function_1d1cd1889bf45607( cleanup_dist_sq_override )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.b_ignore_cleanup )
    {
        return;
    }
    
    if ( isdefined( self.ignore_cleanup_fn ) )
    {
        if ( self [[ self.ignore_cleanup_fn ]]() )
        {
            return;
        }
    }
    
    if ( !isdefined( self.spawn_time ) )
    {
        self.spawn_time = gettime();
    }
    
    var_fd7922680fcdef06 = gettime() - self.spawn_time;
    
    if ( var_fd7922680fcdef06 < 5000 )
    {
        return;
    }
    
    if ( self.b_in_cleanup )
    {
        return;
    }
    
    current_zone = zone_manager::get_current_zone();
    var_5bc9e2e25f935ec4 = isdefined( current_zone );
    
    if ( var_fd7922680fcdef06 < 10000 && !var_5bc9e2e25f935ec4 )
    {
        if ( isdefined( self.goalpos ) && isdefined( zone_manager::function_90e5c3e2272b0130( self.goalpos ) ) )
        {
            return;
        }
    }
    
    var_b87fa2c12c315767 = istrue( current_zone.is_active );
    
    if ( level.var_e89fe60e34cb36f1 || self.var_e89fe60e34cb36f1 )
    {
        if ( isdefined( current_zone ) && isarray( current_zone.occupants ) && current_zone.occupants.size == 0 )
        {
            var_b87fa2c12c315767 = 0;
        }
    }
    
    level.var_f4f8c9a351eaab32.var_8393b3e21b9cbb52++;
    
    if ( !var_b87fa2c12c315767 )
    {
        closest_player_data = function_f887be386388dab2( self.origin );
        var_e5c42b15190b3bf1 = closest_player_data.dist_sq_min;
        var_4629425b6bba982f = closest_player_data.closest_player;
        
        if ( isdefined( cleanup_dist_sq_override ) )
        {
            var_4e2ad070abd61af9 = cleanup_dist_sq_override;
        }
        else
        {
            var_f772a3847457aef9 = level.var_52cc30b67469d423 ?? 562500;
            var_427b074606665be = level.var_fbacfb9da4525df8 ?? level.var_52cc30b67469d423 ?? 469225;
            
            if ( isdefined( var_4629425b6bba982f ) && !is_player_facing_origin( var_4629425b6bba982f, self.origin ) )
            {
                if ( self.movemode == "walk" )
                {
                    var_4e2ad070abd61af9 = var_f772a3847457aef9;
                }
                else
                {
                    var_4e2ad070abd61af9 = var_427b074606665be;
                }
            }
            else
            {
                var_4e2ad070abd61af9 = var_f772a3847457aef9;
            }
        }
        
        should_cleanup = 0;
        cannot_path = 0;
        
        if ( var_e5c42b15190b3bf1 >= var_4e2ad070abd61af9 )
        {
            should_cleanup = 1;
            
            /#
                cleanup_print( "<dev string:x24>" + sqrt( var_4e2ad070abd61af9 ) + "<dev string:x3c>" );
            #/
        }
        
        if ( function_3ef0fbd0c1f45128() )
        {
            cannot_path = 1;
            should_cleanup = 1;
            
            /#
                cleanup_print( "<dev string:x3f>", ( 0, 0, 30 ) );
            #/
        }
        
        if ( cannot_path && var_e5c42b15190b3bf1 > 4000000 && function_3ef0fbd0c1f45128( 15000 ) )
        {
            should_cleanup = 1;
            
            /#
                cleanup_print( "<dev string:x54>", ( 0, 0, 60 ) );
            #/
        }
        else if ( should_cleanup )
        {
            if ( !isdefined( level.var_cf5bb9ecacc3a208 ) )
            {
                level.var_cf5bb9ecacc3a208 = gettime();
            }
            
            var_f22804e113f757c1 = 0;
            
            foreach ( player in level.players )
            {
                if ( !isalive( player ) || player.sessionstate == "spectator" )
                {
                    continue;
                }
                
                var_c6c25fcc14bb9bac = self cansee( player );
                n_cleanup_dist_sq_ai_can_see = zm_utility::get_round_number() >= 31 ? 562500 : 2250000;
                
                if ( var_e5c42b15190b3bf1 < n_cleanup_dist_sq_ai_can_see )
                {
                    if ( var_c6c25fcc14bb9bac )
                    {
                        should_cleanup = 0;
                        self.var_b75e8c30dadb3f95 = gettime();
                        
                        /#
                            cleanup_print( "<dev string:x7a>" + sqrt( n_cleanup_dist_sq_ai_can_see ) + "<dev string:x9c>", ( 0, 0, 60 ) );
                        #/
                        
                        break;
                    }
                }
                else if ( !utility::time_has_passed( level.var_cf5bb9ecacc3a208, 5 ) )
                {
                    if ( var_c6c25fcc14bb9bac )
                    {
                        should_cleanup = 0;
                        
                        /#
                            cleanup_print( "<dev string:x9e>" + level.var_cf5bb9ecacc3a208 + 5000 - gettime(), ( 0, 0, 60 ) );
                        #/
                        
                        break;
                    }
                }
                else
                {
                    var_f22804e113f757c1 = 1;
                }
                
                if ( function_219709696282ca91( player ) )
                {
                    should_cleanup = 0;
                    
                    /#
                        cleanup_print( "<dev string:xe0>", ( 0, 0, 60 ) );
                    #/
                    
                    break;
                }
            }
            
            if ( should_cleanup && var_f22804e113f757c1 && var_c6c25fcc14bb9bac )
            {
                level.var_cf5bb9ecacc3a208 = gettime();
                self.var_d45a05bad6bfa5b7 = gettime();
            }
        }
        
        if ( should_cleanup )
        {
            thread function_a5026e7471e5b971( cannot_path );
        }
        
        return;
    }
    
    /#
        cleanup_print( "<dev string:xf2>" );
    #/
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0x44939de7, Offset: 0x9d4
// Size: 0x107
function private function_f887be386388dab2( test_loc )
{
    var_e5c42b15190b3bf1 = 10000000;
    players = level.players;
    var_4629425b6bba982f = players[ 0 ];
    
    foreach ( player in players )
    {
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            continue;
        }
        
        var_92b21ca8efb6aef2 = distancesquared( test_loc, player.origin );
        
        if ( var_92b21ca8efb6aef2 < var_e5c42b15190b3bf1 )
        {
            var_e5c42b15190b3bf1 = var_92b21ca8efb6aef2;
            var_4629425b6bba982f = player;
        }
    }
    
    return { #closest_player:var_4629425b6bba982f, #dist_sq_min:var_e5c42b15190b3bf1 };
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0x4833e927, Offset: 0xae4
// Size: 0x43, Type: bool
function private function_3ef0fbd0c1f45128( time = 2000 )
{
    assert( isai( self ) );
    
    if ( isdefined( self.enemy ) && self function_c607805e62ad17af() > time )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0xfa8a1938, Offset: 0xb30
// Size: 0x58
function private function_a5026e7471e5b971( var_46159e2772b2df4 )
{
    if ( self.var_cf4d8fe1a0734901 )
    {
        return;
    }
    
    if ( val::get( "damageshield_allow_delete" ) )
    {
        utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
    }
    
    if ( self.magic_bullet_shield )
    {
        return;
    }
    
    thread function_44f5bec4abb163f1( 1, var_46159e2772b2df4 );
}

// Namespace zm_cleanup_manager
// Params 2
// Checksum 0xb47958f1, Offset: 0xb90
// Size: 0x39
function function_f4275f0bbf17cbf6( str_subclass, func_cleanup_override )
{
    if ( !isdefined( level.var_841aaed567a2483f ) )
    {
        level.var_841aaed567a2483f = [];
    }
    
    level.var_841aaed567a2483f[ str_subclass ] = func_cleanup_override;
}

// Namespace zm_cleanup_manager
// Params 4, eflags: 0x4
// Checksum 0x73750bfb, Offset: 0xbd1
// Size: 0xfd, Type: bool
function private function_7dc444aad2727935( var_5cb4f8bc8ebba77, var_46159e2772b2df4, b_force_teleport, resetasm )
{
    if ( isdefined( self.subclass ) && isdefined( level.var_841aaed567a2483f[ self.subclass ] ) )
    {
        var_2a45ff33b3ccb4d2 = self [[ level.var_841aaed567a2483f[ self.subclass ] ]]( var_5cb4f8bc8ebba77, var_46159e2772b2df4 );
        return istrue( var_2a45ff33b3ccb4d2 );
    }
    
    should_teleport = b_force_teleport || self.var_d45a05bad6bfa5b7 === gettime();
    
    if ( b_force_teleport || should_teleport || self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "hvt" )
    {
        teleport_successful = teleport_zombie( var_46159e2772b2df4, resetasm );
        
        if ( !teleport_successful )
        {
            thread retry_teleport( var_46159e2772b2df4, resetasm );
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_cleanup_manager
// Params 2, eflags: 0x4
// Checksum 0x252b9db, Offset: 0xcd7
// Size: 0x77
function private retry_teleport( var_46159e2772b2df4, resetasm )
{
    level endon( #"game_ended" );
    level endon( #"zm_cleanup_disabled" );
    self endon( #"death" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        wait 10;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        success = teleport_zombie( var_46159e2772b2df4, resetasm );
        
        if ( success )
        {
            return;
        }
    }
}

// Namespace zm_cleanup_manager
// Params 2
// Checksum 0x6820a787, Offset: 0xd56
// Size: 0x4e
function function_4e4441bfd881a0ba( str_subclass, func )
{
    if ( !isdefined( level.var_81070e98bc452527[ str_subclass ] ) )
    {
        level.var_81070e98bc452527[ str_subclass ] = [];
    }
    
    level.var_81070e98bc452527[ str_subclass ][ level.var_81070e98bc452527[ str_subclass ].size ] = func;
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0xed70b2c6, Offset: 0xdac
// Size: 0xc4
function private function_961e866b591720be( var_af242ddbfdb446e3 )
{
    profilestart();
    
    if ( !isdefined( level.var_81070e98bc452527 ) )
    {
        profilestop();
        return;
    }
    
    if ( isdefined( self.subclass ) && isdefined( level.var_81070e98bc452527[ self.subclass ] ) )
    {
        foreach ( func in level.var_81070e98bc452527[ self.subclass ] )
        {
            self [[ func ]]( var_af242ddbfdb446e3 );
        }
    }
    
    profilestop();
}

// Namespace zm_cleanup_manager
// Params 2
// Checksum 0x6a62ceec, Offset: 0xe78
// Size: 0x93, Type: bool
function teleport_zombie( var_46159e2772b2df4 = 1, resetasm = 0 )
{
    if ( isalive( self ) )
    {
        subclass = self.subclass;
        spawn_loc = zone_spawner::select_spawn_loc( subclass );
        
        if ( isdefined( spawn_loc ) )
        {
            if ( var_46159e2772b2df4 || function_8b01d78b77c9f9b0( spawn_loc.origin ) )
            {
                function_99d76f5843348bcb( spawn_loc, resetasm );
                callback::callback( #"long_teleport" );
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0xf363f973, Offset: 0xf14
// Size: 0x50, Type: bool
function private function_8b01d78b77c9f9b0( spawn_loc )
{
    var_6b9347df239962e7 = function_f887be386388dab2( self.origin );
    var_a30c6bc7ef87d3e8 = function_f887be386388dab2( spawn_loc );
    return var_a30c6bc7ef87d3e8.dist_sq_min < var_6b9347df239962e7.dist_sq_min;
}

// Namespace zm_cleanup_manager
// Params 2, eflags: 0x4
// Checksum 0x83642fe1, Offset: 0xf6d
// Size: 0xea
function private function_99d76f5843348bcb( location, resetasm )
{
    self endon( #"death" );
    self hide( 1 );
    
    while ( zombie_traverse::is_traversing() )
    {
        waitframe();
    }
    
    /#
        if ( debug_cleanup() )
        {
            debugstar( self.origin, ( 0, 0, 1 ), 100, "<dev string:x112>" );
        }
    #/
    
    self dontinterpolate();
    self forceteleport( location.origin, location.angles ?? self.angles, 10000, resetasm );
    
    /#
        if ( debug_cleanup() )
        {
            debugstar( location.origin, ( 1, 0, 1 ), 100, "<dev string:x122>" );
        }
    #/
    
    self show();
    self.spawn_time = gettime();
    thread zone_spawner::function_ce10e453e7f7bb8e( location );
    thread zone_spawner::function_f9d3af30e993a949();
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x77fd55b5, Offset: 0x105f
// Size: 0xb2
function init_cleanup_triggers()
{
    level.var_cdffdadce15c68fa = getentarray( "cleanup_trigger", #targetname );
    level.cleanup_trigger_ent_queue = [];
    
    foreach ( trigger in level.var_cdffdadce15c68fa )
    {
        trigger::makeenterexittrigger( trigger, &function_a6d4fef2eb935d5e, &function_cf62053d5e951408 );
    }
    
    level thread cleanup_trigger_watcher();
}

// Namespace zm_cleanup_manager
// Params 3, eflags: 0x4
// Checksum 0xb3f32b2b, Offset: 0x1119
// Size: 0x3a
function private function_a6d4fef2eb935d5e( ent, trigger, payload )
{
    if ( isalive( ent ) && isai( ent ) )
    {
        ent thread cleanup_traversal_watcher();
    }
}

// Namespace zm_cleanup_manager
// Params 3, eflags: 0x4
// Checksum 0xb4acc0ba, Offset: 0x115b
// Size: 0x30
function private function_cf62053d5e951408( ent, trigger, payload )
{
    if ( ent )
    {
        ent notify( #"hash_c0025a0ea66c36a1" );
    }
}

// Namespace zm_cleanup_manager
// Params 0, eflags: 0xc
// Checksum 0xdbbd498a, Offset: 0x1193
// Size: 0x5c
function private cleanup_traversal_watcher()
{
    self notify( #"hash_164fdb5f23a6f8f5" );
    self endon( #"hash_164fdb5f23a6f8f5" );
    self endon( #"death" );
    self endon( #"hash_c0025a0ea66c36a1" );
    
    while ( !zombie_traverse::is_traversing() )
    {
        waitframe();
    }
    
    level.cleanup_trigger_ent_queue = arraycombineunique( level.cleanup_trigger_ent_queue, [ self ] );
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x3625570b, Offset: 0x11f7
// Size: 0x1f2
function cleanup_trigger_watcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
        
        foreach ( zombie in level.cleanup_trigger_ent_queue )
        {
            b_skip_cleanup = 0;
            
            if ( !isalive( zombie ) || !isai( zombie ) )
            {
                level.cleanup_trigger_ent_queue = arrayremove( level.cleanup_trigger_ent_queue, zombie );
                continue;
            }
            
            if ( zombie.subclass == "dawg" )
            {
                if ( isplayer( zombie.owner ) )
                {
                    b_skip_cleanup = 1;
                    zombie utility::callsharedfunc( #"dawg", #"teleport_dawg", zombie.owner );
                }
            }
            
            foreach ( player in level.players )
            {
                if ( zombie == player.bgb_hellping_hound )
                {
                    b_skip_cleanup = 1;
                    zombie utility::callsharedfunc( #"bgb", #"teleport_helping_hound", player );
                    break;
                }
            }
            
            if ( !b_skip_cleanup )
            {
                zombie finishtraverse();
                zombie function_44f5bec4abb163f1( 1, 1, zombie zombie_utils::function_bf1464d09f4e4b40(), 1 );
            }
            
            level.cleanup_trigger_ent_queue = arrayremove( level.cleanup_trigger_ent_queue, zombie );
            waitframe();
        }
    }
}

// Namespace zm_cleanup_manager
// Params 1
// Checksum 0x93898c25, Offset: 0x13f1
// Size: 0xb7
function function_dac6d08a9ec88bcb( pos )
{
    pos += ( 0, 0, 10 );
    
    foreach ( trigger in level.var_cdffdadce15c68fa )
    {
        if ( trigger istouchingpoint( pos ) )
        {
            level.cleanup_trigger_ent_queue = arraycombineunique( level.cleanup_trigger_ent_queue, [ self ] );
            break;
        }
    }
}

// Namespace zm_cleanup_manager
// Params 4
// Checksum 0x2f021c7, Offset: 0x14b0
// Size: 0x166
function function_44f5bec4abb163f1( var_5cb4f8bc8ebba77, var_46159e2772b2df4, b_force_teleport, resetasm = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.b_in_cleanup || !isalive( self ) )
    {
        return;
    }
    
    self.b_in_cleanup = 1;
    
    if ( function_7dc444aad2727935( var_5cb4f8bc8ebba77, var_46159e2772b2df4, b_force_teleport, resetasm ) )
    {
        if ( isdefined( self ) )
        {
            self.b_in_cleanup = undefined;
        }
        
        return;
    }
    
    if ( !isalive( self ) )
    {
        println( "<dev string:x130>" );
        return;
    }
    
    self.var_48960fedb514aedd = 1;
    self.var_bde88f28bc9ee20e = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.no_powerups = 1;
    
    /#
        if ( debug_cleanup() )
        {
            debugstar( self.origin, ( 1, 0, 0 ), 100 );
            cleanup_print( "<dev string:x17d>", ( 0, 0, -30 ) );
        }
    #/
    
    if ( isagent( self ) )
    {
        utility::function_32b24db3127bff40( "despawnVfX", "on" );
        waitframe();
        
        if ( isdefined( self ) )
        {
            function_dd62e2042418b7e5();
            self.death_source = "zm_cleanup";
            ai::function_dd7b3233e5b07718( var_5cb4f8bc8ebba77 );
        }
        
        return;
    }
    
    function_dd62e2042418b7e5();
    self kill();
    waitframe();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0x71a82092, Offset: 0x161e
// Size: 0x21a
function private function_219709696282ca91( player )
{
    end_point = self.origin;
    
    if ( isagent( self ) )
    {
        if ( self tagexists( "j_spine4" ) )
        {
            end_point = self gettagorigin( "j_spine4" );
        }
        else if ( self tagexists( "j_spine2" ) )
        {
            end_point = self gettagorigin( "j_spine2" );
        }
    }
    
    if ( !player isvehicleactive() && !player math::point_in_fov( end_point, 0.5, 1 ) )
    {
        return 0;
    }
    
    start_point = player getvieworigin();
    
    if ( isdefined( player.vehicle ) )
    {
        start_point = player.vehicle getcentroid();
    }
    
    can_see = sighttracepassed( start_point, end_point, 1, self, player );
    
    /#
        if ( debug_cleanup() )
        {
            line( start_point, end_point, can_see ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 0, 100 );
        }
    #/
    
    if ( !getdvarint( @"hash_865695d1de4d0acf", 0 ) )
    {
        if ( !can_see )
        {
            bounds_radius = self function_10a84122a845e3bb();
            sight_check_radius = max( bounds_radius[ 0 ], bounds_radius[ 1 ] ) * 2;
            sight_direction = vectornormalize( end_point - start_point );
            sight_offset = sight_check_radius * vectorcross( sight_direction, ( 0, 0, 1 ) );
            can_see = sighttracepassed( start_point, end_point + sight_offset, 1, self, player );
            
            /#
                if ( debug_cleanup() )
                {
                    line( start_point, end_point, can_see ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 0, 100 );
                }
            #/
            
            if ( !can_see )
            {
                can_see = sighttracepassed( start_point, end_point - sight_offset, 1, self, player );
                
                /#
                    if ( debug_cleanup() )
                    {
                        line( start_point, end_point, can_see ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 0, 100 );
                    }
                #/
            }
        }
    }
    
    return can_see;
}

// Namespace zm_cleanup_manager
// Params 2, eflags: 0x4
// Checksum 0x2a9d4c77, Offset: 0x1841
// Size: 0x66, Type: bool
function private is_player_facing_origin( player, origin )
{
    var_dc871477a0dd59ed = player getplayerangles();
    var_2d6b579fc088a2ee = anglestoforward( var_dc871477a0dd59ed );
    v_dir = player getorigin() - origin;
    var_4df7db8d01e4372c = vectordot( var_2d6b579fc088a2ee, v_dir );
    
    if ( var_4df7db8d01e4372c < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_cleanup_manager
// Params 2
// Checksum 0x397457f1, Offset: 0x18b0
// Size: 0x243
function function_ff2f735d3abb2ce0( var_355aa9f02125ac58 = 0, ignore_category )
{
    var_35a76b9286aef10b = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( var_7654d704b9415bab in var_35a76b9286aef10b )
    {
        if ( !isalive( var_7654d704b9415bab ) )
        {
            continue;
        }
        else if ( var_355aa9f02125ac58 && var_7654d704b9415bab.var_825b17c932865df )
        {
            continue;
        }
        else if ( !var_355aa9f02125ac58 && var_7654d704b9415bab.b_ignore_cleanup )
        {
            continue;
        }
        
        if ( isarray( ignore_category ) )
        {
            var_3cd2eba2b7ff6812 = 0;
            
            foreach ( var_8fd3eb7841f45192 in ignore_category )
            {
                if ( var_7654d704b9415bab.aicategory == var_8fd3eb7841f45192 )
                {
                    var_3cd2eba2b7ff6812 = 1;
                }
            }
            
            if ( var_3cd2eba2b7ff6812 )
            {
                continue;
            }
        }
        else if ( var_7654d704b9415bab.aicategory === ignore_category )
        {
            continue;
        }
        
        if ( var_7654d704b9415bab.magic_bullet_shield || var_7654d704b9415bab.damageshield )
        {
            continue;
        }
        
        if ( var_7654d704b9415bab val::get( "damageshield_allow_delete" ) )
        {
            var_7654d704b9415bab utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        var_7654d704b9415bab function_dd62e2042418b7e5( 1 );
        var_7654d704b9415bab.var_48960fedb514aedd = 1;
        var_7654d704b9415bab.no_powerups = 1;
        var_7654d704b9415bab.var_a13bed1ac47e1b2c = 1;
        var_7654d704b9415bab kill();
        
        /#
            if ( debug_cleanup() )
            {
                debugstar( var_7654d704b9415bab.origin, ( 1, 1, 0 ), 100, "<dev string:x188>" );
            }
        #/
        
        waitframe();
    }
}

// Namespace zm_cleanup_manager
// Params 1
// Checksum 0x460e6827, Offset: 0x1afb
// Size: 0xba
function function_dd62e2042418b7e5( var_8710c1e430662bf7 )
{
    var_1f959e6b44d20450 = get_zombie_respawn_info();
    
    if ( isdefined( var_1f959e6b44d20450 ) )
    {
        if ( var_8710c1e430662bf7 ?? 0 )
        {
            level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b[ level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b.size ] = var_1f959e6b44d20450;
        }
        else if ( level.var_f4f8c9a351eaab32.var_e722b24f3444e929.size < level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 )
        {
            level.var_f4f8c9a351eaab32.var_e722b24f3444e929[ level.var_f4f8c9a351eaab32.var_e722b24f3444e929.size ] = var_1f959e6b44d20450;
        }
        
        function_961e866b591720be( var_8710c1e430662bf7 );
    }
}

// Namespace zm_cleanup_manager
// Params 2
// Checksum 0xd8feca5a, Offset: 0x1bbd
// Size: 0xe0
function function_8918c1cebb25919e( var_d0c6b7fe2f128d03, var_8710c1e430662bf7 )
{
    if ( isdefined( var_d0c6b7fe2f128d03 ) )
    {
        if ( var_8710c1e430662bf7 ?? 0 )
        {
            level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b[ level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b.size ] = var_d0c6b7fe2f128d03;
            return;
        }
        
        if ( level.var_f4f8c9a351eaab32.var_e722b24f3444e929.size < level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 )
        {
            level.var_f4f8c9a351eaab32.var_e722b24f3444e929[ level.var_f4f8c9a351eaab32.var_e722b24f3444e929.size ] = var_d0c6b7fe2f128d03;
            return;
        }
        
        assert( level.var_f4f8c9a351eaab32.var_e722b24f3444e929.size > level.var_a009ab14ee0d3223.var_5c8829ccd69f3862, "<dev string:x1a1>" );
    }
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x9ec97cda, Offset: 0x1ca5
// Size: 0x185
function get_zombie_respawn_info()
{
    var_1f959e6b44d20450 = undefined;
    
    if ( isdefined( self.agent_type ) && !self.b_cleanup_no_respawn )
    {
        var_1f959e6b44d20450 = spawnstruct();
        ai_type = self.agent_type;
        
        if ( isstartstr( ai_type, "actor_" ) )
        {
            ai_type = getsubstr( ai_type, 6 );
        }
        
        var_1f959e6b44d20450.aitype = ai_type;
        
        if ( isdefined( self.var_8f7b67390c7a40b2 ) )
        {
            var_1f959e6b44d20450.var_8f7b67390c7a40b2 = self.var_8f7b67390c7a40b2;
        }
        
        if ( level.var_f4f8c9a351eaab32.var_e8f8a2469663d564 || self.var_e8f8a2469663d564 || self.aicategory == "elite" || self.aicategory == "hvt" )
        {
            var_1f959e6b44d20450.savedhealth = self.health;
            var_1f959e6b44d20450.savedmaxhealth = self.maxhealth;
        }
        
        assert( !isdefined( var_1f959e6b44d20450.savedmaxhealth ) && !isdefined( var_1f959e6b44d20450.savedhealth ) || var_1f959e6b44d20450.savedmaxhealth > 0 && var_1f959e6b44d20450.savedhealth > 0 && var_1f959e6b44d20450.savedmaxhealth >= var_1f959e6b44d20450.savedhealth );
        
        if ( isdefined( self.var_abc8197d352873af ) )
        {
            var_1f959e6b44d20450.var_abc8197d352873af = self.var_abc8197d352873af;
        }
    }
    
    return var_1f959e6b44d20450;
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x5a5127fc, Offset: 0x1e33
// Size: 0x3e
function function_227af94975b8071f()
{
    level.var_f4f8c9a351eaab32.var_e722b24f3444e929 = level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b;
    level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b = [];
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x9203119, Offset: 0x1e79
// Size: 0x3e
function function_e675dc1c82f6b58e()
{
    level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b = level.var_f4f8c9a351eaab32.var_e722b24f3444e929;
    level.var_f4f8c9a351eaab32.var_e722b24f3444e929 = [];
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0xf209bcb1, Offset: 0x1ebf
// Size: 0x145
function function_d1dc6feeb14c0420()
{
    zombie = undefined;
    
    if ( get_pending_respawn_count() > 0 )
    {
        var_1f959e6b44d20450 = level.var_f4f8c9a351eaab32.var_e722b24f3444e929[ 0 ];
        
        if ( isdefined( var_1f959e6b44d20450.var_8f7b67390c7a40b2 ) )
        {
            if ( function_f8c4b8fd426e083b( var_1f959e6b44d20450 ) )
            {
                var_1f959e6b44d20450.aitype = var_1f959e6b44d20450.var_8f7b67390c7a40b2;
                var_1f959e6b44d20450.var_8f7b67390c7a40b2 = undefined;
            }
        }
        
        zombie = agent_spawner::spawn_agent( var_1f959e6b44d20450.aitype );
        
        if ( isdefined( zombie ) )
        {
            zombie function_5a0d7d59f7c4fafd( var_1f959e6b44d20450 );
            level.var_f4f8c9a351eaab32.var_e722b24f3444e929[ 0 ] = undefined;
            function_cdc669dbc8ea2101( level.var_f4f8c9a351eaab32.var_e722b24f3444e929 );
            
            /#
                if ( debug_cleanup() )
                {
                    debugstar( zombie.origin, ( 0, 1, 1 ), 100, "<dev string:x1dc>" );
                }
            #/
        }
        else
        {
            level callback::callback( "cleaned_up_zombie_spawn_fail" );
            
            if ( level.var_93e06b805cf2692c == gettime() )
            {
                level.var_f4f8c9a351eaab32.var_e722b24f3444e929[ 0 ] = undefined;
                function_cdc669dbc8ea2101( level.var_f4f8c9a351eaab32.var_e722b24f3444e929 );
            }
        }
    }
    
    return zombie;
}

// Namespace zm_cleanup_manager
// Params 1
// Checksum 0xef0ba3fe, Offset: 0x200d
// Size: 0x177
function function_5a0d7d59f7c4fafd( var_1f959e6b44d20450 )
{
    self.spawn_source = "zm_cleanup";
    
    if ( !isdefined( self.override_ai_type ) || self.override_ai_type == var_1f959e6b44d20450.aitype )
    {
        assert( !isdefined( var_1f959e6b44d20450.savedmaxhealth ) || var_1f959e6b44d20450.savedmaxhealth > 0 );
        assert( !isdefined( var_1f959e6b44d20450.savedhealth ) || var_1f959e6b44d20450.savedhealth > 0 );
        
        if ( var_1f959e6b44d20450.savedmaxhealth > 0 )
        {
            ai::set_ai_max_health( var_1f959e6b44d20450.savedmaxhealth );
        }
        
        if ( var_1f959e6b44d20450.savedhealth > 0 && self.maxhealth >= var_1f959e6b44d20450.savedhealth )
        {
            self.health = var_1f959e6b44d20450.savedhealth;
        }
        
        assert( self.maxhealth >= self.health );
    }
    
    if ( isdefined( var_1f959e6b44d20450.var_8f7b67390c7a40b2 ) )
    {
        self.var_8f7b67390c7a40b2 = var_1f959e6b44d20450.var_8f7b67390c7a40b2;
    }
    
    if ( isdefined( var_1f959e6b44d20450.var_abc8197d352873af ) )
    {
        self.var_c85fec368aa94f80 = var_1f959e6b44d20450.var_abc8197d352873af + gettime();
    }
    
    if ( var_1f959e6b44d20450.metabones.size > 0 )
    {
        self.saved_metabones = var_1f959e6b44d20450.metabones;
    }
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0x561b342b, Offset: 0x218c
// Size: 0x64, Type: bool
function private function_f8c4b8fd426e083b( var_1f959e6b44d20450 )
{
    if ( !level.var_de533bedf48b22d9 || !( isdefined( level.var_6601d1b004c2c7e0 ) && isdefined( level.var_d5beb84142393428 ) ) )
    {
        return true;
    }
    
    level.var_d5beb84142393428 = function_46f9072493651dc9( level.var_d5beb84142393428 );
    return level.var_6601d1b004c2c7e0 - level.var_d5beb84142393428.size <= 0;
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x8d4cd4e1, Offset: 0x21f9
// Size: 0x16
function get_pending_respawn_count()
{
    return level.var_f4f8c9a351eaab32.var_e722b24f3444e929.size;
}

// Namespace zm_cleanup_manager
// Params 0
// Checksum 0x3a0dfb0a, Offset: 0x2218
// Size: 0x23
function function_2aa25a812d802967()
{
    enemies = zm_round_spawning::get_round_enemies();
    
    if ( !isarray( enemies ) )
    {
        return 0;
    }
    
    return enemies.size;
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0x67cc3ecf, Offset: 0x2244
// Size: 0x92
function private on_player_death( params )
{
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            return;
        }
    }
    
    level notify( #"zm_cleanup_disabled" );
}

// Namespace zm_cleanup_manager
// Params 1, eflags: 0x4
// Checksum 0x7fea5fa, Offset: 0x22df
// Size: 0x2f
function private on_zombie_ai_spawned( params )
{
    if ( self.subclass_scriptbundle.navmeshlayer == "zombie_med" )
    {
        thread zombie_med_stuck_monitor();
    }
}

// Namespace zm_cleanup_manager
// Params 0, eflags: 0xc
// Checksum 0x7d0d25bb, Offset: 0x2316
// Size: 0x279
function private zombie_med_stuck_monitor()
{
    self notify( #"hash_b6c8fcd821aaf8b5" );
    self endon( #"hash_b6c8fcd821aaf8b5" );
    self endon( #"death" );
    
    while ( true )
    {
        stuck_test_point = undefined;
        stuck_time = undefined;
        wait 0.25;
        
        while ( self.b_in_spawn_closet || zombie_traverse::is_traversing() )
        {
            wait 0.25;
        }
        
        while ( true )
        {
            stuck_test_point = getclosestpointonnavmesh( self.origin, self, 0, 0, 0, 1 );
            
            if ( isdefined( stuck_test_point ) )
            {
                break;
            }
            
            wait 1;
        }
        
        while ( true )
        {
            var_c0508d719613ca2f = self function_c607805e62ad17af();
            
            if ( var_c0508d719613ca2f < 0 )
            {
                stuck_time = undefined;
                start_node = self getnegotiationstartnode();
                
                if ( isdefined( start_node ) && stuck_test_point != start_node.origin )
                {
                    zone = zone_manager::function_90e5c3e2272b0130( start_node.origin );
                    
                    if ( isdefined( zone ) && zone.is_enabled )
                    {
                        stuck_test_point = start_node.origin;
                    }
                }
            }
            else if ( isdefined( self.enemy ) && isdefined( stuck_test_point ) && var_c0508d719613ca2f > 2000 )
            {
                if ( !self isposreachable( stuck_test_point ) )
                {
                    curr_time = gettime();
                    
                    if ( !isdefined( stuck_time ) )
                    {
                        stuck_time = curr_time;
                    }
                    
                    var_c705d5c8cb5ae495 = curr_time - stuck_time;
                    var_c6c25fcc14bb9bac = 0;
                    var_219709696282ca91 = 0;
                    
                    foreach ( player in level.players )
                    {
                        if ( !isalive( player ) || player.sessionstate == "spectator" )
                        {
                            continue;
                        }
                        
                        var_c6c25fcc14bb9bac |= self cansee( player );
                        var_219709696282ca91 |= function_219709696282ca91( player );
                        
                        if ( var_c6c25fcc14bb9bac && var_219709696282ca91 )
                        {
                            break;
                        }
                    }
                    
                    if ( var_c705d5c8cb5ae495 > 10000 || var_c705d5c8cb5ae495 > 5000 && !var_219709696282ca91 || var_c705d5c8cb5ae495 > 1000 && !var_c6c25fcc14bb9bac && !var_219709696282ca91 )
                    {
                        function_44f5bec4abb163f1( 1, 1 );
                        break;
                    }
                }
            }
            
            wait 1;
        }
    }
}

/#

    // Namespace zm_cleanup_manager
    // Params 0, eflags: 0x4
    // Checksum 0x550d165a, Offset: 0x2597
    // Size: 0x44, Type: dev
    function private function_dd75c560058bcc51()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1ec>" );
        devgui::add_devgui_func( "<dev string:x1fc>", "<dev string:x211>", &toggle_debug_cleanup );
        devgui::add_devgui_func( "<dev string:x223>", "<dev string:x23a>", &toggle_cleanup );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_cleanup_manager
    // Params 0, eflags: 0x4
    // Checksum 0x75b1ae9e, Offset: 0x25e3
    // Size: 0x1a, Type: dev
    function private toggle_debug_cleanup()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x24d>", @"zm_cleanup_debug" );
    }

    // Namespace zm_cleanup_manager
    // Params 2, eflags: 0x4
    // Checksum 0x19c8561c, Offset: 0x2605
    // Size: 0x6f, Type: dev
    function private cleanup_print( text, offset )
    {
        if ( !isdefined( offset ) )
        {
            offset = ( 0, 0, 0 );
        }
        
        if ( debug_cleanup() )
        {
            print3d( self.origin + ( 0, 0, 70 ) + offset, "<dev string:x25e>" + text, ( 1, 0, 0 ), 1, 1, 50 );
        }
    }

    // Namespace zm_cleanup_manager
    // Params 0, eflags: 0x4
    // Checksum 0x7406e176, Offset: 0x267c
    // Size: 0x14, Type: dev
    function private debug_cleanup()
    {
        return getdvarint( @"zm_cleanup_debug", 0 );
    }

    // Namespace zm_cleanup_manager
    // Params 0, eflags: 0x4
    // Checksum 0xb2c76e78, Offset: 0x2698
    // Size: 0x1a, Type: dev
    function private toggle_cleanup()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x26e>", @"zm_cleanup_enabled" );
    }

#/
