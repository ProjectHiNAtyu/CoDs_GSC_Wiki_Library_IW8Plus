// scripts\mp\common\weapons\weap_scarabww.gsc  (hash_654bc92fd279c444.gscc) (size: 32738 Bytes / 0x7fe2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6613c698 (1712572056)
// size ...... 32738 (0x7fe2)
// includes .. 17  (offset: 0x7a8a)
// strings ... 72  (offset: 0x7b12)
// dev strs .. 6   (offset: 0x7f92)
// exports ... 87  (offset: 0x4f4a)
// cseg ...... 0x507 + 0x4a43 (0x4f4a)
// imports ... 236 (offset: 0x5ce2)
// animtree1 . 0   (offset: 0x7fe2)
// animtree2 . 0   (offset: 0x7fe2)
#using script_16ea1b94f0f381b3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vortex;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\weapons\ww_shared;

#namespace weap_scarabww;

// Namespace weap_scarabww
// Params 0, eflags: 0x5
// Checksum 0xf72ec2b8, Offset: 0x525
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"weap_scarabww", undefined, undefined, &post_main );
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xa8e25ac4, Offset: 0x546
// Size: 0xfd
function private post_main()
{
    level.scarabww_basename = "sat_ww_scarab_zm";
    level.scarabww_cyclone_damage_throttle = throttle::throttle_initialize_gate( "scarabww_cyclone_damage", 4, level.framedurationseconds );
    utility::registersharedfunc( #"weap_scarabww", #"hash_6630991317bcc3af", &function_3a1514a781375202 );
    level callback::add( #"player_weapon_change", &on_player_weapon_change );
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( "on_add_pap_attachments", &on_add_pap_attachments );
    level zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    level.var_f7d8c385fccc43b4[ level.scarabww_basename ] = &function_2b25fa189903b103;
    
    if ( !isdefined( level.var_86f911ce75014794 ) )
    {
        level.var_86f911ce75014794 = [];
    }
    
    level.var_86f911ce75014794[ level.scarabww_basename ] = 1;
    
    /#
        init_scarabww_devgui();
    #/
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x7c07c7fb, Offset: 0x64b
// Size: 0x168
function private on_player_weapon_change( params )
{
    data = get_scarabww_player_data();
    
    if ( params.weapon.basename == level.scarabww_basename )
    {
        if ( !isdefined( level.scarabww_settings ) )
        {
            level.scarabww_settings = params.weapon.weaponcustomsettings;
        }
        
        data.is_akimbo = weapon::isakimbo( params.weapon );
        data.is_pap = utility::callsharedfunc( #"zombie", #"get_pap_level", params.weapon ) > 0;
        thread ww_shared::function_3472b693f638483a( level.scarabww_basename, "scarabww_ambient", function_b6759d5040e13258( "on" ), "off" );
        self notify( "stop_monitor_" + level.scarabww_basename + "_state" );
        thread function_4045b358af908c75( params );
        return;
    }
    
    self notify( "stop_monitor_" + level.scarabww_basename + "_state" );
    thread ww_shared::function_50a43e11790d1a15( level.scarabww_basename, "scarabww_ambient", "off" );
    function_bee9462110cdda2b( data );
    data.var_90c60637afa7a0fc = undefined;
    data.var_c703adc98942f6a = undefined;
    data.var_cead3fa3a6f574c = undefined;
    data.var_dfa7a53acb72d9a = undefined;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x86f9d6d3, Offset: 0x7bb
// Size: 0x58
function private function_4045b358af908c75( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "stop_monitor_" + level.scarabww_basename + "_state" );
    childthread function_d4ba237422e15ba4();
    childthread function_b711d8e6dc0f228c();
    childthread function_981bbd22dba7bd3c();
    childthread monitor_ww_melee();
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x4663b9d8, Offset: 0x81b
// Size: 0x88
function private monitor_ww_melee()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "stop_monitor_" + level.scarabww_basename + "_state" );
    
    while ( true )
    {
        self waittill( #"melee_fired", weapon );
        
        if ( !self || !isweapon( weapon ) || weapon.basename != level.scarabww_basename )
        {
            continue;
        }
        
        thread function_7df699544369a338( weapon );
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x5f67340a, Offset: 0x8ab
// Size: 0x1df
function private function_7df699544369a338( weapon )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.12;
    
    if ( !self )
    {
        return;
    }
    
    playerforward = anglestoforward( self getplayerangles() );
    eye_pos = self geteye();
    trace_start = eye_pos + playerforward * 0;
    trace_end = eye_pos + playerforward * 50;
    trace = trace::sphere_trace_get_all_results( trace_start, trace_end, 15, self, undefined, undefined, 0 );
    zombies = [];
    
    foreach ( trace_result in trace )
    {
        target = trace_result[ "entity" ];
        
        if ( isai( target ) && isalive( target ) && target.team != self.team && !target zombie_utils::function_bf1464d09f4e4b40() )
        {
            target.var_c6000e806abe67cf = trace_result[ "position" ];
            zombies[ zombies.size ] = target;
        }
    }
    
    if ( zombies.size <= 0 )
    {
        return;
    }
    
    zombies = utility::get_array_of_closest( self.origin, zombies );
    var_f792509d72a84f58 = function_f6df392ced26d8e3( zombies );
    
    if ( !isai( var_f792509d72a84f58 ) || !isalive( var_f792509d72a84f58 ) )
    {
        return;
    }
    
    hit_position = var_f792509d72a84f58.var_c6000e806abe67cf;
    var_6c41e8e873b7594e = weapon function_a7bd968152df51af();
    var_f792509d72a84f58 dodamage( var_6c41e8e873b7594e, hit_position, self, self, "MOD_MELEE", weapon );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xab4e958e, Offset: 0xa92
// Size: 0xfc
function private function_f6df392ced26d8e3( array )
{
    closest_dot = -1;
    closest_object = undefined;
    forward = anglestoforward( self getplayerangles() );
    eye_pos = self geteye();
    
    foreach ( object in array )
    {
        dir = vectornormalize( ( object gettagorigin( "j_spine4", 1 ) ?? object.origin ) - eye_pos );
        dot = vectordot( forward, dir );
        
        if ( dot >= closest_dot )
        {
            closest_dot = dot;
            closest_object = object;
        }
    }
    
    return closest_object;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x13717bf7, Offset: 0xb97
// Size: 0xa1
function private function_2b25fa189903b103( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( isplayer( dmg_struct.eattacker ) && dmg_struct.smeansofdeath == "MOD_MELEE" )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
        
        if ( var_951c89546ec50477 )
        {
            idamage *= zombie_damage::function_dcee44724d9edddd( dmg_struct.objweapon, var_951c89546ec50477 );
        }
    }
    
    return idamage;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x425f5d05, Offset: 0xc41
// Size: 0xdf
function private function_d4ba237422e15ba4()
{
    while ( true )
    {
        self waittill( #"missile_fire", projectile, weapon, hand );
        
        if ( !( isdefined( projectile ) && isdefined( weapon ) ) || weapon.basename != level.scarabww_basename )
        {
            continue;
        }
        
        function_532cd9c2e3aa4787( projectile, hand );
        
        if ( projectile.var_d8a553fa3d6d8003 )
        {
            continue;
        }
        
        projectile.var_d8a553fa3d6d8003 = 1;
        projectile.var_e936ea68537e7723 = function_75a813c26ede499d( projectile, projectile.birthtime );
        projectile thread function_b56b9dc4beab6efc( self, projectile.birthtime );
        projectile thread function_ed94b371ea03ceff( self );
        projectile thread function_60a61bf3fa6336fb( self, weapon );
        projectile thread function_10700076c9984d5a( self, weapon );
    }
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x56b8d4b5, Offset: 0xd28
// Size: 0x93
function private function_532cd9c2e3aa4787( projectile, hand )
{
    if ( !projectile )
    {
        return;
    }
    
    if ( hand != "left" && hand != "right" )
    {
        return;
    }
    
    if ( !isdefined( projectile.var_3ab61d710d58e276 ) )
    {
        projectile.var_3ab61d710d58e276 = [];
    }
    
    if ( isdefined( function_f02c63b99c9614c9( projectile.var_3ab61d710d58e276, hand ) ) )
    {
        return;
    }
    
    if ( projectile.var_3ab61d710d58e276.size >= 2 )
    {
        return;
    }
    
    projectile.var_3ab61d710d58e276[ projectile.var_3ab61d710d58e276.size ] = hand;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x201ad74, Offset: 0xdc3
// Size: 0x3c
function private function_e5336f1e98c75fbb( projectile )
{
    if ( !projectile.var_3ab61d710d58e276 )
    {
        return;
    }
    
    if ( projectile.var_3ab61d710d58e276.size != 1 )
    {
        return;
    }
    
    return projectile.var_3ab61d710d58e276[ 0 ];
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x627822cd, Offset: 0xe08
// Size: 0x21
function private on_player_connect( _ )
{
    callback::add( #"player_used_item", &function_176013519395df42 );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x45113da6, Offset: 0xe31
// Size: 0x13
function private on_player_disconnect( _ )
{
    function_cc1109ea94e5bf00();
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xffc48bfb, Offset: 0xe4c
// Size: 0x8b
function private function_176013519395df42( params )
{
    key = "scarabww_tutorial_message_has_displayed";
    
    if ( isweapon( params.item.weaponobj ) && params.item.weaponobj.basename == level.scarabww_basename )
    {
        if ( !utility::ent_flag( key ) )
        {
            utility::ent_flag_set( key );
            thread ww_shared::show_hud_tutorial_message( &"hash_4ae7822e132cfae2" );
        }
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x7738630a, Offset: 0xedf
// Size: 0x13b
function private on_add_pap_attachments( params )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != level.scarabww_basename )
    {
        return;
    }
    
    if ( params.weapon canuseattachment( "sat_rec_ww_scarab_pap" ) )
    {
        index = function_f02c63b99c9614c9( params.attachments, "sat_rec_ww_scarab" );
        
        if ( isdefined( index ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_rec_ww_scarab" ];
            params.attachments[ index ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_rec_ww_scarab_pap";
            params.var_f1614eef81f0bdd2[ "sat_rec_ww_scarab_pap" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_rec_ww_scarab" ] = undefined;
        }
    }
    
    key = "scarabww_pap_tutorial_message_has_displayed";
    
    if ( !utility::ent_flag( key ) )
    {
        utility::ent_flag_set( key );
        thread ww_shared::show_hud_tutorial_message( &"hash_2ff538a33b629bd2" );
    }
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xbcd19daf, Offset: 0x1022
// Size: 0xfa
function private function_b56b9dc4beab6efc( attacker, birth_time )
{
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    consume_key = function_75a813c26ede499d( self, birth_time );
    self waittill( #"death" );
    data = attacker get_scarabww_player_data();
    
    if ( !function_b390af29ffb94c8b( data, consume_key ) && ( data.cyclone_allowance ?? 0 ) > 0 )
    {
        function_8ddbe3bdebda3d2( data, self );
        function_b77c7c5e365524ca( data );
    }
    
    if ( isarray( data.pin_infos ) && isdefined( data.pin_infos[ birth_time ] ) )
    {
        data.pin_infos[ birth_time ].var_66151cc039d2151 = undefined;
        data.pin_infos[ birth_time ].var_546b525470d474ab = undefined;
        data.pin_infos[ birth_time ] = undefined;
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xb2ca8c9f, Offset: 0x1124
// Size: 0x17f
function private function_ed94b371ea03ceff( attacker )
{
    self endon( #"death" );
    var_96044cf289b656b5 = 0.5;
    best_target = attacker function_76d5cf445049f2d8( level.scarabww_settings.targetingcone.var_3640250d967365f5 ?? 128, level.scarabww_settings.targetingcone.var_358e2569cd831daf ?? 45, level.scarabww_settings.targetingcone.var_ebf360a417d19929 ?? 20 );
    
    if ( !isdefined( best_target ) )
    {
        best_target = attacker function_76d5cf445049f2d8( level.scarabww_settings.targetingcone.var_ba298ddb11650ccc ?? 1500, level.scarabww_settings.targetingcone.var_b150c4e2e3a3b3b6 ?? 15, level.scarabww_settings.targetingcone.var_822305aaa3d71a8 ?? 8 );
    }
    
    if ( best_target && isalive( best_target ) )
    {
        target_aim_pos = function_35cc058e686cc5a8( best_target );
        var_96044cf289b656b5 = distance( self.origin, target_aim_pos ) / 1600;
        childthread function_5470cd11c6d76819( best_target );
    }
    
    utility::waittill_any_timeout( var_96044cf289b656b5, "missile_stuck", "missile_impact" );
    self notify( #"hash_6fe15783776fceed" );
    
    if ( self )
    {
        self missile_cleartarget();
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x2fa16d84, Offset: 0x12ab
// Size: 0x52
function private function_35cc058e686cc5a8( target )
{
    target_aim_pos = target get_scarabww_target_pos();
    target_aim_offset = rotatevectorinverted( target_aim_pos - target.origin, target.angles );
    self missile_settargetent( target, target_aim_offset );
    return target_aim_pos;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xbb9c1f85, Offset: 0x1306
// Size: 0x36
function private function_5470cd11c6d76819( target )
{
    self endon( #"hash_6fe15783776fceed" );
    
    while ( true )
    {
        waitframe();
        waitframe();
        
        if ( !isalive( target ) )
        {
            return;
        }
        
        function_35cc058e686cc5a8( target );
    }
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0x83dc35e8, Offset: 0x1344
// Size: 0x249
function private function_76d5cf445049f2d8( radius, h_fov, v_fov )
{
    h_fov = min( h_fov, 89 );
    v_fov = min( v_fov, 89 );
    var_f86585b177386a52 = self getvieworigin();
    var_9f3b32e1a46f3c50 = self getgunangles();
    aim_forward = anglestoforward( var_9f3b32e1a46f3c50 );
    var_c27a732dc4eaccd2 = anglestoright( var_9f3b32e1a46f3c50 );
    var_79e093e60ab7659d = anglestoup( var_9f3b32e1a46f3c50 );
    ai_in_radius = getaiarrayinradius( self.origin, radius );
    var_e298aaf449401ece = tan( h_fov );
    var_59064e16b3482850 = tan( v_fov );
    best_target = undefined;
    var_56f8085dbc86ff85 = -1;
    best_distance_squared = 999999999;
    
    foreach ( ai in ai_in_radius )
    {
        if ( !ai getcandamage() || ai.invulnerable )
        {
            continue;
        }
        
        end_origin = ai get_scarabww_target_pos();
        dir_to_ai = vectornormalize( end_origin - var_f86585b177386a52 );
        forward_score = vectordot( aim_forward, dir_to_ai );
        
        if ( !function_83fb186191acc35a( dir_to_ai, forward_score, var_c27a732dc4eaccd2, var_79e093e60ab7659d, var_e298aaf449401ece, var_59064e16b3482850 ) )
        {
            continue;
        }
        
        if ( !utility::can_trace_to_ai( var_f86585b177386a52, ai ) )
        {
            continue;
        }
        
        angle_score = forward_score;
        
        if ( angle_score > var_56f8085dbc86ff85 + 0.0001 )
        {
            var_56f8085dbc86ff85 = angle_score;
            best_distance_squared = distancesquared( self.origin, ai.origin );
            best_target = ai;
            continue;
        }
        
        if ( abs( angle_score - var_56f8085dbc86ff85 ) <= 0.0001 )
        {
            dist_squared = distancesquared( self.origin, ai.origin );
            
            if ( dist_squared >= best_distance_squared )
            {
                continue;
            }
            
            best_distance_squared = dist_squared;
            best_target = ai;
        }
    }
    
    return best_target;
}

// Namespace weap_scarabww
// Params 6, eflags: 0x4
// Checksum 0xdf777c4c, Offset: 0x1596
// Size: 0x88, Type: bool
function private function_83fb186191acc35a( dir_to_ai, var_c5bd4c08173f1057, var_c27a732dc4eaccd2, var_79e093e60ab7659d, var_e298aaf449401ece, var_59064e16b3482850 )
{
    if ( var_c5bd4c08173f1057 <= 0 )
    {
        return false;
    }
    
    var_460a5d54505d1630 = vectordot( dir_to_ai, var_c27a732dc4eaccd2 );
    up_dot = vectordot( dir_to_ai, var_79e093e60ab7659d );
    
    if ( abs( var_460a5d54505d1630 ) > var_c5bd4c08173f1057 * var_e298aaf449401ece )
    {
        return false;
    }
    
    if ( abs( up_dot ) > var_c5bd4c08173f1057 * var_59064e16b3482850 )
    {
        return false;
    }
    
    return true;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xd07e5d61, Offset: 0x1627
// Size: 0x20f
function private function_17fdfda41f9aa95a( dmg_struct )
{
    if ( dmg_struct.sweapon.basename == level.scarabww_basename )
    {
        if ( self.cyclone_kill )
        {
            dmg_struct.var_d20799805edf0194 = 1;
        }
        
        if ( isnumber( dmg_struct.einflictor.birthtime ) && isplayer( dmg_struct.eattacker ) )
        {
            attacker = dmg_struct.eattacker;
            data = attacker get_scarabww_player_data();
            function_8998cfa9b1d75620( dmg_struct );
            
            if ( ( data.cyclone_allowance ?? 0 ) > 0 && gettime() - ( data.var_d7cc26528a76e456 ?? 0 ) > 1000 )
            {
                function_bee9462110cdda2b( data );
            }
            
            if ( ( data.cyclone_allowance ?? 0 ) > 0 && !is_projectile_consumed( data, dmg_struct.einflictor ) )
            {
                spawn_pos = utility::drop_to_ground( dmg_struct.einflictor.origin, 0 );
                attacker function_f002904d7078410f( data, dmg_struct.sweapon, dmg_struct.einflictor, spawn_pos );
            }
            
            info = { #victim:self, #vdir:dmg_struct.vdir, #partname:dmg_struct.partname, #shitloc:dmg_struct.shitloc };
            pin_info = attacker function_df01e237496f3e04( dmg_struct.einflictor.birthtime );
            
            if ( !isdefined( pin_info.var_66151cc039d2151 ) )
            {
                pin_info.var_66151cc039d2151 = [];
            }
            
            pin_info.var_66151cc039d2151[ pin_info.var_66151cc039d2151.size ] = info;
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x1426c525, Offset: 0x183f
// Size: 0x1fa
function private function_60a61bf3fa6336fb( attacker, weapon )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    attacker endon( #"death_or_disconnect" );
    
    if ( !isdefined( attacker.team ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"projectile_impact_ai", ai );
        
        if ( ai.team == attacker.team )
        {
            continue;
        }
        
        self.penetration_count = ( self.penetration_count ?? 0 ) + 1;
        is_final_penetration = self.penetration_count >= 5;
        pin_info = attacker function_df01e237496f3e04( self.birthtime );
        
        if ( pin_info.var_546b525470d474ab && !pin_info.var_546b525470d474ab.var_9093d7db187499fc )
        {
            function_464b42b4655b29ad( pin_info );
        }
        
        if ( !isalive( ai ) )
        {
            var_474320c0f46048f0 = undefined;
            
            foreach ( info in pin_info.var_66151cc039d2151 )
            {
                if ( ai == info.victim )
                {
                    var_474320c0f46048f0 = info;
                    break;
                }
            }
            
            if ( !var_474320c0f46048f0 )
            {
                if ( is_final_penetration )
                {
                    thread destroy_projectile();
                    return;
                }
                
                continue;
            }
            
            if ( !is_final_penetration && function_bb679325bcb070fc( ai.subclass ) && function_3a0144540bf0f272( ai, var_474320c0f46048f0, attacker ) )
            {
                continue;
            }
            
            thread function_9291f5d4eff972b8( ai, var_474320c0f46048f0 );
        }
        
        if ( is_final_penetration )
        {
            thread destroy_projectile();
            return;
        }
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xa6f29930, Offset: 0x1a41
// Size: 0x137
function private function_8998cfa9b1d75620( dmg_struct )
{
    if ( dmg_struct.idamage > 0 && dmg_struct.smeansofdeath == "MOD_RIFLE_BULLET" )
    {
        if ( isvector( dmg_struct.vpoint ) && isvector( dmg_struct.vdir ) && dmg_struct.eattacker )
        {
            impact_fx = spawnscriptable( "scriptable_ww_scarab_impact", dmg_struct.vpoint, vectortoangles( dmg_struct.vdir * -1 ) );
            impact_fx utility::function_7c10ea82c1e305b8( "impact", dmg_struct.eattacker function_b6759d5040e13258( "on" ) );
            impact_fx utility::delaycall( 3, &freescriptable );
            return;
        }
        
        if ( self tagexists( "j_spine4" ) && dmg_struct.eattacker )
        {
            impact_fx = spawnscriptable( "scriptable_ww_scarab_impact", self gettagorigin( "j_spine4" ), self gettagangles( "j_spine4" ) );
            impact_fx utility::function_7c10ea82c1e305b8( "impact", dmg_struct.eattacker function_b6759d5040e13258( "on" ) );
            impact_fx utility::delaycall( 3, &freescriptable );
        }
    }
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0x97349d01, Offset: 0x1b80
// Size: 0x273, Type: bool
function private function_3a0144540bf0f272( ai, var_474320c0f46048f0, attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    attacker endon( #"death_or_disconnect" );
    pin_info = attacker function_df01e237496f3e04( self.birthtime );
    corpse = ai getcorpseentity();
    
    if ( !corpse || ai.noragdoll || corpse.noragdoll )
    {
        return false;
    }
    
    hitloc = get_projectile_impact_location( var_474320c0f46048f0 );
    bone = var_474320c0f46048f0.partname;
    
    if ( !var_474320c0f46048f0.partname || !corpse tagexists( var_474320c0f46048f0.partname ) )
    {
        if ( corpse tagexists( "j_spineupper" ) )
        {
            bone = "j_spineupper";
        }
        else
        {
            return false;
        }
    }
    
    target_wall_info = find_target_wall_info( ai, attacker );
    
    if ( !target_wall_info || !is_wall_surface( target_wall_info[ "normal" ] ) )
    {
        return false;
    }
    
    corpse endon( #"death" );
    corpse function_dd258a3da9a2b4a1( 86400 );
    corpse startragdoll();
    waittillframeend();
    
    if ( !corpse )
    {
        return false;
    }
    
    mover = utility::spawn_tag_origin( corpse.origin + ( 0, 0, 24 ), corpse.angles );
    constraint = spawnragdollconstraint( corpse, hitloc, bone, ( 0, 0, 0 ), 0 );
    
    if ( !constraint )
    {
        mover delete();
        return false;
    }
    
    constraint.origin = mover.origin;
    constraint.angles = mover.angles;
    constraint linkto( mover );
    mover.corpse = corpse;
    mover.constraint = constraint;
    mover.projectile = self;
    mover.var_a4bbc7b2b25613f2 = self.origin;
    mover.var_9e74ae92548de1ab = level.scarabww_settings.var_d53d14e827a2ec44 ?? 450;
    pin_info.var_546b525470d474ab = mover;
    self.is_pinned = 1;
    mover thread function_2df79f707720badd( attacker );
    return true;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x3a32b4ed, Offset: 0x1dfc
// Size: 0x106
function private find_target_wall_info( ai, attacker )
{
    var_cfb5dc6e8df2500f = level.scarabww_settings.var_d53d14e827a2ec44 ?? 450;
    trace_end = self.origin + var_cfb5dc6e8df2500f * anglestoforward( self.angles );
    all_result = trace::ray_trace_get_all_results( self.origin, trace_end, [ ai, attacker ] );
    
    foreach ( result in all_result )
    {
        if ( result && result[ "hittype" ] == "hittype_world" )
        {
            return result;
        }
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x81313aad, Offset: 0x1f0b
// Size: 0x4d
function private function_464b42b4655b29ad( pin_info )
{
    mover = pin_info.var_546b525470d474ab;
    pin_info.var_546b525470d474ab = undefined;
    
    if ( mover )
    {
        mover function_dda92e5e52815f46();
        mover delete();
    }
    
    self.is_pinned = 0;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x6a4da76a, Offset: 0x1f60
// Size: 0x179
function private function_2df79f707720badd( attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    frame_duration = level.framedurationseconds ?? 0.05;
    var_ec3e076c643b4104 = squared( self.var_9e74ae92548de1ab ?? 450 );
    
    while ( true )
    {
        if ( self.var_9093d7db187499fc )
        {
            break;
        }
        
        if ( self.projectile.origin && distancesquared( self.projectile.origin, self.var_a4bbc7b2b25613f2 ?? self.projectile.origin ) <= var_ec3e076c643b4104 )
        {
            self moveto( self.projectile.origin, frame_duration );
        }
        else
        {
            function_dda92e5e52815f46();
            
            if ( self.projectile )
            {
                self.projectile.is_pinned = 0;
            }
            
            break;
        }
        
        wait frame_duration;
    }
    
    if ( self.var_9093d7db187499fc )
    {
        self moveto( self.var_9093d7db187499fc, frame_duration );
        self waittill( #"movedone" );
        attacker function_f8822a9a8511677( self );
        return;
    }
    
    function_dda92e5e52815f46();
    
    if ( self.projectile )
    {
        self.projectile.is_pinned = 0;
    }
    
    self delete();
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x8ec3391d, Offset: 0x20e1
// Size: 0x43
function private function_f34645d74874bc1e( corpse, constraint )
{
    self.corpse = corpse;
    
    if ( constraint islinked() )
    {
        constraint unlink();
    }
    
    constraint linkto( self );
    self.constraint = constraint;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xfb51acb4, Offset: 0x212c
// Size: 0x90
function private function_dda92e5e52815f46()
{
    if ( self.corpse )
    {
        self.corpse function_dd258a3da9a2b4a1( 20 );
        self.corpse = undefined;
    }
    
    if ( self.constraint )
    {
        if ( self.constraint islinked() )
        {
            self.constraint unlink();
        }
        
        self.constraint delete();
        self.constraint = undefined;
    }
    
    if ( self.pin_arrow )
    {
        self.pin_arrow thread despawn_arrow();
        self.pin_arrow = undefined;
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x31b44695, Offset: 0x21c4
// Size: 0xe5
function private function_f8822a9a8511677( pinned_tag )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    data = get_scarabww_player_data();
    
    if ( !isdefined( data.pinned_enemies ) )
    {
        data.pinned_enemies = [];
    }
    
    if ( !isdefined( data.pinned_enemies ) )
    {
        data.pinned_enemies = [];
    }
    
    data.pinned_enemies[ data.pinned_enemies.size ] = pinned_tag;
    
    while ( data.pinned_enemies.size > ( level.scarabww_settings.var_32276ce537cb8174 ?? 2 ) )
    {
        var_957239c53a8147b = data.pinned_enemies[ 0 ];
        var_957239c53a8147b function_dda92e5e52815f46();
        data.pinned_enemies = arrayremove( data.pinned_enemies, var_957239c53a8147b );
        var_957239c53a8147b delete();
    }
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x5f95aa37, Offset: 0x22b1
// Size: 0x11a
function private function_9291f5d4eff972b8( ai, var_474320c0f46048f0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    corpse = ai getcorpseentity();
    
    if ( !isdefined( corpse ) || corpse.noragdoll || ai.noragdoll )
    {
        return;
    }
    
    vdir = var_474320c0f46048f0.vdir ?? ( 0, 0, 0 );
    
    if ( vdir[ 2 ] < 0 )
    {
        vdir = ( vdir[ 0 ], vdir[ 1 ], 0 );
        vdir = vectornormalize( vdir );
    }
    
    launchx = clamp( vdir[ 0 ] * 5000, -8000, 8000 );
    launchy = clamp( vdir[ 1 ] * 5000, -8000, 8000 );
    launchz = clamp( ( vdir[ 2 ] + 150 ) * 1500, 0, 4000 );
    v_launch = ( launchx, launchy, launchz );
    corpse startragdollfromimpact( get_projectile_impact_location( var_474320c0f46048f0 ), v_launch );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x7a38ceec, Offset: 0x23d3
// Size: 0xb5
function private get_projectile_impact_location( info )
{
    if ( info.shitloc && info.shitloc != "none" )
    {
        return info.shitloc;
    }
    
    hitloc = function_434d62cf72c4827( info.partname );
    
    if ( hitloc )
    {
        return hitloc;
    }
    
    hitlocs = [ "head", "left_arm_upper", "right_arm_upper", "left_leg_upper", "right_leg_upper" ];
    index = randomintrange( 0, hitlocs.size );
    return hitlocs[ index ];
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x5475a259, Offset: 0x2490
// Size: 0x1f7
function private function_434d62cf72c4827( partname )
{
    if ( !level.var_b3bc9eadfee90984 )
    {
        map = [];
        map[ #"j_head" ] = "head";
        map[ #"j_neck" ] = "neck";
        map[ #"j_neck2" ] = "neck";
        map[ #"hash_d7380f9cbc886f22" ] = "neck";
        map[ #"j_mainroot" ] = "torso_lower";
        map[ #"j_spinelower" ] = "torso_lower";
        map[ #"j_spinelower_2" ] = "torso_lower";
        map[ #"j_spine4" ] = "torso_lower";
        map[ #"j_spineupper" ] = "torso_upper";
        map[ #"j_spineupper_2" ] = "torso_upper";
        map[ #"j_clavicle_le" ] = "left_arm_upper";
        map[ #"j_shoulder_le" ] = "left_arm_upper";
        map[ #"j_elbow_le" ] = "left_arm_lower";
        map[ #"j_wrist_le" ] = "left_hand";
        map[ #"j_clavicle_ri" ] = "right_arm_upper";
        map[ #"j_shoulder_ri" ] = "right_arm_upper";
        map[ #"j_elbow_ri" ] = "right_arm_lower";
        map[ #"j_wrist_ri" ] = "right_hand";
        map[ #"j_hip_le" ] = "left_leg_upper";
        map[ #"j_knee_le" ] = "left_leg_lower";
        map[ #"j_ankle_le" ] = "left_foot";
        map[ #"j_ball_le" ] = "left_foot";
        map[ #"j_hip_ri" ] = "right_leg_upper";
        map[ #"j_knee_ri" ] = "right_leg_lower";
        map[ #"j_ankle_ri" ] = "right_foot";
        map[ #"j_ball_ri" ] = "right_foot";
        level.var_b3bc9eadfee90984 = map;
    }
    
    return level.var_b3bc9eadfee90984[ partname ];
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xf0e6b6c2, Offset: 0x2690
// Size: 0x205
function private function_10700076c9984d5a( attacker, weapon )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    attacker endon( #"death_or_disconnect" );
    self waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    data = attacker get_scarabww_player_data();
    
    if ( !is_projectile_consumed( data, self ) )
    {
        function_1a39433470613685( attacker, weapon, position, normal );
    }
    
    arrow = spawnscriptable( "scriptable_ww_scarab_arrow", position, self.angles );
    arrow.var_a9f760232ff2f27c = arrow function_e60210d780aa34f1( weapon.variantid, attacker function_b6759d5040e13258( "on" ) );
    arrow utility::function_7c10ea82c1e305b8( "vfx", attacker function_b6759d5040e13258( "on" ) );
    arrow.var_2dcd672a752f782c = attacker function_b6759d5040e13258( "out" );
    impact_fx = spawnscriptable( "scriptable_ww_scarab_impact", position, vectortoangles( normal ) );
    impact_fx utility::function_7c10ea82c1e305b8( "impact", attacker function_b6759d5040e13258( "on" ) );
    impact_fx utility::delaycall( 3, &freescriptable );
    
    if ( self.is_pinned && is_wall_surface( normal ) )
    {
        pin_info = attacker function_df01e237496f3e04( self.birthtime );
        
        if ( pin_info.var_546b525470d474ab )
        {
            pin_info.var_546b525470d474ab.var_9093d7db187499fc = position + normal * 8;
            pin_info.var_546b525470d474ab.pin_arrow = arrow;
        }
    }
    else if ( arrow )
    {
        arrow thread function_3b05a8f2cdc18960();
    }
    
    waittillframeend();
    
    if ( self )
    {
        self delete();
    }
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xe7987753, Offset: 0x289d
// Size: 0x58
function private function_e60210d780aa34f1( variant_id, state )
{
    part = "" + ( variant_id ?? 0 );
    
    if ( !self getscriptablehaspart( part ) || !self getscriptableparthasstate( part, state ) )
    {
        part = "0";
    }
    
    utility::function_7c10ea82c1e305b8( part, state );
    return part;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x7b907468, Offset: 0x28fe
// Size: 0x24
function private function_3b05a8f2cdc18960()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 3;
    despawn_arrow();
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xe5c70233, Offset: 0x292a
// Size: 0x7a
function private despawn_arrow()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.var_963f6941e9ea5a20 )
    {
        return;
    }
    
    self.var_963f6941e9ea5a20 = 1;
    utility::function_7c10ea82c1e305b8( "vfx", self.var_2dcd672a752f782c ?? "out" );
    wait 0.2;
    utility::function_7c10ea82c1e305b8( self.var_a9f760232ff2f27c, "off" );
    wait 2.8;
    
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x3fd46dd, Offset: 0x29ac
// Size: 0x38, Type: bool
function private function_cb9824c8362a2055( start_pos, end_pos )
{
    nav_trace = navtrace( start_pos, end_pos, undefined, 1 );
    return nav_trace[ "fraction" ] >= 1;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x64b7f168, Offset: 0x29ed
// Size: 0x9b, Type: bool
function private function_af5dce77769c7b02( impact_position )
{
    scriptables = getentitylessscriptablearray( undefined, undefined, impact_position, 64 );
    
    foreach ( scriptable in scriptables )
    {
        if ( scriptable.var_674f590d538943ad )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weap_scarabww
// Params 4, eflags: 0x4
// Checksum 0x58d31902, Offset: 0x2a91
// Size: 0x174
function private function_1a39433470613685( attacker, weapon, impact_position, normal )
{
    if ( !isplayer( attacker ) || !isweapon( weapon ) )
    {
        return;
    }
    
    data = attacker get_scarabww_player_data();
    
    if ( ( data.cyclone_allowance ?? 0 ) > 0 && gettime() - ( data.var_d7cc26528a76e456 ?? 0 ) > 1000 )
    {
        function_bee9462110cdda2b( data );
    }
    
    if ( is_projectile_consumed( data, self ) )
    {
        return;
    }
    
    if ( ( data.cyclone_allowance ?? 0 ) <= 0 )
    {
        return;
    }
    
    var_6b297a8b3c91d24 = level.scarabww_settings.var_7492114341e7c11c ?? 64;
    var_d2a25abba3c5b525 = squared( var_6b297a8b3c91d24 );
    spawn_pos = getclosestpointonnavmesh( impact_position );
    
    if ( !isdefined( spawn_pos ) )
    {
        return;
    }
    
    impact_range_override = function_af5dce77769c7b02( impact_position );
    
    if ( distancesquared( impact_position, spawn_pos ) > var_d2a25abba3c5b525 && !impact_range_override )
    {
        return;
    }
    
    if ( normal && !impact_range_override )
    {
        trace_start = impact_position + normal * 20;
        trace_start = getclosestpointonnavmesh( trace_start ) ?? trace_start;
        
        if ( distancesquared( trace_start, spawn_pos ) >= 1 && !function_cb9824c8362a2055( trace_start, spawn_pos ) )
        {
            return;
        }
    }
    
    attacker function_f002904d7078410f( data, weapon, self, spawn_pos );
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xe611d794, Offset: 0x2c0d
// Size: 0xd
function private destroy_projectile()
{
    waittillframeend();
    
    if ( self )
    {
        self delete();
    }
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x97c4eca3, Offset: 0x2c22
// Size: 0x74
function private function_b711d8e6dc0f228c()
{
    while ( true )
    {
        self waittill( #"hash_69562b0de38a064f", param );
        
        switch ( param )
        {
            case 0:
            case 1:
                function_1af6c640206661d4();
                break;
            case 2:
                function_e075f230141cb405();
                break;
            default:
                break;
        }
    }
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x4e484859, Offset: 0x2c9e
// Size: 0x108
function private function_1af6c640206661d4()
{
    data = get_scarabww_player_data();
    weapon = self getcurrentweapon();
    
    if ( !isweapon( weapon ) || weapon.basename != level.scarabww_basename )
    {
        return;
    }
    
    if ( data.is_akimbo )
    {
        if ( !isnumber( data.var_90c60637afa7a0fc ) && self attackbuttonpressed() )
        {
            data.var_90c60637afa7a0fc = gettime();
            data.var_c703adc98942f6a = function_a9cd21f3a734079e( weapon, "left" );
        }
        
        if ( !isnumber( data.var_cead3fa3a6f574c ) && self adsbuttonpressed( 1 ) )
        {
            data.var_cead3fa3a6f574c = gettime();
            data.var_dfa7a53acb72d9a = function_a9cd21f3a734079e( weapon, "right" );
        }
        
        return;
    }
    
    data.var_90c60637afa7a0fc = gettime();
    data.var_c703adc98942f6a = function_a9cd21f3a734079e( weapon );
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xfcaa8899, Offset: 0x2dae
// Size: 0x195
function private function_e075f230141cb405()
{
    data = get_scarabww_player_data();
    
    if ( self reloadbuttonpressed() )
    {
        function_9ebcc80b128d0b7c( data );
        return;
    }
    
    default_fully_charged = 0;
    var_4d2139df1419f617 = 0;
    
    if ( data.is_akimbo )
    {
        if ( !self attackbuttonpressed() && function_56c9264f11b60c29( data.var_90c60637afa7a0fc ) )
        {
            default_fully_charged = 1;
        }
        
        if ( !self adsbuttonpressed( 1 ) && function_56c9264f11b60c29( data.var_cead3fa3a6f574c ) )
        {
            var_4d2139df1419f617 = 1;
        }
    }
    else if ( function_56c9264f11b60c29( data.var_90c60637afa7a0fc ) )
    {
        default_fully_charged = 1;
    }
    
    if ( default_fully_charged || var_4d2139df1419f617 )
    {
        if ( ( data.cyclone_allowance ?? 0 ) <= 0 || gettime() - ( data.var_d7cc26528a76e456 ?? 0 ) > 1000 )
        {
            function_bee9462110cdda2b( data );
        }
        
        if ( default_fully_charged )
        {
            function_cf207369cbea161d( data, function_69a05143f20ee5c0( data ), data.var_c703adc98942f6a );
        }
        
        if ( var_4d2139df1419f617 )
        {
            function_cf207369cbea161d( data, "right", data.var_dfa7a53acb72d9a );
        }
    }
    
    if ( data.is_akimbo )
    {
        if ( !self attackbuttonpressed() )
        {
            data.var_90c60637afa7a0fc = undefined;
            data.var_c703adc98942f6a = undefined;
        }
        
        if ( !self adsbuttonpressed( 1 ) )
        {
            data.var_cead3fa3a6f574c = undefined;
            data.var_dfa7a53acb72d9a = undefined;
        }
        
        return;
    }
    
    data.var_90c60637afa7a0fc = undefined;
    data.var_c703adc98942f6a = undefined;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x7d93b637, Offset: 0x2f4b
// Size: 0x5c
function private function_981bbd22dba7bd3c()
{
    while ( true )
    {
        waitframe();
        
        if ( !self reloadbuttonpressed() )
        {
            continue;
        }
        
        data = get_scarabww_player_data();
        
        if ( !isnumber( data.var_90c60637afa7a0fc ) && !isnumber( data.var_cead3fa3a6f574c ) )
        {
            continue;
        }
        
        function_9ebcc80b128d0b7c( data );
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x3150edd0, Offset: 0x2faf
// Size: 0x41
function private function_9ebcc80b128d0b7c( data )
{
    data.var_90c60637afa7a0fc = undefined;
    data.var_c703adc98942f6a = undefined;
    data.var_cead3fa3a6f574c = undefined;
    data.var_dfa7a53acb72d9a = undefined;
    function_bee9462110cdda2b( data );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x75f81833, Offset: 0x2ff8
// Size: 0x43
function private function_8b9a615d788c52ac( cyclone )
{
    if ( !self || !cyclone )
    {
        return;
    }
    
    did_wait = throttle::throttle_wait_gate( level.scarabww_cyclone_damage_throttle );
    
    if ( !self || !cyclone )
    {
        return;
    }
    
    return did_wait;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xcdd59a3, Offset: 0x3044
// Size: 0x7ed
function private function_e7549be0850f8b3( cyclone, weapon )
{
    level endon( #"game_ended" );
    self.var_f631ee8355e6e83a = 0;
    
    if ( !cyclone )
    {
        return;
    }
    
    cyclone_lifetime = level.scarabww_settings.cyclonelifetime ?? 3;
    var_b3311583a07b28b9 = level.scarabww_settings.var_236e4e29c0419de2 ?? 0.5;
    pap_level = utility::callsharedfunc( #"zombie", #"get_pap_level", weapon );
    cyclone_speed = level.scarabww_settings.var_7732433c5d9e32f9 ?? 48;
    scr_damage = level.scarabww_settings.var_abf3a56a7d07e7dc ?? 100;
    var_5454f57201136c19 = level.scarabww_settings.var_abf3a56a7d07e7dc ?? 300;
    var_2cb9fba4482b9d09 = var_5454f57201136c19;
    var_7aba347f533600c8 = var_5454f57201136c19 * ( zombie_damage::function_dcee44724d9edddd( weapon, pap_level ) ?? 1 );
    
    switch ( pap_level )
    {
        case 1:
            var_2cb9fba4482b9d09 = var_5454f57201136c19 * ( level.scarabww_settings.var_ca639bea06a2ae29 ?? 1 );
            break;
        case 2:
            var_2cb9fba4482b9d09 = var_5454f57201136c19 * ( level.scarabww_settings.var_5789a88ca518c5fc ?? 2 );
            break;
        case 3:
            var_2cb9fba4482b9d09 = var_5454f57201136c19 * ( level.scarabww_settings.var_c7a34100c2fd824f ?? 4 );
            break;
        case 4:
            var_2cb9fba4482b9d09 = var_5454f57201136c19 * ( level.scarabww_settings.var_74f8208cac2bf93a ?? 7 );
            break;
        default:
            break;
    }
    
    wait 0.35;
    
    while ( cyclone_lifetime > 0 )
    {
        tick_start_time = gettime();
        
        if ( !self )
        {
            break;
        }
        
        if ( cyclone.var_cfb11de0d6c22510 )
        {
            break;
        }
        
        move_to_position = undefined;
        cyclone_radius = level.scarabww_settings.cycloneradius ?? 96;
        cyclone_radius_squared = squared( cyclone_radius );
        scriptables = getentitylessscriptablearray( undefined, undefined, cyclone.origin + ( 0, 0, cyclone_radius / 2 ), cyclone_radius );
        
        foreach ( scriptable in scriptables )
        {
            scriptable scriptabledodamage( scr_damage, cyclone, self, undefined, undefined, "MOD_SPECIAL_KILL", weapon );
        }
        
        affected_ents = damage_utility::function_cf1c753aefa70ea1( self.team );
        
        foreach ( ent in affected_ents )
        {
            if ( !isent( ent ) )
            {
                continue;
            }
            
            if ( !ent.var_1355a2eee0e45cf0 )
            {
                continue;
            }
            
            if ( distancesquared( ent.origin, cyclone.origin ) <= squared( cyclone_radius * 3 ) )
            {
                ent dodamage( scr_damage, cyclone.origin, self, cyclone, "MOD_SPECIAL_KILL", weapon, undefined, undefined, 65536 );
            }
        }
        
        zombies = getaiarrayinradius( cyclone.origin, cyclone_speed * 4, "team_two_hundred" );
        zombies = sortbydistance( zombies, cyclone.origin );
        var_3d4e031ab8575b3e = 0;
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            zombie_origin = zombie.origin;
            
            if ( distancesquared( zombie_origin, cyclone.origin ) > cyclone_radius_squared )
            {
                if ( !move_to_position )
                {
                    move_to_position = zombie_origin;
                }
                
                if ( !var_3d4e031ab8575b3e )
                {
                    break;
                }
                
                continue;
            }
            
            if ( zombie.var_2bd1a7d96fc4b2c5 == cyclone )
            {
                if ( !move_to_position )
                {
                    move_to_position = zombie_origin;
                }
                
                continue;
            }
            
            did_wait = function_8b9a615d788c52ac( cyclone );
            
            if ( did_wait === undefined )
            {
                break;
            }
            
            if ( did_wait )
            {
                var_3d4e031ab8575b3e = 1;
            }
            
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            zombie_origin = zombie.origin;
            
            if ( distancesquared( zombie_origin, cyclone.origin ) > cyclone_radius_squared )
            {
                continue;
            }
            
            is_annihilate = 0;
            var_9eda6aa717a37a88 = zombie.health - var_7aba347f533600c8 <= 0;
            
            if ( ( cyclone.var_403f8f68de591461 ?? 0 ) >= ( level.scarabww_settings.var_bba21acde1e31806 ?? 4 ) && var_9eda6aa717a37a88 )
            {
                zombie.forceannihilate = 1;
                is_annihilate = 1;
            }
            
            if ( !zombie.var_2bd1a7d96fc4b2c5 && !is_annihilate && var_9eda6aa717a37a88 && zombie function_94c2de0ecdfa3fd5() && zombie function_5aa9f640bb0e3c71() )
            {
                zombie.var_2bd1a7d96fc4b2c5 = cyclone;
                cyclone.var_403f8f68de591461 = ( cyclone.var_403f8f68de591461 ?? 0 ) + 1;
                childthread function_6f4896026afdf5b9( zombie, cyclone, weapon, var_2cb9fba4482b9d09, cyclone_lifetime );
                continue;
            }
            
            zombie dodamage( var_2cb9fba4482b9d09, cyclone.origin, self, undefined, "MOD_SPECIAL_KILL", weapon, undefined, undefined, 65536 );
            
            if ( isalive( zombie ) )
            {
                zombie effect_slow::slow( "scarabww_slow", level.scarabww_settings.var_8fbf3c413337b5c7 ?? 0.2, var_b3311583a07b28b9 + 0.1, self );
                
                if ( !move_to_position )
                {
                    move_to_position = zombie_origin;
                }
                
                continue;
            }
            
            zombie utility::ent_flag_set( "cyclone_kill" );
        }
        
        if ( !self || !cyclone )
        {
            break;
        }
        
        if ( !isdefined( move_to_position ) )
        {
            move_to_position = cyclone.origin + ( randomintrange( cyclone_radius * -1, cyclone_radius ), randomfloatrange( cyclone_radius * -1, cyclone_radius ), 0 );
        }
        
        var_6d7d592c30e3569d = getclosestpointonnavmesh( move_to_position );
        
        if ( var_6d7d592c30e3569d )
        {
            move_to_position = var_6d7d592c30e3569d;
        }
        
        move_distance = distance( cyclone.origin, move_to_position );
        
        if ( move_distance >= 1 && function_cb9824c8362a2055( cyclone.origin, move_to_position ) )
        {
            move_time = move_distance / cyclone_speed;
            cyclone moveto( move_to_position, move_time );
        }
        
        elapsed_tick_time = ( gettime() - tick_start_time ) * 0.001;
        
        if ( elapsed_tick_time < var_b3311583a07b28b9 )
        {
            wait var_b3311583a07b28b9 - elapsed_tick_time;
            elapsed_tick_time = var_b3311583a07b28b9;
        }
        
        cyclone_lifetime -= elapsed_tick_time;
    }
    
    if ( cyclone && !cyclone.var_cfb11de0d6c22510 )
    {
        playworldsound( cyclone.origin + ( 0, 0, 75 ), #"hash_f59d17e393281a03" );
        
        if ( self )
        {
            cyclone utility::function_7c10ea82c1e305b8( "cyclone", function_b6759d5040e13258( "out" ) );
        }
        
        cyclone utility::delaycall( 2, &delete );
    }
}

// Namespace weap_scarabww
// Params 5, eflags: 0x4
// Checksum 0x92937d3a, Offset: 0x3839
// Size: 0x401
function private function_6f4896026afdf5b9( zombie, cyclone, weapon, var_2cb9fba4482b9d09, pull_timeout )
{
    if ( !isalive( zombie ) || !cyclone )
    {
        function_daeccc89929c8456( zombie, cyclone );
        return;
    }
    
    if ( !isalive( self ) )
    {
        zombie dodamage( var_2cb9fba4482b9d09, cyclone.origin, self, undefined, "MOD_SPECIAL_KILL", weapon, undefined, undefined, 65536 );
        function_daeccc89929c8456( zombie, cyclone );
        return;
    }
    
    var_2955579f743afa59 = level.scarabww_settings.var_512c11db332fdc9c ?? 48;
    var_4276f44908197ae6 = squared( var_2955579f743afa59 );
    var_497021c454a580b9 = { #var_83e3debba79e4480:zombie getentitynumber(), #spawn_time:gettime(), #owner_num:self getentitynumber() };
    pull_deadline = gettime() + pull_timeout * 1000;
    
    while ( isalive( self ) && isalive( zombie ) && cyclone && gettime() < pull_deadline && distancesquared( zombie getcentroid(), cyclone.origin ) > var_4276f44908197ae6 )
    {
        pull_origin = cyclone.origin;
        var_acefecea26e4c38d = utility::drop_to_ground( pull_origin, 0 );
        vortex_height = max( pull_origin[ 2 ] - var_acefecea26e4c38d[ 2 ], 0 );
        vortex_payload = { #mode:"blackhole", #height:vortex_height };
        zombie vortex::set_vortex_state( "blackhole", var_497021c454a580b9, pull_origin, var_2955579f743afa59, vortex_payload );
        waitframe();
    }
    
    if ( zombie )
    {
        zombie vortex::clear_vortex_state( "blackhole", var_497021c454a580b9, 0 );
    }
    
    if ( !isalive( self ) && isalive( zombie ) && cyclone )
    {
        zombie dodamage( var_2cb9fba4482b9d09, cyclone.origin, self, undefined, "MOD_SPECIAL_KILL", weapon, undefined, undefined, 65536 );
        function_daeccc89929c8456( zombie, cyclone );
        return;
    }
    
    pull_timed_out = isalive( self ) && isalive( zombie ) && cyclone && gettime() >= pull_deadline;
    
    if ( pull_timed_out )
    {
        zombie dodamage( var_2cb9fba4482b9d09, cyclone.origin, self, undefined, "MOD_SPECIAL_KILL", weapon, undefined, undefined, 65536 );
        
        if ( !isalive( zombie ) )
        {
            zombie utility::ent_flag_set( "cyclone_kill" );
        }
        
        function_daeccc89929c8456( zombie, cyclone );
        return;
    }
    
    var_c471509a63d419d8 = 0;
    
    if ( isalive( self ) && isalive( zombie ) && cyclone && gettime() < pull_deadline )
    {
        var_c471509a63d419d8 = 1;
        completion_notify = "scarabww_cyclone_twirling_complete_" + zombie getentitynumber() + "_" + gettime();
        var_5b4d58dad490b73b = completion_notify + "_abort";
        zombie thread function_13ada875e639428a( self, completion_notify, var_5b4d58dad490b73b );
        zombie thread function_f640333d06d84c99( self, completion_notify, var_5b4d58dad490b73b );
        zombie thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "scarab_cyclone_spin", "scarabww_cyclone_twirling_done", undefined, undefined, "scarabww_cyclone_animating" );
        completion_timeout = max( ( pull_deadline - gettime() ) * 0.001, level.framedurationseconds );
        utility::waittill_any_timeout_no_endon_death( completion_timeout, completion_notify );
        
        if ( zombie )
        {
            zombie notify( var_5b4d58dad490b73b );
        }
    }
    
    if ( isalive( zombie ) && var_c471509a63d419d8 )
    {
        zombie.forceannihilate = 1;
        damage_origin = cyclone ? cyclone.origin : zombie.origin;
        damage_attacker = isalive( self ) ? self : undefined;
        zombie dodamage( zombie.maxhealth, damage_origin, damage_attacker, cyclone, "MOD_SPECIAL_KILL", weapon, undefined, undefined, 1073807360 );
        
        if ( !isalive( zombie ) )
        {
            zombie utility::ent_flag_set( "cyclone_kill" );
        }
    }
    
    function_daeccc89929c8456( zombie, cyclone );
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0xef65531c, Offset: 0x3c42
// Size: 0x46
function private function_13ada875e639428a( player, completion_notify, var_5b4d58dad490b73b )
{
    self endon( #"death" );
    self endon( var_5b4d58dad490b73b );
    self waittill( #"scarabww_cyclone_twirling_done" );
    
    if ( player )
    {
        player notify( completion_notify );
    }
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0xe6430793, Offset: 0x3c90
// Size: 0x3a
function private function_f640333d06d84c99( player, completion_notify, var_5b4d58dad490b73b )
{
    self endon( var_5b4d58dad490b73b );
    self waittill( #"death" );
    
    if ( player )
    {
        player notify( completion_notify );
    }
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x34d5ba44, Offset: 0x3cd2
// Size: 0x4e
function private function_daeccc89929c8456( zombie, cyclone )
{
    if ( zombie )
    {
        zombie.var_2bd1a7d96fc4b2c5 = undefined;
    }
    
    if ( cyclone )
    {
        cyclone.var_403f8f68de591461 = max( ( cyclone.var_403f8f68de591461 ?? 1 ) - 1, 0 );
    }
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xd5f71024, Offset: 0x3d28
// Size: 0x20, Type: bool
function private function_94c2de0ecdfa3fd5()
{
    return function_bb679325bcb070fc( self.subclass ) && utility::function_4c656524ecb504d6( "scarab_cyclone_spin" );
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xe2b847f0, Offset: 0x3d51
// Size: 0x27, Type: bool
function private function_5aa9f640bb0e3c71()
{
    return self.var_19238dbcc969affa && self.var_5927d2279779cec0 && val::get( "allow_secondary_attack_damage" );
}

// Namespace weap_scarabww
// Params 1
// Checksum 0xd9baf4e8, Offset: 0x3d81
// Size: 0x4b, Type: bool
function function_3a1514a781375202( var_506fb5f70cf3bee7 )
{
    if ( isstruct( var_506fb5f70cf3bee7 ) )
    {
        einflictor = var_506fb5f70cf3bee7.einflictor;
    }
    else
    {
        einflictor = var_506fb5f70cf3bee7;
    }
    
    if ( einflictor.model == "xmodel_ww_scarab_cyclone" )
    {
        return true;
    }
    
    return false;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x802d73f7, Offset: 0x3dd5
// Size: 0xbc
function private function_cc1109ea94e5bf00()
{
    if ( !self )
    {
        return;
    }
    
    data = get_scarabww_player_data();
    
    if ( !data.pinned_enemies )
    {
        return;
    }
    
    foreach ( pinned_tag in data.pinned_enemies )
    {
        if ( pinned_tag )
        {
            pinned_tag function_dda92e5e52815f46();
            pinned_tag delete();
        }
    }
    
    data.pinned_enemies = [];
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0x7b1ca597, Offset: 0x3e99
// Size: 0x33
function private get_scarabww_player_data()
{
    assert( isplayer( self ), "<dev string:x24>" );
    
    if ( !isdefined( self.scarabww_player_data ) )
    {
        self.scarabww_player_data = {};
    }
    
    return self.scarabww_player_data;
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0x2a5832a3, Offset: 0x3ed5
// Size: 0x60
function private function_33b191773590b1cb( attacker, data, spawn_pos )
{
    if ( isplayer( attacker ) && ( data.var_875ad57b11925918 ?? 0 ) > 0 )
    {
        spawn_pos += anglestoright( attacker.angles ) * 24;
        spawn_pos = utility::drop_to_ground( spawn_pos, 0 );
    }
    
    return spawn_pos;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x2a11bf37, Offset: 0x3f3e
// Size: 0x51
function private function_bee9462110cdda2b( data )
{
    data.cyclone_allowance = 0;
    data.var_d7cc26528a76e456 = 0;
    data.var_875ad57b11925918 = 0;
    data.var_11b5d4d736bd40da = "left";
    data.var_ad02f13723840236 = [];
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x5c7eb9d5, Offset: 0x3f97
// Size: 0x74
function private function_75a813c26ede499d( projectile, birth_time )
{
    if ( !isdefined( projectile ) )
    {
        return;
    }
    
    if ( isdefined( projectile.var_e936ea68537e7723 ) )
    {
        return projectile.var_e936ea68537e7723;
    }
    
    ent_num = projectile getentitynumber();
    key = "ent_" + ent_num;
    
    if ( isnumber( birth_time ) )
    {
        key += "_bt_" + birth_time;
    }
    
    return key;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x87299715, Offset: 0x4014
// Size: 0x4b, Type: bool
function private function_b390af29ffb94c8b( data, consume_key )
{
    if ( !isdefined( consume_key ) )
    {
        return false;
    }
    
    if ( !isdefined( data.var_4a6e7c66f9d2ca4b ) )
    {
        data.var_4a6e7c66f9d2ca4b = [];
    }
    
    return data.var_4a6e7c66f9d2ca4b[ consume_key ] ?? 0;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x5be96488, Offset: 0x4068
// Size: 0x46, Type: bool
function private is_projectile_consumed( data, projectile )
{
    if ( !isdefined( projectile ) )
    {
        return false;
    }
    
    consume_key = function_75a813c26ede499d( projectile, projectile.birthtime );
    return function_b390af29ffb94c8b( data, consume_key );
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xeb62d6ae, Offset: 0x40b7
// Size: 0x6e
function private function_8ddbe3bdebda3d2( data, projectile )
{
    if ( !isdefined( projectile ) )
    {
        return;
    }
    
    consume_key = function_75a813c26ede499d( projectile, projectile.birthtime );
    
    if ( !isdefined( data.var_4a6e7c66f9d2ca4b ) )
    {
        data.var_4a6e7c66f9d2ca4b = [];
    }
    
    if ( isdefined( consume_key ) )
    {
        data.var_4a6e7c66f9d2ca4b[ consume_key ] = 1;
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x25c9d62c, Offset: 0x412d
// Size: 0x20
function private function_69a05143f20ee5c0( data )
{
    if ( data.is_akimbo )
    {
        return "left";
    }
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xd22675a1, Offset: 0x4156
// Size: 0x2c
function private function_b6759d5040e13258( str )
{
    return get_scarabww_player_data().is_pap ? str + "_pap" : str;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0x9a40b4d9, Offset: 0x418b
// Size: 0x3e
function private function_a9cd21f3a734079e( weapon, hand = undefined )
{
    if ( !isweapon( weapon ) )
    {
        return 0;
    }
    
    if ( hand )
    {
        return self getweaponammoclip( weapon, hand );
    }
    
    return self getweaponammoclip( weapon );
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xe65a2fc6, Offset: 0x41d2
// Size: 0x6f, Type: bool
function private function_d881e619f671cd82( weapon, hand = undefined )
{
    if ( !isweapon( weapon ) )
    {
        return false;
    }
    
    current_clip_ammo = function_a9cd21f3a734079e( weapon, hand );
    new_clip_ammo = max( current_clip_ammo - 3, 0 );
    
    if ( hand )
    {
        self setweaponammoclip( weapon, new_clip_ammo, hand );
    }
    else
    {
        self setweaponammoclip( weapon, new_clip_ammo );
    }
    
    return true;
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0x2d2723ae, Offset: 0x424a
// Size: 0xda
function private function_cf207369cbea161d( data, hand, charge_clip_ammo )
{
    if ( !isdefined( data.var_ad02f13723840236 ) )
    {
        data.var_ad02f13723840236 = [];
    }
    
    if ( data.var_ad02f13723840236.size >= 2 )
    {
        data.cyclone_allowance = data.var_ad02f13723840236.size;
        data.var_d7cc26528a76e456 = gettime();
        return;
    }
    
    token = { #charge_clip_ammo:charge_clip_ammo, #hand:hand };
    data.var_ad02f13723840236[ data.var_ad02f13723840236.size ] = token;
    data.cyclone_allowance = data.var_ad02f13723840236.size;
    data.var_d7cc26528a76e456 = gettime();
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xbfa2a93a, Offset: 0x432c
// Size: 0xb0
function private function_b77c7c5e365524ca( data )
{
    if ( !isdefined( data.var_ad02f13723840236 ) )
    {
        data.var_ad02f13723840236 = [];
    }
    
    data.var_ad02f13723840236 = function_5713d46873b29625( data.var_ad02f13723840236 );
    
    if ( !data.var_ad02f13723840236.size )
    {
        data.cyclone_allowance = 0;
        return;
    }
    
    token = data.var_ad02f13723840236[ 0 ];
    data.var_ad02f13723840236[ 0 ] = undefined;
    function_cdc669dbc8ea2101( data.var_ad02f13723840236 );
    data.cyclone_allowance = data.var_ad02f13723840236.size;
    return token;
}

// Namespace weap_scarabww
// Params 2, eflags: 0x4
// Checksum 0xef8ab048, Offset: 0x43e5
// Size: 0x243
function private function_66fe5bea38269428( weapon, preferred_hand = undefined )
{
    data = get_scarabww_player_data();
    
    if ( !isdefined( data.var_ad02f13723840236 ) )
    {
        data.var_ad02f13723840236 = [];
    }
    
    data.var_ad02f13723840236 = function_5713d46873b29625( data.var_ad02f13723840236 );
    
    if ( !data.var_ad02f13723840236.size )
    {
        data.cyclone_allowance = 0;
        return;
    }
    
    var_2bfd1e98bd556afb = undefined;
    
    if ( preferred_hand )
    {
        for ( i = 0; i < data.var_ad02f13723840236.size ; i++ )
        {
            token = data.var_ad02f13723840236[ i ];
            
            if ( token && token.hand == preferred_hand )
            {
                var_2bfd1e98bd556afb = i;
                break;
            }
        }
    }
    
    if ( !isdefined( var_2bfd1e98bd556afb ) )
    {
        var_2bfd1e98bd556afb = 0;
        var_5bf3b455882ad0c5 = -999999;
        var_3c22fc7c281e07d2 = data.var_11b5d4d736bd40da ?? "left";
        
        for ( i = 0; i < data.var_ad02f13723840236.size ; i++ )
        {
            token = data.var_ad02f13723840236[ i ];
            
            if ( !isdefined( token ) )
            {
                continue;
            }
            
            score = 0;
            
            if ( isdefined( token.hand ) && isweapon( weapon ) && weapon::isakimbo( weapon ) )
            {
                current_clip_ammo = self getweaponammoclip( weapon, token.hand );
                score = token.charge_clip_ammo - current_clip_ammo;
            }
            
            if ( score > var_5bf3b455882ad0c5 )
            {
                var_2bfd1e98bd556afb = i;
                var_5bf3b455882ad0c5 = score;
                continue;
            }
            
            if ( score == var_5bf3b455882ad0c5 && isdefined( token.hand ) && token.hand == var_3c22fc7c281e07d2 )
            {
                var_2bfd1e98bd556afb = i;
            }
        }
    }
    
    token = data.var_ad02f13723840236[ var_2bfd1e98bd556afb ];
    data.var_ad02f13723840236[ var_2bfd1e98bd556afb ] = undefined;
    
    if ( isint( var_2bfd1e98bd556afb ) )
    {
        function_cdc669dbc8ea2101( data.var_ad02f13723840236 );
    }
    
    data.cyclone_allowance = data.var_ad02f13723840236.size;
    return token;
}

// Namespace weap_scarabww
// Params 3, eflags: 0x4
// Checksum 0x368cfb6c, Offset: 0x4631
// Size: 0xcd
function private function_406f94f46c89554d( data, weapon, projectile )
{
    if ( !isweapon( weapon ) )
    {
        return 0;
    }
    
    preferred_hand = function_e5336f1e98c75fbb( projectile );
    token = function_66fe5bea38269428( weapon, preferred_hand );
    
    if ( !token )
    {
        return 0;
    }
    
    function_8ddbe3bdebda3d2( data, projectile );
    deduct_hand = preferred_hand ?? token.hand;
    
    if ( deduct_hand == "left" )
    {
        data.var_11b5d4d736bd40da = "right";
    }
    else if ( deduct_hand == "right" )
    {
        data.var_11b5d4d736bd40da = "left";
    }
    
    consumed = function_d881e619f671cd82( weapon, deduct_hand );
    return consumed;
}

// Namespace weap_scarabww
// Params 4, eflags: 0x4
// Checksum 0xfa7499f5, Offset: 0x4707
// Size: 0xb7, Type: bool
function private function_f002904d7078410f( data, weapon, projectile, spawn_pos )
{
    if ( !isdefined( spawn_pos ) )
    {
        return false;
    }
    
    spawn_pos = function_33b191773590b1cb( self, data, spawn_pos );
    cyclone = utility::spawn_model( "xmodel_ww_scarab_cyclone", spawn_pos );
    
    if ( !cyclone )
    {
        return false;
    }
    
    cyclone utility::function_7c10ea82c1e305b8( "cyclone", function_b6759d5040e13258( "loop" ) );
    
    if ( !function_406f94f46c89554d( data, weapon, projectile ) )
    {
        cyclone delete();
        return false;
    }
    
    data.var_875ad57b11925918 = ( data.var_875ad57b11925918 ?? 0 ) + 1;
    thread function_e7549be0850f8b3( cyclone, weapon );
    return true;
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xd4e85dd2, Offset: 0x47c7
// Size: 0x93
function private function_df01e237496f3e04( projectile_birthtime )
{
    assert( isplayer( self ), "<dev string:x24>" );
    data = get_scarabww_player_data();
    
    if ( !isdefined( data.pin_infos ) )
    {
        data.pin_infos = [];
    }
    
    pin_info = data.pin_infos[ projectile_birthtime ];
    
    if ( !isdefined( pin_info ) )
    {
        pin_info = { #var_546b525470d474ab:undefined, #var_66151cc039d2151:[] };
        data.pin_infos[ projectile_birthtime ] = pin_info;
    }
    
    return pin_info;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xa30735aa, Offset: 0x4863
// Size: 0x31
function private get_chest_pos()
{
    if ( self tagexists( "j_spineupper" ) )
    {
        pos = self gettagorigin( "j_spineupper" );
    }
    else
    {
        pos = self getcentroid();
    }
    
    return pos;
}

// Namespace weap_scarabww
// Params 0, eflags: 0x4
// Checksum 0xa7c34c75, Offset: 0x489d
// Size: 0x35
function private get_scarabww_target_pos()
{
    override_tag = self.var_6cd3687f6622091c;
    
    if ( override_tag && self tagexists( override_tag ) )
    {
        return self gettagorigin( override_tag );
    }
    
    return get_chest_pos();
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xcdb47495, Offset: 0x48db
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0xcb82455e, Offset: 0x4901
// Size: 0x49, Type: bool
function private is_wall_surface( surface_normal )
{
    dot = vectordot( surface_normal, ( 0, 0, 1 ) );
    return !( dot >= 0.96593 || dot <= -0.96593 && dot > -1 );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x9525e38f, Offset: 0x4953
// Size: 0x33, Type: bool
function private function_56c9264f11b60c29( charge_start_time )
{
    return charge_start_time && gettime() - charge_start_time >= ( level.scarabww_settings.var_1d9e97f328d5e7be ?? 1000 );
}

// Namespace weap_scarabww
// Params 1, eflags: 0x4
// Checksum 0x72c5a075, Offset: 0x498f
// Size: 0x17
function private function_bb679325bcb070fc( subclass )
{
    return issubstr( subclass, "zombie_base" );
}

// Namespace weap_scarabww
// Params 1
// Checksum 0xa255e174, Offset: 0x49af
// Size: 0xe5
function function_26efc39c293acff8( is_dual = 1 )
{
    assert( isplayer( self ), "<dev string:x24>" );
    current_weapon = self getcurrentweapon();
    
    if ( current_weapon && current_weapon.basename == level.scarabww_basename )
    {
        var_a604ff24fb5c90bd = weapon::isakimbo( current_weapon );
        
        if ( is_dual && !var_a604ff24fb5c90bd )
        {
            new_weapon = current_weapon withattachment( "sat_stock_akimbo_ww_scarab" );
        }
        else if ( !is_dual && var_a604ff24fb5c90bd )
        {
            new_weapon = current_weapon withoutattachment( "sat_stock_akimbo_ww_scarab" );
        }
        else
        {
            return;
        }
        
        if ( new_weapon )
        {
            inventory_utility::_takeweapon( current_weapon );
            inventory_utility::_giveweapon( new_weapon );
            self setweaponammoclip( new_weapon, weaponclipsize( new_weapon ) );
            self setweaponammostock( new_weapon, weaponmaxammo( new_weapon ) );
            inventory_utility::_switchtoweaponimmediate( new_weapon );
        }
    }
}

/#

    // Namespace weap_scarabww
    // Params 0, eflags: 0x4
    // Checksum 0x2409a4e7, Offset: 0x4a9c
    // Size: 0x46, Type: dev
    function private init_scarabww_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x58>" );
        devgui::add_devgui_func( "<dev string:x70>", "<dev string:x8b>", &function_1ae41bfb2b2141bd );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xc7>", &function_8504a49b45fc4053, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weap_scarabww
    // Params 0, eflags: 0x4
    // Checksum 0x78ece31e, Offset: 0x4aea
    // Size: 0xdb, Type: dev
    function private function_1ae41bfb2b2141bd()
    {
        foreach ( player in level.players )
        {
            if ( player isweaponsenabled() && isweapon( player.currentweapon ) && player.currentweapon.basename == level.scarabww_basename )
            {
                is_akimbo = weapon::isakimbo( player.currentweapon );
                player function_26efc39c293acff8( !is_akimbo );
            }
        }
    }

    // Namespace weap_scarabww
    // Params 0, eflags: 0x4
    // Checksum 0x21d7bf0e, Offset: 0x4bcd
    // Size: 0xcb, Type: dev
    function private function_8504a49b45fc4053()
    {
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( player isweaponsenabled() && isweapon( player.currentweapon ) && player.currentweapon.basename == level.scarabww_basename )
                {
                    player function_bc7f55297d2b010f();
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace weap_scarabww
    // Params 0, eflags: 0x4
    // Checksum 0xe98c5ec7, Offset: 0x4ca0
    // Size: 0x120, Type: dev
    function private function_bc7f55297d2b010f()
    {
        var_f86585b177386a52 = self getvieworigin();
        var_9f3b32e1a46f3c50 = self getgunangles();
        function_28cb92c2743cc44e( var_f86585b177386a52, var_9f3b32e1a46f3c50, level.scarabww_settings.targetingcone.var_3640250d967365f5 ?? 128, level.scarabww_settings.targetingcone.var_358e2569cd831daf ?? 45, level.scarabww_settings.targetingcone.var_ebf360a417d19929 ?? 20, ( 1, 1, 0 ) );
        function_28cb92c2743cc44e( var_f86585b177386a52, var_9f3b32e1a46f3c50, level.scarabww_settings.targetingcone.var_ba298ddb11650ccc ?? 1500, level.scarabww_settings.targetingcone.var_b150c4e2e3a3b3b6 ?? 15, level.scarabww_settings.targetingcone.var_822305aaa3d71a8 ?? 8, ( 1, 0, 0 ) );
    }

    // Namespace weap_scarabww
    // Params 6, eflags: 0x4
    // Checksum 0xf8dd4cc3, Offset: 0x4dc8
    // Size: 0x182, Type: dev
    function private function_28cb92c2743cc44e( origin, angles, length, h_fov, v_fov, color )
    {
        h_fov = min( h_fov, 89 );
        v_fov = min( v_fov, 89 );
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        up = anglestoup( angles );
        var_7f34180df115288 = length * tan( h_fov );
        half_height = length * tan( v_fov );
        far_center = origin + forward * length;
        top_left = far_center + up * half_height - right * var_7f34180df115288;
        top_right = far_center + up * half_height + right * var_7f34180df115288;
        bottom_left = far_center - up * half_height - right * var_7f34180df115288;
        bottom_right = far_center - up * half_height + right * var_7f34180df115288;
        line( origin, top_left, color, 1, 0, 1 );
        line( origin, top_right, color, 1, 0, 1 );
        line( origin, bottom_left, color, 1, 0, 1 );
        line( origin, bottom_right, color, 1, 0, 1 );
        line( top_left, top_right, color, 1, 0, 1 );
        line( top_right, bottom_right, color, 1, 0, 1 );
        line( bottom_right, bottom_left, color, 1, 0, 1 );
        line( bottom_left, top_left, color, 1, 0, 1 );
    }

#/
