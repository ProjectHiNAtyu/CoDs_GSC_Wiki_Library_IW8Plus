// scripts\common\ai\aitypes\shared\zombie\zombie_barricade.gsc  (hash_70535825777a53ec.gscc) (size: 3222 Bytes / 0xc96 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x149d8dd2 (345869778)
// size ...... 3222 (0xc96)
// includes .. 3   (offset: 0xc46)
// strings ... 4   (offset: 0xc5e)
// dev strs .. 0   (offset: 0xc96)
// exports ... 13  (offset: 0x79e)
// cseg ...... 0xa7 + 0x6f7 (0x79e)
// imports ... 23  (offset: 0x9a6)
// animtree1 . 0   (offset: 0xc96)
// animtree2 . 0   (offset: 0xc96)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_barricade;

// Namespace zombie_barricade
// Params 0
// Checksum 0x8e154af, Offset: 0xc5
// Size: 0x38
function function_86c3ceda23aed5fc()
{
    if ( !utility::issharedfuncdefined( #"repairable_barricade", #"hash_11d54acd73f87f49" ) )
    {
        return 0;
    }
    
    return utility::callsharedfunc( #"repairable_barricade", #"hash_11d54acd73f87f49" );
}

// Namespace zombie_barricade
// Params 1
// Checksum 0x76a1ba4a, Offset: 0x106
// Size: 0x8d
function get_nearby_barricade( range )
{
    if ( self.barricade_data.barricade )
    {
        return self.barricade_data.barricade;
    }
    
    radius = range ?? 64;
    neg = self getnearbynegotiationinfo( radius );
    
    if ( neg && neg[ "node" ] )
    {
        barricade = neg[ "node" ].barricade;
        
        if ( barricade )
        {
            return barricade;
        }
    }
}

// Namespace zombie_barricade
// Params 0
// Checksum 0xfb5e7d57, Offset: 0x19c
// Size: 0xb
function is_interact_barricade()
{
    return self.is_interact_barricade;
}

// Namespace zombie_barricade
// Params 0
// Checksum 0x25146820, Offset: 0x1b0
// Size: 0x4c
function try_grab()
{
    barricade = self.tear_slot.barricade;
    chunk = barricade utility::callsharedfunc( #"repairable_barricade", #"hash_fc34a846424fd415", "repaired" );
    return chunk;
}

// Namespace zombie_barricade
// Params 1
// Checksum 0x124ad84c, Offset: 0x205
// Size: 0x16a
function start_grab( chunk )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    assert( isdefined( chunk ) );
    self.is_interact_barricade = 1;
    
    if ( !isdefined( self.barricade_data ) )
    {
        self.barricade_data = {};
    }
    
    self.barricade_data.barricade = self.tear_slot.barricade;
    self.barricade_data.chunk = chunk;
    self.barricade_data.var_83b2651228d887a3 = self.tear_slot.slot;
    callback::callback( #"hash_ac987ecfe2199639" );
    callback::add( "on_zombie_ai_killed", &on_killed );
    self waittill( #"zombie_hold_chunk" );
    holdtime = getdvarfloat( @"hash_640eb41785946409", 1 );
    chunk utility::waittill_any_timeout( holdtime, "barricade_chunk_tear_interrupted" );
    callback::callback( #"hash_1422ba4cf377766c" );
    self waittill( #"zombie_pull_chunk_end" );
    self.barricade_data.barricade = undefined;
    self.barricade_data.chunk = undefined;
    callback::remove( "on_zombie_ai_killed", &on_killed );
    self.is_interact_barricade = undefined;
}

// Namespace zombie_barricade
// Params 1, eflags: 0x4
// Checksum 0x648587c, Offset: 0x377
// Size: 0x66
function private on_killed( params )
{
    if ( self.barricade_data.chunk )
    {
        self.barricade_data.chunk notify( #"barricade_chunk_tear_interrupted" );
        self.barricade_data.barricade = undefined;
        self.barricade_data.chunk = undefined;
    }
}

// Namespace zombie_barricade
// Params 2
// Checksum 0xb2048fca, Offset: 0x3e5
// Size: 0x99
function function_7cd4f0bd464a6198( taskid, params )
{
    if ( is_interact_barricade() )
    {
        return anim.success;
    }
    
    if ( self.tear_slot )
    {
        return anim.success;
    }
    
    radius = params ?? 64;
    barricade = get_nearby_barricade( radius );
    
    if ( barricade && barricade utility::callsharedfunc( #"repairable_barricade", #"can_tear" ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_barricade
// Params 2
// Checksum 0x730bc598, Offset: 0x487
// Size: 0x7d
function function_8791ff6ab08ed815( taskid, params )
{
    if ( is_interact_barricade() )
    {
        return anim.failure;
    }
    
    radius = params ?? 64;
    barricade = get_nearby_barricade( radius );
    
    if ( barricade )
    {
        barricade utility::callsharedfunc( #"repairable_barricade", #"hash_7c05e512649ba9e9", self );
        self clearpath();
    }
    
    return anim.success;
}

// Namespace zombie_barricade
// Params 2
// Checksum 0xc6f8292d, Offset: 0x50d
// Size: 0x165
function function_f9fe8d1ef968e84a( taskid, params )
{
    if ( !self.tear_slot )
    {
        return anim.failure;
    }
    
    barricade = self.tear_slot.barricade;
    
    if ( barricade && utility::callsharedfunc( #"repairable_barricade", #"hash_dabdef5bccc668ed", barricade ) )
    {
        return anim.failure;
    }
    
    if ( is_interact_barricade() )
    {
        return anim.running;
    }
    
    if ( self.is_motion_warp )
    {
        return anim.running;
    }
    
    if ( !self.tear_slot.var_3c9e911d6e8e0a88 )
    {
        goal_pos = self.tear_slot.pos;
        goal_angles = self.tear_slot.angles;
        
        if ( !function_c0d89969520b4145( goal_pos ) )
        {
            zombie_utils::update_bt_goal( goal_pos );
        }
        else
        {
            thread function_df69f2c2c17a3d6f( goal_pos, goal_angles );
        }
        
        return anim.running;
    }
    
    if ( self.tear_slot.var_3c9e911d6e8e0a88 )
    {
        chunk = try_grab();
        
        if ( chunk )
        {
            thread start_grab( chunk );
            return anim.running;
        }
    }
    
    return anim.failure;
}

// Namespace zombie_barricade
// Params 2, eflags: 0x4
// Checksum 0x325a6842, Offset: 0x67b
// Size: 0x69
function private function_df69f2c2c17a3d6f( goal_pos, goal_angles )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.is_motion_warp = 1;
    self motionwarp( goal_pos, goal_angles, 200 );
    wait 0.2;
    self.is_motion_warp = undefined;
    self.tear_slot.var_3c9e911d6e8e0a88 = 1;
}

// Namespace zombie_barricade
// Params 1, eflags: 0x4
// Checksum 0x380fa1a5, Offset: 0x6ec
// Size: 0x33, Type: bool
function private function_c0d89969520b4145( goal_pos )
{
    dist_sq = distancesquared( goal_pos, self.origin );
    
    if ( dist_sq > 50 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_barricade
// Params 2
// Checksum 0x9149e34f, Offset: 0x728
// Size: 0x75
function function_c81cef22587fb8e( taskid, params )
{
    if ( self.tear_slot.barricade )
    {
        self.tear_slot.barricade utility::callsharedfunc( #"repairable_barricade", #"hash_be38d7005d1ff3c9", self );
    }
    
    self.is_motion_warp = undefined;
    self.is_interact_barricade = undefined;
    return anim.success;
}

