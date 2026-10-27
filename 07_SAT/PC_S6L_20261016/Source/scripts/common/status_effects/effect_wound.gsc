// scripts\common\status_effects\effect_wound.gsc  (hash_4c4d7a92c4b28b75.gscc) (size: 4157 Bytes / 0x103d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f476be9 (793209833)
// size ...... 4157 (0x103d)
// includes .. 5   (offset: 0xef5)
// strings ... 17  (offset: 0xf1d)
// dev strs .. 0   (offset: 0x103d)
// exports ... 10  (offset: 0x961)
// cseg ...... 0x177 + 0x7ea (0x961)
// imports ... 34  (offset: 0xaf1)
// animtree1 . 0   (offset: 0x103d)
// animtree2 . 0   (offset: 0x103d)
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\playerhealth;

#namespace effect_wound;

// Namespace effect_wound
// Params 9
// Checksum 0xdf9f2382, Offset: 0x195
// Size: 0x12c
function wound( durations, maxduration, durationincrease, graceperiod, damage, var_cf730378ec6521c2, attacker, inflictor, var_75285b1df018599f )
{
    if ( status_effects::has_status_effect_type( "wound" ) || utility::ent_flag( "wounded_effect_grace_period" ) )
    {
        return;
    }
    
    wound_effect = status_effects::function_93edde8d0fe48bb6( "wound", durations, undefined, &start_wound, &end_wound );
    wound_effect.damage = damage;
    wound_effect.var_cf730378ec6521c2 = var_cf730378ec6521c2;
    wound_effect.attacker = attacker;
    wound_effect.inflictor = inflictor;
    wound_effect.next_damage_time = gettime();
    wound_effect.var_8114f7a539248a1 = maxduration;
    wound_effect.var_bdc4b2eb823f5f77 = durationincrease;
    wound_effect.total_duration = durations;
    wound_effect.screenfx = var_75285b1df018599f;
    wound_effect.var_5d68017a61bd7d32 = graceperiod;
    return status_effects::function_3747671c47b03216( wound_effect );
}

// Namespace effect_wound
// Params 1, eflags: 0x4
// Checksum 0x9c9985d9, Offset: 0x2ca
// Size: 0xde
function private start_wound( var_b0b7445b437b0f0d )
{
    if ( var_b0b7445b437b0f0d.damage > 0 )
    {
        thread tick_wound( var_b0b7445b437b0f0d );
        callback::add( "on_healingaura_healed", &on_healingaura_healed );
        thread monitor_damage_taken( var_b0b7445b437b0f0d );
        thread function_1b9feb4d83c3fea7( var_b0b7445b437b0f0d );
    }
    
    if ( isalive( self ) && isdefined( var_b0b7445b437b0f0d ) )
    {
        utility::ent_flag_set( "wounded_effect" );
        val::set( "wound", "health_regen", 0 );
        callback::callback( "wounded_effect_start", var_b0b7445b437b0f0d );
        
        if ( isplayer( self ) )
        {
            if ( isdefined( var_b0b7445b437b0f0d.screenfx ) )
            {
                utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:var_b0b7445b437b0f0d.screenfx }, 1, 1 );
            }
            
            thread function_e85b2f7a3ca55b4d( var_b0b7445b437b0f0d.total_duration );
        }
    }
}

// Namespace effect_wound
// Params 1, eflags: 0x4
// Checksum 0x2cc68412, Offset: 0x3b0
// Size: 0x18
function private on_healingaura_healed( params )
{
    self notify( #"healing_aura_healed" );
}

// Namespace effect_wound
// Params 1, eflags: 0x4
// Checksum 0xbd5830b5, Offset: 0x3d0
// Size: 0x1d1
function private monitor_damage_taken( var_b0b7445b437b0f0d )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_d3073c1d39f5eb56" );
    wait 0.1;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon );
        
        if ( meansofdeath != "MOD_BLEEDOUT" || ( idflags | 4294967296 ) == 0 )
        {
            if ( isdefined( var_b0b7445b437b0f0d.end_time ) && isdefined( var_b0b7445b437b0f0d.durations ) && isdefined( var_b0b7445b437b0f0d.var_8114f7a539248a1 ) && isdefined( var_b0b7445b437b0f0d.var_bdc4b2eb823f5f77 ) && isdefined( var_b0b7445b437b0f0d.total_duration ) && damage > 0 )
            {
                if ( var_b0b7445b437b0f0d.total_duration < var_b0b7445b437b0f0d.var_8114f7a539248a1 )
                {
                    increase = var_b0b7445b437b0f0d.var_bdc4b2eb823f5f77;
                    
                    if ( var_b0b7445b437b0f0d.total_duration + increase > var_b0b7445b437b0f0d.var_8114f7a539248a1 )
                    {
                        increase = var_b0b7445b437b0f0d.var_8114f7a539248a1 - var_b0b7445b437b0f0d.total_duration;
                    }
                    
                    var_b0b7445b437b0f0d.total_duration += increase;
                    var_b0b7445b437b0f0d.end_time += utility::function_4b74c15943231980( increase );
                    thread function_e85b2f7a3ca55b4d( utility::function_6f5d2e1f1ff70482( var_b0b7445b437b0f0d.end_time - gettime() ) );
                }
            }
        }
    }
}

