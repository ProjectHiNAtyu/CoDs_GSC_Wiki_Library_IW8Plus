// scripts\common\ai\aitypes\shared\zombie\zombie_utils.gsc  (hash_6c2f6a14fa53759e.gscc) (size: 9136 Bytes / 0x23b0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x974f379f (2538551199)
// size ...... 9136 (0x23b0)
// includes .. 10  (offset: 0x2240)
// strings ... 14  (offset: 0x2290)
// dev strs .. 8   (offset: 0x2348)
// exports ... 30  (offset: 0x1604)
// cseg ...... 0x11d + 0x14e7 (0x1604)
// imports ... 63  (offset: 0x1ab4)
// animtree1 . 0   (offset: 0x23b0)
// animtree2 . 0   (offset: 0x23b0)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\throttle;
#using scripts\common\utility;

#namespace zombie_utils;

// Namespace zombie_utils
// Params 0, eflags: 0x1
// Checksum 0xd3317dd3, Offset: 0x13b
// Size: 0x110
function autoexec init()
{
    utility::registersharedfunc( #"zombie_utils", #"setmovespeed", &function_a8ce00e0448cb6f0 );
    utility::registersharedfunc( #"zombie_utils", #"settarget", &set_ai_target_priority );
    utility::registersharedfunc( #"zombie_utils", #"registerdamagecallback", &function_dfae6a5bd222c586 );
    utility::registersharedfunc( #"zombie_utils", #"turn_ai", &function_c2cee1190760989c );
    utility::registersharedfunc( #"zombie_utils", #"turn_ai_back", &turn_ai_back );
    utility::registersharedfunc( #"zombie_utils", #"hash_ed46e37d3efd53d3", &function_bf1464d09f4e4b40 );
    utility::registersharedfunc( #"zombie_utils", #"removedamagecallback", &function_10c0c35c21e3ed9d );
    utility::registersharedfunc( #"zombie_utils", #"set_zombie_round_difficulty", &set_zombie_round_difficulty );
    utility::registersharedfunc( #"zombie_utils", #"get_zombie_round_difficulty", &get_zombie_round_difficulty );
}

// Namespace zombie_utils
// Params 3
// Checksum 0xf5c12bfb, Offset: 0x253
// Size: 0x300
function function_a8ce00e0448cb6f0( move_speed_value, id, priority )
{
    assert( utility::ent_flag( "<dev string:x24>" ), "<dev string:x35>" );
    
    if ( !isdefined( id ) )
    {
        id = "default";
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    if ( !isdefined( self.var_3e434da475d20265 ) )
    {
        self.var_3e434da475d20265 = [];
    }
    
    if ( isdefined( move_speed_value ) )
    {
        target_speed = getanimspeedthreshold( self, move_speed_value );
        
        if ( !isdefined( target_speed ) )
        {
            return;
        }
    }
    
    move_speed_struct = spawnstruct();
    move_speed_struct.id = id;
    move_speed_struct.move_speed_value = move_speed_value;
    move_speed_struct.priority = priority;
    
    for ( i = 0; i < self.var_3e434da475d20265.size ; i++ )
    {
        current = self.var_3e434da475d20265[ i ];
        
        if ( isdefined( current ) && current.id == id )
        {
            self.var_3e434da475d20265[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( self.var_3e434da475d20265 );
            }
            
            break;
        }
    }
    
    var_abe85f5f715a6eb5 = 0;
    
    if ( isdefined( move_speed_value ) )
    {
        for ( i = 0; i < self.var_3e434da475d20265.size ; i++ )
        {
            current = self.var_3e434da475d20265[ i ];
            
            if ( !isdefined( current ) || current.priority < priority )
            {
                continue;
            }
            
            if ( current.priority == priority )
            {
                assertmsg( "<dev string:x7a>" + current.id + "<dev string:xb0>" + id + "<dev string:xbf>" );
                arrayinsert( self.var_3e434da475d20265, move_speed_struct, i + 1 );
                var_abe85f5f715a6eb5 = 1;
            }
            else if ( current.priority > priority )
            {
                arrayinsert( self.var_3e434da475d20265, move_speed_struct, i );
                var_abe85f5f715a6eb5 = 1;
            }
            
            break;
        }
        
        if ( !var_abe85f5f715a6eb5 )
        {
            var_abe85f5f715a6eb5 = 1;
            self.var_3e434da475d20265[ self.var_3e434da475d20265.size ] = move_speed_struct;
        }
    }
    
    if ( isarray( self.var_3e434da475d20265 ) && isstruct( self.var_3e434da475d20265[ self.var_3e434da475d20265.size - 1 ] ) )
    {
        var_2479fec584964cf0 = self.var_3e434da475d20265[ self.var_3e434da475d20265.size - 1 ].move_speed_value;
        
        if ( !asm_bb::bb_movetyperequested( var_2479fec584964cf0 ) )
        {
            asm_bb::bb_requestmovetype( var_2479fec584964cf0 );
            target_speed = getanimspeedthreshold( self, var_2479fec584964cf0 );
            
            if ( isdefined( target_speed ) )
            {
                self aisetdesiredspeed( target_speed );
                self aisettargetspeed( target_speed );
                priority = self.var_3e434da475d20265[ self.var_3e434da475d20265.size - 1 ].priority;
                callback::callback( "on_move_speed_changed", { #priority:priority, #move_speed:var_2479fec584964cf0 } );
            }
        }
    }
}

// Namespace zombie_utils
// Params 1
// Checksum 0xf24ab6ed, Offset: 0x55b
// Size: 0x6d, Type: bool
function function_5585d9e5cf0a0fa0( id )
{
    if ( self.var_3e434da475d20265 )
    {
        for ( i = 0; i < self.var_3e434da475d20265.size ; i++ )
        {
            current = self.var_3e434da475d20265[ i ];
            
            if ( isdefined( current ) && current.id == id )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_utils
// Params 2
// Checksum 0x115decfd, Offset: 0x5d1
// Size: 0x85, Type: bool
function function_acea107db537cb0f( target_ent, priority )
{
    if ( isdefined( target_ent ) )
    {
        for ( i = 0; i < self.var_114c3198056d5fa9.size ; i++ )
        {
            current = self.var_114c3198056d5fa9[ i ];
            
            if ( !isdefined( current ) || current.priority < priority )
            {
                continue;
            }
            
            if ( current.priority == priority )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_utils
// Params 3
// Checksum 0x3419ab39, Offset: 0x65f
// Size: 0x2c9
function set_ai_target_priority( target_ent, id = "default", priority = 0 )
{
    if ( !isdefined( self.var_114c3198056d5fa9 ) )
    {
        self.var_114c3198056d5fa9 = [];
    }
    
    var_ed92d3edd3eded9 = spawnstruct();
    var_ed92d3edd3eded9.id = id;
    var_ed92d3edd3eded9.target_ent = target_ent;
    var_ed92d3edd3eded9.priority = priority;
    
    for ( i = 0; i < self.var_114c3198056d5fa9.size ; i++ )
    {
        current = self.var_114c3198056d5fa9[ i ];
        
        if ( !isalive( current.target_ent ) || isdefined( current ) && current.id == id )
        {
            self.var_114c3198056d5fa9[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( self.var_114c3198056d5fa9 );
            }
            
            break;
        }
    }
    
    var_abe85f5f715a6eb5 = 0;
    
    if ( isdefined( target_ent ) )
    {
        for ( i = 0; i < self.var_114c3198056d5fa9.size ; i++ )
        {
            current = self.var_114c3198056d5fa9[ i ];
            
            if ( !isdefined( current ) || current.priority < priority )
            {
                continue;
            }
            
            if ( current.priority == priority )
            {
                assertmsg( "<dev string:xf2>" + current.id + "<dev string:xb0>" + id + "<dev string:xbf>" );
                arrayinsert( self.var_114c3198056d5fa9, var_ed92d3edd3eded9, i + 1 );
                var_abe85f5f715a6eb5 = 1;
            }
            else if ( current.priority > priority )
            {
                arrayinsert( self.var_114c3198056d5fa9, var_ed92d3edd3eded9, i );
                var_abe85f5f715a6eb5 = 1;
            }
            
            break;
        }
        
        if ( !var_abe85f5f715a6eb5 )
        {
            var_abe85f5f715a6eb5 = 1;
            self.var_114c3198056d5fa9[ self.var_114c3198056d5fa9.size ] = var_ed92d3edd3eded9;
        }
    }
    
    if ( self.var_114c3198056d5fa9.size > 0 && isstruct( self.var_114c3198056d5fa9[ self.var_114c3198056d5fa9.size - 1 ] ) )
    {
        new_target = self.var_114c3198056d5fa9[ self.var_114c3198056d5fa9.size - 1 ].target_ent;
        
        if ( !isdefined( self.favoriteenemy ) && isdefined( new_target ) || isdefined( self.favoriteenemy ) && !isdefined( new_target ) || self.favoriteenemy != new_target )
        {
            self.favoriteenemy = new_target;
        }
        
        return;
    }
    
    if ( self.var_114c3198056d5fa9.size == 0 && self.favoriteenemy )
    {
        self.favoriteenemy = undefined;
    }
}

// Namespace zombie_utils
// Params 1
// Checksum 0x1a947db3, Offset: 0x930
// Size: 0x39
function function_dfae6a5bd222c586( func )
{
    if ( !isdefined( self.var_f3f3b4d926db02c7 ) )
    {
        self.var_f3f3b4d926db02c7 = [];
    }
    
    self.var_f3f3b4d926db02c7[ self.var_f3f3b4d926db02c7.size ] = func;
}

// Namespace zombie_utils
// Params 1
// Checksum 0xf59e0089, Offset: 0x971
// Size: 0x36
function function_10c0c35c21e3ed9d( func )
{
    if ( !isarray( self.var_f3f3b4d926db02c7 ) )
    {
        return;
    }
    
    self.var_f3f3b4d926db02c7 = arrayremove( self.var_f3f3b4d926db02c7, func );
}

// Namespace zombie_utils
// Params 2
// Checksum 0xd97f0b2b, Offset: 0x9af
// Size: 0x39
function function_b021918a41e1df51( weapon_name, func )
{
    if ( !isdefined( self.var_ad4a0c0e90a75e96 ) )
    {
        self.var_ad4a0c0e90a75e96 = [];
    }
    
    self.var_ad4a0c0e90a75e96[ weapon_name ] = func;
}

// Namespace zombie_utils
// Params 1
// Checksum 0xef283c2a, Offset: 0x9f0
// Size: 0x2a
function function_f856633da44fa83c( weapon_name )
{
    if ( !isarray( self.var_ad4a0c0e90a75e96 ) )
    {
        return;
    }
    
    self.var_ad4a0c0e90a75e96[ weapon_name ] = undefined;
}

// Namespace zombie_utils
// Params 0
// Checksum 0x8c047fad, Offset: 0xa22
// Size: 0x34
function get_zombie_round_difficulty()
{
    assert( isdefined( self._blackboard.var_e9288b4c21f355a9 ) );
    return self._blackboard.var_e9288b4c21f355a9;
}

// Namespace zombie_utils
// Params 3
// Checksum 0xb76bab5, Offset: 0xa5f
// Size: 0xcd
function set_zombie_round_difficulty( round_number, var_a957193b236bb9ba = 1, var_a14bf1d749c136ce = 1 )
{
    assert( isdefined( self._blackboard.var_e9288b4c21f355a9 ) );
    self._blackboard.var_e9288b4c21f355a9 = round_number;
    
    if ( var_a957193b236bb9ba )
    {
        new_health = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( self.var_d6894f01a36b4ff3.healthscriptbundle, round_number );
        ai::set_ai_max_health( new_health );
        self.health = self.maxhealth;
    }
    
    if ( var_a14bf1d749c136ce )
    {
        if ( isdefined( level.var_148e14aa588539af ) )
        {
            [[ level.var_148e14aa588539af ]]( self, round_number );
        }
    }
}

// Namespace zombie_utils
// Params 2
// Checksum 0x6ba83e5e, Offset: 0xb34
// Size: 0x10c
function function_580e82d21a732187( ent, unbounded = 0 )
{
    assert( isdefined( ent ) );
    
    if ( !isdefined( self.var_67de6c7cbecd5d28 ) )
    {
        self.var_67de6c7cbecd5d28 = [];
    }
    
    var_ef5fb942f0eba2b5 = !isdefined( self.var_67de6c7cbecd5d28[ ent getentitynumber() ] );
    var_f4586d1566b33464 = !var_ef5fb942f0eba2b5 && self.var_67de6c7cbecd5d28[ ent getentitynumber() ].time != gettime();
    
    if ( var_ef5fb942f0eba2b5 || var_f4586d1566b33464 )
    {
        var_c7bbccc052e078f2 = spawnstruct();
        var_c7bbccc052e078f2.time = gettime();
        var_c7bbccc052e078f2.origin = self getclosestreachablepointonnavmesh( ent.origin, unbounded );
        self.var_67de6c7cbecd5d28[ ent getentitynumber() ] = var_c7bbccc052e078f2;
    }
    
    var_e16d7c2a575fc93f = self.var_67de6c7cbecd5d28[ ent getentitynumber() ].origin;
    return var_e16d7c2a575fc93f;
}

// Namespace zombie_utils
// Params 2
// Checksum 0xb7bb9823, Offset: 0xc49
// Size: 0xe4
function update_bt_goal( pos, priority )
{
    assert( isdefined( pos ) );
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    if ( isdefined( level.find_zone_path ) && isdefined( level.get_zone_distance ) )
    {
        var_5297ab9a8e6cfe44 = [[ level.get_zone_distance ]]( self.origin, pos );
        path = undefined;
        
        if ( var_5297ab9a8e6cfe44 > 2 )
        {
            path = [[ level.find_zone_path ]]( self.origin, pos );
        }
        
        if ( isarray( path ) && path.size > 2 )
        {
            /#
                self.last_goal_reason = "<dev string:x120>";
            #/
            
            self setbtgoalpos( priority, path[ 1 ].origin );
            return;
        }
    }
    
    /#
        self.last_goal_reason = "<dev string:x12a>";
    #/
    
    self setbtgoalpos( priority, pos );
}

// Namespace zombie_utils
// Params 2
// Checksum 0xd8e37d53, Offset: 0xd35
// Size: 0x39
function function_7ae8d980fd719e78( id, value )
{
    if ( !isdefined( self.var_926019e33c07eee7 ) )
    {
        self.var_926019e33c07eee7 = [];
    }
    
    self.var_926019e33c07eee7[ id ] = value;
}

// Namespace zombie_utils
// Params 1
// Checksum 0xd6ff662e, Offset: 0xd76
// Size: 0x30
function function_b292d64a276f14cc( id )
{
    assert( isdefined( self.var_926019e33c07eee7[ id ] ) );
    return self.var_926019e33c07eee7[ id ];
}

// Namespace zombie_utils
// Params 0
// Checksum 0xd416bba5, Offset: 0xdaf
// Size: 0xd, Type: bool
function function_dd3887f0e9e7ff79()
{
    return utility::ent_flag( "turned" );
}

// Namespace zombie_utils
// Params 0
// Checksum 0xc0ac5304, Offset: 0xdc5
// Size: 0xd, Type: bool
function function_33a24849a0dfd13b()
{
    return status_effects::has_status_effect_type( "charm" );
}

// Namespace zombie_utils
// Params 0
// Checksum 0xde9cc3e7, Offset: 0xddb
// Size: 0x12, Type: bool
function function_bf1464d09f4e4b40()
{
    return function_dd3887f0e9e7ff79() || function_33a24849a0dfd13b();
}

// Namespace zombie_utils
// Params 2
// Checksum 0x1bf6ed60, Offset: 0xdf6
// Size: 0x99
function function_c2cee1190760989c( attacker, scriptable_payload )
{
    if ( function_dd3887f0e9e7ff79() )
    {
        return;
    }
    
    utility::ent_flag_set( "turned" );
    callback::callback( "on_turned", { #scriptable_payload:scriptable_payload, #attacker:attacker } );
    self.health = self.maxhealth;
    self.allowpain = 0;
    
    if ( isdefined( attacker ) && isdefined( attacker.team ) )
    {
        self.team = attacker.team;
    }
    
    self clearpath();
}

// Namespace zombie_utils
// Params 3
// Checksum 0x276cccc6, Offset: 0xe97
// Size: 0x91
function turn_ai_back( originalteam, scriptablepart, scriptablestate )
{
    if ( !function_dd3887f0e9e7ff79() || !originalteam )
    {
        return;
    }
    
    utility::ent_flag_clear( "turned" );
    params = spawnstruct();
    callback::callback( "on_brainrot_end", params );
    self.health = self.maxhealth;
    self.allowpain = 1;
    
    if ( scriptablepart )
    {
        utility::function_32b24db3127bff40( scriptablepart, scriptablestate );
    }
    
    self.team = originalteam;
}

// Namespace zombie_utils
// Params 4
// Checksum 0x1ef92626, Offset: 0xf30
// Size: 0x72
function function_f2e381737e46096( attacker, var_ddd47269e5d6cd98, skip_augments, force )
{
    if ( function_33a24849a0dfd13b() )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"brainrot_zombie" ) )
    {
        utility::callsharedfunc( #"zombie", #"brainrot_zombie", 0, attacker, undefined, undefined, undefined, undefined, undefined, 0, var_ddd47269e5d6cd98, skip_augments, force );
    }
}

// Namespace zombie_utils
// Params 5
// Checksum 0xc1e27d94, Offset: 0xfaa
// Size: 0x42
function get_closest_zombie( origin, team, var_c60105d2445aa45f, max_dist, filter )
{
    return ai::get_ai_closest( origin, team, "zombie", var_c60105d2445aa45f, max_dist, filter );
}

// Namespace zombie_utils
// Params 1
// Checksum 0xdfa1fba7, Offset: 0xff5
// Size: 0x66
function function_a225e7aa4a243fb2( aitypescriptbundle )
{
    assert( isdefined( aitypescriptbundle ) );
    var_22e5e17527a4b653 = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    
    if ( isdefined( var_22e5e17527a4b653.var_394d3c5e6fa40c50 ) )
    {
        var_d3de1a9faac42deb = getscriptbundle( var_22e5e17527a4b653.var_394d3c5e6fa40c50 );
        return var_d3de1a9faac42deb;
    }
}

// Namespace zombie_utils
// Params 1
// Checksum 0xb7480666, Offset: 0x1064
// Size: 0x7b
function function_4e99fb1239980783( params )
{
    if ( isdefined( params.body ) )
    {
        return params.body;
    }
    
    if ( isdefined( params.var_e5f1bac5fedade9 ) )
    {
        body = getentbynum( params.var_e5f1bac5fedade9 );
        
        if ( isactorcorpse( body ) && body.classname == params.var_dffcc08130652cbe )
        {
            return body;
        }
    }
}

// Namespace zombie_utils
// Params 5
// Checksum 0xe51d57d, Offset: 0x10e7
// Size: 0x208
function function_607ff821e430d594( origin, var_29e6002bcbd21280 = 128, stunduration = 1.75, team = "allies", var_b92e88d28029b2ed = 0 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( level.zombie_util_knockdown_throttle ) )
    {
        level.zombie_util_knockdown_throttle = throttle::throttle_initialize( "zombie_util_knockdown", 3, level.framedurationseconds );
    }
    
    var_3e5df7c437647749 = getaiarrayinradius( origin, var_29e6002bcbd21280 );
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            var_3e5df7c437647749 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_3e5df7c437647749, self );
        }
    }
    
    foreach ( zombie in var_3e5df7c437647749 )
    {
        if ( zombie.team == team )
        {
            continue;
        }
        
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( isdefined( zombie.aicategory ) )
        {
            if ( zombie.aicategory == "normal" )
            {
                if ( zombie zombie_knockdown::function_2eb6752428726543() )
                {
                    zombie zombie_knockdown::function_6fc167d4a3590991( origin );
                }
                else
                {
                    zombie zombie_stun::stun_ai( stunduration );
                }
            }
            else if ( var_b92e88d28029b2ed )
            {
                zombie zombie_stun::stun_ai( stunduration );
            }
        }
        else if ( zombie.unittype == "human" )
        {
            zombie notify( #"flashbang", zombie.origin, 1, 1, undefined, team );
        }
        
        throttle::throttle_wait_in_queue( level.zombie_util_knockdown_throttle, self );
    }
}

// Namespace zombie_utils
// Params 1
// Checksum 0xf64817e2, Offset: 0x12f7
// Size: 0xbc, Type: bool
function try_despawn_zombie( leavecorpse = 0 )
{
    if ( !isdefined( self.asmname ) || !self asmhasstate( self.asmname, "despawn_in" ) )
    {
        return false;
    }
    
    aliases = archetypegetaliases( self.animsetname, "despawn" );
    
    if ( !isdefined( aliases ) || aliases.size == 0 )
    {
        return false;
    }
    
    if ( self.disallow_despawn )
    {
        return false;
    }
    
    if ( !self._blackboard.var_903cd88c07cfc16b )
    {
        self notify( #"despawn" );
        
        if ( !leavecorpse )
        {
            self.var_b1d9042e7d29abb8 = 1;
        }
        
        asm::asm_setstate( "despawn_in" );
    }
    
    return true;
}

// Namespace zombie_utils
// Params 2
// Checksum 0xedaef0d, Offset: 0x13bc
// Size: 0x11f
function register_health_state_callback( var_35069c22d08b1f24, callback )
{
    if ( !( isdefined( var_35069c22d08b1f24 ) && isdefined( callback ) ) )
    {
        return;
    }
    
    if ( !isdefined( self.health_state_callbacks ) )
    {
        self.health_state_callbacks = [];
    }
    
    if ( !self.health_state_callbacks.size )
    {
        self.health_state_callbacks[ self.health_state_callbacks.size ] = { #callback:callback, #var_35069c22d08b1f24:var_35069c22d08b1f24 };
        return;
    }
    
    foreach ( index, var_6fcb51fd383c5fa in self.health_state_callbacks )
    {
        if ( var_35069c22d08b1f24 < var_6fcb51fd383c5fa.var_35069c22d08b1f24 )
        {
            arrayinsert( self.health_state_callbacks, { #callback:callback, #var_35069c22d08b1f24:var_35069c22d08b1f24 }, index );
            return;
        }
    }
}

// Namespace zombie_utils
// Params 2
// Checksum 0x7a7f45d0, Offset: 0x14e3
// Size: 0x102, Type: bool
function function_584d912c70295d81( healthpct, var_45f2beaaf602ef55 )
{
    if ( !isdefined( self.var_d6894f01a36b4ff3.var_a8c018f581370760 ) )
    {
        return false;
    }
    
    foreach ( shield_data in self.var_d6894f01a36b4ff3.var_a8c018f581370760 )
    {
        if ( shield_data.healthpct > 0 && shield_data.healthpct == healthpct )
        {
            self.var_2127b832226be646 = clamp( 1 - shield_data.reducedamage, 0, 1 );
            self.var_45f2beaaf602ef55 = var_45f2beaaf602ef55;
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_utils
// Params 0
// Checksum 0xc3bcdbf5, Offset: 0x15ee
// Size: 0x16
function function_6467c6da3b68c7e5()
{
    self.var_2127b832226be646 = undefined;
    self.var_45f2beaaf602ef55 = undefined;
}

