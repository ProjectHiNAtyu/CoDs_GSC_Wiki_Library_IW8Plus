// scripts\common\status_effects\effect_stun.gsc  (hash_1ef7929fc3abf81c.gscc) (size: 3616 Bytes / 0xe20 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f18bf1c (1327021852)
// size ...... 3616 (0xe20)
// includes .. 5   (offset: 0xd64)
// strings ... 7   (offset: 0xd8c)
// dev strs .. 2   (offset: 0xe00)
// exports ... 12  (offset: 0x7d8)
// cseg ...... 0xca + 0x70e (0x7d8)
// imports ... 31  (offset: 0x9b8)
// animtree1 . 0   (offset: 0xe20)
// animtree2 . 0   (offset: 0xe20)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;

#namespace effect_stun;

// Namespace effect_stun
// Params 0, eflags: 0x5
// Checksum 0x259bceef, Offset: 0xe8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"effect_stun", undefined, undefined, &post_main );
}

// Namespace effect_stun
// Params 0, eflags: 0x4
// Checksum 0x9ea3793, Offset: 0x109
// Size: 0x3e
function private post_main()
{
    utility::registersharedfunc( #"effect_stun", #"stun", &stun );
    utility::registersharedfunc( #"effect_stun", #"hash_1517470fc89c1c4e", &function_cf15e13610c1177 );
}

// Namespace effect_stun
// Params 8
// Checksum 0x973afd4e, Offset: 0x14f
// Size: 0x182
function stun( var_1cedb6873f3abee2, var_7ac040448f8ace66, var_1e4624a03ea41715, var_7359b4d85787367e, var_a64ce253f7d8dcdd, var_749345f344f55b77, ignore_score_event = undefined, cooldown = 0 )
{
    assert( isstring( var_1cedb6873f3abee2 ), "<dev string:x24>" );
    assert( isnumber( var_7ac040448f8ace66 ), "<dev string:x45>" );
    
    if ( isplayer( self ) )
    {
        return 0;
    }
    
    if ( isai( self ) && !self.aisettings.var_b11b8458c44f3024 )
    {
        return 0;
    }
    
    effect = status_effects::function_93edde8d0fe48bb6( "stun", var_7ac040448f8ace66, var_1cedb6873f3abee2, &function_6a82fbfa5a40ae1f, &function_c0295c3dab1cd68, var_749345f344f55b77, cooldown );
    effect.var_1e4624a03ea41715 = var_1e4624a03ea41715;
    effect.var_7359b4d85787367e = var_7359b4d85787367e;
    effect.var_a64ce253f7d8dcdd = var_a64ce253f7d8dcdd;
    effect.var_749345f344f55b77 = var_749345f344f55b77;
    effect_applied = status_effects::function_3747671c47b03216( effect );
    
    if ( effect_applied && isplayer( var_1e4624a03ea41715 ) && !isdefined( ignore_score_event ) )
    {
        if ( !isdefined( var_1cedb6873f3abee2 ) || !status_effects::function_fa35fc2723e956eb( "stun", var_1cedb6873f3abee2 ) )
        {
            if ( var_749345f344f55b77 == "electrical" )
            {
                var_1e4624a03ea41715 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"electrocuted" );
            }
            else
            {
                var_1e4624a03ea41715 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"stunned" );
            }
        }
    }
    
    return effect_applied;
}

