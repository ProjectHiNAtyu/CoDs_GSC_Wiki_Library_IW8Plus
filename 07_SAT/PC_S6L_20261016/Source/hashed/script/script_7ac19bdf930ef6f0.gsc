// script_7ac19bdf930ef6f0  (hash_7ac19bdf930ef6f0.gscc) (size: 1843 Bytes / 0x733 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f16d7f (32599423)
// size ...... 1843 (0x733)
// includes .. 4   (offset: 0x6f3)
// strings ... 2   (offset: 0x713)
// dev strs .. 0   (offset: 0x733)
// exports ... 6   (offset: 0x3ef)
// cseg ...... 0x7f + 0x370 (0x3ef)
// imports ... 18  (offset: 0x4df)
// animtree1 . 0   (offset: 0x733)
// animtree2 . 0   (offset: 0x733)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\laststand;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_415b9206a2930add;

// Namespace namespace_415b9206a2930add
// Params 0, eflags: 0x5
// Checksum 0x3ad8e8a8, Offset: 0x9d
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"nowhere_but_there_zm", "nowhere_but_there", &pre_main, undefined );
}

// Namespace namespace_415b9206a2930add
// Params 0, eflags: 0x4
// Checksum 0xccfb85c6, Offset: 0xc2
// Size: 0x44
function private pre_main()
{
    utility::registersharedfunc( "nowhere_but_there", #"hash_9433bcdb1c6b88c0", &function_4bb819aa26adb5ed );
    utility::registersharedfunc( "nowhere_but_there", #"revive_nearby_players", &revive_nearby_players );
    level.var_a5075772bb06b565 = &function_fd0bac65e140209a;
}

// Namespace namespace_415b9206a2930add
// Params 1, eflags: 0x4
// Checksum 0x2a8bcc2e, Offset: 0x10e
// Size: 0x212
function private function_4bb819aa26adb5ed( e_player )
{
    v_respawn_pos = e_player.origin + anglestoforward( e_player.angles ) * 64;
    v_respawn_pos = getrandomnavpoint( v_respawn_pos, 110 );
    
    for ( n_count = 0; n_count < 5 && ( !isdefined( v_respawn_pos ) || positionwouldtelefrag( v_respawn_pos ) || !zone_manager::function_65305a611c6226d9( v_respawn_pos ) ) ; n_count++ )
    {
        v_respawn_pos = getrandomnavpoint( e_player.origin, 110 );
    }
    
    if ( isdefined( v_respawn_pos ) && !positionwouldtelefrag( v_respawn_pos ) )
    {
        v_dir = vectornormalize( e_player.origin - v_respawn_pos + ( 0, 0, 32 ) );
        v_angles = vectortoangles( v_dir );
        s_respawn_pos = spawnstruct();
        s_respawn_pos.is_temp_respawn = 1;
        s_respawn_pos.origin = v_respawn_pos;
        s_respawn_pos.angles = v_angles;
        self.var_860f55942efed674 = v_respawn_pos;
        
        if ( zone_manager::function_65305a611c6226d9( v_respawn_pos ) )
        {
            return s_respawn_pos;
        }
    }
    
    self.var_860f55942efed674 = e_player.origin;
    var_7d2a636b261c6545 = [];
    
    if ( isdefined( level.var_9980bb185b6144a5 ) )
    {
        var_7d2a636b261c6545 = [[ level.var_9980bb185b6144a5 ]]( var_7d2a636b261c6545 );
    }
    
    var_a87104a582b02a9e = undefined;
    var_7d2a636b261c6545 = utility::get_array_of_closest( self.var_860f55942efed674, var_7d2a636b261c6545 );
    
    foreach ( var_670db601def3a0d0 in var_7d2a636b261c6545 )
    {
        if ( !positionwouldtelefrag( var_670db601def3a0d0.origin ) && zone_manager::function_65305a611c6226d9( var_670db601def3a0d0.origin ) )
        {
            return var_670db601def3a0d0;
        }
    }
}

// Namespace namespace_415b9206a2930add
// Params 1, eflags: 0x4
// Checksum 0x6ec1f267, Offset: 0x329
// Size: 0xb5
function private revive_nearby_players( var_1e4139ca72a33905 )
{
    a_players = getplayersinradius( var_1e4139ca72a33905.origin, 220 );
    
    foreach ( player in a_players )
    {
        if ( player != self && player.inlaststand )
        {
            player laststand::function_75e6bc3d39e1f2bb( self, "last_stand_bgb" );
        }
    }
}

// Namespace namespace_415b9206a2930add
// Params 0
// Checksum 0x6eb1ecc8, Offset: 0x3e6
// Size: 0x9
function function_fd0bac65e140209a()
{
    zone_manager::function_fc479cad41a1ae1d();
}

