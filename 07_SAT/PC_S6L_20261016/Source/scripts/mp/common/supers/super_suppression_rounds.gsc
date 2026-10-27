// scripts\mp\common\supers\super_suppression_rounds.gsc  (hash_1180c859f9cc1fbc.gscc) (size: 8763 Bytes / 0x223b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c9da7ae (2090706862)
// size ...... 8763 (0x223b)
// includes .. 15  (offset: 0x20a7)
// strings ... 16  (offset: 0x211f)
// dev strs .. 2   (offset: 0x2223)
// exports ... 30  (offset: 0x12af)
// cseg ...... 0x1b2 + 0x10fd (0x12af)
// imports ... 80  (offset: 0x175f)
// animtree1 . 0   (offset: 0x223b)
// animtree2 . 0   (offset: 0x223b)
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\challenges;
#using scripts\mp\common\supers\super_stoppingpower;
#using scripts\mp\common\utility\callback_group;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons;

#namespace super_suppression_rounds;

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x4809c61a, Offset: 0x1d0
// Size: 0x2e
function suppressionrounds_init()
{
    level.onweapondropcreated callback_group::callback_subscribe( &suppressionrounds_onweaponcreated, level );
    level.onweapondroppickedup callback_group::callback_subscribe( &suppressionrounds_onweaponpickedup, level );
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x3a7b574c, Offset: 0x206
// Size: 0x16d, Type: bool
function suppressionrounds_beginuse()
{
    playerweaponobj = self.lastnormalweaponobj;
    var_aeef81b700291007 = nullweapon();
    
    if ( weapon::ismeleeonly( playerweaponobj ) || weapon::issuperweapon( playerweaponobj ) || weapon::iskillstreakweapon( playerweaponobj ) || weapon::isgamemodeweapon( playerweaponobj ) || weapon::issinglehitweapon( playerweaponobj.basename ) || weapon::isminigunweapon( playerweaponobj ) || !suppressionrounds_isvalidprimaryoralt( playerweaponobj ) || playerweaponobj.basename == level.defaultfist )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/support_box_incompat" );
        }
        
        return false;
    }
    
    result = super_stoppingpower::stoppingpower_cancelreload();
    
    if ( !result )
    {
        return false;
    }
    
    function_4c1196061cf443e8( playerweaponobj );
    
    /#
        setdevdvarifuninitialized( @"hash_cf7e828b80157a7e", 0 );
        setdevdvarifuninitialized( @"hash_e99f272dcc64b03c", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_c3573be192cb700f", 0.7 );
    #/
    
    challenges::function_a0936b0e5b4550f3( "super_suppression_rounds", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    talking_gun::talkinggun_event( self, #"equipment_deployed" );
    return true;
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xb972a1a9, Offset: 0x37c
// Size: 0x2
function suppressionrounds_stopuse()
{
    
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0x3bc28e0b, Offset: 0x386
// Size: 0x3a
function suppressionrounds_isvalidprimaryoralt( objweapon )
{
    if ( !self isalternatemode( objweapon ) )
    {
        return 1;
    }
    
    underbarrel = objweapon.underbarrel;
    return weapons::isattachmentselectfire( objweapon, underbarrel );
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0x71f8f26b, Offset: 0x3c9
// Size: 0x27d, Type: bool
function function_4c1196061cf443e8( playerweaponobj )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
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
            var_ff11fc9689b87361 = clipammo * 2;
            
            if ( isakimbo )
            {
                var_ff11fc9689b87361 *= 2;
            }
            
            function_13d429851325e7a1( self, weaponobj, var_ff11fc9689b87361 );
            
            if ( true )
            {
                if ( isakimbo )
                {
                    clipammo = self getweaponammoclip( weaponobj, "left" ) + self getweaponammoclip( weaponobj, "right" );
                    stockammo = self getweaponammostock( weaponobj );
                    oldammo = clipammo + stockammo;
                    newammo = int( min( weaponmaxammo( weaponobj ), oldammo + var_ff11fc9689b87361 ) );
                    self setweaponammostock( weaponobj, newammo );
                    self setweaponammoclip( weaponobj, 0, "left" );
                    self setweaponammoclip( weaponobj, 0, "right" );
                    continue;
                }
                
                clipammo = self getweaponammoclip( weaponobj );
                stockammo = self getweaponammostock( weaponobj );
                oldammo = clipammo + stockammo;
                maxammo = weaponmaxammo( weaponobj );
                totalammo = oldammo + var_ff11fc9689b87361;
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
    
    thread suppressionrounds_waitforreload( playerweaponobj, stockammo, excessammo );
    return true;
}

// Namespace super_suppression_rounds
// Params 3
// Checksum 0xa32f1a48, Offset: 0x64f
// Size: 0xc1
function suppressionrounds_waitforreload( weaponobj, stockammo, excessammo )
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
            thread hud_message::showsplash( "suppression_rounds_activated", undefined, self );
            
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

// Namespace super_suppression_rounds
// Params 3
// Checksum 0x75240dc8, Offset: 0x718
// Size: 0x7c
function function_13d429851325e7a1( player, objweapon, numrounds )
{
    var_62a1970b3ee932ab = spawnstruct();
    var_62a1970b3ee932ab.player = player;
    var_62a1970b3ee932ab.objweapon = objweapon;
    var_62a1970b3ee932ab.rounds = numrounds;
    var_62a1970b3ee932ab.var_6422b804364eb10c = 0;
    var_62a1970b3ee932ab.kills = 0;
    function_9282051e1af4ba51( player, var_62a1970b3ee932ab );
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xb1600fa1, Offset: 0x79c
// Size: 0x87
function suppressionrounds_giveperks()
{
    perkarray = self.var_c63f8fe481c40028;
    
    foreach ( perk in perkarray )
    {
        perk::giveperk( perk );
    }
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x892e07f2, Offset: 0x82b
// Size: 0x97
function function_78893ed909402ff6()
{
    perkarray = self.var_c63f8fe481c40028;
    
    foreach ( perk in perkarray )
    {
        if ( isdefined( self.perks[ perk ] ) )
        {
            perk::removeperk( perk );
        }
    }
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x80854455, Offset: 0x8ca
// Size: 0xac
function function_51e19ee3f7505bdc()
{
    perkarray = self.var_c63f8fe481c40028;
    
    if ( !isdefined( perkarray ) )
    {
        return 0;
    }
    
    var_fd92b8fb4acb19f4 = 1;
    
    foreach ( perk in perkarray )
    {
        if ( !isdefined( self.perks[ perk ] ) )
        {
            var_fd92b8fb4acb19f4 = 0;
            break;
        }
    }
    
    return var_fd92b8fb4acb19f4;
}

// Namespace super_suppression_rounds
// Params 2
// Checksum 0xfc961c3d, Offset: 0x97f
// Size: 0xf9
function function_9282051e1af4ba51( player, var_62a1970b3ee932ab )
{
    if ( !isdefined( player.var_62a1970b3ee932ab ) )
    {
        player.var_62a1970b3ee932ab = [];
    }
    
    if ( !isdefined( player.var_c63f8fe481c40028 ) )
    {
        player.var_c63f8fe481c40028 = [ "specialty_bulletsuppress", "specialty_bulletpenetration", "specialty_armorpiercingks", "specialty_fastreload" ];
    }
    
    id = weapon::getcompleteweaponnamenoalt( var_62a1970b3ee932ab.objweapon );
    var_b2d4b3d4e4e28bf0 = player.var_62a1970b3ee932ab[ id ];
    
    if ( isdefined( var_b2d4b3d4e4e28bf0 ) )
    {
        var_b2d4b3d4e4e28bf0 thread suppressionrounds_removeapr();
    }
    
    player.var_62a1970b3ee932ab[ id ] = var_62a1970b3ee932ab;
    var_62a1970b3ee932ab thread function_53c2cb694f79ffa0();
    var_62a1970b3ee932ab thread function_30885495eddbf28c();
    var_62a1970b3ee932ab thread function_a6b60901b6cbba79();
    var_62a1970b3ee932ab thread function_762f9818430e7ea1();
    var_62a1970b3ee932ab thread function_475a039b14078745();
    player thread suppressionrounds_breaksprint();
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0xaddb8224, Offset: 0xa80
// Size: 0x19, Type: bool
function function_e6b3ada0b717e4ce( player )
{
    return !isdefined( player.var_62a1970b3ee932ab );
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xe90ac8b2, Offset: 0xaa2
// Size: 0x2b, Type: bool
function suppressionrounds_hasaprrounds()
{
    var_62a1970b3ee932ab = function_cddd9da84018c98( self getcurrentweapon() );
    return isdefined( var_62a1970b3ee932ab ) && var_62a1970b3ee932ab.var_6422b804364eb10c;
}

// Namespace super_suppression_rounds
// Params 3
// Checksum 0x280c17e, Offset: 0xad6
// Size: 0x4f
function suppressionrounds_onweaponcreated( weaponentity, droppingplayer, weaponobj )
{
    if ( !( isdefined( weaponentity ) && isdefined( droppingplayer ) ) )
    {
        return;
    }
    
    var_62a1970b3ee932ab = droppingplayer function_cddd9da84018c98( weaponobj );
    weaponentity.var_62a1970b3ee932ab = var_62a1970b3ee932ab;
}

// Namespace super_suppression_rounds
// Params 3
// Checksum 0x1df8bf91, Offset: 0xb2d
// Size: 0x78
function suppressionrounds_onweaponpickedup( weaponentity, var_5b2075a06ef16da1, weaponobj )
{
    if ( !isdefined( weaponentity.var_62a1970b3ee932ab ) )
    {
        return;
    }
    
    var_62a1970b3ee932ab = weaponentity.var_62a1970b3ee932ab;
    var_62a1970b3ee932ab.player = var_5b2075a06ef16da1;
    var_62a1970b3ee932ab.var_6422b804364eb10c = 0;
    var_62a1970b3ee932ab.kills = 0;
    function_9282051e1af4ba51( var_5b2075a06ef16da1, var_62a1970b3ee932ab );
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0x4dd068a8, Offset: 0xbad
// Size: 0x43
function function_cddd9da84018c98( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_62a1970b3ee932ab ) )
    {
        return;
    }
    
    id = weapon::getcompleteweaponnamenoalt( objweapon );
    return self.var_62a1970b3ee932ab[ id ];
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x9826c61f, Offset: 0xbf9
// Size: 0xc1
function function_762f9818430e7ea1()
{
    self endon( #"suppressionRounds_removeAPR" );
    self.player endon( #"disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        if ( function_ec80aa5463676a6( self.player getcurrentweapon() ) )
        {
            if ( !self.var_6422b804364eb10c )
            {
                self.player suppressionrounds_giveperks();
                self.var_6422b804364eb10c = 1;
            }
        }
        else if ( self.var_6422b804364eb10c )
        {
            self.player function_78893ed909402ff6();
            self.var_6422b804364eb10c = 0;
        }
        
        self.player waittill( #"weapon_change" );
    }
    
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x7392ebc7, Offset: 0xcc2
// Size: 0xa5
function function_475a039b14078745()
{
    self endon( #"suppressionRounds_removeAPR" );
    self.player endon( #"disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        self.player waittill( #"weapon_fired", objweapon );
        
        if ( function_ec80aa5463676a6( objweapon ) )
        {
            self.rounds--;
            
            if ( self.rounds <= 0 )
            {
                break;
            }
        }
    }
    
    self.player thread suppressionrounds_tracklastcrossbowshot( self.objweapon );
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0xca2cbc0, Offset: 0xd6f
// Size: 0x67
function suppressionrounds_tracklastcrossbowshot( objweapon )
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

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x9060b298, Offset: 0xdde
// Size: 0x3e
function suppressionrounds_removeapr()
{
    self notify( #"suppressionRounds_removeAPR" );
    
    if ( isdefined( self.player ) )
    {
        if ( self.var_6422b804364eb10c )
        {
            self.player function_78893ed909402ff6();
        }
        
        function_e494759095d2363f();
    }
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xc7174550, Offset: 0xe24
// Size: 0x22
function function_af25a218515b806e()
{
    self notify( #"suppressionRounds_removeAPR" );
    
    if ( isdefined( self.player ) )
    {
        function_e494759095d2363f();
    }
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x973644c, Offset: 0xe4e
// Size: 0x14d
function function_e494759095d2363f()
{
    if ( isdefined( self.player.var_62a1970b3ee932ab ) )
    {
        id = weapon::getcompleteweaponnamenoalt( self.objweapon );
        var_62a1970b3ee932ab = self.player.var_62a1970b3ee932ab[ id ];
        
        if ( var_62a1970b3ee932ab == self )
        {
            self.player.var_62a1970b3ee932ab[ id ] = undefined;
        }
        
        if ( isdefined( self.player.super ) && isdefined( self.player.super.vehiclehitcount ) )
        {
            self.player challenges::function_a0936b0e5b4550f3( "super_suppression_rounds", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.player.super.vehiclehitcount );
            self.player.super.vehiclehitcount = undefined;
        }
        
        analyticslog::logevent_fieldupgradeexpired( self.player, level.superglobals.staticsuperdata[ "super_suppression_rounds" ].id, self.kills, 0 );
    }
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0x6493866e, Offset: 0xfa3
// Size: 0x12c
function suppressionrounds_onkill( weaponobj )
{
    if ( isdefined( weaponobj ) )
    {
        id = weapon::getcompleteweaponnamenoalt( weaponobj );
        var_62a1970b3ee932ab = self.var_62a1970b3ee932ab[ id ];
        
        if ( isdefined( var_62a1970b3ee932ab ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "suppressionRoundsKills" ] ) )
                {
                    self.leaderboarddata[ "suppressionRoundsKills" ] = self.leaderboarddata[ "suppressionRoundsKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "suppressionRoundsKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "suppressionRoundsKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x3a>" );
                
                if ( isdefined( self.pers[ "suppressionRoundsKills" ] ) )
                {
                    self.pers[ "suppressionRoundsKills" ] = self.pers[ "suppressionRoundsKills" ] + 1;
                }
            }
            
            supers_mp::combatrecordsuperkill( "super_suppression_rounds" );
            var_62a1970b3ee932ab.kills++;
        }
    }
}

// Namespace super_suppression_rounds
// Params 1
// Checksum 0x685668b9, Offset: 0x10d7
// Size: 0x6c, Type: bool
function function_ec80aa5463676a6( objweapon )
{
    var_d92e665a60076e29 = self.player getammotype( self.objweapon );
    currentammotype = self.player getammotype( objweapon );
    var_e1503b1c0e5d6a3c = var_d92e665a60076e29 == currentammotype;
    return issameweapon( objweapon, self.objweapon, 1 ) && var_e1503b1c0e5d6a3c;
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xecdc5285, Offset: 0x114c
// Size: 0x3e
function function_53c2cb694f79ffa0()
{
    self.player endon( #"disconnect" );
    self endon( #"suppressionRounds_removeAPR" );
    self.player waittill( #"death" );
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xeb6ac84d, Offset: 0x1192
// Size: 0x36
function function_30885495eddbf28c()
{
    self.player endon( #"disconnect" );
    self endon( #"suppressionRounds_removeAPR" );
    level waittill( #"game_ended" );
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0xae7037de, Offset: 0x11d0
// Size: 0x3e
function function_a6b60901b6cbba79()
{
    self.player endon( #"disconnect" );
    self endon( #"suppressionRounds_removeAPR" );
    self.player waittill( #"hash_acbc7ab957079995" );
    thread function_af25a218515b806e();
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x6adcdeec, Offset: 0x1216
// Size: 0x5f
function suppressionrounds_givefastreload()
{
    self.player endon( #"death_or_disconnect" );
    self.player perk::giveperk( "specialty_fastreload" );
    self.player utility::waittill_any( "weapon_fired", "weapon_change", "suppressionRounds_removeAPR" );
    self.player perk::removeperk( "specialty_fastreload" );
}

// Namespace super_suppression_rounds
// Params 0
// Checksum 0x26054976, Offset: 0x127d
// Size: 0x32
function suppressionrounds_breaksprint()
{
    self endon( #"death_or_disconnect" );
    val::set( "suppressionRounds", "sprint", 0 );
    wait 0.4;
    val::reset_all( "suppressionRounds" );
}

