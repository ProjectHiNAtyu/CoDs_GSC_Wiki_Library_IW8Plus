// script_3f7d19e011d97209  (hash_3f7d19e011d97209.gscc) (size: 12127 Bytes / 0x2f5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x959f7f92 (2510258066)
// size ...... 12127 (0x2f5f)
// includes .. 9   (offset: 0x2b03)
// strings ... 79  (offset: 0x2b4b)
// dev strs .. 0   (offset: 0x2f5f)
// exports ... 21  (offset: 0x230f)
// cseg ...... 0xd43 + 0x15cc (0x230f)
// imports ... 40  (offset: 0x2657)
// animtree1 . 0   (offset: 0x2f5f)
// animtree2 . 0   (offset: 0x2f5f)
#using script_31ee2a173f3499b7;
#using script_5441a11286579ddc;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\purchasemenu;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_slayer;

#namespace namespace_423c46dff63ec005;

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x5
// Checksum 0xab60b092, Offset: 0xd61
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_63003b747423fea8", undefined, &init, undefined );
}

// Namespace namespace_423c46dff63ec005
// Params 0
// Checksum 0xf13fde1e, Offset: 0xd82
// Size: 0x9
function init()
{
    thread function_46c56b307b8e7488();
}

// Namespace namespace_423c46dff63ec005
// Params 0
// Checksum 0x7722975f, Offset: 0xd93
// Size: 0x5b
function function_46c56b307b8e7488()
{
    waittillframeend();
    level.ztron.var_3a44b8375f0be44b = 0;
    
    if ( level.ztron.blitzmode )
    {
        level.ztron.slayer.store.var_a7b1d95933803443 = &function_731b3c6c8d5796d7;
    }
}

// Namespace namespace_423c46dff63ec005
// Params 1, eflags: 0x4
// Checksum 0x5b9f3e13, Offset: 0xdf6
// Size: 0x4e
function private function_d08a958956e0faa( timeout )
{
    var_b57f04c2a6ccb5c7 = gettime() + int( timeout * 1000 );
    
    while ( level.ztron.var_2f73fe042a677255 > 0 && gettime() < var_b57f04c2a6ccb5c7 )
    {
        waitframe();
    }
}

