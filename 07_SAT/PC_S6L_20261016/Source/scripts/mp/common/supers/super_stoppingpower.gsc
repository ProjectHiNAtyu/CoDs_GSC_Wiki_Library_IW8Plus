// scripts\mp\common\supers\super_stoppingpower.gsc  (hash_14c5c910bc1abffc.gscc) (size: 7235 Bytes / 0x1c43 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed71fb22 (3983670050)
// size ...... 7235 (0x1c43)
// includes .. 11  (offset: 0x1af7)
// strings ... 14  (offset: 0x1b4f)
// dev strs .. 1   (offset: 0x1c37)
// exports ... 24  (offset: 0xec7)
// cseg ...... 0x15a + 0xd6d (0xec7)
// imports ... 73  (offset: 0x1287)
// animtree1 . 0   (offset: 0x1c43)
// animtree2 . 0   (offset: 0x1c43)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\common\utility\callback_group;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace super_stoppingpower;

// Namespace super_stoppingpower
// Params 0
// Checksum 0x372e52bc, Offset: 0x178
// Size: 0x4c
function stoppingpower_init()
{
    level.onweapondropcreated callback_group::callback_subscribe( &stoppingpower_onweaponcreated, level );
    level.onweapondroppickedup callback_group::callback_subscribe( &stoppingpower_onweaponpickedup, level );
    utility::registersharedfunc( #"super_stoppingpower", #"hash_7dff8b8d09af9e50", &stoppingpower_onkill );
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0x5f7fe2c, Offset: 0x1cc
// Size: 0x32b, Type: bool
function stoppingpower_beginuse()
{
    playerweaponobj = self.lastnormalweaponobj;
    var_aeef81b700291007 = nullweapon();
    
    if ( weapon::ismeleeonly( playerweaponobj ) || weapon::issuperweapon( playerweaponobj ) || weapon::iskillstreakweapon( playerweaponobj ) || weapon::isgamemodeweapon( playerweaponobj ) || weapon::issinglehitweapon( playerweaponobj.basename ) || !stoppingpower_isvalidprimaryoralt( playerweaponobj ) || weapon::isfistweapon( playerweaponobj ) )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/support_box_incompat" );
        }
        
        return false;
    }
    
    result = stoppingpower_cancelreload();
    
    if ( !result )
    {
        return false;
    }
    
    if ( self isalternatemode( playerweaponobj ) )
    {
        var_aeef81b700291007 = playerweaponobj;
        playerweaponobj = playerweaponobj getnoaltweapon();
    }
    else
    {
        var_aeef81b700291007 = playerweaponobj getaltweapon();
    }
    
    var_f3f1ae1911b3c3c6 = [];
    stockammo = 0;
    excessammo = 0;
    
    if ( !isnullweapon( var_aeef81b700291007 ) )
    {
        var_f3f1ae1911b3c3c6[ var_f3f1ae1911b3c3c6.size ] = var_aeef81b700291007;
    }
    
    var_f3f1ae1911b3c3c6[ var_f3f1ae1911b3c3c6.size ] = playerweaponobj;
    
    foreach ( weaponobj in var_f3f1ae1911b3c3c6 )
    {
        isakimbo = 0;
        
        if ( weaponobj.isdualwield )
        {
            isakimbo = 1;
        }
        
        if ( issameweapon( weaponobj, playerweaponobj, 0 ) )
        {
            clipammo = weapons::getammooverride( weaponobj );
            var_92085bb6f20e2f11 = clipammo * 1;
            
            if ( isakimbo )
            {
                var_92085bb6f20e2f11 *= 2;
            }
            
            thread stoppingpower_givehcr( self, weaponobj, var_92085bb6f20e2f11 );
            
            if ( true )
            {
                if ( isakimbo )
                {
                    clipammo = self getweaponammoclip( weaponobj, "left" ) + self getweaponammoclip( weaponobj, "right" );
                    stockammo = self getweaponammostock( weaponobj );
                    oldammo = clipammo + stockammo;
                    newammo = int( min( weaponmaxammo( weaponobj ), oldammo + var_92085bb6f20e2f11 ) );
                    self setweaponammostock( weaponobj, newammo );
                    self setweaponammoclip( weaponobj, 0, "left" );
                    self setweaponammoclip( weaponobj, 0, "right" );
                    continue;
                }
                
                clipammo = self getweaponammoclip( weaponobj );
                stockammo = self getweaponammostock( weaponobj );
                oldammo = clipammo + stockammo;
                maxammo = weaponmaxammo( weaponobj );
                totalammo = oldammo + var_92085bb6f20e2f11;
                excessammo = int( totalammo - maxammo );
                newstockammo = int( min( maxammo, totalammo ) );
                self setweaponammoclip( weaponobj, 0 );
                
                if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
                {
                    stockdifference = newstockammo - stockammo;
                    item_ammo::function_46e5ccf39665fcf4( weaponobj, 0, 0, 0, stockdifference );
                    continue;
                }
                
                self setweaponammostock( weaponobj, newstockammo );
            }
        }
    }
    
    thread stoppingpower_waitforreload( playerweaponobj, stockammo, excessammo );
    return true;
}

