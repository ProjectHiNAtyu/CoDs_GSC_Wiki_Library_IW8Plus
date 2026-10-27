// scripts\common\ai\aitypes\shared\zombie\zombie_projectile_attack.gsc  (hash_1622db5f27c31c3f.gscc) (size: 12798 Bytes / 0x31fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5866aa45 (1483123269)
// size ...... 12798 (0x31fe)
// includes .. 3   (offset: 0x2f4e)
// strings ... 40  (offset: 0x2f66)
// dev strs .. 3   (offset: 0x31d6)
// exports ... 22  (offset: 0x200e)
// cseg ...... 0x3c1 + 0x1c4d (0x200e)
// imports ... 99  (offset: 0x237e)
// animtree1 . 0   (offset: 0x31fe)
// animtree2 . 0   (offset: 0x31fe)
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_projectile_attack;

// Namespace zombie_projectile_attack
// Params 1
// Checksum 0x43d4e3db, Offset: 0x3df
// Size: 0xdd
function precache( aitypescriptbundle )
{
    var_22e5e17527a4b653 = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    
    if ( var_22e5e17527a4b653 )
    {
        if ( var_22e5e17527a4b653.var_8ca359012dd4e83d )
        {
            utility::add_fx( "projectile_attack_impact_fx_" + ( aitypescriptbundle.subclass ?? "" ), var_22e5e17527a4b653.var_8ca359012dd4e83d );
        }
        
        if ( var_22e5e17527a4b653.var_c8c53c9a16abe639 )
        {
            utility::add_fx( "player_hit_by_projectile_attack_fx_" + ( aitypescriptbundle.subclass ?? "" ), var_22e5e17527a4b653.var_c8c53c9a16abe639 );
        }
        
        if ( var_22e5e17527a4b653.var_330ddc30033da030 )
        {
            utility::add_fx( "projectile_attack_aoe_fx_" + ( aitypescriptbundle.subclass ?? "" ), var_22e5e17527a4b653.var_330ddc30033da030 );
        }
    }
}

// Namespace zombie_projectile_attack
// Params 0
// Checksum 0x2e44e19e, Offset: 0x4c4
// Size: 0x42
function init_global()
{
    callback::get_template( self.animsetname ) callback::add( "out_playable_space", &out_playable_space );
    callback::get_template( self.animsetname ) callback::add( "in_playable_space", &in_playable_space );
}

// Namespace zombie_projectile_attack
// Params 1
// Checksum 0x4c869bb0, Offset: 0x50e
// Size: 0x128
function init( var_c51df670a8ae88e4 )
{
    thread function_b2edde8c99b8fffc();
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
    
    if ( !isdefined( self.var_577dec43cf1caedf ) )
    {
        self.var_577dec43cf1caedf = 1;
    }
    
    self function_786bb6aa1b76c7ee( "ranged_max_target_count", self.var_577dec43cf1caedf );
    self function_786bb6aa1b76c7ee( "max_ranged_attack_dist", self.var_d6894f01a36b4ff3.var_d075c035f7081d2a );
    self function_786bb6aa1b76c7ee( "max_ranged_attack_yaw", self.var_d6894f01a36b4ff3.var_8ffb67aee9307b70 );
    
    if ( isfunction( var_c51df670a8ae88e4 ) )
    {
        self.var_79254237aa6a1620 = var_c51df670a8ae88e4;
    }
    
    thread function_1c9c7adb7e3e3f69();
}

