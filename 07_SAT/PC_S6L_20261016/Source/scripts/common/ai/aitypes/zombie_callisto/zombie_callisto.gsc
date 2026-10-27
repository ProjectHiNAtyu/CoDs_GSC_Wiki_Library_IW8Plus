// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto.gsc  (hash_7b3e7d847ba7ba7c.gscc) (size: 10206 Bytes / 0x27de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd472c7c (222768252)
// size ...... 10206 (0x27de)
// includes .. 19  (offset: 0x23be)
// strings ... 64  (offset: 0x2456)
// dev strs .. 0   (offset: 0x27de)
// exports ... 28  (offset: 0x13b2)
// cseg ...... 0x4e1 + 0xed1 (0x13b2)
// imports ... 97  (offset: 0x1812)
// animtree1 . 0   (offset: 0x27de)
// animtree2 . 0   (offset: 0x27de)
#using script_5dc2c78e95ce5a77;
#using script_7c2e89079a7b7f97;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_audio;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_claw_attack;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_medal;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_melee_mode;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_roar;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_vehicle_attack;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_wound;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_zombees;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace zombie_callisto;

// Namespace zombie_callisto
// Params 2
// Checksum 0x8745f0ab, Offset: 0x4ff
// Size: 0x5d
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "callisto_weakpoint_impact_fx", settings.weakpointvfx );
        utility::add_fx( "callisto_armored_impact_fx", settings.armoredvfx );
    }
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x3890bbd6, Offset: 0x564
// Size: 0x1d6
function private function_cfbb84b3d7bc65b8( params )
{
    zombie_callisto_audio::function_82e9556dc07c7882();
    zombie_melee::init_zombie_melee_global();
    zombie_callisto_claw_attack::function_24effdc384d55c98();
    namespace_7bf9c7d90634c36f::function_bb5e0c5b7f749444();
    zombie_callisto_roar::function_2add3f1f5708b07c();
    zombie_callisto_zombees::function_480aceb42c1bc321();
    zombie_callisto_zombeehive::function_8086ecde4f36a364();
    zombie_callisto_wound::function_b845eaef22236e9();
    zombie_callisto_melee_mode::function_3aa66d7f880a42de();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( #"long_teleport", &function_aa62e405eca3c0f5 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_4caf5b9134c00a31 );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_16751232a9e10970 );
    zombie_callisto_medal::function_8d0fb4f96269b349();
}

// Namespace zombie_callisto
// Params 1
// Checksum 0x8748663d, Offset: 0x742
// Size: 0x164
function function_b7a9383cfa4294b7( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    zombie_melee::init_zombie_melee();
    zombie_callisto_audio::init_zombie_callisto_audio();
    zombie_callisto_claw_attack::init_zombie_callisto_claw_attack();
    namespace_7bf9c7d90634c36f::function_6e0aee664486fa7a();
    zombie_callisto_roar::init_zombie_callisto_roar();
    zombie_callisto_zombees::init_zombie_callisto_zombees();
    zombie_callisto_zombeehive::function_f79343a86c2508da();
    zombie_callisto_wound::init_zombie_callisto_wound();
    zombie_callisto_vehicle_attack::init_zombie_callisto_vehicle_attack();
    zombie_ranged_attack::init_zombie_ranged_attack();
    thread initscriptable();
    val::set( "callisto_pain", "pain", 0 );
    val::set( "spawn_healthbar_suppress", "show_healthbar", 0 );
    thread function_faa0dd880eca331c();
    self pushplayer( 0 );
    self function_ff32ea59b2119107();
    self.var_34257b16d1050bab = 0;
    
    if ( getdvarint( @"hash_22e120690232d8bf", 0 ) )
    {
        self.var_2726e44ca10e0a06 = 0;
    }
    
    self.var_81239cbfa6fb7d8b = &function_a943c725a8657266;
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.meleemode )
    {
        zombie_callisto_melee_mode::function_e70a98b820ac4d10();
    }
    
    thread update_headlook();
    thread function_583fcb0921e96869();
    
    if ( level.var_b9b5070bae70d850 )
    {
        thread function_8ee8e1211b34de95();
    }
    
    return anim.success;
}

// Namespace zombie_callisto
// Params 0
// Checksum 0x13e42e6e, Offset: 0x8af
// Size: 0x45
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    
    if ( self isscriptable() )
    {
        prepare_spawn_reveal();
        thread spawn_reveal();
    }
}

