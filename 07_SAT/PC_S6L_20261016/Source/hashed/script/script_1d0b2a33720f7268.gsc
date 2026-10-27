// script_1d0b2a33720f7268  (hash_1d0b2a33720f7268.gscc) (size: 1046 Bytes / 0x416 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc5f50a80 (3321170560)
// size ...... 1046 (0x416)
// includes .. 4   (offset: 0x3ce)
// strings ... 2   (offset: 0x3ee)
// dev strs .. 0   (offset: 0x416)
// exports ... 5   (offset: 0x1ea)
// cseg ...... 0x99 + 0x151 (0x1ea)
// imports ... 10  (offset: 0x2b2)
// animtree1 . 0   (offset: 0x416)
// animtree2 . 0   (offset: 0x416)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\perk;

#namespace skill_recharger;

// Namespace skill_recharger
// Params 0, eflags: 0x1
// Checksum 0x94b38e47, Offset: 0xb7
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"recharger", &init );
}

// Namespace skill_recharger
// Params 0
// Checksum 0x6bacf724, Offset: 0xd6
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"recharger", #"ongiveskill", &function_f6f956f52c9797d5 );
    utility::registersharedfunc( #"recharger", #"hash_4aa03f4559ac50a5", &function_e815b79c730d6282 );
}

// Namespace skill_recharger
// Params 1
// Checksum 0xfd9cd597, Offset: 0x11c
// Size: 0x5d, Type: bool
function function_f6f956f52c9797d5( skill_bundle )
{
    if ( skill_bundle.var_a52da47d4465c227 )
    {
        perk::giveperk( "specialty_faster_field_upgrade" );
        val::set( #"recharger", "field_upgrade_recharge_mult", skill_bundle.var_a52da47d4465c227 );
    }
    
    self.var_5b4b541c397a369c = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_recharger
// Params 1
// Checksum 0xa4402034, Offset: 0x182
// Size: 0x68
function function_e815b79c730d6282( skill_bundle )
{
    val::reset( #"recharger", "field_upgrade_recharge_mult" );
    recharge_mult = val::get( "field_upgrade_recharge_mult" );
    
    if ( !recharge_mult && isdefined( self.perks[ "specialty_faster_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_faster_field_upgrade" );
    }
    
    self.var_5b4b541c397a369c = undefined;
}

