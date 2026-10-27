// scripts\common\status_effects\effect_burn.gsc  (hash_73926eaf280b0b75.gscc) (size: 5900 Bytes / 0x170c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbffeaab (4227852971)
// size ...... 5900 (0x170c)
// includes .. 6   (offset: 0x14cc)
// strings ... 31  (offset: 0x14fc)
// dev strs .. 0   (offset: 0x170c)
// exports ... 10  (offset: 0xeec)
// cseg ...... 0x1ff + 0xced (0xeec)
// imports ... 36  (offset: 0x107c)
// animtree1 . 0   (offset: 0x170c)
// animtree2 . 0   (offset: 0x170c)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\throttle;
#using scripts\common\utility;

#namespace effect_burn;

// Namespace effect_burn
// Params 15
// Checksum 0x5ff15948, Offset: 0x21d
// Size: 0x42d
function burn( durations, damage, var_cf730378ec6521c2, attacker, unique_id, var_7c6031633ffb5dfe, inflictor, var_749345f344f55b77, var_c48a6eb5dc332b68 = 0, weaponobj, var_524b2ed803d31b06 = 0, var_cfbaff0d3c40cb59 = 1, var_c81e17a67ccff5e5 = 0, var_44cbc86307493398 = 1, var_4dcec8d502e17e00 = 0 )
{
    if ( !isplayer( self ) && isai( self ) && !self.aisettings.var_652102b804cce911 )
    {
        return 0;
    }
    
    if ( status_effects::has_status_effect_type( "burn" ) && var_c48a6eb5dc332b68 )
    {
        if ( isdefined( unique_id ) )
        {
            foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "burn" ] )
            {
                if ( var_c6321cb8cd32b6a0.unique_id == unique_id )
                {
                    if ( var_c81e17a67ccff5e5 )
                    {
                        status_effects::function_a541569a5cf7126b( "burn", unique_id, durations );
                    }
                    
                    return;
                }
            }
        }
    }
    
    if ( unique_id && var_c81e17a67ccff5e5 && status_effects::function_fa35fc2723e956eb( "burn", unique_id ) )
    {
        status_effects::function_a541569a5cf7126b( "burn", unique_id, durations );
        return;
    }
    
    var_8a1c02309faa4a0b = 0;
    
    if ( status_effects::has_status_effect_type( "burn" ) )
    {
        var_8a1c02309faa4a0b = 1;
    }
    
    var_465e7c1867fba54d = status_effects::function_93edde8d0fe48bb6( "burn", durations, unique_id, &function_4944e88aa5aab05a, &function_be4261333fc6b61d, var_749345f344f55b77 );
    var_465e7c1867fba54d.var_7c6031633ffb5dfe = var_7c6031633ffb5dfe;
    var_465e7c1867fba54d.damage = damage;
    var_465e7c1867fba54d.var_cf730378ec6521c2 = var_cf730378ec6521c2;
    var_465e7c1867fba54d.attacker = attacker;
    var_465e7c1867fba54d.inflictor = inflictor;
    var_465e7c1867fba54d.next_damage_time = gettime();
    var_465e7c1867fba54d.var_8a1c02309faa4a0b = var_8a1c02309faa4a0b;
    var_465e7c1867fba54d.weaponobj = weaponobj;
    var_465e7c1867fba54d.var_524b2ed803d31b06 = var_524b2ed803d31b06;
    var_465e7c1867fba54d.var_cfbaff0d3c40cb59 = var_cfbaff0d3c40cb59;
    var_465e7c1867fba54d.var_44cbc86307493398 = var_44cbc86307493398;
    var_465e7c1867fba54d.var_4dcec8d502e17e00 = var_4dcec8d502e17e00;
    
    if ( isdefined( var_465e7c1867fba54d.inflictor ) && isdefined( var_465e7c1867fba54d.inflictor.weapon_name ) && ( issubstr( var_465e7c1867fba54d.inflictor.weapon_name, "dark_aether" ) || var_465e7c1867fba54d.inflictor.weapon_name == "sat_molotov_zm_purple" ) )
    {
        var_465e7c1867fba54d.var_7dddc60e0205506b = "_purple";
    }
    
    if ( isdefined( weaponobj ) && isdefined( weaponobj.basename ) && issubstr( weaponobj.basename, "dark_flare" ) )
    {
        var_465e7c1867fba54d.var_7dddc60e0205506b = "_shadow";
    }
    
    if ( var_749345f344f55b77 == "purple_fire" )
    {
        var_465e7c1867fba54d.var_7dddc60e0205506b = "_purple";
        var_749345f344f55b77 = "fire";
        var_465e7c1867fba54d.var_749345f344f55b77 = "fire";
    }
    
    if ( var_7c6031633ffb5dfe == "_locust_ww" )
    {
        var_465e7c1867fba54d.var_7dddc60e0205506b = "_locust_ww";
    }
    
    if ( var_7c6031633ffb5dfe == "_locust_ww_pap" )
    {
        var_465e7c1867fba54d.var_7dddc60e0205506b = "_locust_ww_pap";
    }
    
    if ( isplayer( attacker ) && var_749345f344f55b77 == "fire" && unique_id != "dragonsbreath" )
    {
        if ( !isdefined( unique_id ) || !status_effects::function_fa35fc2723e956eb( "burn", unique_id ) )
        {
            attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"ignited" );
        }
    }
    
    return status_effects::function_3747671c47b03216( var_465e7c1867fba54d );
}

