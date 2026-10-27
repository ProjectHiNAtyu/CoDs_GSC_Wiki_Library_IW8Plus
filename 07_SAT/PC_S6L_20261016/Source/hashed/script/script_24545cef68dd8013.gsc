// script_24545cef68dd8013  (hash_24545cef68dd8013.gscc) (size: 5958 Bytes / 0x1746 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6493e0db (1687412955)
// size ...... 5958 (0x1746)
// includes .. 6   (offset: 0x1616)
// strings ... 11  (offset: 0x1646)
// dev strs .. 10  (offset: 0x16ce)
// exports ... 19  (offset: 0xc96)
// cseg ...... 0xef + 0xba7 (0xc96)
// imports ... 57  (offset: 0xf8e)
// animtree1 . 0   (offset: 0x1746)
// animtree2 . 0   (offset: 0x1746)
#using script_2fe74ee229c972c3;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\ent_manager;
#using scripts\mp\weapons;

#namespace skill_war_machine_upgrade;

// Namespace skill_war_machine_upgrade
// Params 0, eflags: 0x1
// Checksum 0xd17f7ea3, Offset: 0x10d
// Size: 0x28
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"war_machine_upgrade", &init );
    weapons::registerusedcallback( "sat_ks_warmachine", &war_machine_used );
}

