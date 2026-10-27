// script_283e7ac3c3edfdf5  (hash_283e7ac3c3edfdf5.gscc) (size: 9126 Bytes / 0x23a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43fc3f7b (1140604795)
// size ...... 9126 (0x23a6)
// includes .. 8   (offset: 0x21aa)
// strings ... 18  (offset: 0x21ea)
// dev strs .. 11  (offset: 0x231e)
// exports ... 26  (offset: 0x12a6)
// cseg ...... 0x15c + 0x114a (0x12a6)
// imports ... 94  (offset: 0x16b6)
// animtree1 . 0   (offset: 0x23a6)
// animtree2 . 0   (offset: 0x23a6)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\hud_util;

#namespace namespace_50d6ca75042166d9;

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x5
// Checksum 0x6b5ee348, Offset: 0x17a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"sat_me_elnath", undefined, &init, undefined );
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0x9dc8fbf2, Offset: 0x19b
// Size: 0x7e
function private init()
{
    weapon_name = utility::get_scripted_weapon_name( #"sat_me_elnath" );
    
    if ( weapon_name )
    {
        level.var_f2258914ab4cd9f3 = weapon_name;
        level.var_9b2de76a3b9c7579 = utility::get_scripted_weapon_name( #"parry_weapon" );
        level callback::add( #"player_weapon_change", &on_weapon_change );
        level callback::add( #"player_connect", &on_player_connect );
        level zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    }
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0x21c6ae58, Offset: 0x221
// Size: 0x21
function private on_player_connect( params )
{
    callback::add( #"hash_652eb614ba902b3d", &function_6108cf3368c55e03 );
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0xec8346c9, Offset: 0x24a
// Size: 0x16c
function private on_weapon_change( params )
{
    if ( !isweapon( params.weapon ) )
    {
        return;
    }
    
    if ( params.weapon.basename == level.var_f2258914ab4cd9f3 )
    {
        if ( !isdefined( level.elnath_settings ) )
        {
            level.elnath_settings = params.weapon.weaponcustomsettings ?? {};
        }
        
        if ( !isdefined( level.var_a2ecc40511fa8c49 ) )
        {
            level.var_a2ecc40511fa8c49 = utility::function_4b74c15943231980( level.elnath_settings.var_215803162698b991 ?? 0.1 );
        }
        
        if ( !isdefined( level.var_2f56899f694e574 ) )
        {
            level.var_2f56899f694e574 = utility::function_4b74c15943231980( level.elnath_settings.var_52ff1fba29dcd120 ?? 1 );
        }
        
        if ( !isdefined( level.var_cf3d1c6c4482a702 ) )
        {
            level.var_cf3d1c6c4482a702 = utility::function_4b74c15943231980( level.elnath_settings.var_888419ce1cc16a80 ?? 2 );
        }
        
        if ( !isdefined( level.var_daf8c5485843fda3 ) )
        {
            level.var_daf8c5485843fda3 = utility::function_4b74c15943231980( level.elnath_settings.var_1c4c7ef28c240c95 ?? 2.1 );
        }
        
        thread monitor_state();
        show_tutorial_message();
        return;
    }
    
    function_5f45b84c79874eb7();
    self notify( #"hash_4013abc9515e4ac9" );
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0xc
// Checksum 0x7fc36e74, Offset: 0x3be
// Size: 0x85
function private monitor_state()
{
    self notify( #"hash_d9b582a07f1de1b5" );
    self endon( #"hash_d9b582a07f1de1b5" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_4013abc9515e4ac9" );
    prev_pressed = 0;
    
    while ( true )
    {
        curr_pressed = is_parry_input();
        
        if ( curr_pressed && !prev_pressed && is_parry_ready() )
        {
            function_f84be52b5f1ca8b9();
        }
        
        prev_pressed = curr_pressed;
        waitframe();
    }
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0xb533ce4b, Offset: 0x44b
// Size: 0x36
function private function_f84be52b5f1ca8b9()
{
    self.var_1d85a8951bda9091 = gettime();
    thread function_fb981a8fc3dd9015();
    
    /#
        thread function_ad9a4e0cdb53b308();
    #/
    
    self giveandfireoffhand( level.var_9b2de76a3b9c7579 );
    thread function_4036c8fc566f1763();
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0x4f10bb26, Offset: 0x489
// Size: 0x2a
function private function_4036c8fc566f1763()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"hash_4013abc9515e4ac9" );
    self takeweapon( level.var_9b2de76a3b9c7579 );
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0xc7d35b0, Offset: 0x4bb
// Size: 0x3b, Type: bool
function private is_parry_input()
{
    return self meleebuttonpressed( 1 ) && !self attackbuttonpressed() && !self ismeleeing() && !self isshooting() && !self function_b0cda4f57c717f39() && !self adsbuttonpressed();
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0xc69d9668, Offset: 0x4ff
// Size: 0x53, Type: bool
function private is_parry_ready()
{
    if ( !self.var_1d85a8951bda9091 )
    {
        return true;
    }
    
    var_496827d850ac8716 = self.var_1d85a8951bda9091 + level.var_daf8c5485843fda3 + level.var_cf3d1c6c4482a702;
    
    if ( gettime() > var_496827d850ac8716 )
    {
        self.var_1d85a8951bda9091 = undefined;
        return true;
    }
    
    return false;
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0x97e7c91e, Offset: 0x55b
// Size: 0x68
function private function_fb981a8fc3dd9015()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_57fd3aa281b33927 = 0;
    wait utility::function_6f5d2e1f1ff70482( level.var_a2ecc40511fa8c49 );
    self.var_57fd3aa281b33927 = 1;
    wait utility::function_6f5d2e1f1ff70482( max( 0, level.var_2f56899f694e574 - level.var_a2ecc40511fa8c49 ) );
    self.var_57fd3aa281b33927 = 0;
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0x9b6f6cac, Offset: 0x5cb
// Size: 0x244
function private function_6108cf3368c55e03( params )
{
    var_40784a32498ead56 = self getcurrentweapon();
    
    if ( !isweapon( var_40784a32498ead56 ) || var_40784a32498ead56.basename != level.var_f2258914ab4cd9f3 )
    {
        return;
    }
    
    if ( !self.var_57fd3aa281b33927 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    attacker = params.eattacker;
    inflictor = params.einflictor;
    means_of_death = params.smeansofdeath;
    
    if ( means_of_death != "MOD_MELEE" && means_of_death != "MOD_GRENADE" )
    {
        return;
    }
    
    if ( means_of_death == "MOD_GRENADE" )
    {
        if ( !function_1c7759bf2375d159( inflictor ) )
        {
            return;
        }
        
        var_7e5f51205e32cad6 = getmissileowner( inflictor );
        var_c51215b779b5fe59 = self.origin - var_7e5f51205e32cad6.origin;
        vdir = vectornormalize( ( var_c51215b779b5fe59[ 0 ], var_c51215b779b5fe59[ 1 ], 0 ) );
    }
    else
    {
        vdir = params.vdamagedir;
    }
    
    if ( !function_26a3218c7299175b( vdir, anglestoforward( self getplayerangles() ) ) )
    {
        return;
    }
    
    if ( means_of_death == "MOD_MELEE" && isagent( attacker ) )
    {
        category = attacker.aicategory;
        
        if ( category == "normal" )
        {
            stun_duration = level.elnath_settings.var_ffa9a8acbc7ec773 ?? 2;
            params.idamage = 0;
        }
        else if ( category == "special" )
        {
            stun_duration = level.elnath_settings.var_bae1bd6821870a3b ?? 1;
            params.idamage = 0;
        }
        
        if ( stun_duration && utility::issharedfuncdefined( #"zombie", #"stunZombie" ) )
        {
            attacker [[ utility::getsharedfunc( #"zombie", #"stunZombie" ) ]]( stun_duration );
            
            /#
                iprintlnbold( "<dev string:x4a>" );
            #/
        }
        
        return;
    }
    
    if ( means_of_death == "MOD_GRENADE" )
    {
        params.idamage = 0;
        function_4901dcfd7e261150();
    }
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0x70961ae6, Offset: 0x817
// Size: 0x75
function private function_4901dcfd7e261150()
{
    self notify( #"hash_293589204b658a5" );
    self.var_9606da20c1b52a78 = 1;
    thread function_ea7e18a9ca0565ad();
    thread function_8f5570e6121b7e6();
    thread ww_shared::function_3472b693f638483a( level.var_f2258914ab4cd9f3, "me_elnath_charge", "on", "off" );
    
    /#
        iprintlnbold( "<dev string:x7d>" + ( level.elnath_settings.var_be5faa66532e3d00 ?? 5 ) + "<dev string:xad>" );
    #/
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0x1f4adb42, Offset: 0x894
// Size: 0x66
function private function_ea7e18a9ca0565ad()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_293589204b658a5" );
    wait level.elnath_settings.var_be5faa66532e3d00 ?? 5;
    self.var_9606da20c1b52a78 = 0;
    ww_shared::function_50a43e11790d1a15( level.var_f2258914ab4cd9f3, "me_elnath_charge", "off" );
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0xb5f261aa, Offset: 0x902
// Size: 0x26
function private function_8f5570e6121b7e6()
{
    self endon( #"hash_293589204b658a5" );
    self waittill( #"death_or_disconnect" );
    
    if ( self )
    {
        function_5f45b84c79874eb7();
    }
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0xf647e2b3, Offset: 0x930
// Size: 0x32
function private function_5f45b84c79874eb7()
{
    self notify( #"hash_293589204b658a5" );
    self.var_9606da20c1b52a78 = 0;
    ww_shared::function_50a43e11790d1a15( level.var_f2258914ab4cd9f3, "me_elnath_charge", "off" );
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0x45a33240, Offset: 0x96a
// Size: 0x160
function private function_17fdfda41f9aa95a( dmg_struct )
{
    player = dmg_struct.eattacker;
    idamage = dmg_struct.idamage;
    
    if ( isplayer( player ) && player.var_9606da20c1b52a78 && dmg_struct.sweapon.basename == level.var_f2258914ab4cd9f3 )
    {
        idamage = int( idamage * ( level.elnath_settings.lightningdamagemultiplier ?? 2 ) );
        
        if ( !callback::exists( "on_zombie_ai_damaged", &function_5bfb63db39ad502b ) )
        {
            callback::add( "on_zombie_ai_damaged", &function_5bfb63db39ad502b );
        }
        
        player function_5f45b84c79874eb7();
        
        /#
            iprintlnbold( "<dev string:xb0>" );
        #/
    }
    
    dmg_struct.idamage = idamage;
    is_multi_hit_damage = dmg_struct.idflags & 1;
    
    if ( !is_multi_hit_damage && dmg_struct.idflags & 131072 && dmg_struct.sweapon.basename == level.var_f2258914ab4cd9f3 && isplayer( player ) && isalive( player ) )
    {
        player thread function_fda2461f2b56bf5a( dmg_struct, self );
    }
    
    function_8998cfa9b1d75620( dmg_struct );
    return idamage;
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0x5adf83af, Offset: 0xad3
// Size: 0x53
function private function_5bfb63db39ad502b( params )
{
    if ( params.idamage >= self.health )
    {
        self.var_34575f1071c85810 = 1;
    }
    
    if ( callback::exists( "on_zombie_ai_damaged", &function_5bfb63db39ad502b ) )
    {
        callback::remove( "on_zombie_ai_damaged", &function_5bfb63db39ad502b );
    }
}

// Namespace namespace_50d6ca75042166d9
// Params 2, eflags: 0x4
// Checksum 0xc449cdd7, Offset: 0xb2e
// Size: 0x2f7
function private function_fda2461f2b56bf5a( dmg_struct, ignore_ai )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    hit_start_dist = level.elnath_settings.var_94a5d07c939e544 ?? 64;
    hit_end_dist = level.elnath_settings.var_1f9d7ef520317041 ?? 80;
    trace_radius = level.elnath_settings.var_a3409b738164bdd6 ?? 48;
    var_6733a7b7ad2c1d9d = level.elnath_settings.var_84c0eec636cab688 ?? 1;
    trace_position_start = anglestoforward( self getplayerangles() ) * hit_start_dist + self geteye();
    trace_position_end = anglestoforward( self getplayerangles() ) * hit_end_dist + self geteye();
    ignore_ents = [ self ];
    
    if ( isent( ignore_ai ) )
    {
        ignore_ents[ ignore_ents.size ] = ignore_ai;
    }
    
    trace = trace::sphere_trace_get_all_results( trace_position_start, trace_position_end, trace_radius, ignore_ents, undefined, undefined, 1 );
    zombies = [];
    
    foreach ( trace_result in trace )
    {
        entity = trace_result[ "entity" ];
        
        if ( isai( entity ) && isalive( entity ) && entity.team != self.team && !isdefined( entity.var_bd22ba6c600a23a3 ) && isdefined( entity.aicategory ) )
        {
            if ( entity val::get( "damage" ) )
            {
                zombies[ zombies.size ] = entity;
            }
        }
    }
    
    wait 0.1;
    hit_count = 0;
    
    while ( true )
    {
        if ( zombies.size < 1 || hit_count >= var_6733a7b7ad2c1d9d )
        {
            break;
        }
        
        zombie = utility::function_4113d68e8e0a401f( zombies );
        
        if ( zombie && !zombie isragdoll() )
        {
            zombie.var_34575f1071c85810 = 1;
            hit_count++;
            dmg_point = zombie tagexists( "j_spine4" ) ? zombie gettagorigin( "j_spine4" ) : zombie getcentroid();
            zombie dodamage( dmg_struct.idamage, dmg_point, self, self, "MOD_MELEE", dmg_struct.sweapon, undefined, undefined, 65537 );
            zombies = arrayremove( zombies, zombie );
            
            if ( isalive( zombie ) )
            {
                zombie.var_34575f1071c85810 = 0;
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0xb4964dc5, Offset: 0xe2d
// Size: 0x13c
function private function_8998cfa9b1d75620( dmg_struct )
{
    if ( dmg_struct.idamage <= 0 || !isplayer( dmg_struct.eattacker ) || !isweapon( dmg_struct.sweapon ) || dmg_struct.sweapon.basename != level.var_f2258914ab4cd9f3 )
    {
        return;
    }
    
    var_d8c7a0fac844e6b = undefined;
    
    if ( isvector( dmg_struct.vpoint ) && isvector( dmg_struct.vdir ) )
    {
        var_d8c7a0fac844e6b = spawnscriptable( "scriptable_me_elnath_impact", dmg_struct.vpoint, vectortoangles( dmg_struct.vdir * -1 ) );
    }
    else if ( self tagexists( "j_spine4" ) )
    {
        var_d8c7a0fac844e6b = spawnscriptable( "scriptable_me_elnath_impact", self gettagorigin( "j_spine4" ), self gettagangles( "j_spine4" ) );
    }
    else
    {
        var_d8c7a0fac844e6b = spawnscriptable( "scriptable_me_elnath_impact", self getcentroid(), ( 0, 0, 0 ) );
    }
    
    if ( !var_d8c7a0fac844e6b )
    {
        return;
    }
    
    var_d8c7a0fac844e6b utility::function_7c10ea82c1e305b8( "impact", get_impact_fx_state_name( dmg_struct ) );
    var_d8c7a0fac844e6b utility::delaycall( 2, &freescriptable );
}

// Namespace namespace_50d6ca75042166d9
// Params 0, eflags: 0x4
// Checksum 0x9823ebf1, Offset: 0xf71
// Size: 0x42
function private show_tutorial_message()
{
    key = level.var_f2258914ab4cd9f3 + "_tutorial_message_has_displayed";
    
    if ( utility::ent_flag( key ) )
    {
        return;
    }
    
    utility::ent_flag_set( key );
    thread ww_shared::show_hud_tutorial_message( &"hash_5849bf47ad168ca4" );
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0x878a0d54, Offset: 0xfbb
// Size: 0xf0
function private get_impact_fx_state_name( dmg_struct )
{
    player = dmg_struct.eattacker;
    
    if ( !isplayer( player ) )
    {
        return "impact_le";
    }
    
    variant = clampint( player function_29ce8f3d1f41fe0f(), 0, 2 );
    
    if ( dmg_struct.idflags & 131072 )
    {
        switch ( variant )
        {
            case 0:
                return "impact_le";
            case 1:
                return ( randomint( 2 ) == 0 ? "impact_le" : "impact_ri" );
            case 2:
                return "impact_ri";
        }
    }
    
    switch ( variant )
    {
        case 0:
        case 1:
            return "impact_le";
        case 2:
            return "impact_ri";
    }
    
    return "impact_le";
}

// Namespace namespace_50d6ca75042166d9
// Params 2, eflags: 0x4
// Checksum 0x3f72663f, Offset: 0x10b4
// Size: 0x59, Type: bool
function private function_26a3218c7299175b( incoming_damage_direction, viewpos_direction )
{
    if ( !isvector( incoming_damage_direction ) || !isvector( viewpos_direction ) )
    {
        return false;
    }
    
    cos_value = vectordot( vectornormalize( incoming_damage_direction ), vectornormalize( viewpos_direction ) );
    return cos_value >= -1 && cos_value <= -0.6428;
}

// Namespace namespace_50d6ca75042166d9
// Params 1, eflags: 0x4
// Checksum 0x796e4bb6, Offset: 0x1116
// Size: 0x56, Type: bool
function private function_1c7759bf2375d159( inflictor )
{
    if ( !isvalidmissile( inflictor ) )
    {
        return false;
    }
    
    oni = getmissileowner( inflictor );
    return oni && isagent( oni ) && issubstr( oni.subclass ?? "", "zombie_orion" );
}

/#

    // Namespace namespace_50d6ca75042166d9
    // Params 0, eflags: 0x4
    // Checksum 0x1f3fdb26, Offset: 0x1175
    // Size: 0xf6, Type: dev
    function private function_ad9a4e0cdb53b308()
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self endon( #"hash_4013abc9515e4ac9" );
        elem = hud_util::createfontstring( "<dev string:xd6>", 1.3 );
        elem hud_util::setpoint( "<dev string:xde>", "<dev string:xde>", 77, -77 );
        elem.archived = 0;
        elem.sort = 10;
        elem.showinkillcam = 0;
        thread function_fe665ae80ee86bf2( elem );
        end_time = gettime() + level.var_daf8c5485843fda3;
        
        while ( gettime() < end_time )
        {
            label = self.var_57fd3aa281b33927 ? "<dev string:xe5>" : "<dev string:xf3>";
            elem setdevtext( label );
            wait 0.2;
        }
        
        self notify( #"hash_2ce52a597b4547eb" );
        elem destroy();
    }

    // Namespace namespace_50d6ca75042166d9
    // Params 1, eflags: 0x4
    // Checksum 0xbca53a23, Offset: 0x1273
    // Size: 0x33, Type: dev
    function private function_fe665ae80ee86bf2( elem )
    {
        self endon( #"hash_2ce52a597b4547eb" );
        utility::waittill_any( "<dev string:x103>", "<dev string:x117>" );
        elem destroy();
    }

#/
