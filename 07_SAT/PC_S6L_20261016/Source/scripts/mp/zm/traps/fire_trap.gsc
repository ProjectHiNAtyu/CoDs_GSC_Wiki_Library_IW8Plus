// scripts\mp\zm\traps\fire_trap.gsc  (hash_245217dfeffadd11.gscc) (size: 15284 Bytes / 0x3bb4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6734d45 (3061009733)
// size ...... 15284 (0x3bb4)
// includes .. 14  (offset: 0x3804)
// strings ... 49  (offset: 0x3874)
// dev strs .. 3   (offset: 0x3b90)
// exports ... 38  (offset: 0x2570)
// cseg ...... 0x35e + 0x2212 (0x2570)
// imports ... 102 (offset: 0x2b60)
// animtree1 . 0   (offset: 0x3bb4)
// animtree2 . 0   (offset: 0x3bb4)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\utility;
#using scripts\mp\ammomods\napalmburst;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\trap_core;

#namespace fire_trap;

// Namespace fire_trap
// Params 0
// Checksum 0x62e1b984, Offset: 0x37c
// Size: 0x28
function pre_init()
{
    level.var_541bf6f0b8135f8c = { #var_1ec9d115b1b3bd09:0 };
    level thread function_cf365415746d2ab5();
    
    /#
        debug_init();
    #/
}

// Namespace fire_trap
// Params 0
// Checksum 0xb21e165f, Offset: 0x3ac
// Size: 0x2de
function function_cf365415746d2ab5()
{
    utility::flag_wait( "scriptables_ready" );
    trap_core::function_63a557f0f22161af( "fire_trap_switch", &activate_fire_trap, &deactivate_fire_trap, &function_93a1878f1901b4f7 );
    utility::flag_wait( "fire_trap_switch_trap_init_finished" );
    fire_trap_switches = utility::getstructarray( "fire_trap_switch" );
    level zombie_utils::function_dfae6a5bd222c586( &function_dd004f257ca25262 );
    level callback::add( "on_zombie_ai_killed", &function_89e5d11605a5e3bd );
    content_manager::register_disable_toggle( "fire_trap_switch", &content_manager::function_5d04e50a29a2142c, &on_fire_trap_disabled, &function_cf6dda8d2da8b668 );
    
    foreach ( trap_switch in fire_trap_switches )
    {
        trap_switch.switch_scriptable = trap_switch.a_switch_pos[ 0 ].switch_scriptable;
        trap_switch.trap_scriptable = trap_switch.trap_positions[ 0 ].trap_scriptable;
        trap_switch.trap_scriptable.var_32f1e7774266024b = trap_switch.switch_scriptable.var_32f1e7774266024b;
        trap_switch.shared_in_use = 0;
        trap_switch.trap_scriptable.dmg_vols = [];
        var_1423de136c84cc98 = getnoentvolumearray( trap_switch.trap_positions[ 0 ].target, #targetname );
        var_1ae45eeca9ce77c2 = sortbydistance( var_1423de136c84cc98, trap_switch.a_switch_pos[ 0 ].origin );
        
        for ( i = 0; i < 3 ; i++ )
        {
            var_1423de136c84cc98[ i ].parent = trap_switch.trap_scriptable;
            var_1423de136c84cc98[ i ].var_347a287e3c00ee50 = [];
            trap_switch.trap_scriptable.dmg_vols[ i ] = var_1423de136c84cc98[ i ];
        }
        
        trap_switch.trap_scriptable.var_112c06556f2b1aa0 = utility::spawn_model( "tag_origin", trap_switch.trap_scriptable.origin, trap_switch.trap_scriptable.angles );
        trap_switch.trap_scriptable.players_in_trigger = [];
        trap_switch.trap_scriptable.interact = interaction::register_scriptable_interact( trap_switch.trap_scriptable, &function_7e01510598efcf4a, undefined, undefined, &alt_fire_trap_hint );
        trap_switch.trap_scriptable thread function_8f18198a1c4e8d35();
    }
}

// Namespace fire_trap
// Params 1
// Checksum 0x56ec4dd8, Offset: 0x692
// Size: 0xf1
function activate_fire_trap( activator )
{
    level endon( #"game_ended" );
    self endon( #"deactivate_trap" );
    var_32f1e7774266024b = self.var_32f1e7774266024b;
    
    if ( var_32f1e7774266024b.shared_in_use )
    {
        return;
    }
    
    var_32f1e7774266024b.shared_in_use = 1;
    params = spawnstruct();
    params.activator = activator;
    params.var_359a765be5422f83 = self;
    level callback::callback( "on_fire_trap_activated", params );
    trap_scriptable = self.trap_scriptable;
    trap_scriptable setscriptablepartstate( "anim", "intro" );
    trap_scriptable setscriptablepartstate( "sfx", "nozzle_active" );
    trap_scriptable setscriptablepartstate( "VFX", "on" );
    function_e2ced34d1f7ededa( activator );
    trap_scriptable thread function_a459800a136be55b( var_32f1e7774266024b.script_duration );
}

// Namespace fire_trap
// Params 1
// Checksum 0x95ef139e, Offset: 0x78b
// Size: 0xa0
function deactivate_fire_trap( activator )
{
    var_32f1e7774266024b = self.var_32f1e7774266024b;
    var_32f1e7774266024b thread function_6f5ce972179bb662();
    params = spawnstruct();
    params.activator = activator;
    params.var_359a765be5422f83 = self;
    level callback::callback( "on_fire_trap_deactivated", params );
    thread stop_fire();
    wait_dur = 60;
    
    /#
        if ( getdvarint( @"hash_cfcdb945d0507870", 0 ) == 1 )
        {
            wait_dur = level.var_d6ac96657b3d40e7;
        }
    #/
    
    thread function_ab773724c547d5d6( wait_dur );
}

// Namespace fire_trap
// Params 2
// Checksum 0xb817795a, Offset: 0x833
// Size: 0x97, Type: bool
function function_93a1878f1901b4f7( activator, interact )
{
    currency_type = self.switch_scriptable.var_32f1e7774266024b.script_currency;
    currency_cost = self.switch_scriptable.var_32f1e7774266024b.script_cost;
    
    if ( !activator currency::attempt_purchase( currency_type, currency_cost, 1 ) )
    {
        return false;
    }
    
    return !self.trap_positions[ 0 ].var_32f1e7774266024b.shared_in_use;
}

// Namespace fire_trap
// Params 1, eflags: 0x4
// Checksum 0xce92cfe5, Offset: 0x8d3
// Size: 0x41
function private function_a459800a136be55b( duration )
{
    level endon( #"game_ended" );
    self endon( #"deactivate_trap" );
    duration -= 5;
    wait duration;
    playsoundatpos( self.origin, "evt_trap_flame_warning" );
}

// Namespace fire_trap
// Params 0, eflags: 0x4
// Checksum 0xab56a528, Offset: 0x91c
// Size: 0x65
function private function_8f18198a1c4e8d35()
{
    level endon( #"game_ended" );
    utility::flag_wait( "power_on" );
    
    if ( self getscriptablepartstate( #"model" ) != #"hidden" )
    {
        self setscriptablepartstate( #"sfx", #"idle" );
        self setscriptablepartstate( #"model", #"pilot_on" );
    }
}

// Namespace fire_trap
// Params 1
// Checksum 0x164c8daa, Offset: 0x989
// Size: 0xbe
function function_e2ced34d1f7ededa( activator )
{
    foreach ( dmg_vol in self.trap_scriptable.dmg_vols )
    {
        dmg_vol.owner = activator;
        dmg_vol thread dmg_watcher( self );
        
        /#
            if ( getdvarint( @"hash_70a068aeb52261a6", 0 ) == 1 )
            {
                dmg_vol thread function_455cacb8e8fd6b83();
            }
        #/
    }
}

// Namespace fire_trap
// Params 0
// Checksum 0x4532f32e, Offset: 0xa4f
// Size: 0x18e
function stop_fire()
{
    self notify( #"deactivate_trap" );
    self.trap_scriptable setscriptablepartstate( "model", "default" );
    self.trap_scriptable setscriptablepartstate( "anim", "off" );
    self.trap_scriptable setscriptablepartstate( "sfx", "nozzle_off" );
    self.trap_scriptable setscriptablepartstate( "VFX", "cooldown" );
    
    foreach ( dmg_vol in self.trap_scriptable.dmg_vols )
    {
        dmg_vol notify( #"deactivate_trap" );
        dmg_vol.owner = undefined;
        
        foreach ( player in dmg_vol.var_347a287e3c00ee50 )
        {
            player setscriptablepartstate( "burning", "neutral" );
            player.var_4c0ff83fa1459a94 = 0;
        }
    }
}

// Namespace fire_trap
// Params 1, eflags: 0xc
// Checksum 0xc65b0634, Offset: 0xbe5
// Size: 0x63
function private function_ab773724c547d5d6( wait_time )
{
    self notify( #"hash_57a9024abfef17e3" );
    self endon( #"hash_57a9024abfef17e3" );
    level endon( #"game_ended" );
    wait wait_time;
    self.trap_scriptable setscriptablepartstate( "sfx", "idle" );
    self.trap_scriptable setscriptablepartstate( "model", "pilot_on" );
}

// Namespace fire_trap
// Params 0
// Checksum 0x41f4a180, Offset: 0xc50
// Size: 0x2
function function_ce412c0d87692b96()
{
    
}

// Namespace fire_trap
// Params 1
// Checksum 0x98456c3d, Offset: 0xc5a
// Size: 0x2da
function dmg_watcher( var_359a765be5422f83 )
{
    level endon( #"game_ended" );
    self endon( #"deactivate_trap" );
    self.b_in_active = 1;
    
    while ( true )
    {
        self waittill( #"trigger", entity );
        
        if ( isplayer( entity ) && isalive( entity ) && !entity issprintsliding() )
        {
            if ( !entity.var_4c0ff83fa1459a94 )
            {
                player_dmg = getdvarfloat( @"hash_1dd1e620f3ef63ea", 0.05 );
                entity.var_4c0ff83fa1459a94 = 1;
                entity setscriptablepartstate( "burning", "all_parts" );
                self.var_347a287e3c00ee50 = arraycombineunique( self.var_347a287e3c00ee50, [ entity ] );
                entity thread function_7c612544c00715d8( player_dmg, self, var_359a765be5422f83 );
                entity thread function_f5d83dfc3626b8f7( self, var_359a765be5422f83 );
            }
            
            continue;
        }
        
        if ( isai( entity ) && isalive( entity ) )
        {
            if ( isdefined( entity.aicategory ) )
            {
                round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
                zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                duration = 5;
                waittick = 0.25;
                attacker = var_359a765be5422f83.attack_entity;
                dmg_value = zombie_base_health * 0.2;
                entity utility::ent_flag_set( "flame_trap_kill" );
                
                if ( !entity.var_4c0ff83fa1459a94 )
                {
                    entity.var_4c0ff83fa1459a94 = 1;
                    
                    switch ( entity.aicategory )
                    {
                        case #"hash_84fcf5e68d7230b2":
                            entity thread fire_kill_zombie( self, var_359a765be5422f83 );
                            break;
                        case #"hash_8c089e813083e510":
                            zm_dmg = getdvarfloat( @"hash_629d9e0e31d6f208", 0.03 );
                            entity thread function_8dac813586f2e3eb( var_359a765be5422f83 );
                            entity thread function_7c612544c00715d8( zm_dmg, self, var_359a765be5422f83 );
                            entity thread function_f5d83dfc3626b8f7( self, var_359a765be5422f83 );
                            dmg_value = 0;
                            break;
                        case #"hash_7b0e2f2ed84f34":
                            zm_dmg = getdvarfloat( @"hash_d174fd5e9a8c22c8", 0.02 );
                            entity thread function_8dac813586f2e3eb( var_359a765be5422f83 );
                            entity thread function_7c612544c00715d8( zm_dmg, self, var_359a765be5422f83 );
                            entity thread function_f5d83dfc3626b8f7( self, var_359a765be5422f83 );
                            dmg_value = 0;
                        case #"hash_4e47eb6c32f5b165":
                            zm_dmg = getdvarfloat( @"hash_cda5ea4b49ed0da9", 0.01 );
                            entity thread function_8dac813586f2e3eb( var_359a765be5422f83 );
                            entity thread function_7c612544c00715d8( zm_dmg, self, var_359a765be5422f83 );
                            entity thread function_f5d83dfc3626b8f7( self, var_359a765be5422f83 );
                            dmg_value = 0;
                            break;
                    }
                }
                
                entity thread effect_burn::burn( duration, dmg_value, waittick, attacker, "_fire_trap", undefined, attacker, undefined, 1, undefined, 0, 0 );
            }
        }
    }
}

// Namespace fire_trap
// Params 2
// Checksum 0xcffbc301, Offset: 0xf3c
// Size: 0x87
function fire_kill_zombie( dmg_trig, var_359a765be5422f83 )
{
    self endon( #"death" );
    waitframe();
    
    if ( !level.var_541bf6f0b8135f8c.var_1ec9d115b1b3bd09 )
    {
        level.var_541bf6f0b8135f8c.var_1ec9d115b1b3bd09 = 1;
        var_359a765be5422f83.attack_entity.activator thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"flame_trap_kill_first_time", #"bc_flavor_player_positive" );
    }
    
    function_7bbaf393b8ba7e79( dmg_trig, var_359a765be5422f83 );
}

// Namespace fire_trap
// Params 2
// Checksum 0x6afa86d2, Offset: 0xfcb
// Size: 0x58
function function_7bbaf393b8ba7e79( dmg_trig, var_359a765be5422f83 )
{
    if ( isalive( self ) )
    {
        if ( self.magic_bullet_shield )
        {
            return;
        }
        
        if ( isdefined( dmg_trig.owner ) )
        {
        }
        
        utility::ent_flag_set( "flame_trap_kill" );
        self kill( undefined, undefined, var_359a765be5422f83.attack_entity );
    }
}

// Namespace fire_trap
// Params 3
// Checksum 0x619ae93d, Offset: 0x102b
// Size: 0xd6
function function_7c612544c00715d8( n_dmg_ratio, dmg_trigger, var_359a765be5422f83 )
{
    level endon( #"game_ended" );
    var_359a765be5422f83 endon( #"deactivate_trap" );
    self endon( #"death_or_disconnect" );
    
    while ( self istouching( dmg_trigger ) && isalive( self ) )
    {
        var_4e00ee8d01ee7fa3 = self.maxhealth * n_dmg_ratio;
        
        if ( isplayer( self ) )
        {
            if ( self issprintsliding() )
            {
                var_4e00ee8d01ee7fa3 = 0;
            }
        }
        
        if ( isai( self ) && var_4e00ee8d01ee7fa3 >= self.health )
        {
            function_7bbaf393b8ba7e79( dmg_trigger, var_359a765be5422f83 );
        }
        else
        {
            self dodamage( var_4e00ee8d01ee7fa3, self.origin, var_359a765be5422f83.attack_entity, var_359a765be5422f83.attack_entity );
        }
        
        wait 0.5;
    }
}

// Namespace fire_trap
// Params 2
// Checksum 0x14f81a61, Offset: 0x1109
// Size: 0xef
function function_f5d83dfc3626b8f7( dmg_trigger, var_359a765be5422f83 )
{
    level endon( #"game_ended" );
    var_359a765be5422f83 endon( #"deactivate_trap" );
    self endon( #"death" );
    
    while ( self istouching( dmg_trigger ) )
    {
        waitframe();
    }
    
    if ( arraycontains( dmg_trigger.var_347a287e3c00ee50, self ) )
    {
        dmg_trigger.var_347a287e3c00ee50 = arrayremove( dmg_trigger.var_347a287e3c00ee50, self );
    }
    
    self.var_4c0ff83fa1459a94 = 0;
    
    if ( isplayer( self ) || isbot( self ) )
    {
        self setscriptablepartstate( "burning", "neutral" );
        return;
    }
    
    if ( isai( self ) && isalive( self ) && dmg_trigger.b_in_active && isstartstr( self.subclass, "zombie_base" ) )
    {
        utility::ent_flag_set( "flame_trap_kill" );
        thread fire_kill_zombie( dmg_trigger, var_359a765be5422f83 );
    }
}

// Namespace fire_trap
// Params 1
// Checksum 0x59ef8fc4, Offset: 0x1200
// Size: 0x66
function function_8dac813586f2e3eb( var_359a765be5422f83 )
{
    if ( !isdefined( self.var_82019f7191582221 ) )
    {
        self.var_82019f7191582221 = [];
    }
    
    if ( !arraycontains( self.var_82019f7191582221, var_359a765be5422f83 ) )
    {
        self.var_82019f7191582221[ self.var_82019f7191582221.size ] = var_359a765be5422f83;
        zombie_stun::stun_ai( 1.5, "stunned_on" );
        thread function_53af34bdb2c3bed1( var_359a765be5422f83 );
    }
}

// Namespace fire_trap
// Params 1
// Checksum 0x754076b3, Offset: 0x126e
// Size: 0x3f
function function_53af34bdb2c3bed1( var_359a765be5422f83 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 40;
    self.var_82019f7191582221 = arrayremove( self.var_82019f7191582221, var_359a765be5422f83 );
}

// Namespace fire_trap
// Params 0
// Checksum 0x381ac002, Offset: 0x12b5
// Size: 0x2
function function_bf80fe41d951fc98()
{
    
}

// Namespace fire_trap
// Params 2, eflags: 0x4
// Checksum 0xc5143192, Offset: 0x12bf
// Size: 0x2f0
function private alt_fire_trap_hint( usable, player )
{
    if ( !isdefined( player ) || !isdefined( usable ) || level.active_relic_challenge.var_aaff0301aebe08c7 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    var_32f1e7774266024b = usable.var_32f1e7774266024b;
    trap_data = level.var_1bc31921d079dc44[ var_32f1e7774266024b.targetname ];
    state = var_32f1e7774266024b.a_switch_pos[ 0 ].interact.state;
    
    if ( !player currency::can_afford( #"essence", var_32f1e7774266024b.script_cost ) )
    {
        aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        b_interactable = 0;
    }
    
    switch ( state )
    {
        case #"hash_7b6614415d1b2e48":
            aux_text = trap_data.var_bd2515d409a23c21;
            b_interactable = 0;
            break;
        case #"hash_4fdec2979b2f4017":
            b_interactable = 1;
            break;
        case #"hash_5ff4908e6e9a0426":
            aux_text = trap_data.var_d4e63793cbc4c264;
            b_interactable = 0;
            break;
        case #"hash_b389e7ddef378fd0":
            aux_text = trap_data.var_2b5efbe74b39722c;
            b_interactable = 0;
            break;
    }
    
    if ( isdefined( level.var_4d9092a6949e967 ) )
    {
        return { #interactable:b_interactable, #icon_text_value:0, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"ui_icon_zm_ping_trap", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #aux_text:aux_text ?? &"", #description:&"shared_hintstrings/alt_fire_trap_hint", #title:&"shared_hintstrings/trap_title_fire", #params:[ 0 ], #string:&"", #type:"HINT_BUTTON" };
    }
    
    return { #interactable:b_interactable, #icon_text_value:1000, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"ui_icon_zm_ping_trap", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #aux_text:aux_text ?? &"", #description:&"shared_hintstrings/alt_fire_trap_hint", #title:&"shared_hintstrings/trap_title_fire", #params:[ 1000 ], #string:&"", #type:"HINT_BUTTON" };
}

// Namespace fire_trap
// Params 1
// Checksum 0x5ae4cdef, Offset: 0x15b7
// Size: 0x4f8
function function_7e01510598efcf4a( player )
{
    level endon( #"game_ended" );
    
    if ( !utility::flag( "power_on" ) || level.active_relic_challenge.var_aaff0301aebe08c7 )
    {
        return;
    }
    
    var_32f1e7774266024b = self.var_32f1e7774266024b;
    switch_scriptable = var_32f1e7774266024b.switch_scriptable;
    switch_struct = var_32f1e7774266024b.a_switch_pos[ 0 ];
    alt_interact = self.interact;
    alt_trigger = self.alt_trigger;
    currency_type = var_32f1e7774266024b.script_currency;
    currency_cost = var_32f1e7774266024b.script_cost;
    
    if ( !isdefined( switch_scriptable ) || !isdefined( switch_struct.interact ) )
    {
        return;
    }
    
    if ( var_32f1e7774266024b.shared_in_use )
    {
        return;
    }
    
    if ( isdefined( player ) && isdefined( currency_type ) && isdefined( currency_cost ) )
    {
        if ( !player currency::attempt_purchase( currency_type, currency_cost, 1 ) )
        {
            return;
        }
    }
    
    var_32f1e7774266024b.shared_in_use = 1;
    switch_struct function_ff7cbcf86a04dffa( "activate" );
    switch_struct.interact.b_cool_down = 0;
    self setscriptablepartstate( "model", "alt_activated" );
    self setscriptablepartstate( "anim", "intro" );
    self setscriptablepartstate( "sfx", "ring_active" );
    self setscriptablepartstate( "vfx", "ring_of_fire" );
    alt_trigger = spawn( "trigger_radius", self.origin, 0, 200, 200 );
    alt_trigger.parent = self;
    alt_trigger.script_int = 0;
    alt_trigger.attacker = player;
    trigger::makeenterexittrigger( alt_trigger, &function_aaa6c84c38b3cdba, &function_365ca85bee0b084d, undefined, "exit_alt_fire_trap" );
    utility::callsharedfunc( #"zm_blizzard", #"add_zone", alt_trigger );
    
    /#
        if ( getdvarint( @"hash_70a068aeb52261a6", 0 ) == 1 )
        {
            alt_trigger thread function_44dac9b155fb06d3();
        }
    #/
    
    trap_info_struct = { #trap:self, #duration:var_32f1e7774266024b.script_duration };
    level callback::callback( #"hash_a692035c56341eea", trap_info_struct );
    var_32f1e7774266024b.script_duration = trap_info_struct.duration;
    thread function_a459800a136be55b( var_32f1e7774266024b.script_duration );
    utility::waittill_notify_or_timeout( "deactivate_trap", var_32f1e7774266024b.script_duration );
    
    if ( self getscriptablepartstate( #"model" ) != #"hidden" )
    {
        self setscriptablepartstate( "model", "default" );
    }
    
    self setscriptablepartstate( "anim", "off" );
    self setscriptablepartstate( "sfx", "ring_off" );
    self setscriptablepartstate( "vfx", "off" );
    var_32f1e7774266024b.trap_positions[ 0 ] notify( #"deactivate_trap" );
    switch_struct function_ff7cbcf86a04dffa( "cooldown" );
    
    foreach ( player_in_trigger in self.players_in_trigger )
    {
        player_in_trigger function_365ca85bee0b084d( player_in_trigger, alt_trigger );
    }
    
    utility::callsharedfunc( #"zm_blizzard", #"remove_zone", alt_trigger );
    alt_trigger delete();
    self.alt_trigger = undefined;
    
    if ( var_32f1e7774266024b.trap_scriptable.perma_disabled )
    {
        return;
    }
    
    wait_dur = 0;
    
    if ( isdefined( var_32f1e7774266024b.script_timeout ) )
    {
        wait_dur = var_32f1e7774266024b.script_timeout;
    }
    
    /#
        if ( getdvarint( @"hash_cfcdb945d0507870", 0 ) == 1 )
        {
            wait_dur = level.var_d6ac96657b3d40e7;
        }
    #/
    
    wait wait_dur;
    var_32f1e7774266024b.shared_in_use = 0;
    switch_struct function_ff7cbcf86a04dffa( "ready" );
    switch_struct.interact.b_cool_down = 1;
    
    if ( self getscriptablepartstate( #"model" ) != #"hidden" )
    {
        self setscriptablepartstate( "sfx", "idle" );
        self setscriptablepartstate( "model", "pilot_on" );
    }
    
    if ( var_32f1e7774266024b.default_script_duration )
    {
        var_32f1e7774266024b.script_duration = var_32f1e7774266024b.default_script_duration;
        var_32f1e7774266024b.default_script_duration = undefined;
    }
    
    if ( var_32f1e7774266024b.default_script_timeout )
    {
        var_32f1e7774266024b.script_timeout = var_32f1e7774266024b.default_script_timeout;
        var_32f1e7774266024b.default_script_timeout = undefined;
    }
}

// Namespace fire_trap
// Params 1
// Checksum 0x82f21fca, Offset: 0x1ab7
// Size: 0x6c
function function_ff7cbcf86a04dffa( new_state )
{
    var_1707af50dcbc1589 = new_state == "ready" ? "buyable" : new_state;
    self.state = new_state;
    self.var_32f1e7774266024b trap_core::set_switch_scriptable_state( "base", self.state );
    self.interact.state = var_1707af50dcbc1589;
}

// Namespace fire_trap
// Params 0
// Checksum 0x81b6375a, Offset: 0x1b2b
// Size: 0x56
function function_6f5ce972179bb662()
{
    wait_dur = 0;
    
    if ( isdefined( self.script_timeout ) )
    {
        wait_dur = self.script_timeout;
    }
    
    /#
        if ( getdvarint( @"hash_cfcdb945d0507870", 0 ) == 1 )
        {
            wait_dur = level.var_d6ac96657b3d40e7;
        }
    #/
    
    wait wait_dur;
    self.shared_in_use = 0;
}

// Namespace fire_trap
// Params 2
// Checksum 0xbf9b31c6, Offset: 0x1b89
// Size: 0x13a
function function_aaa6c84c38b3cdba( ent, trigger )
{
    if ( !isdefined( trigger ) || !isalive( ent ) || !isplayer( ent ) && !isai( ent ) )
    {
        return;
    }
    
    if ( isplayer( ent ) && !ent.var_48fc1f163fceea29 )
    {
        ent thread function_1feaf7a0d780fb11();
        trigger.parent.players_in_trigger = arraycombineunique( trigger.parent.players_in_trigger, [ ent ] );
        ent.var_48fc1f163fceea29 = 1;
        level callback::callback( #"hash_4b6e460a881d6da6", { #player:ent, #trap:trigger.parent } );
        pct = getdvarfloat( @"hash_8379b60642863712", 1 );
        cooldown_len = getdvarfloat( @"hash_c81e2cdb58db69bb", 0.1 );
        ent.trap_ammo_mod = { #cooldown_len:cooldown_len, #pct:pct, #can_proc:1 };
    }
}

// Namespace fire_trap
// Params 2
// Checksum 0x5322f47b, Offset: 0x1ccb
// Size: 0xb1
function function_365ca85bee0b084d( ent, trigger )
{
    self notify( #"hash_64043d71bad293c6" );
    self.var_48fc1f163fceea29 = 0;
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    if ( arraycontains( trigger.parent.players_in_trigger, self ) || !isalive( self ) )
    {
        trigger.parent.players_in_trigger = arrayremove( trigger.parent.players_in_trigger, self );
        level callback::callback( #"hash_4b57400860de234e", { #player:self, #trap:trigger } );
    }
}

// Namespace fire_trap
// Params 1
// Checksum 0xe1b466b5, Offset: 0x1d84
// Size: 0x13d
function function_89e5d11605a5e3bd( params )
{
    if ( isplayer( params.eattacker ) && params.eattacker.var_48fc1f163fceea29 || params.evictim.var_93dda308b67b1560 )
    {
        inventorytype = params.objweapon.inventorytype;
        
        if ( utility::isbulletdamage( params.smeansofdeath ) || inventorytype == "primary" )
        {
            self.var_e797f68de73ece4e = "_fire_trap";
        }
        
        var_6f88a6bfefadea5e = {};
        var_6f88a6bfefadea5e.player = params.eattacker;
        var_6f88a6bfefadea5e.smeansofdeath = "";
        utility::ent_flag_set( "flame_trap_kill" );
        callback::callback( "on_zombie_ai_killed_by_alt_fire_trap", var_6f88a6bfefadea5e );
        
        if ( !level.var_541bf6f0b8135f8c.var_1ec9d115b1b3bd09 )
        {
            level.var_541bf6f0b8135f8c.var_1ec9d115b1b3bd09 = 1;
            params.eattacker thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"flame_trap_kill_first_time", #"bc_flavor_player_positive" );
        }
    }
}

// Namespace fire_trap
// Params 0, eflags: 0xc
// Checksum 0x99f37cf6, Offset: 0x1ec9
// Size: 0x82
function private function_1feaf7a0d780fb11()
{
    self notify( #"hash_a68962f4e9db8682" );
    self endon( #"hash_a68962f4e9db8682" );
    level endon( #"game_ended" );
    self endon( #"hash_64043d71bad293c6" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( utility::callsharedfunc( #"locust_ww", #"hash_5d3ddb2290527878" ) )
        {
            utility::callsharedfunc( #"locust_ww", #"hash_75515290edb3968f", 15 );
        }
    }
}

// Namespace fire_trap
// Params 0
// Checksum 0x99ff1528, Offset: 0x1f53
// Size: 0x2
function function_8b524aa559fdd4ed()
{
    
}

// Namespace fire_trap
// Params 1
// Checksum 0xe82dc034, Offset: 0x1f5d
// Size: 0x11a
function function_dd004f257ca25262( params )
{
    attacker = params.eattacker;
    
    if ( !isplayer( attacker ) || !isalive( attacker ) || !attacker.var_48fc1f163fceea29 || !( utility::isbulletdamage( params.smeansofdeath ) || utility::ismeleedamage( params.smeansofdeath ) ) )
    {
        return -1;
    }
    
    if ( !attacker.trap_ammo_mod.can_proc )
    {
        return -1;
    }
    
    center = self getcentroid();
    success = randomfloat( 1 ) <= attacker.trap_ammo_mod.pct;
    
    if ( success )
    {
        napalmburst::function_2d2890b8aaa96ed4( 0, attacker, undefined, nullweapon(), center, "none", undefined, 1, 1, "_fire_trap" );
        self.var_93dda308b67b1560 = 1;
        attacker.trap_ammo_mod.can_proc = 0;
        level thread function_4efb0425adfdd6a9( attacker );
    }
    
    return -1;
}

// Namespace fire_trap
// Params 1
// Checksum 0x22d7fa4f, Offset: 0x2080
// Size: 0x47
function function_4efb0425adfdd6a9( player )
{
    player endon( #"disconnect" );
    wait player.trap_ammo_mod.cooldown_len;
    player.trap_ammo_mod.can_proc = 1;
}

// Namespace fire_trap
// Params 1, eflags: 0x4
// Checksum 0x2e632256, Offset: 0x20cf
// Size: 0x165
function private on_fire_trap_disabled( feature )
{
    trap_body = feature;
    trap_sbl = trap_body.trap_scriptable;
    trap_body trap_core::set_trap_scriptable_state( "base", "no_power" );
    trap_sbl function_7653c765b6c7b815();
    trap_sbl setscriptablepartstate( "sfx", "off" );
    trap_sbl setscriptablepartstate( "model", "default" );
    
    foreach ( s_switch in trap_body.a_switch_pos )
    {
        if ( s_switch.interact.state == "cooldown" )
        {
            s_switch.interact notify( #"hash_955a9472d9eab0a1" );
        }
        
        s_switch.interact.state = "no_power";
        s_switch trap_core::set_switch_scriptable_state( "base", s_switch.interact.state );
        s_switch.interact.var_94d1ab5da995e573 = 1;
    }
}

// Namespace fire_trap
// Params 1, eflags: 0x4
// Checksum 0xfc8c4a8c, Offset: 0x223c
// Size: 0x148
function private function_cf6dda8d2da8b668( feature )
{
    trap_body = feature;
    trap_sbl = trap_body.trap_scriptable;
    trap_body trap_core::set_trap_scriptable_state( "base", "ready" );
    trap_sbl function_e203bba36cfb19d0();
    trap_sbl setscriptablepartstate( "sfx", "idle" );
    trap_sbl setscriptablepartstate( "model", "pilot_on" );
    
    foreach ( s_switch in trap_body.a_switch_pos )
    {
        s_switch.interact.state = "buyable";
        s_switch.interact.var_94d1ab5da995e573 = 0;
        s_switch.interact.b_cool_down = 1;
        s_switch trap_core::set_switch_scriptable_state( "base", s_switch.interact.state );
    }
}

// Namespace fire_trap
// Params 0
// Checksum 0x63e7a284, Offset: 0x238c
// Size: 0x2
function __debug()
{
    
}

/#

    // Namespace fire_trap
    // Params 0, eflags: 0x4
    // Checksum 0xac5c3753, Offset: 0x2396
    // Size: 0x2e, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x37>", "<dev string:x49>", &function_7c6627801f820b4e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace fire_trap
    // Params 0
    // Checksum 0x32977302, Offset: 0x23cc
    // Size: 0x62, Type: dev
    function function_7c6627801f820b4e()
    {
        setdevdvarifuninitialized( @"hash_70a068aeb52261a6", 0 );
        curr_val = getdvarint( @"hash_70a068aeb52261a6" );
        
        if ( getdvarint( @"hash_70a068aeb52261a6", 0 ) == 0 )
        {
            new_dvar_val = 1;
        }
        else
        {
            new_dvar_val = 0;
        }
        
        setdvar( @"hash_70a068aeb52261a6", new_dvar_val );
    }

    // Namespace fire_trap
    // Params 0
    // Checksum 0xe9092f51, Offset: 0x2436
    // Size: 0xcb, Type: dev
    function function_455cacb8e8fd6b83()
    {
        level endon( #"game_ended" );
        self endon( #"deactivate_trap" );
        vol_struct = self.struct;
        dimensions = ( vol_struct._size_max[ 0 ] + vol_struct._size_min[ 0 ], vol_struct._size_max[ 1 ] + vol_struct._size_min[ 1 ], vol_struct._size_max[ 2 ] + vol_struct._size_min[ 2 ] );
        
        while ( true )
        {
            orientedbox( vol_struct.origin, dimensions, vol_struct.angles, ( 1, 0.5, 0 ), 1, 35 );
            wait 1;
        }
    }

    // Namespace fire_trap
    // Params 0
    // Checksum 0x9f54817f, Offset: 0x2509
    // Size: 0x67, Type: dev
    function function_44dac9b155fb06d3()
    {
        level endon( #"game_ended" );
        self.parent.var_32f1e7774266024b.trap_positions[ 0 ] endon( #"deactivate_trap" );
        
        while ( true )
        {
            sphere( self.origin, 200, ( 1, 0.5, 0 ), 1, 35 );
            wait 1;
        }
    }

#/
