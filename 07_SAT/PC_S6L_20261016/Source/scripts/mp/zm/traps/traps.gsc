// scripts\mp\zm\traps\traps.gsc  (hash_26063cef13ebd0fb.gscc) (size: 20261 Bytes / 0x4f25 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ef5429c (519389852)
// size ...... 20261 (0x4f25)
// includes .. 7   (offset: 0x493d)
// strings ... 37  (offset: 0x4975)
// dev strs .. 44  (offset: 0x4cad)
// exports ... 31  (offset: 0x3925)
// cseg ...... 0x300 + 0x3625 (0x3925)
// imports ... 83  (offset: 0x3dfd)
// animtree1 . 0   (offset: 0x4f25)
// animtree2 . 0   (offset: 0x4f25)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;

#namespace traps;

// Namespace traps
// Params 0
// Checksum 0xe8b899df, Offset: 0x31e
// Size: 0x10
function pre_init()
{
    level.var_655315530ac9b6a1 = &function_e1ecf079d6d4a1c8;
}

// Namespace traps
// Params 2
// Checksum 0xfec32032, Offset: 0x336
// Size: 0x1f9
function function_e1ecf079d6d4a1c8( victim, attacker )
{
    if ( attacker.targetname == "trap_attacker" && isdefined( attacker.trap_scriptable ) )
    {
        if ( !isdefined( attacker.var_59419e7814190b1d ) )
        {
            attacker.var_59419e7814190b1d = 0;
        }
        
        if ( attacker.var_59419e7814190b1d == 0 )
        {
            attacker thread trap_kill_watcher();
        }
        
        attacker.var_59419e7814190b1d++;
        
        if ( attacker.var_59419e7814190b1d == 25 )
        {
            if ( isalive( attacker.activator ) )
            {
                attacker.activator namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_ambush" );
            }
        }
        
        switch ( attacker.var_fcda7168a743663a )
        {
            case #"hash_542e3bc12e7679e0":
                var_ce318cb2d931ad92 = 5;
                str_medal = #"hash_ebd44d089398fc62";
                break;
            case #"hash_a25f8da842014a15":
                var_ce318cb2d931ad92 = 10;
                str_medal = #"medal_fire";
                break;
            case #"hash_6ba8e38bd7446481":
                var_ce318cb2d931ad92 = 10;
                str_medal = #"medal_caustic";
                break;
            case #"hash_221db8e89a49ea54":
                var_ce318cb2d931ad92 = 5;
                str_medal = #"hash_ae98cd4e8f59b4a";
                break;
            default:
                var_ce318cb2d931ad92 = 99;
                str_medal = #"medal_ambush";
                break;
        }
        
        if ( attacker.var_59419e7814190b1d == var_ce318cb2d931ad92 )
        {
            if ( isalive( attacker.activator ) )
            {
                attacker.activator namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( str_medal );
            }
        }
        
        if ( isplayer( attacker.activator ) )
        {
            params = spawnstruct();
            params.var_59419e7814190b1d = attacker.var_59419e7814190b1d;
            attacker.activator callback::callback( "trap_kill", params );
        }
    }
}

// Namespace traps
// Params 0
// Checksum 0x36d946a5, Offset: 0x537
// Size: 0x35
function trap_kill_watcher()
{
    while ( true )
    {
        if ( self.trap_scriptable getscriptablepartstate( "base", 1 ) != "activate" )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_59419e7814190b1d = 0;
}

// Namespace traps
// Params 1
// Checksum 0xc1763b37, Offset: 0x574
// Size: 0xeb
function function_80c9f68d350fb272( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        if ( isdefined( params.einflictor ) && params.einflictor.targetname == "trap_attacker" )
        {
            score_params = spawnstruct();
            
            if ( isdefined( params.einflictor.score_event ) )
            {
                score_params.scoreevent = params.einflictor.score_event;
            }
            else
            {
                score_params.scoreevent = #"zombie_kia_dark_aether_field_trap";
            }
            
            if ( isdefined( params.einflictor.activator ) )
            {
                params.einflictor.activator callback::callback( "zombie_score_event", score_params );
            }
        }
    }
}

