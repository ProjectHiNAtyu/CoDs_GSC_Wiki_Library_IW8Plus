// script_4d5690421d14cda9  (hash_4d5690421d14cda9.gscc) (size: 6624 Bytes / 0x19e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde8e996b (3733887339)
// size ...... 6624 (0x19e0)
// includes .. 8   (offset: 0x179c)
// strings ... 25  (offset: 0x17dc)
// dev strs .. 9   (offset: 0x1974)
// exports ... 14  (offset: 0xed8)
// cseg ...... 0x22c + 0xcac (0xed8)
// imports ... 54  (offset: 0x1108)
// animtree1 . 0   (offset: 0x19e0)
// animtree2 . 0   (offset: 0x19e0)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_5b988172ec655354;

// Namespace namespace_5b988172ec655354
// Params 1
// Checksum 0x9de9df97, Offset: 0x24a
// Size: 0x99
function function_6a5cc184e886746a( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "disciple_lifedrain_beam_fx", settings.var_e05fbdf5ec96877b );
        utility::add_fx( "disciple_weakpoint_hand_impact_fx", settings.var_93c6b96128e313b3 );
        utility::add_fx( "disciple_weakpoint_hand_fx", settings.var_d2ffa27cf04114a1 );
        utility::add_fx( "disciple_lifedrain_screen_fx", settings.var_bd77ea5d7624975a );
        utility::add_fx( "disciple_lifedrain_kill_fx", settings.var_a74a036d1a8e9a1a );
    }
}

// Namespace namespace_5b988172ec655354
// Params 0
// Checksum 0x65b48c7a, Offset: 0x2eb
// Size: 0x2c
function function_9461e7d5fe219c8f()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_c37e98b3183b1aa );
    
    /#
        function_e21a347a6b989723();
    #/
}

// Namespace namespace_5b988172ec655354
// Params 0
// Checksum 0xa714bc19, Offset: 0x31f
// Size: 0x2ce
function init_zombie_disciple_life_drain()
{
    if ( self getaiblackboarddynamic( "can_life_drain" ) )
    {
        self.var_61029d4328f2556a = 0;
        self.lifedrain_health_gained = 0;
        self.var_da0e147b996fa9a2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_481b810da5d0436;
        self.lifedrain_damage_player = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindamage;
        self.lifedrain_max_dist_sq = squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindistance );
        self.var_da0e147b996fa9a2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_481b810da5d0436;
        self.lifedrain_damage_player = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindamage;
        self.lifedrain_max_dist_sq = squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindistance );
        self.lifedrain_max_dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindistance;
        self.var_c92a51a0fcf5352c = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_44fbc4a4dc632dc3;
        self.lifedrain_cooldown_ms = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraincooldown * 1000;
        self.var_73eba89c3643ce9c = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_565c748dfe7fffc3 * 1000;
        self.var_755291e9e5c5f134 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d068a01a9a74f65;
        self.lifedrain_target_ent = undefined;
        self.var_b03794d45a7439ec = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c3f8f2a9c0939ae7;
        self.var_da0e147b996fa9a2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_481b810da5d0436;
        self.lifedrain_damage_player = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindamage;
        self.lifedrain_max_dist_sq = squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.lifedraindistance );
        self.var_32017d5dcb01fe57 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_32017d5dcb01fe57;
        self.var_4b3eae72f75f0ed1 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4b3eae72f75f0ed1;
        thread function_b231c30f260c4a5c();
    }
}

// Namespace namespace_5b988172ec655354
// Params 1, eflags: 0x4
// Checksum 0xdf105e20, Offset: 0x5f5
// Size: 0xeb
function private function_c37e98b3183b1aa( params )
{
    if ( self getaiblackboarddynamic( "in_life_drain" ) )
    {
        if ( isdefined( self.var_20a4a655261f6172 ) )
        {
            self.var_20a4a655261f6172 += params.idamage;
        }
        
        if ( function_e0d51d7e32e0b873( params ) )
        {
            self.var_61029d4328f2556a += params.idamage;
            self.var_1b073de8b71968f0 = params.eattacker;
            playfxontag( utility::getfx( "disciple_weakpoint_hand_impact_fx" ), self, "tag_fx_hand_ri_palm" );
            
            if ( !self.var_e3ff6b5a34e23c16 && self.var_61029d4328f2556a > self.var_da0e147b996fa9a2 * self.maxhealth )
            {
                self function_786bb6aa1b76c7ee( "life_drain_cooldown", self.lifedrain_cooldown_ms + gettime() );
                self function_786bb6aa1b76c7ee( "in_life_drain_pain", 1 );
            }
        }
    }
}

