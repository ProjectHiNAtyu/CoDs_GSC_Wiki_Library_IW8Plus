// scripts\mp\ob\skills\skill_taser_shock.gsc  (hash_0cdb06b79e60b953.gscc) (size: 7666 Bytes / 0x1df2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3175ac2a (829795370)
// size ...... 7666 (0x1df2)
// includes .. 8   (offset: 0x1c7e)
// strings ... 12  (offset: 0x1cbe)
// dev strs .. 11  (offset: 0x1d66)
// exports ... 22  (offset: 0x11a2)
// cseg ...... 0x16a + 0x1038 (0x11a2)
// imports ... 61  (offset: 0x1512)
// animtree1 . 0   (offset: 0x1df2)
// animtree2 . 0   (offset: 0x1df2)
#using script_2fe74ee229c972c3;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_taser_shock;

// Namespace skill_taser_shock
// Params 0, eflags: 0x1
// Checksum 0xa765d344, Offset: 0x188
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"taser_shock", &init );
}

// Namespace skill_taser_shock
// Params 0
// Checksum 0xa428b866, Offset: 0x1a7
// Size: 0x7a
function init()
{
    utility::registersharedfunc( #"taser_shock", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"taser_shock", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"taser_shock", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"taser_shock", #"hash_8698c290a2e85469", &get_skill_weapons );
}

// Namespace skill_taser_shock
// Params 1, eflags: 0x4
// Checksum 0x9ae9381d, Offset: 0x229
// Size: 0x149
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_5ae877ae67b55c63 )
    {
        skill_bundle.var_74e61775a7374cdb = skill_bundle.var_5ae877ae67b55c63 * 1000;
    }
    
    if ( skill_bundle.var_c9addbeaa0d2b76a )
    {
        skill_bundle.var_e361594ec2da7c62 = skill_bundle.var_c9addbeaa0d2b76a * 1000;
    }
    
    if ( skill_bundle.var_d78bd03edcc50b78 )
    {
        fx_id = "vfx_taser_shock_victim_sparks_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = loadfxasset( skill_bundle.var_d78bd03edcc50b78 );
        skill_bundle.var_5520c3b23f123165 = fx_id;
    }
    
    if ( skill_bundle.var_f6fa2645710a024c )
    {
        fx_id = "vfx_taser_shock_on_damage_victim_sparks_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = loadfxasset( skill_bundle.var_f6fa2645710a024c );
        skill_bundle.var_48928bc580f8f6c1 = fx_id;
    }
    
    if ( skill_bundle.var_b88e2f6d739e8b15 )
    {
        fx_id = "vfx_taser_shock_on_damage_attacker_sparks_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = loadfxasset( skill_bundle.var_b88e2f6d739e8b15 );
        skill_bundle.var_81a469a83aee3c70 = fx_id;
    }
}

// Namespace skill_taser_shock
// Params 1, eflags: 0x4
// Checksum 0xae7c2417, Offset: 0x37a
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_382a99364f810ca8 ];
}

