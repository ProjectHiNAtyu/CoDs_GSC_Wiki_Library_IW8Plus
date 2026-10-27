// scripts\mp\zm\systems\aitypes\zm_soldier.gsc  (hash_55a193a2fc75c469.gscc) (size: 2213 Bytes / 0x8a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40f1c8f9 (1089587449)
// size ...... 2213 (0x8a5)
// includes .. 3   (offset: 0x7bd)
// strings ... 16  (offset: 0x7d5)
// dev strs .. 0   (offset: 0x8a5)
// exports ... 11  (offset: 0x431)
// cseg ...... 0x14c + 0x2e5 (0x431)
// imports ... 15  (offset: 0x5e9)
// animtree1 . 0   (offset: 0x8a5)
// animtree2 . 0   (offset: 0x8a5)
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zm_soldier;

// Namespace zm_soldier
// Params 2
// Checksum 0x7ff6b521, Offset: 0x16a
// Size: 0x73
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_6ddb6d5dcb5a8089 ) )
    {
        return;
    }
    
    level.var_6ddb6d5dcb5a8089 = 1;
    level callback::add( "on_agent_spawned", &agent_on_spawned );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    level callback::add( "on_first_ai_init", &function_c1a9f2d8a6f0a5db );
    
    /#
        level thread function_f2a8748a6122ebcf();
    #/
}

// Namespace zm_soldier
// Params 1
// Checksum 0x70ff95e3, Offset: 0x1e5
// Size: 0xb1
function function_c1a9f2d8a6f0a5db( params )
{
    if ( self.type != "human" )
    {
        return;
    }
    
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_fa079b82404a08c );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_db704ea8f19d10ce );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_938174989e9c9cc0 );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_6ea027ea7a0152ad );
    level callback::remove( "on_first_ai_init", &function_c1a9f2d8a6f0a5db );
}

// Namespace zm_soldier
// Params 1
// Checksum 0x3997b046, Offset: 0x29e
// Size: 0x49
function agent_on_spawned( params )
{
    agent = params.agent;
    
    if ( agent.unittype != "soldier" )
    {
        return;
    }
    
    agent.var_7f8ab9bb9f4957fc = &function_e4807244fa5b22cc;
}

// Namespace zm_soldier
// Params 1
// Checksum 0x9a07e46e, Offset: 0x2ef
// Size: 0xc
function function_9238338f068b6568( params )
{
    
}

// Namespace zm_soldier
// Params 1
// Checksum 0xcb00ec5, Offset: 0x303
// Size: 0x60
function function_fa079b82404a08c( params )
{
    self._blackboard.isburning = 1;
    
    if ( self.damageyaw > 0 )
    {
        self.burningdirection = "right";
    }
    else
    {
        self.burningdirection = "left";
    }
    
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_on" );
}

// Namespace zm_soldier
// Params 1
// Checksum 0x2475662c, Offset: 0x36b
// Size: 0x26
function function_db704ea8f19d10ce( params )
{
    level ai::remove_blackboard_isburning( self );
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zm_soldier
// Params 1, eflags: 0x4
// Checksum 0xe87a528a, Offset: 0x399
// Size: 0x1d
function private function_938174989e9c9cc0( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zm_soldier
// Params 1, eflags: 0x4
// Checksum 0x614408fb, Offset: 0x3be
// Size: 0x1d
function private function_6ea027ea7a0152ad( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
}

// Namespace zm_soldier
// Params 5
// Checksum 0x9db3f604, Offset: 0x3e3
// Size: 0x40
function function_e4807244fa5b22cc( idamage, eattacker, objweapon, smeansofdeath, vpoint )
{
    if ( smeansofdeath == "MOD_MELEE" )
    {
        return 10;
    }
    
    return idamage;
}

/#

    // Namespace zm_soldier
    // Params 0, eflags: 0x4
    // Checksum 0xb288520c, Offset: 0x42c
    // Size: 0x5, Type: dev
    function private function_f2a8748a6122ebcf()
    {
        
    }

#/
