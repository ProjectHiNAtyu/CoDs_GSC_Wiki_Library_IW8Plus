// scripts\mp\zm\systems\killstreaks\zm_remove_ammo.gsc  (hash_65707ab1eaead838.gscc) (size: 4306 Bytes / 0x10d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2faf78d (3539662733)
// size ...... 4306 (0x10d2)
// includes .. 10  (offset: 0xf9a)
// strings ... 6   (offset: 0xfea)
// dev strs .. 8   (offset: 0x106a)
// exports ... 10  (offset: 0x902)
// cseg ...... 0xe1 + 0x821 (0x902)
// imports ... 42  (offset: 0xa92)
// animtree1 . 0   (offset: 0x10d2)
// animtree2 . 0   (offset: 0x10d2)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\supers;

#namespace zm_remove_ammo;

// Namespace zm_remove_ammo
// Params 0, eflags: 0x1
// Checksum 0x19635e89, Offset: 0xff
// Size: 0x5b
function autoexec main()
{
    system::function_eca4bddb3f37e51b();
    
    if ( !powerups::function_66b5c6704004966d( "remove_ammo" ) )
    {
        return;
    }
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e>", "<dev string:x55>", &devgui_remove_ammo );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6e>", "<dev string:x93>", &devgui_remove_ammo );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace zm_remove_ammo
    // Params 1
    // Checksum 0x10da0e62, Offset: 0x162
    // Size: 0xc2, Type: dev
    function devgui_remove_ammo( params )
    {
        foreach ( player in level.players )
        {
            if ( player.team == params[ 0 ] )
            {
                player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "<dev string:xaa>", powerups::function_f379817a62e3850c( "<dev string:xaa>", 1 ) );
                player thread drain_ammo( powerups::function_f379817a62e3850c( "<dev string:xaa>", 1 ) );
            }
        }
    }

#/

// Namespace zm_remove_ammo
// Params 1
// Checksum 0x1fa7ab82, Offset: 0x22c
// Size: 0x10b, Type: bool
function function_250ddcd667f0f04b( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "remove_ammo" ];
    streakinfo.weaponname = bundle.deployweaponname;
    deployweaponobj = makeweapon( bundle.deployweaponname );
    deployresult = 1;
    
    if ( !isdefined( streakinfo.var_3343592587469cb5 ) )
    {
        deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweaponobj, 0 );
    }
    
    function_baec4ab33b232829( streakinfo );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    return true;
}

// Namespace zm_remove_ammo
// Params 0
// Checksum 0x17e82300, Offset: 0x340
// Size: 0x35
function function_8e36ab348c76f469()
{
    assert( isplayer( self ), "<dev string:xb6>" );
    streakinfo = killstreak_utility::createstreakinfo( "remove_ammo", self );
    thread function_baec4ab33b232829( streakinfo );
}

// Namespace zm_remove_ammo
// Params 1, eflags: 0x4
// Checksum 0xa806e88f, Offset: 0x37d
// Size: 0xd7
function private function_baec4ab33b232829( streakinfo )
{
    assert( isplayer( self ), "<dev string:xf2>" );
    
    foreach ( player in level.players )
    {
        if ( player.team != self.team )
        {
            player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "remove_ammo", powerups::function_f379817a62e3850c( "remove_ammo", 1 ) );
            player thread drain_ammo( powerups::function_f379817a62e3850c( "remove_ammo", 1 ) );
        }
    }
}

