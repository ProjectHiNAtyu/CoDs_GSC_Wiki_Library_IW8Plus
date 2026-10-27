// script_25c4ed88766feb47  (hash_25c4ed88766feb47.gscc) (size: 2407 Bytes / 0x967 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71ad6c4b (1907190859)
// size ...... 2407 (0x967)
// includes .. 7   (offset: 0x8af)
// strings ... 8   (offset: 0x8e7)
// dev strs .. 0   (offset: 0x967)
// exports ... 8   (offset: 0x507)
// cseg ...... 0xec + 0x41b (0x507)
// imports ... 21  (offset: 0x647)
// animtree1 . 0   (offset: 0x967)
// animtree2 . 0   (offset: 0x967)
#using script_35efc59124dbb5db;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;

#namespace namespace_ff6878b512b89ab2;

// Namespace namespace_ff6878b512b89ab2
// Params 0
// Checksum 0xc132d0c6, Offset: 0x10a
// Size: 0x39
function init()
{
    data = { #chemistry_set:getentitylessscriptablearray( "sat_zm_mantis_ww_chemistry_set" )[ 0 ] };
    level.mantis_ww_quest.var_1e5d963acb8a335e = data;
}

// Namespace namespace_ff6878b512b89ab2
// Params 2
// Checksum 0x60275179, Offset: 0x14b
// Size: 0x7b
function execute( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        quest_data.chemistry_set setscriptablepartstate( "base", "usable_hint" );
    }
    
    scriptable::scriptable_addusedcallback( &function_e0ec687812020bda );
    utility::flag_wait( "ww_sulfur_picked_up" );
}

// Namespace namespace_ff6878b512b89ab2
// Params 2
// Checksum 0x89b74877, Offset: 0x1ce
// Size: 0x55
function cleanup( skipped, save_restored )
{
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    quest_data.chemistry_set setscriptablepartstate( "base", "used" );
    function_c9a42ee2c3c0d583();
}

// Namespace namespace_ff6878b512b89ab2
// Params 6, eflags: 0x4
// Checksum 0x8bd7cefb, Offset: 0x22b
// Size: 0xb8
function private function_e0ec687812020bda( instance, part, state, player, bautouse, usestring )
{
    if ( instance.type != "sat_zm_mantis_ww_chemistry_set" || utility::flag( "ww_sulfur_picked_up" ) )
    {
        return;
    }
    
    utility::flag_set( "ww_sulfur_picked_up" );
    player_banter::function_850de641659a4090();
    level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.mantis_ww_quest.var_1e5d963acb8a335e.acid_pool setscriptablepartstate( "base", "usable_hint_pour" );
    }
}

// Namespace namespace_ff6878b512b89ab2
// Params 0, eflags: 0x4
// Checksum 0xf0de7b71, Offset: 0x2eb
// Size: 0xcf
function private function_c9a42ee2c3c0d583()
{
    while ( level.players.size == 0 )
    {
        wait 1;
    }
    
    foreach ( player in level.players )
    {
        player function_d2cd51be7e673884();
        zm_quest::show_splash_item_picked_up( #"mantis_instruments", #"sat_zm_quest_mantis_wwq_acid", 1, player );
    }
    
    level callback::add( #"player_connect", &function_d2cd51be7e673884 );
    utility::flag_set( "ww_sulfur_picked_up" );
}

// Namespace namespace_ff6878b512b89ab2
// Params 1, eflags: 0x4
// Checksum 0x7377a329, Offset: 0x3c2
// Size: 0x3a
function private function_d2cd51be7e673884( params )
{
    if ( !utility::flag( "ww_acid_picked_up" ) )
    {
        zm_quest::function_b57dfe9625966b0b( #"mantis_instruments", 0, #"sat_zm_quest_mantis_wwq_acid", 1, 1, self );
    }
}

// Namespace namespace_ff6878b512b89ab2
// Params 0
// Checksum 0x99b094d9, Offset: 0x404
// Size: 0x102, Type: bool
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"mantis_ww_quest", #"hash_acf8828e1be3f348" ) )
    {
        return false;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    
    if ( !utility::flag( "ww_sulfur_picked_up" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_76163a5d9aa4ea3c", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.chemistry_set.origin, "wwq_mark_sulfur", 20, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_76163a5d9aa4ea3c" } );
        utility::flag_wait( "ww_sulfur_picked_up" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    return true;
}