// Namespace zombie_projectile_attack
// Params 1
// Checksum 0xe2f1bfc, Offset: 0x63e
// Size: 0x4b
function enable_projectile_attack( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e && ( !isdefined( self.var_79254237aa6a1620 ) || self [[ self.var_79254237aa6a1620 ]]() ) )
    {
        self function_f2df0257c63f229( "disable_ranged_attack" );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "disable_ranged_attack", 1 );
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0xcce07bd5, Offset: 0x691
// Size: 0x14
function private out_playable_space( params )
{
    enable_projectile_attack( 0 );
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0xe37d5c82, Offset: 0x6ad
// Size: 0x15
function private in_playable_space( params )
{
    enable_projectile_attack( 1 );
}

// Namespace zombie_projectile_attack
// Params 1
// Checksum 0x948f0ede, Offset: 0x6ca
// Size: 0x3a
function request_projectile_attack( target_ent )
{
    assert( isdefined( self.grenadeweapon ), "<dev string:x24>" );
    self.ranged_attack_target = target_ent;
    asm::function_7256f5ba459c840b( "ranged_attack_in" );
}

// Namespace zombie_projectile_attack
// Params 0, eflags: 0x4
// Checksum 0xf67f6151, Offset: 0x70c
// Size: 0x51
function private function_b2edde8c99b8fffc()
{
    self endon( #"death" );
    
    while ( true )
    {
        var_a9da764ea9556786 = utility::waittill_any_return( "ranged_attack_enemy_start", "ranged_attack_point_start" );
        request_projectile_attack( var_a9da764ea9556786 == "ranged_attack_enemy_start" ? self.enemy : undefined );
    }
}

// Namespace zombie_projectile_attack
// Params 0, eflags: 0xc
// Checksum 0xb756cfd8, Offset: 0x765
// Size: 0x2f6
function private function_1c9c7adb7e3e3f69()
{
    self notify( #"hash_6807114a7bfe04c5" );
    self endon( #"hash_6807114a7bfe04c5" );
    self endon( #"death" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "cancel_ranged_attack", "attach_projectile", "attach_projectile_left", "attach_projectile_right", "attach_projectile_left_right", "launch_projectile", "launch_projectile_left", "launch_projectile_right", "launch_projectile_left_right" );
        
        if ( msg == "cancel_ranged_attack" )
        {
            continue;
        }
        
        if ( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6.size > 0 )
        {
            var_d75eaefe66066143 = utility::array_random( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6 ).modelname;
        }
        
        assert( var_d75eaefe66066143, "<dev string:x52>" );
        var_2d27742912cc383c = undefined;
        attach_tag_left = undefined;
        attach_tag_right = undefined;
        
        if ( msg == "attach_projectile" )
        {
            var_2d27742912cc383c = self.var_d6894f01a36b4ff3.projectileattachtag;
            self attach( var_d75eaefe66066143, var_2d27742912cc383c );
        }
        else if ( msg == "attach_projectile_left" )
        {
            attach_tag_left = self.var_d6894f01a36b4ff3.projectileattachtagleft;
            self attach( var_d75eaefe66066143, attach_tag_left );
        }
        else if ( msg == "attach_projectile_right" )
        {
            attach_tag_right = self.var_d6894f01a36b4ff3.projectileattachtagright;
            self attach( var_d75eaefe66066143, attach_tag_right );
        }
        else if ( msg == "attach_projectile_left_right" )
        {
            attach_tag_left = self.var_d6894f01a36b4ff3.projectileattachtagleft;
            attach_tag_right = self.var_d6894f01a36b4ff3.projectileattachtagright;
            self attach( var_d75eaefe66066143, attach_tag_left );
            self attach( var_d75eaefe66066143, attach_tag_right );
        }
        
        if ( var_2d27742912cc383c || attach_tag_left || attach_tag_right )
        {
            msg = utility::waittill_any_return( "cancel_ranged_attack", "launch_projectile", "launch_projectile_left", "launch_projectile_right", "launch_projectile_left_right" );
        }
        
        if ( msg == "cancel_ranged_attack" )
        {
            if ( var_2d27742912cc383c )
            {
                self detach( var_d75eaefe66066143, var_2d27742912cc383c );
            }
            
            if ( attach_tag_left )
            {
                self detach( var_d75eaefe66066143, attach_tag_left );
            }
            
            if ( attach_tag_right )
            {
                self detach( var_d75eaefe66066143, attach_tag_right );
            }
            
            continue;
        }
        
        if ( msg == "launch_projectile" )
        {
            function_5a48a73ee2c4ab48( self.var_d6894f01a36b4ff3.projectileattachtag, var_d75eaefe66066143, isdefined( var_2d27742912cc383c ) );
            continue;
        }
        
        if ( msg == "launch_projectile_left" )
        {
            function_5a48a73ee2c4ab48( self.var_d6894f01a36b4ff3.projectileattachtagleft, var_d75eaefe66066143, isdefined( attach_tag_left ) );
            continue;
        }
        
        if ( msg == "launch_projectile_right" )
        {
            function_5a48a73ee2c4ab48( self.var_d6894f01a36b4ff3.projectileattachtagright, var_d75eaefe66066143, isdefined( attach_tag_right ) );
            continue;
        }
        
        if ( msg == "launch_projectile_left_right" )
        {
            function_5a48a73ee2c4ab48( self.var_d6894f01a36b4ff3.projectileattachtagleft, var_d75eaefe66066143, isdefined( attach_tag_left ) );
            function_5a48a73ee2c4ab48( self.var_d6894f01a36b4ff3.projectileattachtagright, var_d75eaefe66066143, isdefined( attach_tag_right ) );
        }
    }
}

// Namespace zombie_projectile_attack
// Params 3, eflags: 0x4
// Checksum 0x3be2faae, Offset: 0xa63
// Size: 0x2d3
function private function_5a48a73ee2c4ab48( var_2d27742912cc383c, var_d75eaefe66066143, b_attached )
{
    start_pos = self gettagorigin( var_2d27742912cc383c );
    local_start_pos = coordtransformtranspose( start_pos, self.origin, self.angles );
    var_e1b150b361aa0993 = isent( self.ranged_attack_target ) ? self.ranged_attack_target : undefined;
    gravity_scale = self.grenadeweapon.var_4b34df4cbe697f89;
    var_267d01d2be2d145 = self function_d5e40e88a4ac1386( self.grenadeweapon, var_e1b150b361aa0993, 0, 0, self.var_d6894f01a36b4ff3.var_119fef101c0ce9fd, self.var_d6894f01a36b4ff3.var_aa57d9825605b34b, self.var_d6894f01a36b4ff3.var_5e7bfcf78c63144b, local_start_pos, self.var_d6894f01a36b4ff3.var_b5ff4d8a226be5fc, gravity_scale );
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        var_267d01d2be2d145 = self._blackboard.var_c894b0896ac6f7d;
    }
    
    projectile = magicgrenademanual( self.grenadeweapon, start_pos, var_267d01d2be2d145, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    projectile.angles = self gettagangles( var_2d27742912cc383c );
    projectile.owner = self;
    
    if ( b_attached )
    {
        self detach( var_d75eaefe66066143, var_2d27742912cc383c );
    }
    
    if ( var_d75eaefe66066143 )
    {
        projectile setmodel( var_d75eaefe66066143 );
    }
    
    params = spawnstruct();
    params.var_e1b150b361aa0993 = var_e1b150b361aa0993;
    params.projectile = projectile;
    callback::callback( "projectile_fired", params );
    
    if ( self.var_d6894f01a36b4ff3.var_8ca359012dd4e83d )
    {
        projectile thread function_d6377d7a67814321( self );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_c8c53c9a16abe639 || callback::exists_any( "on_projectile_player_impact" ) )
    {
        projectile thread function_29494a18bd3990aa( self );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_18fc8730079bfe71 || callback::exists_any( "on_projectile_world_impact" ) )
    {
        projectile thread function_ca4a8f0725d5788e( self );
    }
    
    if ( callback::exists_any( "on_projectile_ai_impact" ) )
    {
        projectile thread function_9015f6bc352ca61b( self );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_a5fe8b20361922d9 )
    {
        projectile thread function_5420da72358c8f49( self );
    }
    
    var_ad1efe5e8f84b51c = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a ) );
    self function_786bb6aa1b76c7ee( "ranged_attack_time", gettime() + var_ad1efe5e8f84b51c );
    
    if ( isplayer( var_e1b150b361aa0993 ) )
    {
        var_e1b150b361aa0993 function_884711fc94b10261();
        var_e1b150b361aa0993 function_a58e1bd7ca9f6222( "ranged_attack" );
        projectile thread function_b56b9dc4beab6efc( var_e1b150b361aa0993 );
    }
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0x91fe366a, Offset: 0xd3e
// Size: 0xe4
function private function_d6377d7a67814321( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    fx_id = "projectile_attack_impact_fx_" + ( ai.subclass ?? "" );
    self waittill( #"explode", position, var_4cd1a139c1b0c2b7 );
    impact_vfx_id = utility::getfx( fx_id );
    
    if ( impact_vfx_id )
    {
        normal = isvector( var_4cd1a139c1b0c2b7 ) ? var_4cd1a139c1b0c2b7 : undefined;
        playfx( impact_vfx_id, position, undefined, normal );
    }
    
    if ( isdefined( self ) && self isscriptable() && self getscriptablehaspart( "projectile" ) && self getscriptableparthasstate( "projectile", "explode" ) )
    {
        self setscriptablepartstate( "projectile", "explode" );
    }
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0x69eaf53b, Offset: 0xe2a
// Size: 0xe0
function private function_29494a18bd3990aa( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    
    if ( self.var_d6894f01a36b4ff3.var_18fc8730079bfe71 )
    {
        fx_id = "player_hit_by_projectile_attack_fx_" + ( ai.subclass ?? "" );
    }
    
    self waittill( #"projectile_impact_player", hitent );
    
    if ( isplayer( hitent ) )
    {
        if ( isalive( ai ) )
        {
            params = spawnstruct();
            params.player = hitent;
            ai callback::callback( "on_projectile_player_impact", params );
        }
        
        if ( fx_id )
        {
            screen_fx_id = utility::getfx( fx_id );
            
            if ( isdefined( screen_fx_id ) )
            {
                playfxontagforclients( screen_fx_id, hitent, "j_head", hitent );
            }
        }
    }
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0x52f8c9c0, Offset: 0xf12
// Size: 0x7b
function private function_9015f6bc352ca61b( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self waittill( #"projectile_impact_ai", hitent );
    
    if ( isai( hitent ) )
    {
        if ( isalive( ai ) )
        {
            params = spawnstruct();
            params.ai = hitent;
            ai callback::callback( "on_projectile_ai_impact", params );
        }
    }
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0x9b905de6, Offset: 0xf95
// Size: 0x22f
function private function_ca4a8f0725d5788e( ai )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self endon( #"projectile_impact_player" );
    weapon = ai.grenadeweapon;
    var_f65a4041e683646b = ai.var_d6894f01a36b4ff3.var_2e336f378c709a8c;
    var_114709d5b68798 = ai.var_d6894f01a36b4ff3.var_597b49917a1fdb2b;
    var_343a3af8e080d16 = ai.var_d6894f01a36b4ff3.var_18fc8730079bfe71;
    self waittill( #"explode", position );
    
    /#
        if ( debug_projectile_attack() )
        {
            sphere( position, var_f65a4041e683646b, ( 1, 0, 1 ) );
        }
    #/
    
    if ( isalive( ai ) )
    {
        params = spawnstruct();
        params.position = position;
        ai callback::callback( "on_projectile_world_impact", params );
    }
    
    if ( var_343a3af8e080d16 )
    {
        nearby_players = getplayersinradius( position, var_f65a4041e683646b, var_f65a4041e683646b, 1 );
        
        foreach ( player in nearby_players )
        {
            if ( isalive( player ) && player.team != ai.team )
            {
                if ( player.var_b6f2224be9ed1a1b )
                {
                    continue;
                }
                
                player dodamage( var_114709d5b68798, position, ai, self, "MOD_GRENADE_SPLASH", weapon );
                
                /#
                    if ( debug_projectile_attack() )
                    {
                        print3d( position, "<dev string:x88>" + distance( player.origin, position ), ( 1, 0, 1 ) );
                        line( position, player.origin, ( 1, 0, 1 ) );
                    }
                #/
            }
        }
    }
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0xedd6a454, Offset: 0x11cc
// Size: 0x9dd
function private function_5420da72358c8f49( ai )
{
    aoe_fx_id = undefined;
    
    if ( isdefined( ai.var_d6894f01a36b4ff3.var_330ddc30033da030 ) )
    {
        aoe_fx_id = utility::getfx( "projectile_attack_aoe_fx_" + ( ai.subclass ?? "" ) );
    }
    
    var_7d43ccfa569e3184 = ai.var_d6894f01a36b4ff3.var_d056f76334001aa2;
    aoe_duration_ms = ai.var_d6894f01a36b4ff3.var_3146511ad5c396b4 * 1000;
    var_9281b47469dec227 = ai.var_d6894f01a36b4ff3.var_9290db4e037c4d68;
    var_5e1384407d4ff629 = ai.var_d6894f01a36b4ff3.var_939025f7b9733f30 ?? 0;
    var_5b62822556e32f3d = ai.var_d6894f01a36b4ff3.var_9cb5633420c55892 ?? 0;
    var_1fa92d6012a155f9 = ai.var_d6894f01a36b4ff3.var_84cc0e75d887688 ?? 0;
    var_801c6fe01369ad7b = ai.var_d6894f01a36b4ff3.var_7cfca8430001e89a ?? 0;
    var_afecf3b1b8736f27 = ai.var_d6894f01a36b4ff3.var_88172cbbe1d769d9;
    var_fe1bc007faaf6a7e = ai.var_d6894f01a36b4ff3.var_113ba715ab2b17fb * 1000;
    aoe_postfx_bundle = ai.var_d6894f01a36b4ff3.var_ba9c84f836d77c58;
    ai_team = ai.team;
    
    if ( var_5e1384407d4ff629 > 0 )
    {
        var_3a1a36f27eaef261 = 1000;
        var_5e1384407d4ff629 /= 1000;
        var_1fa92d6012a155f9 *= 1000;
    }
    else
    {
        var_3a1a36f27eaef261 = ( var_9281b47469dec227 - 0.2 ) * 1000;
    }
    
    self waittill( #"explode", position );
    nav_pos = getclosestpointonnavmesh( position );
    
    if ( isdefined( nav_pos ) && distance2dsquared( position, nav_pos ) < squared( 50 ) )
    {
        height_delta = position[ 2 ] - nav_pos[ 2 ];
        
        if ( height_delta < 100 && height_delta > -20 )
        {
            curr_time = gettime();
            
            if ( !isdefined( ai.var_fa2831c7ae90426 ) )
            {
                ai.var_fa2831c7ae90426 = [];
            }
            
            if ( !isdefined( ai.var_b217c3c0f5102061 ) )
            {
                ai.var_b217c3c0f5102061 = 0;
            }
            
            dist_sqr_tolerance = squared( var_7d43ccfa569e3184 * 0.5 );
            var_99722385af344175 = 0;
            
            foreach ( aoe in ai.var_fa2831c7ae90426 )
            {
                if ( curr_time - aoe.time < 500 && distancesquared( aoe.pos, nav_pos ) < dist_sqr_tolerance )
                {
                    return;
                }
            }
            
            ai.var_b217c3c0f5102061++;
            id = ai.var_b217c3c0f5102061;
            ai.var_fa2831c7ae90426[ ai.var_fa2831c7ae90426.size ] = { #pos:nav_pos, #time:curr_time, #id:id };
            
            if ( isdefined( aoe_fx_id ) )
            {
                playfx( aoe_fx_id, nav_pos );
            }
            
            if ( isdefined( ai.var_d6894f01a36b4ff3.var_a927c04769ac2a83 ) && isdefined( ai.var_d6894f01a36b4ff3.var_ecc588f801488bbd ) )
            {
                aoe_scriptable = spawnscriptable( ai.var_d6894f01a36b4ff3.var_a927c04769ac2a83, nav_pos );
                var_ca486f123d98111b = ai.var_d6894f01a36b4ff3.var_ecc588f801488bbd;
                aoe_scriptable setscriptablepartstate( var_ca486f123d98111b, "on" );
            }
            
            if ( isdefined( ai ) )
            {
                attacker = ai;
            }
            else
            {
                script_origin = utility::spawn_script_origin( nav_pos );
                script_origin.team = ai_team;
                attacker = script_origin;
            }
            
            if ( var_801c6fe01369ad7b > 0 && utility::issharedfuncdefined( #"shockstick", #"shockstick_applyhaywire" ) )
            {
                shockdata = function_327197455e717e13( var_801c6fe01369ad7b, attacker, nav_pos );
            }
            
            if ( var_5e1384407d4ff629 > 0 )
            {
                wave_pos = nav_pos + ( 0, 0, var_5b62822556e32f3d );
            }
            
            /#
                if ( debug_projectile_attack() )
                {
                    cylinder( nav_pos - ( 0, 0, 50 ), nav_pos + ( 0, 0, 50 ), var_7d43ccfa569e3184, ( 1, 1, 0 ), 0, int( aoe_duration_ms / getframeduration() ) );
                }
            #/
            
            end_time = curr_time + aoe_duration_ms;
            
            while ( true )
            {
                var_48ee71281f56f926 = curr_time;
                curr_time = gettime();
                
                if ( curr_time > end_time )
                {
                    break;
                }
                
                affected_players = function_d63fe6a4c08ba6f5( nav_pos, var_7d43ccfa569e3184, 50, 1 );
                var_cfa9f54569c2398a = vehicle_getarrayinradius( nav_pos, var_7d43ccfa569e3184, 50 );
                affected_entities = arraycombine( affected_players, var_cfa9f54569c2398a );
                
                if ( var_5e1384407d4ff629 > 0 )
                {
                    if ( !isdefined( wave_dist ) )
                    {
                        wave_dist = 0;
                    }
                    
                    delta_time = curr_time - var_48ee71281f56f926;
                    
                    if ( delta_time > 0 && curr_time >= var_99722385af344175 )
                    {
                        wave_dist += var_5e1384407d4ff629 * delta_time;
                        
                        if ( wave_dist > var_7d43ccfa569e3184 )
                        {
                            wave_dist = 0;
                            var_99722385af344175 = curr_time + var_1fa92d6012a155f9;
                        }
                    }
                    
                    /#
                        if ( debug_projectile_attack() )
                        {
                            cylinder( nav_pos, wave_pos, wave_dist, ( 1, 0, 0 ) );
                        }
                    #/
                    
                    affected_entities = function_76f94c57be994d1b( affected_entities, wave_pos, wave_dist, var_48ee71281f56f926 );
                }
                
                if ( !isdefined( wave_dist ) || wave_dist > 0 )
                {
                    foreach ( ent in affected_entities )
                    {
                        if ( isalive( ent ) && ent.team != ai_team && ( !isdefined( ent.var_d0bb07a3110d2207 ) || curr_time - ent.var_d0bb07a3110d2207 > var_3a1a36f27eaef261 ) )
                        {
                            if ( ent.var_b6f2224be9ed1a1b )
                            {
                                continue;
                            }
                            
                            if ( !isdefined( ent.var_d0bb07a3110d2207 ) || ent.var_d0bb07a3110d2207 + var_fe1bc007faaf6a7e < curr_time )
                            {
                                ent.var_3153de7deda6913 = curr_time;
                            }
                            
                            time_in_aoe = curr_time - ent.var_3153de7deda6913;
                            highest_pair = undefined;
                            
                            foreach ( pair in var_afecf3b1b8736f27 )
                            {
                                if ( ( !isdefined( pair.var_a95ee436898b4a2f ) || pair.var_a95ee436898b4a2f * 1000 <= time_in_aoe ) && ( !isdefined( highest_pair.var_a95ee436898b4a2f ) || pair.var_a95ee436898b4a2f > highest_pair.var_a95ee436898b4a2f ) )
                                {
                                    highest_pair = pair;
                                }
                            }
                            
                            var_7e4b9f5c15199a83 = highest_pair.damagetick;
                            ent.var_d0bb07a3110d2207 = curr_time;
                            
                            if ( var_7e4b9f5c15199a83 > 0 )
                            {
                                ent dodamage( var_7e4b9f5c15199a83, nav_pos, attacker, undefined, "MOD_GRENADE_SPLASH", "<explicitweaponnone>", undefined, undefined, 2 );
                            }
                            
                            if ( isplayer( ent ) )
                            {
                                if ( isdefined( shockdata ) )
                                {
                                    shockdata thread [[ utility::getsharedfunc( #"shockstick", #"shockstick_applyhaywire" ) ]]( ent, shockdata.weapon, 0 );
                                }
                                
                                if ( isdefined( aoe_postfx_bundle ) )
                                {
                                    pbgpostfxbundlestart( ent, aoe_postfx_bundle );
                                }
                            }
                            
                            /#
                                if ( debug_projectile_attack() )
                                {
                                    print3d( position, "<dev string:x88>" + distance( ent.origin, nav_pos ), ( 1, 0, 0 ) );
                                    line( nav_pos, ent.origin, ( 1, 0, 0 ), 0, int( aoe_duration_ms / getframeduration() ) );
                                }
                            #/
                        }
                    }
                }
                
                if ( var_5e1384407d4ff629 > 0 )
                {
                    waitframe();
                    continue;
                }
                
                wait var_9281b47469dec227;
            }
            
            if ( isdefined( script_origin ) )
            {
                script_origin delete();
                script_origin = undefined;
            }
            
            if ( isdefined( aoe_scriptable ) && isdefined( var_ca486f123d98111b ) )
            {
                aoe_scriptable setscriptablepartstate( var_ca486f123d98111b, "off" );
                aoe_scriptable freescriptable();
            }
            
            if ( isdefined( ai ) )
            {
                if ( ai.var_fa2831c7ae90426.size == 1 )
                {
                    ai.var_fa2831c7ae90426 = [];
                    return;
                }
                
                remove_idx = -1;
                
                foreach ( idx, aoe in ai.var_fa2831c7ae90426 )
                {
                    if ( aoe.id == id )
                    {
                        remove_idx = idx;
                    }
                }
                
                if ( remove_idx >= 0 )
                {
                    ai.var_fa2831c7ae90426[ remove_idx ] = undefined;
                    
                    if ( isint( remove_idx ) )
                    {
                        function_cdc669dbc8ea2101( ai.var_fa2831c7ae90426 );
                    }
                }
            }
        }
    }
}

// Namespace zombie_projectile_attack
// Params 4, eflags: 0x4
// Checksum 0xa13393da, Offset: 0x1bb1
// Size: 0x121
function private function_76f94c57be994d1b( entities, var_a210b94b62c1b99b, wave_dist, var_48ee71281f56f926 )
{
    affected_entities = [];
    
    foreach ( ent in entities )
    {
        if ( ent.var_d0bb07a3110d2207 == var_48ee71281f56f926 )
        {
            continue;
        }
        
        bounds_half_size = ent getboundshalfsize();
        var_829db0e0eb1bd6ca = var_a210b94b62c1b99b - ent.origin;
        
        if ( var_829db0e0eb1bd6ca[ 2 ] < 0 || var_829db0e0eb1bd6ca[ 2 ] > bounds_half_size[ 2 ] * 2 )
        {
            continue;
        }
        else
        {
            var_9612e55d981ec3c6 = length2d( var_829db0e0eb1bd6ca );
            
            if ( abs( var_9612e55d981ec3c6 - wave_dist ) > bounds_half_size[ 0 ] )
            {
                continue;
            }
        }
        
        affected_entities[ affected_entities.size ] = ent;
    }
    
    return affected_entities;
}

// Namespace zombie_projectile_attack
// Params 3, eflags: 0x4
// Checksum 0xd4fa983b, Offset: 0x1cdb
// Size: 0x1d2
function private function_327197455e717e13( shockduration, owner, pos )
{
    shockdata = spawnstruct();
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_3187f585d2de7de7" ) )
    {
        shockdata.tableinfo = [[ utility::getsharedfunc( #"equipment", #"hash_3187f585d2de7de7" ) ]]( "equip_shockstick" );
    }
    
    shockdata.owner = owner;
    shockdata.team = isdefined( self.var_bd22ba6c600a23a3 ) ? self.var_bd22ba6c600a23a3.team : self.team;
    shockdata.origin = pos;
    shockdata.weapon = makeweapon( "none" );
    shockdata.tableinfo.var_f3447a3874df563f = 0;
    shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
    shockdata.tableinfo.var_c6920ebeb7833310 = 1;
    shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
    shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
    shockdata.tableinfo.bundle.var_860545b754d7ecc0 = shockduration;
    shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = shockduration + 0.25;
    shockdata.tableinfo.bundle.shockstick_tickinterval = 0.2;
    return shockdata;
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0x16787117, Offset: 0x1eb6
// Size: 0x32
function private function_b56b9dc4beab6efc( player )
{
    self waittill( #"death" );
    
    if ( isdefined( player ) )
    {
        player function_88a6736ac53d2a25();
        player function_31d0b50675d9d6e( "ranged_attack" );
    }
}

// Namespace zombie_projectile_attack
// Params 1, eflags: 0x4
// Checksum 0x31bf553e, Offset: 0x1ef0
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace zombie_projectile_attack
// Params 5, eflags: 0x4
// Checksum 0xdc5d3d0f, Offset: 0x1f16
// Size: 0xd2
function private function_2408adb3cab0c16c( idamage, eattacker, objweapon, smeansofdeath, vpoint )
{
    if ( eattacker.grenadeweapon && objweapon == eattacker.grenadeweapon )
    {
        if ( eattacker.var_d6894f01a36b4ff3.var_794ee7b60b0d8ed5 && isdefined( eattacker.ranged_damage_multiplier ) )
        {
            idamage = int( ceil( idamage * eattacker.ranged_damage_multiplier ) );
            
            if ( eattacker.var_7977644af14eab4e )
            {
                idamage = minint( idamage, eattacker.maxdamagecap );
            }
        }
        else if ( isdefined( eattacker.ranged_grenade_damage ) )
        {
            idamage = eattacker.ranged_grenade_damage;
        }
    }
    
    return idamage;
}

/#

    // Namespace zombie_projectile_attack
    // Params 0, eflags: 0x4
    // Checksum 0x3a22006c, Offset: 0x1ff1
    // Size: 0x1d, Type: dev
    function private debug_projectile_attack()
    {
        if ( getdvarint( @"hash_44138f06f812e1f7", 0 ) > 0 )
        {
            return 1;
        }
        
        return 0;
    }

#/
