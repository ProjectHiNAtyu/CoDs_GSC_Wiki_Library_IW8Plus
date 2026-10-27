// scripts\mp\ob\skills\skill_pinata.gsc  (hash_51016d4a018b2004.gscc) (size: 4104 Bytes / 0x1008 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5bbc8fcd (1539084237)
// size ...... 4104 (0x1008)
// includes .. 3   (offset: 0xf94)
// strings ... 7   (offset: 0xfac)
// dev strs .. 0   (offset: 0x1008)
// exports ... 16  (offset: 0x89c)
// cseg ...... 0xc5 + 0x7d7 (0x89c)
// imports ... 40  (offset: 0xb1c)
// animtree1 . 0   (offset: 0x1008)
// animtree2 . 0   (offset: 0x1008)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_pinata;

// Namespace skill_pinata
// Params 0, eflags: 0x1
// Checksum 0xfe0fa05, Offset: 0xe3
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"pinata", &init );
}

// Namespace skill_pinata
// Params 0
// Checksum 0x2d2711a0, Offset: 0x102
// Size: 0x86
function init()
{
    utility::registersharedfunc( #"pinata", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"pinata", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"pinata", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    callback::add( #"on_ai_killed", &on_enemy_killed );
    callback::add( #"player_death", &on_enemy_killed );
}

// Namespace skill_pinata
// Params 1, eflags: 0x4
// Checksum 0xbd85c10b, Offset: 0x190
// Size: 0x6e
function private function_1321989bae991e4f( skill_bundle )
{
    if ( !skill_bundle.var_b0a71ae911fa2683 )
    {
        return;
    }
    
    fx_asset = loadfxasset( skill_bundle.var_b0a71ae911fa2683 );
    fx_id_name = "pinata_fx_" + skill_bundle.skilllevel;
    level._effect[ fx_id_name ] = fx_asset;
    skill_bundle.var_ae1004439940a1ce = fx_id_name;
}

// Namespace skill_pinata
// Params 1, eflags: 0x4
// Checksum 0x77ff0a28, Offset: 0x206
// Size: 0x4c, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_52fc1d65b544f92e = { #var_3185dcd9edbdefeb:[], #var_626ba3dc8a02e87f:[], #bundle:skill_bundle };
    callback::add( #"hash_652eb614ba902b3d", &player_damage_callback );
    return true;
}

// Namespace skill_pinata
// Params 1, eflags: 0x4
// Checksum 0x94b97f76, Offset: 0x25b
// Size: 0x15d
function private on_enemy_killed( params )
{
    attacker = params.attacker ?? params.eattacker;
    var_da55798eb12048a0 = attacker.var_52fc1d65b544f92e;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !bundle.var_54036db539295af1 )
    {
        return;
    }
    
    current_time = gettime();
    attacker function_df88c526f91fdb9b( current_time, var_da55798eb12048a0, bundle );
    drop_rate = attacker get_drop_rate( var_da55798eb12048a0, bundle );
    
    if ( !utility::percent_chance( drop_rate ) )
    {
        return;
    }
    
    var_e10a5d9db659e6e = attacker get_random_equipment( bundle );
    launch_velocity = get_random_velocity( attacker, bundle );
    var_366a13b083936e31 = self.origin + ( 0, 0, bundle.var_448817cea664e2cb );
    grenade = attacker launchgrenade( var_e10a5d9db659e6e, var_366a13b083936e31, launch_velocity, bundle.var_4446b27c63cdd88f );
    grenade.var_9568f72eeab7cac7 = 1;
    grenade thread override_trail( attacker, bundle );
    grenade_id = grenade getentitynumber();
    var_da55798eb12048a0.var_3185dcd9edbdefeb[ grenade_id ] = attacker;
    attacker thread function_c972ef2328f0de01( grenade_id, var_da55798eb12048a0 );
    attacker function_52a274dc849c3712( current_time, var_da55798eb12048a0 );
}

// Namespace skill_pinata
// Params 2, eflags: 0x4
// Checksum 0xd88877a7, Offset: 0x3c0
// Size: 0x68
function private get_drop_rate( var_da55798eb12048a0, bundle )
{
    rate_index = int( min( var_da55798eb12048a0.var_626ba3dc8a02e87f.size / bundle.var_ff6e16bac115997d, bundle.var_143735dec3121bc0.size - 1 ) );
    return bundle.var_143735dec3121bc0[ rate_index ].value;
}

// Namespace skill_pinata
// Params 3, eflags: 0x4
// Checksum 0x730c426, Offset: 0x431
// Size: 0xdb
function private function_df88c526f91fdb9b( current_time, var_da55798eb12048a0, bundle )
{
    var_7e4a8fa5e67bd230 = var_da55798eb12048a0.var_626ba3dc8a02e87f;
    var_9b9e595590be9855 = bundle.var_5560bb44949bd78;
    future_list = [];
    
    foreach ( time in var_7e4a8fa5e67bd230 )
    {
        if ( time + var_9b9e595590be9855 > current_time )
        {
            future_list[ future_list.size ] = time;
        }
    }
    
    var_da55798eb12048a0.var_626ba3dc8a02e87f = future_list;
}

// Namespace skill_pinata
// Params 2, eflags: 0x4
// Checksum 0xbbc9efff, Offset: 0x514
// Size: 0x30
function private function_52a274dc849c3712( current_time, var_da55798eb12048a0 )
{
    var_da55798eb12048a0.var_626ba3dc8a02e87f[ var_da55798eb12048a0.var_626ba3dc8a02e87f.size ] = current_time;
}

// Namespace skill_pinata
// Params 2, eflags: 0x4
// Checksum 0xe37f0c69, Offset: 0x54c
// Size: 0x71
function private override_trail( attacker, bundle )
{
    self missilehidetrail();
    trailvfx = utility::getfx( bundle.var_ae1004439940a1ce );
    playfxontag( trailvfx, self, "tag_origin" );
    utility::waittill_any( "missile_stuck", "missile_bounced", "missile_change_to_dud", "death" );
    
    if ( self )
    {
        stopfxontag( trailvfx, self, "tag_origin" );
    }
}

// Namespace skill_pinata
// Params 2, eflags: 0x4
// Checksum 0xe154a0ac, Offset: 0x5c5
// Size: 0x5d
function private function_c972ef2328f0de01( grenade_id, var_da55798eb12048a0 )
{
    self endon( #"disconnect" );
    utility::waittill_any( "explode", "death" );
    wait 6.5;
    
    if ( self && isarray( var_da55798eb12048a0.var_3185dcd9edbdefeb ) )
    {
        var_da55798eb12048a0.var_3185dcd9edbdefeb[ grenade_id ] = undefined;
    }
}

// Namespace skill_pinata
// Params 2, eflags: 0x4
// Checksum 0xdd961ebf, Offset: 0x62a
// Size: 0x94
function private get_random_velocity( attacker, bundle )
{
    random_velocity = randomintrange( bundle.var_611549bea8a4dbea, bundle.var_5584697faaef1cb4 );
    var_47a8bf3b386be5a5 = randomint( bundle.var_d93749fd30594a22 );
    x_velocity = random_velocity * cos( var_47a8bf3b386be5a5 );
    y_velocity = random_velocity * sin( var_47a8bf3b386be5a5 );
    var_f9be4154203f88a = bundle.var_cdce68aeea1bca93;
    return ( x_velocity, y_velocity, var_f9be4154203f88a );
}

// Namespace skill_pinata
// Params 1, eflags: 0x4
// Checksum 0x887fee2b, Offset: 0x6c7
// Size: 0x34
function private get_random_equipment( bundle )
{
    random_equipment = utility::random_weighted_struct( bundle.var_54036db539295af1 );
    return random_equipment.ref;
}

// Namespace skill_pinata
// Params 1, eflags: 0x4
// Checksum 0x137d5ee4, Offset: 0x704
// Size: 0x92
function private player_damage_callback( params )
{
    var_da55798eb12048a0 = params.eattacker.var_52fc1d65b544f92e;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( function_596b5026252708cc( params.einflictor, params.eattacker, params.victim, var_da55798eb12048a0, bundle ) )
    {
        params.idamage *= bundle.var_b508e5925c6c0720;
    }
}

// Namespace skill_pinata
// Params 5, eflags: 0x4
// Checksum 0x50137b2b, Offset: 0x79e
// Size: 0xb3, Type: bool
function private function_596b5026252708cc( inflictor, attacker, victim, var_da55798eb12048a0, bundle )
{
    if ( inflictor.var_9568f72eeab7cac7 && isdefined( bundle.var_b508e5925c6c0720 ) && attacker == victim )
    {
        return true;
    }
    
    if ( inflictor.var_a7803e45d8e63517 )
    {
        equipment_parent = var_da55798eb12048a0.var_3185dcd9edbdefeb[ inflictor.var_a7803e45d8e63517 ];
        
        if ( equipment_parent && equipment_parent == victim && isdefined( bundle.var_b508e5925c6c0720 ) && attacker == victim )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skill_pinata
// Params 1, eflags: 0x4
// Checksum 0x818973, Offset: 0x85a
// Size: 0x42
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_52fc1d65b544f92e = undefined;
    
    if ( callback::exists( #"hash_652eb614ba902b3d", &player_damage_callback ) )
    {
        callback::remove( #"hash_652eb614ba902b3d", &player_damage_callback );
    }
}

