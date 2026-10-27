// scripts\mp\zm\traps\trap_core.gsc  (hash_48cc39a686b43438.gscc) (size: 23318 Bytes / 0x5b16 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e2bb43f (1311487039)
// size ...... 23318 (0x5b16)
// includes .. 8   (offset: 0x5586)
// strings ... 38  (offset: 0x55c6)
// dev strs .. 45  (offset: 0x5892)
// exports ... 37  (offset: 0x4186)
// cseg ...... 0x363 + 0x3e23 (0x4186)
// imports ... 108 (offset: 0x474e)
// animtree1 . 0   (offset: 0x5b16)
// animtree2 . 0   (offset: 0x5b16)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;

#namespace trap_core;

// Namespace trap_core
// Params 0, eflags: 0x5
// Checksum 0x6df2d3ae, Offset: 0x381
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_trap", undefined, &pre_init, &post_init );
}

// Namespace trap_core
// Params 0
// Checksum 0x2f5d36bb, Offset: 0x3a6
// Size: 0x1ef
function pre_init()
{
    if ( !isdefined( level.gametypebundle.var_be8dd79dbae34be5 ) )
    {
        return;
    }
    
    var_20e6d5f71971041b = getscriptbundle( level.gametypebundle.var_be8dd79dbae34be5 );
    
    if ( isdefined( var_20e6d5f71971041b.var_48f2306bf59068da ) && var_20e6d5f71971041b.var_48f2306bf59068da.size != 0 )
    {
        foreach ( data in var_20e6d5f71971041b.var_48f2306bf59068da )
        {
            if ( level.mapname == data.mapname )
            {
                var_cddf60a846b42aa8 = data.trapsettings;
            }
        }
    }
    
    if ( !isdefined( var_cddf60a846b42aa8 ) )
    {
        return;
    }
    
    var_aaa94c03f536a51 = getscriptbundle( hashcat( %"hash_1b5fcaae6dc93d42", var_cddf60a846b42aa8 ) );
    
    if ( !isdefined( var_aaa94c03f536a51 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_1bc31921d079dc44 ) )
    {
        level.var_1bc31921d079dc44 = [];
    }
    
    foreach ( trap_data in var_aaa94c03f536a51.trapsettings )
    {
        level.var_1bc31921d079dc44[ trap_data.scripttag ] = spawnstruct();
        level.var_1bc31921d079dc44[ trap_data.scripttag ] = trap_data;
    }
    
    level.var_655315530ac9b6a1 = &function_e1ecf079d6d4a1c8;
}

