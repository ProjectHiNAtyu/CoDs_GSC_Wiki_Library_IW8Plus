// scripts\mp\zm\traps\electric_trap.gsc  (hash_0ed90db65b7740f8.gscc) (size: 3495 Bytes / 0xda7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc644325a (3326358106)
// size ...... 3495 (0xda7)
// includes .. 7   (offset: 0xc6b)
// strings ... 18  (offset: 0xca3)
// dev strs .. 0   (offset: 0xda7)
// exports ... 7   (offset: 0x757)
// cseg ...... 0x1a0 + 0x5b7 (0x757)
// imports ... 35  (offset: 0x86f)
// animtree1 . 0   (offset: 0xda7)
// animtree2 . 0   (offset: 0xda7)
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\traps\traps;

#namespace electric_trap;

// Namespace electric_trap
// Params 0
// Checksum 0x722b6874, Offset: 0x1be
// Size: 0x5a
function init_electric_trap()
{
    level._effect[ "trap_electric_player" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_screen_elec_shock_bot" );
    traps::function_84ce1d5572ecd46a( "electric_switch", undefined, undefined, undefined, undefined );
    level thread traps::function_63a557f0f22161af( "electric_switch", &function_340882f745709b57, &function_7b8247c341cefb9e );
    level.electric_trap_throttle = throttle::throttle_initialize( "electric_trap", 2, 1 );
}

// Namespace electric_trap
// Params 1
// Checksum 0xa3f3ef0, Offset: 0x220
// Size: 0x250
function function_340882f745709b57( activator )
{
    level endon( #"game_ended" );
    self endon( #"hash_ba7009b1af73b2ef" );
    self.damage_volume = getent( self.target, #targetname );
    var_12579d90f8031d5 = utility::getstructarray( self.target, "targetname" );
    
    while ( true )
    {
        current_time = gettime();
        var_3e5df7c437647749 = getaiarrayinradius( self.damage_volume.origin, 500, level.var_ece703e3d116381c );
        
        foreach ( zombie in var_3e5df7c437647749 )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( zombie istouching( self.damage_volume ) )
            {
                if ( !isdefined( zombie.var_f85d385156d7fbac ) )
                {
                    zombie function_a3343db3df219663( current_time, activator );
                    continue;
                }
                
                if ( current_time > zombie.var_f85d385156d7fbac )
                {
                    zombie function_a3343db3df219663( current_time, activator );
                }
            }
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.var_f85d385156d7fbac ) )
            {
                player.var_f85d385156d7fbac = 0;
            }
            
            if ( current_time > player.var_f85d385156d7fbac && isalive( player ) && player istouching( self.damage_volume ) )
            {
                player dodamage( 20, player.origin, undefined, player );
                player.var_f85d385156d7fbac = current_time + 1000;
                player thread function_6a059e76eb0d6cce();
            }
        }
        
        waitframe();
    }
}

// Namespace electric_trap
// Params 1
// Checksum 0xe8b4b036, Offset: 0x478
// Size: 0x24
function function_7b8247c341cefb9e( activator )
{
    level endon( #"game_ended" );
    self notify( #"hash_ba7009b1af73b2ef" );
}

// Namespace electric_trap
// Params 2
// Checksum 0x4e3c851f, Offset: 0x4a4
// Size: 0xbf
function function_a3343db3df219663( current_time, attacker )
{
    if ( self.aicategory == "normal" || self.aicategory == "special" )
    {
        if ( !utility::ent_flag( "electric_trap_stunned" ) )
        {
            params = spawnstruct();
            params.attacker = attacker;
            callback::callback( "shocked", params );
            utility::ent_flag_set( "electric_trap_stunned" );
            namespace_f4f7019540228268::stun( "electric_trap", 1000, params.attacker, undefined, undefined, "electrical" );
            self.var_f85d385156d7fbac = current_time + utility::function_4b74c15943231980( 2 );
            thread function_207384b81fa7f7f5( attacker );
        }
    }
}

// Namespace electric_trap
// Params 1
// Checksum 0x8b536c03, Offset: 0x56b
// Size: 0x130
function function_207384b81fa7f7f5( attacker )
{
    self endon( #"death" );
    
    while ( zombie_stun::is_stunned() && gettime() <= self.var_f85d385156d7fbac )
    {
        self setscriptablepartstate( "shocked_electric", "shocked_electric_on" );
        
        if ( isalive( self ) )
        {
            var_be54cac8928065d0 = int( self.maxhealth * 0.4 );
            
            if ( self.health - var_be54cac8928065d0 < 1 )
            {
                self.health = 1;
            }
            else
            {
                self dodamage( var_be54cac8928065d0, self.origin, attacker, attacker, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
            }
        }
        
        throttle::throttle_wait_in_queue( level.electric_trap_throttle, self );
        time = gettime();
    }
    
    params = spawnstruct();
    params.attacker = attacker;
    callback::callback( "shocked_end", params );
    utility::ent_flag_clear( "electric_trap_stunned" );
    self setscriptablepartstate( "shocked_electric", "shocked_electric_off" );
    
    if ( isalive( self ) )
    {
        self kill( self.origin, attacker );
    }
}

// Namespace electric_trap
// Params 0
// Checksum 0x71cd100a, Offset: 0x6a3
// Size: 0xb4
function function_6a059e76eb0d6cce()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_6063f49d5d888d5d" );
    self endon( #"hash_6063f49d5d888d5d" );
    
    if ( !self.var_b4d756413b7103ef )
    {
        playfxontagforclients( level._effect[ "trap_electric_player" ], self, "j_head", self );
        self.var_b4d756413b7103ef = 1;
    }
    
    val::set( "electric_trap", "move_speed_scale", 0.5 );
    wait 2;
    val::reset( "electric_trap", "move_speed_scale" );
    stopfxontagforclients( level._effect[ "trap_electric_player" ], self, "j_head", self );
    self.var_b4d756413b7103ef = undefined;
}

