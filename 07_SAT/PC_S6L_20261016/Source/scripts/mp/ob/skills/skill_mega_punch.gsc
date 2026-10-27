// scripts\mp\ob\skills\skill_mega_punch.gsc  (hash_4cad0f0723b60b08.gscc) (size: 6125 Bytes / 0x17ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b3e7915 (1262385429)
// size ...... 6125 (0x17ed)
// includes .. 10  (offset: 0x1685)
// strings ... 19  (offset: 0x16d5)
// dev strs .. 2   (offset: 0x17d5)
// exports ... 17  (offset: 0xd7d)
// cseg ...... 0x149 + 0xc34 (0xd7d)
// imports ... 56  (offset: 0x1025)
// animtree1 . 0   (offset: 0x17ed)
// animtree2 . 0   (offset: 0x17ed)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\perks\zombie\perk_m_mod;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\player_utility;

#namespace skill_mega_punch;

// Namespace skill_mega_punch
// Params 0, eflags: 0x1
// Checksum 0x88eddc2f, Offset: 0x167
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"mega_punch", &init );
}

// Namespace skill_mega_punch
// Params 0
// Checksum 0xa66cca86, Offset: 0x186
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"mega_punch", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"mega_punch", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"mega_punch", #"hash_8698c290a2e85469", &get_skill_weapons );
}

// Namespace skill_mega_punch
// Params 1, eflags: 0x4
// Checksum 0xc47332be, Offset: 0x1ea
// Size: 0x9d, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_9fa2409f11a0f0cb, "<dev string:x24>" );
    assert( skill_bundle.var_24c5bd431eaaf148, "<dev string:x5b>" );
    self.m_mod_overrides = { #damage:0 };
    self.var_299701e09a308567 = { #var_11512ba6c31d1994:0, #bundle:skill_bundle };
    self.var_17f492ff119958ff = skill_bundle.var_b00f85cb2d97c6bc;
    perk_m_mod::function_a83a14617a6b9969();
    callback::add( "on_m_mod_punch", &on_mega_punch );
    return true;
}

// Namespace skill_mega_punch
// Params 1, eflags: 0x4
// Checksum 0x20297439, Offset: 0x290
// Size: 0x38
function private function_c51f1692ecb73bfe( skill_bundle )
{
    perk_m_mod::function_40be123087ac0173();
    self.var_299701e09a308567 = undefined;
    self.m_mod_overrides = undefined;
    callback::remove( "on_m_mod_punch", &on_mega_punch );
}

// Namespace skill_mega_punch
// Params 1, eflags: 0x4
// Checksum 0xc5430a41, Offset: 0x2d0
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_a7360baff4b71338 ];
}

// Namespace skill_mega_punch
// Params 1, eflags: 0x4
// Checksum 0x2477b3f2, Offset: 0x2f5
// Size: 0xb0
function private on_mega_punch( sparams )
{
    utility::waittill_any_timeout( 2, "offhand_pullback" );
    var_da55798eb12048a0 = self.var_299701e09a308567;
    bundle = var_da55798eb12048a0.bundle;
    [ trace_start, trace_end ] = get_trace_positions( bundle );
    [ hit_entities, hit_scriptables ] = calculate_hits( trace_start, trace_end, bundle );
    process_hits( hit_entities, hit_scriptables, trace_end, var_da55798eb12048a0, bundle );
}

// Namespace skill_mega_punch
// Params 1, eflags: 0x4
// Checksum 0xe550d2a5, Offset: 0x3ad
// Size: 0x63
function private get_trace_positions( bundle )
{
    eye_pos = self geteye();
    forward = anglestoforward( self getplayerangles() );
    trace_start = eye_pos;
    trace_end = eye_pos + forward * bundle.var_2085bf5d166afeea;
    return [ trace_start, trace_end ];
}