// Namespace trap_core
// Params 0
// Checksum 0x35dd0703, Offset: 0x59d
// Size: 0x4d
function post_init()
{
    level utility::registersharedfunc( #"traps", #"hash_bec4853d43d80950", &function_ba78c6a9a2d712f5 );
    level callback::add( #"hash_9325330e77aef2ad", &function_9371cba2ebdb7096 );
    level callback::add( #"firesale_end", &function_c7c93a70fd920593 );
}

// Namespace trap_core
// Params 2
// Checksum 0x2c370b43, Offset: 0x5f2
// Size: 0x29d
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
            
            if ( isplayer( attacker.var_114edc6e5d40553c ) && isalive( attacker.var_114edc6e5d40553c ) )
            {
                attacker.var_114edc6e5d40553c namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_ambush" );
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
            
            if ( isplayer( attacker.var_114edc6e5d40553c ) && isalive( attacker.var_114edc6e5d40553c ) )
            {
                attacker.var_114edc6e5d40553c namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( str_medal );
            }
        }
        
        if ( isplayer( attacker.activator ) )
        {
            params = spawnstruct();
            params.var_59419e7814190b1d = attacker.var_59419e7814190b1d;
            attacker.activator callback::callback( "trap_kill", params );
            
            if ( isplayer( attacker.var_114edc6e5d40553c ) )
            {
                attacker.var_114edc6e5d40553c callback::callback( "trap_kill", params );
            }
        }
    }
}

// Namespace trap_core
// Params 0
// Checksum 0xcd0e6537, Offset: 0x897
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

// Namespace trap_core
// Params 2
// Checksum 0xf37eae98, Offset: 0x8d4
// Size: 0x253
function function_80c9f68d350fb272( params, trapbuy )
{
    if ( !isplayer( params.eattacker ) )
    {
        if ( isdefined( params.einflictor ) && params.einflictor.targetname == "trap_attacker" )
        {
            switch ( self.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                    scoreevent = level.var_1bc31921d079dc44[ trapbuy.targetname ].var_b5f16184fd6e2f34;
                    break;
                case #"hash_8c089e813083e510":
                    scoreevent = level.var_1bc31921d079dc44[ trapbuy.targetname ].var_91f9ac7056573a14;
                    break;
                case #"hash_7b0e2f2ed84f34":
                    scoreevent = level.var_1bc31921d079dc44[ trapbuy.targetname ].var_a9e37da9ab33c4b4;
                    break;
                case #"hash_4e47eb6c32f5b165":
                    scoreevent = level.var_1bc31921d079dc44[ trapbuy.targetname ].var_b8d1c96823de6683;
                    break;
                default:
                    scoreevent = undefined;
                    break;
            }
            
            if ( isdefined( scoreevent ) && isplayer( params.einflictor.activator ) )
            {
                score_params = spawnstruct();
                score_params.scoreevent = scoreevent;
                params.einflictor.activator callback::callback( "zombie_score_event", score_params );
                
                if ( isdefined( params.einflictor.var_114edc6e5d40553c ) )
                {
                    params.einflictor.var_114edc6e5d40553c callback::callback( "zombie_score_event", score_params );
                }
            }
            
            if ( isdefined( level.var_1bc31921d079dc44[ trapbuy.targetname ].var_9cc1755ff1836d17 ) && level.var_1bc31921d079dc44[ trapbuy.targetname ].var_9cc1755ff1836d17 != "" )
            {
                utility::ent_flag_set( level.var_1bc31921d079dc44[ trapbuy.targetname ].var_9cc1755ff1836d17 );
            }
        }
    }
}

// Namespace trap_core
// Params 8
// Checksum 0x37556147, Offset: 0xb2f
// Size: 0x3aa
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
    
    if ( !isdefined( level.var_1bc31921d079dc44[ str_targetname ] ) )
    {
        assertmsg( "<dev string:x24>" + str_targetname + "<dev string:x43>" );
        return;
    }
    
    a_s_traps = utility::getstructarray( str_targetname, "targetname" );
    
    if ( isdefined( trap_activate_callback ) )
    {
        foreach ( var_f5d93163bb80f7b in a_s_traps )
        {
            var_f5d93163bb80f7b.trap_activate_callback = trap_activate_callback;
        }
    }
    
    if ( isdefined( trap_deactivate_callback ) )
    {
        foreach ( var_f5d93163bb80f7b in a_s_traps )
        {
            var_f5d93163bb80f7b.trap_deactivate_callback = trap_deactivate_callback;
        }
    }
    
    if ( isdefined( var_93a1878f1901b4f7 ) )
    {
        foreach ( var_f5d93163bb80f7b in a_s_traps )
        {
            var_f5d93163bb80f7b.var_93a1878f1901b4f7 = var_93a1878f1901b4f7;
        }
    }
    
    if ( isdefined( var_4dcbf485031cd3e6 ) )
    {
        foreach ( var_f5d93163bb80f7b in a_s_traps )
        {
            var_f5d93163bb80f7b.var_4dcbf485031cd3e6 = var_4dcbf485031cd3e6;
        }
    }
    
    if ( isdefined( var_68aecb068aaf8bf7 ) )
    {
        foreach ( var_f5d93163bb80f7b in a_s_traps )
        {
            var_f5d93163bb80f7b.var_68aecb068aaf8bf7 = var_68aecb068aaf8bf7;
        }
    }
    
    if ( isdefined( custom_power_on_func ) )
    {
        foreach ( var_f5d93163bb80f7b in a_s_traps )
        {
            var_f5d93163bb80f7b.custom_power_on_func = custom_power_on_func;
        }
    }
    
    level.var_f301c0b95ea728e2 = arraycombineunique( level.var_f301c0b95ea728e2, a_s_traps );
    utility::array_thread( a_s_traps, &init_trap, params );
}

