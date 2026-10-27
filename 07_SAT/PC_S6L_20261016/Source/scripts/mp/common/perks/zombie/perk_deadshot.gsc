// scripts\mp\common\perks\zombie\perk_deadshot.gsc  (hash_0e971eee98c69fca.gscc) (size: 1713 Bytes / 0x6b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1557315e (358035806)
// size ...... 1713 (0x6b1)
// includes .. 5   (offset: 0x62d)
// strings ... 4   (offset: 0x655)
// dev strs .. 0   (offset: 0x6b1)
// exports ... 9   (offset: 0x2e1)
// cseg ...... 0xbe + 0x223 (0x2e1)
// imports ... 17  (offset: 0x449)
// animtree1 . 0   (offset: 0x6b1)
// animtree2 . 0   (offset: 0x6b1)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\currency;

#namespace perk_deadshot;

// Namespace perk_deadshot
// Params 0, eflags: 0x5
// Checksum 0xa174ba71, Offset: 0xdc
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_deadshot", undefined, &__init__, undefined );
}

// Namespace perk_deadshot
// Params 0, eflags: 0x1
// Checksum 0xf8abad6f, Offset: 0xf9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_a843efc01e88a39f );
}

// Namespace perk_deadshot
// Params 0
// Checksum 0xa3b6c939, Offset: 0x119
// Size: 0xa
function __init__()
{
    level thread perk_deadshot_init();
}

// Namespace perk_deadshot
// Params 0
// Checksum 0xc3919fd2, Offset: 0x12b
// Size: 0xae
function perk_deadshot_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_deadshot" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_deadshot" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_deadshot" );
    var_7c0c0569bf2695fb = var_fcb7626c79b3c98f ?? 2000;
    level thread zombie_perks::enable_perk_for_level( "specialty_deadshot", str_currency, var_7c0c0569bf2695fb, &function_9b90e4760ebf253, &function_90b475920ba7edc9, 1 );
    level utility::flag_set( "specialty_deadshot" + "init_complete" );
}

// Namespace perk_deadshot
// Params 1
// Checksum 0xc8a18d06, Offset: 0x1e1
// Size: 0x5e
function function_a843efc01e88a39f( params )
{
    bundle = level.perkbundles[ "specialty_deadshot" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_deadshot", &function_9b90e4760ebf253, &function_90b475920ba7edc9 );
    }
}

// Namespace perk_deadshot
// Params 0
// Checksum 0xcdb0743b, Offset: 0x247
// Size: 0x44
function function_9b90e4760ebf253()
{
    zombie_perks::function_5d65c3d58cc084ec( "specialty_deadshot" );
    critical_dmg_multiplier = level.perkbundles[ "specialty_deadshot" ].var_d6a3ae14884f51bc;
    
    if ( isdefined( critical_dmg_multiplier ) )
    {
        self.var_92a742437d824533 = critical_dmg_multiplier;
    }
}

// Namespace perk_deadshot
// Params 4
// Checksum 0xac968ea1, Offset: 0x293
// Size: 0x38
function function_90b475920ba7edc9( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_2e64334b64103922();
    self.var_92a742437d824533 = undefined;
}

// Namespace perk_deadshot
// Params 0
// Checksum 0xad846036, Offset: 0x2d3
// Size: 0xe
function function_2e64334b64103922()
{
    zombie_perks::function_25539251d02082( "specialty_deadshot" );
}

