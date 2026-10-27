// scripts\common\ai\aitypes\zombie_ghoul\zombie_ghoul_evolve.gsc  (hash_4c628d19ac1a7128.gscc) (size: 7528 Bytes / 0x1d68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x69feb953 (1778301267)
// size ...... 7528 (0x1d68)
// includes .. 8   (offset: 0x1b88)
// strings ... 22  (offset: 0x1bc8)
// dev strs .. 5   (offset: 0x1d2c)
// exports ... 18  (offset: 0x10cc)
// cseg ...... 0x1f8 + 0xed4 (0x10cc)
// imports ... 67  (offset: 0x139c)
// animtree1 . 0   (offset: 0x1d68)
// animtree2 . 0   (offset: 0x1d68)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_bloat;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_ghoul_evolve;

// Namespace zombie_ghoul_evolve
// Params 1
// Checksum 0x127053c0, Offset: 0x216
// Size: 0xd7
function precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( #"hash_1e82fd90ac15f030", settings.var_9790356329a0b80c );
        utility::add_fx( #"hash_362e8a8c8d649f0c", settings.var_a657f5514c73c750 );
        utility::add_fx( #"hash_b953a3fef4047fdf", settings.var_cca984a13a6d3e2d );
    }
    
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_ac1e78b85ea96df4", &function_52ca89363e4a2498 );
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_41aeb3f5f201459", &function_509659f755672e37 );
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_88bce97e9df03b00", &set_evolution_payload );
}

/#

    // Namespace zombie_ghoul_evolve
    // Params 0
    // Checksum 0x1098f3a9, Offset: 0x2f5
    // Size: 0xc, Type: dev
    function function_7cf79a3bca1e2c3b()
    {
        function_ef813ac18b5aba6e();
    }

#/

// Namespace zombie_ghoul_evolve
// Params 0
// Checksum 0xedaec6d2, Offset: 0x309
// Size: 0xfc
function init_zombie_ghoul_evolve()
{
    self.var_2d00ed01947563cf = {};
    self.var_2d00ed01947563cf.absorb_subclass = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_17ebd66a50287fe0;
    self.var_2d00ed01947563cf.next_subclass = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_37a085d02ab344e0;
    self.var_2d00ed01947563cf.var_6e4a9f218adc0f24 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_746527a3621947cf;
    self.var_2d00ed01947563cf.payload = [];
    
    if ( isdefined( self.var_2d00ed01947563cf.absorb_subclass ) && isdefined( self.var_2d00ed01947563cf.next_subclass ) )
    {
        thread function_639c8f566ae07287( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb );
    }
}

// Namespace zombie_ghoul_evolve
// Params 1, eflags: 0x4
// Checksum 0x6ceb49cc, Offset: 0x40d
// Size: 0xad
function private function_52ca89363e4a2498( params )
{
    if ( isdefined( params.var_6312bbd31744f16d ) )
    {
        self.evolve_wait_time = params.var_6312bbd31744f16d;
        
        if ( !utility::ent_flag_exist( "seconds_between_evolution_attempts_changed" ) )
        {
            utility::ent_flag_set( "seconds_between_evolution_attempts_changed" );
        }
    }
    
    if ( isdefined( params.var_22f864c06ba32b89 ) )
    {
        self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f = params.var_22f864c06ba32b89;
        
        if ( !utility::ent_flag_exist( "on_spawn_max_evolved_from_ghoul_ai_limit_changed" ) )
        {
            utility::ent_flag_set( "on_spawn_max_evolved_from_ghoul_ai_limit_changed" );
        }
    }
    
    if ( params.b_force_evolve )
    {
        utility::ent_flag_set( "ghoul_evolve_forced" );
    }
}

// Namespace zombie_ghoul_evolve
// Params 2
// Checksum 0xc9dc5621, Offset: 0x4c2
// Size: 0x46
function set_evolution_payload( id, data )
{
    if ( !isdefined( self.var_2d00ed01947563cf.payload ) )
    {
        return;
    }
    
    self.var_2d00ed01947563cf.payload[ id ] = data;
}

// Namespace zombie_ghoul_evolve
// Params 1
// Checksum 0xfd704dd9, Offset: 0x510
// Size: 0x57
function function_f682288906366dc0( id )
{
    if ( !isdefined( self.var_2d00ed01947563cf.payload ) )
    {
        return;
    }
    
    if ( isdefined( id ) )
    {
        self.var_2d00ed01947563cf.payload[ id ] = undefined;
        return;
    }
    
    self.var_2d00ed01947563cf.payload = undefined;
}

// Namespace zombie_ghoul_evolve
// Params 0
// Checksum 0x4d4e0a8a, Offset: 0x56f
// Size: 0x48
function function_5740e31b0bc8593c()
{
    disciple_parent_data = self.evolution_payload[ "disciple_parent" ];
    
    if ( isdefined( disciple_parent_data ) )
    {
        self [[ disciple_parent_data.var_b3e176999aae46d7 ]]( disciple_parent_data.disciple_parent, disciple_parent_data.var_9ad7cc5d07653ebc );
    }
}

// Namespace zombie_ghoul_evolve
// Params 1, eflags: 0x4
// Checksum 0x5c217bed, Offset: 0x5bf
// Size: 0x51d
function private function_639c8f566ae07287( var_d3de1a9faac42deb )
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "on_spawn_max_evolved_from_ghoul_ai_limit_changed", 2 );
    
    if ( !isdefined( self.evolve_wait_time ) )
    {
        self.evolve_wait_time = undefined;
    }
    
    if ( !isdefined( self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f ) )
    {
        self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f = var_d3de1a9faac42deb.var_7b35a9cabadcc2f7;
    }
    
    while ( true )
    {
        utility::ent_flag_wait_or_timeout( "ghoul_evolve_forced", self.evolve_wait_time ?? 180 );
        utility::ent_flag_waitopen_any( "ghoul_evolve_disabled" );
        
        if ( !utility::ent_flag( "seconds_between_evolution_attempts_changed" ) )
        {
            self.evolve_wait_time = undefined;
        }
        
        var_d8414f13d6081221 = 0;
        
        if ( utility::ent_flag( "ghoul_evolve_forced" ) )
        {
            if ( utility::ent_flag( "ghoul_evolve_skip_anim" ) )
            {
                var_d8414f13d6081221 = 1;
            }
            
            utility::ent_flag_clear( "ghoul_evolve_forced" );
        }
        else
        {
            if ( isdefined( level.var_601b5149340f96ae ) && !utility::ent_flag( "seconds_between_evolution_attempts_changed" ) )
            {
                if ( !self [[ level.var_601b5149340f96ae ]]() )
                {
                    self.evolve_wait_time = 3;
                    continue;
                }
            }
            
            if ( !function_509659f755672e37() && !utility::ent_flag( "seconds_between_evolution_attempts_changed" ) )
            {
                self.evolve_wait_time = 3;
                continue;
            }
        }
        
        if ( zombie_utils::function_bf1464d09f4e4b40() && !utility::ent_flag( "seconds_between_evolution_attempts_changed" ) )
        {
            self.evolve_wait_time = 3;
            continue;
        }
        
        self function_786bb6aa1b76c7ee( "in_evolve", 1 );
        utility::ent_flag_set( "in_evolution_state" );
        
        if ( !isdefined( level.var_16cdf431aa127631 ) )
        {
            level.var_16cdf431aa127631 = 0;
        }
        
        level.var_16cdf431aa127631++;
        self waittill( #"evolve_prepared_start" );
        self setscriptablepartstate( "evolve_fx", "on" );
        zombie_utils::function_dfae6a5bd222c586( &function_6dba37dc2120b435 );
        a_all_zombies = getaiarrayinradius( self.origin, 300, self.team );
        a_zombies = [];
        
        foreach ( zombie in a_all_zombies )
        {
            if ( isalive( zombie ) && zombie.subclass == self.var_2d00ed01947563cf.absorb_subclass )
            {
                a_zombies[ a_zombies.size ] = zombie;
                
                if ( a_zombies.size >= 10 )
                {
                    break;
                }
            }
        }
        
        if ( a_zombies.size < 5 )
        {
            childthread function_cb11da9a20c387c5( 5 - a_zombies.size );
        }
        
        foreach ( zombie in a_zombies )
        {
            thread function_6c753cac5f683144( zombie );
        }
        
        self.var_20e90da189aed81d = 0;
        b_evolve_success = function_f314569bdb12772e( var_d8414f13d6081221 );
        
        if ( b_evolve_success )
        {
            evolved_ai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( self.var_2d00ed01947563cf.next_subclass ), self.origin, self.angles, self.team );
            
            if ( evolved_ai )
            {
                evolved_ai.b_evolved = 1;
                
                if ( isdefined( self.var_2d00ed01947563cf.payload ) )
                {
                    evolved_ai.evolution_payload = self.var_2d00ed01947563cf.payload;
                }
                
                evolved_ai function_5740e31b0bc8593c();
                evolved_ai callback::callback( "spawned_from_emergence" );
                callback::callback( #"emergence_spawn", { #ai:evolved_ai } );
            }
            
            self.nocorpse = 1;
            self.var_a13bed1ac47e1b2c = 1;
            self kill( self.origin );
            level.var_16cdf431aa127631 = int( max( level.var_16cdf431aa127631 - 1, 0 ) );
            break;
        }
        
        self function_786bb6aa1b76c7ee( "in_evolve", 0 );
        utility::ent_flag_clear( "in_evolution_state" );
        level.var_16cdf431aa127631 = int( max( level.var_16cdf431aa127631 - 1, 0 ) );
        self function_786bb6aa1b76c7ee( "evolve_result", 0 );
        self setscriptablepartstate( "evolve_fx", "off" );
        zombie_utils::function_10c0c35c21e3ed9d( &function_6dba37dc2120b435 );
        self.health = int( min( self.health + self.maxhealth * self.var_20e90da189aed81d * self.var_2d00ed01947563cf.var_6e4a9f218adc0f24, self.maxhealth ) );
        
        if ( !utility::ent_flag( "seconds_between_evolution_attempts_changed" ) )
        {
            self.evolve_wait_time = 120;
        }
    }
}