// Namespace traps
// Params 8
// Checksum 0x1e143d83, Offset: 0x667
// Size: 0x382
function function_63a557f0f22161af( str_targetname, trap_activate_callback, trap_deactivate_callback, var_93a1878f1901b4f7, var_4dcbf485031cd3e6, var_68aecb068aaf8bf7, custom_power_on_func, params )
{
    if ( !isdefined( level.var_f301c0b95ea728e2 ) )
    {
        if ( !isdefined( level.var_f301c0b95ea728e2 ) )
        {
            level.var_f301c0b95ea728e2 = [];
        }
    }
    
    if ( !level.gametypebundle.var_b19993a744636fb5 )
    {
        return;
    }
    
    var_7d6a5d59c7b0f5a5 = utility::getstructarray( str_targetname, "targetname" );
    
    if ( isdefined( trap_activate_callback ) )
    {
        foreach ( trap_switch in var_7d6a5d59c7b0f5a5 )
        {
            trap_switch.trap_activate_callback = trap_activate_callback;
        }
    }
    
    if ( isdefined( trap_deactivate_callback ) )
    {
        foreach ( trap_switch in var_7d6a5d59c7b0f5a5 )
        {
            trap_switch.trap_deactivate_callback = trap_deactivate_callback;
        }
    }
    
    if ( isdefined( var_93a1878f1901b4f7 ) )
    {
        foreach ( trap_switch in var_7d6a5d59c7b0f5a5 )
        {
            trap_switch.var_93a1878f1901b4f7 = var_93a1878f1901b4f7;
        }
    }
    
    if ( isdefined( var_4dcbf485031cd3e6 ) )
    {
        foreach ( trap_switch in var_7d6a5d59c7b0f5a5 )
        {
            trap_switch.var_4dcbf485031cd3e6 = var_4dcbf485031cd3e6;
        }
    }
    
    if ( isdefined( var_68aecb068aaf8bf7 ) )
    {
        foreach ( trap_switch in var_7d6a5d59c7b0f5a5 )
        {
            trap_switch.var_68aecb068aaf8bf7 = var_68aecb068aaf8bf7;
        }
    }
    
    if ( isdefined( custom_power_on_func ) )
    {
        foreach ( trap_switch in var_7d6a5d59c7b0f5a5 )
        {
            trap_switch.custom_power_on_func = custom_power_on_func;
        }
    }
    
    level.var_f301c0b95ea728e2 = arraycombineunique( level.var_f301c0b95ea728e2, var_7d6a5d59c7b0f5a5 );
    utility::array_thread( var_7d6a5d59c7b0f5a5, &init_trap, params );
}

// Namespace traps
// Params 9
// Checksum 0x3d3970cc, Offset: 0x9f1
// Size: 0x1bf
function function_84ce1d5572ecd46a( str_targetname, var_42ced0809531114b, str_purchase, str_activate, str_cooldown, str_custom, str_not_enough_essence, str_trap_title, var_3f77d5fa92c1edbb )
{
    var_7d6a5d59c7b0f5a5 = utility::getstructarray( str_targetname, "targetname" );
    
    foreach ( trap in var_7d6a5d59c7b0f5a5 )
    {
        if ( !isdefined( trap.string_hints ) )
        {
            trap.string_hints = [];
        }
        
        if ( isdefined( var_42ced0809531114b ) )
        {
            trap.string_hints[ "power" ] = var_42ced0809531114b;
        }
        
        if ( isdefined( str_purchase ) )
        {
            trap.string_hints[ "buyable" ] = str_purchase;
        }
        
        if ( isdefined( str_activate ) )
        {
            trap.string_hints[ "activate" ] = str_activate;
        }
        
        if ( isdefined( str_cooldown ) )
        {
            trap.string_hints[ "cooldown" ] = str_cooldown;
        }
        
        if ( isdefined( str_custom ) )
        {
            trap.string_hints[ "custom" ] = str_custom;
        }
        
        if ( isdefined( str_not_enough_essence ) )
        {
            trap.string_hints[ "not_enough_essence" ] = str_not_enough_essence;
        }
        
        if ( isdefined( str_trap_title ) )
        {
            trap.string_hints[ "trap_title" ] = str_trap_title;
        }
        
        if ( isdefined( var_3f77d5fa92c1edbb ) )
        {
            trap.string_hints[ "description" ] = var_3f77d5fa92c1edbb;
        }
    }
}

// Namespace traps
// Params 2
// Checksum 0x298fc792, Offset: 0xbb8
// Size: 0x12c
function function_1bbf8ccfa1d3efa( str_targetname, var_ba501304b86b1487 )
{
    var_7d6a5d59c7b0f5a5 = utility::getstructarray( str_targetname, "targetname" );
    
    foreach ( trap in var_7d6a5d59c7b0f5a5 )
    {
        foreach ( trap_info in trap.trap_positions )
        {
            if ( isdefined( trap_info.attack_entity ) )
            {
                trap_info.attack_entity.score_event = var_ba501304b86b1487;
            }
        }
    }
}

// Namespace traps
// Params 1
// Checksum 0x8f37cdcf, Offset: 0xcec
// Size: 0x18f
function init_trap( params )
{
    if ( !isdefined( self.string_hints ) )
    {
        self.string_hints = [];
    }
    
    self.a_switch_pos = utility::getstructarray( self.target, "targetname" );
    self.trap_positions = utility::getstructarray( self.a_switch_pos[ 0 ].target, "targetname" );
    
    foreach ( switch_pos in self.a_switch_pos )
    {
        switch_pos thread init_switch( self, params );
    }
    
    foreach ( trap_pos in self.trap_positions )
    {
        trap_pos thread spawn_trap_scriptable( self );
    }
    
    function_6ddc0b65d69cf40c();
    level utility::flag_set( self.targetname + "_trap_init_finished" );
    
    /#
        level.var_d6ac96657b3d40e7 = 5;
        setup_trap_devgui();
    #/
}

// Namespace traps
// Params 0
// Checksum 0xe3a13e09, Offset: 0xe83
// Size: 0xb0
function function_6ddc0b65d69cf40c()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_b7b9bb70a79aaab1 = 1;
        
        foreach ( switch_pos in self.a_switch_pos )
        {
            if ( !isdefined( switch_pos.interact ) )
            {
                var_b7b9bb70a79aaab1 = 0;
            }
        }
        
        if ( var_b7b9bb70a79aaab1 )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace traps