// Namespace skill_taser_shock
// Params 1, eflags: 0x4
// Checksum 0x278a7a6c, Offset: 0x39f
// Size: 0x102, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_dc4a17391c356ce5, "<dev string:x24>" );
    assert( skill_bundle.var_f1b7479d2fc17e37, "<dev string:x4e>" );
    assert( skill_bundle.tasershockduration, "<dev string:x7d>" );
    assert( skill_bundle.var_2b3385755f1b80c5, "<dev string:xa9>" );
    assert( skill_bundle.var_b7d27aad072df4ba, "<dev string:xdb>" );
    assert( skill_bundle.var_7f509dba190657ab, "<dev string:x10b>" );
    var_3c793eed5f22ab1a = { #var_35432dda4c4b63e8:0, #var_1017e28c7d8f86ed:0, #bundle:skill_bundle };
    assert( !callback::exists( #"hash_2f7a081cd065e655", &function_337e7b0e560736c, var_3c793eed5f22ab1a, 1 ) );
    callback::add( #"hash_2f7a081cd065e655", &function_337e7b0e560736c, var_3c793eed5f22ab1a );
    return true;
}

// Namespace skill_taser_shock
// Params 1, eflags: 0x4
// Checksum 0x9f9b9bd8, Offset: 0x4aa
// Size: 0x40
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"hash_2f7a081cd065e655", &function_337e7b0e560736c, undefined, 1 ) );
    callback::remove( #"hash_2f7a081cd065e655", &function_337e7b0e560736c );
}

// Namespace skill_taser_shock
// Params 2, eflags: 0x4
// Checksum 0xb069bfe0, Offset: 0x4f2
// Size: 0xc0
function private on_killed_body_cloned( aparams, vfx_id )
{
    if ( self.var_ca4816fc2d60d8d1 )
    {
        foreach ( tag in self.var_ca4816fc2d60d8d1 )
        {
            if ( vfx_id && aparams.body tagexists( tag ) )
            {
                thread function_c04ca285d44309f4( aparams.body, tag, vfx_id );
            }
        }
    }
}

// Namespace skill_taser_shock
// Params 3, eflags: 0x4
// Checksum 0x9c96853c, Offset: 0x5ba
// Size: 0x3b
function private function_c04ca285d44309f4( corpse, tag, vfx_id )
{
    stopfxontag( vfx_id, corpse, tag );
    wait 0.5;
    
    if ( corpse )
    {
        stopfxontag( vfx_id, corpse, tag );
    }
}

// Namespace skill_taser_shock
// Params 2, eflags: 0x4
// Checksum 0x63bd0792, Offset: 0x5fd
// Size: 0x71
function private function_337e7b0e560736c( params, var_da55798eb12048a0 )
{
    bundle = var_da55798eb12048a0.bundle;
    
    if ( function_5df395b64494dd63( params, var_da55798eb12048a0, bundle ) )
    {
        for ( i = 0; i < bundle.var_f1b7479d2fc17e37 ; i++ )
        {
            params.victim thread attach_taser( self, params, bundle );
        }
    }
}

// Namespace skill_taser_shock
// Params 3, eflags: 0x4
// Checksum 0x2caff7ca, Offset: 0x676
// Size: 0x167, Type: bool
function private function_5df395b64494dd63( params, var_da55798eb12048a0, bundle )
{
    if ( self.inlaststand )
    {
        return false;
    }
    
    if ( !isalive( params.victim ) )
    {
        return false;
    }
    
    if ( !utility::isbulletdamage( params.smeansofdeath ) )
    {
        return false;
    }
    
    if ( weapon::issuperweapon( params.objweapon.basename ) )
    {
        return false;
    }
    
    if ( !params.partname )
    {
        return false;
    }
    
    if ( params.victim ai::get_ignoreme() )
    {
        return false;
    }
    
    if ( !function_4de5a741f5baa1c4( params.victim, bundle ) )
    {
        return false;
    }
    
    if ( !function_5b0696cfd645fff9( params.victim, params.partname, bundle ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_c76f1d80ea7ae86a", 0 ) )
        {
            return true;
        }
    #/
    
    now = gettime();
    
    if ( is_in_cooldown( var_da55798eb12048a0, bundle, now ) )
    {
        return false;
    }
    
    var_da55798eb12048a0.var_1017e28c7d8f86ed = now + ( bundle.var_74e61775a7374cdb ?? 0 );
    
    if ( !utility::percent_chance( bundle.var_dc4a17391c356ce5 ) )
    {
        return false;
    }
    
    var_da55798eb12048a0.var_35432dda4c4b63e8 = now + ( bundle.var_e361594ec2da7c62 ?? 0 );
    return true;
}

// Namespace skill_taser_shock
// Params 2, eflags: 0x4
// Checksum 0xfbd848c7, Offset: 0x7e6
// Size: 0xa4, Type: bool
function private function_4de5a741f5baa1c4( victim, bundle )
{
    if ( !player_utility::playersareenemies( self, victim ) )
    {
        return false;
    }
    
    if ( victim.type == "zombie" )
    {
        var_c04e417f8531bdb5 = bundle.var_39d330a32d3136c7;
    }
    else if ( victim.type == "human" )
    {
        var_c04e417f8531bdb5 = bundle.var_a3b4c809e819e79a;
    }
    
    if ( var_c04e417f8531bdb5 )
    {
        tier_number = victim ai_utility::get_power_tier();
        assert( tier_number, "<dev string:x13a>" );
        
        if ( tier_number > var_c04e417f8531bdb5 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace skill_taser_shock
// Params 3, eflags: 0x4
// Checksum 0x9c89af3a, Offset: 0x893
// Size: 0xd5, Type: bool
function private function_5b0696cfd645fff9( victim, tag, bundle )
{
    if ( bundle.var_b969c36981933eed && victim.var_ca4816fc2d60d8d1.size >= bundle.var_b969c36981933eed )
    {
        return false;
    }
    
    if ( victim.var_ca4816fc2d60d8d1 )
    {
        foreach ( taser in victim.var_ca4816fc2d60d8d1 )
        {
            if ( taser == tag )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace skill_taser_shock
// Params 3, eflags: 0x4
// Checksum 0xd5b4ca6a, Offset: 0x971
// Size: 0x65, Type: bool
function private is_in_cooldown( var_da55798eb12048a0, bundle, now )
{
    if ( bundle.var_e361594ec2da7c62 && now < var_da55798eb12048a0.var_35432dda4c4b63e8 )
    {
        return true;
    }
    
    if ( bundle.var_74e61775a7374cdb && now < var_da55798eb12048a0.var_1017e28c7d8f86ed )
    {
        return true;
    }
    
    return false;
}

// Namespace skill_taser_shock
// Params 3, eflags: 0x4
// Checksum 0x77de9de0, Offset: 0x9df
// Size: 0x3c9
function private attach_taser( attacker, params, bundle )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    tag = params.partname;
    original_damage_context = { #originalangles:params.victim.angles, #originaldir:params.vdir };
    
    if ( !isdefined( self.var_ca4816fc2d60d8d1 ) )
    {
        self.var_ca4816fc2d60d8d1 = [];
    }
    
    var_ab44c4a15c5da65d = !function_f2448ab6b6514be1( tag );
    self.var_ca4816fc2d60d8d1[ self.var_ca4816fc2d60d8d1.size ] = tag;
    
    /#
        if ( getdvarint( @"hash_56edd46144f4364e", 0 ) )
        {
            iprintlnbold( "<dev string:x15b>" + self.var_ca4816fc2d60d8d1.size );
        }
    #/
    
    if ( self.type == "zombie" )
    {
        damage = bundle.var_b7d27aad072df4ba;
    }
    else if ( self.type == "human" )
    {
        damage = bundle.var_7f509dba190657ab;
    }
    
    assert( damage, "<dev string:x18c>" + self.type );
    
    if ( var_ab44c4a15c5da65d )
    {
        function_72181b270c141263( bundle, tag );
    }
    
    attacker apply_one_time_vfx( bundle.var_81a469a83aee3c70, bundle.var_e2eaa86d923ee312, "tag_flash", attacker.origin );
    
    if ( bundle.var_cd0bbe4dd544b119 )
    {
        attacker function_fd928c67b484298d( self, bundle );
    }
    
    interval = bundle.var_2b3385755f1b80c5;
    var_3acd113c32d5235b = int( bundle.tasershockduration / interval );
    
    for ( i = 0; i < var_3acd113c32d5235b ; i++ )
    {
        msg = utility::waittill_any_timeout( interval, "taser_shock_turned" );
        
        if ( msg == "taser_shock_turned" )
        {
            break;
        }
        
        if ( !self tagexists( tag ) )
        {
            break;
        }
        
        tag_position = self gettagorigin( tag );
        callback::add( #"hash_70c49d15a6f8da89", &function_556a0424588b0426, original_damage_context );
        self dodamage( damage, tag_position, attacker, attacker, "MOD_ELEMENTAL_ELEC", bundle.var_382a99364f810ca8, "torso_upper" );
        callback::remove( #"hash_70c49d15a6f8da89", &function_556a0424588b0426 );
        apply_one_time_vfx( bundle.var_48928bc580f8f6c1, bundle.var_cc9ead45526bdd4f, tag, tag_position );
    }
    
    foreach ( index, entry in self.var_ca4816fc2d60d8d1 )
    {
        if ( entry == tag )
        {
            self.var_ca4816fc2d60d8d1[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( self.var_ca4816fc2d60d8d1 );
            }
            
            break;
        }
    }
    
    if ( self.var_ca4816fc2d60d8d1.size == 0 )
    {
        assert( callback::exists( "<dev string:x1c2>", &on_killed_body_cloned, undefined, 1 ) );
        callback::remove( "killed_body_cloned", &on_killed_body_cloned );
        assert( callback::exists( "<dev string:x1d5>", &on_turned ) );
        callback::remove( "on_turned", &on_turned );
        self.var_ca4816fc2d60d8d1 = undefined;
    }
    
    if ( !function_f2448ab6b6514be1( tag ) )
    {
        self notify( "taser_shock_removed_" + tag, tag );
    }
}

// Namespace skill_taser_shock
// Params 2, eflags: 0x4
// Checksum 0x29697289, Offset: 0xdb0
// Size: 0x11a
function private function_fd928c67b484298d( victim, bundle )
{
    assert( bundle.var_645aabe511cc7eb5 );
    
    if ( victim.var_cc997278e6e6e01[ #"taser_shock" ] )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"hash_ed46e37d3efd53d3" ) && victim utility::callsharedfunc( #"zombie_utils", #"hash_ed46e37d3efd53d3" ) )
    {
        return;
    }
    
    if ( bundle.var_886d2e0ac0b783f )
    {
        enemy_tier = victim ai_utility::get_power_tier();
        
        if ( enemy_tier && enemy_tier > bundle.var_886d2e0ac0b783f )
        {
            return;
        }
    }
    
    if ( !utility::percent_chance( bundle.var_cd0bbe4dd544b119 ) )
    {
        return;
    }
    
    stun_data = { #aistunduration:bundle.var_645aabe511cc7eb5, #source:#"taser_shock", #stunorigin:victim.origin };
    thread ob_stun::function_c4c4f539eb76482f( stun_data, victim );
}

// Namespace skill_taser_shock
// Params 4, eflags: 0x4
// Checksum 0x6ea14724, Offset: 0xed2
// Size: 0x6b
function private apply_one_time_vfx( vfx_key, var_6154b136827fcee6, tag, var_fc556adf6144d481 )
{
    vfx_id = vfx_key ? utility::getfx( vfx_key ) : undefined;
    
    if ( vfx_id && self tagexists( tag ) )
    {
        playfxontag( vfx_id, self, tag );
    }
    
    if ( var_6154b136827fcee6 )
    {
        playsoundatpos( var_fc556adf6144d481, var_6154b136827fcee6 );
    }
}

// Namespace skill_taser_shock
// Params 2, eflags: 0x4
// Checksum 0x885bed08, Offset: 0xf45
// Size: 0xfd
function private function_72181b270c141263( bundle, tag )
{
    vfx_id = bundle.var_5520c3b23f123165 ? utility::getfx( bundle.var_5520c3b23f123165 ) : undefined;
    
    if ( vfx_id )
    {
        playfxontag( vfx_id, self, tag );
    }
    
    is_first_taser = self.var_ca4816fc2d60d8d1.size == 1;
    
    if ( is_first_taser )
    {
        if ( bundle.var_20299f3f1206e763 )
        {
            self playloopsound( bundle.var_20299f3f1206e763 );
        }
        
        assert( !callback::exists( "<dev string:x1c2>", &on_killed_body_cloned, undefined, 1 ) );
        callback::add( "killed_body_cloned", &on_killed_body_cloned, vfx_id );
        assert( !callback::exists( "<dev string:x1d5>", &on_turned ) );
        callback::add( "on_turned", &on_turned );
    }
    
    thread function_91e1023158b59d33( vfx_id, bundle.var_20299f3f1206e763, tag );
}

// Namespace skill_taser_shock
// Params 3, eflags: 0x4
// Checksum 0x39ba2b41, Offset: 0x104a
// Size: 0x77
function private function_91e1023158b59d33( vfx_id, var_a19d5d0e7a3d5227, tag )
{
    self endon( #"death" );
    self endon( #"game_ended" );
    self waittill( "taser_shock_removed_" + tag );
    
    if ( vfx_id && self tagexists( tag ) )
    {
        stopfxontag( vfx_id, self, tag );
    }
    
    if ( !self.var_ca4816fc2d60d8d1 && var_a19d5d0e7a3d5227 )
    {
        self stoploopsound( var_a19d5d0e7a3d5227 );
    }
}

// Namespace skill_taser_shock
// Params 1, eflags: 0x4
// Checksum 0x7c11673c, Offset: 0x10c9
// Size: 0x93, Type: bool
function private function_f2448ab6b6514be1( tag )
{
    if ( self.var_ca4816fc2d60d8d1 )
    {
        foreach ( taser in self.var_ca4816fc2d60d8d1 )
        {
            if ( taser == tag )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace skill_taser_shock
// Params 1, eflags: 0x4
// Checksum 0x32550e3a, Offset: 0x1165
// Size: 0x18
function private on_turned( params )
{
    self notify( #"taser_shock_turned" );
}

// Namespace skill_taser_shock
// Params 2, eflags: 0x4
// Checksum 0xfdccf951, Offset: 0x1185
// Size: 0x1c
function private function_556a0424588b0426( params, original_damage_context )
{
    return [ original_damage_context ];
}