// Namespace trap_core
// Params 1
// Checksum 0xbe3663e, Offset: 0xee1
// Size: 0x31c
function init_trap( params )
{
    self.script_cost = level.var_1bc31921d079dc44[ self.targetname ].trapcost;
    self.script_duration = level.var_1bc31921d079dc44[ self.targetname ].trapduration;
    self.script_timeout = level.var_1bc31921d079dc44[ self.targetname ].var_204569adc9c61cb9;
    self.script_currency = self.script_currency ?? #"essence";
    self.power_on_flag = level.var_1bc31921d079dc44[ self.targetname ].var_3304f793d93f0819;
    self.var_edb06a64c1fbf4e6 = level.var_1bc31921d079dc44[ self.targetname ].var_99a361d2e3902966;
    
    if ( isdefined( level.var_1bc31921d079dc44[ self.targetname ].var_13661690410a598c ) && isdefined( self.script_noteworthy ) )
    {
        foreach ( data in level.var_1bc31921d079dc44[ self.targetname ].var_13661690410a598c )
        {
            if ( data.scripttag == self.script_noteworthy )
            {
                self.power_on_flag = data.var_1831d6a1ac1bfac1;
                break;
            }
        }
    }
    
    var_3010f232fa3880d9 = utility::getstructarray( self.target, "targetname" );
    
    foreach ( pos in var_3010f232fa3880d9 )
    {
        if ( pos.script_noteworthy == "switch" )
        {
            if ( !isdefined( self.a_switch_pos ) )
            {
                self.a_switch_pos = [];
            }
            
            self.a_switch_pos[ self.a_switch_pos.size ] = pos;
            pos thread init_switch( self, params );
            continue;
        }
        
        if ( pos.script_noteworthy == "trap" )
        {
            if ( !isdefined( self.trap_positions ) )
            {
                self.trap_positions = [];
            }
            
            self.trap_positions[ self.trap_positions.size ] = pos;
            pos thread spawn_trap_scriptable( self );
        }
    }
    
    function_6ddc0b65d69cf40c();
    level utility::flag_set( self.targetname + "_trap_init_finished" );
    
    /#
        level.var_d6ac96657b3d40e7 = 5;
        setup_trap_devgui();
    #/
}

// Namespace trap_core
// Params 0
// Checksum 0xcf4c64ba, Offset: 0x1205
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

// Namespace trap_core
// Params 2
// Checksum 0x4fca1567, Offset: 0x12bd
// Size: 0x5b5
function init_switch( myparent, params )
{
    self.var_32f1e7774266024b = myparent;
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_d4beef0c08a6c468 ) )
    {
        self.switch_scriptable = utility::spawn_model( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_d4beef0c08a6c468, self.origin, self.angles );
    }
    else if ( isdefined( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_1067f1cccca81dfa ) )
    {
        self.switch_scriptable = spawnscriptable( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_1067f1cccca81dfa, self.origin, self.angles );
        self.var_1ed9309883ffd20d = 0;
    }
    else
    {
        self.switch_scriptable = spawnscriptable( "t10_zm_trap_switch", self.origin, self.angles );
        self.var_1ed9309883ffd20d = 1;
    }
    
    if ( self.script_parameters != "no_minimap" )
    {
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", self.switch_scriptable, "icon" );
    }
    
    assert( self.switch_scriptable getscriptablehaspart( "<dev string:x64>" ), "<dev string:x69>" + self.origin + "<dev string:x83>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:x9f>" ), "<dev string:x69>" + self.origin + "<dev string:xa8>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:xd8>" ), "<dev string:x69>" + self.origin + "<dev string:xe1>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:x111>" ), "<dev string:x69>" + self.origin + "<dev string:x117>" );
    assert( self.switch_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:x144>" ), "<dev string:x69>" + self.origin + "<dev string:x14d>" );
    self.switch_scriptable.var_32f1e7774266024b = myparent;
    
    if ( self.var_1ed9309883ffd20d )
    {
        self.animation_proxy = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self.switch_scriptable scriptablesetparententity( self.animation_proxy );
        self.animation_proxy rotateroll( 90, 0.5, 0.1, 0.1 );
    }
    
    interact_org = self.origin;
    
    if ( isdefined( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_7f7ba716eedc26f ) )
    {
        fwd = anglestoforward( self.angles );
        interact_org += fwd * level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_7f7ba716eedc26f;
    }
    
    if ( isdefined( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_38a595a0a10c2d2b ) )
    {
        up = anglestoup( self.angles );
        interact_org += up * level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_38a595a0a10c2d2b;
    }
    
    radius_type = level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_817b9ac7d992a7cf;
    self.interact = function_afebc76c388796fe( interact_org, &switch_used, &function_c1d665c28c7c2175, radius_type );
    self.interact.b_cool_down = 1;
    self.interact.s_trapbuy = myparent;
    self.interact.s_switch = self;
    self.interact.interact_use_range = radius_type == "large" ? 120 : 80;
    
    if ( isdefined( myparent.power_on_flag ) && !utility::flag( myparent.power_on_flag ) )
    {
        if ( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].var_7873b2187ef33f8 )
        {
            self.interact.state = "power";
        }
        else
        {
            self.interact.state = "off";
        }
        
        thread function_8f18198a1c4e8d35( myparent.power_on_flag );
        set_switch_scriptable_state( "base", self.interact.state );
        return;
    }
    
    self.interact.state = "buyable";
    set_switch_scriptable_state( "base", self.interact.state );
}