// Namespace super_stoppingpower
// Params 1
// Checksum 0x64d5a21a, Offset: 0x500
// Size: 0x3a
function stoppingpower_isvalidprimaryoralt( objweapon )
{
    if ( !self isalternatemode( objweapon ) )
    {
        return 1;
    }
    
    underbarrel = objweapon.underbarrel;
    return weapons::isattachmentselectfire( objweapon, underbarrel );
}

// Namespace super_stoppingpower
// Params 3
// Checksum 0x7a870d02, Offset: 0x543
// Size: 0xbf
function stoppingpower_waitforreload( weaponobj, stockammo, excessammo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( self getcurrentprimaryweapon() != weaponobj )
        {
            break;
        }
        
        currentammo = self getweaponammoclip( weaponobj );
        
        if ( currentammo > 0 )
        {
            thread hud_message::showsplash( "stopping_power_loaded" );
            
            if ( excessammo > 0 )
            {
                self setweaponammostock( weaponobj, stockammo + excessammo );
            }
            
            break;
        }
        
        waitframe();
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]();
    }
}

// Namespace super_stoppingpower
// Params 3
// Checksum 0x11e0888f, Offset: 0x60a
// Size: 0x7c
function stoppingpower_givehcr( player, objweapon, numrounds )
{
    hcrdata = spawnstruct();
    hcrdata.player = player;
    hcrdata.objweapon = objweapon;
    hcrdata.rounds = numrounds;
    hcrdata.gavehcr = 0;
    hcrdata.kills = 0;
    stoppingpower_givehcrdata( player, hcrdata );
}

// Namespace super_stoppingpower
// Params 2
// Checksum 0x3ba62bae, Offset: 0x68e
// Size: 0xc3
function stoppingpower_givehcrdata( player, hcrdata )
{
    if ( !isdefined( player.hcrdata ) )
    {
        player.hcrdata = [];
    }
    
    id = weapon::getcompleteweaponnamenoalt( hcrdata.objweapon );
    var_46cd1686bf7f9f1c = player.hcrdata[ id ];
    
    if ( isdefined( var_46cd1686bf7f9f1c ) )
    {
        var_46cd1686bf7f9f1c thread stoppingpower_removehcr();
    }
    
    player.hcrdata[ id ] = hcrdata;
    hcrdata thread stoppingpower_clearhcrondeath();
    hcrdata thread stoppingpower_clearhcrongameended();
    hcrdata thread stoppingpower_clearhcronperkscleared();
    hcrdata thread stoppingpower_givefastreload();
    player thread stoppingpower_breaksprint();
    hcrdata thread stoppingpower_watchhcrweaponchange();
    hcrdata thread stoppingpower_watchhcrweaponfire();
}

