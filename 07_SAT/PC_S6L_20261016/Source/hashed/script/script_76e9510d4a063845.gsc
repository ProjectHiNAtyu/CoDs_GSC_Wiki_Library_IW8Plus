// script_76e9510d4a063845  (hash_76e9510d4a063845.gscc) (size: 3185 Bytes / 0xc71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x28ad1578 (682431864)
// size ...... 3185 (0xc71)
// includes .. 3   (offset: 0xbc5)
// strings ... 11  (offset: 0xbdd)
// dev strs .. 0   (offset: 0xc71)
// exports ... 12  (offset: 0x711)
// cseg ...... 0x126 + 0x5eb (0x711)
// imports ... 25  (offset: 0x8f1)
// animtree1 . 0   (offset: 0xc71)
// animtree2 . 0   (offset: 0xc71)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_explosive_flourish;

// Namespace zm_bgb_explosive_flourish
// Params 0, eflags: 0x5
// Checksum 0xa451db33, Offset: 0x144
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "explosive_flourish", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_explosive_flourish
// Params 0
// Checksum 0x6e596fe2, Offset: 0x169
// Size: 0x24
function __init__()
{
    bgb::register( "explosive_flourish", "time", 120, &enable, &disable, &validation );
}

// Namespace zm_bgb_explosive_flourish
// Params 0
// Checksum 0x69f49496, Offset: 0x195
// Size: 0x9
function enable()
{
    thread function_2ea3b3a013f619f();
}

