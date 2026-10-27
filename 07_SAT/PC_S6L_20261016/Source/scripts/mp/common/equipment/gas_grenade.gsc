// scripts\mp\common\equipment\gas_grenade.gsc  (hash_6a3544644b02bfb7.gscc) (size: 33193 Bytes / 0x81a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x576a3eb2 (1466580658)
// size ...... 33193 (0x81a9)
// includes .. 39  (offset: 0x7b9d)
// strings ... 54  (offset: 0x7cd5)
// dev strs .. 9   (offset: 0x8139)
// exports ... 70  (offset: 0x5435)
// cseg ...... 0x457 + 0x4fde (0x5435)
// imports ... 229 (offset: 0x5f25)
// animtree1 . 0   (offset: 0x81a9)
// animtree2 . 0   (offset: 0x81a9)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\supers\gas_trap;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\ent_manager;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\common;
#using scripts\mp\scripted_weapons;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace gas_grenade;

// Namespace gas_grenade
// Params 0, eflags: 0x1
// Checksum 0x44bc2991, Offset: 0x475
// Size: 0x1dc
function autoexec gasgrenade_init()
{
    utility::flag_wait( "equipment_initialized" );
    
    if ( !isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        level.var_ef6fc50ff40f47a8 = [];
    }
    
    level.var_ef6fc50ff40f47a8[ level.var_ef6fc50ff40f47a8.size ] = "gas";
    perkfunctions::function_deeb2f40153920c7( "gas", &function_8ac87a6ce246f3e3 );
    weapons::registerusedcallback( "gas", &gas_used );
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_gas", &gas_used );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customend:1, #equipref:"equip_gas_grenade" } );
    level callback::add( #"on_ai_killed", &gas_grenade_on_ai_killed );
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( !bundle )
    {
        return;
    }
    
    level.var_d010b06c3c14eb1d = getxhashasset( bundle.useweapon );
    equipment_mp::registercallback( "equip_gas_grenade", "onPlayerDamaged", &gas_onplayerdamaged );
    
    if ( utility::callsharedfunc( #"gas", #"hash_43bf0d88a1c3c9b8", bundle ) )
    {
        data = utility::callsharedfunc( #"gas", #"hash_b1acc2201b601807", "gas_grenade", bundle.gassettings, &function_30a5ccb26ebe5c64, &function_c05e808ce6343d0e, undefined, &function_521f3138a5a67658, &function_ca1a5849471f6394, &function_2eeef3a721b936d7 );
        level.equipment.table[ "equip_gas_grenade" ].createtriggerfunc = data.createtrigger;
        level.equipment.table[ "equip_gas_grenade" ].var_5a57daa69c661479 = 1;
    }
}

// Namespace gas_grenade
// Params 0
// Checksum 0xbaccf48f, Offset: 0x659
// Size: 0x31
function function_8ac87a6ce246f3e3()
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return 0;
    }
    
    owner thread gas_used( self );
    weapons::_detonate();
}

// Namespace gas_grenade
// Params 3
// Checksum 0x98bde4ad, Offset: 0x692
// Size: 0xba
function gas_used( grenade, isgl, objweapon )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    team = grenade.owner.team;
    challenges::function_3d7a169dbae062fb( "equip_gas_grenade", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    
    /#
        print::printgameaction( "<dev string:x24>", grenade.owner );
    #/
    
    thread weapons::monitordisownedgrenade( self, grenade );
    thread gas_watchexplode( grenade, team );
    grenade thread equipment_mp::watchwaterdepth( &function_4ab67ff5e3cc3980 );
}

// Namespace gas_grenade
// Params 0
// Checksum 0x98f01099, Offset: 0x754
// Size: 0xc
function function_4ab67ff5e3cc3980()
{
    if ( self )
    {
        self delete();
    }
}

// Namespace gas_grenade
// Params 2
// Checksum 0x96d36485, Offset: 0x768
// Size: 0x167
function gas_watchexplode( grenade, team )
{
    grenade thread script::notifyafterframeend( "death", "end_explode" );
    grenade endon( #"end_explode" );
    owner = grenade.owner;
    grenade waittill( #"explode", position );
    duration = getdvarfloat( @"scr_gas_grenade_duration", 6.5 );
    triggerinfo = { #weaponobj:grenade.weapon_object };
    
    if ( level.equipment.table[ "equip_gas_grenade" ].var_5a57daa69c661479 && level.equipment.table[ "equip_gas_grenade" ].createtriggerfunc )
    {
        trigger = [[ level.equipment.table[ "equip_gas_grenade" ].createtriggerfunc ]]( "gas_grenade", position, owner, team, duration, undefined, undefined, undefined, undefined, triggerinfo );
        trigger.eventid = grenade.eventid;
        return;
    }
    
    grenade thread gas_createtrigger( position, owner, team, duration, undefined, undefined, undefined, undefined, undefined, undefined, grenade.weapon_name, triggerinfo );
}

// Namespace gas_grenade
// Params 1
// Checksum 0xd07eebcd, Offset: 0x8d7
// Size: 0x2b8, Type: bool
function gas_onplayerdamaged( data )
{
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    if ( data.attacker == data.victim )
    {
        if ( distancesquared( data.point, data.victim.origin ) > 30625 )
        {
            return false;
        }
    }
    else if ( isplayer( data.attacker ) )
    {
        data.attacker damage::combatrecordtacticalstat( "equip_gas_grenade" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( data.attacker ) ) )
        {
            if ( isdefined( data.attacker.leaderboarddata[ "gasHits" ] ) )
            {
                data.attacker.leaderboarddata[ "gasHits" ] = data.attacker.leaderboarddata[ "gasHits" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "gasHits" ] ) )
            {
                [[ level.leaderboardfunc[ "gasHits" ] ]]( data.attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x35>" );
            
            if ( isdefined( data.attacker.pers[ "gasHits" ] ) )
            {
                data.attacker.pers[ "gasHits" ] = data.attacker.pers[ "gasHits" ] + 1;
            }
        }
        
        challenges::function_3d7a169dbae062fb( "equip_gas_grenade", data.attacker, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
        
        if ( isdefined( data.victim.perks[ "specialty_gas_grenade_resist" ] ) )
        {
            data.attacker damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
        }
    }
    
    if ( level.equipment.table[ "equip_gas_grenade" ].var_5a57daa69c661479 )
    {
        return true;
    }
    
    if ( function_7ae095a698691834() && isdefined( self.gasmaskhealth ) && self.gasmaskhealth > 0 )
    {
        return true;
    }
    
    if ( isdefined( self.perks[ "specialty_gas_immunity" ] ) )
    {
        return true;
    }
    
    data.victim thread gas_applycough( data.attacker, 1 );
    return true;
}

// Namespace gas_grenade
// Params 1
// Checksum 0x332fd2c, Offset: 0xb98
// Size: 0x1c7
function gas_clear( fromdeath )
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    
    if ( bundle.var_9a68372899d8bbbd ?? 1 )
    {
        gas_clearspeedredux( fromdeath );
    }
    
    gas_clearblur( fromdeath );
    gas_clearcough( fromdeath );
    
    if ( isdefined( level.var_548004405d16dcf8 ) && isdefined( self ) )
    {
        self [[ level.var_7518fcc73a6d4676 ]]( "gas_grenade" );
    }
    
    player::codcastersetplayerstatuseffect( "gas", 0 );
    white_phosphorus::disableloopingcoughaudio();
    
    if ( self.var_fbd9557189406237 && self getscriptablehaspart( #"cradle_gas" ) && self getscriptablepartstate( #"cradle_gas", 1, 1 ) != #"exit_gas" )
    {
        self setscriptablepartstate( #"cradle_gas", #"exit_gas" );
    }
    
    self.var_fbd9557189406237 = undefined;
    self notify( #"gas_exited" );
    
    if ( self && ( bundle.var_9a68372899d8bbbd ?? 1 ) )
    {
        if ( function_7a528b347ace56de() )
        {
            val::reset( "gas_grenade_supersprint", "supersprint" );
        }
    }
    
    if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( !isdefined( trigger ) )
            {
                continue;
            }
            
            trigger.playersintrigger[ self getentitynumber() ] = undefined;
        }
    }
    
    self.gastriggerstouching = undefined;
}

// Namespace gas_grenade
// Params 12
// Checksum 0x380a3a54, Offset: 0xd67
// Size: 0x4ba
function gas_createtrigger( position, owner, team, duration, scale, iscrossbow = 0, crossbowlevel = 0, radius, height = 225, offset = -74.25, grenade_weapon_name, triggerinfo )
{
    if ( !isdefined( position ) )
    {
        return;
    }
    
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    
    if ( !isdefined( duration ) )
    {
        duration = bundle.gas_grenade_lifetime ?? 6.5;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = bundle.gas_grenade_radius ?? 256;
    }
    
    if ( bundle.var_c7709714d768097c && owner equipment_mp::function_e6b75548c2c3c6cf( "equip_gas_grenade", bundle.var_c7709714d768097c ) )
    {
        duration *= bundle.var_4906a0f655f194f1 ?? 1.1;
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    radius = int( radius * scale );
    height = int( height * scale );
    offset = int( offset * scale );
    triggerorigin = position + ( 0, 0, offset );
    trigger = spawn( "trigger_radius", triggerorigin, 0, radius, height );
    trigger ent_manager::registerspawn( 1, &sweepgas );
    
    if ( !isdefined( level.var_3d90777bfb7fc504 ) )
    {
        badplace = createnavbadplacebybounds( triggerorigin, ( radius, radius, height ), ( 0, 0, 0 ) );
        trigger.badplace = badplace;
    }
    
    trigger.var_ba0e4b835e09578 = position;
    trigger.height = height;
    trigger.radius = radius;
    trigger.duration = duration;
    trigger.creationtime = gettime();
    trigger.eventid = self.eventid;
    trigger endon( #"death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.iscrossbow = iscrossbow;
    trigger.crossbowlevel = crossbowlevel;
    trigger.playersintrigger = [];
    trigger.var_a8d0289a93e5a155 = [];
    trigger.scoreeventfired = [];
    trigger.grenade_weapon_name = grenade_weapon_name;
    trigger.weaponobj = triggerinfo.weaponobj;
    trigger.var_4a204f123199db39 = bundle.var_8fbc6cd387dc389;
    
    if ( bundle.var_4e416eaec1522362 )
    {
        trigger.var_e4bcca7ae7bbff3a = bundle.var_4e416eaec1522362 * 1000;
    }
    
    if ( owner )
    {
        if ( !isdefined( owner.gas_grenade_array ) )
        {
            owner.gas_grenade_array = [];
        }
        
        owner.gas_grenade_array[ owner.gas_grenade_array.size ] = trigger;
    }
    
    if ( isdefined( level.equipment.table[ "equip_gas_grenade" ] ) )
    {
        trigger.weapon = level.equipment.table[ "equip_gas_grenade" ].weaponname;
    }
    
    if ( function_7ae095a698691834() )
    {
        trigger thread br::function_ce601d6f64265108( position );
    }
    
    trigger thread gas_watchtriggerenter( bundle );
    trigger thread gas_watchtriggerexit();
    
    if ( bundle.var_e36b84555e7df1d3 && owner equipment_mp::function_e6b75548c2c3c6cf( "equip_gas_grenade", bundle.var_e36b84555e7df1d3 ) )
    {
        trigger thread function_cf2564bde6b65120( bundle );
    }
    
    /#
        draw_version = getdvarint( @"hash_94521eb2fc22ae59", 0 );
        
        switch ( draw_version )
        {
            case 1:
                drawentitybounds( trigger, ( 1, 0, 0 ), 0, int( duration / level.framedurationseconds ) );
                break;
            case 2:
                cylinder( trigger.origin, trigger.origin + ( 0, 0, height ), radius, ( 1, 0, 0 ), 0, int( duration / level.framedurationseconds ) );
                break;
        }
    #/
    
    trigger thread gas_destroytriggerdelayed( duration, "gas_cleared" );
    
    if ( !isdefined( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = [];
    }
    
    level.var_9f723c1b2e8c3484[ level.var_9f723c1b2e8c3484.size ] = trigger;
}

// Namespace gas_grenade
// Params 0
// Checksum 0xd402105a, Offset: 0x1229
// Size: 0x19, Type: bool
function function_7ae095a698691834()
{
    return isbrgamemode() && getdvarint( @"scr_gas_grenade_gas_mask_protection", 1 );
}

// Namespace gas_grenade
// Params 0
// Checksum 0x9d48357b, Offset: 0x124b
// Size: 0x18, Type: bool
function function_e83dcafd317914fb()
{
    return isbrgamemode() && getdvarint( @"hash_93c3a50d09e1989b", 0 );
}

// Namespace gas_grenade
// Params 0
// Checksum 0xf9077f08, Offset: 0x126c
// Size: 0x9
function sweepgas()
{
    thread gas_destroytrigger();
}

// Namespace gas_grenade
// Params 0
// Checksum 0xa44f8ef1, Offset: 0x127d
// Size: 0x2eb
function gas_destroytrigger()
{
    if ( isdefined( self ) && self.owner && self.eventid )
    {
        thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #attacker:self.owner, #eventid:self.eventid } );
    }
    
    if ( isdefined( self ) )
    {
        foreach ( player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player thread gas_onexittrigger( self );
            
            if ( player function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
            {
                player setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 0 );
            }
        }
        
        foreach ( agent in self.var_a8d0289a93e5a155 )
        {
            if ( agent )
            {
                agent.var_daa128602a7fab36 = 0;
                agent.var_a60c1db83eacc9d5 = undefined;
            }
        }
        
        if ( self.var_906d028196e17aa4 )
        {
            self.owner.gas_grenade_trigger = undefined;
            self.var_906d028196e17aa4 = undefined;
            self.owner utility::callsharedfunc( #"zombie_utils", #"removedamagecallback", &on_ai_damage_brainrot );
            self.owner agent_utils::function_def5273cfe3c9109( &on_ai_damage_brainrot );
        }
        
        if ( self.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_95fcd19aa80083b2" ) )
        {
            self.var_f11a0565ec4721fc = undefined;
        }
        
        self.var_b45ec83004b91323 = undefined;
    }
    
    ent_manager::deregisterspawn();
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
    }
    
    if ( isdefined( self ) )
    {
        if ( self.owner && self.owner.gas_grenade_array )
        {
            self.owner.gas_grenade_array = arrayremove( self.owner.gas_grenade_array, self );
        }
        
        self delete();
    }
    
    if ( isarray( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = function_5713d46873b29625( level.var_9f723c1b2e8c3484 );
    }
}

// Namespace gas_grenade
// Params 2
// Checksum 0x25d1d6ea, Offset: 0x1570
// Size: 0x5d
function gas_destroytriggerdelayed( delaytime, var_7bf155b448f3de04 )
{
    self endon( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner utility::waittill_notify_or_timeout( "disconnect", delaytime );
    }
    else
    {
        wait delaytime;
    }
    
    if ( isdefined( var_7bf155b448f3de04 ) )
    {
        self notify( var_7bf155b448f3de04 );
    }
    
    thread gas_destroytrigger();
}

// Namespace gas_grenade
// Params 1
// Checksum 0xc84a8632, Offset: 0x15d5
// Size: 0x41c
function gas_onentertrigger( trigger )
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    entnum = trigger getentitynumber();
    self.gastriggerstouching[ entnum ] = trigger;
    self.lastgastouchtime = gettime();
    self notify( #"hash_9292d26860c37712" );
    
    if ( trigger.weaponobj )
    {
        telemetry_mp::function_594cbdc6a4d8098a( self, trigger.owner, trigger.weaponobj, entnum );
    }
    
    thread function_5f57379dc2327524( trigger.owner, trigger );
    
    if ( getdvarint( @"hash_9ae216012f64affd" ) && isdefined( trigger.owner.chemist ) )
    {
        if ( utility::issharedfuncdefined( #"warlord_chemist", #"periodicdamage" ) )
        {
            thread utility::callsharedfunc( #"warlord_chemist", #"periodicdamage", trigger.owner.chemist.gasdamage, trigger.owner.chemist.var_2c66d0398d75957f, trigger.owner );
        }
        
        if ( isdefined( self.gasmaskhealth ) )
        {
            if ( self.gasmaskhealth > 0 )
            {
                if ( isdefined( level.var_548004405d16dcf8 ) )
                {
                    self [[ level.var_548004405d16dcf8 ]]( "gas_grenade" );
                }
                
                return entnum;
            }
        }
        
        if ( utility::issharedfuncdefined( #"warlord_chemist", #"gasmask_watcher" ) && !self.gasmaskequipped )
        {
            thread utility::callsharedfunc( #"warlord_chemist", #"gasmask_watcher" );
        }
    }
    
    if ( function_7ae095a698691834() && isdefined( self.gasmaskhealth ) && self.gasmaskhealth > 0 )
    {
        thread function_d71594ef42208c09( trigger );
        return entnum;
    }
    
    if ( function_e83dcafd317914fb() )
    {
        thread function_1505269c0f0de5aa( trigger );
    }
    
    if ( self.gastriggerstouching.size >= 1 )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
        
        if ( bundle.var_9a68372899d8bbbd ?? 1 )
        {
            thread gas_applyspeedredux();
        }
        
        thread gas_applyblur();
        
        if ( bundle.var_1aadfb29005ffaa4 )
        {
            thread function_f45f8371a30fea6b( trigger.owner );
        }
    }
    
    if ( self.gastriggerstouching.size == 1 )
    {
        if ( function_7a528b347ace56de() )
        {
            thread gas_startcoughing( trigger.owner );
        }
        else
        {
            thread gas_applycough( trigger.owner, 0 );
        }
    }
    
    if ( !isdefined( self.loopingcoughaudio ) )
    {
        white_phosphorus::enableloopingcoughaudio( trigger.owner );
    }
    
    if ( !trigger.scoreeventfired[ self.entnum ?? utility::get_entity_number( self ) ] && self.team != trigger.owner.team )
    {
        trigger.scoreeventfired[ self.entnum ] = 1;
        trigger.owner namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "gasGrenadeHit", 0, { #objweapon:trigger.weaponobj } );
    }
    
    player::codcastersetplayerstatuseffect( "gas", -1 );
    
    if ( getdvarint( @"hash_9ae216012f64affd" ) && !self.var_14914c04d961f6ca && utility::issharedfuncdefined( #"warlord_chemist", #"hash_32b9b34a4ceaf5bb" ) )
    {
        self.var_14914c04d961f6ca = 1;
        thread utility::callsharedfunc( #"warlord_chemist", #"hash_32b9b34a4ceaf5bb" );
    }
    
    if ( self getscriptablehaspart( #"cradle_gas" ) && self getscriptablepartstate( #"cradle_gas", 1, 1 ) != #"enter_gas" )
    {
        self.var_fbd9557189406237 = 1;
        self setscriptablepartstate( #"cradle_gas", #"enter_gas" );
    }
    
    return entnum;
}

// Namespace gas_grenade
// Params 2
// Checksum 0x97bbfbf2, Offset: 0x19fa
// Size: 0x53
function function_5f57379dc2327524( owner, trigger )
{
    utility::waittill_any( "death_or_disconnect", "last_stand_enter", "start_hallucination_immunity" );
    fromdeath = !player::isreallyalive( self );
    function_6f02931058892606( owner, trigger, fromdeath );
    gas_clear( fromdeath );
}

// Namespace gas_grenade
// Params 3
// Checksum 0x312bec30, Offset: 0x1a55
// Size: 0x162
function function_6f02931058892606( owner, trigger, fromdeath )
{
    if ( fromdeath )
    {
        var_95b0d6118738c579 = trigger.weaponobj;
        waitframe();
        
        if ( !( isdefined( self ) && isdefined( self.gastriggerstouching ) && isdefined( self.gastriggerstouching ) ) || self.gastriggerstouching.size < 1 )
        {
            return;
        }
        else if ( isdefined( self.attackers ) )
        {
            var_8f12d39b82e09e5d = self.attackers;
            
            if ( var_8f12d39b82e09e5d.size > 1 )
            {
                var_8f12d39b82e09e5d = arrayremove( var_8f12d39b82e09e5d, owner );
            }
            
            foreach ( attacker in var_8f12d39b82e09e5d )
            {
                if ( isdefined( attacker ) )
                {
                    function_e829dd56611dd0b4( attacker, owner, var_95b0d6118738c579 );
                }
            }
        }
        
        return;
    }
    
    fromdown = player::isinlaststand( self );
    
    if ( fromdown )
    {
        if ( !( isdefined( self ) && isdefined( self.gastriggerstouching ) ) || self.gastriggerstouching.size < 1 )
        {
            return;
        }
        
        thread waitforfinish( owner, trigger );
    }
}

// Namespace gas_grenade
// Params 2
// Checksum 0xe3485bee, Offset: 0x1bbf
// Size: 0xde
function waitforfinish( owner, trigger )
{
    self endon( #"disconnect" );
    self endon( #"laststand_revived" );
    var_ce1219a4fd42d4ec = trigger.weaponobj;
    self waittill( #"death" );
    waitframe();
    
    if ( isdefined( self.attackers ) )
    {
        foreach ( attacker in self.attackers )
        {
            if ( isdefined( attacker ) )
            {
                function_e829dd56611dd0b4( attacker, owner, var_ce1219a4fd42d4ec );
            }
        }
    }
}

// Namespace gas_grenade
// Params 3
// Checksum 0xfd69aaf5, Offset: 0x1ca5
// Size: 0xd7
function function_e829dd56611dd0b4( attacker, owner, var_ce1219a4fd42d4ec )
{
    victim = self;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( !isdefined( damage::_validateattacker( attacker ) ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_5d7ed9f2a7fdd8cb ) )
    {
        attacker.var_5d7ed9f2a7fdd8cb = victim;
    }
    
    if ( attacker.var_5d7ed9f2a7fdd8cb != victim )
    {
        attacker thread points::doscoreevent( #"gas_trap_double" );
        attacker.var_5d7ed9f2a7fdd8cb = undefined;
    }
    else
    {
        attacker thread function_44bfa879113d89f6();
    }
    
    if ( attacker == owner )
    {
        owner thread points::doscoreevent( #"gas_finished", var_ce1219a4fd42d4ec );
        return;
    }
    
    owner thread points::doscoreevent( #"hash_867f6f6254ec9309", var_ce1219a4fd42d4ec );
}

// Namespace gas_grenade
// Params 0, eflags: 0xc
// Checksum 0xf88ce705, Offset: 0x1d84
// Size: 0x33
function private function_44bfa879113d89f6()
{
    self notify( #"hash_9657fd148f23285d" );
    self endon( #"hash_9657fd148f23285d" );
    self endon( #"death_or_disconnect" );
    wait 2;
    self.var_5d7ed9f2a7fdd8cb = undefined;
}

// Namespace gas_grenade
// Params 2
// Checksum 0xdfce5494, Offset: 0x1dbf
// Size: 0x638
function gas_onentertriggerai( trigger, bundledata )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    can_affect = 1;
    
    if ( isplayer( trigger.owner ) && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( trigger.owner, self );
    }
    
    if ( !can_affect )
    {
        return;
    }
    
    agenttier = ai_utility::get_power_tier();
    var_b1e090996828dbd9 = bundledata.var_725116ad251753ba ?? 0;
    var_b0454d018092840 = trigger.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_3999244ea26d60b1" );
    var_6559bcb974ad8e84 = var_b0454d018092840 ? var_b1e090996828dbd9 + 1 : var_b1e090996828dbd9;
    
    if ( bundledata.var_3ea7f749cdd49370 && !isdefined( self.var_fb2e0070ae6f04e4 ) && ( !var_b1e090996828dbd9 || agenttier <= var_6559bcb974ad8e84 ) )
    {
        if ( bundledata.var_d5d0e03168cccb0a && self.var_daa128602a7fab36 )
        {
            return;
        }
        
        if ( function_58dce3a196ac4d8b( bundledata, self.aicategory ) )
        {
            return;
        }
        
        self.var_daa128602a7fab36 = 1;
        
        if ( !self.aisettings.var_abb7ad1e6db7fa37 )
        {
            return;
        }
        
        var_1baa53f2742ba4d3 = agenttier == var_b1e090996828dbd9 + 1;
        
        if ( var_1baa53f2742ba4d3 )
        {
            var_f437d74b541eb787 = trigger.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_95fcd19aa80083b2" );
            
            if ( trigger.var_f11a0565ec4721fc >= var_f437d74b541eb787 )
            {
                return;
            }
        }
        
        probability = var_1baa53f2742ba4d3 ? var_b0454d018092840 : trigger.var_b45ec83004b91323;
        var_564e18baf30a92cc = trigger.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7" );
        var_5760450bf6ef13e0 = trigger.var_7d4b90c36d11819a < var_564e18baf30a92cc;
        
        if ( !isdefined( self.var_a60c1db83eacc9d5 ) )
        {
            if ( !var_5760450bf6ef13e0 && randomfloat( 1 ) > probability )
            {
                return;
            }
            
            if ( !var_5760450bf6ef13e0 && trigger.owner.var_c102323125f3aa38 )
            {
                trigger.var_b45ec83004b91323 = max( trigger.owner.var_310e9c36300a34b6, trigger.var_b45ec83004b91323 - trigger.owner.var_c102323125f3aa38 );
            }
        }
        else if ( !self.var_a60c1db83eacc9d5 )
        {
            return;
        }
        
        if ( bundledata.var_b31ef781986c2f56 && !function_aad3f9ba4ac6be30( trigger ) )
        {
            return;
        }
        
        var_ecd432e37d3770ce = trigger.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_8c6386b772caad1d" ) ?? bundledata.var_b6533dc2c75d64b8;
        
        if ( !var_ecd432e37d3770ce || trigger.var_7d4b90c36d11819a < var_ecd432e37d3770ce )
        {
            trigger.var_7d4b90c36d11819a++;
            
            if ( var_1baa53f2742ba4d3 )
            {
                trigger.var_f11a0565ec4721fc++;
            }
            
            brainrotdata = spawnstruct();
            brainrotdata.trigger = trigger;
            brainrotdata.brainrotduration = trigger.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_6ab81a5a8df063b1" ) ?? bundledata.var_b56042d67ad05c53;
            brainrotdata.var_2570f353fae877d0 = bundledata.var_ddf57c1945e91df9;
            brainrotdata.brainrot_base_damage_percent = bundledata.var_fe2fd15b0c7638c0;
            brainrotdata.var_5076313ebb1f3fbf = bundledata.var_5555fecf00912ec8;
            brainrotdata.brainrot_end_damage_percent = bundledata.var_30aafdb408ad56c6;
            brainrotdata.owner = trigger.owner;
            brainrotdata.ignored = bundledata.var_ef1916648342851c;
            brainrotdata.weapon = bundledata.useweapon;
            brainrotdata.kill_enemy = bundledata.var_9cb95ccabe1ea6b9;
            self.var_fb2e0070ae6f04e4 = trigger.owner;
            self.var_e797f68de73ece4e = "_gas_grenade";
            self.gas_grenade_time = trigger.creationtime;
            utility::callsharedfunc( #"challenges", #"hash_8ec698d92f03a49a", "equip_gas_grenade", trigger.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ), undefined, undefined, undefined, self );
            utility::delaythreadendon( brainrotdata.brainrotduration + 1, "death", &function_3184eae4516d79c );
            
            if ( bundledata.var_fc765712be32f9c2 )
            {
                if ( utility::callsharedfunc( #"brainrot", #"hash_a8325ae4a081c092" ) && self.aicategory != "hvt" && self.aicategory != "boss" )
                {
                    self thread [[ utility::getsharedfunc( #"gas_hallucination", #"hash_8d11dd86e8c44217" ) ]]( brainrotdata );
                }
                else
                {
                    return;
                }
            }
            
            var_d2f64acfaec981b7 = trigger.owner.var_f6ce3f6c3c2ead86.bundle.var_c85f8a289117843d ?? bundledata.var_fa03f499c082fd09;
            
            if ( var_d2f64acfaec981b7 )
            {
                set_ai_difficulty( var_d2f64acfaec981b7 );
            }
            
            if ( trigger.owner.gas_grenade_trigger.var_906d028196e17aa4 )
            {
                trigger.owner.gas_grenade_trigger.var_906d028196e17aa4 = arraycombineunique( trigger.owner.gas_grenade_trigger.var_906d028196e17aa4, [ self ] );
            }
            
            self thread [[ utility::getsharedfunc( #"gas_hallucination", #"hash_8d11dd86e8c44217" ) ]]( brainrotdata );
        }
    }
}

// Namespace gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x24d7fa17, Offset: 0x23ff
// Size: 0x65
function private set_ai_difficulty( roundnumber )
{
    if ( utility::issharedfuncdefined( #"region_difficulty_manager", #"hash_92c9697fbfaef62e" ) )
    {
        self.difficulty = utility::callsharedfunc( #"region_difficulty_manager", #"hash_92c9697fbfaef62e", roundnumber );
    }
    
    utility::callsharedfunc( #"zombie_utils", #"set_zombie_round_difficulty", roundnumber );
}

// Namespace gas_grenade
// Params 0, eflags: 0x4
// Checksum 0x35fe3c2e, Offset: 0x246c
// Size: 0x25
function private function_3184eae4516d79c()
{
    waitframe();
    
    if ( self )
    {
        self.var_fb2e0070ae6f04e4 = undefined;
        self.var_e797f68de73ece4e = undefined;
        self.gas_grenade_time = undefined;
    }
}

// Namespace gas_grenade
// Params 0
// Checksum 0x2015ff26, Offset: 0x2499
// Size: 0x5c
function function_dcb13d23fa969d90()
{
    var_e5e3f7fdc72e8f26 = level.equipment.table[ "equip_gas_grenade" ].bundle.var_b45d254cca07a4d3;
    
    if ( !var_e5e3f7fdc72e8f26 )
    {
        return;
    }
    
    shellshock_utility_cpmp::_shellshock( var_e5e3f7fdc72e8f26, #"stun", 0.75, 0, 100 );
}

// Namespace gas_grenade
// Params 1
// Checksum 0x4b36348f, Offset: 0x24fd
// Size: 0x91
function gas_onexittrigger( trigger )
{
    triggerid = trigger getentitynumber();
    assert( isdefined( triggerid ), "<dev string:x5b>" );
    
    if ( !isdefined( self.gastriggerstouching ) )
    {
        return;
    }
    
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    
    if ( trigger.weaponobj )
    {
        telemetry_mp::function_edb43d25c7bd56c6( self, trigger.weaponobj, triggerid );
    }
    
    if ( self.gastriggerstouching.size == 0 )
    {
        thread function_a72b7cc6cf273c45( trigger );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xd7b6470d, Offset: 0x2596
// Size: 0x1a5
function function_a72b7cc6cf273c45( trigger )
{
    self endon( #"hash_9292d26860c37712" );
    var_ac255db0656a7936 = trigger.owner.entnum ?? utility::get_entity_number( trigger.owner );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    var_88c8920200789866 = max( bundle.gas_hallucination_settings.var_47a7035712dd1d84 ?? 0, self.hallucinationtimer ?? 0 );
    
    if ( self.hallucinationtimer )
    {
        self.hallucinationtimer = var_88c8920200789866;
    }
    
    wait var_88c8920200789866;
    
    while ( self.hallucinationtimer && self.hallucinationtimer > 0 && !self.var_193dad851d6389a4 )
    {
        wait 0.1;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( level.var_548004405d16dcf8 ) )
    {
        self [[ level.var_7518fcc73a6d4676 ]]( "gas_grenade" );
    }
    
    player::codcastersetplayerstatuseffect( "gas", 0 );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    
    if ( bundle.var_9a68372899d8bbbd ?? 1 )
    {
        thread gas_removespeedredux();
    }
    
    thread gas_removeblur( var_ac255db0656a7936 );
    white_phosphorus::disableloopingcoughaudio();
    
    if ( self getscriptablehaspart( #"cradle_gas" ) && self getscriptablepartstate( #"cradle_gas", 1, 1 ) != #"exit_gas" )
    {
        self setscriptablepartstate( #"cradle_gas", #"exit_gas" );
    }
    
    self notify( #"gas_exited" );
}

// Namespace gas_grenade
// Params 0, eflags: 0x4
// Checksum 0xc5cb9416, Offset: 0x2743
// Size: 0x44, Type: bool
function private function_22bb6fe5edb928()
{
    if ( !utility::issharedfuncdefined( #"ai", #"hash_28d452ebde67664b" ) )
    {
        return false;
    }
    
    if ( self.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_15540c4bc4150e68" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_grenade
// Params 1
// Checksum 0xfa522cda, Offset: 0x2790
// Size: 0x40d
function gas_watchtriggerenter( bundle )
{
    self endon( #"death" );
    self.var_7d4b90c36d11819a = 0;
    assert( !self.owner.var_310e9c36300a34b6 || self.owner.var_310e9c36300a34b6 < bundle.var_fa85b03a3c33b612, "<dev string:x90>" );
    self.var_b45ec83004b91323 = bundle.var_fa85b03a3c33b612;
    
    if ( self.owner utility::callsharedfunc( "equip_gas_grenade", #"hash_95fcd19aa80083b2" ) )
    {
        self.var_f11a0565ec4721fc = 0;
    }
    
    if ( bundle.var_3ea7f749cdd49370 && bundle.var_e137c81f1b0f19eb && function_22bb6fe5edb928() )
    {
        self.owner.gas_grenade_trigger = self;
        self.var_906d028196e17aa4 = [];
        self.owner utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &on_ai_damage_brainrot );
        self.owner agent_utils::function_bc89b9076dd93902( &on_ai_damage_brainrot );
    }
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            if ( isagent( player ) )
            {
                if ( isdefined( self.owner ) && player utility::function_92f6c5dd7f8b6166( "tear_gas", self.owner.team ) )
                {
                    continue;
                }
                
                if ( !arraycontains( self.var_a8d0289a93e5a155, player ) || player.flashendtime < gettime() )
                {
                    self.var_a8d0289a93e5a155[ self.var_a8d0289a93e5a155.size ] = player;
                    
                    if ( player.radimmune )
                    {
                        continue;
                    }
                    
                    player notify( #"flashbang", player.origin, 1, 1, self.owner, "axis", 9 );
                }
                
                if ( function_22bb6fe5edb928() )
                {
                    player thread [[ utility::getsharedfunc( #"ai", #"hash_28d452ebde67664b" ) ]]( self, bundle );
                    
                    if ( player.var_a60c1db83eacc9d5 )
                    {
                        player.nodamagenumbers = undefined;
                    }
                }
                
                player thread gas_onentertriggerai( self, bundle );
            }
            
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_tac_mask" ] ) && isdefined( player.perks[ "specialty_gas_immunity" ] ) )
        {
            if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
            {
                player perks::function_142df1226093bce0( "specialty_tac_mask" );
            }
            else
            {
                player perks::activateperk( "specialty_tac_mask" );
            }
            
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_gas_immunity" ] ) )
        {
            continue;
        }
        
        if ( player.var_193dad851d6389a4 )
        {
            continue;
        }
        
        if ( player killstreak::isjuggernaut() && !game_utility_mp::isjuggermoshgamemode() )
        {
            continue;
        }
        
        if ( function_8de1f4bd0dc11222( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( isdefined( self.playersintrigger[ player getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( player.var_e6815fe05e87b11a )
        {
            continue;
        }
        
        if ( bundle.gas_hallucination_settings.var_fffe60466a6a319b )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( isalive( self.owner ) )
            {
                if ( player != self.owner && !player_utility::playersareenemies( player, self.owner ) )
                {
                    continue;
                }
            }
            else if ( player_utility::isfriendly( self.team, player ) )
            {
                continue;
            }
        }
        
        self.playersintrigger[ player getentitynumber() ] = player;
        
        if ( player function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
        {
            player setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 1 );
        }
        
        player thread gas_onentertrigger( self );
    }
}

// Namespace gas_grenade
// Params 1, eflags: 0x4
// Checksum 0x69a0b39, Offset: 0x2ba5
// Size: 0x38f
function private on_ai_damage_brainrot( params )
{
    bundledata = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( bundledata.useweapon != params.objweapon.basename )
    {
        return params.idamage;
    }
    
    agenttier = ai_utility::get_power_tier();
    var_b1e090996828dbd9 = bundledata.var_725116ad251753ba ?? 0;
    var_ecd432e37d3770ce = params.eattacker utility::callsharedfunc( "equip_gas_grenade", #"hash_8c6386b772caad1d" ) ?? bundledata.var_b6533dc2c75d64b8;
    
    if ( params.eattacker.gas_grenade_trigger.var_906d028196e17aa4.size >= var_ecd432e37d3770ce )
    {
        return params.idamage;
    }
    
    if ( function_58dce3a196ac4d8b( bundledata, self.aicategory ) )
    {
        return params.idamage;
    }
    
    if ( !self.aisettings.var_abb7ad1e6db7fa37 )
    {
        return params.idamage;
    }
    
    var_1baa53f2742ba4d3 = agenttier == var_b1e090996828dbd9 + 1;
    
    if ( agenttier > var_b1e090996828dbd9 )
    {
        var_b0454d018092840 = params.eattacker utility::callsharedfunc( "equip_gas_grenade", #"hash_3999244ea26d60b1" );
        var_f437d74b541eb787 = params.eattacker utility::callsharedfunc( "equip_gas_grenade", #"hash_95fcd19aa80083b2" );
        var_50c2ae46b5f31b09 = var_1baa53f2742ba4d3 && var_b0454d018092840 && params.eattacker.gas_grenade_trigger.var_f11a0565ec4721fc < var_f437d74b541eb787;
        
        if ( !var_50c2ae46b5f31b09 )
        {
            return params.idamage;
        }
    }
    
    if ( arraycontains( params.eattacker.gas_grenade_trigger.var_906d028196e17aa4, self ) )
    {
        return 1;
    }
    
    var_564e18baf30a92cc = params.eattacker utility::callsharedfunc( "equip_gas_grenade", #"hash_fd15fd23829c9df7" );
    var_5760450bf6ef13e0 = params.eattacker.gas_grenade_trigger.var_906d028196e17aa4.size < var_564e18baf30a92cc;
    brainrotprobability = var_50c2ae46b5f31b09 ? var_b0454d018092840 : params.eattacker.gas_grenade_trigger.var_b45ec83004b91323;
    damage_modified = params.idamage;
    
    if ( !isdefined( self.var_a60c1db83eacc9d5 ) )
    {
        self.var_a60c1db83eacc9d5 = 0;
        
        if ( var_5760450bf6ef13e0 || randomfloat( 1 ) < brainrotprobability )
        {
            self.nodamagenumbers = 1;
            damage_modified = 1;
            self.var_a60c1db83eacc9d5 = 1;
            
            if ( !var_5760450bf6ef13e0 && params.eattacker.var_c102323125f3aa38 )
            {
                params.eattacker.gas_grenade_trigger.var_b45ec83004b91323 = max( params.eattacker.var_310e9c36300a34b6, params.eattacker.gas_grenade_trigger.var_b45ec83004b91323 - params.eattacker.var_c102323125f3aa38 );
            }
        }
    }
    
    return damage_modified;
}

// Namespace gas_grenade
// Params 1
// Checksum 0xcf7cd02a, Offset: 0x2f3d
// Size: 0x1f4
function function_cf2564bde6b65120( bundle )
{
    self notify( #"hash_678190af740298f8" );
    self endon( #"hash_678190af740298f8" );
    level endon( #"game_ended" );
    self endon( #"death" );
    gasdamage = bundle.var_e931c9889fca5ac ?? 20;
    var_8330395bbba18546 = bundle.var_ae08ef4f76b22db0 ?? 5;
    var_c0db39d69d09fc9f = bundle.var_ef1e7fa7d1b1e5c5 ?? 1;
    spawnprotectionduration = ( bundle.var_c04026595d9808c4 ?? 5 ) * 1000;
    
    while ( true )
    {
        currenttime = gettime();
        
        foreach ( player in self.playersintrigger )
        {
            if ( !( isdefined( player ) && isdefined( player.origin ) ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( currenttime - player.lastspawntime < spawnprotectionduration )
            {
                continue;
            }
            
            if ( !isdefined( player.perks[ "specialty_gas_immunity" ] ) )
            {
                if ( isdefined( player.perks[ "specialty_gas_grenade_resist" ] ) )
                {
                    player dodamage( var_8330395bbba18546, player.origin, self.owner, self, "MOD_GRENADE", self.weapon );
                    continue;
                }
                
                player dodamage( gasdamage, player.origin, self.owner, self, "MOD_GRENADE", self.weapon );
            }
        }
        
        wait var_c0db39d69d09fc9f;
    }
}

// Namespace gas_grenade
// Params 0
// Checksum 0xbaa5560, Offset: 0x3139
// Size: 0x10b
function gas_watchtriggerexit()
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( id, player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( player istouching( self ) && !function_8de1f4bd0dc11222( player ) && !player.var_193dad851d6389a4 )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            
            if ( player function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
            {
                player setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 0 );
            }
            
            player thread gas_onexittrigger( self );
        }
        
        waitframe();
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xf7a5eb9e, Offset: 0x324c
// Size: 0x103
function function_d71594ef42208c09( trigger )
{
    self notify( #"hash_2fd822af062f9738" );
    self endon( #"hash_2fd822af062f9738" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self.gastriggerstouching ) || self.gastriggerstouching.size == 0 )
        {
            return;
        }
        
        if ( !isdefined( self.gasmaskhealth ) || self.gasmaskhealth <= 0 )
        {
            break;
        }
    }
    
    foreach ( trigger in self.gastriggerstouching )
    {
        trigger.playersintrigger[ self getentitynumber() ] = undefined;
        self.gastriggerstouching[ trigger getentitynumber() ] = undefined;
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xeaa8014f, Offset: 0x3357
// Size: 0x19, Type: bool
function function_8de1f4bd0dc11222( player )
{
    if ( player function_65267a768ced48a0() )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_grenade
// Params 2
// Checksum 0x4174bd48, Offset: 0x3379
// Size: 0xa8
function gas_applycough( attacker, fromimpact )
{
    var_f51647acde95eb6d = isdefined( self.perks[ "specialty_gas_grenade_resist" ] );
    var_b660048a0793257a = self == attacker;
    
    if ( !var_b660048a0793257a && var_f51647acde95eb6d || self getinairpocket() )
    {
        return;
    }
    
    isheavy = 0;
    
    if ( fromimpact )
    {
        isheavy = 1;
        
        if ( var_b660048a0793257a )
        {
            isheavy = 0;
            
            /#
                if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                {
                    isheavy = 1;
                }
            #/
        }
    }
    
    if ( !self.gascoughinprogress || fromimpact )
    {
        thread gas_queuecough( isheavy );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x41bb7830, Offset: 0x3429
// Size: 0x197
function gas_queuecough( isheavy )
{
    self endon( #"death_or_disconnect" );
    self endon( #"gas_clear_cough" );
    self endon( #"gas_exited" );
    self notify( #"gas_queue_cough" );
    self endon( #"gas_queue_cough" );
    var_458c575e2b8c77cf = gettime() + 1000;
    
    while ( gas_coughisblocked() )
    {
        waitframe();
    }
    
    if ( isheavy && gettime() > var_458c575e2b8c77cf )
    {
        isheavy = 0;
    }
    
    var_6b728440205d689a = getdvarint( @"hash_827901421ad0679", 1 ) == 1;
    
    if ( utility::issharedfuncdefined( #"br_circle", #"hash_e2f87d36729a4f5a" ) && getdvarint( @"hash_ae9ab8441d241bbc", 1 ) )
    {
        thread utility::callsharedfunc( #"br_circle", #"hash_e2f87d36729a4f5a" );
    }
    
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    
    if ( bundle.var_bb4a62b2df5cfeee )
    {
        return;
    }
    
    if ( var_6b728440205d689a )
    {
        thread gas_begincoughing( isheavy );
        return;
    }
    
    if ( function_7a528b347ace56de() )
    {
        thread function_a64bbeae7f0f4957( isheavy );
        return;
    }
    
    self endon( #"gas_begin_coughing" );
    currweapon = self getcurrentweapon();
    
    if ( currweapon.basename != "none" )
    {
        self.gascoughinprogress = 1;
        
        if ( isheavy )
        {
            self playgestureviewmodel( "iw9_ges_gas_cough_long" );
            wait 3.33;
        }
        else
        {
            self playgestureviewmodel( "iw9_ges_gas_cough" );
            wait 1.833;
        }
        
        self.gascoughinprogress = undefined;
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x5d01e54f, Offset: 0x35c8
// Size: 0xf7
function function_a64bbeae7f0f4957( isheavy )
{
    self notify( #"hash_df27ba7edf85d012" );
    self endon( #"hash_df27ba7edf85d012" );
    self endon( #"death_or_disconnect" );
    gesture = isheavy ? "iw9_ges_gas_cough_long" : "iw9_ges_gas_cough";
    duration = isheavy ? 3.33 : 1.833;
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    effectsmovement = bundle.var_9a68372899d8bbbd ?? 1;
    
    if ( effectsmovement )
    {
        val::set( "gas_grenade_supersprint", "supersprint", 0 );
    }
    
    currweapon = self getcurrentweapon();
    
    if ( currweapon.basename != "none" )
    {
        self playgestureviewmodel( gesture, undefined, 1 );
    }
    
    wait duration;
    
    if ( effectsmovement )
    {
        val::reset( "gas_grenade_supersprint", "supersprint" );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xc67f3fe, Offset: 0x36c7
// Size: 0x1a0
function gas_begincoughing( isheavy )
{
    self endon( #"death_or_disconnect" );
    self endon( #"gas_clear_cough" );
    self notify( #"gas_begin_coughing" );
    self endon( #"gas_begin_coughing" );
    
    if ( !isnullweapon( self getheldoffhand() ) )
    {
        childthread gas_takeheldoffhand();
    }
    
    self.gascoughinprogress = 1;
    var_af26ed837ee66f07 = scripted_weapons::get_scripted_weapon_object( #"gas_cough_light" );
    var_4e22443d07a9c648 = scripted_weapons::get_scripted_weapon_object( #"gas_cough_heavy" );
    
    if ( self hasweapon( var_af26ed837ee66f07 ) )
    {
        inventory_utility::_takeweapon( var_af26ed837ee66f07 );
    }
    
    if ( self hasweapon( var_4e22443d07a9c648 ) )
    {
        inventory_utility::_takeweapon( var_4e22443d07a9c648 );
    }
    
    weaponobj = isheavy ? var_4e22443d07a9c648 : var_af26ed837ee66f07;
    duration = isheavy ? 3.33 : 1.833;
    val::set( "gas_grenade", "supers", 0 );
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( bundle.var_9408e40664fbbb65 ?? 1 )
    {
        self giveandfireoffhand( weaponobj );
    }
    
    childthread gas_monitorcoughweaponfired( weaponobj );
    childthread gas_monitorcoughweapontaken( weaponobj );
    childthread gas_monitorcoughduration( duration );
    utility::waittill_any( "gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration" );
    val::reset( "gas_grenade", "supers" );
    
    if ( self hasweapon( weaponobj ) )
    {
        inventory_utility::_takeweapon( weaponobj );
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace gas_grenade
// Params 1
// Checksum 0xe27b4e44, Offset: 0x386f
// Size: 0x48
function gas_removecough( fromdeath )
{
    self notify( #"gas_queue_cough" );
    self notify( #"gas_begin_coughing" );
    self.gascoughinprogress = undefined;
    
    if ( !fromdeath )
    {
        if ( isdefined( self.gastakenweaponobj ) )
        {
            gas_restoreheldoffhand();
        }
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xb8533aa, Offset: 0x38bf
// Size: 0xdc
function gas_clearcough( fromdeath )
{
    self notify( #"gas_queue_cough" );
    self notify( #"gas_begin_coughing" );
    self.gascoughinprogress = undefined;
    
    if ( !fromdeath )
    {
        var_6b728440205d689a = getdvarint( @"hash_827901421ad0679", 1 ) == 1;
        var_af26ed837ee66f07 = scripted_weapons::get_scripted_weapon_object( #"gas_cough_light" );
        var_4e22443d07a9c648 = scripted_weapons::get_scripted_weapon_object( #"gas_cough_heavy" );
        
        if ( var_6b728440205d689a )
        {
            if ( self hasweapon( var_af26ed837ee66f07 ) )
            {
                inventory_utility::_takeweapon( var_af26ed837ee66f07 );
            }
            
            if ( self hasweapon( var_4e22443d07a9c648 ) )
            {
                inventory_utility::_takeweapon( var_4e22443d07a9c648 );
            }
            
            if ( isdefined( self.gastakenweaponobj ) )
            {
                gas_restoreheldoffhand();
            }
            
            return;
        }
        
        self stopgestureviewmodel( "iw9_ges_gas_cough" );
        self stopgestureviewmodel( "iw9_ges_gas_cough_long" );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x5bf1a07, Offset: 0x39a3
// Size: 0x78
function gas_startcoughing( triggerowner )
{
    self endon( #"gas_exited" );
    self endon( #"death_or_disconnect" );
    var_d11a327929f8b79 = getdvarfloat( @"hash_2ef09b292af0ff6d", 1 );
    var_52d22ca9520a034b = getdvarfloat( @"hash_e0de3305bf9cea1b", 1.5 );
    
    while ( true )
    {
        childthread gas_applycough( triggerowner, 0 );
        wait randomfloatrange( var_d11a327929f8b79, var_52d22ca9520a034b );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x75a42536, Offset: 0x3a24
// Size: 0x5e
function gas_monitorcoughweaponfired( var_2d0bf388453117d1 )
{
    self endon( #"gas_coughWeaponTaken" );
    self endon( #"gas_coughDuration" );
    
    while ( true )
    {
        self waittill( #"offhand_fired", weaponobj );
        
        if ( issameweapon( weaponobj, var_2d0bf388453117d1 ) )
        {
            break;
        }
    }
    
    self notify( #"gas_coughWeaponFired" );
}

// Namespace gas_grenade
// Params 1
// Checksum 0x1687e632, Offset: 0x3a8a
// Size: 0x3e
function gas_monitorcoughweapontaken( var_2d0bf388453117d1 )
{
    self endon( #"gas_coughWeaponFired" );
    self endon( #"gas_coughDuration" );
    
    while ( self hasweapon( var_2d0bf388453117d1 ) )
    {
        waitframe();
    }
    
    self notify( #"gas_coughWeaponTaken" );
}

// Namespace gas_grenade
// Params 1
// Checksum 0x90c1cfaf, Offset: 0x3ad0
// Size: 0x33
function gas_monitorcoughduration( coughduration )
{
    self endon( #"gas_coughWeaponTaken" );
    self endon( #"gas_coughWeaponFired" );
    wait coughduration;
    self notify( #"gas_coughDuration" );
}

// Namespace gas_grenade
// Params 0
// Checksum 0x55f93ab7, Offset: 0x3b0b
// Size: 0x164
function gas_takeheldoffhand()
{
    if ( isdefined( self.gastakenweaponobj ) )
    {
        gas_restoreheldoffhand();
    }
    
    self endon( #"hash_24e08adb990efce0" );
    self.gastakenweaponobj = self getheldoffhand();
    equipmentref = equipment_mp::getequipmentreffromweapon( self.gastakenweaponobj );
    
    if ( isdefined( equipmentref ) && equipment_mp::hasequipment( equipmentref ) )
    {
        self.gastakenweaponammo = equipment_mp::getequipmentammo( equipmentref );
        inventory_utility::_takeweapon( self.gastakenweaponobj );
        wait 0.05;
        thread gas_restoreheldoffhand();
    }
    
    superref = supers_mp::getsuperrefforsuperoffhand( self.gastakenweaponobj );
    
    if ( isdefined( superref ) )
    {
        currentsuperref = supers_mp::getcurrentsuperref();
        
        if ( currentsuperref == superref )
        {
            self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
            inventory_utility::_takeweapon( self.gastakenweaponobj );
            wait 0.05;
            thread gas_restoreheldoffhand();
        }
    }
    
    isgesture = weapon::isgesture( self.gastakenweaponobj );
    
    if ( isgesture )
    {
        inventory_utility::_takeweapon( self.gastakenweaponobj );
        wait 0.05;
        thread gas_restoreheldoffhand();
    }
    
    self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
    inventory_utility::_takeweapon( self.gastakenweaponobj );
    wait 0.05;
    thread gas_restoreheldoffhand();
}

// Namespace gas_grenade
// Params 0
// Checksum 0xc2686c0e, Offset: 0x3c77
// Size: 0x230
function gas_restoreheldoffhand()
{
    self notify( #"hash_24e08adb990efce0" );
    superref = supers_mp::getsuperrefforsuperoffhand( self.gastakenweaponobj );
    
    if ( isdefined( superref ) )
    {
        currentsuperref = supers_mp::getcurrentsuperref();
        
        if ( currentsuperref == superref )
        {
            inventory_utility::_giveweapon( self.gastakenweaponobj );
            self assignweaponoffhandspecial( self.gastakenweaponobj );
            self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
            self.gastakenweaponobj = undefined;
            self.gastakenweaponammo = undefined;
        }
        
        return;
    }
    
    equipmentref = equipment_mp::getequipmentreffromweapon( self.gastakenweaponobj );
    
    if ( isdefined( equipmentref ) && equipment_mp::hasequipment( equipmentref ) )
    {
        if ( equipment_mp::hasequipment( equipmentref ) )
        {
            inventory_utility::_giveweapon( self.gastakenweaponobj );
            slot = equipment_mp::findequipmentslot( equipmentref );
            assert( slot == "<dev string:xda>" || slot == "<dev string:xe2>", "<dev string:xec>" + equipmentref + "<dev string:x111>" );
            
            if ( slot == "primary" )
            {
                self assignweaponoffhandprimary( self.gastakenweaponobj );
            }
            else if ( slot == "secondary" )
            {
                self assignweaponoffhandsecondary( self.gastakenweaponobj );
            }
            
            equipment_mp::setequipmentammo( equipmentref, self.gastakenweaponammo );
            self.gastakenweaponobj = undefined;
            self.gastakenweaponammo = undefined;
        }
        
        return;
    }
    
    isgesture = weapon::isgesture( self.gastakenweaponobj );
    
    if ( isgesture )
    {
        if ( self.gestureweapon == self.gastakenweaponobj.basename )
        {
            inventory_utility::_giveweapon( self.gastakenweaponobj );
            self.gastakenweaponobj = undefined;
        }
        
        return;
    }
    
    var_b9d1c21ecd1b752 = supers_mp::function_328cd660d9471655( self.gastakenweaponobj );
    
    if ( var_b9d1c21ecd1b752 )
    {
        self.gastakenweaponobj = undefined;
        return;
    }
    
    inventory_utility::_giveweapon( self.gastakenweaponobj );
    self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
    self.gastakenweaponobj = undefined;
    self.gastakenweaponammo = undefined;
}

// Namespace gas_grenade
// Params 0
// Checksum 0xaa08de9f, Offset: 0x3eaf
// Size: 0x385
function gas_applyspeedredux()
{
    self endon( #"death_or_disconnect" );
    self notify( #"gas_modify_speed" );
    self endon( #"gas_modify_speed" );
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( isdefined( self.gasspeedmod ) )
    {
        if ( self.gasspeedmod < ( bundle.var_b7ea3e7f8f896913 ?? -0.15 ) )
        {
            if ( isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
            {
                if ( isdefined( self.perks[ "specialty_veteran" ] ) )
                {
                    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
                }
                else
                {
                    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_tac_resist" );
                }
                
                self.gasspeedmod = bundle.var_b7ea3e7f8f896913 ?? -0.15;
                common::function_a0f5c85d465c5f0a( "gasSpeedMod", self.gasspeedmod );
                common::function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
                weapons::updatemovespeedscale();
                return;
            }
            
            if ( isdefined( self.gastriggerstouching ) )
            {
                foreach ( trigger in self.gastriggerstouching )
                {
                    if ( isdefined( trigger ) && trigger.owner == self )
                    {
                        /#
                            if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                            {
                                self.gasspeedmod = 0;
                                common::function_a0f5c85d465c5f0a( "<dev string:x12c>", self.gasspeedmod );
                                common::function_11a0a06c67c80f4d( "<dev string:x12c>", 2 );
                                break;
                            }
                        #/
                        
                        self.gasspeedmod = bundle.var_b7ea3e7f8f896913 ?? -0.15;
                        common::function_a0f5c85d465c5f0a( "gasSpeedMod", self.gasspeedmod );
                        common::function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
                        weapons::updatemovespeedscale();
                        return;
                    }
                }
            }
        }
    }
    else
    {
        self.gasspeedmod = 0;
        
        if ( !common::function_8ff835bf23198a0( "gasSpeedMod" ) )
        {
            common::function_ac4bf3256b2545e3( "gasSpeedMod", self.gasspeedmod );
            common::function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
        }
    }
    
    var_eff79089a25249fe = bundle.var_2636db1918a68a6c ?? -0.35;
    
    if ( isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        var_eff79089a25249fe = bundle.var_b7ea3e7f8f896913 ?? -0.15;
    }
    else if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( isdefined( trigger ) && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                var_eff79089a25249fe = bundle.var_b7ea3e7f8f896913 ?? -0.15;
            }
        }
    }
    
    gas_modifyspeed( var_eff79089a25249fe );
    self.gasspeedmod = var_eff79089a25249fe;
    weapons::updatemovespeedscale();
}

// Namespace gas_grenade
// Params 0
// Checksum 0xa907f086, Offset: 0x423c
// Size: 0x68
function gas_removespeedredux()
{
    self endon( #"death_or_disconnect" );
    self notify( #"gas_modify_speed" );
    self endon( #"gas_modify_speed" );
    
    if ( !isdefined( self.gasspeedmod ) )
    {
        return;
    }
    
    gas_modifyspeed( 0 );
    self.gasspeedmod = undefined;
    
    if ( common::function_8ff835bf23198a0( "gasSpeedMod" ) )
    {
        common::function_d85a92c557ea5a52( "gasSpeedMod" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace gas_grenade
// Params 1
// Checksum 0x12a07fba, Offset: 0x42ac
// Size: 0x89
function gas_modifyspeed( var_eff79089a25249fe )
{
    timeelapsed = 0;
    
    while ( timeelapsed <= 0.65 )
    {
        timeelapsed += 0.05;
        self.gasspeedmod = math::lerp( self.gasspeedmod, var_eff79089a25249fe, min( 1, timeelapsed / 0.65 ) );
        common::function_a0f5c85d465c5f0a( "gasSpeedMod", self.gasspeedmod );
        common::function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
        weapons::updatemovespeedscale();
        wait 0.05;
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x305e8f62, Offset: 0x433d
// Size: 0x50
function gas_clearspeedredux( fromdeath )
{
    self notify( #"gas_modify_speed" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.gasspeedmod = undefined;
    
    if ( common::function_8ff835bf23198a0( "gasSpeedMod" ) )
    {
        common::function_d85a92c557ea5a52( "gasSpeedMod" );
    }
    
    if ( !fromdeath )
    {
        weapons::updatemovespeedscale();
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x8e12b9c6, Offset: 0x4395
// Size: 0x394
function gas_applyblur( overwrite_bundle )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_1f7a3b28c814e517" );
    self endon( #"hash_1f7a3b28c814e517" );
    
    if ( isdefined( self.perks[ "specialty_hallucination_immunity" ] ) )
    {
        return;
    }
    
    bundle = overwrite_bundle ?? level.equipment.table[ "equip_gas_grenade" ].bundle;
    shockassetname = bundle.var_b45d254cca07a4d3 ?? %"gas_grenade_heavy_mp";
    
    if ( bundle.gasgrenadepbgpostfxbundle )
    {
        [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:bundle.gasgrenadepbgpostfxbundle }, 1, 1 );
    }
    
    if ( isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        shockassetname = bundle.gas_grenade_light_shock ?? %"gas_grenade_light_mp";
    }
    else if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( isdefined( trigger ) && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                shockassetname = bundle.gas_grenade_light_shock ?? %"gas_grenade_light_mp";
            }
        }
    }
    
    shouldapplyblur = getdvarint( @"hash_e72c615f3e82fac8", 1 ) == 1;
    
    if ( trigger.weapon == "bunker_buster_proj_jup_mp" )
    {
        shockassetname = %"gas_kls_bunker_buster_mp";
    }
    
    if ( shouldapplyblur )
    {
        if ( bundle.var_1aadfb29005ffaa4 )
        {
            self.var_955518e3fd692fbd = 1;
            
            if ( !isdefined( self.var_221bcd7e6f8830f8 ) )
            {
                self.var_221bcd7e6f8830f8 = {};
            }
            
            self.var_221bcd7e6f8830f8.weapon = trigger.weapon_object;
            
            foreach ( trigger in self.gastriggerstouching )
            {
                self.var_221bcd7e6f8830f8.attackers[ trigger.owner.entnum ?? utility::get_entity_number( trigger.owner ) ] = trigger.owner;
            }
            
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_fafb93cf2eff0b4b" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]( level.equipment.table[ "equip_gas_grenade" ].bundle );
            }
        }
        
        function_dcb13d23fa969d90();
        
        while ( true )
        {
            shellshock_utility_cpmp::_shellshock( shockassetname, #"gas", 0.75, 0 );
            wait 0.3;
        }
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x97a797a9, Offset: 0x4731
// Size: 0x48
function function_f45f8371a30fea6b( attacker )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_1f7a3b28c814e517" );
    self endon( #"hash_1f7a3b28c814e517" );
    
    while ( self.var_955518e3fd692fbd )
    {
        gas_trap::function_ecdaac79558cbea0( attacker );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x2992ab57, Offset: 0x4781
// Size: 0x143
function gas_removeblur( var_ac255db0656a7936 )
{
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( bundle.gasgrenadepbgpostfxbundle )
    {
        [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:bundle.gasgrenadepbgpostfxbundle } );
    }
    
    if ( bundle.var_1aadfb29005ffaa4 )
    {
        if ( !isdefined( self.perks[ "specialty_hallucination_immunity" ] ) )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_f00f78b8f103a397" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]( level.equipment.table[ "equip_gas_grenade" ].bundle );
            }
            
            if ( !self.var_193dad851d6389a4 )
            {
                function_dcb13d23fa969d90();
            }
        }
        
        self.var_955518e3fd692fbd = undefined;
        
        if ( isdefined( self.var_221bcd7e6f8830f8 ) )
        {
            self.var_221bcd7e6f8830f8.attackers[ var_ac255db0656a7936 ] = undefined;
        }
    }
    
    self notify( #"hash_1f7a3b28c814e517" );
}

// Namespace gas_grenade
// Params 1
// Checksum 0x16b62aa3, Offset: 0x48cc
// Size: 0x130
function gas_clearblur( fromdeath )
{
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( bundle.gasgrenadepbgpostfxbundle )
    {
        [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:bundle.gasgrenadepbgpostfxbundle } );
    }
    
    if ( bundle.var_1aadfb29005ffaa4 )
    {
        if ( !isdefined( self.perks[ "specialty_hallucination_immunity" ] ) )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_f00f78b8f103a397" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]( level.equipment.table[ "equip_gas_grenade" ].bundle );
            }
        }
        
        self.var_955518e3fd692fbd = undefined;
        
        if ( isdefined( self.var_221bcd7e6f8830f8 ) )
        {
            self.var_221bcd7e6f8830f8 = undefined;
        }
    }
    
    self notify( #"hash_1f7a3b28c814e517" );
    
    if ( !fromdeath )
    {
        shellshock_utility_cpmp::_stopshellshock();
    }
}

// Namespace gas_grenade
// Params 0
// Checksum 0x6afa1fde, Offset: 0x4a04
// Size: 0x37, Type: bool
function gas_shouldtakeheldoffhand()
{
    switch ( self getheldoffhand().basename )
    {
        case #"hash_3102ab88c5c102fc":
            return false;
        default:
            return true;
    }
    
    return false;
}

// Namespace gas_grenade
// Params 0
// Checksum 0x3608aa1b, Offset: 0x4a44
// Size: 0x5a, Type: bool
function gas_coughisblocked()
{
    if ( !val::get( "cough_gesture" ) )
    {
        return true;
    }
    
    if ( !val::get( "offhand_weapons" ) )
    {
        return true;
    }
    
    if ( !isnullweapon( self getheldoffhand() ) && !gas_shouldtakeheldoffhand() )
    {
        return true;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return true;
    }
    
    if ( self isreloading() )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_grenade
// Params 0
// Checksum 0x532be17a, Offset: 0x4aa7
// Size: 0x25, Type: bool
function gas_isintrigger()
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        return false;
    }
    
    if ( self.gastriggerstouching.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_grenade
// Params 0
// Checksum 0x67782dfb, Offset: 0x4ad5
// Size: 0x5f
function gas_updateplayereffects()
{
    if ( killstreak::isjuggernaut() && !game_utility_mp::isjuggermoshgamemode() )
    {
        gas_clear();
        return;
    }
    
    if ( gas_isintrigger() )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
        
        if ( bundle.var_9a68372899d8bbbd ?? 1 )
        {
            thread gas_applyspeedredux();
        }
        
        thread gas_applyblur();
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xc53e4aee, Offset: 0x4b3c
// Size: 0x11
function gas_getblurinterruptdelayms( duration )
{
    return 300;
}

// Namespace gas_grenade
// Params 0
// Checksum 0x8c51600f, Offset: 0x4b56
// Size: 0x73, Type: bool
function function_7a528b347ace56de()
{
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    if ( !bundle.var_3d5968300b24ade3 )
    {
        return false;
    }
    
    if ( function_4042d2fbe6237835( #"hash_d89414a5aef24585" ) )
    {
        return false;
    }
    
    if ( !getdvarint( @"hash_f3446fadfb80717a", 0 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_grenade
// Params 2
// Checksum 0x2fb5cf6c, Offset: 0x4bd2
// Size: 0x9c, Type: bool
function function_58dce3a196ac4d8b( bundledata, aicategory )
{
    foreach ( var_4c856b353a96c05c in bundledata.var_1da235cea8c28166 )
    {
        if ( var_4c856b353a96c05c.category == aicategory )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gas_grenade
// Params 1
// Checksum 0x41f5a284, Offset: 0x4c77
// Size: 0xd0, Type: bool
function function_aad3f9ba4ac6be30( var_39bc414888da0b04 )
{
    assert( isagent( self ) );
    ray_to = self gettagorigin( "j_spine4", 1 ) ?? self.origin;
    ray_from = ( var_39bc414888da0b04.var_ba0e4b835e09578 ?? var_39bc414888da0b04.origin ) + ( 0, 0, 30 );
    contents = trace::create_solid_ai_contents( 1 );
    
    /#
        if ( getdvarint( @"hash_bb1e132abbbedb60", 0 ) )
        {
            sphere( ray_from, 6, ( 0, 1, 0 ), 0, int( var_39bc414888da0b04.duration / level.framedurationseconds ) );
        }
    #/
    
    return trace::ray_trace_passed( ray_from, ray_to, undefined, contents );
}

// Namespace gas_grenade
// Params 1
// Checksum 0xfdc25f79, Offset: 0x4d50
// Size: 0x1bc
function function_1505269c0f0de5aa( trigger )
{
    victim = self;
    attacker = trigger.owner;
    victim endon( #"death_or_disconnect" );
    victim endon( #"hash_da63487f41fc6510" );
    victim endon( #"gas_exit" );
    victim notify( #"hash_3a7c894c0e673662" );
    victim endon( #"hash_3a7c894c0e673662" );
    victim thread function_5dd789acb83d824e( trigger );
    var_989a843c172bfd6d = isdefined( victim.perks[ "specialty_gas_grenade_resist" ] );
    hasoutlander = isdefined( victim.perks[ "specialty_outlander" ] );
    var_a8698ce9146799c0 = victim == attacker;
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    damagetick = bundle.gas_grenade_damage_heavy ?? 10;
    
    if ( var_989a843c172bfd6d || hasoutlander || var_a8698ce9146799c0 )
    {
        damagetick = bundle.gas_grenade_damage_light ?? 8;
    }
    
    damagetick = int( max( 1, damagetick ) );
    
    while ( isdefined( trigger ) )
    {
        if ( victim getinairpocket() || gasmask::function_a062bf98847b605a( victim ) )
        {
            wait 1;
            continue;
        }
        
        victim dodamage( damagetick, trigger.origin, trigger.owner, trigger, "MOD_TRIGGER_HURT", "danger_circle_br", "none" );
        victim armor::damagearmor( damagetick );
        
        if ( var_989a843c172bfd6d && isdefined( self.perks[ "specialty_veteran" ] ) )
        {
            namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
        }
        
        wait 1;
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0x595e5898, Offset: 0x4f14
// Size: 0x72
function function_5dd789acb83d824e( trigger )
{
    victim = self;
    level endon( #"game_ended" );
    victim endon( #"death_or_disconnect" );
    victim notify( #"hash_66e176a4c1859655" );
    victim endon( #"hash_66e176a4c1859655" );
    victim utility::waittill_notify_or_timeout( "gas_exited", trigger.duration );
    victim notify( #"hash_da63487f41fc6510" );
}

// Namespace gas_grenade
// Params 1, eflags: 0x4
// Checksum 0xe52d393f, Offset: 0x4f8e
// Size: 0x184
function private gas_grenade_on_ai_killed( params )
{
    var_f20c72ca635e6a48 = 0;
    
    if ( isplayer( params.eattacker.var_fb2e0070ae6f04e4 ) && val::get( "allow_give_point" ) && isdefined( self.kiastring ) )
    {
        kia_string = hashcat( self.kiastring, "_gas_grenade" );
        player = params.eattacker.var_fb2e0070ae6f04e4;
        victim = self;
        player thread utility::callsharedfunc( #"player", #"doScoreEvent", kia_string, undefined, undefined, undefined, victim );
        var_f20c72ca635e6a48 = 1;
        gas_grenade_time = params.eattacker.gas_grenade_time;
    }
    
    if ( isplayer( self.var_fb2e0070ae6f04e4 ) || var_f20c72ca635e6a48 )
    {
        if ( !isdefined( gas_grenade_time ) )
        {
            gas_grenade_time = self.gas_grenade_time;
        }
        
        if ( !isdefined( player ) )
        {
            player = self.var_fb2e0070ae6f04e4;
        }
        
        if ( isplayer( player ) && gas_grenade_time )
        {
            if ( !isdefined( player.var_7a14a582c0d46f63[ gas_grenade_time ] ) )
            {
                player.var_7a14a582c0d46f63[ gas_grenade_time ] = 0;
            }
            
            player.var_7a14a582c0d46f63[ gas_grenade_time ]++;
            
            if ( player.var_7a14a582c0d46f63[ gas_grenade_time ] == 10 )
            {
                player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_chokedup" );
            }
            
            player thread function_51a6f589b5eb597d( gas_grenade_time, 30 );
        }
    }
}

// Namespace gas_grenade
// Params 2, eflags: 0xc
// Checksum 0xa80b0603, Offset: 0x511a
// Size: 0x66
function private function_51a6f589b5eb597d( index, duration )
{
    self notify( #"hash_9c6bd7836acc0785" );
    self endon( #"hash_9c6bd7836acc0785" );
    self endon( #"disconnect" );
    self notify( "gas_kills_tracking" + index );
    self endon( "gas_kills_tracking" + index );
    wait duration;
    
    if ( isplayer( self ) )
    {
        self.var_7a14a582c0d46f63[ index ] = undefined;
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xa34180d8, Offset: 0x5188
// Size: 0xf4
function function_30a5ccb26ebe5c64( trigger )
{
    if ( self function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
    {
        self setclientomnvar( "ui_br_player_is_in_gas_from_grenade", self.gastriggerstouching && self.gastriggerstouching.size > 0 );
    }
    
    if ( !trigger.scoreeventfired[ self.entnum ?? utility::get_entity_number( self ) ] && self.team != trigger.owner.team )
    {
        trigger.scoreeventfired[ self.entnum ] = 1;
        trigger.owner namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "gasGrenadeHit", 0 );
    }
    
    entnum = trigger getentitynumber();
    
    if ( trigger.weaponobj )
    {
        telemetry_mp::function_594cbdc6a4d8098a( self, trigger.owner, trigger.weaponobj, entnum );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xc68c3770, Offset: 0x5284
// Size: 0x72
function function_c05e808ce6343d0e( trigger )
{
    if ( self function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
    {
        self setclientomnvar( "ui_br_player_is_in_gas_from_grenade", self.gastriggerstouching && self.gastriggerstouching.size > 0 );
    }
    
    entnum = trigger getentitynumber();
    
    if ( trigger.weaponobj )
    {
        telemetry_mp::function_edb43d25c7bd56c6( self, trigger.weaponobj, entnum );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xdc0a7e4c, Offset: 0x52fe
// Size: 0x7f
function function_521f3138a5a67658( trigger )
{
    if ( trigger.owner && trigger.eventid )
    {
        thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:trigger.origin, #attacker:trigger.owner, #eventid:trigger.eventid } );
    }
}

// Namespace gas_grenade
// Params 1
// Checksum 0xbdd201c0, Offset: 0x5385
// Size: 0x1e
function function_2eeef3a721b936d7( player )
{
    player thread points::doscoreevent( #"gas_finished" );
}

// Namespace gas_grenade
// Params 1
// Checksum 0x1967998c, Offset: 0x53ab
// Size: 0x8a
function function_ca1a5849471f6394( player )
{
    if ( player == self.lastkilledby )
    {
        player thread points::doscoreevent( #"gas_finished" );
        
        if ( !isdefined( player.var_5d7ed9f2a7fdd8cb ) )
        {
            player.var_5d7ed9f2a7fdd8cb = self;
        }
        
        if ( player.var_5d7ed9f2a7fdd8cb != self )
        {
            player thread points::doscoreevent( #"gas_trap_double" );
            player.var_5d7ed9f2a7fdd8cb = undefined;
        }
        
        return;
    }
    
    player thread points::doscoreevent( #"gas_assist" );
}

