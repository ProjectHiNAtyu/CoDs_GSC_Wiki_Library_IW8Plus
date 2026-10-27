// script_201ae0c900017e43  (hash_201ae0c900017e43.gscc) (size: 5011 Bytes / 0x1393 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78316a7b (2016504443)
// size ...... 5011 (0x1393)
// includes .. 5   (offset: 0x1213)
// strings ... 16  (offset: 0x123b)
// dev strs .. 8   (offset: 0x1333)
// exports ... 13  (offset: 0xa87)
// cseg ...... 0x15c + 0x92b (0xa87)
// imports ... 47  (offset: 0xc8f)
// animtree1 . 0   (offset: 0x1393)
// animtree2 . 0   (offset: 0x1393)
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_triton_move;

// Namespace zombie_triton_move
// Params 0
// Checksum 0x5ca98617, Offset: 0x17a
// Size: 0x29
function function_6c6968735350f500()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    function_5cc34708f60bbb06();
}

// Namespace zombie_triton_move
// Params 0
// Checksum 0x2d6374f4, Offset: 0x1ab
// Size: 0x34
function init_zombie_triton_move()
{
    self.var_a91bd029284b1261 = getdvarint( @"hash_729aed15f47ed156", 1 );
    self function_786bb6aa1b76c7ee( "triton_stand_turned_once", 0 );
    thread function_64d86a0235778eb5();
    thread function_133f3bd4d5fafdd9();
}

// Namespace zombie_triton_move
// Params 0, eflags: 0x4
// Checksum 0xc84f1b1e, Offset: 0x1e7
// Size: 0xbf
function private function_64d86a0235778eb5()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"stand_turn_start" );
        
        if ( !self getaiblackboarddynamic( "triton_stand_turned_once" ) )
        {
            self function_786bb6aa1b76c7ee( "triton_stand_turned_once", 1 );
        }
        
        self function_786bb6aa1b76c7ee( "triton_is_stand_turning", 1 );
        thread track_target_yaw();
        
        while ( asm::asm_getcurrentstate( self.asmname ) == "stand_turn" )
        {
            waitframe();
        }
        
        msg = utility::waittill_any_timeout( 0.3, "move_exit_start" );
        
        if ( msg == "timeout" )
        {
            thread function_956a84ab29fe11ea();
        }
        
        self function_786bb6aa1b76c7ee( "triton_is_stand_turning", 0 );
        self function_af99635258e79543( 0 );
        self notify( #"stand_turn_end" );
    }
}

// Namespace zombie_triton_move
// Params 0, eflags: 0x4
// Checksum 0xc9f92acb, Offset: 0x2ae
// Size: 0x96
function private function_133f3bd4d5fafdd9()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"move_exit_start" );
        
        if ( self getaiblackboarddynamic( "triton_stand_turned_once" ) )
        {
            self function_786bb6aa1b76c7ee( "triton_stand_turned_once", 0 );
        }
        
        self function_786bb6aa1b76c7ee( "triton_is_move_exit_turning", 1 );
        thread track_target_yaw();
        thread function_956a84ab29fe11ea();
        
        while ( asm::asm_getcurrentstate( self.asmname ) == "move_exit" )
        {
            waitframe();
        }
        
        self function_786bb6aa1b76c7ee( "triton_is_move_exit_turning", 0 );
        self function_af99635258e79543( 0 );
        self notify( #"move_exit_end" );
    }
}

// Namespace zombie_triton_move
// Params 0, eflags: 0x4
// Checksum 0x458b3540, Offset: 0x34c
// Size: 0x35a
function private track_target_yaw()
{
    self endon( #"death" );
    self endon( #"stand_turn_end" );
    self endon( #"move_exit_end" );
    
    if ( isdefined( self.var_8276841ec402381f ) )
    {
        switch ( self.var_8276841ec402381f )
        {
            case #"hash_bdea5e7441323370":
                var_58f8bcda95dfa292 = 100;
                var_6801c72a5ac5528b = 200;
                break;
            case #"hash_9710f96c58beeaaa":
                var_58f8bcda95dfa292 = 50;
                var_6801c72a5ac5528b = 100;
                break;
            case #"hash_eb06fed69a41dab5":
                var_58f8bcda95dfa292 = 40;
                var_6801c72a5ac5528b = 75;
                break;
        }
    }
    
    initangles = self.angles;
    var_db10ab37e6a1831d = anglestoforward( initangles );
    turningright = undefined;
    
    /#
        debugturning = getdvarint( @"hash_b14b21b6dd73bb65", 0 );
    #/
    
    self function_af99635258e79543( 0 );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) )
        {
            targetvelocity = ( 0, 0, 0 );
            
            if ( isdefined( self._blackboard.var_607ff3a73d2aecee ) && self._blackboard.var_607ff3a73d2aecee != ( 0, 0, 0 ) )
            {
                targetvelocity = vectornormalize2( self._blackboard.var_607ff3a73d2aecee );
            }
            else if ( isplayer( self.enemy ) || isagent( self.enemy ) )
            {
                targetvelocity = vectornormalize2( self.enemy getvelocity() );
            }
            
            var_9559484bc2aec9f9 = math::lerp_fraction( -1, 1, vectordot2( var_db10ab37e6a1831d, targetvelocity ) );
            var_ef2239a23e2fe602 = math::lerp( var_6801c72a5ac5528b, var_58f8bcda95dfa292, var_9559484bc2aec9f9 );
            var_cb55cc1cfa69df70 = self.enemy.origin + targetvelocity * var_ef2239a23e2fe602;
            targetyaw = utility::getyaw( var_cb55cc1cfa69df70 ) - initangles[ 1 ];
            targetyaw = angleclamp180( targetyaw );
            
            if ( !isdefined( turningright ) )
            {
                turningright = targetyaw < 0;
            }
            
            if ( turningright && targetyaw > 0 && targetyaw < 90 || !turningright && targetyaw > -90 && targetyaw < 0 )
            {
                targetyaw = 0;
            }
            else if ( turningright && targetyaw > 90 && targetyaw < 180 )
            {
                targetyaw = -180;
            }
            else if ( !turningright && targetyaw > -180 && targetyaw < -90 )
            {
                targetyaw = 180;
            }
            
            self function_af99635258e79543( targetyaw );
            
            /#
                if ( debugturning )
                {
                    print3d( self.origin, "<dev string:x24>" + turningright + "<dev string:x34>" + initangles[ 1 ] + "<dev string:x40>" + targetyaw, ( 1, 0, 0 ), 1, 1, 1, 1 );
                    line( self.origin, self.origin + rotatepointaroundvector( ( 0, 0, 1 ), anglestoforward( initangles ), targetyaw ) * 100, ( 1, 0, 0 ), 1, 0, 10 );
                    sphere( var_cb55cc1cfa69df70, 10, ( 1, 0, 0 ) );
                }
            #/
        }
        
        waitframe();
    }
}

