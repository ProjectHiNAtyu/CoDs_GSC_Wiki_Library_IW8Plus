// scripts\mp\ob\activities\locked_in\ob_activity_locked_in_firewall.gsc  (hash_271fba8ee976dfce.gscc) (size: 4817 Bytes / 0x12d1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcea06f91 (3466620817)
// size ...... 4817 (0x12d1)
// includes .. 5   (offset: 0x121d)
// strings ... 8   (offset: 0x1245)
// dev strs .. 3   (offset: 0x12a5)
// exports ... 19  (offset: 0xac9)
// cseg ...... 0xfe + 0x9cb (0xac9)
// imports ... 37  (offset: 0xdc1)
// animtree1 . 0   (offset: 0x12d1)
// animtree2 . 0   (offset: 0x12d1)
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\damage;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\systems\ob_flying_drone;

#namespace ob_activity_locked_in_firewall;

// Namespace ob_activity_locked_in_firewall
// Params 0
// Checksum 0xc8a18045, Offset: 0x11c
// Size: 0xa
function firewall_setup()
{
    level ob_flying_drone::setup_helper_drones();
}

// Namespace ob_activity_locked_in_firewall
// Params 2
// Checksum 0x9c037ae6, Offset: 0x12e
// Size: 0x127
function function_37c842ffd11cc4a0( var_e39f05514bc5a668, activity_instance )
{
    e_firewall = spawn( "script_model", var_e39f05514bc5a668.origin );
    e_firewall.angles = var_e39f05514bc5a668.angles;
    e_firewall setmodel( "wc::t10_electronics_satellite_uplink_station_router_big_01_ob_scriptable" );
    e_firewall setcandamage( 0 );
    e_firewall.var_802e5cc2ac5910f1 = 1;
    e_firewall.maxhealth = var_e39f05514bc5a668.health;
    e_firewall.var_ff41aba15eadee14 = var_e39f05514bc5a668.var_ff41aba15eadee14;
    e_firewall setscriptablepartstate( #"body", #"idle" );
    e_firewall.linked_activity_instance = activity_instance;
    
    /#
        e_firewall thread debug_draw_firewall();
    #/
    
    if ( !isdefined( level.ob.cysts ) )
    {
        level.ob.cysts = [];
    }
    
    level.ob.cysts[ level.ob.cysts.size ] = e_firewall;
    return e_firewall;
}

// Namespace ob_activity_locked_in_firewall
// Params 0
// Checksum 0xb17f57ef, Offset: 0x25e
// Size: 0xb9
function function_6670c8de4d0bed14()
{
    if ( !is_firewall_entity() )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( self.helper_drone_owner )
    {
        self.helper_drone_owner ob_flying_drone::function_a08f109bc062fffe();
        self.helper_drone_owner = undefined;
    }
    
    if ( level.ob.cysts && arraycontains( level.ob.cysts, self ) )
    {
        level.ob.cysts = arrayremove( level.ob.cysts, self );
    }
    
    clean_registers();
    damage::monitordamageend();
    calloutmarkerping::function_608710c894185549();
    self delete();
}

// Namespace ob_activity_locked_in_firewall
// Params 2
// Checksum 0x614e8972, Offset: 0x31f
// Size: 0x52
function function_3369c062236b8a16( callback, activity_instance )
{
    if ( !isdefined( activity_instance.var_70768078873213e8 ) )
    {
        activity_instance.var_70768078873213e8 = [];
    }
    
    activity_instance.var_70768078873213e8 = arraycombineunique( activity_instance.var_70768078873213e8, [ callback ] );
}

// Namespace ob_activity_locked_in_firewall
// Params 2
// Checksum 0xeb70da35, Offset: 0x379
// Size: 0x42
function function_dae173aeb1a50001( callback, activity_instance )
{
    if ( !activity_instance.var_70768078873213e8 )
    {
        return;
    }
    
    activity_instance.var_70768078873213e8 = arrayremove( activity_instance.var_70768078873213e8, callback );
}

// Namespace ob_activity_locked_in_firewall
// Params 0
// Checksum 0xe72acfd, Offset: 0x3c3
// Size: 0xcf
function activate_firewall()
{
    if ( !is_firewall_entity() )
    {
        assertmsg( "<dev string:x4e>" );
        return;
    }
    
    if ( !self.var_5acc8d3f9541a9e4 )
    {
        utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "locked_in_firewall" );
        self.var_5acc8d3f9541a9e4 = 1;
    }
    
    if ( !self.var_157e39728edf76ee )
    {
        level utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", self );
        self.var_157e39728edf76ee = 1;
    }
    
    self.is_active = 1;
    self.var_66a78d4707b60b51 = undefined;
    thread damage::monitordamage( self.maxhealth, "hitequip", &on_firewall_destroyed, &damage_modify );
    self setscriptablepartstate( #"body", #"active" );
}

// Namespace ob_activity_locked_in_firewall
// Params 0
// Checksum 0x82f0d881, Offset: 0x49a
// Size: 0x24
function is_firewall_activated()
{
    if ( !is_firewall_entity() )
    {
        assertmsg( "<dev string:x7a>" );
        return 0;
    }
    
    return self.is_active;
}

// Namespace ob_activity_locked_in_firewall
// Params 0
// Checksum 0xa0dcf295, Offset: 0x4c7
// Size: 0x39
function function_a08f109bc062fffe()
{
    if ( !is_firewall_entity() )
    {
        assertmsg( "<dev string:x7a>" );
        return 0;
    }
    
    if ( !self.helper_drone_owner )
    {
        return;
    }
    
    self.helper_drone_owner ob_flying_drone::function_a08f109bc062fffe();
}

// Namespace ob_activity_locked_in_firewall
// Params 0
// Checksum 0xc18612d0, Offset: 0x508
// Size: 0xb
function function_8babea4f625910ad()
{
    function_ce6374e74b5e267f( 1 );
}

// Namespace ob_activity_locked_in_firewall
// Params 1
// Checksum 0x1f4a9471, Offset: 0x51b
// Size: 0x5b
function show_outline( b_show )
{
    if ( !is_firewall_entity() )
    {
        assertmsg( "<dev string:x7a>" );
        return;
    }
    
    state = b_show ? #"show" : #"hide";
    self setscriptablepartstate( #"outline", state );
}

// Namespace ob_activity_locked_in_firewall
// Params 0, eflags: 0x4
// Checksum 0x53bfb40c, Offset: 0x57e
// Size: 0xb
function private is_firewall_entity()
{
    return self.var_802e5cc2ac5910f1;
}

// Namespace ob_activity_locked_in_firewall
// Params 1, eflags: 0x4
// Checksum 0x28cd88cc, Offset: 0x592
// Size: 0x14
function private on_firewall_destroyed( damage_data )
{
    function_ce6374e74b5e267f( 0 );
}

// Namespace ob_activity_locked_in_firewall
// Params 1, eflags: 0x4
// Checksum 0x112cfe84, Offset: 0x5ae
// Size: 0x154
function private function_ce6374e74b5e267f( var_46159e2772b2df4 )
{
    self.is_active = undefined;
    self.var_66a78d4707b60b51 = undefined;
    clean_registers();
    show_outline( 0 );
    
    if ( level.ob.cysts && arraycontains( level.ob.cysts, self ) )
    {
        level.ob.cysts = arrayremove( level.ob.cysts, self );
    }
    
    damage::monitordamageend();
    self setscriptablepartstate( #"body", #"destroyed" );
    calloutmarkerping::function_608710c894185549();
    
    if ( self.linked_activity_instance.var_70768078873213e8 )
    {
        foreach ( callback in self.linked_activity_instance.var_70768078873213e8 )
        {
            self [[ callback ]]( self.linked_activity_instance, var_46159e2772b2df4 );
        }
    }
}

// Namespace ob_activity_locked_in_firewall
// Params 0, eflags: 0x4
// Checksum 0xf03cd47f, Offset: 0x70a
// Size: 0x62
function private clean_registers()
{
    if ( self.var_5acc8d3f9541a9e4 )
    {
        utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
        self.var_5acc8d3f9541a9e4 = undefined;
    }
    
    if ( self.var_157e39728edf76ee )
    {
        level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", self );
        self.var_157e39728edf76ee = undefined;
    }
}

// Namespace ob_activity_locked_in_firewall
// Params 1, eflags: 0x4
// Checksum 0xea4d76b1, Offset: 0x774
// Size: 0xcd
function private damage_modify( s_damage_data )
{
    damage = damage::modifydamage( s_damage_data );
    is_black_hat_damage = s_damage_data.objweapon.var_25b0062cbe4d9c99 == #"black_hat_sat_mp";
    
    if ( is_black_hat_damage )
    {
        return damage;
    }
    
    if ( damage > 0 && mp_agent_damage::function_dc9f82a74577dbd9() )
    {
        mp_agent_damage::function_eb8ba16055d6da7c( s_damage_data.attacker, self, "none", s_damage_data.var_99c3515eb9f97ce0, s_damage_data.objweapon, damage, s_damage_data.point, 0, undefined, 0, 0 );
    }
    
    if ( !self.var_66a78d4707b60b51 )
    {
        spawn_helper_drone( s_damage_data.attacker );
        self.var_66a78d4707b60b51 = 1;
    }
    
    return damage;
}

// Namespace ob_activity_locked_in_firewall
// Params 1, eflags: 0x4
// Checksum 0xcbace8d9, Offset: 0x84a
// Size: 0xe5
function private spawn_helper_drone( attacker )
{
    drone_types = [ "shock", "turret", "explosive" ];
    count = function_1af7ff603fe4c1fe();
    
    for ( i = 0; i < count ; i++ )
    {
        var_cdffe119ed60d14d = utility::array_random( drone_types );
        spawn_target = self;
        spawn_points = self.var_ff41aba15eadee14;
        
        if ( spawn_points.size )
        {
            spawn_target = spawn_points[ i % spawn_points.size ];
        }
        
        path_array = [ spawn_target.origin ];
        
        if ( !isdefined( self.helper_drone_owner ) )
        {
            self.helper_drone_owner = spawnstruct();
        }
        
        self.helper_drone_owner thread ob_flying_drone::spawn_helper_drone( var_cdffe119ed60d14d, spawn_target, path_array, undefined, undefined, 0 );
    }
}

// Namespace ob_activity_locked_in_firewall
// Params 0, eflags: 0x4
// Checksum 0xcaeea589, Offset: 0x937
// Size: 0x4
function private function_1af7ff603fe4c1fe()
{
    return 2;
}

/#

    // Namespace ob_activity_locked_in_firewall
    // Params 0, eflags: 0xc
    // Checksum 0x4f7484ef, Offset: 0x944
    // Size: 0x185, Type: dev
    function private debug_draw_firewall()
    {
        self notify( #"hash_d02f2a6ef758d864" );
        self endon( #"hash_d02f2a6ef758d864" );
        
        if ( !getdvarint( @"hash_c2105dfb5c840eff", 0 ) )
        {
            return;
        }
        
        self endon( #"death" );
        
        if ( self.linked_activity_instance )
        {
            self.linked_activity_instance endon( #"all_firewalls_destroyed" );
        }
        
        while ( !level.players[ 0 ] )
        {
            wait 1;
        }
        
        me = level.players[ 0 ];
        me endon( #"death_or_disconnect" );
        
        while ( true )
        {
            waitframe();
            remain_health = isdefined( self.damagetaken ) ? self.maxhealth - self.damagetaken : 0;
            var_6406b411db6be5c4 = remain_health > 0;
            color = self.is_active ? var_6406b411db6be5c4 ? ( 0, 1, 0 ) : ( 1, 0, 0 ) : ( 0.75, 0.75, 0.75 );
            line( me.origin, self.origin, color );
            sphere( self.origin, 10, color );
            
            if ( self.is_active )
            {
                print3d( self.origin + ( 0, 0, 20 ), remain_health, color, 1, 0.5, 1, 1 );
            }
        }
    }

#/
