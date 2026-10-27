// scripts\mp\common\weapons\weap_manglercannon.gsc  (hash_73416159552abb7f.gscc) (size: 5835 Bytes / 0x16cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b644061 (2607038561)
// size ...... 5835 (0x16cb)
// includes .. 6   (offset: 0x1553)
// strings ... 20  (offset: 0x1583)
// dev strs .. 0   (offset: 0x16cb)
// exports ... 14  (offset: 0xd17)
// cseg ...... 0x1ae + 0xb69 (0xd17)
// imports ... 51  (offset: 0xf47)
// animtree1 . 0   (offset: 0x16cb)
// animtree2 . 0   (offset: 0x16cb)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\weapons\manglercannon_torpedo;

#namespace weap_manglercannon;

// Namespace weap_manglercannon
// Params 0, eflags: 0x5
// Checksum 0xa815289c, Offset: 0x1cc
// Size: 0x17
function private autoexec init()
{
    killstreak_shared::registerkillstreakinitfunction( #"mangler_cannon", &function_d0c6e6de2a8060df );
}

// Namespace weap_manglercannon
// Params 0, eflags: 0x4
// Checksum 0x3ee32941, Offset: 0x1eb
// Size: 0xde
function private function_d0c6e6de2a8060df()
{
    weaponname = utility::get_scripted_weapon_name( #"mangler_cannon" );
    
    if ( isdefined( weaponname ) )
    {
        if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
        {
            [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "mangler_cannon", &function_fc1e9bf63d0c2e66, &function_c55abc62514e7e04 );
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"registerKillstreakStowableWeapon" ) )
        {
            [[ utility::getsharedfunc( #"killstreak", #"registerKillstreakStowableWeapon" ) ]]( "mangler_cannon", weaponname );
        }
        
        if ( !level callback::exists( #"player_weapon_change", &on_weapon_change ) )
        {
            level callback::add( #"player_weapon_change", &on_weapon_change );
        }
        
        level thread register_on_kill_medal( weaponname );
    }
}

// Namespace weap_manglercannon
// Params 1, eflags: 0x4
// Checksum 0xc84b9e8f, Offset: 0x2d1
// Size: 0x5b
function private register_on_kill_medal( weaponname )
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        if ( isdefined( weaponname ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weaponname, &on_killed_medal );
        }
    }
}

// Namespace weap_manglercannon
// Params 1
// Checksum 0x9fdd0422, Offset: 0x334
// Size: 0x3e
function function_c55abc62514e7e04( streakitem )
{
    weapon_name = utility::get_scripted_weapon_name( #"mangler_cannon" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "mangler_cannon", weapon_name, #"low" );
}

// Namespace weap_manglercannon
// Params 1
// Checksum 0x554ad5d3, Offset: 0x37a
// Size: 0x2e
function function_fc1e9bf63d0c2e66( streakitem )
{
    level thread namespace_9d8e359c3b1041e5::trysaylocalsoundsharedfunc( self, #"bc_killstreak_action_mangler_cannon", 0.5 );
    self.streakinfo = streakitem;
}

// Namespace weap_manglercannon
// Params 1
// Checksum 0xf3046164, Offset: 0x3b0
// Size: 0x1a5
function on_weapon_change( params )
{
    if ( !( isdefined( params.weapon ) && isdefined( level.var_363840efc0e8a5a0 ) ) )
    {
        return;
    }
    
    ismanglercannon = is_mangler_cannon( params.weapon );
    
    if ( ismanglercannon )
    {
        self.isinads = 0;
        self notifyonplayercommand( "charge_pressed", "+attack" );
        self notifyonplayercommand( "charge_released", "-attack" );
        thread monitor_manglercannon_charge_pressed();
        thread function_e6651bae2db21a1b( params.weapon );
        thread function_559e750d510a7475();
        
        if ( self getscriptableparthasstate( "ManglerCannonIdleVFX", "idle" ) )
        {
            self setscriptablepartstate( "ManglerCannonIdleVFX", "idle" );
        }
        
        self.hadmanglercannon = 1;
        return;
    }
    
    if ( self.hadmanglercannon )
    {
        self notifyonplayercommandremove( "charge_pressed", "+attack" );
        self notifyonplayercommandremove( "charge_released", "-attack" );
        self notify( #"monitor_manglercannon_fire_end" );
        self notify( #"monitor_player_ads_end" );
        self notify( #"monitor_manglercannon_charge_pressed_end" );
        
        if ( self getscriptableparthasstate( "ManglerCannonIdleVFX", "off" ) )
        {
            self setscriptablepartstate( "ManglerCannonIdleVFX", "off" );
        }
        
        self.hadmanglercannon = 0;
        self setclientomnvar( "ui_m_c_target_num", -1 );
        
        if ( utility::issharedfuncdefined( #"killstreak", #"recordkillstreakendstats" ) )
        {
            streakinfo = self.streakinfo;
            self [[ utility::getsharedfunc( #"killstreak", #"recordkillstreakendstats" ) ]]( streakinfo );
            self.streakinfo = undefined;
        }
    }
}

// Namespace weap_manglercannon
// Params 0, eflags: 0x4
// Checksum 0x96097ff, Offset: 0x55d
// Size: 0xde
function private function_559e750d510a7475()
{
    self endon( #"death_or_disconnect" );
    self notify( #"monitor_player_ads_end" );
    self endon( #"monitor_player_ads_end" );
    
    while ( true )
    {
        if ( self playerads() < 0.4 )
        {
            self.isinads = 0;
            self.torpedo_target = undefined;
            self setclientomnvar( "ui_m_c_target_num", -1 );
        }
        
        if ( self playerads() > 0.9 )
        {
            if ( !self.isinads )
            {
                adsstarttime = gettime();
            }
            
            self.isinads = 1;
            
            if ( gettime() - adsstarttime > 750 )
            {
                possible_target = function_a65b8b5afb6cbe2a();
                
                if ( isdefined( possible_target ) )
                {
                    self.torpedo_target = possible_target;
                    self setclientomnvar( "ui_m_c_target_num", self.torpedo_target getentitynumber() );
                }
                
                wait 1;
            }
        }
        
        waitframe();
    }
}

// Namespace weap_manglercannon
// Params 0, eflags: 0x4
// Checksum 0x72899925, Offset: 0x643
// Size: 0x55
function private monitor_manglercannon_charge_pressed()
{
    self endon( #"death_or_disconnect" );
    self notify( #"monitor_manglercannon_charge_pressed_end" );
    self endon( #"monitor_manglercannon_charge_pressed_end" );
    
    while ( true )
    {
        self waittill( #"charge_pressed" );
        
        if ( self.disallow_weapon_fire || self getcurrentweaponclipammo() == 0 )
        {
            continue;
        }
    }
}

// Namespace weap_manglercannon
// Params 1, eflags: 0x4
// Checksum 0xd367d72a, Offset: 0x6a0
// Size: 0x2fc
function private function_e6651bae2db21a1b( weapon )
{
    self endon( #"death_or_disconnect" );
    self notify( #"monitor_manglercannon_fire_end" );
    self endon( #"monitor_manglercannon_fire_end" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", weaponobj );
        
        if ( self.disallow_weapon_fire || weapon != weaponobj )
        {
            continue;
        }
        
        angles = isplayer( self ) ? self getplayerangles() : self.angles;
        forward = anglestoforward( angles );
        
        if ( isdefined( self.torpedo_target ) )
        {
            target_pos = self.torpedo_target.origin;
        }
        else if ( self getcamerathirdperson() )
        {
            start = self getcamerathirdpersonorigin();
            target_pos = start + 1500 * forward;
            trace = trace::ray_trace( start, target_pos, [ self ], undefined, 1, 1 );
            
            if ( trace[ "fraction" ] < 0.99 && isdefined( trace[ "position" ] ) )
            {
                if ( trace[ "hittype" ] == "hittype_world" && trace[ "surfacetype" ] != "surftype_water" )
                {
                    target_pos = trace[ "position" ];
                }
            }
        }
        else
        {
            target_pos = get_target_pos( 1500 );
        }
        
        if ( isdefined( self.get_cannon_fire_params ) )
        {
            [ torpedo_pos, launch_direction ] = self [[ self.get_cannon_fire_params ]]( target_pos );
        }
        else if ( self tagexists( "tag_accessory_left" ) )
        {
            torpedo_pos = self gettagorigin( "tag_accessory_left" );
            
            if ( self getcamerathirdperson() )
            {
                launch_direction = vectornormalize( target_pos - torpedo_pos );
                
                if ( vectordot( forward, launch_direction ) < 0.7071 )
                {
                    launch_direction = forward;
                }
            }
            else
            {
                launch_direction = forward;
            }
        }
        else
        {
            torpedo_pos = self geteye();
            launch_direction = forward;
        }
        
        target = self.torpedo_target;
        detonationdist = 24;
        velocity = 700;
        moveintervaltime = 0.1;
        maxrange = 1500;
        var_f4b133aee924c98a = 20;
        torpedoradius = 60;
        blastradius = 100;
        var_57282cdbede88a80 = weapon getmindamage( 0 );
        var_8508644c715881bb = weapon getmaxdamage( 0 );
        var_563b2433865c9509 = 200;
        var_5618163386362e87 = 500;
        var_19c5437e89b71a4f = var_8508644c715881bb;
        stun_elites = 1;
        var_deed69668835b4ea = 1;
        detonate_on_target = 1;
        manglercannon_torpedo::mangler_cannon_shoot_torpedo( torpedo_pos, launch_direction, target, target_pos, detonationdist, velocity, moveintervaltime, maxrange, var_f4b133aee924c98a, torpedoradius, blastradius, var_57282cdbede88a80, var_8508644c715881bb, var_563b2433865c9509, var_5618163386362e87, var_19c5437e89b71a4f, stun_elites, var_deed69668835b4ea, detonate_on_target, weapon.basename, "tag_origin_mangler_cannon_torpedo" );
    }
}

// Namespace weap_manglercannon
// Params 0, eflags: 0x4
// Checksum 0x5e9c2aee, Offset: 0x9a4
// Size: 0x164
function private function_a65b8b5afb6cbe2a()
{
    angles = isplayer( self ) ? self getplayerangles() : self.angles;
    forward = anglestoforward( angles );
    start = self getcamerathirdperson() ? self getcamerathirdpersonorigin() : self geteye();
    end = start + 1500 * forward;
    trace_results = trace::ray_trace_get_all_results( start, end, [ self ], undefined, 1 );
    
    foreach ( trace_result in trace_results )
    {
        if ( trace_result[ "hittype" ] == "hittype_entity" )
        {
            entity = trace_result[ "entity" ];
            
            if ( isai( entity ) && isdefined( entity.team ) && entity.team != self.team )
            {
                return entity;
            }
        }
        
        if ( trace_result[ "hittype" ] == "hittype_world" && trace_result[ "surfacetype" ] != "surftype_water" )
        {
            return;
        }
    }
}

// Namespace weap_manglercannon
// Params 1, eflags: 0x4
// Checksum 0x3a3edcc, Offset: 0xb11
// Size: 0x42
function private get_target_pos( maxrange )
{
    start = self geteye();
    dir = anglestoforward( self getplayerangles() );
    end = start + maxrange * dir;
    return end;
}

// Namespace weap_manglercannon
// Params 1
// Checksum 0x72e6ce8b, Offset: 0xb5c
// Size: 0x75
function is_mangler_cannon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    mangler_cannon_name = utility::get_scripted_weapon_name( #"mangler_cannon" );
    mutant_injection_name = utility::get_scripted_weapon_name( #"mutant_injection_cannon" );
    ismanglercannon = weapon.basename == mangler_cannon_name || weapon.basename == mutant_injection_name;
    return ismanglercannon;
}

// Namespace weap_manglercannon
// Params 4, eflags: 0x4
// Checksum 0xc2ffff4, Offset: 0xbda
// Size: 0x13d
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "mangler_cannon", sweapon );
    }
    
    if ( isdefined( einflictor ) )
    {
        if ( !isdefined( einflictor.torpedo_kills ) )
        {
            einflictor.torpedo_kills = 0;
        }
        
        einflictor.torpedo_kills++;
        
        if ( isdefined( self.streakinfo ) )
        {
            if ( !isdefined( self.streakinfo.kills ) )
            {
                self.streakinfo.kills = int( 0 );
            }
            
            self.streakinfo.kills++;
        }
        
        if ( einflictor.torpedo_kills == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_broadside" );
        }
        
        if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
        {
            utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "mangler_cannon", victim );
        }
    }
}