// Namespace skill_mega_punch
// Params 3, eflags: 0x4
// Checksum 0x5cc02809, Offset: 0x419
// Size: 0x146
function private calculate_hits( trace_position_start, trace_position_end, bundle )
{
    hit_entities = [];
    hit_scriptables = [];
    trace = trace::sphere_trace_get_all_results( trace_position_start, trace_position_end, bundle.var_2085bf5d166afeea, self, undefined, undefined, 1 );
    
    foreach ( trace_result in trace )
    {
        if ( isent( trace_result[ "entity" ] ) )
        {
            if ( player_utility::playersareenemies( self, trace_result[ "entity" ] ) )
            {
                hit_entities[ hit_entities.size ] = trace_result[ "entity" ];
            }
        }
        
        if ( trace_result[ "scriptable" ] )
        {
            hit_scriptables[ hit_scriptables.size ] = trace_result[ "scriptable" ];
        }
    }
    
    /#
        if ( getdvarint( @"hash_e4dcbca03b2f8a9b", 0 ) )
        {
            sphere( trace_position_end, bundle.var_2085bf5d166afeea, ( 1, 0, 0 ), 0, 60 );
        }
    #/
    
    return [ hit_entities, hit_scriptables ];
}

// Namespace skill_mega_punch
// Params 5, eflags: 0x4
// Checksum 0xcd29c21d, Offset: 0x568
// Size: 0x50
function private process_hits( hit_entities, hit_scriptables, trace_end, var_da55798eb12048a0, bundle )
{
    function_2884ebebaac233ec( hit_scriptables );
    function_9601a68e66866895( trace_end, bundle );
    function_e4db458d211c25b7( hit_entities, trace_end, var_da55798eb12048a0, bundle );
}

// Namespace skill_mega_punch
// Params 1, eflags: 0x4
// Checksum 0xd067fbdc, Offset: 0x5c0
// Size: 0xd1
function private function_2884ebebaac233ec( hit_scriptables )
{
    foreach ( scriptable in hit_scriptables )
    {
        if ( scriptable && ( scriptable scriptableisdoor() || scriptable scriptabledoorisdouble() ) )
        {
            door_state = scriptable getscriptablepartstate( "door", 1 );
            
            if ( door_state != "frozen" && door_state != "locked" )
            {
                scriptable scriptabledoorbashopen( "away", self.origin );
            }
        }
    }
}

// Namespace skill_mega_punch
// Params 2, eflags: 0x4
// Checksum 0x4e987c24, Offset: 0x699
// Size: 0x42
function private function_9601a68e66866895( position, bundle )
{
    self radiusdamage( position, bundle.var_2085bf5d166afeea, bundle.var_c76aa95017250360, 1, self, "MOD_MELEE", "<explicitweaponnone>", 1 );
}

// Namespace skill_mega_punch
// Params 4, eflags: 0x4
// Checksum 0x661a1ddb, Offset: 0x6e3
// Size: 0x1a6
function private function_e4db458d211c25b7( hit_entities, trace_end, var_da55798eb12048a0, bundle )
{
    foreach ( entity in hit_entities )
    {
        if ( !isent( entity ) )
        {
            continue;
        }
        
        entity_eye_position = issentient( entity ) ? entity geteye() : entity.origin;
        var_617f2876f4b4344e = [ self, entity ];
        trace = trace::ray_trace( self geteye(), entity_eye_position, var_617f2876f4b4344e, undefined, 0, 0, 0, undefined, self.team );
        
        if ( trace[ "hittype" ] == "hittype_none" || entity == trace[ "entity" ].dawg )
        {
            if ( entity vehicle::is_vehicle() )
            {
                if ( bundle.var_512f17a57e9fe6d3 && !entity.var_8839162ef17bfbc1 && entity vehicle_isphysveh() && !entity hascomponent( "c2p" ) )
                {
                    entity vehphys_impulse( vectornormalize2( entity.origin - trace_end ), bundle.var_512f17a57e9fe6d3 );
                }
                
                continue;
            }
            
            if ( isagent( entity ) )
            {
                function_4e11260013517a0f( entity, var_da55798eb12048a0, bundle );
            }
        }
    }
}

// Namespace skill_mega_punch
// Params 3, eflags: 0x4
// Checksum 0x4ac7b284, Offset: 0x891
// Size: 0x182
function private function_4e11260013517a0f( entity, var_da55798eb12048a0, bundle )
{
    damage = entity function_af1feabe896eff01() ? bundle.var_9fa2409f11a0f0cb : bundle.var_24c5bd431eaaf148;
    var_5beaff634c597287 = anglestoforward( self getplayerangles() ) * 10 + self geteye();
    function_d8e12762ffc127fd( entity, var_5beaff634c597287, 1, 0, var_da55798eb12048a0, bundle );
    aicategory = entity.aicategory;
    powertier = entity.powertier;
    dopush = !isdefined( entity.var_ea900b480a55e803 );
    hit_loc = "torso_upper";
    
    if ( entity.bhasriotshieldattached )
    {
        var_cb9750b87adf8ac7 = entity damage_utility::function_96098e54715671d3( anglestoforward( self.angles ), entity.angles, bundle.var_1ef7bf3eee89911a );
        
        if ( !var_cb9750b87adf8ac7 )
        {
            hit_loc = "shield";
        }
    }
    
    entity dodamage( damage, var_5beaff634c597287, self, self, "MOD_MELEE", bundle.var_a7360baff4b71338, hit_loc );
    
    if ( entity.health <= 0 )
    {
        if ( dopush )
        {
            function_c0a18c4ac5c03a46( entity, bundle );
        }
        
        entity.aicategory = aicategory;
        entity.powertier = powertier;
        function_d8e12762ffc127fd( entity, var_5beaff634c597287, 0, 1, var_da55798eb12048a0, bundle );
    }
}

