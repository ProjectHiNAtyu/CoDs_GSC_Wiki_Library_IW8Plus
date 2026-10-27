// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple.gsc  (hash_3a48907e3dc17c58.gscc) (size: 26298 Bytes / 0x66ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe860c32 (243665970)
// size ...... 26298 (0x66ba)
// includes .. 16  (offset: 0x5fee)
// strings ... 83  (offset: 0x606e)
// dev strs .. 29  (offset: 0x655a)
// exports ... 75  (offset: 0x3c46)
// cseg ...... 0x5df + 0x3667 (0x3c46)
// imports ... 186 (offset: 0x47fe)
// animtree1 . 0   (offset: 0x66ba)
// animtree2 . 0   (offset: 0x66ba)
#using script_16ea1b94f0f381b3;
#using script_3e4f26df9dc4b465;
#using script_4d5690421d14cda9;
#using script_4fa22bc28608e9bd;
#using script_ac32c5a74321662;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_medal;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\status_effects\status_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_disciple;

// Namespace zombie_disciple
// Params 2
// Checksum 0x8c1a595e, Offset: 0x5fd
// Size: 0x58
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "disciple_weakpoint_impact_fx", settings.var_62a5f91fb98db922 );
    }
    
    namespace_5b988172ec655354::function_6a5cc184e886746a( aitypescriptbundle );
    namespace_d4e7a14ee55bd048::function_a13ce4b7ef033fc6( aitypescriptbundle );
}

// Namespace zombie_disciple
// Params 1
// Checksum 0xb9e3cc26, Offset: 0x65d
// Size: 0x1fd
function function_2e2ba6d7368de45b( params )
{
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_194299ff7ad3ffc4 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_4381868971a4c9e6 );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_7ff4e22ba92319a8 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    zombie_disciple_medal::function_1608872af183cf53();
    
    /#
        init_disciple_devgui();
    #/
}

// Namespace zombie_disciple
// Params 1
// Checksum 0xcee659f9, Offset: 0x862
// Size: 0x3a9
function function_93a92cb56526c031( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_2e2ba6d7368de45b );
    callback::add( "on_zombie_init_restore_metabones", &restore_metabones );
    self function_786bb6aa1b76c7ee( "can_bind_zombies", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8f971c2cfc3d7b4e );
    self function_786bb6aa1b76c7ee( "can_life_drain", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.canlifedrain );
    self function_786bb6aa1b76c7ee( "can_summon_zombies", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_97af70adf549f5a );
    self function_786bb6aa1b76c7ee( "can_passive_spawn", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6389eb9c1c8d6d9c );
    self function_786bb6aa1b76c7ee( "can_force_evolution", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9c44dd7991a409dc );
    self function_786bb6aa1b76c7ee( "can_scream_attack", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_229834f229a6739d );
    self function_786bb6aa1b76c7ee( "can_inject_zombies", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_54b10e3691607ad4 );
    self.var_9ede79ad4bac218b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4865f09cf56e2f99 * 0.01;
    self.health_state_models = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthstatemodels;
    self.var_23d1907a9b2062ca = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.sweepmovespeed;
    self.sweep_start_dist_sq = squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5c5adb3252f5ea19 );
    self.var_385a11d661a7ce23 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4ecaa284108dacd1;
    self.sweep_cooldown_ms = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.sweepcooldown * 1000;
    self.sweep_cooldown_time = 0;
    assert( isdefined( self.health_state_models ) && self.health_state_models.size, "<dev string:x24>" );
    self.var_6fcb51fd383c5fa = 1;
    self.var_b58461ff1ccb968d = 10;
    self.var_cdf48282bb6d1237 = 100;
    self.allowstrafe = 0;
    self.disable_brain_rot = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.disablebrainrot;
    register_movement_state( 0, &function_a66c3be32304d36d, &function_812c36941b0c4014, undefined );
    register_movement_state( 1, &function_ed4b8d3b5d36f6e8, &function_453b74db5b1a10e7, &function_6ac85a4a2f2b1666 );
    register_movement_state( 2, &function_4ab1d129b91eefd0, &function_b6864e9f7d11ffaf, &function_ad7fa00be39a87ee );
    register_movement_state( 3, &function_158ea20ae17199fe, &function_b9e8a4c86bbdd5f9, &function_fc83329a27415c28 );
    register_movement_state( 4, &function_b74506e55b501d07, &function_e965e34491c9e2b2, &function_f032644700cacde3 );
    register_movement_state( 5, &function_f6e7ca32ebace573, &function_7a6a7c270fab7316, &function_d12facee5ddd8087 );
    thread spawn_fade_in();
    thread initscriptable();
    createnavrepulsor( "disciple_command_spot_repulsor", -1, self, undefined, 1, undefined );
    return anim.success;
}

// Namespace zombie_disciple
// Params 0, eflags: 0x4
// Checksum 0xdbda1ae3, Offset: 0xc14
// Size: 0x66
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_32b24db3127bff40( "base", "base_on" );
    utility::function_32b24db3127bff40( "head", "normal" );
    function_a31c2bb4406e9121();
    prepare_spawn_reveal();
    thread spawn_reveal();
}

