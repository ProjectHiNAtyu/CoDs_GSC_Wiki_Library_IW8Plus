// script_3d224bcd5ba96094  (hash_3d224bcd5ba96094.gscc) (size: 8578 Bytes / 0x2182 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x934f8864 (2471463012)
// size ...... 8578 (0x2182)
// includes .. 10  (offset: 0x1f42)
// strings ... 18  (offset: 0x1f92)
// dev strs .. 17  (offset: 0x20a2)
// exports ... 15  (offset: 0x14aa)
// cseg ...... 0x277 + 0x1233 (0x14aa)
// imports ... 67  (offset: 0x1702)
// animtree1 . 0   (offset: 0x2182)
// animtree2 . 0   (offset: 0x2182)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\player;

#namespace zombie_triton_targeting;

// Namespace zombie_triton_targeting
// Params 0
// Checksum 0x5535272a, Offset: 0x295
// Size: 0x2c
function function_4116d6da87f957b8()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_a38bc494a40d08f4 );
    
    /#
        function_8b74e66a370845d5();
    #/
}

// Namespace zombie_triton_targeting
// Params 0
// Checksum 0x46d2d559, Offset: 0x2c9
// Size: 0x2d
function init_zombie_triton_targeting()
{
    thread function_496154843c5cf840();
    self.var_c3cf35bf363a00b = [];
    utility::ent_flag_set( "look_for_burst_damage_target" );
    thread function_86b7f1612749c47d();
    thread function_dc27987ad3359f98();
}

// Namespace zombie_triton_targeting
// Params 1
// Checksum 0xce2c5816, Offset: 0x2fe
// Size: 0x58
function function_f5c10ded7711e35b( targetent )
{
    self.var_e18f0d242b4a8c57 = 0;
    self.var_71df68fe9f212b8d = 0;
    self._blackboard.var_b47ad26aa439acbc = ( 0, 0, 0 );
    utility::ent_flag_clear( "look_for_burst_damage_target", 1 );
    thread set_burst_damage_target( targetent );
}

// Namespace zombie_triton_targeting
// Params 1
// Checksum 0x31a6387, Offset: 0x35e
// Size: 0x28
function function_b07a430d3df9df65( timeinseconds )
{
    assert( timeinseconds >= 0, "<dev string:x24>" );
    self.var_47f35434b8887c71 = timeinseconds;
}

// Namespace zombie_triton_targeting
// Params 1
// Checksum 0xfe729fc4, Offset: 0x38e
// Size: 0x28
function function_6891912552daaaef( timeinseconds )
{
    assert( timeinseconds >= 0, "<dev string:x6b>" );
    self.var_59fbdc5e5b6ae34d = timeinseconds;
}

// Namespace zombie_triton_targeting
// Params 1, eflags: 0x4
// Checksum 0x9ff091c3, Offset: 0x3be
// Size: 0x424
function private function_a38bc494a40d08f4( params )
{
    self endon( #"death" );
    
    if ( !utility::ent_flag_exist( "look_for_burst_damage_target" ) )
    {
        return;
    }
    
    if ( self._blackboard.var_606bf8ea1f70975d == 0 )
    {
        return;
    }
    
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:xac>" );
    var_c02544ff729a8825 = utility::function_4b74c15943231980( getdvarfloat( @"hash_ab01537c7ed74adf", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f841234cdd739534 ) );
    
    if ( gettime() - params.timehit >= var_c02544ff729a8825 )
    {
        return;
    }
    
    if ( isdefined( params.eattacker ) )
    {
        var_d70e9d6742fce163 = params.eattacker getentitynumber();
        
        if ( !isplayer( params.eattacker ) || isdefined( params.eattacker.team ) && !isenemyteam( params.eattacker.team, self.team ) )
        {
            if ( isdefined( self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] ) )
            {
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
            }
            
            return;
        }
        
        if ( params.eattacker.ignoreme || params.eattacker.notarget || params.eattacker.aether_shroud_active || params.eattacker getthreatbiasgroup() == "ignored_by_zombies" || player::isinlaststand( params.eattacker ) )
        {
            if ( isdefined( self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] ) )
            {
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
            }
            
            return;
        }
        
        if ( !isdefined( self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] ) )
        {
            self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = spawnstruct();
            self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be = [];
        }
        
        var_3799c3813662860b = 0;
        var_86b494bfb6e92287 = [];
        
        foreach ( damagetimestamp in self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be )
        {
            if ( params.timehit - damagetimestamp.timehit <= var_c02544ff729a8825 )
            {
                var_86b494bfb6e92287[ var_86b494bfb6e92287.size ] = damagetimestamp;
                var_3799c3813662860b += damagetimestamp.damage;
            }
        }
        
        var_3799c3813662860b += params.idamage;
        var_9a83a452be1e6e71 = var_3799c3813662860b / self.maxhealth;
        var_9a83a452be1e6e71 *= 100;
        
        if ( var_9a83a452be1e6e71 >= getdvarfloat( @"hash_fc22d147dfe0cd59", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ed68a9c61a68f113 ) )
        {
            function_f5c10ded7711e35b( params.eattacker );
            return;
        }
        
        self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be = var_86b494bfb6e92287;
        damagetimestamp = spawnstruct();
        damagetimestamp.timehit = params.timehit;
        damagetimestamp.damage = params.idamage;
        self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be[ self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be.size ] = damagetimestamp;
        self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_9a83a452be1e6e71 = var_9a83a452be1e6e71;
        self.var_c3cf35bf363a00b = arraysort( self.var_c3cf35bf363a00b, undefined, &function_364e22185b34ec5 );
    }
}