// Params 2
// Checksum 0x8decab6c, Offset: 0xf3b
// Size: 0x55b
function init_switch( myparent, params )
{
    self.var_32f1e7774266024b = myparent;
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( self.script_modelname ) )
    {
        self.switch_scriptable = utility::spawn_model( self.script_modelname, self.origin, self.angles );
    }
    else if ( isdefined( self.script_label ) )
    {
        self.switch_scriptable = spawnscriptable( self.script_label, self.origin, self.angles );
        self.var_1ed9309883ffd20d = 0;
    }
    else
    {
        self.switch_scriptable = spawnscriptable( "t10_zm_trap_switch", self.origin, self.angles );
        self.var_1ed9309883ffd20d = 1;
    }
    
    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.switch_scriptable, "icon" );
    assert( self.switch_scriptable getscriptablehaspart( "<dev string:x24>" ), "<dev string:x29>" + self.origin + "<dev string:x43>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:x5f>" ), "<dev string:x29>" + self.origin + "<dev string:x68>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:x98>" ), "<dev string:x29>" + self.origin + "<dev string:xa1>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:xd1>" ), "<dev string:x29>" + self.origin + "<dev string:xd7>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:x104>" ), "<dev string:x29>" + self.origin + "<dev string:x10d>" );
    self.switch_scriptable.var_32f1e7774266024b = myparent;
    
    if ( self.var_1ed9309883ffd20d )
    {
        self.animation_proxy = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self.switch_scriptable scriptablesetparententity( self.animation_proxy );
        self.animation_proxy rotateroll( 90, 0.5, 0.1, 0.1 );
    }
    
    self.radius = myparent.radius ?? 50;
    self.script_cost = int( myparent.script_cost ?? 500 );
    self.script_currency = myparent.script_currency ?? #"essence";
    self.script_duration = int( myparent.script_duration ?? 60 );
    self.script_timeout = int( myparent.script_timeout ?? 15 );
    radius_type = myparent.script_label ?? "small_white_dot";
    
    if ( isdefined( params.var_5e130bba976c4cc1 ) )
    {
        fwd = anglestoforward( self.angles );
        interact_org = self.origin + fwd * params.var_5e130bba976c4cc1;
    }
    else
    {
        interact_org = self.origin;
    }
    
    self.interact = function_afebc76c388796fe( interact_org, &switch_used, &function_c1d665c28c7c2175, radius_type );
    self.interact.b_cool_down = 1;
    self.interact.s_trapbuy = myparent;
    self.interact.s_switch = self;
    
    if ( params.var_25e31af90e9437ee && isdefined( self.var_32f1e7774266024b.script_flag_set ) )
    {
        self.interact thread function_6da008af6330b88( self.var_32f1e7774266024b.script_flag_set );
    }
    
    if ( params.var_d2f0379eae0e4e36 && params.var_9082dc2b9645cabb )
    {
        n_forward_offset = params.var_9082dc2b9645cabb;
        self.child_scriptable = spawnscriptable( params.var_d2f0379eae0e4e36, self.origin + anglestoforward( self.angles ) * n_forward_offset, self.angles );
    }
    
    if ( isdefined( myparent.script_power ) && !utility::flag( myparent.script_power ) )
    {
        self.interact.state = "power";
        thread function_8f18198a1c4e8d35( myparent.script_power );
        set_switch_scriptable_state( "base", self.interact.state );
        return;
    }
    
    self.interact.state = "buyable";
    set_switch_scriptable_state( "base", self.interact.state );
}