// Namespace effect_burn
// Params 1, eflags: 0x4
// Checksum 0xc046f286, Offset: 0x653
// Size: 0x163
function private function_4944e88aa5aab05a( s_burn_effect )
{
    if ( s_burn_effect.damage > 0 )
    {
        thread function_ec15f39fbdc983de( s_burn_effect );
    }
    
    if ( s_burn_effect.var_8a1c02309faa4a0b )
    {
        waitframe();
    }
    
    if ( isalive( self ) && isdefined( s_burn_effect ) )
    {
        if ( s_burn_effect.var_7c6031633ffb5dfe == "_nburst" )
        {
            if ( isplayer( s_burn_effect.attacker ) )
            {
                if ( s_burn_effect.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_damage_boost" ) )
                {
                    start_burn_vfx( "napalm_burned", "napalm_burned_thermite", s_burn_effect );
                }
                else
                {
                    start_burn_vfx( "napalm_burned", "napalm_burned", s_burn_effect );
                }
            }
            else
            {
                start_burn_vfx( "napalm_burned", "napalm_burned", s_burn_effect );
            }
            
            return;
        }
        
        if ( s_burn_effect.var_7c6031633ffb5dfe == "_wraith" )
        {
            start_burn_vfx( "wraith_burned", "wraith_burned", s_burn_effect );
            return;
        }
        
        if ( s_burn_effect.var_749345f344f55b77 == "poison" )
        {
            start_burn_vfx( "poisoned", "poisoned", s_burn_effect );
            return;
        }
        
        var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
        start_burn_vfx( "burned" + var_7dddc60e0205506b, "burned", s_burn_effect );
    }
}

// Namespace effect_burn
// Params 1, eflags: 0x4
// Checksum 0xe6dd6845, Offset: 0x7be
// Size: 0xb1
function private function_be4261333fc6b61d( s_burn_effect )
{
    if ( s_burn_effect.var_721a3ba8345b9108 == "burn" )
    {
        if ( s_burn_effect.var_7c6031633ffb5dfe == "_nburst" )
        {
            end_burn_vfx( "napalm_burned", "napalm_burned", s_burn_effect );
            return;
        }
        
        if ( s_burn_effect.var_7c6031633ffb5dfe == "_wraith" )
        {
            end_burn_vfx( "wraith_burned", "wraith_burned", s_burn_effect );
            return;
        }
        
        if ( s_burn_effect.var_749345f344f55b77 == "poison" )
        {
            end_burn_vfx( "poisoned", "poisoned", s_burn_effect );
            return;
        }
        
        end_burn_vfx( "burned", "burned", s_burn_effect );
    }
}

// Namespace effect_burn
// Params 3, eflags: 0x4
// Checksum 0x8525f4d4, Offset: 0x877
// Size: 0x4d
function private start_burn_vfx( flag, message, s_burn_effect )
{
    utility::ent_flag_set( flag );
    callback::callback( message, s_burn_effect );
    
    if ( self.type != "zombie" )
    {
        function_502bd688762aba27( message, s_burn_effect );
    }
}

// Namespace effect_burn
// Params 3, eflags: 0x4
// Checksum 0x50ad9ee0, Offset: 0x8cc
// Size: 0x53
function private end_burn_vfx( flag, message, s_burn_effect )
{
    utility::ent_flag_clear( flag );
    callback::callback( message + "_end", s_burn_effect );
    
    if ( self.type != "zombie" )
    {
        function_209d36940dfdfbe8( message, s_burn_effect );
    }
}

// Namespace effect_burn
// Params 2, eflags: 0x4
// Checksum 0xbfda250, Offset: 0x927
// Size: 0x124
function private function_502bd688762aba27( message, s_burn_effect )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( message, message + "_on" );
    
    if ( isdefined( self._blackboard ) && s_burn_effect.var_44cbc86307493398 )
    {
        self._blackboard.isburning = 1;
        self.var_553ae45c1a5786fb = gettime();
    }
    
    if ( !( isdefined( s_burn_effect.attacker ) && isdefined( s_burn_effect.attacker.origin ) ) )
    {
        self.burningdirection = "right";
        return;
    }
    
    origin = s_burn_effect.attacker.origin;
    right = anglestoright( self.angles );
    tofire = vectornormalize( origin - self.origin );
    
    if ( vectordot( right, tofire ) > 0 )
    {
        self.burningdirection = "right";
        return;
    }
    
    self.burningdirection = "left";
}

