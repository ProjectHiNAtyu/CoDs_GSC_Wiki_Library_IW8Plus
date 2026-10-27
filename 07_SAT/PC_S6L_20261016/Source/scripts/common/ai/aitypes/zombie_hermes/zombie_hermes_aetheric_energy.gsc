// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_aetheric_energy.gsc  (hash_0592fb75adae93a5.gscc) (size: 11880 Bytes / 0x2e68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30364a3e (808864318)
// size ...... 11880 (0x2e68)
// includes .. 11  (offset: 0x2a60)
// strings ... 47  (offset: 0x2ab8)
// dev strs .. 19  (offset: 0x2d74)
// exports ... 31  (offset: 0x1970)
// cseg ...... 0x40e + 0x1562 (0x1970)
// imports ... 100 (offset: 0x1e48)
// animtree1 . 0   (offset: 0x2e68)
// animtree2 . 0   (offset: 0x2e68)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_move;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_summon;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;

#namespace zombie_hermes_aetheric_energy;

// Namespace zombie_hermes_aetheric_energy
// Params 0
// Checksum 0xeb30c2de, Offset: 0x42c
// Size: 0x22
function function_bb4e848c26927853()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_fb927249bfe03afa );
}

// Namespace zombie_hermes_aetheric_energy
// Params 0
// Checksum 0xebcf9f95, Offset: 0x456
// Size: 0xba
function init_zombie_hermes_aetheric_energy()
{
    self.var_f4589db1c6743e1b = self.health - getdvarfloat( @"hash_72997148725f4060", 4800 );
    self.var_79c7447d5aa221fa = [];
    
    if ( !isdefined( self.var_3fb70b08726a5da0 ) )
    {
        self.var_3fb70b08726a5da0 = [ 0.82, 0.39, 0.07 ];
    }
    
    if ( !isdefined( self.var_1a69b6b0a7582d0c ) )
    {
        self.var_1a69b6b0a7582d0c = [ 1, 0.75, 0.32 ];
    }
    
    self.var_3196011060b46013 = 1;
    self.var_ad5f87eec21ab881 = 0;
    self.var_2ce10a01582b08b0 = 0;
    
    /#
        thread function_8884cd5195725316();
    #/
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0x6a37fad3, Offset: 0x518
// Size: 0x17
function get_hermes_phase( hermes )
{
    return hermes.var_3196011060b46013;
}

// Namespace zombie_hermes_aetheric_energy
// Params 2
// Checksum 0x1765fdab, Offset: 0x538
// Size: 0x1a0
function set_hermes_phase( hermes, phase )
{
    assert( phase >= 1 && phase <= 3 );
    hermes.var_3196011060b46013 = phase;
    hermes.var_b565835a1ee91398 = 0;
    hermes.var_db071f31fd6a254c = 0;
    hermes notify( #"hermes_phase_start" );
    level callback::callback( "phase_heal_tessie" );
    level callback::callback( "spawn_boss_death_urchins", { #var_f7585bfe318bec1:0 } );
    level callback::callback( "spawn_boss_barnacles", { #var_f7585bfe318bec1:0 } );
    hermes callback::callback( "new_hermes_phase", { #phase:phase } );
    hermes utility::ent_flag_set( "hermes_new_phase_set_recently" );
    hermes thread utility::ent_flag_clear_delayed( "hermes_new_phase_set_recently", 14 );
    hermes.var_2ce10a01582b08b0 = 0;
    var_28755b2381cf7597 = int( hermes.var_1a69b6b0a7582d0c[ phase - 1 ] * hermes.maxhealth );
    
    if ( hermes.health > var_28755b2381cf7597 )
    {
        hermes.health = var_28755b2381cf7597 - 1;
    }
    
    health_min = int( hermes.var_3fb70b08726a5da0[ phase - 1 ] * hermes.maxhealth );
    
    if ( hermes.health < health_min )
    {
        hermes.health = health_min + 1;
    }
    
    /#
        if ( debug_aetheric() )
        {
            iprintlnbold( "<dev string:x24>" + hermes.var_3196011060b46013 );
        }
    #/
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0xb8d1937a, Offset: 0x6e0
// Size: 0x61
function function_84e20c26b0bfba86( hermes )
{
    var_1e562e6847201882 = hermes.var_3196011060b46013 - 1;
    assert( var_1e562e6847201882 >= 0 && var_1e562e6847201882 <= 2 );
    threshold = hermes.var_3fb70b08726a5da0[ var_1e562e6847201882 ];
    return threshold * hermes.maxhealth;
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0x6f4ad135, Offset: 0x74a
// Size: 0x26
function get_hermes_gamera_spin_health_threshold( hermes )
{
    return function_84e20c26b0bfba86( hermes ) + 0.03 * hermes.maxhealth;
}

// Namespace zombie_hermes_aetheric_energy
// Params 2
// Checksum 0x8f2ffdae, Offset: 0x779
// Size: 0xa3
function function_8f74d1df92413c95( hermes, damage )
{
    assert( function_798e83d6bf762949( hermes ) || hermes utility::ent_flag( "<dev string:x37>" ) );
    hermes.var_ad5f87eec21ab881 += damage;
    hermes.var_79c7447d5aa221fa = function_5713d46873b29625( hermes.var_79c7447d5aa221fa );
    
    if ( function_4fd93d1d3fcae3e6( hermes ) )
    {
        hermes.var_ad5f87eec21ab881 = 0;
        
        if ( randomfloat( 1 ) < getdvarfloat( @"hash_3a7da2a34923370", 1 ) )
        {
            thread spawn_aetheric_energy();
        }
    }
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0x38f6bc3f, Offset: 0x824
// Size: 0x5d, Type: bool
function function_4fd93d1d3fcae3e6( hermes )
{
    if ( function_798e83d6bf762949( hermes ) || hermes utility::ent_flag( "hermes_gamera_spin_immune" ) )
    {
        if ( hermes.var_ad5f87eec21ab881 > getdvarfloat( @"hash_72997148725f4060", 4800 ) && hermes.var_79c7447d5aa221fa.size <= 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_hermes_aetheric_energy
// Params 1, eflags: 0x4
// Checksum 0x751970a3, Offset: 0x88a
// Size: 0xb4
function private function_fb927249bfe03afa( dmg_struct )
{
    if ( self.health / self.maxhealth < ( self.var_1a69b6b0a7582d0c[ self.var_3196011060b46013 ] ?? 0 ) )
    {
        set_hermes_phase( self, self.var_3196011060b46013 + 1 );
    }
    
    if ( arraycontains( [ "MOD_CRUSH", "MOD_MELEE_ALIEN" ], dmg_struct.smeansofdeath ) && dmg_struct.eattacker.var_b6a3f46ec4332fd8 && dmg_struct.idamage >= 100 )
    {
        dmg_struct.eattacker notify( #"vehicle_collide_hermes" );
    }
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0x47562221, Offset: 0x946
// Size: 0x8e, Type: bool
function function_798e83d6bf762949( hermes )
{
    phase = hermes.var_3196011060b46013;
    var_35069c22d08b1f24 = hermes.health / hermes.maxhealth;
    health_pct_max = hermes.var_3fb70b08726a5da0[ phase - 1 ];
    health_pct_min = hermes.var_1a69b6b0a7582d0c[ phase ] ?? 0;
    
    if ( var_35069c22d08b1f24 <= health_pct_max && var_35069c22d08b1f24 >= health_pct_min )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0xde8180b5, Offset: 0x9dd
// Size: 0x6e
function function_c11303ef88c3dd( hermes )
{
    phase = hermes.var_3196011060b46013;
    var_35069c22d08b1f24 = hermes.health / hermes.maxhealth;
    health_pct_min = hermes.var_1a69b6b0a7582d0c[ phase ] ?? 0;
    return hermes.maxhealth * health_pct_min;
}

// Namespace zombie_hermes_aetheric_energy
// Params 1, eflags: 0x4
// Checksum 0x46cbbc4b, Offset: 0xa54
// Size: 0x76
function private function_241c8d37369574e6( veh )
{
    veh endon( #"death" );
    var_65f8be6f30d4b3fa = 10;
    var_8b6b1e531818c4ff = veh vehicle_gettopspeedforward();
    var_433b39112f3e7d60 = int( var_8b6b1e531818c4ff + var_65f8be6f30d4b3fa );
    veh vehicle_settopspeedforward( var_433b39112f3e7d60 );
    veh utility::ent_flag_waitopen_any( "aetheric_energy_imbued" );
    var_8b6b1e531818c4ff = veh vehicle_gettopspeedforward();
    veh vehicle_settopspeedforward( int( var_8b6b1e531818c4ff - var_65f8be6f30d4b3fa ) );
}

// Namespace zombie_hermes_aetheric_energy
// Params 0, eflags: 0x4
// Checksum 0xbd8e74be, Offset: 0xad2
// Size: 0x693
function private spawn_aetheric_energy()
{
    energy = utility::spawn_model( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_32b49049ed833a64, self.origin );
    energy endon( #"death" );
    
    if ( isdefined( energy ) )
    {
        self.var_79c7447d5aa221fa[ self.var_79c7447d5aa221fa.size ] = energy;
        level callback::callback( "hermes_aetheric_energy_spawned", { #var_e3b7316c4c6ad3f9:0, #energy_ref:energy } );
        point1 = self getcentroid();
        var_9c4f598d397698f8 = 50;
        target_pos = undefined;
        
        if ( self.arena_center_pos )
        {
            var_5d51aba2f200e7b3 = get_nearby_wonder_veh( energy.origin, 2000 );
            
            if ( !isdefined( var_5d51aba2f200e7b3 ) )
            {
                var_5d51aba2f200e7b3 = self;
            }
            
            var_2dccb89a9888ab5 = self.arena_center_pos + vectornormalize2( self.arena_center_pos - var_5d51aba2f200e7b3.origin ) * 500;
            aetheric_spots = utility::getstructarray( "boss_aetheric_loc", "script_noteworthy" );
            
            if ( isarray( aetheric_spots ) )
            {
                var_ed92d3edd3eded9 = function_b21056d585c710d( aetheric_spots, var_2dccb89a9888ab5 );
                target_pos = var_ed92d3edd3eded9.origin;
            }
            else
            {
                target_pos = var_2dccb89a9888ab5;
            }
        }
        else
        {
            side_angle = self.angles;
            side_angle += ( 0, randomintrange( -45, 45 ), 0 ) + ( 0, utility::array_random( [ -90, 90 ] ), 0 );
            random_dir = anglestoforward( side_angle );
            target_pos = point1 - ( 0, 0, 100 ) + random_dir * 500;
        }
        
        target_pos = getgroundposition( target_pos, 10, 1000 ) - ( 0, 0, var_9c4f598d397698f8 );
        assert( isdefined( target_pos ) );
        var_3292d7458c3fce28 = vectornormalize( target_pos - point1 );
        var_78c1cff37056d75d = length( target_pos - point1 );
        point2 = point1 + ( 0, 0, 500 ) + var_3292d7458c3fce28 * var_78c1cff37056d75d * 0.33;
        point3 = point2 + ( 0, 0, -200 ) + var_3292d7458c3fce28 * var_78c1cff37056d75d * 0.33;
        time_s = getdvarfloat( @"hash_137431233d88d8c5", 3 );
        energy utility::function_2159dd4196ff4b81( [ point1, point2, point3, target_pos ], time_s, 0, 1, 0, 0.5, 0.5, 0 );
        energy.origin = target_pos + ( 0, 0, var_9c4f598d397698f8 );
        energy utility::function_32b24db3127bff40( "target", "ground" );
        energy utility::function_32b24db3127bff40( "objective", "on" );
        var_1281c381733f5f67 = gettime() + getdvarfloat( @"hash_9b4e93afe7be7fcb", 10000 );
        nearby_veh = undefined;
        
        while ( true )
        {
            if ( gettime() > var_1281c381733f5f67 )
            {
                energy thread function_d3e828ccb0f4f35();
                return;
            }
            
            nearby_veh = get_nearby_wonder_veh( energy.origin, 200 );
            
            if ( isdefined( nearby_veh ) && !nearby_veh utility::ent_flag( "aetheric_energy_imbued" ) )
            {
                break;
            }
            
            waitframe();
        }
        
        nearby_veh utility::ent_flag_set( "aetheric_energy_imbued" );
        level callback::callback( "vo_boss_aetheric_energy_pickup" );
        nearby_veh utility::function_32b24db3127bff40( "aetheric_energy", "on" );
        nearby_veh thread function_241c8d37369574e6( nearby_veh );
        nearby_veh vehicle_damage::set_health( nearby_veh.health + 0.05 * nearby_veh.maxhealth );
        level callback::callback( "vehicle_aetheric_energy_imbued", { #vehicle:nearby_veh } );
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( nearby_veh, 0 );
        
        foreach ( occupant in occupants )
        {
            occupant.health = occupant.maxhealth;
            occupant damage_effects::onexitdeathsdoor( 1 );
        }
        
        energy linkto( nearby_veh, "tag_canister_2", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        energy utility::function_32b24db3127bff40( "target", "off" );
        msg = nearby_veh utility::waittill_notify_or_timeout_return( "vehicle_collide_hermes", 15 );
        
        if ( msg == "timeout" )
        {
            if ( isdefined( nearby_veh ) )
            {
                nearby_veh utility::ent_flag_clear( "aetheric_energy_imbued" );
                nearby_veh utility::function_32b24db3127bff40( "aetheric_energy", "transition_to_off" );
            }
            
            energy delete();
            self.var_2ce10a01582b08b0++;
            return;
        }
        
        energy utility::function_32b24db3127bff40( "target", "off" );
        radiusdamage( nearby_veh.origin, 200, 100, 100 );
        hit_hermes = 0;
        nearby_hermes = zombie_utils::get_closest_zombie( nearby_veh.origin, undefined, "zombie_hermes" );
        
        if ( isdefined( nearby_hermes ) && distance( nearby_hermes.origin, nearby_veh.origin ) < 1000 )
        {
            if ( function_798e83d6bf762949( nearby_hermes ) || nearby_hermes utility::ent_flag( "hermes_gamera_spin_immune" ) )
            {
                thread zombie_hermes_move::function_5308069777f513f1( nearby_hermes, 1 );
            }
            
            stun_hermes( nearby_hermes );
            hit_hermes = 1;
            nearby_hermes dodamage( nearby_hermes.maxhealth * 0.01, nearby_veh.origin, nearby_veh, nearby_veh, "MOD_EXPLOSIVE", "<explicitweaponnone>", "torso_upper" );
            level callback::callback( "vo_boss_aetheric_energy_attack" );
        }
        
        if ( isdefined( nearby_veh ) )
        {
            nearby_veh utility::ent_flag_clear( "aetheric_energy_imbued" );
            nearby_veh utility::function_32b24db3127bff40( "aetheric_energy", "off" );
        }
        
        if ( hit_hermes )
        {
            foreach ( var_e032bbc96af90e2d in self.var_79c7447d5aa221fa )
            {
                if ( var_e032bbc96af90e2d )
                {
                    var_e032bbc96af90e2d delete();
                }
            }
        }
        
        wait 3;
        energy delete();
    }
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0x75e047bd, Offset: 0x116d
// Size: 0x1d, Type: bool
function is_stunned( hermes )
{
    return ( hermes getaiblackboarddynamic( "hermes_stunned" ) ?? 0 ) > 0;
}

// Namespace zombie_hermes_aetheric_energy
// Params 1
// Checksum 0x92b14ad6, Offset: 0x1193
// Size: 0x19
function is_recently_stunned( hermes )
{
    return hermes utility::ent_flag( "hermes_stunned_recently" );
}

// Namespace zombie_hermes_aetheric_energy
// Params 1, eflags: 0x4
// Checksum 0x423c97e5, Offset: 0x11b5
// Size: 0x62
function private stun_hermes( hermes )
{
    hermes function_786bb6aa1b76c7ee( "hermes_stunned", 1 );
    hermes utility::ent_flag_set( "hermes_stunned_recently" );
    hermes thread function_d4b93c6a0c5b8bc1( hermes );
    zombie_hermes_metabones::function_5ae8f1abadd9aea6( hermes, 1 );
    hermes notify( #"hash_ce9a5bbc5b4c6bd" );
    hermes callback::callback( "on_hermes_stunned" );
    hermes thread function_8358515db98dbaf3( hermes );
}

// Namespace zombie_hermes_aetheric_energy
// Params 1, eflags: 0x4
// Checksum 0x2cd2b218, Offset: 0x121f
// Size: 0x58
function private function_d4b93c6a0c5b8bc1( hermes )
{
    wait 2;
    
    if ( !isalive( hermes ) || !is_stunned( hermes ) )
    {
        return;
    }
    
    hermes utility::ent_flag_clear( "hermes_stunned_recently" );
    hermes utility::function_32b24db3127bff40( "belly", "exposed" );
    hermes metabone::set_metabone_active( "belly", 1 );
}

// Namespace zombie_hermes_aetheric_energy
// Params 1, eflags: 0x4
// Checksum 0x98701654, Offset: 0x127f
// Size: 0x152
function private function_8358515db98dbaf3( hermes )
{
    hermes endon( #"death" );
    var_5b4eff275b24247d = hermes utility::waittill_any_in_array_or_timeout_no_endon_death( [ "hermes_phase_start", "fake_death" ], getdvarfloat( @"hash_66e92c75581e24f4", 10 ) );
    is_fake_death = var_5b4eff275b24247d == "fake_death";
    
    if ( var_5b4eff275b24247d == "timeout" )
    {
        hermes utility::function_32b24db3127bff40( "belly", "off" );
        hermes function_695b8e1b655c2796( "stun_outro", "stun_timeout" );
    }
    else
    {
        hermes utility::function_32b24db3127bff40( "belly", "explode" );
        hermes zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_le", 1 );
        hermes zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_ri", 1 );
        
        if ( !is_fake_death )
        {
            hermes function_695b8e1b655c2796( "stun_outro", "stun_phase_transition" );
            hermes function_786bb6aa1b76c7ee( "hermes_animation_movement", 1 );
            hermes thread function_a21cfc17f6e6bc1a();
            hermes thread function_6a0f7f3ef5141f02();
        }
    }
    
    hermes function_f2df0257c63f229( "hermes_stunned" );
    hermes utility::ent_flag_clear( "hermes_stunned_recently" );
    zombie_hermes_metabones::function_5ae8f1abadd9aea6( hermes, 0 );
    hermes metabone::set_metabone_active( "belly", 0 );
    
    if ( var_5b4eff275b24247d == "fake_death" )
    {
        return;
    }
    
    if ( function_798e83d6bf762949( hermes ) )
    {
        zombie_hermes_move::function_7115fba9ef789d9( hermes );
    }
}

// Namespace zombie_hermes_aetheric_energy
// Params 0, eflags: 0x4
// Checksum 0x82eb2149, Offset: 0x13d9
// Size: 0x43
function private function_a21cfc17f6e6bc1a()
{
    self endon( #"death" );
    utility::waittill_notify_or_timeout( "stun_outro_end", 20 );
    self function_f2df0257c63f229( "hermes_animation_movement" );
    zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_le", 0 );
    zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_ri", 0 );
}

// Namespace zombie_hermes_aetheric_energy
// Params 0, eflags: 0x4
// Checksum 0x175dd418, Offset: 0x1424
// Size: 0xf2
function private function_6a0f7f3ef5141f02()
{
    self endon( #"death" );
    msg = utility::waittill_notify_or_timeout_return( "hermes_phase_transition_roar", 6 );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    nearby_players = getplayersinradius( self.origin, 5000 );
    
    foreach ( player in nearby_players )
    {
        player earthquakeforplayer( 0.25, 6, self.origin, 5000 );
        player playrumbleonentity( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_831d78df774c04df );
    }
}

// Namespace zombie_hermes_aetheric_energy
// Params 2, eflags: 0x4
// Checksum 0xc64c7294, Offset: 0x151e
// Size: 0xbb
function private get_nearby_wonder_veh( origin, radius )
{
    vehiclelist = getentarrayinradius( "script_vehicle", #classname, origin, radius );
    
    foreach ( veh in vehiclelist )
    {
        if ( !isalive( veh ) )
        {
            continue;
        }
        
        if ( veh.var_b6a3f46ec4332fd8 )
        {
            return veh;
        }
    }
}

// Namespace zombie_hermes_aetheric_energy
// Params 0, eflags: 0x4
// Checksum 0xfc61f836, Offset: 0x15e1
// Size: 0x41
function private function_d3e828ccb0f4f35()
{
    self endon( #"delete" );
    level callback::callback( "hermes_aetheric_energy_spawned", { #var_e3b7316c4c6ad3f9:1 } );
    utility::function_32b24db3127bff40( "objective", "off" );
    wait 5;
    self delete();
}

// Namespace zombie_hermes_aetheric_energy
// Params 0, eflags: 0x4
// Checksum 0xf30b9cee, Offset: 0x162a
// Size: 0x12, Type: bool
function private debug_aetheric()
{
    return getdvarint( @"hash_448e1a9b2bc3e358", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_aetheric_energy
    // Params 0, eflags: 0x4
    // Checksum 0x2bab9947, Offset: 0x1645
    // Size: 0xc5, Type: dev
    function private function_8884cd5195725316()
    {
        devgui::function_9082edeb5db93280( "<dev string:x51>" );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x7f>", &function_719296a4e977a94e, 1 );
        devgui::add_devgui_func( "<dev string:x95>", "<dev string:xa1>", &function_9966ae1c6149a31c );
        devgui::add_devgui_func( "<dev string:xad>", "<dev string:xc3>", &function_7b1c0ea73b736c58 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe0>", "<dev string:xef>", &function_9ded70dac91167b4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x102>", "<dev string:x111>", &function_9ded70dac91167b4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x124>", "<dev string:x133>", &function_9ded70dac91167b4 );
        devgui::add_devgui_func( "<dev string:x146>", "<dev string:x15d>", &function_bab1995cc1bb8c11 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_aetheric() )
        {
            level thread function_29801c122c6c95f9();
        }
    }

    // Namespace zombie_hermes_aetheric_energy
    // Params 1, eflags: 0x4
    // Checksum 0x768aad2, Offset: 0x1712
    // Size: 0x44, Type: dev
    function private function_719296a4e977a94e( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x17b>", @"hash_448e1a9b2bc3e358" );
        
        if ( debug_aetheric() )
        {
            level thread function_29801c122c6c95f9();
            return;
        }
        
        level notify( #"hash_6da59deedb19e38" );
    }

    // Namespace zombie_hermes_aetheric_energy
    // Params 0, eflags: 0x4
    // Checksum 0xefc0a0f4, Offset: 0x175e
    // Size: 0x43, Type: dev
    function private function_7b1c0ea73b736c58()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x191>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        hermes thread spawn_aetheric_energy();
    }

    // Namespace zombie_hermes_aetheric_energy
    // Params 0, eflags: 0x4
    // Checksum 0xc956aa92, Offset: 0x17a9
    // Size: 0x43, Type: dev
    function private function_9966ae1c6149a31c()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x191>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        stun_hermes( hermes );
    }

    // Namespace zombie_hermes_aetheric_energy
    // Params 1, eflags: 0x4
    // Checksum 0x6ebf79bb, Offset: 0x17f4
    // Size: 0x5f, Type: dev
    function private function_9ded70dac91167b4( params )
    {
        phase = int( params[ 0 ] );
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x191>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        set_hermes_phase( hermes, phase );
    }

    // Namespace zombie_hermes_aetheric_energy
    // Params 1, eflags: 0x4
    // Checksum 0x65a316a, Offset: 0x185b
    // Size: 0xbb, Type: dev
    function private function_bab1995cc1bb8c11( params )
    {
        phase = params ? int( params[ 0 ] ) : undefined;
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x191>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        hermes.health = hermes.maxhealth;
        set_hermes_phase( hermes, 3 );
        wait 1;
        stun_hermes( hermes );
        wait 5;
        hermes.health = int( hermes.maxhealth * 0.5 );
        set_hermes_phase( hermes, 2 );
    }

    // Namespace zombie_hermes_aetheric_energy
    // Params 0, eflags: 0x4
    // Checksum 0x82e24184, Offset: 0x191e
    // Size: 0x52, Type: dev
    function private function_29801c122c6c95f9()
    {
        level endon( #"hash_6da59deedb19e38" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x191>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            waitframe();
        }
    }

#/