// Namespace zombie_triton_targeting
// Params 1, eflags: 0x4
// Checksum 0xf3222a47, Offset: 0x7ea
// Size: 0x2cf
function private set_burst_damage_target( targetent )
{
    self endon( #"death" );
    utility::ent_flag_set( "currently_targeting_burst_target" );
    var_dfeda7d19f472e12 = self getthreatbiasgroup();
    agent_utils::function_4ba92f680237cedb( self, "triton_burst_damage_boss_group" );
    self.var_14ac7f76b960e009 = targetent;
    nearbyplayers = self.nearbyplayers ?? namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, 3000 );
    
    foreach ( nearbyplayer in nearbyplayers )
    {
        if ( targetent == nearbyplayer )
        {
            continue;
        }
        
        nearbyplayer.var_941f0a8363236c43 = nearbyplayer getthreatbiasgroup();
        agent_utils::function_33f83956b1b9af77( nearbyplayer, "triton_burst_damage_ignore_group" );
    }
    
    var_58484bfab39b6513 = gettime();
    
    while ( gettime() - var_58484bfab39b6513 <= utility::function_4b74c15943231980( getdvarfloat( @"hash_1244b35464202b44", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9619a29458f2d08d ) ) )
    {
        if ( !isdefined( self.var_14ac7f76b960e009 ) || player::isinlaststand( self.var_14ac7f76b960e009 ) || !isalive( self.var_14ac7f76b960e009 ) )
        {
            break;
        }
        
        if ( self.var_14ac7f76b960e009.ignoreme || self.var_14ac7f76b960e009.notarget || self.var_14ac7f76b960e009.aether_shroud_active || self.var_14ac7f76b960e009 getthreatbiasgroup() == "ignored_by_zombies" )
        {
            break;
        }
        
        if ( utility::ent_flag( "armor_piece_broke_while_already_focused_on_burst_damage_target" ) )
        {
            utility::ent_flag_clear( "armor_piece_broke_while_already_focused_on_burst_damage_target" );
            break;
        }
        
        waitframe();
    }
    
    foreach ( nearbyplayer in nearbyplayers )
    {
        if ( targetent == nearbyplayer )
        {
            continue;
        }
        
        agent_utils::function_33f83956b1b9af77( nearbyplayer, nearbyplayer.var_941f0a8363236c43 );
    }
    
    self.var_c3cf35bf363a00b = [];
    self.var_e18f0d242b4a8c57 = 1;
    self.var_71df68fe9f212b8d = 1;
    self.var_14ac7f76b960e009 = undefined;
    agent_utils::function_4ba92f680237cedb( self, var_dfeda7d19f472e12 );
    utility::ent_flag_clear( "currently_targeting_burst_target" );
    utility::ent_flag_set( "look_for_burst_damage_target" );
}

