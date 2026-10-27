// scripts\mp\common\powerups\full_power.gsc  (hash_2c27c1fb96593ffd.gscc) (size: 1981 Bytes / 0x7bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4f4ba2a (3572808234)
// size ...... 1981 (0x7bd)
// includes .. 5   (offset: 0x77d)
// strings ... 2   (offset: 0x7a5)
// dev strs .. 0   (offset: 0x7bd)
// exports ... 7   (offset: 0x3b5)
// cseg ...... 0x8c + 0x329 (0x3b5)
// imports ... 24  (offset: 0x4cd)
// animtree1 . 0   (offset: 0x7bd)
// animtree2 . 0   (offset: 0x7bd)
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\common\powerups\powerups;
#using scripts\mp\supers;

#namespace full_power;

// Namespace full_power
// Params 0, eflags: 0x1
// Checksum 0xc95fbb4e, Offset: 0xaa
// Size: 0x9
function autoexec main()
{
    init_full_power();
}

// Namespace full_power
// Params 0
// Checksum 0x31c8557d, Offset: 0xbb
// Size: 0x36
function init_full_power()
{
    powerups::register_powerup( "full_power", &grab_full_power, &function_3dd5ed51bfe6be58 );
    utility::registersharedfunc( #"full_power", #"hash_cee7fddde600119a", &function_21f8005dcd5af7f9 );
}

// Namespace full_power
// Params 0
// Checksum 0xff8d344a, Offset: 0xf9
// Size: 0x12, Type: bool
function function_3dd5ed51bfe6be58()
{
    if ( level.b_field_upgrade_used )
    {
        return true;
    }
    
    return false;
}

// Namespace full_power
// Params 2
// Checksum 0xe9ba2ff1, Offset: 0x114
// Size: 0xaf
function grab_full_power( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player function_21f8005dcd5af7f9();
        player thread powerups_cpmp::function_52318afc13635e7c( str_powerup );
    }
    
    level notify( #"hash_1254b8d07b365821" );
}

// Namespace full_power
// Params 0
// Checksum 0xa90de0b7, Offset: 0x1cb
// Size: 0x1a5
function function_21f8005dcd5af7f9()
{
    var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
    
    if ( !isalive( self ) || !isdefined( var_c0c4324d255baab3 ) )
    {
        return;
    }
    
    if ( isdefined( var_c0c4324d255baab3 ) && var_c0c4324d255baab3.isinuse )
    {
        if ( !callback::exists( #"on_super_use_finished", &on_super_use_finished ) )
        {
            callback::add( #"on_super_use_finished", &on_super_use_finished );
        }
        
        return;
    }
    
    var_d532e397ecea6843 = 0;
    b_super_ready = supers_mp::issuperready();
    
    if ( !b_super_ready )
    {
        var_3923f56bd3e748e9 = supers_mp::getsuperpointsneeded();
        var_d532e397ecea6843 = var_3923f56bd3e748e9 - supers_mp::getcurrentsuperpoints();
    }
    
    if ( isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        var_ec53cb5847b1149b = supers_mp::function_7dcdfecb3848b30e();
        
        if ( b_super_ready && !var_ec53cb5847b1149b )
        {
            var_3923f56bd3e748e9 = supers_mp::getsuperpointsneeded();
            var_d532e397ecea6843 = var_3923f56bd3e748e9 - self.overclockcharge;
        }
    }
    
    if ( var_d532e397ecea6843 != 0 )
    {
        superpointsmod = level.var_8a3e2af27738ffdc[ var_c0c4324d255baab3.staticdata.ref ] ?? level.superpointsmod;
        points_needed_scaled = ceil( var_d532e397ecea6843 / superpointsmod );
        supers_mp::givesuperpoints( points_needed_scaled, undefined, 1 );
    }
    
    if ( isdefined( self.var_6b07486215a175b0 ) && isdefined( level.var_d8c17916fed09937 ) )
    {
        var_bdbce0670f93e9a8 = level.var_d8c17916fed09937 * getdvarfloat( @"hash_ff34d3b7eb7fbab1", 1 );
        
        if ( self.var_6b07486215a175b0 >= var_bdbce0670f93e9a8 )
        {
            self.var_6b07486215a175b0 -= var_bdbce0670f93e9a8;
        }
    }
}

// Namespace full_power
// Params 1, eflags: 0x4
// Checksum 0x4cd4a7cf, Offset: 0x378
// Size: 0x3d
function private on_super_use_finished( params )
{
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( isalive( self ) )
    {
        function_21f8005dcd5af7f9();
        callback::remove( #"on_super_use_finished", &on_super_use_finished );
    }
}

