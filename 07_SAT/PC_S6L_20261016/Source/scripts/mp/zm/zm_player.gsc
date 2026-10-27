// scripts\mp\zm\zm_player.gsc  (hash_2e262e1987b0b66f.gscc) (size: 23071 Bytes / 0x5a1f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab6606b0 (2875590320)
// size ...... 23071 (0x5a1f)
// includes .. 13  (offset: 0x5603)
// strings ... 36  (offset: 0x566b)
// dev strs .. 27  (offset: 0x58bb)
// exports ... 43  (offset: 0x3ac7)
// cseg ...... 0x301 + 0x37c6 (0x3ac7)
// imports ... 168 (offset: 0x417f)
// animtree1 . 0   (offset: 0x5a1f)
// animtree2 . 0   (offset: 0x5a1f)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\spawnlogic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_player;

// Namespace zm_player
// Params 0
// Checksum 0x5fdb30db, Offset: 0x31f
// Size: 0xc5
function init_player()
{
    utility::registersharedfunc( #"player", #"hash_ab1b6d347d2c1b81", &function_c1440cc102ccf1a8 );
    utility::registersharedfunc( #"player", #"hash_bb3e9af3250b07c3", &function_868777c10833a79f );
    level.var_a6f80a315ca414aa = 60;
    level.var_5c1e9fc4f3cf900b = 1;
    level.override_unresolved_collision = &override_unresolved_collision;
    level.var_9c5893f78a9f30e7 = [];
    var_1a77b47d373e0493 = undefined;
    callback::add( #"start_game_ended", &function_69367c58067c7fd9 );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"loadout_given", &on_loadout_given );
    
    /#
        level init_player_devgui();
    #/
}

// Namespace zm_player
// Params 1
// Checksum 0xfe45d5c1, Offset: 0x3ec
// Size: 0xd9
function function_69367c58067c7fd9( params )
{
    foreach ( player in level.players )
    {
        if ( function_f37cfdf04b932a03( player ) )
        {
            player val::set( "end_game", "damage", 0 );
            player val::set( "end_game", "ignoreme", 1 );
            player val::set( "end_game", "allow_movement", 0 );
            player val::set( "end_game", "freezecontrols_allowlook", 1 );
        }
    }
}

// Namespace zm_player
// Params 0
// Checksum 0x1140bc96, Offset: 0x4cd
// Size: 0x5e
function init_shared_funcs()
{
    utility::registersharedfunc( #"player", #"setusingremote", &setusingremote, 0 );
    utility::registersharedfunc( #"player", #"clearusingremote", &clearusingremote, 0 );
    utility::registersharedfunc( #"zombie", #"hash_c2f3b4bd5b181dd0", &function_ea92f88903bc485 );
}

// Namespace zm_player
// Params 1
// Checksum 0x2654423c, Offset: 0x533
// Size: 0x48
function function_1c077eb1ecd1777e( params )
{
    thread function_684f3d4743476115();
    thread function_d60b0ae6d3964c07();
    thread function_6d1c626d2e41db14();
    thread function_27a2c9805cd1844f();
    thread function_748eeaafe8e34798();
    
    if ( !getdvarint( @"hash_72e4d6b8f8afa03", 0 ) )
    {
        thread function_5ee8ecdf3ba623d8();
    }
}

// Namespace zm_player
// Params 2, eflags: 0x4
// Checksum 0x7d44b20b, Offset: 0x583
// Size: 0x99
function private override_unresolved_collision( player, ballowsuicide )
{
    thread function_be5837e65aca3c42( player );
    
    if ( player.ismutantinjection && utility::flag( "exfil_start" ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_used" );
        }
        
        player thread utility::callsharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", 1 );
    }
}

// Namespace zm_player
// Params 1, eflags: 0x4
// Checksum 0xa9ca3a68, Offset: 0x624
// Size: 0x156
function private function_be5837e65aca3c42( player )
{
    player endon( #"death_or_disconnect" );
    
    if ( player utility::ent_flag( "unresolved_collision_thread" ) )
    {
        return;
    }
    
    if ( getdvarint( @"zm_player_unresolved_collision_thread", 1 ) > 0 )
    {
        return;
    }
    
    player utility::ent_flag_set( "unresolved_collision_thread" );
    wait 5;
    num_checks = 10;
    var_b59792c41768cf75 = 15;
    dist_z_threshold = 100;
    
    while ( num_checks > 0 )
    {
        nav_pos = getclosestpointonnavmesh( player.origin );
        var_48607cfdb87ffbae = distance2dsquared( nav_pos, player.origin );
        
        if ( var_48607cfdb87ffbae < squared( var_b59792c41768cf75 ) && abs( nav_pos[ 2 ] - player.origin[ 2 ] ) < dist_z_threshold )
        {
            player utility::ent_flag_clear( "unresolved_collision_thread" );
            return;
        }
        
        /#
            if ( player isnoclip() )
            {
                player utility::ent_flag_clear( "<dev string:x24>" );
                return;
            }
        #/
        
        num_checks--;
        wait 1;
    }
    
    teleport_player( player, undefined, undefined, 0 );
    assertmsg( "<dev string:x40>" + player.origin + "<dev string:x68>" + player.name );
    player utility::ent_flag_clear( "unresolved_collision_thread" );
}

// Namespace zm_player
// Params 0, eflags: 0x4
// Checksum 0xc9a000e6, Offset: 0x782
// Size: 0x4b
function private function_684f3d4743476115()
{
    self notify( #"hash_2b6b967dbe60fed6" );
    self endon( #"hash_2b6b967dbe60fed6" );
    self endon( #"disconnect" );
    self.var_c5841ca9d8c4dcf1 = 0;
    
    while ( isdefined( self ) )
    {
        self.var_c5841ca9d8c4dcf1 = function_f37cfdf04b932a03( self, 1 );
        waitframe();
    }
}

// Namespace zm_player
// Params 0, eflags: 0xc
// Checksum 0x9dce995f, Offset: 0x7d5
// Size: 0x1ed
function private function_5ee8ecdf3ba623d8()
{
    self notify( #"hash_7003123f9865ba0a" );
    self endon( #"hash_7003123f9865ba0a" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait function_dcb0e4a4ac8f1e9f();
        
        if ( getdvarint( @"hash_72e4d6b8f8afa03", 0 ) )
        {
            continue;
        }
        
        if ( level.var_1a7d5de49b6970b1 )
        {
            continue;
        }
        
        if ( !isalive( self ) || self.sessionstate == "spectator" || self.sessionstate == "playing_but_spectating" || self function_e7d19d7e4403c48() )
        {
            continue;
        }
        
        if ( self.b_ignore_playable_area_check || val::get( "ignore_playable_area_check" ) )
        {
            continue;
        }
        
        if ( self isonascender() )
        {
            continue;
        }
        
        if ( self isswimunderwater() )
        {
            continue;
        }
        
        fall_speed_threshold = -300;
        velocity = self getvelocity();
        
        if ( velocity[ 2 ] < fall_speed_threshold )
        {
            continue;
        }
        
        if ( !function_83f76a6615ec6637() && ( !function_eebc26d3ebcc3852() || function_cb6f435613626945() ) && !function_8a01a51e9195d1e8() )
        {
            /#
                if ( self isufo() || self isnoclip() )
                {
                    continue;
                }
                
                iprintlnbold( "<dev string:x87>" + self.origin );
            #/
            
            if ( !self.inlaststand )
            {
                self playlocalsound( #"evt_plr_oob_impact_main" );
            }
            
            if ( self.maxhealth > 0 )
            {
                n_damage = int( self.maxhealth / 3 ) + 1;
            }
            else
            {
                n_damage = 51;
            }
            
            if ( self.health <= n_damage )
            {
                self.var_ee4e521e94b41b6a = 1;
                var_ee676fca0a0c2d1a = 1;
            }
            
            self dodamage( n_damage, self.origin, self, self, undefined, "<explicitweaponnone>", undefined, undefined, 65536 );
            
            if ( var_ee676fca0a0c2d1a )
            {
                self.var_ee4e521e94b41b6a = 0;
                var_ee676fca0a0c2d1a = 0;
            }
        }
    }
}

// Namespace zm_player
// Params 0, eflags: 0x4
// Checksum 0x4800d9ea, Offset: 0x9ca
// Size: 0x2a
function private function_dcb0e4a4ac8f1e9f()
{
    /#
        if ( level.var_4a4831f495f1cbfd )
        {
            return 0.5;
        }
    #/
    
    if ( zombie_perks::has_perk( "specialty_quickrevive" ) )
    {
        return 1;
    }
    
    return 3;
}

// Namespace zm_player
// Params 0
// Checksum 0x58871fdc, Offset: 0x9fd
// Size: 0x26, Type: bool
function function_eebc26d3ebcc3852()
{
    var_8c4fe62d01999d1e = zone_manager::get_current_zone();
    return isdefined( var_8c4fe62d01999d1e ) && var_8c4fe62d01999d1e.is_enabled;
}

// Namespace zm_player
// Params 0
// Checksum 0xc74f654a, Offset: 0xa2c
// Size: 0x69, Type: bool
function function_8a01a51e9195d1e8()
{
    if ( !level.var_239f27811d6175db )
    {
        return false;
    }
    
    closest_pos = getclosestpointonnavmesh( self.origin + ( 0, 0, 10 ) );
    var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( closest_pos );
    return isdefined( var_8c4fe62d01999d1e ) && arraycontains( level.var_239f27811d6175db, var_8c4fe62d01999d1e.script_zone_name );
}

// Namespace zm_player
// Params 1
// Checksum 0x8bf45a02, Offset: 0xa9e
// Size: 0x23
function function_ff714b8751ab0002( noent_volume )
{
    level.var_9c5893f78a9f30e7[ level.var_9c5893f78a9f30e7.size ] = noent_volume;
}

// Namespace zm_player
// Params 0
// Checksum 0x70a8e952, Offset: 0xac9
// Size: 0x63, Type: bool
function function_83f76a6615ec6637()
{
    var_8f0d33adadef57df = getentarray( "life_brush", #script_noteworthy );
    var_8f0d33adadef57df = arraycombine( var_8f0d33adadef57df, level.var_9c5893f78a9f30e7 );
    
    if ( !isdefined( var_8f0d33adadef57df ) )
    {
        return false;
    }
    
    for ( i = 0; i < var_8f0d33adadef57df.size ; i++ )
    {
        if ( self istouching( var_8f0d33adadef57df[ i ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_player
// Params 0
// Checksum 0xe7daf3db, Offset: 0xb35
// Size: 0x69, Type: bool
function function_cb6f435613626945()
{
    var_89700fb0e36609 = getentarray( "kill_brush", #script_noteworthy );
    self.kill_brush = undefined;
    
    if ( !isdefined( var_89700fb0e36609 ) )
    {
        return false;
    }
    
    for ( i = 0; i < var_89700fb0e36609.size ; i++ )
    {
        if ( self istouching( var_89700fb0e36609[ i ] ) )
        {
            self.kill_brush = var_89700fb0e36609[ i ];
            return true;
        }
    }
    
    return false;
}

// Namespace zm_player
// Params 6
// Checksum 0xcf6943b, Offset: 0xba7
// Size: 0x406
function teleport_player( e_player, v_teleport_point, var_b5d94448829ca237, var_b637d5d6f0a587e9, var_1c8dc5f124d77215, var_9786e5849d2da40a )
{
    e_player endon( #"death" );
    assert( isplayer( e_player ), "<dev string:x9e>" );
    e_player utility::ent_flag_set( "zm_player_teleport" );
    e_player utility::ent_flag_set( "zm_player_teleport_done" );
    
    if ( !isdefined( v_teleport_point ) )
    {
        var_bc38bf8ebfecbcb = getclosestpointonnavmesh( e_player.origin );
        
        if ( !zone_manager::function_65305a611c6226d9( var_bc38bf8ebfecbcb ) || positionwouldtelefrag( var_bc38bf8ebfecbcb ) )
        {
            var_a87104a582b02a9e = e_player zone_manager::function_aeaa8dd788ed9b16( undefined, 1 );
            v_teleport_point = var_a87104a582b02a9e.origin;
            var_b5d94448829ca237 = var_a87104a582b02a9e.angles;
        }
        else
        {
            v_teleport_point = var_bc38bf8ebfecbcb;
        }
    }
    
    if ( !isdefined( var_b5d94448829ca237 ) )
    {
        var_b5d94448829ca237 = e_player.angles;
    }
    
    if ( !isdefined( var_b637d5d6f0a587e9 ) )
    {
        var_b637d5d6f0a587e9 = 1;
    }
    
    if ( !isdefined( var_1c8dc5f124d77215 ) )
    {
        var_1c8dc5f124d77215 = 5;
    }
    
    e_player val::set( "zm_player_teleport", "ignoreme", 1 );
    parent = e_player getlinkedparent();
    
    if ( isdefined( parent ) )
    {
        grandparent = parent getlinkedparent();
        e_player unlink();
    }
    
    e_player setvelocity( ( 0, 0, 0 ) );
    e_player setorigin( v_teleport_point );
    e_player val::set( "zm_player_teleport", "freezecontrols", 1 );
    var_f7c8613ca0f514de = e_player.origin + ( 0, 0, 60 );
    a_ai = getaiarray();
    var_8e51d99478263b21 = [];
    var_f47d94670350654c = undefined;
    
    if ( var_b637d5d6f0a587e9 && a_ai.size )
    {
        var_8e51d99478263b21 = utility::get_array_of_closest( e_player.origin, a_ai );
        
        foreach ( ai in var_8e51d99478263b21 )
        {
            var_3a7faa84def42c4e = ai sightconetrace( var_f7c8613ca0f514de, e_player );
            
            if ( var_3a7faa84def42c4e <= 0.2 )
            {
                continue;
            }
            
            var_b5d94448829ca237 = vectortoangles( ai getcentroid() - var_f7c8613ca0f514de );
            break;
        }
    }
    
    e_player setplayerangles( var_b5d94448829ca237 );
    level callback::callback( "zm_player_teleport", { #player:e_player } );
    
    if ( isdefined( var_9786e5849d2da40a[ "zm_player_teleport" ] ) )
    {
        level callback::callback( var_9786e5849d2da40a[ "zm_player_teleport" ], { #player:e_player } );
    }
    
    e_player show();
    
    if ( var_1c8dc5f124d77215 > 0 )
    {
        a_ai = getaiarray();
        var_efb9ed6a0e9e4824 = utility::get_array_of_closest( e_player.origin, a_ai, undefined, undefined, var_1c8dc5f124d77215 );
        
        foreach ( ai in var_efb9ed6a0e9e4824 )
        {
            if ( !isai( ai ) || !isalive( ai ) )
            {
                continue;
            }
            
            ai.ignore_enemy_count = 1;
            ai dodamage( ai.health + 1000, e_player.origin, undefined, undefined, "MOD_UNKNOWN" );
            
            if ( !isalive( ai ) )
            {
                ai callback::callback( "zm_player_teleport_kill", { #player:e_player } );
                
                if ( isdefined( var_9786e5849d2da40a[ "zm_player_teleport_kill" ] ) )
                {
                    ai callback::callback( var_9786e5849d2da40a[ "zm_player_teleport_kill" ], { #player:e_player } );
                }
            }
        }
    }
    
    e_player utility::ent_flag_clear( "zm_player_teleport" );
    e_player thread function_12dcac1da754702a();
}

// Namespace zm_player
// Params 0, eflags: 0x4
// Checksum 0x8aeb5103, Offset: 0xfb5
// Size: 0x3c
function private function_12dcac1da754702a()
{
    wait 0.2;
    val::reset( "zm_player_teleport", "freezecontrols" );
    wait 0.5;
    val::reset( "zm_player_teleport", "ignoreme" );
    utility::ent_flag_clear( "zm_player_teleport_done" );
}

// Namespace zm_player
// Params 3
// Checksum 0x142cf248, Offset: 0xff9
// Size: 0xc8
function function_f37cfdf04b932a03( e_player, b_check_ignore_me = 0, b_allow_last_stand = 0 )
{
    if ( !isplayer( e_player ) )
    {
        return 0;
    }
    
    if ( !isalive( e_player ) )
    {
        return 0;
    }
    
    if ( e_player.sessionstate == "spectator" || e_player.sessionstate == "intermission" )
    {
        return 0;
    }
    
    if ( !b_allow_last_stand )
    {
        if ( e_player.inlaststand )
        {
            return 0;
        }
    }
    
    if ( b_check_ignore_me )
    {
        if ( e_player.ignoreme || e_player.notarget )
        {
            return 0;
        }
    }
    
    if ( isdefined( level.var_360484c65210bbc ) )
    {
        return [[ level.var_360484c65210bbc ]]( e_player );
    }
    
    return 1;
}

// Namespace zm_player
// Params 3
// Checksum 0x86f5b5d6, Offset: 0x10ca
// Size: 0x3fc
function function_a18e3b2a9646f559( origin, ignore_players = [], var_a43aac944155ca46 = 0 )
{
    players = level.players;
    
    foreach ( player in players )
    {
        if ( !player.var_c5841ca9d8c4dcf1 )
        {
            ignore_players = arraycombineunique( ignore_players, [ player ] );
            continue;
        }
        
        if ( isdefined( level.var_bb273cf9d00233bf ) )
        {
            if ( ![[ level.var_bb273cf9d00233bf ]]( player ) )
            {
                ignore_players[ ignore_players.size ] = player;
            }
        }
        
        if ( isdefined( level.is_player_reachable ) )
        {
            if ( ![[ level.is_player_reachable ]]( player ) )
            {
                ignore_players[ ignore_players.size ] = player;
            }
        }
    }
    
    if ( isdefined( ignore_players ) )
    {
        foreach ( var_9f61f37dea577200 in ignore_players )
        {
            players = arrayremove( players, var_9f61f37dea577200 );
        }
    }
    
    if ( players.size == 0 )
    {
        return;
    }
    
    if ( !var_a43aac944155ca46 && isdefined( self.var_69f13be78b25a980 ) )
    {
        player = [[ self.var_69f13be78b25a980 ]]( origin, players );
    }
    else if ( !var_a43aac944155ca46 && isdefined( level.var_69f13be78b25a980 ) )
    {
        player = [[ level.var_69f13be78b25a980 ]]( origin, players );
    }
    else
    {
        player = function_47c86977a18df38b( players, origin );
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    z_check = undefined;
    
    if ( isdefined( player.last_valid_position ) )
    {
        z_check = player.last_valid_position[ 2 ];
        last_valid_position_delta_z = abs( player.last_valid_position[ 2 ] - self.origin[ 2 ] );
        pathfinding_height = 72;
        pathfinding_radius = 15;
        
        if ( distance2dsquared( self.origin, player.last_valid_position ) < squared( pathfinding_radius ) && last_valid_position_delta_z > pathfinding_height * 0.25 && last_valid_position_delta_z < pathfinding_height || abs( self.origin[ 2 ] - player.last_valid_position[ 2 ] ) < pathfinding_height * 0.25 )
        {
            z_check = self.origin[ 2 ];
        }
    }
    
    player_vel = length( player getvelocity() );
    var_36e329eea9922734 = 45;
    
    if ( !( isdefined( player.last_valid_position ) && isdefined( z_check ) ) || !isdefined( player getgroundentity() ) && !player isonladder() && player_vel != 0 || distancesquared( player.last_valid_position, player.origin ) < ( self.unreachable_range_override ?? squared( player_vel + var_36e329eea9922734 ) ) && abs( z_check - player.origin[ 2 ] ) < ( self.var_5cd33d9d373b60e6 ?? level.var_a6f80a315ca414aa ) && ( level.var_5c1e9fc4f3cf900b || isdefined( player.var_2776ebddb28a41ea ) && !player.var_2776ebddb28a41ea.var_96b8e19f060d4a6d ) )
    {
        if ( isdefined( self.var_320fac4fb2054040 ) && [[ self.var_320fac4fb2054040 ]]( player ) )
        {
            function_78558c89827662f3( self );
        }
        else
        {
            function_cbdb7ea42f3c719c( self );
        }
    }
    else
    {
        function_78558c89827662f3( self );
    }
    
    return player;
}

// Namespace zm_player
// Params 0
// Checksum 0x2b3a7433, Offset: 0x14cf
// Size: 0x3a0
function function_4edc86bda6052f6e()
{
    if ( isdefined( level.var_a52fc6524d39e8e9 ) )
    {
        spawn_point = self [[ level.var_a52fc6524d39e8e9 ]]();
        
        if ( spawn_point )
        {
            return spawn_point;
        }
    }
    
    valid_teammates = [];
    
    foreach ( player in level.players )
    {
        if ( player == self || player.team != self.team )
        {
            continue;
        }
        
        if ( function_f37cfdf04b932a03( player, 0, 1 ) )
        {
            valid_teammates[ valid_teammates.size ] = player;
        }
    }
    
    if ( valid_teammates.size == 0 )
    {
        return;
    }
    
    valid_teammates = arrayrandomize( valid_teammates );
    var_f4324e6c89d8f33c = [];
    active_zones = zone_manager::get_active_zones();
    
    foreach ( zone_struct in active_zones )
    {
        var_494e0a8e02253114 = zone_manager::function_9dd25e9fb0ecd45b( zone_struct.zone_name );
        
        foreach ( respawn_group in var_494e0a8e02253114 )
        {
            if ( zone_manager::location_in_zone( respawn_group.origin, zone_struct ) )
            {
                var_f4324e6c89d8f33c[ var_f4324e6c89d8f33c.size ] = respawn_group;
            }
        }
    }
    
    if ( var_f4324e6c89d8f33c.size == 0 )
    {
        return;
    }
    
    var_c9a1f9ce9e93bd49 = undefined;
    closest_distance = undefined;
    var_ec15c187bbcd68e0 = undefined;
    var_559a3bdea175e0e6 = undefined;
    
    foreach ( player in valid_teammates )
    {
        foreach ( respawn_group in var_f4324e6c89d8f33c )
        {
            var_ae7f1b91096cf187 = respawn_group.script_int ?? 1000;
            player_distance = distancesquared( player.origin, respawn_group.origin );
            
            if ( player_distance <= var_ae7f1b91096cf187 * var_ae7f1b91096cf187 )
            {
                if ( !isdefined( closest_distance ) || player_distance < closest_distance )
                {
                    var_c9a1f9ce9e93bd49 = respawn_group;
                    closest_distance = player_distance;
                }
                
                continue;
            }
            
            if ( !isdefined( var_559a3bdea175e0e6 ) || player_distance < var_559a3bdea175e0e6 )
            {
                var_ec15c187bbcd68e0 = respawn_group;
                var_559a3bdea175e0e6 = player_distance;
            }
        }
        
        if ( !isdefined( var_c9a1f9ce9e93bd49 ) )
        {
            var_c9a1f9ce9e93bd49 = var_ec15c187bbcd68e0;
        }
        
        if ( isdefined( var_c9a1f9ce9e93bd49 ) )
        {
            spawn_point = function_d6478754a8814223( var_c9a1f9ce9e93bd49 );
            
            if ( isdefined( spawn_point ) )
            {
                return spawn_point;
            }
        }
    }
}

// Namespace zm_player
// Params 1
// Checksum 0xeda58bb6, Offset: 0x1878
// Size: 0x358
function function_c107082b3aabba7d( zone_name )
{
    query_zone_struct = undefined;
    zones = zone_manager::get_inited_zones();
    
    foreach ( zone_struct in zones )
    {
        if ( zone_struct.zone_name == zone_name )
        {
            query_zone_struct = zone_struct;
            break;
        }
    }
    
    if ( !isdefined( query_zone_struct ) )
    {
        return;
    }
    
    var_f4324e6c89d8f33c = [];
    
    if ( query_zone_struct.is_enabled )
    {
        var_494e0a8e02253114 = zone_manager::function_9dd25e9fb0ecd45b( query_zone_struct.zone_name );
        
        foreach ( respawn_group in var_494e0a8e02253114 )
        {
            if ( zone_manager::location_in_zone( respawn_group.origin, query_zone_struct ) )
            {
                var_f4324e6c89d8f33c[ var_f4324e6c89d8f33c.size ] = respawn_group;
            }
        }
    }
    
    if ( var_f4324e6c89d8f33c.size == 0 )
    {
        foreach ( zone_struct in zones )
        {
            if ( zone_struct.is_enabled )
            {
                var_494e0a8e02253114 = zone_manager::function_9dd25e9fb0ecd45b( zone_struct.zone_name );
                
                foreach ( respawn_group in var_494e0a8e02253114 )
                {
                    if ( zone_manager::location_in_zone( respawn_group.origin, zone_struct ) )
                    {
                        var_f4324e6c89d8f33c[ var_f4324e6c89d8f33c.size ] = respawn_group;
                    }
                }
            }
        }
        
        if ( var_f4324e6c89d8f33c.size == 0 )
        {
            return;
        }
    }
    
    zone_origin = query_zone_struct.origin;
    var_c9a1f9ce9e93bd49 = var_f4324e6c89d8f33c[ 0 ];
    closest_distance_sqr = distancesquared( var_f4324e6c89d8f33c[ 0 ].origin, zone_origin );
    
    foreach ( respawn_group in var_f4324e6c89d8f33c )
    {
        distance_sqr = distancesquared( respawn_group.origin, zone_origin );
        
        if ( distance_sqr < closest_distance_sqr )
        {
            closest_distance_sqr = distance_sqr;
            var_c9a1f9ce9e93bd49 = respawn_group;
        }
    }
    
    spawn_point = function_d6478754a8814223( var_c9a1f9ce9e93bd49 );
    
    if ( isdefined( spawn_point ) )
    {
        return spawn_point;
    }
}

// Namespace zm_player
// Params 1
// Checksum 0x79be4b7f, Offset: 0x1bd8
// Size: 0x2db
function function_d6478754a8814223( respawn_group )
{
    if ( !isdefined( respawn_group.spawn_points_cache ) )
    {
        respawn_group.spawn_points_cache = [];
        
        foreach ( spawn_location in respawn_group.var_f448a26cf56f4a2a )
        {
            spawn_point = spawnstruct();
            spawn_point.origin = spawn_location.origin;
            spawn_point.angles = spawn_location.angles ?? ( 0, 0, 0 );
            spawn_point.index = -1;
            spawn_point.isdynamicspawn = 1;
            spawn_point spawnlogic::spawnpointinit();
            respawn_group.spawn_points_cache[ respawn_group.spawn_points_cache.size ] = spawn_point;
        }
    }
    
    spawn_points = respawn_group.spawn_points_cache;
    
    if ( !isarray( spawn_points ) || spawn_points.size == 0 )
    {
        return;
    }
    
    player_ent_num = self getentitynumber();
    
    if ( level utility::flag( "round_reset" ) )
    {
        var_d97c1d887461ab3b = player_ent_num;
        assert( var_d97c1d887461ab3b >= 0 && var_d97c1d887461ab3b < spawn_points.size );
        return spawn_points[ var_d97c1d887461ab3b ];
    }
    
    spawn_points = arrayrandomize( spawn_points );
    available_points = [];
    
    foreach ( spawn_point in spawn_points )
    {
        if ( isdefined( spawn_point.occupant ) )
        {
            if ( spawn_point.occupant == player_ent_num )
            {
                if ( positionwouldtelefrag( spawn_point.origin ) )
                {
                    spawn_point.occupant = undefined;
                }
                else
                {
                    return spawn_point;
                }
            }
            
            continue;
        }
        
        available_points[ available_points.size ] = spawn_point;
    }
    
    foreach ( spawn_point in available_points )
    {
        if ( positionwouldtelefrag( spawn_point.origin ) )
        {
            continue;
        }
        
        spawn_point.occupant = player_ent_num;
        return spawn_point;
    }
    
    return spawn_points[ 0 ];
}

// Namespace zm_player
// Params 1
// Checksum 0xf42cc6af, Offset: 0x1ebc
// Size: 0xc
function function_78558c89827662f3( params )
{
    
}

// Namespace zm_player
// Params 1
// Checksum 0x1c391d20, Offset: 0x1ed0
// Size: 0xc
function function_cbdb7ea42f3c719c( params )
{
    
}

// Namespace zm_player
// Params 1
// Checksum 0x33e27515, Offset: 0x1ee4
// Size: 0x19
function invalidate_player( player )
{
    player.var_c5841ca9d8c4dcf1 = 0;
}

// Namespace zm_player
// Params 0
// Checksum 0x6a673622, Offset: 0x1f05
// Size: 0x81
function invalidate_all_players()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            invalidate_player( player );
        }
    }
}

// Namespace zm_player
// Params 0
// Checksum 0xfe04d094, Offset: 0x1f8e
// Size: 0x164
function function_d60b0ae6d3964c07()
{
    self endon( #"disconnect" );
    
    if ( !isnavmeshloaded() )
    {
        assertmsg( "<dev string:xb2>" );
        return;
    }
    
    while ( true )
    {
        if ( ispointonnavmesh( self.origin, self ) )
        {
            self.last_valid_position = self.origin;
            waitframe();
            continue;
        }
        else if ( !isdefined( self.last_valid_position ) )
        {
            self.last_valid_position = getclosestpointonnavmesh( self.origin, self, 1 );
        }
        
        if ( !isdefined( self.last_valid_position ) )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( level.var_fd1b132233ad954 ) && ![[ level.var_fd1b132233ad954 ]]() )
        {
            waitframe();
            continue;
        }
        
        if ( ispointonnavmesh( self.last_valid_position, self ) && distance2dsquared( self.origin, self.last_valid_position ) < squared( 15 ) && squared( self.origin[ 2 ] - self.last_valid_position[ 2 ] ) < squared( 16 ) )
        {
            waitframe();
            continue;
        }
        
        navmesh_pos = getclosestpointonnavmesh( self.origin, self, 1 );
        
        if ( isdefined( navmesh_pos ) && distancesquared( navmesh_pos, self.origin ) < distancesquared( self.last_valid_position, self.origin ) )
        {
            self.last_valid_position = navmesh_pos;
        }
        
        waitframe();
    }
}

// Namespace zm_player
// Params 0
// Checksum 0xe01c1ce9, Offset: 0x20fa
// Size: 0x2d
function function_6aa4b5494255506b()
{
    if ( !isdefined( self.var_b545861f8e52b5ae ) )
    {
        self.var_b545861f8e52b5ae = ( 0, 0, 0 );
    }
    
    return self.var_b545861f8e52b5ae;
}

// Namespace zm_player
// Params 0, eflags: 0x4
// Checksum 0xd699fd11, Offset: 0x2130
// Size: 0x255
function private function_6d1c626d2e41db14()
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_a2e61e07c07645cc ) )
    {
        self.var_a2e61e07c07645cc = [];
    }
    
    if ( !isdefined( self.var_b199182381b5e0bf ) )
    {
        self.var_b199182381b5e0bf = 0;
    }
    
    if ( !isdefined( self.var_b545861f8e52b5ae ) )
    {
        self.var_b545861f8e52b5ae = ( 0, 0, 0 );
    }
    
    while ( true )
    {
        if ( !self.var_c5841ca9d8c4dcf1 )
        {
            self.var_b199182381b5e0bf = 0;
            self.var_b545861f8e52b5ae = ( 0, 0, 0 );
            wait 0.5;
            continue;
        }
        
        if ( self.var_b199182381b5e0bf <= 0 )
        {
            self.var_a2e61e07c07645cc[ 0 ] = { #origin:self.origin, #time:gettime() };
            self.var_b199182381b5e0bf++;
            wait 0.5;
            continue;
        }
        
        last_sample = self.var_a2e61e07c07645cc[ self.var_b199182381b5e0bf - 1 ];
        var_be6e3d49c6c2d9fa = gettime() - last_sample.time;
        
        if ( var_be6e3d49c6c2d9fa > utility::function_4b74c15943231980( 10 ) )
        {
            self.var_b199182381b5e0bf = 0;
            self.var_b545861f8e52b5ae = ( 0, 0, 0 );
            wait 0.5;
            continue;
        }
        
        var_c33df7835cd3cf35 = self.origin - last_sample.origin;
        var_f2444db3cbb165b3 = length( var_c33df7835cd3cf35 );
        
        if ( var_f2444db3cbb165b3 < getdvarfloat( @"hash_b880b09b75b6e341", 150 ) )
        {
            wait 0.5;
            continue;
        }
        
        new_sample = { #origin:self.origin, #time:gettime() };
        self.var_a2e61e07c07645cc[ self.var_b199182381b5e0bf ] = new_sample;
        self.var_b199182381b5e0bf++;
        
        if ( self.var_b199182381b5e0bf >= 3 )
        {
            self.var_b199182381b5e0bf = 0;
            self.var_b545861f8e52b5ae = vectornormalize( self.var_a2e61e07c07645cc[ 2 ].origin - self.var_a2e61e07c07645cc[ 0 ].origin );
        }
        
        wait 0.5;
        continue;
    }
}

// Namespace zm_player
// Params 0, eflags: 0x4
// Checksum 0xe887a03e, Offset: 0x238d
// Size: 0x24f
function private function_27a2c9805cd1844f()
{
    player = self;
    player endon( #"disconnect" );
    
    if ( !level.challengesallowed )
    {
        return;
    }
    
    var_f79a67daa282af3b = 0;
    var_a5db5976d7650aef = undefined;
    var_9b56f2d86658a701 = 0;
    var_bb84435318cbe055 = undefined;
    var_b1fa4d8a566fdc40 = 0;
    kills_threshold = 50;
    var_59b64a37fad5c3cf = 6;
    
    while ( true )
    {
        check_interval = getdvarfloat( @"hash_59c60bf76c98b1d1", float( 60 ) );
        
        if ( check_interval <= 0 )
        {
            return;
        }
        
        if ( isalive( player ) )
        {
            valuestates = player.values[ "damage" ];
            
            if ( isdefined( valuestates ) )
            {
                allow_damage_reason = getlastarraykey( valuestates );
                
                if ( !player val::get( "damage" ) && var_a5db5976d7650aef === allow_damage_reason && !player.ismutantinjection )
                {
                    var_f79a67daa282af3b += 1;
                }
                else
                {
                    var_f79a67daa282af3b = 0;
                    var_a5db5976d7650aef = allow_damage_reason;
                    var_b1fa4d8a566fdc40 = player.pers[ "kills" ];
                }
                
                if ( var_f79a67daa282af3b >= var_59b64a37fad5c3cf && player.pers[ "kills" ] - var_b1fa4d8a566fdc40 > kills_threshold )
                {
                    player val::reset( allow_damage_reason, "damage" );
                    assertmsg( "<dev string:xeb>" + ( allow_damage_reason ?? "<dev string:x120>" ) + "<dev string:x128>" + var_59b64a37fad5c3cf * check_interval + "<dev string:x12e>" );
                }
            }
            
            valuestates = player.values[ "ignoreme" ];
            
            if ( isdefined( valuestates ) )
            {
                ignore_me_reason = getlastarraykey( valuestates );
                
                if ( player val::get( "ignoreme" ) && var_bb84435318cbe055 === ignore_me_reason )
                {
                    var_9b56f2d86658a701 += 1;
                }
                else
                {
                    var_9b56f2d86658a701 = 0;
                    var_bb84435318cbe055 = ignore_me_reason;
                    var_b1fa4d8a566fdc40 = player.pers[ "kills" ];
                }
                
                if ( var_9b56f2d86658a701 >= var_59b64a37fad5c3cf && player.pers[ "kills" ] - var_b1fa4d8a566fdc40 > kills_threshold )
                {
                    player val::reset( ignore_me_reason, "ignoreme" );
                    assertmsg( "<dev string:x137>" + ( ignore_me_reason ?? "<dev string:x120>" ) + "<dev string:x128>" + var_59b64a37fad5c3cf * check_interval + "<dev string:x12e>" );
                }
            }
        }
        
        wait check_interval;
    }
}

// Namespace zm_player
// Params 0, eflags: 0x4
// Checksum 0x9db7f872, Offset: 0x25e4
// Size: 0x3af
function private function_748eeaafe8e34798()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !level.gamemodebundle.var_4773f68ad32a99f2 )
    {
        return;
    }
    
    prev_vel = ( 0, 0, 0 );
    vel = ( 0, 0, 0 );
    nearby_ai_radius = 200;
    var_b819c214097731f9 = 5;
    var_82c312e88db4e7e4 = 300;
    width = 32;
    height = 16;
    slide_damage = 5;
    hit_ai = 0;
    
    while ( true )
    {
        if ( !isalive( self ) )
        {
            self waittill( #"spawned_player" );
            hit_ai = 0;
        }
        
        var_9e91c0e43507f9bf = self issprintsliding() || self isactiverolling();
        
        if ( var_9e91c0e43507f9bf && !hit_ai )
        {
            vel = self getvelocity();
            
            if ( lengthsquared( vel ) < squared( var_82c312e88db4e7e4 ) )
            {
                waitframe();
                continue;
            }
            
            dir = vectornormalize( vel );
            angles = vectortoangles( dir );
            length = min( length( vel ) * level.framedurationseconds * var_b819c214097731f9, nearby_ai_radius );
            nearby_ai = getaiarrayinradius( self.origin, length );
            potential_targets = [];
            box_midpoint = self.origin + dir * length * 0.5;
            box_bounds = ( length * 0.5, width, height );
            
            foreach ( ai in nearby_ai )
            {
                if ( ai.aicategory != "normal" )
                {
                    continue;
                }
                
                closest_point = math::function_1243a6cc6a030f2a( ai.origin, box_midpoint, box_bounds, angles );
                dist_to_ai = distance2d( ai.origin, closest_point );
                
                if ( dist_to_ai <= length( utility::flat_origin( ai getboundshalfsize() ) ) )
                {
                    potential_targets[ potential_targets.size ] = ai;
                }
            }
            
            if ( potential_targets.size > 0 )
            {
                closest_target = utility::function_4325398d215ecda5( self.origin, potential_targets );
                
                if ( isdefined( closest_target ) )
                {
                    closest_target zombie_knockdown::function_6fc167d4a3590991( self.origin );
                    closest_target dodamage( slide_damage, self.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_lower" );
                    hit_ai = 1;
                }
            }
            
            /#
                if ( getdvarint( @"hash_3b50b02b325702ce", 0 ) > 0 )
                {
                    debug::function_76204bee46fa39fd( box_midpoint, box_bounds, angles, level.framedurationseconds, ( 0.5, 0, 0 ) );
                    
                    foreach ( ai in potential_targets )
                    {
                        line( ai.origin, self.origin, ( 0.2, 0.4, 0.4 ) );
                    }
                }
            #/
        }
        else if ( !var_9e91c0e43507f9bf )
        {
            hit_ai = 0;
        }
        
        waitframe();
    }
}

// Namespace zm_player
// Params 1, eflags: 0x4
// Checksum 0xd2d74227, Offset: 0x299b
// Size: 0xc6
function private validate_last_closest_player( players )
{
    if ( isdefined( self.var_f7438e491d6dad2e ) && self.var_f7438e491d6dad2e.var_c5841ca9d8c4dcf1 )
    {
        return;
    }
    
    if ( !isdefined( players ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( player.var_c5841ca9d8c4dcf1 )
        {
            self.var_f7438e491d6dad2e = player;
            return;
        }
    }
    
    self.var_f7438e491d6dad2e = undefined;
}

// Namespace zm_player
// Params 2
// Checksum 0x24ed9ee0, Offset: 0x2a69
// Size: 0x9b5
function function_fbbb9b87286ae679( origin, players )
{
    if ( players.size == 0 )
    {
        return;
    }
    
    if ( players.size == 1 && !self.var_38b0bce3cdd3de5b )
    {
        self.var_f7438e491d6dad2e = players[ 0 ];
        self.last_closest_player_dist = distancesquared( players[ 0 ].origin, origin );
        validate_last_closest_player( players[ 0 ] );
        return self.var_f7438e491d6dad2e;
    }
    
    if ( !isdefined( self.var_f7438e491d6dad2e ) )
    {
        self.var_f7438e491d6dad2e = players[ 0 ];
    }
    
    level.var_67e206d97f782e5e = gettime();
    pathfinddata = spawnstruct();
    pathfinddata.origin = origin;
    
    if ( isdefined( self.var_400b17997497977c ) )
    {
        var_d26d0e6cdb8dfcd1 = self [[ self.var_400b17997497977c ]]( origin, players );
        playerpositions = [];
        
        if ( isdefined( var_d26d0e6cdb8dfcd1 ) )
        {
            foreach ( var_859c15e38bfc2898 in var_d26d0e6cdb8dfcd1 )
            {
                if ( isdefined( var_859c15e38bfc2898.origin ) )
                {
                    playerpositions[ playerpositions.size ] = var_859c15e38bfc2898.origin;
                }
            }
        }
        else
        {
            var_d26d0e6cdb8dfcd1 = [];
        }
    }
    else
    {
        playerpositions = [];
        var_d26d0e6cdb8dfcd1 = [];
        
        foreach ( player in players )
        {
            player_pos = player.last_valid_position;
            
            if ( !isdefined( player_pos ) )
            {
                player_pos = getclosestpointonnavmesh( player.origin );
                
                if ( !isdefined( player_pos ) )
                {
                    continue;
                }
            }
            
            if ( isdefined( player_pos ) )
            {
                pos = player_pos;
            }
            else
            {
                pos = player.origin;
            }
            
            playerpositions[ playerpositions.size ] = pos;
            player_ent_num = player getentitynumber();
            
            if ( !( isdefined( self.target_dist_cache ) && isdefined( self.target_dist_cache[ player_ent_num ] ) ) )
            {
                if ( !isdefined( self.target_dist_cache ) )
                {
                    self.target_dist_cache = [];
                }
                
                self.target_dist_cache[ player_ent_num ] = spawnstruct();
                self.target_dist_cache[ player_ent_num ].last_updated = 0;
                self.target_dist_cache[ player_ent_num ].dist = -1;
            }
            
            var_12932aae2240e3fa = spawnstruct();
            var_12932aae2240e3fa.player = player;
            var_12932aae2240e3fa.origin = pos;
            var_d26d0e6cdb8dfcd1[ var_d26d0e6cdb8dfcd1.size ] = var_12932aae2240e3fa;
        }
    }
    
    closestplayer = undefined;
    self.last_closest_player_dist = undefined;
    
    if ( !isdefined( self.target_dist_cache ) )
    {
        self.target_dist_cache = [];
    }
    
    lowest_score = 0;
    var_6e76503b1fe8821b = undefined;
    target_scores = [];
    target_dists = [];
    
    if ( ispointonnavmesh( pathfinddata.origin, self ) )
    {
        var_458471c2021e0957 = -1;
        var_6d5903e2edaff718 = -1;
        
        for ( i = 0; i < var_d26d0e6cdb8dfcd1.size ; i++ )
        {
            var_3d9b7c7a834e6d93 = self.target_dist_cache[ var_d26d0e6cdb8dfcd1[ i ].player getentitynumber() ].last_updated;
            
            if ( var_458471c2021e0957 == -1 || var_3d9b7c7a834e6d93 < var_6d5903e2edaff718 )
            {
                var_6d5903e2edaff718 = var_3d9b7c7a834e6d93;
                var_458471c2021e0957 = i;
            }
            
            target_dists[ i ] = -2;
        }
        
        target_dists[ var_458471c2021e0957 ] = squared( distance( pathfinddata.origin, playerpositions[ var_458471c2021e0957 ] ) );
        
        if ( !isdefined( target_dists ) )
        {
            return;
        }
        
        for ( i = 0; i < target_dists.size ; i++ )
        {
            target = var_d26d0e6cdb8dfcd1[ i ].player;
            target_ent_num = target getentitynumber();
            
            if ( target_dists[ i ] == -2 )
            {
                target_dists[ i ] = self.target_dist_cache[ target_ent_num ].dist;
                continue;
            }
            
            self.target_dist_cache[ target_ent_num ].dist = target_dists[ i ];
            self.target_dist_cache[ target_ent_num ].last_updated = gettime();
        }
        
        target_scores = arraycopy( target_dists );
        smallest_dist = -1;
        closest_target = undefined;
        
        for ( i = 0; i < target_dists.size ; i++ )
        {
            if ( target_dists[ i ] != -1 )
            {
                if ( !isdefined( closest_target ) || smallest_dist > target_dists[ i ] )
                {
                    closest_target = var_d26d0e6cdb8dfcd1[ i ].player;
                    smallest_dist = target_dists[ i ];
                }
            }
        }
        
        if ( !isdefined( closest_target ) )
        {
            return;
        }
        
        for ( i = 0; i < target_dists.size ; i++ )
        {
            potential_target = var_d26d0e6cdb8dfcd1[ i ].player;
            potential_target_ent_num = potential_target getentitynumber();
            
            if ( isdefined( self.damage_by[ potential_target_ent_num ] ) )
            {
                var_eb861cdb2497dca3 = self.damage_by[ potential_target_ent_num ];
                var_dfc99f07c0d8ebc2 = 2;
                
                if ( isdefined( self.var_cabce6ff900c7811 ) )
                {
                    var_dfc99f07c0d8ebc2 = [[ self.var_cabce6ff900c7811 ]]( potential_target, var_eb861cdb2497dca3 );
                }
                
                target_scores[ i ] -= squared( var_eb861cdb2497dca3 * var_dfc99f07c0d8ebc2 );
            }
            
            if ( isdefined( self.var_db25565704fb1f15 ) )
            {
                target_scores[ i ] = [[ self.var_db25565704fb1f15 ]]( potential_target, target_scores[ i ] );
            }
        }
        
        lowest_score = 0;
        var_6e76503b1fe8821b = undefined;
        
        for ( i = 0; i < var_d26d0e6cdb8dfcd1.size ; i++ )
        {
            if ( target_dists[ i ] == -1 )
            {
                continue;
            }
            
            if ( target_scores[ i ] < lowest_score || !isdefined( var_6e76503b1fe8821b ) )
            {
                lowest_score = target_scores[ i ];
                var_6e76503b1fe8821b = var_d26d0e6cdb8dfcd1[ i ].player;
            }
        }
        
        if ( !self.var_4a1de0ed0e631e04 )
        {
            if ( !self.stickiness_flag )
            {
                if ( closest_target == var_6e76503b1fe8821b )
                {
                    self.stickiness_flag = 1;
                    self.var_69eaa80582434027 = gettime() + 3000;
                    self.damage_by = undefined;
                    self.friends_hurt_by = undefined;
                }
                
                self.var_f7438e491d6dad2e = var_6e76503b1fe8821b;
                self.last_closest_player_dist = lowest_score;
            }
            else
            {
                if ( gettime() > self.var_69eaa80582434027 )
                {
                    self.stickiness_flag = 0;
                }
                
                self.var_f7438e491d6dad2e = closest_target;
                self.last_closest_player_dist = smallest_dist;
            }
        }
        else
        {
            self.var_f7438e491d6dad2e = var_6e76503b1fe8821b;
        }
    }
    
    /#
        white = ( 1, 1, 1 );
        green = ( 0, 1, 0 );
        
        if ( getdvarint( @"hash_5c51d0785191bfa7", 0 ) > 0 )
        {
            attacker_text = "<dev string:x169>";
            
            for ( i = 0; i < var_d26d0e6cdb8dfcd1.size ; i++ )
            {
                target = var_d26d0e6cdb8dfcd1[ i ].player;
                score = target_scores[ i ];
                
                if ( isdefined( target ) && isdefined( var_6e76503b1fe8821b ) )
                {
                    if ( var_6e76503b1fe8821b == target )
                    {
                        color = "<dev string:x16a>";
                    }
                    else
                    {
                        color = "<dev string:x16d>";
                    }
                    
                    if ( isdefined( self.friends_hurt_by[ target getentitynumber() ] ) )
                    {
                        var_6ecb68c9f3b788ab = "<dev string:x170>" + self.friends_hurt_by[ target getentitynumber() ];
                    }
                    
                    attacker_text = color + "<dev string:x181>" + target getentitynumber() + "<dev string:x187>" + score;
                }
                else
                {
                    attacker_text = "<dev string:x195>";
                }
                
                record3dtext( attacker_text, self.origin + ( 0, 0, 80 - 30 * i ), white, "<dev string:x1a2>", self, 0.5 );
                
                if ( isdefined( target_dists[ i ] ) )
                {
                    record3dtext( "<dev string:x1a9>" + target_dists[ i ], self.origin + ( 0, 0, 75 - 30 * i ), white, "<dev string:x1a2>", self, 0.5 );
                }
            }
            
            if ( isdefined( self.kia_data ) )
            {
                attacker_text = "<dev string:x169>";
                
                foreach ( attacker in self.kia_data )
                {
                    time_since = ( gettime() - attacker.time ) * 0.001;
                    
                    if ( isdefined( attacker.player ) && isdefined( self.damage_by[ attacker.player getentitynumber() ] ) )
                    {
                        attacker_text += "<dev string:x181>" + attacker.player getentitynumber() + "<dev string:x1b2>" + self.damage_by[ attacker.player getentitynumber() ] + "<dev string:x1b6>" + time_since + "<dev string:x1be>";
                    }
                }
                
                record3dtext( attacker_text, self.origin + ( 0, 0, -20 ), white, "<dev string:x1a2>", self, 0.5 );
            }
            
            if ( self.stickiness_flag )
            {
                record3dtext( "<dev string:x1c0>", self.origin + ( 0, 0, -25 ), green, "<dev string:x1a2>", self, 0.5 );
            }
        }
    #/
    
    validate_last_closest_player( players );
    return self.var_f7438e491d6dad2e;
}

// Namespace zm_player
// Params 0
// Checksum 0x13023366, Offset: 0x3427
// Size: 0x37, Type: bool
function function_c1440cc102ccf1a8()
{
    if ( ( self.is_in_dark_aether || self.is_in_relic_challenge ) && !level.active_relic_challenge.var_f74c6dbea99bce4c )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_player
// Params 0
// Checksum 0x926123d2, Offset: 0x3467
// Size: 0x12, Type: bool
function function_868777c10833a79f()
{
    if ( self.var_42866b061a84f0c6 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_player
// Params 2
// Checksum 0x1d632c7c, Offset: 0x3482
// Size: 0xf1
function setusingremote( remotename, var_a10bd8be831f302c )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !utility::isusingremote() );
    self.usingremote = remotename;
    
    if ( utility::isnightmap() && !game_utility::islargebrmap() )
    {
        val::set( "usingRemote", "nvg", 0 );
    }
    
    val::set( "usingRemote", "vehicle_use", 0 );
    val::set( "usingRemote", "crate_use", 0 );
    val::set( "usingRemote", "offhand_weapons", 0 );
    val::set( "usingRemote", "ads", 0 );
    val::set( "usingRemote", "ascender_use", 0 );
    white_phosphorus::enableloopingcoughaudiosupression();
    self setclientomnvar( "ui_using_killstreak_remote", 1 );
    self notify( #"using_remote" );
}

// Namespace zm_player
// Params 1
// Checksum 0x848a7d20, Offset: 0x357b
// Size: 0x5d
function clearusingremote( bypassweaponswitch )
{
    val::reset_all( "usingRemote" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    self notify( #"stopped_using_remote" );
}

// Namespace zm_player
// Params 1
// Checksum 0x57a36ad9, Offset: 0x35e0
// Size: 0xb7
function on_player_spawned( params )
{
    params.player endon( #"disconnect" );
    wait 1;
    
    if ( params.player.sessionstate === "spectator" )
    {
        return;
    }
    
    xuid = function_fffbd405b1911268( self getxuid() );
    
    if ( isdefined( level.var_30c37b394b9f17cc[ xuid ] ) )
    {
        var_6787895101874fb4 = level.var_30c37b394b9f17cc[ xuid ];
        level.var_30c37b394b9f17cc = function_a5c1175d3ea3c25a( level.var_30c37b394b9f17cc, var_6787895101874fb4 );
        utility::ent_flag_set( "saved_loadout_restored" );
        zm_save::restore_player_state( 2, var_6787895101874fb4 );
        zm_save::function_44611ba14d9004aa( var_6787895101874fb4 );
    }
}

// Namespace zm_player
// Params 1
// Checksum 0xa1de1981, Offset: 0x369f
// Size: 0xdc
function on_loadout_given( params )
{
    if ( !isdefined( self.var_8cf9648fae56099c ) )
    {
        self.var_8cf9648fae56099c = [];
    }
    
    if ( self.loadoutequipmentprimary )
    {
        primaryvariantid = self.classstruct.var_a1191d5606e653f0;
        
        if ( primaryvariantid > 0 )
        {
            self.var_8cf9648fae56099c[ self.loadoutequipmentprimary ] = primaryvariantid;
        }
        else
        {
            self.var_8cf9648fae56099c[ self.loadoutequipmentprimary ] = undefined;
        }
    }
    
    if ( self.loadoutequipmentsecondary )
    {
        secondaryvariantid = self.classstruct.var_9481e959139fe88;
        
        if ( secondaryvariantid > 0 )
        {
            self.var_8cf9648fae56099c[ self.loadoutequipmentsecondary ] = secondaryvariantid;
            return;
        }
        
        self.var_8cf9648fae56099c[ self.loadoutequipmentsecondary ] = undefined;
    }
}

// Namespace zm_player
// Params 1
// Checksum 0x8be7d4d0, Offset: 0x3783
// Size: 0xdd
function save_player_loadout( player )
{
    if ( !isdefined( level.var_ccc5cda60a15cdbd ) )
    {
        level.var_ccc5cda60a15cdbd = 0;
    }
    
    if ( !isdefined( level.var_30c37b394b9f17cc ) )
    {
        level.var_30c37b394b9f17cc = [];
    }
    
    xuid = function_fffbd405b1911268( player getxuid() );
    
    if ( !isdefined( level.var_30c37b394b9f17cc[ xuid ] ) )
    {
        var_9c56ffddfda3aec7 = 8;
        
        if ( level.var_30c37b394b9f17cc.size >= var_9c56ffddfda3aec7 )
        {
            logstring( "ZM Saved Player Loadout Failed To Save: There are " + var_9c56ffddfda3aec7 + " saved loadouts" );
            return;
        }
        
        level.var_30c37b394b9f17cc[ xuid ] = level.var_ccc5cda60a15cdbd;
        level.var_ccc5cda60a15cdbd += 1;
    }
    
    var_6787895101874fb4 = level.var_30c37b394b9f17cc[ xuid ];
    player zm_save::save_player_state( 2, var_6787895101874fb4 );
}

// Namespace zm_player
// Params 0
// Checksum 0xd038a14f, Offset: 0x3868
// Size: 0x4a, Type: bool
function function_ea92f88903bc485()
{
    player = self;
    xuid = function_fffbd405b1911268( player getxuid() );
    
    if ( isdefined( level.var_30c37b394b9f17cc[ xuid ] ) )
    {
        return true;
    }
    
    if ( player utility::ent_flag( "saved_loadout_restored" ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace zm_player
    // Params 0, eflags: 0x4
    // Checksum 0x2b643340, Offset: 0x38bb
    // Size: 0x30, Type: dev
    function private init_player_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1d3>" );
        devgui::add_devgui_func( "<dev string:x1de>", "<dev string:x1f7>", &function_734d1bb3507259d2, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_player
    // Params 1, eflags: 0x4
    // Checksum 0x18eee56e, Offset: 0x38f3
    // Size: 0x1d4, Type: dev
    function private function_734d1bb3507259d2( params )
    {
        while ( true )
        {
            foreach ( player in level.players )
            {
                sample_i = 0;
                col = ( 1, 0.2, 0 );
                var_a5897e2b69798f37 = player.var_a2e61e07c07645cc.size > 1 && player.var_b199182381b5e0bf == 0 ? 3 : player.var_b199182381b5e0bf;
                
                for ( sample_i = 0; sample_i < var_a5897e2b69798f37 ; sample_i++ )
                {
                    var_5d23c7329e0ef31c = player.var_a2e61e07c07645cc[ sample_i ];
                    sphere( var_5d23c7329e0ef31c.origin, 10, col, 1 );
                    print3d( var_5d23c7329e0ef31c.origin + ( 0, 0, 20 ), sample_i, col );
                    
                    if ( sample_i > 0 )
                    {
                        line( var_5d23c7329e0ef31c.origin + ( 0, 0, 1 ), player.var_a2e61e07c07645cc[ sample_i - 1 ].origin, col, 1, 1 );
                    }
                }
                
                if ( isdefined( player.var_b545861f8e52b5ae ) )
                {
                    arrow_length = 200;
                    utility::draw_arrow( player getcentroid(), player getcentroid() + player.var_b545861f8e52b5ae * arrow_length, col, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/
