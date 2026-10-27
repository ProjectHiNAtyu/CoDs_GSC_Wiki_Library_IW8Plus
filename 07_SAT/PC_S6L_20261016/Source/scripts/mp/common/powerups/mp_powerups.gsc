// scripts\mp\common\powerups\mp_powerups.gsc  (hash_221af69acf3f8167.gscc) (size: 3346 Bytes / 0xd12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6122e85b (1629677659)
// size ...... 3346 (0xd12)
// includes .. 6   (offset: 0xc9e)
// strings ... 4   (offset: 0xcce)
// dev strs .. 1   (offset: 0xd06)
// exports ... 12  (offset: 0x6d6)
// cseg ...... 0x95 + 0x641 (0x6d6)
// imports ... 35  (offset: 0x8b6)
// animtree1 . 0   (offset: 0xd12)
// animtree2 . 0   (offset: 0xd12)
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;

#namespace mp_powerups;

// Namespace mp_powerups
// Params 0, eflags: 0x1
// Checksum 0xee0e1766, Offset: 0xb3
// Size: 0x34
function autoexec main()
{
    if ( getdvarint( @"scr_mp_powerups_enabled", 1 ) && isdefined( level.gametypebundle.powerup_list ) )
    {
        level thread init();
    }
}

// Namespace mp_powerups
// Params 0
// Checksum 0xacecd0e3, Offset: 0xef
// Size: 0xa9
function init()
{
    powerups_cpmp::init( &util_give_points, &function_4aa1d175b03e7bb2, 1 );
    bundle = powerups::get_bundle_list();
    level.powerups_root.cache_drop_chance = bundle.var_1f33ff37e7838dbc;
    level.powerups_root.kill_drop_chance = bundle.var_3d01bdd4221215e2;
    level.powerups_root.var_6cd2e2a3fe7ea414 = bundle.var_3a8d076dd0f5523c;
    utility::registersharedfunc( #"powerups", #"dropPowerup", &mp_powerup_drop );
    init_callbacks();
}

// Namespace mp_powerups
// Params 0
// Checksum 0x6abb7e8, Offset: 0x1a0
// Size: 0x71
function init_callbacks()
{
    if ( level.powerups_root.kill_drop_chance > 0 )
    {
        level callback::add( #"player_death", &mp_on_death );
    }
    
    if ( level.powerups_root.var_6cd2e2a3fe7ea414 > 0 && level.gametypebundle.var_f2fc76ef473d1a0a )
    {
        level callback::add( "on_zombie_ai_killed", &mp_on_death );
    }
}

// Namespace mp_powerups
// Params 1
// Checksum 0x61a0ed09, Offset: 0x219
// Size: 0x41
function mp_on_death( params )
{
    powerups::function_b6d20332b27fa42e();
    attacker = params.attacker ?? params.eattacker;
    mp_handle_death( attacker );
}

// Namespace mp_powerups
// Params 1
// Checksum 0x5675c4d6, Offset: 0x262
// Size: 0xc5
function mp_handle_death( attacker )
{
    if ( attacker == self || !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    roll = randomfloatrange( 0, 1 );
    
    /#
        if ( getdvar( @"hash_33bb76bce736065a" ) )
        {
            roll = 0;
        }
    #/
    
    var_dcef9be67174ef20 = get_drop_chance( self );
    
    if ( roll > var_dcef9be67174ef20 )
    {
        return;
    }
    
    offset = ( 0, 0, powerups::get_powerup_var( "drop_height_offset" ) );
    location = self getdroptofloorposition( self.origin ) ?? self.origin;
    level thread function_e00e17d205000f16( location + offset, self, attacker );
}

// Namespace mp_powerups
// Params 1
// Checksum 0xf3edfc5f, Offset: 0x32f
// Size: 0x5d
function get_drop_chance( victim )
{
    if ( victim.var_bfca74c4f1a0032e )
    {
        return victim.var_bfca74c4f1a0032e;
    }
    
    if ( isplayer( victim ) )
    {
        return level.powerups_root.kill_drop_chance;
    }
    
    return level.powerups_root.var_6cd2e2a3fe7ea414;
}

// Namespace mp_powerups
// Params 3
// Checksum 0xfe5b5e61, Offset: 0x394
// Size: 0x4a
function function_e00e17d205000f16( location, victim, attacker )
{
    powerup = get_random_powerup( attacker );
    
    if ( powerup != "none" )
    {
        mp_powerup_drop( powerup, location, undefined, victim );
    }
}

// Namespace mp_powerups
// Params 1
// Checksum 0x119e1f21, Offset: 0x3e6
// Size: 0x1e5
function get_random_powerup( attacker )
{
    root = powerups::get_powerups_root();
    ranges = [];
    sum = 0;
    
    foreach ( powerup_ref in root.powerup_drop_array )
    {
        info = powerups::get_powerup_info( powerup_ref );
        iszombie = attacker.team == "axis";
        
        if ( istrue( info.var_ea83f93d1d359224 ) != iszombie )
        {
            continue;
        }
        
        chance = info.var_3d01bdd4221215e2 ?? 0;
        chance = getdvarfloat( hashcat( @"hash_c5ce2570868e9b80", powerup_ref ), chance );
        
        if ( chance <= 0 )
        {
            continue;
        }
        
        range = int( 100 * chance );
        ranges[ powerup_ref ] = range;
        sum += range;
    }
    
    if ( sum < 100 )
    {
        ranges[ "none" ] = 100 - sum;
        sum = 100;
    }
    
    var_ddf24b010015c8af = randomintrange( 0, sum );
    var_c4f08400c4885fc5 = "none";
    
    foreach ( powerup_ref, range in ranges )
    {
        var_ddf24b010015c8af -= range;
        
        if ( var_ddf24b010015c8af < 0 )
        {
            var_c4f08400c4885fc5 = powerup_ref;
            break;
        }
    }
    
    return var_c4f08400c4885fc5;
}

// Namespace mp_powerups
// Params 4
// Checksum 0x69a93823, Offset: 0x5d4
// Size: 0x81
function mp_powerup_drop( powerup_ref, spawn_pos, drop_lifetime_override, victim )
{
    if ( isdefined( level.sharedfuncs[ #"powerups" ][ #"hash_8d90986f51e1d851" ] ) )
    {
        shoulddrop = utility::callsharedfunc( #"powerups", #"hash_8d90986f51e1d851", powerup_ref, victim );
        
        if ( !shoulddrop )
        {
            return;
        }
    }
    
    powerups::powerup_drop( powerup_ref, spawn_pos, drop_lifetime_override );
}

// Namespace mp_powerups
// Params 3
// Checksum 0x6f195be2, Offset: 0x65d
// Size: 0x48
function util_give_points( eventstring, points, victim )
{
    if ( !isplayer( self ) || player::isinlaststand( self ) )
    {
        return;
    }
    
    points::doscoreevent( eventstring, undefined, points, undefined, victim, undefined, undefined, undefined, undefined, 1 );
}

// Namespace mp_powerups
// Params 1
// Checksum 0x2c359848, Offset: 0x6ad
// Size: 0x29
function function_4aa1d175b03e7bb2( value )
{
    assert( isplayer( self ), "<dev string:x24>" );
    self.point_scalar = value;
}

