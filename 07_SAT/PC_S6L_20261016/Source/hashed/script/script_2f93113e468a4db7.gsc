// script_2f93113e468a4db7  (hash_2f93113e468a4db7.gscc) (size: 3593 Bytes / 0xe09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4ab37c8 (4104861640)
// size ...... 3593 (0xe09)
// includes .. 6   (offset: 0xd0d)
// strings ... 12  (offset: 0xd3d)
// dev strs .. 0   (offset: 0xe09)
// exports ... 12  (offset: 0x725)
// cseg ...... 0x10b + 0x61a (0x725)
// imports ... 35  (offset: 0x905)
// animtree1 . 0   (offset: 0xe09)
// animtree2 . 0   (offset: 0xe09)
#using script_ac28d65e8605696;
#using script_e92a9717969a5cd;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;

#namespace europa_revive_teammate;

// Namespace europa_revive_teammate
// Params 0, eflags: 0x5
// Checksum 0xd8ba55ca, Offset: 0x129
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa_revive_teammate", undefined, undefined, &post_main );
}

// Namespace europa_revive_teammate
// Params 0
// Checksum 0x1028acea, Offset: 0x14a
// Size: 0x5a
function post_main()
{
    callback::add( #"hash_7e3a7d30f11f29e6", &init_cool_down );
    callback::add( #"europa_activated", &on_europa_activated );
    callback::add( europa::function_a4859357bdc15f92( "revive_teammate" ), &function_9cf064397d106f67 );
    callback::add( europa::function_8d0b7818fc98dbab( "revive_teammate" ), &function_d34e9097a2667862 );
}

// Namespace europa_revive_teammate
// Params 1, eflags: 0x4
// Checksum 0x4b86483c, Offset: 0x1ac
// Size: 0x43
function private init_cool_down( params )
{
    revivecooldown = self.aisettings.specificaisettings.revivecooldown;
    europa::register_cool_down( "revive_teammate", revivecooldown );
}

// Namespace europa_revive_teammate
// Params 1, eflags: 0x4
// Checksum 0xe11b3d4d, Offset: 0x1f7
// Size: 0x36
function private on_europa_activated( params )
{
    self.europa.reviving_teammate = 0;
    self.europa.revive_teammate_count = 0;
}

// Namespace europa_revive_teammate
// Params 1, eflags: 0x4
// Checksum 0x503327c2, Offset: 0x235
// Size: 0x1f
function private function_9cf064397d106f67( params )
{
    val::set( "revive_teammate", "ignoreall", 1 );
}

// Namespace europa_revive_teammate
// Params 1, eflags: 0x4
// Checksum 0xfddebd81, Offset: 0x25c
// Size: 0x1e
function private function_d34e9097a2667862( params )
{
    val::set( "revive_teammate", "ignoreall", 0 );
}

// Namespace europa_revive_teammate
// Params 0
// Checksum 0xae26ff48, Offset: 0x282
// Size: 0x6c, Type: bool
function can_revive_teammate()
{
    if ( !europa::is_activated() )
    {
        return false;
    }
    
    if ( europa::has_cool_down( "revive_teammate" ) )
    {
        return false;
    }
    
    revivecount = self.aisettings.specificaisettings.revivetimes;
    
    if ( revivecount > 0 && self.europa.revive_teammate_count >= revivecount )
    {
        return false;
    }
    
    return true;
}

// Namespace europa_revive_teammate
// Params 1
// Checksum 0x1ccd3217, Offset: 0x2f7
// Size: 0x1a7
function function_b4770470c58d200d( taskid )
{
    if ( !isdefined( self.europa.reviving_teammate ) )
    {
        self.europa.reviving_teammate = 0;
    }
    
    if ( self.europa.reviving_teammate )
    {
        return 50;
    }
    
    if ( !can_revive_teammate() )
    {
        return 0;
    }
    
    besttarget = undefined;
    var_c3d5d88c0201f678 = self.aisettings.specificaisettings.var_c3d5d88c0201f678;
    assert( var_c3d5d88c0201f678 > 0 );
    var_ea8d2af17a0b7a93 = squared( var_c3d5d88c0201f678 );
    
    foreach ( player in level.players )
    {
        if ( europa::is_target_in_last_stand( player ) && !player.beingrevived && !player.isselfreviving )
        {
            distancesq = distancesquared( self.origin, player.origin );
            
            if ( player == europa::function_b8c0ff578e3412( "owner" ) )
            {
                distancesq -= 10000;
            }
            
            if ( distancesq < var_ea8d2af17a0b7a93 )
            {
                var_ea8d2af17a0b7a93 = distancesq;
                besttarget = player;
            }
        }
    }
    
    if ( isdefined( besttarget ) )
    {
        europa::set_target( "revive_teammate", besttarget );
        return 50;
    }
    
    return 0;
}

// Namespace europa_revive_teammate
// Params 1
// Checksum 0xc32699d0, Offset: 0x4a7
// Size: 0x65
function europa_revivestart( taskid )
{
    target = europa::function_b8c0ff578e3412( "revive_teammate" );
    
    if ( !isplayer( target ) || !europa::is_target_in_last_stand( target ) )
    {
        return anim.failure;
    }
    
    europa::clear_goal_pos();
    self setlookatpos( target.origin );
    return anim.success;
}

// Namespace europa_revive_teammate
// Params 1
// Checksum 0x7c7092d2, Offset: 0x515
// Size: 0x172
function europa_reviveupdate( taskid )
{
    target = europa::function_b8c0ff578e3412( "revive_teammate" );
    
    if ( !isplayer( target ) )
    {
        return anim.failure;
    }
    
    europa::clear_goal_pos();
    
    if ( !europa::is_target_in_last_stand( target ) )
    {
        return anim.failure;
    }
    
    if ( !europa::is_facing_point( target.origin, 15 ) )
    {
        self orientmode( "face point", target.origin );
        return anim.running;
    }
    
    if ( europa::is_script_animation() )
    {
        return anim.running;
    }
    
    if ( !self.europa.reviving_teammate && target.laststandreviveent )
    {
        if ( target.beingrevived )
        {
            return anim.failure;
        }
        
        thread europa::play_vo( "revive_teammate" );
        self.europa.reviving_teammate = 1;
        val::set( "europa_revive", "script_pushable", 0 );
        val::set( "europa_revive", "script_pushable_by_ai", 0 );
        val::set( "europa_revive", "toggle_remote_revive", 1 );
        target.laststandreviveent notify( #"trigger", self );
        thread europa_asm::play_scripted_anim( "revive_other" );
        utility::function_32b24db3127bff40( "revive", "on" );
    }
    
    return anim.running;
}

// Namespace europa_revive_teammate
// Params 2
// Checksum 0x5bb5ad2a, Offset: 0x690
// Size: 0x94
function europa_reviveend( taskid, param )
{
    europa::clear_goal_pos();
    
    if ( self.europa.reviving_teammate )
    {
        utility::function_32b24db3127bff40( "revive", "off" );
        europa_asm::function_4d732b0c87bec23e();
        val::reset( "europa_revive" );
        self.europa.reviving_teammate = 0;
        europa::start_cool_down( "revive_teammate" );
        self.europa.revive_teammate_count++;
    }
    
    return anim.success;
}

