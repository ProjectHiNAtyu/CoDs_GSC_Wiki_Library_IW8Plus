// scripts\mp\ob\systems\ob_spectate.gsc  (hash_1539edd625bc1ef0.gscc) (size: 5000 Bytes / 0x1388 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda9fffc6 (3667918790)
// size ...... 5000 (0x1388)
// includes .. 8   (offset: 0x131c)
// strings ... 2   (offset: 0x135c)
// dev strs .. 0   (offset: 0x1388)
// exports ... 16  (offset: 0xb74)
// cseg ...... 0x7a + 0xafa (0xb74)
// imports ... 40  (offset: 0xdf4)
// animtree1 . 0   (offset: 0x1388)
// animtree2 . 0   (offset: 0x1388)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\ob\ob_infils_portal;
#using scripts\mp\playerlogic;

#namespace ob_spectate;

// Namespace ob_spectate
// Params 0, eflags: 0x5
// Checksum 0x7876aab6, Offset: 0x98
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_spectate", undefined, &function_7d730f4c289e66fd, undefined );
}

// Namespace ob_spectate
// Params 0, eflags: 0x4
// Checksum 0xa352307, Offset: 0xb9
// Size: 0x97
function private function_7d730f4c289e66fd()
{
    callback::add( #"player_spawned", &_on_spawned );
    callback::add( #"player_disconnect", &_on_disconnect );
    callback::add( #"player_death", &_on_death );
    callback::add( #"player_leave_squad", &function_3bdbd02e4890d7ef );
    callback::add( #"ob_exfil_success", &_on_exfil );
    callback::add( #"ob_pvp_enabled", &function_fcd08bf551d35709 );
    level.var_87445ca8378539fd = getdvarint( @"hash_b439761b168c3e68", 0 );
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0x5a72f853, Offset: 0x158
// Size: 0x4c
function private _on_spawned( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    params.player.playertospectate = undefined;
    params.player setclientomnvar( "ui_show_spectateHud", -1 );
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0x7744b6f, Offset: 0x1ac
// Size: 0x22
function private _on_disconnect( params )
{
    if ( !self.b_completed_exfil )
    {
        migrate_spectators( self, undefined );
    }
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0x9cfa91c0, Offset: 0x1d6
// Size: 0xb4
function private _on_death( death_data )
{
    if ( _should_skip_spectator( death_data.victim ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_4ff15fd679ad3eba", 1 ) )
    {
        waittillframeend();
    }
    
    if ( utility::issharedfuncdefined( #"ob_activity_locked_in", #"hash_14be8027375a5e11" ) )
    {
        if ( utility::callsharedfunc( #"ob_activity_locked_in", #"hash_14be8027375a5e11", death_data.victim ) )
        {
            return;
        }
    }
    
    migrate_spectators( death_data.victim, death_data );
    
    if ( level.var_bb86f77304f193c4.spectateondeath )
    {
        spawn_spectator( death_data.victim, death_data );
    }
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0x67ad276d, Offset: 0x292
// Size: 0x2d, Type: bool
function private _should_skip_spectator( dying_player )
{
    if ( utility::callsharedfunc( #"pvp_contract", #"hash_7110702dfa987255", dying_player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0xf20bead8, Offset: 0x2c8
// Size: 0x30
function private function_3bdbd02e4890d7ef( params )
{
    if ( !self.b_completed_exfil && !self.disconnecting )
    {
        migrate_spectators( self, undefined );
    }
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0x3541c1ff, Offset: 0x300
// Size: 0x15
function private _on_exfil( params )
{
    migrate_spectators( self, undefined );
}

// Namespace ob_spectate
// Params 1, eflags: 0x4
// Checksum 0x95874ebe, Offset: 0x31d
// Size: 0x1b
function private function_fcd08bf551d35709( params )
{
    setdvar( @"g_spectateonlysquadmembers", 0 );
}

// Namespace ob_spectate
// Params 2
// Checksum 0x50426c2e, Offset: 0x340
// Size: 0x1e6
function spawn_spectator( spectator, death_data )
{
    if ( spectator.spawnedasspectator )
    {
        return;
    }
    
    spectator.spawnedasspectator = 1;
    var_78c287b7f36f9491 = function_d5c69fa2a7c18dab( spectator, death_data.attacker );
    
    if ( function_9f46745add453bb9( var_78c287b7f36f9491 ) && !spectator.b_completed_exfil )
    {
        spectator.playertospectate = var_78c287b7f36f9491;
        spectator allowspectateallteams( 0 );
        spectator allowspectateteam( var_78c287b7f36f9491.team, 1 );
        spectator setclientomnvar( "ui_show_spectateHud", var_78c287b7f36f9491 getentitynumber() );
        spectator spectateclientnum( var_78c287b7f36f9491 getentitynumber(), 1 );
        return;
    }
    
    if ( !spectator.b_completed_exfil && level.var_87445ca8378539fd )
    {
        spectator setclientomnvar( "ui_show_spectateHud", spectator getentitynumber() );
        spectator class::setthirdpersonview();
        return;
    }
    
    spectator setclientomnvar( "ui_show_spectateHud", -1 );
    
    if ( !getdvarint( @"hash_c49a40a4534e6549", 0 ) )
    {
        stopspectateplayer( spectator getentitynumber(), 1 );
        
        if ( spectator.liveragdoll )
        {
            spectator.liveragdoll = 0;
            spectator function_53d446e6e6a7f1ac( 0 );
            spectator function_715e8b27564eeece( 0 );
            spectator stopliveragdoll();
        }
        
        if ( isdefined( spectator.origin ) && isdefined( spectator.angles ) )
        {
            spawnpoint = {};
            spawnpoint.origin = spectator.origin - 64 * anglestoforward( spectator.angles ) + ( 0, 0, 32 );
            spawnpoint.angles = spectator.angles;
            spectator thread playerlogic::spawnintermission( spawnpoint, undefined, 0 );
            return;
        }
        
        spectator thread playerlogic::spawnintermission( undefined, undefined, 0 );
    }
}

// Namespace ob_spectate
// Params 2
// Checksum 0x8f46e52a, Offset: 0x52e
// Size: 0x1a2
function migrate_spectators( spectated_player, death_data )
{
    spectators = get_spectators( spectated_player );
    
    if ( spectators.size == 0 )
    {
        return;
    }
    
    var_78c287b7f36f9491 = function_d5c69fa2a7c18dab( spectated_player, death_data.attacker );
    
    if ( function_9f46745add453bb9( var_78c287b7f36f9491 ) )
    {
        foreach ( spectator in spectators )
        {
            spectator.playertospectate = var_78c287b7f36f9491;
            spectator allowspectateallteams( 0 );
            spectator allowspectateteam( var_78c287b7f36f9491.team, 1 );
            spectator setclientomnvar( "ui_show_spectateHud", var_78c287b7f36f9491 getentitynumber() );
            spectator spectateclientnum( var_78c287b7f36f9491 getentitynumber(), 1 );
        }
        
        return;
    }
    
    foreach ( spectator in spectators )
    {
        spectator setclientomnvar( "ui_show_spectateHud", spectator getentitynumber() );
        stopspectateplayer( spectator getentitynumber(), 1, 0 );
        spectator.playertospectate = undefined;
        spectator class::setthirdpersonview();
    }
}

// Namespace ob_spectate
// Params 1
// Checksum 0x462dfb24, Offset: 0x6d8
// Size: 0x27
function get_spectate_target( spectator )
{
    if ( isdefined( spectator.playertospectate ) )
    {
        return spectator.playertospectate;
    }
}

// Namespace ob_spectate
// Params 1
// Checksum 0xbcbe3612, Offset: 0x708
// Size: 0xb2
function get_spectators( target_player )
{
    spectators = [];
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            spectate_target = get_spectate_target( player );
            
            if ( spectate_target == target_player )
            {
                spectators[ spectators.size ] = player;
            }
        }
    }
    
    return spectators;
}

// Namespace ob_spectate
// Params 1
// Checksum 0x8d2488f5, Offset: 0x7c3
// Size: 0x69, Type: bool
function function_9f46745add453bb9( var_78c287b7f36f9491 )
{
    if ( !isplayer( var_78c287b7f36f9491 ) )
    {
        return false;
    }
    
    if ( var_78c287b7f36f9491.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( !isalive( var_78c287b7f36f9491 ) )
    {
        return false;
    }
    
    if ( var_78c287b7f36f9491.b_completed_exfil )
    {
        return false;
    }
    
    if ( var_78c287b7f36f9491.disconnecting )
    {
        return false;
    }
    
    if ( ob_infils_portal::function_cf564904f7af50b3( var_78c287b7f36f9491 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_spectate
// Params 2
// Checksum 0xb3fe1057, Offset: 0x835
// Size: 0x33e
function function_d5c69fa2a7c18dab( spectator, attacker )
{
    if ( function_9f46745add453bb9( spectator.playertospectate ) )
    {
        var_78c287b7f36f9491 = spectator.playertospectate;
        spectator.playertospectate = undefined;
        return var_78c287b7f36f9491;
    }
    
    squadmates = spectator squad_utility::getsquadmembers( spectator.team );
    
    foreach ( player in squadmates )
    {
        if ( function_9f46745add453bb9( player ) && player != spectator )
        {
            return player;
        }
    }
    
    if ( !utility::callsharedfunc( #"ob_pvp", #"is_enabled" ) )
    {
        return;
    }
    
    teammates = spectator team_utility::getfriendlyplayers( spectator.team );
    
    foreach ( player in teammates )
    {
        if ( function_9f46745add453bb9( player ) && player != spectator )
        {
            return player;
        }
    }
    
    if ( isplayer( attacker ) && attacker != spectator )
    {
        if ( function_9f46745add453bb9( attacker ) )
        {
            return attacker;
        }
        else
        {
            attacker_teammates = attacker team_utility::getfriendlyplayers( attacker.team );
            
            foreach ( player in attacker_teammates )
            {
                if ( function_9f46745add453bb9( player ) )
                {
                    return player;
                }
            }
        }
    }
    
    if ( isplayer( attacker ) && attacker != spectator )
    {
        candidate = attacker;
        checked_candidates = [];
        
        while ( isdefined( candidate ) && !function_9f46745add453bb9( candidate ) && checked_candidates.size < 100 )
        {
            candidate_entnum = candidate getentitynumber();
            
            if ( isdefined( checked_candidates[ candidate_entnum ] ) )
            {
                candidate = undefined;
                break;
            }
            
            checked_candidates[ candidate_entnum ] = candidate;
            candidate = get_spectate_target( candidate );
        }
        
        if ( isdefined( candidate ) )
        {
            return candidate;
        }
    }
    
    foreach ( player in level.players )
    {
        if ( function_9f46745add453bb9( player ) && player != spectator )
        {
            return player;
        }
    }
}