// Namespace zombie_triton_targeting
// Params 0, eflags: 0x4
// Checksum 0x941baa8a, Offset: 0xac1
// Size: 0x43
function private function_496154843c5cf840()
{
    self endon( #"death" );
    utility::ent_flag_wait( "zombie_asm_init_finished" );
    agent_utils::ai_createthreatbiasgroup( "triton_burst_damage_boss_group" );
    agent_utils::ai_createthreatbiasgroup( "triton_burst_damage_ignore_group" );
    agent_utils::ai_setignoremegroup( "triton_burst_damage_ignore_group", "triton_burst_damage_boss_group" );
}

// Namespace zombie_triton_targeting
// Params 0, eflags: 0x4
// Checksum 0x8a028ae7, Offset: 0xb0c
// Size: 0x283
function private function_86b7f1612749c47d()
{
    self endon( #"death" );
    
    if ( !isdefined( level.search_for_nearby_enemy_to_foot_stomp_throttle ) )
    {
        level.search_for_nearby_enemy_to_foot_stomp_throttle = throttle::throttle_initialize( "search_for_nearby_enemy_to_foot_stomp_throttle", 1 );
    }
    
    utility::ent_flag_wait( "foot_stomp_range_defined" );
    self.var_e18f0d242b4a8c57 = 1;
    self.var_4e665f889f49e49 = gettime();
    self.var_47f35434b8887c71 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_47f35434b8887c71;
    var_a1fd3b6d68672c35 = squared( self getaiblackboarddynamic( "footStompAttackRange" ) );
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.search_for_nearby_enemy_to_foot_stomp_throttle, self );
        
        if ( !self.var_e18f0d242b4a8c57 )
        {
            continue;
        }
        
        if ( self._blackboard.var_606bf8ea1f70975d == 0 )
        {
            continue;
        }
        
        if ( !isdefined( self.enemy ) )
        {
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_foot_stomp" ) || self getaiblackboarddynamic( "foot_stomp_nearby_enemy" ) )
        {
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_ground_slam" ) || zombie_leap_attack::is_in_leap_attack() || self getaiblackboarddynamic( "in_armor_break" ) )
        {
            continue;
        }
        
        if ( gettime() - self.var_4e665f889f49e49 <= utility::function_4b74c15943231980( self.var_47f35434b8887c71 ) )
        {
            continue;
        }
        
        foreach ( entnumber, attackercalculations in self.var_c3cf35bf363a00b )
        {
            currentent = getentbynum( entnumber );
            
            if ( !isalive( currentent ) || self.enemy == currentent || player::isinlaststand( currentent ) )
            {
                continue;
            }
            
            var_a55df8993943a22e = distance2dsquared( self.origin, self.enemy.origin );
            
            if ( var_a55df8993943a22e <= var_a1fd3b6d68672c35 )
            {
                continue;
            }
            
            var_fb56dbc8e5f65b1d = distance2dsquared( self.origin, currentent.origin );
            
            if ( var_fb56dbc8e5f65b1d <= var_a1fd3b6d68672c35 )
            {
                self function_786bb6aa1b76c7ee( "foot_stomp_nearby_enemy", 1 );
                self.var_d5406f9626075326 = currentent;
                self.var_4e665f889f49e49 = gettime();
                break;
            }
        }
    }
}

// Namespace zombie_triton_targeting
// Params 0, eflags: 0x4
// Checksum 0x4e52b377, Offset: 0xd97
// Size: 0x2a2
function private function_dc27987ad3359f98()
{
    self endon( #"death" );
    self.var_71df68fe9f212b8d = 1;
    self.var_93fff9a1f95eb84d = gettime();
    self.var_59fbdc5e5b6ae34d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_59fbdc5e5b6ae34d;
    self._blackboard.var_b47ad26aa439acbc = ( 0, 0, 0 );
    
    if ( !isdefined( level.search_for_far_away_enemy_to_leap_slam_throttle ) )
    {
        level.search_for_far_away_enemy_to_leap_slam_throttle = throttle::throttle_initialize( "search_for_far_away_enemy_to_leap_slam_throttle", 1 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.search_for_far_away_enemy_to_leap_slam_throttle, self );
        
        if ( !self.var_71df68fe9f212b8d )
        {
            continue;
        }
        
        if ( self._blackboard.var_606bf8ea1f70975d == 0 )
        {
            continue;
        }
        
        if ( !isdefined( self.enemy ) )
        {
            continue;
        }
        
        if ( zombie_leap_attack::is_in_leap_attack() )
        {
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_foot_stomp" ) || self getaiblackboarddynamic( "in_ground_slam" ) || self getaiblackboarddynamic( "in_armor_break" ) )
        {
            continue;
        }
        
        if ( gettime() - self.var_93fff9a1f95eb84d <= utility::function_4b74c15943231980( self.var_59fbdc5e5b6ae34d ) )
        {
            continue;
        }
        
        foreach ( entnumber, attackercalculations in self.var_c3cf35bf363a00b )
        {
            currentent = getentbynum( entnumber );
            
            if ( !isalive( currentent ) || self.enemy == currentent || player::isinlaststand( currentent ) )
            {
                continue;
            }
            
            var_e91841b4763100e7 = rotatepointaroundvector( ( 0, 0, 1 ), ( -168.945, 0, 0 ), vectortoyaw( anglestoforward( self.angles ) ) );
            self._blackboard.var_b47ad26aa439acbc = currentent.origin + var_e91841b4763100e7;
            var_8d739ef09aeea955 = utility::waittill_any_timeout( 0.5, "leap_attack_start" );
            var_8d739ef09aeea955 = var_8d739ef09aeea955 != "timeout";
            
            if ( var_8d739ef09aeea955 )
            {
                self.var_93fff9a1f95eb84d = gettime();
                break;
            }
        }
        
        self._blackboard.var_b47ad26aa439acbc = ( 0, 0, 0 );
    }
}

// Namespace zombie_triton_targeting
// Params 2, eflags: 0x4
// Checksum 0x73ebb670, Offset: 0x1041
// Size: 0x2c, Type: bool
function private function_364e22185b34ec5( a, b )
{
    return a.var_9a83a452be1e6e71 > b.var_9a83a452be1e6e71;
}

/#

    // Namespace zombie_triton_targeting
    // Params 0
    // Checksum 0x2b18a755, Offset: 0x1076
    // Size: 0x48, Type: dev
    function function_8b74e66a370845d5()
    {
        devgui::function_9082edeb5db93280( "<dev string:x120>" );
        devgui::add_devgui_func( "<dev string:x142>", "<dev string:x16b>", &function_c7e28d7c265f134, 1 );
        devgui::add_devgui_func( "<dev string:x194>", "<dev string:x1a1>", &function_9651d61160ff070, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_triton_targeting
    // Params 0, eflags: 0x4
    // Checksum 0x259ca024, Offset: 0x10c6
    // Size: 0x92, Type: dev
    function private function_c7e28d7c265f134()
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1bc>" );
        
        if ( isdefined( triton ) )
        {
            iprintlnbold( "<dev string:x1ca>" + !triton utility::ent_flag_exist( "<dev string:x1f2>" ) );
            triton.var_c3cf35bf363a00b = [];
            
            if ( triton utility::ent_flag_exist( "<dev string:x1f2>" ) )
            {
                triton utility::ent_flag_clear( "<dev string:x1f2>", 1 );
                triton zombie_utils::set_ai_target_priority( undefined, "<dev string:x20f>", 99999 );
            }
        }
    }

    // Namespace zombie_triton_targeting
    // Params 0, eflags: 0x4
    // Checksum 0xdcaf4fa0, Offset: 0x1160
    // Size: 0x34a, Type: dev
    function private function_9651d61160ff070()
    {
        info_text_color = ( 1, 1, 0 );
        var_54d40894fbb5f6de = ( 1, 0, 0 );
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1bc>" );
        
        while ( true )
        {
            if ( !isalive( triton ) )
            {
                return;
            }
            
            if ( triton._blackboard.var_606bf8ea1f70975d == 0 )
            {
                return;
            }
            
            if ( triton utility::ent_flag( "<dev string:x1f2>" ) && isdefined( triton.var_c3cf35bf363a00b ) && triton.var_c3cf35bf363a00b.size > 0 )
            {
                var_ee200dc52b8db055 = undefined;
                var_c02544ff729a8825 = utility::function_4b74c15943231980( triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f841234cdd739534 );
                level debug::function_298a6c4895b8935d( ( 400, 300, 0 ) );
                level debug::function_ce323c1a383e915( "<dev string:x223>", info_text_color );
                
                foreach ( entnumber, attackercalculations in triton.var_c3cf35bf363a00b )
                {
                    totaldamage = 0;
                    
                    foreach ( damagetimestamp in attackercalculations.var_1e552358f8a271be )
                    {
                        if ( gettime() - damagetimestamp.timehit <= var_c02544ff729a8825 )
                        {
                            totaldamage += damagetimestamp.damage;
                        }
                    }
                    
                    if ( totaldamage != 0 )
                    {
                        level debug::function_ce323c1a383e915( "<dev string:x25a>" + entnumber + "<dev string:x25f>" + totaldamage, info_text_color );
                    }
                }
            }
            else if ( isdefined( triton.var_14ac7f76b960e009 ) )
            {
                if ( !isdefined( var_ee200dc52b8db055 ) )
                {
                    var_ee200dc52b8db055 = gettime();
                }
                
                assert( isdefined( triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:xac>" );
                timeleft = utility::function_4b74c15943231980( triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9619a29458f2d08d ) - gettime() - var_ee200dc52b8db055;
                level debug::function_298a6c4895b8935d( ( 400, 300, 0 ) );
                level debug::function_ce323c1a383e915( "<dev string:x271>" + triton.var_14ac7f76b960e009 getentitynumber(), var_54d40894fbb5f6de );
                level debug::function_ce323c1a383e915( "<dev string:x291>" + utility::function_6f5d2e1f1ff70482( timeleft ), var_54d40894fbb5f6de );
                level thread utility::draw_entity_bounds( triton.var_14ac7f76b960e009, 1, ( 1, 0, 0 ), 1, 0.2 );
            }
            
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

#/
