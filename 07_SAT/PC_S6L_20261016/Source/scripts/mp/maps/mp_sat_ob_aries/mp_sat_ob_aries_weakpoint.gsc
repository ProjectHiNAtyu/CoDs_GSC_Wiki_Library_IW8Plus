// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint.gsc  (hash_759295c47621f000.gscc) (size: 4986 Bytes / 0x137a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe320b65b (3810571867)
// size ...... 4986 (0x137a)
// includes .. 6   (offset: 0x124e)
// strings ... 15  (offset: 0x127e)
// dev strs .. 1   (offset: 0x136e)
// exports ... 22  (offset: 0xb2a)
// cseg ...... 0x1af + 0x97b (0xb2a)
// imports ... 32  (offset: 0xe9a)
// animtree1 . 0   (offset: 0x137a)
// animtree2 . 0   (offset: 0x137a)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\mp_agent_damage;

#namespace weak_point;

// Namespace weak_point
// Params 0, eflags: 0x1
// Checksum 0x6b8d5c3b, Offset: 0x1cd
// Size: 0x9
function autoexec weak_point_init()
{
    function_b65725ea129fef65();
}

/#

    // Namespace weak_point
    // Params 0
    // Checksum 0xcd80bed, Offset: 0x1de
    // Size: 0x5, Type: dev
    function function_b0cc869ac4116f99()
    {
        
    }

#/

