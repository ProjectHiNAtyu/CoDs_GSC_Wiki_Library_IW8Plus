// script_38e58e8a44ad61f5  (hash_38e58e8a44ad61f5.gscc) (size: 8701 Bytes / 0x21fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a91ea7c (1251076732)
// size ...... 8701 (0x21fd)
// includes .. 9   (offset: 0x2081)
// strings ... 10  (offset: 0x20c9)
// dev strs .. 13  (offset: 0x215d)
// exports ... 25  (offset: 0x13ed)
// cseg ...... 0x141 + 0x12ac (0x13ed)
// imports ... 74  (offset: 0x17d5)
// animtree1 . 0   (offset: 0x21fd)
// animtree2 . 0   (offset: 0x21fd)
#using script_26bdd21dbb5b5fc8;
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_dismemberment;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ob\systems\ob_stun;

#namespace namespace_50771774fedd8a78;

// Namespace namespace_50771774fedd8a78
// Params 0, eflags: 0x1
// Checksum 0xfb429d4d, Offset: 0x15f
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"explosive_delivery", &init );
}

// Namespace namespace_50771774fedd8a78
// Params 0, eflags: 0x4
// Checksum 0xf1a7f524, Offset: 0x17e
// Size: 0x7a
function private init()
{
    utility::registersharedfunc( #"explosive_delivery", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"explosive_delivery", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"explosive_delivery", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"explosive_delivery", #"hash_8698c290a2e85469", &get_skill_weapons );
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x959800ca, Offset: 0x200
// Size: 0xdd
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_b421636cf6a54df4 )
    {
        skill_bundle.var_63786036e5ba5698 = skill_bundle.var_b421636cf6a54df4 * 1000;
    }
    
    if ( skill_bundle.var_3e1169c1af9c3a8 )
    {
        fx_id_name = "explosive_delivery_explosion_vfx_" + skill_bundle.skilllevel;
        level._effect[ fx_id_name ] = loadfxasset( skill_bundle.var_3e1169c1af9c3a8 );
        skill_bundle.var_b56613742aa6e595 = fx_id_name;
    }
    
    if ( skill_bundle.var_5dce598ac65cd951 )
    {
        var_36bc132c13c58d3b = "explosive_delivery_warning_vfx_" + skill_bundle.skilllevel;
        level._effect[ var_36bc132c13c58d3b ] = loadfxasset( skill_bundle.var_5dce598ac65cd951 );
        skill_bundle.var_4e7de67ec753e924 = var_36bc132c13c58d3b;
    }
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x62423913, Offset: 0x2e5
// Size: 0x14d, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_6472fb77be8991af, "<dev string:x24>" );
    assert( skill_bundle.var_cc72e7149420a9db, "<dev string:x5f>" );
    assert( skill_bundle.var_63786036e5ba5698, "<dev string:xa4>" );
    assert( skill_bundle.var_e07894aa927a454a, "<dev string:xd9>" );
    assert( skill_bundle.var_55566c226e6d7085, "<dev string:x117>" );
    assert( skill_bundle.var_6a722898126c93d6, "<dev string:x155>" );
    assert( skill_bundle.var_2758d34d171d56a7, "<dev string:x192>" );
    assert( skill_bundle.var_f764646633256f73, "<dev string:x1d3>" );
    assert( skill_bundle.var_d6003b873584d698, "<dev string:x20e>" );
    self.var_51e356a79e28a7e = { #var_680df4badee6da0d:undefined, #var_87449c973343263:undefined, #var_3cc547d7025a5c04:0, #bundle:skill_bundle };
    
    if ( skill_bundle.var_f0d4635d48fb8e9f )
    {
        zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    }
    
    if ( skill_bundle.var_9ceb815d07d283bf )
    {
        agent_utils::function_bc89b9076dd93902( &function_17fdfda41f9aa95a );
    }
    
    return true;
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x983767d1, Offset: 0x43b
// Size: 0x49
function private get_skill_weapons( skill_bundle )
{
    result = [ skill_bundle.var_d6003b873584d698 ];
    
    if ( skill_bundle.var_25e40e7bc2651998 )
    {
        result[ result.size ] = skill_bundle.var_25e40e7bc2651998;
    }
    
    return result;
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x9c0da165, Offset: 0x48d
// Size: 0x4a
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_f0d4635d48fb8e9f )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &function_17fdfda41f9aa95a );
    }
    
    if ( skill_bundle.var_9ceb815d07d283bf )
    {
        agent_utils::function_def5273cfe3c9109( &function_17fdfda41f9aa95a );
    }
    
    self.var_51e356a79e28a7e = undefined;
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x881ee969, Offset: 0x4df
// Size: 0x73
function private function_17fdfda41f9aa95a( dmg_struct )
{
    attacker = dmg_struct.eattacker;
    var_da55798eb12048a0 = attacker.var_51e356a79e28a7e;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !function_4f491080d71fa328( var_da55798eb12048a0, bundle, dmg_struct ) )
    {
        return dmg_struct.idamage;
    }
    
    thread function_58a9a49a963af2b( attacker, var_da55798eb12048a0, bundle );
    return 0;
}

