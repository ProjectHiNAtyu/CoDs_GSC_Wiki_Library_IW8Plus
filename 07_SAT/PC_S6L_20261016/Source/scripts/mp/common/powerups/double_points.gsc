// scripts\mp\common\powerups\double_points.gsc  (hash_32241913730f2c41.gscc) (size: 1308 Bytes / 0x51c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1e51f9d (3521453981)
// size ...... 1308 (0x51c)
// includes .. 3   (offset: 0x4d8)
// strings ... 3   (offset: 0x4f0)
// dev strs .. 0   (offset: 0x51c)
// exports ... 5   (offset: 0x2bc)
// cseg ...... 0x87 + 0x235 (0x2bc)
// imports ... 12  (offset: 0x384)
// animtree1 . 0   (offset: 0x51c)
// animtree2 . 0   (offset: 0x51c)
#using script_16ea1b94f0f381b3;
#using scripts\common\powerups;
#using scripts\common\utility;

#namespace double_points;

// Namespace double_points
// Params 0, eflags: 0x1
// Checksum 0xc5dc8ca6, Offset: 0xa5
// Size: 0x1b
function autoexec main()
{
    if ( getdvarint( @"scr_disable_powerup_double_points", 0 ) )
    {
        return;
    }
    
    init_double_points();
}

// Namespace double_points
// Params 1
// Checksum 0xc1bb69d9, Offset: 0xc8
// Size: 0x1d
function init_double_points( var_a53a6962d153065f )
{
    powerups::register_powerup( "double_points", &function_d80cb3ffd639de42 );
}

// Namespace double_points
// Params 2
// Checksum 0xc77338de, Offset: 0xed
// Size: 0xf9
function function_d80cb3ffd639de42( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    root = powerups::get_powerups_root();
    n_lifetime = root.powerups[ "double_points" ].var_3f03b937c69044df;
    
    if ( isdefined( level.powerup_timeout_override ) )
    {
        n_lifetime = self [[ level.powerup_timeout_override ]]( n_lifetime );
    }
    
    foreach ( player in a_players )
    {
        player thread set_double_points( n_lifetime, root );
    }
    
    level notify( #"hash_41412e7e2e973e85" );
}

// Namespace double_points
// Params 2
// Checksum 0x4a8f1fc9, Offset: 0x1ee
// Size: 0xce
function set_double_points( n_lifetime, root )
{
    self notify( #"hash_511081e0254ffbe6" );
    self endon( #"hash_511081e0254ffbe6" );
    scalar = getdvarfloat( @"hash_f4f08198433d1d4d", 2 );
    self [[ root.var_a53a6962d153065f ]]( scalar );
    utility::callsharedfunc( #"powerup_double_points", #"apply_effect" );
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "double_points", n_lifetime );
    utility::waittill_any_timeout( n_lifetime, "end_double_points", "death" );
    
    if ( isdefined( self ) )
    {
        self [[ root.var_a53a6962d153065f ]]( 1 );
        utility::callsharedfunc( #"powerup_double_points", #"remove_effect" );
        self notify( #"hash_ac5614462d6f7a81" );
    }
}

