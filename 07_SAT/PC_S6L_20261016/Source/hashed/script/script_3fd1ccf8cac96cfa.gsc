// script_3fd1ccf8cac96cfa  (hash_3fd1ccf8cac96cfa.gscc) (size: 1627 Bytes / 0x65b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x625c5f1a (1650220826)
// size ...... 1627 (0x65b)
// includes .. 7   (offset: 0x60b)
// strings ... 2   (offset: 0x643)
// dev strs .. 0   (offset: 0x65b)
// exports ... 5   (offset: 0x37b)
// cseg ...... 0x7a + 0x301 (0x37b)
// imports ... 16  (offset: 0x443)
// animtree1 . 0   (offset: 0x65b)
// animtree2 . 0   (offset: 0x65b)
#using script_4478f81b31480314;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\currency;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace bgb_machine_zm;

// Namespace bgb_machine_zm
// Params 0, eflags: 0x5
// Checksum 0x69340b0c, Offset: 0x98
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"bgb_machine_zm", #"bgb_machine", &pre_main, undefined );
}

// Namespace bgb_machine_zm
// Params 0, eflags: 0x4
// Checksum 0x6b3084f0, Offset: 0xc1
// Size: 0x3e
function private pre_main()
{
    utility::registersharedfunc( #"bgb_machine", #"hash_aafc637a8f249873", &function_714b45076a2319e );
    utility::registersharedfunc( #"bgb_machine", #"hash_de9e76cf8acd3fb6", &function_390979b4e3f992d5 );
}

// Namespace bgb_machine_zm
// Params 1, eflags: 0x4
// Checksum 0xd1910225, Offset: 0x107
// Size: 0x19f
function private function_714b45076a2319e( player )
{
    var_23f5dda23530d048 = undefined;
    var_c54c030e4bd2dd2e = -1;
    
    if ( isdefined( player.bgb ) && isdefined( level.bgb[ player.bgb ] ) )
    {
        var_c54c030e4bd2dd2e = level.bgb[ player.bgb ].item_index;
    }
    
    var_23f5dda23530d048 = gettime();
    
    if ( self.disabled )
    {
        wait 0.1;
        return;
    }
    
    cost = function_390979b4e3f992d5( player, self.base_cost );
    
    if ( zm_player::function_f37cfdf04b932a03( player ) && player currency::attempt_purchase( #"essence", cost ) )
    {
        self.bgb_machine_user = player;
        self.var_15d2744d244af3ed = cost;
    }
    else
    {
        return;
    }
    
    if ( isdefined( level.var_fae6e4a3f78b3a15 ) )
    {
        player thread [[ level.var_fae6e4a3f78b3a15 ]]();
    }
    
    player thread bgb_machine::cooldown_timer();
    player.var_71280c614e54bce2++;
    self.bgb_machine_user = player;
    self.bgb_machine_open = 1;
    self.var_8c58cdcaa8138341 = bgb_machine::function_7a24f6084a281eac( player );
    thread bgb_machine::set_bgb_machine_state( "open" );
    
    if ( self.var_8c58cdcaa8138341 && isdefined( self.selected_bgb ) )
    {
        player callback::callback( "on_gobblegum_purchased", { #cost:cost, #name:self.selected_bgb } );
    }
    
    self waittill( #"gumball_available" );
    self.var_871b76b970146df8 = 1;
}

// Namespace bgb_machine_zm
// Params 2
// Checksum 0x2103ca0a, Offset: 0x2ae
// Size: 0xcc
function function_390979b4e3f992d5( player, base_cost )
{
    base_cost = level.var_e8ab6fe908f0124d;
    
    if ( player.var_71280c614e54bce2 < 1 )
    {
        return 0;
    }
    
    cost = base_cost;
    
    if ( player.var_71280c614e54bce2 >= 1 )
    {
        round = zm_utility::get_round_number();
        multi_mod = int( round / 10 );
        
        if ( multi_mod > 0 )
        {
            power_multiplier = pow( level.var_7d97f961e8f522d8, multi_mod );
            cost = power_multiplier * level.var_c5ba997d23c10a7f + 500;
        }
    }
    
    if ( player.var_71280c614e54bce2 >= 2 )
    {
        cost *= level.var_8fa1adc73c6dd067;
    }
    
    return int( cost );
}