// Namespace effect_burn
// Params 2, eflags: 0x4
// Checksum 0xd1276b0e, Offset: 0xa53
// Size: 0x69
function private function_209d36940dfdfbe8( message, s_burn_effect )
{
    victim = self;
    
    if ( !isagent( victim ) )
    {
        return;
    }
    
    level ai::remove_blackboard_isburning( victim );
    
    if ( isdefined( victim ) && isdefined( victim._blackboard ) )
    {
        victim.burningdirection = undefined;
    }
    
    victim utility::function_32b24db3127bff40( message, message + "_off" );
}

// Namespace effect_burn
// Params 1, eflags: 0x4
// Checksum 0x38161b5e, Offset: 0xac4
// Size: 0x3f2
function private function_ec15f39fbdc983de( effect )
{
    self notify( #"hash_c006e975199786ca" );
    self endon( #"hash_c006e975199786ca" );
    self endon( #"death" );
    waitframe();
    
    while ( self.status_effects[ "burn" ].size > 0 )
    {
        damage_amount = 0;
        var_53572c9cefffc09c = 1;
        var_1b3eb30b79d38a4d = undefined;
        inflictor = var_1b3eb30b79d38a4d;
        
        foreach ( var_465e7c1867fba54d in self.status_effects[ "burn" ] )
        {
            now = gettime();
            
            if ( now < var_465e7c1867fba54d.end_time && now >= var_465e7c1867fba54d.next_damage_time && var_465e7c1867fba54d.damage > 0 )
            {
                var_465e7c1867fba54d.var_e45a1340b3decd = 1;
                var_465e7c1867fba54d.next_damage_time += utility::function_4b74c15943231980( var_465e7c1867fba54d.var_cf730378ec6521c2 );
                damage_amount += var_465e7c1867fba54d.damage;
                
                if ( self.health - damage_amount < 1 && isdefined( effect.var_7c6031633ffb5dfe ) && isai( self ) )
                {
                    self.var_e797f68de73ece4e = effect.var_7c6031633ffb5dfe;
                }
                
                if ( isent( var_465e7c1867fba54d.attacker ) )
                {
                    var_1b3eb30b79d38a4d = var_465e7c1867fba54d.attacker;
                }
                
                if ( isdefined( var_465e7c1867fba54d.inflictor ) )
                {
                    inflictor = var_465e7c1867fba54d.inflictor;
                }
                
                self.var_553ae45c1a5786fb = gettime();
            }
        }
        
        if ( self.status_effects[ "burn" ].size > 1 )
        {
            foreach ( var_465e7c1867fba54d in self.status_effects[ "burn" ] )
            {
                if ( !var_465e7c1867fba54d.var_e45a1340b3decd )
                {
                    var_53572c9cefffc09c = 0;
                    break;
                }
            }
        }
        
        if ( var_53572c9cefffc09c )
        {
            idflags = 536870912;
            
            foreach ( var_465e7c1867fba54d in self.status_effects[ "burn" ] )
            {
                var_465e7c1867fba54d.var_e45a1340b3decd = undefined;
                
                if ( var_465e7c1867fba54d.var_cfbaff0d3c40cb59 )
                {
                    idflags |= 65536;
                }
                
                if ( var_465e7c1867fba54d.var_524b2ed803d31b06 && isai( self ) )
                {
                    idflags |= 1073741824;
                }
                
                if ( var_465e7c1867fba54d.var_4dcec8d502e17e00 )
                {
                    idflags |= 137438953472;
                }
            }
            
            element_mod = effect.var_749345f344f55b77 == "poison" ? "MOD_ELEMENTAL_TOXIC" : "MOD_ELEMENTAL_FIRE";
            self.var_183f4d5d5cc70f29 = 1;
            self dodamage( damage_amount, self.origin, var_1b3eb30b79d38a4d, inflictor, element_mod, effect.weaponobj ?? "<explicitweaponnone>", "none", undefined, idflags );
            self.var_183f4d5d5cc70f29 = undefined;
        }
        
        throttle::throttle_wait_in_queue( get_burn_throttle(), self );
    }
}

// Namespace effect_burn
// Params 0, eflags: 0x4
// Checksum 0x4878ad4, Offset: 0xebe
// Size: 0x2d
function private get_burn_throttle()
{
    if ( !isdefined( level.var_2f7d90248d3dffc3 ) )
    {
        level.var_2f7d90248d3dffc3 = throttle::throttle_initialize( "status_effect_burn", 2 );
    }
    
    return level.var_2f7d90248d3dffc3;
}

