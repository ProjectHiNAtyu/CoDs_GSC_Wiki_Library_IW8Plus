// scripts\common\ai\aitypes\shared\zombie\zombie_float_move.gsc  (hash_4870ef382a8cb8b5.gscc) (size: 1124 Bytes / 0x464 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20af6518 (548365592)
// size ...... 1124 (0x464)
// includes .. 1   (offset: 0x434)
// strings ... 3   (offset: 0x43c)
// dev strs .. 0   (offset: 0x464)
// exports ... 4   (offset: 0x254)
// cseg ...... 0x81 + 0x1d3 (0x254)
// imports ... 11  (offset: 0x2f4)
// animtree1 . 0   (offset: 0x464)
// animtree2 . 0   (offset: 0x464)
#using script_ac32c5a74321662;

#namespace zombie_float_move;

// Namespace zombie_float_move
// Params 2
// Checksum 0xa439224d, Offset: 0x9f
// Size: 0xb9
function function_eb224126b23f84da( taskid, params )
{
    if ( !self._blackboard.var_2ae163fc4d461251 )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "in_float_move" ) )
    {
        namespace_7143065cf1b062e3::clear_float_move();
    }
    
    float_move_goal = self._blackboard.var_2ccb0e03a4937933;
    float_move_speed = undefined;
    
    if ( isfloat( params ) )
    {
        float_move_speed = params;
    }
    else if ( isstring( params ) )
    {
        float_move_speed = self getaiblackboarddynamic( params );
    }
    
    self clearpath();
    self setbtgoalpos( 0, float_move_goal );
    namespace_7143065cf1b062e3::function_dce35a336383305c( float_move_goal, float_move_speed, 0 );
    return anim.success;
}

// Namespace zombie_float_move
// Params 2
// Checksum 0x7f6bb137, Offset: 0x161
// Size: 0xaf
function function_7ac8b4c83dc8549( taskid, params )
{
    if ( self getaiblackboarddynamic( "in_float_move" ) )
    {
        self animmode( "noclip" );
        
        if ( isdefined( self.float_move_info ) )
        {
            next_point_index = int( min( self.float_move_info.current_index + 1, self.float_move_info.points.size - 1 ) );
            self orientmode( "face point", self.float_move_info.points[ next_point_index ] );
        }
        
        return anim.running;
    }
    
    return anim.success;
}

// Namespace zombie_float_move
// Params 2
// Checksum 0xf161498f, Offset: 0x219
// Size: 0x3a
function function_6d90bac3a6bf0b07( taskid, params )
{
    self._blackboard.var_2ae163fc4d461251 = 0;
    namespace_7143065cf1b062e3::clear_float_move();
    return anim.success;
}

