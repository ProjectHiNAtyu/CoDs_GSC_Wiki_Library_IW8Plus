// script_3b63a3e0026b877b  (hash_3b63a3e0026b877b.gscc) (size: 10162 Bytes / 0x27b2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44c60fd5 (1153830869)
// size ...... 10162 (0x27b2)
// includes .. 10  (offset: 0x252a)
// strings ... 33  (offset: 0x257a)
// dev strs .. 0   (offset: 0x27b2)
// exports ... 19  (offset: 0x18ea)
// cseg ...... 0x2b3 + 0x1637 (0x18ea)
// imports ... 79  (offset: 0x1be2)
// animtree1 . 0   (offset: 0x27b2)
// animtree2 . 0   (offset: 0x27b2)
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_utility;

#namespace namespace_a2abfbbbd7a9852f;

// Namespace namespace_a2abfbbbd7a9852f
// Params 0
// Checksum 0x5121d667, Offset: 0x2d1
// Size: 0x2a5
function function_26586a1abc6350ac()
{
    level endon( #"game_ended" );
    level endon( #"hash_45c8729688962b7d" );
    
    while ( true )
    {
        if ( !isalive( self.empowered_ai ) )
        {
            spawn_pos = utility::function_8ae0ea62537eafc5( self.empowered_ai_spawn_pos.origin, 150 );
            
            if ( isdefined( spawn_pos ) )
            {
                self.empowered_ai = spawn_empowered_ai( self.origin, spawn_pos );
                
                if ( !isdefined( self.empowered_ai ) )
                {
                    wait 1;
                    continue;
                }
                
                thread zm_quest::update_guidance( [ [ self.empowered_ai, 70, undefined, &"zm_sat_mantis_post/protect" ] ], #"mantis_mq_guidance", #"hash_2779ce97f29bfa34" );
                
                if ( !level.s_dark_heart.phase_data[ "phase_3" ].var_e622cff9ef923dd2 )
                {
                    self.empowered_ai thread function_3a22798776fee0fc();
                }
                
                self.empowered_ai thread function_8ab8a5081b984d80();
                self.empowered_ai thread function_7888890ade31ea46();
                zm_quest::function_cd1f2fee4749fb0a( 1, #"mantis_mq", #"hash_62f0c8070b60a671" );
                zm_quest::function_9f49b2a045ece8ae( 100, 1, #"mantis_mq", #"hash_62f0c8070b60a671" );
                self.empowered_ai callback::add( "on_zombie_ai_damaged", &function_98acdd656e4f8675 );
                self.empowered_ai val::set( "empowered_ai", "ammomod_immune" );
                self.empowered_ai val::set( "empowered_ai", "ignoreme" );
                self.empowered_ai callback::add( "on_zombie_ai_killed", &function_4d8b237d50f0f7a4 );
                self.empowered_ai waittill( #"death", attacker );
                
                if ( isplayer( attacker ) )
                {
                    function_5b23eef175d403fd( self.empowered_ai.origin );
                }
                
                if ( !self.var_dd5147eb36a3795b[ 0 ].b_released || !self.var_dd5147eb36a3795b[ 1 ].b_released || !self.var_dd5147eb36a3795b[ 2 ].b_released )
                {
                    thread zm_quest::update_guidance( undefined, #"mantis_mq_guidance", #"hash_2779ce97f29bfa34" );
                }
                
                self.empowered_ai = undefined;
                wait level.s_dark_heart.phase_data[ "phase_3" ].var_610b3fe3c8e4f1c;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 1, eflags: 0x4
// Checksum 0x34567f60, Offset: 0x57e
// Size: 0xec
function private function_4d8b237d50f0f7a4( params )
{
    zm_quest::function_fba942a1cfd85f5d( 0, 1, #"mantis_mq", #"hash_62f0c8070b60a671" );
    level zm_quest::clear_all_guidance();
    entity_num = self getentitynumber();
    
    if ( isdefined( level.var_617d007621979019[ entity_num ] ) )
    {
        foreach ( beam in level.var_617d007621979019[ entity_num ] )
        {
            if ( isdefined( beam ) )
            {
                beam delete();
            }
        }
        
        level.var_617d007621979019[ entity_num ] = function_5713d46873b29625( level.var_617d007621979019[ entity_num ] );
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 6
// Checksum 0x27bcd922, Offset: 0x672
// Size: 0x173
function fire_fireball( source_position, impact_position, var_9867cb3f8b621dc4, override_damage_radius, override_max_damage, override_min_damage )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_9867cb3f8b621dc4 ) )
    {
        var_9867cb3f8b621dc4 = 3;
    }
    
    if ( !isdefined( override_damage_radius ) )
    {
        override_damage_radius = 400;
    }
    
    if ( !isdefined( override_max_damage ) )
    {
        override_max_damage = 300;
    }
    
    if ( !isdefined( override_min_damage ) )
    {
        override_min_damage = 200;
    }
    
    self.fireball = utility::spawn_model( "tag_origin", source_position );
    self.fireball.angles = vectortoangles( impact_position - source_position );
    self.fireball thread function_a889dbaed0c5596c();
    self.fireball utility::function_8001268940441423( source_position, impact_position, averagepoint( [ source_position, impact_position ] ) + ( 0, 0, 300 ), var_9867cb3f8b621dc4, 0, 1 );
    
    if ( self.fireball )
    {
        self.fireball delete();
    }
    
    if ( !isdefined( level.s_dark_heart.damage_proxy ) )
    {
        level.s_dark_heart.damage_proxy = utility::spawn_model( "tag_origin", level.s_dark_heart.origin );
    }
    
    radiusdamage( impact_position, override_damage_radius, override_max_damage, override_min_damage, level.s_dark_heart.damage_proxy );
    zm_utility::function_1d82e63812f9640a( impact_position, override_damage_radius, 0.5 );
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0
// Checksum 0xdae77dc4, Offset: 0x7ed
// Size: 0x9c
function function_a889dbaed0c5596c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.last_pos ) )
        {
            self.last_pos = self.origin;
        }
        else if ( self.last_pos != self.origin )
        {
            angles = vectortoangles( self.origin - self.last_pos );
            self.angles = angles;
            self.last_pos = self.origin;
        }
        
        waitframe();
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 2
// Checksum 0x3dd1373a, Offset: 0x891
// Size: 0x2fc
function spawn_empowered_ai( source_position, spawn_pos )
{
    level endon( #"game_ended" );
    fire_fireball( source_position, spawn_pos );
    waitframe();
    empowered_ai = zm_quest::spawn_zombies_at_location( level.s_dark_heart.phase_data[ "phase_3" ].var_f0707219edffbcc3, spawn_pos, 1, 0, undefined, 1, undefined, 1 )[ 0 ];
    
    if ( !isdefined( empowered_ai ) )
    {
        return;
    }
    
    empowered_ai utility::callsharedfunc( #"w_mod", #"wisp_ignore", "mantis_boss_fight" );
    empowered_ai thread function_3ca9cf0a9c84279c();
    empowered_ai thread function_8d79e0a2550fc82();
    empowered_ai thread utility::delaythreadendon( getdvarfloat( @"hash_fdc4f4a8bc38d1b9", 3.1 ), "death", &function_24cdf85728043f90 );
    empowered_ai setscriptablepartstate( "mantis_empowered_ai", "active" );
    empowered_ai.var_19238dbcc969affa = 0;
    
    if ( isdefined( level.s_dark_heart.phase_data[ "phase_3" ].var_819e711fd86e9bf5 ) )
    {
        empowered_ai ai::set_ai_max_health( level.s_dark_heart.phase_data[ "phase_3" ].var_819e711fd86e9bf5 );
        empowered_ai.health = level.s_dark_heart.phase_data[ "phase_3" ].var_819e711fd86e9bf5;
    }
    
    if ( isdefined( level.s_dark_heart.phase_data[ "phase_3" ].var_523df0729fca20bd ) )
    {
        empowered_ai thread zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( level.s_dark_heart.phase_data[ "phase_3" ].var_523df0729fca20bd == "super_sprint" || level.s_dark_heart.phase_data[ "phase_3" ].var_523df0729fca20bd == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && level.s_dark_heart.phase_data[ "phase_3" ].var_523df0729fca20bd == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && level.s_dark_heart.phase_data[ "phase_3" ].var_523df0729fca20bd == "sprint" ? "run" : level.s_dark_heart.phase_data[ "phase_3" ].var_523df0729fca20bd, "zm_quest", 6 );
    }
    
    empowered_ai.var_ee697eaba1724382 = 1;
    return empowered_ai;
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 1
// Checksum 0xabc9628e, Offset: 0xb96
// Size: 0x22
function immune_check( params )
{
    if ( function_fd01dedacb92ac4a() )
    {
        return 0;
    }
    
    return params.idamage;
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0
// Checksum 0x5837aaab, Offset: 0xbc1
// Size: 0xba, Type: bool
function function_fd01dedacb92ac4a()
{
    new_array = [];
    
    foreach ( zombie in self.draining_zombies )
    {
        if ( isalive( zombie ) && zombie.var_873309f049548b1d )
        {
            new_array[ new_array.size ] = zombie;
        }
    }
    
    self.draining_zombies = new_array;
    
    if ( self.draining_zombies.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0
// Checksum 0x2698de72, Offset: 0xc84
// Size: 0x57
function function_3a22798776fee0fc()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !zm_quest::function_c003bcea47ed77fe( level.s_dark_heart.phase_data[ "phase_3" ].var_1cd2b52533b87957, 1 ) )
        {
            zombie_stun::stun_ai( 0.5 );
        }
        
        wait 0.5;
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0, eflags: 0x4
// Checksum 0xa84a01c4, Offset: 0xce3
// Size: 0x215
function private function_8ab8a5081b984d80()
{
    self endon( #"death" );
    self.draining_zombies = [];
    var_8554155703d37111 = level.s_dark_heart.phase_data[ "phase_3" ].var_9d7b4a10d69f9380;
    var_aeff9b6ecaaf2005 = level.s_dark_heart.phase_data[ "phase_3" ].var_bd5f7a0bd01553b;
    var_88086def77f4ba4c = level.s_dark_heart.phase_data[ "phase_3" ].var_9ad4cffa5d51f032;
    var_8554155703d37111 = level.s_dark_heart.phase_data[ "phase_3" ].var_9d7b4a10d69f9380;
    var_f4cf709b0a6d32f9 = zm_sat_mantis_boss_fight::function_d15951201200bcaa( level.s_dark_heart.phase_data[ "phase_3" ] );
    
    while ( true )
    {
        near_zombies = getaiarrayinradius( self.origin, level.s_dark_heart.phase_data[ "phase_3" ].var_1cd2b52533b87957, "team_two_hundred" );
        near_zombies = arrayrandomize( near_zombies );
        
        if ( near_zombies.size != 0 )
        {
            i = 0;
            
            while ( i < near_zombies.size && i < var_aeff9b6ecaaf2005 )
            {
                self.draining_zombies = function_46f9072493651dc9( self.draining_zombies );
                self.draining_zombies = function_5713d46873b29625( self.draining_zombies );
                
                if ( !arraycontains( self.draining_zombies, near_zombies[ i ] ) && isalive( near_zombies[ i ] ) && self != near_zombies[ i ] && near_zombies[ i ].aicategory == "normal" && !near_zombies[ i ].b_in_spawn_closet )
                {
                    near_zombies[ i ] thread link_chain( self, var_8554155703d37111, var_f4cf709b0a6d32f9 );
                    self.draining_zombies[ self.draining_zombies.size ] = near_zombies[ i ];
                }
                
                i++;
                waitframe();
            }
        }
        
        wait var_88086def77f4ba4c;
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0, eflags: 0x4
// Checksum 0x3087a878, Offset: 0xf00
// Size: 0x18e
function private function_7888890ade31ea46()
{
    self endon( #"death" );
    self.draining_zombies = [];
    var_8554155703d37111 = level.s_dark_heart.phase_data[ "phase_3" ].var_9d7b4a10d69f9380;
    var_8554155703d37111 = level.s_dark_heart.phase_data[ "phase_3" ].var_9d7b4a10d69f9380;
    var_f4cf709b0a6d32f9 = level.s_dark_heart.phase_data[ "phase_3" ].var_601edadcf590dc7d;
    
    while ( true )
    {
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            if ( var_576d220b01160c72.b_released || var_576d220b01160c72.var_6eb21481f208c57f )
            {
                continue;
            }
            
            if ( distance( self.origin, var_576d220b01160c72.origin ) < level.s_dark_heart.phase_data[ "phase_3" ].var_1cd2b52533b87957 )
            {
                var_576d220b01160c72 thread link_chain( self, var_8554155703d37111, var_f4cf709b0a6d32f9 );
                break;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 3
// Checksum 0x69ffde55, Offset: 0x1096
// Size: 0x319
function link_chain( empowered_ai, var_8554155703d37111, var_f4cf709b0a6d32f9 )
{
    level endon( #"game_ended" );
    
    if ( isagent( self ) )
    {
        self endon( #"death" );
    }
    
    empowered_ai endon( #"death" );
    
    if ( !isdefined( level.var_617d007621979019 ) )
    {
        level.var_617d007621979019 = [];
    }
    
    if ( !isdefined( level.var_617d007621979019[ empowered_ai getentitynumber() ] ) )
    {
        level.var_617d007621979019[ empowered_ai getentitynumber() ] = [];
    }
    
    n_active_beams = 0;
    
    if ( isdefined( level.var_617d007621979019 ) )
    {
        foreach ( entity_beams in level.var_617d007621979019 )
        {
            foreach ( b in entity_beams )
            {
                if ( isdefined( b ) )
                {
                    n_active_beams++;
                }
            }
        }
    }
    
    link_beam = undefined;
    
    if ( isagent( self ) )
    {
        if ( n_active_beams < 20 )
        {
            link_beam = playfxontagsbetweenclients( utility::getfx( "empowered_ai_beam" ), empowered_ai, "j_spineupper", self, "j_spineupper" );
        }
    }
    else if ( isstruct( self ) )
    {
        if ( !isdefined( self.mdl ) )
        {
            return;
        }
        
        if ( self.draining_struct )
        {
            return;
        }
        
        self.draining_struct = 1;
        
        if ( n_active_beams < 20 )
        {
            link_beam = playfxontagsbetweenclients( utility::getfx( "empowered_ai_beam" ), empowered_ai, "j_spineupper", self.mdl, "tag_origin" );
        }
    }
    
    if ( isdefined( link_beam ) )
    {
        level.var_617d007621979019[ empowered_ai getentitynumber() ][ level.var_617d007621979019[ empowered_ai getentitynumber() ].size ] = link_beam;
    }
    
    self.var_873309f049548b1d = 1;
    wait var_8554155703d37111;
    self.var_873309f049548b1d = 0;
    
    if ( isdefined( link_beam ) )
    {
        link_beam delete();
    }
    
    if ( isstruct( self ) )
    {
        self.draining_struct = 0;
        return;
    }
    
    if ( isagent( self ) )
    {
        empowered_ai.draining_zombies = arrayremove( empowered_ai.draining_zombies, self );
    }
    
    if ( !isdefined( level.s_dark_heart.damage_proxy ) )
    {
        level.s_dark_heart.damage_proxy = utility::spawn_model( "tag_origin", level.s_dark_heart.origin );
    }
    
    empowered_ai dodamage( empowered_ai.maxhealth * var_f4cf709b0a6d32f9, empowered_ai.origin, level.s_dark_heart.damage_proxy );
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 1
// Checksum 0x280fd271, Offset: 0x13b7
// Size: 0x114
function function_5b23eef175d403fd( source_position )
{
    level endon( #"game_ended" );
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        if ( distance( source_position, var_576d220b01160c72.origin ) < level.s_dark_heart.phase_data[ "phase_3" ].var_1cd2b52533b87957 )
        {
            fx_proxy = utility::spawn_model( "tag_origin", source_position );
            fx_proxy zm_quest::function_b8743f5a9219cf9b( source_position, var_576d220b01160c72.origin, "new_zombie_soul_trail", 50 );
            var_576d220b01160c72 zm_sat_mantis_boss_fight::function_3176083662ac618d( 0 );
            level notify( #"boss_fight_phase3_release_musical_items" );
            return;
        }
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0, eflags: 0x4
// Checksum 0xd8189112, Offset: 0x14d3
// Size: 0xa8
function private function_3ca9cf0a9c84279c()
{
    self.tornado_vfx = utility::spawn_model( "tag_origin", self.origin );
    self.tornado_vfx endon( #"death" );
    thread utility::delete_on_death( self.tornado_vfx );
    thread function_a5610bf29545e35b( self.tornado_vfx, self );
    playfxontag( level._effect[ "empowered_ai_tornado_spawn" ], self.tornado_vfx, "tag_origin" );
    wait getdvarfloat( @"hash_a98db014b04bef00", 3 );
    playfxontag( level._effect[ "empowered_ai_tornado" ], self.tornado_vfx, "tag_origin" );
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 2, eflags: 0x4
// Checksum 0xa8c59f1d, Offset: 0x1583
// Size: 0x82
function private function_a5610bf29545e35b( tornado, empowered_ai )
{
    tornado endon( #"death" );
    empowered_ai endon( #"death" );
    
    while ( true )
    {
        navmesh_pos = getclosestpointonnavmesh( empowered_ai.origin, empowered_ai );
        
        if ( navmesh_pos )
        {
            ground_pos = getgroundposition( navmesh_pos, 1, 100, 0 );
            
            if ( ground_pos )
            {
                tornado.origin = ground_pos;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0, eflags: 0x4
// Checksum 0xa6ff99e5, Offset: 0x160d
// Size: 0xa4
function private give_aura()
{
    var_d981cebbe5db0ec0 = "j_spine4";
    
    if ( isdefined( self.model ) && !modelhastag( self.model, var_d981cebbe5db0ec0 ) )
    {
        var_d981cebbe5db0ec0 = "tag_origin";
    }
    
    self.aura = utility::spawn_model( "tag_origin", self gettagorigin( var_d981cebbe5db0ec0 ) );
    thread utility::delete_on_death( self.aura );
    self.aura linkto( self, var_d981cebbe5db0ec0 );
    playfxontag( level._effect[ "empowered_ai_aura" ], self.aura, "tag_origin" );
    self playloopsound( "evt_wwq_fire_zombie_tether" );
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 1, eflags: 0x4
// Checksum 0x9527dcd5, Offset: 0x16b9
// Size: 0x45
function private function_98acdd656e4f8675( params )
{
    if ( isalive( self ) )
    {
        zm_quest::function_9f49b2a045ece8ae( self.health * 100 / self.maxhealth, 1, #"mantis_mq", #"hash_62f0c8070b60a671" );
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0, eflags: 0x4
// Checksum 0xe02864b, Offset: 0x1706
// Size: 0x11e
function private function_8d79e0a2550fc82()
{
    self endon( #"hash_e0a6ccc389394ed9", #"death" );
    self.var_20147b315fb58d7d = utility::spawn_model( "tag_origin", self.origin );
    thread utility::delete_on_death( self.var_20147b315fb58d7d );
    self linkto( self.var_20147b315fb58d7d );
    self.var_20147b315fb58d7d moveto( self.origin + ( 0, 0, 50 ), 1.5, 1.5 );
    self.var_20147b315fb58d7d rotateto( ( -30, 0, 0 ), 1.5, 1.5 );
    self hide();
    
    if ( self asmhasstate( self.asmname, "float_in_place_in" ) )
    {
        self function_695b8e1b655c2796( "floatinplacetype", "floatinplace_base_1" );
        
        while ( true )
        {
            current_state = self asmgetcurrentstate( self.asmname );
            
            if ( current_state != "float_in_place_intro" && current_state != "float_in_place_loop" )
            {
                asm::function_7256f5ba459c840b( "float_in_place_in" );
            }
            
            wait 0.5;
        }
    }
}

// Namespace namespace_a2abfbbbd7a9852f
// Params 0, eflags: 0x4
// Checksum 0x38f6168a, Offset: 0x182c
// Size: 0xbe
function private function_24cdf85728043f90()
{
    self endon( #"death" );
    self notify( #"hash_e0a6ccc389394ed9" );
    self show();
    utility::function_7c10ea82c1e305b8( "simple_dissolve", "fade_in_long" );
    give_aura();
    self.var_20147b315fb58d7d moveto( self.origin - ( 0, 0, 50 ), 1.5, 1.5 );
    self.var_20147b315fb58d7d rotateto( ( 0, 0, 0 ), 1.5, 1.5 );
    wait 1.5;
    asm::asm_fireevent( self.asmname, "float_in_place_end" );
    self unlink();
    self.var_20147b315fb58d7d delete();
    wait 3;
}

