// scripts\mp\zm\ztron\ztron_lightning_chain.gsc  (hash_047dd6ff2a6720f8.gscc) (size: 6967 Bytes / 0x1b37 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9e534de (3118806238)
// size ...... 6967 (0x1b37)
// includes .. 5   (offset: 0x18c3)
// strings ... 41  (offset: 0x18eb)
// dev strs .. 0   (offset: 0x1b37)
// exports ... 10  (offset: 0x114b)
// cseg ...... 0x408 + 0xd43 (0x114b)
// imports ... 50  (offset: 0x12db)
// animtree1 . 0   (offset: 0x1b37)
// animtree2 . 0   (offset: 0x1b37)
#using scripts\common\ai;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\weapons\lightning_chain;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_lightning_chain;

// Namespace ztron_lightning_chain
// Params 0, eflags: 0x5
// Checksum 0xf6b7b41c, Offset: 0x426
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_lightning_chain", #"lightning_chain", &pre_main, undefined );
}

// Namespace ztron_lightning_chain
// Params 0, eflags: 0x4
// Checksum 0x7d40c4db, Offset: 0x44f
// Size: 0x20
function private pre_main()
{
    utility::registersharedfunc( #"lightning_chain", #"init", &init );
}

// Namespace ztron_lightning_chain
// Params 0, eflags: 0x4
// Checksum 0x5849b32c, Offset: 0x477
// Size: 0x16f
function private init()
{
    level._effect[ "tesla_shock_on_pap2" ] = loadfxasset( "vfx_sat_zm_tesla_elec_torso_ch_purple_ztron" );
    level._effect[ "tesla_bolt_pap2" ] = loadfxasset( "vfx_sat_zm_weapons_tesla_elec_bolt_01_purple_ztron" );
    level._effect[ "tesla_shock_pap2" ] = loadfxasset( "vfx_sat_zm_tesla_shock_purple_ztron" );
    level._effect[ "tesla_shock_eyes_pap2" ] = loadfxasset( "vfx_sat_zm_weapons_tesla_shock_eye_purple_ztron" );
    level._effect[ "tesla_shock_mouth_pap2" ] = loadfxasset( "vfx_sat_zm_weapons_tesla_shock_mouth_purple_ztron" );
    level._effect[ "tesla_shock_ground_pap2" ] = loadfxasset( "vfx_sat_zm_tesla_shock_ground_purple_ztron" );
    utility::registersharedfunc( #"lightning_chain", #"lc_expand", &lc_expand );
    utility::registersharedfunc( #"lightning_chain", #"lc_stun_and_damage", &lc_stun_and_damage );
    utility::registersharedfunc( #"lightning_chain", #"lc_play_stun_fx", &lc_play_stun_fx );
    utility::registersharedfunc( #"lightning_chain", #"lc_damage_calculation", &lc_damage_calculation );
    level.ztron.var_7cae2e380e0347ab = [];
    level.ztron.var_7cae2e380e0347ab[ 0 ] = 100;
    level.ztron.var_7cae2e380e0347ab[ 1 ] = 100;
    level.ztron.var_7cae2e380e0347ab[ 2 ] = 100;
}

// Namespace ztron_lightning_chain
// Params 3, eflags: 0x4
// Checksum 0x48fdf2e4, Offset: 0x5ee
// Size: 0x1bf
function private lc_expand( start_point, count_left, params )
{
    var_d61135157d642a8f = int( min( params.var_dc97cf84d9220187, count_left ) );
    ai_targets = getaiarrayinradius( start_point, params.arc_radius );
    filtered_ai_targets = [];
    
    foreach ( ai in ai_targets )
    {
        if ( ai lightning_chain::function_7060ea3387a52416( params ) )
        {
            continue;
        }
        
        filtered_ai_targets[ filtered_ai_targets.size ] = ai;
    }
    
    var_d61135157d642a8f = int( min( filtered_ai_targets.size, var_d61135157d642a8f ) );
    
    if ( var_d61135157d642a8f == 0 )
    {
        return 0;
    }
    
    filtered_ai_targets = sortbydistance( filtered_ai_targets, start_point );
    
    for ( i = 0; i < var_d61135157d642a8f ; i++ )
    {
        level thread function_36f0e2930c537867( start_point, filtered_ai_targets[ i ], params );
    }
    
    if ( params.var_fff5dc5501f9e352 )
    {
        while ( i > 0 && filtered_ai_targets[ i - 1 ] ai::is_boss() )
        {
            i--;
        }
    }
    else
    {
        while ( i > 0 && filtered_ai_targets[ i - 1 ] ai::is_non_base() )
        {
            i--;
        }
    }
    
    if ( i == 0 )
    {
        return;
    }
    
    next_start_point = lightning_chain::function_edaa39ee22ae128b( filtered_ai_targets[ i - 1 ] );
    count_left -= var_d61135157d642a8f;
    
    if ( count_left > 0 )
    {
        level thread lightning_chain::function_dd36404d9835d6b2( params.arc_travel_time + 0.1, next_start_point, count_left, params );
    }
}

// Namespace ztron_lightning_chain
// Params 3
// Checksum 0xd5e5ae0c, Offset: 0x7b5
// Size: 0x142
function function_36f0e2930c537867( start_point, ai_target, params )
{
    end_point = lightning_chain::function_edaa39ee22ae128b( ai_target );
    
    if ( !isdefined( end_point ) )
    {
        return;
    }
    
    var_a542a8f69a73e0fa = utility::spawn_tag_origin( start_point );
    var_a542a8f69a73e0fa show();
    
    if ( params.var_516d207140d59c2 > 1 && isdefined( level._effect[ "tesla_bolt_pap2" ] ) )
    {
        bolt_fx = "tesla_bolt_pap2";
    }
    else if ( params.var_516d207140d59c2 > 0 )
    {
        bolt_fx = "tesla_bolt_pap";
    }
    else
    {
        bolt_fx = "tesla_bolt";
    }
    
    fx_id = level._effect[ bolt_fx ];
    
    if ( isdefined( params.var_ff926fba88e29825 ) )
    {
        fx_id = params.var_ff926fba88e29825;
    }
    
    fx = playfxontag( fx_id, var_a542a8f69a73e0fa, "tag_origin" );
    var_a542a8f69a73e0fa moveto( end_point, params.arc_travel_time );
    var_a542a8f69a73e0fa waittill( #"movedone" );
    var_a542a8f69a73e0fa delete();
    
    if ( isalive( ai_target ) )
    {
        ai_target thread utility::callsharedfunc( #"lightning_chain", #"lc_stun_and_damage", 0, params );
    }
}

// Namespace ztron_lightning_chain
// Params 2, eflags: 0x4
// Checksum 0x8b90b1d6, Offset: 0x8ff
// Size: 0x3ab
function private lc_stun_and_damage( var_f191c2408c95ef7, params )
{
    self endon( #"death" );
    
    if ( self.lc_stunned )
    {
        return;
    }
    
    if ( isdefined( params.var_53ad54fe8805dda3 ) )
    {
        if ( !self [[ params.var_53ad54fe8805dda3 ]]() )
        {
            return;
        }
    }
    else if ( !should_stun_ai( params ) )
    {
        lightning_chain::lc_do_damage( params );
        
        if ( !isdefined( self.lc_records ) )
        {
            self.lc_records = [];
            return;
        }
        
        self.lc_records = arraycombineunique( self.lc_records, [ params.lc_id ] );
        return;
    }
    
    duration = ( params.stun_duration ?? 3 ) + ( randomint( 10 ) - 5 ) * 0.1;
    
    if ( self.type == "zombie" && isdefined( self.aicategory ) )
    {
        if ( self.aicategory == "normal" )
        {
            duration = params.var_a4b06b7d5862ddea ?? duration;
        }
        else if ( self.aicategory == "special" )
        {
            duration = params.var_ae23bfd4b4acd418 ?? duration;
        }
        else if ( self.aicategory == "elite" || self.aicategory == "hvt" )
        {
            duration = params.var_bf1f7231596f25bc ?? duration;
        }
    }
    
    if ( params.var_7a514800b212feb9 && self.aicategory == "normal" )
    {
        thread lightning_chain::function_63083e0eb079e32d( params, duration );
    }
    
    switch ( self.type )
    {
        case #"hash_f695947f7a9ce23f":
            if ( utility::issharedfuncdefined( #"effect_stun", #"stun" ) )
            {
                utility::callsharedfunc( #"effect_stun", #"stun", params.weapon.basename, duration, params.eattacker, undefined, undefined, "electrical" );
            }
            
            break;
        case #"hash_207629acc9a1e5a":
            thread lightning_chain::function_3dcee24de3aa889a( duration + 1 );
            break;
    }
    
    self.lc_stunned = 1;
    self.var_230f79da4bf6cf4a = gettime() + utility::function_4b74c15943231980( duration );
    self notify( #"zombie_lc_stunned" );
    utility::callsharedfunc( #"lightning_chain", #"lc_play_stun_fx", var_f191c2408c95ef7, params );
    
    if ( params.var_516d207140d59c2 > 1 )
    {
        self.lc_stunned_pap = 1;
        
        if ( isdefined( self.model ) && isdefined( level._effect[ "tesla_shock_on_pap2" ] ) && utility::hastag( self.model, "j_spineupper" ) )
        {
            ztron_vfx::function_a2884eba34f8ea6b( level._effect[ "tesla_shock_on_pap2" ], self, "j_spineupper" );
        }
        else if ( !utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_on_paped" ) )
        {
            utility::function_32b24db3127bff40( "shocked_tesla_storm", "shocked_tesla_storm_on" );
        }
    }
    else
    {
        self.lc_stunned_pap = 0;
        
        if ( !utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_on" ) )
        {
            utility::function_32b24db3127bff40( "shocked_tesla_storm", "shocked_tesla_storm_on" );
        }
    }
    
    self.lc_record = params.lc_id;
    thread lightning_chain::lc_do_tick_damage_ai( params, duration );
    wait duration;
    self.lc_stunned = 0;
    self.lc_stunned_pap = 0;
    
    if ( !utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_off" ) )
    {
        utility::function_32b24db3127bff40( "shocked_tesla_storm", "shocked_tesla_storm_off" );
    }
}

// Namespace ztron_lightning_chain
// Params 1, eflags: 0x4
// Checksum 0xd00f4c73, Offset: 0xcb2
// Size: 0x36, Type: bool
function private should_stun_ai( params )
{
    if ( ai::is_boss() )
    {
        return false;
    }
    
    if ( isdefined( params.var_a4b06b7d5862ddea ) )
    {
        return true;
    }
    
    if ( ai::is_non_base() )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_lightning_chain
// Params 2, eflags: 0x4
// Checksum 0x4d35da5c, Offset: 0xcf1
// Size: 0x307
function private lc_play_stun_fx( var_f191c2408c95ef7, params )
{
    if ( params.var_516d207140d59c2 > 0 )
    {
        paped = 1;
    }
    else
    {
        paped = 0;
    }
    
    tag = "J_SpineUpper";
    
    if ( params.var_516d207140d59c2 > 1 && isdefined( level._effect[ "tesla_shock_pap2" ] ) )
    {
        shock_fx = "tesla_shock_pap2";
    }
    else if ( paped )
    {
        shock_fx = "tesla_shock_pap";
    }
    else
    {
        shock_fx = "tesla_shock";
    }
    
    if ( var_f191c2408c95ef7 )
    {
        if ( params.var_516d207140d59c2 > 1 && isdefined( level._effect[ "tesla_shock_ground_pap2" ] ) )
        {
            ground_fx = "tesla_shock_ground_pap2";
        }
        else if ( paped )
        {
            ground_fx = "tesla_shock_ground_pap";
        }
        else
        {
            ground_fx = "tesla_shock_ground";
        }
        
        ground_fx_id = level._effect[ ground_fx ];
        
        if ( isdefined( params.ground_fx_id_override ) )
        {
            ground_fx_id = params.ground_fx_id_override;
        }
        
        playfxontag( ground_fx_id, self, "tag_origin" );
    }
    else
    {
        shock_fx = undefined;
    }
    
    if ( isdefined( shock_fx ) && utility::hastag( self.model, tag ) )
    {
        shock_fx_id = level._effect[ shock_fx ];
        
        if ( isdefined( params.shock_fx_id_override ) )
        {
            shock_fx_id = params.shock_fx_id_override;
        }
        
        playfxontag( shock_fx_id, self, tag );
    }
    
    if ( params.should_gib_head && isdefined( self.aicategory ) && self.aicategory == "normal" && !self.head_gibbed )
    {
        if ( randomint( 100 ) < params.head_gib_chance )
        {
            self.var_6a6a43836cde0417 = 1;
            return;
        }
        
        if ( self tagexists( "J_EyeBall_LE" ) )
        {
            if ( params.var_516d207140d59c2 > 1 )
            {
                eye_fx = isdefined( level._effect[ "tesla_shock_eyes_pap2" ] ) ? "tesla_shock_eyes_pap2" : "tesla_shock_mouth_pap";
                mouth_fx = isdefined( level._effect[ "tesla_shock_mouth_pap2" ] ) ? "tesla_shock_mouth_pap2" : "tesla_shock_mouth_pap";
            }
            else if ( paped )
            {
                eye_fx = "tesla_shock_eyes_pap";
                mouth_fx = "tesla_shock_mouth_pap";
            }
            else
            {
                eye_fx = "tesla_shock_eyes";
                mouth_fx = "tesla_shock_mouth";
            }
            
            eye_fx_id = level._effect[ eye_fx ];
            
            if ( isdefined( params.eye_fx_id_override ) )
            {
                eye_fx_id = params.eye_fx_id_override;
            }
            
            mouth_fx_id = level._effect[ mouth_fx ];
            
            if ( isdefined( params.mouth_fx_id_override ) )
            {
                mouth_fx_id = params.mouth_fx_id_override;
            }
            
            playfxontag( eye_fx_id, self, "J_EyeBall_RI" );
            playfxontag( eye_fx_id, self, "J_EyeBall_LE" );
            playfxontag( mouth_fx_id, self, "J_Head" );
        }
    }
}

// Namespace ztron_lightning_chain
// Params 1, eflags: 0x4
// Checksum 0x69adf081, Offset: 0x1000
// Size: 0x14b
function private lc_damage_calculation( params )
{
    if ( isplayer( self ) )
    {
        if ( params.tdot )
        {
            return ( params.var_8953d5d1a11c5cfd ?? getdvarint( @"hash_e951b3efc51435d9", 25 ) );
        }
        
        return ( params.player_damage ?? getdvarint( @"hash_49d1b75ff4c19854", 75 ) );
    }
    
    if ( utility::issharedfuncdefined( #"lightning_chain", #"hash_d8c9695ff733902" ) )
    {
        n_damage = utility::callsharedfunc( #"lightning_chain", #"hash_d8c9695ff733902" );
        
        if ( isdefined( n_damage ) )
        {
            return n_damage;
        }
    }
    
    if ( isnumber( params.lc_damage ) )
    {
        return params.lc_damage;
    }
    
    if ( ai::is_non_base() )
    {
        var_516d207140d59c2 = minint( params.var_516d207140d59c2 ?? 0, level.ztron.var_7cae2e380e0347ab.size - 1 );
        return level.ztron.var_7cae2e380e0347ab[ var_516d207140d59c2 ];
    }
    
    if ( ai::is_non_base() )
    {
        return level.var_cf7706e013c62841[ params.var_516d207140d59c2 ?? 0 ];
    }
    
    return self.health;
}

