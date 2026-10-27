// script_7a7841d643e82a68  (hash_7a7841d643e82a68.gscc) (size: 5866 Bytes / 0x16ea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc15382b (3423942699)
// size ...... 5866 (0x16ea)
// includes .. 7   (offset: 0x163a)
// strings ... 9   (offset: 0x1672)
// dev strs .. 0   (offset: 0x16ea)
// exports ... 25  (offset: 0xcee)
// cseg ...... 0x15f + 0xb8f (0xcee)
// imports ... 46  (offset: 0x10d6)
// animtree1 . 0   (offset: 0x16ea)
// animtree2 . 0   (offset: 0x16ea)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;

#namespace skill_vehicle_summoner_upgrade;

// Namespace skill_vehicle_summoner_upgrade
// Params 0, eflags: 0x1
// Checksum 0xe18914ae, Offset: 0x17d
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"vehicle_summoner_upgrade", &init );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 0
// Checksum 0xe1745bbc, Offset: 0x19c
// Size: 0x96
function init()
{
    utility::registersharedfunc( #"vehicle_summoner_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"vehicle_summoner_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( "super_vehicle_summoner_enter_passenger", &vehicle_enter_player );
    level callback::add( "super_vehicle_summoner_exit_passenger", &vehicle_exit_player );
    level zombie_utils::function_dfae6a5bd222c586( &function_943d8dd3946c8611 );
    level agent_utils::register_soldier_damage_callback( &function_943d8dd3946c8611 );
    utility::registersharedfunc( "super_vehicle_summoner", #"hash_f10eb0c08ca64317", &function_1ea2e13bc836ebea );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x453bc62, Offset: 0x23a
// Size: 0x2d, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_9f9910e83b86adee = { #var_7300d6c4266cb468:undefined, #bundle:skill_bundle };
    return true;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0xcbaa011b, Offset: 0x270
// Size: 0x38
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"vehicle_summoner_upgrade_ended" );
    function_eb46aa1fb7c8ca55( 0, skill_bundle );
    function_8e73afa24308722a( 0, skill_bundle, 1 );
    self.var_9f9910e83b86adee = undefined;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 0, eflags: 0x4
// Checksum 0x7f3b634b, Offset: 0x2b0
// Size: 0x5e
function private function_1ea2e13bc836ebea()
{
    bundle = self.var_9f9910e83b86adee.bundle;
    return { #var_b6bb45a65271cc98:bundle.var_a872e2910a408cc2, #var_4ad99a00ad8a0f91:bundle.var_7fa1e68a7bd12577, #pointsneeded:bundle.var_bbb123f57abfbd16 };
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf6b21e64, Offset: 0x317
// Size: 0x21
function private function_731c6c7a5b969b3f( vehicle )
{
    return vehicle.owner.var_9f9910e83b86adee;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 0, eflags: 0x4
// Checksum 0x8e4c0de0, Offset: 0x341
// Size: 0x1f, Type: bool
function private function_5cdb72b67a4c93cd()
{
    return is_inside_vehicle() || self.var_9f9910e83b86adee.var_7300d6c4266cb468;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 3, eflags: 0x4
// Checksum 0x1bd83aaa, Offset: 0x369
// Size: 0xaf
function private function_8e73afa24308722a( enabled, bundle, force_disable )
{
    if ( enabled )
    {
        var_a0102079ad2250f9 = !callback::exists( #"hash_652eb614ba902b3d", &function_1ac4e4884311c1c0, bundle );
        assert( var_a0102079ad2250f9 );
        
        if ( var_a0102079ad2250f9 )
        {
            callback::add( #"hash_652eb614ba902b3d", &function_1ac4e4884311c1c0, bundle );
        }
        
        return;
    }
    
    if ( force_disable || !function_5cdb72b67a4c93cd() )
    {
        if ( callback::exists( #"hash_652eb614ba902b3d", &function_1ac4e4884311c1c0, bundle ) )
        {
            callback::remove( #"hash_652eb614ba902b3d", &function_1ac4e4884311c1c0, bundle );
        }
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0xcf7a78da, Offset: 0x420
// Size: 0x54
function private vehicle_enter_player( params )
{
    if ( !function_731c6c7a5b969b3f( params.vehicle ) )
    {
        return;
    }
    
    function_8e73afa24308722a( 1, params.vehicle.owner.var_9f9910e83b86adee.bundle );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x85b3516e, Offset: 0x47c
// Size: 0x35, Type: bool
function private function_73193962f612df69( bundle )
{
    return bundle.var_1e69b074d48e8331 && ( bundle.var_7e32cd4063888f21 || bundle.var_34d5702344bcbb1f );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 2, eflags: 0x4
// Checksum 0x36e4614, Offset: 0x4ba
// Size: 0xa8
function private function_7b48a9cfdf8ebdd( bundle, var_55751198478e87d9 )
{
    thread function_cab4acd5859aa538( bundle );
    
    foreach ( occupant in var_55751198478e87d9.occupants )
    {
        occupant function_8e73afa24308722a( 0, bundle, 1 );
        occupant thread function_cab4acd5859aa538( bundle );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x162c9b49, Offset: 0x56a
// Size: 0x9b
function private vehicle_exit_player( params )
{
    if ( !function_731c6c7a5b969b3f( params.vehicle ) )
    {
        return;
    }
    
    bundle = params.vehicle.owner.var_9f9910e83b86adee.bundle;
    function_8e73afa24308722a( 0, bundle );
    
    if ( function_73193962f612df69( bundle ) && params.vehicle.owner == self )
    {
        function_7b48a9cfdf8ebdd( bundle, params.vehicle );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 0, eflags: 0x4
// Checksum 0xf185bd6f, Offset: 0x60d
// Size: 0x31, Type: bool
function private is_inside_vehicle()
{
    return self.vehicle.occupants && arraycontains( self.vehicle.occupants, self );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 2, eflags: 0x4
// Checksum 0x3646ce31, Offset: 0x647
// Size: 0x109
function private function_1ac4e4884311c1c0( params, bundle )
{
    damage_reduction_factor = bundle.var_b2af05b1a15e077f;
    
    if ( damage_reduction_factor && params.victim is_inside_vehicle() )
    {
        params.idamage -= params.idamage * damage_reduction_factor;
        params.victim function_4e07b6f171656107( bundle );
        params.victim.vehicle function_fa85530815af5758( bundle );
    }
    
    var_64273038fb089251 = bundle.var_7e32cd4063888f21;
    
    if ( var_64273038fb089251 && self.var_9f9910e83b86adee.var_7300d6c4266cb468 )
    {
        params.idamage -= params.idamage * var_64273038fb089251;
        params.victim function_4e07b6f171656107( bundle );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x59966515, Offset: 0x758
// Size: 0x47
function private function_4e07b6f171656107( bundle )
{
    if ( bundle.var_576cc36e72822336 && bundle.var_b443894bf917a6f4 )
    {
        self setscriptablepartstate( bundle.var_576cc36e72822336, bundle.var_b443894bf917a6f4, 1 );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x81e82844, Offset: 0x7a7
// Size: 0x47
function private function_fa85530815af5758( bundle )
{
    if ( bundle.var_ee1525fe46c6b542 && bundle.var_8a260ff732254130 )
    {
        self setscriptablepartstate( bundle.var_ee1525fe46c6b542, bundle.var_8a260ff732254130, 1 );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 2, eflags: 0x4
// Checksum 0x580cd472, Offset: 0x7f6
// Size: 0x45
function private update_invulnerability( enabled, bundle )
{
    if ( bundle.var_34d5702344bcbb1f )
    {
        val::set( #"vehicle_summoner_upgrade", "damage", !enabled );
        function_48bb493e6cb7a9bb( enabled, bundle );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 2, eflags: 0x4
// Checksum 0x89c56b1b, Offset: 0x843
// Size: 0x13b
function private function_48bb493e6cb7a9bb( enabled, bundle )
{
    if ( enabled )
    {
        val::set( #"vehicle_summoner_upgrade", "damage_protection_omnvar", "ui_squadmate_show_damage_protection_" + self.sessionuimemberindex );
        
        if ( bundle.var_8f1ffea5dc37deaf && bundle.var_3753ef47b7072066 )
        {
            self setscriptablepartstate( bundle.var_8f1ffea5dc37deaf, bundle.var_3753ef47b7072066, 0 );
        }
        
        if ( bundle.var_df318aa3385ad99c )
        {
            val::set( #"vehicle_summoner_upgrade", "damage_protection_pgb_post_fx", bundle.var_df318aa3385ad99c );
        }
        
        if ( bundle.var_31d78fb28873b424 )
        {
            self playsoundtoplayer( bundle.var_31d78fb28873b424, self );
        }
        
        return;
    }
    
    val::reset( #"vehicle_summoner_upgrade", "damage_protection_omnvar" );
    
    if ( bundle.var_8f1ffea5dc37deaf && bundle.var_b4da6ab784d21148 )
    {
        self setscriptablepartstate( bundle.var_8f1ffea5dc37deaf, bundle.var_b4da6ab784d21148, 0 );
    }
    
    if ( bundle.var_df318aa3385ad99c )
    {
        val::reset( #"vehicle_summoner_upgrade", "damage_protection_pgb_post_fx" );
    }
}

// Namespace skill_vehicle_summoner_upgrade
// Params 2, eflags: 0x4
// Checksum 0xf7278201, Offset: 0x986
// Size: 0x71
function private function_eb46aa1fb7c8ca55( enabled, bundle )
{
    if ( self.var_9f9910e83b86adee )
    {
        self.var_9f9910e83b86adee.var_7300d6c4266cb468 = enabled ? 1 : undefined;
    }
    
    update_invulnerability( enabled, bundle );
    enabled_callback = enabled && bundle.var_7e32cd4063888f21;
    function_8e73afa24308722a( enabled_callback, bundle );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0xc
// Checksum 0x9bc1a65, Offset: 0x9ff
// Size: 0x8c
function private function_cab4acd5859aa538( bundle )
{
    self notify( #"hash_2eff57ce22853a0e" );
    self endon( #"hash_2eff57ce22853a0e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_e6bfa3c26bcdad2a = bundle.var_1e69b074d48e8331;
    assert( var_e6bfa3c26bcdad2a );
    
    if ( !var_e6bfa3c26bcdad2a )
    {
        return;
    }
    
    function_eb46aa1fb7c8ca55( 1, bundle );
    utility::waittill_any_timeout( var_e6bfa3c26bcdad2a, "death", "vehicle_summoner_upgrade_ended" );
    function_eb46aa1fb7c8ca55( 0, bundle );
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x20d4cedc, Offset: 0xa93
// Size: 0x95
function private function_943d8dd3946c8611( params )
{
    if ( !params.eattacker )
    {
        return params.idamage;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        return params.eattacker function_ec18d0b71c2025cf( params );
    }
    
    if ( params.eattacker vehicle::is_vehicle() && function_731c6c7a5b969b3f( params.eattacker ) )
    {
        return params.eattacker function_1b619ee5c3995dcc( params );
    }
    
    return params.idamage;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0x92ff8c13, Offset: 0xb31
// Size: 0x8b
function private function_ec18d0b71c2025cf( params )
{
    if ( !is_inside_vehicle() || !is_vehicle_summoner( self.vehicle ) )
    {
        return params.idamage;
    }
    
    damagemod = self.var_9f9910e83b86adee.bundle.var_a0bfe29a5c71c1d0;
    
    if ( !damagemod )
    {
        return params.idamage;
    }
    
    result = params.idamage * damagemod;
    return result;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe797ee33, Offset: 0xbc5
// Size: 0x9b
function private function_1b619ee5c3995dcc( params )
{
    player = params.eattacker.owner;
    
    if ( !player is_vehicle_summoner( self ) )
    {
        return params.idamage;
    }
    
    damagemod = player.var_9f9910e83b86adee.bundle.var_b100d2f6ac5a424a;
    
    if ( !damagemod )
    {
        return params.idamage;
    }
    
    result = params.idamage * damagemod;
    return result;
}

// Namespace skill_vehicle_summoner_upgrade
// Params 1, eflags: 0x4
// Checksum 0xd7dd5b18, Offset: 0xc69
// Size: 0x84, Type: bool
function private is_vehicle_summoner( vehicle )
{
    if ( self.tacticalsuper.staticdata.ref != "super_vehicle_summoner" )
    {
        return false;
    }
    
    vehicle_bundle = self.tacticalsuper.staticdata.bundle.var_1f377d00ae0ba8aa;
    
    if ( !vehicle_bundle )
    {
        return false;
    }
    
    if ( vehicle.bundlename != vehicle_bundle )
    {
        return false;
    }
    
    return true;
}