// Namespace zombie_disciple
// Params 0, eflags: 0x4
// Checksum 0x11088471, Offset: 0xc82
// Size: 0x13
function private prepare_spawn_reveal()
{
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x835b2bd3, Offset: 0xc9d
// Size: 0x89
function private spawn_reveal( b_teleport_reveal )
{
    self endon( #"death" );
    self clearpath();
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    
    if ( b_teleport_reveal )
    {
        waitframe();
    }
    
    if ( !self.disable_spawn_vfx )
    {
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal" );
    }
    else
    {
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
    }
    
    wait 2;
    self function_f2df0257c63f229( "in_spawn_reveal" );
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x8252bb35, Offset: 0xd2e
// Size: 0x3c
function private restore_metabones( params )
{
    metabone::restore_metabones( params.saved_metabones );
    function_3a0a310247b377d( self.health );
    function_86f9cf14a6a9cdae();
    function_a31c2bb4406e9121();
}

// Namespace zombie_disciple
// Params 0, eflags: 0x4
// Checksum 0xb0480aa0, Offset: 0xd72
// Size: 0x58
function private spawn_fade_in()
{
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "spawning", 1 );
    val::set( "spawn_fade_in", "damage", 0 );
    wait 1.5;
    self function_786bb6aa1b76c7ee( "spawning", 0 );
    val::reset_all( "spawn_fade_in" );
    thread handle_movement_state( get_default_movement_state() );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x3b9311fb, Offset: 0xdd2
// Size: 0x7b
function private play_death_fx( params )
{
    destroynavrepulsor( self );
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        body endon( #"corpse_deleted" );
        body utility::function_32b24db3127bff40( "death_reveal", "death_reveal" );
        
        if ( isdefined( self ) && body != self )
        {
            body.origin = self.origin;
        }
        
        wait 2.5;
        body delete();
    }
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x79629dd, Offset: 0xe55
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x90078e6d, Offset: 0xe7a
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x6028ad41, Offset: 0xe9f
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x5d68cf41, Offset: 0xec4
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x9b5a7e82, Offset: 0xef5
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x27f52129, Offset: 0xf1a
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0xd6322278, Offset: 0xf4b
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0xc5c40976, Offset: 0xf92
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x2fe482c3, Offset: 0xfd9
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x490d2f63, Offset: 0xffe
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0x56da85a5, Offset: 0x1023
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0xc326f37e, Offset: 0x1048
// Size: 0x81
function private function_4381868971a4c9e6( params )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    function_a31c2bb4406e9121();
    
    if ( utility::function_9f2c41c1dcc8c94( "head", "destroyed" ) )
    {
        utility::function_7c10ea82c1e305b8( "head", "destroyed_turned" );
    }
    
    if ( utility::function_9f2c41c1dcc8c94( "head", "mask_off" ) )
    {
        utility::function_7c10ea82c1e305b8( "head", "mask_off_turned" );
    }
    
    self.var_cab75db7e9e5b64c = undefined;
    self.var_86fae3f99538b683 = 1;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0x8a2ad7b8, Offset: 0x10d1
// Size: 0x6c
function function_7ff4e22ba92319a8( params )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
    function_a31c2bb4406e9121();
    
    if ( utility::function_9f2c41c1dcc8c94( "head", "destroyed_turned" ) )
    {
        utility::function_7c10ea82c1e305b8( "head", "destroyed" );
    }
    
    if ( utility::function_9f2c41c1dcc8c94( "head", "mask_off_turned" ) )
    {
        utility::function_7c10ea82c1e305b8( "head", "mask_off" );
    }
}

// Namespace zombie_disciple
// Params 1, eflags: 0x4
// Checksum 0xd8e1fc35, Offset: 0x1145
// Size: 0x93
function private function_194299ff7ad3ffc4( params )
{
    self.var_493dad358ba8e342 = gettime();
    
    if ( params.metabonename == "head" )
    {
        playfxontag( utility::getfx( "disciple_weakpoint_impact_fx" ), self, "tag_fx_head_weakspot" );
    }
    
    if ( !self._blackboard.var_ea5eb773cb969ee1 && function_3a0a310247b377d( self.health - params.idamage ) )
    {
        if ( !self.var_e3ff6b5a34e23c16 )
        {
            self function_786bb6aa1b76c7ee( "in_health_state_pain", 1 );
        }
    }
}

// Namespace zombie_disciple
// Params 2
// Checksum 0xb0e6de02, Offset: 0x11e0
// Size: 0xcb
function function_6f44feb4aad1265b( taskid, params )
{
    if ( self.b_in_spawn_closet )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return anim.failure;
    }
    
    if ( self.force_scream_attack )
    {
        return anim.failure;
    }
    
    if ( self._blackboard.var_d4512652c6056e7e != 1 && self._blackboard.var_d4512652c6056e7e != 3 )
    {
        return anim.failure;
    }
    
    if ( self.var_e598aad55093504a )
    {
        return anim.failure;
    }
    
    return namespace_d4e7a14ee55bd048::can_bind_zombies() ? anim.success : anim.failure;
}

// Namespace zombie_disciple
// Params 2
// Checksum 0xc109ae72, Offset: 0x12b4
// Size: 0x63
function function_b884d7f469e68f47( taskid, params )
{
    if ( self.force_scream_attack )
    {
        return anim.failure;
    }
    
    return self._blackboard.var_d4512652c6056e7e == 3 && namespace_6825c954c0756ce0::can_summon_zombies() ? anim.success : anim.failure;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xffd0c28c, Offset: 0x1320
// Size: 0x1ac
function function_a464035fcdb36b36()
{
    if ( self.force_scream_attack )
    {
        return;
    }
    
    target_ent = self.enemy;
    
    if ( self.var_755291e9e5c5f134 )
    {
        nearby_ai = getaiarrayinradius( self.origin, self.lifedrain_max_dist, self.team );
        temp_target_ent = undefined;
        
        if ( nearby_ai.size > 0 )
        {
            foreach ( zombie in nearby_ai )
            {
                if ( isdefined( zombie.aicategory ) )
                {
                    if ( zombie.aicategory == "special" || zombie.aicategory == "elite" || zombie.aicategory == "hvt" || zombie.aicategory == "boss" )
                    {
                        continue;
                    }
                }
                
                if ( zombie.var_d899cefe6090a8b2 < gettime() )
                {
                    continue;
                }
                
                temp_target_ent = zombie;
                break;
            }
        }
        
        if ( isdefined( temp_target_ent ) )
        {
            dist_sq_enemy = distancesquared( target_ent.origin, self.origin );
            dist_sq_zombie = distancesquared( temp_target_ent.origin, self.origin );
            
            if ( dist_sq_zombie < dist_sq_enemy )
            {
                target_ent = temp_target_ent;
            }
        }
    }
    
    return target_ent;
}

// Namespace zombie_disciple
// Params 2
// Checksum 0xaec31af8, Offset: 0x14d5
// Size: 0x14b
function function_74d28787b898fe64( taskid, params )
{
    if ( self.b_in_spawn_closet )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return anim.failure;
    }
    
    if ( self.force_scream_attack )
    {
        return anim.failure;
    }
    
    target_ent = function_a464035fcdb36b36();
    
    if ( utility::ent_flag( "playing_life_drain_anim" ) )
    {
        return anim.failure;
    }
    
    if ( self.var_cb717f4cdfadb860 && self.var_b03794d45a7439ec && self.var_9361df999d755b2a )
    {
        return anim.failure;
    }
    
    if ( !isalive( target_ent ) || target_ent.var_82684d0bd77016cc )
    {
        return anim.failure;
    }
    
    if ( !trace::ray_trace_passed( self getcentroid(), self.enemy getcentroid(), undefined, trace::create_default_contents( 1 ) ) )
    {
        return anim.failure;
    }
    
    if ( target_ent.var_d899cefe6090a8b2 > gettime() )
    {
        return anim.failure;
    }
    
    target_ent.var_d899cefe6090a8b2 = gettime() + 3000;
    self.lifedrain_target_ent = target_ent;
    return anim.success;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0x5293dc4c, Offset: 0x1629
// Size: 0x34
function function_13b9c2ec5ae3c0ab( entity )
{
    return ( entity.health_state_models.size + 1 - entity.var_6fcb51fd383c5fa ) / entity.health_state_models.size;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0xdbb8ee12, Offset: 0x1666
// Size: 0x64
function get_disciple_health_state( var_f93a08c86c2cd513 = self.health )
{
    var_f93a08c86c2cd513 = max( var_f93a08c86c2cd513, 1 );
    var_f93a08c86c2cd513 = min( var_f93a08c86c2cd513, self.maxhealth );
    return int( self.health_state_models.size + 1 - ceil( var_f93a08c86c2cd513 * self.health_state_models.size / self.maxhealth ) );
}

// Namespace zombie_disciple
// Params 1
// Checksum 0x3fd8f202, Offset: 0x16d3
// Size: 0xa4, Type: bool
function function_3a0a310247b377d( new_health )
{
    new_health_state = get_disciple_health_state( new_health );
    
    if ( isarray( self.health_state_models ) && self.health_state_models.size > 0 )
    {
        if ( self.var_6fcb51fd383c5fa != new_health_state && new_health_state > 0 && new_health_state <= self.health_state_models.size )
        {
            self setmodel( self.health_state_models[ new_health_state - 1 ].modelname );
            self.var_6fcb51fd383c5fa = new_health_state;
            function_86f9cf14a6a9cdae();
            function_a31c2bb4406e9121();
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xbd11deef, Offset: 0x1780
// Size: 0x53
function function_86f9cf14a6a9cdae()
{
    if ( metabone::get_metabone_state_name( "head" ) != "destroyed" && self.var_6fcb51fd383c5fa > 1 )
    {
        utility::function_32b24db3127bff40( "head", "mask_off" + ( status_effects::has_status_effect_type( "charm" ) ? "_turned" : "" ) );
    }
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xd825f0d, Offset: 0x17db
// Size: 0x54
function function_a31c2bb4406e9121()
{
    utility::function_32b24db3127bff40( "torso", "torso_" + self.var_6fcb51fd383c5fa + ( status_effects::has_status_effect_type( "charm" ) ? "_turned" : "" ) );
    
    if ( self.var_6fcb51fd383c5fa > 1 )
    {
        self notify( #"hash_929016c302152e7f" );
    }
}

// Namespace zombie_disciple
// Params 1
// Checksum 0xc012837d, Offset: 0x1837
// Size: 0x6a, Type: bool
function function_7e89c2b6e30b1cf3( pos )
{
    if ( self._blackboard.var_6a8c50efac75caa1 > 0 )
    {
        var_464855befbe198ec = distance2dsquared( self._blackboard.var_b213ded5043dfa2b, pos );
        
        if ( var_464855befbe198ec > squared( self._blackboard.var_6a8c50efac75caa1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_disciple
// Params 4
// Checksum 0xd18efd6c, Offset: 0x18aa
// Size: 0xc7
function register_movement_state( state_index, var_a6ffc258f919531b, var_4fe69312caae5c9a, var_65cdff0faaf15c6d )
{
    if ( !isdefined( self.movement_state_list ) )
    {
        self.movement_state_list = [];
    }
    
    assert( !isdefined( self.movement_state_list[ state_index ] ), "<dev string:x51>" + state_index + "<dev string:x5c>" );
    assert( isdefined( var_4fe69312caae5c9a ), "<dev string:x72>" );
    state = spawnstruct();
    state.state_index = state_index;
    state.var_a6ffc258f919531b = var_a6ffc258f919531b;
    state.var_4fe69312caae5c9a = var_4fe69312caae5c9a;
    state.var_65cdff0faaf15c6d = var_65cdff0faaf15c6d;
    self.movement_state_list[ state_index ] = state;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0x9e3ecd93, Offset: 0x1979
// Size: 0x1ff
function handle_movement_state( init_state )
{
    self endon( #"death" );
    assert( isarray( self.movement_state_list ) && self.movement_state_list.size > 0, "<dev string:x98>" );
    
    if ( !isdefined( init_state ) )
    {
        init_state = utility::array_random( self.movement_state_list ).state_index;
    }
    
    assert( isdefined( self.movement_state_list[ init_state ] ), "<dev string:x51>" + init_state + "<dev string:xcf>" );
    self._blackboard.var_d4512652c6056e7e = init_state;
    current_state = self.movement_state_list[ init_state ];
    
    if ( isdefined( current_state.var_a6ffc258f919531b ) )
    {
        self [[ current_state.var_a6ffc258f919531b ]]();
    }
    
    while ( true )
    {
        waitframe();
        var_79f7d8e8159eba95 = self [[ current_state.var_4fe69312caae5c9a ]]();
        
        /#
            debug_next_state = getdvarint( @"scr_disciple_movement_state", -1 );
            
            if ( isdefined( self.movement_state_list[ debug_next_state ] ) )
            {
                var_79f7d8e8159eba95 = debug_next_state;
            }
            
            function_709eab2489f477ad( "<dev string:xe8>" + self._blackboard.var_d4512652c6056e7e );
        #/
        
        if ( isdefined( var_79f7d8e8159eba95 ) && var_79f7d8e8159eba95 != self._blackboard.var_d4512652c6056e7e )
        {
            if ( isdefined( current_state.var_65cdff0faaf15c6d ) )
            {
                self [[ current_state.var_65cdff0faaf15c6d ]]();
            }
            
            assert( isdefined( self.movement_state_list[ var_79f7d8e8159eba95 ] ), "<dev string:xf9>" + self._blackboard.var_d4512652c6056e7e + "<dev string:x10c>" + var_79f7d8e8159eba95 + "<dev string:x125>" );
            self._blackboard.var_d4512652c6056e7e = var_79f7d8e8159eba95;
            current_state = self.movement_state_list[ var_79f7d8e8159eba95 ];
            
            if ( isdefined( current_state.var_a6ffc258f919531b ) )
            {
                self [[ current_state.var_a6ffc258f919531b ]]();
            }
        }
    }
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x458d8928, Offset: 0x1b80
// Size: 0x57
function get_default_movement_state()
{
    if ( self.b_in_spawn_closet )
    {
        return 0;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return 0;
    }
    
    if ( self.var_845a0792dc9e9059 == "defensive" )
    {
        if ( getdvarint( @"hash_bc392c231114be3e", 0 ) )
        {
            return 6;
        }
        
        if ( function_ae8129851e53d2ef() )
        {
            return 2;
        }
        
        return 3;
    }
    
    return 0;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xaaba673f, Offset: 0x1be0
// Size: 0x2
function function_a66c3be32304d36d()
{
    
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xad39b7c3, Offset: 0x1bea
// Size: 0xea
function function_812c36941b0c4014()
{
    namespace_7143065cf1b062e3::clear_float_move();
    
    if ( self.var_845a0792dc9e9059 == "defensive" )
    {
        return get_default_movement_state();
    }
    
    var_59d2648db909ddd2 = namespace_d4e7a14ee55bd048::function_766769d2750f286f();
    
    if ( isdefined( var_59d2648db909ddd2 ) )
    {
        self.var_59d2648db909ddd2 = var_59d2648db909ddd2;
        return 1;
    }
    
    if ( isdefined( self.var_91ad9fe5fbf8a649 ) )
    {
        return 7;
    }
    
    if ( function_ae8129851e53d2ef() )
    {
        return 2;
    }
    
    if ( self.var_845a0792dc9e9059 != "defensive" && function_384296a688cfa34a( self.enemy, self.sweep_start_dist_sq ) )
    {
        return 5;
    }
    
    if ( function_55924d325abaf8c5() )
    {
        return 4;
    }
    
    if ( function_51cf408567acb12a( self.enemy, self.sweep_start_dist_sq ) )
    {
        return 5;
    }
    
    if ( self.var_845a0792dc9e9059 == "defensive" )
    {
        return get_default_movement_state();
    }
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xba8e0c34, Offset: 0x1cdc
// Size: 0x2
function function_e2d47c1375beab25()
{
    
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x27fe4c17, Offset: 0x1ce6
// Size: 0x13
function function_ed4b8d3b5d36f6e8()
{
    self function_f2fdf8ef124744e8( 2, self.var_59d2648db909ddd2 );
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xbaf05932, Offset: 0x1d01
// Size: 0x7d
function function_453b74db5b1a10e7()
{
    namespace_7143065cf1b062e3::clear_float_move();
    
    if ( !isalive( self.var_59d2648db909ddd2 ) || self.var_59d2648db909ddd2 utility::ent_flag( "disciple_bound" ) || function_7e89c2b6e30b1cf3( self.var_59d2648db909ddd2.origin ) )
    {
        return get_default_movement_state();
    }
    
    if ( function_384296a688cfa34a( self.var_59d2648db909ddd2, self.sweep_start_dist_sq * 0.25 ) )
    {
        return 5;
    }
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xd1c383c9, Offset: 0x1d86
// Size: 0x14
function function_6ac85a4a2f2b1666()
{
    self clearbtgoal( 2 );
    self.var_59d2648db909ddd2 = undefined;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x5444b22d, Offset: 0x1da2
// Size: 0x34
function function_4ab1d129b91eefd0()
{
    self setbtgoalpos( 2, self.var_98b8abf242c21fd8 );
    self clearpath();
    self.allowstrafe = 1;
    namespace_7143065cf1b062e3::function_dce35a336383305c( self.var_98b8abf242c21fd8 );
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x769d9753, Offset: 0x1dde
// Size: 0x73
function function_b6864e9f7d11ffaf()
{
    if ( !isdefined( self.var_98b8abf242c21fd8 ) )
    {
        return 0;
    }
    
    if ( distancesquared( self.origin, self.var_98b8abf242c21fd8 ) < 225 || !self getaiblackboarddynamic( "in_float_move" ) )
    {
        return 3;
    }
    else if ( !isalive( self.enemy ) )
    {
        return get_default_movement_state();
    }
    
    /#
        function_709eab2489f477ad( "<dev string:x144>", self.var_98b8abf242c21fd8 );
    #/
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x5f58c254, Offset: 0x1e59
// Size: 0x1b
function function_ad7fa00be39a87ee()
{
    self.allowstrafe = 0;
    self clearbtgoal( 2 );
    namespace_7143065cf1b062e3::clear_float_move();
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x31aa933f, Offset: 0x1e7c
// Size: 0xc8
function function_158ea20ae17199fe()
{
    if ( !isdefined( level.var_2102b1f59a32b7c6 ) )
    {
        level.var_2102b1f59a32b7c6 = [];
    }
    
    level.var_2102b1f59a32b7c6[ level.var_2102b1f59a32b7c6.size ] = self;
    var_3fe63ede76f5253e = spawnstruct();
    var_3fe63ede76f5253e.var_bcf1fe2485e54b1d = gettime() + 2000;
    var_3fe63ede76f5253e.var_f93193ccd432db68 = gettime() + 5000;
    var_3fe63ede76f5253e.var_3f49f8704c269353 = 0;
    self.var_a93b699a11eb2daf = var_3fe63ede76f5253e;
    round_number = zombie_utils::get_zombie_round_difficulty();
    max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( self.subclass, round_number );
    self.var_bf3d6811fc2ab123 = self.health - max_health * self.var_9ede79ad4bac218b;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x29b3bcb3, Offset: 0x1f4c
// Size: 0x23b
function function_b9e8a4c86bbdd5f9()
{
    if ( function_c2a441211d58c3b4() )
    {
        if ( function_ae8129851e53d2ef() )
        {
            return 2;
        }
        else if ( self.var_845a0792dc9e9059 == "defensive" )
        {
            if ( isalive( self.enemy ) && isarray( level.var_c91c1b49d1cc4430 ) && level.var_c91c1b49d1cc4430.size > 0 )
            {
                var_76e311f8ad01c4c = function_47c86977a18df38b( level.var_c91c1b49d1cc4430, self.enemy.origin, 200 );
                
                if ( isdefined( var_76e311f8ad01c4c ) )
                {
                    var_a6eb2cec013fdbef = var_76e311f8ad01c4c.spots;
                }
                
                foreach ( var_f2d9376971a2eae in level.var_2102b1f59a32b7c6 )
                {
                    if ( !isalive( var_f2d9376971a2eae ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( var_f2d9376971a2eae.var_98b8abf242c21fd8 ) )
                    {
                        continue;
                    }
                    
                    var_a6eb2cec013fdbef = utility::get_array_of_closest( var_f2d9376971a2eae.var_98b8abf242c21fd8, var_a6eb2cec013fdbef, undefined, undefined, undefined, 200, 1 );
                }
                
                if ( isarray( var_a6eb2cec013fdbef ) && var_a6eb2cec013fdbef.size > 0 )
                {
                    foreach ( spot in var_a6eb2cec013fdbef )
                    {
                        if ( isdefined( self.var_98b8abf242c21fd8 ) && distancesquared( spot.origin, self.var_98b8abf242c21fd8 ) < 300 )
                        {
                            continue;
                        }
                        
                        hit_nothing = !navtrace( self.origin, spot.origin, self );
                        
                        if ( hit_nothing )
                        {
                            self.var_98b8abf242c21fd8 = spot.origin;
                            return 2;
                        }
                    }
                }
            }
        }
        
        return 0;
    }
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x9bb0d1a2, Offset: 0x218f
// Size: 0x2d
function function_fc83329a27415c28()
{
    level.var_2102b1f59a32b7c6 = arrayremove( level.var_2102b1f59a32b7c6, self );
    self.var_a93b699a11eb2daf = undefined;
    self.var_bf3d6811fc2ab123 = undefined;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xe4b9a363, Offset: 0x21c4
// Size: 0xd
function function_b74506e55b501d07()
{
    self.allowstrafe = 1;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x620db75b, Offset: 0x21d9
// Size: 0x56
function function_e965e34491c9e2b2()
{
    var_59d2648db909ddd2 = namespace_d4e7a14ee55bd048::function_766769d2750f286f();
    
    if ( isdefined( var_59d2648db909ddd2 ) )
    {
        self.var_59d2648db909ddd2 = var_59d2648db909ddd2;
        return 1;
    }
    else if ( isdefined( self.var_91ad9fe5fbf8a649 ) )
    {
        return 7;
    }
    else if ( !function_55924d325abaf8c5() )
    {
        return get_default_movement_state();
    }
    
    function_eead908427add3fd();
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xffe5ba81, Offset: 0x2237
// Size: 0x16
function function_f032644700cacde3()
{
    self.allowstrafe = 0;
    self.var_17c94bd4556610bb = undefined;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xde53f056, Offset: 0x2255
// Size: 0x37
function function_f6e7ca32ebace573()
{
    self clearpath();
    self clearbtgoal( 0 );
    namespace_7143065cf1b062e3::function_dce35a336383305c( self.var_f42f9d84927082af, self.var_23d1907a9b2062ca );
    self playsound( #"hash_6cd9eaa6fd901d4a" );
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xaaeba1c4, Offset: 0x2294
// Size: 0x122
function function_7a6a7c270fab7316()
{
    dist_sq = distancesquared( self.origin, self.var_f42f9d84927082af );
    
    if ( dist_sq < 2025 || dist_sq > 4000000 || !self getaiblackboarddynamic( "in_float_move" ) )
    {
        return get_default_movement_state();
    }
    
    if ( isdefined( self.var_52a95b5ab94e7af2 ) && distancesquared( self.var_52a95b5ab94e7af2.origin, self.var_f42f9d84927082af ) > squared( 384 ) )
    {
        var_f42f9d84927082af = function_74ba0a37b7c2e035( self.var_52a95b5ab94e7af2 );
        
        if ( isdefined( var_f42f9d84927082af ) )
        {
            self.var_f42f9d84927082af = var_f42f9d84927082af;
            namespace_7143065cf1b062e3::function_66c462b9c6c443c0( self.var_f42f9d84927082af );
        }
    }
    
    if ( isdefined( self.var_449e521c47cbd09f ) && utility::time_has_passed( self.var_449e521c47cbd09f, 1 ) )
    {
        return get_default_movement_state();
    }
    
    self animmode( "noclip" );
    self orientmode( "face point", self.var_f42f9d84927082af );
    
    /#
        function_709eab2489f477ad( "<dev string:x155>", self.var_f42f9d84927082af );
    #/
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x1b28acf6, Offset: 0x23be
// Size: 0x34
function function_d12facee5ddd8087()
{
    self.var_52a95b5ab94e7af2 = undefined;
    self.var_f42f9d84927082af = undefined;
    self.sweep_cooldown_time = gettime() + self.sweep_cooldown_ms;
    namespace_7143065cf1b062e3::clear_float_move();
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x27734bec, Offset: 0x23fa
// Size: 0x39
function function_439dbee0961c459b()
{
    self endon( #"death" );
    self endon( #"clear_float_move" );
    self.var_52a95b5ab94e7af2 waittill( #"death" );
    self.var_52a95b5ab94e7af2 = undefined;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0x4f56cd44, Offset: 0x243b
// Size: 0x91
function function_74ba0a37b7c2e035( target )
{
    dir_to_self = self.origin - target.origin;
    var_5290e343e7cabade = vectornormalize( dir_to_self ) * 128 + target.origin;
    var_f42f9d84927082af = getrandomnavpoint( var_5290e343e7cabade, 128 );
    
    if ( isdefined( var_f42f9d84927082af ) && abs( var_f42f9d84927082af[ 2 ] - self.origin[ 2 ] ) <= 50 )
    {
        return ( var_f42f9d84927082af + ( 0, 0, 50 ) );
    }
}

// Namespace zombie_disciple
// Params 2
// Checksum 0x29ba1555, Offset: 0x24d4
// Size: 0x145, Type: bool
function function_384296a688cfa34a( target, start_dist_sq )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( self.sweep_cooldown_time > gettime() )
    {
        return false;
    }
    
    if ( distancesquared( target.origin, self.origin ) < start_dist_sq )
    {
        return false;
    }
    
    if ( isent( target ) )
    {
        if ( !isalive( target ) || namespace_5b988172ec655354::function_67205a7e25fe2273( self ) || self getaiblackboarddynamic( "in_force_evolution" ) || self getaiblackboarddynamic( "request_force_evolution" ) )
        {
            return false;
        }
        
        if ( self._blackboard.var_6a8c50efac75caa1 > 0 )
        {
            var_464855befbe198ec = distance2dsquared( self._blackboard.var_b213ded5043dfa2b, target.origin );
            
            if ( var_464855befbe198ec > squared( self._blackboard.var_6a8c50efac75caa1 ) )
            {
                return false;
            }
        }
        
        if ( self.var_385a11d661a7ce23 && !self cansee( target ) )
        {
            return false;
        }
    }
    
    var_f42f9d84927082af = function_74ba0a37b7c2e035( target );
    
    if ( isdefined( var_f42f9d84927082af ) )
    {
        self.var_f42f9d84927082af = var_f42f9d84927082af;
        self.var_52a95b5ab94e7af2 = target;
        thread function_439dbee0961c459b();
        return true;
    }
    
    return false;
}

// Namespace zombie_disciple
// Params 2
// Checksum 0xb40f702a, Offset: 0x2622
// Size: 0x100, Type: bool
function function_51cf408567acb12a( target, start_dist_sq )
{
    if ( self._blackboard.var_6a8c50efac75caa1 <= 0 )
    {
        return false;
    }
    
    if ( !isalive( target ) || namespace_5b988172ec655354::function_67205a7e25fe2273( self ) )
    {
        return false;
    }
    
    if ( self.sweep_cooldown_time > gettime() )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, self._blackboard.var_b213ded5043dfa2b ) < start_dist_sq )
    {
        return false;
    }
    
    var_464855befbe198ec = distance2dsquared( self._blackboard.var_b213ded5043dfa2b, target.origin );
    
    if ( var_464855befbe198ec < squared( self._blackboard.var_6a8c50efac75caa1 ) )
    {
        return false;
    }
    
    var_f42f9d84927082af = self._blackboard.var_b213ded5043dfa2b;
    
    if ( isdefined( var_f42f9d84927082af ) )
    {
        self.var_f42f9d84927082af = var_f42f9d84927082af;
        return true;
    }
    
    return false;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x236c3cc8, Offset: 0x272b
// Size: 0x44f, Type: bool
function function_ae8129851e53d2ef()
{
    /#
        if ( getdvarint( @"hash_a13284356f5c0aaa", 0 ) )
        {
            return false;
        }
    #/
    
    if ( self.b_in_spawn_closet )
    {
        return false;
    }
    
    if ( self isintraverse() )
    {
        return false;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return false;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return false;
    }
    
    if ( namespace_5b988172ec655354::function_67205a7e25fe2273( self ) )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "request_force_evolution" ) || self getaiblackboarddynamic( "in_force_evolution" ) )
    {
        return false;
    }
    
    if ( status_effects::has_status_effect_type( "charm" ) )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "can_bind_zombies" ) && !namespace_6825c954c0756ce0::can_summon_zombies() )
    {
        return false;
    }
    
    n_time = gettime();
    
    if ( self.var_845a0792dc9e9059 != "defensive" && isdefined( self.var_493dad358ba8e342 ) && self.var_493dad358ba8e342 + 4000 > n_time )
    {
        return false;
    }
    
    if ( self.var_845a0792dc9e9059 != "defensive" && isdefined( self.var_2490adce807a0d9c ) && self.var_2490adce807a0d9c + 3000 > n_time )
    {
        return false;
    }
    
    if ( isdefined( self.var_5b98f83acb7d92c ) && self.var_5b98f83acb7d92c + 500 > n_time )
    {
        return false;
    }
    
    self.var_5b98f83acb7d92c = n_time;
    
    if ( !isdefined( level.var_c91c1b49d1cc4430 ) )
    {
        level.var_c91c1b49d1cc4430 = [];
    }
    
    var_76e311f8ad01c4c = function_47c86977a18df38b( level.var_c91c1b49d1cc4430, self.enemy.origin, 200 );
    
    if ( isdefined( var_76e311f8ad01c4c ) )
    {
        var_a6eb2cec013fdbef = var_76e311f8ad01c4c.spots;
    }
    else
    {
        var_a6eb2cec013fdbef = function_b52a4d4a1a7f47b7( self, self.enemy );
    }
    
    if ( !isarray( var_a6eb2cec013fdbef ) || var_a6eb2cec013fdbef.size == 0 )
    {
        self.var_2490adce807a0d9c = gettime();
        return false;
    }
    
    if ( !isplayer( self.enemy ) )
    {
        return false;
    }
    
    var_76e311f8ad01c4c = spawnstruct();
    var_76e311f8ad01c4c.origin = self.enemy.origin;
    var_76e311f8ad01c4c.spots = var_a6eb2cec013fdbef;
    level.var_c91c1b49d1cc4430[ level.var_c91c1b49d1cc4430.size ] = var_76e311f8ad01c4c;
    
    if ( level.var_c91c1b49d1cc4430.size > 15 )
    {
        level.var_c91c1b49d1cc4430 = utility::array_slice( level.var_c91c1b49d1cc4430, 5, 15 );
    }
    
    if ( isdefined( level.var_2102b1f59a32b7c6 ) )
    {
        foreach ( var_f2d9376971a2eae in level.var_2102b1f59a32b7c6 )
        {
            if ( var_a6eb2cec013fdbef.size == 0 )
            {
                self.var_2490adce807a0d9c = gettime();
                return false;
            }
            
            if ( !isalive( var_f2d9376971a2eae ) )
            {
                continue;
            }
            
            if ( !isdefined( var_f2d9376971a2eae.var_98b8abf242c21fd8 ) )
            {
                continue;
            }
            
            var_a6eb2cec013fdbef = utility::get_array_of_closest( var_f2d9376971a2eae.var_98b8abf242c21fd8, var_a6eb2cec013fdbef, undefined, undefined, undefined, 200, 1 );
        }
    }
    
    if ( self.var_845a0792dc9e9059 == "defensive" )
    {
        var_a6eb2cec013fdbef = function_8c4a4b21fac5f390( var_a6eb2cec013fdbef );
    }
    
    if ( isarray( var_a6eb2cec013fdbef ) && var_a6eb2cec013fdbef.size > 0 )
    {
        foreach ( spot in var_a6eb2cec013fdbef )
        {
            if ( isdefined( self.var_98b8abf242c21fd8 ) && distancesquared( spot.origin, self.var_98b8abf242c21fd8 ) < 300 )
            {
                continue;
            }
            
            hit_nothing = !navtrace( self.origin, spot.origin, self );
            
            if ( hit_nothing )
            {
                self.var_98b8abf242c21fd8 = spot.origin;
                return true;
            }
        }
    }
    
    self.var_2490adce807a0d9c = gettime();
    return false;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0xa1a0ea6f, Offset: 0x2b83
// Size: 0x1ac
function function_8c4a4b21fac5f390( var_a6eb2cec013fdbef )
{
    horde_list = function_f4432a6d8e12d35f();
    
    foreach ( spot in var_a6eb2cec013fdbef )
    {
        enemy_dist = 0;
        
        if ( isdefined( self.enemy ) )
        {
            enemy_dist = clamp( distance( self.enemy.origin, spot.origin ) / 500, 0, 1 ) * self.var_90f1944e4d0eedc;
        }
        
        player_influence = clamp( getinfluencedistanceatposition( spot.origin ) / 500, 0, 1 ) * self.var_f088969d069758ac;
        height = clamp( spot.origin[ 2 ] / 300, 0, 1 ) * self.var_f50b5cb59a26a35e;
        closest_hordes = utility::get_array_of_closest( spot.origin, horde_list, undefined, undefined, undefined, 200 );
        var_bd13b204b6991299 = 0;
        
        if ( isarray( closest_hordes ) && isdefined( closest_hordes[ 0 ] ) )
        {
            var_bd13b204b6991299 = closest_hordes[ 0 ].score;
        }
        
        spot.score = enemy_dist + var_bd13b204b6991299 + height - player_influence;
    }
    
    sorted_spots = arraysort( var_a6eb2cec013fdbef, undefined, &function_b1dae27a29511682 );
    return sorted_spots;
}

// Namespace zombie_disciple
// Params 2
// Checksum 0xfe15bca6, Offset: 0x2d38
// Size: 0x50, Type: bool
function function_b1dae27a29511682( a, b )
{
    if ( !isdefined( a.score ) )
    {
        return false;
    }
    
    if ( !isdefined( b.score ) )
    {
        return false;
    }
    
    return a.score > b.score;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x5a9bb34, Offset: 0x2d91
// Size: 0x133, Type: bool
function function_c2a441211d58c3b4()
{
    if ( namespace_5b988172ec655354::function_67205a7e25fe2273( self ) )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "request_force_evolution" ) || self getaiblackboarddynamic( "in_force_evolution" ) )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "in_summon" ) )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "in_scream_attack" ) )
    {
        return false;
    }
    
    info = self.var_a93b699a11eb2daf;
    
    if ( !isdefined( info ) )
    {
        return true;
    }
    
    if ( self.health <= self.var_bf3d6811fc2ab123 )
    {
        return true;
    }
    
    if ( gettime() < info.var_bcf1fe2485e54b1d )
    {
        return false;
    }
    
    if ( gettime() > info.var_f93193ccd432db68 )
    {
        return true;
    }
    
    if ( isdefined( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) < 40000 )
    {
        return true;
    }
    
    if ( isdefined( self.enemy ) && !self cansee( self.enemy ) )
    {
        info.var_3f49f8704c269353 += 1;
    }
    
    if ( info.var_3f49f8704c269353 >= 3 )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_disciple
// Params 2
// Checksum 0x9c027c3b, Offset: 0x2ecd
// Size: 0x163
function function_b52a4d4a1a7f47b7( disciple, disciple_enemy )
{
    originalpos = disciple.origin;
    enemypos = disciple_enemy.origin;
    to_enemy_yaw = vectortoyaw( disciple.origin - enemypos );
    positions = ai::function_7bcb54b16c07d1ec( 10, enemypos, 100, 500, 300, 1, to_enemy_yaw - 50, to_enemy_yaw + 50 );
    var_af666205ccc2fd8b = [];
    
    foreach ( pos in positions )
    {
        var_ed3ff56436a89f55 = distancesquared( originalpos, pos );
        
        if ( var_ed3ff56436a89f55 < squared( 200 ) )
        {
            continue;
        }
        
        if ( abs( originalpos[ 2 ] - pos[ 2 ] ) > 100 )
        {
            continue;
        }
        
        if ( !sighttracepassed( pos, enemypos, 0, disciple ) )
        {
            continue;
        }
        
        spot = spawnstruct();
        spot.origin = pos;
        var_af666205ccc2fd8b[ var_af666205ccc2fd8b.size ] = spot;
    }
    
    return var_af666205ccc2fd8b;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xb734d01e, Offset: 0x3039
// Size: 0x5a, Type: bool
function function_55924d325abaf8c5()
{
    if ( self.var_845a0792dc9e9059 == "defensive" || !isdefined( self.enemy ) || namespace_5b988172ec655354::function_67205a7e25fe2273( self ) || distancesquared( self.origin, self.enemy.origin ) > 62500 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xfca6d0ef, Offset: 0x309c
// Size: 0x2d5
function function_eead908427add3fd()
{
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_17c94bd4556610bb ) || distance2dsquared( self.origin, self.var_17c94bd4556610bb ) < 900 )
    {
        var_35ac0ffe1e64150b = self.origin - self.enemy.origin;
        yaw_to_disciple = vectortoyaw( var_35ac0ffe1e64150b );
        var_6be63f2fb3affaf2 = [ 30, -30 ];
        var_ed720ccbffb6cf8e = [];
        var_212777d371f9a7c0 = 100;
        
        if ( self getentitynumber() % 2 == 0 )
        {
            var_212777d371f9a7c0 += 50;
        }
        
        foreach ( angle in var_6be63f2fb3affaf2 )
        {
            target_angle = angleclamp180( yaw_to_disciple + angle );
            var_f69824bbfb33e492 = anglestoforward( ( 0, target_angle, 0 ) );
            target_pos = self.enemy.origin + var_f69824bbfb33e492 * var_212777d371f9a7c0;
            target_pos_navmesh = getclosestpointonnavmesh( target_pos );
            
            if ( isdefined( target_pos_navmesh ) )
            {
                var_ed720ccbffb6cf8e[ var_ed720ccbffb6cf8e.size ] = target_pos_navmesh;
            }
        }
        
        best_pos_navmesh = undefined;
        
        if ( !isdefined( self.var_17c94bd4556610bb ) )
        {
            if ( self.enemy utility::ent_flag( "disciple_take_left_turn" ) )
            {
                best_pos_navmesh = var_ed720ccbffb6cf8e[ 1 ] ?? var_ed720ccbffb6cf8e[ 0 ];
                self.enemy utility::ent_flag_clear( "disciple_take_left_turn" );
            }
            else
            {
                best_pos_navmesh = var_ed720ccbffb6cf8e[ 0 ];
                self.enemy utility::ent_flag_set( "disciple_take_left_turn" );
            }
        }
        else
        {
            forward_vec = self.velocity;
            
            foreach ( pos in var_ed720ccbffb6cf8e )
            {
                vec_to_pos = pos - self.origin;
                dot = vectordot( vec_to_pos, forward_vec );
                
                if ( dot > 0 )
                {
                    best_pos_navmesh = pos;
                }
            }
        }
        
        if ( !isdefined( best_pos_navmesh ) && var_ed720ccbffb6cf8e.size > 0 )
        {
            best_pos_navmesh = var_ed720ccbffb6cf8e[ randomint( var_ed720ccbffb6cf8e.size ) ];
        }
        
        if ( isdefined( best_pos_navmesh ) )
        {
            zombie_utils::update_bt_goal( best_pos_navmesh );
            self.var_17c94bd4556610bb = best_pos_navmesh;
        }
    }
}

// Namespace zombie_disciple
// Params 0
// Checksum 0x5e1faa02, Offset: 0x3379
// Size: 0x4c3
function function_f4432a6d8e12d35f()
{
    if ( getdvarint( @"hash_bc392c231114be3e", 0 ) )
    {
        if ( self.force_scream_attack )
        {
            if ( !isdefined( self.enemy ) )
            {
                return;
            }
            
            var_9d65156c1526bf0a = spawnstruct();
            var_9d65156c1526bf0a.center_ent = self.enemy;
            var_9d65156c1526bf0a.origin = self.enemy.origin;
            var_9d65156c1526bf0a.radius = self.var_671d348f225c33c;
            var_9d65156c1526bf0a.var_f99653cb971f7164 = 0;
            var_9d65156c1526bf0a.player_influence = getplayerinfluenceatposition( self.enemy.origin, 1 );
            self.var_63b34440b85afcdd = gettime() + self.var_38f3a2d30cddab2a;
            self.var_c106054902055cfd = gettime() + 5000;
            level.var_9ff6d5cbb5b1becd[ self getentitynumber() ] = var_9d65156c1526bf0a;
            return var_9d65156c1526bf0a;
        }
        
        if ( isdefined( self.var_e463f576fc860b07 ) )
        {
            var_9d65156c1526bf0a = spawnstruct();
            var_9d65156c1526bf0a.origin = self.var_e463f576fc860b07;
            var_9d65156c1526bf0a.radius = self.var_671d348f225c33c;
            var_9d65156c1526bf0a.var_f99653cb971f7164 = 0;
            
            if ( isdefined( self.enemy ) )
            {
                var_9d65156c1526bf0a.player_influence = getplayerinfluenceatposition( self.enemy.origin, 1 );
            }
            else
            {
                var_9d65156c1526bf0a.player_influence = 0;
            }
            
            self.var_63b34440b85afcdd = gettime() + self.var_38f3a2d30cddab2a;
            self.var_c106054902055cfd = gettime() + 5000;
            level.var_9ff6d5cbb5b1becd[ self getentitynumber() ] = var_9d65156c1526bf0a;
            return var_9d65156c1526bf0a;
        }
    }
    
    var_9ff6d5cbb5b1becd = [];
    ai_in_radius = getaiarrayinradius( self.origin, self.var_a96b67a80f895e54, self.team );
    ai_in_radius = utility::array_removedead_or_dying( ai_in_radius, 1 );
    
    if ( !isarray( ai_in_radius ) || ai_in_radius.size == 0 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_bc392c231114be3e", 0 ) )
    {
        var_660b70b030064ff7 = level.var_9ff6d5cbb5b1becd[ self getentitynumber() ];
        level.var_9ff6d5cbb5b1becd[ self getentitynumber() ] = undefined;
    }
    
    var_9ff6d5cbb5b1becd = [];
    
    foreach ( target in ai_in_radius )
    {
        if ( target == self )
        {
            continue;
        }
        
        if ( target.b_in_spawn_closet || target utility::ent_flag( "spawn_animating" ) || target.is_living_world_ai && !target.var_f2bc035a31b7e81b utility::ent_flag( "range_wait" ) )
        {
            continue;
        }
        
        var_119c6c17d6db9b8d = function_47c86977a18df38b( level.var_9ff6d5cbb5b1becd, target.origin );
        
        if ( isdefined( var_119c6c17d6db9b8d ) )
        {
            continue;
        }
        
        var_be3d7ac84b588173 = function_47c86977a18df38b( var_9ff6d5cbb5b1becd, target.origin );
        
        if ( !isdefined( var_be3d7ac84b588173 ) || distance2dsquared( var_be3d7ac84b588173.origin, target.origin ) > squared( self.var_9e9b24abbbbfac76 ) )
        {
            var_9d65156c1526bf0a = spawnstruct();
            var_9d65156c1526bf0a.center_ent = target;
            var_9d65156c1526bf0a.origin = target.origin;
            var_9d65156c1526bf0a.radius = self.var_671d348f225c33c;
            var_9d65156c1526bf0a.var_f99653cb971f7164 = 1;
            var_9d65156c1526bf0a.player_influence = getinfluencedistanceatposition( target.origin );
            var_9d65156c1526bf0a.score = var_9d65156c1526bf0a.var_f99653cb971f7164 * self.var_b5264bb792a5caf5 + var_9d65156c1526bf0a.player_influence + self.var_f088969d069758ac;
            var_9ff6d5cbb5b1becd[ var_9ff6d5cbb5b1becd.size ] = var_9d65156c1526bf0a;
            continue;
        }
        
        var_be3d7ac84b588173.var_f99653cb971f7164++;
        var_be3d7ac84b588173.score = var_be3d7ac84b588173.var_f99653cb971f7164 * self.var_b5264bb792a5caf5 + var_be3d7ac84b588173.player_influence + self.var_f088969d069758ac;
    }
    
    sorted_group = arraysort( var_9ff6d5cbb5b1becd, undefined, &function_d3cb0af34787b191 );
    
    if ( getdvarint( @"hash_bc392c231114be3e", 0 ) )
    {
        self.var_63b34440b85afcdd = gettime() + self.var_38f3a2d30cddab2a;
        self.var_c106054902055cfd = gettime() + 5000;
    }
    
    return sorted_group;
}

// Namespace zombie_disciple
// Params 2
// Checksum 0x348a93f6, Offset: 0x3845
// Size: 0x2c, Type: bool
function function_d3cb0af34787b191( a, b )
{
    return a.score > b.score;
}

// Namespace zombie_disciple
// Params 1
// Checksum 0x419a716d, Offset: 0x387a
// Size: 0x150
function function_be19bf0161341b13( var_d89f6942222346b3 )
{
    if ( !isarray( var_d89f6942222346b3 ) || var_d89f6942222346b3.size == 0 )
    {
        return;
    }
    
    var_e3b63c59f28bfc06 = undefined;
    current_max = -1;
    
    foreach ( area in var_d89f6942222346b3 )
    {
        score = area.var_f99653cb971f7164 * self.var_b5264bb792a5caf5 + area.player_influence + self.var_f088969d069758ac;
        
        if ( score > current_max )
        {
            current_max = score;
            var_e3b63c59f28bfc06 = area;
        }
        
        /#
            if ( getdvarint( @"hash_94fe2d66de772f4a", 0 ) )
            {
                utility::draw_circle( area.origin, area.radius, ( 1, 0, 0 ), 1, 0, 120 );
                print3d( area.origin, score, ( 1, 0, 0 ), 1, 1, 120, 1 );
            }
        #/
    }
    
    return var_e3b63c59f28bfc06;
}

// Namespace zombie_disciple
// Params 0
// Checksum 0xc0ec9b6b, Offset: 0x39d3
// Size: 0x56, Type: bool
function function_202699de918c3a3b()
{
    if ( !isdefined( self.var_b4c7fcee0d3f489a ) )
    {
        return true;
    }
    
    pathdist = self pathdisttogoal();
    
    if ( pathdist < 5 && self.var_63b34440b85afcdd < gettime() )
    {
        return true;
    }
    
    if ( self.var_c106054902055cfd < gettime() )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace zombie_disciple
    // Params 0
    // Checksum 0x554bfd53, Offset: 0x3a32
    // Size: 0x132, Type: dev
    function init_disciple_devgui()
    {
        state_name_map = [];
        state_name_map[ 0 ] = "<dev string:x164>";
        state_name_map[ 1 ] = "<dev string:x16a>";
        state_name_map[ 2 ] = "<dev string:x177>";
        state_name_map[ 3 ] = "<dev string:x18a>";
        state_name_map[ 4 ] = "<dev string:x197>";
        state_name_map[ 7 ] = "<dev string:x19e>";
        devgui::function_9082edeb5db93280( "<dev string:x1b3>" );
        devgui::add_devgui_func( "<dev string:x1cd>", "<dev string:x1dc>", &function_2f1f4082999f0dc9 );
        devgui::add_devgui_func( "<dev string:x1f0>", "<dev string:x20a>", &function_6a589a74a25c22b2 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x228>" );
        
        foreach ( i, v in state_name_map )
        {
            devgui::function_cd4e263c1f3018ae( v, "<dev string:x257>" + i, &force_movement_state );
        }
        
        devgui::function_cd4e263c1f3018ae( "<dev string:x26d>", "<dev string:x27f>", &force_movement_state );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_disciple
    // Params 0, eflags: 0x4
    // Checksum 0x7ea0ab79, Offset: 0x3b6c
    // Size: 0x1a, Type: dev
    function private function_2f1f4082999f0dc9()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x297>", @"scr_disciple_debug" );
    }

    // Namespace zombie_disciple
    // Params 1, eflags: 0x4
    // Checksum 0xd2b7aa69, Offset: 0x3b8e
    // Size: 0x32, Type: dev
    function private force_movement_state( params )
    {
        state_index = int( params[ 0 ] );
        setdvar( @"scr_disciple_movement_state", state_index );
    }

    // Namespace zombie_disciple
    // Params 2, eflags: 0x4
    // Checksum 0x8dcbcd69, Offset: 0x3bc8
    // Size: 0x5c, Type: dev
    function private function_709eab2489f477ad( text, pos )
    {
        if ( getdvarint( @"scr_disciple_debug", 0 ) )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, text, ( 1, 0, 0 ) );
        }
    }

    // Namespace zombie_disciple
    // Params 0, eflags: 0x4
    // Checksum 0xf0c94e4b, Offset: 0x3c2c
    // Size: 0x1a, Type: dev
    function private function_6a589a74a25c22b2()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x2aa>", @"hash_94fe2d66de772f4a" );
    }

#/