// Namespace zombie_triton_move
// Params 0, eflags: 0x4
// Checksum 0x45a3a924, Offset: 0x6ae
// Size: 0x14c
function private function_956a84ab29fe11ea()
{
    self endon( #"death" );
    utility::waittill_any( "stand_turn_end", "move_exit_end" );
    var_e33b0c873703d7fc = getdvarfloat( @"hash_9e5186ad6822aa03", 1 );
    var_7a5c3cb605fb70cf = getdvarfloat( @"hash_e32162a0e904a530", 0.1 );
    self.var_219f5b51d51c49e0 = self.turnrate;
    
    while ( self.turnrate < var_e33b0c873703d7fc )
    {
        self.turnrate += var_7a5c3cb605fb70cf;
        waitframe();
    }
    
    var_2bcc9741de1748d3 = 0.9;
    
    while ( true )
    {
        forwardvec = anglestoforward( self.angles );
        
        if ( isdefined( self.enemy ) )
        {
            var_5756ae427c8b81b5 = vectornormalize2( self.enemy.origin - self.origin );
        }
        else
        {
            var_28343eb233cd40f = self getpath();
            
            if ( isdefined( var_28343eb233cd40f[ 1 ] ) )
            {
                var_5756ae427c8b81b5 = var_28343eb233cd40f[ 1 ] - self.origin;
            }
            else
            {
                break;
            }
        }
        
        if ( vectordot2( forwardvec, var_5756ae427c8b81b5 ) >= var_2bcc9741de1748d3 )
        {
            break;
        }
        
        waitframe();
    }
    
    self.turnrate = self.var_219f5b51d51c49e0;
}

// Namespace zombie_triton_move
// Params 0, eflags: 0x4
// Checksum 0x62723d59, Offset: 0x802
// Size: 0x5d
function private function_5cc34708f60bbb06()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ) );
}

// Namespace zombie_triton_move
// Params 1
// Checksum 0x25b3efc7, Offset: 0x867
// Size: 0x61
function on_move_speed_changed( params )
{
    self.var_8276841ec402381f = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:x4e>" + self.var_8276841ec402381f, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x63>", self );
    #/
}

// Namespace zombie_triton_move
// Params 1, eflags: 0x4
// Checksum 0x651f7352, Offset: 0x8d0
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace zombie_triton_move
// Params 1, eflags: 0x4
// Checksum 0x3153af81, Offset: 0x905
// Size: 0x90
function private function_83979130715e100f( struct )
{
    alias = "";
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
        
        alias += struct.var_a0ba2bd8aec21d38;
    }
    
    assert( alias != "<dev string:x6a>", "<dev string:x6b>" + self._blackboard.movetype + "<dev string:x8f>" );
    return alias;
}

// Namespace zombie_triton_move
// Params 1, eflags: 0x4
// Checksum 0x5da9a876, Offset: 0x99e
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace zombie_triton_move
// Params 4
// Checksum 0xe102e91a, Offset: 0x9eb
// Size: 0x9b, Type: bool
function function_b32633b91eeeec1c( asmname, statename, tostatename, params )
{
    if ( self getaiblackboarddynamic( "triton_is_stand_turning" ) || self getaiblackboarddynamic( "triton_stand_turned_once" ) || !isdefined( self.enemy ) || distancesquared( self.enemy.origin, self.origin ) > squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.footStompAttackRange ) )
    {
        return false;
    }
    
    return true;
}