// Namespace traps
// Params 1, eflags: 0x4
// Checksum 0x85960784, Offset: 0x149e
// Size: 0x46
function private function_6da008af6330b88( flag )
{
    self setscriptablepartstate( "base", "off" );
    level endon( #"game_ended" );
    level utility::flag_wait( flag );
    self setscriptablepartstate( "base", self.radius_type );
}

// Namespace traps
// Params 4
// Checksum 0x88cf76c, Offset: 0x14ec
// Size: 0xd1
function function_afebc76c388796fe( org_or_ent, use_callback, var_b2107da793be51f7, radius_type )
{
    var_45b620bc30783968 = undefined;
    
    if ( isvector( org_or_ent ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_quest_scriptable_interact", org_or_ent );
    }
    else if ( isvector( org_or_ent.origin ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_quest_scriptable_interact", org_or_ent.origin );
    }
    
    if ( !isdefined( var_45b620bc30783968 ) )
    {
        print( "<dev string:x13d>" );
        return;
    }
    
    var_45b620bc30783968.radius_type = radius_type;
    var_45b620bc30783968 utility::function_7c10ea82c1e305b8( "base", radius_type );
    
    if ( isfunction( var_b2107da793be51f7 ) )
    {
        var_45b620bc30783968 interaction::set_interact_hint_callback( var_b2107da793be51f7 );
    }
    
    if ( isfunction( use_callback ) )
    {
        var_45b620bc30783968 = interaction::register_scriptable_interact( var_45b620bc30783968, use_callback );
    }
    
    return var_45b620bc30783968;
}

// Namespace traps
// Params 2
// Checksum 0x6a179510, Offset: 0x15c6
// Size: 0xf1
function set_switch_scriptable_state( str_part, str_state )
{
    if ( isdefined( self.interact ) && self.interact.var_94d1ab5da995e573 )
    {
        return;
    }
    
    switch ( str_state )
    {
        case #"hash_5ff4908e6e9a0426":
        case #"hash_e0b47474a33283f0":
            sbl_state = "no_power";
            break;
        case #"hash_4fdec2979b2f4017":
        case #"hash_8818ed9a4ecf6ed4":
            sbl_state = "ready";
            break;
        case #"hash_b389e7ddef378fd0":
            sbl_state = "activate";
            break;
        case #"hash_7b6614415d1b2e48":
        case #"hash_a018e6f02f48c018":
            sbl_state = "cooldown";
            break;
        case #"hash_f2cd9b714333fcd4":
            sbl_state = "update";
            break;
    }
    
    self.switch_scriptable setscriptablepartstate( str_part, sbl_state );
}

// Namespace traps
// Params 1
// Checksum 0xee347997, Offset: 0x16bf
// Size: 0x2c2
function spawn_trap_scriptable( myparent )
{
    self.var_32f1e7774266024b = myparent;
    
    if ( isdefined( self.script_modelname ) )
    {
        self.trap_scriptable = utility::spawn_model( self.script_modelname, self.origin, self.angles );
    }
    else if ( isdefined( self.script_label ) )
    {
        self.trap_scriptable = spawnscriptable( self.script_label, self.origin, self.angles );
    }
    
    assert( isdefined( self.trap_scriptable ), "<dev string:x164>" + self.origin + "<dev string:x183>" );
    assert( self.trap_scriptable getscriptablehaspart( "<dev string:x24>" ), "<dev string:x210>" + self.origin + "<dev string:x223>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:x5f>" ), "<dev string:x210>" + self.origin + "<dev string:x68>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:x98>" ), "<dev string:x210>" + self.origin + "<dev string:xa1>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:xd1>" ), "<dev string:x210>" + self.origin + "<dev string:xd7>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x24>", "<dev string:x104>" ), "<dev string:x210>" + self.origin + "<dev string:x10d>" );
    
    if ( isent( self.trap_scriptable ) )
    {
        self.attack_entity = self.trap_scriptable;
    }
    else
    {
        self.attack_entity = utility::spawn_model( "tag_origin", self.origin, self.angles );
    }
    
    self.attack_entity.targetname = "trap_attacker";
    self.attack_entity.trap_scriptable = self.trap_scriptable;
    self.attack_entity.var_fcda7168a743663a = self.var_32f1e7774266024b.targetname;
    
    if ( isdefined( myparent.script_power ) && !utility::flag( myparent.script_power ) )
    {
        set_trap_scriptable_state( "base", "no_power" );
        level utility::flag_wait( myparent.script_power );
        set_trap_scriptable_state( "base", "ready" );
        return;
    }
    
    set_trap_scriptable_state( "base", "ready" );
}

// Namespace traps
// Params 2
// Checksum 0x5863eb5a, Offset: 0x1989
// Size: 0x3f
function set_trap_scriptable_state( str_part, str_state )
{
    if ( isdefined( self.trap_scriptable ) )
    {
        self.trap_scriptable setscriptablepartstate( str_part, str_state );
        return;
    }
    
    self setscriptablepartstate( str_part, str_state );
}

// Namespace traps
// Params 1
// Checksum 0x116fdd5c, Offset: 0x19d0
// Size: 0x88
function function_8f18198a1c4e8d35( str_flag )
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.var_32f1e7774266024b.custom_power_on_func ) )
    {
        self [[ self.var_32f1e7774266024b.custom_power_on_func ]]();
    }
    
    level utility::flag_wait( str_flag );
    self.interact.state = "buyable";
    set_switch_scriptable_state( "base", self.interact.state );
}

