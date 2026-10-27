// scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager.gsc  (hash_15ce43f40ea0fd2b.gscc) (size: 18526 Bytes / 0x485e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x195a2eb4 (425340596)
// size ...... 18526 (0x485e)
// includes .. 7   (offset: 0x44b6)
// strings ... 41  (offset: 0x44ee)
// dev strs .. 29  (offset: 0x46f2)
// exports ... 41  (offset: 0x2f5a)
// cseg ...... 0x369 + 0x2bf1 (0x2f5a)
// imports ... 124 (offset: 0x35c2)
// animtree1 . 0   (offset: 0x485e)
// animtree2 . 0   (offset: 0x485e)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace zombie_attractor_manager;

// Namespace zombie_attractor_manager
// Params 0, eflags: 0x1
// Checksum 0xbf4e6b46, Offset: 0x387
// Size: 0xad
function autoexec init()
{
    utility::registersharedfunc( #"zombie_attractor", #"init", &init_zombie_attractor_manager );
    utility::registersharedfunc( #"zombie_attractor", #"addattractor", &add_attractor );
    utility::registersharedfunc( #"zombie_attractor", #"removeattractor", &remove_attractor );
    utility::registersharedfunc( #"zombie_attractor", #"addonself", &function_7eb1aaa8bc7cc15 );
    utility::registersharedfunc( #"zombie_attractor", #"removeonself", &function_dcfb4c31f1d97cd2 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_14cd05bcce8c23a3", &function_e3743c2577dbec4a );
}

// Namespace zombie_attractor_manager
// Params 0, eflags: 0x5
// Checksum 0xb11740a9, Offset: 0x43c
// Size: 0x6d
function private autoexec init_zombie_attractor_manager()
{
    if ( level.gametypebundle.var_8318eed5fd779573 )
    {
        return;
    }
    
    level.active_attractors = [];
    level.var_f1c750caecfbc463 = [];
    callback::get_template( "zombie" ) callback::add( "damage_point", &on_damage_point );
    scriptable::scriptable_adddamagedcallback( &on_scriptable_damaged );
    thread function_1760643af2232fc2();
    thread function_65e71f6a299ba6c9();
    
    /#
        thread function_4069f770eb8785e7();
    #/
}

// Namespace zombie_attractor_manager
// Params 10
// Checksum 0x6876a64a, Offset: 0x4b1
// Size: 0x141
function add_attractor( var_c6969b9fb8f1cf23, priority, range, var_927d86585b9a5ff7, var_b29803c8278047e1, var_1466dd1a94ffa11e, is_nullifier, var_3ec7444e5bce7d0a, var_79eafbbf83b29fe9, var_e359b706d5b60ecf )
{
    assert( isent( var_c6969b9fb8f1cf23 ) || isstruct( var_c6969b9fb8f1cf23 ) || !isent( var_c6969b9fb8f1cf23 ) && var_c6969b9fb8f1cf23 isscriptableinstance() );
    assert( isdefined( var_c6969b9fb8f1cf23.origin ) );
    
    if ( !isdefined( var_c6969b9fb8f1cf23.origin ) )
    {
        return;
    }
    
    var_5f4d19ee2f1cae92 = spawnstruct();
    var_5f4d19ee2f1cae92.source = var_c6969b9fb8f1cf23;
    var_5f4d19ee2f1cae92.var_1466dd1a94ffa11e = var_1466dd1a94ffa11e;
    
    if ( isdefined( var_3ec7444e5bce7d0a ) )
    {
        var_5f4d19ee2f1cae92.source.team = var_3ec7444e5bce7d0a;
    }
    
    if ( !isdefined( var_5f4d19ee2f1cae92.source.team ) )
    {
        var_5f4d19ee2f1cae92.source.team = "allies";
    }
    
    level _add_attractor_internal( var_5f4d19ee2f1cae92, priority, range, var_927d86585b9a5ff7, var_b29803c8278047e1, is_nullifier, var_79eafbbf83b29fe9, var_e359b706d5b60ecf );
    return var_5f4d19ee2f1cae92;
}

// Namespace zombie_attractor_manager
// Params 10
// Checksum 0xd35a642f, Offset: 0x5fb
// Size: 0x147
function function_7eb1aaa8bc7cc15( var_c6969b9fb8f1cf23, priority, range, var_927d86585b9a5ff7, var_b29803c8278047e1, var_1466dd1a94ffa11e, is_nullifier, var_3ec7444e5bce7d0a, var_79eafbbf83b29fe9, var_e359b706d5b60ecf )
{
    assert( isent( var_c6969b9fb8f1cf23 ) || isstruct( var_c6969b9fb8f1cf23 ) );
    assert( isdefined( var_c6969b9fb8f1cf23.origin ) );
    
    if ( !isdefined( var_c6969b9fb8f1cf23.origin ) )
    {
        return;
    }
    
    var_5f4d19ee2f1cae92 = spawnstruct();
    var_5f4d19ee2f1cae92.source = var_c6969b9fb8f1cf23;
    var_5f4d19ee2f1cae92.var_1466dd1a94ffa11e = var_1466dd1a94ffa11e;
    
    if ( isdefined( var_3ec7444e5bce7d0a ) )
    {
        var_5f4d19ee2f1cae92.source.team = var_3ec7444e5bce7d0a;
    }
    
    if ( !isdefined( var_5f4d19ee2f1cae92.source.team ) )
    {
        var_5f4d19ee2f1cae92.source.team = "allies";
    }
    
    level.var_f1c750caecfbc463 = arraycombineunique( level.var_f1c750caecfbc463, [ self ] );
    _add_attractor_internal( var_5f4d19ee2f1cae92, priority, range, var_927d86585b9a5ff7, var_b29803c8278047e1, is_nullifier, var_79eafbbf83b29fe9, var_e359b706d5b60ecf );
    return var_5f4d19ee2f1cae92;
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0xc5d130c6, Offset: 0x74b
// Size: 0x15
function remove_attractor( var_66e511e2765463fe )
{
    return level _remove_attractor_internal( var_66e511e2765463fe );
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0xca5ca535, Offset: 0x769
// Size: 0x14
function function_dcfb4c31f1d97cd2( var_66e511e2765463fe )
{
    return _remove_attractor_internal( var_66e511e2765463fe );
}

// Namespace zombie_attractor_manager
// Params 0
// Checksum 0xc7975bf, Offset: 0x786
// Size: 0x404, Type: bool
function calculate_target_attractor()
{
    var_44dde87daaca7970 = self function_af79ce8d7dd29cdf();
    
    if ( !isdefined( var_44dde87daaca7970 ) || var_44dde87daaca7970.size <= 0 )
    {
        self.target_attractor = undefined;
        return false;
    }
    
    var_15137180d12e4353 = undefined;
    best_attractor_slots = [];
    var_2d9536db6c4052c2 = 1;
    closest_dist_sq = undefined;
    best_attractor_priority = undefined;
    
    foreach ( attractor in var_44dde87daaca7970 )
    {
        if ( attractor.priority < best_attractor_priority )
        {
            break;
        }
        
        if ( isdefined( attractor.var_1466dd1a94ffa11e ) && ![[ attractor.var_1466dd1a94ffa11e ]]( attractor, self ) )
        {
            continue;
        }
        
        if ( !attractor.skipteamcheck && isdefined( attractor.source ) && self.team == attractor.source.team )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_57e52c648ecc4c3c" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_57e52c648ecc4c3c" ) ]]( attractor, self ) )
            {
                continue;
            }
        }
        
        var_b9266667595513af = [];
        var_67b227f26a3f7eb0 = 0;
        
        if ( attractor.var_fc48cc6608c8d82c.size > 0 )
        {
            var_b9266667595513af = [];
            
            foreach ( slot in attractor.var_fc48cc6608c8d82c )
            {
                if ( !isalive( slot.var_80be1da0fa595ce1 ) && gettime() > slot.var_5a25d62d7ccac022 + attractor.slot_cooldown_ms && ( !isdefined( slot.subclass ) || slot.subclass == self.subclass ) )
                {
                    var_b9266667595513af[ var_b9266667595513af.size ] = slot;
                    continue;
                }
                
                if ( slot.var_80be1da0fa595ce1 === self )
                {
                    var_67b227f26a3f7eb0 = 1;
                }
            }
            
            if ( var_b9266667595513af.size <= 0 && !var_67b227f26a3f7eb0 )
            {
                continue;
            }
        }
        
        dist_sq = distancesquared( attractor.source.origin, self.origin );
        
        if ( !isdefined( closest_dist_sq ) || closest_dist_sq > dist_sq )
        {
            var_15137180d12e4353 = attractor.is_nullifier ? undefined : attractor;
            best_attractor_slots = var_b9266667595513af;
            best_attractor_priority = attractor.priority;
            var_2d9536db6c4052c2 = !var_67b227f26a3f7eb0;
            closest_dist_sq = dist_sq;
        }
    }
    
    if ( var_2d9536db6c4052c2 )
    {
        slot = undefined;
        
        if ( best_attractor_slots.size > 0 )
        {
            slot = function_47c86977a18df38b( best_attractor_slots, self.origin );
        }
        
        if ( isdefined( self.target_attractor_slot ) )
        {
            self.target_attractor_slot.var_80be1da0fa595ce1 = undefined;
        }
        
        self.target_attractor_slot = slot;
        
        if ( isdefined( slot ) )
        {
            slot.var_80be1da0fa595ce1 = self;
        }
    }
    
    if ( ( !isdefined( self.target_attractor ) || !( self.target_attractor === var_15137180d12e4353 ) ) && isdefined( var_15137180d12e4353 ) )
    {
        params = { #var_b608d30f5672b7ce:self, #target_attractor:var_15137180d12e4353 };
        callback::callback( "on_ai_acquire_attractor", params );
    }
    else if ( isdefined( self.target_attractor ) && !isdefined( var_15137180d12e4353 ) )
    {
        callback::callback( "on_ai_lose_attractor" );
    }
    
    self.target_attractor = var_15137180d12e4353;
    return true;
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0x94ef92f5, Offset: 0xb93
// Size: 0x62
function function_3803e8d052e47b39( attractor )
{
    if ( isdefined( attractor.var_b29803c8278047e1 ) )
    {
        return [[ attractor.var_b29803c8278047e1 ]]( attractor, self );
    }
    
    if ( isdefined( self.target_attractor_slot ) )
    {
        return self.target_attractor_slot.origin;
    }
    
    return attractor.source.origin;
}

// Namespace zombie_attractor_manager
// Params 0
// Checksum 0xaf24085e, Offset: 0xbfe
// Size: 0x198
function function_f84fb37f6c524103()
{
    assert( isdefined( self.target_attractor ) );
    var_ef5fb942f0eba2b5 = !isdefined( self.var_30203b3e0cbdc098 );
    var_f4586d1566b33464 = !var_ef5fb942f0eba2b5 && self.var_30203b3e0cbdc098.time != gettime();
    var_ec0d29e03734c114 = undefined;
    var_8bf9fb43578b26b0 = 0;
    b_goal_changed = 0;
    
    if ( var_f4586d1566b33464 )
    {
        var_8bf9fb43578b26b0 = self.var_30203b3e0cbdc098.attractor != self.target_attractor;
        
        if ( !var_8bf9fb43578b26b0 )
        {
            var_ec0d29e03734c114 = function_3803e8d052e47b39( self.target_attractor );
            b_goal_changed = self.var_30203b3e0cbdc098.goal != var_ec0d29e03734c114;
        }
    }
    
    if ( var_ef5fb942f0eba2b5 || var_8bf9fb43578b26b0 || b_goal_changed )
    {
        goal = var_ec0d29e03734c114 ?? function_3803e8d052e47b39( self.target_attractor );
        closest_reachable_point = function_9ad7279ee518d022( goal, self );
        
        if ( !isdefined( closest_reachable_point ) && self.target_attractor.var_79eafbbf83b29fe9 )
        {
            closest_reachable_point = self getclosestreachablepointonnavmesh( goal );
        }
        
        if ( isdefined( closest_reachable_point ) )
        {
            var_919522b6ebb37caf = spawnstruct();
            var_919522b6ebb37caf.time = gettime();
            var_919522b6ebb37caf.attractor = self.target_attractor;
            var_919522b6ebb37caf.goal = goal;
            var_919522b6ebb37caf.var_6ce9a7aa61a7a265 = closest_reachable_point;
            self.var_30203b3e0cbdc098 = var_919522b6ebb37caf;
        }
    }
    
    return self.var_30203b3e0cbdc098;
}

// Namespace zombie_attractor_manager
// Params 2
// Checksum 0x54436b57, Offset: 0xd9f
// Size: 0xb5
function set_attractor_slots( var_5f4d19ee2f1cae92, var_1dd0c29c89cb5741 )
{
    assert( isarray( var_1dd0c29c89cb5741 ) );
    assert( isstruct( var_5f4d19ee2f1cae92 ) );
    
    foreach ( slot in var_1dd0c29c89cb5741 )
    {
        slot.var_5a25d62d7ccac022 = 0;
    }
    
    var_5f4d19ee2f1cae92.var_fc48cc6608c8d82c = var_1dd0c29c89cb5741;
}

// Namespace zombie_attractor_manager
// Params 2
// Checksum 0x7db68d26, Offset: 0xe5c
// Size: 0x41
function function_4c34b0f066a9d9fe( var_5f4d19ee2f1cae92, var_a90efd6938bbb83a )
{
    assert( isdefined( var_a90efd6938bbb83a ) );
    assert( var_5f4d19ee2f1cae92.var_927d86585b9a5ff7 );
    var_5f4d19ee2f1cae92.attack_angle_threshold = var_a90efd6938bbb83a;
}

// Namespace zombie_attractor_manager
// Params 2
// Checksum 0xf722c08c, Offset: 0xea5
// Size: 0x39
function set_attractor_cooldown_time( var_5f4d19ee2f1cae92, slot_cooldown_ms )
{
    assert( isdefined( var_5f4d19ee2f1cae92 ) );
    assert( isdefined( slot_cooldown_ms ) );
    var_5f4d19ee2f1cae92.slot_cooldown_ms = slot_cooldown_ms;
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0x401289, Offset: 0xee6
// Size: 0xc8
function function_c9e40c55fa068d00( var_5f4d19ee2f1cae92 )
{
    assert( isdefined( var_5f4d19ee2f1cae92 ) );
    var_a677c6c89d4a4ba1 = [];
    
    if ( isdefined( var_5f4d19ee2f1cae92.var_fc48cc6608c8d82c ) )
    {
        foreach ( slot in var_5f4d19ee2f1cae92.var_fc48cc6608c8d82c )
        {
            if ( isalive( slot.var_80be1da0fa595ce1 ) )
            {
                var_a677c6c89d4a4ba1[ var_a677c6c89d4a4ba1.size ] = slot.var_80be1da0fa595ce1;
            }
        }
    }
    
    return var_a677c6c89d4a4ba1;
}

// Namespace zombie_attractor_manager
// Params 2
// Checksum 0x24b44979, Offset: 0xfb7
// Size: 0x71
function function_e8b05e26d8b2ede( var_5f4d19ee2f1cae92, scriptmodel )
{
    assert( isdefined( scriptmodel ) );
    assert( var_5f4d19ee2f1cae92.var_927d86585b9a5ff7 );
    assert( scriptmodel.classname == "<dev string:x24>" );
    var_5f4d19ee2f1cae92.var_9aaae8ef943ddb6a = scriptmodel;
    assert( isdefined( scriptmodel function_48cbebbf2007bfd1() ), "<dev string:x31>" );
}

// Namespace zombie_attractor_manager
// Params 4
// Checksum 0xdbdeb083, Offset: 0x1030
// Size: 0x64
function function_a2aab3762aaa055f( var_5f4d19ee2f1cae92, box_origin, box_half_size, box_angles )
{
    assert( var_5f4d19ee2f1cae92.var_927d86585b9a5ff7 );
    var_5f4d19ee2f1cae92.var_bff6ba3f2de5971e = box_origin;
    var_5f4d19ee2f1cae92.var_3b9e0fec4458d497 = box_half_size;
    var_5f4d19ee2f1cae92.var_b53796b885d2abb4 = box_angles;
}

// Namespace zombie_attractor_manager
// Params 5
// Checksum 0x887cb638, Offset: 0x109c
// Size: 0x1b5
function function_1497469a46932be2( var_5f4d19ee2f1cae92, origin, angles, radius, var_50d7d36595e1100c )
{
    if ( !isdefined( origin ) )
    {
        assertmsg( "<dev string:x78>" );
        return;
    }
    
    level endon( #"game_ended" );
    slots = [];
    
    for ( var_c2ad6de33364b53e = 0; var_c2ad6de33364b53e < var_50d7d36595e1100c ; var_c2ad6de33364b53e++ )
    {
        var_f78c75e467fb301 = math::remap( var_c2ad6de33364b53e, 0, var_50d7d36595e1100c, 0, 360 );
        x = radius * cos( var_f78c75e467fb301 + ( angles[ 1 ] ?? 0 ) );
        y = radius * sin( var_f78c75e467fb301 + ( angles[ 1 ] ?? 0 ) );
        pos = ( x, y, 0 ) + origin;
        capsule_height = 60;
        capsule_radius = 15;
        
        if ( isent( var_5f4d19ee2f1cae92.source ) && !var_5f4d19ee2f1cae92.source aiphysicstracepassed( origin + ( 0, 0, 5 ), pos + ( 0, 0, 5 ), capsule_radius, capsule_height, 1 ) )
        {
            if ( var_c2ad6de33364b53e % 2 == 1 )
            {
                waitframe();
            }
            
            continue;
        }
        
        end_pos = physicstrace( pos + ( 0, 0, 10 ), pos - ( 0, 0, 10 ) );
        var_75319c5420c61a27 = getclosestpointonnavmesh( end_pos );
        slot = spawnstruct();
        slot.origin = var_75319c5420c61a27;
        slots[ slots.size ] = slot;
    }
    
    set_attractor_slots( var_5f4d19ee2f1cae92, slots );
}

// Namespace zombie_attractor_manager
// Params 8, eflags: 0x4
// Checksum 0xba9e1a36, Offset: 0x1259
// Size: 0x12f
function private _add_attractor_internal( var_5f4d19ee2f1cae92, priority, range, var_927d86585b9a5ff7, var_b29803c8278047e1, is_nullifier, var_79eafbbf83b29fe9, var_e359b706d5b60ecf )
{
    var_5f4d19ee2f1cae92.priority = priority ?? 0;
    var_5f4d19ee2f1cae92.range = range ?? -1;
    var_5f4d19ee2f1cae92.var_927d86585b9a5ff7 = var_927d86585b9a5ff7 ?? 0;
    var_5f4d19ee2f1cae92.is_nullifier = is_nullifier ?? 0;
    var_5f4d19ee2f1cae92.var_79eafbbf83b29fe9 = var_79eafbbf83b29fe9 ?? 0;
    var_5f4d19ee2f1cae92.var_b29803c8278047e1 = var_b29803c8278047e1;
    var_5f4d19ee2f1cae92.var_e359b706d5b60ecf = var_e359b706d5b60ecf;
    var_5f4d19ee2f1cae92.var_fc48cc6608c8d82c = [];
    var_5f4d19ee2f1cae92.slot_cooldown_ms = 0;
    
    if ( var_927d86585b9a5ff7 )
    {
        function_4c34b0f066a9d9fe( var_5f4d19ee2f1cae92, 45 );
    }
    
    if ( !isdefined( self.active_attractors ) )
    {
        self.active_attractors = [];
    }
    
    if ( !isdefined( self.active_attractors ) )
    {
        self.active_attractors = [];
    }
    
    self.active_attractors[ self.active_attractors.size ] = var_5f4d19ee2f1cae92;
}

// Namespace zombie_attractor_manager
// Params 1, eflags: 0x4
// Checksum 0x51f742c1, Offset: 0x1390
// Size: 0xe3, Type: bool
function private _remove_attractor_internal( var_c6969b9fb8f1cf23 )
{
    var_342a383ef45d092b = 0;
    new_attractor_array = [];
    
    if ( !isdefined( self.active_attractors ) )
    {
        return false;
    }
    
    foreach ( attractor in self.active_attractors )
    {
        if ( attractor == var_c6969b9fb8f1cf23 )
        {
            var_342a383ef45d092b = 1;
            continue;
        }
        
        if ( attractor.source == var_c6969b9fb8f1cf23 )
        {
            var_342a383ef45d092b = 1;
            continue;
        }
        
        new_attractor_array[ new_attractor_array.size ] = attractor;
    }
    
    if ( var_342a383ef45d092b )
    {
        self.active_attractors = new_attractor_array;
        return true;
    }
    
    return false;
}

// Namespace zombie_attractor_manager
// Params 0, eflags: 0x4
// Checksum 0x31a47e6, Offset: 0x147c
// Size: 0x379
function private function_1760643af2232fc2()
{
    level endon( #"game_ended" );
    var_749eefed89a6c447 = 3;
    
    for ( var_dd77a4915a40fde6 = 0; true ; var_dd77a4915a40fde6 = 0 )
    {
        var_255232a5c5895cf6 = getaispeciesarray( "all", "zombie" );
        
        if ( isdefined( var_255232a5c5895cf6 ) )
        {
            foreach ( ai in var_255232a5c5895cf6 )
            {
                if ( isalive( ai ) )
                {
                    found_potential_attractors = ai calculate_target_attractor();
                    
                    if ( isalive( ai ) )
                    {
                        if ( isdefined( ai.target_attractor ) )
                        {
                            var_ff2b7fc48d289912 = ai function_f84fb37f6c524103();
                            
                            if ( isalive( ai ) )
                            {
                                if ( !ai._blackboard.var_79b2d8d61c6ef8b1 )
                                {
                                    ai._blackboard.var_79b2d8d61c6ef8b1 = 1;
                                    ai function_b1fcfc3cc2092665( 1 );
                                }
                                
                                ai._blackboard.var_b010d8a858880160 = isdefined( var_ff2b7fc48d289912 ) ? var_ff2b7fc48d289912.var_6ce9a7aa61a7a265 : ai.origin;
                                
                                if ( ai.target_attractor.var_927d86585b9a5ff7 )
                                {
                                    ai._blackboard.var_13e853497403856c = 1;
                                    
                                    if ( ai.target_attractor.var_e359b706d5b60ecf )
                                    {
                                        ai._blackboard.var_aead9ff2aa3beb9f = [[ ai.target_attractor.var_e359b706d5b60ecf ]]( ai.target_attractor, ai );
                                    }
                                    else
                                    {
                                        ai._blackboard.var_aead9ff2aa3beb9f = ai.target_attractor.source.origin;
                                    }
                                    
                                    if ( isdefined( ai.target_attractor.attack_angle_threshold ) )
                                    {
                                        ai._blackboard.var_4e1319950e5ff032 = ai.target_attractor.attack_angle_threshold;
                                    }
                                    
                                    var_759fafd7f19f0f38 = get_attractor_obb( ai.target_attractor );
                                    
                                    if ( isdefined( var_759fafd7f19f0f38 ) )
                                    {
                                        attractor_half_height = var_759fafd7f19f0f38.origin[ 2 ] - ai.target_attractor.source.origin[ 2 ];
                                        ai._blackboard.var_559361239b8febff = attractor_half_height;
                                    }
                                    else
                                    {
                                        ai._blackboard.var_559361239b8febff = 0;
                                    }
                                }
                                else
                                {
                                    ai._blackboard.var_13e853497403856c = 0;
                                }
                            }
                        }
                        else if ( ai._blackboard.var_79b2d8d61c6ef8b1 )
                        {
                            ai._blackboard.var_79b2d8d61c6ef8b1 = 0;
                            ai function_b1fcfc3cc2092665( 0 );
                        }
                    }
                }
                
                if ( found_potential_attractors )
                {
                    var_dd77a4915a40fde6 += 1;
                }
                else
                {
                    var_dd77a4915a40fde6 += 0.1;
                }
                
                if ( var_dd77a4915a40fde6 > var_749eefed89a6c447 )
                {
                    var_dd77a4915a40fde6 = 0;
                    waitframe();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_attractor_manager
// Params 0, eflags: 0x4
// Checksum 0xee625cd, Offset: 0x17fd
// Size: 0x101
function private function_65e71f6a299ba6c9()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level cleanup_attractor_array();
        var_c57ab981cf13fdf8 = [];
        var_342a383ef45d092b = 0;
        
        foreach ( ent in level.var_f1c750caecfbc463 )
        {
            if ( !isalive( ent ) )
            {
                var_342a383ef45d092b = 1;
                continue;
            }
            
            if ( ent cleanup_attractor_array() )
            {
                if ( !isdefined( ent.active_attractors ) || ent.active_attractors.size <= 0 )
                {
                    var_342a383ef45d092b = 1;
                    continue;
                }
            }
            
            var_c57ab981cf13fdf8[ var_c57ab981cf13fdf8.size ] = ent;
        }
        
        if ( var_342a383ef45d092b )
        {
            level.var_f1c750caecfbc463 = var_c57ab981cf13fdf8;
        }
        
        waitframe();
    }
}

// Namespace zombie_attractor_manager
// Params 0, eflags: 0x4
// Checksum 0xf25750ec, Offset: 0x1906
// Size: 0x1a7
function private cleanup_attractor_array()
{
    var_342a383ef45d092b = 0;
    new_attractor_array = [];
    
    if ( !isdefined( self.active_attractors ) )
    {
        self.active_attractors = [];
    }
    
    foreach ( attractor in self.active_attractors )
    {
        if ( !( isdefined( attractor ) && isdefined( attractor.source ) && isdefined( attractor.source.origin ) ) )
        {
            var_342a383ef45d092b = 1;
            continue;
        }
        
        foreach ( slot in attractor.var_fc48cc6608c8d82c )
        {
            if ( isdefined( slot.var_80be1da0fa595ce1 ) && !isalive( slot.var_80be1da0fa595ce1 ) )
            {
                slot.var_80be1da0fa595ce1 = undefined;
                slot.var_5a25d62d7ccac022 = gettime();
            }
        }
        
        new_attractor_array[ new_attractor_array.size ] = attractor;
    }
    
    if ( var_342a383ef45d092b )
    {
        self.active_attractors = new_attractor_array.size <= 0 ? undefined : new_attractor_array;
    }
    
    return var_342a383ef45d092b;
}

// Namespace zombie_attractor_manager
// Params 1, eflags: 0x4
// Checksum 0xa2605182, Offset: 0x1ab6
// Size: 0x1ae
function private on_damage_point( params )
{
    if ( !isdefined( self.target_attractor ) )
    {
        return;
    }
    
    var_6271e36734e22cd3 = get_attractor_obb( self.target_attractor );
    
    if ( !isdefined( var_6271e36734e22cd3 ) )
    {
        return;
    }
    
    var_a4ec8f192ced84e2 = math::function_1243a6cc6a030f2a( params.origin, var_6271e36734e22cd3.origin, var_6271e36734e22cd3.half_size, var_6271e36734e22cd3.angles );
    var_4193955b25309ca2 = 32 + ( params.radius ?? 0 );
    
    if ( distancesquared( var_a4ec8f192ced84e2, params.origin ) < squared( var_4193955b25309ca2 ) )
    {
        var_260fbe0dd010a00 = self.target_attractor.var_9aaae8ef943ddb6a ?? self.target_attractor.source;
        
        if ( !isdefined( var_260fbe0dd010a00 ) )
        {
            return;
        }
        
        var_260fbe0dd010a00 notify( #"hit_from_attracted_zombie", params );
        
        if ( var_260fbe0dd010a00 vehicle::is_vehicle() )
        {
            ref = var_260fbe0dd010a00 vehicle::get_ref();
            data = vehicle::get_data( ref );
            
            if ( !data.damage.var_64c36f110db1c196 )
            {
                return;
            }
        }
        
        if ( isent( var_260fbe0dd010a00 ) )
        {
            var_260fbe0dd010a00 dodamage( params.damage, params.origin, self, self, params.meansofdeath );
            return;
        }
        
        if ( var_260fbe0dd010a00 isscriptableinstance() )
        {
            var_260fbe0dd010a00 scriptabledodamage( params.damage, self, self, params.origin, undefined, params.meansofdeath );
        }
    }
}

// Namespace zombie_attractor_manager
// Params 11, eflags: 0x4
// Checksum 0x9fb5821c, Offset: 0x1c6c
// Size: 0x13e
function private on_scriptable_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    assert( isdefined( instance ), "<dev string:xad>" );
    
    if ( !isdefined( instance ) || !instance.attractor )
    {
        return;
    }
    
    if ( !isai( eattacker ) && instance.attractor )
    {
        return;
    }
    
    dmg_struct = { #partname:partname, #modelindex:modelindex, #vpoint:vpoint, #vdir:vdir, #objweapon:objweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #instance:instance, #eattacker:eattacker, #einflictor:einflictor };
    instance callback::callback( "on_attractor_damaged", dmg_struct );
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0xea2efdbd, Offset: 0x1db2
// Size: 0x1b0
function get_attractor_obb( var_5f4d19ee2f1cae92 )
{
    if ( isdefined( var_5f4d19ee2f1cae92.var_bff6ba3f2de5971e ) && isdefined( var_5f4d19ee2f1cae92.var_3b9e0fec4458d497 ) && isdefined( var_5f4d19ee2f1cae92.var_b53796b885d2abb4 ) )
    {
        var_6271e36734e22cd3 = spawnstruct();
        var_6271e36734e22cd3.origin = var_5f4d19ee2f1cae92.var_bff6ba3f2de5971e;
        var_6271e36734e22cd3.half_size = var_5f4d19ee2f1cae92.var_3b9e0fec4458d497;
        var_6271e36734e22cd3.angles = var_5f4d19ee2f1cae92.var_b53796b885d2abb4;
        return var_6271e36734e22cd3;
    }
    
    var_260fbe0dd010a00 = var_5f4d19ee2f1cae92.var_9aaae8ef943ddb6a ?? var_5f4d19ee2f1cae92.source;
    
    if ( !isent( var_260fbe0dd010a00 ) )
    {
        return;
    }
    
    if ( isplayer( var_260fbe0dd010a00 ) )
    {
        return;
    }
    
    if ( var_260fbe0dd010a00.classname != "script_model" && var_260fbe0dd010a00.classname != "script_brushmodel" && var_260fbe0dd010a00.classname != "script_vehicle" && var_260fbe0dd010a00.classname != "scriptable" )
    {
        return;
    }
    
    aabb = var_260fbe0dd010a00 function_48cbebbf2007bfd1();
    
    if ( !isdefined( aabb ) )
    {
        return;
    }
    
    mid_point = vectorlerp( aabb[ "min" ], aabb[ "max" ], 0.5 );
    bounds = ( aabb[ "max" ] - aabb[ "min" ] ) * 0.5;
    var_6271e36734e22cd3 = spawnstruct();
    var_6271e36734e22cd3.origin = mid_point;
    var_6271e36734e22cd3.half_size = bounds;
    var_6271e36734e22cd3.angles = var_260fbe0dd010a00.angles;
    return var_6271e36734e22cd3;
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0xf6db2909, Offset: 0x1f6b
// Size: 0x58
function function_e3743c2577dbec4a( params )
{
    log_array = function_c9d17cad763ffcf1();
    iprintlnbold( "Printing Attractor Debug to Logs (" + log_array.size + " lines)" );
    line_i = 0;
    
    while ( line_i < log_array.size )
    {
        logstring( log_array[ line_i ] );
        line_i += 1;
    }
}

// Namespace zombie_attractor_manager
// Params 0
// Checksum 0x6fc27527, Offset: 0x1fcb
// Size: 0x220
function function_c9d17cad763ffcf1()
{
    str_array = [];
    str_array[ str_array.size ] = "Debugging AI with Local Attractors - Num of AI: " + level.var_f1c750caecfbc463.size;
    
    foreach ( ent in level.var_f1c750caecfbc463 )
    {
        str_array = arraycombine( str_array, function_f3e2263f329cde34( ent ) );
    }
    
    all_ai = getaiarray();
    var_e984c5ba27e3e371 = [];
    
    foreach ( ai in all_ai )
    {
        if ( !arraycontains( level.var_f1c750caecfbc463, ai ) )
        {
            var_e984c5ba27e3e371[ var_e984c5ba27e3e371.size ] = ai;
        }
    }
    
    str_array[ str_array.size ] = "Debugging AI without Local Attractors - Num of AI: " + var_e984c5ba27e3e371.size;
    
    foreach ( ent in var_e984c5ba27e3e371 )
    {
        str_array = arraycombine( str_array, function_f3e2263f329cde34( ent ) );
    }
    
    str_array[ str_array.size ] = "Debugging All Global Attractors - Total Global Attractors: " + level.active_attractors.size;
    attractor_i = 0;
    
    while ( attractor_i < level.active_attractors.size )
    {
        str_array = arraycombine( str_array, function_cad31afe3bcef28a( level.active_attractors[ attractor_i ], "[Global Attractor #" + attractor_i + "]" ) );
        attractor_i += 1;
    }
    
    return str_array;
}

// Namespace zombie_attractor_manager
// Params 1
// Checksum 0x1bbae2bf, Offset: 0x21f4
// Size: 0x100
function function_f3e2263f329cde34( ai )
{
    str_array = [];
    str_array[ str_array.size ] = "AI EntNum(" + ai getentitynumber() + ") - Attractor Exists: " + ( ai.target_attractor ? "YES" : "NO" ) + " - Enemy Exists: " + ( ai.enemy ? "YES" : "NO" ) + " - Subclass: " + ai.subclass;
    
    if ( ai.target_attractor )
    {
        str_array = arraycombine( str_array, function_cad31afe3bcef28a( ai.target_attractor, "\t[Target Attractor] " ) );
    }
    
    attractor_i = 0;
    
    while ( attractor_i < ai.active_attractors.size )
    {
        str_array = arraycombine( str_array, function_cad31afe3bcef28a( ai.active_attractors[ attractor_i ], "\t[Active Attractor #" + attractor_i + "] " ) );
        attractor_i += 1;
    }
    
    return str_array;
}

// Namespace zombie_attractor_manager
// Params 2, eflags: 0x4
// Checksum 0x3dfa10ee, Offset: 0x22fd
// Size: 0x12f
function private function_cad31afe3bcef28a( var_5f4d19ee2f1cae92, str_prefix )
{
    str_array = [];
    str_array[ str_array.size ] = str_prefix + "Source Type: " + ( isstruct( var_5f4d19ee2f1cae92.source ) ? "STRUCT" : "ENT" ) + " - Origin: " + var_5f4d19ee2f1cae92.source.origin + " - Angles: " + var_5f4d19ee2f1cae92.source.angles;
    str_array[ str_array.size ] = str_prefix + "Range: " + var_5f4d19ee2f1cae92.range + " - Priority: " + var_5f4d19ee2f1cae92.priority + " - Is Attackable: " + var_5f4d19ee2f1cae92.attackable + " - Num Slots: " + var_5f4d19ee2f1cae92.var_fc48cc6608c8d82c.size;
    
    if ( isent( var_5f4d19ee2f1cae92.source ) )
    {
        str_array[ str_array.size ] = str_prefix + "Source Ent Num: " + var_5f4d19ee2f1cae92.source getentitynumber() + " - Source Ent Classname: " + ( var_5f4d19ee2f1cae92.source.classname ?? "unknown" );
    }
    
    return str_array;
}

/#

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x7bea7646, Offset: 0x2435
    // Size: 0xd0, Type: dev
    function private function_4069f770eb8785e7()
    {
        devgui::function_9082edeb5db93280( "<dev string:xe4>" );
        devgui::add_devgui_func( "<dev string:xf6>", "<dev string:x115>", &function_1855c9bd82861914 );
        devgui::add_devgui_func( "<dev string:x134>", "<dev string:x150>", &function_a811e7a72410a9a9 );
        devgui::add_devgui_func( "<dev string:x163>", "<dev string:x18b>", &function_e99d2acecf8efa90 );
        devgui::add_devgui_func( "<dev string:x1a9>", "<dev string:x1cd>", &function_ab9c07e1fb6e9470 );
        devgui::add_devgui_func( "<dev string:x1ef>", "<dev string:x216>", &function_946ebddec9848893 );
        devgui::add_devgui_func( "<dev string:x23b>", "<dev string:x260>", &function_72bdb79a463bf5f8 );
        devgui::add_devgui_func( "<dev string:x280>", "<dev string:x29c>", &function_fb307fecfaf4f3cb );
        devgui::add_devgui_func( "<dev string:x2b8>", "<dev string:x2d6>", &function_e3743c2577dbec4a );
        devgui::function_77df7fe7dd273e10();
        level thread debug_draw_attractors();
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x9cc58dad, Offset: 0x250d
    // Size: 0x6d, Type: dev
    function private function_a811e7a72410a9a9()
    {
        pos = devgui::function_97024c0a6d1256a6();
        struct = spawnstruct();
        struct.origin = pos;
        
        if ( !isdefined( level.var_1e3aede20f4f2ca ) )
        {
            level.var_1e3aede20f4f2ca = [];
        }
        
        level.var_1e3aede20f4f2ca[ level.var_1e3aede20f4f2ca.size ] = struct;
        add_attractor( struct, undefined, 500 );
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x39af457f, Offset: 0x2582
    // Size: 0x4c, Type: dev
    function private function_e99d2acecf8efa90()
    {
        if ( isdefined( level.var_1e3aede20f4f2ca ) )
        {
            sorted = utility::get_array_of_closest( level.players[ 0 ].origin, level.var_1e3aede20f4f2ca );
            remove_attractor( sorted[ 0 ] );
        }
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0xa5b7e3ea, Offset: 0x25d6
    // Size: 0xaf, Type: dev
    function private function_ab9c07e1fb6e9470()
    {
        pos = devgui::function_97024c0a6d1256a6();
        zombies = getaispeciesarray( "<dev string:x2ec>", "<dev string:x2f1>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        struct = spawnstruct();
        struct.origin = pos;
        
        if ( !isdefined( level.test_attractors_closest_zombie ) )
        {
            level.test_attractors_closest_zombie = [];
        }
        
        level.test_attractors_closest_zombie[ level.test_attractors_closest_zombie.size ] = struct;
        var_88f817d755d2b49c function_7eb1aaa8bc7cc15( struct, undefined, 400 );
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0xa4d5660c, Offset: 0x268d
    // Size: 0xd6, Type: dev
    function private function_946ebddec9848893()
    {
        zombies = getaispeciesarray( "<dev string:x2ec>", "<dev string:x2f1>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        if ( !isdefined( level.test_attractors_closest_zombie ) )
        {
            level.test_attractors_closest_zombie = [];
        }
        
        foreach ( struct in level.test_attractors_closest_zombie )
        {
            var_88f817d755d2b49c function_dcfb4c31f1d97cd2( struct );
        }
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x3e807b80, Offset: 0x276b
    // Size: 0x6a, Type: dev
    function private function_72bdb79a463bf5f8()
    {
        if ( !isdefined( level.var_edc1d0d87f8b0df5 ) )
        {
            level.var_edc1d0d87f8b0df5 = 0;
        }
        
        if ( !level.var_edc1d0d87f8b0df5 )
        {
            level.var_edc1d0d87f8b0df5 = 1;
            add_attractor( level.players[ 0 ], undefined, 500, 1 );
            return;
        }
        
        level.var_edc1d0d87f8b0df5 = 0;
        remove_attractor( level.players[ 0 ] );
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x2d101076, Offset: 0x27dd
    // Size: 0xb8, Type: dev
    function private function_fb307fecfaf4f3cb()
    {
        pos = devgui::function_97024c0a6d1256a6();
        pos -= ( 0, 0, 4 );
        table = spawn( "<dev string:x24>", pos );
        table setmodel( "<dev string:x2f5>" );
        table.health = 100;
        table disconnectpaths();
        table setcandamage( 1 );
        attractor = add_attractor( table, 10, 400, 1 );
        function_1497469a46932be2( attractor, attractor.source.origin, attractor.source.angles, 50, 5 );
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x8e389d78, Offset: 0x289d
    // Size: 0x2b, Type: dev
    function private function_1855c9bd82861914()
    {
        setdvar( @"debug_attractors", getdvarint( @"debug_attractors" ) > 0 ? 0 : 1 );
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0x48630f0a, Offset: 0x28d0
    // Size: 0xc9, Type: dev
    function private debug_draw_attractors()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( level.active_attractors ) )
            {
                continue;
            }
            
            if ( getdvarint( @"debug_attractors", 0 ) <= 0 )
            {
                continue;
            }
            
            level function_d1fd914110a1357c();
            ai_array = getaiarray();
            
            foreach ( ai in ai_array )
            {
                ai function_d1fd914110a1357c();
            }
        }
    }

    // Namespace zombie_attractor_manager
    // Params 0, eflags: 0x4
    // Checksum 0xddc8c5c1, Offset: 0x29a1
    // Size: 0xb6, Type: dev
    function private function_d1fd914110a1357c()
    {
        if ( !isdefined( self.active_attractors ) || self.active_attractors.size <= 0 )
        {
            return;
        }
        
        foreach ( attractor in self.active_attractors )
        {
            if ( !( isdefined( attractor ) && isdefined( attractor.source ) ) )
            {
                continue;
            }
            
            function_d84b9fe9d6db67be( attractor );
        }
    }

    // Namespace zombie_attractor_manager
    // Params 1, eflags: 0x4
    // Checksum 0x36d7488, Offset: 0x2a5f
    // Size: 0x2e8, Type: dev
    function private function_d84b9fe9d6db67be( attractor )
    {
        color = self == level ? ( 1, 0, 0 ) : ( 0, 0, 1 );
        utility::draw_circle( attractor.source.origin, 15, ( 1, 0, 0 ), 1, 1, 1 );
        var_4f2ce1ec7742176f = attractor.range > 0 ? "<dev string:x305>" + attractor.range : "<dev string:x310>";
        var_260fbe0dd010a00 = attractor.var_9aaae8ef943ddb6a ?? attractor.source;
        var_f8074ae8ca9be25a = isdefined( var_260fbe0dd010a00.health ) ? "<dev string:x311>" + string( var_260fbe0dd010a00.health ?? 0 ) : "<dev string:x310>";
        print3d( attractor.source.origin + ( 0, 0, 32 ), "<dev string:x31a>" + string( attractor.priority ) + var_4f2ce1ec7742176f, color );
        
        if ( attractor.var_927d86585b9a5ff7 )
        {
            print3d( attractor.source.origin + ( 0, 0, 24 ), "<dev string:x329>" + var_f8074ae8ca9be25a, color );
            function_b2e2cd02cda76ae5( attractor );
        }
        
        sphere( attractor.source.origin, 15, color );
        
        if ( attractor.range > 0 )
        {
            utility::draw_circle( attractor.source.origin, attractor.range, color );
        }
        
        foreach ( slot in attractor.var_fc48cc6608c8d82c )
        {
            b_is_open = !isalive( slot.var_80be1da0fa595ce1 );
            b_is_on_cooldown = gettime() < slot.var_5a25d62d7ccac022 + attractor.slot_cooldown_ms;
            var_6ffcdf3e392d33be = b_is_open ? b_is_on_cooldown ? ( 1, 0.5, 0.5 ) : ( 0, 1, 0 ) : ( 1, 0, 0 );
            utility::draw_circle( slot.origin, 5, var_6ffcdf3e392d33be );
        }
    }

    // Namespace zombie_attractor_manager
    // Params 1, eflags: 0x4
    // Checksum 0x1cb609cf, Offset: 0x2d4f
    // Size: 0x20b, Type: dev
    function private function_b2e2cd02cda76ae5( attractor )
    {
        var_6271e36734e22cd3 = get_attractor_obb( attractor );
        
        if ( !isdefined( var_6271e36734e22cd3 ) )
        {
            return;
        }
        
        var_b997226e65e9c8a1[ 0 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size;
        var_b997226e65e9c8a1[ 1 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( 1, 1, -1 );
        var_b997226e65e9c8a1[ 2 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( -1, 1, -1 );
        var_b997226e65e9c8a1[ 3 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( -1, 1, 1 );
        var_b9971f6e65e9c208[ 0 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( 1, -1, 1 );
        var_b9971f6e65e9c208[ 1 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( 1, -1, -1 );
        var_b9971f6e65e9c208[ 2 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( -1, -1, -1 );
        var_b9971f6e65e9c208[ 3 ] = var_6271e36734e22cd3.origin + var_6271e36734e22cd3.half_size * ( -1, -1, 1 );
        
        for ( i = 0; i < 4 ; i++ )
        {
            j = i + 1;
            
            if ( j == 4 )
            {
                j = 0;
            }
            
            line( var_b997226e65e9c8a1[ i ], var_b997226e65e9c8a1[ j ], ( 1, 0, 0 ), 1, 0, 1 );
            line( var_b9971f6e65e9c208[ i ], var_b9971f6e65e9c208[ j ], ( 1, 0, 0 ), 1, 0, 1 );
            line( var_b997226e65e9c8a1[ i ], var_b9971f6e65e9c208[ i ], ( 1, 0, 0 ), 1, 0, 1 );
        }
    }

#/
