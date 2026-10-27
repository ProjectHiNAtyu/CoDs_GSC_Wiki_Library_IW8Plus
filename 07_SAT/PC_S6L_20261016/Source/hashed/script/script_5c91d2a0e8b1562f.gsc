// script_5c91d2a0e8b1562f  (hash_5c91d2a0e8b1562f.gscc) (size: 1663 Bytes / 0x67f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x989522c9 (2559910601)
// size ...... 1663 (0x67f)
// includes .. 4   (offset: 0x62b)
// strings ... 3   (offset: 0x64b)
// dev strs .. 0   (offset: 0x67f)
// exports ... 6   (offset: 0x36f)
// cseg ...... 0x96 + 0x2d9 (0x36f)
// imports ... 16  (offset: 0x45f)
// animtree1 . 0   (offset: 0x67f)
// animtree2 . 0   (offset: 0x67f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace specialty_explosive_slow;

// Namespace specialty_explosive_slow
// Params 0, eflags: 0x1
// Checksum 0x75cc540c, Offset: 0xb4
// Size: 0x36
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
    utility::registersharedfunc( #"specialty_explosive_slow", #"hash_d9e9a01b83d5611e", &function_32a6e97b9efe62b3 );
}

// Namespace specialty_explosive_slow
// Params 1
// Checksum 0xdf6730c2, Offset: 0xf2
// Size: 0x3a
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_explosive_slow", &function_efd3cbba72234a28, &function_8d8b9a182832637, [] );
    }
}

// Namespace specialty_explosive_slow
// Params 0
// Checksum 0xc602d4a0, Offset: 0x134
// Size: 0x74
function function_efd3cbba72234a28()
{
    bundle = self.var_9842326056fd7207;
    self.var_4e40c1557aa27515 = bundle.var_4e40c1557aa27515 ?? getdvarfloat( @"hash_c4d8d43799f0121a", -0.2 );
    self.var_efb15be2098af854 = bundle.var_efb15be2098af854 ?? getdvarfloat( @"hash_829c5a80bc42ed8a", 3 );
    self.var_befce6213f4de60e = 1;
}

// Namespace specialty_explosive_slow
// Params 0
// Checksum 0x8eeb1460, Offset: 0x1b0
// Size: 0x20
function function_8d8b9a182832637()
{
    self.var_4e40c1557aa27515 = undefined;
    self.var_efb15be2098af854 = undefined;
    self.var_befce6213f4de60e = undefined;
}

// Namespace specialty_explosive_slow
// Params 1
// Checksum 0x6965a364, Offset: 0x1d8
// Size: 0x197
function function_32a6e97b9efe62b3( victim )
{
    victim notify( #"explosiveSlow" );
    victim endon( #"explosiveSlow" );
    victim endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( victim.var_63c0fb8343d7d16d ) )
    {
        victim.var_63c0fb8343d7d16d = self.var_4e40c1557aa27515;
        
        if ( !victim common::function_8ff835bf23198a0( "explosiveSlow" ) )
        {
            victim common::function_ac4bf3256b2545e3( "explosiveSlow", self.var_4e40c1557aa27515 );
            victim common::function_11a0a06c67c80f4d( "explosiveSlow", 2 );
        }
        
        victim weapons::updatemovespeedscale();
    }
    
    timer = self.var_efb15be2098af854;
    timer = utility::callsharedfunc( #"specialty_frangible_resist", #"hash_5a93f6e77e6f2e69", timer );
    currtime = gettime();
    
    if ( !isdefined( victim.disabledshocktime ) || currtime - victim.disabledshocktime > 800 )
    {
        duration = 0.8;
        victim shellshock( "chargemode_mp", duration );
        victim.disabledshocktime = currtime;
    }
    
    while ( isalive( victim ) && timer > 0 )
    {
        timer -= level.framedurationseconds;
        waitframe();
    }
    
    victim.var_63c0fb8343d7d16d = undefined;
    victim.disabledshocktime = undefined;
    
    if ( victim common::function_8ff835bf23198a0( "explosiveSlow" ) )
    {
        victim common::function_d85a92c557ea5a52( "explosiveSlow" );
    }
    
    victim weapons::updatemovespeedscale();
}

