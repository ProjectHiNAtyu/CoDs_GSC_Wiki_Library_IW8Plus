// scripts\mp\common\equipment\claymore.gsc  (hash_011f1c46396d1b9f.gscc) (size: 15860 Bytes / 0x3df4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e02687f (2114087039)
// size ...... 15860 (0x3df4)
// includes .. 25  (offset: 0x39fc)
// strings ... 43  (offset: 0x3ac4)
// dev strs .. 2   (offset: 0x3ddc)
// exports ... 35  (offset: 0x22f0)
// cseg ...... 0x327 + 0x1fc9 (0x22f0)
// imports ... 145 (offset: 0x2868)
// animtree1 . 0   (offset: 0x3df4)
// animtree2 . 0   (offset: 0x3df4)
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_mines;
#using scripts\common\weapon;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\equipment;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\hud_message;
#using scripts\mp\scripted_weapons;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\weapons;

#namespace claymore;

// Namespace claymore
// Params 0, eflags: 0x1
// Checksum 0x3f49cbe0, Offset: 0x345
// Size: 0x11b
function autoexec claymore_init()
{
    level thread function_2c6f8297f69a3013();
    utility::flag_wait( "equipment_initialized" );
    level._effect[ "claymore_explode" ] = loadfxasset( "vfx_iw9_core_equip_claymore_trigger" );
    
    if ( game[ "isLaunchChunk" ] )
    {
        return;
    }
    
    minetriggerdata = vehicle_mines::get_mine_data( "equip_claymore", 1 );
    minetriggerdata.triggercallback = &claymore_triggerfromvehicle;
    weapons::registerusedcallback( "claymore", &claymore_use );
    equipment_mp::registercallback( "equip_claymore", "onOwnerChanged", &claymore_onownerchanged );
    equipment_mp::registercallback( "equip_claymore", "onDestroyedByTrophy", &claymore_delete );
    level.var_d3ff65cbeaa3ff69[ #"claymore" ] = &claymore_modifieddamage;
    level.var_d3ff65cbeaa3ff69[ #"claymore_radial" ] = &claymore_modifieddamage;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"train" ][ #"hash_2edafff898b3de81" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( #"claymore", &sweepclaymore );
    }
    
    equipmentinteractinit();
}

// Namespace claymore
// Params 0, eflags: 0x4
// Checksum 0xbbe193d9, Offset: 0x468
// Size: 0x4d
function private function_2c6f8297f69a3013()
{
    level endon( #"game_ended" );
    utility::flag_wait( "loadEquipmentBundles_finished" );
    damageweaponname = scripted_weapons::get_scripted_weapon_object( #"claymore_radial" ).basenamehash;
    equipment_mp::function_e08050aec5516278( "equip_claymore", damageweaponname );
}

// Namespace claymore
// Params 0
// Checksum 0xbb5972d9, Offset: 0x4bd
// Size: 0xab
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_claymore" ].bundle;
    
    if ( !bundle.equipmentinteractions || !bundle.useweapon )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_claymore" ), #"interactdisable", &function_93c735c4951d1283 );
    utility::registersharedfunc( getxhash( "equip_claymore" ), #"interactenable", &function_f15b2e8d1e5871bf );
    utility::registersharedfunc( getxhash( "equip_claymore" ), #"interactdestroy", &function_f2f768b368caf965 );
}

// Namespace claymore
// Params 1
// Checksum 0x34bb6f4f, Offset: 0x570
// Size: 0x1e
function function_93c735c4951d1283( data )
{
    function_def0a32d99f5c680( data.attacker );
}

// Namespace claymore
// Params 1
// Checksum 0xd67deeb5, Offset: 0x596
// Size: 0x13
function function_f2f768b368caf965( data )
{
    claymore_destroy();
}

// Namespace claymore
// Params 1
// Checksum 0x95f47a2f, Offset: 0x5b1
// Size: 0x374
function claymore_use( grenade )
{
    self endon( #"death_or_disconnect" );
    grenade endon( #"death" );
    
    if ( isdefined( self.perks[ "specialty_rugged_eqp" ] ) )
    {
        grenade.hasruggedeqp = 1;
    }
    
    grenade.exploding = 1;
    thread weapons::monitordisownedgrenade( self, grenade );
    
    if ( isdefined( vehicle::get_vehicle() ) )
    {
        hud_message::showerrormessage( grenade.bundle.claymore_errormessage );
        thread equipment_mp::incrementequipmentammo( "equip_claymore", 1 );
        waitframe();
        grenade delete();
    }
    
    plantdata = spawnstruct();
    plantdata.throwspeedforward = 100;
    plantdata.throwspeedup = -50;
    plantdata.castdivisions = 3;
    plantdata.castmaxtime = grenade.bundle.var_beaeecf6acdd9e09 ?? 0.5;
    plantdata.castdetail = 1;
    plantdata.plantmaxtime = grenade.bundle.var_beaeecf6acdd9e09 ?? 0.5;
    plantdata.plantmaxroll = 15;
    plantdata.plantmindistbeloweye = 12;
    plantdata.plantmaxdistbelowownerfeet = 20;
    plantdata.plantmindisteyetofeet = 45;
    plantdata.plantnormalcos = 0.342;
    plantdata.plantoffsetz = 3;
    plantdata.var_7d250c296decddc9 = grenade.bundle.var_df420141f8a06386 ?? 0;
    
    if ( train_utility::player_standing_on_train() )
    {
        plantdata.plantoffsetz += 2;
        plantdata.contents = train_utility::function_d2c2c502947f8c4a();
    }
    else
    {
        plantdata.contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass" ] );
    }
    
    if ( grenade.bundle.var_7d1ea16f3b7d5843 )
    {
        grenade setscriptablepartstate( "visibility", "show", 0 );
    }
    
    plantresult = equipment::plant( grenade, plantdata );
    
    if ( !plantresult.result )
    {
        hud_message::showerrormessage( grenade.bundle.claymore_errormessage );
        thread equipment_mp::incrementequipmentammo( "equip_claymore", 1 );
        grenade delete();
        return;
    }
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            hud_message::showerrormessage( grenade.bundle.claymore_errormessage );
            equipment_mp::incrementequipmentslotammo( "primary" );
            grenade delete();
            return;
        }
    }
    
    linkedparent = grenade getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        grenade weapons::explosivehandlemovers( linkedparent );
    }
    
    grenade.exploding = 0;
    grenade thread claymore_plant();
    
    if ( utility::issharedfuncdefined( #"entity", #"hash_c7672f71e7dbfe82" ) )
    {
        [[ utility::getsharedfunc( #"entity", #"hash_c7672f71e7dbfe82" ) ]]( grenade, self, "claymore" );
        grenade thread function_2474022e594dd10e();
    }
}

// Namespace claymore
// Params 0
// Checksum 0x73cac965, Offset: 0x92d
// Size: 0x2b2
function claymore_plant()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    owner = self.owner;
    ent_manager::registerspawn( 1, &sweepclaymore );
    sentientpoolmanager::registersentient( "Lethal_Static", owner, 1 );
    
    if ( level.gamemodebundle.var_738c716858d0a544 )
    {
        utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_34f9d09235c7b7df" );
    }
    else
    {
        thread weapons::makeexplosiveusabletag( "tag_use", 1 );
    }
    
    owner weapons::onequipmentplanted( self, "equip_claymore", &claymore_delete );
    thread weapons::monitordisownedequipment( owner, self );
    self missilethermal();
    self missileoutline();
    self setentityowner( owner );
    self setotherent( owner );
    self setnodeploy( 1 );
    self.headiconid = entityheadicons::setheadicon_equipment( self );
    thread weapons::outlineequipmentforowner( self );
    thread weapons::minedamagemonitor();
    thread claymore_explodeonnotify();
    emp_debuff::set_apply_emp_callback( &claymore_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempapplycallback = &function_80494632513116ee;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempclearcallback = &function_f15b2e8d1e5871bf;
    }
    
    chaff_debuff::function_3860212a5ec36b56( &function_d1d2442ce72487c );
    chaff_debuff::function_324dd42a2703bc25( &function_35bab643d011eecd );
    haywire::function_7f69a1eb3d590f76( &claymore_haywireapplied );
    function_a4ebfb83ec0621b9( &claymore_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( self );
        }
    }
    
    claymore_updatedangerzone();
    self setscriptablepartstate( "plant", "active", 0 );
    owner setscriptablepartstate( "equipClaymoreFXView", "plant", 0 );
    thread claymore_forceclampangles();
    wait self.bundle.claymore_armtime;
    self setscriptablepartstate( "arm", "active", 0 );
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        self [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( self );
    }
    
    thread claymore_watchfortrigger();
    thread equipment_interact::remoteinteractsetup( &claymore_trigger, 1, 1 );
    owner weapons::function_e9702cd6c6aeec0f( self, ( 0, 0, 1 ) );
}

// Namespace claymore
// Params 0
// Checksum 0xb756780d, Offset: 0xbe7
// Size: 0x60
function claymore_updatedangerzone()
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

// Namespace claymore
// Params 0
// Checksum 0x7c16dd, Offset: 0xc4f
// Size: 0x7b
function claymore_forceclampangles()
{
    self endon( #"mine_selfdestruct" );
    self endon( #"death" );
    endtime = gettime() + 2000;
    
    while ( endtime > gettime() )
    {
        yawonly = ( 0, self.angles[ 1 ], 0 );
        maxdiff = 15;
        self.angles = anglelerpquat( yawonly, self.angles, maxdiff );
        waitframe();
    }
}

// Namespace claymore
// Params 0
// Checksum 0x7fe7bf7, Offset: 0xcd2
// Size: 0x3ee
function claymore_watchfortrigger()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water" ] );
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( true )
    {
        self waittill( #"trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        if ( self.stunned || self.chaffstunned )
        {
            continue;
        }
        
        foreach ( ent in entarr )
        {
            if ( isdefined( ent.classname ) )
            {
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
                    if ( !player::isreallyalive( ent ) )
                    {
                        continue;
                    }
                    
                    if ( var_23a82edf24269a34 && ent.spawnprotection )
                    {
                        continue;
                    }
                    
                    forward = anglestoforward( self.angles );
                    up = anglestoup( self.angles );
                    castorigin = self.origin + up * 0;
                    
                    if ( isent( self ) )
                    {
                        ignorelist = equipment::get_mine_ignore_list();
                    }
                    else
                    {
                        ignorelist = [];
                    }
                    
                    if ( ent utility::hastag( ent.model, "j_mainroot" ) )
                    {
                        var_c61cd1b15eeee03c = ent gettagorigin( "j_mainroot" );
                    }
                    else
                    {
                        var_c61cd1b15eeee03c = ent.origin;
                    }
                    
                    eorigins = [ var_c61cd1b15eeee03c ];
                    btwn = castorigin - var_c61cd1b15eeee03c;
                    eorigin = ent.origin;
                    
                    if ( vectordot( btwn, ( 0, 0, 1 ) ) >= 0 )
                    {
                        eorigin = ent gettagorigin( "j_spineupper", 1 ) ?? eorigin;
                    }
                    
                    eorigins[ eorigins.size ] = eorigin;
                    handled = 0;
                    
                    foreach ( eorigin in eorigins )
                    {
                        btwn = eorigin - self.origin;
                        var_5d36b0dd458f541d = vectordot( btwn, forward );
                        
                        if ( var_5d36b0dd458f541d > 90 )
                        {
                            continue;
                        }
                        
                        var_e0c5702bc28fce7d = vectordot( btwn, up );
                        
                        if ( abs( var_e0c5702bc28fce7d ) > 32 )
                        {
                            continue;
                        }
                        
                        var_da5b527c1a410a9f = vectornormalize( btwn );
                        var_5a089502e5e472f7 = vectordot( var_da5b527c1a410a9f, forward );
                        
                        if ( var_5a089502e5e472f7 < 0.86602 )
                        {
                            continue;
                        }
                        
                        castresults = physics_raycast( castorigin, eorigin, contents, ignorelist, 0, "physicsquery_closest", 1 );
                        
                        if ( castresults.size > 0 )
                        {
                            continue;
                        }
                        
                        handled = 1;
                        thread claymore_trigger( ent );
                    }
                    
                    if ( handled )
                    {
                        break;
                    }
                }
            }
        }
    }
}

// Namespace claymore
// Params 2
// Checksum 0x354ff251, Offset: 0x10c8
// Size: 0x11f
function claymore_trigger( ent, attacker )
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    
    if ( isdefined( attacker ) )
    {
        attacker endon( #"disconnect" );
    }
    else
    {
        attacker = self.owner;
    }
    
    self notify( #"mine_triggered" );
    
    /#
        print::printgameaction( "<dev string:x24>", self.owner );
    #/
    
    if ( isent( self ) )
    {
        if ( level.gamemodebundle.var_738c716858d0a544 )
        {
            utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_a48cc4029c1d44e1" );
        }
        else
        {
            weapons::makeexplosiveunusuabletag();
        }
    }
    
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "trigger", "active", 0 );
    graceperiod = self.bundle.claymore_graceperiod ?? 0;
    weapons::explosivetrigger( ent, graceperiod );
    thread claymore_explode( attacker );
}

// Namespace claymore
// Params 2
// Checksum 0xa2d7444b, Offset: 0x11ef
// Size: 0xd3
function claymore_triggerfromvehicle( vehicle, mine )
{
    mine endon( #"mine_destroyed" );
    mine endon( #"death" );
    mine.owner endon( #"disconnect" );
    mine notify( #"mine_triggered" );
    
    if ( level.gamemodebundle.var_738c716858d0a544 )
    {
        mine utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_a48cc4029c1d44e1" );
    }
    else
    {
        mine weapons::makeexplosiveunusuabletag();
    }
    
    mine setscriptablepartstate( "arm", "neutral", 0 );
    mine setscriptablepartstate( "trigger", "active", 0 );
    wait mine.bundle.var_dbc09cc14dde3f2e;
    mine thread claymore_explodefromvehicletrigger( vehicle );
}

// Namespace claymore
// Params 1
// Checksum 0x98946a7e, Offset: 0x12ca
// Size: 0x97
function claymore_explodefromvehicletrigger( vehicle )
{
    vehicle dodamage( self.bundle.var_510ba0bb7a34b473 ?? 0, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon( %"claymore_mp" ) );
    ignoredamageid = vehicle damage::non_player_add_ignore_damage_signature( self.owner, makeweapon( %"claymore_mp" ), self, "MOD_EXPLOSIVE" );
    thread claymore_explode();
    waitframe();
    
    if ( isdefined( vehicle ) )
    {
        vehicle damage::non_player_remove_ignore_damage_signature( ignoredamageid );
    }
}

// Namespace claymore
// Params 1
// Checksum 0x355ce5d7, Offset: 0x1369
// Size: 0x27e
function claymore_explode( attacker )
{
    self setscriptablepartstate( "plant", "neutral", 0 );
    self setscriptablepartstate( "trigger", "neutral", 0 );
    self setscriptablepartstate( "explode", "active", 0 );
    
    if ( self getscriptablehaspart( "health" ) )
    {
        self setscriptablepartstate( "health", "ignore_damage", 0 );
    }
    
    if ( isent( self ) )
    {
        weapon::deregistermine();
        self setcandamage( 0 );
        ent_manager::deregisterspawn();
        
        if ( level.gamemodebundle.var_738c716858d0a544 )
        {
            utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_a48cc4029c1d44e1" );
        }
        else
        {
            weapons::makeexplosiveunusuabletag();
        }
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    self.exploding = 1;
    owner = self.owner;
    
    if ( isdefined( self.owner ) )
    {
        owner weapons::removeequip( self );
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    
    if ( isent( self ) )
    {
        damagedealer = self;
    }
    else if ( isent( owner ) )
    {
        damagedealer = owner;
        
        if ( !isdefined( owner.var_183e97ad0a703f17 ) )
        {
            owner.var_183e97ad0a703f17 = [];
        }
        
        if ( !isdefined( owner.var_183e97ad0a703f17[ %"claymore_mp" ] ) )
        {
            owner.var_183e97ad0a703f17[ %"claymore_mp" ] = [];
        }
        
        owner.var_183e97ad0a703f17[ %"claymore_mp" ][ owner.var_183e97ad0a703f17[ %"claymore_mp" ].size ] = self.index;
    }
    
    waitframe();
    earthquake( 0.45, 0.7, self.origin, 800 );
    
    if ( isdefined( damagedealer ) )
    {
        weaponname = self.bundle.damageweapons ?? scripted_weapons::get_scripted_weapon_object( #"claymore_radial" ) ?? %"claymore_radial_mp";
        damagedealer radiusdamage( self.origin, self.bundle.var_5203bd2b9eade662, self.bundle.var_3286a1243c1b2d1, self.bundle.var_34b5c1243e7dbbf, self.owner, "MOD_EXPLOSIVE", weaponname );
    }
    
    if ( isent( self ) )
    {
        self detonate( attacker );
    }
}

// Namespace claymore
// Params 0
// Checksum 0x86d63c66, Offset: 0x15ef
// Size: 0x75
function claymore_explodeonnotify()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"detonateexplosive", attacker );
    self.detonatingplayer = attacker;
    self setscriptablepartstate( "arm", "neutral", 0 );
    self setscriptablepartstate( "trigger", "active", 0 );
    self notify( #"mine_triggered" );
    thread claymore_explode( attacker );
}

// Namespace claymore
// Params 0
// Checksum 0x651efb6d, Offset: 0x166c
// Size: 0x9
function sweepclaymore()
{
    claymore_destroy();
}

// Namespace claymore
// Params 1
// Checksum 0x14f81d51, Offset: 0x167d
// Size: 0x34
function claymore_destroy( destroydelay = 0 )
{
    self setscriptablepartstate( "destroy", "active", 0 );
    thread claymore_delete( destroydelay + 0.2 );
}

// Namespace claymore
// Params 1
// Checksum 0xc369a8df, Offset: 0x16b9
// Size: 0x8f
function claymore_empapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    attacker thread points::doscoreevent( #"hash_63de6daee74ed86f" );
    damagefeedback = "";
    
    if ( self.hasruggedeqp )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    thread claymore_destroy();
}

// Namespace claymore
// Params 1
// Checksum 0x939adebe, Offset: 0x1750
// Size: 0x8a
function function_80494632513116ee( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self, data.objweapon );
    }
    
    damagefeedback = "";
    
    if ( self.hasruggedeqp )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    thread function_17884d9e89025637( attacker );
}

// Namespace claymore
// Params 1
// Checksum 0x7321f1b5, Offset: 0x17e2
// Size: 0xc7
function function_d1d2442ce72487c( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) || getdvarint( @"hash_a9351075975417a", 0 ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    damagefeedback = "";
    
    if ( self.hasruggedeqp )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    self setscriptablepartstate( "empd", "active", 0 );
    self setscriptablepartstate( "arm", "neutral", 0 );
    attacker thread points::doscoreevent( #"disabled_claymore" );
    self.chaffstunned = 1;
}

// Namespace claymore
// Params 1
// Checksum 0xd92d1a37, Offset: 0x18b1
// Size: 0x38
function function_35bab643d011eecd( data )
{
    self setscriptablepartstate( "empd", "neutral", 0 );
    self setscriptablepartstate( "arm", "active", 0 );
    self.chaffstunned = 0;
}

// Namespace claymore
// Params 1
// Checksum 0xb98ba401, Offset: 0x18f1
// Size: 0x7f
function claymore_haywireapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    damagefeedback = "";
    
    if ( self.hasruggedeqp )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    claymore_explode( attacker );
}

// Namespace claymore
// Params 1
// Checksum 0x32e7e333, Offset: 0x1978
// Size: 0x48
function function_9a7c71dee883d589( attacker )
{
    self endon( #"death" );
    self setscriptablepartstate( "empd", "active", 0 );
    claymore_stunned( attacker, 6 );
    self setscriptablepartstate( "empd", "neutral", 0 );
}

// Namespace claymore
// Params 1
// Checksum 0x7ca8a4a8, Offset: 0x19c8
// Size: 0x32
function function_17884d9e89025637( attacker )
{
    self endon( #"death" );
    self setscriptablepartstate( "empd", "active", 0 );
    function_def0a32d99f5c680( attacker );
}

// Namespace claymore
// Params 1
// Checksum 0xae5bcf45, Offset: 0x1a02
// Size: 0x152
function claymore_delete( deletiondelay = 0 )
{
    self setscriptablepartstate( "hack_usable", "off" );
    self notify( #"death" );
    ent_manager::deregisterspawn();
    
    if ( isent( self ) )
    {
        weapon::deregistermine();
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
    else if ( isdefined( level.entlessmines[ self.index ] ) )
    {
        level.entlessmines[ self.index ] = undefined;
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.dangerzone ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    owner = self.owner;
    
    if ( isdefined( self.owner ) )
    {
        owner weapons::removeequip( self );
    }
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    self freescriptable();
}

// Namespace claymore
// Params 5
// Checksum 0xfc843c7e, Offset: 0x1b5c
// Size: 0x4a2
function claymore_modifieddamage( victim, inflictor, objweapon, meansofdeath, damage )
{
    if ( !isdefined( inflictor ) )
    {
        return damage;
    }
    
    if ( isnullweapon( objweapon ) )
    {
        return damage;
    }
    
    if ( !equipment_mp::function_ae4237ff60a6e452( "equip_claymore" ) )
    {
        return damage;
    }
    
    tableinfo = equipment_mp::getequipmenttableinfo( "equip_claymore" );
    bundle = tableinfo.bundle;
    
    if ( isdefined( inflictor.owner ) )
    {
        attacker = inflictor.owner;
        claymoreorigin = inflictor.origin;
        claymoreangles = inflictor.angles;
    }
    else if ( isdefined( inflictor.team ) && isagent( inflictor ) && objweapon.basenamehash == ( bundle.var_f22fea20f0956588 ?? %"claymore_radial_mp" ) )
    {
        attacker = inflictor;
        
        if ( isdefined( attacker.var_183e97ad0a703f17[ %"claymore_mp" ] ) )
        {
            foreach ( explosiveid in attacker.var_183e97ad0a703f17[ %"claymore_mp" ] )
            {
                explosive = level.entlessmines[ explosiveid ];
                claymoreorigin = explosive.origin;
                claymoreangles = explosive.angles;
                attacker.var_183e97ad0a703f17[ %"claymore_mp" ] = arrayremove( attacker.var_183e97ad0a703f17[ %"claymore_mp" ], explosiveid );
                break;
            }
        }
        else
        {
            assertmsg( "<dev string:x37>" );
        }
    }
    
    if ( objweapon.basenamehash == %"claymore_mp" )
    {
        if ( isdefined( self.claymoreshitby ) )
        {
            foreach ( claymore in self.claymoreshitby )
            {
                if ( claymore == inflictor )
                {
                    return 0;
                }
            }
        }
    }
    else if ( objweapon.basenamehash == ( bundle.var_f22fea20f0956588 ?? %"claymore_radial_mp" ) )
    {
        if ( !player_utility::playersareenemies( victim, attacker ) )
        {
            return 0;
        }
        
        thread claymore_blockdamageuntilframeend( inflictor );
    }
    else
    {
        return damage;
    }
    
    if ( isbrgamemode() )
    {
        return damage;
    }
    
    if ( !isexplosivedamagemod( meansofdeath ) )
    {
        return damage;
    }
    
    btwn = victim.origin - claymoreorigin;
    dist = vectordot( btwn, anglestoup( claymoreangles ) );
    
    if ( dist > 65 )
    {
        return 0;
    }
    
    btwn = claymoreorigin - victim geteye();
    dist = vectordot( btwn, anglestoup( claymoreangles ) );
    
    if ( dist > 65 )
    {
        return 0;
    }
    
    forward = anglestoforward( claymoreangles );
    forward = ( forward[ 0 ], forward[ 1 ], 0 );
    disp = victim.origin - claymoreorigin;
    disp = ( disp[ 0 ], disp[ 1 ], 0 );
    dot = vectordot( forward, disp );
    
    if ( dot < 0 )
    {
        return 0;
    }
    
    dist = distance2d( claymoreorigin, victim.origin );
    ratio = 1 - clamp( ( dist - bundle.var_2daa25b0ee59dcfb ) / ( bundle.var_2d871bb0ee337f45 - bundle.var_2daa25b0ee59dcfb ), 0, 1 );
    damage = bundle.var_34b5c1243e7dbbf + ( bundle.var_2d871bb0ee337f45 - bundle.var_2daa25b0ee59dcfb ) * ratio;
    
    if ( isdefined( inflictor.detonatingplayer ) )
    {
        var_6d1e81e8b22484b5 = inflictor.detonatingplayer == inflictor.owner;
        var_2e4aad7b2d82fffa = inflictor.detonatingplayer == victim;
        
        if ( !var_6d1e81e8b22484b5 && var_2e4aad7b2d82fffa )
        {
            damage = min( damage, 80 );
        }
    }
    
    return damage;
}

// Namespace claymore
// Params 1
// Checksum 0x443f5cd5, Offset: 0x2007
// Size: 0x68
function claymore_blockdamageuntilframeend( inflictor )
{
    self endon( #"disconnect" );
    self notify( #"hash_1fbbe8c2be02a8c4" );
    self endon( #"hash_1fbbe8c2be02a8c4" );
    
    if ( !isdefined( self.claymoreshitby ) )
    {
        self.claymoreshitby = [];
    }
    
    self.claymoreshitby[ self.claymoreshitby.size ] = inflictor;
    waittillframeend();
    self.claymoreshitby = undefined;
}

// Namespace claymore
// Params 1
// Checksum 0xe4f5212a, Offset: 0x2077
// Size: 0x7f
function claymore_onownerchanged( oldowner )
{
    self setscriptablepartstate( "hacked", "active", 0 );
    claymore_updatedangerzone();
    sentientpool = self.sentientpool;
    sentientpoolmanager::unregistersentient( self.sentientpool, self.sentientpoolindex );
    sentientpoolmanager::registersentient( sentientpool, self.owner, 1 );
    thread weapons::monitordisownedequipment( self.owner, self );
    thread weapons::outlineequipmentforowner( self );
}

// Namespace claymore
// Params 2
// Checksum 0xdb3eb5c4, Offset: 0x20fe
// Size: 0xb6
function claymore_stunned( attacker, duration )
{
    self endon( #"death" );
    
    if ( !isdefined( duration ) )
    {
        duration = self.bundle.claymore_stunduration;
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "hitequip" );
    }
    
    self notify( #"hash_cd779a5272613c0d" );
    self endon( #"hash_cd779a5272613c0d" );
    attacker thread points::doscoreevent( #"disabled_claymore" );
    self setscriptablepartstate( "arm", "neutral", 0 );
    self.stunned = 1;
    wait duration;
    self.stunned = 0;
    self setscriptablepartstate( "arm", "active", 0 );
}

// Namespace claymore
// Params 1
// Checksum 0xd2dc5c85, Offset: 0x21bc
// Size: 0x75
function function_def0a32d99f5c680( attacker )
{
    self endon( #"death" );
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "hitequip" );
    }
    
    self notify( #"hash_cd779a5272613c0d" );
    self endon( #"hash_cd779a5272613c0d" );
    attacker thread points::doscoreevent( #"disabled_claymore" );
    self setscriptablepartstate( "arm", "neutral", 0 );
    self.stunned = 1;
}

// Namespace claymore
// Params 1
// Checksum 0x3f16f350, Offset: 0x2239
// Size: 0x27
function function_f15b2e8d1e5871bf( data )
{
    self.stunned = 0;
    self setscriptablepartstate( "arm", "active", 0 );
}

// Namespace claymore
// Params 1
// Checksum 0xf21587c4, Offset: 0x2268
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace claymore
// Params 0
// Checksum 0x5e694ddf, Offset: 0x2287
// Size: 0x33
function claymore_watch_game_end()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread claymore_destroy();
}

// Namespace claymore
// Params 0
// Checksum 0x68c989f3, Offset: 0x22c2
// Size: 0x2e
function function_2474022e594dd10e()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self waittill( #"hash_48859e1eba4d25f" );
    claymore_destroy();
}

