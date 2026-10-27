// scripts\mp\bots\bots_killstreaks.gsc  (hash_347c8a067853b721.gscc) (size: 4971 Bytes / 0x136b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7c5108d (3620016269)
// size ...... 4971 (0x136b)
// includes .. 5   (offset: 0x1223)
// strings ... 22  (offset: 0x124b)
// dev strs .. 0   (offset: 0x136b)
// exports ... 17  (offset: 0xb67)
// cseg ...... 0x185 + 0x9e2 (0xb67)
// imports ... 33  (offset: 0xe0f)
// animtree1 . 0   (offset: 0x136b)
// animtree2 . 0   (offset: 0x136b)
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\bots\bots_sentry;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace bots_killstreaks;

// Namespace bots_killstreaks
// Params 0
// Checksum 0xf14d73f8, Offset: 0x1a3
// Size: 0x9b
function bot_killstreak_setup()
{
    bot_register_killstreak_func( "radar_ping", &bot_killstreak_simple_use );
    bot_register_killstreak_func( "skewer", &bot_killstreak_simple_use );
    bot_register_killstreak_func( "uav", &bot_killstreak_simple_use );
    bot_register_killstreak_func( "counter_uav", &bot_killstreak_simple_use );
    bot_register_killstreak_func( "airdrop_escort", &bot_killstreak_simple_use );
    bot_register_killstreak_func( "ground_drone_unit", &bot_killstreak_simple_use );
    bot_register_killstreak_func( "airdrop", &bot_killstreak_drop_outside );
    bot_register_killstreak_func( "dawg", &bot_killstreak_drop_outside );
    bot_register_killstreak_func( "remote_turret", &bot_killstreak_sentry );
}

// Namespace bots_killstreaks
// Params 3
// Checksum 0x85a1cd66, Offset: 0x246
// Size: 0x6e
function bot_register_killstreak_func( name, func, can_use )
{
    if ( !isdefined( level.var_44c933670937057d ) )
    {
        level.var_44c933670937057d = [];
    }
    
    streakdata = spawnstruct();
    streakdata.func = func;
    streakdata.can_use = can_use;
    level.var_44c933670937057d[ name ] = streakdata;
}

