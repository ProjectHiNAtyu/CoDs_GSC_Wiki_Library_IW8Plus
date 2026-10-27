// scripts\mp\ob\skills\skill_shocking_reload.gsc  (hash_362ec46b16d0b24f.gscc) (size: 4324 Bytes / 0x10e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9e2a17e (4192379262)
// size ...... 4324 (0x10e4)
// includes .. 4   (offset: 0xf5c)
// strings ... 9   (offset: 0xf7c)
// dev strs .. 17  (offset: 0xff4)
// exports ... 14  (offset: 0x8f0)
// cseg ...... 0x10c + 0x7e4 (0x8f0)
// imports ... 36  (offset: 0xb20)
// animtree1 . 0   (offset: 0x10e4)
// animtree2 . 0   (offset: 0x10e4)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\utility;
#using scripts\mp\ob\ob_shock_util;

#namespace skill_shocking_reload;

// Namespace skill_shocking_reload
// Params 0, eflags: 0x1
// Checksum 0xccf5b483, Offset: 0x12a
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"shocking_reload", &init );
}

// Namespace skill_shocking_reload
// Params 0, eflags: 0x4
// Checksum 0x28c67e6, Offset: 0x149
// Size: 0x3e
function private init()
{
    utility::registersharedfunc( #"shocking_reload", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"shocking_reload", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_shocking_reload
// Params 1, eflags: 0x4
// Checksum 0x40b3bb9b, Offset: 0x18f
// Size: 0x19d, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.shockingreloadradius, "<dev string:x24>" );
    assert( skill_bundle.var_43622916322a42aa, "<dev string:x68>" );
    assert( skill_bundle.shockingreloadmaxdamage, "<dev string:xaf>" );
    assert( skill_bundle.shockingreloadcooldown, "<dev string:xf6>" );
    assert( skill_bundle.shockingreloadstunduration, "<dev string:x13c>" );
    assert( skill_bundle.var_a680a31760ce9294, "<dev string:x186>" );
    assert( skill_bundle.var_186d607b7c6abee1, "<dev string:x1d6>" );
    assert( skill_bundle.var_8f230c3877682097, "<dev string:x223>" );
    assert( skill_bundle.var_43622916322a42aa <= skill_bundle.shockingreloadmaxdamage, "<dev string:x270>" + skill_bundle.skilllevel );
    assert( self getscriptablehaspart( "<dev string:x2ad>" ), "<dev string:x2be>" + "<dev string:x2ad>" );
    assert( self getscriptableparthasstate( "<dev string:x2ad>", "<dev string:x2de>" ), "<dev string:x2f5>" + "<dev string:x2de>" + "<dev string:x316>" + "<dev string:x2ad>" );
    assert( self getscriptableparthasstate( "<dev string:x2ad>", "<dev string:x320>" ), "<dev string:x2f5>" + "<dev string:x320>" + "<dev string:x316>" + "<dev string:x2ad>" );
    self.var_3f02bf670c665cc8 = { #oncooldown:0 };
    thread monitor_shocking_reload( skill_bundle, self.var_3f02bf670c665cc8 );
    return true;
}

// Namespace skill_shocking_reload
// Params 1, eflags: 0x4
// Checksum 0x36e2b3b6, Offset: 0x335
// Size: 0x2e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"kill_shocking_reload" );
    self setclientomnvar( "ui_skill_shockingreload_activated", 0 );
    self.var_3f02bf670c665cc8 = undefined;
}

// Namespace skill_shocking_reload
// Params 2
// Checksum 0x34709d62, Offset: 0x36b
// Size: 0x1ba
function monitor_shocking_reload( bundle, var_da55798eb12048a0 )
{
    self endon( #"disconnect", #"kill_shocking_reload" );
    
    while ( true )
    {
        self waittill( #"reload_start" );
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon.var_d37f6a384340d490 )
        {
            continue;
        }
        
        if ( var_da55798eb12048a0.oncooldown )
        {
            waitframe();
            continue;
        }
        
        var_83e55048826dcd05 = self getweaponammoclip( current_weapon );
        var_b11feea92c35d08e = weaponclipsize( current_weapon );
        
        if ( !var_b11feea92c35d08e || var_b11feea92c35d08e <= 0 )
        {
            var_361f9c4ebf7a714f = 1;
        }
        else
        {
            var_361f9c4ebf7a714f = 1 - var_83e55048826dcd05 / var_b11feea92c35d08e;
        }
        
        if ( isdefined( self ) )
        {
            thread cooldown_timer( current_weapon, bundle.shockingreloadcooldown, var_da55798eb12048a0 );
            
            /#
                if ( getdvarint( @"hash_77c49f1c75b64926", 0 ) )
                {
                    text_distance = "<dev string:x335>" + string( bundle.shockingreloadradius );
                    printtoscreen2d( 500, 350, text_distance, ( 1, 1, 1 ), 2, 300 );
                    sphere( self.origin, bundle.shockingreloadradius, ( 0, 1, 0 ), 0, 300 );
                }
            #/
            
            thread reload_fx();
            do_damage( &get_close_ai, bundle, bundle.shockingreloadstunduration, bundle.var_43622916322a42aa, bundle.shockingreloadmaxdamage, var_361f9c4ebf7a714f );
            do_damage( &get_close_players, bundle, bundle.var_a680a31760ce9294, bundle.var_186d607b7c6abee1, bundle.var_8f230c3877682097, var_361f9c4ebf7a714f );
        }
    }
}

// Namespace skill_shocking_reload
// Params 6, eflags: 0x4
// Checksum 0x212871a1, Offset: 0x52d
// Size: 0xad
function private do_damage( get_enemies_func, bundle, duration, var_578d71b7c00fc4ba, var_6a02108301e17dc, var_361f9c4ebf7a714f )
{
    enemies = [[ get_enemies_func ]]( self.origin, bundle.shockingreloadradius );
    var_ebcc90c69d045cb1 = mapfloat( 0, 1, var_578d71b7c00fc4ba, var_6a02108301e17dc, var_361f9c4ebf7a714f );
    
    for ( i = 0; i < enemies.size ; i++ )
    {
        enemy = enemies[ i ];
        thread do_damage_to_enemy( bundle, var_ebcc90c69d045cb1, enemy, duration );
    }
}

// Namespace skill_shocking_reload
// Params 4, eflags: 0x4
// Checksum 0xa75d039a, Offset: 0x5e2
// Size: 0xe0
function private do_damage_to_enemy( bundle, var_ebcc90c69d045cb1, enemy, duration )
{
    if ( enemy function_4de5a741f5baa1c4( self, bundle.var_50382f7291e7682f, bundle.var_fe97c446eee2ed89 ) )
    {
        enemy.is_shocking_reload_damage = 1;
        var_687e7155eaad543f = enemy.health > var_ebcc90c69d045cb1;
        
        if ( var_687e7155eaad543f )
        {
            enemy ob_shock_util::stun_target( self, duration );
            enemy thread ob_shock_util::shock_fx( self, duration );
            enemy thread function_db1e2fd08da70d5e( duration );
        }
        
        wait 0.1;
        
        if ( isalive( enemy ) )
        {
            enemy dodamage( var_ebcc90c69d045cb1, self.origin, self, self, "MOD_ELEMENTAL_ELEC", "<explicitweaponnone>", "none", undefined, 65537 );
            
            if ( !var_687e7155eaad543f )
            {
                enemy.is_shocking_reload_damage = undefined;
            }
        }
    }
}

// Namespace skill_shocking_reload
// Params 2, eflags: 0x4
// Checksum 0x5802ef0, Offset: 0x6ca
// Size: 0x1c
function private get_close_ai( origin, radius )
{
    return getaiarrayinradius( origin, radius );
}

// Namespace skill_shocking_reload
// Params 2, eflags: 0x4
// Checksum 0xb46960c9, Offset: 0x6ef
// Size: 0x1c
function private get_close_players( origin, radius )
{
    return getplayersinradius( origin, radius );
}

// Namespace skill_shocking_reload
// Params 3
// Checksum 0x2eb240c5, Offset: 0x714
// Size: 0x78
function cooldown_timer( current_weapon, skill_cooldown, var_da55798eb12048a0 )
{
    self endon( #"disconnect", #"kill_shocking_reload" );
    var_da55798eb12048a0.oncooldown = 1;
    weapon_reload_time = self function_e338113f9be8939e( current_weapon ) * 0.001;
    cooldown = skill_cooldown + weapon_reload_time;
    wait cooldown;
    var_da55798eb12048a0.oncooldown = 0;
}

// Namespace skill_shocking_reload
// Params 0
// Checksum 0xf4cecad7, Offset: 0x794
// Size: 0x55
function reload_fx()
{
    self endon( #"disconnect", #"kill_shocking_reload" );
    self setclientomnvar( "ui_skill_shockingreload_activated", 1 );
    utility::function_32b24db3127bff40( "shockingReloadFX", "shockingReloadFX_start" );
    wait 1;
    utility::function_32b24db3127bff40( "shockingReloadFX", "shockingReloadFX_off" );
    self setclientomnvar( "ui_skill_shockingreload_activated", 0 );
}

// Namespace skill_shocking_reload
// Params 3, eflags: 0x4
// Checksum 0xffd21f83, Offset: 0x7f1
// Size: 0xcd, Type: bool
function private function_4de5a741f5baa1c4( attacker, zombie_max_tier, soldier_max_tier )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self.team == attacker.team )
    {
        return false;
    }
    
    if ( isagent( self ) && self._blackboard.invehicle )
    {
        return false;
    }
    
    ai_max_tier = undefined;
    
    if ( self.type == "zombie" )
    {
        ai_max_tier = zombie_max_tier;
    }
    else if ( self.type == "human" )
    {
        ai_max_tier = soldier_max_tier;
    }
    
    if ( isdefined( ai_max_tier ) )
    {
        tiernumber = ai_utility::get_power_tier();
        assert( isdefined( tiernumber ), "<dev string:x34e>" );
        return ( ai_max_tier >= tiernumber );
    }
    
    return true;
}

// Namespace skill_shocking_reload
// Params 1, eflags: 0x4
// Checksum 0x7cad477c, Offset: 0x8c7
// Size: 0x29
function private function_db1e2fd08da70d5e( stun_duration )
{
    level endon( #"game_ended" );
    wait stun_duration;
    
    if ( self )
    {
        self.is_shocking_reload_damage = undefined;
    }
}

