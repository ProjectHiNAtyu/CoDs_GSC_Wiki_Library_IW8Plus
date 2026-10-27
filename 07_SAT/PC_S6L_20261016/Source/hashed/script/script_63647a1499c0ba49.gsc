// script_63647a1499c0ba49  (hash_63647a1499c0ba49.gscc) (size: 12055 Bytes / 0x2f17 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7a76412 (4154942482)
// size ...... 12055 (0x2f17)
// includes .. 10  (offset: 0x2bd3)
// strings ... 41  (offset: 0x2c23)
// dev strs .. 3   (offset: 0x2eef)
// exports ... 25  (offset: 0x1c6f)
// cseg ...... 0x334 + 0x193b (0x1c6f)
// imports ... 87  (offset: 0x2057)
// animtree1 . 0   (offset: 0x2f17)
// animtree2 . 0   (offset: 0x2f17)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_passive_spawn;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_f2cf5f122ca519c4;

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0x51e4de5d, Offset: 0x352
// Size: 0x6b
function function_d4599956e62b3c9a( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "disciple_force_evolution_beam_fx", settings.var_cdb0f23b0f89e407 );
        utility::add_fx( "disciple_weakpoint_hand_impact_fx", settings.var_93c6b96128e313b3 );
        utility::add_fx( "disciple_weakpoint_hand_fx", settings.var_dc690bf3c93745cd );
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0x2d9ea3d7, Offset: 0x3c5
// Size: 0x4f
function function_b1296c984f82ea69()
{
    if ( self getaiblackboarddynamic( "can_force_evolution" ) )
    {
        callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_4d469c26d93c15f2 );
        callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_bf731e5c7eae0684 );
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0x54a91f33, Offset: 0x41c
// Size: 0x10b
function function_bbf58926498fae95()
{
    self.var_1629dcb960803248 = [];
    
    if ( self getaiblackboarddynamic( "can_force_evolution" ) )
    {
        self function_786bb6aa1b76c7ee( "in_force_evolution", 0 );
        self function_786bb6aa1b76c7ee( "request_force_evolution", 0 );
        self.var_930cf4b998cc4969 = 0;
        self.force_evolution_cooldown = 0;
        self.var_c0c4ed0aff693bab = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bfd03828bccd983e;
        self.var_292b3ce87d7d232 = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f7ca6563aaca4510 ) );
        self.var_cf6313babcaf8d46 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e359a580ed8ed7a8;
        self.var_4fe3ba41cade6434 = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7fe6f0250cdbcd63 ) );
        init_special_cooldowns( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb );
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0x83fe2245, Offset: 0x52f
// Size: 0xb5
function init_special_cooldowns( settings )
{
    if ( !isdefined( self.var_dd6a08ac4ca2bb2e ) )
    {
        self.var_dd6a08ac4ca2bb2e = [];
    }
    
    foreach ( entry in settings.var_5374684049e51c59 )
    {
        self.var_dd6a08ac4ca2bb2e[ entry.var_96afce4056adb08b ] = entry.var_dacdf9590f8b08ce;
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 2
// Checksum 0xf294ab80, Offset: 0x5ec
// Size: 0x27, Type: bool
function function_2daa67da290fa701( index, target )
{
    if ( target.var_a744a5aa7cd23766 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0x9cb78381, Offset: 0x61c
// Size: 0x185
function function_b8c0ff578e3412()
{
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_756be0fd3192fc53 ) || gettime() > level.var_756be0fd3192fc53 )
    {
        if ( !isarray( level.var_297fd5d473fd6986 ) || level.var_297fd5d473fd6986.size <= 0 )
        {
            var_39cdf7a20f9242df = getaiarrayinradius( self.enemy.origin, self.var_cf6313babcaf8d46, self.team );
            var_39cdf7a20f9242df = function_46f9072493651dc9( var_39cdf7a20f9242df );
            var_39cdf7a20f9242df = arrayremove( var_39cdf7a20f9242df, self );
            var_39cdf7a20f9242df = utility::function_6ed29b1b786df49a( var_39cdf7a20f9242df, &function_2daa67da290fa701 );
            
            if ( var_39cdf7a20f9242df.size > 0 )
            {
                var_39cdf7a20f9242df = function_34985a52ad28ac98( var_39cdf7a20f9242df );
                level.var_756be0fd3192fc53 = gettime() + self.var_4fe3ba41cade6434;
            }
            
            level.var_fdd955b6aa4e3e8e = var_39cdf7a20f9242df;
        }
    }
    
    foreach ( candidate in level.var_fdd955b6aa4e3e8e )
    {
        if ( !candidate[ 1 ].var_a983686954b241f5 )
        {
            best_target = candidate;
        }
    }
    
    if ( !isdefined( best_target ) )
    {
        return;
    }
    
    return best_target[ 1 ];
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0x313475b6, Offset: 0x7aa
// Size: 0x106, Type: bool
function can_force_evolution()
{
    /#
        if ( getdvarint( @"hash_f7eadc246751461d", 0 ) )
        {
            return false;
        }
    #/
    
    if ( self._blackboard.var_ea5eb773cb969ee1 )
    {
        return false;
    }
    
    if ( isdefined( self.var_a45189ff1e34f63c ) && !self.var_a45189ff1e34f63c )
    {
        return false;
    }
    
    if ( !isdefined( self.var_91ad9fe5fbf8a649 ) )
    {
        return false;
    }
    
    if ( !isalive( self.var_91ad9fe5fbf8a649 ) )
    {
        return false;
    }
    
    if ( isdefined( self getaiblackboarddynamic( "force_evolution_cooldown" ) ) && self getaiblackboarddynamic( "force_evolution_cooldown" ) > gettime() )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "request_force_evolution" ) || self getaiblackboarddynamic( "in_force_evolution" ) )
    {
        return false;
    }
    
    if ( self.var_91ad9fe5fbf8a649.var_287ea4c2debf2264 > gettime() )
    {
        return false;
    }
    
    if ( !trace::ray_trace_passed( self getcentroid(), self.var_91ad9fe5fbf8a649 getcentroid(), undefined, trace::create_default_contents( 1 ) ) )
    {
        self.var_782ca4f832080896 = gettime() + 250;
        return false;
    }
    
    return true;
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0xaa438dd3, Offset: 0x8b9
// Size: 0x6d2
function zombie_disciple_force_evolution_loop()
{
    level endon( #"game_ended" );
    
    if ( !isalive( self.var_91ad9fe5fbf8a649 ) )
    {
        self.var_91ad9fe5fbf8a649 = undefined;
        self function_786bb6aa1b76c7ee( "in_force_evolution", 0 );
        return;
    }
    
    self notify( #"hash_bc5cf67a08651478" );
    target_ent = self.var_91ad9fe5fbf8a649;
    self.force_evolution_cooldown = function_d278eee6f7d49ea0( target_ent.subclass );
    var_8f645c02de95609 = function_c3400bc71d5c2524( target_ent.subclass );
    
    if ( !isdefined( var_8f645c02de95609 ) || !isdefined( self.force_evolution_cooldown ) )
    {
        if ( !isdefined( self.force_evolution_cooldown ) )
        {
            self.force_evolution_cooldown = 0;
        }
        
        self.var_91ad9fe5fbf8a649 = undefined;
        self function_786bb6aa1b76c7ee( "in_force_evolution", 0 );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "in_force_evolution", 1 );
    self function_786bb6aa1b76c7ee( "in_force_evolution_pain", 0 );
    self.var_930cf4b998cc4969 = 0;
    metabone::set_metabone_active( "hand", 1 );
    playfxontag( utility::getfx( "disciple_weakpoint_hand_fx" ), self, "tag_fx_hand_ri_palm" );
    self setscriptablepartstate( "drain_audio", "on" );
    target_ent zombie_stun::stun_ai( var_8f645c02de95609 * 0.001 + 1 );
    target_ent utility::ent_flag_set( "disciple_skoll_forcing" );
    
    if ( target_ent isscriptable() )
    {
        target_ent setscriptablepartstate( "force_evo_audio", "on", 0 );
    }
    
    self.var_c5c9b03d0d4a5389 = utility::spawn_model( "tag_origin", self gettagorigin( "tag_fx_hand_ri_palm" ) );
    self.var_c5c9b03d0d4a5389 linkto( self, "tag_fx_hand_ri_palm" );
    self.var_1ea224fdc9924a45 = playfxontagsbetweenclients( utility::getfx( "disciple_force_evolution_beam_fx" ), target_ent, "j_spine4", self.var_c5c9b03d0d4a5389, "tag_origin" );
    
    if ( isdefined( self.var_1ea224fdc9924a45 ) )
    {
        self.var_1ea224fdc9924a45 namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    }
    
    var_87534c89abc1c0a9 = var_8f645c02de95609 + gettime();
    trace_check_time = gettime() + 250;
    
    while ( isalive( self ) && isalive( target_ent ) && gettime() < var_87534c89abc1c0a9 )
    {
        if ( self getaiblackboarddynamic( "in_force_evolution" ) == 0 )
        {
            break;
        }
        
        if ( trace_check_time < gettime() )
        {
            trace_check_time = gettime() + 250;
            
            if ( !trace::ray_trace_passed( self getcentroid(), target_ent getcentroid(), undefined, trace::create_default_contents( 1 ) ) )
            {
                interruptedevolution = 1;
                break;
            }
        }
        
        if ( issubstr( target_ent.subclass, "zombie_ghoul" ) && utility::issharedfuncdefined( target_ent.subclass, #"hash_88bce97e9df03b00" ) && !target_ent utility::ent_flag( "ghoul_evolve_forced" ) && gettime() >= var_87534c89abc1c0a9 - utility::function_4b74c15943231980( 3 ) )
        {
            target_ent zombie_stun::function_d738299157923d28();
            target_ent.disciple_parent = self;
            host_data_params = spawnstruct();
            host_data_params.disciple_parent = self;
            host_data_params.var_b3e176999aae46d7 = &function_a0cbe641bc76022a;
            host_data_params.var_9ad7cc5d07653ebc = target_ent.var_9ad7cc5d07653ebc;
            target_ent utility::callsharedfunc( target_ent.subclass, #"hash_88bce97e9df03b00", "disciple_parent", host_data_params );
            target_ent utility::ent_flag_set( "ghoul_evolve_skip_anim" );
            target_ent utility::ent_flag_set( "ghoul_evolve_forced" );
        }
        
        waitframe();
    }
    
    if ( isalive( self ) )
    {
        if ( isdefined( self.var_c5c9b03d0d4a5389 ) )
        {
            self.var_c5c9b03d0d4a5389 delete();
            self.var_c5c9b03d0d4a5389 = undefined;
        }
        
        if ( isdefined( self.var_1ea224fdc9924a45 ) )
        {
            self.var_1ea224fdc9924a45 delete();
            self.var_1ea224fdc9924a45 = undefined;
        }
        
        self.var_930cf4b998cc4969 = 0;
        self function_786bb6aa1b76c7ee( "in_force_evolution", 0 );
        self.var_91ad9fe5fbf8a649 = undefined;
        
        if ( !interruptedevolution )
        {
            ai::set_blackboard_cooldown( "force_evolution_cooldown", self.force_evolution_cooldown );
        }
        else
        {
            ai::set_blackboard_cooldown( "force_evolution_cooldown", 1500 );
        }
        
        stopfxontag( utility::getfx( "disciple_weakpoint_hand_fx" ), self, "tag_fx_hand_ri_palm" );
        self setscriptablepartstate( "drain_audio", "stop" );
        self setscriptablepartstate( "sound_vo", "force_evo_success" );
        metabone::set_metabone_active( "hand", 0 );
    }
    
    if ( isalive( target_ent ) )
    {
        target_ent.var_a983686954b241f5 = undefined;
        target_ent setscriptablepartstate( "force_evo_audio", "off", 0 );
        target_ent zombie_stun::function_d738299157923d28();
        
        if ( isalive( self ) && !self._blackboard.var_49653a40eabfea73 && !interruptedevolution )
        {
            target_ent.disciple_parent = self;
            host_data_params = spawnstruct();
            host_data_params.disciple_parent = self;
            host_data_params.var_b3e176999aae46d7 = &function_a0cbe641bc76022a;
            
            if ( isdefined( self.var_7b40098f6851862a ) && arraycontains( self.var_7b40098f6851862a, target_ent ) )
            {
                host_data_params.var_9ad7cc5d07653ebc = 1;
            }
            
            if ( issubstr( target_ent.subclass, "zombie_parasite" ) )
            {
                if ( utility::issharedfuncdefined( target_ent.subclass, #"hash_88bce97e9df03b00" ) )
                {
                    target_ent utility::callsharedfunc( target_ent.subclass, #"hash_88bce97e9df03b00", "disciple_parent", host_data_params );
                    target_ent.force_evolve = 1;
                }
            }
            else if ( !issubstr( target_ent.subclass, "zombie_ghoul" ) && target_ent._blackboard.var_7ee6e625fa8c93d3 == 0 )
            {
                if ( target_ent._blackboard.var_a7ac06c0829177ee )
                {
                    target_ent zombie_emergence_spawning::function_80623a2279a4d888();
                }
                
                target_ent.var_d2bf06613fb462fa = 10;
                target_ent.var_a2382de1a0db3a3b = 15;
                target_ent.var_93ceea3a043c8451 = 3;
                target_ent zombie_emergence_spawning::register_emergence_spawning_host_data( "disciple_parent", host_data_params );
                target_ent thread function_2ab7c66a94ef4d3b();
            }
            else
            {
                target_ent zombie_emergence_spawning::register_emergence_spawning_host_data( "disciple_parent", host_data_params );
                target_ent zombie_emergence_spawning::force_emergence_spawning( 1 );
            }
            
            self.var_767be00663f05e7c = 1;
            return;
        }
        
        target_ent utility::ent_flag_clear( "disciple_skoll_forcing" );
        
        if ( issubstr( target_ent.subclass, "zombie_ghoul" ) )
        {
            target_ent notify( #"evolve_fail" );
            return;
        }
        
        if ( isdefined( target_ent.evolution ) && isdefined( target_ent.evolution.retry_delay ) && issubstr( target_ent.subclass, "zombie_parasite" ) )
        {
            target_ent.evolution.var_813abb7710d169e3 = gettime() + target_ent.evolution.retry_delay;
        }
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1, eflags: 0x4
// Checksum 0x3cc0e5a2, Offset: 0xf93
// Size: 0xa8
function private function_4d469c26d93c15f2( params )
{
    if ( self getaiblackboarddynamic( "in_force_evolution" ) && function_e0d51d7e32e0b873( params ) )
    {
        self.var_930cf4b998cc4969 += params.idamage;
        self.var_742f6b5735abcec3 = params.eattacker;
        playfxontag( utility::getfx( "disciple_weakpoint_hand_impact_fx" ), self, "tag_fx_hand_ri_palm" );
        
        if ( !self.var_e3ff6b5a34e23c16 && self.var_930cf4b998cc4969 > self.var_c0c4ed0aff693bab * self.maxhealth )
        {
            self function_786bb6aa1b76c7ee( "in_force_evolution_pain", 1 );
        }
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0x16093f7e, Offset: 0x1043
// Size: 0xc, Type: bool
function function_3914130f2e186410()
{
    return isdefined( self.var_91ad9fe5fbf8a649 );
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0x1980c3f, Offset: 0x1058
// Size: 0x1d, Type: bool
function function_e0d51d7e32e0b873( params )
{
    return params.metabonename == "hand";
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0xd34f4c69, Offset: 0x107e
// Size: 0x3a6
function function_34985a52ad28ac98( var_b6e07679b5385b9d )
{
    if ( !isdefined( var_b6e07679b5385b9d ) )
    {
        return;
    }
    
    if ( !isarray( var_b6e07679b5385b9d ) )
    {
        return;
    }
    
    var_f445f44c40db94b4 = [];
    
    foreach ( candidate in var_b6e07679b5385b9d )
    {
        if ( candidate == self )
        {
            continue;
        }
        
        if ( candidate.var_a983686954b241f5 )
        {
            continue;
        }
        
        if ( !issubstr( candidate.subclass, "zombie_vermin" ) && !issubstr( candidate.subclass, "zombie_parasite" ) && !issubstr( candidate.subclass, "zombie_ghoul" ) )
        {
            continue;
        }
        
        if ( issubstr( candidate.subclass, "_hvt" ) )
        {
            continue;
        }
        
        if ( candidate._blackboard.var_ea5eb773cb969ee1 )
        {
            continue;
        }
        
        if ( candidate.var_287ea4c2debf2264 > gettime() )
        {
            continue;
        }
        
        if ( candidate utility::ent_flag( "spawn_animating" ) )
        {
            continue;
        }
        
        if ( candidate.b_in_spawn_closet )
        {
            continue;
        }
        
        if ( candidate utility::ent_flag( "disciple_skoll_forcing" ) )
        {
            continue;
        }
        
        if ( candidate.var_c85fec368aa94f80 > gettime() )
        {
            continue;
        }
        
        if ( candidate.var_fadea7cb564eab83 > gettime() )
        {
            continue;
        }
        
        if ( isdefined( function_b80af5aa706e525a( candidate.subclass ) ) && self.var_bb237890238f94c5 < gettime() )
        {
            continue;
        }
        
        within_limits = function_cdc50697768f5b45( candidate );
        
        if ( isdefined( within_limits ) && !within_limits )
        {
            continue;
        }
        
        var_a5024d693d0008c6 = getdvarint( @"hash_bb40d24806f9d8b8", -1 );
        
        if ( var_a5024d693d0008c6 > -1 && issubstr( candidate.subclass, "zombie_vermin" ) && level.var_29cbaf753d01265a >= var_a5024d693d0008c6 )
        {
            continue;
        }
        
        self_bounds = self getboundshalfsize();
        candidate_bounds = candidate getboundshalfsize();
        var_813ada6cfab0c0bc = length( self_bounds );
        var_450970c14fff3bc3 = length( candidate_bounds );
        
        if ( distancesquared( candidate.origin, self.origin ) <= squared( var_813ada6cfab0c0bc + var_450970c14fff3bc3 + 15 ) )
        {
            continue;
        }
        
        if ( issubstr( candidate.subclass, "zombie_parasite" ) )
        {
            if ( isalive( self.evolution.host ) )
            {
                continue;
            }
            
            if ( candidate getaiblackboarddynamic( "can_evolve" ) != 1 )
            {
                continue;
            }
            
            if ( !utility::issharedfuncdefined( candidate.subclass, #"hash_6ace5c7a2f86f75" ) || !isdefined( candidate utility::callsharedfunc( candidate.subclass, #"hash_6ace5c7a2f86f75" ) ) )
            {
                continue;
            }
        }
        
        score = function_52ee3b783fb8599c( candidate.subclass );
        distsq = distancesquared( self.origin, candidate.origin );
        
        if ( distsq == 0 )
        {
            distsq = 1;
        }
        
        score += 1 / distsq;
        var_f445f44c40db94b4[ var_f445f44c40db94b4.size ] = [ score, candidate ];
    }
    
    return arraysort( var_f445f44c40db94b4, undefined, &function_c3c96ff06f82d9a6 );
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0xe34af142, Offset: 0x142d
// Size: 0x46
function function_cdc50697768f5b45( potential_host )
{
    if ( utility::issharedfuncdefined( potential_host.subclass, #"hash_41aeb3f5f201459" ) )
    {
        return potential_host utility::callsharedfunc( potential_host.subclass, #"hash_41aeb3f5f201459" );
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0xb0bd4265, Offset: 0x147b
// Size: 0x95
function function_dff4ebc6aa2b8e37( host )
{
    if ( host zombie_emergence_spawning::is_emergence_spawning_enabled() )
    {
        var_ebbd87c9405fdca2 = host function_f398d739dc0cd5c3();
        
        if ( isarray( var_ebbd87c9405fdca2 ) && var_ebbd87c9405fdca2.size > 0 )
        {
            return var_ebbd87c9405fdca2[ 0 ];
        }
    }
    
    if ( issubstr( host.subclass, "zombie_parasite" ) )
    {
        return self.evolution.result_type;
    }
    
    if ( issubstr( host.subclass, "zombie_ghoul" ) )
    {
        return self.evolution.next_subclass;
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 2
// Checksum 0xb101d724, Offset: 0x1518
// Size: 0x47, Type: bool
function function_c3c96ff06f82d9a6( var_23e831cf545ac9ba, var_23e830cf545ac787 )
{
    if ( !isdefined( var_23e831cf545ac9ba ) )
    {
        return false;
    }
    
    if ( !isdefined( var_23e830cf545ac787 ) )
    {
        return false;
    }
    
    var_425a5471db2fa287 = var_23e831cf545ac9ba[ 0 ];
    var_425a5571db2fa4ba = var_23e830cf545ac787[ 0 ];
    return var_425a5471db2fa287 > var_425a5571db2fa4ba;
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0x2a743ab, Offset: 0x1568
// Size: 0xd0
function function_c3400bc71d5c2524( subclass )
{
    foreach ( entry in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ed51c6228d701796 )
    {
        if ( issubstr( subclass, entry.var_3d8507b3905bbf10 ) )
        {
            return int( utility::function_4b74c15943231980( entry.var_9592ca7d5b04ed97 ) );
        }
    }
    
    assertmsg( "<dev string:x24>" + subclass + "<dev string:x57>" );
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0xc3f9315, Offset: 0x1640
// Size: 0xd0
function function_d278eee6f7d49ea0( subclass )
{
    foreach ( entry in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ed51c6228d701796 )
    {
        if ( issubstr( subclass, entry.var_3d8507b3905bbf10 ) )
        {
            return int( utility::function_4b74c15943231980( entry.var_ba70e8255866a141 ) );
        }
    }
    
    assertmsg( "<dev string:x24>" + subclass + "<dev string:xa8>" );
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0x68a286dc, Offset: 0x1718
// Size: 0xb2
function function_52ee3b783fb8599c( subclass )
{
    foreach ( entry in self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ed51c6228d701796 )
    {
        if ( !issubstr( subclass, entry.var_3d8507b3905bbf10 ) )
        {
            return entry.var_125eeca818e3d8a8;
        }
    }
    
    return 0;
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1
// Checksum 0x69eb9242, Offset: 0x17d3
// Size: 0xad
function function_b80af5aa706e525a( subclass )
{
    var_472f95fe21373fc4 = getarraykeys( self.var_dd6a08ac4ca2bb2e );
    
    foreach ( special_cooldown in var_472f95fe21373fc4 )
    {
        if ( issubstr( subclass, special_cooldown ) )
        {
            return int( utility::function_4b74c15943231980( self.var_dd6a08ac4ca2bb2e[ special_cooldown ] ) );
        }
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0
// Checksum 0x1e3e35f0, Offset: 0x1889
// Size: 0x30
function function_1f91b659661972d5()
{
    if ( isalive( self.var_91ad9fe5fbf8a649 ) )
    {
        self orientmode( "face point", self.var_91ad9fe5fbf8a649.origin );
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 0, eflags: 0x4
// Checksum 0xc19aef4e, Offset: 0x18c1
// Size: 0xda
function private function_2ab7c66a94ef4d3b()
{
    self endon( #"death" );
    self endon( #"evolution_interrupted" );
    utility::function_32b24db3127bff40( "transform", "transform_tell" );
    
    if ( utility::function_9f2c41c1dcc8c94( "injected", "injected_on" ) )
    {
        utility::function_7c10ea82c1e305b8( "injected", "injected_off" );
        utility::function_32b24db3127bff40( "eyes", "injected_on" );
    }
    
    wait self.var_93ceea3a043c8451;
    zombie_emergence_spawning::enable_emergence_spawning( 1 );
    zombie_emergence_spawning::force_emergence_spawning( 1 );
    self._blackboard.var_5f2c4e295aea3c41 = 1;
    
    if ( self._blackboard.var_397bfb4ed7256a7a )
    {
        self._blackboard.var_89af3e0b1e21175 = 1;
    }
    
    self.var_a13bed1ac47e1b2c = 1;
    self.noragdoll = 1;
    self kill();
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1, eflags: 0x4
// Checksum 0xc3f53b28, Offset: 0x19a3
// Size: 0xca
function private function_bf731e5c7eae0684( params )
{
    if ( isent( self.var_c5c9b03d0d4a5389 ) )
    {
        self.var_c5c9b03d0d4a5389 delete();
        self.var_c5c9b03d0d4a5389 = undefined;
    }
    
    if ( isent( self.var_1ea224fdc9924a45 ) )
    {
        self.var_1ea224fdc9924a45 delete();
        self.var_1ea224fdc9924a45 = undefined;
    }
    
    stopfxontag( utility::getfx( "disciple_weakpoint_hand_fx" ), self, "tag_fx_hand_ri_palm" );
    self setscriptablepartstate( "drain_audio", "stop" );
    
    if ( isalive( self.var_91ad9fe5fbf8a649 ) )
    {
        self.var_91ad9fe5fbf8a649 zombie_stun::function_d738299157923d28();
        self.var_91ad9fe5fbf8a649 utility::ent_flag_clear( "disciple_skoll_forcing" );
        self.var_91ad9fe5fbf8a649.var_a983686954b241f5 = undefined;
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 1, eflags: 0x4
// Checksum 0xf27251d5, Offset: 0x1a75
// Size: 0xa8
function private function_780ec1fdaeda90d3( params )
{
    if ( isalive( self.disciple_parent ) && isarray( self.disciple_parent.var_1629dcb960803248 ) )
    {
        special_cooldown = self.disciple_parent function_b80af5aa706e525a( self.subclass );
        
        if ( isdefined( special_cooldown ) )
        {
            self.disciple_parent.var_bb237890238f94c5 = gettime() + special_cooldown;
        }
        
        self.disciple_parent.var_1629dcb960803248 = arrayremove( self.disciple_parent.var_1629dcb960803248, self );
    }
}

// Namespace namespace_f2cf5f122ca519c4
// Params 2
// Checksum 0x1339af22, Offset: 0x1b25
// Size: 0x14a
function function_a0cbe641bc76022a( disciple_parent, var_9ad7cc5d07653ebc )
{
    assert( isdefined( disciple_parent ) );
    disciple_parent endon( #"death" );
    
    if ( isalive( disciple_parent ) )
    {
        self.disciple_parent = disciple_parent;
        
        if ( isarray( disciple_parent.var_1629dcb960803248 ) )
        {
            disciple_parent.var_1629dcb960803248[ disciple_parent.var_1629dcb960803248.size ] = self;
            callback::add( "on_zombie_ai_killed", &function_780ec1fdaeda90d3 );
            utility::function_32b24db3127bff40( "injected", "injected_on" );
            
            if ( issubstr( self.subclass, "zombie_vermin" ) )
            {
                utility::function_32b24db3127bff40( "eyes", "injected_on" );
            }
            
            if ( self.aicategory != "special" && self.aicategory != "elite" && self.aicategory != "hvt" )
            {
                self.var_5d3022108c155ed4 = #"hash_b5393e6bcc451e49";
            }
            
            if ( var_9ad7cc5d07653ebc )
            {
                self.disciple_parent.var_7b40098f6851862a[ self.disciple_parent.var_7b40098f6851862a.size ] = self;
                self.var_9ad7cc5d07653ebc = 1;
                callback::add( "on_zombie_ai_killed", &zombie_disciple_passive_spawn::function_ee0d10cbd1ffeb7b );
            }
        }
    }
}