// Namespace bots_killstreaks
// Params 1
// Checksum 0xc679b139, Offset: 0x2bc
// Size: 0x2a, Type: bool
function bot_is_killstreak_supported( name )
{
    if ( !isdefined( name ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_44c933670937057d[ name ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_killstreaks
// Params 1
// Checksum 0xeee26c49, Offset: 0x2ef
// Size: 0x3d
function bot_can_use_killstreak( name )
{
    can_use_killstreak_function = level.var_44c933670937057d[ name ].can_use;
    
    if ( !isdefined( can_use_killstreak_function ) )
    {
        return 1;
    }
    
    return self [[ can_use_killstreak_function ]]();
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0x175eef2e, Offset: 0x335
// Size: 0x54
function bot_use_killstreak( killstreak_info, killstreak_slot )
{
    use_function = level.var_44c933670937057d[ killstreak_info.streakname ].func;
    assert( isdefined( use_function ) );
    self [[ use_function ]]( killstreak_info, killstreak_slot );
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0xabe6c552, Offset: 0x391
// Size: 0x1f
function bot_switch_to_killstreak_weapon( killstreak_info, killstreak_slot )
{
    thread killstreaks::triggerkillstreak( killstreak_info, killstreak_slot );
}

// Namespace bots_killstreaks
// Params 0
// Checksum 0xf59f2a23, Offset: 0x3b8
// Size: 0x18f
function bot_think_killstreak()
{
    self notify( #"bot_think_killstreak" );
    self endon( #"bot_think_killstreak" );
    self endon( #"death_or_disconnect" );
    self endon( #"exit_autopilot" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait randomfloatrange( 1, 2 );
        killstreaks_array = self.streakdata.streaks;
        
        if ( !isdefined( killstreaks_array ) || killstreaks_array.size == 0 )
        {
            continue;
        }
        
        if ( !bots_util_mp::bot_allowed_to_use_killstreaks() )
        {
            continue;
        }
        
        foreach ( killstreak_slot, killstreak_info in killstreaks_array )
        {
            if ( !isdefined( killstreak_info ) )
            {
                continue;
            }
            
            if ( !isdefined( killstreak_info.streakname ) )
            {
                continue;
            }
            
            if ( killstreak_info.available == 1 )
            {
                if ( !bot_is_killstreak_supported( killstreak_info.streakname ) )
                {
                    continue;
                }
                
                if ( !bot_can_use_killstreak( killstreak_info.streakname ) )
                {
                    continue;
                }
                
                wait randomintrange( 2, 6 );
                
                if ( !bots_util_mp::bot_allowed_to_use_killstreaks() || !bot_can_use_killstreak( killstreak_info.streakname ) )
                {
                    break;
                }
                
                bot_use_killstreak( killstreak_info, killstreak_slot );
            }
        }
    }
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0xb755eb1e, Offset: 0x54f
// Size: 0x1f
function bot_killstreak_simple_use( killstreak_info, killstreak_slot )
{
    bot_switch_to_killstreak_weapon( killstreak_info, killstreak_slot );
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0x93cb20c3, Offset: 0x576
// Size: 0x24
function bot_killstreak_drop_anywhere( killstreak_info, killstreak_slot )
{
    bot_killstreak_drop( killstreak_info, killstreak_slot, "anywhere" );
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0x1ab600c, Offset: 0x5a2
// Size: 0x24
function bot_killstreak_drop_outside( killstreak_info, killstreak_slot )
{
    bot_killstreak_drop( killstreak_info, killstreak_slot, "outside" );
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0xb36534c0, Offset: 0x5ce
// Size: 0x24
function bot_killstreak_drop_hidden( killstreak_info, killstreak_slot )
{
    bot_killstreak_drop( killstreak_info, killstreak_slot, "hidden" );
}

// Namespace bots_killstreaks
// Params 3
// Checksum 0xb152614a, Offset: 0x5fa
// Size: 0x276
function bot_killstreak_drop( killstreak_info, killstreak_slot, drop_where = "anywhere" )
{
    tacpoint_target = undefined;
    
    if ( drop_where == "outside" )
    {
        outside_tacpoints = [];
        var_713659199552a321 = bots_util::function_785b7ca2538863b0( 0, 750, 0.6, 1 );
        
        foreach ( tacpoint in var_713659199552a321 )
        {
            if ( tacpointexposedtosky( tacpoint ) )
            {
                outside_tacpoints[ outside_tacpoints.size ] = tacpoint;
            }
        }
        
        if ( var_713659199552a321.size > 5 && outside_tacpoints.size > var_713659199552a321.size * 0.6 )
        {
            outside_tacpoints_sorted = utility::get_array_of_closest( self.origin, outside_tacpoints, undefined, undefined, undefined, 150 );
            
            if ( outside_tacpoints_sorted.size > 0 )
            {
                tacpoint_target = utility::array_random( outside_tacpoints_sorted );
            }
            else
            {
                tacpoint_target = utility::array_random( outside_tacpoints );
            }
        }
    }
    else if ( drop_where == "hidden" )
    {
        tacpoints_in_radius = function_a034a927128ada11( self.origin, 256, 0, 40 );
        var_ee2b73b69a2b2e6f = self getnearesttacpoint();
        
        if ( isdefined( var_ee2b73b69a2b2e6f ) )
        {
            var_6255622f2cc1e7b9 = [];
            
            foreach ( tacpoint in tacpoints_in_radius )
            {
                if ( tacpointsvisible( var_ee2b73b69a2b2e6f, tacpoint ) )
                {
                    var_6255622f2cc1e7b9[ var_6255622f2cc1e7b9.size ] = tacpoint;
                }
            }
            
            tacpoint_target = bots_util::function_ec1247a9311f67a4( "bot_killstreak_drop -> hide", var_6255622f2cc1e7b9, 1, "hide" );
        }
    }
    
    if ( isdefined( tacpoint_target ) || drop_where == "anywhere" )
    {
        self botsetflag( "disable_movement", 1 );
        
        if ( isdefined( tacpoint_target ) )
        {
            self botlookatpoint( tacpoint_target.groundpos, 2.45, "script_forced" );
        }
        
        bot_switch_to_killstreak_weapon( killstreak_info, killstreak_slot );
        wait 2;
        self botpressbutton( "attack" );
        wait 1.5;
        self botsetflag( "disable_movement", 0 );
    }
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0x19e2d884, Offset: 0x878
// Size: 0x24
function bot_killstreak_sentry( killstreak_info, killstreak_slot )
{
    bots_sentry::function_8df6526373cd03ae( killstreak_info, killstreak_slot, "turret" );
}

// Namespace bots_killstreaks
// Params 0
// Checksum 0xe2515af7, Offset: 0x8a4
// Size: 0x1ad
function bot_think_watch_aerial_killstreak()
{
    self notify( #"bot_think_watch_aerial_killstreak" );
    self endon( #"bot_think_watch_aerial_killstreak" );
    self endon( #"bot_suspended" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.last_global_badplace_time ) )
    {
        level.last_global_badplace_time = -10000;
    }
    
    level.killstreak_global_bp_exists_for[ "allies" ] = [];
    level.killstreak_global_bp_exists_for[ "axis" ] = [];
    currently_hiding = 0;
    next_wait_time = randomfloatrange( 0.05, 4 );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait next_wait_time;
        next_wait_time = randomfloatrange( 0.05, 4 );
        assert( !isdefined( level.remote_mortar ) );
        
        if ( bots_util::bot_is_remote_or_linked() )
        {
            continue;
        }
        
        if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
        {
            continue;
        }
        
        var_5e5d723ffd290cb6 = 0;
        
        if ( isdefined( level.chopper ) && level.chopper.team != self.team )
        {
            var_5e5d723ffd290cb6 = 1;
        }
        
        if ( isdefined( level.lbsniper ) && level.lbsniper.team != self.team )
        {
            var_5e5d723ffd290cb6 = 1;
        }
        
        if ( !currently_hiding && var_5e5d723ffd290cb6 )
        {
            currently_hiding = 1;
            self botsetflag( "hide_indoors", 1 );
        }
        
        if ( currently_hiding && !var_5e5d723ffd290cb6 )
        {
            currently_hiding = 0;
            self botsetflag( "hide_indoors", 0 );
        }
    }
}

// Namespace bots_killstreaks
// Params 2
// Checksum 0x453b9700, Offset: 0xa59
// Size: 0x8d
function try_place_global_badplace( killstreak_unique_name, var_881d51f3ee0dc760 )
{
    if ( !isdefined( level.killstreak_global_bp_exists_for[ self.team ][ killstreak_unique_name ] ) )
    {
        level.killstreak_global_bp_exists_for[ self.team ][ killstreak_unique_name ] = 0;
    }
    
    if ( !level.killstreak_global_bp_exists_for[ self.team ][ killstreak_unique_name ] )
    {
        level.killstreak_global_bp_exists_for[ self.team ][ killstreak_unique_name ] = 1;
        level thread monitor_enemy_dangerous_killstreak( self.team, killstreak_unique_name, var_881d51f3ee0dc760 );
    }
}

// Namespace bots_killstreaks
// Params 3
// Checksum 0xee311b71, Offset: 0xaee
// Size: 0x79
function monitor_enemy_dangerous_killstreak( my_team, killstreak_unique_name, var_881d51f3ee0dc760 )
{
    assert( -1 );
    wait_time = 0.5;
    
    while ( [[ var_881d51f3ee0dc760 ]]( my_team ) )
    {
        if ( gettime() > level.last_global_badplace_time + 4000 )
        {
            level.last_global_badplace_time = gettime();
        }
        
        wait wait_time;
    }
    
    level.killstreak_global_bp_exists_for[ my_team ][ killstreak_unique_name ] = 0;
}