// Namespace effect_wound
// Params 1, eflags: 0xc
// Checksum 0x98ea65ce, Offset: 0x5a9
// Size: 0x9f
function private function_e85b2f7a3ca55b4d( duration )
{
    self notify( #"hash_b8081499514ad6bf" );
    self endon( #"hash_b8081499514ad6bf" );
    
    if ( isplayer( self ) )
    {
        if ( self getscriptablehaspart( "wound_fx" ) )
        {
            self setscriptablepartstate( "wound_fx", "off", 0 );
            waitframe();
            
            if ( isdefined( self ) )
            {
                if ( duration <= 2.5 )
                {
                    self setscriptablepartstate( "wound_fx", "level_0", 0 );
                    return;
                }
                
                if ( duration <= 3.5 )
                {
                    self setscriptablepartstate( "wound_fx", "level_1", 0 );
                    return;
                }
                
                self setscriptablepartstate( "wound_fx", "level_2", 0 );
            }
        }
    }
}

// Namespace effect_wound
// Params 1, eflags: 0x4
// Checksum 0xd99728ac, Offset: 0x650
// Size: 0x83
function private function_1b9feb4d83c3fea7( var_b0b7445b437b0f0d )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_d3073c1d39f5eb56" );
    value = utility::waittill_any_return( "adrenaline_used", "healing_aura_healed" );
    
    if ( value == "adrenaline_used" )
    {
        val::reset( "wound", "health_regen" );
        playerhealth::forcehealthregen( self );
    }
    
    if ( isdefined( var_b0b7445b437b0f0d.end_time ) )
    {
        var_b0b7445b437b0f0d.end_time = gettime();
    }
}

// Namespace effect_wound
// Params 1, eflags: 0x4
// Checksum 0x5450057b, Offset: 0x6db
// Size: 0x112
function private end_wound( var_b0b7445b437b0f0d )
{
    utility::ent_flag_clear( "wounded_effect" );
    callback::callback( "wounded_effect_end", var_b0b7445b437b0f0d );
    callback::remove( "on_healingaura_healed", &on_healingaura_healed );
    val::reset( "wound", "health_regen" );
    
    if ( isplayer( self ) )
    {
        playerhealth::forcehealthregen( self );
        
        if ( isdefined( var_b0b7445b437b0f0d.screenfx ) )
        {
            utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:var_b0b7445b437b0f0d.screenfx } );
        }
        
        if ( self getscriptablehaspart( "wound_fx" ) )
        {
            self setscriptablepartstate( "wound_fx", "off", 0 );
        }
    }
    
    self notify( #"hash_d3073c1d39f5eb56" );
    
    if ( var_b0b7445b437b0f0d.var_5d68017a61bd7d32 > 0 && isalive( self ) )
    {
        thread wound_grace_period( var_b0b7445b437b0f0d.var_5d68017a61bd7d32 );
    }
    
    if ( !isalive( self ) && utility::ent_flag( "wounded_effect_grace_period" ) )
    {
        utility::ent_flag_clear( "wounded_effect_grace_period" );
    }
}

// Namespace effect_wound
// Params 1, eflags: 0xc
// Checksum 0x9bf8a9c5, Offset: 0x7f5
// Size: 0x4a
function private wound_grace_period( var_5d68017a61bd7d32 )
{
    self notify( #"hash_afc0fe4c06d05295" );
    self endon( #"hash_afc0fe4c06d05295" );
    self endon( #"death_or_disconnect" );
    utility::ent_flag_set( "wounded_effect_grace_period" );
    utility::ent_flag_clear_delayed( "wounded_effect_grace_period", var_5d68017a61bd7d32 );
}

// Namespace effect_wound
// Params 1, eflags: 0xc
// Checksum 0xfd3ff55c, Offset: 0x847
// Size: 0x11a
function private tick_wound( wound_effect )
{
    self notify( #"hash_52855ef7e0c95bb7" );
    self endon( #"hash_52855ef7e0c95bb7" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_d3073c1d39f5eb56" );
    
    if ( wound_effect.damage <= 0 )
    {
        return;
    }
    
    waitframe();
    
    while ( true )
    {
        wait wound_effect.var_cf730378ec6521c2;
        wound_effect.next_damage_time += utility::function_4b74c15943231980( wound_effect.var_cf730378ec6521c2 );
        
        if ( isent( wound_effect.attacker ) )
        {
            var_1b3eb30b79d38a4d = wound_effect.attacker;
        }
        
        if ( isdefined( wound_effect.inflictor ) )
        {
            inflictor = wound_effect.inflictor;
        }
        
        idflags = 4294967296;
        self dodamage( wound_effect.damage, self.origin, var_1b3eb30b79d38a4d, inflictor, "MOD_BLEEDOUT", "<explicitweaponnone>", "none", undefined, idflags );
    }
}