// Namespace skill_mega_punch
// Params 2, eflags: 0x4
// Checksum 0x5631f2d0, Offset: 0xa1b
// Size: 0xde
function private function_c0a18c4ac5c03a46( entity, bundle )
{
    h_boost = bundle.var_810e488c96a8637b;
    v_boost = bundle.var_f67bb090935ff389;
    
    if ( !( h_boost || v_boost ) )
    {
        return;
    }
    
    v_dir = entity.damagedir;
    launchx = clamp( v_dir[ 0 ] * h_boost, -10000, 10000 );
    launchy = clamp( v_dir[ 1 ] * h_boost, -10000, 10000 );
    launchz = clamp( v_boost, 0, 10000 );
    v_launch = ( launchx, launchy, launchz );
    corpse = entity getcorpseentity();
    
    if ( corpse )
    {
        corpse startragdollfromimpact( "torso_lower", v_launch );
    }
}

// Namespace skill_mega_punch
// Params 0, eflags: 0x4
// Checksum 0x9fa135ba, Offset: 0xb01
// Size: 0x11, Type: bool
function private function_af1feabe896eff01()
{
    return self.type == "zombie";
}

// Namespace skill_mega_punch
// Params 6, eflags: 0x4
// Checksum 0x59edd0ec, Offset: 0xb1b
// Size: 0x262
function private function_d8e12762ffc127fd( entity, var_5beaff634c597287, hit_check, kill_check, var_da55798eb12048a0, bundle )
{
    if ( entity.subclass == #"dawg" )
    {
        return;
    }
    
    if ( !entity val::get( "damage" ) )
    {
        return;
    }
    
    should_check = hit_check && bundle.var_d849af8021f6153c || kill_check && bundle.var_1d04687d4539499b;
    
    if ( should_check )
    {
        now = gettime();
        var_890942a5c4b87751 = var_da55798eb12048a0.var_11512ba6c31d1994;
        cooldown = bundle.var_b37e7aedf72cff6e;
        percent_check = bundle.var_4ef102e362854f17;
        
        if ( hit_check )
        {
            percent_check = bundle.var_7ae9804ebc9ec178;
        }
        
        diff_time = now - var_890942a5c4b87751;
        var_3d2f64c495ccca90 = diff_time >= cooldown;
        percent_check = randomint( 100 ) < percent_check;
        grant_effect = var_3d2f64c495ccca90 && percent_check;
        
        if ( grant_effect )
        {
            ai_tier = entity ai_utility::get_power_tier();
            
            if ( ai_tier == 3 && bundle.var_665c85ca86856e3d >= 3 )
            {
                var_b1487eb1ce65e991 = #"lightray_big_game";
                ammo_mod_xhash = getxhash( "lightray" );
                var_40c64f99a08dd9de = self.zombie_augments[ ammo_mod_xhash ];
                var_d2c1edec5a9f0994 = level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400;
                self.zombie_augments[ ammo_mod_xhash ] = { #majorname:var_b1487eb1ce65e991 };
                level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400 = 1;
            }
            
            entity utility::callsharedfunc( #"lightray", #"hash_c333c3a1e7aa8b2d", 1, self, undefined, "<explicitweaponnone>", entity.origin, var_5beaff634c597287, undefined, 1 );
            var_da55798eb12048a0.var_11512ba6c31d1994 = now;
            
            if ( var_b1487eb1ce65e991 )
            {
                self.zombie_augments[ ammo_mod_xhash ] = var_40c64f99a08dd9de;
                level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400 = var_d2c1edec5a9f0994;
            }
        }
    }
}