// Namespace namespace_50771774fedd8a78
// Params 3, eflags: 0x4
// Checksum 0xdc24e42c, Offset: 0x55b
// Size: 0x14a, Type: bool
function private function_4f491080d71fa328( var_da55798eb12048a0, bundle, dmg_struct )
{
    if ( !utility::isbulletdamage( dmg_struct.smeansofdeath ) )
    {
        return false;
    }
    
    if ( zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( zombie_dismemberment::is_crawling() )
    {
        return false;
    }
    
    enemy_tier = ai_utility::get_power_tier();
    
    if ( enemy_tier && enemy_tier > bundle.var_f764646633256f73 )
    {
        return false;
    }
    
    inflictor = dmg_struct.einflictor;
    
    if ( inflictor && inflictor zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( var_da55798eb12048a0.var_3cc547d7025a5c04 >= bundle.var_cc72e7149420a9db )
    {
        return false;
    }
    
    if ( var_da55798eb12048a0.var_87449c973343263 && gettime() - var_da55798eb12048a0.var_87449c973343263 < bundle.var_63786036e5ba5698 )
    {
        return false;
    }
    
    var_dd4e6b80d55fa6b3 = self.health - dmg_struct.idamage;
    health_threshold = self.maxhealth * bundle.var_6a722898126c93d6;
    
    if ( var_dd4e6b80d55fa6b3 > health_threshold )
    {
        return false;
    }
    
    if ( !utility::percent_chance( bundle.var_6472fb77be8991af ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_50771774fedd8a78
// Params 3, eflags: 0x4
// Checksum 0x5455d9bc, Offset: 0x6ae
// Size: 0x11c
function private function_58a9a49a963af2b( attacker, var_da55798eb12048a0, bundle )
{
    var_da55798eb12048a0.var_3cc547d7025a5c04++;
    var_da55798eb12048a0.var_87449c973343263 = gettime();
    var_da55798eb12048a0.var_680df4badee6da0d = [];
    
    /#
        if ( getdvarint( @"hash_c9cc72fc1238c92c", 0 ) )
        {
            iprintlnbold( "<dev string:x24c>" + var_da55798eb12048a0.var_3cc547d7025a5c04 );
        }
    #/
    
    function_8a59e882252d14aa( attacker, bundle );
    function_8b63810f6a08c589( bundle.var_8fdaace73f216e2c );
    function_c545851705e795b1( var_da55798eb12048a0, bundle );
    thread monitor_lifetime( attacker, bundle );
    assert( !callback::exists( "<dev string:x261>", &on_killed_body_cloned, undefined, 1 ) );
    callback::add( "killed_body_cloned", &on_killed_body_cloned, { #skilldata:var_da55798eb12048a0, #attacker:attacker } );
    callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7, { #skilldata:var_da55798eb12048a0, #attacker:attacker } );
    self.var_9cf9051d40e9cd4e = 1;
}

// Namespace namespace_50771774fedd8a78
// Params 2, eflags: 0x4
// Checksum 0xb9ec2851, Offset: 0x7d2
// Size: 0x28e
function private function_c545851705e795b1( var_da55798eb12048a0, bundle )
{
    if ( !bundle.var_60e970da8e970675 )
    {
        return;
    }
    
    radius = bundle.var_691fc1ad37b9d73c;
    squaredradius = radius * radius;
    assert( radius > 0 );
    function_dc4d9239184cdebc( bundle );
    ai_array = getaiarrayinradius( self.origin, radius, "team_hundred_ninety" );
    
    /#
        if ( getdvarint( @"hash_c9cc72fc1238c92c", 0 ) )
        {
            sphere( self.origin, radius, ( 0.9, 0.7, 0.6 ), 0, int( bundle.var_2758d34d171d56a7 / level.framedurationseconds ) );
        }
    #/
    
    foreach ( agent in ai_array )
    {
        if ( agent == self || agent.unittype != "soldier" )
        {
            continue;
        }
        
        data = { #var_35d882b84c2a7f8c:agent.var_32120addd78eb2d8, #var_b52ed6aa5e11097a:agent.meleebashmaxdistsq, #var_7e893852ac5265a2:agent.meleechargedist, #var_42e977601f19b98:agent.meleechargedistvsplayer, #var_826cc5af93de225e:agent canusecover(), #var_a12148bd90cccd22:agent.meleetryhard, #var_d91cf92bafb76824:agent.dontevershoot, #var_cdb60b67a983db68:agent.meleeonly, #entity:agent };
        var_da55798eb12048a0.var_680df4badee6da0d[ var_da55798eb12048a0.var_680df4badee6da0d.size ] = data;
        agent.meleeonly = 1;
        agent.dontevershoot = 1;
        agent.meleetryhard = 1;
        agent setcanusecover( 0 );
        agent setgoalentity( self, 32 );
        agent.meleechargedistvsplayer = radius;
        agent.meleechargedist = radius;
        agent.meleebashmaxdistsq = squaredradius;
        agent.var_32120addd78eb2d8 = radius;
    }
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x3810e70b, Offset: 0xa68
// Size: 0xd2
function private function_dc4d9239184cdebc( bundle )
{
    if ( !bundle.var_39acfebef9db5a50 )
    {
        return;
    }
    
    if ( self.unittype != "soldier" )
    {
        return;
    }
    
    radius = bundle.var_691fc1ad37b9d73c;
    self setcanusecover( 0 );
    self function_fa32376aaa88a7a2( self.origin, radius );
    onlymelee = bundle.var_a18ce83713223bea;
    
    if ( onlymelee )
    {
        self.meleealwayswin = 1;
        self.meleeonly = 1;
        self.dontevershoot = 1;
        self.meleetryhard = 1;
        self.meleechargedistvsplayer = radius;
        self.meleechargedist = radius;
        self.meleebashmaxdistsq = radius * radius;
        self.var_32120addd78eb2d8 = radius;
    }
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x951eebf7, Offset: 0xb42
// Size: 0x163
function private function_dbbd5a596f1fa488( var_da55798eb12048a0 )
{
    foreach ( agent_data in var_da55798eb12048a0.var_680df4badee6da0d )
    {
        entity = agent_data.entity;
        
        if ( isalive( entity ) )
        {
            entity.meleeonly = agent_data.var_cdb60b67a983db68;
            entity.dontevershoot = agent_data.var_d91cf92bafb76824;
            entity.meleetryhard = agent_data.var_a12148bd90cccd22;
            entity.meleechargedistvsplayer = agent_data.var_42e977601f19b98;
            entity.meleechargedist = agent_data.var_7e893852ac5265a2;
            entity.meleebashmaxdistsq = agent_data.var_b52ed6aa5e11097a;
            entity.var_32120addd78eb2d8 = agent_data.var_35d882b84c2a7f8c;
            entity cleargoalentity();
            entity setcanusecover( agent_data.var_826cc5af93de225e );
        }
    }
    
    var_da55798eb12048a0.var_680df4badee6da0d = [];
}

// Namespace namespace_50771774fedd8a78
// Params 2, eflags: 0x4
// Checksum 0xb353f8ef, Offset: 0xcad
// Size: 0x9c
function private function_8a59e882252d14aa( attacker, bundle )
{
    utility::callsharedfunc( #"zombie_utils", #"turn_ai", attacker, { #state:#"brainrot_on", #part:#"brainrot" } );
    ob_stun::cancel_stun();
    self disableaimassist();
    self.var_914a5379b8e8fd3 = 1;
    self.owner = attacker;
    self.skillref = #"explosive_delivery";
    function_a3d5efc202278254( bundle );
    thread function_cb1d2ca2e9892437( bundle );
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x3994cb65, Offset: 0xd51
// Size: 0x57
function private function_8b63810f6a08c589( bias_value )
{
    if ( !bias_value )
    {
        return;
    }
    
    if ( !threatbiasgroupexists( "explosive_delivery_target" ) )
    {
        createthreatbiasgroup( "explosive_delivery_target" );
    }
    
    setthreatbias( "explosive_delivery_target", "team_two_hundred", bias_value );
    setthreatbias( "explosive_delivery_target", "team_hundred_ninety", bias_value );
    self setthreatbiasgroup( "explosive_delivery_target" );
}

// Namespace namespace_50771774fedd8a78
// Params 2, eflags: 0x4
// Checksum 0x30372282, Offset: 0xdb0
// Size: 0x3b
function private monitor_lifetime( attacker, bundle )
{
    self endon( #"death" );
    wait bundle.var_2758d34d171d56a7;
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x3882001b, Offset: 0xdf3
// Size: 0x55
function private function_a3d5efc202278254( bundle )
{
    warning_fx = level._effect[ bundle.var_4e7de67ec753e924 ];
    
    if ( warning_fx && self tagexists( #"j_spine4" ) )
    {
        playfxontag( warning_fx, self, #"j_spine4" );
    }
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x8e40ad1f, Offset: 0xe50
// Size: 0x101
function private function_cb1d2ca2e9892437( bundle )
{
    self endon( #"death" );
    
    if ( !bundle.var_29b1643e376d9072 || !bundle.var_6bac1eb1fc17f2a8 )
    {
        return;
    }
    
    var_27471c220e71eb67 = lookupsoundlength( bundle.var_6bac1eb1fc17f2a8 ) * 0.001 ?? 0;
    assert( var_27471c220e71eb67, "<dev string:x274>" );
    assert( bundle.var_cefbc6ead460f246, "<dev string:x2b5>" );
    var_dcffdb0b16558c75 = bundle.var_2758d34d171d56a7 - var_27471c220e71eb67;
    var_9ac9a56aafddcce6 = bundle.var_cefbc6ead460f246;
    elapsed = 0;
    
    while ( elapsed < var_dcffdb0b16558c75 )
    {
        playsoundatpos( self getorigin(), bundle.var_29b1643e376d9072 );
        wait var_9ac9a56aafddcce6;
        elapsed += var_9ac9a56aafddcce6;
    }
    
    playsoundatpos( self getorigin(), bundle.var_6bac1eb1fc17f2a8 );
}

// Namespace namespace_50771774fedd8a78
// Params 2, eflags: 0x4
// Checksum 0x975012c9, Offset: 0xf59
// Size: 0xda
function private on_killed_body_cloned( params, var_3c793eed5f22ab1a )
{
    var_da55798eb12048a0 = var_3c793eed5f22ab1a.skilldata;
    bundle = var_da55798eb12048a0.bundle;
    warning_fx = level._effect[ bundle.var_4e7de67ec753e924 ];
    
    if ( warning_fx && params.body && params.body tagexists( #"j_spine4" ) )
    {
        stopfxontag( warning_fx, params.body, #"j_spine4" );
        wait 0.5;
        
        if ( params.body )
        {
            stopfxontag( warning_fx, params.body, #"j_spine4" );
        }
    }
}

// Namespace namespace_50771774fedd8a78
// Params 2, eflags: 0x4
// Checksum 0xee14cc2, Offset: 0x103b
// Size: 0xd0
function private function_8c5e06ee1e60aeb7( params, var_3c793eed5f22ab1a )
{
    attacker = var_3c793eed5f22ab1a.attacker;
    var_da55798eb12048a0 = var_3c793eed5f22ab1a.skilldata;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( attacker && var_da55798eb12048a0 && var_da55798eb12048a0.var_3cc547d7025a5c04 )
    {
        var_da55798eb12048a0.var_3cc547d7025a5c04--;
        
        /#
            if ( getdvarint( @"hash_c9cc72fc1238c92c", 0 ) )
            {
                iprintlnbold( "<dev string:x24c>" + var_da55798eb12048a0.var_3cc547d7025a5c04 );
            }
        #/
    }
    
    var_d0a9d177707a4448 = self getcentroid();
    function_8ad36b9f50d770db( var_d0a9d177707a4448, attacker, bundle );
    function_dbbd5a596f1fa488( var_da55798eb12048a0 );
}

// Namespace namespace_50771774fedd8a78
// Params 1, eflags: 0x4
// Checksum 0x55c60fc8, Offset: 0x1113
// Size: 0x71
function private function_e4d0bda8f3513039( bundle )
{
    return { #weapon:bundle.var_d6003b873584d698, #damage:bundle.var_55566c226e6d7085, #radius:bundle.var_e07894aa927a454a, #sfx:bundle.var_4c7ee59c503b9f93, #vfxid:bundle.var_b56613742aa6e595 };
}

// Namespace namespace_50771774fedd8a78
// Params 3, eflags: 0x4
// Checksum 0xf98d3ce9, Offset: 0x118d
// Size: 0x60
function private function_8ad36b9f50d770db( var_d0a9d177707a4448, attacker, bundle )
{
    explosion_params = function_e4d0bda8f3513039( bundle );
    function_eac7c88125ad5525( var_d0a9d177707a4448, explosion_params );
    apply_explosion_damage( var_d0a9d177707a4448, attacker, explosion_params );
    
    if ( bundle.var_be7ca49acafe51c0 )
    {
        namespace_7bfb7f22014f83ed::function_40826e063563a661( var_d0a9d177707a4448, attacker, bundle );
    }
}

// Namespace namespace_50771774fedd8a78
// Params 2, eflags: 0x4
// Checksum 0xd398f373, Offset: 0x11f5
// Size: 0x63
function private function_eac7c88125ad5525( var_d0a9d177707a4448, explosion_params )
{
    effect_id = level._effect[ explosion_params.vfxid ];
    
    if ( effect_id )
    {
        playfx( effect_id, var_d0a9d177707a4448 );
    }
    
    if ( explosion_params.sfx )
    {
        playsoundatpos( var_d0a9d177707a4448, explosion_params.sfx );
    }
}

// Namespace namespace_50771774fedd8a78
// Params 3, eflags: 0x4
// Checksum 0x1283567d, Offset: 0x1260
// Size: 0x139
function private apply_explosion_damage( var_d0a9d177707a4448, attacker, explosion_params )
{
    /#
        if ( getdvarint( @"hash_c9cc72fc1238c92c", 0 ) )
        {
            sphere( var_d0a9d177707a4448, explosion_params.radius, ( 1, 0, 0 ), 1, 30 );
        }
    #/
    
    nearby_ai = getaiarrayinradius( var_d0a9d177707a4448, explosion_params.radius );
    
    foreach ( enemy in nearby_ai )
    {
        if ( !isalive( enemy ) )
        {
            continue;
        }
        
        if ( enemy.team == attacker.team )
        {
            continue;
        }
        
        enemy dodamage( explosion_params.damage, var_d0a9d177707a4448, attacker, undefined, "MOD_EXPLOSIVE", explosion_params.weapon, "torso_upper" );
    }
    
    function_37370dc18e5c579b( var_d0a9d177707a4448, attacker, explosion_params );
}

// Namespace namespace_50771774fedd8a78
// Params 3, eflags: 0x4
// Checksum 0xe5d92893, Offset: 0x13a1
// Size: 0x4c
function private function_37370dc18e5c579b( var_d0a9d177707a4448, attacker, explosion_params )
{
    self radiusdamage( var_d0a9d177707a4448, explosion_params.radius, explosion_params.damage, 1, attacker, "MOD_EXPLOSIVE", "<explicitweaponnone>", 1 );
}