// Namespace super_stoppingpower
// Params 3
// Checksum 0x592777ee, Offset: 0x759
// Size: 0x4f
function stoppingpower_onweaponcreated( weaponentity, droppingplayer, weaponobj )
{
    if ( !( isdefined( weaponentity ) && isdefined( droppingplayer ) ) )
    {
        return;
    }
    
    hcrdata = droppingplayer stoppingpower_getweaponhcrdata( weaponobj );
    weaponentity.hcrdata = hcrdata;
}

// Namespace super_stoppingpower
// Params 3
// Checksum 0x40989cb2, Offset: 0x7b0
// Size: 0x78
function stoppingpower_onweaponpickedup( weaponentity, var_5b2075a06ef16da1, weaponobj )
{
    if ( !isdefined( weaponentity.hcrdata ) )
    {
        return;
    }
    
    hcrdata = weaponentity.hcrdata;
    hcrdata.player = var_5b2075a06ef16da1;
    hcrdata.gavehcr = 0;
    hcrdata.kills = 0;
    stoppingpower_givehcrdata( var_5b2075a06ef16da1, hcrdata );
}

// Namespace super_stoppingpower
// Params 1
// Checksum 0x76eeaf45, Offset: 0x830
// Size: 0x43
function stoppingpower_getweaponhcrdata( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return;
    }
    
    if ( !isdefined( self.hcrdata ) )
    {
        return;
    }
    
    id = weapon::getcompleteweaponnamenoalt( objweapon );
    return self.hcrdata[ id ];
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0xb04c702a, Offset: 0x87c
// Size: 0x1c, Type: bool
function stoppingpower_cancelreload()
{
    self endon( #"death_or_disconnect" );
    self cancelreload();
    wait 0.05;
    return true;
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0x2d60caf8, Offset: 0x8a1
// Size: 0xcb
function stoppingpower_watchhcrweaponchange()
{
    self endon( #"stoppingPower_removeHCR" );
    self.player endon( #"disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        if ( stoppingpower_ishcrweapon( self.player getcurrentweapon() ) )
        {
            if ( !self.gavehcr )
            {
                self.player perk::giveperk( "specialty_bulletdamage" );
                self.gavehcr = 1;
            }
        }
        else if ( self.gavehcr )
        {
            self.player perk::removeperk( "specialty_bulletdamage" );
            self.gavehcr = 0;
        }
        
        self.player waittill( #"weapon_change" );
    }
    
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0xfcc93ebf, Offset: 0x974
// Size: 0xa5
function stoppingpower_watchhcrweaponfire()
{
    self endon( #"stoppingPower_removeHCR" );
    self.player endon( #"disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        self.player waittill( #"weapon_fired", objweapon );
        
        if ( stoppingpower_ishcrweapon( objweapon ) )
        {
            self.rounds--;
            
            if ( self.rounds <= 0 )
            {
                break;
            }
        }
    }
    
    self.player thread stoppingpower_tracklastcrossbowshot( self.objweapon );
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower
// Params 1
// Checksum 0x1430cbfe, Offset: 0xa21
// Size: 0x67
function stoppingpower_tracklastcrossbowshot( objweapon )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    rootname = weapon::getweaponrootname( objweapon );
    
    if ( rootname != "iw9_dm_crossbow" )
    {
        return;
    }
    
    self.lastcrossbowhadstoppingpower = 1;
    utility::waittill_any_timeout_no_endon_death( 2, "weapon_fired", "weapon_change" );
    self.lastcrossbowhadstoppingpower = undefined;
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0xaae30a84, Offset: 0xa90
// Size: 0x43
function stoppingpower_removehcr()
{
    self notify( #"stoppingPower_removeHCR" );
    
    if ( isdefined( self.player ) )
    {
        if ( self.gavehcr )
        {
            self.player perk::removeperk( "specialty_bulletdamage" );
        }
        
        stoppingpower_clearhcrdata();
    }
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0xf9638064, Offset: 0xadb
// Size: 0x22
function stoppingpower_loadoutchangeremovehcr()
{
    self notify( #"stoppingPower_removeHCR" );
    
    if ( isdefined( self.player ) )
    {
        stoppingpower_clearhcrdata();
    }
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0xe9363b7b, Offset: 0xb05
// Size: 0xae
function stoppingpower_clearhcrdata()
{
    if ( isdefined( self.player.hcrdata ) )
    {
        id = weapon::getcompleteweaponnamenoalt( self.objweapon );
        hcrdata = self.player.hcrdata[ id ];
        
        if ( hcrdata == self )
        {
            self.player.hcrdata[ id ] = undefined;
        }
        
        analyticslog::logevent_fieldupgradeexpired( self.player, level.superglobals.staticsuperdata[ "super_support_box" ].id, self.kills, 0 );
    }
}

// Namespace super_stoppingpower
// Params 1
// Checksum 0x961fcee2, Offset: 0xbbb
// Size: 0x12c
function stoppingpower_onkill( weaponobj )
{
    if ( isdefined( weaponobj ) )
    {
        id = weapon::getcompleteweaponnamenoalt( weaponobj );
        hcrdata = self.hcrdata[ id ];
        
        if ( isdefined( hcrdata ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "stoppingPowerKills" ] ) )
                {
                    self.leaderboarddata[ "stoppingPowerKills" ] = self.leaderboarddata[ "stoppingPowerKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "stoppingPowerKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "stoppingPowerKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( self.pers[ "stoppingPowerKills" ] ) )
                {
                    self.pers[ "stoppingPowerKills" ] = self.pers[ "stoppingPowerKills" ] + 1;
                }
            }
            
            supers_mp::combatrecordsuperkill( "super_support_box" );
            hcrdata.kills++;
        }
    }
}

// Namespace super_stoppingpower
// Params 1
// Checksum 0x5dc62431, Offset: 0xcef
// Size: 0x6c, Type: bool
function stoppingpower_ishcrweapon( objweapon )
{
    var_a3ccb179538bed79 = self.player getammotype( self.objweapon );
    currentammotype = self.player getammotype( objweapon );
    var_e1503b1c0e5d6a3c = var_a3ccb179538bed79 == currentammotype;
    return issameweapon( objweapon, self.objweapon, 1 ) && var_e1503b1c0e5d6a3c;
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0x7ed660c1, Offset: 0xd64
// Size: 0x3e
function stoppingpower_clearhcrondeath()
{
    self.player endon( #"disconnect" );
    self endon( #"stoppingPower_removeHCR" );
    self.player waittill( #"death" );
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0x12d58116, Offset: 0xdaa
// Size: 0x36
function stoppingpower_clearhcrongameended()
{
    self.player endon( #"disconnect" );
    self endon( #"stoppingPower_removeHCR" );
    level waittill( #"game_ended" );
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0x4e4f1d7c, Offset: 0xde8
// Size: 0x3e
function stoppingpower_clearhcronperkscleared()
{
    self.player endon( #"disconnect" );
    self endon( #"stoppingPower_removeHCR" );
    self.player waittill( #"hash_acbc7ab957079995" );
    thread stoppingpower_loadoutchangeremovehcr();
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0x94ee49a3, Offset: 0xe2e
// Size: 0x5f
function stoppingpower_givefastreload()
{
    self.player endon( #"death_or_disconnect" );
    self.player perk::giveperk( "specialty_fastreload" );
    self.player utility::waittill_any( "weapon_fired", "weapon_change", "stoppingPower_removeHCR" );
    self.player perk::removeperk( "specialty_fastreload" );
}

// Namespace super_stoppingpower
// Params 0
// Checksum 0xbf7e2217, Offset: 0xe95
// Size: 0x32
function stoppingpower_breaksprint()
{
    self endon( #"death_or_disconnect" );
    val::set( "stoppingPower", "sprint", 0 );
    wait 0.4;
    val::reset_all( "stoppingPower" );
}

