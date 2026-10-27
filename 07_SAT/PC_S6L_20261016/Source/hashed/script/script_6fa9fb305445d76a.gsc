// script_6fa9fb305445d76a  (hash_6fa9fb305445d76a.gscc) (size: 15722 Bytes / 0x3d6a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80c18cf6 (2160168182)
// size ...... 15722 (0x3d6a)
// includes .. 18  (offset: 0x3816)
// strings ... 83  (offset: 0x38a6)
// dev strs .. 5   (offset: 0x3d2a)
// exports ... 39  (offset: 0x2296)
// cseg ...... 0x5c3 + 0x1cd3 (0x2296)
// imports ... 129 (offset: 0x28ae)
// animtree1 . 0   (offset: 0x3d6a)
// animtree2 . 0   (offset: 0x3d6a)
#using script_16ea1b94f0f381b3;
#using script_23b580b08abe064f;
#using script_468b83303606e795;
#using script_4c50b97d3697e30f;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\status_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\rank;

#namespace zombie_hellhound;

// Namespace zombie_hellhound
// Params 2
// Checksum 0x7a345c04, Offset: 0x5e1
// Size: 0x1e
function precache( classname, aitypescriptbundle )
{
    init_zombie_hellhound_pet_precache( aitypescriptbundle );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x6642ee27, Offset: 0x607
// Size: 0x1e2
function private function_cfbb84b3d7bc65b8( params )
{
    zombie_hellhound_audio::function_6f39238c8dd13230();
    zombie_melee::init_zombie_melee_global();
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "spawn_animscripted", &function_e7fe1f8d4410ffd7 );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &function_82c00b437547d531 );
    
    if ( !level callback::exists( #"player_laststand", &on_player_laststand_enter ) )
    {
        level callback::add( #"player_laststand", &on_player_laststand_enter );
    }
    
    if ( !level callback::exists( #"player_death", &on_player_death ) )
    {
        level callback::add( #"player_death", &on_player_death );
    }
    
    /#
        setup_hellhound_devgui();
    #/
}

// Namespace zombie_hellhound
// Params 1
// Checksum 0x89a75b88, Offset: 0x7f1
// Size: 0x1b9
function function_cc6153da512d645( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    zombie_utils::function_dfae6a5bd222c586( &function_6e88765a62e61d6b );
    self.allowstrafe = 0;
    self.var_7bd2fc702f01b407 = 1;
    
    if ( getdvarint( @"ob_living_world" ) == 1 )
    {
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.diggingenabled )
        {
            if ( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.diggingitemspawnlist ) )
            {
                thread function_15239deae51ca70b();
            }
        }
    }
    
    zombie_hellhound_knockdown::function_578cd83f268c0cc3();
    zombie_melee::init_zombie_melee();
    zombie_hellhound_audio::init_zombie_hellhound_audio();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    thread initscriptable();
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_711f7fcb28081a9a )
    {
        thread function_14d919b1a01e1cd1();
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9803cef712959f0 && isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8fdca14dd18ed734 ) && self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8fdca14dd18ed734 != "" )
    {
        self.default_spawn_animation = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8fdca14dd18ed734;
    }
    
    return anim.success;
}

// Namespace zombie_hellhound
// Params 0
// Checksum 0xeba76303, Offset: 0x9b3
// Size: 0x6c
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self isscriptable() )
    {
        is_cryofreeze_on = 0;
        
        if ( self getscriptablehaspart( "cryofreeze" ) && self getscriptablepartstate( "cryofreeze" ) == "cryofreeze_on" )
        {
            is_cryofreeze_on = 1;
        }
        
        if ( !is_cryofreeze_on )
        {
            utility::function_32b24db3127bff40( "base", "base_on" );
        }
    }
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xcf3438dc, Offset: 0xa27
// Size: 0x74
function private init_zombie_hellhound_pet_precache( aitypescriptbundle )
{
    var_d6894f01a36b4ff3 = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    var_8be51e1b9af4b208 = getscriptbundle( var_d6894f01a36b4ff3.var_394d3c5e6fa40c50 );
    utility::add_fx( "hellhound_spawn_flash_fx", var_8be51e1b9af4b208.spawnvfx );
    utility::add_fx( "hellhound_spawn_in_fx", var_8be51e1b9af4b208.var_11aeb5871ee9f669 );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x2deb6ea9, Offset: 0xaa3
// Size: 0x13b
function private play_death_fx( params )
{
    if ( utility::ent_flag( "burned" ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_32b24db3127bff40( "burned", "burned_on" );
            params.body thread function_fc12a24729ef4e67();
        }
    }
    else if ( utility::ent_flag( "napalm_burned" ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            params.body thread function_a67c6606a684a2dd();
        }
    }
    else if ( utility::ent_flag( "locust_ww_burned" ) )
    {
        params.body utility::function_32b24db3127bff40( "burned_locust_ww", "burned_dead" );
    }
    else if ( utility::ent_flag( "locust_ww_burned_pap" ) )
    {
        params.body utility::function_32b24db3127bff40( "burned_locust_ww_pap", "burned_dead" );
    }
    
    if ( isdefined( self.death_explode_func ) )
    {
        self thread [[ self.death_explode_func ]]( params );
        return;
    }
    
    thread death_explode( params.body, params.eattacker );
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x131265ce, Offset: 0xbe6
// Size: 0x1e
function private function_fc12a24729ef4e67()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    }
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x6f008a48, Offset: 0xc0c
// Size: 0x1e
function private function_a67c6606a684a2dd()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
    }
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xaa60b5f3, Offset: 0xc32
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x3df11243, Offset: 0xc57
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x7bc4be56, Offset: 0xc7c
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x68329558, Offset: 0xcc3
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x82121eed, Offset: 0xd0a
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xe4fbb34d, Offset: 0xd2f
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x8a03bd07, Offset: 0xd54
// Size: 0x29
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::ent_flag_clear( "napalm_burned" );
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x6f2db17f, Offset: 0xd85
// Size: 0x30
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "turned", 26 );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_hellhound
// Params 2, eflags: 0x4
// Checksum 0x87d35fc, Offset: 0xdbd
// Size: 0x44d
function private death_explode( body, attacker )
{
    level endon( #"game_ended" );
    utility::function_32b24db3127bff40( "base", "base_off" );
    body utility::function_32b24db3127bff40( "base", "base_on" );
    var_e4608505a7697681 = 0.5;
    var_e261de90c97d18b1 = 1;
    
    if ( self.forceannihilate )
    {
        if ( self._blackboard.var_431d45d5a00efc3d && self._blackboard.vortexmode == "blackhole" )
        {
            var_e261de90c97d18b1 = 0;
        }
        
        var_e4608505a7697681 = level.framedurationseconds;
        body.forceannihilate = 1;
    }
    else if ( self.explode_time_override > 0 )
    {
        var_e4608505a7697681 = self.explode_time_override;
    }
    else if ( isdefined( self.asmname ) )
    {
        statename = self asmgetcurrentstate( self.asmname );
        animid = asm::asm_getanim( self.asmname, statename );
        xanim = asm::asm_getxanim( statename, animid );
        
        if ( isanimation( xanim ) )
        {
            animlength = getanimlength( xanim );
            
            if ( animhasnotetrack( xanim, "zombie_dog_explode" ) )
            {
                var_adbcd06227e8326f = getnotetracktimes( xanim, "zombie_dog_explode" )[ 0 ];
                var_e4608505a7697681 = animlength * var_adbcd06227e8326f;
            }
        }
    }
    
    var_301d850c6dd9cd63 = spawnstruct();
    var_301d850c6dd9cd63.var_a7d48a95bf00eb0f = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a9eba73b4db0aec2;
    var_301d850c6dd9cd63.var_26d60828d52dbe5e = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_534e039a3993efd5;
    var_301d850c6dd9cd63.var_11e56719b4a07f70 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9a69d405c47f8b4d;
    var_301d850c6dd9cd63.var_e53f6343f1d63f7a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.flameduration;
    var_301d850c6dd9cd63.round_number = zombie_utils::get_zombie_round_difficulty();
    var_301d850c6dd9cd63.var_fe048a2106d8ef00 = self.var_fe048a2106d8ef00;
    explode_vfx_time = 0.1;
    body function_dd258a3da9a2b4a1( var_301d850c6dd9cd63.var_e53f6343f1d63f7a + var_e4608505a7697681 + explode_vfx_time );
    results = body utility::waittill_any_return_params_or_timeout( var_e4608505a7697681, "corpse_thrown_explode" );
    
    if ( isdefined( body ) )
    {
        blast_radius = 65;
        blast_inner_damage = 17;
        blast_outer_damage = 7;
        body utility::function_32b24db3127bff40( "death", "explode_on" );
        
        if ( body.forceannihilate )
        {
            body utility::function_32b24db3127bff40( "death_annihilate", "death_annihilate" );
            body callback::callback( "on_annihilated" );
        }
        
        if ( results[ "message" ] == "corpse_thrown_explode" && results[ 0 ] )
        {
            var_b7b609abde6844aa = results[ 0 ];
        }
        else
        {
            var_b7b609abde6844aa = body gettagorigin( "j_spine2", 1 ) ?? body.origin;
        }
        
        var_b7b609abde6844aa = utility::drop_to_ground( var_b7b609abde6844aa, 100 );
        var_a2ed83ab36ec43c8 = spawn( "script_model", var_b7b609abde6844aa );
        
        if ( !isdefined( var_a2ed83ab36ec43c8 ) )
        {
            var_a2ed83ab36ec43c8 = body;
        }
        
        var_a2ed83ab36ec43c8.owner = attacker;
        var_a2ed83ab36ec43c8.weapon_name = "hellhound_molotov";
        var_a2ed83ab36ec43c8.weapon_object = nullweapon();
        var_a2ed83ab36ec43c8.prevent_knockdown = 1;
        var_a2ed83ab36ec43c8.var_d7594a5edcf54e30 = &function_d7594a5edcf54e30;
        var_a2ed83ab36ec43c8.attacker_subclass = self.subclass;
        level thread apply_explosion_damage( var_b7b609abde6844aa, blast_radius, blast_inner_damage, blast_outer_damage, attacker, body, "MOD_EXPLOSIVE", var_301d850c6dd9cd63, var_a2ed83ab36ec43c8 );
        level thread function_30461691650a2a72( var_b7b609abde6844aa, blast_radius, body );
        
        if ( var_e261de90c97d18b1 )
        {
            body thread function_e481cca7a0ef32b6( var_b7b609abde6844aa, var_301d850c6dd9cd63.var_fe048a2106d8ef00[ #"hellhound_pool" ], attacker, var_a2ed83ab36ec43c8 );
        }
        
        wait explode_vfx_time;
        
        if ( !isdefined( body ) )
        {
            return;
        }
        
        body hide();
        wait var_301d850c6dd9cd63.var_e53f6343f1d63f7a;
        
        if ( isdefined( body ) )
        {
            body delete();
        }
        
        if ( isdefined( var_a2ed83ab36ec43c8 ) )
        {
            var_a2ed83ab36ec43c8 delete();
        }
    }
}

// Namespace zombie_hellhound
// Params 9, eflags: 0x4
// Checksum 0xa145bad0, Offset: 0x1212
// Size: 0x2fe
function private apply_explosion_damage( origin, radius, var_a45682402aaf604e, var_d795e8197507b57b, attacker, exploder, means_of_death, var_301d850c6dd9cd63, var_a2ed83ab36ec43c8 )
{
    level endon( #"game_ended" );
    potential_targets = [];
    potential_targets = getaiarrayinradius( origin, radius );
    
    if ( isdefined( exploder.team ) )
    {
        players = getplayersinradius( origin, radius );
        var_aeacddf87ef52029 = [];
        
        foreach ( player in players )
        {
            if ( exploder.team != player.team )
            {
                var_aeacddf87ef52029[ var_aeacddf87ef52029.size ] = player;
            }
        }
        
        if ( var_aeacddf87ef52029.size )
        {
            potential_targets = arraycombine( potential_targets, var_aeacddf87ef52029 );
        }
    }
    
    if ( !isdefined( attacker ) )
    {
        attacker = var_a2ed83ab36ec43c8;
    }
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) || target == exploder )
        {
            continue;
        }
        
        if ( issubstr( target.subclass, "zombie_hellhound" ) || issubstr( target.subclass, "zombie_base_armored_agni" ) )
        {
            continue;
        }
        
        base_explosion_damage = mapfloat( 0, radius, var_a45682402aaf604e, var_d795e8197507b57b, distance( target.origin, origin ) );
        var_65c55325765f1984 = base_explosion_damage;
        
        if ( isai( target ) )
        {
            n_round = var_301d850c6dd9cd63.round_number;
            
            if ( n_round >= var_301d850c6dd9cd63.var_a7d48a95bf00eb0f )
            {
                if ( n_round > var_301d850c6dd9cd63.var_26d60828d52dbe5e )
                {
                    n_round = var_301d850c6dd9cd63.var_26d60828d52dbe5e;
                }
                
                var_884e66a2b9ea21cb = n_round - var_301d850c6dd9cd63.var_a7d48a95bf00eb0f + 1;
                var_b5ea3be9d1a829aa = 1 + var_301d850c6dd9cd63.var_11e56719b4a07f70;
                var_7d1e526fec068901 = pow( var_b5ea3be9d1a829aa, var_884e66a2b9ea21cb );
                var_65c55325765f1984 = int( var_65c55325765f1984 * var_7d1e526fec068901 );
            }
        }
        else
        {
            var_65c55325765f1984 = ceil( base_explosion_damage * ( var_301d850c6dd9cd63.var_fe048a2106d8ef00[ #"hellhound_explosion" ] ?? 1 ) );
        }
        
        var_65c55325765f1984 = int( var_65c55325765f1984 );
        target dodamage( var_65c55325765f1984, origin, attacker, var_a2ed83ab36ec43c8, means_of_death, undefined, "torso_lower" );
    }
}

// Namespace zombie_hellhound
// Params 3, eflags: 0x4
// Checksum 0xd7911585, Offset: 0x1518
// Size: 0x10a
function private function_30461691650a2a72( origin, radius, exploder )
{
    potential_targets = getaiarrayinradius( origin, radius );
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) || target == exploder )
        {
            continue;
        }
        
        if ( target.aicategory == "normal" && !issubstr( target.subclass, "zombie_base_armored" ) && !issubstr( target.subclass, "zombie_hellhound" ) && !target zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            target zombie_knockdown::function_6fc167d4a3590991( origin );
        }
    }
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x28ea2cad, Offset: 0x162a
// Size: 0x124
function private function_aba375756cf9f184( source )
{
    if ( !isai( self ) )
    {
        return -1;
    }
    
    if ( issubstr( self.subclass, "zombie_hellhound" ) )
    {
        return 0;
    }
    
    if ( self.aicategory == "boss" )
    {
        return 0;
    }
    
    if ( issubstr( self.subclass, "zombie_base_armored_agni" ) )
    {
        return 0;
    }
    
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    dmg_ratio = undefined;
    
    if ( self.aicategory )
    {
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                dmg_ratio = 0.075;
                break;
            case #"hash_8c089e813083e510":
                dmg_ratio = 0.05;
                break;
            case #"hash_7b0e2f2ed84f34":
                dmg_ratio = 0.025;
                break;
            case #"hash_4e47eb6c32f5b165":
                dmg_ratio = 0.01;
                break;
        }
    }
    
    if ( !isdefined( dmg_ratio ) )
    {
        return -1;
    }
    
    return max( 1, int( zombie_base_health * dmg_ratio ) );
}

// Namespace zombie_hellhound
// Params 4, eflags: 0x4
// Checksum 0xeb695b43, Offset: 0x1757
// Size: 0x1d9
function private function_e481cca7a0ef32b6( var_f6a15c4c4115faa8, var_13727c7357581d8d, attacker, var_a2ed83ab36ec43c8 )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( isdefined( level.var_3e74032bbe4a375f ) )
    {
        burnbundle = level.var_3e74032bbe4a375f;
    }
    else
    {
        burnbundle = spawnstruct();
        burnbundle.var_c3f25b11c2247a29 = 2;
        burnbundle.var_7ceb375188b38c13 = 2;
        burnbundle.var_78880e1476d45684 = 2;
        burnbundle.var_29dd3c8b7a515774 = 0.2;
        burnbundle.var_61041a515545d346 = "";
        burnbundle.var_35807474702938c6 = 1;
        burnbundle.damage_override_func = &function_aba375756cf9f184;
        burnbundle.var_13727c7357581d8d = var_13727c7357581d8d;
        burnbundle.molotov_damage_flags = 1073741824;
        burnbundle.means_of_death = "MOD_FIRE";
    }
    
    var_a2ed83ab36ec43c8.var_5b038f631de3ad97 = burnbundle;
    var_a2ed83ab36ec43c8.blueprintdefindex = 0;
    var_a2ed83ab36ec43c8.nonavobstacle = burnbundle.nonavobstacle;
    var_a2ed83ab36ec43c8.friendlyfireexception = burnbundle.friendlyfireexception;
    var_234cdf722852c327 = level.equipment.table[ "equip_molotov_hellhound" ] ?? level.equipment.table[ "equip_molotov" ];
    
    if ( var_234cdf722852c327.objweapon )
    {
        burnbundle.useweapon = var_234cdf722852c327.objweapon;
    }
    
    thread molotov::molotov_simulate_impact( var_a2ed83ab36ec43c8, var_f6a15c4c4115faa8, ( 0, 0, 1 ), undefined, ( 0, 0, 100 ), gettime(), "equip_molotov_hellhound_pool_mp_p" );
    thread play_impact_fx( var_f6a15c4c4115faa8 );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xb2ea16cc, Offset: 0x1938
// Size: 0x88
function private play_impact_fx( position )
{
    self endon( #"death" );
    ignore = undefined;
    
    if ( isalive( ignore ) )
    {
        ignore = self;
    }
    
    trace = trace::_bullet_trace( position + ( 0, 0, 20 ), position, 0, ignore );
    var_3051911490153b0c = trace[ "surfacetype" ] == "surftype_water";
    
    if ( !var_3051911490153b0c )
    {
        if ( isdefined( self ) )
        {
            utility::function_32b24db3127bff40( "death_impact", "impact_on" );
        }
    }
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x3df7edac, Offset: 0x19c8
// Size: 0x85
function private function_6e88765a62e61d6b( params )
{
    if ( isdefined( params.einflictor ) && params.einflictor.weapon_name == "hellhound_molotov" )
    {
        params.var_d20799805edf0194 = 1;
        return 0;
    }
    
    if ( isdefined( self.var_ef6139ebe4f0f95a ) )
    {
        newdamage = self [[ self.var_ef6139ebe4f0f95a ]]( params );
        
        if ( isdefined( newdamage ) )
        {
            return newdamage;
        }
    }
    
    return params.idamage;
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xd5b0a91, Offset: 0x1a56
// Size: 0x1e9
function private function_e7fe1f8d4410ffd7( params )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_9be9559dfb0f242c = "show_hound";
    val::set( "spawn_anim", "hide", 1 );
    val::set( "spawn_anim", "disallow_bloat", 1 );
    thread function_87bce3edb6e5351e();
    scriptable = undefined;
    
    if ( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.spawnscriptable ) )
    {
        scriptable = spawnscriptable( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.spawnscriptable, self.origin + ( 0, 0, 90 ), self.angles );
        scriptable setscriptablepartstate( "spawn_fx", "spawn_loop" );
    }
    
    thread function_e5990b59d48c79e2( scriptable, var_9be9559dfb0f242c );
    waitframe();
    show_time = 2;
    
    if ( isdefined( self.asmname ) )
    {
        var_377c4a4461cc5c49 = undefined;
        
        if ( isdefined( params ) && isdefined( params.aliasname ) )
        {
            var_377c4a4461cc5c49 = [ params.aliasname ];
        }
        
        statename = self asmgetcurrentstate( self.asmname );
        animid = asm::asm_getanim( self.asmname, statename, var_377c4a4461cc5c49 );
        xanim = asm::asm_getxanim( statename, animid );
        animlength = getanimlength( xanim );
        
        if ( animhasnotetrack( xanim, var_9be9559dfb0f242c ) )
        {
            frac = getnotetracktimes( xanim, var_9be9559dfb0f242c )[ 0 ];
            show_time = animlength * frac;
        }
    }
    
    wait show_time;
    self notify( var_9be9559dfb0f242c );
    
    if ( isalive( self ) )
    {
        self notify( #"show_hellhound" );
        thread spawn_flash_vfx();
        
        if ( isalive( self ) )
        {
            val::reset_all( "spawn_anim" );
        }
    }
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x6d2ea104, Offset: 0x1c48
// Size: 0x19
function private function_87bce3edb6e5351e()
{
    wait 10;
    
    if ( isalive( self ) )
    {
        val::reset_all( "spawn_anim" );
    }
}

// Namespace zombie_hellhound
// Params 2, eflags: 0x4
// Checksum 0x2f4d9a52, Offset: 0x1c69
// Size: 0x3c
function private function_e5990b59d48c79e2( scriptable, end_note )
{
    level endon( #"game_ended" );
    utility::waittill_any( end_note, "death" );
    
    if ( isdefined( scriptable ) )
    {
        scriptable freescriptable();
    }
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x1e6d067c, Offset: 0x1cad
// Size: 0x13
function private spawn_flash_vfx()
{
    utility::function_32b24db3127bff40( "spawn_fx", "spawn_flash" );
}

// Namespace zombie_hellhound
// Params 1
// Checksum 0xe17d7602, Offset: 0x1cc8
// Size: 0x142
function function_61183ed213dc12ae( item_count )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( item_count ) )
    {
        item_count = 1;
    }
    
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "dig", "hellhound_dig_complete", undefined, undefined, undefined );
    utility::function_32b24db3127bff40( "digging", "digging_on" );
    self waittill( #"hellhound_dig_complete" );
    utility::function_32b24db3127bff40( "digging", "digging_off" );
    
    if ( isdefined( self.var_bd22ba6c600a23a3 ) )
    {
        closestplayer = zombie_hellhound_pet_asm::function_6c0182e951281eab();
        
        if ( distancesquared( closestplayer.origin, self.origin ) > 40000 )
        {
            self waittill( #"hash_383911d9e31b7523" );
        }
        
        wait 0.75;
        var_f06c3d8143b76949 = self gettagorigin( "j_head" );
        item = namespace_9d8e359c3b1041e5::spawnpickupfromlistsharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.diggingitemspawnlist, item_count, var_f06c3d8143b76949 );
    }
    else
    {
        item = namespace_9d8e359c3b1041e5::spawnpickupfromlistsharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.diggingitemspawnlist, item_count, self.origin );
    }
    
    self.var_2723dd9262a6181d = 0;
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x6f93e152, Offset: 0x1e12
// Size: 0xda
function private function_15239deae51ca70b()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.var_2723dd9262a6181d = 0;
    var_6d385136f6bf8e72 = 30;
    
    while ( true )
    {
        wait randomfloat( var_6d385136f6bf8e72 );
        
        if ( randomfloat( 1 ) < 0.5 )
        {
            var_dd3887f0e9e7ff79 = 0;
            
            if ( status_effects::has_status_effect_type( "charm" ) )
            {
                var_dd3887f0e9e7ff79 = 1;
            }
            
            if ( !self.var_2723dd9262a6181d )
            {
                if ( var_dd3887f0e9e7ff79 )
                {
                    if ( !isdefined( self.enemy ) && !self.petting )
                    {
                        self.var_2723dd9262a6181d = 1;
                        thread function_61183ed213dc12ae( 1 );
                    }
                }
                else if ( !isdefined( self.enemy ) )
                {
                    self.var_2723dd9262a6181d = 1;
                    thread function_61183ed213dc12ae( 1 );
                }
            }
        }
        
        wait var_6d385136f6bf8e72;
    }
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x2694011b, Offset: 0x1ef4
// Size: 0x36
function private function_14d919b1a01e1cd1()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"bmeleeended" );
        thread function_d6bcabb27859c9bf();
    }
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x70584265, Offset: 0x1f32
// Size: 0x66
function private function_d6bcabb27859c9bf()
{
    var_9a5568d8b174bdf0 = 1;
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"start_chase_slowdown" );
    self endon( #"start_chase_slowdown" );
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "chase_slowdown", 15 );
    wait var_9a5568d8b174bdf0;
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "chase_slowdown" );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x404fc1a2, Offset: 0x1fa0
// Size: 0x3a
function private function_82c00b437547d531( params )
{
    if ( isplayer( params.var_2d2aab21299551f8 ) )
    {
        params.var_2d2aab21299551f8 utility::function_32b24db3127bff40( "hellhoundMeleeVFX", "hit_fx" );
    }
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xaa1387c5, Offset: 0x1fe2
// Size: 0x50
function private on_player_laststand_enter( params )
{
    if ( !self.var_c36cb8f36e9afca1 && params.inflictor.attacker_subclass )
    {
        self.var_c36cb8f36e9afca1 = params.inflictor.attacker_subclass;
    }
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0x92dc02da, Offset: 0x203a
// Size: 0x50
function private on_player_death( params )
{
    if ( !self.var_c36cb8f36e9afca1 && params.inflictor.attacker_subclass )
    {
        self.var_c36cb8f36e9afca1 = params.inflictor.attacker_subclass;
    }
}

// Namespace zombie_hellhound
// Params 0, eflags: 0x4
// Checksum 0x9563b19e, Offset: 0x2092
// Size: 0x54
function private function_d7594a5edcf54e30()
{
    attacker = self.owner;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_4ce2be89357100be ) )
    {
        self.var_4ce2be89357100be = 0;
    }
    
    self.var_4ce2be89357100be++;
    attacker function_2f5f877a93fdf0d5( self.var_4ce2be89357100be );
}

// Namespace zombie_hellhound
// Params 1, eflags: 0x4
// Checksum 0xc9b523bb, Offset: 0x20ee
// Size: 0x5c
function private function_2f5f877a93fdf0d5( var_4ce2be89357100be )
{
    attacker = self;
    
    if ( isplayer( attacker ) && var_4ce2be89357100be == 5 )
    {
        points = rank::getscoreinfovalue( #"medal_muckfire" );
        
        if ( isdefined( points ) )
        {
            attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_muckfire" );
        }
    }
}

/#

    // Namespace zombie_hellhound
    // Params 0, eflags: 0x4
    // Checksum 0xa03e6ba4, Offset: 0x2152
    // Size: 0x2f, Type: dev
    function private setup_hellhound_devgui()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x54>", &function_774ff043bde4185e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_hellhound
    // Params 1, eflags: 0x4
    // Checksum 0xf9633b53, Offset: 0x2189
    // Size: 0x10d, Type: dev
    function private function_774ff043bde4185e( params )
    {
        player = level.players[ 0 ];
        ai_array = getaiarrayinradius( player.origin, 500 );
        
        foreach ( ai in ai_array )
        {
            if ( !isalive( ai ) || isdefined( ai.subclass ) && !issubstr( ai.subclass, "<dev string:x66>" ) )
            {
                continue;
            }
            
            if ( ai asmhasstate( ai.asmname, "<dev string:x77>" ) )
            {
                ai startliveragdoll();
                ai asm::function_7256f5ba459c840b( "<dev string:x77>" );
            }
        }
    }

#/