// Namespace zm_remove_ammo
// Params 1
// Checksum 0x9698876f, Offset: 0x45c
// Size: 0x374
function drain_ammo( n_lifetime )
{
    self notify( #"hash_f07625a3ec3532f9" );
    self endon( #"hash_f07625a3ec3532f9" );
    self endon( #"death", #"hash_3d68648f8d460626" );
    n_start_time = gettime();
    
    if ( !isdefined( n_lifetime ) )
    {
        n_lifetime = powerups::function_f379817a62e3850c( "remove_ammo", 1 );
    }
    
    while ( isalive( self ) && n_start_time + n_lifetime * 1000 > gettime() )
    {
        primaryweapons = self.primaryweapons;
        currentprimaryweapon = self.currentprimaryweapon;
        
        if ( currentprimaryweapon.ismelee )
        {
            function_ce51e5b5af4619b0( 0 );
        }
        
        var_97ed0f9a10cee08d = 0;
        
        foreach ( weapon in primaryweapons )
        {
            var_efe292aab202dd44 = self getweaponammostock( weapon );
            
            if ( var_efe292aab202dd44 > 0 && !issubstr( weapon.magazine, "beltfed" ) )
            {
                var_97ed0f9a10cee08d = 1;
                self setweaponammostock( weapon, var_efe292aab202dd44 - 1 );
                
                if ( weapon == currentprimaryweapon )
                {
                    function_ce51e5b5af4619b0( 2 );
                }
                
                continue;
            }
            
            var_3bb181f15a404e4e = self getweaponammoclip( weapon );
            
            if ( var_3bb181f15a404e4e > 0 )
            {
                var_97ed0f9a10cee08d = 1;
                self setweaponammoclip( weapon, var_3bb181f15a404e4e - 1 );
                
                if ( weapon == currentprimaryweapon )
                {
                    function_ce51e5b5af4619b0( 1 );
                }
                
                continue;
            }
            
            if ( weapon::isakimbo( weapon ) )
            {
                n_clip_ammo_lh = self getweaponammoclip( weapon, "left" );
                
                if ( n_clip_ammo_lh > 0 )
                {
                    var_97ed0f9a10cee08d = 1;
                    self setweaponammoclip( weapon, n_clip_ammo_lh - 1, "left" );
                    
                    if ( weapon == currentprimaryweapon )
                    {
                        function_ce51e5b5af4619b0( 1 );
                    }
                    
                    continue;
                }
            }
            
            if ( weapon.hasalternate )
            {
                weaponaltobj = weapon getaltweapon();
                n_stock_ammo_alt = self getweaponammostock( weaponaltobj );
                
                if ( n_stock_ammo_alt > 0 )
                {
                    var_97ed0f9a10cee08d = 1;
                    self setweaponammostock( weaponaltobj, n_stock_ammo_alt - 1 );
                    
                    if ( weaponaltobj == currentprimaryweapon )
                    {
                        function_ce51e5b5af4619b0( 2 );
                    }
                    
                    continue;
                }
                
                n_clip_ammo_alt = self getweaponammoclip( weaponaltobj );
                
                if ( n_clip_ammo_alt > 0 )
                {
                    var_97ed0f9a10cee08d = 1;
                    self setweaponammoclip( weaponaltobj, n_clip_ammo_alt - 1 );
                    
                    if ( weaponaltobj == currentprimaryweapon )
                    {
                        function_ce51e5b5af4619b0( 1 );
                    }
                    
                    continue;
                }
            }
            
            if ( weapon == currentprimaryweapon )
            {
                function_ce51e5b5af4619b0( 0 );
            }
        }
        
        var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
        
        if ( isdefined( var_c0c4324d255baab3 ) && !var_c0c4324d255baab3.isinuse && !var_97ed0f9a10cee08d && var_c0c4324d255baab3.basepoints > 0 )
        {
            n_base_points = var_c0c4324d255baab3.basepoints;
            var_d3a02e794369ceb7 = self.overclockcharge;
            
            if ( isdefined( var_d3a02e794369ceb7 ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) && var_d3a02e794369ceb7 > 0 )
            {
                supers_mp::function_1f9b6b3c1d1f1404( 0 );
            }
            
            if ( n_base_points > 0 )
            {
                if ( n_base_points >= supers_mp::getsuperpointsneeded( var_c0c4324d255baab3 ) )
                {
                    perkpackage::perkpackage_reset();
                }
                
                supers_mp::setsuperbasepoints( n_base_points - 1 );
            }
        }
        
        wait 0.1;
    }
    
    function_ce51e5b5af4619b0( 0 );
}

// Namespace zm_remove_ammo
// Params 0
// Checksum 0x37d7d0ee, Offset: 0x7d8
// Size: 0x16
function function_f7994094f16988c2()
{
    self notify( #"hash_3d68648f8d460626" );
    function_ce51e5b5af4619b0( 0 );
}

// Namespace zm_remove_ammo
// Params 1, eflags: 0x4
// Checksum 0x4070c913, Offset: 0x7f6
// Size: 0xd5
function private function_ce51e5b5af4619b0( ammo_drain = 0 )
{
    if ( !isdefined( self.ui_ammo_drain ) )
    {
        self.ui_ammo_drain = 0;
    }
    
    if ( ammo_drain == self.ui_ammo_drain )
    {
        return;
    }
    
    switch ( ammo_drain )
    {
        case 0:
            self setclientomnvar( "ui_zm_clip_ammo_loss_enabled", 0 );
            self setclientomnvar( "ui_zm_stock_ammo_loss_enabled", 0 );
            break;
        case 1:
            self setclientomnvar( "ui_zm_clip_ammo_loss_enabled", 1 );
            self setclientomnvar( "ui_zm_stock_ammo_loss_enabled", 0 );
            break;
        case 2:
            self setclientomnvar( "ui_zm_clip_ammo_loss_enabled", 0 );
            self setclientomnvar( "ui_zm_stock_ammo_loss_enabled", 1 );
            break;
        default:
            break;
    }
    
    self.ui_ammo_drain = ammo_drain;
}

// Namespace zm_remove_ammo
// Params 0
// Checksum 0x990aeb12, Offset: 0x8d3
// Size: 0x2f
function function_d1754b54f23f42ce()
{
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "remove_ammo", powerups::function_f379817a62e3850c( "remove_ammo", 1 ) );
    thread drain_ammo( powerups::function_f379817a62e3850c( "remove_ammo", 1 ) );
}

