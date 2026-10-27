// scripts\mp\ob\supers\cradle_gas_grenade.gsc  (hash_39c4c45d80f6ddd5.gscc) (size: 3017 Bytes / 0xbc9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60ca5771 (1623873393)
// size ...... 3017 (0xbc9)
// includes .. 5   (offset: 0xb45)
// strings ... 3   (offset: 0xb6d)
// dev strs .. 2   (offset: 0xbb1)
// exports ... 12  (offset: 0x679)
// cseg ...... 0x96 + 0x5e3 (0x679)
// imports ... 25  (offset: 0x859)
// animtree1 . 0   (offset: 0xbc9)
// animtree2 . 0   (offset: 0xbc9)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\utility\points;
#using scripts\mp\supers;

#namespace cradle_gas_grenade;

// Namespace cradle_gas_grenade
// Params 0, eflags: 0x5
// Checksum 0x62c52463, Offset: 0xb4
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace cradle_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0xae6135df, Offset: 0xd4
// Size: 0xbb
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_cradle_gas_grenade" );
    assert( bundle, "<dev string:x24>" );
    level callback::add( #"grenade_fire", &on_grenade_fire );
    level callback::add( "on_turned", &on_turned );
    supers_mp::function_48aaa60b2ce7b8a1( "super_cradle_gas_grenade", undefined, undefined, &begin_use );
    utility::registersharedfunc( "equip_gas_grenade", #"hash_8c6386b772caad1d", &function_9d0384098897fe99 );
    utility::registersharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7", &function_591ddbb78df6d17b );
    utility::registersharedfunc( "equip_gas_grenade", #"hash_15540c4bc4150e68", &function_96cfccadd0f7fdb );
}

// Namespace cradle_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0xa49e17d1, Offset: 0x197
// Size: 0x106, Type: bool
function private begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_cradle_gas_grenade" );
    assert( isdefined( bundle ), "<dev string:x53>" );
    assert( bundle.offhandweapon );
    self.var_b1c88d3658740b45 = bundle.offhandweapon;
    self.super_cradle_gas_grenade_score_event = bundle.var_9624638649057a3b;
    self.var_8d30829b1b7f8805 = bundle.var_97892f45c0264a90;
    self.var_f7225e1074f627ff = bundle.var_9d00733d4479fb5e;
    self.var_c84896e407259cb7 = bundle.var_50b6d9d41caef9e7;
    self.var_310e9c36300a34b6 = bundle.var_3adc4403dd30b3f7;
    self.var_c102323125f3aa38 = bundle.var_aebee3aeb7ad83e6;
    
    if ( bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
    {
        callback::add( #"super_cancel", &cancel );
    }
    
    return true;
}

// Namespace cradle_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x806cca6, Offset: 0x2a6
// Size: 0x56
function private cancel( params )
{
    if ( self.cradle_gas_trigger )
    {
        self.cradle_gas_trigger thread gas_grenade::gas_destroytrigger();
        self.cradle_gas_trigger = undefined;
    }
    
    if ( self.cradle_gas_grenade )
    {
        self.cradle_gas_grenade delete();
        self.cradle_gas_grenade = undefined;
    }
}

// Namespace cradle_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x2d0b96fe, Offset: 0x304
// Size: 0x9c
function private on_grenade_fire( params )
{
    if ( !params.grenade.weapon_name || params.grenade.weapon_name != self.var_b1c88d3658740b45 || params.grenade.owner != self )
    {
        return;
    }
    
    self.cradle_gas_grenade = params.grenade;
    params.grenade thread watch_water_explode();
    thread function_3be212d31b1c5ea1( params.grenade );
}

// Namespace cradle_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x216c4ad3, Offset: 0x3a8
// Size: 0x2d
function private watch_water_explode()
{
    self endon( #"death" );
    self endon( #"explode" );
    self waittill( #"missile_water_impact" );
    self detonate();
}

// Namespace cradle_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0xf35a2359, Offset: 0x3dd
// Size: 0x18c
function private function_3be212d31b1c5ea1( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade_weapon_name = grenade.weapon_name;
    self.cradle_gas_grenade = grenade;
    grenade waittill( #"death" );
    self.cradle_gas_grenade = undefined;
    waitframe();
    
    if ( self.gas_grenade_array )
    {
        foreach ( var_39bc414888da0b04 in self.gas_grenade_array )
        {
            if ( var_39bc414888da0b04.grenade_weapon_name && grenade_weapon_name == var_39bc414888da0b04.grenade_weapon_name )
            {
                self.cradle_gas_trigger = var_39bc414888da0b04;
                break;
            }
        }
    }
    
    if ( self.cradle_gas_trigger )
    {
        self.cradle_gas_trigger waittill( #"death" );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_cradle_gas_grenade" );
    
    if ( bundle.var_8b9eade13fbfb044 && callback::exists( #"super_cancel", &cancel ) )
    {
        callback::remove( #"super_cancel", &cancel );
    }
    
    self.cradle_gas_trigger = undefined;
    self.var_b1c88d3658740b45 = undefined;
}

// Namespace cradle_gas_grenade
// Params 1, eflags: 0x4
// Checksum 0xcaa33da0, Offset: 0x571
// Size: 0x82
function private on_turned( params )
{
    player = params.attacker;
    
    if ( !self.var_fb2e0070ae6f04e4 || !player || player != self.var_fb2e0070ae6f04e4 )
    {
        return;
    }
    
    self.superref = "super_cradle_gas_grenade";
    player thread points::doscoreevent( player.super_cradle_gas_grenade_score_event );
    
    if ( !self.owner )
    {
        self.owner = player;
    }
}

// Namespace cradle_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x3b4b6d40, Offset: 0x5fb
// Size: 0x30, Type: bool
function private function_9d0384098897fe99()
{
    var_3eb6f2fb6604215f = utility::callsharedfunc( "super_cradle_gas_grenade", #"hash_8921a2c5511486bf" );
    return var_3eb6f2fb6604215f ?? self.var_8d30829b1b7f8805;
}

// Namespace cradle_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x6a89614a, Offset: 0x634
// Size: 0x30, Type: bool
function private function_591ddbb78df6d17b()
{
    var_7707397afe3cd879 = utility::callsharedfunc( "super_cradle_gas_grenade", #"hash_bbbc4a1e00d68ab5" );
    return var_7707397afe3cd879 ?? self.var_f7225e1074f627ff;
}

// Namespace cradle_gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x76e06839, Offset: 0x66d
// Size: 0xb
function private function_96cfccadd0f7fdb()
{
    return self.var_c84896e407259cb7;
}

