// scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_holographic_attraction.gsc  (hash_40ca76e11d7c33b5.gscc) (size: 6529 Bytes / 0x1981 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x928e3842 (2458794050)
// size ...... 6529 (0x1981)
// includes .. 3   (offset: 0x17ed)
// strings ... 22  (offset: 0x1805)
// dev strs .. 0   (offset: 0x1981)
// exports ... 18  (offset: 0xe7d)
// cseg ...... 0x204 + 0xc79 (0xe7d)
// imports ... 56  (offset: 0x114d)
// animtree1 . 0   (offset: 0x1981)
// animtree2 . 0   (offset: 0x1981)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_galileo_holographic_attraction;

// Namespace zombie_galileo_holographic_attraction
// Params 0
// Checksum 0xa3f5a1bc, Offset: 0x222
// Size: 0x56
function function_3cbb35fca89f7320()
{
    level callback::add( #"player_damaged", &on_player_damaged );
    level callback::add( #"player_laststand", &on_player_laststand_enter );
    level callback::add( #"on_used_super", &function_6c2eba803f44e3f );
    level callback::add( "on_gobblegum_used", &function_20e8f24d6b63cfae );
}

// Namespace zombie_galileo_holographic_attraction
// Params 0
// Checksum 0xb4740f1d, Offset: 0x280
// Size: 0xe0
function init_zombie_galileo_holographic_attraction()
{
    galileo_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    assert( isdefined( galileo_settings ) );
    self.hologram_settings = { #drone_speed:galileo_settings.var_1abdbf85ebb9041b, #var_a8bbd6ad54a5cfb2:int( utility::function_4b74c15943231980( galileo_settings.var_edd0b7a299413b8a ) ), #drone_weapon:galileo_settings.var_e2f638b83970d224, #attraction_radius:galileo_settings.var_15a5500837b321cd, #attraction_duration:galileo_settings.var_fafe937860dfe12b };
    
    if ( galileo_settings.var_705a418c9b43eca7 )
    {
        self.hologram_settings.attraction_postfx = getxhashasset( galileo_settings.var_705a418c9b43eca7 );
    }
    
    self.var_f0ad3eb1431e0b9e = 1;
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0x4
// Checksum 0x4ad70f68, Offset: 0x368
// Size: 0x8c
function private on_player_damaged( params )
{
    attacker = params.eattacker;
    weapon = params.objweapon;
    
    if ( attacker.subclass == "zombie_galileo" && weapon.basename == attacker.hologram_settings.drone_weapon )
    {
        if ( function_46b673435b509b90() )
        {
            thread function_36fa2c83f9b613db( attacker.hologram_settings );
        }
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 1
// Checksum 0xf417b855, Offset: 0x3fc
// Size: 0x51
function on_player_laststand_enter( params )
{
    if ( params.attacker.game_over_scene_subclass && params.attacker.game_over_scene_subclass == "zombie_galileo" )
    {
        self.var_c36cb8f36e9afca1 = "zombie_galileo";
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 0, eflags: 0x4
// Checksum 0x49e72e3e, Offset: 0x455
// Size: 0x1e, Type: bool
function private function_46b673435b509b90()
{
    return !utility::ent_flag( "galileo_holographic_attraction" ) && !utility::ent_flag( "clear_holographic_attraction" );
}

// Namespace zombie_galileo_holographic_attraction
// Params 0, eflags: 0x4
// Checksum 0xfc78e3c6, Offset: 0x47c
// Size: 0x1c
function private clear_holographic_attraction()
{
    utility::ent_flag_set( "clear_holographic_attraction" );
    utility::ent_flag_clear_delayed( "clear_holographic_attraction", 2 );
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0x4
// Checksum 0xc1ceab69, Offset: 0x4a0
// Size: 0x72
function private function_6c2eba803f44e3f( params )
{
    if ( isplayer( params.player ) )
    {
        var_e93a67c34276fb3f = params.superinfo.staticdata.ref;
        
        if ( var_e93a67c34276fb3f == "super_aether_shroud" || var_e93a67c34276fb3f == "super_healing_aura" )
        {
            params.player clear_holographic_attraction();
        }
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0x4
// Checksum 0xd8292149, Offset: 0x51a
// Size: 0x30
function private function_20e8f24d6b63cfae( params )
{
    if ( isplayer( self ) && params.name == "idle_eyes" )
    {
        clear_holographic_attraction();
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0xc
// Checksum 0xe0879218, Offset: 0x552
// Size: 0xe1
function private function_36fa2c83f9b613db( settings )
{
    self notify( #"hash_fb56b97b5652306" );
    self endon( #"hash_fb56b97b5652306" );
    postfx = settings.attraction_postfx;
    duration = settings.attraction_duration;
    radius = settings.attraction_radius;
    
    if ( isxhashasset( postfx ) )
    {
        pbgpostfxbundlestart( self, postfx );
    }
    
    utility::function_32b24db3127bff40( "galileo_holographic_attraction", "on" );
    utility::ent_flag_set( "galileo_holographic_attraction" );
    thread attract_nearby_zombies( radius );
    utility::waittill_any_timeout( duration, "death_or_disconnect", "clear_holographic_attraction" );
    
    if ( self )
    {
        if ( isxhashasset( postfx ) )
        {
            pbgpostfxbundleend( self, postfx );
        }
        
        utility::function_32b24db3127bff40( "galileo_holographic_attraction", "off_with_audio" );
        utility::ent_flag_clear( "galileo_holographic_attraction" );
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 0, eflags: 0x4
// Checksum 0x9b1ba97b, Offset: 0x63b
// Size: 0x84
function private function_2193247cb223c7b3()
{
    var_a0ba2bd8aec21d38 = self._blackboard.movetype;
    
    switch ( var_a0ba2bd8aec21d38 )
    {
        case #"hash_eb06fed69a41dab5":
            if ( !level.gametypebundle.var_25934546ad2751f3 )
            {
                return "super_sprint";
            }
        case #"hash_9710f96c58beeaaa":
            return "sprint";
        case #"hash_bdea5e7441323370":
        default:
            return "run";
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0xc
// Checksum 0x547d227, Offset: 0x6c7
// Size: 0x20e
function private attract_nearby_zombies( radius )
{
    self notify( #"hash_35553d3ae967fea2" );
    self endon( #"hash_35553d3ae967fea2" );
    self endon( #"death_or_disconnect", #"clear_holographic_attraction" );
    
    while ( true )
    {
        nearby_agents = getaiarrayinradius( self.origin, radius );
        
        foreach ( agent in nearby_agents )
        {
            if ( !isalive( agent ) || agent.team == self.team || agent function_6e9854c98dd1fed7() )
            {
                continue;
            }
            
            if ( !isdefined( agent.var_a85f7cad343712eb ) )
            {
                agent.var_a85f7cad343712eb = [];
            }
            
            current_target = undefined;
            
            foreach ( target in agent.var_a85f7cad343712eb )
            {
                if ( target.entity == self )
                {
                    current_target = target;
                    break;
                }
            }
            
            if ( !current_target )
            {
                current_target = { #entity:self };
                agent.var_a85f7cad343712eb[ agent.var_a85f7cad343712eb.size ] = current_target;
            }
            
            current_target.expiration_time = gettime() + int( utility::function_4b74c15943231980( 1.1 ) );
            
            if ( !agent utility::ent_flag( "galileo_hologram_attracted" ) )
            {
                agent thread function_e21db50fd03302aa( radius );
            }
        }
        
        wait 1;
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 0, eflags: 0x4
// Checksum 0xe9f3a26e, Offset: 0x8dd
// Size: 0x49, Type: bool
function private function_6e9854c98dd1fed7()
{
    if ( self.var_f0ad3eb1431e0b9e )
    {
        return true;
    }
    
    if ( self.target_attractor )
    {
        if ( self.target_attractor.source.equipmentref == "equip_decoy" )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0x4
// Checksum 0xa9183d10, Offset: 0x92f
// Size: 0x234
function private function_e21db50fd03302aa( attraction_radius )
{
    self endon( #"death" );
    utility::ent_flag_set( "galileo_hologram_attracted" );
    self.ignore_decoy = 1;
    var_1b16c1eacdf7e00 = function_2193247cb223c7b3();
    zombie_utils::function_a8ce00e0448cb6f0( var_1b16c1eacdf7e00, "galileo_hologram_attracted", 32 );
    
    while ( true )
    {
        current_time = gettime();
        var_c127d6dcc18f3fe5 = [];
        
        foreach ( target in self.var_a85f7cad343712eb )
        {
            if ( !isalive( target.entity ) || !target.entity utility::ent_flag( "galileo_holographic_attraction" ) )
            {
                continue;
            }
            
            if ( current_time >= target.expiration_time )
            {
                continue;
            }
            
            var_c127d6dcc18f3fe5[ var_c127d6dcc18f3fe5.size ] = target.entity;
        }
        
        if ( var_c127d6dcc18f3fe5.size > 0 && !function_6e9854c98dd1fed7() )
        {
            if ( var_c127d6dcc18f3fe5.size > 1 )
            {
                best_target = function_47c86977a18df38b( var_c127d6dcc18f3fe5, self.origin, attraction_radius );
            }
            else
            {
                best_target = var_c127d6dcc18f3fe5[ 0 ];
            }
            
            self.game_over_scene_subclass = "zombie_galileo";
            zombie_utils::set_ai_target_priority( best_target, "galileo_hologram_attracted", 100 );
            utility::function_32b24db3127bff40( "galileo_hologram_attracted", "on" );
            
            if ( !callback::exists( "on_zombie_ai_killed", &function_c7ca44fd7c95371d ) )
            {
                callback::add( "on_zombie_ai_killed", &function_c7ca44fd7c95371d );
            }
        }
        else
        {
            self.game_over_scene_subclass = undefined;
            zombie_utils::function_a8ce00e0448cb6f0( undefined, "galileo_hologram_attracted" );
            zombie_utils::set_ai_target_priority( undefined, "galileo_hologram_attracted" );
            utility::function_32b24db3127bff40( "galileo_hologram_attracted", "off" );
            self.var_a85f7cad343712eb = undefined;
            self.ignore_decoy = undefined;
            callback::remove( "on_zombie_ai_killed", &function_c7ca44fd7c95371d );
            utility::ent_flag_clear( "galileo_hologram_attracted" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0x4
// Checksum 0x232901c5, Offset: 0xb6b
// Size: 0x1d
function private function_c7ca44fd7c95371d( params )
{
    utility::function_32b24db3127bff40( "galileo_hologram_attracted", "off" );
}

// Namespace zombie_galileo_holographic_attraction
// Params 2
// Checksum 0xe4edb881, Offset: 0xb90
// Size: 0x17b
function function_8d4a4d7e5ef60898( taskid, params )
{
    if ( self getaiblackboarddynamic( "is_launching_holographic_drone" ) )
    {
        return anim.running;
    }
    
    utility::function_32b24db3127bff40( #"holographic_drone", "off" );
    
    if ( self isintraverse() )
    {
        return anim.failure;
    }
    
    current_time = gettime();
    
    if ( current_time < self.var_d7c338f995ae9117 )
    {
        return anim.failure;
    }
    
    potential_enemies = self function_f017e352a29a57a1( self.origin, 1024, 1 );
    
    if ( potential_enemies.size > 0 )
    {
        hologram_target = undefined;
        
        foreach ( enemy in potential_enemies )
        {
            if ( !isalive( enemy ) || !isplayer( enemy ) || enemy.var_c966b63c8a2e3877 )
            {
                continue;
            }
            
            if ( !enemy function_46b673435b509b90() )
            {
                continue;
            }
            
            if ( self cansee( enemy ) )
            {
                hologram_target = enemy;
                break;
            }
        }
        
        if ( hologram_target )
        {
            thread launch_holographic_drone( hologram_target );
            return anim.running;
        }
    }
    
    return anim.success;
}

// Namespace zombie_galileo_holographic_attraction
// Params 2
// Checksum 0xb31f34ca, Offset: 0xd14
// Size: 0x20
function function_8db245ae4ac76e00( taskid, params )
{
    self function_f2df0257c63f229( "is_launching_holographic_drone" );
}

// Namespace zombie_galileo_holographic_attraction
// Params 1, eflags: 0x4
// Checksum 0x6833bff5, Offset: 0xd3c
// Size: 0x141
function private launch_holographic_drone( hologram_target )
{
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "is_launching_holographic_drone", 1 );
    utility::function_7c10ea82c1e305b8( #"holographic_drone", "tell" );
    wait 0.5;
    
    if ( isalive( hologram_target ) && withinfov( self.origin, self.angles, hologram_target.origin, 0.5 ) )
    {
        target_location = hologram_target getcentroid();
        launcher_location = self gettagorigin( "j_spine4" );
        drone_velocity = vectornormalize( target_location - launcher_location ) * self.hologram_settings.drone_speed;
        utility::function_7c10ea82c1e305b8( #"holographic_drone", "fire" );
        
        if ( self.hologram_settings.drone_weapon )
        {
            magicgrenademanual( "sat_zombie_galileo_holographic_drone", launcher_location, drone_velocity, 5, self );
        }
        
        wait 0.5;
    }
    
    utility::function_7c10ea82c1e305b8( #"holographic_drone", "off" );
    self.var_d7c338f995ae9117 = gettime() + self.hologram_settings.var_a8bbd6ad54a5cfb2;
    self function_f2df0257c63f229( "is_launching_holographic_drone" );
}

