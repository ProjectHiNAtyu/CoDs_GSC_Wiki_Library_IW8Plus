// scripts\mp\frontendfiringrange.gsc  (hash_7e40c68d87e5d0f4.gscc) (size: 37019 Bytes / 0x909b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3bce9682 (1003394690)
// size ...... 37019 (0x909b)
// includes .. 10  (offset: 0x88f7)
// strings ... 120 (offset: 0x8947)
// dev strs .. 6   (offset: 0x9027)
// exports ... 81  (offset: 0x5ebf)
// cseg ...... 0xb3d + 0x5382 (0x5ebf)
// imports ... 230 (offset: 0x6b67)
// animtree1 . 0   (offset: 0x907b)
// animtree2 . 2   (offset: 0x907b)
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\crossbow;
#using scripts\mp\damagefeedback;
#using scripts\mp\frontendutils;
#using scripts\mp\mtx_weapon;
#using scripts\mp\operator;

#namespace frontendfiringrange;

// Namespace frontendfiringrange
// Params 2, eflags: 0x40 variadic
// Checksum 0xa985497a, Offset: 0xb5b
// Size: 0x8a
function function_3fb8295621b2f890( ... )
{
    if ( level.var_234c2a7158e3582 )
    {
        return;
    }
    
    if ( getomnvar( "ui_firing_range_has_started" ) == 1 )
    {
        function_d93dc0e30142bc0a();
        currentweapon = self getcurrentweapon();
        
        if ( isdefined( currentweapon ) && isdefined( currentweapon.weaponblueprint ) )
        {
            setomnvar( "ui_firing_range_weapon_in_use_loot_index", currentweapon.weaponblueprint.lootid );
            return;
        }
        
        setomnvar( "ui_firing_range_weapon_in_use_loot_index", -1 );
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xd8a14131, Offset: 0xbed
// Size: 0x189
function frontend_spawnplayer()
{
    println( "<dev string:x24>" );
    level.transient_soundbanks = spawn( "sound_transient_soundbanks", ( 0, 0, 0 ) );
    self.guid = 0;
    self.team = "allies";
    groundpos = utility::groundpos( level.sectionarray[ "firingrange" ].basecam.origin );
    self spawn( groundpos, level.sectionarray[ "firingrange" ].basecam.angles );
    waitframe();
    self setcamerathirdperson( 0 );
    updateplayerweapon();
    self setclienttriggeraudiozone( "frontend_firingrange", 0.25 );
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
        self.headmodel = undefined;
    }
    
    bodymodelname = self getcustomizationbody();
    headmodelname = self getcustomizationhead();
    viewmodelname = self getcustomizationviewmodel();
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
    
    self setclothtype( #"vestlight" );
    self setgeartype( #"millghtgr" );
    level.playerviewowner.var_ba0fee1a3d02f016 = undefined;
    level.playerviewowner mtx_weapon::onplayerspawnedmtx();
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x6dbb7459, Offset: 0xd7e
// Size: 0x95
function function_2e0a8c011b3d1851( var_aa5ad549f8090ce6 )
{
    if ( !getomnvar( "ui_firing_range_has_started" ) )
    {
        return;
    }
    
    if ( var_aa5ad549f8090ce6 )
    {
        function_fdd6e9ab83afde9();
    }
    
    println( "<dev string:x34>" );
    self.sessionstate = "playing";
    self.statusicon = "";
    
    if ( self.settospectate )
    {
        self endon( #"disconnect" );
        level endon( #"game_ended" );
        level endon( #"exit_firing_range" );
        self.settospectate = 0;
        waitframe();
        frontend_spawnplayer();
    }
    
    self cameraunlink();
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xd7220869, Offset: 0xe1b
// Size: 0x6a
function getdefaultweapon( isprimary )
{
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) && isdefined( gamemodebundle.weaponlist ) )
    {
        weaponlistbundle = getscriptbundle( gamemodebundle.weaponlist );
        
        if ( isprimary )
        {
            return weaponlistbundle.defaultprimaryweapon;
        }
        
        return weaponlistbundle.defaultsecondaryweapon;
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x303aaba4, Offset: 0xe8d
// Size: 0x3a6
function updateplayerweapon()
{
    if ( isdefined( self.primaryweaponobj ) )
    {
        self takeweapon( self.primaryweaponobj );
    }
    
    if ( isdefined( self.secondaryweaponobj ) && self.secondaryweaponobj.basename != "none" )
    {
        self takeweapon( self.secondaryweaponobj );
    }
    
    self.primaryweaponobj = undefined;
    self.secondaryweaponobj = undefined;
    loadoutdata = self function_cb8df376b3e57420();
    self.primaryweaponobj = loadoutdata.primaryweaponentityindex;
    
    if ( !isdefined( self.primaryweaponobj ) || self.primaryweaponobj.basename == "none" )
    {
        primaryweapon = getdefaultweapon( 1 );
        self.primaryweaponobj = weapon::buildweapon( primaryweapon, [], "camo_none", "none", 0, [], "none", [], 0, [] );
    }
    
    self giveweapon( self.primaryweaponobj );
    self setweaponammoclip( self.primaryweaponobj, weaponclipsize( self.primaryweaponobj ) );
    self setweaponammostock( self.primaryweaponobj, weaponmaxammo( self.primaryweaponobj ) );
    self setactionslot( 3, "altmode" );
    self.secondaryweaponobj = loadoutdata.secondaryweaponentityindex;
    
    if ( !isdefined( self.secondaryweaponobj ) || self.secondaryweaponobj.basename == "none" )
    {
        secondaryweapon = getdefaultweapon();
        self.secondaryweaponobj = weapon::buildweapon( secondaryweapon, [], "camo_none", "none", 0, [], "none", [], 0, [] );
    }
    
    self giveweapon( self.secondaryweaponobj );
    self setweaponammoclip( self.secondaryweaponobj, weaponclipsize( self.secondaryweaponobj ) );
    self setweaponammostock( self.secondaryweaponobj, weaponmaxammo( self.secondaryweaponobj ) );
    self switchtoweaponimmediate( self.primaryweaponobj );
    
    if ( isdefined( self.primaryweaponobj ) && isdefined( self.primaryweaponobj.weaponblueprint ) )
    {
        setomnvar( "ui_firing_range_weapon_in_use_loot_index", self.primaryweaponobj.weaponblueprint.lootid );
    }
    else
    {
        setomnvar( "ui_firing_range_weapon_in_use_loot_index", -1 );
    }
    
    if ( !isdefined( level.playerviewowner.operatorcustomization ) )
    {
        level.playerviewowner.operatorcustomization = spawnstruct();
    }
    
    level.playerviewowner.operatorcustomization.skinref = loadoutdata.skinref;
    
    if ( loadoutdata.skinref )
    {
        reactiveoperator = operator::getreactiveoperator( loadoutdata.skinref );
        
        if ( reactiveoperator )
        {
            level.playerviewowner function_184d7ec010cfaa92( reactiveoperator );
        }
    }
    
    foreach ( dummy in level.firing_range_targets )
    {
        if ( !dummy.ismovabledummy )
        {
            continue;
        }
        
        dummy thread function_79ec23a13bb782d0( dummy.proxyent, self );
    }
    
    thread function_7d5cfd5e524d2aea( self.primaryweaponobj );
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x8ae90f96, Offset: 0x123b
// Size: 0x241
function updateWeaponSwitch()
{
    self notify( #"updateWeaponSwitch" );
    self endon( #"updateWeaponSwitch" );
    previousweap = undefined;
    firstweaponswitch = 1;
    
    while ( true )
    {
        self waittill( #"weapon_change" );
        level.var_65d3ec21afb8c1b1 = 0;
        level.var_6d20f1bfea78492e = 0;
        level.var_ec67017c22f64929 = 0;
        level.bulletshitsecondary = 0;
        level.var_ebf908e3e5e96aa7 = 0;
        setomnvar( "ui_firing_range_lane", 1 );
        setomnvar( "ui_firing_range_accuracy", 0 );
        setomnvar( "ui_firing_range_target_kill_count", 0 );
        setomnvar( "ui_firing_range_tot_damage", 0 );
        setomnvar( "ui_firing_range_ttk", 0 );
        
        foreach ( dummy in level.firing_range_targets )
        {
            dummy.firstdamagetime = undefined;
            
            if ( !dummy.ismovabledummy )
            {
                continue;
            }
            
            dummy thread function_79ec23a13bb782d0( dummy.proxyent, self, firstweaponswitch );
        }
        
        recoil_panel = getent( "recoil_panel", #script_noteworthy );
        
        if ( isdefined( recoil_panel ) )
        {
            if ( firstweaponswitch )
            {
                recoil_panel.angles = ( 90, 0, 0 );
            }
            
            thread initializePanelBehaviour( recoil_panel );
        }
        
        firstweaponswitch = 0;
        weapon = self getcurrentweapon();
        
        if ( damage_utility::iscrossbowdamage( weapon ) )
        {
            thread crossbow::initcrossbowusage();
            thread crossbow::crossbowusageloop( weapon );
        }
        
        if ( getweaponhasperk( weapon, "specialty_ub_crossbow" ) )
        {
            thread function_a7c41fa3e19dcfd9();
        }
        
        if ( isdefined( weapon ) && isdefined( weapon.weaponblueprint ) )
        {
            setomnvar( "ui_firing_range_weapon_in_use_loot_index", weapon.weaponblueprint.lootid );
        }
        else
        {
            setomnvar( "ui_firing_range_weapon_in_use_loot_index", -1 );
        }
        
        mtx_weapon::function_215f432bc7345e71( weapon );
        function_d99cec6ead064213( weapon, previousweap );
        previousweap = weapon;
    }
}

// Namespace frontendfiringrange
// Params 2
// Checksum 0x4219e2f7, Offset: 0x1484
// Size: 0x1f
function function_d99cec6ead064213( currweaponobj, prevweaponobj )
{
    weaponattachmentperkupdate( currweaponobj, prevweaponobj );
}

// Namespace frontendfiringrange
// Params 2
// Checksum 0x19c0e7c5, Offset: 0x14ab
// Size: 0x239
function weaponattachmentperkupdate( currweaponobj, prevweaponobj )
{
    newattachments = undefined;
    oldattachments = undefined;
    
    if ( !isundefinedweapon( prevweaponobj ) )
    {
        oldattachments = getweaponattachments( prevweaponobj );
        
        if ( oldattachments.size > 0 )
        {
            foreach ( oldattach in oldattachments )
            {
                perks = function_af968e89b7c034f0( prevweaponobj, oldattach );
                
                if ( !isdefined( perks ) )
                {
                    continue;
                }
                
                foreach ( perk in perks )
                {
                    frontend_removeperk( perk );
                }
            }
        }
    }
    
    if ( !isundefinedweapon( currweaponobj ) )
    {
        newattachments = getweaponattachments( currweaponobj );
        
        if ( newattachments.size > 0 )
        {
            foreach ( newattach in newattachments )
            {
                perks = function_af968e89b7c034f0( currweaponobj, newattach );
                
                if ( !isdefined( perks ) )
                {
                    continue;
                }
                
                foreach ( perk in perks )
                {
                    frontend_giveperk( perk );
                }
            }
        }
    }
}

// Namespace frontendfiringrange
// Params 2
// Checksum 0xaa9c84d5, Offset: 0x16ec
// Size: 0xc2
function function_af968e89b7c034f0( weaponobj, attachmentname )
{
    attachperks = function_85c28ebf8918783c( weaponobj, attachmentname );
    
    if ( isdefined( attachperks ) )
    {
        var_bb6b6d77d6f9c7f1 = [];
        
        foreach ( perk in attachperks )
        {
            var_3c8ec0ced7385c88 = function_14f8b14e310e3df8( perk );
            
            if ( isdefined( var_3c8ec0ced7385c88 ) )
            {
                var_bb6b6d77d6f9c7f1[ var_bb6b6d77d6f9c7f1.size ] = var_3c8ec0ced7385c88;
            }
        }
        
        return var_bb6b6d77d6f9c7f1;
    }
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x9afa4579, Offset: 0x17b7
// Size: 0x28
function function_14f8b14e310e3df8( perk )
{
    switch ( perk )
    {
        case #"hash_fbc8c549d7e39757":
            return "specialty_fastreload";
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x244458b4, Offset: 0x17e8
// Size: 0x12
function function_b4d2e3406027eec5()
{
    updateplayerweapon();
    function_2e0a8c011b3d1851( 1 );
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xf04da7ab, Offset: 0x1802
// Size: 0x6b
function function_86a9f6833f670d0d()
{
    player = self;
    loadout_clearperks();
    
    if ( level.var_864871a73700178d )
    {
        player function_55f82390d475f3cc( "specialty_pistoldraw" );
        player function_55f82390d475f3cc( "specialty_selectivehearing" );
        player function_55f82390d475f3cc( "specialty_quickswap" );
        return;
    }
    
    player function_55f82390d475f3cc( "specialty_pistoldraw" );
    player function_55f82390d475f3cc( "specialty_selectivehearing" );
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x27c18d2a, Offset: 0x1875
// Size: 0x59
function function_55f82390d475f3cc( perkname )
{
    player = self;
    
    if ( !isdefined( player.loadoutperks ) )
    {
        player.loadoutperks = [];
    }
    
    player frontend_giveperk( perkname );
    player.loadoutperks[ player.loadoutperks.size ] = perkname;
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x24e958c8, Offset: 0x18d6
// Size: 0x23
function frontend_giveperk( perk )
{
    player = self;
    player setperk( perk, 1 );
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x636910b4, Offset: 0x1901
// Size: 0x23
function frontend_removeperk( perk )
{
    player = self;
    player unsetperk( perk, 1 );
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xe09c8550, Offset: 0x192c
// Size: 0xa7
function loadout_clearperks()
{
    player = self;
    
    if ( !isdefined( player.loadoutperks ) )
    {
        return;
    }
    
    foreach ( perkname in player.loadoutperks )
    {
        player unsetperk( perkname, 1 );
    }
    
    player.loadoutperks = [];
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x8dfe172a, Offset: 0x19db
// Size: 0xe0
function function_62bd406831db8f68()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    function_95437b3e5726ad89();
    level.thirdpersondvarvalue = getdvarint( @"camera_thirdperson", 0 );
    setdvar( @"camera_thirdperson", 0 );
    
    if ( !isdefined( level.var_f451bf7e9a4e2166 ) )
    {
        level.var_f451bf7e9a4e2166 = self getcamerathirdperson();
    }
    
    level.gamemodebundle = getgamemodescriptbundle();
    println( "<dev string:x54>" );
    suitname = utility::function_3d02f6af6042aa67();
    self setsuit( suitname );
    println( "<dev string:x34>" );
    self.sessionstate = "playing";
    self.statusicon = "";
    function_a29beb13ea2a48ad( 1 );
    waitframe();
    self.settospectate = 0;
    frontend_spawnplayer();
    self function_5ba9f6826d11778e();
    function_d93dc0e30142bc0a();
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xbdba0b85, Offset: 0x1ac3
// Size: 0x9
function function_bb71c1fb5408ca04()
{
    updateplayerweapon();
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xeec26396, Offset: 0x1ad4
// Size: 0x106
function function_ffb5613c989cd070()
{
    self setcamerathirdperson( level.var_f451bf7e9a4e2166 );
    level.var_f451bf7e9a4e2166 = undefined;
    setdvar( @"camera_thirdperson", level.thirdpersondvarvalue );
    function_975c17bde7e82d6();
    origin = level.sectionarray[ "loadout_showcase" ].basecam.origin ?? ( 0, 0, 0 );
    angles = level.sectionarray[ "loadout_showcase" ].basecam.angles ?? ( 0, 0, 0 );
    self setspectatedefaults( origin, angles );
    self cameralinkto( level.camera_anchor, "tag_origin" );
    setomnvar( "ui_firing_range_has_started", 0 );
    setomnvar( "ui_firing_range_lane", -1 );
    function_9f6834cdc0c1becc();
    function_a29beb13ea2a48ad( 0 );
    self function_5a15b3baf50bc587();
    level notify( #"exit_firing_range" );
}

// Namespace frontendfiringrange
// Params 2, eflags: 0x40 variadic
// Checksum 0x82fab30b, Offset: 0x1be2
// Size: 0x342
function function_232489312b237c86( ... )
{
    if ( level.var_234c2a7158e3582 )
    {
        return;
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    level.var_c230571f1ddf3ee6 = 0;
    setomnvar( "ui_firing_range_has_started", 1 );
    function_95437b3e5726ad89();
    level.thirdpersondvarvalue = getdvarint( @"camera_thirdperson", 0 );
    setdvar( @"camera_thirdperson", 0 );
    
    if ( !isdefined( level.var_f451bf7e9a4e2166 ) )
    {
        level.var_f451bf7e9a4e2166 = self getcamerathirdperson();
    }
    
    foreach ( trig in level.lanetriggers )
    {
        trig.var_33f76c2d569e4abf = 0;
    }
    
    if ( function_941bfbb474f39cde() )
    {
        level.var_73cb6a603e7b0a8f = gettime();
        level.var_4ba0784de7cbe969 = 0;
        level.var_abc1df8893fd72c5 = 0;
        level.var_4df5c8890bd99e4f = 0;
        level.var_6c05f0950ec69685 = 0;
    }
    
    level.var_864871a73700178d = getprojectname() == "WZ2" || getprojectname() == "SAW" ? 1 : 0;
    level thread function_533453ef891c8da1();
    level.var_65d3ec21afb8c1b1 = 0;
    level.var_6d20f1bfea78492e = 0;
    level.var_ec67017c22f64929 = 0;
    level.bulletshitsecondary = 0;
    level.var_38e10219d88bb19c = 0;
    level.var_edd9d75d4e242354 = 0;
    level.var_ebf908e3e5e96aa7 = 0;
    level.gamemodebundle = getgamemodescriptbundle();
    level.var_a177b2baa36179c9 = throttle::throttle_initialize( "nembus_detonation" );
    setomnvar( "ui_firing_range_accuracy", 1 );
    setomnvar( "ui_firing_range_target_kill_count", 1 );
    setomnvar( "ui_firing_range_tot_damage", 1 );
    setomnvar( "ui_firing_range_target_range", 1 );
    setomnvar( "ui_firing_range_ttk", 1 );
    
    if ( function_120e71871fb92f69() )
    {
        setdvar( @"hash_4033da1e021e6d5", 0 );
        level.var_15a1d4ce0883a965 = gettime();
        level.var_bfc1156387b479bb = 0;
        level.var_7b135d1536298f8e = 0;
        level.var_75cb0c6c413e69d5 = 0;
        level.var_28d38438e08910d4 = 0;
    }
    
    println( "<dev string:x54>" );
    suitname = utility::function_3d02f6af6042aa67();
    self setsuit( suitname );
    println( "<dev string:x34>" );
    self.sessionstate = "playing";
    self.statusicon = "";
    waitframe();
    self.settospectate = 0;
    frontend_spawnplayer();
    function_deef98f99656c6af();
    function_86a9f6833f670d0d();
    thread function_8f6b33a18012760e();
    thread infiniteammo();
    thread updateWeaponSwitch();
    thread function_39417c370429569();
    
    /#
        thread function_f01ff36db2e217b3();
    #/
    
    thread function_438354bc8387bd87();
    recoil_panel = getent( "recoil_panel", #script_noteworthy );
    
    if ( isdefined( recoil_panel ) )
    {
        thread initializePanelBehaviour( recoil_panel );
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x51ebb11e, Offset: 0x1f2c
// Size: 0x42
function function_8f6b33a18012760e()
{
    level endon( #"exit_firing_range" );
    self notify( #"resetweaponstats" );
    self endon( #"resetweaponstats" );
    
    while ( true )
    {
        level waittill( #"firing_range_weapon_stats_reset" );
        function_deef98f99656c6af();
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xdb79b4d4, Offset: 0x1f76
// Size: 0x7a
function function_deef98f99656c6af()
{
    self.var_2102a2d0be3461d9 = 0;
    self.var_77e861f8d388441d = 0;
    self.var_2dcefb4ab3452bf3 = 0;
    self.var_e48b4294f9178c53 = 0;
    self.var_ea29b694b7afa122 = 0;
    self.var_910beafca8020768 = 0;
    self.var_a68b4227d7dc67b9 = 0;
    self.var_4a28bdd45dfb1a7d = 0;
    self.var_f5bdad532aeadd53 = 0;
    self.var_f59814ff13303233 = 0;
    self.var_c2dc71d5213e6802 = 0;
    self.var_491885e356b317c8 = 0;
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xd6dae7ac, Offset: 0x1ff8
// Size: 0xaf
function function_975c17bde7e82d6()
{
    self.settospectate = 1;
    
    if ( isdefined( self.primaryweaponobj ) )
    {
        if ( self hasweapon( self.primaryweaponobj ) )
        {
            self takeweapon( self.primaryweaponobj );
            self clearclienttriggeraudiozone( 3 );
        }
    }
    
    if ( isdefined( self.secondaryweaponobj ) )
    {
        if ( self hasweapon( self.secondaryweaponobj ) )
        {
            self takeweapon( self.secondaryweaponobj );
        }
    }
    
    self suicide();
    waitframe();
    
    if ( isent( level.transient_soundbanks ) )
    {
        level.transient_soundbanks delete();
    }
    
    self allowspectateteam( "none", 1 );
    self.sessionstate = "spectator";
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x42fa4713, Offset: 0x20af
// Size: 0x29, Type: bool
function function_120e71871fb92f69()
{
    return getdvarint( @"hash_e46b4b4f19be660b", 0 ) == 1 && getdvarint( @"hash_c006752ec3578568", -1 ) > -1;
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xef334762, Offset: 0x20e1
// Size: 0xc3
function function_9020b424ac3b3f08()
{
    var_57a1f29c598edb97 = [ "bundle_id", getdvarint( @"hash_c006752ec3578568" ), "nb_bullet_fired", level.var_bfc1156387b479bb ?? 0, "nb_inspection", getdvarint( @"hash_4033da1e021e6d5" ), "nb_target_killed", level.var_28d38438e08910d4 ?? 0, "accuracy", level.var_75cb0c6c413e69d5 ?? 0, "time_spent_in_firing_range", gettime() - ( level.var_15a1d4ce0883a965 ?? gettime() ) ];
    dlog_recordevent( "dlog_event_try_a_gun_stats", var_57a1f29c598edb97 );
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xb6633140, Offset: 0x21ac
// Size: 0x14, Type: bool
function function_941bfbb474f39cde()
{
    return getdvarint( @"hash_3e7f94c85db5827a", 1 ) == 1;
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x14a34eea, Offset: 0x21c9
// Size: 0x171
function function_1339d93f11b7327e()
{
    if ( !function_941bfbb474f39cde() )
    {
        return;
    }
    
    var_7e2a1fb26e960434 = [ "time_spent_in_firing_range", gettime() - level.var_73cb6a603e7b0a8f ?? 0, "last_primary_weapon", self.primaryweaponobj.basename ?? "", "last_primary_type", "todo", "last_seconday_weapon", self.secondaryweaponobj.basename ?? "", "last_secondary_type", "todo", "last_bullets_fired", level.var_65d3ec21afb8c1b1 + level.var_ec67017c22f64929 ?? 0, "last_targets_killed", getomnvar( "ui_firing_range_target_kill_count" ), "last_accuracy", getomnvar( "ui_firing_range_accuracy" ), "num_plates_zero", level.var_4ba0784de7cbe969 ?? 0, "num_plates_one", level.var_abc1df8893fd72c5 ?? 0, "num_plates_two", level.var_4df5c8890bd99e4f ?? 0, "num_plates_three", level.var_6c05f0950ec69685 ?? 0 ];
    dlog_recordevent( "dlog_event_firing_range_stats", var_7e2a1fb26e960434 );
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xb0bb81f4, Offset: 0x2342
// Size: 0x82
function function_88d7f49f9e5ab266()
{
    if ( !function_941bfbb474f39cde() )
    {
        return;
    }
    
    switch ( level.var_a915beb05994e493 )
    {
        case 0:
            level.var_4ba0784de7cbe969++;
            break;
        case 1:
            level.var_abc1df8893fd72c5++;
            break;
        case 2:
            level.var_4df5c8890bd99e4f++;
            break;
        case 3:
            level.var_6c05f0950ec69685++;
            break;
    }
}

// Namespace frontendfiringrange
// Params 2, eflags: 0x40 variadic
// Checksum 0x4cdf361f, Offset: 0x23cc
// Size: 0x25c
function function_4dbdb6e6debb40ee( ... )
{
    if ( level.var_234c2a7158e3582 )
    {
        return;
    }
    
    if ( level.var_c230571f1ddf3ee6 )
    {
        return;
    }
    
    level.var_c230571f1ddf3ee6 = 1;
    function_1339d93f11b7327e();
    self setcamerathirdperson( level.var_f451bf7e9a4e2166 );
    level.var_f451bf7e9a4e2166 = undefined;
    setdvar( @"camera_thirdperson", level.thirdpersondvarvalue );
    function_975c17bde7e82d6();
    origin = level.sectionarray[ "loadout_showcase" ].basecam.origin ?? ( 0, 0, 0 );
    angles = level.sectionarray[ "loadout_showcase" ].basecam.angles ?? ( 0, 0, 0 );
    self setspectatedefaults( origin, angles );
    self cameralinkto( level.camera_anchor, "tag_origin" );
    setomnvar( "ui_firing_range_has_started", 0 );
    setomnvar( "ui_firing_range_lane", -1 );
    
    if ( function_120e71871fb92f69() )
    {
        function_9020b424ac3b3f08();
        setdvar( @"hash_c006752ec3578568", -1 );
    }
    
    level.var_65d3ec21afb8c1b1 = 0;
    level.var_6d20f1bfea78492e = 0;
    level.var_ec67017c22f64929 = 0;
    level.bulletshitsecondary = 0;
    level.var_38e10219d88bb19c = 0;
    level.var_edd9d75d4e242354 = 0;
    level.var_ebf908e3e5e96aa7 = 0;
    function_deef98f99656c6af();
    setomnvar( "ui_firing_range_accuracy", 0 );
    setomnvar( "ui_firing_range_target_kill_count", 0 );
    setomnvar( "ui_firing_range_tot_damage", 0 );
    setomnvar( "ui_firing_range_target_range", 0 );
    setomnvar( "ui_firing_range_ttk", 0 );
    level notify( #"exit_firing_range" );
    
    foreach ( target in level.firing_range_targets )
    {
        target thread respawntarget();
    }
    
    function_9f6834cdc0c1becc();
}

// Namespace frontendfiringrange
// Params 2, eflags: 0x40 variadic
// Checksum 0x42166e33, Offset: 0x2630
// Size: 0x3d
function function_7eb21b04340b04d( ... )
{
    if ( level.var_234c2a7158e3582 )
    {
        return;
    }
    
    if ( getomnvar( "ui_firing_range_has_started" ) == 1 )
    {
        function_d93dc0e30142bc0a();
        function_4dbdb6e6debb40ee();
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x948408b6, Offset: 0x2675
// Size: 0xbd
function infiniteammo()
{
    level endon( #"exit_firing_range" );
    self notify( #"infiniteammo" );
    self endon( #"infiniteammo" );
    
    while ( true )
    {
        weapons = self getweaponslistprimaries();
        
        foreach ( weapon in weapons )
        {
            self givemaxammo( weapon );
            self setweaponammostock( weapon, weaponmaxammo( weapon ) );
        }
        
        waitframe();
    }
}

// Namespace frontendfiringrange
// Params 1, eflags: 0x4
// Checksum 0x8e924bb4, Offset: 0x273a
// Size: 0x1af
function private initializePanelBehaviour( panel )
{
    level endon( #"exit_firing_range" );
    level notify( #"initializePanelBehaviour" );
    level endon( #"initializePanelBehaviour" );
    
    if ( !isdefined( level.var_4a3c3d2624e15d37 ) )
    {
        level.var_4a3c3d2624e15d37 = 0;
    }
    
    buttonhelddown = 0;
    
    foreach ( dummy in level.firing_range_targets )
    {
        if ( !dummy.ismovabledummy )
        {
            continue;
        }
        
        movabledummy = dummy;
    }
    
    while ( true )
    {
        var_978ae5ddcdf4930a = self function_9ed57b4b1e9ea092();
        
        if ( var_978ae5ddcdf4930a && !buttonhelddown )
        {
            buttonhelddown = 1;
            level.var_4a3c3d2624e15d37++;
            
            if ( level.var_4a3c3d2624e15d37 > 2 )
            {
                level.var_4a3c3d2624e15d37 = 0;
            }
            
            switch ( level.var_4a3c3d2624e15d37 )
            {
                case 0:
                    panel function_7b4575eadc9f4( 1 );
                    break;
                case 1:
                    movabledummy function_aba6b28f7dfdf4de( 0 );
                    break;
                case 2:
                    removeallfxmarks();
                    panel function_7b4575eadc9f4( 0 );
                    movabledummy function_aba6b28f7dfdf4de( 1 );
                    break;
            }
            
            wait 0.8;
        }
        else if ( !var_978ae5ddcdf4930a && buttonhelddown )
        {
            buttonhelddown = 0;
        }
        
        waitframe();
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x7604c7e8, Offset: 0x28f1
// Size: 0x1ea
function function_a7c41fa3e19dcfd9()
{
    level endon( #"exit_firing_range" );
    self endon( #"weapon_change" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"missile_fire", glgrenade, objweapon );
        
        if ( isdefined( objweapon ) && isdefined( glgrenade ) && getweaponhasperk( objweapon, "specialty_ub_crossbow" ) )
        {
            glgrenade waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
            stuckposition = position - normal;
            objweapon = makeweapon( "t10_ub_crossbow_explosive_bolt_mp" );
            
            if ( objweapon.basename != "none" )
            {
                grenade = self launchgrenade( "t10_ub_crossbow_explosive_bolt_mp", stuckposition, ( 0, 0, 0 ) );
                
                if ( grenade )
                {
                    grenade.angles = glgrenade.angles;
                    
                    if ( isdefined( stuckto ) )
                    {
                        if ( isdefined( stuckpart ) && stuckto.model != "" && stuckpart != "scriptbrushmodeldummy" && stuckto.classname != "script_brushmodel" )
                        {
                            grenade linkto( stuckto, stuckpart );
                        }
                        else
                        {
                            grenade linkto( stuckto );
                        }
                    }
                    else
                    {
                        staticlink = utility::spawn_script_origin( stuckposition, normal );
                        grenade linkto( staticlink );
                        grenade.staticlink = staticlink;
                        staticlink thread utility::delete_after_delay( 3 );
                    }
                    
                    if ( grenade isscriptable() && grenade getscriptableparthasstate( "state", "warning" ) )
                    {
                        grenade setscriptablepartstate( "state", "warning" );
                    }
                }
            }
            
            if ( isdefined( glgrenade ) )
            {
                glgrenade delete();
            }
        }
    }
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x3d162046, Offset: 0x2ae3
// Size: 0xcd
function function_aba6b28f7dfdf4de( var_f694a141b5dd55de )
{
    dummy = self;
    rotatetoangles = var_f694a141b5dd55de ? ( 90, 0, 0 ) : ( 0, 0, 0 );
    var_f694a141b5dd55de = !var_f694a141b5dd55de;
    dummy.scriptorigin rotateto( rotatetoangles, 0.8 );
    
    if ( var_f694a141b5dd55de )
    {
        dummy.proxyent setcandamage( 1 );
        dummy enableaimassist();
        dummy solid();
        dummy playsound( "amb_emt_t10_shooting_range_target_down" );
        return;
    }
    
    dummy.proxyent setcandamage( 0 );
    dummy disableaimassist();
    dummy notsolid();
    dummy playsound( "amb_emt_t10_shooting_range_target_up" );
    dummy notify( #"entitydeleted" );
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xa7756d17, Offset: 0x2bb8
// Size: 0x7d
function function_7b4575eadc9f4( var_a3aab0a6fe311248 )
{
    panel = self;
    soundtoplay = var_a3aab0a6fe311248 ? "amb_emt_t10_shooting_range_panel_up" : "amb_emt_t10_shooting_range_panel_down";
    rotatetoangle = var_a3aab0a6fe311248 ? ( 90, 0, 0 ) : ( 0, 0, 0 );
    var_a3aab0a6fe311248 = !var_a3aab0a6fe311248;
    panel playsound( soundtoplay );
    panel rotateto( rotatetoangle, 0.8, 0, 0 );
}

/#

    // Namespace frontendfiringrange
    // Params 0
    // Checksum 0x2b05b182, Offset: 0x2c3d
    // Size: 0x60, Type: dev
    function function_f01ff36db2e217b3()
    {
        level endon( #"exit_firing_range" );
        
        while ( true )
        {
            var_efcc1a91acb98c0d = getdvarint( @"scr_firing_range_dummy_plates", -1 );
            
            if ( var_efcc1a91acb98c0d != -1 )
            {
                setdvar( @"scr_firing_range_dummy_plates", -1 );
                self notify( #"luinotifyserver", "<dev string:x61>", var_efcc1a91acb98c0d );
            }
            
            waitframe();
        }
    }

#/

// Namespace frontendfiringrange
// Params 1
// Checksum 0x1dff8984, Offset: 0x2ca5
// Size: 0xe8
function function_2de3b0117ec0842c( numplates )
{
    var_52102604ae74f363 = level.var_a915beb05994e493;
    level.var_a915beb05994e493 = int( max( 0, numplates ) );
    setomnvar( "ui_firing_range_num_dummy_plates", level.var_a915beb05994e493 );
    
    foreach ( ent in level.firing_range_targets )
    {
        ent.proxyent.health = function_c76d6117f2e172ac();
    }
    
    if ( var_52102604ae74f363 != level.var_a915beb05994e493 )
    {
        function_88d7f49f9e5ab266();
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x656bc949, Offset: 0x2d95
// Size: 0x65
function function_438354bc8387bd87()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    level endon( #"exit_firing_range" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, val );
        
        if ( channel == "ui_set_dummy_num_plates" )
        {
            function_2de3b0117ec0842c( val );
        }
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x89d67be6, Offset: 0x2e02
// Size: 0x23
function function_c76d6117f2e172ac()
{
    healthamount = function_608451b25e6fe222() + level.var_a915beb05994e493 * 50;
    return healthamount;
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x1a4391e4, Offset: 0x2e2e
// Size: 0x32
function function_608451b25e6fe222()
{
    if ( level.var_864871a73700178d )
    {
        defaultmaxhealth = getdvarint( @"scr_firingrange_maxhealth", 150 );
    }
    else
    {
        defaultmaxhealth = 100;
    }
    
    return defaultmaxhealth;
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xdbb00e2e, Offset: 0x2e69
// Size: 0x4aa
function function_533453ef891c8da1()
{
    if ( !isdefined( level.firing_range_targets ) )
    {
        level.var_a915beb05994e493 = level.var_864871a73700178d ? 3 : 0;
        setomnvar( "ui_firing_range_num_dummy_plates", level.var_a915beb05994e493 );
        level.firing_range_targets = frontendutils::function_55f1609e123f6a51( "enemyTarget" );
        
        foreach ( ent in level.firing_range_targets )
        {
            ent.proxyent = spawn( "script_origin", ent.origin );
            ent.proxyent.owner = ent;
            ent.proxyent.health = function_c76d6117f2e172ac();
            ent.brushes = getentarray( ent.target, #targetname );
            
            foreach ( brush in ent.brushes )
            {
                brush.owner = ent;
                brush thread function_dfac2d0f32995de9();
                brush setcandamage( 1 );
            }
            
            ent.proxyent thread function_446d540a417a481c();
            ent mtx_weapon::onplayerspawnedmtx();
            
            if ( getdvarint( @"hash_19cb7a793ce35f97", 0 ) == 0 )
            {
                ent thread function_64d23f1f2c62f4c3();
            }
        }
        
        movabledummy = getent( "enemyTargetRail_cer", #targetname );
        
        if ( isdefined( movabledummy ) )
        {
            level.firing_range_targets[ level.firing_range_targets.size ] = movabledummy;
            movabledummy.proxyent = spawn( "script_origin", movabledummy.origin );
            movabledummy.proxyent.owner = movabledummy;
            movabledummy.proxyent.health = function_c76d6117f2e172ac();
            movabledummy.mountrailing = getent( "railTarget_cer", #targetname );
            movabledummy linkto( movabledummy.mountrailing, "tag_origin" );
            movabledummy.scriptorigin = spawn( "script_model", movabledummy.mountrailing.origin );
            movabledummy.scriptorigin setmodel( "tag_origin" );
            movabledummy.mountrailing linkto( movabledummy.scriptorigin, "tag_origin" );
            movabledummy.brushes = getentarray( movabledummy.target, #targetname );
            movabledummy.ismovabledummy = 1;
            
            foreach ( brush in movabledummy.brushes )
            {
                brush.owner = movabledummy;
                brush enablelinkto();
                brush linkto( movabledummy, "tag_origin" );
                brush thread function_dfac2d0f32995de9();
            }
            
            movabledummy.proxyent thread function_446d540a417a481c();
            movabledummy mtx_weapon::onplayerspawnedmtx();
            
            if ( getdvarint( @"hash_19cb7a793ce35f97", 0 ) == 0 )
            {
                movabledummy thread function_64d23f1f2c62f4c3();
            }
        }
    }
    else
    {
        foreach ( ent in level.firing_range_targets )
        {
            ent.proxyent.health = function_c76d6117f2e172ac();
        }
    }
    
    function_88d7f49f9e5ab266();
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xfb6ba6de, Offset: 0x331b
// Size: 0x170
function function_64d23f1f2c62f4c3()
{
    defaultpos = self.origin + ( 0, 0, 40 );
    self.lastimpactpos = defaultpos;
    defaultdir = ( 0, 0, 1 );
    self.var_b7b7296658a13c3f = defaultdir;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, var_7edd83e15d43a9b0 );
        defaultpos = self.origin + ( 0, 0, 40 );
        
        if ( distance( point, defaultpos ) < 48 )
        {
            self.lastimpactpos = point;
            self.var_b7b7296658a13c3f = direction_vec;
        }
        else
        {
            self.lastimpactpos = defaultpos;
            self.var_b7b7296658a13c3f = defaultdir;
        }
        
        /#
            level thread drawsphere( self.lastimpactpos, 2, 5, ( 1, 0, 0 ) );
        #/
    }
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x793a6f47, Offset: 0x3493
// Size: 0x3c6
function function_dfac2d0f32995de9( ismodel )
{
    firingrangeent = self;
    data = spawnstruct();
    data.damage = 0;
    level.playerviewowner.lastshottime = 0;
    
    while ( true )
    {
        firingrangeent waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, var_7edd83e15d43a9b0 );
        
        if ( level.playerviewowner.lastshottime == gettime() )
        {
            continue;
        }
        
        level.playerviewowner.lastshottime = gettime();
        attacker = level.playerviewowner;
        
        if ( ismodel )
        {
            victim = firingrangeent;
        }
        else
        {
            victim = firingrangeent.owner;
        }
        
        hitloc = "torso_upper";
        
        if ( isdefined( firingrangeent.script_noteworthy ) )
        {
            switch ( firingrangeent.script_noteworthy )
            {
                case #"hash_b107b5547c755d23":
                    hitloc = "head";
                    break;
                case #"hash_92bbfe494d03d772":
                    hitloc = "neck";
                    break;
                case #"hash_24df6c1a53c03c53":
                    hitloc = "torso_upper";
                    break;
                case #"hash_aa63b4eb30a83f7a":
                    hitloc = "torso_lower";
                    break;
                case #"hash_acfb90a9d1526a42":
                    hitloc = "right_arm_upper";
                    break;
                case #"hash_c12ea512f3bb658f":
                    hitloc = "right_arm_lower";
                    break;
                case #"hash_86d069a9bd083804":
                    hitloc = "right_leg_upper";
                    break;
                case #"hash_713cfc12ca4421d9":
                    hitloc = "right_leg_lower";
                    break;
            }
        }
        
        data.origin = firingrangeent.origin;
        data.attacker = attacker;
        data.meansofdeath = meansofdeath;
        data.weapon = attacker getcurrentweapon();
        data.hitloc = hitloc;
        data.idflags = idflags;
        
        if ( data.idflags & 262144 )
        {
            weapondamagetype = 2;
        }
        else
        {
            weapondamagetype = 0;
        }
        
        scaleddamage = int( floor( damage * getweaponhitlocdamagemultiplier( attacker getcurrentweapon(), hitloc, weapondamagetype ) ) );
        data.damage = scaleddamage;
        
        if ( isspreadweapon( data.weapon ) )
        {
            data.damage = spreadshotdamagemod( victim, data.attacker, data.weapon, data.damage, data.idflags );
        }
        
        if ( data.damage > 0 )
        {
            /#
                print3d( firingrangeent.origin, data.damage, ( 1, 0, 0 ), 1, 0.75, 75 );
            #/
            
            /#
                print3d( firingrangeent.origin + ( 0, 0, 13 ), hitloc, ( 1, 1, 1 ), 1, 0.5, 75 );
            #/
            
            victim thread processDamageThisFrame( data );
        }
    }
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x91b89b17, Offset: 0x3861
// Size: 0xc54
function processDamageThisFrame( instance )
{
    proxyent = self.proxyent;
    
    if ( proxyent.health <= 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_117c55a6dfeb9860 ) || level.var_117c55a6dfeb9860.damage < instance.damage )
    {
        level.var_117c55a6dfeb9860 = instance;
    }
    
    level notify( #"processDamageThisFrame" );
    level endon( #"processDamageThisFrame" );
    waittillframeend();
    instance = level.var_117c55a6dfeb9860;
    level.var_117c55a6dfeb9860 = undefined;
    var_6182fa0235c8929e = function_608451b25e6fe222();
    hasarmor = proxyent.health > var_6182fa0235c8929e;
    var_50b7d34e641e396a = function_608451b25e6fe222() + 150;
    hitmarkertype = "standard";
    armordamage = 0;
    armorbroke = 0;
    
    if ( hasarmor )
    {
        currentarmor = proxyent.health - var_6182fa0235c8929e;
        armordamage = int( clamp( instance.damage, 0, currentarmor ) );
        armorbroke = currentarmor - armordamage == 0;
    }
    
    shouldOhkProtect = function_6663e8f14900ff75( instance.meansofdeath ) && armordamage >= 150;
    var_dab25f734d960262 = function_d0f7407d5f8aaa05( instance.weapon );
    var_f42cd31093febac6 = proxyent.health >= var_50b7d34e641e396a;
    
    if ( shouldOhkProtect && var_f42cd31093febac6 )
    {
        if ( instance.damage >= proxyent.health && !var_dab25f734d960262 )
        {
            instance.damage = int( clamp( instance.damage, 0, proxyent.health - 1 ) );
        }
    }
    
    if ( isdefined( level.matchrules_damagemultiplier ) )
    {
        instance.damage *= level.matchrules_damagemultiplier;
    }
    
    weaponrootstring = getweaponrootstring( instance.weapon );
    
    if ( isdefined( level.brmodifyweapondamage[ weaponrootstring ] ) )
    {
        instance.damage = [[ level.brmodifyweapondamage[ weaponrootstring ] ]]( instance.attacker, proxyent, instance.attacker, instance.damage, instance.meansofdeath, instance.weapon, instance.origin.origin, ( 0, 0, 0 ), "none", 0, instance.damage );
    }
    
    proxyent dodamage( instance.damage, instance.origin, instance.attacker, instance.attacker, instance.meansofdeath, instance.weapon, instance.hitloc );
    
    if ( proxyent.health < 0 )
    {
        instance.damage += proxyent.health;
    }
    
    level.var_ebf908e3e5e96aa7 += int( instance.damage );
    setomnvar( "ui_firing_range_tot_damage", level.var_ebf908e3e5e96aa7 );
    
    if ( !isdefined( self.firstdamagetime ) )
    {
        self.firstdamagetime = gettime();
    }
    
    level notify( #"damage_done" );
    isheadshot = instance.hitloc == "head";
    hitdist = math::round_float( distance( instance.attacker.origin, proxyent.origin ) / 39.37, 2 );
    ignoreaccuracy = instance.meansofdeath == "MOD_FIRE" || instance.meansofdeath == "MOD_EXPLOSIVE";
    
    if ( !ignoreaccuracy )
    {
        bulletsfired = 1;
        bulletshit = 1;
        
        if ( instance.attacker getcurrentweapon() == instance.attacker.primaryweaponobj )
        {
            level.var_6d20f1bfea78492e = min( level.var_6d20f1bfea78492e + 1, level.var_65d3ec21afb8c1b1 );
            bulletshit = level.var_6d20f1bfea78492e;
            bulletsfired = level.var_65d3ec21afb8c1b1;
            
            if ( function_120e71871fb92f69() )
            {
                level.var_7b135d1536298f8e++;
                var_bfc1156387b479bb = max( 1, level.var_bfc1156387b479bb );
                level.var_75cb0c6c413e69d5 = clamp( level.var_7b135d1536298f8e / var_bfc1156387b479bb, 0, 1 );
            }
            
            if ( isheadshot )
            {
                level.var_38e10219d88bb19c++;
                playsoundatpos( instance.origin, "jup_firingrange_target_bullet_impact_headshot" );
            }
            
            instance.attacker.var_77e861f8d388441d = bulletsfired == 0 ? 0 : clamp( level.var_38e10219d88bb19c / bulletsfired, 0, 1 );
            instance.attacker.var_2dcefb4ab3452bf3 = bulletsfired == 0 ? 0 : clamp( bulletshit / bulletsfired, 0, 1 );
            instance.attacker.var_e48b4294f9178c53 += int( instance.damage );
            instance.attacker.var_ea29b694b7afa122 = int( instance.damage );
            instance.attacker.var_910beafca8020768 = clamp( hitdist, 0, 100 );
            playsoundatpos( instance.origin, "jup_firingrange_target_bullet_impact" );
        }
        else
        {
            level.bulletshitsecondary = min( level.bulletshitsecondary + 1, level.var_ec67017c22f64929 );
            bulletshit = level.bulletshitsecondary;
            bulletsfired = level.var_ec67017c22f64929;
            
            if ( isheadshot )
            {
                level.var_edd9d75d4e242354++;
                playsoundatpos( instance.origin, "jup_firingrange_target_bullet_impact_headshot" );
            }
            
            instance.attacker.var_4a28bdd45dfb1a7d = bulletsfired == 0 ? 0 : clamp( level.var_edd9d75d4e242354 / bulletsfired, 0, 1 );
            instance.attacker.var_f5bdad532aeadd53 = bulletsfired == 0 ? 0 : clamp( bulletshit / bulletsfired, 0, 1 );
            instance.attacker.var_f59814ff13303233 += int( instance.damage );
            instance.attacker.var_c2dc71d5213e6802 = int( instance.damage );
            instance.attacker.var_491885e356b317c8 = clamp( hitdist, 0, 100 );
            playsoundatpos( instance.origin, "jup_firingrange_target_bullet_impact" );
        }
        
        bulletsfired = max( 1, bulletsfired );
        accuracy = clamp( bulletshit / bulletsfired, 0, 1 );
        setomnvar( "ui_firing_range_accuracy", accuracy );
        println( "<dev string:x79>" + accuracy );
    }
    
    var_238b458b43465af0 = getdvarint( @"hash_c0bf29e81b3a5eec", 1 );
    var_db59c6c1cd1a6d0f = getdvarint( @"hash_d1eeda3bc1bfb41b", 1 );
    icontype = undefined;
    hitsound = getdvar( @"snd_hitmarker_alias" );
    
    if ( var_238b458b43465af0 || var_db59c6c1cd1a6d0f )
    {
        if ( armorbroke )
        {
            if ( var_238b458b43465af0 )
            {
                if ( proxyent.health + instance.damage >= var_50b7d34e641e396a )
                {
                    icontype = "hitarmormaxplatebreak";
                }
                else
                {
                    icontype = "hitarmorlightbreak";
                }
                
                if ( var_f42cd31093febac6 )
                {
                    hitmarkertype = "threeplatearmorbreak";
                }
                else
                {
                    hitmarkertype = "standardarmorbreak";
                }
            }
            
            if ( var_db59c6c1cd1a6d0f )
            {
                hitsound = "hit_marker_3d_armor_break";
            }
        }
        else if ( hasarmor )
        {
            if ( var_238b458b43465af0 )
            {
                if ( proxyent.health + instance.damage >= var_50b7d34e641e396a )
                {
                    icontype = "hitarmorlightmaxlevel";
                }
                else
                {
                    icontype = "hitarmorlight";
                }
                
                if ( var_f42cd31093febac6 )
                {
                    hitmarkertype = "threeplatearmor";
                }
                else
                {
                    hitmarkertype = "standardarmor";
                }
            }
        }
    }
    
    if ( proxyent.health <= 0 )
    {
        if ( getdvarint( @"hash_19cb7a793ce35f97", 0 ) == 0 )
        {
            isbulletdamage = isdefined( instance.meansofdeath ) && ( utility::isbulletdamage( instance.meansofdeath ) || instance.meansofdeath == "MOD_EXPLOSIVE_BULLET" );
            
            if ( isbulletdamage )
            {
                proxyent.owner function_7251ae4f0b47c7e5( proxyent.owner.lastimpactpos, proxyent.owner.var_b7b7296658a13c3f, instance.attacker, instance.weapon, 1 );
            }
        }
        
        prevvalue = getomnvar( "ui_firing_range_target_kill_count" );
        
        if ( prevvalue <= 500 )
        {
            setomnvar( "ui_firing_range_target_kill_count", prevvalue + 1 );
        }
        
        ttkvalue = math::round_float( ( gettime() - ( self.firstdamagetime ?? gettime() ) ) / 1000, 3 );
        setomnvar( "ui_firing_range_ttk", ttkvalue );
        self.firstdamagetime = undefined;
        
        if ( function_120e71871fb92f69() )
        {
            level.var_28d38438e08910d4++;
        }
        
        if ( instance.attacker getcurrentweapon() == instance.attacker.primaryweaponobj )
        {
            if ( instance.attacker.var_2102a2d0be3461d9 <= 500 )
            {
                instance.attacker.var_2102a2d0be3461d9++;
            }
        }
        else if ( instance.attacker.var_a68b4227d7dc67b9 <= 500 )
        {
            instance.attacker.var_a68b4227d7dc67b9++;
        }
        
        if ( isheadshot )
        {
            self playsoundtoplayer( #"mp_headshot_alert", instance.attacker );
        }
        else
        {
            self playsoundtoplayer( #"mp_kill_alert", instance.attacker );
        }
        
        playsoundatpos( instance.origin + ( 0, 0, 15 ), "jup_firingrange_target_bullet_impact_death" );
        
        if ( self.ismovabledummy )
        {
            thread function_f1d0779f842e7d28( proxyent, instance.attacker );
        }
        else
        {
            thread function_eb19123198ad828c( proxyent );
        }
        
        deathdata = spawnstruct();
        deathdata.attacker = instance.attacker;
        deathdata.objweapon = instance.weapon;
        deathdata.meansofdeath = instance.meansofdeath;
        deathdata.hitloc = instance.hitloc;
        self.body = self;
        mtx_weapon::function_5da3bf4fd1233318( deathdata );
        waskilled = 1;
    }
    else
    {
        playsoundatpos( instance.origin, hitsound );
        waskilled = 0;
    }
    
    objweapon = instance.weapon;
    bulletdamage = 1;
    var_795e8a31194a39ac = damagefeedback::function_63bdec1d3fd95d25( 0, proxyent, 0, objweapon );
    
    if ( !isdefined( icontype ) )
    {
        icontype = "standard";
    }
    
    hitmarkertype = 1;
    suppressaudio = 0;
    targetentnum = proxyent getentitynumber();
    armorPlateCount = 1;
    instance.attacker damagefeedback::updatedamagefeedback( icontype, waskilled, isheadshot, hitmarkertype, suppressaudio, undefined, targetentnum, armorPlateCount, var_795e8a31194a39ac ?? {} );
}

// Namespace frontendfiringrange
// Params 2
// Checksum 0xd638d495, Offset: 0x44bd
// Size: 0x106
function function_f1d0779f842e7d28( proxyent, attacker )
{
    level endon( #"exit_firing_range" );
    
    if ( self.var_f9a396aeb09d7be2 )
    {
        return;
    }
    
    self.var_f9a396aeb09d7be2 = 1;
    dummyranges = function_cc6d8e547793427a( attacker getcurrentweapon() );
    
    if ( !isdefined( dummyranges ) )
    {
        proxyent.health = function_c76d6117f2e172ac();
        function_2fa4609f16f1ade0( proxyent );
        return;
    }
    
    dummyranges = arrayremoveduplicates( dummyranges );
    dummyranges = arraysort( dummyranges );
    self.var_d6945f469cc1af62 = self.var_d6945f469cc1af62 >= dummyranges.size - 1 ? 0 : self.var_d6945f469cc1af62 + 1;
    self.var_4afcf6fb638f149e = clamp( ( dummyranges[ self.var_d6945f469cc1af62 ] ?? dummyranges[ 0 ] ) - 150 + 1, 0, 3800 );
    newlocation = self.startingpos - ( self.var_4afcf6fb638f149e, 0, 0 );
    thread function_f16b7030dd2e82f2( newlocation, proxyent, 1.5, 0 );
}

// Namespace frontendfiringrange
// Params 4
// Checksum 0x8c8088f6, Offset: 0x45cb
// Size: 0x18b
function function_f16b7030dd2e82f2( newlocation, proxyent, waittime, var_4a28a508f9fb3a48 )
{
    level endon( #"exit_firing_range" );
    self.previousmovetolocation = newlocation;
    deceltime = min( waittime / 2, 0.3 );
    acceltime = min( waittime / 2, 0.3 );
    self.scriptorigin moveto( ( newlocation[ 0 ], self.scriptorigin.origin[ 1 ], self.scriptorigin.origin[ 2 ] ), waittime, acceltime, deceltime );
    proxyent setcandamage( 0 );
    self disableaimassist();
    self notsolid();
    self notify( #"entitydeleted" );
    differenceloc = self.scriptorigin.origin[ 0 ] - newlocation[ 0 ];
    
    if ( differenceloc != 0 && isdefined( var_4a28a508f9fb3a48 ) && !var_4a28a508f9fb3a48 )
    {
        function_807a1fc26d104718( differenceloc );
    }
    
    wait waittime;
    var_f91c572c2c0a5b0 = round( ( 150 + self.var_4afcf6fb638f149e + 1 ) / 39.37, 0.1 );
    setomnvar( "ui_firing_range_target_range", var_f91c572c2c0a5b0 );
    proxyent.health = function_c76d6117f2e172ac();
    function_2fa4609f16f1ade0( proxyent );
    mtx_weapon::onplayerspawnedmtx();
    self.var_f9a396aeb09d7be2 = 0;
    level.var_ebf908e3e5e96aa7 = 0;
    setomnvar( "ui_firing_range_tot_damage", 0 );
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xeebfdd4e, Offset: 0x475e
// Size: 0x52
function function_807a1fc26d104718( differenceloc = 1 )
{
    if ( differenceloc > 0 )
    {
        if ( self.var_d6945f469cc1af62 <= 1 )
        {
            self playsound( "amb_emt_t10_shooting_range_target_move1" );
        }
        else
        {
            self playsound( "amb_emt_t10_shooting_range_target_move2" );
        }
        
        return;
    }
    
    self playsound( "amb_emt_t10_shooting_range_target_comeback" );
}

// Namespace frontendfiringrange
// Params 3
// Checksum 0x87309f83, Offset: 0x47b8
// Size: 0x18b
function function_79ec23a13bb782d0( proxyent, player, firstweaponswitch )
{
    player endon( #"updateWeaponSwitch" );
    
    while ( player getcurrentweapon().classname == "none" )
    {
        waitframe();
    }
    
    if ( !isdefined( self.startingpos ) )
    {
        self.startingpos = ( 78270, -19636, 34 );
    }
    
    dummyranges = function_cc6d8e547793427a( player getcurrentweapon() );
    
    if ( !isdefined( dummyranges ) )
    {
        return;
    }
    
    dummyranges = arrayremoveduplicates( dummyranges );
    dummyranges = arraysort( dummyranges );
    self.var_d6945f469cc1af62 = 0;
    self.var_4afcf6fb638f149e = clamp( dummyranges[ 0 ] + 1, 0, 3800 );
    var_f91c572c2c0a5b0 = round( ( 150 + self.var_4afcf6fb638f149e + 1 ) / 39.37, 0.1 );
    setomnvar( "ui_firing_range_target_range", var_f91c572c2c0a5b0 );
    newlocation = self.startingpos - ( self.var_4afcf6fb638f149e, 0, 0 );
    
    if ( self.previousmovetolocation == newlocation )
    {
        return;
    }
    
    thread function_f16b7030dd2e82f2( newlocation, self.proxyent, 1.5, firstweaponswitch );
    
    if ( self.scriptorigin.angles != ( 90, 0, 0 ) && firstweaponswitch )
    {
        level.var_4a3c3d2624e15d37 = 0;
        self.scriptorigin.angles = ( 90, 0, 0 );
    }
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xe43e1e84, Offset: 0x494b
// Size: 0x3a
function function_2fa4609f16f1ade0( proxyent )
{
    if ( level.var_4a3c3d2624e15d37 == 1 )
    {
        self.var_f9a396aeb09d7be2 = 0;
        self solid();
        self enableaimassist();
        proxyent setcandamage( 1 );
    }
}

#using_animtree( "script_model" );

// Namespace frontendfiringrange
// Params 1
// Checksum 0x98fb595b, Offset: 0x498d
// Size: 0x99
function function_eb19123198ad828c( proxyent )
{
    level endon( #"exit_firing_range" );
    
    if ( self.var_f9a396aeb09d7be2 )
    {
        return;
    }
    
    self.var_f9a396aeb09d7be2 = 1;
    proxyent setcandamage( 0 );
    self disableaimassist();
    self notsolid();
    self notify( #"entitydeleted" );
    self scriptmodelplayanimdeltamotion( "iw9_mp_firingrange_dummy_death" );
    self playsound( "uin_firingrange_target_fall" );
    wait getanimlength( %iw9_mp_firingrange_dummy_death );
    self scriptmodelplayanimdeltamotion( "iw9_mp_firingrange_dummy_deathidle" );
    playsoundatpos( self.origin, "uin_firingrange_target_rise" );
    thread respawntarget();
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x4476644c, Offset: 0x4a2e
// Size: 0x87
function respawntarget()
{
    if ( !self.var_f9a396aeb09d7be2 )
    {
        return;
    }
    
    self scriptmodelplayanimdeltamotion( "iw9_mp_firingrange_dummy_respawn" );
    self.var_f9a396aeb09d7be2 = 1;
    wait getanimlength( %iw9_mp_firingrange_dummy_respawn ) - 0.3;
    self scriptmodelclearanim();
    self.var_f9a396aeb09d7be2 = 0;
    self solid();
    self enableaimassist();
    self.proxyent.health = function_c76d6117f2e172ac();
    self.proxyent setcandamage( 1 );
    mtx_weapon::onplayerspawnedmtx();
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0x487aa909, Offset: 0x4abd
// Size: 0x9d
function function_446d540a417a481c()
{
    self setcandamage( 1 );
    self.owner enableaimassist();
    
    /#
        thread function_e01eed580e50df1f();
    #/
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon );
    }
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xbea5a69e, Offset: 0x4b62
// Size: 0xd2
function function_7d5cfd5e524d2aea( primary )
{
    level notify( #"frontend_watch_bullets" );
    level endon( #"exit_firing_range" );
    level endon( #"frontend_watch_bullets" );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        bulletsfired = 0;
        hitnum = 0;
        
        if ( objweapon == primary )
        {
            level.var_65d3ec21afb8c1b1++;
            bulletsfired = level.var_65d3ec21afb8c1b1;
            hitnum = level.var_6d20f1bfea78492e;
            
            if ( function_120e71871fb92f69() )
            {
                level.var_bfc1156387b479bb++;
            }
        }
        else
        {
            level.var_ec67017c22f64929++;
            bulletsfired = level.var_ec67017c22f64929;
            hitnum = level.bulletshitsecondary;
        }
        
        thread function_6d9fec4518f7c13a( hitnum, bulletsfired, objweapon == primary );
    }
}

// Namespace frontendfiringrange
// Params 3
// Checksum 0x3434557b, Offset: 0x4c3c
// Size: 0x172
function function_6d9fec4518f7c13a( hitnum, bulletsfired, isprimary )
{
    level notify( #"wait_for_bullet_result" );
    level endon( #"exit_firing_range" );
    level endon( #"wait_for_bullet_result" );
    thread waitfordamage();
    level utility::waittill_any( "timeout_damage", "damage_done" );
    
    if ( isprimary && hitnum == level.var_6d20f1bfea78492e || !isprimary && hitnum == level.bulletshitsecondary )
    {
        bulletsfired = max( 1, bulletsfired );
        accuracy = clamp( hitnum / bulletsfired, 0, 1 );
        setomnvar( "ui_firing_range_accuracy", accuracy );
        println( "<dev string:x97>" + accuracy );
        
        if ( isprimary )
        {
            self.var_2dcefb4ab3452bf3 = accuracy;
            self.var_77e861f8d388441d = clamp( level.var_38e10219d88bb19c / bulletsfired, 0, 1 );
        }
        else
        {
            self.var_f5bdad532aeadd53 = accuracy;
            self.var_4a28bdd45dfb1a7d = clamp( level.var_edd9d75d4e242354 / bulletsfired, 0, 1 );
        }
        
        if ( isprimary && function_120e71871fb92f69() )
        {
            var_bfc1156387b479bb = max( 1, level.var_bfc1156387b479bb );
            level.var_75cb0c6c413e69d5 = clamp( level.var_7b135d1536298f8e / var_bfc1156387b479bb, 0, 1 );
        }
    }
}

// Namespace frontendfiringrange
// Params 0
// Checksum 0xac93fa96, Offset: 0x4db6
// Size: 0x38
function waitfordamage()
{
    level endon( #"damage_done" );
    level endon( #"exit_firing_range" );
    level endon( #"wait_for_bullet_result" );
    wait 0.1;
    level notify( #"timeout_damage" );
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x1b2298dd, Offset: 0x4df6
// Size: 0x1f, Type: bool
function isspreadweapon( objweapon )
{
    return isdefined( objweapon ) && weaponclass( objweapon ) == "spread";
}

// Namespace frontendfiringrange
// Params 5
// Checksum 0x10c93bb6, Offset: 0x4e1e
// Size: 0x350
function spreadshotdamagemod( victim, eattacker, objweapon, idamage, idflags )
{
    if ( isdefined( eattacker ) && isdefined( victim ) )
    {
        hand = function_deff5471cdf04d56( idflags );
        victimentnum = function_4ec08fffae2d922d( victim );
        time = gettime();
        
        if ( !isdefined( eattacker.pelletweaponvictimids ) )
        {
            eattacker.pelletweaponvictimids = [];
        }
        
        foreach ( ihand, var_3efaf483dba5b6a8 in eattacker.pelletweaponvictimids )
        {
            foreach ( victimid, victimstruct in var_3efaf483dba5b6a8 )
            {
                if ( ( time - victimstruct.time ) / 1000 > 0.1 )
                {
                    eattacker.pelletweaponvictimids[ ihand ][ victimid ] = undefined;
                    
                    if ( eattacker.pelletweaponvictimids[ ihand ].size == 0 )
                    {
                        eattacker.pelletweaponvictimids[ ihand ] = undefined;
                    }
                }
            }
        }
        
        if ( !isdefined( eattacker.pelletweaponvictimids[ hand ] ) )
        {
            eattacker.pelletweaponvictimids[ hand ] = [];
        }
        
        if ( !isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
        {
            eattacker.pelletweaponvictimids[ hand ][ victimentnum ] = function_e15be0607bfbb4e7( eattacker, objweapon, time );
        }
        
        eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_77e7ce207984d5d8 = 0;
        eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed = arraysort( eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed );
        
        if ( eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed.size >= eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_b2fcf56b19fb3493 )
        {
            if ( idamage > eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ] )
            {
                damagedelta = idamage - eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ];
                eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed[ 0 ] = idamage;
                eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_77e7ce207984d5d8 = 1;
                idamage = damagedelta;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            arrayinsert( eattacker.pelletweaponvictimids[ hand ][ victimentnum ].pelletdmgpassed, idamage, 0 );
        }
        
        idamage = function_ceb194a906bf4a4c( eattacker, victim, idflags, idamage );
    }
    
    return idamage;
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x2ce5bc15, Offset: 0x5177
// Size: 0x24
function function_deff5471cdf04d56( idflags )
{
    if ( idflags & 2048 )
    {
        return "lHandWeap";
    }
    
    return "rHandWeap";
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xdb45e7f1, Offset: 0x51a3
// Size: 0x12
function function_4ec08fffae2d922d( victim )
{
    return victim getentitynumber();
}

// Namespace frontendfiringrange
// Params 3
// Checksum 0x2d68b599, Offset: 0x51be
// Size: 0xa0
function function_e15be0607bfbb4e7( eattacker, objweapon, time )
{
    struct = spawnstruct();
    struct.time = time;
    struct.pelletdmgpassed = [];
    struct.var_8c8eb6b39a4c19ad = 0;
    struct.var_b2fcf56b19fb3493 = getspreadpelletspershot( eattacker, objweapon );
    
    if ( function_e03b776948c43ba8( objweapon.basename ) )
    {
        struct.var_57dfd4c4337d402e = 120;
    }
    else
    {
        struct.var_57dfd4c4337d402e = 200;
    }
    
    return struct;
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x25798a9f, Offset: 0x5267
// Size: 0xa6, Type: bool
function function_e03b776948c43ba8( weaponname )
{
    var_205ed7d117277fa5 = [ "iw9_sh_mike1014_mp", "iw9_sh_vecho_mp", "iw9_pi_swhiskey_mp" ];
    
    foreach ( i in var_205ed7d117277fa5 )
    {
        if ( i == weaponname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace frontendfiringrange
// Params 4
// Checksum 0x887dd6d6, Offset: 0x5316
// Size: 0x119
function function_ceb194a906bf4a4c( eattacker, victim, idflags, idamage )
{
    hand = function_deff5471cdf04d56( idflags );
    victimentnum = function_4ec08fffae2d922d( victim );
    
    if ( !isdefined( eattacker.pelletweaponvictimids[ hand ][ victimentnum ] ) )
    {
        return idamage;
    }
    
    var_57dfd4c4337d402e = eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_57dfd4c4337d402e;
    var_8c8eb6b39a4c19ad = eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_8c8eb6b39a4c19ad;
    
    if ( var_8c8eb6b39a4c19ad < var_57dfd4c4337d402e )
    {
        idamage = clamp( idamage, 0, var_57dfd4c4337d402e - eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_8c8eb6b39a4c19ad );
        eattacker.pelletweaponvictimids[ hand ][ victimentnum ].var_8c8eb6b39a4c19ad += idamage;
        return idamage;
    }
    
    return 0;
}

// Namespace frontendfiringrange
// Params 2
// Checksum 0xae6d84c, Offset: 0x5437
// Size: 0x92
function getspreadpelletspershot( eattacker, objweapon )
{
    rootname = objweapon.var_1616e6fbba9a722d;
    
    if ( rootname == %"iw9_sh_charlie725" || rootname == %"iw9_pi_swhiskey" )
    {
        if ( eattacker isdualwielding() )
        {
            return 2;
        }
        
        if ( objweapon hasattachment( "bar_sh_short_p14" ) )
        {
            return 3;
        }
        
        ads = eattacker playerads() > 0.5;
        
        if ( ads )
        {
            return 4;
        }
        else
        {
            return 3;
        }
        
        return;
    }
    
    return 4;
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0x6a5dc622, Offset: 0x54d1
// Size: 0x30, Type: bool
function function_6663e8f14900ff75( smeansofdeath )
{
    if ( !isdefined( smeansofdeath ) )
    {
        return false;
    }
    
    if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
    {
        return true;
    }
    
    return false;
}

// Namespace frontendfiringrange
// Params 1
// Checksum 0xd32e8b27, Offset: 0x550a
// Size: 0x69, Type: bool
function function_d0f7407d5f8aaa05( objweapon )
{
    if ( isinfrontend() )
    {
        return true;
    }
    
    weapontype = weaponclass( objweapon );
    
    if ( weapontype == "sniper" && objweapon.basename != "iw9_sn_limax_mp" && getweaponhasperk( objweapon, "specialty_explosivebullet" ) )
    {
        return true;
    }
    
    if ( damage_utility::iscrossbowdamage( objweapon ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace frontendfiringrange
    // Params 0
    // Checksum 0x18bb6498, Offset: 0x557c
    // Size: 0x90, Type: dev
    function function_e01eed580e50df1f()
    {
        while ( true )
        {
            color = self.health > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            
            /#
                print3d( self.owner.origin + ( 0, 0, 100 ), int( max( self.health, 0 ) ), color, 1, 0.75, 1, 1 );
            #/
            
            waitframe();
        }
    }

    // Namespace frontendfiringrange
    // Params 4
    // Checksum 0x8332cbca, Offset: 0x5614
    // Size: 0x64, Type: dev
    function drawsphere( origin, radius, drawtimeseconds, color )
    {
        drawframes = int( drawtimeseconds / 0.05 );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( origin, radius, color );
            waitframe();
        }
    }

#/

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0xb9d8f0ff, Offset: 0x5680
// Size: 0xc6
function private function_39417c370429569()
{
    level endon( #"exit_firing_range" );
    self notify( #"hash_c55a9b091dc8ffa1" );
    self endon( #"hash_c55a9b091dc8ffa1" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
        
        if ( objweapon.basename == "sat_sl_nembus_mp" )
        {
            nembus_used( { #originalowner:originalowner, #grenade:grenade } );
            continue;
        }
        
        if ( objweapon.basename == "sat_sh_husky_mp" && objweapon hasattachment( "sat_firemod_firetype_gl_sh_husky" ) )
        {
            grenade thread function_744d070e5fa6aac8();
        }
    }
}

// Namespace frontendfiringrange
// Params 1, eflags: 0x4
// Checksum 0x2f36e62f, Offset: 0x574e
// Size: 0x14d
function private nembus_used( grenadedata )
{
    grenade = grenadedata.grenade;
    
    if ( !isdefined( self.nembusgrenades ) )
    {
        self.nembusgrenades = [];
    }
    
    grenade.var_808ece62b3a01215 = 0;
    grenade.var_4f49e9e8607f622e = 0;
    self.nembusgrenades[ self.nembusgrenades.size ] = grenade;
    self.nembusgrenades = function_5713d46873b29625( self.nembusgrenades );
    
    if ( self.nembusgrenades.size > 4 )
    {
        var_614ccd4a0ccc1b4b = self.nembusgrenades[ 0 ];
        self.nembusgrenades[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.nembusgrenades );
        
        if ( !var_614ccd4a0ccc1b4b.var_4f49e9e8607f622e && !var_614ccd4a0ccc1b4b.var_808ece62b3a01215 )
        {
            var_614ccd4a0ccc1b4b thread function_c24b05c041748215();
        }
    }
    
    grenade setcandamage( 1 );
    grenade.health = 9999;
    grenade thread function_4d62503f21de901b();
    grenade thread function_4999b5cdb6213c7a();
    grenade thread function_a0b7889caf9a48ad();
    
    if ( !self.nembusused )
    {
        thread watch_nembus_detonation();
        thread function_10a4b0435dae6e63();
        self.nembusused = 1;
    }
    
    utility::function_969f9f5596dba07a( grenade, &function_8c62fe50ce0d0541 );
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x8676fb95, Offset: 0x58a3
// Size: 0x260
function private watch_nembus_detonation()
{
    self endon( #"nembus_cleanup" );
    self endon( #"death_or_disconnect" );
    self notifyonplayercommand( "nembus_detonation", "+speed_throw" );
    
    while ( true )
    {
        self waittill( #"nembus_detonation" );
        
        if ( self.currentweapon.basename != level.nembusweaponname )
        {
            continue;
        }
        
        if ( self.currentweapon hasattachment( "sat_mag_extmag_sl_nembus" ) )
        {
            activationdelay = 30;
            var_7c700a4f4609375d = 0;
        }
        else
        {
            activationdelay = 300;
            var_7c700a4f4609375d = 1;
        }
        
        self playsoundtoplayer( "wpn_sl_nembus_fcg_detonate_plr", self );
        detonatedgrenades = [];
        self.nembusgrenades = function_5713d46873b29625( self.nembusgrenades );
        
        foreach ( grenade in self.nembusgrenades )
        {
            if ( grenade.var_808ece62b3a01215 || grenade.var_4f49e9e8607f622e )
            {
                continue;
            }
            
            shoulddetonate = 0;
            
            if ( var_7c700a4f4609375d )
            {
                if ( isdefined( grenade.stucktime ) && gettime() >= grenade.stucktime + activationdelay )
                {
                    shoulddetonate = 1;
                }
            }
            else if ( isdefined( grenade.birthtime ) && gettime() >= grenade.birthtime + activationdelay )
            {
                shoulddetonate = 1;
            }
            
            if ( shoulddetonate )
            {
                detonatedgrenades[ detonatedgrenades.size ] = grenade;
            }
        }
        
        foreach ( grenade in detonatedgrenades )
        {
            self.nembusgrenades = arrayremove( self.nembusgrenades, grenade );
            grenade thread function_d4d714c62bee024();
        }
        
        if ( !self.nembusgrenades.size )
        {
            cleanup_nembus_tracking();
            return;
        }
    }
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x835e2c46, Offset: 0x5b0b
// Size: 0x40
function private function_4999b5cdb6213c7a()
{
    self endon( #"death" );
    self endon( #"hash_619b485845417ba4" );
    self endon( #"hash_1d7fbf737f3e8a63" );
    self waittill( #"missile_stuck" );
    self.stucktime = gettime();
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0xd75858c3, Offset: 0x5b53
// Size: 0xa1
function private function_10a4b0435dae6e63()
{
    self endon( #"nembus_cleanup" );
    self waittill( #"death_or_disconnect" );
    
    foreach ( grenade in self.nembusgrenades )
    {
        if ( isdefined( grenade ) )
        {
            grenade thread function_c24b05c041748215();
        }
    }
    
    cleanup_nembus_tracking();
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0xa83a4ec2, Offset: 0x5bfc
// Size: 0xe3
function private function_4d62503f21de901b()
{
    self endon( #"hash_619b485845417ba4" );
    self endon( #"hash_1d7fbf737f3e8a63" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, damage_type, modelname, tagname, partname, idflags, objweapon );
        
        if ( self.owner == attacker && self.weapon_object == objweapon )
        {
            if ( damage_type == "MOD_IMPACT" )
            {
                continue;
            }
            
            self.var_808ece62b3a01215 = 1;
            function_9d90cb0617580f5c();
            thread function_d4d714c62bee024();
            return;
        }
        
        thread function_8c62fe50ce0d0541();
    }
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x96f75674, Offset: 0x5ce7
// Size: 0x2e
function private function_a0b7889caf9a48ad()
{
    self endon( #"hash_619b485845417ba4" );
    self endon( #"hash_1d7fbf737f3e8a63" );
    self waittill( #"death" );
    function_9d90cb0617580f5c();
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x37c4a964, Offset: 0x5d1d
// Size: 0x48
function private function_d4d714c62bee024()
{
    self endon( #"death" );
    self notify( #"hash_1d7fbf737f3e8a63" );
    self.var_808ece62b3a01215 = 1;
    throttle::throttle_wait_in_queue( level.var_a177b2baa36179c9, self );
    self notify( #"hash_619b485845417ba4" );
    self detonate();
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x45e6d28d, Offset: 0x5d6d
// Size: 0x10
function private function_8c62fe50ce0d0541()
{
    function_9d90cb0617580f5c();
    thread function_c24b05c041748215();
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x3dd850fc, Offset: 0x5d85
// Size: 0x6d
function private function_9d90cb0617580f5c()
{
    if ( isdefined( self.owner.nembusgrenades ) )
    {
        self.owner.nembusgrenades = arrayremove( self.owner.nembusgrenades, self );
        
        if ( !self.owner.nembusgrenades.size )
        {
            self.owner cleanup_nembus_tracking();
        }
    }
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x6805bc8a, Offset: 0x5dfa
// Size: 0x32
function private cleanup_nembus_tracking()
{
    self.nembusused = undefined;
    self.nembusgrenades = [];
    self notifyonplayercommandremove( "nembus_detonation", "+speed_throw" );
    self notify( #"nembus_cleanup" );
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0xa393ab25, Offset: 0x5e34
// Size: 0x3b
function private function_c24b05c041748215()
{
    self notify( #"hash_619b485845417ba4" );
    self setscriptablepartstate( "destroy", "active", 0 );
    self.var_4f49e9e8607f622e = 1;
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace frontendfiringrange
// Params 0, eflags: 0x4
// Checksum 0x543b82e1, Offset: 0x5e77
// Size: 0x48
function private function_744d070e5fa6aac8()
{
    self endon( #"death" );
    self waittill( #"missile_impact", hitent, pos );
    utility::waittill_any_timeout( 0.2, "missile_impact" );
    self detonate();
}

