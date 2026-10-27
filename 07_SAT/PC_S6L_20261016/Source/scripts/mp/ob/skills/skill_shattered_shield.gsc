// scripts\mp\ob\skills\skill_shattered_shield.gsc  (hash_4c1b31fd714125d5.gscc) (size: 4679 Bytes / 0x1247 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7701921 (3346012449)
// size ...... 4679 (0x1247)
// includes .. 4   (offset: 0x1137)
// strings ... 9   (offset: 0x1157)
// dev strs .. 9   (offset: 0x11db)
// exports ... 16  (offset: 0xa27)
// cseg ...... 0x104 + 0x923 (0xa27)
// imports ... 39  (offset: 0xca7)
// animtree1 . 0   (offset: 0x1247)
// animtree2 . 0   (offset: 0x1247)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_shattered_shield;

// Namespace skill_shattered_shield
// Params 0, eflags: 0x1
// Checksum 0x19b93538, Offset: 0x122
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"shattered_shield", &init );
}

// Namespace skill_shattered_shield
// Params 0
// Checksum 0x817e5ee1, Offset: 0x141
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"shattered_shield", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"shattered_shield", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"shattered_shield", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0xd4710fd8, Offset: 0x1a5
// Size: 0x80
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.shatteredshieldstunduration )
    {
        skill_bundle.stundata = { #var_c27a2418f1d8f32d:1, #aistunduration:skill_bundle.shatteredshieldstunduration, #playersstunduration:skill_bundle.shatteredshieldstunduration, #stunradius:skill_bundle.shatteredshieldradius, #source:#"shattered_shield" };
    }
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0xf85b860a, Offset: 0x22d
// Size: 0x148, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.shatteredshieldradius, "<dev string:x24>" );
    assert( skill_bundle.var_d95c563e7234c7c9, "<dev string:x6a>" );
    assert( skill_bundle.var_2541b904b890264d, "<dev string:xbb>" );
    assert( skill_bundle.var_5f469a4e24335059, "<dev string:x109>" );
    assert( skill_bundle.var_c06ab922a8b34828, "<dev string:x15c>" );
    assert( skill_bundle.var_1a78d3f553c27fce, "<dev string:x1a8>" );
    assert( skill_bundle.shatteredshieldstunduration, "<dev string:x1f5>" );
    self.var_f05c6e0b73f67460 = { #var_b02d916a28bce41:undefined, #bundle:skill_bundle };
    
    if ( skill_bundle.var_aaa42cd3750b696 )
    {
        assert( skill_bundle.var_1d4ed455777ce37, "<dev string:x241>" + skill_bundle.asset + "<dev string:x257>" );
        self.var_f05c6e0b73f67460.var_b02d916a28bce41 = 0;
    }
    
    callback::add( "on_armor_break", &on_full_armor_break );
    callback::add( #"hash_a359ccbee608ee6f", &function_e64d8a669ca050df );
    return true;
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0xbe0ede53, Offset: 0x37e
// Size: 0x72
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"shattered_shield_end" );
    self.var_f05c6e0b73f67460 = undefined;
    
    if ( callback::exists( "on_armor_break", &on_full_armor_break ) )
    {
        callback::remove( "on_armor_break", &on_full_armor_break );
    }
    
    if ( callback::exists( #"hash_a359ccbee608ee6f", &function_e64d8a669ca050df ) )
    {
        callback::remove( #"hash_a359ccbee608ee6f", &function_e64d8a669ca050df );
    }
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0xfb9b9868, Offset: 0x3f8
// Size: 0x40
function private function_80af1b301cc54366( bundle )
{
    /#
        dvar_state = getdvarint( @"hash_3a672f7274b7c0af", -1 );
        
        if ( dvar_state != -1 )
        {
            return dvar_state;
        }
    #/
    
    return bundle.var_d95c563e7234c7c9;
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0x73604984, Offset: 0x441
// Size: 0x10b
function private on_full_armor_break( params )
{
    var_da55798eb12048a0 = self.var_f05c6e0b73f67460;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( bundle.var_aaa42cd3750b696 )
    {
        time = gettime();
        
        if ( time > var_da55798eb12048a0.var_b02d916a28bce41 )
        {
            invulnerability_data = { #duration:bundle.var_36ae3478f7cf87b2, #pbg_post_fx:bundle.var_49f028de4999a2c7, #id:"shattered_shield_invulnerability" };
            thread utility::callsharedfunc( #"skills", #"apply_invulnerability", invulnerability_data );
            var_da55798eb12048a0.var_b02d916a28bce41 = time + ( invulnerability_data.duration + bundle.var_1d4ed455777ce37 ) * 1000;
        }
    }
    
    if ( bundle.var_126ef96728fbd556 )
    {
        thread function_242d14352c43a777( params.attacker, bundle );
    }
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0x29286206, Offset: 0x554
// Size: 0x123
function private function_e64d8a669ca050df( params )
{
    if ( params.brokenplate == params.totalplates )
    {
        return;
    }
    
    bundle = self.var_f05c6e0b73f67460.bundle;
    
    if ( function_80af1b301cc54366( bundle ) )
    {
        is_last_plate = params.brokenplate <= 0;
        var_f88c475a941204cc = bundle.var_5f469a4e24335059;
        var_b3553ee4f2219970 = bundle.var_b8cad56fb8b9954e;
        scriptable_state = is_last_plate && bundle.var_aaa42cd3750b696 ? var_b3553ee4f2219970 : var_f88c475a941204cc;
        function_632e884a7470fb29( scriptable_state, bundle );
        stun_enemies( bundle );
        function_b7674fa3a53a67a2( params.attacker, params.smeansofdeath, bundle );
    }
    
    if ( bundle.var_9237052c1068cfcd )
    {
        potential_targets = getaiarrayinradius( self.origin, bundle.shatteredshieldradius );
        function_182a75ebef6556ec( bundle, potential_targets );
    }
}

// Namespace skill_shattered_shield
// Params 0, eflags: 0x4
// Checksum 0x629080df, Offset: 0x67f
// Size: 0xf
function private reset_omnvar_activation()
{
    waitframe();
    self setclientomnvar( "ui_skill_shatteredshield_activated", 0 );
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0x287a7b42, Offset: 0x696
// Size: 0x32
function private stun_enemies( bundle )
{
    self setclientomnvar( "ui_skill_shatteredshield_activated", 1 );
    thread ob_stun::function_f3eb76017907e72f( bundle.stundata );
    thread reset_omnvar_activation();
}

// Namespace skill_shattered_shield
// Params 3, eflags: 0x4
// Checksum 0xc88ed3ab, Offset: 0x6d0
// Size: 0x55
function private function_b7674fa3a53a67a2( attacker, smeansofdeath, bundle )
{
    if ( !bundle.var_d83f59c6b85f557b )
    {
        return;
    }
    
    if ( !attacker )
    {
        return;
    }
    
    if ( utility::ismeleedamage( smeansofdeath ) )
    {
        return;
    }
    
    thread ob_stun::function_c4c4f539eb76482f( bundle.stundata, attacker );
}

// Namespace skill_shattered_shield
// Params 2, eflags: 0x4
// Checksum 0x8b5354d1, Offset: 0x72d
// Size: 0x41
function private function_632e884a7470fb29( scriptable_state, bundle )
{
    scriptable_part = bundle.var_2541b904b890264d;
    
    if ( scriptable_part && scriptable_state )
    {
        utility::function_32b24db3127bff40( scriptable_part, scriptable_state );
    }
}

// Namespace skill_shattered_shield
// Params 2, eflags: 0x4
// Checksum 0xbee1787a, Offset: 0x776
// Size: 0x139
function private function_182a75ebef6556ec( bundle, potential_targets )
{
    foreach ( target in potential_targets )
    {
        if ( target.team == self.team || target._blackboard.invehicle )
        {
            continue;
        }
        
        if ( target.type == "zombie" )
        {
            target dodamage( bundle.var_c06ab922a8b34828, target.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
            continue;
        }
        
        if ( target.type == "human" )
        {
            target dodamage( bundle.var_1a78d3f553c27fce, target.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
        }
    }
}

// Namespace skill_shattered_shield
// Params 2, eflags: 0x4
// Checksum 0x6719b779, Offset: 0x8b7
// Size: 0x138
function private function_242d14352c43a777( entity, bundle )
{
    if ( function_53cde647e319559a( entity ) )
    {
        player_forward = vectornormalize( anglestoforward( self getplayerangles( 1 ) ) );
        forward_pos = self geteye() + player_forward * bundle.var_2ed5df380e92e53e;
        var_7bf66648a3f62aa9 = { #skill_name:#"shattered_shield", #cooldown:bundle.var_c5aeb1392a7edb29, #var_3b55b60765b98d29:[ 1, 2 ], #weights_table:bundle.var_135e7f2a8ec34fa0, #shitloc:"none", #vpoint:forward_pos, #idamage:0, #inflictor:entity, #probability:bundle.var_126ef96728fbd556, #player:self };
        
        if ( utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
        {
            entity utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", var_7bf66648a3f62aa9 );
        }
    }
}

// Namespace skill_shattered_shield
// Params 1, eflags: 0x4
// Checksum 0x1653e7b, Offset: 0x9f7
// Size: 0x2f, Type: bool
function private function_53cde647e319559a( ent )
{
    if ( !isalive( self ) || !isalive( ent ) || !isagent( ent ) )
    {
        return false;
    }
    
    return true;
}

