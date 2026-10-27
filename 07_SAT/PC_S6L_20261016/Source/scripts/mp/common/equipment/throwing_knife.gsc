// scripts\mp\common\equipment\throwing_knife.gsc  (hash_4faabe437aa3b975.gscc) (size: 8764 Bytes / 0x223c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x265ab7d5 (643479509)
// size ...... 8764 (0x223c)
// includes .. 8   (offset: 0x1ffc)
// strings ... 29  (offset: 0x203c)
// dev strs .. 5   (offset: 0x2200)
// exports ... 21  (offset: 0x1594)
// cseg ...... 0x354 + 0x1240 (0x1594)
// imports ... 61  (offset: 0x18dc)
// animtree1 . 0   (offset: 0x223c)
// animtree2 . 0   (offset: 0x223c)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\mtx_weapon;

#namespace throwing_knife;

// Namespace throwing_knife
// Params 0, eflags: 0x1
// Checksum 0x414ff7c0, Offset: 0x372
// Size: 0xbf
function autoexec throwing_knife_init()
{
    level thread function_b77232fdce7fb041();
    utility::flag_wait( "equipment_initialized" );
    level.throwingknifemaxpickups = getdvarfloat( @"hash_9cf2c444ba60d047", 12 );
    level.throwingknifepickuptimeout = getdvarfloat( @"hash_63a7b50937e43d7b", 20 );
    
    /#
        utility::issharedfuncdefined( #"throwing_knife", #"init" );
    #/
    
    [[ utility::getsharedfunc( #"throwing_knife", #"init" ) ]]();
    equipment_mp::registercallback( "equip_throwing_knife", "onGive", &throwing_knife_ongive );
    equipment_mp::registercallback( "equip_throwing_knife", "onTake", &throwing_knife_ontake );
    equipment_mp::registercallback( "equip_throwing_knife", "onIncrement", &function_720dc05597666561 );
}

// Namespace throwing_knife
// Params 0
// Checksum 0x30385f3a, Offset: 0x439
// Size: 0xc9
function function_b77232fdce7fb041()
{
    level endon( #"game_ended" );
    utility::flag_wait( "loadEquipmentBundles_finished" );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_throwing_knife" );
    level.equipment_throwing_knife = spawnstruct();
    level.equipment_throwing_knife.bundle = bundle;
    level.equipment_throwing_knife.equipref = "equip_throwing_knife";
    level.equipment_throwing_knife.weaponname = "throwingknife_mp";
    level.equipment_throwing_knife.var_ddb8990415240048 = ( bundle.var_268c68f741c7c7dd ?? 90, bundle.var_268c67f741c7c5aa ?? 0, bundle.var_268c66f741c7c377 ?? 0 );
}

// Namespace throwing_knife
// Params 4
// Checksum 0x22db1d0c, Offset: 0x50a
// Size: 0x64
function throwing_knife_ongive( equipmentref, equipmentslot, variantid, attachments )
{
    if ( utility::issharedfuncdefined( #"throwing_knife", #"ongive" ) )
    {
        self [[ utility::getsharedfunc( #"throwing_knife", #"ongive" ) ]]( equipmentref, equipmentslot, variantid, attachments );
    }
}

// Namespace throwing_knife
// Params 2
// Checksum 0x9108d8d9, Offset: 0x576
// Size: 0x4f
function throwing_knife_ontake( equipmentref, equipmentslot )
{
    if ( utility::issharedfuncdefined( #"throwing_knife", #"onTake" ) )
    {
        self [[ utility::getsharedfunc( #"throwing_knife", #"onTake" ) ]]( equipmentref, equipmentslot );
    }
}

// Namespace throwing_knife
// Params 2
// Checksum 0x344dea2a, Offset: 0x5cd
// Size: 0x25
function function_720dc05597666561( equipmentref, currammo )
{
    if ( currammo == 0 )
    {
        throwing_knife_ongive( equipmentref );
    }
}

// Namespace throwing_knife
// Params 1
// Checksum 0xac0b93f0, Offset: 0x5fa
// Size: 0x136
function function_665adad844a8aca1( grenade )
{
    if ( !isdefined( grenade ) || !isdefined( grenade.owner ) )
    {
        return;
    }
    
    grenade endon( #"death" );
    grenade endon( #"explode" );
    grenade endon( #"missile_stuck" );
    grenade endon( #"missile_change_to_dud" );
    grenade endon( #"missile_water_impact" );
    grenade.owner endon( #"disconnect" );
    
    while ( true )
    {
        grenade waittill( #"missile_bounced" );
        
        if ( !isdefined( grenade.bouncecount ) )
        {
            grenade.bouncecount = 0;
        }
        
        grenade.bouncecount++;
        grenade.hasbounced = 1;
        callbackparams = { #player:grenade.owner, #equipmentref:grenade.equipmentref, #bouncecount:grenade.bouncecount, #hasbounced:grenade.hasbounced };
        callback::callback( #"equipment_bounce", callbackparams );
    }
}

// Namespace throwing_knife
// Params 1
// Checksum 0xa7d728d4, Offset: 0x738
// Size: 0x249
function throwing_knife_used( grenade )
{
    grenade endon( #"death" );
    grenade function_53204409aec2e2b2();
    grenade.bwasunderwater = player_utility::isswimmingunderwater();
    grenade thread function_386df2f34f64d5a2();
    grenade thread function_665adad844a8aca1( grenade );
    grenade makeunusable();
    
    if ( !isdefined( grenade.equipmentref ) )
    {
        if ( grenade.weapon_name == "shuriken_mp" || grenade.weapon_name == "shuriken_mp_inert" )
        {
            grenade.equipmentref = "equip_shuriken";
        }
        else
        {
            grenade.equipmentref = "equip_throwing_knife";
        }
    }
    
    stuckto = undefined;
    stuckpart = undefined;
    grenade_owner_name = self.name;
    grenade endon( #"hash_b2b4305b96237bdf" );
    grenade waittill( #"missile_stuck", stuckto, stuckpart, var_3cd1054550c085eb, hitvelocity, hitposition, hitnormal );
    level notify( #"hash_f8acd64098a6f03f", grenade, "throwingknife_mp", grenade_owner_name );
    hitshield = stuckpart == "tag_flicker";
    hitplayer = isdefined( stuckto ) && ( isplayer( stuckto ) || isagent( stuckto ) );
    
    if ( hitplayer && hitshield )
    {
        stuckto notify( #"shield_hit", grenade );
    }
    
    if ( isdefined( stuckto ) && stuckto.var_3ca43042bdfe8877 )
    {
        grenade delete();
        return;
    }
    
    if ( hitplayer )
    {
        if ( isdefined( stuckpart ) && stuckto tagexists( stuckpart ) )
        {
            var_60e11a17f72c104b = stuckto gettagorigin( stuckpart, 1 );
            
            if ( var_60e11a17f72c104b )
            {
                var_13d18310aa60f776 = function_bb4ed613776bcc52( self.origin, var_60e11a17f72c104b, 0.5 );
                origin = var_13d18310aa60f776;
                self.origin = origin;
            }
            else
            {
                fwdvector = anglestoforward( self.angles );
                self.origin += fwdvector * 10;
            }
        }
    }
    
    /#
        grenade thread drawdebugcylinder();
    #/
    
    grenade throwing_knife_makepickup();
}

// Namespace throwing_knife
// Params 3
// Checksum 0x6d4d3a02, Offset: 0x989
// Size: 0x4c
function function_bb4ed613776bcc52( veca, vecb, factor )
{
    vecline = vecb - veca;
    var_7fbf9452e41b2836 = vecline * factor;
    vecpoint = veca + var_7fbf9452e41b2836;
    return vecpoint;
}

/#

    // Namespace throwing_knife
    // Params 0
    // Checksum 0xc2b872a8, Offset: 0x9de
    // Size: 0x53, Type: dev
    function drawdebugcylinder()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_throwingknife" ) > 0 )
            {
                cylinder( self.origin, self.origin + ( 0, 0, 64 ), 64 );
            }
            
            waitframe();
        }
    }

#/

// Namespace throwing_knife
// Params 0, eflags: 0x4
// Checksum 0x4a53b47, Offset: 0xa39
// Size: 0x73
function private function_386df2f34f64d5a2()
{
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"missile_stuck" );
    self.owner endon( #"disconnect" );
    
    if ( self.inertknife )
    {
        return 0;
    }
    
    self waittill( #"missile_water_impact", impactdata );
    self.bwasunderwater = 1;
    thread function_7b675bb5537a7f5d();
}

// Namespace throwing_knife
// Params 0, eflags: 0x4
// Checksum 0x7b164ce0, Offset: 0xab4
// Size: 0x139
function private function_7b675bb5537a7f5d()
{
    level endon( #"game_end" );
    self endon( #"missile_stuck" );
    self.owner endon( #"disconnect" );
    owner = self.owner;
    newspawnpos = self.origin;
    var_b009bd74c12e1804 = self.weapon_object;
    var_56e9e40657c596e7 = self.angles;
    inertweapon = self.bundle.var_fb47908ea071f955 ?? "throwingknife_mp_inert";
    
    if ( self.weapon_name == "shuriken_mp" )
    {
        inertweapon = "shuriken_mp_inert";
    }
    
    self waittill( #"missile_change_to_dud", dudpos );
    owner notify( #"hash_b2b4305b96237bdf" );
    
    if ( isdefined( dudpos ) )
    {
        newspawnpos = dudpos;
    }
    
    replacementknife = owner launchgrenade( inertweapon, newspawnpos, ( 0, 0, 0 ), undefined, undefined );
    
    if ( isdefined( replacementknife ) )
    {
        replacementknife.inertknife = 1;
        replacementknife.var_b009bd74c12e1804 = var_b009bd74c12e1804;
        replacementknife.angles = var_56e9e40657c596e7;
    }
}

// Namespace throwing_knife
// Params 1
// Checksum 0xabfe6b8e, Offset: 0xbf5
// Size: 0x55
function function_588ffc7587b7cb54( victim )
{
    outdmg = 45;
    var_a0be4a2063c309d5 = victim.health - 45 <= 0;
    
    if ( var_a0be4a2063c309d5 )
    {
        outdmg = int( max( victim.health - 1, 1 ) );
    }
    
    return outdmg;
}

// Namespace throwing_knife
// Params 1
// Checksum 0x799b514a, Offset: 0xc53
// Size: 0x16b
function getcorpstablestate( stuckpart )
{
    switch ( stuckpart )
    {
        case #"hash_21fb295da569a24b":
            return "head";
        case #"hash_de9ffaed3aaf2f50":
            return "head";
        case #"hash_402665c8637b5f05":
            return "head";
        case #"hash_b68fa57896eba8d3":
            return "to_";
        case #"hash_75d098324e281f06":
            return "to_";
        case #"hash_270342211f93c022":
            return "ar_";
        case #"hash_274912211fcb218c":
            return "al_";
        case #"hash_d6c67a869aa3949f":
            return "ar_";
        case #"hash_d70b82869ad9bb31":
            return "al_";
        case #"hash_d332e6054003402b":
            return "ar_";
        case #"hash_d3921605404ec06d":
            return "al_";
        case #"hash_74dd72dc5d3dc459":
            return "lr";
        case #"hash_74e38adc5d42674f":
            return "ll_";
        case #"hash_87e17a385203b93f":
            return "lr";
        case #"hash_882682385239dfd1":
            return "ll_";
        case #"hash_34953cef3230c1eb":
            return "lr";
        case #"hash_34f36cef327aaf2d":
            return "ll_";
        default:
            println( "<dev string:x24>" + stuckpart + "<dev string:x4c>" );
            return;
    }
}

// Namespace throwing_knife
// Params 0
// Checksum 0x80b2bc4c, Offset: 0xdc6
// Size: 0x48
function function_53204409aec2e2b2()
{
    souleaterknife = mtx_weapon::function_4903b4967df7673f( self.weapon_object );
    
    if ( souleaterknife )
    {
        state = self.owner mtx_weapon::function_1e26d71a360eed47();
        self setscriptablepartstate( "soulEater", state );
    }
}

// Namespace throwing_knife
// Params 0
// Checksum 0x7df4e818, Offset: 0xe16
// Size: 0x297
function throwing_knife_makepickup()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( level.gametypebundle.var_a66b864dc4e9421e && common_item::items_isenabled() && common_inventory::inventory_isenabled() && !self.var_fbb45c724e16fc60 )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( self.origin, self.angles + level.equipment_throwing_knife.var_ddb8990415240048 );
        knifeitem = common_item::function_325e28c0fb65c36a( self.equipmentref, 1, spawnoptions );
        
        foreach ( player in level.players )
        {
            if ( player != self.owner )
            {
                knifeitem disablescriptableplayeruse( player );
            }
        }
        
        self delete();
        return;
    }
    
    self makeunusable();
    trigger = spawn( "trigger_radius", self.origin, 0, 64, 64 );
    trigger.targetname = "dropped_knife";
    trigger enablelinkto();
    trigger linkto( self );
    self.knife_trigger = trigger;
    
    if ( !isdefined( level.throwingknives ) )
    {
        level.throwingknives = [];
    }
    
    temparr = [ self ];
    
    foreach ( throwingknife in level.throwingknives )
    {
        if ( temparr.size >= level.throwingknifemaxpickups )
        {
            if ( isdefined( throwingknife ) )
            {
                throwingknife throwing_knife_deletepickup();
            }
            
            continue;
        }
        
        if ( isdefined( throwingknife ) )
        {
            temparr[ temparr.size ] = throwingknife;
        }
    }
    
    level.throwingknives = temparr;
    
    if ( self.bundle.var_aa37d375407e8141 )
    {
        self hudoutlineenableforclient( self.owner, self.bundle.throwingknife_hudoutline ?? "defaulthudoutline" );
    }
    
    thread throwing_knife_watchpickup();
    thread throwing_knife_watchpickuptimeout();
    thread function_bfb8f1eaf58e0f48();
}

// Namespace throwing_knife
// Params 0
// Checksum 0x93477a07, Offset: 0x10b5
// Size: 0x211
function throwing_knife_watchpickup()
{
    self endon( #"death" );
    isbackpackinventoryenabled = 0;
    
    if ( utility::issharedfuncdefined( #"inventory", #"isbackpackinventoryenabled" ) )
    {
        isbackpackinventoryenabled = [[ utility::getsharedfunc( #"inventory", #"isbackpackinventoryenabled" ) ]]();
    }
    
    while ( true )
    {
        self.knife_trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && self.owner != player )
        {
            continue;
        }
        
        if ( isdefined( self.var_b009bd74c12e1804 ) )
        {
            if ( !player hasweapon( self.var_b009bd74c12e1804 ) && !isbackpackinventoryenabled )
            {
                continue;
            }
        }
        
        if ( !isbackpackinventoryenabled && player.alternateweapons.size > 0 && ( self.equipmentref == "equip_findia_throwing_knife" && player.alternateweapons[ 0 ].receiver == "rex_rec_findia_knives" || player.alternateweapons[ 1 ].receiver == "rex_rec_findia_knives" ) || self.equipmentref == "equip_moscar_spring_bayonet_rex_mp" && player.alternateweapons[ 0 ].receiver == "rex_rec_moscar_bayonet" || player.alternateweapons[ 1 ].receiver == "rex_rec_moscar_bayonet" )
        {
        }
        else if ( !player hasweapon( self.weapon_object ) && !isbackpackinventoryenabled )
        {
            continue;
        }
        
        variantid = 0;
        weaponobj = self.weapon_object;
        
        if ( isdefined( weaponobj ) )
        {
            variantid = weaponobj.variantid;
        }
        
        if ( player throwing_knife_trytopickup( self.equipmentref, variantid ) )
        {
            thread throwing_knife_deletepickup();
        }
    }
}

// Namespace throwing_knife
// Params 0
// Checksum 0xba359811, Offset: 0x12ce
// Size: 0x1f
function throwing_knife_watchpickuptimeout()
{
    self endon( #"death" );
    wait level.throwingknifepickuptimeout;
    thread throwing_knife_deletepickup();
}

// Namespace throwing_knife
// Params 0
// Checksum 0x6d523845, Offset: 0x12f5
// Size: 0x90
function function_bfb8f1eaf58e0f48()
{
    self endon( #"death" );
    
    if ( self.var_fbb45c724e16fc60 )
    {
        return;
    }
    
    while ( isdefined( self.owner ) )
    {
        currentequipment = self.owner equipment_mp::getcurrentequipment( "primary" );
        
        if ( isdefined( currentequipment ) && self.owner equipment_mp::getequipmentammo( currentequipment ) > 0 && currentequipment != "equip_throwing_knife" )
        {
            thread throwing_knife_deletepickup();
        }
        
        self.owner waittill( #"equipment_used" );
    }
}

// Namespace throwing_knife
// Params 0
// Checksum 0x3d57f911, Offset: 0x138d
// Size: 0x23
function throwing_knife_deletepickup()
{
    if ( isdefined( self.knife_trigger ) )
    {
        self.knife_trigger delete();
    }
    
    self delete();
}

// Namespace throwing_knife
// Params 2
// Checksum 0xda6ff0db, Offset: 0x13b8
// Size: 0x1db
function throwing_knife_trytopickup( equipmentref, variantid )
{
    if ( equipmentref == "equip_findia_throwing_knife" && ( getweaponhasperk( self.primaryweapon, "specialty_apex_knives" ) || getweaponhasperk( self.secondaryweapon, "specialty_apex_knives" ) ) )
    {
        pickupsuccessful = self [[ utility::getsharedfunc( #"findia_throwing_knife", #"trytopickup" ) ]]( equipmentref );
        assert( isdefined( pickupsuccessful ), "<dev string:x4f>" );
        
        if ( pickupsuccessful )
        {
            callbackparams = { #equipmentref:equipmentref, #player:self };
            callback::callback( #"equipment_reclaimed", callbackparams );
        }
        
        return pickupsuccessful;
    }
    else if ( equipmentref == "equip_moscar_spring_bayonet_rex_mp" && ( getweaponhasperk( self.primaryweapon, "specialty_spring_bayonet_apex" ) || getweaponhasperk( self.secondaryweapon, "specialty_spring_bayonet_apex" ) ) )
    {
        pickupsuccessful = self [[ utility::getsharedfunc( #"hash_43bd3b7ca4651593", #"trytopickup" ) ]]( equipmentref );
        assert( isdefined( pickupsuccessful ), "<dev string:x91>" );
        
        if ( pickupsuccessful )
        {
            callbackparams = { #equipmentref:equipmentref, #player:self };
            callback::callback( #"equipment_reclaimed", callbackparams );
        }
        
        return pickupsuccessful;
    }
    else if ( utility::issharedfuncdefined( #"throwing_knife", #"trytopickup" ) )
    {
        pickupsuccessful = self [[ utility::getsharedfunc( #"throwing_knife", #"trytopickup" ) ]]( equipmentref );
        assert( isdefined( pickupsuccessful ), "<dev string:xd3>" );
        
        if ( pickupsuccessful )
        {
            callbackparams = { #equipmentref:equipmentref, #player:self };
            callback::callback( #"equipment_reclaimed", callbackparams );
        }
        
        return pickupsuccessful;
    }
    
    return 1;
}

