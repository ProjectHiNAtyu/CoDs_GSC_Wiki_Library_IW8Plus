// scripts\mp\common\equipment\debuff_util.gsc  (hash_3bfb44b9a43a83f8.gscc) (size: 1777 Bytes / 0x6f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ea71b46 (2393316166)
// size ...... 1777 (0x6f1)
// includes .. 5   (offset: 0x68d)
// strings ... 5   (offset: 0x6b5)
// dev strs .. 0   (offset: 0x6f1)
// exports ... 5   (offset: 0x461)
// cseg ...... 0xbd + 0x3a4 (0x461)
// imports ... 12  (offset: 0x529)
// animtree1 . 0   (offset: 0x6f1)
// animtree2 . 0   (offset: 0x6f1)
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\emp_debuff;

#namespace debuff_util;

// Namespace debuff_util
// Params 4
// Checksum 0x7d48b899, Offset: 0xdb
// Size: 0xa4
function function_91c904a55dd47b6a( var_35a846a6bc3711bd, var_b837f83cb74d3833, var_de21f97c06719266, var_add2dd471396e6f9 )
{
    self notify( #"end_explosiveregenhalt" );
    self notify( #"hash_2e081362109547c0" );
    self notify( #"hash_c4700f9ace6b3e19" );
    thread shellshock_utility::_stopshellshock();
    player::hidehudclear();
    emp_debuff::clear_emp();
    emp_debuff::clear_emp_scramble();
    
    if ( self.ksempd )
    {
        utility::callsharedfunc( #"emp", #"hash_6781b1898af33d91" );
    }
    
    thread function_780612a55bca1527( var_35a846a6bc3711bd, var_b837f83cb74d3833, var_de21f97c06719266, var_add2dd471396e6f9 );
    thread function_737a6ab503796ece( var_35a846a6bc3711bd, var_b837f83cb74d3833, var_de21f97c06719266 );
}

// Namespace debuff_util
// Params 3
// Checksum 0x986aa2ca, Offset: 0x187
// Size: 0x6f
function function_737a6ab503796ece( duration, var_b837f83cb74d3833, var_de21f97c06719266 )
{
    self.var_193dad851d6389a4 = 1;
    self notify( #"start_hallucination_immunity" );
    params = function_e7807da574c5012b( var_b837f83cb74d3833, var_de21f97c06719266 );
    utility::waittill_any_in_array_or_timeout_no_endon_death( params, duration );
    
    if ( self && self.var_193dad851d6389a4 )
    {
        self.var_193dad851d6389a4 = undefined;
    }
}

// Namespace debuff_util
// Params 4
// Checksum 0x85208ae0, Offset: 0x1fe
// Size: 0x1ae
function function_780612a55bca1527( duration, var_b837f83cb74d3833, var_de21f97c06719266, var_add2dd471396e6f9 )
{
    var_e474e30fb981fe77 = [ "specialty_emp_immunity", "specialty_empimmune", "specialty_stun_resistance" ];
    
    foreach ( perk in var_add2dd471396e6f9 )
    {
        var_e474e30fb981fe77[ var_e474e30fb981fe77.size ] = perk;
    }
    
    foreach ( perk in var_e474e30fb981fe77 )
    {
        perk::giveperk( perk );
    }
    
    params = function_e7807da574c5012b( var_b837f83cb74d3833, var_de21f97c06719266 );
    utility::waittill_any_in_array_or_timeout_no_endon_death( params, duration );
    
    if ( self )
    {
        foreach ( perk in var_e474e30fb981fe77 )
        {
            perk::removeperk( perk );
        }
    }
}

// Namespace debuff_util
// Params 2, eflags: 0x4
// Checksum 0x75ca5d51, Offset: 0x3b4
// Size: 0xac
function private function_e7807da574c5012b( var_b837f83cb74d3833, var_de21f97c06719266 )
{
    params = [ "disconnect" ];
    
    if ( !var_b837f83cb74d3833 )
    {
        params[ params.size ] = "death";
    }
    
    foreach ( param in var_de21f97c06719266 )
    {
        params[ params.size ] = param;
    }
    
    return params;
}