// Namespace weak_point
// Params 5
// Checksum 0xe3590cfb, Offset: 0x1eb
// Size: 0x172
function cluster_setup( targetname, var_6e09f5d9ac598a18, max_health, var_8f6d340ee3e19bb4, intervals = 0 )
{
    assert( isdefined( targetname ), "<dev string:x24>" );
    var_6e09f5d9ac598a18 = var_6e09f5d9ac598a18 ?? "active";
    max_health = max_health ?? 50;
    var_8f6d340ee3e19bb4 = var_8f6d340ee3e19bb4 ?? &default_damage_override;
    weak_point_cluster = { #var_8f6d340ee3e19bb4:var_8f6d340ee3e19bb4, #arr_weak_point:getscriptablearray( targetname, "targetname" ), #targetname:targetname };
    weak_point_cluster.var_9f0a469e77d5227c = 0;
    
    foreach ( weak_point in weak_point_cluster.arr_weak_point )
    {
        if ( intervals > 0 )
        {
            weak_point.intervals = intervals;
            weak_point.interval_health = max_health / ( intervals + 1 );
        }
        
        weak_point function_dc61b81ec6b63cc4( 1 );
        weak_point.cluster = weak_point_cluster;
        weak_point function_29ad3679e4146bc2( max_health );
        weak_point thread set_state( var_6e09f5d9ac598a18 );
    }
    
    return weak_point_cluster;
}

// Namespace weak_point
// Params 1
// Checksum 0x6bf1bb4d, Offset: 0x366
// Size: 0x27
function get_cluster( name )
{
    cluster = utility::getstruct( name, "targetname" );
    return cluster;
}

// Namespace weak_point
// Params 1
// Checksum 0x5cc39246, Offset: 0x396
// Size: 0x70
function function_ab7d92dae2a8792c( weak_point )
{
    self.arr_weak_point[ self.arr_weak_point.size ] = weak_point;
    weak_point.cluster = self;
    weak_point_state = weak_point get_state();
    
    if ( weak_point_state == "active" || weak_point_state == "closed" )
    {
        self.var_9f0a469e77d5227c += 1;
    }
}

// Namespace weak_point
// Params 1
// Checksum 0xf7f58f40, Offset: 0x40e
// Size: 0x87
function function_8e525d6b07c50229( cluster )
{
    foreach ( weak_point in cluster.arr_weak_point )
    {
        function_ab7d92dae2a8792c( weak_point );
    }
}

/#

    // Namespace weak_point
    // Params 0
    // Checksum 0x555067dd, Offset: 0x49d
    // Size: 0x5, Type: dev
    function function_ae32325297fabf41()
    {
        
    }

#/

// Namespace weak_point
// Params 0
// Checksum 0x5db160a4, Offset: 0x4aa
// Size: 0xe
function function_b65725ea129fef65()
{
    scriptable::scriptable_adddamagedcallback( &weak_point_damage_callback );
}

// Namespace weak_point
// Params 11, eflags: 0x4
// Checksum 0x9a57bea5, Offset: 0x4c0
// Size: 0x34a
function private weak_point_damage_callback( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "mp_sat_ob_aries_boss_weakpoint_scriptable" && instance.type != "mp_sat_ob_aries_boss_weakpoint_scriptable_mars_arena" && instance.type != "mp_sat_ob_aries_boss_weakpoint_container_tower_scriptable" )
    {
        return;
    }
    
    if ( instance getscriptablepartstate( "body" ) == "dead" )
    {
        return;
    }
    
    weak_point_entity = instance.entity;
    
    if ( !isvector( vpoint ) )
    {
        vpoint = instance.origin;
    }
    
    if ( !isdefined( weak_point_entity.cluster.initial_wait_flag ) && instance getscriptablepartstate( "body" ) == "closed" )
    {
        mp_agent_damage::function_eb8ba16055d6da7c( eattacker, weak_point_entity, "tag_origin", undefined, undefined, 0, vpoint, 1 );
        level notify( #"hash_4d3f4083ee8a6f11" );
    }
    
    if ( !isdefined( weak_point_entity.cluster.initial_wait_flag ) && ( instance get_state() == "active" || instance get_state() == "damaged" ) )
    {
        idamage = function_a581cf5949256f38( idamage, objweapon, smeansofdeath );
        idamage = weak_point_entity [[ weak_point_entity get_damage_override() ]]( idamage, objweapon, smeansofdeath );
        mp_agent_damage::function_eb8ba16055d6da7c( eattacker, instance, "none", undefined, undefined, idamage, vpoint, 0, undefined, 1 );
        
        if ( isplayer( eattacker ) )
        {
            eattacker damagefeedback::updatehitmarker( "standard", instance.health == 0, 1, 1 );
        }
        else if ( isplayer( eattacker.owner ) )
        {
            eattacker.owner damagefeedback::updatehitmarker( "standard", instance.health == 0, 1, 1 );
        }
        else
        {
            return;
        }
        
        if ( weak_point_entity.intervals > 0 )
        {
            weak_point_entity.interval_health -= idamage;
        }
        
        if ( weak_point_entity.health - idamage <= 0 )
        {
            weak_point_entity.cluster.var_9f0a469e77d5227c -= 1;
            instance set_state( "dead" );
            weak_point_entity default_callback();
            weak_point_entity notify( #"weak_point_destroyed", eattacker );
            weak_point_entity.cluster notify( #"weak_point_destroyed", eattacker );
            
            if ( ob::nightmare() )
            {
                if ( isplayer( eattacker ) )
                {
                    eattacker points::doscoreevent( #"ob_aethernest_cyst_destroyed" );
                }
            }
            
            return;
        }
        
        weak_point_entity notify( #"notify_weak_point_damaged", idamage );
        weak_point_entity.cluster notify( #"notify_weak_point_damaged" );
        
        if ( weak_point_entity.interval_health <= 0 )
        {
            weak_point_entity thread interval_handler();
            return;
        }
        
        if ( instance getscriptablepartstate( "body" ) != "damaged" )
        {
            instance set_state( "damaged" );
        }
    }
}

/#

    // Namespace weak_point
    // Params 0
    // Checksum 0x6a8662cf, Offset: 0x812
    // Size: 0x5, Type: dev
    function function_98823f40c322b954()
    {
        
    }

#/

// Namespace weak_point
// Params 0
// Checksum 0x29544d3c, Offset: 0x81f
// Size: 0x5a
function interval_handler()
{
    set_state( "closing" );
    wait randomintrange( 7, 10 );
    set_state( "opening" );
    self.intervals--;
    
    if ( self.intervals >= 0 )
    {
        self.interval_health = self.health / ( self.intervals + 1 );
    }
}

// Namespace weak_point
// Params 1
// Checksum 0x98f78702, Offset: 0x881
// Size: 0x86
function cluster_set_state( state )
{
    foreach ( weak_point in self.arr_weak_point )
    {
        weak_point thread set_state( state );
    }
}

// Namespace weak_point
// Params 2
// Checksum 0x55dde89e, Offset: 0x90f
// Size: 0xa5
function set_state( state, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    self setscriptablepartstate( "body", state );
    
    if ( state == "active" || state == "opening" )
    {
        if ( !utility::ent_flag( "flag_weak_point_initial_open" ) )
        {
            self.health = self.maxhealth;
            utility::ent_flag_set( "flag_weak_point_initial_open" );
        }
        
        self.cluster.var_9f0a469e77d5227c += 1;
        self notify( #"hash_17875999f2e2c3f" );
    }
}

// Namespace weak_point
// Params 0
// Checksum 0x870c3df6, Offset: 0x9bc
// Size: 0xc
function get_state()
{
    return self getscriptablepartstate( "body" );
}

// Namespace weak_point
// Params 1
// Checksum 0x1c11807, Offset: 0x9d1
// Size: 0x29
function function_29ad3679e4146bc2( max_health )
{
    self.maxhealth = max_health;
    self.health = self.maxhealth;
}

// Namespace weak_point
// Params 0, eflags: 0x4
// Checksum 0x114c87, Offset: 0xa02
// Size: 0x15
function private get_weak_point_callback()
{
    return self.cluster.cluster_callback;
}

// Namespace weak_point
// Params 0, eflags: 0x4
// Checksum 0x76dbf8af, Offset: 0xa20
// Size: 0x15
function private get_damage_override()
{
    return self.cluster.var_8f6d340ee3e19bb4;
}

// Namespace weak_point
// Params 0, eflags: 0x4
// Checksum 0x1744cc42, Offset: 0xa3e
// Size: 0xb
function private function_3e38d8b1c7d90a67()
{
    return self.var_9f0a469e77d5227c;
}

// Namespace weak_point
// Params 0
// Checksum 0x828db6a, Offset: 0xa52
// Size: 0x2a
function default_callback()
{
    if ( self.cluster function_3e38d8b1c7d90a67() <= 0 )
    {
        self.cluster notify( #"all_weak_points_in_cluster_destroyed" );
    }
}

// Namespace weak_point
// Params 3
// Checksum 0x398ebcef, Offset: 0xa84
// Size: 0x20
function default_damage_override( damage_amount, weapon_object, var_b3cbd266eebbbb50 )
{
    return damage_amount;
}

// Namespace weak_point
// Params 3
// Checksum 0xf7ba3b56, Offset: 0xaad
// Size: 0x7c
function function_a581cf5949256f38( damage_amount, weapon_object, var_b3cbd266eebbbb50 )
{
    var_659f96f3358f496d = 50;
    var_d4bd03f151208c38 = 5;
    var_a94e79343f7322d6 = damage_amount;
    
    switch ( var_b3cbd266eebbbb50 )
    {
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a911a1880d996edb":
            var_a94e79343f7322d6 -= var_659f96f3358f496d;
            break;
    }
    
    if ( var_a94e79343f7322d6 < var_d4bd03f151208c38 )
    {
        var_a94e79343f7322d6 = var_d4bd03f151208c38;
    }
    
    return var_a94e79343f7322d6;
}