// Namespace namespace_5b988172ec655354
// Params 1, eflags: 0x4
// Checksum 0x20f271d5, Offset: 0x6e8
// Size: 0x60
function private function_1ba922360367af15( params )
{
    if ( self.var_82684d0bd77016cc && isdefined( params.body ) && params.body tagexists( "j_spine4" ) )
    {
        playfxontag( utility::getfx( "disciple_lifedrain_kill_fx" ), params.body, "j_spine4" );
    }
}

// Namespace namespace_5b988172ec655354
// Params 0, eflags: 0x4
// Checksum 0x11087033, Offset: 0x750
// Size: 0x5b
function private function_b231c30f260c4a5c()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"life_drain_loop_start" );
        utility::ent_flag_set( "playing_life_drain_anim" );
        thread function_3b648dc2aec48e02();
        self waittill( #"life_drain_loop_end" );
        utility::ent_flag_clear( "playing_life_drain_anim" );
        self function_786bb6aa1b76c7ee( "in_life_drain", 0 );
    }
}

// Namespace namespace_5b988172ec655354
// Params 0, eflags: 0x4
// Checksum 0x4f3ad140, Offset: 0x7b3
// Size: 0x5b7
function private function_3b648dc2aec48e02()
{
    level endon( #"game_ended" );
    target_ent = self.enemy;
    
    if ( isdefined( self.lifedrain_target_ent ) )
    {
        target_ent = self.lifedrain_target_ent;
    }
    
    if ( !isdefined( target_ent ) || target_ent.var_82684d0bd77016cc )
    {
        self function_786bb6aa1b76c7ee( "in_life_drain", 0 );
        return;
    }
    
    target_ent.var_82684d0bd77016cc = 1;
    self.var_20a4a655261f6172 = 0;
    self.var_61029d4328f2556a = 0;
    metabone::set_metabone_active( "hand", 1 );
    playfxontag( utility::getfx( "disciple_weakpoint_hand_fx" ), self, "tag_fx_hand_ri_palm" );
    self setscriptablepartstate( "drain_audio", "on" );
    n_damage = 0;
    
    if ( isplayer( target_ent ) )
    {
        if ( !utility::issharedfuncdefined( #"disciple", #"hash_ddbc0720466b1c3e" ) || target_ent utility::callsharedfunc( #"disciple", #"hash_ddbc0720466b1c3e" ) )
        {
            playfxontagforclients( utility::getfx( "disciple_lifedrain_screen_fx" ), target_ent, "j_head", target_ent );
        }
        
        n_damage = self.lifedrain_damage_player;
    }
    else if ( isdefined( target_ent.maxhealth ) )
    {
        target_ent callback::add( "killed_body_cloned", &function_1ba922360367af15 );
        
        if ( target_ent.aicategory == "special" || target_ent.aicategory == "hvt" || target_ent.aicategory == "elite" )
        {
            n_damage = int( min( max( self.maxhealth * 0.05, target_ent.maxhealth * 0.05 ), self.maxhealth ) );
        }
        else
        {
            n_damage = int( min( max( self.maxhealth * 0.2, target_ent.maxhealth * 0.2 ), self.maxhealth ) );
        }
    }
    
    var_54f877d904866396 = utility::spawn_model( "tag_origin", self gettagorigin( "tag_fx_hand_ri_palm" ) );
    var_54f877d904866396 linkto( self, "tag_fx_hand_ri_palm" );
    life_drain_ent = playfxontagsbetweenclients( utility::getfx( "disciple_lifedrain_beam_fx" ), var_54f877d904866396, "tag_origin", target_ent, "j_spine4" );
    
    if ( isdefined( life_drain_ent ) )
    {
        life_drain_ent namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    }
    
    n_frames = 0;
    var_3bedb22cda20613f = gettime() + 3000;
    
    while ( isalive( self ) && isalive( target_ent ) && !target_ent.inlaststand )
    {
        if ( !self.var_755291e9e5c5f134 && self.enemy != target_ent )
        {
            break;
        }
        
        dist_sq = distancesquared( target_ent.origin, self.origin );
        
        if ( dist_sq > self.lifedrain_max_dist_sq && gettime() > var_3bedb22cda20613f )
        {
            break;
        }
        
        if ( dist_sq > self.lifedrain_max_dist_sq * 3 )
        {
            break;
        }
        
        if ( !self.var_755291e9e5c5f134 && target_ent.team == self.team )
        {
            break;
        }
        
        if ( !self getaiblackboarddynamic( "in_life_drain" ) )
        {
            break;
        }
        
        if ( !trace::ray_trace_passed( self getcentroid(), target_ent getcentroid(), undefined, trace::create_default_contents( 1 ) ) )
        {
            break;
        }
        
        n_frames++;
        
        if ( n_frames == 10 )
        {
            missing_health_perc = 1 - self.health / self.maxhealth;
            base_health_healed = self.var_32017d5dcb01fe57 * self.maxhealth;
            missing_health_scalar = 1 + missing_health_perc * self.var_4b3eae72f75f0ed1;
            var_cc8d6439ddd2a313 = base_health_healed * missing_health_scalar;
            var_cc8d6439ddd2a313 += self.var_20a4a655261f6172 * self.var_c92a51a0fcf5352c;
            self.var_20a4a655261f6172 = 0;
            health_cap_percentage = zombie_disciple::function_13b9c2ec5ae3c0ab( self );
            var_cc8d6439ddd2a313 = int( min( var_cc8d6439ddd2a313, max( health_cap_percentage * self.maxhealth - self.health, 0 ) ) );
            var_1c601fd30d83455 = self.maxhealth;
            self.health += var_cc8d6439ddd2a313;
            self.maxhealth = var_1c601fd30d83455;
            self.lifedrain_health_gained += var_cc8d6439ddd2a313;
            
            if ( isagent( target_ent ) && n_damage >= target_ent.health )
            {
                target_ent.do_immediate_ragdoll = 1;
            }
            
            target_ent dodamage( n_damage, target_ent.origin, self, self, "MOD_PROJECTILE", undefined, "torso_upper" );
            n_frames = 0;
        }
        
        wait 0.05;
    }
    
    var_54f877d904866396 delete();
    life_drain_ent delete();
    
    if ( isalive( self ) && isdefined( self.var_20a4a655261f6172 ) )
    {
        self.var_61029d4328f2556a = 0;
        self.var_20a4a655261f6172 = undefined;
        self function_786bb6aa1b76c7ee( "in_life_drain", 0 );
        
        if ( !self getaiblackboarddynamic( "in_life_drain_pain" ) )
        {
            self function_786bb6aa1b76c7ee( "life_drain_cooldown", self.var_73eba89c3643ce9c + gettime() );
        }
        
        stopfxontag( utility::getfx( "disciple_weakpoint_hand_fx" ), self, "tag_fx_hand_ri_palm" );
        self setscriptablepartstate( "drain_audio", "stop" );
        metabone::set_metabone_active( "hand", 0 );
    }
    
    if ( isdefined( target_ent ) )
    {
        target_ent.var_82684d0bd77016cc = undefined;
        
        if ( isplayer( target_ent ) )
        {
            stopfxontag( utility::getfx( "disciple_lifedrain_screen_fx" ), target_ent, "j_head" );
            return;
        }
        
        target_ent callback::remove( "killed_body_cloned", &function_1ba922360367af15 );
    }
}

// Namespace namespace_5b988172ec655354
// Params 1
// Checksum 0x38b48fea, Offset: 0xd72
// Size: 0x18, Type: bool
function function_67205a7e25fe2273( entity )
{
    return istrue( entity getaiblackboarddynamic( "in_life_drain" ) );
}

// Namespace namespace_5b988172ec655354
// Params 1
// Checksum 0xc15846af, Offset: 0xd93
// Size: 0x1d, Type: bool
function function_e0d51d7e32e0b873( params )
{
    return params.metabonename == "hand";
}

/#

    // Namespace namespace_5b988172ec655354
    // Params 0, eflags: 0x4
    // Checksum 0xd9cc2287, Offset: 0xdb9
    // Size: 0x44, Type: dev
    function private function_e21a347a6b989723()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x4f>", &force_life_drain );
        devgui::add_devgui_func( "<dev string:x60>", "<dev string:x71>", &function_50b2151f5907cc6c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_5b988172ec655354
    // Params 0, eflags: 0x4
    // Checksum 0xa54142b8, Offset: 0xe05
    // Size: 0x46, Type: dev
    function private force_life_drain()
    {
        disciple = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x82>" );
        
        if ( isdefined( disciple ) )
        {
            disciple function_786bb6aa1b76c7ee( "<dev string:x92>", 1 );
        }
    }

    // Namespace namespace_5b988172ec655354
    // Params 0, eflags: 0x4
    // Checksum 0xccf11f2a, Offset: 0xe53
    // Size: 0x1a, Type: dev
    function private function_50b2151f5907cc6c()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa0>", @"hash_5ea28fb57e748699" );
    }

    // Namespace namespace_5b988172ec655354
    // Params 2, eflags: 0x4
    // Checksum 0x7201dd0f, Offset: 0xe75
    // Size: 0x63, Type: dev
    function private debug_print_life_drain( text, pos )
    {
        if ( getdvarint( @"hash_5ea28fb57e748699", 0 ) )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:xba>" + text, ( 1, 0, 0 ) );
        }
    }

#/