// Namespace skill_war_machine_upgrade
// Params 0
// Checksum 0x3ab886, Offset: 0x13d
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"war_machine_upgrade", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"war_machine_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"war_machine_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0x2813a6ab, Offset: 0x1a1
// Size: 0x95
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_4c7b931e26f4ec76 )
    {
        skill_bundle.var_1fbcd338ab03b496 = skill_bundle.var_4c7b931e26f4ec76 * 1000;
    }
    
    if ( skill_bundle.var_47a752ac7203a359 )
    {
        fx_asset = loadfxasset( skill_bundle.var_47a752ac7203a359 );
        fx_id = "war_machine_upgrade_fx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_a35fb0fbd9c01e9c = fx_id;
    }
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc53727ec, Offset: 0x23e
// Size: 0x12e, Type: bool
function private on_give_skill( skill_bundle )
{
    /#
        if ( skill_bundle.var_c342b52b1536500e )
        {
            assert( skill_bundle.var_33e407df3c09439b, "<dev string:x24>" );
            assert( skill_bundle.var_4bea8eeab1dabe55, "<dev string:x6e>" );
            assert( skill_bundle.var_f5e6c1afe75922a, "<dev string:xba>" );
            assert( skill_bundle.var_1fbcd338ab03b496, "<dev string:x104>" );
            assert( skill_bundle.var_7314d1d2dd9e05cc, "<dev string:x14d>" );
            assert( skill_bundle.var_594a09df674dec2, "<dev string:x196>" );
            assert( skill_bundle.var_d1e919b8d20a3f63, "<dev string:x1e0>" );
            assert( skill_bundle.var_ee46d65b7c807b67, "<dev string:x222>" );
            assert( skill_bundle.var_7de39c3ab96bf09, "<dev string:x26d>" );
            assert( skill_bundle.var_490232d242b636f1, "<dev string:x2b8>" );
        }
    #/
    
    self.var_d5c5b2a36bc0a41b = { #activetriggers:undefined, #bundle:skill_bundle };
    return true;
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xa87810cb, Offset: 0x375
// Size: 0xa5
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"war_machine_upgrade_end" );
    
    foreach ( trigger in self.var_d5c5b2a36bc0a41b.activetriggers )
    {
        function_e3e0d4008446f25( trigger );
    }
    
    self.var_d5c5b2a36bc0a41b = undefined;
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xcf0ebbca, Offset: 0x422
// Size: 0x112
function private war_machine_used( grenade )
{
    self endon( #"death_or_disconnect" );
    self endon( #"war_machine_upgrade_end" );
    var_da55798eb12048a0 = self.var_d5c5b2a36bc0a41b;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !bundle.var_c342b52b1536500e )
    {
        return;
    }
    
    grenade waittill( #"explode", impact_position, normal );
    trigger = function_9748b471e20e14d0( impact_position, normal, bundle );
    
    if ( !isdefined( var_da55798eb12048a0.activetriggers ) )
    {
        var_da55798eb12048a0.activetriggers = [];
    }
    
    var_da55798eb12048a0.activetriggers[ var_da55798eb12048a0.activetriggers.size ] = trigger;
    childthread function_17b073bd4a0fd1f2( trigger, bundle );
    duration = bundle.var_4bea8eeab1dabe55;
    wait duration;
    var_da55798eb12048a0.activetriggers = arrayremove( var_da55798eb12048a0.activetriggers, trigger );
    function_e3e0d4008446f25( trigger );
}

// Namespace skill_war_machine_upgrade
// Params 3, eflags: 0x4
// Checksum 0xebc3296f, Offset: 0x53c
// Size: 0x121
function private function_9748b471e20e14d0( impact_position, normal, bundle )
{
    if ( !impact_position )
    {
        return;
    }
    
    origin = function_b0c4bc1f31d2e63a( impact_position );
    radius = bundle.var_33e407df3c09439b;
    height = bundle.var_f5e6c1afe75922a;
    trigger = spawn( "trigger_radius", origin, 0, radius, height );
    trigger ent_manager::registerspawn( 1, &function_e3e0d4008446f25 );
    trigger.owner = self;
    trigger.impact_position = impact_position;
    trigger.enemies_in_trigger = getaiarrayinradius( origin, radius );
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        utility::callsharedfunc( #"game", #"makeenterexittrigger", trigger, &watch_trigger_enter, &watch_trigger_exit );
    }
    
    function_ac804fb5b6e7f79( trigger, normal, bundle );
    
    /#
        function_23c99d2927e47aae( trigger, bundle.var_4bea8eeab1dabe55, radius, height );
    #/
    
    return trigger;
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xdff4ef26, Offset: 0x666
// Size: 0x2e
function private function_e3e0d4008446f25( trigger )
{
    trigger.enemies_in_trigger = [];
    function_a1dfaa1519a73293( trigger );
    
    if ( trigger )
    {
        trigger delete();
    }
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0x1172614e, Offset: 0x69c
// Size: 0x49
function private function_b0c4bc1f31d2e63a( impact_position )
{
    trigger_origin = utility::drop_to_ground( impact_position );
    
    if ( utility::ispointinwater( trigger_origin ) )
    {
        water_height = getwaterheightatlocation( trigger_origin );
        trigger_origin = ( trigger_origin[ 0 ], trigger_origin[ 1 ], water_height );
    }
    
    return trigger_origin;
}

// Namespace skill_war_machine_upgrade
// Params 2, eflags: 0x4
// Checksum 0xeb340825, Offset: 0x6ee
// Size: 0x45
function private watch_trigger_enter( enemy, trigger )
{
    if ( !arraycontains( trigger.enemies_in_trigger, enemy ) )
    {
        trigger.enemies_in_trigger[ trigger.enemies_in_trigger.size ] = enemy;
    }
}

// Namespace skill_war_machine_upgrade
// Params 2, eflags: 0x4
// Checksum 0x74456afe, Offset: 0x73b
// Size: 0x46
function private watch_trigger_exit( enemy, trigger )
{
    if ( arraycontains( trigger.enemies_in_trigger, enemy ) )
    {
        trigger.enemies_in_trigger = arrayremove( trigger.enemies_in_trigger, enemy );
    }
}

// Namespace skill_war_machine_upgrade
// Params 3, eflags: 0x4
// Checksum 0x196d38bb, Offset: 0x789
// Size: 0x125
function private function_ac804fb5b6e7f79( trigger, normal, bundle )
{
    trigger.fx_tag_origin = utility::spawn_tag_origin( trigger.impact_position );
    trigger.effect_id = utility::getfx( bundle.var_a35fb0fbd9c01e9c );
    trigger.fx_tag_origin show();
    playfxontag( trigger.effect_id, trigger.fx_tag_origin, "tag_origin" );
    up = normal;
    forward = vectornormalize( vectorcross( up, anglestoright( self getgunangles() ) ) );
    right = vectorcross( forward, up );
    angles = axistoangles( forward, right, up );
    trigger.scriptable = spawnscriptable( bundle.var_ee46d65b7c807b67, trigger.impact_position, angles );
    trigger.scriptable setscriptablepartstate( bundle.var_7de39c3ab96bf09, bundle.var_490232d242b636f1, 0 );
}

// Namespace skill_war_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xb29921f3, Offset: 0x8b6
// Size: 0x89
function private function_a1dfaa1519a73293( trigger )
{
    if ( trigger.fx_tag_origin )
    {
        killfxontag( trigger.effect_id, trigger.fx_tag_origin, "tag_origin" );
        trigger.fx_tag_origin delete();
        trigger.fx_tag_origin = undefined;
        trigger.effect_id = undefined;
    }
    
    if ( trigger.scriptable )
    {
        trigger.scriptable freescriptable();
        trigger.scriptable = undefined;
    }
}

// Namespace skill_war_machine_upgrade
// Params 2, eflags: 0x4
// Checksum 0x9f4e0f14, Offset: 0x947
// Size: 0xab
function private function_17b073bd4a0fd1f2( trigger, bundle )
{
    while ( trigger )
    {
        waitframe();
        
        foreach ( enemy in trigger.enemies_in_trigger )
        {
            if ( !function_4e5e4ad857cce86f( enemy, bundle ) )
            {
                continue;
            }
            
            function_6d275d5c576d3cec( enemy, trigger, bundle );
        }
    }
}

// Namespace skill_war_machine_upgrade
// Params 2, eflags: 0x4
// Checksum 0xde10fca1, Offset: 0x9fa
// Size: 0x93, Type: bool
function private function_4e5e4ad857cce86f( enemy, bundle )
{
    if ( !isalive( enemy ) || player_utility::isfriendly( enemy.team ?? enemy.agentteam, self ) )
    {
        return false;
    }
    
    current_time = gettime();
    
    if ( enemy.var_553ae45c1a5786fb && current_time - enemy.var_553ae45c1a5786fb < bundle.var_1fbcd338ab03b496 )
    {
        return false;
    }
    
    enemy.var_553ae45c1a5786fb = current_time;
    return true;
}

// Namespace skill_war_machine_upgrade
// Params 3, eflags: 0x4
// Checksum 0x70d0070d, Offset: 0xa96
// Size: 0x88
function private function_6d275d5c576d3cec( enemy, trigger, bundle )
{
    if ( enemy.type == "zombie" )
    {
        enemy dodamage( bundle.var_7314d1d2dd9e05cc, enemy.origin, self, self, "MOD_FIRE", bundle.var_d1e919b8d20a3f63, "torso_upper" );
        return;
    }
    
    if ( enemy.type == "human" )
    {
        function_615b80e36345a810( enemy, trigger, bundle );
    }
}

// Namespace skill_war_machine_upgrade
// Params 3, eflags: 0x4
// Checksum 0xaa40d59b, Offset: 0xb26
// Size: 0xde
function private function_615b80e36345a810( enemy, trigger, bundle )
{
    enemy.burningdirection = undefined;
    right = anglestoright( enemy.angles );
    tofire = vectornormalize( trigger.origin - enemy.origin );
    
    if ( vectordot( right, tofire ) > 0 )
    {
        enemy.burningdirection = "right";
    }
    else
    {
        enemy.burningdirection = "left";
    }
    
    duration = bundle.var_4c7b931e26f4ec76;
    damage = bundle.var_594a09df674dec2;
    enemy effect_burn::burn( duration, damage, duration, self, undefined, undefined, self, "fire", undefined, undefined, undefined, 0 );
}

/#

    // Namespace skill_war_machine_upgrade
    // Params 4, eflags: 0x4
    // Checksum 0xc604dd00, Offset: 0xc0c
    // Size: 0x8a, Type: dev
    function private function_23c99d2927e47aae( trigger, duration, radius, height )
    {
        draw_version = getdvarint( @"hash_c9bcce956aee39ee", 0 );
        
        if ( draw_version )
        {
            cylinder( trigger.origin, trigger.origin + ( 0, 0, height ), radius, ( 1, 0, 0 ), 0, int( duration / level.framedurationseconds ) );
        }
    }

#/