// Namespace namespace_423c46dff63ec005
// Params 0
// Checksum 0xcbbee3c5, Offset: 0xe4c
// Size: 0x1e4
function function_731b3c6c8d5796d7()
{
    level.ztron.slayer.store.items = [];
    
    for ( i = 1; i <= 6 ; i++ )
    {
        level.ztron.slayer.store.items[ i ] = [];
    }
    
    tab_struct = purchasemenu::get_purchasemenu_tab( #"ztron_store", 1 );
    
    foreach ( item in tab_struct.items )
    {
        itemref = purchasemenu::create_item_struct( #"ztron_store", item.var_f5fec69ffd2456b2 );
        
        if ( !isdefined( itemref.itemref ) )
        {
            continue;
        }
        
        itemref.var_a47abb1173bf5614 = itemref.maxstack;
        
        if ( function_428f895d3c248ec0( itemref.itemref ) )
        {
            continue;
        }
        
        tier = itemref.tier;
        
        if ( tier < 1 || tier > 6 )
        {
            continue;
        }
        
        level.ztron.slayer.store.items[ tier ][ level.ztron.slayer.store.items[ tier ].size ] = itemref;
    }
}

// Namespace namespace_423c46dff63ec005
// Params 1
// Checksum 0x82f5e0ce, Offset: 0x1038
// Size: 0x222, Type: bool
function function_428f895d3c248ec0( itemref )
{
    switch ( itemref )
    {
        case #"hash_12143b0891997c47":
        case #"hash_1777a67de3f464e7":
        case #"hash_202f60657f23c4fc":
        case #"hash_23eeb47737d2d7ff":
        case #"hash_272419558a6e4d12":
        case #"hash_39d0620bc3222ce3":
        case #"hash_4011c09ee42ff32e":
        case #"hash_43d8abeddfe96c10":
        case #"hash_43f76b761ab788d6":
        case #"hash_4822c58b7d0fc518":
        case #"hash_48abedcfa3f8ac1f":
        case #"hash_490b54011370ddd8":
        case #"hash_52f6509bc3a01e7a":
        case #"hash_5d237838e4f7f6f3":
        case #"hash_6b3b67fd60885ebd":
        case #"hash_6b5325492738ed4d":
        case #"hash_7a4d46b61636be95":
        case #"hash_7b732493ff8c6383":
        case #"hash_8fdb999f8ed13737":
        case #"hash_8ff56dccb50de3f8":
        case #"hash_91ca690644a65145":
        case #"hash_960d686d7544b19e":
        case #"hash_98591dc23871f5d1":
        case #"hash_9a1ead6d6ade8f75":
        case #"hash_a64136777e1999b0":
        case #"hash_a815ba366422d932":
        case #"hash_b0fe1d09e95d0613":
        case #"hash_b7e07d8afccf57f6":
        case #"hash_bda60be3d6fc6ac2":
        case #"hash_c3dcd53f7be41c69":
        case #"hash_cb4853e4be395a71":
        case #"hash_d4978b62b9d7edff":
        case #"hash_d8436ae2b569ef05":
        case #"hash_d8c6d03982498ae7":
        case #"hash_e09c1fc8e12bab79":
        case #"hash_f7653acf05e2d1e6":
        case #"hash_fd0dd79a5d70a5f3":
        case #"hash_fe61fe134fc9a029":
            return true;
        default:
            break;
    }
    
    if ( issubstr( itemref, "_fate30" ) )
    {
        return true;
    }
    
    if ( issubstr( itemref, "_fate_" ) && issubstr( itemref, "_upgrade_" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0xdeb29180, Offset: 0x1263
// Size: 0xd7
function private function_e5ba032dff1e5b9e()
{
    bucket = [];
    bucket[ bucket.size ] = "ztron_store_barrel_bomb";
    bucket[ bucket.size ] = "ztron_store_teslaballx3";
    bucket[ bucket.size ] = "ztron_store_bgb_arsenal_accelerator";
    bucket[ bucket.size ] = "ztron_store_rocket_purple";
    bucket[ bucket.size ] = "ztron_store_blitz_perm_death";
    bucket[ bucket.size ] = "ztron_store_bgb_stock_option";
    bucket[ bucket.size ] = "ztron_store_nuke";
    bucket[ bucket.size ] = "ztron_store_bgb_explosive_flourish";
    bucket[ bucket.size ] = "ztron_store_bgb_free_fire";
    bucket[ bucket.size ] = "ztron_store_bgb_kill_joy";
    bucket[ bucket.size ] = "ztron_store_blitz_death_machine_upgrade";
    bucket[ bucket.size ] = "ztron_store_nuke";
    bucket[ bucket.size ] = "ztron_store_bgb_power_keg";
    bucket[ bucket.size ] = "ztron_store_blitz_arms_race";
    bucket[ bucket.size ] = "ztron_store_holybrimestone";
    bucket[ bucket.size ] = "ztron_store_bgb_dead_drop";
    bucket[ bucket.size ] = "ztron_store_bgb_wall_to_wall";
    bucket[ bucket.size ] = "ztron_store_level3Weapon5Minutes";
    return bucket;
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0xf6e8e38b, Offset: 0x1343
// Size: 0xd7
function private function_2353b2583688e5b2()
{
    bucket = [];
    bucket[ bucket.size ] = "ztron_store_sawblade_5min";
    bucket[ bucket.size ] = "ztron_store_bgb_soda_fountain";
    bucket[ bucket.size ] = "ztron_store_chicken_5min";
    bucket[ bucket.size ] = "ztron_store_mutant_injection";
    bucket[ bucket.size ] = "ztron_store_blitz_fowl_friend";
    bucket[ bucket.size ] = "ztron_store_sawblade_and_barrel_5min";
    bucket[ bucket.size ] = "ztron_store_blitz_red_feather";
    bucket[ bucket.size ] = "ztron_store_bgb_shields_up";
    bucket[ bucket.size ] = "ztron_store_bgb_power_vacuum";
    bucket[ bucket.size ] = "ztron_store_blitz_purple_feather";
    bucket[ bucket.size ] = "ztron_store_bucket_of_chicken_5min";
    bucket[ bucket.size ] = "ztron_store_bgb_crate_power";
    bucket[ bucket.size ] = "ztron_store_extra_life";
    bucket[ bucket.size ] = "ztron_store_blitz_war_talons";
    bucket[ bucket.size ] = "ztron_store_bgb_respin_cycle";
    bucket[ bucket.size ] = "ztron_store_helo";
    bucket[ bucket.size ] = "ztron_store_bgb_wall_power";
    bucket[ bucket.size ] = "ztron_store_bgb_requipment";
    return bucket;
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0xb149932b, Offset: 0x1423
// Size: 0x184
function private function_f4a2d55dbbe20141()
{
    var_7efb5ad4ce85c699 = [];
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_brainrot";
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_cryo";
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_deadwire";
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_firework";
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_lightray";
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_napalm";
    var_7efb5ad4ce85c699[ var_7efb5ad4ce85c699.size ] = "ztron_store_ammo_shadow";
    fieldUpgrades = [];
    fieldUpgrades[ fieldUpgrades.size ] = "ztron_store_super_aether_shroud";
    fieldUpgrades[ fieldUpgrades.size ] = "ztron_store_super_dark_flare";
    fieldUpgrades[ fieldUpgrades.size ] = "ztron_store_super_energy_mine";
    fieldUpgrades[ fieldUpgrades.size ] = "ztron_store_super_frost_blast";
    fieldUpgrades[ fieldUpgrades.size ] = "ztron_store_super_mary_paris";
    fieldUpgrades[ fieldUpgrades.size ] = "ztron_store_super_tesla_storm";
    bucket = [];
    bucket[ bucket.size ] = "ztron_store_demolition";
    bucket[ bucket.size ] = "ztron_store_booster";
    bucket[ bucket.size ] = var_7efb5ad4ce85c699[ randomint( var_7efb5ad4ce85c699.size ) ];
    bucket[ bucket.size ] = "ztron_store_bgb_arsenal_accelerator";
    bucket[ bucket.size ] = "ztron_store_blitz_fast_player";
    bucket[ bucket.size ] = "ztron_store_bootcamp";
    bucket[ bucket.size ] = fieldUpgrades[ randomint( fieldUpgrades.size ) ];
    bucket[ bucket.size ] = "ztron_store_warmachine";
    bucket[ bucket.size ] = "ztron_store_advanced_weapon_training";
    bucket[ bucket.size ] = "ztron_store_blitz_cinder_toes";
    bucket[ bucket.size ] = "ztron_store_health_regen";
    bucket[ bucket.size ] = "ztron_store_bgb_power_keg";
    bucket[ bucket.size ] = "ztron_store_extra_life";
    bucket[ bucket.size ] = "ztron_store_bgb_wall_power";
    bucket[ bucket.size ] = "ztron_store_blitz_extra_boosts";
    bucket[ bucket.size ] = "ztron_store_ride_rings";
    bucket[ bucket.size ] = "ztron_store_deadops";
    bucket[ bucket.size ] = "ztron_store_bgb_elementary";
    return bucket;
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0x870b14ad, Offset: 0x15b0
// Size: 0x91
function private function_3b85ac16bc2b02b1()
{
    self.ztron.var_5a1110f58f547858 = [];
    self.ztron.var_5a1110f58f547858[ 0 ] = function_e5ba032dff1e5b9e();
    self.ztron.var_5a1110f58f547858[ 1 ] = function_2353b2583688e5b2();
    self.ztron.var_5a1110f58f547858[ 2 ] = function_f4a2d55dbbe20141();
    self.ztron.var_e5f5d37dc0fa73e5 = [ 0, 0, 0 ];
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0xadea978c, Offset: 0x1649
// Size: 0xc1
function private function_a0086dfae5530ef7()
{
    choices = [];
    self.ztron.var_ce97f1ccbace1695 = [];
    
    for ( b = 0; b < self.ztron.var_5a1110f58f547858.size ; b++ )
    {
        bucket = self.ztron.var_5a1110f58f547858[ b ];
        
        if ( bucket.size == 0 )
        {
            continue;
        }
        
        ref = bucket[ 0 ];
        item = ztron_slayer::function_714b4f935c8d2f0c( ref );
        
        if ( isdefined( item ) )
        {
            self.ztron.var_ce97f1ccbace1695[ choices.size ] = b;
            choices[ choices.size ] = item;
        }
    }
    
    return choices;
}

// Namespace namespace_423c46dff63ec005
// Params 1, eflags: 0x4
// Checksum 0x961e0977, Offset: 0x1713
// Size: 0x55
function private function_b1a0d9f2ca388e42( bucketidx )
{
    self.ztron.var_5a1110f58f547858[ bucketidx ] = arrayremove( self.ztron.var_5a1110f58f547858[ bucketidx ], self.ztron.var_5a1110f58f547858[ bucketidx ][ 0 ] );
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0x3808393b, Offset: 0x1770
// Size: 0xb9
function private function_87872baa9b81b87b()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.ztron ) && isdefined( player.ztron.meta ) )
        {
            if ( namespace_4f98d1d7dc3196d::function_996793ae2b9b6a3c( player, "masterBlaster" ) >= 5 )
            {
                player namespace_4f98d1d7dc3196d::awardtoken( 1 );
            }
        }
    }
}

// Namespace namespace_423c46dff63ec005
// Params 0, eflags: 0x4
// Checksum 0x1b9c2ade, Offset: 0x1831
// Size: 0xc4
function private function_d0c6ea9b230193c8()
{
    swap = [];
    pairs = [];
    pairs[ pairs.size ] = "ztron_store_blitz_fowl_friend";
    pairs[ pairs.size ] = "ztron_store_bgb_power_vacuum";
    pairs[ pairs.size ] = "ztron_store_blitz_fast_player";
    pairs[ pairs.size ] = "ztron_store_blitz_cinder_toes";
    swap[ "ztron_store_blitz_perm_death" ] = pairs;
    pairs = [];
    pairs[ pairs.size ] = "ztron_store_blitz_perm_death";
    pairs[ pairs.size ] = "ztron_store_bgb_free_fire";
    pairs[ pairs.size ] = "ztron_store_blitz_fast_player";
    pairs[ pairs.size ] = "ztron_store_blitz_cinder_toes";
    swap[ "ztron_store_blitz_fowl_friend" ] = pairs;
    pairs = [];
    pairs[ pairs.size ] = "ztron_store_blitz_perm_death";
    pairs[ pairs.size ] = "ztron_store_bgb_free_fire";
    pairs[ pairs.size ] = "ztron_store_blitz_fowl_friend";
    pairs[ pairs.size ] = "ztron_store_bgb_power_vacuum";
    swap[ "ztron_store_blitz_fast_player" ] = pairs;
    return swap;
}

// Namespace namespace_423c46dff63ec005
// Params 3, eflags: 0x4
// Checksum 0xc3703dce, Offset: 0x18fe
// Size: 0x8f, Type: bool
function private function_30cde5015e4aa2eb( bucket, itema, itemb )
{
    idxa = -1;
    idxb = -1;
    
    for ( i = 0; i < bucket.size ; i++ )
    {
        if ( bucket[ i ] == itema )
        {
            idxa = i;
            continue;
        }
        
        if ( bucket[ i ] == itemb )
        {
            idxb = i;
        }
    }
    
    if ( idxa >= 0 && idxb >= 0 )
    {
        bucket[ idxa ] = itemb;
        bucket[ idxb ] = itema;
        return true;
    }
    
    return false;
}

// Namespace namespace_423c46dff63ec005
// Params 2, eflags: 0x4
// Checksum 0x481ef203, Offset: 0x1996
// Size: 0xf2
function private function_6a2490cac4a83508( chosenbucket, var_f6945d3de79f4890 )
{
    swaptable = function_d0c6ea9b230193c8();
    
    if ( !isdefined( swaptable[ var_f6945d3de79f4890 ] ) )
    {
        return;
    }
    
    swappairs = swaptable[ var_f6945d3de79f4890 ];
    p = 0;
    
    while ( p + 1 < swappairs.size )
    {
        for ( b = 0; b < self.ztron.var_5a1110f58f547858.size ; b++ )
        {
            if ( b == chosenbucket || self.ztron.var_e5f5d37dc0fa73e5[ b ] )
            {
                continue;
            }
            
            if ( function_30cde5015e4aa2eb( self.ztron.var_5a1110f58f547858[ b ], swappairs[ p ], swappairs[ p + 1 ] ) )
            {
                self.ztron.var_e5f5d37dc0fa73e5[ b ] = 1;
            }
        }
        
        p += 2;
    }
}

// Namespace namespace_423c46dff63ec005
// Params 1
// Checksum 0x623763ec, Offset: 0x1a90
// Size: 0xf1
function function_c0ca6b6e15e9ae7f( arenaid )
{
    level endon( #"ztron_game_is_over" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player.ztron.upgradeMask & 17179869184 && player namespace_a6a7fe92789f4ad9::function_d99937c243f5f1d6() == 0 )
        {
            player thread ztron_slayer::ztron_store_item_grant( "ztron_nuke", 1 );
        }
    }
    
    if ( arenaid >= 19 )
    {
        return;
    }
    
    wait 1;
    timeout = 15;
    function_d2c0a9d1528a8a3e( arenaid, timeout );
}

// Namespace namespace_423c46dff63ec005
// Params 2, eflags: 0x4
// Checksum 0x1cf1da2, Offset: 0x1b89
// Size: 0x174
function private function_d2c0a9d1528a8a3e( arenaid, timeout )
{
    level endon( #"ztron_game_is_over" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.ztron.var_5a1110f58f547858 ) )
        {
            player function_3b85ac16bc2b02b1();
        }
    }
    
    level.ztron.var_2f73fe042a677255 = 0;
    
    foreach ( player in level.players )
    {
        choices = player function_a0086dfae5530ef7();
        
        if ( choices.size > 0 )
        {
            level.ztron.var_2f73fe042a677255++;
            player thread function_1817389e796245c4( choices, timeout );
        }
    }
    
    function_d08a958956e0faa( timeout + 2 );
}

// Namespace namespace_423c46dff63ec005
// Params 2, eflags: 0x4
// Checksum 0xb555a49e, Offset: 0x1d05
// Size: 0x26d
function private function_1817389e796245c4( choices, timeout )
{
    self endon( #"disconnect" );
    
    if ( choices.size == 0 )
    {
        level.ztron.var_2f73fe042a677255--;
        return;
    }
    
    ztron_ui::ztron_fate_upgrade_show( choices, int( timeout ), int( timeout ) + 2, "scripted_widget_ztron_blitz_upgrade" );
    msg = utility::waittill_any_timeout( timeout, "ztron_fate_upgrade_item_chosen" );
    
    if ( msg == "ztron_fate_upgrade_item_chosen" )
    {
        chosenitem = self.ztron.var_a29e0ac675549772;
    }
    else
    {
        chosenitem = choices[ randomint( choices.size ) ];
    }
    
    if ( isdefined( chosenitem ) )
    {
        self.ztron.var_293457251497a573 = 1;
        self.ztron.var_1273ec6eee47c2 = undefined;
        self setclientomnvar( "ui_ztron_fate_upgrade_chosen_idx", chosenitem.globalindex );
        wait 1.5;
        self setclientomnvar( "ui_ztron_fate_upgrade_chosen_idx", 255 );
        self.ztron.var_293457251497a573 = 0;
        
        if ( isdefined( self.ztron.var_ce97f1ccbace1695 ) )
        {
            for ( i = 0; i < choices.size ; i++ )
            {
                if ( choices[ i ].itemref == chosenitem.itemref )
                {
                    chosenbucket = self.ztron.var_ce97f1ccbace1695[ i ];
                    function_b1a0d9f2ca388e42( chosenbucket );
                    
                    if ( self.ztron.var_5a1110f58f547858[ chosenbucket ].size == 0 )
                    {
                        function_87872baa9b81b87b();
                    }
                    
                    if ( issubstr( chosenitem.itemref, "ztron_store_blitz_" ) )
                    {
                        function_6a2490cac4a83508( chosenbucket, chosenitem.itemref );
                    }
                    
                    break;
                }
            }
            
            self.ztron.var_ce97f1ccbace1695 = undefined;
        }
        
        if ( !isdefined( self.ztron.var_a644b55a4197f7cf ) )
        {
            self.ztron.var_a644b55a4197f7cf = [];
        }
        
        self.ztron.var_a644b55a4197f7cf[ self.ztron.var_a644b55a4197f7cf.size ] = chosenitem.itemref;
        ztron_slayer::function_e444cf78bd758cb9( chosenitem );
    }
    
    level.ztron.var_2f73fe042a677255--;
}

// Namespace namespace_423c46dff63ec005
// Params 0
// Checksum 0x1815f6c6, Offset: 0x1f7a
// Size: 0x395
function function_8a34ddd0e9e79242()
{
    level endon( #"arena_completed", #"ztron_game_is_over", #"arena_deactivated", #"ztron_teleporter_taken" );
    
    if ( !isdefined( level.ztron.var_acd7346203660b39 ) || level.ztron.var_9a38721bfdf46da <= 0 )
    {
        return;
    }
    
    if ( level.ztron.currentarena < 0 )
    {
        return;
    }
    
    while ( !isdefined( level.ztron.blitzstarttime ) )
    {
        waitframe();
    }
    
    if ( level.ztron.var_cbceca19d7ef7c87 )
    {
        return;
    }
    
    wait 5 + randomint( 10 );
    
    if ( utility::flag( "ztron_round_over" ) || !isdefined( level.ztron.active_arena ) )
    {
        return;
    }
    
    arena = level.ztron.active_arena;
    piecesleft = level.ztron.var_9a38721bfdf46da;
    
    if ( level.ztron.currentarena >= 19 )
    {
        while ( level.ztron.var_9a38721bfdf46da > 0 )
        {
            spot = arena.lootspots[ randomint( arena.lootspots.size ) ];
            ztron_item::requestspawnitem( level.ztron.var_acd7346203660b39, spot.origin, 52 );
            level.ztron.var_9a38721bfdf46da--;
            ztron_debug::debugmsg( "Blitz force-dumping timepiece in boss arena (" + level.ztron.var_9a38721bfdf46da + " left)" );
            
            if ( level.ztron.var_9a38721bfdf46da > 0 )
            {
                wait 3;
            }
        }
        
        return;
    }
    
    var_5e6ecf2a6ec0fd2c = 19 - level.ztron.currentarena;
    var_ed090fd41e1ee80a = 18 - level.ztron.currentarena;
    
    if ( var_ed090fd41e1ee80a <= 0 )
    {
        var_ed090fd41e1ee80a = 1;
    }
    
    forcespawn = piecesleft >= var_5e6ecf2a6ec0fd2c;
    probability = 1 - pow( var_ed090fd41e1ee80a / ( piecesleft + var_ed090fd41e1ee80a ), 2 );
    roll = randomfloat( 1 );
    
    if ( forcespawn || roll < probability || level.ztron.currentarena >= 18 )
    {
        spot = arena.lootspots[ randomint( arena.lootspots.size ) ];
        ztron_item::requestspawnitem( level.ztron.var_acd7346203660b39, spot.origin, 52 );
        level.ztron.var_9a38721bfdf46da--;
        level.ztron.var_cbceca19d7ef7c87 = 1;
        ztron_debug::debugmsg( "Blitz timepiece dropped in arena " + level.ztron.currentarena + " (" + level.ztron.var_9a38721bfdf46da + " left)" + ( forcespawn ? " [FORCED]" : "" ) );
        return;
    }
    
    ztron_debug::debugmsg( "Blitz timepiece skipped in arena " + level.ztron.currentarena + " (prob " + probability + ", " + piecesleft + " left)" );
}

