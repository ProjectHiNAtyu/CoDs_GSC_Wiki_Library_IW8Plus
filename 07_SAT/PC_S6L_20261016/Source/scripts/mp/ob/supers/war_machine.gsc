// scripts\mp\ob\supers\war_machine.gsc  (hash_36562228e89cf88d.gscc) (size: 3002 Bytes / 0xbba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5c9bfc5f (1553726559)
// size ...... 3002 (0xbba)
// includes .. 3   (offset: 0xb66)
// strings ... 2   (offset: 0xb7e)
// dev strs .. 1   (offset: 0xbae)
// exports ... 13  (offset: 0x63e)
// cseg ...... 0x78 + 0x5c6 (0x63e)
// imports ... 26  (offset: 0x846)
// animtree1 . 0   (offset: 0xbba)
// animtree2 . 0   (offset: 0xbba)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\points;
#using scripts\mp\supers;

#namespace war_machine;

// Namespace war_machine
// Params 0, eflags: 0x5
// Checksum 0x333b2eb7, Offset: 0x96
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0x365f29d2, Offset: 0xb6
// Size: 0xc6
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_war_machine" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level callback::add( #"on_ai_killed", &function_dc09e88dc727432d );
    level callback::add( #"player_death", &function_dc09e88dc727432d );
    level callback::add( #"on_ai_damaged", &function_83a90447c587e683 );
    level callback::add( #"player_damaged", &function_83a90447c587e683 );
    supers_mp::function_48aaa60b2ce7b8a1( "super_war_machine", undefined, undefined, &begin_use, &end_use );
}

// Namespace war_machine
// Params 0, eflags: 0x4
// Checksum 0x11eb8ab7, Offset: 0x184
// Size: 0x6d, Type: bool
function private begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_war_machine" );
    
    if ( !isdefined( bundle ) )
    {
        assertmsg( "<dev string:x24>" );
        return false;
    }
    
    if ( bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
    {
        callback::add( #"super_cancel", &cancel );
    }
    
    return true;
}

// Namespace war_machine
// Params 2, eflags: 0x4
// Checksum 0xc300d693, Offset: 0x1fa
// Size: 0x41
function private end_use( fromdeath, attacker )
{
    if ( callback::exists( #"super_cancel", &cancel ) )
    {
        callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0xc234dbb9, Offset: 0x243
// Size: 0x18
function private cancel( params )
{
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace war_machine
// Params 0, eflags: 0x4
// Checksum 0xe91eeede, Offset: 0x263
// Size: 0x2f, Type: bool
function private is_war_machine_in_use()
{
    return supers_mp::issuperinuse() && self.super.staticdata.ref == "super_war_machine";
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0xd7c8143a, Offset: 0x29b
// Size: 0x76
function private function_dc09e88dc727432d( params )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    attacker = params.eattacker ?? params.attacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( attacker is_war_machine_in_use() )
    {
        function_da928222cad039de( attacker );
    }
    
    if ( isdefined( self.war_machine_damage_data ) )
    {
        function_b9fc3d148ce3a531( attacker );
    }
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0xcf34f18c, Offset: 0x319
// Size: 0x58
function private function_da928222cad039de( attacker )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_war_machine" );
    
    if ( isdefined( bundle.var_1f2a0131ac62b4e7 ) )
    {
        weapon = attacker getcurrentweapon();
        attacker thread points::doscoreevent( bundle.var_1f2a0131ac62b4e7, weapon );
    }
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0x16408d3e, Offset: 0x379
// Size: 0x11f
function private function_b9fc3d148ce3a531( attacker )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_war_machine" );
    
    if ( isdefined( bundle.var_41741d567ff47fc8 ) )
    {
        foreach ( damage_data in self.war_machine_damage_data )
        {
            if ( !isplayer( damage_data.attacker ) )
            {
                continue;
            }
            
            if ( damage_data.attacker == attacker )
            {
                continue;
            }
            
            if ( damage_data.time <= gettime() )
            {
                weapon = damage_data.attacker getcurrentweapon();
                damage_data.attacker thread points::doscoreevent( bundle.var_41741d567ff47fc8, weapon );
            }
        }
    }
    
    self.war_machine_damage_data = undefined;
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0xcf6bb1ac, Offset: 0x4a0
// Size: 0x61
function private function_83a90447c587e683( params )
{
    attacker = params.eattacker;
    
    if ( !isalive( self ) || !isdefined( attacker ) || !attacker is_war_machine_in_use() )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_war_machine" );
    function_d529c4a284e0d5b5( attacker, bundle );
}

// Namespace war_machine
// Params 2, eflags: 0x4
// Checksum 0x6a80e666, Offset: 0x509
// Size: 0x9c
function private function_d529c4a284e0d5b5( attacker, bundle )
{
    current_damage_data = function_b6f7be762ca19037( attacker ) ?? {};
    current_damage_data.time = gettime() + ( bundle.var_d62669dda39c4f01 ?? 5 );
    
    if ( !isdefined( current_damage_data.attacker ) )
    {
        current_damage_data.attacker = attacker;
        
        if ( !isdefined( self.war_machine_damage_data ) )
        {
            self.war_machine_damage_data = [];
        }
        
        self.war_machine_damage_data[ self.war_machine_damage_data.size ] = current_damage_data;
    }
}

// Namespace war_machine
// Params 1, eflags: 0x4
// Checksum 0x85f1deb6, Offset: 0x5ad
// Size: 0x90
function private function_b6f7be762ca19037( attacker )
{
    foreach ( damage_data in self.war_machine_damage_data )
    {
        if ( damage_data.attacker == attacker )
        {
            return damage_data;
        }
    }
}