// Namespace trap_core
// Params 4
// Checksum 0xf35bd4fe, Offset: 0x187a
// Size: 0xd1
function function_afebc76c388796fe( org_or_ent, use_callback, var_b2107da793be51f7, radius_type )
{
    var_45b620bc30783968 = undefined;
    
    if ( isvector( org_or_ent ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_t10_trap_scriptable_interact", org_or_ent );
    }
    else if ( isvector( org_or_ent.origin ) )
    {
        var_45b620bc30783968 = spawnscriptable( "zm_t10_trap_scriptable_interact", org_or_ent.origin );
    }
    
    if ( !isdefined( var_45b620bc30783968 ) )
    {
        print( "<dev string:x17d>" );
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

// Namespace trap_core
// Params 2
// Checksum 0xf85643b8, Offset: 0x1954
// Size: 0x104
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
        case #"hash_3699ac6c262c25ea":
            sbl_state = "off";
            break;
    }
    
    self.switch_scriptable setscriptablepartstate( str_part, sbl_state );
}

// Namespace trap_core
// Params 1
// Checksum 0x93c89557, Offset: 0x1a60
// Size: 0x357
function spawn_trap_scriptable( myparent )
{
    self.var_32f1e7774266024b = myparent;
    
    if ( isdefined( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].trapscriptmodel ) )
    {
        self.trap_scriptable = utility::spawn_model( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].trapscriptmodel, self.origin, self.angles );
    }
    else if ( isdefined( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].trapscriptable ) )
    {
        self.trap_scriptable = spawnscriptable( level.var_1bc31921d079dc44[ self.var_32f1e7774266024b.targetname ].trapscriptable, self.origin, self.angles );
    }
    
    assert( isdefined( self.trap_scriptable ), "<dev string:x1a4>" + self.origin + "<dev string:x1c3>" );
    assert( self.trap_scriptable getscriptablehaspart( "<dev string:x64>" ), "<dev string:x250>" + self.origin + "<dev string:x263>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:x9f>" ), "<dev string:x250>" + self.origin + "<dev string:xa8>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:xd8>" ), "<dev string:x250>" + self.origin + "<dev string:xe1>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:x111>" ), "<dev string:x250>" + self.origin + "<dev string:x117>" );
    assert( self.trap_scriptable getscriptableparthasstate( "<dev string:x64>", "<dev string:x144>" ), "<dev string:x250>" + self.origin + "<dev string:x14d>" );
    
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
    self.attack_entity.s_trapbuy = self.var_32f1e7774266024b;
    
    if ( isdefined( myparent.power_on_flag ) && !utility::flag( myparent.power_on_flag ) )
    {
        set_trap_scriptable_state( "base", "no_power" );
        level utility::flag_wait( myparent.power_on_flag );
        set_trap_scriptable_state( "base", "ready" );
        return;
    }
    
    set_trap_scriptable_state( "base", "ready" );
}

// Namespace trap_core
// Params 2
// Checksum 0x8095540e, Offset: 0x1dbf
// Size: 0x5e
function set_trap_scriptable_state( str_part, str_state )
{
    if ( isfunction( self.var_4d40b73592a8fc86 ) )
    {
        return [[ self.var_4d40b73592a8fc86 ]]( str_part, str_state );
    }
    
    if ( isdefined( self.trap_scriptable ) )
    {
        self.trap_scriptable setscriptablepartstate( str_part, str_state );
        return;
    }
    
    self setscriptablepartstate( str_part, str_state );
}

