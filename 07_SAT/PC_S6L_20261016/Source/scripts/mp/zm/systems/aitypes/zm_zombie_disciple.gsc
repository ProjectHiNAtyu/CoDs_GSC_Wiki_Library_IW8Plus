// scripts\mp\zm\systems\aitypes\zm_zombie_disciple.gsc  (hash_4c8d5348338c0a3f.gscc) (size: 1322 Bytes / 0x52a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab85d72f (2877675311)
// size ...... 1322 (0x52a)
// includes .. 4   (offset: 0x4ce)
// strings ... 5   (offset: 0x4ee)
// dev strs .. 0   (offset: 0x52a)
// exports ... 5   (offset: 0x2fe)
// cseg ...... 0x10b + 0x1f3 (0x2fe)
// imports ... 9   (offset: 0x3c6)
// animtree1 . 0   (offset: 0x52a)
// animtree2 . 0   (offset: 0x52a)
#using scripts\common\callbacks;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_zombie_disciple;

// Namespace zm_zombie_disciple
// Params 2
// Checksum 0x82a7800d, Offset: 0x129
// Size: 0x123
function precache( classname, aitypescriptbundle )
{
    summon_aitypes = agent_utils::get_aitype_by_subclass( "zombie_base" );
    var_86378c265bd6b3c6 = undefined;
    
    foreach ( aitype in summon_aitypes )
    {
        strlen = aitype.size;
        
        if ( !isdefined( var_86378c265bd6b3c6 ) || var_86378c265bd6b3c6.size > strlen )
        {
            var_86378c265bd6b3c6 = aitype;
        }
    }
    
    aitype_to_spawn = var_86378c265bd6b3c6;
    level.var_c9fa5883a2c15ba5 = aitype_to_spawn;
    
    if ( !isdefined( level.var_10208ef92cb393b5 ) )
    {
        callback::add( "on_zombie_disciple_skoll_spawned", &function_1940b732b387aaca );
        callback::add( "on_zombie_disciple_skoll_hvt_spawned", &function_1940b732b387aaca );
        callback::add( "disciple_check_passive_spawn_location", &disciple_check_passive_spawn_location );
        level.var_10208ef92cb393b5 = 1;
    }
}

// Namespace zm_zombie_disciple
// Params 1
// Checksum 0x807f038f, Offset: 0x254
// Size: 0x1d
function function_1940b732b387aaca( params )
{
    callback::add( "disciple_check_round_spawn_limits_requested", &function_5092ebdaa9629cf2 );
}

// Namespace zm_zombie_disciple
// Params 1
// Checksum 0x914b0234, Offset: 0x279
// Size: 0x41
function function_5092ebdaa9629cf2( params )
{
    var_a45189ff1e34f63c = 0;
    
    if ( zm_utility::get_active_zombies_count() < level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
    {
        self.var_a45189ff1e34f63c = 1;
    }
}

// Namespace zm_zombie_disciple
// Params 1
// Checksum 0x49043548, Offset: 0x2c2
// Size: 0x3b, Type: bool
function disciple_check_passive_spawn_location( params )
{
    zone = zone_manager::function_90e5c3e2272b0130( params.location );
    return isdefined( zone ) && zone.is_active;
}