// Namespace traps
// Params 2
// Checksum 0x564d6df3, Offset: 0x1a60
// Size: 0x3fb
function function_c1d665c28c7c2175( interact, player )
{
    b_interactable = 1;
    
    if ( isdefined( player ) && isdefined( interact.s_switch.script_cost ) && !player currency::can_afford( #"essence", interact.s_switch.script_cost ) )
    {
        aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        b_interactable = 0;
    }
    
    if ( isdefined( interact.s_trapbuy.script_power ) && !utility::flag( interact.s_trapbuy.script_power ) )
    {
        state = "power";
    }
    else
    {
        state = interact.state;
    }
    
    if ( !isdefined( state ) )
    {
        return;
    }
    
    if ( isdefined( player ) && player.interactions_disabled || interact.var_94d1ab5da995e573 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( level utility::flag( "all_traps_disabled" ) )
    {
        return { #string:&"shared_hintstrings/traps_disabled", #type:"HINT_NOBUTTON" };
    }
    else if ( interact utility::ent_flag( "trap_disabled" ) )
    {
        return { #string:&"shared_hintstrings/trap_disabled", #type:"HINT_NOBUTTON" };
    }
    
    if ( isdefined( interact.s_trapbuy.var_4dcbf485031cd3e6 ) && interact.s_trapbuy [[ interact.s_trapbuy.var_4dcbf485031cd3e6 ]]( player ) )
    {
        state = "custom";
    }
    
    str_button_type = "HINT_BUTTON";
    var_bcfe0ed5ba4c9e74 = interact.s_switch.script_cost;
    str_button_callout = &"SHARED_HINTSTRINGS/HINT_BUY";
    str_icon_text = &"SHARED_HINTSTRINGS/COST_ESSENCE";
    var_25ca4f7bf09cfe46 = interact.s_switch.script_cost;
    
    switch ( state )
    {
        case #"hash_7b6614415d1b2e48":
            hint = interact function_2f771b7c8fca1d18( "cooldown" );
            b_interactable = 0;
            break;
        case #"hash_4fdec2979b2f4017":
            hint = interact function_2f771b7c8fca1d18( "buyable", player );
            break;
        case #"hash_5ff4908e6e9a0426":
            hint = interact function_2f771b7c8fca1d18( "power" );
            b_interactable = 0;
            break;
        case #"hash_b389e7ddef378fd0":
            hint = interact function_2f771b7c8fca1d18( "activate" );
            b_interactable = 0;
            break;
        case #"hash_44e999799ff10fce":
            hint_type = interact function_2f771b7c8fca1d18( "custom" );
            return hint_type;
    }
    
    trap_title = interact.trap_title ?? &"SHARED_HINTSTRINGS/TRAP_TITLE";
    trap_icon = interact.trap_icon ?? "ui_icon_zm_ping_trap";
    trap_desc = interact.trap_desc ?? &"hash_38d0628731f81057";
    aux_text = interact.aux_text ?? "";
    return { #interactable:b_interactable, #icon_text_value:var_25ca4f7bf09cfe46, #var_776a268784e089af:str_icon_text, #icon:trap_icon, #buttoncallout:str_button_callout, #aux_text:aux_text, #description:trap_desc, #title:trap_title, #params:[ var_bcfe0ed5ba4c9e74 ], #string:hint, #type:str_button_type };
}

// Namespace traps
// Params 2
// Checksum 0xada8d478, Offset: 0x1e64
// Size: 0x37f
function function_2f771b7c8fca1d18( state, player )
{
    if ( isdefined( self.s_trapbuy.string_hints[ "trap_title" ] ) )
    {
        self.trap_title = self.s_trapbuy.string_hints[ "trap_title" ];
    }
    
    if ( isdefined( self.s_trapbuy.string_hints[ "description" ] ) )
    {
        self.trap_desc = self.s_trapbuy.string_hints[ "description" ];
    }
    
    switch ( state )
    {
        case #"hash_7b6614415d1b2e48":
            if ( isdefined( self.s_trapbuy.string_hints[ "cooldown" ] ) )
            {
                hint = self.s_trapbuy.string_hints[ "cooldown" ];
                self.aux_text = self.s_trapbuy.string_hints[ "cooldown" ];
            }
            else
            {
                hint = &"SHARED_HINTSTRINGS/TRAP_COOLDOWN_HINT";
            }
            
            return hint;
        case #"hash_4fdec2979b2f4017":
            if ( isdefined( self.s_switch.script_cost ) && player currency::can_afford( #"essence", self.s_switch.script_cost ) )
            {
                if ( isdefined( self.s_trapbuy.string_hints[ "buyable" ] ) )
                {
                    hint = self.s_trapbuy.string_hints[ "buyable" ];
                    self.aux_text = &"";
                }
                else
                {
                    hint = &"SHARED_HINTSTRINGS/TRAP_ESSENCE_HINT";
                }
            }
            else if ( isdefined( self.s_trapbuy.string_hints[ "not_enough_essence" ] ) )
            {
                hint = self.s_trapbuy.string_hints[ "not_enough_essence" ];
                self.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
            }
            else
            {
                hint = &"SHARED_HINTSTRINGS/TRAP_NOT_ENOUGH_ESSENCE_HINT";
            }
            
            return hint;
        case #"hash_5ff4908e6e9a0426":
            if ( isdefined( self.s_trapbuy.string_hints[ "power" ] ) )
            {
                hint = self.s_trapbuy.string_hints[ "power" ];
                self.aux_text = hint;
            }
            else
            {
                hint = &"SHARED_HINTSTRINGS/TRAP_SWITCH_POWER_HINT";
            }
            
            return hint;
        case #"hash_b389e7ddef378fd0":
            if ( isdefined( self.s_trapbuy.string_hints[ "activate" ] ) )
            {
                hint = self.s_trapbuy.string_hints[ "activate" ];
                self.aux_text = &"SHARED_HINTSTRINGS/TRAP_ACTIVATE_HINT";
            }
            else
            {
                hint = &"SHARED_HINTSTRINGS/TRAP_ACTIVATE_HINT";
            }
            
            return hint;
        case #"hash_44e999799ff10fce":
            if ( isdefined( self.s_trapbuy.string_hints[ "custom" ] ) )
            {
                hint = self.s_trapbuy.string_hints[ "custom" ];
                self.aux_text = &"";
            }
            else
            {
                /#
                    iprintlnbold( "<dev string:x241>" );
                #/
                
                hint = { #string:&"", #type:"HINT_NOBUTTON" };
            }
            
            return hint;
        default:
            return;
    }
}

// Namespace traps
// Params 1, eflags: 0x4
// Checksum 0xaa14624d, Offset: 0x21eb
// Size: 0xad4
function private switch_used( player )
{
    level endon( #"game_ended" );
    
    if ( self.var_94d1ab5da995e573 || level utility::flag( "all_traps_disabled" ) || utility::ent_flag( "trap_disabled" ) )
    {
        return;
    }
    
    if ( isdefined( self.override_used_func ) )
    {
        self [[ self.override_used_func ]]();
        return;
    }
    
    if ( isdefined( self.s_trapbuy.script_power ) )
    {
        if ( !utility::flag( self.s_trapbuy.script_power ) )
        {
            return;
        }
    }
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( !self.b_cool_down )
    {
        return;
    }
    
    if ( isdefined( self.s_trapbuy.var_93a1878f1901b4f7 ) )
    {
        if ( !self.s_trapbuy [[ self.s_trapbuy.var_93a1878f1901b4f7 ]]( player, self ) )
        {
            return;
        }
    }
    else if ( isdefined( player ) && isdefined( self.s_switch.script_currency ) && isdefined( self.s_switch.script_cost ) )
    {
        if ( !player currency::attempt_purchase( self.s_switch.script_currency, self.s_switch.script_cost, 1 ) )
        {
            /#
                iprintlnbold( "<dev string:x260>" );
            #/
            
            return;
        }
    }
    
    player playrumbleonentity( "damage_heavy" );
    
    foreach ( s_switch in self.s_trapbuy.a_switch_pos )
    {
        s_switch.interact.state = "activate";
        s_switch.interact.b_cool_down = 0;
        s_switch set_switch_scriptable_state( "base", s_switch.interact.state );
        
        if ( s_switch.var_1ed9309883ffd20d )
        {
            s_switch.animation_proxy rotateroll( -180, 0.5, 0.1, 0.1 );
        }
    }
    
    self.activator = player;
    params = {};
    params.currency = self.s_switch.script_currency ?? "";
    params.cost = self.s_switch.script_cost ?? 0;
    params.position = self.s_switch.origin;
    params.trap_name = self.s_switch.var_32f1e7774266024b.targetname;
    params.activator = self.activator;
    player callback::callback( "purchase_trap", params );
    
    if ( self.s_trapbuy.targetname == "oil_trap_ascent" )
    {
        self.s_trapbuy.trap_positions[ 0 ] set_trap_scriptable_state( "base", "activate_2" );
    }
    else
    {
        utility::array_thread( self.s_trapbuy.trap_positions, &set_trap_scriptable_state, "base", "activate" );
    }
    
    assert( isdefined( self.s_trapbuy.trap_activate_callback ), "<dev string:x273>" );
    utility::array_thread( self.s_trapbuy.trap_positions, self.s_trapbuy.trap_activate_callback, player );
    
    foreach ( trap_info in self.s_trapbuy.trap_positions )
    {
        trap_info.attack_entity.activator = player;
        trap_info.attack_entity.var_59419e7814190b1d = 0;
    }
    
    if ( isdefined( self.s_trapbuy.script_flag_set ) )
    {
        level utility::flag_set( self.s_trapbuy.script_flag_set );
    }
    
    thread function_2dbb4bc4f83ee04f( self.s_switch.script_duration );
    level callback::add( #"on_ai_killed", &zm_trap_on_ai_killed, self.s_trapbuy );
    self waittill( #"run_out_of_duration" );
    level callback::remove( #"on_ai_killed", &zm_trap_on_ai_killed, self.s_trapbuy );
    
    foreach ( s_switch in self.s_trapbuy.a_switch_pos )
    {
        s_switch.interact.state = "cooldown";
        s_switch set_switch_scriptable_state( "base", s_switch.interact.state );
        
        if ( s_switch.var_1ed9309883ffd20d )
        {
            s_switch.animation_proxy rotateroll( 180, 0.5, 0.1, 0.1 );
        }
    }
    
    if ( self.s_trapbuy.var_dfcd26bbb344a0b0 )
    {
        foreach ( trap_position in self.s_trapbuy.trap_positions )
        {
            if ( isdefined( level.var_e4f3ed554ddef1c3 ) )
            {
                trap_position utility::delaythread( 1, &set_trap_scriptable_state, "base", "cooldown" );
                continue;
            }
            
            trap_position utility::delaythread( 26, &set_trap_scriptable_state, "base", "cooldown" );
        }
    }
    else
    {
        utility::array_thread( self.s_trapbuy.trap_positions, &set_trap_scriptable_state, "base", "cooldown" );
    }
    
    assert( isdefined( self.s_trapbuy.trap_deactivate_callback ), "<dev string:x2a2>" );
    utility::array_thread( self.s_trapbuy.trap_positions, self.s_trapbuy.trap_deactivate_callback, player );
    
    if ( self.s_trapbuy.var_dfcd26bbb344a0b0 )
    {
        foreach ( trap_position in self.s_trapbuy.trap_positions )
        {
            if ( isdefined( level.var_e4f3ed554ddef1c3 ) )
            {
                trap_position utility::delaythread( 4, &set_trap_scriptable_state, "base", "ready" );
                continue;
            }
            
            trap_position utility::delaythread( 45, &set_trap_scriptable_state, "base", "ready" );
        }
    }
    
    if ( isdefined( self.s_trapbuy.var_68aecb068aaf8bf7 ) )
    {
        self.s_trapbuy [[ self.s_trapbuy.var_68aecb068aaf8bf7 ]]();
    }
    else
    {
        if ( isdefined( self.s_switch.script_timeout ) )
        {
            wait_dur = self.s_switch.script_timeout;
        }
        
        /#
            if ( getdvarint( @"hash_cfcdb945d0507870", 0 ) == 1 )
            {
                wait_dur = level.var_d6ac96657b3d40e7;
            }
        #/
        
        if ( isdefined( wait_dur ) )
        {
            self.s_trapbuy utility::waittill_notify_or_timeout( "trap_finish_cooldown_early", wait_dur );
        }
    }
    
    foreach ( trap_info in self.s_trapbuy.trap_positions )
    {
        trap_info.attack_entity.activator = undefined;
    }
    
    foreach ( s_switch in self.s_trapbuy.a_switch_pos )
    {
        s_switch.interact.state = "buyable";
        s_switch set_switch_scriptable_state( "base", s_switch.interact.state );
        s_switch.interact.b_cool_down = 1;
    }
    
    if ( !self.s_trapbuy.var_dfcd26bbb344a0b0 )
    {
        utility::array_thread( self.s_trapbuy.trap_positions, &set_trap_scriptable_state, "base", "ready" );
    }
    
    self.activator = undefined;
    var_6f88a6bfefadea5e = spawnstruct();
    var_6f88a6bfefadea5e.trap_scriptable = self.s_switch.var_32f1e7774266024b.trap_positions[ 0 ].trap_scriptable;
    callback::callback( "on_pop_ready", var_6f88a6bfefadea5e );
}

// Namespace traps
// Params 2
// Checksum 0x12699045, Offset: 0x2cc7
// Size: 0x124
function zm_trap_on_ai_killed( sparams, trap_buy )
{
    if ( !damagefeedback::isusingstackablehitmarker() )
    {
        return;
    }
    
    foreach ( trap in trap_buy.trap_positions )
    {
        if ( !( isdefined( sparams.eattacker.activator ) && isdefined( trap.attack_entity ) ) || trap.attack_entity != sparams.eattacker )
        {
            continue;
        }
        
        sparams.eattacker.activator damagefeedback::updatedamagefeedback( "standard", sparams.idamage >= self.health, sparams.biscritical, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
    }
}

// Namespace traps
// Params 1
// Checksum 0xe2f45fcd, Offset: 0x2df3
// Size: 0x33
function function_2dbb4bc4f83ee04f( var_dc58879cfee40e71 )
{
    level endon( #"game_ended" );
    self endon( #"run_out_of_duration" );
    wait var_dc58879cfee40e71;
    self notify( #"run_out_of_duration" );
}

// Namespace traps
// Params 2
// Checksum 0x9869c2e3, Offset: 0x2e2e
// Size: 0x28a
function function_477b6dafe486c6b0( swtich_targetname, var_94d1ab5da995e573 )
{
    level endon( #"game_ended" );
    switchs = utility::getstructarray( swtich_targetname, "targetname" );
    
    foreach ( switch_pos in switchs )
    {
        foreach ( sub_switch_pos in switch_pos.a_switch_pos )
        {
            if ( isdefined( sub_switch_pos.switch_scriptable ) && isdefined( sub_switch_pos.interact ) )
            {
                if ( var_94d1ab5da995e573 )
                {
                    sub_switch_pos set_switch_scriptable_state( "base", "power" );
                    sub_switch_pos.paused_state = sub_switch_pos.interact.state;
                    sub_switch_pos.interact.var_94d1ab5da995e573 = var_94d1ab5da995e573;
                    
                    if ( isdefined( sub_switch_pos.var_ce72993ecfa880f4 ) )
                    {
                        sub_switch_pos [[ sub_switch_pos.var_ce72993ecfa880f4 ]]();
                    }
                    
                    continue;
                }
                
                sub_switch_pos.interact.var_94d1ab5da995e573 = var_94d1ab5da995e573;
                
                if ( sub_switch_pos.paused_state == "activate" && sub_switch_pos.interact.state == "buyable" )
                {
                    sub_switch_pos set_switch_scriptable_state( "base", "cooldown" );
                    
                    if ( isdefined( sub_switch_pos.var_602abdfe6392b6eb ) )
                    {
                        sub_switch_pos [[ sub_switch_pos.var_602abdfe6392b6eb ]]();
                    }
                    
                    wait 1;
                    sub_switch_pos set_switch_scriptable_state( "base", sub_switch_pos.interact.state );
                    continue;
                }
                
                sub_switch_pos set_switch_scriptable_state( "base", sub_switch_pos.interact.state );
                
                if ( isdefined( sub_switch_pos.var_602abdfe6392b6eb ) )
                {
                    sub_switch_pos [[ sub_switch_pos.var_602abdfe6392b6eb ]]();
                }
            }
        }
    }
}

// Namespace traps
// Params 3
// Checksum 0xb2016cf5, Offset: 0x30c0
// Size: 0x12a
function function_12640169421ca5e7( swtich_targetname, var_e187252c277f51b1, var_eeb9a3815362758c )
{
    switchs = utility::getstructarray( swtich_targetname, "targetname" );
    
    foreach ( switch_pos in switchs )
    {
        foreach ( sub_switch_pos in switch_pos.a_switch_pos )
        {
            sub_switch_pos.var_ce72993ecfa880f4 = var_e187252c277f51b1;
            sub_switch_pos.var_602abdfe6392b6eb = var_eeb9a3815362758c;
        }
    }
}

// Namespace traps
// Params 1
// Checksum 0x333ae374, Offset: 0x31f2
// Size: 0x293
function function_ba78c6a9a2d712f5( var_94d1ab5da995e573 )
{
    level endon( #"game_ended" );
    
    if ( !isarray( level.var_f301c0b95ea728e2 ) || level.var_f301c0b95ea728e2.size == 0 )
    {
        return;
    }
    
    foreach ( switch_pos in level.var_f301c0b95ea728e2 )
    {
        foreach ( sub_switch_pos in switch_pos.a_switch_pos )
        {
            if ( isdefined( sub_switch_pos.switch_scriptable ) && isdefined( sub_switch_pos.interact ) )
            {
                if ( var_94d1ab5da995e573 )
                {
                    sub_switch_pos set_switch_scriptable_state( "base", "power" );
                    sub_switch_pos.paused_state = sub_switch_pos.interact.state;
                    sub_switch_pos.interact.var_94d1ab5da995e573 = var_94d1ab5da995e573;
                    
                    if ( isdefined( sub_switch_pos.var_ce72993ecfa880f4 ) )
                    {
                        sub_switch_pos [[ sub_switch_pos.var_ce72993ecfa880f4 ]]();
                    }
                    
                    continue;
                }
                
                sub_switch_pos.interact.var_94d1ab5da995e573 = var_94d1ab5da995e573;
                
                if ( sub_switch_pos.paused_state == "activate" && sub_switch_pos.interact.state == "buyable" )
                {
                    sub_switch_pos set_switch_scriptable_state( "base", "cooldown" );
                    
                    if ( isdefined( sub_switch_pos.var_602abdfe6392b6eb ) )
                    {
                        sub_switch_pos [[ sub_switch_pos.var_602abdfe6392b6eb ]]();
                    }
                    
                    wait 1;
                    sub_switch_pos set_switch_scriptable_state( "base", sub_switch_pos.interact.state );
                    continue;
                }
                
                sub_switch_pos set_switch_scriptable_state( "base", sub_switch_pos.interact.state );
                
                if ( isdefined( sub_switch_pos.var_602abdfe6392b6eb ) )
                {
                    sub_switch_pos [[ sub_switch_pos.var_602abdfe6392b6eb ]]();
                }
            }
        }
    }
}

// Namespace traps
// Params 4
// Checksum 0x7f5d03be, Offset: 0x348d
// Size: 0x221
function register_minimap_icon( swtich_targetname, minimap_scriptable, var_9741f4677ed6e16, var_cbeb829c335b047b )
{
    switchs = utility::getstructarray( swtich_targetname, "targetname" );
    
    if ( var_9741f4677ed6e16 )
    {
        foreach ( switch_pos in switchs )
        {
            switch_pos.var_8f7b30ae6520029c = [ spawnscriptable( minimap_scriptable, switch_pos.origin, switch_pos.angles ) ];
        }
        
        return;
    }
    
    foreach ( switch_pos in switchs )
    {
        switch_pos.var_8f7b30ae6520029c = [];
        var_ea12205a88b107cd = var_cbeb829c335b047b ? [ utility::array_random( switch_pos.a_switch_pos ) ] : switch_pos.a_switch_pos;
        
        foreach ( minimap_loc in var_ea12205a88b107cd )
        {
            minimap_icon = spawnscriptable( minimap_scriptable, minimap_loc.origin, minimap_loc.angles );
            switch_pos.var_8f7b30ae6520029c[ switch_pos.var_8f7b30ae6520029c.size ] = minimap_icon;
        }
    }
}

/#

    // Namespace traps
    // Params 0, eflags: 0x4
    // Checksum 0x8e42dcf6, Offset: 0x36b6
    // Size: 0x112, Type: dev
    function private setup_trap_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2d4>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2dd>", "<dev string:x2f7>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x311>", "<dev string:x32b>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x345>", "<dev string:x35f>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x379>", "<dev string:x394>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3af>", "<dev string:x3ca>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3e5>", "<dev string:x400>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x41b>", "<dev string:x436>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x451>", "<dev string:x46c>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x487>", "<dev string:x496>", &function_7d16ce3f30f4d998 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a5>", "<dev string:x4bf>", &function_17c692f2e20a4ca1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d3>", "<dev string:x4ec>", &function_17c692f2e20a4ca1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace traps
    // Params 1
    // Checksum 0x41041eec, Offset: 0x37d0
    // Size: 0x2d, Type: dev
    function function_17c692f2e20a4ca1( params )
    {
        var_94d1ab5da995e573 = params[ 0 ] == "<dev string:x500>";
        function_ba78c6a9a2d712f5( var_94d1ab5da995e573 );
    }

    // Namespace traps
    // Params 1
    // Checksum 0x7198c7a, Offset: 0x3805
    // Size: 0x2f, Type: dev
    function function_db67b1af1206a2cd( params )
    {
        setdvar( @"hash_cfcdb945d0507870", 1 );
        level.var_d6ac96657b3d40e7 = int( params[ 0 ] );
    }

    // Namespace traps
    // Params 1
    // Checksum 0x8569000f, Offset: 0x383c
    // Size: 0xb3, Type: dev
    function function_7d16ce3f30f4d998( params )
    {
        foreach ( trap in level.var_f301c0b95ea728e2 )
        {
            if ( trap.interact.state == "<dev string:x98>" )
            {
                trap.interact notify( #"run_out_of_duration" );
            }
        }
    }

    // Namespace traps
    // Params 2
    // Checksum 0x5930e42b, Offset: 0x38f7
    // Size: 0x2e, Type: dev
    function function_daabee83b751549f( interact, player )
    {
        if ( isdefined( interact ) && isdefined( player ) )
        {
            interact switch_used( player );
        }
    }

#/