// Namespace zombie_callisto
// Params 1
// Checksum 0xf209cf59, Offset: 0x8fc
// Size: 0x2e
function function_4b705a0e1a9137e8( value )
{
    self function_786bb6aa1b76c7ee( "zombeesattack_canattack", value ? 1 : 0 );
    self.var_ea0339471f98d3c7 = !value;
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x9f0b4c57, Offset: 0x932
// Size: 0x15e
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        if ( self.forceannihilate )
        {
            body endon( #"corpse_deleted" );
            body callback::callback( "on_annihilated" );
            body utility::function_32b24db3127bff40( "death_explosion", "death_explosion" );
            waitframe();
            body delete();
            return;
        }
        
        if ( utility::ent_flag( "dark_aether_bubble" ) )
        {
            body utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dissolve" );
            body thread dark_aether_bubble_timer();
        }
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
        }
        else if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
        }
        else if ( utility::ent_flag( "locust_ww_burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww", "burned_dead" );
        }
        else if ( utility::ent_flag( "locust_ww_burned_pap" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww_pap", "burned_dead" );
        }
        
        body endon( #"corpse_deleted" );
        body waittill( #"death_explode" );
        body utility::function_32b24db3127bff40( "death_explosion", "death_explosion" );
        wait 0.2;
        body delete();
    }
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x7a05cc06, Offset: 0xa98
// Size: 0x4b, Type: bool
function private is_explosive_damage( smeansofdeath )
{
    if ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0xe7c1d938, Offset: 0xaec
// Size: 0x6a, Type: bool
function private function_a943c725a8657266( var_e31c53eb403a02dd )
{
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_17f5b802bbd0062c && is_explosive_damage( var_e31c53eb403a02dd.smeansofdeath ) )
    {
        return false;
    }
    
    if ( isdefined( var_e31c53eb403a02dd.metabonename ) )
    {
        return false;
    }
    
    if ( var_e31c53eb403a02dd.idamage == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_callisto
// Params 0, eflags: 0x4
// Checksum 0xc65a503c, Offset: 0xb5f
// Size: 0x64
function private function_faa0dd880eca331c()
{
    self endon( #"death" );
    
    while ( true )
    {
        in_bull_charge = istrue( self getaiblackboarddynamic( "in_charge" ) );
        
        if ( in_bull_charge )
        {
            if ( self.collide_with_ai )
            {
                self.collide_with_ai = 0;
            }
        }
        else if ( !self.collide_with_ai )
        {
            self.collide_with_ai = 1;
        }
        
        waitframe();
    }
}

// Namespace zombie_callisto
// Params 0, eflags: 0x4
// Checksum 0x3cd5416d, Offset: 0xbcb
// Size: 0x1dc
function private update_headlook()
{
    self endon( #"death" );
    self.head_yaw = 0;
    
    while ( true )
    {
        if ( self.enemy )
        {
            target_pos = self.enemy.origin;
            var_f06c3d8143b76949 = self gettagorigin( "j_head" );
            var_ee6433c31961982d = target_pos - var_f06c3d8143b76949;
            var_ee6433c31961982d = vectornormalize( var_ee6433c31961982d );
            forward = anglestoforward( self.angles );
            up = anglestoup( self.angles );
            sub_up = vectordot( var_ee6433c31961982d, up ) * -1;
            var_ee6433c31961982d += sub_up * up;
            var_ee6433c31961982d = vectornormalize( var_ee6433c31961982d );
            dot = clamp( vectordot( var_ee6433c31961982d, forward ), -1, 1 );
            var_1694f943e71c8674 = acos( dot );
            isleft = vectordot( vectorcross( forward, var_ee6433c31961982d ), up ) > 0;
            
            if ( isleft )
            {
                yaw = var_1694f943e71c8674 * -1;
            }
            else
            {
                yaw = var_1694f943e71c8674;
            }
            
            yaw_delta = yaw - self.head_yaw;
            
            if ( abs( yaw_delta ) < 5 )
            {
                yaw = self.head_yaw;
            }
            else
            {
                yaw_speed = 200 * level.framedurationseconds;
                
                if ( yaw_delta > 0 )
                {
                    if ( yaw_speed > yaw_delta )
                    {
                        yaw_speed = yaw_delta;
                    }
                    
                    yaw = self.head_yaw + yaw_speed;
                }
                else
                {
                    if ( yaw_speed > yaw_delta * -1 )
                    {
                        yaw_speed = yaw_delta * -1;
                    }
                    
                    yaw = self.head_yaw - yaw_speed;
                }
            }
            
            yaw = clamp( yaw, -65, 65 );
            self function_536f8624346a747b( yaw );
            self.head_yaw = yaw;
        }
        else
        {
            self function_536f8624346a747b( 0 );
        }
        
        waitframe();
    }
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0xc8180821, Offset: 0xdaf
// Size: 0x107
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
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 0;
    }
    
    wait 1.5;
    val::reset( "spawn_healthbar_suppress", "show_healthbar" );
    self function_f2df0257c63f229( "in_spawn_reveal" );
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
    
    if ( !b_teleport_reveal )
    {
        zombie_callisto_zombeehive::function_87b27756a8931417();
    }
    
    if ( !self.var_698cf8d8d4a8cbb9 && !self.var_16f6f3f5b489a0a2 )
    {
        utility::function_32b24db3127bff40( "base", "base_on" );
    }
    
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x9af1d3ba, Offset: 0xebe
// Size: 0x3b
function private prepare_spawn_reveal( b_teleport_reveal )
{
    if ( !b_teleport_reveal )
    {
        zombie_callisto_zombeehive::function_dabab364c6f054aa();
    }
    
    utility::function_32b24db3127bff40( "base", "base_off" );
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x55d31ad8, Offset: 0xf01
// Size: 0x1e
function private function_aa62e405eca3c0f5( params )
{
    prepare_spawn_reveal( 1 );
    thread spawn_reveal( 1 );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0xe764882e, Offset: 0xf27
// Size: 0x30
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    thread function_f28f2022b3f6ff6f();
    self function_786bb6aa1b76c7ee( "zombeesattack_canattack", 0 );
}

// Namespace zombie_callisto
// Params 0, eflags: 0x4
// Checksum 0x19847ba9, Offset: 0xf5f
// Size: 0x1b
function private function_f28f2022b3f6ff6f()
{
    self endon( #"death" );
    wait 2;
    zombie_callisto_zombees::on_spawn_bees();
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0xbd15347d, Offset: 0xf82
// Size: 0x46
function private function_16751232a9e10970( params )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
    
    if ( self.var_c2c4733342e35fa9 > 0 && !self.var_ea0339471f98d3c7 )
    {
        self function_786bb6aa1b76c7ee( "zombeesattack_canattack", 1 );
    }
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x58d9f8d7, Offset: 0xfd0
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0xcf485f67, Offset: 0xff5
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x897df372, Offset: 0x101a
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x9a8bd87c, Offset: 0x1061
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x70ab53c9, Offset: 0x10a8
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x1642fe69, Offset: 0x10cd
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0x99554af, Offset: 0x10f2
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_callisto
// Params 0, eflags: 0x4
// Checksum 0x73cafe73, Offset: 0x1117
// Size: 0x25
function private dark_aether_bubble_timer()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

// Namespace zombie_callisto
// Params 1, eflags: 0x4
// Checksum 0xd8e90aff, Offset: 0x1144
// Size: 0x1d3
function private function_4caf5b9134c00a31( params )
{
    if ( isdefined( params.metabonename ) )
    {
        if ( params.biscritical )
        {
            playfx( utility::getfx( "callisto_weakpoint_impact_fx" ), params.vpoint );
        }
        else
        {
            playfx( utility::getfx( "callisto_armored_impact_fx" ), params.vpoint );
        }
    }
    
    if ( self.health < params.idamage && params.smeansofdeath == "MOD_CRUSH" && params.eattacker && params.eattacker vehicle::is_vehicle() )
    {
        self function_786bb6aa1b76c7ee( "death_fast", 1 );
    }
    
    if ( !isdefined( self.var_becf6aec57a489d8 ) || gettime() > self.var_becf6aec57a489d8 )
    {
        self.var_becf6aec57a489d8 = gettime() + utility::function_4b74c15943231980( 5 );
        
        if ( self getaiblackboarddynamic( "in_charge_loop" ) )
        {
            asm::function_7256f5ba459c840b( "charge_loop_pain" );
        }
        else
        {
            from_right = 0;
            angles = self.angles;
            origin = self.origin;
            
            if ( isdefined( params.vpoint ) )
            {
                to_point = params.vpoint - origin;
                right = anglestoright( angles );
                dot = vectordot( to_point, right );
                
                if ( dot > 0 )
                {
                    from_right = 1;
                }
            }
            
            pain_index = from_right ? 1 : 2;
            self function_6ecae54580d8f0aa( 1, pain_index );
        }
        
        utility::delaycallendon( 5, "death", &function_6ecae54580d8f0aa, 0, 0 );
    }
}

// Namespace zombie_callisto
// Params 0, eflags: 0x4
// Checksum 0xbade6b96, Offset: 0x131f
// Size: 0x35
function private function_583fcb0921e96869()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"callisto_reset_stance" );
        
        if ( self )
        {
            self.currentpose = "stand";
        }
    }
}

// Namespace zombie_callisto
// Params 0, eflags: 0x4
// Checksum 0xca5babee, Offset: 0x135c
// Size: 0x56
function private function_8ee8e1211b34de95()
{
    self endon( #"death" );
    wait 5;
    start_time = gettime();
    
    while ( self.b_in_spawn_closet )
    {
        if ( self && gettime() - start_time > 15000 )
        {
            level notify( #"hash_278e8250b8dee365", self );
            break;
        }
        
        wait 5;
    }
}