// Namespace zm_bgb_explosive_flourish
// Params 0
// Checksum 0x8c175d05, Offset: 0x1a6
// Size: 0x18
function disable()
{
    self notify( #"kill_bgb_explosive_flourish" );
    self.bgb_explosive_flourish_cooldown = undefined;
}

// Namespace zm_bgb_explosive_flourish
// Params 0
// Checksum 0x56c31cf9, Offset: 0x1c6
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace zm_bgb_explosive_flourish
// Params 0
// Checksum 0xaaf772a6, Offset: 0x1d3
// Size: 0x2d9
function function_2ea3b3a013f619f()
{
    self endon( #"disconnect", #"kill_bgb_explosive_flourish" );
    self.var_9fbc8e07784f3ceb = [];
    self.var_31b3a0eb94ce4613 = 0;
    
    while ( true )
    {
        self waittill( #"reload_start" );
        current_weapon = self getcurrentweapon();
        
        if ( arraycontains( self.var_9fbc8e07784f3ceb, current_weapon ) )
        {
            continue;
        }
        
        if ( current_weapon.var_d37f6a384340d490 )
        {
            continue;
        }
        
        self.var_9fbc8e07784f3ceb[ self.var_9fbc8e07784f3ceb.size ] = current_weapon;
        self.var_31b3a0eb94ce4613++;
        var_83e55048826dcd05 = self getweaponammoclip( current_weapon );
        var_b11feea92c35d08e = weaponclipsize( current_weapon );
        
        if ( var_b11feea92c35d08e <= 0 )
        {
            continue;
        }
        
        var_361f9c4ebf7a714f = 1 - var_83e55048826dcd05 / var_b11feea92c35d08e;
        var_5d05503c69d97725 = 256;
        var_ebcc90c69d045cb1 = mapfloat( 0, 1, 100, 575, var_361f9c4ebf7a714f );
        thread function_a64bab56109d34( current_weapon );
        
        if ( isdefined( self ) )
        {
            switch ( self.var_31b3a0eb94ce4613 )
            {
                case 0:
                case 1:
                    var_1750e29c4552e157 = undefined;
                    break;
                case 2:
                    var_1750e29c4552e157 = 8;
                    break;
                case 3:
                    var_1750e29c4552e157 = 4;
                    break;
                case 4:
                    var_1750e29c4552e157 = 2;
                    break;
                default:
                    var_1750e29c4552e157 = 0;
                    break;
            }
            
            thread function_c83f846de6de6b18( current_weapon );
            
            if ( var_1750e29c4552e157 === 0 )
            {
                continue;
            }
            
            thread function_4bc41d070eeefd21( var_361f9c4ebf7a714f );
            self notify( #"hash_30bb8120b6489d6a" );
            a_zombies = getplayersandaiarrayinradius( self.origin, var_5d05503c69d97725 );
            var_56fb443d4cb62322 = 0;
            
            for ( i = 0; i < a_zombies.size ; i++ )
            {
                if ( self.team == a_zombies[ i ].team )
                {
                    continue;
                }
                
                if ( isalive( self ) && isalive( a_zombies[ i ] ) )
                {
                    if ( isdefined( var_1750e29c4552e157 ) )
                    {
                        if ( var_56fb443d4cb62322 < var_1750e29c4552e157 )
                        {
                            var_56fb443d4cb62322++;
                        }
                        else
                        {
                            break;
                        }
                    }
                    
                    if ( isplayer( a_zombies[ i ] ) )
                    {
                    }
                    else if ( a_zombies[ i ].health <= var_ebcc90c69d045cb1 )
                    {
                        a_zombies[ i ] thread explosive_flourish_death_fx();
                        
                        if ( !isdefined( self.bgb_explosive_flourish_kills ) )
                        {
                            self.bgb_explosive_flourish_kills = 0;
                        }
                        
                        self.bgb_explosive_flourish_kills++;
                    }
                    else if ( !isdefined( a_zombies[ i ].var_1279adada07449f2 ) )
                    {
                    }
                    
                    wait 0.1;
                    
                    if ( isalive( a_zombies[ i ] ) )
                    {
                        a_zombies[ i ] dodamage( var_ebcc90c69d045cb1, self.origin, self, self, "MOD_EXPLOSIVE", "<explicitweaponnone>" );
                    }
                }
            }
            
            self notify( #"explosive_flourish_end" );
        }
    }
}

// Namespace zm_bgb_explosive_flourish
// Params 1
// Checksum 0x1b7c7f90, Offset: 0x4b4
// Size: 0x9b
function function_a64bab56109d34( weapon )
{
    self endon( #"disconnect", #"kill_bgb_explosive_flourish", "player_lost_weapon_" + weapon.basename );
    thread function_b82147060c38f1e2( weapon );
    
    while ( true )
    {
        utility::waittill_any( "reload", "zmb_max_ammo_level" );
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon == weapon )
        {
            self.var_9fbc8e07784f3ceb = arrayremove( self.var_9fbc8e07784f3ceb, weapon );
            self notify( "weapon_reload_complete_" + weapon.basename );
            break;
        }
    }
}

// Namespace zm_bgb_explosive_flourish
// Params 1
// Checksum 0x361ddea2, Offset: 0x557
// Size: 0x92
function function_b82147060c38f1e2( weapon )
{
    self endon( #"disconnect", #"kill_bgb_explosive_flourish", "weapon_reload_complete_" + weapon.basename );
    
    while ( true )
    {
        self waittill( #"weapon_change" );
        primaryweapons = self getweaponslistprimaries();
        
        if ( !arraycontains( primaryweapons, weapon ) )
        {
            self notify( "player_lost_weapon_" + weapon.basename );
            self.var_9fbc8e07784f3ceb = arrayremove( self.var_9fbc8e07784f3ceb, weapon );
            break;
        }
    }
}

// Namespace zm_bgb_explosive_flourish
// Params 1
// Checksum 0x8052aaa, Offset: 0x5f1
// Size: 0x81
function function_c83f846de6de6b18( current_weapon )
{
    self endon( #"disconnect", #"kill_bgb_explosive_flourish" );
    
    if ( self.var_31b3a0eb94ce4613 > 4 && !isdefined( self.bgb_explosive_flourish_cooldown ) )
    {
        self.bgb_explosive_flourish_cooldown = 1;
        var_30d690136b92e914 = 0.25;
        var_633285f53d38fbc0 = var_30d690136b92e914 + 3;
        wait var_633285f53d38fbc0;
        self.var_31b3a0eb94ce4613 = 0;
        self.bgb_explosive_flourish_cooldown = undefined;
    }
}

// Namespace zm_bgb_explosive_flourish
// Params 1
// Checksum 0xaf9202e3, Offset: 0x67a
// Size: 0x71
function function_4bc41d070eeefd21( var_361f9c4ebf7a714f )
{
    self endon( #"disconnect", #"kill_bgb_explosive_flourish" );
    self setscriptablepartstate( "bgb_explosive_flourish", "bgb_fx_on", 0 );
    
    if ( var_361f9c4ebf7a714f >= 0.67 )
    {
    }
    else if ( var_361f9c4ebf7a714f >= 0.33 && var_361f9c4ebf7a714f < 0.67 )
    {
    }
    
    wait 2;
    self setscriptablepartstate( "bgb_explosive_flourish", "bgb_fx_off", 0 );
}

// Namespace zm_bgb_explosive_flourish
// Params 0
// Checksum 0xe8dad265, Offset: 0x6f3
// Size: 0x1e
function explosive_flourish_death_fx()
{
    self endon( #"death" );
    
    if ( !self.head_gibbed )
    {
    }
}

