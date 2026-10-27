// scripts\mp\common\equipment\at_mine.gsc  (hash_3a459cb70cbfb426.gscc) (size: 19197 Bytes / 0x4afd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4cba548 (3301680456)
// size ...... 19197 (0x4afd)
// includes .. 28  (offset: 0x45b5)
// strings ... 62  (offset: 0x4695)
// dev strs .. 1   (offset: 0x4af1)
// exports ... 47  (offset: 0x29a9)
// cseg ...... 0x43e + 0x256b (0x29a9)
// imports ... 171 (offset: 0x3101)
// animtree1 . 0   (offset: 0x4afd)
// animtree2 . 0   (offset: 0x4afd)
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\swim_common;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_mines;
#using scripts\common\weapon;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\equipment;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\hud_message;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace at_mine;

// Namespace at_mine
// Params 0, eflags: 0x1
// Checksum 0x3fcd9d0a, Offset: 0x45c
// Size: 0x9
function autoexec main()
{
    at_mine_init();
}

// Namespace at_mine
// Params 0
// Checksum 0x71ef6db9, Offset: 0x46d
// Size: 0x11f
function at_mine_init()
{
    utility::flag_wait( "equipment_initialized" );
    var_bfe1633523542785 = vehicle_mines::get_mine_data( "equip_at_mine", 1 );
    var_bfe1633523542785.radius = 100;
    var_bfe1633523542785.triggercallback = &at_mine_vehicle_trigger;
    
    /#
        setdevdvarifuninitialized( @"hash_e67a08119163320a", 0 );
        level thread function_6a9cd2691c88e134();
    #/
    
    level thread function_ae67064345ea205e();
    weapons::registerusedcallback( "at_mine", &at_mine_use );
    equipment_mp::registercallback( "equip_at_mine", "onOwnerChanged", &at_mine_onownerchanged );
    equipment_mp::registercallback( "equip_at_mine", "onDestroyedByTrophy", &at_mine_delete );
    level.var_d3ff65cbeaa3ff69[ #"at_mine" ] = &at_mine_modified_damage;
    level.var_d3ff65cbeaa3ff69[ #"at_mine_ap" ] = &at_mine_modified_damage;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"train" ][ #"hash_2edafff898b3de81" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( #"at_mine", &at_mine_destroy );
    }
    
    equipmentinteractinit();
}

// Namespace at_mine
// Params 0
// Checksum 0x329ba07b, Offset: 0x594
// Size: 0x9b
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_at_mine" ].bundle;
    
    if ( !bundle.equipmentinteractions )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_at_mine" ), #"interactdisable", &equipmentinteractdisable );
    utility::registersharedfunc( getxhash( "equip_at_mine" ), #"interactenable", &equipmentinteractenable );
    utility::registersharedfunc( getxhash( "equip_at_mine" ), #"interactdestroy", &equipmentinteractdestroy );
}

// Namespace at_mine
// Params 1
// Checksum 0xd6352036, Offset: 0x637
// Size: 0x27
function equipmentinteractenable( data )
{
    self.isdisabled = 0;
    self setscriptablepartstate( "empd", "neutral", 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0xa73ff839, Offset: 0x666
// Size: 0x28
function equipmentinteractdisable( data )
{
    self.isdisabled = 1;
    self setscriptablepartstate( "empd", "active", 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0xa0318dea, Offset: 0x696
// Size: 0x1e
function equipmentinteractdestroy( data )
{
    at_mine_destroy( data.attacker );
}

// Namespace at_mine
// Params 0
// Checksum 0xa6eabd91, Offset: 0x6bc
// Size: 0x7c
function function_ae67064345ea205e()
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_at_mine" );
    level.equipment_at_mine = spawnstruct();
    level.equipment_at_mine.bundle = bundle;
    level.equipment_at_mine.equipref = "equip_at_mine";
    level.equipment_at_mine.weaponname = bundle.useweapon ?? "at_mine_mp";
}

// Namespace at_mine
// Params 1
// Checksum 0x58abd8bb, Offset: 0x740
// Size: 0x203
function at_mine_use( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade.var_736c0b69e68cc5a0 = isdefined( self.perks[ "specialty_rugged_equipment" ] );
    
    if ( isdefined( self.perks[ "specialty_rugged_eqp" ] ) )
    {
        grenade.hasruggedeqp = 1;
    }
    
    grenade.var_4a4b0a500f4daecd = isdefined( grenade.bundle ) && grenade.bundle.var_128ba815578acfd7;
    grenade ent_manager::registerspawn( 2, &deletemine );
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade thread at_mine_watch_game_end();
    grenade setscriptablepartstate( "visibility", "show", 0 );
    data = spawnstruct();
    data.endonstring = "mine_destroyed";
    data.skipdeath = 1;
    grenade thread movers::handle_moving_platform_touch( data );
    grenade waittill( #"missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal );
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            hud_message::showerrormessage( %"equipment/plant_failed" );
            equipment_mp::incrementequipmentslotammo( "primary" );
            grenade delete();
            return;
        }
    }
    
    if ( isdefined( stuckto ) )
    {
        if ( isent( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
        {
            grenade.origin += ( 0, 0, 1.6 );
            data.var_f07590e06f628942 = 1;
            grenade setmissileantilagged( 1 );
        }
        
        grenade linkto( stuckto );
    }
    
    thread at_mine_plant( grenade, surfacetype, normal );
}

// Namespace at_mine
// Params 0
// Checksum 0xcefc2d67, Offset: 0x94b
// Size: 0x60
function at_mine_update_danger_zone()
{
    if ( level.dangerzoneskipequipment )
    {
        return;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzone );
    }
    
    self.dangerzone = spawnlogic::addspawninfluencer( #"equipment_mine", self.origin, self.owner.team );
}

// Namespace at_mine
// Params 0
// Checksum 0x23a05970, Offset: 0x9b3
// Size: 0x43
function function_3f435475e4ea9664()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self waittill( #"missile_water_impact" );
    self setscriptablepartstate( "floats", "show", 0 );
    self.hitwater = 1;
}

// Namespace at_mine
// Params 3
// Checksum 0x2587bbd4, Offset: 0x9fe
// Size: 0x319
function at_mine_plant( grenade, surfacetype, normal )
{
    grenade endon( #"mine_destroyed" );
    grenade endon( #"death" );
    grenade setotherent( self );
    grenade setentityowner( self );
    grenade missilethermal();
    
    if ( !grenade.var_d6dc6d1d909f23fb )
    {
        grenade missileoutline();
    }
    
    grenade setnodeploy( 1 );
    grenade setscriptablepartstate( "plant", "active", 0 );
    self setscriptablepartstate( "equipATMineFXView", "plant", 0 );
    weapons::onequipmentplanted( grenade, "equip_at_mine", &at_mine_delete );
    thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Lethal_Static", grenade.owner, 1 );
    grenade thread weapons::minedamagemonitor();
    grenade thread at_mine_watch_detonate();
    grenade emp_debuff::set_apply_emp_callback( &at_mine_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &at_mine_empapplied;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempclearcallback = &at_mine_empcleared;
    }
    
    grenade chaff_debuff::function_3860212a5ec36b56( &function_b6d91b56187e683f );
    grenade chaff_debuff::function_324dd42a2703bc25( &function_adef69580fecafa6 );
    grenade haywire::function_7f69a1eb3d590f76( &at_mine_haywireapplied );
    grenade function_a4ebfb83ec0621b9( &at_mine_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    grenade at_mine_update_danger_zone();
    armtime = 1.5;
    
    if ( isdefined( grenade.armtime ) )
    {
        armtime = grenade.armtime;
    }
    
    wait armtime / 2;
    
    if ( grenade.touchedmovingplatform )
    {
        grenade thread at_mine_movingplatform_update();
    }
    
    wait armtime / 2;
    grenade thread equipment_interact::remoteinteractsetup( &at_mine_explode_from_player_trigger, 1, 1 );
    grenade setscriptablepartstate( "arm", "active", 0 );
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        grenade [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( grenade );
    }
    
    grenade thread at_mine_watch_trigger();
    
    if ( game_utility::getgametype() != "mines" )
    {
        if ( level.gamemodebundle.var_738c716858d0a544 )
        {
            grenade utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_34f9d09235c7b7df" );
        }
        else
        {
            grenade thread weapons::makeexplosiveusabletag( "tag_use", 1 );
        }
        
        thread weapons::outlineequipmentforowner( grenade );
    }
    
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    weapons::function_e9702cd6c6aeec0f( grenade, normal );
}

// Namespace at_mine
// Params 1
// Checksum 0xb9d61c36, Offset: 0xd1f
// Size: 0xa1
function at_mine_explode_from_stuck( stucktarget )
{
    if ( isdefined( stucktarget ) )
    {
        self endon( #"death" );
        remainingtime = self.flightendtime - gettime();
        self setscriptablepartstate( "arm", "neutral", 0 );
        self setscriptablepartstate( "trigger", "neutral", 0 );
        self setscriptablepartstate( "hacked", "neutral", 0 );
        self setscriptablepartstate( "launch", "neutral", 0 );
        
        if ( remainingtime > 0 )
        {
            remainingtime /= 1000;
            wait remainingtime;
        }
        
        thread function_78a6c826f41fe25f( stucktarget );
        return;
    }
    
    thread at_mine_destroy();
}

// Namespace at_mine
// Params 1
// Checksum 0x8c51b9d9, Offset: 0xdc8
// Size: 0xd0
function function_78a6c826f41fe25f( stucktarget )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( stucktarget ) )
    {
        thread at_mine_destroy();
        return;
    }
    
    thread at_mine_delete( 5 );
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.weapon_name );
    
    if ( bundle.var_435c007a9a9ac7f0 )
    {
        utility::function_ce86ddbb7d60e9bd( self.origin, bundle.var_4441fcc4c44427a3, self.owner );
    }
    
    if ( !self.var_4a4b0a500f4daecd )
    {
        self setscriptablepartstate( "explode", "fromPlayer", 0 );
        return;
    }
    
    self setscriptablepartstate( "explode", "fromPlayer_noDamage", 0 );
    at_mine_do_damage( "fromPlayer" );
}

// Namespace at_mine
// Params 1
// Checksum 0x7fb94122, Offset: 0xea0
// Size: 0xf1
function at_mine_explode_from_player_trigger( owner )
{
    thread at_mine_delete( 5 );
    
    if ( !isdefined( owner ) )
    {
        owner = self.owner;
    }
    
    self setentityowner( owner );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "trigger", "neutral", 0 );
    self setscriptablepartstate( "hacked", "neutral", 0 );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.weapon_name );
    
    if ( bundle.var_435c007a9a9ac7f0 )
    {
        utility::function_ce86ddbb7d60e9bd( self.origin, bundle.var_4441fcc4c44427a3, self.owner );
    }
    
    if ( !self.var_4a4b0a500f4daecd )
    {
        self setscriptablepartstate( "explode", "fromPlayer", 0 );
        return;
    }
    
    self setscriptablepartstate( "explode", "fromPlayer_noDamage", 0 );
    at_mine_do_damage( "fromPlayer" );
}

// Namespace at_mine
// Params 1
// Checksum 0x4e0e9036, Offset: 0xf99
// Size: 0x10f
function at_mine_explode_from_vehicle_trigger( vehicle )
{
    level endon( #"game_ended" );
    thread at_mine_explode_from_vehicle_trigger_internal();
    
    if ( isdefined( vehicle ) )
    {
        vehicledamage = 200;
        
        if ( self.var_4a4b0a500f4daecd && isdefined( self.bundle.var_4730c95ac0560b6d ) )
        {
            vehicledamage = self.bundle.var_4730c95ac0560b6d;
        }
        
        vehicle dodamage( vehicledamage, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon( self.bundle.useweapon ) );
        ignoredamageid = vehicle damage::non_player_add_ignore_damage_signature( self.owner, makeweapon( self.bundle.useweapon ), self, "MOD_EXPLOSIVE" );
        
        if ( !self.var_4a4b0a500f4daecd )
        {
            waitframe();
        }
        else
        {
            thread at_mine_do_damage( "fromVehicle" );
            self waittill( #"damage_done" );
        }
        
        vehicle damage::non_player_remove_ignore_damage_signature( ignoredamageid );
    }
}

// Namespace at_mine
// Params 0
// Checksum 0x17da7c72, Offset: 0x10b0
// Size: 0xc9
function at_mine_explode_from_vehicle_trigger_internal()
{
    thread at_mine_delete( 5 );
    
    if ( isent( self ) )
    {
        self setentityowner( self.owner );
        self clearscriptabledamageowner();
    }
    
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "launch", "neutral", 0 );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.weapon_name );
    
    if ( bundle.var_435c007a9a9ac7f0 )
    {
        utility::function_ce86ddbb7d60e9bd( self.origin, bundle.var_4441fcc4c44427a3, self.owner );
    }
    
    if ( !self.var_4a4b0a500f4daecd )
    {
        self setscriptablepartstate( "explode", "fromVehicle", 0 );
        return;
    }
    
    self setscriptablepartstate( "explode", "fromVehicle_noDamage", 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0x6d7daf3a, Offset: 0x1181
// Size: 0xd0
function at_mine_explode_from_notify( attacker )
{
    thread at_mine_delete( 5 );
    self setentityowner( attacker );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "launch", "neutral", 0 );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.weapon_name );
    
    if ( bundle.var_435c007a9a9ac7f0 )
    {
        utility::function_ce86ddbb7d60e9bd( self.origin, bundle.var_4441fcc4c44427a3, self.owner );
    }
    
    if ( !self.var_4a4b0a500f4daecd )
    {
        self setscriptablepartstate( "explode", "fromDamage", 0 );
        return;
    }
    
    self setscriptablepartstate( "explode", "fromDamage_noDamage", 0 );
    at_mine_do_damage( "fromDamage" );
}

// Namespace at_mine
// Params 1
// Checksum 0xced0dbd2, Offset: 0x1259
// Size: 0x159
function at_mine_do_damage( explosiontype )
{
    switch ( tolower( explosiontype ) )
    {
        case #"hash_e483dd32e0fdb810":
            origin = self.origin;
            radius = self.bundle.var_515224719df7bc4d;
            innerdamage = self.bundle.var_71d90c8513135f5f;
            outerdamage = self.bundle.var_b9a9d62d877351ae;
            self radiusdamage( origin, radius, innerdamage, outerdamage, self.owner, "MOD_EXPLOSIVE", self.weapon_object );
            break;
        case #"hash_158ce4a7ce3563ff":
        case #"hash_75e0768a682372f0":
            origin = self.origin;
            radius = self.bundle.var_5bc497e55b664d59;
            innerdamage = self.bundle.var_cea9d06454c44d7b;
            outerdamage = self.bundle.var_1ea1d096e4ace2c2;
            self radiusdamage( origin, radius, innerdamage, outerdamage, self.owner, "MOD_EXPLOSIVE", self.weapon_object );
            break;
        default:
            return;
    }
    
    self notify( #"damage_done" );
}

// Namespace at_mine
// Params 1
// Checksum 0x6dfebedc, Offset: 0x13ba
// Size: 0x54
function at_mine_destroy( attacker )
{
    self endon( #"death" );
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "launch", "neutral", 0 );
    self setscriptablepartstate( "destroy", "active", 0 );
    thread at_mine_delete( 5 );
}

// Namespace at_mine
// Params 1
// Checksum 0xab35d4f4, Offset: 0x1416
// Size: 0x1fc
function at_mine_delete( deletiondelay )
{
    if ( self.isdestroyed || !isdefined( self ) )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self notify( #"death" );
    
    if ( weapon::function_89d2d0588f2def25() )
    {
        weapon::deregistermine();
    }
    
    self setscriptablepartstate( "hack_usable", "off" );
    
    if ( isent( self ) )
    {
        self setcandamage( 0 );
        
        if ( level.gamemodebundle.var_738c716858d0a544 )
        {
            utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_a48cc4029c1d44e1" );
        }
        else
        {
            weapons::makeexplosiveunusuabletag();
        }
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.dangerzone ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    if ( isdefined( self.dangericonent ) )
    {
        self.dangericonent delete();
    }
    
    if ( isent( self ) )
    {
        linkedchildren = self getlinkedchildren();
        
        if ( isdefined( linkedchildren ) )
        {
            foreach ( child in linkedchildren )
            {
                if ( isdefined( child ) && child.equipmentref == "equip_claymore" && !child.exploding )
                {
                    child thread claymore::claymore_destroy();
                }
            }
        }
    }
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    ent_manager::deregisterspawn();
    
    if ( isent( self ) )
    {
        self delete();
    }
}

// Namespace at_mine
// Params 0
// Checksum 0x895a30b0, Offset: 0x161a
// Size: 0x86
function at_mine_movingplatform_update()
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

// Namespace at_mine
// Params 1
// Checksum 0xff2dfe29, Offset: 0x16a8
// Size: 0x37, Type: bool
function is_at_mine_moving( mine )
{
    return isdefined( mine ) && isdefined( mine.attachedvelocity ) && length2dsquared( mine.attachedvelocity ) > 0.01;
}

// Namespace at_mine
// Params 0
// Checksum 0x39073ff0, Offset: 0x16e8
// Size: 0x1b0
function at_mine_watch_trigger()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( true )
    {
        self waittill( #"trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        if ( self.isdisabled || self.chaffstunned )
        {
            continue;
        }
        
        foreach ( ent in entarr )
        {
            if ( !( isdefined( ent ) && isdefined( ent.classname ) ) )
            {
                continue;
            }
            
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent vehicle_mines::function_56d954c642e8acea( self ) )
                {
                    continue;
                }
                
                if ( !vehicle_mines::function_60d53a1a3bd504cd( ent, self ) )
                {
                    continue;
                }
                
                vehicle_mines::trigger_mine( ent, self );
                break;
            }
            
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( isdefined( ent.vehicle ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( ent ) )
                {
                    continue;
                }
                
                if ( var_23a82edf24269a34 && ent.spawnprotection )
                {
                    continue;
                }
                
                thread at_mine_player_trigger( ent );
                break;
            }
        }
    }
}

/#

    // Namespace at_mine
    // Params 0
    // Checksum 0x90c39bc0, Offset: 0x18a0
    // Size: 0xe7, Type: dev
    function function_6a9cd2691c88e134()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            debuglaunch = getdvarint( @"hash_e67a08119163320a", 0 );
            
            if ( debuglaunch )
            {
                allmines = weapon::function_3aafcaf7ff6dea9e();
                
                foreach ( mine in allmines )
                {
                    if ( mine.equipmentref == "<dev string:x24>" )
                    {
                        mine thread at_mine_player_trigger( mine.owner );
                    }
                }
                
                setdvar( @"hash_e67a08119163320a", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace at_mine
// Params 1
// Checksum 0x5c5dd6cc, Offset: 0x198f
// Size: 0x109
function at_mine_player_trigger( ent )
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.weapon_name );
    self notify( #"mine_triggered" );
    self.triggeredbyplayer = 1;
    
    if ( level.gamemodebundle.var_738c716858d0a544 )
    {
        utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_a48cc4029c1d44e1" );
    }
    else
    {
        weapons::makeexplosiveunusuabletag();
    }
    
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "trigger", "active", 0 );
    weaponname = utility::get_scripted_weapon_name( #"at_mine_ap" );
    function_d8672fcb29964e7a( weaponname, 100 );
    weapons::explosivetrigger( ent, 0.1 );
    stucktarget = undefined;
    
    if ( bundle.var_11c4b25833bf3b75 )
    {
        stucktarget = ent;
    }
    
    thread at_mine_watch_flight( stucktarget );
}

// Namespace at_mine
// Params 2
// Checksum 0x6ef5fc9d, Offset: 0x1aa0
// Size: 0x71
function function_d8672fcb29964e7a( var_55cef2838fbf6f77, fusetime )
{
    dangericonent = weapon::_launchgrenade( var_55cef2838fbf6f77, self.origin, ( 0, 0, 0 ), fusetime, 1 );
    dangericonent linkto( self );
    thread at_mine_cleanup_danger_icon_ent( dangericonent );
    dangericonent.weapon_object = makeweapon( var_55cef2838fbf6f77 );
    self.dangericonent = dangericonent;
}

// Namespace at_mine
// Params 2
// Checksum 0x3e17e69c, Offset: 0x1b19
// Size: 0x129
function at_mine_vehicle_trigger( vehicle, mine )
{
    mine endon( #"mine_destroyed" );
    mine endon( #"death" );
    mine.owner endon( #"disconnect" );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( mine.weapon_name );
    mine notify( #"mine_triggered" );
    
    if ( isent( mine ) )
    {
        if ( level.gamemodebundle.var_738c716858d0a544 )
        {
            mine utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_a48cc4029c1d44e1" );
        }
        else
        {
            mine weapons::makeexplosiveunusuabletag();
        }
    }
    
    mine setscriptablepartstate( "arm", "neutral", 0 );
    mine setscriptablepartstate( "trigger", "active", 0 );
    wait 0.2;
    
    if ( bundle.var_a0550ba1eda795f8 )
    {
        weaponname = utility::get_scripted_weapon_name( #"at_mine_ap" );
        mine function_d8672fcb29964e7a( weaponname, 100 );
        mine thread at_mine_watch_flight( vehicle );
        return;
    }
    
    mine thread at_mine_explode_from_vehicle_trigger( vehicle );
}

// Namespace at_mine
// Params 2
// Checksum 0x7c5ac80d, Offset: 0x1c4a
// Size: 0x81
function at_mine_watch_flight_mover( flighttime, enttarget )
{
    self endon( #"death" );
    thread function_ff39e11db8a145c( enttarget, flighttime );
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

// Namespace at_mine
// Params 2
// Checksum 0xf335a02b, Offset: 0x1cd3
// Size: 0x140
function function_ff39e11db8a145c( targetent, flighttime )
{
    if ( !isdefined( targetent ) )
    {
        return;
    }
    
    targetent endon( #"death" );
    isplayertarget = isplayer( targetent );
    
    if ( isplayertarget )
    {
        targetent endon( #"disconnect" );
    }
    
    self endon( #"death" );
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( self.grenade.weapon_name );
    
    if ( isdefined( bundle.var_abd6a2c201be330 ) )
    {
        flighttime = bundle.var_abd6a2c201be330;
    }
    
    self.grenade.flightendtime = gettime() + flighttime * 1000;
    
    while ( isdefined( self.grenade ) )
    {
        if ( function_ee3a6b435a538d9d( targetent ) )
        {
            self.grenade unlink();
            self.grenade linkto( targetent );
            self.grenade notify( #"stuck_to_target" );
            stuckstate = "on_vehicle";
            
            if ( isplayertarget )
            {
                stuckstate = "on_player";
            }
            
            self.grenade setscriptablepartstate( "stuck", stuckstate, 0 );
            self delete();
            break;
        }
        
        waitframe();
    }
}

// Namespace at_mine
// Params 1
// Checksum 0xbe651ffe, Offset: 0x1e1b
// Size: 0xc9
function function_ee3a6b435a538d9d( targetent )
{
    canstick = 0;
    traceplayer = 0;
    tracevehicle = 0;
    
    if ( isplayer( targetent ) )
    {
        traceplayer = 1;
    }
    else
    {
        tracevehicle = 1;
    }
    
    contentoverride = trace::create_contents( traceplayer, 0, 0, 0, 0, tracevehicle );
    ignorelist = [ self, self.grenade ];
    traceresult = trace::sphere_trace( self.grenade.origin, self.grenade.origin, 5, ignorelist, contentoverride );
    
    if ( traceresult[ "hittype" ] != "hittype_none" )
    {
        canstick = 1;
    }
    
    return canstick;
}

// Namespace at_mine
// Params 0
// Checksum 0xb8f1174b, Offset: 0x1eed
// Size: 0xa
function deletemine()
{
    at_mine_delete( 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0xaf97914d, Offset: 0x1eff
// Size: 0x2b9
function at_mine_watch_flight( enttarget )
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    flighttime = 0.8;
    
    if ( flighttime > 0 )
    {
        flightdir = ( 0, 0, 1 );
        flightdest = self.origin + flightdir * 64;
        contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip" ] );
        ignorelist = equipment::get_mine_ignore_list();
        caststart = self.origin;
        castend = flightdest;
        castresults = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
        
        if ( castresults.size > 0 )
        {
            castdist = vectordot( castresults[ 0 ][ "position" ] - caststart, flightdir );
            castdist = max( 0, castdist - 1 );
            flighttime = 0;
            flightdest = self.origin;
            
            if ( castdist > 0 )
            {
                flighttime = castdist / 64 * 0.8;
                flightdest = self.origin + flightdir * castdist;
            }
        }
        
        if ( is_at_mine_moving( self ) )
        {
            flightdest += self.attachedvelocity * flighttime;
        }
        
        if ( flighttime > 0 )
        {
            flighttimeremaining = flighttime;
            flightdeceltime = flighttimeremaining * 0.81;
            
            if ( is_at_mine_moving( self ) )
            {
                flightdeceltime *= 0.25;
            }
            
            flighttimeremaining -= flightdeceltime;
            flightacceltime = 0;
            
            if ( flighttimeremaining > 0 )
            {
                flightacceltime = flighttimeremaining * 0;
            }
            
            mover = spawn( "script_model", self.origin );
            mover.angles = vectortoangles( anglestoforward( self.angles ) * ( 1, 1, 0 ) );
            mover setmodel( "tag_origin" );
            self.mover = mover;
            mover.grenade = self;
            self linkto( mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            mover moveto( flightdest, flighttime, flightacceltime, flightdeceltime );
            mover thread at_mine_watch_flight_mover( flighttime, enttarget );
            function_9a19fe76181d4e9c();
            childthread equipment::watch_flight_collision();
            result = utility::waittill_any_timeout( flighttime, "collision_with_platform", "stuck_to_target" );
            
            if ( result == "stuck_to_target" )
            {
                thread at_mine_explode_from_stuck( enttarget );
                return;
            }
            
            thread at_mine_explode_from_player_trigger();
            return;
        }
    }
}

// Namespace at_mine
// Params 0
// Checksum 0x58bf9d3e, Offset: 0x21c0
// Size: 0x34
function function_9a19fe76181d4e9c()
{
    launchstate = "land";
    
    if ( self.hitwater )
    {
        launchstate = "water";
    }
    
    self setscriptablepartstate( "launch", launchstate, 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0xa8b36d6c, Offset: 0x21fc
// Size: 0x6c
function at_mine_empapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self, data.objweapon );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    thread at_mine_destroy( attacker );
}

// Namespace at_mine
// Params 1
// Checksum 0xa149855c, Offset: 0x2270
// Size: 0x8a
function function_b6d91b56187e683f( data )
{
    attacker = data.attacker;
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    attacker thread points::doscoreevent( #"disabled_at_mine" );
    self.chaffstunned = 1;
    self setscriptablepartstate( "empd", "active", 0 );
    self setscriptablepartstate( "plant", "neutral", 0 );
    self setscriptablepartstate( "arm", "neutral", 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0x116544ac, Offset: 0x2302
// Size: 0x49
function function_adef69580fecafa6( data )
{
    self.chaffstunned = 0;
    self setscriptablepartstate( "empd", "neutral", 0 );
    self setscriptablepartstate( "plant", "active", 0 );
    self setscriptablepartstate( "arm", "active", 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0x905dce71, Offset: 0x2353
// Size: 0x66
function at_mine_haywireapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    self notify( #"detonateexplosive", attacker );
}

// Namespace at_mine
// Params 0
// Checksum 0xf184c0dc, Offset: 0x23c1
// Size: 0x60
function at_mine_watch_detonate()
{
    self endon( #"death" );
    self waittill( #"detonateexplosive", attacker );
    
    if ( isdefined( attacker ) )
    {
        thread at_mine_explode_from_notify( attacker );
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        thread at_mine_explode_from_notify( self.owner );
        return;
    }
    
    thread at_mine_destroy();
}

// Namespace at_mine
// Params 0
// Checksum 0x5404c07e, Offset: 0x2429
// Size: 0x33
function at_mine_watch_game_end()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread at_mine_destroy();
}

// Namespace at_mine
// Params 1
// Checksum 0x5176e02b, Offset: 0x2464
// Size: 0x8f
function at_mine_damage_vehicle_manually( vehicle )
{
    vehicle dodamage( 200, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon( self.bundle.useweapon ) );
    ignoredamageid = vehicle damage::non_player_add_ignore_damage_signature( self.owner, makeweapon( self.bundle.useweapon ), self, "MOD_EXPLOSIVE" );
    waitframe();
    
    if ( isdefined( vehicle ) )
    {
        vehicle damage::non_player_remove_ignore_damage_signature( ignoredamageid );
    }
}

// Namespace at_mine
// Params 5
// Checksum 0x33790e8b, Offset: 0x24fb
// Size: 0x31d
function at_mine_modified_damage( victim, inflictor, objweapon, meansofdeath, damage )
{
    if ( !isdefined( inflictor ) )
    {
        return damage;
    }
    
    if ( meansofdeath != "MOD_EXPLOSIVE" )
    {
        return damage;
    }
    
    if ( !isdefined( objweapon ) )
    {
        return damage;
    }
    
    if ( isnullweapon( objweapon ) )
    {
        return damage;
    }
    
    if ( objweapon.basename != level.equipment_at_mine.weaponname && objweapon.basename != utility::get_scripted_weapon_name( #"at_mine_ap" ) )
    {
        return damage;
    }
    
    up = anglestoup( inflictor.angles );
    btwn = inflictor.origin - self geteye();
    var_b42270b1edd83fac = vectordot( btwn, up );
    
    if ( var_b42270b1edd83fac > 60 )
    {
        return 0;
    }
    
    btwn = self.origin - inflictor.origin;
    var_54952b94c2beedeb = vectordot( btwn, up );
    
    if ( var_54952b94c2beedeb > 60 )
    {
        return 0;
    }
    
    if ( objweapon.basename == utility::get_scripted_weapon_name( #"at_mine_ap" ) || inflictor.triggeredbyplayer )
    {
        if ( var_b42270b1edd83fac >= 0 )
        {
            proneclamp = 35;
            crouchclamp = 35;
            
            if ( isdefined( level.var_1de668bdb367b433[ objweapon.basenamehash ] ) && isdefined( level.equipment.table[ level.var_1de668bdb367b433[ objweapon.basenamehash ] ] ) )
            {
                equipref = level.var_1de668bdb367b433[ objweapon.basenamehash ];
                bundle = level.equipment.table[ equipref ].bundle;
                
                if ( bundle.var_128ba815578acfd7 )
                {
                    if ( isdefined( bundle.var_5f37afa798e80ce7 ) )
                    {
                        crouchclamp = bundle.var_5f37afa798e80ce7;
                    }
                    
                    if ( isdefined( bundle.var_6d65cd4d4d98a695 ) )
                    {
                        proneclamp = bundle.var_6d65cd4d4d98a695;
                    }
                }
            }
            
            stance = victim getstance();
            
            if ( stance == "prone" || swim_common::isplayerunderwater() )
            {
                damage = int( min( damage, proneclamp ) );
            }
            else if ( stance == "crouch" || self issprintsliding() )
            {
                damage = int( min( damage, crouchclamp ) );
            }
        }
    }
    
    if ( isdefined( victim ) && victim isdiving() )
    {
        if ( damage >= victim.health )
        {
            damage = victim.health - 1;
        }
    }
    
    if ( damage < victim.health )
    {
        if ( stance == "prone" || stance == "crouch" || victim isdiving() )
        {
            callback::callback( #"hash_bb2b63d9cf172bfa", { #victim:victim } );
        }
    }
    
    return damage;
}

// Namespace at_mine
// Params 1
// Checksum 0xf63cb0b5, Offset: 0x2821
// Size: 0x2d
function at_mine_cleanup_danger_icon_ent( dangericonent )
{
    dangericonent endon( #"death" );
    self waittill( #"death" );
    dangericonent delete();
}

// Namespace at_mine
// Params 1
// Checksum 0xff94a5e1, Offset: 0x2856
// Size: 0x7f
function at_mine_onownerchanged( oldowner )
{
    self setscriptablepartstate( "hacked", "active", 0 );
    at_mine_update_danger_zone();
    sentientpool = self.sentientpool;
    sentientpoolmanager::unregistersentient( self.sentientpool, self.sentientpoolindex );
    sentientpoolmanager::registersentient( sentientpool, self.owner, 1 );
    thread weapons::monitordisownedequipment( self.owner, self );
    thread weapons::outlineequipmentforowner( self );
}

// Namespace at_mine
// Params 1
// Checksum 0x31509006, Offset: 0x28dd
// Size: 0x7e
function at_mine_disable( attacker )
{
    self endon( #"death" );
    attacker thread points::doscoreevent( #"disabled_at_mine" );
    self.isdisabled = 1;
    self setscriptablepartstate( "empd", "active", 0 );
    
    if ( !self.owner.ksempd )
    {
        wait 6;
        self.isdisabled = 0;
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace at_mine
// Params 1
// Checksum 0x894c7f0e, Offset: 0x2963
// Size: 0x27
function at_mine_empcleared( data )
{
    self.isdisabled = 0;
    self setscriptablepartstate( "empd", "neutral", 0 );
}

// Namespace at_mine
// Params 1
// Checksum 0xbe03b701, Offset: 0x2992
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