// Namespace trap_core
// Params 1
// Checksum 0x7c7c09e0, Offset: 0x1e25
// Size: 0x9c
function function_8f18198a1c4e8d35( str_flag )
{
    level endon( #"game_ended" );
    self.interact endon( #"death" );
    
    if ( isdefined( self.var_32f1e7774266024b.custom_power_on_func ) )
    {
        self [[ self.var_32f1e7774266024b.custom_power_on_func ]]();
    }
    
    level utility::flag_wait( str_flag );
    self.interact.state = "buyable";
    set_switch_scriptable_state( "base", self.interact.state );
}

// Namespace trap_core
// Params 1
// Checksum 0x9aa8c191, Offset: 0x1ec9
// Size: 0x11d
function function_9371cba2ebdb7096( params )
{
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        trap.var_5d9c9cc665da8323 = trap.script_cost;
        trap.script_cost = 10;
        
        foreach ( switch_pos in self.a_switch_pos )
        {
            switch_pos.script_cost = 10;
        }
    }
}

// Namespace trap_core
// Params 1
// Checksum 0x45aed613, Offset: 0x1fee
// Size: 0x118
function function_c7c93a70fd920593( params )
{
    foreach ( trap in level.var_f301c0b95ea728e2 )
    {
        trap.script_cost = trap.var_5d9c9cc665da8323;
        
        foreach ( switch_pos in self.a_switch_pos )
        {
            switch_pos.script_cost = trap.var_5d9c9cc665da8323;
        }
    }
}

// Namespace trap_core
// Params 2
// Checksum 0x4a8b22e0, Offset: 0x210e
// Size: 0x477
function function_c1d665c28c7c2175( interact, player )
{
    b_interactable = 1;
    hint_data = {};
    var_f5d93163bb80f7b = interact.s_trapbuy;
    
    if ( isdefined( var_f5d93163bb80f7b.power_on_flag ) && !utility::flag( var_f5d93163bb80f7b.power_on_flag ) )
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
    
    if ( isdefined( interact.s_trapbuy.var_4dcbf485031cd3e6 ) )
    {
        return interact.s_trapbuy [[ interact.s_trapbuy.var_4dcbf485031cd3e6 ]]( player );
    }
    
    if ( interact.s_trapbuy.script_cost )
    {
        var_bcfe0ed5ba4c9e74 = interact.s_trapbuy.script_cost;
    }
    else
    {
        var_bcfe0ed5ba4c9e74 = level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].trapcost;
    }
    
    if ( isdefined( player ) && isdefined( level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].trapcost ) )
    {
        if ( var_f5d93163bb80f7b.var_edb06a64c1fbf4e6 && !player.var_1131da0d530e7946 && !var_f5d93163bb80f7b.var_6b6c1bfda2809bae && level.players.size > 1 )
        {
            player function_892718809a2147f3( interact );
        }
        
        if ( state == "buyable" )
        {
            hint_data = function_f3f0095f295c63ae( player, var_f5d93163bb80f7b );
            aux_text = hint_data.aux_text;
            b_interactable = hint_data.interactable;
        }
    }
    
    hint_data.icon_text_value = var_bcfe0ed5ba4c9e74;
    
    if ( hint_data.icon_text_value == 0 )
    {
        hint_data.var_776a268784e089af = &"";
        hint_data.icon_text_value = undefined;
    }
    
    switch ( state )
    {
        case #"hash_7b6614415d1b2e48":
            aux_text = level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_bd2515d409a23c21;
            b_interactable = 0;
            break;
        case #"hash_4fdec2979b2f4017":
            break;
        case #"hash_5ff4908e6e9a0426":
            aux_text = level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_d4e63793cbc4c264;
            b_interactable = 0;
            break;
        case #"hash_b389e7ddef378fd0":
            aux_text = level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_2b5efbe74b39722c;
            b_interactable = 0;
            break;
    }
    
    return { #interactable:b_interactable, #icon_text_value:hint_data.icon_text_value, #var_776a268784e089af:hint_data.var_776a268784e089af ?? &"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_f9ca3a75bceb8df2 ?? "ui_icon_zm_ping_trap", #var_492f94db590aab17:hint_data.var_492f94db590aab17, #altbuttoncallout:hint_data.altbuttoncallout, #buttoncallout:level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_9f3f87dc1b5775d0, #aux_text:aux_text ?? &"", #description:level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_d8acbd60dd6575e7 ?? &"hash_38d0628731f81057", #title:level.var_1bc31921d079dc44[ var_f5d93163bb80f7b.targetname ].var_e34e31814ded5ec3 ?? &"SHARED_HINTSTRINGS/TRAP_TITLE", #params:[ var_bcfe0ed5ba4c9e74 ], #string:&"", #type:"HINT_BUTTON" };
}

// Namespace trap_core
// Params 1
// Checksum 0xfd06eff1, Offset: 0x258e
// Size: 0x5f
function function_892718809a2147f3( interact )
{
    if ( !function_c396a28e4a9bf134( interact ) )
    {
        return;
    }
    
    self.var_1131da0d530e7946 = 1;
    thread function_2ea14a06ae8cfadb( interact );
    thread function_aae6f40fd1ab83d6( interact );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "try_partial_doorbuy_kbm", "+reload" );
        self notifyonplayercommand( "try_partial_doorbuy_gpad", "-usereload" );
    }
}

// Namespace trap_core
// Params 1
// Checksum 0xa8d637c2, Offset: 0x25f5
// Size: 0x50
function function_c396a28e4a9bf134( interact )
{
    if ( isdefined( interact ) && distancesquared( self.origin, interact.origin ) <= squared( interact.interact_use_range + 16 ) )
    {
        return 1;
    }
    
    thread function_3fbb163ddce8dc27();
    return 0;
}

