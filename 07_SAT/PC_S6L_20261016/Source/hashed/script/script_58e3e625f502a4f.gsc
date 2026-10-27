// script_58e3e625f502a4f  (hash_058e3e625f502a4f.gscc) (size: 7325 Bytes / 0x1c9d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d709b90 (1299225488)
// size ...... 7325 (0x1c9d)
// includes .. 6   (offset: 0x1a19)
// strings ... 39  (offset: 0x1a49)
// dev strs .. 0   (offset: 0x1c9d)
// exports ... 18  (offset: 0xfe5)
// cseg ...... 0x297 + 0xd4e (0xfe5)
// imports ... 61  (offset: 0x12b5)
// animtree1 . 0   (offset: 0x1c9d)
// animtree2 . 0   (offset: 0x1c9d)
#using script_16ea1b94f0f381b3;
#using script_6b10011ac07f7291;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_2bfee0fa87a9007a;

// Namespace namespace_2bfee0fa87a9007a
// Params 0
// Checksum 0xb1b1a690, Offset: 0x2b5
// Size: 0x73
function init_mech_beam_attack()
{
    callback::add( #"on_ai_killed", &cleanup_beam_ents );
    self.beam_ent = spawn( "script_model", ( 0, 0, 0 ) );
    self.beam_ent setmodel( "tag_origin_libra_mech_beam_tip" );
    self.beam_ent utility::function_7c10ea82c1e305b8( "beam_tip", "off" );
    thread utility::delete_on_death( self.beam_ent );
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1
// Checksum 0xb9b91838, Offset: 0x330
// Size: 0x15
function start_beam_attack( speed_mult )
{
    thread function_6c8610ca81382efd( speed_mult );
}

// Namespace namespace_2bfee0fa87a9007a
// Params 0
// Checksum 0xeceaf6ba, Offset: 0x34d
// Size: 0xe
function stop_beam_attack()
{
    self notify( #"beam_attack_loop_finished" );
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0x793955ba, Offset: 0x363
// Size: 0x62
function private calculate_beam_damage( var_90ec0886f9ccf215 )
{
    var_f170b524015f6863 = 12;
    
    if ( isplayer( var_90ec0886f9ccf215 ) && !var_90ec0886f9ccf215 utility::ent_flag( "mech_beam_shocked" ) )
    {
        if ( level.players.size <= 1 && var_90ec0886f9ccf215 != self.focustarget )
        {
            var_f170b524015f6863 = 100;
        }
        else
        {
            var_f170b524015f6863 = 48;
        }
    }
    
    return var_f170b524015f6863;
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0x3345e84d, Offset: 0x3ce
// Size: 0x27f
function private function_6c8610ca81382efd( speed_mult )
{
    self endon( #"death" );
    self endon( #"beam_attack_loop_finished" );
    thread beam_attack_on_end();
    mech = self;
    self.beam_ent dontinterpolate();
    last_hit_something = 0;
    var_c5b5bb741c705530 = 0;
    desired_end_pos = ( mech.origin[ 0 ], mech.origin[ 1 ], mech.origin[ 2 ] + 30 ) + get_head_forward() * 3000;
    fx = utility::getfx( "vfx_sat_wc_libra_mech_beam" );
    self.beam_fx = playfxontagsbetweenclients( fx, mech, "tag_aim", self.beam_ent, "tag_origin" );
    
    if ( isdefined( self.beam_fx ) )
    {
        self.beam_fx namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    }
    
    self.beam_ent utility::function_7c10ea82c1e305b8( "beam_tip", "start" );
    
    while ( true )
    {
        assert( isdefined( self.beam_ent ) );
        source_pos = self gettagorigin( "tag_aim" );
        desired_end_pos = mech aim_beam( desired_end_pos, source_pos, speed_mult );
        end_pos = desired_end_pos;
        var_42d66caabe0b20db = trace::ray_trace( source_pos, desired_end_pos );
        var_90ec0886f9ccf215 = var_42d66caabe0b20db[ "entity" ];
        var_925c7adfed1216b4 = var_42d66caabe0b20db[ "fraction" ] < 1;
        
        if ( var_925c7adfed1216b4 )
        {
            end_pos = var_42d66caabe0b20db[ "position" ];
            
            if ( !var_90ec0886f9ccf215 )
            {
                if ( gettime() >= var_c5b5bb741c705530 )
                {
                    function_24f6c6f448bbc089( end_pos );
                    var_c5b5bb741c705530 = gettime() + 200;
                }
            }
            else if ( var_90ec0886f9ccf215 == self.var_b9ccc2459bdce040 )
            {
                self.beamlockedon = 1;
            }
        }
        
        /#
            debug_beam( source_pos, end_pos, desired_end_pos );
        #/
        
        self.beam_ent.origin = end_pos;
        is_beam_tip_off = self.beam_ent getscriptablepartstate( "beam_tip" ) == "off";
        
        if ( is_beam_tip_off || var_925c7adfed1216b4 != last_hit_something )
        {
            if ( var_925c7adfed1216b4 )
            {
                self.beam_ent utility::function_7c10ea82c1e305b8( "beam_tip", "hit" );
            }
            else
            {
                self.beam_ent utility::function_7c10ea82c1e305b8( "beam_tip", "hit_nothing" );
            }
        }
        
        last_hit_something = var_925c7adfed1216b4;
        
        if ( isdefined( var_90ec0886f9ccf215 ) )
        {
            beam_hit( var_90ec0886f9ccf215 );
        }
        
        waitframe();
    }
}

// Namespace namespace_2bfee0fa87a9007a
// Params 0, eflags: 0x4
// Checksum 0xd9841512, Offset: 0x655
// Size: 0xf5
function private get_player_closest_to_beam()
{
    headforward = get_head_forward();
    bestplayer = undefined;
    bestdot = 0.8;
    
    foreach ( player in level.players )
    {
        if ( sat_libra_mech_turret::function_59fb39487166f319( player ) )
        {
            if ( !function_b1187ccaea28decd( player ) )
            {
                direction = vectornormalize2( player.origin - self.origin );
                dot = vectordot2( headforward, direction, 0 );
                
                if ( dot > bestdot )
                {
                    bestplayer = player;
                }
            }
        }
    }
    
    return bestplayer;
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0xf17d9f2c, Offset: 0x753
// Size: 0x36, Type: bool
function private function_b1187ccaea28decd( target_ent )
{
    if ( target_ent.var_bdd74df2bc62c24 && target_ent.var_bdd74df2bc62c24 + 3000 > gettime() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0xdb9275dd, Offset: 0x792
// Size: 0xe3, Type: bool
function private function_9da25f3da83b7c51( target_ent )
{
    if ( isdefined( target_ent ) && self.can_lock_on_target )
    {
        headforward = get_head_forward();
        direction = vectornormalize2( target_ent.origin - self.origin );
        dot = vectordot2( headforward, direction, 0 );
        
        if ( dot >= 0.8 )
        {
            source_pos = self gettagorigin( "tag_aim" );
            end_pos = ( target_ent.origin[ 0 ], target_ent.origin[ 1 ], target_ent.origin[ 2 ] + 30 );
            var_42d66caabe0b20db = trace::ray_trace( source_pos, end_pos );
            
            if ( var_42d66caabe0b20db[ "fraction" ] >= 0.97 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_2bfee0fa87a9007a
// Params 0, eflags: 0x4
// Checksum 0x632320c7, Offset: 0x87e
// Size: 0x2d
function private get_head_forward()
{
    worldyaw = combineangles( self.angles, ( 0, self.headyaw, 0 ) );
    return anglestoforward( worldyaw );
}

// Namespace namespace_2bfee0fa87a9007a
// Params 0, eflags: 0x4
// Checksum 0x42159c94, Offset: 0x8b4
// Size: 0x107
function private find_beam_target()
{
    if ( sat_libra_mech_turret::function_59fb39487166f319( self.focustarget ) )
    {
        self.var_b9ccc2459bdce040 = undefined;
        self.beamlockedon = undefined;
        return self.focustarget;
    }
    
    if ( self.var_b9ccc2459bdce040 )
    {
        if ( sat_libra_mech_turret::function_59fb39487166f319( self.var_b9ccc2459bdce040 ) && self.var_a4e5bde9b01f2aa4 >= gettime() )
        {
            if ( function_9da25f3da83b7c51( self.var_b9ccc2459bdce040 ) )
            {
                self.var_29ad6ead5d3765a1 = gettime();
                return self.var_b9ccc2459bdce040;
            }
            else if ( self.var_29ad6ead5d3765a1 > gettime() - 2000 )
            {
                return self.var_b9ccc2459bdce040;
            }
        }
        
        self.var_b9ccc2459bdce040 = undefined;
        self.beamlockedon = undefined;
    }
    
    new_target = get_player_closest_to_beam();
    
    if ( function_9da25f3da83b7c51( new_target ) )
    {
        self.var_a4e5bde9b01f2aa4 = gettime() + 3000;
        self.var_b9ccc2459bdce040 = new_target;
        self.beamlockedon = undefined;
        return new_target;
    }
}

// Namespace namespace_2bfee0fa87a9007a
// Params 3, eflags: 0x4
// Checksum 0xe8650c76, Offset: 0x9c4
// Size: 0x134
function private aim_beam( current_end_pos, source_pos, speed_mult )
{
    sourceorigin = self.origin;
    target_ent = find_beam_target();
    
    if ( target_ent )
    {
        target_ent.var_bdd74df2bc62c24 = gettime();
        distance = distance( target_ent.origin, source_pos );
        point = ( sourceorigin[ 0 ], sourceorigin[ 1 ], target_ent.origin[ 2 ] + 30 ) + get_head_forward() * distance;
    }
    else
    {
        point = ( sourceorigin[ 0 ], sourceorigin[ 1 ], self.origin[ 2 ] + 30 ) + get_head_forward() * 1000;
    }
    
    direction = vectornormalize( point - source_pos );
    desired = source_pos + direction * 3000;
    
    if ( current_end_pos[ 2 ] < desired[ 2 ] )
    {
        adjusted_height = min( current_end_pos[ 2 ] + 50 * speed_mult, desired[ 2 ] );
    }
    else
    {
        adjusted_height = max( current_end_pos[ 2 ] - 50 * speed_mult, desired[ 2 ] );
    }
    
    return ( desired[ 0 ], desired[ 1 ], adjusted_height );
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0x8edaa8bd, Offset: 0xb01
// Size: 0x126
function private beam_hit( var_90ec0886f9ccf215 )
{
    if ( !var_90ec0886f9ccf215 utility::ent_flag( "mech_beam_hit" ) )
    {
        var_a0684ccb4c773bce = isai( var_90ec0886f9ccf215 ) && isdefined( var_90ec0886f9ccf215.subclass ) && issubstr( var_90ec0886f9ccf215.subclass, "zombie_base" );
        damage = calculate_beam_damage( var_90ec0886f9ccf215 );
        var_90ec0886f9ccf215 dodamage( damage, self.origin, self, self, "MOD_PROJECTILE" );
        
        if ( var_a0684ccb4c773bce && damage > var_90ec0886f9ccf215.health )
        {
            var_90ec0886f9ccf215 utility::ent_flag_set( "dissolve" );
        }
        
        if ( sat_libra_mech_turret::function_59fb39487166f319( var_90ec0886f9ccf215 ) )
        {
            if ( !var_90ec0886f9ccf215 utility::ent_flag( "mech_beam_shocked" ) )
            {
                var_90ec0886f9ccf215 utility::ent_flag_set( "mech_beam_shocked" );
                var_90ec0886f9ccf215 thread utility::ent_flag_clear_delayed( "mech_beam_shocked", 3 );
                thread shock_target( var_90ec0886f9ccf215 );
            }
            
            level notify( #"mech_beam_hit_player" );
            var_90ec0886f9ccf215 playsoundevent( %"sndevent_abom_beam_hit_player" );
        }
        
        var_90ec0886f9ccf215 utility::ent_flag_set( "mech_beam_hit" );
        var_90ec0886f9ccf215 thread utility::ent_flag_clear_delayed( "mech_beam_hit", 0.2 );
    }
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0x6d5c5dd5, Offset: 0xc2f
// Size: 0x1e
function private function_24f6c6f448bbc089( end_pos )
{
    radiusdamage( end_pos, 5, 12, 12, self, undefined, undefined, 1 );
}

// Namespace namespace_2bfee0fa87a9007a
// Params 0, eflags: 0x4
// Checksum 0x9dbdbc7, Offset: 0xc55
// Size: 0x5d
function private beam_attack_on_end()
{
    self endon( #"death" );
    self waittill( #"beam_attack_loop_finished" );
    
    if ( isdefined( self.beam_fx ) )
    {
        self.beam_fx delete();
    }
    
    if ( isdefined( self.beam_ent ) )
    {
        self.beam_ent utility::function_7c10ea82c1e305b8( "beam_tip", "end" );
    }
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0xe4a6eeda, Offset: 0xcba
// Size: 0x42
function private cleanup_beam_ents( params )
{
    if ( isdefined( self.beam_fx ) )
    {
        self.beam_fx delete();
    }
    
    if ( isdefined( self.beam_ent ) )
    {
        self.beam_ent delete();
    }
}

// Namespace namespace_2bfee0fa87a9007a
// Params 1, eflags: 0x4
// Checksum 0xe4a38de, Offset: 0xd04
// Size: 0x1f8
function private shock_target( target )
{
    if ( isnullweapon( target getcurrentweapon() ) )
    {
        return;
    }
    
    target endon( #"death" );
    target shellshock( "cer_electric_damage_sp", 2.5, 1, 1 );
    target forceplaygestureviewmodel( "vm_ges_shockstick_react" );
    playfxontagforclients( level._effect[ "shock_hit_player" ], target, "j_head", target );
    playfxontagforclients( level._effect[ "shock_hit_player_arms" ], target, "j_wrist_le", target );
    target.var_61f43ce2d56a201d = 1;
    target val::set( "beam_shocked_player", "weapon_switch", 0 );
    target val::set( "beam_shocked_player", "reload", 0 );
    target val::set( "beam_shocked_player", "fire", 0 );
    target val::set( "beam_shocked_player", "mount_side", 0 );
    target val::set( "beam_shocked_player", "mount_top", 0 );
    target val::set( "beam_shocked_player", "mantle", 0 );
    target val::set( "beam_shocked_player", "offhand_weapons", 0 );
    target val::set( "beam_shocked_player", "supers", 0 );
    target val::set( "beam_shocked_player", "melee", 0 );
    target val::set( "beam_shocked_player", "ads", 0 );
    target val::set( "beam_shocked_player", "slide", 0 );
    target val::set( "beam_shocked_player", "sprint", 0 );
    target val::set( "beam_shocked_player", "supersprint", 0 );
    wait 3;
    target.var_61f43ce2d56a201d = undefined;
    target val::reset_all( "beam_shocked_player" );
    target stopgestureviewmodel( "vm_ges_shockstick_react", 2 );
    stopfxontagforclients( level._effect[ "shock_hit_player" ], target, "j_head", target );
    stopfxontagforclients( level._effect[ "shock_hit_player_arms" ], target, "j_wrist_le", target );
}

/#

    // Namespace namespace_2bfee0fa87a9007a
    // Params 3, eflags: 0x4
    // Checksum 0x70b672ca, Offset: 0xf04
    // Size: 0xe1, Type: dev
    function private debug_beam( source_pos, end_pos, desired_end_pos )
    {
        if ( getdvarint( @"debug_mech_beam", 0 ) > 0 )
        {
            point = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 30 ) + get_head_forward() * 1000;
            sphere( point, 30, ( 1, 0, 0 ), 0, 1 );
            sphere( desired_end_pos, 30, ( 0, 1, 0 ), 0, 1 );
            sphere( end_pos, 30, ( 0, 0, 1 ), 0, 1 );
            line( source_pos, point, ( 1, 0, 0 ), 1, 0 );
        }
    }

#/