// Namespace effect_stun
// Params 1, eflags: 0x4
// Checksum 0x3ee7f2af, Offset: 0x2da
// Size: 0x94
function private function_6a82fbfa5a40ae1f( effect )
{
    if ( self.type == "zombie" )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"stunZombie" ) )
        {
            self [[ utility::getsharedfunc( #"zombie", #"stunZombie" ) ]]( effect.durations, effect.var_7359b4d85787367e, effect.var_a64ce253f7d8dcdd );
        }
        
        return;
    }
    
    if ( self.type == "human" )
    {
        function_16ba258200f121af( effect );
    }
}

// Namespace effect_stun
// Params 1, eflags: 0x4
// Checksum 0x2bf44ead, Offset: 0x376
// Size: 0xc
function private function_c0295c3dab1cd68( effect )
{
    
}

// Namespace effect_stun
// Params 1
// Checksum 0x9ae2104, Offset: 0x38a
// Size: 0x88
function function_cf15e13610c1177( var_1cedb6873f3abee2 )
{
    assert( isstring( var_1cedb6873f3abee2 ), "<dev string:x24>" );
    
    if ( self.status_effects[ var_1cedb6873f3abee2 ].size > 1 )
    {
        return;
    }
    
    if ( self.type == "human" )
    {
        function_e0c23e97fa9268f8( var_1cedb6873f3abee2 );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"clearstunzombie" ) )
    {
        self [[ utility::getsharedfunc( #"zombie", #"clearstunzombie" ) ]]();
    }
}

// Namespace effect_stun
// Params 2
// Checksum 0xa1dc1f71, Offset: 0x41a
// Size: 0xe2, Type: bool
function function_715dc69554c2d9ed( entity, var_1cedb6873f3abee2 )
{
    assert( isstring( var_1cedb6873f3abee2 ), "<dev string:x24>" );
    
    if ( !status_effects::has_status_effect_type( "stun" ) )
    {
        return false;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "stun" ] )
    {
        if ( var_1cedb6873f3abee2 == var_c6321cb8cd32b6a0.unique_id && entity === var_c6321cb8cd32b6a0.var_1e4624a03ea41715 )
        {
            return ( var_c6321cb8cd32b6a0.var_1e4624a03ea41715 == entity );
        }
    }
    
    return false;
}

// Namespace effect_stun
// Params 1
// Checksum 0xb0f9d8c5, Offset: 0x505
// Size: 0xa2
function function_75ca528f26ee06d( entity )
{
    var_72c432ad8a90fee4 = 0;
    
    if ( isagent( entity ) )
    {
        if ( isdefined( entity.aicategory ) )
        {
            switch ( entity.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                case #"hash_8c089e813083e510":
                    var_72c432ad8a90fee4 = 1;
                    break;
                case #"hash_7b0e2f2ed84f34":
                    break;
                default:
                    break;
            }
        }
        else if ( entity.aisettings.var_b11b8458c44f3024 )
        {
            var_72c432ad8a90fee4 = 1;
        }
    }
    
    return var_72c432ad8a90fee4;
}

// Namespace effect_stun
// Params 1, eflags: 0x4
// Checksum 0xc809670c, Offset: 0x5b0
// Size: 0x6f
function private function_e0c23e97fa9268f8( var_1cedb6873f3abee2 )
{
    self notify( #"hash_1517470fc89c1c4e" );
    
    if ( isdefined( self._blackboard ) )
    {
        self._blackboard.shockedendtime = 0;
    }
    
    self.status_effects[ var_1cedb6873f3abee2 ][ 0 ].end_time = 0;
    self.stunendtime = 0;
    utility::function_7c10ea82c1e305b8( "stunned", "stunned_off" );
}

// Namespace effect_stun
// Params 1, eflags: 0x4
// Checksum 0x4e2adbf8, Offset: 0x627
// Size: 0x140
function private function_16ba258200f121af( effect )
{
    if ( isdefined( self._blackboard ) )
    {
        firstshock = gettime() > self._blackboard.shockedendtime;
        
        if ( self asmhaspainstate( self.asmname ) )
        {
            if ( effect.var_749345f344f55b77 == "electrical" )
            {
                self._blackboard.shockedendtime = gettime() + int( utility::function_4b74c15943231980( effect.durations ) );
                self._blackboard.var_ba9517cfc0287af8 = gettime();
            }
            else
            {
                self.stunendtime = gettime() + int( utility::function_4b74c15943231980( effect.durations ) );
            }
            
            if ( effect.var_7359b4d85787367e )
            {
                thread set_stun_state( effect.durations, effect.var_7359b4d85787367e );
            }
        }
    }
    
    if ( firstshock && self asmhaspainstate( self.asmname ) )
    {
        self asmevalpaintransition( self.asmname );
    }
    
    callback::callback( "on_ai_stunned", { #duration:effect.durations } );
}

// Namespace effect_stun
// Params 2, eflags: 0xc
// Checksum 0x94ac3004, Offset: 0x76f
// Size: 0x69
function private set_stun_state( duration, var_7359b4d85787367e )
{
    self notify( #"hash_ee2fb4159fab3ede" );
    self endon( #"hash_ee2fb4159fab3ede" );
    
    if ( utility::function_7c10ea82c1e305b8( "stunned", var_7359b4d85787367e ) )
    {
        self endon( #"death" );
        self endon( #"hash_1517470fc89c1c4e" );
        wait duration;
        utility::function_7c10ea82c1e305b8( "stunned", "stunned_off" );
    }
}

