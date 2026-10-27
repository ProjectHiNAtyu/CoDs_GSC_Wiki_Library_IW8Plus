// script_e6a8fa6bdd2ec12  (hash_0e6a8fa6bdd2ec12.gscc) (size: 1736 Bytes / 0x6c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f253e5c (1327840860)
// size ...... 1736 (0x6c8)
// includes .. 4   (offset: 0x670)
// strings ... 3   (offset: 0x690)
// dev strs .. 0   (offset: 0x6c8)
// exports ... 9   (offset: 0x328)
// cseg ...... 0x9a + 0x28e (0x328)
// imports ... 16  (offset: 0x490)
// animtree1 . 0   (offset: 0x6c8)
// animtree2 . 0   (offset: 0x6c8)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace specialty_gas_move_speed_mod;

// Namespace specialty_gas_move_speed_mod
// Params 0, eflags: 0x1
// Checksum 0x985eaaa2, Offset: 0xb8
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_gas_move_speed_mod
// Params 1
// Checksum 0xc73ed25, Offset: 0xd8
// Size: 0x84
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_gas_move_speed_mod", &function_d5cbeb2e85f362ae, &function_e12cb97e2c136149, [] );
    }
    
    utility::registersharedfunc( #"hash_6175cbdaef362646", #"updatemovespeed", &function_a9e2a151b937eac5 );
    level callback::add( #"hash_2fd481f23e5e677a", &function_164d80d9d20c637c );
    level callback::add( #"hash_6dd1d7b87f599c7c", &function_9e17c4f4d789faa0 );
}

// Namespace specialty_gas_move_speed_mod
// Params 0
// Checksum 0x1bc7a265, Offset: 0x164
// Size: 0x45
function function_d5cbeb2e85f362ae()
{
    bundle = self.var_9842326056fd7207;
    self.var_edf0263f753f611f = 1;
    self.var_2062e7a6411a2067 = bundle.var_95fd65ba806b447a ?? 0.1;
    function_a9e2a151b937eac5();
}

// Namespace specialty_gas_move_speed_mod
// Params 0
// Checksum 0x513d18aa, Offset: 0x1b1
// Size: 0x1d
function function_e12cb97e2c136149()
{
    self.var_edf0263f753f611f = undefined;
    self.var_2062e7a6411a2067 = undefined;
    function_a9e2a151b937eac5();
}

// Namespace specialty_gas_move_speed_mod
// Params 1
// Checksum 0xd69dc1e0, Offset: 0x1d6
// Size: 0x15
function function_164d80d9d20c637c( params )
{
    function_a9e2a151b937eac5( 1 );
}

// Namespace specialty_gas_move_speed_mod
// Params 1
// Checksum 0x1a769747, Offset: 0x1f3
// Size: 0x14
function function_9e17c4f4d789faa0( params )
{
    function_a9e2a151b937eac5( 0 );
}

// Namespace specialty_gas_move_speed_mod
// Params 1, eflags: 0x4
// Checksum 0xb4c5d97d, Offset: 0x20f
// Size: 0xf8
function private function_a9e2a151b937eac5( ingas = isingas() )
{
    if ( self.var_edf0263f753f611f && ingas )
    {
        if ( self.gasspeedmod != self.var_2062e7a6411a2067 )
        {
            self.gasspeedmod = self.var_2062e7a6411a2067;
            
            if ( !common::function_8ff835bf23198a0( "gasSpeedPerkMod" ) )
            {
                common::function_ac4bf3256b2545e3( "gasSpeedPerkMod", self.gasspeedmod );
                common::function_11a0a06c67c80f4d( "gasSpeedPerkMod", 2 );
            }
            
            weapons::updatemovespeedscale();
            self notify( #"hash_62689185a5d0db8d" );
        }
        
        return;
    }
    
    if ( self.gasspeedmod )
    {
        self.gasspeedmod = undefined;
        
        if ( common::function_8ff835bf23198a0( "gasSpeedMod" ) )
        {
            common::function_d85a92c557ea5a52( "gasSpeedMod" );
        }
        
        if ( common::function_8ff835bf23198a0( "gasSpeedPerkMod" ) )
        {
            common::function_d85a92c557ea5a52( "gasSpeedPerkMod" );
        }
        
        weapons::updatemovespeedscale();
        self notify( #"hash_4e6e3bf44481ea84" );
    }
}

// Namespace specialty_gas_move_speed_mod
// Params 0, eflags: 0x4
// Checksum 0xe51df055, Offset: 0x30f
// Size: 0x18, Type: bool
function private isingas()
{
    return self.isincircle || self.var_a7d90dea0d5e6ba2;
}