// Namespace trap_core
// Params 1, eflags: 0x4
// Checksum 0x31a783c9, Offset: 0x264d
// Size: 0x44
function private function_2ea14a06ae8cfadb( interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_4941ba1cb93cff9d" );
    
    while ( function_c396a28e4a9bf134( interact ) )
    {
        wait 0.1;
    }
}

// Namespace trap_core
// Params 1, eflags: 0x4
// Checksum 0x67db0cd1, Offset: 0x2699
// Size: 0xc3
function private function_aae6f40fd1ab83d6( interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e3d7b5dd2028efc0" );
    
    while ( true )
    {
        notifies = [ "try_partial_doorbuy_kbm", "try_partial_doorbuy_gpad" ];
        event = utility::waittill_any_in_array_return( notifies );
        isvalidinput = 0;
        
        if ( event == "try_partial_doorbuy_kbm" && !self usinggamepad() )
        {
            isvalidinput = 1;
        }
        
        if ( event == "try_partial_doorbuy_gpad" && self usinggamepad() )
        {
            isvalidinput = 1;
        }
        
        if ( isvalidinput && isdefined( interact ) )
        {
            interact thread switch_used( self, 1 );
        }
        
        wait 0.2;
    }
}

// Namespace trap_core
// Params 2, eflags: 0x4
// Checksum 0x1e305b63, Offset: 0x2764
// Size: 0x21e
function private function_f3f0095f295c63ae( player, var_f5d93163bb80f7b )
{
    var_b4dab724fa2a3943 = 0;
    can_afford_only_half_buy = 0;
    hint_data = spawnstruct();
    hint_data.interactable = 1;
    
    if ( isplayer( player ) && isdefined( var_f5d93163bb80f7b.script_currency ) && isdefined( var_f5d93163bb80f7b.script_cost ) )
    {
        if ( var_f5d93163bb80f7b.var_edb06a64c1fbf4e6 && player currency::can_afford( var_f5d93163bb80f7b.script_currency, int( var_f5d93163bb80f7b.script_cost / 2 ) ) && !var_f5d93163bb80f7b.var_6b6c1bfda2809bae && level.players.size > 1 )
        {
            var_b4dab724fa2a3943 = 1;
            hint_data.altbuttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY_HALF";
            hint_data.var_492f94db590aab17 = 1;
        }
        
        if ( !player currency::can_afford( var_f5d93163bb80f7b.script_currency, var_f5d93163bb80f7b.script_cost ) )
        {
            if ( var_f5d93163bb80f7b.var_edb06a64c1fbf4e6 && level.players.size > 1 )
            {
                if ( player currency::can_afford( var_f5d93163bb80f7b.script_currency, int( var_f5d93163bb80f7b.script_cost / 2 ) ) && !var_f5d93163bb80f7b.var_6b6c1bfda2809bae )
                {
                    can_afford_only_half_buy = 1;
                    hint_data.altbuttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY_HALF";
                    hint_data.var_492f94db590aab17 = 1;
                    var_b4dab724fa2a3943 = 1;
                }
                else
                {
                    hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
                    hint_data.interactable = 0;
                }
            }
            else
            {
                hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
                hint_data.interactable = 0;
            }
        }
    }
    
    if ( player.var_1131da0d530e7946 )
    {
        player setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", can_afford_only_half_buy );
        player setclientomnvar( "ui_zm_doorbuy_is_doorbuy", var_b4dab724fa2a3943 );
        
        if ( !isbot( player ) )
        {
            player allowreload( !var_b4dab724fa2a3943 );
        }
    }
    
    return hint_data;
}

