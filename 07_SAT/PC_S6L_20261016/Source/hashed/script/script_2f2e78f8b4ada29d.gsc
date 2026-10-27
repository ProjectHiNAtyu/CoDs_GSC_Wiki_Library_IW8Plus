// script_2f2e78f8b4ada29d  (hash_2f2e78f8b4ada29d.gscc) (size: 2812 Bytes / 0xafc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7900835f (2030076767)
// size ...... 2812 (0xafc)
// includes .. 3   (offset: 0xa14)
// strings ... 11  (offset: 0xa2c)
// dev strs .. 0   (offset: 0xafc)
// exports ... 7   (offset: 0x6a0)
// cseg ...... 0xf3 + 0x5ad (0x6a0)
// imports ... 16  (offset: 0x7b8)
// animtree1 . 0   (offset: 0xafc)
// animtree2 . 0   (offset: 0xafc)
#using script_aa3bac81ad4fc8e;
#using scripts\common\powerups;
#using scripts\common\system;

#namespace namespace_dd551179d4bb8c8;

// Namespace namespace_dd551179d4bb8c8
// Params 0, eflags: 0x5
// Checksum 0xc5657bda, Offset: 0x111
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "reign_drops", #"bgb", &__init__, undefined );
}

// Namespace namespace_dd551179d4bb8c8
// Params 0
// Checksum 0xdd8da4c2, Offset: 0x136
// Size: 0x21
function __init__()
{
    bgb::register( "reign_drops", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_dd551179d4bb8c8
// Params 0
// Checksum 0xcf53aa23, Offset: 0x15f
// Size: 0x2f5
function activation()
{
    self endon( #"disconnect", #"bled_out" );
    root = powerups::get_powerups_root();
    a_origins = [ get_powerup_origin_grid( 1 ), get_powerup_origin_grid( 2 ), get_powerup_origin_grid( 3 ), get_powerup_origin_grid( 4 ), get_powerup_origin_grid( 5 ), get_powerup_origin_grid( 6 ), get_powerup_origin_grid( 7 ), get_powerup_origin_grid( 8 ), get_powerup_origin_grid( 9 ) ];
    var_9529a4f450c98260 = bgb::function_5e53a4c5e5a4250e( a_origins );
    
    if ( isdefined( root.powerups[ "full_power" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "full_power", get_powerup_origin_grid( 1 ) );
        }
        else
        {
            thread powerups::powerup_activate( "full_power" );
        }
    }
    
    if ( isdefined( root.powerups[ "bonus_points_team" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "bonus_points_team", get_powerup_origin_grid( 2 ) );
        }
        else
        {
            thread powerups::powerup_activate( "bonus_points_team" );
        }
    }
    
    if ( isdefined( root.powerups[ "nuke" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "nuke", get_powerup_origin_grid( 3 ) );
        }
        else
        {
            thread bgb::function_9ecd75f64d86a93f( "nuke", undefined, 1 );
        }
    }
    
    if ( isdefined( root.powerups[ "full_armor" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "full_armor", get_powerup_origin_grid( 4 ) );
        }
        else
        {
            thread powerups::powerup_activate( "full_armor" );
        }
    }
    
    if ( isdefined( root.powerups[ "free_perk" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "free_perk", get_powerup_origin_grid( 5 ) );
        }
        else
        {
            thread powerups::powerup_activate( "free_perk" );
        }
    }
    
    if ( isdefined( root.powerups[ "fire_sale" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "fire_sale", get_powerup_origin_grid( 6 ) );
        }
        else
        {
            thread powerups::powerup_activate( "fire_sale" );
        }
    }
    
    if ( isdefined( root.powerups[ "insta_kill" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "insta_kill", get_powerup_origin_grid( 7 ) );
        }
        else
        {
            thread powerups::powerup_activate( "insta_kill" );
        }
    }
    
    if ( isdefined( root.powerups[ "full_ammo" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "full_ammo", get_powerup_origin_grid( 8 ) );
        }
        else
        {
            thread powerups::powerup_activate( "full_ammo" );
        }
    }
    
    if ( isdefined( root.powerups[ "double_points" ] ) )
    {
        if ( var_9529a4f450c98260 )
        {
            level thread bgb::function_9ecd75f64d86a93f( "double_points", get_powerup_origin_grid( 9 ) );
        }
        else
        {
            thread powerups::powerup_activate( "double_points" );
        }
    }
    
    self.reign_drops_live = 1;
    thread powerup_timeout_watcher();
}

// Namespace namespace_dd551179d4bb8c8
// Params 0
// Checksum 0x8be7e3d1, Offset: 0x45c
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace namespace_dd551179d4bb8c8
// Params 0
// Checksum 0x3f8d944c, Offset: 0x469
// Size: 0x6f
function powerup_timeout_watcher()
{
    waitframe();
    n_start_time = gettime();
    n_total_time = 0;
    
    while ( isdefined( level.active_powerups ) && level.active_powerups.size )
    {
        wait 0.5;
        n_current_time = gettime();
        n_total_time = ( n_current_time - n_start_time ) / 1000;
        
        if ( n_total_time >= 28 )
        {
            break;
        }
    }
    
    self.reign_drops_live = undefined;
}

// Namespace namespace_dd551179d4bb8c8
// Params 1
// Checksum 0xb60b2888, Offset: 0x4e0
// Size: 0x1bf
function get_powerup_origin_grid( var_14d261fa908e3926 )
{
    var_65b05724b1d344d7 = bgb::function_d38deee41dc2c68b();
    v_up = ( 0, 0, 5 );
    v_powerup_2 = var_65b05724b1d344d7 + anglestoforward( self.angles ) * 60 + v_up;
    v_powerup_3 = v_powerup_2 + anglestoforward( self.angles ) * 60 + v_up;
    
    switch ( var_14d261fa908e3926 )
    {
        case 1:
            v_origin = var_65b05724b1d344d7 + anglestoright( self.angles ) * -60 + v_up;
            break;
        case 2:
            v_origin = var_65b05724b1d344d7;
            break;
        case 3:
            v_origin = var_65b05724b1d344d7 + anglestoright( self.angles ) * 60 + v_up;
            break;
        case 4:
            v_origin = v_powerup_2 + anglestoright( self.angles ) * -60 + v_up;
            break;
        case 5:
            v_origin = v_powerup_2;
            break;
        case 6:
            v_origin = v_powerup_2 + anglestoright( self.angles ) * 60 + v_up;
            break;
        case 7:
            v_origin = v_powerup_3 + anglestoright( self.angles ) * -60 + v_up;
            break;
        case 8:
            v_origin = v_powerup_3;
            break;
        case 9:
            v_origin = v_powerup_3 + anglestoright( self.angles ) * 60 + v_up;
            break;
        default:
            v_origin = var_65b05724b1d344d7;
            break;
    }
    
    return v_origin;
}

