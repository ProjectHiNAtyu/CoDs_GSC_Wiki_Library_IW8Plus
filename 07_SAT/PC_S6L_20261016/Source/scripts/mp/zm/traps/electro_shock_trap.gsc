// scripts\mp\zm\traps\electro_shock_trap.gsc  (hash_3c10fff45fec6ec2.gscc) (size: 6078 Bytes / 0x17be / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5957e21a (1498931738)
// size ...... 6078 (0x17be)
// includes .. 6   (offset: 0x1596)
// strings ... 33  (offset: 0x15c6)
// dev strs .. 0   (offset: 0x17be)
// exports ... 9   (offset: 0xe42)
// cseg ...... 0x3b3 + 0xa8f (0xe42)
// imports ... 49  (offset: 0xfaa)
// animtree1 . 0   (offset: 0x17be)
// animtree2 . 0   (offset: 0x17be)
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\trap_core;

#namespace electro_shock_trap;

// Namespace electro_shock_trap
// Params 0
// Checksum 0x3520ba83, Offset: 0x3d1
// Size: 0xac
function init()
{
    level._effect[ "laser_trap_beam" ] = loadfxasset( "vfx_sat_levels_zm_ruby_laser_trap_red" );
    level._effect[ "laser_trap_beam_trail" ] = loadfxasset( "vfx_sat_levels_zm_ruby_laser_trap_red_t" );
    level._effect[ "laser_trap_mirror_impact" ] = loadfxasset( "vfx_sat_levels_zm_ruby_laser_trap_mirrors_impact" );
    level._effect[ "trap_electric_player" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_screen_elec_shock_bot" );
    level utility::flag_wait( "scriptables_ready" );
    trap_core::function_63a557f0f22161af( "electro_shock_trap_switch", &activate_electro_shock_trap, &deactivate_electro_shock_trap );
    trap_core::function_63a557f0f22161af( "electro_shock_trap_garage_switch", &activate_electro_shock_trap, &deactivate_electro_shock_trap );
    level utility::flag_wait( "electro_shock_trap_switch_init_finished" );
}

// Namespace electro_shock_trap
// Params 1
// Checksum 0x8eee3738, Offset: 0x485
// Size: 0x2b4
function activate_electro_shock_trap( activator )
{
    level endon( #"game_ended" );
    self endon( #"deactivate_trap" );
    self.damage_volume = getnoentvolumearray( self.target, #targetname )[ 0 ];
    
    if ( isdefined( activator ) && !activator utility::ent_flag( "electro_shock_trap_first_kill_vo" ) )
    {
        if ( !level callback::exists( "on_zombie_ai_killed", &function_f00c0f833e8147fc ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
        }
    }
    
    while ( true )
    {
        current_time = gettime();
        var_3e5df7c437647749 = getaiarrayinradius( self.damage_volume.origin, 300, level.var_ece703e3d116381c );
        
        foreach ( zombie in var_3e5df7c437647749 )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( zombie.relic_spawn && level.active_relic_challenge.relic_hash == %"hash_5fd98af539578121" )
            {
                continue;
            }
            
            if ( zombie istouching( self.damage_volume ) )
            {
                zombie function_a3343db3df219663( current_time, activator, self );
                continue;
            }
            
            zombie electric_end( activator, self );
            zombie notify( #"hash_b57413cd7e10445f" );
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.var_8fa6ea0a3da3394e ) )
            {
                player.var_8fa6ea0a3da3394e = 0;
            }
            
            if ( current_time > player.var_8fa6ea0a3da3394e && isalive( player ) && player istouching( self.damage_volume ) )
            {
                player dodamage( 20, player.origin, self.attack_entity, self.attack_entity, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
                player.var_8fa6ea0a3da3394e = current_time + 500;
                player thread function_6a059e76eb0d6cce();
            }
        }
        
        waitframe();
    }
}

// Namespace electro_shock_trap
// Params 1
// Checksum 0x316fe7, Offset: 0x741
// Size: 0x12e
function deactivate_electro_shock_trap( activator )
{
    self notify( #"deactivate_trap" );
    params = spawnstruct();
    params.activator = activator;
    params.var_359a765be5422f83 = self;
    var_3e5df7c437647749 = getaiarrayinradius( self.damage_volume.origin, 300, level.var_ece703e3d116381c );
    
    foreach ( zombie in var_3e5df7c437647749 )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie istouching( self.damage_volume ) )
        {
            zombie effect_stun::function_cf15e13610c1177( "electro_shock_trap" );
            zombie electric_end( activator, self );
            zombie notify( #"hash_b57413cd7e10445f" );
        }
    }
    
    level callback::remove( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
}

// Namespace electro_shock_trap
// Params 3
// Checksum 0x3f5413fb, Offset: 0x877
// Size: 0x1a3
function function_a3343db3df219663( current_time, attacker, var_359a765be5422f83 )
{
    if ( !utility::ent_flag( "electro_shock_trap_damaged" ) )
    {
        utility::ent_flag_set( "electro_shock_trap_damaged" );
        
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                self.var_8d2325a3c1b80415 = 0.5;
                self.should_stun = 1;
                break;
            case #"hash_8c089e813083e510":
                self.var_8d2325a3c1b80415 = 0.1;
                self.should_stun = 1;
                break;
            case #"hash_7b0e2f2ed84f34":
                self.var_8d2325a3c1b80415 = 0.08;
                self.should_stun = 0;
                break;
            case #"hash_4e47eb6c32f5b165":
                self.var_8d2325a3c1b80415 = 0.06;
                self.should_stun = 0;
                break;
            case #"hash_7e8a002ed096276c":
                self.var_8d2325a3c1b80415 = 0;
                self.should_stun = 0;
                break;
            default:
                self.var_8d2325a3c1b80415 = 0;
                self.should_stun = 0;
                return;
        }
        
        if ( self.should_stun )
        {
            params = spawnstruct();
            params.attacker = attacker;
            callback::callback( "shocked", params );
            effect_stun::stun( "electro_shock_trap", 1000, params.attacker, undefined, undefined, "electrical" );
        }
        
        self.var_fcda6ada44e27b98 = current_time + utility::function_4b74c15943231980( 2 );
        thread function_207384b81fa7f7f5( attacker, var_359a765be5422f83 );
    }
}

// Namespace electro_shock_trap
// Params 0
// Checksum 0xcee539b6, Offset: 0xa22
// Size: 0xea
function function_6a059e76eb0d6cce()
{
    self notify( #"hash_a189a8532403221e" );
    self endon( #"hash_a189a8532403221e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !self.var_b4d756413b7103ef )
    {
        playfxontagforclients( level._effect[ "trap_electric_player" ], self, "j_head", self );
        self playsoundtoplayer( #"hash_79ef456929f3c3cc", self );
        self.electric_loop_sound = self playloopsound( #"hash_f2c677e2a71c39dd" );
        self.var_b4d756413b7103ef = 1;
    }
    
    val::set( "electric_trap", "move_speed_scale", 0.5 );
    wait 2;
    val::reset( "electric_trap", "move_speed_scale" );
    stopfxontagforclients( level._effect[ "trap_electric_player" ], self, "j_head", self );
    self stoploopsound( self.electric_loop_sound );
    self.var_b4d756413b7103ef = undefined;
}

// Namespace electro_shock_trap
// Params 2
// Checksum 0xbeaebfe1, Offset: 0xb14
// Size: 0x165
function function_207384b81fa7f7f5( attacker, var_359a765be5422f83 )
{
    self endon( #"death" );
    
    while ( gettime() <= self.var_fcda6ada44e27b98 )
    {
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            utility::function_7c10ea82c1e305b8( "shocked_electric", "shocked_electric_on" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "shocked", "shocked_on" );
        }
        
        if ( isalive( self ) )
        {
            var_be54cac8928065d0 = int( self.maxhealth * self.var_8d2325a3c1b80415 ) + 1;
            
            if ( self.health - var_be54cac8928065d0 <= 0 )
            {
                annihilate_rate = randomfloat( 1 );
                
                if ( annihilate_rate < 0.5 )
                {
                    self.forceannihilate = 1;
                }
                
                if ( !utility::ent_flag( "electro_shock_trap_kill" ) )
                {
                    utility::ent_flag_set( "electro_shock_trap_kill" );
                }
                
                self kill( undefined, undefined, var_359a765be5422f83.attack_entity, "MOD_ELEMENTAL_ELEC", "<explicitweaponnone>" );
                break;
            }
            else
            {
                if ( !utility::ent_flag( "electro_shock_trap_kill" ) )
                {
                    utility::ent_flag_set( "electro_shock_trap_kill" );
                }
                
                self dodamage( var_be54cac8928065d0, self.origin, attacker, var_359a765be5422f83.attack_entity, "MOD_ELEMENTAL_ELEC", "<explicitweaponnone>" );
            }
        }
        
        wait 0.5;
    }
    
    electric_end( attacker, var_359a765be5422f83 );
}

// Namespace electro_shock_trap
// Params 2
// Checksum 0xc423ee4f, Offset: 0xc81
// Size: 0xa9
function electric_end( attacker, var_359a765be5422f83 )
{
    params = spawnstruct();
    params.attacker = attacker;
    callback::callback( "shocked_end", params );
    utility::ent_flag_clear( "electro_shock_trap_damaged" );
    
    if ( issubstr( self.subclass, "zombie_base" ) )
    {
        utility::function_7c10ea82c1e305b8( "shocked_electric", "shocked_electric_off" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
    }
    
    if ( isalive( self ) )
    {
        if ( utility::ent_flag( "electro_shock_trap_kill" ) )
        {
            utility::ent_flag_clear( "electro_shock_trap_kill" );
        }
    }
}

// Namespace electro_shock_trap
// Params 1, eflags: 0x4
// Checksum 0x83a641a9, Offset: 0xd32
// Size: 0x110
function private function_f00c0f833e8147fc( params )
{
    if ( isdefined( params.einflictor ) && ( params.einflictor.var_fcda7168a743663a == "electro_shock_trap_garage_switch" || params.einflictor.var_fcda7168a743663a == "electro_shock_trap_switch" ) )
    {
        player = params.einflictor.activator;
        
        if ( !isplayer( player ) )
        {
            return;
        }
        
        if ( player utility::ent_flag( "electro_shock_trap_first_kill_vo" ) )
        {
            return;
        }
        
        if ( !( gettime() > ( level.var_e8abfed5193da9da ?? 0 ) ) )
        {
            return;
        }
        
        player utility::ent_flag_set( "electro_shock_trap_first_kill_vo" );
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"electro_shock_trap_first_kill" );
        
        if ( !var_db75d3de862ce072 )
        {
            player utility::ent_flag_clear( "electro_shock_trap_first_kill_vo" );
            return;
        }
        
        level callback::remove( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
        level.var_e8abfed5193da9da = gettime() + 180000;
    }
}