// Namespace zombie_ghoul_evolve
// Params 0
// Checksum 0x8296d3ad, Offset: 0xae4
// Size: 0x55, Type: bool
function function_509659f755672e37()
{
    if ( !isdefined( level.var_9335940a4e492645 ) )
    {
        level.var_9335940a4e492645 = 0;
    }
    
    if ( !isdefined( level.var_16cdf431aa127631 ) )
    {
        level.var_16cdf431aa127631 = 0;
    }
    
    return level.var_9335940a4e492645 + level.var_16cdf431aa127631 < self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f;
}

// Namespace zombie_ghoul_evolve
// Params 1, eflags: 0x4
// Checksum 0x1189696b, Offset: 0xb42
// Size: 0x80, Type: bool
function private function_f314569bdb12772e( var_d8414f13d6081221 )
{
    self endon( #"evolve_fail" );
    
    if ( var_d8414f13d6081221 )
    {
        b_evolve_success = var_d8414f13d6081221;
    }
    else
    {
        wait 10;
        self notify( #"absorb_zombies" );
        wait 0.5;
        b_evolve_success = self.var_20e90da189aed81d >= 3;
    }
    
    self function_786bb6aa1b76c7ee( "evolve_result", b_evolve_success ? 1 : 2 );
    
    if ( b_evolve_success )
    {
        utility::waittill_any_timeout( 3, "start_evolution" );
        return true;
    }
    
    waitframe();
    return false;
}

// Namespace zombie_ghoul_evolve
// Params 1, eflags: 0x4
// Checksum 0x15818166, Offset: 0xbcb
// Size: 0x1d
function private function_6dba37dc2120b435( params )
{
    return params.idamage * 0.35;
}

// Namespace zombie_ghoul_evolve
// Params 1, eflags: 0x4
// Checksum 0x92b2ccee, Offset: 0xbf1
// Size: 0x12f
function private function_cb11da9a20c387c5( n_count )
{
    spawn_points = ai::function_7bcb54b16c07d1ec( n_count, self.origin, 80, 220, 140 );
    ai_type = function_b3988325430ce242( self.var_2d00ed01947563cf.absorb_subclass );
    
    foreach ( spawn_point in spawn_points )
    {
        spawn_angles = vectortoangles( self.origin - spawn_point );
        var_98fb882c060e473b = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( ai_type, spawn_point, spawn_angles, self.team );
        
        if ( isdefined( var_98fb882c060e473b ) )
        {
            var_98fb882c060e473b.var_5d3022108c155ed4 = #"hash_76b6069e721f145b";
            var_98fb882c060e473b thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
            thread function_6c753cac5f683144( var_98fb882c060e473b );
        }
        
        wait 1;
    }
}

// Namespace zombie_ghoul_evolve
// Params 1, eflags: 0x4
// Checksum 0xdf7f574c, Offset: 0xd28
// Size: 0x197
function private function_6c753cac5f683144( zombie )
{
    self endon( #"death" );
    self endon( #"evolve_fail" );
    zombie endon( #"death" );
    s_attractor = { #team:"neutral", #origin:self.origin };
    zombie zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 4, 300 );
    zombie thread function_9e5fc1e047fee1e2( self, s_attractor );
    
    while ( isalive( self ) && distance2dsquared( self.origin, zombie.origin ) > squared( 140 ) )
    {
        wait 0.5;
    }
    
    zombie zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_attractor );
    zombie namespace_27d28dc1345f6289::function_2cd238f58ce9245b( 13 );
    playfxontag( utility::getfx( #"hash_1e82fd90ac15f030" ), zombie, "j_spine4" );
    zombie.forceannihilate = 1;
    zombie.var_cfc66782eb4df4c2 = playfxontagsbetweenclients( utility::getfx( #"hash_b953a3fef4047fdf" ), self, "j_spine4", zombie, "j_spine4" );
    zombie.var_cfc66782eb4df4c2 namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    zombie thread utility::delete_on_death( zombie.var_cfc66782eb4df4c2 );
    self waittill( #"absorb_zombies" );
    self.var_20e90da189aed81d++;
    wait self.var_20e90da189aed81d * 0.1 + 0.1;
    level thread function_f206e127448ee3f7( self, zombie );
    zombie.var_a13bed1ac47e1b2c = 1;
    zombie kill( zombie.origin );
}

// Namespace zombie_ghoul_evolve
// Params 2, eflags: 0x4
// Checksum 0x55c630c8, Offset: 0xec7
// Size: 0x83
function private function_9e5fc1e047fee1e2( ghoul, s_attractor )
{
    self endon( #"death" );
    ghoul utility::waittill_any( "death", "evolve_fail" );
    stopfxontag( utility::getfx( #"hash_1e82fd90ac15f030" ), self, "j_spine4" );
    zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_attractor );
    namespace_27d28dc1345f6289::function_283d2dbdc4ac8f96();
    self.forceannihilate = undefined;
    
    if ( isdefined( self.var_cfc66782eb4df4c2 ) )
    {
        self.var_cfc66782eb4df4c2 delete();
    }
}

// Namespace zombie_ghoul_evolve
// Params 2, eflags: 0x4
// Checksum 0x7202369, Offset: 0xf52
// Size: 0xf6
function private function_f206e127448ee3f7( ghoul, zombie )
{
    level endon( #"game_ended" );
    trail_start = zombie.origin + ( 0, 0, 40 );
    trail_end = ghoul.origin + ( 0, 0, 50 );
    
    if ( zombie tagexists( "j_spine4" ) )
    {
        trail_start = zombie gettagorigin( "j_spine4" );
    }
    
    if ( ghoul tagexists( "j_spine4" ) )
    {
        trail_end = ghoul gettagorigin( "j_spine4" );
    }
    
    trail_ent = utility::spawn_model( "tag_origin", trail_start, zombie.angles );
    playfxontag( utility::getfx( #"hash_362e8a8c8d649f0c" ), trail_ent, "tag_origin" );
    trail_ent moveto( trail_end, 0.2 );
    wait 0.5;
    trail_ent delete();
}

/#

    // Namespace zombie_ghoul_evolve
    // Params 0, eflags: 0x4
    // Checksum 0x5cc0dde4, Offset: 0x1050
    // Size: 0x2e, Type: dev
    function private function_ef813ac18b5aba6e()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x42>", "<dev string:x53>", &function_cb0423985b574ecf );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_ghoul_evolve
    // Params 0, eflags: 0x4
    // Checksum 0xda556df4, Offset: 0x1086
    // Size: 0x46, Type: dev
    function private function_cb0423985b574ecf()
    {
        ghoul = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x63>" );
        
        if ( isdefined( ghoul ) )
        {
            ghoul utility::ent_flag_set( "<dev string:x70>" );
        }
    }

#/
