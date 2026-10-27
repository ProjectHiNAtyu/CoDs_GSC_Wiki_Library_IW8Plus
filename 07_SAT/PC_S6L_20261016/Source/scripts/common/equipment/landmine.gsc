// scripts\common\equipment\landmine.gsc  (hash_0f3a280c3232484d.gscc) (size: 15581 Bytes / 0x3cdd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x99af5da2 (2578406818)
// size ...... 15581 (0x3cdd)
// includes .. 4   (offset: 0x3af5)
// strings ... 29  (offset: 0x3b15)
// dev strs .. 2   (offset: 0x3cc5)
// exports ... 33  (offset: 0x24d9)
// cseg ...... 0x2a6 + 0x2233 (0x24d9)
// imports ... 139 (offset: 0x2a01)
// animtree1 . 0   (offset: 0x3cdd)
// animtree2 . 0   (offset: 0x3cdd)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace landmine;

// Namespace landmine
// Params 0, eflags: 0x1
// Checksum 0x3a095014, Offset: 0x2c4
// Size: 0xc2
function autoexec main()
{
    utility::registersharedfunc( #"super_landmine", #"use", &function_72e650c98b5fc3b8 );
    utility::registersharedfunc( #"landmine", #"hack", &landmine_hack );
    utility::registersharedfunc( #"landmine", #"hash_1d3dfc2162571a81", &deletemine );
    utility::registersharedfunc( #"landmine", #"hash_e6633009f3a8858a", &function_96b1c2993e82b065 );
    level callback::add( #"equipment_init", &function_ce9ec6107d4ce6cf );
    level.var_d3ff65cbeaa3ff69[ #"equip_landmine" ] = &function_a0751d4bce34d3e1;
    level._effect[ "vfx_landmine_launch_dust" ] = loadfxasset( "vfx_t10_core_equip_landmine_trigger_dust" );
}

// Namespace landmine
// Params 1
// Checksum 0x7fb83bea, Offset: 0x38e
// Size: 0x4a
function function_ce9ec6107d4ce6cf( params )
{
    var_bfe1633523542785 = namespace_9d8e359c3b1041e5::vehicleminesgetleveldataforminesharedfunc( "equip_landmine", 1 );
    
    if ( isdefined( var_bfe1633523542785 ) )
    {
        var_bfe1633523542785.radius = 100;
        var_bfe1633523542785.triggercallback = &landmine_vehicle_trigger;
    }
}

// Namespace landmine
// Params 1
// Checksum 0x51759e45, Offset: 0x3e0
// Size: 0x2fe
function function_72e650c98b5fc3b8( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    issuper = 1;
    
    if ( utility::issharedfuncdefined( #"equipment", #"getequipmentbundlefromweaponname" ) )
    {
        equipmentbundle = [[ utility::getsharedfunc( #"equipment", #"getequipmentbundlefromweaponname" ) ]]( grenade.weapon_name );
        issuper = !isdefined( equipmentbundle ) || equipmentbundle.equipmenttype == "super";
    }
    
    if ( issuper )
    {
        grenade.superref = "super_landmine";
        grenade.issuper = 1;
        grenade.bundle = namespace_9d8e359c3b1041e5::getsuperbundlefromoffhandweaponnamesharedfunc( grenade.weapon_name );
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    if ( isdefined( self.perks[ "specialty_mod_health_max" ] ) )
    {
        maxhealth = [[ utility::getsharedfunc( #"specialty_mod_health_max", #"modifymaxhealth" ) ]]( grenade );
    }
    else if ( isdefined( self.perks[ "specialty_rugged_eqp" ] ) )
    {
        grenade.hasruggedeqp = 1;
    }
    
    grenade namespace_9d8e359c3b1041e5::registerspawnsharedfunc( 2, &deletemine );
    thread namespace_9d8e359c3b1041e5::monitordisownedgrenadesharedfunc( self, grenade );
    grenade thread landmine_watch_game_end();
    grenade setscriptablepartstate( #"hash_a3a6bb9c5477d862", #"hide", 0 );
    data = spawnstruct();
    data.endonstring = "mine_destroyed";
    data.skipdeath = 1;
    grenade thread namespace_9d8e359c3b1041e5::handlemovingplatformtouchsharedfunc( data );
    grenade thread function_ac174b8f2914255b();
    
    if ( utility::issharedfuncdefined( "equip_landmine", #"hash_68160ecc80207080" ) )
    {
        grenade thread [[ utility::getsharedfunc( "equip_landmine", #"hash_68160ecc80207080" ) ]]();
    }
    
    grenade thread function_8c6f4b49b6d26b08( 0.1 );
    grenade waittill( #"missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal );
    
    if ( isdefined( stuckto ) )
    {
        if ( isent( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
        {
            grenade.origin += ( 0, 0, 1.6 );
            
            if ( utility::issharedfuncdefined( #"equip_landmine", #"hash_48bfd10b9cade8bd" ) )
            {
                utility::callsharedfunc( #"equip_landmine", #"hash_48bfd10b9cade8bd", grenade, 1 );
            }
        }
        
        grenade linkto( stuckto );
    }
    
    thread function_4f0d7c204fc652fe( grenade, surfacetype );
}

// Namespace landmine
// Params 1
// Checksum 0x809b7a03, Offset: 0x6e6
// Size: 0x35
function function_8c6f4b49b6d26b08( delaytime )
{
    if ( self isscriptable() )
    {
        wait delaytime;
        
        if ( isdefined( self ) )
        {
            self setscriptablepartstate( #"visibility", #"show", 0 );
        }
    }
}

// Namespace landmine
// Params 0
// Checksum 0xb764ba21, Offset: 0x723
// Size: 0x60
function function_438c368dd28a5ac1()
{
    if ( level.dangerzoneskipequipment )
    {
        return;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        namespace_9d8e359c3b1041e5::removespawninfluencersharedfunc( self.dangerzone );
    }
    
    self.dangerzone = namespace_9d8e359c3b1041e5::addspawninfluencersharedfunc( #"equipment_mine", self.origin, self.owner.team );
}

// Namespace landmine
// Params 0
// Checksum 0x1bdbaf31, Offset: 0x78b
// Size: 0x40
function function_ac174b8f2914255b()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self waittill( #"missile_water_impact" );
    self setscriptablepartstate( #"hash_a3a6bb9c5477d862", #"show", 0 );
}

// Namespace landmine
// Params 2
// Checksum 0x7f9a8cb8, Offset: 0x7d3
// Size: 0x2fe
function function_4f0d7c204fc652fe( grenade, surfacetype )
{
    grenade endon( #"mine_destroyed" );
    grenade endon( #"death" );
    grenade setotherent( self );
    grenade setentityowner( self );
    grenade missilethermal();
    grenade missileoutline();
    grenade setnodeploy( 1 );
    grenade setscriptablepartstate( #"plant", #"active", 0 );
    self setscriptablepartstate( #"equipatminefxview", #"plant", 0 );
    namespace_9d8e359c3b1041e5::onequipmentplantedsharedfunc( grenade, "equip_landmine", &function_f6d8f58820630e86 );
    thread namespace_9d8e359c3b1041e5::monitordisownedequipmentsharedfunc( self, grenade );
    grenade namespace_9d8e359c3b1041e5::registersentientsharedfunc( "Lethal_Static", grenade.owner, 1 );
    grenade thread namespace_9d8e359c3b1041e5::minedamagemonitorsharedfunc();
    grenade thread function_bcb65ad5d65b57fd();
    
    if ( utility::issharedfuncdefined( "equip_landmine", #"empapplied" ) )
    {
        if ( utility::issharedfuncdefined( "equip_landmine", #"empclear" ) )
        {
            grenade namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, utility::getsharedfunc( "equip_landmine", #"empapplied" ), undefined, utility::getsharedfunc( "equip_landmine", #"empclear" ) );
        }
        else
        {
            grenade namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, utility::getsharedfunc( "equip_landmine", #"empapplied" ) );
        }
    }
    
    if ( level.var_36218e71baa7e689 )
    {
        grenade.var_c5ccf9dff3b5e393 = &function_c5886af82b5f3df;
    }
    
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    grenade function_438c368dd28a5ac1();
    activationdelay = 1.5;
    
    if ( isstruct( grenade.bundle ) && isdefined( grenade.bundle.landmine_activationdelay ) )
    {
        activationdelay = grenade.bundle.landmine_activationdelay;
    }
    
    wait activationdelay / 2;
    
    if ( grenade.touchedmovingplatform )
    {
        grenade thread function_7637c9ec1ff2fe30();
    }
    
    wait activationdelay / 2;
    grenade thread namespace_9d8e359c3b1041e5::remoteinteractsetupsharedfunc( &function_a135263868e889da, 1, 1 );
    grenade setscriptablepartstate( #"arm", #"active", 0 );
    grenade thread landmine_watch_trigger();
    
    /#
        if ( getdvarint( @"scr_landmine_debug", 0 ) )
        {
            grenade thread function_7514d8850d484737();
        }
    #/
    
    thread namespace_9d8e359c3b1041e5::outlineequipmentforownersharedfunc( grenade );
    
    if ( grenade.bundle.headicon_enable )
    {
        grenade.headiconid = namespace_9d8e359c3b1041e5::function_aa75822b8899334( grenade );
    }
    else
    {
        grenade.headiconid = grenade namespace_9d8e359c3b1041e5::setheadiconfactionimagesharedfunc( 1, 2, undefined, undefined, undefined, 0.1, 1, 0, undefined, undefined, level.gamemodebundle.var_a43747faa623d1b0 ?? "ui_hud_icon_field_upgrade", "icon_small" );
    }
    
    utility::function_969f9f5596dba07a( grenade, &function_c989c791608191d9 );
}

// Namespace landmine
// Params 1
// Checksum 0xb2a27879, Offset: 0xad9
// Size: 0x17c
function function_a135263868e889da( owner )
{
    thread function_f6d8f58820630e86( 5 );
    
    if ( !isdefined( owner ) )
    {
        owner = self.owner;
    }
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( isent( self ) )
    {
        self setentityowner( owner );
        self clearscriptabledamageowner();
    }
    else
    {
        if ( !isdefined( self.radius ) )
        {
            self.radius = 100;
        }
        
        if ( !isdefined( self.damage_max ) )
        {
            self.damage_max = 200;
        }
        
        if ( !isdefined( self.damage_min ) )
        {
            self.damage_min = 100;
        }
        
        waitframe();
        self.exploded = 1;
        owner.var_fa5dea8f8e019d45 = self.origin;
        owner.triggeredbyplayer = 1;
        owner.var_54c212c5a054f834 = 1;
        owner radiusdamage( self.origin, self.radius, self.damage_max, self.damage_min, self.attacker );
    }
    
    self setscriptablepartstate( #"arm", #"neutral", 0 );
    self setscriptablepartstate( #"trigger", #"neutral", 0 );
    self setscriptablepartstate( #"explode", #"fromplayer", 0 );
    self setscriptablepartstate( #"hacked", #"neutral", 0 );
    self setscriptablepartstate( #"danger-icon", #"off", 0 );
}

// Namespace landmine
// Params 1
// Checksum 0xbd0429dd, Offset: 0xc5d
// Size: 0xce
function function_95d44541e4634537( vehicle )
{
    if ( isdefined( vehicle ) )
    {
        var_8f4aad183918d24f = namespace_9d8e359c3b1041e5::getsuperweaponsharedfunc( "super_landmine" );
        
        if ( !isdefined( var_8f4aad183918d24f ) && utility::issharedfuncdefined( "equip_landmine", #"getweaponname" ) )
        {
            var_8f4aad183918d24f = [[ utility::getsharedfunc( "equip_landmine", #"getweaponname" ) ]]();
        }
        
        var_b82768e7c3567bf8 = makeweapon( var_8f4aad183918d24f );
        vehicle dodamage( 200, self.origin, self.owner, self, "MOD_EXPLOSIVE", var_b82768e7c3567bf8 );
        ignoredamageid = vehicle namespace_9d8e359c3b1041e5::function_287accac73ec9c41( self.owner, var_b82768e7c3567bf8, self, "MOD_EXPLOSIVE" );
    }
    
    thread function_43e919c36d641259();
    waitframe();
    
    if ( isdefined( vehicle ) )
    {
        vehicle namespace_9d8e359c3b1041e5::function_cc18ed453e5ccdbc( ignoredamageid );
    }
}

// Namespace landmine
// Params 0
// Checksum 0xa473d065, Offset: 0xd33
// Size: 0x6b
function function_43e919c36d641259()
{
    thread function_f6d8f58820630e86( 5 );
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
    self setscriptablepartstate( #"arm", #"neutral", 0 );
    self setscriptablepartstate( #"launch", #"neutral", 0 );
    self setscriptablepartstate( #"explode", #"fromvehicle", 0 );
}

// Namespace landmine
// Params 1
// Checksum 0x860a570e, Offset: 0xda6
// Size: 0x144
function function_96b1c2993e82b065( attacker )
{
    if ( isdefined( attacker ) && isdefined( self.owner ) && attacker != self.owner )
    {
        if ( isdefined( self.bundle ) && isdefined( self.bundle.var_5d7006fb6c782ce2 ) )
        {
            attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( self.bundle.var_5d7006fb6c782ce2 );
        }
    }
    
    thread function_f6d8f58820630e86( 5 );
    
    if ( isent( self ) )
    {
        self setentityowner( attacker );
        self clearscriptabledamageowner();
    }
    else
    {
        if ( !isdefined( self.radius ) )
        {
            self.radius = 100;
        }
        
        if ( !isdefined( self.damage_max ) )
        {
            self.damage_max = 200;
        }
        
        if ( !isdefined( self.damage_min ) )
        {
            self.damage_min = 100;
        }
        
        self.owner radiusdamage( self.origin, 100, 200, 100 );
    }
    
    self setscriptablepartstate( #"arm", #"neutral", 0 );
    self setscriptablepartstate( #"launch", #"neutral", 0 );
    self setscriptablepartstate( #"explode", #"fromdamage", 0 );
}

// Namespace landmine
// Params 1
// Checksum 0xc0987c56, Offset: 0xef2
// Size: 0x79
function function_c989c791608191d9( attacker )
{
    thread function_f6d8f58820630e86( 5 );
    self setscriptablepartstate( #"arm", #"neutral", 0 );
    self setscriptablepartstate( #"launch", #"neutral", 0 );
    self setscriptablepartstate( #"destroy", #"active", 0 );
    self setscriptablepartstate( #"health_listener", #"off", 0 );
}

// Namespace landmine
// Params 1
// Checksum 0x4ba36ba0, Offset: 0xf73
// Size: 0x17b
function function_f6d8f58820630e86( deletiondelay )
{
    self notify( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    weapon::deregistermine();
    self setscriptablepartstate( #"hack_usable", #"off" );
    
    if ( isent( self ) )
    {
        self setcandamage( 0 );
        namespace_9d8e359c3b1041e5::makeexplosiveunusuabletagsharedfunc();
    }
    
    namespace_9d8e359c3b1041e5::setheadicondeleteiconsharedfunc( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.dangerzone ) )
    {
        namespace_9d8e359c3b1041e5::removespawninfluencersharedfunc( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner namespace_9d8e359c3b1041e5::removeequipsharedfunc( self );
    }
    
    if ( isdefined( self.launchedmine ) )
    {
        self.launchedmine delete();
    }
    
    if ( utility::issharedfuncdefined( "equip_landmine", #"hash_b383a9b6a9ae6db1" ) )
    {
        [[ utility::getsharedfunc( "equip_landmine", #"hash_b383a9b6a9ae6db1" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    if ( isent( self ) )
    {
        namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    }
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    namespace_9d8e359c3b1041e5::deregisterspawnsharedfunc();
    
    if ( isdefined( self ) )
    {
        if ( isent( self ) )
        {
            self delete();
            return;
        }
        
        self freescriptable();
    }
}

// Namespace landmine
// Params 0
// Checksum 0x1c92bdc4, Offset: 0x10f6
// Size: 0x86
function function_7637c9ec1ff2fe30()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self.attachedvelocity = ( 0, 0, 0 );
    update_interval = 0.2;
    
    while ( true )
    {
        old_origin = self.origin;
        wait update_interval;
        self.attachedvelocity = 1 / update_interval * ( self.origin - old_origin );
    }
}

// Namespace landmine
// Params 1
// Checksum 0xce9ad51d, Offset: 0x1184
// Size: 0x37, Type: bool
function is_landmine_moving( mine )
{
    return isdefined( mine ) && isdefined( mine.attachedvelocity ) && length2dsquared( mine.attachedvelocity ) > 0.01;
}

// Namespace landmine
// Params 0
// Checksum 0xb345feba, Offset: 0x11c4
// Size: 0x385
function landmine_watch_trigger()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    var_8a99ba0186cd22e8 = undefined;
    
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicleminesisfriendlytomine" ) )
    {
        var_8a99ba0186cd22e8 = utility::getsharedfunc( #"vehicle", #"vehicleminesisfriendlytomine" );
    }
    
    var_734f418303df90c1 = undefined;
    
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicleminesshouldvehicletriggermine" ) )
    {
        var_734f418303df90c1 = utility::getsharedfunc( #"vehicle", #"vehicleminesshouldvehicletriggermine" );
    }
    
    var_872aa3e5dbf8e64a = undefined;
    
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicleminesminetrigger" ) )
    {
        var_872aa3e5dbf8e64a = utility::getsharedfunc( #"vehicle", #"vehicleminesminetrigger" );
    }
    
    var_f1dc5fb67ef2dd19 = undefined;
    
    if ( utility::issharedfuncdefined( "equip_landmine", #"hash_ff42655615376475" ) )
    {
        var_f1dc5fb67ef2dd19 = utility::getsharedfunc( "equip_landmine", #"hash_ff42655615376475" );
    }
    
    var_1f92ce085c5f47f8 = undefined;
    
    if ( utility::issharedfuncdefined( #"player", #"isreallyalive" ) )
    {
        var_f1dc5fb67ef2dd19 = utility::getsharedfunc( #"player", #"isreallyalive" );
    }
    
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( true )
    {
        self waittill( #"trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        if ( self.isdisabled || self.isjammed )
        {
            continue;
        }
        
        if ( !isarray( entarr ) )
        {
            entarr = [ entarr ];
        }
        
        foreach ( ent in entarr )
        {
            if ( ent.classname == "script_vehicle" )
            {
                if ( isdefined( var_8a99ba0186cd22e8 ) && ent [[ var_8a99ba0186cd22e8 ]]( self ) )
                {
                    continue;
                }
                
                if ( isdefined( var_734f418303df90c1 ) && ![[ var_734f418303df90c1 ]]( ent, self ) )
                {
                    continue;
                }
                
                if ( isdefined( var_872aa3e5dbf8e64a ) )
                {
                    [[ var_872aa3e5dbf8e64a ]]( ent, self );
                }
                
                break;
            }
            
            if ( isagent( ent ) || isplayer( ent ) || isentityprop( ent ) || isdefined( var_f1dc5fb67ef2dd19 ) && [[ var_f1dc5fb67ef2dd19 ]]( ent ) )
            {
                if ( isdefined( ent.vehicle ) )
                {
                    continue;
                }
                
                if ( isdefined( var_1f92ce085c5f47f8 ) && ![[ var_1f92ce085c5f47f8 ]]( ent ) )
                {
                    continue;
                }
                
                if ( isdefined( ent.perks[ "specialty_lightfoot" ] ) )
                {
                    continue;
                }
                
                if ( var_23a82edf24269a34 && ent.spawnprotection )
                {
                    continue;
                }
                
                if ( ent.var_ff102e941e8065c )
                {
                    if ( utility::issharedfuncdefined( #"equipment", #"hash_ea29440e05008300" ) )
                    {
                        delayapplied = utility::callsharedfunc( #"equipment", #"hash_ea29440e05008300", ent, ent.var_ff102e941e8065c, 48 );
                        
                        if ( delayapplied )
                        {
                            continue;
                        }
                    }
                }
                
                thread landmine_player_trigger( ent );
                break;
            }
        }
    }
}

/#

    // Namespace landmine
    // Params 0
    // Checksum 0xcd50259e, Offset: 0x1551
    // Size: 0x12a, Type: dev
    function function_7514d8850d484737()
    {
        self endon( #"mine_triggered" );
        self endon( #"mine_destroyed" );
        self endon( #"death" );
        
        if ( isdefined( self.debug_trig ) )
        {
            self.debug_trig delete();
        }
        
        self.debug_trig = spawn( "<dev string:x24>", self.origin, 0, 48, 48 );
        self.debug_trig enablelinkto();
        self.debug_trig linkto( self );
        cylinder( self.origin, self.origin + ( 0, 0, 48 ), 48, ( 1, 1, 0 ), 0, 100 );
        
        while ( true )
        {
            self.debug_trig waittill( #"trigger", ent );
            assert( isdefined( ent ) );
            self notify( #"trigger_grenade", [ ent ] );
            print3d( self.origin, "<dev string:x33>", ( 1, 1, 0 ), 1, 0.5, 100, 1 );
        }
    }

#/

// Namespace landmine
// Params 1
// Checksum 0x1d2bfc19, Offset: 0x1683
// Size: 0xf3
function landmine_player_trigger( ent )
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self notify( #"mine_triggered" );
    self.triggeredbyplayer = 1;
    
    if ( isent( self ) )
    {
        namespace_9d8e359c3b1041e5::makeexplosiveunusuabletagsharedfunc();
    }
    
    self setscriptablepartstate( #"arm", #"neutral", 0 );
    self setscriptablepartstate( #"trigger", #"active", 0 );
    self setscriptablepartstate( #"danger-icon", #"on", 0 );
    
    if ( utility::issharedfuncdefined( #"weapons", #"explosivetrigger" ) )
    {
        namespace_9d8e359c3b1041e5::explosivetriggersharedfunc( ent, 0.5 );
    }
    else
    {
        wait 0.5;
    }
    
    if ( isent( self ) || self.var_b8e92a93af2aa003 )
    {
        thread function_367acc8ccfaff827();
        return;
    }
    
    wait 0.4;
    thread function_a135263868e889da();
}

// Namespace landmine
// Params 2
// Checksum 0x59ac447c, Offset: 0x177e
// Size: 0x9f
function landmine_vehicle_trigger( vehicle, mine )
{
    mine endon( #"mine_destroyed" );
    mine endon( #"death" );
    mine.owner endon( #"disconnect" );
    mine notify( #"mine_triggered" );
    mine namespace_9d8e359c3b1041e5::makeexplosiveunusuabletagsharedfunc();
    mine setscriptablepartstate( #"arm", #"neutral", 0 );
    mine setscriptablepartstate( #"trigger", #"active", 0 );
    wait 0.2;
    mine thread function_95d44541e4634537( vehicle );
}

// Namespace landmine
// Params 0
// Checksum 0x7163612c, Offset: 0x1825
// Size: 0xa
function deletemine()
{
    function_f6d8f58820630e86( 0 );
}

// Namespace landmine
// Params 0
// Checksum 0x2a268ac, Offset: 0x1837
// Size: 0x33c
function function_367acc8ccfaff827()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    flighttime = 0.2;
    
    if ( flighttime > 0 )
    {
        flightdir = ( 0, 0, 1 );
        flightdest = self.origin + flightdir * 64;
        contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip" ] );
        ignorelist = [];
        
        if ( isent( self ) )
        {
            ignorelist = namespace_9d8e359c3b1041e5::getmineignorelistsharedfunc();
        }
        
        caststart = self.origin;
        castend = flightdest;
        castresults = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
        var_aeda03cace55dd8f = 0;
        
        if ( castresults.size > 0 )
        {
            castdist = vectordot( castresults[ 0 ][ "position" ] - caststart, flightdir );
            castdist = max( 0, castdist - 1 );
            flighttime = 0;
            flightdest = self.origin;
            
            if ( castdist > 0 )
            {
                flighttime = castdist / 64 * 0.2;
                flightdest = self.origin + flightdir * castdist;
            }
            
            var_aeda03cace55dd8f = 1;
        }
        
        if ( is_landmine_moving( self ) )
        {
            flightdest += self.attachedvelocity * flighttime;
        }
        
        if ( flighttime > 0 )
        {
            flighttimeremaining = flighttime;
            flightdeceltime = flighttimeremaining * 1;
            
            if ( is_landmine_moving( self ) )
            {
                flightdeceltime *= 0.25;
            }
            
            flighttimeremaining -= flightdeceltime;
            flightacceltime = 0;
            
            if ( flighttimeremaining > 0 )
            {
                flightacceltime = flighttimeremaining * 0;
            }
            
            self setscriptablepartstate( #"visibility", #"hide" );
            mover = spawn( "script_model", self.origin );
            mover.angles = vectortoangles( anglestoforward( self.angles ) * ( 1, 1, 0 ) );
            mover setmodel( "tag_origin" );
            self.mover = mover;
            mover.grenade = self;
            
            if ( isent( self ) )
            {
                mover thread function_904b804ff46c3985( flighttime );
                self linkto( mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            else
            {
                mover thread function_904b804ff46c3985( flighttime + level.framedurationseconds );
                waitframe();
                self scriptablesetparententity( mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            
            mover moveto( flightdest, flighttime, flightacceltime, flightdeceltime );
            thread function_714d9625e6f4919e( flighttime );
            childthread namespace_9d8e359c3b1041e5::watchflightcollisionsharedfunc();
            utility::waittill_any_timeout( flighttime + 0.05, "collision_with_platform" );
            
            if ( !var_aeda03cace55dd8f )
            {
                mover moveto( flightdest - ( 0, 0, 25 ), 0.2, 0.2, 0 );
                utility::waittill_any_timeout( 0.2, "collision_with_platform" );
            }
            
            thread function_a135263868e889da();
            return;
        }
    }
}

// Namespace landmine
// Params 1
// Checksum 0x2cf5c8c, Offset: 0x1b7b
// Size: 0x6e
function function_904b804ff46c3985( flighttime )
{
    self endon( #"death" );
    self.grenade utility::waittill_any_timeout( flighttime, "death", "mine_destroyed" );
    
    if ( isdefined( self.grenade ) )
    {
        self moveto( self.origin, 0.05, 0, 0 );
    }
    
    while ( isdefined( self.grenade ) )
    {
        waitframe();
    }
    
    self delete();
}

// Namespace landmine
// Params 1
// Checksum 0x1540ffc0, Offset: 0x1bf1
// Size: 0x70
function function_714d9625e6f4919e( flighttime )
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    playfx( utility::getfx( "vfx_landmine_launch_dust" ), self.origin, ( 1, 0, 0 ), ( 0, 0, 1 ) );
    self setscriptablepartstate( #"launch", #"active", 0 );
}

// Namespace landmine
// Params 0
// Checksum 0xbcb1c8e4, Offset: 0x1c69
// Size: 0x60
function function_bcb65ad5d65b57fd()
{
    self endon( #"death" );
    self waittill( #"detonateexplosive", attacker );
    
    if ( isdefined( attacker ) )
    {
        thread function_96b1c2993e82b065( attacker );
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        thread function_96b1c2993e82b065( self.owner );
        return;
    }
    
    thread function_c989c791608191d9();
}

// Namespace landmine
// Params 0
// Checksum 0x1931c846, Offset: 0x1cd1
// Size: 0x33
function landmine_watch_game_end()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread function_c989c791608191d9();
}

// Namespace landmine
// Params 5
// Checksum 0xa813029a, Offset: 0x1d0c
// Size: 0x26b
function function_a0751d4bce34d3e1( victim, inflictor, objweapon, meansofdeath, damage )
{
    if ( !isdefined( inflictor ) )
    {
        return damage;
    }
    
    if ( meansofdeath != "MOD_EXPLOSIVE" )
    {
        return damage;
    }
    
    if ( !inflictor.var_54c212c5a054f834 )
    {
        if ( !isdefined( objweapon ) )
        {
            return damage;
        }
        
        if ( isnullweapon( objweapon ) )
        {
            return damage;
        }
        
        if ( objweapon.var_25b0062cbe4d9c99 != #"equip_landmine" )
        {
            return damage;
        }
    }
    
    up = anglestoup( inflictor.angles );
    
    if ( inflictor.var_fa5dea8f8e019d45 )
    {
        btwn = isdefined( self ) ? inflictor.var_fa5dea8f8e019d45 - self geteye() : inflictor.var_fa5dea8f8e019d45;
    }
    else
    {
        btwn = isdefined( self ) ? inflictor.origin - self geteye() : inflictor.origin;
    }
    
    var_b42270b1edd83fac = vectordot( btwn, up );
    damagescalar = 1;
    
    if ( inflictor.triggeredbyplayer )
    {
        stance = victim getstance();
        diving = 0;
        
        if ( isdefined( inflictor.bundle ) && inflictor.bundle.var_e5fcd46aa618e476 )
        {
            diving = victim isdiving();
        }
        
        if ( var_b42270b1edd83fac > 30 )
        {
            damagescalar = 0;
        }
        
        if ( diving || stance == "prone" )
        {
            if ( inflictor.bundle.var_4ea6e098fc37b71d && isdefined( inflictor.bundle.var_d27a230e8ab45c30 ) )
            {
                damagescalar = inflictor.bundle.var_d27a230e8ab45c30;
            }
            else
            {
                damagescalar = 0;
            }
        }
        
        if ( stance == "crouch" )
        {
            if ( inflictor.bundle.var_4ea6e098fc37b71d && isdefined( inflictor.bundle.var_c2aa5f56c5f02e ) )
            {
                damagescalar = inflictor.bundle.var_c2aa5f56c5f02e;
            }
        }
    }
    
    if ( damagescalar != 0 && inflictor.var_a90aaf6efe186115 )
    {
        damagescalar *= inflictor.var_a90aaf6efe186115;
    }
    
    return int( damage * damagescalar );
}

// Namespace landmine
// Params 1
// Checksum 0x1c1d58b6, Offset: 0x1f80
// Size: 0x35
function function_5e11dd37061ea354( launchedmine )
{
    launchedmine endon( #"death" );
    self waittill( #"death" );
    
    if ( !isdefined( launchedmine ) )
    {
        return;
    }
    
    launchedmine delete();
}

// Namespace landmine
// Params 2
// Checksum 0x1003c054, Offset: 0x1fbd
// Size: 0xdd
function landmine_hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner utility::callsharedfunc( #"equipment", #"hash_e54f01be6ce23bab", self.superref, #"stolen_hacked" );
    self.owner = attacker;
    self setentityowner( attacker );
    self setotherent( attacker );
    function_438c368dd28a5ac1();
    thread namespace_9d8e359c3b1041e5::monitordisownedequipmentsharedfunc( self.owner, self );
    thread namespace_9d8e359c3b1041e5::outlineequipmentforownersharedfunc( self );
    var_67f2373fa78a9a22 = level.teambased ? attacker.team : attacker;
    self filteroutplayermarks( var_67f2373fa78a9a22 );
    self setscriptablepartstate( #"hacked", #"active", 0 );
}

// Namespace landmine
// Params 1
// Checksum 0x2171c720, Offset: 0x20a2
// Size: 0x77
function function_4d88ee5a63491b4f( attacker )
{
    self endon( #"death" );
    attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"disabled_at_mine" );
    self.isdisabled = 1;
    self setscriptablepartstate( #"empd", #"active", 0 );
    wait 6;
    self.isdisabled = 0;
    self setscriptablepartstate( #"empd", #"neutral", 0 );
}

// Namespace landmine
// Params 1, eflags: 0x4
// Checksum 0x6b714b69, Offset: 0x2121
// Size: 0xd0
function private function_c5886af82b5f3df( data )
{
    if ( isdefined( data.victim.bundle ) && isdefined( data.victim.bundle.var_5d7006fb6c782ce2 ) )
    {
        data.attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( data.victim.bundle.var_5d7006fb6c782ce2 );
    }
    
    thread function_f6d8f58820630e86( 0.25 );
    self setscriptablepartstate( #"arm", #"neutral", 0 );
    self setscriptablepartstate( #"launch", #"neutral", 0 );
    self setscriptablepartstate( #"destroy", #"active", 0 );
}

// Namespace landmine
// Params 1
// Checksum 0x47b32023, Offset: 0x21f9
// Size: 0x220
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = 0;
            
            if ( utility::issharedfuncdefined( #"rank", #"hash_b4c081ca47d526a4" ) )
            {
                basepoints = [[ utility::getsharedfunc( #"rank", #"hash_b4c081ca47d526a4" ) ]]( #"hash_2a460c645664deb4" );
            }
            
            params.combatlink.owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_2a460c645664deb4", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_5ffd6a7c85f19d10", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
            
            self.var_a90aaf6efe186115 = params.bundle.var_a90aaf6efe186115 ?? undefined;
        }
    }
}

// Namespace landmine
// Params 1
// Checksum 0x36030b6f, Offset: 0x2421
// Size: 0xb8
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
                
                self.var_a90aaf6efe186115 = undefined;
            }
        }
    }
}