// Namespace trap_core
// Params 0, eflags: 0xc
// Checksum 0x43e65ca, Offset: 0x298b
// Size: 0xb1
function private function_3fbb163ddce8dc27()
{
    self notify( #"hash_cb6f0cb5504ea221" );
    self endon( #"hash_cb6f0cb5504ea221" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_1131da0d530e7946 = 0;
    self setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 0 );
    self setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 0 );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "try_partial_doorbuy_kbm", "+reload" );
        self notifyonplayercommandremove( "try_partial_doorbuy_gpad", "-usereload" );
    }
    
    self notify( #"hash_4941ba1cb93cff9d" );
    self notify( #"hash_e3d7b5dd2028efc0" );
    wait 0.1;
    
    if ( self && !isbot( self ) )
    {
        self allowreload( 1 );
    }
}

// Namespace trap_core
// Params 2, eflags: 0x4
// Checksum 0x4b9edc8a, Offset: 0x2a44
// Size: 0xaaa
function private switch_used( player, b_half_buy = 0 )
{
    level endon( #"game_ended" );
    self endon( #"hash_955a9472d9eab0a1" );
    
    if ( self.var_94d1ab5da995e573 )
    {
        return;
    }
    
    if ( isdefined( self.override_used_func ) )
    {
        self [[ self.override_used_func ]]();
        return;
    }
    
    if ( isdefined( self.s_trapbuy.power_on_flag ) )
    {
        if ( !utility::flag( self.s_trapbuy.power_on_flag ) )
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
    else if ( isdefined( player ) && isdefined( self.s_trapbuy.script_currency ) && isdefined( self.s_trapbuy.script_cost ) )
    {
        if ( b_half_buy )
        {
            if ( !self.s_trapbuy.var_6b6c1bfda2809bae && player currency::attempt_purchase( self.s_trapbuy.script_currency, int( self.s_trapbuy.script_cost / 2 ), 1 ) )
            {
                self.s_trapbuy.var_6b6c1bfda2809bae = 1;
                player playrumbleonentity( "damage_heavy" );
                self.s_trapbuy.script_cost = int( self.s_trapbuy.script_cost / 2 );
                player function_3fbb163ddce8dc27();
                self.s_trapbuy.var_114edc6e5d40553c = player;
                player playsoundtoplayer( "ui_zm_core_door_purchase_partial", player );
            }
            
            return;
        }
        
        if ( !player currency::attempt_purchase( self.s_trapbuy.script_currency, self.s_trapbuy.script_cost, 1 ) )
        {
            /#
                iprintlnbold( "<dev string:x281>" );
            #/
            
            return;
        }
    }
    
    player function_3fbb163ddce8dc27();
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
    
    if ( self.s_trapbuy.var_114edc6e5d40553c == player )
    {
        self.s_trapbuy.var_114edc6e5d40553c = undefined;
    }
    
    params = {};
    params.currency = self.s_trapbuy.script_currency ?? "";
    params.cost = self.s_trapbuy.script_cost ?? 0;
    params.position = self.s_switch.origin;
    params.trap_name = self.s_switch.var_32f1e7774266024b.targetname;
    params.activator = self.activator;
    player callback::callback( "purchase_trap", params );
    
    if ( self.s_trapbuy.var_edb06a64c1fbf4e6 )
    {
        self.s_trapbuy.script_cost = level.var_1bc31921d079dc44[ self.s_trapbuy.targetname ].trapcost;
    }
    
    utility::array_thread( self.s_trapbuy.trap_positions, &set_trap_scriptable_state, "base", "activate" );
    assert( isdefined( self.s_trapbuy.trap_activate_callback ), "<dev string:x294>" );
    utility::array_thread( self.s_trapbuy.trap_positions, self.s_trapbuy.trap_activate_callback, player );
    
    foreach ( trap_info in self.s_trapbuy.trap_positions )
    {
        trap_info.attack_entity.activator = player;
        trap_info.attack_entity.var_114edc6e5d40553c = self.s_trapbuy.var_114edc6e5d40553c;
        trap_info.attack_entity.var_59419e7814190b1d = 0;
    }
    
    thread function_2dbb4bc4f83ee04f( self.s_trapbuy.script_duration );
    
    if ( !level callback::exists( #"on_ai_killed", &zm_trap_on_ai_killed, self.s_trapbuy ) )
    {
        level callback::add( #"on_ai_killed", &zm_trap_on_ai_killed, self.s_trapbuy );
    }
    
    self waittill( #"run_out_of_duration" );
    
    if ( level callback::exists( #"on_ai_killed", &zm_trap_on_ai_killed, self.s_trapbuy ) )
    {
        level callback::remove( #"on_ai_killed", &zm_trap_on_ai_killed, self.s_trapbuy );
    }
    
    foreach ( s_switch in self.s_trapbuy.a_switch_pos )
    {
        s_switch.interact.state = "cooldown";
        s_switch set_switch_scriptable_state( "base", s_switch.interact.state );
        
        if ( s_switch.var_1ed9309883ffd20d )
        {
            s_switch.animation_proxy rotateroll( 180, 0.5, 0.1, 0.1 );
        }
    }
    
    utility::array_thread( self.s_trapbuy.trap_positions, &set_trap_scriptable_state, "base", "cooldown" );
    assert( isdefined( self.s_trapbuy.trap_deactivate_callback ), "<dev string:x2c3>" );
    utility::array_thread( self.s_trapbuy.trap_positions, self.s_trapbuy.trap_deactivate_callback, player );
    
    if ( isdefined( self.s_trapbuy.var_68aecb068aaf8bf7 ) )
    {
        self.s_trapbuy [[ self.s_trapbuy.var_68aecb068aaf8bf7 ]]();
    }
    else
    {
        if ( isdefined( self.s_trapbuy.script_timeout ) )
        {
            wait_dur = self.s_trapbuy.script_timeout;
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
    
    if ( self.s_trapbuy.var_edb06a64c1fbf4e6 )
    {
        self.s_trapbuy.var_114edc6e5d40553c = undefined;
        self.s_trapbuy.var_6b6c1bfda2809bae = 0;
    }
    
    foreach ( trap_info in self.s_trapbuy.trap_positions )
    {
        trap_info.attack_entity.activator = undefined;
        trap_info.attack_entity.var_114edc6e5d40553c = undefined;
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
    sparams = spawnstruct();
    sparams.trap = self.s_trapbuy;
    callback::callback( "on_trap_ready", sparams );
}

// Namespace trap_core
// Params 2
// Checksum 0xea9b5da3, Offset: 0x34f6
// Size: 0x156
function zm_trap_on_ai_killed( sparams, trapbuy )
{
    if ( !damagefeedback::isusingstackablehitmarker() )
    {
        return;
    }
    
    foreach ( trap in trapbuy.trap_positions )
    {
        if ( !( isdefined( sparams.eattacker.activator ) && isdefined( trap.attack_entity ) ) || trap.attack_entity != sparams.eattacker )
        {
            continue;
        }
        
        sparams.eattacker.activator damagefeedback::updatedamagefeedback( "standard", sparams.idamage >= self.health, sparams.biscritical, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
    }
    
    self.var_a13bed1ac47e1b2c = level.var_1bc31921d079dc44[ trapbuy.targetname ].var_208214f9a6a61809;
    function_80c9f68d350fb272( sparams, trapbuy );
}

// Namespace trap_core
// Params 1
// Checksum 0xce19057e, Offset: 0x3654
// Size: 0x33
function function_2dbb4bc4f83ee04f( var_dc58879cfee40e71 )
{
    level endon( #"game_ended" );
    self endon( #"run_out_of_duration" );
    wait var_dc58879cfee40e71;
    self notify( #"run_out_of_duration" );
}

// Namespace trap_core
// Params 2
// Checksum 0xb4849850, Offset: 0x368f
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

// Namespace trap_core
// Params 3
// Checksum 0x9eec3646, Offset: 0x3921
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

// Namespace trap_core
// Params 1
// Checksum 0x6160dc03, Offset: 0x3a53
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

// Namespace trap_core
// Params 4
// Checksum 0x53b0590d, Offset: 0x3cee
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

    // Namespace trap_core
    // Params 0, eflags: 0x4
    // Checksum 0x7595ff64, Offset: 0x3f17
    // Size: 0x112, Type: dev
    function private setup_trap_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2f5>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fe>", "<dev string:x318>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x332>", "<dev string:x34c>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x366>", "<dev string:x380>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x39a>", "<dev string:x3b5>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d0>", "<dev string:x3eb>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x406>", "<dev string:x421>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43c>", "<dev string:x457>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x472>", "<dev string:x48d>", &function_db67b1af1206a2cd, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a8>", "<dev string:x4b7>", &function_7d16ce3f30f4d998 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4c6>", "<dev string:x4e0>", &function_17c692f2e20a4ca1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4f4>", "<dev string:x50d>", &function_17c692f2e20a4ca1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace trap_core
    // Params 1
    // Checksum 0xbad33d7e, Offset: 0x4031
    // Size: 0x2d, Type: dev
    function function_17c692f2e20a4ca1( params )
    {
        var_94d1ab5da995e573 = params[ 0 ] == "<dev string:x521>";
        function_ba78c6a9a2d712f5( var_94d1ab5da995e573 );
    }

    // Namespace trap_core
    // Params 1
    // Checksum 0x2bf4d6c9, Offset: 0x4066
    // Size: 0x2f, Type: dev
    function function_db67b1af1206a2cd( params )
    {
        setdvar( @"hash_cfcdb945d0507870", 1 );
        level.var_d6ac96657b3d40e7 = int( params[ 0 ] );
    }

    // Namespace trap_core
    // Params 1
    // Checksum 0xa9845abc, Offset: 0x409d
    // Size: 0xb3, Type: dev
    function function_7d16ce3f30f4d998( params )
    {
        foreach ( trap in level.var_f301c0b95ea728e2 )
        {
            if ( trap.interact.state == "<dev string:xd8>" )
            {
                trap.interact notify( #"run_out_of_duration" );
            }
        }
    }

    // Namespace trap_core
    // Params 2
    // Checksum 0xa2e7c7b9, Offset: 0x4158
    // Size: 0x2e, Type: dev
    function function_daabee83b751549f( interact, player )
    {
        if ( isdefined( interact ) && isdefined( player ) )
        {
            interact switch_used( player );
        }
    }

#/
