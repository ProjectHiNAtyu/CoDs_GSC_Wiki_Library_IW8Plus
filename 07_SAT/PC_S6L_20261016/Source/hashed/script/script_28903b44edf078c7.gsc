// script_28903b44edf078c7  (hash_28903b44edf078c7.gscc) (size: 3012 Bytes / 0xbc4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8ad5dc7 (3098369479)
// size ...... 3012 (0xbc4)
// includes .. 5   (offset: 0xaa8)
// strings ... 10  (offset: 0xad0)
// dev strs .. 7   (offset: 0xb70)
// exports ... 8   (offset: 0x628)
// cseg ...... 0xcf + 0x559 (0x628)
// imports ... 28  (offset: 0x768)
// animtree1 . 0   (offset: 0xbc4)
// animtree2 . 0   (offset: 0xbc4)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_aafbaa6bf95d91a9;

// Namespace namespace_aafbaa6bf95d91a9
// Params 0
// Checksum 0xc7618634, Offset: 0xed
// Size: 0xa8
function register_move_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "wander" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ), 2 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ), 2 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "super_sprint" ), 2 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( undefined ) );
}

// Namespace namespace_aafbaa6bf95d91a9
// Params 0
// Checksum 0xc2e7de17, Offset: 0x19d
// Size: 0x6c
function init_dawg_move()
{
    callback::add( "on_move_speed_changed", &function_45e0b45eece3213a );
    self.turnanimsenabled = 1;
    self.var_6c4d911c54477656 = self.dawgaisettings.var_6c4d911c54477656;
    self.var_c245801ce039379a = self.dawgaisettings.var_c245801ce039379a;
    self._blackboard.var_224d529c5512a171 = 1;
}

// Namespace namespace_aafbaa6bf95d91a9
// Params 3
// Checksum 0x4e4bb331, Offset: 0x211
// Size: 0x2c6
function function_a8ce00e0448cb6f0( move_speed_value, id, priority )
{
    assert( utility::ent_flag( "<dev string:x24>" ), "<dev string:x35>" );
    
    if ( !isdefined( id ) )
    {
        id = "default";
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 0;
    }
    
    if ( !isdefined( self.var_3e434da475d20265 ) )
    {
        self.var_3e434da475d20265 = [];
    }
    
    if ( isdefined( move_speed_value ) )
    {
        target_speed = getanimspeedthreshold( self, move_speed_value );
        
        if ( !isdefined( target_speed ) )
        {
            return;
        }
    }
    
    move_speed_struct = spawnstruct();
    move_speed_struct.id = id;
    move_speed_struct.move_speed_value = move_speed_value;
    move_speed_struct.priority = priority;
    
    for ( i = 0; i < self.var_3e434da475d20265.size ; i++ )
    {
        current = self.var_3e434da475d20265[ i ];
        
        if ( isdefined( current ) && current.id == id )
        {
            self.var_3e434da475d20265[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( self.var_3e434da475d20265 );
            }
            
            break;
        }
    }
    
    var_abe85f5f715a6eb5 = 0;
    
    if ( isdefined( move_speed_value ) )
    {
        for ( i = 0; i < self.var_3e434da475d20265.size ; i++ )
        {
            current = self.var_3e434da475d20265[ i ];
            
            if ( !isdefined( current ) || current.priority < priority )
            {
                continue;
            }
            
            if ( current.priority == priority )
            {
                assertmsg( "<dev string:x7a>" + current.id + "<dev string:xb0>" + id + "<dev string:xbf>" );
                arrayinsert( self.var_3e434da475d20265, move_speed_struct, i + 1 );
                var_abe85f5f715a6eb5 = 1;
            }
            else if ( current.priority > priority )
            {
                arrayinsert( self.var_3e434da475d20265, move_speed_struct, i );
                var_abe85f5f715a6eb5 = 1;
            }
            
            break;
        }
        
        if ( !var_abe85f5f715a6eb5 )
        {
            var_abe85f5f715a6eb5 = 1;
            self.var_3e434da475d20265[ self.var_3e434da475d20265.size ] = move_speed_struct;
        }
    }
    
    if ( isarray( self.var_3e434da475d20265 ) && isstruct( self.var_3e434da475d20265[ self.var_3e434da475d20265.size - 1 ] ) )
    {
        var_2479fec584964cf0 = self.var_3e434da475d20265[ self.var_3e434da475d20265.size - 1 ].move_speed_value;
        
        if ( !asm_bb::bb_movetyperequested( var_2479fec584964cf0 ) )
        {
            asm_bb::bb_requestmovetype( var_2479fec584964cf0 );
            target_speed = getanimspeedthreshold( self, var_2479fec584964cf0 );
            
            if ( isdefined( target_speed ) )
            {
                self aisetdesiredspeed( target_speed );
                self aisettargetspeed( target_speed );
                callback::callback( "on_move_speed_changed" );
            }
        }
    }
}

// Namespace namespace_aafbaa6bf95d91a9
// Params 1, eflags: 0x4
// Checksum 0xac0c06f1, Offset: 0x4df
// Size: 0x5d
function private function_45e0b45eece3213a( params )
{
    var_4dd9c210b998e030 = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:xf2>" + var_4dd9c210b998e030, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x107>", self );
    #/
}

// Namespace namespace_aafbaa6bf95d91a9
// Params 1, eflags: 0x4
// Checksum 0x5be14ef4, Offset: 0x544
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_aafbaa6bf95d91a9
// Params 1, eflags: 0x4
// Checksum 0xf42083f8, Offset: 0x579
// Size: 0x61
function private function_83979130715e100f( struct )
{
    alias = "";
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        alias += struct.var_a0ba2bd8aec21d38;
        
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
    }
    
    return alias;
}

// Namespace namespace_aafbaa6bf95d91a9
// Params 1, eflags: 0x4
// Checksum 0x635795d0, Offset: 0x5e3
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

