// script_4ab530c3a51adeef  (hash_4ab530c3a51adeef.gscc) (size: 4874 Bytes / 0x130a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xacc044b3 (2898281651)
// size ...... 4874 (0x130a)
// includes .. 5   (offset: 0x12ca)
// strings ... 2   (offset: 0x12f2)
// dev strs .. 0   (offset: 0x130a)
// exports ... 17  (offset: 0xc4a)
// cseg ...... 0x7e + 0xbcc (0xc4a)
// imports ... 31  (offset: 0xef2)
// animtree1 . 0   (offset: 0x130a)
// animtree2 . 0   (offset: 0x130a)
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\utility;
#using scripts\mp\class;
#using scripts\mp\spawncamera;

#namespace specialty_ghost;

// Namespace specialty_ghost
// Params 0, eflags: 0x1
// Checksum 0x2183168a, Offset: 0x9c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_7a14d4d8c2dd5de2 );
}

// Namespace specialty_ghost
// Params 1
// Checksum 0xe0d5e529, Offset: 0xbc
// Size: 0x3a
function function_7a14d4d8c2dd5de2( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_ghost", &setghost, &unsetghost, [] );
    }
}

// Namespace specialty_ghost
// Params 0
// Checksum 0xc8200f1f, Offset: 0xfe
// Size: 0xe3
function setghost()
{
    self.var_8842d6b0a05565d6 = self.var_9842326056fd7207.var_8842d6b0a05565d6 ?? 0;
    self.var_87e24c0db4be12c4 = self.var_9842326056fd7207.var_87e24c0db4be12c4 ?? 3;
    self.var_7d036bca7e3f470e = self.var_9842326056fd7207.var_7d036bca7e3f470e ?? 0;
    self.var_90b2282a508c7f91 = self.var_9842326056fd7207.var_90b2282a508c7f91 ?? 35;
    self.var_da093905786118a2 = self.var_9842326056fd7207.var_da093905786118a2 ?? 2;
    self.var_22699f4bb5bf77db = self.var_9842326056fd7207.var_22699f4bb5bf77db ?? 0;
    self.canghost = 0;
    self.var_9dccbe85eb5980 = 0;
    thread startgpsjammer();
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x716bc7ae, Offset: 0x1e9
// Size: 0x6d
function unsetghost()
{
    self.var_8842d6b0a05565d6 = undefined;
    self.var_87e24c0db4be12c4 = undefined;
    self.var_7d036bca7e3f470e = undefined;
    self.var_90b2282a508c7f91 = undefined;
    self.var_da093905786118a2 = undefined;
    self.var_b3237fbb1b7abd29 = undefined;
    self.var_22699f4bb5bf77db = undefined;
    function_8ad3cee59a419d22( 0 );
    self.var_9dccbe85eb5980 = undefined;
    self setplayeradvanceduavdot( 0 );
    self notify( #"remove_gpsjammer" );
}

// Namespace specialty_ghost
// Params 0
// Checksum 0xcfa1f8a6, Offset: 0x25e
// Size: 0x13b
function startgpsjammer()
{
    self endon( #"remove_gpsjammer" );
    self endon( #"death_or_disconnect" );
    
    if ( isai( self ) && !isbot( self ) )
    {
        function_43f07b5bbe813394( self.avoidkillstreakonspawntimer );
        self.avoidkillstreakonspawntimer = undefined;
    }
    
    if ( level.minspeedsq == 0 )
    {
        return;
    }
    
    assert( level.timeperiod >= 0.05 );
    
    if ( level.timeperiod < 0.05 )
    {
        return;
    }
    
    self.timesincelastweaponfire = 0;
    
    if ( !self.var_22699f4bb5bf77db )
    {
        thread ghostadvanceduavwatcher();
    }
    
    if ( self.var_7d036bca7e3f470e )
    {
        thread function_6fed56c60a34db00( self.var_90b2282a508c7f91 );
    }
    else
    {
        self.canghost = 1;
    }
    
    self.timesincelastweaponfire = 0;
    function_8ad3cee59a419d22( istrue( self.canghost ) );
    
    if ( self.var_22699f4bb5bf77db )
    {
        self function_e8653d9a87fea503( self.canghost );
    }
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( class::isweaponsilenced( objweapon ) )
        {
            continue;
        }
        
        doghostweaponfired();
    }
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x9b7fbde9, Offset: 0x3a1
// Size: 0xf6
function startgpsjammer_allowmovement()
{
    self endon( #"remove_gpsjammer" );
    self endon( #"death_or_disconnect" );
    
    if ( isai( self ) && !isbot( self ) )
    {
        function_43f07b5bbe813394( self.avoidkillstreakonspawntimer );
        self.avoidkillstreakonspawntimer = undefined;
    }
    
    if ( level.minspeedsq == 0 )
    {
        return;
    }
    
    assert( level.timeperiod >= 0.05 );
    
    if ( level.timeperiod < 0.05 )
    {
        return;
    }
    
    self.timesincelastweaponfire = 0;
    
    if ( !self.var_22699f4bb5bf77db )
    {
        thread ghostadvanceduavwatcher();
    }
    
    self.timesincelastweaponfire = 0;
    function_8ad3cee59a419d22( istrue( self.canghost ) );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( class::isweaponsilenced( objweapon ) )
        {
            continue;
        }
        
        doghostweaponfired();
    }
}

// Namespace specialty_ghost
// Params 1
// Checksum 0xa1112666, Offset: 0x49f
// Size: 0x3f
function function_43f07b5bbe813394( killstreaktimer )
{
    delay = killstreaktimer ?? 0;
    
    if ( delay > 0 )
    {
        if ( self.inspawncamera )
        {
            delay += spawncamera::getspawncamerablendtime();
        }
        
        wait delay;
    }
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x439ca8ae, Offset: 0x4e6
// Size: 0xae
function doghostweaponfired()
{
    self endon( #"remove_gpsjammer" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.var_8842d6b0a05565d6 )
    {
        return;
    }
    
    function_8ad3cee59a419d22( 0 );
    thread checkforghostweaponfire();
    var_b78bd3ae582840d0 = self.var_87e24c0db4be12c4;
    
    while ( self.timesincelastweaponfire < var_b78bd3ae582840d0 )
    {
        wait level.timeperiod;
        self.timesincelastweaponfire += level.timeperiod;
    }
    
    self notify( #"ghost_restored" );
    self.timesincelastweaponfire = 0;
    function_8ad3cee59a419d22( self.canghost );
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x6a9d787a, Offset: 0x59c
// Size: 0x49
function checkforghostweaponfire()
{
    self endon( #"death_or_disconnect" );
    self endon( #"remove_gpsjammer" );
    self endon( #"ghost_restored" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        self.timesincelastweaponfire = 0;
    }
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x92f5c3d3, Offset: 0x5ed
// Size: 0x203
function ghostadvanceduavwatcher()
{
    self endon( #"death_or_disconnect" );
    self endon( #"remove_gpsjammer" );
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_2c1306edc77d33bb )
    {
        return;
    }
    
    bundle = level.streakglobals.streakbundles[ "directional_uav" ];
    var_9d01d56c7a3cbe00 = istrue( bundle.var_c354011303a999d9 );
    
    while ( true )
    {
        if ( level.teambased )
        {
            enemyhasauav = function_972e127f16af366b();
            
            if ( enemyhasauav )
            {
                self setplayeradvanceduavdot( !var_9d01d56c7a3cbe00 );
                self setplayerghost( 0 );
                
                while ( enemyhasauav )
                {
                    waitframe();
                    enemyhasauav = function_972e127f16af366b();
                }
                
                self setplayerghost( self.canghost );
                self setplayeradvanceduavdot( !self.canghost );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( player == self )
                {
                    continue;
                }
                
                if ( level.activeadvanceduavs[ player.guid ] && level.activeadvanceduavs[ player.guid ] > 0 )
                {
                    self setplayeradvanceduavdot( 1 );
                    self setplayerghost( 0 );
                    
                    while ( level.activeadvanceduavs[ player.guid ] && level.activeadvanceduavs[ player.guid ] > 0 )
                    {
                        level waittill( #"uav_update" );
                    }
                    
                    self setplayerghost( self.canghost );
                    self setplayeradvanceduavdot( !self.canghost );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x7c8e911c, Offset: 0x7f8
// Size: 0xd9
function function_972e127f16af366b()
{
    if ( level.var_f3d1cde89907a07a )
    {
        var_3ee9dcfa6415803a = 0;
        
        foreach ( squadindex, squadarray in level.squaddata[ self.team ] )
        {
            var_3ee9dcfa6415803a += level.activeadvanceduavs[ squadindex ];
        }
        
        return ( level.activeadvanceduavcount - var_3ee9dcfa6415803a > 0 );
    }
    
    return level.activeadvanceduavcount - ( level.activeadvanceduavs[ self.team ] ?? 0 ) > 0;
}

// Namespace specialty_ghost
// Params 1
// Checksum 0xd46b5ea3, Offset: 0x8d9
// Size: 0xf3
function function_6fed56c60a34db00( minspeed )
{
    self endon( #"death_or_disconnect" );
    self endon( #"remove_gpsjammer" );
    self.canghost = istrue( self.canghost );
    
    while ( true )
    {
        laststatus = self.canghost;
        
        if ( self.var_82e5268591e32cb2 )
        {
            self.canghost = 1;
        }
        else if ( self.forceghost.size )
        {
            self.canghost = 1;
        }
        else
        {
            self.canghost = function_d0626438f82f8443( minspeed );
        }
        
        if ( !level.gametypebundle.var_2c1306edc77d33bb && !self.var_22699f4bb5bf77db && function_b8987d13aaa62a17() )
        {
            self.canghost = 0;
        }
        
        if ( laststatus != self.canghost )
        {
            function_8ad3cee59a419d22( self.canghost );
        }
        
        waitframe();
    }
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x472eaf7b, Offset: 0x9d4
// Size: 0x57, Type: bool
function function_b8987d13aaa62a17()
{
    key = level.teambased ? self.team : self.guid;
    var_8b6b00b5a3da1a4b = level.activeadvanceduavs[ key ] ?? 0;
    return level.activeadvanceduavcount - var_8b6b00b5a3da1a4b > 0;
}

// Namespace specialty_ghost
// Params 1
// Checksum 0xf054a4e3, Offset: 0xa34
// Size: 0xcc, Type: bool
function function_d0626438f82f8443( minspeed )
{
    var_9edbd654b8505573 = lengthsquared( self getvelocity() ) >= squared( minspeed );
    
    if ( var_9edbd654b8505573 )
    {
        self.var_b3237fbb1b7abd29 = undefined;
        return true;
    }
    
    if ( self.isdefusing )
    {
        return true;
    }
    
    if ( self.isplanting )
    {
        return true;
    }
    
    if ( isdefined( self.vehicle_controlling ) && isdefined( self.vehicle_controlling.streakinfo ) )
    {
        return true;
    }
    
    if ( utility::isusingremote() )
    {
        return true;
    }
    
    if ( !isdefined( self.var_b3237fbb1b7abd29 ) )
    {
        self.var_b3237fbb1b7abd29 = gettime() + self.var_da093905786118a2 * 1000;
        return true;
    }
    
    if ( gettime() < self.var_b3237fbb1b7abd29 )
    {
        return true;
    }
    
    return false;
}

// Namespace specialty_ghost
// Params 0
// Checksum 0x88006749, Offset: 0xb09
// Size: 0x2a
function removegpsjammer()
{
    self notify( #"remove_gpsjammer" );
    function_8ad3cee59a419d22( 0 );
    
    if ( !self.var_22699f4bb5bf77db )
    {
        self setplayeradvanceduavdot( 0 );
    }
}

// Namespace specialty_ghost
// Params 1
// Checksum 0x84694a5e, Offset: 0xb3b
// Size: 0x10f
function function_8ad3cee59a419d22( isghost )
{
    if ( isdefined( self.var_9dccbe85eb5980 ) && isghost != self.var_9dccbe85eb5980 )
    {
        self.var_9dccbe85eb5980 = isghost;
        
        if ( isghost )
        {
            status_tracking::function_820d05797324eca0( self, #"ghost_active" );
            
            if ( self.var_22699f4bb5bf77db )
            {
                status_tracking::function_820d05797324eca0( self, #"hash_869fbc9948ce756a" );
            }
        }
        else
        {
            status_tracking::function_646b346a2f15596c( self, #"ghost_active" );
            
            if ( self.var_22699f4bb5bf77db )
            {
                status_tracking::function_646b346a2f15596c( self, #"hash_869fbc9948ce756a" );
            }
        }
        
        params = { #player:self };
        level callback::callback( isghost ? #"hash_c0e3f7df1c23e95f" : #"hash_d74170bd7751a308", params );
    }
    
    self setplayerghost( isghost );
    
    if ( self.var_22699f4bb5bf77db )
    {
        self function_e8653d9a87fea503( isghost );
        return;
    }
    
    if ( level.gametypebundle.var_2c1306edc77d33bb )
    {
        self setplayeradvanceduavdot( isghost );
    }
}

