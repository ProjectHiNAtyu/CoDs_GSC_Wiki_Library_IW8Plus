// scripts\mp\common\perks\perkpackage.gsc  (hash_09b5f893c39bde3a.gscc) (size: 16799 Bytes / 0x419f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85f0a760 (2247141216)
// size ...... 16799 (0x419f)
// includes .. 5   (offset: 0x3ef7)
// strings ... 39  (offset: 0x3f1f)
// dev strs .. 0   (offset: 0x419f)
// exports ... 50  (offset: 0x29ef)
// cseg ...... 0x367 + 0x2688 (0x29ef)
// imports ... 107 (offset: 0x31bf)
// animtree1 . 0   (offset: 0x419f)
// animtree2 . 0   (offset: 0x419f)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\supers;

#namespace perkpackage;

// Namespace perkpackage
// Params 0
// Checksum 0x45237412, Offset: 0x385
// Size: 0x1e
function perkpackage_initperkpackages()
{
    perkpackage_initpersdata();
    thread perkpackage_updateifchanged();
    thread perkpackage_checkifready();
    thread function_aab3497cbf8602bd();
}

// Namespace perkpackage
// Params 0
// Checksum 0xf55424a8, Offset: 0x3ab
// Size: 0x8a
function function_aab3497cbf8602bd()
{
    self notify( #"hash_a6e71c87e73a96ff" );
    self endon( #"hash_a6e71c87e73a96ff" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waittillframeend();
    
    if ( self )
    {
        state = self getclientomnvar( "ui_super_state" );
    }
    
    while ( self )
    {
        if ( state == 1 && self.perkpackagedata.istwomode )
        {
            perkpackage_setstate( 0 );
        }
        
        self waittill( #"ui_super_state", state );
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0xb79e84a3, Offset: 0x43d
// Size: 0xd2
function perkpackage_checkifready()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"giveloadout_start" );
    wasearned = 0;
    
    while ( true )
    {
        if ( !self.perkpackagedata.isusing && supers_mp::issuperready() )
        {
            if ( self.perkpackagedata.istwomode )
            {
                perkpackage_setstate( 1 );
                
                if ( true )
                {
                    function_6c56fa45e81c0b9d();
                    
                    if ( isdefined( level.perkpackage_checkifready_callback ) )
                    {
                        [[ level.perkpackage_checkifready_callback ]]();
                    }
                }
            }
            
            if ( level.superglobals.var_7528e3d743bcb734 )
            {
                return;
            }
            
            if ( wasearned )
            {
                thread supers_mp::showsuperremindersplash();
            }
        }
        
        self waittill( #"hash_280382f2684ea238", wasearned );
    }
}

// Namespace perkpackage
// Params 2
// Checksum 0x27344077, Offset: 0x517
// Size: 0x2c
function function_6cd31c590c97e0fd( var_62aef5673524c52b = [], new = [] )
{
    return arraycompare( var_62aef5673524c52b, new );
}

// Namespace perkpackage
// Params 0
// Checksum 0xce8328c6, Offset: 0x54c
// Size: 0x50e
function perkpackage_updateifchanged()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"giveloadout_start" );
    firstupgrade = perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage_getsecondfieldupgrade();
    var_83fd42851647fda5 = function_7eb91cbefdd85734();
    var_d3d31a23a1b0df0b = function_da8da44d2b6eaa58();
    var_f53c01849a742526 = perkpackage_getfirstfieldupgradeattachments( firstupgrade );
    var_fb3dd6572ad66784 = perkpackage_getsecondfieldupgradeattachments( secondupgrade );
    hassuper = isdefined( self.super );
    newfirst = self.perkpackagedata.firstupgrade != firstupgrade;
    newsecond = self.perkpackagedata.secondupgrade != secondupgrade;
    var_e656bda8164c7a72 = function_6cd31c590c97e0fd( self.perkpackagedata.var_f53c01849a742526, var_f53c01849a742526 ) || function_6cd31c590c97e0fd( self.perkpackagedata.var_fb3dd6572ad66784, var_fb3dd6572ad66784 );
    
    if ( !hassuper || newfirst || newsecond || self.perkpackagedata.forcereset || var_e656bda8164c7a72 )
    {
        var_a144448ac35d89de = supers_mp::getsuperid( firstupgrade );
        self setclientomnvar( "ui_perk_package_super1", var_a144448ac35d89de );
        var_20374b325e7d6d6c = supers_mp::getsuperid( secondupgrade );
        self setclientomnvar( "ui_perk_package_super2", var_20374b325e7d6d6c );
        isimmediate = istrue( self.perkpackagedata.var_95c5f5d416cfe27a );
        
        if ( isdefined( supers_mp::getcurrentsuper() ) )
        {
            if ( self.perkpackagedata.forcereset )
            {
                supers_mp::setsuperbasepoints( 0 );
            }
            else
            {
                currentpoints = supers_mp::getcurrentsuperpoints();
                newpoints = currentpoints - 0;
                newpoints = max( newpoints, 0 );
                
                if ( !supers_mp::issuperinuse() && supers_mp::getcurrentsuperpoints() < supers_mp::getsuperpointsneeded() )
                {
                    supers_mp::setsuperbasepoints( newpoints, 1 );
                }
            }
        }
        
        if ( firstupgrade == "none" && secondupgrade == "none" )
        {
            self.perkpackagedata.istwomode = 0;
            supers_mp::function_7c7012c332084e14();
            perkpackage_setstate( 0 );
            self.perkpackagedata.super = undefined;
            self.perkpackagedata.superattachments = [];
            supers_mp::clearsuper();
        }
        else if ( secondupgrade == "none" )
        {
            self.perkpackagedata.istwomode = 0;
            supers_mp::function_7c7012c332084e14();
            perkpackage_setstate( 3 );
            self.perkpackagedata.super = firstupgrade;
            self.perkpackagedata.superattachments = var_f53c01849a742526;
            
            if ( isdefined( self.var_760a3e04da86556f ) && supers_mp::function_31f00fe6e0334d03() )
            {
                supers_mp::givesuper( self.perkpackagedata.super, 0, isimmediate, var_83fd42851647fda5, var_f53c01849a742526 );
            }
            else
            {
                supers_mp::givesuper( self.perkpackagedata.super, 1, isimmediate, var_83fd42851647fda5, var_f53c01849a742526 );
            }
        }
        else if ( firstupgrade == "none" )
        {
            self.perkpackagedata.istwomode = 0;
            supers_mp::function_7c7012c332084e14();
            perkpackage_setstate( 4 );
            self.perkpackagedata.super = secondupgrade;
            self.perkpackagedata.superattachments = var_fb3dd6572ad66784;
            
            if ( isdefined( self.var_760a3e04da86556f ) && supers_mp::function_31f00fe6e0334d03() )
            {
                supers_mp::givesuper( self.perkpackagedata.super, 0, isimmediate, var_d3d31a23a1b0df0b, var_fb3dd6572ad66784 );
            }
            else
            {
                supers_mp::givesuper( self.perkpackagedata.super, 1, isimmediate, var_d3d31a23a1b0df0b, var_fb3dd6572ad66784 );
            }
        }
        else
        {
            self.perkpackagedata.istwomode = 1;
            supers_mp::function_f520ad17bbf59ded();
            perkpackage_setstate( 0 );
            function_6c56fa45e81c0b9d();
        }
        
        var_6d6795272a56d9a5 = supers_mp::function_3f90266754288234();
        
        if ( newfirst || newsecond )
        {
            if ( var_6d6795272a56d9a5 )
            {
                if ( var_6d6795272a56d9a5 != firstupgrade && var_6d6795272a56d9a5 != secondupgrade )
                {
                    supers_mp::function_6bb6a62fab30a411();
                }
            }
        }
        
        if ( !self.perkpackagedata.istwomode )
        {
            if ( var_6d6795272a56d9a5 && var_6d6795272a56d9a5 != firstupgrade )
            {
                supers_mp::function_6bb6a62fab30a411();
            }
        }
        
        if ( supers_mp::issuperready() )
        {
            thread supers_mp::showsuperremindersplash();
        }
        
        self.perkpackagedata.forcereset = 0;
        self.perkpackagedata.firstupgrade = firstupgrade;
        self.perkpackagedata.var_f53c01849a742526 = var_f53c01849a742526;
        self.perkpackagedata.secondupgrade = secondupgrade;
        self.perkpackagedata.var_fb3dd6572ad66784 = var_fb3dd6572ad66784;
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0xc588c085, Offset: 0xa62
// Size: 0x163
function function_6c56fa45e81c0b9d()
{
    if ( isdefined( self.perkpackagedata.super ) && self.perkpackagedata.super != "super_select" )
    {
        self.perkpackagedata.lastsuper = self.perkpackagedata.super;
        self.perkpackagedata.var_64f1fef77c371835 = self.perkpackagedata.superattachments;
        
        if ( supers_mp::function_6cb748aa8fcb575b( self.perkpackagedata.lastsuper ) )
        {
            supers_mp::function_e588c6513c782be0( self.perkpackagedata.lastsuper );
        }
    }
    
    self.perkpackagedata.super = "super_select";
    self.perkpackagedata.superattachments = [];
    
    if ( isdefined( self.var_760a3e04da86556f ) && supers_mp::function_31f00fe6e0334d03() )
    {
        supers_mp::givesuper( self.perkpackagedata.super, 0, 0, undefined, self.perkpackagedata.superattachments );
        return;
    }
    
    supers_mp::givesuper( self.perkpackagedata.super, 1, 0, undefined, self.perkpackagedata.superattachments );
}

// Namespace perkpackage
// Params 0
// Checksum 0xb099549c, Offset: 0xbcd
// Size: 0x2f, Type: bool
function perkpackage_isreadytoupgrade()
{
    if ( !isdefined( self.perkpackagedata ) )
    {
        return false;
    }
    
    if ( self.perkpackagedata.state != 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace perkpackage
// Params 1
// Checksum 0x3f0d3018, Offset: 0xc05
// Size: 0x4d
function perkpackage_setuistate( state )
{
    if ( !isdefined( self.var_6e6f241f7964127e ) )
    {
        self.var_6e6f241f7964127e = [];
    }
    
    self.var_6e6f241f7964127e[ self.var_6e6f241f7964127e.size ] = state;
    
    if ( !self.var_715f429307367d79 )
    {
        function_7c227010c3877db0();
    }
}

// Namespace perkpackage
// Params 0, eflags: 0xc
// Checksum 0x6c9b35c1, Offset: 0xc5a
// Size: 0x8e
function private function_7c227010c3877db0()
{
    self notify( #"hash_fcb6e15b942ea06f" );
    self endon( #"hash_fcb6e15b942ea06f" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_715f429307367d79 = 1;
    
    while ( self.var_6e6f241f7964127e.size > 0 )
    {
        self setclientomnvar( "ui_perk_package_state", self.var_6e6f241f7964127e[ 0 ] );
        self.var_6e6f241f7964127e[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.var_6e6f241f7964127e );
        wait 0.25;
    }
    
    self.var_715f429307367d79 = 0;
}

// Namespace perkpackage
// Params 1
// Checksum 0xaeb0523a, Offset: 0xcf0
// Size: 0x2b
function perkpackage_setstate( newstate )
{
    thread perkpackage_setuistate( newstate );
    self.perkpackagedata.state = newstate;
}

// Namespace perkpackage
// Params 0
// Checksum 0x28ead4fd, Offset: 0xd23
// Size: 0x49
function perkpackage_getfirstfieldupgrade()
{
    fieldupgrade = self.loadoutfieldupgrade1;
    
    if ( isdefined( self.overridefieldupgrade1 ) )
    {
        fieldupgrade = self.overridefieldupgrade1;
    }
    
    if ( isdefined( self.var_f20215e1fa71682a ) )
    {
        fieldupgrade = self.var_f20215e1fa71682a;
    }
    
    return fieldupgrade;
}

// Namespace perkpackage
// Params 1
// Checksum 0x42186c7e, Offset: 0xd75
// Size: 0x7d, Type: bool
function perkpackage_getfirstfieldupgradeattachments( firstupgrade )
{
    if ( self.loadoutfieldupgrade1 == firstupgrade )
    {
        attachments = self.var_6dd76aa72f0c26e1;
    }
    else if ( self.loadoutfieldupgrade2 == firstupgrade )
    {
        attachments = self.var_3834964fc455658e;
    }
    
    if ( self.overridefieldupgrade1 )
    {
        attachments = self.var_9af0e57bcf353e4d ?? [];
    }
    
    if ( self.var_f20215e1fa71682a )
    {
        attachments = [];
    }
    
    return attachments ?? [];
}

// Namespace perkpackage
// Params 0
// Checksum 0xb749ed9a, Offset: 0xdfb
// Size: 0xb
function function_7eb91cbefdd85734()
{
    return self.var_6b08217cbc33ea5c;
}

// Namespace perkpackage
// Params 0
// Checksum 0x81b55654, Offset: 0xe0f
// Size: 0x31
function perkpackage_getsecondfieldupgrade()
{
    fieldupgrade = self.loadoutfieldupgrade2;
    
    if ( isdefined( self.overridefieldupgrade2 ) )
    {
        fieldupgrade = self.overridefieldupgrade2;
    }
    
    return fieldupgrade;
}

// Namespace perkpackage
// Params 1
// Checksum 0xf9862eb, Offset: 0xe49
// Size: 0x6e, Type: bool
function perkpackage_getsecondfieldupgradeattachments( secondupgrade )
{
    if ( self.loadoutfieldupgrade1 == secondupgrade )
    {
        attachments = self.var_6dd76aa72f0c26e1;
    }
    else if ( self.loadoutfieldupgrade2 == secondupgrade )
    {
        attachments = self.var_3834964fc455658e;
    }
    
    if ( self.overridefieldupgrade2 )
    {
        attachments = self.var_210b69c5565617da ?? [];
    }
    
    return attachments ?? [];
}

// Namespace perkpackage
// Params 0
// Checksum 0x3e924886, Offset: 0xec0
// Size: 0xb
function function_da8da44d2b6eaa58()
{
    return self.var_5e73e76f67b0afed;
}

// Namespace perkpackage
// Params 0
// Checksum 0xfa133586, Offset: 0xed4
// Size: 0x1d5
function perkpackage_initpersdata()
{
    self.perkpackagedata = self.pers[ "perkPackageData" ];
    
    if ( !isdefined( self.perkpackagedata ) )
    {
        self.perkpackagedata = spawnstruct();
        self.perkpackagedata.state = 0;
        self.perkpackagedata.forcereset = 0;
        self.perkpackagedata.isusing = 0;
        self.perkpackagedata.firstupgrade = undefined;
        self.perkpackagedata.var_f53c01849a742526 = [];
        self.perkpackagedata.secondupgrade = undefined;
        self.perkpackagedata.var_fb3dd6572ad66784 = [];
        self.perkpackagedata.super = "super_select";
        self.perkpackagedata.superattachments = [];
        self.perkpackagedata.istwomode = 0;
        self.perkpackagedata.lastsuper = undefined;
        self.perkpackagedata.var_64f1fef77c371835 = undefined;
        self.perkpackagedata.giveonspawn = getdvarint( @"hash_71b04bfc490e137a", 0 );
        self.perkpackagedata.var_95c5f5d416cfe27a = istrue( level.superglobals.var_385fefa79e4f1bde );
        self.pers[ "perkPackageData" ] = self.perkpackagedata;
        
        if ( !isagent( self ) )
        {
            self setclientomnvar( "ui_perk_package_state", self.perkpackagedata.state );
        }
        
        if ( isdefined( self.perkpackagedata.overridepointsneeded ) )
        {
            supers_mp::function_7c7012c332084e14();
        }
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0x307bde91, Offset: 0x10b1
// Size: 0x7
function perkpackage_getperkicon()
{
    return "hud_icon_perk_blast_shield";
}

// Namespace perkpackage
// Params 0
// Checksum 0x10a0f0cf, Offset: 0x10c1
// Size: 0x57
function perkpackage_openselect()
{
    canopenmenu = perkpackagemenu_canactivatesuper();
    isready = perkpackage_isreadytoupgrade();
    
    if ( !canopenmenu )
    {
        return 0;
    }
    
    if ( !isready )
    {
        return 0;
    }
    
    thread perkpackagemenu_openmenu();
    self notify( #"hash_8426ddb67417b717" );
    thread function_686002b6684d2d59();
    return 1;
}

// Namespace perkpackage
// Params 0
// Checksum 0x9d6b7f85, Offset: 0x1120
// Size: 0x27
function function_686002b6684d2d59()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    self notify( #"hash_d4a610d7fafe1606" );
}

// Namespace perkpackage
// Params 0
// Checksum 0xd5f3d962, Offset: 0x114f
// Size: 0x11b
function perkpackagemenu_openmenu()
{
    val::set( "ppmenu", "killstreaks", 0 );
    val::set( "ppmenu", "offhand_weapons", 0 );
    self notifyonplayercommand( "perkPackageMenu_option1", "+smoke" );
    self notifyonplayercommand( "perkPackageMenu_option2", "+frag" );
    thread perkpackagemenu_closeinputthink();
    success = perkpackagemenu_menuthink();
    success = istrue( success );
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_be1c531304e41fa2" );
        forcerefund = !success;
        
        if ( player::isreallyalive( self ) )
        {
            self notifyonplayercommandremove( "perkPackageMenu_option1", "+smoke" );
            self notifyonplayercommandremove( "perkPackageMenu_option2", "+frag" );
            supers_mp::superusefinished( forcerefund, 1 );
            val::reset_all( "ppmenu" );
        }
        else if ( !player::isreallyalive( self ) && forcerefund )
        {
            thread function_a5f4559b262c0f4f();
        }
        
        if ( success )
        {
            perkpackage_awardperkpackageupgrade();
            return;
        }
        
        self.perkpackagedata.super = "super_select";
        self.perkpackagedata.superattachments = [];
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0xe601a5ff, Offset: 0x1272
// Size: 0xec
function perkpackagemenu_menuthink()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"giveloadout_start" );
    perkpackage_setstate( 2 );
    function_1e8e9a75ecac4fae( 1 );
    var_7c497237906c6a12 = getdvarfloat( @"hash_6baabdf45e17acc1", 0 );
    wait var_7c497237906c6a12;
    result = utility::waittill_any_return( "perkPackageMenu_option1", "perkPackageMenu_option2", "perkPackageMenu_close", "death", "super_disable_start" );
    shouldactivate = 0;
    function_1e8e9a75ecac4fae( 0 );
    
    if ( result == "perkPackageMenu_option1" )
    {
        perkpackage_setstate( 3 );
        shouldactivate = 1;
    }
    else if ( result == "perkPackageMenu_option2" )
    {
        perkpackage_setstate( 4 );
        shouldactivate = 1;
    }
    else
    {
        perkpackage_setstate( 1 );
        shouldactivate = 0;
        wait 0.3;
    }
    
    if ( !perkpackagemenu_canactivatesuper() )
    {
        shouldactivate = 0;
    }
    
    return shouldactivate;
}

// Namespace perkpackage
// Params 1
// Checksum 0xf04326b0, Offset: 0x1367
// Size: 0x56
function function_1e8e9a75ecac4fae( isdisabled )
{
    if ( isdisabled )
    {
        val::set( "perkpackage_menu", "usability", 0 );
        val::set( "perkpackage_menu", "ascender_use", 0 );
        val::set( "perkpackage_menu", "vehicle_use", 0 );
        return;
    }
    
    val::reset_all( "perkpackage_menu" );
}

// Namespace perkpackage
// Params 0
// Checksum 0x64c36fc4, Offset: 0x13c5
// Size: 0x7a
function function_a5f4559b262c0f4f()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_be1c531304e41fa2" );
    utility::waittill_any( "spawned_player", "laststand_revived" );
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    superinfo = supers_mp::getcurrentsuper();
    
    if ( isdefined( superinfo ) )
    {
        supers_mp::setsuperexpended( 0 );
        superinfo.wasrefunded = 1;
        supers_mp::setsuperbasepoints( supers_mp::getsuperpointsneeded() );
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0x7e15b95a, Offset: 0x1447
// Size: 0x56
function perkpackagemenu_closeinputthink()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"giveloadout_start" );
    self endon( #"hash_be1c531304e41fa2" );
    
    while ( true )
    {
        if ( !perkpackagemenu_canactivatesuper() )
        {
            self notify( #"perkpackagemenu_close" );
        }
        
        wait 0.05;
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0x4cf3937, Offset: 0x14a5
// Size: 0x44, Type: bool
function perkpackagemenu_canactivatesuper()
{
    if ( self usebuttonpressed() || self attackbuttonpressed() || self adsbuttonpressed() || self meleebuttonpressed() )
    {
        return false;
    }
    
    if ( !val::get( "supers" ) )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    return true;
}

// Namespace perkpackage
// Params 0
// Checksum 0x6119feee, Offset: 0x14f2
// Size: 0x1f4
function perkpackage_awardperkpackageupgrade()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"giveloadout_start" );
    superref = undefined;
    
    if ( self.perkpackagedata.state == 3 )
    {
        superref = perkpackage_getfirstfieldupgrade();
        attachments = perkpackage_getfirstfieldupgradeattachments( superref );
    }
    else if ( self.perkpackagedata.state == 4 )
    {
        superref = perkpackage_getsecondfieldupgrade();
        attachments = perkpackage_getsecondfieldupgradeattachments( superref );
    }
    
    if ( isdefined( superref ) )
    {
        superinfo = supers_mp::getcurrentsuper();
        self.perkpackagedata.super = superref;
        self.perkpackagedata.superattachments = attachments;
        
        if ( !function_587a64dc2ca54554( superref ) )
        {
            supers_mp::givesuper( self.perkpackagedata.super, 0, 1, undefined, attachments );
        }
        
        self.perkpackagedata.lastsuper = superref;
        self.perkpackagedata.var_64f1fef77c371835 = attachments;
        
        if ( supers_mp::function_6cb748aa8fcb575b( self.perkpackagedata.lastsuper ) )
        {
            supers_mp::function_e588c6513c782be0( self.perkpackagedata.lastsuper );
        }
        
        if ( true )
        {
            if ( !function_587a64dc2ca54554( superref ) )
            {
                var_4c5729c32c933ff2 = supers_mp::getcurrentsuper();
                result = perkpackage_forceusesuper( var_4c5729c32c933ff2, superinfo, attachments );
                
                if ( !result )
                {
                    self notify( #"hash_3042b830f809f7d1" );
                }
                else if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_ed83f0f1668a6ed2 )
                {
                    thread function_487b84477d9313cf();
                }
            }
            else
            {
                function_f8c6a1906195cb4e( superref );
            }
            
            return;
        }
        
        thread perkpackagemenu_disableoffhanduse( 0.3 );
    }
}

// Namespace perkpackage
// Params 1
// Checksum 0x32962d9, Offset: 0x16ee
// Size: 0x98, Type: bool
function function_587a64dc2ca54554( superref )
{
    if ( !isdefined( level.gamemodebundle ) || !level.gamemodebundle.var_ed83f0f1668a6ed2 )
    {
        return false;
    }
    
    if ( function_1f400f00ba12ac81( superref ) || function_66276baeca101c8b( superref ) )
    {
        if ( !isdefined( self.perkpackagedata.var_2852e6bfa94d6db1 ) )
        {
            self.perkpackagedata.var_2852e6bfa94d6db1 = [];
        }
        
        if ( self.perkpackagedata.var_2852e6bfa94d6db1[ superref ] )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    return false;
}

// Namespace perkpackage
// Params 1
// Checksum 0x61a2af53, Offset: 0x178f
// Size: 0xca
function function_f8c6a1906195cb4e( superref )
{
    msg = function_d8d70216d2625d20( superref );
    
    switch ( superref )
    {
        case #"hash_caf53e8cfa3f875d":
            self.var_7c99c656f84a5f2a = 1;
            break;
        case #"hash_2a2d382fc09b9c1b":
            self.var_b590d8a08fa6c901 = 1;
            break;
    }
    
    self notify( msg, "success" );
    
    if ( function_1f400f00ba12ac81( superref ) )
    {
        self.var_7498cbde80958ac7 = 1;
        thread function_487b84477d9313cf( superref, 1 );
        
        if ( function_1f400f00ba12ac81( superref ) )
        {
            self.perkpackagedata.var_2852e6bfa94d6db1[ superref ] = undefined;
        }
        
        return;
    }
    
    function_6c56fa45e81c0b9d();
    perkpackage_setstate( 1 );
    supers_mp::setsuperbasepoints( 500 );
    return 1;
}

// Namespace perkpackage
// Params 2
// Checksum 0xe7799107, Offset: 0x1861
// Size: 0x44a
function function_487b84477d9313cf( var_46b9aee332ab2cef, skipwait )
{
    self notify( #"hash_b6e068e7236c4561" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b6e068e7236c4561" );
    level endon( #"game_ended" );
    firstupgrade = perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage_getsecondfieldupgrade();
    superref = undefined;
    shouldclear = istrue( level.var_88ed2e42c358210c );
    
    if ( self.super.staticdata.isweapon )
    {
        result = utility::waittill_any_return( "super_use_finish", "weapon_change" );
        
        if ( result == "weapon_change" )
        {
            result = utility::waittill_any_return( "super_use_finish", "weapon_change" );
            
            if ( result == "weapon_change" )
            {
                superref = self.super.staticdata.ref;
                clipammo = self.super.var_af5bd93c7223b946;
                stockammo = self.super.var_c25aa4af3452dc6;
                
                if ( isdefined( clipammo ) && isdefined( stockammo ) && ( clipammo >= 0 || stockammo >= 0 ) )
                {
                    var_a144448ac35d89de = supers_mp::getsuperid( firstupgrade );
                    self setclientomnvar( "ui_perk_package_super1", var_a144448ac35d89de );
                    var_20374b325e7d6d6c = supers_mp::getsuperid( secondupgrade );
                    self setclientomnvar( "ui_perk_package_super2", var_20374b325e7d6d6c );
                    
                    if ( !isdefined( self.perkpackagedata.weaponclipammo ) )
                    {
                        self.perkpackagedata.weaponclipammo = [];
                    }
                    
                    if ( !isdefined( self.perkpackagedata.weaponstockammo ) )
                    {
                        self.perkpackagedata.weaponstockammo = [];
                    }
                    
                    self.perkpackagedata.weaponclipammo[ superref ] = clipammo;
                    self.perkpackagedata.weaponstockammo[ superref ] = stockammo;
                    thread function_d02ec706b783e4ab();
                    function_6c56fa45e81c0b9d();
                    perkpackage_setstate( 1 );
                    supers_mp::setsuperbasepoints( 500 );
                    return;
                }
                else if ( superref == firstupgrade )
                {
                    superref = secondupgrade;
                }
                else
                {
                    superref = firstupgrade;
                }
            }
        }
    }
    else if ( !skipwait )
    {
        self waittill( #"super_use_finished" );
    }
    
    if ( !isdefined( var_46b9aee332ab2cef ) )
    {
        var_46b9aee332ab2cef = self.super.staticdata.ref;
    }
    
    if ( function_1f400f00ba12ac81( var_46b9aee332ab2cef ) || function_66276baeca101c8b( var_46b9aee332ab2cef ) )
    {
        if ( !self.perkpackagedata.var_2852e6bfa94d6db1[ var_46b9aee332ab2cef ] )
        {
            self.perkpackagedata.var_2852e6bfa94d6db1[ var_46b9aee332ab2cef ] = 1;
            thread function_5b78fb0b469a1db8();
            thread function_9a26be473a1995b0( var_46b9aee332ab2cef );
            wait 1;
            function_6c56fa45e81c0b9d();
            perkpackage_setstate( 1 );
            supers_mp::setsuperbasepoints( 500 );
            return;
        }
    }
    
    if ( !isdefined( superref ) && self.perkpackagedata.state == 3 )
    {
        superref = secondupgrade;
    }
    else if ( !isdefined( superref ) && self.perkpackagedata.state == 4 )
    {
        superref = firstupgrade;
    }
    
    if ( isdefined( self.perkpackagedata ) )
    {
        self.perkpackagedata.istwomode = 0;
        
        if ( isdefined( self.perkpackagedata.weaponclipammo[ superref ] ) && isdefined( self.perkpackagedata.weaponstockammo[ superref ] ) )
        {
            self.perkpackagedata.var_97b887f1826cf9b8 = 1;
            thread function_5b78fb0b469a1db8();
        }
    }
    
    if ( function_1f400f00ba12ac81( superref ) || function_66276baeca101c8b( superref ) )
    {
        if ( isdefined( self.perkpackagedata.var_2852e6bfa94d6db1 ) && self.perkpackagedata.var_2852e6bfa94d6db1[ superref ] )
        {
            shouldclear = 1;
        }
    }
    
    if ( isdefined( superref ) )
    {
        if ( shouldclear )
        {
            function_6c56fa45e81c0b9d();
            perkpackage_setstate( 1 );
            return;
        }
        
        perkpackage_giveimmediate( superref );
        self.var_7498cbde80958ac7 = 0;
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0xb463d862, Offset: 0x1cb3
// Size: 0x103
function function_d02ec706b783e4ab()
{
    self notify( #"hash_9c5d2683709801e5" );
    level endon( #"game_ended" );
    self endon( #"hash_9c5d2683709801e5" );
    result = utility::waittill_any_return( "super_use_finish", "death" );
    
    if ( result == "death" )
    {
        self.perkpackagedata.weaponclipammo = undefined;
        self.perkpackagedata.weaponstockammo = undefined;
        return;
    }
    
    superref = self.super.staticdata.ref;
    self.perkpackagedata.weaponclipammo[ superref ] = undefined;
    self.perkpackagedata.weaponstockammo[ superref ] = undefined;
    
    if ( self.perkpackagedata.weaponclipammo.size > 0 || self.perkpackagedata.weaponstockammo.size > 0 )
    {
        thread function_d02ec706b783e4ab();
    }
}

// Namespace perkpackage
// Params 0
// Checksum 0xf7f135ce, Offset: 0x1dbe
// Size: 0x59
function function_5b78fb0b469a1db8()
{
    self notify( #"perkpackage_monitordeath" );
    level endon( #"game_ended" );
    self endon( #"perkpackage_monitordeath" );
    self waittill( #"death" );
    self.perkpackagedata.var_2852e6bfa94d6db1 = undefined;
    self.perkpackagedata.var_97b887f1826cf9b8 = undefined;
}

// Namespace perkpackage
// Params 1
// Checksum 0xcb761e39, Offset: 0x1e1f
// Size: 0x148
function function_9a26be473a1995b0( superref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"super_use_finished" );
    
    if ( superref == "super_deployed_decoy" )
    {
        ent = undefined;
        
        foreach ( decoy in self.var_70e47e4d766ba906 )
        {
            ent = decoy;
        }
        
        ent waittill( #"detonateexplosive" );
    }
    else if ( superref == "super_tac_camera" )
    {
        self waittill( #"camera_destroyed" );
    }
    else
    {
        return;
    }
    
    firstupgrade = perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage_getsecondfieldupgrade();
    
    if ( superref == firstupgrade )
    {
        self.perkpackagedata.state = 3;
    }
    else
    {
        self.perkpackagedata.state = 4;
    }
    
    function_487b84477d9313cf( superref, 1 );
}

// Namespace perkpackage
// Params 0
// Checksum 0x9883c6a8, Offset: 0x1f6f
// Size: 0x11a, Type: bool
function function_3cec82ba2ae6e1c3()
{
    if ( self.perkpackagedata.istwomode || self.perkpackagedata.var_97b887f1826cf9b8 )
    {
        superinfo = supers_mp::getcurrentsuper();
        
        if ( isdefined( level.gamemodebundle ) && isdefined( superinfo ) && isdefined( superinfo.staticdata ) && isdefined( superinfo.staticdata.ref ) && isdefined( self.perkpackagedata.weaponclipammo[ superinfo.staticdata.ref ] ) && isdefined( self.perkpackagedata.weaponstockammo[ superinfo.staticdata.ref ] ) && level.gamemodebundle.var_ed83f0f1668a6ed2 )
        {
            if ( self.perkpackagedata.var_97b887f1826cf9b8 )
            {
                self.perkpackagedata.var_97b887f1826cf9b8 = undefined;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace perkpackage
// Params 1
// Checksum 0x62ac32c6, Offset: 0x2092
// Size: 0x34, Type: bool
function function_1f400f00ba12ac81( superref )
{
    switch ( superref )
    {
        case #"hash_d2e07f72a95c89d0":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace perkpackage
// Params 1
// Checksum 0x7f0942e0, Offset: 0x20cf
// Size: 0x34, Type: bool
function function_66276baeca101c8b( superref )
{
    switch ( superref )
    {
        case #"hash_2a2d382fc09b9c1b":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace perkpackage
// Params 1
// Checksum 0xca69d5b3, Offset: 0x210c
// Size: 0x51
function function_d8d70216d2625d20( superref )
{
    msg = undefined;
    
    switch ( superref )
    {
        case #"hash_d2e07f72a95c89d0":
            msg = "activateDecoy";
            break;
        case #"hash_2a2d382fc09b9c1b":
            msg = "activateCamera";
            break;
    }
    
    return msg;
}

// Namespace perkpackage
// Params 3
// Checksum 0xbef56eb6, Offset: 0x2166
// Size: 0x2cd
function perkpackage_forceusesuper( superinfo, var_54c7c27937f5af55, superattachments )
{
    self.perkpackagedata.var_d3a6043ef81c7c4a = 0;
    thread perkpackage_waitforsuperfinish();
    superref = supers_mp::getcurrentsuperref();
    
    if ( !isdefined( superref ) )
    {
        return 0;
    }
    
    superweapon = level.superglobals.staticsuperdata[ superref ].weapon;
    
    if ( !isdefined( superweapon ) )
    {
        return 0;
    }
    
    var_4588ed7d75a32bf6 = level.superglobals.staticsuperdata[ superref ].objweapon ?? weapon_utility::function_d2c8356dc369d9ce( superweapon );
    
    if ( isarray( superattachments ) )
    {
        if ( ( superinfo.staticdata.weapon == %"super_default_mp" || superinfo.staticdata.weapon == %"super_minor_default_mp" ) && superinfo.staticdata.weapontype == "BULLETWEAPON" && superinfo.staticdata.useweapon )
        {
            superinfo.var_7ef7600ff6978d76 = superinfo.staticdata.useweapon;
            superinfo.var_7ef7600ff6978d76 = superinfo.var_7ef7600ff6978d76 withattachments( superattachments );
        }
        else
        {
            var_4588ed7d75a32bf6 = var_4588ed7d75a32bf6 withattachments( superattachments );
        }
    }
    
    thread perkpackagemenu_disableoffhanduse( 0.3 );
    iscanceled = 0;
    
    if ( %"super_default_mp" != superweapon )
    {
        iscanceled = !supers_mp::function_d629c90761cd2a1c( var_4588ed7d75a32bf6 );
        
        if ( isdefined( self.perks[ "wildcard_field_captain" ] ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
        {
            pointsneeded = supers_mp::getsuperpointsneeded( var_54c7c27937f5af55 );
            
            if ( var_54c7c27937f5af55.basepoints >= pointsneeded )
            {
                self.perkpackagedata.var_d3a6043ef81c7c4a = 1;
            }
            else
            {
                self.overclockcharge = var_54c7c27937f5af55.basepoints;
            }
        }
    }
    
    if ( iscanceled )
    {
        result = 0;
    }
    else
    {
        result = supers_mp::trysuperusebegin( var_4588ed7d75a32bf6 );
    }
    
    if ( !result )
    {
        perkpackage_setstate( 1 );
        self.perkpackagedata.super = "super_select";
        self.perkpackagedata.superattachments = [];
        supers_mp::givesuper( self.perkpackagedata.super, 0, 1 );
        
        if ( self.perkpackagedata.var_d3a6043ef81c7c4a )
        {
            supers_mp::givesuperpoints( pointsneeded );
        }
    }
    
    return result;
}

// Namespace perkpackage
// Params 0
// Checksum 0xb43361d2, Offset: 0x243c
// Size: 0xb5
function perkpackage_waitforsuperfinish()
{
    self endon( #"disconnect" );
    self.perkpackagedata.isusing = 1;
    msg = perkpackage_waitforsuperfinishinternal();
    
    if ( self.perkpackagedata.var_d3a6043ef81c7c4a )
    {
        perkpackage_setstate( 1 );
        self.perkpackagedata.super = "super_select";
        self.perkpackagedata.superattachments = [];
        supers_mp::givesuper( self.perkpackagedata.super, 0, 1 );
    }
    
    self.perkpackagedata.isusing = 0;
}

// Namespace perkpackage
// Params 0
// Checksum 0x9f191048, Offset: 0x24f9
// Size: 0x31
function perkpackage_waitforsuperfinishinternal()
{
    level endon( #"game_ended" );
    self endon( #"giveloadout_start" );
    self endon( #"hash_3042b830f809f7d1" );
    return utility::waittill_any_return( "super_use_finished" );
}

// Namespace perkpackage
// Params 1
// Checksum 0x6a774686, Offset: 0x2533
// Size: 0x9b
function perkpackage_waitforsupercanceled( superweapon )
{
    self endon( #"offhand_fired" );
    superoffhand = undefined;
    starttime = gettime();
    
    while ( true )
    {
        offhand = self getheldoffhand();
        
        if ( offhand == superweapon )
        {
            superoffhand = offhand;
            break;
        }
        
        endtime = gettime();
        
        if ( endtime - starttime > 400 )
        {
            return 1;
        }
        
        wait 0.05;
    }
    
    while ( true )
    {
        offhand = self getheldoffhand();
        
        if ( offhand != superoffhand )
        {
            return 1;
        }
        
        wait 0.05;
    }
}

// Namespace perkpackage
// Params 1
// Checksum 0x451ba7d0, Offset: 0x25d6
// Size: 0x63
function perkpackagemenu_disableoffhanduse( duration )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"giveloadout_start" );
    val::set( "field_upgrade_pro", "offhand_primary_weapons", 0 );
    val::set( "field_upgrade_pro", "offhand_secondary_weapons", 0 );
    wait duration;
    val::reset_all( "field_upgrade_pro" );
}

// Namespace perkpackage
// Params 3
// Checksum 0x20679d23, Offset: 0x2641
// Size: 0x2f
function perkpackage_givedebug( superref, blueprintindex, attachments )
{
    perkpackage_giveimmediate( superref, undefined, undefined, blueprintindex, 1, attachments );
}

// Namespace perkpackage
// Params 7
// Checksum 0x2a3efb3, Offset: 0x2678
// Size: 0x188
function perkpackage_giveimmediate( superref, var_9ca4694cf2da3bcd, var_380c922ad517de09, blueprintindex, immediate = 1, var_f53c01849a742526, var_fb3dd6572ad66784 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    perkpackage_initpersdata();
    self.perkpackagedata.istwomode = 0;
    supers_mp::function_7c7012c332084e14();
    
    if ( superref == "super_select" )
    {
        if ( !isdefined( var_9ca4694cf2da3bcd ) )
        {
            var_9ca4694cf2da3bcd = "super_deployed_decoy";
        }
        
        if ( !isdefined( var_380c922ad517de09 ) )
        {
            var_380c922ad517de09 = "super_tac_camera";
        }
        
        self.perkpackagedata.istwomode = 1;
        supers_mp::function_f520ad17bbf59ded();
        perkpackage_giveoverridefieldupgrades( var_9ca4694cf2da3bcd, var_380c922ad517de09, var_f53c01849a742526, var_fb3dd6572ad66784 );
    }
    else
    {
        if ( !level.superglobals.staticsuperdata[ superref ] )
        {
            overrideinfo = level.superglobals.refoverrides[ superref ];
            
            if ( overrideinfo )
            {
                superref = overrideinfo.overrideref;
            }
        }
        
        perkpackage_giveoverridefieldupgrades( superref, undefined, var_f53c01849a742526, var_fb3dd6572ad66784 );
        supers_mp::givesuper( superref, 0, immediate, blueprintindex, var_f53c01849a742526 );
    }
    
    self.perkpackagedata.super = superref;
    self.perkpackagedata.superattachments = var_f53c01849a742526 ?? [];
    
    if ( immediate && ( isbrgamemode() || isdmzgamemode() ) )
    {
        thread supers_mp::function_cb3e288a8ed4df3e( 1 );
        thread supers_mp::handlesuperuistatechange( 2 );
    }
}

// Namespace perkpackage
// Params 1
// Checksum 0x2aeab994, Offset: 0x2808
// Size: 0xc6
function function_74d21cbb27f74e78( id )
{
    if ( !isdefined( level.superglobals.staticsuperdata ) )
    {
        return "none";
    }
    
    foreach ( staticsuperdata in level.superglobals.staticsuperdata )
    {
        if ( staticsuperdata.id === id )
        {
            return staticsuperdata.ref;
        }
    }
    
    return "none";
}

// Namespace perkpackage
// Params 4
// Checksum 0xec4897cf, Offset: 0x28d7
// Size: 0x72
function perkpackage_giveoverridefieldupgrades( fieldupgrade1, fieldupgrade2, fieldupgrade1attachments, fieldupgrade2attachments )
{
    self.overridefieldupgrade1 = fieldupgrade1 ?? "none";
    self.overridefieldupgrade2 = fieldupgrade2 ?? "none";
    self.var_9af0e57bcf353e4d = fieldupgrade1attachments ?? [];
    self.var_210b69c5565617da = fieldupgrade2attachments ?? [];
    perkpackage_updateifchanged();
}

// Namespace perkpackage
// Params 0
// Checksum 0x469e75e9, Offset: 0x2951
// Size: 0x2a
function perkpackage_resetoverridefieldupgrades()
{
    self.overridefieldupgrade1 = undefined;
    self.overridefieldupgrade2 = undefined;
    self.var_9af0e57bcf353e4d = [];
    self.var_210b69c5565617da = [];
}

// Namespace perkpackage
// Params 0
// Checksum 0xf3737d55, Offset: 0x2983
// Size: 0x33
function perkpackage_reset()
{
    self.perkpackagedata.forcereset = 1;
    self.var_715f429307367d79 = 0;
    self.var_6e6f241f7964127e = [];
    perkpackage_updateifchanged();
}

// Namespace perkpackage
// Params 0
// Checksum 0x43b96b2, Offset: 0x29be
// Size: 0x31
function function_a921047acdb4eb1f()
{
    if ( isdefined( self.pers[ "perkPackageData" ] ) )
    {
        self.pers[ "perkPackageData" ].forcereset = 1;
    }
}

